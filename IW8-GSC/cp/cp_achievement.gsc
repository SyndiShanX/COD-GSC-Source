/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\cp_achievement.gsc
***********************************************/

switchminimapid(var_0) {
  if(isDefined(level.script)) {
    switch (level.script) {
      default:
        var_0.achievement_list = ["_encstr_BA09099DA5F9CC40D8DD63", "_encstr_AAB606A02553A822", "_encstr_B45009027C7997B8E14BAB", "_encstr_A5010A6214AA72111592A844", "_encstr_88790841A4862D62A29A"];
        break;
    }
  }

  if(isDefined(var_0.achievement_registration_func))
    var_0[[var_0.achievement_registration_func]]();
}

register_default_achievements() {
  register_achievement("_encstr_BA09099DA5F9CC40D8DD63", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("_encstr_AAB606A02553A822", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("_encstr_B45009027C7997B8E14BAB", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("_encstr_A5010A6214AA72111592A844", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("_encstr_88790841A4862D62A29A", 1, ::default_init, ::default_should_update, ::callback_playeractive);
}

register_achievement(var_0, var_1, var_2, var_3, var_4) {
  var_5 = spawnStruct();
  var_5[[var_2]](var_1, var_3, var_4);
  self.achievement_list[var_0] = var_5;
}

default_init(var_0, var_1, var_2) {
  self.progress = 0;
  self.goal = var_0;
  self.should_update_func = var_1;
  self.is_goal_reached_func = var_2;
  self.achievement_completed = 0;
}

callback_playeractive(var_0) {
  if(!istrue(var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", "_encstr_BA09099DA5F9CC40D8DD63")) || !istrue(var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", "_encstr_AAB606A02553A822")) || !istrue(var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", "_encstr_B45009027C7997B8E14BAB")) || !istrue(var_0 getplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", "_encstr_A5010A6214AA72111592A844")))
    return 0;

  var_0 thread scripts\cp_mp\xmike109::screenent_d("_encstr_8A8E0FA3D3A2C810702F33A993F1D8988B");
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_B1741363C8AB97FB1B6545315E2BE275B020EBEF40", 5, 1);
  return 1;
}

default_should_update(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(!var_0 callback_create())
    return 0;

  return 1;
}

update_progress(var_0) {
  self.progress = self.progress + var_0;
}

at_least_goal() {
  return self.progress >= self.goal;
}

equal_to_goal(var_0) {
  return self.progress == self.goal;
}

is_completed() {
  return self.achievement_completed;
}

mark_completed() {
  self.achievement_completed = 1;
}

is_valid_achievement(var_0) {
  return isDefined(var_0);
}

update_achievement(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = self.achievement_list[var_0];

  if(!is_valid_achievement(var_12)) {
    return;
  }
  if(var_12 is_completed()) {
    return;
  }
  if(var_12[[var_12.should_update_func]](self, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11)) {
    var_12 update_progress(var_1);

    if(var_12[[var_12.is_goal_reached_func]](self)) {
      if(var_0 == "_encstr_BA09099DA5F9CC40D8DD63" || var_0 == "_encstr_AAB606A02553A822" || var_0 == "_encstr_B45009027C7997B8E14BAB" || var_0 == "_encstr_A5010A6214AA72111592A844")
        thread scripts\cp\agents\gametype_cp_wave_sv::giveunifiedpoints("_encstr_BA2D185B2B190B8DAFAD2C3A1B34D78D7BAD0EB1CA3A59BE0FE0");
      else
        self giveachievement(var_0);

      self setplayerdata("_encstr_850703B7D9", "_encstr_B1451318AA665FCB079166EB816733C34D7240E063", var_0, 1);
      var_12 mark_completed();
    }
  }
}

update_achievement_all_players(var_0, var_1) {
  foreach(var_3 in level.players)
  var_3 update_achievement(var_0, var_1);
}

callback_create() {
  if(!isDefined(self._id_136A1))
    return 1;

  if(!isDefined(level.computer_interaction_start))
    return 1;

  if(level.computer_interaction_start > self._id_136A1)
    return 0;

  return 1;
}

_id_13066() {
  level.computer_interaction_start = gettime();
}

ascender_disableplayeruse(var_0, var_1, var_2) {
  if(var_1 == "_encstr_A1ED0BA9FF84562B60BA073E83" && isstartstr(var_2, "_encstr_BE7206A2D07B1322"))
    var_0 scriptable_reserved_count();

  if(var_0 isonladder()) {
    if(var_1 == "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215" || var_1 == "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9" || var_1 == "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5")
      var_0 thread _id_13FBE();
  }
}

trapachievementboom(var_0) {
  var_1 = var_0 getplayerdata("_encstr_850703B7D9", "_encstr_8A2E15977046A7054047FBF8D7C3ACA91DA5E0A808F303", "_encstr_859B05D218404F");

  if(var_1 > 3) {
    return;
  }
  var_1++;
  var_0 setplayerdata("_encstr_850703B7D9", "_encstr_8A2E15977046A7054047FBF8D7C3ACA91DA5E0A808F303", "_encstr_859B05D218404F", var_1);

  if(var_1 >= 3)
    var_0 giveachievement("_encstr_859B05D218404F");
}

_id_13FBE() {
  var_0 = self getplayerdata("_encstr_850703B7D9", "_encstr_8A2E15977046A7054047FBF8D7C3ACA91DA5E0A808F303", "_encstr_856A095AD0050F03E071A5");

  if(var_0 > 3) {
    return;
  }
  var_0++;
  self setplayerdata("_encstr_850703B7D9", "_encstr_8A2E15977046A7054047FBF8D7C3ACA91DA5E0A808F303", "_encstr_856A095AD0050F03E071A5", var_0);

  if(var_0 >= 3)
    self giveachievement("_encstr_856A095AD0050F03E071A5");
}

scriptable_reserved_count() {
  self giveachievement("_encstr_96500CB9AD7BB5B2464BE4598D1D");
}

scriptable_setups() {
  self giveachievement("_encstr_B23A09134851FBF7389DE5");
}

scriptable_enginedamaged() {
  self giveachievement("_encstr_996D0A2BAAFDB758B770A0F1");
}