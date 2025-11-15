/***************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\sp\friendlyfire.gsc
***************************************/

main() {
  level.friendlyfire["min_participation"] = -200;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -650;
  level.friendlyfire["point_loss_interval"] = 1.25;
  level.player.var_C929 = 0;
  level.var_7416 = 0;
  level.var_7417 = 0;
  setdvarifuninitialized("friendlyfire_dev_disabled", "0");
  scripts\engine\utility::flag_init("friendly_fire_warning");
  thread func_4EDB();
  thread func_C92B();
}

func_4EDB() {}

func_20A7(param_00) {
  level.var_740B = param_00;
}

func_E013(param_00) {
  level.var_740B = undefined;
}

func_73B1(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  if(!isDefined(param_00.team)) {
    param_00.team = "allies";
  }

  if(isDefined(level.var_BFED)) {
    return;
  }

  level endon("mission failed");
  level thread func_C15E(param_00);
  level thread func_C160(param_00);
  level thread func_C161(param_00);
  for(;;) {
    if(!isDefined(param_00)) {
      return;
    }

    if(param_00.health <= 0) {
      return;
    }

    var_01 = undefined;
    var_02 = undefined;
    var_03 = undefined;
    var_04 = undefined;
    var_05 = undefined;
    var_06 = undefined;
    var_07 = undefined;
    param_00 waittill("friendlyfire_notify", var_01, var_02, var_03, var_04, var_05, var_06);
    if(!isDefined(param_00)) {
      return;
    }

    if(!isDefined(var_02)) {
      continue;
    }

    if(isDefined(level.var_740B)) {
      var_01 = var_01 * level.var_740B;
      var_01 = int(var_01);
    }

    var_08 = 0;
    if(!isDefined(var_06)) {
      var_06 = param_00.var_E2;
    }

    if(isDefined(level.var_740C)) {
      if(isDefined(var_02.damageowner)) {
        var_07 = 1;
        var_02 = var_02.damageowner;
      }
    }

    if(isDefined(level.var_740D)) {
      if(isDefined(var_02) && isDefined(var_02.triggerportableradarping) && var_02.triggerportableradarping == level.player) {
        var_08 = 1;
      }
    }

    if(isplayer(var_02)) {
      var_08 = 1;
      if(isDefined(var_06) && var_06 == "none") {
        var_08 = 0;
      }

      if(var_02 isusingturret()) {
        var_08 = 1;
      }

      if(isDefined(var_07)) {
        var_08 = 1;
      }
    } else if(isDefined(var_02.var_9F) && var_02.var_9F == "script_vehicle") {
      var_09 = var_02 _meth_816A();
      if(isDefined(var_09) && isplayer(var_09)) {
        var_08 = 1;
      }
    }

    if(!var_08) {
      continue;
    }

    if(!isDefined(param_00.team)) {
      continue;
    }

    var_0A = param_00.team == level.player.team;
    var_0B = undefined;
    if(isDefined(param_00.type) && param_00.type == "civilian") {
      var_0B = 1;
    } else {
      var_0B = issubstr(param_00.classname, "civilian");
    }

    var_0C = var_01 == -1;
    if(!var_0A && !var_0B) {
      if(var_0C) {
        level.player.var_C929 = level.player.var_C929 + level.friendlyfire["enemy_kill_points"];
        func_C92A();
        return;
      }

      continue;
    }

    if(isDefined(param_00.var_BFED)) {
      continue;
    }

    if(var_05 == "MOD_PROJECTILE_SPLASH" && isDefined(level.var_BFEE)) {
      continue;
    }

    if(isDefined(var_06) && var_06 == "claymore") {
      continue;
    }

    if(var_0C) {
      if(isDefined(param_00.var_738F)) {
        level.player.var_C929 = level.player.var_C929 + param_00.var_738F;
      } else {
        level.player.var_C929 = level.player.var_C929 + level.friendlyfire["friend_kill_points"];
      }
    } else {
      level.player.var_C929 = level.player.var_C929 - var_01;
    }

    func_C92A();
    if(func_3DA1(param_00, var_05) && func_EB68()) {
      if(var_0C) {
        return;
      } else {
        continue;
      }
    }

    if(isDefined(level.var_73B0)) {
      [
        [level.var_73B0]
      ](param_00, var_01, var_02, var_03, var_04, var_05, var_06);
      continue;
    }

    func_73AE(var_0B);
  }
}

func_73AE(param_00) {
  if(isDefined(level.var_6AD2) && level.var_6AD2) {
    level thread func_B8CF(param_00);
    return;
  }

  var_01 = level.var_7417;
  if(isDefined(level.var_740C) && param_00) {
    var_01 = 0;
  }

  if(var_01) {
    return;
  }

  if(level.var_7416 == 1) {
    return;
  }

  if(level.player.var_C929 <= level.friendlyfire["min_participation"]) {
    level thread func_B8CF(param_00);
  }
}

func_3DA1(param_00, param_01) {
  if(!isDefined(param_00)) {
    return 0;
  }

  var_02 = 0;
  if(isDefined(param_00.var_E2) && param_00.var_E2 == "none") {
    var_02 = 1;
  }

  if(isDefined(param_01) && param_01 == "MOD_GRENADE_SPLASH") {
    var_02 = 1;
  }

  return var_02;
}

func_EB68() {
  var_00 = gettime();
  if(var_00 < 4500) {
    return 1;
  } else if(var_00 - level.var_2668.var_A943 < 4500) {
    return 1;
  }

  return 0;
}

func_C92A() {
  if(level.player.var_C929 > level.friendlyfire["max_participation"]) {
    level.player.var_C929 = level.friendlyfire["max_participation"];
  }

  if(level.player.var_C929 < level.friendlyfire["min_participation"]) {
    level.player.var_C929 = level.friendlyfire["min_participation"];
  }
}

func_C92B() {
  level endon("mission failed");
  for(;;) {
    if(level.player.var_C929 > 0) {
      level.player.var_C929--;
    } else if(level.player.var_C929 < 0) {
      level.player.var_C929++;
    }

    wait(level.friendlyfire["point_loss_interval"]);
  }
}

func_1299E() {
  level.var_7416 = 0;
}

func_129A9() {
  level.var_7416 = 1;
}

func_B8CF(param_00) {
  if(!isDefined(param_00)) {
    param_00 = 0;
  }

  if(getdvar("friendlyfire_dev_disabled") == "1") {
    return;
  }

  if(getdvarint("exec_review") > 0) {
    return;
  }

  level.player endon("death");
  if(!isalive(level.player)) {
    return;
  }

  level endon("mine death");
  level notify("mission failed");
  level notify("friendlyfire_mission_fail");
  waittillframeend;
  setsaveddvar("hud_missionFailed", 1);
  setomnvar("ui_hide_weapon_info", 1);
  setsaveddvar("hud_showstance", 0);
  setsaveddvar("actionSlotsHide", 1);
  if(isDefined(level.player.var_6AD1)) {
    return;
  }

  if(param_00) {
    setomnvar("ui_death_hint", 9);
  } else if(isDefined(level.var_4C51)) {
    lib_0B60::func_F32D(level.var_4C51);
  } else {
    setomnvar("ui_death_hint", 12);
  }

  if(isDefined(level.var_4C52)) {
    thread lib_0B60::func_F330(level.var_4C52, 64, 64, 0);
  }

  scripts\sp\utility::func_B8D1();
}

func_1D2B() {
  level.player endon("death");
  self endon("death");
  self givescorefortrophyblocks();
  scripts\sp\utility::func_414F();
  scripts\sp\utility::func_F417(1);
  scripts\sp\utility::clearthreatbias("axis", "allies");
  for(;;) {
    self.team = "axis";
    self.var_6BAE = level.player;
    wait(0.05);
  }
}

func_C15E(param_00) {
  param_00 endon("death");
  for(;;) {
    param_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_06, var_06, var_06, var_07);
    param_00 notify("friendlyfire_notify", var_01, var_02, var_03, var_04, var_05, var_07);
  }
}

func_C160(param_00) {
  param_00 waittill("damage_notdone", var_01, var_02, var_03, var_03, var_04);
  param_00 notify("friendlyfire_notify", -1, var_02, undefined, undefined, var_04);
}

func_C161(param_00) {
  param_00 waittill("death", var_01, var_02, var_03);
  param_00 notify("friendlyfire_notify", -1, var_01, undefined, undefined, var_02, var_03);
}

func_53AE(param_00) {}