/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\front.gsc
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
    scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 600);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 100);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 2);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  game["dialog"]["gametype"] = "frontline";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x3e488386ae6284c8")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["strings"]["overtime_hint"] = &"MP/FIRST_BLOOD";
  thread _id_E3AE();
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3d360d2f7f4c76f87", getmatchrulesdata("frontData", "enemyBaseKillReveal"));
  setdynamicdvar("#x3c468dc794db0bb17", getmatchrulesdata("frontData", "friendlyBaseScore"));
  setdynamicdvar("#x3d157de0c1fbd4db3", getmatchrulesdata("frontData", "midfieldScore"));
  setdynamicdvar("#x3b23b380750c61d1c", getmatchrulesdata("frontData", "enemyBaseScore"));
  setdynamicdvar("#x377e61fda0d75423", 0);
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

  foreach(var_3 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/FRONT");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/FRONT");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/FRONT_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/FRONT_HINT");
  }

  level._id_7C6C = "waypoint_capture_kill";
  level._id_7C6B = "waypoint_capture_kill";
  _id_8294();
  _id_22A7();
  thread _id_D84D();
  thread _id_D84C();
  level._id_4A82 = 1;
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
  level._id_5406 = scripts\mp\utility\dvars::_id_509A("enemyBaseKillReveal", 5, 0, 60);
  level._id_5FA0 = scripts\mp\utility\dvars::_id_509A("friendlyBaseScore", 1, 0, 25);
  level._id_9E8A = scripts\mp\utility\dvars::_id_509A("midfieldScore", 2, 0, 25);
  level._id_5408 = scripts\mp\utility\dvars::_id_509A("enemyBaseScore", 1, 0, 25);
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);
  _id_0817::_id_D461("Default", "Crit_Default");
  _id_0817::_id_1136("allies", "mp_front_spawn_allies");
  _id_0817::_id_1136("axis", "mp_front_spawn_axis");
  level._id_5FE1 = [];
  level._id_5FE1["allies"] = "allies";
  level._id_5FE1["axis"] = "axis";
  _id_0817::_id_C2B9("allies", "mp_front_spawn_allies");
  _id_0817::_id_C2B9("axis", "mp_front_spawn_axis");
  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_ABA4() {
  if(isPlayer(self)) {
    self._id_7E06 = 0;
    self._id_7EAC = 0;
    self._id_AD04 = 0;

    if(isDefined(self._id_ACE5)) {
      scripts\mp\utility\outline::outlinedisable(self._id_ACE5, self);
    }

    self._id_FE9E = 0;
    self._id_ACE5 = undefined;
    thread _id_5FA2();
    thread _id_540A();

    foreach(var_1 in level._id_110E9) {
      var_1 _id_DC89(self);
    }
  }
}

_id_6D4A() {
  var_0 = self.pers["team"];

  if(game["switchedsides"]) {
    var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
  }

  var_1 = _id_0817::_id_6D4A(self, var_0, level._id_5FE1[var_0]);
  return var_1;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
  var_6 = 0;

  if(var_0._id_7EAC || var_1._id_7E06) {
    var_1 thread _id_0A9F::_id_7003("enemy_base_kill", var_4);
    var_6 = level._id_5408;
  } else if(var_1._id_7EAC || var_0._id_7E06) {
    var_1 thread _id_0A9F::_id_7003("friendly_base_kill", var_4);
    var_6 = level._id_5FA0;
  } else {
    var_1 thread _id_0A9F::_id_7003("midfield_kill", var_4);
    var_6 = level._id_9E8A;
  }

  var_7 = game["teamScores"][var_1.pers["team"]] + var_6;
  var_8 = var_7 >= level._id_C948;

  if(var_8 && level._id_C948 != 0) {
    var_6 = level._id_C948 - game["teamScores"][var_1.pers["team"]];
  }

  if(var_6 > 0) {
    scripts\mp\gamescore::_id_7001(var_1.pers["team"], var_6, 0);
    var_1 thread scripts\mp\rank::_id_CC00("teamscore_notify_" + var_6);
  }
}

_id_5406() {
  level endon("game_ended");
  self endon("death");
  self notify("EnemyBaseKillReveal");
  self endon("EnemyBaseKillReveal");

  if(isDefined(self._id_22C1)) {
    scripts\mp\utility\outline::outlinedisable(self._id_22C1, self);
  }

  self._id_22C1 = scripts\mp\utility\outline::_id_ACD2(self, scripts\mp\utility\game::_id_6BE2(self.team)[0], "outline_nodepth_orange", "perk");

  if(!isbot(self)) {
    scripts\mp\utility\outline::_id_0C2E("outline_nodepth_orange", 0);
  }

  self sethudtutorialmessage(&"MP/FRONT_REVEALED");
  wait(level._id_5406);
  scripts\mp\utility\outline::outlinedisable(self._id_22C1, self);
  scripts\mp\utility\outline::_id_0C2D();
  self clearhudtutorialmessage(0);
}

_id_D84D() {
  level._id_110E9 = [];

  if(game["switchedsides"]) {
    level._id_1519 = getEntArray("frontline_zone_allies", "targetname");

    foreach(var_1 in level._id_1519) {
      var_1.team = "axis";
      var_1 thread _id_5FA2();
      var_1 thread _id_540A();
      var_1 thread _id_5407();
    }

    thread _id_D8C0(level._id_1519[0]);
    level._id_110E9[level._id_110E9.size] = level._id_1519[0];
    level._id_1FF1 = getEntArray("frontline_zone_axis", "targetname");

    if(level.mapname == "mp_junk") {
      var_3 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
      level._id_1FF1[level._id_1FF1.size] = var_3;
    }

    foreach(var_1 in level._id_1FF1) {
      var_1.team = "allies";
      var_1 thread _id_5FA2();
      var_1 thread _id_540A();
      var_1 thread _id_5407();
    }

    thread _id_D8C0(level._id_1FF1[0]);
    level._id_110E9[level._id_110E9.size] = level._id_1FF1[0];
  } else {
    level._id_1519 = getEntArray("frontline_zone_allies", "targetname");

    foreach(var_1 in level._id_1519) {
      var_1.team = "allies";
      var_1 thread _id_5FA2();
      var_1 thread _id_540A();
      var_1 thread _id_5407();
    }

    thread _id_D8C0(level._id_1519[0]);
    level._id_110E9[level._id_110E9.size] = level._id_1519[0];
    level._id_1FF1 = getEntArray("frontline_zone_axis", "targetname");

    if(level.mapname == "mp_junk") {
      var_3 = spawn("trigger_radius", (-1410, -2080, 240), 0, 1000, 600);
      level._id_1FF1[level._id_1FF1.size] = var_3;
    }

    foreach(var_1 in level._id_1FF1) {
      var_1.team = "axis";
      var_1 thread _id_5FA2();
      var_1 thread _id_540A();
      var_1 thread _id_5407();
    }

    thread _id_D8C0(level._id_1FF1[0]);
    level._id_110E9[level._id_110E9.size] = level._id_1FF1[0];
  }
}

_id_D8C0(var_0) {
  var_1 = [];
  var_1[0] = var_0;

  if(isDefined(var_0.target)) {
    var_2 = getEntArray(var_0.target, "targetname");

    for(var_3 = 0; var_3 < var_2.size; var_3++) {
      var_1[var_1.size] = var_2[var_3];
    }
  }

  var_1 = _id_9AC0(var_1, var_0.target);
  var_0._id_10430 = var_1;
}

_id_9AC0(var_0, var_1) {
  if(level.mapname == "mp_parkour" && var_1 == "front_vis_axis") {
    var_2 = spawn("script_origin", (-1088, -1504, 136));
    var_2.angles = (0, 180, 0);
    var_2._id_0481 = var_1;
    var_0[var_0.size] = var_2;
    var_3 = spawn("script_origin", (-1088, -1440, 136));
    var_3.angles = (0, 180, 0);
    var_2._id_0481 = var_1;
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

_id_5FA2() {
  level endon("game_ended");
  self endon("disconnect");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    if(var_0.team != self.team) {
      continue;
    }
    if(var_0._id_7EAC) {
      continue;
    }
    var_0 thread _id_5FA1(self);
  }
}

_id_5FA1(var_0) {
  self notify("friendlyTriggerWatcher");
  self endon("friendlyTriggerWatcher");
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(game["switchedsides"]) {
    if(self.team == "allies") {
      var_1 = level._id_1FF1;
    } else {
      var_1 = level._id_1519;
    }
  } else if(self.team == "allies")
    var_1 = level._id_1519;
  else {
    var_1 = level._id_1FF1;
  }

  for(;;) {
    self._id_7EAC = 0;

    foreach(var_0 in var_1) {
      if(self istouching(var_0)) {
        self._id_7EAC = 1;
        break;
      }
    }

    if(!self._id_7EAC || _id_07AD::_id_88B6()) {
      if(istrue(self._id_E355)) {
        scripts\mp\gametypes\common::_id_C523();
      }

      break;
    }

    waitframe();
  }
}

_id_540A() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(isDefined(var_0.team) && var_0.team == self.team) {
      continue;
    }
    if(isalive(var_0) && isDefined(var_0.sessionstate) && var_0.sessionstate != "spectator" || _id_B683(var_0)) {
      var_0._id_7E06 = 1;
      var_0 thread _id_5409(self);
    }
  }
}

_id_5409(var_0) {
  self endon("death");
  level endon("game_ended");

  if(istrue(self._id_FE9E)) {
    return;
  }
  for(;;) {
    if(isDefined(self) && self istouching(var_0)) {
      if(!istrue(self._id_FE9E)) {
        thread _id_524C();
      }
    } else {
      self._id_FE9E = 0;
      self._id_7E06 = 0;
      thread _id_4AAF();
      break;
    }

    waitframe();
  }
}

_id_524C() {
  self._id_FE9E = 1;
  self._id_AD04 = gettime();
  self._id_ACE5 = scripts\mp\utility\outline::_id_ACD2(self, scripts\mp\utility\game::_id_6BE2(self.team)[0], "outline_nodepth_orange", "perk");

  if(!isbot(self)) {
    if(isPlayer(self)) {
      scripts\mp\utility\outline::_id_0C2E("outline_nodepth_orange", 0);
    }
  }
}

_id_4AAF() {
  self._id_FE9E = 0;
  scripts\mp\utility\outline::outlinedisable(self._id_ACE5, self);
  self._id_ACE5 = undefined;

  if(!isbot(self) && isPlayer(self)) {
    scripts\mp\utility\outline::_id_0C2D();
  }
}

_id_5407() {
  level endon("game_ended");

  for(;;) {
    if(level._id_F897.size > 0) {
      foreach(var_1 in level._id_F897) {
        _id_747A(var_1);
      }
    }

    wait 0.1;
  }
}

_id_747A(var_0) {
  if(var_0.owner.team == self.team) {
    return;
  }
  if(var_0 istouching(self)) {
    if(!isDefined(var_0._id_ACE5)) {
      var_0._id_ACE5 = scripts\mp\utility\outline::_id_ACD2(var_0, self.team, "outline_nodepth_orange", "lowest");
    }
  } else if(isDefined(var_0._id_ACE5)) {
    scripts\mp\utility\outline::outlinedisable(var_0._id_ACE5, var_0);
    var_0._id_ACE5 = undefined;
  } else {}
}

_id_B683(var_0) {
  if(isDefined(var_0.streakname)) {
    switch (var_0.streakname) {
      default:
        return 0;
    }
  }

  return 0;
}

_id_DC89(var_0) {
  var_1 = self.team;
  var_2 = undefined;
  var_3 = var_0.team;

  if(!isDefined(var_3)) {
    var_3 = "allies";
  }

  var_4 = var_0 _meth_81D3();

  if(var_4) {
    var_3 = var_0 _meth_8154();
  } else if(var_3 == "spectator") {
    var_3 = "allies";
  }

  var_5 = level._id_22BA["friendly"];
  var_6 = level._id_22BA["enemy"];

  if(var_3 == var_1) {
    _id_DCAE(self._id_0B64, var_0);
    _id_78FC(self._id_0B63, var_0);
  } else {
    _id_DCAE(self._id_0B63, var_0);
    _id_78FC(self._id_0B64, var_0);
  }
}

_id_DCAE(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] showtoplayer(var_1);
  }
}

_id_78FC(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    var_0[var_2] hidefromplayer(var_1);
  }
}

_id_E2F1() {
  self._id_0B64 = [];
  self._id_0B63 = [];

  for(var_0 = 1; var_0 < self._id_10430.size; var_0++) {
    var_1 = anglesToForward(self._id_10430[var_0].angles);
    self._id_0B64[self._id_0B64.size] = spawnfx(level._id_22BA["friendly"], self._id_10430[var_0].origin, var_1);
    self._id_0B64[self._id_0B64.size - 1] _meth_8322();
    triggerfx(self._id_0B64[self._id_0B64.size - 1]);
  }

  for(var_0 = 1; var_0 < self._id_10430.size; var_0++) {
    var_1 = anglesToForward(self._id_10430[var_0].angles);
    self._id_0B63[self._id_0B63.size] = spawnfx(level._id_22BA["enemy"], self._id_10430[var_0].origin, var_1);
    self._id_0B63[self._id_0B63.size - 1] _meth_8322();
    triggerfx(self._id_0B63[self._id_0B63.size - 1]);
  }
}

_id_22A7() {
  level._id_22BA["friendly"] = loadfx("vfx/core/mp/core/vfx_front_border_cyan.vfx");
  level._id_22BA["enemy"] = loadfx("vfx/core/mp/core/vfx_front_border_orng.vfx");
}

_id_E3AE() {
  waitframe();

  foreach(var_1 in level._id_110E9) {
    var_1 _id_E2F1();
  }
}

onplayerconnect(var_0) {
  foreach(var_2 in level._id_110E9) {
    var_2 _id_DC89(var_0);
  }
}

_id_D84C() {
  var_0 = _id_68FB("front_zone_visual_allies_contest");
  var_1 = _id_68FB("front_zone_visual_axis_contest");
  var_2 = _id_68FB("front_zone_visual_allies_friend");
  var_3 = _id_68FB("front_zone_visual_axis_friend");
  var_4 = _id_68FB("front_zone_visual_allies_enemy");
  var_5 = _id_68FB("front_zone_visual_axis_enemy");
  _id_78EC(var_0);
  _id_78EC(var_1);
  _id_78EC(var_2);
  _id_78EC(var_3);
  _id_78EC(var_4);
  _id_78EC(var_5);
}

_id_78EC(var_0) {
  if(isDefined(var_0)) {
    for(var_1 = 0; var_1 < var_0.size; var_1++) {
      var_0[var_1] hide();
    }
  }
}

_id_68FB(var_0) {
  var_1 = getEntArray(var_0, "targetname");

  if(!isDefined(var_1) || var_1.size == 0) {
    return undefined;
  }

  return var_1;
}