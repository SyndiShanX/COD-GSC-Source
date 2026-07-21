/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_gamescore.gsc
***********************************************/

init_gamescore() {
  register_scoring_mode();
}

register_scoring_mode() {
  if(scripts\cp\utility::isplayingsolo())
    setomnvar("_encstr_8DF10E680FE71B6359FC26385272A180", 1);
  else
    setomnvar("_encstr_8DF10E680FE71B6359FC26385272A180", 0);
}

register_eog_score_component(var_0, var_1) {
  if(!isDefined(level.eog_score_components))
    level.eog_score_components = [];

  var_2 = spawnStruct();
  var_2.lua_string_index = var_1;
  level.eog_score_components[var_0] = var_2;
}

register_encounter_score_component(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = spawnStruct();
  var_8 = [[var_1]](var_8);
  var_8.reset_team_performance_func = var_2;
  var_8.reset_player_performance_func = var_3;
  var_8.calculate_func = var_4;
  var_8.lua_string_index = var_5;
  var_8.end_game_score_component_ref = var_6;

  if(isDefined(var_7))
    var_8.player_init_func = var_7;

  level.encounter_score_components[var_0] = var_8;
}

has_eog_score_component(var_0) {
  return has_score_component_internal(level.eog_score_components, var_0);
}

has_score_component_internal(var_0, var_1) {
  if(is_scoring_disabled())
    return 0;

  if(!isDefined(var_0))
    return 0;

  return isDefined(var_0[var_1]);
}

is_scoring_disabled() {
  if(isDefined(level.isscoringdisabled))
    return [[level.isscoringdisabled]]();

  return 0;
}

init_player_score() {
  if(is_scoring_disabled()) {
    return;
  }
  self.encounter_performance = [];
  self.end_game_score = [];
  component_specific_init(self);
  reset_player_encounter_performance(self);
  reset_end_game_score();
}

component_specific_init(var_0) {
  foreach(var_3, var_2 in level.encounter_score_components) {
    if(isDefined(var_2.player_init_func))
      [[var_2.player_init_func]](var_0);
  }
}

reset_player_encounter_performance(var_0) {
  foreach(var_3, var_2 in level.encounter_score_components) {
    if(isDefined(var_2.reset_player_performance_func))
      [[var_2.reset_player_performance_func]](var_0);
  }
}

reset_end_game_score() {
  foreach(var_2, var_1 in level.eog_score_components)
  self.end_game_score[var_2] = 0;
}

reset_encounter_performance() {
  foreach(var_2, var_1 in level.encounter_score_components) {
    if(isDefined(var_1.reset_team_performance_func))
      [[var_1.reset_team_performance_func]](var_1);
  }

  reset_players_encounter_performance_and_lua();
}

reset_players_encounter_performance_and_lua() {
  foreach(var_1 in level.players) {
    reset_player_encounter_performance(var_1);
    reset_player_encounter_lua_omnvars(var_1);
  }
}

calculate_players_total_end_game_score(var_0) {
  if(is_scoring_disabled()) {
    return;
  }
  if(isDefined(level.endgameencounterscorefunc))
    [[level.endgameencounterscorefunc]](var_0);

  foreach(var_2 in level.players)
  calculate_total_end_game_score(var_2);
}

calculate_total_end_game_score(var_0) {
  var_1 = 1;
  var_2 = 0;

  foreach(var_6, var_4 in level.eog_score_components) {
    var_5 = var_0.end_game_score[var_6];
    var_1++;
    var_2 = var_2 + var_5;
  }
}

calculate_and_show_encounter_scores(var_0, var_1) {
  calculate_encounter_scores(var_0, var_1);
  show_encounter_scores();
}

calculate_encounter_scores(var_0, var_1, var_2) {
  foreach(var_4 in var_0)
  calculate_player_encounter_scores(var_4, var_1, var_2);
}

calculate_player_encounter_scores(var_0, var_1, var_2) {
  var_3 = 1;
  var_4 = 0;

  foreach(var_6 in var_1) {
    var_7 = level.encounter_score_components[var_6];
    var_8 = [[var_7.calculate_func]](var_0, var_7);
    var_8 = var_8 * level.cycle_score_scalar;
    var_8 = int(var_8);
    var_0.end_game_score[var_7.end_game_score_component_ref] = var_0.end_game_score[var_7.end_game_score_component_ref] + var_8;
    set_lua_encounter_score_row(var_0, var_3, var_7.lua_string_index, var_8);
    var_4 = var_4 + var_8;
    var_3++;
  }

  if(isDefined(level.bonusscorefunc)) {
    var_10 = [[level.bonusscorefunc]](var_0, var_4);
    var_4 = var_4 + var_10.amount;
    set_lua_encounter_score_row(var_0, var_3, var_10.ui_string_index, var_10.amount);
    var_3++;
  }

  set_lua_encounter_score_row(var_0, var_3, 6, var_4);
  var_3++;

  if(isDefined(level.postencounterscorefunc))
    [[level.postencounterscorefunc]](var_0, var_4, var_3);
}

round_up_to_nearest(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_2 = ceil(var_2);
  return int(var_2 * var_1);
}

update_players_encounter_performance(var_0, var_1, var_2) {
  foreach(var_4 in level.players)
  var_4 update_personal_encounter_performance(var_0, var_1, var_2);
}

update_personal_encounter_performance(var_0, var_1, var_2) {
  if(!has_encounter_score_component(var_0)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self.encounter_performance = update_encounter_performance_internal(self.encounter_performance, var_1, var_2);
}

update_encounter_performance_internal(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  var_0[var_1] = var_0[var_1] + var_2;
  return var_0;
}

get_team_encounter_performance(var_0, var_1) {
  return var_0.team_encounter_performance[var_1];
}

has_encounter_score_component(var_0) {
  return has_score_component_internal(level.encounter_score_components, var_0);
}

get_player_encounter_performance(var_0, var_1) {
  return var_0.encounter_performance[var_1];
}

calculate_under_max_score(var_0, var_1, var_2) {
  var_3 = clamp(var_1 - var_0, 0, var_1);
  return int(var_3 / var_1 * var_2);
}

update_team_encounter_performance(var_0, var_1, var_2) {
  if(!has_encounter_score_component(var_0)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 1;

  level.encounter_score_components[var_0].team_encounter_performance[var_1] = level.encounter_score_components[var_0].team_encounter_performance[var_1] + var_2;
}

blank_score_component_init(var_0) {
  return var_0;
}

get_team_score_component_name() {
  return scripts\engine\utility::ter_op(isDefined(level.team_score_component_name), level.team_score_component_name, "_encstr_8AEF05472BC2D6");
}

reset_player_encounter_lua_omnvars(var_0) {
  var_1 = 8;

  for(var_2 = 1; var_2 <= var_1; var_2++) {
    var_3 = "_encstr_8C441ED55A7D2CC65A5973AF2BB936F6EAB98EB29CBEA34B1D36AC7D4EDBDDF5" + var_2;
    var_4 = "_encstr_A6E01E575ABEB0B196B2E67DCADC6CBD5D9BD19527BEDCC6BDC995FA39EDDD7D" + var_2;
    var_0 setclientomnvar(var_3, 0);
    var_0 setclientomnvar(var_4, 0);
  }
}

set_lua_eog_score_row(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_B6A9159EADAFEA4BF5B2BD9DD7A35A1D63CAFA39DBDDBE" + var_1;
  var_5 = "_encstr_B6A9159EADAFEA4BF5B2BD9DD7A35A1D63CAFA39DBDDBE" + var_1;
  var_0 setclientomnvar(var_4, var_2);
  var_0 setclientomnvar(var_5, var_3);
}

show_encounter_scores() {
  level endon("_encstr_BD710C3A61F9C78170BD0C15B182");
  setomnvar("_encstr_866A1B9EDABE575AEB370D7BEEAFACB91BBD5DB9D1B24EF5E61BED392B", 1);
  wait 1.0;
  setomnvar("_encstr_866A1B9EDABE575AEB370D7BEEAFACB91BBD5DB9D1B24EF5E61BED392B", 0);
}

set_lua_encounter_score_row(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_8C441ED55A7D2CC65A5973AF2BB936F6EAB98EB29CBEA34B1D36AC7D4EDBDDF5" + var_1;
  var_5 = "_encstr_A6E01E575ABEB0B196B2E67DCADC6CBD5D9BD19527BEDCC6BDC995FA39EDDD7D" + var_1;
}

processassist(var_0, var_1, var_2) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  _id_128A5(var_0, var_1, var_2);
}

_id_128A5(var_0, var_1, var_2) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(isDefined(var_1) && var_1.basename == "_encstr_95DB19EB1C61A8BDE1DBF1F7FF3B73281233136682C2B8E219B7F9") {
    return;
  }
  if(!isDefined(var_2))
    var_2 = 0;

  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(var_0.ismarkedtarget)) {
    var_4 = var_0.attackers;
    var_3 = 1;
  }

  if(isDefined(var_0.markedbyboomperk))
    var_5 = var_0.markedbyboomperk;

  wait 0.05;
  scripts\asm\soldier\mp\melee::waittillslowprocessallowed();
  var_6 = self.pers["_encstr_8AEF05472BC2D6"];

  if(!scripts\cp\utility::isgameplayteam(var_6)) {
    return;
  }
  if(isPlayer(var_0) && isDefined(var_0.pers)) {
    if(var_6 == var_0.pers["_encstr_8AEF05472BC2D6"] && level.teambased)
      return;
  }

  var_7 = undefined;
  var_8 = "_encstr_A1BD075837DCD29B47";

  if(!level.teambased)
    var_8 = "_encstr_91A70B13A312807E13497961B2";

  var_9 = scripts\cp\drone\emp_drone::getscoreinfovalue(var_8);

  if(!level.teambased) {
    var_7 = var_9 + var_9 * var_2;
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_91A70B13A312807E13497961B2", var_1, var_7);
  } else if(isDefined(var_5) && scripts\engine\utility::array_contains_key(var_5, scripts\cp\utility::getuniqueid()))
    thread scripts\cp\agents\gametype_cp_wave_sv::givestreakpointswithtext("_encstr_87250CAFCF9EB253B8FE125C30C8", var_1, undefined);
  else {
    var_7 = var_9 + var_9 * var_2;
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_A1BD075837DCD29B47", var_1, var_7);
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
      self.modifiers["_encstr_A7220B9A13D8E7E7A86082DAA8"] = 1;
      break;
    }
  }

  if(scripts\cp\utility::_hasperk("_encstr_B60B139B8B686E2A10B149A887D9E7EB894AC4E00F") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["_encstr_A1F308589BCD96CD476E"] == 1) {
      if(!scripts\cp\utility::iskillstreakweapon(var_1) && !scripts\cp\utility::issuperweapon(var_1))
        thread scripts\cp\agents\gametype_cp_wave_sv::givestreakpointswithtext("_encstr_8CA910EFF003194391D09CD6AE696AD108F8", var_1, 1);
    }

    self notify("_encstr_8CA910EFF003194391D09CD6AE696AD108F8");
  }

  if(self.pers["_encstr_A1F308589BCD96CD476E"] < 998) {
    scripts\cp\agents\agents::incpersstat("_encstr_A1F308589BCD96CD476E", 1);
    self.assists = scripts\cp\agents\agents::getpersstat("_encstr_A1F308589BCD96CD476E");
  }

  scripts\asm\soldier\mp\melee::bufferednotify("_encstr_A3F1104953AFEBC04B0F8DAB5EB7082E9FBA", self.modifiers);
  thread scripts\mp\ammorestock::onplayerkillassist(var_0);
}