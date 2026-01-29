/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\319.gsc
**************************************/

main() {
  level.friendlyfire["min_participation"] = -200;
  level.friendlyfire["max_participation"] = 1000;
  level.friendlyfire["enemy_kill_points"] = 250;
  level.friendlyfire["friend_kill_points"] = -650;
  level.friendlyfire["point_loss_interval"] = 1.25;
  level.player._id_1FE1 = 0;
  level.friendlyfiredisabled = 0;
  level.friendlyfiredisabledfordestructible = 0;
  setdvarifuninitialized("friendlyfire_dev_disabled", "0");
  common_scripts\utility::flag_init("friendly_fire_warning");
  thread _id_1FE3();
  thread _id_1FED();
}

_id_1FE3() {}

_id_1FE4(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  if(!isDefined(var_0.team)) {
    var_0.team = "allies";

  }
  if(isDefined(level._id_17D3)) {
    return;
  }
  level endon("mission failed");
  level thread _id_1FF3(var_0);
  level thread _id_1FF4(var_0);
  level thread _id_1FF5(var_0);

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
    var_8 = 0;

    if(!isDefined(var_6)) {
      var_6 = var_0.damageweapon;

    }
    if(isDefined(level._id_01DC)) {
      if(isDefined(var_2.damageowner)) {
        var_7 = 1;
        var_2 = var_2.damageowner;
      }
    }

    if(isplayer(var_2)) {
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
    } else if(isDefined(var_2.code_classname) && var_2.code_classname == "script_vehicle") {
      var_9 = var_2 getvehicleowner();

      if(isDefined(var_9) && isplayer(var_9)) {
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

    if(level.script == "airport") {
      var_11 = 0;
    } else if(isDefined(var_0.type) && var_0.type == "civilian") {
      var_11 = 1;
    } else {
      var_11 = issubstr(var_0.classname, "civilian");

    }
    var_12 = var_1 == -1;

    if(!var_10 && !var_11) {
      if(var_12) {
        level.player._id_1FE1 = level.player._id_1FE1 + level.friendlyfire["enemy_kill_points"];
        _id_1FEC();
        return;
      }
    } else {
      if(isDefined(var_0._id_17D3)) {
        continue;
      }
      if(var_5 == "MOD_PROJECTILE_SPLASH" && isDefined(level._id_1FE5)) {
        continue;
      }
      if(isDefined(var_6) && var_6 == "claymore") {
        continue;
      }
      if(var_12) {
        if(isDefined(var_0._id_1FE6)) {
          level.player._id_1FE1 = level.player._id_1FE1 + var_0._id_1FE6;
        } else {
          level.player._id_1FE1 = level.player._id_1FE1 + level.friendlyfire["friend_kill_points"];
        }
      } else {
        level.player._id_1FE1 = level.player._id_1FE1 - var_1;

      }
      _id_1FEC();

      if(_id_1FEA(var_0, var_5) && _id_1FEB()) {
        if(var_12) {
          return;
        } else {
          continue;
        }
      }

      if(isDefined(level._id_1FE7)) {
        [[level._id_1FE7]](var_0, var_1, var_2, var_3, var_4, var_5, var_6);
        continue;
      }

      _id_1FE8(var_11);
    }
  }
}

_id_1FE8(var_0) {
  if(isDefined(level._id_1FE9) && level._id_1FE9) {
    level thread _id_1FF0(var_0);
    return;
  }

  var_1 = level.friendlyfiredisabledfordestructible;

  if(isDefined(level._id_01DC) && var_0) {
    var_1 = 0;

  }
  if(var_1) {
    return;
  }
  if(level.friendlyfiredisabled == 1) {
    return;
  }
  if(level.player._id_1FE1 <= level.friendlyfire["min_participation"]) {
    level thread _id_1FF0(var_0);
  }
}

_id_1FEA(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;

  }
  var_2 = 0;

  if(isDefined(var_0.damageweapon) && var_0.damageweapon == "none") {
    var_2 = 1;

  }
  if(isDefined(var_1) && var_1 == "MOD_GRENADE_SPLASH") {
    var_2 = 1;

  }
  return var_2;
}

_id_1FEB() {
  var_0 = gettime();

  if(var_0 < 4500) {
    return 1;
  } else if(var_0 - level._id_1C2B < 4500) {
    return 1;

  }
  return 0;
}

_id_1FEC() {
  if(level.player._id_1FE1 > level.friendlyfire["max_participation"]) {
    level.player._id_1FE1 = level.friendlyfire["max_participation"];

  }
  if(level.player._id_1FE1 < level.friendlyfire["min_participation"]) {
    level.player._id_1FE1 = level.friendlyfire["min_participation"];
  }
}

_id_1FED() {
  level endon("mission failed");

  for(;;) {
    if(level.player._id_1FE1 > 0) {
      level.player._id_1FE1--;
    } else if(level.player._id_1FE1 < 0) {
      level.player._id_1FE1++;

    }
    wait(level.friendlyfire["point_loss_interval"]);
  }
}

_id_1FEE() {
  level.friendlyfiredisabled = 0;
}

_id_1FEF() {
  level.friendlyfiredisabled = 1;
}

_id_1FF0(var_0) {
  if(!isDefined(var_0)) {
    var_0 = 0;

  }
  if(level.script == "airport") {
    if(var_0) {
      return;
    }
    common_scripts\utility::flag_set("friendly_fire_warning");
    return;
  }

  if(getdvar("friendlyfire_dev_disabled") == "1") {
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

  if(isDefined(level.player._id_1EF4)) {
    return;
  }
  if(var_0) {
    setdvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_CIVILIAN_KILLED");
  } else if(isDefined(level._id_1FF1)) {
    setdvar("ui_deadquote", level._id_1FF1);
  } else if(level._id_0BA2 == "british") {
    setdvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_BRITISH");
  } else if(level._id_0BA2 == "russian") {
    setdvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_RUSSIAN");
  } else {
    setdvar("ui_deadquote", &"SCRIPT_MISSIONFAIL_KILLTEAM_AMERICAN");

  }
  if(isDefined(level._id_1FF2)) {
    thread maps\_load::_id_1EF6(level._id_1FF2, 64, 64, 0);

  }
  reconspatialevent(level.player.origin, "script_friendlyfire: civilian %d", var_0);
  maps\_utility::_id_1826();
}

_id_1FF3(var_0) {
  level endon("mission failed");
  var_0 endon("death");

  for(;;) {
    var_1 = undefined;
    var_2 = undefined;
    var_3 = undefined;
    var_4 = undefined;
    var_5 = undefined;
    var_6 = undefined;
    var_7 = undefined;
    var_8 = undefined;
    var_9 = undefined;
    var_10 = undefined;
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
    var_0 notify("friendlyfire_notify", var_1, var_2, var_3, var_4, var_5, var_10);
  }
}

_id_1FF4(var_0) {
  level endon("mission failed");
  var_0 waittill("damage_notdone", var_1, var_2, var_3, var_4, var_5);
  var_0 notify("friendlyfire_notify", -1, var_2, undefined, undefined, var_5);
}

_id_1FF5(var_0) {
  level endon("mission failed");
  var_0 waittill("death", var_1, var_2, var_3);
  var_0 notify("friendlyfire_notify", -1, var_1, undefined, undefined, var_2, var_3);
}

_id_1FF6(var_0) {}