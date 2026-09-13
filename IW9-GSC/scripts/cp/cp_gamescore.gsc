/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_gamescore.gsc
***********************************************/

init_gamescore() {
  register_scoring_mode();
}

register_scoring_mode() {
  if(scripts\cp\utility::isplayingsolo())
    setomnvar("zm_ui_is_solo", 1);
  else
    setomnvar("zm_ui_is_solo", 0);
}

register_eog_score_component(_id_D5E812DC0C8DE8A0, lua_string_index) {
  if(!isDefined(level.eog_score_components))
    level.eog_score_components = [];

  _id_E5975EC44088F591 = spawnStruct();
  _id_E5975EC44088F591.lua_string_index = lua_string_index;
  level.eog_score_components[_id_D5E812DC0C8DE8A0] = _id_E5975EC44088F591;
}

register_encounter_score_component(_id_D5E812DC0C8DE8A0, init_func, reset_team_performance_func, reset_player_performance_func, calculate_func, lua_string_index, end_game_score_component_ref, player_init_func) {
  _id_E5975EC44088F591 = spawnStruct();
  _id_E5975EC44088F591 = [[init_func]](_id_E5975EC44088F591);
  _id_E5975EC44088F591.reset_team_performance_func = reset_team_performance_func;
  _id_E5975EC44088F591.reset_player_performance_func = reset_player_performance_func;
  _id_E5975EC44088F591.calculate_func = calculate_func;
  _id_E5975EC44088F591.lua_string_index = lua_string_index;
  _id_E5975EC44088F591.end_game_score_component_ref = end_game_score_component_ref;

  if(isDefined(player_init_func))
    _id_E5975EC44088F591.player_init_func = player_init_func;

  level.encounter_score_components[_id_D5E812DC0C8DE8A0] = _id_E5975EC44088F591;
}

has_eog_score_component(_id_5654C767628C0591) {
  return has_score_component_internal(level.eog_score_components, _id_5654C767628C0591);
}

has_score_component_internal(_id_80F2FA99271C0666, _id_5654C767628C0591) {
  if(is_scoring_disabled())
    return 0;

  if(!isDefined(_id_80F2FA99271C0666))
    return 0;

  return isDefined(_id_80F2FA99271C0666[_id_5654C767628C0591]);
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

component_specific_init(player) {
  foreach(_id_A475D6DAA5DD7242, _id_E5975EC44088F591 in level.encounter_score_components) {
    if(isDefined(_id_E5975EC44088F591.player_init_func))
      [[_id_E5975EC44088F591.player_init_func]](player);
  }
}

reset_player_encounter_performance(player) {
  foreach(_id_A475D6DAA5DD7242, _id_E5975EC44088F591 in level.encounter_score_components) {
    if(isDefined(_id_E5975EC44088F591.reset_player_performance_func))
      [[_id_E5975EC44088F591.reset_player_performance_func]](player);
  }
}

reset_end_game_score() {
  foreach(_id_E16956C20A49272C, _id_E5975EC44088F591 in level.eog_score_components)
  self.end_game_score[_id_E16956C20A49272C] = 0;
}

reset_encounter_performance() {
  foreach(_id_A475D6DAA5DD7242, _id_E5975EC44088F591 in level.encounter_score_components) {
    if(isDefined(_id_E5975EC44088F591.reset_team_performance_func))
      [[_id_E5975EC44088F591.reset_team_performance_func]](_id_E5975EC44088F591);
  }

  reset_players_encounter_performance_and_lua();
}

reset_players_encounter_performance_and_lua() {
  foreach(player in level.players) {
    reset_player_encounter_performance(player);
    reset_player_encounter_lua_omnvars(player);
  }
}

calculate_players_total_end_game_score(override) {
  if(is_scoring_disabled()) {
    return;
  }
  if(isDefined(level.endgameencounterscorefunc))
    [[level.endgameencounterscorefunc]](override);

  foreach(player in level.players)
  calculate_total_end_game_score(player);
}

calculate_total_end_game_score(player) {
  _id_5732EFF28B14AF01 = 1;
  _id_5599A35B585B0733 = 0;

  foreach(_id_10EA2AF8F615D10F, _id_5784E2E019B558B5 in level.eog_score_components) {
    _id_42829E2108C7C16D = player.end_game_score[_id_10EA2AF8F615D10F];
    _id_5732EFF28B14AF01++;
    _id_5599A35B585B0733 = _id_5599A35B585B0733 + _id_42829E2108C7C16D;
  }
}

calculate_and_show_encounter_scores(_id_ECDDB34473DD4732, _id_DF48775871133666) {
  calculate_encounter_scores(_id_ECDDB34473DD4732, _id_DF48775871133666);
  show_encounter_scores();
}

calculate_encounter_scores(_id_ECDDB34473DD4732, _id_DF48775871133666, override) {
  foreach(player in _id_ECDDB34473DD4732)
  calculate_player_encounter_scores(player, _id_DF48775871133666, override);
}

calculate_player_encounter_scores(player, _id_DF48775871133666, override) {
  _id_5732EFF28B14AF01 = 1;
  _id_4AE450CE67662CE0 = 0;

  foreach(_id_5654C767628C0591 in _id_DF48775871133666) {
    _id_41A9C90605002D6F = level.encounter_score_components[_id_5654C767628C0591];
    _id_54B36399D6815CA7 = [[_id_41A9C90605002D6F.calculate_func]](player, _id_41A9C90605002D6F);
    _id_54B36399D6815CA7 = _id_54B36399D6815CA7 * level.cycle_score_scalar;
    _id_54B36399D6815CA7 = int(_id_54B36399D6815CA7);
    player.end_game_score[_id_41A9C90605002D6F.end_game_score_component_ref] = player.end_game_score[_id_41A9C90605002D6F.end_game_score_component_ref] + _id_54B36399D6815CA7;
    set_lua_encounter_score_row(player, _id_5732EFF28B14AF01, _id_41A9C90605002D6F.lua_string_index, _id_54B36399D6815CA7);
    _id_4AE450CE67662CE0 = _id_4AE450CE67662CE0 + _id_54B36399D6815CA7;
    _id_5732EFF28B14AF01++;
  }

  if(isDefined(level.bonusscorefunc)) {
    _id_2AD6C5502CBBD27D = [[level.bonusscorefunc]](player, _id_4AE450CE67662CE0);
    _id_4AE450CE67662CE0 = _id_4AE450CE67662CE0 + _id_2AD6C5502CBBD27D.amount;
    set_lua_encounter_score_row(player, _id_5732EFF28B14AF01, _id_2AD6C5502CBBD27D.ui_string_index, _id_2AD6C5502CBBD27D.amount);
    _id_5732EFF28B14AF01++;
  }

  set_lua_encounter_score_row(player, _id_5732EFF28B14AF01, 6, _id_4AE450CE67662CE0);
  _id_5732EFF28B14AF01++;

  if(isDefined(level.postencounterscorefunc))
    [[level.postencounterscorefunc]](player, _id_4AE450CE67662CE0, _id_5732EFF28B14AF01);
}

round_up_to_nearest(_id_F06AFD7746575927, base) {
  _id_75B10A88AD0D8395 = _id_F06AFD7746575927 / base;
  _id_75B10A88AD0D8395 = ceil(_id_75B10A88AD0D8395);
  return int(_id_75B10A88AD0D8395 * base);
}

update_players_encounter_performance(_id_5654C767628C0591, _id_4BFB21EEF0D73C62, amount) {
  foreach(player in level.players)
  player update_personal_encounter_performance(_id_5654C767628C0591, _id_4BFB21EEF0D73C62, amount);
}

update_personal_encounter_performance(_id_5654C767628C0591, _id_4BFB21EEF0D73C62, amount) {
  if(!has_encounter_score_component(_id_5654C767628C0591)) {
    return;
  }
  if(!isPlayer(self)) {
    return;
  }
  self.encounter_performance = update_encounter_performance_internal(self.encounter_performance, _id_4BFB21EEF0D73C62, amount);
}

update_encounter_performance_internal(_id_AD73B325AEB8D58E, _id_4BFB21EEF0D73C62, amount) {
  if(!isDefined(amount))
    amount = 1;

  _id_AD73B325AEB8D58E[_id_4BFB21EEF0D73C62] = _id_AD73B325AEB8D58E[_id_4BFB21EEF0D73C62] + amount;
  return _id_AD73B325AEB8D58E;
}

get_team_encounter_performance(_id_41A9C90605002D6F, _id_4BFB21EEF0D73C62) {
  return _id_41A9C90605002D6F.team_encounter_performance[_id_4BFB21EEF0D73C62];
}

has_encounter_score_component(_id_5654C767628C0591) {
  return has_score_component_internal(level.encounter_score_components, _id_5654C767628C0591);
}

get_player_encounter_performance(player, _id_4BFB21EEF0D73C62) {
  return player.encounter_performance[_id_4BFB21EEF0D73C62];
}

calculate_under_max_score(_id_CABD9E1D57839959, _id_AF5C9161064BFD0D, _id_9D3207145B5E514C) {
  _id_251E7690721C4668 = clamp(_id_AF5C9161064BFD0D - _id_CABD9E1D57839959, 0, _id_AF5C9161064BFD0D);
  return int(_id_251E7690721C4668 / _id_AF5C9161064BFD0D * _id_9D3207145B5E514C);
}

update_team_encounter_performance(_id_5654C767628C0591, _id_4BFB21EEF0D73C62, amount) {
  if(!has_encounter_score_component(_id_5654C767628C0591)) {
    return;
  }
  if(!isDefined(amount))
    amount = 1;

  level.encounter_score_components[_id_5654C767628C0591].team_encounter_performance[_id_4BFB21EEF0D73C62] = level.encounter_score_components[_id_5654C767628C0591].team_encounter_performance[_id_4BFB21EEF0D73C62] + amount;
}

blank_score_component_init(_id_41A9C90605002D6F) {
  return _id_41A9C90605002D6F;
}

get_team_score_component_name() {
  return scripts\engine\utility::ter_op(isDefined(level.team_score_component_name), level.team_score_component_name, "team");
}

reset_player_encounter_lua_omnvars(player) {
  _id_389CF859982E0A0A = 8;

  for(_id_5732EFF28B14AF01 = 1; _id_5732EFF28B14AF01 <= _id_389CF859982E0A0A; _id_5732EFF28B14AF01++) {
    _id_80A7169CDFFB7AFD = "ui_alien_encounter_title_row_" + _id_5732EFF28B14AF01;
    _id_FE5CD0BF7F32E381 = "ui_alien_encounter_score_row_" + _id_5732EFF28B14AF01;
    player setclientomnvar(_id_80A7169CDFFB7AFD, 0);
    player setclientomnvar(_id_FE5CD0BF7F32E381, 0);
  }
}

set_lua_eog_score_row(player, _id_5732EFF28B14AF01, _id_C9DE11C82E860046, _id_633E0F5F80136222) {
  _id_97C477C244A6D4CB = "zm_ui_eog_title_row_" + _id_5732EFF28B14AF01;
  _id_AEDD7CEAC3E6136F = "zm_ui_eog_title_row_" + _id_5732EFF28B14AF01;
  player setclientomnvar(_id_97C477C244A6D4CB, _id_C9DE11C82E860046);
  player setclientomnvar(_id_AEDD7CEAC3E6136F, _id_633E0F5F80136222);
}

show_encounter_scores() {
  level endon("game_ended ");
  setomnvar("zm_ui_show_encounter_score", 1);
  wait 1.0;
  setomnvar("zm_ui_show_encounter_score", 0);
}

set_lua_encounter_score_row(player, _id_5732EFF28B14AF01, _id_C9DE11C82E860046, _id_633E0F5F80136222) {
  _id_97C477C244A6D4CB = "ui_alien_encounter_title_row_" + _id_5732EFF28B14AF01;
  _id_AEDD7CEAC3E6136F = "ui_alien_encounter_score_row_" + _id_5732EFF28B14AF01;
}

processassist(killedplayer, objweapon, _id_54351D786449EE9E) {
  if(isDefined(level.assists_disabled)) {
    return;
  }
  processassist_regularcp(killedplayer, objweapon, _id_54351D786449EE9E);
}

processassist_regularcp(killedplayer, objweapon, _id_54351D786449EE9E) {
  self endon("disconnect");
  killedplayer endon("disconnect");

  if(isDefined(objweapon) && objweapon.basename == "white_phosphorus_proj_mp") {
    return;
  }
  if(!isDefined(_id_54351D786449EE9E))
    _id_54351D786449EE9E = 0;

  markedbyboomperk = undefined;

  if(isDefined(killedplayer.markedbyboomperk))
    markedbyboomperk = killedplayer.markedbyboomperk;

  wait 0.05;
  scripts\cp\utility\script::waittillslowprocessallowed();
  _id_B47248E0C4294FA4 = self.pers["team"];

  if(!scripts\cp\utility::isgameplayteam(_id_B47248E0C4294FA4)) {
    return;
  }
  if(isPlayer(killedplayer) && isDefined(killedplayer.pers)) {
    if(_id_B47248E0C4294FA4 == killedplayer.pers["team"] && level.teambased)
      return;
  }

  _id_91185FF4A2E16A72 = undefined;
  event = "assist";

  if(!level.teambased)
    event = "assist_ffa";

  points = _id_187A04151C40FB72::getscoreinfovalue(event);

  if(!level.teambased) {
    _id_91185FF4A2E16A72 = points + points * _id_54351D786449EE9E;
    thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_FE68DFA78D19874E", objweapon, _id_91185FF4A2E16A72);
  } else if(isDefined(markedbyboomperk) && scripts\engine\utility::array_contains_key(markedbyboomperk, scripts\cp\utility::getuniqueid()))
    thread _id_41AE4F5CA24216CB::givestreakpointswithtext("stat_8C8AAC25BCC4EE97", objweapon, undefined);
  else {
    _id_91185FF4A2E16A72 = points + points * _id_54351D786449EE9E;
    thread _id_41AE4F5CA24216CB::_id_0366980B6A8796AE("stat_8FCF8BBD78A0502E", objweapon, _id_91185FF4A2E16A72);
  }

  if(level.teambased) {
    _id_EF269077A28646EB = scripts\common\utility::playersinsphere(self.origin, 300);

    foreach(player in _id_EF269077A28646EB) {
      if(self.team != player.team || self == player) {
        continue;
      }
      if(!scripts\cp\utility\player::isreallyalive(player)) {
        continue;
      }
      self.modifiers["buddy_kill"] = 1;
      break;
    }
  }

  if(scripts\cp\utility::_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      if(!_id_2669878CF5A1B6BC::iskillstreakweapon(objweapon) && !scripts\cp\utility::issuperweapon(objweapon))
        thread _id_41AE4F5CA24216CB::givestreakpointswithtext("stat_D3C055A940235D0C", objweapon, 1);
    }

    self notify("assist_hardline");
  }

  if(self.pers["assists"] < 998) {
    scripts\cp\cp_matchdata::incpersstat("assists", 1);
    self.assists = scripts\cp\cp_matchdata::getpersstat("assists");
  }

  scripts\cp\utility\script::bufferednotify("assist_buffered", self.modifiers);
  thread scripts\cp\cp_challenge::onplayerkillassist(killedplayer);
}