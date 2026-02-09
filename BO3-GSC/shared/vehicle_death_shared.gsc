/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicle_death_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\flag_shared;
#using scripts\shared\math_shared;
#using scripts\shared\sound_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace vehicle_death;

function autoexec __init__sytem__() {
  system::register("vehicle_death", &__init__, undefined, undefined);
}

function __init__() {
  setDvar("debug_crash_type", -1);
}

function main() {
  self endon("nodeath_thread");
  while(isDefined(self)) {
    self waittill("death", attacker, damagefromunderneath, weapon, point, dir);
    if(isDefined(self.death_enter_cb)) {
      [[self.death_enter_cb]]();
    }
    if(isDefined(self.script_deathflag)) {
      level flag::set(self.script_deathflag);
    }
    if(!isDefined(self.delete_on_death)) {
      self thread play_death_audio();
    }
    if(!isDefined(self)) {
      return;
    }
    self death_cleanup_level_variables();
    if(vehicle::is_corpse(self)) {
      if(!(isDefined(self.dont_kill_riders) && self.dont_kill_riders)) {
        self death_cleanup_riders();
      }
      self notify("delete_destructible");
      return;
    }
    self vehicle::lights_off();
    if(isDefined(level.vehicle_death_thread[self.vehicletype])) {
      thread[[level.vehicle_death_thread[self.vehicletype]]]();
    }
    if(!isDefined(self.delete_on_death)) {
      thread death_radius_damage();
    }
    is_aircraft = isDefined(self.vehicleclass) && self.vehicleclass == "plane" || (isDefined(self.vehicleclass) && self.vehicleclass == "helicopter");
    if(!isDefined(self.destructibledef)) {
      if(!is_aircraft && (!(self.vehicletype == "horse" || self.vehicletype == "horse_player" || self.vehicletype == "horse_player_low" || self.vehicletype == "horse_low" || self.vehicletype == "horse_axis")) && isDefined(self.deathmodel) && self.deathmodel != "") {
        self thread set_death_model(self.deathmodel, self.modelswapdelay);
      }
      if(!isDefined(self.delete_on_death) && (!isDefined(self.mantled) || !self.mantled) && !isDefined(self.nodeathfx)) {
        thread death_fx();
      }
      if(isDefined(self.delete_on_death)) {
        wait(0.05);
        if(self.disconnectpathonstop === 1) {
          self vehicle::disconnect_paths();
        }
        if(!(isDefined(self.no_free_on_death) && self.no_free_on_death)) {
          self freevehicle();
          self.isacorpse = 1;
          wait(0.05);
          if(isDefined(self)) {
            self notify("death_finished");
            self delete();
          }
        }
        continue;
      }
    }
    thread death_make_badplace(self.vehicletype);
    if(isDefined(level.vehicle_deathnotify) && isDefined(level.vehicle_deathnotify[self.vehicletype])) {
      level notify(level.vehicle_deathnotify[self.vehicletype], attacker);
    }
    if(target_istarget(self)) {
      target_remove(self);
    }
    if(self.classname == "script_vehicle") {
      self thread death_jolt(self.vehicletype);
    }
    if(do_scripted_crash()) {
      self thread death_update_crash(point, dir);
    }
    if(isDefined(self.turretweapon) && self.turretweapon != level.weaponnone) {
      self clearturrettarget();
    }
    self waittill_crash_done_or_stopped();
    if(isDefined(self)) {
      while(isDefined(self) && isDefined(self.dontfreeme)) {
        wait(0.05);
      }
      self notify("stop_looping_death_fx");
      self notify("death_finished");
      wait(0.05);
      if(isDefined(self)) {
        if(vehicle::is_corpse(self)) {
          continue;
        }
        if(!isDefined(self)) {
          continue;
        }
        occupants = self getvehoccupants();
        if(isDefined(occupants) && occupants.size) {
          for(i = 0; i < occupants.size; i++) {
            self usevehicle(occupants[i], 0);
          }
        }
        if(!(isDefined(self.no_free_on_death) && self.no_free_on_death)) {
          self freevehicle();
          self.isacorpse = 1;
        }
        if(self.modeldummyon) {
          self hide();
        }
      }
    }
  }
}

function do_scripted_crash() {
  return !isDefined(self.do_scripted_crash) || (isDefined(self.do_scripted_crash) && self.do_scripted_crash);
}

function play_death_audio() {
  if(isDefined(self) && (isDefined(self.vehicleclass) && self.vehicleclass == "helicopter")) {
    if(!isDefined(self.death_counter)) {
      self.death_counter = 0;
    }
    if(self.death_counter == 0) {
      self.death_counter++;
      self playSound("exp_veh_helicopter_hit");
    }
  }
}

function play_spinning_plane_sound() {
  self playLoopSound("veh_drone_spin", 0.05);
  level util::waittill_any("crash_move_done", "death");
  self stoploopsound(0.02);
}

function set_death_model(smodel, fdelay) {
  if(!isDefined(smodel)) {
    return;
  }
  if(isDefined(fdelay) && fdelay > 0) {
    wait(fdelay);
  }
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.deathmodel_attached)) {
    return;
  }
  emodel = vehicle::get_dummy();
  if(!isDefined(emodel)) {
    return;
  }
  if(!isDefined(emodel.death_anim) && isDefined(emodel.animtree)) {
    emodel clearanim(%generic::root, 0);
  }
  if(smodel != self.vehmodel) {
    emodel setModel(smodel);
    emodel setenemymodel(smodel);
  }
}

function aircraft_crash(point, dir) {
  self.crashing = 1;
  if(isDefined(self.unloading)) {
    while(isDefined(self.unloading)) {
      wait(0.05);
    }
  }
  if(!isDefined(self)) {
    return;
  }
  self thread aircraft_crash_move(point, dir);
  self thread play_spinning_plane_sound();
}

function helicopter_crash(point, dir) {
  self.crashing = 1;
  self thread play_crashing_loop();
  if(isDefined(self.unloading)) {
    while(isDefined(self.unloading)) {
      wait(0.05);
    }
  }
  if(!isDefined(self)) {
    return;
  }
  self thread helicopter_crash_movement(point, dir);
}

function helicopter_crash_movement(point, dir) {
  self endon("crash_done");
  self cancelaimove();
  self clearvehgoalpos();
  if(isDefined(level.heli_crash_smoke_trail_fx)) {
    if(issubstr(self.vehicletype, "v78")) {
      playFXOnTag(level.heli_crash_smoke_trail_fx, self, "tag_origin");
    } else {
      if(self.vehicletype == "drone_firescout_axis" || self.vehicletype == "drone_firescout_isi") {
        playFXOnTag(level.heli_crash_smoke_trail_fx, self, "tag_main_rotor");
      } else {
        playFXOnTag(level.heli_crash_smoke_trail_fx, self, "tag_engine_left");
      }
    }
  }
  crash_zones = struct::get_array("heli_crash_zone", "targetname");
  if(crash_zones.size > 0) {
    best_dist = 99999;
    best_idx = -1;
    if(isDefined(self.a_crash_zones)) {
      crash_zones = self.a_crash_zones;
    }
    for(i = 0; i < crash_zones.size; i++) {
      vec_to_crash_zone = crash_zones[i].origin - self.origin;
      vec_to_crash_zone = (vec_to_crash_zone[0], vec_to_crash_zone[1], 0);
      dist = length(vec_to_crash_zone);
      vec_to_crash_zone = vec_to_crash_zone / dist;
      veloctiy_scale = vectordot(self.velocity, vec_to_crash_zone) * -1;
      dist = dist + (500 * veloctiy_scale);
      if(dist < best_dist) {
        best_dist = dist;
        best_idx = i;
      }
    }
    if(best_idx != -1) {
      self.crash_zone = crash_zones[best_idx];
      self thread helicopter_crash_zone_accel(dir);
    }
  } else {
    if(isDefined(dir)) {
      dir = vectornormalize(dir);
    } else {
      dir = (1, 0, 0);
    }
    side_dir = vectorcross(dir, (0, 0, 1));
    side_dir_mag = randomfloatrange(-500, 500);
    side_dir_mag = side_dir_mag + (math::sign(side_dir_mag) * 60);
    side_dir = side_dir * side_dir_mag;
    side_dir = side_dir + vectorscale((0, 0, 1), 150);
    self setphysacceleration((randomintrange(-500, 500), randomintrange(-500, 500), -1000));
    self setvehvelocity(self.velocity + side_dir);
    self thread helicopter_crash_accel();
    if(isDefined(point)) {
      self thread helicopter_crash_rotation(point, dir);
    } else {
      self thread helicopter_crash_rotation(self.origin, dir);
    }
  }
  self thread crash_collision_test();
  wait(15);
  if(isDefined(self)) {
    self notify("crash_done");
  }
}

function helicopter_crash_accel() {
  self endon("crash_done");
  self endon("crash_move_done");
  self endon("death");
  if(!isDefined(self.crash_accel)) {
    self.crash_accel = randomfloatrange(50, 80);
  }
  while(isDefined(self)) {
    self setvehvelocity(self.velocity + (anglestoup(self.angles) * self.crash_accel));
    wait(0.1);
  }
}

function helicopter_crash_rotation(point, dir) {
  self endon("crash_done");
  self endon("crash_move_done");
  self endon("death");
  start_angles = self.angles;
  start_angles = (start_angles[0] + 10, start_angles[1], start_angles[2]);
  start_angles = (start_angles[0], start_angles[1], start_angles[2] + 10);
  ang_vel = self getangularvelocity();
  ang_vel = (0, ang_vel[1] * randomfloatrange(2, 3), 0);
  self setangularvelocity(ang_vel);
  point_2d = (point[0], point[1], self.origin[2]);
  torque = (0, randomintrange(90, 180), 0);
  if(self getangularvelocity()[1] < 0) {
    torque = torque * -1;
  }
  if(distance(self.origin, point_2d) > 5) {
    local_hit_point = point_2d - self.origin;
    dir_2d = (dir[0], dir[1], 0);
    if(length(dir_2d) > 0.01) {
      dir_2d = vectornormalize(dir_2d);
      torque = vectorcross(vectornormalize(local_hit_point), dir);
      torque = (0, 0, torque[2]);
      torque = vectornormalize(torque);
      torque = (0, torque[2] * 180, 0);
    }
  }
  while(true) {
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + (torque * 0.05);
    if(ang_vel[1] < (360 * -1)) {
      ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
    } else if(ang_vel[1] > 360) {
      ang_vel = (ang_vel[0], 360, ang_vel[2]);
    }
    self setangularvelocity(ang_vel);
    wait(0.05);
  }
}

function helicopter_crash_zone_accel(dir) {
  self endon("crash_done");
  self endon("crash_move_done");
  torque = (0, randomintrange(90, 150), 0);
  ang_vel = self getangularvelocity();
  torque = torque * math::sign(ang_vel[1]);
  if(isDefined(self.crash_zone.height)) {
    self.crash_zone.height = 0;
  }
  if(abs(self.angles[2]) < 3) {
    self.angles = (self.angles[0], self.angles[1], randomintrange(3, 6) * math::sign(self.angles[2]));
  }
  is_vtol = issubstr(self.vehicletype, "v78");
  if(is_vtol) {
    torque = torque * 0.3;
  }
  while(isDefined(self)) {
    assert(isDefined(self.crash_zone));
    dist = distance2d(self.origin, self.crash_zone.origin);
    if(dist < self.crash_zone.radius) {
      self setphysacceleration(vectorscale((0, 0, -1), 400));
      circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (0, 1, 0), 0, 2000);
      self.crash_accel = 0;
    } else {
      self setphysacceleration(vectorscale((0, 0, -1), 50));
      circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (1, 0, 0), 0, 2);
    }
    self.crash_vel = self.crash_zone.origin - self.origin;
    self.crash_vel = (self.crash_vel[0], self.crash_vel[1], 0);
    self.crash_vel = vectornormalize(self.crash_vel);
    self.crash_vel = self.crash_vel * (self getmaxspeed() * 0.5);
    if(is_vtol) {
      self.crash_vel = self.crash_vel * 0.5;
    }
    crash_vel_forward = (anglestoup(self.angles) * self getmaxspeed()) * 2;
    crash_vel_forward = (crash_vel_forward[0], crash_vel_forward[1], 0);
    self.crash_vel = self.crash_vel + crash_vel_forward;
    vel_x = difftrack(self.crash_vel[0], self.velocity[0], 1, 0.1);
    vel_y = difftrack(self.crash_vel[1], self.velocity[1], 1, 0.1);
    vel_z = difftrack(self.crash_vel[2], self.velocity[2], 1, 0.1);
    self setvehvelocity((vel_x, vel_y, vel_z));
    ang_vel = self getangularvelocity();
    ang_vel = (0, ang_vel[1], 0);
    ang_vel = ang_vel + (torque * 0.1);
    max_angluar_vel = 200;
    if(is_vtol) {
      max_angluar_vel = 100;
    }
    if(ang_vel[1] < (max_angluar_vel * -1)) {
      ang_vel = (ang_vel[0], max_angluar_vel * -1, ang_vel[2]);
    } else if(ang_vel[1] > max_angluar_vel) {
      ang_vel = (ang_vel[0], max_angluar_vel, ang_vel[2]);
    }
    self setangularvelocity(ang_vel);
    wait(0.1);
  }
}

function helicopter_collision() {
  self endon("crash_done");
  while(true) {
    self waittill("veh_collision", velocity, normal);
    ang_vel = self getangularvelocity() * 0.5;
    self setangularvelocity(ang_vel);
    if(normal[2] < 0.7) {
      self setvehvelocity(self.velocity + (normal * 70));
    } else {
      self notify("crash_done");
    }
  }
}

function play_crashing_loop() {
  ent = spawn("script_origin", self.origin);
  ent linkto(self);
  ent playLoopSound("exp_heli_crash_loop");
  self util::waittill_any("death", "snd_impact");
  ent delete();
}

function helicopter_explode(delete_me) {
  self endon("death");
  self vehicle::do_death_fx();
  if(isDefined(delete_me) && delete_me == 1) {
    self delete();
  }
  self thread set_death_model(self.deathmodel, self.modelswapdelay);
}

function aircraft_crash_move(point, dir) {
  self endon("crash_move_done");
  self endon("death");
  self thread crash_collision_test();
  self clearvehgoalpos();
  self cancelaimove();
  self setrotorspeed(0.2);
  if(isDefined(self) && isDefined(self.vehicletype)) {
    b_custom_deathmodel_setup = 1;
    switch (self.vehicletype) {
      default: {
        b_custom_deathmodel_setup = 0;
        break;
      }
    }
    if(b_custom_deathmodel_setup) {
      self.deathmodel_attached = 1;
    }
  }
  ang_vel = self getangularvelocity();
  ang_vel = (0, 0, 0);
  self setangularvelocity(ang_vel);
  nodes = self getvehicleavoidancenodes(10000);
  closest_index = -1;
  best_dist = 999999;
  if(nodes.size > 0) {
    for(i = 0; i < nodes.size; i++) {
      dir = vectornormalize(nodes[i] - self.origin);
      forward = anglesToForward(self.angles);
      dot = vectordot(dir, forward);
      if(dot < 0) {
        continue;
      }
      dist = distance2d(self.origin, nodes[i]);
      if(dist < best_dist) {
        best_dist = dist;
        closest_index = i;
      }
    }
    if(closest_index >= 0) {
      o = nodes[closest_index];
      o = (o[0], o[1], self.origin[2]);
      dir = vectornormalize(o - self.origin);
      self setvehvelocity(self.velocity + (dir * 2000));
    } else {
      self setvehvelocity((self.velocity + (anglestoright(self.angles) * (randomintrange(-1000, 1000)))) + (0, 0, randomintrange(0, 1500)));
    }
  } else {
    self setvehvelocity((self.velocity + (anglestoright(self.angles) * (randomintrange(-1000, 1000)))) + (0, 0, randomintrange(0, 1500)));
  }
  self thread delay_set_gravity(randomfloatrange(1.5, 3));
  torque = (0, randomintrange(-90, 90), randomintrange(90, 720));
  if(randomint(100) < 50) {
    torque = (torque[0], torque[1], torque[2] * -1);
  }
  while(isDefined(self)) {
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + (torque * 0.05);
    if(ang_vel[2] < (500 * -1)) {
      ang_vel = (ang_vel[0], ang_vel[1], 500 * -1);
    } else if(ang_vel[2] > 500) {
      ang_vel = (ang_vel[0], ang_vel[1], 500);
    }
    self setangularvelocity(ang_vel);
    wait(0.05);
  }
}

function delay_set_gravity(delay) {
  self endon("crash_move_done");
  self endon("death");
  wait(delay);
  self setphysacceleration((randomintrange(-1600, 1600), randomintrange(-1600, 1600), -1600));
}

function helicopter_crash_move(point, dir) {
  self endon("crash_move_done");
  self endon("death");
  self thread crash_collision_test();
  self cancelaimove();
  self clearvehgoalpos();
  self setturningability(0);
  self setphysacceleration(vectorscale((0, 0, -1), 800));
  vel = self.velocity;
  dir = vectornormalize(dir);
  ang_vel = self getangularvelocity();
  ang_vel = (0, ang_vel[1] * randomfloatrange(1, 3), 0);
  self setangularvelocity(ang_vel);
  point_2d = (point[0], point[1], self.origin[2]);
  torque = vectorscale((0, 1, 0), 720);
  if(distance(self.origin, point_2d) > 5) {
    local_hit_point = point_2d - self.origin;
    dir_2d = (dir[0], dir[1], 0);
    if(length(dir_2d) > 0.01) {
      dir_2d = vectornormalize(dir_2d);
      torque = vectorcross(vectornormalize(local_hit_point), dir);
      torque = (0, 0, torque[2]);
      torque = vectornormalize(torque);
      torque = (0, torque[2] * 180, 0);
    }
  }
  while(true) {
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + (torque * 0.05);
    if(ang_vel[1] < (360 * -1)) {
      ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
    } else if(ang_vel[1] > 360) {
      ang_vel = (ang_vel[0], 360, ang_vel[2]);
    }
    self setangularvelocity(ang_vel);
    wait(0.05);
  }
}

function boat_crash(point, dir) {
  self.crashing = 1;
  if(isDefined(self.unloading)) {
    while(isDefined(self.unloading)) {
      wait(0.05);
    }
  }
  if(!isDefined(self)) {
    return;
  }
  self thread boat_crash_movement(point, dir);
}

function boat_crash_movement(point, dir) {
  self endon("crash_move_done");
  self endon("death");
  self cancelaimove();
  self clearvehgoalpos();
  self setphysacceleration(vectorscale((0, 0, -1), 50));
  vel = self.velocity;
  dir = vectornormalize(dir);
  ang_vel = self getangularvelocity();
  ang_vel = (0, 0, 0);
  self setangularvelocity(ang_vel);
  torque = (randomintrange(-5, -3), 0, (randomintrange(0, 100) < 50 ? -5 : 5));
  self thread boat_crash_monitor(point, dir, 4);
  while(true) {
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + (torque * 0.05);
    if(ang_vel[1] < (360 * -1)) {
      ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
    } else if(ang_vel[1] > 360) {
      ang_vel = (ang_vel[0], 360, ang_vel[2]);
    }
    self setangularvelocity(ang_vel);
    velocity = self.velocity;
    velocity = (velocity[0] * 0.975, velocity[1], velocity[2]);
    velocity = (velocity[0], velocity[1] * 0.975, velocity[2]);
    self setvehvelocity(velocity);
    wait(0.05);
  }
}

function boat_crash_monitor(point, dir, crash_time) {
  self endon("death");
  wait(crash_time);
  self notify("crash_move_done");
  self crash_stop();
  self notify("crash_done");
}

function crash_stop() {
  self endon("death");
  self setphysacceleration((0, 0, 0));
  self setrotorspeed(0);
  speed = self getspeedmph();
  while(speed > 2) {
    velocity = self.velocity;
    velocity = velocity * 0.9;
    self setvehvelocity(velocity);
    angular_velocity = self getangularvelocity();
    angular_velocity = angular_velocity * 0.9;
    self setangularvelocity(angular_velocity);
    speed = self getspeedmph();
    wait(0.05);
  }
  self setvehvelocity((0, 0, 0));
  self setangularvelocity((0, 0, 0));
  self vehicle::toggle_tread_fx(0);
  self vehicle::toggle_exhaust_fx(0);
  self vehicle::toggle_sounds(0);
}

function crash_collision_test() {
  self endon("death");
  self waittill("veh_collision", velocity, normal);
  self helicopter_explode();
  self notify("crash_move_done");
  if(normal[2] > 0.7) {
    forward = anglesToForward(self.angles);
    right = vectorcross(normal, forward);
    desired_forward = vectorcross(right, normal);
    self setphysangles(vectortoangles(desired_forward));
    self crash_stop();
    self notify("crash_done");
  } else {
    wait(0.05);
    self delete();
  }
}

function crash_path_check(node) {
  targ = node;
  for(search_depth = 5; isDefined(targ) && search_depth >= 0; search_depth--) {
    if(isDefined(targ.detoured) && targ.detoured == 0) {
      detourpath = vehicle::path_detour_get_detourpath(getvehiclenode(targ.target, "targetname"));
      if(isDefined(detourpath) && isDefined(detourpath.script_crashtype)) {
        return true;
      }
    }
    if(isDefined(targ.target)) {
      targ1 = getvehiclenode(targ.target, "targetname");
      if(isDefined(targ1) && isDefined(targ1.target) && isDefined(targ.targetname) && targ1.target == targ.targetname) {
        return false;
      }
      if(isDefined(targ1) && targ1 == node) {
        return false;
      }
      targ = targ1;
      continue;
    }
    targ = undefined;
  }
  return false;
}

function death_firesound(sound) {
  self thread sound::loop_on_tag(sound, undefined, 0);
  self util::waittill_any("fire_extinguish", "stop_crash_loop_sound");
  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + sound);
}

function death_fx() {
  if(self vehicle::is_destructible()) {
    return;
  }
  self util::explode_notify_wrapper();
  if(isDefined(self.do_death_fx)) {
    self[[self.do_death_fx]]();
  } else {
    self vehicle::do_death_fx();
  }
}

function death_make_badplace(type) {
  if(!isDefined(level.vehicle_death_badplace[type])) {
    return;
  }
  struct = level.vehicle_death_badplace[type];
  if(isDefined(struct.delay)) {
    wait(struct.delay);
  }
  if(!isDefined(self)) {
    return;
  }
  badplace_box("vehicle_kill_badplace", struct.duration, self.origin, struct.radius, "all");
}

function death_jolt(type) {
  self endon("death");
  if(isDefined(self.ignore_death_jolt) && self.ignore_death_jolt) {
    return;
  }
  self joltbody(self.origin + (23, 33, 64), 3);
  if(isDefined(self.death_anim)) {
    self animscripted("death_anim", self.origin, self.angles, self.death_anim, "normal", %generic::root, 1, 0);
    self waittillmatch("death_anim");
  } else if(self.isphysicsvehicle) {
    num_launch_multiplier = 1;
    if(isDefined(self.physicslaunchdeathscale)) {
      num_launch_multiplier = self.physicslaunchdeathscale;
    }
    self launchvehicle(vectorscale((0, 0, 1), 180) * num_launch_multiplier, (randomfloatrange(5, 10), randomfloatrange(-5, 5), 0), 1, 0, 1);
  }
}

function deathrollon() {
  if(self.health > 0) {
    self.rollingdeath = 1;
  }
}

function deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

function loop_fx_on_vehicle_tag(effect, looptime, tag) {
  assert(isDefined(effect));
  assert(isDefined(tag));
  assert(isDefined(looptime));
  self endon("stop_looping_death_fx");
  while(isDefined(self)) {
    playFXOnTag(effect, deathfx_ent(), tag);
    wait(looptime);
  }
}

function deathfx_ent() {
  if(!isDefined(self.deathfx_ent)) {
    ent = spawn("script_model", (0, 0, 0));
    emodel = vehicle::get_dummy();
    ent setModel(self.model);
    ent.origin = emodel.origin;
    ent.angles = emodel.angles;
    ent notsolid();
    ent hide();
    ent linkto(emodel);
    self.deathfx_ent = ent;
  } else {
    self.deathfx_ent setModel(self.model);
  }
  return self.deathfx_ent;
}

function death_cleanup_level_variables() {
  script_linkname = self.script_linkname;
  targetname = self.targetname;
  if(isDefined(script_linkname)) {
    arrayremovevalue(level.vehicle_link[script_linkname], self);
  }
  if(isDefined(self.script_vehiclespawngroup)) {
    if(isDefined(level.vehicle_spawngroup[self.script_vehiclespawngroup])) {
      arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], self);
      arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], undefined);
    }
  }
  if(isDefined(self.script_vehiclestartmove)) {
    arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);
  }
  if(isDefined(self.script_vehiclegroupdelete)) {
    arrayremovevalue(level.vehicle_deletegroup[self.script_vehiclegroupdelete], self);
  }
}

function death_cleanup_riders() {
  if(isDefined(self.riders)) {
    for(j = 0; j < self.riders.size; j++) {
      if(isDefined(self.riders[j])) {
        self.riders[j] delete();
      }
    }
  }
  if(vehicle::is_corpse(self)) {
    self.riders = [];
  }
}

function death_radius_damage(meansofdamage = "MOD_EXPLOSIVE") {
  self endon("death");
  if(!isDefined(self) || self.abandoned === 1 || self.damage_on_death === 0 || self.radiusdamageradius <= 0) {
    return;
  }
  position = self.origin + vectorscale((0, 0, 1), 15);
  radius = self.radiusdamageradius;
  damagemax = self.radiusdamagemax;
  damagemin = self.radiusdamagemin;
  attacker = self;
  wait(0.05);
  if(isDefined(self)) {
    self radiusdamage(position, radius, damagemax, damagemin, attacker, meansofdamage);
  }
}

function death_update_crash(point, dir) {
  if(!isDefined(self.destructibledef)) {
    if(isDefined(self.script_crashtypeoverride)) {
      crashtype = self.script_crashtypeoverride;
    } else {
      if(isDefined(self.vehicleclass) && self.vehicleclass == "plane") {
        crashtype = "aircraft";
      } else {
        if(isDefined(self.vehicleclass) && self.vehicleclass == "helicopter") {
          crashtype = "helicopter";
        } else {
          if(isDefined(self.vehicleclass) && self.vehicleclass == "boat") {
            crashtype = "boat";
          } else {
            if(isDefined(self.currentnode) && crash_path_check(self.currentnode)) {
              crashtype = "none";
            } else {
              crashtype = "tank";
            }
          }
        }
      }
    }
    if(crashtype == "aircraft") {
      self thread aircraft_crash(point, dir);
    } else {
      if(crashtype == "helicopter") {
        if(isDefined(self.script_nocorpse)) {
          self thread helicopter_explode();
        } else {
          self thread helicopter_crash(point, dir);
        }
      } else {
        if(crashtype == "boat") {
          self thread boat_crash(point, dir);
        } else if(crashtype == "tank") {
          if(!isDefined(self.rollingdeath)) {
            self vehicle::set_speed(0, 25, "Dead");
          } else {
            self waittill("deathrolloff");
            self vehicle::set_speed(0, 25, "Dead, finished path intersection");
          }
          wait(0.4);
          if(isDefined(self) && !vehicle::is_corpse(self)) {
            self vehicle::set_speed(0, 10000, "deadstop");
            self notify("deadstop");
            if(self.disconnectpathonstop === 1) {
              self vehicle::disconnect_paths();
            }
            if(isDefined(self.tankgetout) && self.tankgetout > 0) {
              self waittill("animsdone");
            }
          }
        }
      }
    }
  }
}

function waittill_crash_done_or_stopped() {
  self endon("death");
  if(isDefined(self) && (isDefined(self.vehicleclass) && self.vehicleclass == "plane" || (isDefined(self.vehicleclass) && self.vehicleclass == "boat"))) {
    if(isDefined(self.crashing) && self.crashing == 1) {
      self waittill("crash_done");
    }
  } else {
    wait(0.2);
    if(self.isphysicsvehicle) {
      self clearvehgoalpos();
      self cancelaimove();
      stable_count = 0;
      while(stable_count < 3) {
        if(isDefined(self.velocity) && lengthsquared(self.velocity) > 1) {
          stable_count = 0;
        } else {
          stable_count++;
        }
        wait(0.3);
      }
      self vehicle::disconnect_paths();
    } else {
      while(isDefined(self) && self getspeedmph() > 0) {
        wait(0.3);
      }
    }
  }
}

function vehicle_damage_filter_damage_watcher(driver, heavy_damage_threshold) {
  self endon("death");
  self endon("exit_vehicle");
  self endon("end_damage_filter");
  if(!isDefined(heavy_damage_threshold)) {
    heavy_damage_threshold = 100;
  }
  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weapon);
    earthquake(0.25, 0.15, self.origin, 512, self);
    driver playrumbleonentity("damage_light");
    time = gettime();
    if((time - level.n_last_damage_time) > 500) {
      level.n_hud_damage = 1;
      if(damage > heavy_damage_threshold) {
        driver playSound("veh_damage_filter_heavy");
      } else {
        driver playSound("veh_damage_filter_light");
      }
      level.n_last_damage_time = gettime();
    }
  }
}

function vehicle_damage_filter_exit_watcher(driver) {
  self util::waittill_any("exit_vehicle", "death", "end_damage_filter");
}

function vehicle_damage_filter(vision_set, heavy_damage_threshold, filterid = 0, b_use_player_damage = 0) {
  self endon("death");
  self endon("exit_vehicle");
  self endon("end_damage_filter");
  driver = self getseatoccupant(0);
  if(!isDefined(self.damage_filter_init)) {
    self.damage_filter_init = 1;
  }
  level.n_hud_damage = 0;
  level.n_last_damage_time = gettime();
  damagee = isDefined(b_use_player_damage) && (b_use_player_damage ? driver : self);
  damagee thread vehicle_damage_filter_damage_watcher(driver, heavy_damage_threshold);
  damagee thread vehicle_damage_filter_exit_watcher(driver);
  while(true) {
    if(isDefined(level.n_hud_damage) && level.n_hud_damage) {
      time = gettime();
      if((time - level.n_last_damage_time) > 500) {
        level.n_hud_damage = 0;
      }
    }
    wait(0.05);
  }
}

function flipping_shooting_death(attacker, hitdir) {
  if(isDefined(self.delete_on_death)) {
    if(isDefined(self)) {
      self delete();
    }
    return;
  }
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self death_cleanup_level_variables();
  self disableaimassist();
  self death_fx();
  self thread death_radius_damage();
  self thread set_death_model(self.deathmodel, self.modelswapdelay);
  self vehicle::toggle_tread_fx(0);
  self vehicle::toggle_exhaust_fx(0);
  self vehicle::toggle_sounds(0);
  self vehicle::lights_off();
  self thread flipping_shooting_crash_movement(attacker, hitdir);
  self waittill("crash_done");
  while(isDefined(self.controlled) && self.controlled) {
    wait(0.05);
  }
  self delete();
}

function plane_crash() {
  self endon("death");
  self setphysacceleration(vectorscale((0, 0, -1), 1000));
  self.vehcheckforpredictedcrash = 1;
  forward = anglesToForward(self.angles);
  forward_mag = randomfloatrange(0, 300);
  forward_mag = forward_mag + (math::sign(forward_mag) * 400);
  forward = forward * forward_mag;
  new_vel = forward + (self.velocity * 0.2);
  ang_vel = self getangularvelocity();
  yaw_vel = randomfloatrange(0, 130) * math::sign(ang_vel[1]);
  yaw_vel = yaw_vel + (math::sign(yaw_vel) * 20);
  ang_vel = (randomfloatrange(-1, 1), yaw_vel, 0);
  roll_amount = (abs(ang_vel[1]) / 150) * 30;
  if(ang_vel[1] > 0) {
    roll_amount = roll_amount * -1;
  }
  self.angles = (self.angles[0], self.angles[1], roll_amount);
  ang_vel = (ang_vel[0], ang_vel[1], roll_amount * 0.9);
  self.velocity_rotation_frac = 1;
  self.crash_accel = randomfloatrange(65, 90);
  set_movement_and_accel(new_vel, ang_vel);
}

function barrel_rolling_crash() {
  self endon("death");
  self setphysacceleration(vectorscale((0, 0, -1), 1000));
  self.vehcheckforpredictedcrash = 1;
  forward = anglesToForward(self.angles);
  forward_mag = randomfloatrange(0, 250);
  forward_mag = forward_mag + (math::sign(forward_mag) * 300);
  forward = forward * forward_mag;
  new_vel = forward + vectorscale((0, 0, 1), 70);
  ang_vel = self getangularvelocity();
  yaw_vel = randomfloatrange(0, 60) * math::sign(ang_vel[1]);
  yaw_vel = yaw_vel + (math::sign(yaw_vel) * 30);
  roll_vel = randomfloatrange(-200, 200);
  roll_vel = roll_vel + (math::sign(roll_vel) * 300);
  ang_vel = (randomfloatrange(-5, 5), yaw_vel, roll_vel);
  self.velocity_rotation_frac = 1;
  self.crash_accel = randomfloatrange(145, 210);
  self setphysacceleration(vectorscale((0, 0, -1), 250));
  set_movement_and_accel(new_vel, ang_vel);
}

function random_crash(hitdir) {
  self endon("death");
  self setphysacceleration(vectorscale((0, 0, -1), 1000));
  self.vehcheckforpredictedcrash = 1;
  if(!isDefined(hitdir)) {
    hitdir = (1, 0, 0);
  }
  hitdir = vectornormalize(hitdir);
  side_dir = vectorcross(hitdir, (0, 0, 1));
  side_dir_mag = randomfloatrange(-280, 280);
  side_dir_mag = side_dir_mag + (math::sign(side_dir_mag) * 150);
  side_dir = side_dir * side_dir_mag;
  forward = anglesToForward(self.angles);
  forward_mag = randomfloatrange(0, 300);
  forward_mag = forward_mag + (math::sign(forward_mag) * 30);
  forward = forward * forward_mag;
  new_vel = (((self.velocity * 1.2) + forward) + side_dir) + vectorscale((0, 0, 1), 50);
  ang_vel = self getangularvelocity();
  ang_vel = (ang_vel[0] * 0.3, ang_vel[1], ang_vel[2] * 1.2);
  yaw_vel = randomfloatrange(0, 130) * math::sign(ang_vel[1]);
  yaw_vel = yaw_vel + (math::sign(yaw_vel) * 50);
  ang_vel = ang_vel + (randomfloatrange(-5, 5), yaw_vel, randomfloatrange(-18, 18));
  self.velocity_rotation_frac = randomfloatrange(0.3, 0.99);
  self.crash_accel = randomfloatrange(65, 90);
  set_movement_and_accel(new_vel, ang_vel);
}

function set_movement_and_accel(new_vel, ang_vel) {
  self death_fx();
  self thread death_radius_damage();
  self setvehvelocity(new_vel);
  self setangularvelocity(ang_vel);
  if(!isDefined(self.off)) {
    self thread flipping_shooting_crash_accel();
  }
  self thread vehicle_ai::nudge_collision();
  self playSound("veh_wasp_dmg_hit");
  self vehicle::toggle_sounds(0);
  if(!isDefined(self.off)) {
    self thread flipping_shooting_dmg_snd();
  }
  wait(0.1);
  if(randomint(100) < 40 && !isDefined(self.off) && self.variant !== "rocket") {
    self thread vehicle_ai::fire_for_time(randomfloatrange(0.7, 2));
  }
  result = self util::waittill_any_timeout(15, "crash_done");
  if(result === "crash_done") {
    self vehicle::do_death_dynents();
    self set_death_model(self.deathmodel, self.modelswapdelay);
  } else {
    self notify("crash_done");
  }
}

function flipping_shooting_crash_movement(attacker, hitdir) {
  self endon("crash_done");
  self endon("death");
  self cancelaimove();
  self clearvehgoalpos();
  self clearlookatent();
  self setphysacceleration(vectorscale((0, 0, -1), 1000));
  self.vehcheckforpredictedcrash = 1;
  if(!isDefined(hitdir)) {
    hitdir = (1, 0, 0);
  }
  hitdir = vectornormalize(hitdir);
  new_vel = self.velocity;
  self.crash_style = getdvarint("debug_crash_type");
  if(self.crash_style == -1) {
    self.crash_style = randomint(3);
  }
  switch (self.crash_style) {
    case 0: {
      barrel_rolling_crash();
      break;
    }
    case 1: {
      plane_crash();
      break;
    }
    default: {
      random_crash(hitdir);
    }
  }
}

function flipping_shooting_dmg_snd() {
  dmg_ent = spawn("script_origin", self.origin);
  dmg_ent linkto(self);
  dmg_ent playLoopSound("veh_wasp_dmg_loop");
  self util::waittill_any("crash_done", "death");
  dmg_ent stoploopsound(1);
  wait(2);
  dmg_ent delete();
}

function flipping_shooting_crash_accel() {
  self endon("crash_done");
  self endon("death");
  count = 0;
  prev_forward = anglesToForward(self.angles);
  prev_forward_vel = vectordot(self.velocity, prev_forward) * self.velocity_rotation_frac;
  if(prev_forward_vel < 0) {
    prev_forward_vel = 0;
  }
  while(true) {
    self setvehvelocity(self.velocity + (anglestoup(self.angles) * self.crash_accel));
    self.crash_accel = self.crash_accel * 0.98;
    new_velocity = self.velocity;
    new_velocity = new_velocity - (prev_forward * prev_forward_vel);
    forward = anglesToForward(self.angles);
    new_velocity = new_velocity + (forward * prev_forward_vel);
    prev_forward = forward;
    prev_forward_vel = vectordot(new_velocity, prev_forward) * self.velocity_rotation_frac;
    if(prev_forward_vel < 10) {
      new_velocity = new_velocity + (forward * 40);
      prev_forward_vel = 0;
    }
    self setvehvelocity(new_velocity);
    wait(0.1);
    count++;
    if((count % 8) == 0 && randomint(100) > 40) {
      if(self.velocity[2] > 130) {
        self.crash_accel = self.crash_accel * 0.75;
      } else if(self.velocity[2] < 40 && count < 60) {
        if(abs(self.angles[0]) > 35 || abs(self.angles[2]) > 35) {
          self.crash_accel = randomfloatrange(100, 150);
        } else {
          self.crash_accel = randomfloatrange(45, 70);
        }
      }
    }
  }
}

function death_fire_loop_audio() {
  sound_ent = spawn("script_origin", self.origin);
  sound_ent playLoopSound("veh_qrdrone_death_fire_loop", 0.1);
  wait(11);
  sound_ent stoploopsound(1);
  sound_ent delete();
}

function freewhensafe(time = 4) {
  self thread delayedremove_thread(time, 0);
}

function deletewhensafe(time = 4) {
  self thread delayedremove_thread(time, 1);
}

function delayedremove_thread(time, shoulddelete) {
  if(!isDefined(self)) {
    return;
  }
  self endon("death");
  self endon("free_vehicle");
  if(shoulddelete === 1) {
    self setvehvelocity((0, 0, 0));
    self ghost();
    self notsolid();
  }
  util::waitfortimeandnetworkframe(time);
  if(shoulddelete === 1) {
    self delete();
  } else {
    self freevehicle();
  }
}

function cleanup() {
  if(isDefined(self.cleanup_after_time)) {
    wait(self.cleanup_after_time);
    if(isDefined(self)) {
      self delete();
    }
  }
}