/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perks.gsc
***********************************************/

function init() {
  level thread scripts\mp\perks\perkfunctions::rechargeequipmentthink_init();
  level thread scripts\mp\perks\perkfunctions::supersprintkillrefresh_init();
  level thread scripts\mp\perks\perkfunctions::sixthsense_think();
  level.perkfuncs = [];
  level.menuperks = [];
  level.scriptperks = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.extraperkmap = [];
  level.menurigperks = [];
  registerscriptperk("specialty_healer", &scripts\mp\perks\perkfunctions::sethealer, &scripts\mp\perks\perkfunctions::unsethealer, ["specialty_regenfaster", "specialty_regen_delay_reduced"]);
  registerscriptperk("specialty_survivor", &scripts\mp\perks\perkfunctions::setsurvivor, &scripts\mp\perks\perkfunctions::unsetsurvivor, ["specialty_blastshield"]);
  registerscriptperk("specialty_support", &scripts\mp\perks\perkfunctions::setsupport, &scripts\mp\perks\perkfunctions::unsetsupport, ["specialty_offhand_provider"]);
  registerscriptperk("specialty_demolitions", &scripts\mp\perks\perkfunctions::setdemolitions, &scripts\mp\perks\perkfunctions::unsetdemolitions, ["specialty_extra_deadly"]);
  registerscriptperk("specialty_stealth", &scripts\mp\perks\perkfunctions::setstealth, &scripts\mp\perks\perkfunctions::unsetstealth, ["specialty_ghost", "specialty_spygame"]);
  registerscriptperk("specialty_munitions", &scripts\mp\perks\perkfunctions::setmunitions, &scripts\mp\perks\perkfunctions::unsetmunitions, ["specialty_twoprimaries"]);
  registerscriptperk("specialty_spotter", &scripts\mp\perks\perkfunctions::setspotter, &scripts\mp\perks\perkfunctions::unsetspotter, ["specialty_ads_mark_target", "specialty_engineer", "specialty_kill_report"]);
  registerscriptperk("specialty_tank", &scripts\mp\perks\perkfunctions::settank, &scripts\mp\perks\perkfunctions::unsettank);
  registerscriptperk("specialty_breacher", &scripts\mp\perks\perkfunctions::setbreacher, &scripts\mp\perks\perkfunctions::unsetbreacher);
  registerscriptperk("specialty_intel", &scripts\mp\perks\perkfunctions::setintel, &scripts\mp\perks\perkfunctions::unsetintel);
  registerscriptperk("specialty_hunter", &scripts\mp\perks\perkfunctions::sethunter, &scripts\mp\perks\perkfunctions::unsethunter);
  registerscriptperk("specialty_revive_use_weapon", &scripts\mp\perks\perkfunctions::setreviveuseweapon, &scripts\mp\perks\perkfunctions::unsetreviveuseweapon, ["specialty_medic"]);
  registerscriptperk("specialty_ability_selfrevive", undefined, undefined, ["specialty_pistoldeath"]);
  registerscriptperk("specialty_door_breach", &scripts\mp\perks\perkfunctions::setdoorbreach, &scripts\mp\perks\perkfunctions::unsetdoorbreach);
  registerscriptperk("specialty_ability_deploycover");
  registerscriptperk("specialty_rugged_eqp", &scripts\mp\perks\perkfunctions::setruggedeqp, &scripts\mp\perks\perkfunctions::unsetruggedeqp, ["specialty_extra_planted_equipment"]);
  registerscriptperk("specialty_extra_planted_equipment");
  registerscriptperk("specialty_ability_empdrone");
  registerscriptperk("specialty_ability_deadsilence");
  registerscriptperk("specialty_ability_supportbox");
  registerscriptperk("specialty_ability_trophy");
  registerscriptperk("specialty_ability_recondrone");
  registerscriptperk("specialty_ability_tacinsert");
  registerscriptperk("specialty_ability_ammodrop");
  registerscriptperk("specialty_blastshield", &scripts\mp\perks\perkfunctions::setblastshield, &scripts\mp\perks\perkfunctions::unsetblastshield);
  registerscriptperk("specialty_engineer", &scripts\mp\perks\perkfunctions::setengineer, &scripts\mp\perks\perkfunctions::unsetengineer, ["specialty_outlinekillstreaks"]);
  registerscriptperk("specialty_strategist", undefined, undefined, ["specialty_killstreak_to_scorestreak", "specialty_br_better_mission_rewards"]);
  registerscriptperk("specialty_munitions_2", undefined, undefined, ["specialty_twoprimaries"]);
  registerscriptperk("specialty_guerrilla", undefined, undefined, ["specialty_ghost", "specialty_heartbreaker"]);
  registerscriptperk("specialty_tune_up", undefined, undefined, ["specialty_improved_field_upgrades", "specialty_faster_field_upgrade", "specialty_br_faster_revive"]);
  registerscriptperk("specialty_restock", undefined, undefined, ["specialty_recharge_equipment"]);
  registerscriptperk("specialty_hustle", undefined, undefined, ["specialty_supersprint_enhanced", "specialty_fastcrouchmovement"]);
  registerscriptperk("specialty_tactical_recon", undefined, undefined, ["specialty_engineer", "specialty_markequipment", "specialty_hack"]);
  registerscriptperk("specialty_tac_resist", undefined, undefined, ["specialty_stun_resistance", "specialty_emp_resist", "specialty_gas_grenade_resist", "specialty_scrambler_resist", "specialty_snapshot_immunity"]);
  registerscriptperk("specialty_heavy_metal", undefined, undefined, ["specialty_chain_killstreaks", "specialty_br_extra_killstreak_chance"]);
  registerscriptperk("specialty_scavenger_plus", undefined, undefined, ["specialty_scavenger"]);
  registerscriptperk("specialty_hardline", &scripts\mp\perks\perkfunctions::sethardline, &scripts\mp\perks\perkfunctions::unsethardline, ["specialty_br_cheaper_kiosk"]);
  registerscriptperk("specialty_extra_shrapnel", undefined, undefined, ["specialty_extra_deadly", "specialty_shrapnel"]);
  registerscriptperk("specialty_covert_ops", undefined, undefined, ["specialty_blindeye", "specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget", "specialty_sixth_sense_immune"]);
  registerscriptperk("specialty_eod", undefined, undefined, ["specialty_blastshield", "specialty_throwback", "specialty_shrapnel_resist"]);
  registerscriptperk("specialty_huntmaster", undefined, undefined, ["specialty_tracker", "specialty_kill_report", "specialty_silentkill"]);
  registerscriptperk("specialty_warhead", undefined, undefined, ["specialty_quickswap", "specialty_fastreload_launchers"]);
  registerscriptperk("specialty_quick_fix", undefined, undefined, ["specialty_reduce_regen_delay_on_kill", "specialty_reduce_regen_delay_on_objective", "specialty_reduce_regen_delay_on_plate"]);
  registerscriptperk("specialty_mercenary", undefined, undefined, ["specialty_bounty"]);
  registerscriptperk("specialty_sonar", undefined, undefined, ["specialty_always_minimap"]);
  registerscriptperk("specialty_graverobber", undefined, undefined, ["specialty_scrap_weapons"]);
  registerscriptperk("specialty_specialist_bonus", &scripts\mp\perks\perkfunctions::ref_131c2, &scripts\mp\perks\perkfunctions::ref_13f6e);
  registerscriptperk("specialty_killstreak_to_scorestreak", &scripts\mp\perks\perkfunctions::setkillstreaktoscorestreak, &scripts\mp\perks\perkfunctions::unsetkillstreaktoscorestreak);
  registerscriptperk("specialty_improved_field_upgrades");
  registerscriptperk("specialty_recharge_equipment", &scripts\mp\perks\perkfunctions::setrechargeequipment, &scripts\mp\perks\perkfunctions::unsetrechargeequipment);
  registerscriptperk("specialty_super_sprint_kill_refresh");
  registerscriptperk("specialty_markequipment", &scripts\mp\perks\perkfunctions::setmarkequipment, &scripts\mp\perks\perkfunctions::unsetmarkequipment);
  registerscriptperk("specialty_chain_killstreaks", &scripts\mp\perks\perkfunctions::ref_13137, &scripts\mp\perks\perkfunctions::ref_13f64);
  registerscriptperk("specialty_scrap_weapons", &scripts\mp\perks\perkfunctions::setscrapweapons, &scripts\mp\perks\perkfunctions::unsetscrapweapons);
  registerscriptperk("specialty_door_alarm", &scripts\mp\perks\perkfunctions::setdooralarm, &scripts\mp\perks\perkfunctions::unsetdooralarm);
  registerscriptperk("specialty_always_minimap", &scripts\mp\perks\perkfunctions::setalwaysminimap, &scripts\mp\perks\perkfunctions::unsetalwaysminimap);
  registerscriptperk("specialty_shrapnel");
  registerscriptperk("specialty_team_scavenger");
  registerscriptperk("specialty_fastreload_launchers", &scripts\mp\perks\perkfunctions::setfastreloadlaunchers, &scripts\mp\perks\perkfunctions::unsetfastreloadlaunchers);
  registerscriptperk("specialty_emp_resist");
  registerscriptperk("specialty_sixth_sense_immune");
  registerscriptperk("specialty_shrapnel_resist");
  registerscriptperk("specialty_reduce_regen_delay_on_kill", &scripts\mp\perks\perkfunctions::ref_131b8, &scripts\mp\perks\perkfunctions::ref_13f6c);
  registerscriptperk("specialty_reduce_regen_delay_on_plate", &scripts\mp\perks\perkfunctions::ref_131ba, undefined);
  registerscriptperk("specialty_reduce_regen_delay_on_objective", &scripts\mp\perks\perkfunctions::setreduceregendelayonobjective, &scripts\mp\perks\perkfunctions::unsetreduceregendelayonobjective);
  registerscriptperk("specialty_scrambler_resist");
  registerscriptperk("specialty_no_battle_chatter");
  registerscriptperk("specialty_br_cheaper_kiosk");
  registerscriptperk("specialty_br_faster_revive");
  registerscriptperk("specialty_br_better_mission_rewards", &scripts\mp\perks\perkfunctions::ref_1312c, &scripts\mp\perks\perkfunctions::ref_13f63);
  registerscriptperk("specialty_br_extra_killstreak_chance");

  if(scripts\mp\utility\game::getgametype() == "br") {
    registerscriptperk("specialty_br_ping_on_damage", &scripts\mp\perks\perkfunctions::ref_13199, &scripts\mp\perks\perkfunctions::ref_13f69);
    registerscriptperk("specialty_br_stronger_armor", &scripts\mp\perks\perkfunctions::ref_131c5, &scripts\mp\perks\perkfunctions::ref_13f6f);
  } else {
    registerscriptperk("specialty_br_ping_on_damage");
    registerscriptperk("specialty_br_stronger_armor");
  }

  registerscriptperk("specialty_regenfaster", &scripts\mp\perks\perkfunctions::setregenfaster, &scripts\mp\perks\perkfunctions::unsetregenfaster);
  registerscriptperk("specialty_medic");
  registerscriptperk("specialty_regen_delay_reduced", &scripts\mp\perks\perkfunctions::setreduceregendelay, &scripts\mp\perks\perkfunctions::unsetreduceregendelay);
  registerscriptperk("specialty_can_be_revived");
  registerscriptperk("specialty_kill_report");
  registerscriptperk("specialty_ads_mark_target", &scripts\mp\perks\perkfunctions::setadsmarktarget, &scripts\mp\perks\perkfunctions::unsetadsmarktarget);
  registerscriptperk("specialty_armorvest", &scripts\mp\perks\perkfunctions::setarmorvest, &scripts\mp\perks\perkfunctions::unsetarmorvest);
  registerscriptperk("specialty_tracker", &scripts\mp\perks\perkfunctions::settracker, &scripts\mp\perks\perkfunctions::unsettracker, ["specialty_tracker_pro"]);
  registerscriptperk("specialty_ghost", &scripts\mp\perks\perkfunctions::setghost, &scripts\mp\perks\perkfunctions::unsetghost, ["specialty_gpsjammer"]);
  registerscriptperk("specialty_helmet", &scripts\mp\perks\perkfunctions::sethelmet, &scripts\mp\perks\perkfunctions::unsethelmet);
  registerscriptperk("specialty_ladder", &scripts\mp\perks\perkfunctions::setladder, &scripts\mp\perks\perkfunctions::unsetladder);
  registerscriptperk("specialty_extra_deadly", &scripts\mp\perks\perkfunctions::setextradeadly, &scripts\mp\perks\perkfunctions::unsetextradeadly);
  registerscriptperk("specialty_remote_defuse", &scripts\mp\perks\perkfunctions::setremotedefuse, &scripts\mp\perks\perkfunctions::unsetremotedefuse);
  registerscriptperk("specialty_hack");
  registerscriptperk("specialty_faster_field_upgrade");
  registerscriptperk("specialty_improved_target_mark");
  registerscriptperk("specialty_door_sense", &scripts\mp\perks\perkfunctions::setdoorsense, &scripts\mp\perks\perkfunctions::unsetdoorsense);
  registerscriptperk("specialty_worsenedgunkick", &scripts\mp\perks\perkfunctions::setworsenedgunkick, &scripts\mp\perks\perkfunctions::unsetworsenedgunkick);
  registerscriptperk("specialty_ammo_disabling");
  registerscriptperk("specialty_gunperk_xp");
  registerscriptperk("specialty_location_marking", &scripts\mp\perks\perkfunctions::setlocationmarking, &scripts\mp\perks\perkfunctions::unsetlocationmarking);

  if(scripts\mp\utility\game::getgametype() == "br") {
    registerscriptperk("specialty_surveillance", undefined, undefined, ["specialty_sixth_sense", "specialty_superhearing"]);
  } else {
    registerscriptperk("specialty_surveillance", undefined, undefined, ["specialty_sixth_sense"]);
  }

  registerscriptperk("specialty_br_highalert", undefined, undefined, ["specialty_sixth_sense", "specialty_superhearing"]);
  registerscriptperk("specialty_br_spotter", undefined, undefined, ["specialty_engineer"]);
  registerscriptperk("specialty_br_tracker", undefined, undefined, ["specialty_tracker_pro"]);
  registerscriptperk("specialty_br_stalker", undefined, undefined, ["specialty_stalker"]);
  registerscriptperk("specialty_br_marksman", undefined, undefined, ["specialty_marksman"]);
  registerscriptperk("specialty_br_sleightofhand", undefined, undefined, ["specialty_fastreload"]);
  registerscriptperk("specialty_br_healer", undefined, undefined);
  registerscriptperk("specialty_br_ammoscavenger", undefined, undefined);
  registerscriptperk("specialty_br_armorscavenger", undefined, undefined);
  registerscriptperk("specialty_br_bountyhunter", &scripts\mp\perks\perkfunctions::setbountyhunter, &scripts\mp\perks\perkfunctions::unsetbountyhunter);
  registerscriptperk("specialty_br_medicscavenger", undefined, undefined);
  registerscriptperk("specialty_br_plunderscavenger", undefined, undefined);
  registerscriptperk("specialty_br_ghost", undefined, undefined, ["specialty_gpsjammer"]);
  registerscriptperk("specialty_br_sneaky", undefined, undefined, ["specialty_hunter"]);
  registerscriptperk("specialty_br_eod", undefined, undefined, ["specialty_blastshield", "specialty_hack", "specialty_throwback", "specialty_shrapnel_resist"]);

  if(scripts\mp\utility\game::getgametype() == "br") {
    registerscriptperk("specialty_br_advancedscout", undefined, undefined, ["specialty_br_ping_on_damage"]);
    registerscriptperk("specialty_br_reinforced", undefined, undefined, ["specialty_br_stronger_armor"]);
  } else {
    registerscriptperk("specialty_br_advancedscout", undefined, undefined, undefined);
    registerscriptperk("specialty_br_reinforced", undefined, undefined, undefined);
  }

  registerscriptperk("specialty_br_serpentine", undefined, undefined, ["specialty_br_sprinting_dr"]);
  registerscriptperk("specialty_br_sprinting_dr", undefined, undefined);
  registerscriptperk("specialty_quick", &scripts\mp\perks\perkfunctions::ref_131b3, &scripts\mp\perks\perkfunctions::ref_13f6a);
  registerscriptperk("specialty_frenzy", undefined, undefined, ["specialty_reduce_regen_delay_on_kill"]);
  registerscriptperk("specialty_shrouded", undefined, undefined);
  registerscriptperk("specialty_quickscope", &scripts\mp\perks\perkfunctions::ref_131b4, &scripts\mp\perks\perkfunctions::ref_13f6b);
  registerscriptperk("specialty_hardscope", &scripts\mp\perks\perkfunctions::ref_13159, &scripts\mp\perks\perkfunctions::ref_13f65);
  registerscriptperk("specialty_nervesofsteel", &scripts\mp\perks\perkfunctions::ref_13176, &scripts\mp\perks\perkfunctions::ref_13f66);
  registerscriptperk("specialty_panic", &scripts\mp\perks\perkfunctions::ref_13195, &scripts\mp\perks\perkfunctions::ref_13f68);
  registerscriptperk("specialty_scr_tightgrip", &scripts\mp\perks\perkfunctions::ref_131d0, &scripts\mp\perks\perkfunctions::ref_13f70);
  registerscriptperk("specialty_vital");
  registerscriptperk("specialty_icyveins", undefined, undefined, ["specialty_nervesofsteel", "specialty_fastreload_injured"]);
  registerscriptperk("specialty_afterburner", &scripts\mp\perks\perkfunctions::setafterburner, &scripts\mp\perks\perkfunctions::unsetafterburner, ["specialty_thruster"]);
  registerscriptperk("specialty_autospot", &scripts\mp\perks\perkfunctions::setautospot, &scripts\mp\perks\perkfunctions::unsetautospot);
  registerscriptperk("specialty_boom", &scripts\mp\perks\perkfunctions::setboom, &scripts\mp\perks\perkfunctions::unsetboom);
  registerscriptperk("specialty_delaymine", &scripts\mp\perks\perkfunctions::setdelaymine, &scripts\mp\perks\perkfunctions::unsetdelaymine);
  registerscriptperk("specialty_dexterity", undefined, undefined, ["specialty_fastreload", "specialty_quickswap"]);
  registerscriptperk("specialty_hardwired", undefined, undefined, ["specialty_tracker_jammer", "specialty_noscopeoutline", "specialty_empimmune"]);
  registerscriptperk("specialty_empimmune", &scripts\mp\perks\perkfunctions::setempimmune, &scripts\mp\perks\perkfunctions::unsetempimmune);
  registerscriptperk("specialty_explosivedamage");
  registerscriptperk("specialty_extraammo", &scripts\mp\perks\perkfunctions::setextraammo, &scripts\mp\perks\perkfunctions::unsetextraammo);
  registerscriptperk("specialty_falldamage", &scripts\mp\perks\perkfunctions::setfreefall, &scripts\mp\perks\perkfunctions::unsetfreefall);
  registerscriptperk("specialty_hard_shell", &scripts\mp\perks\perkfunctions::sethardshell, &scripts\mp\perks\perkfunctions::unsethardshell);
  registerscriptperk("specialty_powercell", &scripts\mp\perks\perkfunctions::setpowercell, &scripts\mp\perks\perkfunctions::unsetpowercell);
  registerscriptperk("specialty_incog", &scripts\mp\perks\perkfunctions::setincog, &scripts\mp\perks\perkfunctions::unsetincog);
  registerscriptperk("specialty_localjammer", &scripts\mp\perks\perkfunctions::setlocaljammer, &scripts\mp\perks\perkfunctions::unsetlocaljammer);
  registerscriptperk("specialty_overclock", &scripts\mp\perks\perkfunctions::setoverclock, &scripts\mp\perks\perkfunctions::unsetoverclock);
  registerscriptperk("specialty_outlinekillstreaks", &scripts\mp\perks\perkfunctions::setoutlinekillstreaks, &scripts\mp\perks\perkfunctions::unsetoutlinekillstreaks);
  registerscriptperk("specialty_pitcher", &scripts\mp\perks\perkfunctions::setpitcher, &scripts\mp\perks\perkfunctions::unsetpitcher, ["specialty_throwback"]);
  registerscriptperk("specialty_stun_resistance", &scripts\mp\perks\perkfunctions::setstunresistance, &scripts\mp\perks\perkfunctions::unsetstunresistance, ["specialty_hard_shell"]);
  registerscriptperk("penalty_stun_more", &scripts\mp\perks\perkfunctions::setstunmore, &scripts\mp\perks\perkfunctions::unsetstunmore);
  registerscriptperk("specialty_twoprimaries", &scripts\mp\perks\perkfunctions::setoverkill, &scripts\mp\perks\perkfunctions::unsetoverkill, []);
  registerscriptperk("specialty_bullet_outline", &scripts\mp\perks\perkfunctions::setbulletoutline, &scripts\mp\perks\perkfunctions::unsetbulletoutline);
  registerscriptperk("specialty_activereload", &scripts\mp\perks\perkfunctions::setactivereload, &scripts\mp\perks\perkfunctions::unsetactivereload);
  registerscriptperk("specialty_sixth_sense", &scripts\mp\perks\perkfunctions::setsixthsense, &scripts\mp\perks\perkfunctions::unsetsixthsense);
  registerscriptperk("specialty_enhanced_sixth_sense", &scripts\mp\perks\perkfunctions::setenhancedsixthsense, &scripts\mp\perks\perkfunctions::unsetenhancedsixthsense);
  registerscriptperk("specialty_meleekill", &scripts\mp\perks\perkfunctions::setmeleekill, &scripts\mp\perks\perkfunctions::unsetmeleekill);
  registerscriptperk("specialty_gung_ho");
  registerscriptperk("specialty_man_at_arms", &scripts\mp\perks\perkfunctions::setmanatarms, &scripts\mp\perks\perkfunctions::unsetmanatarms, ["specialty_extraammo", "specialty_overrideweaponspeed"]);
  registerscriptperk("specialty_momentum", &scripts\mp\perks\perkfunctions::setmomentum, &scripts\mp\perks\perkfunctions::unsetmomentum);
  registerscriptperk("specialty_improvedmelee", &scripts\mp\perks\perkfunctions::setimprovedmelee, &scripts\mp\perks\perkfunctions::unsetimprovedmelee, ["specialty_extendedmelee", "specialty_fastermelee", "specialty_thief"]);
  registerscriptperk("specialty_thief", &scripts\mp\perks\perkfunctions::setthief, &scripts\mp\perks\perkfunctions::unsetthief);
  registerscriptperk("specialty_silentkill");
  registerscriptperk("specialty_armorpiercing");
  registerscriptperk("specialty_armorpiercingks");
  registerscriptperk("specialty_fastcrouch", &scripts\mp\perks\perkfunctions::setfastcrouch, &scripts\mp\perks\perkfunctions::unsetfastcrouch);
  registerscriptperk("specialty_bulletdamage", undefined, undefined, ["specialty_overcharge", "specialty_worsenedgunkick"]);
  registerscriptperk("specialty_solobuddyboost", &scripts\mp\perks\perkfunctions::setsolobuddyboost, &scripts\mp\perks\perkfunctions::unsetsolobuddyboost);
  registerscriptperk("specialty_offhand_provider", &scripts\mp\perks\perkfunctions::setoffhandprovider, &scripts\mp\perks\perkfunctions::unsetoffhandprovider);
  registerscriptperk("specialty_glintreduce");
  registerscriptperk("specialty_gas_grenade_resist", &scripts\mp\perks\perkfunctions::setgasgrenaderesist, &scripts\mp\perks\perkfunctions::unsetgasgrenaderesist);
  registerscriptperk("specialty_battleslide", &scripts\mp\perks\perkfunctions::setbattleslide, &scripts\mp\perks\perkfunctions::unsetbattleslide);
  registerscriptperk("specialty_battleslide_offense", &scripts\mp\perks\perkfunctions::setbattleslideoffense, &scripts\mp\perks\perkfunctions::unsetbattleslideoffense);
  registerscriptperk("specialty_battleslide_shield", &scripts\mp\perks\perkfunctions::setbattleslideshield, &scripts\mp\perks\perkfunctions::unsetbattleslideshield);
  registerscriptperk("specialty_disruptor_punch", &scripts\mp\perks\perkfunctions::setdisruptorpunch, &scripts\mp\perks\perkfunctions::unsetdisruptorpunch);
  registerscriptperk("specialty_ground_pound", &scripts\mp\perks\perkfunctions::setgroundpound, &scripts\mp\perks\perkfunctions::unsetgroundpound);
  registerscriptperk("specialty_ground_pound_shield", &scripts\mp\perks\perkfunctions::setgroundpoundshield, &scripts\mp\perks\perkfunctions::unsetgroundpoundshield);
  registerscriptperk("specialty_ground_pound_shock", &scripts\mp\perks\perkfunctions::setgroundpoundshock, &scripts\mp\perks\perkfunctions::unsetgroundpoundshock);
  registerscriptperk("specialty_thruster", &scripts\mp\perks\perkfunctions::setthruster, &scripts\mp\perks\perkfunctions::unsetthruster);
  registerscriptperk("specialty_dodge", &scripts\mp\perks\perkfunctions::setdodge, &scripts\mp\perks\perkfunctions::unsetdodge);
  registerscriptperk("specialty_extra_dodge", &scripts\mp\perks\perkfunctions::setextradodge, &scripts\mp\perks\perkfunctions::unsetextradodge);
  registerscriptperk("specialty_extend_dodge", &scripts\mp\perks\perkfunctions::setextenddodge, &scripts\mp\perks\perkfunctions::unsetextenddodge);
  registerscriptperk("specialty_phase_slide", &scripts\mp\perks\perkfunctions::setphaseslide, &scripts\mp\perks\perkfunctions::unsetphaseslide);
  registerscriptperk("specialty_tele_slide", &scripts\mp\perks\perkfunctions::setteleslide, &scripts\mp\perks\perkfunctions::unsetteleslide);
  registerscriptperk("specialty_phaseslash", undefined, undefined, ["specialty_phaseslash_rephase"]);
  registerscriptperk("specialty_phaseslash_rephase", &scripts\mp\perks\perkfunctions::setphaseslashrephase, &scripts\mp\perks\perkfunctions::unsetphaseslashrephase);
  registerscriptperk("specialty_phase_fall", &scripts\mp\perks\perkfunctions::setphasefall, &scripts\mp\perks\perkfunctions::unsetphasefall);
  registerscriptperk("specialty_aura_quickswap", &scripts\mp\perks\perkfunctions::setauraquickswap, &scripts\mp\perks\perkfunctions::unsetauraquickswap);
  registerscriptperk("specialty_aura_speed", &scripts\mp\perks\perkfunctions::setauraspeed, &scripts\mp\perks\perkfunctions::unsetauraspeed);
  registerscriptperk("specialty_mark_targets", &scripts\mp\perks\perkfunctions::setmarktargets, &scripts\mp\perks\perkfunctions::unsetmarktargets);
  registerscriptperk("specialty_batterypack", &scripts\mp\perks\perkfunctions::setbatterypack, &scripts\mp\perks\perkfunctions::unsetbatterypack);
  registerscriptperk("specialty_camo_elite", &scripts\mp\perks\perkfunctions::setcamoelite, &scripts\mp\perks\perkfunctions::unsetcamoelite);
  registerscriptperk("specialty_scorestreakpack", &scripts\mp\perks\perkfunctions::setscorestreakpack, &scripts\mp\perks\perkfunctions::unsetscorestreakpack);
  registerscriptperk("specialty_superpack", &scripts\mp\perks\perkfunctions::setsuperpack, &scripts\mp\perks\perkfunctions::unsetsuperpack);
  registerscriptperk("specialty_dodge_defense", &scripts\mp\perks\perkfunctions::setdodgedefense, &scripts\mp\perks\perkfunctions::unsetdodgedefense);
  registerscriptperk("specialty_spawncloak", &scripts\mp\perks\perkfunctions::setspawncloak, &scripts\mp\perks\perkfunctions::unsetspawncloak);
  registerscriptperk("specialty_commando");
  registerscriptperk("specialty_personal_trophy", &scripts\mp\perks\perkfunctions::setpersonaltrophy, &scripts\mp\perks\perkfunctions::unsetpersonaltrophy);
  registerscriptperk("specialty_equipment_ping", &scripts\mp\perks\perkfunctions::setequipmentping, &scripts\mp\perks\perkfunctions::unsetequipmentping, ["specialty_paint"]);
  registerscriptperk("specialty_cloak", &scripts\mp\perks\perkfunctions::setcloak, &scripts\mp\perks\perkfunctions::unsetcloak);
  registerscriptperk("specialty_wall_lock", &scripts\mp\perks\perkfunctions::setwalllock, &scripts\mp\perks\perkfunctions::unsetwalllock);
  registerscriptperk("specialty_rush", &scripts\mp\perks\perkfunctions::setrush, &scripts\mp\perks\perkfunctions::unsetrush);
  registerscriptperk("specialty_hover", &scripts\mp\perks\perkfunctions::sethover, &scripts\mp\perks\perkfunctions::unsethover);
  registerscriptperk("specialty_scavenger_eqp", &scripts\mp\perks\perkfunctions::setscavengereqp, &scripts\mp\perks\perkfunctions::unsetscavengereqp);
  registerscriptperk("specialty_spawnview", &scripts\mp\perks\perkfunctions::setspawnview, &scripts\mp\perks\perkfunctions::unsetspawnview);
  registerscriptperk("specialty_headgear", &scripts\mp\perks\perkfunctions::setheadgear, &scripts\mp\perks\perkfunctions::unsetheadgear);
  registerscriptperk("specialty_ftlslide", &scripts\mp\perks\perkfunctions::setftlslide, &scripts\mp\perks\perkfunctions::unsetftlslide);
  registerscriptperk("specialty_improved_prone", &scripts\mp\perks\perkfunctions::setimprovedprone, &scripts\mp\perks\perkfunctions::unsetimprovedprone);
  registerscriptperk("specialty_support_killstreaks", &scripts\mp\perks\perkfunctions::setsupportkillstreaks, &scripts\mp\perks\perkfunctions::unsetsupportkillstreaks);
  registerscriptperk("specialty_overrideweaponspeed", &scripts\mp\perks\perkfunctions::setoverrideweaponspeed, &scripts\mp\perks\perkfunctions::unsetoverrideweaponspeed);
  registerscriptperk("specialty_cloak_aerial", &scripts\mp\perks\perkfunctions::setcloakaerial, &scripts\mp\perks\perkfunctions::unsetcloakaerial);
  registerscriptperk("specialty_spawn_radar", &scripts\mp\perks\perkfunctions::setspawnradar, &scripts\mp\perks\perkfunctions::unsetspawnradar);
  registerscriptperk("specialty_ads_awareness", &scripts\mp\perks\perkfunctions::setadsawareness, &scripts\mp\perks\perkfunctions::unsetadsawareness);
  registerscriptperk("specialty_rearguard", &scripts\mp\perks\perkfunctions::setrearguard, &scripts\mp\perks\perkfunctions::unsetrearguard);
  registerscriptperk("specialty_sharp_focus", &scripts\mp\perks\perkfunctions::setsharpfocus, &scripts\mp\perks\perkfunctions::unsetsharpfocus);
  registerscriptperk("specialty_bling");
  registerscriptperk("specialty_comexp", &scripts\mp\perks\perkfunctions::setcomexp, &scripts\mp\perks\perkfunctions::unsetcomexp);
  registerscriptperk("specialty_paint");
  registerscriptperk("specialty_paint_pro");
  registerscriptperk("specialty_steadyaimpro", &scripts\mp\perks\perkfunctions::setsteadyaimpro, &scripts\mp\perks\perkfunctions::unsetsteadyaimpro);
  registerscriptperk("specialty_block_health_regen", &scripts\mp\perks\perkfunctions::setblockhealthregen, &scripts\mp\perks\perkfunctions::unsetblockhealthregen);
  registerscriptperk("specialty_rshieldradar", &scripts\mp\perks\perkfunctions::setrshieldradar, &scripts\mp\perks\perkfunctions::unsetrshieldradar);
  registerscriptperk("specialty_rshieldscrambler", &scripts\mp\perks\perkfunctions::setrshieldscrambler, &scripts\mp\perks\perkfunctions::unsetrshieldscrambler);
  registerscriptperk("specialty_delayhealing");
  registerscriptperk("specialty_hardmelee");
  registerscriptperk("specialty_combathigh", &scripts\mp\perks\perkfunctions::setcombathigh, &scripts\mp\perks\perkfunctions::unsetcombathigh);
  registerscriptperk("specialty_juiced", &scripts\mp\perks\perkfunctions::setjuiced, &scripts\mp\perks\perkfunctions::unsetjuiced);
  registerscriptperk("specialty_revenge", &scripts\mp\perks\perkfunctions::setrevenge, &scripts\mp\perks\perkfunctions::unsetrevenge);
  registerscriptperk("specialty_light_armor", &scripts\mp\perks\perkfunctions::setlightarmor, &scripts\mp\perks\perkfunctions::unsetlightarmor);
  registerscriptperk("specialty_carepackage", &scripts\mp\perks\perkfunctions::setcarepackage, &scripts\mp\perks\perkfunctions::unsetcarepackage);
  registerscriptperk("specialty_stopping_power");
  registerscriptperk("specialty_uav", &scripts\mp\perks\perkfunctions::setuav, &scripts\mp\perks\perkfunctions::unsetuav);
  registerscriptperk("specialty_viewkickoverride", &scripts\mp\perks\perkfunctions::setviewkickoverride, &scripts\mp\perks\perkfunctions::unsetviewkickoverride);
  registerscriptperk("specialty_affinityspeedboost", &scripts\mp\perks\perkfunctions::setaffinityspeedboost, &scripts\mp\perks\perkfunctions::unsetaffinityspeedboost);
  registerscriptperk("specialty_affinityextralauncher", &scripts\mp\perks\perkfunctions::setaffinityextralauncher, &scripts\mp\perks\perkfunctions::unsetaffinityextralauncher);
  registerscriptperk("bouncingbetty_mp");
  registerscriptperk("c4_mp_p");
  registerscriptperk("claymore_mp");
  registerscriptperk("frag_grenade_mp");
  registerscriptperk("semtex_mp");
  registerscriptperk("cluster_grenade_mp");
  registerscriptperk("throwingknife_mp");
  registerscriptperk("throwingknife_fire_mp");
  registerscriptperk("throwingknife_electric_mp");
  registerscriptperk("throwingknife_drill_mp");
  registerscriptperk("throwingknifec4_mp");
  registerscriptperk("proximity_explosive_mp");
  registerscriptperk("case_bomb_mp");
  registerscriptperk("sonic_sensor_mp");
  registerscriptperk("specialty_equip_throwingKnife", &scripts\mp\perks\perkfunctions::setthrowingknifemelee, &scripts\mp\perks\perkfunctions::unsetthrowingknifemelee);
  registerscriptperk("concussion_grenade_mp");
  registerscriptperk("sensor_grenade_mp");
  registerscriptperk("gravity_grenade_mp");
  registerscriptperk("flash_grenade_mp");
  registerscriptperk("smoke_grenade_mp");
  registerscriptperk("emp_grenade_mp");
  registerscriptperk("specialty_tacticalinsertion", &scripts\mp\perks\perkfunctions::settacticalinsertion, &scripts\mp\perks\perkfunctions::unsettacticalinsertion);
  registerscriptperk("trophy_mp");
  registerscriptperk("motion_sensor_mp");
  registerscriptperk("mobile_radar_mp");
  registerscriptperk("blackout_grenade_mp");
  registerscriptperk("proxy_bomb_mp");
  registerscriptperk("splash_grenade_mp");
  registerscriptperk("forcepush_mp");
  registerscriptperk("ammo_box_mp");
  registerscriptperk("blackhat_mp");
  registerscriptperk("flare_mp");
  registerscriptperk("serum_gadget", undefined, undefined, ["penalty_stun_more", "specialty_extendedmelee_s4", "specialty_hardmelee", "penalty_louder"]);
  var_0 = scripts\mp\passives::getweapontypepassives();

  foreach(var_2 in var_0) {
    level.scriptperks[var_2] = 1;
    var_3 = scripts\mp\passives::getpassiveperk(var_2);

    if(isDefined(var_3)) {
      level.extraperkmap[var_2] = [var_3];
    }
  }

  registerscriptperk("specialty_null");
  registercodeperkinfo("specialty_thermal", &scripts\mp\perks\perkfunctions::setthermal, &scripts\mp\perks\perkfunctions::unsetthermal);
  registercodeperkinfo("specialty_lightweight", &scripts\mp\perks\perkfunctions::setlightweight, &scripts\mp\perks\perkfunctions::unsetlightweight);
  registercodeperkinfo("specialty_steelnerves", &scripts\mp\perks\perkfunctions::setsteelnerves, &scripts\mp\perks\perkfunctions::unsetsteelnerves);
  registercodeperkinfo("specialty_saboteur", &scripts\mp\perks\perkfunctions::setsaboteur, &scripts\mp\perks\perkfunctions::unsetsaboteur);
  registercodeperkinfo("specialty_endgame", &scripts\mp\perks\perkfunctions::setendgame, &scripts\mp\perks\perkfunctions::unsetendgame);
  registercodeperkinfo("specialty_onemanarmy", &scripts\mp\perks\perkfunctions::setonemanarmy, &scripts\mp\perks\perkfunctions::unsetonemanarmy);
  registercodeperkinfo("specialty_weaponlaser", &scripts\mp\perks\perkfunctions::setweaponlaser, &scripts\mp\perks\perkfunctions::unsetweaponlaser);
  registercodeperkinfo("specialty_marksman", &scripts\mp\perks\perkfunctions::setmarksman, &scripts\mp\perks\perkfunctions::unsetmarksman);
  registercodeperkinfo("specialty_holdbreath", undefined, undefined);
  registercodeperkinfo("specialty_holdbreath_s4", undefined, undefined);
  registercodeperkinfo("specialty_fastermelee", undefined, undefined);
  registercodeperkinfo("specialty_double_load", &scripts\mp\perks\perkfunctions::setdoubleload, &scripts\mp\perks\perkfunctions::unsetdoubleload);
  registercodeperkinfo("specialty_overkill_pro", &scripts\mp\perks\perkfunctions::setoverkillpro, &scripts\mp\perks\perkfunctions::unsetoverkillpro);
  registercodeperkinfo("specialty_refill_grenades", &scripts\mp\perks\perkfunctions::setrefillgrenades, &scripts\mp\perks\perkfunctions::unsetrefillgrenades);
  registercodeperkinfo("specialty_refill_ammo", &scripts\mp\perks\perkfunctions::setrefillammo, &scripts\mp\perks\perkfunctions::unsetrefillammo);
  registercodeperkinfo("specialty_combat_speed", &scripts\mp\perks\perkfunctions::setcombatspeed, &scripts\mp\perks\perkfunctions::unsetcombatspeed);
  registercodeperkinfo("specialty_tagger", &scripts\mp\perks\perkfunctions::settagger, &scripts\mp\perks\perkfunctions::unsettagger);
  registercodeperkinfo("specialty_triggerhappy", &scripts\mp\perks\perkfunctions::settriggerhappy, &scripts\mp\perks\perkfunctions::unsettriggerhappy);
  registercodeperkinfo("specialty_blindeye", &scripts\mp\perks\perkfunctions::setblindeye, &scripts\mp\perks\perkfunctions::unsetblindeye);
  registercodeperkinfo("specialty_quickswap", &scripts\mp\perks\perkfunctions::setquickswap, &scripts\mp\perks\perkfunctions::unsetquickswap, ["specialty_fastoffhand"]);
  registercodeperkinfo("specialty_extra_equipment", &scripts\mp\perks\perkfunctions::setextraequipment, &scripts\mp\perks\perkfunctions::unsetextraequipment);
  registercodeperkinfo("specialty_lifepack", &scripts\mp\perks\perkfunctions::setlifepack, &scripts\mp\perks\perkfunctions::unsetlifepack);
  registercodeperkinfo("specialty_toughenup", &scripts\mp\perks\perkfunctions::settoughenup, &scripts\mp\perks\perkfunctions::unsettoughenup);
  registercodeperkinfo("specialty_scoutping", &scripts\mp\perks\perkfunctions::setscoutping, &scripts\mp\perks\perkfunctions::unsetscoutping);
  registercodeperkinfo("specialty_phase_speed", &scripts\mp\perks\perkfunctions::setphasespeed, &scripts\mp\perks\perkfunctions::unsetphasespeed);
  registercodeperkinfo("specialty_camo_clone", &scripts\mp\perks\perkfunctions::setcamoclone, &scripts\mp\perks\perkfunctions::unsetcamoclone);
  registercodeperkinfo("specialty_improvedgunkick", undefined, undefined, ["specialty_reducedsway"]);
  registercodeperkinfo("specialty_overcharge", &scripts\mp\perks\perkfunctions::setovercharge, &scripts\mp\perks\perkfunctions::unsetovercharge);
  registercodeperkinfo("specialty_supersprint_enhanced", &scripts\mp\perks\perkfunctions::setsupersprintenhanced, &scripts\mp\perks\perkfunctions::unsetsupersprintenhanced);
  registercodeperkinfo("specialty_noscopeoutline", &scripts\mp\perks\perkfunctions::setnoscopeoutline, &scripts\mp\perks\perkfunctions::unsetnoscopeoutline);
  registercodeperkinfo("specialty_snapshot_immunity");
  initperkdvars();
  menurigperkparsetable();
  menuperkparsetable();
  initperktable();
  thread onplayerconnect();
}

function registerscriptperk(var_0, var_1, var_2, var_3) {
  registerperk(var_0, 1, var_1, var_2, var_3);
}

function registercodeperkinfo(var_0, var_1, var_2, var_3) {
  registerperk(var_0, 0, var_1, var_2, var_3);
}

function registerperk(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_1)) {
    level.scriptperks[var_0] = 1;
  }

  if(isDefined(var_2)) {
    level.perksetfuncs[var_0] = var_2;
  }

  if(isDefined(var_3)) {
    level.perkunsetfuncs[var_0] = var_3;
  }

  if(isDefined(var_4)) {
    level.extraperkmap[var_0] = var_4;
    return;
  }
}

function menurigperkparsetable() {
  if(!isDefined(level.menurigperks)) {
    level.menurigperks = [];
  }

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/menuRigPerks.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/menuRigPerks.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp/menuRigPerks.csv", var_0, 2);
    var_4 = spawnStruct();
    var_4.id = var_1;
    var_4.ref = var_3;
    var_4.archetype = var_2;

    if(!isDefined(level.menurigperks[var_3])) {
      level.menurigperks[var_3] = var_4;
    }
  }
}

function menuperkparsetable() {
  if(!isDefined(level.menuperks)) {
    level.menuperks = [];
  }

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/menuPerks.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/menuPerks.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp/menuPerks.csv", var_0, 2);
    var_4 = spawnStruct();
    var_4.name = var_3;
    var_4.ref = var_3;
    var_4.slot = var_2;

    if(!isDefined(level.menuperks[var_3])) {
      level.menuperks[var_3] = var_4;
    }
  }
}

function initperktable() {
  if(!isDefined(level.perktable)) {
    level.perktable = [];
  }

  level.perksbyid = [];

  for(var_0 = 0;; var_0++) {
    var_1 = tablelookupbyrow("mp/perkTable.csv", var_0, 0);

    if(var_1 == "") {
      break;
    }

    var_2 = tablelookupbyrow("mp/perkTable.csv", var_0, 1);
    var_3 = tablelookupbyrow("mp/perkTable.csv", var_0, 16);
    var_4 = tablelookupbyrow("mp/perkTable.csv", var_0, 17);
    var_5 = tablelookupbyrow("mp/perkTable.csv", var_0, 18);
    var_6 = spawnStruct();
    var_6.ref = var_2;
    var_6.id = int(var_1);
    var_6.specialist = int(var_3);
    var_6.ref_136d1 = int(var_4);

    if(var_5 != "") {
      game["dialog"][var_2] = var_5;
    }

    if(!isDefined(level.perktable[var_2])) {
      level.perktable[var_2] = var_6;
    }

    level.perksbyid[var_6.id] = var_6.ref;
  }
}

function initspecialistkillstreaks() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialist_perk_1", undefined, &onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialist_perk_2", undefined, &onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialist_perk_3", undefined, &onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialist_perk_bonus", undefined, &ref_1208e);
}

function onspecialistkillstreakavailable(var_0) {
  var_1 = getspecialistperkforstreak(var_0.streakname);
  scripts\mp\utility\perk::giveperk(var_1);
}

function getspecialistperkforstreak(var_0) {
  var_1 = getspecialistindexforstreak(var_0);

  if(var_1 == -1) {
    return undefined;
  }

  return self.classstruct.loadoutextraperks[var_1];
}

function getspecialistindexforstreak(var_0) {
  if(!isDefined(var_0)) {
    return -1;
  }

  if(var_0 == "specialist_perk_1") {
    return 0;
  }

  if(var_0 == "specialist_perk_2") {
    return 1;
  }

  if(var_0 == "specialist_perk_3") {
    return 2;
  }

  return -1;
}

function usescriptablemeleeblood(var_0) {
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

function ref_1208e(var_0) {
  bears();
}

function battle_tracks_tryinittogglestate(var_0) {
  switch (var_0) {
    case "yellow":
      big_door_watcher();
      break;
    case "red":
      battletracksowner();
      break;
    case "blue":
      battle_tracks_gettrackindex();
      break;
    case "":
      break;
    default:
      scripts\mp\utility\perk::giveperk(var_0);
      break;
  }
}

function hudcost(var_0) {
  if(issubstr(var_0, "brloot_perk_point_")) {
    var_1 = getsubstr(var_0, 18);

    switch (var_1) {
      case "amped":
        return "specialty_warhead";
      case "battle_hardened":
        return "specialty_tac_resist";
      case "combat_scout":
        return "specialty_br_advancedscout";
      case "engineer":
        return "specialty_tactical_recon";
      case "shrapnel":
        return "specialty_extra_shrapnel";
      case "tune_up":
        return "specialty_tune_up";
      case "tracker":
        return "specialty_huntmaster";
      case "ghost":
        return "specialty_guerrilla";
      case "hardline":
        return "specialty_hardline";
      case "high_alert":
        return "specialty_surveillance";
      case "overkill":
        return "specialty_munitions_2";
      case "pointman":
        return "specialty_strategist";
      case "restock":
        return "specialty_restock";
      case "tempered":
        return "specialty_br_reinforced";
      case "quick_fix":
        return "specialty_quick_fix";
      case "cold_blooded":
        return "specialty_covert_ops";
      case "double_time":
        return "specialty_hustle";
      case "eod":
        return "specialty_eod";
      case "kill_chain":
        return "specialty_heavy_metal";
      case "scavenger":
        return "specialty_scavenger_plus";
      case "serpentine":
        return "specialty_br_serpentine";
      case "blue":
      case "yellow":
      case "red":
        return var_1;
      default:
        return "";
    }

    return;
  }

  return "";
}

function big_door_watcher() {
  scripts\mp\utility\perk::giveperk("specialty_warhead");
  scripts\mp\utility\perk::giveperk("specialty_tac_resist");
  scripts\mp\utility\perk::giveperk("specialty_br_advancedscout");
  scripts\mp\utility\perk::giveperk("specialty_tactical_recon");
  scripts\mp\utility\perk::giveperk("specialty_extra_shrapnel");
  scripts\mp\utility\perk::giveperk("specialty_tune_up");
  scripts\mp\utility\perk::giveperk("specialty_huntmaster");
}

function battletracksowner() {
  scripts\mp\utility\perk::giveperk("specialty_guerrilla");
  scripts\mp\utility\perk::giveperk("specialty_hardline");
  scripts\mp\utility\perk::giveperk("specialty_surveillance");
  scripts\mp\utility\perk::giveperk("specialty_munitions_2");
  scripts\mp\utility\perk::giveperk("specialty_strategist");
  scripts\mp\utility\perk::giveperk("specialty_restock");
  scripts\mp\utility\perk::giveperk("specialty_br_reinforced");
}

function battle_tracks_gettrackindex() {
  scripts\mp\utility\perk::giveperk("specialty_quick_fix");
  scripts\mp\utility\perk::giveperk("specialty_covert_ops");
  scripts\mp\utility\perk::giveperk("specialty_hustle");
  scripts\mp\utility\perk::giveperk("specialty_eod");
  scripts\mp\utility\perk::giveperk("specialty_heavy_metal");
  scripts\mp\utility\perk::giveperk("specialty_scavenger_plus");
}

function bears() {
  foreach(var_1 in level.perktable) {
    var_2 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "br", istrue(var_1.ref_136d1), istrue(var_1.specialist));

    if(!var_2) {
      continue;
    }

    if(equipmentisrestricted(var_1.ref)) {
      continue;
    }

    scripts\mp\utility\perk::giveperk(var_1.ref);
  }

  scripts\mp\utility\perk::giveperk("specialty_specialist_bonus");

  if(scripts\mp\utility\game::getgametype() == "br") {
    return;
  }

  scripts\mp\utility\perk::giveperk("specialty_lightweight");
  scripts\mp\utility\perk::giveperk("specialty_fastreload");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::giveperk("specialty_ammo_disabling");
    scripts\mp\utility\perk::giveperk("specialty_delayhealing");
    scripts\mp\utility\perk::giveperk("specialty_armorpiercing");
    scripts\mp\utility\perk::giveperk("specialty_hardmelee");
    scripts\mp\utility\perk::giveperk("specialty_marksman");
    scripts\mp\utility\perk::giveperk("specialty_gunperk_xp");
    return;
  }
}

function ref_12c25() {
  foreach(var_1 in level.perktable) {
    var_2 = scripts\engine\utility::ter_op(scripts\mp\utility\game::getgametype() == "br", istrue(var_1.ref_136d1), istrue(var_1.specialist));

    if(!var_2) {
      continue;
    }

    if(equipmentisrestricted(var_1.ref)) {
      continue;
    }

    scripts\mp\utility\perk::removeperk(var_1.ref);
  }

  scripts\mp\utility\perk::removeperk("specialty_specialist_bonus");

  if(scripts\mp\utility\game::getgametype() == "br") {
    return;
  }

  scripts\mp\utility\perk::removeperk("specialty_lightweight");
  scripts\mp\utility\perk::removeperk("specialty_fastreload");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::removeperk("specialty_ammo_disabling");
    scripts\mp\utility\perk::removeperk("specialty_delayhealing");
    scripts\mp\utility\perk::removeperk("specialty_armorpiercing");
    scripts\mp\utility\perk::removeperk("specialty_hardmelee");
    scripts\mp\utility\perk::removeperk("specialty_marksman");
    scripts\mp\utility\perk::removeperk("specialty_gunperk_xp");
    return;
  }
}

function getavailableperks() {
  var_0 = [];

  foreach(var_2 in level.menuperks) {
    if(scripts\mp\utility\perk::_hasperk(var_2.name)) {
      continue;
    }

    var_0 = var_2.name;
  }

  return var_0;
}

function getperkslot(var_0) {
  var_1 = level.menuperks[var_0];

  if(!isDefined(var_1)) {
    return undefined;
  }

  return int(var_1.slot);
}

function validateperk(var_0) {
  if(!scripts\mp\utility\perk::perksenabled()) {
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
      case "specialty_activereload":
      case "specialty_pitcher":
      case "specialty_falldamage":
      case "specialty_extraammo":
      case "specialty_explosivedamage":
      case "specialty_boom":
      case "specialty_fastreload":
      case "specialty_stalker":
      case "specialty_superhearing":
      case "specialty_sixth_sense":
      case "specialty_location_marking":
      case "specialty_door_sense":
      case "specialty_remote_defuse":
      case "specialty_gpsjammer":
      case "specialty_can_be_revived":
      case "specialty_quickswap":
      case "specialty_silentkill":
      case "specialty_scavenger":
      case "specialty_hack":
      case "specialty_faster_field_upgrade":
      case "specialty_door_breach":
      case "specialty_medic":
      case "specialty_hunter":
      case "specialty_intel":
      case "specialty_breacher":
      case "specialty_tank":
      case "specialty_kill_report":
      case "specialty_ads_mark_target":
      case "specialty_spotter":
      case "specialty_twoprimaries":
      case "specialty_munitions":
      case "specialty_stealth":
      case "specialty_extra_deadly":
      case "specialty_demolitions":
      case "specialty_offhand_provider":
      case "specialty_support":
      case "specialty_blastshield":
      case "specialty_survivor":
      case "specialty_regenfaster":
      case "specialty_healer":
      case "specialty_hardline":
      case "specialty_improved_target_mark":
      case "specialty_blindeye":
      case "specialty_lightweight":
      case "specialty_quieter":
      case "specialty_gung_ho":
      case "specialty_stun_resistance":
        break;
      default:
        var_0 = "specialty_null";
        break;
    }
  }

  return var_0;
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0.perks = [];
    var_0.perksblocked = [];
    var_0.weaponlist = [];
  }
}

function initperkdvars() {
  level.graceperiodgrenademod = 0.08;
  level.armorpiercingmod = 1.5;
  level.armorpiercingmodks = 1.25;
  level.regenfasterhealthmod = scripts\mp\utility\dvars::getintproperty("perk_fastRegenRate", 2);
  level.explosivedamagemod = scripts\mp\utility\dvars::getintproperty("perk_explosiveDamage", 40) / 100;
  level.blastshieldmod = scripts\mp\utility\dvars::getintproperty("perk_blastShieldScale", 65) / 100;
  level.completed_areas = getdvarint("perk_blastShieldScaleBR", 55) / 100;
  level.blastshieldclamp = scripts\mp\utility\dvars::getintproperty("perk_blastShieldClampHP", 80);
  level.completecollectionquest = getdvarint("perk_blastShieldClampHPBR", 200);
  level.riotshieldmod = scripts\mp\utility\dvars::getintproperty("perk_riotShield", 100) / 100;
  level.armorvestbulletdelta = scripts\mp\utility\dvars::getintproperty("perk_armorVest", 1);
  level.minspeed = scripts\mp\utility\dvars::getintproperty("perk_gpsjammer_min_speed", 100);
  level.mindistance = scripts\mp\utility\dvars::getintproperty("perk_gpsjammer_min_distance", 10);
  level.timeperiod = scripts\mp\utility\dvars::getintproperty("perk_gpsjammer_time_period", 200) / 1000;
  level.minspeedsq = level.minspeed * level.minspeed;
  level.mindistancesq = level.mindistance * level.mindistance;

  if(isDefined(level.hardcoremode) && level.hardcoremode) {
    level.blastshieldmod = scripts\mp\utility\dvars::getintproperty("perk_blastShieldScale_HC", 20) / 100;
    level.blastshieldclamp = scripts\mp\utility\dvars::getintproperty("perk_blastShieldClampHP_HC", 20);
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    level.blastshieldmod = scripts\mp\utility\dvars::dvarintvalue("blastShieldMod", 65, 0, 100) / 100;
    level.blastshieldclamp = scripts\mp\utility\dvars::dvarintvalue("blastShieldClamp", 80, 0, 100);
    return;
  }
}

function giveperks(var_0, var_1) {
  var_1 = scripts\engine\utility::ter_op(isDefined(var_1), var_1, 1);

  foreach(var_3 in var_0) {
    if(var_1) {
      var_3 = validateperk(var_3);
    }

    if(var_3 != "specialty_null") {
      scripts\mp\class::loadout_giveperk(var_3);
    }
  }
}

function _setperk(var_0) {
  if(!isDefined(self.perks)) {
    self.perks = [];
  }

  if(!isDefined(self.perks[var_0])) {
    self.perks[var_0] = 1;
  } else {
    self.perks[var_0]++;
  }

  if(self.perks[var_0] == 1 && !isDefined(self.perksblocked[var_0])) {
    _setperkinternal(var_0);
    return;
  }
}

function _setperkinternal(var_0) {
  var_1 = level.perksetfuncs[var_0];

  if(isDefined(var_1)) {
    self thread[[var_1]]();
  }

  self setperk(var_0, !isDefined(level.scriptperks[var_0]));
}

function _setextraperks(var_0) {
  if(isDefined(level.extraperkmap[var_0])) {
    foreach(var_2 in level.extraperkmap[var_0]) {
      _setperk(var_2);
      _setextraperks(var_2);
    }

    return;
  }
}

function _unsetextraperks(var_0) {
  if(isDefined(level.extraperkmap[var_0])) {
    foreach(var_2 in level.extraperkmap[var_0]) {
      _unsetperk(var_2);
      _unsetextraperks(var_2);
    }

    return;
  }
}

function _unsetperk(var_0) {
  if(!isDefined(self.perks[var_0])) {
    return;
  }

  self.perks[var_0]--;

  if(self.perks[var_0] == 0) {
    if(!isDefined(self.perksblocked[var_0])) {
      _unsetperkinternal(var_0);
    }

    self.perks[var_0] = undefined;
    return;
  }
}

function _unsetperkinternal(var_0) {
  if(isDefined(level.perkunsetfuncs[var_0])) {
    self thread[[level.perkunsetfuncs[var_0]]]();
  }

  self unsetperk(var_0, !isDefined(level.scriptperks[var_0]));
}

function _clearperks() {
  if(isDefined(self.perks)) {
    foreach(var_1 in self.perks) {
      if(isDefined(level.perkunsetfuncs[var_2])) {
        self[[level.perkunsetfuncs[var_2]]]();
      }
    }
  }

  self.perks = [];
  self.perksblocked = [];
  self clearperks();
}

function removeinvalidperks(var_0) {
  var_1 = [];

  foreach(var_3 in var_0) {
    if(validateperk(var_3) != "specialty_null") {
      var_1 = var_3;
    }
  }

  return var_1;
}

function giveperksafterspawn() {
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self endon("giveLoadout_start");
  self endon("loadout_perks_cleared");
  scripts\mp\class::loadout_giveperk("specialty_blindeye");
  scripts\mp\class::loadout_giveperk("specialty_gpsjammer");
  scripts\mp\class::loadout_giveperk("specialty_noscopeoutline");
  scripts\mp\class::loadout_giveperk("specialty_gas_grenade_resist");

  if(self.avoidkillstreakonspawntimer > 0) {
    var_0 = self.avoidkillstreakonspawntimer;

    if(istrue(self.inspawncamera)) {
      var_0 += scripts\mp\spawncamera::room_door_windows();
    }

    wait var_0;
  }

  if(scripts\mp\utility\killstreak::isplayerkillstreak(self) && isDefined(self.playerproxyagent) && isalive(self.playerproxyagent)) {
    return;
  }

  scripts\mp\class::loadout_removeperk("specialty_blindeye");
  scripts\mp\class::loadout_removeperk("specialty_gpsjammer");
  scripts\mp\class::loadout_removeperk("specialty_noscopeoutline");
  scripts\mp\class::loadout_removeperk("specialty_gas_grenade_resist");
  self notify("removed_spawn_perks");
}

function updateactiveperks(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = isDefined(var_0) && isPlayer(var_0);
  var_9 = scripts\mp\utility\weapon::isthrowingknife(var_5);
  var_10 = var_9 && isDefined(var_0) && isDefined(var_0.classname) && var_0.classname == "grenade";
  var_11 = isDefined(var_1) && isPlayer(var_1) && var_1 != var_2;

  if(var_11 && (var_8 || var_10)) {
    var_1.waittoopenaltbunker = gettime();
    thread scripts\mp\perks\weaponpassives::updateweaponpassivesonkill(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_triggerhappy")) {
      var_1 thread scripts\mp\perks\perkfunctions::settriggerhappyinternal();
    }

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_boom")) {
      var_2 thread scripts\mp\perks\perkfunctions::setboominternal(var_1);
    }

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_deadeye")) {
      var_1.deadeyekillcount++;
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
      var_1 scripts\mp\perks\perkfunctions::supersprintkillrefresh_onkill();
    }

    if(var_1 scripts\mp\utility\perk::_hasperk("specialty_reduce_regen_delay_on_kill")) {
      var_1 scripts\mp\perks\perkfunctions::regendelayreduce_onkill();
      return;
    }

    return;
  }
}

function setomnvarsforperklist(var_0, var_1) {
  var_2 = [];

  foreach(var_4 in var_1) {
    if(!isDefined(level.perktable[var_4])) {
      continue;
    }

    var_5 = getperkslot(var_4);

    if(!isDefined(var_5)) {
      continue;
    }

    if(!isDefined(var_2[var_5])) {
      var_2 = [];
    }

    var_2[var_2[var_5].size] = level.perktable[var_4].id;
  }

  var_7 = [];

  for(var_5 = 1; var_5 < 4; var_5++) {
    if(isDefined(var_2[var_5])) {
      foreach(var_4 in var_2[var_5]) {
        var_7 = var_4;
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

function isperkinloadout(var_0) {
  var_1 = self.pers["loadoutPerks"];

  foreach(var_3 in var_1) {
    if(var_3 == var_0) {
      return true;
    }
  }

  return false;
}

function getperkid(var_0) {
  if(!isDefined(var_0) || !isDefined(level.perktable[var_0])) {
    return 0;
  }

  return level.perktable[var_0].id;
}