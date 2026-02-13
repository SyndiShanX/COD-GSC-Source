/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2646.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("nuke", ::_id_F796);
  scripts\mp\killstreaks\killstreaks::_id_C26A("nuke_select_location", ::_id_F796);
  level._effect["nuke_rolling_death"] = loadfx("vfx/iw8_mp/killstreak/vfx_nuke_player_death_2.vfx");
  level._id_A6F8 = scripts\cp_mp\utility\game_utility::_id_6B19("nuke_expl_pos");
}

_id_F795() {
  var_0 = scripts\cp_mp\utility\killstreak_utility::_id_4056("nuke", self);
  return _id_F796(var_0);
}

_id_F796(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  if(getdvarint("#x3216f538ad3bf849b", 1) == 0) {
    scripts\mp\hud_message::_id_DCA2("KILLSTREAKS/UNAVAILABLE");
    return 0;
  }

  if(isDefined(level._id_8DEB)) {
    if(!level[[level._id_8DEB]](var_0)) {
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(var_0.streakname == "nuke_select_location") {
    var_1 = 1;
  } else {
    var_1 = 0;
  }

  var_0._id_A745 = var_1;
  var_2 = undefined;
  var_3 = undefined;

  if(!isDefined(level._id_A737)) {
    level._id_A737 = 1;
    level._id_A73D = self;
  } else {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/NUKE_ALREADY_INBOUND");
    }

    return 0;
  }

  if(var_1 == 1) {
    var_4 = _id_09B9::_id_EA03(var_0, makeweapon("s4_binoculars_mp", ["spotterscope"]), "weapon_fired", ::_id_10D94, ::_id_10DE1, ::_id_10D82);
    var_2 = _id_09AB::_id_13C3(self);
    var_3 = 25;
    var_5 = scripts\mp\utility\game::_id_6BE2(var_0.owner.team);
    level thread _id_A725(var_5[0]);
  } else if(!istrue(level._id_9DDC))
    var_4 = _id_09B9::_id_EA01(var_0, makeweapon("s4_ks_gesture_generic_mp"));
  else {
    var_4 = 1;
  }

  if(!istrue(var_4) || level.gameended) {
    level._id_A737 = undefined;
    level._id_A73D = undefined;
    var_0 notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  if(isDefined(level._id_8DC6)) {
    if(!level[[level._id_8DC6]](var_0)) {
      level._id_A737 = undefined;
      level._id_A73D = undefined;
      var_0 notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  thread _id_A716(var_0, 0, undefined, undefined, var_2, undefined, var_3);

  if(var_1 != 1 && !istrue(level._id_9DDC)) {
    scripts\common\utility::_id_F73A(level._id_9BB4, "nuke", self.origin);
  }

  if(!istrue(level._id_9DDC)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("sound", "playKillstreakDeployDialog")) {
      [[scripts\cp_mp\utility\script_utility::getsharedfunc("sound", "playKillstreakDeployDialog")]](self, var_0.streakname);
    }
  }

  return 1;
}

_id_10D94(var_0) {
  return 1;
}

_id_10DE1(var_0, var_1) {
  if(istrue(var_1)) {
    thread _id_09AB::_id_13D6(var_0, "splash_icon_nuke");
  }
}

_id_10D82(var_0, var_1, var_2) {
  var_3 = _id_09AB::_id_13C3(self);

  if(!isDefined(var_3)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage")) {
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/INVALID_POINT");
    }

    return "continue";
  }

  return "success";
}

_id_A6F4(var_0, var_1, var_2, var_3) {
  level endon("nuke_cancelled");

  if(isDefined(var_0)) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  }

  level thread[[var_1]](var_2, var_3);
}

_id_A716(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level endon("nuke_cancelled");
  level notify("used_nuke");
  self notify("used_nuke");
  var_0 notify("killstreak_finished_with_deploy_weapon", 1);
  level._id_A738 = spawnStruct();
  level._id_A738.player = self;
  level._id_A738.team = self.pers["team"];
  level._id_A748 = "aftermath_post";
  level._id_3161 = 0;
  level._id_A735 = undefined;
  level._id_A731 = undefined;
  level._id_A72A = undefined;
  var_8 = 0;
  var_9 = self.origin + (0, 0, 30000) + anglesToForward(self.angles) * 30000;
  var_10 = self.origin + anglesToForward(self.angles) * 15000;

  if(isDefined(level._id_A6F8)) {
    var_10 = level._id_A6F8.origin;
    var_11 = vectornormalize((var_10[0], var_10[1], 0) - (self.origin[0], self.origin[1], 0));
    var_9 = var_10 + var_11 * 15000;
    var_9 = var_9 + (0, 0, 30000) + var_11 * 5000;
  } else if(var_0.streakname != "nuke_select_location") {}

  var_12 = 6;
  var_13 = 10;
  var_14 = 1;

  if(istrue(var_1)) {
    var_8 = var_1;

    if(istrue(var_8)) {
      level._id_3161 = 1;
    }
  }

  if(isDefined(var_3)) {
    var_9 = var_3;
  }

  if(isDefined(var_4)) {
    var_10 = var_4;
  }

  if(istrue(var_5)) {
    var_12 = var_5;
  }

  if(istrue(var_6)) {
    var_13 = var_6;
  }

  if(istrue(var_2)) {
    var_14 = var_2;
  }

  if(!isDefined(level._id_A6EE)) {
    level._id_A6EE = spawn("script_origin", var_9 + (0, 0, 100));
    level._id_A6EE dontinterpolate();
    level._id_A6EE hide();
  } else
    level._id_A6EE.origin = var_9 + (0, 0, 100);

  level._id_A700 = spawn("script_model", var_10 + (0, 0, 5000));
  level._id_A700 setModel("tag_origin");
  level._id_A700.team = self.team;
  level._id_A700.owner = self;
  level._id_A700.streakinfo = var_0;

  if(istrue(level._id_9DDC)) {
    var_12 = 0.7;
  }

  level thread _id_A719(self, var_0, var_14, var_9, var_10, var_12, var_13, var_7);
  var_0._id_A736 = var_10;
  var_15 = var_12 + var_13;

  if(isDefined(var_0._id_A745) && var_0._id_A745 == 1) {
    level thread _id_A6F4(var_15, ::_id_A6EF, self, var_0);
  }

  level thread _id_A6F4(var_15, ::_id_A715, self, var_0);
  level thread _id_A6F4(var_15, ::_id_A6F9, self, var_0);
  level thread _id_A6F4(var_15, ::_id_A6F7, self, var_0);
  level thread _id_A6F4(var_15 + 0.075, ::_id_A724, self, var_0);
  level thread _id_A6F4(var_15 + 5, ::_id_A6F1, self, var_0);

  if(isDefined(level._id_8DD3)) {
    level thread[[level._id_8DD3]](var_0);
  }

  scripts\mp\rank::_id_1144(2, level._id_A738.team, "nuke");

  if(level._id_3161 && var_8) {
    level thread _id_A726(level._id_A738.player);
  }
}

_id_A726(var_0) {
  if(!isDefined(level._id_A720)) {
    _func_0428("nuke");
    level._id_A720 = 1;
  }

  level endon("game_ended");
  var_0 waittill("disconnect");
  level._id_A72A = 1;
  level._id_A737 = undefined;
  level._id_A73D = undefined;
  _id_A6ED();
  _func_01F0(1, 1, 0);
  level notify("nuke_cancelled");
}

_id_A71F(var_0) {
  level endon("nuke_cancelled");

  if(istrue(level._id_9DDC)) {
    setomnvar("ui_nuke_timer_type", 2);
  } else {
    setomnvar("ui_nuke_timer_type", 0);
  }

  setomnvar("ui_nuke_countdown_active", 1);
  level thread _id_A722(var_0);
  var_1 = var_0;
  var_2 = 0;
  var_3 = 0;
  thread _id_084C::v2_timer_start(level._id_A6EE);

  while(var_1 > 0) {
    if(var_1 <= 10) {
      thread _id_084C::v2_timer_tick(level._id_A6EE);

      if(isDefined(level._id_A708) && !istrue(var_2)) {
        level thread _id_A71B();
        var_2 = 1;
      }
    }

    if(var_1 <= 4.9) {
      if(isDefined(level._id_A708) && !istrue(var_3)) {
        var_3 = 1;
      }
    }

    wait 1.0;
    var_1--;
  }
}

_id_A71B() {
  level._id_A708 endon("death");
  level endon("game_ended");
  thread _id_084C::v2_incoming(level._id_A708);
}

_id_A6ED() {
  setomnvar("ui_nuke_countdown_active", -1);
}

_id_A719(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  level thread _id_A71E(var_5, var_1, var_0);
  thread _id_084C::_id_13BF();

  if(var_0 _meth_8685()) {
    var_0 setclientomnvar("nVidiaHighlights_events", 16);
  }

  if(var_1.streakname != "nuke_select_location") {
    var_8 = _func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_timelimit");
    level._id_10AD4[var_8]._id_04CB = 0;
    level._id_AD6A[var_8] = 0;
    level._id_5856 = 0;
    level._id_4DA1 = 1;

    foreach(var_10 in level.players) {
      if(isDefined(var_10)) {
        var_10 notify("abort_killcam");
        var_10._id_315D = 1;
      }
    }

    level thread _id_A6E6();
    level._id_4AE7 = 1;
  }

  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_5);
  level thread _id_A703(var_0, var_1, var_3, var_4, var_6, var_7);
}

_id_A71E(var_0, var_1, var_2) {
  level endon("game_ended");
  var_3 = 0;

  if(isDefined(var_1) && isDefined(var_2)) {
    var_2 thread scripts\cp_mp\utility\killstreak_utility::_id_B86F("use_" + var_1.streakname, 1, 1);
  }

  while(var_0 > 0) {
    if(isDefined(level._id_A6EE) && !istrue(var_3)) {
      var_3 = 1;
    }

    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(2);
    var_0 = var_0 - 2;
  }
}

_id_A703(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("game_ended");
  var_6 = var_4;
  level thread _id_A71F(var_6);

  if(isDefined(var_0)) {
    level thread scripts\mp\hud_util::_id_EF8D("used_nuke", var_0);
  }

  var_7 = "s4_v2_mp";

  if(isDefined(var_5)) {
    var_7 = var_5;
  }

  var_8 = (0, 0, -1 * getdvarint("#x33c01342f08fa6256", 800));
  var_9 = (var_3 - 0.5 * var_8 * _func_0219(var_4) - var_2) / var_4;
  level._id_A708 = magicgrenademanual(var_7, var_2, var_9, var_4);
  level._id_A708 setscriptablepartstate("launch", "on", 0);
}

_id_A6FD(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_4 = physics_createcontents(["physicscontents_vehicleclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_5 = -2000;
  var_6 = 2000;
  var_7 = (0, 0, -1 * getdvarint("#x33c01342f08fa6256", 800));

  for(;;) {
    var_8 = var_0;
    var_9 = var_8 + (0, 0, 5000);

    if(scripts\engine\trace::ray_trace_passed(var_8, var_9, undefined, var_4)) {
      var_10 = (var_1 - 0.5 * var_7 * _func_0219(var_2) - var_8) / var_2;
      var_3._id_E06F = var_8;
      var_3._id_0200 = var_1;
      var_3._id_82B5 = var_10;
      break;
    }

    var_8 = var_8 + anglestoright(self.angles) * randomintrange(var_5, var_6);
    var_5 = int(var_5 * 1.3);
    var_6 = int(var_6 * 1.3);
    waitframe();
  }

  return var_3;
}

_id_A6F9(var_0, var_1) {
  level endon("nuke_cancelled");
  _id_A6ED();
  level._id_A731 = 1;
  level notify("nuke_detonated");

  if(isDefined(level._id_A708)) {
    level._id_A6FA = level._id_A708.origin;
    level._id_A708 setscriptablepartstate("launch", "off", 0);
    level._id_A708 delete();
  } else
    level._id_A6FA = (0, 0, 0);

  var_2 = spawn("script_model", level._id_A6FA);
  var_2 setModel("ks_nuke_mp");
  var_2 setscriptablepartstate("explode", "on", 0);
  var_2 thread scripts\mp\utility\script::_id_46C7(50);
  thread _id_084C::v2_explosion(level._id_A6FA);

  if(var_1.streakname != "nuke_select_location") {
    foreach(var_4 in level.characters) {
      if(_id_A6EA(var_4, _id_A6EB())) {
        if(isPlayer(var_4)) {
          var_4 _meth_867F("mp_killstreak_nuke");

          if(scripts\mp\utility\player::isreallyalive(var_4)) {
            var_4 thread _id_A71C();
          }
        }
      }
    }
  } else {
    foreach(var_4 in level.characters) {
      if(isPlayer(var_4) && scripts\mp\utility\player::isreallyalive(var_4)) {
        var_4 thread _id_A71D();
        var_4 _meth_867F("mp_killstreak_nuke");
      }
    }
  }
}

_id_A718(var_0) {}

_id_A715(var_0, var_1) {
  if(var_1.streakname == "nuke_select_location") {
    return;
  }
  level endon("nuke_cancelled");
  level waittill("nuke_death");
  _func_01F0(1, 0.25, 0.1);
}

_id_D613() {
  if(!isDefined(level._id_A720)) {
    _func_0428("nuke");
    level._id_A720 = 1;
  }
}

_id_A6F6(var_0, var_1) {
  level endon("nuke_cancelled");

  foreach(var_3 in level.players) {
    var_3 thread _id_A6E8();
  }
}

_id_A6E8() {
  self endon("disconnect");
  self _meth_8660(2.0, 1500);
}

_id_A724(var_0, var_1) {
  level endon("nuke_cancelled");
  level._id_A747 = 1;
  visionsetnaked("nuke_global_flash", 0.05);
  setDvar("#x39e121f7b6097fb74", 0);
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(0.5);
  level notify("nuke_aftermath_post_started");
  level thread _id_A6FB(1, 2);
  level waittill("nuke_death");
  level thread _id_A723();
  level _id_A712(5);
}

_id_A6FB(var_0, var_1) {
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);
  visionsetnaked("", var_1);
}

_id_A6F1(var_0, var_1) {
  level endon("nuke_cancelled");
  level endon("game_ended");
  level notify("nuke_death");
  var_2 = level._id_A738.player;

  if(level.teambased) {
    var_2 = level._id_A700.team;
  }

  scripts\mp\hostmigration::waittillhostmigrationdone();
  var_3 = _id_A6EB();

  if(isDefined(level._id_A738.player)) {
    if(var_1.streakname != "nuke_select_location") {
      foreach(var_5 in level.characters) {
        if(_id_A6EA(var_5, var_3)) {
          if(isPlayer(var_5)) {
            var_5._id_A72E = 1;

            if(scripts\mp\utility\player::isreallyalive(var_5) && !istrue(var_5._id_CACF)) {
              var_6 = level._id_A738.player;

              if(level.teambased && var_5.team == var_6.team) {
                var_6 = var_5;
              }

              var_7 = makeweapon("s4_v2_mp");
              var_5 dodamage(999999, level._id_A700.origin, var_6, level._id_A700, "MOD_EXPLOSIVE", var_7, "none");
            }
          }
        }
      }

      if(istrue(var_3)) {
        _id_A6F5();
      } else if(!istrue(level._id_259B)) {
        var_9 = scripts\mp\utility\teams::_id_6A01(level._id_A700.team);

        foreach(var_11 in var_9) {
          _id_A6F5(var_11);
        }
      }

      scripts\mp\utility\print::_id_BD15("killstreak ended - nuke", level._id_A738.player);
    } else {
      foreach(var_5 in level.characters) {
        if(_id_A702(var_5, level._id_A6FA, 25000000)) {
          if(isPlayer(var_5)) {
            var_5._id_A72E = 1;

            if(scripts\mp\utility\player::isreallyalive(var_5)) {
              var_7 = makeweapon("s4_v2_mp");
              _id_07C3::_id_108F(var_5, level._id_A738.player, undefined, var_7, 0, undefined, undefined, undefined, undefined, undefined);
              var_14 = vectornormalize(var_5.origin + (0, 0, 1000) - level._id_A700.origin);
              var_5 thread _id_07C3::_id_5B1C(level._id_A700, level._id_A738.player, 999999, 0, "MOD_EXPLOSIVE", var_7, var_5.origin, var_14, "none", 0, 0, undefined, undefined);
            }
          }
        }
      }
    }

    if(!istrue(level._id_9DDC)) {
      if(isDefined(level._id_A738.player) && isDefined(var_1)) {
        level._id_A738.player scripts\cp_mp\utility\killstreak_utility::_id_C14A(var_1);
      }
    }
  }

  if(istrue(var_3)) {
    level._id_A735 = 1;
    level thread _id_A6F3(3, var_2);
  }
}

_id_A6F3(var_0, var_1) {
  level endon("game_ended");
  level thread _id_A70A(1);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);

  if(scripts\mp\utility\game::_id_875D()) {
    level thread scripts\mp\gametypes\arena_evo_tourney::_id_1ACB(var_1);
  } else {
    if(istrue(level._id_9DDC)) {
      level thread scripts\mp\gamelogic::_id_52F7(var_1, game["end_reason"]["mercy_win"], game["end_reason"]["mercy_loss"], 1, 1);
      return;
    }

    level thread scripts\mp\gamelogic::_id_52F7(var_1, game["end_reason"]["nuke_end"], undefined, 1);
  }
}

_id_A70A(var_0) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_0);
  level notify("play_nuke_bnk");
  _func_01EA("post_game_state", 13);
}

_id_A6EA(var_0, var_1) {
  if(istrue(level._id_259B)) {
    return 0;
  }

  if(!isDefined(level._id_A738)) {
    return 0;
  }

  if(istrue(var_1)) {
    return 1;
  }

  if(level.teambased) {
    if(isDefined(level._id_A738.team) && var_0.team == level._id_A738.team) {
      return 0;
    }
  } else {
    var_2 = isDefined(level._id_A738.player) && var_0 == level._id_A738.player;
    var_3 = isDefined(level._id_A738.player) && isDefined(var_0.owner) && var_0.owner == level._id_A738.player;

    if(var_2 || var_3) {
      return 0;
    }
  }

  return 1;
}

_id_A6F7(var_0, var_1) {
  level endon("nuke_cancelled");

  if(!isDefined(level._id_9AAC)) {
    var_2 = var_1._id_A736;
  } else {
    var_2 = level._id_9AAC;
  }

  earthquake(0.4, 2, var_2, 100000);
  level thread _id_A70C(var_1);
  level waittill("nuke_death");

  if(var_1.streakname == "nuke_select_location") {
    earthquake(0.3, 1, var_2, 100000);
  } else {
    earthquake(1.3, 3, var_2, 100000);
  }

  foreach(var_4 in level.players) {
    var_4 _meth_83F4("tank_rumble");
    var_4 playrumbleonentity("damage_heavy");
  }
}

_id_A70C(var_0) {
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var_1 = 0.01;

  if(!isDefined(level._id_9AAC)) {
    var_2 = var_0._id_A736;
  } else {
    var_2 = level._id_9AAC;
  }

  foreach(var_4 in level.players) {
    var_4 _meth_8278("tank_rumble");
  }

  for(;;) {
    earthquake(var_1, 0.05, var_2, 100000);
    wait 0.05;
    var_1 = var_1 + 0.002;

    if(var_1 >= 0.6) {
      var_1 = 0.6;
    }
  }
}

onplayerspawned() {
  if(isDefined(level._id_A731)) {
    thread _id_A713(0, 0);
  }
}

_id_A713(var_0, var_1) {
  if(isDefined(var_0) && var_0 > 0) {
    wait(var_0);
  }

  self visionsetnakedforplayer("nuke_global_aftermath", var_1);
}

_id_A722(var_0) {
  level endon("game_ended");
  level endon("disconnect");
  level endon("nuke_cancelled");
  level endon("nuke_death");
  var_1 = var_0 * 1000 + gettime();
  setomnvar("ui_nuke_end_milliseconds", var_1);
  level waittill("host_migration_begin");
  var_2 = scripts\mp\hostmigration::waittillhostmigrationdone();

  if(var_2 > 0) {
    setomnvar("ui_nuke_end_milliseconds", var_1 + var_2);
  }
}

_id_A723() {
  level endon("game_ended");

  for(;;) {
    level waittill("host_migration_end");
    level _id_A712(0);
  }
}

_id_A712(var_0) {
  if(isDefined(level._id_A730)) {
    level thread[[level._id_A730]]();
  }

  _id_A714();
}

_id_A714() {
  _func_01EA("post_game_state", 12);

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_1, 1);
    var_1 setclientomnvar("ui_world_fade", 1);
    var_1 _meth_82FD("nuke_killstreak", 2, "ambient", "ambient_events");
  }

  level thread _id_A710();
}

_id_A710() {
  level endon("game_ended");
  level waittill("play_nuke_bnk");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    level thread scripts\cp_mp\utility\game_utility::_id_58C7(var_1, 0, 1);
  }
}

_id_A6F5(var_0) {
  var_1 = "s4_v2_mp";
  var_2 = level._id_0F4C;
  var_3 = [[level._id_6885]]();
  var_4 = undefined;

  if(isDefined(var_2) && isDefined(var_3)) {
    var_4 = scripts\engine\utility::_id_1B9D(var_2, var_3);
  } else if(isDefined(var_2)) {
    var_4 = var_2;
  } else if(isDefined(var_3)) {
    var_4 = var_3;
  }

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6)) {
        var_6 scripts\mp\utility\killstreak::_id_4C56(10000, level._id_A738.player, level._id_A738.player, var_0, var_6.origin, "MOD_EXPLOSIVE", var_1);
      }
    }
  }
}

_id_A71C() {
  self endon("disconnect");

  if(!istrue(self._id_CACF)) {
    scripts\mp\weapons::_id_523B(1, "nuke_active");
  }

  thread _id_A70B(3.25);
  level waittill("nuke_death");

  if(isDefined(self._id_2D80) && self._id_2D80 > 0) {
    scripts\mp\weapons::_id_4A84(1, "nuke_active");
  }

  var_0 = 0;

  if(var_0) {
    return;
  }
}

_id_A71D() {
  self endon("disconnect");
  scripts\mp\weapons::_id_523B(1, "nuke_active");
  thread _id_A70B(3.25);
  level waittill("nuke_death");
  scripts\mp\weapons::_id_4A84(1, "nuke_active");
}

_id_A70B(var_0) {
  self endon("disconnect");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0);

  if(!scripts\mp\utility\player::_id_8ACE()) {
    self visionsetnakedforplayer("nuke_deathblur", 4);
  }

  var_1 = self.origin;
  var_2 = level._id_A6FA;
  var_3 = var_1;
  var_4 = "nuke_rolling_death";
  playFX(scripts\engine\utility::getfx(var_4), var_1, var_2 - var_3, undefined, self);
}

_id_A6E9() {
  self endon("disconnect");
  var_0[0][0]["org"] = self gettagorigin("j_spineupper");
  var_0[0][0]["angles"] = self gettagangles("j_spineupper");
  var_0[0][1]["org"] = self gettagorigin("j_spinelower");
  var_0[0][1]["angles"] = self gettagangles("j_spinelower");
  var_0[0][2]["org"] = self gettagorigin("j_head");
  var_0[0][2]["angles"] = self gettagangles("j_head");
  var_0[1][0]["org"] = self gettagorigin("j_knee_ri");
  var_0[1][0]["angles"] = self gettagangles("j_knee_ri");
  var_0[1][1]["org"] = self gettagorigin("j_knee_le");
  var_0[1][1]["angles"] = self gettagangles("j_knee_le");
  var_0[1][2]["org"] = self gettagorigin("j_elbow_ri");
  var_0[1][2]["angles"] = self gettagangles("j_elbow_ri");
  var_0[1][3]["org"] = self gettagorigin("j_elbow_le");
  var_0[1][3]["angles"] = self gettagangles("j_elbow_le");
  var_0[2][0]["org"] = self gettagorigin("j_ankle_le");
  var_0[2][0]["angles"] = self gettagangles("j_ankle_le");
  var_0[2][1]["org"] = self gettagorigin("j_ankle_ri");
  var_0[2][1]["angles"] = self gettagangles("j_ankle_ri");
  var_0[2][2]["org"] = self gettagorigin("j_wrist_le");
  var_0[2][2]["angles"] = self gettagangles("j_wrist_le");
  var_0[2][3]["org"] = self gettagorigin("j_wrist_ri");
  var_0[2][3]["angles"] = self gettagangles("j_wrist_ri");
  self._id_25CA hide();
  var_1 = self._id_25CA.origin;
  var_2 = level._id_A700.origin * (1, 1, 0);
  var_3 = var_1 * (1, 1, 0);
  var_4 = "nuke_atomize_body";
  playFX(scripts\engine\utility::getfx(var_4), var_1, var_2 - var_3);
}

_id_A6EB() {
  var_0 = 1;

  if(scripts\mp\utility\game::getgametype() == "br") {
    var_0 = 0;
  }

  return var_0;
}

_id_A6EF(var_0, var_1) {
  if(0) {
    wait 10;
    playFX(scripts\engine\utility::getfx("vfx_nuke_zone_5000_static_s"), (0, 0, 0));
    _id_A70F((0, 0, 0));

    if(!isDefined(level._id_A72F)) {
      level._id_A72F = [];
    }

    level._id_A72F[level._id_A72F.size] = _id_0817::_id_1135(var_1._id_A736 - (0, 0, 1000), 5000, 15000, "axis", 4000);
    level._id_A72F[level._id_A72F.size] = _id_0817::_id_1135(var_1._id_A736 - (0, 0, 1000), 5000, 15000, "allies", 4000);
  } else {
    var_1._id_CFA4 = (var_1._id_A736[0], var_1._id_A736[1], _id_0797::_id_693F());
    playFX(scripts\engine\utility::getfx("vfx_nuke_zone_5000_static_s"), var_1._id_CFA4);
    _id_A70F(var_1._id_CFA4);

    if(!isDefined(level._id_A72F)) {
      level._id_A72F = [];
    }

    level._id_A72F[level._id_A72F.size] = _id_0817::_id_1135(var_1._id_A736 - (0, 0, 1000), 5000, 15000, "axis", 4000);
    level._id_A72F[level._id_A72F.size] = _id_0817::_id_1135(var_1._id_A736 - (0, 0, 1000), 5000, 15000, "allies", 4000);
  }

  thread _id_A6FC(var_0);
}

_id_A70F(var_0) {
  if(!isDefined(level._id_BF46)) {
    level._id_BF46 = [];
    level thread _id_A70E();
  }

  level._id_BF46[level._id_BF46.size] = var_0;
}

_id_A711(var_0) {
  level._id_BF46 = scripts\engine\utility::array_remove(level._id_BF46, var_0);
}

_id_A70E() {
  level endon("game_ended");
  var_0 = 10;

  for(;;) {
    foreach(var_2 in level.players) {
      var_2._id_82E0 = 0;

      foreach(var_4 in level._id_BF46) {
        if(_id_A702(var_2, var_4, 25000000)) {
          if(istrue(var_2._id_61D4)) {
            var_2 _id_0792::_id_BD65(var_0);
          } else {
            var_2 thread scripts\mp\utility\print::_id_F8D0("MP/NUKE_RADIATION_HURT", 2);
            var_2 dodamage(var_0, var_2.origin, var_2, undefined, "MOD_TRIGGER_HURT");
          }

          var_2._id_82E0 = 1;
          break;
        }
      }

      if(var_2._id_82E0) {
        continue;
      }
      foreach(var_4 in level._id_BF46) {
        if(_id_A702(var_2, var_4, 36000000)) {
          var_2 thread scripts\mp\utility\print::_id_F8D0("MP/NUKE_RADIATION_WARNING", 2);
          break;
        }
      }
    }

    wait 1;
  }
}

_id_A725(var_0) {
  level endon("nuke_death");

  for(;;) {
    foreach(var_2 in level.players) {
      if(var_2.team == var_0) {
        var_2 thread scripts\mp\utility\print::_id_F8D0("MP/NUKE_SELECT_LAUNCH_DETECTED", 2);
      }
    }

    wait 1;
  }
}

_id_A702(var_0, var_1, var_2) {
  var_3 = distance2dsquared(var_1, var_0.origin);
  return var_3 < var_2;
}

_id_A6FC(var_0) {
  wait 20;

  if(istrue(var_0._id_758D)) {
    var_0._id_758D = 0;
  }

  if(isDefined(var_0._id_8D6F)) {
    var_0._id_8D6F = 0;
  }

  visionsetnaked("", 1);
}

_id_A6E6() {
  level endon("game_ended");

  for(;;) {
    level waittill("player_spawned", var_0);

    if(isDefined(var_0)) {
      var_0 notify("abort_killcam");
      var_0._id_315D = 1;
    }
  }
}