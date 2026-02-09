/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\sp\friendlyfire.gsc
*********************************************/

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

func_20A7(var_0) {
  level.var_740B = var_0;
}

func_E013(var_0) {
  level.var_740B = undefined;
}

func_73B1(var_0) {
  if(!isDefined(var_0)) {
    return;
  }

  if(!isDefined(var_0.team)) {
    var_0.team = "allies";
  }

  if(isDefined(level.var_BFED)) {
    return;
  }

  level endon("mission failed");
  level thread func_C15E(var_0);
  level thread func_C160(var_0);
  level thread func_C161(var_0);
  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }

    if(var_0.health <= 0) {
      return;
    }

    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_0 waittill("friendlyfire_notify", var_1, var_2, var_3, var_4, var_5, var_6);
    if(!isDefined(var_0)) {
      return;
    }

    if(!isDefined(var_2)) {
      continue;
    }

    if(isDefined(level.var_740B)) {
      var_1 = var_1 * level.var_740B;
      var_1 = int(var_1);
    }

    var_8 = 0;
    if(!isDefined(var_6)) {
      var_6 = var_0.var_E2;
    }

    if(isDefined(level.var_740C)) {
      if(isDefined(var_2.damageowner)) {
        var_7 = 1;
        var_2 = var_2.damageowner;
      }
    }

    if(isDefined(level.var_740D)) {
      if(isDefined(var_2) && isDefined(var_2.owner) && var_2.owner == level.player) {
        var_8 = 1;
      }
    }

    if(isPlayer(var_2)) {
      var_8 = 1;
      if(isDefined(var_6) && var_6 == "none") {
        var_8 = 0;
      }

      if(var_2 isusingturret()) {
        var_8 = 1;
      }

      if(isDefined(var_7)) {
        var_8 = 1;
      }
    } else if(isDefined(var_2.var_9F) && var_2.var_9F == "script_vehicle") {
      var_9 = var_2 func_816A();
      if(isDefined(var_9) && isPlayer(var_9)) {
        var_8 = 1;
      }
    }

    if(!var_8) {
      continue;
    }

    if(!isDefined(var_0.team)) {
      continue;
    }

    var_10 = var_0.team == level.player.team;
    var_11 = undefined;
    if(isDefined(var_0.type) && var_0.type == "civilian") {
      var_11 = 1;
    } else {
      var_11 = issubstr(var_0.classname, "civilian");
    }

    var_12 = var_1 == -1;
    if(!var_10 && !var_11) {
      if(var_12) {
        level.player.var_C929 = level.player.var_C929 + level.friendlyfire["enemy_kill_points"];
        func_C92A();
        return;
      }

      continue;
    }

    if(isDefined(var_0.var_BFED)) {
      continue;
    }

    if(var_5 == "MOD_PROJECTILE_SPLASH" && isDefined(level.var_BFEE)) {
      continue;
    }

    if(isDefined(var_6) && var_6 == "claymore") {
      continue;
    }

    if(var_12) {
      if(isDefined(var_0.var_738F)) {
        level.player.var_C929 = level.player.var_C929 + var_0.var_738F;
      } else {
        level.player.var_C929 = level.player.var_C929 + level.friendlyfire["friend_kill_points"];
      }
    } else {
      level.player.var_C929 = level.player.var_C929 - var_1;
    }

    func_C92A();
    if(func_3DA1(var_0, var_5) && func_EB68()) {
      if(var_12) {
        return;
      } else {
        continue;
      }
    }

    if(isDefined(level.var_73B0)) {
      [[level.var_73B0]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
      continue;
    }

    func_73AE(var_11);
  }
}

func_73AE(var_0) {
  if(isDefined(level.var_6AD2) && level.var_6AD2) {
    level thread func_B8CF(var_0);
    return;
  }

  var_1 = level.var_7417;
  if(isDefined(level.var_740C) && var_0) {
    var_1 = 0;
  }

  if(var_1) {
    return;
  }

  if(level.var_7416 == 1) {
    return;
  }

  if(level.player.var_C929 <= level.friendlyfire["min_participation"]) {
    level thread func_B8CF(var_0);
  }
}

func_3DA1(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  var_2 = 0;
  if(isDefined(var_0.var_E2) && var_0.var_E2 == "none") {
    var_2 = 1;
  }

  if(isDefined(var_1) && var_1 == "MOD_GRENADE_SPLASH") {
    var_2 = 1;
  }

  return var_2;
}

func_EB68() {
  var_0 = gettime();
  if(var_0 < 4500) {
    return 1;
  } else if(var_0 - level.var_2668.var_A943 < 4500) {
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

func_B8CF(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;
  }

  if(getDvar("friendlyfire_dev_disabled") == "1") {
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

  if(var_0) {
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

func_C15E(var_0) {
  var_0 endon("death");
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_6, var_6, var_6, var_7);
    var_0 notify("friendlyfire_notify", var_1, var_2, var_3, var_4, var_5, var_7);
  }
}

func_C160(var_0) {
  var_0 waittill("damage_notdone", var_1, var_2, var_3, var_3, var_4);
  var_0 notify("friendlyfire_notify", -1, var_2, undefined, undefined, var_4);
}

func_C161(var_0) {
  var_0 waittill("death", var_1, var_2, var_3);
  var_0 notify("friendlyfire_notify", -1, var_1, undefined, undefined, var_2, var_3);
}

func_53AE(var_0) {}