/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_damage.gsc
*****************************************************/

function vehicle_damage_setCanDamage(var0) {
  var1 = self getlinkedchildren(1);

  if(isDefined(var1)) {
    foreach(var3 in var1) {
      if(isDefined(var3.code_classname) && var3.code_classname == "misc_turret") {
        if(var0) {
          thread vehicle_damage_keepturretalive(var3);
          continue;
        }

        vehicle_damage_keepturretaliveend(var3);
      }
    }
  }

  self setCanDamage(var0);
  vehicle_damage_cleareventlog(self);
}

function vehicle_damage_getleveldataforvehicle(var0, var1, var2) {
  var3 = vehicle_damage_getleveldata();
  var4 = var3.vehicledata[var0];

  if(!isDefined(var4)) {
    if(istrue(var1)) {
      var4 = spawnStruct();
      var3.vehicledata[var0] = var4;
      var4.isattachmentvariantlocked = [];
      var4.class = "none";
      var4.showtacmaphint = undefined;
      var4.ref_12899 = undefined;
      var4.siege_bot_team_triple_cap_check = undefined;
      var4.flare_setup = undefined;
      var4.visualpercents = [];
      var4.visualcallbacks = [];
      var4.visualclearcallbacks = [];
      var4.visualhighesttolowest = undefined;
    } else if(istrue(var2)) {}
  }

  return var4;
}

function ref_1414c(var0, var1, var2) {
  var3 = var0.damagedata;

  if(!isDefined(var3)) {
    if(istrue(var1)) {
      var3 = spawnStruct();
      var0.damagedata = var3;
      var3.lb_mg_impulse_dmg_threshold_low = undefined;
      var3.lb_mg_impulse_dmg_threshold_mid = undefined;
      var3.lb_mg_dmg_factor_landing_gear = undefined;
      var3.lb_mg_dmg_factor_main_rotor = undefined;
      var3.sidekillcount = undefined;
      var3.siege_bot_team_had_advantage = undefined;
      var3.shuttingdown = undefined;
      var3.sidehouse_intel_sequence = undefined;
      var3.ref_11bae = undefined;
      var3.ref_11baf = undefined;
      var3.ref_11bac = undefined;
      var3.ref_11bad = undefined;
      var3.wind_trigger_toggle = undefined;
      var3.wind_triggers = undefined;
      var3.winbycaptures = undefined;
      var3.wind_trigger_loop = undefined;
    } else if(istrue(var2)) {}
  }

  return var3;
}

function ref_1416e(var0) {
  return ref_1414c(var0, 1);
}

function ref_14141(var0) {
  var0.damagedata = undefined;
}

function ref_1414d(var0, var1, var2, var3) {
  var4 = vehicle_damage_getleveldataforvehicle(var0, var2, var3);
  var5 = var4.isattachmentvariantlocked[var1];

  if(!isDefined(var5)) {
    if(istrue(var2)) {
      var5 = spawnStruct();
      var4.isattachmentvariantlocked[var1] = var5;
      var5.maxhealth = undefined;
      var5.ref_12024 = undefined;
      var5.ref_1202d = undefined;
    } else if(istrue(var3)) {}
  }

  return var5;
}

function ref_1416f(var0, var1, var2, var3, var4) {
  var5 = vehicle_damage_getleveldataforvehicle(var0, 1);
  var5.visualpercents[var4] = var1;
  var5.visualcallbacks[var4] = var2;
  var5.visualclearcallbacks[var4] = var3;
}

function ref_14142(var0, var1) {
  var2 = vehicle_damage_getleveldataforvehicle(var0, 0);

  if(isDefined(var2)) {
    var2.visualpercents[var1] = undefined;
    var2.visualcallbacks[var1] = undefined;
    var2.visualclearcallbacks[var1] = undefined;
    return;
  }
}

function ref_1416d(var0) {
  var1 = vehicle_damage_getleveldataforvehicle(var0, 1);
  var1.visualhighesttolowest = 1;
  ref_1416f(var0, 0.85, &ref_1415c, &vehicle_damage_lightvisualclearcallback, "light");
  ref_1416f(var0, 0.5, &ref_1415f, &vehicle_damage_mediumvisualclearcallback, "medium");
  ref_1416f(var0, 0.15, &ref_14157, &vehicle_damage_heavyvisualclearcallback, "heavy");

  if(level.gametype != "br") {
    ref_1416f(var0, 0.15, &ref_14145, &ref_14146, "engine");
    return;
  }
}

function ref_14140(var0) {
  var1 = vehicle_damage_getleveldataforvehicle(var0, 1);
  var1.visualhighesttolowest = undefined;
  ref_14142(var0, "light");
  ref_14142(var0, "medium");
  ref_14142(var0, "heavy");
  ref_14142(var0, "engine");
}

function vehicle_damage_clearvisuals(var0, var1, var2) {
  if(isDefined(self.vehiclename)) {
    var3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, 0, 1);

    if(isDefined(var3)) {
      foreach(var5 in var3.visualclearcallbacks) {
        self thread[[var5]](var0, var1, var2);
      }

      return;
    }

    return;
  }
}

function ref_14170() {
  ref_1413c(self.maxhealth);
}

function ref_1413c(var0) {
  self.health = int(min(self.health + var0, self.maxhealth));
  var1 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

  if(!isDefined(var1)) {
    return;
  }

  if(level.gametype == "br") {
    ref_14181();
  } else {
    ref_14182(undefined, 0, 1);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
}

function ref_14160(var0, var1, var2) {
  var3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var0, var1);
  var4 = vehicle_damage_getleveldataforvehicle(var0.vehiclename);

  if(isDefined(var3)) {
    if(isDefined(var4.ref_11fa5) && isDefined(var4.ref_11fa5[var3])) {
      var2 *= var4.ref_11fa5[var3];
    }

    if(isDefined(var4.ref_11fa4) && isDefined(var4.ref_11fa4[var3])) {
      var2 = clamp(var2, 0, var4.ref_11fa4[var3]);
    }
  }

  return var2;
}

function vehicle_damage_init() {
  var0 = spawnStruct();
  level.vehicle.damage = var0;
  var0.vehicledata = [];
  var0.ref_12899 = getdvarint("scr_vehicleDamageStatePristineHealthAdd", 125);
  var0.siege_bot_team_triple_cap_check = getdvarint("scr_vehicleDamageStateHeavyHealthAdd", 350);
  var0.ref_11bb0 = getdvarfloat("scr_vehicleDamageStateMediumHealthRatio", 0.5);
  var0.flare_setup = getdvarfloat("scr_vehicleDamageBurnDownTime", 8);
  ref_1415d();
  vehicle_damage_initdebug();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "init")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "init")]]();
  }

  if(level.gametype == "br") {
    ref_14159();
  } else {
    ref_14158();
  }

  level.brking_managecircles = getdvarint("scr_vehicle_allow_damage_audio_feedback", 1);
  ref_1415a();
}

function ref_1415d() {
  var0 = vehicle_damage_getleveldata();
  var1 = spawnStruct();
  var0.table = var1;
  var1.ref_11ca5 = [];
  var1.ref_11ca6 = [];
  var1.spawn_lmg_soldiers_01 = [];
  var1.spawn_lmg_soldiers_02 = [];
  var1.ref_133c2 = [];
  var1.ref_133c3 = [];
  var2 = [];
  GscBinSkip0(0x2e, "class", []);
}

function ref_1415e(var0, var1, var2, var3, var4) {
  var5 = vehicle_damage_getleveldata();
  var6 = var5.table;

  if(var2 == "weaponMod") {
    var7 = float(var0);

    if(var4 == "class") {
      if(!isDefined(var6.ref_11ca5[var3])) {
        var6.ref_11ca5[var3] = [];
      }

      var6.ref_11ca5[var3][var1] = var7;
    } else if(var4 == "vehicle") {
      if(!isDefined(var6.ref_11ca6[var3])) {
        var6.ref_11ca6[var3] = [];
      }

      var6.ref_11ca6[var3][var1] = var7;
    }
  }

  if(var2 == "weaponHPA") {
    var7 = int(var0);

    if(var4 == "class") {
      if(!isDefined(var6.spawn_lmg_soldiers_01[var3])) {
        var6.spawn_lmg_soldiers_01[var3] = [];
      }

      var6.spawn_lmg_soldiers_01[var3][var1] = var7;
    } else if(var4 == "vehicle") {
      if(!isDefined(var6.spawn_lmg_soldiers_02[var3])) {
        var6.spawn_lmg_soldiers_02[var3] = [];
      }

      var6.spawn_lmg_soldiers_02[var3][var1] = var7;
    }
  }

  if(var2 == "weaponSkipBurnDown") {
    var7 = int(var0) != 0;

    if(var4 == "class") {
      if(!isDefined(var6.ref_133c2[var3])) {
        var6.ref_133c2[var3] = [];
      }

      var6.ref_133c2[var3][var1] = var7;
      return;
    }

    if(var4 == "vehicle") {
      if(!isDefined(var6.ref_133c3[var3])) {
        var6.ref_133c3[var3] = [];
      }

      var6.ref_133c3[var3][var1] = var7;
      return;
    }

    return;
  }
}

function ref_1413d(var0, var1) {
  var2 = vehicle_damage_getleveldata();
  var3 = var2.table;
  var4 = vehicle_damage_getleveldataforvehicle(var0, undefined, var1);

  if(!isDefined(var4)) {
    return;
  }

  var5 = var4.class;

  if(isDefined(var3.ref_11ca5[var5])) {
    foreach(var8, var7 in var3.ref_11ca5[var5]) {
      ref_1417a(var8, var7, 0, var0);
    }
  }

  if(isDefined(var3.ref_11ca6[var0])) {
    foreach(var7 in var3.ref_11ca6[var0]) {
      ref_1417a(var8, var7, 0, var0);
    }
  }

  if(isDefined(var3.spawn_lmg_soldiers_01[var5])) {
    foreach(var12, var11 in var3.spawn_lmg_soldiers_01[var5]) {
      ref_1417c(var12, var11, var0);
      ref_14179(var0, 100, var12);
    }
  }

  if(isDefined(var3.spawn_lmg_soldiers_02[var0])) {
    foreach(var11 in var3.spawn_lmg_soldiers_02[var0]) {
      ref_1417c(var12, var11, var0);
      ref_14179(var0, 100, var12);
    }

    return;
  }
}

function ref_14158() {
  ref_1417b("iw8_la_gromeo_mp", 5);
  ref_1417b("iw8_la_kgolf_mp", 5);
  ref_1417b("iw8_la_t9standard_mp", 5);
  ref_1417b("iw8_la_rpapa7_mp", 5);
  ref_1417b("iw8_la_t9freefire_mp", 5);
  ref_1417b("iw8_la_juliet_mp", 6);
  ref_1417b("iw8_la_gromeoks_mp", 4);
  ref_1417b("iw8_la_mike32_mp", 3);
  ref_1417b("iw8_la_t9launcher_mp", 3);
  ref_1417b("iw8_ar_mike4_mp", 3);
  ref_1417b("iw8_ar_akilo47_mp", 3);
  ref_1417b("frag_grenade_mp", 3);
  ref_1417b("semtex_mp", 3);
  ref_1417b("c4_mp_p", 3);
  ref_1417b("at_mine_ap_mp", 3);
  ref_1417b("at_mine_mp", 3);
  ref_1417b("claymore_mp", 3);
  ref_1417b("molotov_mp", 2);
  ref_1417b("thermite_mp", 2);
  ref_1417b("thermite_av_mp", 1);
  ref_1417b("thermite_bolt_mp", 1);
  ref_1417b("semtex_bolt_mp", 4);
  ref_1417b("thermite_xmike109_mp", 0.5);
  ref_1417b("semtex_xmike109_mp", 2);
  ref_1417b("semtex_aalpha12_mp", 1);
  ref_1417b("apache_proj_mp", 3);
  ref_1417b("toma_proj_mp", 3);
  ref_1417b("cruise_proj_mp", 15);
  ref_1417b("artillery_mp", 3);
  ref_1417b("nuke_mp", 15);
  ref_1417b("ac130_105mm_mp", 15);
  ref_1417b("ac130_40mm_mp", 5);
  ref_1417b("ac130_25mm_mp", 1);
  ref_1417b("hover_jet_proj_mp", 3);
  ref_1417b("assault_drone_mp", 5);
  ref_1417b("emp_drone_non_player_mp", 3);
  ref_1417b("emp_drone_non_player_direct_mp", 5);
}

function ref_14159() {
  ref_1417b("iw8_la_gromeo_mp", 10);
  ref_1417b("iw8_la_kgolf_mp", 10);
  ref_1417b("iw8_la_rpapa7_mp", 10);
  ref_1417b("iw8_la_t9freefire_mp", 10);
  ref_1417b("iw8_la_t9standard_mp", 10);
  ref_1417b("iw8_la_juliet_mp", 20);
  ref_1417b("iw8_la_gromeoks_mp", 10);
  ref_1417b("iw8_la_mike32_mp", 6);
  ref_1417b("iw8_la_t9launcher_mp", 6);
  ref_1417b("iw8_ar_mike4_mp", 6);
  ref_1417b("iw8_ar_akilo47_mp", 6);
  ref_1417b("c4_mp_p", 13);
  ref_1417b("semtex_mp", 4);
  ref_1417b("frag_grenade_mp", 4);
  ref_1417b("pop_rocket_mp", 4);
  ref_1417b("molotov_mp", 1);
  ref_1417b("at_mine_ap_mp", 5);
  ref_1417b("at_mine_mp", 13);
  ref_1417b("thermite_mp", 1);
  ref_1417b("thermite_av_mp", 1);
  ref_1417b("emp_grenade_mp", 4);
  ref_1417b("claymore_mp", 13);
  ref_1417b("thermite_bolt_mp", 1);
  ref_1417b("semtex_bolt_mp", 4);
  ref_1417b("thermite_xmike109_mp", 0.5);
  ref_1417b("semtex_xmike109_mp", 2);
  ref_1417b("semtex_aalpha12_mp", 1);
  ref_1417b("apache_proj_mp", 3);
  ref_1417b("toma_proj_mp", 12);
  ref_1417b("cruise_proj_mp", 15);
  ref_1417b("artillery_mp", 10);
  ref_1417b("nuke_mp", 20);
  ref_1417b("ac130_105mm_mp", 15);
  ref_1417b("ac130_40mm_mp", 6);
  ref_1417b("ac130_25mm_mp", 1);
  ref_1417b("hover_jet_proj_mp", 3);
  ref_1417b("hover_jet_proj_mp", 3);
  ref_1417b("assault_drone_mp", 10);
  ref_1417b("emp_drone_non_player_mp", 3);
  ref_1417b("emp_drone_non_player_direct_mp", 5);
  ref_1417b("s4_la_m1bravo_mp", 10);
  ref_1417b("s4_la_palpha42_mp", 10);
  ref_1417b("s4_la_mkilo1_mp", 10);
  ref_1417b("s4_la_palpha_mp", 10);
  ref_1417b("s4_la_walpha2_mp", 10);
}

function ref_1415a() {
  ref_14174("specialty_armorpiercing", 0.5, 0);
}

function vehicle_damage_getleveldata() {
  return level.vehicle.damage;
}

function vehicle_damage_isselfdamage(var0, var1) {
  if(isDefined(var1.inflictor)) {
    if(var1.inflictor == var0) {
      return true;
    }

    var2 = scripts\cp_mp\vehicles\vehicle::ref_14193(var0);

    foreach(var4 in var2) {
      if(var1.inflictor == var4) {
        return true;
      }
    }

    if(var1.inflictor.classname == "rocket" && isDefined(var1.inflictor.vehicle) && var1.inflictor.vehicle == var0) {
      return true;
    }
  }

  return false;
}

function vehicle_damage_enableownerdamage(var0) {
  var0.ownerdamageenabled = 1;
}

function vehicle_damage_isownerdamageenabled(var0) {
  return istrue(var0.ownerdamageenabled);
}

function vehicle_damage_logevent(var0, var1) {
  if(!isDefined(var0.damageevents)) {
    var0.damageevents = [];
  }

  var0.damageevents[var0.damageevents.size] = var1;
  thread vehicle_damage_cleareventlogatframeend(var0);
}

function vehicle_damage_cleareventlog(var0) {
  var0 notify("vehicle_damage_clearEventLog");
  var0.damageevents = undefined;
}

function vehicle_damage_cleareventlogatframeend(var0) {
  var0 endon("death");
  var0 endon("vehicle_damage_clearEventLog");
  var0 notify("vehicle_damage_clearEventLogAtFrameEnd");
  var0 endon("vehicle_damage_clearEventLogAtFrameEnd");
  waittillframeend();
  thread vehicle_damage_cleareventlog(var0);
}

function vehicle_damage_referevent(var0, var1, var2) {
  if(!isDefined(var2.meansofdeath)) {
    return 0;
  }

  if(!isexplosivedamagemod(var2.meansofdeath)) {
    return 0;
  }

  if(!isDefined(var2.eventid)) {
    return 0;
  }

  if(isDefined(var0.damageevents)) {
    foreach(var4 in var0.damageevents) {
      if(var4.eventid == var2.eventid) {
        return 0;
      }
    }
  }

  if(!isDefined(var2.inflictor)) {
    var2.inflictor = undefined;
  }

  var0 endon("death");
  var0 endon("vehicle_damage_clearEventLog");
  var0 dodamage(var2.damage, var2.point, var2.attacker, var2.inflictor, var2.meansofdeath, var2.objweapon, var2.hitlocation);
  vehicle_damage_logevent(var0, var2);
}

function vehicle_damage_keepturretalive(var0) {
  self endon("death");
  self endon("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(1);
  self.health = 2147483647;
  self waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14, var15);
  var16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var2, self, var1, var10, var5, var14, var4, var3, var6, var8, var7, var9, var15);
  vehicle_damage_referevent(var0, self, var16);
  self.health = 2147483647;
}

function vehicle_damage_keepturretaliveend(var0) {
  self notify("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(0);
}

function vehicle_damage_dovisuals(var0) {
  var1 = vehicle_damage_getleveldataforvehicle(self.vehiclename);

  if(isDefined(var1)) {
    var2 = self.health / self.maxhealth;
    var3 = self.health;
    var4 = 0;

    if(isDefined(var0) && isDefined(var0.damage)) {
      var3 = int(max(0, self.health - var0.damage));
    }

    var5 = var3 / self.maxhealth;
    var6 = getarraykeys(var1.visualpercents);

    if(istrue(var1.visualhighesttolowest)) {
      if(var1.visualpercents.size > 1) {
        var6 = getarraykeys(var1.visualpercents);

        for(var7 = 0; var7 < var6.size; var7++) {
          for(var8 = var7 + 1; var8 < var6.size; var8++) {
            var9 = var1.visualpercents[var6[var7]];
            var10 = var1.visualpercents[var6[var8]];

            if(var9 < var10) {
              var11 = var6[var7];
              var6 = var6[var8];
              var6 = var11;
            }
          }
        }
      }
    }

    for(var7 = 0; var7 < var6.size; var7++) {
      var12 = var6[var7];
      var13 = var1.visualpercents[var12];

      if(var5 > var13) {
        if(isDefined(var1.visualclearcallbacks[var12])) {
          var14 = var2 <= var13;
          self thread[[var1.visualclearcallbacks[var12]]](var0, var14);
        }

        continue;
      }

      if(isDefined(var1.visualcallbacks[var12])) {
        var14 = var2 > var13;
        self thread[[var1.visualcallbacks[var12]]](var0, var14);
      }
    }

    return;
  }
}

function ref_14184(var0, var1) {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
  self endon("vehicle_damage_visualStopWatchingSpeedChange");
  var2 = undefined;

  while(isDefined(self)) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
      var3 = undefined;
      var4 = int(self vehicle_getspeed());
      var5 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

      if(var5 && self vehicle_isonground()) {
        var3 = 0;
      } else if(!var5 && var4 <= 3) {
        var3 = 0;
      } else if(var4 <= 25) {
        var3 = 1;
      } else {
        var3 = 2;
      }

      if(isDefined(var2) && var3 != var2) {
        var6 = ref_1414d(self.vehiclename, var0);
        self thread[[var6.ref_12024]](var0, var1);
        return;
      }

      var3 = var4;
    }

    wait 0.1;
  }
}

function vehicle_damage_visualstopwatchingspeedchange() {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
}

function ref_1415c(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
    self setscriptablepartstate("damageLight", "stopped", 1);
  } else {
    var2 = int(self vehicle_getspeed());
    var3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var3 && self vehicle_isonground()) {
      self setscriptablepartstate("damageLight", "stopped", 1);
    } else if(!var3 && var2 <= 3) {
      self setscriptablepartstate("damageLight", "stopped", 1);
    } else if(var2 <= 25) {
      self setscriptablepartstate("damageLight", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageLight", "highSpeed", 1);
    }
  }

  thread ref_14184("light", var0);
}

function vehicle_damage_lightvisualclearcallback(var0, var1, var2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageLight", "off", 1);
}

function ref_1415f(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
    self setscriptablepartstate("damageMedium", "stopped", 1);
  } else {
    var2 = int(self vehicle_getspeed());
    var3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var3 && self vehicle_isonground()) {
      self setscriptablepartstate("damageMedium", "stopped", 1);
    } else if(!var3 && var2 <= 3) {
      self setscriptablepartstate("damageMedium", "stopped", 1);
    } else if(var2 <= 25) {
      self setscriptablepartstate("damageMedium", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageMedium", "highSpeed", 1);
    }
  }

  thread ref_14184("medium", var0);
}

function vehicle_damage_mediumvisualclearcallback(var0, var1, var2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageMedium", "off", 1);
}

function ref_14157(var0, var1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
    self setscriptablepartstate("damageHeavy", "stopped", 1);
  } else {
    var2 = int(self vehicle_getspeed());
    var3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var3 && self vehicle_isonground()) {
      self setscriptablepartstate("damageHeavy", "stopped", 1);
    } else if(!var3 && var2 <= 3) {
      self setscriptablepartstate("damageHeavy", "stopped", 1);
    } else if(var2 <= 25) {
      self setscriptablepartstate("damageHeavy", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageHeavy", "highSpeed", 1);
    }
  }

  thread ref_14184("heavy", var0);
}

function vehicle_damage_heavyvisualclearcallback(var0, var1, var2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageHeavy", "off", 1);
}

function ref_14145(var0, var1) {
  self setscriptablepartstate("damageEngine", "explode", 1);
}

function ref_14146(var0, var1, var2) {
  self setscriptablepartstate("damageEngine", "off", 1);
}

function ref_14152() {
  if(!isDefined(self.isautouse)) {
    return "pristine";
  }

  return self.isautouse;
}

function ref_14177(var0, var1, var2) {
  self notify("damage_state_change");

  if(var1 != "pristine") {
    var3 = ref_1414d(self.vehiclename, var1);

    if(isDefined(var3.ref_1202d)) {
      self thread[[var3.ref_1202d]](var0, var2);
    }
  }

  if(var0 != "pristine") {
    var3 = ref_1414d(self.vehiclename, var0);

    if(isDefined(var3.ref_12024)) {
      self thread[[var3.ref_12024]](var1, var2);
    }
  }

  self.isautouse = var0;
}

function ref_1417f(var0, var1, var2) {
  var3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var2);

  if(!isDefined(var3)) {
    return;
  }

  self.lasttimedamaged = gettime();
  ref_14182(var0, var1, var2);
}

function ref_14182(var0, var1, var2) {
  var3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var2);
  var4 = self.health;

  if(isDefined(var0) && isDefined(var0.damage)) {
    var4 -= int(var0.damage);
  }

  var5 = "pristine";
  var6 = undefined;
  var7 = undefined;

  foreach(var9 in var3.isattachmentvariantlocked) {
    if(!isDefined(var7) || var9.maxhealth < var7) {
      if(var4 <= var9.maxhealth) {
        var5 = var10;
        var6 = var9;
        var7 = var9.maxhealth;
      }
    }
  }

  var11 = ref_14152();

  if(var5 != var11) {
    if(!istrue(var1)) {
      if(var5 == "heavy" && (!isDefined(var11) || var11 != "heavy")) {
        if(!istrue(self.load_sequence_4_vfx)) {
          var12 = ref_1414b(undefined, self.vehiclename);

          if(isDefined(var12)) {
            if(isDefined(var0) && isDefined(var0.damage) && var0.damage != 0) {
              self.health += var12 - var4;
            }
          }
        }
      }
    }

    ref_14177(var5, var11, var0);
    return;
  }
}

function ref_14180(var0, var1) {
  var2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var1);

  if(!isDefined(var2)) {
    return;
  }

  self.lasttimedamaged = gettime();
  ref_14181(var0);
}

function ref_14181(var0) {
  var1 = self.health;

  if(isDefined(var0) && isDefined(var0.damage)) {
    var1 -= int(var0.damage);
  }

  var2 = var1 / self.maxhealth;

  if(var2 <= 0.1) {
    var3 = "heavy";
  } else if(var3 <= 0.5) {
    var3 = "medium";
  } else if(var3 <= 0.85) {
    var3 = "light";
  } else {
    var3 = "pristine";
  }

  var4 = ref_14152();

  if(var3 != var4) {
    ref_14177(var3, var4, var3);
    return;
  }
}

function ref_14143(var0) {
  if(var0) {
    self.load_sequence_4_vfx = 1;
    return;
  }

  self.load_sequence_4_vfx = undefined;
}

function ref_14165(var0, var1) {
  ref_1415c(var1, 1);

  if(!isDefined(var0) || var0 == "pristine") {
    ref_14166(var0, var1);
    return;
  }
}

function ref_1416a(var0, var1) {
  vehicle_damage_lightvisualclearcallback(var1, 1);
}

function ref_14167(var0, var1) {
  ref_1415f(var1, 1);

  if(!isDefined(var0) || var0 == "light" || var0 == "pristine") {
    ref_14168(var0, var1);
    return;
  }
}

function ref_1416b(var0, var1) {
  vehicle_damage_mediumvisualclearcallback(var1, 1);
}

function ref_14163(var0, var1) {
  ref_14157(var1, 1);

  if(level.gametype != "br") {
    ref_14145(var1, 1);
  }

  if(!isDefined(var0) || var0 != "heavy") {
    if(!istrue(self.move_to_car_stop)) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);
    }

    ref_14164(var0, var1);
    thread ref_1413e(var1);
    return;
  }
}

function ref_14169(var0, var1) {
  vehicle_damage_heavyvisualclearcallback(var1, 1);
  ref_14146(var1, 1);

  if(!isDefined(var0) || var0 != "heavy") {
    if(!istrue(self.move_to_car_stop)) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);
    }

    ref_14144();
    return;
  }
}

function ref_1416c(var0, var1, var2, var3, var4, var5) {
  var6 = vehicle_damage_getleveldataforvehicle(var0, 1);
  var6.health = var1;
  var6.ref_12899 = var2;
  var6.siege_bot_team_triple_cap_check = var3;
  var6.ref_11bb0 = var4;
  var6.flare_setup = var5;
  var7 = ref_1414d(var0, "light", 1);
  var7.ref_12024 = &ref_14165;
  var7.ref_1202d = &ref_1416a;
  var7 = ref_1414d(var0, "medium", 1);
  var7.ref_12024 = &ref_14167;
  var7.ref_1202d = &ref_1416b;
  var7 = ref_1414d(var0, "heavy", 1);
  var7.ref_12024 = &ref_14163;
  var7.ref_1202d = &ref_14169;
  ref_14183(var0);
}

function ref_1414e(var0, var1) {
  if(!isDefined(var1)) {
    var1 = var0.vehiclename;
  }

  var2 = vehicle_damage_getleveldata();
  var3 = vehicle_damage_getleveldataforvehicle(var1, 1);

  if(!isDefined(var3)) {
    if(isDefined(var0)) {
      return var0.maxhealth;
    }

    return undefined;
  }

  if(!isDefined(var3.health)) {
    if(isDefined(var0)) {
      return var0.maxhealth;
    }

    return undefined;
  }

  var4 = var3.health;
  var5 = ref_14150(var1);

  if(isDefined(var5)) {
    var4 += var5;
  }

  var6 = ref_1414a(var1);

  if(isDefined(var6)) {
    var4 += var6;
  }

  return int(var4);
}

function ref_14151(var0, var1) {
  if(!isDefined(var1)) {
    var1 = var0.vehiclename;
  }

  var2 = vehicle_damage_getleveldata();
  var3 = vehicle_damage_getleveldataforvehicle(var1, 1);

  if(!isDefined(var3)) {
    return undefined;
  }

  if(!isDefined(var3.health)) {
    return undefined;
  }

  var4 = var3.health;
  var5 = ref_1414a(var1);

  if(isDefined(var5)) {
    var4 += var5;
  }

  if(!isDefined(var4) || var4 <= 0) {
    return undefined;
  }

  return int(var4);
}

function ref_1414b(var0, var1) {
  if(!isDefined(var1)) {
    var1 = var0.vehiclename;
  }

  var2 = vehicle_damage_getleveldata();
  var3 = vehicle_damage_getleveldataforvehicle(var1);

  if(!isDefined(var3)) {
    return undefined;
  }

  if(!isDefined(var3.health)) {
    return undefined;
  }

  var4 = ref_1414a(var1);

  if(!isDefined(var4) || var4 <= 0) {
    return undefined;
  }

  return int(var4);
}

function ref_14183(var0) {
  var1 = vehicle_damage_getleveldataforvehicle(var0);
  var2 = undefined;
  var3 = undefined;

  foreach(var5 in var1.isattachmentvariantlocked) {
    if(var6 == "light") {
      var5.maxhealth = ref_14151(undefined, var0);
      var3 = var5.maxhealth;
      continue;
    }

    if(var6 == "heavy") {
      var5.maxhealth = ref_1414b(undefined, var0);
      var2 = var5.maxhealth;
    }
  }

  var5 = var1.isattachmentvariantlocked["medium"];

  if(isDefined(var5)) {
    if(isDefined(var2) && isDefined(var3)) {
      var7 = ref_1414f(var0);

      if(isDefined(var7)) {
        var5.maxhealth = int(scripts\engine\math::lerp(var2, var3, var7));
        return;
      }

      return;
    }

    return;
  }
}

function ref_14150(var0) {
  var1 = vehicle_damage_getleveldata();
  var2 = vehicle_damage_getleveldataforvehicle(var0);
  var3 = var2.ref_12899;

  if(!isDefined(var3)) {
    var3 = var1.ref_12899;
  }

  if(!isDefined(var3) || var3 <= 0) {
    return undefined;
  }

  return int(var3);
}

function ref_1414a(var0) {
  var1 = vehicle_damage_getleveldata();
  var2 = vehicle_damage_getleveldataforvehicle(var0);
  var3 = var2.siege_bot_team_triple_cap_check;

  if(!isDefined(var3)) {
    var3 = var1.siege_bot_team_triple_cap_check;
  }

  if(!isDefined(var3) || var3 <= 0) {
    return undefined;
  }

  return int(var3);
}

function ref_1414f(var0) {
  var1 = vehicle_damage_getleveldata();
  var2 = vehicle_damage_getleveldataforvehicle(var0);
  var3 = var2.ref_11bb0;

  if(!isDefined(var3)) {
    var3 = var1.ref_11bb0;
  }

  if(!isDefined(var3) || var3 <= 0 || var3 > 1) {
    return undefined;
  }

  return var3;
}

function ref_1413e(var0) {
  self endon("death");
  self endon("end_burn_down");

  if(!istrue(self.flarecooldown)) {
    var1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(self.vehiclename);
    var2 = var1.destroycallback;
    var3 = ref_14149(self.vehiclename);
    var4 = istrue(self.little_bird_mg_onexitheavydamagestate);

    if(!var4 && isDefined(var3) && isDefined(var2)) {
      self.flarecooldown = 1;
      var5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

      if(isDefined(var5)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", var5, self.vehiclename);
      }

      wait var3;
      self.flarecooldown = undefined;
      scripts\cp_mp\pet_watch::getfullweaponobjforscriptablepartname();
      self.flare_activated = 1;
      self thread[[var2]](var0, 0);
      return;
    }

    return;
  }
}

function ref_14144(var0) {
  if(!istrue(self.flarecooldown)) {
    return;
  }

  self notify("end_burn_down");
  scripts\cp_mp\pet_watch::getfullweaponobjforscriptablepartname();

  if(!istrue(var0)) {
    var1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

    if(isDefined(var1)) {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", var1, self.vehiclename);
    }
  }

  self.flarecooldown = undefined;
}

function ref_1415b() {
  return istrue(self.flarecooldown);
}

function ref_14149(var0) {
  var1 = vehicle_damage_getleveldata();
  var2 = vehicle_damage_getleveldataforvehicle(var0);
  var3 = var2.flare_setup;

  if(!isDefined(var3)) {
    var3 = var1.flare_setup;
  }

  if(!isDefined(var3) || var3 <= 0) {
    return undefined;
  }

  return var3;
}

function ref_1417d(var0) {
  if(isDefined(var0.meansofdeath)) {
    if(var0.meansofdeath == "MOD_CRUSH") {
      return 1;
    }

    if(!isexplosivedamagemod(var0.meansofdeath) && var0.meansofdeath != "MOD_FIRE") {
      return 0;
    }
  }

  if(isDefined(var0.objweapon) && !nullweapon(var0.objweapon) && isDefined(self.vehiclename)) {
    var1 = undefined;
    var2 = self.vehiclename;
    var3 = var0.objweapon.basename;
    var4 = vehicle_damage_getleveldata();
    var5 = var4.table;

    if(isDefined(var4.table.ref_133c3[var2])) {
      var1 = var4.table.ref_133c3[var2][var3];
    }

    if(isDefined(var1)) {
      return var1;
    }

    var6 = vehicle_damage_getleveldataforvehicle(var2, undefined, 1);

    if(isDefined(var6)) {
      var7 = var6.class;

      if(!isDefined(var7) || var7 == "none") {
        return 1;
      }

      if(isDefined(var4.table.ref_133c2[var7])) {
        var1 = var4.table.ref_133c2[var7][var3];
      }

      if(isDefined(var1)) {
        return var1;
      }
    } else {
      return 1;
    }
  } else {
    return 1;
  }

  return 0;
}

function ref_14147(var0, var1, var2, var3, var4) {
  if(isDefined(var1) && var1 == "none") {
    var1 = undefined;
  }

  if(isDefined(var3) && var3 == "none") {
    var3 = undefined;
  }

  if(!istrue(var0.scurrentobjective) && isPlayer(var0.attacker)) {
    var0.scurrentobjective = scripts\cp_mp\vehicles\vehicle::ref_141b7(self, var0.attacker);
  }

  if(isDefined(var0.objweapon) && weaponclass(var0.objweapon.basename) != "rocketlauncher") {
    if(istrue(var2)) {
      var0.ref_12f0d = 1;
    }

    if(istrue(var4)) {
      var0.chestorigin = 1;
    }
  }

  thread ref_14156(var0.attacker, var1, var3, var0);
}

function ref_14166(var0, var1) {
  if(isDefined(var1) && isDefined(var1.attacker)) {
    var2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var2)) {
      var3 = ref_1414c(self, undefined, 1);
      var4 = undefined;
      var5 = undefined;
      var6 = undefined;
      var7 = undefined;

      if(isDefined(var3)) {
        var4 = var3.wind_trigger_toggle;
        var5 = var3.wind_triggers;
        var6 = var3.winbycaptures;
        var7 = var3.wind_trigger_loop;
      }

      ref_14147(var1, var4, var5, var6, var7);
      return;
    }

    return;
  }
}

function ref_14168(var0, var1) {
  if(isDefined(var1) && isDefined(var1.attacker)) {
    var2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var2)) {
      var3 = ref_1414c(self, undefined, 1);
      var4 = undefined;
      var5 = undefined;
      var6 = undefined;
      var7 = undefined;

      if(isDefined(var3)) {
        var4 = var3.ref_11bae;
        var5 = var3.ref_11baf;
        var6 = var3.ref_11bac;
        var7 = var3.ref_11bad;
      }

      ref_14147(var1, var4, var5, var6, var7);
      return;
    }

    return;
  }
}

function ref_14164(var0, var1) {
  if(isDefined(var1) && isDefined(var1.attacker)) {
    var2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var2)) {
      var3 = ref_1414c(self, undefined, 1);
      var4 = undefined;
      var5 = undefined;
      var6 = undefined;
      var7 = undefined;

      if(isDefined(var3)) {
        var4 = var3.sidekillcount;
        var5 = var3.siege_bot_team_had_advantage;
        var6 = var3.shuttingdown;
        var7 = var3.sidehouse_intel_sequence;
      }

      if(isDefined(var2.class)) {
        if(!isDefined(var4)) {
          switch (var2.class) {
            case "light":
            case "super_light":
              var4 = "disabled_vehicle_light";
              break;
            case "medium_heavy":
            case "medium_light":
            case "medium":
              var4 = "disabled_vehicle_medium";
              break;
            case "heavy":
            case "super_heavy":
              var4 = "disabled_vehicle_heavy";
              break;
          }
        }

        if(isDefined(var6)) {}
      }

      ref_14147(var1, var4, var5, var6, var7);
      return;
    }

    return;
  }
}

function ref_14162(var0) {
  if(isDefined(var0) && isDefined(var0.attacker)) {
    var1 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var1)) {
      var2 = ref_1414c(self, undefined, 1);
      var3 = undefined;
      var4 = undefined;
      var5 = undefined;
      var6 = undefined;

      if(isDefined(var2)) {
        var3 = var2.lb_mg_impulse_dmg_threshold_low;
        var4 = var2.lb_mg_impulse_dmg_threshold_mid;
        var5 = var2.lb_mg_dmg_factor_landing_gear;
        var6 = var2.lb_mg_dmg_factor_main_rotor;
      }

      if(isDefined(var1.class)) {
        if(!isDefined(var3)) {
          switch (var1.class) {
            case "light":
            case "super_light":
              var3 = "destroyed_vehicle_light";
              break;
            case "medium_heavy":
            case "medium_light":
            case "medium":
              var3 = "destroyed_vehicle_medium";
              break;
            case "heavy":
            case "super_heavy":
              var3 = "destroyed_vehicle_heavy";
              break;
            default:
              var3 = "none";
              break;
          }
        }

        if(isDefined(var5)) {}
      }

      if(isDefined(var3) && var3 == "none") {
        var3 = undefined;
      }

      if(isDefined(var5) && var5 == "none") {
        var5 = undefined;
      }

      if(isPlayer(var0.attacker)) {
        if(!isDefined(var0.scurrentobjective)) {
          var0.scurrentobjective = scripts\cp_mp\vehicles\vehicle::ref_141b7(self, var0.attacker);
        } else if(var0.scurrentobjective && scripts\cp_mp\vehicles\vehicle::ref_141b9(self, var0.attacker)) {
          var0.scurrentobjective = 0;
        } else if(!var0.scurrentobjective && scripts\cp_mp\vehicles\vehicle::ref_141b7(self, var0.attacker)) {
          var0.scurrentobjective = 1;
        }
      } else {
        var0.scurrentobjective = 0;
      }

      if(isDefined(var0.objweapon) && weaponclass(var0.objweapon.basename) != "rocketlauncher") {
        if(istrue(var4)) {
          var0.ref_12f0d = 1;
        }

        if(istrue(var6)) {
          var0.chestorigin = 1;
        }
      }

      if(var0.scurrentobjective && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onVehicleKilled")) {
        var0.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onVehicleKilled")]](self, var0.inflictor, var0.attacker, var0.damage, var0.objweapon);
      }

      ref_14155(var0.attacker, var3, var5, var0, self getentitynumber());
      return;
    }

    return;
  }
}

function ref_14156(var0, var1, var2, var3) {
  var4 = var3 getentitynumber();
  self endon("disconnect");
  self endon("vehicle_damage_giveScoreAndXP" + var4);
  waittillframeend();
  thread ref_14155(var0, var1, var3, var4);
}

function ref_14155(var0, var1, var2, var3) {
  self notify("vehicle_damage_giveScoreAndXP" + var3);

  if(isDefined(var0) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "giveScore")) {
    var4 = scripts\engine\utility::ter_op(istrue(var2.ref_12f0d), undefined, var2.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "giveScore")]](var0, var4, !istrue(var2.scurrentobjective));
  }

  if(isDefined(var1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "giveAward")) {
    var4 = scripts\engine\utility::ter_op(istrue(var2.chestorigin), undefined, var2.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "giveAward")]](var1, var4, !istrue(var2.scurrentobjective));
    return;
  }
}

function br_iseliminated(var0) {
  var1 = self;

  if(!var0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() && !var0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
    return;
  }

  if(isDefined(var0.inflictor) && isDefined(var0.inflictor.classname) && var0.inflictor.classname == "worldspawn") {
    return;
  }

  var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var1);

  if(var2.size <= 0) {
    return;
  }

  var3 = 0;

  if(!isDefined(var1.waitthensetgendersoundcontext)) {
    var1.waitthensetgendersoundcontext = ["gas", 0, "bombs", 0, "dauntless_turret", 0, "bomber_turret", 0, "aa_truck", 0, "other_vehicle", 0, "aa_turret", 0, "normal_damage", 0, "self_elimination", 0, "trigger_hurt", 0, "launcher", 0, "other", 0];
  }

  var4 = br_isininfil(var0);
  var5 = -1;
  var6 = 0;

  while(var6 < var1.waitthensetgendersoundcontext.size) {
    if(var1.waitthensetgendersoundcontext[var6] == var4) {
      var5 = var6;
    }

    var6 += 2;
  }

  if(var5 == -1) {
    var5 = 22;
  }

  var5 += 1;
  var1.waitthensetgendersoundcontext[var5] += var0.damage;
}

function br_isininfil(var0) {
  var1 = var0.attacker;
  var2 = var0.meansofdeath;
  var3 = "";

  if(isDefined(var0.objweapon) && isDefined(var0.objweapon.basename) && var0.objweapon.basename == "danger_circle_br") {
    var3 = "gas";
  } else if(!isent(var0.attacker)) {
    var3 = "other";
  } else if(var0.attacker == var0.victim) {
    var3 = "self_elimination";
  } else if(isDefined(var0.objweapon) && isDefined(var0.objweapon.basename) && (var0.objweapon.basename == "manual_turret_flak_mp_highrof" || var0.objweapon.basename == "manual_turret_flak_mp" || var0.objweapon.basename == "manual_turret_flak_vehicle")) {
    if(!isDefined(var0.attacker.vehicle)) {
      var3 = "aa_turret";
    } else {
      var3 = "aa_truck";
    }
  } else if(isDefined(var0.objweapon) && isDefined(var0.objweapon.basename) && var0.objweapon.basename == "tur_gun_bt_mp") {
    var3 = "bomber_turret";
  } else if(isDefined(var0.objweapon) && isDefined(var0.objweapon.basename) && var0.objweapon.basename == "tur_gun_bt_mp_bomb") {
    var3 = "bombs";
  } else if(isDefined(var0.objweapon) && isDefined(var0.objweapon.basename) && var0.objweapon.basename == "tur_gun_fd_mp_seeking") {
    var3 = "dauntless_turret";
  } else if(isDefined(var0.attacker.vehicle)) {
    var3 = "other_vehicle";
  } else if(var0.meansofdeath == "MOD_PROJECTILE" || var0.meansofdeath == "MOD_PROJECTILE_SPLASH") {
    var3 = "launcher";
  } else if(isPlayer(var0.attacker)) {
    var3 = "normal_damage";
  }

  return var3;
}

function ref_1417e(var0) {
  var1 = self;

  if(!istrue(level.brking_managecircles)) {
    return;
  }

  if(issubstr(var0.meansofdeath, "BULLET") || var0.meansofdeath == "MOD_PROJECTILE") {
    if(isPlayer(var0.attacker)) {
      var0.attacker setscriptablepartstate("vehicleHitmarkerSound", "vehicleHitmarkerSound", 0);
    }

    if(var0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
      var2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var1);

      if(isDefined(var2)) {
        foreach(var4 in var2) {
          var4 setscriptablepartstate("planeImpactSound", "planeImpactSound", 0);
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_1417a(var0, var1, var2, var3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponClassModDamageForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle")]](var0, var1, var2, var3);
    return;
  }
}

function ref_14174(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPerkModDamage")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPerkModDamage")]](var0, var1, var2);
    return;
  }
}

function ref_1417b(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageData")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageData")]](var0, var1);
    return;
  }
}

function ref_14178(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](var0, var1);
    return;
  }
}

function ref_14179(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]](var0, var1, var2);
    return;
  }
}

function ref_1417c(var0, var1, var2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]](var0, var1, var2);
    return;
  }
}

function ref_14176(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPreModDamageCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPreModDamageCallback")]](var0, var1);
    return;
  }
}

function ref_14175(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPostModDamageCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPostModDamageCallback")]](var0, var1);
    return;
  }
}

function ref_14171(var0, var1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setDeathCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setDeathCallback")]](var0, var1);
    return;
  }
}

function ref_14173(var0, var1, var2) {
  var3 = vehicle_damage_getleveldataforvehicle(var0, 1);

  if(!isDefined(var3.ref_11fa5)) {
    var3.ref_11fa5 = [];
  }

  var3.ref_11fa5[var1] = var2;
}

function ref_14172(var0, var1, var2) {
  var3 = vehicle_damage_getleveldataforvehicle(var0, 1);

  if(!isDefined(var3.ref_11fa4)) {
    var3.ref_11fa4 = [];
  }

  var3.ref_11fa4[var1] = var2;
}

function vehicle_damage_initdebug() {
  setdvarifuninitialized("scr_vehicleGod", 0);
  setdvarifuninitialized("scr_simulateVehicleDamage", 0);
}