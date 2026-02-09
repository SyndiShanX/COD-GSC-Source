/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_levity.gsc
***************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_audio;
#include maps\mp\_dynamic_events;

main() {
  maps\mp\mp_levity_precache::main();
  maps\createart\mp_levity_art::main();
  maps\mp\mp_levity_fx::main();

  maps\mp\_load::main();
  thread set_lighting_values();

  maps\mp\mp_levity_lighting::main();
  thread maps\mp\mp_levity_aud::main();

  level.aerial_pathnode_offset = 600;
  level.aerial_pathnodes_force_connect[0] = spawnStruct();
  level.aerial_pathnodes_force_connect[0].origin = (-977, -1811, 2054);
  level.aerial_pathnodes_force_connect[0].radius = 275;

  maps\mp\_compass::setupMiniMap("compass_map_mp_levity");

  setDvar("r_lightGridEnableTweaks", 1);
  setDvar("r_lightGridIntensity", 1.33);

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  array_thread(getEntArray("com_radar_dish", "targetname"), ::radar_dish_rotate);

  level thread hanger_event();
  level thread init_fans();
  level thread init_antenna();

  if(level.nextgen) {
    level thread init_assembly_line();

    setDvar("sm_polygonOffsetPreset", 2);
  }
}

init_assembly_line() {
  anims = ["mp_lev_drone_assembly_line_01", "mp_lev_drone_assembly_line_02", "mp_lev_drone_assembly_line_03", "mp_lev_drone_assembly_line_04", "mp_lev_drone_assembly_line_05", "mp_lev_drone_assembly_line_06", "mp_lev_drone_assembly_line_07"];

  foreach(a in anims) {
    PrecacheMpAnim(a);
  }

  scripted_node = GetStruct("robot_arm_scripted_node", "targetname");

  drones = getEntArray("assembly_line_drone", "targetname");
  foreach(i, drone in drones) {
    drone thread run_assembly_line(scripted_node, anims[i]);
  }
}

run_assembly_line(scripted_node, drone_anim) {
  self endon("death");

  notrack_notify = "droneNT";

  self ScriptModelPlayAnimDeltaMotionFromPos(drone_anim, scripted_node.origin, scripted_node.angles, notrack_notify);
  while(1) {
    self waittill(notrack_notify, note);

    snd_origin = self GetTagOrigin("j_drone");
    switch (note) {
      case "drone_sound_start":
        playSoundAtPos(snd_origin, "drone_gear_start");
        break;
      case "drone_sound_stop":
        playSoundAtPos(snd_origin, "drone_gear_stop");
        break;
      default:
        break;
    }
  }
}

init_fans() {
  spin_anim = "mp_lev_ind_thermanl_cell_fan_spin";
  PrecacheMpAnim(spin_anim);

  fans = getEntArray("levity_animated_fan", "targetname");
  array_thread(fans, ::run_fan, spin_anim);
}

run_fan(spin_anim) {
  self ScriptModelPlayAnimDeltaMotion(spin_anim);
}

init_antenna() {
  antenna = getEntArray("levity_antenna", "targetname");
  array_thread(antenna, ::radar_dish_rotate, 20);
}

radar_dish_rotate(speed) {
  time = 40000;

  if(!isDefined(speed)) {
    speed = 70;
  }

  if(isDefined(self.script_noteworthy) && (self.script_noteworthy == "lockedspeed")) {
    wait 0;
  } else {
    wait randomfloatrange(0, 1);
  }

  while(true) {
    self rotatevelocity((0, speed, 0), time);
    wait time;
  }
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "1");
    }
  }
}

hanger_event() {
  level.event_ents = getEntArray("hanger_event", "targetname");

  array_thread(level.event_ents, ::hanger_floor_init);
  array_thread(level.event_ents, ::hanger_ent_init);
  array_thread(level.event_ents, ::hanger_event_idle_anims);
}

event_start() {
  array_thread(level.event_ents, ::hanger_floor_run);
  thread maps\mp\mp_levity_aud::event_aud();
}

event_reset() {
  array_thread(level.event_ents, ::hanger_ent_reset);
  array_thread(level.event_ents, ::hanger_event_idle_anims);

  hanger_event_connect_nodes_drone();
  hanger_event_connect_nodes_floor();
}

hanger_ent_init() {
  self.start_origin = self.origin;
  self.start_angles = self.angles;
}

hanger_ent_reset() {
  if(isDefined(self.event_animated) && self.event_animated) {
    self ScriptModelClearAnim();
    if(isDefined(self.collision_prop)) {
      self.collision_prop ScriptModelClearAnim();
    }
  }
  self.origin = self.start_origin;
  self.angles = self.start_angles;
}

hanger_floor_init() {
  door_offset = (60, 0, 0);

  switch (self.script_noteworthy) {
    case "hanger_door_left":
      self.origin -= door_offset;
      self DisconnectPaths();
      break;
    case "hanger_door_right":
      self.origin += door_offset;
      self DisconnectPaths();
      break;

    case "drone":
      if(isDefined(self.target)) {
        clip = GetEnt(self.target, "targetname");
        clip.carepackageTouchValid = true;
        clip LinkTo(self);
      }
      break;
    default:
      break;
  }
}

drone_fx() {
  waittillframeend;
  fx = SpawnLinkedFx(getfx("mp_levity_aircraft_light"), self, "tag_fx_camera");
  TriggerFX(fx);
}

hanger_event_idle_anims() {
  switch (self.script_noteworthy) {
    case "drone":
      self.event_animated = true;
      anims = [];

      anims["drone"] = "mp_lev_drone_deploy_idle";

      ref_node = getstruct("ref_anim_node", "targetname");
      self ScriptModelPlayAnimDeltaMotionFromPos(anims[self.script_noteworthy], ref_node.origin, ref_node.angles);

      if(isDefined(self.collision_prop)) {
        self.collision_prop ScriptModelPlayAnimDeltaMotionFromPos(anims[self.script_noteworthy + "_collision"], ref_node.origin, ref_node.angles);
      }

      self thread drone_fx();

      break;
    default:
      break;
  }
}

hanger_floor_run() {
  floor_open_dist = 270;
  floor_open_time = 2;

  brace_rotate = 110;
  brace_return_delay = 2.0;
  brace_return_rotate = 90;

  drone_delay = 1.5;
  drone_move_down_time = 2;
  drone_move_dist = -512;
  drone_fly_dist = 6000;
  drone_fly_time = 2;

  window_move_time = 1;

  step_move_time = 1;

  switch (self.script_noteworthy) {
    case "hanger_floor_left":
      hanger_event_disconnect_nodes_floor();
      self MoveX(-1 * floor_open_dist, floor_open_time);
      break;
    case "hanger_floor_right":
      self MoveX(floor_open_dist, floor_open_time);
      break;

    case "drone":
      anims = [];

      anims["drone"] = "mp_lev_drone_deploy";

      ref_node = getstruct("ref_anim_node", "targetname");

      wait drone_delay;
      self ScriptModelPlayAnimDeltaMotionFromPos(anims[self.script_noteworthy], ref_node.origin, ref_node.angles);

      if(isDefined(self.collision_prop)) {
        self.collision_prop ScriptModelPlayAnimDeltaMotionFromPos(anims[self.script_noteworthy + "_collision"], ref_node.origin, ref_node.angles);
      }

      break;
    case "window":
      wait drone_delay;
      target = getstruct(self.target, "targetname");
      self MoveTo(target.origin, window_move_time);
      break;
    case "window_step":
      wait drone_delay;
      target = getstruct(self.target, "targetname");
      self MoveTo(target.origin, step_move_time);
      break;
    default:
      break;
  }
}

hanger_event_disconnect_nodes(targetname) {
  path_ent = GetEnt(targetname, "targetname");
  if(!isDefined(path_ent)) {
    return;
  }

  path_ent.origin += (0, 0, 1200);
  path_ent DisconnectPaths();
  path_ent.origin -= (0, 0, 1200);
}

hanger_event_disconnect_nodes_drone() {
  hanger_event_disconnect_nodes("path_node_disconnect_drone");
}

hanger_event_disconnect_nodes_floor() {
  hanger_event_disconnect_nodes("path_node_disconnect_floor");
}

hanger_event_connect_nodes(targetname) {
  path_ent = GetEnt(targetname, "targetname");
  if(!isDefined(path_ent)) {
    return;
  }

  path_ent ConnectPaths();
}

hanger_event_connect_nodes_drone() {
  hanger_event_connect_nodes("path_node_disconnect_drone");
}

hanger_event_connect_nodes_floor() {
  hanger_event_connect_nodes("path_node_disconnect_floor");
}