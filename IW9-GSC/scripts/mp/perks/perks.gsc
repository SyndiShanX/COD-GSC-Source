/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\perks.gsc
***********************************************/

init() {
  level thread scripts\mp\perks\perkfunctions::rechargeequipmentthink_init();
  level thread scripts\mp\perks\perkfunctions::supersprintkillrefresh_init();
  level thread scripts\mp\perks\perkfunctions::sixthsense_think();
  level.perkfuncs = [];
  level.scriptperks = [];
  level._id_8115DC9EC10AD4AD = [];
  level.perksetfuncs = [];
  level.perkunsetfuncs = [];
  level.extraperkmap = [];
  level.menurigperks = [];
  game["dialog"]["specialty_restock"] = "iw9_perk_prks_uktl_pers";
  game["dialog"]["specialty_hardline"] = "iw9_perk_prks_uktl_pehl";
  game["dialog"]["specialty_tactical_recon"] = "iw9_perk_prks_uktl_pesp";
  game["dialog"]["specialty_focus"] = "iw9_perk_prks_uktl_pefc";
  game["dialog"]["specialty_covert_ops"] = "iw9_perk_prks_uktl_pecb";
  game["dialog"]["specialty_warhead"] = "iw9_perk_prks_uktl_pefh";
  game["dialog"]["specialty_quick_fix"] = "iw9_perk_prks_uktl_peqf";
  game["dialog"]["specialty_surveillance"] = "iw9_perk_prks_uktl_peha";
  game["dialog"]["specialty_guerrilla"] = "iw9_perk_prks_uktl_pegh";
  game["dialog"]["specialty_overwatch"] = "iw9_perk_prks_uktl_pebe";
  game["dialog"]["specialty_survivor"] = "iw9_perk_prks_uktl_pesv";
  game["dialog"]["specialty_overcharge_field_upgrade"] = "iw9_perk_prks_uktl_peoc";

  if(_id_55E418C5CC946593::_id_C0D385A09D173A36()) {
    _id_55E418C5CC946593::_id_9FD92851E68A5662();

    if(_id_55E418C5CC946593::_id_56F3D322E17B9974())
      _id_55E418C5CC946593::_id_CA7E33035F7F102F();
  } else if(getdvarint("dvar_B01050DA9B96D273", 1)) {
    _id_287EDC73EAC41DB5 = int(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 29));
    _id_D59F742FEB2ABEC1 = int(tablelookup("mp/gametypesTable.csv", 0, scripts\mp\utility\game::getgametype(), 30));

    if(!isDefined(_id_287EDC73EAC41DB5) || _id_287EDC73EAC41DB5 <= 0)
      _id_287EDC73EAC41DB5 = 1050;

    if(!isDefined(_id_287EDC73EAC41DB5) || _id_D59F742FEB2ABEC1 <= 0)
      _id_D59F742FEB2ABEC1 = 3150;

    level._id_606EB45E074FF204 = 1;
    level._id_F36DCECDEBE6160B = getdvarint("dvar_6870BE7663E6C99F", 100);
    level._id_5A3318627FB4465D = getdvarint("dvar_0207E7EEEF2A5C8C", _id_287EDC73EAC41DB5);
    level._id_5CDAA841F503D45A = getdvarint("dvar_5617874CB4B808D5", _id_D59F742FEB2ABEC1);
    level._id_F3D4343DA6D28C4C = getdvarint("dvar_F0B8C004A14DB0A2", 0);
    level._id_F3D4353DA6D28E7F = getdvarint("dvar_F0B8C104A14DB2D5", 0);
    level._id_9C166C328FE115B7 = getdvarint("dvar_9C0E13893954DA30");
    level._id_24B471CE5E06FF1E = getdvarint("dvar_8F6F2F16EB3E92FF");
    level._id_D0AE54C9481320FA = getdvarint("dvar_443A10022BCEDD62", 0);
    level._id_3F893C812B909915 = getdvarint("dvar_1A0F0B7B29A6543B", 1);
    level._id_4AD21852735184E9 = getdvarint("dvar_92B3C30D024AA224", 0);
    level._id_63D440B3041CA2A7 = getdvarint("dvar_75676A5CBB837AEE", 0);
    thread _id_CCDBD1F6DA822D2C();
  }

  level._id_AEBBD8276F721D86 = getdvarfloat("dvar_BB66C3A69C1F7A8F", 1.5);
  level._id_100503F6600F157E = getdvarint("dvar_F8AF3C2D327B9C23", 50);
  level._id_A7B25D0A3D5B8F1E = getdvarfloat("dvar_5EC956FB006E323B", 1000);
  level._id_FBF305C1816A8C8A = getdvarfloat("dvar_8A028A50E729F737", 1500);

  if(istrue(level._id_D0AE54C9481320FA))
    level thread _id_667EC8F124FE1AB3();

  _id_301144E1B628A10C();
  registerscriptperk("specialty_ante_up", scripts\mp\perks\perkfunctions::_id_A686A690639763DA, scripts\mp\perks\perkfunctions::_id_22483F0BF514320B);
  registerscriptperk("specialty_flak_jacket", undefined, undefined, ["specialty_blastshield", "specialty_shrapnel_resist", "specialty_blastshield_limiter", "specialty_fire_resistence"], scripts\mp\perks\perkfunctions::_id_C8717DCA5558B2FB);
  registerscriptperk("specialty_blastshield_limiter", scripts\mp\perks\perkfunctions::_id_76826219412C80CE, scripts\mp\perks\perkfunctions::_id_2A071B7E5D0351D3);
  registerscriptperk("specialty_fire_resistence", scripts\mp\perks\perkfunctions::_id_DF1F464B16738E76, scripts\mp\perks\perkfunctions::_id_9A3330B21E0AD027);
  registerscriptperk("specialty_scavenger_ammo_and_equipment", undefined, undefined, ["specialty_scavenger", "specialty_scavenger_equipment"], scripts\mp\perks\perkfunctions::_id_E2DF669ADA6F810C);
  registercodeperkinfo("specialty_gungho", undefined, undefined, ["specialty_sprintoffhand", "specialty_supersprintreload"]);
  registercodeperkinfo("specialty_slayer", scripts\mp\perks\perkfunctions::_id_8D12A3F39C293F29, scripts\mp\perks\perkfunctions::_id_CD592C12C1E9CD58);
  registercodeperkinfo("specialty_operative", scripts\mp\perks\perkfunctions::_id_B8D4388CDB3CA5C8, scripts\mp\perks\perkfunctions::_id_4FCF4D3385AAFB53, ["specialty_sixth_sense"]);
  registercodeperkinfo("specialty_tactician", scripts\mp\perks\perkfunctions::_id_87C42BAF479B4429, scripts\mp\perks\perkfunctions::_id_04AF62A9306C8436, ["specialty_fastoffhand"], scripts\mp\perks\perkfunctions::_id_153CF3C8788FE8C1);
  registerscriptperk("specialty_headhunter", undefined, undefined, undefined);
  registerscriptperk("specialty_armored", scripts\mp\perks\perkfunctions::_id_6FAFF35E3A38BA5F, scripts\mp\perks\perkfunctions::_id_D02ED6D205E7EB64, undefined);
  registerscriptperk("specialty_grenade_expert", scripts\mp\perks\perkfunctions::_id_81F0718F6C5AB1D7, scripts\mp\perks\perkfunctions::_id_2BBA0E9E144C276C, ["specialty_missileprediction"]);
  registerscriptperk("specialty_extra_tactical", undefined, undefined, []);
  registerscriptperk("specialty_hustle", undefined, undefined, ["specialty_supersprint_enhanced", "specialty_fastcrouchmovement"]);
  registerscriptperk("specialty_eod", undefined, undefined, ["specialty_blastshield", "specialty_throwback", "specialty_shrapnel_resist"]);
  registerscriptperk("specialty_scavenger_plus", undefined, undefined, ["specialty_scavenger"]);
  registerscriptperk("specialty_munitions_2", undefined, undefined, ["specialty_twoprimaries"]);
  registerscriptperk("specialty_tac_resist", undefined, undefined, ["specialty_stun_resistance", "specialty_emp_resist", "specialty_gas_grenade_resist", "specialty_scrambler_resist", "specialty_snapshot_immunity"]);
  registerscriptperk("specialty_huntmaster", undefined, undefined, ["specialty_tracker", "specialty_kill_report", "specialty_silentkill"]);
  registerscriptperk("specialty_warhead", undefined, undefined, ["specialty_quickswap", "specialty_fastreload", "specialty_fastoffhand"]);
  registerscriptperk("specialty_focus", undefined, undefined, ["specialty_viewkickoverride", "specialty_improvedholdbreath"]);
  registerscriptperk("specialty_quick_fix", undefined, undefined, ["specialty_reduce_regen_delay_on_kill", "specialty_reduce_regen_delay_on_objective", "specialty_reduce_regen_delay_on_plate"]);
  registerscriptperk("specialty_covert_ops", undefined, undefined, ["specialty_blindeye", "specialty_noscopeoutline", "specialty_coldblooded", "specialty_noplayertarget", "specialty_sixth_sense_immune"]);
  registerscriptperk("specialty_tactical_recon", undefined, undefined, ["specialty_engineer", "specialty_markequipment", "specialty_hack"]);
  registerscriptperk("specialty_restock", undefined, undefined, ["specialty_recharge_equipment", "specialty_extra_deadly"]);
  registerscriptperk("specialty_survivor", scripts\mp\perks\perkfunctions::setsurvivor, scripts\mp\perks\perkfunctions::unsetsurvivor, ["specialty_pistoldeath"]);
  registerscriptperk("specialty_overcharge_field_upgrade", scripts\mp\perks\perkfunctions::_id_17F9B8D5579B7E98, scripts\mp\perks\perkfunctions::_id_448448AC4206D715, ["specialty_improved_field_upgrades", "specialty_faster_field_upgrade"]);
  registerscriptperk("specialty_overwatch", scripts\mp\perks\perkfunctions::_id_4A833BCF538DBBF0, scripts\mp\perks\perkfunctions::_id_9CEA3E4EA6FBE3D7, scripts\mp\perks\perkfunctions::_id_AF3D35751DFD4E79());
  registerscriptperk("specialty_surveillance", undefined, undefined, ["specialty_sixth_sense"]);
  registerscriptperk("specialty_guerrilla", undefined, undefined, ["specialty_ghost", "specialty_heartbreaker"]);
  registerscriptperk("specialty_hardline", scripts\mp\perks\perkfunctions::sethardline, scripts\mp\perks\perkfunctions::unsethardline, ["specialty_br_cheaper_kiosk"]);
  registercodeperkinfo("specialty_snakecam", undefined, undefined, undefined);
  registerscriptperk("specialty_pc_medic", undefined, undefined, ["specialty_medic", "specialty_br_faster_revive"]);
  registerscriptperk("specialty_pc_comms", scripts\mp\perks\perkfunctions::_id_57FA0386E81EAF33, scripts\mp\perks\perkfunctions::_id_4173E65571FBFD44);
  registerscriptperk("specialty_pc_stealth", scripts\mp\perks\perkfunctions::_id_C834F1EACBB06D09, scripts\mp\perks\perkfunctions::_id_B35C8CF5DD0E38A2, ["specialty_ghost", "specialty_heartbreaker"]);
  registerscriptperk("specialty_pc_tempered", scripts\mp\perks\perkfunctions::_id_E16E3E01EB4E705E, scripts\mp\perks\perkfunctions::_id_3BFEABC0BD9D0CBF);
  registerscriptperk("specialty_pc_high_capacity", scripts\mp\perks\perkfunctions::_id_7603AADD14DA7EC6, scripts\mp\perks\perkfunctions::_id_6AF20073381A18D3);
  registerscriptperk("specialty_super_protection");
  registerscriptperk("specialty_heavy_metal", undefined, undefined, ["specialty_chain_killstreaks", "specialty_br_extra_killstreak_chance"]);
  registerscriptperk("specialty_strategist", undefined, undefined, ["specialty_killstreak_to_scorestreak", "specialty_br_better_mission_rewards"]);
  registerscriptperk("specialty_underkill", undefined, undefined);
  registerscriptperk("specialty_third_person", scripts\mp\perks\perkfunctions::_id_756D7E15C7467312, scripts\mp\perks\perkfunctions::_id_FBD953549BE66251);
  registerscriptperk("specialty_tune_up", undefined, undefined, ["specialty_improved_field_upgrades", "specialty_faster_field_upgrade", "specialty_br_faster_revive"]);
  registerscriptperk("specialty_extra_shrapnel", undefined, undefined, ["specialty_extra_deadly", "specialty_shrapnel"]);
  registerscriptperk("specialty_specialist_bonus", scripts\mp\perks\perkfunctions::setspecialistbonus, scripts\mp\perks\perkfunctions::unsetspecialistbonus);
  registerscriptperk("specialty_mercenary", undefined, undefined, ["specialty_bounty"]);
  registerscriptperk("specialty_sonar", undefined, undefined, ["specialty_always_minimap"]);
  registerscriptperk("specialty_graverobber", undefined, undefined, ["specialty_scrap_weapons"]);
  registerscriptperk("specialty_healer", scripts\mp\perks\perkfunctions::sethealer, scripts\mp\perks\perkfunctions::unsethealer);
  registerscriptperk("specialty_breacher", scripts\mp\perks\perkfunctions::setbreacher, scripts\mp\perks\perkfunctions::unsetbreacher);
  registerscriptperk("specialty_door_breach", scripts\mp\perks\perkfunctions::setdoorbreach, scripts\mp\perks\perkfunctions::unsetdoorbreach);
  registerscriptperk("specialty_killstreak_to_scorestreak", scripts\mp\perks\perkfunctions::setkillstreaktoscorestreak, scripts\mp\perks\perkfunctions::unsetkillstreaktoscorestreak);
  registerscriptperk("specialty_improved_field_upgrades");
  registerscriptperk("specialty_recharge_equipment", scripts\mp\perks\perkfunctions::setrechargeequipment, scripts\mp\perks\perkfunctions::unsetrechargeequipment);
  registerscriptperk("specialty_super_sprint_kill_refresh");
  registerscriptperk("specialty_markequipment", scripts\mp\perks\perkfunctions::setmarkequipment, scripts\mp\perks\perkfunctions::unsetmarkequipment);
  registerscriptperk("specialty_chain_killstreaks", scripts\mp\perks\perkfunctions::setchainkillstreaks, scripts\mp\perks\perkfunctions::unsetchainkillstreaks);
  registerscriptperk("specialty_scrap_weapons", scripts\mp\perks\perkfunctions::setscrapweapons, scripts\mp\perks\perkfunctions::unsetscrapweapons);
  registerscriptperk("specialty_door_alarm", scripts\mp\perks\perkfunctions::setdooralarm, scripts\mp\perks\perkfunctions::unsetdooralarm);
  registerscriptperk("specialty_always_minimap", scripts\mp\perks\perkfunctions::setalwaysminimap, scripts\mp\perks\perkfunctions::unsetalwaysminimap);
  registerscriptperk("specialty_shrapnel");
  registerscriptperk("specialty_team_scavenger");
  registerscriptperk("specialty_fastreload_launchers", scripts\mp\perks\perkfunctions::setfastreloadlaunchers, scripts\mp\perks\perkfunctions::unsetfastreloadlaunchers);
  registerscriptperk("specialty_emp_resist");
  registerscriptperk("specialty_sixth_sense_immune");
  registerscriptperk("specialty_shrapnel_resist");
  registerscriptperk("specialty_reduce_regen_delay_on_kill", scripts\mp\perks\perkfunctions::setreduceregendelayonkill, scripts\mp\perks\perkfunctions::unsetreduceregendelayonkill);
  registerscriptperk("specialty_reduce_regen_delay_on_objective", scripts\mp\perks\perkfunctions::setreduceregendelayonobjective, scripts\mp\perks\perkfunctions::unsetreduceregendelayonobjective);
  registerscriptperk("specialty_reduce_regen_delay_on_plate");
  registerscriptperk("specialty_scrambler_resist");
  registerscriptperk("specialty_no_battle_chatter");
  registerscriptperk("specialty_engineer", scripts\mp\perks\perkfunctions::setengineer, scripts\mp\perks\perkfunctions::unsetengineer, ["specialty_outlinekillstreaks"]);
  registerscriptperk("speciality_undying", scripts\mp\perks\perkfunctions::_id_D31614685FB778E1, scripts\mp\perks\perkfunctions::_id_62E54942C53B9BDA);
  registerscriptperk("specialty_br_cheaper_kiosk");
  registerscriptperk("specialty_br_faster_revive");
  registerscriptperk("specialty_br_better_mission_rewards", scripts\mp\perks\perkfunctions::setbettermissionrewards, scripts\mp\perks\perkfunctions::unsetbettermissionrewards);
  registerscriptperk("specialty_br_extra_killstreak_chance");
  registerscriptperk("specialty_regenfaster", scripts\mp\perks\perkfunctions::setregenfaster, scripts\mp\perks\perkfunctions::unsetregenfaster);
  registerscriptperk("specialty_medic");
  registerscriptperk("specialty_regen_delay_reduced", scripts\mp\perks\perkfunctions::setreduceregendelay, scripts\mp\perks\perkfunctions::unsetreduceregendelay);
  registerscriptperk("specialty_can_be_revived");
  registerscriptperk("specialty_kill_report");
  registerscriptperk("specialty_ads_mark_target", scripts\mp\perks\perkfunctions::setadsmarktarget, scripts\mp\perks\perkfunctions::unsetadsmarktarget);
  registerscriptperk("specialty_armorvest", scripts\mp\perks\perkfunctions::setarmorvest, scripts\mp\perks\perkfunctions::unsetarmorvest);
  registerscriptperk("specialty_tracker", scripts\mp\perks\perkfunctions::settracker, scripts\mp\perks\perkfunctions::unsettracker, ["specialty_tracker_pro"]);
  registerscriptperk("specialty_ghost", scripts\mp\perks\perkfunctions::setghost, scripts\mp\perks\perkfunctions::unsetghost, ["specialty_gpsjammer"]);
  registerscriptperk("specialty_helmet", scripts\mp\perks\perkfunctions::sethelmet, scripts\mp\perks\perkfunctions::unsethelmet);
  registerscriptperk("specialty_extra_deadly", scripts\mp\perks\perkfunctions::setextradeadly, scripts\mp\perks\perkfunctions::unsetextradeadly);
  registerscriptperk("specialty_remote_defuse", scripts\mp\perks\perkfunctions::setremotedefuse, scripts\mp\perks\perkfunctions::unsetremotedefuse);
  registerscriptperk("specialty_hack");
  registerscriptperk("specialty_faster_field_upgrade");
  registerscriptperk("specialty_improved_target_mark");
  registerscriptperk("specialty_door_sense", scripts\mp\perks\perkfunctions::setdoorsense, scripts\mp\perks\perkfunctions::unsetdoorsense);
  registerscriptperk("specialty_worsenedgunkick", scripts\mp\perks\perkfunctions::setworsenedgunkick, scripts\mp\perks\perkfunctions::unsetworsenedgunkick);
  registerscriptperk("specialty_ammo_disabling");
  registerscriptperk("specialty_gunperk_xp");
  registerscriptperk("specialty_location_marking", scripts\mp\perks\perkfunctions::setlocationmarking, scripts\mp\perks\perkfunctions::unsetlocationmarking);
  registerscriptperk("specialty_swimming", undefined, undefined, ["specialty_spygame", "specialty_coldblooded"]);
  registerscriptperk("specialty_afterburner", scripts\mp\perks\perkfunctions::setafterburner, scripts\mp\perks\perkfunctions::unsetafterburner, ["specialty_thruster"]);
  registerscriptperk("specialty_autospot", scripts\mp\perks\perkfunctions::setautospot, scripts\mp\perks\perkfunctions::unsetautospot);
  registerscriptperk("specialty_boom", scripts\mp\perks\perkfunctions::setboom, scripts\mp\perks\perkfunctions::unsetboom);
  registerscriptperk("specialty_delaymine", scripts\mp\perks\perkfunctions::setdelaymine, scripts\mp\perks\perkfunctions::unsetdelaymine);
  registerscriptperk("specialty_hardwired", undefined, undefined, ["specialty_tracker_jammer", "specialty_noscopeoutline", "specialty_empimmune"]);
  registerscriptperk("specialty_empimmune", scripts\mp\perks\perkfunctions::setempimmune, scripts\mp\perks\perkfunctions::unsetempimmune);
  registerscriptperk("specialty_explosivedamage");
  registerscriptperk("specialty_extraammo", scripts\mp\perks\perkfunctions::setextraammo, scripts\mp\perks\perkfunctions::unsetextraammo);
  registerscriptperk("specialty_falldamage", scripts\mp\perks\perkfunctions::setfreefall, scripts\mp\perks\perkfunctions::unsetfreefall);
  registerscriptperk("specialty_hard_shell", scripts\mp\perks\perkfunctions::sethardshell, scripts\mp\perks\perkfunctions::unsethardshell);
  registerscriptperk("specialty_powercell", scripts\mp\perks\perkfunctions::setpowercell, scripts\mp\perks\perkfunctions::unsetpowercell);
  registerscriptperk("specialty_incog", scripts\mp\perks\perkfunctions::setincog, scripts\mp\perks\perkfunctions::unsetincog);
  registerscriptperk("specialty_localjammer", scripts\mp\perks\perkfunctions::setlocaljammer, scripts\mp\perks\perkfunctions::unsetlocaljammer);
  registerscriptperk("specialty_overclock", scripts\mp\perks\perkfunctions::setoverclock, scripts\mp\perks\perkfunctions::unsetoverclock);
  registerscriptperk("specialty_outlinekillstreaks", scripts\mp\perks\perkfunctions::setoutlinekillstreaks, scripts\mp\perks\perkfunctions::unsetoutlinekillstreaks);
  registerscriptperk("specialty_pitcher", scripts\mp\perks\perkfunctions::setpitcher, scripts\mp\perks\perkfunctions::unsetpitcher, ["specialty_throwback"]);
  registerscriptperk("specialty_stun_resistance", scripts\mp\perks\perkfunctions::setstunresistance, scripts\mp\perks\perkfunctions::unsetstunresistance, ["specialty_hard_shell"]);
  registerscriptperk("specialty_twoprimaries", scripts\mp\perks\perkfunctions::setoverkill, scripts\mp\perks\perkfunctions::unsetoverkill, []);
  registerscriptperk("specialty_bullet_outline", scripts\mp\perks\perkfunctions::setbulletoutline, scripts\mp\perks\perkfunctions::unsetbulletoutline);
  registerscriptperk("specialty_activereload", scripts\mp\perks\perkfunctions::setactivereload, scripts\mp\perks\perkfunctions::unsetactivereload);
  registerscriptperk("specialty_sixth_sense", scripts\mp\perks\perkfunctions::setsixthsense, scripts\mp\perks\perkfunctions::unsetsixthsense);
  registerscriptperk("specialty_enhanced_sixth_sense", scripts\mp\perks\perkfunctions::setenhancedsixthsense, scripts\mp\perks\perkfunctions::unsetenhancedsixthsense);
  registerscriptperk("specialty_meleekill", scripts\mp\perks\perkfunctions::setmeleekill, scripts\mp\perks\perkfunctions::unsetmeleekill);
  registerscriptperk("specialty_gung_ho");
  registerscriptperk("specialty_man_at_arms", scripts\mp\perks\perkfunctions::setmanatarms, scripts\mp\perks\perkfunctions::unsetmanatarms, ["specialty_extraammo", "specialty_overrideweaponspeed"]);
  registerscriptperk("specialty_momentum", scripts\mp\perks\perkfunctions::setmomentum, scripts\mp\perks\perkfunctions::unsetmomentum);
  registerscriptperk("specialty_improvedmelee", scripts\mp\perks\perkfunctions::setimprovedmelee, scripts\mp\perks\perkfunctions::unsetimprovedmelee, ["specialty_extendedmelee", "specialty_fastermelee", "specialty_thief"]);
  registerscriptperk("specialty_thief", scripts\mp\perks\perkfunctions::setthief, scripts\mp\perks\perkfunctions::unsetthief);
  registerscriptperk("specialty_silentkill");
  registerscriptperk("specialty_armorpiercingks");
  registerscriptperk("specialty_fastcrouch", scripts\mp\perks\perkfunctions::setfastcrouch, scripts\mp\perks\perkfunctions::unsetfastcrouch);
  registerscriptperk("specialty_bulletdamage", undefined, undefined, ["specialty_overcharge", "specialty_worsenedgunkick"]);
  registerscriptperk("specialty_solobuddyboost", scripts\mp\perks\perkfunctions::setsolobuddyboost, scripts\mp\perks\perkfunctions::unsetsolobuddyboost);
  registerscriptperk("specialty_offhand_provider", scripts\mp\perks\perkfunctions::setoffhandprovider, scripts\mp\perks\perkfunctions::unsetoffhandprovider);
  registerscriptperk("specialty_glintreduce");
  registerscriptperk("specialty_gas_grenade_resist", scripts\mp\perks\perkfunctions::setgasgrenaderesist, scripts\mp\perks\perkfunctions::unsetgasgrenaderesist);
  registerscriptperk("specialty_extra_planted_equipment");
  registerscriptperk("specialty_blastshield");
  registerscriptperk("specialty_bulletsuppress", scripts\mp\perks\perkfunctions::_id_7CFA6000210CBD68, scripts\mp\perks\perkfunctions::_id_F1A813FE1B8A2275);
  registerscriptperk("specialty_battleslide", scripts\mp\perks\perkfunctions::setbattleslide, scripts\mp\perks\perkfunctions::unsetbattleslide);
  registerscriptperk("specialty_battleslide_offense", scripts\mp\perks\perkfunctions::setbattleslideoffense, scripts\mp\perks\perkfunctions::unsetbattleslideoffense);
  registerscriptperk("specialty_battleslide_shield", scripts\mp\perks\perkfunctions::setbattleslideshield, scripts\mp\perks\perkfunctions::unsetbattleslideshield);
  registerscriptperk("specialty_disruptor_punch", scripts\mp\perks\perkfunctions::setdisruptorpunch, scripts\mp\perks\perkfunctions::unsetdisruptorpunch);
  registerscriptperk("specialty_ground_pound", scripts\mp\perks\perkfunctions::setgroundpound, scripts\mp\perks\perkfunctions::unsetgroundpound);
  registerscriptperk("specialty_ground_pound_shield", scripts\mp\perks\perkfunctions::setgroundpoundshield, scripts\mp\perks\perkfunctions::unsetgroundpoundshield);
  registerscriptperk("specialty_ground_pound_shock", scripts\mp\perks\perkfunctions::setgroundpoundshock, scripts\mp\perks\perkfunctions::unsetgroundpoundshock);
  registerscriptperk("specialty_thruster", scripts\mp\perks\perkfunctions::setthruster, scripts\mp\perks\perkfunctions::unsetthruster);
  registerscriptperk("specialty_dodge", scripts\mp\perks\perkfunctions::setdodge, scripts\mp\perks\perkfunctions::unsetdodge);
  registerscriptperk("specialty_extra_dodge", scripts\mp\perks\perkfunctions::setextradodge, scripts\mp\perks\perkfunctions::unsetextradodge);
  registerscriptperk("specialty_extend_dodge", scripts\mp\perks\perkfunctions::setextenddodge, scripts\mp\perks\perkfunctions::unsetextenddodge);
  registerscriptperk("specialty_phase_slide", scripts\mp\perks\perkfunctions::setphaseslide, scripts\mp\perks\perkfunctions::unsetphaseslide);
  registerscriptperk("specialty_tele_slide", scripts\mp\perks\perkfunctions::setteleslide, scripts\mp\perks\perkfunctions::unsetteleslide);
  registerscriptperk("specialty_phaseslash", undefined, undefined, ["specialty_phaseslash_rephase"]);
  registerscriptperk("specialty_phaseslash_rephase", scripts\mp\perks\perkfunctions::setphaseslashrephase, scripts\mp\perks\perkfunctions::unsetphaseslashrephase);
  registerscriptperk("specialty_phase_fall", scripts\mp\perks\perkfunctions::setphasefall, scripts\mp\perks\perkfunctions::unsetphasefall);
  registerscriptperk("specialty_aura_quickswap", scripts\mp\perks\perkfunctions::setauraquickswap, scripts\mp\perks\perkfunctions::unsetauraquickswap);
  registerscriptperk("specialty_aura_speed", scripts\mp\perks\perkfunctions::setauraspeed, scripts\mp\perks\perkfunctions::unsetauraspeed);
  registerscriptperk("specialty_mark_targets", scripts\mp\perks\perkfunctions::setmarktargets, scripts\mp\perks\perkfunctions::unsetmarktargets);
  registerscriptperk("specialty_batterypack", scripts\mp\perks\perkfunctions::setbatterypack, scripts\mp\perks\perkfunctions::unsetbatterypack);
  registerscriptperk("specialty_camo_elite", scripts\mp\perks\perkfunctions::setcamoelite, scripts\mp\perks\perkfunctions::unsetcamoelite);
  registerscriptperk("specialty_scorestreakpack", scripts\mp\perks\perkfunctions::setscorestreakpack, scripts\mp\perks\perkfunctions::unsetscorestreakpack);
  registerscriptperk("specialty_superpack", scripts\mp\perks\perkfunctions::setsuperpack, scripts\mp\perks\perkfunctions::unsetsuperpack);
  registerscriptperk("specialty_dodge_defense", scripts\mp\perks\perkfunctions::setdodgedefense, scripts\mp\perks\perkfunctions::unsetdodgedefense);
  registerscriptperk("specialty_spawncloak", scripts\mp\perks\perkfunctions::setspawncloak, scripts\mp\perks\perkfunctions::unsetspawncloak);
  registerscriptperk("specialty_commando");
  registerscriptperk("specialty_personal_trophy", scripts\mp\perks\perkfunctions::setpersonaltrophy, scripts\mp\perks\perkfunctions::unsetpersonaltrophy);
  registerscriptperk("specialty_equipment_ping", scripts\mp\perks\perkfunctions::setequipmentping, scripts\mp\perks\perkfunctions::unsetequipmentping, ["specialty_paint"]);
  registerscriptperk("specialty_cloak", scripts\mp\perks\perkfunctions::setcloak, scripts\mp\perks\perkfunctions::unsetcloak);
  registerscriptperk("specialty_wall_lock", scripts\mp\perks\perkfunctions::setwalllock, scripts\mp\perks\perkfunctions::unsetwalllock);
  registerscriptperk("specialty_rush", scripts\mp\perks\perkfunctions::setrush, scripts\mp\perks\perkfunctions::unsetrush);
  registerscriptperk("specialty_hover", scripts\mp\perks\perkfunctions::sethover, scripts\mp\perks\perkfunctions::unsethover);
  registerscriptperk("specialty_scavenger_eqp", scripts\mp\perks\perkfunctions::setscavengereqp, scripts\mp\perks\perkfunctions::unsetscavengereqp);
  registerscriptperk("specialty_spawnview", scripts\mp\perks\perkfunctions::setspawnview, scripts\mp\perks\perkfunctions::unsetspawnview);
  registerscriptperk("specialty_headgear", scripts\mp\perks\perkfunctions::setheadgear, scripts\mp\perks\perkfunctions::unsetheadgear);
  registerscriptperk("specialty_ftlslide", scripts\mp\perks\perkfunctions::setftlslide, scripts\mp\perks\perkfunctions::unsetftlslide);
  registerscriptperk("specialty_improved_prone", scripts\mp\perks\perkfunctions::setimprovedprone, scripts\mp\perks\perkfunctions::unsetimprovedprone);
  registerscriptperk("specialty_support_killstreaks", scripts\mp\perks\perkfunctions::setsupportkillstreaks, scripts\mp\perks\perkfunctions::unsetsupportkillstreaks);
  registerscriptperk("specialty_overrideweaponspeed", scripts\mp\perks\perkfunctions::setoverrideweaponspeed, scripts\mp\perks\perkfunctions::unsetoverrideweaponspeed);
  registerscriptperk("specialty_cloak_aerial", scripts\mp\perks\perkfunctions::setcloakaerial, scripts\mp\perks\perkfunctions::unsetcloakaerial);
  registerscriptperk("specialty_spawn_radar", scripts\mp\perks\perkfunctions::setspawnradar, scripts\mp\perks\perkfunctions::unsetspawnradar);
  registerscriptperk("specialty_ads_awareness", scripts\mp\perks\perkfunctions::setadsawareness, scripts\mp\perks\perkfunctions::unsetadsawareness);
  registerscriptperk("specialty_rearguard", scripts\mp\perks\perkfunctions::setrearguard, scripts\mp\perks\perkfunctions::unsetrearguard);
  registerscriptperk("specialty_rugged_eqp");
  registerscriptperk("specialty_sharp_focus", scripts\mp\perks\perkfunctions::setsharpfocus, scripts\mp\perks\perkfunctions::unsetsharpfocus);
  registerscriptperk("specialty_bling");
  registerscriptperk("specialty_comexp", scripts\mp\perks\perkfunctions::setcomexp, scripts\mp\perks\perkfunctions::unsetcomexp);
  registerscriptperk("specialty_paint");
  registerscriptperk("specialty_paint_pro");
  registerscriptperk("specialty_steadyaimpro", scripts\mp\perks\perkfunctions::setsteadyaimpro, scripts\mp\perks\perkfunctions::unsetsteadyaimpro);
  registerscriptperk("specialty_block_health_regen", scripts\mp\perks\perkfunctions::setblockhealthregen, scripts\mp\perks\perkfunctions::unsetblockhealthregen);
  registerscriptperk("specialty_rshieldradar", scripts\mp\perks\perkfunctions::setrshieldradar, scripts\mp\perks\perkfunctions::unsetrshieldradar);
  registerscriptperk("specialty_rshieldscrambler", scripts\mp\perks\perkfunctions::setrshieldscrambler, scripts\mp\perks\perkfunctions::unsetrshieldscrambler);
  registerscriptperk("specialty_delayhealing");
  registerscriptperk("specialty_wounding");
  registerscriptperk("specialty_explosivebullet");
  registerscriptperk("specialty_armorpiercing");
  registerscriptperk("specialty_hardmelee");
  registerscriptperk("specialty_highlight");
  registerscriptperk("specialty_incendiary");
  registerscriptperk("specialty_incendiary_alt");
  registerscriptperk("specialty_flashlight");
  registerscriptperk("specialty_glintxsml");
  registerscriptperk("specialty_glintsml");
  registerscriptperk("specialty_glintmed");
  registerscriptperk("specialty_glintlrg");
  registerscriptperk("specialty_glintxlrg");
  registerscriptperk("specialty_extraclip");
  registerscriptperk("specialty_smags");
  registerscriptperk("specialty_akimbo");
  registerscriptperk("specialty_gunmelee");
  registerscriptperk("specialty_magwell", undefined, undefined, ["specialty_fastreload"]);
  registerscriptperk("specialty_combathigh", scripts\mp\perks\perkfunctions::setcombathigh, scripts\mp\perks\perkfunctions::unsetcombathigh);
  registerscriptperk("specialty_juiced", scripts\mp\perks\perkfunctions::setjuiced, scripts\mp\perks\perkfunctions::unsetjuiced);
  registerscriptperk("specialty_revenge", scripts\mp\perks\perkfunctions::setrevenge, scripts\mp\perks\perkfunctions::unsetrevenge);
  registerscriptperk("specialty_light_armor", scripts\mp\perks\perkfunctions::setlightarmor, scripts\mp\perks\perkfunctions::unsetlightarmor);
  registerscriptperk("specialty_carepackage", scripts\mp\perks\perkfunctions::setcarepackage, scripts\mp\perks\perkfunctions::unsetcarepackage);
  registerscriptperk("specialty_stopping_power");
  registerscriptperk("specialty_uav", scripts\mp\perks\perkfunctions::setuav, scripts\mp\perks\perkfunctions::unsetuav);
  registerscriptperk("specialty_viewkickoverride", scripts\mp\perks\perkfunctions::setviewkickoverride, scripts\mp\perks\perkfunctions::unsetviewkickoverride);
  registerscriptperk("specialty_affinityspeedboost", scripts\mp\perks\perkfunctions::setaffinityspeedboost, scripts\mp\perks\perkfunctions::unsetaffinityspeedboost);
  registerscriptperk("specialty_affinityextralauncher", scripts\mp\perks\perkfunctions::setaffinityextralauncher, scripts\mp\perks\perkfunctions::unsetaffinityextralauncher);
  registerscriptperk("specialty_equip_throwingKnife", scripts\mp\perks\perkfunctions::setthrowingknifemelee, scripts\mp\perks\perkfunctions::unsetthrowingknifemelee);
  registerscriptperk("specialty_tacticalinsertion", scripts\mp\perks\perkfunctions::settacticalinsertion, scripts\mp\perks\perkfunctions::unsettacticalinsertion);
  weaponpassives = scripts\mp\passives::getweapontypepassives();

  foreach(_id_D8DA47E8DAA32CE6 in weaponpassives) {
    level.scriptperks[_id_D8DA47E8DAA32CE6] = 1;
    _id_F6EC76E875E6F59E = scripts\mp\passives::getpassiveperk(_id_D8DA47E8DAA32CE6);

    if(isDefined(_id_F6EC76E875E6F59E))
      level.extraperkmap[_id_D8DA47E8DAA32CE6] = [_id_F6EC76E875E6F59E];
  }

  registerscriptperk("specialty_talkinggun_test1", _id_189B67B2735B981D::_id_096F59FEFD781E47, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_test2", _id_189B67B2735B981D::_id_096F5AFEFD78207A, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_test3", _id_189B67B2735B981D::_id_096F5BFEFD7822AD, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_test4", _id_189B67B2735B981D::_id_096F54FEFD781348, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_announcer", _id_189B67B2735B981D::_id_FC6E0B02ABB995CB, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_robot", _id_189B67B2735B981D::_id_73E4AE4F932E9F30, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_blackcell", _id_189B67B2735B981D::_id_CC0FDDFE26B772A7, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_npc", _id_189B67B2735B981D::_id_FC09644394BF843F, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_cat", _id_189B67B2735B981D::_id_44D73A43CA35CBCC, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_talkinggun_dog", _id_189B67B2735B981D::_id_514A7643D295A3A2, _id_189B67B2735B981D::_id_DA3D9F34D24AC85A);
  registerscriptperk("specialty_doomscreen", _id_189B67B2735B981D::_id_62E0BCEF615A8D1D, _id_189B67B2735B981D::_id_ADE69726300553AC);
  registerscriptperk("specialty_null");
  registercodeperkinfo("specialty_thermal", scripts\mp\perks\perkfunctions::setthermal, scripts\mp\perks\perkfunctions::unsetthermal);
  registercodeperkinfo("specialty_lightweight", scripts\mp\perks\perkfunctions::setlightweight, scripts\mp\perks\perkfunctions::unsetlightweight);
  registercodeperkinfo("specialty_steelnerves", scripts\mp\perks\perkfunctions::setsteelnerves, scripts\mp\perks\perkfunctions::unsetsteelnerves);
  registercodeperkinfo("specialty_saboteur", scripts\mp\perks\perkfunctions::setsaboteur, scripts\mp\perks\perkfunctions::unsetsaboteur);
  registercodeperkinfo("specialty_endgame", scripts\mp\perks\perkfunctions::setendgame, scripts\mp\perks\perkfunctions::unsetendgame);
  registercodeperkinfo("specialty_onemanarmy", scripts\mp\perks\perkfunctions::setonemanarmy, scripts\mp\perks\perkfunctions::unsetonemanarmy);
  registercodeperkinfo("specialty_weaponlaser", scripts\mp\perks\perkfunctions::setweaponlaser, scripts\mp\perks\perkfunctions::unsetweaponlaser);
  registercodeperkinfo("specialty_marksman", scripts\mp\perks\perkfunctions::setmarksman, scripts\mp\perks\perkfunctions::unsetmarksman);
  registercodeperkinfo("specialty_holdbreath", undefined, undefined);
  registercodeperkinfo("specialty_fastermelee", undefined, undefined);
  registercodeperkinfo("specialty_double_load", scripts\mp\perks\perkfunctions::setdoubleload, scripts\mp\perks\perkfunctions::unsetdoubleload);
  registercodeperkinfo("specialty_overkill_pro", scripts\mp\perks\perkfunctions::setoverkillpro, scripts\mp\perks\perkfunctions::unsetoverkillpro);
  registercodeperkinfo("specialty_refill_grenades", scripts\mp\perks\perkfunctions::setrefillgrenades, scripts\mp\perks\perkfunctions::unsetrefillgrenades);
  registercodeperkinfo("specialty_refill_ammo", scripts\mp\perks\perkfunctions::setrefillammo, scripts\mp\perks\perkfunctions::unsetrefillammo);
  registercodeperkinfo("specialty_combat_speed", scripts\mp\perks\perkfunctions::setcombatspeed, scripts\mp\perks\perkfunctions::unsetcombatspeed);
  registercodeperkinfo("specialty_tagger", scripts\mp\perks\perkfunctions::settagger, scripts\mp\perks\perkfunctions::unsettagger);
  registercodeperkinfo("specialty_triggerhappy", scripts\mp\perks\perkfunctions::settriggerhappy, scripts\mp\perks\perkfunctions::unsettriggerhappy);
  registercodeperkinfo("specialty_blindeye", scripts\mp\perks\perkfunctions::setblindeye, scripts\mp\perks\perkfunctions::unsetblindeye);
  registercodeperkinfo("specialty_quickswap", scripts\mp\perks\perkfunctions::setquickswap, scripts\mp\perks\perkfunctions::unsetquickswap, ["specialty_fastoffhand"]);
  registercodeperkinfo("specialty_extra_equipment");
  registercodeperkinfo("specialty_lifepack", scripts\mp\perks\perkfunctions::setlifepack, scripts\mp\perks\perkfunctions::unsetlifepack);
  registercodeperkinfo("specialty_toughenup", scripts\mp\perks\perkfunctions::settoughenup, scripts\mp\perks\perkfunctions::unsettoughenup);
  registercodeperkinfo("specialty_scoutping", scripts\mp\perks\perkfunctions::setscoutping, scripts\mp\perks\perkfunctions::unsetscoutping);
  registercodeperkinfo("specialty_phase_speed", scripts\mp\perks\perkfunctions::setphasespeed, scripts\mp\perks\perkfunctions::unsetphasespeed);
  registercodeperkinfo("specialty_camo_clone", scripts\mp\perks\perkfunctions::setcamoclone, scripts\mp\perks\perkfunctions::unsetcamoclone);
  registercodeperkinfo("specialty_improvedgunkick");
  registercodeperkinfo("specialty_sprintfire", undefined, undefined, ["specialty_fastsprintrecovery"]);
  registercodeperkinfo("specialty_overcharge", scripts\mp\perks\perkfunctions::setovercharge, scripts\mp\perks\perkfunctions::unsetovercharge);
  registercodeperkinfo("specialty_supersprint_enhanced", scripts\mp\perks\perkfunctions::setsupersprintenhanced, scripts\mp\perks\perkfunctions::unsetsupersprintenhanced);
  registercodeperkinfo("specialty_noscopeoutline", scripts\mp\perks\perkfunctions::setnoscopeoutline, scripts\mp\perks\perkfunctions::unsetnoscopeoutline);
  registercodeperkinfo("specialty_snapshot_immunity");
  registercodeperkinfo("specialty_spygame");
  registercodeperkinfo("specialty_dexterity", undefined, undefined, ["specialty_quickswap"]);
  registercodeperkinfo("specialty_autoaimhead", undefined, undefined);
  initperkdvars();
  level thread onplayerconnect();
}

registerscriptperk(perkname, setfunc, unsetfunc, extraperkmap, _id_EC2EC5F083DF61CD) {
  registerperk(perkname, 1, setfunc, unsetfunc, extraperkmap, _id_EC2EC5F083DF61CD);
}

registercodeperkinfo(perkname, setfunc, unsetfunc, extraperkmap, _id_EC2EC5F083DF61CD) {
  registerperk(perkname, 0, setfunc, unsetfunc, extraperkmap, _id_EC2EC5F083DF61CD);
}

registerperk(perkname, _id_9AA715F8120F5692, setfunc, unsetfunc, extraperkmap, _id_EC2EC5F083DF61CD) {
  if(_id_E6D4BDE94154C10E(perkname) && !isDefined(level._id_A1AD2758FCBD2F5E[perkname])) {
    return;
  }
  if(istrue(_id_9AA715F8120F5692))
    level.scriptperks[perkname] = 1;
  else
    level._id_8115DC9EC10AD4AD[perkname] = 1;

  if(isDefined(setfunc))
    level.perksetfuncs[perkname] = setfunc;

  if(isDefined(unsetfunc))
    level.perkunsetfuncs[perkname] = unsetfunc;

  if(isDefined(extraperkmap))
    level.extraperkmap[perkname] = extraperkmap;

  if(isDefined(_id_EC2EC5F083DF61CD))
    self[[_id_EC2EC5F083DF61CD]]();
}

_id_F45C19871B412EA5(perkname) {
  return isDefined(level.scriptperks[perkname]) || isDefined(level._id_8115DC9EC10AD4AD[perkname]);
}

_id_E6D4BDE94154C10E(perkname) {
  return isDefined(level._id_FFC23517BDB76237[perkname]);
}

_id_301144E1B628A10C() {
  if(!isDefined(level._id_A1AD2758FCBD2F5E))
    level._id_A1AD2758FCBD2F5E = [];

  level._id_D5F3DCF05B7E8BE6 = [];
  level._id_FFC23517BDB76237 = [];
  _id_3AC7980D8CA4B1AD = undefined;
  _id_3AC7980D8CA4B1AD = getscriptbundle("perklist:" + level._id_1A2B600A06EC21F4._id_5F366B3FE39302D6);

  if(!isDefined(_id_3AC7980D8CA4B1AD._id_5F366B3FE39302D6)) {
    return;
  }
  _id_ADF241ECC8935598 = 1;

  foreach(id, _id_5B4192A2AF2B26CB in _id_3AC7980D8CA4B1AD._id_5F366B3FE39302D6) {
    if(!isnumber(id)) {
      continue;
    }
    if(!isDefined(_id_5B4192A2AF2B26CB)) {
      continue;
    }
    perkref = _id_5B4192A2AF2B26CB.ref;

    if(!isDefined(perkref)) {
      continue;
    }
    level._id_FFC23517BDB76237[perkref] = perkref;

    if(_id_ADF241ECC8935598 == 0 && perkref == "specialty_null") {
      continue;
    }
    _id_AC6FD57A63D31232 = _id_5B4192A2AF2B26CB._id_D442547D75DFFD09;

    if(!isDefined(_id_AC6FD57A63D31232)) {
      continue;
    }
    if(_id_AC6FD57A63D31232 == "replace_me") {
      continue;
    }
    _id_D442547D75DFFD09 = getscriptbundle("perk:" + _id_AC6FD57A63D31232);

    if(!isDefined(_id_D442547D75DFFD09)) {
      continue;
    }
    level._id_A1AD2758FCBD2F5E[perkref] = _id_D442547D75DFFD09;
    level._id_D5F3DCF05B7E8BE6[perkref] = id;

    if(isDefined(_id_D442547D75DFFD09._id_157EDC9E5F97FACF))
      game["dialog"][perkref] = _id_D442547D75DFFD09._id_157EDC9E5F97FACF;
  }
}

initspecialistkillstreaks() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialist_perk_1", undefined, ::onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialist_perk_2", undefined, ::onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialist_perk_3", undefined, ::onspecialistkillstreakavailable);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("specialist_perk_bonus", undefined, ::onspecialistbonusavailable);
}

onspecialistkillstreakavailable(_id_16EFCF27E6EFCBE8) {
  perk = getspecialistperkforstreak(_id_16EFCF27E6EFCBE8.streakname);
  scripts\mp\utility\perk::giveperk(perk);
}

getspecialistperkforstreak(streakname) {
  _id_0B8E6A73826B0264 = getspecialistindexforstreak(streakname);

  if(_id_0B8E6A73826B0264 == -1)
    return undefined;

  return self.classstruct.loadoutextraperks[_id_0B8E6A73826B0264];
}

getspecialistindexforstreak(streakname) {
  if(!isDefined(streakname))
    return -1;

  if(streakname == "specialist_perk_1")
    return 0;
  else if(streakname == "specialist_perk_2")
    return 1;
  else if(streakname == "specialist_perk_3")
    return 2;
  else
    return -1;
}

isspecialiststreak(streakname) {
  switch (streakname) {
    case "specialist_perk_bonus":
    case "specialist_perk_3":
    case "specialist_perk_2":
    case "specialist_perk_1":
      return 1;
    default:
      return 0;
  }
}

onspecialistbonusavailable(_id_16EFCF27E6EFCBE8) {
  addspecialistbonus();
}

addspecialistbonus() {
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  foreach(perk, _id_D442547D75DFFD09 in level._id_A1AD2758FCBD2F5E) {
    _id_E72DDC0FDEFE52EC = scripts\engine\utility::ter_op(_id_E005D4B70D6F2611, istrue(_id_D442547D75DFFD09.specialistbr), istrue(_id_D442547D75DFFD09.specialist));

    if(!_id_E72DDC0FDEFE52EC) {
      continue;
    }
    if(perkisrestricted(perk)) {
      continue;
    }
    scripts\mp\utility\perk::giveperk(perk);
  }

  scripts\mp\utility\perk::giveperk("specialty_specialist_bonus");
  scripts\mp\utility\perk::giveperk("specialty_lightweight");
  scripts\mp\utility\perk::giveperk("specialty_fastreload");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::giveperk("specialty_ammo_disabling");
    scripts\mp\utility\perk::giveperk("specialty_delayhealing");
    scripts\mp\utility\perk::giveperk("specialty_armorpiercing");
    scripts\mp\utility\perk::giveperk("specialty_hardmelee");
    scripts\mp\utility\perk::giveperk("specialty_marksman");
    scripts\mp\utility\perk::giveperk("specialty_gunperk_xp");
  }
}

removespecialistbonus() {
  _id_E005D4B70D6F2611 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508();

  foreach(perk, _id_D442547D75DFFD09 in level._id_A1AD2758FCBD2F5E) {
    _id_E72DDC0FDEFE52EC = scripts\engine\utility::ter_op(_id_E005D4B70D6F2611, istrue(_id_D442547D75DFFD09.specialistbr), istrue(_id_D442547D75DFFD09.specialist));

    if(!_id_E72DDC0FDEFE52EC) {
      continue;
    }
    if(perkisrestricted(perk)) {
      continue;
    }
    scripts\mp\utility\perk::removeperk(perk);
  }

  scripts\mp\utility\perk::removeperk("specialty_specialist_bonus");
  scripts\mp\utility\perk::removeperk("specialty_lightweight");
  scripts\mp\utility\perk::removeperk("specialty_fastreload");

  if(!scripts\mp\utility\game::isanymlgmatch()) {
    scripts\mp\utility\perk::removeperk("specialty_ammo_disabling");
    scripts\mp\utility\perk::removeperk("specialty_delayhealing");
    scripts\mp\utility\perk::removeperk("specialty_armorpiercing");
    scripts\mp\utility\perk::removeperk("specialty_hardmelee");
    scripts\mp\utility\perk::removeperk("specialty_marksman");
    scripts\mp\utility\perk::removeperk("specialty_gunperk_xp");
  }
}

getavailableperks() {
  _id_E554AEC07EE87FC1 = [];

  foreach(perkref in level._id_FFC23517BDB76237) {
    if(scripts\mp\utility\perk::_hasperk(perkref)) {
      continue;
    }
    _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E[perkref];

    if(!istrue(_id_D442547D75DFFD09._id_594AF43597023062)) {
      continue;
    }
    _id_E554AEC07EE87FC1[_id_E554AEC07EE87FC1.size] = perkref;
  }

  return _id_E554AEC07EE87FC1;
}

getperkslot(perkref) {
  if(!isDefined(perkref))
    return undefined;

  _id_D442547D75DFFD09 = level._id_A1AD2758FCBD2F5E[perkref];

  if(!isDefined(_id_D442547D75DFFD09))
    return undefined;

  return _id_D442547D75DFFD09._id_4A0E5042CE1AE1E2;
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player.perks = [];
    player.perksblocked = [];
    player.weaponlist = [];
    _id_A9811E9D60C20505(player);
  }
}

_id_A9811E9D60C20505(_id_B7B0DBFE5E343D18) {
  _id_326B121623F1F70D = 0;

  foreach(player in level.players) {
    if(isDefined(player.pers["perkPackageProgress"]))
      _id_326B121623F1F70D = _id_326B121623F1F70D + player.pers["perkPackageProgress"];
  }

  _id_2C30AAD2DA89CE58 = 0;

  if(istrue(level.players.size > 0))
    _id_2C30AAD2DA89CE58 = _id_326B121623F1F70D / level.players.size;

  _id_B7B0DBFE5E343D18.pers["perkPackageProgress"] = _id_2C30AAD2DA89CE58;
}

initperkdvars() {
  maxhealth = getdvarint("scr_player_maxhealth", 100);
  level.graceperiodgrenademod = 0.08;
  level.armorpiercingmod = 1.5;
  level._id_3395494B137909BB = 1.5;
  level._id_F83DD54FB01D0B92 = 1.75;
  level.regenfasterhealthmod = scripts\mp\utility\dvars::getintproperty("perk_fastregenrate", 2);
  level.explosivedamagemod = scripts\mp\utility\dvars::getintproperty("perk_explosivedamage", 40) / 100;
  level.blastshieldmod = scripts\mp\utility\dvars::getfloatproperty("perk_blastshieldscale", 0.65);
  level.blastshieldclamp = scripts\mp\utility\dvars::getfloatproperty("perk_blastshieldclamphp", 0.8) * maxhealth;
  level.riotshieldmod = scripts\mp\utility\dvars::getintproperty("perk_riotshield", 100) / 100;
  level.armorvestbulletdelta = scripts\mp\utility\dvars::getintproperty("perk_armorvest", 1);
  level.minspeed = scripts\mp\utility\dvars::getintproperty("perk_gpsjammer_min_speed", 100);
  level.mindistance = scripts\mp\utility\dvars::getintproperty("perk_gpsjammer_min_distance", 10);
  level.timeperiod = scripts\mp\utility\dvars::getintproperty("perk_gpsjammer_time_period", 200) / 1000;
  level.minspeedsq = level.minspeed * level.minspeed;
  level.mindistancesq = level.mindistance * level.mindistance;

  if(_id_55E418C5CC946593::_id_C0D385A09D173A36() && !_func_EC3AEA190C440D29("dvar_DE884E7ED943C255"))
    level._id_0EECCF9E10242815 = 0;
  else
    level._id_0EECCF9E10242815 = getdvarint("dvar_DE884E7ED943C255", 1);

  if(scripts\cp_mp\utility\game_utility::_id_21322DA268E71C19()) {
    level.blastshieldmod = scripts\mp\utility\dvars::getfloatproperty("perk_blastshieldscale_hc", 0.65);
    level.blastshieldclamp = scripts\mp\utility\dvars::getfloatproperty("perk_blastshieldclamphp_hc", 0.66) * maxhealth;
  }

  if(scripts\mp\utility\game::getgametype() == "arena") {
    level.blastshieldmod = scripts\mp\utility\dvars::dvarfloatvalue("blastShieldMod", 0.65, 0, 1.0);
    level.blastshieldclamp = scripts\mp\utility\dvars::dvarfloatvalue("blastShieldClamp", 0.8, 0.0, 1.0) * maxhealth;
  }

  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    level.blastshieldmod = scripts\mp\utility\dvars::getfloatproperty("dvar_0EEA6D50EA045FDF", 0.8);
    level.blastshieldclamp = scripts\mp\utility\dvars::getfloatproperty("dvar_60E279F4F47F7B8E", 1.0) * maxhealth;
  }
}

giveperks(loadoutperks) {
  foreach(perk in loadoutperks) {
    if(perk != "none" && perk != "specialty_null")
      scripts\mp\class::loadout_giveperk(perk);
  }
}

_id_4613EC15F87B7CF2(_id_D4FA758998A39BFD, _id_4C152A7907B0248E) {
  self._id_15F3E6DF722FB1CF = _id_D4FA758998A39BFD;
  self._id_15F3E5DF722FAF9C = _id_4C152A7907B0248E;
}

_setperk(perkname) {
  if(!isDefined(self.perks))
    self.perks = [];

  if(!scripts\mp\utility\perk::_hasperk(perkname))
    self.perks[perkname] = 1;
  else
    self.perks[perkname]++;

  if(self.perks[perkname] == 1 && !scripts\mp\utility\perk::_id_8641EDD897D42547(perkname))
    _setperkinternal(perkname);
}

_setperkinternal(perkname) {
  _id_2E61A6A3A9244975 = level.perksetfuncs[perkname];

  if(isDefined(_id_2E61A6A3A9244975))
    self thread[[_id_2E61A6A3A9244975]]();

  self setperk(perkname, !isDefined(level.scriptperks[perkname]));
}

_setextraperks(perkname) {
  if(isDefined(level.extraperkmap[perkname])) {
    foreach(_id_43596460393338E5 in level.extraperkmap[perkname]) {
      _setperk(_id_43596460393338E5);
      _setextraperks(_id_43596460393338E5);
    }
  }
}

_unsetextraperks(perkname) {
  if(isDefined(level.extraperkmap[perkname])) {
    foreach(_id_43596460393338E5 in level.extraperkmap[perkname]) {
      _unsetperk(_id_43596460393338E5);
      _unsetextraperks(_id_43596460393338E5);
    }
  }
}

_unsetperk(perkname) {
  if(!scripts\mp\utility\perk::_hasperk(perkname)) {
    return;
  }
  self.perks[perkname]--;

  if(self.perks[perkname] == 0) {
    if(!scripts\mp\utility\perk::_id_8641EDD897D42547(perkname))
      _unsetperkinternal(perkname);

    self.perks[perkname] = undefined;
  }
}

_unsetperkinternal(perkname) {
  if(isDefined(level.perkunsetfuncs[perkname]))
    self thread[[level.perkunsetfuncs[perkname]]]();

  self unsetperk(perkname, !isDefined(level.scriptperks[perkname]));
}

_clearperks() {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.perks)) {
    foreach(perkname, _id_C9FBB2A46AE3886E in self.perks) {
      if(isDefined(level.perkunsetfuncs[perkname]))
        self[[level.perkunsetfuncs[perkname]]]();
    }
  }

  self.perks = [];
  self.perksblocked = [];
  self clearperks();
}

_id_29EF7A1951B051F7() {
  if(!isDefined(self)) {
    return;
  }
  _id_00672A655F9C24B7 = [];

  if(isDefined(self.perks))
    _id_00672A655F9C24B7 = self.perks;

  if(isDefined(self._id_B6AD5B4211ACA6F2)) {
    foreach(perk in self._id_B6AD5B4211ACA6F2)
    _id_00672A655F9C24B7 = scripts\engine\utility::array_remove_key(_id_00672A655F9C24B7, perk);
  }

  if(isDefined(_id_00672A655F9C24B7)) {
    foreach(perkname, _id_C9FBB2A46AE3886E in _id_00672A655F9C24B7) {
      if(isDefined(level.perkunsetfuncs[perkname]))
        self[[level.perkunsetfuncs[perkname]]]();
    }
  }

  foreach(perk, value in _id_00672A655F9C24B7) {
    self.perks = scripts\engine\utility::array_remove_key(self.perks, perk);
    self unsetperk(perk, !isDefined(level.scriptperks[perk]));
  }
}

giveperksafterspawn() {
  self endon("death_or_disconnect");
  self endon("joined_spectators");
  self endon("giveLoadout_start");
  self endon("loadout_perks_cleared");
  scripts\mp\class::loadout_giveperk("specialty_blindeye");
  scripts\mp\class::loadout_giveperk("specialty_gpsjammer");
  scripts\mp\class::loadout_giveperk("specialty_noscopeoutline");
  scripts\mp\class::loadout_giveperk("specialty_gas_grenade_resist");

  if(self.avoidkillstreakonspawntimer > 0) {
    _id_2530A108E73BDBB8 = self.avoidkillstreakonspawntimer;

    if(istrue(self.inspawncamera))
      _id_2530A108E73BDBB8 = _id_2530A108E73BDBB8 + scripts\mp\spawncamera::getspawncamerablendtime();

    wait(_id_2530A108E73BDBB8);
  }

  self.avoidkillstreakonspawntimer = undefined;

  if(scripts\mp\utility\killstreak::isplayerkillstreak(self) && isDefined(self.playerproxyagent) && isalive(self.playerproxyagent))
    return;
  else {
    scripts\mp\class::loadout_removeperk("specialty_blindeye");
    scripts\mp\class::loadout_removeperk("specialty_gpsjammer");
    scripts\mp\class::loadout_removeperk("specialty_noscopeoutline");
    scripts\mp\class::loadout_removeperk("specialty_gas_grenade_resist");
    self notify("removed_spawn_perks");
  }
}

updateactiveperks(einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir) {
  _id_C3A55EE9F23FB616 = isDefined(einflictor) && isPlayer(einflictor);
  _id_D758F68157FEBC76 = scripts\mp\utility\weapon::isthrowingknife(objweapon);
  _id_4F5E5BF85BDB8C7A = _id_D758F68157FEBC76 && isDefined(einflictor) && isDefined(einflictor.classname) && einflictor.classname == "grenade";
  _id_99D1ABC1148A35AD = isDefined(attacker) && isPlayer(attacker) && attacker != victim;

  if(_id_99D1ABC1148A35AD && (_id_C3A55EE9F23FB616 || _id_4F5E5BF85BDB8C7A)) {
    attacker.lastgunkilltime = gettime();
    thread scripts\mp\perks\weaponpassives::updateweaponpassivesonkill(einflictor, attacker, victim, idamage, smeansofdeath, objweapon, shitloc, vdir);

    if(attacker scripts\mp\utility\perk::_hasperk("specialty_triggerhappy"))
      attacker thread scripts\mp\perks\perkfunctions::settriggerhappyinternal();

    if(attacker scripts\mp\utility\perk::_hasperk("specialty_boom"))
      victim thread scripts\mp\perks\perkfunctions::setboominternal(attacker);

    if(attacker scripts\mp\utility\perk::_hasperk("specialty_deadeye"))
      attacker.deadeyekillcount++;

    _id_F3F59686C0FABC4C = attacker.pers["abilityRecharging"];

    if(isDefined(_id_F3F59686C0FABC4C) && _id_F3F59686C0FABC4C)
      attacker notify("abilityFastRecharge");

    _id_2EDB46E413CBC42F = attacker.pers["abilityOn"];

    if(isDefined(_id_2EDB46E413CBC42F) && _id_2EDB46E413CBC42F)
      attacker notify("abilityExtraTime");

    if(attacker scripts\mp\utility\perk::_hasperk("specialty_super_sprint_kill_refresh"))
      attacker scripts\mp\perks\perkfunctions::supersprintkillrefresh_onkill();

    if(attacker scripts\mp\utility\perk::_hasperk("specialty_reduce_regen_delay_on_kill"))
      attacker scripts\mp\perks\perkfunctions::regendelayreduce_onkill();

    if(attacker scripts\mp\utility\perk::_hasperk("specialty_armored") && attacker getammocount("bandage_br") < 1)
      attacker _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(1);

    if(attacker scripts\mp\utility\perk::_hasperk("specialty_slayer"))
      attacker scripts\mp\perks\perkfunctions::_id_E1349C922318FC19();
  }
}

_id_7C8CC44B58093CE4(_id_77BC1C85DC4C173F) {
  index = scripts\mp\class::_id_ED0C3ACFDAC0BAED(_id_77BC1C85DC4C173F);
  self setclientomnvar("ui_perk_package_bundle_index", index);
}

setomnvarsforperklist(_id_5DC06B0667135C87, _id_CA58D54671E2640D) {
  _id_3E723D9F699E3373 = [];

  foreach(perk in _id_CA58D54671E2640D) {
    if(!_id_F45C19871B412EA5(perk)) {
      continue;
    }
    slot = getperkslot(perk);

    if(!isDefined(slot)) {
      continue;
    }
    if(!isDefined(_id_3E723D9F699E3373[slot]))
      _id_3E723D9F699E3373[slot] = [];

    _id_3E723D9F699E3373[slot][_id_3E723D9F699E3373[slot].size] = perk;
  }

  _id_4E4F84E174228B69 = [];

  for(slot = 1; slot < 4; slot++) {
    if(isDefined(_id_3E723D9F699E3373[slot])) {
      foreach(perk in _id_3E723D9F699E3373[slot])
      _id_4E4F84E174228B69[_id_4E4F84E174228B69.size] = perk;
    }
  }

  for(_id_D861F893072A477E = 0; _id_D861F893072A477E < 4; _id_D861F893072A477E++) {
    _id_5C9DDCF56D36F133 = _id_4E4F84E174228B69[_id_D861F893072A477E];

    if(!isDefined(_id_5C9DDCF56D36F133))
      _id_5C9DDCF56D36F133 = "none";

    self setclientomnvar(_id_5DC06B0667135C87 + _id_D861F893072A477E, _id_5C9DDCF56D36F133);
  }
}

isperkinloadout(perk) {
  perks = self.pers["loadoutPerks"];

  foreach(_id_C934A976D3201257 in perks) {
    if(_id_C934A976D3201257 == perk)
      return 1;
  }

  return 0;
}

getperkid(perkref) {
  if(!isDefined(perkref))
    return 0;

  _id_8852E1DA266FEA14 = level._id_D5F3DCF05B7E8BE6[perkref];

  if(!isnumber(_id_8852E1DA266FEA14))
    return 0;

  return _id_8852E1DA266FEA14;
}

_id_CCDBD1F6DA822D2C() {
  level endon("game_ended");

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
    scripts\mp\flags::gameflagwait("prematch_done");

  starttime = gettime();
  waitframe();

  if(!isDefined(game["perk_package_progress_global"]))
    game["perk_package_progress_global"] = 0;

  for(;;) {
    if(isDefined(level._id_D659494E95BD9496) && level._id_D659494E95BD9496) {
      starttime = gettime();
      waitframe();
      continue;
    }

    game["perk_package_progress_global"] = game["perk_package_progress_global"] + 10 * level.framedurationseconds;

    if(int(game["perk_package_progress_global"]) % 10 == 0) {
      foreach(player in level.players) {
        if(isbot(player)) {
          continue;
        }
        player _id_F2DBAB6F947771F2();
      }
    }

    waitframe();
  }
}

_id_F2DBAB6F947771F2() {
  if(!isPlayer(self)) {
    return;
  }
  if(!istrue(level._id_606EB45E074FF204)) {
    return;
  }
  if(!isDefined(self._id_15F3E6DF722FB1CF) || !isDefined(self._id_15F3E5DF722FAF9C)) {
    return;
  }
  if(!isDefined(self.pers["perkPackageProgress"]))
    self.pers["perkPackageProgress"] = 0;

  if(!isDefined(self.pers["perkPackageTier2Earned"]))
    self.pers["perkPackageTier2Earned"] = 0;

  if(!isDefined(self.pers["perkPackageTier3State"]))
    self.pers["perkPackageTier3State"] = 0;

  _id_FF54A98A1569A09D = level._id_5A3318627FB4465D;
  _id_1601C1F95D06209A = level._id_5CDAA841F503D45A;

  if(self.pers["perkPackageProgress"] + game["perk_package_progress_global"] > _id_FF54A98A1569A09D && !self.pers["perkPackageTier2Earned"] || level._id_F3D4343DA6D28C4C == 1) {
    scripts\mp\utility\perk::giveperk(self._id_15F3E6DF722FB1CF);
    self.pers["perkPackageTier2Earned"] = 1;

    if(istrue(self._id_A7BEFB30CD4958CB)) {
      self setclientomnvar("ui_perk_bonus_splash", 1);
      scripts\mp\utility\dialog::leaderdialogonplayer(self._id_15F3E6DF722FB1CF);
    }

    if(scripts\mp\utility\perk::_hasperk("specialty_recharge_equipment"))
      _id_0EC0F9AD939B29E0::_id_E27C4D2340D9D56B();

    self dlog_recordplayerevent("dlog_event_mp_perk_tier2_earn", ["match_time", scripts\mp\utility\game::gettimepassed(), "t2_cost", _id_FF54A98A1569A09D]);
  }

  _id_CA485F8EC3DE1D80 = self.pers["perkPackageProgress"] + game["perk_package_progress_global"];
  _id_076D0E2DFC8BB69E = _id_CA485F8EC3DE1D80 > _id_1601C1F95D06209A && self.pers["perkPackageTier3State"] < 1;

  if((_id_076D0E2DFC8BB69E || level._id_F3D4353DA6D28E7F == 1) && self._id_15F3E5DF722FAF9C != "specialty_null") {
    self.pers["perkPackageTier3State"] = 1;

    if(istrue(self._id_A7BEFB30CD4958CB)) {
      self setclientomnvar("ui_perk_ultimate_splash", 1);
      scripts\mp\utility\dialog::leaderdialogonplayer(self._id_15F3E5DF722FAF9C);
    }

    _id_2E9BD87BF55528F9();
    self dlog_recordplayerevent("dlog_event_mp_perk_tier3_earn", ["match_time", scripts\mp\utility\game::gettimepassed(), "t3_cost", _id_1601C1F95D06209A]);
  }

  _id_0FF3E705EC08C840();
}

_id_2E9BD87BF55528F9() {
  if(!istrue(level._id_606EB45E074FF204)) {
    return;
  }
  if(isDefined(self.pers["perkPackageTier3State"])) {
    scripts\mp\utility\perk::giveperk(self._id_15F3E5DF722FAF9C);
    self.pers["perkPackageTier3State"] = 2;

    if(istrue(level._id_3F893C812B909915))
      scripts\mp\perks\perkfunctions::_id_6964A0E0E8D00B09(self._id_15F3E5DF722FAF9C);

    _id_1601C1F95D06209A = level._id_5CDAA841F503D45A;
    self dlog_recordplayerevent("dlog_event_mp_perk_tier3_activate", ["match_time", scripts\mp\utility\game::gettimepassed(), "t3_cost", _id_1601C1F95D06209A]);
  }
}

_id_2CB1405F41491297(amount) {
  if(!isPlayer(self)) {
    return;
  }
  if(!istrue(level._id_606EB45E074FF204)) {
    return;
  }
  if(!isDefined(self.pers["perkPackageProgress"]))
    self.pers["perkPackageProgress"] = 0;

  self.pers["perkPackageProgress"] = self.pers["perkPackageProgress"] + amount;
  _id_0FF3E705EC08C840();
}

_id_0FF3E705EC08C840() {
  _id_CA485F8EC3DE1D80 = self.pers["perkPackageProgress"] + game["perk_package_progress_global"];
  _id_4D0D085EE780C083 = _id_CA485F8EC3DE1D80 / level._id_5A3318627FB4465D;
  _id_E3DF6497B9E052AD = (_id_CA485F8EC3DE1D80 - level._id_5A3318627FB4465D) / (level._id_5CDAA841F503D45A - level._id_5A3318627FB4465D);
  self setclientomnvar("ui_perk_bonus_progress", _id_4D0D085EE780C083);
  self setclientomnvar("ui_perk_ultimate_progress", _id_E3DF6497B9E052AD);
}

_id_B30E1C92800E9F5F() {
  if(!istrue(level._id_606EB45E074FF204))
    return 0;

  if(self._id_4C6852D3C7765D04 >= level._id_F36DCECDEBE6160B && isDefined(self.pers["perkPackageTier3State"]) && self.pers["perkPackageTier3State"] == 1)
    return 1;

  return 0;
}

_id_7EF2F6D740DA9325() {
  if(!isDefined(self.pers["perkPackageProgress"]))
    self.pers["perkPackageProgress"] = 0;

  if(!isDefined(self.pers["perkPackageTier3State"]))
    self.pers["perkPackageTier3State"] = 0;

  if(!isDefined(self.pers["perkPackageTier2Earned"]))
    self.pers["perkPackageTier2Earned"] = 0;

  if(!isDefined(game["perk_package_progress_global"]))
    game["perk_package_progress_global"] = 0;
}

_id_007A60D901339410(amount) {
  if(!isDefined(amount))
    amount = 0;

  foreach(player in level.players) {
    player.pers["perkPackageTier2Earned"] = 0;
    player.pers["perkPackageTier3State"] = 0;
    player.pers["perkPackageProgress"] = amount;
    self setclientomnvar("ui_perk_bonus_splash", 0);
    self setclientomnvar("ui_perk_ultimate_splash", 0);
    player _id_F2DBAB6F947771F2();
  }
}

_id_667EC8F124FE1AB3() {
  level endon("game_ended");
  level endon("perk_package_round_switch");
  level waittill("prematch_done");

  if(level.roundswitch == 0) {
    return;
  }
  _id_BC0657CB598A7E2A = game["roundsPlayed"] % level.roundswitch;

  if(istrue(level._id_63D440B3041CA2A7)) {
    if(game["roundsPlayed"] >= level._id_24B471CE5E06FF1E || level.halftimetype == "overtime")
      game["perk_package_progress_global"] = level._id_5CDAA841F503D45A - level._id_4AD21852735184E9;
    else if(game["roundsPlayed"] >= level._id_9C166C328FE115B7)
      game["perk_package_progress_global"] = level._id_5A3318627FB4465D;
    else
      game["perk_package_progress_global"] = 0;
  } else if(_id_BC0657CB598A7E2A >= level._id_24B471CE5E06FF1E || level.halftimetype == "overtime")
    game["perk_package_progress_global"] = level._id_5CDAA841F503D45A - level._id_4AD21852735184E9;
  else if(_id_BC0657CB598A7E2A >= level._id_9C166C328FE115B7)
    game["perk_package_progress_global"] = level._id_5A3318627FB4465D;
  else
    game["perk_package_progress_global"] = 0;

  _id_007A60D901339410();
  level notify("perk_package_round_switch");
}

_id_5A3FEF8CB39336B8(perkref) {
  self setclientomnvar("ui_perk_activation", perkref);
  self setclientomnvar("ui_perk_activation_notify", gettime());
}

_id_D1A7E9B22C284B92() {
  if(isDefined(self._id_15F3E6DF722FB1CF))
    scripts\mp\utility\perk::removeperk(self._id_15F3E6DF722FB1CF);

  if(isDefined(self._id_15F3E5DF722FAF9C))
    scripts\mp\utility\perk::removeperk(self._id_15F3E5DF722FAF9C);

  foreach(perk in self.pers["loadoutPerks"])
  scripts\mp\utility\perk::removeperk(perk);
}