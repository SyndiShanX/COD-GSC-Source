/**************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_disco\cp_disco_interactions.gsc
**************************************************************/

register_interactions() {
  level.interaction_hintstrings["debris_350"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1000"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1500"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2000"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2500"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1250"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_750"] = &"CP_DISCO_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["power_door_sliding"] = &"COOP_INTERACTIONS_REQUIRES_POWER";
  level.interaction_hintstrings["power_door_pivot"] = &"COOP_INTERACTIONS_REQUIRES_POWER";
  level.interaction_hintstrings["chi_0"] = "";
  level.interaction_hintstrings["chi_1"] = "";
  level.interaction_hintstrings["chi_2"] = "";
  level.interaction_hintstrings["fan_trap"] = &"CP_DISCO_INTERACTIONS_FAN_TRAP";
  level.interaction_hintstrings["electric_trap"] = &"CP_DISCO_INTERACTIONS_ELECTRIC_TRAP";
  level.interaction_hintstrings["trap_buffer"] = &"CP_DISCO_INTERACTIONS_TRAP_BUFFER_HINT";
  level.interaction_hintstrings["trap_hydrant"] = &"CP_DISCO_INTERACTIONS_TRAP_HYDRANT_HINT";
  level.interaction_hintstrings["trap_mosh"] = &"CP_DISCO_INTERACTIONS_TRAP_MOSH_HINT";
  scripts\cp\cp_interaction::register_interaction("debris_350", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 350);
  scripts\cp\cp_interaction::register_interaction("debris_1000", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1000);
  scripts\cp\cp_interaction::register_interaction("debris_1500", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1500);
  scripts\cp\cp_interaction::register_interaction("debris_2000", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 2000);
  scripts\cp\cp_interaction::register_interaction("debris_2500", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 2500);
  scripts\cp\cp_interaction::register_interaction("debris_1250", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1250);
  scripts\cp\cp_interaction::register_interaction("debris_750", "door_buy", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 750);
  scripts\cp\cp_interaction::register_interaction("team_killdoor", "team_killdoor", undefined, undefined, undefined, 0, 1);
  scripts\cp\cp_interaction::register_interaction("chi_0", "chi_door", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 0, 0);
  scripts\cp\cp_interaction::register_interaction("chi_1", "chi_door", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1, 0);
  scripts\cp\cp_interaction::register_interaction("chi_2", "chi_door", undefined, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 2, 0);
  scripts\cp\cp_interaction::register_interaction("power_door_sliding", "door_buy", undefined, undefined, undefined, 0, 1, ::init_sliding_power_doors);
  scripts\cp\cp_interaction::register_interaction("power_door_pivot", "door_buy", undefined, undefined, undefined, 0, 1, ::init_pivot_power_doors);
  disco_register_interaction(1, "phonebooth", undefined, undefined, ::scripts\cp\maps\cp_disco\phonebooth::hint_phonebooth, ::scripts\cp\maps\cp_disco\phonebooth::use_phonebooth, 0, 1, ::scripts\cp\maps\cp_disco\phonebooth::init_phonebooth);
  disco_register_interaction(1, "disco_record", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::discorecordhint, ::scripts\cp\maps\cp_disco\cp_disco::discorecorduse, 0, 1, ::scripts\cp\maps\cp_disco\cp_disco::init_disco_record);
  disco_register_interaction(1, "punk_record", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::punkrecordhint, ::scripts\cp\maps\cp_disco\cp_disco::punkrecorduse, 0, 1, ::scripts\cp\maps\cp_disco\cp_disco::init_punk_record);
  disco_register_interaction(1, "pa_turntable", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::paturntablehint, ::scripts\cp\maps\cp_disco\cp_disco::paturntableuse, 0, 1, ::scripts\cp\maps\cp_disco\cp_disco::init_pa_turntables);
  disco_register_interaction(1, "clock", undefined, undefined, ::hint_nunchucks, ::use_nunchucks_object, 0, 0, ::init_nunchucks);
  disco_register_interaction(1, "clock_2", undefined, undefined, ::hint_nunchucks, ::use_nunchucks_object_2, 0, 0, ::init_nunchucks_2);
  disco_register_interaction(1, "clock_3", undefined, undefined, ::hint_nunchucks, ::use_nunchucks_object_3, 0, 0, ::init_nunchucks_3);
  disco_register_interaction(1, "memory_tv", undefined, undefined, ::hint_nunchucks, ::use_memory_tv_object, 0, 0, ::init_memory_tv);
  disco_register_interaction(1, "memory_object_three", undefined, undefined, ::mem_object_hint, ::mem_object_func, 0, 0, ::init_mem3);
  disco_register_interaction(1, "memory_object_four", undefined, undefined, ::mem_object_hint, ::mem_object_func, 0, 0, ::init_mem4);
  disco_register_interaction(1, "memory_object_five", undefined, undefined, ::mem_object_hint, ::mem_object_func, 0, 0, ::init_mem5);
  disco_register_interaction(1, "memory_object_six", undefined, undefined, ::mem_object_hint, ::mem_object_func, 0, 0, ::init_mem6);
  register_environment_interactions();
  disco_register_interaction(1, "rk_relic_pos", undefined, undefined, ::scripts\cp\maps\cp_disco\rat_king_fight::rkrelic_hint_func, ::scripts\cp\maps\cp_disco\rat_king_fight::pickuprkrelic, 0, 0, ::scripts\cp\maps\cp_disco\rat_king_fight::init_rkrelic);
  disco_register_interaction(1, "rk_arena_center", undefined, undefined, ::scripts\cp\maps\cp_disco\rat_king_fight::rkarenacenter_hint_func, ::scripts\cp\maps\cp_disco\rat_king_fight::userkarenacenter, 0, 0, undefined);
  disco_register_interaction(1, "rk_debug", undefined, undefined, ::scripts\cp\maps\cp_disco\rat_king_fight::rkdebug_hint_func, ::scripts\cp\maps\cp_disco\rat_king_fight::userkdebug, 0, 0, undefined);
  scripts\cp\cp_interaction::register_interaction("trap_buffer", "trap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_traps::use_buffer_trap, 750, 1, ::scripts\cp\maps\cp_disco\cp_disco_traps::init_buffer_trap);
  scripts\cp\cp_interaction::register_interaction("trap_hydrant", "trap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_traps::use_hydrant_trap, 350, 1, ::scripts\cp\maps\cp_disco\cp_disco_traps::init_hydrant_trap);
  scripts\cp\cp_interaction::register_interaction("trap_mosh", "trap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_traps::use_mosh_trap, 750, 1, ::scripts\cp\maps\cp_disco\cp_disco_traps::init_mosh_trap);
  scripts\cp\cp_interaction::register_interaction("fan_trap", "trap", undefined, undefined, ::use_fan_trap, 750, 1, ::init_fan_trap);
  scripts\cp\cp_interaction::register_interaction("electric_trap", "trap", undefined, undefined, ::use_electric_trap, 750, 0, ::init_electric_trap);
  disco_register_interaction(1, "turnstile", undefined, undefined, ::scripts\cp\maps\cp_disco\disco_mpq::empty_hint, ::scripts\cp\maps\cp_disco\disco_mpq::use_turnstile, 0, 0, ::scripts\cp\maps\cp_disco\disco_mpq::init_turnstile);
  disco_register_interaction(1, "disco_fever_interact", undefined, undefined, ::scripts\cp\maps\cp_disco\disco_mpq::discofeverhintfunc, ::scripts\cp\maps\cp_disco\disco_mpq::use_turntable, 0, 0, ::scripts\cp\maps\cp_disco\disco_mpq::init_turntable);
  disco_register_interaction(1, "mpq_relics", undefined, undefined, ::scripts\cp\maps\cp_disco\disco_mpq::mpqrelichintfunc, ::scripts\cp\maps\cp_disco\disco_mpq::mpqrelicusefunc, 0, 0);
  register_martial_arts_style_interactions();
  register_weapon_interactions();
  register_pack_a_punch_interactions();
  register_afterlife_games();
  register_crafting_interactions();
  level notify("interactions_initialized");
  scripts\engine\utility::flag_set("interactions_initialized");
  if(isDefined(level.escape_interaction_registration_func)) {
    [[level.escape_interaction_registration_func]]();
  }
}

register_pack_a_punch_interactions() {
  level.interaction_hintstrings["enter_stall"] = &"CP_DISCO_INTERACTIONS_NEED_TOKENS";
  level.interaction_hintstrings["enter_stall_allowed"] = &"CP_DISCO_INTERACTIONS_ENTER_THIS_AREA";
  level.interaction_hintstrings["enter_peepshow"] = &"CP_DISCO_INTERACTIONS_NEED_TICKET";
  level.interaction_hintstrings["enter_peepshow_allowed"] = &"CP_DISCO_INTERACTIONS_ENTER_THIS_AREA";
  level.interaction_hintstrings["peepshow_flyer"] = "";
  level.interaction_hintstrings["pickup_reel"] = "";
  level.interaction_hintstrings["add_reel"] = &"CP_DISCO_INTERACTIONS_ADD_REEL";
  level.interaction_hintstrings["pap_fuse_switch"] = "";
  level.interaction_hintstrings["pap_fusebox"] = "";
  level.interaction_hintstrings["weapon_upgrade"] = &"CP_DISCO_INTERACTIONS_UPGRADE_WEAPON";
  scripts\cp\cp_interaction::register_interaction("enter_stall", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::enter_pap_stall, 0, 0);
  scripts\cp\cp_interaction::register_interaction("add_reel", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::add_reel, 0, 0, ::scripts\cp\maps\cp_disco\cp_disco::init_projector);
  scripts\cp\cp_interaction::register_interaction("pickup_reel", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::pickup_reel, 0, 0);
  scripts\cp\cp_interaction::register_interaction("pap_portal", "fast_travel", undefined, ::scripts\cp\maps\cp_disco\cp_disco::pap_portal_hint_logic, ::scripts\cp\maps\cp_disco\cp_disco::pap_portal_use_func, 0, 0);
  scripts\cp\cp_interaction::register_interaction("enter_stall_allowed", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::enter_pap_stall, 0, 0);
  scripts\cp\cp_interaction::register_interaction("enter_peepshow", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::enter_peepshow, 0, 0);
  scripts\cp\cp_interaction::register_interaction("enter_peepshow_allowed", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::enter_peepshow, 0, 0);
  scripts\cp\cp_interaction::register_interaction("peepshow_flyer", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::take_peepshow_flyer, 0, 0, ::scripts\cp\maps\cp_disco\cp_disco::init_peepshow_flyer);
  scripts\cp\cp_interaction::register_interaction("pap_fuse_switch", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::use_pap_upgrade_switch, 0, 0);
  scripts\cp\cp_interaction::register_interaction("pap_fusebox", "pap", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco::take_fuses, 0, 0);
  scripts\cp\cp_interaction::register_interaction("weapon_upgrade", "pap", undefined, ::scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::weapon_upgrade_hint_func, ::scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::weapon_upgrade, 5000, 1, ::scripts\cp\zombies\interaction_weapon_upgrade::init_all_weapon_upgrades);
}

register_martial_arts_style_interactions() {
  disco_register_interaction(1, "martial_arts_animals", undefined, undefined, ::scripts\cp\maps\cp_disco\kung_fu_mode::style_hint_func, ::scripts\cp\maps\cp_disco\kung_fu_mode::choose_martial_arts_style, 0, 0, ::scripts\cp\maps\cp_disco\kung_fu_mode::ma_style_init);
  disco_register_interaction(1, "gourd_station", undefined, undefined, ::scripts\cp\maps\cp_disco\kung_fu_mode::usegourd_hint_func, ::scripts\cp\maps\cp_disco\kung_fu_mode::usegourdstation, 0, 0, ::scripts\cp\maps\cp_disco\kung_fu_mode::guord_interaction_init);
  disco_register_interaction(0, "martial_arts_trainer", undefined, undefined, ::scripts\cp\maps\cp_disco\kung_fu_mode::trainer_hint_func, ::scripts\cp\maps\cp_disco\kung_fu_mode::talk_to_trainer, 0, 0, ::scripts\cp\maps\cp_disco\kung_fu_mode::init_martial_arts_trainer);
  disco_register_interaction(1, "black_cat", undefined, undefined, ::scripts\cp\maps\cp_disco\kung_fu_mode::blackcathintfunc, ::scripts\cp\maps\cp_disco\kung_fu_mode::blackcatusefunc, 0, 0, ::scripts\cp\maps\cp_disco\kung_fu_mode::blackcatinitfunc);
  disco_register_interaction(1, "perk_candy_box", undefined, undefined, ::scripts\cp\maps\cp_disco\rat_king_fight::perkbox_hintfunc, ::scripts\cp\maps\cp_disco\rat_king_fight::perkbox_usefunc, 0, 0, ::scripts\cp\maps\cp_disco\rat_king_fight::init_rk_candy_interactions);
}

register_environment_interactions() {
  level.interaction_hintstrings["atm_deposit"] = &"CP_DISCO_INTERACTIONS_ATM_DEPOSIT";
  level.interaction_hintstrings["atm_withdrawal"] = &"CP_DISCO_INTERACTIONS_ATM_WITHDRAWAL";
  disco_register_interaction(1, "pay_phones", "atm", undefined, ::blank_hint, ::blank, 0);
  disco_register_interaction(1, "trash_cans", "atm", undefined, ::blank_hint, ::trash_can_use, 0);
  disco_register_interaction(0, "atm_deposit", "atm", undefined, ::scripts\cp\cp_interaction::atm_deposit_hint, ::atm_deposit, 1000, 1, undefined);
  disco_register_interaction(0, "atm_withdrawal", "atm", undefined, ::atm_withdrawal_hint, ::atm_withdrawal, 0, 1, ::setup_atm_system);
}

trash_can_use(var_0, var_1) {
  if(!isDefined(var_0.used_by)) {
    var_0.used_by = [];
  }

  if(isDefined(var_1.first_cipher_seen) && var_1.first_cipher_seen && !scripts\engine\utility::array_contains(var_0.used_by, var_1)) {
    var_0.used_by[var_0.used_by.size] = var_1;
    var_0.used_by_player = 1;
    var_1.treasure_cans_used++;
    var_1 notify("player_used_trashcan");
    var_1 playlocalsound("skullbuster_arcade_pickup_spraycleaner");
    level notify("player_used_trashcan");
  }
}

blank(var_0, var_1) {}

blank_hint(var_0, var_1) {
  return "";
}

blank_use(var_0, var_1) {
  var_1 playlocalsound("part_pickup");
  thread disableinteractionfortime(var_0, 5);
}

register_weapon_interactions() {
  level.interaction_hintstrings["iw7_ar57_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m4_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_fmg_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ake_zml"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_sonic_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_g18_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_revolver_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m1_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m1c_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_spas_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_crb_zml"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_erad_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_kbs_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_g18c_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ripper_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ump45_zml"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m8_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_cheytac_zmr"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_devastator_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_axe_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_katana_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_rvn_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_udm45_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_katana_zm"] = &"CP_DISCO_INTERACTIONS_BUY_WEAPON";
  disco_register_interaction(1, "iw7_katana_zm", "wall_buy", undefined, ::scripts\cp\maps\cp_disco\rat_king_fight::katanahintfunc, ::scripts\cp\maps\cp_disco\rat_king_fight::katanausefunc, 10000);
  var_0 = 500;
  scripts\cp\cp_interaction::register_interaction("iw7_revolver_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_m1c_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  var_0 = 750;
  scripts\cp\cp_interaction::register_interaction("iw7_g18c_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_sonic_zmr", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_udm45_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  var_0 = 1000;
  scripts\cp\cp_interaction::register_interaction("iw7_m8_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_cheytac_zmr", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_g18_zmr", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_rvn_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_spas_zmr", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_kbs_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_crb_zml", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_erad_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_ripper_zmr", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_ump45_zml", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_devastator_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, var_0);
  scripts\cp\cp_interaction::register_interaction("iw7_m4_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_ar57_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_ake_zml", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_fmg_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_axe_zm", "wall_buy", undefined, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
}

register_afterlife_games() {
  level.interaction_hintstrings["basketball_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["laughingclown_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["bowling_for_planets_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["clown_tooth_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["game_race"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_icehock"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_seaques"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_boxing"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_oink"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_keyston"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_plaque"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_crackpo"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_hero"] = &"COOP_INTERACTIONS_PLAY_GAME";
  scripts\cp\cp_interaction::register_interaction("arcade_hero", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_icehock", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_seaques", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_boxing", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_oink", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_keyston", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_plaque", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_crackpo", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("basketball_game_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_basketball::use_basketball_game, 0, 0, ::scripts\cp\zombies\interaction_basketball::init_afterlife_basketball_game);
  scripts\cp\cp_interaction::register_interaction("clown_tooth_game_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_clowntooth::use_clowntooth_game, 0, 0, ::scripts\cp\zombies\interaction_clowntooth::init_afterlife_clowntooth_game);
  scripts\cp\cp_interaction::register_interaction("laughingclown_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_laughingclown::laughing_clown, 0, 0, ::scripts\cp\zombies\interaction_laughingclown::init_all_afterlife_laughing_clowns);
  scripts\cp\cp_interaction::register_interaction("bowling_for_planets_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_bowling_for_planets::use_bfp_game, 0, 0, ::scripts\cp\zombies\interaction_bowling_for_planets::init_bfp_afterlife_game);
  scripts\cp\cp_interaction::register_interaction("game_race", "arcade_game", undefined, ::scripts\cp\zombies\interaction_racing::race_game_hint_logic, ::scripts\cp\zombies\interaction_racing::use_race_game, 0, 1, ::scripts\cp\zombies\interaction_racing::init_all_race_games);
}

register_crafting_interactions() {
  level.interaction_hintstrings["craft_robot"] = "";
  level.interaction_hintstrings["purchase_robot"] = &"CP_DISCO_PURCHASE_ROBOT";
  level.interaction_hintstrings["craft_zombgone"] = "";
  level.interaction_hintstrings["purchase_zombgone"] = &"CP_DISCO_PURCHASE_ZOMBGONE";
  level.interaction_hintstrings["craft_turret"] = "";
  level.interaction_hintstrings["purchase_turret"] = &"CP_DISCO_PURCHASE_TURRET";
  level.interaction_hintstrings["craft_boombox"] = "";
  level.interaction_hintstrings["purchase_boombox"] = &"CP_DISCO_PURCHASE_BOOMBOX";
  level.interaction_hintstrings["craft_lavalamp"] = "";
  level.interaction_hintstrings["purchase_lavalamp"] = &"CP_DISCO_PURCHASE_LAVALAMP";
  level.interaction_hintstrings["puzzle"] = "";
  scripts\cp\cp_interaction::register_interaction("craft_zombgone", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("purchase_zombgone", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("craft_turret", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("purchase_turret", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("craft_boombox", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("purchase_boombox", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("craft_lavalamp", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("purchase_lavalamp", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("craft_robot", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("purchase_robot", "souvenir_station", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::use_crafting_station, 0);
  scripts\cp\cp_interaction::register_interaction("pillage_item", undefined, undefined, ::scripts\cp\zombies\zombies_pillage::pillage_hint_func, ::scripts\cp\zombies\zombies_pillage::player_used_pillage_spot, 0, 0);
  scripts\cp\cp_interaction::register_interaction("puzzle", "souvenir_coin", undefined, undefined, ::scripts\cp\maps\cp_disco\cp_disco_crafting::pickup_puzzle, 0);
  scripts\cp\maps\cp_disco\cp_disco_crafting::init_crafting();
}

disco_register_interaction(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  var_0A = spawnStruct();
  var_0A.name = var_1;
  var_0A.hint_func = var_4;
  var_0A.spend_type = var_2;
  var_0A.tutorial = var_3;
  var_0A.activation_func = var_5;
  var_0A.enabled = 1;
  var_0A.disable_guided_interactions = var_0;
  if(!isDefined(var_6)) {
    var_6 = 0;
  }

  var_0A.cost = var_6;
  if(isDefined(var_7)) {
    var_0A.requires_power = var_7;
  } else {
    var_0A.requires_power = 0;
  }

  var_0A.init_func = var_8;
  var_0A.can_use_override_func = var_9;
  level.interactions[var_1] = var_0A;
}

init_pivot_power_doors() {
  var_0 = scripts\engine\utility::getstructarray("power_door_pivot", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread pivot_power_door();
  }
}

pivot_power_door() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  if(isDefined(self.script_sound)) {
    playsoundatpos(self.origin, self.script_sound);
  }

  if(isDefined(self.target) && self.target == "subway_left_door") {
    wait(0.2);
    playsoundatpos(self.origin, "power_buy_subway_gate_open_left");
    wait(0.7);
  }

  if(isDefined(self.target) && self.target == "subway_right_door") {
    playsoundatpos(self.origin, "power_buy_subway_gate_open_right");
    wait(0.9);
  }

  var_0 = getEntArray(self.target, "targetname");
  foreach(var_2 in var_0) {
    if(var_2.classname == "script_brushmodel") {
      var_2 connectpaths();
      var_2 notsolid();
    }

    if(isDefined(self.script_angles)) {
      if(!isDefined(var_2.angles)) {
        var_2.angles = (0, 0, 0);
      }

      var_2 rotateto(var_2.angles + self.script_angles, 1);
      continue;
    }

    var_2 hide();
  }

  scripts\cp\cp_interaction::disable_linked_interactions(self);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(self);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(self.script_area);
}

init_sliding_power_doors() {
  var_0 = scripts\engine\utility::getstructarray("power_door_sliding", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2 thread sliding_power_door();
  }
}

sliding_power_door() {
  if(scripts\engine\utility::istrue(self.requires_power)) {
    level scripts\engine\utility::waittill_any_3("power_on", self.power_area + " power_on");
  }

  self.powered_on = 1;
  if(isDefined(self.script_sound)) {
    playsoundatpos(self.origin, self.script_sound);
  }

  var_0 = getEntArray(self.target, "targetname");
  foreach(var_2 in var_0) {
    if(var_2.classname == "script_brushmodel") {
      var_2 connectpaths();
      var_2 notsolid();
    }

    var_3 = undefined;
    if(isDefined(var_2.target)) {
      var_3 = scripts\engine\utility::getstruct(var_2.target, "targetname");
    }

    if(isDefined(var_3)) {
      var_4 = var_3.origin - var_2.origin;
      var_2 moveto(var_2.origin + (var_4[0], var_4[1], 0), 0.5, 0.1, 0.1);
      continue;
    }

    if(isDefined(var_2.script_angles)) {
      var_2 rotateto(var_2.script_angles, 0.75);
      continue;
    }

    var_2 hide();
  }

  scripts\cp\cp_interaction::disable_linked_interactions(self);
  scripts\cp\zombies\zombies_spawning::set_adjacent_volume_from_door_struct(self);
  scripts\cp\zombies\zombies_spawning::activate_volume_by_name(self.script_area);
}

disableinteractionfortime(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  if(isDefined(var_1)) {
    wait(var_1);
  } else {
    wait(3);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

setup_atm_system() {
  level.atm_amount_deposited = 0;
}

atm_deposit(var_0, var_1) {
  var_1 notify("stop_interaction_logic");
  var_1.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited + 1000;
  scripts\cp\cp_interaction::increase_total_deposit_amount(var_1, 1000);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("atm_deposit", "zmb_comment_vo", "low");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  var_1 scripts\cp\cp_interaction::refresh_interaction();
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
  level.atm_amount_deposited = level.atm_amount_deposited - var_2;
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("withdraw_cash", "zmb_comment_vo", "low");
  var_1 scripts\cp\cp_interaction::refresh_interaction();
}

atm_withdrawal_hint(var_0, var_1) {
  if(var_0.requires_power && !var_0.powered_on) {
    return &"COOP_INTERACTIONS_REQUIRES_POWER";
  }

  if(isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000) {
    return &"CP_DISCO_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}

final_part_rewind_quest() {
  if(!isDefined(self.clocks_destroyed)) {
    self.clocks_destroyed = 0;
  }

  if(!isDefined(self.array_of_clocks)) {
    self.array_of_clocks = [];
  }

  self.array_of_clocks = level.clocks_to_be_destroyed;
  self.start_breaking_clock = 1;
  foreach(var_2, var_1 in self.array_of_clocks) {
    var_1.object_num = var_2 + 1;
    thread watch_for_damage_on_clock(var_1);
  }

  thread watch_for_final_quest_end();
  thread reset_clocks_on_failure(self);
}

watch_for_rewind_triggered_on_completion() {
  self endon("disconnect");
  self endon("death");
  self endon("ended_on_successful_teleport");
  for(;;) {
    if(!scripts\engine\utility::istrue(self.isrewinding) || !isDefined(self.rewindmover)) {
      scripts\engine\utility::waitframe();
      continue;
    } else {
      var_0 = getclosestpointonnavmesh(self.origin);
      scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
      thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.05);
      thread play_fx_rewind(0.05);
      self setscriptablepartstate("scripted_rewind", "inactive");
      self setscriptablepartstate("clockFx", "inactive");
      self dontinterpolate();
      self setorigin(var_0, 1);
      self setvelocity((0, 0, 0));
      self setstance("stand");
      if(!scripts\engine\utility::isweaponswitchallowed()) {
        scripts\engine\utility::allow_weapon_switch(1);
      }

      if(!scripts\engine\utility::isusabilityallowed()) {
        scripts\engine\utility::allow_usability(1);
      }

      if(!scripts\cp\utility::isteleportenabled()) {
        scripts\cp\utility::allow_player_teleport(1);
      }

      scripts\cp\utility::removedamagemodifier("rewind_invulnerability", 0);
      self playanimscriptevent("power_exit", "rewind");
      self playershow();
      self setphasestatus(0);
      scripts\engine\utility::allow_melee(1);
      scripts\engine\utility::allow_weapon(1);
      scripts\engine\utility::allow_jump(1);
      self allowprone(1);
      self limitedmovement(0);
      self unlink();
      if(isDefined(self.rewindmover)) {
        self.rewindmover delete();
      }

      if(scripts\engine\utility::istrue(self.isrewinding)) {
        self.isrewinding = 0;
      }

      self notify("ended_on_successful_teleport");
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

watch_for_final_quest_end() {
  self endon("backstory_quest_complete");
  self endon("disconnect");
  for(;;) {
    if(self.clocks_destroyed == 3) {
      if(isDefined(self.rewindmover) || scripts\engine\utility::istrue(self.isrewinding)) {
        thread watch_for_rewind_triggered_on_completion();
      }

      foreach(var_1 in level.players) {
        var_1.start_breaking_clock = 0;
        var_1.clocks_destroyed = 0;
        if(!isDefined(var_1.array_of_clocks)) {
          var_1.array_of_clocks = level.clocks_to_be_destroyed;
        }

        foreach(var_3 in var_1.array_of_clocks) {
          var_3.health = 5;
          var_3.damage_done = 0;
          var_3.maxhealth = 5;
          var_3 showtoplayer(self);
          var_3.already_attacked_by_player = 0;
        }
      }

      switch (self.vo_prefix) {
        case "p1_":
          thread scripts\cp\cp_vo::try_to_play_vo("ww_bio_all_sally", "rave_ww_vo", "highest", 70, 0, 0, 1);
          self setplayerdata("cp", "alienSession", "escapedRank0", 1);
          break;

        case "p2_":
          thread scripts\cp\cp_vo::try_to_play_vo("ww_bio_all_poindexter", "rave_ww_vo", "highest", 70, 0, 0, 1);
          self setplayerdata("cp", "alienSession", "escapedRank1", 1);
          break;

        case "p3_":
          thread scripts\cp\cp_vo::try_to_play_vo("ww_bio_all_andre", "rave_ww_vo", "highest", 70, 0, 0, 1);
          self setplayerdata("cp", "alienSession", "escapedRank2", 1);
          break;

        case "p4_":
          thread scripts\cp\cp_vo::try_to_play_vo("ww_bio_all_aj", "rave_ww_vo", "highest", 70, 0, 0, 1);
          self setplayerdata("cp", "alienSession", "escapedRank3", 1);
          break;

        default:
          level thread scripts\cp\cp_vo::try_to_play_vo("ww_bio_all", "rave_announcer_vo", "highest", 70, 0, 0, 1);
          break;
      }

      level thread dont_play_powerup_vo_for_delay(30);
      self.start_breaking_clock = 0;
      self setscriptablepartstate("scripted_rewind", "inactive");
      self setscriptablepartstate("clockFx", "inactive");
      if(!isDefined(level.magic_weapons["nunchucks"])) {
        level.magic_weapons["nunchucks"] = "iw7_nunchucks_zm";
      }

      self.finished_backstory = 1;
      spawn_power_up(self, "fire_30");
      self notify("backstory_quest_complete");
    }

    wait(1);
  }
}

spawn_power_up(var_0, var_1) {
  var_2 = var_0.origin;
  var_3 = (0, 0, 0);
  var_4 = self getplayerangles();
  var_5 = 7;
  var_2 = var_2 + var_3[0] * anglestoright(var_4);
  var_2 = var_2 + var_3[1] * anglesToForward(var_4);
  var_2 = var_2 + var_3[2] * anglestoup(var_4);
  var_6 = rotatepointaroundvector(anglestoup(var_4), anglesToForward(var_4), var_5);
  var_7 = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_vehicleclip", "physicscontents_item", "physicscontents_detail", "physicscontents_vehicleclip", "physicscontents_vehicle", "physicscontents_canshootclip", "physicscontents_missileclip", "physicscontents_clipshot"]);
  var_8 = scripts\common\trace::ray_trace(var_0 getEye(), var_2 + var_6, self, var_7);
  var_2 = scripts\engine\utility::drop_to_ground(var_8["position"] + var_6 * -18, 32, -2000);
  if(!scripts\cp\cp_weapon::isinvalidzone(var_2, level.invalid_spawn_volume_array, undefined, undefined, 1)) {
    var_2 = getclosestpointonnavmesh(var_0.origin);
  }

  level scripts\cp\loot::drop_loot(var_2, var_0, var_1);
}

start_rewind_sequence() {
  self setscriptablepartstate("clockFx", "active");
  level thread player_clock_tick_sfx(self);
  resetrecordedlocations();
  self.rewindangles[self.rewindpositionstartindex] = self getplayerangles();
  self.rewindorigins[self.rewindpositionstartindex] = self.origin;
  self.rewindvelocities[self.rewindpositionstartindex] = self getvelocity();
  var_0 = gettime();
  thread recordrewindlocations(4);
  runrewind(4);
}

watch_for_damage_on_clock(var_0) {
  self endon("backstory_quest_complete");
  self endon("end_this_thread");
  self endon("disconnect");
  self endon("death");
  self endon("last_stand");
  for(;;) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(!isplayer(var_2) && !isagent(var_2)) {
      var_0.health = var_0.maxhealth;
      continue;
    }

    if(scripts\engine\utility::istrue(var_0.already_attacked_by_player)) {
      var_0.health = var_0.maxhealth;
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.finished_backstory)) {
      continue;
    }

    if(var_2 != self) {
      continue;
    }

    if(scripts\engine\utility::istrue(var_2.kung_fu_mode)) {
      continue;
    }

    if(isDefined(var_5) && var_5 != "MOD_MELEE") {
      var_0.health = var_0.maxhealth;
      continue;
    }

    if(var_1 >= var_0.health) {
      var_2.clocks_destroyed++;
      var_0.already_attacked_by_player = 1;
      if(var_2.clocks_destroyed == 1) {
        var_2 thread start_rewind_sequence();
      }

      var_0 playfx_and_shatter_clock(var_2);
      continue;
    }

    var_0.health = var_0.maxhealth;
    continue;
  }
}

playfx_and_shatter_clock(var_0) {
  self endon("death");
  level endon("game_ended");
  playFX(level._effect["crafting_pickup"], self.origin);
  var_0 playlocalsound("disco_backstory_clock_smash");
  if(self.health < 0) {
    self.health = 5;
  }

  if(isDefined(var_0.clocks_destroyed) && var_0.clocks_destroyed == 3) {
    self hidefromplayer(var_0);
    var_0 notify("end_this_thread");
  }
}

reset_clocks_on_failure(var_0) {
  level endon("game_ended");
  var_0 endon("death");
  var_0 notify("ended_on_successful_teleport");
  for(;;) {
    scripts\engine\utility::waittill_any_3("rewind_power_finished", "remove_rewind_ability", "rewind_activated", "rat_king_fight_started", "last_stand");
    if(var_0.clocks_destroyed != 3) {
      foreach(var_2 in var_0.array_of_clocks) {
        var_2.health = 5;
        var_2.damage_done = 0;
        var_2.maxhealth = 5;
        var_2 showtoplayer(var_0);
        var_2.already_attacked_by_player = 0;
      }

      var_0.start_breaking_clock = 0;
      var_0.clocks_destroyed = 0;
      var_0 setscriptablepartstate("scripted_rewind", "inactive");
      var_0 setscriptablepartstate("clockFx", "inactive");
      var_0 notify("stop_clock_sfx");
      var_0 notify("clocks_reset");
    }
  }
}

hint_memory_tv(var_0, var_1) {
  return &"CP_DISCO_INTERACTIONS_PHONEBOOTH_USE";
}

init_memory_tv() {
  foreach(var_1 in level.players) {
    while(!isDefined(var_1.vo_prefix)) {
      wait(1);
    }
  }

  level.tv_channels_models = ["cp_disco_tv_crt", "cp_disco_tv_sally", "cp_disco_tv_pointd", "cp_disco_tv_andre", "cp_disco_tv_aj", "cp_disco_tv_yeti"];
  level.tv_modelsarray = [];
  level.tv_modelsarray = scripts\engine\utility::getstructarray("tv_model", "script_noteworthy");
  level.tv_array = [];
  level.tv_array = scripts\engine\utility::getstructarray("memory_tv", "script_noteworthy");
  if(level.tv_array.size <= 0) {
    return;
  }

  foreach(var_6, var_4 in level.tv_modelsarray) {
    var_5 = undefined;
    switch (var_4.name) {
      case "tv_sally":
        var_5 = spawn("script_model", var_4.origin);
        var_5 setModel("cp_disco_tv_crt_01_off");
        var_5.angles = var_4.angles;
        var_4.model = var_5;
        var_4.triggerportableradarping = "p1_";
        break;

      case "tv_pointd":
        var_5 = spawn("script_model", var_4.origin);
        var_5 setModel("cp_disco_tv_crt_01_off");
        var_5.angles = var_4.angles;
        var_4.model = var_5;
        var_4.triggerportableradarping = "p2_";
        break;

      case "tv_andre":
        var_5 = spawn("script_model", var_4.origin);
        var_5 setModel("cp_disco_tv_crt_01_off");
        var_5.angles = var_4.angles;
        var_4.model = var_5;
        var_4.triggerportableradarping = "p3_";
        break;

      case "tv_aj":
        var_5 = spawn("script_model", var_4.origin);
        var_5 setModel("cp_disco_tv_crt_01_off");
        var_5.angles = var_4.angles;
        var_4.model = var_5;
        var_4.triggerportableradarping = "p4_";
        break;

      default:
        break;
    }

    level.tv_modelsarray[var_6] = var_4;
  }

  var_7 = getEntArray("clock_model", "targetname");
  foreach(var_6, var_9 in var_7) {
    switch (var_9.script_noteworthy) {
      case "clock_3":
      case "clock_2":
      case "clock":
        var_9.maxhealth = 5;
        var_9.health = 5;
        var_9.damage_done = 0;
        var_9 setCanDamage(1);
        break;

      default:
        break;
    }

    level.clocks_to_be_destroyed[var_6] = var_9;
  }

  foreach(var_4 in level.tv_array) {
    switch (var_4.name) {
      case "tv_p1":
        var_4.number_of_tv_interactions = 4;
        var_4.times_interacted = 0;
        var_4.owner_prefix = "p1_";
        break;

      case "tv_p2":
        var_4.number_of_tv_interactions = 4;
        var_4.times_interacted = 0;
        var_4.owner_prefix = "p2_";
        break;

      case "tv_p3":
        var_4.number_of_tv_interactions = 4;
        var_4.times_interacted = 0;
        var_4.owner_prefix = "p3_";
        break;

      case "tv_p4":
        var_4.number_of_tv_interactions = 4;
        var_4.times_interacted = 0;
        var_4.owner_prefix = "p4_";
        break;

      default:
        break;
    }

    foreach(var_1 in level.players) {
      if(var_1.vo_prefix == var_4.owner_prefix) {
        if(!isDefined(var_1.tv_interaction)) {
          var_1.tv_interaction = var_4;
        }
      }
    }
  }
}

watch_for_quest_progress(var_0) {
  level endon("game_ended");
  self endon("tv_quest_complete");
  self endon("disconnect");
  if(scripts\engine\utility::istrue(self.finished_final_part)) {
    return;
  }

  for(;;) {
    if(scripts\engine\utility::istrue(self.finished_final_part)) {
      self.tv_interaction.times_interacted = 0;
      self.interacted_with_set = undefined;
      thread final_part_rewind_quest();
      wait(5);
      self notify("tv_quest_complete");
    }

    wait(1);
  }
}

use_memory_tv_object(var_0, var_1) {
  level endon("game_ended");
  var_1 endon("tv_quest_complete");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_1 endon("death");
  if(var_1.vo_prefix == "p5_") {
    playsoundatpos(var_0.origin, "ww_magicbox_laughter");
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  var_2 = 666;
  var_3 = " ";
  if(var_1.vo_prefix == "p5_") {
    playsoundatpos(var_0.origin, "ww_magicbox_laughter");
    return;
  }

  if(!isDefined(var_1.tv_interaction)) {
    foreach(var_5 in level.tv_array) {
      if(var_5.owner_prefix == var_1.vo_prefix) {
        var_1.tv_interaction = var_5;
      }
    }
  }

  if(!isDefined(var_1.tv_model)) {
    foreach(var_8 in level.tv_modelsarray) {
      if(var_8.triggerportableradarping == var_1.vo_prefix) {
        var_1.tv_model = var_8;
      }
    }
  }

  if((scripts\engine\utility::istrue(var_1.finished_part_one) && scripts\engine\utility::istrue(var_1.finished_part_two) && scripts\engine\utility::istrue(var_1.finished_part_three)) || getdvar("scr_tv_quest") != "") {
    if(!isDefined(var_1.vo_prefix)) {
      return;
    }

    if(scripts\engine\utility::istrue(var_1.finished_backstory)) {
      return;
    }

    if(scripts\engine\utility::istrue(var_1.interacted_with_set)) {
      return;
    }

    if(var_1.tv_interaction.name != var_0.name) {
      playsoundatpos(var_0.origin, "ww_magicbox_laughter");
      return;
    }

    var_0A = randomint(6);
    switch (var_0A) {
      case 0:
        var_2 = 0;
        var_3 = "yeti";
        var_1.tv_model.model setModel("cp_disco_tv_yeti");
        playsoundatpos(var_0.origin, "ww_magicbox_laughter");
        level thread delay_tv_interaction(var_0, 3, var_1);
        break;

      case 1:
        var_2 = 1;
        var_3 = "p1_";
        var_1.tv_model.model setModel("cp_disco_tv_sally");
        break;

      case 2:
        var_2 = 2;
        var_3 = "p2_";
        var_1.tv_model.model setModel("cp_disco_tv_pointdexter");
        break;

      case 3:
        var_2 = 3;
        var_3 = "p3_";
        var_1.tv_model.model setModel("cp_disco_tv_andre");
        break;

      case 4:
        var_2 = 4;
        var_3 = "p4_";
        var_1.tv_model.model setModel("cp_disco_tv_aj");
        break;

      default:
        var_2 = 5;
        var_3 = "crt";
        var_1.tv_model.model setModel("cp_disco_tv_crt");
        var_1 playlocalsound("disco_backstory_tv_channel");
        level thread delay_tv_interaction(var_0, 3, var_1);
        break;
    }

    var_1 playlocalsound("disco_backstory_tv_channel");
    if(var_3 == var_1.vo_prefix) {
      var_1 thread watch_for_quest_progress(var_0);
      var_1.interacted_with_set = 1;
      wait(1);
      var_1 thread start_fake_spawn_sequence(var_1);
      level thread delay_tv_interaction(var_0, 60, var_1);
      return;
    }

    level thread delay_tv_interaction(var_0, 3, var_1);
    return;
  }
}

delay_tv_interaction(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_2);
  level scripts\engine\utility::waittill_any_timeout_1(var_1, "tv_quest_complete");
  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_2);
}

watch_for_tries() {
  self endon("tv_quest_complete");
  level endon("game_ended");
  self endon("disconnect");
  if(self.tv_interaction.times_interacted == self.tv_interaction.number_of_tv_interactions) {
    thread start_fake_spawn_sequence(self);
    return;
  }

  self.interacted_with_set = undefined;
}

choose_number_of_karatemasters() {
  var_0 = 1;
  if(isDefined(level.players.size) && level.players.size > 0) {
    switch (level.players.size) {
      case 1:
        var_0 = 4;
        break;

      case 4:
      case 3:
      case 2:
        var_0 = 8;
        break;

      default:
        var_0 = 4;
        break;
    }

    return var_0;
  }
}

start_fake_spawn_sequence(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  var_1 = choose_number_of_karatemasters();
  var_2 = var_1;
  level.skeletons_alive = var_2;
  var_3 = 0;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = undefined;
  var_7 = undefined;
  if(scripts\cp\zombies\zombies_spawning::num_zombies_available_to_spawn() < var_2) {
    var_4 = level.current_enemy_deaths;
    var_5 = level.max_static_spawned_enemies;
    var_6 = level.desired_enemy_deaths_this_wave;
    var_7 = level.wave_num;
    while(level.current_enemy_deaths == level.desired_enemy_deaths_this_wave) {
      wait(0.05);
    }

    level.current_enemy_deaths = 0;
    level.desired_enemy_deaths_this_wave = 24;
    level.special_event = 1;
    var_3 = 1;
  }

  var_8 = getrandomnavpoints(self.tv_interaction.origin, 128, var_2);
  scripts\cp\zombies\zombies_spawning::increase_reserved_spawn_slots(var_2);
  wait(2);
  var_9 = skeleton_spawner(var_8, var_0);
  while(level.skeletons_alive > 0) {
    wait(0.1);
  }

  var_0.finished_final_part = 1;
  var_0.tv_model.model setModel("cp_disco_tv_crt");
  if(var_3) {
    level.spawndelayoverride = undefined;
    level.wave_num_override = undefined;
    level.special_event = undefined;
    level.zombies_paused = 0;
    if(level.wave_num == var_7) {
      level.current_enemy_deaths = var_4;
      level.max_static_spawned_enemies = var_5;
      level.desired_enemy_deaths_this_wave = var_6;
    } else {
      level.current_enemy_deaths = 0;
      level.max_static_spawned_enemies = scripts\cp\zombies\zombies_spawning::get_max_static_enemies(level.wave_num);
      level.desired_enemy_deaths_this_wave = scripts\cp\zombies\zombies_spawning::get_total_spawned_enemies(level.wave_num);
    }
  }

  scripts\cp\zombies\zombies_spawning::decrease_reserved_spawn_slots(var_2);
  return 1;
}

determine_best_shovel_spawns(var_0, var_1) {
  var_2 = [];
  var_3 = scripts\engine\utility::getstructarray("camper_to_lake_spawner", "targetname");
  var_3 = sortbydistance(var_3, var_0);
  for(var_4 = 0; var_4 < var_1; var_4++) {
    var_2[var_4] = var_3[var_4];
  }

  var_5 = scripts\engine\utility::array_randomize(var_2);
  return var_2;
}

get_rand_point(var_0) {
  while(![[level.active_volume_check]](var_0)) {
    var_0 = getrandomnavpoint(var_0, 128);
    scripts\engine\utility::waitframe();
  }

  return var_0;
}

skeleton_spawner(var_0, var_1) {
  var_1 endon("disconnect");
  var_2 = [];
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_0[var_3] = get_rand_point(var_0[var_3]);
    var_4 = spawn_skeleton_solo(var_0[var_3]);
    if(isDefined(var_4)) {
      var_4 thread skeleton_death_watcher(var_1);
      var_2[var_2.size] = var_4;
      var_4 thread set_skeleton_attributes();
      if(!isDefined(var_1.skeletons)) {
        var_1.skeletons = [];
      }

      var_1.skeletons[var_1.skeletons.size] = var_4;
      wait(1);
      continue;
    }

    level.skeletons_alive--;
  }

  return var_2;
}

skeleton_death_watcher(var_0) {
  level endon("game_ended");
  var_0 endon("disconnect");
  self waittill("death");
  level.skeletons_alive--;
  if(level.skeletons_alive <= 0) {
    var_0.finished_final_part = 1;
  }
}

spawn_skeleton_solo(var_0) {
  var_0 = scripts\engine\utility::drop_to_ground(var_0, 30, -100);
  var_1 = spawnStruct();
  var_1.origin = var_0;
  var_1.script_parameters = "ground_spawn_no_boards";
  var_1.script_animation = "spawn_ground";
  var_2 = 4;
  var_3 = 0.3;
  for(var_4 = 0; var_4 < var_2; var_4++) {
    var_5 = var_1 scripts\cp\zombies\zombies_spawning::spawn_wave_enemy("karatemaster", 1, var_1, var_0);
    if(isDefined(var_5)) {
      return var_5;
    }

    wait(var_3);
  }

  return undefined;
}

set_skeleton_attributes() {
  level endon("game_ended");
  self endon("death");
  self.dont_cleanup = 1;
  self.synctransients = "sprint";
  if(!scripts\engine\utility::istrue(self.aj_karatemaster)) {
    self.aj_karatemaster = 1;
  }

  self.health = scripts\cp\zombies\cp_disco_spawning::calculatezombiehealth("karatemaster");
  self.maxhealth = scripts\cp\zombies\cp_disco_spawning::calculatezombiehealth("karatemaster");
}

skeleton_arrival_cowbell(var_0) {
  var_1 = (0, 0, -11);
  var_2 = spawnfx(level._effect["superslasher_summon_zombie_portal"], var_0 + var_1, (0, 0, 1), (1, 0, 0));
  triggerfx(var_2);
  scripts\engine\utility::waittill_any_3("death", "intro_vignette_done");
  var_2 delete();
}

hint_nunchucks(var_0, var_1) {
  return "";
}

remove_influence_of_rewind_afterlife(var_0) {
  if(isDefined(var_0.rewindmover)) {
    var_0 setstance("stand");
    var_0.rewindmover solid();
    if(!var_0 scripts\engine\utility::isweaponswitchallowed()) {
      var_0 scripts\engine\utility::allow_weapon_switch(1);
    }

    if(!var_0 scripts\engine\utility::isusabilityallowed()) {
      var_0 scripts\engine\utility::allow_usability(1);
    }

    if(!var_0 scripts\cp\utility::isteleportenabled()) {
      var_0 scripts\cp\utility::allow_player_teleport(1);
    }

    var_0 scripts\cp\utility::removedamagemodifier("rewind_invulnerability", 0);
    var_0 playanimscriptevent("power_exit", "rewind");
    var_0 playershow();
    var_0 setphasestatus(0);
    var_0 scripts\engine\utility::allow_melee(1);
    var_0 scripts\engine\utility::allow_weapon(1);
    var_0 scripts\engine\utility::allow_jump(1);
    var_0 allowprone(1);
    var_0 limitedmovement(0);
    var_0 unlink();
    var_0.flung = undefined;
    var_0.rewindmover delete();
    var_0 setscriptablepartstate("scripted_rewind", "inactive");
    var_0 setscriptablepartstate("clockFx", "inactive");
    var_0 notify("rewind_power_finished");
    if(isDefined(var_0.clocks_destroyed)) {
      var_0.clocks_destroyed = 0;
    }

    var_0.isrewinding = 0;
  }
}

init_nunchucks() {
  level.rewind_afterlife_func = ::remove_influence_of_rewind_afterlife;
  if(!isDefined(level.clock)) {
    level.clock = [];
  }

  if(!isDefined(level.clock[0])) {
    level.clock[0] = undefined;
  }

  level.quest_one_objects = [];
  foreach(var_1 in scripts\engine\utility::getstructarray("clock", "script_noteworthy")) {
    level.clock[0] = var_1;
  }

  var_3 = scripts\engine\utility::getstructarray("mem", "targetname");
  foreach(var_2, var_1 in var_3) {
    var_5 = undefined;
    switch (var_1.script_noteworthy) {
      case "memory_object_one":
        var_5 = spawn("script_model", var_1.origin);
        var_5 setModel("p7_book_vintage_05");
        var_5.angles = var_1.angles;
        var_1.object_num = 1;
        break;

      case "memory_object_two":
        var_5 = spawn("script_model", var_1.origin);
        var_5 setModel("p7_book_vintage_05");
        var_5.angles = var_1.angles;
        var_1.object_num = 2;
        break;

      default:
        break;
    }

    var_5 setCanDamage(1);
    var_5.maxhealth = 5;
    var_5.health = 5;
    var_5.damage_done = 0;
    if(isDefined(var_5)) {
      var_1.model = var_5;
    }

    level.quest_one_objects[var_2] = var_1;
  }

  foreach(var_7 in level.players) {
    var_7.attacked_first_object = 0;
  }

  if(isDefined(level.clock_interaction)) {
    scripts\cp\cp_interaction::enable_linked_interactions(level.clock_interaction);
  }
}

watch_for_player_disconnect(var_0, var_1, var_2, var_3) {
  level endon("clock_tick_done_1");
  level endon("objects_reset");
  level endon(var_2);
  var_0 waittill("disconnect");
  foreach(var_5 in var_3) {
    var_5.health = 5;
    var_5.damage_done = 0;
    var_5.model showtoplayer(var_0);
    var_5.maxhealth = 5;
  }

  var_0 setscriptablepartstate("clockFx", "inactive");
  var_1.clock_owner = undefined;
  var_0.objects_array_sequence["part1"] = [];
  var_1.clock_active = 0;
  scripts\cp\cp_interaction::enable_linked_interactions(var_1);
  level notify("objects_reset");
}

use_nunchucks_object(var_0, var_1) {
  level endon("clock_tick_done_1");
  if(var_1.vo_prefix == "p5_") {
    playsoundatpos(var_0.origin, "ww_magicbox_laughter");
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  foreach(var_3 in level.players) {
    if(var_3 == var_1) {
      if(isDefined(level.clock_interaction_q2) && isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_3) {
        return;
      } else if(isDefined(level.clock_interaction_q3) && isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_3) {
        return;
      }

      continue;
    }

    if(isDefined(level.clock_interaction) && isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_3) {
      return;
    }
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.finished_part_one) && getdvar("scr_nunchucks") == "") {
    return;
  }

  var_1 setscriptablepartstate("clockFx", "active");
  level thread player_clock_tick_sfx(var_1);
  level thread watch_for_player_disconnect(var_1, var_0, "part_1_VO_done", level.quest_one_objects);
  level thread watch_for_player_laststand(var_1, var_0, "part_1_VO_done", level.quest_one_objects);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  level.clock_interaction = var_0;
  var_0.clock_owner = var_1;
  if(!isDefined(var_1.objects_array_sequence)) {
    var_1.objects_array_sequence = [];
  }

  if(!isDefined(var_1.objects_array_sequence["part1"])) {
    var_1.objects_array_sequence["part1"] = [];
  }

  var_0.clock_active = 1;
  var_1.angles_when_using_clock = var_1 getplayerangles();
  var_1 resetrecordedlocations();
  var_1.rewindpositionstartindex = 0;
  var_1.rewindangles[var_1.rewindpositionstartindex] = var_1 getplayerangles();
  var_1.rewindorigins[var_1.rewindpositionstartindex] = var_1.origin;
  var_1.rewindvelocities[var_1.rewindpositionstartindex] = var_1 getvelocity();
  var_5 = gettime();
  var_1 thread recordrewindlocations(1);
  var_1 thread watch_for_sequence_trigger(var_1, "1");
  var_1 thread clock_watcher(var_0, var_5, var_1, 1);
  var_1 runrewind(1);
  level thread delay_enable_linked_interaction(var_0, 30, var_1);
}

player_clock_tick_sfx(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_1 linkto(var_0);
  var_1 playLoopSound("quest_rewind_clock_tick_long");
  var_0 scripts\engine\utility::waittill_any_3("stop_clock_sfx", "objects_reset_q2", "objects_reset_q3", "part_1_VO_done", "part_2_VO_done", "part_3_VO_done", "backstory_quest_complete", "clocks_reset");
  var_1 stoploopsound();
  var_1 delete();
}

watch_for_player_laststand(var_0, var_1, var_2, var_3) {
  level endon("clock_tick_done_1");
  level endon("objects_reset");
  level endon(var_2);
  var_0 endon("disconnect");
  var_0 waittill("last_stand");
  foreach(var_5 in var_3) {
    var_5.model.health = 5;
    var_5.model.damage_done = 0;
    var_5.model.maxhealth = 5;
    var_5.model showtoplayer(var_0);
  }

  foreach(var_8 in level.players) {
    var_8.attacked_first_object = 0;
  }

  var_1.clock_owner = undefined;
  var_0 notify("stop_clock_sfx");
  var_0.objects_array_sequence["part1"] = [];
  var_0 setscriptablepartstate("clockFx", "inactive");
  var_0 setscriptablepartstate("scripted_rewind", "inactive");
  var_1.clock_active = 0;
  scripts\cp\cp_interaction::enable_linked_interactions(var_1);
  level notify("objects_reset");
}

clock_watcher(var_0, var_1, var_2, var_3) {
  var_2 endon("disconnect");
  var_2 endon("death");
  level endon("game_ended");
  var_4 = 0;
  if(isDefined(var_3)) {
    switch (var_3) {
      case 1:
        var_4 = 14;
        break;

      case 2:
        var_4 = 15.45;
        break;

      case 3:
        var_4 = 16.25;
        break;
    }
  }

  while(gettime() <= var_1 + var_4 * 1000) {
    scripts\engine\utility::waitframe();
  }

  var_0.clock_active = 0;
  var_0.clock_owner = undefined;
  var_2 notify("stop_clock_sfx");
  level notify("clock_tick_done_" + var_3);
  var_2 setscriptablepartstate("scripted_rewind", "inactive");
  var_2 setscriptablepartstate("clockFx", "inactive");
  level thread delay_enable_linked_interaction(var_0, 30, var_2);
}

delay_enable_linked_interaction(var_0, var_1, var_2) {
  var_2 endon("disconnect");
  level waittill("spawn_wave_done");
  scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_0, var_2);
}

watch_for_sequence_trigger(var_0, var_1) {
  var_0 endon("part_" + var_1 + "_VO_done");
  var_0 endon("disconnect");
  var_0 endon("death");
  level endon("game_ended");
  level endon("objects_reset");
  var_0 endon("objects_reset_q" + var_1);
  var_0 notify("ending_thread_for_" + var_0.name + " running quest " + var_1);
  var_0 endon("ending_thread_for_" + var_0.name + " running quest " + var_1);
  var_2 = [];
  var_3 = 0;
  var_4 = "part";
  var_5 = undefined;
  if(isDefined(var_1)) {
    switch (var_1) {
      case "1":
        var_2 = level.quest_one_objects;
        var_3 = 2;
        var_4 = "part1";
        var_5 = ::watch_for_damage_on_struct;
        break;

      case "2":
        var_2 = var_0.quest_two_objects;
        var_3 = 2;
        var_6 = scripts\engine\utility::getstructarray("memory_object_three", "script_noteworthy");
        foreach(var_8 in var_6) {
          var_0.quest_active_q2 = 1;
          var_0 scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_8, var_0);
        }

        var_6 = scripts\engine\utility::getstructarray("memory_object_four", "script_noteworthy");
        foreach(var_8 in var_6) {
          var_0.quest_active_q2 = 1;
          var_0 scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_8, var_0);
        }

        var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
        var_4 = "quest_2";
        break;

      case "3":
        var_2 = var_0.quest_three_objects;
        var_3 = 2;
        var_6 = scripts\engine\utility::getstructarray("memory_object_five", "script_noteworthy");
        foreach(var_8 in var_6) {
          var_0.quest_active_q3 = 1;
          var_0 scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_8, var_0);
        }

        var_6 = scripts\engine\utility::getstructarray("memory_object_six", "script_noteworthy");
        foreach(var_8 in var_6) {
          var_0.quest_active_q3 = 1;
          var_0 scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_8, var_0);
        }

        var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
        var_4 = "quest_3";
        break;
    }
  }

  if(isDefined(var_5)) {
    foreach(var_8 in var_2) {
      var_8 thread[[var_5]](var_0);
    }
  }

  for(;;) {
    if(var_0.objects_array_sequence[var_4].size == var_3) {
      var_0 setscriptablepartstate("scripted_rewind", "inactive");
      var_0 setscriptablepartstate("clockFx", "inactive");
      level thread play_character_bio(int(var_1), var_0);
      var_0 thread reset_rewind_mover(var_1);
      switch (var_1) {
        case "1":
          foreach(var_13 in level.players) {
            var_13.attacked_first_object = 0;
          }

          var_0.finished_part_one = 1;
          level.clock_interaction.clock_owner = undefined;
          var_0 notify("part_" + var_1 + "_VO_done");
          break;

        case "2":
          foreach(var_13 in level.players) {
            var_13.attacked_first_object_q2 = 0;
          }

          var_0.finished_part_two = 1;
          var_0.quest_active_q2 = 0;
          level.clock_interaction_q2.clock_owner = undefined;
          var_0 notify("part_" + var_1 + "_VO_done");
          break;

        case "3":
          foreach(var_13 in level.players) {
            var_13.attacked_first_object_q3 = 0;
          }

          var_0.finished_part_three = 1;
          var_0.quest_active_q3 = 0;
          level.clock_interaction_q3.clock_owner = undefined;
          var_0 notify("part_" + var_1 + "_VO_done");
          break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}

play_char_bio_vo_after_delay(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  wait(var_2 + 10);
  switch (var_0) {
    case 1:
      if(var_1.vo_prefix == "p1_") {
        if(!isDefined(level.completed_dialogues["sally_willard_bio_1_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("sally_willard_bio_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["sally_willard_bio_1_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p2_") {
        if(!isDefined(level.completed_dialogues["pdex_willard_bio_1_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("pdex_willard_bio_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["pdex_willard_bio_1_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p3_") {
        if(!isDefined(level.completed_dialogues["andre_willard_bio_1_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("andre_willard_bio_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["andre_willard_bio_1_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p4_") {
        if(!isDefined(level.completed_dialogues["aj_willard_bio_1_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("aj_willard_bio_1_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["aj_willard_bio_1_1"] = 1;
        }
      }
      break;

    case 2:
      if(var_1.vo_prefix == "p1_") {
        if(!isDefined(level.completed_dialogues["sally_willard_bio_2_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("sally_willard_bio_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["sally_willard_bio_2_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p2_") {
        if(!isDefined(level.completed_dialogues["pdex_willard_bio_2_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("pdex_willard_bio_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["pdex_willard_bio_2_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p3_") {
        if(!isDefined(level.completed_dialogues["andre_willard_bio_2_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("andre_willard_bio_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["andre_willard_bio_2_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p4_") {
        if(!isDefined(level.completed_dialogues["aj_willard_bio_2_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("aj_willard_bio_2_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["aj_willard_bio_2_1"] = 1;
        }
      }
      break;

    case 3:
      if(var_1.vo_prefix == "p1_") {
        if(!isDefined(level.completed_dialogues["sally_willard_bio_3_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("sally_willard_bio_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["sally_willard_bio_3_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p2_") {
        if(!isDefined(level.completed_dialogues["pdex_willard_bio_3_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("pdex_willard_bio_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["pdex_willard_bio_3_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p3_") {
        if(!isDefined(level.completed_dialogues["andre_willard_bio_3_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("andre_willard_bio_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["andre_willard_bio_3_1"] = 1;
        }
      }

      if(var_1.vo_prefix == "p4_") {
        if(!isDefined(level.completed_dialogues["aj_willard_bio_3_1"])) {
          var_1 thread scripts\cp\cp_vo::try_to_play_vo("aj_willard_bio_3_1", "rave_dialogue_vo", "highest", 666, 0, 0, 0, 100);
          level.completed_dialogues["aj_willard_bio_3_1"] = 1;
        }
      }
      break;
  }
}

play_character_bio(var_0, var_1) {
  var_1 endon("disconnect");
  wait(3);
  var_2 = 60;
  var_3 = " ";
  switch (var_0) {
    case 1:
      if(var_1.vo_prefix == "p1_") {
        var_3 = "ww_bio_sally_1";
      }

      if(var_1.vo_prefix == "p2_") {
        var_3 = "ww_bio_pdex_1";
      }

      if(var_1.vo_prefix == "p3_") {
        var_3 = "ww_bio_andre_1";
      }

      if(var_1.vo_prefix == "p4_") {
        var_3 = "ww_bio_aj_1";
      }
      break;

    case 2:
      if(var_1.vo_prefix == "p1_") {
        var_3 = "ww_bio_sally_2";
      }

      if(var_1.vo_prefix == "p2_") {
        var_3 = "ww_bio_pdex_2";
      }

      if(var_1.vo_prefix == "p3_") {
        var_3 = "ww_bio_andre_2";
      }

      if(var_1.vo_prefix == "p4_") {
        var_3 = "ww_bio_aj_2";
      }
      break;

    case 3:
      if(var_1.vo_prefix == "p1_") {
        var_3 = "ww_bio_sally_3";
      }

      if(var_1.vo_prefix == "p2_") {
        var_3 = "ww_bio_pdex_3";
      }

      if(var_1.vo_prefix == "p3_") {
        var_3 = "ww_bio_andre_3";
      }

      if(var_1.vo_prefix == "p4_") {
        var_3 = "ww_bio_aj_3";
      }
      break;
  }

  var_1 thread scripts\cp\cp_vo::try_to_play_vo(var_3, "rave_ww_vo", "highest", 30, 1, 0, 1, 100);
  var_2 = scripts\cp\cp_vo::get_sound_length(var_3);
  level thread dont_play_powerup_vo_for_delay(var_2);
  play_char_bio_vo_after_delay(var_0, var_1, var_2);
}

dont_play_powerup_vo_for_delay(var_0) {
  level.dont_play_powerup_vo = 1;
  wait(var_0);
  level.dont_play_powerup_vo = 0;
}

reset_rewind_mover(var_0) {
  if(scripts\engine\utility::istrue(self.finished_part_one) || scripts\engine\utility::istrue(self.finished_part_two) || scripts\engine\utility::istrue(self.finished_part_three)) {
    if(isDefined(self.rewindmover)) {
      var_0 = int(var_0);
      var_1 = level.clock[var_0 - 1].origin;
      var_2 = level.clock[var_0 - 1].angles;
      var_3 = (0, 0, 0);
      thread watch_for_rewind_triggered_on_completion();
    }

    return;
  }

  var_0 = int(var_0);
  var_1 = level.clock[var_0 - 1].origin;
  var_2 = level.clock[var_0 - 1].angles;
  var_3 = (0, 0, 0);
  if(isDefined(self.rewindmover) || scripts\engine\utility::istrue(self.isrewinding)) {
    thread watch_for_rewind_triggered_on_completion();
  }
}

reset_on_failure(var_0) {
  level endon("objects_reset");
  level endon("game_ended");
  self endon("death");
  var_0 endon("part_1_VO_done");
  var_0 endon("part_one_complete");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("last_stand");
  for(;;) {
    level waittill("clock_tick_done_1");
    if(var_0.objects_array_sequence["part1"].size != 2) {
      foreach(var_2 in level.quest_one_objects) {
        var_2.model.health = 5;
        var_2.model.damage_done = 0;
        var_2.model showtoplayer(var_0);
        var_2.model.maxhealth = 5;
      }

      foreach(var_5 in level.players) {
        var_5.attacked_first_object = 0;
      }

      level.clock_interaction.clock_owner = undefined;
      var_0.objects_array_sequence["part1"] = [];
      level.clock_interaction.clock_active = 0;
      var_0 setscriptablepartstate("scripted_rewind", "inactive");
      var_0 setscriptablepartstate("clockFx", "inactive");
      if(isDefined(var_0.rewindmover)) {
        var_0 thread reset_rewind_mover(1);
      }

      var_0.quest_num = undefined;
      level notify("objects_reset");
    }

    wait(1);
  }
}

watch_for_damage_on_struct(var_0) {
  var_0 endon("part_one_complete");
  level endon("objects_reset");
  var_0 endon("disconnect");
  var_0 endon("death");
  var_0 endon("last_stand");
  thread reset_on_failure(var_0);
  for(;;) {
    self.model waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(!isplayer(var_2) && !isagent(var_2)) {
      continue;
    }

    if(isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner != var_2) {
      continue;
    }

    if(isDefined(var_5) && var_5 != "MOD_MELEE") {
      continue;
    }

    if(self.object_num == 2 && var_2.objects_array_sequence["part1"].size == 0) {
      continue;
    } else if(!scripts\engine\utility::istrue(var_2.attacked_first_object) && self.object_num == 1 && var_2.objects_array_sequence["part1"].size == 0) {
      var_2.objects_array_sequence["part1"][self.object_num - 1] = self;
      self.model.damage_done = self.model.damage_done + var_1;
      var_2.attacked_first_object = 1;
      self.model hidefromplayer(var_2);
      var_2 playlocalsound("part_pickup");
    }

    if(self.object_num == 2 && scripts\engine\utility::istrue(var_2.attacked_first_object)) {
      var_2.objects_array_sequence["part1"][self.object_num - 1] = self;
      self.model.damage_done = self.model.damage_done + var_1;
      var_2.attacked_first_object = 1;
      self.model hidefromplayer(var_2);
      var_2 playlocalsound("part_pickup");
    }

    if(var_2.objects_array_sequence["part1"].size == 2) {
      foreach(var_0C in var_2.objects_array_sequence["part1"]) {
        var_0C playfx_and_shatter(var_2);
      }

      var_2 playlocalsound("zmb_ui_earn_tickets");
      var_0 notify("part_one_complete");
    }
  }
}

playfx_and_shatter(var_0) {
  self endon("death");
  level endon("game_ended");
  playFX(level._effect["crafting_pickup"], self.origin);
  var_0 playlocalsound("part_pickup");
  if(self.model.health < 0) {
    self.model.health = 5;
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(self, var_0);
    var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
  }
}

removememorystructonconnect(var_0) {
  level endon("game_ended");
  for(;;) {
    level waittill("connected", var_1);
    var_1 thread removememorystructswhenvalid(var_0, var_1);
  }
}

removememorystructswhenvalid(var_0, var_1) {
  while(!isDefined(var_1.disabled_interactions)) {
    scripts\engine\utility::waitframe();
  }

  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  var_1 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_1);
}

setup_backstory_models_hotjoined_player() {
  if(isDefined(level.quest_one_objects)) {
    var_0 = level.quest_one_objects;
    foreach(var_3, var_2 in var_0) {
      var_2.model showtoplayer(self);
      if(!isDefined(self.quest_one_objects)) {
        self.quest_one_objects = [];
      }

      self.quest_one_objects[var_3] = var_2;
    }
  }

  if(!isDefined(self.quest_two_objects)) {
    self.quest_two_objects = [];
  }

  if(!isDefined(self.quest_three_objects)) {
    self.quest_three_objects = [];
  }

  self.quest_two_objects = level.quest_two_objects;
  self.quest_three_objects = level.quest_three_objects;
}

setup_backstory_models(var_0, var_1) {
  if(!isDefined(level.quest_two_objects)) {
    level.quest_two_objects = [];
  }

  if(!isDefined(level.quest_three_objects)) {
    level.quest_three_objects = [];
  }

  scripts\cp\maps\cp_disco\cp_disco::addtopersonalinteractionlist(var_0);
  foreach(var_3 in level.players) {
    var_0.object_num = 1;
    switch (var_1) {
      case "memory_object_three":
        var_0.object_num = 1;
        var_3.attacked_first_object_q2 = 0;
        break;

      case "memory_object_four":
        var_0.object_num = 2;
        break;

      case "memory_object_five":
        var_0.object_num = 1;
        var_3.attacked_first_object_q3 = 0;
        break;

      case "memory_object_six":
        var_0.object_num = 2;
        break;

      default:
        break;
    }

    if(var_1 == "memory_object_three" || var_1 == "memory_object_four") {
      level.quest_two_objects[var_0.object_num - 1] = var_0;
    }

    if(var_1 == "memory_object_five" || var_1 == "memory_object_six") {
      level.quest_three_objects[var_0.object_num - 1] = var_0;
    }

    if(!isDefined(var_3.quest_two_objects)) {
      var_3.quest_two_objects = [];
    }

    if(!isDefined(var_3.quest_three_objects)) {
      var_3.quest_three_objects = [];
    }

    var_3.quest_two_objects[var_0.object_num - 1] = level.quest_two_objects[var_0.object_num - 1];
    var_3.quest_three_objects[var_0.object_num - 1] = level.quest_three_objects[var_0.object_num - 1];
    if(isDefined(level.quest_one_objects)) {
      var_3.quest_one_objects = level.quest_one_objects;
    }
  }
}

mem_object_hint(var_0, var_1) {
  return "";
}

mem_object_func(var_0, var_1) {}

getcurrentquestfromstruct(var_0, var_1) {
  if(!isDefined(var_0.script_noteworthy)) {
    return undefined;
  }

  switch (var_0.script_noteworthy) {
    case "memory_object_four":
    case "memory_object_three":
      return "quest_2";

    case "memory_object_six":
    case "memory_object_five":
      return "quest_3";

    default:
      return undefined;
  }

  return undefined;
}

activatememquestmodel(var_0, var_1, var_2) {
  level notify(var_0.script_noteworthy + "_" + var_1.name);
  level endon(var_0.script_noteworthy + "_" + var_1.name);
  level endon("game_ended");
  var_1 endon("disconnect");
  var_1 endon("last_stand");
  var_2 endon("p_ent_reset");
  if(!isDefined(var_0.model)) {
    return;
  }

  var_0.model.health = 5;
  var_0.model.maxhealth = 5;
  var_0.model setCanDamage(1);
  var_3 = getcurrentquestfromstruct(var_0, var_1);
  for(;;) {
    var_0.model waittill("damage", var_4, var_5, var_6, var_7, var_8, var_9, var_0A, var_0B, var_0C, var_0D);
    if(!isplayer(var_5)) {
      continue;
    }

    if(var_5 != var_1) {
      continue;
    }

    if(!isDefined(var_3)) {
      continue;
    }

    if(!var_5 scripts\cp\utility::is_valid_player()) {
      continue;
    }

    if(var_3 == "quest_2" && !scripts\engine\utility::istrue(var_1.quest_active_q2)) {
      continue;
    }

    if(var_3 == "quest_3" && !scripts\engine\utility::istrue(var_1.quest_active_q3)) {
      continue;
    }

    if(isDefined(var_8) && var_8 != "MOD_MELEE") {
      continue;
    }

    if(var_0.object_num == 2 && var_5.objects_array_sequence[var_3].size == 0) {
      continue;
    } else if(var_0.object_num == 1 && var_5.objects_array_sequence[var_3].size == 0) {
      if(var_3 == "quest_2" && !scripts\engine\utility::istrue(var_5.attacked_first_object_q2)) {
        var_5.objects_array_sequence[var_3][0] = var_0;
        var_0.model.damage_done = var_0.model.damage_done + var_4;
        var_5.attacked_first_object_q2 = 1;
        scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_5);
        var_5 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_5);
        var_5 playlocalsound("part_pickup");
      } else if(var_3 == "quest_3" && !scripts\engine\utility::istrue(var_5.attacked_first_object_q3)) {
        var_5.objects_array_sequence[var_3][0] = var_0;
        var_0.model.damage_done = var_0.model.damage_done + var_4;
        var_5.attacked_first_object_q3 = 1;
        scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_5);
        var_5 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_5);
        var_5 playlocalsound("part_pickup");
      }
    }

    if(var_0.object_num == 2) {
      if((var_3 == "quest_2" && scripts\engine\utility::istrue(var_5.attacked_first_object_q2)) || var_3 == "quest_3" && scripts\engine\utility::istrue(var_5.attacked_first_object_q3)) {
        var_5.objects_array_sequence[var_3][1] = var_0;
        var_0.model.damage_done = var_0.model.damage_done + var_4;
        scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_5);
        var_5 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_5);
        var_5 playlocalsound("part_pickup");
      }
    }

    if(var_5.objects_array_sequence[var_3].size == 2) {
      var_5 playlocalsound("zmb_ui_earn_tickets");
      if(var_3 == "quest_2") {
        var_5 notify("part_two_complete");
      } else if(var_3 == "quest_3") {
        var_5 notify("part_three_complete");
      }

      foreach(var_0F in var_5.objects_array_sequence[var_3]) {
        var_0F playfx_and_shatter(var_5);
      }
    }
  }
}

applymemquestattributes(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_3.vo_prefix)) {
    return;
  }

  if(!isDefined(var_1.script_noteworthy)) {
    return;
  }

  switch (var_1.script_noteworthy) {
    case "memory_object_three":
      if(var_3.vo_prefix == "p1_") {
        var_1.playeroffset[var_3.name] = (-2462.58, 4604.5, 782.219);
        if(scripts\engine\utility::istrue(var_3.quest_active_q2)) {
          var_0 setModel("cp_disco_memory_quest_newspaper");
        } else {
          var_0 setModel("cp_disco_memory_quest_newspaper_nophy");
        }

        var_0.origin = (-2462.58, 4604.5, 782.219);
        var_0.angles = (0, 180, 0);
      } else if(var_3.vo_prefix == "p2_") {
        var_1.playeroffset[var_3.name] = (-2462.58, 4604.5, 782.219);
        if(scripts\engine\utility::istrue(var_3.quest_active_q2)) {
          var_0 setModel("cp_disco_comic_book");
        } else {
          var_0 setModel("cp_disco_comic_book_nophy");
        }

        var_0.origin = (-2462.58, 4604.5, 782.219);
        var_0.angles = (0, 180, 0);
      } else if(var_3.vo_prefix == "p3_") {
        var_1.playeroffset[var_3.name] = (-2459.6, 4597.5, 783.2);
        if(scripts\engine\utility::istrue(var_3.quest_active_q2)) {
          var_0 setModel("cp_disco_microphone_quest");
        } else {
          var_0 setModel("cp_disco_microphone_nophy");
        }

        var_0.origin = (-2459.6, 4597.5, 783.2);
        var_0.angles = (85, 0, 0);
      } else if(var_3.vo_prefix == "p4_") {
        var_1.playeroffset[var_3.name] = (-2459.5, 4597.5, 782.1);
        if(scripts\engine\utility::istrue(var_3.quest_active_q2)) {
          var_0 setModel("cp_disco_trophy");
        } else {
          var_0 setModel("cp_disco_trophy_nophy");
        }

        var_0.origin = (-2459.5, 4597.5, 782.1);
        var_0.angles = (0, 0, 0);
      }
      break;

    case "memory_object_four":
      if(var_3.vo_prefix == "p1_") {
        var_1.playeroffset[var_3.name] = (-1215, 294.5, 956.5);
        if(scripts\engine\utility::istrue(var_3.quest_active_q2)) {
          var_0 setModel("cp_disco_memory_quest_newspaper");
        } else {
          var_0 setModel("cp_disco_memory_quest_newspaper_nophy");
        }

        var_0.origin = (-1215, 294.5, 956.5);
        var_0.angles = (0, 317.1, 0);
      } else if(var_3.vo_prefix == "p2_") {
        var_1.playeroffset[var_3.name] = (-1215, 294.5, 956.5);
        if(scripts\engine\utility::istrue(var_3.quest_active_q2)) {
          var_0 setModel("cp_disco_comic_book");
        } else {
          var_0 setModel("cp_disco_comic_book_nophy");
        }

        var_0.origin = (-1215, 294.5, 956.5);
        var_0.angles = (0, 317.1, 0);
      } else if(var_3.vo_prefix == "p3_") {
        var_1.playeroffset[var_3.name] = (-1215, 301.5, 957.5);
        if(scripts\engine\utility::istrue(var_3.quest_active_q2)) {
          var_0 setModel("cp_disco_microphone_quest");
        } else {
          var_0 setModel("cp_disco_microphone_nophy");
        }

        var_0.origin = (-1215, 301.5, 957.5);
        var_0.angles = (0, 0, -86.6);
      } else if(var_3.vo_prefix == "p4_") {
        var_1.playeroffset[var_3.name] = (-1215, 299.5, 956.5);
        if(scripts\engine\utility::istrue(var_3.quest_active_q2)) {
          var_0 setModel("cp_disco_trophy");
        } else {
          var_0 setModel("cp_disco_trophy_nophy");
        }

        var_0.origin = (-1215, 299.5, 956.5);
        var_0.angles = (0, 90, 0);
      }
      break;

    case "memory_object_six":
    case "memory_object_five":
      if(var_3.vo_prefix == "p1_") {
        if(scripts\engine\utility::istrue(var_3.quest_active_q3)) {
          var_0 setModel("cp_disco_movie_script_book_04");
        } else {
          var_0 setModel("cp_disco_movie_script_book_04_nophy");
        }
      } else if(var_3.vo_prefix == "p2_") {
        if(scripts\engine\utility::istrue(var_3.quest_active_q3)) {
          var_0 setModel("cp_disco_movie_script_book_02");
        } else {
          var_0 setModel("cp_disco_movie_script_book_02_nophy");
        }
      } else if(var_3.vo_prefix == "p3_") {
        if(scripts\engine\utility::istrue(var_3.quest_active_q3)) {
          var_0 setModel("cp_disco_movie_script_book_03");
        } else {
          var_0 setModel("cp_disco_movie_script_book_03_nophy");
        }
      } else if(var_3.vo_prefix == "p4_") {
        if(scripts\engine\utility::istrue(var_3.quest_active_q3)) {
          var_0 setModel("cp_disco_movie_script_book_01");
        } else {
          var_0 setModel("cp_disco_movie_script_book_01_nophy");
        }
      }
      break;
  }

  var_1.model = var_0;
  var_1.model.damage_done = 0;
  thread activatememquestmodel(var_1, var_3, var_0);
}

init_mem3() {
  level.special_mode_activation_funcs["memory_object_three"] = ::applymemquestattributes;
  level.normal_mode_activation_funcs["memory_object_three"] = ::applymemquestattributes;
  var_0 = scripts\engine\utility::getstructarray("memory_object_three", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_backstory_models(var_2, "memory_object_three");
  }
}

init_mem4() {
  level.special_mode_activation_funcs["memory_object_four"] = ::applymemquestattributes;
  level.normal_mode_activation_funcs["memory_object_four"] = ::applymemquestattributes;
  var_0 = scripts\engine\utility::getstructarray("memory_object_four", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_backstory_models(var_2, "memory_object_four");
  }
}

init_mem5() {
  level.special_mode_activation_funcs["memory_object_five"] = ::applymemquestattributes;
  level.normal_mode_activation_funcs["memory_object_five"] = ::applymemquestattributes;
  var_0 = scripts\engine\utility::getstructarray("memory_object_five", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_backstory_models(var_2, "memory_object_five");
  }
}

init_mem6() {
  level.special_mode_activation_funcs["memory_object_six"] = ::applymemquestattributes;
  level.normal_mode_activation_funcs["memory_object_six"] = ::applymemquestattributes;
  var_0 = scripts\engine\utility::getstructarray("memory_object_six", "script_noteworthy");
  foreach(var_2 in var_0) {
    var_2.groupname = "locOverride";
    var_2.playeroffset = [];
    setup_backstory_models(var_2, "memory_object_six");
  }
}

init_nunchucks_2() {
  level.quest_two_objects = [];
  if(!isDefined(level.clock[1])) {
    level.clock[1] = undefined;
  }

  foreach(var_1 in scripts\engine\utility::getstructarray("clock_2", "script_noteworthy")) {
    level.clock[1] = var_1;
  }

  foreach(var_4 in level.players) {
    var_4.attacked_first_object_q2 = 0;
  }

  if(isDefined(level.clock_interaction_q2)) {
    scripts\cp\cp_interaction::enable_linked_interactions(level.clock_interaction_q2);
  }
}

watch_for_player_disconnect_q2(var_0, var_1, var_2, var_3) {
  level endon("clock_tick_done_2");
  var_0 endon("objects_reset_q2");
  level endon(var_2);
  var_0 waittill("disconnect");
  foreach(var_5 in var_3) {
    if(isDefined(var_5.model)) {
      var_5.model.health = 5;
      var_5.model.damage_done = 0;
      var_5.model.maxhealth = 5;
    }

    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_5, var_0);
    var_0.quest_active_q2 = 0;
    var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
  }

  var_1.clock_owner = undefined;
  var_0.objects_array_sequence["quest_2"] = [];
  var_0 setscriptablepartstate("clockFx", "inactive");
  var_0 setscriptablepartstate("scripted_rewind", "inactive");
  var_1.clock_active = 0;
  scripts\cp\cp_interaction::enable_linked_interactions(var_1);
  var_0 notify("objects_reset_q2");
}

use_nunchucks_object_2(var_0, var_1) {
  level endon("clock_tick_done_2");
  if(var_1.vo_prefix == "p5_") {
    playsoundatpos(var_0.origin, "ww_magicbox_laughter");
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  foreach(var_3 in level.players) {
    if(var_3 == var_1) {
      if(isDefined(level.clock_interaction) && isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_3) {
        return;
      } else if(isDefined(level.clock_interaction_q3) && isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_3) {
        return;
      }

      continue;
    }

    if(isDefined(level.clock_interaction_q2) && isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_3) {
      return;
    }
  }

  if(scripts\engine\utility::istrue(var_1.finished_part_two) && getdvar("scr_nunchucks") == "") {
    return;
  }

  if(!isDefined(var_1.objects_array_sequence)) {
    var_1.objects_array_sequence = [];
  }

  if(!isDefined(var_1.objects_array_sequence["quest_2"])) {
    var_1.objects_array_sequence["quest_2"] = [];
  }

  var_1 setscriptablepartstate("clockFx", "active");
  level thread player_clock_tick_sfx(var_1);
  var_1 thread reset_on_failure_q2(var_1);
  level thread watch_for_player_disconnect_q2(var_1, var_0, "part_2_VO_done", var_1.quest_two_objects);
  level thread watch_for_player_laststand_q2(var_1, var_0, "part_2_VO_done", var_1.quest_two_objects);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  level.clock_interaction_q2 = var_0;
  var_0.clock_owner = var_1;
  var_0.clock_active = 1;
  var_1.angles_when_using_clock = var_1 getplayerangles();
  var_1 resetrecordedlocations();
  var_1.rewindpositionstartindex = 0;
  var_1.rewindangles[var_1.rewindpositionstartindex] = var_1 getplayerangles();
  var_1.rewindorigins[var_1.rewindpositionstartindex] = var_1.origin;
  var_1.rewindvelocities[var_1.rewindpositionstartindex] = var_1 getvelocity();
  var_5 = gettime();
  var_1 thread recordrewindlocations(2);
  var_1 thread watch_for_sequence_trigger(var_1, "2");
  var_1 thread clock_watcher(var_0, var_5, var_1, 2);
  var_1 runrewind(2);
  level thread delay_enable_linked_interaction(var_0, 30, var_1);
}

watch_for_player_laststand_q2(var_0, var_1, var_2, var_3) {
  level endon("clock_tick_done_2");
  var_0 endon("objects_reset_q2");
  level endon(var_2);
  var_0 endon("disconnect");
  var_0 waittill("last_stand");
  foreach(var_5 in var_3) {
    if(isDefined(var_5.model)) {
      var_5.model.health = 5;
      var_5.model.damage_done = 0;
      var_5.model.maxhealth = 5;
    }

    foreach(var_7 in level.players) {
      var_7.attacked_first_object_q2 = 0;
    }

    var_0.quest_active_q2 = 0;
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_5, var_0);
    var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
  }

  var_1.clock_owner = undefined;
  var_0.objects_array_sequence["quest_2"] = [];
  var_0 setscriptablepartstate("clockFx", "inactive");
  var_0 setscriptablepartstate("scripted_rewind", "inactive");
  var_1.clock_active = 0;
  scripts\cp\cp_interaction::enable_linked_interactions(var_1);
  var_0 notify("objects_reset_q2");
}

reset_on_failure_q2(var_0) {
  var_0 endon("part_2_VO_done");
  var_0 endon("objects_reset_q2");
  level endon("game_ended");
  self endon("death");
  var_0 endon("part_two_complete");
  var_0 notify("end_reset_thread_for_" + var_0.name + " for quest 2");
  var_0 endon("end_reset_thread_for_" + var_0.name + " for quest 2");
  for(;;) {
    level waittill("clock_tick_done_2");
    if(var_0.objects_array_sequence["quest_2"].size != 2) {
      foreach(var_2 in var_0.quest_two_objects) {
        if(isDefined(var_2.model)) {
          var_2.model.health = 5;
          var_2.model.damage_done = 0;
          var_2.model.maxhealth = 5;
        }

        var_0.quest_active_q2 = 0;
        scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_2, var_0);
        var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
      }

      foreach(var_5 in level.players) {
        var_5.attacked_first_object_q2 = 0;
      }

      level.clock_interaction_q2.clock_owner = undefined;
      var_0.objects_array_sequence["quest_2"] = [];
      var_0 setscriptablepartstate("clockFx", "inactive");
      var_0 setscriptablepartstate("scripted_rewind", "inactive");
      level.clock_interaction_q2.clock_active = 0;
      if(isDefined(var_0.rewindmover)) {
        var_0 thread reset_rewind_mover(2);
      }

      var_0.quest_num = undefined;
      var_0 notify("objects_reset_q2");
    }
  }
}

watch_for_damage_on_struct_q2(var_0) {
  var_0 endon("part_two_complete");
  var_0 endon("objects_reset_q2");
  var_0 endon("delete_previous_thread");
  for(;;) {
    self.model waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(!isplayer(var_2) && !isagent(var_2)) {
      continue;
    }

    if(isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner != var_2) {
      continue;
    }

    if(!scripts\engine\utility::istrue(var_2.quest_active)) {
      continue;
    }

    if(isDefined(var_5) && var_5 != "MOD_MELEE") {
      continue;
    }

    if(self.object_num == 2 && var_2.objects_array_sequence["quest_2"].size == 0) {
      continue;
    } else if(!scripts\engine\utility::istrue(var_2.attacked_first_object_q2) && self.object_num == 1 && var_2.objects_array_sequence["part2"].size == 0) {
      var_2.objects_array_sequence["quest_2"][self.object_num - 1] = self;
      self.model.damage_done = self.model.damage_done + var_1;
      var_2.attacked_first_object_q2 = 1;
      scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(self, var_2);
      var_2 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_2);
      var_2 playlocalsound("part_pickup");
    }

    if(self.object_num == 2 && scripts\engine\utility::istrue(var_2.attacked_first_object_q2)) {
      var_2.objects_array_sequence["quest_2"][self.object_num - 1] = self;
      self.model.damage_done = self.model.damage_done + var_1;
      scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(self, var_2);
      var_2 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_2);
      var_2 playlocalsound("part_pickup");
    }

    if(var_2.objects_array_sequence["quest_2"].size == 2) {
      foreach(var_0C in var_2.objects_array_sequence["quest_2"]) {
        var_0C playfx_and_shatter(var_2);
      }

      var_2 playlocalsound("zmb_ui_earn_tickets");
      var_2 notify("part_two_complete");
    }
  }
}

init_nunchucks_3() {
  level.quest_three_objects = [];
  if(!isDefined(level.clock[2])) {
    level.clock[2] = undefined;
  }

  foreach(var_1 in scripts\engine\utility::getstructarray("clock_3", "script_noteworthy")) {
    level.clock[2] = var_1;
  }

  foreach(var_4 in level.players) {
    var_4.attacked_first_object_q3 = 0;
  }

  if(isDefined(level.clock_interaction_q3)) {
    scripts\cp\cp_interaction::enable_linked_interactions(level.clock_interaction_q3);
  }
}

watch_for_player_disconnect_q3(var_0, var_1, var_2, var_3) {
  level endon("clock_tick_done_3");
  var_0 endon("objects_reset_q3");
  level endon(var_2);
  var_0 waittill("disconnect");
  foreach(var_5 in var_3) {
    if(isDefined(var_5.model)) {
      var_5.model.health = 5;
      var_5.model.damage_done = 0;
      var_5.model.maxhealth = 5;
    }

    var_0.quest_active_q3 = 0;
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_5, var_0);
    var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
  }

  var_1.clock_owner = undefined;
  var_0.objects_array_sequence["quest_3"] = [];
  var_0 setscriptablepartstate("clockFx", "inactive");
  var_0 setscriptablepartstate("scripted_rewind", "inactive");
  var_1.clock_active = 0;
  scripts\cp\cp_interaction::enable_linked_interactions(var_1);
  var_0 notify("objects_reset_q3");
}

use_nunchucks_object_3(var_0, var_1) {
  level endon("clock_tick_done_3");
  if(var_1.vo_prefix == "p5_") {
    playsoundatpos(var_0.origin, "ww_magicbox_laughter");
    return;
  }

  if(scripts\engine\utility::istrue(var_1.kung_fu_mode)) {
    return;
  }

  if(scripts\engine\utility::istrue(var_1.isrewinding)) {
    return;
  }

  foreach(var_3 in level.players) {
    if(var_3 == var_1) {
      if(isDefined(level.clock_interaction) && isDefined(level.clock_interaction.clock_owner) && level.clock_interaction.clock_owner == var_3) {
        return;
      } else if(isDefined(level.clock_interaction_q2) && isDefined(level.clock_interaction_q2.clock_owner) && level.clock_interaction_q2.clock_owner == var_3) {
        return;
      }

      continue;
    }

    if(isDefined(level.clock_interaction_q3) && isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner == var_3) {
      return;
    }
  }

  if(scripts\engine\utility::istrue(var_1.finished_part_three) && getdvar("scr_nunchucks") == "") {
    return;
  }

  if(!isDefined(var_1.objects_array_sequence)) {
    var_1.objects_array_sequence = [];
  }

  if(!isDefined(var_1.objects_array_sequence["quest_3"])) {
    var_1.objects_array_sequence["quest_3"] = [];
  }

  var_1 setscriptablepartstate("clockFx", "active");
  level thread player_clock_tick_sfx(var_1);
  var_1 thread reset_on_failure_q3(var_1);
  level thread watch_for_player_disconnect_q3(var_1, var_0, "part_3_VO_done", var_1.quest_three_objects);
  level thread watch_for_player_laststand_q3(var_1, var_0, "part_3_VO_done", var_1.quest_three_objects);
  scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  level.clock_interaction_q3 = var_0;
  var_0.clock_owner = var_1;
  var_0.clock_active = 1;
  var_1.angles_when_using_clock = var_1 getplayerangles();
  var_1 resetrecordedlocations();
  var_1.rewindpositionstartindex = 0;
  var_1.rewindangles[var_1.rewindpositionstartindex] = var_1 getplayerangles();
  var_1.rewindorigins[var_1.rewindpositionstartindex] = var_1.origin;
  var_1.rewindvelocities[var_1.rewindpositionstartindex] = var_1 getvelocity();
  var_5 = gettime();
  var_1 thread recordrewindlocations(3);
  var_1 thread watch_for_sequence_trigger(var_1, "3");
  var_1 thread clock_watcher(var_0, var_5, var_1, 3);
  var_1 runrewind(3);
  level thread delay_enable_linked_interaction(var_0, 30, var_1);
}

watch_for_player_laststand_q3(var_0, var_1, var_2, var_3) {
  level endon("clock_tick_done_3");
  var_0 endon("objects_reset_q3");
  level endon(var_2);
  var_0 endon("disconnect");
  var_0 waittill("last_stand");
  foreach(var_5 in var_3) {
    if(isDefined(var_5.model)) {
      var_5.model.health = 5;
      var_5.model.damage_done = 0;
      var_5.model.maxhealth = 5;
    }

    foreach(var_7 in level.players) {
      var_7.attacked_first_object_q3 = 0;
    }

    var_0.quest_active_q3 = 0;
    scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_5, var_0);
    var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
  }

  var_1.clock_owner = undefined;
  var_0.objects_array_sequence["quest_3"] = [];
  var_1.clock_active = 0;
  scripts\cp\cp_interaction::enable_linked_interactions(var_1);
  var_0 notify("objects_reset_q3");
}

reset_on_failure_q3(var_0) {
  var_0 endon("objects_reset_q3");
  level endon("game_ended");
  self endon("death");
  var_0 endon("part_3_VO_done");
  var_0 endon("part_three_complete");
  var_0 notify("end_reset_thread_for_" + var_0.name + " for quest 3");
  var_0 endon("end_reset_thread_for_" + var_0.name + " for quest 3");
  for(;;) {
    level waittill("clock_tick_done_3");
    if(var_0.objects_array_sequence["quest_3"].size != 2) {
      foreach(var_2 in var_0.quest_three_objects) {
        if(isDefined(var_2.model)) {
          var_2.model.health = 5;
          var_2.model.damage_done = 0;
          var_2.model.maxhealth = 5;
        }

        var_0.quest_active_q3 = 0;
        scripts\cp\cp_interaction::add_to_current_interaction_list_for_player(var_2, var_0);
        var_0 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_0);
      }

      foreach(var_5 in level.players) {
        var_5.attacked_first_object_q3 = 0;
      }

      level.clock_interaction_q3.clock_owner = undefined;
      var_0.objects_array_sequence["quest_3"] = [];
      var_0 setscriptablepartstate("clockFx", "inactive");
      var_0 setscriptablepartstate("scripted_rewind", "inactive");
      level.clock_interaction_q3.clock_active = 0;
      if(isDefined(var_0.rewindmover)) {
        var_0 thread reset_rewind_mover(3);
      }

      var_0.quest_num = undefined;
      var_0 notify("objects_reset_q3");
    }
  }
}

watch_for_damage_on_struct_q3(var_0) {
  var_0 endon("part_three_complete");
  var_0 endon("objects_reset_q3");
  var_0 endon("delete_previous_thread");
  thread reset_on_failure_q3(var_0);
  for(;;) {
    self.model waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_0A);
    if(!isplayer(var_2) && !isagent(var_2)) {
      continue;
    }

    if(isDefined(level.clock_interaction_q3.clock_owner) && level.clock_interaction_q3.clock_owner != var_2) {
      continue;
    }

    if(isDefined(var_5) && var_5 != "MOD_MELEE") {
      continue;
    }

    if(self.object_num == 2 && var_2.objects_array_sequence["quest_3"].size == 0) {
      continue;
    } else if(!scripts\engine\utility::istrue(var_2.attacked_first_object_q3) && self.object_num == 1 && var_2.objects_array_sequence["part3"].size == 0) {
      var_2.objects_array_sequence["quest_3"][self.object_num - 1] = self;
      self.model.damage_done = self.model.damage_done + var_1;
      var_2.attacked_first_object_q3 = 1;
      scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(self, var_2);
      var_2 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_2);
      var_2 playlocalsound("part_pickup");
    }

    if(self.object_num == 2 && scripts\engine\utility::istrue(var_2.attacked_first_object_q3)) {
      var_2.objects_array_sequence["quest_3"][self.object_num - 1] = self;
      self.model.damage_done = self.model.damage_done + var_1;
      var_2.attacked_first_object_q3 = 1;
      scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(self, var_2);
      var_2 thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(var_2);
      var_2 playlocalsound("part_pickup");
    }

    if(var_2.objects_array_sequence["quest_3"].size == 2) {
      foreach(var_0C in var_2.objects_array_sequence["quest_3"]) {
        var_0C playfx_and_shatter(var_2);
      }

      var_2 playlocalsound("zmb_ui_earn_tickets");
      var_2 notify("part_three_complete");
    }
  }
}

disco_wait_for_interaction_triggered(var_0) {
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
    var_2 = level.interactions[var_0.script_noteworthy].cost;
    if(!isDefined(level.interactions[var_0.script_noteworthy].spend_type)) {
      level.interactions[var_0.script_noteworthy].spend_type = "null";
    }

    if(isDefined(level.interactions[var_0.script_noteworthy].can_use_override_func)) {
      if(![[level.interactions[var_0.script_noteworthy].can_use_override_func]](var_0, var_1)) {
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
      var_3 = var_1 getcurrentweapon();
      level.prevweapon = var_1 getcurrentweapon();
      var_4 = scripts\cp\cp_weapon::get_weapon_level(var_3);
      if(scripts\engine\utility::istrue(level.placed_alien_fuses)) {
        if(var_4 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_UPGRADE_MAXED");
          wait(0.1);
          continue;
        } else if(scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::can_upgrade(var_3, 1)) {
          if(var_4 == 1) {
            var_2 = 5000;
          } else if(var_4 == 2) {
            var_2 = 10000;
          }
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
          wait(0.1);
          continue;
        }
      } else if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
        var_2 = 0;
      } else if(var_4 == level.pap_max) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_INTERACTIONS_UPGRADE_MAXED");
        wait(0.1);
        continue;
      } else if(scripts\cp\maps\cp_disco\cp_disco_weapon_upgrade::can_upgrade(var_3)) {
        if(scripts\engine\utility::istrue(level.has_picked_up_fuses) && !isDefined(level.placed_alien_fuses)) {
          var_2 = 0;
        } else if(var_4 == 1) {
          var_2 = 5000;
        } else if(var_4 == 2) {
          var_2 = 10000;
        }
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(var_0)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        wait(0.1);
        continue;
      }

      var_5 = var_1 getcurrentweapon();
      var_6 = scripts\cp\utility::getbaseweaponname(var_5);
      var_7 = issubstr(var_0.script_noteworthy, "katana");
      if(var_7 && !scripts\engine\utility::istrue(var_1.has_disco_soul_key) && !scripts\engine\utility::flag("rk_fight_ended")) {
        wait(0.1);
        continue;
      }

      if(scripts\cp\cp_weapon::has_weapon_variation(var_0.script_noteworthy)) {
        if(var_7 && !scripts\engine\utility::istrue(var_1.has_disco_soul_key)) {
          wait(0.1);
          continue;
        }

        if(!scripts\cp\cp_interaction::can_purchase_ammo(var_0.script_noteworthy) || var_7) {
          if(!var_7) {
            scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"COOP_GAME_PLAY_AMMO_MAX");
          }

          wait(0.1);
          continue;
        } else {
          var_8 = scripts\cp\utility::getrawbaseweaponname(var_0.script_noteworthy);
          var_4 = scripts\cp\cp_weapon::get_weapon_level(var_8);
          if(var_4 > 1) {
            var_2 = 4500;
          } else {
            var_2 = var_2 * 0.5;
          }
        }
      } else if(var_7 && scripts\engine\utility::flag("rk_fight_ended")) {
        var_2 = 0;
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
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(var_0, var_2, level.interactions[var_0.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[var_0.script_noteworthy], self);
      if(var_0.script_parameters == "tickets") {
        scripts\cp\cp_interaction::interaction_show_fail_reason(var_0, &"CP_ZMB_INTERACTIONS_NEED_TICKETS");
        thread scripts\cp\cp_vo::try_to_play_vo("no_tickets", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(var_0) && var_0.perk_type == "perk_machine_revive" && var_1.self_revives_purchased >= var_1.max_self_revive_machine_use) {
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

    var_9 = level.interactions[var_0.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var_2, var_9);
    level thread[[level.interactions[var_0.script_noteworthy].activation_func]](var_0, self);
    if(scripts\cp\cp_interaction::interaction_is_souvenir(var_0)) {
      level thread scripts\cp\cp_interaction::souvenir_team_splash(var_0.script_noteworthy, self);
    }

    scripts\cp\cp_interaction::interaction_post_activate_update(var_0);
    wait(0.1);
    var_0.triggered = undefined;
  }
}

get_closest_interaction_struct(var_0) {
  var_1 = undefined;
  var_2 = 0;
  foreach(var_4 in level.current_interaction_structs) {
    if(!isDefined(var_4)) {
      continue;
    }

    var_5 = distancesquared(var_0, var_4.origin);
    if(!isDefined(var_1) || var_5 < var_2) {
      if(scripts\engine\utility::array_contains(self.disabled_interactions, var_4)) {
        continue;
      }

      var_1 = var_4;
      var_2 = var_5;
    }
  }

  return var_1;
}

disco_player_interaction_monitor() {
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
    var_5 = get_closest_interaction_struct(self.origin);
    if(!isDefined(var_5)) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(self.delay_hint)) {
      wait(0.1);
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_5) && distancesquared(var_5.origin, self.origin) < var_2) {
      var_4 = var_5;
    }

    if(!isDefined(var_4) && !scripts\cp\cp_interaction::interaction_is_window_entrance(var_5) && distancesquared(var_5.origin, self.origin) <= var_0) {
      var_4 = var_5;
    }

    if(isDefined(var_4) && scripts\cp\cp_interaction::interaction_is_door_buy(var_4) || scripts\cp\cp_interaction::interaction_is_chi_door(var_4) && !scripts\cp\cp_interaction::interaction_is_special_door_buy(var_4)) {
      var_4 = undefined;
    }

    if(!isDefined(var_4) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var_5.origin, self.origin) <= var_1) {
        var_4 = var_5;
      }

      if(isDefined(var_4) && ![[level.should_allow_far_search_dist_func]](var_4)) {
        var_4 = undefined;
      }
    } else if(!isDefined(var_4) && isDefined(var_5.custom_search_dist)) {
      if(distance(var_5.origin, self.origin) <= var_5.custom_search_dist) {
        var_4 = var_5;
      }
    }

    if(!isDefined(var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(!scripts\cp\cp_interaction::can_use_interaction(var_4)) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_4)) {
      var_6 = scripts\cp\utility::get_closest_entrance(var_4.origin);
      if(!isDefined(var_6)) {
        self.last_interaction_point = undefined;
        wait(0.05);
        continue;
      }

      if(scripts\cp\utility::entrance_is_fully_repaired(var_6)) {
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

    if(scripts\cp\cp_interaction::interaction_is_perk(var_4) && self getstance() == "prone") {
      self.last_interaction_point = undefined;
      wait(0.05);
      continue;
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

recordrewindlocations(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("remove_rewind_ability");
  self endon("clocks_reset");
  var_1 = 0;
  var_2 = 0;
  switch (var_0) {
    case 1:
      var_1 = 7;
      var_2 = 2.9166;
      break;

    case 2:
      var_1 = 11.45;
      var_2 = 2;
      break;

    case 3:
      var_1 = 8.25;
      var_2 = 3.416;
      break;

    case 4:
      var_1 = 19;
      var_2 = 4;
      break;
  }

  var_3 = self.origin;
  var_4 = var_1 / var_2 * 0.05;
  var_5 = var_1 / var_4;
  for(;;) {
    wait(var_4);
    if(scripts\engine\utility::istrue(self.isrewinding)) {
      self waittill("rewind_power_finished");
      wait(2);
      self notify("remove_rewind_ability");
    }

    if(distance2dsquared(self.origin, var_3) < 484) {
      continue;
    }

    var_3 = self.origin;
    if(self.rewindorigins.size < int(var_5)) {
      recordlocation(self.rewindorigins.size);
      continue;
    }

    clearsinglerecordedlocation(self.rewindpositionstartindex);
    var_6 = self.rewindpositionstartindex + int(var_5);
    recordlocation(var_6);
    self.rewindpositionstartindex++;
  }
}

_playerlerpangles(var_0, var_1, var_2) {
  var_3 = 0.05;
  var_4 = float(gettime()) / 1000;
  var_5 = var_4 + var_2;
  if(var_2 <= 0) {
    return;
  }

  var_0.angles = self.angles_when_using_clock;
  if(!isDefined(var_0)) {
    return;
  }

  var_6 = self getplayerangles();
  var_0.angles = self.angles_when_using_clock;
  self setworldupreference(var_0);
  self setplayerangles((0, 0, 0));
  self setworldupreferenceangles(var_6, 0);
  while(var_4 < var_5) {
    var_7 = cos(var_5 - var_4 / var_2 * 90);
    var_0.angles = anglelerpquatfrac(var_6, var_1, var_7);
    wait(var_3);
    var_4 = float(gettime()) / 1000;
  }

  var_0.angles = var_1;
  var_6 = self getplayerangles();
  self setworldupreference(undefined);
  self setplayerangles((0, 0, 0));
  self setworldupreferenceangles(var_6, 0);
}

runrewind(var_0) {
  self endon("disconnect");
  level endon("game_ended");
  self endon("backstory_quest_complete");
  self endon("part_1_VO_done");
  self endon("part_2_VO_done");
  self endon("part_3_VO_done");
  self endon("part_two_complete");
  self endon("part_three_complete");
  self endon("last_stand");
  self endon("death");
  self endon("rat_king_fight_started");
  var_1 = 0;
  var_2 = 0;
  var_3 = 0;
  var_4 = "quest_rewind_sound_long";
  switch (var_0) {
    case 1:
      var_1 = 7;
      var_2 = 7;
      var_3 = 2.9166;
      var_4 = "quest_rewind_sound_short";
      break;

    case 2:
      var_1 = 11.45;
      var_2 = 11.45;
      var_3 = 2;
      var_4 = "quest_rewind_sound_med";
      break;

    case 3:
      var_1 = 8.25;
      var_2 = 8.25;
      var_3 = 3.416;
      var_4 = "quest_rewind_sound_med";
      break;

    case 4:
      var_1 = 19;
      var_2 = 19;
      var_3 = 4;
      var_4 = "quest_rewind_sound_long";
      break;
  }

  wait(var_1 - 0.2);
  self playlocalsound(var_4);
  wait(0.2);
  self.quest_num = var_0;
  if(self.rewindorigins.size <= 0) {
    return;
  }

  self notify("rewind_activated");
  self setscriptablepartstate("scripted_rewind", "active");
  self.angles_when_using_clock = self getplayerangles();
  scripts\engine\utility::waitframe();
  self cancelmantle();
  self givesurvivortimescore();
  self setscriptablepartstate("screen_effects", "kung_fu_punch");
  self.isrewinding = 1;
  self setphasestatus(1);
  var_5 = (0, 0, 0);
  if(isDefined(level.clock[int(var_0) - 1]) && var_0 != 4) {
    var_5 = level.clock[int(var_0) - 1].origin;
  } else if(var_0 == 4) {
    var_5 = self.rewindorigins[self.rewindpositionstartindex];
  }

  var_6 = self.rewindangles[self.rewindpositionstartindex];
  var_7 = self.rewindvelocities[self.rewindpositionstartindex];
  scripts\cp\utility::adddamagemodifier("rewind_invulnerability", 0, 0);
  self.rewindmover = spawn("script_model", self getEye());
  self.rewindmover setModel("tag_origin");
  self.rewindmover.angles = self getplayerangles();
  self.rewindmover hidefromplayer(self);
  self.rewindmover notsolid();
  self playerlinkto(self.rewindmover, "tag_origin", 0, 10, 10, 10, 10, 0);
  self getweaponrankxpmultiplier();
  scripts\engine\utility::allow_melee(0);
  scripts\engine\utility::allow_weapon(0);
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\engine\utility::allow_usability(0);
  scripts\cp\utility::allow_player_teleport(0);
  scripts\engine\utility::allow_jump(0);
  self allowprone(0);
  self limitedmovement(1);
  self.flung = 1;
  scripts\engine\utility::waitframe();
  self playanimscriptevent("power_active", "rewind");
  var_8 = var_2 / var_3 * 0.05;
  var_9 = var_2 / var_8;
  var_0A = var_3 / var_9;
  self lerpviewangleclamp(var_3, var_0A, 0, 0, 0, 0, 0);
  thread play_fx_rewind(var_3);
  for(var_0B = self.rewindorigins.size - 1; var_0B >= 0; var_0B--) {
    var_0C = self.rewindorigins[var_0B];
    var_0D = var_0B + self.rewindpositionstartindex;
    var_0E = self.rewindorigins[var_0D];
    var_0F = self.rewindangles[var_0D];
    scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
    thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(var_0A);
    if(!isDefined(var_0E)) {
      var_0E = self.rewindorigins[self.rewindorigins.size - 1];
    }

    if(isDefined(var_0C)) {
      self.rewindmover.origin = vectorlerp(var_0C, var_0E, 0.05);
    } else {
      self.rewindmover.origin = var_0E;
    }

    wait(var_0A);
  }

  thread scripts\cp\maps\cp_disco\cp_disco::update_special_mode_for_player(self);
  completeplayerwarp(self.rewindmover, var_5, var_6, var_7, var_0);
}

play_fx_rewind(var_0) {
  self shellshock("default_nosound", var_0);
}

return_player_to_clock(var_0, var_1) {
  while(isDefined(var_0.rewindmover)) {
    wait(0.1);
  }

  var_2 = 2;
  switch (var_1) {
    case 1:
      var_3 = 7;
      var_4 = 7;
      var_2 = 2.9166;
      break;

    case 2:
      var_3 = 11.45;
      var_4 = 11.45;
      var_2 = 2;
      break;

    case 3:
      var_3 = 8.25;
      var_4 = 8.25;
      var_2 = 3.416;
      break;

    case 4:
      var_3 = 19;
      var_4 = 19;
      var_2 = 4;
      break;
  }

  var_0 scripts\cp\zombies\zombie_afterlife_arcade::add_white_screen();
  var_5 = level.clock[var_1 - 1].origin;
  var_6 = level.clock[var_1 - 1].angles;
  var_7 = (0, 0, 0);
  var_0 thread scripts\cp\zombies\zombie_afterlife_arcade::remove_white_screen(0.05);
  var_0 thread play_fx_rewind(var_2);
  if(isDefined(var_0.rewindmover)) {
    var_0 completeplayerwarp(var_0.rewindmover, var_5, var_6, var_7, var_1);
    return;
  }

  var_8 = vectorlerp(var_0.origin, var_5, 0.05);
  var_9 = getclosestpointonnavmesh(var_5);
  var_0 setorigin(var_9, 0);
  var_0 setvelocity(var_7);
  var_0 setstance("stand");
  var_0 setscriptablepartstate("scripted_rewind", "inactive");
}

recordlocation(var_0) {
  self.rewindorigins[var_0] = self.origin;
  self.rewindangles[var_0] = self getplayerangles();
  self.rewindvelocities[var_0] = self getvelocity();
}

clearsinglerecordedlocation(var_0) {
  self.rewindorigins[var_0] = undefined;
  self.rewindangles[var_0] = undefined;
  self.rewindvelocities[var_0] = undefined;
}

resetrecordedlocations() {
  self.rewindorigins = [];
  self.rewindangles = [];
  self.rewindvelocities = [];
  self.rewindpositionstartindex = 0;
}

completeplayerwarp(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vectorlerp(var_0.origin, var_1, 0.05);
  self setorigin(var_5, 0);
  self setvelocity(var_3);
  self setstance("stand");
  scripts\engine\utility::waitframe();
  var_0 solid();
  if(!scripts\engine\utility::isweaponswitchallowed()) {
    scripts\engine\utility::allow_weapon_switch(1);
  }

  if(!scripts\engine\utility::isusabilityallowed()) {
    scripts\engine\utility::allow_usability(1);
  }

  if(!scripts\cp\utility::isteleportenabled()) {
    scripts\cp\utility::allow_player_teleport(1);
  }

  scripts\cp\utility::removedamagemodifier("rewind_invulnerability", 0);
  self playanimscriptevent("power_exit", "rewind");
  self playershow();
  self setphasestatus(0);
  scripts\engine\utility::allow_melee(1);
  scripts\engine\utility::allow_weapon(1);
  scripts\engine\utility::allow_jump(1);
  self allowprone(1);
  self limitedmovement(0);
  self unlink();
  self.flung = undefined;
  self.rewindmover delete();
  self setscriptablepartstate("scripted_rewind", "inactive");
  self notify("rewind_power_finished");
  if(isDefined(self.clocks_destroyed)) {
    self.clocks_destroyed = 0;
  }

  self.isrewinding = 0;
  self.quest_num = undefined;
}

restrictfunctionality() {
  if(scripts\engine\utility::istrue(self.rewindrestrictedfunctionality)) {
    return;
  }

  self.rewindrestrictedfunctionality = 1;
  scripts\engine\utility::allow_weapon_switch(0);
  scripts\engine\utility::allow_usability(0);
  scripts\cp\utility::allow_player_teleport(0);
  thread restrictfunctionalitycleanup();
}

restorefunctionality() {
  if(!scripts\engine\utility::istrue(self.rewindrestrictedfunctionality)) {
    return;
  }

  self.rewindrestrictedfunctionality = undefined;
  if(!scripts\engine\utility::isweaponswitchallowed()) {
    scripts\engine\utility::allow_weapon_switch(1);
  }

  if(!scripts\engine\utility::isusabilityallowed()) {
    scripts\engine\utility::allow_usability(1);
  }

  if(!scripts\cp\utility::isteleportenabled()) {
    scripts\cp\utility::allow_player_teleport(1);
  }
}

restrictfunctionalitycleanup() {
  self endon("disconnect");
  self endon("rewindUnset");
  self notify("rewindRestrictFunctionalityCleanup");
  self endon("rewindRestrictFunctionalityCleanup");
  self waittill("death");
  self.rewindrestrictedfunctionality = undefined;
}

rotate_fans() {
  level endon("stop_waterfall_trap");
  level.center_sewer_fan rotateyaw(7200, 28, 2, 5);
  foreach(var_1 in level.sewer_fans) {
    var_1 rotateyaw(14400, 28, randomintrange(1, 4), 5);
  }
}

rotate_center_fan() {
  for(;;) {
    if(isDefined(level.fan_trap_active)) {
      wait(0.1);
      continue;
    } else {
      level.center_sewer_fan rotateyaw(15, 1);
    }

    wait(1);
  }
}

init_fan_trap() {
  level.sewer_fans = getEntArray("sewer_fans", "targetname");
  level.center_sewer_fan = getent("center_fan", "targetname");
  level.sewer_fan_interactions = scripts\engine\utility::getstructarray("fan_trap", "script_noteworthy");
  level.sewer_fan_switches = getEntArray(level.sewer_fan_interactions[0].target, "targetname");
  level.lower_sewer_phys_vol = getent("lower_sewer_phys_vol", "targetname");
  level.upper_sewer_phys_vol = getent("upper_sewer_phys_vol", "targetname");
  level.lower_sewer_phys_point = scripts\engine\utility::getstruct(level.lower_sewer_phys_vol.target, "targetname");
  level.sewer_fan_trig = spawn("trigger_radius", (-882.5, 1846, 151.5), 0, 585, 96);
  foreach(var_1 in level.sewer_fan_interactions) {
    var_1 thread sewer_fan_power_handler();
  }

  level thread rotate_center_fan();
}

sewer_fan_power_handler() {
  level scripts\engine\utility::waittill_any_3("power_on", self.power_area + " power_on");
  self.powered_on = 1;
  foreach(var_1 in level.sewer_fan_switches) {
    var_1 setModel("mp_frag_button_on_green");
  }
}

init_electric_trap() {
  scripts\engine\utility::flag_init("rooftop_walkway_open");
  var_0 = scripts\engine\utility::getstructarray("electric_trap", "script_noteworthy");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list(var_2);
  }

  wait(10);
  for(;;) {
    if(scripts\engine\utility::istrue(level.spawn_volume_array["punk_street"].var_19) && scripts\engine\utility::istrue(level.spawn_volume_array["rooftops_1"].var_19)) {
      break;
    }

    wait(1);
  }

  scripts\engine\utility::flag_set("rooftop_walkway_open");
  foreach(var_2 in var_0) {
    scripts\cp\cp_interaction::add_to_current_interaction_list(var_2);
  }
}

use_electric_trap(var_0, var_1) {
  level thread electric_trap_fx();
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  level thread scripts\cp\cp_interaction::interaction_cooldown(var_0, 115);
  level thread electric_trap_damage(var_0, var_1);
  wait(25);
  level notify("stop_electric_trap");
}

electric_trap_fx() {
  scripts\engine\utility::exploder(120);
  playsoundatpos((-380, 532, 961), "disco_gen_electric_trap_power_up");
  wait(1.3);
  var_0 = scripts\engine\utility::play_loopsound_in_space("disco_gen_electric_trap_lp", (-380, 532, 961));
  wait(0.05);
  var_1 = scripts\engine\utility::play_loopsound_in_space("disco_trap_electric_on_lp", (-485, 463, 962));
  level waittill("stop_electric_trap");
  playsoundatpos((-380, 532, 961), "disco_gen_electric_trap_power_down");
  wait(0.25);
  var_0 stoploopsound();
  var_1 stoploopsound();
  var_0 delete();
  var_1 delete();
}

electric_trap_damage(var_0, var_1) {
  level endon("stop_electric_trap");
  var_2 = gettime();
  var_3 = getent(var_0.target, "targetname");
  for(;;) {
    var_3 waittill("trigger", var_4);
    if(isplayer(var_4) && isalive(var_4) && !scripts\cp\cp_laststand::player_in_laststand(var_4) && !isDefined(var_4.padding_damage)) {
      playsoundatpos(var_4.origin, "trap_electric_shock");
      playfxontagforclients(level._effect["electric_shock_plyr"], var_4, "tag_eye", var_4);
      var_4.padding_damage = 1;
      var_4 dodamage(20, var_4.origin);
      var_4 thread remove_padding_damage();
      continue;
    }

    if(scripts\engine\utility::istrue(var_4.is_turned) || !scripts\cp\utility::should_be_affected_by_trap(var_4, 0, 1)) {
      continue;
    }

    if(var_4.agent_type == "ratking") {
      continue;
    }

    if(gettime() > var_2 + 1000) {
      playsoundatpos(var_4.origin, "trap_electric_shock");
      var_2 = gettime();
    }

    level thread electrocute_zombie(var_4, var_1);
    var_5 = ["kill_trap_generic", "trap_kill_elecfence"];
    var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_5), "zmb_comment_vo", "highest", 10, 0, 0, 1, 25);
  }
}

electrocute_zombie(var_0, var_1) {
  var_0 endon("death");
  wait(randomfloat(2));
  var_0.dontmutilate = 1;
  var_0.electrocuted = 1;
  var_0 setscriptablepartstate("electrocuted", "on");
  if(var_1 scripts\cp\utility::is_valid_player(1)) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }

  var_0 dodamage(var_0.health + 100, var_0.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_electrictrap_zm");
}

remove_padding_damage() {
  self endon("disconnect");
  wait(0.5);
  self.padding_damage = undefined;
}

use_fan_trap(var_0, var_1) {
  if(!scripts\engine\utility::istrue(var_0.powered_on)) {
    return;
  }

  scripts\cp\cp_interaction::disable_linked_interactions(var_0);
  level thread fan_trap_sfx();
  foreach(var_3 in level.sewer_fan_switches) {
    var_3 setModel("mp_frag_button_on");
  }

  var_0.trap_kills = 0;
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("activate_trap_generic", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
  var_5 = gettime() + 2000;
  playrumbleonposition("light_3s", level.center_sewer_fan.origin + (0, 0, 50));
  while(gettime() < var_5) {
    earthquake(0.2, 2, var_0.origin + (0, 0, 100), 500);
    wait(0.5);
    playrumbleonposition("light_3s", level.center_sewer_fan.origin + (0, 0, -50));
    wait(0.5);
  }

  level thread rotate_fans();
  level.fan_trap_active = 1;
  scripts\engine\utility::exploder(49);
  level.upper_sewer_phys_vol physics_volumesetasdirectionalforce(1, anglesToForward((-90, 0, 0)), 5000);
  level.upper_sewer_phys_vol physics_volumesetactivator(1);
  level.upper_sewer_phys_vol physics_volumeenable(1);
  level.lower_sewer_phys_vol physics_volumesetasfocalforce(1, level.lower_sewer_phys_point.origin, 2500);
  level.lower_sewer_phys_vol physics_volumesetactivator(1);
  level.lower_sewer_phys_vol physics_volumeenable(1);
  level thread kill_zombies(var_0, var_1);
  var_5 = gettime() + 25000;
  while(gettime() < var_5) {
    playrumbleonposition("heavy_3s", level.center_sewer_fan.origin + (0, 0, 50));
    earthquake(0.2, 3, level.center_sewer_fan.origin + (0, 0, -100), 500);
    wait(1);
  }

  level notify("stop_waterfall_trap");
  level.fan_trap_active = undefined;
  level.upper_sewer_phys_vol physics_volumesetactivator(0);
  level.upper_sewer_phys_vol physics_volumeenable(0);
  level.lower_sewer_phys_vol physics_volumesetactivator(0);
  level.lower_sewer_phys_vol physics_volumeenable(0);
  scripts\cp\cp_interaction::enable_linked_interactions(var_0);
  scripts\cp\cp_interaction::interaction_cooldown(var_0, 300);
  foreach(var_3 in level.sewer_fan_switches) {
    var_3 setModel("mp_frag_button_on_green");
  }
}

fan_trap_sfx() {
  playsoundatpos((-920, 1832, 450), "giant_fan_startup_lr");
  var_0 = scripts\engine\utility::play_loopsound_in_space("giant_fan_grate_impacts_lp", (-920, 1832, 450));
  wait(0.85);
  var_1 = scripts\engine\utility::play_loopsound_in_space("giant_fan_lp_lr", (-920, 1832, 450));
  var_2 = scripts\engine\utility::play_loopsound_in_space("giant_fan_wind_paper_01", (-1295, 1662, 234));
  var_3 = scripts\engine\utility::play_loopsound_in_space("giant_fan_wind_paper_02", (-438, 1644, 234));
  var_4 = scripts\engine\utility::play_loopsound_in_space("giant_fan_wind_paper_03", (-879, 2349, 234));
  level waittill("stop_waterfall_trap");
  playsoundatpos((-920, 1832, 450), "giant_fan_stop_lr");
  var_0 stoploopsound();
  var_0 delete();
  wait(0.1);
  var_1 stoploopsound();
  var_1 delete();
  wait(0.15);
  var_2 stoploopsound();
  var_2 delete();
  wait(0.2);
  var_3 stoploopsound();
  var_3 delete();
  wait(0.13);
  var_4 stoploopsound();
  var_4 delete();
}

waterfall_trap_sfx() {
  wait(0.65);
  playsoundatpos((-1714, -2031, 248), "trap_waterfall_start");
  var_0 = scripts\engine\utility::play_loopsound_in_space("trap_waterfall_rushing_lp", (-1717, -2013, 189));
  wait(4);
  var_1 = scripts\engine\utility::play_loopsound_in_space("trap_waterfall_splashing_lp", (-1702, -1824, 101));
  level waittill("stop_waterfall_trap");
  playsoundatpos((-1714, -2031, 248), "trap_waterfall_end");
  wait(0.2);
  var_0 stoploopsound();
  var_0 delete();
  var_1 stoploopsound();
  var_1 delete();
}

kill_zombies(var_0, var_1) {
  level endon("stop_waterfall_trap");
  for(;;) {
    level.sewer_fan_trig waittill("trigger", var_2);
    if(!scripts\cp\utility::should_be_affected_by_trap(var_2, undefined, 1)) {
      continue;
    }

    var_0.trap_kills++;
    var_3 = ["kill_trap_generic", "trap_kill_fanblade"];
    var_1 thread scripts\cp\cp_vo::try_to_play_vo(scripts\engine\utility::random(var_3), "zmb_comment_vo", "high", 10, 0, 0, 1, 25);
    var_2 thread fling_zombie(var_0, var_1);
  }
}

fling_zombie(var_0, var_1) {
  self endon("death");
  self.flung = 1;
  self.marked_for_death = 1;
  self.do_immediate_ragdoll = 1;
  self.customdeath = 1;
  self.disable_armor = 1;
  wait(randomfloatrange(0.5, 1.5));
  if(var_1 scripts\cp\utility::is_valid_player()) {
    var_2 = var_1;
  } else {
    var_2 = undefined;
  }

  self.dontmutilate = 1;
  self dodamage(self.health + 100, level.sewer_fan_trig.origin, var_2, var_2, "MOD_UNKNOWN", "iw7_fantrap_zm");
}

delay_remove_from_interactions(var_0) {
  var_0 notify("delay_interaction_array");
  var_0 endon("delay_interaction_array");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}

delay_add_to_interactions(var_0) {
  var_0 notify("delay_interaction_array");
  var_0 endon("delay_interaction_array");
  scripts\engine\utility::flag_wait("interactions_initialized");
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
}