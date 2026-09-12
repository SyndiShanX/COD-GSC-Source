/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_heli_boss.gsc
**************************************************************************/

function heli_boss_precache() {
  level._effect["helidown_rpghit"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_air_explosion.vfx");
}

function spawn_enemy_lbravo(var_0) {
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_MILBASE_DIALOGUE/HELI_INBOUND");

  if(scripts\engine\utility::flag_exist("boss_heli")) {
    scripts\engine\utility::flag_set("boss_heli");
  }

  var_1 = scripts\engine\utility::getStructArray("boss_heli_spawn", "targetname");
  var_2 = var_1[0];

  if(!isDefined(var_2.angles)) {
    var_2.angles = (0, 0, 0);
  }

  level.heli = spawnVehicle("veh8_mil_air_lbravo_weapons_cp", "chopper_boss", "lbravo_infil_cp", var_2.origin, var_2.angles);
  level.heli.spawnpoint = var_2;
  level.heli.isheli = 1;
  level.all_spawned_vehicles[level.all_spawned_vehicles.size] = level.heli;
  level.heli.vehicletype = "apache";
  level.heli.health = 50000;
  level.heli.maxhealth = 50000;
  level.heli.team = "axis";
  level.heli setvehicleteam(level.heli.team);
  level.heli setmaxpitchroll(15, 15);
  level.heli.health_remaining = 2500;
  level.heli.evade_radius = 1000;
  level.heli.bullets_can_damage = 1;
  level.heli.obj_pregame = "heli_evade_start_node";
  thread flag_think(level.heli, var_0);
  thread setup_pilot(level.heli, "tag_pilot1");
  level.heli thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor(var_0);
  level.heli sethoverparams(25, 15, 10);
  level.heli.ref_11E98 = 1;
  level.heli.circle_radius = 800;
  level.heli.should_move_to_target_dist = 2400;
  level.heli.heli_can_target_dist = 1800;
  level.heli.new_target_dist = 1200;
  scripts\cp\cp_weapon::add_to_special_lockon_target_list(level.heli);
  thread follow_path_until(level.heli);
}

function spawn_fake_damage_fx() {
  self.fx_ent = spawn("script_model", self.origin);
  self.fx_ent.angles = self.angles;
  self.fx_ent setModel("tag_origin_lbravo_fx");
  self.fx_ent linkTo(self, "tag_origin");
}

function flag_think(var_0, var_1) {
  level.heli endon("death");

  if(isDefined(var_0) && scripts\engine\utility::flag_exist(var_0)) {
    scripts\engine\utility::flag_wait(var_0);
  }

  if(istrue(var_1)) {
    level thread scripts\cp\helicopter\cp_helicopter::heli_rocket_think_default(level.heli);
    return;
  }

  level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(level.heli);
}

function follow_path_until(var_0) {
  self endon("death");
  var_1 = scripts\engine\utility::getStructArray(self.spawnpoint.target, "targetname");
  var_2 = var_1[0];

  while(isDefined(var_2)) {
    self cleartargetyaw();
    self cleargoalyaw();
    self.gotopos = var_2.origin;
    var_3 = self.gotopos;

    if(distance2dsquared(self.origin, var_3) > 640000) {
      self setneargoalnotifydist(300);
      self vehicle_setspeed(40, 30, 30);
      self setvehgoalpos(var_3, 0);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var_3, 0);
    }

    scripts\engine\utility::ref_143BB(15, "goal", "goal_reached", "near_goal");

    if(isDefined(var_2.target) && var_2.target != var_0) {
      var_1 = scripts\engine\utility::getStructArray(var_2.target, "targetname");
      var_2 = var_1[0];
      continue;
    }

    break;
  }

  var_4 = var_2;
  var_1 = scripts\engine\utility::getStructArray(var_2.target, "targetname");
  var_2 = var_1[0];
  arrive_at_exfil_location(self, var_2, var_4);
}

function initbunker11keypad() {
  self endon("goal");

  for(;;) {
    foreach(var_1 in level.players) {
      if(var_1 istouching(self)) {
        thread ref_11D92(var_1);
      }
    }

    waitframe();
  }
}

function ref_11D92(var_0) {
  var_1 = var_0.origin - self.origin;
  var_1 = vectorNormalize(var_1);
  var_1 *= 200;
  var_1 = (var_1[0], var_1[1], 0);
  var_0 setOrigin(var_0.origin + var_1, 1);
  waitframe();
  var_0 dodamage(var_0.health + 1000, var_0.origin, self, self, "MOD_SUICIDE");
}

function arrive_at_exfil_location(var_0, var_1, var_2) {
  var_0 setvehgoalpos(var_2.origin, 1);
  var_0 waittill("goal");
  var_0 settargetyaw(var_1.angles[1]);
  var_0 setyawspeed(40, 25, 25, 0);
  thread initbunker11keypad();
  wait 3;
  level notify("arrive_at_exfil_location");
  var_0.goalradius = 4;
  var_0 setvehgoalpos(var_1.origin, 1);
  var_0 waittill("goal");
  var_0 vehicle_setspeedimmediate(0);
  thread heli_sfx_shutdown();
  var_0 vehicle_cleardrivingstate();
  var_0 notify("heli_landed");
  var_0.landed = 1;
}

function heli_sfx_shutdown() {
  self endon("death");
  self playSound("cp_dwn_twn_heli_shutdown");
  wait 2;
  self vehicle_turnengineoff();
  level scripts\engine\utility::ref_143A5("hvt_leaving", "heli_engage");
  self playSound("cp_dwn_twn_heli_spoolup");
  wait 2;
  self vehicle_turnengineon();
}

function setup_pilot(var_0, var_1, var_2) {
  var_3 = "tag_pilot";

  if(isDefined(var_0)) {
    var_3 = var_0;
  }

  var_4 = (0, 0, 0);

  if(isDefined(var_1)) {
    var_4 = var_1;
  }

  var_5 = (0, 0, 0);

  if(isDefined(var_2)) {
    var_5 = var_2;
  }

  if(!self tagexists(var_3)) {
    var_3 = "tag_pilot1";
  }

  self.pilot = spawn("script_model", self gettagorigin(var_3));
  self.pilot setModel("aq_pilot_fullbody_1");
  self.pilot linkTo(self, var_3, var_4, var_5);
  self.pilot scriptmodelplayanim("vh_blima_rappel_pilot");
}

function heli_damagemonitor(var_0) {
  self endon("death");
  var_1 = 0;
  self.health = 1000000;
  var_2 = 2500;

  for(;;) {
    self waittill("damage", var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16);
    self.health = 1000000;

    if(isDefined(var_4) && var_4 == self) {
      continue;
    }

    if(isDefined(var_16) && isDefined(var_16.owner) && var_16.owner == self) {
      continue;
    }

    if(is_snipe_kill(var_4, var_6, var_12)) {
      var_1++;

      if(var_1 == 2) {
        var_4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        thread do_heli_crash(var_4);
        return;
      }

      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(var_7)) {
      if(istrue(self.bullets_can_damage)) {
        var_3 *= 0.1;
      } else {
        var_3 = 0;
      }

      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitarmorheavy");
    } else {
      var_4.lasthitmarkertime = undefined;
      var_4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(var_12) && var_12.basename == "iw8_thermite_mp") {
        switch (var_12.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            var_3 = 1400;
            break;
          default:
            break;
        }
      } else if(var_3 < 700) {
        var_3 = 700;
      }

      if(isDefined(var_0) && !scripts\engine\utility::flag(var_0)) {
        scripts\engine\utility::flag_set(var_0);
      } else {
        if(!self.needs_to_evade) {
          self.needs_to_evade = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    self.health_remaining -= var_3;

    if(self.health_remaining <= var_2 * 0.25 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx2 = 1;
    } else if(self.health_remaining <= var_2 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var_2 * 0.75 && !isDefined(self.deathfx)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(var_12) && issubstr(var_12.basename, "molotov")) {
        if(isDefined(var_4) && isPlayer(var_4)) {
          var_4 thread scripts\cp\cp_achievement::scriptable_setups();
        }
      }

      if(isDefined(var_4) && isPlayer(var_4)) {
        var_4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
      }

      playFX(level._effect["helidown_rpghit"], self.origin);
      level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);

      if(isDefined(self.minigun)) {
        self.minigun delete();
      }

      if(isDefined(self.pilot)) {
        self.pilot delete();
      }

      self delete();
    }
  }
}

function is_snipe_kill(var_0, var_1, var_2) {
  var_3 = isDefined(var_2) && isDefined(var_2.classname) && var_2.classname == "sniper";

  if(!ispointnearpilot(self, var_1) || !var_3) {
    return false;
  }

  return true;
}

function do_heli_crash(var_0) {
  thread crash_deathfx();
  self.vehicle_skipdeathmodel = 1;
  self.delay_before_delete = 0.25;
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  self notify("death", var_0, "MOD_EXPLOSIVE", undefined, self.origin);
  scripts\common\vehicle_code::vehicle_docrash(var_0, "sniped");
  self makecorpse();
}

function crash_deathfx() {
  self waittill("vehicle_deathComplete", var_0);
  playFX(level._effect["vfx_blima_explosion"], var_0 + (0, 0, -100));
  playsoundatpos(var_0, "cp_br_syrk_chopper_crash");
}

function ispointnearpilot(var_0, var_1) {
  var_2 = anglesToForward(self.angles);
  var_3 = anglestoleft(self.angles);
  var_4 = self.origin + var_2 * 133 + (0, 0, -70);
  var_5 = self.origin + var_2 * 112 + var_3 * 17 + (0, 0, -70);
  var_6 = self.origin + var_2 * 112 + (0, 0, -50);

  if(distance(var_1, var_4) <= 20) {
    return true;
  }

  if(distance(var_1, var_5) <= 20) {
    return true;
  }

  if(distance(var_1, var_6) <= 20) {
    return true;
  }

  return false;
}