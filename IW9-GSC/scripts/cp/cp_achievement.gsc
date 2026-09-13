/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_achievement.gsc
***********************************************/

register_default_achievements() {
  register_achievement("threestarbadsit", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("threestarvehesc", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("threestarobservatory", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("noalarmbadsit", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("onestarcp", 1, ::default_init, ::default_should_update, ::equal_to_goal);
  register_achievement("fullsse", 1, ::default_init, ::default_should_update, ::equal_to_goal);
}

register_achievement(_id_D79CAAB4489A152E, goal, init_func, should_update_func, is_goal_reached_func) {
  achievement = spawnStruct();
  achievement[[init_func]](goal, should_update_func, is_goal_reached_func);
  self.achievement_list[_id_D79CAAB4489A152E] = achievement;
}

default_init(goal, should_update_func, is_goal_reached_func) {
  self.progress = 0;
  self.goal = goal;
  self.should_update_func = should_update_func;
  self.is_goal_reached_func = is_goal_reached_func;
  self.achievement_completed = 0;
}

default_should_update(player, _id_E7ABF6B769F068E6, _id_E7ABF7B769F06B19, _id_E7ABF8B769F06D4C, _id_E7ABF9B769F06F7F, _id_E7ABFAB769F071B2, _id_E7ABFBB769F073E5, _id_E7ABFCB769F07618, _id_E7ABFDB769F0784B, _id_6F93E55DFBB17219) {
  if(!player are_achievements_allowed())
    return 0;
  else
    return 1;
}

update_progress(_id_88F6B9BA4E8D9D0B) {
  self.progress = self.progress + _id_88F6B9BA4E8D9D0B;
}

at_least_goal() {
  return self.progress >= self.goal;
}

equal_to_goal(player) {
  return self.progress == self.goal;
}

is_completed() {
  return self.achievement_completed;
}

mark_completed() {
  self.achievement_completed = 1;
}

is_valid_achievement(achievement) {
  return isDefined(achievement);
}

init_player_achievements(player) {
  if(isDefined(level.script)) {
    switch (level.script) {
      default:
        player.achievement_list = ["threestarbadsit", "threestarvehesc", "threestarobservatory", "noalarmbadsit", "onestarcp", "fullsse"];
        break;
    }
  }

  if(isDefined(player.achievement_registration_func))
    player[[player.achievement_registration_func]]();
}

update_achievement(_id_D79CAAB4489A152E, _id_AB2E13F08B37F533, _id_59A075FA10AA3736, _id_59A074FA10AA3503, _id_59A073FA10AA32D0, _id_59A07AFA10AA4235, _id_59A079FA10AA4002, _id_59A078FA10AA3DCF, _id_59A077FA10AA3B9C, _id_59A07EFA10AA4B01, _id_59A07DFA10AA48CE, _id_C61A7AF2A6570232) {
  achievement = self.achievement_list[_id_D79CAAB4489A152E];

  if(!is_valid_achievement(achievement)) {
    return;
  }
  if(achievement is_completed()) {
    return;
  }
  if(achievement[[achievement.should_update_func]](self, _id_59A074FA10AA3503, _id_59A073FA10AA32D0, _id_59A07AFA10AA4235, _id_59A079FA10AA4002, _id_59A078FA10AA3DCF, _id_59A077FA10AA3B9C, _id_59A07EFA10AA4B01, _id_59A07DFA10AA48CE, _id_C61A7AF2A6570232)) {
    achievement update_progress(_id_AB2E13F08B37F533);

    if(achievement[[achievement.is_goal_reached_func]](self)) {
      self giveachievement(_id_D79CAAB4489A152E);
      self setplayerdata("cp", "tacOpsAchievements", _id_D79CAAB4489A152E, 1);
      achievement mark_completed();
    }
  }
}

update_achievement_all_players(_id_D79CAAB4489A152E, _id_AB2E13F08B37F533) {
  foreach(player in level.players)
  player update_achievement(_id_D79CAAB4489A152E, _id_AB2E13F08B37F533);
}

are_achievements_allowed() {
  if(!isDefined(self.spawntimestamp))
    return 1;

  if(!isDefined(level.blockachievementstimestamp))
    return 1;

  if(level.blockachievementstimestamp > self.spawntimestamp)
    return 0;

  return 1;
}

set_achievements_blocker() {
  level.blockachievementstimestamp = gettime();
}

_id_EE76C2B537F53629() {
  if(!istrue(game["stealth_was_broken"]))
    level thread update_achievement_all_players("noalarmbadsit", 1);
}

_id_5979446EE216F232() {
  update_achievement("fullsse", 1);
}

_id_42AE9DFC72534D75() {
  level thread update_achievement_all_players("onestarcp", 1);
}

_id_57B06AC64F28DC4A() {
  switch (level.script) {
    case "cp_hydro":
      level thread update_achievement_all_players("threestarbadsit", 1);
      break;
    case "cp_mission_esc":
      if(istrue(level._id_05F694EFAFEB95D7)) {} else
        level thread update_achievement_all_players("threestarvehesc", 1);

      break;
    case "cp_observatory":
      level thread update_achievement_all_players("threestarobservatory", 1);
      break;
  }
}

trapachievementboom(player) {
  _id_59E88214927CE64E = player getplayerdata("cp", "cpCommonAchievements", "boom");

  if(_id_59E88214927CE64E > 3) {
    return;
  }
  _id_59E88214927CE64E++;
  player setplayerdata("cp", "cpCommonAchievements", "boom", _id_59E88214927CE64E);

  if(_id_59E88214927CE64E >= 3)
    player giveachievement("boom");
}

_id_4D0A3CBA9DE1DB93() {
  _id_BBC24B1F18A9A23A = 3;
  _id_1A2ABCEA976D90AF = self getplayerdata("cp", "cpCommonAchievements", "wallofduty");

  if(!isDefined(_id_1A2ABCEA976D90AF)) {
    _id_1A2ABCEA976D90AF = 0;
    self setplayerdata("cp", "cpCommonAchievements", "wallofduty", _id_1A2ABCEA976D90AF);
  }

  if(_id_1A2ABCEA976D90AF >= _id_BBC24B1F18A9A23A) {
    return;
  }
  while(_id_1A2ABCEA976D90AF < _id_BBC24B1F18A9A23A) {
    level waittill("ai_killed", _id_C9B351269A319209, sweapon, smeansofdeath, eattacker);

    if(isDefined(eattacker) && eattacker == self) {
      if(isDefined(sweapon) && isDefined(sweapon.type) && sweapon.type == "riotshield") {
        _id_1A2ABCEA976D90AF++;
        self setplayerdata("cp", "cpCommonAchievements", "wallofduty", _id_1A2ABCEA976D90AF);
      }
    }
  }

  self giveachievement("wallofduty");
}