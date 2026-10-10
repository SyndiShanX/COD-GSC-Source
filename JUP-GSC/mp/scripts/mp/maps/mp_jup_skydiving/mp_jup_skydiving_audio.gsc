/**************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_skydiving\mp_jup_skydiving_audio.gsc
**************************************************************************/

#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace mp_jup_skydiving_audio;

function main() {
  level.var_fcb88e09334f2385 = "jup_mode_wm_exfil_skydive";
  level.var_587955703c59a8a5 = "jup_mode_wm_exfil_skydive";
  thread function_b05e86bdd689e483();
  thread function_88af6b25b05851cd();
  thread function_670a2192538db37f();
}

function function_b05e86bdd689e483() {
  level endon("game_ended");
  level endon("zone_2_objective_end");
  level waittill("matchStartTimer_done");
  scripts\mp\flags::function_1240434f4201ac9d("zone_2_objective_start");
  var_dac1735abf86e34c = getglassarray("glass_hoverjet");
  var_289a80160c539d65 = var_dac1735abf86e34c.size;

  while(true) {
    if(var_dac1735abf86e34c.size > 0) {
      for(i = 0; i <= var_289a80160c539d65; i++) {
        if(isDefined(var_dac1735abf86e34c[i])) {
          if(isglassdestroyed(var_dac1735abf86e34c[i])) {
            playsoundatpos(getglassorigin(var_dac1735abf86e34c[i]), "amb_skydiving_window_break_wind_blow");
            var_dac1735abf86e34c[i] = undefined;
          }
        }
      }
    } else {
      break;
    }

    wait 1;
  }
}

function function_670a2192538db37f() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  var_91dced5167d25d08 = getEnt("wheelson_context_type_glass", "targetname");
  level waittill("wheelson_spawn");
  waitframe();
  level.escortvehicles[0] setentitysoundcontext("jup_map", "skydiving_zombie", 0.1);
  var_91dced5167d25d08 waittill("trigger", vehicle);
  test = vehicle;
  level.escortvehicles[0] setentitysoundcontext("jup_map", "", 1);
}

function function_88af6b25b05851cd() {
  level endon("game_ended");
  level waittill("matchStartTimer_done");
  scripts\mp\flags::gameflagwait("zone_2_objective_start");
  var_33fa3224d3fdc02b = spawn("script_model", (-12531, -24682, 3800));
  var_33fa4024d3fddef5 = spawn("script_model", (-13497, -24903, 3800));
  var_342f3224d438453f = spawn("script_model", (-12725, -23823, 3800));
  var_342f4824d43875a1 = spawn("script_model", (-13690, -24027, 3800));
  var_14550bd41b7d7e0a = spawn("script_model", (-13065, -24489, 3800));
  var_8cf5bb812cabeff4 = spawn("script_model", (-12458, -25881, 3640));
  var_8cf5a1812cabb6c6 = spawn("script_model", (-13011, -25991, 3640));
  var_8cc09b812c712480 = spawn("script_model", (-12612, -25521, 3640));
  var_8cc0b9812c71667a = spawn("script_model", (-13052, -25639, 3640));
  var_d28e7a149e684d42 = spawn("script_model", (-12770, -22578, 3640));
  attackerteam = scripts\engine\utility::array_remove(level.teamnamelist, level.objectives["_e"].ownerteam)[0];
  level waittill("wheelson_spawn");
  thread function_9f5546f5af9c1016();

  while(!istrue(level.objectives["_e"].complete)) {
    if(level.objectives["_e"].numtouching["allies"] > 0 && is_equal(level.objectives["_e"].allowcapture, 1)) {
      var_33fa3224d3fdc02b playsoundtoteam("amb_skydiving_alarm_01_allies_fl", game["attackers"]);
      var_33fa4024d3fddef5 playsoundtoteam("amb_skydiving_alarm_01_allies_fr", game["attackers"]);
      var_342f3224d438453f playsoundtoteam("amb_skydiving_alarm_01_allies_rl", game["attackers"]);
      var_342f4824d43875a1 playsoundtoteam("amb_skydiving_alarm_01_allies_rr", game["attackers"]);
      var_14550bd41b7d7e0a playsoundtoteam("amb_skydiving_alarm_01_allies_wet", game["attackers"]);
      var_33fa3224d3fdc02b playsoundtoteam("amb_skydiving_alarm_01_enemy_fl", game["defenders"]);
      var_33fa4024d3fddef5 playsoundtoteam("amb_skydiving_alarm_01_enemy_fr", game["defenders"]);
      var_342f3224d438453f playsoundtoteam("amb_skydiving_alarm_01_enemy_rl", game["defenders"]);
      var_342f4824d43875a1 playsoundtoteam("amb_skydiving_alarm_01_enemy_rr", game["defenders"]);
      var_14550bd41b7d7e0a playsoundtoteam("amb_skydiving_alarm_01_enemy_wet", game["defenders"]);
    }

    wait 2;
  }

  if(istrue(level.objectives["_e"].complete)) {
    wait 2;
    var_33fa3224d3fdc02b delete();
    var_33fa4024d3fddef5 delete();
    var_342f3224d438453f delete();
    var_342f4824d43875a1 delete();
  }

  while(!istrue(level.objectives["_f"].complete)) {
    if(level.objectives["_f"].numtouching["allies"] > 0 && is_equal(level.objectives["_f"].allowcapture, 1)) {
      var_8cf5bb812cabeff4 playsoundtoteam("amb_skydiving_alarm_02_allies_fl", game["attackers"]);
      var_8cf5a1812cabb6c6 playsoundtoteam("amb_skydiving_alarm_02_allies_fr", game["attackers"]);
      var_8cc09b812c712480 playsoundtoteam("amb_skydiving_alarm_02_allies_rl", game["attackers"]);
      var_8cc0b9812c71667a playsoundtoteam("amb_skydiving_alarm_02_allies_rr", game["attackers"]);
      var_14550bd41b7d7e0a playsoundtoteam("amb_skydiving_alarm_02_allies_wet", game["attackers"]);
      var_8cf5bb812cabeff4 playsoundtoteam("amb_skydiving_alarm_02_enemy_fl", game["defenders"]);
      var_8cf5a1812cabb6c6 playsoundtoteam("amb_skydiving_alarm_02_enemy_fr", game["defenders"]);
      var_8cc09b812c712480 playsoundtoteam("amb_skydiving_alarm_02_enemy_rl", game["defenders"]);
      var_8cc0b9812c71667a playsoundtoteam("amb_skydiving_alarm_02_enemy_rr", game["defenders"]);
      var_14550bd41b7d7e0a playsoundtoteam("amb_skydiving_alarm_02_enemy_wet", game["defenders"]);
    }

    wait 2;
  }

  if(istrue(level.objectives["_f"].complete)) {
    wait 2;
    var_8cf5bb812cabeff4 delete();
    var_8cf5a1812cabb6c6 delete();
    var_8cc09b812c712480 delete();
    var_8cc0b9812c71667a delete();
    var_d28e7a149e684d42 delete();
  }
}

function function_9f5546f5af9c1016() {
  level endon("game_ended");
  var_5a9960654f0d8699 = 4;
  level waittill("wm_zone_captured");
  thread function_6bec8fd8725f7e44();

  while(var_5a9960654f0d8699 != 0) {
    playsoundatpos((-11059, -25023, 3750), "amb_skydiving_zombie_alarm_fl");
    playsoundatpos((-14744, -25893, 3750), "amb_skydiving_zombie_alarm_fr");
    playsoundatpos((-11381, -22889, 3750), "amb_skydiving_zombie_alarm_rl");
    playsoundatpos((-15621, -24369, 3750), "amb_skydiving_zombie_alarm_rr");
    playsoundatpos((-13065, -24489, 3800), "amb_skydiving_zombie_alarm_wet");
    wait 2;
    var_5a9960654f0d8699--;
  }

  wait 3.5;
  var_5a9960654f0d8699 = 4;
  scripts\mp\flags::gameflagwait("wheelson_reach_hack_point_final");

  while(var_5a9960654f0d8699 != 0) {
    playsoundatpos((-11059, -25023, 3750), "amb_skydiving_zombie_alarm_fl");
    playsoundatpos((-14744, -25893, 3750), "amb_skydiving_zombie_alarm_fr");
    playsoundatpos((-11381, -22889, 3750), "amb_skydiving_zombie_alarm_rl");
    playsoundatpos((-15621, -24369, 3750), "amb_skydiving_zombie_alarm_rr");
    playsoundatpos((-13065, -24489, 3800), "amb_skydiving_zombie_alarm_wet");
    wait 2;
    var_5a9960654f0d8699--;
  }

  wait 3.5;
  var_5a9960654f0d8699 = 26;
  level waittill("zone_2_objective_end");

  while(var_5a9960654f0d8699 != 0) {
    playsoundatpos((-11059, -25023, 3750), "amb_skydiving_zombie_alarm_fl_short");
    playsoundatpos((-14744, -25893, 3750), "amb_skydiving_zombie_alarm_fr_short");
    playsoundatpos((-11381, -22889, 3750), "amb_skydiving_zombie_alarm_rl_short");
    playsoundatpos((-15621, -24369, 3750), "amb_skydiving_zombie_alarm_rr_short");
    playsoundatpos((-13065, -24489, 3800), "amb_skydiving_zombie_alarm_wet_short");
    wait 1;
    var_5a9960654f0d8699--;
  }
}

function function_6bec8fd8725f7e44() {
  level endon("game_ended");
  var_756a358f871e2af = spawn("script_model", (-11153, -32003, 1909));
  var_756a358f871e2af thread function_73b02e72ac12c5f0();
  scripts\mp\flags::gameflagwait("zone_3_objective_start");

  while(!istrue(level.objectives["_j"].complete)) {
    if(scripts\engine\utility::array_sum(level.objectives["_j"].numtouching) > 0) {
      var_756a358f871e2af notify("pds_on");
    } else {
      var_756a358f871e2af notify("pds_off");
    }

    wait 0.5;
  }

  var_756a358f871e2af stoploopsound();
  var_756a358f871e2af playSound("jup_skydiving_pds_capture_lp_stop");
  wait 1;
  var_756a358f871e2af delete();
}

function function_73b02e72ac12c5f0() {
  while(!istrue(level.objectives["_j"].complete)) {
    if(scripts\engine\utility::array_sum(level.objectives["_j"].numtouching) > 0) {
      self playSound("jup_skydiving_pds_capture_lp_start");
      self playLoopSound("jup_skydiving_pds_capture_lp");
      self waittill("pds_off");
      continue;
    }

    self stoploopsound();
    self playSound("jup_skydiving_pds_capture_lp_stop");
    self waittill("pds_on");
  }
}