/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_detroit_events.gsc
***************************************************/

#include common_scripts\utility;
#include maps\mp\_dynamic_events;
#include maps\mp\_utility;

trams() {
  level.trams = getEntArray("ambient_tram", "targetname");
  array_thread(level.trams, ::tram_init);

  tram_anims = ["mp_detroit_train_01", "mp_detroit_train_02"];
  foreach(tramAnim in tram_anims) {
    PrecacheMpAnim(tramAnim);
  }

  foreach(tram in level.trams) {
    tram playLoopSound("mp_detroit_tram_close");
  }

  while(1) {
    foreach(tram in level.trams) {
      if(!tram.active) {
        randAnim = Random(tram_anims);
        tram thread tram_animate(randAnim);
        break;
      }
    }

    wait RandomFloatRange(10.0, 15.0);
  }
}

object_init_reset() {
  self.reset_origin = self.origin;
  self.reset_angles = self.angles;
}

object_reset() {
  self DontInterpolate();
  self.origin = self.reset_origin;
  self.angles = self.reset_angles;
}

tram_init() {
  if(isDefined(self.target)) {
    clips = getEntArray(self.target, "targetname");
    foreach(clip in clips) {
      clip LinkTo(self);
    }
  }

  self.active = false;
  self object_init_reset();
}

tram_reset() {
  self object_reset();
}

tram_spline_debug() {
  SetDevDvar("detroit_tram_spline_debug", 0);

  while(1) {
    while(self.active || !GetDvarInt("detroit_tram_spline_debug", 0)) {
      waitframe();
    }

    self tram_reset();
    self.active = true;

    spline_vehicle = tram_spline_vehicle_spawn();

    spline_vehicle waittill("playSpaceStart");

    spline_vehicle thread tram_spline_stay_in_playspace();

    while(GetDvarInt("detroit_tram_spline_debug", 0)) {
      waitframe();
    }

    self thread tram_spline_leave(spline_vehicle, 40);
  }
}

tram_spline_vehicle_spawn() {
  spline_vehicle = SpawnVehicle("tag_origin", "detroit_tram", "detroit_tram_mp", self.origin, self.angles);
  spline_vehicle.owner = self.owner;

  startNode = getVehicleNode(self.target, "targetname");

  playSpaceStartNode = undefined;
  playSpaceEndNode = undefined;
  trackEndNode = undefined;

  searchNode = startNode;
  while(isDefined(searchNode.target)) {
    searchNode = GetVehicleNode(searchNode.target, "targetname");
    if(string_starts_with(searchNode.targetname, "play_space_edge")) {
      if(!isDefined(playSpaceStartNode)) {
        playSpaceStartNode = searchNode;
      } else {
        playSpaceEndNode = searchNode;
      }
    }
    if(string_starts_with(searchNode.targetname, "track_end")) {
      trackEndNode = searchNode;
    }
  }

  self thread tram_node_notify(spline_vehicle, playSpaceStartNode, "playSpaceStart");
  self thread tram_node_notify(spline_vehicle, playSpaceEndNode, "playSpaceEnd");
  self thread tram_node_notify(spline_vehicle, trackEndNode, "trackEnd");

  spline_vehicle attachPath(startNode);
  spline_vehicle StartPath(startNode);

  spline_vehicle.spline_speed = 25;
  spline_vehicle.spline_accel = 15;
  spline_vehicle.spline_decel = 20;
  spline_vehicle.spline_fast_decel = spline_vehicle.spline_decel * 2;

  self LinkTo(spline_vehicle);

  return spline_vehicle;
}

tram_spline_move(time_limit) {
  self.active = true;
  spline_vehicle = self tram_spline_vehicle_spawn();
  self.endTime = GetTime() + (time_limit * 1000);
  self.owner SetClientOmnvar("ui_warbird_countdown", self.endTime);

  waitframe();

  enter_exit_speed = 40;
  spline_vehicle tram_set_forward();
  spline_vehicle Vehicle_SetSpeedImmediate(enter_exit_speed, spline_vehicle.spline_accel, spline_vehicle.spline_decel);

  spline_vehicle tram_stop_player_control();

  result = self waittill_any_return("playSpaceStart", "player_exit");

  if(result != "player_exit") {
    spline_vehicle tram_start_player_control();
    spline_vehicle thread tram_spline_stay_in_playspace(::tram_start_player_control, ::tram_stop_player_control);

    self waittill_notify_or_timeout("player_exit", (self.endTime - GetTime()) / 1000);
  }

  spline_vehicle tram_stop_player_control();
  self thread tram_spline_leave(spline_vehicle, enter_exit_speed);
}

tram_spline_leave(spline_vehicle, enter_exit_speed) {
  spline_vehicle notify("stop_stay_in_playspace");
  spline_vehicle tram_set_forward();
  spline_vehicle Vehicle_SetSpeed(enter_exit_speed, spline_vehicle.spline_accel, spline_vehicle.spline_decel);

  spline_vehicle waittill("trackEnd");

  self Unlink();
  spline_vehicle Delete();

  decrementFauxVehicleCount();

  self.active = false;
}

tram_spline_stay_in_playspace(startContrlsFunc, stopControlsFunc) {
  self endon("stop_stay_in_playspace");

  while(1) {
    result = self waittill_any_return("playSpaceStart", "playSpaceEnd");

    if(isDefined(stopControlsFunc)) {
      self[[stopControlsFunc]]();
    }

    self Vehicle_SetSpeed(0, self.spline_accel, self.spline_fast_decel);

    while(self.veh_speed != 0) {
      waitframe();
    }

    if(result == "playSpaceStart") {
      self tram_set_forward();
    } else {
      self tram_set_reverse();
    }

    self Vehicle_SetSpeed(self.spline_speed, self.spline_accel, self.spline_decel);

    self waittill(result);

    if(isDefined(startContrlsFunc)) {
      self[[startContrlsFunc]]();
    }
  }
}

tram_node_notify(spline_vehicle, node, msg) {
  spline_vehicle endon("death");

  while(1) {
    node waittill("trigger", vehicle);
    if(vehicle == spline_vehicle) {
      spline_vehicle notify(msg);
      self notify(msg);
    }
  }
}

tram_set_forward() {
  self.current_dir = "forward";
  self.veh_transmission = self.current_dir;
  self.veh_pathdir = self.current_dir;
}

tram_set_reverse() {
  self.current_dir = "reverse";
  self.veh_transmission = self.current_dir;
  self.veh_pathdir = self.current_dir;
}

tram_start_player_control() {
  self thread tram_update_player_spline_control();
}

tram_stop_player_control() {
  self notify("stop_player_control");
}

tram_update_player_spline_control() {
  self endon("death");
  self endon("player_exit");
  self endon("stop_player_control");

  player = self.owner;
  player endon("disconnect");

  self SetAcceleration(self.spline_accel);
  self SetDeceleration(self.spline_decel);

  while(1) {
    [fwd, right] = player GetNormalizedMovement();

    stick_dir = player GetNormalizedMovement();
    stick_size = Length(stick_dir);

    if(stick_size < 0.1) {
      self Vehicle_SetSpeed(0);
    } else {
      player_angles = player GetPlayerAngles();

      stick_dir = (stick_dir[0], stick_dir[1] * -1, 0);
      stick_angles = VectorToAngles(stick_dir);
      stick_angles = flat_angle(CombineAngles(stick_angles, player_angles));

      stick_dir = anglesToForward(stick_angles);
      vehicle_dir = anglesToForward(self.angles);

      dot = VectorDot(stick_dir, vehicle_dir);
      if(dot > 0) {
        if(self.current_dir != "forward" && self.veh_speed != 0) {
          self Vehicle_SetSpeed(0, self.spline_accel, self.spline_fast_decel);
        } else {
          if(self.current_dir != "forward") {
            self tram_set_forward();
          } else {
            self Vehicle_SetSpeed(self.spline_speed, self.spline_accel, self.spline_decel);
          }
        }
      } else {
        if(self.current_dir != "reverse" && self.veh_speed != 0) {
          self Vehicle_SetSpeed(0, self.spline_accel, self.spline_fast_decel);
        } else {
          if(self.current_dir != "reverse") {
            tram_set_reverse();
          } else {
            self Vehicle_SetSpeed(self.spline_speed, self.spline_accel, self.spline_decel);
          }
        }
      }

    }
    waitframe();
  }
}

tram_animate(anim_name) {
  tram_node = GetStruct("tram_node", "targetname");
  if(!isDefined(tram_node)) {
    return;
  }

  self.active = true;

  self ScriptModelPlayAnimDeltaMotionFromPos(anim_name, tram_node.origin, tram_node.angles, "tram_anim");

  self waittillmatch("tram_anim", "end");

  self.active = false;
}

tram_move(tram_speed, tram_speed_fast) {
  self endon("dropped");

  pi = 3.14159;

  if(!isDefined(tram_speed_fast)) {
    tram_speed_fast = tram_speed;
  }

  self.active = true;
  current = self;

  while(isDefined(current.target)) {
    next = getstruct(current.target, "targetname");

    speed = tram_speed;
    rotate_yaw = undefined;

    if(isDefined(next.script_noteworthy)) {
      switch (next.script_noteworthy) {
        case "fast":
          speed = tram_speed_fast;
          break;
        case "clockwise_fast":
          speed = tram_speed_fast;
          rotate_yaw = -90;
          break;
        case "clockwise":
          rotate_yaw = -90;
          break;
        case "counterclockwise_fast":
          speed = tram_speed_fast;
          rotate_yaw = 90;
          break;
        case "counterclockwise":
          rotate_yaw = 90;
          break;
        default:
          break;
      }

    }

    if(isDefined(rotate_yaw)) {
      rotation_ent = spawn("script_origin", next.origin);

      self LinkToSynchronizedParent(rotation_ent);

      radius = distance(rotation_ent.origin, self.origin);
      cir = radius * 2 * pi;
      dist = cir * (abs(rotate_yaw) / 360);
      time = dist / speed;

      rotation_ent RotateYaw(rotate_yaw, time);
      rotation_ent waittill("rotatedone");
      self Unlink();
      rotation_ent Delete();
    } else {
      dist = Distance(self.origin, next.origin);
      time = dist / speed;

      self MoveTo(next.origin, time);
      self waittill("movedone");
    }

    current = next;
  }
  self.active = false;
}