/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_achievement.gsc
***********************************************/

function switchminimapid(var0) {
  if(isDefined(level.script)) {
    switch (level.script) {
      default:
        var0.achievement_list = ["LANDLORD", "ARMED", "SMUGGLED", "LAUNDERED", "PICKLES"];
        break;
    }
  }

  if(isDefined(var0.achievement_registration_func)) {
    var0[[var0.achievement_registration_func]]();
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

function register_achievement(var0, var1, var2, var3, var4) {
  var5 = spawnStruct();
  var5[[var2]](var1, var3, var4);
  self.achievement_list[var0] = var5;
}

function default_init(var0, var1, var2) {
  self.progress = 0;
  self.goal = var0;
  self.should_update_func = var1;
  self.is_goal_reached_func = var2;
  self.achievement_completed = 0;
}

function callback_playeractive(var0) {
  if(!istrue(var0 getplayerdata("cp", "tacOpsAchievements", "LANDLORD")) || !istrue(var0 getplayerdata("cp", "tacOpsAchievements", "ARMED")) || !istrue(var0 getplayerdata("cp", "tacOpsAchievements", "SMUGGLED")) || !istrue(var0 getplayerdata("cp", "tacOpsAchievements", "LAUNDERED"))) {
    return false;
  }

  var0 thread scripts\cp_mp\xmike109::screenent_d("all_operations");
  var0 setplayerdata("cp", "has_seen_cinematic", 5, 1);
  return true;
}

function default_should_update(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(!callback_create(var0)) {
    return false;
  }

  return true;
}

function update_progress(var0) {
  self.progress += var0;
}

function at_least_goal() {
  return self.progress >= self.goal;
}

function equal_to_goal(var0) {
  return self.progress == self.goal;
}

function is_completed() {
  return self.achievement_completed;
}

function mark_completed() {
  self.achievement_completed = 1;
}

function is_valid_achievement(var0) {
  return isDefined(var0);
}

function update_achievement(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11) {
  var12 = self.achievement_list[var0];

  if(!is_valid_achievement(var12)) {
    return;
  }

  if(is_completed(var12)) {
    return;
  }

  if(var12[[var12.should_update_func]](self, var3, var4, var5, var6, var7, var8, var9, var10, var11)) {
    update_progress(var12, var1);

    if(var12[[var12.is_goal_reached_func]](self)) {
      if(var0 == "LANDLORD" || var0 == "ARMED" || var0 == "SMUGGLED" || var0 == "LAUNDERED") {
        thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("medal_match_complete_xp");
      } else {
        self giveachievement(var0);
      }

      self setplayerdata("cp", "tacOpsAchievements", var0, 1);
      mark_completed(var12);
      return;
    }

    return;
  }
}

function update_achievement_all_players(var0, var1) {
  foreach(var3 in level.players) {
    update_achievement(var3, var0, var1);
  }
}

function callback_create() {
  if(!isDefined(self.ref_136a1)) {
    return true;
  }

  if(!isDefined(level.computer_interaction_start)) {
    return true;
  }

  if(level.computer_interaction_start > self.ref_136a1) {
    return false;
  }

  return true;
}

function ref_13066() {
  level.computer_interaction_start = gettime();
}

function ascender_disableplayeruse(var0, var1, var2) {
  if(var1 == "MOD_IMPACT" && isstartstr(var2, "smoke")) {
    scriptable_reserved_count(var0);
  }

  if(var0 isonladder()) {
    if(var1 == "MOD_PISTOL_BULLET" || var1 == "MOD_RIFLE_BULLET" || var1 == "MOD_EXPLOSIVE_BULLET") {
      thread ref_13fbe();
      return;
    }

    return;
  }
}

function trapachievementboom(var0) {
  var1 = var0 getplayerdata("cp", "cpCommonAchievements", "boom");

  if(var1 > 3) {
    return;
  }

  var1++;
  var0 setplayerdata("cp", "cpCommonAchievements", "boom", var1);

  if(var1 >= 3) {
    var0 giveachievement("boom");
    return;
  }
}

function ref_13fbe() {
  var0 = self getplayerdata("cp", "cpCommonAchievements", "hangtime");

  if(var0 > 3) {
    return;
  }

  var0++;
  self setplayerdata("cp", "cpCommonAchievements", "hangtime", var0);

  if(var0 >= 3) {
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