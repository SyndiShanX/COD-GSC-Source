/**********************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\maps\cp_zmb\cp_zmb_interactions.gsc
**********************************************************/

register_interactions() {
  level.interaction_hintstrings["neil_head"] = &"CP_ZMB_INTERACTIONS_NEIL_HEAD_PICKUP";
  level.interaction_hintstrings["neil_battery"] = &"CP_QUEST_WOR_PART";
  level.interaction_hintstrings["neil_firmware"] = &"CP_QUEST_WOR_PART";
  level.interaction_hintstrings["neil_repair"] = &"CP_ZMB_INTERACTIONS_REPAR_NEIL";
  level.interaction_hintstrings["dj_quest_part_1"] = "";
  level.interaction_hintstrings["dj_quest_part_2"] = "";
  level.interaction_hintstrings["dj_quest_part_3"] = "";
  level.interaction_hintstrings["dj_quest_speaker"] = &"CP_QUEST_WOR_PLACE_PART";
  level.interaction_hintstrings["rockettrap"] = &"CP_ZMB_INTERACTIONS_ROCKET_TRAP";
  level.interaction_hintstrings["beamtrap"] = &"CP_ZMB_INTERACTIONS_BEAMTRAP";
  level.interaction_hintstrings["interaction_discoballtrap"] = &"CP_ZMB_INTERACTIONS_USE_DISCO_TRAP";
  level.interaction_hintstrings["scrambler"] = &"CP_ZMB_INTERACTIONS_SCRAMBLER";
  level.interaction_hintstrings["blackhole_trap"] = &"CP_ZMB_INTERACTIONS_USE_BLACKHOLE_TRAP";
  level.interaction_hintstrings["debris_350"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1000"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1500"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2000"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_2500"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_1250"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["debris_750"] = &"CP_ZMB_INTERACTIONS_PURCHASE_AREA";
  level.interaction_hintstrings["team_door_switch"] = &"CP_ZMB_INTERACTIONS_TEAM_DOOR_SWITCH";
  level.interaction_hintstrings["tutorial"] = &"CP_ZMB_INTERACTIONS_TURN_ON_TUTORIALS";
  level.interaction_hintstrings["iw7_ar57_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m4_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_fmg_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ake_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ake_zml"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_sonic_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_sonic_zmr"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_nrg_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m1_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m1_zmr"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m1c_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_revolver_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_spas_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_crb_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_crb_zml"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_erad_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_kbs_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ripper_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ripper_zmr"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_ump45_zml"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_m8_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["iw7_cheytac_zm"] = &"CP_ZMB_INTERACTIONS_BUY_WEAPON";
  level.interaction_hintstrings["crafting_pickup"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTINGITEM_PICKUP";
  level.interaction_hintstrings["crafting_item_swap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTINGITEM_SWAP";
  level.interaction_hintstrings["crafting_station"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTING_ADDPIECE";
  level.interaction_hintstrings["crafting_nopiece"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTING_NOPIECE";
  level.interaction_hintstrings["crafting_addpiece"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTING_ADDPIECE";
  level.interaction_hintstrings["crafted_windowtrap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_LASERTRAP";
  level.interaction_hintstrings["crafted_autosentry"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_AUTOSENTRY";
  level.interaction_hintstrings["crafted_ims"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_IMS";
  level.interaction_hintstrings["crafted_medusa"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_MEDUSA";
  level.interaction_hintstrings["crafted_electric_trap"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_ELECTRIC_TRAP";
  level.interaction_hintstrings["crafted_boombox"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_BOOMBOX";
  level.interaction_hintstrings["crafted_revocator"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_REVOCATOR";
  level.interaction_hintstrings["crafted_gascan"] = &"ZOMBIE_CRAFTING_SOUVENIRS_CRAFTED_GASCAN";
  level.interaction_hintstrings["weapon_upgrade"] = &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON";
  level.interaction_hintstrings["atm_deposit"] = &"CP_ZMB_INTERACTIONS_ATM_DEPOSIT";
  level.interaction_hintstrings["atm_withdrawal"] = &"CP_ZMB_INTERACTIONS_ATM_WITHDRAWAL";
  level.interaction_hintstrings["power_armageddon"] = &"COOP_INTERACTIONS_CRAFTED_ARMAGEDDON";
  level.interaction_hintstrings["power_bioSpike"] = &"COOP_INTERACTIONS_CRAFTED_BIOSPIKE";
  level.interaction_hintstrings["power_c4"] = &"COOP_INTERACTIONS_CRAFTED_C4";
  level.interaction_hintstrings["power_barrier"] = &"COOP_INTERACTIONS_CRAFTED_BARRIER";
  level.interaction_hintstrings["power_cloak"] = &"COOP_INTERACTIONS_CRAFTED_CLOAK";
  level.interaction_hintstrings["power_mortarMount"] = &"COOP_INTERACTIONS_CRAFTED_MORTAR_MOUNT";
  level.interaction_hintstrings["power_teleport"] = &"COOP_INTERACTIONS_CRAFTED_TELEPORT";
  level.interaction_hintstrings["power_transponder"] = &"COOP_INTERACTIONS_CRAFTED_TRANSPONDER";
  level.interaction_hintstrings["power_speedBoost"] = &"COOP_INTERACTIONS_CRAFTED_SPEED_BO0ST";
  level.interaction_hintstrings["power_phaseShift"] = &"COOP_INTERACTIONS_CRAFTED_PHASE_SHIFT";
  level.interaction_hintstrings["power_kineticPulse"] = &"COOP_INTERACTIONS_CRAFTED_KINETIC_PULSE";
  level.interaction_hintstrings["power_microTurret"] = &"COOP_INTERACTIONS_CRAFTED_MICRO_TURRET";
  level.interaction_hintstrings["power_chargeMode"] = &"COOP_INTERACTIONS_CRAFTED_CHARGE_MODE";
  level.interaction_hintstrings["power_rewind"] = &"COOP_INTERACTIONS_CRAFTED_REWIND";
  level.interaction_hintstrings["fast_travel"] = &"CP_ZMB_INTERACTIONS_ENTER_PORTAL";
  level.interaction_hintstrings["small_ticket_prize"] = &"CP_ZMB_INTERACTIONS_BAG_O_BULLETS";
  level.interaction_hintstrings["medium_ticket_prize"] = &"CP_ZMB_INTERACTIONS_GRENADE_POUCH";
  level.interaction_hintstrings["large_ticket_prize"] = &"CP_ZMB_INTERACTIONS_ARK_ATTACHMENT";
  level.interaction_hintstrings["iw7_forgefreeze_zm"] = &"CP_ZMB_INTERACTIONS_REDEEM_FREEZE";
  level.interaction_hintstrings["zfreeze_semtex_mp"] = &"CP_ZMB_INTERACTIONS_REDEEM_CRYONADE";
  level.interaction_hintstrings["gold_teeth"] = &"CP_QUEST_WOR_GATOR_TEETH";
  level.interaction_hintstrings["gator_teeth_placement"] = &"CP_QUEST_WOR_PLACE_PART";
  level.interaction_hintstrings["laughingclown"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["laughingclown_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["coaster"] = &"CP_ZMB_INTERACTIONS_RIDE_COASTER";
  level.interaction_hintstrings["basketball_game"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["basketball_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["shooting_gallery"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["bowling_for_planets"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["bowling_for_planets_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["clown_tooth_game"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["clown_tooth_game_afterlife"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["game_race"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["wor_crafting_crate"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["ark_quest_station"] = &"CP_QUEST_WOR_PLACE_PART";
  level.interaction_hintstrings["white_ark"] = &"CP_ZMB_INTERACTIONS_EQUIP_WHITE_ARK";
  level.interaction_hintstrings["arcade_barnstorming"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_robottank"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_spider"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_demon"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_starmaster"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_riverraid"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_pitfall"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["arcade_cosmic"] = &"COOP_INTERACTIONS_PLAY_GAME";
  level.interaction_hintstrings["spawned_essence"] = &"CP_QUEST_WOR_PART";
  if(scripts\cp\utility::isplayingsolo() || level.only_one_player) {
    scripts\cp\cp_interaction::register_interaction("tutorial", "quest", undefined, undefined, ::interact_spaceland_tutorial, 0, 0, ::init_spaceland_tutorial);
  }

  scripts\cp\cp_interaction::register_interaction("arcade_barnstorming", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_robottank", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_spider", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_demon", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_starmaster", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_riverraid", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_pitfall", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_cosmic", "arcade_game", undefined, undefined, ::scripts\cp\zombies\zombie_arcade_games::use_arcade_game, 0, 1);
  scripts\cp\cp_interaction::register_interaction("arcade_counter_grenade", "tickets", 1, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_hint_func, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_activation, 150, 1, ::scripts\cp\zombies\interaction_small_ticket_counter::init_arcade_grenade_slot);
  scripts\cp\cp_interaction::register_interaction("arcade_counter_ammo", "tickets", 1, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_hint_func, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_activation, 150, 1, ::scripts\cp\zombies\interaction_small_ticket_counter::init_arcade_counter_ammo_slot);
  scripts\cp\cp_interaction::register_interaction("small_ticket_prize", "tickets", 1, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_hint_func, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_activation, 25, 1, ::scripts\cp\zombies\interaction_small_ticket_counter::init_small_counter_slot);
  scripts\cp\cp_interaction::register_interaction("medium_ticket_prize", "tickets", 1, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_hint_func, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_activation, 50, 1, ::scripts\cp\zombies\interaction_small_ticket_counter::init_medium_counter_slot);
  scripts\cp\cp_interaction::register_interaction("large_ticket_prize", "tickets", 1, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_hint_func, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_activation, 300, 1, ::scripts\cp\zombies\interaction_small_ticket_counter::init_large_counter_slot);
  scripts\cp\cp_interaction::register_interaction("debris_350", "door_buy", 1, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 350);
  scripts\cp\cp_interaction::register_interaction("debris_1000", "door_buy", 1, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1000);
  scripts\cp\cp_interaction::register_interaction("debris_1500", "door_buy", 1, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1500);
  scripts\cp\cp_interaction::register_interaction("debris_2000", "door_buy", 1, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 2000);
  scripts\cp\cp_interaction::register_interaction("debris_2500", "door_buy", 1, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 2500);
  scripts\cp\cp_interaction::register_interaction("debris_1250", "door_buy", 1, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 1250);
  scripts\cp\cp_interaction::register_interaction("debris_750", "door_buy", 1, undefined, ::scripts\cp\zombies\interaction_openareas::clear_debris, 750);
  scripts\cp\cp_interaction::register_interaction("team_door_switch", "team_door_buy", 1, undefined, ::scripts\cp\zombies\interaction_openareas::use_team_door_switch, 1000);
  scripts\cp\cp_interaction::register_interaction("zfreeze_semtex_mp", "ticket_weapon", undefined, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_hint_func, ::give_player_cryobomb, 350, 0, ::init_cryobomb);
  scripts\cp\cp_interaction::register_interaction("iw7_forgefreeze_zm", "ticket_weapon", undefined, ::scripts\cp\zombies\interaction_small_ticket_counter::ticket_counter_slot_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 500, 0, ::init_cryobomb);
  scripts\cp\cp_interaction::register_interaction("gold_teeth", "ticket_prize", undefined, ::scripts\cp\maps\cp_zmb\cp_zmb::gold_teeth_hint_func, ::scripts\cp\maps\cp_zmb\cp_zmb::gold_teeth_pickup, 300, 1, ::scripts\cp\maps\cp_zmb\cp_zmb::gator_tooth_init);
  scripts\cp\cp_interaction::register_interaction("gator_teeth_placement", "quest", undefined, ::scripts\cp\maps\cp_zmb\cp_zmb::gator_mouth_hint_func, ::scripts\cp\maps\cp_zmb\cp_zmb::gator_mouth_activation_func, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb::gator_tooth_placement_init);
  scripts\cp\cp_interaction::register_interaction("iw7_m8_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1000);
  scripts\cp\cp_interaction::register_interaction("iw7_cheytac_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1000);
  scripts\cp\cp_interaction::register_interaction("iw7_m1_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 500);
  scripts\cp\cp_interaction::register_interaction("iw7_m1_zmr", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 500);
  scripts\cp\cp_interaction::register_interaction("iw7_m1c_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 500);
  scripts\cp\cp_interaction::register_interaction("iw7_revolver_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 500);
  scripts\cp\cp_interaction::register_interaction("iw7_sonic_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 750);
  scripts\cp\cp_interaction::register_interaction("iw7_sonic_zmr", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 750);
  scripts\cp\cp_interaction::register_interaction("iw7_nrg_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 750);
  scripts\cp\cp_interaction::register_interaction("iw7_spas_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_kbs_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_crb_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_crb_zml", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_erad_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_ripper_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_ripper_zmr", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_ump45_zml", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1250);
  scripts\cp\cp_interaction::register_interaction("iw7_m4_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_ar57_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_ake_zml", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("iw7_fmg_zm", "wall_buy", 1, ::scripts\cp\zombies\coop_wall_buys::get_wall_buy_hint_func, ::scripts\cp\zombies\coop_wall_buys::interaction_purchase_weapon, 1500);
  scripts\cp\cp_interaction::register_interaction("power_bioSpike", "wall_buy", undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_wall_bought_power, 1000);
  scripts\cp\cp_interaction::register_interaction("power_c4", "wall_buy", undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_wall_bought_power, 1000);
  scripts\cp\cp_interaction::register_interaction("ark_quest_station", "quest", undefined, ::scripts\cp\zombies\zombie_ark_quest::ark_quest_hint_func, ::scripts\cp\zombies\zombie_ark_quest::ark_quest_activation, 0, 0, ::scripts\cp\zombies\zombie_ark_quest::init_ark_quest);
  scripts\cp\cp_interaction::register_interaction("white_ark", "quest", undefined, ::scripts\cp\zombies\zombie_ark_quest::has_white_ark_hint_func, ::scripts\cp\zombies\zombie_ark_quest::add_white_ark_to_weapon, 2000);
  scripts\cp\cp_interaction::register_interaction("crafting_pickup", "souvenir_coin", 1, undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_crafting::crafting_item_pickup, 0);
  scripts\cp\cp_interaction::register_interaction("atm_withdrawal", "atm", 1, ::scripts\cp\zombies\zombies_atm::atm_withdrawal_hint_logic, ::scripts\cp\zombies\zombies_atm::interaction_atm_withdrawal, 0, 1, undefined);
  scripts\cp\cp_interaction::register_interaction("atm_deposit", "atm", 1, ::scripts\cp\cp_interaction::atm_deposit_hint, ::scripts\cp\zombies\zombies_atm::interaction_atm_deposit, 1000, 1, ::scripts\cp\zombies\zombies_atm::init_atm);
  scripts\cp\cp_interaction::register_interaction("weapon_upgrade", "pap", 1, ::scripts\cp\zombies\interaction_weapon_upgrade::weapon_upgrade_hint_logic, ::scripts\cp\zombies\interaction_weapon_upgrade::weapon_upgrade, 5000, 0, ::scripts\cp\zombies\interaction_weapon_upgrade::init_all_weapon_upgrades);
  scripts\cp\cp_interaction::register_interaction("rockettrap", "trap", 1, undefined, ::scripts\cp\zombies\interaction_rockettrap::use_rocket_trap, 750, 1, ::scripts\cp\zombies\interaction_rockettrap::init_rockettrap);
  scripts\cp\cp_interaction::register_interaction("crafting_station", "souvenir_station", 1, undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_crafting::use_crafting_station, 0, 1, ::scripts\cp\maps\cp_zmb\cp_zmb_crafting::init_crafting_station);
  scripts\cp\cp_interaction::register_interaction("beamtrap", "trap", 1, undefined, ::scripts\cp\zombies\interaction_beamtrap::use_beam_trap, 750, 1, ::scripts\cp\zombies\interaction_beamtrap::init_beam_trap);
  scripts\cp\cp_interaction::register_interaction("basketball_game", "arcade_game", undefined, ::scripts\cp\zombies\arcade_game_utility::arcade_game_hint_func, ::scripts\cp\zombies\interaction_basketball::use_basketball_game, 0, 0, ::scripts\cp\zombies\interaction_basketball::init_basketball_game);
  scripts\cp\cp_interaction::register_interaction("coaster", "coaster", undefined, ::scripts\cp\zombies\arcade_game_utility::arcade_game_hint_func, ::scripts\cp\maps\cp_zmb\cp_zmb_coaster::use_coaster, 0, 1, ::scripts\cp\maps\cp_zmb\cp_zmb_coaster::init_coaster);
  scripts\cp\cp_interaction::register_interaction("laughingclown", "arcade_game", undefined, ::scripts\cp\zombies\arcade_game_utility::arcade_game_hint_func, ::scripts\cp\zombies\interaction_laughingclown::laughing_clown, 0, 1, ::scripts\cp\zombies\interaction_laughingclown::init_all_laughing_clowns);
  scripts\cp\cp_interaction::register_interaction("bowling_for_planets", "arcade_game", undefined, ::scripts\cp\zombies\arcade_game_utility::arcade_game_hint_func, ::scripts\cp\zombies\interaction_bowling_for_planets::use_bfp_game, 0, 1, ::scripts\cp\zombies\interaction_bowling_for_planets::init_bfp_game);
  scripts\cp\cp_interaction::register_interaction("clown_tooth_game", "arcade_game", undefined, ::scripts\cp\zombies\arcade_game_utility::arcade_game_hint_func, ::scripts\cp\zombies\interaction_clowntooth::use_clowntooth_game, 0, 1, ::scripts\cp\zombies\interaction_clowntooth::init_clowntooth_game);
  scripts\cp\cp_interaction::register_interaction("game_race", "arcade_game", undefined, ::scripts\cp\zombies\interaction_racing::race_game_hint_logic, ::scripts\cp\zombies\interaction_racing::use_race_game, 0, 1, ::scripts\cp\zombies\interaction_racing::init_all_race_games);
  scripts\cp\cp_interaction::register_interaction("basketball_game_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_basketball::use_basketball_game, 0, 0, ::scripts\cp\zombies\interaction_basketball::init_afterlife_basketball_game);
  scripts\cp\cp_interaction::register_interaction("clown_tooth_game_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_clowntooth::use_clowntooth_game, 0, 0, ::scripts\cp\zombies\interaction_clowntooth::init_afterlife_clowntooth_game);
  scripts\cp\cp_interaction::register_interaction("laughingclown_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_laughingclown::laughing_clown, 0, 0, ::scripts\cp\zombies\interaction_laughingclown::init_all_afterlife_laughing_clowns);
  scripts\cp\cp_interaction::register_interaction("bowling_for_planets_afterlife", "afterlife_game", undefined, undefined, ::scripts\cp\zombies\interaction_bowling_for_planets::use_bfp_game, 0, 0, ::scripts\cp\zombies\interaction_bowling_for_planets::init_bfp_afterlife_game);
  scripts\cp\cp_interaction::register_interaction("power_speedBoost", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_phaseShift", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_kineticPulse", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_microTurret", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_chargeMode", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_rewind", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_transponder", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_mortarMount", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_teleport", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_armageddon", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("power_barrier", undefined, undefined, undefined, ::scripts\cp\powers\coop_powers::give_player_crafted_power, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_autosentry", "craftable", 1, undefined, ::scripts\cp\cp_weapon_autosentry::give_crafted_sentry, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_ims", "craftable", 1, undefined, ::scripts\cp\zombies\craftables\_fireworks_trap::give_crafted_fireworks_trap, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_medusa", "craftable", 1, undefined, ::scripts\cp\zombies\craftables\_zm_soul_collector::give_crafted_medusa, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_electric_trap", "craftable", 1, undefined, ::scripts\cp\zombies\craftables\_electric_trap::give_crafted_trap, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_boombox", "craftable", 1, undefined, ::scripts\cp\zombies\craftables\_boombox::give_crafted_boombox, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_revocator", "craftable", 1, undefined, ::scripts\cp\zombies\craftables\_revocator::give_crafted_revocator, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_gascan", "craftable", 1, undefined, ::scripts\cp\zombies\craftables\_gascan::give_crafted_gascan, 0);
  scripts\cp\cp_interaction::register_interaction("crafted_windowtrap", "craftable", 1, undefined, ::scripts\cp\zombies\interaction_windowtraps::purchase_laser_trap, 0);
  scripts\cp\cp_interaction::register_interaction("interaction_discoballtrap", "trap", 1, undefined, ::scripts\cp\zombies\interaction_discoballtrap::use_discoball_trap, 750, 1, ::scripts\cp\zombies\interaction_discoballtrap::init_discoball_trap);
  scripts\cp\cp_interaction::register_interaction("fast_travel", "fast_travel", undefined, ::scripts\cp\zombies\zombie_fast_travel::fast_travel_hint_logic, ::scripts\cp\zombies\zombie_fast_travel::run_fast_travel_logic, 0, 1, ::scripts\cp\zombies\zombie_fast_travel::fast_travel_init);
  scripts\cp\cp_interaction::register_interaction("scrambler", "trap", 1, undefined, ::scripts\cp\zombies\interaction_scrambler::use_scrambler, 750, 1, ::scripts\cp\zombies\interaction_scrambler::init_scrambler);
  scripts\cp\cp_interaction::register_interaction("blackhole_trap", "trap", 1, undefined, ::scripts\cp\zombies\interaction_blackhole_trap::use_blackhole_trap, 750, 1, ::scripts\cp\zombies\interaction_blackhole_trap::init_blackhole_trap);
  scripts\cp\cp_interaction::register_interaction("neil_head", "quest", 1, undefined, ::scripts\cp\zombies\interaction_neil::pickup_head, 0, 0);
  scripts\cp\cp_interaction::register_interaction("neil_battery", "quest", undefined, undefined, ::scripts\cp\zombies\interaction_neil::pickup_battery, 0, 0);
  scripts\cp\cp_interaction::register_interaction("neil_firmware", "quest", undefined, undefined, ::scripts\cp\zombies\interaction_neil::pickup_firmware, 0, 0);
  scripts\cp\cp_interaction::register_interaction("neil_repair", "quest_neil", 1, ::scripts\cp\zombies\interaction_neil::neil_repair_hintstring_logic, ::scripts\cp\zombies\interaction_neil::add_part_to_neil, 0, 0);
  scripts\cp\cp_interaction::register_interaction("spawned_essence", "quest", undefined, undefined, ::scripts\cp\zombies\zombies_wor::essence_pickup_func, 0, 0);
  scripts\cp\cp_interaction::register_interaction("dj_quest_part_1", "quest", undefined, undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::pick_up_part_1, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::init_part_1);
  scripts\cp\cp_interaction::register_interaction("dj_quest_part_2", "quest", undefined, undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::pick_up_part_2, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::init_part_2);
  scripts\cp\cp_interaction::register_interaction("dj_quest_part_3", "quest", undefined, undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::pick_up_part_3, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::init_part_3);
  scripts\cp\cp_interaction::register_interaction("dj_quest_door", "quest", undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::dj_door_hintstring, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::use_dj_door, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::setup_dj_doors);
  scripts\cp\cp_interaction::register_interaction("dj_quest_speaker", "quest", undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::speaker_defend_hint_func, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::start_defense_sequence, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::init_dj_speaker);
  scripts\cp\cp_interaction::register_interaction("dj_quest_speaker_mid", "quest", undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::dj_speaker_mid_hint_func, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::waitforplayertrigger, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb_dj::createstructinmiddle);
  scripts\cp\cp_interaction::register_interaction("pap_upgrade", undefined, undefined, ::scripts\cp\maps\cp_zmb\cp_zmb_ufo::pap_upgrade_hintstring, ::scripts\cp\maps\cp_zmb\cp_zmb_ufo::upgrade_pap, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb_ufo::init_pap_upgrade, ::scripts\cp\maps\cp_zmb\cp_zmb_ufo::can_use_pap_upgrade);
  scripts\cp\cp_interaction::register_interaction("pillage_item", "pillage_item", 1, ::scripts\cp\zombies\zombies_pillage::pillage_hint_func, ::scripts\cp\zombies\zombies_pillage::player_used_pillage_spot, 0, 0);
  scripts\cp\cp_interaction::register_interaction("wor_standee", "quest", undefined, ::scripts\cp\zombies\zombies_wor::standee_hint_logic, ::scripts\cp\zombies\zombies_wor::standee_activate_logic, 0, 0, ::scripts\cp\zombies\zombies_wor::init_standee_interaction);
  if(scripts\cp\utility::is_escape_gametype()) {
    level.interaction_hintstrings["escape_exit"] = &"CP_ZMB_INTERACTIONS_ESCAPE_THE_PARK";
    scripts\cp\cp_interaction::register_interaction("escape_exit", undefined, undefined, undefined, ::scripts\cp\gametypes\escape::player_escape, 0, 0, ::scripts\cp\maps\cp_zmb\cp_zmb_escape::init_escape_interactions);
    return;
  }

  if(isDefined(level.escape_interaction_registration_func)) {
    level thread[[level.escape_interaction_registration_func]]();
  }
}

give_player_cryobomb(param_00, param_01) {
  param_01 scripts\cp\powers\coop_powers::givepower("power_cryobomb", "primary", undefined, undefined, 0, 1);
  thread scripts\cp\zombies\interaction_small_ticket_counter::deactivate_ticket_counter_slot(param_00, param_01);
}

init_cryobomb() {
  var_00 = scripts\engine\utility::getstruct("zfreeze_semtex_mp", "script_noteworthy");
  var_00.randomintrange = var_00.trigger;
  var_00.randomintrange.hint_string = level.interaction_hintstrings["zfreeze_semtex_mp"];
}

init_cryobomb() {
  var_00 = scripts\engine\utility::getstruct("iw7_forgefreeze_zm+forgefreezealtfire", "script_noteworthy");
  var_00.randomintrange = var_00.trigger;
  var_00.randomintrange.hint_string = level.interaction_hintstrings["iw7_forgefreeze_zm"];
}

interact_spaceland_tutorial(param_00, param_01) {
  param_01 thread scripts\cp\cp_hud_message::tutorial_interaction();
  param_01 setclientomnvar("zm_tutorial_num", -1);
}

init_spaceland_tutorial() {
  level.tutorial_interaction_1 = spawn_tutorial_interaction((688, 3116.5, 0));
  level.tutorial_interaction_2 = spawn_tutorial_interaction((688, 3203, 0));
}

spawn_tutorial_interaction(param_00) {
  var_01 = spawnStruct();
  var_01.script_noteworthy = "tutorial";
  var_01.origin = param_00;
  var_01.requires_power = 0;
  var_01.powered_on = 1;
  var_01.script_parameters = "tutorial";
  var_01.name = "tutorial";
  var_01.spend_type = "quest";
  var_01.var_336 = "interaction";
  scripts\cp\cp_interaction::add_to_current_interaction_list(var_01);
  return var_01;
}

zmb_player_interaction_monitor() {
  self notify("player_interaction_monitor");
  self endon("player_interaction_monitor");
  self endon("disconnect");
  self endon("death");
  var_00 = 5184;
  var_01 = 9216;
  var_02 = 2304;
  for(;;) {
    if(isDefined(level.interactions_disabled)) {
      wait(1);
      continue;
    }

    var_04 = undefined;
    level.current_interaction_structs = scripts\engine\utility::array_removeundefined(level.current_interaction_structs);
    var_05 = sortbydistance(level.current_interaction_structs, self.origin);
    foreach(var_07 in self.disabled_interactions) {
      var_05 = scripts\engine\utility::array_remove(var_05, var_07);
    }

    if(var_05.size == 0) {
      wait(0.1);
      continue;
    }

    if(scripts\engine\utility::istrue(self.delay_hint)) {
      wait(0.1);
      continue;
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_05[0]) && distancesquared(var_05[0].origin, self.origin) < var_02) {
      var_04 = var_05[0];
    }

    if(!isDefined(var_04) && !scripts\cp\cp_interaction::interaction_is_window_entrance(var_05[0]) && distancesquared(var_05[0].origin, self.origin) <= var_00) {
      var_04 = var_05[0];
    }

    if(isDefined(var_04) && scripts\cp\cp_interaction::interaction_is_door_buy(var_04) || scripts\cp\cp_interaction::interaction_is_chi_door(var_04) && !scripts\cp\cp_interaction::interaction_is_special_door_buy(var_04)) {
      var_04 = undefined;
    }

    if(!isDefined(var_04) && isDefined(level.should_allow_far_search_dist_func)) {
      if(distancesquared(var_05[0].origin, self.origin) <= var_01) {
        var_04 = var_05[0];
      }

      if(isDefined(var_04) && ![[level.should_allow_far_search_dist_func]](var_04)) {
        var_04 = undefined;
      }
    } else if(!isDefined(var_04) && isDefined(var_05[0].custom_search_dist)) {
      if(distance(var_05[0].origin, self.origin) <= var_05[0].custom_search_dist) {
        var_04 = var_05[0];
      }
    }

    if(!scripts\cp\cp_interaction::can_use_interaction(var_04)) {
      scripts\cp\cp_interaction::reset_interaction();
      if(isDefined(self.ticket_item_outlined)) {
        self.ticket_item_outlined hudoutlinedisableforclient(self);
        self.ticket_item_outlined = undefined;
      }

      continue;
    }

    if(!scripts\cp\cp_interaction::interaction_is_ticket_buy(var_04)) {
      if(isDefined(self.ticket_item_outlined)) {
        self.ticket_item_outlined hudoutlinedisableforclient(self);
        self.ticket_item_outlined = undefined;
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_ark_quest_station(var_04) && !isDefined(var_04.crystals) || isDefined(var_04.crystals) && var_04.crystals.size < 1) {
      scripts\cp\cp_interaction::reset_interaction();
      continue;
    } else if(scripts\cp\cp_interaction::interaction_is_white_ark(var_04)) {
      if(!scripts\cp\cp_weapon::can_use_attachment("arkpink", self getcurrentweapon())) {
        scripts\cp\cp_interaction::reset_interaction();
        continue;
      } else if(scripts\engine\utility::istrue(self.has_white_ark)) {
        scripts\cp\cp_interaction::reset_interaction();
        continue;
      }
    }

    if(scripts\cp\cp_interaction::interaction_is_window_entrance(var_04)) {
      var_09 = scripts\cp\utility::get_closest_entrance(var_04.origin);
      if(!isDefined(var_09)) {
        self.last_interaction_point = undefined;
        wait(0.05);
        continue;
      }

      if(scripts\cp\utility::entrance_is_fully_repaired(var_09)) {
        scripts\cp\cp_interaction::reset_interaction();
        if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
          if(!isDefined(var_04.has_trap)) {
            thread scripts\cp\cp_interaction::flash_inventory();
          }
        }

        self.last_interaction_point = var_04;
        continue;
      } else {
        self notify("stop_interaction_logic");
        self.last_interaction_point = undefined;
      }

      if(isDefined(self.current_crafted_inventory) && self.current_crafted_inventory.randomintrange == "crafted_windowtrap") {
        if(!isDefined(var_04.has_trap)) {
          thread scripts\cp\cp_interaction::flash_inventory();
        }
      }
    }

    if(!isDefined(self.last_interaction_point)) {
      scripts\cp\cp_interaction::set_interaction_point(var_04);
    } else if(self.last_interaction_point == var_04 && scripts\cp\cp_interaction::interaction_is_weapon_buy(var_04) && !scripts\engine\utility::istrue(self.delay_hint)) {
      scripts\cp\cp_interaction::set_interaction_point(var_04, 0);
    } else if(self.last_interaction_point != var_04) {
      scripts\cp\cp_interaction::set_interaction_point(var_04);
    }

    wait(0.05);
  }
}

zmb_wait_for_interaction_triggered(param_00) {
  self notify("interaction_logic_started");
  self endon("interaction_logic_started");
  self endon("stop_interaction_logic");
  self endon("disconnect");
  for(;;) {
    self.interaction_trigger waittill("trigger", var_01);
    if(var_01 isinphase()) {
      continue;
    }

    if(!scripts\cp\cp_interaction::interaction_is_valid(param_00, var_01)) {
      wait(0.1);
      continue;
    }

    param_00.triggered = 1;
    param_00 thread scripts\cp\cp_interaction::delayed_trigger_unset();
    if(isDefined(param_00.available_ingredient_slots)) {
      if(param_00.available_ingredient_slots > 0) {
        if(!isDefined(var_01.current_crafting_struct)) {
          var_01 thread scripts\cp\cp_vo::try_to_play_vo("no_souvenir_coin", "zmb_comment_vo", "low", 10, 0, 0, 0, 50);
        }
      }
    }

    var_02 = level.interactions[param_00.script_noteworthy].cost;
    if(!isDefined(level.interactions[param_00.script_noteworthy].spend_type)) {
      level.interactions[param_00.script_noteworthy].spend_type = "null";
    }

    if(isDefined(level.interactions[param_00.script_noteworthy].can_use_override_func)) {
      if(![[level.interactions[param_00.script_noteworthy].can_use_override_func]](param_00, var_01)) {
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_souvenir(param_00) && scripts\cp\cp_interaction::player_has_souvenir(param_00, self)) {
      scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_ALREADY_HAVE");
      wait(0.1);
      continue;
    } else if(param_00.script_noteworthy == "dj_quest_speaker") {
      var_03 = self canplayerplacesentry(1, 24);
      if(!self isonground() || !var_03["result"] || abs(param_00.origin[2] - self.origin[2]) > 24) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_NOT_ENOUGH_SPACE");
        wait(0.1);
        continue;
      }
    } else if(param_00.script_noteworthy == "lost_and_found") {
      if(!scripts\engine\utility::istrue(self.have_things_in_lost_and_found)) {
        wait(0.1);
        continue;
      }

      if(isDefined(self.lost_and_found_spot) && self.lost_and_found_spot != param_00) {
        wait(0.1);
        continue;
      }

      if(scripts\cp\utility::isplayingsolo() || scripts\engine\utility::istrue(level.only_one_player)) {
        var_02 = 0;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_upgrade(param_00)) {
      if(scripts\cp\utility::is_codxp()) {
        wait(0.1);
        continue;
      }

      var_04 = var_01 getcurrentweapon();
      level.prevweapon = var_01 getcurrentweapon();
      var_05 = scripts\cp\cp_weapon::get_weapon_level(var_04);
      if(scripts\engine\utility::istrue(var_01.has_zis_soul_key) || scripts\engine\utility::istrue(level.placed_alien_fuses)) {
        if(var_05 == 3) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_UPGRADE_MAXED");
          wait(0.1);
          continue;
        } else if(scripts\cp\cp_weapon::can_upgrade(var_04)) {
          if(var_05 == 1) {
            var_02 = 5000;
          } else if(var_05 == 2) {
            var_02 = 10000;
          }
        } else {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
          wait(0.1);
          continue;
        }
      } else if(var_05 == level.pap_max) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_UPGRADE_MAXED");
        wait(0.1);
        continue;
      } else if(scripts\cp\cp_weapon::can_upgrade(var_04)) {
        if(var_05 == 1) {
          var_02 = 5000;
        } else if(var_05 == 2) {
          var_02 = 10000;
        }
      } else {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"CP_ZMB_INTERACTIONS_UPGRADE_WEAPON_FAIL");
        wait(0.1);
        continue;
      }
    } else if(isDefined(param_00.script_noteworthy) && param_00.script_noteworthy == "spawned_essence") {
      if(!scripts\cp\utility::weaponhasattachment(var_01 getcurrentweapon(), "arcane_base")) {
        thread scripts\cp\cp_vo::try_to_play_vo("quest_arcane_nocore_fail", "zmb_comment_vo", "medium", 10, 0, 0, 1, 100);
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"CP_QUEST_WOR_CANNOT_PICKUP_ESSENCE");
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_white_ark(param_00)) {
      if(!scripts\cp\utility::weaponhasattachment(var_01 getcurrentweapon(), "arcane_base")) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"CP_QUEST_WOR_CANNOT_PICKUP_ESSENCE");
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_weapon_buy(param_00)) {
      if(scripts\cp\utility::is_weapon_purchase_disabled()) {
        wait(0.1);
        continue;
      }

      var_06 = var_01 getcurrentweapon();
      var_07 = scripts\cp\utility::getbaseweaponname(var_06);
      if(param_00.script_parameters == "tickets") {
        if(self hasweapon(param_00.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_ALREADY_HAVE");
          wait(0.1);
          continue;
        }

        self.itempicked = param_00.script_noteworthy;
        scripts\cp\zombies\zombie_analytics::log_item_purchase_with_tickets(level.wave_num, self.itempicked, level.transactionid);
      }

      if(scripts\cp\cp_weapon::has_weapon_variation(param_00.script_noteworthy)) {
        if(!scripts\cp\cp_interaction::can_purchase_ammo(param_00.script_noteworthy)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_GAME_PLAY_AMMO_MAX");
          wait(0.1);
          continue;
        } else {
          var_08 = scripts\cp\utility::getrawbaseweaponname(param_00.script_noteworthy);
          var_05 = scripts\cp\cp_weapon::get_weapon_level(var_08);
          if(var_05 > 1) {
            var_02 = 4500;
          } else {
            var_02 = var_02 * 0.5;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_perk(param_00)) {
      if(!var_01 scripts\cp\cp_interaction::can_use_perk(param_00)) {
        var_02 = 0;
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && param_00.perk_type == "perk_machine_revive" && var_01.self_revives_purchased <= var_01.max_self_revive_machine_use) {
        var_02 = 500;
      } else {
        var_02 = scripts\cp\cp_interaction::get_perk_machine_cost(param_00);
      }
    } else if(scripts\cp\cp_interaction::interaction_is_crafting_station(param_00)) {
      if(!isDefined(var_01.current_crafting_struct) && param_00.available_ingredient_slots > 0) {
        level notify("interaction", "purchase_denied", level.interactions[param_00.script_noteworthy], self);
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_ticket_buy(param_00)) {
      if(param_00.script_noteworthy == "large_ticket_prize") {
        var_04 = self getcurrentweapon();
        var_09 = strtok(var_04, "_");
        if(var_09[0] == "alt" && issubstr(var_04, "meleervn")) {
          continue;
        }

        var_0A = scripts\cp\utility::get_attachment_from_interaction(param_00);
        if(scripts\cp\utility::weaponhasattachment(self getcurrentweapon(), var_0A)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_ALREADY_HAVE");
          wait(0.1);
          continue;
        }

        if(!scripts\cp\cp_weapon::can_use_attachment(var_0A)) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_PILLAGE_CANT_USE");
          wait(0.1);
          continue;
        }
      } else if(param_00.script_noteworthy == "arcade_counter_grenade") {
        var_0B = scripts\cp\powers\coop_powers::what_power_is_in_slot("primary");
        if(self.powers[var_0B].charges >= level.powers[var_0B].maxcharges) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_EQUIPMENT_FULL");
          wait(0.1);
          continue;
        }
      } else if(param_00.script_noteworthy == "arcade_counter_ammo") {
        var_0C = self getcurrentweapon();
        if(self getweaponammostock(var_0C) >= weaponmaxammo(var_0C)) {
          var_0D = 1;
          if(weaponmaxammo(var_0C) == weaponclipsize(var_0C)) {
            if(self getweaponammoclip(var_0C) < weaponclipsize(var_0C)) {
              var_0D = 0;
            }
          }

          if(var_0D) {
            scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_GAME_PLAY_AMMO_MAX");
            wait(0.1);
            continue;
          }
        }
      }
    } else if(scripts\cp\cp_interaction::interaction_is_fortune_teller(param_00)) {
      if(!scripts\engine\utility::istrue(level.unlimited_fnf)) {
        if(var_01.card_refills == 2) {
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_NO_MORE_CARDS_OWNED");
          wait(0.1);
          continue;
        }
      }

      if(self.card_refills >= 1) {
        var_02 = level.fortune_visit_cost_2;
      } else {
        var_02 = level.fortune_visit_cost_1;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_grenade_wall_buy(param_00)) {
      if(!isDefined(param_00.power_name)) {
        param_00.power_name = param_00.script_noteworthy;
      }

      if(isDefined(self.powers[param_00.power_name]) && self.powers[param_00.power_name].charges >= level.powers[param_00.power_name].maxcharges) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_EQUIPMENT_FULL");
        wait(0.1);
        continue;
      }
    } else if(scripts\cp\cp_interaction::interaction_is_challenge_station(param_00)) {
      if(!isDefined(self.completed_challenges)) {
        var_02 = 0;
      } else if(scripts\engine\utility::array_contains(self.completed_challenges, param_00.script_type)) {
        var_02 = 0;
      } else {
        var_02 = 0;
      }
    }

    if(!scripts\cp\cp_interaction::can_purchase_interaction(param_00, var_02, level.interactions[param_00.script_noteworthy].spend_type)) {
      level notify("interaction", "purchase_denied", level.interactions[param_00.script_noteworthy], self);
      if(param_00.script_parameters == "tickets") {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"CP_ZMB_INTERACTIONS_NEED_TICKETS");
        thread scripts\cp\cp_vo::try_to_play_vo("no_tickets", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
      } else if((scripts\cp\utility::isplayingsolo() || level.only_one_player) && scripts\cp\cp_interaction::interaction_is_perk(param_00) && param_00.perk_type == "perk_machine_revive" && var_01.self_revives_purchased >= var_01.max_self_revive_machine_use) {
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_CANNOT_BUY_SELF_REVIVE");
      } else {
        thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 10, 0, 0, 1, 50);
        scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_NEED_MONEY");
      }

      wait(0.1);
      continue;
    }

    if(param_00.script_noteworthy == "atm_withdrawal") {
      if(isDefined(level.atm_transaction_amount)) {
        if(level.atm_amount_deposited < level.atm_transaction_amount) {
          thread scripts\cp\cp_vo::try_to_play_vo("no_cash", "zmb_comment_vo", "high", 30, 0, 0, 1, 50);
          scripts\cp\cp_interaction::interaction_show_fail_reason(param_00, &"COOP_INTERACTIONS_NEED_MONEY");
          wait(0.1);
          continue;
        }
      }
    }

    thread scripts\cp\cp_interaction::interaction_post_activate_delay(param_00);
    if(scripts\cp\cp_interaction::interaction_is_weapon_buy(param_00)) {
      level notify("interaction", param_00.name, undefined, self);
    } else {
      level notify("interaction", "purchase", level.interactions[param_00.script_noteworthy], self);
    }

    if(param_00.script_parameters == "tickets") {
      self.num_tickets = self.num_tickets - var_02;
      self setclientomnvar("zombie_number_of_ticket", int(self.num_tickets));
      self notify("spent_tickets_notify", var_02);
      if(isDefined(param_00.randomintrange) && isDefined(param_00.randomintrange.model)) {
        self.itempicked = param_00.randomintrange.model;
      } else {
        self.itempicked = param_00.script_noteworthy;
      }

      level.transactionid = randomint(100);
      scripts\cp\zombies\zombie_analytics::log_item_purchase_with_tickets(level.wave_num, self.itempicked, level.transactionid);
      thread scripts\cp\cp_vo::try_to_play_vo("purchase_tickets", "zmb_comment_vo", "medium", 2, 0, 0, 1, 40);
      level thread[[level.interactions[param_00.script_noteworthy].activation_func]](param_00, self);
      scripts\cp\cp_interaction::interaction_post_activate_update(param_00);
      wait(0.1);
      return;
    }

    var_0E = level.interactions[param_00.script_noteworthy].spend_type;
    thread scripts\cp\cp_interaction::take_player_money(var_02, var_0E);
    level thread[[level.interactions[param_00.script_noteworthy].activation_func]](param_00, self);
    if(scripts\cp\cp_interaction::interaction_is_souvenir(param_00)) {
      level thread scripts\cp\cp_interaction::souvenir_team_splash(param_00.script_noteworthy, self);
    }

    scripts\cp\cp_interaction::interaction_post_activate_update(param_00);
    wait(0.1);
    param_00.triggered = undefined;
  }
}