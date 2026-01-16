/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_vehicle_death.gsc
**************************************/

#include maps\_utility;
#include maps\_vehicle;
#include common_scripts\utility;
#include maps\_vehicle_aianim;
#include maps\_avenger;
#include maps\_pegasus;
#include maps\_f35;

init() {
  if(isassetloaded("fx", "trail/fx_trail_heli_killstreak_engine_smoke"))
    level.heli_crash_smoke_trail_fx = loadfx("trail/fx_trail_heli_killstreak_engine_smoke");
}

main() {
  self endon("nodeath_thread");

  while(isDefined(self)) {
    self waittill("death", attacker, damagefromunderneath, weaponname, point, dir);

    if(isDefined(self.script_deathflag))
      flag_set(self.script_deathflag);

    if(!isDefined(self.delete_on_death))
      self thread play_death_audio();

    if(!isDefined(self)) {
      return;
    }
    self lights_off();
    self death_cleanup_level_variables();

    if(is_corpse(self)) {
      if(isDefined(self.dont_kill_riders) && !self.dont_kill_riders)
        self death_cleanup_riders();

      self notify("delete_destructible");
      return;
    }

    if(isDefined(level.vehicle_death_thread[self.vehicletype]))
      thread[[level.vehicle_death_thread[self.vehicletype]]]();

    if(!isDefined(self.delete_on_death)) {
      if(isDefined(self.deathquakescale) && self.deathquakescale > 0)
        earthquake(self.deathquakescale, self.deathquakeduration, self.origin, self.deathquakeradius);

      thread death_radius_damage();
    }

    is_aircraft = self.vehicleclass == "plane" || self.vehicleclass == "helicopter";

    if(!isDefined(self.destructibledef)) {
      if(!is_aircraft && !(self.vehicletype == "horse" || self.vehicletype == "horse_player" || self.vehicletype == "horse_player_low" || self.vehicletype == "horse_low" || self.vehicletype == "horse_axis") && isDefined(self.deathmodel) && self.deathmodel != "")
        self thread set_death_model(self.deathmodel, self.modelswapdelay);

      if(!isDefined(self.delete_on_death) && (!isDefined(self.mantled) || !self.mantled) && !isDefined(self.nodeathfx))
        thread death_fx();

      if(isDefined(self.delete_on_death)) {
        wait 0.05;

        if(!isDefined(self.dontdisconnectpaths))
          self vehicle_disconnectpaths_wrapper();

        self freevehicle();
        self.isacorpse = 1;
        wait 0.05;
        self notify("death_finished");
        self delete();
        continue;
      }
    }

    if(isDefined(self.riders) && self.riders.size > 0)
      maps\_vehicle_aianim::blowup_riders();

    thread death_make_badplace(self.vehicletype);

    if(isDefined(level.vehicle_deathnotify) && isDefined(level.vehicle_deathnotify[self.vehicletype]))
      level notify(level.vehicle_deathnotify[self.vehicletype], attacker);

    if(target_istarget(self))
      target_remove(self);

    if(self.classname == "script_vehicle")
      self thread death_jolt(self.vehicletype);

    if(do_scripted_crash())
      self thread death_update_crash(point, dir);

    if(isDefined(self.turretweapon) && self.turretweapon != "")
      self clearturrettarget();

    self waittill_crash_done_or_stopped();

    if(isDefined(self)) {
      while(isDefined(self) && isDefined(self.dontfreeme))
        wait 0.05;

      self notify("stop_looping_death_fx");
      self notify("death_finished");
      wait 0.05;

      if(isDefined(self)) {
        if(is_corpse(self)) {
          continue;
        }
        if(!isDefined(self)) {
          continue;
        }
        occupants = self getvehoccupants();

        if(isDefined(occupants) && occupants.size) {
          for(i = 0; i < occupants.size; i++)
            self useby(occupants[i]);
        }

        self freevehicle();
        self.isacorpse = 1;

        if(self.modeldummyon)
          self hide();
      }
    }
  }
}

do_scripted_crash() {
  return !isDefined(self.do_scripted_crash) || isDefined(self.do_scripted_crash) && self.do_scripted_crash;
}

play_death_audio() {
  if(isDefined(self) && self.vehicleclass == "helicopter") {
    if(!isDefined(self.death_counter))
      self.death_counter = 0;

    if(self.death_counter == 0) {
      self.death_counter++;
      self playsound("exp_veh_helicopter_hit");
    }
  }
}

play_spinning_plane_sound() {
  self playloopsound("veh_drone_spin", 0.05);
  level waittill_any("crash_move_done", "death");
  self stoploopsound(0.02);
}

#using_animtree("vehicles");

set_death_model(smodel, fdelay) {
  assert(isDefined(smodel));

  if(isDefined(fdelay) && fdelay > 0)
    wait(fdelay);

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.deathmodel_attached)) {
    return;
  }
  emodel = get_dummy();

  if(!isDefined(emodel.death_anim))
    emodel clearanim( % root, 0);

  emodel setmodel(smodel);
  emodel setvehicleattachments(1);
}

aircraft_crash(point, dir) {
  self.crashing = 1;

  if(isDefined(self.unloading)) {
    while(isDefined(self.unloading))
      wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  self thread aircraft_crash_move(point, dir);
  self thread play_spinning_plane_sound();
}

helicopter_crash(point, dir) {
  self.crashing = 1;
  self thread play_crashing_loop();

  if(isDefined(self.unloading)) {
    while(isDefined(self.unloading))
      wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  self thread helicopter_crash_movement(point, dir);
}

helicopter_crash_movement(point, dir) {
  self endon("crash_done");
  self cancelaimove();
  self clearvehgoalpos();

  if(isDefined(level.heli_crash_smoke_trail_fx)) {
    if(issubstr(self.vehicletype, "v78"))
      playfxontag(level.heli_crash_smoke_trail_fx, self, "tag_origin");
    else if(self.vehicletype == "drone_firescout_axis" || self.vehicletype == "drone_firescout_isi")
      playfxontag(level.heli_crash_smoke_trail_fx, self, "tag_main_rotor");
    else
      playfxontag(level.heli_crash_smoke_trail_fx, self, "tag_engine_left");
  }

  crash_zones = getstructarray("heli_crash_zone", "targetname");

  if(crash_zones.size > 0) {
    best_dist = 99999;
    best_idx = -1;

    if(isDefined(self.a_crash_zones))
      crash_zones = self.a_crash_zones;

    for(i = 0; i < crash_zones.size; i++) {
      vec_to_crash_zone = crash_zones[i].origin - self.origin;
      vec_to_crash_zone = (vec_to_crash_zone[0], vec_to_crash_zone[1], 0);
      dist = length(vec_to_crash_zone);
      vec_to_crash_zone = vec_to_crash_zone / dist;
      veloctiy_scale = vectordot(self.velocity, vec_to_crash_zone) * -1;
      dist = dist + 500 * veloctiy_scale;

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
    dir = vectornormalize(dir);
    side_dir = vectorcross(dir, (0, 0, 1));
    side_dir_mag = randomfloatrange(-500, 500);
    side_dir_mag = side_dir_mag + sign(side_dir_mag) * 60;
    side_dir = side_dir * side_dir_mag;
    side_dir = side_dir + vectorscale((0, 0, 1), 150.0);
    self setphysacceleration((randomintrange(-500, 500), randomintrange(-500, 500), -1000));
    self setvehvelocity(self.velocity + side_dir);
    self thread helicopter_crash_accel();
    self thread helicopter_crash_rotation(point, dir);
  }

  self thread crash_collision_test();
  wait 15;
  self notify("crash_done");
}

helicopter_crash_accel() {
  self endon("crash_done");
  self endon("crash_move_done");

  if(!isDefined(self.crash_accel))
    self.crash_accel = randomfloatrange(50, 80);

  while(isDefined(self)) {
    self setvehvelocity(self.velocity + anglestoup(self.angles) * self.crash_accel);
    wait 0.1;
  }
}

helicopter_crash_rotation(point, dir) {
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

  if(self getangularvelocity()[1] < 0)
    torque = torque * -1;

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
    ang_vel = ang_vel + torque * 0.05;

    if(ang_vel[1] < 360 * -1)
      ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
    else if(ang_vel[1] > 360)
      ang_vel = (ang_vel[0], 360, ang_vel[2]);

    self setangularvelocity(ang_vel);
    wait 0.05;
  }
}

helicopter_crash_zone_accel(dir) {
  self endon("crash_done");
  self endon("crash_move_done");
  torque = (0, randomintrange(90, 150), 0);
  ang_vel = self getangularvelocity();
  torque = torque * sign(ang_vel[1]);

  if(isDefined(self.crash_zone.height))
    self.crash_zone.height = 0;

  if(abs(self.angles[2]) < 3.0)
    self.angles = (self.angles[0], self.angles[1], randomintrange(3, 6) * sign(self.angles[2]));

  is_vtol = issubstr(self.vehicletype, "v78");

  if(is_vtol)
    torque = torque * 0.3;

  while(isDefined(self)) {
    assert(isDefined(self.crash_zone));
    dist = distance2d(self.origin, self.crash_zone.origin);

    if(dist < self.crash_zone.radius) {
      self setphysacceleration(vectorscale((0, 0, -1), 400.0));

      circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (0, 1, 0), 0, 2000);

      self.crash_accel = 0;
    } else {
      self setphysacceleration(vectorscale((0, 0, -1), 50.0));

      circle(self.crash_zone.origin + (0, 0, self.crash_zone.height), self.crash_zone.radius, (1, 0, 0), 0, 2);

    }

    self.crash_vel = self.crash_zone.origin - self.origin;
    self.crash_vel = (self.crash_vel[0], self.crash_vel[1], 0);
    self.crash_vel = vectornormalize(self.crash_vel);
    self.crash_vel = self.crash_vel * (self getmaxspeed() * 0.5);

    if(is_vtol)
      self.crash_vel = self.crash_vel * 0.5;

    crash_vel_forward = anglestoup(self.angles) * self getmaxspeed() * 2;
    crash_vel_forward = (crash_vel_forward[0], crash_vel_forward[1], 0);
    self.crash_vel = self.crash_vel + crash_vel_forward;
    vel_x = difftrack(self.crash_vel[0], self.velocity[0], 1, 0.1);
    vel_y = difftrack(self.crash_vel[1], self.velocity[1], 1, 0.1);
    vel_z = difftrack(self.crash_vel[2], self.velocity[2], 1, 0.1);
    self setvehvelocity((vel_x, vel_y, vel_z));
    ang_vel = self getangularvelocity();
    ang_vel = (0, ang_vel[1], 0);
    ang_vel = ang_vel + torque * 0.1;
    max_angluar_vel = 200;

    if(is_vtol)
      max_angluar_vel = 100;

    if(ang_vel[1] < max_angluar_vel * -1)
      ang_vel = (ang_vel[0], max_angluar_vel * -1, ang_vel[2]);
    else if(ang_vel[1] > max_angluar_vel)
      ang_vel = (ang_vel[0], max_angluar_vel, ang_vel[2]);

    self setangularvelocity(ang_vel);
    wait 0.1;
  }
}

helicopter_collision() {
  self endon("crash_done");

  while(true) {
    self waittill("veh_collision", velocity, normal);
    ang_vel = self getangularvelocity() * 0.5;
    self setangularvelocity(ang_vel);

    if(normal[2] < 0.7)
      self setvehvelocity(self.velocity + normal * 70);
    else {
      createdynentandlaunch(self.deathmodel, self.origin, self.angles, self.origin, self.velocity * 0.03, self.deathfx, 1);
      self notify("crash_done");
    }
  }
}

play_crashing_loop() {
  ent = spawn("script_origin", self.origin);
  ent linkto(self);
  ent playloopsound("exp_heli_crash_loop");
  self waittill_any("death", "snd_impact");
  ent delete();
}

helicopter_explode(delete_me) {
  self endon("death");
  fx_origin = self gettagorigin(self.death_fx_struct.tag);
  fx_angles = self gettagangles(self.death_fx_struct.tag);

  if(isDefined(self.death_fx_struct) && isDefined(self.death_fx_struct.effect))
    playfx(self.death_fx_struct.effect, fx_origin, anglestoforward(fx_angles), anglestoup(fx_angles));

  if(abs(fx_origin[0]) > 65000 || abs(fx_origin[1]) > 60000 || abs(fx_origin[2]) > 30000) {
    return;
  }
  playsoundatposition("exp_veh_helicopter", fx_origin);
  self notify("snd_impact");

  if(isDefined(delete_me) && delete_me == 1)
    self delete();

  self thread set_death_model(self.deathmodel, self.modelswapdelay);
}

aircraft_crash_move(point, dir) {
  self endon("crash_move_done");
  self endon("death");
  self thread crash_collision_test();
  self clearvehgoalpos();
  self cancelaimove();
  self setrotorspeed(0.2);

  if(isDefined(self) && isDefined(self.vehicletype)) {
    b_custom_deathmodel_setup = 1;

    switch (self.vehicletype) {
      case "drone_avenger":
      case "drone_avenger_fast":
      case "drone_avenger_fast_la2":
      case "drone_avenger_fast_la2_2x":
        self maps\_avenger::set_deathmodel(point, dir);
        break;
      case "drone_pegasus":
      case "drone_pegasus_fast":
      case "drone_pegasus_fast_la2":
      case "drone_pegasus_fast_la2_2x":
      case "drone_pegasus_low":
      case "drone_pegasus_low_la2":
        self maps\_pegasus::set_deathmodel(point, dir);
        break;
      case "plane_f35":
      case "plane_f35_fast":
      case "plane_f35_fast_la2":
      case "plane_f35_vtol":
      case "plane_f35_vtol_nocockpit":
      case "plane_fa38_hero":
        self maps\_f35::set_deathmodel(point, dir);
        break;
      default:
        b_custom_deathmodel_setup = 0;
        break;
    }

    if(b_custom_deathmodel_setup)
      self.deathmodel_attached = 1;
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
      forward = anglestoforward(self.angles);
      dot = vectordot(dir, forward);

      if(dot < 0.0) {
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
      self setvehvelocity(self.velocity + dir * 2000);
    } else
      self setvehvelocity(self.velocity + anglestoright(self.angles) * randomintrange(-1000, 1000) + (0, 0, randomintrange(0, 1500)));
  } else
    self setvehvelocity(self.velocity + anglestoright(self.angles) * randomintrange(-1000, 1000) + (0, 0, randomintrange(0, 1500)));

  self thread delay_set_gravity(randomfloatrange(1.5, 3));
  torque = (0, randomintrange(-90, 90), randomintrange(90, 720));

  if(randomint(100) < 50)
    torque = (torque[0], torque[1], torque[2] * -1);

  while(isDefined(self)) {
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + torque * 0.05;

    if(ang_vel[2] < 500 * -1)
      ang_vel = (ang_vel[0], ang_vel[1], 500 * -1);
    else if(ang_vel[2] > 500)
      ang_vel = (ang_vel[0], ang_vel[1], 500);

    self setangularvelocity(ang_vel);
    wait 0.05;
  }
}

delay_set_gravity(delay) {
  self endon("crash_move_done");
  self endon("death");
  wait(delay);
  self setphysacceleration((randomintrange(-1600, 1600), randomintrange(-1600, 1600), -1600));
}

helicopter_crash_move(point, dir) {
  self endon("crash_move_done");
  self endon("death");
  self thread crash_collision_test();
  self cancelaimove();
  self clearvehgoalpos();
  self setturningability(0);
  self setphysacceleration(vectorscale((0, 0, -1), 800.0));
  vel = self.velocity;
  dir = vectornormalize(dir);
  ang_vel = self getangularvelocity();
  ang_vel = (0, ang_vel[1] * randomfloatrange(1, 3), 0);
  self setangularvelocity(ang_vel);
  point_2d = (point[0], point[1], self.origin[2]);
  torque = vectorscale((0, 1, 0), 720.0);

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
    ang_vel = ang_vel + torque * 0.05;

    if(ang_vel[1] < 360 * -1)
      ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
    else if(ang_vel[1] > 360)
      ang_vel = (ang_vel[0], 360, ang_vel[2]);

    self setangularvelocity(ang_vel);
    wait 0.05;
  }
}

boat_crash(point, dir) {
  self.crashing = 1;

  if(isDefined(self.unloading)) {
    while(isDefined(self.unloading))
      wait 0.05;
  }

  if(!isDefined(self)) {
    return;
  }
  self thread boat_crash_movement(point, dir);
}

boat_crash_movement(point, dir) {
  self endon("crash_move_done");
  self endon("death");
  self cancelaimove();
  self clearvehgoalpos();
  self setphysacceleration(vectorscale((0, 0, -1), 50.0));
  vel = self.velocity;
  dir = vectornormalize(dir);
  ang_vel = self getangularvelocity();
  ang_vel = (0, 0, 0);
  self setangularvelocity(ang_vel);
  torque = (randomintrange(-5, -3), 0, randomintrange(0, 100) < 50 ? -5 : 5);
  self thread boat_crash_monitor(point, dir, 4);

  while(true) {
    ang_vel = self getangularvelocity();
    ang_vel = ang_vel + torque * 0.05;

    if(ang_vel[1] < 360 * -1)
      ang_vel = (ang_vel[0], 360 * -1, ang_vel[2]);
    else if(ang_vel[1] > 360)
      ang_vel = (ang_vel[0], 360, ang_vel[2]);

    self setangularvelocity(ang_vel);
    velocity = self.velocity;
    velocity = (velocity[0] * 0.975, velocity[1], velocity[2]);
    velocity = (velocity[0], velocity[1] * 0.975, velocity[2]);
    self setvehvelocity(velocity);
    wait 0.05;
  }
}

boat_crash_monitor(point, dir, crash_time) {
  self endon("death");
  wait(crash_time);
  self notify("crash_move_done");
  self crash_stop();
  self notify("crash_done");
}

crash_stop() {
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
    wait 0.05;
  }

  self setvehvelocity((0, 0, 0));
  self setangularvelocity((0, 0, 0));
  self veh_toggle_tread_fx(0);
  self veh_toggle_exhaust_fx(0);
  self vehicle_toggle_sounds(0);
}

crash_collision_test() {
  self endon("death");
  self waittill("veh_collision", velocity, normal);
  self helicopter_explode();
  self notify("crash_move_done");

  if(normal[2] > 0.7) {
    forward = anglestoforward(self.angles);
    right = vectorcross(normal, forward);
    desired_forward = vectorcross(right, normal);
    self setphysangles(vectortoangles(desired_forward));
    self crash_stop();
    self notify("crash_done");
  } else {
    wait 0.05;
    self delete();
  }
}

crash_path_check(node) {
  targ = node;

  for(search_depth = 5; isDefined(targ) && search_depth >= 0; search_depth--) {
    if(isDefined(targ.detoured) && targ.detoured == 0) {
      detourpath = path_detour_get_detourpath(getvehiclenode(targ.target, "targetname"));

      if(isDefined(detourpath) && isDefined(detourpath.script_crashtype))
        return true;
    }

    if(isDefined(targ.target)) {
      targ1 = getvehiclenode(targ.target, "targetname");

      if(isDefined(targ1) && isDefined(targ1.target) && isDefined(targ.targetname) && targ1.target == targ.targetname)
        return false;
      else if(isDefined(targ1) && targ1 == node)
        return false;
      else
        targ = targ1;

      continue;
    }

    targ = undefined;
  }

  return false;
}

death_firesound(sound) {
  self thread play_loop_sound_on_tag(sound, undefined, 0);
  self waittill_any("fire_extinguish", "stop_crash_loop_sound");

  if(!isDefined(self)) {
    return;
  }
  self notify("stop sound" + sound);
}

death_fx() {
  if(self isdestructible()) {
    return;
  }
  level notify("vehicle_explosion", self.origin);
  self explode_notify_wrapper();
  struct = build_death_fx(self.deathfx, self.deathfxtag, self.deathfxsound);
  thread death_fx_thread(struct);
}

death_fx_thread(struct) {
  assert(isDefined(struct));

  if(isDefined(struct.waitdelay)) {
    if(struct.waitdelay >= 0)
      wait(struct.waitdelay);
    else
      self waittill("death_finished");
  }

  if(!isDefined(self)) {
    return;
  }
  if((self.vehicleclass == "helicopter" || self.vehicleclass == "plane") && do_scripted_crash()) {
    self.death_fx_struct = struct;
    return;
  }

  if(isDefined(struct.notifystring))
    self notify(struct.notifystring);

  emodel = get_dummy();

  if(isDefined(struct.effect)) {
    if(struct.beffectlooping && !isDefined(self.delete_on_death)) {
      if(isDefined(struct.tag)) {
        if(isDefined(struct.stayontag) && struct.stayontag == 1)
          thread loop_fx_on_vehicle_tag(struct.effect, struct.delay, struct.tag);
        else
          thread playloopedfxontag(struct.effect, struct.delay, struct.tag);
      } else {
        forward = emodel.origin + vectorscale((0, 0, 1), 100.0) - emodel.origin;
        playfx(struct.effect, emodel.origin, forward);
      }
    } else if(isDefined(struct.tag)) {
      if(isDefined(self.modeldummyon) && self.modeldummyon)
        playfxontag(struct.effect, deathfx_ent(), struct.tag);
      else
        playfxontag(struct.effect, self, struct.tag);
    } else {
      forward = emodel.origin + vectorscale((0, 0, 1), 100.0) - emodel.origin;
      playfx(struct.effect, emodel.origin, forward);
    }
  }

  if(isDefined(struct.sound) && !isDefined(self.delete_on_death)) {
    if(struct.bsoundlooping)
      thread death_firesound(struct.sound);
    else
      self play_sound_in_space(struct.sound);
  }
}

build_death_fx(effect, tag, sound, beffectlooping, delay, bsoundlooping, waitdelay, stayontag, notifystring) {
  if(!isDefined(bsoundlooping))
    bsoundlooping = 0;

  if(!isDefined(beffectlooping))
    beffectlooping = 0;

  if(!isDefined(delay))
    delay = 1;

  struct = spawnstruct();
  struct.effect = effect;
  struct.tag = tag;
  struct.sound = sound;
  struct.bsoundlooping = bsoundlooping;
  struct.delay = delay;
  struct.waitdelay = waitdelay;
  struct.stayontag = stayontag;
  struct.notifystring = notifystring;
  struct.beffectlooping = beffectlooping;
  return struct;
}

death_make_badplace(type) {
  if(!isDefined(level.vehicle_death_badplace[type])) {
    return;
  }
  struct = level.vehicle_death_badplace[type];

  if(isDefined(struct.delay))
    wait(struct.delay);

  if(!isDefined(self)) {
    return;
  }
  badplace_cylinder("vehicle_kill_badplace", struct.duration, self.origin, struct.radius, struct.height, struct.team1, struct.team2);
}

death_jolt(type) {
  self endon("death");

  if(is_true(self.ignore_death_jolt)) {
    return;
  }
  old_dontfreeme = self.dontfreeme;
  self joltbody(self.origin + (23, 33, 64), 3);

  if(isDefined(self.death_anim)) {
    self animscripted("death_anim", self.origin, self.angles, self.death_anim, "normal", % root, 1, 0);
    self waittillmatch("death_anim", "end");
  } else if(!isDefined(self.destructibledef)) {
    if(self.isphysicsvehicle) {
      num_launch_multiplier = 1;

      if(self.vehicleclass == "tank")
        num_launch_multiplier = 0.1;

      self launchvehicle(vectorscale((0, 0, 1), 250.0) * num_launch_multiplier, (randomfloatrange(5, 10), randomfloatrange(-5, 5), 0), 1, 0, 1);
    }
  }

  wait 2;
  self.dontfreeme = old_dontfreeme;
}

deathrollon() {
  if(self.health > 0)
    self.rollingdeath = 1;
}

deathrolloff() {
  self.rollingdeath = undefined;
  self notify("deathrolloff");
}

loop_fx_on_vehicle_tag(effect, looptime, tag) {
  assert(isDefined(effect));
  assert(isDefined(tag));
  assert(isDefined(looptime));
  self endon("stop_looping_death_fx");

  while(isDefined(self)) {
    playfxontag(effect, deathfx_ent(), tag);
    wait(looptime);
  }
}

deathfx_ent() {
  if(!isDefined(self.deathfx_ent)) {
    ent = spawn("script_model", (0, 0, 0));
    emodel = get_dummy();
    ent setmodel(self.model);
    ent.origin = emodel.origin;
    ent.angles = emodel.angles;
    ent notsolid();
    ent hide();
    ent linkto(emodel);
    self.deathfx_ent = ent;
  } else
    self.deathfx_ent setmodel(self.model);

  return self.deathfx_ent;
}

death_cleanup_level_variables() {
  script_linkname = self.script_linkname;
  targetname = self.targetname;

  if(isDefined(script_linkname))
    arrayremovevalue(level.vehicle_link[script_linkname], self);

  if(isDefined(self.script_vehiclespawngroup)) {
    if(isDefined(level.vehicle_spawngroup[self.script_vehiclespawngroup])) {
      arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], self);
      arrayremovevalue(level.vehicle_spawngroup[self.script_vehiclespawngroup], undefined);
    }
  }

  if(isDefined(self.script_vehiclestartmove))
    arrayremovevalue(level.vehicle_startmovegroup[self.script_vehiclestartmove], self);

  if(isDefined(self.script_vehiclegroupdelete))
    arrayremovevalue(level.vehicle_deletegroup[self.script_vehiclegroupdelete], self);
}

death_cleanup_riders() {
  if(isDefined(self.riders)) {
    for(j = 0; j < self.riders.size; j++) {
      if(isDefined(self.riders[j]))
        self.riders[j] delete();
    }
  }

  if(is_corpse(self))
    self.riders = [];
}

death_radius_damage() {
  if(!isDefined(self) || self.radiusdamageradius <= 0) {
    return;
  }
  wait 0.05;

  if(isDefined(self))
    self radiusdamage(self.origin + vectorscale((0, 0, 1), 15.0), self.radiusdamageradius, self.radiusdamagemax, self.radiusdamagemin, self, "MOD_EXPLOSIVE");
}

death_update_crash(point, dir) {
  if(!isDefined(self.destructibledef)) {
    if(isDefined(self.script_crashtypeoverride))
      crashtype = self.script_crashtypeoverride;
    else if(self.vehicleclass == "plane")
      crashtype = "aircraft";
    else if(self.vehicleclass == "helicopter")
      crashtype = "helicopter";
    else if(self.vehicleclass == "boat")
      crashtype = "boat";
    else if(isDefined(self.currentnode) && crash_path_check(self.currentnode))
      crashtype = "none";
    else
      crashtype = "tank";

    if(crashtype == "aircraft")
      self thread aircraft_crash(point, dir);

    if(crashtype == "helicopter") {
      if(isDefined(self.script_nocorpse))
        self thread helicopter_explode();
      else
        self thread helicopter_crash(point, dir);
    }

    if(crashtype == "boat")
      self thread boat_crash(point, dir);

    if(crashtype == "tank") {
      if(!isDefined(self.rollingdeath))
        self vehicle_setspeed(0, 25, "Dead");
      else {
        self waittill("deathrolloff");
        self vehicle_setspeed(0, 25, "Dead, finished path intersection");
      }

      wait 0.4;

      if(isDefined(self) && !is_corpse(self)) {
        self vehicle_setspeed(0, 10000, "deadstop");
        self notify("deadstop");

        if(!isDefined(self.dontdisconnectpaths))
          self vehicle_disconnectpaths_wrapper();

        if(isDefined(self.tankgetout) && self.tankgetout > 0)
          self waittill("animsdone");
      }
    }
  }
}

waittill_crash_done_or_stopped() {
  self endon("death");

  if(isDefined(self) && (self.vehicleclass == "plane" || self.vehicleclass == "boat")) {
    if(isDefined(self.crashing) && self.crashing == 1)
      self waittill("crash_done");
  } else {
    wait 0.2;

    if(self.isphysicsvehicle) {
      self clearvehgoalpos();
      self cancelaimove();

      while(isDefined(self.velocity) && lengthsquared(self.velocity) > 1.0)
        wait 0.3;

      self vehicle_disconnectpaths_wrapper();
    } else {
      while(isDefined(self) && self getspeedmph() > 0)
        wait 0.3;
    }
  }
}

precache_death_model_wrapper(death_model_name) {
  if(!isDefined(self.script_string) || isDefined(self.script_string) && self.script_string != "no_deathmodel")
    precachemodel(death_model_name);
}

vehicle_damage_filter_damage_watcher(heavy_damage_threshold) {
  self endon("death");
  self endon("exit_vehicle");
  self endon("end_damage_filter");

  if(!isDefined(heavy_damage_threshold))
    heavy_damage_threshold = 100;

  while(true) {
    self waittill("damage", damage, attacker, direction, point, type, tagname, modelname, partname, weaponname);
    earthquake(0.25, 0.15, self.origin, 512, self);
    level.player playrumbleonentity("damage_light");
    time = gettime();

    if(time - level.n_last_damage_time > 500) {
      level.n_hud_damage = 1;

      if(damage > heavy_damage_threshold) {
        rpc("clientscripts/_vehicle", "damage_filter_heavy");
        level.player playsound("veh_damage_filter_heavy");
      } else {
        rpc("clientscripts/_vehicle", "damage_filter_light");
        level.player playsound("veh_damage_filter_light");
      }

      level.n_last_damage_time = gettime();
    }
  }
}

vehicle_damage_filter_exit_watcher() {
  self waittill_any("exit_vehicle", "death", "end_damage_filter");
  rpc("clientscripts/_vehicle", "damage_filter_disable");
  rpc("clientscripts/_vehicle", "damage_filter_off");

  if(isDefined(level.player.save_visionset))
    level.player visionsetnaked(level.player.save_visionset, 0);
}

vehicle_damage_filter(vision_set, heavy_damage_threshold, filterid, b_use_player_damage) {
  if(!isDefined(filterid))
    filterid = 0;

  if(!isDefined(b_use_player_damage))
    b_use_player_damage = 0;

  self endon("death");
  self endon("exit_vehicle");
  self endon("end_damage_filter");

  if(!isDefined(self.damage_filter_init)) {
    rpc("clientscripts/_vehicle", "init_damage_filter", filterid);
    self.damage_filter_init = 1;
  } else
    rpc("clientscripts/_vehicle", "damage_filter_enable", 0, filterid);

  if(isDefined(vision_set)) {
    level.player.save_visionset = level.player getvisionsetnaked();
    level.player visionsetnaked(vision_set, 0.5);
  }

  level.n_hud_damage = 0;
  level.n_last_damage_time = gettime();
  damagee = isDefined(b_use_player_damage) && b_use_player_damage ? level.player : self;
  damagee thread vehicle_damage_filter_damage_watcher(heavy_damage_threshold);
  damagee thread vehicle_damage_filter_exit_watcher();

  while(true) {
    if(isDefined(level.n_hud_damage) && level.n_hud_damage) {
      time = gettime();

      if(time - level.n_last_damage_time > 500) {
        rpc("clientscripts/_vehicle", "damage_filter_off");
        level.n_hud_damage = 0;
      }
    }

    wait 0.05;
  }
}