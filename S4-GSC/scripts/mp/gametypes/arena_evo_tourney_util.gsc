/***********************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena_evo_tourney_util.gsc
***********************************************************/

_id_F70A() {
  var_0 = self;

  if(var_0 _id_DAA0()) {
    var_0 thread _id_C9DB();
  } else {
    var_0 scripts\mp\gametypes\arena_evo_tourney::_id_1AEF();
  }
}

_id_C9DB() {
  var_0 = self;
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0._id_1A5D = 0;
  var_0 _id_D353();

  if(scripts\mp\gametypes\arena_evo_tourney::_id_1AD8()) {
    return;
  }
  var_0._id_10843 = 1;
  _id_106F1();
  var_0 scripts\mp\gametypes\arena_evo_tourney::_id_1AEF(1);
}

_id_D353() {
  var_0 = self;
  var_0 _meth_8060();
  var_0 endon("disconnect");
  var_0 setclientomnvar("ui_arena_evo_unscheduled_buy", 0);
  var_0 setclientomnvar("ui_arena_evo_bye", 0);

  if(!istrue(level._id_1A7B)) {
    return;
  }
  initialize_intermission_view_if_not_defined();
  var_0 thread _id_CA27(var_0 getEye(), var_0 getplayerangles(), level._id_1A7A.origin, level._id_1A7A.angles);
}

initialize_intermission_view_if_not_defined() {
  if(!isDefined(level._id_1A7A)) {
    level._id_1A7A = spawn("script_model", (0, 0, 1000));
    level._id_1A7A setModel("tag_origin");
    _id_D261();
  }
}

_id_DAA0() {
  var_0 = self;

  if(scripts\mp\gametypes\arena_evo_tourney::_id_1AD8()) {
    return 0;
  }

  if(!istrue(level._id_CA43)) {
    return 0;
  }

  return 1;
}

_id_5217() {
  var_0 = self;
  var_0._id_9CCD = undefined;
}

set_player_respawn(var_0) {
  var_1 = self;
  var_1._id_9CCD = var_0;
}

_id_4A36() {
  var_0 = self;
  var_0._id_9CCD = 0;
}

_id_8675() {
  var_0 = self;
  return !isDefined(var_0._id_9CCD) || istrue(var_0._id_9CCD);
}

_id_6605(var_0) {
  var_1 = _id_66A9(var_0);
  var_2 = 0;

  foreach(var_4 in var_1) {
    if(var_4 _id_8675()) {
      var_2++;
    }
  }

  return var_2;
}

_id_FD43() {
  if(isPlayer(self)) {
    var_0 = scripts\engine\utility::ter_op(isDefined(self.pers["kills"]), self.pers["kills"], 0);
    var_1 = scripts\engine\utility::ter_op(isDefined(self.pers["assists"]), self.pers["assists"], 0);
    self setclientomnvar("ui_arena_evo_stat_ekia", var_0 + var_1);
  }
}

_id_FB86(var_0) {
  var_1 = _id_67BF(var_0) + 1;
  var_2 = _id_67C1(var_0);

  if(!isDefined(var_2)) {
    return;
  }
  var_3 = _id_67BF(var_2) + 1;
  var_4 = _func_00BE("ui_arena_match_score_team" + var_1);
  var_5 = _func_00BE("ui_arena_match_score_team" + var_3);
  var_6 = _id_86E2(var_0);
  var_7 = _id_86E2(var_2);

  if(!var_6 && (var_4 > var_5 || var_7)) {
    var_8 = 1;
  } else if(!var_7 && (var_4 < var_5 || var_6)) {
    var_8 = 2;
  } else {
    var_8 = 0;
  }

  var_9 = _id_6603() + 1;
  var_10 = _id_66A9(var_0);

  foreach(var_12 in var_10) {
    var_12 setclientomnvar("ui_arena_match_result" + var_9, var_8);
  }

  var_14 = 0;

  if(var_8 == 2) {
    var_14 = 1;
  } else if(var_8 == 1) {
    var_14 = 2;
  }

  var_15 = _id_66A9(var_2);

  foreach(var_12 in var_15) {
    var_12 setclientomnvar("ui_arena_match_result" + var_9, var_14);
  }
}

_id_FB38() {
  foreach(var_1 in _id_633A()) {
    _id_FB86(var_1);
  }

  level.were_any_teams_eliminated_this_match = _id_67C9().size > 0;
}

_id_C5A4(var_0) {
  var_1 = _id_633A();

  foreach(var_3 in var_1) {
    for(var_4 = 1; var_4 <= var_0; var_4++) {
      var_5 = var_4;
      var_6 = _id_66A9(var_3);

      foreach(var_8 in var_6) {
        var_8 setclientomnvar("ui_arena_match_result" + var_5, 0);
      }
    }
  }
}

_id_106CC(var_0, var_1) {
  level notify("wait_and_update_countdown_timer");
  level endon("wait_and_update_countdown_timer");

  for(var_2 = 0; var_2 < var_0; var_2++) {
    _id_D361(var_1 - var_2);
    wait 1;
  }
}

_id_10A84() {
  var_0 = istrue(level._id_7D76);
  level._id_7D76 = 0;
  var_1 = 4;
  var_2 = scripts\engine\utility::ter_op(istrue(level.were_any_teams_eliminated_this_match), 6, 4);
  var_3 = 7;
  var_4 = _id_6711() == 1;
  var_5 = !isDefined(level._id_A76F) || level._id_A76F == 0;
  var_6 = var_4 && var_5;
  var_7 = !var_6 && !var_0;
  var_8 = var_6;
  var_9 = 0;

  if(var_7) {
    var_9 = var_9 + var_2;
  }

  if(var_8) {
    var_9 = var_9 + var_1;
  }

  var_9 = var_9 + var_3;
  _id_D361(var_9);

  if(var_8) {
    _func_01EA("ui_arena_ui_state", 14);
    _id_106CC(var_1, var_9);
    var_9 = var_9 - var_1;
  }

  if(var_7) {
    _func_01EA("ui_arena_ui_state", 0);
    _id_106CC(var_2, var_9);
    var_9 = var_9 - var_2;
  }

  var_10 = scripts\engine\utility::ter_op(var_5 && !var_8, 7, 1);
  _func_01EA("ui_arena_ui_state", var_10);

  foreach(var_12 in level.players) {
    var_13 = var_9 - 3;

    if(var_13 < 0) {
      var_13 = var_9;
    }

    var_12 scripts\engine\utility::delaythread(var_13, ::_id_110EF);
  }

  _id_106CC(var_3, var_9);
  level thread scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_0E9A();
  level._id_1A8E = 1;
}

_id_10753() {
  level._id_1A8E = 0;
  level thread _id_10A84();

  while(!istrue(level._id_1A8E)) {
    waitframe();
  }

  _func_01EA("ui_match_start_countdown", -1);
  _func_01EA("ui_arena_ui_state", 6);
  setomnvar("ui_match_start_text", "waiting_for_players");
}

_id_D3EC() {
  var_0 = _id_6711();
  setomnvar("ui_arena_round_index", var_0);
  var_1 = _id_6583();
  setomnvar("ui_arena_match_display_index", var_1);
  setomnvar("ui_arena_matches_until_buy_round", _id_6586());
  _id_81D7();
  var_2 = [];
  var_3 = 1;

  foreach(var_5 in _id_633A()) {
    var_2[var_5] = var_3;
    var_6 = level._id_1AC2[var_5];

    if(_id_86E2(var_5)) {
      setomnvar("ui_arena_score" + var_3, -1);
    } else {
      setomnvar("ui_arena_score" + var_3, var_6);
    }

    foreach(var_8 in _id_66A9(var_5)) {
      var_8 setclientomnvar("ui_arena_player_team", var_3);
      _id_D354(var_8, var_5);
    }

    var_3++;
  }

  foreach(var_5 in _id_633A()) {
    var_3 = var_2[var_5];
    var_12 = _id_67C1(var_5);

    if(isDefined(var_12)) {
      setomnvar("ui_arena_matchup" + var_3, var_2[var_12]);
      continue;
    }

    setomnvar("ui_arena_matchup" + var_3, 0);
  }

  if(isDefined(level._id_1A6D)) {
    var_14 = 1;

    foreach(var_16 in level._id_1A6D) {
      var_3 = 1;

      foreach(var_5 in _id_633A()) {
        if(var_5 == var_16) {
          setomnvar("ui_arena_elim_order" + var_14, var_3);
          break;
        }

        var_3++;
      }

      var_14++;
    }
  }

  foreach(var_8 in level.players) {
    var_21 = var_8 _id_661A();

    if(isDefined(var_21)) {
      var_8 setclientomnvar("ui_arena_opponent", var_2[var_21]);
      continue;
    }

    var_8 setclientomnvar("ui_arena_opponent", 0);
  }
}

_id_D354(var_0, var_1) {
  var_2 = level._id_EF6A[var_1]["upcomingMatchups"];

  for(var_3 = 0; var_3 < 8; var_3++) {
    if(var_3 < var_2.size) {
      var_4 = _id_67BF(var_2[var_3]) + 1;
    } else {
      var_4 = 0;
    }

    var_0 setclientomnvar("ui_arena_clientmatchup" + (var_3 + 1), var_4);
  }

  var_5 = _id_6603();
  var_0 setclientomnvar("ui_arena_clientmatchup_index", var_5);
}

_id_7409() {
  if(istrue(level.final_bye_round_active)) {
    level._id_5A5A = 1;
    level._id_1A74 = 1;
  }

  _id_FB38();
  _id_100F();

  foreach(var_1 in _id_633A()) {
    var_2 = _id_66A9(var_1);
    level notify("end_uav_" + var_1);

    foreach(var_4 in var_2) {
      if(_id_86E2(var_4)) {
        if(istrue(var_4.isspectating)) {
          var_4 scripts\mp\gametypes\arena_evo_tourney::_id_1ACE();
        }

        continue;
      }

      arenatournament_dlog_record_end_of_round(var_4);
      var_4._id_1AA2 = undefined;
      var_4 thread scripts\mp\gametypes\arena_evo_tourney_gameplay_modifiers::_id_1ACA();
      var_4 scripts\mp\gametypes\arena_evo_tourney_loot::_id_B3F5();
      var_4 _id_5217();
      var_4.arenaevoafk_eliminationsthisround = var_4.pers["kills"] + var_4.pers["assists"];

      if(istrue(var_4.isspectating)) {
        var_4 notify("exit_spectate_listener");
        var_4 scripts\mp\gametypes\arena_evo_tourney::_id_1ACE();
      }

      var_5 = var_4 _meth_876E("ui_arena_match_result" + _id_6603());
      var_6 = var_5 == 1;

      if(var_6) {
        var_7 = getdvarint("#x38c4dc97c5a288551", 1000);
        scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AC6(var_4, var_7, "arena_evo_match_won");
        var_4 thread _id_0A8D::_id_9137("arena_evo_took_points_from_enemy");
      } else if(var_5 == 2)
        var_4 thread _id_0A8D::_id_9137("arena_evo_enemy_took_your_points");

      var_4 _id_1AFD(0);
    }
  }

  _func_0140("Champion Hill - New Round Start");

  if(shouldadjusttimerforfinalmatchup()) {
    level.arena_evo_final_matchup_time_limit = getdvarint("#x3d9cc516d435eee0", 120);
    level.arena_evo_num_matches_until_buy_round = 1;
  }

  _id_A44E();

  foreach(var_11 in level._id_1A86) {
    level thread[[var_11]]();
  }

  _id_38AC();
  _id_D21F();

  foreach(var_1 in _id_633A()) {
    var_2 = _id_66A9(var_1);

    foreach(var_4 in var_2) {
      var_4 _id_38B5();

      if(!_id_86E2(var_4)) {
        if(isDefined(var_4._id_9457)) {
          var_4._id_9458 = var_4._id_9457;
        }

        var_4 scripts\mp\gametypes\arena_evo_tourney::_id_1AF2();
      }
    }
  }

  level thread reenable_arena_evo_spawns();
  level thread scripts\mp\gametypes\arena_evo_tourney::_id_1AF4();
}

reenable_arena_evo_spawns() {
  var_0 = 3.0;
  level scripts\engine\utility::_id_108F5("respawns_started", var_0);
  waitframe();
  level._id_1A83 = 0;
}

shouldadjusttimerforfinalmatchup() {
  if(_id_67CA().size > 2) {
    return 0;
  }

  if(_id_88CF()) {
    return 0;
  }

  return 1;
}

freezetimers() {
  level._id_1A75 = 1;
}

_id_C9B2() {
  var_0 = get_time_limit_for_match();

  if(_id_88C3()) {
    level thread _id_CA3A();
  }

  var_1 = 0;
  setomnvar("ui_match_start_text", "match_in_progress");
  _id_D287(var_0);
  level._id_4AE7 = 0;

  for(level._id_1A87 = 0; level._id_1A87 < var_0; level._id_1A87++) {
    if(scripts\mp\gametypes\arena_evo_tourney::_id_1AD8()) {
      level._id_1A87 = 0;
      break;
    }

    if(istrue(level._id_1A75) || getdvarint("#x33aa24fb737fd5555", 0)) {
      level._id_1A87 = 0;
      _id_D287(-1);
    }

    wait 1;

    if(level._id_1A87 >= var_0 - 5 - 1) {
      level._id_1A83 = 1;
      level._id_4AE7 = 1;

      foreach(var_3 in level.players) {
        if(isDefined(var_3._id_E277)) {
          var_3 notify("kill_handle_move_to_blended");
          var_3 thread _id_0815::_id_4790();
        }
      }
    }

    if(level._id_1A87 >= var_0 - 10 - 1) {
      if(!istrue(var_1)) {
        var_1 = 1;

        foreach(var_3 in level.players) {
          thread _id_07F8::_id_9BC3(var_3);

          if(!_id_88CF() || !isDefined(level._id_BB9D)) {
            var_3 thread _id_0A8D::_id_9137("10_seconds", "chvo", 1);
            continue;
          }

          var_3 thread _id_0A8D::_id_9137("buy_round_10_seconds");
        }
      }
    }
  }

  _id_D287(-1);

  if(_id_88C3()) {
    _id_E90B();
  }
}

get_time_limit_for_match() {
  var_0 = getdvarint("#x375cf8e26bd54c1e4", 60);

  if(_id_88CF()) {
    var_0 = getdvarint("#x3e4b186337df5ece5", 30);
  } else if(isDefined(level.arena_evo_final_matchup_time_limit)) {
    var_0 = level.arena_evo_final_matchup_time_limit;
  }

  return var_0;
}

_id_88C3() {
  return istrue(level.final_bye_round_active);
}

_id_CA3A() {
  level endon("StopFinalByeRoundCelebration");

  for(;;) {
    for(var_0 = 0; var_0 < level._id_1ABF.size; var_0++) {
      _id_B22F(level._id_1ABF[var_0]);
      wait 5;
    }
  }
}

_id_E90B() {
  level notify("StopFinalByeRoundCelebration");
}

_id_64B9() {
  if(_id_88CF()) {
    return getdvarint("#x3e4b186337df5ece5", 30);
  } else {
    return getdvarint("#x375cf8e26bd54c1e4", 60);
  }
}

_id_100F() {
  if(!isDefined(level._id_A76F)) {
    level._id_A76F = 0;
  }

  if(!isDefined(level._id_A770)) {
    level._id_A770 = 0;
  }

  if(!isDefined(level.number_completed_red_robin_matches_total_no_buy_rounds)) {
    level.number_completed_red_robin_matches_total_no_buy_rounds = 0;
  }

  level._id_A76F++;
  level._id_A770++;

  if(!_id_88CF()) {
    level.number_completed_red_robin_matches_total_no_buy_rounds++;
  }
}

_id_6603(var_0, var_1) {
  if(!isDefined(level._id_A76F)) {
    level._id_A76F = 0;
  }

  if(!isDefined(level._id_A770)) {
    level._id_A770 = 0;
  }

  if(!isDefined(level.number_completed_red_robin_matches_total_no_buy_rounds)) {
    level.number_completed_red_robin_matches_total_no_buy_rounds = 0;
  }

  if(istrue(var_1)) {
    return level.number_completed_red_robin_matches_total_no_buy_rounds;
  }

  if(istrue(var_0)) {
    return level._id_A770;
  }

  return level._id_A76F;
}

_id_6711() {
  if(!isDefined(level._id_1A68)) {
    return 1;
  }

  return level._id_1A68;
}

_id_6583() {
  return _id_6603(1) + 1;
}

_id_6586() {
  if(_id_88CF()) {
    return 0;
  }

  if(!isDefined(level.arena_evo_last_buy_round)) {
    var_0 = level.arena_evo_num_matches_until_buy_round - _id_6603(1);
  } else {
    var_1 = _id_6603(1) - level.arena_evo_last_buy_round;
    var_0 = level.arena_evo_num_matches_until_buy_round + 1 - var_1;
  }

  if(var_0 < 0) {
    var_0 = 0;
  }

  return var_0;
}

_id_106F1() {
  level notify("run_intermission");

  while(istrue(level._id_CA43)) {
    waitframe();
  }
}

_id_3463() {
  while(!isDefined(level.players)) {
    waitframe();
  }

  while(level.players.size == 0) {
    waitframe();
  }

  var_0 = gettime();
  var_1 = getdvarint("#x3f4fa4950a9dd7376", 10) * 1000;

  if(!istrue(level._id_1A79)) {
    while(_id_67CB(1) != _id_633A().size) {
      var_2 = gettime() - var_0;

      if(var_2 > var_1) {
        break;
      }

      _id_D361(int((var_1 - var_2) / 1000));
      waitframe();
    }

    level._id_1A79 = 1;
  }
}

_id_10A42() {
  level endon("game_ended");
  _id_1073D();
  _id_3463();
  var_0 = gettime();
  var_1 = getdvarint("#x3b96dbbf48fd99974", 5000);

  while(!_id_8552()) {
    if(var_1 >= 0 && gettime() - var_0 > var_1) {
      break;
    }

    waitframe();
  }

  level._id_1A70 = 1;
}

_id_C9F0() {
  level notify("run_prematch_purchase_round");
  level endon("run_prematch_purchase_round");

  if(!istrue(level._id_1A7C)) {
    level._id_1A7C = 1;
    level thread _id_C9DC();
  }

  while(!istrue(level._id_1A7B)) {
    waitframe();
  }

  _id_1A8B("arena_evo_player_state_loot_round");

  foreach(var_1 in level.players) {
    var_1 _id_1A8A("arena_evo_player_state_loot_round");
  }

  _func_01EA("ui_arena_ui_state", 13);

  if(getdvarint("#x3438ace35ce03afb0", 0)) {
    level waittill("forever");
  }

  var_3 = getdvarint("#x3d7cd988f37458e1e", 45);
  _id_D361(var_3);
  var_4 = getdvarfloat("#x3369d6f9b80f250fa", 0.0);
  var_5 = var_4 + getdvarfloat("#x37c468793c1f500e1", 3.0);
  var_6 = var_5 + getdvarfloat("#x33b889c457bfc09b8", 4.0);
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = var_3 >= 20;

  if(!var_10) {
    foreach(var_12 in level._id_1A7D) {
      _func_0186(var_12);
    }
  }

  for(var_14 = 0; var_14 <= var_3; var_14++) {
    if(var_10) {
      if(var_14 >= var_4 && !var_7) {
        _id_B268("intro_buy_dialog_01");

        foreach(var_12 in level._id_1A7D) {
          _func_0186(var_12);
        }

        var_7 = 1;
      }

      if(var_14 >= var_5 && !var_8) {
        _id_B268("intro_buy_dialog_02");
        var_8 = 1;
      }

      if(var_14 >= var_6 && !var_9) {
        _id_B268("intro_buy_dialog_03");
        var_9 = 1;
      }
    }

    wait 1;

    if(var_3 - var_14 == 10) {
      _id_B268("intro_buy_dialog_04");
    }

    _id_D361(var_3 - var_14);

    if(istrue(level._id_1A75)) {
      level waittill("forever");
    }
  }

  foreach(var_12 in level._id_1A7D) {
    _func_0172(var_12, 0);
    _func_0173(var_12, 0);
    _func_018B(var_12);
  }

  kickconnectingplayersandeliminateemptyteams();

  if(_id_67CA().size == 2) {
    level.arena_evo_skip_final_buy_round = 1;
  }

  _id_A44E();
  _id_D3EC();
  _id_1A8B("arena_evo_player_state_intermission");
  level._id_BB9D = 1;

  foreach(var_1 in level.players) {
    var_1 scripts\mp\gametypes\arena_evo_tourney::_id_1AF2();
  }
}

kickconnectingplayersandeliminateemptyteams() {
  foreach(var_1 in _id_633A()) {
    var_2 = _id_66A9(var_1);

    foreach(var_4 in var_2) {
      if(!istrue(var_4._id_75B4)) {
        var_4.waskicked = 1;
        kick(var_4 getentitynumber(), "EXE/PLAYERKICKED_INACTIVE", 1);
      }
    }

    if(_id_66A9(var_1).size == 0) {
      _id_D3DF([var_1], 1);
    }
  }
}

_id_110EF() {
  var_0 = self;
  initialize_intermission_view_if_not_defined();
  var_0 thread _id_CA27(level._id_1A7A.origin, level._id_1A7A.angles, var_0 getEye(), var_0 getplayerangles(), 1);
  thread _id_07F8::matchbeginmusicfromcountdown(var_0);
}

_id_CA27(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_5 notify("RunCameraSlam");
  var_5 endon("RunCameraSlam");
  var_5 endon("disconnect");

  if(_id_86E2(var_5)) {
    if(isDefined(var_5._id_2FF7)) {
      var_5._id_2FF7 delete();
    }

    return;
  }

  if(!isDefined(var_5._id_2FF7)) {
    var_6 = spawn("script_model", var_0);
    var_6 setModel("tag_origin");
    var_5._id_2FF7 = var_6;
  }

  var_5._id_2FF7.angles = var_1;
  var_5 cameralinkto(var_5._id_2FF7, "tag_origin", 1, 1);
  var_5._id_2FF7 moveto(var_2, 1);
  var_5._id_2FF7 rotateto(var_3, 1);

  if(istrue(var_4)) {
    wait 1;
    var_5 _meth_8060();
    var_5._id_2FF7 delete();
  }
}

_id_B268(var_0) {
  foreach(var_2 in level.players) {
    var_2 playlocalsound(game["dialog"][var_0]);
  }
}

_id_C9DC() {
  if(getdvarint("#x360ae3325782293e8", 0)) {
    level._id_1A7B = 1;
    return;
  }

  var_0 = getdvarfloat("#x3748deaf948a24dc3", 4.0);
  var_1 = getdvarfloat("#x3fe3f2b038255fae0", 3.0);
  var_2 = getdvarfloat("#x3909a20d5808b769", 3.0);
  var_3 = getdvarfloat("#x35695bbc056ace12e", 3.5);
  _func_01EA("ui_arena_ui_state", 9);
  _id_B268("intro_dialog_00");
  wait(var_0);
  _func_01EA("ui_arena_ui_state", 10);
  _id_B268("intro_dialog_01");
  wait(var_1);
  _func_01EA("ui_arena_ui_state", 11);
  _id_B268("intro_dialog_02");
  wait(var_2);
  _func_01EA("ui_arena_ui_state", 12);
  _id_B268("intro_dialog_03");
  wait(var_3);
  level._id_1A7B = 1;
}

_id_8552() {
  var_0 = _id_67CA();

  foreach(var_2 in var_0) {
    var_3 = _id_66A9(var_2);

    foreach(var_5 in var_3) {
      if(!istrue(var_5._id_10843)) {
        return 0;
      }
    }
  }

  return 1;
}

_id_D21F() {
  level._id_1A70 = 0;
  level._id_CA43 = 1;
}

_id_D330(var_0) {
  var_1 = self.pers["team"];
  var_2 = _id_67BF(var_1) + 1;

  if(!isDefined(level._id_EF41)) {
    level._id_EF41 = [];
  }

  level._id_EF41[var_1] = var_0;

  if(isDefined(var_0)) {
    setomnvar("ui_arena_location_team" + var_2, var_0.arena_index);
  } else {
    setomnvar("ui_arena_location_team" + var_2, 0);
  }
}

_id_6661() {
  if(!isDefined(level._id_EF41)) {
    return undefined;
  }

  if(!isDefined(level._id_EF41[self.pers["team"]])) {
    return undefined;
  }

  return level._id_EF41[self.pers["team"]];
}

_id_67B9(var_0) {
  if(isDefined(level._id_EF41)) {
    return level._id_EF41[var_0];
  } else {
    return undefined;
  }
}

_id_38B5() {
  _id_D330(undefined);
}

_id_66A5(var_0) {
  var_1 = [];

  foreach(var_3 in level.players) {
    if(!scripts\engine\utility::is_equal(var_0, var_3 _id_6661())) {
      continue;
    }
    var_1[var_1.size] = var_3;
  }

  return var_1;
}

_id_661A() {
  return _id_67C1(self.pers["team"]);
}

_id_81C6(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_1465)) {
    var_4 = _id_0817::_id_6D4E(level._id_1518);
    var_5 = _id_0817::_id_6D4E(level._id_1FEF);
    var_6 = _id_0817::_id_6D4E("mp_tdm_spawn");
    var_7 = _id_0817::_id_6D4E("mp_tdm_spawn_secondary");
    var_8 = _id_0817::_id_6D4E("mp_dom_spawn");
    level._id_1465 = scripts\engine\utility::array_combine(var_4, var_5, var_6, var_8, var_7);
  }

  var_9 = scripts\engine\utility::getstruct(var_0, "targetname");

  if(!isDefined(var_9._id_E363)) {
    var_9._id_E363 = [];
  }

  foreach(var_11 in level._id_1465) {
    if(var_11.target == var_9._id_0481) {
      if(!isDefined(var_9._id_E363[var_11.classname])) {
        var_9._id_E363[var_11.classname] = [];
      }

      var_9._id_E363[var_11.classname] = ::scripts\engine\utility::array_add(var_9._id_E363[var_11.classname], var_11);
    }
  }

  var_9._id_228A = scripts\engine\utility::_id_6369(var_9.origin, scripts\engine\utility::getStructArray("red_barrel_explode_struct", "targetname"), undefined, 1000);

  foreach(var_14 in var_9._id_228A) {
    var_14[[level._id_227B]]();
  }

  var_9._id_EFA0 = [];
  var_9._id_EFA2 = [];
  var_9._id_9C39 = var_1;
  var_9._id_EF42 = var_1;
  var_9.players = [];
  var_9._id_62A9 = var_2;
  var_9._id_3085 = spawn("script_model", var_9.origin);
  var_9._id_3085 setModel("tag_origin");
  var_9._id_5B97 = scripts\engine\utility::getstruct(var_9._id_0481, "script_noteworthy");
  var_9.arena_index = var_3;
  var_16 = getEntArray("arena_evo_grenade_volume", "targetname");
  var_9.arenavolume = scripts\engine\utility::_id_6969(var_9.origin, var_16);
  var_9._id_3085.origin = var_9._id_3085.origin + (0, 1500, 2000);
  var_9._id_3085.angles = vectortoangles(var_9.origin - var_9._id_3085.origin);
  level._id_1ABF[level._id_1ABF.size] = var_9;
}

_id_C1CC(var_0) {
  if(!isDefined(level._id_1A86)) {
    level._id_1A86 = [];
  }

  level._id_1A86[level._id_1A86.size] = var_0;
}

_id_46F1() {
  if(!isDefined(level._id_146A)) {
    return;
  }
  level._id_146A = scripts\engine\utility::_id_1BD1(level._id_146A);

  foreach(var_1 in level._id_146A) {
    var_1 delete();
  }
}

_id_F3DC() {
  var_0 = self;
  var_0 thread _id_F3DD();
}

_id_F3DD() {
  var_0 = self;
  var_0 endon("disconnect");
  var_0 notify("track_grenade_usage_internal");
  var_0 endon("track_grenade_usage_internal");

  for(;;) {
    var_0 waittill("grenade_fire", var_1, var_2);
    var_0 thread scripts\mp\gametypes\arena_evo_tourney::arena_evo_projectile_tracking(var_1);

    if(!isDefined(level._id_146A)) {
      level._id_146A = [];
    }

    level._id_146A[level._id_146A.size] = var_1;
    level._id_146A = scripts\engine\utility::_id_1BD1(level._id_146A);
  }
}

_id_65D9(var_0) {
  var_1 = var_0;

  if(!isDefined(_id_6661())) {
    var_2 = _id_6377(var_1);
  } else {
    var_2 = _id_6661();
  }

  if(!isDefined(var_2)) {
    return undefined;
  }

  if(!istrue(self._id_1AA2)) {
    var_3 = _id_637C(var_2);
  } else {
    var_3 = _id_1A76(self, var_2);
  }

  var_4 = spawnStruct();
  var_4._id_1A5C = var_2;
  var_4._id_03E9 = var_3;
  return var_4;
}

_id_1A76(var_0, var_1) {
  var_2 = scripts\engine\utility::array_combine(var_1._id_E363["mp_tdm_spawn"], var_1._id_E363["mp_tdm_spawn_secondary"]);
  var_3 = undefined;
  var_4 = self.pers["team"];
  var_5 = _id_67C1(var_4);
  var_6 = _id_66A9(var_4);
  var_7 = _id_66A9(var_5);
  var_8 = [];
  var_9 = [];

  foreach(var_11 in var_7) {
    var_12 = get_player_origin_check(var_11);

    if(!isDefined(var_12)) {
      continue;
    }
    if(!isDefined(var_12)) {
      continue;
    }
    var_8[var_8.size] = var_12;
    var_9[var_9.size] = var_11;
    var_13 = _id_65A4();
    var_14 = scripts\engine\utility::_id_6369(var_12, var_2, undefined, undefined, var_13);
    var_2 = scripts\engine\utility::_id_1BBF(var_2, var_14);
  }

  foreach(var_17 in var_6) {
    var_18 = get_player_origin_check(var_17);

    if(!isDefined(var_18)) {
      continue;
    }
    if(scripts\engine\utility::is_equal(var_17, self)) {
      continue;
    }
    foreach(var_20 in var_2) {
      if(distance2d(var_18, var_20.origin) < 64) {
        var_2 = scripts\engine\utility::array_remove(var_2, var_20);
      }
    }
  }

  if(var_8.size == 0) {
    var_8 = [var_1.origin];
  }

  var_23 = _func_0016(var_8);
  var_2 = _func_0204(var_2, var_23);

  if(var_2.size >= 3) {
    var_3 = scripts\engine\utility::random([var_2[var_2.size - 1], var_2[var_2.size - 2], var_2[var_2.size - 3]]);
  } else if(var_2.size >= 2) {
    var_3 = scripts\engine\utility::random([var_2[var_2.size - 1], var_2[var_2.size - 2]]);
  } else if(var_2.size >= 1) {
    var_3 = var_2[var_2.size - 1];
  } else {
    var_2 = scripts\engine\utility::array_combine(var_1._id_E363["mp_tdm_spawn"], var_1._id_E363["mp_tdm_spawn_secondary"]);
    var_2 = _func_0204(var_2, var_23);
    var_3 = var_2[var_2.size - 1];
  }

  return var_3;
}

get_player_origin_check(var_0) {
  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    return var_0.origin;
  }

  if(var_0 scripts\mp\utility\player::_id_88C7()) {
    return undefined;
  }

  if(isDefined(self._id_E293) && isDefined(self._id_E293._id_E332)) {
    return self._id_E293._id_E332;
  }

  return var_0.origin;
}

_id_65A4() {
  var_0 = getdvarint("#x36040065c1bd12625", 1100);
  return var_0;
}

_id_637C(var_0) {
  var_1 = level._id_1518;
  var_2 = self.pers["team"];

  for(var_3 = 0; var_3 < var_0._id_EFA2.size; var_3++) {
    if(scripts\engine\utility::is_equal(var_0._id_EFA2[var_3], var_2)) {
      var_1 = level._id_1A91[var_3];
    }
  }

  return var_0._id_E363[var_1][_id_6696(self)];
}

_id_38AC() {
  foreach(var_1 in _id_6325()) {
    var_1 _id_38B7();
    var_1._id_5BD4 = undefined;
  }
}

_id_38B7() {
  var_0 = self;
  var_0._id_EFA0 = [];
  var_0._id_EFA2 = [];
  var_0.players = [];
}

_id_6377(var_0) {
  var_1 = _id_6325();

  if(getdvarint("#x353e18d53c0796264", 1)) {
    var_1 = scripts\engine\utility::array_randomize(var_1);
  }

  if(!isDefined(level._id_BC2A)) {
    level._id_BC2A = [];
  }

  var_1 = _id_E020(var_0, var_1);
  var_2 = undefined;

  foreach(var_4 in var_1) {
    var_5 = _id_18FA(var_4, var_1, var_0);

    if(isDefined(var_5)) {
      var_2 = var_5;
      continue;
    }

    if(_id_1A9A(var_4)) {
      var_2 = var_4;
      break;
    } else if(_id_147B(var_4) && _id_1A99(var_4, var_0)) {
      var_2 = var_4;
      break;
    } else if(!_id_147B(var_4) && _id_DA6F(var_4, var_0)) {
      var_2 = var_4;
      break;
    }
  }

  var_2._id_EFA0[var_0] = "claimed";
  level._id_BC2A[var_0] = var_2._id_62A9;

  if(!scripts\engine\utility::array_contains(var_2._id_EFA2, var_0)) {
    var_2._id_EFA2[var_2._id_EFA2.size] = var_0;
  }

  return var_2;
}

_id_E020(var_0, var_1) {
  var_2 = [];
  var_3 = [];
  var_4 = [];
  var_5 = level._id_BC2A[_id_67C1(var_0)];

  foreach(var_7 in var_1) {
    if(scripts\engine\utility::is_equal(level._id_BC2A[var_0], var_7._id_62A9)) {
      var_3[var_3.size] = var_7;
      continue;
    }

    if(scripts\engine\utility::is_equal(var_5, var_7._id_62A9)) {
      var_4[var_4.size] = var_7;
      continue;
    }

    var_2[var_2.size] = var_7;
  }

  var_2 = scripts\engine\utility::array_combine(var_2, var_3, var_4);
  return var_2;
}

_id_DA6F(var_0, var_1) {
  if(_id_1A99(var_0, var_1)) {
    return 1;
  }

  if(_id_1A98(var_0, var_1)) {
    return 1;
  }

  return 0;
}

_id_18FA(var_0, var_1, var_2) {
  foreach(var_4 in var_1) {
    if(scripts\engine\utility::is_equal(var_4, var_0)) {
      continue;
    }
    if(_id_1A98(var_4, var_2)) {
      return var_4;
    }

    if(_id_1A99(var_4, var_2)) {
      return var_4;
    }
  }
}

_id_1A98(var_0, var_1) {
  if(!isDefined(level._id_EF6A[var_1]["upcomingMatchups"])) {
    return 0;
  }

  return isDefined(var_0._id_EFA0[_id_67C1(var_1)]);
}

_id_1A96(var_0) {
  var_1 = [];

  foreach(var_4, var_3 in var_0._id_EFA0) {
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_1A9A(var_0) {
  return var_0._id_EFA0.size == 0;
}

_id_1A99(var_0, var_1) {
  return isDefined(var_0._id_EFA0[var_1]);
}

_id_147B(var_0) {
  return var_0._id_EFA0.size >= var_0._id_9C39;
}

_id_6325() {
  return level._id_1ABF;
}

_id_6326() {
  var_0 = [];

  foreach(var_2 in level.players) {
    var_3 = var_2 _id_6661();

    if(!_id_86E2(var_2.pers["team"]) && isDefined(var_3) && !scripts\engine\utility::array_contains(var_0, var_3)) {
      var_0[var_0.size] = var_3;
    }
  }

  return var_0;
}

_id_67C8(var_0) {
  var_1 = _id_66A5(var_0);
  var_2 = [];

  foreach(var_4 in var_1) {
    var_2[var_4.pers["team"]] = var_4.pers["team"];
  }

  return var_2;
}

_id_633A() {
  return level._id_EF89;
}

_id_6328() {
  var_0 = _id_67CA();
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = 1;
    var_5 = _id_66A9(var_3);

    if(_id_1472(var_5)) {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_67CA() {
  var_0 = [];

  foreach(var_2 in _id_633A()) {
    if(_id_86E2(var_2)) {
      continue;
    }
    var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_633B() {
  return scripts\engine\utility::_id_1BBF(_id_633A(), _id_67CA());
}

_id_650F(var_0) {
  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] = _id_67BF(var_0[var_1]);
  }

  return var_0;
}

_id_66A9(var_0) {
  var_1 = level._id_EF6A[var_0]["players"];
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!istrue(var_4.waskicked)) {
      var_2[var_2.size] = var_4;
    }
  }

  return var_2;
}

_id_6696(var_0) {
  var_1 = _id_66A9(var_0.pers["team"]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(scripts\engine\utility::is_equal(var_0, var_1[var_2])) {
      return var_2;
    }
  }

  return -1;
}

_id_67CB(var_0) {
  var_1 = 0;
  var_2 = 0;
  var_3 = _id_6780();

  if(istrue(var_0)) {
    var_2 = var_3;
  }

  foreach(var_5 in _id_633A()) {
    if(_id_66A9(var_5).size >= var_2) {
      var_1++;
    }
  }

  return var_1;
}

_id_DAA4(var_0, var_1) {
  if(_id_86E2(var_0)) {
    return 0;
  }

  if(istrue(var_1)) {
    if(_id_66A9(var_0).size == 0) {
      return 1;
    }
  }

  return 0;
}

_id_6780() {
  var_0 = getdvarint("#x3db5d3184a15d696d", 0);
  var_1 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_teamcount"), -1);
  return int(var_0 / var_1);
}

_id_C441(var_0, var_1, var_2) {
  _id_81D7(var_0);

  if(var_1 > 0 && istrue(level._id_1A9C)) {
    var_1 = var_1 * 2;
  }

  var_3 = level._id_1AC2[var_0];
  level._id_1AC2[var_0] = level._id_1AC2[var_0] - var_1;

  if(level._id_1AC2[var_0] < 0) {
    level._id_1AC2[var_0] = 0;
  }

  if(level._id_1AC2[var_0] > getdvarint("#x32ae7460af7e83048", 12)) {
    level._id_1AC2[var_0] = getdvarint("#x32ae7460af7e83048", 12);
  }

  var_4 = 0;

  if(istrue(var_2)) {
    level._id_1AC2[var_0] = -1;
    var_4 = 1;
  } else
    var_4 = level._id_1AC2[var_0] == 0 && (istrue(var_2) || getdvarint("#x33ad69175e1f60fa6", 1) == 0 || _id_6605(var_0) == 0);

  if(var_4) {
    if(!isDefined(level._id_1AC3)) {
      level._id_1AC3 = [];
    }

    if(!isDefined(level._id_1AC3[var_0])) {
      level._id_1AC3[var_0] = level._id_1AC3.size;
    }
  }

  if(_id_6714(var_0) == 1) {
    level thread _id_0A8D::_id_9139("last_life", _id_66A9(var_0));
  }

  foreach(var_6 in _id_66A9(var_0)) {
    var_6 setclientomnvar("ui_arena_no_respawning", level._id_1AC2[var_0] == 0);
  }

  var_8 = 1;

  foreach(var_10 in _id_633A()) {
    if(var_10 == var_0) {
      setomnvar("ui_arena_score" + var_8, int(max(0, level._id_1AC2[var_0])));
      break;
    }

    var_8++;
  }
}

_id_6714(var_0) {
  _id_81D7(var_0);
  return level._id_1AC2[var_0];
}

_id_6364() {
  var_0 = _id_66A5(_id_6661());
  var_1 = [];
  var_1["team_alive_count"] = 0;
  var_1["opponents"] = [];
  var_1["teammates"] = [];
  var_1["arena"] = _id_6661();
  var_1["teams"] = [];
  var_1["teams"][self.pers["team"]] = 1;
  var_1["alive_enemy_teams"] = [];

  foreach(var_3 in var_0) {
    var_4 = scripts\engine\utility::is_equal(var_3.pers["team"], self.pers["team"]);

    if(var_4) {
      var_1["teammates"] = ::scripts\engine\utility::array_add(var_1["teammates"], var_3);

      if(scripts\mp\utility\player::isreallyalive(var_3)) {
        var_1["team_alive_count"]++;
      }
    } else {
      var_1["opponents"] = ::scripts\engine\utility::array_add(var_1["opponents"], var_3);

      if(scripts\mp\utility\player::isreallyalive(var_3)) {
        var_1["alive_enemy_teams"][var_3.pers["team"]] = 1;
      }
    }

    if(!isDefined(var_1["teams"][var_3.pers["team"]])) {
      var_1["teams"][var_3.pers["team"]] = 1;
    }
  }

  return var_1;
}

_id_86B4() {
  if(_id_85CD()) {
    return 1;
  }

  if(istrue(level._id_1A74)) {
    level._id_1A74 = 0;
    return 1;
  }

  return 0;
}

_id_85CD() {
  var_0 = _id_6603();
  var_1 = _id_67CA()[0];

  if(!isDefined(level._id_EF6A[var_1]["upcomingMatchups"])) {
    return 0;
  }

  return !isDefined(level._id_EF6A[var_1]["upcomingMatchups"][var_0]);
}

is_first_blood(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = var_0 _id_661A();
  var_3 = !istrue(level._id_EF6A[var_1]["firstBlood"]) && !istrue(level._id_EF6A[var_2]["firstBlood"]);

  if(var_3) {
    level._id_EF6A[var_1]["firstBlood"] = 1;
    return 1;
  }

  return 0;
}

_id_A44E(var_0) {
  if(!isDefined(level._id_1A68)) {
    level._id_1A68 = 1;
    level._id_1A80 = 7;
    level._id_EF4F = _id_67C0();
    level.buy_round_start_index = level.arena_evo_num_matches_until_buy_round;
  }

  if(_id_86B4()) {
    var_1 = _id_6603();
    setomnvar("ui_arena_evo_series_end_match_index", var_1);
    level.buy_round_start_index = _id_6586();
    level._id_1A68++;
    level._id_A76F = 0;
    level._id_1A80 = 7;
    level._id_EF4F = _id_67C0();
    level.last_bye_round_team = arenatournament_get_last_bye_round_team();
  }

  var_2 = _id_6587(8, level._id_EF4F);

  foreach(var_9 in _id_633A()) {
    level._id_EF6A[var_9]["upcomingMatchups"] = [];
    level._id_EF6A[var_9]["firstBlood"] = 0;
  }

  var_11 = shouldshiftmatchups(var_2);

  if(var_11) {
    var_12 = var_2[var_2.size - 1];
    var_13 = scripts\engine\utility::_id_1BD4(var_2, 0, var_2.size - 1);
    var_13 = scripts\engine\utility::_id_1BB3(var_13, var_12, 0);
    var_2 = var_13;
  }

  for(var_4 = 0; var_4 < var_2.size; var_4++) {
    var_14 = var_2[var_4];

    for(var_6 = 0; var_6 < var_14.size; var_6++) {
      var_7 = var_14[var_6];
      [var_16, var_17] = get_teams_from_pair(var_7);
      add_teams_to_upcoming_matchups(var_16, var_17);
    }
  }

  if(_id_67CA().size != 3) {
    insert_scheduled_buy_round_into_schedule();
  }

  var_25 = !istrue(level.arena_evo_skip_final_buy_round) && getdvarint("#x3969984b6c084ec97", 1);

  if(istrue(var_0)) {
    var_25 = 0;
  }

  if(_id_67CA().size == 2 && !istrue(level._id_5A5A) && var_25) {
    level.final_bye_round_active = 1;
  } else {
    level.final_bye_round_active = 0;
  }

  if(shouldactivatefinalbuyround()) {
    var_22 = _id_6603();

    foreach(var_9 in _id_67CA()) {
      level._id_EF6A[var_9]["upcomingMatchups"][var_22] = var_9;
    }
  }

  scripts\mp\gametypes\arena_evo_tourney::_id_1AFA(level._id_1A68);
  level._id_1A80--;
}

shouldshiftmatchups(var_0) {
  var_1 = getdvarint("#x39bb4eeb9027c2cb6", 0);

  if(!var_1) {
    return 0;
  }

  if(isDefined(level.last_bye_round_team)) {
    var_2 = var_0[0];
    var_3 = undefined;

    foreach(var_5 in var_2) {
      if(scripts\engine\utility::array_contains(var_5, -1)) {
        var_6 = scripts\engine\utility::array_remove(var_5, -1)[0];
        var_3 = _id_633A()[var_6 - 1];
      }
    }

    if(isDefined(var_3)) {
      if(scripts\engine\utility::is_equal(level.last_bye_round_team, var_3)) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  return 0;
}

add_teams_to_upcoming_matchups(var_0, var_1) {
  level._id_EF6A[var_0]["upcomingMatchups"] = ::scripts\engine\utility::array_add(level._id_EF6A[var_0]["upcomingMatchups"], var_1);

  if(var_1 != var_0) {
    level._id_EF6A[var_1]["upcomingMatchups"] = ::scripts\engine\utility::array_add(level._id_EF6A[var_1]["upcomingMatchups"], var_0);
  }
}

insert_scheduled_buy_round_into_schedule() {
  foreach(var_1 in _id_633A()) {
    var_2 = level.buy_round_start_index;

    for(;;) {
      if(isDefined(level._id_EF6A[var_1]["upcomingMatchups"][var_2])) {
        level._id_EF6A[var_1]["upcomingMatchups"] = ::scripts\engine\utility::_id_1BB3(level._id_EF6A[var_1]["upcomingMatchups"], var_1, var_2);
        var_2 = var_2 + (level.arena_evo_num_matches_until_buy_round + 1);
        continue;
      }

      break;
    }
  }
}

get_teams_from_pair(var_0) {
  var_1 = undefined;
  var_2 = _id_633A();

  if(scripts\engine\utility::array_contains(var_0, -1)) {
    var_3 = scripts\engine\utility::array_remove(var_0, -1)[0];
    var_1 = var_2[var_3 - 1];
  }

  if(isDefined(var_1)) {
    var_4 = var_1;
    var_5 = var_1;
  } else {
    var_4 = var_2[var_0[0] - 1];
    var_5 = var_2[var_0[1] - 1];
  }

  return [var_4, var_5];
}

shouldactivatefinalbuyround() {
  return istrue(level.final_bye_round_active) && !istrue(level._id_5A5A);
}

get_first_match_bye_team(var_0) {
  var_1 = var_0[0];

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];

    if(scripts\engine\utility::array_contains(var_3, -1)) {
      var_4 = scripts\engine\utility::array_remove(var_3, -1)[0] - 1;
      return _id_633A()[var_4];
    }
  }

  return undefined;
}

_id_67C0() {
  var_0 = [];

  foreach(var_2 in _id_67CA()) {
    var_0[var_0.size] = _id_67BF(var_2) + 1;
  }

  if(var_0.size % 2 != 0) {
    var_0[var_0.size] = -1;
  }

  return scripts\engine\utility::array_randomize(var_0);
}

_id_6587(var_0, var_1) {
  var_2 = _id_6588(var_1, var_0);
  var_3 = _id_6713(var_2);
  return var_3;
}

_id_6713(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size - 1; var_2++) {
    var_3 = var_0[var_2];
    var_4 = scripts\engine\utility::_id_1BD4(var_3, 0, int(var_3.size / 2));
    var_5 = scripts\engine\utility::_id_1BD2(scripts\engine\utility::_id_1BD4(var_3, int(var_3.size / 2), var_3.size));
    var_6 = [];

    for(var_7 = 0; var_7 < var_4.size; var_7++) {
      var_6[var_6.size] = var_4[var_7];
      var_6[var_6.size] = var_5[var_7];
    }

    var_1 = _id_1017(var_1, var_6);
  }

  return var_1;
}

_id_6588(var_0, var_1) {
  var_2 = [];

  for(var_3 = 0; var_3 < var_1; var_3++) {
    var_2[var_3] = var_0;
    var_4 = var_0[0];
    var_5 = scripts\engine\utility::_id_1BD4(var_2[var_3], 1, var_2[var_3].size);

    for(var_6 = 0; var_6 < var_3; var_6++) {
      var_5 = scripts\engine\utility::_id_1BB3(var_5, var_5[var_5.size - 1], 0);
      var_5 = scripts\engine\utility::_id_1BD4(var_5, 0, var_5.size - 1);
    }

    var_5 = scripts\engine\utility::_id_1BB3(var_5, var_4, 0);
    var_2[var_3] = var_5;
  }

  return var_2;
}

_id_1017(var_0, var_1) {
  var_2 = var_0.size;
  var_0[var_2] = [];

  for(var_3 = 0; var_3 < var_1.size; var_3 = var_3 + 2) {
    if(!isDefined(var_1[var_3 + 1])) {
      var_1[var_3 + 1] = -1;
    }

    var_0[var_2][var_0[var_2].size] = [var_1[var_3], var_1[var_3 + 1]];
  }

  return var_0;
}

_id_D676() {
  var_0 = [];
  var_1 = 0;

  if(_id_88CF()) {
    foreach(var_3 in level._id_EF89) {
      var_4 = _id_66A9(var_3);

      foreach(var_6 in var_4) {
        var_6 _id_D661(var_1);
      }
    }
  } else {
    foreach(var_10 in _id_6334()) {
      var_3 = var_10[0];

      if(_id_8602(var_3)) {
        continue;
      }
      if(!isDefined(var_0[var_3])) {
        var_11 = _id_67C1(var_3);
        var_0[var_3] = var_1;
        var_0[var_11] = var_1;
        var_4 = scripts\engine\utility::array_combine(_id_66A9(var_3), _id_66A9(var_11));

        foreach(var_6 in var_4) {
          var_6 _id_D661(var_1);
        }

        var_1++;
      }
    }

    level.octagonchannel = var_1;

    foreach(var_3 in level._id_EF89) {
      if(isDefined(var_0[var_3])) {
        continue;
      }
      var_4 = _id_66A9(var_3);

      foreach(var_6 in var_4) {
        var_6 _id_D661(level.octagonchannel);
      }
    }
  }
}

_id_D661(var_0) {
  self._id_01F1 = self._id_01F1 | 1024;

  if(!isDefined(var_0)) {
    return;
  }
  if(var_0 > 7) {
    return;
  }
  var_1 = 3;
  var_2 = 3;
  var_3 = int(_func_01A6(2, var_1)) - 1;
  var_4 = (var_0 &var_3) << var_2;
  var_5 = ~(var_3 << var_2);
  var_6 = self._id_01F1;
  var_7 = var_6 &var_5;
  var_8 = var_7 + var_4;
  self._id_01F1 = var_8;
}

_id_67C1(var_0) {
  if(!isDefined(level._id_EF6A[var_0]["upcomingMatchups"])) {
    return undefined;
  }

  var_1 = _id_6603();
  return level._id_EF6A[var_0]["upcomingMatchups"][var_1];
}

_id_6334() {
  var_0 = [];
  var_1 = _id_6603();

  foreach(var_3 in _id_633A()) {
    var_4 = level._id_EF6A[var_3]["upcomingMatchups"];
    var_5 = level._id_EF6A[var_3]["upcomingMatchups"][var_1];

    if(isDefined(var_5)) {
      var_0[var_0.size] = [var_3, var_5];
    }
  }

  return var_0;
}

_id_81D7(var_0) {
  if(isDefined(level._id_1AC2) && isDefined(var_0) && isDefined(level._id_1AC2[var_0])) {
    return;
  }
  if(!isDefined(level._id_1AC2)) {
    level._id_1AC2 = [];
  }

  var_1 = 1;

  foreach(var_0 in _id_633A()) {
    if(!isDefined(level._id_1AC2[var_0])) {
      level._id_1AC2[var_0] = getdvarint("#x32ae7460af7e83048", 12);
      setomnvar("ui_arena_score" + var_1, level._id_1AC2[var_0]);
    }

    var_1++;
  }
}

_id_D3DE(var_0, var_1) {
  level._id_1A8D[var_0] = var_1;
}

_id_67C6(var_0) {
  if(!isDefined(var_0) || !isDefined(level._id_1A8D[var_0])) {
    return "no_status";
  }

  return level._id_1A8D[var_0];
}

_id_86E2(var_0) {
  if(isPlayer(var_0)) {
    var_1 = var_0.pers["team"];
  } else {
    var_1 = var_0;
  }

  return _id_67C6(var_1) == "eliminated";
}

_id_D3DB(var_0) {
  if(isPlayer(var_0)) {
    var_1 = var_0.pers["team"];
  } else {
    var_1 = var_0;
  }

  var_2 = _id_66A9(var_1);

  foreach(var_4 in var_2) {
    var_4 _id_1A8A("arena_evo_player_state_eliminated");
    var_4 _id_5217();

    if(!istrue(var_4._id_1AA1)) {
      var_4._id_1AA1 = 1;
      var_4 thread scripts\mp\gametypes\arena_evo_tourney::_id_1ACD();
      var_4 _id_0A99::_id_D5EA(78);
    }

    var_4._id_C941 = "eliminated_this_round";
    var_4 _id_D661(level.octagonchannel);
  }

  _id_0FB2(var_1);

  if(!isDefined(level._id_1A6D)) {
    level._id_1A6D = [];
  }

  level._id_1A6D = scripts\engine\utility::array_add(level._id_1A6D, var_1);
  _id_D3DE(var_1, "eliminated");
  var_6 = 1;

  foreach(var_8 in level._id_1A6D) {
    var_9 = 1;

    foreach(var_11 in _id_633A()) {
      if(var_11 == var_8) {
        setomnvar("ui_arena_elim_order" + var_6, var_9);
        break;
      }

      var_9++;
    }

    var_6++;
  }

  var_14 = get_arena_evo_placement(var_1);
  scripts\mp\gametypes\arena_evo::grantexp_onsquadeliminated(var_1, var_14);
  var_9 = 1;

  foreach(var_11 in _id_633A()) {
    if(var_11 == var_1) {
      setomnvar("ui_arena_score" + var_9, -1);
      break;
    }

    var_9++;
  }
}

set_xp_omnvars() {
  var_0 = self;

  if(isDefined(var_0._id_B16D)) {
    var_0 setclientomnvar("ui_arena_evo_stat_placement_bonus_xp", var_0._id_B16D);
  }

  var_1 = var_0.pers["summary"]["xp"];
  var_0 setclientomnvar("ui_arena_evo_stat_total_xp", var_1);
}

get_arena_evo_placement(var_0) {
  var_1 = 0;

  for(var_2 = 0; var_2 < level._id_1A6D.size; var_2++) {
    if(scripts\engine\utility::is_equal(var_0, level._id_1A6D[var_2])) {
      var_1 = var_2;
      break;
    }
  }

  var_3 = _id_633A().size - var_1;
  return var_3;
}

_id_0FB2(var_0) {
  var_1 = _id_6603(1);

  if(!isDefined(level._id_EFA1)) {
    level._id_EFA1 = [];
  }

  if(!isDefined(level._id_EFA1[var_1])) {
    level._id_EFA1[var_1] = [];
  }

  level._id_EFA1[var_1][level._id_EFA1[var_1].size] = var_0;
}

_id_67C9() {
  if(!isDefined(level._id_EFA1)) {
    return [];
  }

  var_0 = _id_6603(1);

  if(!isDefined(level._id_EFA1[var_0])) {
    return [];
  }

  return level._id_EFA1[var_0];
}

_id_EF5D(var_0) {
  var_1 = _id_67C9();

  if(var_1.size == 0) {
    return 0;
  }

  return scripts\engine\utility::array_contains(var_1, var_0);
}

_id_67BF(var_0) {
  var_1 = 0;

  foreach(var_3 in _id_633A()) {
    if(var_3 == var_0) {
      break;
    }

    var_1++;
  }

  return var_1;
}

_id_D3DF(var_0, var_1, var_2) {
  level._id_1A74 = 1;
  var_3 = 0;

  foreach(var_5 in var_0) {
    if(istrue(var_1)) {
      _id_C441(var_5, _id_6714(var_5), 1);
    }

    _id_D3DB(var_5);
    var_3++;
  }

  var_7 = [];

  foreach(var_5 in var_0) {
    var_7 = scripts\engine\utility::array_combine(var_7, _id_66A9(var_5));
  }

  var_10 = scripts\engine\utility::_id_1BBF(level.players, var_7);
  var_11 = var_10;

  if(isDefined(var_2)) {
    var_11 = scripts\engine\utility::_id_1BBF(var_11, _id_66A9(var_2));
  }

  if(istrue(var_1)) {
    return;
  }
  foreach(var_5 in var_0) {
    var_13 = "elimination_team_" + (_id_67BF(var_5) + 1);
    level thread _id_0A8D::_id_9139(var_13, var_11);
  }

  if(_id_67CA().size == 6) {
    level thread _id_0A8D::_id_9139("large_amount_teams_remaining", var_10);
  }

  if(_id_67CA().size == 4) {
    level thread _id_0A8D::_id_9139("medium_amount_teams_remaining", var_10);
  }

  if(_id_67CA().size == 2) {
    level thread _id_0A8D::_id_9139("small_amount_teams_remaining", var_10);
  }

  level thread _id_0A8D::_id_9139("you_are_eliminated", var_7);
}

_id_1A95(var_0) {
  if(var_0["team_alive_count"] > 0) {
    return 0;
  }

  if(var_0["opponents"].size == 0) {
    return 0;
  }

  return 1;
}

_id_D361(var_0) {
  var_1 = "ui_match_start_countdown";

  foreach(var_3 in _id_633A()) {
    var_4 = _id_66A9(var_3);

    foreach(var_6 in var_4) {
      var_6 setclientomnvar(var_1, var_0);
    }
  }
}

_id_D287(var_0) {
  if(var_0 == -1) {
    setomnvar("ui_arena_evo_match_time", 0);
  } else {
    setomnvar("ui_arena_evo_match_time", gettime() + var_0 * 1000);
  }
}

_id_CA17() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("spectate_game");

  if(istrue(level._id_BB9D)) {
    self setclientomnvar("ui_arena_evo_unscheduled_buy", !_id_88CF());
  }

  self setclientomnvar("ui_arena_evo_bye", 1);
}

_id_73FE() {
  self endon("disconnect");
  self endon("game_ended");
  self endon("spectate_game");

  if(level.onlinegame) {
    if(self _meth_878F() || isbot(self)) {
      thread _id_1F18();
    }
  }

  self waittill("leave_game");
  kick(self getentitynumber());
}

_id_1F18() {
  wait 3;
  self notify("leave_game");
}

_id_1472(var_0) {
  foreach(var_2 in var_0) {
    if(!(isbot(var_2) || var_2 _meth_878F())) {
      return 0;
    }
  }

  return 1;
}

_id_D261() {
  level notify("set_intermission_screen_focus_to_new_arena");
  level endon("set_intermission_screen_focus_to_new_arena");

  if(scripts\mp\gametypes\arena_evo_tourney::_id_1AD8()) {
    return;
  }
  while(!isDefined(level._id_1A7A)) {
    waitframe();
  }

  var_0 = getEntArray("mp_global_intermission", "classname");

  if(!isDefined(var_0[0].angles)) {
    var_0[0].angles = (0, 0, 0);
  }

  level._id_1A7A.origin = var_0[0].origin;
  level._id_1A7A.angles = var_0[0].angles;
}

_id_1073D() {
  if(istrue(level._id_1A84)) {
    return;
  }
  if(level._id_BBAE > 0 && !isDefined(level._id_7AAE)) {
    level waittill("matchStartTimer_done");
  }

  level._id_1A84 = 1;
}

_id_B61B(var_0) {
  var_1 = self;
  var_2 = var_1 getweaponslistprimaries();
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!scripts\mp\gametypes\arena_evo_tourney_loot::is_valid_loadout_weapon(var_5.basename)) {
      continue;
    }
    if(!isDefined(var_3[var_5.basename])) {
      var_3[var_5.basename] = var_5;
    }
  }

  var_7 = 0;

  foreach(var_10, var_5 in var_3) {
    var_9 = getcompleteweaponname(var_5 _meth_8625());
    var_9 = scripts\mp\utility\script::_id_EA63(var_9, "_mp");

    if(var_7 == 0) {
      var_1 scripts\mp\gametypes\arena_evo_tourney_loot::_id_D160(var_9, "arena_evo_loadout_override_primary");
    } else {
      var_1 scripts\mp\gametypes\arena_evo_tourney_loot::_id_D160(var_9, "arena_evo_loadout_override_secondary");
    }

    var_7++;
  }

  var_1 scripts\mp\gametypes\arena_evo_tourney_loot::_id_AD3D(var_1.pers["classCache"]["class0"], undefined, var_0);
}

_id_CB53() {
  foreach(var_1 in _id_67CA()) {
    if(!isDefined(level._id_EFA6)) {
      level._id_EFA6 = [];
    }

    level._id_EFA6[var_1] = _id_6714(var_1);
  }
}

_id_1A89(var_0) {
  var_1 = self;

  if(isbot(var_1)) {
    return;
  }
  if(var_0 && scripts\mp\equipment::_id_85BF("primary") && scripts\mp\equipment::_id_85BF("secondary")) {
    return;
  }
  if(!var_0 && !scripts\mp\equipment::_id_85BF("primary") && !scripts\mp\equipment::_id_85BF("secondary")) {
    return;
  }
  var_1 scripts\mp\equipment::_id_153B("primary", var_0);
  var_1 scripts\mp\equipment::_id_153B("secondary", var_0);
}

_id_C002(var_0) {
  foreach(var_3, var_2 in var_0._id_E363) {
    var_0._id_E363[var_3] = ::scripts\engine\utility::array_randomize(var_2);
  }
}

_id_5E45() {
  var_0 = self;
  self notify("force_bot_enemy");
  self endon("force_bot_enemy");

  for(;;) {
    if(scripts\engine\utility::is_equal(var_0.sessionstate, "playing")) {
      var_1 = var_0 _id_661A();

      if(!isDefined(var_1)) {
        break;
      }

      var_2 = _id_66A9(var_1);

      foreach(var_4 in var_2) {
        var_0 _meth_812E(var_4);
      }
    }

    wait 0.15;
  }
}

_id_8602(var_0) {
  if(isPlayer(var_0)) {
    var_1 = var_0.pers["team"];
  } else {
    var_1 = var_0;
  }

  if(!isDefined(var_1)) {
    return 0;
  }

  if(!_id_74EB(var_1, _id_67C1(var_1))) {
    return 1;
  }

  if(scripts\engine\utility::is_equal(_id_67C1(var_1), var_1)) {
    return 1;
  }

  return 0;
}

_id_DBCA() {
  return _id_BBA0() && !isDefined(level._id_BB9D);
}

_id_BBA0() {
  return getdvarint("#x3236c452967fb1d0d", 1);
}

_id_88CF() {
  foreach(var_1 in _id_67CA()) {
    if(!_id_8602(var_1)) {
      return 0;
    }
  }

  return 1;
}

_id_74EB(var_0, var_1) {
  if(scripts\engine\utility::is_equal(var_0, var_1)) {
    return 0;
  }

  if(_id_86E2(var_1) && !_id_EF5D(var_1)) {
    return 0;
  }

  return 1;
}

_id_1A97(var_0) {
  return isDefined(var_0) && isDefined(var_0._id_5BD4);
}

_id_B22F(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_0481)) {
    return;
  }
  switch (var_0._id_0481) {
    case "arena_market":
      var_1 = "flare_fanfare_lrg_3";
      break;
    case "arena_2":
      var_1 = "flare_fanfare_lrg_4";
      break;
    case "arena_4":
      var_1 = "flare_fanfare_lrg_1";
      break;
    default:
      var_1 = "flare_fanfare_lrg_2";
      break;
  }

  playFX(scripts\engine\utility::getfx(var_1), var_0._id_5B97.origin, anglesToForward(var_0._id_5B97.angles), anglestoup(var_0._id_5B97.angles));
}

_id_448B() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isDefined(level.player.pers["team"])) {
    waitframe();
  }

  while(scripts\engine\utility::is_equal(level.player.pers["team"], "spectator")) {
    waitframe();
  }

  var_0 = getdvarint("#x314fe879628c97abb", 2);

  if(getdvarint("#x3e87471b486173f14", 0)) {
    var_1 = scripts\engine\utility::random(scripts\engine\utility::array_remove(_id_633A(), level.player.pers["team"]));
  } else {
    var_1 = "";
  }

  if(getdvarint("#x37c9a47d0055ca979", 0)) {
    var_2 = getdvarint("#x37c9a47d0055ca979", 0);
  } else {
    var_2 = 0;
  }

  if(getdvarint("#x3d9e5f91102d761c2", 0)) {
    foreach(var_4 in _id_633A()) {
      if(var_2 > 0 && !scripts\engine\utility::is_equal(level.player.pers["team"], var_4)) {
        var_2--;
        continue;
      }

      if(scripts\engine\utility::is_equal(var_4, var_1)) {
        continue;
      }
      if(scripts\engine\utility::is_equal(var_4, level.player.pers["team"])) {
        if(!getdvarint("#x3ba3da5a68eb617b9", 0)) {
          level thread scripts\mp\bots\bots::spawn_bots(var_0 - 1, var_4);
        }

        continue;
      }

      level thread scripts\mp\bots\bots::spawn_bots(var_0, var_4);
    }
  }
}

_debug_toggle_spectate_on_dpad_left(var_0) {
  var_0 endon("disconnect");
  level endon("game_ended");
  var_0 notifyonplayercommand("dpad_left_release", "-actionslot 3");

  for(;;) {
    var_0 waittill("dpad_left_release");

    if(var_0.sessionstate == "spectator") {
      var_0 scripts\mp\utility\player::_id_FD26("playing");
      continue;
    }

    var_0 scripts\mp\utility\player::_id_FD26("spectator");
  }
}

debug_player_spectate() {
  if(getdvarint("#x3b3227dfd5183a3f7", 0)) {}

  while(!isDefined(level.player)) {
    waitframe();
  }

  while(!isDefined(level.player.pers["team"])) {
    waitframe();
  }

  while(scripts\engine\utility::is_equal(level.player.pers["team"], "spectator")) {
    waitframe();
  }

  if(getdvarint("#x3b3227dfd5183a3f7", 0)) {
    _debug_toggle_spectate_on_dpad_left(level.player);
  }
}

_id_1A8A(var_0) {
  var_1 = self;

  if(_id_86E2(var_1)) {
    var_0 = "arena_evo_player_state_eliminated";
  }

  switch (var_0) {
    case "arena_evo_player_state_eliminated":
    case "arena_evo_player_state_loot_round":
      var_1._id_B928 = 1;
      var_1._id_0480 = 1;
      var_1 _id_1AFD(1);
      var_1 _id_1AF7();
      var_1 thread scripts\mp\gametypes\arena_evo_tourney::_id_1ADB();
      var_1 _meth_86C4();
      var_1 thread _id_1A89(0);
      var_1 scripts\mp\battlechatter_mp::_id_4A81(var_1);

      if(scripts\engine\utility::is_equal(var_0, "arena_evo_player_state_loot_round")) {
        var_1 thread _id_CA17();
      }

      if(scripts\engine\utility::is_equal(var_0, "arena_evo_player_state_eliminated")) {
        var_1 thread _id_D358();
        level thread disableallscriptablesforeliminatedplayer(var_1);
      }

      break;
    case "arena_evo_player_state_playing":
      var_1._id_B928 = 0;
      var_1._id_0480 = 0;
      var_1 _meth_86C5();
      var_1 allowfire(1);
      var_1 _id_1AF7();
      var_1 _id_1AFD(1);
      var_1 thread _id_1A89(1);
      var_1 scripts\mp\battlechatter_mp::_id_523A(var_1);
      var_1 thread scripts\mp\gametypes\arena_evo_tourney::arenatournament_afk_check(var_1.origin, var_1.arenaevoafk_elapsedtime, var_1.arenaevoafk_distancetraveled, var_1.arenaevoafk_eliminationsthisround);
      break;
    case "arena_evo_player_state_intermission":
      var_1._id_B928 = 1;
      var_1._id_0480 = 0;
      var_1 _id_1AFD(0);
      var_1 thread _id_1A89(0);
      var_1 scripts\mp\battlechatter_mp::_id_4A81(var_1);
      break;
  }

  var_1._id_41B1 = var_0;
}

_id_D358() {
  var_0 = self;
  var_0 clearaccessory();
  var_0 takeallweapons();
  var_1 = scripts\mp\class::buildweapon("s4_me_fists", [], "none", "none", -1);
  var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);
  var_2 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1);
  var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_38B6();
  var_0 _id_B61B();
}

_id_1A8B(var_0) {
  level._id_1A6B = var_0;
}

is_in_combat_state() {
  var_0 = self;
  var_1 = arenatournament_get_player_allow_state();
  return scripts\engine\utility::is_equal(var_1, "arena_evo_player_state_playing");
}

is_in_weapon_upgrade_state() {
  var_0 = self;

  if(var_0 _meth_8270() != "mount_none") {
    return 0;
  }

  var_1 = arenatournament_get_player_allow_state();

  switch (var_1) {
    case "arena_evo_player_state_intermission":
      return 0;
    default:
      return 1;
  }
}

arenatournament_get_player_allow_state() {
  var_0 = self;

  if(!isDefined(var_0._id_41B1)) {
    return "";
  }

  return var_0._id_41B1;
}

arenatournament_save_last_bye_round_team() {
  if(_id_88CF()) {
    return;
  }
  foreach(var_1 in _id_633A()) {
    if(_id_8602(var_1)) {
      level.arena_tournament_last_bye_round_team = var_1;
      break;
    }
  }
}

arenatournament_get_last_bye_round_team() {
  return level.arena_tournament_last_bye_round_team;
}

_id_1AFD(var_0) {
  if(var_0 && scripts\common\utility::_id_85CE() && scripts\common\utility::_id_8616()) {
    return;
  }
  if(!var_0 && !scripts\common\utility::_id_85CE() && !scripts\common\utility::_id_8616()) {
    return;
  }
  self allowmovement(var_0);
  scripts\common\utility::_id_153E(var_0);
  scripts\common\utility::_id_1587(var_0);
  scripts\common\utility::_id_154E(var_0);
  scripts\common\utility::_id_1554(var_0);
  scripts\common\utility::_id_1581(var_0);
  scripts\common\utility::_id_154F(var_0);

  if(!istrue(level._id_4ACD)) {
    scripts\common\utility::_id_1558(var_0);
    scripts\common\utility::_id_1557(var_0);
  }
}

_id_1AF7(var_0) {
  var_1 = self;

  if(isDefined(var_0)) {
    var_2 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");

    if(isarenaevolauncherweapon(var_0)) {
      var_1 setclientomnvar("ui_arena_weapon_rank_" + var_2, 0);
      return;
    }

    if(scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AD5(var_0)) {
      var_1 setclientomnvar("ui_arena_weapon_rank_" + var_2, scripts\mp\gametypes\arena_evo_tourney_weapon_util::_id_1AD2(var_0));
    } else {
      var_1 setclientomnvar("ui_arena_weapon_rank_" + var_2, -1);
    }

    return;
  }

  foreach(var_6, var_4 in var_1._id_1AA4) {
    var_5 = scripts\mp\utility\script::_id_EA63(var_6, "_mp");

    if(!scripts\mp\gametypes\arena_evo_tourney_loot::_id_1AD5(var_6)) {
      var_4 = -1;
    }

    if(isarenaevolauncherweapon(var_6)) {
      continue;
    }
    var_1 setclientomnvar("ui_arena_weapon_rank_" + var_5, var_4);
  }
}

_id_1A77(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    if(scripts\engine\utility::is_equal(var_1.basename, self._id_4422.basename)) {
      var_0 = var_1;
    }
  }

  if(isDefined(var_2)) {
    if(scripts\engine\utility::is_equal(var_2.basename, self._id_4422.basename)) {
      var_0 = var_2;
    }
  }

  return var_0;
}

disablescriptableforalleliminatedplayers(var_0) {
  var_0 wait_for_usable_state();

  foreach(var_2 in level.players) {
    if(_id_86E2(var_2)) {
      var_0 _meth_86A8(var_2);
    }
  }
}

disableallscriptablesforeliminatedplayer(var_0) {
  foreach(var_2 in level._id_2A95._id_CF26) {
    if(isDefined(var_2)) {
      var_2 _meth_86A8(var_0);
    }
  }
}

disablescriptableforotherteam(var_0) {
  var_1 = self;
  var_1 wait_for_usable_state();
  var_2 = _id_67C1(var_0);

  foreach(var_4 in _id_66A9(var_2)) {
    var_1 _meth_86A8(var_4);
  }
}

wait_for_usable_state() {
  var_0 = self;

  for(;;) {
    if(!isDefined(var_0)) {
      return;
    }
    var_1 = var_0 _meth_8575(var_0.type, 1);

    if(scripts\engine\utility::is_equal(var_1, "visible") || scripts\engine\utility::is_equal(var_1, "delayAuto")) {
      break;
    }

    waitframe();
  }

  waitframe();
}

arenatournament_dlog_record_purchase_event(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  if(!isDefined(var_4)) {
    var_4 = 0;
  }

  var_5 = ["item_name", var_1, "item_cost", var_2, "item_match_num", _id_6603(1), "item_level", var_3, "is_dpad_upgrade", var_4, "team_size", _id_6780()];
  var_0 _meth_870F("dlog_event_arena_evo_purchases", var_5);
}

arenatournament_dlog_record_end_of_round(var_0) {
  var_1 = var_0.pers["team"];
  var_2 = _id_67C1(var_0.pers["team"]);

  if(!isDefined(var_2)) {
    var_2 = var_1;
  }

  var_3 = 0;

  if(isDefined(var_0._id_432F)) {
    var_3 = var_0._id_432F;
  }

  var_0._id_432F = 0;
  var_0 _meth_870F("dlog_event_end_of_round", ["time_from_match_start_ms", gettime(), "player_team_name", var_1, "enemy_team_name", var_2, "player_team_score", _id_6714(var_1), "enemy_team_score", _id_6714(var_2), "damage_this_round", var_3]);
}

arenatournament_dlog_record_end_of_game() {
  _func_03BF("dlog_arena_evo_match_end", ["number_of_rounds_played", _id_6603(1), "team_size", _id_6780()]);
}

arena_evo_playerprematchallow(var_0) {}

arena_evo_getafkchecktime() {
  return getdvarint("#x313eb7bd7c13181ef", 25);
}

isspectateactivationallowed(var_0) {
  if(!getdvarint("#x39d0db0cbd592d9d1", 0)) {
    return 0;
  }

  if(!_id_8602(var_0) && !_id_86E2(var_0) || _id_88CF()) {
    return 0;
  }

  if(!scripts\engine\utility::is_equal(var_0._id_41B1, "arena_evo_player_state_loot_round") && !scripts\engine\utility::is_equal(var_0._id_41B1, "arena_evo_player_state_eliminated")) {
    return 0;
  }

  if(var_0.origin[2] < 440) {
    return 0;
  }

  return 1;
}

isarenaevolauncherweapon(var_0) {
  var_0 = scripts\mp\utility\script::_id_EA63(var_0, "_mp");

  switch (var_0) {
    case "s4_la_palpha":
    case "s4_la_palpha42":
    case "s4_la_mkilo1":
    case "s4_la_m1bravo":
      return 1;
    default:
      return 0;
  }
}