/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_raps.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace raps;

function autoexec __init__sytem__() {
  system::register("raps", & __init__, undefined, undefined);
}

function __init__() {
  clientfield::register("vehicle", "raps_side_deathfx", 1, 1, "int");
  vehicle::add_main_callback("raps", & raps_initialize);
  slow_triggers = getentarray("raps_slow", "targetname");
  array::thread_all(slow_triggers, & slow_raps_trigger);
}

function raps_initialize() {
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.delete_on_death = 1;
  self.health = self.healthdefault;
  self.last_jump_chance_time = 0;
  self useanimtree($generic);
  self vehicle::friendly_fire_shield();
  assert(isdefined(self.scriptbundlesettings));
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  if(self.settings.aim_assist) {
    self enableaimassist();
  }
  self setneargoalnotifydist(self.settings.near_goal_notify_dist);
  self.goalradius = 999999;
  self.goalheight = 999999;
  self setgoal(self.origin, 0, self.goalradius, self.goalheight);
  self.overridevehicledamage = & raps_callback_damage;
  self.allowfriendlyfiredamageoverride = & raps_allowfriendlyfiredamage;
  self.do_death_fx = & do_death_fx;
  self thread vehicle_ai::nudge_collision();
  self thread sndfunctions();
  if(isdefined(level.vehicle_initializer_cb)) {
    [
      [level.vehicle_initializer_cb]
    ](self);
  }
  defaultrole();
}

function defaultrole() {
  self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("combat").update_func = & state_combat_update;
  self vehicle_ai::get_state_callbacks("driving").update_func = & state_scripted_update;
  self vehicle_ai::get_state_callbacks("death").update_func = & state_death_update;
  self vehicle_ai::get_state_callbacks("emped").update_func = & state_emped_update;
  self vehicle_ai::call_custom_add_state_callbacks();
  vehicle_ai::startinitialstate("combat");
}

function state_scripted_update(params) {
  self endon("change_state");
  self endon("death");
  driver = self getseatoccupant(0);
  if(isplayer(driver)) {
    driver endon("disconnect");
    driver util::waittill_attack_button_pressed();
    self kill(self.origin, driver);
  }
}

function state_death_update(params) {
  self endon("death");
  attacker = params.inflictor;
  if(!isdefined(attacker)) {
    attacker = params.attacker;
  }
  if(attacker !== self && (!isdefined(self.owner) || self.owner !== attacker) && (isai(attacker) || isplayer(attacker))) {
    self.damage_on_death = 0;
    wait(0.05);
    attacker = params.inflictor;
    if(!isdefined(attacker)) {
      attacker = params.attacker;
    }
    if(isdefined(attacker) && !isdefined(self.detonate_sides_disabled)) {
      self detonate_sides(attacker);
    } else {
      self.damage_on_death = 1;
    }
  }
  self vehicle_ai::defaultstate_death_update();
}

function state_emped_update(params) {
  self endon("death");
  self endon("change_state");
  if(self.servershortout === 1) {
    forward = vectornormalize((self getvelocity()[0], self getvelocity()[1], 0));
    side = vectorcross(forward, (0, 0, 1)) * math::randomsign();
    self setvehgoalpos((self.origin + (side * 500)) + (forward * randomfloat(400)), 0, 0);
    wait(0.6);
    self clearvehgoalpos();
    self util::waittill_any_timeout(1.5, "veh_collision", "change_state", "death");
    self kill(self.origin, self.abnormal_status.attacker, self.abnormal_status.inflictor, getweapon("emp"));
  } else {
    vehicle_ai::defaultstate_emped_update(params);
  }
}

function state_combat_update(params) {
  self endon("change_state");
  self endon("death");
  pathfailcount = 0;
  foundpath = 1;
  self thread prevent_stuck();
  self thread detonation_monitor();
  self thread nudge_collision();
  for (;;) {
    if(isdefined(self.inpain) && self.inpain) {
      wait(0.1);
      continue;
    }
    if(!isdefined(self.enemy) || (isdefined(self.raps_force_patrol_behavior) && self.raps_force_patrol_behavior)) {
      if(isdefined(self.settings.all_knowing)) {
        self force_get_enemies();
      }
      self setspeed(self.settings.defaultmovespeed * 0.35);
      pixbeginevent("_raps::state_combat_update 1");
      queryresult = positionquery_source_navigation(self.origin, 0, self.settings.max_move_dist * 3, self.settings.max_move_dist * 3, self.radius * 2, self, self.radius * 4);
      pixendevent();
      positionquery_filter_inclaimedlocation(queryresult, self);
      positionquery_filter_distancetogoal(queryresult, self);
      vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
      best_point = undefined;
      best_score = -999999;
      foreach(point in queryresult.data) {
        if(!isdefined(point._scoredebug)) {
          point._scoredebug = [];
        }
        point._scoredebug[""] = mapfloat(0, 200, 0, 100, point.disttoorigin2d);
        point.score = point.score + mapfloat(0, 200, 0, 100, point.disttoorigin2d);
        if(point.inclaimedlocation) {
          if(!isdefined(point._scoredebug)) {
            point._scoredebug = [];
          }
          point._scoredebug[""] = -500;
          point.score = point.score + -500;
        }
        if(!isdefined(point._scoredebug)) {
          point._scoredebug = [];
        }
        point._scoredebug[""] = randomfloatrange(0, 50);
        point.score = point.score + randomfloatrange(0, 50);
        if(isdefined(self.prevmovedir)) {
          movedir = vectornormalize(point.origin - self.origin);
          if(vectordot(movedir, self.prevmovedir) > 0.64) {
            if(!isdefined(point._scoredebug)) {
              point._scoredebug = [];
            }
            point._scoredebug[""] = randomfloatrange(50, 150);
            point.score = point.score + randomfloatrange(50, 150);
          }
        }
        if(point.score > best_score) {
          best_score = point.score;
          best_point = point;
        }
      }
      self vehicle_ai::positionquery_debugscores(queryresult);
      foundpath = 0;
      if(isdefined(best_point)) {
        foundpath = self setvehgoalpos(best_point.origin, 0, 1);
      } else {
        wait(1);
      }
      if(foundpath) {
        self.prevmovedir = vectornormalize(best_point.origin - self.origin);
        self.current_pathto_pos = undefined;
        self thread path_update_interrupt();
        pathfailcount = 0;
        self vehicle_ai::waittill_pathing_done();
      } else {
        wait(1);
      }
      continue;
    }
    if(!self.enemy.allowdeath && self getpersonalthreatbias(self.enemy) == 0) {
      self setpersonalthreatbias(self.enemy, -2000, 30);
      wait(0.05);
      continue;
    }
    foundpath = 0;
    targetpos = raps_get_target_position();
    if(isdefined(targetpos)) {
      if(distancesquared(self.origin, targetpos) > (400 * 400) && self isposinclaimedlocation(targetpos)) {
        pixbeginevent("_raps::state_combat_update 2");
        queryresult = positionquery_source_navigation(targetpos, 0, self.settings.max_move_dist, self.settings.max_move_dist, self.radius, self);
        pixendevent();
        positionquery_filter_inclaimedlocation(queryresult, self.enemy);
        best_point = undefined;
        best_score = -999999;
        foreach(point in queryresult.data) {
          if(!isdefined(point._scoredebug)) {
            point._scoredebug = [];
          }
          point._scoredebug[""] = mapfloat(0, 200, 0, -200, distance(point.origin, queryresult.origin));
          point.score = point.score + (mapfloat(0, 200, 0, -200, distance(point.origin, queryresult.origin)));
          if(!isdefined(point._scoredebug)) {
            point._scoredebug = [];
          }
          point._scoredebug[""] = mapfloat(50, 200, 0, -200, abs(point.origin[2] - queryresult.origin[2]));
          point.score = point.score + (mapfloat(50, 200, 0, -200, abs(point.origin[2] - queryresult.origin[2])));
          if(point.inclaimedlocation === 1) {
            if(!isdefined(point._scoredebug)) {
              point._scoredebug = [];
            }
            point._scoredebug[""] = -500;
            point.score = point.score + -500;
          }
          if(point.score > best_score) {
            best_score = point.score;
            best_point = point;
          }
        }
        self vehicle_ai::positionquery_debugscores(queryresult);
        if(isdefined(best_point)) {
          targetpos = best_point.origin;
        }
      }
      foundpath = self setvehgoalpos(targetpos, 0, 1);
      if(self.test_failed_path === 1) {
        foundpath = vehicle_ai::waittill_pathresult(0.5);
      }
      if(foundpath) {
        self.current_pathto_pos = targetpos;
        self thread path_update_interrupt();
        pathfailcount = 0;
        self vehicle_ai::waittill_pathing_done();
      } else {
        wait(0.05);
      }
    }
    if(!foundpath) {
      pathfailcount++;
      if(pathfailcount > 2) {
        if(isdefined(self.enemy)) {
          self setpersonalthreatbias(self.enemy, -2000, 5);
        }
        if(pathfailcount > self.settings.max_path_fail_count) {
          detonate();
        }
      }
      wait(0.2);
      pixbeginevent("_raps::state_combat_update 3");
      queryresult = positionquery_source_navigation(self.origin, 0, self.settings.max_move_dist, self.settings.max_move_dist, self.radius, self);
      pixbeginevent("_raps::state_combat_update 3");
      if(queryresult.data.size) {
        point = queryresult.data[randomint(queryresult.data.size)];
        self setvehgoalpos(point.origin, 0, 0);
        self.current_pathto_pos = undefined;
        self thread path_update_interrupt();
        wait(2);
        self notify("near_goal");
      }
    }
    wait(0.2);
  }
}

function prevent_stuck() {
  self endon("change_state");
  self endon("death");
  self notify("end_prevent_stuck");
  self endon("end_prevent_stuck");
  wait(2);
  count = 0;
  previous_origin = undefined;
  while (true) {
    if(isdefined(previous_origin) && distancesquared(previous_origin, self.origin) < (0.1 * 0.1) && (!(isdefined(level.bzm_worldpaused) && level.bzm_worldpaused))) {
      count++;
    } else {
      previous_origin = self.origin;
      count = 0;
    }
    if(count > 10) {
      detonate();
    }
    wait(1);
  }
}

function check_detonation_dist(origin, enemy) {
  if(isdefined(enemy) && isalive(enemy)) {
    enemy_look_dir_offst = anglestoforward(enemy.angles) * 30;
    targetpoint = enemy.origin + enemy_look_dir_offst;
    if(distance2dsquared(targetpoint, origin) < (self.settings.detonation_distance * self.settings.detonation_distance) && ((abs(targetpoint[2] - origin[2])) < self.settings.detonation_distance || (abs((targetpoint[2] - 20) - origin[2])) < self.settings.detonation_distance)) {
      return true;
    }
  }
  return false;
}

function jump_detonate() {
  if(isdefined(self.sndalias["jump_up"])) {
    self playsound(self.sndalias["jump_up"]);
  }
  self launchvehicle((0, 0, 1) * self.jumpforce, (0, 0, 0), 1);
  self.is_jumping = 1;
  wait(0.4);
  time_to_land = 0.6;
  while (time_to_land > 0) {
    if(check_detonation_dist(self.origin, self.enemy)) {
      self detonate();
    }
    wait(0.05);
    time_to_land = time_to_land - 0.05;
  }
  if(isalive(self)) {
    self.is_jumping = 0;
    trace = physicstrace(self.origin + (0, 0, self.radius * 2), self.origin - vectorscale((0, 0, 1), 1000), vectorscale((-1, -1, -1), 10), vectorscale((1, 1, 1), 10), self, 2);
    willfall = 1;
    if(trace["fraction"] < 1) {
      pos = trace["position"];
      pos_on_navmesh = getclosestpointonnavmesh(pos, 100, self.radius, 16777183);
      if(isdefined(pos_on_navmesh)) {
        willfall = 0;
      }
    }
    if(willfall) {
      self detonate();
    }
  }
}

function detonate(attacker = self) {
  self stopsounds();
  self dodamage(self.health + 1000, self.origin, attacker, self, "none", "MOD_EXPLOSIVE", 0, self.turretweapon);
}

function detonate_damage_monitored(enemy, weapon) {
  self.selfdestruct = 1;
  self dodamage(1000, self.origin, enemy, self, "none", "MOD_EXPLOSIVE", 0, self.turretweapon);
}

function detonation_monitor() {
  self endon("death");
  self endon("change_state");
  lastenemy = undefined;
  while (true) {
    try_detonate();
    wait(0.2);
    if(isdefined(self.enemy) && isplayer(self.enemy)) {
      if(lastenemy !== self.enemy) {
        lastdisttoenemysquared = 1E+08;
        lastenemy = self.enemy;
      }
      if(!isdefined(self.looping_targeting_sound)) {
        if(isdefined(self.sndalias["vehRapsAlarm"])) {
          self.looping_targeting_sound = spawn("script_origin", self.origin);
          self.looping_targeting_sound linkto(self);
          self.looping_targeting_sound setinvisibletoall();
          self.looping_targeting_sound setvisibletoplayer(self.enemy);
          self.looping_targeting_sound playloopsound(self.sndalias["vehRapsAlarm"]);
          self.looping_targeting_sound thread raps_audio_cleanup(self);
        }
      }
      disttoenemysquared = distancesquared(self.origin, self.enemy.origin);
      if(disttoenemysquared < (250 * 250)) {
        if(lastdisttoenemysquared > (250 * 250) && (!(isdefined(self.servershortout) && self.servershortout)) && isdefined(self.sndalias["vehRapsClose250"])) {
          self playsoundtoplayer(self.sndalias["vehRapsClose250"], self.enemy);
        }
      } else {
        if(disttoenemysquared < (750 * 750)) {
          if(lastdisttoenemysquared > (750 * 750) && (!(isdefined(self.servershortout) && self.servershortout)) && isdefined(self.sndalias["vehRapsTargeting"])) {
            self playsoundtoplayer(self.sndalias["vehRapsTargeting"], self.enemy);
          }
        } else if(disttoenemysquared < (1500 * 1500)) {
          if(lastdisttoenemysquared > (1500 * 1500) && (!(isdefined(self.servershortout) && self.servershortout)) && isdefined(self.sndalias["vehRapsClose1500"])) {
            self playsoundtoplayer(self.sndalias["vehRapsClose1500"], self.enemy);
          }
        }
      }
      if(disttoenemysquared < lastdisttoenemysquared) {
        lastdisttoenemysquared = disttoenemysquared;
      }
      lastdisttoenemysquared = lastdisttoenemysquared + (10 * 10);
    }
  }
}

function raps_audio_cleanup(owner) {
  owner waittill("death");
  if(isdefined(owner)) {
    owner stopsounds();
  }
  if(isdefined(self)) {
    self stoploopsound();
    self delete();
  }
}

function try_detonate() {
  if(isdefined(self.disableautodetonation) && self.disableautodetonation) {
    return;
  }
  jump_time = 0.5;
  cur_time = gettime();
  can_jump = (cur_time - self.last_jump_chance_time) > 1500;
  if(can_jump) {
    predicted_origin = self.origin + (self getvelocity() * jump_time);
  }
  if(isdefined(predicted_origin) && check_detonation_dist(predicted_origin, self.enemy)) {
    trace = bullettrace(predicted_origin + (0, 0, self.radius), self.enemy.origin + (0, 0, self.radius), 1, self);
    if(trace["fraction"] === 1 || isdefined(trace["entity"])) {
      self.last_jump_chance_time = cur_time;
      jump_chance = self.settings.jump_chance;
      if((self.enemy.origin[2] - 20) > predicted_origin[2]) {
        jump_chance = self.settings.jump_chance * 2;
      }
      if(randomfloat(1) < jump_chance) {
        self jump_detonate();
      }
    }
  } else if(check_detonation_dist(self.origin, self.enemy)) {
    trace = bullettrace(self.origin + (0, 0, self.radius), self.enemy.origin + (0, 0, self.radius), 1, self);
    if(trace["fraction"] === 1 || isdefined(trace["entity"])) {
      self detonate();
    }
  }
  if(isdefined(self.owner)) {
    foreach(player in level.players) {
      if(self.owner util::isenemyplayer(player) && (!isdefined(self.enemy) || player != self.enemy)) {
        if(player isnotarget() || !isalive(player)) {
          continue;
        }
        if(player.ignoreme === 1) {
          continue;
        }
        if(!sessionmodeiscampaigngame() && !sessionmodeiszombiesgame() && player hasperk("specialty_nottargetedbyraps")) {
          continue;
        }
        if(distancesquared(player.origin, self.origin) < (self.settings.detonation_distance * self.settings.detonation_distance)) {
          trace = bullettrace(self.origin + (0, 0, self.radius), player.origin + (0, 0, self.radius), 1, self);
          if(trace["fraction"] === 1 || isdefined(trace["entity"])) {
            self detonate();
          }
        }
      }
    }
  }
}

function raps_get_target_position() {
  if(isdefined(self.settings.all_knowing)) {
    if(isdefined(self.enemy)) {
      target_pos = self.enemy.origin;
    }
  } else {
    target_pos = vehicle_ai::gettargetpos(vehicle_ai::getenemytarget());
  }
  enemy = self.enemy;
  if(isdefined(target_pos)) {
    target_pos_onnavmesh = getclosestpointonnavmesh(target_pos, self.settings.detonation_distance * 1.5, self.radius, 16777183);
  }
  if(!isdefined(target_pos_onnavmesh)) {
    if(isdefined(self.enemy)) {
      self setpersonalthreatbias(self.enemy, -2000, 5);
    }
    if(isdefined(self.current_pathto_pos)) {
      target_pos_onnavmesh = getclosestpointonnavmesh(self.current_pathto_pos, self.settings.detonation_distance * 2, self.settings.detonation_distance * 1.5, 16777183);
    }
    if(isdefined(target_pos_onnavmesh)) {
      return target_pos_onnavmesh;
    }
    return self.current_pathto_pos;
  }
  if(isdefined(self.enemy)) {
    if(distancesquared(target_pos, target_pos_onnavmesh) > (self.settings.detonation_distance * 0.9) * (self.settings.detonation_distance * 0.9)) {
      self setpersonalthreatbias(self.enemy, -2000, 5);
    }
  }
  if(isdefined(enemy) && isplayer(enemy)) {
    enemy_vel_offset = enemy getvelocity() * 0.5;
    enemy_look_dir_offset = anglestoforward(enemy.angles);
    if(distance2dsquared(self.origin, enemy.origin) > (500 * 500)) {
      enemy_look_dir_offset = enemy_look_dir_offset * 110;
    } else {
      enemy_look_dir_offset = enemy_look_dir_offset * 35;
    }
    offset = enemy_vel_offset + enemy_look_dir_offset;
    offset = (offset[0], offset[1], 0);
    if(tracepassedonnavmesh(target_pos_onnavmesh, target_pos + offset)) {
      target_pos = target_pos + offset;
    } else {
      target_pos = target_pos_onnavmesh;
    }
  } else {
    target_pos = target_pos_onnavmesh;
  }
  return target_pos;
}

function path_update_interrupt() {
  self endon("death");
  self endon("change_state");
  self endon("near_goal");
  self endon("reached_end_node");
  self notify("clear_interrupt_threads");
  self endon("clear_interrupt_threads");
  wait(0.1);
  while (true) {
    if(isdefined(self.current_pathto_pos)) {
      if(distance2dsquared(self.current_pathto_pos, self.goalpos) > (self.goalradius * self.goalradius)) {
        wait(0.5);
        self notify("near_goal");
      }
      targetpos = raps_get_target_position();
      if(isdefined(targetpos)) {
        if(distancesquared(self.origin, targetpos) > (400 * 400)) {
          repath_range = self.settings.repath_range * 2;
          wait(0.1);
        } else {
          repath_range = self.settings.repath_range;
        }
        if(distance2dsquared(self.current_pathto_pos, targetpos) > (repath_range * repath_range)) {
          if(isdefined(self.sndalias) && isdefined(self.sndalias["direction"])) {
            self playsound(self.sndalias["direction"]);
          }
          self notify("near_goal");
        }
      }
      if(isdefined(self.enemy) && isplayer(self.enemy) && !isdefined(self.slow_trigger)) {
        forward = anglestoforward(self.enemy getplayerangles());
        dir_to_raps = self.origin - self.enemy.origin;
        speedtouse = self.settings.defaultmovespeed;
        if(isdefined(self._override_raps_combat_speed)) {
          speedtouse = self._override_raps_combat_speed;
        }
        if(vectordot(forward, dir_to_raps) > 0) {
          self setspeed(speedtouse);
        } else {
          self setspeed(speedtouse * 0.75);
        }
      } else {
        speedtouse = self.settings.defaultmovespeed;
        if(isdefined(self._override_raps_combat_speed)) {
          speedtouse = self._override_raps_combat_speed;
        }
        self setspeed(speedtouse);
      }
      wait(0.2);
    } else {
      wait(0.4);
    }
  }
}

function collision_fx(normal) {
  tilted = normal[2] < 0.6;
  fx_origin = self.origin - (normal * (tilted ? 28 : 10));
  if(isdefined(self.sndalias["vehRapsCollision"])) {
    self playsound(self.sndalias["vehRapsCollision"]);
  }
}

function nudge_collision() {
  self endon("death");
  self endon("change_state");
  self notify("end_nudge_collision");
  self endon("end_nudge_collision");
  while (true) {
    self waittill("veh_collision", velocity, normal);
    ang_vel = self getangularvelocity() * 0.8;
    self setangularvelocity(ang_vel);
    if(isalive(self) && vectordot(normal, (0, 0, 1)) < 0.5) {
      self setvehvelocity(self.velocity + (normal * 400));
      self collision_fx(normal);
    }
  }
}

function raps_allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
  if(isdefined(self.owner) && eattacker == self.owner && isdefined(self.settings.friendly_fire) && int(self.settings.friendly_fire) && !weapon.isemp) {
    return true;
  }
  if(isdefined(eattacker) && isdefined(eattacker.archetype) && isdefined(smeansofdeath) && eattacker.archetype == "raps" && smeansofdeath == "MOD_EXPLOSIVE") {
    return true;
  }
  return false;
}

function detonate_sides(einflictor) {
  forward_direction = anglestoforward(self.angles);
  up_direction = anglestoup(self.angles);
  origin = self.origin + vectorscale(up_direction, 15);
  right_direction = vectorcross(forward_direction, up_direction);
  right_direction = vectornormalize(right_direction);
  left_direction = vectorscale(right_direction, -1);
  einflictor cylinderdamage(vectorscale(right_direction, 140), origin, 15, 50, self.radiusdamagemax, self.radiusdamagemax / 5, self, "MOD_EXPLOSIVE", self.turretweapon);
  einflictor cylinderdamage(vectorscale(left_direction, 140), origin, 15, 50, self.radiusdamagemax, self.radiusdamagemax / 5, self, "MOD_EXPLOSIVE", self.turretweapon);
  self.bsidedetonation = 1;
}

function raps_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(self.drop_deploying === 1 && smeansofdeath == "MOD_TRIGGER_HURT" && (!isdefined(self.hurt_trigger_immune_end_time) || gettime() < self.hurt_trigger_immune_end_time)) {
    return 0;
  }
  if(isdefined(eattacker) && isdefined(eattacker.archetype) && isdefined(smeansofdeath) && eattacker.archetype == "raps" && smeansofdeath == "MOD_EXPLOSIVE") {
    if(eattacker != self && isdefined(vdir) && lengthsquared(vdir) > 0.1 && (!isdefined(eattacker) || eattacker.team === self.team) && (!isdefined(einflictor) || einflictor.team === self.team)) {
      self setvehvelocity(self.velocity + (vectornormalize(vdir) * 300));
      return 1;
    }
  }
  if(vehicle_ai::should_emp(self, weapon, smeansofdeath, einflictor, eattacker)) {
    minempdowntime = 0.8 * self.settings.empdowntime;
    maxempdowntime = 1.2 * self.settings.empdowntime;
    self notify("emped", randomfloatrange(minempdowntime, maxempdowntime), eattacker, einflictor);
  }
  if(vehicle_ai::should_burn(self, weapon, smeansofdeath, einflictor, eattacker)) {
    self thread vehicle_ai::burning_thread(eattacker, einflictor);
  }
  return idamage;
}

function slow_raps_trigger() {
  self endon("death");
  while (true) {
    self waittill("trigger", other);
    if(isvehicle(other) && isdefined(other.archetype) && other.archetype == "raps") {
      other thread slow_raps(self);
    }
    wait(0.1);
  }
}

function slow_raps(trigger) {
  self notify("slow_raps");
  self endon("slow_raps");
  self endon("death");
  self.slow_trigger = 1;
  if(isdefined(trigger.script_int)) {
    if(isdefined(self._override_raps_combat_speed) && self._override_raps_combat_speed < trigger.script_int) {
      self setspeedimmediate(self._override_raps_combat_speed);
    } else {
      self setspeedimmediate(trigger.script_int, 200, 200);
    }
  } else {
    if(isdefined(self._override_raps_combat_speed) && self._override_raps_combat_speed < (0.5 * self.settings.defaultmovespeed)) {
      self setspeed(self._override_raps_combat_speed);
    } else {
      self setspeed(0.5 * self.settings.defaultmovespeed);
    }
  }
  wait(1);
  self resumespeed();
  self.slow_trigger = undefined;
}

function force_get_enemies() {
  if(isdefined(level.raps_force_get_enemies)) {
    return self[[level.raps_force_get_enemies]]();
  }
  foreach(player in level.players) {
    if(self util::isenemyplayer(player) && !player.ignoreme) {
      self getperfectinfo(player);
      return;
    }
  }
}

function sndfunctions() {
  self.sndalias = [];
  self.sndalias["inAir"] = "veh_raps_in_air";
  self.sndalias["land"] = "veh_raps_land";
  self.sndalias["spawn"] = "veh_raps_spawn";
  self.sndalias["direction"] = "veh_raps_direction";
  self.sndalias["jump_up"] = "veh_raps_jump_up";
  self.sndalias["vehRapsClose250"] = "veh_raps_close_250";
  self.sndalias["vehRapsClose1500"] = "veh_raps_close_1500";
  self.sndalias["vehRapsTargeting"] = "veh_raps_targeting";
  self.sndalias["vehRapsAlarm"] = "evt_raps_alarm";
  self.sndalias["vehRapsCollision"] = "veh_wasp_wall_imp";
  if(isdefined(self.vehicletype) && (self.vehicletype == "spawner_enemy_zombie_vehicle_raps_suicide" || self.vehicletype == "spawner_zombietron_veh_meatball" || self.vehicletype == "spawner_zombietron_veh_meatball_med" || self.vehicletype == "spawner_zombietron_veh_meatball_small")) {
    self.sndalias["inAir"] = "zmb_meatball_in_air";
    self.sndalias["land"] = "zmb_meatball_land";
    self.sndalias["spawn"] = undefined;
    self.sndalias["direction"] = undefined;
    self.sndalias["jump_up"] = "zmb_meatball_jump_up";
    self.sndalias["vehRapsClose250"] = "zmb_meatball_close_250";
    self.sndalias["vehRapsClose1500"] = undefined;
    self.sndalias["vehRapsTargeting"] = "zmb_meatball_targeting";
    self.sndalias["vehRapsAlarm"] = undefined;
    self.sndalias["vehRapsCollision"] = "zmb_meatball_collision";
  }
  if(self isdrivableplayervehicle()) {
    self thread drivablerapsinair();
  } else {
    self thread raps_in_air_audio();
    if(sessionmodeiscampaigngame() || sessionmodeiszombiesgame()) {
      self thread raps_spawn_audio();
    }
  }
}

function drivablerapsinair() {
  self endon("death");
  while (true) {
    self waittill("veh_landed");
    if(isdefined(self.sndalias["land"])) {
      self playsound(self.sndalias["land"]);
    }
  }
}

function raps_in_air_audio() {
  self endon("death");
  if(!sessionmodeiscampaigngame() && !sessionmodeiszombiesgame()) {
    self waittill("veh_landed");
  }
  while (true) {
    self waittill("veh_inair");
    if(isdefined(self.sndalias["inAir"])) {
      self playsound(self.sndalias["inAir"]);
    }
    self waittill("veh_landed");
    if(isdefined(self.sndalias["land"])) {
      self playsound(self.sndalias["land"]);
    }
  }
}

function raps_spawn_audio() {
  self endon("death");
  wait(randomfloatrange(0.25, 1.5));
  if(isdefined(self.sndalias["spawn"])) {
    self playsound(self.sndalias["spawn"]);
  }
}

function isdrivableplayervehicle() {
  str_vehicletype = self.vehicletype;
  if(isdefined(str_vehicletype) && strendswith(str_vehicletype, "_player")) {
    return true;
  }
  return false;
}

function do_death_fx() {
  self vehicle::do_death_dynents();
  if(isdefined(self.bsidedetonation)) {
    self clientfield::set("raps_side_deathfx", 1);
  } else {
    self clientfield::set("deathfx", 1);
  }
}