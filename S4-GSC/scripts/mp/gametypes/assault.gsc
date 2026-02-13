/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\assault.gsc
*************************************************/

main() {
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_0[0] = ::scripts\mp\utility\game::getgametype();
  var_0[1] = "sd";
  var_0[2] = "bombzone";
  var_0[3] = "blocker";
  _id_07D6::main(var_0);

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 3.0);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  var_1 = scripts\mp\utility\dvars::getwatcheddvar("timelimit");
  scripts\mp\utility\dvars::_id_C2CB("addObjectiveTime", var_1);
  _id_FC7D();
  level._id_A8D4 = 1;
  level.teambased = 1;
  level._id_A543 = 1;
  level._id_AB7F = ::_id_AB7F;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_9FE8 = ::_id_ABA4;
  level._id_AB70 = ::_id_AB70;
  level._id_ABC0 = ::_id_ABC0;
  level._id_AB3F = ::_id_AB3F;
  level._id_AB42 = ::_id_AB42;
  level._id_C650 = scripts\mp\gametypes\obj_bombzone::_id_C650;
  level._id_15BE = 0;
  game["dialog"]["offense_obj"] = "obj_destroy";
  game["dialog"]["defense_obj"] = "obj_defend";
  game["dialog"]["lead_lost"] = "null";
  game["dialog"]["lead_tied"] = "null";
  game["dialog"]["lead_taken"] = "null";
  game["dialog"]["lost_a"] = "lost_a";
  game["dialog"]["lost_b"] = "lost_b";
  game["dialog"]["lost_c"] = "lost_c";
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  var_0 = getmatchrulesdata("assaultData", "roundLength");
  setdynamicdvar("#x39795afb33bc7b2db", var_0);
  scripts\mp\utility\game::_id_C2C1("assault", var_0);
  var_1 = getmatchrulesdata("assaultData", "roundSwitch");
  setdynamicdvar("#x31e90c4c6daba00bf", var_1);
  scripts\mp\utility\game::_id_C2AA("assault", var_1, 0, 9);
  var_2 = getmatchrulesdata("commonOption", "scoreLimit");
  setdynamicdvar("#x3e19395f01fa46a7c", var_2);
  scripts\mp\utility\game::_id_C2D0("assault", var_2);
  setdynamicdvar("#x3b3d6763fe518220a", getmatchrulesdata("assaultData", "bombTimer"));
  setdynamicdvar("#x333ed1b019c6eb1d7", getmatchrulesdata("assaultData", "plantTime"));
  setdynamicdvar("#x3bbe868680cbb96f2", getmatchrulesdata("assaultData", "defuseTime"));
  setdynamicdvar("#x366d0e2713491f10a", getmatchrulesdata("assaultData", "multiBomb"));
  setdynamicdvar("#x36f2a496824981a89", getmatchrulesdata("assaultData", "bombResetTimer"));
  setdynamicdvar("#x39b28661eef0f10ea", 0);
  scripts\mp\utility\game::_id_C2A9("assault", 0);
  setdynamicdvar("#x31e04080b896dbe08", 1);
  scripts\mp\utility\game::_id_C2AD("assault", 1);
  setdynamicdvar("#x32f814b574af436f9", 0);
  scripts\mp\utility\game::_id_C25D("assault", 0);
}

_id_AB7F() {
  game["bomb_dropped_sound"] = "mp_war_objective_lost";
  game["bomb_recovered_sound"] = "mp_war_objective_taken";
}

_id_ABAD() {
  if(!isDefined(game["switchedsides"])) {
    game["switchedsides"] = 0;
  }

  if(game["switchedsides"]) {
    var_0 = game["attackers"];
    var_1 = game["defenders"];
    game["attackers"] = var_1;
    game["defenders"] = var_0;
  }

  setclientnamemode("manual_change");
  level._effect["bomb_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  level._effect["vehicle_explosion"] = loadfx("vfx/core/expl/small_vehicle_explosion_new.vfx");
  level._effect["building_explosion"] = loadfx("vfx/iw7/_requests/mp/vfx_debug_warning.vfx");
  scripts\mp\utility\game::_id_D61C(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
  scripts\mp\utility\game::_id_D61C(game["defenders"], &"OBJECTIVES/SD_DEFENDER");

  if(level.splitscreen) {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES/SD_ATTACKER");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES/SD_DEFENDER");
  } else {
    scripts\mp\utility\game::_id_D61A(game["attackers"], &"OBJECTIVES/SD_ATTACKER_SCORE");
    scripts\mp\utility\game::_id_D61A(game["defenders"], &"OBJECTIVES/SD_DEFENDER_SCORE");
  }

  scripts\mp\utility\game::_id_D615(game["attackers"], &"OBJECTIVES/SD_ATTACKER_HINT");
  scripts\mp\utility\game::_id_D615(game["defenders"], &"OBJECTIVES/SD_DEFENDER_HINT");
  _id_8294();
  _id_D6E0();
  thread _id_81E7();
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_113A("mp_assault_spawn_attacker_start");
  _id_0817::_id_113A("mp_assault_spawn_defender_start");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  level._id_1CE8 = [];
  _id_8151("attacker");
  _id_8151("defender");
  _id_0817::_id_0EE5();
}

_id_8151(var_0) {
  level._id_1CE8[var_0] = [];
  var_1 = "mp_assault_spawn_" + var_0;
  var_2 = _id_0817::_id_6D4E(var_1);

  foreach(var_4 in var_2) {
    var_5 = var_4._id_039B;

    if(!isDefined(level._id_1CE8[var_0][var_5])) {
      level._id_1CE8[var_0][var_5] = [];
    }

    level._id_1CE8[var_0][var_5][level._id_1CE8[var_0][var_5].size] = var_4;
  }
}

_id_6D4A() {
  var_0 = self.pers["team"];
  var_1 = "defender";

  if(var_0 == game["attackers"]) {
    var_1 = "attacker";
  }

  if(level._id_7EB0) {
    var_2 = _id_0817::_id_6D4E("mp_assault_spawn_" + var_1 + "_start");
    var_3 = _id_0817::_id_6D4D(var_2);
  } else {
    var_4 = level._id_413D.label;
    var_5 = level._id_1CE8[var_1][var_4];
    var_3 = _id_0817::_id_6D4C(var_5);
  }

  return var_3;
}

_id_ABA4() {
  if(scripts\mp\utility\entity::_id_8877(self)) {
    self._id_8986 = 0;
    self._id_87F7 = 0;
    self._id_8783 = 0;
  }

  if(level._id_A2F7 && self.pers["team"] == game["attackers"]) {
    self setclientomnvar("ui_carrying_bomb", 1);
  } else {
    self setclientomnvar("ui_carrying_bomb", 0);
  }

  scripts\mp\utility\stats::_id_D550(0);

  if(isDefined(self.pers["plants"])) {
    scripts\mp\utility\stats::_id_D550(self.pers["plants"]);
  }

  level notify("spawned_player");
  _id_D89F();
  var_0 = getdvarint("#x3b4fe4f4759a93ccf");
  self _meth_8468(var_0);
  self _meth_8468(var_0);
  self _meth_8469(var_0);
}

_id_AB70(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  self setclientomnvar("ui_carrying_bomb", 0);
  thread _id_34DE();
}

_id_34DE() {
  waitframe();
  var_0 = 0;

  if(!scripts\mp\utility\teams::_id_6DCA(game["attackers"], "aliveCount")) {
    level._id_E3E2[game["attackers"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(!scripts\mp\utility\teams::_id_6DCA(game["defenders"], "aliveCount")) {
    level._id_E3E2[game["defenders"]]._id_15B5 = 1;
    var_0 = 1;
  }

  if(var_0) {
    _id_081A::_id_FD35();
  }
}

_id_CF9E(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isai(var_3)) {
      var_3 setclientomnvar("ui_objective_state", 0);
    }
  }

  level._id_5AA3 = var_0;

  if(var_1 == game["end_reason"]["target_destroyed"] || var_1 == game["end_reason"]["bomb_defused"]) {
    if(!isDefined(level._id_5AA2[var_0]) || level._id_5AA2[var_0] != level._id_413D._id_8D65) {
      _id_07D0::_id_5597();
    }
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0, var_1);
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = scripts\mp\rank::getscoreinfovalue("kill");
  var_7 = var_0.team;

  if(var_0._id_8986) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  } else if(var_0._id_87F7) {
    var_1 scripts\mp\utility\stats::_id_7DAE("defends", 1);
    var_1 scripts\mp\persistence::_id_E770("round", "defends", var_1.pers["defends"]);
  }
}

_id_ABC0() {
  _id_CF9E(game["defenders"], game["end_reason"]["time_limit_reached"]);

  foreach(var_1 in level.players) {
    if(isDefined(var_1._id_2668)) {
      var_1 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_1._id_2668);
      break;
    }
  }
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_B1DA = scripts\mp\utility\dvars::_id_509A("planttime", 5, 0, 20);
  level._id_4644 = scripts\mp\utility\dvars::_id_509A("defusetime", 5, 0, 20);
  level._id_2682 = scripts\mp\utility\dvars::_id_509A("bombtimer", 45, 1, 300);
  level._id_A2F7 = scripts\mp\utility\dvars::_id_509C("multibomb", 0, 0, 1);
  level._id_2677 = scripts\mp\utility\dvars::_id_509C("bombResetTimer", 60, 0, 180);
}

_id_D6E0() {
  if(_func_0127() && scripts\mp\utility\game::_id_6B32("defaultClasses", game["attackers"], 5, "class", "inUse")) {
    level._id_CF9F[game["attackers"]] = ::scripts\mp\utility\game::_id_6B33(game["attackers"], 5);
  }
}

_id_899B(var_0) {
  if(isDefined(level._id_4136)) {
    return self istouching(level._id_4136.trigger);
  }

  return 0;
}

_id_81E7() {
  level._id_5BE1 = 1;
  var_0 = getEntArray("bombzone", "targetname");
  level._id_A8E8 = var_0;
  level._id_413E = 0;
  level._id_413D = _id_D894(level._id_413E);
}

_id_D894(var_0) {
  var_1 = level._id_A8E8[var_0];
  var_2 = var_1._id_039B;

  if(!isDefined(var_2)) {
    var_2 = "bombzone";
  }

  var_3 = undefined;

  switch (var_2) {
    case "bombzone":
      if(isDefined(level._id_5BE1)) {
        scripts\mp\gametypes\obj_bombzone::_id_2694("sd_bomb");
        level._id_5BE1 = undefined;
      } else
        scripts\mp\gametypes\obj_bombzone::_id_11D5();

      var_3 = scripts\mp\gametypes\obj_bombzone::_id_D896(var_0);
      _id_0A8D::_id_9136("offense_obj", game["attackers"]);
      _id_0A8D::_id_9136("defense_obj", game["defenders"]);
      break;
    case "dompoint":
      var_3 = scripts\mp\gametypes\obj_dom::_id_D896(level._id_A8E8[var_0]);
      break;
    case "payload":
      break;
    case "ctf":
      break;
  }

  return var_3;
}

_id_AB42(var_0, var_1, var_2, var_3, var_4) {
  switch (var_0) {
    case "dompoint":
      _id_AAB8(var_1, var_2, var_3, var_4);
      break;
    case "bombzone":
      _id_AA7C(var_1, var_2, var_3, var_4);
      break;
  }

  if(var_3 == game["attackers"]) {
    level._id_413E++;

    if(level._id_413E < level._id_A8E8.size) {
      var_5 = scripts\mp\utility\dvars::getwatcheddvar("addObjectiveTime");
      scripts\mp\utility\dvars::_id_D633("timelimit", scripts\mp\utility\game::_id_6DE5() + var_5);
      _id_C6E3();
      level._id_413D = _id_D894(level._id_413E);
    } else {
      setgameendtime(0);
      wait 3;
      _id_CF9E(game["attackers"], game["end_reason"]["target_destroyed"]);
    }
  }
}

_id_AAB8(var_0, var_1, var_2, var_3) {
  var_4 = var_1.team;

  if(var_3 == "neutral") {
    var_5 = scripts\mp\utility\game::_id_6BE2(var_4)[0];
    thread scripts\mp\utility\print::_id_BD0C(var_4, var_5, undefined, undefined, "mp_dom_flag_captured", undefined, var_1);
    _id_0A8D::_id_E775("secured" + self.label, var_4, 1);
    _id_0A8D::_id_E775("lost_" + self.label, var_5, 1);
  }
}

_id_AA7C(var_0, var_1, var_2, var_3) {
  if(var_2 == game["defenders"]) {
    _id_C6E3();
    thread scripts\mp\gametypes\obj_bombzone::_id_C68E();
    level._id_413D = scripts\mp\gametypes\obj_bombzone::_id_D896(level._id_413E);
  }
}

_id_C6E3() {
  scripts\mp\gamelogic::resumetimer();
  level._id_F23C = gettime() - level._id_F23D;
  level._id_F21A = 0;
}

_id_D89F() {
  if(isai(self)) {
    return;
  }
  self notifyonplayercommand("playerPing", "+breath_sprint");
  thread _id_1081C();
}

_id_1081C() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("playerPing");

    if(scripts\mp\utility\player::isreallyalive(self) && !scripts\mp\utility\player::_id_8ACE()) {
      if(self adsbuttonpressed()) {
        _id_4E64();
        wait 0.5;
      }
    }

    wait 0.1;
  }
}

_id_4E64() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = self getEye();
  var_1 = var_0 + anglesToForward(self getplayerangles()) * 2000;
  var_2 = scripts\engine\trace::ray_trace(var_0, var_1, self);
  var_3 = var_2["entity"];
  var_4 = "WAYPOINT";
  var_5 = (1, 1, 1);

  if(isDefined(var_3)) {
    if(isDefined(var_3.team) && var_3.team != self.team) {
      var_5 = (1, 0, 0);

      if(isPlayer(var_3)) {
        var_4 = "KILL";
        self notify("enemy_sighted");
      } else
        var_4 = "DESTROY";
    } else if(isDefined(var_3._id_CD69)) {
      if(var_3._id_CD69 == "bombzone") {
        if(self.team == game["attackers"]) {
          var_4 = "ATTACK";
          var_5 = (1, 1, 0);
        } else {
          var_4 = "DEFEND";
          var_5 = (0, 0, 1);
        }
      } else if(var_3._id_CD69 == "sd") {
        if(self.team == game["attackers"]) {
          var_4 = "OBJECTIVE";
          var_5 = (1, 1, 0);
        }
      }
    }
  }
}