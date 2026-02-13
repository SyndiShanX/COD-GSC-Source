/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\arena_evo.gsc
*************************************************/

init() {}

main() {
  _id_07DC::init();
  _id_07DC::_id_D854();
  arenatournament_set_default_dvars();

  if(_func_0127()) {
    level._id_81E5 = ::_id_81E5;
    [[level._id_81E5]]();
    level thread scripts\mp\utility\game::_id_C2EB();
  } else {
    scripts\mp\utility\game::_id_C2AA(level.gametype, 0, 0, 9);
    scripts\mp\utility\game::_id_C2C1(level.gametype, 10);
    scripts\mp\utility\game::_id_C2AD(level.gametype, 75);
    scripts\mp\utility\game::_id_C2A9(level.gametype, 1);
    scripts\mp\utility\game::_id_C2D0(level.gametype, 1);
    scripts\mp\utility\game::_id_C27E(level.gametype, 0);
    scripts\mp\utility\game::_id_C25D(level.gametype, 0);
    level._id_9BEB = 0;
    level._id_9BF0 = 0;
  }

  _id_FC7D();

  if(!issubstr(scripts\cp_mp\utility\game_utility::_id_6B2D(), "mp_arena_evo")) {
    return;
  }
  level._id_25A8 = 1;
  level.watchafkwaitflag = "ch_tutorial_done";
  level._id_1518 = "mp_arena_spawn_allies_start";
  level._id_1FEF = "mp_arena_spawn_axis_start";
  level._id_BB9F = scripts\mp\gametypes\arena_evo_tourney_util::arena_evo_playerprematchallow;
  level.mp_juggernaut_health_override = getdvarint("#x3a3acb54c1b75aba3", 800);
  level._id_AD3C = ::_id_A438;

  if(isDefined(level._id_227C)) {
    level thread[[level._id_227C]]();
  }

  level thread _id_07AC::_id_189E();
  scripts\engine\utility::_id_0FDC("flare_fanfare_lrg_1", "vfx/s4/flare/flare_fanfare_blue_lrg");
  scripts\engine\utility::_id_0FDC("flare_fanfare_lrg_2", "vfx/s4/flare/flare_fanfare_green_lrg");
  scripts\engine\utility::_id_0FDC("flare_fanfare_lrg_3", "vfx/s4/flare/flare_fanfare_yellow_lrg");
  scripts\engine\utility::_id_0FDC("flare_fanfare_lrg_4", "vfx/s4/flare/flare_fanfare_lrg");
  level thread scripts\mp\gametypes\arena_evo_tourney::init();
  level._id_E2EA = 0;
  level._id_ABC2 = 0.0;
  level._id_4203 = 0.0;
  level._id_31B5 = 0;
  level._id_ABC0 = ::_id_ABC0;
  level._id_ABAD = ::_id_ABAD;
  level.onplayerconnect = ::onplayerconnect;
  level._id_6D4A = scripts\mp\gametypes\arena_evo_tourney::_id_1AD0;
  level._id_AB70 = scripts\mp\gametypes\arena_evo_tourney::_id_1AC7;
  level._id_AD3D = scripts\mp\gametypes\arena_evo_tourney_loot::_id_AD3D;
  level._id_1A8D = [];
  game["dialog"]["intro_dialog_00"] = "mp_glob_chvo_bchr_int0";
  game["dialog"]["intro_dialog_01"] = "mp_glob_chvo_bchr_int1";
  game["dialog"]["intro_dialog_02"] = "mp_glob_chvo_bchr_int2";
  game["dialog"]["intro_dialog_03"] = "mp_glob_chvo_bchr_int3";
  game["dialog"]["intro_buy_dialog_01"] = "mp_glob_chvo_bchr_chb1";
  game["dialog"]["intro_buy_dialog_02"] = "mp_glob_chvo_bchr_chb2";
  game["dialog"]["intro_buy_dialog_03"] = "mp_glob_chvo_bchr_chb3";
  game["dialog"]["intro_buy_dialog_04"] = "mp_glob_chvo_bchr_chb4";
  game["dialog"]["champion_hill_start"] = "mp_glob_chvo_bchr_i3in";
  game["dialog"]["arena_evo_matchup_first"] = "mp_glob_chvo_bchr_chnm";
  game["dialog"]["keep_fighting"] = "mp_glob_chvo_bchr_z319";
  game["dialog"]["arena_evo_took_points_from_enemy"] = "mp_glob_chvo_bchr_chat";
  game["dialog"]["arena_evo_enemy_took_your_points"] = "mp_glob_chvo_bchr_chdt";
  game["dialog"]["arena_evo_matchup_2"] = "mp_glob_chvo_bchr_chm2";
  game["dialog"]["mod_card_activated"] = "mp_glob_chvo_bchr_mcac";
  game["dialog"]["large_amount_teams_remaining"] = "mp_glob_chvo_bchr_latm";
  game["dialog"]["medium_amount_teams_remaining"] = "mp_glob_chvo_bchr_matr";
  game["dialog"]["small_amount_teams_remaining"] = "mp_glob_chvo_bchr_satr";
  game["dialog"]["large_amount_lives_remaining"] = "mp_glob_chvo_bchr_latr";
  game["dialog"]["medium_amount_lives_remaining"] = "mp_glob_chvo_bchr_malr";
  game["dialog"]["small_amount_lives_remaining"] = "mp_glob_chvo_bchr_salr";
  game["dialog"]["last_life"] = "mp_glob_chvo_bchr_chll";
  game["dialog"]["new_location"] = "mp_glob_chvo_bchr_nwlc";
  game["dialog"]["final_matchup"] = "mp_glob_chvo_bchr_flmh_01";
  game["dialog"]["team_eliminated"] = "mp_glob_chvo_bchr_felm";
  game["dialog"]["you_are_eliminated"] = "mp_glob_chvo_bchr_yelm";
  game["dialog"]["new_round"] = "mp_glob_chvo_bchr_nwrd";
  game["dialog"]["almost_won"] = "mp_glob_chvo_bchr_alwn";
  game["dialog"]["you_won"] = "mp_glob_chvo_bchr_yuwn";
  game["dialog"]["eliminated_other"] = "mp_glob_chvo_bchr_elmt";
  game["dialog"]["securing_flag"] = "mp_glob_chvo_bchr_z169";
  game["dialog"]["losing_flag"] = "mp_glob_chvo_bchr_z170";
  game["dialog"]["buy_round_reminder"] = "mp_glob_chvo_bchr_z195";
  game["dialog"]["mid_match_buy"] = "mp_glob_chvo_bchr_z191";
  game["dialog"]["first_legendary"] = "mp_glob_chvo_bchr_z173";
  game["dialog"]["finished_off"] = "mp_glob_chvo_bchr_z171";
  game["dialog"]["last_man_standing"] = "mp_glob_chvo_bchr_z189";
  game["dialog"]["buy_round_10_seconds"] = "mp_glob_chvo_bchr_z175";
  game["dialog"]["10_seconds"] = "mp_glob_chvo_bchr_tslt";
  game["dialog"]["ch_5_lives_left"] = "mp_glob_chvo_bchr_5lvs";
  game["dialog"]["ch_4_lives_left"] = "mp_glob_chvo_bchr_4lvs";
  game["dialog"]["ch_3_lives_left"] = "mp_glob_chvo_bchr_3lvs";
  game["dialog"]["ch_2_lives_left"] = "mp_glob_chvo_bchr_2lvs";
  game["dialog"]["ch_1_lives_left"] = "mp_glob_chvo_bchr_1lvs";
  game["dialog"]["eliminated_team_1"] = "mp_glob_chvo_bchr_eet1";
  game["dialog"]["eliminated_team_2"] = "mp_glob_chvo_bchr_eet2";
  game["dialog"]["eliminated_team_3"] = "mp_glob_chvo_bchr_eet3";
  game["dialog"]["eliminated_team_4"] = "mp_glob_chvo_bchr_eet4";
  game["dialog"]["eliminated_team_5"] = "mp_glob_chvo_bchr_eet5";
  game["dialog"]["eliminated_team_6"] = "mp_glob_chvo_bchr_eet6";
  game["dialog"]["eliminated_team_7"] = "mp_glob_chvo_bchr_eet7";
  game["dialog"]["eliminated_team_8"] = "mp_glob_chvo_bchr_eet8";
  game["dialog"]["elimination_team_1"] = "mp_glob_chvo_bchr_t1we";
  game["dialog"]["elimination_team_2"] = "mp_glob_chvo_bchr_t2we";
  game["dialog"]["elimination_team_3"] = "mp_glob_chvo_bchr_t3we";
  game["dialog"]["elimination_team_4"] = "mp_glob_chvo_bchr_t4we";
  game["dialog"]["elimination_team_5"] = "mp_glob_chvo_bchr_t5we";
  game["dialog"]["elimination_team_6"] = "mp_glob_chvo_bchr_t6we";
  game["dialog"]["elimination_team_7"] = "mp_glob_chvo_bchr_t7we";
  game["dialog"]["elimination_team_8"] = "mp_glob_chvo_bchr_t8we";
  game["dialog"]["enemy_activated_uav"] = "mp_glob_rcon_bchr_euse";
  arena_evo_set_random_loadout_active();
}

arenatournament_set_default_dvars() {
  setdynamicdvar("#x362b15ff47d91275", 5);
  setdynamicdvar("#x31289ab893ce37036", 5);
  setdynamicdvar("#x364442c66cf7c65ef", 1);
  setdynamicdvar("#x3eef4e390f811e19", 1);
  setdynamicdvar("#x3cf95d339bd1c5469", 1);
  setdynamicdvar("#x387394b83c27a6d8b", 1);

  if(!scripts\mp\utility\game::matchmakinggame()) {
    setdynamicdvar("#x3d89605100dc8a2bb", 75);
  }
}

grantexp_onsquadeliminated(var_0, var_1) {
  [var_3, var_4, var_5] = calculatearenaevobonusxp(var_1);
  var_6 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_0);

  foreach(var_8 in var_6) {
    if(isDefined(var_8)) {
      var_8 givearenaevobonusxp(var_3, undefined, "squadEliminated");
      var_8._id_9BA8 = var_4;
      var_8._id_B16D = var_5;
      var_8 scripts\mp\gametypes\arena_evo_tourney_util::set_xp_omnvars();
      var_8 _id_07BC::createchampionhillchallengeevent(var_1);
    }
  }
}

grantexp_onplayerdisconnectgiveexp(var_0) {}

grantexp_onsquadwin(var_0) {
  [var_2, var_3, var_4] = calculatearenaevobonusxp(1);
  var_5 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_0);

  foreach(var_7 in var_5) {
    if(isDefined(var_7)) {
      var_7 givearenaevobonusxp(var_2, undefined, "winner");
      var_7._id_9BA8 = var_3;
      var_7._id_B16D = var_4;
      var_7 _id_07BC::createchampionhillchallengeevent(1);
    }
  }
}

grantexp_onendofgame(var_0) {
  [var_2, var_3, var_4] = calculatearenaevobonusxp(1);
  var_5 = scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_0);

  foreach(var_7 in var_5) {
    if(isDefined(var_7)) {
      var_7 givearenaevobonusxp(var_2, undefined, "endGame");
      var_7._id_9BA8 = var_3;
      var_7._id_B16D = var_4;
      var_7 scripts\mp\gametypes\arena_evo_tourney_util::set_xp_omnvars();
    }
  }
}

calculatearenaevobonusxp(var_0) {
  if(!_id_07D1::_id_60BE("prematch_done")) {
    return 0;
  }

  if(!isDefined(level._id_10FDB)) {
    level._id_10FDB = scripts\mp\gametypes\arena_evo_tourney_util::_id_633A().size;
  }

  if(!isDefined(level._id_10FD7)) {
    var_1 = getdvarint("#x3971943b510d229c0", 500);
    level._id_10FD7 = var_1;
  }

  var_2 = getdvarfloat("#x366b3f972bb461cba", 0.0039);
  var_3 = gettime() - level._id_E703;
  var_4 = int(var_2 * var_3 + 0.5);
  var_5 = level._id_10FD7 * (level._id_10FDB - var_0 + 1);
  var_6 = var_4 + var_5;
  return [var_6, var_4, var_5];
}

givearenaevobonusxp(var_0, var_1, var_2) {
  if(!isDefined(self) || isbot(self) || _func_03DA(self)) {
    return;
  }
  if(!game["timePassed"]) {
    return;
  }
  if(!(scripts\mp\utility\game::matchmakinggame() || getdvarint("#x378c3667dfc793afa"))) {
    return;
  }
  if(scripts\engine\utility::is_equal(self.arenaevobonusxpallowed, 0)) {
    return;
  }
  var_3 = 0;
  var_4 = 0;

  if(!isDefined(var_2)) {
    var_2 = "undefined";
  }

  switch (var_2) {
    case "disconnect":
      var_3 = 1;
      var_4 = 1;
      break;
    case "squadEliminated":
      var_3 = 1;
      var_4 = 1;
      break;
    case "endGame":
    case "winner":
      var_3 = 1;
      var_4 = 1;
      break;
    case "undefined":
    default:
      var_3 = 0;
      var_4 = 1;
      break;
  }

  scripts\mp\rank::giverankxp("arena_evo_timeXPBonus", var_0, var_1, var_3, var_4);
  self.arenaevobonusxpallowed = 0;
}

arena_evo_set_random_loadout_active() {
  var_0 = getDvar("#x3dd32a56071a20b2f", "3");
  var_1 = strtok(var_0, ",");
  var_2 = int(scripts\engine\utility::random(var_1));
  setomnvar("ui_arena_evo_loadout_select", var_2);
}

_id_81E5() {
  scripts\mp\utility\game::_id_D4E0();
  setdynamicdvar("#x3b87c0767505c186d", 0);
  var_0 = getdvarint(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_override_teamsize"), -1);

  if(var_0 > 0) {
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_teamsize"), var_0);
    setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_squadsize"), var_0);
  }

  if(scripts\mp\utility\game::privatematch()) {
    var_1 = getmatchrulesdata("commonOption", "teamSize");

    if(isDefined(var_1)) {
      setDvar("#x3acded9dbd574bf5c", var_1);
      setDvar("#x32ae7460af7e83048", var_1 * 6);
    }
  }

  var_2 = getdvarint("#x3acded9dbd574bf5c");
  setomnvar("ui_squadSize", var_2);
  setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_roundswitch"), 0);
  scripts\mp\utility\game::_id_C2AA(scripts\mp\utility\game::getgametype(), 0, 0, 9);
  setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_roundlimit"), 1);
  scripts\mp\utility\game::_id_C2A9(scripts\mp\utility\game::getgametype(), 1);
  setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_winlimit"), 1);
  scripts\mp\utility\game::_id_C2D0(scripts\mp\utility\game::getgametype(), 1);
  setdynamicdvar(_func_0483("#x3ecead486797add6d", scripts\mp\utility\game::getgametype(), "_halftime"), 0);
  scripts\mp\utility\game::_id_C25D(scripts\mp\utility\game::getgametype(), 0);
}

_id_FC7D() {
  scripts\mp\gametypes\common::_id_FC39();
}

onplayerconnect(var_0) {
  if(istrue(level._id_15BD)) {
    level._id_15BD = 0;
  }

  foreach(var_3, var_2 in level._id_1A8F) {
    var_0 scripts\mp\gametypes\arena_evo_tourney_loot::_id_0C30(var_3 + "_mp");
  }

  var_0 setclientomnvar("ui_skip_loadout", 1);
  level thread scripts\mp\gametypes\arena_evo_tourney::_id_1ADA(var_0);

  if(!istrue(level._id_1A84) && var_0 _meth_876E("ui_arena_ui_state") != 4) {
    var_0 setclientomnvar("ui_arena_ui_state", 4);
  }
}

_id_ABAD() {
  if(getdvarint("#x3afbc23f3e3741c2e", 1)) {
    scripts\mp\utility\dvars::_id_D633("numlives", 0);
  }

  level._id_7644 = 5;
  level._id_7647 = level._id_7644 <= 0;
  level._id_B6D2 = level._id_7644;
  _id_07D1::_id_60C0("ch_tutorial_done", 0);
  scripts\mp\gametypes\arena_evo_tourney::_id_1AD6();

  if(getdvarint("#x343f1534cfa776b42", 1) && scripts\mp\utility\game::privatematch()) {
    _func_01E6(1, 1);
    _func_01E7(1, 1);
  }
}

_id_ABC0() {
  if(level.gameended) {
    return;
  }
}

_id_1A6F(var_0) {
  level._id_1AA5 = [];

  if(var_0 != "tie") {
    level thread _id_0A8D::_id_9139("you_won", scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_0), "gametype");
    var_1 = level._id_1A6D;
    level._id_1AA5 = [var_0];
  } else
    var_1 = [];

  if(isDefined(var_1) && var_1.size > 0) {
    if(var_1.size >= 1) {
      var_2 = var_1[var_1.size - 1];
      level thread _id_0A8D::_id_9139("almost_won", scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_2), "gametype");
      level._id_1AA5[level._id_1AA5.size] = var_2;
    }

    if(var_1.size >= 2) {
      var_3 = var_1[var_1.size - 2];
      level thread _id_0A8D::_id_9139("almost_won", scripts\mp\gametypes\arena_evo_tourney_util::_id_66A9(var_3), "gametype");
      level._id_1AA5[level._id_1AA5.size] = var_3;
    }
  }

  if(isDefined(var_0) && var_0 != "tie") {
    var_4 = scripts\mp\gametypes\arena_evo_tourney_util::_id_633A().size;
    setomnvar("ui_arena_elim_order" + var_4, scripts\mp\gametypes\arena_evo_tourney_util::_id_67BF(var_0) + 1);
  }

  foreach(var_6 in level.players) {
    var_6 scripts\mp\gametypes\arena_evo_tourney_util::_id_FD43();
  }

  grantexp_onsquadwin(var_0);

  if(var_0 == "tie") {
    foreach(var_9 in scripts\mp\gametypes\arena_evo_tourney_util::_id_67CA()) {
      if(!scripts\engine\utility::is_equal(var_9, var_0)) {
        grantexp_onendofgame(var_9);
      }
    }
  }

  level._id_5E90 = 1;
  setomnvar("ui_match_over", 1);
  thread scripts\mp\gamelogic::_id_52F7(var_0, game["end_reason"][tolower(game[game["defenders"]]) + "_eliminated"]);
}

_id_A438() {
  level waittill("forever");
}