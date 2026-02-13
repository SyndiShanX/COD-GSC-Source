/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\skulls.gsc
*************************************************/

init() {}

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
    scripts\mp\utility\game::_id_C2AD(scripts\mp\utility\game::getgametype(), 75);
    scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
    scripts\mp\utility\game::_id_C27E(scripts\mp\utility\game::getgametype(), 0);
    scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  }

  _id_FC7D();
  level.teambased = 1;
  level._id_ABAD = ::_id_ABAD;
  level._id_6D4A = ::_id_6D4A;
  level._id_AB3F = ::_id_AB3F;
  level._id_9FE8 = ::_id_ABA4;
  level.onplayerconnect = ::onplayerconnect;

  if(getdvarint("#x3863de265c7325250", 0) != 0) {
    level._id_AB70 = ::_id_AB03;
  }

  game["dialog"]["gametype"] = "gametype_tdm";

  if(getdvarint("#x3af383f37c3a10748")) {
    game["dialog"]["gametype"] = "hc_" + game["dialog"]["gametype"];
  } else if(getdvarint("#x36c8f5946a1247e70")) {
    game["dialog"]["gametype"] = "thirdp_" + game["dialog"]["gametype"];
  }

  game["dialog"]["boost"] = "boost_tdm";
  game["dialog"]["offense_obj"] = "boost_tdm";
  game["dialog"]["defense_obj"] = "boost_tdm";
  level._id_F0E4 = getdvarint("#x3596b515a9c3f3361", 0);
  level._id_EF37 = getdvarfloat("#x36a596b1c1bcf8e1b", 1000);
  level._id_EF38 = getdvarfloat("#x34f014b3c223afd46", 2048);
  level._id_EF36 = getdvarfloat("#x3f6617402ac195a50", 4092);

  if(istrue(level._id_F0E4)) {
    _id_0797::_id_8251();
  }

  if(scripts\mp\utility\game::matchmakinggame()) {
    level._id_DB63 = ::_id_DB63;
  }

  _id_07A1::_id_CEC6(::resourceused);
}

onplayerconnect(var_0) {
  var_0 waittill("spawned");
  var_0 update_player_ui_skulls(2);
  var_1 = var_0 scripts\mp\hud_util::createfontstring("default", 1.9);
  var_1 scripts\mp\hud_util::setpoint("BOTTOM", "BOTTOM", -30, -70);
  var_1.label = &"SKULLS_MODE/LABEL";
}

mark_skull_leaders() {
  level endon("game_ended");
  var_0 = [];

  for(;;) {
    wait 5;

    if(!isDefined(level.players) || level.players.size <= 1) {
      continue;
    }
    if(!isDefined(level.previous_skull_kings)) {
      level.previous_skull_kings = [];

      foreach(var_2 in level._id_EF89) {
        level.previous_skull_kings[var_2] = undefined;
      }
    }

    var_4 = [];

    foreach(var_6 in var_0) {
      if(isDefined(var_6)) {
        var_6 destroy();
      }
    }

    var_0 = [];

    foreach(var_2 in level._id_EF89) {
      var_9 = scripts\mp\utility\game::_id_6BE2(var_2)[0];
      var_10 = level._id_EF6A[var_9]["players"];
      var_11 = [];

      foreach(var_13 in var_10) {
        if(scripts\engine\utility::is_equal(var_13.sessionstate, "spectate")) {
          continue;
        }
        var_11 = scripts\engine\utility::array_add(var_11, var_13);
      }

      if(isDefined(var_11) && var_11.size >= 0) {
        var_15 = get_champion_skull_carrier(var_9);

        if(isDefined(var_15)) {
          var_0[var_2] = newteamhudelem(var_2);
          var_0[var_2] setshader("icon_minimap_juggernaut", 64, 64);
          var_0[var_2] _meth_83B2(0, 1, 0, 0);
          var_0[var_2] _meth_8388(var_15);
          var_0[var_2].color = (1, 0.2, 0.2);

          if(!scripts\engine\utility::is_equal(level.previous_skull_kings[var_2], var_15)) {
            foreach(var_13 in level._id_EF6A[var_2]["players"]) {
              var_13 playlocalsound("mp_dom_flag_captured_all");
              var_13 thread play_ui_splash_for_player(&"SKULLS_MODE/SKULL_KING", 100, 0);
            }
          }

          level.previous_skull_kings[var_2] = var_15;
          var_15 thread handlewaypointdeath(var_0[var_2], var_2, var_9);
        }
      }
    }

    foreach(var_13 in level.previous_skull_kings) {
      var_13 scripts\engine\utility::delaythread(0.5, ::play_ui_splash_for_player, &"SKULLS_MODE/SKULL_KING_PLAYER", 100, -40);
    }
  }
}

resourceused(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = var_3.pers["team"];

  if(scripts\engine\utility::is_equal(var_2, "item_test_used_" + var_6)) {
    var_0 _meth_86BE();

    if(!isDefined(var_3.skullcount)) {
      var_3.skullcount = 2;
    }

    var_3 thread scripts\mp\rank::_id_CC00("resource_collected");
    var_3 playrumbleonentity("damage_light");
    var_3 playsoundtoplayer("mp_hit_air_3d", var_3);
    var_3.skullcount++;

    if(!isDefined(level.skulls_team_reward_uav_time)) {
      level.skulls_team_reward_uav_time = [];

      foreach(var_8 in level._id_EF89) {
        level.skulls_team_reward_uav_time[var_8] = -1;
        level thread run_uav_skulls(var_8);
      }
    }

    foreach(var_8 in level._id_EF89) {
      var_11 = get_skulls_owned_by_team(var_8);

      if(var_11 >= 25) {
        level.skulls_team_reward_uav_time[var_8] = 10;
      }

      if(var_11 >= 50) {
        level.skulls_team_reward_uav_time[var_8] = 5;
      }

      if(var_11 >= 75) {
        level.skulls_team_reward_uav_time[var_8] = 2;
      }

      if(var_11 < 25) {
        level.skulls_team_reward_uav_time[var_8] = -1;
      }
    }

    if(var_3.skullcount == 5) {
      var_3 scripts\mp\class::_id_C55D();
      var_3 thread play_ui_splash_for_player(&"SKULLS_MODE/REWARD_1", -100, 0);
    }

    if(var_3.skullcount == 10) {
      var_3 thread give_temporary_armor();
      var_3 thread play_ui_splash_for_player(&"SKULLS_MODE/REWARD_2", -100, 0);
    }

    if(var_3.skullcount == 15) {
      _id_07EA::_id_9455(var_3);
      _id_07EA::_id_9453(var_3, 125, 0);
      var_3 thread play_ui_splash_for_player(&"SKULLS_MODE/REWARD_3", -100, 0);
    }

    if(var_3.skullcount == 25) {
      var_3 scripts\mp\killstreaks\killstreaks::_id_1FC8("flamethrower", var_3);
      var_3 thread play_ui_splash_for_player(&"SKULLS_MODE/REWARD_4", -100, 0);
    }

    var_3 update_player_ui_skulls(var_3.skullcount);
  } else if(issubstr(var_2, "item_test_used_")) {
    level thread reset_skull_scriptable(var_0.origin, var_6);
    var_0 _meth_86BE();
  }
}

run_uav_skulls(var_0) {
  level endon("unset_uav_active");
  level endon("game_ended");

  for(;;) {
    if(level.skulls_team_reward_uav_time[var_0] == -1) {
      wait 1;
      continue;
    }

    foreach(var_2 in level._id_EF6A[var_0]["players"]) {
      if(!isDefined(var_2)) {
        continue;
      }
      var_2._id_0358 = _func_00E0();
      var_2._id_024A = 0;
      var_2.hasradar = 1;
      var_2.radarshowenemydirection = 0;
      var_2.radarmode = "normal_radar";
      var_2 setclientomnvar("ui_hide_minimap", 0);
      var_2 setclientomnvar("ui_show_hardcore_minimap", 1);
      _func_0253(var_2);
      var_2 _meth_85C0(2);
    }

    wait(level.skulls_team_reward_uav_time[var_0]);
  }
}

reset_skull_scriptable(var_0, var_1) {
  wait 0.75;
  var_2 = _func_03C5("s4_skulls_resource_" + scripts\mp\utility\game::_id_6BE2(var_1)[0], var_0, (0, 0, 0));
}

give_temporary_armor() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 notify("give_temporary_armor");
  var_0 endon("give_temporary_armor");
  var_1 = 0.5;
  var_2 = 10;
  _id_07EA::_id_9455(var_0);
  _id_07EA::_id_9453(var_0, 125, 0);

  if(isDefined(var_0.temporaryarmorhud)) {
    var_0.temporaryarmorhud destroy();
  }

  var_3 = newclienthudelem(self);
  var_3.x = 0;
  var_3.y = 0;
  var_3.alignx = "left";
  var_3.aligny = "top";
  var_3.sort = 1;
  var_3.horzalign = "fullscreen";
  var_3.vertalign = "fullscreen";
  var_3.alpha = 0.125;
  var_3.color = (1, 1, 0);
  var_3 setshader("white", 640, 480);
  var_0.temporaryarmorhud = var_3;
  wait(var_2 - var_1);
  var_3 fadeovertime(0.5);
  var_3.alpha = 0;
  wait(var_1);
  var_0.temporaryarmorhud destroy();
  _id_07EA::_id_9455(var_0);
}

play_ui_splash_for_player(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = var_3 scripts\mp\hud_util::createfontstring("default", 1.9);
  var_4 scripts\mp\hud_util::setpoint("CENTER", "CENTER", var_1, var_2);
  var_4.label = var_0;
  wait 3;
  var_4 destroy();
}

handlewaypointdeath(var_0, var_1, var_2) {
  level endon("start_waypoint_skulls_" + var_2);
  level notify("start_waypoint_skulls_" + var_2);
  scripts\engine\utility::waittill_any_2("death", "disconnect");
  level.previous_skull_kings[var_1] = undefined;
  var_0 destroy();
}

update_player_ui_skulls(var_0) {
  var_1 = self;

  if(isDefined(self.skullscountvalue)) {
    self.skullscountvalue[0] destroy();
    self.skullscountvalue[1] destroy();
  }

  var_2 = "" + var_0;

  if(var_2.size < 2) {
    var_2 = "0" + var_2;
  }

  var_3 = var_1 scripts\mp\hud_util::createfontstring("default", 1.9);
  var_3 scripts\mp\hud_util::setpoint("BOTTOM", "BOTTOM", 0, -70);
  var_3.label = get_string_from_int(int(var_2[0]));

  if(int(var_2[0]) == 0) {
    var_3.alpha = 0;
  } else {
    var_3.alpha = 1;
  }

  self.skullscountvalue[0] = var_3;
  var_3 = var_1 scripts\mp\hud_util::createfontstring("default", 1.9);
  var_3 scripts\mp\hud_util::setpoint("BOTTOM", "BOTTOM", 10, -70);
  var_3.label = get_string_from_int(int(var_2[1]));
  self.skullscountvalue[1] = var_3;
}

get_string_from_int(var_0) {
  var_1 = [];
  var_1[var_1.size] = &"SKULLS_MODE/0";
  var_1[var_1.size] = &"SKULLS_MODE/1";
  var_1[var_1.size] = &"SKULLS_MODE/2";
  var_1[var_1.size] = &"SKULLS_MODE/3";
  var_1[var_1.size] = &"SKULLS_MODE/4";
  var_1[var_1.size] = &"SKULLS_MODE/5";
  var_1[var_1.size] = &"SKULLS_MODE/6";
  var_1[var_1.size] = &"SKULLS_MODE/7";
  var_1[var_1.size] = &"SKULLS_MODE/8";
  var_1[var_1.size] = &"SKULLS_MODE/9";
  return var_1[var_0];
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3d6ccba87107eb70a", 0);
  scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
  setdynamicdvar("#x33f7f987edc36b03a", 0);
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
    scripts\mp\utility\game::_id_D61C(var_3, &"OBJECTIVES/WAR");

    if(level.splitscreen) {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/WAR");
    } else {
      scripts\mp\utility\game::_id_D61A(var_3, &"OBJECTIVES/WAR_SCORE");
    }

    scripts\mp\utility\game::_id_D615(var_3, &"OBJECTIVES/WAR_HINT");
  }

  if(isDefined(level._id_8295)) {
    [[level._id_8295]]();
  } else {
    _id_8294();
  }

  scripts\mp\gametypes\bradley_spawner::_id_82A8();

  if(getdvarint("#x3863de265c7325250", 0) != 0) {
    thread _id_A117();
  }

  level thread updateskullsscores();
  level thread mark_skull_leaders();
}

updateskullsscores() {
  level endon("game_ended");
  var_0 = undefined;
  var_1 = undefined;
  level waittill("prematch_done");

  while(!level.gameended) {
    var_2 = 5.0;
    var_3 = scripts\mp\gamelogic::_id_6DE8();

    if(var_3 < 5000 && var_3 > 0) {
      var_2 = var_3 / 1000;
    }

    wait(var_2);
    scripts\mp\hostmigration::waittillhostmigrationdone();

    foreach(var_5 in level._id_EF89) {
      var_6 = get_skulls_owned_by_team(var_5);
      var_7 = int(var_6 / 10);

      foreach(var_9 in level._id_EF6A[var_5]["players"]) {
        var_9 iprintlnbold("Team " + var_5 + " : +^3" + var_7 + "^7 Points [For ^3" + var_6 + "^7 Skulls Held]");
      }

      scripts\mp\gamescore::_id_7001(var_5, var_7, 1, undefined, 1);
    }
  }
}

get_skulls_owned_by_team(var_0) {
  var_1 = 0;

  foreach(var_3 in level._id_EF6A[var_0]["players"]) {
    if(!isDefined(var_3.skullcount)) {
      var_1 = var_1 + 2;
      continue;
    }

    var_1 = var_1 + var_3.skullcount;
  }

  return var_1;
}

get_champion_skull_carrier(var_0) {
  var_1 = undefined;
  var_2 = 0;

  foreach(var_4 in level._id_EF6A[var_0]["players"]) {
    if(scripts\engine\utility::is_equal(var_4.sessionstate, "spectator")) {
      continue;
    }
    var_5 = scripts\engine\utility::ter_op(isDefined(var_4.skullcount), var_4.skullcount, 2);

    if(var_5 > var_2) {
      var_2 = var_5;
      var_1 = var_4;
    }
  }

  return var_1;
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
}

_id_8294() {
  level._id_E327 = (0, 0, 0);
  level._id_E324 = (0, 0, 0);

  if(isDefined(scripts\cp_mp\utility\game_utility::_id_6B18())) {
    _id_0817::_id_D461("BigTDM", "Crit_Frontline");
  } else {
    _id_0817::_id_D461("Default", "Crit_Frontline");
  }

  _id_0817::_id_113A("mp_tdm_spawn_allies_start");
  _id_0817::_id_113A("mp_tdm_spawn_axis_start");
  _id_0817::_id_1136(game["attackers"], "mp_tdm_spawn_allies_start");
  _id_0817::_id_1136(game["defenders"], "mp_tdm_spawn_axis_start");
  var_0 = _id_0817::_id_6D4E("mp_tdm_spawn_allies_start");
  var_1 = _id_0817::_id_6D4E("mp_tdm_spawn_axis_start");
  _id_0817::_id_C2B9("start_attackers", var_0);
  _id_0817::_id_C2B9("start_defenders", var_1);
  _id_0817::_id_1136("allies", "mp_tdm_spawn");
  _id_0817::_id_1136("axis", "mp_tdm_spawn");
  _id_0817::_id_1136("allies", "mp_tdm_spawn_secondary", 1, 1);
  _id_0817::_id_1136("axis", "mp_tdm_spawn_secondary", 1, 1);
  var_2 = _id_0817::_id_6D4E("mp_tdm_spawn");
  var_3 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
  _id_0817::_id_C2B9("normal", var_2);
  _id_0817::_id_C2B9("fallback", var_3);

  if(istrue(level._id_F0E4)) {
    var_4 = getdvarfloat("#x3ab5edb4c02a50335", randomfloatrange(-4096, 4096));
    var_5 = getdvarfloat("#x3ab5eda4c02a50102", randomfloatrange(-4096, 4096));
    var_6 = getdvarfloat("#x3ab5ed94c02a4fecf", randomfloatrange(0, 512));
    level._id_9AAC = (var_4, var_5, var_6);
    _id_EF35();
  } else {
    level._id_9AAC = _id_0817::_id_5AE1(level._id_E327, level._id_E324);
    setmapcenter(level._id_9AAC);
  }

  _id_0817::_id_0EE5();
}

_id_6D4A() {
  var_0 = self.pers["team"];
  var_1 = undefined;

  if(istrue(level._id_F0E4)) {
    var_2 = level._id_EF39._id_1783 * randomfloatrange(level._id_EF38 * -1.0, level._id_EF38);
    var_3 = undefined;

    if(var_0 == "axis") {
      var_3 = level._id_EF39._id_1773 * level._id_EF36 * -1.0;
    } else {
      var_3 = level._id_EF39._id_1773 * level._id_EF36;
    }

    var_1 = spawnStruct();
    var_1.origin = level._id_9AAC + var_2 + var_3 + (0, 0, level._id_EF37);
    var_1.angles = (0, 0, 0);
    var_1.index = 1;
  } else if(_id_0817::_id_DC06()) {
    if(var_0 == game["attackers"]) {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_attackers", undefined);
    } else {
      var_1 = _id_0817::_id_6D4A(self, var_0, "start_defenders", undefined);
    }
  } else
    var_1 = _id_0817::_id_6D4A(self, var_0, "normal", "fallback");

  return var_1;
}

_id_ABA4() {
  self setclientomnvar("ui_match_status_hint_text", 0);

  if(getdvarint("#x3e138924b10a94dfa") != 0) {
    thread scripts\mp\teams::_id_ACDA();
  }

  if(!istrue(level._id_F0E4)) {
    return;
  }
  self setplayerangles(vectortoangles(level._id_9AAC - self.origin));
}

_id_AB3F(var_0, var_1, var_2, var_3, var_4, var_5) {
  level thread spawn_loot_from_player_death(var_0, var_0.skullcount);
  scripts\mp\gametypes\common::_id_AA89(var_0, var_1, var_2, var_3, var_4, var_5);
}

spawn_loot_from_player_death(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 2;
  }

  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_4 = cos(var_3 * (360 / var_1));
    var_5 = sin(var_3 * (360 / var_1));
    var_6 = 32 * var_4;
    var_7 = 32 * var_5;
    var_8 = var_0.origin + (var_6, var_7, 0);
    var_9 = scripts\engine\trace::_bullet_trace(var_8 + (0, 0, 32), var_8 + (0, 0, -32), 0);
    var_2[var_2.size] = var_9["position"] + (0, 0, 1);
  }

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_10 = spawn("script_model", var_0.origin);
    var_10 setModel("s4_skulls_resource_model_01");
    var_11 = var_2[var_3];
    var_10 hide();
    var_10 thread launch_loot_piece(var_0.origin, var_11, var_0.pers["team"], var_3 * 0.05);
  }

  var_0.skullcount = 2;
  var_0 update_player_ui_skulls(var_0.skullcount);
}

launch_loot_piece(var_0, var_1, var_2, var_3) {
  var_4 = self;
  wait(var_3);
  var_4 show();
  var_5 = solvequadratic(-400.0, 400, 0)[1];
  var_6 = var_1[0] - var_0[0];
  var_7 = var_1[1] - var_0[1];
  var_8 = var_6 / var_5;
  var_9 = var_7 / var_5;
  var_4 movegravity((var_8, var_9, 400), var_5);
  var_4 _meth_82A1((1080, 1080, 0), var_5);
  wait(var_5);
  var_2 = scripts\mp\utility\game::_id_6BE2(var_2)[0];
  var_10 = _func_03C5("s4_skulls_resource_" + var_2, var_1, scripts\engine\utility::_id_5CD9(var_4.angles));
  var_4 delete();
}

solvequadratic(var_0, var_1, var_2) {
  var_3 = var_1 * var_1 - 4 * var_0 * var_2;
  var_4 = 0;
  var_5 = 0;

  if(var_3 > 0) {
    var_4 = (-1 * var_1 + _func_0218(var_3)) / (2 * var_0);
    var_5 = (-1 * var_1 - _func_0218(var_3)) / (2 * var_0);
  }

  return [var_4, var_5];
}

_id_ABC0() {
  var_0 = scripts\mp\gamescore::_id_6AA0();

  if(game["status"] == "overtime") {
    var_0 = "forfeit";
  } else if("tie") {
    var_0 = "overtime";
  }

  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"]["time_limit_reached"]);
}

_id_EF35() {
  thread scripts\mp\utility\debug::_id_4F48(level._id_9AAC, 128, 100, (0, 1, 0));

  if(!isDefined(level._id_EF39)) {
    waitframe();
  }

  var_0 = level._id_EF39._id_1773 * level._id_EF36;
  var_1 = level._id_EF39._id_1783 * level._id_EF38;
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC, level._id_9AAC + var_0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC, level._id_9AAC - var_0, 1000, (1, 0, 0));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC + var_0, level._id_9AAC + var_0 + var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC + var_0, level._id_9AAC + var_0 - var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC - var_0, level._id_9AAC - var_0 + var_1, 1000, (0, 0, 1));
  thread scripts\mp\utility\debug::_id_4F43(level._id_9AAC - var_0, level._id_9AAC - var_0 - var_1, 1000, (0, 0, 1));
}

_id_A117() {
  level endon("game_ended");
  level._id_ACCD = [];
  level._id_7AB6 = 0;
  var_0 = 0;
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    foreach(var_2 in level.players) {
      if(!isDefined(var_2._id_7AB8)) {
        var_2._id_7AB7 = 0;
        var_2._id_7AB8 = var_2.origin;
        var_2._id_0E13 = var_2.origin;
      }

      var_2._id_7AB7 = var_2._id_7AB7 + distancesquared(var_2._id_7AB8, var_2.origin);
      var_2._id_7AB8 = var_2.origin;
    }

    var_0 = var_0 + level._id_5F3A;

    if(var_0 > 3.0) {
      if(level._id_7AB6 >= 2) {
        level._id_7AB6 = 0;

        foreach(var_2 in level.players) {
          if(!isDefined(var_2._id_0E13)) {
            var_2._id_0E13 = var_2.origin;
          }

          var_2._id_5E74 = distancesquared(var_2._id_0E13, var_2.origin) < 4225;
          var_2._id_0E13 = var_2.origin;
        }
      }

      foreach(var_2 in level.players) {
        var_7 = var_2 getentitynumber();
        var_8 = var_2.pers["team"];

        if(var_8 == "allies") {
          var_9 = "axis";
        } else {
          var_9 = "allies";
        }

        if(isalive(var_2) && (istrue(var_2._id_5E74) || var_2._id_7AB7 < 4225 && !istrue(var_2._id_7AB9))) {
          var_2._id_5E74 = 0;

          if(!isDefined(level._id_ACCD[var_7])) {
            level._id_ACCD[var_7] = var_2;
            var_2._id_ACE8 = scripts\mp\utility\outline::_id_ACD2(var_2, var_8, "outline_nodepth_orange", "level_script");
            var_2._id_ACE7 = scripts\mp\utility\outline::_id_ACD2(var_2, var_9, "outline_nodepth_red", "level_script");
            var_2 scripts\mp\utility\outline::_id_0C2E("outlinefill_nodepth_orange", 0);
          }
        } else {
          if(isalive(var_2)) {
            var_2._id_7AB9 = 0;
          }

          var_2._id_5E74 = 0;

          if(isDefined(level._id_ACCD[var_7])) {
            scripts\mp\utility\outline::outlinedisable(var_2._id_ACE8, var_2);
            scripts\mp\utility\outline::outlinedisable(var_2._id_ACE7, var_2);
            var_2 scripts\mp\utility\outline::_id_0C2D();
            var_2._id_ACE8 = undefined;
            var_2._id_ACE7 = undefined;
            level._id_ACCD[var_7] = undefined;
          }
        }

        var_2._id_7AB7 = 0;
      }

      var_0 = 0;
    }

    level._id_7AB6++;
    waitframe();
  }
}

_id_AB03(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_10 = self getentitynumber();

  if(isDefined(level._id_ACCD[var_10])) {
    scripts\mp\utility\outline::outlinedisable(self._id_ACE8, self);
    scripts\mp\utility\outline::outlinedisable(self._id_ACE7, self);
    self._id_ACE8 = undefined;
    self._id_ACE7 = undefined;
    level._id_ACCD[var_10] = undefined;
  }

  self._id_7AB9 = 1;
}

_id_DB63() {
  var_0 = int(game["teamScores"]["axis"]);
  var_1 = int(game["teamScores"]["allies"]);
  var_2 = var_0 - var_1;
  return var_2 < 10;
}