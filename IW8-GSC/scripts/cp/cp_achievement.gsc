/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_achievement.gsc
***********************************************/

function switchminimapid(var_0) {
  if(isDefined(level.script)) {
    switch (level.script) {
      default:
        var_0.achievement_list = ["LANDLORD", "ARMED", "SMUGGLED", "LAUNDERED", "PICKLES"];
        break;
    }
  }

  if(isDefined(var_0.achievement_registration_func)) {
    var_0[[var_0.achievement_registration_func]]();
    return;
  }
}

function register_default_achievements() {
  register_achievement("LANDLORD", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("ARMED", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("SMUGGLED", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("LAUNDERED", 1, &default_init, &default_should_update, &equal_to_goal);
  register_achievement("PICKLES", 1, &default_init, &default_should_update, &callback_playeractive);
}

function register_achievement(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5[[var_2]](var_1, var_3, var_4);
  self.achievement_list[var_0] = var_5;
}

function default_init(var_0, var_1, var_2) {
  self.progress = 0;
  self.goal = var_0;
  self.should_update_func = var_1;
  self.is_goal_reached_func = var_2;
  self.achievement_completed = 0;
}

function callback_playeractive(var_0) {
  if(!istrue(var_0 getplayerdata("cp", "tacOpsAchievements", "LANDLORD")) || !istrue(var_0 getplayerdata("cp", "tacOpsAchievements", "ARMED")) || !istrue(var_0 getplayerdata("cp", "tacOpsAchievements", "SMUGGLED")) || !istrue(var_0 getplayerdata("cp", "tacOpsAchievements", "LAUNDERED"))) {
    return false;
  }

  var_0 thread scripts\cp_mp\xmike109::screenent_d("all_operations");
  var_0 setplayerdata("cp", "has_seen_cinematic", 5, 1);
  return true;
}

function default_should_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!callback_create(var_0)) {
    return false;
  }

  return true;
}

function update_progress(var_0) {
  self.progress += var_0;
}

function at_least_goal() {
  return self.progress >= self.goal;
}

function equal_to_goal(var_0) {
  return self.progress == self.goal;
}

function is_completed() {
  return self.achievement_completed;
}

function mark_completed() {
  self.achievement_completed = 1;
}

function is_valid_achievement(var_0) {
  return isDefined(var_0);
}

function update_achievement(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self.achievement_list[var_0];

  if(!is_valid_achievement(var_12)) {
    return;
  }

  if(is_completed(var_12)) {
    return;
  }

  if(var_12[[var_12.should_update_func]](self, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11)) {
    update_progress(var_12, var_1);

    if(var_12[[var_12.is_goal_reached_func]](self)) {
      if(var_0 == "LANDLORD" || var_0 == "ARMED" || var_0 == "SMUGGLED" || var_0 == "LAUNDERED") {
        thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("medal_match_complete_xp");
      } else {
        self giveachievement(var_0);
      }

      self setplayerdata("cp", "tacOpsAchievements", var_0, 1);
      mark_completed(var_12);
      return;
    }

    return;
  }
}

function update_achievement_all_players(var_0, var_1) {
  foreach(var_3 in level.players) {
    update_achievement(var_3, var_0, var_1);
  }
}

function callback_create() {
  if(!isDefined(self.ref_136A1)) {
    return true;
  }

  if(!isDefined(level.computer_interaction_start)) {
    return true;
  }

  if(level.computer_interaction_start > self.ref_136A1) {
    return false;
  }

  return true;
}

function ref_13066() {
  level.computer_interaction_start = gettime();
}

function ascender_disableplayeruse(var_0, var_1, var_2) {
  if(var_1 == "MOD_IMPACT" && isstartstr(var_2, "smoke")) {
    scriptable_reserved_count(var_0);
  }

  if(var_0 isonladder()) {
    if(var_1 == "MOD_PISTOL_BULLET" || var_1 == "MOD_RIFLE_BULLET" || var_1 == "MOD_EXPLOSIVE_BULLET") {
      thread ref_13FBE();
      return;
    }

    return;
  }
}

function trapachievementboom(var_0) {
  var_1 = var_0 getplayerdata("cp", "cpCommonAchievements", "boom");

  if(var_1 > 3) {
    return;
  }

  var_1++;
  var_0 setplayerdata("cp", "cpCommonAchievements", "boom", var_1);

  if(var_1 >= 3) {
    var_0 giveachievement("boom");
    return;
  }
}

function ref_13FBE() {
  var_0 = self getplayerdata("cp", "cpCommonAchievements", "hangtime");

  if(var_0 > 3) {
    return;
  }

  var_0++;
  self setplayerdata("cp", "cpCommonAchievements", "hangtime", var_0);

  if(var_0 >= 3) {
    self giveachievement("hangtime");
    return;
  }
}

function scriptable_reserved_count() {
  self giveachievement("smokedirect");
}

function scriptable_setups() {
  self giveachievement("wildfire");
}

function scriptable_enginedamaged() {
  self giveachievement("pilotkill");
}