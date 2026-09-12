/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_gamescore.gsc
***********************************************/

function init_gamescore() {
  register_scoring_mode();
}

function register_scoring_mode() {
  if(scripts\cp\utility::isplayingsolo()) {
    setomnvar("zm_ui_is_solo", 1);
    return;
  }

  setomnvar("zm_ui_is_solo", 0);
}

function register_eog_score_component(var_0, var_1) {
  if(!isDefined(level.eog_score_components)) {
    level.eog_score_components = [];
  }

  var_2 = spawnStruct();
  var_2.lua_string_index = var_1;
  level.eog_score_components[var_0] = var_2;
}

function register_encounter_score_component(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();
  var_8 = [[var_1]](var_8);
  var_8.reset_team_performance_func = var_2;
  var_8.reset_player_performance_func = var_3;
  var_8.calculate_func = var_4;
  var_8.lua_string_index = var_5;
  var_8.end_game_score_component_ref = var_6;

  if(isDefined(var_7)) {
    var_8.player_init_func = var_7;
  }

  level.encounter_score_components[var_0] = var_8;
}

function has_eog_score_component(var_0) {
  return has_score_component_internal(level.eog_score_components, var_0);
}

function has_score_component_internal(var_0, var_1) {
  if(is_scoring_disabled()) {
    return false;
  }

  if(!isDefined(var_0)) {
    return false;
  }

  return isDefined(var_0[var_1]);
}

function is_scoring_disabled() {
  if(isDefined(level.isscoringdisabled)) {
    return [[level.isscoringdisabled]]();
  }

  return 0;
}

function init_player_score() {
  if(is_scoring_disabled()) {
    return;
  }

  self.encounter_performance = [];
  self.end_game_score = [];
  component_specific_init(self);
  reset_player_encounter_performance(self);
  reset_end_game_score();
}

function component_specific_init(var_0) {
  foreach(var_2 in level.encounter_score_components) {
    if(isDefined(var_2.player_init_func)) {
      [[var_2.player_init_func]](var_0);
    }
  }
}

function reset_player_encounter_performance(var_0) {
  foreach(var_2 in level.encounter_score_components) {
    if(isDefined(var_2.reset_player_performance_func)) {
      [[var_2.reset_player_performance_func]](var_0);
    }
  }
}

function reset_end_game_score() {
  foreach(var_1 in level.eog_score_components) {
    self.end_game_score[var_2] = 0;
  }
}

function reset_encounter_performance() {
  foreach(var_1 in level.encounter_score_components) {
    if(isDefined(var_1.reset_team_performance_func)) {
      [[var_1.reset_team_performance_func]](var_1);
    }
  }

  reset_players_encounter_performance_and_lua();
}

function reset_players_encounter_performance_and_lua() {
  foreach(var_1 in level.players) {
    reset_player_encounter_performance(var_1);
    reset_player_encounter_lua_omnvars(var_1);
  }
}

function calculate_players_total_end_game_score(var_0) {
  if(is_scoring_disabled()) {
    return;
  }

  if(isDefined(level.endgameencounterscorefunc)) {
    [[level.endgameencounterscorefunc]](var_0);
  }

  foreach(var_2 in level.players) {
    calculate_total_end_game_score(var_2);
  }
}

function calculate_total_end_game_score(var_0) {
  var_1 = 1;
  var_2 = 0;

  foreach(var_4 in level.eog_score_components) {
    var_5 = var_0.end_game_score[var_6];
    var_1++;
    var_2 += var_5;
  }
}

function calculate_and_show_encounter_scores(var_0, var_1) {
  calculate_encounter_scores(var_0, var_1);
  show_encounter_scores();
}

function calculate_encounter_scores(var_0, var_1, var_2) {
  foreach(var_4 in var_0) {
    calculate_player_encounter_scores(var_4, var_1, var_2);
  }
}

function calculate_player_encounter_scores(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = 0;

  foreach(var_6 in var_1) {
    var_7 = level.encounter_score_components[var_6];
    var_8 = [[var_7.calculate_func]](var_0, var_7);
    var_8 *= level.cycle_score_scalar;
    var_8 = int(var_8);
    var_0.end_game_score[var_7.end_game_score_component_ref] += var_8;
    set_lua_encounter_score_row(var_0, var_3, var_7.lua_string_index, var_8);
    var_4 += var_8;
    var_3++;
  }

  if(isDefined(level.bonusscorefunc)) {
    var_10 = [[level.bonusscorefunc]](var_0, var_4);
    var_4 += var_10.amount;
    set_lua_encounter_score_row(var_0, var_3, var_10.ui_string_index, var_10.amount);
    var_3++;
  }

  set_lua_encounter_score_row(var_0, var_3, 6, var_4);
  var_3++;

  if(isDefined(level.postencounterscorefunc)) {
    [[level.postencounterscorefunc]](var_0, var_4, var_3);
    return;
  }
}

function round_up_to_nearest(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_2 = ceil(var_2);
  return int(var_2 * var_1);
}

function update_players_encounter_performance(var_0, var_1, var_2) {
  foreach(var_4 in level.players) {
    update_personal_encounter_performance(var_4, var_0, var_1, var_2);
  }
}

function update_personal_encounter_performance(var_0, var_1, var_2) {
  if(!has_encounter_score_component(var_0)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  self.encounter_performance = update_encounter_performance_internal(self.encounter_performance, var_1, var_2);
}

function update_encounter_performance_internal(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  var_0 = var_0[var_1] + var_2;
  return var_0;
}

function get_team_encounter_performance(var_0, var_1) {
  return var_0.team_encounter_performance[var_1];
}

function has_encounter_score_component(var_0) {
  return has_score_component_internal(level.encounter_score_components, var_0);
}

function get_player_encounter_performance(var_0, var_1) {
  return var_0.encounter_performance[var_1];
}

function calculate_under_max_score(var_0, var_1, var_2) {
  var_3 = clamp(var_1 - var_0, 0, var_1);
  return int(var_3 / var_1 * var_2);
}

function update_team_encounter_performance(var_0, var_1, var_2) {
  if(!has_encounter_score_component(var_0)) {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  level.encounter_score_components[var_0].team_encounter_performance[var_1] += var_2;
}

function blank_score_component_init(var_0) {
  return var_0;
}

function get_team_score_component_name() {
  return scripts\engine\utility::ter_op(isDefined(level.team_score_component_name), level.team_score_component_name, "team");
}

function reset_player_encounter_lua_omnvars(var_0) {
  var_1 = 8;

  for(var_2 = 1; var_2 <= var_1; var_2++) {
    var_3 = "ui_alien_encounter_title_row_" + var_2;
    var_4 = "ui_alien_encounter_score_row_" + var_2;
    var_0 setclientomnvar(var_3, 0);
    var_0 setclientomnvar(var_4, 0);
  }
}

function set_lua_eog_score_row(var_0, var_1, var_2, var_3) {
  var_4 = "zm_ui_eog_title_row_" + var_1;
  var_5 = "zm_ui_eog_title_row_" + var_1;
  var_0 setclientomnvar(var_4, var_2);
  var_0 setclientomnvar(var_5, var_3);
}

function show_encounter_scores() {
  level endon("game_ended ");
  setomnvar("zm_ui_show_encounter_score", 1);
  wait 1;
  setomnvar("zm_ui_show_encounter_score", 0);
}

function set_lua_encounter_score_row(var_0, var_1, var_2, var_3) {
  var_4 = "ui_alien_encounter_title_row_" + var_1;
  var_5 = "ui_alien_encounter_score_row_" + var_1;
}

function processassist(var_0, var_1, var_2) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  ref_128A5(var_0, var_1, var_2);
}

function ref_128A5(var_0, var_1, var_2) {
  self endon("disconnect");
  var_0 endon("disconnect");

  if(isDefined(var_1) && var_1.basename == "white_phosphorus_proj_mp") {
    return;
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_0.ismarkedtarget)) {
    var_4 = var_0.attackers;
    var_3 = 1;
  }

  if(isDefined(var_0.markedbyboomperk)) {
    var_5 = var_0.markedbyboomperk;
  }

  wait 0.05;
  scripts\asm\soldier\mp\melee::waittillslowprocessallowed();
  var_6 = self.pers["team"];

  if(!scripts\cp\utility::isgameplayteam(var_6)) {
    return;
  }

  if(isPlayer(var_0) && isDefined(var_0.pers)) {
    if(var_6 == var_0.pers["team"] && level.teambased) {
      return;
    }
  }

  var_7 = undefined;
  var_8 = "assist";

  if(!level.teambased) {
    var_8 = "assist_ffa";
  }

  var_9 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_8);

  if(!level.teambased) {
    var_7 = var_9 + var_9 * var_2;
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assist_ffa", var_1, var_7);
  } else if(isDefined(var_5) && scripts\engine\utility::array_contains_key(var_5, scripts\cp\utility::getuniqueid())) {
    thread scripts\cp\agents\gametype_cp_wave_sv::givestreakpointswithtext("assist_ping", var_1, undefined);
  } else {
    var_7 = var_9 + var_9 * var_2;
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assist", var_1, var_7);
  }

  if(level.teambased) {
    var_10 = scripts\common\utility::playersinsphere(self.origin, 300);

    foreach(var_12 in var_10) {
      if(self.team != var_12.team || self == var_12) {
        continue;
      }

      if(!scripts\cp\utility\player::isreallyalive(var_12)) {
        continue;
      }

      self.modifiers["buddy_kill"] = 1;
      break;
    }
  }

  if(scripts\cp\utility::_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      if(!scripts\cp\utility::iskillstreakweapon(var_1) && !scripts\cp\utility::issuperweapon(var_1)) {
        thread scripts\cp\agents\gametype_cp_wave_sv::givestreakpointswithtext("assist_hardline", var_1, 1);
      }
    }

    self notify("assist_hardline");
  }

  if(self.pers["assists"] < 998) {
    scripts\cp\agents\agents::incpersstat("assists", 1);
    self.assists = scripts\cp\agents\agents::getpersstat("assists");
  }

  scripts\asm\soldier\mp\melee::bufferednotify("assist_buffered", self.modifiers);
  thread scripts\mp\ammorestock::onplayerkillassist(var_0);
}