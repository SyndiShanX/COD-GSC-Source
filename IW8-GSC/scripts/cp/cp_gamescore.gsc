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

function register_eog_score_component(var0, var1) {
  if(!isDefined(level.eog_score_components)) {
    level.eog_score_components = [];
  }

  var2 = spawnStruct();
  var2.lua_string_index = var1;
  level.eog_score_components[var0] = var2;
}

function register_encounter_score_component(var0, var1, var2, var3, var4, var5, var6, var7) {
  var8 = spawnStruct();
  var8 = [[var1]](var8);
  var8.reset_team_performance_func = var2;
  var8.reset_player_performance_func = var3;
  var8.calculate_func = var4;
  var8.lua_string_index = var5;
  var8.end_game_score_component_ref = var6;

  if(isDefined(var7)) {
    var8.player_init_func = var7;
  }

  level.encounter_score_components[var0] = var8;
}

function has_eog_score_component(var0) {
  return has_score_component_internal(level.eog_score_components, var0);
}

function has_score_component_internal(var0, var1) {
  if(is_scoring_disabled()) {
    return false;
  }

  if(!isDefined(var0)) {
    return false;
  }

  return isDefined(var0[var1]);
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

function component_specific_init(var0) {
  foreach(var2 in level.encounter_score_components) {
    if(isDefined(var2.player_init_func)) {
      [[var2.player_init_func]](var0);
    }
  }
}

function reset_player_encounter_performance(var0) {
  foreach(var2 in level.encounter_score_components) {
    if(isDefined(var2.reset_player_performance_func)) {
      [[var2.reset_player_performance_func]](var0);
    }
  }
}

function reset_end_game_score() {
  foreach(var1 in level.eog_score_components) {
    self.end_game_score[var2] = 0;
  }
}

function reset_encounter_performance() {
  foreach(var1 in level.encounter_score_components) {
    if(isDefined(var1.reset_team_performance_func)) {
      [[var1.reset_team_performance_func]](var1);
    }
  }

  reset_players_encounter_performance_and_lua();
}

function reset_players_encounter_performance_and_lua() {
  foreach(var1 in level.players) {
    reset_player_encounter_performance(var1);
    reset_player_encounter_lua_omnvars(var1);
  }
}

function calculate_players_total_end_game_score(var0) {
  if(is_scoring_disabled()) {
    return;
  }

  if(isDefined(level.endgameencounterscorefunc)) {
    [[level.endgameencounterscorefunc]](var0);
  }

  foreach(var2 in level.players) {
    calculate_total_end_game_score(var2);
  }
}

function calculate_total_end_game_score(var0) {
  var1 = 1;
  var2 = 0;

  foreach(var4 in level.eog_score_components) {
    var5 = var0.end_game_score[var6];
    var1++;
    var2 += var5;
  }
}

function calculate_and_show_encounter_scores(var0, var1) {
  calculate_encounter_scores(var0, var1);
  show_encounter_scores();
}

function calculate_encounter_scores(var0, var1, var2) {
  foreach(var4 in var0) {
    calculate_player_encounter_scores(var4, var1, var2);
  }
}

function calculate_player_encounter_scores(var0, var1, var2) {
  var3 = 1;
  var4 = 0;

  foreach(var6 in var1) {
    var7 = level.encounter_score_components[var6];
    var8 = [[var7.calculate_func]](var0, var7);
    var8 *= level.cycle_score_scalar;
    var8 = int(var8);
    var0.end_game_score[var7.end_game_score_component_ref] += var8;
    set_lua_encounter_score_row(var0, var3, var7.lua_string_index, var8);
    var4 += var8;
    var3++;
  }

  if(isDefined(level.bonusscorefunc)) {
    var10 = [[level.bonusscorefunc]](var0, var4);
    var4 += var10.amount;
    set_lua_encounter_score_row(var0, var3, var10.ui_string_index, var10.amount);
    var3++;
  }

  set_lua_encounter_score_row(var0, var3, 6, var4);
  var3++;

  if(isDefined(level.postencounterscorefunc)) {
    [[level.postencounterscorefunc]](var0, var4, var3);
    return;
  }
}

function round_up_to_nearest(var0, var1) {
  var2 = var0 / var1;
  var2 = ceil(var2);
  return int(var2 * var1);
}

function update_players_encounter_performance(var0, var1, var2) {
  foreach(var4 in level.players) {
    update_personal_encounter_performance(var4, var0, var1, var2);
  }
}

function update_personal_encounter_performance(var0, var1, var2) {
  if(!has_encounter_score_component(var0)) {
    return;
  }

  if(!isPlayer(self)) {
    return;
  }

  self.encounter_performance = update_encounter_performance_internal(self.encounter_performance, var1, var2);
}

function update_encounter_performance_internal(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 1;
  }

  var0 = var0[var1] + var2;
  return var0;
}

function get_team_encounter_performance(var0, var1) {
  return var0.team_encounter_performance[var1];
}

function has_encounter_score_component(var0) {
  return has_score_component_internal(level.encounter_score_components, var0);
}

function get_player_encounter_performance(var0, var1) {
  return var0.encounter_performance[var1];
}

function calculate_under_max_score(var0, var1, var2) {
  var3 = clamp(var1 - var0, 0, var1);
  return int(var3 / var1 * var2);
}

function update_team_encounter_performance(var0, var1, var2) {
  if(!has_encounter_score_component(var0)) {
    return;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  level.encounter_score_components[var0].team_encounter_performance[var1] += var2;
}

function blank_score_component_init(var0) {
  return var0;
}

function get_team_score_component_name() {
  return scripts\engine\utility::ter_op(isDefined(level.team_score_component_name), level.team_score_component_name, "team");
}

function reset_player_encounter_lua_omnvars(var0) {
  var1 = 8;

  for(var2 = 1; var2 <= var1; var2++) {
    var3 = "ui_alien_encounter_title_row_" + var2;
    var4 = "ui_alien_encounter_score_row_" + var2;
    var0 setclientomnvar(var3, 0);
    var0 setclientomnvar(var4, 0);
  }
}

function set_lua_eog_score_row(var0, var1, var2, var3) {
  var4 = "zm_ui_eog_title_row_" + var1;
  var5 = "zm_ui_eog_title_row_" + var1;
  var0 setclientomnvar(var4, var2);
  var0 setclientomnvar(var5, var3);
}

function show_encounter_scores() {
  level endon("game_ended ");
  setomnvar("zm_ui_show_encounter_score", 1);
  wait 1;
  setomnvar("zm_ui_show_encounter_score", 0);
}

function set_lua_encounter_score_row(var0, var1, var2, var3) {
  var4 = "ui_alien_encounter_title_row_" + var1;
  var5 = "ui_alien_encounter_score_row_" + var1;
}

function processassist(var0, var1, var2) {
  if(isDefined(level.assists_disabled)) {
    return;
  }

  ref_128a5(var0, var1, var2);
}

function ref_128a5(var0, var1, var2) {
  self endon("disconnect");
  var0 endon("disconnect");

  if(isDefined(var1) && var1.basename == "white_phosphorus_proj_mp") {
    return;
  }

  if(!isDefined(var2)) {
    var2 = 0;
  }

  var3 = undefined;
  var4 = undefined;
  var5 = undefined;

  if(isDefined(var0.ismarkedtarget)) {
    var4 = var0.attackers;
    var3 = 1;
  }

  if(isDefined(var0.markedbyboomperk)) {
    var5 = var0.markedbyboomperk;
  }

  wait 0.05;
  scripts\asm\soldier\mp\melee::waittillslowprocessallowed();
  var6 = self.pers["team"];

  if(!scripts\cp\utility::isgameplayteam(var6)) {
    return;
  }

  if(isPlayer(var0) && isDefined(var0.pers)) {
    if(var6 == var0.pers["team"] && level.teambased) {
      return;
    }
  }

  var7 = undefined;
  var8 = "assist";

  if(!level.teambased) {
    var8 = "assist_ffa";
  }

  var9 = scripts\cp\drone\emp_drone::getscoreinfovalue(var8);

  if(!level.teambased) {
    var7 = var9 + var9 * var2;
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assist_ffa", var1, var7);
  } else if(isDefined(var5) && scripts\engine\utility::array_contains_key(var5, scripts\cp\utility::getuniqueid())) {
    thread scripts\cp\agents\gametype_cp_wave_sv::givestreakpointswithtext("assist_ping", var1, undefined);
  } else {
    var7 = var9 + var9 * var2;
    thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("assist", var1, var7);
  }

  if(level.teambased) {
    var10 = scripts\common\utility::playersinsphere(self.origin, 300);

    foreach(var12 in var10) {
      if(self.team != var12.team || self == var12) {
        continue;
      }

      if(!scripts\cp\utility\player::isreallyalive(var12)) {
        continue;
      }

      self.modifiers["buddy_kill"] = 1;
      break;
    }
  }

  if(scripts\cp\utility::_hasperk("specialty_hardline") && isDefined(self.hardlineactive)) {
    if(self.hardlineactive["assists"] == 1) {
      if(!scripts\cp\utility::iskillstreakweapon(var1) && !scripts\cp\utility::issuperweapon(var1)) {
        thread scripts\cp\agents\gametype_cp_wave_sv::givestreakpointswithtext("assist_hardline", var1, 1);
      }
    }

    self notify("assist_hardline");
  }

  if(self.pers["assists"] < 998) {
    scripts\cp\agents\agents::incpersstat("assists", 1);
    self.assists = scripts\cp\agents\agents::getpersstat("assists");
  }

  scripts\asm\soldier\mp\melee::bufferednotify("assist_buffered", self.modifiers);
  thread scripts\mp\ammorestock::onplayerkillassist(var0);
}