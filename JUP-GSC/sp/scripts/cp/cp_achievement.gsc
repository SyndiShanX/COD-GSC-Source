/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_achievement.gsc
***********************************************/



#using scripts\common\utility;
#using scripts\engine\utility;
#namespace cp_achievement;

function register_default_achievements() {
  register_achievement("threestarbadsit", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("threestarvehesc", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("threestarobservatory", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("noalarmbadsit", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("onestarcp", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("fullsse", 1, &default_init, &default_should_update, &equal_to_goal);
}

function register_achievement(reference, goal, init_func, should_update_func, is_goal_reached_func) {
  achievement = spawnStruct();
  achievement[[init_func]](goal, should_update_func, is_goal_reached_func);
  self.achievement_list[reference] = achievement;
}

function default_init(goal, should_update_func, is_goal_reached_func) {
  self.progress = 0;
  self.goal = goal;
  self.should_update_func = should_update_func;
  self.is_goal_reached_func = is_goal_reached_func;
  self.achievement_completed = 0;
}

function default_should_update(player, unused_2, unused_3, unused_4, unused_5, unused_6, unused_7, unused_8, unused_9, unused_10) {
  if(!player are_achievements_allowed()) {
    return 0;
  }

  return 1;
}

function update_progress(progress_amount) {
  self.progress += progress_amount;
}

function at_least_goal() {
  return self.progress >= self.goal;
}

function equal_to_goal(player) {
  return self.progress == self.goal;
}

function is_completed() {
  return self.achievement_completed;
}

function mark_completed() {
  self.achievement_completed = 1;
}

function is_valid_achievement(achievement) {
  return isDefined(achievement);
}

function init_player_achievements(player) {
  if(isDefined(level.script)) {
    player.achievement_list = ["threestarbadsit", "threestarvehesc", "threestarobservatory", "noalarmbadsit", "onestarcp", "fullsse"];
  }

  if(isDefined(player.achievement_registration_func)) {
    player[[player.achievement_registration_func]]();
  }
}

function update_achievement(reference, progress_amt, param_1, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, param_10) {
  achievement = self.achievement_list[reference];

  if(!is_valid_achievement(achievement)) {
    return;
  }

  if(achievement is_completed()) {
    return;
  }

  if(achievement[[achievement.should_update_func]](self, param_2, param_3, param_4, param_5, param_6, param_7, param_8, param_9, param_10)) {
    achievement update_progress(progress_amt);

    if(achievement[[achievement.is_goal_reached_func]](self)) {
      self iprintlnbold("<dev string:x1c>" + reference);

      self giveachievement(reference);
      self setplayerdata("cp", "tacOpsAchievements", reference, 1);
      achievement mark_completed();
    }
  }
}

function update_achievement_all_players(reference, progress_amt) {
  foreach(player in level.players) {
    player update_achievement(reference, progress_amt);
  }
}

function are_achievements_allowed() {
  if(!isDefined(self.spawntimestamp)) {
    return true;
  }

  if(!isDefined(level.blockachievementstimestamp)) {
    return true;
  }

  if(level.blockachievementstimestamp > self.spawntimestamp) {
    return false;
  }

  return true;
}

function set_achievements_blocker() {
  level.blockachievementstimestamp = gettime();
}

function function_ee76c2b537f53629() {
  if(!istrue(game["stealth_was_broken"])) {
    level thread update_achievement_all_players("noalarmbadsit", 1);
  }
}

function function_5979446ee216f232() {
  update_achievement("fullsse", 1);
}

function function_42ae9dfc72534d75() {
  level thread update_achievement_all_players("onestarcp", 1);
}

function function_57b06ac64f28dc4a() {
  switch (level.script) {
    case #"hash_d9c138fad5b09bff":
      level thread update_achievement_all_players("threestarbadsit", 1);
      break;
    case #"hash_e7978e13d7ba3321":
      if(istrue(level.var_5f694efafeb95d7)) {} else {
        level thread update_achievement_all_players("threestarvehesc", 1);
      }

      break;
    case #"hash_fac4357bd021125d":
      level thread update_achievement_all_players("threestarobservatory", 1);
      break;
  }
}

function trapachievementboom(player) {
  var_59e88214927ce64e = player getplayerdata("cp", "cpCommonAchievements", "boom");

  if(var_59e88214927ce64e > 3) {
    return;
  }

  var_59e88214927ce64e++;
  player setplayerdata("cp", "cpCommonAchievements", "boom", var_59e88214927ce64e);

  if(var_59e88214927ce64e >= 3) {
    player giveachievement("boom");
  }
}

function function_4d0a3cba9de1db93() {
  var_bbc24b1f18a9a23a = 3;
  var_1a2abcea976d90af = self getplayerdata("cp", "cpCommonAchievements", "wallofduty");

  if(!isDefined(var_1a2abcea976d90af)) {
    var_1a2abcea976d90af = 0;
    self setplayerdata("cp", "cpCommonAchievements", "wallofduty", var_1a2abcea976d90af);
  }

  if(var_1a2abcea976d90af >= var_bbc24b1f18a9a23a) {
    return;
  }

  while(var_1a2abcea976d90af < var_bbc24b1f18a9a23a) {
    level waittill("ai_killed", vpos, sweapon, smeansofdeath, eattacker);

    if(isDefined(eattacker) && eattacker == self) {
      if(isDefined(sweapon) && isDefined(sweapon.type) && sweapon.type == "riotshield") {
        var_1a2abcea976d90af++;
        self setplayerdata("cp", "cpCommonAchievements", "wallofduty", var_1a2abcea976d90af);
      }
    }
  }

  self giveachievement("wallofduty");
}

function function_1798ae18b940195a(objweapon) {
  if(isDefined(objweapon) && (objweapon.basename == "toma_proj_mp" || objweapon.basename == "toma_proj_jup_mp")) {
    self function_6a369480dbaf1090("jup_sp_thatsonewaytodoit");
  }
}