/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\vehicles\vehicle_damage.gsc
*****************************************************/

function vehicle_damage_setCanDamage(var_0) {
  var_1 = self getlinkedchildren(1);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(isDefined(var_3.code_classname) && var_3.code_classname == "misc_turret") {
        if(var_0) {
          thread vehicle_damage_keepturretalive(var_3);
          continue;
        }

        vehicle_damage_keepturretaliveend(var_3);
      }
    }
  }

  self setCanDamage(var_0);
  vehicle_damage_cleareventlog(self);
}

function vehicle_damage_getleveldataforvehicle(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldata();
  var_4 = var_3.vehicledata[var_0];

  if(!isDefined(var_4)) {
    if(istrue(var_1)) {
      var_4 = spawnStruct();
      var_3.vehicledata[var_0] = var_4;
      var_4.isattachmentvariantlocked = [];
      var_4.class = "none";
      var_4.showtacmaphint = undefined;
      var_4.ref_12899 = undefined;
      var_4.siege_bot_team_triple_cap_check = undefined;
      var_4.flare_setup = undefined;
      var_4.visualpercents = [];
      var_4.visualcallbacks = [];
      var_4.visualclearcallbacks = [];
      var_4.visualhighesttolowest = undefined;
    } else if(istrue(var_2)) {}
  }

  return var_4;
}

function ref_1414C(var_0, var_1, var_2) {
  var_3 = var_0.damagedata;

  if(!isDefined(var_3)) {
    if(istrue(var_1)) {
      var_3 = spawnStruct();
      var_0.damagedata = var_3;
      var_3.lb_mg_impulse_dmg_threshold_low = undefined;
      var_3.lb_mg_impulse_dmg_threshold_mid = undefined;
      var_3.lb_mg_dmg_factor_landing_gear = undefined;
      var_3.lb_mg_dmg_factor_main_rotor = undefined;
      var_3.sidekillcount = undefined;
      var_3.siege_bot_team_had_advantage = undefined;
      var_3.shuttingdown = undefined;
      var_3.sidehouse_intel_sequence = undefined;
      var_3.ref_11BAE = undefined;
      var_3.ref_11BAF = undefined;
      var_3.ref_11BAC = undefined;
      var_3.ref_11BAD = undefined;
      var_3.wind_trigger_toggle = undefined;
      var_3.wind_triggers = undefined;
      var_3.winbycaptures = undefined;
      var_3.wind_trigger_loop = undefined;
    } else if(istrue(var_2)) {}
  }

  return var_3;
}

function ref_1416E(var_0) {
  return ref_1414C(var_0, 1);
}

function ref_14141(var_0) {
  var_0.damagedata = undefined;
}

function ref_1414D(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_damage_getleveldataforvehicle(var_0, var_2, var_3);
  var_5 = var_4.isattachmentvariantlocked[var_1];

  if(!isDefined(var_5)) {
    if(istrue(var_2)) {
      var_5 = spawnStruct();
      var_4.isattachmentvariantlocked[var_1] = var_5;
      var_5.maxhealth = undefined;
      var_5.ref_12024 = undefined;
      var_5.ref_1202D = undefined;
    } else if(istrue(var_3)) {}
  }

  return var_5;
}

function ref_1416F(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_damage_getleveldataforvehicle(var_0, 1);
  var_5.visualpercents[var_4] = var_1;
  var_5.visualcallbacks[var_4] = var_2;
  var_5.visualclearcallbacks[var_4] = var_3;
}

function ref_14142(var_0, var_1) {
  var_2 = vehicle_damage_getleveldataforvehicle(var_0, 0);

  if(isDefined(var_2)) {
    var_2.visualpercents[var_1] = undefined;
    var_2.visualcallbacks[var_1] = undefined;
    var_2.visualclearcallbacks[var_1] = undefined;
    return;
  }
}

function ref_1416D(var_0) {
  var_1 = vehicle_damage_getleveldataforvehicle(var_0, 1);
  var_1.visualhighesttolowest = 1;
  ref_1416F(var_0, 0.85, &ref_1415C, &vehicle_damage_lightvisualclearcallback, "light");
  ref_1416F(var_0, 0.5, &ref_1415F, &vehicle_damage_mediumvisualclearcallback, "medium");
  ref_1416F(var_0, 0.15, &ref_14157, &vehicle_damage_heavyvisualclearcallback, "heavy");

  if(level.gametype != "br") {
    ref_1416F(var_0, 0.15, &ref_14145, &ref_14146, "engine");
    return;
  }
}

function ref_14140(var_0) {
  var_1 = vehicle_damage_getleveldataforvehicle(var_0, 1);
  var_1.visualhighesttolowest = undefined;
  ref_14142(var_0, "light");
  ref_14142(var_0, "medium");
  ref_14142(var_0, "heavy");
  ref_14142(var_0, "engine");
}

function vehicle_damage_clearvisuals(var_0, var_1, var_2) {
  if(isDefined(self.vehiclename)) {
    var_3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, 0, 1);

    if(isDefined(var_3)) {
      foreach(var_5 in var_3.visualclearcallbacks) {
        self thread[[var_5]](var_0, var_1, var_2);
      }

      return;
    }

    return;
  }
}

function ref_14170() {
  ref_1413C(self.maxhealth);
}

function ref_1413C(var_0) {
  self.health = int(min(self.health + var_0, self.maxhealth));
  var_1 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

  if(!isDefined(var_1)) {
    return;
  }

  if(level.gametype == "br") {
    ref_14181();
  } else {
    ref_14182(undefined, 0, 1);
  }

  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_updateomnvarsondamage(self);
}

function ref_14160(var_0, var_1, var_2) {
  var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(var_0, var_1);
  var_4 = vehicle_damage_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_3)) {
    if(isDefined(var_4.ref_11FA5) && isDefined(var_4.ref_11FA5[var_3])) {
      var_2 *= var_4.ref_11FA5[var_3];
    }

    if(isDefined(var_4.ref_11FA4) && isDefined(var_4.ref_11FA4[var_3])) {
      var_2 = clamp(var_2, 0, var_4.ref_11FA4[var_3]);
    }
  }

  return var_2;
}

function vehicle_damage_init() {
  var_0 = spawnStruct();
  level.vehicle.damage = var_0;
  var_0.vehicledata = [];
  var_0.ref_12899 = getdvarint("scr_vehicleDamageStatePristineHealthAdd", 125);
  var_0.siege_bot_team_triple_cap_check = getdvarint("scr_vehicleDamageStateHeavyHealthAdd", 350);
  var_0.ref_11BB0 = getdvarfloat("scr_vehicleDamageStateMediumHealthRatio", 0.5);
  var_0.flare_setup = getdvarfloat("scr_vehicleDamageBurnDownTime", 8);
  ref_1415D();
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
  ref_1415A();
}

function ref_1415D() {
  var_0 = vehicle_damage_getleveldata();
  var_1 = spawnStruct();
  var_0.table = var_1;
  var_1.ref_11CA5 = [];
  var_1.ref_11CA6 = [];
  var_1.spawn_lmg_soldiers_01 = [];
  var_1.spawn_lmg_soldiers_02 = [];
  var_1.ref_133C2 = [];
  var_1.ref_133C3 = [];
  var_2 = [];
  GscBinSkip0(0x2e, "class", []);
}

function ref_1415E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_damage_getleveldata();
  var_6 = var_5.table;

  if(var_2 == "weaponMod") {
    var_7 = float(var_0);

    if(var_4 == "class") {
      if(!isDefined(var_6.ref_11CA5[var_3])) {
        var_6.ref_11CA5[var_3] = [];
      }

      var_6.ref_11CA5[var_3][var_1] = var_7;
    } else if(var_4 == "vehicle") {
      if(!isDefined(var_6.ref_11CA6[var_3])) {
        var_6.ref_11CA6[var_3] = [];
      }

      var_6.ref_11CA6[var_3][var_1] = var_7;
    }
  }

  if(var_2 == "weaponHPA") {
    var_7 = int(var_0);

    if(var_4 == "class") {
      if(!isDefined(var_6.spawn_lmg_soldiers_01[var_3])) {
        var_6.spawn_lmg_soldiers_01[var_3] = [];
      }

      var_6.spawn_lmg_soldiers_01[var_3][var_1] = var_7;
    } else if(var_4 == "vehicle") {
      if(!isDefined(var_6.spawn_lmg_soldiers_02[var_3])) {
        var_6.spawn_lmg_soldiers_02[var_3] = [];
      }

      var_6.spawn_lmg_soldiers_02[var_3][var_1] = var_7;
    }
  }

  if(var_2 == "weaponSkipBurnDown") {
    var_7 = int(var_0) != 0;

    if(var_4 == "class") {
      if(!isDefined(var_6.ref_133C2[var_3])) {
        var_6.ref_133C2[var_3] = [];
      }

      var_6.ref_133C2[var_3][var_1] = var_7;
      return;
    }

    if(var_4 == "vehicle") {
      if(!isDefined(var_6.ref_133C3[var_3])) {
        var_6.ref_133C3[var_3] = [];
      }

      var_6.ref_133C3[var_3][var_1] = var_7;
      return;
    }

    return;
  }
}

function ref_1413D(var_0, var_1) {
  var_2 = vehicle_damage_getleveldata();
  var_3 = var_2.table;
  var_4 = vehicle_damage_getleveldataforvehicle(var_0, undefined, var_1);

  if(!isDefined(var_4)) {
    return;
  }

  var_5 = var_4.class;

  if(isDefined(var_3.ref_11CA5[var_5])) {
    foreach(var_8, var_7 in var_3.ref_11CA5[var_5]) {
      ref_1417A(var_8, var_7, 0, var_0);
    }
  }

  if(isDefined(var_3.ref_11CA6[var_0])) {
    foreach(var_7 in var_3.ref_11CA6[var_0]) {
      ref_1417A(var_8, var_7, 0, var_0);
    }
  }

  if(isDefined(var_3.spawn_lmg_soldiers_01[var_5])) {
    foreach(var_12, var_11 in var_3.spawn_lmg_soldiers_01[var_5]) {
      ref_1417C(var_12, var_11, var_0);
      ref_14179(var_0, 100, var_12);
    }
  }

  if(isDefined(var_3.spawn_lmg_soldiers_02[var_0])) {
    foreach(var_11 in var_3.spawn_lmg_soldiers_02[var_0]) {
      ref_1417C(var_12, var_11, var_0);
      ref_14179(var_0, 100, var_12);
    }

    return;
  }
}

function ref_14158() {
  ref_1417B("iw8_la_gromeo_mp", 5);
  ref_1417B("iw8_la_kgolf_mp", 5);
  ref_1417B("iw8_la_t9standard_mp", 5);
  ref_1417B("iw8_la_rpapa7_mp", 5);
  ref_1417B("iw8_la_t9freefire_mp", 5);
  ref_1417B("iw8_la_juliet_mp", 6);
  ref_1417B("iw8_la_gromeoks_mp", 4);
  ref_1417B("iw8_la_mike32_mp", 3);
  ref_1417B("iw8_la_t9launcher_mp", 3);
  ref_1417B("iw8_ar_mike4_mp", 3);
  ref_1417B("iw8_ar_akilo47_mp", 3);
  ref_1417B("frag_grenade_mp", 3);
  ref_1417B("semtex_mp", 3);
  ref_1417B("c4_mp_p", 3);
  ref_1417B("at_mine_ap_mp", 3);
  ref_1417B("at_mine_mp", 3);
  ref_1417B("claymore_mp", 3);
  ref_1417B("molotov_mp", 2);
  ref_1417B("thermite_mp", 2);
  ref_1417B("thermite_av_mp", 1);
  ref_1417B("thermite_bolt_mp", 1);
  ref_1417B("semtex_bolt_mp", 4);
  ref_1417B("thermite_xmike109_mp", 0.5);
  ref_1417B("semtex_xmike109_mp", 2);
  ref_1417B("semtex_aalpha12_mp", 1);
  ref_1417B("apache_proj_mp", 3);
  ref_1417B("toma_proj_mp", 3);
  ref_1417B("cruise_proj_mp", 15);
  ref_1417B("artillery_mp", 3);
  ref_1417B("nuke_mp", 15);
  ref_1417B("ac130_105mm_mp", 15);
  ref_1417B("ac130_40mm_mp", 5);
  ref_1417B("ac130_25mm_mp", 1);
  ref_1417B("hover_jet_proj_mp", 3);
  ref_1417B("assault_drone_mp", 5);
  ref_1417B("emp_drone_non_player_mp", 3);
  ref_1417B("emp_drone_non_player_direct_mp", 5);
}

function ref_14159() {
  ref_1417B("iw8_la_gromeo_mp", 10);
  ref_1417B("iw8_la_kgolf_mp", 10);
  ref_1417B("iw8_la_rpapa7_mp", 10);
  ref_1417B("iw8_la_t9freefire_mp", 10);
  ref_1417B("iw8_la_t9standard_mp", 10);
  ref_1417B("iw8_la_juliet_mp", 20);
  ref_1417B("iw8_la_gromeoks_mp", 10);
  ref_1417B("iw8_la_mike32_mp", 6);
  ref_1417B("iw8_la_t9launcher_mp", 6);
  ref_1417B("iw8_ar_mike4_mp", 6);
  ref_1417B("iw8_ar_akilo47_mp", 6);
  ref_1417B("c4_mp_p", 13);
  ref_1417B("semtex_mp", 4);
  ref_1417B("frag_grenade_mp", 4);
  ref_1417B("pop_rocket_mp", 4);
  ref_1417B("molotov_mp", 1);
  ref_1417B("at_mine_ap_mp", 5);
  ref_1417B("at_mine_mp", 13);
  ref_1417B("thermite_mp", 1);
  ref_1417B("thermite_av_mp", 1);
  ref_1417B("emp_grenade_mp", 4);
  ref_1417B("claymore_mp", 13);
  ref_1417B("thermite_bolt_mp", 1);
  ref_1417B("semtex_bolt_mp", 4);
  ref_1417B("thermite_xmike109_mp", 0.5);
  ref_1417B("semtex_xmike109_mp", 2);
  ref_1417B("semtex_aalpha12_mp", 1);
  ref_1417B("apache_proj_mp", 3);
  ref_1417B("toma_proj_mp", 12);
  ref_1417B("cruise_proj_mp", 15);
  ref_1417B("artillery_mp", 10);
  ref_1417B("nuke_mp", 20);
  ref_1417B("ac130_105mm_mp", 15);
  ref_1417B("ac130_40mm_mp", 6);
  ref_1417B("ac130_25mm_mp", 1);
  ref_1417B("hover_jet_proj_mp", 3);
  ref_1417B("hover_jet_proj_mp", 3);
  ref_1417B("assault_drone_mp", 10);
  ref_1417B("emp_drone_non_player_mp", 3);
  ref_1417B("emp_drone_non_player_direct_mp", 5);
  ref_1417B("s4_la_m1bravo_mp", 10);
  ref_1417B("s4_la_palpha42_mp", 10);
  ref_1417B("s4_la_mkilo1_mp", 10);
  ref_1417B("s4_la_palpha_mp", 10);
  ref_1417B("s4_la_walpha2_mp", 10);
}

function ref_1415A() {
  ref_14174("specialty_armorpiercing", 0.5, 0);
}

function vehicle_damage_getleveldata() {
  return level.vehicle.damage;
}

function vehicle_damage_isselfdamage(var_0, var_1) {
  if(isDefined(var_1.inflictor)) {
    if(var_1.inflictor == var_0) {
      return true;
    }

    var_2 = scripts\cp_mp\vehicles\vehicle::ref_14193(var_0);

    foreach(var_4 in var_2) {
      if(var_1.inflictor == var_4) {
        return true;
      }
    }

    if(var_1.inflictor.classname == "rocket" && isDefined(var_1.inflictor.vehicle) && var_1.inflictor.vehicle == var_0) {
      return true;
    }
  }

  return false;
}

function vehicle_damage_enableownerdamage(var_0) {
  var_0.ownerdamageenabled = 1;
}

function vehicle_damage_isownerdamageenabled(var_0) {
  return istrue(var_0.ownerdamageenabled);
}

function vehicle_damage_logevent(var_0, var_1) {
  if(!isDefined(var_0.damageevents)) {
    var_0.damageevents = [];
  }

  var_0.damageevents[var_0.damageevents.size] = var_1;
  thread vehicle_damage_cleareventlogatframeend(var_0);
}

function vehicle_damage_cleareventlog(var_0) {
  var_0 notify("vehicle_damage_clearEventLog");
  var_0.damageevents = undefined;
}

function vehicle_damage_cleareventlogatframeend(var_0) {
  var_0 endon("death");
  var_0 endon("vehicle_damage_clearEventLog");
  var_0 notify("vehicle_damage_clearEventLogAtFrameEnd");
  var_0 endon("vehicle_damage_clearEventLogAtFrameEnd");
  waittillframeend();
  thread vehicle_damage_cleareventlog(var_0);
}

function vehicle_damage_referevent(var_0, var_1, var_2) {
  if(!isDefined(var_2.meansofdeath)) {
    return 0;
  }

  if(!isexplosivedamagemod(var_2.meansofdeath)) {
    return 0;
  }

  if(!isDefined(var_2.eventid)) {
    return 0;
  }

  if(isDefined(var_0.damageevents)) {
    foreach(var_4 in var_0.damageevents) {
      if(var_4.eventid == var_2.eventid) {
        return 0;
      }
    }
  }

  if(!isDefined(var_2.inflictor)) {
    var_2.inflictor = undefined;
  }

  var_0 endon("death");
  var_0 endon("vehicle_damage_clearEventLog");
  var_0 dodamage(var_2.damage, var_2.point, var_2.attacker, var_2.inflictor, var_2.meansofdeath, var_2.objweapon, var_2.hitlocation);
  vehicle_damage_logevent(var_0, var_2);
}

function vehicle_damage_keepturretalive(var_0) {
  self endon("death");
  self endon("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(1);
  self.health = 2147483647;
  self waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15);
  var_16 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_2, self, var_1, var_10, var_5, var_14, var_4, var_3, var_6, var_8, var_7, var_9, var_15);
  vehicle_damage_referevent(var_0, self, var_16);
  self.health = 2147483647;
}

function vehicle_damage_keepturretaliveend(var_0) {
  self notify("vehicle_damage_keepTurretAliveEnd");
  self setCanDamage(0);
}

function vehicle_damage_dovisuals(var_0) {
  var_1 = vehicle_damage_getleveldataforvehicle(self.vehiclename);

  if(isDefined(var_1)) {
    var_2 = self.health / self.maxhealth;
    var_3 = self.health;
    var_4 = 0;

    if(isDefined(var_0) && isDefined(var_0.damage)) {
      var_3 = int(max(0, self.health - var_0.damage));
    }

    var_5 = var_3 / self.maxhealth;
    var_6 = getarraykeys(var_1.visualpercents);

    if(istrue(var_1.visualhighesttolowest)) {
      if(var_1.visualpercents.size > 1) {
        var_6 = getarraykeys(var_1.visualpercents);

        for(var_7 = 0; var_7 < var_6.size; var_7++) {
          for(var_8 = var_7 + 1; var_8 < var_6.size; var_8++) {
            var_9 = var_1.visualpercents[var_6[var_7]];
            var_10 = var_1.visualpercents[var_6[var_8]];

            if(var_9 < var_10) {
              var_11 = var_6[var_7];
              var_6 = var_6[var_8];
              var_6 = var_11;
            }
          }
        }
      }
    }

    for(var_7 = 0; var_7 < var_6.size; var_7++) {
      var_12 = var_6[var_7];
      var_13 = var_1.visualpercents[var_12];

      if(var_5 > var_13) {
        if(isDefined(var_1.visualclearcallbacks[var_12])) {
          var_14 = var_2 <= var_13;
          self thread[[var_1.visualclearcallbacks[var_12]]](var_0, var_14);
        }

        continue;
      }

      if(isDefined(var_1.visualcallbacks[var_12])) {
        var_14 = var_2 > var_13;
        self thread[[var_1.visualcallbacks[var_12]]](var_0, var_14);
      }
    }

    return;
  }
}

function ref_14184(var_0, var_1) {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
  self endon("vehicle_damage_visualStopWatchingSpeedChange");
  var_2 = undefined;

  while(isDefined(self)) {
    if(!scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
      var_3 = undefined;
      var_4 = int(self vehicle_getspeed());
      var_5 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

      if(var_5 && self vehicle_isonground()) {
        var_3 = 0;
      } else if(!var_5 && var_4 <= 3) {
        var_3 = 0;
      } else if(var_4 <= 25) {
        var_3 = 1;
      } else {
        var_3 = 2;
      }

      if(isDefined(var_2) && var_3 != var_2) {
        var_6 = ref_1414D(self.vehiclename, var_0);
        self thread[[var_6.ref_12024]](var_0, var_1);
        return;
      }

      var_3 = var_4;
    }

    wait 0.1;
  }
}

function vehicle_damage_visualstopwatchingspeedchange() {
  self notify("vehicle_damage_visualStopWatchingSpeedChange");
}

function ref_1415C(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
    self setscriptablepartstate("damageLight", "stopped", 1);
  } else {
    var_2 = int(self vehicle_getspeed());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var_3 && self vehicle_isonground()) {
      self setscriptablepartstate("damageLight", "stopped", 1);
    } else if(!var_3 && var_2 <= 3) {
      self setscriptablepartstate("damageLight", "stopped", 1);
    } else if(var_2 <= 25) {
      self setscriptablepartstate("damageLight", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageLight", "highSpeed", 1);
    }
  }

  thread ref_14184("light", var_0);
}

function vehicle_damage_lightvisualclearcallback(var_0, var_1, var_2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageLight", "off", 1);
}

function ref_1415F(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
    self setscriptablepartstate("damageMedium", "stopped", 1);
  } else {
    var_2 = int(self vehicle_getspeed());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var_3 && self vehicle_isonground()) {
      self setscriptablepartstate("damageMedium", "stopped", 1);
    } else if(!var_3 && var_2 <= 3) {
      self setscriptablepartstate("damageMedium", "stopped", 1);
    } else if(var_2 <= 25) {
      self setscriptablepartstate("damageMedium", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageMedium", "highSpeed", 1);
    }
  }

  thread ref_14184("medium", var_0);
}

function vehicle_damage_mediumvisualclearcallback(var_0, var_1, var_2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageMedium", "off", 1);
}

function ref_14157(var_0, var_1) {
  if(scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle()) {
    self setscriptablepartstate("damageHeavy", "stopped", 1);
  } else {
    var_2 = int(self vehicle_getspeed());
    var_3 = istrue(scripts\cp_mp\vehicles\vehicle::vehiclecanfly());

    if(var_3 && self vehicle_isonground()) {
      self setscriptablepartstate("damageHeavy", "stopped", 1);
    } else if(!var_3 && var_2 <= 3) {
      self setscriptablepartstate("damageHeavy", "stopped", 1);
    } else if(var_2 <= 25) {
      self setscriptablepartstate("damageHeavy", "lowSpeed", 1);
    } else {
      self setscriptablepartstate("damageHeavy", "highSpeed", 1);
    }
  }

  thread ref_14184("heavy", var_0);
}

function vehicle_damage_heavyvisualclearcallback(var_0, var_1, var_2) {
  vehicle_damage_visualstopwatchingspeedchange();
  self setscriptablepartstate("damageHeavy", "off", 1);
}

function ref_14145(var_0, var_1) {
  self setscriptablepartstate("damageEngine", "explode", 1);
}

function ref_14146(var_0, var_1, var_2) {
  self setscriptablepartstate("damageEngine", "off", 1);
}

function ref_14152() {
  if(!isDefined(self.isautouse)) {
    return "pristine";
  }

  return self.isautouse;
}

function ref_14177(var_0, var_1, var_2) {
  self notify("damage_state_change");

  if(var_1 != "pristine") {
    var_3 = ref_1414D(self.vehiclename, var_1);

    if(isDefined(var_3.ref_1202D)) {
      self thread[[var_3.ref_1202D]](var_0, var_2);
    }
  }

  if(var_0 != "pristine") {
    var_3 = ref_1414D(self.vehiclename, var_0);

    if(isDefined(var_3.ref_12024)) {
      self thread[[var_3.ref_12024]](var_1, var_2);
    }
  }

  self.isautouse = var_0;
}

function ref_1417F(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var_2);

  if(!isDefined(var_3)) {
    return;
  }

  self.lasttimedamaged = gettime();
  ref_14182(var_0, var_1, var_2);
}

function ref_14182(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var_2);
  var_4 = self.health;

  if(isDefined(var_0) && isDefined(var_0.damage)) {
    var_4 -= int(var_0.damage);
  }

  var_5 = "pristine";
  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in var_3.isattachmentvariantlocked) {
    if(!isDefined(var_7) || var_9.maxhealth < var_7) {
      if(var_4 <= var_9.maxhealth) {
        var_5 = var_10;
        var_6 = var_9;
        var_7 = var_9.maxhealth;
      }
    }
  }

  var_11 = ref_14152();

  if(var_5 != var_11) {
    if(!istrue(var_1)) {
      if(var_5 == "heavy" && (!isDefined(var_11) || var_11 != "heavy")) {
        if(!istrue(self.load_sequence_4_vfx)) {
          var_12 = ref_1414B(undefined, self.vehiclename);

          if(isDefined(var_12)) {
            if(isDefined(var_0) && isDefined(var_0.damage) && var_0.damage != 0) {
              self.health += var_12 - var_4;
            }
          }
        }
      }
    }

    ref_14177(var_5, var_11, var_0);
    return;
  }
}

function ref_14180(var_0, var_1) {
  var_2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, var_1);

  if(!isDefined(var_2)) {
    return;
  }

  self.lasttimedamaged = gettime();
  ref_14181(var_0);
}

function ref_14181(var_0) {
  var_1 = self.health;

  if(isDefined(var_0) && isDefined(var_0.damage)) {
    var_1 -= int(var_0.damage);
  }

  var_2 = var_1 / self.maxhealth;

  if(var_2 <= 0.1) {
    var_3 = "heavy";
  } else if(var_3 <= 0.5) {
    var_3 = "medium";
  } else if(var_3 <= 0.85) {
    var_3 = "light";
  } else {
    var_3 = "pristine";
  }

  var_4 = ref_14152();

  if(var_3 != var_4) {
    ref_14177(var_3, var_4, var_3);
    return;
  }
}

function ref_14143(var_0) {
  if(var_0) {
    self.load_sequence_4_vfx = 1;
    return;
  }

  self.load_sequence_4_vfx = undefined;
}

function ref_14165(var_0, var_1) {
  ref_1415C(var_1, 1);

  if(!isDefined(var_0) || var_0 == "pristine") {
    ref_14166(var_0, var_1);
    return;
  }
}

function ref_1416A(var_0, var_1) {
  vehicle_damage_lightvisualclearcallback(var_1, 1);
}

function ref_14167(var_0, var_1) {
  ref_1415F(var_1, 1);

  if(!isDefined(var_0) || var_0 == "light" || var_0 == "pristine") {
    ref_14168(var_0, var_1);
    return;
  }
}

function ref_1416B(var_0, var_1) {
  vehicle_damage_mediumvisualclearcallback(var_1, 1);
}

function ref_14163(var_0, var_1) {
  ref_14157(var_1, 1);

  if(level.gametype != "br") {
    ref_14145(var_1, 1);
  }

  if(!isDefined(var_0) || var_0 != "heavy") {
    if(!istrue(self.move_to_car_stop)) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 0);
    }

    ref_14164(var_0, var_1);
    thread ref_1413E(var_1);
    return;
  }
}

function ref_14169(var_0, var_1) {
  vehicle_damage_heavyvisualclearcallback(var_1, 1);
  ref_14146(var_1, 1);

  if(!isDefined(var_0) || var_0 != "heavy") {
    if(!istrue(self.move_to_car_stop)) {
      scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_allowmovement(self, 1);
    }

    ref_14144();
    return;
  }
}

function ref_1416C(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = vehicle_damage_getleveldataforvehicle(var_0, 1);
  var_6.health = var_1;
  var_6.ref_12899 = var_2;
  var_6.siege_bot_team_triple_cap_check = var_3;
  var_6.ref_11BB0 = var_4;
  var_6.flare_setup = var_5;
  var_7 = ref_1414D(var_0, "light", 1);
  var_7.ref_12024 = &ref_14165;
  var_7.ref_1202D = &ref_1416A;
  var_7 = ref_1414D(var_0, "medium", 1);
  var_7.ref_12024 = &ref_14167;
  var_7.ref_1202D = &ref_1416B;
  var_7 = ref_1414D(var_0, "heavy", 1);
  var_7.ref_12024 = &ref_14163;
  var_7.ref_1202D = &ref_14169;
  ref_14183(var_0);
}

function ref_1414E(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.vehiclename;
  }

  var_2 = vehicle_damage_getleveldata();
  var_3 = vehicle_damage_getleveldataforvehicle(var_1, 1);

  if(!isDefined(var_3)) {
    if(isDefined(var_0)) {
      return var_0.maxhealth;
    }

    return undefined;
  }

  if(!isDefined(var_3.health)) {
    if(isDefined(var_0)) {
      return var_0.maxhealth;
    }

    return undefined;
  }

  var_4 = var_3.health;
  var_5 = ref_14150(var_1);

  if(isDefined(var_5)) {
    var_4 += var_5;
  }

  var_6 = ref_1414A(var_1);

  if(isDefined(var_6)) {
    var_4 += var_6;
  }

  return int(var_4);
}

function ref_14151(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.vehiclename;
  }

  var_2 = vehicle_damage_getleveldata();
  var_3 = vehicle_damage_getleveldataforvehicle(var_1, 1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  if(!isDefined(var_3.health)) {
    return undefined;
  }

  var_4 = var_3.health;
  var_5 = ref_1414A(var_1);

  if(isDefined(var_5)) {
    var_4 += var_5;
  }

  if(!isDefined(var_4) || var_4 <= 0) {
    return undefined;
  }

  return int(var_4);
}

function ref_1414B(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = var_0.vehiclename;
  }

  var_2 = vehicle_damage_getleveldata();
  var_3 = vehicle_damage_getleveldataforvehicle(var_1);

  if(!isDefined(var_3)) {
    return undefined;
  }

  if(!isDefined(var_3.health)) {
    return undefined;
  }

  var_4 = ref_1414A(var_1);

  if(!isDefined(var_4) || var_4 <= 0) {
    return undefined;
  }

  return int(var_4);
}

function ref_14183(var_0) {
  var_1 = vehicle_damage_getleveldataforvehicle(var_0);
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1.isattachmentvariantlocked) {
    if(var_6 == "light") {
      var_5.maxhealth = ref_14151(undefined, var_0);
      var_3 = var_5.maxhealth;
      continue;
    }

    if(var_6 == "heavy") {
      var_5.maxhealth = ref_1414B(undefined, var_0);
      var_2 = var_5.maxhealth;
    }
  }

  var_5 = var_1.isattachmentvariantlocked["medium"];

  if(isDefined(var_5)) {
    if(isDefined(var_2) && isDefined(var_3)) {
      var_7 = ref_1414F(var_0);

      if(isDefined(var_7)) {
        var_5.maxhealth = int(scripts\engine\math::lerp(var_2, var_3, var_7));
        return;
      }

      return;
    }

    return;
  }
}

function ref_14150(var_0) {
  var_1 = vehicle_damage_getleveldata();
  var_2 = vehicle_damage_getleveldataforvehicle(var_0);
  var_3 = var_2.ref_12899;

  if(!isDefined(var_3)) {
    var_3 = var_1.ref_12899;
  }

  if(!isDefined(var_3) || var_3 <= 0) {
    return undefined;
  }

  return int(var_3);
}

function ref_1414A(var_0) {
  var_1 = vehicle_damage_getleveldata();
  var_2 = vehicle_damage_getleveldataforvehicle(var_0);
  var_3 = var_2.siege_bot_team_triple_cap_check;

  if(!isDefined(var_3)) {
    var_3 = var_1.siege_bot_team_triple_cap_check;
  }

  if(!isDefined(var_3) || var_3 <= 0) {
    return undefined;
  }

  return int(var_3);
}

function ref_1414F(var_0) {
  var_1 = vehicle_damage_getleveldata();
  var_2 = vehicle_damage_getleveldataforvehicle(var_0);
  var_3 = var_2.ref_11BB0;

  if(!isDefined(var_3)) {
    var_3 = var_1.ref_11BB0;
  }

  if(!isDefined(var_3) || var_3 <= 0 || var_3 > 1) {
    return undefined;
  }

  return var_3;
}

function ref_1413E(var_0) {
  self endon("death");
  self endon("end_burn_down");

  if(!istrue(self.flarecooldown)) {
    var_1 = scripts\cp_mp\vehicles\vehicle::vehicle_getleveldataforvehicle(self.vehiclename);
    var_2 = var_1.destroycallback;
    var_3 = ref_14149(self.vehiclename);
    var_4 = istrue(self.little_bird_mg_onexitheavydamagestate);

    if(!var_4 && isDefined(var_3) && isDefined(var_2)) {
      self.flarecooldown = 1;
      var_5 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

      if(isDefined(var_5)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("burningDown", var_5, self.vehiclename);
      }

      wait var_3;
      self.flarecooldown = undefined;
      scripts\cp_mp\pet_watch::getfullweaponobjforscriptablepartname();
      self.flare_activated = 1;
      self thread[[var_2]](var_0, 0);
      return;
    }

    return;
  }
}

function ref_14144(var_0) {
  if(!istrue(self.flarecooldown)) {
    return;
  }

  self notify("end_burn_down");
  scripts\cp_mp\pet_watch::getfullweaponobjforscriptablepartname();

  if(!istrue(var_0)) {
    var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self, 0);

    if(isDefined(var_1)) {
      scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("burningDown", var_1, self.vehiclename);
    }
  }

  self.flarecooldown = undefined;
}

function ref_1415B() {
  return istrue(self.flarecooldown);
}

function ref_14149(var_0) {
  var_1 = vehicle_damage_getleveldata();
  var_2 = vehicle_damage_getleveldataforvehicle(var_0);
  var_3 = var_2.flare_setup;

  if(!isDefined(var_3)) {
    var_3 = var_1.flare_setup;
  }

  if(!isDefined(var_3) || var_3 <= 0) {
    return undefined;
  }

  return var_3;
}

function ref_1417D(var_0) {
  if(isDefined(var_0.meansofdeath)) {
    if(var_0.meansofdeath == "MOD_CRUSH") {
      return 1;
    }

    if(!isexplosivedamagemod(var_0.meansofdeath) && var_0.meansofdeath != "MOD_FIRE") {
      return 0;
    }
  }

  if(isDefined(var_0.objweapon) && !nullweapon(var_0.objweapon) && isDefined(self.vehiclename)) {
    var_1 = undefined;
    var_2 = self.vehiclename;
    var_3 = var_0.objweapon.basename;
    var_4 = vehicle_damage_getleveldata();
    var_5 = var_4.table;

    if(isDefined(var_4.table.ref_133C3[var_2])) {
      var_1 = var_4.table.ref_133C3[var_2][var_3];
    }

    if(isDefined(var_1)) {
      return var_1;
    }

    var_6 = vehicle_damage_getleveldataforvehicle(var_2, undefined, 1);

    if(isDefined(var_6)) {
      var_7 = var_6.class;

      if(!isDefined(var_7) || var_7 == "none") {
        return 1;
      }

      if(isDefined(var_4.table.ref_133C2[var_7])) {
        var_1 = var_4.table.ref_133C2[var_7][var_3];
      }

      if(isDefined(var_1)) {
        return var_1;
      }
    } else {
      return 1;
    }
  } else {
    return 1;
  }

  return 0;
}

function ref_14147(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_1) && var_1 == "none") {
    var_1 = undefined;
  }

  if(isDefined(var_3) && var_3 == "none") {
    var_3 = undefined;
  }

  if(!istrue(var_0.scurrentobjective) && isPlayer(var_0.attacker)) {
    var_0.scurrentobjective = scripts\cp_mp\vehicles\vehicle::ref_141B7(self, var_0.attacker);
  }

  if(isDefined(var_0.objweapon) && weaponclass(var_0.objweapon.basename) != "rocketlauncher") {
    if(istrue(var_2)) {
      var_0.ref_12F0D = 1;
    }

    if(istrue(var_4)) {
      var_0.chestorigin = 1;
    }
  }

  thread ref_14156(var_0.attacker, var_1, var_3, var_0);
}

function ref_14166(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.attacker)) {
    var_2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var_2)) {
      var_3 = ref_1414C(self, undefined, 1);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;

      if(isDefined(var_3)) {
        var_4 = var_3.wind_trigger_toggle;
        var_5 = var_3.wind_triggers;
        var_6 = var_3.winbycaptures;
        var_7 = var_3.wind_trigger_loop;
      }

      ref_14147(var_1, var_4, var_5, var_6, var_7);
      return;
    }

    return;
  }
}

function ref_14168(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.attacker)) {
    var_2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var_2)) {
      var_3 = ref_1414C(self, undefined, 1);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;

      if(isDefined(var_3)) {
        var_4 = var_3.ref_11BAE;
        var_5 = var_3.ref_11BAF;
        var_6 = var_3.ref_11BAC;
        var_7 = var_3.ref_11BAD;
      }

      ref_14147(var_1, var_4, var_5, var_6, var_7);
      return;
    }

    return;
  }
}

function ref_14164(var_0, var_1) {
  if(isDefined(var_1) && isDefined(var_1.attacker)) {
    var_2 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var_2)) {
      var_3 = ref_1414C(self, undefined, 1);
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;
      var_7 = undefined;

      if(isDefined(var_3)) {
        var_4 = var_3.sidekillcount;
        var_5 = var_3.siege_bot_team_had_advantage;
        var_6 = var_3.shuttingdown;
        var_7 = var_3.sidehouse_intel_sequence;
      }

      if(isDefined(var_2.class)) {
        if(!isDefined(var_4)) {
          switch (var_2.class) {
            case "light":
            case "super_light":
              var_4 = "disabled_vehicle_light";
              break;
            case "medium_heavy":
            case "medium_light":
            case "medium":
              var_4 = "disabled_vehicle_medium";
              break;
            case "heavy":
            case "super_heavy":
              var_4 = "disabled_vehicle_heavy";
              break;
          }
        }

        if(isDefined(var_6)) {}
      }

      ref_14147(var_1, var_4, var_5, var_6, var_7);
      return;
    }

    return;
  }
}

function ref_14162(var_0) {
  if(isDefined(var_0) && isDefined(var_0.attacker)) {
    var_1 = vehicle_damage_getleveldataforvehicle(self.vehiclename, undefined, 1);

    if(isDefined(var_1)) {
      var_2 = ref_1414C(self, undefined, 1);
      var_3 = undefined;
      var_4 = undefined;
      var_5 = undefined;
      var_6 = undefined;

      if(isDefined(var_2)) {
        var_3 = var_2.lb_mg_impulse_dmg_threshold_low;
        var_4 = var_2.lb_mg_impulse_dmg_threshold_mid;
        var_5 = var_2.lb_mg_dmg_factor_landing_gear;
        var_6 = var_2.lb_mg_dmg_factor_main_rotor;
      }

      if(isDefined(var_1.class)) {
        if(!isDefined(var_3)) {
          switch (var_1.class) {
            case "light":
            case "super_light":
              var_3 = "destroyed_vehicle_light";
              break;
            case "medium_heavy":
            case "medium_light":
            case "medium":
              var_3 = "destroyed_vehicle_medium";
              break;
            case "heavy":
            case "super_heavy":
              var_3 = "destroyed_vehicle_heavy";
              break;
            default:
              var_3 = "none";
              break;
          }
        }

        if(isDefined(var_5)) {}
      }

      if(isDefined(var_3) && var_3 == "none") {
        var_3 = undefined;
      }

      if(isDefined(var_5) && var_5 == "none") {
        var_5 = undefined;
      }

      if(isPlayer(var_0.attacker)) {
        if(!isDefined(var_0.scurrentobjective)) {
          var_0.scurrentobjective = scripts\cp_mp\vehicles\vehicle::ref_141B7(self, var_0.attacker);
        } else if(var_0.scurrentobjective && scripts\cp_mp\vehicles\vehicle::ref_141B9(self, var_0.attacker)) {
          var_0.scurrentobjective = 0;
        } else if(!var_0.scurrentobjective && scripts\cp_mp\vehicles\vehicle::ref_141B7(self, var_0.attacker)) {
          var_0.scurrentobjective = 1;
        }
      } else {
        var_0.scurrentobjective = 0;
      }

      if(isDefined(var_0.objweapon) && weaponclass(var_0.objweapon.basename) != "rocketlauncher") {
        if(istrue(var_4)) {
          var_0.ref_12F0D = 1;
        }

        if(istrue(var_6)) {
          var_0.chestorigin = 1;
        }
      }

      if(var_0.scurrentobjective && scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "onVehicleKilled")) {
        var_0.attacker thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "onVehicleKilled")]](self, var_0.inflictor, var_0.attacker, var_0.damage, var_0.objweapon);
      }

      ref_14155(var_0.attacker, var_3, var_5, var_0, self getentitynumber());
      return;
    }

    return;
  }
}

function ref_14156(var_0, var_1, var_2, var_3) {
  var_4 = var_3 getentitynumber();
  self endon("disconnect");
  self endon("vehicle_damage_giveScoreAndXP" + var_4);
  waittillframeend();
  thread ref_14155(var_0, var_1, var_3, var_4);
}

function ref_14155(var_0, var_1, var_2, var_3) {
  self notify("vehicle_damage_giveScoreAndXP" + var_3);

  if(isDefined(var_0) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "giveScore")) {
    var_4 = scripts\engine\utility::ter_op(istrue(var_2.ref_12F0D), undefined, var_2.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "giveScore")]](var_0, var_4, !istrue(var_2.scurrentobjective));
  }

  if(isDefined(var_1) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "giveAward")) {
    var_4 = scripts\engine\utility::ter_op(istrue(var_2.chestorigin), undefined, var_2.objweapon);
    self[[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "giveAward")]](var_1, var_4, !istrue(var_2.scurrentobjective));
    return;
  }
}

function br_iseliminated(var_0) {
  var_1 = self;

  if(!var_0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() && !var_0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
    return;
  }

  if(isDefined(var_0.inflictor) && isDefined(var_0.inflictor.classname) && var_0.inflictor.classname == "worldspawn") {
    return;
  }

  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1);

  if(var_2.size <= 0) {
    return;
  }

  var_3 = 0;

  if(!isDefined(var_1.waitthensetgendersoundcontext)) {
    var_1.waitthensetgendersoundcontext = ["gas", 0, "bombs", 0, "dauntless_turret", 0, "bomber_turret", 0, "aa_truck", 0, "other_vehicle", 0, "aa_turret", 0, "normal_damage", 0, "self_elimination", 0, "trigger_hurt", 0, "launcher", 0, "other", 0];
  }

  var_4 = br_isininfil(var_0);
  var_5 = -1;
  var_6 = 0;

  while(var_6 < var_1.waitthensetgendersoundcontext.size) {
    if(var_1.waitthensetgendersoundcontext[var_6] == var_4) {
      var_5 = var_6;
    }

    var_6 += 2;
  }

  if(var_5 == -1) {
    var_5 = 22;
  }

  var_5 += 1;
  var_1.waitthensetgendersoundcontext[var_5] += var_0.damage;
}

function br_isininfil(var_0) {
  var_1 = var_0.attacker;
  var_2 = var_0.meansofdeath;
  var_3 = "";

  if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && var_0.objweapon.basename == "danger_circle_br") {
    var_3 = "gas";
  } else if(!isent(var_0.attacker)) {
    var_3 = "other";
  } else if(var_0.attacker == var_0.victim) {
    var_3 = "self_elimination";
  } else if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && (var_0.objweapon.basename == "manual_turret_flak_mp_highrof" || var_0.objweapon.basename == "manual_turret_flak_mp" || var_0.objweapon.basename == "manual_turret_flak_vehicle")) {
    if(!isDefined(var_0.attacker.vehicle)) {
      var_3 = "aa_turret";
    } else {
      var_3 = "aa_truck";
    }
  } else if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && var_0.objweapon.basename == "tur_gun_bt_mp") {
    var_3 = "bomber_turret";
  } else if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && var_0.objweapon.basename == "tur_gun_bt_mp_bomb") {
    var_3 = "bombs";
  } else if(isDefined(var_0.objweapon) && isDefined(var_0.objweapon.basename) && var_0.objweapon.basename == "tur_gun_fd_mp_seeking") {
    var_3 = "dauntless_turret";
  } else if(isDefined(var_0.attacker.vehicle)) {
    var_3 = "other_vehicle";
  } else if(var_0.meansofdeath == "MOD_PROJECTILE" || var_0.meansofdeath == "MOD_PROJECTILE_SPLASH") {
    var_3 = "launcher";
  } else if(isPlayer(var_0.attacker)) {
    var_3 = "normal_damage";
  }

  return var_3;
}

function ref_1417E(var_0) {
  var_1 = self;

  if(!istrue(level.brking_managecircles)) {
    return;
  }

  if(issubstr(var_0.meansofdeath, "BULLET") || var_0.meansofdeath == "MOD_PROJECTILE") {
    if(isPlayer(var_0.attacker)) {
      var_0.attacker setscriptablepartstate("vehicleHitmarkerSound", "vehicleHitmarkerSound", 0);
    }

    if(var_0.victim _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_0.victim _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
      var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_1);

      if(isDefined(var_2)) {
        foreach(var_4 in var_2) {
          var_4 setscriptablepartstate("planeImpactSound", "planeImpactSound", 0);
        }

        return;
      }

      return;
    }

    return;
  }
}

function ref_1417A(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponClassModDamageForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponClassModDamageForVehicle")]](var_0, var_1, var_2, var_3);
    return;
  }
}

function ref_14174(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPerkModDamage")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPerkModDamage")]](var_0, var_1, var_2);
    return;
  }
}

function ref_1417B(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageData")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageData")]](var_0, var_1);
    return;
  }
}

function ref_14178(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](var_0, var_1);
    return;
  }
}

function ref_14179(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageDataForWeapon")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageDataForWeapon")]](var_0, var_1, var_2);
    return;
  }
}

function ref_1417C(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setWeaponHitDamageDataForVehicle")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setWeaponHitDamageDataForVehicle")]](var_0, var_1, var_2);
    return;
  }
}

function ref_14176(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPreModDamageCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPreModDamageCallback")]](var_0, var_1);
    return;
  }
}

function ref_14175(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setPostModDamageCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setPostModDamageCallback")]](var_0, var_1);
    return;
  }
}

function ref_14171(var_0, var_1) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("vehicle_damage", "setDeathCallback")) {
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("vehicle_damage", "setDeathCallback")]](var_0, var_1);
    return;
  }
}

function ref_14173(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldataforvehicle(var_0, 1);

  if(!isDefined(var_3.ref_11FA5)) {
    var_3.ref_11FA5 = [];
  }

  var_3.ref_11FA5[var_1] = var_2;
}

function ref_14172(var_0, var_1, var_2) {
  var_3 = vehicle_damage_getleveldataforvehicle(var_0, 1);

  if(!isDefined(var_3.ref_11FA4)) {
    var_3.ref_11FA4 = [];
  }

  var_3.ref_11FA4[var_1] = var_2;
}

function vehicle_damage_initdebug() {
  setdvarifuninitialized("scr_vehicleGod", 0);
  setdvarifuninitialized("scr_simulateVehicleDamage", 0);
}