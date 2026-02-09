/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_achievement_dlc2.gsc
***********************************************/

register_achievements_dlc2() {
  maps\mp\alien\_achievement::register_achievement("REACH_CARGO", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("REACH_DECK", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("KILL_KRAKEN_1ST_TIME", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("KILL_KRAKEN_WITH_RELIC", 1, maps\mp\alien\_achievement::default_init, ::is_using_relic, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("KILL_KRAKEN_AND_ALL_CHALLENGES", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::should_update_all_challenge, maps\mp\alien\_achievement::at_least_goal);
  maps\mp\alien\_achievement::register_achievement("FOUND_ALL_INTELS_MAYDAY", 9, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1);
  maps\mp\alien\_achievement::register_achievement("KILL_SEEDER_TURRETS", 15, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::equal_to_goal);
  maps\mp\alien\_achievement::register_achievement("HYPNO_TRAP_RHINO", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::equal_to_goal);
  maps\mp\alien\_achievement::register_achievement("GOT_THEEGGSTRA_XP_DLC2", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::at_least_goal, 1);
  maps\mp\alien\_achievement::register_achievement("CRAFT_ALL_ITEMS", 1, maps\mp\alien\_achievement::default_init, maps\mp\alien\_achievement::default_should_update, maps\mp\alien\_achievement::equal_to_goal);
  thread maps\mp\alien\_pillage_intel::init_player_intel_total();
  thread fixup_crafting_achievement();
}

fixup_crafting_achievement() {
  for(;;) {
    if(maps\mp\alien\_utility::is_true(level.introscreen_done)) {
      break;
    }

    wait 1;
  }

  var_0 = 10;
  var_1 = 2;
  var_2 = 0;

  for(;;) {
    var_3 = tablelookup("mp/alien/crafting_traps.csv", var_2, var_0, var_1);

    if(var_3 == "") {
      break;
    }

    update_craft_all_items_achievement(var_3);
    var_0 = var_0 + 1;
  }
}

less_than_goal() {
  return self.progress <= self.goal;
}

update_alien_kill_achievements_dlc2(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  if(!isDefined(var_1) || !isPlayer(var_1)) {
    return;
  }
  if(isDefined(self.alien_type) && self.alien_type == "seeder_spore")
    var_1 maps\mp\alien\_achievement::update_achievement("KILL_SEEDER_TURRETS", 1);
}

is_using_relic(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  return var_0 maps\mp\alien\_prestige::get_num_nerf_selected() != 0;
}

update_blocker_achievements(var_0, var_1) {
  switch (var_0) {
    case "tentacle_fight":
      maps\mp\alien\_achievement::update_achievement_all_players("REACH_CARGO", 1);
      break;
    case "blocker_cargo":
      maps\mp\alien\_achievement::update_achievement_all_players("REACH_DECK", 1);
      break;
    case "kraken":
      maps\mp\alien\_achievement::update_achievement_all_players("KILL_KRAKEN_1ST_TIME", 1);
      maps\mp\alien\_achievement::update_achievement_all_players("KILL_KRAKEN_AND_ALL_CHALLENGES", 1);

      foreach(var_3 in level.players)
      var_3 maps\mp\alien\_achievement::update_achievement("KILL_KRAKEN_WITH_RELIC", 1, var_3);

      break;
    default:
      break;
  }
}

update_hypno_trap_rhino() {
  maps\mp\alien\_achievement::update_achievement("HYPNO_TRAP_RHINO", 1);
}

update_craft_all_items_achievement(var_0) {
  if(self _meth_842A(var_0))
    maps\mp\alien\_achievement::update_achievement("CRAFT_ALL_ITEMS", 1);
}