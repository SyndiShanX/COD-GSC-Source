/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\vehicles\_wasp.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\math_shared;
#using scripts\shared\statemachine_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_death_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace wasp;

function autoexec __init__sytem__() {
  system::register("wasp", & __init__, undefined, undefined);
}

function __init__() {
  vehicle::add_main_callback("wasp", & wasp_initialize);
  clientfield::register("vehicle", "rocket_wasp_hijacked", 1, 1, "int");
}

function wasp_initialize() {
  self useanimtree($generic);
  target_set(self, (0, 0, 0));
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  self enableaimassist();
  self setneargoalnotifydist(40);
  self sethoverparams(50, 100, 100);
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.vehaircraftcollisionenabled = 1;
  assert(isDefined(self.scriptbundlesettings));
  self.settings = struct::get_script_bundle("vehiclecustomsettings", self.scriptbundlesettings);
  self.goalradius = 999999;
  self.goalheight = 999999;
  self setgoal(self.origin, 0, self.goalradius, self.goalheight);
  self.variant = "mg";
  if(issubstr(self.vehicletype, "rocket")) {
    self.variant = "rocket";
  }
  self.overridevehicledamage = & drone_callback_damage;
  self.allowfriendlyfiredamageoverride = & drone_allowfriendlyfiredamage;
  self thread vehicle_ai::nudge_collision();
  if(isDefined(level.vehicle_initializer_cb)) {
    [[level.vehicle_initializer_cb]](self);
  }
  if(self.variant === "rocket") {
    self.ignorefirefly = 1;
    self vehicle_ai::initthreatbias();
  }
  init_guard_points();
  defaultrole();
}

function defaultrole() {
  self vehicle_ai::init_state_machine_for_role("default");
  self vehicle_ai::get_state_callbacks("combat").enter_func = & state_combat_enter;
  self vehicle_ai::get_state_callbacks("combat").update_func = & state_combat_update;
  self vehicle_ai::get_state_callbacks("death").update_func = & state_death_update;
  self vehicle_ai::get_state_callbacks("driving").update_func = & wasp_driving;
  self vehicle_ai::get_state_callbacks("emped").update_func = & state_emped_update;
  self vehicle_ai::add_state("guard", & state_guard_enter, & state_guard_update, & state_guard_exit);
  vehicle_ai::add_utility_connection("combat", "guard", & state_guard_can_enter);
  vehicle_ai::add_utility_connection("guard", "combat");
  vehicle_ai::add_interrupt_connection("guard", "emped", "emped");
  vehicle_ai::add_interrupt_connection("guard", "surge", "surge");
  vehicle_ai::add_interrupt_connection("guard", "off", "shut_off");
  vehicle_ai::add_interrupt_connection("guard", "pain", "pain");
  vehicle_ai::add_interrupt_connection("guard", "driving", "enter_vehicle");
  vehicle_ai::startinitialstate("combat");
}

function state_death_update(params) {
  self endon("death");
  if(isarray(self.followers)) {
    foreach(follower in self.followers) {
      if(isDefined(follower)) {
        follower.leader = undefined;
      }
    }
  }
  death_type = vehicle_ai::get_death_type(params);
  if(!isDefined(death_type) && isDefined(params)) {
    if(isDefined(params.weapon)) {
      if(params.weapon.doannihilate) {
        death_type = "gibbed";
      } else if(params.weapon.dogibbing && isDefined(params.attacker)) {
        dist = distance(self.origin, params.attacker.origin);
        if(dist < params.weapon.maxgibdistance) {
          gib_chance = 1 - (dist / params.weapon.maxgibdistance);
          if(randomfloatrange(0, 2) < gib_chance) {
            death_type = "gibbed";
          }
        }
      }
    }
    if(isDefined(params.meansofdeath)) {
      meansofdeath = params.meansofdeath;
      if(meansofdeath === "MOD_EXPLOSIVE" || meansofdeath === "MOD_GRENADE_SPLASH" || meansofdeath === "MOD_PROJECTILE_SPLASH" || meansofdeath === "MOD_PROJECTILE") {
        death_type = "gibbed";
      }
    }
  }
  if(!isDefined(death_type)) {
    crash_style = randomint(3);
    switch (crash_style) {
      case 0: {
        if(self.hijacked === 1) {
          params.death_type = "gibbed";
          vehicle_ai::defaultstate_death_update(params);
        } else {
          vehicle_death::barrel_rolling_crash();
        }
        break;
      }
      case 1: {
        vehicle_death::plane_crash();
        break;
      }
      default: {
        vehicle_death::random_crash(params.vdir);
      }
    }
    self vehicle_death::deletewhensafe();
  } else {
    params.death_type = death_type;
    vehicle_ai::defaultstate_death_update(params);
  }
}

function state_emped_update(params) {
  self endon("death");
  self endon("change_state");
  wait(0.05);
  gravity = 400;
  self notify("end_nudge_collision");
  empdowntime = params.notify_param[0];
  assert(isDefined(empdowntime));
  vehicle_ai::cooldown("emped_timer", empdowntime);
  wait(randomfloat(0.2));
  ang_vel = self getangularvelocity();
  pitch_vel = math::randomsign() * randomfloatrange(200, 250);
  yaw_vel = math::randomsign() * randomfloatrange(200, 250);
  roll_vel = math::randomsign() * randomfloatrange(200, 250);
  ang_vel = ang_vel + (pitch_vel, yaw_vel, roll_vel);
  self setangularvelocity(ang_vel);
  if(ispointinnavvolume(self.origin, "navvolume_small")) {
    self.position_before_fall = self.origin;
  }
  self cancelaimove();
  self setphysacceleration((0, 0, gravity * -1));
  killonimpact_speed = self.settings.killonimpact_speed;
  if(self.health <= 20) {
    killonimpact_speed = 1;
  }
  self fall_and_bounce(killonimpact_speed, self.settings.killonimpact_time);
  self notify("landed");
  self setvehvelocity((0, 0, 0));
  self setphysacceleration((0, 0, (gravity * -1) * 0.1));
  self setangularvelocity((0, 0, 0));
  while(!vehicle_ai::iscooldownready("emped_timer")) {
    timeleft = max(vehicle_ai::getcooldownleft("emped_timer"), 0.5);
    wait(timeleft);
  }
  self.abnormal_status.emped = 0;
  self vehicle::toggle_emp_fx(0);
  self vehicle_ai::emp_startup_fx();
  bootup_timer = 1.6;
  while(bootup_timer > 0) {
    self vehicle::lights_on();
    wait(0.4);
    self vehicle::lights_off();
    wait(0.4);
    bootup_timer = bootup_timer - 0.8;
  }
  self vehicle::lights_on();
  if(isDefined(self.position_before_fall)) {
    originoffset = vectorscale((0, 0, 1), 5);
    goalpoint = self getclosestpointonnavvolume(self.origin + originoffset, 50);
    if(isDefined(goalpoint) && sighttracepassed(self.origin + originoffset, goalpoint, 0, self)) {
      self setvehgoalpos(goalpoint, 0, 0);
      self util::waittill_any_timeout(0.3, "near_goal", "goal", "change_state", "death");
      if(isDefined(self.enemy)) {
        self setlookatent(self.enemy);
      }
      starttime = gettime();
      self.current_pathto_pos = self.position_before_fall;
      foundgoal = self setvehgoalpos(self.current_pathto_pos, 1, 1);
      while(!foundgoal && vehicle_ai::timesince(starttime) < 3) {
        foundgoal = self setvehgoalpos(self.current_pathto_pos, 1, 1);
        wait(0.3);
      }
      if(foundgoal) {
        self util::waittill_any_timeout(1, "near_goal", "goal", "change_state", "death");
      } else {
        self setvehgoalpos(self.origin, 1, 0);
      }
      wait(1);
      self.position_before_fall = undefined;
      self vehicle_ai::evaluate_connections();
    }
  }
  self vehicle::lights_off();
}

function fall_and_bounce(killonimpact_speed, killonimpact_time) {
  self endon("death");
  self endon("change_state");
  maxbouncetime = 3;
  bouncescale = 0.3;
  velocityloss = 0.3;
  maxangle = 12;
  bouncedtime = 0;
  angularvelstablizeparams = (0.3, 0.5, 0.2);
  anglesstablizeinitialscale = 0.6;
  anglesstablizeincrement = 0.2;
  fallstart = gettime();
  while(bouncedtime < maxbouncetime && lengthsquared(self.velocity) > (10 * 10)) {
    self waittill("veh_collision", impact_vel, normal);
    if(lengthsquared(impact_vel) > (killonimpact_speed * killonimpact_speed) || (vehicle_ai::timesince(fallstart) > killonimpact_time && lengthsquared(impact_vel) > (killonimpact_speed * 0.8) * (killonimpact_speed * 0.8))) {
      self kill();
    } else {
      if(!isDefined(self.position_before_fall)) {
        self kill();
      } else {
        fallstart = gettime();
      }
    }
    oldvelocity = self.velocity;
    vel_hitdir = vectorprojection(impact_vel, normal) * -1;
    vel_hitdirup = vectorprojection(vel_hitdir, (0, 0, 1));
    velscale = min(bouncescale * (bouncedtime + 1), 0.9);
    newvelocity = (oldvelocity - vectorprojection(oldvelocity, vel_hitdir)) * (1 - velocityloss);
    newvelocity = newvelocity + (vel_hitdir * velscale);
    shouldbounce = vectordot(normal, (0, 0, 1)) > 0.76;
    if(shouldbounce) {
      velocitylengthsqr = lengthsquared(newvelocity);
      stablizescale = mapfloat(5 * 5, 60 * 60, 0.1, 1, velocitylengthsqr);
      ang_vel = self getangularvelocity();
      ang_vel = ang_vel * (angularvelstablizeparams * stablizescale);
      self setangularvelocity(ang_vel);
      angles = self.angles;
      anglesstablizescale = min(anglesstablizeinitialscale - (bouncedtime * anglesstablizeincrement), 0.1);
      pitch = angles[0];
      yaw = angles[1];
      roll = angles[2];
      surfaceangles = vectortoangles(normal);
      surfaceroll = surfaceangles[2];
      if(pitch < (maxangle * -1) || pitch > maxangle) {
        pitch = pitch * anglesstablizescale;
      }
      if(roll < (surfaceroll - maxangle) || roll > (surfaceroll + maxangle)) {
        roll = lerpfloat(surfaceroll, roll, anglesstablizescale);
      }
      self.angles = (pitch, yaw, roll);
    }
    self setvehvelocity(newvelocity);
    self vehicle_ai::collision_fx(normal);
    if(shouldbounce) {
      bouncedtime++;
    }
  }
}

function init_guard_points() {
  self._guard_points = [];
  if(!isDefined(self._guard_points)) {
    self._guard_points = [];
  } else if(!isarray(self._guard_points)) {
    self._guard_points = array(self._guard_points);
  }
  self._guard_points[self._guard_points.size] = (150, -110, 110);
  if(!isDefined(self._guard_points)) {
    self._guard_points = [];
  } else if(!isarray(self._guard_points)) {
    self._guard_points = array(self._guard_points);
  }
  self._guard_points[self._guard_points.size] = (150, 110, 110);
  if(!isDefined(self._guard_points)) {
    self._guard_points = [];
  } else if(!isarray(self._guard_points)) {
    self._guard_points = array(self._guard_points);
  }
  self._guard_points[self._guard_points.size] = (120, -110, 80);
  if(!isDefined(self._guard_points)) {
    self._guard_points = [];
  } else if(!isarray(self._guard_points)) {
    self._guard_points = array(self._guard_points);
  }
  self._guard_points[self._guard_points.size] = (120, 110, 80);
  if(!isDefined(self._guard_points)) {
    self._guard_points = [];
  } else if(!isarray(self._guard_points)) {
    self._guard_points = array(self._guard_points);
  }
  self._guard_points[self._guard_points.size] = (180, 0, 140);
}

function guard_points_debug() {
  self endon("death");
  if(self.isdebugdrawing === 1) {
    return;
  }
  self.isdebugdrawing = 1;
  while(true) {
    foreach(point in self.debugpointsarray) {
      color = (1, 0, 0);
      if(ispointinnavvolume(point, "")) {
        color = (0, 1, 0);
      }
      debugstar(point, 5, color);
    }
    wait(0.05);
  }
}

function get_guard_points(owner) {
  assert(self._guard_points.size > 0, "");
  points_array = [];
  foreach(point in self._guard_points) {
    offset = rotatepoint(point, owner.angles);
    worldpoint = (offset + owner.origin) + (owner getvelocity() * 0.5);
    if(ispointinnavvolume(worldpoint, "navvolume_small")) {
      if(!isDefined(points_array)) {
        points_array = [];
      } else if(!isarray(points_array)) {
        points_array = array(points_array);
      }
      points_array[points_array.size] = worldpoint;
    }
  }
  if(points_array.size < 1) {
    queryresult = positionquery_source_navigation(owner.origin + vectorscale((0, 0, 1), 50), 25, 200, 100, 1.2 * self.radius, self);
    positionquery_filter_sight(queryresult, owner.origin + vectorscale((0, 0, 1), 10), (0, 0, 0), self, 3);
    foreach(point in queryresult.data) {
      if(point.visibility === 1 && bullettracepassed(owner.origin + vectorscale((0, 0, 1), 10), point.origin, 0, self, self, 0, 1)) {
        if(!isDefined(points_array)) {
          points_array = [];
        } else if(!isarray(points_array)) {
          points_array = array(points_array);
        }
        points_array[points_array.size] = point.origin;
      }
    }
  }
  return points_array;
}

function state_guard_can_enter(from_state, to_state, connection) {
  if(self.enable_guard !== 1 || !isDefined(self.owner)) {
    return false;
  }
  if(!isDefined(self.enemy) || !self vehseenrecently(self.enemy, 3)) {
    return true;
  }
  if(distancesquared(self.owner.origin, self.enemy.origin) > (1200 * 1200) && distancesquared(self.origin, self.enemy.origin) > (300 * 300)) {
    return true;
  }
  if(!ispointinnavvolume(self.origin, "navvolume_small")) {
    return true;
  }
  return false;
}

function state_guard_enter(params) {
  if(self.enable_target_laser === 1) {
    self laseroff();
  }
  self update_main_guard();
}

function update_main_guard() {
  if(isDefined(self.owner) && !isalive(self.owner.main_guard) || self.owner.main_guard.owner !== self.owner) {
    self.owner.main_guard = self;
  }
}

function state_guard_exit(params) {
  if(isDefined(self.owner) && self.owner.main_guard === self) {
    self.owner.main_guard = undefined;
  }
}

function test_get_back_point(point) {
  if(sighttracepassed(self.origin, point, 0, self)) {
    if(bullettracepassed(self.origin, point, 0, self, self, 0, 1)) {
      return 1;
    }
    return 0;
  }
  return -1;
}

function test_get_back_queryresult(queryresult) {
  getbackpoint = undefined;
  foreach(point in queryresult.data) {
    testresult = test_get_back_point(point.origin);
    if(testresult == 1) {
      return point.origin;
    }
    if(testresult == 0) {
      wait(0.05);
    }
  }
  return undefined;
}

function state_guard_update(params) {
  self endon("death");
  self endon("change_state");
  self sethoverparams(20, 40, 30);
  timenotatgoal = gettime();
  pointindex = 0;
  stuckcount = 0;
  while(true) {
    if(isDefined(self.enemy) && distancesquared(self.owner.origin, self.enemy.origin) < (1000 * 1000) && self vehseenrecently(self.enemy, 1) && ispointinnavvolume(self.origin, "navvolume_small")) {
      self vehicle_ai::evaluate_connections();
      wait(1);
    } else {
      owner = self.owner;
      if(!isDefined(owner)) {
        wait(1);
        continue;
      }
      usepathfinding = 1;
      onnavvolume = ispointinnavvolume(self.origin, "navvolume_small");
      if(!onnavvolume) {
        getbackpoint = undefined;
        pointonnavvolume = self getclosestpointonnavvolume(self.origin, 500);
        if(isDefined(pointonnavvolume)) {
          if(test_get_back_point(pointonnavvolume) == 1) {
            getbackpoint = pointonnavvolume;
          }
        }
        if(!isDefined(getbackpoint)) {
          queryresult = positionquery_source_navigation(self.origin, 0, 1500, 200, 80, self);
          getbackpoint = test_get_back_queryresult(queryresult);
        }
        if(!isDefined(getbackpoint)) {
          queryresult = positionquery_source_navigation(self.origin, 0, 300, 700, 30, self);
          getbackpoint = test_get_back_queryresult(queryresult);
        }
        if(isDefined(getbackpoint)) {
          if(distancesquared(getbackpoint, self.origin) > (20 * 20)) {
            self.current_pathto_pos = getbackpoint;
            usepathfinding = 0;
            self.vehaircraftcollisionenabled = 0;
          } else {
            onnavvolume = 1;
          }
        } else {
          stuckcount++;
          if(stuckcount == 1) {
            stucklocation = self.origin;
          } else if(stuckcount > 10) {
            /
            #
            assert(0, "" + self.origin);
            v_box_min = (self.radius * -1, self.radius * -1, self.radius * -1);
            v_box_max = (self.radius, self.radius, self.radius);
            box(self.origin, v_box_min, v_box_max, self.angles[1], (1, 0, 0), 1, 0, 1000000);
            if(isDefined(stucklocation)) {
              line(stucklocation, self.origin, (1, 0, 0), 1, 1, 1000000);
            }
            self kill();
          }
        }
      }
      if(onnavvolume) {
        self update_main_guard();
        if(owner.main_guard === self) {
          guardpoints = get_guard_points(owner);
          if(guardpoints.size < 1) {
            wait(1);
            continue;
          }
          stuckcount = 0;
          self.vehaircraftcollisionenabled = 1;
          if(guardpoints.size <= pointindex) {
            pointindex = randomint(int(min(self._guard_points.size, guardpoints.size)));
            timenotatgoal = gettime();
          }
          self.current_pathto_pos = guardpoints[pointindex];
        } else {
          main_guard = owner.main_guard;
          if(isalive(main_guard) && isDefined(main_guard.current_pathto_pos)) {
            query_position = main_guard.current_pathto_pos;
            queryresult = positionquery_source_navigation(query_position, 20, 140, 100, 20, self, 15);
            if(queryresult.data.size > 0) {
              self.current_pathto_pos = queryresult.data[queryresult.data.size - 1].origin;
            }
          }
        }
      }
      if(isDefined(self.current_pathto_pos)) {
        distancetogoalsq = distancesquared(self.current_pathto_pos, self.origin);
        if(!onnavvolume || distancetogoalsq > (60 * 60)) {
          if(distancetogoalsq > (600 * 600)) {
            self setspeed(self.settings.defaultmovespeed * 2);
          } else {
            if(distancetogoalsq < (100 * 100)) {
              self setspeed(self.settings.defaultmovespeed * 0.3);
            } else {
              self setspeed(self.settings.defaultmovespeed);
            }
          }
          timenotatgoal = gettime();
        } else {
          if(vehicle_ai::timesince(timenotatgoal) > 4) {
            pointindex = randomint(self._guard_points.size);
            timenotatgoal = gettime();
          }
          wait(0.2);
          continue;
        }
        if(self setvehgoalpos(self.current_pathto_pos, 1, usepathfinding)) {
          self playSound("veh_wasp_direction");
          self clearlookatent();
          self notify("fire_stop");
          self thread path_update_interrupt();
          if(onnavvolume) {
            self vehicle_ai::waittill_pathing_done(1);
          } else {
            self vehicle_ai::waittill_pathing_done();
          }
        } else {
          wait(0.5);
        }
      } else {
        wait(0.5);
      }
    }
  }
}

function state_combat_enter(params) {
  if(self.enable_target_laser === 1) {
    self laseron();
  }
  if(isDefined(self.owner) && isDefined(self.owner.enemy)) {
    self.favoriteenemy = self.owner.enemy;
  }
  self thread turretfireupdate();
}

function turretfireupdate() {
  self endon("death");
  self endon("change_state");
  isrockettype = self.variant === "rocket";
  while(true) {
    if(isDefined(self.enemy) && self vehcansee(self.enemy)) {
      if(distancesquared(self.enemy.origin, self.origin) < ((0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) * 3) * ((0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax)) * 3)) {
        self setlookatent(self.enemy);
        if(isrockettype) {
          self setturrettargetent(self.enemy, (self.enemy getvelocity() * 0.3) - (vehicle_ai::gettargeteyeoffset(self.enemy) * 0.3));
        } else {
          self setturrettargetent(self.enemy, (vehicle_ai::gettargeteyeoffset(self.enemy) * -1) * 0.3);
        }
        startaim = gettime();
        while(!self.turretontarget && vehicle_ai::timesince(startaim) < 3) {
          wait(0.2);
        }
        if(isDefined(self.enemy) && self.turretontarget && self.noshoot !== 1) {
          if(isrockettype) {
            for(i = 0; i < 2 && isDefined(self.enemy); i++) {
              self fireweapon(0, self.enemy);
              fired = 1;
              wait(0.25);
            }
          } else {
            self vehicle_ai::fire_for_time(randomfloatrange(self.settings.turret_fire_burst_min, self.settings.turret_fire_burst_max), 0, self.enemy);
          }
          if(isDefined(self.settings.turret_cooldown_max)) {
            if(!isDefined(self.settings.turret_cooldown_min)) {
              self.settings.turret_cooldown_min = 0;
            }
            wait(randomfloatrange(self.settings.turret_cooldown_min, self.settings.turret_cooldown_max));
          }
        } else if(isDefined(self.settings.turret_enemy_detect_freq)) {
          wait(self.settings.turret_enemy_detect_freq);
        }
        self setturrettargetrelativeangles(vectorscale((1, 0, 0), 15), 0);
      }
      if(isrockettype) {
        if(isDefined(self.enemy) && isai(self.enemy)) {
          wait(randomfloatrange(4, 7));
        } else {
          wait(randomfloatrange(3, 5));
        }
      } else {
        if(isDefined(self.enemy) && isai(self.enemy)) {
          wait(randomfloatrange(2, 2.5));
        } else {
          wait(randomfloatrange(0.5, 1.5));
        }
      }
    } else {
      wait(0.4);
    }
  }
}

function path_update_interrupt() {
  self endon("death");
  self endon("change_state");
  self endon("near_goal");
  self endon("reached_end_node");
  old_enemy = self.enemy;
  wait(1);
  while(true) {
    if(isDefined(self.current_pathto_pos)) {
      if(distance2dsquared(self.current_pathto_pos, self.goalpos) > (self.goalradius * self.goalradius)) {
        wait(0.2);
        self notify("near_goal");
      }
    }
    if(isDefined(self.enemy)) {
      if(self.noshoot !== 1 && self vehcansee(self.enemy)) {
        self setturrettargetent(self.enemy);
        self setlookatent(self.enemy);
      }
      if(!isDefined(old_enemy)) {
        self notify("near_goal");
      } else if(self.enemy != old_enemy) {
        self notify("near_goal");
      }
      if(self vehcansee(self.enemy) && distance2dsquared(self.origin, self.enemy.origin) < (250 * 250)) {
        self notify("near_goal");
      }
    }
    wait(0.2);
  }
}

function wait_till_something_happens(timeout) {
  self endon("change_state");
  self endon("death");
  wait(0.1);
  time = timeout;
  cant_see_count = 0;
  while(time > 0) {
    if(isDefined(self.current_pathto_pos)) {
      if(distancesquared(self.current_pathto_pos, self.goalpos) > (self.goalradius * self.goalradius)) {
        break;
      }
    }
    if(isDefined(self.enemy)) {
      if(!self vehcansee(self.enemy)) {
        cant_see_count++;
        if(cant_see_count >= 3) {
          break;
        }
      } else {
        cant_see_count = 0;
      }
      if(distance2dsquared(self.origin, self.enemy.origin) < (250 * 250)) {
        break;
      }
      goalheight = self.enemy.origin[2] + (0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax));
      distfrompreferredheight = abs(self.origin[2] - goalheight);
      if(distfrompreferredheight > 100) {
        break;
      }
      if(isplayer(self.enemy) && self.enemy islookingat(self)) {
        if(math::cointoss()) {
          wait(randomfloatrange(0.1, 0.5));
        }
        self drop_leader();
        break;
      }
    }
    if(isDefined(self.leader) && isDefined(self.leader.current_pathto_pos)) {
      if(distancesquared(self.origin, self.leader.current_pathto_pos) > (165 * 165)) {
        break;
      }
    }
    wait(0.3);
    time = time - 0.3;
  }
}

function drop_leader() {
  if(isDefined(self.leader)) {
    arrayremovevalue(self.leader.followers, self);
    self.leader = undefined;
  }
}

function update_leader() {
  if(isDefined(self.no_group) && self.no_group == 1) {
    return;
  }
  if(isDefined(self.leader)) {
    return;
  }
  if(isDefined(self.followers)) {
    self.followers = array::remove_dead(self.followers, 0);
    if(self.followers.size > 0) {
      return;
    }
  }
  team_mates = getaiteamarray(self.team);
  foreach(guy in team_mates) {
    if(isDefined(guy.archetype) && guy.archetype == "wasp") {
      if(isDefined(guy.leader)) {
        continue;
      }
      if(guy == self) {
        continue;
      }
      if(distancesquared(self.origin, guy.origin) > (700 * 700)) {
        continue;
      }
      if(!isDefined(guy.followers)) {
        guy.followers = [];
      }
      if(guy.followers.size >= 2) {
        continue;
      }
      guy.followers[guy.followers.size] = self;
      self.leader = guy;
      break;
    }
  }
}

function should_fly_forward(distancetogoalsq) {
  if(self.always_face_enemy === 1) {
    return 0;
  }
  if(distancetogoalsq < (250 * 250)) {
    return 0;
  }
  if(isDefined(self.enemy)) {
    to_goal = vectornormalize(self.current_pathto_pos - self.origin);
    to_enemy = vectornormalize(self.enemy.origin - self.origin);
    dot = vectordot(to_goal, to_enemy);
    if(abs(dot) > 0.7) {
      return 0;
    }
  }
  if(distancetogoalsq > (400 * 400)) {
    return randomint(100) > 25;
  }
  return randomint(100) > 50;
}

function state_combat_update(params) {
  self endon("change_state");
  self endon("death");
  wait(0.1);
  stuckcount = 0;
  for(;;) {
    self setspeed(self.settings.defaultmovespeed);
    self update_leader();
    if(isDefined(self.inpain) && self.inpain) {
      wait(0.1);
      continue;
    }
    if(self.enable_guard === 1) {
      self vehicle_ai::evaluate_connections();
    }
    if(isDefined(self.enemy)) {
      self setturrettargetent(self.enemy);
      self setlookatent(self.enemy);
      self wait_till_something_happens(randomfloatrange(2, 5));
    }
    if(!isDefined(self.enemy)) {
      self clearlookatent();
      aiarray = getaiteamarray("all");
      foreach(ai in aiarray) {
        self getperfectinfo(ai);
      }
      players = getplayers("all");
      foreach(player in players) {
        self getperfectinfo(player);
      }
      wait(1);
    }
    usepathfinding = 1;
    onnavvolume = ispointinnavvolume(self.origin, "navvolume_small");
    if(!onnavvolume) {
      getbackpoint = undefined;
      if(self.aggresive_navvolume_recover === 1) {
        self vehicle_ai::evaluate_connections();
      }
      pointonnavvolume = self getclosestpointonnavvolume(self.origin, 100);
      if(isDefined(pointonnavvolume)) {
        if(sighttracepassed(self.origin, pointonnavvolume, 0, self)) {
          getbackpoint = pointonnavvolume;
        }
      }
      if(!isDefined(getbackpoint)) {
        queryresult = positionquery_source_navigation(self.origin, 0, 200, 100, 2 * self.radius, self);
        positionquery_filter_sight(queryresult, self.origin, (0, 0, 0), self, 1);
        getbackpoint = undefined;
        foreach(point in queryresult.data) {
          if(point.visibility === 1) {
            getbackpoint = point.origin;
            break;
          }
        }
      }
      if(isDefined(getbackpoint)) {
        self.current_pathto_pos = getbackpoint;
        usepathfinding = 0;
      } else {
        stuckcount++;
        if(stuckcount == 1) {
          stucklocation = self.origin;
        } else if(stuckcount > 10) {
          /
          #
          assert(0, "" + self.origin);
          v_box_min = (self.radius * -1, self.radius * -1, self.radius * -1);
          v_box_max = (self.radius, self.radius, self.radius);
          box(self.origin, v_box_min, v_box_max, self.angles[1], (1, 0, 0), 1, 0, 1000000);
          if(isDefined(stucklocation)) {
            line(stucklocation, self.origin, (1, 0, 0), 1, 1, 1000000);
          }
          self kill();
        }
      }
    } else {
      stuckcount = 0;
      if(self.goalforced) {
        goalpos = self getclosestpointonnavvolume(self.goalpos, 100);
        if(isDefined(goalpos)) {
          self.current_pathto_pos = goalpos;
          usepathfinding = 1;
        } else {
          self.current_pathto_pos = self.goalpos;
          usepathfinding = 0;
        }
      } else {
        if(isDefined(self.enemy)) {
          self.current_pathto_pos = getnextmoveposition_tactical();
          usepathfinding = 1;
        } else {
          self.current_pathto_pos = getnextmoveposition_wander();
          usepathfinding = 1;
        }
      }
    }
    if(isDefined(self.current_pathto_pos)) {
      distancetogoalsq = distancesquared(self.current_pathto_pos, self.origin);
      if(!onnavvolume || distancetogoalsq > (75 * 75)) {
        if(distancetogoalsq > (2000 * 2000)) {
          self setspeed(self.settings.defaultmovespeed * 2);
        }
        if(self setvehgoalpos(self.current_pathto_pos, 1, usepathfinding)) {
          if(isDefined(self.enemy)) {
            self playSound("veh_wasp_direction");
          } else {
            self playSound("veh_wasp_vox");
          }
          if(should_fly_forward(distancetogoalsq)) {
            self clearlookatent();
            self notify("fire_stop");
            self.noshoot = 1;
          }
          self thread path_update_interrupt();
          self vehicle_ai::waittill_pathing_done();
          self.noshoot = undefined;
        }
      }
    }
  }
}

function getnextmoveposition_wander() {
  querymultiplier = 1;
  queryresult = positionquery_source_navigation(self.origin, 80, 500 * querymultiplier, 130, (3 * self.radius) * querymultiplier, self, self.radius * querymultiplier);
  positionquery_filter_distancetogoal(queryresult, self);
  vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
  self.isonnav = queryresult.centeronnav;
  best_point = undefined;
  best_score = -999999;
  foreach(point in queryresult.data) {
    randomscore = randomfloatrange(0, 100);
    disttooriginscore = point.disttoorigin2d * 0.2;
    point.score = point.score + (randomscore + disttooriginscore);
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = disttooriginscore;
    point.score = point.score + disttooriginscore;
    if(point.score > best_score) {
      best_score = point.score;
      best_point = point;
    }
  }
  self vehicle_ai::positionquery_debugscores(queryresult);
  if(!isDefined(best_point)) {
    return undefined;
  }
  return best_point.origin;
}

function getnextmoveposition_tactical() {
  if(!isDefined(self.enemy)) {
    return self getnextmoveposition_wander();
  }
  selfdisttotarget = distance2d(self.origin, self.enemy.origin);
  gooddist = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
  closedist = 1.2 * gooddist;
  fardist = 3 * gooddist;
  querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttotarget);
  preferedheightrange = 35;
  randomness = 30;
  avoid_locations = [];
  avoid_radius = 50;
  if(isalive(self.leader) && isDefined(self.leader.current_pathto_pos)) {
    query_position = self.leader.current_pathto_pos;
    queryresult = positionquery_source_navigation(query_position, 0, 140, 100, 35, self, 25);
  } else {
    if(isalive(self.owner) && self.enable_guard === 1) {
      ownerorigin = self getclosestpointonnavvolume(self.owner.origin + vectorscale((0, 0, 1), 40), 50);
      if(isDefined(ownerorigin)) {
        queryresult = positionquery_source_navigation(ownerorigin, 0, 500 * min(querymultiplier, 1.5), 130, 3 * self.radius, self);
        if(isDefined(queryresult) && isDefined(queryresult.data)) {
          positionquery_filter_sight(queryresult, self.owner getEye(), (0, 0, 0), self, 5, self, "visowner");
          positionquery_filter_sight(queryresult, self.enemy getEye(), (0, 0, 0), self, 5, self, "visenemy");
          foreach(point in queryresult.data) {
            if(point.visowner === 1) {
              if(!isDefined(point._scoredebug)) {
                point._scoredebug = [];
              }
              point._scoredebug[""] = 300;
              point.score = point.score + 300;
            }
            if(point.visenemy === 1) {
              if(!isDefined(point._scoredebug)) {
                point._scoredebug = [];
              }
              point._scoredebug[""] = 300;
              point.score = point.score + 300;
            }
          }
        }
      }
    } else {
      queryresult = positionquery_source_navigation(self.origin, 0, 500 * min(querymultiplier, 2), 130, (3 * self.radius) * querymultiplier, self, (2.2 * self.radius) * querymultiplier);
      team_mates = getaiteamarray(self.team);
      avoid_radius = 140;
      foreach(guy in team_mates) {
        if(isDefined(guy.archetype) && guy.archetype == "wasp") {
          if(isDefined(guy.followers) && guy.followers.size > 0 && guy != self) {
            if(isDefined(guy.current_pathto_pos)) {
              avoid_locations[avoid_locations.size] = guy.current_pathto_pos;
            }
          }
        }
      }
    }
  }
  if(!isDefined(queryresult) || !isDefined(queryresult.data) || queryresult.data.size == 0) {
    return undefined;
  }
  positionquery_filter_distancetogoal(queryresult, self);
  positionquery_filter_inclaimedlocation(queryresult, self);
  self vehicle_ai::positionquery_filter_outofgoalanchor(queryresult);
  self vehicle_ai::positionquery_filter_engagementdist(queryresult, self.enemy, self.settings.engagementdistmin, self.settings.engagementdistmax);
  self vehicle_ai::positionquery_filter_engagementheight(queryresult, self.enemy, self.settings.engagementheightmin, self.settings.engagementheightmax);
  best_point = undefined;
  best_score = -999999;
  foreach(point in queryresult.data) {
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = randomfloatrange(0, randomness);
    point.score = point.score + randomfloatrange(0, randomness);
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = point.distawayfromengagementarea * -1;
    point.score = point.score + (point.distawayfromengagementarea * -1);
    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }
    point._scoredebug[""] = (point.distengagementheight * -1) * 1.4;
    point.score = point.score + ((point.distengagementheight * -1) * 1.4);
    if(point.disttoorigin2d < 120) {
      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }
      point._scoredebug[""] = (120 - point.disttoorigin2d) * -1.5;
      point.score = point.score + ((120 - point.disttoorigin2d) * -1.5);
    }
    foreach(location in avoid_locations) {
      if(distancesquared(point.origin, location) < (avoid_radius * avoid_radius)) {
        if(!isDefined(point._scoredebug)) {
          point._scoredebug = [];
        }
        point._scoredebug[""] = avoid_radius * -1;
        point.score = point.score + (avoid_radius * -1);
      }
    }
    if(point.inclaimedlocation) {
      if(!isDefined(point._scoredebug)) {
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
  if(!isDefined(best_point)) {
    return undefined;
  }
  if(isDefined(getdvarint("")) && getdvarint("")) {
    recordline(self.origin, best_point.origin, (0.3, 1, 0));
    recordline(self.origin, self.enemy.origin, (1, 0, 0.4));
  }
  return best_point.origin;
}

function drone_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  idamage = vehicle_ai::shared_callback_damage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  return idamage;
}

function drone_allowfriendlyfiredamage(einflictor, eattacker, smeansofdeath, weapon) {
  if(isDefined(eattacker) && isDefined(eattacker.archetype) && isDefined(smeansofdeath) && eattacker.archetype == "wasp" && smeansofdeath == "MOD_EXPLOSIVE") {
    return true;
  }
  return false;
}

function wasp_driving(params) {
  self endon("change_state");
  driver = self getseatoccupant(0);
  if(isplayer(driver)) {
    clientfield::set("rocket_wasp_hijacked", 1);
  }
  if(isplayer(driver) && isDefined(self.playerdrivenversion)) {
    self thread wasp_manage_camera_swaps();
  }
}

function wasp_manage_camera_swaps() {
  self endon("death");
  self endon("change_state");
  driver = self getseatoccupant(0);
  driver endon("disconnect");
  cam_low_type = self.vehicletype;
  cam_high_type = self.playerdrivenversion;
}