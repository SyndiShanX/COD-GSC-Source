/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2866.gsc
***************************************/

main() {
  level.friendlyfire["min_participation"] = -200;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -650;
  level.friendlyfire["point_loss_interval"] = 1.25;
  level.player.func_C929 = 0;
  level.func_7416 = 0;
  level.func_7417 = 0;
  setdvarifuninitialized("friendlyfire_dev_disabled", "0");
  scripts\engine\utility::flag_init("friendly_fire_warning");
  thread func_4EDB();
  thread func_C92B();
}

func_4EDB() {}

func_20A7(var_00) {
  level.func_740B = var_00;
}

func_E013(var_00) {
  level.func_740B = undefined;
}

func_73B1(var_00) {
  if(!isDefined(var_00)) {
    return;
  }
  if(!isDefined(var_0.team)) {
    var_0.team = "allies";
  }

  if(isDefined(level.func_BFED)) {
    return;
  }
  level endon("mission failed");
  level thread func_C15E(var_00);
  level thread func_C160(var_00);
  level thread func_C161(var_00);

  for(;;) {
    if(!isDefined(var_00)) {
      return;
    }
    if(var_0.health <= 0) {
      return;
    }
    var_01 = undefined;
    var_02 = undefined;
    var_03 = undefined;
    var_04 = undefined;
    var_05 = undefined;
    var_06 = undefined;
    var_07 = undefined;
    var_00 waittill("friendlyfire_notify", var_01, var_02, var_03, var_04, var_05, var_06);

    if(!isDefined(var_00)) {
      return;
    }
    if(!isDefined(var_02)) {
      continue;
    }
    if(isDefined(level.func_740B)) {
      var_01 = var_01 * level.func_740B;
      var_01 = int(var_01);
    }

    var_08 = 0;

    if(!isDefined(var_06)) {
      var_06 = var_0.damageweapon;
    }

    if(isDefined(level.func_740C)) {
      if(isDefined(var_2.damageowner)) {
        var_07 = 1;
        var_02 = var_2.damageowner;
      }
    }

    if(isDefined(level.func_740D)) {
      if(isDefined(var_02) && isDefined(var_2.owner) && var_2.owner == level.player) {
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
    } else if(isDefined(var_2.code_classname) && var_2.code_classname == "script_vehicle") {
      var_09 = var_02 _meth_816A();

      if(isDefined(var_09) && isplayer(var_09)) {
        var_08 = 1;
      }
    }

    if(!var_08) {
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

    var_12 = var_01 == -1;

    if(!var_10 && !var_11) {
      if(var_12) {
        level.player.func_C929 = level.player.func_C929 + level.friendlyfire["enemy_kill_points"];
        func_C92A();
        return;
      }
    } else {
      if(isDefined(var_0.func_BFED)) {
        continue;
      }
      if(var_05 == "MOD_PROJECTILE_SPLASH" && isDefined(level.func_BFEE)) {
        continue;
      }
      if(isDefined(var_06) && var_06 == "claymore") {
        continue;
      }
      if(var_12) {
        if(isDefined(var_0.func_738F)) {
          level.player.func_C929 = level.player.func_C929 + var_0.func_738F;
        } else {
          level.player.func_C929 = level.player.func_C929 + level.friendlyfire["friend_kill_points"];
        }
      } else
        level.player.func_C929 = level.player.func_C929 - var_01;

      func_C92A();

      if(func_3DA1(var_00, var_05) && func_EB68()) {
        if(var_12) {
          return;
        } else {
          continue;
        }
      }

      if(isDefined(level.func_73B0)) {
        [[level.func_73B0]](var_00, var_01, var_02, var_03, var_04, var_05, var_06);
        continue;
      }

      func_73AE(var_11);
    }
  }
}

func_73AE(var_00) {
  if(isDefined(level.func_6AD2) && level.func_6AD2) {
    level thread func_B8CF(var_00);
    return;
  }

  var_01 = level.func_7417;

  if(isDefined(level.func_740C) && var_00) {
    var_01 = 0;
  }

  if(var_01) {
    return;
  }
  if(level.func_7416 == 1) {
    return;
  }
  if(level.player.func_C929 <= level.friendlyfire["min_participation"]) {
    level thread func_B8CF(var_00);
  }
}

func_3DA1(var_00, var_01) {
  if(!isDefined(var_00)) {
    return 0;
  }

  var_02 = 0;

  if(isDefined(var_0.damageweapon) && var_0.damageweapon == "none") {
    var_02 = 1;
  }

  if(isDefined(var_01) && var_01 == "MOD_GRENADE_SPLASH") {
    var_02 = 1;
  }

  return var_02;
}

func_EB68() {
  var_00 = gettime();

  if(var_00 < 4500) {
    return 1;
  } else if(var_00 - level.func_2668.func_A943 < 4500) {
    return 1;
  }

  return 0;
}

func_C92A() {
  if(level.player.func_C929 > level.friendlyfire["max_participation"]) {
    level.player.func_C929 = level.friendlyfire["max_participation"];
  }

  if(level.player.func_C929 < level.friendlyfire["min_participation"]) {
    level.player.func_C929 = level.friendlyfire["min_participation"];
  }
}

func_C92B() {
  level endon("mission failed");

  for(;;) {
    if(level.player.func_C929 > 0) {
      level.player.func_C929--;
    } else if(level.player.func_C929 < 0) {
      level.player.func_C929++;
    }

    wait(level.friendlyfire["point_loss_interval"]);
  }
}

func_1299E() {
  level.func_7416 = 0;
}

func_129A9() {
  level.func_7416 = 1;
}

func_B8CF(var_00) {
  if(!isDefined(var_00)) {
    var_00 = 0;
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
  _setsaveddvar("hud_missionFailed", 1);
  setomnvar("ui_hide_weapon_info", 1);
  _setsaveddvar("hud_showstance", 0);
  _setsaveddvar("actionSlotsHide", 1);

  if(isDefined(level.player.func_6AD1)) {
    return;
  }
  if(var_00) {
    setomnvar("ui_death_hint", 9);
  } else if(isDefined(level.func_4C51)) {
    func_0B60::func_F32D(level.func_4C51);
  } else {
    setomnvar("ui_death_hint", 12);
  }

  if(isDefined(level.func_4C52)) {
    thread func_0B60::func_F330(level.func_4C52, 64, 64, 0);
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
    self.func_6BAE = level.player;
    wait 0.05;
  }
}

func_C15E(var_00) {
  var_00 endon("death");

  for(;;) {
    var_00 waittill("damage", var_01, var_02, var_03, var_04, var_05, var_06, var_06, var_06, var_06, var_07);
    var_00 notify("friendlyfire_notify", var_01, var_02, var_03, var_04, var_05, var_07);
  }
}

func_C160(var_00) {
  var_00 waittill("damage_notdone", var_01, var_02, var_03, var_04);
  var_00 notify("friendlyfire_notify", -1, var_02, undefined, undefined, var_04);
}

func_C161(var_00) {
  var_00 waittill("death", var_01, var_02, var_03);
  var_00 notify("friendlyfire_notify", -1, var_01, undefined, undefined, var_02, var_03);
}

func_53AE(var_00) {}