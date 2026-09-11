/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_dwn_twn\objectives\cp_dwn_twn_heli_boss.gsc
**************************************************************************/

function heli_boss_precache() {
  level._effect["helidown_rpghit"] = loadfx("vfx/iw8_cp/chopper/vfx_chopper_air_explosion.vfx");
}

function spawn_enemy_lbravo(var0) {
  level thread scripts\cp\utility::cp_add_dialogue_line(&"CP_MILBASE_DIALOGUE/HELI_INBOUND");

  if(scripts\engine\utility::flag_exist("boss_heli")) {
    scripts\engine\utility::flag_set("boss_heli");
  }

  var1 = scripts\engine\utility::getStructArray("boss_heli_spawn", "targetname");
  var2 = var1[0];

  if(!isDefined(var2.angles)) {
    var2.angles = (0, 0, 0);
  }

  level.heli = spawnVehicle("veh8_mil_air_lbravo_weapons_cp", "chopper_boss", "lbravo_infil_cp", var2.origin, var2.angles);
  level.heli.spawnpoint = var2;
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
  thread flag_think(level.heli, var0);
  thread setup_pilot(level.heli, "tag_pilot1");
  level.heli thread scripts\cp\helicopter\cp_helicopter::heli_damagemonitor(var0);
  level.heli sethoverparams(25, 15, 10);
  level.heli.ref_11e98 = 1;
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

function flag_think(var0, var1) {
  level.heli endon("death");

  if(isDefined(var0) && scripts\engine\utility::flag_exist(var0)) {
    scripts\engine\utility::flag_wait(var0);
  }

  if(istrue(var1)) {
    level thread scripts\cp\helicopter\cp_helicopter::heli_rocket_think_default(level.heli);
    return;
  }

  level thread scripts\cp\helicopter\cp_helicopter::heli_think_default(level.heli);
}

function follow_path_until(var0) {
  self endon("death");
  var1 = scripts\engine\utility::getStructArray(self.spawnpoint.target, "targetname");
  var2 = var1[0];

  while(isDefined(var2)) {
    self cleartargetyaw();
    self cleargoalyaw();
    self.gotopos = var2.origin;
    var3 = self.gotopos;

    if(distance2dsquared(self.origin, var3) > 640000) {
      self setneargoalnotifydist(300);
      self vehicle_setspeed(40, 30, 30);
      self setvehgoalpos(var3, 0);
    } else {
      self vehicle_setspeed(15, 12, 12);
      self setvehgoalpos(var3, 0);
    }

    scripts\engine\utility::ref_143bb(15, "goal", "goal_reached", "near_goal");

    if(isDefined(var2.target) && var2.target != var0) {
      var1 = scripts\engine\utility::getStructArray(var2.target, "targetname");
      var2 = var1[0];
      continue;
    }

    break;
  }

  var4 = var2;
  var1 = scripts\engine\utility::getStructArray(var2.target, "targetname");
  var2 = var1[0];
  arrive_at_exfil_location(self, var2, var4);
}

function initbunker11keypad() {
  self endon("goal");

  for(;;) {
    foreach(var1 in level.players) {
      if(var1 istouching(self)) {
        thread ref_11d92(var1);
      }
    }

    waitframe();
  }
}

function ref_11d92(var0) {
  var1 = var0.origin - self.origin;
  var1 = vectorNormalize(var1);
  var1 *= 200;
  var1 = (var1[0], var1[1], 0);
  var0 setOrigin(var0.origin + var1, 1);
  waitframe();
  var0 dodamage(var0.health + 1000, var0.origin, self, self, "MOD_SUICIDE");
}

function arrive_at_exfil_location(var0, var1, var2) {
  var0 setvehgoalpos(var2.origin, 1);
  var0 waittill("goal");
  var0 settargetyaw(var1.angles[1]);
  var0 setyawspeed(40, 25, 25, 0);
  thread initbunker11keypad();
  wait 3;
  level notify("arrive_at_exfil_location");
  var0.goalradius = 4;
  var0 setvehgoalpos(var1.origin, 1);
  var0 waittill("goal");
  var0 vehicle_setspeedimmediate(0);
  thread heli_sfx_shutdown();
  var0 vehicle_cleardrivingstate();
  var0 notify("heli_landed");
  var0.landed = 1;
}

function heli_sfx_shutdown() {
  self endon("death");
  self playSound("cp_dwn_twn_heli_shutdown");
  wait 2;
  self vehicle_turnengineoff();
  level scripts\engine\utility::ref_143a5("hvt_leaving", "heli_engage");
  self playSound("cp_dwn_twn_heli_spoolup");
  wait 2;
  self vehicle_turnengineon();
}

function setup_pilot(var0, var1, var2) {
  var3 = "tag_pilot";

  if(isDefined(var0)) {
    var3 = var0;
  }

  var4 = (0, 0, 0);

  if(isDefined(var1)) {
    var4 = var1;
  }

  var5 = (0, 0, 0);

  if(isDefined(var2)) {
    var5 = var2;
  }

  if(!self tagexists(var3)) {
    var3 = "tag_pilot1";
  }

  self.pilot = spawn("script_model", self gettagorigin(var3));
  self.pilot setModel("aq_pilot_fullbody_1");
  self.pilot linkTo(self, var3, var4, var5);
  self.pilot scriptmodelplayanim("vh_blima_rappel_pilot");
}

function heli_damagemonitor(var0) {
  self endon("death");
  var1 = 0;
  self.health = 1000000;
  var2 = 2500;

  for(;;) {
    self waittill("damage", var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16);
    self.health = 1000000;

    if(isDefined(var4) && var4 == self) {
      continue;
    }

    if(isDefined(var16) && isDefined(var16.owner) && var16.owner == self) {
      continue;
    }

    if(is_snipe_kill(var4, var6, var12)) {
      var1++;

      if(var1 == 2) {
        var4 scripts\cp\cp_achievement::scriptable_enginedamaged();
        var4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
        thread do_heli_crash(var4);
        return;
      }

      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical", 1);
      self.needs_to_evade = 1;
      self vehicle_setspeed(100, 100, 100);
      self setvehgoalpos(self.origin + (randomintrange(-50, 50), randomintrange(-50, 50), 0), 0);
      self notify("needs_to_evade");
      continue;
    }

    if(!isexplosivedamagemod(var7)) {
      if(istrue(self.bullets_can_damage)) {
        var3 *= 0.1;
      } else {
        var3 = 0;
      }

      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitarmorheavy");
    } else {
      var4.lasthitmarkertime = undefined;
      var4 scripts\cp\cp_damagefeedback::updatedamagefeedback("hitcritical");

      if(isDefined(var12) && var12.basename == "iw8_thermite_mp") {
        switch (var12.basename) {
          case "iw8_thermite_mp":
            break;
          case "emp_drone_player_mp":
            var3 = 1400;
            break;
          default:
            break;
        }
      } else if(var3 < 700) {
        var3 = 700;
      }

      if(isDefined(var0) && !scripts\engine\utility::flag(var0)) {
        scripts\engine\utility::flag_set(var0);
      } else {
        if(!self.needs_to_evade) {
          self.needs_to_evade = 1;
        }

        self notify("needs_to_evade");
        self vehicle_setspeed(100, 100, 100);
        self setvehgoalpos(self.origin + (randomintrange(-850, 850), randomintrange(-850, 850), 0), 0);
      }
    }

    self.health_remaining -= var3;

    if(self.health_remaining <= var2 * 0.25 && !isDefined(self.deathfx2)) {
      self setscriptablepartstate("body_damage_heavy", "on");
      self.deathfx2 = 1;
    } else if(self.health_remaining <= var2 * 0.5 && !isDefined(self.deathfx1)) {
      self setscriptablepartstate("body_damage_medium", "on");
      self.deathfx1 = 1;
    } else if(self.health_remaining <= var2 * 0.75 && !isDefined(self.deathfx)) {
      self setscriptablepartstate("body_damage_light", "on");
      self.deathfx = 1;
    }

    if(self.health_remaining <= 0) {
      if(isDefined(var12) && issubstr(var12.basename, "molotov")) {
        if(isDefined(var4) && isPlayer(var4)) {
          var4 thread scripts\cp\cp_achievement::scriptable_setups();
        }
      }

      if(isDefined(var4) && isPlayer(var4)) {
        var4 thread scripts\cp_mp\xmike109::givemidmatchaward("kill_ss_chopper_support");
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

function is_snipe_kill(var0, var1, var2) {
  var3 = isDefined(var2) && isDefined(var2.classname) && var2.classname == "sniper";

  if(!ispointnearpilot(self, var1) || !var3) {
    return false;
  }

  return true;
}

function do_heli_crash(var0) {
  thread crash_deathfx();
  self.vehicle_skipdeathmodel = 1;
  self.delay_before_delete = 0.25;
  level.all_spawned_vehicles = scripts\engine\utility::array_remove(level.all_spawned_vehicles, self);
  self notify("death", var0, "MOD_EXPLOSIVE", undefined, self.origin);
  scripts\common\vehicle_code::vehicle_docrash(var0, "sniped");
  self makecorpse();
}

function crash_deathfx() {
  self waittill("vehicle_deathComplete", var0);
  playFX(level._effect["vfx_blima_explosion"], var0 + (0, 0, -100));
  playsoundatpos(var0, "cp_br_syrk_chopper_crash");
}

function ispointnearpilot(var0, var1) {
  var2 = anglesToForward(self.angles);
  var3 = anglestoleft(self.angles);
  var4 = self.origin + var2 * 133 + (0, 0, -70);
  var5 = self.origin + var2 * 112 + var3 * 17 + (0, 0, -70);
  var6 = self.origin + var2 * 112 + (0, 0, -50);

  if(distance(var1, var4) <= 20) {
    return true;
  }

  if(distance(var1, var5) <= 20) {
    return true;
  }

  if(distance(var1, var6) <= 20) {
    return true;
  }

  return false;
}