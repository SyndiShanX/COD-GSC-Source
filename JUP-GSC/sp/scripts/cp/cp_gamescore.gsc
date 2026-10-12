/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_gamescore.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\cp\cp_challenge;
#using scripts\cp\cp_matchdata;
#using scripts\cp\points;
#using scripts\cp\rank;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\utility\script;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace cp_gamescore;

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

function register_eog_score_component(name_ref, lua_string_index) {
  if(!isDefined(level.eog_score_components)) {
    level.eog_score_components = [];
  }

  score_component = spawnStruct();
  score_component.lua_string_index = lua_string_index;
  level.eog_score_components[name_ref] = score_component;
}

function register_encounter_score_component(name_ref, init_func, reset_team_performance_func, reset_player_performance_func, calculate_func, lua_string_index, end_game_score_component_ref, player_init_func) {
  assertex(has_eog_score_component(end_game_score_component_ref), "'" + end_game_score_component_ref + "' eog game component has not been registered.");
  score_component = spawnStruct();
  score_component = [[init_func]](score_component);
  score_component.reset_team_performance_func = reset_team_performance_func;
  score_component.reset_player_performance_func = reset_player_performance_func;
  score_component.calculate_func = calculate_func;
  score_component.lua_string_index = lua_string_index;
  score_component.end_game_score_component_ref = end_game_score_component_ref;

  if(isDefined(player_init_func)) {
    score_component.player_init_func = player_init_func;
  }

  level.encounter_score_components[name_ref] = score_component;
}

function has_eog_score_component(score_component_name) {
  return has_score_component_internal(level.eog_score_components, score_component_name);
}

function has_score_component_internal(var_80f2fa99271c0666, score_component_name) {
  if(is_scoring_disabled()) {
    return false;
  }

  if(!isDefined(var_80f2fa99271c0666)) {
    return false;
  }

  return isDefined(var_80f2fa99271c0666[score_component_name]);
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

function component_specific_init(player) {
  foreach(score_component in level.encounter_score_components) {
    if(isDefined(score_component.player_init_func)) {
      [[score_component.player_init_func]](player);
    }
  }
}

function reset_player_encounter_performance(player) {
  foreach(score_component in level.encounter_score_components) {
    if(isDefined(score_component.reset_player_performance_func)) {
      [[score_component.reset_player_performance_func]](player);
    }
  }
}

function reset_end_game_score() {
  foreach(score_component in level.eog_score_components) {
    self.end_game_score[var_e16956c20a49272c] = 0;
  }
}

function reset_encounter_performance() {
  foreach(score_component in level.encounter_score_components) {
    if(isDefined(score_component.reset_team_performance_func)) {
      [[score_component.reset_team_performance_func]](score_component);
    }
  }

  reset_players_encounter_performance_and_lua();
}

function reset_players_encounter_performance_and_lua() {
  foreach(player in level.players) {
    reset_player_encounter_performance(player);
    reset_player_encounter_lua_omnvars(player);
  }
}

function calculate_players_total_end_game_score(override) {
  if(is_scoring_disabled()) {
    return;
  }

  if(isDefined(level.endgameencounterscorefunc)) {
    [[level.endgameencounterscorefunc]](override);
  }

  foreach(player in level.players) {
    calculate_total_end_game_score(player);
  }
}

function calculate_total_end_game_score(player) {
  row_number = 1;
  total_end_game_score = 0;

  foreach(var_5784e2e019b558b5 in level.eog_score_components) {
    var_42829e2108c7c16d = player.end_game_score[var_10ea2af8f615d10f];
    row_number++;
    total_end_game_score += var_42829e2108c7c16d;
  }
}

function calculate_and_show_encounter_scores(players_list, var_df48775871133666) {
  calculate_encounter_scores(players_list, var_df48775871133666);
  show_encounter_scores();
}

function calculate_encounter_scores(players_list, var_df48775871133666, override) {
  foreach(player in players_list) {
    calculate_player_encounter_scores(player, var_df48775871133666, override);
  }
}

function calculate_player_encounter_scores(player, var_df48775871133666, override) {
  function_e93a7f76c425af37(player);

  row_number = 1;
  total_score = 0;

  foreach(score_component_name in var_df48775871133666) {
    assertex(isDefined(level.encounter_score_components[score_component_name]), "'" + score_component_name + "' is not a initialized score component");
    var_41a9c90605002d6f = level.encounter_score_components[score_component_name];
    encounter_score = [[var_41a9c90605002d6f.calculate_func]](player, var_41a9c90605002d6f);
    encounter_score *= level.cycle_score_scalar;
    encounter_score = int(encounter_score);
    player.end_game_score[var_41a9c90605002d6f.end_game_score_component_ref] += encounter_score;
    set_lua_encounter_score_row(player, row_number, var_41a9c90605002d6f.lua_string_index, encounter_score);
    total_score += encounter_score;
    row_number++;
  }

  if(isDefined(level.bonusscorefunc)) {
    bonus_score = [[level.bonusscorefunc]](player, total_score);
    total_score += bonus_score.amount;
    set_lua_encounter_score_row(player, row_number, bonus_score.ui_string_index, bonus_score.amount);
    row_number++;
  }

  set_lua_encounter_score_row(player, row_number, 6, total_score);
  row_number++;

  if(isDefined(level.postencounterscorefunc)) {
    [[level.postencounterscorefunc]](player, total_score, row_number);
  }
}

function round_up_to_nearest(cash_amount, base) {
  temp_value = cash_amount / base;
  temp_value = ceil(temp_value);
  return int(temp_value * base);
}

function update_players_encounter_performance(score_component_name, var_4bfb21eef0d73c62, amount) {
  foreach(player in level.players) {
    player update_personal_encounter_performance(score_component_name, var_4bfb21eef0d73c62, amount);
  }
}

function update_personal_encounter_performance(score_component_name, var_4bfb21eef0d73c62, amount) {
  if(!has_encounter_score_component(score_component_name)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  self.encounter_performance = update_encounter_performance_internal(self.encounter_performance, var_4bfb21eef0d73c62, amount);
}

function update_encounter_performance_internal(var_ad73b325aeb8d58e, var_4bfb21eef0d73c62, amount) {
  assertex(isDefined(var_ad73b325aeb8d58e), "Performance list is not defined");
  assertex(isDefined(var_ad73b325aeb8d58e[var_4bfb21eef0d73c62]), "Unknown performance type: " + var_4bfb21eef0d73c62);

  if(!isDefined(amount)) {
    amount = 1;
  }

  var_ad73b325aeb8d58e[var_4bfb21eef0d73c62] += amount;
  return var_ad73b325aeb8d58e;
}

function get_team_encounter_performance(var_41a9c90605002d6f, var_4bfb21eef0d73c62) {
  return var_41a9c90605002d6f.team_encounter_performance[var_4bfb21eef0d73c62];
}

function has_encounter_score_component(score_component_name) {
  return has_score_component_internal(level.encounter_score_components, score_component_name);
}

function get_player_encounter_performance(player, var_4bfb21eef0d73c62) {
  return player.encounter_performance[var_4bfb21eef0d73c62];
}

function calculate_under_max_score(performance, max_limit, max_score) {
  var_251e7690721c4668 = clamp(max_limit - performance, 0, max_limit);
  return int(var_251e7690721c4668 / max_limit * max_score);
}

function update_team_encounter_performance(score_component_name, var_4bfb21eef0d73c62, amount) {
  if(!has_encounter_score_component(score_component_name)) {
    return;
  }

  if(!isDefined(amount)) {
    amount = 1;
  }

  level.encounter_score_components[score_component_name].team_encounter_performance[var_4bfb21eef0d73c62] += amount;
}

function blank_score_component_init(var_41a9c90605002d6f) {
  return var_41a9c90605002d6f;
}

function get_team_score_component_name() {
  return scripts\engine\utility::ter_op(isDefined(level.team_score_component_name), level.team_score_component_name, "team");
}

function reset_player_encounter_lua_omnvars(player) {
  var_389cf859982e0a0a = 8;

  for(row_number = 1; row_number <= var_389cf859982e0a0a; row_number++) {
    var_80a7169cdffb7afd = "ui_alien_encounter_title_row_" + row_number;
    var_fe5cd0bf7f32e381 = "ui_alien_encounter_score_row_" + row_number;
    player setclientomnvar(var_80a7169cdffb7afd, 0);
    player setclientomnvar(var_fe5cd0bf7f32e381, 0);
  }
}

function set_lua_eog_score_row(player, row_number, row_title, row_score) {
  var_97c477c244a6d4cb = "zm_ui_eog_title_row_" + row_number;
  var_aedd7ceac3e6136f = "zm_ui_eog_title_row_" + row_number;
  player setclientomnvar(var_97c477c244a6d4cb, row_title);
  player setclientomnvar(var_aedd7ceac3e6136f, row_score);
}

function show_encounter_scores() {
  level endon("game_ended ");
  setomnvar("zm_ui_show_encounter_score", 1);
  wait 1;
  setomnvar("zm_ui_show_encounter_score", 0);
}

function set_lua_encounter_score_row(player, row_number, row_title, row_score) {
  var_97c477c244a6d4cb = "ui_alien_encounter_title_row_" + row_number;
  var_aedd7ceac3e6136f = "ui_alien_encounter_score_row_" + row_number;
}

function processassist(killedplayer, objweapon, bonusmagnitude) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  processassist_regularcp(killedplayer, objweapon, bonusmagnitude);
}

function processassist_regularcp(killedplayer, objweapon, bonusmagnitude) {
  self endon("disconnect");
  killedplayer endon("disconnect");

  if(isDefined(objweapon) && objweapon.basename == "white_phosphorus_proj_mp") {
    return;
  }

  if(!isDefined(bonusmagnitude)) {
    bonusmagnitude = 0;
  }

  markedbyboomperk = undefined;

  if(isDefined(killedplayer.markedbyboomperk)) {
    markedbyboomperk = killedplayer.markedbyboomperk;
  }

  wait 0.05;
  scripts\cp\utility\script::waittillslowprocessallowed();
  var_b47248e0c4294fa4 = self.pers["team"];

  if(!scripts\cp\utility::isgameplayteam(var_b47248e0c4294fa4)) {
    return;
  }

  if(isPlayer(killedplayer) && isDefined(killedplayer.pers)) {
    if(var_b47248e0c4294fa4 == killedplayer.pers["team"] && level.teambased) {
      return;
    }
  }

  pointsoverride = undefined;
  event = "assist";

  if(!level.teambased) {
    event = "assist_ffa";
  }

  points = scripts\cp\rank::getscoreinfovalue(event);

  if(!level.teambased) {
    pointsoverride = points + points * bonusmagnitude;
    thread scripts\cp\points::doscoreevent(#"assist_ffa", objweapon, pointsoverride);
  } else if(isDefined(markedbyboomperk) && array_contains_key(markedbyboomperk, getuniqueid())) {
    thread givestreakpointswithtext(#"assist_ping", objweapon, undefined);
  } else {
    pointsoverride = points + points * bonusmagnitude;
    thread scripts\cp\points::doscoreevent(#"assist", objweapon, pointsoverride);
  }

  if(level.teambased) {
    nearplayers = utility::playersinsphere(self.origin, 300);

    foreach(player in nearplayers) {
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

  if(_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      if(!iskillstreakweapon(objweapon) && !issuperweapon(objweapon)) {
        thread givestreakpointswithtext(#"assist_hardline", objweapon, 1);
      }
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

function function_e93a7f76c425af37(player) {
  if(!function_bc2a6d490d67ed37()) {
    return;
  }

  println("<dev string:x1c>");
  println("<dev string:x5f>" + player getentitynumber() + "<dev string:x8c>");
  println("<dev string:x98>");

  foreach(key, score_component in level.encounter_score_components) {
    if(isDefined(score_component.team_encounter_performance)) {
      foreach(value in score_component.team_encounter_performance) {
        println(var_8db70ce09c8bf0c9 + "<dev string:xac>" + value);
      }
    }
  }

  println("<dev string:xaf>");

  foreach(value in player.encounter_performance) {
    println(key + "<dev string:xac>" + value);
  }

  println("<dev string:xc2>");
}

function function_bc2a6d490d67ed37() {
  return getDvar(@ "hash_2c5cfc8633798c71") == "<dev string:x111>";
}

# /