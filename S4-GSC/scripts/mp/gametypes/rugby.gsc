/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rugby.gsc
*************************************************/

main() {
  var_0 = spawnStruct();
  level._id_C98B = var_0;
  var_0._id_535E = [];
  var_0._id_535E["allies"] = [];
  var_0._id_535E["axis"] = [];
  var_0._id_8C30 = [];
  var_0._id_708D = [];
  var_0._id_0F49 = [];
  var_0._id_0F4A = [];
  var_0._id_8FF9 = [];
  _id_07DC::init();
  _id_07DC::_id_D854();
  var_1[0] = ::scripts\mp\utility\game::getgametype();
  _id_07D6::main(var_1);
  _id_827F();
  level.teambased = 1;
  level._id_A8D4 = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_ABC0 = ::_id_ABC0;
  game["dialog"]["gametype"] = "gametype_rugby";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_rugby";

  if(!isDefined(game["roundsPlayed"])) {
    var_2 = "boost_rugby";
  } else {
    var_2 = "boost_rugby_short";
  }

  game["dialog"]["offense_obj"] = var_2;
  game["dialog"]["defense_obj"] = var_2;
  level._effect["rugby_score_explosion"] = loadfx("vfx/iw8_mp/gamemode/vfx_search_bombsite_destroy.vfx");
}

_id_827F() {
  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 1, 0, 1);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 240);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 3);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  var_0 = getmatchrulesdata("rugbyData", "juggHealth");
  setdynamicdvar("#x35ce565b29b24520", var_0);
  var_1 = getmatchrulesdata("rugbyData", "juggSpeed");
  setdynamicdvar("#x3f83e46e25b26bcd", var_1);
  var_2 = getmatchrulesdata("rugbyData", "juggTeamSpeed");
  setdynamicdvar("#x331fcd6ee22c67a16", var_2);
  var_3 = getmatchrulesdata("rugbyData", "juggTimeout");
  setdynamicdvar("#x38aea31e33c2f72dd", var_3);
  var_4 = getmatchrulesdata("rugbyData", "juggTimeoutOn");
  setdynamicdvar("#x37f3d707218415bc8", var_4);
  var_5 = getmatchrulesdata("rugbyData", "helperMax");
  setdynamicdvar("#x33230ac1c02afa9bd", var_5);
}

_id_6AD2() {
  return getdvarint("#x35ce565b29b24520");
}

_id_6AD5(var_0) {
  var_1 = -0.3 + 0.1 * getdvarfloat("#x3f83e46e25b26bcd");
  var_0 = int(min(var_0, getdvarint("#x33230ac1c02afa9bd")));
  var_2 = 0.08 * getdvarfloat("#x331fcd6ee22c67a16");
  return var_1 + var_0 * var_2;
}

_id_6AD6() {
  return getdvarfloat("#x38aea31e33c2f72dd");
}

_id_6AD7() {
  return getdvarint("#x37f3d707218415bc8") != 0;
}

_id_ABAD() {
  setclientnamemode("auto_change");

  foreach(var_1 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_1, &"MP_MODE_RUGBY/INGAME_OBJECTIVE");
  }

  _id_827E();
  _id_D882();
  _id_8294();
  _id_824F();
  _id_8200();
}

_id_827E() {
  _id_818D();
  _id_8201();
}

_id_818D() {
  var_0 = level._id_C98B;
  var_1 = scripts\engine\utility::getStructArray("rugby_endzone", "targetname");

  foreach(var_3 in var_1) {
    _id_818C(var_3);
    var_0._id_535E[var_3.team][var_0._id_535E[var_3.team].size] = var_3;
  }
}

_id_818C(var_0) {
  var_1 = getEntArray(var_0.target, "targetname");
  var_0._id_10430 = [];
  var_0._id_10430["friendly"] = [];
  var_0._id_10430["enemy"] = [];

  foreach(var_3 in var_1) {
    if(var_3.classname == "trigger_multiple_mp_rugby_endzone") {
      var_0._id_1A4B = var_3;
    }

    if(isDefined(var_3._id_039B) && _func_00D6(var_3._id_039B, 0, 3) == "fx_") {
      var_4 = scripts\engine\utility::ter_op(var_3._id_039B == "fx_friendly", "friendly", "enemy");
      var_0._id_10430[var_4][var_0._id_10430[var_4].size] = var_3;
    }
  }

  if(var_0._id_03EA & 1) {
    var_0.team = "allies";
  } else if(var_0._id_03EA & 2) {
    var_0.team = "axis";
  } else {
    var_0.team = "allies";
  }
}

_id_8201() {
  var_0 = level._id_C98B;
  var_1 = scripts\engine\utility::getStructArray("rugby_jugg_crate", "targetname");

  foreach(var_3 in var_1) {
    var_0._id_8C30[var_0._id_8C30.size] = var_3;
  }
}

_id_824F() {
  level._id_E3EA = [];
  level._id_E3EA[0]["allies"] = spawnStruct();
  level._id_E3EA[0]["axis"] = spawnStruct();
  _id_0815::_id_D572("allies", level._id_E3EA[0]["allies"]);
  _id_0815::_id_D572("axis", level._id_E3EA[0]["axis"]);
  _id_FCE2("allies");
  _id_FCE2("axis");
  level._id_FC76 = ::_id_FCE2;
  level._id_E3EB = 1.25;
}

_id_8200() {
  var_0 = _id_07E6::_id_8BED();
  level._id_C98B._id_8C2A = var_0;
  var_1 = _id_6AD2();
  var_0.maxhealth = var_1;
  var_0._id_E6D3 = var_1;
  var_0._id_EAF7 = "iw8_juggernaut_mp_rugby";
  var_0._id_39FC = "vestheavy";
  var_0._id_15D1["crouch"] = 1;
  var_0._id_15D1["sprint"] = 1;
  var_0._id_15D1["weapon_switch"] = undefined;
  var_0._id_3808._id_9683 = "iw8_lm_dblmg";
}

_id_8294() {
  var_0 = level._id_C98B;
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_D461("Rugby", "Crit_Default");
  var_0._id_E724 = "mp_rugby_spawn";
  _id_0817::_id_113A(var_0._id_E724 + "_allies_start", 1, "allies");
  _id_0817::_id_113A(var_0._id_E724 + "_axis_start", 1, "axis");

  if(!isDefined(level._id_EFAF)) {
    var_0._id_E724 = "mp_tdm_spawn";
    _id_0817::_id_113A(var_0._id_E724 + "_allies_start", 1, "allies");
    _id_0817::_id_113A(var_0._id_E724 + "_axis_start", 1, "axis");
  }

  var_1 = _id_0817::_id_6D4E("mp_rugby_spawn_allies");
  var_2 = _id_0817::_id_6D4E("mp_rugby_spawn_axis");

  if(var_1.size <= 0 || var_2.size <= 0) {
    var_3 = _id_0817::_id_6D4E("mp_tdm_spawn");

    foreach(var_5 in var_3) {
      if(distancesquared(var_5.origin, var_0._id_708D["allies"].origin) < distancesquared(var_5.origin, var_0._id_708D["axis"].origin)) {
        var_1[var_1.size] = var_5;
        continue;
      }

      var_2[var_2.size] = var_5;
    }
  }

  var_7 = _id_0817::_id_6D4E("mp_rugby_spawn_allies_secondary");
  var_8 = _id_0817::_id_6D4E("mp_rugby_spawn_axis_secondary");
  _id_0817::_id_C2B8("allies", var_1);
  _id_0817::_id_C2B8("axis", var_2);
  _id_0817::_id_C2B8("allies", var_7);
  _id_0817::_id_C2B8("axis", var_8);
  _id_0817::_id_C2B9("rugby_allies", var_1);
  _id_0817::_id_C2B9("rugby_axis", var_2);
  _id_0817::_id_C2B9("rugby_allies_base", var_7);
  _id_0817::_id_C2B9("rugby_axis_base", var_8);
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = level._id_C98B;
  var_1 = self.pers["team"];

  if(istrue(game["switchedsides"])) {
    var_1 = scripts\engine\utility::ter_op(var_1 == "allies", "axis", "allies");
  }

  var_2 = scripts\engine\utility::ter_op(var_1 == "allies", "axis", "allies");

  if(_id_0817::_id_DC06()) {
    var_3 = _id_0817::_id_6D4E(var_0._id_E724 + "_" + var_1 + "_start");
    var_4 = _id_0817::_id_6D4D(var_3);
  } else {
    var_5 = _id_6AD4();
    var_6 = [];
    var_6["singlePointPos"] = var_5;
    var_6["minDistToSinglePointSq"] = 562500;
    var_6["maxDistToSinglePointSq"] = 36000000;
    var_6["distRangeToSinglePointSq"] = 35437500;
    var_6["juggPos"] = var_5;
    var_6["rugbyFieldDir2D"] = var_0._id_708D[var_2].origin - var_0._id_708D[var_1].origin;
    var_7 = undefined;
    var_8 = undefined;

    if(var_1 == "allies") {
      var_7 = "rugby_allies";
      var_8 = "rugby_allies_base";
    } else {
      var_7 = "rugby_axis";
      var_8 = "rugby_axis_base";
    }

    var_4 = _id_0817::_id_6D4A(self, self.team, var_7, var_8, undefined, var_6);
  }

  return var_4;
}

_id_6AD4() {
  var_0 = level._id_C98B;

  if(var_0._id_0F4A.size > 0) {
    foreach(var_2 in var_0._id_0F4A) {
      return var_2.origin;
    }
  } else {
    foreach(var_5 in var_0._id_0F49) {
      return var_5.origin;
    }
  }

  return undefined;
}

_id_4C7F(var_0) {
  var_1 = level._id_C98B;

  if(var_1._id_0F4A.size > 0) {
    foreach(var_3 in var_1._id_0F4A) {
      if(var_3.team == var_0) {
        return 1;
      }
    }
  }

  return 0;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
}

_id_ABC0() {
  if(level.gameended) {
    return;
  }
  if(level._id_C98B._id_0F4A.size <= 0) {
    game["roundsWon"]["allies"]++;
    game["roundsWon"]["axis"]++;
    thread scripts\mp\gamelogic::_id_52F7("tie", game["end_reason"]["time_limit_reached"]);
  } else if(!istrue(level._id_C98B._id_82D0)) {
    iprintlnbold("Overtime");
    level._id_C98B._id_82D0 = 1;
  }
}

_id_AB0D(var_0) {
  level endon("game_ended");
  playsoundatpos(var_0.origin, "exp_bombsite_lr");
  playFX(scripts\engine\utility::getfx("rugby_score_explosion"), var_0.origin);
  var_1 = scripts\mp\utility\player::_id_6C5F(var_0.origin, 800);

  foreach(var_3 in var_1) {
    if(var_3 != var_0 && var_3.team != var_0.team) {
      var_3 dodamage(5000, var_0.origin, var_3, undefined, "MOD_EXPLOSIVE");
    }
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0.team, game["end_reason"]["target_destroyed"]);
}

_id_D882() {
  var_0 = level._id_C98B;
  _id_78E6();

  if(!_id_0EF2(var_0._id_535E["allies"][0], "allies")) {
    return;
  }
  if(!_id_0EF2(var_0._id_535E["axis"][0], "axis")) {
    return;
  }
  if(!_id_0EF9()) {
    return;
  }
}

_id_0EF9() {
  var_0 = randomint(level._id_C98B._id_8C30.size);
  var_1 = level._id_C98B._id_8C30[var_0];

  if(!isDefined(var_1)) {
    return 0;
  }

  return _id_0EF6(var_1.origin, scripts\engine\utility::ter_op(isDefined(var_1.angles), var_1.angles, (0, 0, 0)));
}

_id_0EF2(var_0, var_1) {
  var_2 = level._id_C98B;

  if(istrue(game["switchedsides"])) {
    var_1 = scripts\engine\utility::ter_op(var_1 == "allies", "axis", "allies");
  }

  if(!isDefined(var_0)) {
    return 0;
  }

  if(isDefined(var_2._id_708D[var_1])) {
    _id_438D(var_2._id_708D[var_1]);
  }

  var_2._id_708D[var_1] = var_0;
  var_0 thread _id_10B1E(var_1);
  return 1;
}

_id_438D(var_0) {
  var_0 notify("endzone_deactivate");
}

_id_DC9D(var_0, var_1, var_2) {
  foreach(var_4 in var_0._id_10430[var_1]) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_2) {
        var_4 showtoplayer(var_6);
        continue;
      }

      var_4 hidefromplayer(var_6);
    }
  }
}

_id_78F6(var_0, var_1, var_2) {
  foreach(var_4 in var_0._id_10430[var_1]) {
    foreach(var_6 in level.players) {
      if(var_6.team == var_2) {
        var_4 hidefromplayer(var_6);
        continue;
      }

      var_4 showtoplayer(var_6);
    }
  }
}

_id_78E6(var_0) {
  var_1 = ["allies", "axis"];
  var_2 = ["friendly", "enemy"];

  foreach(var_4 in var_1) {
    foreach(var_0 in level._id_C98B._id_535E[var_4]) {
      foreach(var_7 in var_2) {
        foreach(var_9 in var_0._id_10430[var_7]) {
          var_9 hide();
        }
      }
    }
  }
}

_id_D877(var_0) {
  var_1 = var_0.team;
  var_2 = scripts\mp\utility\teams::_id_6A01(var_1);
  var_3 = var_2[0];
  var_4 = level._id_C98B._id_708D[var_3];
  _id_DC9D(var_4, "enemy", var_1);
  _id_DC9D(var_4, "friendly", var_3);
}

_id_10B1E(var_0) {
  level endon("game_ended");
  self endon("endzone_deactivate");

  for(;;) {
    self._id_1A4B waittill("trigger", var_1);

    if(isDefined(var_1._id_C98C) && var_1.team != var_0) {
      _id_AB0D(var_1);
      return;
    }
  }
}

_id_0EFA(var_0) {
  var_1 = level._id_C98B;
  var_2 = spawnStruct();
  var_2.player = var_0;
  var_3 = var_0 getentitynumber();
  var_2._id_7C8C = var_3;
  var_1._id_0F4A[var_3] = var_0;
  var_0._id_C98C = var_2;
  _id_D8A0(var_0);
  _id_4025(var_0, var_2);
  _id_E6DD(var_0);
  _id_D877(var_0);
  var_0 thread _id_10B94();
  var_0 thread _id_10B1A();
  var_0 thread _id_10B95();
  var_0 thread _id_10C16();

  if(_id_6AD7()) {
    var_0 thread _id_10B96();
  }
}

_id_438F(var_0) {
  var_1 = level._id_C98B;
  var_2 = var_0._id_C98C;

  if(isDefined(var_0)) {
    var_0._id_C98C = undefined;
  }

  var_1._id_0F4A[var_2._id_7C8C] = undefined;
  _id_3895(var_0, var_2);
  _id_394A();
  _id_78E6();
  var_0 notify("rugby_jugg_end");
}

_id_E6DD(var_0) {
  setomnvar("ui_rugby_jugg_client", var_0);
  setomnvar("ui_rugby_jugg_health", 1.0);

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("ui_rugby_jugg_friendly", scripts\engine\utility::ter_op(var_2.team == var_0.team, 0, 1));
  }
}

_id_394A() {
  setomnvar("ui_rugby_jugg_client", undefined);

  foreach(var_1 in level.players) {
    var_1 setclientomnvar("ui_rugby_jugg_friendly", -1);
  }
}

_id_10B94() {
  level endon("game_ended");
  self endon("rugby_jugg_end");

  for(;;) {
    self waittill("damage");
    setomnvar("ui_rugby_jugg_health", self.health / self.maxhealth);
  }
}

_id_10B1A() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  self waittill("death_or_disconnect");
  var_0 = undefined;

  if(!isDefined(self)) {
    var_0 = level._id_8FF9[self._id_C98C._id_7C8C];
  } else {
    var_0 = self.origin;
  }

  var_1 = _func_02AB(var_0);
  _id_0EF6(var_1 + (0, 0, 60), (0, 0, 0));
  _id_438F(self);
}

_id_10B95() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  var_0 = self.team;
  var_1 = scripts\mp\utility\teams::_id_6A01(var_0);
  var_2 = var_1[0];
  var_3 = level._id_C98B._id_708D[var_0];
  var_4 = level._id_C98B._id_708D[var_2];
  var_5 = var_4.origin - var_3.origin;
  var_6 = vectordot(var_5, var_5);

  for(;;) {
    var_7 = self.origin * (1, 1, 0) - var_3.origin * (1, 1, 0);
    var_8 = vectordot(var_5, var_7) / var_6;
    var_8 = clamp(var_8, 0.0, 1.0);
    var_9 = [];
    var_9[var_0] = var_8;
    var_9[var_2] = 1.0 - var_8;

    foreach(var_11 in level.players) {
      if(var_11.team == var_0 || var_11.team == var_2) {
        var_11 setclientomnvar("ui_rugby_jugg_progress", var_9[var_11.team]);
      }
    }

    level._id_8FF9[self._id_C98C._id_7C8C] = self.origin;
    wait 0.05;
  }
}

_id_D8A0(var_0) {
  var_1 = level._id_C98B._id_8C2A;
  var_2 = var_0 _id_07E6::_id_8C08(var_1);

  if(!var_2) {}

  var_0._id_5046 = 1;
  var_0 givemaxammo(var_0._id_3808._id_968A);
  var_0._id_B7E4 = _id_6AD5(0);
  var_0 scripts\mp\weapons::_id_FCCC();
  var_0 thread _id_7462();
  var_3 = scripts\mp\utility\teams::_id_6A01(var_0.team);
  var_4 = var_3[0];
}

_id_10C16() {
  level endon("game_ended");
  self endon("rugby_jugg_end");

  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(var_2.team != self.team || var_2 == self) {
        continue;
      }
      if(distancesquared(var_2.origin, self.origin) < 122500) {
        var_0++;
      }
    }

    self._id_B7E4 = _id_6AD5(var_0);
    scripts\mp\weapons::_id_FCCC();
    wait 0.1;
  }
}

_id_10B96() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  wait(_id_6AD6());
  self suicide();
}

_id_7462() {
  level endon("game_ended");
  self endon("rugby_jugg_end");
  self notifyonplayercommand("jugg_jumped", "+goStand");

  for(;;) {
    self waittill("jugg_jumped");
    var_0 = self getvelocity();
    var_1 = (var_0[0] * 0.25, var_0[1] * 0.25, var_0[2]);
    self setvelocity(var_1);
  }
}

_id_4025(var_0, var_1) {
  _id_4003(var_0, var_1);
  var_2 = scripts\mp\utility\teams::_id_6A01(var_0.team);
  var_3 = var_2[0];
  var_4 = level._id_C98B._id_708D[var_3];
  _id_3FC7(var_4, var_3, var_1);
}

_id_3895(var_0, var_1) {
  _id_07F9::_id_C799(var_1._id_8C88);
  _id_07F9::_id_C799(var_1._id_535D);
}

_id_4003(var_0, var_1) {
  var_2 = _id_07F9::_id_C57D(99);
  var_1._id_8C88 = var_2;
  _id_07F9::_id_A867(var_2, "current", var_0.origin, "icon_waypoint_jugg");
  _id_07F9::_id_A8B1(var_2, 0);
  _id_07F9::_id_A8B2(var_2, 0);
  _id_07F9::_id_A8A2(var_2);
  _id_07F9::_id_FB93(var_2, var_0);
  _id_07F9::_id_FB9D(var_2, 90);
  _func_0182(var_2, var_0.team);
  _func_0168(var_2, "MP_MODE_RUGBY/JUGG_ESCORT");
  _func_0169(var_2, "MP_MODE_RUGBY/JUGG_KILL");
}

_id_3FC7(var_0, var_1, var_2) {
  var_3 = _id_07F9::_id_C57D(99);
  var_2._id_535D = var_3;
  _id_07F9::_id_A867(var_3, "current", var_0.origin, "icon_waypoint_hq");
  _id_07F9::_id_A8B1(var_3, 0);
  _id_07F9::_id_A8B2(var_3, 0);
  _id_07F9::_id_A8A2(var_3);
  _func_0182(var_3, var_1);
  _func_0168(var_3, "MP_MODE_RUGBY/ENDZONE_DEFEND");
  _func_0169(var_3, "MP_MODE_RUGBY/ENDZONE_ASSAULT");
}

_id_0EF6(var_0, var_1) {
  var_2 = level._id_C98B;
  var_3 = _id_4001(var_0, var_1);
  var_2._id_0F49[var_3._id_3E91] = var_3;
  return 1;
}

_id_4001(var_0, var_1) {
  var_2 = getgroundposition(var_0, 32);
  var_3 = spawn("script_model", var_2);
  var_3.angles = var_1;
  var_3 setModel("military_crate_large_stackable_01_jugg");
  var_3._id_3E91 = var_3 getentitynumber();
  _id_4002(var_3);
  var_3 thread _id_8C2D();
  var_3 thread _id_72B0();
  return var_3;
}

_id_72B0() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    var_0 = _func_00E8();

    foreach(var_2 in var_0) {
      if(distance2dsquared(var_2.origin, self.origin) < 40000) {
        var_2 delete();
      }
    }

    wait 0.25;
  }
}

_id_8C2D() {
  level endon("game_ended");
  self endon("death");
  self setuserange(120);
  self setcursorhint("HINT_NOICON");
  self sethintstring(&"MP_MODE_RUGBY/CRATE_USE");
  self setuseholdduration("duration_long");
  self sethintrequiresholding(1);
  self makeuseable();
  self._id_84EF = 0;
  thread _id_8C35();
  thread _id_8C34();
  thread _id_8C33();
}

_id_8C32(var_0) {
  _id_0EFA(var_0);
  _id_8C2C();
  level._id_C98B._id_0F49[self._id_3E91] = undefined;
  self delete();
}

_id_8C2C() {
  _id_07F9::_id_C799(self._id_A906);
}

_id_8C34() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger", var_0);

    if(!scripts\mp\utility\player::isreallyalive(var_0)) {
      continue;
    }
    _id_8C32(var_0);
    return;
  }
}

_id_8C35() {
  level endon("game_ended");
  self endon("death");

  for(;;) {
    self waittill("trigger_progress", var_0);
    self._id_FF16 = var_0;
    self._id_84EF = 1;
    self._id_90BE = gettime();
  }
}

_id_8C33() {
  level endon("game_ended");
  self endon("death");
  var_0 = self._id_84EF;
  var_1 = self._id_FF16;

  for(;;) {
    wait 0.2;

    if(self._id_84EF) {
      if(self._id_90BE < gettime() - 200.0) {
        self._id_84EF = 0;
        self._id_FF16 = undefined;
        self._id_90BE = undefined;
        continue;
      }

      var_2 = isDefined(var_1) && isDefined(self._id_FF16) && var_1 != self._id_FF16;

      if(!var_0 || var_2) {
        _id_FC97(self);
      }
    } else if(var_0)
      _id_FC97(self);

    var_0 = self._id_84EF;
    var_1 = self._id_FF16;
  }
}

_id_4002(var_0) {
  var_1 = _id_07F9::_id_C57D(99);
  var_0._id_A906 = var_1;
  var_2 = var_0.origin + (0, 0, 32);
  _id_07F9::_id_A867(var_1, "current", var_2, "icon_waypoint_jugg");
  _id_07F9::_id_A8B1(var_1, 0);
  _id_07F9::_id_A8B2(var_1, 0);
  _id_07F9::_id_A8A2(var_1);
  _func_016A(var_1, "MP_MODE_RUGBY/CRATE_CAPTURE");
  _func_0168(var_1, "MP_MODE_RUGBY/CRATE_CAPTURING");
  _func_0169(var_1, "MP_MODE_RUGBY/CRATE_LOSING");
  _id_FC97(var_0);
}

_id_FC97(var_0) {
  var_1 = var_0._id_A906;
  var_2 = istrue(var_0._id_84EF);

  if(var_2) {
    _func_0182(var_1, var_0._id_FF16.team);
    _func_0174(var_1, 1);
  } else {
    _func_0182(var_1, undefined);
    _func_0174(var_1, 0);
  }
}

_id_FCE2(var_0) {
  if(isDefined(var_0)) {
    var_1 = var_0;
    var_2 = level._id_E3EA[0][var_1];
  } else {
    var_1 = self.team;
    var_2 = level._id_E3EA[0][self.team];
  }

  var_3 = level._id_C98B;
  var_4 = undefined;

  if(!istrue(game["switchedsides"])) {
    var_4 = var_1;
  } else {
    var_4 = scripts\engine\utility::ter_op(var_1 == "allies", "axis", "allies");
  }

  var_5 = scripts\engine\utility::ter_op(var_4 == "allies", "axis", "allies");
  var_6 = var_3._id_535E[var_4][0].origin;
  var_7 = var_3._id_535E[var_5][0].origin;
  var_8 = (var_7 - var_6) * (1, 1, 0);
  var_9 = _func_0133(var_8);
  var_10 = scripts\cp_mp\utility\killstreak_utility::_id_6ADB();

  if(isDefined(var_10)) {
    var_11 = var_10.origin[2];
  } else {
    var_11 = 5000;
  }

  var_12 = undefined;
  var_13 = undefined;

  if(_id_4C7F(var_1)) {
    var_14 = _id_6AD4();
    var_12 = var_14 + var_8 * (-3000 / var_9);
    var_12 = (var_12[0], var_12[1], var_11);
    var_13 = var_14 + (var_7 - var_14) * 0.5;
  } else {
    var_12 = var_6 + var_8 * (-2000 / var_9);
    var_12 = (var_12[0], var_12[1], var_11);
    var_13 = _id_6AD4();
  }

  var_15 = var_13 - var_12;
  var_16 = vectortoangles(var_15);
  var_2.origin = var_12;
  var_2.angles = var_16;
}

_id_E727() {
  _id_0A99::_id_D5EA(0);
  waitframe();
  scripts\mp\utility\player::_id_FD26("spectator");
  _id_081A::_id_D512();

  if(isDefined(self._id_8FB8)) {
    self setplayerangles(self._id_8FB8);
  }

  wait 0.1;
  scripts\mp\utility\player::_id_D51E();
  _id_FCE2();
  var_0 = level._id_E3EA[0][self.team];
  var_1 = var_0.origin;
  var_2 = var_0.angles;
  self._id_4411 = var_1;
  self._id_4410 = var_2;
  var_3 = spawn("script_model", self getvieworigin());
  var_3 setModel("tag_origin");
  var_3.angles = var_2;
  self._id_E3E9 = var_3;
  self._id_8AD7 = 1;
  self cameralinkto(var_3, "tag_origin", 1);
  thread _id_4CF1();
  var_3 _id_A227(self, var_1, var_2);
}

_id_4CF1() {
  wait 0.4;
  thread _id_B8DB();
  _id_19EE();
}

_id_534B() {
  if(!isDefined(self._id_E3E9)) {
    return;
  }
  _id_C533();
  _id_C50C();
  thread _id_CA72();
}

_id_19EE() {
  self visionsetthermalforplayer("proto_apache_flir_mp");
  self _meth_840B();
}

_id_C533() {
  self _meth_840A();
}

_id_A227(var_0, var_1, var_2) {
  var_0 endon("spawned_player");
  var_3 = 1.0;
  var_4 = 1.0;
  self moveto(var_1, 1.0, 0.5, 0.5);
  var_0 _meth_82FD("spawn_cam", 0.5, "mix");
  self rotateto(var_2, 1.0, 0.5, 0.5);
  wait 1.1;
  var_5 = anglesToForward(var_2) * 300;
  var_5 = var_5 * (1, 1, 0);

  if(isDefined(var_0) && isDefined(var_0._id_E3E9)) {
    self moveto(var_1 + var_5, 15.0, 1.0, 1.0);
    var_0 earthquakeforplayer(0.03, 15.0, var_1 + var_5, 1000);
  }
}

_id_CA72() {
  self waittill("spawned_player");
  var_0 = self getEye();
  var_1 = self.angles;
  scripts\mp\utility\player::_id_FD26("spectator");
  self cameralinkto(self._id_E3E9, "tag_origin", 1);
  self visionsetnakedforplayer("tac_ops_slamzoom", 0.2);
  self._id_E3E9 moveto(var_0, 0.5);
  self _meth_8078(0.5);
  self._id_E3E9 rotateto(var_1, 0.5, 0.5);
  wait 0.5;
  self visionsetnakedforplayer("", 0);
  thread _id_B8DB();
  scripts\mp\utility\player::_id_FD26("playing");
  self _meth_8060();
  self._id_E3E9 delete();
  wait 1.0;
}

_id_B8DB() {
  var_0 = newclienthudelem(self);
  var_0.x = 0;
  var_0.y = 0;
  var_0.alignx = "left";
  var_0.aligny = "top";
  var_0.sort = 1;
  var_0.horzalign = "fullscreen";
  var_0.vertalign = "fullscreen";
  var_0.alpha = 1;
  var_0._id_01D6 = 1;
  var_0 setshader("white", 640, 480);
  var_0 fadeovertime(0.4);
  var_0.alpha = 0.0;
  wait 0.4;
  var_0 destroy();
}

_id_5266() {
  self._id_C98D = [];

  foreach(var_1 in level.players) {
    if(var_1 == self) {
      continue;
    }
    var_2 = scripts\engine\utility::ter_op(var_1.team == self.team, "outlinefill_nodepth_cyan", "outlinefill_nodepth_orange");
    var_3 = scripts\mp\utility\outline::outlineenableforplayer(var_1, self, var_2, "level_script");
    self._id_C98D[var_3] = var_1;
  }
}

_id_C50C() {
  if(isDefined(self._id_C98D)) {
    foreach(var_2, var_1 in self._id_C98D) {
      scripts\mp\utility\outline::outlinedisable(var_2, var_1);
    }

    self._id_C98D = undefined;
  }
}