/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\pill.gsc
*************************************************/

main() {
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "grind";
  var_0[2] = "dom";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 85);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level._id_4CEB = [];
  scripts\mp\gametypes\obj_grindzone::init();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  level._id_3B72["vanish"] = loadfx("vfx/core/impacts/small_snowhit");
  _id_07D2::init();
  level._id_7C74 = "icon_waypoint_generic";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3d52b76cc216819cc", getmatchrulesdata("pillData", "bankTime"));
  setdynamicdvar("#x3d58c635e26648b0f", getmatchrulesdata("pillData", "bankRate"));
  setdynamicdvar("#x329466475f99b7490", getmatchrulesdata("pillData", "bankCaptureTime"));
  setdynamicdvar("#x3246d12d88df83cd6", getmatchrulesdata("pillData", "megaBankLimit"));
  setdynamicdvar("#x3f80dca4bacfc4d3c", getmatchrulesdata("pillData", "megaBankBonus"));
  setdynamicdvar("#x35f29b4814b9d5403", 0);
  scripts\mp\utility\game::_id_C25D("grind", 0);
  setdynamicdvar("#x3c8d9f3626effd73d", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  scripts\mp\utility\game::_id_D61C("allies", &"OBJECTIVES/WAR");
  scripts\mp\utility\game::_id_D61C("axis", &"OBJECTIVES/WAR");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/WAR");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/WAR");
  } else {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/WAR_SCORE");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/WAR_SCORE");
  }

  scripts\mp\utility\game::_id_D615("allies", &"OBJECTIVES/WAR_HINT");
  scripts\mp\utility\game::_id_D615("axis", &"OBJECTIVES/WAR_HINT");
  _id_8294();
  _id_405B();
  level._id_4CE2 = ::_id_4CE2;
  scripts\mp\gametypes\br_pickups::_id_8141();
  scripts\mp\gametypes\br_pickups::_id_825A();
  _id_E31F();
  level thread _id_C52E();
  level thread _id_21DB();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_21DC = scripts\mp\utility\dvars::_id_509A("bankTime", 2, 0, 10);
  level._id_21D9 = scripts\mp\utility\dvars::_id_509C("bankRate", 1, 1, 1000);
  level._id_21CD = scripts\mp\utility\dvars::_id_509C("bankCaptureTime", 0, 0, 10);
  level._id_9D38 = scripts\mp\utility\dvars::_id_509C("megaBankLimit", 5, 5, 15);
  level._id_9D36 = scripts\mp\utility\dvars::_id_509C("megaBankBonus", 150, 0, 750);
}

_id_ABA4() {
  if(isDefined(self._id_ED74)) {
    self setclientomnvar("ui_pillage_currency", self._id_ED74);
  }
}

_id_405B() {
  level._id_4CE8 = [];

  for(var_0 = 0; var_0 < 30; var_0++) {
    var_1[0] = spawn("script_model", (0, 0, 0));
    var_1[0] setModel("military_dogtags_iw8_orange");
    var_1[1] = spawn("script_model", (0, 0, 0));
    var_1[1] setModel("military_dogtags_iw8_blue");
    var_1[0] _meth_82CB("mp_dogtag_spin");
    var_1[1] _meth_82CB("mp_dogtag_spin");
    var_1[0] hide();
    var_1[1] hide();
    var_1[0] setasgametypeobjective();
    var_1[1] setasgametypeobjective();
    var_2 = spawn("trigger_radius", (0, 0, 0), 0, 32, 32);
    var_2._id_0481 = "trigger_dogtag";
    var_2 hide();
    var_3 = spawnStruct();
    var_3.type = "useObject";
    var_3._id_4140 = var_2.origin;
    var_3._id_5513 = var_2 getentitynumber();
    var_3._id_90B8 = 0;
    var_3._id_10430 = var_1;
    var_3._id_A97E = (0, 0, 16);
    var_3.trigger = var_2;
    var_3._id_F637 = "proximity";
    var_3 _id_07D6::_id_15DF("none");
    level._id_4CE8[level._id_4CE8.size] = var_3;
  }
}

_id_6DB1() {
  var_0 = level._id_4CE8[0];
  var_1 = gettime();

  foreach(var_3 in level._id_4CE8) {
    if(!isDefined(var_3._id_90B8)) {
      continue;
    }
    if(var_3._id_83B6 == "none") {
      var_0 = var_3;
      break;
    }

    if(var_3._id_90B8 < var_1) {
      var_1 = var_3._id_90B8;
      var_0 = var_3;
    }
  }

  var_0 notify("reset");
  var_0 _id_07D6::_id_81EA();
  var_0._id_90B8 = gettime();
  return var_0;
}

_id_E38B(var_0, var_1) {
  var_2 = var_0 + (0, 0, 14);
  var_3 = (0, randomfloat(360), 0);
  var_4 = anglesToForward(var_3);
  var_5 = randomfloatrange(30, 150);
  var_6 = var_2 + var_5 * var_4;
  var_2 = _func_019A(var_2, var_6);
  var_7 = _id_6DB1();
  var_7._id_4140 = var_2;
  var_7.trigger.origin = var_2;
  var_7._id_10430[0].origin = var_2;
  var_7._id_10430[1].origin = var_2;
  var_7.trigger show();
  var_7 _id_07D6::_id_15DF("any");
  var_7._id_10430[0] thread _id_DCF7(var_7, scripts\mp\utility\game::_id_6BE2(var_1)[0]);
  var_7._id_10430[1] thread _id_DCF7(var_7, var_1);
  var_7._id_10430[0] setasgametypeobjective();
  var_7._id_10430[1] setasgametypeobjective();
  playsoundatpos(var_2, "mp_grind_token_drop");
  return var_7;
}

_id_DCF7(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("reset");
  self hide();

  foreach(var_3 in level.players) {
    if(_id_B673(var_3)) {
      if(var_3.team == var_1) {
        self showtoplayer(var_3);
      }

      if(var_3.team == "spectator" && var_1 == "allies") {
        self showtoplayer(var_3);
      }
    }
  }

  for(;;) {
    level waittill("joined_team");
    self hide();

    foreach(var_3 in level.players) {
      if(_id_B673(var_3)) {
        if(var_3.team == var_1) {
          self showtoplayer(var_3);
        }
      }

      if(var_3.team == "spectator" && var_1 == "allies") {
        self showtoplayer(var_3);
      }

      if(var_0._id_103CC == var_3.team && var_3 == var_0.attacker) {
        _id_07F9::_id_FB9E(var_0._id_A906, "invisible");
      }
    }
  }
}

_id_B673(var_0) {
  return 1;
}

_id_A148(var_0) {
  level endon("game_ended");
  var_0 endon("deleted");
  var_0 endon("reset");

  for(;;) {
    var_0.trigger waittill("trigger", var_1);

    if(!scripts\mp\utility\player::isreallyalive(var_1)) {
      continue;
    }
    if(var_1 scripts\mp\utility\player::_id_8ACE() || isDefined(var_1._id_E307)) {
      continue;
    }
    if(isDefined(var_1.classname) && var_1.classname == "script_vehicle") {
      continue;
    }
    if(isagent(var_1) && isDefined(var_1.owner)) {
      var_1 = var_1.owner;
    }

    var_0._id_10430[0] hide();
    var_0._id_10430[1] hide();
    var_0.trigger hide();
    var_0._id_4140 = (0, 0, 1000);
    var_0.trigger.origin = (0, 0, 1000);
    var_0._id_10430[0].origin = (0, 0, 1000);
    var_0._id_10430[1].origin = (0, 0, 1000);
    var_0 _id_07D6::_id_15DF("none");

    if(var_0.team != var_1.team) {
      var_1 _id_B7A5(var_1._id_ED74 + 1);
      var_1 thread _id_0A9F::_id_7003("tag_collected");
    }

    var_1 playSound("mp_killconfirm_tags_pickup");

    if(isDefined(level._id_EB99) && level._id_EB99) {
      if(isDefined(var_1._id_3E59) && var_1._id_3E59) {
        var_1 _id_07C1::_id_D4EE("kill");
      } else {
        var_1 _id_07C1::_id_AA91(undefined, var_1);
      }
    }

    playsoundatpos(var_1.origin, "mp_grind_token_pickup");
    break;
  }
}

onplayerconnect(var_0) {
  var_0._id_8A17 = 0;
  var_0 thread _id_A11C();
}

_id_B7A5(var_0) {
  self._id_ED74 = var_0;
  self._id_01F1 = var_0;
  self setclientomnvar("ui_pillage_currency", var_0);
}

_id_A11C() {
  self endon("disconnect");

  for(;;) {
    scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
    _id_B7A5(0);
  }
}

_id_7902(var_0) {
  level waittill("game_ended");

  if(isDefined(var_0)) {
    var_0.alpha = 0;
  }
}

_id_4073() {
  var_0 = getEntArray("grind_location", "targetname");

  foreach(var_2 in var_0) {
    var_3 = scripts\mp\gametypes\obj_grindzone::_id_D896(var_2);
    var_3 thread _id_CA7E();
    level._id_A8E8[var_3._id_A8E1] = var_3;
  }
}

_id_88D9(var_0, var_1) {
  if(scripts\mp\utility\player::isreallyalive(var_0) && var_0 istouching(var_1.trigger) && var_1._id_ADAE == var_0.team) {
    return 1;
  }

  return 0;
}

_id_CA7E() {
  level endon("game_ended");

  for(;;) {
    self.trigger waittill("trigger", var_0);

    if(self._id_E57B) {
      continue;
    }
    if(isagent(var_0)) {
      continue;
    }
    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0._id_8A17) {
      continue;
    }
    var_0._id_8A17 = 1;
    level thread _id_BD7C(var_0, self);
  }
}

_id_C52E() {
  level waittill("game_ended");

  foreach(var_1 in level.players) {
    if(!isDefined(var_1)) {
      continue;
    }
    if(!isDefined(var_1._id_ED74)) {
      continue;
    }
    var_1._id_ED74 = 0;
  }
}

_id_BD7C(var_0, var_1) {
  while(var_0._id_ED74 && _id_88D9(var_0, var_1) && !var_1._id_E57B) {
    var_0 playsoundtoplayer("mp_grind_token_banked", var_0);
    var_2 = level._id_21D9;

    if(var_2 > var_0._id_ED74) {
      var_2 = var_0._id_ED74;
    }

    _id_CBF4(var_0, var_2);

    for(var_3 = 0; var_3 < var_2; var_3++) {
      var_0 thread _id_0A9F::_id_7003("tag_score");
    }

    if(isDefined(level._id_EB99) && level._id_EB99 && isDefined(var_0._id_3E59) && var_0._id_3E59) {
      var_0 _id_07C1::_id_D4EE("kill");
    }

    wait(level._id_21DC);
  }

  var_1 scripts\mp\gametypes\obj_grindzone::_id_D608();
  var_0._id_8A17 = 0;
}

_id_CBF4(var_0, var_1) {
  var_0 _id_B7A5(var_0._id_ED74 - var_1);
  scripts\mp\gamescore::_id_7001(var_0.team, var_1, 0);
}

_id_8294() {
  _id_0817::_id_D461("BigTDM", "Crit_Frontline");
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_allies_start");
  _id_0817::_id_1136("axis", "mp_tdm_spawn_axis_start");
  _id_0817::_id_C2B9("normal_allies", "mp_tdm_spawn_allies_start");
  _id_0817::_id_C2B9("normal_axis", "mp_tdm_spawn_axis_start");
  _id_0817::_id_C2B9("fallback", "mp_tdm_spawn_secondary");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  }

  if(_id_0817::_id_DC06()) {
    var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_" + var_0 + "_start");
    var_2 = _id_0817::_id_6D4D(var_1);
  } else if(var_0 == "allies")
    var_2 = _id_0817::_id_6D4A(self, var_0, "normal_allies", "fallback");
  else {
    var_2 = _id_0817::_id_6D4A(self, var_0, "normal_axis", "fallback");
  }

  return var_2;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(istrue(level._id_5CD3)) {
    _id_07D2::_id_5CC9(var_1, var_0, gettime(), "kill_by_" + var_1.team);
  }

  var_0 scripts\mp\gametypes\plunder::_id_B7A5(var_0._id_ED74 + 1000);
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_5067(var_0, var_1) {
  if(isagent(var_0)) {
    return;
  }
  if(var_0._id_ED74 > 9) {
    var_2 = 10;
  } else if(var_0._id_ED74 > 0) {
    var_2 = var_0._id_ED74;
  } else {
    var_2 = 0;
  }

  for(var_3 = 0; var_3 < var_2; var_3++) {
    var_4 = _id_E38B(var_0.origin, var_0.team);
    var_4.team = var_0.team;
    var_4._id_103C2 = var_0;
    var_4.attacker = var_1;
    level notify("new_tag_spawned", var_4);
    level thread _id_A148(var_4);
  }

  var_5 = var_0._id_ED74 - var_2;
  var_5 = int(max(0, var_5));
  var_0 _id_B7A5(var_5);
}

_id_4CE2(var_0) {}

_id_C50D() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("#x3806a10bc0145262", "") != "") {
      var_0 = getDvar("#x3806a10bc0145262", "");

      foreach(var_2 in level._id_A8E8) {
        if(isDefined(var_2._id_A8E1) && var_2._id_A8E1 == var_0) {
          var_2 notify("stop_trigger" + var_2._id_A8E1);
          var_2 _id_07D6::_id_15DF("none");
          var_2.trigger = undefined;
          var_2 notify("deleted");
          var_2._id_1041A = "none";
          var_2 _id_07D6::_id_D61B(undefined, undefined);
          var_3 = [];

          foreach(var_5 in level._id_A8E8) {
            if(var_5._id_A8E1 != var_0) {
              var_3[var_5._id_A8E1] = var_5;
            }
          }

          level._id_A8E8 = var_3;
          break;
        }
      }

      setdynamicdvar("#x3806a10bc0145262", "");
    }

    wait 1;
  }
}

_id_B17A() {
  self endon("game_ended");

  for(;;) {
    if(getDvar("#x3dfcdef2d7e684127", "") != "") {
      var_0 = getDvar("#x3dfcdef2d7e684127", "");
      var_1 = undefined;
      var_2 = getEntArray("grind_location", "targetname");

      foreach(var_4 in var_2) {
        if("_" + var_4._id_CD99 == var_0) {
          var_1 = var_4;
        }
      }

      var_1.origin = level.players[0].origin;
      var_1._id_ADAE = "neutral";
      var_6 = var_1.origin + (0, 0, 32);
      var_7 = var_1.origin + (0, 0, -32);
      var_8 = scripts\engine\trace::ray_trace(var_6, var_7, undefined, scripts\engine\trace::_id_3EF6(1));
      var_1.origin = var_8["position"];
      var_1._id_FB2F = vectortoangles(var_8["normal"]);
      var_1._id_01D7 = anglesToForward(var_1._id_FB2F);
      var_1._id_0376 = anglestoright(var_1._id_FB2F);
      var_9[0] = spawn("script_model", var_1.origin);
      var_9[0].angles = var_1.angles;
      var_10 = spawn("trigger_radius", var_1.origin, 0, 90, 128);
      var_10._id_CD99 = var_1._id_CD99;
      var_1 = var_10;
      var_11 = _id_07D6::_id_406E("neutral", var_1, var_9, (0, 0, 100));

      if(isDefined(var_1._id_A8E1)) {
        var_11._id_A8E1 = var_1._id_A8E1;
      } else {
        var_11._id_A8E1 = var_11 _id_07D6::_id_6AF1();
      }

      if(isDefined(var_1._id_7C73)) {
        var_11._id_7C73 = var_1._id_7C73;
      } else {
        var_11._id_7C73 = var_11 _id_07D6::_id_6AF1();
      }

      var_11 thread _id_CA7E();
      var_11 _id_07D6::_id_15DF("enemy");
      var_11 _id_07D6::_id_D8D2(level._id_21CD);
      var_11 _id_07D6::_id_D61B("waypoint_defend", "waypoint_captureneutral");
      var_11 _id_07D6::_id_D8E0("any");
      var_11 _id_07D6::_id_316A(1);
      var_11._id_ABCB = scripts\mp\gametypes\obj_grindzone::_id_110D8;
      var_11._id_AA79 = scripts\mp\gametypes\obj_grindzone::_id_110D9;
      var_11._id_ABC8 = scripts\mp\gametypes\obj_grindzone::_id_110D6;
      var_11._id_AA8D = scripts\mp\gametypes\obj_grindzone::_id_110D2;
      var_11._id_ABC7 = scripts\mp\gametypes\obj_grindzone::_id_110D5;
      var_11._id_37F3 = level._id_21CD * 1000;
      var_6 = var_11._id_10430[0].origin + (0, 0, 32);
      var_7 = var_11._id_10430[0].origin + (0, 0, -32);
      var_12 = scripts\engine\trace::_id_3EE5(1, 1, 1, 1, 0, 1, 1);
      var_13 = [];
      var_8 = scripts\engine\trace::ray_trace(var_6, var_7, var_13, var_12);
      var_11._id_22B7 = var_8["position"];
      var_14 = vectortoangles(var_8["normal"]);
      var_14 = -1 * var_14;
      var_11._id_22B6 = anglesToForward(var_14);
      var_11 scripts\mp\gametypes\obj_grindzone::_id_D607();
      level._id_A8E8[var_11._id_A8E1] = var_11;
      setdynamicdvar("#x3dfcdef2d7e684127", "");
    }

    wait 1;
  }
}

_id_E31F() {
  scripts\cp_mp\killstreaks\airdrop::_id_8272();
  var_0 = scripts\engine\utility::getStructArray("pillage_cache_spawn", "targetname");
  var_1 = int(100 * var_0.size / 100);
  var_0 = scripts\engine\utility::array_randomize(var_0);
  level._id_414D = [];

  for(var_2 = 0; var_2 < var_1; var_2++) {
    _id_E31E(var_0[var_2]);
  }
}

_id_E31E(var_0) {
  var_1 = scripts\mp\gametypes\br_pickups::_id_E336("Pillage_Cache", var_0.origin + level._id_2A95._id_2A3A[0], (0, 0, 0));
}

_id_6FFD() {
  scripts\mp\gametypes\plunder::_id_B7A5(self._id_ED74 + 1000);
}

_id_21DB() {
  self endon("game_ended");
  var_0 = getEntArray("grind_location", "targetname");
  wait 5;
  var_1 = [];
  var_2 = [];

  for(;;) {
    var_0 = scripts\engine\utility::array_randomize(var_0);
    var_3 = 0;
    var_4 = 0;

    while(var_3 < 1) {
      foreach(var_4, var_6 in var_0) {
        if(var_3 == 1) {
          break;
        }

        if((!isDefined(var_6._id_84EF) || !var_6._id_84EF) && (!isDefined(var_6._id_FE4E) || !var_6._id_FE4E)) {
          var_7 = scripts\mp\gametypes\obj_grindzone::_id_D896(var_0[var_4]);
          var_7 _id_07D6::_id_15DF("any");
          var_7 _id_07D6::_id_D8E0("any");
          _id_07F9::_id_A8B1(var_7._id_A908, 0);
          var_7._id_970A = 0;
          var_7 _id_07D6::_id_D61B("icon_waypoint_generic");
          var_7._id_970A = 1;
          _func_0167(var_7._id_A908, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          _func_016A(var_7._id_A908, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          _func_0168(var_7._id_A908, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          _func_0169(var_7._id_A908, &"MP_INGAME_ONLY/PILLAGE_DEPOT_OPEN");
          var_7 thread _id_CA7E();
          var_1[var_4] = var_7;
          var_7._id_E071 = var_6;
          var_6._id_84EF = 1;
          var_3++;
        }
      }

      if(var_3 < 1) {
        foreach(var_6 in var_0) {
          var_6._id_FE4E = 0;
        }
      }
    }

    wait 5;

    foreach(var_6 in var_1) {
      var_6 _id_07D6::_id_15DF("none");
      var_6 _id_07D6::_id_D8E0("none");
      var_6 _id_07D6::_id_C300();
      var_6._id_1041A = "none";
      var_6._id_03A9 delete();
      var_6._id_E071._id_FE4E = 1;
      var_6._id_E071._id_84EF = 0;
    }

    var_1 = [];
    wait 5;
  }
}