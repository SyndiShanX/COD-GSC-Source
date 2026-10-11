/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_180407b61054c278.gsc
*************************************************/

#using script_4a6760982b403bad;
#using scripts\common\utility;
#using scripts\engine\utility;
#using scripts\mp\codcasterclientmatchdata;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\matchdata;
#using scripts\mp\playerstats_interface;
#using scripts\mp\supers;
#using scripts\mp\utility\game;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#namespace namespace_ecb54f1ef997b69f;

function function_bb1348b8361a6742() {
  level.var_64586d042bc83658 = &function_da50e02d9e2c31d2;
  level.var_bc366ef8514f9c7e = &function_de30d8b0a3c06fd8;
  level.var_cb98c0fda2fd2c79 = spawnStruct();
  level.var_cb98c0fda2fd2c79.data_function = &function_aa01fe87ee1cb415;
  level.var_b290423f07c0fa3c = spawnStruct();
  level.var_b290423f07c0fa3c.var_21e140b4aaaf4563 = "dlog_event_esports_player_match_end_koth";
  level.var_b290423f07c0fa3c.data_function = &function_664e133f4636982c;
  level.var_2b79862d8e89e043 = spawnStruct();
  level.var_2b79862d8e89e043.data_function = &function_f93988444dece179;
}

function function_89b5debaabf76ff3() {
  level.var_64586d042bc83658 = &function_c358696cb940224b;
  level.var_bc366ef8514f9c7e = &function_e16b616be638e777;
  level.var_cb98c0fda2fd2c79 = spawnStruct();
  level.var_cb98c0fda2fd2c79.data_function = &function_9576e752aed74566;
  level.var_2b79862d8e89e043 = spawnStruct();
  level.var_2b79862d8e89e043.data_function = &function_66d2b5499b862642;
  level.var_b290423f07c0fa3c = spawnStruct();
  level.var_b290423f07c0fa3c.var_21e140b4aaaf4563 = "dlog_event_esports_player_match_end_sd";
  level.var_b290423f07c0fa3c.data_function = &function_20524d471d23d817;
  level.var_9f33f41b213a1be7 = spawnStruct();
  level.var_9f33f41b213a1be7.var_21e140b4aaaf4563 = "dlog_event_esports_player_round_end_sd";
  level.var_9f33f41b213a1be7.data_function = &function_1b1ee2699a6a524c;
}

function function_da27978a46c38e71() {
  level.var_bc366ef8514f9c7e = &function_86c1b16817ad3899;
  level.var_cb98c0fda2fd2c79 = spawnStruct();
  level.var_cb98c0fda2fd2c79.data_function = &function_935ad059f8bc1ae8;
  level.var_b290423f07c0fa3c = spawnStruct();
  level.var_b290423f07c0fa3c.var_21e140b4aaaf4563 = "dlog_event_esports_player_match_end_control";
  level.var_b290423f07c0fa3c.data_function = &function_3a0bba2841cc215b;
  level.var_9f33f41b213a1be7 = spawnStruct();
  level.var_9f33f41b213a1be7.var_21e140b4aaaf4563 = "dlog_event_esports_player_round_end_control";
  level.var_9f33f41b213a1be7.data_function = &function_7b9680c1e187bd00;
  level.var_2b79862d8e89e043 = spawnStruct();
  level.var_2b79862d8e89e043.data_function = &function_6e10cfdfa388094c;
}

function function_a9ef96191f2b64a9() {
  level.var_2b79862d8e89e043 = spawnStruct();
  level.var_2b79862d8e89e043.data_function = &function_6e10cfdfa388094c;
}

function init() {
  if(getdvarint(@ "hash_830d682c147b23bb", 0) > 0) {
    wait getdvarint(@ "hash_830d682c147b23bb", 0);
  }

  if(!function_3b6961b424a382f() && getdvarint(@ "hash_8d2f43eb37209bae", 0) == 0) {
    return;
  }

  level.esports = spawnStruct();
  level.esports.teams = [];
  level.esports.players = [];
  level.esports.var_241db65c803fdcd0 = getdvarint(@ "hash_839ed56f32c687f1", 5);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_server_start", &function_ec68f43c79e586dc);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_match_start", &function_393baf20db478c0d);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_match_end", &function_f5f91665fe4dba94);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_round_start", &on_round_start);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_round_end", &function_b610a0d728dfa59e);

  if(getdvarint(@ "hash_f405928d962ae17e", 0) < 2) {
    namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_objective_state_changed", &function_cd0b801a8b092ca);
  }

  if(getdvarint(@ "hash_f405928d962ae17e", 0) < 1) {
    namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_player_loadout_changed", &function_c82d72ebcdb14059);
    namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_disconnect", &on_player_disconnect);
  }

  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_player_death", &on_player_death);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_first_connect", &on_player_first_connect);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_connect", &on_player_connect);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_player_round_end", &function_49472736af222fcc);
  namespace_de6e6777b0937bd7::function_aacbbe63c26687ae("callback_on_player_spawned", &function_ed4b9c7445b52be8);

  switch (level.gametype) {
    case #"hash_6efb0f59a62300fb":
      function_bb1348b8361a6742();
      break;
    case #"hash_fa50b0f6bd82e972":
      function_89b5debaabf76ff3();
      break;
    case #"hash_a1313b745c17c07e":
      function_da27978a46c38e71();
      break;
    default:
      function_a9ef96191f2b64a9();
      break;
  }

  level notify("telemetry_init");
}

function function_d3c6179b65106833() {
  if(getdvarint(@ "hash_f405928d962ae17e", 0) >= 2) {
    return;
  }

  self endon("death");
  level endon("game_ended");
  var_241db65c803fdcd0 = level.esports.var_241db65c803fdcd0;

  while(true) {
    function_a6c2b5a6203b8813();
    function_c22652f83b317b82();
    wait var_241db65c803fdcd0;
  }
}

function function_36fa9aa217c6858() {
  var_4dba79dfa0880763 = getdvarint(@ "hash_e38ee0a901267948", 0);

  if(var_4dba79dfa0880763 <= 0) {
    return;
  }

  var_9bd7564c71693e36 = getdvarint(@ "hash_5425503fa577c921", 10000) / 1000;
  var_720c6460e66c2e7f = getdvarint(@ "hash_9b4fbaf632d0f62e", 1);
  var_d80f4a569a2e75bd = function_ae0481d6812510b2();

  while(true) {
    for(i = 0; i < var_720c6460e66c2e7f; i++) {
      function_4eaf70b59b015528(var_d80f4a569a2e75bd);
    }

    wait var_9bd7564c71693e36;
  }
}

function function_ae0481d6812510b2() {
  var_cac5351de1e9ba74 = [];

  for(i = 0; i <= 7; i++) {
    dvar_name = hashcat(@ "hash_3ab224a3325d7169", i);
    event_probability = getdvarfloat(dvar_name, 0);
    var_cac5351de1e9ba74[i] = event_probability;
  }

  return var_cac5351de1e9ba74;
}

function function_4eaf70b59b015528(distribution) {
  var_5a46afdcd4f81177 = function_1433fc1cd0f15328(distribution);

  switch (var_5a46afdcd4f81177) {
    case 0:
      function_9f5de9916ad7fb1e("dlog_event_esports_test_0", 20);
      break;
    case 1:
      function_9f5de9916ad7fb1e("dlog_event_esports_test_1", 50);
      break;
    case 2:
      function_9f5de9916ad7fb1e("dlog_event_esports_test_2", 100);
      break;
    case 3:
      function_9f5de9916ad7fb1e("dlog_event_esports_test_3", 150);
      break;
    case 4:
      function_9f5de9916ad7fb1e("dlog_event_esports_test_4", 250);
      break;
    case 5:
      function_9f5de9916ad7fb1e("dlog_event_esports_test_5", 500);
      break;
    case 6:
      function_9f5de9916ad7fb1e("dlog_event_esports_test_6", 1000);
      break;
    case 7:
      var_bbd656ce5a10696c = function_550037a80866cb85(1024);
      esports_event = ["test_column_1", var_bbd656ce5a10696c, "test_column_2", var_bbd656ce5a10696c];
      dlog_recordevent("dlog_event_esports_test_7", esports_event);
      break;
  }
}

function function_550037a80866cb85(count) {
  var_73f4f7f2ccc98c73 = [];

  for(i = 0; i < count; i++) {
    var_73f4f7f2ccc98c73[i] = randomint(256);
  }

  return var_73f4f7f2ccc98c73;
}

function function_9f5de9916ad7fb1e(event_name, event_size) {
  esports_event = ["test_column", function_550037a80866cb85(event_size)];
  dlog_recordevent(event_name, esports_event);
}

function function_1433fc1cd0f15328(distribution) {
  randfloat = randomfloat(1);
  current_index = 0;
  var_3ee256c689d62fa7 = 0;

  for(var_6645afb1fb6e3e31 = distribution[current_index]; !is_between(var_3ee256c689d62fa7, randfloat, var_6645afb1fb6e3e31); var_6645afb1fb6e3e31 = 1) {
    current_index++;
    var_3ee256c689d62fa7 = var_6645afb1fb6e3e31;

    if(current_index != distribution.size - 1) {
      var_6645afb1fb6e3e31 += distribution[current_index];
      continue;
    }
  }

  return current_index;
}

function is_between(min, value, max) {
  return value >= min && value <= max;
}

function function_a3d4800b4cb51b38(vector) {
  return [vector[0], vector[1], vector[2]];
}

function function_78707b6b4cb17a1c(team_id) {
  if(!isDefined(level.esports.teams[team_id])) {
    team_name = function_ca9af9c7fabd79a0(team_id);
    level.esports.teams[team_id] = ter_op(isDefined(team_name), team_name, team_id);
  }

  return level.esports.teams[team_id];
}

function get_winning_team(winning_team) {
  if(winning_team == "none" || winning_team == "tie") {
    return "draw";
  }

  return function_78707b6b4cb17a1c(winning_team);
}

function function_1da7bfa6bc897e5e(player) {
  if(!isDefined(player.xuid)) {
    return player function_bb91c271085a7728();
  }

  if(!isDefined(level.esports.players[player.xuid])) {
    level.esports.players[player.xuid] = player function_bb91c271085a7728();
  }

  return level.esports.players[player.xuid];
}

function function_22de454b228d857c() {
  return scripts\mp\matchdata::gettimefrommatchstart(gettime());
}

function function_df75e8bd68b005f0(end_reason) {
  if(!isDefined(end_reason)) {
    return "unknown";
  }

  end_reasons = game["end_reason"];
  reasons = getarraykeys(end_reasons);

  foreach(reason in reasons) {
    reason_index = end_reasons[reason];

    if(reason_index == end_reason) {
      return reason;
    }
  }

  return "unknown";
}

function function_bd8cfc6e4a98dee6(winning_team) {
  var_f7fb016578461b57 = spawnStruct();

  if(winning_team == game["attackers"]) {
    var_f7fb016578461b57.side = "attack";
    var_f7fb016578461b57.win_team = winning_team;
    var_f7fb016578461b57.loss_team = game["defenders"];
  } else if(winning_team == game["defenders"]) {
    var_f7fb016578461b57.side = "defense";
    var_f7fb016578461b57.win_team = winning_team;
    var_f7fb016578461b57.loss_team = game["attackers"];
  } else {
    var_f7fb016578461b57.side = "none";
    var_f7fb016578461b57.win_team = "none";
    var_f7fb016578461b57.loss_team = "none";
  }

  return var_f7fb016578461b57;
}

function function_8b0f3d64ee5d77da() {
  team_sides = spawnStruct();

  if(isroundbased()) {
    if(game["attackers"] == "allies") {
      team_sides.team1 = "attack";
      team_sides.team2 = "defense";
    } else {
      team_sides.team1 = "defense";
      team_sides.team2 = "attack";
    }
  } else {
    team_sides.team1 = "none";
    team_sides.team2 = "none";
  }

  return team_sides;
}

function function_b6c29e08764ae361(means_of_death) {
  round = 1;

  if(!isroundbased()) {
    return round;
  }

  round = game["roundsPlayed"];

  if(isDefined(means_of_death) && (means_of_death == "MOD_GAME_ENDED" || means_of_death == "MOD_ROUND_ENDED")) {
    round--;

    if(round < 1) {
      round = 1;
    }
  }

  return round;
}

function function_aae4068942e8bc69() {
  objective_time = level.zoneendtime;

  if(isDefined(level.defuseendtime)) {
    objective_time = level.defuseendtime;
  }

  if(isDefined(objective_time)) {
    currenttime = gettime();
    return ter_op(currenttime < objective_time, objective_time - currenttime, 0);
  }

  return 0;
}

function is_ace_kill(attacker, victim) {
  var_988b0676a35ef9d6 = scripts\mp\utility\teams::getfriendlyplayers(victim.team, 0).size;
  return attacker.pers["kills"] - attacker.var_934379620852e329.kills == var_988b0676a35ef9d6;
}

function function_1e412fb6d8cbc655(deathdata) {
  return isDefined(deathdata.damageflags) && deathdata.damageflags & 8;
}

function function_d303e25d324b2874() {
  return !level.var_bf918fc5f938cd0c && level.zoneendtime - gettime() <= 15000;
}

function function_bffb24c16c411c32() {
  objective_key = level.zone.objectivekey;
  return "point" + objective_key;
}

function function_e553b81f7f609a5b() {
  objective_label = self.objectivekey;

  if(isDefined(objective_label) && (objective_label == "_a" || objective_label == "_b")) {
    return ("point" + objective_label);
  }

  return "bomb";
}

function function_50280cf505622041() {
  return "point" + self.objectivekey;
}

function function_3fc5fd079e76a114(objective) {
  objective_info = ["obj_name", "point" + objective.objectivekey, "origin", function_a3d4800b4cb51b38(objective.curorigin)];
  return objective_info;
}

function is_interacting_objective() {
  var_96349e74c9078d79 = istrue(self.isbombcarrier) || istrue(self.isplanting) || istrue(self.isdefusing);
  is_touching_triggers = isDefined(self.touchtriggers) && self.touchtriggers.size > 0;
  return var_96349e74c9078d79 || is_touching_triggers;
}

function function_da50e02d9e2c31d2() {
  if(!isDefined(self.pers["obj1Time"])) {
    initpersstat("obj1Time");
  }

  if(!isDefined(self.pers["obj2Time"])) {
    initpersstat("obj2Time");
  }

  if(!isDefined(self.pers["obj3Time"])) {
    initpersstat("obj3Time");
  }

  if(!isDefined(self.pers["obj4Time"])) {
    initpersstat("obj4Time");
  }

  if(!isDefined(self.pers["obj5Time"])) {
    initpersstat("obj5Time");
  }
}

function function_c358696cb940224b() {
  if(!isDefined(self.pers["sneakDefuses"])) {
    initpersstat("sneakDefuses");
  }
}

function function_2cbdf94f9506ad4f() {
  if(!isDefined(self.pers["total_time_alive"])) {
    initpersstat("total_time_alive");
  }

  if(!isDefined(self.pers["shotsHitHead"])) {
    initpersstat("shotsHitHead");
  }

  if(!isDefined(self.pers["totalMultikills"])) {
    initpersstat("totalMultikills");
  }

  if(!isDefined(self.pers["soloKills"])) {
    initpersstat("soloKills");
  }

  if(!isDefined(self.pers["deadSilenceKills"])) {
    initpersstat("deadSilenceKills");
  }

  if(!isDefined(self.pers["deadSilenceTime"])) {
    initpersstat("deadSilenceTime");
  }

  if(!isDefined(self.pers["damageHealed"])) {
    initpersstat("damageHealed");
  }

  if(!isDefined(self.pers["inapplicableTradedKills"])) {
    initpersstat("inapplicableTradedKills");
  }

  if(!isDefined(self.pers["inapplicableTradedDeaths"])) {
    initpersstat("inapplicableTradedDeaths");
  }

  if(!isDefined(self.pers["friendlyDamageDone"])) {
    initpersstat("friendlyDamageDone");
  }

  if(!isDefined(self.pers["tacticalsUsed"])) {
    initpersstat("tacticalsUsed");
  }

  if(!isDefined(self.pers["lethalsUsed"])) {
    initpersstat("lethalsUsed");
  }

  if(!isDefined(self.pers["damageTaken"])) {
    initpersstat("damageTaken");
  }

  if(!isDefined(self.pers["totalDistTraveled"])) {
    initpersstat("totalDistTraveled");
  }

  if(isDefined(level.var_64586d042bc83658)) {
    self[[level.var_64586d042bc83658]]();
  }
}

function function_de30d8b0a3c06fd8(var_934379620852e329, persistent_data) {
  var_934379620852e329.hill_time = function_a08fea26a49145a8(0);
  var_934379620852e329.contested_hill_time = function_a08fea26a49145a8(12);
}

function function_e16b616be638e777(var_934379620852e329, persistent_data) {
  var_934379620852e329.bombs_planted = persistent_data["plants"];
  var_934379620852e329.bombs_defused = persistent_data["defuses"];
  var_934379620852e329.sneak_defuses = persistent_data["sneakDefuses"];
}

function function_86c1b16817ad3899(var_934379620852e329, persistent_data) {
  var_934379620852e329.tiers_captured = function_a08fea26a49145a8(8);
}

function function_42afc3bfbb1e92cb() {
  var_934379620852e329 = spawnStruct();
  persistent_data = self.pers;
  var_934379620852e329.kills = persistent_data["kills"];
  var_934379620852e329.deaths = persistent_data["deaths"];
  var_934379620852e329.assists = persistent_data["assists"];
  var_934379620852e329.score = persistent_data["score"];
  var_934379620852e329.highest_streak = persistent_data["longestStreak"];
  var_934379620852e329.shots_fired = function_e42724fbfacff469(0);
  var_934379620852e329.shots_hit = function_e42724fbfacff469(1);
  var_934379620852e329.shots_head = persistent_data["shotsHitHead"];
  var_934379620852e329.untraded_kills = function_815fee43d577e1b6(5);
  var_934379620852e329.untraded_deaths = persistent_data["untradedDeaths"];
  var_934379620852e329.traded_kills = persistent_data["tradedKills"];
  var_934379620852e329.traded_deaths = persistent_data["tradedDeaths"];
  var_934379620852e329.inapplicable_traded_kills = persistent_data["inapplicableTradedKills"];
  var_934379620852e329.inapplicable_traded_deaths = persistent_data["inapplicableTradedDeaths"];
  var_934379620852e329.damage_dealt = function_815fee43d577e1b6(1);
  var_934379620852e329.damage_taken = persistent_data["damageTaken"];
  var_934379620852e329.damage_healed = persistent_data["damageHealed"];
  var_934379620852e329.damage_friend = persistent_data["friendlyDamageDone"];
  var_934379620852e329.tacticals_used = persistent_data["tacticalsUsed"];
  var_934379620852e329.lethals_used = persistent_data["lethalsUsed"];
  var_934379620852e329.time_alive = persistent_data["total_time_alive"];
  var_934379620852e329.distance_traveled = persistent_data["totalDistTraveled"];
  var_934379620852e329.dead_silence_time = persistent_data["deadSilenceTime"];
  var_934379620852e329.movementupdatecount = persistent_data["movementUpdateCount"];
  var_934379620852e329.movingtotal = persistent_data["movingTotal"];
  var_934379620852e329.distancetotal = persistent_data["distanceTotal"];

  if(isDefined(level.var_bc366ef8514f9c7e)) {
    self[[level.var_bc366ef8514f9c7e]](var_934379620852e329, persistent_data);
  }

  self.var_934379620852e329 = var_934379620852e329;
}

function function_e2ec18c5b7de4fb6() {
  deathtime = function_22de454b228d857c();
  var_cc785f48d0173169 = deathtime - scripts\mp\matchdata::gettimefrommatchstart(self.spawntime);
  incpersstat("total_time_alive", var_cc785f48d0173169);
}

function function_d21dfe417b65b64a() {
  if(isalive(self)) {
    match_time = function_22de454b228d857c();
    var_cc785f48d0173169 = match_time - scripts\mp\matchdata::gettimefrommatchstart(self.spawntime);
    incpersstat("total_time_alive", var_cc785f48d0173169);
  }
}

function function_c56d015e4cd2e47c(data) {
  movement_data = spawnStruct();

  if(isDefined(data["movementUpdateCount"]) && data["movementUpdateCount"] > 0) {
    movement_data.percent_time_moving = int(data["movingTotal"] / data["movementUpdateCount"] / 5 * 100);
    movement_data.average_speed = float(data["distanceTotal"] / data["movementUpdateCount"]);
    return movement_data;
  }

  movement_data.percent_time_moving = 0;
  movement_data.average_speed = 0;
  return movement_data;
}

function function_3ddc4f55dfe66ebb() {
  var_934379620852e329 = self.var_934379620852e329;

  if(!isDefined(var_934379620852e329.movementupdatecount)) {
    return function_c56d015e4cd2e47c(self.pers);
  }

  persistent_data = self.pers;
  var_104538cf2341cf1e = [];
  var_104538cf2341cf1e["movingTotal"] = persistent_data["movingTotal"] - var_934379620852e329.movingtotal;
  var_104538cf2341cf1e["movementUpdateCount"] = persistent_data["movementUpdateCount"] - var_934379620852e329.movementupdatecount;
  var_104538cf2341cf1e["distanceTotal"] = persistent_data["distanceTotal"] - var_934379620852e329.distancetotal;
  return function_c56d015e4cd2e47c(var_104538cf2341cf1e);
}

function function_b433743dc5925931(var_fb5a2da2d4c3c2e7) {
  player = self;
  player_weapon = var_fb5a2da2d4c3c2e7.weapon;
  weapon_name = "none";

  if(isDefined(player_weapon)) {
    weapon_name = player_weapon.basename;
  }

  weapon_attachments = [];

  if(!isundefinedweapon(player_weapon)) {
    weapon_attachments = getweaponattachments(player_weapon);
  }

  return ["name", function_1da7bfa6bc897e5e(player), "team", function_78707b6b4cb17a1c(player.sessionteam), "origin", function_a3d4800b4cb51b38(var_fb5a2da2d4c3c2e7.origin), "viewangles", function_a3d4800b4cb51b38(var_fb5a2da2d4c3c2e7.angles), "weapon", weapon_name, "weapon_attachments", weapon_attachments];
}

function function_770a5e6a8a9e1289() {
  player = self;
  return ["is_ads", player isplayerads(), "is_flashed", istrue(player.flashbanged), "is_interacting_objective", player is_interacting_objective()];
}

function function_393baf20db478c0d() {
  function_8773797d27789d6e();
  function_62268a7bb3b85f6c();
}

function function_f5f91665fe4dba94(data) {
  function_458ce094fbf47be3(data);

  foreach(player in level.players) {
    var_7e2c53b0bcf117d9 = spawnStruct();
    var_7e2c53b0bcf117d9.player = player;
    function_e60b22a0532246a9(var_7e2c53b0bcf117d9);
  }
}

function on_round_start() {
  level thread function_d3c6179b65106833();
  level thread function_36fa9aa217c6858();
  function_ebacc818c229d2e3();
}

function on_player_first_connect(player) {
  if(player iscodcaster()) {
    return;
  }

  player function_2cbdf94f9506ad4f();
}

function on_player_connect(player) {
  if(player iscodcaster()) {
    return;
  }

  if(!isDefined(player.var_f038145f52e97ce3)) {
    player.var_f038145f52e97ce3 = spawnStruct();
  }

  if(!isDefined(player.var_934379620852e329)) {
    player function_42afc3bfbb1e92cb();
  }
}

function on_player_death(data) {
  if(!isDefined(data.attacker)) {
    return;
  }

  data.victim function_e2ec18c5b7de4fb6();
  function_a9d9e4dd889a4258(data);
}

function on_player_disconnect(data) {
  player = data.player;

  if(player iscodcaster() || !scripts\mp\flags::gameflag("prematch_done")) {
    return;
  }

  var_e44c9440aaae891b = player.var_f038145f52e97ce3;

  if(!istrue(var_e44c9440aaae891b.round_end)) {
    function_49472736af222fcc(data);
  }

  if(!istrue(var_e44c9440aaae891b.match_end)) {
    function_e60b22a0532246a9(data);
  }

  function_b30fd7d465d6d57c(data);
}

function function_ec68f43c79e586dc() {
  function_d47580052756d597();
  esports_event = ["game_type", level.gametype, "map_name", level.mapname, "team1_name", function_78707b6b4cb17a1c("allies"), "team2_name", function_78707b6b4cb17a1c("axis")];
  dlog_recordevent("dlog_event_esports_server_start", esports_event);
}

function function_8773797d27789d6e() {
  esports_event = ["game_type", level.gametype, "map_name", level.mapname, "team1_name", function_78707b6b4cb17a1c("allies"), "team2_name", function_78707b6b4cb17a1c("axis")];
  dlog_recordevent("dlog_event_esports_match_start", esports_event);
}

function function_458ce094fbf47be3(data) {
  esports_event = ["match_time", function_22de454b228d857c(), "team1_score", getteamscore("allies"), "team2_score", getteamscore("axis"), "win_team", get_winning_team(data.winner)];
  dlog_recordevent("dlog_event_esports_match_end", esports_event);
}

function function_a6c2b5a6203b8813() {
  esports_event = ["game_timer", int(scripts\mp\gamelogic::gettimeremaining() / 1000), "objective_timer", int(function_aae4068942e8bc69() / 1000), "team1_score", getteamscore("allies"), "team2_score", getteamscore("axis")];
  var_21e140b4aaaf4563 = "dlog_event_esports_match_interval_info";
  dlog_recordevent(var_21e140b4aaaf4563, esports_event);
}

function function_ebacc818c229d2e3() {
  team_sides = function_8b0f3d64ee5d77da();
  esports_event = ["team1_side", team_sides.team1, "team2_side", team_sides.team2];
  dlog_recordevent("dlog_event_esports_round_start", esports_event);
}

function function_b610a0d728dfa59e(data) {
  if(!isroundbased()) {
    return;
  }

  round_info = function_bd8cfc6e4a98dee6(data.winner);
  esports_event = ["result", function_df75e8bd68b005f0(data.end_reason), "win_side", round_info.side, "match_time", function_22de454b228d857c(), "win_team", function_78707b6b4cb17a1c(round_info.win_team), "loss_team", function_78707b6b4cb17a1c(round_info.loss_team)];
  dlog_recordevent("dlog_event_esports_round_end", esports_event);
}

function function_62268a7bb3b85f6c() {
  esports_event = [];
  objectives = ter_op(isDefined(level.objectives), level.objectives, []);
  var_12632b94c52c98a0 = [];

  foreach(objective in objectives) {
    var_12632b94c52c98a0 = array_add(var_12632b94c52c98a0, function_3fc5fd079e76a114(objective));
  }

  esports_event = array_add(esports_event, "objectives_info");
  esports_event = array_add(esports_event, var_12632b94c52c98a0);
  var_21e140b4aaaf4563 = "dlog_event_esports_objective_info";
  dlog_recordevent(var_21e140b4aaaf4563, esports_event);
}

function function_aa01fe87ee1cb415(esports_event, objective_data) {
  obj_team = objective_data.obj_team;
  esports_event = array_combine(esports_event, ["obj_name", function_bffb24c16c411c32()]);
  esports_event = array_add(esports_event, "objective_state_zone");
  esports_event = array_add(esports_event, ["is_captured", obj_team != "none", "is_contested", self.stalemate, "tiers_captured", 0]);
  return esports_event;
}

function function_9576e752aed74566(esports_event, objective_data) {
  player = objective_data.credit_player;
  is_bomb_picked_up = 0;

  if(isDefined(player)) {
    is_bomb_picked_up = player.isbombcarrier;
  }

  esports_event = array_combine(esports_event, ["obj_name", function_e553b81f7f609a5b()]);
  esports_event = array_add(esports_event, "objective_state_bomb");
  esports_event = array_add(esports_event, ["is_bomb_picked_up", is_bomb_picked_up, "is_bomb_planted", level.bombplanted, "is_bomb_defused", level.bombdefused]);
  return esports_event;
}

function function_935ad059f8bc1ae8(esports_event, objective_data) {
  obj_team = objective_data.obj_team;
  tiers_captured = 0;

  if(isDefined(self.segmentupdate)) {
    tiers_captured = self.segmentupdate;
  }

  esports_event = array_combine(esports_event, ["obj_name", function_50280cf505622041()]);
  esports_event = array_add(esports_event, "objective_state_zone");
  esports_event = array_add(esports_event, ["is_captured", self.claimteam != "none" && self.claimteam != self.ownerteam, "is_contested", self.stalemate, "tiers_captured", tiers_captured]);
  return esports_event;
}

function function_cd0b801a8b092ca(data) {
  if(!isDefined(self.objidnum)) {
    return;
  }

  credit_player = data.credit_player;
  objective_entity = data.objective_entity;
  player_name = "none";
  obj_team = "none";

  if(isDefined(credit_player)) {
    player_name = function_1da7bfa6bc897e5e(credit_player);
    obj_team = function_78707b6b4cb17a1c(credit_player.sessionteam);
  }

  esports_event = ["player_name", player_name, "obj_pos", function_a3d4800b4cb51b38(self.curorigin), "obj_team", obj_team, "match_time", function_22de454b228d857c()];
  var_21e140b4aaaf4563 = "dlog_event_esports_objective_state_changed";

  if(isDefined(level.var_cb98c0fda2fd2c79)) {
    objective_data = spawnStruct();
    objective_data.credit_player = credit_player;
    objective_data.obj_team = obj_team;
    esports_event = self[[level.var_cb98c0fda2fd2c79.data_function]](esports_event, objective_data);
  }

  if(!array_contains_key(esports_event, "obj_name")) {
    esports_event = array_combine(esports_event, ["obj_name", ""]);
  }

  dlog_recordevent(var_21e140b4aaaf4563, esports_event);
}

function function_b30fd7d465d6d57c(data) {
  player = data.player;
  esports_event = ["player_name", function_1da7bfa6bc897e5e(player)];
  player dlog_recordplayerevent("dlog_event_esports_player_disconnect", esports_event);
}

function function_ed4b9c7445b52be8(player) {
  player_origin = player.origin;
  player_angles = player getplayerangles();
  esports_event = ["player_name", function_1da7bfa6bc897e5e(player), "player_team", function_78707b6b4cb17a1c(player.sessionteam), "match_time", function_22de454b228d857c(), "origin", function_a3d4800b4cb51b38(player_origin)];
  player dlog_recordplayerevent("dlog_event_esports_player_spawned", esports_event);
}

function function_f93988444dece179(esports_event, data) {
  esports_event[11] = array_combine(esports_event[11], ["is_planter_kill", 0, "is_defuser_kill", 0, "is_ace_kill", 0, "is_rotation_kill", function_d303e25d324b2874()]);
  return esports_event;
}

function function_66d2b5499b862642(esports_event, data) {
  attacker = data.attacker;

  if(!isDefined(attacker)) {
    return function_6e10cfdfa388094c(esports_event, data);
  }

  victim = data.victim;
  attacker_modifiers = ter_op(isDefined(attacker.modifiers), attacker.modifiers, []);
  esports_event[11] = array_combine(esports_event[11], ["is_planter_kill", istrue(attacker_modifiers["killed_planter"]), "is_defuser_kill", istrue(attacker_modifiers["killed_defuser"]), "is_ace_kill", is_ace_kill(attacker, victim), "is_rotation_kill", 0]);
  return esports_event;
}

function function_6e10cfdfa388094c(esports_event, data) {
  esports_event[11] = array_combine(esports_event[11], ["is_planter_kill", 0, "is_defuser_kill", 0, "is_ace_kill", 0, "is_rotation_kill", 0]);
  return esports_event;
}

function function_a9d9e4dd889a4258(data) {
  victim = data.victim;
  victim_origin = victim.lastdeathpos;
  victim_angles = victim.lastdeathangles;
  attacker = data.attacker;

  if(isPlayer(attacker)) {
    attacker_origin = attacker.origin;
    attacker_angles = attacker getplayerangles();
    attacker_weapon = data.objweapon;
    attacker_modifiers = ter_op(isDefined(attacker.modifiers), attacker.modifiers, []);
    var_7ff0a085ae13029 = spawnStruct();
    var_7ff0a085ae13029.origin = attacker_origin;
    var_7ff0a085ae13029.angles = attacker_angles;
    var_7ff0a085ae13029.weapon = attacker_weapon;
    attacker_info = attacker function_b433743dc5925931(var_7ff0a085ae13029);
    var_7633e290ec9d496c = attacker function_770a5e6a8a9e1289();
    attacker_in_victim_fov = within_fov(victim_origin, victim_angles, attacker_origin, 0.4226);
    victim_in_attacker_fov = within_fov(attacker_origin, attacker_angles, victim_origin, 0.4226);
    is_dead_silence_kill = 0;
    var_7639389406e14c2e = attacker scripts\mp\supers::getcurrentsuper();

    if(isDefined(var_7639389406e14c2e) && attacker scripts\mp\supers::issuperinuse() && var_7639389406e14c2e.staticdata.ref == "super_deadsilence") {
      is_dead_silence_kill = 1;
    }

    kill_context = ["is_longshot_kill", istrue(attacker_modifiers["longshot"]), "is_pointblank_kill", istrue(attacker_modifiers["pointblank"]), "is_first_blood", istrue(attacker_modifiers["firstblood"]), "is_revenge_kill", istrue(attacker_modifiers["revenge"]), "is_wallbang", function_1e412fb6d8cbc655(data), "attacker_in_victim_fov", attacker_in_victim_fov, "victim_in_attacker_fov", victim_in_attacker_fov, "is_dead_silence_kill", is_dead_silence_kill];
    kill_distance = distance(attacker_origin, victim_origin);
  } else {
    attacker_info = [];
    var_7633e290ec9d496c = [];
    kill_context = [];
    kill_distance = 0;
  }

  victim_weapon = victim.lastweaponused;
  var_54ac843c056a6336 = spawnStruct();
  var_54ac843c056a6336.origin = victim_origin;
  var_54ac843c056a6336.angles = victim_angles;
  var_54ac843c056a6336.weapon = victim_weapon;
  victim_info = victim function_b433743dc5925931(var_54ac843c056a6336);
  var_43c8b33f18127c89 = victim function_770a5e6a8a9e1289();
  kill_info = ["match_time", function_22de454b228d857c(), "means_of_death", data.meansofdeath, "players_distance", kill_distance];
  esports_event = ["info", kill_info, "attacker", attacker_info, "attacker_status", var_7633e290ec9d496c, "victim", victim_info, "victim_status", var_43c8b33f18127c89, "kill_context", kill_context];
  var_21e140b4aaaf4563 = "dlog_event_esports_player_killed";

  if(isDefined(level.var_2b79862d8e89e043)) {
    esports_event = self[[level.var_2b79862d8e89e043.data_function]](esports_event, data);
  }

  victim dlog_recordplayerevent(var_21e140b4aaaf4563, esports_event);
}

function function_664e133f4636982c(esports_event, persistent_data, var_934379620852e329) {
  esports_event = array_combine(esports_event, ["hill_time", function_a08fea26a49145a8(0), "contested_hill_time", function_a08fea26a49145a8(12)]);
  return esports_event;
}

function function_20524d471d23d817(esports_event, persistent_data, var_934379620852e329) {
  esports_event = array_combine(esports_event, ["bombs_planted", persistent_data["plants"], "bombs_defused", persistent_data["defuses"], "sneak_defuses", persistent_data["sneakDefuses"]]);
  return esports_event;
}

function function_3a0bba2841cc215b(esports_event, persistent_data, var_934379620852e329) {
  esports_event = array_combine(esports_event, ["total_objectives_captured", persistent_data["captures"], "objective_tiers_contributed", function_a08fea26a49145a8(8)]);
  return esports_event;
}

function function_e60b22a0532246a9(data) {
  player = data.player;

  if(player iscodcaster()) {
    return;
  }

  persistent_data = player.pers;
  var_934379620852e329 = player.var_934379620852e329;
  movement_data = function_c56d015e4cd2e47c(persistent_data);
  current_streak = persistent_data["cur_kill_streak"];
  total_distance_traveled = 0;

  if(isDefined(persistent_data["totalDistTraveled"])) {
    total_distance_traveled = float(persistent_data["totalDistTraveled"]);
  }

  esports_event = ["player_name", function_1da7bfa6bc897e5e(player), "kills", persistent_data["kills"], "deaths", persistent_data["deaths"], "assists", persistent_data["assists"], "score", persistent_data["score"], "highest_streak", persistent_data["longestStreak"], "shots_fired", player function_e42724fbfacff469(0), "shots_hit", player function_e42724fbfacff469(1), "shots_head", persistent_data["shotsHitHead"], "untraded_kills", player function_815fee43d577e1b6(5), "untraded_deaths", persistent_data["untradedDeaths"], "traded_kills", persistent_data["tradedKills"], "traded_deaths", persistent_data["tradedDeaths"], "inapplicable_traded_kills", persistent_data["inapplicableTradedKills"], "inapplicable_traded_deaths", persistent_data["inapplicableTradedDeaths"], "damage_dealt", player function_815fee43d577e1b6(1), "damage_taken", ter_op(isDefined(persistent_data["damageTaken"]), persistent_data["damageTaken"], 0), "damage_healed", persistent_data["damageHealed"], "damage_friend", persistent_data["friendlyDamageDone"], "tacticals_used", persistent_data["tacticalsUsed"], "lethals_used", persistent_data["lethalsUsed"], "time_alive", ter_op(persistent_data["total_time_alive"] == 0, function_22de454b228d857c(), persistent_data["total_time_alive"]), "distance_traveled", total_distance_traveled, "average_speed", movement_data.average_speed, "percent_time_moving", movement_data.percent_time_moving, "dead_silence_time", int(persistent_data["deadSilenceTime"] / 1000)];
  var_21e140b4aaaf4563 = "dlog_event_esports_player_match_end";

  if(isDefined(level.var_b290423f07c0fa3c)) {
    var_21e140b4aaaf4563 = level.var_b290423f07c0fa3c.var_21e140b4aaaf4563;
    esports_event = player[[level.var_b290423f07c0fa3c.data_function]](esports_event, persistent_data, player.var_934379620852e329);
  }

  player dlog_recordplayerevent(var_21e140b4aaaf4563, esports_event);
  player.var_f038145f52e97ce3.match_end = 1;
}

function function_c22652f83b317b82() {
  all_events = [];

  foreach(player in level.players) {
    if(!isDefined(player) || player iscodcaster()) {
      continue;
    }

    persistent_data = player.pers;
    esports_event = ["player_name", function_1da7bfa6bc897e5e(player), "origin", function_a3d4800b4cb51b38(player.origin), "viewangles", function_a3d4800b4cb51b38(player getplayerangles())];

    if(isDefined(level.var_f8fa0c6bb4b9de4e)) {
      esports_event = player[[level.var_f8fa0c6bb4b9de4e.data_function]](esports_event);
    }

    player_event = spawnStruct();
    player_event.player = player;
    player_event.event = esports_event;
    all_events = array_add(all_events, player_event);
  }

  var_21e140b4aaaf4563 = "dlog_event_esports_player_interval_info";

  if(isDefined(level.var_f8fa0c6bb4b9de4e)) {
    var_21e140b4aaaf4563 = level.var_f8fa0c6bb4b9de4e.var_21e140b4aaaf4563;
  }

  foreach(player_event in all_events) {
    player = player_event.player;

    if(!isDefined(player)) {
      continue;
    }

    player dlog_recordplayerevent(var_21e140b4aaaf4563, player_event.event);
    waitframe();
  }
}

function function_1b1ee2699a6a524c(esports_event, persistent_data, var_934379620852e329) {
  esports_event = array_combine(esports_event, ["bombs_planted", persistent_data["plants"] - var_934379620852e329.bombs_planted, "bombs_defused", persistent_data["defuses"] - var_934379620852e329.bombs_defused, "sneak_defuses", persistent_data["sneakDefuses"] - var_934379620852e329.sneak_defuses]);
  return esports_event;
}

function function_7b9680c1e187bd00(esports_event, persistent_data, var_934379620852e329) {
  esports_event = array_combine(esports_event, ["tiers_captured", function_a08fea26a49145a8(8) - var_934379620852e329.tiers_captured]);
  return esports_event;
}

function function_49472736af222fcc(data) {
  player = data.player;

  if(player iscodcaster() || !isroundbased()) {
    return;
  }

  player function_d21dfe417b65b64a();
  persistent_data = player.pers;
  var_934379620852e329 = player.var_934379620852e329;
  current_streak = persistent_data["cur_kill_streak"];
  movement_data = player function_3ddc4f55dfe66ebb();
  distance_traveled = 0;

  if(isDefined(persistent_data["totalDistTraveled"])) {
    distance_traveled = float(persistent_data["totalDistTraveled"]);
  }

  esports_event = ["player_name", function_1da7bfa6bc897e5e(player), "round_number", function_b6c29e08764ae361(), "round_won", ter_op(isDefined(player.team) && data.winner == player.team, 1, 0), "kills", persistent_data["kills"] - var_934379620852e329.kills, "deaths", persistent_data["deaths"] - var_934379620852e329.deaths, "assists", persistent_data["assists"] - var_934379620852e329.assists, "score", persistent_data["score"] - var_934379620852e329.score, "highest_streak", persistent_data["longestStreak"], "shots_fired", player function_e42724fbfacff469(0) - var_934379620852e329.shots_fired, "shots_hit", player function_e42724fbfacff469(1) - var_934379620852e329.shots_hit, "shots_head", persistent_data["shotsHitHead"] - var_934379620852e329.shots_head, "untraded_kills", player function_815fee43d577e1b6(5) - var_934379620852e329.untraded_kills, "untraded_deaths", persistent_data["untradedDeaths"] - var_934379620852e329.untraded_deaths, "traded_kills", persistent_data["tradedKills"] - var_934379620852e329.traded_kills, "traded_deaths", persistent_data["tradedDeaths"] - var_934379620852e329.traded_deaths, "inapplicable_traded_kills", persistent_data["inapplicableTradedKills"] - var_934379620852e329.inapplicable_traded_kills, "inapplicable_traded_deaths", persistent_data["inapplicableTradedDeaths"] - var_934379620852e329.inapplicable_traded_deaths, "damage_dealt", player function_815fee43d577e1b6(1) - var_934379620852e329.damage_dealt, "damage_taken", ter_op(isDefined(persistent_data["damageTaken"]), persistent_data["damageTaken"], 0) - var_934379620852e329.damage_taken, "damage_healed", persistent_data["damageHealed"] - var_934379620852e329.damage_healed, "damage_friend", persistent_data["friendlyDamageDone"] - var_934379620852e329.damage_friend, "tacticals_used", persistent_data["tacticalsUsed"] - var_934379620852e329.tacticals_used, "lethals_used", persistent_data["lethalsUsed"] - var_934379620852e329.lethals_used, "time_alive", ter_op(persistent_data["total_time_alive"] == 0, function_22de454b228d857c(), persistent_data["total_time_alive"]) - var_934379620852e329.time_alive, "distance_traveled", distance_traveled - var_934379620852e329.distance_traveled, "average_speed", movement_data.average_speed, "percent_time_moving", movement_data.percent_time_moving, "dead_silence_time", int((persistent_data["deadSilenceTime"] - var_934379620852e329.dead_silence_time) / 1000)];
  var_21e140b4aaaf4563 = "dlog_event_esports_player_round_end";

  if(isDefined(level.var_9f33f41b213a1be7)) {
    var_21e140b4aaaf4563 = level.var_9f33f41b213a1be7.var_21e140b4aaaf4563;
    esports_event = player[[level.var_9f33f41b213a1be7.data_function]](esports_event, persistent_data, var_934379620852e329);
  }

  player dlog_recordplayerevent(var_21e140b4aaaf4563, esports_event);
  player.var_f038145f52e97ce3.round_end = 1;
}

function function_c82d72ebcdb14059(data) {
  player = data.player;

  if(player iscodcaster()) {
    return;
  }

  struct = data.struct;
  killstreaks = [struct.loadoutkillstreak1, struct.loadoutkillstreak2, struct.loadoutkillstreak3];
  field_upgrades = [struct.loadoutfieldupgrade1, struct.loadoutfieldupgrade2];
  perks = struct.loadoutperks;

  if(isDefined(struct.var_15f3e6df722fb1cf) && struct.var_15f3e6df722fb1cf != "none" && !perkisrestricted(struct.var_15f3e6df722fb1cf)) {
    perks = array_add(perks, struct.var_15f3e6df722fb1cf);
  }

  if(isDefined(struct.var_15f3e5df722faf9c) && struct.var_15f3e5df722faf9c != "none" && !perkisrestricted(struct.var_15f3e5df722faf9c)) {
    perks = array_add(perks, struct.var_15f3e5df722faf9c);
  }

  primary_weapon_attachments = ["none"];

  if(isDefined(struct.loadoutprimaryattachments) && struct.loadoutprimaryattachments.size > 0) {
    primary_weapon_attachments = struct.loadoutprimaryattachments;
  }

  secondary_weapon_attachments = ["none"];

  if(isDefined(struct.loadoutsecondaryattachments) && struct.loadoutsecondaryattachments.size > 0) {
    secondary_weapon_attachments = struct.loadoutsecondaryattachments;
  }

  if(istrue(level.tertiaryweaponslotenabled)) {}

  esports_event = ["player_name", function_1da7bfa6bc897e5e(player), "primary_weapon", struct.loadoutprimary, "primary_weapon_attachments", primary_weapon_attachments, "secondary_weapon", struct.loadoutsecondary, "secondary_weapon_attachments", secondary_weapon_attachments, "primary_grenade", struct.loadoutequipmentprimary, "secondary_grenade", struct.loadoutequipmentsecondary, "field_upgrades", field_upgrades, "streaks", killstreaks, "perks", perks, "match_time", function_22de454b228d857c()];
  player dlog_recordplayerevent("dlog_event_esports_player_loadout_changed", esports_event);
}