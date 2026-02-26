/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\vehicles\smart_bomb.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\laststand_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#namespace smart_bomb;

function function_c6f75619() {
  self.last_jump_chance_time = 0;
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.delete_on_death = 1;
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  assert(isDefined(self.scriptbundlesettings));
  self.settings = getscriptbundle(self.scriptbundlesettings);

  if(self.settings.aim_assist) {
    self enableaimassist();
  }

  if(self.settings.ignorelaststandplayers === 1) {
    self.ignorelaststandplayers = 1;
  }

  self setneargoalnotifydist(self.settings.near_goal_notify_dist);
  self.goalradius = 999999;
  self.goalheight = 999999;
  self setgoal(self.origin, 0, self.goalradius, self.goalheight);
  self.allowfriendlyfiredamageoverride = &function_bf16c9ed;
  self.do_death_fx = &do_death_fx;
  self.canbemeleed = 0;
  self thread vehicle_ai::nudge_collision();
  self thread sndfunctions();
}

function state_scripted_update(params) {
  self endon(#"change_state", #"death");
  driver = self getseatoccupant(0);

  if(isPlayer(driver)) {
    driver endon(#"disconnect");
    driver util::waittill_attack_button_pressed();
    self kill(self.origin, driver);
  }
}

function state_death_update(params) {
  self endon(#"death");
  attacker = params.inflictor;

  if(!isDefined(attacker)) {
    attacker = params.attacker;
  }

  waitframe(1);
  damage_on_death = self.damage_on_death;

  if(isDefined(attacker) && !is_true(self.detonate_sides_disabled)) {
    if(attacker !== self && (!isDefined(self.owner) || self.owner !== attacker) && (isai(attacker) || isPlayer(attacker))) {
      damage_on_death = 0;
      self detonate_sides(attacker);
    }
  }

  self.damage_on_death = damage_on_death;
  self vehicle_ai::defaultstate_death_update();
}

function state_emped_update(params) {
  self endon(#"death", #"change_state");

  if(self.servershortout === 1) {
    forward = vectornormalize((self getvelocity()[0], self getvelocity()[1], 0));
    side = vectorcross(forward, (0, 0, 1)) * math::randomsign();
    self function_a57c34b7(self.origin + side * 500 + forward * randomfloat(400), 0, 0);
    wait 0.6;
    self function_d4c687c9();
    self waittilltimeout(1.5, #"veh_collision");
    self kill(self.origin, self.abnormal_status.attacker, self.abnormal_status.inflictor, getweapon(#"emp"));
    return;
  }

  vehicle_ai::defaultstate_emped_update(params);
}

function state_combat_update(params) {
  self endon(#"change_state", #"death");
  pathfailcount = 0;
  foundpath = 1;
  self thread prevent_stuck();
  self thread detonation_monitor();

  for(;;) {
    if(is_true(self.inpain)) {
      wait 0.1;
      continue;
    }

    if(!isDefined(self.enemy)) {
      if(isDefined(self.settings.all_knowing)) {
        self force_get_enemies();
      }

      self setspeed(self.settings.defaultmovespeed * 0.35);
      pixbeginevent(#"");
      queryresult = positionquery_source_navigation(self.origin, 0, self.settings.max_move_dist * 3, self.settings.max_move_dist * 3, self.radius * 2, self, self.radius * 4);
      pixendevent();
      positionquery_filter_inclaimedlocation(queryresult, self);
      positionquery_filter_distancetogoal(queryresult, self);
      vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
      best_point = undefined;
      best_score = -999999;

      foreach(point in queryresult.data) {
        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }

        if(!isDefined(point._scoredebug[#"disttoorigin"])) {
          point._scoredebug[#"disttoorigin"] = spawnStruct();
        }

        point._scoredebug[#"disttoorigin"].score = mapfloat(0, 200, 0, 100, point.disttoorigin2d);
        point._scoredebug[#"disttoorigin"].scorename = "<dev string:x38>";

        point.score += mapfloat(0, 200, 0, 100, point.disttoorigin2d);

        if(point.inclaimedlocation) {
          if(!isDefined(point._scoredebug)) {
            point._scoredebug = [];
          }

          if(!isDefined(point._scoredebug[#"inclaimedlocation"])) {
            point._scoredebug[#"inclaimedlocation"] = spawnStruct();
          }

          point._scoredebug[#"inclaimedlocation"].score = -500;
          point._scoredebug[#"inclaimedlocation"].scorename = "<dev string:x48>";

          point.score += -500;
        }

        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }

        if(!isDefined(point._scoredebug[#"random"])) {
          point._scoredebug[#"random"] = spawnStruct();
        }

        point._scoredebug[#"random"].score = randomfloatrange(0, 50);
        point._scoredebug[#"random"].scorename = "<dev string:x5d>";

        point.score += randomfloatrange(0, 50);

        if(isDefined(self.prevmovedir)) {
          movedir = vectornormalize(point.origin - self.origin);

          if(vectordot(movedir, self.prevmovedir) > 0.64) {
            if(!isDefined(point._scoredebug)) {
              point._scoredebug = [];
            }

            if(!isDefined(point._scoredebug[#"currentmovedir"])) {
              point._scoredebug[#"currentmovedir"] = spawnStruct();
            }

            point._scoredebug[#"currentmovedir"].score = randomfloatrange(50, 150);
            point._scoredebug[#"currentmovedir"].scorename = "<dev string:x67>";

            point.score += randomfloatrange(50, 150);
          }
        }

        if(point.score > best_score) {
          best_score = point.score;
          best_point = point;
        }
      }

      self vehicle_ai::positionquery_debugscores(queryresult);
      foundpath = 0;

      if(isDefined(best_point)) {
        foundpath = self function_a57c34b7(best_point.origin, 0, 1);
      } else {
        wait 1;
      }

      if(foundpath) {
        self.prevmovedir = vectornormalize(best_point.origin - self.origin);
        self.current_pathto_pos = undefined;
        self thread path_update_interrupt();
        pathfailcount = 0;
        self vehicle_ai::waittill_pathing_done();
      } else {
        wait 1;
      }

      continue;
    }

    if(!self.enemy.allowdeath && issentient(self.enemy) && self getpersonalthreatbias(self.enemy) == 0) {
      self setpersonalthreatbias(self.enemy, -2000, 30);
      waitframe(1);
      continue;
    }

    foundpath = hunt_enemy();

    if(!foundpath) {
      pathfailcount++;

      if(pathfailcount > 2) {
        if(isDefined(self.enemy) && issentient(self.enemy)) {
          self setpersonalthreatbias(self.enemy, -2000, 5);
        }

        if(isDefined(self.settings.max_path_fail_count) && pathfailcount > self.settings.max_path_fail_count) {
          detonate();
        }
      }

      wait 0.2;
      pixbeginevent(#"");
      queryresult = positionquery_source_navigation(self.origin, 0, self.settings.max_move_dist, self.settings.max_move_dist, self.radius, self);
      pixendevent();

      if(queryresult.data.size) {
        point = queryresult.data[randomint(queryresult.data.size)];
        self function_a57c34b7(point.origin, 0, 0);
        self.current_pathto_pos = undefined;
        self thread path_update_interrupt();
        wait 2;
        self notify(#"near_goal");
      }
    }

    wait 0.2;
  }
}

function hunt_enemy() {
  foundpath = 0;
  targetpos = function_dcecac3c();

  if(isDefined(targetpos)) {
    if(distancesquared(self.origin, targetpos) > sqr(400) && self isposinclaimedlocation(targetpos)) {
      pixbeginevent(#"");
      queryresult = positionquery_source_navigation(targetpos, 0, self.settings.max_move_dist, self.settings.max_move_dist, self.radius, self);
      pixendevent();
      positionquery_filter_inclaimedlocation(queryresult, self.enemy);
      best_point = undefined;
      best_score = -999999;

      foreach(point in queryresult.data) {
        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }

        if(!isDefined(point._scoredebug[#"disttoorigin"])) {
          point._scoredebug[#"disttoorigin"] = spawnStruct();
        }

        point._scoredebug[#"disttoorigin"].score = mapfloat(0, 200, 0, -200, distance(point.origin, queryresult.origin));
        point._scoredebug[#"disttoorigin"].scorename = "<dev string:x38>";

        point.score += mapfloat(0, 200, 0, -200, distance(point.origin, queryresult.origin));

        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }

        if(!isDefined(point._scoredebug[#"heighttoorigin"])) {
          point._scoredebug[#"heighttoorigin"] = spawnStruct();
        }

        point._scoredebug[#"heighttoorigin"].score = mapfloat(50, 200, 0, -200, abs(point.origin[2] - queryresult.origin[2]));
        point._scoredebug[#"heighttoorigin"].scorename = "<dev string:x79>";

        point.score += mapfloat(50, 200, 0, -200, abs(point.origin[2] - queryresult.origin[2]));

        if(point.inclaimedlocation === 1) {
          if(!isDefined(point._scoredebug)) {
            point._scoredebug = [];
          }

          if(!isDefined(point._scoredebug[#"inclaimedlocation"])) {
            point._scoredebug[#"inclaimedlocation"] = spawnStruct();
          }

          point._scoredebug[#"inclaimedlocation"].score = -500;
          point._scoredebug[#"inclaimedlocation"].scorename = "<dev string:x48>";

          point.score += -500;
        }

        if(point.score > best_score) {
          best_score = point.score;
          best_point = point;
        }
      }

      self vehicle_ai::positionquery_debugscores(queryresult);

      if(isDefined(best_point)) {
        targetpos = best_point.origin;
      }
    }

    foundpath = self function_a57c34b7(targetpos, 0, 1);

    if(self.test_failed_path === 1) {
      foundpath = vehicle_ai::waittill_pathresult(0.5);
    }

    if(foundpath) {
      self.current_pathto_pos = targetpos;
      self thread path_update_interrupt();
      pathfailcount = 0;
      self vehicle_ai::waittill_pathing_done();
    } else {
      waitframe(1);
    }
  }

  return foundpath;
}

function prevent_stuck() {
  self endon(#"change_state", #"death");
  self notify(#"end_prevent_stuck");
  self endon(#"end_prevent_stuck");
  wait 2;
  count = 0;
  previous_origin = undefined;

  while(true) {
    if(isDefined(previous_origin) && distancesquared(previous_origin, self.origin) < sqr(0.1) && !is_true(level.bzm_worldpaused)) {
      count++;
    } else {
      previous_origin = self.origin;
      count = 0;
    }

    if(count > 10) {
      detonate();
    }

    wait 1;
  }
}

function check_detonation_dist(origin, enemy) {
  if(isDefined(enemy) && isalive(enemy)) {
    enemy_look_dir_offst = anglesToForward(enemy.angles) * 30;
    targetpoint = enemy.origin + enemy_look_dir_offst;

    if(distance2dsquared(targetpoint, origin) < sqr(self.settings.detonation_distance) && (abs(targetpoint[2] - origin[2]) < self.settings.detonation_distance || abs(targetpoint[2] - self.settings.jump_height - origin[2]) < self.settings.detonation_distance)) {
      return true;
    }
  }

  return false;
}

function jump_detonate() {
  if(isDefined(self.sndalias[#"jump_up"])) {
    self playSound(self.sndalias[#"jump_up"]);
  }

  self launchvehicle((0, 0, 1) * self.jumpforce, (0, 0, 0), 1);
  self.is_jumping = 1;
  wait 0.4;
  time_to_land = 0.6;

  while(time_to_land > 0) {
    if(check_detonation_dist(self.origin, self.enemy)) {
      self detonate();
    }

    waitframe(1);
    time_to_land -= 0.05;
  }

  if(isalive(self)) {
    self.is_jumping = 0;
    trace = physicstrace(self.origin + (0, 0, self.radius * 2), self.origin - (0, 0, 1000), (-10, -10, -10), (10, 10, 10), self, 2);
    willfall = 1;

    if(trace[#"fraction"] < 1) {
      pos = trace[#"position"];
      pos_on_navmesh = getclosestpointonnavmesh(pos, 100, self.radius, 4194287);

      if(isDefined(pos_on_navmesh)) {
        willfall = 0;
      }
    }

    if(willfall) {
      self detonate();
    }
  }
}

function detonate(attacker = self) {
  if(isDefined(self.owner) && isbot(self.owner) && isDefined(self.killstreaktype) && self.killstreaktype == "recon_car") {
    self notify(#"shutdown");
    return;
  }

  self stopsounds();
  self dodamage(self.health + 1000, self.origin, attacker, self, "none", "MOD_EXPLOSIVE", 0, self.turretweapon);
}

function detonation_monitor() {
  self endon(#"death", #"change_state");
  lastenemy = undefined;

  while(true) {
    wait 0.2;
    try_detonate();

    if(isDefined(self.var_345c5167)) {
      [[self.var_345c5167]]();
      continue;
    }

    function_ded83def(lastenemy);
  }
}

function function_ded83def(lastenemy) {
  if(isDefined(self.enemy) && isPlayer(self.enemy)) {
    if(lastenemy !== self.enemy) {
      lastdisttoenemysquared = 1e+08;
      lastenemy = self.enemy;
    }

    if(!isDefined(self.looping_targeting_sound)) {
      if(isDefined(self.sndalias[#"vehalarm"])) {
        self.looping_targeting_sound = spawn("script_origin", self.origin);
        self.looping_targeting_sound linkto(self);
        self.looping_targeting_sound setinvisibletoall();
        self.looping_targeting_sound setvisibletoplayer(self.enemy);
        self.looping_targeting_sound playLoopSound(self.sndalias[#"vehalarm"]);
        self.looping_targeting_sound thread function_47dbd72(self);
      }
    }

    enemy = self.enemy;
    enemy_origin = enemy.origin;

    if(isPlayer(enemy) && enemy isinvehicle()) {
      enemy_vehicle = enemy getvehicleoccupied();
      enemy_origin = enemy_vehicle.origin;
    }

    disttoenemysquared = distancesquared(self.origin, enemy_origin);

    if(disttoenemysquared < sqr(250)) {
      if(lastdisttoenemysquared > sqr(250) && !is_true(self.servershortout) && isDefined(self.sndalias[#"vehclose250"])) {
        self playsoundtoplayer(self.sndalias[#"vehclose250"], self.enemy);
      }
    } else if(disttoenemysquared < sqr(750)) {
      if(lastdisttoenemysquared > sqr(750) && !is_true(self.servershortout) && isDefined(self.sndalias[#"vehtargeting"])) {
        self playsoundtoplayer(self.sndalias[#"vehtargeting"], self.enemy);
      }
    } else if(disttoenemysquared < sqr(1500)) {
      if(lastdisttoenemysquared > sqr(1500) && !is_true(self.servershortout) && isDefined(self.sndalias[#"vehclose1500"])) {
        self playsoundtoplayer(self.sndalias[#"vehclose1500"], self.enemy);
      }
    }

    if(disttoenemysquared < lastdisttoenemysquared) {
      lastdisttoenemysquared = disttoenemysquared;
    }

    lastdisttoenemysquared += sqr(10);
  }
}

function function_47dbd72(bomb) {
  bomb waittill(#"death");

  if(isDefined(bomb)) {
    bomb stopsounds();
  }

  if(isDefined(self)) {
    self stoploopsound();
    self delete();
  }
}

function try_detonate() {
  if(is_true(self.disableautodetonation)) {
    return;
  }

  jump_time = 0.5;
  cur_time = gettime();

  if(isDefined(self.enemy)) {
    var_8abb9239 = self.origin;
    jump_chance = self.settings.jump_chance;

    if(isDefined(jump_chance) && jump_chance > 0) {
      can_jump = 1;

      if(can_jump) {
        jump_origin = self.origin + self getvelocity() * jump_time;
        centroid = self.enemy getcentroid();

        if(centroid[2] - self.settings.jump_height > jump_origin[2]) {
          jump_chance = 1;
        }

        if(randomfloat(1) <= jump_chance) {
          var_8abb9239 = jump_origin;
          self.last_jump_chance_time = cur_time;
          jump = 1;
        }
      }
    }

    if(isDefined(var_8abb9239) && check_detonation_dist(var_8abb9239, self.enemy)) {
      trace = bulletTrace(var_8abb9239 + (0, 0, self.radius), self.enemy.origin + (0, 0, self.radius), 1, self);

      if(trace[#"fraction"] === 1 || isDefined(trace[#"entity"])) {
        if(is_true(jump)) {
          self jump_detonate();
        } else {
          self detonate();
        }
      }
    }
  }

  if(isDefined(self.team)) {
    a_enemies = function_f6f34851(self.team);

    if(!isDefined(a_enemies) || a_enemies.size == 0) {
      return;
    }

    a_enemies = arraysortclosest(a_enemies, self.origin, 2, 0, self.settings.detonation_distance);

    foreach(player in a_enemies) {
      if(!isDefined(self.enemy) || player != self.enemy) {
        if(player isnotarget() || !isalive(player) || player laststand::player_is_in_laststand()) {
          continue;
        }

        if(player.ignoreme === 1) {
          continue;
        }

        trace = bulletTrace(self.origin + (0, 0, self.radius), player.origin + (0, 0, self.radius), 1, self);

        if(trace[#"fraction"] === 1 || isDefined(trace[#"entity"])) {
          self detonate();
        }
      }
    }
  }
}

function function_dcecac3c() {
  if(isDefined(self.settings.all_knowing)) {
    if(isDefined(self.enemy)) {
      target_pos = self.enemy.origin;
    }
  } else {
    target_pos = vehicle_ai::gettargetpos(vehicle_ai::getenemytarget());
  }

  enemy = self.enemy;

  if(isDefined(target_pos)) {
    target_pos_onnavmesh = getclosestpointonnavmesh(target_pos, self.settings.detonation_distance * 1.5, self.radius, 4194287);
  }

  if(!isDefined(target_pos_onnavmesh)) {
    if(isDefined(self.enemy) && issentient(self.enemy)) {
      self setpersonalthreatbias(self.enemy, -2000, 5);
    }

    if(isDefined(self.current_pathto_pos)) {
      target_pos_onnavmesh = getclosestpointonnavmesh(self.current_pathto_pos, self.settings.detonation_distance * 2, self.settings.detonation_distance * 1.5, 4194287);
    }

    if(isDefined(target_pos_onnavmesh)) {
      return target_pos_onnavmesh;
    } else {
      return self.current_pathto_pos;
    }
  } else if(isDefined(self.enemy) && issentient(self.enemy)) {
    if(distancesquared(target_pos, target_pos_onnavmesh) > sqr(self.settings.detonation_distance * 0.9)) {
      self setpersonalthreatbias(self.enemy, -2000, 5);
    }
  }

  if(isDefined(enemy) && isPlayer(enemy)) {
    enemy_vel_offset = enemy getvelocity() * 0.5;
    enemy_look_dir_offset = anglesToForward(enemy.angles);

    if(distance2dsquared(self.origin, enemy.origin) > sqr(500)) {
      enemy_look_dir_offset *= 110;
    } else {
      enemy_look_dir_offset *= 35;
    }

    offset = enemy_vel_offset + enemy_look_dir_offset;
    offset = (offset[0], offset[1], 0);

    if(tracepassedonnavmesh(target_pos_onnavmesh, target_pos + offset)) {
      target_pos += offset;
    } else {
      target_pos = target_pos_onnavmesh;
    }
  } else {
    target_pos = target_pos_onnavmesh;
  }

  return target_pos;
}

function path_update_interrupt() {
  self endon(#"death", #"change_state", #"near_goal", #"reached_end_node");
  self notify(#"path_update_interrupt");
  self endon(#"path_update_interrupt");
  wait 0.1;

  while(true) {
    if(isDefined(self.current_pathto_pos)) {
      if(distance2dsquared(self.current_pathto_pos, self.goalpos) > sqr(self.goalradius)) {
        wait 0.5;
        self notify(#"near_goal");
      }

      targetpos = function_dcecac3c();

      if(isDefined(targetpos)) {
        if(distancesquared(self.origin, targetpos) > sqr(400)) {
          repath_range = self.settings.repath_range * 2;
          wait 0.1;
        } else {
          repath_range = self.settings.repath_range;
        }

        if(distance2dsquared(self.current_pathto_pos, targetpos) > sqr(repath_range)) {
          if(isDefined(self.sndalias) && isDefined(self.sndalias[#"direction"])) {
            self playSound(self.sndalias[#"direction"]);
          }

          self notify(#"near_goal");
        }
      }

      if(isDefined(self.enemy) && isPlayer(self.enemy) && !isDefined(self.slow_trigger)) {
        forward = anglesToForward(self.enemy getplayerangles());
        var_d3d5462f = self.origin - self.enemy.origin;
        speedtouse = self.settings.defaultmovespeed;

        if(vectordot(forward, var_d3d5462f) > 0) {
          self setspeed(speedtouse);
        } else {
          self setspeed(speedtouse * 0.75);
        }
      } else {
        speedtouse = self.settings.defaultmovespeed;
        self setspeed(speedtouse);
      }

      wait 0.2;
      continue;
    }

    wait 0.4;
  }
}

function function_bf16c9ed(einflictor, eattacker, smeansofdeath, weapon) {
  if(isDefined(self.owner) && eattacker == self.owner && isDefined(self.settings.friendly_fire) && int(self.settings.friendly_fire) && !weapon.isemp) {
    return true;
  }

  if(isDefined(eattacker) && isDefined(eattacker.archetype) && eattacker.archetype != # "bot" && isDefined(smeansofdeath) && smeansofdeath == "MOD_EXPLOSIVE") {
    return true;
  }

  return false;
}

function detonate_sides(einflictor) {
  forward_direction = anglesToForward(self.angles);
  up_direction = anglestoup(self.angles);
  origin = self.origin + vectorscale(up_direction, 15);
  right_direction = vectorcross(forward_direction, up_direction);
  right_direction = vectornormalize(right_direction);
  left_direction = vectorscale(right_direction, -1);
  einflictor cylinderdamage(vectorscale(right_direction, 140), origin, 15, 50, self.radiusdamagemax, self.radiusdamagemax / 5, self, "MOD_EXPLOSIVE", self.turretweapon);
  einflictor cylinderdamage(vectorscale(left_direction, 140), origin, 15, 50, self.radiusdamagemax, self.radiusdamagemax / 5, self, "MOD_EXPLOSIVE", self.turretweapon);
}

function function_ec8d8bbc(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(self.drop_deploying === 1 && modelindex == "MOD_TRIGGER_HURT" && (!isDefined(self.hurt_trigger_immune_end_time) || gettime() < self.hurt_trigger_immune_end_time)) {
    return 0;
  }

  if(isDefined(psoffsettime) && isDefined(psoffsettime.archetype) && psoffsettime.archetype != # "bot" && isDefined(modelindex) && modelindex == "MOD_EXPLOSIVE") {
    if(psoffsettime != self && isDefined(vsurfacenormal) && lengthsquared(vsurfacenormal) > 0.1 && (!isDefined(psoffsettime) || psoffsettime.team === self.team) && (!isDefined(vdamageorigin) || vdamageorigin.team === self.team)) {
      self setvehvelocity(self.velocity + vectornormalize(vsurfacenormal) * 300);
      return 1;
    }
  }

  if(vehicle_ai::should_emp(self, partname, modelindex, vdamageorigin, psoffsettime)) {
    minempdowntime = 0.8 * self.settings.empdowntime;
    maxempdowntime = 1.2 * self.settings.empdowntime;
    self notify(#"emped", {
      #param0: randomfloatrange(minempdowntime, maxempdowntime), #param1: psoffsettime, #pararm2: vdamageorigin
    });
  }

  if(vehicle_ai::should_burn(self, partname, modelindex, vdamageorigin, psoffsettime)) {
    self thread vehicle_ai::burning_thread(psoffsettime, vdamageorigin);
  }

  return damagefromunderneath;
}

function force_get_enemies() {
  foreach(player in level.players) {
    if(self util::isenemyplayer(player) && !player.ignoreme) {
      self getperfectinfo(player);
      return;
    }
  }
}

function sndfunctions() {
  if(self isdrivableplayervehicle()) {
    self thread function_dd7a181d();
    return;
  }

  self thread function_2a91d5ee();

  if(sessionmodeiscampaigngame() || sessionmodeiszombiesgame()) {
    self thread function_12857be3();
  }
}

function function_dd7a181d() {
  self endon(#"death");

  while(true) {
    self waittill(#"veh_landed");

    if(isDefined(self.sndalias[#"land"])) {
      self playSound(self.sndalias[#"land"]);
    }
  }
}

function function_2a91d5ee() {
  self endon(#"death");

  if(!sessionmodeiscampaigngame() && !sessionmodeiszombiesgame()) {
    self waittill(#"veh_landed");
  }

  while(true) {
    self waittill(#"veh_inair");

    if(isDefined(self.sndalias[#"inair"])) {
      self playSound(self.sndalias[#"inair"]);
    }

    self waittill(#"veh_landed");

    if(isDefined(self.sndalias[#"land"])) {
      self playSound(self.sndalias[#"land"]);
    }
  }
}

function function_12857be3() {
  self endon(#"death");
  wait randomfloatrange(0.25, 1.5);

  if(isDefined(self.sndalias[#"spawn"])) {
    if(isDefined(self.enemy) && isDefined(self.enemy.team)) {
      foreach(player in level.players) {
        if(player.team == self.enemy.team) {
          self playsoundtoplayer(self.sndalias[#"spawn"], player);
        }
      }

      return;
    }

    self playSound(self.sndalias[#"spawn"]);
  }
}

function isdrivableplayervehicle() {
  str_vehicletype = self.vehicletype;

  if(isDefined(str_vehicletype) && self.isplayervehicle) {
    return true;
  }

  return false;
}

function do_death_fx() {
  self vehicle::do_death_dynents();
  self clientfield::set("deathfx", 1);
}