/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_dmz.gsc
****************************************************/

init() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  _id_C2A1BC0C5A905217();
  _id_A96666BC3E3D2CB0();
  _id_81B59887710BAF14();
  level thread _id_164622EB2B0F5390::init();
  level thread initdialog();
  level thread initfx();
  level thread _id_F269438F48049613();
  level thread initpostmain();
  level thread _id_F16652E1462A3739();
  level thread _id_4FB6F74E053A49D6();
  level thread _id_E1FA80F536692A32();
  setDvar("scr_br_magcount", 3);
  setDvar("dvar_F6F24E020168ADE8", "nothing");
  setDvar("voice_proximity_team", 0);
  setDvar("voice_proximity_enemy", 1);
  setDvar("dvar_58A078A367C02AB3", 1);
  setDvar("voice_proximity_radius", 2200);
  setdvarifuninitialized("dvar_A44CF32FF2620BC2", 9);
  setdvarifuninitialized("dvar_8D9AD523F40BE455", 10000);
  setomnvar("ui_br_circle_state", 5);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  _id_35A334482F930BE6 = getdvarint("dvar_B773758221A0C100", -1);

  if(_id_35A334482F930BE6 == -1)
    setDvar("dvar_B773758221A0C100", 10);

  level._id_E4A482EDC1542597 = getdvarint("dvar_0BB9178DA63CE4B9", 1) == 1;
  level._id_D040719163E20394 = 1;
  level._id_48154008716F7116 = 1;
  level._id_B9ABF4FC2D1F7FCD = ::_id_B9ABF4FC2D1F7FCD;

  if(getdvarint("dvar_4E758755F5217912", 1) == 1)
    level._id_924A9707BDCBFC46 = ::_id_F6843E3A71516B3E;

  level.skipprematchdropspawn = 1;
  level.skipplaybodycountsound = 1;
  level.brdisablefinalkillcam = 1;
  level.br_prematchffa = 0;
  level._id_59FF09549058DDA2 = getdvarint("dvar_F1B1048E888610E9", 1) && getdvarint("dvar_FF65C25889692DB8", 0) != 1;
  level.giveloadouteverytime = getdvarint("dvar_F38399DADD8DBB3C", 1);
  level._id_FC90401F4AE3F765 = getdvarint("dvar_0BB1DCC8BDBF24FF", 0) == 1;
  level.skipprematch = getdvarint("dvar_CB643D3F8E15DC02", 0);
  level.allowprematchdamage = 0;
  level._id_8281A47E2CECB257 = 1;
  level._id_EEF1D450C2D5D682 = getdvarint("dvar_DCF2CE95246DD428", 1);

  if(level._id_EEF1D450C2D5D682)
    _id_362C58E8BB39BCDA::disablefeature("littleBirdSpawns");

  level._id_E148F7D0B42FE6DA = getdvarfloat("dvar_C8C9056814E8241C", 1.0);
  level._id_BE39D6B46044F344 = getdvarfloat("dvar_685BE141B7E436EE", 40.0);
  level.instantbleedoutsquadwipe = getdvarint("dvar_76A23E670FCF02B5", 1);
  level._id_D21C4A649C5ACA6C = getdvarint("dvar_445F250F74C53306", 0);
  level.respawnheightoverride = getdvarint("dvar_1CFE5B8F1BEEB2C6", 5000);
  level.parachutedeploydelay = getdvarfloat("dvar_0BF323F012D271C0", 0.5);
  level.autoassignfirstquest = getdvarint("dvar_0C2BDAB0E90057ED", 0);
  level.tabletreplacefrequency = getdvarfloat("dvar_C9E99CA095302D5E", 1.5);
  level.objectivescaler = 1;
  level._id_644A33D86D8514BF = getdvarint("dvar_36B76ADBFA9D12C5", 1) == 1;
  level.skipweapondropondeath = getdvarint("dvar_D9F08C101634F72E", 0);
  level.skipequipmentdropondeath = getdvarint("dvar_3B11AFF9DADD9D22", 0);
  level.allowfultondropondeath = getdvarint("dvar_906F1E617463438E", 1);
  level._id_545CDDF92DA82A04 = getdvarint("dvar_F924E428AE42DC96", 0);
  level._id_36827F5D10328424 = ::_id_F1AD30EFC5733CAF;
  level._id_57ECE26E490AD8C4 = getdvarint("dvar_31AFD0E1D896114A", 1);
  level._id_E4623740D9B51824 = getdvarint("dvar_EEFB9C49E01093A6", 1);
  level._id_F4B090DBBD2B125B = getdvarint("dvar_09B11F9106FB2721", 0);
  level._id_E028CA551ECC95A3 = getdvarint("dvar_1107CAF2E45B5CCD", 1);
  level._id_CC9E990B6E83975B = getdvarint("dvar_0C39067C564E9BE9", 1);
  level._id_A101059DEA76957C = getdvarint("dvar_9AFF44DBD6467CB1", 1);
  level._id_2C93542553C664F5 = getdvarint("dvar_850BDE4C8D2D482B", 0);
  level._id_472D7A6D15E57940 = getdvarint("dvar_586D32848F833922", 1);
  level._id_1D814F83596D0A02 = getdvarint("dvar_07A1DA73FA673ED8", 1);
  level._id_8DEA6607B3189A60 = getdvarint("dvar_32C09327627C883C", 1);
  level.minplunderdropondeath = getdvarint("dvar_E0A487B88D0E4410", 0);
  level._id_0F478C1F94CAA7E9 = getdvarint("dvar_4F0A12B17756A2D0", 1);
  level._id_7D17E26667BE2792 = getdvarint("dvar_55D9444D8A3CE31A", 1);
  _id_42692985AEBCEA16 = getDvar("dvar_53BC1DFEE47E5C6D", "brloot_weapon_ar_schotel_lege,brloot_weapon_ar_golf3_lege,brloot_weapon_br_msecho_lege,brloot_weapon_br_soscar14_lege,brloot_weapon_ar_mike4_lege,brloot_weapon_ar_mike16_lege,brloot_weapon_ar_akilo_lege");
  level._id_808A69414F52F6BC = strtok(_id_42692985AEBCEA16, ",");
  level._id_184726567A9F58D8 = getdvarfloat("dvar_D2B4C84CDDA73751", 0.02);
  level._id_E5993849FC7D5987 = getdvarint("dvar_BEB500581164E4BC", 1);
  level._id_38AE6E498DB315FF = getdvarint("dvar_FE9052D4AAA052E0", 1000);
  level._id_499B5E2905BFA698 = getdvarint("dvar_19476575934AB4CE", 4);
  level.disablewinonscore = getdvarint("dvar_4A9C110CFC54A4C5", 0);
  level._id_EF3E0EB58D1263C5 = getdvarint("dvar_8985888259FDE494", 30);
  level._id_376762409014CC8E = getdvarint("dvar_D7B1D34D99C190A8", 0);
  level._id_87A4731D4DCE4C3F = ::_id_9DF0EE7FCB9589D4;
  level._id_08973F9DA378E47D = 0;
  level._id_AF010715D9DE37A1 = getdvarfloat("dvar_DAF598646A54A4B7", 0.4);
  level._id_D034183ABF2E274D = getdvarint("dvar_64BE202F01A8B591", 1);
  level._id_87DEB8F6A4C7D50E = getdvarfloat("dvar_3895FE2399DD9E41", 512);
  level._id_719B61CA626125FF = getdvarfloat("dvar_86A034ED5D293BEC", 256);
  level._id_7A36D824DA6087EF = getdvarint("dvar_744188CC6B4D2AF0", 1);
  level._id_FB7D41D7C65922B7 = getdvarint("dvar_60642A632AB9BAEB", 0);

  if(level._id_FB7D41D7C65922B7)
    level._id_76EBA5FACACD254B = ::_id_BFD9F11E955ACE89;

  setDvar("dvar_A6A3FD965485D4BC", 2);
  level thread _id_62B40B6A6C2CF37A();
  level thread _id_3114E3023D0EDF66();
  level thread checkendgame();
  _id_5307834CD39B435C::_id_36F1BD0F5D72054A();
  level thread _id_2CC6455920627806::_id_476BA78D85B349EA();

  if(getdvarint("dvar_696CDE56698DCC68", 1) == 1)
    thread _id_1174ABEDBEFE9ADA::_id_03ACF5939A1DB7A7();

  if(getdvarint("dvar_7AFD7AC5E611D8AD", 1) == 1)
    level thread _id_34874C98AB154F37::_id_414E92DE6D8A19AD();

  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    _func_D2C13FC95E4E8962(1);
    _id_0B7A9CE0A2282B79::init();
  }

  level thread _id_F3A2435F8E39438B();

  if(_id_0A661C5FAD6BEDD8::_id_BC586652AA211EE1())
    level thread _id_0A661C5FAD6BEDD8::_id_2CAFA6C0BC2D49A9(1, 300, 600);

  _id_FBA25AE643DD02E8();
}

_id_B52F35A3FF450ECD() {
  _id_A620CB0E6444887F = getdvarint("dvar_A0C7B324FE8C09C6", 3);

  if(_id_A620CB0E6444887F <= 0 || istrue(level._id_291B51C7AF8D1204)) {
    return;
  }
  _id_9E4E1482CB40C9C5 = level._id_E4669B797013D077;

  if(!isDefined(_id_9E4E1482CB40C9C5) || _id_9E4E1482CB40C9C5.size == 0) {
    return;
  }
  foreach(struct in scripts\engine\utility::array_slice(scripts\engine\utility::array_randomize(_id_9E4E1482CB40C9C5), 0, _id_A620CB0E6444887F)) {
    _id_EFB5620DEEAD5E9B = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_lnd_mrap", struct);
    _id_EFB5620DEEAD5E9B scripts\cp_mp\vehicles\vehicle_occupancy::_id_AC0A3326D43EB8FD();
  }
}

_id_C2A1BC0C5A905217() {
  _id_2957DE46170ADAD1 = spawnStruct();
  _id_2957DE46170ADAD1._id_FD6906DC66B503B4 = getdvarint("dvar_3CE6579B3E9456DE", 10);
  _id_2957DE46170ADAD1._id_4C433DC943A4B16E = getdvarint("dvar_5973B1CA7FD76FE0", 20);
  _id_2957DE46170ADAD1._id_AC5D474FFE947F53 = getdvarint("dvar_41027AEA8F94BF2D", 7);
  _id_2957DE46170ADAD1._id_8FB4E94454C2B089 = getdvarint("dvar_4769E3057DF7EAEF", 15);
  _id_2957DE46170ADAD1._id_DE220EE05772F786 = getdvarint("dvar_94B723881ADE691C", 1);
  _id_2957DE46170ADAD1._id_D4692DEEC4B3B23C = getdvarint("dvar_787EFBD4ED18AB72", 2);
  _id_35DE402EFC5ACFB3::_id_33BDD4AD6AA14EDC(_id_2957DE46170ADAD1);
}

_id_FBA25AE643DD02E8() {
  _id_26660AE1076E2D99::init();
  _id_42DB00FECB0FA74D::_id_5BA1BB4933EDC5DA();
}

_id_A96666BC3E3D2CB0() {
  _id_362C58E8BB39BCDA::disablefeature("circle");
  _id_362C58E8BB39BCDA::disablefeature("gulag");
  _id_362C58E8BB39BCDA::disablefeature("dropbag");
  _id_362C58E8BB39BCDA::disablefeature("plunderSites");
  _id_362C58E8BB39BCDA::disablefeature("circle");
  _id_362C58E8BB39BCDA::disablefeature("brQuests");

  if(getdvarint("dvar_C3A2E929E971289A", 1) == 0)
    _id_362C58E8BB39BCDA::disablefeature("teamSpectate");

  if(getdvarint("dvar_18984A982B2FFC8F", 0) == 0)
    _id_362C58E8BB39BCDA::disablefeature("spectateOnDeath");

  if(getdvarint("dvar_CF460F5E17CACBE6", 1) == 0)
    _id_362C58E8BB39BCDA::disablefeature("kiosk");

  _id_362C58E8BB39BCDA::enablefeature("allowLateJoiners");

  if(getdvarint("dvar_38723BBB368F3F8C", 1) == 1)
    _id_362C58E8BB39BCDA::enablefeature("tabletReplace");
}

_id_81B59887710BAF14() {
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerShouldRespawn", ::playershouldrespawn);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("spawnHandled", ::spawnhandled);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerWelcomeSplashes", ::playerwelcomesplashes);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onPlayerConnect", ::onplayerconnect);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("isValidSpectateTarget", ::isvalidspectatetarget);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("playerSkipLootPickup", ::playerskiplootpickup);
  _id_362C58E8BB39BCDA::registerbrgametypefunc("onStartGameType", ::onstartgametype);
  level.filtervehiclespawnstructsfunc = ::filtervehiclespawnstructs;
  level.modeiskillstreakallowed = ::_id_F1C3982D13453D32;
}

initdialog() {
  level endon("game_ended");
  level._id_92B187A00D3DD091 = 1;
  level waittill("br_dialog_initialized");
  game["dialog"]["gametype"] = "gametype_dmz";
  game["dialog"]["prematch_enter_mission"] = "gamestate_prematch_enter_mission_tutorial";
  game["dialog"]["prematch_enter_gear"] = "gamestate_prematch_enter_death_tutorial";
  game["dialog"]["prematch_end"] = "gamestate_prematch_end";
  game["dialog"]["dmz_infil_end"] = "gamestate_prematch_end_dmz";
  game["dialog"]["dmz_tutorial_end"] = "gametype_tutorial_match_end";
  game["dialog"]["dmz_tutorial_exfil"] = "gametype_tutorial_exfil";
  game["dialog"]["dmz_radiation_east"] = "gamestate_match_end_indicator_east";
  game["dialog"]["dmz_radiation_north"] = "gamestate_match_end_indicator_north";
  game["dialog"]["dmz_radiation_west"] = "gamestate_match_end_indicator_west";
  game["dialog"]["dmz_radiation_south"] = "gamestate_match_end_indicator_south";
  game["dialog"]["dmz_radiation_north_west"] = "gamestate_match_end_indicator_northwest";
  game["dialog"]["dmz_radiation_north_east"] = "gamestate_match_end_indicator_northeast";
  game["dialog"]["dmz_radiation_south_west"] = "gamestate_match_end_indicator_southwest";
  game["dialog"]["dmz_radiation_sound_east"] = "gamestate_match_end_indicator_southeast";
  game["dialog"]["dmz_exfil_pilot_inbound"] = "dx_mpo_usop_exfil_inbound_landing";
  game["dialog"]["dmz_exfil_pilot_lz_clear"] = "dx_mpo_usop_lz_clear";
  game["dialog"]["dmz_exfil_pilot_lz_hot"] = "dx_mpo_usop_lz_hot";
  game["dialog"]["dmz_exfil_inbound"] = "gamestate_exfil_inbound";
  game["dialog"]["dmz_exfil_leaving_generic"] = "gamestate_exfil_leaving_generic";
  game["dialog"]["dmz_exfil_leaving_train"] = "gamestate_exfil_leaving_train";
  game["dialog"]["dmz_exfil_leaving_sewers"] = "gamestate_exfil_leaving_sewers";
  game["dialog"]["dmz_exfil_leaving_cliffs"] = "gamestate_exfil_leaving_cliffs";
  game["dialog"]["dmz_exfil_leaving_forest"] = "gamestate_exfil_leaving_forest";
  game["dialog"]["dmz_exfil_leaving_van"] = "gamestate_exfil_leaving_van";
  game["dialog"]["dmz_exfil_leaving_fire_rd"] = "gamestate_exfil_leaving_fire_rd";
  game["dialog"]["dmz_exfil_leaving_heli"] = "gamestate_exfil_leaving_heli";
  game["dialog"]["dmz_exfil_fail"] = "gamestate_exfil_fail";
  game["dialog"]["dmz_exfil_success_squadmates_dead"] = "gamestate_exfil_success_squadmates_dead";
  game["dialog"]["dmz_exfil_success_personal_dead"] = "gamestate_exfil_success_personal_dead";
  game["dialog"]["dmz_exfil_success_contract_failed_squadmates_dead"] = "gamestate_exfil_success_contract_failed_squadmates_dead";
  game["dialog"]["dmz_exfil_success_contract_failed_personal_dead"] = "gamestate_exfil_success_contract_failed_personal_dead";
  game["dialog"]["dmz_team_revive"] = "gamestate_team_revive";
  game["dialog"]["dmz_team_ally_death"] = "gamestate_ally_death";
  game["dialog"]["dmz_team_last_player"] = "gamestate_ally_death_last_player";
  game["dialog"]["dmz_exfil_intro"] = "dx_br_dmzo_sqst_ovld_main";
  game["dialog"]["dmz_exfil_activity_new"] = "dx_br_dmzo_sqst_ovld_accg";
  game["dialog"]["dmz_exfil_activity_remind"] = "dx_br_dmzo_sqst_ovld_acco";
  game["dialog"]["dmz_exfil_pilot_called_gas"] = "dx_br_dmzc_exfi_depi_ecga";
  game["dialog"]["dmz_exfil_pilot_called_hotzone"] = "dx_br_dmzc_exfi_depi_echz";
  game["dialog"]["dmz_exfil_pilot_called_default"] = "dx_br_dmzc_exfi_depi_ecde";
  game["dialog"]["dmz_exfil_pilot_called_timeout"] = "dx_br_dmzc_exfi_depi_ecti";
  game["dialog"]["dmz_exfil_pilot_called_masks"] = "dx_br_dmzc_exfi_depi_ecma";
  game["dialog"]["dmz_exfil_pilot_called_shortcut"] = "dx_br_dmzc_exfi_depi_ecsc";
  game["dialog"]["dmz_exfil_pilot_called_touchdown"] = "dx_br_dmzc_exfi_depi_ectd";
  game["dialog"]["dmz_exfil_pilot_called_close"] = "dx_br_dmzc_exfi_depi_ecla";
  game["dialog"]["dmz_exfil_pilot_called_15out"] = "dx_br_dmzc_exfi_depi_ec15";
  game["dialog"]["dmz_exfil_pilot_called_30out"] = "dx_br_dmzc_exfi_depi_ec30";
  game["dialog"]["dmz_exfil_pilot_called_final"] = "dx_br_dmzc_exfi_depi_ecfi";
  game["dialog"]["dmz_exfil_pilot_called_final_warning"] = "dx_br_dmzc_exfi_depi_ecfw";
  game["dialog"]["dmz_exfil_pilot_called_final_leaving"] = "dx_br_dmzc_exfi_depi_ecfl";
  game["dialog"]["dmz_exfil_pilot_called_final_gone"] = "dx_br_dmzo_sqst_ovld_enre";
  game["dialog"]["dmz_contract_complete_1"] = "gamestate_exfil_inbound_contract_complete";
  game["dialog"]["dmz_contract_complete_2"] = "gamestate_contract_complete";
  game["dialog"]["dmz_all_contract_complete"] = "gamestate_all_contracts_complete";
  game["dialog"]["dmz_new_contract"] = "gamestate_new_contract";
  game["dialog"]["dmz_mission_direction_north"] = "mission_mission_direction_north";
  game["dialog"]["dmz_mission_direction_south"] = "mission_mission_direction_south";
  game["dialog"]["dmz_mission_direction_west"] = "mission_mission_direction_west";
  game["dialog"]["dmz_mission_direction_east"] = "mission_mission_direction_east";
  game["dialog"]["dmz_mission_direction_northwest"] = "mission_mission_direction_northwest";
  game["dialog"]["dmz_mission_direction_northeast"] = "mission_mission_direction_northeast";
  game["dialog"]["dmz_mission_direction_southwest"] = "mission_mission_direction_southwest";
  game["dialog"]["dmz_mission_direction_southeast"] = "mission_mission_direction_southeast";
  game["dialog"]["dmz_mission_ass_accept"] = "mission_assassination_intro";
  game["dialog"]["dmz_mission_ass_target_nearby"] = "mission_assassination_target_near_player";
  game["dialog"]["dmz_mission_ass_target_killed"] = "mission_assassination_target_killed_player";
  game["dialog"]["dmz_mission_ass_target_killed_by_enemy"] = "mission_assassination_target_killed_enemy_team";
  game["dialog"]["dmz_mission_extract_assigned"] = "mission_extract_mission_assigned";
  game["dialog"]["dmz_mission_mass_assigned"] = "mission_extract_mission_assigned";
  game["dialog"]["dmz_mission_ass_intro_gl"] = "dx_mpm_unca_assassination_mission_mission_intro_10";
  game["dialog"]["dmz_mission_ass_accept_gl"] = "assassination_mission_mission_assigned";
  game["dialog"]["dmz_mission_ass_target_nearby_gl"] = "assassination_mission_mission_yegorclose";
  game["dialog"]["dmz_mission_ass_target_killed_gl"] = "assassination_mission_mission_yegorkilled";
  game["dialog"]["dmz_mission_ass_target_killed_by_enemy_gl"] = "assassination_mission_mission_yegorkilled";
  game["dialog"]["dmz_mission_ass_confirmed_kill_gl"] = "assassination_mission_mission_yegorkiaconfed";
  game["dialog"]["dmz_mission_scav_accept"] = "mission_mission_scavenger_intro";
  game["dialog"]["dmz_mission_scav_first_cache"] = "mission_mission_scavenger_first_cache_secured";
  game["dialog"]["dmz_mission_scav_second_cache"] = "mission_mission_scavenger_second_cache_secured";
  game["dialog"]["dmz_mission_scav_third_cache"] = "mission_mission_scavenger_third_cache_secured";
  game["dialog"]["dmz_mission_search_assigned"] = "mission_search_mission_assigned";
  game["dialog"]["dmz_mission_trap_intro"] = "dx_mpm_unca_search_mission_mission_recieved_part1_10";
  game["dialog"]["dmz_mission_trap_assigned"] = "search_mission_mission_recieved_part2";
  game["dialog"]["dmz_mission_trap_near"] = "search_mission_approaching_targetlocation";
  game["dialog"]["dmz_mission_survive_assigned"] = "trap_mission_mission_assigned";
  game["dialog"]["dmz_mission_survive_complete"] = "trap_mission_mission_lockerunlocked";
  game["dialog"]["dmz_mission_loot_complete"] = "trap_mission_mission_extractremind";
  game["dialog"]["dmz_mission_recon_accept"] = "mission_recon_intro";
  game["dialog"]["dmz_mission_recon_target_near"] = "mission_recon_target_near_player";
  game["dialog"]["dmz_mission_recon_upload_start"] = "mission_recon_upload_start_player";
  game["dialog"]["dmz_mission_recon_upload_complete"] = "mission_recon_upload_upload_complete";
  game["dialog"]["dmz_mission_bounty_accept"] = "mission_mission_grunt_bounty_hunter_intro";
  game["dialog"]["dmz_mission_bounty_first_kill"] = "mission_mission_grunt_bounty_first_kill";
  game["dialog"]["dmz_mission_bounty_second_kill"] = "mission_mission_grunt_bounty_second_kill";
  game["dialog"]["dmz_mission_bounty_third_kill"] = "mission_mission_grunt_bounty_third_kill";
  game["dialog"]["dmz_mission_hostage_assigned"] = "trap_mission_mission_assigned";
  game["dialog"]["dmz_mission_hostage_success"] = "trap_mission_mission_lockerunlocked";
  game["dialog"]["dmz_mission_hostage_failure"] = "trap_mission_mission_lockerunlocked";
  game["dialog"]["dmz_mission_safe_opening"] = "dx_br_dmzo_cost_ovld_ultra1beadvisedthats";
  game["dialog"]["dmz_mission_safe_opening_other_team"] = "dx_br_dmzo_cost_ovld_ultra1enemyoperators";
  game["dialog"]["dmz_mission_safe_unlocked"] = "dx_br_dmzo_cost_ovld_ultra1thesafeisopens";
  game["dialog"]["dmz_mission_clear_assigned"] = "dx_br_dmzo_clfa_ovld_cfas";
  game["dialog"]["dmz_mission_clear_approach"] = "dx_br_dmzo_clfa_ovld_cfnr";
  game["dialog"]["dmz_mission_clear_entered"] = "dx_br_dmzo_clfa_ovld_cfen";
  game["dialog"]["dmz_mission_clear_success"] = "dx_br_dmzo_clfa_ovld_cfcl";
  game["dialog"]["dmz_mission_clear_stealth"] = "dx_br_dmzo_clfa_ovld_cfst";
  game["dialog"]["dmz_mission_clear_loud"] = "dx_br_dmzo_clfa_ovld_cfld";
  game["dialog"]["dmz_mission_destroy_sam_assigned"] = "dx_br_dmzo_cost_ovld_dsas";
  game["dialog"]["dmz_mission_destroy_sam_approach"] = "dx_br_dmzo_cost_ovld_dsnr";
  game["dialog"]["dmz_mission_destroy_sam_close"] = "dx_br_dmzo_cost_ovld_dsar";
  game["dialog"]["dmz_mission_destroy_sam_planted"] = "dx_br_dmzo_cost_ovld_dspl";
  game["dialog"]["dmz_mission_destroy_sam_invited"] = "dx_br_dmzo_cost_ovld_dsiv";
  game["dialog"]["dmz_mission_destroy_sam_hostiles"] = "dx_br_dmzo_cost_ovld_dsin";
  game["dialog"]["dmz_mission_destroy_sam_defusing"] = "dx_br_dmzo_cost_ovld_dsdg";
  game["dialog"]["dmz_mission_destroy_sam_defused"] = "dx_br_dmzo_cost_ovld_dsde";
  game["dialog"]["dmz_mission_destroy_sam_invite_defuse"] = "dx_br_dmzo_cost_ovld_dsiw";
  game["dialog"]["dmz_mission_destroy_sam_success"] = "dx_br_dmzo_cost_ovld_dsex";
  game["dialog"]["dmz_mission_vehicledrive_accept"] = "dx_br_dmzo_cost_ovld_aivd";
  game["dialog"]["dmz_mission_vehicledrive_open_door"] = "dx_br_dmzo_cost_ovld_vdad";
  game["dialog"]["dmz_mission_vehicledrive_extract_inbound"] = "dx_br_dmzo_cost_ovld_vdar";
  game["dialog"]["dmz_mission_vehicledrive_destination"] = "dx_br_dmzo_cost_ovld_vhdd";
  game["dialog"]["dmz_mission_vehicledrive_assigned"] = "dx_br_dmzo_cost_ovld_vhda";
}

initfx() {
  if(!isDefined(level._effect["cargo_pallet_destruction"]))
    level._effect["cargo_pallet_destruction"] = loadfx("vfx/iw9/veh/scriptables/death/vfx_veh_cargo_dest.vfx");

  if(!isDefined(level._effect["gunship_flares"]))
    level._effect["gunship_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_flares.vfx");
}

_id_4FB6F74E053A49D6() {
  level.nosuspensemusic = 1;

  if(getdvarint("dvar_9C43B60485FBD92E", 0) != 1)
    level waittill("prematch_fade_done");
  else
    wait 5;

  _id_7AB5B649FA408138::_id_0F1AED36AB4598EA("mp_gamemode_dmz");
}

_id_F269438F48049613() {
  level endon("game_ended");
}

initpostmain() {
  level endon("game_ended");
  level._id_F38E7B13448998B4 = ::_id_F38E7B13448998B4;

  if(getdvarint("dvar_FF65C25889692DB8", 0) == 0)
    _id_362C58E8BB39BCDA::registerbrgametypefunc("infilSequence", ::_id_73BDF8B18E29B13F);

  scripts\cp_mp\utility\script_utility::registersharedfunc("hud", "showDMZSplash", ::_id_AE6091699E25D8B4);
  scripts\cp_mp\utility\script_utility::registersharedfunc("inventory", "isBackpackInventoryEnabled", _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2);
  waittillframeend;
  scripts\mp\flags::gameflaginit("start_fortress_spawns", 0);
  nojip = getdvarint("dvar_C26EF34F769BD14F", 1) == 1;
  setnojiptime(nojip, 1);
  setnojipscore(nojip, 1);
  level.nojip = nojip;

  if(!nojip)
    level thread _id_0FFC9BEBE581E6FA();

  level thread _id_304F476283F6D36E::_id_D197EDBD2618C9D1();
  level.getspawnpoint = ::getspawnpoint;
  level.modemayconsiderplayerdead = ::brmayconsiderplayerdead;
  level.brmodevariantrewardcullfunc = ::_id_3ACBBD83AF4BCD34;
  level.ononeleftevent = ::_id_07CE541F0D7227AB;
  level.onplayerdisconnect = ::onplayerdisconnect;
  level.onplayerkilled = ::onplayerkilled;
  level.onpostkillcamcallback = ::onpostkillcamcallback;
  level.ontimelimit = ::ontimelimit;
  level.bypassclasschoicefunc = ::pickclassbr;
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level thread _id_03314ADD7998AB13::_id_DF15F72187363229();
  level thread _id_2FDEB8023287BE67::_id_1CCD859721E5EAEE();
  level thread _id_79D4B1C751A51F03::_id_AD4172A44F169CB6();
  level thread _id_662CBAC61C1AE7E2::_id_3E18070E9C4C07DB();

  if(level._id_EEF1D450C2D5D682)
    level thread _id_D8431975BBEC1179();

  if(level.mapname != "mp_ai_firefight")
    _id_28BEE6F49336B0A8::init();

  if(!scripts\cp_mp\utility\game_utility::_id_FFBBB4525B11D5A2())
    level._id_01A6C1600565C49A = _id_67015C88C47EC4F8::_id_DF0FE5AC51164868;

  _id_5C55C87B89467A29::_id_209B4F3CBE639411();
  _id_371B4C2AB5861E62::_id_9EC5F9CFC835208E();
  level thread _id_11750957AA915A23();
  level thread eomawardplayerxp();
  level thread _id_D236513E49E4E740();
  level thread _id_4948CDF739393D2D::_id_B6DB5C2031ED059A();
  level thread _id_57D3850A12CF1D8F::init();
  level thread _id_57D3850A12CF1D8F::_id_2A56C656879DBF63();
  level thread _id_7C03AB87C5F9F420::_id_83599506981C29CD();
  level thread _id_3403C13CEC1CEA46();
  level thread _id_6D337A1FD1D54C5F::_id_9C85640063AA1A62();
}

_id_0FFC9BEBE581E6FA() {
  _id_B2B90C3AAD0F71A4 = getdvarint("dvar_56BEC729CFB5D24C", 300);
  wait(_id_B2B90C3AAD0F71A4);
  setnojiptime(1, 1);
  setnojipscore(1, 1);
  level.nojip = 1;
}

_id_811855D1EDEEF614() {}

_id_F16652E1462A3739() {
  if(getdvarint("dvar_973E5E3DEBCA8D24", 0) != 1) {
    level._id_428703950599C9E9 = _id_268C4DA1EF6A20A8::_id_428703950599C9E9;
    _id_48814951E916AF89::init();
    level thread _id_268C4DA1EF6A20A8::init();
    level thread _id_1C47017BA325709A::_id_7F4D3080C6E8748B();
    level thread _id_2BC0B0102F9B7751::_id_D0FFCD08E0870CF2();
    level thread _id_640CF1641C03E2A0::_id_CA39A413ACE3C168();
    level thread _id_6153E980B3EB0E1B::_id_48E19AA598E95954();
    scripts\cp_mp\utility\script_utility::registersharedfunc("paraReinforce", "onChutePull", _id_640CF1641C03E2A0::_id_6A8AD55C5A4036D1);
    _id_8C3EC2D4F32359D0 = getdvarint("dvar_0878B14B03D2A762", 1);

    if(_id_8C3EC2D4F32359D0)
      _id_2B736EB3FDD9B328::_id_A9E26388B8DC22B3();

    _id_48814951E916AF89::_id_2FC80954FA70D153();

    if(_id_8C3EC2D4F32359D0)
      level thread _id_2B736EB3FDD9B328::_id_CBAE2BD62D2E7086();

    level thread _id_590D4C1AAF3A5235::_id_2E887982267D85A8();

    if(!istrue(level._id_4CFD75AA6DDDE156) || getdvarint("dvar_6C875CDB8F27302E", 0) == 1)
      level thread _id_2FDEB8023287BE67::_id_8CF8796583FE070E();

    _id_48814951E916AF89::_id_80CD0109B7F5161D();
    scripts\mp\flags::gameflagset("start_fortress_spawns");
    level thread _id_48814951E916AF89::_id_B4367B762AB15E1F();

    if(getdvarint("dvar_5FC378F6FC9470F7", 0))
      level thread _id_34874C98AB154F37::_id_918A46F20ADDF647();

    level thread _id_48814951E916AF89::_id_51014D65A15CF0F9();
  } else {}
}

onplayerconnect(player) {
  player setclientomnvar("ui_br_infiled", 1);

  if(_id_03314ADD7998AB13::_id_5EA5A722C499078F(player.team))
    _id_03314ADD7998AB13::_id_64623E2FF7409F39(player, 0);

  _id_1174ABEDBEFE9ADA::_id_1509B788F4410B94(player);
  _id_371B4C2AB5861E62::_id_03A458AF8AB69F4E(player);
}

_id_26F93CC0AD9B7C39() {
  self endon("disconnect");
  _id_2FE5EF40DC48DAF0();

  if(getdvarint("dvar_8DA4A5E690432CD0", 1) == 0) {
    return;
  }
  if(!self istacmapactive())
    self setclientomnvar("ui_dmz_mission_overlay", 1);

  wait 1;
  self setclientomnvar("ui_dmz_mission_overlay", 0);
}

_id_2FE5EF40DC48DAF0() {
  self endon("tac_map_toggle");
  self endon("disconnect");
  self endon("screen_completely_black");

  while(!self istacmapactive()) {
    if(isDefined(self) && isDefined(self.origin)) {
      if(_id_5DEF7AF2A9F04234::_id_47D356083884F913() && isDefined(level.teamdata) && isDefined(self.team) && isDefined(level.teamdata[self.team]) && isDefined(level.teamdata[self.team]["startPoint"]) && isDefined(level.teamdata[self.team]["startPoint"]._id_B205D90302DA2F07)) {
        _id_B205D90302DA2F07 = level.teamdata[self.team]["startPoint"]._id_B205D90302DA2F07;
        _id_BEF13F1E36D7DCD9 = _id_5DEF7AF2A9F04234::_id_D2ED76E2BEDD339E(_id_B205D90302DA2F07);

        if(isDefined(_id_BEF13F1E36D7DCD9) && distance(_id_BEF13F1E36D7DCD9, self.origin) < 13000)
          _id_1E4A61DB11011446::_id_258C4F40DEE8189A(_id_BEF13F1E36D7DCD9[0], _id_BEF13F1E36D7DCD9[1], 1.0);
        else
          _id_1E4A61DB11011446::_id_258C4F40DEE8189A(self.origin[0], self.origin[1], 1.0);
      } else
        _id_1E4A61DB11011446::_id_258C4F40DEE8189A(self.origin[0], self.origin[1], 1.0);
    }

    wait 1;
  }
}

brmayconsiderplayerdead(player) {
  if(isDefined(level.checkforlaststandwipe))
    [[level.checkforlaststandwipe]](player);

  if(istrue(self.squadwiped)) {
    player setplayermusicstate("mp_lose_2");
    _id_5307834CD39B435C::_id_2EDA2621150BD589([player], 4);
  }

  return 1;
}

_id_3ACBBD83AF4BCD34(rewards) {
  _id_36F04620526242FF = [];
  return _id_36F04620526242FF;
}

filtervehiclespawnstructs(_id_7A2113183150C910) {
  if(getdvarint("dvar_2CC531E644D4FDB3", 1) == 0)
    return _id_7A2113183150C910;

  if(!_id_5DEF7AF2A9F04234::_id_7E9CBC0F32DE6578())
    return [];

  if(!isDefined(level._id_AB20B3A256911579) || level._id_AB20B3A256911579.size == 0)
    return _id_7A2113183150C910;

  _id_7CB19F95DBC68942 = [];

  foreach(struct in _id_7A2113183150C910) {
    if(!isDefined(struct.origin)) {
      continue;
    }
    _id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(struct.origin, 1);

    if(scripts\engine\utility::array_contains(level._id_AB20B3A256911579, _id_B205D90302DA2F07)) {
      continue;
    }
    _id_7CB19F95DBC68942[_id_7CB19F95DBC68942.size] = struct;
  }

  return _id_7CB19F95DBC68942;
}

_id_07CE541F0D7227AB(team) {}

onplayerdisconnect(player) {
  if(getdvarint("dvar_8F63416F53600636", 1) && scripts\mp\utility\player::isreallyalive(player) && !istrue(player.extracted) && !istrue(player._id_DED04CDD264A7E00)) {
    if(_id_2D9D24F7C63AC143::_id_720D227D0E55A960())
      _id_2391409EF7B431E1::_id_F6D685CABFAD2CE9(player);

    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
    player _id_2D9D24F7C63AC143::_id_C6B3799B231916BB(player, dropstruct);

    if(_id_7E52B56769FA7774::_id_990BE1AA4AD3C9D4())
      player _id_7E52B56769FA7774::_id_C15A28FC6247AD60(dropstruct);
  } else {
    player _id_3AACF02225CA0DA5::_id_C320904C58171311();

    if(isDefined(player._id_5F6D702BC79161F8))
      scripts\mp\objidpoolmanager::returnobjectiveid(player._id_5F6D702BC79161F8);
  }

  if(!istrue(player.extracted) && !istrue(player._id_DED04CDD264A7E00))
    scripts\cp_mp\challenges::_id_B8E86C6DEA0AC027(player);

  _id_C227BD210D16E07C(player);
  level thread _id_DA0FA1AFAA8835CF();
}

_id_C227BD210D16E07C(player) {
  if(istrue(player._id_84D661FF601A2F9F)) {
    return;
  }
  if(istrue(player._id_DED04CDD264A7E00)) {
    if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
      _id_0B7A9CE0A2282B79::_id_CD234CDD6B1B3699(player);
  } else if(!istrue(player.extracted)) {
    if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7() && _id_0B7A9CE0A2282B79::_id_DEDF2039EDEE97D0())
      _id_0B7A9CE0A2282B79::_id_868B6D4FBEC3938C(player);
    else {
      player _id_2D9D24F7C63AC143::_id_5C5E6619F0B24F90();
      _id_2D9D24F7C63AC143::_id_954372D604277278(player);
    }

    scripts\cp_mp\challenges::_id_868B6D4FBEC3938C(player);
  } else {
    _id_0B7A9CE0A2282B79::_id_2495DD1DDE4756FB(player);
    _id_0B7A9CE0A2282B79::_id_EA65E35C77F7679B(player);
  }

  player._id_84D661FF601A2F9F = 1;

  if(!istrue(player._id_DED04CDD264A7E00))
    _id_6A8EC730B2BFA844::_id_B0CA76F04AD0E0C3(player);
}

onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00) {
  _id_1E4A61DB11011446::onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, _id_61B5D0250B328F00);

  if(!istrue(level._id_FC90401F4AE3F765)) {
    self.class = "gamemode";
    self.pers["gamemodeLoadout"] = [];
    scripts\mp\class::respawnitems_clear();
  }

  _id_F3990D8529DE3A54 = _id_2D9D24F7C63AC143::_id_C4F1BD7A01A307FA(self);
  _id_2D9D24F7C63AC143::_id_5C5E6619F0B24F90(_id_F3990D8529DE3A54);
  _id_2D9D24F7C63AC143::_id_954372D604277278(self);

  if(isDefined(self._id_5F6D702BC79161F8))
    attacker _id_34874C98AB154F37::_id_A5D597201278C71C(self);

  if(_id_362C58E8BB39BCDA::isfeatureenabled("pleaForHelp"))
    self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("pleaForHelp", "callForHelp")]]();

  _id_42DB00FECB0FA74D::_id_47EF2434C27B063C(self, attacker, smeansofdeath);
  level thread _id_DA0FA1AFAA8835CF();
  level thread _id_265AFD733FF97699(self);
}

_id_265AFD733FF97699(_id_F99D56BCB582A8BA) {
  _id_F99D56BCB582A8BA notify("revive_timer_watch");
  _id_F99D56BCB582A8BA endon("revive_timer_watch");
  _id_F99D56BCB582A8BA endon("revivedAlive");
  _id_F99D56BCB582A8BA endon("restored_loot");
  _id_F99D56BCB582A8BA endon("disconnect");
  _id_F99D56BCB582A8BA endon("spawned_player");
  level endon("game_ended");

  if(!isDefined(_id_F99D56BCB582A8BA.team) || !isDefined(_id_F99D56BCB582A8BA._id_0FF97225579DE16A)) {
    return;
  }
  wait(getdvarint("dvar_9A366844FF95B5D7", 90));
  _id_A6AB8D0FDA441DC2 = scripts\mp\utility\teams::_id_3D0F2343793D709B(_id_F99D56BCB582A8BA.team, _id_F99D56BCB582A8BA._id_0FF97225579DE16A, 1);

  if(_id_A6AB8D0FDA441DC2.size <= 1) {
    return;
  }
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("squad_revive_reminder", _id_A6AB8D0FDA441DC2);
}

_id_1714FFEA633DCFED(team) {
  if(team == "all" || !_id_14D3930854CB398C::_id_4DB915A9CE0E903A() || !getdvarint("dvar_A5BFCE6C742AA583", 1))
    return 0;

  thread _id_ED7A5462253EBDEF(team);
  return 1;
}

_id_ED7A5462253EBDEF(team) {
  level endon("game_ended");
  _id_03314ADD7998AB13::_id_ADC51ADE78872D95(team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(!_id_14D3930854CB398C::_id_C1E2F014739D7903(player)) {
      player notify("check_for_plea");
      waitframe();

      if(!_id_14D3930854CB398C::_id_BFDFD3C9BA0CC7CB(player)) {
        thread _id_74E0AAE435A09A51(player);
        player notify("plea_eliminated");
        continue;
      }

      thread _id_5DF318837F8D78A2(player);
    }
  }
}

_id_04253EEC492C87AA() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  starttime = gettime();

  if(level.killcam) {
    while(!isDefined(self._id_7C813E50FF75BE27)) {
      timeelapsed = gettime() - starttime;

      if(timeelapsed >= 1000) {
        return;
      }
      waitframe();
    }

    if(level.killcam && istrue(self.killcam))
      scripts\engine\utility::waittill_any_3("killcam_ended", "killcam_canceled", "abort_killcam");
  }
}

_id_5DF318837F8D78A2(player) {
  player notify("waiting_for_plea");
  level endon("game_ended");
  player endon("disconnect");
  player endon("revivedAlive");
  player endon("waiting_for_plea");
  player endon("plea_created");
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getteamdata(player.team, "players");

  foreach(_id_80EF668C09FFB70F in _id_6D5ED003AF1F9612) {
    if(isDefined(_id_80EF668C09FFB70F))
      _id_80EF668C09FFB70F endon("spawned_player");
  }

  player setclientomnvar("ui_show_spectateHud", player getentitynumber());
  player._id_7C813E50FF75BE27 = undefined;
  player _id_04253EEC492C87AA();
  waitframe();
  player setclientomnvar("ui_waiting_for_aar", 1);
  endtime = int(gettime() + getdvarint("dvar_E323D1171DAB7BFF", 20) * 1000);
  player._id_6AF52E47CBD09141 = endtime;
  player scripts\mp\utility\lower_message::setlowermessageomnvar("plea_time", endtime);
  _id_14D3930854CB398C::_id_D8B32F106816AFC1(player);
  thread _id_74E0AAE435A09A51(player);

  if(_id_14D3930854CB398C::_id_C1E2F014739D7903(player))
    _id_14D3930854CB398C::_id_58E61608AAB59511(player);

  player notify("plea_eliminated");
}

_id_74E0AAE435A09A51(player) {
  _id_5307834CD39B435C::_id_2EDA2621150BD589([player], 4);
  player.squadwiped = 1;

  if(!istrue(player.extracted) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("dmz_bosses", "onPlayerSquadWiped"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("dmz_bosses", "onPlayerSquadWiped")]](player);

  player setclientomnvar("ui_league_play_br_leave_penalty_timer", 0);
  _id_A9CEB9B39C78FB07 = [];
  _id_5AAB9D85460F9E87 = 0;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    if(_id_F90358454413407F == player.team) {
      continue;
    }
    _id_849D01AFB2FC0F0A = _id_1E4A61DB11011446::_id_99E3948BFD8A99B8(_id_F90358454413407F);

    if(_id_849D01AFB2FC0F0A > 0) {
      _id_A9CEB9B39C78FB07[_id_A9CEB9B39C78FB07.size] = _id_F90358454413407F;
      _id_5AAB9D85460F9E87 = _id_5AAB9D85460F9E87 + _id_849D01AFB2FC0F0A;
    }
  }

  teamplacement = _id_A9CEB9B39C78FB07.size + 1;
  [_id_B5D67493FB854F58, _id_1B70C48B930405F0, _id_D6A23FDABD1D282C] = player _id_1E4A61DB11011446::calculatebrbonusxp(teamplacement, player.team);
  _id_B01ACA3236595958 = _id_09E8CCAD6488211B::_id_8B22E17D9E3AAEA3(player);
  player _id_1E4A61DB11011446::givebrbonusxp(_id_B5D67493FB854F58, undefined, "squadEliminated", _id_B01ACA3236595958);
  player.matchbonus = scripts\mp\rank::_id_C18C8BB0776284C6(_id_1B70C48B930405F0, _id_B01ACA3236595958);
  player.placementbonus = scripts\mp\rank::_id_9E1336D25EB66326(_id_D6A23FDABD1D282C, _id_B01ACA3236595958);
  player thread _id_1E4A61DB11011446::handlebrdefeatedpostgamestate(teamplacement);
  player _id_1E4A61DB11011446::setplacementstats(teamplacement);
  player _id_1E4A61DB11011446::stopchallengetimers();
  scripts\mp\gamelogic::_setplayerteamrank(player, teamplacement);
  _id_1E4A61DB11011446::updateclientmatchdata(player);

  if(istrue(level._id_77907D733ABE8B63))
    player _id_697B7AE06BA9B28C::_id_D1092FECB16D3B3C(teamplacement, 1, 0);

  result = undefined;

  if(istrue(player.pers["hasDoneAnyCombat"]) || istrue(player.pers["participation"]))
    result = "eliminated";

  player scripts\cp_mp\utility\game_utility::stopkeyearning(result);
  _func_EB1A045A6D299C6A();
}

_id_ADC51ADE78872D95(team) {
  if(team == "all") {
    foreach(player in level.players) {
      if(isDefined(player)) {
        player.squadwiped = 1;
        player thread _id_1E4A61DB11011446::handlebrdefeatedpostgamestate();
        player _id_1E4A61DB11011446::stopchallengetimers();
        _id_5307834CD39B435C::_id_2EDA2621150BD589([player], 4);
        _id_1E4A61DB11011446::updateclientmatchdata(player);
      }
    }
  } else {
    players = scripts\mp\utility\teams::getteamdata(team, "players");
    _id_5307834CD39B435C::_id_2EDA2621150BD589(players, 4);

    foreach(_id_736D8D9188CCBD45 in players) {
      _id_736D8D9188CCBD45.squadwiped = 1;

      if(!istrue(_id_736D8D9188CCBD45.extracted)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dmz_bosses", "onPlayerSquadWiped"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("dmz_bosses", "onPlayerSquadWiped")]](_id_736D8D9188CCBD45);
      }
    }

    _id_03314ADD7998AB13::_id_ADC51ADE78872D95(team);
  }
}

_id_F1AD30EFC5733CAF() {
  self notify("reconcileLoot");
  self endon("reconcileLoot");
  self endon("disconnect");
  self endon("restored_loot");
  level endon("game_ended");
  self waittill("revivedAlive");
  thread _id_0F0E913C037010A9();
  thread _id_707D956BDBD4B134();
}

_id_707D956BDBD4B134() {
  self notify("restored_loot");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  _id_0B7A9CE0A2282B79::_id_F30F21D87C483297(self);
  self._id_4F7710ECFF5B1619 = undefined;
  self._id_457667014505E1F9 = undefined;

  if(isDefined(self._id_BA19D6A40E652DD6)) {
    _id_176ECFACEE5F2EF4 = self._id_BA19D6A40E652DD6;
    _id_BF334F5702551108 = self._id_0CD82E790E825DB2;

    if(istrue(level._id_813B4B2211FBAF1D) && isDefined(self._id_6A4360DCF2A8F3D4) && isDefined(self._id_6A4360DCF2A8F3D4._id_BF23A60678978C19) && isDefined(self._id_6A4360DCF2A8F3D4._id_BF23A60678978C19[9]) && !istrue(self._id_6A4360DCF2A8F3D4._id_BF23A60678978C19[9]["lootID"])) {
      _id_BF334F5702551108 = undefined;
      _id_176ECFACEE5F2EF4 = 5;
    }

    _id_2D9D24F7C63AC143::_id_D28F52DA6EDE0191(self, _id_176ECFACEE5F2EF4, undefined, _id_BF334F5702551108);

    if(isDefined(_id_BF334F5702551108))
      _id_0B7A9CE0A2282B79::_id_92D947129EA5BA6E(self, _id_BF334F5702551108);
  }

  if(isDefined(self._id_6A4360DCF2A8F3D4) && isDefined(self._id_6A4360DCF2A8F3D4.contents)) {
    _id_342175A1B9F9067E = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(self);
    _id_65B695F0C0D909ED = 0;
    dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();

    foreach(index, item in self._id_6A4360DCF2A8F3D4.contents) {
      if(isDefined(item)) {
        lootid = item["lootID"];
        quantity = item["quantity"];

        if(_id_65B695F0C0D909ED >= _id_342175A1B9F9067E && lootid > 0 && quantity > 0) {
          if(!getdvarint("dvar_F48EF3A11B86B06D", 1)) {
            break;
          }

          _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
          scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);
          _id_87583859F07B58E3 = _id_7E52B56769FA7774::spawnpickup(scriptablename, _id_CB4FAD49263E20C4, quantity, 1);
        } else {
          scripts\cp_mp\utility\script_utility::_id_F3BB4F4911A1BEB2(lootid, "pickedUp", self._id_6A4360DCF2A8F3D4, self);
          _id_2D9D24F7C63AC143::_id_11F48AE5B87B4525(self, _id_65B695F0C0D909ED, lootid, quantity);
        }

        _id_65B695F0C0D909ED++;
      }
    }

    if(isDefined(self._id_6A4360DCF2A8F3D4._id_04F6CDE716E0C3D7) && isDefined(self._id_6A4360DCF2A8F3D4._id_6FB67C8525B1D79E)) {
      weapon = self._id_6A4360DCF2A8F3D4._id_6FB67C8525B1D79E;
      _id_2D9D24F7C63AC143::_id_E35A7CB7E7C8C17E(self, weapon, undefined, self._id_6A4360DCF2A8F3D4._id_4E479E14D0837E84);
      _id_724736FCF0FB6604::_id_AE30366A2D519A57(self, 2, self._id_6A4360DCF2A8F3D4._id_275F4441AB7920C8);
    }

    if(!istrue(level._id_813B4B2211FBAF1D))
      _id_7E52B56769FA7774::loothide(self._id_6A4360DCF2A8F3D4);
  }

  _id_EBC7C27C25633BB7 = undefined;

  if(!istrue(level._id_51225D738094457D) && isDefined(self._id_D2DBB2FA012E6D9C)) {
    _id_BFBB389447A5262C = 0;
    isweaponpickup = 0;

    foreach(key, item in self._id_D2DBB2FA012E6D9C) {
      if(isDefined(item)) {
        if(isDefined(item.customweaponname) && !scripts\mp\weapons::isfistweapon(item.customweaponname)) {
          if(!isDefined(_id_EBC7C27C25633BB7))
            _id_EBC7C27C25633BB7 = item.customweaponname;

          _id_BFBB389447A5262C++;
          isweaponpickup = 1;
        } else if(isDefined(item.type) && isDefined(level.br_lootiteminfo) && isDefined(level.br_lootiteminfo[item.type]) && isDefined(level.br_lootiteminfo[item.type].fullweaponname) && !scripts\mp\weapons::isfistweapon(level.br_lootiteminfo[item.type].fullweaponname)) {
          if(!isDefined(_id_EBC7C27C25633BB7))
            _id_EBC7C27C25633BB7 = level.br_lootiteminfo[item.type].fullweaponname;

          _id_BFBB389447A5262C++;
          isweaponpickup = 1;
        }

        if(_id_BFBB389447A5262C == 3 && isweaponpickup) {
          _id_BFBB389447A5262C = 0;
          pickup = spawnStruct();
          pickup.scriptablename = item.type;
          pickup.count = _id_7E52B56769FA7774::loot_getitemcount(item);
          pickup.countlefthand = _id_7E52B56769FA7774::loot_getitemcountlefthand(item);
          pickup._id_E97D731BEDD44C63 = _id_7E52B56769FA7774::_id_3A5F7703319142DD(item);
          pickup.instance = item;

          if(isDefined(item.customweaponname))
            pickup.customweaponname = item.customweaponname;

          _id_7F6369ECA6D7C141 = _id_724736FCF0FB6604::_id_55C5D35C8C76A95B(pickup);
          _id_DD515FCF025B2E79 = _id_7F6369ECA6D7C141[0];
          _id_2D9D24F7C63AC143::_id_E35A7CB7E7C8C17E(self, _id_DD515FCF025B2E79);
          _id_724736FCF0FB6604::_id_AE30366A2D519A57(self, 2, item._id_E1147886CCF51970);
          _id_7E52B56769FA7774::loothide(item);
        } else
          _id_7E52B56769FA7774::lootused(item, item.type, "visible", self, 0, item.type);

        self._id_D2DBB2FA012E6D9C[key] = undefined;
        isweaponpickup = 0;
      }
    }
  }

  if(istrue(level._id_51225D738094457D) && isDefined(self._id_77893F01EE39C62E) && isDefined(self._id_77893F01EE39C62E.contents)) {
    foreach(item in self._id_77893F01EE39C62E.contents) {
      if(isDefined(item)) {
        lootid = item["lootID"];
        quantity = item["quantity"];

        if(lootid == 0 || quantity == 0) {
          continue;
        }
        if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid)) {
          [_id_C9CCB7804978DC9F, _] = _id_2391409EF7B431E1::_id_E92E13020D5EE099(quantity);

          if(isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player))
            _id_2391409EF7B431E1::_id_8E643D6706DEFEEA(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player, quantity);

          if(isDefined(level._id_547167A7517600FB) && isDefined(level._id_547167A7517600FB._id_5B72B9E0891944AE))
            [[level._id_547167A7517600FB._id_5B72B9E0891944AE]](self);

          continue;
        }

        _id_7E52B56769FA7774::_id_FE539E37B6579930(lootid, quantity);
      }
    }

    if(isDefined(self._id_77893F01EE39C62E._id_04F6CDE716E0C3D7) && isDefined(self._id_77893F01EE39C62E._id_6FB67C8525B1D79E)) {
      weapon = self._id_77893F01EE39C62E._id_6FB67C8525B1D79E;
      _id_1B47EC827F34BD5B = getcompleteweaponname(weapon);
      basename = undefined;

      if(isDefined(weapon.basename))
        basename = weapon.basename;
      else
        basename = getweaponbasename(weapon);

      success = _id_724736FCF0FB6604::br_forcegivecustomweapon(self, weapon, _id_1B47EC827F34BD5B, basename, undefined, undefined, undefined, self._id_77893F01EE39C62E._id_4E479E14D0837E84);
      _id_FE4048AD22C35D73 = _id_724736FCF0FB6604::_id_2AB3BDA08C595A32(self, weapon);

      if(isDefined(_id_FE4048AD22C35D73))
        _id_724736FCF0FB6604::_id_AE30366A2D519A57(self, _id_FE4048AD22C35D73, self._id_77893F01EE39C62E._id_275F4441AB7920C8);
    }

    _id_7E52B56769FA7774::loothide(self._id_77893F01EE39C62E);
  }

  if(istrue(level._id_813B4B2211FBAF1D)) {
    if(isDefined(self._id_D2DBB2FA012E6D9C) && self._id_D2DBB2FA012E6D9C.size > 0) {
      self._id_C7FD13C53DBDC4F6 = 1;

      foreach(item in self._id_D2DBB2FA012E6D9C)
      _id_7E52B56769FA7774::lootused(item, item.type, "visible", self, 0, item.type);

      self._id_C7FD13C53DBDC4F6 = undefined;
      self._id_D2DBB2FA012E6D9C = [];
    }

    if(isDefined(self._id_6A4360DCF2A8F3D4) && isDefined(self._id_6A4360DCF2A8F3D4._id_BF23A60678978C19)) {
      foreach(item in self._id_6A4360DCF2A8F3D4._id_BF23A60678978C19) {
        if(isDefined(item)) {
          lootid = item["lootID"];
          quantity = item["quantity"];

          if(lootid == 0 || quantity == 0) {
            continue;
          }
          scriptablename = _id_600B944A95C3A7BF::_id_E1D5A33193DB0133(lootid);

          if(_id_2391409EF7B431E1::_id_03C17A26CE6A4668(lootid)) {
            [_id_C9CCB7804978DC9F, _] = _id_2391409EF7B431E1::_id_E92E13020D5EE099(quantity);

            if(isDefined(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player))
              _id_2391409EF7B431E1::_id_8E643D6706DEFEEA(level._id_B287C5D31BEE8267[_id_C9CCB7804978DC9F].player, quantity);

            if(isDefined(level._id_547167A7517600FB) && isDefined(level._id_547167A7517600FB._id_5B72B9E0891944AE))
              [[level._id_547167A7517600FB._id_5B72B9E0891944AE]](self);

            continue;
          }

          if(_id_7E52B56769FA7774::_id_B1E944A2B3E15E9D(scriptablename))
            continue;
          else {
            if(_id_2CEDCC356F1B9FC8::isarmorplate(scriptablename))
              self._id_D4BFB0D4D797F448 = 1;

            _id_7E52B56769FA7774::_id_FE539E37B6579930(lootid, quantity);
          }
        }
      }

      if(isDefined(self._id_6A4360DCF2A8F3D4._id_A06E7128C001851D) && isDefined(self._id_6A4360DCF2A8F3D4._id_A0E9FEF038504BD0)) {
        weapon = self._id_6A4360DCF2A8F3D4._id_A0E9FEF038504BD0;
        _id_1B47EC827F34BD5B = getcompleteweaponname(weapon);
        basename = undefined;

        if(isDefined(weapon.basename))
          basename = weapon.basename;
        else
          basename = getweaponbasename(weapon);

        success = _id_724736FCF0FB6604::br_forcegivecustomweapon(self, weapon, _id_1B47EC827F34BD5B, basename, undefined, undefined, undefined, self._id_6A4360DCF2A8F3D4._id_BB6791B7369EF71A);
        _id_FE4048AD22C35D73 = _id_724736FCF0FB6604::_id_2AB3BDA08C595A32(self, weapon);

        if(isDefined(_id_FE4048AD22C35D73))
          _id_724736FCF0FB6604::_id_AE30366A2D519A57(self, _id_FE4048AD22C35D73, self._id_6A4360DCF2A8F3D4._id_C31356A794D8CB46);
      }
    }

    if(isDefined(self._id_6A4360DCF2A8F3D4))
      _id_7E52B56769FA7774::loothide(self._id_6A4360DCF2A8F3D4);
  }

  if(istrue(level._id_51225D738094457D)) {
    if(isDefined(self._id_3480393DC131952A)) {
      item = self._id_3480393DC131952A;

      if(!isDefined(_id_EBC7C27C25633BB7)) {
        if(isDefined(item.customweaponname) && !scripts\mp\weapons::isfistweapon(item.customweaponname))
          _id_EBC7C27C25633BB7 = item.customweaponname;
        else if(isDefined(item.type) && isDefined(level.br_lootiteminfo) && isDefined(level.br_lootiteminfo[item.type]) && isDefined(level.br_lootiteminfo[item.type].fullweaponname) && !scripts\mp\weapons::isfistweapon(level.br_lootiteminfo[item.type].fullweaponname))
          _id_EBC7C27C25633BB7 = level.br_lootiteminfo[item.type].fullweaponname;
      }

      _id_7E52B56769FA7774::lootused(item, item.type, "visible", self, 0, item.type);
    }

    if(isDefined(self.dogtag) && !istrue(level._id_813B4B2211FBAF1D))
      _id_7E52B56769FA7774::lootused(self.dogtag, self.dogtag.type, "visible", self, 0, self.dogtag.type);
  }

  if(isDefined(self._id_73BB45340691326C)) {
    self.br_ammo = self._id_73BB45340691326C;
    _id_724736FCF0FB6604::br_ammo_update_weapons(self);
  }

  if(istrue(level._id_51225D738094457D) && isDefined(self._id_620F2A17DF977448)) {
    item = self._id_620F2A17DF977448;
    _id_7E52B56769FA7774::lootused(item, item.type, "visible", self, 0, item.type);
  }

  self.dogtag = undefined;
  waitframe();

  if(isDefined(_id_EBC7C27C25633BB7) && self hasweapon(_id_EBC7C27C25633BB7))
    self switchtoweaponimmediate(_id_EBC7C27C25633BB7);

  if(isDefined(self.equipment) && !isDefined(self.equipment["health"]))
    _id_07C40FA80892A721::_id_BE5C0CDFA0202544();
}

_id_0C3F3FCEEDDDA6F6(_id_C2FC8BF80C1B0AA2) {
  if(!getdvarint("dvar_DF3D4C7861E822B4", 1)) {
    return;
  }
  if(isDefined(self.attached_bag))
    _id_6D569066AC5F3DF0();

  self attach(_id_C2FC8BF80C1B0AA2, "tag_stowed_back3", 1, 1);

  if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.body) || self.operatorcustomization.body != "body_mp_gus_iw9_1_1") {
    if(self tagexists("TAG_STOWED_BACKPACK_HIDE"))
      self hidepart("TAG_STOWED_BACKPACK_HIDE");
  }

  self.attached_bag = _id_C2FC8BF80C1B0AA2;
}

_id_6D569066AC5F3DF0() {
  if(!getdvarint("dvar_DF3D4C7861E822B4", 1) || !isDefined(self.attached_bag)) {
    return;
  }
  self detach(self.attached_bag, "tag_stowed_back3");
  self.attached_bag = undefined;
}

onpostkillcamcallback() {}

ontimelimit() {
  if(isDefined(level._id_AAB9F6CFC50F372F))
    [[level._id_AAB9F6CFC50F372F]]();
  else if(!istrue(level._id_99EADAE60B4B76E4)) {
    level thread _id_1174ABEDBEFE9ADA::_id_A01F654E559EE5EC();
    level._id_99EADAE60B4B76E4 = 1;
  }
}

checkendgame() {
  level endon("dmzDeathEnd");
  level waittill("dmz_radiation_complete");
  wait(level._id_EF3E0EB58D1263C5);
  _id_5D292910802798B2 = 2;
  level._id_999D19FFA4F37DF9 = 1;

  foreach(player in level.players) {
    if(isDefined(player) && scripts\mp\utility\player::isreallyalive(player) && !istrue(player.extracted))
      player thread _id_FC71EB3BA70583A1(_id_5D292910802798B2);
  }

  if(isDefined(level.revivetriggers)) {
    foreach(guid, _id_B25CA392892D7A80 in level.revivetriggers) {
      if(isDefined(_id_B25CA392892D7A80.victim))
        _id_B25CA392892D7A80.victim thread scripts\mp\teamrevive::removetrigger(guid);
    }
  }

  wait(_id_5D292910802798B2 + 5);
  level notify("dmzTimerEnd");

  foreach(player in level.players)
  _id_C227BD210D16E07C(player);

  scripts\mp\gamelogic::endgame_regularmp("none", game["end_reason"]["time_limit_reached"], game["end_reason"]["time_limit_reached"]);
}

_id_FC71EB3BA70583A1(_id_5D292910802798B2) {
  self endon("disconnect");
  scripts\mp\utility\player::hidehudenable();
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, _id_5D292910802798B2);
  wait(_id_5D292910802798B2);
  _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("exfil_none", [self]);
  self dodamage(999999, self.origin, self, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  self freezecontrols(1);
  wait 2;
  scripts\mp\utility\player::hidehuddisable();
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);
}

_id_DA0FA1AFAA8835CF() {
  level notify("checkEndGameDeathDmz");
  level endon("checkEndGameDeathDmz");
  level endon("dmzTimerEnd");
  wait 25;

  foreach(_id_F90358454413407F in level.teamnamelist) {
    _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "aliveCount");

    if(_id_BCE4EFC75EB01319) {
      aliveplayers = scripts\mp\utility\teams::getteamdata(_id_F90358454413407F, "alivePlayers");

      foreach(player in aliveplayers) {
        if(isDefined(player) && !istrue(player.extracted))
          return;
      }
    }
  }

  wait 1;

  foreach(player in level.players) {
    if(isDefined(player))
      _id_C227BD210D16E07C(player);
  }

  level notify("dmzDeathEnd");
  scripts\mp\gamelogic::endgame_regularmp("none", game["end_reason"]["time_limit_reached"], game["end_reason"]["time_limit_reached"]);
}

_id_D236513E49E4E740() {
  _id_F49539F37FC54ABA = scripts\mp\gamelogic::gettimeremaining() / 1000 / 60;
  level._id_5EA7C93B496821EA = [];
  level._id_CCA4E7F5433DD7D8 = 0;
  level._id_CCADF0F543480A51 = 0;
  level._id_CCADF3F5434810EA = 0;
  level._id_FC4B2BCC24F36E2A = 0;
  level._id_FC4B28CC24F36791 = 0;

  if(!level._id_CCA4E7F5433DD7D8 && _id_F49539F37FC54ABA < 30) {
    level._id_CCA4E7F5433DD7D8 = 1;
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("match_remaining_30", level.players);
  }

  if(!level._id_CCADF0F543480A51 && _id_F49539F37FC54ABA < 15) {
    level._id_CCADF0F543480A51 = 1;
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("match_remaining_15", level.players);
  }

  if(!level._id_CCADF3F5434810EA && _id_F49539F37FC54ABA < 10) {
    level._id_CCADF3F5434810EA = 1;
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("match_remaining_10", level.players);
  }

  if(!level._id_FC4B2BCC24F36E2A && _id_F49539F37FC54ABA < 5) {
    level._id_FC4B2BCC24F36E2A = 1;
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("match_remaining_5", level.players);
  }

  if(!level._id_FC4B28CC24F36791 && _id_F49539F37FC54ABA <= 0) {
    level._id_FC4B28CC24F36791 = 1;
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("match_remaining_0", level.players);
  }
}

pickclassbr() {
  return self.class;
}

playershouldrespawn(data) {
  if(istrue(game["inLiveLobby"]))
    return 1;

  return 0;
}

spawnhandled(player) {
  return istrue(player.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  wait 1;
  scripts\mp\hud_message::showsplash("br_welcome");

  if(istrue(level.autoassignfirstquest) && istrue(level.br_prematchstarted))
    autoassignquest(self);
}

_id_E283C6996BFAD7AE() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility\dialog::leaderdialogonplayer("prematch_enter_mission");
  wait 3;
  scripts\mp\utility\dialog::leaderdialogonplayer("prematch_enter_gear");
}

_id_73BDF8B18E29B13F(players) {
  if(!_id_362C58E8BB39BCDA::isfeaturedisabled("oneLife"))
    setdynamicdvar(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getgametype(), "_numLives"), 1);

  while(!isDefined(level.players) || level.players.size == 0)
    waitframe();

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player _id_5BAB271917698DC4::_id_334A8FE67E88BBE7();
    player thread _id_08AA3182C50A3094();
  }

  _id_C40817516B7D2B68 = [];

  foreach(teamdata in level.teamdata) {
    if(isDefined(teamdata["startPoint"]))
      _id_C40817516B7D2B68[_id_C40817516B7D2B68.size] = teamdata["startPoint"].origin;
  }

  _id_48814951E916AF89::_id_0A767DBCB4DD41CE(_id_C40817516B7D2B68);
  wait 2.0;
  scripts\mp\flags::gameflagset("prematch_fade_done");
  wait 2.0;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }
    player thread _id_927A1C74689CE55A();
  }
}

_id_08AA3182C50A3094() {
  _id_14A780F439CFFF1D = getspawnpoint();
  self _meth_670863FC4008C3D8(_id_14A780F439CFFF1D.origin);
}

_id_927A1C74689CE55A() {
  _id_2CEDCC356F1B9FC8::playerwaittillstreamhintcomplete();
  spawnpoint = getspawnpoint();
  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  self setOrigin(spawnorigin, 1);
  self setplayerangles(spawnangles);
  _id_5BAB271917698DC4::_id_E68E4BB4F65F5FE4();
  self.plotarmor = undefined;
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self._id_D68B9F006BC2A1CB = 1;
}

_id_F6843E3A71516B3E() {
  self endon("disconnect");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);

  if(getdvarint("dvar_5FA01DE35B23EEE0", 1) == 1) {
    timeouttime = getdvarint("dvar_C483C0CFE7219133", 15000);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
    scripts\mp\utility\player::_enableignoreme();
    self freezecontrols(1);
    self _meth_B88C89BB7CD1AB8E(self.origin);
    starttime = gettime();

    while(!self ispredictedstreamposready() && gettime() - starttime < timeouttime)
      waitframe();

    scripts\mp\utility\player::_disableignoreme();
    self freezecontrols(0);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
  }

  self._id_D68B9F006BC2A1CB = 1;
}

_id_F38E7B13448998B4() {
  self endon("disconnect");

  if(!scripts\mp\flags::gameflag("prematch_values_reset"))
    scripts\mp\flags::gameflagwait("prematch_values_reset");

  _id_1E4A61DB11011446::brgivestartfieldupgrade();
  _id_7460B890072BFFBE();
  _id_6FC415FF6A905DC1::_id_F09E47B124561928();
  _id_0F0E913C037010A9();
  _id_12B9BC0F30AA8F5D();
  _id_1EBD7D347B85CAE3();
  _id_724736FCF0FB6604::br_ammo_update_weapons(self);

  if(getdvarint("dvar_4B6B3F032485ABF8", 0))
    _id_CD59D6BE22C74107();

  _id_4185480FA177DDB5 = getDvar("dvar_65A264CD9D78EE69", "");

  if(_id_4185480FA177DDB5 != "")
    _id_2D9D24F7C63AC143::_id_C2F16E2BBB4E38C0(_id_4185480FA177DDB5);

  thread _id_B68A411ADF965E7F();
}

_id_CD59D6BE22C74107() {
  if(isDefined(self._id_BED158A6DFAC230D) && self._id_BED158A6DFAC230D < 3) {
    _id_0347AA4935F42810 = _id_2CEDCC356F1B9FC8::_id_C2F2BB9E0AE9A454(3);
    _id_7E52B56769FA7774::_id_E98A5A4E0E001AC3(self, _id_0347AA4935F42810);
  }

  _id_31DAFC6BA15DFBC9 = _id_2D9D24F7C63AC143::_id_B13E35608B336D65(self);

  if(_id_31DAFC6BA15DFBC9 < 9) {
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7("brloot_backpack_large");
    _id_0B7A9CE0A2282B79::_id_5B7DC44BB66553A6(self);
    _id_0B7A9CE0A2282B79::_id_92D947129EA5BA6E(self, lootid);
    _id_2D9D24F7C63AC143::_id_D28F52DA6EDE0191(self, 9, undefined, lootid);
  }

  if(!_id_2CEDCC356F1B9FC8::hasselfrevivetoken())
    _id_7E52B56769FA7774::addselfrevivetoken(1);

  if(!_id_2D9D24F7C63AC143::_id_EFAB78B72D131D76(self)) {
    weaponobj = _id_7E52B56769FA7774::getfullweaponobjforscriptablepartname("brloot_weapon_sm_victor_lege");
    _id_2D9D24F7C63AC143::_id_E35A7CB7E7C8C17E(self, weaponobj, 1);
  }

  _id_EB061C2E39F5D6F7 = ["brloot_valuable_car_battery", "brloot_valuable_jumper_cables", "brloot_super_oxygenmask"];

  foreach(item in _id_EB061C2E39F5D6F7) {
    _id_65B695F0C0D909ED = _id_2D9D24F7C63AC143::_id_AE22C70A9C2474D9();

    if(!isDefined(_id_65B695F0C0D909ED)) {
      break;
    }

    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = item;
    _id_60227BFF1E9478CC.count = 1;
    lootid = _id_600B944A95C3A7BF::_id_FAE5E1D3DE32D3F7(item);
    _id_2D9D24F7C63AC143::_id_10F6E537F1B5763C(lootid, _id_60227BFF1E9478CC);
  }
}

_id_7460B890072BFFBE() {
  _id_A4E8372932B8612C = self.classstruct.loadoutkillstreak1;

  if(isDefined(_id_A4E8372932B8612C) && _id_A4E8372932B8612C != "none" && getdvarint("dvar_2BE93DD484220A45", 0) == 0)
    _id_7E52B56769FA7774::forcegivekillstreak(_id_A4E8372932B8612C, 0, 0);
}

_id_62B40B6A6C2CF37A() {
  level._id_65F3F1FEF64FFA68 = spawnStruct();
  level._id_F38AEC9B79359AF1 = getdvarint("dvar_1E556FF10B892938", 0) == 1;
  level._id_65F3F1FEF64FFA68.perks = [];
  level._id_65F3F1FEF64FFA68.perks["specialty_hustle"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_hustle");
  level._id_65F3F1FEF64FFA68.perks["specialty_tac_resist"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_tac_resist");
  level._id_65F3F1FEF64FFA68.perks["specialty_eod"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_eod");
  level._id_65F3F1FEF64FFA68.perks["specialty_scavenger_plus"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_scavenger_plus");
  level._id_65F3F1FEF64FFA68.perks["specialty_grenade_expert"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_grenade_expert");
  level._id_65F3F1FEF64FFA68.perks["specialty_focus"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_focus");
  level._id_65F3F1FEF64FFA68.perks["specialty_warhead"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_warhead");
  level._id_65F3F1FEF64FFA68.perks["specialty_covert_ops"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_covert_ops");
  level._id_65F3F1FEF64FFA68.perks["specialty_quick_fix"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_quick_fix");
  level._id_65F3F1FEF64FFA68.perks["specialty_guerrilla"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_guerrilla");
  level._id_65F3F1FEF64FFA68.perks["specialty_tactical_recon"] = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5("specialty_tactical_recon");
  level._id_65F3F1FEF64FFA68._id_21832626A15C50DA = [];
  level._id_65F3F1FEF64FFA68._id_21832626A15C50DA[0] = [level._id_65F3F1FEF64FFA68.perks["specialty_hustle"], level._id_65F3F1FEF64FFA68.perks["specialty_tac_resist"], level._id_65F3F1FEF64FFA68.perks["specialty_eod"], level._id_65F3F1FEF64FFA68.perks["specialty_scavenger_plus"], level._id_65F3F1FEF64FFA68.perks["specialty_grenade_expert"]];
  level._id_65F3F1FEF64FFA68._id_21832626A15C50DA[1] = [level._id_65F3F1FEF64FFA68.perks["specialty_focus"], level._id_65F3F1FEF64FFA68.perks["specialty_warhead"], level._id_65F3F1FEF64FFA68.perks["specialty_covert_ops"]];
  level._id_65F3F1FEF64FFA68._id_21832626A15C50DA[2] = [level._id_65F3F1FEF64FFA68.perks["specialty_quick_fix"], level._id_65F3F1FEF64FFA68.perks["specialty_guerrilla"], level._id_65F3F1FEF64FFA68.perks["specialty_tactical_recon"]];
}

_id_53109B63A7168074() {
  _id_5CC93630CC034274 = self getplayerdata(level._id_5D69837CF4DB0407, "currentStreakCount");
  _id_9C5135B341C2386D = self getplayerdata(level._id_5D69837CF4DB0407, "bestStreakCount");

  if(!_id_61F9109D0EB76F19()) {
    self setplayerdata(level._id_5D69837CF4DB0407, "currentStreakGainedProgress", 0);
    self setplayerdata(level._id_5D69837CF4DB0407, "bestStreakGainedProgress", 0);
    return;
  }

  _id_9215D4AEE874A4DB = _id_5CC93630CC034274 + 1;
  self setplayerdata(level._id_5D69837CF4DB0407, "currentStreakGainedProgress", 1);
  self setplayerdata(level._id_5D69837CF4DB0407, "currentStreakCount", _id_9215D4AEE874A4DB);

  if(_id_9215D4AEE874A4DB > _id_9C5135B341C2386D) {
    self setplayerdata(level._id_5D69837CF4DB0407, "bestStreakGainedProgress", 1);
    self setplayerdata(level._id_5D69837CF4DB0407, "bestStreakCount", _id_9215D4AEE874A4DB);
  } else
    self setplayerdata(level._id_5D69837CF4DB0407, "bestStreakGainedProgress", 0);

  _id_203EAC7388D590A9 = int(tablelookupbyrow("mp/dmz_streakrewards.csv", _id_9215D4AEE874A4DB + 1, 1));
  _id_652429904B5EB1C5 = undefined;

  if(isDefined(level._id_65F3F1FEF64FFA68._id_21832626A15C50DA[_id_203EAC7388D590A9])) {
    _id_E59ECCD90C6407DA = [];
    _id_DF9FB2CBD434F334 = undefined;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
      lootid = self getplayerdata(level._id_5D69837CF4DB0407, "DMZExfilPerkStreak", _id_AC0E594AC96AA3A8, "lootID");

      if(lootid != 0) {
        _id_E59ECCD90C6407DA[_id_E59ECCD90C6407DA.size] = lootid;
        continue;
      }

      if(!isDefined(_id_DF9FB2CBD434F334))
        _id_DF9FB2CBD434F334 = _id_AC0E594AC96AA3A8;
    }

    if(isDefined(_id_DF9FB2CBD434F334) && _id_E59ECCD90C6407DA.size < level._id_65F3F1FEF64FFA68.perks.size) {
      perks = scripts\engine\utility::array_randomize(level._id_65F3F1FEF64FFA68._id_21832626A15C50DA[_id_203EAC7388D590A9]);

      foreach(_id_D933A3A8C547998E in perks) {
        if(!scripts\engine\utility::array_contains(_id_E59ECCD90C6407DA, _id_D933A3A8C547998E)) {
          self setplayerdata(level._id_5D69837CF4DB0407, "DMZExfilPerkStreak", _id_DF9FB2CBD434F334, "lootID", _id_D933A3A8C547998E);
          _id_652429904B5EB1C5 = _id_D933A3A8C547998E;
          break;
        }
      }
    }
  }

  if(isDefined(_id_652429904B5EB1C5))
    _id_0B7A9CE0A2282B79::_id_80A3ED28ED1B33A1(self, _id_9215D4AEE874A4DB, _id_652429904B5EB1C5);
}

_id_470B4AAAFD986A0D(player) {
  if(!_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7()) {
    return;
  }
  player setplayerdata(level._id_5D69837CF4DB0407, "currentStreakGainedProgress", 0);
  player setplayerdata(level._id_5D69837CF4DB0407, "bestStreakGainedProgress", 0);
  [_id_153FDEE861E0F06F, perks] = _id_0B7A9CE0A2282B79::_id_1558F8FB859C492A(player);

  if(_id_153FDEE861E0F06F > 0) {
    player setplayerdata(level._id_5D69837CF4DB0407, "currentStreakCount", _id_153FDEE861E0F06F);
    _id_2B8554E15B5C8E77 = 0;

    foreach(_id_D933A3A8C547998E in perks) {
      if(_id_D933A3A8C547998E != 0) {
        player setplayerdata(level._id_5D69837CF4DB0407, "DMZExfilPerkStreak", _id_2B8554E15B5C8E77, "lootID", _id_D933A3A8C547998E);
        _id_2B8554E15B5C8E77++;
      }
    }
  } else
    _id_1A425272955D5F75();
}

_id_0F0E913C037010A9() {
  _id_F42AE929DC77A767 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    lootid = self getplayerdata(level._id_5D69837CF4DB0407, "DMZExfilPerkStreak", _id_AC0E594AC96AA3A8, "lootID");

    if(lootid != 0)
      _id_F42AE929DC77A767[_id_F42AE929DC77A767.size] = lootid;
  }

  if(level._id_F38AEC9B79359AF1) {
    foreach(lootid in _id_F42AE929DC77A767) {
      perk = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
      scripts\mp\utility\perk::giveperk(perk);
    }
  }
}

_id_1EBD7D347B85CAE3() {
  player = self;
  player._id_A6DD5C7E74106CE3 = [];

  if(!getdvarint("dvar_3D25F67E59D61B96", 1)) {
    return;
  }
  foreach(weapon in player.equippedweapons) {
    equipmentref = scripts\mp\equipment::getequipmentreffromweapon(weapon);

    if(!isDefined(equipmentref) || !isDefined(weapon._id_4C23F392C9061568) || !isDefined(weapon.variantid)) {
      continue;
    }
    slot = scripts\mp\equipment::findequipmentslot(equipmentref);
    _id_B971E09CE070BD58 = scripts\mp\equipment::getequipmentslotammo(slot);
    scripts\mp\equipment::takeequipment(slot);
    scripts\mp\equipment::giveequipment(equipmentref, slot, weapon.variantid);
    player._id_A6DD5C7E74106CE3[equipmentref] = weapon.variantid;
  }
}

_id_12B9BC0F30AA8F5D() {
  if(!istrue(level._id_7F3AAFCF56C9CE14) || !isDefined(self._id_04045F099F3DA4BD)) {
    return;
  }
  _id_7E52B56769FA7774::_id_6523C0535FDB1F1F(self, self._id_04045F099F3DA4BD);
}

_id_1A425272955D5F75() {
  if(istrue(self.extracted)) {
    return;
  }
  self setplayerdata(level._id_5D69837CF4DB0407, "currentStreakGainedProgress", 0);
  self setplayerdata(level._id_5D69837CF4DB0407, "currentStreakCount", 0);
  self setplayerdata(level._id_5D69837CF4DB0407, "bestStreakGainedProgress", 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++)
    self setplayerdata(level._id_5D69837CF4DB0407, "DMZExfilPerkStreak", _id_AC0E594AC96AA3A8, "lootID", 0);
}

_id_61F9109D0EB76F19() {
  if(level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker")
    return 1;

  return istrue(self.brmissionscompleted);
}

_id_1BE19E52E991D817(player) {
  player notify("overlord_extraction_streak");
  player endon("overlord_extraction_streak");
  player endon("last_stand_start");
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  wait(getdvarint("dvar_12DB8F9058061D1B", 10));
  _id_ADF1FE22B2CD5BD2(player);
}

_id_ADF1FE22B2CD5BD2(player) {
  if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player)) {
    return;
  }
  if(istrue(player._id_496A6EA8CB39CD1D)) {
    return;
  }
  _id_5CC93630CC034274 = player getplayerdata(level._id_5D69837CF4DB0407, "currentStreakCount");

  if(getdvarint("dvar_1EC9AC9EF82212CC", 0) > 0)
    _id_5CC93630CC034274 = getdvarint("dvar_1EC9AC9EF82212CC", 0);

  if(isDefined(_id_5CC93630CC034274) && _id_5CC93630CC034274 >= getdvarint("dvar_F5FFDC69ACC2ED9E", 2)) {
    _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("streak_reminder", [player]);
    player._id_496A6EA8CB39CD1D = 1;
  }
}

_id_B68A411ADF965E7F() {
  level endon("game_ended");

  if(getdvarint("dvar_EDAA12A361B23765", 0) == 1) {
    return;
  }
  if(!isDefined(self.team)) {
    return;
  }
  if(!isDefined(level._id_538B75512B4726A8))
    level._id_538B75512B4726A8 = [];

  _id_E1B5345B16363C30 = self.team;

  if(istrue(level._id_538B75512B4726A8[_id_E1B5345B16363C30])) {
    return;
  }
  if(!isDefined(level._id_538B75512B4726A8[_id_E1B5345B16363C30]))
    level._id_538B75512B4726A8[_id_E1B5345B16363C30] = 1;

  wait 120;

  for(;;) {
    _id_BCE4EFC75EB01319 = scripts\mp\utility\teams::getteamdata(_id_E1B5345B16363C30, "aliveCount");

    if(!isDefined(_id_BCE4EFC75EB01319) || _id_BCE4EFC75EB01319 <= 0) {
      return;
    }
    players = scripts\mp\utility\teams::getteamdata(_id_E1B5345B16363C30, "players");

    if(!isDefined(players) || players.size <= 1) {
      wait(getdvarint("dvar_69B4EB1D49243C68", 120));
      continue;
    }

    aliveplayers = [];

    foreach(player in players) {
      if(scripts\mp\utility\player::isreallyalive(player))
        aliveplayers[aliveplayers.size] = player;
    }

    if(aliveplayers.size <= 1) {
      wait(getdvarint("dvar_69B4EB1D49243C68", 120));
      continue;
    }

    _id_C4B81997F0120A97 = undefined;

    foreach(player in aliveplayers) {
      if(!isDefined(_id_C4B81997F0120A97)) {
        _id_C4B81997F0120A97 = player;
        continue;
      }

      dist = distance2d(player.origin, _id_C4B81997F0120A97.origin);

      if(dist >= getdvarint("dvar_F49EDD0604D1E232", 7500)) {
        _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5("teammates_far_away_nag", aliveplayers);
        break;
      }
    }

    wait(getdvarint("dvar_69B4EB1D49243C68", 120));
  }
}

_id_5C9E1BD30347CB36(weapon, maxammo) {
  ammotype = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weapon);
  _id_B7E1758E56028B63 = 100;

  if(isDefined(ammotype) && isDefined(level.br_pickups.counts[ammotype]))
    _id_B7E1758E56028B63 = level.br_pickups.counts[ammotype];

  _id_28AEBE3DD6733ED3 = scripts\engine\utility::ter_op(weaponclipsize(weapon) < _id_B7E1758E56028B63 || istrue(maxammo), weaponclipsize(weapon), _id_B7E1758E56028B63);
  _id_961012DD15FA29EE = 0;

  if(weapon.hasalternate) {
    _id_5D9B5B689A1846C8 = weapon getaltweapon();
    _id_961012DD15FA29EE = scripts\engine\utility::ter_op(weaponclipsize(_id_5D9B5B689A1846C8) < _id_B7E1758E56028B63 || istrue(maxammo), weaponclipsize(_id_5D9B5B689A1846C8), _id_B7E1758E56028B63);
  }

  return [_id_28AEBE3DD6733ED3, _id_28AEBE3DD6733ED3, _id_961012DD15FA29EE];
}

_id_AE6091699E25D8B4(_id_1B4ADA49A21B51CA, playerlist, _id_171F90B9C4C76D44, optionalnumber) {
  temp = level._id_CC9E990B6E83975B;
  level._id_CC9E990B6E83975B = 0;

  foreach(player in playerlist) {
    if(isPlayer(player)) {
      player setclientomnvar("ui_dmz_poi_name", _id_5DEF7AF2A9F04234::_id_80CDAEA4BD3ECF70(_id_171F90B9C4C76D44));
      player thread scripts\mp\hud_message::showsplash(_id_1B4ADA49A21B51CA, optionalnumber, undefined, undefined, 1);
    }
  }

  level._id_CC9E990B6E83975B = temp;
}

_id_E1FA80F536692A32() {
  for(;;) {
    dvar = getDvar("dvar_911645DD41A57D5D", "");

    if(isDefined(dvar) && dvar != "") {
      setDvar("dvar_911645DD41A57D5D", "");
      item = spawnscriptable(dvar, level.players[0].origin, level.players[0].angles);

      if(isDefined(item))
        _id_7E52B56769FA7774::registerscriptableinstance(item);
    }

    if(getdvarint("dvar_77012BC5215F715E", 0)) {
      setDvar("dvar_77012BC5215F715E", 0);
      items = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "brloot_black_mous_intel");
      level.players[0] setOrigin(items[0].origin);
    }

    waitframe();
  }
}

_id_B9ABF4FC2D1F7FCD(_id_9156B53BCF7CE573) {}

_id_0181A43D54C23236() {
  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702())
    return 0;

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414())
    return 0;

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    return 0;

  return 1;
}

_id_DBE369AF1ABC2991() {
  level._id_A06B389554958A4A = 1;
}

_id_4E5CA94D32370A5A() {
  return istrue(level._id_A06B389554958A4A);
}

_id_63A938BFC7BA5C2B(nodes) {
  _id_C40817516B7D2B68 = spawnStruct();
  _id_C40817516B7D2B68.points = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4 = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[0] = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[1] = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[2] = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[3] = [];

  if(!_id_4E5CA94D32370A5A())
    _id_4EFC16030B7AC1F9 = scripts\engine\utility::array_randomize(nodes);
  else
    _id_4EFC16030B7AC1F9 = nodes;

  foreach(node in _id_4EFC16030B7AC1F9) {
    if(isDefined(level._id_AB20B3A256911579) && level._id_E5993849FC7D5987 == 0 && (!isDefined(node._id_B205D90302DA2F07) || scripts\engine\utility::array_contains(level._id_AB20B3A256911579, node._id_B205D90302DA2F07)) && _id_5DEF7AF2A9F04234::_id_7E9CBC0F32DE6578()) {
      continue;
    }
    startpoint = spawnStruct();
    startpoint._id_B205D90302DA2F07 = node._id_B205D90302DA2F07;
    startpoint.origin = node.origin;
    startpoint.angles = node.angles;
    startpoint.team = undefined;

    if(isDefined(node.target))
      startpoint.target = node.target;

    if(isDefined(node.script_label))
      startpoint.script_label = node.script_label;

    if(isDefined(node._id_78C002BE5BC09AEA)) {
      startpoint._id_78C002BE5BC09AEA = int(node._id_78C002BE5BC09AEA);
      _id_C40817516B7D2B68.points[startpoint._id_78C002BE5BC09AEA] = startpoint;
      continue;
    }

    _id_C40817516B7D2B68.points[_id_C40817516B7D2B68.points.size] = startpoint;
  }

  level._id_C137999BA28087DF = 0;
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[0] = _id_C40817516B7D2B68.points;
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[1] = _id_C40817516B7D2B68.points;
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[2] = _id_C40817516B7D2B68.points;
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[3] = _id_C40817516B7D2B68.points;
  return _id_C40817516B7D2B68;
}

_id_7EB9B366E7EE262E() {
  if(scripts\cp_mp\utility\game_utility::_id_7EE65FAE13124702())
    return "mp/dmz_spawnpoints.csv";

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414())
    return "mp/dmz_sealion_spawnpoints.csv";

  if(scripts\cp_mp\utility\game_utility::_id_5E0E3A24DBB1FAE1())
    return "mp/dmz_delta_spawnpoints.csv";

  return "mp/dmz_spawnpoints.csv";
}

_id_EFFB4F29BF72A97B(_id_DF08A16A5E6579C3) {
  _id_C40817516B7D2B68 = spawnStruct();
  _id_C40817516B7D2B68.points = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4 = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[0] = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[1] = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[2] = [];
  _id_C40817516B7D2B68._id_F700D2836AAB75A4[3] = [];
  _id_BE2DB88FA84D30D3 = scripts\engine\utility::getStructArray(_id_DF08A16A5E6579C3, "script_noteworthy");
  _id_D159D4C99E9374BD = [];

  foreach(point in _id_BE2DB88FA84D30D3) {
    if(isDefined(point.script_label) && point.script_label != "")
      _id_D159D4C99E9374BD[point.script_label] = point;
  }

  _id_701A116FE9041DC2 = _id_7EB9B366E7EE262E();
  _id_09DD5D9E57E7E36D = tablelookupgetnumrows(_id_701A116FE9041DC2);
  _id_AF29A901B9609348 = 0;

  for(_id_43F004CCE557F835 = 0; _id_43F004CCE557F835 < _id_09DD5D9E57E7E36D; _id_43F004CCE557F835++) {
    _id_B205D90302DA2F07 = tablelookupbyrow(_id_701A116FE9041DC2, _id_43F004CCE557F835, 0);

    if(isDefined(level._id_AB20B3A256911579) && level._id_E5993849FC7D5987 == 0 && (!isDefined(_id_B205D90302DA2F07) || scripts\engine\utility::array_contains(level._id_AB20B3A256911579, _id_B205D90302DA2F07)) && _id_5DEF7AF2A9F04234::_id_7E9CBC0F32DE6578()) {
      continue;
    }
    noteworthy = tablelookupbyrow(_id_701A116FE9041DC2, _id_43F004CCE557F835, 5);

    if(noteworthy != _id_DF08A16A5E6579C3) {
      continue;
    }
    _id_51CE8D39AFD59B34 = tablelookupbyrow(_id_701A116FE9041DC2, _id_43F004CCE557F835, 14);

    if(!isDefined(_id_51CE8D39AFD59B34) || _id_51CE8D39AFD59B34 == "") {
      continue;
    }
    if(!isDefined(_id_D159D4C99E9374BD[_id_51CE8D39AFD59B34])) {
      continue;
    }
    point = _id_D159D4C99E9374BD[_id_51CE8D39AFD59B34];
    startpoint = spawnStruct();
    startpoint._id_B205D90302DA2F07 = scripts\engine\utility::ter_op(isDefined(point._id_B205D90302DA2F07), point._id_B205D90302DA2F07, "");
    startpoint.origin = point.origin;
    startpoint.angles = scripts\engine\utility::ter_op(isDefined(point.angles), point.angles, (0, 0, 0));
    startpoint.team = undefined;

    if(isDefined(point.target))
      startpoint.target = point.target;

    if(isDefined(point.script_label))
      startpoint.script_label = point.script_label;

    _id_C40817516B7D2B68.points[_id_C40817516B7D2B68.points.size] = startpoint;
  }

  level._id_C137999BA28087DF = 0;

  foreach(point in _id_C40817516B7D2B68.points) {
    index = scripts\engine\utility::ter_op(point.origin[0] < 0, -1, 0) + scripts\engine\utility::ter_op(point.origin[1] < 0, 3, 1);

    if(level._id_497DAAC5A6D4041B[index] != 0) {
      continue;
    }
    _id_C40817516B7D2B68._id_F700D2836AAB75A4[index][_id_C40817516B7D2B68._id_F700D2836AAB75A4[index].size] = point;
  }

  _id_3BAFC217F6706130 = _func_0047FD8FCDF90B0E() & 65535;
  _id_2CB677E3452C5EEB = _id_3BAFC217F6706130;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_C40817516B7D2B68._id_F700D2836AAB75A4.size; _id_AC0E594AC96AA3A8++) {
    _id_2CB677E3452C5EEB = (_id_2CB677E3452C5EEB * 29 + 19) % 65535;
    _id_795A46D2F3321B31 = _id_2CB677E3452C5EEB % _id_C40817516B7D2B68._id_F700D2836AAB75A4.size;
    _id_E97B68032A8F5332 = _id_C40817516B7D2B68._id_F700D2836AAB75A4[_id_AC0E594AC96AA3A8];
    _id_C40817516B7D2B68._id_F700D2836AAB75A4[_id_AC0E594AC96AA3A8] = _id_C40817516B7D2B68._id_F700D2836AAB75A4[_id_795A46D2F3321B31];
    _id_C40817516B7D2B68._id_F700D2836AAB75A4[_id_795A46D2F3321B31] = _id_E97B68032A8F5332;
  }

  _id_3BAFC217F6706130 = _func_0047FD8FCDF90B0E() & 65535;
  _id_2CB677E3452C5EEB = _id_3BAFC217F6706130;

  foreach(index, _id_9D308880669C09EA in _id_C40817516B7D2B68._id_F700D2836AAB75A4) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9D308880669C09EA.size; _id_AC0E594AC96AA3A8++) {
      _id_2CB677E3452C5EEB = (_id_2CB677E3452C5EEB * 29 + 19) % 65535;
      _id_795A46D2F3321B31 = _id_2CB677E3452C5EEB % _id_9D308880669C09EA.size;
      _id_E97B68032A8F5332 = _id_9D308880669C09EA[_id_AC0E594AC96AA3A8];
      _id_9D308880669C09EA[_id_AC0E594AC96AA3A8] = _id_9D308880669C09EA[_id_795A46D2F3321B31];
      _id_9D308880669C09EA[_id_795A46D2F3321B31] = _id_E97B68032A8F5332;
    }

    _id_C40817516B7D2B68._id_F700D2836AAB75A4[index] = _id_9D308880669C09EA;
  }

  return _id_C40817516B7D2B68;
}

_id_3114E3023D0EDF66() {
  level.spawnheight = getdvarfloat("dvar_1CDB6B91E9C4A104", 1);
  level._id_497DAAC5A6D4041B = [getdvarint("dvar_3EC0C24FAA920E9D", 0), getdvarint("dvar_3EC0D04FAA922D67", 0), getdvarint("dvar_3EF9C24FAAD08988", 0), getdvarint("dvar_3EF9B44FAAD06ABE", 0)];
  _id_80905631869FB395 = 0;

  foreach(_id_9D308880669C09EA in level._id_497DAAC5A6D4041B) {
    if(_id_9D308880669C09EA == 0)
      _id_80905631869FB395++;
  }

  level._id_68AAA2C8668CC4FB = _id_80905631869FB395;
  level._id_C40817516B7D2B68 = [];

  while(!isDefined(level.struct_class_names))
    waitframe();

  primary = [];

  if(_id_0181A43D54C23236() && !isDefined(level._id_744DFABB8F946331))
    primary = scripts\engine\utility::getStructArray("dmz_squadSpawnPoint_GLOuterEdge1", "script_noteworthy");

  if(primary.size == 0) {
    if(level.mapname == "mp_fortress_tm") {
      startpoint = spawnStruct();
      startpoint.origin = (-599, -1298, 111);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
      startpoint = spawnStruct();
      startpoint.origin = (525, -1298, 111);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
      startpoint = spawnStruct();
      startpoint.origin = (167, -1778, 113);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
    } else if(level.mapname == "mp_ai_firefight") {
      startpoint = spawnStruct();
      startpoint.origin = (1707, 1965, 204);
      startpoint.angles = (0, 180, 0);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
      startpoint = spawnStruct();
      startpoint.origin = (1707, 1965, 204);
      startpoint.angles = (0, 180, 0);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
    } else if(issubstr(level.mapname, "mp_stronghold")) {
      startpoint = spawnStruct();
      startpoint.origin = (0, 0, 60);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
      startpoint = spawnStruct();
      startpoint.origin = (0, 0, 60);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
    } else if(level.mapname == "mp_br_mechanics") {
      startpoint = spawnStruct();
      startpoint.origin = (-2861, 2762, 58);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
      startpoint = spawnStruct();
      startpoint.origin = (-2861, 2762, 58);
      startpoint.team = undefined;
      primary[primary.size] = startpoint;
    } else if(isDefined(level._id_744DFABB8F946331))
      primary = [[level._id_744DFABB8F946331]]();
  }

  if(primary.size == 0 && !_id_0181A43D54C23236())
    level._id_C40817516B7D2B68[0] = _id_EFFB4F29BF72A97B("dmz_squadSpawnPoint_GLOuterEdge1");
  else {
    level._id_C40817516B7D2B68[0] = _id_63A938BFC7BA5C2B(primary);
    level._id_68AAA2C8668CC4FB = 4;
  }

  if(_id_0181A43D54C23236())
    level._id_C40817516B7D2B68[1] = _id_63A938BFC7BA5C2B(scripts\engine\utility::getStructArray("dmz_squadSpawnPoint_GLOuterEdge2", "script_noteworthy"));
  else
    level._id_C40817516B7D2B68[1] = _id_EFFB4F29BF72A97B("dmz_squadSpawnPoint_GLOuterEdge2");

  level._id_41BF3DEA04371564 = [];
}

getspawnpoint() {
  _id_3EDA0EF65C9478AC = 0;

  foreach(index, team in level.allteamnamelist) {
    if(team == self.sessionteam) {
      _id_3EDA0EF65C9478AC = index;
      break;
    }
  }

  if(!isDefined(level._id_C40817516B7D2B68))
    _id_3114E3023D0EDF66();

  _id_CFC2CA5EBFA83DB2 = undefined;

  if(isDefined(level._id_98AE8DC756286ACA))
    _id_CFC2CA5EBFA83DB2 = self[[level._id_98AE8DC756286ACA]](level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4);

  _id_0BAD273951F293D6 = undefined;

  if(!isDefined(_id_CFC2CA5EBFA83DB2))
    _id_0BAD273951F293D6 = int(floor(_id_3EDA0EF65C9478AC / level._id_68AAA2C8668CC4FB));

  _id_F38B865DD10333FE = int(_id_3EDA0EF65C9478AC % level._id_68AAA2C8668CC4FB);

  if(!isDefined(self.team) || !isDefined(level.teamdata) || !isDefined(level.teamdata[self.team])) {
    point = undefined;

    if(isDefined(_id_CFC2CA5EBFA83DB2))
      point = _id_CFC2CA5EBFA83DB2;
    else if(isDefined(level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6]))
      point = level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6];
    else if(isDefined(level._id_C40817516B7D2B68[1]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6 - level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE].size + 1]))
      point = level._id_C40817516B7D2B68[1]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6];

    if(!isDefined(point)) {
      point = spawnStruct();
      point.origin = (0, 0, 0);
    }

    spawnpoint = spawnStruct();
    spawnpoint.origin = point.origin;
    spawnpoint.angles = scripts\engine\utility::ter_op(isDefined(point.angles), point.angles, (0, 0, 0));
    spawnpoint.time = gettime();
    spawnpoint.team = undefined;
    spawnpoint.index = -1;
    spawnpoint.lifeid = self.lifeid;
    return spawnpoint;
  }

  _id_6373489AC2AEFF2B = [];

  if(!isDefined(level.teamdata[self.team]["startPoint"])) {
    _id_50387780D85ADCA4 = level._id_C137999BA28087DF;
    _id_7F6ED4BCF0DB77DB = 0;

    if(isDefined(_id_CFC2CA5EBFA83DB2)) {
      startpoint = _id_CFC2CA5EBFA83DB2;
      level.teamdata[self.team]["startPoint"] = startpoint;
      startpoint.team = self.team;
    } else if(isDefined(level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6]) && !isDefined(level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6].team)) {
      startpoint = level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6];
      level.teamdata[self.team]["startPoint"] = startpoint;
      startpoint.team = self.team;
    } else if(isDefined(level._id_C40817516B7D2B68[1]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6 - level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE].size + 1]) && !isDefined(level._id_C40817516B7D2B68[1]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6 - level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE].size + 1].team)) {
      startpoint = level._id_C40817516B7D2B68[1]._id_F700D2836AAB75A4[_id_F38B865DD10333FE][_id_0BAD273951F293D6 - level._id_C40817516B7D2B68[0]._id_F700D2836AAB75A4[_id_F38B865DD10333FE].size + 1];
      level.teamdata[self.team]["startPoint"] = startpoint;
      startpoint.team = self.team;
    } else {
      while(!isDefined(level.teamdata[self.team]["startPoint"]) && _id_7F6ED4BCF0DB77DB < level._id_C40817516B7D2B68.size) {
        foreach(startpoint in level._id_C40817516B7D2B68[_id_7F6ED4BCF0DB77DB]._id_F700D2836AAB75A4[level._id_C137999BA28087DF]) {
          if(isDefined(startpoint.team)) {
            continue;
          }
          level.teamdata[self.team]["startPoint"] = startpoint;
          startpoint.team = self.team;
          break;
        }

        level._id_C137999BA28087DF++;

        if(level._id_C137999BA28087DF > 3)
          level._id_C137999BA28087DF = 0;

        if(_id_50387780D85ADCA4 == level._id_C137999BA28087DF)
          _id_7F6ED4BCF0DB77DB++;
      }
    }
  }

  spawnorigin = level.teamdata[self.team]["startPoint"].origin;
  spawnangles = level.teamdata[self.team]["startPoint"].angles;
  _id_A17AD319DC0E4B41 = scripts\engine\utility::array_find(level.teamdata[self.team]["players"], self);

  if(isDefined(_id_A17AD319DC0E4B41)) {
    if(isDefined(level._id_FC458DDEC84C95A0)) {
      point = [[level._id_FC458DDEC84C95A0]](level.teamdata[self.team]["startPoint"], _id_A17AD319DC0E4B41);

      if(isDefined(point)) {
        spawnorigin = point.origin;
        spawnangles = point.angles;
      }
    } else
      spawnorigin = spawnorigin + _id_9EC9C03926F7B11C(_id_A17AD319DC0E4B41, level.maxteamsize);
  }

  if(!isDefined(level.teamdata[self.team]["startPoint"].script_label) || level.teamdata[self.team]["startPoint"].script_label != "InteriorSpawnPoint") {
    _id_FBCABD62B8F66EB8 = scripts\engine\trace::create_default_contents(1);
    result = scripts\engine\trace::ray_trace(spawnorigin + (0, 0, 10000), spawnorigin - (0, 0, 20000), undefined, _id_FBCABD62B8F66EB8)["position"];
    spawnorigin = (spawnorigin[0], spawnorigin[1], result[2] + level.spawnheight);
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnorigin;
  spawnpoint.angles = scripts\engine\utility::ter_op(isDefined(spawnangles), spawnangles, (0, 0, 0));
  spawnpoint.time = gettime();
  spawnpoint.team = self.team;
  spawnpoint.index = -1;
  spawnpoint.lifeid = self.lifeid;
  return spawnpoint;
}

_id_9EC9C03926F7B11C(index, _id_165262BFF9D18643) {
  _id_AD3758FD3576AE97 = scripts\engine\utility::ter_op(istrue(level._id_359D1318419A254D), 0, 100.0);
  angle = index / _id_165262BFF9D18643 * 360;
  return (cos(angle) * _id_AD3758FD3576AE97, sin(angle) * _id_AD3758FD3576AE97, 0);
}

_id_BE92590A9B41DEA8(_id_592E60649EA08687) {
  _id_701A116FE9041DC2 = _id_7EB9B366E7EE262E();
  _id_09DD5D9E57E7E36D = tablelookupgetnumrows(_id_701A116FE9041DC2);
  _id_AF29A901B9609348 = 0;

  for(_id_43F004CCE557F835 = 0; _id_43F004CCE557F835 < _id_09DD5D9E57E7E36D; _id_43F004CCE557F835++) {
    id = tablelookupbyrow(_id_701A116FE9041DC2, _id_43F004CCE557F835, 13);

    if(int(id) == _id_592E60649EA08687) {
      _id_AF29A901B9609348 = _id_43F004CCE557F835;
      break;
    }
  }

  _id_B205D90302DA2F07 = tablelookupbyrow(_id_701A116FE9041DC2, _id_AF29A901B9609348, 0);
  _id_22BCD0FB063692B5 = tablelookupbyrow(_id_701A116FE9041DC2, _id_AF29A901B9609348, 1);
  _id_9C8E5DAB0E4FEA3A = tablelookupbyrow(_id_701A116FE9041DC2, _id_AF29A901B9609348, 2);
  _id_7C4E2C6A50914434 = strtok(_id_22BCD0FB063692B5, ", ");
  _id_B91D15A3A3340001 = strtok(_id_9C8E5DAB0E4FEA3A, ", ");
  spawnorigin = (float(_id_7C4E2C6A50914434[0]), float(_id_7C4E2C6A50914434[1]), float(_id_7C4E2C6A50914434[2]));
  spawnangles = (float(_id_B91D15A3A3340001[0]), float(_id_B91D15A3A3340001[1]), float(_id_B91D15A3A3340001[2]));
  _id_3068716C250A5E58 = spawnStruct();
  _id_3068716C250A5E58._id_B205D90302DA2F07 = _id_B205D90302DA2F07;
  _id_3068716C250A5E58.origin = spawnorigin;
  _id_3068716C250A5E58.angles = spawnangles;
  return _id_3068716C250A5E58;
}

isvalidspectatetarget(player) {
  if(!isDefined(player) || !isDefined(player.team) || !isalive(player) || !isDefined(self) || !isDefined(self.team))
    return 0;

  return player.team == self.team;
}

autoassignquest(player) {
  if(!isDefined(level.questinfo.teamsonquests) || scripts\engine\utility::array_contains(level.questinfo.teamsonquests, player.team)) {
    return;
  }
  _id_73A1687C46C4D341 = [];

  foreach(type in level.validautoassignquests)
  _id_73A1687C46C4D341 = scripts\engine\utility::array_combine(_id_73A1687C46C4D341, getlootscriptablearray("brloot_" + type + "_tablet"));

  _id_73A1687C46C4D341 = scripts\engine\utility::array_randomize(_id_73A1687C46C4D341);
  _id_D62CC2E2BFA94D60 = undefined;
  _id_31A0A0ED9E70E900 = undefined;

  foreach(index, _id_670AA0DF96F7DE65 in _id_73A1687C46C4D341) {
    dist = scripts\engine\utility::distance_2d_squared(player.origin, _id_670AA0DF96F7DE65.origin);

    if(dist <= 16777216 && dist >= 16384) {
      player _id_64ACB6CE534155B7::_id_BB413728BC5231D0(_id_670AA0DF96F7DE65);
      return;
    }

    if(!isDefined(_id_D62CC2E2BFA94D60) || dist < _id_31A0A0ED9E70E900) {
      _id_D62CC2E2BFA94D60 = _id_670AA0DF96F7DE65;
      _id_31A0A0ED9E70E900 = dist;
    }
  }

  if(isDefined(_id_D62CC2E2BFA94D60))
    player _id_64ACB6CE534155B7::_id_BB413728BC5231D0(_id_D62CC2E2BFA94D60);
}

_id_11750957AA915A23() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  timer = getdvarint("scr_br_timelimit");
  level thread _id_18F66BBF9AA3C9AF(timer);
}

_id_18F66BBF9AA3C9AF(timer) {
  wait(int(max(timer - (timer - 600), 0)));
  setomnvar("ui_br_circle_state", 5);
  level waittill("start_dmz_extracts");
  setomnvar("ui_br_circle_state", 9);
}

eomawardplayerxp() {
  level waittill("give_match_bonus");
}

_id_F1C3982D13453D32(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470) {
  if(getdvarint("dvar_3D843517229CD382", 1) && isDefined(level._id_CF3FEEAA65A4E3F0)) {
    if(_id_79D4B1C751A51F03::_id_F3354DDC02E867C9(_id_16EFCF27E6EFCBE8))
      return 0;
  }

  return _id_1E4A61DB11011446::briskillstreakallowed(_id_16EFCF27E6EFCBE8, _id_015314DA30B44470);
}

_id_DD432354AF4C9024() {
  level.outofboundstriggers = [];
  _id_CCFDB06748D7F326 = getEntArray("OutOfBounds", "targetname");
  _id_D204F6A98A5BE26F = getdvarint("dvar_A4617FB891CA21CB", 0) == 1;

  if(_id_D204F6A98A5BE26F) {
    foreach(trigger in _id_CCFDB06748D7F326) {
      if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "locale_32") {
        level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
        continue;
      }

      trigger delete();
    }
  } else {
    foreach(trigger in _id_CCFDB06748D7F326) {
      if(!isDefined(trigger.script_noteworthy)) {
        level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
        continue;
      }

      trigger delete();
    }
  }
}

_id_D8431975BBEC1179() {
  waitframe();

  while(!isDefined(level.struct_class_names))
    waitframe();

  _id_48814951E916AF89::_id_2FC80954FA70D153();
  _id_1BC434E0A66F7DB6 = scripts\engine\utility::array_randomize(scripts\engine\utility::getStructArray("heli_loc_protected", "script_noteworthy"));

  if(_id_5DEF7AF2A9F04234::_id_47D356083884F913()) {
    _id_50F783A5617F8940 = [];

    foreach(loc in _id_1BC434E0A66F7DB6) {
      if(!isDefined(loc._id_B205D90302DA2F07))
        loc._id_B205D90302DA2F07 = _id_5DEF7AF2A9F04234::_id_6CC445C02B5EFFAC(loc.origin, 1);

      if(isDefined(loc._id_B205D90302DA2F07) && _id_5DEF7AF2A9F04234::_id_FAA6481E65F14ADE(loc._id_B205D90302DA2F07)) {
        _id_D1CF55B36FACF5A8 = _id_48814951E916AF89::_id_0A44E168E8CCED18(loc.origin, loc._id_B205D90302DA2F07);
        loc._id_71AD22C5D093D90B = _id_D1CF55B36FACF5A8._id_71AD22C5D093D90B;
        _id_50F783A5617F8940[_id_50F783A5617F8940.size] = loc;
      }
    }

    _id_1BC434E0A66F7DB6 = _id_50F783A5617F8940;
  }

  _id_387E5F09EA0603E8 = getdvarint("dvar_673EC70C6EFF1E18", 2);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_387E5F09EA0603E8; _id_AC0E594AC96AA3A8++) {
    spawndata = spawnStruct();

    if(!isDefined(_id_1BC434E0A66F7DB6[_id_AC0E594AC96AA3A8])) {
      continue;
    }
    spawndata.origin = _id_1BC434E0A66F7DB6[_id_AC0E594AC96AA3A8].origin;
    spawndata.angles = _id_1BC434E0A66F7DB6[_id_AC0E594AC96AA3A8].angles;
    _id_46AF76764B1FC7F0::spawnavehicle("little_bird", spawndata);
    _id_DA8B6C7C8AD40CE1 = scripts\engine\utility::getStructArray(_id_1BC434E0A66F7DB6[_id_AC0E594AC96AA3A8].target, "targetname");

    if(!isDefined(_id_DA8B6C7C8AD40CE1)) {
      continue;
    }
    foreach(node in _id_DA8B6C7C8AD40CE1) {
      if(isDefined(node.script_noteworthy)) {
        node._id_B205D90302DA2F07 = _id_1BC434E0A66F7DB6[_id_AC0E594AC96AA3A8]._id_B205D90302DA2F07;
        node._id_71AD22C5D093D90B = _id_1BC434E0A66F7DB6[_id_AC0E594AC96AA3A8]._id_71AD22C5D093D90B;
        script_noteworthy = tolower(node.script_noteworthy);

        if(issubstr(script_noteworthy, "guard"))
          _id_48814951E916AF89::_id_591B22E0CA8A8BE1(node, 1, 1, "medium", "extraGuards");
        else if(script_noteworthy == "patrolstart" || issubstr(script_noteworthy, "patrolpath")) {
          pathstruct = _id_48814951E916AF89::_id_09EDCF99159ABB0B(node, issubstr(script_noteworthy, "looped"));
          _id_48814951E916AF89::_id_3DCF83BCEF7081BA(pathstruct, 1, 2, undefined, "high", "extraPatrols");
        }
      }
    }
  }
}

_id_3403C13CEC1CEA46() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("lasertrap", "createLootDropInfo", ::_id_624810233C1B8082);
  scripts\cp_mp\utility\script_utility::registersharedfunc("lasertrap", "spawnPickup", _id_7E52B56769FA7774::spawnpickup);

  while(!isDefined(level._id_F1073FBD45B59A06) || !istrue(level._id_F1073FBD45B59A06._id_9B87FDB80920F442))
    waitframe();

  if(isDefined(level._id_F1BFF73A86C35C52))
    [[level._id_F1BFF73A86C35C52]]();

  if(isDefined(level._id_B08CAEEDD32CFDAF) && isDefined(level._id_B08CAEEDD32CFDAF._id_325F9F15252B4928))
    level thread[[level._id_B08CAEEDD32CFDAF._id_325F9F15252B4928]]();

  if(isDefined(level._id_D49FE7F07F2BA493) && isDefined(level._id_D49FE7F07F2BA493._id_325F9F15252B4928))
    level thread[[level._id_D49FE7F07F2BA493._id_325F9F15252B4928]]();

  if(scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    level thread _id_15CBA36F180AB171::_id_7142C6E9236C9683();
    level thread _id_1FA444CDC9DBF364::_id_F04C619138BAAFD8();
  }
}

_id_624810233C1B8082(baseorigin, baseangles, _id_447F40C814B97CDC, _id_8A600B6102DA9F9B, _id_F71D4F78D508DA69, _id_6FE2FF802D5192D4, _id_3ACE5AC9C7D6FA44) {
  dropstruct = _id_7E52B56769FA7774::_id_7B9F3966A7A42003();
  return _id_7E52B56769FA7774::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, _id_447F40C814B97CDC, _id_8A600B6102DA9F9B, _id_F71D4F78D508DA69, _id_6FE2FF802D5192D4, _id_3ACE5AC9C7D6FA44);
}

_id_9DF0EE7FCB9589D4(player, slot, _id_C0FCE415CDB283C2) {
  _id_0B7A9CE0A2282B79::_id_351FE4AC57CA37E5(player, slot);
  _id_2D9D24F7C63AC143::_id_8237B4EEAB275F08(player, slot, _id_C0FCE415CDB283C2);

  if(isDefined(_id_C0FCE415CDB283C2) && _id_C0FCE415CDB283C2 == "equip_throwing_knife")
    player scripts\mp\equipment\throwing_knife_mp::throwing_knife_mp_ontake();
}

_id_5E77414CC166E514() {
  _id_1642F84B31FAA340 = _id_5DEF7AF2A9F04234::_id_47D356083884F913();

  if(_id_1642F84B31FAA340)
    _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("tripwires");

  tripwires = scripts\engine\utility::array_randomize(getentitylessscriptablearray("scriptable_dmz_tripwire", "classname"));
  _id_7C17C2FA4ED014B4 = [];

  foreach(_id_801C53C0ED06495B in tripwires) {
    if(istrue(_id_801C53C0ED06495B._id_AAD14F891FB70D86)) {
      continue;
    }
    if(!isDefined(_id_801C53C0ED06495B.target)) {
      continue;
    }
    _id_3A6B42AB825A103E = _id_801C53C0ED06495B.origin + anglesToForward(_id_801C53C0ED06495B.angles) * 45;
    _id_276AC5E84835EA87 = _id_4948CDF739393D2D::_id_C0A211A69F5F8F2F(_id_3A6B42AB825A103E);

    if(isDefined(_id_276AC5E84835EA87)) {
      if(_id_1642F84B31FAA340)
        _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_276AC5E84835EA87._id_B205D90302DA2F07, "tripwires", _id_801C53C0ED06495B);

      if(!isDefined(_id_276AC5E84835EA87.tripwires))
        _id_276AC5E84835EA87.tripwires = [];

      _id_276AC5E84835EA87.tripwires[_id_276AC5E84835EA87.tripwires.size] = _id_801C53C0ED06495B;
      continue;
    }

    _id_7C17C2FA4ED014B4[_id_7C17C2FA4ED014B4.size] = _id_801C53C0ED06495B;
  }

  _id_BB07898EC09C0F96 = getdvarint("dvar_B458C6EFFE039ABD", 15);
  _id_7C17C2FA4ED014B4 = scripts\engine\utility::array_randomize(_id_7C17C2FA4ED014B4);

  foreach(index, _id_801C53C0ED06495B in _id_7C17C2FA4ED014B4) {
    if(index < _id_BB07898EC09C0F96) {
      if(isDefined(level._id_E9A6FC11B0AA7EB2))
        [[level._id_E9A6FC11B0AA7EB2]](_id_801C53C0ED06495B);

      continue;
    }

    if(isDefined(level._id_D9D80893720B39DF))
      [[level._id_D9D80893720B39DF]](_id_801C53C0ED06495B);
  }
}

_id_F3A2435F8E39438B() {
  _id_32CA6D3E9BC8E099 = getdvarint("dvar_F8CE5D52364013CE", 5);

  if(_id_32CA6D3E9BC8E099 <= 0) {
    return;
  }
  scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
  wait(getdvarint("dvar_4EF15172B2450728", 240));

  foreach(player in level.players) {
    if(!isDefined(player.team)) {
      continue;
    }
    if(isDefined(player.brmissionscompleted) && player.brmissionscompleted > 0) {
      continue;
    }
    if(_id_03314ADD7998AB13::_id_5EA5A722C499078F(player.team)) {
      continue;
    }
    _id_2CEF9B44F8516A81 = player getplayerdata(level._id_5D69837CF4DB0407, "playerStats", "modeStats", "br_dmz", "gamesPlayed");

    if(level.mapname != "mp_bio_lab" && isDefined(_id_2CEF9B44F8516A81) && _id_2CEF9B44F8516A81 < _id_32CA6D3E9BC8E099)
      _id_1F97A44D1761C919::_id_D87D5DEB069BF8E5(scripts\engine\utility::random(["mission_reminder_1", "mission_reminder_2"]), [player]);
  }
}

playerskiplootpickup(instance, _id_B2635DB617B09ABD) {
  if((istrue(self._id_859654E0445A36D9) || istrue(self._id_6B9CAB81D9F94C6D)) && isDefined(instance) && isDefined(instance.type) && instance.type != "dmz_hostage") {
    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = instance.type;
    _id_60227BFF1E9478CC.weapon = instance.weapon;

    if(!_id_7E52B56769FA7774::isweaponpickupitem(_id_60227BFF1E9478CC))
      return 0;

    if(!istrue(_id_B2635DB617B09ABD))
      scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);

    return 1;
  }

  if(!istrue(_id_B2635DB617B09ABD) && istrue(self._id_35DADE814E13D3CE)) {
    scripts\mp\hud_message::showerrormessage(level.br_pickups._id_355CDDB773CB000D);
    return 1;
  }

  return 0;
}

_id_0865B1A5A62C49D7(_id_74753A0C1C255400) {
  if(!isDefined(self) || isDefined(self.disconnecting)) {
    return;
  }
  if(istrue(self._id_3716375613CA89FD)) {
    return;
  }
  _id_B23DDA83A49CD36E = undefined;

  if(_id_6A8EC730B2BFA844::_id_CFF2F4F168B29B81())
    _id_B23DDA83A49CD36E = scripts\mp\utility\teams::getteamdata(self.team, "poisVisited");

  if(isDefined(_id_B23DDA83A49CD36E))
    _id_B23DDA83A49CD36E = _id_B23DDA83A49CD36E.size;
  else
    _id_B23DDA83A49CD36E = 0;

  _id_70C0ACBE330BD8A6 = scripts\engine\utility::_id_53C4C53197386572(self.pers["explorationXP"], 0);
  _id_D961222798F5D01A = scripts\engine\utility::_id_53C4C53197386572(self._id_79C8F592B7C3C2D6, 0);
  _id_737B512E4921C915 = scripts\engine\utility::_id_53C4C53197386572(self.pers["lootingXP"], 0);
  _id_56A4E98C643A1E2D = scripts\engine\utility::_id_53C4C53197386572(self._id_56A4E98C643A1E2D, 0);
  _id_54658E63E8FB96B5 = scripts\engine\utility::_id_53C4C53197386572(self.pers["missionXP"], 0);
  _id_B3A234477420DCCD = scripts\engine\utility::_id_53C4C53197386572(self.brmissionscompleted, 0);
  _id_595AF2CB6F43AE9F = scripts\engine\utility::_id_53C4C53197386572(self.pers["contractXP"], 0);
  _id_8AE6C90597DAA60A = scripts\engine\utility::_id_53C4C53197386572(self._id_8AE6C90597DAA60A, 0);
  _id_EC9A1B9484844FBE = scripts\engine\utility::_id_53C4C53197386572(self._id_EC9A1B9484844FBE, 0);
  _id_FD5C87130F304833 = scripts\engine\utility::_id_53C4C53197386572(self._id_FD5C87130F304833, 0);
  _id_C26450F6E6E47B84 = scripts\engine\utility::_id_53C4C53197386572(self._id_C26450F6E6E47B84, 0);
  _id_D3DE339E58150E00 = scripts\engine\utility::_id_53C4C53197386572(self.pers["uavTowerXP"], 0);
  _id_35B94C88CC1CEA97 = scripts\engine\utility::_id_53C4C53197386572(self._id_35B94C88CC1CEA97, 0);
  _id_309975E7D2B80275 = scripts\engine\utility::_id_53C4C53197386572(self.pers["safeOpenedXP"], 0);
  _id_BD3FCBFDEDA97E97 = scripts\engine\utility::_id_53C4C53197386572(self._id_BD3FCBFDEDA97E97, 0);
  _id_3C8F44C3384940A5 = scripts\engine\utility::_id_53C4C53197386572(self.pers["areaUnlockedXP"], 0);
  _id_320A8BA98AE41575 = scripts\engine\utility::_id_53C4C53197386572(self._id_320A8BA98AE41575, 0);
  _id_37ADC1D23C54ED05 = scripts\engine\utility::_id_53C4C53197386572(self.pers["supplyDropsOpenedXP"], 0);
  _id_03AE8206B7E8CC06 = scripts\engine\utility::_id_53C4C53197386572(scripts\mp\rank::getscoreinfovalue("stat_EF9582D72160F199"), 0);
  _id_A8469FC3ED757F0D = scripts\engine\utility::_id_53C4C53197386572(getdvarint("dvar_DEFD7006EFDE9127", 100), 0);
  _id_EB583C04711378A8 = scripts\engine\utility::_id_53C4C53197386572(getdvarint("dvar_DFCAD66B7BA8DA13", 500), 0);
  _id_2B00EAA34070C8F7 = scripts\engine\utility::_id_53C4C53197386572(self._id_2B00EAA34070C8F7, 0);
  _id_9AE2028BC0B28AB2 = _id_03AE8206B7E8CC06 * _id_2B00EAA34070C8F7;
  _id_32EA0136E9AFCD9A = scripts\engine\utility::_id_53C4C53197386572(self.kills, 0);
  _id_F761F69E71210F99 = _id_A8469FC3ED757F0D * _id_32EA0136E9AFCD9A;
  _id_8C8050D7D861D06C = scripts\engine\utility::_id_53C4C53197386572(self._id_8C8050D7D861D06C, 0);
  _id_6AA094BD7B024408 = scripts\engine\utility::_id_53C4C53197386572(self._id_6AA094BD7B024408, _id_EB583C04711378A8 * _id_8C8050D7D861D06C);
  _id_22F7D9F7E360615D = scripts\engine\utility::_id_53C4C53197386572(self.pers["revives"], 0);
  _id_474587290CC15554 = scripts\engine\utility::_id_53C4C53197386572(self.pers["reviveXP"], 0);
  _id_6DAE31F85F556E55 = scripts\engine\utility::_id_53C4C53197386572(self.pers["combatXP"], 0);
  _id_CD58B8FFBEB66495 = _id_6DAE31F85F556E55 - _id_474587290CC15554 - _id_6AA094BD7B024408 - _id_F761F69E71210F99 - _id_9AE2028BC0B28AB2;
  _id_076EDD1CD894E14C = 0;

  if(istrue(self.extracted) || istrue(_id_74753A0C1C255400)) {
    _id_33E0291812D90FC1 = scripts\mp\rank::_id_D06C3CBB904AE29B("stat_A664E407EB3E39D4");

    if(_id_2391409EF7B431E1::_id_C07675F2CE32FCB5(self))
      _id_33E0291812D90FC1 = _id_33E0291812D90FC1 + getdvarint("dvar_2B3CB1F1B979A35B", 500);

    _id_076EDD1CD894E14C = scripts\engine\utility::_id_53C4C53197386572(_id_33E0291812D90FC1, 0);
  }

  _id_E7FAF08F327B0FB5 = scripts\engine\utility::_id_53C4C53197386572(self._id_E7FAF08F327B0FB5, 0);

  if(istrue(level._id_FE38A7ECE3409052)) {
    _id_B23DDA83A49CD36E = _id_B23DDA83A49CD36E + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 0);
    _id_70C0ACBE330BD8A6 = _id_70C0ACBE330BD8A6 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 1);
    _id_D961222798F5D01A = _id_D961222798F5D01A + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 2);
    _id_737B512E4921C915 = _id_737B512E4921C915 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 3);
    _id_56A4E98C643A1E2D = _id_56A4E98C643A1E2D + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 4);
    _id_54658E63E8FB96B5 = _id_54658E63E8FB96B5 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 5);
    _id_B3A234477420DCCD = _id_B3A234477420DCCD + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 6);
    _id_595AF2CB6F43AE9F = _id_595AF2CB6F43AE9F + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 7);
    _id_8AE6C90597DAA60A = _id_8AE6C90597DAA60A + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 8);
    _id_EC9A1B9484844FBE = _id_EC9A1B9484844FBE + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 9);
    _id_C26450F6E6E47B84 = _id_C26450F6E6E47B84 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 10);
    _id_D3DE339E58150E00 = _id_D3DE339E58150E00 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 11);
    _id_35B94C88CC1CEA97 = _id_35B94C88CC1CEA97 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 12);
    _id_309975E7D2B80275 = _id_309975E7D2B80275 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 13);
    _id_BD3FCBFDEDA97E97 = _id_BD3FCBFDEDA97E97 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 14);
    _id_3C8F44C3384940A5 = _id_3C8F44C3384940A5 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 15);
    _id_320A8BA98AE41575 = _id_320A8BA98AE41575 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 16);
    _id_37ADC1D23C54ED05 = _id_37ADC1D23C54ED05 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 17);
    _id_2B00EAA34070C8F7 = _id_2B00EAA34070C8F7 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 18);
    _id_9AE2028BC0B28AB2 = _id_9AE2028BC0B28AB2 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 19);
    _id_32EA0136E9AFCD9A = _id_32EA0136E9AFCD9A + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 20);
    _id_F761F69E71210F99 = _id_F761F69E71210F99 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 21);
    _id_8C8050D7D861D06C = _id_8C8050D7D861D06C + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 22);
    _id_6AA094BD7B024408 = _id_6AA094BD7B024408 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 23);
    _id_22F7D9F7E360615D = _id_22F7D9F7E360615D + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 24);
    _id_474587290CC15554 = _id_474587290CC15554 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 25);
    _id_CD58B8FFBEB66495 = _id_CD58B8FFBEB66495 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 26);
    _id_076EDD1CD894E14C = _id_076EDD1CD894E14C + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 27);
    _id_E7FAF08F327B0FB5 = _id_E7FAF08F327B0FB5 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 28);
    _id_FD5C87130F304833 = _id_FD5C87130F304833 + self getplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 29);
  }

  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 0, _id_B23DDA83A49CD36E);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 1, _id_70C0ACBE330BD8A6);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 2, _id_D961222798F5D01A);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 3, _id_737B512E4921C915);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 4, _id_56A4E98C643A1E2D);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 5, _id_54658E63E8FB96B5);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 6, _id_B3A234477420DCCD);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 7, _id_595AF2CB6F43AE9F);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 8, _id_8AE6C90597DAA60A);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 9, _id_EC9A1B9484844FBE);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 10, _id_C26450F6E6E47B84);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 11, _id_D3DE339E58150E00);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 12, _id_35B94C88CC1CEA97);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 13, _id_309975E7D2B80275);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 14, _id_BD3FCBFDEDA97E97);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 15, _id_3C8F44C3384940A5);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 16, _id_320A8BA98AE41575);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 17, _id_37ADC1D23C54ED05);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 18, _id_2B00EAA34070C8F7);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 19, _id_9AE2028BC0B28AB2);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 20, _id_32EA0136E9AFCD9A);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 21, _id_F761F69E71210F99);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 22, _id_8C8050D7D861D06C);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 23, _id_6AA094BD7B024408);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 24, _id_22F7D9F7E360615D);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 25, _id_474587290CC15554);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 26, _id_CD58B8FFBEB66495);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 27, _id_076EDD1CD894E14C);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 28, _id_E7FAF08F327B0FB5);
  self setplayerdata(level._id_5D69837CF4DB0407, "DMZaarValue", 29, _id_FD5C87130F304833);
  self._id_3716375613CA89FD = 1;
}

onstartgametype() {
  if(_id_0B7A9CE0A2282B79::_id_E0FC1230452CF4E7())
    _id_0B7A9CE0A2282B79::initteamdatafields();

  level.br_plunder.plunderlimit = getdvarint("dvar_81ED5B282707434C", 25000);
}

_id_A7F9424636F37FB1() {
  return level.mapname != "mp_saba" && level.mapname != "mp_saba2" && level.mapname != "mp_saba_pm";
}

_id_BFD9F11E955ACE89(player) {
  if(!isDefined(player))
    return 0;

  if(!isDefined(level._id_FE2E551DA0962C3C) || level._id_FE2E551DA0962C3C.size == 0)
    return 0;

  dist = getdvarint("dvar_57797986A6D60476", 4096);
  distsq = dist * dist;

  foreach(exfil in level._id_FE2E551DA0962C3C) {
    if(distancesquared(exfil.origin, player.origin) < distsq)
      return 1;
  }

  return 0;
}

_id_80BF519FB6395CE2() {
  scripts\engine\utility::flag_wait("create_script_initialized");
  _id_FB1DEF007972B25A = scripts\engine\utility::getStruct("special_unlock_buy_station", "script_noteworthy");

  if(isDefined(_id_FB1DEF007972B25A)) {
    scripts\mp\flags::_id_1240434F4201AC9D("prematch_done");
    waitframe();

    if(istrue(level._id_C153EAC6E7C0E1A2)) {
      scripts\engine\scriptable::scriptable_addusedcallbackbypart("drone_deployable_kiosk_dmz", ::_id_6CB6FD3AC869E6E3);
      level._id_0FF7432B1F934BA5 = spawn("script_model", _id_FB1DEF007972B25A.origin);
      level._id_0FF7432B1F934BA5.angles = _id_FB1DEF007972B25A.angles;
      level._id_0FF7432B1F934BA5 setModel("military_deployable_buystation_dmz");
      level._id_0FF7432B1F934BA5.scriptable = level._id_0FF7432B1F934BA5 getlinkedscriptableinstance();
      level._id_0FF7432B1F934BA5.scriptable._id_7940DCDE72827AF7 = 159;
      level._id_0FF7432B1F934BA5.scriptable._id_DED92CCB217BBAEB = 95;
      _id_342E51952B63E594::_id_45EEFC63956143ED(level._id_0FF7432B1F934BA5.scriptable, "barter_recipe_list_iw9_obs");
      level._id_0FF7432B1F934BA5._id_98AABCA05601AA67 = 1;
    }
  }
}

_id_6CB6FD3AC869E6E3(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(_id_1174ABEDBEFE9ADA::_id_076EF3C8B8171D2D(instance.origin))
    _id_57CE8F0135B8B312::_id_208501A7029AB500(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61);
  else {
    player playlocalsound("br_plunder_atm_cancel");
    player scripts\mp\hud_message::showerrormessage("MP_BR_INGAME/UNUSABLE_OBS_KIOSK");
  }
}

_id_B71560B07A8F979D(_id_D52EAE4D954F9A1B) {
  if(getdvarint("dvar_2FDA550AD7EC197F", 1) == 0) {
    return;
  }
  _id_CBBC69E627EC4AE0 = _func_91A28C56C45A736F();
  level._id_34858BA8086735C6 = [];

  foreach(_id_5E803928BC35A4D6 in _id_CBBC69E627EC4AE0) {
    _id_5933C7F534C269C0 = _func_AAE8B5DC22C12D2C(_id_5E803928BC35A4D6);

    if(issubstr(_id_5933C7F534C269C0, _id_D52EAE4D954F9A1B))
      level._id_34858BA8086735C6[level._id_34858BA8086735C6.size] = _id_5933C7F534C269C0;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dmzWar", "poiNameFixer"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("dmzWar", "poiNameFixer")]]();

  _id_50F783A5617F8940 = [];

  foreach(_id_171F90B9C4C76D44 in level._id_34858BA8086735C6) {
    if(scripts\engine\utility::array_contains(level._id_DBB3DD5AB77CCD48, _id_171F90B9C4C76D44))
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = _id_171F90B9C4C76D44;
  }

  level._id_34858BA8086735C6 = _id_50F783A5617F8940;
  level._id_34858BA8086735C6 = scripts\engine\utility::array_remove_duplicates(level._id_34858BA8086735C6);
  level._id_E3E83F2C87707AF3 = [];

  if(issubstr(level.mapname, "saba")) {
    level._id_0C129FA020D92B91[0] = "aq";
    level._id_0C129FA020D92B91[1] = "ru";
  } else if(issubstr(level.mapname, "sealion")) {
    level._id_0C129FA020D92B91[0] = "merc";
    level._id_0C129FA020D92B91[1] = "ru";
  } else if(issubstr(level.mapname, "delta")) {
    level._id_0C129FA020D92B91[0] = "merc";
    level._id_0C129FA020D92B91[1] = "ru";
  }
}

_id_7A7AA3B5455F0412(_id_171F90B9C4C76D44) {
  if(!isDefined(level._id_34858BA8086735C6))
    return 0;

  return scripts\engine\utility::array_contains(level._id_34858BA8086735C6, _id_171F90B9C4C76D44);
}

_id_A1E18F290954A5E9() {
  if(!isDefined(level._id_34858BA8086735C6)) {
    return;
  }
  _id_3E8D58A34EB71817();
  _id_676D1E19647F363B();

  foreach(_id_171F90B9C4C76D44 in level._id_34858BA8086735C6) {
    _id_32EEB14C9C5932AB(_id_171F90B9C4C76D44);
    level thread _id_75512AFD0C09AD03(_id_171F90B9C4C76D44);
  }
}

_id_3E8D58A34EB71817() {
  _id_3E73140B5586C6BA = scripts\engine\utility::getStructArray("dmzWar_fireLoc", "script_noteworthy");
  _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("warFireLocs");
  level._id_D12E916057CF5F18 = getdvarint("dvar_AA44E542C9B99FE9", 3);

  foreach(_id_6C48E2C4741A282D in _id_3E73140B5586C6BA) {
    if(isDefined(_id_6C48E2C4741A282D._id_B205D90302DA2F07) && _id_7A7AA3B5455F0412(_id_6C48E2C4741A282D._id_B205D90302DA2F07))
      _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_6C48E2C4741A282D._id_B205D90302DA2F07, "warFireLocs", _id_6C48E2C4741A282D);
  }
}

_id_32EEB14C9C5932AB(_id_171F90B9C4C76D44) {
  _id_3E73140B5586C6BA = _id_5DEF7AF2A9F04234::_id_1AF8A41E4C1252C7(_id_171F90B9C4C76D44, "warFireLocs");

  if(_id_3E73140B5586C6BA.size == 0) {
    loc = spawnStruct();
    loc.origin = level._id_ACF99124377543BB[_id_171F90B9C4C76D44];
    loc.angles = (0, 0, 0);
    _id_3E73140B5586C6BA[_id_3E73140B5586C6BA.size] = loc;
  }

  if(!isDefined(level._id_CBE618F35B332990))
    level._id_CBE618F35B332990 = spawn("script_origin", (0, 0, 0));

  _id_3E73140B5586C6BA = scripts\engine\utility::array_randomize(_id_3E73140B5586C6BA);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D12E916057CF5F18; _id_AC0E594AC96AA3A8++) {
    _id_6C48E2C4741A282D = _id_3E73140B5586C6BA[_id_AC0E594AC96AA3A8];

    if(!isDefined(_id_6C48E2C4741A282D)) {
      break;
    }

    if(!isDefined(_id_6C48E2C4741A282D.script_parameters)) {
      continue;
    }
    _id_67F14F8315CB0F2F = strtok(_id_6C48E2C4741A282D.script_parameters, " ");
    _id_1D01475F82A8218E = scripts\engine\utility::random(_id_67F14F8315CB0F2F);

    if(!isDefined(_id_1D01475F82A8218E)) {
      break;
    }

    if(_id_1D01475F82A8218E == "largefire")
      _id_1D01475F82A8218E = "fire_plume";
    else if(_id_1D01475F82A8218E == "medfire")
      _id_1D01475F82A8218E = "fire_plume_02";
    else if(_id_1D01475F82A8218E == "smoke")
      _id_1D01475F82A8218E = "fire_plume_03";

    _id_74484087F576EF7B = spawn("script_model", _id_6C48E2C4741A282D.origin);
    _id_74484087F576EF7B setModel(_id_1D01475F82A8218E);
    _id_74484087F576EF7B forcenetfieldhighlod(1);

    if(_id_1D01475F82A8218E != "fire_plume_03")
      level thread _id_7D89B4A3C059DAD5(_id_74484087F576EF7B, 100);
  }
}

_id_7D89B4A3C059DAD5(object, radius) {
  level endon("game_ended");
  navobstacle = createnavobstaclebybounds(object.origin, (radius, radius, radius), object.angles);

  for(;;) {
    level._id_CBE618F35B332990 radiusdamage(object.origin, radius, 5, 5, level._id_CBE618F35B332990, "MOD_FIRE", "molotov_mp", 0, 0);
    wait 1.0;
  }
}

_id_676D1E19647F363B() {
  _id_FE168757BBB623C4 = scripts\engine\utility::getStructArray("killstreakLoc", "script_noteworthy");
  _id_5DEF7AF2A9F04234::_id_44739FE1CF82E29A("killstreakLocs");
  level._id_0B97A5A45A2DBA6C = getdvarint("dvar_F181834D0FDDD688", 45);
  level._id_D5C63047751CF4FA = getdvarint("dvar_D9C60A3D6D9109F2", 10);
  level._id_D1F13AADF10414CC = [];
  level._id_5D440F3B81A8AFBF = [];
  level._id_5D440F3B81A8AFBF["precision"] = _id_48814951E916AF89::_id_46C2D826EBB9E2CC;
  level._id_5D440F3B81A8AFBF["mortar"] = _id_48814951E916AF89::_id_4A618B49270CFD25;

  if(getdvarint("dvar_A003311E2A2CE147", 1) == 1)
    level._id_D1F13AADF10414CC[level._id_D1F13AADF10414CC.size] = "precision";

  if(getdvarint("dvar_C79B251CA40D012C", 1) == 1)
    level._id_D1F13AADF10414CC[level._id_D1F13AADF10414CC.size] = "mortar";

  foreach(_id_57F50A2A718E315F in _id_FE168757BBB623C4) {
    if(isDefined(_id_57F50A2A718E315F._id_B205D90302DA2F07) && _id_7A7AA3B5455F0412(_id_57F50A2A718E315F._id_B205D90302DA2F07)) {
      _id_67F14F8315CB0F2F = strtok(_id_57F50A2A718E315F.script_parameters, " ");
      _id_57F50A2A718E315F._id_A6850967C471D767 = [];

      foreach(_id_E921CD2D3FB29B66 in _id_67F14F8315CB0F2F) {
        if(scripts\engine\utility::array_contains(level._id_D1F13AADF10414CC, _id_E921CD2D3FB29B66))
          _id_57F50A2A718E315F._id_A6850967C471D767[_id_57F50A2A718E315F._id_A6850967C471D767.size] = _id_E921CD2D3FB29B66;
      }

      _id_5DEF7AF2A9F04234::_id_D0E7647E5538EB9D(_id_57F50A2A718E315F._id_B205D90302DA2F07, "killstreakLocs", _id_57F50A2A718E315F);
    }
  }
}

_id_75512AFD0C09AD03(_id_171F90B9C4C76D44) {
  level endon("game_ended");
  _id_FE168757BBB623C4 = _id_5DEF7AF2A9F04234::_id_1AF8A41E4C1252C7(_id_171F90B9C4C76D44, "killstreakLocs");

  for(;;) {
    wait(level._id_0B97A5A45A2DBA6C + randomintrange(level._id_D5C63047751CF4FA * -1, level._id_D5C63047751CF4FA + 1));
    _id_1C4F6D991C751924 = scripts\engine\utility::array_randomize(_func_7E3F22E620F3F71E(_id_171F90B9C4C76D44, "everybody"));

    foreach(agent in _id_1C4F6D991C751924) {
      if(isDefined(agent) && isagent(agent) && isalive(agent)) {
        _id_57F50A2A718E315F = scripts\engine\utility::random(_id_FE168757BBB623C4);

        if(!isDefined(agent) || !isDefined(_id_57F50A2A718E315F)) {
          break;
        }

        _id_2A011A206CDE6940 = scripts\engine\utility::random(_id_57F50A2A718E315F._id_A6850967C471D767);
        _id_2884ADC8D320F897 = _id_48814951E916AF89::_id_AF3034A7C69D7EDB(agent.team);

        if(!isDefined(_id_2884ADC8D320F897)) {
          continue;
        }
        [[level._id_5D440F3B81A8AFBF[_id_2A011A206CDE6940]]](_id_2884ADC8D320F897, _id_57F50A2A718E315F.origin, _id_57F50A2A718E315F.radius);
        break;
      }
    }
  }
}

_id_39ACEB03C0AACE46(player, meansofdeath) {
  if(!isDefined(level._id_A3DE977788317EF5))
    level._id_A3DE977788317EF5 = getdvarint("dvar_EC07295B05C0FE7B", 10);

  if(!isDefined(player._id_C669906A542B9BAF)) {
    return;
  }
  foreach(_id_8E5A9B658FA525ED, _id_CB2F0F5908924BC1 in player._id_C669906A542B9BAF) {
    _id_24316E3669FB6DDA = _id_371B4C2AB5861E62::_id_1BCA33010B895B0B(_id_8E5A9B658FA525ED);

    if(_id_CB2F0F5908924BC1 >= level._id_A3DE977788317EF5 || isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION") {
      _id_371B4C2AB5861E62::_id_AB491B16F8423C8E(player, _id_24316E3669FB6DDA, 0);
      group = _id_371B4C2AB5861E62::_id_ED5140C225D4F337(player);
      _id_371B4C2AB5861E62::_id_CA2ADCE5C7865C20(player, group);
      player thread scripts\mp\hud_message::showsplash("dmz_friendly_faction_turned_sc", undefined, undefined, undefined, undefined, undefined, 1);
      continue;
    }

    if(_id_CB2F0F5908924BC1 == int(level._id_A3DE977788317EF5 / 3) && _id_371B4C2AB5861E62::_id_46C0DE7595D8CAB2(player, _id_24316E3669FB6DDA))
      player thread scripts\mp\hud_message::showsplash("dmz_friendly_faction_warning_sc", undefined, undefined, undefined, undefined, undefined, 1);
  }
}