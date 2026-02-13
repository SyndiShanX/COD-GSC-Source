/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\tjugg.gsc
*************************************************/

main() {
  if(getDvar("#x376847958d67972ef") == "mp_background") {
    return;
  }
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2C1(level.gametype, 10);
    scripts\mp\utility\game::_id_C2A9(level.gametype, 1);
    scripts\mp\utility\game::_id_C2AD(level.gametype, 150);
    scripts\mp\utility\game::_id_C2D0(level.gametype, 1);
    scripts\mp\utility\game::_id_C27E(level.gametype, 0);
    scripts\mp\utility\game::_id_C25D(level.gametype, 0);
    level._id_8C8E = 90;
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_4E69 = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB70 = ::_id_AB70;
  game["dialog"]["gametype"] = "gametype_tjugg";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_tjugg";
  game["dialog"]["offense_obj"] = "boost_tjugg";
  game["dialog"]["defense_obj"] = "boost_tjugg";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3530bfb44da3cbecc", getmatchrulesdata("tjuggData", "juggHealth"));
  setdynamicdvar("#x3b54bfcf1001a96af", getmatchrulesdata("tjuggData", "juggSwitchTime"));
  setdynamicdvar("#x3818a4300c39650b9", getmatchrulesdata("tjuggData", "ppkAsJugg"));
  setdynamicdvar("#x358d5b13d3f79c288", getmatchrulesdata("tjuggData", "ppkOnJugg"));
  setdynamicdvar("#x3d4362a97a9b6315f", getmatchrulesdata("tjuggData", "ppkJuggOnJugg"));
  setdynamicdvar("#x3c9b57cb44fba2b1b", 0);
  scripts\mp\utility\game::_id_C2AA("tjugg", 0, 0, 9);
  setdynamicdvar("#x3fda3e010c9e2a176", 1);
  scripts\mp\utility\game::_id_C2A9("tjugg", 1);
  setdynamicdvar("#x35c3fa5dce8ef2b18", 1);
  scripts\mp\utility\game::_id_C2D0("tjugg", 1);
  setdynamicdvar("#x3b7697371e82cebb5", 0);
  scripts\mp\utility\game::_id_C25D("tjugg", 0);
  setdynamicdvar("#x3e270c87d3032b9a3", 0);
  setdynamicdvar("#x37de759abe96789b7", 0);
  setdynamicdvar("#x388d06624940c1a88", 1);
  setdynamicdvar("#x3ee6d1b6a4d407071", 0);
  setdynamicdvar("#x38ad93cf3ff34555b", 0);
}

_id_ABAD() {
  setclientnamemode("auto_change");

  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  scripts\mp\utility\game::_id_D61C("allies", &"OBJECTIVES/TJUGG");
  scripts\mp\utility\game::_id_D61C("axis", &"OBJECTIVES/TJUGG");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/TJUGG");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/TJUGG");
  } else {
    scripts\mp\utility\game::_id_D61A("allies", &"OBJECTIVES/TJUGG_SCORE");
    scripts\mp\utility\game::_id_D61A("axis", &"OBJECTIVES/TJUGG_SCORE");
  }

  scripts\mp\utility\game::_id_D615("allies", &"OBJECTIVES/TJUGG_HINT");
  scripts\mp\utility\game::_id_D615("axis", &"OBJECTIVES/TJUGG_HINT");
  _id_8294();
  scripts\mp\playeractions::_id_C23B("tjugg", ["usability", "killstreaks", "supers"]);
  level._id_C6C2 = loadfx("vfx/core/expl/bouncing_betty_explosion");
  level._id_8BE5 = [];
  level._id_8BE5["axis"] = 1;
  level._id_8BE5["allies"] = 1;
  level._id_8BE4 = [];
  level._id_8BE4["axis"] = [];
  level._id_8BE4["allies"] = [];
  level._id_8BEE = [];
  level._id_8BEE["axis"] = undefined;
  level._id_8BEE["allies"] = undefined;
  level._id_F29B = [];
  level._id_F29B["allies"] = ::scripts\mp\hud_util::_id_404A("objective", 1.4, "allies");
  level._id_F29B["allies"] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 55, 150);
  level._id_F29B["allies"].label = &"MP_JUGG_NEXT_JUGG_IN";
  level._id_F29B["allies"].alpha = 0;
  level._id_F29B["allies"].archived = 0;
  level._id_F29B["allies"].hidewheninmenu = 1;
  level._id_F29B["axis"] = ::scripts\mp\hud_util::_id_404A("objective", 1.4, "axis");
  level._id_F29B["axis"] scripts\mp\hud_util::setpoint("TOPLEFT", "TOPLEFT", 55, 150);
  level._id_F29B["axis"].label = &"MP_JUGG_NEXT_JUGG_IN";
  level._id_F29B["axis"].alpha = 0;
  level._id_F29B["axis"].archived = 0;
  level._id_F29B["axis"].hidewheninmenu = 1;
  thread _id_7919(level._id_F29B["allies"]);
  thread _id_7919(level._id_F29B["axis"]);
  level._id_59EC = 5;
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_8C86 = scripts\mp\utility\dvars::_id_509C("juggHealth", 1000, 1000, 10000);
  level._id_8C8E = scripts\mp\utility\dvars::_id_509A("juggSwitchTime", 60, 10, 180);
  level._id_BB29 = scripts\mp\utility\dvars::_id_509C("ppkAsJugg", 2, 1, 100);
  level._id_BB2B = scripts\mp\utility\dvars::_id_509C("ppkOnJugg", 5, 1, 100);
  level._id_BB2A = scripts\mp\utility\dvars::_id_509C("ppkJuggOnJugg", 10, 1, 100);
}

onplayerconnect(var_0) {
  var_0._id_7543 = 0;
  var_0._id_8BDF = 0;
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_D461("Default", "Crit_Frontline");
  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_C2B9("normal", "mp_tdm_spawn");
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
  } else
    var_2 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");

  return var_2;
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_3 == "MOD_SUICIDE" && var_4.basename == "none" && isDefined(self._id_10A21)) {
    return;
  }
  var_10 = self;

  if(isDefined(var_10._id_88E5)) {
    if(isDefined(var_10._id_8C89)) {
      var_10._id_8C89 destroy();
    }

    var_10._id_B7E4 = undefined;
    var_10._id_A5DF = 0;
    var_10 scripts\mp\utility\player::_id_0CF0("iw8_defaultsuit_mp");
    _id_3895(var_10);
  }

  if(isDefined(var_1) && isPlayer(var_1)) {
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;
    var_15 = 0;
    var_16 = 0;
    var_17 = 0;

    if(var_1 == var_10) {
      if(isDefined(var_10._id_88E5)) {
        var_12 = 1;
      }
    } else if(var_1.team != var_10.team) {
      if(isDefined(var_10._id_88E5)) {
        var_12 = 1;

        if(isDefined(var_1._id_88E5)) {
          var_13 = 1;
        } else {
          var_14 = 1;
        }
      } else if(isDefined(var_1._id_88E5))
        var_15 = 1;

      if(level._id_8BE5[var_1.team]) {
        var_11 = 1;
      }
    } else if(isDefined(var_10._id_88E5) && var_1.team == var_10.team) {
      var_10 thread _id_6FA9();
      return;
    }

    if(var_11) {
      _id_C61B(var_1);
    }

    if(var_12) {
      var_18 = _id_691D(var_10.team, 0);

      if(!isDefined(var_18)) {
        var_18 = _id_691D(var_10.team, 1);
      }

      if(!isDefined(var_18)) {
        var_18 = var_10;
      }

      _id_C61B(var_18, var_10);
    }

    if(var_11 || var_12) {
      _id_0AA2::_id_B8F1("mp_enemy_obj_captured");
    }

    if(var_1 != var_10 && var_1.team != var_10.team && !isDefined(var_1._id_88E5)) {
      if(var_1._id_7543) {
        var_1._id_8BDF = var_1._id_8BDF + 25;

        if(var_14) {
          var_1._id_8BDF = var_1._id_8BDF + 75;
        }

        if(isDefined(level._id_8BE4[var_1.team][var_10.guid])) {
          var_16 = 1;
          var_1._id_8BDF = var_1._id_8BDF + 50;
          level._id_8BE4[var_1.team][var_10.guid] = undefined;
        }
      } else {
        var_1._id_8BDF = var_1._id_8BDF + 50;

        if(var_14) {
          var_1._id_8BDF = var_1._id_8BDF + 100;
        }

        if(isDefined(level._id_8BE4[var_1.team][var_10.guid])) {
          var_16 = 1;
          var_1._id_8BDF = var_1._id_8BDF + 100;
          level._id_8BE4[var_1.team][var_10.guid] = undefined;
        }
      }
    }

    if(var_14) {
      var_1 thread _id_0A9F::_id_7003("kill_juggernaut");
      var_17 = level._id_BB2B;
    } else if(var_13) {
      var_1 thread _id_0A9F::_id_7003("jugg_on_jugg");
      var_17 = level._id_BB2A;
    } else if(var_15) {
      var_1 thread _id_0A9F::_id_7003("kill_as_juggernaut");
      var_17 = level._id_BB29;
    }

    if(var_17) {
      var_1 scripts\mp\gamescore::_id_7001(var_1.pers["team"], var_17);
    }

    if(var_1.team != var_10.team && game["state"] == "postgame" && game["teamScores"][var_1.team] > game["teamScores"][level._id_AC9D[var_1.team]]) {
      var_1._id_5AA1 = 1;
      return;
    }
  } else if(isDefined(var_10._id_88E5)) {
    var_18 = _id_691D(var_10.team, 0);

    if(!isDefined(var_18)) {
      var_18 = _id_691D(var_10.team, 1);
    }

    if(!isDefined(var_18)) {
      var_18 = var_10;
    }

    _id_C61B(var_18, var_10);
  }
}

_id_C61B(var_0, var_1) {
  if(isDefined(var_1)) {
    var_1 notify("lost_juggernaut");
    var_1._id_88E5 = undefined;
  } else
    level._id_8BE5[var_0.team] = 0;

  level._id_8BEE[var_0.team] = undefined;
  level._id_F29B[var_0.team].alpha = 0;
  level._id_8BE4[var_0.team] = [];

  foreach(var_3 in level.players) {
    if(var_3.team == var_0.team) {
      var_3._id_8BDF = 0;
    }
  }

  var_0 thread _id_6FA9();
}

_id_6FA9() {
  if(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::_id_8ACE()) {
    self endon("disconnect");
    thread _id_C61D(0);

    while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::_id_8ACE()) {
      waitframe();
    }

    self notify("end_resetJuggLoadoutOnDisconnect");
  }

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  while(self _meth_81CE()) {
    waitframe();
  }

  while(!self isonground()) {
    waitframe();
  }

  if(istrue(self._id_88E5)) {
    self notify("lost_juggernaut");
    waitframe();
  }

  self._id_88E5 = 1;
  level._id_8BEE[self.team] = self;
  self._id_7543 = 1;
  _id_0A18::_id_E346(self.origin, self.angles);
  self notify("faux_spawn");
  self._id_59DF = self getstance();
  thread scripts\mp\playerlogic::_id_E337(1);
  _id_4004(self);
  thread _id_FC99();
  self._id_88DF = 1;
  self.maxhealth = level._id_8C86;
  self.health = self.maxhealth;
  self._id_A5DF = 1;
  scripts\mp\class::_id_9621(1);
  scripts\mp\playeractions::_id_1596("tjugg", 0);
  var_0 = scripts\mp\class::buildweapon("s4_ar_stango44", ["holo"], "none", "none", -1);
  self giveweapon(var_0);
  scripts\cp_mp\utility\inventory_utility::_id_5ED6(var_0);
  var_0 = scripts\mp\class::buildweapon("s4_pi_mike1911", [], "none", "none", -1);
  self giveweapon(var_0);
  self givemaxammo(var_0);
  scripts\mp\utility\perk::_id_6FC2("specialty_stun_resistance");
  scripts\mp\utility\perk::_id_6FC2("specialty_sharp_focus");
  scripts\mp\utility\player::_id_0CF0("iw8_juggernaut_mp");
  self._id_B7E4 = -0.2;
  scripts\mp\weapons::_id_FCCC();
  scripts\mp\teams::_id_D5C3();
  self._id_8C89 = newclienthudelem(self);
  self._id_8C89.x = 0;
  self._id_8C89.y = 0;
  self._id_8C89.alignx = "left";
  self._id_8C89.aligny = "top";
  self._id_8C89.horzalign = "fullscreen";
  self._id_8C89.vertalign = "fullscreen";
  self._id_8C89 setshader("gasmask_overlay_delta", 640, 480);
  self._id_8C89.sort = -10;
  self._id_8C89.archived = 1;
  self._id_8C89.alpha = 1.0;
  self._id_5FB9 = scripts\mp\utility\outline::_id_ACD2(self, self.team, "outlinefill_nodepth_cyan", "killstreak");
  thread _id_C61D(1);
  thread _id_C61C();
  thread _id_C814();
  thread _id_9758();

  if(level._id_8C8E != 0) {
    thread _id_A4A9();
  }
}

_id_A4A9() {
  level endon("game_ended");
  self endon("death_or_disconnect");
  level._id_F29B[self.team].label = &"MP_JUGG_NEXT_JUGG_IN";
  level._id_F29B[self.team] _meth_8391(level._id_8C8E);
  level._id_F29B[self.team].alpha = 1;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(level._id_8C8E);
  level._id_F29B[self.team].alpha = 0;
  var_0 = _id_691D(self.team, 0);

  if(!isDefined(var_0)) {
    var_0 = _id_691D(self.team, 1);
  }

  if(!isDefined(var_0)) {
    var_0 = self;
  }

  _id_0AA2::_id_B8F1("mp_enemy_obj_captured");
  _id_C61B(var_0, self);

  if(var_0 != self) {
    thread _id_C6C1();
  }
}

_id_C6C1() {
  level endon("game_ended");
  self endon("disconnect");

  while(!scripts\mp\utility\player::isreallyalive(self) || scripts\mp\utility\player::_id_8ACE()) {
    waitframe();
  }

  if(isDefined(self._id_87A7) && self._id_87A7 == 1) {
    self notify("force_cancel_placement");
    waitframe();
  }

  _id_0A18::_id_E346(self.origin, self.angles);
  playFX(level._id_C6C2, self.origin);
  self notify("lost_juggernaut");
  waitframe();

  while(!self isonground()) {
    waitframe();
  }

  self notify("faux_spawn");

  if(isDefined(self._id_8C89)) {
    self._id_8C89 destroy();
  }

  self._id_59DF = self getstance();
  self._id_B7E4 = undefined;
  self._id_88DF = 0;
  self._id_A5DF = 0;
  scripts\mp\utility\outline::outlinedisable(self._id_5FB9, self);
  self.maxhealth = scripts\mp\tweakables::_id_6E14("player", "maxhealth");
  thread scripts\mp\playerlogic::_id_E337(1);
  scripts\mp\utility\player::_id_0CF0("iw8_defaultsuit_mp");
  scripts\mp\weapons::_id_FCCC();
  _id_3895(self);
}

_id_C814() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    wait 1.0;

    foreach(var_1 in level.players) {
      if(scripts\mp\utility\player::isreallyalive(var_1) && !var_1 scripts\mp\utility\player::_id_8ACE() && var_1 != self && var_1.team == self.team && distancesquared(var_1.origin, self.origin) < 48400) {
        if(var_1._id_7543) {
          var_1._id_8BDF = var_1._id_8BDF + 15;
          continue;
        }

        var_1._id_8BDF = var_1._id_8BDF + 25;
      }
    }
  }
}

_id_9758() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isPlayer(var_1) && var_1.team != self.team) {
      if(!isDefined(level._id_8BE4[self.team][var_1.guid])) {
        level._id_8BE4[self.team][var_1.guid] = 1;
      }
    }
  }
}

_id_C61D(var_0) {
  level endon("game_ended");

  if(var_0) {
    self endon("death");
  } else {
    self endon("end_resetJuggLoadoutOnDisconnect");
  }

  var_1 = self.team;
  self waittill("disconnect");
  var_2 = _id_691D(var_1, 0);

  if(!isDefined(var_2)) {
    var_2 = _id_691D(var_1, 1);
  }

  if(isDefined(var_2)) {
    _id_0AA2::_id_B8F1("mp_enemy_obj_captured");
    _id_C61B(var_2);
  } else {
    level._id_8BE5[var_1] = 1;
    level._id_8BEE[var_1] = undefined;
    level._id_F29B[var_1].alpha = 0;
    level._id_8BE4[var_1] = [];

    foreach(var_4 in level.players) {
      if(var_4.team == var_1) {
        var_4._id_8BDF = 0;
      }
    }
  }
}

_id_C61C() {
  level endon("game_ended");
  self endon("disconnect");
  var_0 = self.team;
  scripts\engine\utility::waittill_any_2("joined_team", "joined_spectators");
  self._id_88E5 = undefined;
  var_1 = _id_691D(var_0, 0);

  if(!isDefined(var_1)) {
    var_1 = _id_691D(var_0, 1);
  }

  if(isDefined(var_1)) {
    _id_0AA2::_id_B8F1("mp_enemy_obj_captured");
    _id_C61B(var_1);
  } else {
    level._id_8BE5[var_0] = 1;
    level._id_8BEE[var_0] = undefined;
    level._id_F29B[var_0].alpha = 0;
    level._id_8BE4[var_0] = [];

    foreach(var_3 in level.players) {
      if(var_3.team == var_0) {
        var_3._id_8BDF = 0;
      }
    }
  }
}

_id_691D(var_0, var_1) {
  var_2 = undefined;
  var_3 = -1;

  foreach(var_5 in level.players) {
    if((var_1 || !var_5 scripts\mp\utility\player::_id_8ACE()) && var_5 != self && var_5.team == var_0 && var_5._id_8BDF > var_3) {
      var_2 = var_5;
      var_3 = var_5._id_8BDF;
    }
  }

  return var_2;
}

_id_7919(var_0) {
  level waittill("game_ended");
  var_0.alpha = 0;
}

_id_4004(var_0) {
  var_1 = _id_07F9::_id_C57D(99);
  var_0._id_8C88 = var_1;
  var_0._id_A97E = (0, 0, 90);
  var_0._id_1041A = "any";
  var_0._id_ADAE = var_0.team;
  _id_07F9::_id_A867(var_1, "current", var_0.origin, "icon_minimap_juggernaut");
  _id_07F9::_id_A8B1(var_1, 0);
  _id_07F9::_id_A8B2(var_1, 0);
  _id_07F9::_id_A8A2(var_1);
  _id_07F9::_id_FB93(var_1, var_0);
  _id_07F9::_id_FB9D(var_1, var_0._id_A97E[2]);
  _func_0182(var_1, var_0.team);
  _func_0168(var_1, "MP_INGAME_ONLY/OBJ_DEFEND_CAPS");
  _func_0169(var_1, "MP_INGAME_ONLY/OBJ_KILL_CAPS");
}

_id_3895(var_0) {
  _id_07F9::_id_C799(var_0._id_8C88);
  var_0._id_8C88 = undefined;
}

_id_FC98() {
  self endon("death_or_disconnect");
  self endon("lost_juggernaut");

  for(;;) {
    self._id_4140 = self.origin + (0, 0, 90);
    waitframe();
  }
}

_id_FC99() {
  self endon("death_or_disconnect");
  self endon("lost_juggernaut");
  thread _id_FC98();

  if(!isDefined(self._id_A912)) {
    self._id_A912 = 4.0;
  }

  for(;;) {
    foreach(var_1 in level._id_EF89) {
      if(!_id_07D6::_id_886F(var_1)) {
        objective_setpingsforteam(self._id_8C88, var_1);
        _func_018F(self._id_8C88);
      }
    }

    scripts\engine\utility::_id_108AE(self._id_A912);
  }
}

_id_D6E1() {
  level._id_F29A["default"]["loadoutArchetype"] = "archetype_assault";
  level._id_F29A["default"]["loadoutPrimary"] = "s4_ar_stango44";
  level._id_F29A["default"]["loadoutPrimaryAttachment"] = "none";
  level._id_F29A["default"]["loadoutPrimaryAttachment2"] = "none";
  level._id_F29A["default"]["loadoutPrimaryCamo"] = "none";
  level._id_F29A["default"]["loadoutPrimaryReticle"] = "none";
  level._id_F29A["default"]["loadoutSecondary"] = "s4_la_m1bravo";
  level._id_F29A["default"]["loadoutSecondaryAttachment"] = "none";
  level._id_F29A["default"]["loadoutSecondaryAttachment2"] = "none";
  level._id_F29A["default"]["loadoutSecondaryCamo"] = "none";
  level._id_F29A["default"]["loadoutSecondaryReticle"] = "none";
  level._id_F29A["default"]["loadoutMeleeSlot"] = "s4_me_fists_mp_ls";
  level._id_F29A["default"]["loadoutEquipmentPrimary"] = "equip_frag";
  level._id_F29A["default"]["loadoutEquipmentSecondary"] = "equip_smoke";
  level._id_F29A["default"]["loadoutStreakType"] = "assault";
  level._id_F29A["default"]["loadoutKillstreak1"] = "none";
  level._id_F29A["default"]["loadoutKillstreak2"] = "none";
  level._id_F29A["default"]["loadoutKillstreak3"] = "none";
  level._id_F29A["default"]["loadoutSuper"] = "none";
  level._id_F29A["default"]["loadoutPerks"] = ["specialty_scavenger", "specialty_blastshield"];
  level._id_F29A["default"]["loadoutGesture"] = "playerData";
}