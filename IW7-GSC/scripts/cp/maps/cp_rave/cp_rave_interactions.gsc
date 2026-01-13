/************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_rave\cp_rave_interactions.gsc
************************************************************/

register_interactions() {
  level.interaction_hintstrings["debris_350"] = &"CP_RAVE_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1000"] = &"CP_RAVE_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1500"] = &"CP_RAVE_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2000"] = &"CP_RAVE_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2500"] = &"CP_RAVE_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1250"] = &"CP_RAVE_PURCHASE_AREA";
  level.interaction_hintstrings["debris_750"] = &"CP_RAVE_PURCHASE_AREA";
  level.interaction_hintstrings["power_door_sliding"] = &"COOP_INTERACTIONS_REQUIRES_POWER";
  level.interaction_hintstrings["weapon_upgrade"] = &"CP_RAVE_UPGRADE_WEAPON";
  level.interaction_hintstrings["interaction_packboat"] = &"CP_RAVE_USEBOAT";
  level.interaction_hintstrings["fast_travel"] = &"CP_RAVE_ENTER_PORTAL";
  level.interaction_hintstrings["interaction_woodchipper"] = &"CP_RAVE_TRAP_GENERIC";
  level.interaction_hintstrings["trap_loudspeaker"] = &"CP_RAVE_TRAP_GENERIC";
  level.interaction_hintstrings["trap_electric"] = &"CP_RAVE_TRAP_FISH";
  level.interaction_hintstrings["trap_logswing"] = &"CP_RAVE_TRAP_LOGSWING";
  level.interaction_hintstrings["trap_waterfall"] = &"CP_RAVE_TRAP_GENERIC";
  level.interaction_hintstrings["atm_deposit"] = &"CP_RAVE_ATM_DEPOSIT";
  level.interaction_hintstrings["atm_withdrawal"] = &"CP_RAVE_ATM_WITHDRAWAL";
  level.interaction_hintstrings["fix_pap"] = &"CP_RAVE_FIX_PAP";
  scripts\cp\cp_interaction::register_interaction("pap_portal", "fast_travel", undefined, scripts\cp\maps\cp_rave\cp_rave_boat::pap_portal_hint_logic, scripts\cp\maps\cp_rave\cp_rave_boat::pap_portal_use_func, 0, 0);
  scripts\cp\cp_interaction::register_interaction("fix_pap", "pap", undefined, scripts\cp\maps\cp_rave\cp_rave_boat::pap_repair_hint_func, scripts\cp\maps\cp_rave\cp_rave_boat::fix_pap, 0);
  scripts\cp\cp_interaction::register_interaction("interaction_packboat", "door_buy", undefined, scripts\cp\maps\cp_rave\cp_rave_boat::packboat_hint_func, scripts\cp\maps\cp_rave\cp_rave_boat::use_packboat, 0, 0, scripts\cp\maps\cp_rave\cp_rave_boat::init_pap_boat);
  scripts\cp\cp_interaction::register_interaction("weapon_upgrade", "pap", undefined, scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::weapon_upgrade_hint_func, scripts\cp\maps\cp_rave\cp_rave_weapon_upgrade::weapon_upgrade, 5000, 1, scripts\cp\zombies\interaction_weapon_upgrade::init_all_weapon_upgrades);
  scripts\cp\cp_interaction::register_interaction("debris_350", "door_buy", undefined, undefined, scripts\cp\zombies\cp_rave_doors::clear_debris, 350);
  scripts\cp\cp_interaction::register_interaction("debris_1000", "door_buy", undefined, undefined, scripts\cp\zombies\cp_rave_doors::clear_debris, 1000);
  scripts\cp\cp_interaction::register_interaction("debris_1500", "door_buy", undefined, undefined, scripts\cp\zombies\cp_rave_doors::clear_debris, 1500);
  scripts\cp\cp_interaction::register_interaction("debris_2000", "door_buy", undefined, undefined, scripts\cp\zombies\cp_rave_doors::clear_debris, 2000);
  scripts\cp\cp_interaction::register_interaction("debris_2500", "door_buy", undefined, undefined, scripts\cp\zombies\cp_rave_doors::clear_debris, 2500);
  scripts\cp\cp_interaction::register_interaction("debris_1250", "door_buy", undefined, undefined, scripts\cp\zombies\cp_rave_doors::clear_debris, 1250);
  scripts\cp\cp_interaction::register_interaction("debris_750", "door_buy", undefined, undefined, scripts\cp\zombies\cp_rave_doors::clear_debris, 750);
  scripts\cp\cp_interaction::register_interaction("power_door_sliding", "door_buy", undefined, undefined, undefined, 0, 1, scripts\cp\zombies\interaction_rave_openareas::init_sliding_power_doors);
  register_wall_buys();
  scripts\cp\cp_interaction::register_interaction("ritual_stone", undefined, undefined, ::rave_ritual_stone_hint, ::use_rave_ritual_stone, 0, 0);
  scripts\cp\cp_interaction::register_interaction("interaction_woodchipper", "trap", undefined, undefined, scripts\cp\zombies\interaction_woodchipper_trap::use_woodchipper_trap, 750, 1, scripts\cp\zombies\interaction_woodchipper_trap::init_woodchipper_trap);
  scripts\cp\cp_interaction::register_interaction("trap_loudspeaker", "trap", undefined, undefined, scripts\cp\zombies\interaction_loudspeaker::use_loudspeaker_trap, 750, 1, scripts\cp\zombies\interaction_loudspeaker::init_loudspeaker_trap);
  scripts\cp\cp_interaction::register_interaction("trap_electric", "trap", undefined, undefined, scripts\cp\zombies\interaction_fishtrap::use_fishtrap, 750, 1, scripts\cp\zombies\interaction_fishtrap::init_fishtrap);
  scripts\cp\cp_interaction::register_interaction("trap_logswing", "trap", undefined, undefined, scripts\cp\zombies\interaction_logswing::use_logswing_trap, 350, 1, scripts\cp\zombies\interaction_logswing::init_logswing_trap);
  scripts\cp\cp_interaction::register_interaction("trap_waterfall", "trap", undefined, undefined, scripts\cp\zombies\interaction_waterfall::use_waterfall_trap, 750, 1, scripts\cp\zombies\interaction_waterfall::init_waterfall_trap);
  scripts\cp\cp_interaction::register_interaction("atm_withdrawal", "atm", undefined, ::atm_withdrawal_hint_logic, ::atm_withdrawal, 0);
  scripts\cp\cp_interaction::register_interaction("atm_deposit", "atm", undefined, scripts\cp\cp_interaction::atm_deposit_hint, ::atm_deposit, 1000);
  scripts\cp\cp_interaction::register_interaction("memory_vo_skull", undefined, undefined, ::blank_hint_func, ::use_memory_skull, 0, 1);
  scripts\cp\cp_interaction::register_interaction("computer", undefined, undefined, ::blank_hint_func, ::use_computer, 0, 1);
  register_afterlife_games();
  register_crafting_interactions();
  register_mini_games();
  register_arcade_rom_games();
  register_challenges();
  register_super_slasher_fight_interactions();
  level notify("interactions_initialized");
  scripts\engine\utility::flag_set("interactions_initialized");
  if(isDefined(level.escape_interaction_registration_func)) {
    [[level.escape_interaction_registration_func]]();
  }
}

atm_deposit(var_0, var_1) {
  var_1 notify("stop_interaction_logic");
  var_1.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited + 1000;
  scripts\cp\cp_interaction::increase_total_deposit_amount(var_1, 1000);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("atm_deposit", "zmb_comment_vo", "low");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  if(scripts\cp\cp_interaction::exceed_deposit_limit(var_1)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  }
}

atm_withdrawal(var_0, var_1) {
  if(level.atm_amount_deposited < 1000) {
    return;
  }

  var_2 = 1000;
  var_1 scripts\cp\cp_persistence::give_player_currency(var_2, undefined, undefined, undefined, "atm");
  var_1 notify("stop_interaction_logic");
  var_1.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited - var_2;
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("withdraw_cash", "zmb_comment_vo", "low");
}

atm_withdrawal_hint_logic(var_0, var_1) {
  if(var_0.requires_power && !var_0.powered_on) {
    return &"COOP_INTERACTIONS_REQUIRES_POWER";
  }

  if(isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000) {
    return &"CP_RAVE_ATM_INSUFFICIENT_FUNDS";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

use_memory_skull(var_0, var_1) {}

use_computer(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.has_zis_soul_key)) {
    return;
  }

  if(scripts\engine\utility::istrue(level.has_picked_up_fuses)) {
    return;
  }

  var_1 playlocalsound("zmb_item_pickup");
  var_0 thread wait_for_delivery();
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

wait_for_delivery() {
  level endon("game_ended");
  self notify("wait_for_delivery");
  self endon("wait_for_delivery");
  var_0 = 3;
  var_1 = 0;
  thread scripts\cp\utility::playsoundinspace("quest_modem_connect", (-515, -1439, 284));
  while(var_1 < var_0) {
    level waittill("wave_starting");
    var_1++;
  }

  var_2 = spawn("script_model", (-532, -1477, 284));
  var_2 setModel("park_alien_gray_fuse");
  var_2.angles = (randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360));
  var_3 = spawn("script_model", (-518, -1471, 284));
  var_3 setModel("park_alien_gray_fuse");
  var_3.angles = (randomintrange(0, 360), randomintrange(0, 360), randomintrange(0, 360));
  var_3 thread delay_spawn_glow_vfx_on(var_3, "souvenir_glow");
  var_3 thread item_keep_rotating(var_3);
  var_2 thread delay_spawn_glow_vfx_on(var_2, "souvenir_glow");
  var_2 thread item_keep_rotating(var_2);
  var_2 thread fuse_pick_up_monitor(var_2, var_3);
}

delay_spawn_glow_vfx_on(var_0, var_1) {
  var_0 endon("death");
  wait(0.3);
  playFXOnTag(level._effect[var_1], var_0, "tag_origin");
}

item_keep_rotating(var_0) {
  var_0 endon("death");
  var_1 = var_0.angles;
  for(;;) {
    var_0 rotateto(var_1 + (randomintrange(-40, 40), randomintrange(-40, 90), randomintrange(-40, 90)), 3);
    wait(3);
  }
}

fuse_pick_up_monitor(var_0, var_1) {
  var_0 endon("death");
  var_0 makeusable();
  var_0 sethintstring(&"CP_RAVE_PICKUP_ITEM");
  for(;;) {
    var_0 waittill("trigger", var_2);
    if(isplayer(var_2)) {
      level.has_picked_up_fuses = 1;
      var_2 playlocalsound("part_pickup");
      var_2 thread scripts\cp\cp_vo::try_to_play_vo("quest_ufo_collect_alienfuse_2", "zmb_comment_vo", "highest", 10, 0, 0, 1, 100);
      break;
    }
  }

  foreach(var_2 in level.players) {
    var_2 setclientomnvar("zm_special_item", 1);
  }

  var_1 delete();
  var_0 delete();
}

blank_hint_func(var_0, var_1) {
  return "";
}

register_challenges() {
  level.interaction_hintstrings["challenge_repulsor"] = &"CP_RAVE_CHALLENGES_REPULSOR_CHALLENGE";
  scripts\cp\cp_interaction::register_interaction("challenge_repulsor", "wall_buy", undefined, scripts\cp\maps\cp_rave\cp_rave_challenges::repulsor_challenge_hint, scripts\cp\maps\cp_rave\cp_rave_challenges::activate_repulsor_challenge, 0);
  level.interaction_hintstrings["challenge_tripmine"] = &"CP_RAVE_CHALLENGES_ARMAGEDDON_CHALLENGE";
  scripts\cp\cp_interaction::register_interaction("challenge_armageddon", "wall_buy", undefined, scripts\cp\maps\cp_rave\cp_rave_challenges::armageddon_challenge_hint, scripts\cp\maps\cp_rave\cp_rave_challenges::activate_armageddon_challenge, 0);
  level.interaction_hintstrings["challenge_blackhole"] = &"CP_RAVE_CHALLENGES_BLACKHOLE_CHALLENGE";
  scripts\cp\cp_interaction::register_interaction("challenge_blackhole", "wall_buy", undefined, scripts\cp\maps\cp_rave\cp_rave_challenges::blackhole_challenge_hint, scripts\cp\maps\cp_rave\cp_rave_challenges::activate_blackhole_challenge, 0);
  level.interaction_hintstrings["challenge_transponder"] = &"CP_RAVE_CHALLENGES_TRANSPONDER_CHALLENGE";
  scripts\cp\cp_interaction::register_interaction("challenge_transponder", "wall_buy", undefined, scripts\cp\maps\cp_rave\cp_rave_challenges::transponder_challenge_hint, scripts\cp\maps\cp_rave\cp_rave_challenges::activate_transponder_challenge, 0);
  level.interaction_hintstrings["challenge_rewind"] = &"CP_RAVE_CHALLENGES_REWIND_CHALLENGE";
  scripts\cp\cp_interaction::register_interaction("challenge_rewind", "wall_buy", undefined, scripts\cp\maps\cp_rave\cp_rave_challenges::rewind_challenge_hint, scripts\cp\maps\cp_rave\cp_rave_challenges::activate_rewind_challenge, 0);
  level thread init_challenge_stations();
}

register_wall_buys() {
  level.interaction_hintstrings["iw7_devastator_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ar57_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m4_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_fmg_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ake_zml"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_sonic_zmr"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_revolver_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m1_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m1c_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_spas_zmr"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_crb_zml"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_erad_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_kbs_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ripper_zmr"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ump45_zml"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m8_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_cheytac_zmr"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_two_headed_axe_mp"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_golf_club_mp"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_spiked_bat_mp"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_machete_mp"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_g18_zmr"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_axe_zm"] = &"CP_RAVE_BUY_WEAPON";
  level.interaction_hintstrings["iw7_slasher_zm"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_harpoon_zm"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_harpoon1_zm"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_harpoon2_zm"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_harpoon3_zm+akimbo"] = &"CP_RAVE_PICKUP_WEAPON";
  level.interaction_hintstrings["iw7_harpoon4_zm"] = &"CP_RAVE_PICKUP_WEAPON";
  scripts\cp\cp_interaction::register_interaction("iw7_harpoon_zm", "wall_buy", undefined, ::harpoon_hint_func, ::interaction_pickup_harpoon_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_harpoon1_zm", "wall_buy", undefined, ::harpoon_hint_func, ::interaction_pickup_harpoon_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_harpoon2_zm", "wall_buy", undefined, ::harpoon_hint_func, ::interaction_pickup_harpoon_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_harpoon3_zm+akimbo", "wall_buy", undefined, ::harpoon_hint_func, ::interaction_pickup_harpoon_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_harpoon4_zm", "wall_buy", undefined, ::harpoon_hint_func, ::interaction_pickup_harpoon_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_machete_mp", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_golf_club_mp", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_two_headed_axe_mp", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_spiked_bat_mp", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_devastator_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_m8_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1000);
  scripts\cp\cp_interaction::register_interaction("iw7_g18_zmr", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 0);
  scripts\cp\cp_interaction::register_interaction("iw7_cheytac_zmr", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1000);
  scripts\cp\cp_interaction::register_interaction("iw7_m1c_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 500);
  scripts\cp\cp_interaction::register_interaction("iw7_sonic_zmr", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 750);
  scripts\cp\cp_interaction::register_interaction("iw7_spas_zmr", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_kbs_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_crb_zml", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_erad_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_ripper_zmr", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_ump45_zml", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_m4_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_ar57_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_ake_zml", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_fmg_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_revolver_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 500);
  scripts\cp\cp_interaction::register_interaction("iw7_axe_zm", "wall_buy", undefined, ::rave_wall_buy_hint_func, ::interaction_pickup_unique_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_slasher_zm", "wall_buy", undefined, undefined, ::slasher_weapon_use_func, 0);
}

register_afterlife_games() {
  level.interaction_hintstrings["basketball_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["laughingclown_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["bowling_for_planets_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["clown_tooth_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["game_race"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("basketball_game_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_basketball::use_basketball_game, 0, 0, scripts\cp\zombies\interaction_basketball::init_afterlife_basketball_game);
  scripts\cp\cp_interaction::register_interaction("clown_tooth_game_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_clowntooth::use_clowntooth_game, 0, 0, scripts\cp\zombies\interaction_clowntooth::init_afterlife_clowntooth_game);
  scripts\cp\cp_interaction::register_interaction("laughingclown_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_laughingclown::laughing_clown, 0, 0, scripts\cp\zombies\interaction_laughingclown::init_all_afterlife_laughing_clowns);
  scripts\cp\cp_interaction::register_interaction("bowling_for_planets_afterlife", "afterlife_game", undefined, undefined, scripts\cp\zombies\interaction_bowling_for_planets::use_bfp_game, 0, 0, scripts\cp\zombies\interaction_bowling_for_planets::init_bfp_afterlife_game);
  scripts\cp\cp_interaction::register_interaction("game_race", "arcade_game", undefined, scripts\cp\zombies\interaction_racing::race_game_hint_logic, scripts\cp\zombies\interaction_racing::use_race_game, 0, 1, scripts\cp\zombies\interaction_racing::init_all_race_games);
}

rave_wall_buy_hint_func(var_0, var_1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return &"CP_RAVE_WALL_BUY_DISABLED";
  }

  if(!var_1 scripts\cp\zombies\coop_wall_buys::can_give_weapon(var_0)) {
    return &"COOP_INTERACTIONS_CANNOT_BUY";
  }

  var_2 = weapon_hint_func(var_0, var_1);
  if(isDefined(var_2)) {
    return var_2;
  }

  var_3 = getweaponbasename(var_0.script_noteworthy);
  return level.interaction_hintstrings[var_3];
}

weapon_hint_func(var_0, var_1) {
  if(var_1 scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
    return &"COOP_INTERACTIONS_PURCHASE_AMMO";
  }

  return undefined;
}

harpoon_hint_func(var_0, var_1) {
  if(var_1 hasweapon(var_0.script_noteworthy)) {
    return &"COOP_GAME_PLAY_RESTRICTED";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

interaction_pickup_harpoon_weapon(var_0, var_1) {
  if(!scripts\engine\utility::flag("harpoon_unlocked")) {
    return;
  }

  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return;
  }

  if(var_1 hasweapon(var_0.script_noteworthy)) {
    return;
  }

  if(!scripts\engine\utility::istrue(var_0.quest_complete)) {
    var_0 thread wait_for_quest_completed(var_0, var_1);
  }

  if(!isDefined(var_0.clip)) {
    var_0.clip = weaponclipsize(var_0.script_noteworthy);
  }

  if(issubstr(var_0.script_noteworthy, "+akimbo") && !isDefined(var_0.left_clip)) {
    var_0.left_clip = weaponclipsize(var_0.script_noteworthy);
  }

  if(!isDefined(var_0.stock)) {
    var_0.stock = weaponmaxammo(var_0.script_noteworthy);
  }

  var_0 thread watch_player_ammo_count(var_0, var_1, var_0.script_noteworthy);
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_1 scripts\cp\maps\cp_rave\cp_rave::give_harpoon_weapon(var_0, var_1);
}

watch_player_ammo_count_for_player(var_0, var_1, var_2) {
  var_0 notify("watch_player_ammo_count_" + var_1.name);
  var_0 endon("watch_player_ammo_count_" + var_1.name);
  var_0 endon("weapon_disowned_" + var_0.script_noteworthy);
  var_1 endon("disconnect");
  for(;;) {
    if(var_1 getcurrentweapon() == var_2) {
      while(var_1 scripts\cp\utility::getvalidtakeweapon() == var_2) {
        var_1 waittill("weapon_fired", var_3);
        while(var_1 getteamsize()) {
          scripts\engine\utility::waitframe();
        }

        if(var_3 == var_2 && var_1 hasweapon(var_2)) {
          var_1.saw_clip = var_1 getweaponammoclip(var_2);
          var_1.saw_stock = var_1 getweaponammostock(var_2);
          if(var_1 isdualwielding() && isDefined(var_1.saw_left_clip)) {
            var_1.saw_left_clip = var_1 getweaponammoclip(var_2, "left");
          }
        }
      }
    }

    var_1 waittill("weapon_change");
  }
}

watch_player_ammo_count(var_0, var_1, var_2) {
  var_0 notify("watch_player_ammo_count");
  var_0 endon("watch_player_ammo_count");
  var_0 endon("weapon_disowned_" + var_0.script_noteworthy);
  var_1 endon("disconnect");
  for(;;) {
    if(var_1 getcurrentweapon() == var_2) {
      while(var_1 scripts\cp\utility::getvalidtakeweapon() == var_2) {
        var_1 waittill("weapon_fired", var_3);
        while(var_1 getteamsize()) {
          scripts\engine\utility::waitframe();
        }

        if(var_3 == var_2 && var_1 hasweapon(var_2)) {
          var_0.clip = var_1 getweaponammoclip(var_2);
          var_0.stock = var_1 getweaponammostock(var_2);
          if(var_1 isdualwielding() && isDefined(var_0.left_clip)) {
            var_0.left_clip = var_1 getweaponammoclip(var_2, "left");
          }
        }
      }
    }

    var_1 waittill("weapon_change");
  }
}

wait_for_quest_completed(var_0, var_1) {
  var_0 endon("weapon_disowned_" + var_0.script_noteworthy);
  var_1 endon("disconnect");
  var_1 waittill("harpoon_quest_completed", var_2);
  var_0.trigger setModel(getweaponmodel(var_2));
  var_0.quest_complete = 1;
  var_0.script_noteworthy = var_2;
  var_0.clip = weaponclipsize(var_2);
  var_0.stock = weaponmaxammo(var_2);
  var_0.var_394 = var_2;
  var_1 thread scripts\cp\maps\cp_rave\cp_rave::watch_for_weapon_removed(var_0, var_1);
  var_0 thread watch_player_ammo_count(var_0, var_1, var_2);
}

interaction_pickup_unique_weapon(var_0, var_1) {
  if(scripts\cp\utility::is_weapon_purchase_disabled()) {
    return;
  }

  var_1 scripts\cp\maps\cp_rave\cp_rave::cp_rave_give_weapon(var_0, var_1);
  var_1.last_interaction_point = undefined;
}

melee_weapon_init() {
  var_0 = scripts\engine\utility::getstructarray("starting_melee_weapons", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.model = spawn("script_weapon", var_2.origin, 0, 0, var_2.name);
    var_2.model.angles = var_2.angles;
  }
}

register_crafting_interactions() {
  level.interaction_hintstrings["crafting_pickup"] = &"CP_RAVE_PICKUP_OFFERING";
  level.interaction_hintstrings["crafting_item_swap"] = &"CP_RAVE_CRAFTING_ITEM_SWAP";
  level.interaction_hintstrings["crafting_station"] = &"CP_RAVE_ADD_CRAFTING_ITEM";
  level.interaction_hintstrings["crafting_nopiece"] = &"CP_RAVE_NEED_OFFERING";
  level.interaction_hintstrings["crafted_windowtrap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_LASERTRAP";
  level.interaction_hintstrings["crafted_autosentry"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_AUTOSENTRY";
  level.interaction_hintstrings["crafted_ims"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_IMS";
  level.interaction_hintstrings["crafted_medusa"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_MEDUSA";
  level.interaction_hintstrings["crafted_electric_trap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_ELECTRIC_TRAP";
  level.interaction_hintstrings["crafted_boombox"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_BOOMBOX";
  level.interaction_hintstrings["crafted_revocator"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_REVOCATOR";
  level.interaction_hintstrings["crafted_gascan"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_GASCAN";
  level.interaction_hintstrings["crafted_trap_mower"] = &"CP_RAVE_EQUIP_MOWER";
  level.interaction_hintstrings["crafted_trap_balloon"] = &"CP_RAVE_EQUIP_BALLOONS";
  level.interaction_hintstrings["lair_secret_door"] = "";
  level.interaction_hintstrings["survivor_interaction"] = &"CP_RAVE_KEVIN";
  scripts\cp\cp_interaction::register_interaction("crafting_station", "souvenir_station", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave_crafting::use_crafting_station, 0, 1, scripts\cp\maps\cp_rave\cp_rave_crafting::init_crafting_station);
  scripts\cp\cp_interaction::register_interaction("crafting_pickup", "souvenir_coin", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave_crafting::crafting_item_pickup, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_autosentry", "craftable", undefined, undefined, scripts\cp\cp_weapon_autosentry::give_crafted_sentry, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_ims", "craftable", 1, undefined, scripts\cp\zombies\craftables\_fireworks_trap::give_crafted_fireworks_trap, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_medusa", "craftable", undefined, undefined, scripts\cp\zombies\craftables\_zm_soul_collector::give_crafted_medusa, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_electric_trap", "craftable", undefined, undefined, scripts\cp\zombies\craftables\_electric_trap::give_crafted_trap, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_boombox", "craftable", undefined, undefined, scripts\cp\zombies\craftables\_boombox::give_crafted_boombox, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_revocator", "craftable", undefined, undefined, scripts\cp\zombies\craftables\_revocator::give_crafted_revocator, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_gascan", "craftable", undefined, undefined, scripts\cp\zombies\craftables\_gascan::give_crafted_gascan, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_windowtrap", "craftable", undefined, undefined, scripts\cp\zombies\interaction_windowtraps::purchase_laser_trap, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_trap_mower", "craftable", undefined, undefined, scripts\cp\crafted_trap_mower::give_crafted_trap, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_trap_balloon", "craftable", undefined, undefined, scripts\cp\crafted_trap_balloons::give_crafted_trap, 0);
  scripts\cp\cp_interaction::register_interaction("pillage_item", undefined, undefined, scripts\cp\zombies\zombies_pillage::pillage_hint_func, scripts\cp\zombies\zombies_pillage::player_used_pillage_spot, 0, 0);
  scripts\cp\cp_interaction::register_interaction("animal_statue_toys", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave::toy_animal_statue_hint_func, scripts\cp\maps\cp_rave\cp_rave::use_toy_animal_statue, 0);
  scripts\cp\cp_interaction::register_interaction("animal_statue_end_pos", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave::toy_statue_end_pos_hint_func, scripts\cp\maps\cp_rave\cp_rave::toy_animal_statue_end_pos, 0);
  scripts\cp\cp_interaction::register_interaction("charge_animal_toys", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave::toy_charging_hint_func, scripts\cp\maps\cp_rave\cp_rave::toy_charging_use_func, 0);
  scripts\cp\cp_interaction::register_interaction("memory_quest_start_pos", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave_memory_quests::memory_start_hint_func, scripts\cp\maps\cp_rave\cp_rave_memory_quests::memory_quest_start_func, 0, 0);
  scripts\cp\cp_interaction::register_interaction("memory_quest_end_pos", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave_memory_quests::memories_end_hint_func, scripts\cp\maps\cp_rave\cp_rave_memory_quests::memories_end_use_func, 0, 0);
  scripts\cp\cp_interaction::register_interaction("ring_quest_lights", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave_memory_quests::ring_quest_hint_func, scripts\cp\maps\cp_rave\cp_rave_memory_quests::ring_quest_use_func, 0, 0);
  scripts\cp\cp_interaction::register_interaction("mushroom_patch", undefined, undefined, ::mushroom_patch_hint_func, ::mushroom_patch_use_func, 0, 0);
  scripts\cp\cp_interaction::register_interaction("survivor_interaction", undefined, undefined, ::survivor_hint_func, ::survivor_use_func, 0, 0);
  scripts\cp\cp_interaction::register_interaction("boat_quest_piece", undefined, undefined, ::boat_quest_hint_func, ::boat_quest_use_func, 0, 0, ::init_boat_quest);
  scripts\cp\cp_interaction::register_interaction("pap_quest_piece", undefined, undefined, ::pap_quest_hint_func, ::pap_quest_use_func, 0, 0, ::init_pap_quest);
  scripts\cp\cp_interaction::register_interaction("lair_secret_door", undefined, undefined, undefined, ::use_lair_door, 0, 0, ::init_lair_door);
}

survivor_hint_func(var_0, var_1) {
  return level.interaction_hintstrings["survivor_interaction"];
}

survivor_use_func(var_0, var_1) {
  var_2 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");
  foreach(var_4 in var_2) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_4);
  }

  if(!scripts\engine\utility::istrue(level.metks)) {
    level thread play_first_meeting_with_ks_vo(var_1, var_0);
    return;
  }

  level thread play_meet_ks_vo(var_1, var_0);
}

add_back_to_interaction_system(var_0, var_1, var_2) {
  level endon("game_ended");
  while(scripts\cp\cp_vo::is_vo_system_busy()) {
    wait(1);
  }

  if(!scripts\cp\cp_vo::is_vo_system_busy()) {
    foreach(var_4 in level.vo_priority_level) {
      if(isDefined(var_2)) {
        if(isDefined(var_2.vo_system.vo_queue[var_4]) && var_2.vo_system.vo_queue[var_4].size > 0) {
          foreach(var_6 in var_2.vo_system.vo_queue[var_4]) {
            if(isDefined(var_6)) {
              if(soundexists(var_6.alias)) {
                wait(scripts\cp\cp_vo::get_sound_length(var_6.alias));
              }
            }
          }
        }
      }
    }
  }

  var_9 = scripts\engine\utility::getstructarray(var_0.script_noteworthy, "script_noteworthy");
  foreach(var_0B in var_9) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_0B);
  }
}

play_first_meeting_with_ks_vo(var_0, var_1) {
  level endon("game_ended");
  if(isDefined(var_0.vo_system.vo_currently_playing)) {
    if(isDefined(var_0.vo_system.vo_currently_playing.alias) && soundexists(var_0.vo_system.vo_currently_playing.alias)) {
      var_0 stoplocalsound(var_0.vo_system.vo_currently_playing.alias);
      var_0.vo_system_playing_vo = 0;
    }
  }

  switch (var_0.vo_prefix) {
    case "p1_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("meetksmith_32_1", "rave_kevin_smith_dialogue_vo", "highest", 666, 0, 0, 0, 100, 1);
      level thread add_back_to_interaction_system(var_1, "meetksmith_32_1", var_0);
      break;

    case "p2_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("meetksmith_35_1", "rave_kevin_smith_dialogue_vo", "highest", 666, 0, 0, 0, 100, 1);
      level thread add_back_to_interaction_system(var_1, "meetksmith_35_1", var_0);
      break;

    case "p3_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("ks_meetksmith_33_1", "rave_kevin_smith_dialogue_vo", "highest", 666, 0, 0, 0, 100, 1);
      level thread add_back_to_interaction_system(var_1, "ks_meetksmith_33_1", var_0);
      break;

    case "p4_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("meetksmith_34_1", "rave_kevin_smith_dialogue_vo", "highest", 666, 0, 0, 0, 100, 1);
      level thread add_back_to_interaction_system(var_1, "meetksmith_34_1", var_0);
      break;

    case "p5_":
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("meetksmith_36_1", "rave_kevin_smith_dialogue_vo", "highest", 666, 0, 0, 0, 100, 1);
      level thread add_back_to_interaction_system(var_1, "meetksmith_36_1", var_0);
      break;

    default:
      break;
  }

  level.met_kev = 1;
  level.metks = 1;
  if(!isDefined(level.players_who_met_kev)) {
    level.players_who_met_kev = [];
  }

  level.players_who_met_kev = level.players;
  level thread add_back_to_interaction_system(var_1, "");
}

play_meet_ks_vo(var_0, var_1) {
  level endon("game_ended");
  if(scripts\engine\utility::flag("photo_1_kev_given") && !scripts\engine\utility::flag("photo_1_kev_vo_done")) {
    var_0 scripts\cp\maps\cp_rave\cp_rave_j_mem_quest::play_jay_memory_to_kev(var_1);
    scripts\engine\utility::flag_set("photo_1_kev_vo_done");
    return;
  }

  if(scripts\engine\utility::flag("photo_2_kev_given") && !scripts\engine\utility::flag("photo_2_kev_vo_done")) {
    var_0 scripts\cp\maps\cp_rave\cp_rave_j_mem_quest::play_jay_memory_to_kev(var_1);
    scripts\engine\utility::flag_set("photo_2_kev_vo_done");
    return;
  }

  if(randomint(100) > 50) {
    if(!scripts\engine\utility::flag("pap_fixed")) {
      var_0 thread scripts\cp\cp_vo::try_to_play_vo("ks_pap_outoforder", "rave_ks_vo");
      level thread add_back_to_interaction_system(var_1, "ks_pap_outoforder", var_0);
      return;
    }

    level thread add_back_to_interaction_system(var_1, "");
    return;
  }

  var_2 = getweaponattachments(var_0 getcurrentweapon());
  if(scripts\engine\utility::array_contains(var_2, "cos_087") || scripts\engine\utility::array_contains(var_2, "cos_085")) {
    foreach(var_4 in var_2) {
      if(issubstr(var_4, "cos_087")) {
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("ks_memento_wwyler", "rave_ks_vo");
        level thread add_back_to_interaction_system(var_1, "ks_memento_wwyler", var_0);
        continue;
      }

      if(issubstr(var_4, "cos_085")) {
        var_0 thread scripts\cp\cp_vo::try_to_play_vo("ks_memento_carya", "rave_ks_vo");
        level thread add_back_to_interaction_system(var_1, "ks_memento_carya", var_0);
      }
    }

    return;
  }

  level thread add_back_to_interaction_system(var_1, "");
}

init_pap_quest() {
  scripts\engine\utility::flag_wait("interactions_initialized");
  var_0 = (-6122.09, 4854.49, 149);
  var_1 = (0, 101.998, 0);
  var_2 = spawn("script_model", var_0);
  var_2.angles = var_1;
  var_2 setModel("cp_rave_projector");
  level.projector_struct = var_2;
  level.pap_pieces_found = 0;
  var_3 = scripts\engine\utility::getstructarray("pap_quest_piece", "script_noteworthy");
  foreach(var_5 in var_3) {
    if(!isDefined(var_5.name)) {
      continue;
    }

    var_6 = var_5.name;
    var_5.model = spawn("script_model", var_5.origin);
    if(isDefined(var_5.angles)) {
      var_5.model.angles = var_5.angles;
    } else {
      var_5.model.angles = (0, 0, 0);
    }

    switch (var_6) {
      case "reel":
        var_5.model setModel("cp_rave_projector_reel");
        break;
    }
  }
}

init_boat_quest() {
  level.boat_pieces_found = 0;
  var_0 = scripts\engine\utility::getstructarray("boat_quest_piece", "script_noteworthy");
  foreach(var_2 in var_0) {
    if(!isDefined(var_2.name)) {
      continue;
    }

    var_3 = var_2.name;
    var_2.model = spawn("script_model", var_2.origin);
    var_2.model.angles = var_2.angles;
    switch (var_3) {
      case "propeller":
        var_2.model setModel("cp_rave_boat_motor_prop");
        break;

      case "engine":
        var_2.model setModel("cp_rave_boat_motor_handle");
        break;

      case "tiller":
        var_2.model setModel("cp_rave_boat_motor_stalk");
        break;
    }
  }
}

boat_quest_hint_func(var_0, var_1) {
  return &"CP_RAVE_INSPECT_ITEM";
}

boat_quest_use_func(var_0, var_1) {
  level.boat_pieces_found++;
  var_0.model delete();
  var_1 playlocalsound("part_pickup");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  switch (var_0.name) {
    case "propeller":
      level scripts\cp\utility::set_quest_icon(7);
      break;

    case "engine":
      level scripts\cp\utility::set_quest_icon(9);
      break;

    case "tiller":
      level scripts\cp\utility::set_quest_icon(8);
      break;
  }

  if(level.boat_pieces_found == 3) {
    switch (var_1.vo_prefix) {
      case "p1_":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("island_46_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["island_46_1"] = 1;
        break;

      case "p4_":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("island_48_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["island_48_1"] = 1;
        break;

      case "p3_":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("island_47_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["island_47_1"] = 1;
        break;

      case "p2_":
        var_1 thread scripts\cp\cp_vo::try_to_play_vo("island_49_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
        level.completed_dialogues["island_49_1"] = 1;
        break;

      default:
        break;
    }
  }
}

pap_quest_hint_func(var_0, var_1) {
  return "";
}

pap_quest_use_func(var_0, var_1) {
  level.pap_pieces_found++;
  if(level.pap_pieces_found == 1) {
    level scripts\cp\utility::set_quest_icon(11);
  } else {
    level scripts\cp\utility::set_quest_icon(12);
  }

  var_0.model delete();
  var_1 playlocalsound("part_pickup");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

register_arcade_rom_games() {
  level.interaction_hintstrings["arcade_atlantis"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_beamrid"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_boombang"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_command"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_kaboom"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_ghostbu"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_hero"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_megaman"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("arcade_atlantis", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_beamrid", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_boombang", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_command", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_kaboom", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_ghostbu", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_hero", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_megaman", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  level.interaction_hintstrings["arcade_icehock"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_seaques"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_boxing"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_oink"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_keyston"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_plaque"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_crackpo"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("arcade_icehock", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_seaques", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_boxing", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_oink", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_keyston", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_plaque", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_crackpo", "arcade_game", undefined, undefined, scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
}

collect_zombie_souls(var_0) {
  level endon("game_ended");
  level.memory_quest_items[level.memory_quest_items.size] = var_0;
  var_1 = 0;
  var_0.runner_count = 0;
  var_0.expected_souls = 0;
  var_2 = 10;
  while(var_1 < var_2) {
    level waittill("kill_near_crystal", var_3, var_4, var_5);
    var_0.expected_souls--;
    if(var_0 != var_5) {
      continue;
    }

    thread crytsal_capture_killed_essense(var_3, var_0);
    var_0.runner_count++;
    var_1++;
  }

  while(var_0.runner_count >= 1) {
    wait(0.05);
  }

  var_0.fully_charged = 1;
  var_0 notify("fully_charged");
  foreach(var_7 in level.players) {
    var_7 playlocalsound("part_pickup");
  }

  if(isDefined(var_0) && scripts\engine\utility::array_contains(level.memory_quest_items, var_0)) {
    level.memory_quest_items = scripts\engine\utility::array_remove(level.memory_quest_items, var_0);
  }
}

crytsal_capture_killed_essense(var_0, var_1) {
  var_2 = spawn("script_model", var_0);
  var_2 setModel("tag_origin_soultrail");
  var_3 = var_1.origin;
  var_4 = var_0 + (0, 0, 40);
  for(;;) {
    var_5 = distance(var_4, var_3);
    var_6 = 1500;
    var_7 = var_5 / var_6;
    if(var_7 < 0.05) {
      var_7 = 0.05;
    }

    var_2 moveto(var_3, var_7);
    var_2 waittill("movedone");
    if(distance(var_2.origin, var_1.origin) > 16) {
      var_3 = var_1.origin;
      var_4 = var_2.origin;
      continue;
    }

    break;
  }

  wait(0.25);
  var_1.runner_count--;
  var_2 delete();
}

update_rave_mode_for_player(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  while(scripts\engine\utility::istrue(var_0.rave_mode_updating)) {
    scripts\engine\utility::waitframe();
  }

  waittillframeend;
  var_0 notify("rave_interactions_updated");
}

unsetravetriggeraftertime(var_0, var_1, var_2, var_3, var_4) {
  level endon("game_ended");
  var_0 scripts\engine\utility::waittill_any_timeout_1(scripts\engine\utility::ter_op(scripts\engine\utility::istrue(level.only_one_player) || scripts\cp\utility::isplayingsolo(), 60, 2), "picked_up");
  var_0.ravetriggered = 0;
  foreach(var_6 in level.players) {
    var_6 thread update_rave_mode_for_player(var_6);
  }
}

setup_rave_dust_interactions() {
  scripts\engine\utility::flag_init("init_interaction_done");
  scripts\engine\utility::flag_wait("init_interaction_done");
  level.rave_mode_activation_funcs["mushroom_patch"] = ::rave_dust_rave_mode;
  var_0 = [1, 2, 3, 4];
  for(var_1 = 0; var_1 <= var_0.size; var_1++) {
    if(var_1 == 0) {
      var_2 = scripts\engine\utility::getstructarray("mushroom_patch", "targetname");
    } else {
      var_2 = scripts\engine\utility::getstructarray("mushroom_patch_" + var_1, "targetname");
    }

    foreach(var_4 in var_2) {
      var_4.script_noteworthy = "mushroom_patch";
      var_4.requires_power = 0;
      var_4.powered_on = 1;
      var_4.script_parameters = "default";
      var_4.custom_search_dist = 32;
      var_4.currentlyownedby = [];
      var_4.only_rave_mode = 1;
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_4);
      scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_4);
    }
  }
}

rave_dust_rave_mode(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.model) || isDefined(var_0.model) && var_0.model != "tag_origin_rave_dust") {
    var_0 setModel("tag_origin_rave_dust");
  }

  scripts\engine\utility::waitframe();
  var_0 setscriptablepartstate("rave_dust", "active");
}

mushroom_patch_use_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.rave_mode)) {
    var_0 thread delay_use_for_time(var_0, var_1);
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
    var_1 scripts\cp\zombies\zombies_rave_meter::rave_meter_large_bump();
    var_1 thread update_rave_mode_for_player(var_1);
    var_1 setscriptablepartstate("screen_effects", "fairies");
    var_1 playsoundtoplayer("cp_rave_talk_to_fairies", var_1);
    if(isDefined(var_0.currentlyownedby[var_1.name])) {
      var_0.currentlyownedby[var_1.name] scripts\cp\maps\cp_rave\cp_rave::resetpersonalent(var_0.currentlyownedby[var_1.name]);
      scripts\engine\utility::waitframe();
    }
  }
}

resetmushroompatchaftercooldown(var_0) {
  level endon("game_ended");
  level waittill("wave_starting");
  var_0.rave_model = scripts\engine\utility::random(["rave_shroom_patch_01", "rave_shroom_patch_02", "rave_shroom_patch_03"]);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  scripts\cp\maps\cp_rave\cp_rave::add_to_current_rave_interaction_list(var_0);
  foreach(var_2 in level.players) {
    var_2 notify("rave_interactions_updated");
  }
}

mushroom_patch_hint_func(var_0, var_1) {
  if(scripts\engine\utility::istrue(var_1.rave_mode)) {
    if(isDefined(var_0.currentlyownedby[var_1.name])) {
      return &"CP_RAVE_USE_FAIRIES";
    }

    return "";
  }

  return "";
}

delay_use_for_time(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  level waittill("wave_starting");
  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_1);
  var_1 thread update_rave_mode_for_player(var_1);
}

rave_ritual_stone_hint(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_rave_dust)) {
    return &"CP_RAVE_NEED_POUCH";
  }

  return &"CP_RAVE_THROW_POUCH";
}

use_rave_ritual_stone(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_1.has_rave_dust)) {
    return;
  }

  var_2 = scripts\engine\utility::get_array_of_closest(var_1.origin, scripts\engine\utility::getstructarray("ritual_stone", "script_noteworthy"), undefined, 4);
  var_1.has_rave_dust = undefined;
  var_1 setclientomnvar("zm_hud_inventory_2", 0);
  level thread trigger_rave_mode_ritual(var_0, var_1);
}

trigger_rave_mode_ritual(var_0, var_1) {
  var_2 = gettime() + 5000;
  var_3 = scripts\engine\utility::getclosest(var_0.origin, scripts\engine\utility::getstructarray("rave_fx", "targetname"));
  var_4 = (var_3.origin[0], var_3.origin[1], var_1.origin[2]);
  playFX(level._effect["ritual_stone_use"], var_4 + (0, 0, 25));
  var_5 = -25536;
  while(gettime() < var_2) {
    foreach(var_7 in level.players) {
      if(scripts\engine\utility::istrue(var_7.inlaststand)) {
        continue;
      }

      if(!isalive(var_7)) {
        continue;
      }

      if(scripts\engine\utility::istrue(var_7.rave_mode)) {
        continue;
      }

      if(distance2dsquared(var_7.origin, var_4) > var_5) {
        continue;
      }

      scripts\cp\maps\cp_rave\cp_rave::enter_rave_mode(var_7);
      var_7 thread exit_rave_on_laststand();
    }

    wait(0.1);
  }
}

exit_rave_after_time() {
  self notify("exit_rave_after_time");
  self endon("exit_rave_after_time");
  level endon("game_ended");
  level endon("rave_event_started");
  self endon("disconnect");
  self endon("last_stand");
  for(;;) {
    var_0 = scripts\engine\utility::waittill_any_timeout_1(self.current_rave_mode_timer, "update_rave_mode_timer");
    if(var_0 == "timeout") {
      scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(self);
    }
  }
}

exit_rave_on_laststand() {
  self notify("exit_rave_on_laststand");
  self endon("exit_rave_on_laststand");
  level endon("game_ended");
  level endon("rave_event_started");
  self endon("exit_rave");
  self endon("disconnect");
  self waittill("last_stand");
  scripts\cp\maps\cp_rave\cp_rave::exit_rave_mode(self);
}

register_mini_games() {
  level.interaction_hintstrings["interaction_knife_throw"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("interaction_knife_throw", "arcade_game", undefined, undefined, scripts\cp\zombies\interaction_knife_throw::use_knife_throw, 0, 0, scripts\cp\zombies\interaction_knife_throw::init_knifethrow_game);
}

register_super_slasher_fight_interactions() {
  level.interaction_hintstrings["memory_trap_trigger"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("memory_trap_trigger", "memory_trap_trigger", undefined, undefined, scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::use_memory_trap, 0, 0, scripts\cp\maps\cp_rave\cp_rave_super_slasher_fight::init_memory_traps);
}

cp_rave_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  var_0 = 5184;
  var_1 = 9216;
  var_2 = 2304;
  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      wait(1);
      continue;
    }

    var_4 = undefined;
    level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
    var_5 = sortbydistance(level.current_interaction_structs, self.origin);
    foreach(var_7 in self.disabled_interactions) {
      var_5 = scripts\engine\utility::array_remove(var_5, var_7);
    }

    if(var_5.size == 0) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(self.delay_hint)) {
      wait(0.1);
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_5[0]) && distancesquared(var_5[0].origin, self.origin) < var_2) {
      var_4 = var_5[0];
    }

    if(!isDefined(var_4) && !scripts\cp\cp_interaction::interaction_is_window_entrance(var_5[0]) && distancesquared(var_5[0].origin, self.origin) <= var_0) {
      var_4 = var_5[0];
    }

    if(isDefined(var_4) && scripts\cp\cp_interaction::interaction_is_door_buy(var_4) && !scripts\cp\cp_interaction::interaction_is_special_door_buy(var_4)) {
      var_4 = undefined;
    }

    if(!isDefined(var_4) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var_5[0].origin, self.origin) <= var_1) {
        var_4 = var_5[0];
      }

      if(isDefined(var_4) && ![[level.should_allow_far_search_dist_func]](var_4)) {
        var_4 = undefined;
      }
    } else if(!isDefined(var_4) && isDefined(var_5[0].custom_search_dist)) {
      if(distance(var_5[0].origin, self.origin) <= var_5[0].custom_search_dist) {
        var_4 = var_5[0];
      }
    }

    if(!scripts\cp\cp_interaction::can_use_interaction(var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      if(isDefined(self.ticket_item_outlined)) {
        self.ticket_item_outlined hudoutlinedisableforclient(self);
        self.ticket_item_outlined = undefined;
      }

      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_4)) {
      var_9 = scripts\cp\utility::get_closest_entrance(var_4.origin);
      if(!isDefined(var_9)) {
        self.last_interaction_point = undefined;
        wait(0.05);
        continue;
      }

      if(scripts\cp\utility::entrance_is_fully_repaired(var_9)) {
        scripts\cp\cp_interaction::reset_interaction();
        if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
          if(!isDefined(var_4.has_trap)) {
            thread scripts\cp\cp_interaction::flash_inventory();
          }
        }

        self.last_interaction_point = var_4;
        continue;
      } else {
        self notify("stop_interaction_logic");
        self.last_interaction_point = undefined;
      }

      if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
        if(!isDefined(var_4.has_trap)) {
          thread scripts\cp\cp_interaction::flash_inventory();
        }
      }
    }

    if(!isDefined(self.last_interaction_point)) {
      scripts\cp\cp_interaction::set_interaction_point(var_4);
    } else if(self.last_interaction_point == var_4 && scripts\cp\cp_interaction::interaction_is_weapon_buy(var_4) && !scripts\engine\utility::istrue(self.delay_hint)) {
      scripts\cp\cp_interaction::set_interaction_point(var_4, 0);
    } else if(self.last_interaction_point != var_4) {
      scripts\cp\cp_interaction::set_interaction_point(var_4);
    }

    wait(0.05);
  }
}

cp_rave_wait_for_interaction_triggered(var_0) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");
  for(;;) {
    self.interaction_trigger waittill("trigger", var_1);
    if(var_1 isinphase()) {
      continue;
    }

    if(!scripts\cp\cp_interaction::interaction_is_valid(var_0, var_1)) {
      wait(0.1);
      continue;
    }

    var_0.triggered = 1;
    var_0 thread scripts\cp\cp_interaction::delayed_trigger_unset();
    if(isDefined(var_0.available_ingredient_slots)) {
      if(var_0.available_ingredient_slots > 0) {
        if(!isDefined(var_1.current_crafting_struct)) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("no_souvenir_coin", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
        }
      }
    }

    var_2 = level.interactions[var_0.script_noteworthy].cost;
    if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type)) {
      level.interactions[var_0.script_noteworthy].spend_type = "null";
    }

    if(isDefined(level.interactions[var_0.script_noteworthy].can_use_override_func)) {
      if(![[level.interactions[var_0.script_noteworthy].can_use_override_func]](var_0, var_1)) {
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_souvenir(var_0) && scripts\cp\cp_interaction::player_has_souvenir(var_0, self)) {
      scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_ALREADY_HAVE");
      wait(0.1);
      continue;
    } else if(var_0.script_noteworthy == "dj_quest_speaker") {
      var_3 = self canplayerplacesentry(1, 24);
      if(!self isonground() || !var_3["result"] || abs(var_0.origin[2] - self.origin[2]) > 24) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NOT_ENOUGH_SPACE");
        wait(0.1);
        continue;
      }
    } else if(var_0.script_noteworthy == "lost_and_found") {
      if(!scripts\engine\utility::istrue(self.have_things_in_lost_and_found)) {
        wait(0.1);
        continue;
      }

      if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot != var_0) {
        wait(0.1);
        continue;
      }

      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
        var_2 = 0;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_upgrade(var_0)) {
      if(scripts\cp\utility::is_codxp()) {
        wait(0.1);
        continue;
      }

      var_4 = var_1 getcurrentweapon();
      level.prevweapon = var_1 getcurrentweapon();
      var_5 = scripts\cp\cp_weapon::get_weapon_level(var_4);
      if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
        var_2 = 0;
      } else if(scripts\engine\utility::istrue(var_1.has_zis_soul_key) || scripts\engine\utility::istrue(level.placed_alien_fuses)) {
        if(var_5 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_UPGRADE_MAXED");
          wait(0.1);
          continue;
        } else if(scripts\cp\cp_weapon::can_upgrade(var_4)) {
          if(var_5 == 1) {
            var_2 = 5000;
          } else if(var_5 == 2) {
            var_2 = 10000;
          }
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_RAVE_UPGRADE_WEAPON_FAIL");
          wait(0.1);
          continue;
        }
      } else if(var_5 == level.pap_max) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_UPGRADE_MAXED");
        wait(0.1);
        continue;
      } else if(scripts\cp\cp_weapon::can_upgrade(var_4)) {
        if(var_5 == 1) {
          var_2 = 5000;
        } else if(var_5 == 2) {
          var_2 = 10000;
        }
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_RAVE_UPGRADE_WEAPON_FAIL");
        wait(0.1);
        continue;
      }
    } else if(isDefined(var_0.script_noteworthy) && var_0.script_noteworthy == "spawned_essence") {
      if(!scripts\cp\utility::weaponhasattachment(var_1 getcurrentweapon(), "arcane_base")) {
        thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_nocore_fail", "zmb_comment_vo", "medium", 10, 0, 0, 1, 100);
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_QUEST_WOR_CANNOT_PICKUP_ESSENCE");
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_white_ark(var_0)) {
      if(!scripts\cp\utility::weaponhasattachment(var_1 getcurrentweapon(), "arcane_base")) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_QUEST_WOR_CANNOT_PICKUP_ESSENCE");
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        wait(0.1);
        continue;
      }

      var_6 = var_1 getcurrentweapon();
      var_7 = scripts\cp\utility::getbaseweaponname(var_6);
      if(var_0.script_parameters == "tickets") {
        if(self hasweapon(var_0.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_ALREADY_HAVE");
          wait(0.1);
          continue;
        }

        self.itempicked = var_0.script_noteworthy;
        scripts\cp\zombies\zombie_analytics::log_item_purchase_with_tickets(level.wave_num, self.itempicked, level.transactionid);
      }

      if(scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
        if(!scripts\cp\cp_interaction::can_purchase_ammo(var_0.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_GAME_PLAY_AMMO_MAX");
          wait(0.1);
          continue;
        } else {
          var_8 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
          var_5 = scripts\cp\cp_weapon::get_weapon_level(var_8);
          if(var_5 > 1) {
            var_2 = 4500;
          } else if(var_8 == "g18") {
            var_2 = 250;
          } else {
            var_2 = var_2 * 0.5;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_perk(var_0)) {
      if(!var_1 scripts\cp\cp_interaction::can_use_perk(var_0)) {
        var_2 = 0;
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased <= var_1.max_self_revive_machine_use) {
        var_2 = 500;
      } else {
        var_2 = scripts\cp\cp_interaction::get_perk_machine_cost(var_0);
      }
    } else if(scripts\cp\cp_interaction::interaction_is_crafting_station(var_0)) {
      if(!isDefined(var_1.current_crafting_struct) && var_0.available_ingredient_slots > 0) {
        level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_ticket_buy(var_0)) {
      if(var_0.script_noteworthy == "large_ticket_prize") {
        var_9 = scripts\cp\utility::get_attachment_from_interaction(var_0);
        if(scripts\cp\utility::weaponhasattachment(self getcurrentweapon(), var_9)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_ALREADY_HAVE");
          wait(0.1);
          continue;
        }

        if(!scripts\cp\cp_weapon::can_use_attachment(var_9)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_PILLAGE_CANT_USE");
          wait(0.1);
          continue;
        }
      } else if(var_0.script_noteworthy == "arcade_counter_grenade") {
        var_0A = scripts\cp\powers\coop_powers::what_power_is_in_slot("primary");
        if(self.powers[var_0A].charges >= level.powers[var_0A].maxcharges) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_EQUIPMENT_FULL");
          wait(0.1);
          continue;
        }
      } else if(var_0.script_noteworthy == "arcade_counter_ammo") {
        var_0B = self getcurrentweapon();
        if(self getweaponammostock(var_0B) >= weaponmaxammo(var_0B)) {
          var_0C = 1;
          if(weaponmaxammo(var_0B) == weaponclipsize(var_0B)) {
            if(self getweaponammoclip(var_0B) < weaponclipsize(var_0B)) {
              var_0C = 0;
            }
          }

          if(var_0C) {
            scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_GAME_PLAY_AMMO_MAX");
            wait(0.1);
            continue;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_fortune_teller(var_0)) {
      if(!scripts\engine\utility::istrue(level.unlimited_fnf)) {
        if(var_1.card_refills == 2) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NO_MORE_CARDS_OWNED");
          wait(0.1);
          continue;
        }
      }

      if(self.card_refills >= 1) {
        var_2 = level.fortune_visit_cost_2;
      } else {
        var_2 = level.fortune_visit_cost_1;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_grenade_wall_buy(var_0)) {
      if(!isDefined(var_0.power_name)) {
        var_0.power_name = var_0.script_noteworthy;
      }

      if(isDefined(self.powers[var_0.power_name]) && self.powers[var_0.power_name].charges >= level.powers[var_0.power_name].maxcharges) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_EQUIPMENT_FULL");
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_challenge_station(var_0)) {
      if(!isDefined(self.completed_challenges)) {
        var_2 = 0;
      } else if(scripts\engine\utility::array_contains(self.completed_challenges, var_0.script_type)) {
        var_2 = 0;
      } else {
        var_2 = 0;
      }
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(var_0, var_2, level.interactions[var_0.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);
      if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(var_0) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased >= var_1.max_self_revive_machine_use) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_CANNOT_BUY_SELF_REVIVE");
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NEED_MONEY");
      }

      wait(0.1);
      continue;
    }

    if(var_0.script_noteworthy == "atm_withdrawal") {
      if(isDefined(level.atm_transaction_amount)) {
        if(level.atm_amount_deposited < level.atm_transaction_amount) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_NEED_MONEY");
          wait(0.1);
          continue;
        }
      }
    }

    thread scripts\cp\cp_interaction::interaction_post_activate_delay(var_0);
    if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      level notify("interaction", var_0.name, undefined, self);
    } else {
      level notify("interaction", "purchase", level.interactions[var_0.script_noteworthy], self);
    }

    if(var_0.script_parameters == "tickets") {
      self.num_tickets = self.num_tickets - var_2;
      self setclientomnvar("zombie_number_of_ticket", int(self.num_tickets));
      if(isDefined(var_0.randomintrange) && isDefined(var_0.randomintrange.model)) {
        self.itempicked = var_0.randomintrange.model;
      } else {
        self.itempicked = var_0.script_noteworthy;
      }

      level.transactionid = randomint(100);
      scripts\cp\zombies\zombie_analytics::log_item_purchase_with_tickets(level.wave_num, self.itempicked, level.transactionid);
      level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
      scripts\cp\cp_interaction::interaction_post_activate_update(var_0);
      wait(0.1);
      return;
    }

    var_0D = level.interactions[var_0.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var_2, var_0D);
    level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
    if(scripts\cp\cp_interaction::interaction_is_souvenir(var_0)) {
      level thread scripts\cp\cp_interaction::souvenir_team_splash(var_0.script_noteworthy, self);
    }

    scripts\cp\cp_interaction::interaction_post_activate_update(var_0);
    wait(0.1);
    var_0.triggered = undefined;
  }
}

init_lair_door() {
  level.lair_door_switch_structs = scripts\engine\utility::getstructarray("lair_secret_door", "script_noteworthy");
  level thread init_lair_door_switches();
}

use_lair_door(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_0.pressed = 1;
  getent(var_0.script_objective, "targetname") setscriptablepartstate("light", "on");
  var_1 playlocalsound("zmb_power_switch");
  while(var_1 scripts\cp\utility::is_valid_player() && var_1 usebuttonpressed() && distance(var_1.origin, var_0.origin) < 96 && !scripts\engine\utility::flag("survivor_released")) {
    try_to_release_survivor();
    wait(0.05);
  }

  if(scripts\engine\utility::flag("survivor_released")) {
    return;
  } else {
    getent(var_0.script_objective, "targetname") setscriptablepartstate("light", "off");
  }

  wait(0.25);
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
  var_0.pressed = undefined;
}

init_survivor_trapped() {}

init_survivor_released() {}

wait_for_survivor_trapped() {
  scripts\engine\utility::flag_wait("survivor_trapped");
}

wait_for_survivor_released() {
  level thread lair_door_player_monitor();
  while(!scripts\engine\utility::flag("survivor_released")) {
    playsoundatpos((-84, -1859, 117), "survivor_pounding_door");
    wait(randomintrange(1, 2));
    if(!scripts\engine\utility::flag("survivor_released")) {
      scripts\cp\utility::playsoundinspace("ks_inside_cellar", (-84, -1859, 117));
    }

    if(!scripts\engine\utility::flag("survivor_released")) {
      wait(randomintrange(5, 8));
    }

    if(!scripts\engine\utility::flag("survivor_released")) {
      playsoundatpos((-84, -1859, 117), "survivor_pounding_door");
    }

    if(!scripts\engine\utility::flag("survivor_released")) {
      wait(randomintrange(6, 8));
    }
  }

  playsoundatpos((-29, -1859, 115), "survivor_portal_teleport");
  wait(0.4);
  scripts\cp\utility::playsoundinspace("ks_outside_cellar", (-84, -1859, 117));
}

init_lair_door_switches() {
  while(!isDefined(level.players) || level.players.size < 1) {
    wait(1);
  }

  var_0 = getent("trap_door_switch1", "targetname");
  var_1 = getent("trap_door_switch2", "targetname");
  var_2 = getent("trap_door_switch3", "targetname");
  var_3 = getent("trap_door_switch4", "targetname");
  var_0 setscriptablepartstate("light", "off");
  var_1 setscriptablepartstate("light", "off");
  var_2 setscriptablepartstate("light", "off");
  var_3 setscriptablepartstate("light", "off");
  disable_door_interaction("trap_door_switch1");
  disable_door_interaction("trap_door_switch2");
  disable_door_interaction("trap_door_switch3");
  disable_door_interaction("trap_door_switch4");
  set_switch_pressed(0, 0, 0, 0);
}

lair_door_player_monitor() {
  var_0 = 0;
  var_1 = getent("trap_door_switch1", "targetname");
  var_2 = getent("trap_door_switch2", "targetname");
  var_3 = getent("trap_door_switch3", "targetname");
  var_4 = getent("trap_door_switch4", "targetname");
  while(!scripts\engine\utility::flag("survivor_released")) {
    if(level.players.size == var_0) {
      wait(0.25);
      continue;
    }

    var_0 = level.players.size;
    switch (level.players.size) {
      case 1:
        var_1 setscriptablepartstate("light", "off");
        var_2 setscriptablepartstate("light", "on");
        var_3 setscriptablepartstate("light", "on");
        var_4 setscriptablepartstate("light", "on");
        enable_door_interaction("trap_door_switch1");
        disable_door_interaction("trap_door_switch2");
        disable_door_interaction("trap_door_switch3");
        disable_door_interaction("trap_door_switch4");
        set_switch_pressed(0, 1, 1, 1);
        break;

      case 2:
        var_1 setscriptablepartstate("light", "off");
        var_2 setscriptablepartstate("light", "off");
        var_3 setscriptablepartstate("light", "on");
        var_4 setscriptablepartstate("light", "on");
        enable_door_interaction("trap_door_switch1");
        enable_door_interaction("trap_door_switch2");
        disable_door_interaction("trap_door_switch3");
        disable_door_interaction("trap_door_switch4");
        set_switch_pressed(0, 0, 1, 1);
        break;

      case 3:
        var_1 setscriptablepartstate("light", "off");
        var_2 setscriptablepartstate("light", "off");
        var_3 setscriptablepartstate("light", "off");
        var_4 setscriptablepartstate("light", "on");
        enable_door_interaction("trap_door_switch1");
        enable_door_interaction("trap_door_switch2");
        enable_door_interaction("trap_door_switch3");
        disable_door_interaction("trap_door_switch4");
        set_switch_pressed(0, 0, 0, 1);
        break;

      case 4:
        var_1 setscriptablepartstate("light", "off");
        var_2 setscriptablepartstate("light", "off");
        var_3 setscriptablepartstate("light", "off");
        var_4 setscriptablepartstate("light", "off");
        enable_door_interaction("trap_door_switch1");
        enable_door_interaction("trap_door_switch2");
        enable_door_interaction("trap_door_switch3");
        enable_door_interaction("trap_door_switch4");
        set_switch_pressed(0, 0, 0, 0);
        break;
    }

    level scripts\engine\utility::waittill_any_timeout_1(1, "connected");
  }
}

disable_door_interaction(var_0) {
  foreach(var_2 in level.lair_door_switch_structs) {
    if(var_0 == var_2.script_objective) {
      scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    }
  }
}

enable_door_interaction(var_0) {
  foreach(var_2 in level.lair_door_switch_structs) {
    if(var_0 == var_2.script_objective) {
      scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
    }
  }
}

get_door_switch_struct(var_0) {
  foreach(var_2 in level.lair_door_switch_structs) {
    if(var_0 == var_2.script_objective) {
      return var_2;
    }
  }
}

try_to_release_survivor() {
  var_0 = 1;
  foreach(var_2 in level.lair_door_switch_structs) {
    if(!isDefined(var_2.pressed)) {
      var_0 = 0;
    }
  }

  if(var_0 && !scripts\engine\utility::flag("survivor_released")) {
    scripts\cp\utility::playsoundinspace("archery_fail_buzzer", (-84, -1859, 117));
    level thread scripts\cp\maps\cp_rave\cp_rave_boat::spawn_survivor_on_boat();
    scripts\engine\utility::waitframe();
    scripts\engine\utility::flag_set("survivor_released");
  }
}

set_switch_pressed(var_0, var_1, var_2, var_3) {
  var_4 = get_door_switch_struct("trap_door_switch1");
  if(var_0) {
    var_4.pressed = 1;
  } else {
    var_4.pressed = undefined;
  }

  var_5 = get_door_switch_struct("trap_door_switch2");
  if(var_1) {
    var_5.pressed = 1;
  } else {
    var_5.pressed = undefined;
  }

  var_6 = get_door_switch_struct("trap_door_switch3");
  if(var_2) {
    var_6.pressed = 1;
  } else {
    var_6.pressed = undefined;
  }

  var_7 = get_door_switch_struct("trap_door_switch4");
  if(var_3) {
    var_7.pressed = 1;
    return;
  }

  var_7.pressed = undefined;
}

enable_slasher_weapon() {
  var_0 = scripts\engine\utility::getstructarray("iw7_slasher_zm", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
    var_2.trigger show();
  }
}

disable_slasher_weapon() {
  level endon("game_ended");
  level waittill("interactions_initialized");
  var_0 = scripts\engine\utility::getstructarray("iw7_slasher_zm", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
    var_2.trigger hide();
  }
}

slasher_weapon_hint_func(var_0, var_1) {
  return "";
}

slasher_weapon_use_func(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  var_0.trigger hidefromplayer(var_1);
  var_1 scripts\cp\maps\cp_rave\cp_rave::cp_rave_give_weapon(var_0, var_1);
  if(!isDefined(var_1.saw_clip)) {
    var_1.saw_clip = weaponclipsize(var_0.script_noteworthy);
  }

  if(issubstr(var_0.script_noteworthy, "+akimbo") && !isDefined(var_1.saw_left_clip)) {
    var_1.saw_left_clip = weaponclipsize(var_0.script_noteworthy);
  }

  if(!isDefined(var_1.saw_stock)) {
    var_1.saw_stock = weaponmaxammo(var_0.script_noteworthy);
  }

  var_0 thread watch_player_ammo_count_for_player(var_0, var_1, "iw7_slasher_zm");
  var_1 thread watch_for_saw_removed(var_0, var_1);
}

watch_for_saw_removed(var_0, var_1) {
  var_0 notify("watch_for_weapon_removed_" + var_1.name);
  var_0 thread wait_for_saw_disowned(var_0, var_1);
  level thread scripts\cp\maps\cp_rave\cp_rave::watch_player_disconnect(var_0, var_1);
  var_1 thread wait_for_saw_removed(var_0, var_1);
  var_1 thread saw_wait_for_player_death(var_0, var_1);
}

saw_wait_for_player_death(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("watch_for_weapon_removed_" + var_1.name);
  var_0 endon("weapon_disowned_" + var_0.script_noteworthy);
  var_2 = 1;
  for(;;) {
    if(!var_2) {
      break;
    }

    var_3 = undefined;
    var_1 waittill("last_stand");
    var_2 = 0;
    var_4 = var_1 scripts\engine\utility::waittill_any_return_no_endon_death_3("player_entered_ala", "revive", "death");
    if(var_4 != "revive") {
      var_3 = var_1 scripts\engine\utility::waittill_any_return("lost_and_found_collected", "lost_and_found_time_out");
      if(isDefined(var_3) && var_3 == "lost_and_found_time_out") {
        continue;
      }
    }

    var_5 = var_1 getweaponslistall();
    foreach(var_7 in var_5) {
      if(getweaponbasename(var_7) == getweaponbasename(var_0.script_noteworthy)) {
        var_1 thread wait_for_saw_removed(var_0, var_1);
        var_2 = 1;
        break;
      }
    }
  }

  var_0 notify("weapon_disowned_" + var_0.script_noteworthy);
}

wait_for_saw_removed(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("last_stand");
  var_1 endon("disconnect");
  var_0 endon("watch_for_weapon_removed_" + var_1.name);
  var_0 endon("weapon_disowned_" + var_0.script_noteworthy);
  var_2 = 1;
  for(;;) {
    if(!var_2) {
      break;
    }

    var_1 scripts\engine\utility::waittill_any_3("weapon_purchased", "mule_munchies_sold");
    var_2 = 0;
    var_3 = var_1 getweaponslistall();
    foreach(var_5 in var_3) {
      if(getweaponbasename(var_5) == getweaponbasename(var_0.script_noteworthy)) {
        var_2 = 1;
        break;
      }
    }
  }

  var_0 notify("weapon_disowned_" + var_0.script_noteworthy);
}

wait_for_saw_disowned(var_0, var_1) {
  level endon("game_ended");
  var_0 endon("watch_for_weapon_removed_" + var_1.name);
  var_0.should_be_hidden = 1;
  var_0 waittill("weapon_disowned_" + var_0.script_noteworthy);
  var_0.should_be_hidden = undefined;
  if(isDefined(var_1)) {
    var_0 scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_1);
    var_0.trigger showtoplayer(var_1);
  }
}

init_challenge_stations() {
  wait(5);
  var_0 = getEntArray("challenge_power", "targetname");
  var_1 = getEntArray("challenge_pole", "targetname");
  foreach(var_3 in var_1) {
    if(!isDefined(var_3.script_noteworthy) || int(var_3.script_noteworthy) != 0) {
      continue;
    }

    var_4 = scripts\engine\utility::getclosest(var_3.origin, level.current_interaction_structs);
    var_4.challenge_stations = scripts\engine\utility::get_array_of_closest(var_3.origin, var_1, undefined, 4);
    var_4.power = scripts\engine\utility::getclosest(var_3.origin, var_0);
    foreach(var_6 in var_4.challenge_stations) {
      var_6.interaction = var_4;
      var_6 thread scripts\cp\maps\cp_rave\cp_rave_challenges::challenge_station_visibility_monitor();
    }

    level thread scripts\cp\maps\cp_rave\cp_rave_challenges::power_visiblity_monitor(var_4.power, var_4.script_type);
  }
}