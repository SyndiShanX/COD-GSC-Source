/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_4f320724b79a7e18.gsc
***********************************************/

#using scripts\core_common\ai\systems\ai_interface;
#using scripts\core_common\ai_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_death_shared;
#using scripts\core_common\vehicle_shared;
#namespace hind;

function private autoexec __init__system__() {
  system::register(#"armada_hind", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  vehicle::add_main_callback("armada_hind", &function_1f03ae98);
}

function function_a6337662() {
  self.missiletags = [];

  if(!isDefined(self.missiletags)) {
    self.missiletags = [];
  } else if(!isarray(self.missiletags)) {
    self.missiletags = array(self.missiletags);
  }

  self.missiletags[self.missiletags.size] = "tag_flash1";

  if(!isDefined(self.missiletags)) {
    self.missiletags = [];
  } else if(!isarray(self.missiletags)) {
    self.missiletags = array(self.missiletags);
  }

  self.missiletags[self.missiletags.size] = "tag_flash3";

  if(!isDefined(self.missiletags)) {
    self.missiletags = [];
  } else if(!isarray(self.missiletags)) {
    self.missiletags = array(self.missiletags);
  }

  self.missiletags[self.missiletags.size] = "tag_flash2";
}

function function_1f03ae98() {
  self endon(#"death");
  self useanimtree("generic");
  vehicle::make_targetable(self, (0, 0, 0));
  ai::createinterfaceforentity(self);
  self.health = self.healthdefault;
  self vehicle::friendly_fire_shield();
  self setneargoalnotifydist(64);
  self sethoverparams(15, 100, 40);
  self.flyheight = getdvarfloat(#"g_quadrotorflyheight", 0);
  self.fovcosine = 0;
  self.fovcosinebusy = 0.574;
  self.vehaircraftcollisionenabled = 1;
  self.original_vehicle_type = self.vehicletype;
  self.settings = getscriptbundle(self.scriptbundlesettings);
  self.var_ec0d66ce = 0.5 * (self.settings.engagementdistmin + self.settings.engagementdistmax);
  self.var_ff6d7c88 = sqr(self.var_ec0d66ce);
  accel = self getdefaultacceleration();
  self.var_442fce01 = 1 * accel;
  self.var_f13adcf8 = 1 * self.settings.defaultmovespeed;
  self function_a6337662();
  self.overridevehicledamage = &function_9dd28496;
  self thread vehicle_ai::nudge_collision();

  if(isDefined(level.vehicle_initializer_cb)) {
    [[level.vehicle_initializer_cb]](self);
  }

  self turret::_init_turret(1);
  self turret::set_burst_parameters(1, 2, 1, 2, 1);
  self turret::_init_turret(2);
  self turret::_init_turret(3);
  self setrotorspeed(1);
  defaultrole();
}

function defaultrole() {
  self vehicle_ai::init_state_machine_for_role();
  self vehicle_ai::get_state_callbacks("combat").enter_func = &state_combat_enter;
  self vehicle_ai::get_state_callbacks("combat").update_func = &state_combat_update;
  self vehicle_ai::get_state_callbacks("combat").exit_func = &state_combat_exit;
  self vehicle_ai::get_state_callbacks("driving").enter_func = &function_3929047b;
  self vehicle_ai::get_state_callbacks("scripted").enter_func = &function_3929047b;
  self vehicle_ai::get_state_callbacks("death").enter_func = &state_death_enter;
  self vehicle_ai::get_state_callbacks("death").update_func = &state_death_update;
  vehicle_ai::startinitialstate();
}

function shut_off_fx() {
  self endon(#"death");
  self notify(#"death_shut_off");

  if(isDefined(self.frontscanner)) {
    self.frontscanner.sndscanningent delete();
    self.frontscanner delete();
  }
}

function state_death_enter(params) {
  self endon(#"death");

  if(isDefined(self.faketargetent)) {
    self.faketargetent delete();
  }

  vehicle_ai::defaultstate_death_enter();
  self.inpain = 1;
  self thread shut_off_fx();
}

function state_death_update(params) {
  self endon(#"death");
  playFXOnTag(#"hash_6ca050a42ba76baa", self, "tag_body");
  playFXOnTag(#"hash_1a0d6a6745ac6af", self, "tag_body");
  self setphysacceleration((0, 0, -300));
  self.vehcheckforpredictedcrash = 1;
  forward = anglesToForward(self.angles);
  forward_mag = randomfloatrange(0, 300);
  forward_mag += math::sign(forward_mag) * 400;
  forward *= forward_mag;
  new_vel = forward + self.velocity * 0.75;
  ang_vel = self getangularvelocity();
  yaw_vel = randomfloatrange(0, 130) * math::sign(ang_vel[1]);
  yaw_vel += math::sign(yaw_vel) * 20;
  ang_vel = (randomfloatrange(-1, 1), yaw_vel, 0);
  roll_amount = abs(ang_vel[1]) / 150 * 30;

  if(ang_vel[1] > 0) {
    roll_amount *= -1;
  }

  self.angles = (self.angles[0], self.angles[1], roll_amount);
  ang_vel = (ang_vel[0], ang_vel[1], roll_amount * 0.9);
  self.velocity_rotation_frac = 1;
  self.crash_accel = randomfloatrange(65, 90);
  self setvehvelocity(new_vel);
  self setangularvelocity(ang_vel);
  self thread vehicle_ai::nudge_collision();
  self vehicle::toggle_sounds(0);
  wait 2;
  vehicle_ai::gibbed_death(params);
}

function function_ec878580() {
  getbackpoint = undefined;
  pointonnavvolume = self getclosestpointonnavvolume(self.origin, 600);

  if(isDefined(pointonnavvolume)) {
    if(sighttracepassed(self.origin, pointonnavvolume, 0, self)) {
      getbackpoint = pointonnavvolume;
    }
  }

  if(!isDefined(getbackpoint)) {
    queryresult = positionquery_source_navigation(self.origin, 0, 1200, 1000, self.radius, self);
    positionquery_filter_sight(queryresult, self.origin, (0, 0, 0), self, 1);
    getbackpoint = undefined;

    foreach(point in queryresult.data) {
      if(point.visibility === 1) {
        getbackpoint = point.origin;
        break;
      }
    }
  }

  return getbackpoint;
}

function disable_turrets() {
  self turret::disable(1);
  self turret::disable(2);
  self turret::disable(3);
}

function state_combat_enter(params) {
  accel = self getdefaultacceleration();
  self setspeed(1 * self.settings.defaultmovespeed, 1 * accel, 1 * accel);
}

function function_24ec919c() {
  self endon(#"death");

  while(true) {
    struct = self waittill(#"gunner_weapon_fired");

    if(struct.gunner_index == 2 || struct.gunner_index == 3) {
      struct.projectiles[0] thread function_abdb5689(self.enemy);
    }
  }
}

function function_abdb5689(enemy) {
  self endon(#"death");

  while(isDefined(enemy)) {
    if(distancesquared(self.origin, enemy.origin) < 1440000) {
      playrumbleonposition("armada_rocket_flyby", self.origin);
      wait 0.15;
      continue;
    }

    waitframe(1);
  }
}

function state_combat_update(params) {
  self endon(#"change_state", #"death");
  self thread attack_thread_mainturret();
  self thread attack_thread_rocket();
  self thread function_24ec919c();
  stuckcount = 0;

  for(;;) {
    goalpos = function_b1bd875a();

    if(isDefined(goalpos)) {
      self setspeed(self.settings.defaultmovespeed, 5, 5);
      onnavvolume = ispointinnavvolume(self.origin, "navvolume_big");

      if(!onnavvolume && !self isplayinganimscripted()) {
        getbackpoint = self function_ec878580();
        self.vehaircraftcollisionenabled = 0;

        if(isDefined(getbackpoint)) {
          if(self function_a57c34b7(getbackpoint, 1, 0)) {
            self waittilltimeout(10, #"near_goal");
          }
        } else {
          stuckcount++;

          if(stuckcount == 1) {
            stucklocation = self.origin;
          } else if(stuckcount > 10) {
            v_box_min = (self.radius * -1, self.radius * -1, self.radius * -1);
            v_box_max = (self.radius, self.radius, self.radius);
            box(self.origin, v_box_min, v_box_max, self.angles[1], (1, 0, 0), 1, 0, 1000000);

            if(isDefined(stucklocation)) {
              line(stucklocation, self.origin, (1, 0, 0), 1, 1, 1000000);
            }

            self.origin = goalpos;
          }
        }
      } else {
        stuckcount = 0;
        self.vehaircraftcollisionenabled = 1;
        foundpath = self function_a57c34b7(goalpos, 1, 1);

        if(foundpath) {
          self setspeed(self.var_f13adcf8, 35, 35);
          self waittilltimeout(10, #"near_goal");
        } else {
          self setspeedimmediate(0);
          self setvehvelocity((0, 0, 0));
          self setphysacceleration((0, 0, 0));
        }
      }
    }

    waitframe(1);
  }
}

function state_combat_exit(params) {
  self notify(#"end_attack_thread");
  self notify(#"end_movement_thread");
  self turretcleartarget(0);
}

function delay_target_toenemy_thread(point, enemy, timetohit) {
  self endon(#"death", #"change_state", #"end_attack_thread");
  enemy endon(#"death");

  if(!isDefined(self.faketargetent)) {
    self.faketargetent = spawn("script_origin", point);
  }

  self.faketargetent unlink();
  self.faketargetent.origin = point;
  self turretsettarget(0, self.faketargetent);
  self waittill(#"turret_on_target");
  timestart = gettime();
  offset = (0, 0, 0);

  if(issentient(enemy)) {
    offset = enemy getEye() - enemy.origin;
  }

  while(gettime() < timestart + int(timetohit * 1000)) {
    self.faketargetent.origin = lerpvector(point, enemy.origin + offset, (gettime() - timestart) / int(timetohit * 1000));
    waitframe(1);
  }

  self.faketargetent.origin = enemy.origin + offset;
  waitframe(1);
  self.faketargetent linkto(enemy);
}

function attack_thread_mainturret() {
  self endon(#"death", #"change_state", #"end_attack_thread");

  while(true) {
    enemy = self.enemy;

    if(isDefined(enemy) && !is_true(self.inpain)) {
      self vehlookat(enemy);

      if(self cansee(enemy)) {
        vectorfromenemy = vectornormalize(((self.origin - enemy.origin)[0], (self.origin - enemy.origin)[1], 0));
        self thread delay_target_toenemy_thread(enemy.origin + vectorfromenemy * 300, enemy, 1.5);
        self waittill(#"turret_on_target");
        self vehicle_ai::fire_for_time(2 + randomfloat(0.8), 1, enemy);

        if(isDefined(enemy) && isai(enemy)) {
          wait 2.5 + randomfloat(0.5);
        } else {
          wait 2 + randomfloat(0.4);
        }
      } else {
        wait 0.4;
      }

      continue;
    }

    self turretcleartarget(0);
    self vehclearlookat();
    wait 0.4;
  }
}

function attack_thread_rocket() {
  self endon(#"death", #"change_state", #"end_attack_thread");

  while(true) {
    enemy = self.enemy;

    if(!isDefined(enemy) || is_true(self.inpain)) {
      wait 1;
      continue;
    }

    self turretsettarget(2, enemy);
    self turretsettarget(3, enemy);

    if(isDefined(enemy) && self cansee(enemy) && util::iscooldownready("rocket_launcher")) {
      if(isvehicle(enemy) || isPlayer(enemy) && enemy isinvehicle()) {
        var_10d2ac85 = 1;
      } else {
        var_10d2ac85 = 0;
      }

      if(var_10d2ac85) {
        if(is_true(enemy.var_918b6ecc)) {
          util::cooldown("rocket_launcher", 2);
        } else {
          util::cooldown("rocket_launcher", 4);
        }
      } else {
        util::cooldown("rocket_launcher", 2);
      }

      target = enemy.origin;
      self vehlookat(enemy);

      if(var_10d2ac85) {
        wait 0.5;
      } else {
        wait 1.5;
      }

      var_bfd1e88 = 0;
      eye = self.origin;

      if(isDefined(enemy)) {
        anglestotarget = vectortoangles(enemy.origin - eye);
        angles = anglestotarget - self.angles;

        if(-30 < angles[0] && angles[0] < 60 && -70 < angles[1] && angles[1] < 70) {
          var_bfd1e88 = 1;
        }
      }

      if(var_bfd1e88) {
        if(math::cointoss() || is_true(enemy.var_918b6ecc)) {
          if(var_bfd1e88) {
            if(is_true(enemy.var_918b6ecc)) {
              self function_b9e0d497(2, target, undefined, enemy);
            } else {
              self function_cb13df0f(2, enemy);
            }
          } else {
            continue;
          }

          wait 0.5;

          if(isDefined(enemy)) {
            eye = self.origin;
            angles = vectortoangles(enemy.origin - eye) - self.angles;

            if(-30 < angles[0] && angles[0] < 60 && -70 < angles[1] && angles[1] < 70) {
              var_bfd1e88 = 1;
            }
          }

          if(var_bfd1e88) {
            if(is_true(enemy.var_918b6ecc)) {
              self function_b9e0d497(3, target, undefined, enemy);
            } else {
              self function_cb13df0f(3, enemy);
            }
          }

          wait 1;
        } else {
          self function_a0cd4663(2, 3, enemy, 6);
        }
      }
    }

    wait 0.5;
  }
}

function function_cb13df0f(turret_index, enemy) {
  self endon(#"death");
  self thread vehicle_ai::fireturret(turret_index, enemy);
}

function function_a0cd4663(var_1a2aa691, var_e158b4ea, enemy, var_255b5830) {
  self endon(#"death");

  for(i = 0; i < var_255b5830; i++) {
    self thread vehicle_ai::fireturret(var_1a2aa691, enemy);
    wait 0.125;
    self thread vehicle_ai::fireturret(var_e158b4ea, enemy);
    wait 0.125;
  }
}

function function_b9e0d497(turret_index, target, offset, enemy) {
  self endon(#"death");

  if(!isDefined(offset)) {
    offset = (0, 0, 0);
  }

  self.missiletags[2] = "tag_flash2";
  self.missiletags[3] = "tag_flash3";
  spawntag = self.missiletags[turret_index];
  origin = self gettagorigin(spawntag);
  angles = self gettagangles(spawntag);
  forward = anglesToForward(angles);
  up = anglestoup(angles);

  if(isDefined(spawntag) && isDefined(target)) {
    weapon = getweapon("gunship_missile_armada");
    v_dir = vectornormalize(enemy.origin - origin);
    var_a64609fe = v_dir * 3500;
    missile = self magicmissile(weapon, origin, var_a64609fe, enemy);
  }
}

function getenemyarray(include_ai, include_player) {
  enemyarray = [];
  enemy_team = # "allies";

  if(is_true(include_ai)) {
    aiarray = getaiteamarray(enemy_team);
    enemyarray = arraycombine(enemyarray, aiarray, 0, 0);
  }

  if(is_true(include_player)) {
    playerarray = getplayers(enemy_team);
    enemyarray = arraycombine(enemyarray, playerarray, 0, 0);
  }

  return enemyarray;
}

function is_point_in_view(point, do_trace) {
  if(!isDefined(point)) {
    return 0;
  }

  scanner = self.frontscanner;
  vector_to_point = point - scanner.origin;
  in_view = lengthsquared(vector_to_point) <= sqr(10000);

  if(in_view) {
    in_view = util::within_fov(scanner.origin, scanner.angles, point, cos(190));
  }

  if(in_view && is_true(do_trace) && isDefined(self.enemy)) {
    in_view = sighttracepassed(scanner.origin, point, 0, self.enemy);
  }

  return in_view;
}

function is_valid_target(target, do_trace) {
  target_is_valid = 1;

  if(is_true(target.ignoreme) || target.health <= 0) {
    target_is_valid = 0;
  } else if(issentient(target) && (target isnotarget() || target ai::is_dead_sentient())) {
    target_is_valid = 0;
  } else if(isDefined(target.origin) && !is_point_in_view(target.origin, do_trace)) {
    target_is_valid = 0;
  }

  return target_is_valid;
}

function get_enemies_in_view(do_trace) {
  validenemyarray = [];
  enemyarray = getenemyarray(1, 1);

  foreach(enemy in enemyarray) {
    if(is_valid_target(enemy, do_trace)) {
      if(!isDefined(validenemyarray)) {
        validenemyarray = [];
      } else if(!isarray(validenemyarray)) {
        validenemyarray = array(validenemyarray);
      }

      validenemyarray[validenemyarray.size] = enemy;
    }
  }

  return validenemyarray;
}

function function_2d59fe25() {
  waitresult = self waittill(#"exit_vehicle");
  waitresult.player val::reset(#"hunter", "ignoreme");
  waitresult.player val::reset(#"hunter", "takedamage");
  self setheliheightlock(0);
  self enableaimassist();
  self setvehicletype(self.original_vehicle_type);
  self.attachedpath = undefined;
  self setgoal(self.origin, 0, 4096, 512);
}

function function_3929047b(params) {
  params.driver = self getseatoccupant(0);

  if(isDefined(params.driver)) {
    self disableaimassist();
    self thread vehicle_death::vehicle_damage_filter("firestorm_turret");
    params.driver val::set(#"hunter", "ignoreme", 1);
    params.driver val::set(#"hunter", "takedamage", 0);

    if(isDefined(self.vehicle_weapon_override)) {
      self setvehweapon(self.vehicle_weapon_override);
    }

    self thread function_2d59fe25();
    self thread function_e9e5bd0();
    self thread player_fire_update_side_turret_1();
    self thread player_fire_update_side_turret_2();
    self thread player_fire_update_rocket();
  }

  if(isDefined(self.goal_node) && isDefined(self.goal_node.var_db67c9d)) {
    self.goal_node.var_db67c9d = undefined;
  }

  self turretcleartarget(0);
  self function_d4c687c9();
  self pathvariableoffsetclear();
  self pathfixedoffsetclear();
  self vehclearlookat();
  self resumespeed();
}

function player_fire_update_side_turret_1() {
  self endon(#"death", #"exit_vehicle");
  weapon = self seatgetweapon(1);
  firetime = weapon.firetime;

  while(true) {
    target = self turretgettarget(0);

    if(isDefined(target)) {
      self turretsettarget(1, self turretgettarget(0));

      if(self isdriverfiring()) {
        self fireweapon(1);
      }
    }

    wait firetime;
  }
}

function player_fire_update_side_turret_2() {
  self endon(#"death", #"exit_vehicle");
  weapon = self seatgetweapon(2);
  firetime = weapon.firetime;

  while(true) {
    target = self turretgettarget(0);

    if(isDefined(target)) {
      self turretsettarget(2, self turretgettarget(0));

      if(self isdriverfiring()) {
        self fireweapon(2);
      }
    }

    wait firetime;
  }
}

function player_fire_update_rocket() {
  self endon(#"death", #"exit_vehicle");
  weapon = getweapon("gunship_rockets_armada");
  firetime = weapon.firetime;
  driver = self getseatoccupant(0);

  while(true) {
    if(driver jumpbuttonPressed()) {
      spawntag0 = self.missiletags[0];
      spawntag1 = self.missiletags[1];
      origin0 = self gettagorigin(spawntag0);
      origin1 = self gettagorigin(spawntag1);
      target = self turretgettarget(0);
      magicbullet(weapon, origin0, target);
      magicbullet(weapon, origin1, target);
      wait firetime;
    }

    waitframe(1);
  }
}

function function_e9e5bd0() {
  self endon(#"change_state", #"crash_done", #"death");

  while(true) {
    waitresult = self waittill(#"veh_collision");
    velocity = waitresult.velocity;
    normal = waitresult.normal;
    driver = self getseatoccupant(0);

    if(isDefined(driver) && lengthsquared(velocity) > 4900) {
      earthquake(0.25, 0.25, driver.origin, 50);
      driver playrumbleonentity("damage_heavy");
    }
  }
}

function function_15f76db9() {
  self endon(#"death", #"emped", #"landed");

  while(isDefined(self.emped)) {
    velocity = self.velocity;
    self.angles = (self.angles[0] * 0.85, self.angles[1], self.angles[2] * 0.85);
    ang_vel = self getangularvelocity() * 0.85;
    self setangularvelocity(ang_vel);
    self setvehvelocity(velocity);
    waitframe(1);
  }
}

function function_3787ff5(time, velocitystablizeparam, rotationstablizeparam, restorelookpoint, emped) {
  self endon(#"death");
  self.painstarttime = gettime();

  if(!is_true(self.inpain)) {
    self.inpain = 1;

    while(gettime() < self.painstarttime + int(velocitystablizeparam * 1000)) {
      self setvehvelocity(self.velocity * rotationstablizeparam);
      self setangularvelocity(self getangularvelocity() * restorelookpoint);
      wait 0.1;
    }

    if(isDefined(emped)) {
      restorelookent = spawn("script_model", emped);
      restorelookent setModel(#"tag_origin");
      self vehclearlookat();
      self vehlookat(restorelookent);
      self turretsettarget(0, restorelookent);
      restorelookent thread util::function_f9af3d43(5);
      wait 5;
      self vehclearlookat();
      self turretcleartarget(0);
    }

    self.inpain = 0;
  }
}

function function_7afa9936(eattacker, damagetype, hitpoint, hitdirection, hitlocationinfo, partname, emped = 0) {
  if(!isDefined(hitlocationinfo) || !isDefined(partname)) {
    return;
  }

  if(isDefined(self.allowpain) && self.allowpain == 0) {
    return;
  }

  self setvehvelocity(self.velocity + vectornormalize(partname) * 20);

  if(!is_true(self.inpain)) {
    vecright = anglestoright(self.angles);
    sign = math::sign(vectordot(vecright, partname));
    yaw_vel = sign * randomfloatrange(100, 140);
    ang_vel = self getangularvelocity();
    ang_vel += (randomfloatrange(-120, -100), yaw_vel, randomfloatrange(-100, 100));
    self setangularvelocity(ang_vel);
    self thread function_3787ff5(8, 1, 0.8, hitlocationinfo, emped);
  }
}

function function_9dd28496(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(vdir) && vdir.team == self.team) {
    return 0;
  }

  if(vdamageorigin == "MOD_CRUSH") {
    return 0;
  }

  if(!isDefined(self.damagelevel)) {
    self.damagelevel = 0;
    self.newdamagelevel = self.damagelevel;
  }

  newdamagelevel = vehicle::should_update_damage_fx_level(self.health, shitloc, self.healthdefault);

  if(newdamagelevel > self.damagelevel) {
    self.newdamagelevel = newdamagelevel;
  }

  if(self.newdamagelevel > self.damagelevel) {
    self.damagelevel = self.newdamagelevel;
    function_7afa9936(vdir, vdamageorigin, damagefromunderneath, modelindex, partname, vsurfacenormal);
    vehicle::set_damage_fx_level(self.damagelevel);
  }

  if(vehicle_ai::should_emp(self, psoffsettime, vdamageorigin, vpoint, vdir)) {
    function_7afa9936(vdir, vdamageorigin, damagefromunderneath, modelindex, partname, vsurfacenormal, 1);
  }

  return shitloc;
}

function function_b1bd875a() {
  assert(isDefined(self.ai));

  if(!isDefined(self.ai.var_88b0fd29)) {
    self.ai.var_88b0fd29 = gettime() + 1000;
    return;
  }

  goalinfo = self function_4794d6a3();
  assert(isDefined(goalinfo.goalpos));
  var_12cb92c6 = 0;
  newpos = undefined;
  point = undefined;

  if(isDefined(self.favoriteenemy)) {
    enemy = self.favoriteenemy;
  } else {
    enemy = self.enemy;
  }

  currenttime = gettime();
  forcedgoal = is_true(goalinfo.goalforced);
  isatgoal = is_true(goalinfo.isatgoal);
  haspath = self haspath();
  isapproachinggoal = !isatgoal && haspath && self isapproachinggoal();
  itsbeenawhile = currenttime >= self.ai.var_88b0fd29;
  var_ed3f071f = currenttime >= self.ai.var_88b0fd29 + 5000;
  var_48ea0381 = 0;

  if(issentient(enemy) && !haspath) {
    var_48ea0381 = !self seerecently(enemy, randomintrange(3, 5));

    if(var_48ea0381 && issentient(enemy)) {
      var_48ea0381 = !self attackedrecently(enemy, randomintrange(5, 7));
    }
  }

  var_3e782e85 = forcedgoal || goalinfo.goalradius < 2 * self.radius && goalinfo.goalheight < 2 * self.radius;
  var_f5ae7ee0 = isatgoal && !var_3e782e85 && (itsbeenawhile || var_48ea0381);
  var_633ff15a = !isatgoal && (!isapproachinggoal || var_ed3f071f);
  var_12cb92c6 = var_f5ae7ee0 || var_633ff15a;

  if(var_12cb92c6) {
    if(!isatgoal || !var_3e782e85) {
      if(var_3e782e85) {
        newpos = self getclosestpointonnavvolume(goalinfo.goalpos, self.radius * 2);
      } else if(!isatgoal) {
        point = function_1e0d693b(goalinfo, enemy);
      } else if(isDefined(enemy)) {
        point = function_1e0d693b(goalinfo, enemy);
      }

      if(isDefined(point)) {
        newpos = point.origin;
      }

      if(!isDefined(newpos)) {
        newpos = self getclosestpointonnavvolume(goalinfo.goalpos, self.radius * 2);
      }

      if(!isDefined(newpos)) {
        record3dtext("<dev string:x38>" + goalinfo.goalpos + "<dev string:x5d>" + goalinfo.goalradius + "<dev string:x6f>" + goalinfo.goalheight, self.origin + (0, 0, 8), (1, 0, 0));
        recordline(self.origin, goalinfo.goalpos, (1, 0, 0));

        newpos = goalinfo.goalpos;
      }

      self.ai.var_88b0fd29 = currenttime + randomintrange(100, 200);
    }
  } else if(isatgoal && var_3e782e85) {
    self setspeedimmediate(0);
    self setvehvelocity((0, 0, 0));
    self setphysacceleration((0, 0, 0));
  }

  return newpos;
}

function function_1e0d693b(goal, enemy) {
  prefereddistawayfromorigin = isDefined(self.settings.var_99955aeb) ? self.settings.var_99955aeb : 150;

  if(isDefined(self.settings.engagementheightmax) && isDefined(self.settings.engagementheightmin)) {
    var_20b5eeff = 0.5 * (self.settings.engagementheightmax + self.settings.engagementheightmin);
  } else {
    var_20b5eeff = 150;
  }

  var_3069c020 = isDefined(self.settings.var_2ade16ee) ? self.settings.var_2ade16ee : 450;
  enemypos = enemy.origin;

  if(function_ffa5b184(enemy)) {
    enemypos = enemy.var_88f8feeb;
  }

  var_caa2a43c = max(prefereddistawayfromorigin, goal.goalradius + distance2d(self.origin, goal.goalpos));
  var_a51de54a = goal.goalheight + abs(self.origin[2] - goal.goalpos[2]);
  closedist = 1.2 * self.var_ec0d66ce;
  fardist = 3 * self.var_ec0d66ce;
  selfdisttoenemy = distance2d(self.origin, enemypos);
  querymultiplier = mapfloat(closedist, fardist, 1, 3, selfdisttoenemy);
  maxsearchradius = min(var_caa2a43c, (isDefined(self.settings.var_3285f09a) ? self.settings.var_3285f09a : 1000) * querymultiplier);
  halfheight = min(var_a51de54a / 2, (isDefined(self.settings.var_e1d36c37) ? self.settings.var_e1d36c37 : 300) * querymultiplier);
  innerspacing = maxsearchradius / 10;
  outerspacing = innerspacing;
  queryresult = positionquery_source_navigation(enemy.origin, isDefined(self.settings.var_99955aeb) ? self.settings.var_99955aeb : 0, maxsearchradius, halfheight, innerspacing, self, outerspacing);
  positionquery_filter_distancetogoal(queryresult, self);
  positionquery_filter_inclaimedlocation(queryresult, self);
  positionquery_filter_sight(queryresult, enemypos, self getEye() - self.origin, self, 0, enemy);
  self vehicle_ai::positionquery_filter_engagementdist(queryresult, enemy, self.settings.engagementdistmin, self.settings.engagementdistmax, var_3069c020);
  goalheight = enemypos[2] + 0.5 * (self.settings.engagementheightmin + self.settings.engagementheightmax);

  foreach(point in queryresult.data) {
    if(point.disttogoal > 0) {
      score = -5000 - point.disttogoal * 2;

      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }

      if(!isDefined(point._scoredebug[# "outofgoalanchor"])) {
        point._scoredebug[# "outofgoalanchor"] = spawnStruct();
      }

      point._scoredebug[# "outofgoalanchor"].score = score;
      point._scoredebug[# "outofgoalanchor"].scorename = "<dev string:x85>";

      point.score += score;
    }

    if(!point.visibility) {
      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }

      if(!isDefined(point._scoredebug[# "no visibility"])) {
        point._scoredebug[# "no visibility"] = spawnStruct();
      }

      point._scoredebug[# "no visibility"].score = -5000;
      point._scoredebug[# "no visibility"].scorename = "<dev string:x98>";

      point.score += -5000;
    }

    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }

    if(!isDefined(point._scoredebug[# "engagementdist"])) {
      point._scoredebug[# "engagementdist"] = spawnStruct();
    }

    point._scoredebug[# "engagementdist"].score = point.distawayfromengagementarea * -1;
    point._scoredebug[# "engagementdist"].scorename = "<dev string:xa9>";

    point.score += point.distawayfromengagementarea * -1;

    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }

    if(!isDefined(point._scoredebug[# "hash_6c444b535ec20313"])) {
      point._scoredebug[# "hash_6c444b535ec20313"] = spawnStruct();
    }

    point._scoredebug[# "hash_6c444b535ec20313"].score = mapfloat(0, prefereddistawayfromorigin, -5000, 0, point.disttoorigin2d);
    point._scoredebug[# "hash_6c444b535ec20313"].scorename = "<dev string:xbb>";

    point.score += mapfloat(0, prefereddistawayfromorigin, -5000, 0, point.disttoorigin2d);

    if(point.inclaimedlocation) {
      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }

      if(!isDefined(point._scoredebug[# "inclaimedlocation"])) {
        point._scoredebug[# "inclaimedlocation"] = spawnStruct();
      }

      point._scoredebug[# "inclaimedlocation"].score = -5000;
      point._scoredebug[# "inclaimedlocation"].scorename = "<dev string:xcd>";

      point.score += -5000;
    }

    distfrompreferredheight = abs(point.origin[2] - goalheight);

    if(distfrompreferredheight > var_20b5eeff) {
      heightscore = mapfloat(var_20b5eeff, 10000, 0, 2500, distfrompreferredheight) * -1;

      if(!isDefined(point._scoredebug)) {
        point._scoredebug = [];
      }

      if(!isDefined(point._scoredebug[# "height"])) {
        point._scoredebug[# "height"] = spawnStruct();
      }

      point._scoredebug[# "height"].score = heightscore;
      point._scoredebug[# "height"].scorename = "<dev string:xe2>";

      point.score += heightscore;
    }

    score = randomfloatrange(0, 80);

    if(!isDefined(point._scoredebug)) {
      point._scoredebug = [];
    }

    if(!isDefined(point._scoredebug[# "random"])) {
      point._scoredebug[# "random"] = spawnStruct();
    }

    point._scoredebug[# "random"].score = score;
    point._scoredebug[# "random"].scorename = "<dev string:xec>";

    point.score += score;
  }

  if(queryresult.data.size > 0) {
    vehicle_ai::positionquery_postprocess_sortscore(queryresult);
    self vehicle_ai::positionquery_debugscores(queryresult);

    foreach(point in queryresult.data) {
      return point;
    }
  }

  return undefined;
}