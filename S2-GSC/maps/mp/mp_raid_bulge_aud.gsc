/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_raid_bulge_aud.gsc
*********************************************/

func_00F9() {
  level thread lib_04F3::func_533A();
  level thread objectivecountdownmusic();
  level.var_777["tank_tiger"] = 7;
  level.var_777["truck_opel_blitz"] = 13.666;
  level.ongascanphysics = ::gascanphysics;
}

func_A3ED() {
  var_00 = self;
  var_01 = undefined;
  if(isDefined(var_00.var_106) == 0) {
    var_01 = "no model!";
    return;
  }

  switch (var_00.var_106) {
    case "vehicle_usa_tank_sherman_75mm_no_turret":
    default:
      var_01 = "unhandled model \'" + var_00.var_106 + "\'";
      break;

    case "vehicle_ger_tank_king_tiger_mp":
      var_00 thread func_5360();
      break;
  }
}

func_5360() {
  var_00 = 1;
  if(var_00 == 0) {
    var_01 = (-166, 0, 80);
    var_02 = (116, 0, 36);
    var_03 = "tag_origin";
    var_04 = 0.25;
    var_05 = 8;
    var_06 = 0.25;
    var_07 = 4;
    var_08 = 1;
    var_09 = 1;
    var_0A = [];
    var_0A["speed"] = [var_04, var_05];
    var_0A["scale"] = [0.8408964, 1.414214];
    var_0A["curve"] = ["linear"];
    var_0B = [];
    var_0B["speed"] = [var_06, var_07 / 1.333333];
    var_0B["scale"] = [var_08, 0];
    var_0B["curve"] = ["xfade"];
    var_0C = [];
    var_0C["speed"] = [var_04, var_05];
    var_0C["scale"] = [0.5, 1];
    var_0C["curve"] = ["linear"];
    var_0D = [];
    var_0D["speed"] = [var_06, var_07];
    var_0D["scale"] = [0, var_08];
    var_0D["curve"] = ["xfade"];
    var_0E = [];
    var_0E["speed"] = [var_04, var_05];
    var_0E["scale"] = [0.5946035, 1];
    var_0E["curve"] = ["linear"];
    var_0F = [];
    var_0F["speed"] = [var_06, var_07 / 2];
    var_0F["scale"] = [0, var_09];
    var_0F["curve"] = ["easein"];
    wait 0.05;
    self method_808C();
    lib_02EF::func_8AAE("tank_tiger_idle_low_lp", var_03, var_01, var_0A, var_0B);
    lib_02EF::func_8AAE("tank_tiger_engine_lp", var_03, var_01, var_0C, var_0D);
    lib_02EF::func_8AAE("tank_tiger_treads_lp", var_03, var_02, var_0E, var_0F);
  }
}

func_9413(param_00) {
  var_01 = 1;
  if(isDefined(param_00) == 0) {
    param_00 = 0.1;
  }

  if(var_01 == 0) {
    lib_02EF::func_8AB7(param_00);
  }
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

objectivecountdownmusic() {
  level endon("game_ended");
  lib_04F3::func_A785();
  waittillframeend;
  var_00 = lib_02EF::randomarrayelement(["epic", "winter_01", "winter_02"]);
  lib_04F3::raidmusicsetcountdown(var_00);
  for(;;) {
    level waittill("objectiveComplete", var_01);
    switch (var_01) {
      default:
        break;

      case "tank_escort_3":
      case "tank_escort_2":
      case "tank_escort_1":
        break;

      case "escort_tanks":
        var_00 = lib_02EF::randomarrayelement(["epic", "action_04", "winter_01", "winter_02"]);
        lib_04F3::raidmusicsetcountdown(var_00);
        break;

      case "tank_refuel":
        var_02 = lib_02EF::randomarrayelement(["action_05", "default", "urban_02a"]);
        lib_04F3::raidmusicsetcountdown(var_02);
        break;

      case "bridge_escort":
        break;
    }
  }
}

func_A57E(param_00) {
  param_00.var_56E8 = 1;
  lib_0502::func_9FF(param_00);
}

func_54E4() {
  var_00 = self;
  var_01 = 3;
  var_02 = 6;
  var_03 = 0.2238721;
  var_04 = 1 - var_03;
  var_05 = 14;
  var_06 = 1;
  if(isDefined(level.var_54D0["allies"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {
    var_07 = level.var_54D0["allies"].var_9309;
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_vignette", 0.1, 1);
    wait 0.05;
    var_00 maps\mp\_audio_submixes::func_8A9E("mp_war_intro_vignette", var_04, var_01);
    level waittill("allies_intro_cleanup");
    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_vignette", var_06);
    wait(var_06);
    wait(30);
  }
}

func_54E5() {
  var_00 = self;
  var_01 = 3;
  var_02 = 6;
  var_03 = 0.2238721;
  var_04 = 1 - var_03;
  var_05 = 25;
  var_06 = 1;
  if(isDefined(level.var_54D0["allies"]) == 1 && isDefined(level.var_54D0["allies"].var_9309) == 1) {
    var_07 = level.var_54D0["allies"].var_9309;
    var_00 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_vignette", 0.1, 1);
    wait 0.05;
    var_00 maps\mp\_audio_submixes::func_8A9E("mp_war_intro_vignette", var_04, var_01);
    thread introvignetteaxissounds();
    level waittill("axis_intro_cleanup");
    var_00 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_vignette", var_06);
    wait(var_06);
    wait(30);
  }
}

introvignetteaxisplayercameramix(param_00) {
  var_01 = self;
  var_02 = 0.1;
  switch (param_00) {
    case 1:
    default:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_01", var_02);
      break;

    case 2:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_01", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_02", var_02);
      break;

    case 3:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_02", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_03", var_02);
      break;

    case 4:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_03", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_04", var_02);
      break;

    case 5:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_04", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_axis_05", var_02);
      level waittill("axis_intro_cleanup");
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_axis_05", var_02);
      break;
  }
}

introvignettealliesplayercameramix(param_00) {
  var_01 = self;
  var_02 = 0.2;
  switch (param_00) {
    case 1:
    default:
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_01", var_02);
      break;

    case 2:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_01", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_02", var_02);
      break;

    case 3:
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_02", var_02);
      var_01 maps\mp\_audio_submixes::func_8A9D("mp_war_intro_allies_03", var_02);
      level waittill("allies_intro_cleanup");
      var_01 maps\mp\_audio_submixes::func_8A9F("mp_war_intro_allies_03", var_02);
      break;
  }
}

introvignetteaxissounds() {
  level endon("axis_intro_cleanup");
  lib_04F3::func_79CB("ni_mortar_launchers_bg", (-11788, 4308, 463));
  lib_04F3::func_79CB("ni_charge", (-11788, 4308, 463));
  wait(6);
  lib_04F3::func_79CB("ni_tank_crunch", (-10587, 3031, 425));
  wait(4);
  lib_04F3::func_79CB("ni_charge_fs", (-11788, 4308, 463));
  wait(2.5);
  lib_04F3::func_79CB("ni_dontstopshooting", (-11788, 4308, 463));
  wait(5);
  lib_04F3::func_79CB("ni_artillery_strike_end", (-7770, 3863, 727));
}

func_97B6() {
  var_00 = (0, 0, 0);
  lib_04F3::func_79CB("o3_crates_tank_smash", var_00);
}

gascanphysics() {
  self endon("physics_finished");
  lib_04F3::func_79CC("gascan_bounce_first", self);
  for(;;) {
    self waittill("physics_impact", var_00, var_01, var_02, var_03);
    if(abs(var_02[0]) > 2.5 || abs(var_02[1]) > 2.5 || abs(var_02[2]) > 2.5) {
      lib_04F3::func_79CC("gascan_bounce_" + var_03, self);
    }
  }
}