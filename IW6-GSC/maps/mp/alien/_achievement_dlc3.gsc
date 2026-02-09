/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_achievement_dlc3.gsc
***********************************************/

register_achievements_dlc3() {
  maps\mp\alien\_achievement::register_achievement("FINISH_GATE", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("EXTEND_THE_BRIDGE", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("AWAKENING_ESCAPE", 1, maps\mp\alien\_achievement::default_init, ::did_player_escape, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("AWAKENING_RELIC_ESCAPE", 1, maps\mp\alien\_achievement::default_init, ::escaped_with_relic, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("AWAKENING_ALL_CHALLENGES_ESCAPE", 1, maps\mp\alien\_achievement::default_init, ::escaped_with_all_challenges, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("AWAKENING_ALL_INTEL", 6, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1);
  maps\mp\alien\_achievement::register_achievement("KILL_GARG_WITH_VANGUARD", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("GOT_THEEGGSTRA_XP_DLC3", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1);
  maps\mp\alien\_achievement::register_achievement("LIKE_A_GLOVE", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("AWAKENING_4_CLASS_ESCAPE", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  thread maps\mp\alien\_pillage_intel::init_player_intel_total();
}

init_achievement_weapon_list() {
  var_0 = [];

  foreach(var_2 in level.collectibles) {
    if(var_2.isweapon) {
      var_3 = var_2.ref;
      var_4 = getsubstr(var_3, 7);
      var_5 = getweaponbasename(var_4);
      var_6 = maps\mp\_utility::getweaponclass(var_5);
      var_7 = maps\mp\alien\_pillage::get_possible_attachments_by_weaponclass(var_6, var_5);

      foreach(var_9 in var_7) {
        if(var_9 == "alienmuzzlebrake" || var_9 == "alienmuzzlebrakesg" || var_9 == "alienmuzzlebrakesn")
          var_0[var_5] = 0;
      }
    }
  }

  self.pers["kill_tracker"] = var_0;
}

update_alien_kill_achievements_dlc3(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return;
  }
  var_9 = 1;
  var_10 = isDefined(var_1) && isPlayer(var_1);

  if(var_10 && isDefined(self.alien_type) && self.alien_type == "gargoyle") {
    if(isDefined(var_4) && (var_4 == "alienvanguard_projectile_mp" || var_4 == "alienvanguard_projectile_mini_mp"))
      var_1 maps\mp\alien\_achievement::update_achievement("KILL_GARG_WITH_VANGUARD", 1);
  }

  if(var_10) {
    if(!isDefined(var_1.pers["kill_tracker"]))
      var_1 init_achievement_weapon_list();

    if(isDefined(var_4) && maps\mp\alien\_utility::weapon_has_alien_attachment(var_4, var_9, var_1) && var_3 != "MOD_MELEE") {
      var_11 = getweaponbasename(var_4);
      var_1.pers["kill_tracker"][var_11]++;
      var_12 = 1;

      foreach(var_14 in var_1.pers["kill_tracker"]) {
        if(var_14 < 5) {
          var_12 = 0;
          break;
        }
      }

      if(var_12)
        var_1 maps\mp\alien\_achievement::update_achievement("LIKE_A_GLOVE", 1);
    }
  }
}

did_player_escape(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return maps\mp\alien\_utility::is_true(var_0.dlc3_escaped);
}

escaped_with_relic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return did_player_escape(var_0) && var_0 maps\mp\alien\_prestige::get_num_nerf_selected() >= 2;
}

escaped_with_all_challenges(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return did_player_escape(var_0) && level.all_challenge_completed;
}

check_escape_all_classes() {
  var_0 = maps\mp\alien\_persistence::get_selected_perk_0();
  var_1 = self getcoopplayerdatareservedint("dlc_3_escape_flags");

  switch (var_0) {
    case "perk_health":
      var_1 = var_1 | 1;
      break;
    case "perk_bullet_damage":
      var_1 = var_1 | 2;
      break;
    case "perk_medic":
      var_1 = var_1 | 4;
      break;
    case "perk_rigger":
      var_1 = var_1 | 8;
      break;
  }

  self setcoopplayerdatareservedint("dlc_3_escape_flags", var_1);

  if(var_1 == 15)
    maps\mp\alien\_achievement::update_achievement("AWAKENING_4_CLASS_ESCAPE", 1);
}

update_progression_achievements(var_0, var_1) {
  switch (var_0) {
    case "complete_first_gate":
      maps\mp\alien\_achievement::update_achievement_all_players("FINISH_GATE", 1);
      break;
    case "extend_the_bridge":
      maps\mp\alien\_achievement::update_achievement_all_players("EXTEND_THE_BRIDGE", 1);
      break;
    case "awakening_escape":
      foreach(var_3 in level.players) {
        var_3 maps\mp\alien\_achievement::update_achievement("AWAKENING_RELIC_ESCAPE", 1, var_3);
        var_3 maps\mp\alien\_achievement::update_achievement("AWAKENING_ESCAPE", 1, var_3);
        var_3 maps\mp\alien\_achievement::update_achievement("AWAKENING_ALL_CHALLENGES_ESCAPE", 1, var_3);
        var_3 check_escape_all_classes();
      }

      break;
    default:
      break;
  }
}