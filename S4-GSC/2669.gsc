/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2669.gsc
*************************************************/

init() {
  level thread _id_0A6B::_id_C10F();
  level thread _id_0A6B::_id_EB47();
  level thread _id_0A6B::_id_DD73();
  level thread _id_0A6B::_id_84E9();
  level._id_AFCD = [];
  level._id_9DD3 = [];
  level._id_CF95 = [];
  level._id_AFFB = [];
  level._id_B000 = [];
  level._id_5853 = [];
  level._id_9DD5 = [];
  _id_C2B1("specialty_healer", _id_0A6B::_id_D5A1, _id_0A6B::_id_FAA4, ["specialty_regenfaster", "specialty_regen_delay_reduced"]);
  _id_C2B1("specialty_survivor", _id_0A6B::_id_D703, _id_0A6B::_id_FB0E, ["specialty_blastshield"]);
  _id_C2B1("specialty_support", _id_0A6B::_id_D700, _id_0A6B::_id_FB0C, ["specialty_offhand_provider"]);
  _id_C2B1("specialty_demolitions", _id_0A6B::_id_D50E, _id_0A6B::_id_FA7D, ["specialty_extra_deadly"]);
  _id_C2B1("specialty_stealth", _id_0A6B::_id_D6EF, _id_0A6B::_id_FB07, ["specialty_ghost", "specialty_spygame"]);
  _id_C2B1("specialty_munitions", _id_0A6B::_id_D604, _id_0A6B::_id_FAC1, ["specialty_twoprimaries"]);
  _id_C2B1("specialty_spotter", _id_0A6B::_id_D6E6, _id_0A6B::_id_FB04, ["specialty_ads_mark_target", "specialty_engineer", "specialty_kill_report"]);
  _id_C2B1("specialty_tank", _id_0A6B::_id_D709, _id_0A6B::_id_FB13);
  _id_C2B1("specialty_breacher", _id_0A6B::_id_D4A5, _id_0A6B::_id_FA63);
  _id_C2B1("specialty_intel", _id_0A6B::_id_D5BC, _id_0A6B::_id_FAAB);
  _id_C2B1("specialty_hunter", _id_0A6B::_id_D5AB, _id_0A6B::_id_FAA7);
  _id_C2B1("specialty_revive_use_weapon", _id_0A6B::_id_D6A8, _id_0A6B::_id_FAE9, ["specialty_medic"]);
  _id_C2B1("specialty_ability_selfrevive", undefined, undefined, ["specialty_pistoldeath"]);
  _id_C2B1("specialty_door_breach", _id_0A6B::_id_D532, _id_0A6B::_id_FA83);
  _id_C2B1("specialty_ability_deploycover");
  _id_C2B1("specialty_rugged_eqp", _id_0A6B::_id_D6AF, _id_0A6B::_id_FAED, ["specialty_extra_planted_equipment"]);
  _id_C2B1("specialty_extra_planted_equipment");
  _id_C2B1("specialty_ability_empdrone");
  _id_C2B1("specialty_ability_deadsilence");
  _id_C2B1("specialty_ability_supportbox");
  _id_C2B1("specialty_ability_trophy");
  _id_C2B1("specialty_ability_recondrone");
  _id_C2B1("specialty_ability_tacinsert");
  _id_C2B1("specialty_ability_ammodrop");
  _id_C2B1("specialty_blastshield", _id_0A6B::_id_D49A, _id_0A6B::_id_FA5D);
  _id_C2B1("specialty_engineer", _id_0A6B::_id_D540, _id_0A6B::_id_FA88, ["specialty_outlinekillstreaks"]);
  _id_C2B1("specialty_strategist", undefined, undefined, ["specialty_killstreak_to_scorestreak", "specialty_br_better_mission_rewards"]);
  _id_C2B1("specialty_munitions_2", undefined, undefined, ["specialty_twoprimaries"]);
  _id_C2B1("specialty_surveillance", undefined, undefined, ["specialty_sixth_sense"]);
  _id_C2B1("specialty_guerrilla", undefined, undefined, ["specialty_ghost", "specialty_heartbreaker"]);
  _id_C2B1("specialty_tune_up", undefined, undefined, ["specialty_improved_field_upgrades", "specialty_faster_field_upgrade", "specialty_br_faster_revive"]);
  _id_C2B1("specialty_restock", undefined, undefined, ["specialty_recharge_equipment"]);
  _id_C2B1("specialty_hustle", undefined, undefined, ["specialty_supersprint_enhanced", "specialty_fastcrouchmovement"]);
  _id_C2B1("specialty_tactical_recon", undefined, undefined, ["specialty_engineer", "specialty_markequipment", "specialty_hack"]);
  _id_C2B1("specialty_tac_resist", undefined, undefined, ["specialty_stun_resistance", "specialty_emp_resist", "specialty_gas_grenade_resist", "specialty_scrambler_resist", "specialty_snapshot_immunity"]);
  _id_C2B1("specialty_heavy_metal", undefined, undefined, ["specialty_chain_killstreaks", "specialty_br_extra_killstreak_chance"]);
  _id_C2B1("specialty_scavenger_plus", undefined, undefined, ["specialty_scavenger"]);
  _id_C2B1("specialty_hardline", _id_0A6B::_id_D589, _id_0A6B::_id_FAA0, ["specialty_br_cheaper_kiosk"]);
  _id_C2B1("specialty_extra_shrapnel", undefined, undefined, ["specialty_extra_deadly", "specialty_shrapnel"]);
  _id_C2B1("specialty_covert_ops", undefined, undefined, ["specialty_blindeye", "specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget", "specialty_sixth_sense_immune"]);
  _id_C2B1("specialty_eod", undefined, undefined, ["specialty_blastshield", "specialty_throwback", "specialty_shrapnel_resist"]);
  _id_C2B1("specialty_huntmaster", undefined, undefined, ["specialty_tracker", "specialty_kill_report", "specialty_silentkill"]);
  _id_C2B1("specialty_warhead", undefined, undefined, ["specialty_quickswap", "specialty_fastreload_launchers"]);
  _id_C2B1("specialty_quick_fix", undefined, undefined, ["specialty_reduce_regen_delay_on_kill", "specialty_reduce_regen_delay_on_objective"]);
  _id_C2B1("specialty_mercenary", undefined, undefined, ["specialty_bounty"]);
  _id_C2B1("specialty_sonar", undefined, undefined, ["specialty_always_minimap"]);
  _id_C2B1("specialty_graverobber", undefined, undefined, ["specialty_scrap_weapons"]);
  _id_C2B1("specialty_specialist_bonus", _id_0A6B::_id_D6DF, _id_0A6B::_id_FB02);
  _id_C2B1("specialty_killstreak_to_scorestreak", _id_0A6B::_id_D5D3, _id_0A6B::_id_FAB1);
  _id_C2B1("specialty_improved_field_upgrades");
  _id_C2B1("specialty_recharge_equipment", _id_0A6B::_id_D699, _id_0A6B::_id_FADF);
  _id_C2B1("specialty_super_sprint_kill_refresh");
  _id_C2B1("specialty_markequipment", _id_0A6B::_id_D5F1, _id_0A6B::_id_FABB);
  _id_C2B1("specialty_chain_killstreaks", _id_0A6B::_id_D4BD, _id_0A6B::_id_FA69);
  _id_C2B1("specialty_scrap_weapons", _id_0A6B::_id_D6BC, _id_0A6B::_id_FAF6);
  _id_C2B1("specialty_door_alarm", _id_0A6B::_id_D531, _id_0A6B::_id_FA82);
  _id_C2B1("specialty_always_minimap", _id_0A6B::_id_D46D, _id_0A6B::_id_FA4F);
  _id_C2B1("specialty_shrapnel");
  _id_C2B1("specialty_team_scavenger");
  _id_C2B1("specialty_fastreload_launchers", _id_0A6B::_id_D55C, _id_0A6B::_id_FA92);
  _id_C2B1("specialty_emp_resist");
  _id_C2B1("specialty_sixth_sense_immune");
  _id_C2B1("specialty_shrapnel_resist");
  _id_C2B1("specialty_reduce_regen_delay_on_kill");
  _id_C2B1("specialty_reduce_regen_delay_on_objective", _id_0A6B::_id_D69E, _id_0A6B::_id_FAE2);
  _id_C2B1("specialty_scrambler_resist");
  _id_C2B1("specialty_no_battle_chatter");
  _id_C2B1("specialty_br_cheaper_kiosk");
  _id_C2B1("specialty_br_faster_revive");
  _id_C2B1("specialty_br_better_mission_rewards", _id_0A6B::_id_D498, _id_0A6B::_id_FA5B);
  _id_C2B1("specialty_br_extra_killstreak_chance");
  _id_C2B1("specialty_regenfaster", _id_0A6B::_id_D6A2, _id_0A6B::_id_FAE6);
  _id_C2B1("specialty_medic");
  _id_C2B1("specialty_regen_delay_reduced", _id_0A6B::_id_D69C, _id_0A6B::_id_FAE0);
  _id_C2B1("specialty_can_be_revived");
  _id_C2B1("specialty_kill_report");
  _id_C2B1("specialty_ads_mark_target", _id_0A6B::_id_D464, _id_0A6B::_id_FA4B);
  _id_C2B1("specialty_armorvest", _id_0A6B::_id_D482, _id_0A6B::_id_FA50);
  _id_C2B1("specialty_tracker", _id_0A6B::_id_D732, _id_0A6B::_id_FB1D, ["specialty_tracker_pro"]);
  _id_C2B1("specialty_ghost", _id_0A6B::_id_D575, _id_0A6B::_id_FA9A, ["specialty_gpsjammer"]);
  _id_C2B1("specialty_helmet", _id_0A6B::_id_D5A5, _id_0A6B::_id_FAA5);
  _id_C2B1("specialty_ladder", _id_0A6B::_id_D5D8, _id_0A6B::_id_FAB4);
  _id_C2B1("specialty_extra_deadly", _id_0A6B::_id_D54D, _id_0A6B::_id_FA8D);
  _id_C2B1("specialty_remote_defuse", _id_0A6B::_id_D6A6, _id_0A6B::_id_FAE7);
  _id_C2B1("specialty_hack");
  _id_C2B1("specialty_faster_field_upgrade");
  _id_C2B1("specialty_improved_target_mark");
  _id_C2B1("specialty_door_sense", _id_0A6B::_id_D533, _id_0A6B::_id_FA84);
  _id_C2B1("specialty_worsenedgunkick", _id_0A6B::_id_D8F3, _id_0A6B::_id_FB26);
  _id_C2B1("specialty_ammo_disabling");
  _id_C2B1("specialty_location_marking", _id_0A6B::_id_D5E6, _id_0A6B::_id_FAB9);
  _id_C2B1("specialty_br_highalert", undefined, undefined, ["specialty_sixth_sense"]);
  _id_C2B1("specialty_br_spotter", undefined, undefined, ["specialty_engineer"]);
  _id_C2B1("specialty_br_tracker", undefined, undefined, ["specialty_tracker_pro"]);
  _id_C2B1("specialty_br_stalker", undefined, undefined, ["specialty_stalker"]);
  _id_C2B1("specialty_br_marksman", undefined, undefined, ["specialty_marksman"]);
  _id_C2B1("specialty_br_sleightofhand", undefined, undefined, ["specialty_fastreload"]);
  _id_C2B1("specialty_br_healer", undefined, undefined);
  _id_C2B1("specialty_br_ammoscavenger", undefined, undefined);
  _id_C2B1("specialty_br_armorscavenger", undefined, undefined);
  _id_C2B1("specialty_br_bountyhunter", _id_0A6B::_id_D4A3, _id_0A6B::_id_FA61);
  _id_C2B1("specialty_br_medicscavenger", undefined, undefined);
  _id_C2B1("specialty_br_plunderscavenger", undefined, undefined);
  _id_C2B1("specialty_br_ghost", undefined, undefined, ["specialty_gpsjammer"]);
  _id_C2B1("specialty_br_sneaky", undefined, undefined, ["specialty_hunter"]);
  _id_C2B1("specialty_br_eod", undefined, undefined, ["specialty_blastshield", "specialty_hack", "specialty_throwback", "specialty_shrapnel_resist"]);
  _id_C2B1("specialty_van_demolition", _id_0A6B::_id_D8D6, _id_0A6B::_id_FB21, ["specialty_extra_deadly", "specialty_missileprediction"]);
  _id_C2B1("specialty_van_demolition_sniper");
  _id_C2B1("specialty_van_demolition_mg");
  _id_C2B1("specialty_scout", _id_0A6B::_id_D6B7, _id_0A6B::_id_FAF3, ["specialty_ghost"]);
  _id_C2B1("specialty_scout_spread_smg");
  _id_C2B1("specialty_scout_rifle_sniper");
  _id_C2B1("specialty_scout_mg");
  _id_C2B1("specialty_operator", _id_0A6B::_id_D629, _id_0A6B::_id_FAC6, ["specialty_munitions_2", "specialty_quickswap", "specialty_sprintreload"]);
  _id_C2B1("specialty_tactician", _id_0A6B::_id_D706, _id_0A6B::_id_FB11, ["specialty_recharge_equipment"]);
  _id_C2B1("specialty_extra_tactical", _id_0A6B::_id_D554, _id_0A6B::_id_FA90);
  _id_C2B1("specialty_tactical_outline", _id_0A6B::_id_D705, _id_0A6B::_id_FB10);
  _id_C2B1("specialty_reaper", _id_0A6B::_id_D697, _id_0A6B::_id_FADD, ["specialty_chain_killstreaks"]);
  _id_C2B1("specialty_clandestine", _id_0A6B::_id_D4D2, _id_0A6B::_id_FA6A, ["specialty_scavenger", "specialty_radarpingonspawn"]);
  _id_C2B1("specialty_radarpingonspawn", _id_0A6B::_id_D696, _id_0A6B::_id_FADC);
  _id_C2B1("specialty_gasmask");
  _id_C2B1("specialty_grenadearc", _id_0A6B::_id_D57C, _id_0A6B::_id_FA9B);
  _id_C2B1("specialty_explosive_recon", undefined, undefined, ["specialty_tactical_outline"]);
  _id_C2B1("specialty_tac_mask", undefined, undefined, ["specialty_stun_resistance", "specialty_emp_resist", "specialty_scrambler_resist", "specialty_snapshot_immunity", "specialty_gasmask"]);
  _id_C2B1("specialty_code_breaker", undefined, undefined, ["specialty_showspawns", "specialty_expanded_minimap"]);
  _id_C2B1("specialty_piercing_vision");
  _id_C2B1("specialty_intuition", _id_0A6B::_id_D5BE, _id_0A6B::_id_FAAC);
  _id_C2B1("specialty_runner", _id_0A6B::_id_D6B0, _id_0A6B::_id_FAEE);
  _id_C2B1("specialty_asdic", undefined, undefined, ["specialty_showweaponpings"]);
  _id_C2B1("specialty_vanguard", _id_0A6B::_id_D8D9, _id_0A6B::_id_FB22);
  _id_C2B1("specialty_coolheaded", _id_0A6B::setcoolheaded, _id_0A6B::unsetcoolheaded, ["specialty_sixth_sense_immune", "specialty_heartbreaker", "specialty_noplayertarget", "specialty_noscopeoutline", "specialty_blindeye", "specialty_awareness_box_reduce", "specialty_showspawns_jammer"]);
  _id_C2B1("specialty_serpentine");
  _id_C2B1("specialty_dauntless", _id_0A6B::_id_D4FC, _id_0A6B::_id_FA7B);
  _id_C2B1("specialty_van_lightweight", undefined, undefined, ["specialty_lightweight"]);
  _id_C2B1("specialty_brawler", _id_0A6B::_id_D4A4, _id_0A6B::_id_FA62);
  _id_C2B1("specialty_command");
  _id_C2B1("specialty_informed");
  _id_C2B1("specialty_tactical");
  _id_C2B1("specialty_low_profile", undefined, undefined, ["specialty_awareness_box_reduce"]);
  _id_C2B1("specialty_ninja", undefined, undefined, ["specialty_quieter", "specialty_no_battle_chatter", "specialty_featherfall", "specialty_tracker_jammer"]);
  _id_C2B1("specialty_armory", undefined, undefined, ["specialty_fastoffhand_equipment"]);
  _id_C2B1("specialty_evasive", _id_0A6B::setevasive, _id_0A6B::unsetevasive);
  _id_C2B1("specialty_mechanic", undefined, undefined, ["specialty_tune_up"]);
  _id_C2B1("specialty_featherfall");
  _id_C2B1("specialty_aware");
  _id_C2B1("specialty_perceptive");
  _id_C2B1("specialty_tier1_wip1");
  _id_C2B1("specialty_tier1_wip2");
  _id_C2B1("specialty_tier1_wip3");
  _id_C2B1("specialty_tier2_wip1");
  _id_C2B1("specialty_tier3_wip1");
  _id_C2B1("specialty_disable");
  _id_C2B1("specialty_quick", _id_0A6B::_id_D690, _id_0A6B::_id_FAD9);
  _id_C2B1("specialty_ammomod_frangible", undefined, undefined, ["specialty_delayhealing", "specialty_ammo_disabling"]);
  _id_C2B1("specialty_vital");
  _id_C2B1("specialty_shrouded", undefined, undefined, ["specialty_glintreduce"]);
  _id_C2B1("specialty_silent_focus", _id_0A6B::_id_D6C9, _id_0A6B::_id_FAF9);
  _id_C2B1("specialty_tight_grip", _id_0A6B::_id_D725, _id_0A6B::_id_FB1B);
  _id_C2B1("specialty_quickscope", _id_0A6B::_id_D691, _id_0A6B::_id_FADA);
  _id_C2B1("specialty_hardscope", _id_0A6B::_id_D58A, _id_0A6B::_id_FAA1);
  _id_C2B1("specialty_nervesofsteel", _id_0A6B::_id_D606, _id_0A6B::_id_FAC2);
  _id_C2B1("specialty_panic", _id_0A6B::_id_D63B, _id_0A6B::_id_FACE);
  _id_C2B1("specialty_icyveins", undefined, undefined, ["specialty_nervesofsteel", "specialty_fastreload_injured"]);
  _id_C2B1("specialty_momentum", _id_0A6B::_id_D5FF, _id_0A6B::_id_FABF);
  _id_C2B1("specialty_awareness", undefined, undefined, ["specialty_ads_awareness_range", "specialty_marksman"]);
  _id_C2B1("specialty_afterburner", _id_0A6B::_id_D467, _id_0A6B::_id_FA4E, ["specialty_thruster"]);
  _id_C2B1("specialty_autospot", _id_0A6B::_id_D489, _id_0A6B::_id_FA54);
  _id_C2B1("specialty_boom", _id_0A6B::_id_D4A1, _id_0A6B::_id_FA60);
  _id_C2B1("specialty_delaymine", _id_0A6B::_id_D50A, _id_0A6B::_id_FA7C);
  _id_C2B1("specialty_dexterity", undefined, undefined, ["specialty_fastreload", "specialty_quickswap"]);
  _id_C2B1("specialty_hardwired", undefined, undefined, ["specialty_tracker_jammer", "specialty_noscopeoutline", "specialty_empimmune"]);
  _id_C2B1("specialty_empimmune", _id_0A6B::_id_D53A, _id_0A6B::_id_FA86);
  _id_C2B1("specialty_extraammo", _id_0A6B::_id_D54B, _id_0A6B::_id_FA8C);
  _id_C2B1("specialty_falldamage", _id_0A6B::_id_D56C, _id_0A6B::_id_FA96);
  _id_C2B1("specialty_hard_shell", _id_0A6B::_id_D58C, _id_0A6B::_id_FAA2);
  _id_C2B1("specialty_powercell", _id_0A6B::_id_D686, _id_0A6B::_id_FAD7);
  _id_C2B1("specialty_incog", _id_0A6B::_id_D5B4, _id_0A6B::_id_FAAA);
  _id_C2B1("specialty_localjammer", _id_0A6B::_id_D5E5, _id_0A6B::_id_FAB8);
  _id_C2B1("specialty_overclock", _id_0A6B::_id_D62F, _id_0A6B::_id_FACA);
  _id_C2B1("specialty_outlinekillstreaks", _id_0A6B::_id_D62D, _id_0A6B::_id_FAC8);
  _id_C2B1("specialty_pitcher", _id_0A6B::_id_D653, _id_0A6B::_id_FAD6, ["specialty_throwback"]);
  _id_C2B1("specialty_stun_resistance", _id_0A6B::_id_D6F7, _id_0A6B::_id_FB09, ["specialty_hard_shell"]);
  _id_C2B1("specialty_twoprimaries", _id_0A6B::_id_D630, _id_0A6B::_id_FACB, []);
  _id_C2B1("specialty_bullet_outline", _id_0A6B::_id_D4A9, _id_0A6B::_id_FA64);
  _id_C2B1("specialty_activereload", _id_0A6B::_id_D460, _id_0A6B::_id_FA49);
  _id_C2B1("specialty_sixth_sense", _id_0A6B::_id_D6CA, _id_0A6B::_id_FAFA);
  _id_C2B1("specialty_enhanced_sixth_sense", _id_0A6B::_id_D541, _id_0A6B::_id_FA89);
  _id_C2B1("specialty_meleekill", _id_0A6B::_id_D5F6, _id_0A6B::_id_FABE);
  _id_C2B1("specialty_gung_ho");
  _id_C2B1("specialty_man_at_arms", _id_0A6B::_id_D5EC, _id_0A6B::_id_FABA, ["specialty_extraammo", "specialty_overrideweaponspeed"]);
  _id_C2B1("specialty_improvedmelee", _id_0A6B::_id_D5B2, _id_0A6B::_id_FAA8, ["specialty_extendedmelee", "specialty_fastermelee", "specialty_thief"]);
  _id_C2B1("specialty_thief", _id_0A6B::_id_D721, _id_0A6B::_id_FB18);
  _id_C2B1("specialty_silentkill");
  _id_C2B1("specialty_armorpiercing");
  _id_C2B1("specialty_armorpiercingks");
  _id_C2B1("specialty_fastcrouch", _id_0A6B::_id_D55A, _id_0A6B::_id_FA91);
  _id_C2B1("specialty_bulletdamage", undefined, undefined, ["specialty_overcharge", "specialty_worsenedgunkick"]);
  _id_C2B1("specialty_solobuddyboost", _id_0A6B::_id_D6D1, _id_0A6B::_id_FAFD);
  _id_C2B1("specialty_offhand_provider", _id_0A6B::_id_D623, _id_0A6B::_id_FAC4);
  _id_C2B1("specialty_glintreduce");
  _id_C2B1("specialty_gas_grenade_resist", _id_0A6B::_id_D574, _id_0A6B::_id_FA99);
  _id_C2B1("specialty_battleslide", _id_0A6B::_id_D493, _id_0A6B::_id_FA58);
  _id_C2B1("specialty_battleslide_offense", _id_0A6B::_id_D494, _id_0A6B::_id_FA59);
  _id_C2B1("specialty_battleslide_shield", _id_0A6B::_id_D495, _id_0A6B::_id_FA5A);
  _id_C2B1("specialty_disruptor_punch", _id_0A6B::_id_D515, _id_0A6B::_id_FA7E);
  _id_C2B1("specialty_ground_pound", _id_0A6B::_id_D57E, _id_0A6B::_id_FA9C);
  _id_C2B1("specialty_ground_pound_shield", _id_0A6B::_id_D580, _id_0A6B::_id_FA9E);
  _id_C2B1("specialty_ground_pound_shock", _id_0A6B::_id_D581, _id_0A6B::_id_FA9F);
  _id_C2B1("specialty_thruster", _id_0A6B::_id_D724, _id_0A6B::_id_FB1A);
  _id_C2B1("specialty_dodge", _id_0A6B::_id_D516, _id_0A6B::_id_FA7F);
  _id_C2B1("specialty_extra_dodge", _id_0A6B::_id_D54E, _id_0A6B::_id_FA8E);
  _id_C2B1("specialty_extend_dodge", _id_0A6B::_id_D54A, _id_0A6B::_id_FA8B);
  _id_C2B1("specialty_phase_slide", _id_0A6B::_id_D64D, _id_0A6B::_id_FAD3);
  _id_C2B1("specialty_tele_slide", _id_0A6B::_id_D71D, _id_0A6B::_id_FB16);
  _id_C2B1("specialty_phaseslash", undefined, undefined, ["specialty_phaseslash_rephase"]);
  _id_C2B1("specialty_phaseslash_rephase", _id_0A6B::_id_D64C, _id_0A6B::_id_FAD2);
  _id_C2B1("specialty_phase_fall", _id_0A6B::_id_D649, _id_0A6B::_id_FAD0);
  _id_C2B1("specialty_aura_quickswap", _id_0A6B::_id_D487, _id_0A6B::_id_FA52);
  _id_C2B1("specialty_aura_speed", _id_0A6B::_id_D488, _id_0A6B::_id_FA53);
  _id_C2B1("specialty_mark_targets", _id_0A6B::_id_D5F4, _id_0A6B::_id_FABD);
  _id_C2B1("specialty_batterypack", _id_0A6B::_id_D491, _id_0A6B::_id_FA57);
  _id_C2B1("specialty_camo_elite", _id_0A6B::_id_D4B0, _id_0A6B::_id_FA67);
  _id_C2B1("specialty_scorestreakpack", _id_0A6B::_id_D6B5, _id_0A6B::_id_FAF2);
  _id_C2B1("specialty_superpack", _id_0A6B::_id_D6FC, _id_0A6B::_id_FB0A);
  _id_C2B1("specialty_dodge_defense", _id_0A6B::_id_D517, _id_0A6B::_id_FA80);
  _id_C2B1("specialty_spawncloak", _id_0A6B::_id_D6D6, _id_0A6B::_id_FAFF);
  _id_C2B1("specialty_commando");
  _id_C2B1("specialty_personal_trophy", _id_0A6B::_id_D647, _id_0A6B::_id_FACF);
  _id_C2B1("specialty_equipment_ping", _id_0A6B::_id_D544, _id_0A6B::_id_FA8A, ["specialty_paint"]);
  _id_C2B1("specialty_cloak", _id_0A6B::_id_D4D4, _id_0A6B::_id_FA6B);
  _id_C2B1("specialty_wall_lock", _id_0A6B::_id_D8E4, _id_0A6B::_id_FB24);
  _id_C2B1("specialty_rush", _id_0A6B::_id_D6B1, _id_0A6B::_id_FAEF);
  _id_C2B1("specialty_hover", _id_0A6B::_id_D5A8, _id_0A6B::_id_FAA6);
  _id_C2B1("specialty_scavenger_eqp", _id_0A6B::_id_D6B3, _id_0A6B::_id_FAF1);
  _id_C2B1("specialty_spawnview", _id_0A6B::_id_D6DE, _id_0A6B::_id_FB01);
  _id_C2B1("specialty_headgear", _id_0A6B::_id_D58E, _id_0A6B::_id_FAA3);
  _id_C2B1("specialty_ftlslide", _id_0A6B::_id_D56F, _id_0A6B::_id_FA97);
  _id_C2B1("specialty_improved_prone", _id_0A6B::_id_D5B3, _id_0A6B::_id_FAA9);
  _id_C2B1("specialty_support_killstreaks", _id_0A6B::_id_D701, _id_0A6B::_id_FB0D);
  _id_C2B1("specialty_overrideweaponspeed", _id_0A6B::_id_D634, _id_0A6B::_id_FACD);
  _id_C2B1("specialty_cloak_aerial", _id_0A6B::_id_D4D5, _id_0A6B::_id_FA6C);
  _id_C2B1("specialty_spawn_radar", _id_0A6B::_id_D6DB, _id_0A6B::_id_FB00);
  _id_C2B1("specialty_ads_awareness", _id_0A6B::_id_D463, _id_0A6B::_id_FA4A);
  _id_C2B1("specialty_rearguard", _id_0A6B::_id_D698, _id_0A6B::_id_FADE);
  _id_C2B1("specialty_sharp_focus", _id_0A6B::_id_D6C6, _id_0A6B::_id_FAF7);
  _id_C2B1("specialty_bling");
  _id_C2B1("specialty_comexp", _id_0A6B::_id_D4DE, _id_0A6B::_id_FA72);
  _id_C2B1("specialty_paint");
  _id_C2B1("specialty_paint_pro");
  _id_C2B1("specialty_steadyaimpro", _id_0A6B::_id_D6EE, _id_0A6B::_id_FB06);
  _id_C2B1("specialty_block_health_regen", _id_0A6B::_id_D49C, _id_0A6B::_id_FA5F);
  _id_C2B1("specialty_rshieldradar", _id_0A6B::_id_D6AB, _id_0A6B::_id_FAEB);
  _id_C2B1("specialty_rshieldscrambler", _id_0A6B::_id_D6AD, _id_0A6B::_id_FAEC);
  _id_C2B1("specialty_delayhealing");
  _id_C2B1("specialty_hardmelee");
  _id_C2B1("specialty_combathigh", _id_0A6B::_id_D4DB, _id_0A6B::_id_FA6D);
  _id_C2B1("specialty_juiced", _id_0A6B::_id_D5C4, _id_0A6B::_id_FAAD);
  _id_C2B1("specialty_revenge", _id_0A6B::_id_D6A7, _id_0A6B::_id_FAE8);
  _id_C2B1("specialty_light_armor", _id_0A6B::_id_D5E1, _id_0A6B::_id_FAB6);
  _id_C2B1("specialty_carepackage", _id_0A6B::_id_D4B4, _id_0A6B::_id_FA68);
  _id_C2B1("specialty_stopping_power");
  _id_C2B1("specialty_uav", _id_0A6B::_id_D739, _id_0A6B::_id_FB20);
  _id_C2B1("specialty_viewkickoverride", _id_0A6B::_id_D8DE, _id_0A6B::_id_FB23);
  _id_C2B1("specialty_affinityspeedboost", _id_0A6B::_id_D466, _id_0A6B::_id_FA4D);
  _id_C2B1("specialty_affinityextralauncher", _id_0A6B::_id_D465, _id_0A6B::_id_FA4C);
  _id_C2B1("bouncingbetty_mp");
  _id_C2B1("s4_c4_mp");
  _id_C2B1("claymore_mp");
  _id_C2B1("s4_frag_usa_mk2_mp");
  _id_C2B1("s4_semtex_mp");
  _id_C2B1("cluster_grenade_mp");
  _id_C2B1("s4_throwing_knife_mp");
  _id_C2B1("throwingknifec4_mp");
  _id_C2B1("throwingknifeteleport_mp");
  _id_C2B1("throwingknifesmokewall_mp");
  _id_C2B1("proximity_explosive_mp");
  _id_C2B1("case_bomb_mp");
  _id_C2B1("throwingreaper_mp");
  _id_C2B1("transponder_mp");
  _id_C2B1("sonic_sensor_mp");
  _id_C2B1("sticky_mine_mp");
  _id_C2B1("throwingknifedisruptor_mp");
  _id_C2B1("pulse_grenade_mp");
  _id_C2B1("portal_grenade_mp");
  _id_C2B1("virus_grenade_mp");
  _id_C2B1("specialty_equip_throwingKnife", _id_0A6B::_id_D723, _id_0A6B::_id_FB19);
  _id_C2B1("s4_stun_gbr_n69_mp");
  _id_C2B1("sensor_grenade_mp");
  _id_C2B1("gravity_grenade_mp");
  _id_C2B1("flash_grenade_mp");
  _id_C2B1("s4_smoke_usa_m18_mp");
  _id_C2B1("emp_grenade_mp");
  _id_C2B1("specialty_tacticalinsertion", _id_0A6B::_id_D704, _id_0A6B::_id_FB0F);
  _id_C2B1("trophy_mp");
  _id_C2B1("motion_sensor_mp");
  _id_C2B1("mobile_radar_mp");
  _id_C2B1("blackout_grenade_mp");
  _id_C2B1("proxy_bomb_mp");
  _id_C2B1("splash_grenade_mp");
  _id_C2B1("forcepush_mp");
  _id_C2B1("ammo_box_mp");
  _id_C2B1("blackhat_mp");
  _id_C2B1("s4_hand_flare_mp");
  var_0 = _id_07FD::_id_6E91();

  foreach(var_2 in var_0) {
    level._id_CF95[var_2] = 1;
    var_3 = _id_07FD::_id_6C16(var_2);

    if(isDefined(var_3)) {
      level._id_5853[var_2] = [var_3];
    }
  }

  _id_C2B1("specialty_null");
  _id_C249("specialty_thermal", _id_0A6B::_id_D71F, _id_0A6B::_id_FB17);
  _id_C249("specialty_lightweight", _id_0A6B::_id_D5E3, _id_0A6B::_id_FAB7);
  _id_C249("specialty_steelnerves", _id_0A6B::_id_D6F3, _id_0A6B::_id_FB08);
  _id_C249("specialty_saboteur", _id_0A6B::_id_D6B2, _id_0A6B::_id_FAF0);
  _id_C249("specialty_endgame", _id_0A6B::_id_D53C, _id_0A6B::_id_FA87);
  _id_C249("specialty_onemanarmy", _id_0A6B::_id_D628, _id_0A6B::_id_FAC5);
  _id_C249("specialty_weaponlaser", _id_0A6B::_id_D8E6, _id_0A6B::_id_FB25);
  _id_C249("specialty_marksman", _id_0A6B::_id_D5F3, _id_0A6B::_id_FABC);
  _id_C249("specialty_holdbreath", undefined, undefined);
  _id_C249("specialty_fastermelee", undefined, undefined);
  _id_C249("specialty_double_load", _id_0A6B::_id_D534, _id_0A6B::_id_FA85);
  _id_C249("specialty_overkill_pro", _id_0A6B::_id_D631, _id_0A6B::_id_FACC);
  _id_C249("specialty_refill_grenades", _id_0A6B::_id_D6A0, _id_0A6B::_id_FAE4);
  _id_C249("specialty_refill_ammo", _id_0A6B::_id_D69F, _id_0A6B::_id_FAE3);
  _id_C249("specialty_combat_speed", _id_0A6B::_id_D4DC, _id_0A6B::_id_FA70);
  _id_C249("specialty_tagger", _id_0A6B::_id_D707, _id_0A6B::_id_FB12);
  _id_C249("specialty_triggerhappy", _id_0A6B::_id_D734, _id_0A6B::_id_FB1F);
  _id_C249("specialty_blindeye", _id_0A6B::_id_D49B, _id_0A6B::_id_FA5E);
  _id_C249("specialty_quickswap", _id_0A6B::_id_D693, _id_0A6B::_id_FADB, ["specialty_fastoffhand"]);
  _id_C249("specialty_extra_equipment", _id_0A6B::_id_D54F, _id_0A6B::_id_FA8F);
  _id_C249("specialty_lifepack", _id_0A6B::_id_D5DE, _id_0A6B::_id_FAB5);
  _id_C249("specialty_toughenup", _id_0A6B::_id_D72E, _id_0A6B::_id_FB1C);
  _id_C249("specialty_scoutping", _id_0A6B::_id_D6B8, _id_0A6B::_id_FAF4);
  _id_C249("specialty_phase_speed", _id_0A6B::_id_D64E, _id_0A6B::_id_FAD4);
  _id_C249("specialty_camo_clone", _id_0A6B::_id_D4AF, _id_0A6B::_id_FA66);
  _id_C249("specialty_improvedgunkick", undefined, undefined, ["specialty_reducedsway"]);
  _id_C249("specialty_overcharge", _id_0A6B::_id_D62E, _id_0A6B::_id_FAC9);
  _id_C249("specialty_supersprint_enhanced", _id_0A6B::_id_D6FD, _id_0A6B::_id_FB0B);
  _id_C249("specialty_noscopeoutline", _id_0A6B::_id_D60F, _id_0A6B::_id_FAC3);
  _id_C249("specialty_snapshot_immunity");
  _id_8254();
  _id_9DD4();
  _id_9DD2();
  _id_8256();
  level thread onplayerconnect();
}

_id_C2B1(var_0, var_1, var_2, var_3) {
  _id_C298(var_0, 1, var_1, var_2, var_3);
}

_id_C249(var_0, var_1, var_2, var_3) {
  _id_C298(var_0, 0, var_1, var_2, var_3);
}

_id_C298(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_1)) {
    level._id_CF95[var_0] = 1;
  }

  if(isDefined(var_2)) {
    level._id_AFFB[var_0] = var_2;
  }

  if(isDefined(var_3)) {
    level._id_B000[var_0] = var_3;
  }

  if(isDefined(var_4)) {
    level._id_5853[var_0] = var_4;
  }
}

_id_9DD4() {
  if(!isDefined(level._id_9DD5)) {
    level._id_9DD5 = [];
  }

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/menuRigPerks.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/menuRigPerks.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp/menuRigPerks.csv", var_0, 2);
    var_4 = spawnStruct();
    var_4._id_7C8C = var_1;
    var_4._id_C189 = var_3;
    var_4._id_1A35 = var_2;

    if(!isDefined(level._id_9DD5[var_3])) {
      level._id_9DD5[var_3] = var_4;
    }

    var_0++;
  }
}

_id_9DD2() {
  if(!isDefined(level._id_9DD3)) {
    level._id_9DD3 = [];
  }

  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/menuPerks.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/menuPerks.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp/menuPerks.csv", var_0, 2);
    var_4 = tablelookupbyrow("mp/menuPerks.csv", var_0, 3) == "1";
    var_5 = spawnStruct();
    var_5.name = var_3;
    var_5._id_C189 = var_3;
    var_5._id_DDEF = var_2;
    var_5._id_8B15 = var_4;

    if(!isDefined(level._id_9DD3[var_3])) {
      level._id_9DD3[var_3] = var_5;
    }

    var_0++;
  }
}

_id_8256() {
  if(!isDefined(level._id_AFFD)) {
    level._id_AFFD = [];
  }

  level._id_AFF9 = [];
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow("mp/perkTable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/perkTable.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp/perkTable.csv", var_0, 16);
    var_4 = tablelookupbyrow("mp/perkTable.csv", var_0, 17);
    var_5 = spawnStruct();
    var_5._id_C189 = var_2;
    var_5._id_7C8C = int(var_1);
    var_5._id_E3CE = int(var_3);

    if(var_4 != "") {
      game["dialog"][var_2] = var_4;
    }

    if(!isDefined(level._id_AFFD[var_2])) {
      level._id_AFFD[var_2] = var_5;
    }

    level._id_AFF9[var_5._id_7C8C] = var_5._id_C189;
    var_0++;
  }
}

_id_8297() {
  scripts\mp\killstreaks\killstreaks::_id_C26A("specialist_perk_1", undefined, ::_id_ABA8);
  scripts\mp\killstreaks\killstreaks::_id_C26A("specialist_perk_2", undefined, ::_id_ABA8);
  scripts\mp\killstreaks\killstreaks::_id_C26A("specialist_perk_3", undefined, ::_id_ABA8);
  scripts\mp\killstreaks\killstreaks::_id_C26A("specialist_perk_bonus", undefined, ::_id_ABA7);
}

_id_ABA8(var_0) {
  var_1 = _id_6D68(var_0.streakname);
  scripts\mp\utility\perk::_id_6FC2(var_1);
}

_id_6D68(var_0) {
  var_1 = _id_6D67(var_0);

  if(var_1 == -1) {
    return undefined;
  }

  return self._id_3808._id_9670[var_1];
}

_id_6D67(var_0) {
  if(!isDefined(var_0)) {
    return -1;
  }

  if(var_0 == "specialist_perk_1") {
    return 0;
  } else if(var_0 == "specialist_perk_2") {
    return 1;
  } else if(var_0 == "specialist_perk_3") {
    return 2;
  } else {
    return -1;
  }
}

_id_8A53(var_0) {
  switch (var_0) {
    case "specialist_perk_bonus":
    case "specialist_perk_3":
    case "specialist_perk_2":
    case "specialist_perk_1":
      return 1;
    default:
      return 0;
  }
}

_id_ABA7(var_0) {
  foreach(var_2 in level._id_AFFD) {
    if(istrue(var_2._id_E3CE) && !_func_0419(var_2._id_C189)) {
      scripts\mp\utility\perk::_id_6FC2(var_2._id_C189);
    }
  }

  scripts\mp\utility\perk::_id_6FC2("specialty_fastreload");
  scripts\mp\utility\perk::_id_6FC2("specialty_specialist_bonus");
  scripts\mp\utility\perk::_id_6FC2("specialty_lightweight");
}

_id_68EB() {
  var_0 = [];

  foreach(var_2 in level._id_9DD3) {
    if(scripts\mp\utility\perk::_hasperk(var_2.name)) {
      continue;
    }
    var_0[var_0.size] = var_2.name;
  }

  return var_0;
}

_id_6C27(var_0) {
  var_1 = level._id_9DD3[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return int(var_1._id_DDEF);
}

_id_FF50(var_0) {
  if(!scripts\mp\utility\perk::_id_AFFA()) {
    var_0 = "specialty_null";
  } else {
    switch (var_0) {
      case "specialty_corpse_steal":
      case "specialty_chain_reaction":
      case "specialty_deadeye":
      case "specialty_gambler":
      case "specialty_selectivehearing":
      case "specialty_detectexplosive":
      case "specialty_quickdraw":
      case "specialty_bulletaccuracy":
      case "specialty_marathon":
      case "specialty_fastsprintrecovery":
      case "perkpackage_spotter":
      case "perkpackage_munitions":
      case "perkpackage_stealth":
      case "perkpackage_demolitions":
      case "perkpackage_support":
      case "perkpackage_survivor":
      case "perkpackage_healer":
      case "specialty_reducedsway":
      case "specialty_null":
      case "specialty_comexp":
      case "specialty_sharp_focus":
      case "specialty_paint":
      case "specialty_superpack":
      case "specialty_scorestreakpack":
      case "specialty_batterypack":
      case "specialty_extend_dodge":
      case "specialty_extra_dodge":
      case "specialty_battleslide":
      case "specialty_gung_ho":
      case "specialty_activereload":
      case "specialty_pitcher":
      case "specialty_falldamage":
      case "specialty_extraammo":
      case "specialty_boom":
      case "specialty_quieter":
      case "specialty_lightweight":
      case "specialty_fastreload":
      case "specialty_stalker":
      case "specialty_location_marking":
      case "specialty_door_sense":
      case "specialty_improved_target_mark":
      case "specialty_extra_deadly":
      case "specialty_demolitions":
      case "specialty_quickswap":
      case "specialty_door_breach":
      case "specialty_ads_mark_target":
      case "specialty_tank":
      case "specialty_kill_report":
      case "specialty_spotter":
      case "specialty_intel":
      case "specialty_breacher":
      case "specialty_munitions":
      case "specialty_healer":
      case "specialty_twoprimaries":
      case "specialty_offhand_provider":
      case "specialty_support":
      case "specialty_sixth_sense":
      case "specialty_remote_defuse":
      case "specialty_gpsjammer":
      case "specialty_can_be_revived":
      case "specialty_stun_resistance":
      case "specialty_hack":
      case "specialty_stealth":
      case "specialty_silentkill":
      case "specialty_blindeye":
      case "specialty_hardline":
      case "specialty_scavenger":
      case "specialty_medic":
      case "specialty_hunter":
      case "specialty_faster_field_upgrade":
      case "specialty_blastshield":
      case "specialty_survivor":
      case "specialty_regenfaster":
        break;
      default:
        var_0 = "specialty_null";
        break;
    }
  }

  return var_0;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.perks = [];
    var_0._id_AFF8 = [];
    var_0.weaponlist = [];
  }
}

_id_8254() {
  level._id_7117 = 0.08;
  level._id_1B5C = 1.5;
  level._id_1B5D = 1.25;
  level._id_C1BE = scripts\mp\utility\dvars::_id_6AC8("#x3261d608d3bfa5796", 2);
  level._id_2544 = scripts\mp\utility\dvars::_id_6AC8("#x35ea41e86cb3866b6", 65) / 100;
  level._id_2543 = scripts\mp\utility\dvars::_id_6AC8("#x34ab4963bb71b7b13", 80);
  level._id_C886 = scripts\mp\utility\dvars::_id_6AC8("#x3a421b30985e58dae", 100) / 100;
  level._id_1B72 = scripts\mp\utility\dvars::_id_6AC8("#x3958db59659bc49de", 1);
  level._id_9F3E = scripts\mp\utility\dvars::_id_6AC8("#x3d8f52ed5abddc598", 100);
  level._id_9EB6 = scripts\mp\utility\dvars::_id_6AC8("#x38240402176704c6a", 10);
  level._id_F240 = scripts\mp\utility\dvars::_id_6AC8("#x36b968acf923b010f", 200) / 1000;
  level._id_9F3F = level._id_9F3E * level._id_9F3E;
  level._id_9EB8 = level._id_9EB6 * level._id_9EB6;

  if(isDefined(level._id_74C4) && level._id_74C4) {
    level._id_2544 = scripts\mp\utility\dvars::_id_6AC8("#x320d58265df4279ce", 20) / 100;
    level._id_2543 = scripts\mp\utility\dvars::_id_6AC8("#x3b0ae8d7bcdd64925", 20);
  }

  if(scripts\mp\utility\game::_id_875E()) {
    level._id_2544 = scripts\mp\utility\dvars::_id_509C("blastShieldMod", 65, 0, 100) / 100;
    level._id_2543 = scripts\mp\utility\dvars::_id_509C("blastShieldClamp", 80, 0, 100);
  }
}

_id_6FC5(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 1);

  foreach(var_3 in var_0) {
    if(var_1) {
      var_3 = _id_FF50(var_3);
    }

    if(var_3 != "specialty_null") {
      scripts\mp\class::_id_9630(var_3);
    }
  }
}

_setperk(var_0) {
  if(!isDefined(self.perks)) {
    self.perks = [];
  }

  if(!isDefined(self.perks[var_0])) {
    self.perks[var_0] = 1;
  } else {
    self.perks[var_0]++;
  }

  if(self.perks[var_0] == 1 && !isDefined(self._id_AFF8[var_0])) {
    _id_0CED(var_0);
  }
}

_id_0CED(var_0) {
  var_1 = level._id_AFFB[var_0];

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  self _meth_8361(var_0, !isDefined(level._id_CF95[var_0]));
}

_id_0CE9(var_0) {
  if(isDefined(level._id_5853[var_0])) {
    foreach(var_2 in level._id_5853[var_0]) {
      _setperk(var_2);
      _id_0CE9(var_2);
    }
  }
}

_id_0DA0(var_0) {
  if(isDefined(level._id_5853[var_0])) {
    foreach(var_2 in level._id_5853[var_0]) {
      _unsetperk(var_2);
      _id_0DA0(var_2);
    }
  }
}

_unsetperk(var_0) {
  if(!isDefined(self.perks[var_0])) {
    return;
  }
  self.perks[var_0]--;

  if(self.perks[var_0] == 0) {
    if(!isDefined(self._id_AFF8[var_0])) {
      _id_0DA2(var_0);
    }

    self.perks[var_0] = undefined;
  }
}

_id_0DA2(var_0) {
  if(isDefined(level._id_B000[var_0])) {
    self thread[[level._id_B000[var_0]]]();
  }

  self _meth_8418(var_0, !isDefined(level._id_CF95[var_0]));
}

_clearperks() {
  if(isDefined(self.perks)) {
    foreach(var_2, var_1 in self.perks) {
      if(isDefined(level._id_B000[var_2])) {
        self[[level._id_B000[var_2]]]();
      }
    }
  }

  self.perks = [];
  self._id_AFF8 = [];
  self clearperks();
}

_id_C4D5(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(_id_FF50(var_3) != "specialty_null") {
      var_1[var_1.size] = var_3;
    }
  }

  return var_1;
}

_id_6FC6() {
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self endon("giveLoadout_start");
  self endon("loadout_perks_cleared");
  scripts\mp\class::_id_9630("specialty_blindeye");
  scripts\mp\class::_id_9630("specialty_gpsjammer");
  scripts\mp\class::_id_9630("specialty_noscopeoutline");
  scripts\mp\class::_id_9630("specialty_gas_grenade_resist");

  if(self._id_1FAF > 0) {
    var_0 = self._id_1FAF;

    if(istrue(self._id_82F0)) {
      var_0 = var_0 + _id_0815::_id_6D41();
    }

    wait(var_0);
  }

  if(scripts\mp\utility\killstreak::_id_8992(self) && isDefined(self._id_B75E) && isalive(self._id_B75E)) {
    return;
  } else {
    scripts\mp\class::_id_9636("specialty_blindeye");
    scripts\mp\class::_id_9636("specialty_gpsjammer");
    scripts\mp\class::_id_9636("specialty_noscopeoutline");
    scripts\mp\class::_id_9636("specialty_gas_grenade_resist");
    self notify("removed_spawn_perks");
  }
}

_id_FBF1(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(var_0) && isPlayer(var_0);
  var_9 = var_5.basename == "s4_throwing_knife_mp";
  var_10 = var_9 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "grenade";
  var_11 = isDefined(var_1) && isPlayer(var_1) && var_1 != var_2;

  if(var_11 && (var_8 || var_10)) {
    thread _id_0A6E::_id_FD8C(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_triggerhappy")) {
      var_1 thread _id_0A6B::_id_D735();
    }

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_boom")) {
      var_2 thread _id_0A6B::_id_D4A2(var_1);
    }

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_deadeye")) {
      var_1._id_439D++;
    }

    var_12 = var_1.pers["abilityRecharging"];

    if(isDefined(var_12) && var_12) {
      var_1 notify("abilityFastRecharge");
    }

    var_13 = var_1.pers["abilityOn"];

    if(isDefined(var_13) && var_13) {
      var_1 notify("abilityExtraTime");
    }

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_super_sprint_kill_refresh")) {
      var_1 _id_0A6B::_id_EB48();
    }

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_reduce_regen_delay_on_kill")) {
      var_1 _id_0A6B::_id_C1B6();
    }
  }
}

_id_D626(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(level._id_AFFD[var_4])) {
      continue;
    }
    var_5 = _id_6C27(var_4);

    if(!isDefined(var_5)) {
      continue;
    }
    if(!isDefined(var_2[var_5])) {
      var_2[var_5] = [];
    }

    var_2[var_5][var_2[var_5].size] = level._id_AFFD[var_4]._id_7C8C;
  }

  var_7 = [];

  for(var_5 = 1; var_5 < 4; var_5++) {
    if(isDefined(var_2[var_5])) {
      foreach(var_4 in var_2[var_5]) {
        var_7[var_7.size] = var_4;
      }
    }
  }

  for(var_10 = 0; var_10 < 6; var_10++) {
    var_11 = var_7[var_10];

    if(!isDefined(var_11)) {
      var_11 = -1;
    }

    self setclientomnvar(var_0 + var_10, var_11);
  }
}

_id_897B(var_0) {
  var_1 = self.pers["loadoutPerks"];

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return 1;
    }
  }

  return 0;
}

_id_6C26(var_0) {
  if(!isDefined(var_0) || !isDefined(level._id_AFFD[var_0])) {
    return 0;
  }

  return level._id_AFFD[var_0]._id_7C8C;
}