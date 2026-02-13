/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\cranked.gsc
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
    scripts\mp\utility\game::_id_C2C1(scripts\mp\utility\game::getgametype(), 10);
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 100);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  level.teambased = getdvarint("#x3663506e2decce032", 1) == 1;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;

  if(!level.teambased) {
    level._id_AB75 = ::_id_AB75;
    setDvar("#x31243de53419fdbd7", getdvarint("#x39553d882c109a56f", 60));
    _func_01F5("ffa");
  }

  game["dialog"]["gametype"] = "cranked";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x3e488386ae6284c8")) {
    game["dialog"]["gametype"] = "dh_" + game["dialog"]["gametype"];
  } else if(getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_promode"))) {
    game["dialog"]["gametype"] = game["dialog"]["gametype"] + "_pro";
  }

  game["dialog"]["offense_obj"] = "crnk_hint";
  game["dialog"]["begin_cranked"] = "crnk_cranked";
  game["dialog"]["five_seconds_left"] = "crnk_det";
  game["strings"]["overtime_hint"] = &"MP/FIRST_BLOOD";
}

onplayerconnect(var_0) {
  var_0 thread onplayerspawned();
}

onplayerspawned() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned_player");
  }
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3f9b5455872e5e496", 0);
  scripts\mp\utility\game::_id_C2AA("cranked", 0, 0, 9);
  setdynamicdvar("#x3f6b41d896319d01d", 1);
  scripts\mp\utility\game::_id_C2A9("cranked", 1);
  setdynamicdvar("#x371871ca695967383", 1);
  scripts\mp\utility\game::_id_C2D0("cranked", 1);
  setdynamicdvar("#x39ee9978e3256e67a", 0);
  scripts\mp\utility\game::_id_C25D("cranked", 0);
  setdynamicdvar("#x3bedaf27917031b2a", 0);
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

  var_2 = &"OBJECTIVES/WAR";
  var_3 = &"OBJECTIVES/WAR_SCORE";
  var_4 = &"OBJECTIVES/WAR_HINT";

  if(!level.teambased) {
    var_2 = &"OBJECTIVES/DM";
    var_3 = &"OBJECTIVES/DM_SCORE";
    var_4 = &"OBJECTIVES/DM_HINT";
  }

  foreach(var_6 in level._id_EF89) {
    scripts\mp\utility\game::_id_D61C(var_6, var_2);

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_6, var_2);
    } else {
      scripts\mp\utility\game::_id_D61A(var_6, var_3);
    }

    scripts\mp\utility\game::_id_D615(var_6, var_4);
  }

  _id_8294();
  _id_3E59();
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);

  if(level.teambased) {
    _id_0817::_id_D461("Default", "Crit_Frontline");
    _id_0817::_id_113A("mp_tdm_spawn_allies_start");
    _id_0817::_id_113A("mp_tdm_spawn_axis_start");
    _id_0817::_id_1136("allies", "mp_tdm_spawn");
    _id_0817::_id_1136("axis", "mp_tdm_spawn");
    _id_0817::_id_C2B9("normal", "mp_tdm_spawn");
    _id_0817::_id_C2B9("fallback", "mp_tdm_spawn_secondary");
  } else {
    _id_0817::_id_D461("FreeForAll", "Crit_Default");
    _id_0817::_id_1136("allies", "mp_dm_spawn");
    _id_0817::_id_1136("axis", "mp_dm_spawn");
    _id_0817::_id_C2B9("normal", "mp_dm_spawn");
    _id_0817::_id_C2B9("fallback", "mp_dm_spawn_secondary");
  }

  level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
  setmapcenter(level._id_9AAC);
  _id_0817::_id_0EE5();
}

_id_6D4A() {
  if(level.teambased) {
    var_0 = self.pers["team"];

    if(game["switchedsides"]) {
      var_0 = scripts\mp\utility\game::_id_6BE2(var_0)[0];
    }

    if(_id_0817::_id_DC06()) {
      var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_" + var_0 + "_start");
      var_2 = _id_0817::_id_6D4D(var_1);
    } else
      var_2 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");
  } else if(level._id_7EB0) {
    var_1 = _id_0817::_id_6DDD(self.team);
    var_2 = _id_0817::_id_6D4C(var_1);
  } else
    var_2 = _id_0817::_id_6D4A(self, "none", "normal", "fallback");

  return var_2;
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 _id_387B();
  var_6 = scripts\mp\rank::getscoreinfovalue("score_increment");

  if(isDefined(var_1._id_3E59)) {
    var_6 = var_6 * 2;
    var_7 = "kill_cranked";
    var_1 thread _id_AB0E(var_7);
    var_1.pers["killChains"]++;
    var_1 scripts\mp\persistence::_id_E770("round", "killChains", var_1.pers["killChains"]);
  } else if(scripts\mp\utility\player::isreallyalive(var_1))
    var_1 _id_99E2("begin_cranked");

  if(isDefined(var_0._id_1DDE) && !isDefined(level._id_1D2C)) {
    foreach(var_9 in var_0._id_1DDE) {
      if(!isDefined(_id_0A8B::_id_0DB6(var_9))) {
        continue;
      }
      if(var_9 == var_1) {
        continue;
      }
      if(var_0 == var_9) {
        continue;
      }
      if(!isDefined(var_9._id_3E59)) {
        continue;
      }
      var_9 thread _id_AA72("assist_cranked");
    }
  }

  if(level.teambased) {
    level scripts\mp\gamescore::_id_7001(var_1.pers["team"], var_6, 0);
  } else {
    var_11 = 0;

    foreach(var_9 in level.players) {
      if(isDefined(var_9._id_038F) && var_9._id_038F > var_11) {
        var_11 = var_9._id_038F;
      }
    }
  }
}

_id_387B() {
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  self._id_3E59 = undefined;
  self._id_3E5A = undefined;
}

_id_ABC0() {
  var_0 = scripts\mp\gamescore::_id_6AA0();

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if(var_0 == "tie") {
    var_0 = "overtime";
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_AB75(var_0, var_1) {
  if(var_0 != "super_kill" && issubstr(var_0, "kill")) {
    var_2 = scripts\mp\rank::getscoreinfovalue("score_increment");

    if(isDefined(var_1._id_3E59)) {
      var_2 = var_2 * 2;
    }

    return var_2;
  }

  return 0;
}

_id_3E59() {
  level._id_3E5B = 30;
}

_id_99E2(var_0) {
  _id_0A8D::_id_9137(var_0);
  thread scripts\mp\rank::_id_CC00(var_0);
  _id_D4EC("kill");
  self._id_3E59 = 1;
  scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickdraw");
  scripts\mp\utility\perk::_id_6FC2("specialty_fastoffhand");
  scripts\mp\utility\perk::_id_6FC2("specialty_fastsprintrecovery");
  scripts\mp\utility\perk::_id_6FC2("specialty_marathon");
  scripts\mp\utility\perk::_id_6FC2("specialty_quickswap");
  scripts\mp\utility\perk::_id_6FC2("specialty_stalker");
  self._id_A25F = 1.2;
  scripts\mp\weapons::_id_FCCC();
}

_id_AB0E(var_0) {
  level endon("game_ended");
  self endon("disconnect");

  while(!isDefined(self.pers)) {
    waitframe();
  }

  thread _id_0A9F::_id_7003(var_0);
  _id_D4EC("kill");
}

_id_AA72(var_0) {
  level endon("game_ended");
  self endon("disconnect");
  thread scripts\mp\rank::_id_CC00(var_0);
  _id_D4EC("assist");
}

_id_10A9B(var_0) {
  self notify("watchBombTimer");
  self endon("watchBombTimer");
  self endon("death_or_disconnect");
  level endon("game_ended");
  var_1 = 5;
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(var_0 - var_1 - 1);
  _id_0A8D::_id_9137("five_seconds_left");
  scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
  self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);

  while(var_1 > 0) {
    scripts\mp\hostmigration::waitlongdurationwithhostmigrationpause(1.0);
    var_1--;
  }

  if(isDefined(self) && scripts\mp\utility\player::isreallyalive(self)) {
    self playSound("frag_grenade_expl_trans");
    _id_0A8B::_id_0D8A();
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
  }
}

_id_D4EC(var_0) {
  var_1 = level._id_3E5B;

  if(var_0 == "assist") {
    var_1 = int(min((self._id_3E5A - gettime()) / 1000 + level._id_3E5B * 0.5, level._id_3E5B));
  }

  var_2 = var_1 * 1000 + gettime();
  self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", var_2);
  self._id_3E5A = var_2;
  thread _id_10AB6();
  thread _id_10A9B(var_1);
  thread _id_10AD8();
}

_id_10AB6() {
  self notify("watchCrankedHostMigration");
  self endon("watchCrankedHostMigration");
  level endon("game_ended");
  self endon("death_or_disconnect");
  level waittill("host_migration_begin");
  self setclientomnvar("ui_cranked_timer_stopped", 1);
  var_0 = scripts\mp\hostmigration::waittillhostmigrationdone();
  self setclientomnvar("ui_cranked_timer_stopped", 0);

  if(self._id_3E5A + var_0 < 5) {
    self setclientomnvar("ui_cranked_bomb_timer_final_seconds", 1);
  }

  if(var_0 > 0) {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self._id_3E5A + var_0);
  } else {
    self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", self._id_3E5A);
  }
}

_id_10AD8() {
  self notify("watchEndGame");
  self endon("watchEndGame");
  self endon("death_or_disconnect");

  for(;;) {
    if(game["state"] == "postgame" || level.gameended) {
      self setclientomnvar("ui_cranked_bomb_timer_end_milliseconds", 0);
      break;
    }

    wait 0.1;
  }
}