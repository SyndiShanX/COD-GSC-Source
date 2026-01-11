/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_achievement_dlc.gsc
**********************************************/

register_achievements_dlc() {
  maps\mp\alien\_achievement::register_achievement("REACH_COMPOUND", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("REACH_FACILITY", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("KILLBOSS_1ST_TIME", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("KILLBOSS_IN_TIME", 300000, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, ::less_than_goal);
  maps\mp\alien\_achievement::register_achievement("KILL_WITH_SWEAPON", 50, maps\mp\alien\_achievement::default_init, ::should_update_kill_with_sweapon, maps\mp\alien\_achievement::equal_to_goal);
  maps\mp\alien\_achievement::register_achievement("COMPLETE_ALL_CHALLENGE", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::should_update_all_challenge, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("KILLBOSS_WITH_RELIC", 1, maps\mp\alien\_achievement::default_init, ::is_using_relic, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("KILL_PHANTOMS", 5, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::equal_to_goal);
  maps\mp\alien\_achievement::register_achievement("KILL_RHINO_PISTOL", 1, maps\mp\alien\_achievement::default_init, ::should_update_kill_rhino_pistol, maps\mp\alien\_achievement::equal_to_goal);
  maps\mp\alien\_achievement::register_achievement("FOUND_ALL_INTELS", 11, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1);
  maps\mp\alien\_achievement::register_achievement("GOT_THEEGGSTRA_XP", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1);
  thread maps\mp\alien\_pillage_intel::init_player_intel_total();
}

less_than_goal() {
  return self.progress <= self.goal;
}

update_alien_kill_achievements_dlc(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1) || !isplayer(var_1)) {
    return;
  }
  var_1 maps\mp\alien\_achievement::update_achievement("KILL_WITH_SWEAPON", 1, var_4);

  if(isDefined(self.alien_type) && self.alien_type == "locust") {
    var_1 maps\mp\alien\_achievement::update_achievement("KILL_PHANTOMS", 1);
  }

  if(isDefined(var_4) && maps\mp\_utility::getweaponclass(var_4) == "weapon_pistol" && isDefined(self.shot_only_by_pistol)) {
    var_1 maps\mp\alien\_achievement::update_achievement("KILL_RHINO_PISTOL", 1, self.alien_type, self.shot_only_by_pistol);
  }
}

should_update_kill_rhino_pistol(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isDefined(var_0) && var_0 == "elite" && isDefined(var_1) && var_1) {
    return 1;
  }

  return 0;
}

should_update_kill_with_sweapon(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(var_0 == "iw6_aliendlc11_mp") {
    return 1;
  }

  return 0;
}

is_using_relic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return var_0 maps\mp\alien\_prestige::get_num_nerf_selected() != 0;
}

update_boss_achievements(var_0, var_1) {
  switch (var_0) {
    case "compound":
      maps\mp\alien\_achievement::update_achievement_all_players("REACH_COMPOUND", 1);
      break;
    case "facility":
      maps\mp\alien\_achievement::update_achievement_all_players("REACH_FACILITY", 1);
      break;
    case "final":
      maps\mp\alien\_achievement::update_achievement_all_players("KILLBOSS_1ST_TIME", 1);
      maps\mp\alien\_achievement::update_achievement_all_players("KILLBOSS_IN_TIME", var_1);
      maps\mp\alien\_achievement::update_achievement_all_players("COMPLETE_ALL_CHALLENGE", 1);

      foreach(var_3 in level.players) {
        var_3 maps\mp\alien\_achievement::update_achievement("KILLBOSS_WITH_RELIC", 1, var_3);
      }

      break;
    default:
      break;
  }
}

update_achievement_damage_weapon_dlc(var_0) {
  if(maps\mp\_utility::getweaponclass(var_0) != "weapon_pistol") {
    self.shot_only_by_pistol = 0;
  }

  if((!isDefined(self.shot_only_by_pistol) || self.shot_only_by_pistol) && maps\mp\_utility::getweaponclass(var_0) == "weapon_pistol") {
    self.shot_only_by_pistol = 1;
  }
}