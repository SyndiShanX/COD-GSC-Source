/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_cobra_aud.gsc
*********************************************/

func_00F9() {
  level thread lib_04F3::func_533A();
  level thread initraidcobrasubmix();
  level thread objectivecountdownmusic();
  level thread func_18F5();
}

initraidcobrasubmix() {
  for(;;) {
    level waittill("connected", var_00);
    var_00 thread applyraidcobrasubmix();
  }
}

applyraidcobrasubmix() {
  self endon("disconnect");
  var_00 = self;
  for(;;) {
    self waittill("spawned_player");
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_cobra_init_mix", 0.1, 1);
  }
}

func_A3ED() {
  var_00 = self;
  var_01 = undefined;
  if(isDefined(var_00.var_106) == 0) {
    var_01 = "no model!";
    return;
  }

  switch (var_00.var_106) {
    default:
      var_01 = "unhandled model \'" + var_00.var_106 + "\'";
      break;

    case "vehicle_usa_tank_sherman_75mm_no_turret":
      var_00 func_535D();
      break;
  }
}

func_5362(param_00, param_01) {
  var_02 = 1;
  var_03 = "tag_origin";
  var_04 = (-128, 0, 4);
  var_05 = 8;
  if(var_02) {
    param_00.var_56E8 = 1;
    lib_0502::func_9FF(param_00);
  } else {
    var_06 = (120, 0, 40);
    var_07 = (-112, 44, 4);
    var_08 = (-112, -44, 4);
    var_09 = (-128, 0, 48);
    var_0A = 0.25;
    var_0B = 6.666;
    var_0C = 0.25;
    var_0D = 6.666;
    var_0E = 1;
    var_0F = 1;
    var_10 = 1;
    var_11 = [];
    var_11["speed"] = [var_0A, var_0B];
    var_11["scale"] = [1, 2];
    var_11["curve"] = ["linear"];
    var_12 = [];
    var_12["speed"] = [var_0C, var_0D];
    var_12["scale"] = [var_0E, 0];
    var_12["curve"] = ["xfade"];
    var_13 = [];
    var_13["speed"] = [var_0A, var_0B];
    var_13["scale"] = [0.5, 1];
    var_13["curve"] = ["linear"];
    var_14 = [];
    var_14["speed"] = [var_0C, var_0D];
    var_14["scale"] = [0, var_0E];
    var_14["curve"] = ["xfade"];
    var_15 = [];
    var_15["speed"] = [var_0A, var_0B];
    var_15["scale"] = [0.5, 1.414214];
    var_15["curve"] = ["linear"];
    var_16 = [];
    var_16["speed"] = [var_0C, var_0D / 4];
    var_16["scale"] = [0, var_0F];
    var_16["curve"] = ["easein"];
    var_17 = [];
    var_17["speed"] = [var_0A, var_0B];
    var_17["scale"] = [0.7071, 1.414214];
    var_17["curve"] = ["linear"];
    var_18 = [];
    var_18["speed"] = [var_0C, var_0D / 3];
    var_18["scale"] = [0, var_0F];
    var_18["curve"] = ["easein"];
    param_00 method_808C();
    wait(0.1);
    param_00 method_808C();
    param_00 lib_02EF::func_8AAE("truck_cckw_idle_lp", var_03, var_06, var_11, var_12);
    param_00 lib_02EF::func_8AAE("truck_cckw_engine_lp", var_03, var_06, var_13, var_14);
    param_00 lib_02EF::func_8AAE("truck_cckw_tires_lp", var_03, var_04, var_15, var_16);
    param_00 lib_02EF::func_8AAE("truck_cckw_rattle_lp", var_03, var_09, var_17, var_18);
  }

  var_19 = 14.666;
  maps\mp\gametypes\_hostmigration::func_A6F5(var_19);
  var_1A = param_00 gettagorigin(var_03);
  var_1A = var_1A + var_04;
  lib_04F3::func_79CB("truck_cckw_brake", var_1A);
  var_1B = 5;
  maps\mp\gametypes\_hostmigration::func_A6F5(var_1B);
  if(var_02) {
    lib_0502::func_7D03(param_00, var_05);
    return;
  }

  param_00 lib_02EF::func_8AB7(var_05, "easeout");
}

func_535C() {}

func_8C36() {
  if(isDefined(level.var_5D2) == 1) {
    for(var_00 = 0; var_00 < level.var_5D2.size; var_00++) {
      level.var_5D2[var_00] lib_02EF::func_8AB7(0.1);
    }
  }
}

func_535D(param_00) {
  var_01 = 1;
  var_02 = "tag_origin";
  if(var_01 == 1) {
    param_00.var_56E8 = 1;
    lib_0502::func_9FF(param_00);
    return;
  }

  var_03 = (-108, 0, 32);
  var_04 = (106, 0, 32);
  var_05 = 0.25;
  var_06 = 8;
  var_07 = 0.25;
  var_08 = 8;
  var_09 = 1;
  var_0A = 1;
  var_0B = [];
  var_0B["speed"] = [var_05, var_06];
  var_0B["scale"] = [1, 1.681793];
  var_0B["curve"] = ["linear"];
  var_0C = [];
  var_0C["speed"] = [var_07, var_08 / 1.333333];
  var_0C["scale"] = [var_09, 0];
  var_0C["curve"] = ["xfade"];
  var_0D = [];
  var_0D["speed"] = [var_05, var_06];
  var_0D["scale"] = [0.5, 1.189207];
  var_0D["curve"] = ["linear"];
  var_0E = [];
  var_0E["speed"] = [var_07, var_08];
  var_0E["scale"] = [0, var_09];
  var_0E["curve"] = ["xfade"];
  var_0F = [];
  var_0F["speed"] = [var_05, var_06];
  var_0F["scale"] = [0.7071068, 1.189207];
  var_0F["curve"] = ["linear"];
  var_10 = [];
  var_10["speed"] = [var_07, var_08 / 4];
  var_10["scale"] = [0, var_0A];
  var_10["curve"] = ["easein"];
  if(getdvarint("scr_raid_bandwidthTest", 0) == 0) {
    lib_02EF::func_8AAE("tank_sherman_idle_low_lp", var_02, var_03, var_0B, var_0C);
    lib_02EF::func_8AAE("tank_sherman_engine_lp", var_02, var_03, var_0D, var_0E);
    lib_02EF::func_8AAE("tank_sherman_treads_lp", var_02, var_04, var_0F, var_10);
  }
}

func_9413(param_00) {
  var_01 = 1;
  var_02 = self;
  if(isDefined(param_00) == 0) {
    param_00 = 0.1;
  }

  if(var_01 == 1) {
    lib_0502::func_7D03(var_02, param_00);
    return;
  }

  var_02 lib_02EF::func_8AB7(param_00);
}

func_A6CC(param_00) {
  var_01 = 10;
  var_02 = 0;
  if(isDefined(param_00) == 0) {
    param_00 = 5;
  }

  while(isDefined(self) == 1 && isDefined(lib_02EF::func_8A93("speed")) == 1) {
    if(lib_02EF::func_8A93("speed") > 0) {
      var_02 = 0;
    } else {
      var_02 = var_02 + 1;
    }

    if(var_02 >= var_01) {
      break;
    }

    wait 0.05;
  }

  lib_02EF::func_8AB7(param_00, "easeinout");
  wait(param_00 + 0.05);
}

func_0C06() {
  var_00 = self;
  var_01 = 3;
  var_02 = 6;
  var_03 = 0.707945;
  var_04 = 1 - var_03;
  var_05 = 20;
  var_06 = 5;
  if(isDefined(level.var_54D0["allies"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {
    var_07 = level.var_54D0["allies"].var_9309;
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_master", 0.1, 1);
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_vignette", 0.1, 1);
    wait 0.05;
    var_00 maps\mp\_audio_submixes::func_8A9E("mp_war_intro_master", var_04, var_01);
    wait(var_01);
    var_08 = gettime();
    var_09 = var_08 - var_07;
    var_0A = var_09 * 0.001;
    if(var_0A < var_02) {
      var_02 = var_02 - var_0A;
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_master", var_02);
    var_0B = var_05 - var_02 - var_01;
    if(var_0B > 0.05) {
      wait(var_0B);
    }

    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_vignette", var_06);
  }
}

objectivecountdownmusic() {
  level endon("game_ended");
  lib_04F3::func_A785();
  waittillframeend;
  var_00 = lib_02EF::randomarrayelement(["default", "urban_02a", "urban_02b"]);
  lib_04F3::raidmusicsetcountdown(var_00);
  for(;;) {
    level waittill("objectiveComplete", var_01);
    switch (var_01) {
      default:
        break;

      case "farm_hardpoint":
        var_00 = lib_02EF::randomarrayelement(["default", "urban_02a", "urban_02b"]);
        lib_04F3::raidmusicsetcountdown(var_00);
        break;

      case "bridge_1":
        break;

      case "bridge_2":
        var_00 = lib_02EF::randomarrayelement(["action_05", "default", "action_05", "action_05"]);
        lib_04F3::raidmusicsetcountdown(var_00);
        break;

      case "town_destruction":
      case "town_bombplant":
        var_00 = lib_02EF::randomarrayelement(["default", "action_05"]);
        lib_04F3::raidmusicsetcountdown(var_00);
        break;

      case "tank_escort":
        break;
    }
  }
}

func_18F5() {
  var_00 = common_scripts\utility::func_46B5("town_bombplant", "targetname");
  if(isDefined(var_00) == 0) {
    return;
  }

  level endon("raidTownObjectiveComplete");
  while(isDefined(var_00)) {
    var_00 waittill("bomb_planted");
    lib_04F3::raidmusiconteam("attackers", "objective_bomb_planted", "objective_bomb_defused");
    var_00 waittill("bomb_defused");
    lib_04F3::raidmusiconteam("defenders", "objective_bomb_planted", "objective_bomb_defused");
  }
}