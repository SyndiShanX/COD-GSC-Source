/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_gametype_dmz.gsc
*******************************************************/

#using script_1174abedbefe9ada;
#using script_1193c0b83fce13b;
#using script_15ca41a3fbb0e379;
#using script_15cba36f180ab171;
#using script_1c47017ba325709a;
#using script_1fa444cdc9dbf364;
#using script_241ff3c86d02a28d;
#using script_28bee6f49336b0a8;
#using script_2b736eb3fdd9b328;
#using script_2d9d24f7c63ac143;
#using script_2e2e13d44d465832;
#using script_34874c98ab154f37;
#using script_3665d737b10b78d9;
#using script_3aacf02225ca0da5;
#using script_3e32e216ce730ac2;
#using script_419eebc6f24e287;
#using script_46b3c7d0a4338d8;
#using script_4948cdf739393d2d;
#using script_495022338d50407e;
#using script_5307834cd39b435c;
#using script_530f3ea26428deba;
#using script_58fe895fd0fbe620;
#using script_590d4c1aaf3a5235;
#using script_5bab271917698dc4;
#using script_5c55c87b89467a29;
#using script_6153e980b3eb0e1b;
#using script_640cf1641c03e2a0;
#using script_64acb6ce534155b7;
#using script_67015c88c47ec4f8;
#using script_697b7ae06ba9b28c;
#using script_6b7618d5ead05b66;
#using script_6d337a1fd1d54c5f;
#using script_6fc415ff6a905dc1;
#using script_7fba4131729fe74d;
#using script_a62705cb078ec0a;
#using script_b7a9ce0a2282b79;
#using script_c00335a7aeb2728;
#using scripts\anim\battlechatter;
#using scripts\common\utility;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\armor;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\omnvar_utility;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_heli_reinforce;
#using scripts\mp\ai_mp_controller;
#using scripts\mp\bounty_system;
#using scripts\mp\class;
#using scripts\mp\equipment;
#using scripts\mp\equipment\disguise;
#using scripts\mp\equipment\throwing_knife_mp;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\gamescore;
#using scripts\mp\gametypes\activity_manager;
#using scripts\mp\gametypes\br;
#using scripts\mp\gametypes\br_gametype_dmz;
#using scripts\mp\gametypes\br_gametypes;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\gametypes\br_public;
#using scripts\mp\gametypes\br_vehicles;
#using scripts\mp\gametypes\br_weapons;
#using scripts\mp\gametypes\dead_drop;
#using scripts\mp\gametypes\dmz_ai;
#using scripts\mp\gametypes\dmz_ai_chopper;
#using scripts\mp\gametypes\dmz_bounty;
#using scripts\mp\gametypes\dmz_dog_tag;
#using scripts\mp\gametypes\dmz_safes;
#using scripts\mp\gametypes\dmz_samsites;
#using scripts\mp\hud_message;
#using scripts\mp\hud_util;
#using scripts\mp\locksandkeys;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\playerlogic;
#using scripts\mp\plea_for_help;
#using scripts\mp\pmc_missions;
#using scripts\mp\poi;
#using scripts\mp\rank;
#using scripts\mp\stationary_notes;
#using scripts\mp\teamrevive;
#using scripts\mp\utility\dialog;
#using scripts\mp\utility\game;
#using scripts\mp\utility\killstreak;
#using scripts\mp\utility\lower_message;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\sound;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace br_gametype_dmz;

function main() {
  level.var_cdc15ee14362fbf = &scripts\mp\gametypes\br_gametype_dmz::init;
  scripts\mp\gametypes\br::main();
}

function init() {
  scripts\cp_mp\utility\game_utility::removematchingents_bykey("delete_on_load", "targetname");
  function_c2a1bc0c5a905217();
  function_a96666bc3e3d2cb0();
  function_81b59887710baf14();

  if(issharedfuncdefined("dmz_s5_reveal", "init")) {
    level thread[[getsharedfunc("dmz_s5_reveal", "init")]]();
  }

  level thread initdialog();
  level thread initfx();
  level thread initexternalfeatures();
  level thread initpostmain();
  level thread initai();
  level thread function_4fb6f74e053a49d6();

  level thread namespace_d1a9ca87d78d9813::function_df414d6582eeca3();

  level thread testtimelimit();

  level thread function_f7920586b5a59226();

  level thread function_2ff493cd8ff03634();

  level thread function_f917fde1df9c5506();

  level thread function_37eaf2bc0bb3e28a();

  level thread function_dc98aeb4dd4b727a();

  level thread function_459e2558e6d936ed();

  level thread scripts\mp\gametypes\dmz_ai_chopper::debug();

  level thread function_b0d036699b334631();

  level thread function_e1fa80f536692a32();
  setDvar(@ "hash_da4f64f6eb4d97da", 3);
  setDvar(@ "scr_br_loadout_option", "nothing");
  setDvar(@ "hash_a85ba82ffd9faefe", 0);
  setDvar(@ "hash_2c9195a6f431585d", 1);
  setDvar(@ "hash_58a078a367c02ab3", 1);
  setDvar(@ "hash_c5d765aefb9658bd", 2200);
  setdvarifuninitialized(@ "hash_a44cf32ff2620bc2", 9);
  setdvarifuninitialized(@ "scr_br_respawnmaxteammateoffset", 10000);
  setomnvar("ui_br_circle_state", 5);
  setomnvar("ui_gulag_state", 1);
  setomnvar("ui_hide_redeploy_timer", 1);
  oobtime = getdvarint(@ "scr_outofboundstime", -1);

  if(oobtime == -1) {
    setDvar(@ "scr_outofboundstime", 10);
  }

  level.var_e4a482edc1542597 = getdvarint(@ "hash_bb9178da63ce4b9", 1) == 1;
  level.var_d040719163e20394 = 1;
  level.var_78db23c4f4816114 = 1;
  level.var_ece60df4b8bc448 = 1;
  level.var_5dee688f6db9ad0b = 1;
  level.var_b9c6856f5ab5f70f = 1;
  level.var_f60a3be40c34023d = 1;
  level.var_c3d1e9e6a5024479 = 1;
  level.var_82ef5f20ebbf6b59 = 1;
  level.var_b7ad06255200033c = 1;
  setDvar(@ "hash_e57fc6a3ec1c560b", 0);
  level.var_82a0e660e66306dc = 1;
  level.var_faec6e12b831873d = 1;
  level.var_749783dc3aa20c72 = 1;
  level.var_b75e093e97f9e931 = 1;
  level.var_2690bfebdead0396 = 1;
  level.var_48154008716f7116 = 1;
  level.var_b9abf4fc2d1f7fcd = &function_b9abf4fc2d1f7fcd;

  if(getdvarint(@ "hash_4e758755f5217912", 1) == 1) {
    level.var_924a9707bdcbfc46 = &function_f6843e3a71516b3e;
  }

  level.var_d191ab4628e775cd = getdvarint(@ "hash_942e15dcd26fb29e", 20);
  level.skipprematchdropspawn = 1;
  level.skipplaybodycountsound = 1;
  level.brdisablefinalkillcam = 1;
  level.br_prematchffa = 0;
  level.var_59ff09549058dda2 = getdvarint(@ "hash_f1b1048e888610e9", 1) && getdvarint(@ "hash_ff65c25889692db8", 0) != 1;
  level.giveloadouteverytime = getdvarint(@ "hash_f38399dadd8dbb3c", 1);
  level.var_fc90401f4ae3f765 = getdvarint(@ "hash_bb1dcc8bdbf24ff", 0) == 1;
  level.skipprematch = getdvarint(@ "hash_cb643d3f8e15dc02", 0);
  level.allowprematchdamage = 0;
  level.var_8281a47e2cecb257 = 1;
  level.var_eef1d450c2d5d682 = getdvarint(@ "hash_dcf2ce95246dd428", 1);

  if(level.var_eef1d450c2d5d682) {
    scripts\mp\gametypes\br_gametypes::disablefeature("littleBirdSpawns");
  }

  level.var_e00997af1f830a38 = 1;
  level.var_e148f7d0b42fe6da = getdvarfloat(@ "hash_c8c9056814e8241c", 1);
  level.var_be39d6b46044f344 = getdvarfloat(@ "hash_685be141b7e436ee", 40);
  level.instantbleedoutsquadwipe = getdvarint(@ "hash_76a23e670fcf02b5", 1);
  level.laststandoutlineenabled = getdvarint(@ "hash_445f250f74c53306", 0);
  level.respawnheightoverride = getdvarint(@ "hash_1cfe5b8f1beeb2c6", 5000);
  level.parachutedeploydelay = getdvarfloat(@ "hash_bf323f012d271c0", 0.5);
  level.autoassignfirstquest = getdvarint(@ "hash_c2bdab0e90057ed", 0);
  level.tabletreplacefrequency = getdvarfloat(@ "hash_c9e99ca095302d5e", 1.5);
  level.objectivescaler = 1;
  level.var_644a33d86d8514bf = getdvarint(@ "hash_36b76adbfa9d12c5", 1) == 1;
  level.skipweapondropondeath = getdvarint(@ "hash_d9f08c101634f72e", 0);
  level.skipequipmentdropondeath = getdvarint(@ "hash_3b11aff9dadd9d22", 0);
  level.allowfultondropondeath = getdvarint(@ "hash_906f1e617463438e", 1);
  level.var_545cddf92da82a04 = getdvarint(@ "hash_f924e428ae42dc96", 0);
  level.var_36827f5d10328424 = &function_f1ad30efc5733caf;
  level.var_57ece26e490ad8c4 = getdvarint(@ "hash_31afd0e1d896114a", 1);
  level.var_e4623740d9b51824 = getdvarint(@ "hash_eefb9c49e01093a6", 1);
  level.var_595938569c3fe806 = getdvarint(@ "hash_c43f4c79f914aee", 1);
  level.var_f4b090dbbd2b125b = getdvarint(@ "hash_9b11f9106fb2721", 0);
  level.var_e028ca551ecc95a3 = getdvarint(@ "hash_1107caf2e45b5ccd", 1);
  level.var_cc9e990b6e83975b = getdvarint(@ "hash_c39067c564e9be9", 1);
  level.var_a101059dea76957c = getdvarint(@ "hash_9aff44dbd6467cb1", 1);
  level.var_2c93542553c664f5 = getdvarint(@ "hash_850bde4c8d2d482b", 0);
  level.var_472d7a6d15e57940 = getdvarint(@ "hash_586d32848f833922", 1);
  level.var_1d814f83596d0a02 = getdvarint(@ "hash_7a1da73fa673ed8", 1);
  level.var_8dea6607b3189a60 = getdvarint(@ "hash_32c09327627c883c", 1);
  level.minplunderdropondeath = getdvarint(@ "hash_e0a487b88d0e4410", 0);
  level.var_f478c1f94caa7e9 = getdvarint(@ "scr_use_playerdata_weapon_slot", 1);
  level.var_7d17e26667be2792 = getdvarint(@ "hash_55d9444d8a3ce31a", 1);
  guns = getDvar(@ "hash_53bc1dfee47e5c6d", "brloot_weapon_ar_schotel_lege,brloot_weapon_ar_golf3_lege,brloot_weapon_br_msecho_lege,brloot_weapon_br_soscar14_lege,brloot_weapon_ar_mike4_lege,brloot_weapon_ar_mike16_lege,brloot_weapon_ar_akilo_lege");
  level.var_808a69414f52f6bc = strtok(guns, ",");
  level.var_184726567a9f58d8 = getdvarfloat(@ "hash_d2b4c84cdda73751", 0.02);
  level.var_e5993849fc7d5987 = getdvarint(@ "hash_beb500581164e4bc", 1);
  level.var_38ae6e498db315ff = getdvarint(@ "hash_fe9052d4aaa052e0", 1000);
  level.var_499b5e2905bfa698 = getdvarint(@ "scr_dmz_maxteamsperpoi", 4);
  level.var_3c8e175d92be01ea = &function_daf5cd1e02931ea7;
  level.disablewinonscore = getdvarint(@ "hash_4a9c110cfc54a4c5", 0);
  level.var_ef3e0eb58d1263c5 = getdvarint(@ "hash_8985888259fde494", 30);
  level.var_44691e82f0c05d37 = &onteameliminated;
  level.var_376762409014cc8e = getdvarint(@ "hash_d7b1d34d99c190a8", 0);
  level.var_87a4731d4dce4c3f = &function_9df0ee7fcb9589d4;
  level.var_8973f9da378e47d = 0;
  level.var_af010715d9de37a1 = getdvarfloat(@ "hash_daf598646a54a4b7", 0.4);
  level.var_d034183abf2e274d = getdvarint(@ "hash_64be202f01a8b591", 1);
  level.var_87deb8f6a4c7d50e = getdvarfloat(@ "hash_3895fe2399dd9e41", 512);
  level.var_719b61ca626125ff = getdvarfloat(@ "hash_86a034ed5d293bec", 256);
  level.var_7a36d824da6087ef = getdvarint(@ "hash_744188cc6b4d2af0", 1);
  level.var_c7aedf1af259f045 = 1;
  level.var_fb7d41d7c65922b7 = getdvarint(@ "hash_60642a632ab9baeb", 1);

  if(level.var_fb7d41d7c65922b7) {
    level.var_76eba5facacd254b = &function_bfd9f11e955ace89;
  }

  level.onplayereliminated = &function_d056e6d06ba65ca8;
  setDvar(@ "hash_a6a3fd965485d4bc", 2);
  level thread function_62b40b6a6c2cf37a();
  level thread initstartpoints();
  level thread checkendgame();

  if(istrue(level.var_c7aedf1af259f045)) {
    namespace_25b25d188ef778c4::function_36f1bd0f5d72054a();
  }

  level thread scripts\mp\gametypes\dead_drop::init_dead_drop();

  if(getdvarint(@ "hash_696cde56698dcc68", 1) == 1) {
    thread namespace_7789f919216d38a2::radiation_init();
  }

  if(getdvarint(@ "hash_7afd7ac5e611d8ad", 1) == 1) {
    level thread namespace_c50aac14f506294b::function_414e92de6d8a19ad();
  }

  if(getdvarint(@ "hash_a6efeb74a267da10", 0)) {
    level thread function_3fd2d65f62ca31b0();
  }

  setDvar(@ "live_lobby_max_time", 0);

  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    function_d2c13fc95e4e8962(1);
    namespace_a38a2e1fe7519183::init();
  }

  level thread function_f3a2435f8e39438b();
  function_fba25ae643dd02e8();
}

function function_b52f35a3ff450ecd() {
  tospawn = getdvarint(@ "hash_a0c7b324fe8c09c6", 3);

  if(tospawn <= 0 || istrue(level.var_291b51c7af8d1204)) {
    return;
  }

  structs = level.var_e4669b797013d077;

  if(!isDefined(structs) || structs.size == 0) {
    return;
  }

  foreach(struct in array_slice(array_randomize(structs), 0, tospawn)) {
    mrap = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh9_mil_lnd_mrap", struct);
    mrap scripts\cp_mp\vehicles\vehicle_occupancy::function_ac0a3326d43eb8fd();
  }
}

function function_c2a1bc0c5a905217() {
  battlechatteroverrides = spawnStruct();
  battlechatteroverrides.idlemindelay = getdvarint(@ "hash_3ce6579b3e9456de", 10);
  battlechatteroverrides.idlemaxdelay = getdvarint(@ "hash_5973b1ca7fd76fe0", 20);
  battlechatteroverrides.huntmindelay = getdvarint(@ "hash_41027aea8f94bf2d", 7);
  battlechatteroverrides.huntmaxdelay = getdvarint(@ "hash_4769e3057df7eaef", 15);
  battlechatteroverrides.combatmindelay = getdvarint(@ "hash_94b723881ade691c", 1);
  battlechatteroverrides.combatmaxdelay = getdvarint(@ "hash_787efbd4ed18ab72", 2);
  scripts\anim\battlechatter::init_battlechatteroverrides(battlechatteroverrides);
}

function function_fba25ae643dd02e8() {
  scripts\mp\bounty_system::init();
  scripts\mp\gametypes\dmz_bounty::function_5ba1bb4933edc5da();
}

function function_a96666bc3e3d2cb0() {
  scripts\mp\gametypes\br_gametypes::disablefeature("circle");
  scripts\mp\gametypes\br_gametypes::disablefeature("gulag");
  scripts\mp\gametypes\br_gametypes::disablefeature("dropbag");
  scripts\mp\gametypes\br_gametypes::disablefeature("plunderSites");
  scripts\mp\gametypes\br_gametypes::disablefeature("circle");
  scripts\mp\gametypes\br_gametypes::disablefeature("brQuests");

  if(getdvarint(@ "hash_c3a2e929e971289a", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::disablefeature("teamSpectate");
  }

  if(getdvarint(@ "hash_18984a982b2ffc8f", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::disablefeature("spectateOnDeath");
  }

  if(getdvarint(@ "hash_cf460f5e17cacbe6", 1) == 0) {
    scripts\mp\gametypes\br_gametypes::disablefeature("kiosk");
  }

  scripts\mp\gametypes\br_gametypes::enablefeature("allowLateJoiners");

  if(getdvarint(@ "hash_38723bbb368f3f8c", 1) == 1) {
    scripts\mp\gametypes\br_gametypes::enablefeature("tabletReplace");
  }

  scripts\mp\gametypes\br_gametypes::enablefeature("infilParachuteVfx");
}

function function_81b59887710baf14() {
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerShouldRespawn", &playershouldrespawn);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("spawnHandled", &spawnhandled);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerWelcomeSplashes", &playerwelcomesplashes);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onPlayerConnect", &onplayerconnect);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("isValidSpectateTarget", &isvalidspectatetarget);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("playerSkipLootPickup", &playerskiplootpickup);
  scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("onStartGameType", &onstartgametype);
  level.filtervehiclespawnstructsfunc = &filtervehiclespawnstructs;
  level.modeiskillstreakallowed = &function_f1c3982d13453d32;
}

function initdialog() {
  level endon("game_ended");
  level.var_92b187a00d3dd091 = 1;
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

function initfx() {
  if(!isDefined(level._effect["cargo_pallet_destruction"])) {
    level._effect["cargo_pallet_destruction"] = loadfx("vfx/iw9/veh/scriptables/death/vfx_veh_cargo_dest.vfx");
  }

  if(!isDefined(level._effect["gunship_flares"])) {
    level._effect["gunship_flares"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_flares.vfx");
  }
}

function function_4fb6f74e053a49d6() {
  level.nosuspensemusic = 1;

  if(getdvarint(@ "hash_9c43b60485fbd92e", 0) != 1) {
    level waittill("prematch_fade_done");
  } else {
    wait 5;
  }

  snd_transient_load("mp_gamemode_dmz");
}

function initexternalfeatures() {
  level endon("game_ended");
}

function initpostmain() {
  level endon("game_ended");
  level.var_f38e7b13448998b4 = &function_f38e7b13448998b4;

  if(getdvarint(@ "hash_ff65c25889692db8", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::registerbrgametypefunc("infilSequence", &function_73bdf8b18e29b13f);
  }

  scripts\engine\utility::registersharedfunc("hud", "showDMZSplash", &scripts\mp\gametypes\br_gametype_dmz::showdmzsplash);
  scripts\engine\utility::registersharedfunc("inventory", "isBackpackInventoryEnabled", &namespace_aead94004cf4c147::isbackpackinventoryenabled);
  waittillframeend();
  scripts\mp\flags::gameflaginit("start_fortress_spawns", 0);
  nojip = getdvarint(@ "hash_c26ef34f769bd14f", 1) == 1;
  setnojiptime(nojip, 1);
  setnojipscore(nojip, 1);
  level.nojip = nojip;

  if(!nojip) {
    level thread function_ffc9bebe581e6fa();
  }

  level thread scripts\mp\stationary_notes::function_d197edbd2618c9d1();
  level.getspawnpoint = &getspawnpoint;
  level.var_c11104510d66e98 = &getspawnpoint;
  level.modemayconsiderplayerdead = &brmayconsiderplayerdead;
  level.brmodevariantrewardcullfunc = &function_3acbbd83af4bcd34;
  level.ononeleftevent = &brononeleftevent;
  level.onplayerdisconnect = &onplayerdisconnect;
  level.onplayerkilled = &onplayerkilled;
  level.onpostkillcamcallback = &onpostkillcamcallback;
  level.ontimelimit = &ontimelimit;
  level.bypassclasschoicefunc = &pickclassbr;
  level.validautoassignquests = [];
  level.validautoassignquests[0] = "assassination";
  level.validautoassignquests[1] = "domination";
  level.validautoassignquests[2] = "scavenger";
  level thread scripts\mp\gametypes\activity_manager::function_df15f72187363229();

  if(issharedfuncdefined("dmz_bosses", "initBosses")) {
    level thread[[getsharedfunc("dmz_bosses", "initBosses")]]();
  }

  level thread scripts\mp\gametypes\dmz_samsites::function_ad4172a44f169cb6();
  level thread scripts\mp\gametypes\dmz_safes::initsafes();

  if(level.var_eef1d450c2d5d682) {
    level thread function_d8431975bbec1179();
  }

  if(level.mapname != "mp_ai_firefight") {
    namespace_8fb3ba83379e798c::init();
  }

  if(!scripts\cp_mp\utility\game_utility::function_ffbbb4525b11d5a2()) {
    level.var_1a6c1600565c49a = &namespace_e0526929a9f43046::function_df0fe5ac51164868;
  }

  namespace_3a88b1955556fd::function_209b4f3cbe639411();
  scripts\cp_mp\agents\agent_utils::function_9ec5f9cfc835208e();
  level thread function_11750957aa915a23();
  level thread eomawardplayerxp();
  level thread checktimelimitevents();
  level thread namespace_9823ee6035594d67::fortress_init();
  level thread scripts\mp\locksandkeys::init();
  level thread scripts\mp\locksandkeys::function_2a56c656879dbf63();
  level thread scripts\mp\locksandkeys::function_a894d6041798cc06();
  level thread scripts\mp\equipment\disguise::function_83599506981c29cd();
  level thread function_3403c13cec1cea46();
  level thread namespace_232c174d637e4b1d::function_9c85640063aa1a62();
}

function function_ffc9bebe581e6fa() {
  var_b2b90c3aad0f71a4 = getdvarint(@ "hash_56bec729cfb5d24c", 300);
  wait var_b2b90c3aad0f71a4;
  setnojiptime(1, 1);
  setnojipscore(1, 1);
  level.nojip = 1;
}

function function_811855d1edeef614() {}

function initai() {
  if(getdvarint(@ "hash_973e5e3debca8d24", 0) != 1) {
    level.var_428703950599c9e9 = &scripts\mp\gametypes\dmz_ai::function_428703950599c9e9;
    scripts\mp\ai_mp_controller::init();
    level thread scripts\mp\gametypes\dmz_ai::init();
    level thread namespace_43bf74a2ee9234c0::function_7f4d3080c6e8748b();
    level thread scripts\mp\ai_heli_reinforce::function_d0ffcd08e0870cf2();
    level thread namespace_885300a47c2b51e6::function_ca39a413ace3c168();
    level thread namespace_ab6776a0c2e19905::function_48e19aa598e95954();
    scripts\engine\utility::registersharedfunc("paraReinforce", "onChutePull", &namespace_885300a47c2b51e6::function_6a8ad55c5a4036d1);
    var_8c3ec2d4f32359d0 = getdvarint(@ "hash_878b14b03d2a762", 1);

    if(var_8c3ec2d4f32359d0) {
      namespace_d2c35aa0ab3fe2d2::function_a9e26388b8dc22b3();
    }

    scripts\mp\ai_mp_controller::function_2fc80954fa70d153();

    if(var_8c3ec2d4f32359d0) {
      level thread namespace_d2c35aa0ab3fe2d2::function_cbae2bd62d2e7086();
    }

    level thread namespace_e5a48e48e132c025::function_2e887982267d85a8();

    level thread namespace_d2c35aa0ab3fe2d2::function_6994a068636ec457();

    if(!istrue(level.var_4cfd75aa6ddde156) || getdvarint(@ "hash_6c875cdb8f27302e", 0) == 1) {
      if(issharedfuncdefined("dmz_bosses", "spawnMatchStartBosses")) {
        level thread[[getsharedfunc("dmz_bosses", "spawnMatchStartBosses")]]();
      }
    }

    scripts\mp\ai_mp_controller::function_80cd0109b7f5161d();
    scripts\mp\flags::gameflagset("start_fortress_spawns");
    level thread scripts\mp\ai_mp_controller::function_b4367b762ab15e1f();

    if(getdvarint(@ "hash_5fc378f6fc9470f7", 0)) {
      level thread namespace_c50aac14f506294b::function_918a46f20addf647();
    }

    level thread scripts\mp\ai_mp_controller::function_51014d65a15cf0f9();
    return;
  }

  level thread scripts\mp\ai_mp_controller::function_576ed049f93d9496();
}

function onplayerconnect(player) {
  player setclientomnvar("ui_br_infiled", 1);

  if(scripts\mp\gametypes\activity_manager::function_5ea5a722c499078f(player.team)) {
    scripts\mp\gametypes\activity_manager::function_64623e2ff7409f39(player, 0);
  }

  namespace_7789f919216d38a2::function_1509b788f4410b94(player);
  scripts\cp_mp\agents\agent_utils::function_3a458af8ab69f4e(player);
}

function function_26f93cc0ad9b7c39() {
  self endon("disconnect");
  function_2fe5ef40dc48daf0();

  if(getdvarint(@ "hash_8da4a5e690432cd0", 1) == 0) {
    return;
  }

  if(!self istacmapactive()) {
    self setclientomnvar("ui_dmz_mission_overlay", 1);
  }

  wait 1;
  self setclientomnvar("ui_dmz_mission_overlay", 0);
}

function function_2fe5ef40dc48daf0() {
  self endon("tac_map_toggle");
  self endon("disconnect");
  self endon("screen_completely_black");

  while(!self istacmapactive()) {
    if(isDefined(self) && isDefined(self.origin)) {
      if(scripts\mp\poi::poi_issystemactive() && isDefined(level.teamdata) && isDefined(self.team) && isDefined(level.teamdata[self.team]) && isDefined(level.teamdata[self.team]["startPoint"]) && isDefined(level.teamdata[self.team]["startPoint"].poi)) {
        poi = level.teamdata[self.team]["startPoint"].poi;
        poiorigin = scripts\mp\poi::poi_getorigin(poi);

        if(isDefined(poiorigin) && distance(poiorigin, self.origin) < 13000) {
          scripts\mp\gametypes\br::function_258c4f40dee8189a(poiorigin[0], poiorigin[1], 1);
        } else {
          scripts\mp\gametypes\br::function_258c4f40dee8189a(self.origin[0], self.origin[1], 1);
        }
      } else {
        scripts\mp\gametypes\br::function_258c4f40dee8189a(self.origin[0], self.origin[1], 1);
      }
    }

    wait 1;
  }
}

function brmayconsiderplayerdead(player) {
  if(isDefined(level.checkforlaststandwipe)) {
    [[level.checkforlaststandwipe]](player);
  }

  if(istrue(self.squadwiped)) {
    player setplayermusicstate("mp_lose_2");
    namespace_25b25d188ef778c4::function_2eda2621150bd589([player], 4);
  }

  return true;
}

function function_3acbbd83af4bcd34(rewards) {
  var_36f04620526242ff = [];
  return var_36f04620526242ff;
}

function filtervehiclespawnstructs(vehiclespawnstructs) {
  if(getdvarint(@ "hash_2cc531e644d4fdb3", 1) == 0) {
    return vehiclespawnstructs;
  }

  if(!scripts\mp\poi::function_7e9cbc0f32de6578()) {
    return [];
  }

  if(!isDefined(level.var_ab20b3a256911579) || level.var_ab20b3a256911579.size == 0) {
    return vehiclespawnstructs;
  }

  filtered = [];

  foreach(struct in vehiclespawnstructs) {
    if(!isDefined(struct.origin)) {
      continue;
    }

    poi = scripts\mp\poi::poi_findpoioriginisin(struct.origin, 1);

    if(array_contains(level.var_ab20b3a256911579, poi)) {
      continue;
    }

    filtered[filtered.size] = struct;
  }

  return filtered;
}

function brononeleftevent(team) {}

function onplayerdisconnect(player) {
  if(getdvarint(@ "hash_8f63416f53600636", 1) && isaliveandnotinlaststand(player) && !istrue(player.extracted) && !istrue(player.var_ded04cdd264a7e00)) {
    if(namespace_aead94004cf4c147::function_720d227d0e55a960()) {
      scripts\mp\gametypes\dmz_dog_tag::function_f6d685cabfad2ce9(player);
    }

    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
    player namespace_aead94004cf4c147::function_c6b3799b231916bb(player, dropstruct);

    if(scripts\mp\gametypes\br_pickups::function_990be1aa4ad3c9d4()) {
      player scripts\mp\gametypes\br_pickups::function_c15a28fc6247ad60(dropstruct);
    }
  } else {
    player namespace_a8b2b88699fc40fb::function_c320904c58171311();

    if(isDefined(player.objidbounty)) {
      scripts\mp\objidpoolmanager::returnobjectiveid(player.objidbounty);
    }
  }

  if(!istrue(player.extracted) && !istrue(player.var_ded04cdd264a7e00)) {
    scripts\cp_mp\challenges::function_b8e86c6dea0ac027(player);
  }

  function_c227bd210d16e07c(player);
  level thread function_da0fa1afaa8835cf();
}

function function_c227bd210d16e07c(player) {
  if(istrue(player.var_84d661ff601a2f9f)) {
    return;
  }

  if(istrue(player.var_ded04cdd264a7e00)) {
    if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
      namespace_a38a2e1fe7519183::function_cd234cdd6b1b3699(player);
    }
  } else if(!istrue(player.extracted)) {
    if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7() && namespace_a38a2e1fe7519183::function_dedf2039edee97d0()) {
      namespace_a38a2e1fe7519183::function_868b6d4fbec3938c(player);
    } else {
      player namespace_aead94004cf4c147::clearbackpack();
      namespace_aead94004cf4c147::function_954372d604277278(player);
    }

    scripts\cp_mp\challenges::function_868b6d4fbec3938c(player);
  } else {
    namespace_a38a2e1fe7519183::unlockitems(player);
    namespace_a38a2e1fe7519183::function_ea65e35c77f7679b(player);
  }

  player.var_84d661ff601a2f9f = 1;

  if(!istrue(player.var_ded04cdd264a7e00)) {
    scripts\mp\pmc_missions::function_b0ca76f04ad0e0c3(player);
  }
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid) {
  scripts\mp\gametypes\br::onplayerkilled(einflictor, attacker, idamage, smeansofdeath, objweapon, vdir, shitloc, psoffsettime, deathanimduration, killid);

  if(!istrue(level.var_fc90401f4ae3f765)) {
    self.class = "gamemode";
    self.pers["gamemodeLoadout"] = [];
    scripts\mp\class::respawnitems_clear();
  }

  var_f3990d8529de3a54 = namespace_aead94004cf4c147::function_c4f1bd7a01a307fa(self);
  namespace_aead94004cf4c147::clearbackpack(var_f3990d8529de3a54);
  namespace_aead94004cf4c147::function_954372d604277278(self);

  if(isDefined(self.objidbounty)) {
    attacker namespace_c50aac14f506294b::function_a5d597201278c71c(self);
  }

  if(scripts\mp\gametypes\br_gametypes::isfeatureenabled("pleaForHelp")) {
    self thread[[scripts\engine\utility::getsharedfunc("pleaForHelp", "callForHelp")]]();
  }

  scripts\mp\gametypes\dmz_bounty::function_47ef2434c27b063c(self, attacker, smeansofdeath);
  level thread function_da0fa1afaa8835cf();
  level thread function_265afd733ff97699(self);
}

function function_265afd733ff97699(deadplayer) {
  deadplayer notify("revive_timer_watch");
  deadplayer endon("revive_timer_watch");
  deadplayer endon("revivedAlive");
  deadplayer endon("restored_loot");
  deadplayer endon("disconnect");
  level endon("game_ended");

  if(!isDefined(deadplayer.team) || !isDefined(deadplayer.sessionsquadid)) {
    return;
  }

  wait getdvarint(@ "hash_9a366844ff95b5d7", 90);
  teamplayers = scripts\mp\utility\teams::getsquadmates(deadplayer.team, deadplayer.sessionsquadid, 1);

  if(teamplayers.size <= 1) {
    return;
  }

  scripts\cp_mp\overlord::playevent("squad_revive_reminder", teamplayers);
}

function function_1714ffea633dcfed(team) {
  if(team == "all" || !scripts\mp\plea_for_help::function_4db915a9ce0e903a() || !getdvarint(@ "hash_a5bfce6c742aa583", 1)) {
    return false;
  }

  thread function_ed7a5462253ebdef(team);
  return true;
}

function function_ed7a5462253ebdef(team) {
  level endon("game_ended");
  scripts\mp\gametypes\activity_manager::onteameliminated(team);
  players = scripts\mp\utility\teams::getteamdata(team, "players");

  foreach(player in players) {
    if(!scripts\mp\plea_for_help::ispleading(player)) {
      player notify("check_for_plea");
      waitframe();

      if(!scripts\mp\plea_for_help::function_bfdfd3c9ba0cc7cb(player)) {
        thread onplayereliminated(player);
        continue;
      }

      thread function_5df318837f8d78a2(player);
    }
  }
}

function onplayereliminated(player) {
  namespace_25b25d188ef778c4::function_2eda2621150bd589([player], 4);
  player.squadwiped = 1;

  if(!istrue(player.extracted) && scripts\engine\utility::issharedfuncdefined("dmz_bosses", "onPlayerSquadWiped")) {
    [[scripts\engine\utility::getsharedfunc("dmz_bosses", "onPlayerSquadWiped")]](player);
  }

  player setclientomnvar("ui_league_play_br_leave_penalty_timer", 0);
  remainingteams = [];
  remainingplayers = 0;

  foreach(entry in level.teamnamelist) {
    if(entry == player.team) {
      continue;
    }

    var_849d01afb2fc0f0a = scripts\mp\gametypes\br::function_99e3948bfd8a99b8(entry);

    if(var_849d01afb2fc0f0a > 0) {
      remainingteams[remainingteams.size] = entry;
      remainingplayers += var_849d01afb2fc0f0a;
    }
  }

  teamplacement = remainingteams.size + 1;
  [brbonusxp, var_1b70c48b930405f0, var_d6a23fdabd1d282c] = player scripts\mp\gametypes\br::calculatebrbonusxp(teamplacement, player.team);
  var_b01aca3236595958 = namespace_b5e6108f786dfb5a::function_87ecb716bc207294(player);
  player scripts\mp\gametypes\br::givebrbonusxp(brbonusxp, undefined, "squadEliminated", var_b01aca3236595958);
  player.matchbonus = scripts\mp\rank::function_c18c8bb0776284c6(var_1b70c48b930405f0, var_b01aca3236595958);
  player.placementbonus = scripts\mp\rank::function_9e1336d25eb66326(var_d6a23fdabd1d282c, var_b01aca3236595958);
  player thread scripts\mp\gametypes\br::handlebrdefeatedpostgamestate(teamplacement);
  player scripts\mp\gametypes\br::setplacementstats(teamplacement);
  player scripts\mp\gametypes\br::stopchallengetimers();
  scripts\mp\gamelogic::_setplayerteamrank(player, teamplacement);
  scripts\mp\gametypes\br::updateclientmatchdata(player);

  if(istrue(level.var_77907d733abe8b63)) {
    player namespace_2c7976a64ea24d6a::match_end(teamplacement, 1, 0);
  }

  result = undefined;

  if(istrue(player.pers["hasDoneAnyCombat"]) || istrue(player.pers["participation"])) {
    result = "eliminated";
  }

  player scripts\cp_mp\utility\game_utility::stopkeyearning(result);
  playerendmatch();
}

function function_4253eec492c87aa() {
  level endon("game_ended");
  self endon("disconnect");
  self endon("spawned");
  starttime = gettime();

  if(level.killcam) {
    while(!isDefined(self.var_7c813e50ff75be27)) {
      timeelapsed = gettime() - starttime;

      if(timeelapsed >= 1000) {
        return;
      }

      waitframe();
    }

    if(level.killcam && istrue(self.killcam)) {
      waittill_any_3("killcam_ended", "killcam_canceled", "abort_killcam");
    }
  }
}

function function_5df318837f8d78a2(player) {
  player notify("waiting_for_plea");
  level endon("game_ended");
  player endon("disconnect");
  player endon("revivedAlive");
  player endon("waiting_for_plea");
  player endon("plea_created");
  teammates = getteamdata(player.team, "players");

  foreach(member in teammates) {
    if(isDefined(member)) {
      member endon("spawned_player");
    }
  }

  player setclientomnvar("ui_show_spectateHud", player getentitynumber());
  player.var_7c813e50ff75be27 = undefined;
  player function_4253eec492c87aa();
  waitframe();
  player setclientomnvar("ui_waiting_for_aar", 1);
  endtime = int(gettime() + getdvarint(@ "hash_e323d1171dab7bff", 20) * 1000);
  player.var_6af52e47cbd09141 = endtime;
  player scripts\mp\utility\lower_message::setlowermessageomnvar("plea_time", endtime);
  scripts\mp\plea_for_help::function_d8b32f106816afc1(player);
  thread onplayereliminated(player);
}

function function_d056e6d06ba65ca8(player) {
  namespace_25b25d188ef778c4::function_2eda2621150bd589([player], 4);
  player.squadwiped = 1;

  if(!istrue(player.extracted) && scripts\engine\utility::issharedfuncdefined("dmz_bosses", "onPlayerSquadWiped")) {
    [[scripts\engine\utility::getsharedfunc("dmz_bosses", "onPlayerSquadWiped")]](player);
  }

  player setclientomnvar("ui_league_play_br_leave_penalty_timer", 0);
  remainingteams = [];
  remainingplayers = 0;

  foreach(entry in level.teamnamelist) {
    if(entry == player.team) {
      continue;
    }

    var_849d01afb2fc0f0a = scripts\mp\gametypes\br::function_99e3948bfd8a99b8(entry);

    if(var_849d01afb2fc0f0a > 0) {
      remainingteams[remainingteams.size] = entry;
      remainingplayers += var_849d01afb2fc0f0a;
    }
  }

  teamplacement = remainingteams.size + 1;
  [brbonusxp, var_1b70c48b930405f0, var_d6a23fdabd1d282c] = player scripts\mp\gametypes\br::calculatebrbonusxp(teamplacement, player.team);
  var_b01aca3236595958 = namespace_b5e6108f786dfb5a::function_87ecb716bc207294(player);
  player scripts\mp\gametypes\br::givebrbonusxp(brbonusxp, undefined, "squadEliminated", var_b01aca3236595958);
  player.matchbonus = scripts\mp\rank::function_c18c8bb0776284c6(var_1b70c48b930405f0, var_b01aca3236595958);
  player.placementbonus = scripts\mp\rank::function_9e1336d25eb66326(var_d6a23fdabd1d282c, var_b01aca3236595958);

  if(issharedfuncdefined("seasonalevents", "getFeaturedLootEventActive")) {
    if(callsharedfunc("seasonalevents", "getFeaturedLootEventActive")) {
      function_af5ab021b625cdf8(player);
    }
  }

  player thread scripts\mp\gametypes\br::handlebrdefeatedpostgamestate(teamplacement);
  player scripts\mp\gametypes\br::setplacementstats(teamplacement);
  player scripts\mp\gametypes\br::stopchallengetimers();
  scripts\mp\gamelogic::_setplayerteamrank(player, teamplacement);
  scripts\mp\gametypes\br::updateclientmatchdata(player);

  if(istrue(level.var_77907d733abe8b63)) {
    player namespace_2c7976a64ea24d6a::match_end(teamplacement, 1, 0);
  }

  result = undefined;

  if(istrue(player.pers["hasDoneAnyCombat"]) || istrue(player.pers["participation"])) {
    result = "eliminated";
  }

  player scripts\cp_mp\utility\game_utility::stopkeyearning(result);
  playerendmatch();
}

function onteameliminated(team) {
  if(team == "all") {
    foreach(player in level.players) {
      if(isDefined(player)) {
        player.squadwiped = 1;
        player thread scripts\mp\gametypes\br::handlebrdefeatedpostgamestate();
        player scripts\mp\gametypes\br::stopchallengetimers();
        namespace_25b25d188ef778c4::function_2eda2621150bd589([player], 4);
        scripts\mp\gametypes\br::updateclientmatchdata(player);
      }
    }

    return;
  }

  players = scripts\mp\utility\teams::getteamdata(team, "players");
  namespace_25b25d188ef778c4::function_2eda2621150bd589(players, 4);

  foreach(teamplayer in players) {
    teamplayer.squadwiped = 1;

    if(!istrue(teamplayer.extracted)) {
      if(scripts\engine\utility::issharedfuncdefined("dmz_bosses", "onPlayerSquadWiped")) {
        [[scripts\engine\utility::getsharedfunc("dmz_bosses", "onPlayerSquadWiped")]](teamplayer);
      }
    }
  }

  scripts\mp\gametypes\activity_manager::onteameliminated(team);
}

function function_f1ad30efc5733caf() {
  self notify("reconcileLoot");
  self endon("reconcileLoot");
  self endon("disconnect");
  self endon("restored_loot");
  level endon("game_ended");
  self waittill("revivedAlive");
  thread function_f0e913c037010a9();
  thread function_707d956bdbd4b134();
}

function function_707d956bdbd4b134() {
  self notify("restored_loot");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  namespace_a38a2e1fe7519183::function_f30f21d87c483297(self);
  self.var_4f7710ecff5b1619 = undefined;
  self.var_457667014505e1f9 = undefined;

  if(isDefined(self.var_ba19d6a40e652dd6)) {
    newsize = self.var_ba19d6a40e652dd6;
    newid = self.var_cd82e790e825db2;

    if(istrue(level.var_813b4b2211fbaf1d) && isDefined(self.var_6a4360dcf2a8f3d4) && isDefined(self.var_6a4360dcf2a8f3d4.loadoutcontents) && isDefined(self.var_6a4360dcf2a8f3d4.loadoutcontents[9]) && !istrue(self.var_6a4360dcf2a8f3d4.loadoutcontents[9]["lootID"])) {
      newid = undefined;
      newsize = 5;
    }

    namespace_aead94004cf4c147::function_d28f52da6ede0191(self, newsize, undefined, newid);

    if(isDefined(newid)) {
      namespace_a38a2e1fe7519183::function_92d947129ea5ba6e(self, newid);
    }
  }

  if(isDefined(self.var_6a4360dcf2a8f3d4) && isDefined(self.var_6a4360dcf2a8f3d4.contents)) {
    backpacksize = namespace_aead94004cf4c147::getplayerbackpacksize(self);
    backpackindex = 0;
    dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();

    foreach(item in self.var_6a4360dcf2a8f3d4.contents) {
      if(isDefined(item)) {
        lootid = item["lootID"];
        quantity = item["quantity"];

        if(backpackindex >= backpacksize && lootid > 0 && quantity > 0) {
          if(!getdvarint(@ "hash_f48ef3a11b86b06d", 1)) {
            break;
          }

          dropinfo = scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, self.origin, self.angles, self);
          scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);
          spawnedbackpack = scripts\mp\gametypes\br_pickups::spawnpickup(scriptablename, dropinfo, quantity, 1);
        } else {
          scripts\engine\utility::callsharedfunc(lootid, "pickedUp", self.var_6a4360dcf2a8f3d4, self);
          namespace_aead94004cf4c147::function_11f48ae5b87b4525(self, backpackindex, lootid, quantity);
        }

        backpackindex++;
      }
    }

    if(isDefined(self.var_6a4360dcf2a8f3d4.weaponslotcontents) && isDefined(self.var_6a4360dcf2a8f3d4.weaponslotobj)) {
      weapon = self.var_6a4360dcf2a8f3d4.weaponslotobj;
      namespace_aead94004cf4c147::function_e35a7cb7e7c8c17e(self, weapon, undefined, self.var_6a4360dcf2a8f3d4.metadata);
      scripts\mp\gametypes\br_weapons::function_ae30366a2d519a57(self, 2, self.var_6a4360dcf2a8f3d4.var_275f4441ab7920c8);
    }

    if(!istrue(level.var_813b4b2211fbaf1d)) {
      scripts\mp\gametypes\br_pickups::loothide(self.var_6a4360dcf2a8f3d4);
    }
  }

  var_ebc7c27c25633bb7 = undefined;

  if(!istrue(level.var_51225d738094457d) && isDefined(self.var_d2dbb2fa012e6d9c)) {
    weaponcount = 0;
    isweaponpickup = 0;

    foreach(key, item in self.var_d2dbb2fa012e6d9c) {
      if(isDefined(item)) {
        if(isDefined(item.customweaponname) && !scripts\mp\weapons::isfistweapon(item.customweaponname)) {
          if(!isDefined(var_ebc7c27c25633bb7)) {
            var_ebc7c27c25633bb7 = item.customweaponname;
          }

          weaponcount++;
          isweaponpickup = 1;
        } else if(isDefined(item.type) && isDefined(level.br_lootiteminfo) && isDefined(level.br_lootiteminfo[item.type]) && isDefined(level.br_lootiteminfo[item.type].fullweaponname) && !scripts\mp\weapons::isfistweapon(level.br_lootiteminfo[item.type].fullweaponname)) {
          if(!isDefined(var_ebc7c27c25633bb7)) {
            var_ebc7c27c25633bb7 = level.br_lootiteminfo[item.type].fullweaponname;
          }

          weaponcount++;
          isweaponpickup = 1;
        }

        if(weaponcount == 3 && isweaponpickup) {
          weaponcount = 0;
          pickup = spawnStruct();
          pickup.scriptablename = item.type;
          pickup.count = scripts\mp\gametypes\br_pickups::loot_getitemcount(item);
          pickup.countlefthand = scripts\mp\gametypes\br_pickups::loot_getitemcountlefthand(item);
          pickup.countalt = scripts\mp\gametypes\br_pickups::function_3a5f7703319142dd(item);
          pickup.instance = item;

          if(isDefined(item.customweaponname)) {
            pickup.customweaponname = item.customweaponname;
          }

          [newweapon] = scripts\mp\gametypes\br_weapons::function_55c5d35c8c76a95b(pickup);
          namespace_aead94004cf4c147::function_e35a7cb7e7c8c17e(self, newweapon);
          scripts\mp\gametypes\br_weapons::function_ae30366a2d519a57(self, 2, item.pastteam);
          scripts\mp\gametypes\br_pickups::loothide(item);
        } else {
          scripts\mp\gametypes\br_pickups::lootused(item, item.type, "visible", self, 0, item.type);
        }

        self.var_d2dbb2fa012e6d9c[key] = undefined;
        isweaponpickup = 0;
      }
    }
  }

  if(istrue(level.var_51225d738094457d) && isDefined(self.var_77893f01ee39c62e) && isDefined(self.var_77893f01ee39c62e.contents)) {
    foreach(item in self.var_77893f01ee39c62e.contents) {
      if(isDefined(item)) {
        lootid = item["lootID"];
        quantity = item["quantity"];

        if(lootid == 0 || quantity == 0) {
          continue;
        }

        if(scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(lootid)) {
          [victimindex, _] = scripts\mp\gametypes\dmz_dog_tag::getdogtagvictimandkiller(quantity);

          if(isDefined(level.dogtaginfo[victimindex].player)) {
            scripts\mp\gametypes\dmz_dog_tag::function_8e643d6706defeea(level.dogtaginfo[victimindex].player, quantity);
          }

          if(isDefined(level.var_547167a7517600fb) && isDefined(level.var_547167a7517600fb.var_5b72b9e0891944ae)) {
            [[level.var_547167a7517600fb.var_5b72b9e0891944ae]](self);
          }

          continue;
        }

        scripts\mp\gametypes\br_pickups::equipitem(lootid, quantity);
      }
    }

    if(isDefined(self.var_77893f01ee39c62e.weaponslotcontents) && isDefined(self.var_77893f01ee39c62e.weaponslotobj)) {
      weapon = self.var_77893f01ee39c62e.weaponslotobj;
      fullname = getcompleteweaponname(weapon);
      basename = undefined;

      if(isDefined(weapon.basename)) {
        basename = weapon.basename;
      } else {
        basename = getweaponbasename(weapon);
      }

      success = scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon(self, weapon, fullname, basename, undefined, undefined, undefined, self.var_77893f01ee39c62e.metadata);
      weaponindex = scripts\mp\gametypes\br_weapons::function_2ab3bda08c595a32(self, weapon);

      if(isDefined(weaponindex)) {
        scripts\mp\gametypes\br_weapons::function_ae30366a2d519a57(self, weaponindex, self.var_77893f01ee39c62e.var_275f4441ab7920c8);
      }
    }

    scripts\mp\gametypes\br_pickups::loothide(self.var_77893f01ee39c62e);
  }

  if(istrue(level.var_813b4b2211fbaf1d)) {
    if(isDefined(self.var_d2dbb2fa012e6d9c) && self.var_d2dbb2fa012e6d9c.size > 0) {
      self.var_c7fd13c53dbdc4f6 = 1;

      foreach(item in self.var_d2dbb2fa012e6d9c) {
        scripts\mp\gametypes\br_pickups::lootused(item, item.type, "visible", self, 0, item.type);
      }

      self.var_c7fd13c53dbdc4f6 = undefined;
      self.var_d2dbb2fa012e6d9c = [];
    }

    if(isDefined(self.var_6a4360dcf2a8f3d4) && isDefined(self.var_6a4360dcf2a8f3d4.loadoutcontents)) {
      foreach(item in self.var_6a4360dcf2a8f3d4.loadoutcontents) {
        if(isDefined(item)) {
          lootid = item["lootID"];
          quantity = item["quantity"];

          if(lootid == 0 || quantity == 0) {
            continue;
          }

          scriptablename = scripts\cp_mp\utility\loot::getscriptablefromlootid(lootid);

          if(scripts\mp\gametypes\dmz_dog_tag::function_3c17a26ce6a4668(lootid)) {
            [victimindex, _] = scripts\mp\gametypes\dmz_dog_tag::getdogtagvictimandkiller(quantity);

            if(isDefined(level.dogtaginfo[victimindex].player)) {
              scripts\mp\gametypes\dmz_dog_tag::function_8e643d6706defeea(level.dogtaginfo[victimindex].player, quantity);
            }

            if(isDefined(level.var_547167a7517600fb) && isDefined(level.var_547167a7517600fb.var_5b72b9e0891944ae)) {
              [[level.var_547167a7517600fb.var_5b72b9e0891944ae]](self);
            }

            continue;
          }

          if(scripts\mp\gametypes\br_pickups::function_b1e944a2b3e15e9d(scriptablename)) {
            continue;
          }

          if(scripts\mp\gametypes\br_public::isarmorplate(scriptablename)) {
            self.var_d4bfb0d4d797f448 = 1;
          }

          scripts\mp\gametypes\br_pickups::equipitem(lootid, quantity);
        }
      }

      if(isDefined(self.var_6a4360dcf2a8f3d4.var_a06e7128c001851d) && isDefined(self.var_6a4360dcf2a8f3d4.var_a0e9fef038504bd0)) {
        weapon = self.var_6a4360dcf2a8f3d4.var_a0e9fef038504bd0;
        fullname = getcompleteweaponname(weapon);
        basename = undefined;

        if(isDefined(weapon.basename)) {
          basename = weapon.basename;
        } else {
          basename = getweaponbasename(weapon);
        }

        success = scripts\mp\gametypes\br_weapons::br_forcegivecustomweapon(self, weapon, fullname, basename, undefined, undefined, undefined, self.var_6a4360dcf2a8f3d4.var_bb6791b7369ef71a);
        weaponindex = scripts\mp\gametypes\br_weapons::function_2ab3bda08c595a32(self, weapon);

        if(isDefined(weaponindex)) {
          scripts\mp\gametypes\br_weapons::function_ae30366a2d519a57(self, weaponindex, self.var_6a4360dcf2a8f3d4.var_c31356a794d8cb46);
        }
      }
    }

    if(isDefined(self.var_6a4360dcf2a8f3d4)) {
      scripts\mp\gametypes\br_pickups::loothide(self.var_6a4360dcf2a8f3d4);
    }
  }

  if(istrue(level.var_51225d738094457d)) {
    if(isDefined(self.var_3480393dc131952a)) {
      item = self.var_3480393dc131952a;

      if(!isDefined(var_ebc7c27c25633bb7)) {
        if(isDefined(item.customweaponname) && !scripts\mp\weapons::isfistweapon(item.customweaponname)) {
          var_ebc7c27c25633bb7 = item.customweaponname;
        } else if(isDefined(item.type) && isDefined(level.br_lootiteminfo) && isDefined(level.br_lootiteminfo[item.type]) && isDefined(level.br_lootiteminfo[item.type].fullweaponname) && !scripts\mp\weapons::isfistweapon(level.br_lootiteminfo[item.type].fullweaponname)) {
          var_ebc7c27c25633bb7 = level.br_lootiteminfo[item.type].fullweaponname;
        }
      }

      scripts\mp\gametypes\br_pickups::lootused(item, item.type, "visible", self, 0, item.type);
    }

    if(isDefined(self.dogtag) && !istrue(level.var_813b4b2211fbaf1d)) {
      scripts\mp\gametypes\br_pickups::lootused(self.dogtag, self.dogtag.type, "visible", self, 0, self.dogtag.type);
    }
  }

  if(isDefined(self.ammoondeath)) {
    self.br_ammo = self.ammoondeath;
    scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);
  }

  if(istrue(level.var_51225d738094457d) && isDefined(self.var_620f2a17df977448)) {
    item = self.var_620f2a17df977448;
    scripts\mp\gametypes\br_pickups::lootused(item, item.type, "visible", self, 0, item.type);
  }

  self.dogtag = undefined;
  waitframe();

  if(isDefined(var_ebc7c27c25633bb7) && self hasweapon(var_ebc7c27c25633bb7)) {
    self switchtoweaponimmediate(var_ebc7c27c25633bb7);
  }

  if(isDefined(self.equipment) && !isDefined(self.equipment["health"])) {
    scripts\cp_mp\armor::function_be5c0cdfa0202544();
  }
}

function attachbag(bagmodel) {
  assertex(isPlayer(self), "<dev string:x1c>");

  if(!getdvarint(@ "hash_df3d4c7861e822b4", 1)) {
    return;
  }

  if(isDefined(self.attached_bag)) {
    detachbag();
  }

  self attach(bagmodel, "tag_stowed_back3", 1, 1);

  if(!isDefined(self.operatorcustomization) || !isDefined(self.operatorcustomization.body) || self.operatorcustomization.body != "body_mp_gus_iw9_1_1") {
    if(self tagexists("TAG_STOWED_BACKPACK_HIDE")) {
      self hidepart("TAG_STOWED_BACKPACK_HIDE");
    }
  }

  self.attached_bag = bagmodel;
}

function detachbag() {
  assertex(isPlayer(self), "<dev string:x5a>");

  if(!getdvarint(@ "hash_df3d4c7861e822b4", 1) || !isDefined(self.attached_bag)) {
    return;
  }

  self detach(self.attached_bag, "tag_stowed_back3");
  self.attached_bag = undefined;
}

function onpostkillcamcallback() {}

function ontimelimit() {
  if(isDefined(level.var_aab9f6cfc50f372f)) {
    [[level.var_aab9f6cfc50f372f]]();
    return;
  }

  if(!istrue(level.var_99eadae60b4b76e4)) {
    level thread namespace_7789f919216d38a2::radiation_startspread();
    level.var_99eadae60b4b76e4 = 1;
  }
}

function checkendgame() {
  level endon("dmzDeathEnd");
  level waittill("dmz_radiation_complete");
  wait level.var_ef3e0eb58d1263c5;
  fadedur = 2;
  level.disablelaststand = 1;

  foreach(player in level.players) {
    if(isDefined(player) && isreallyalive(player) && !istrue(player.extracted)) {
      player thread endmatchfade(fadedur);
    }
  }

  if(isDefined(level.revivetriggers)) {
    foreach(guid, revivetrigger in level.revivetriggers) {
      if(isDefined(revivetrigger.victim)) {
        revivetrigger.victim thread scripts\mp\teamrevive::removetrigger(guid);
      }
    }
  }

  wait fadedur + 5;
  level notify("dmzTimerEnd");

  foreach(player in level.players) {
    function_c227bd210d16e07c(player);
  }

  scripts\mp\gamelogic::endgame_regularmp("none", game["end_reason"]["time_limit_reached"], game["end_reason"]["time_limit_reached"]);
}

function endmatchfade(fadedur) {
  self endon("disconnect");
  utility::hidehudenable();
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, fadedur);
  wait fadedur;
  scripts\cp_mp\overlord::playevent("exfil_none", [self]);
  self dodamage(999999, self.origin, self, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
  self freezecontrols(1);
  wait 2;
  utility::hidehuddisable();
  level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 1);
}

function function_da0fa1afaa8835cf() {
  level notify("checkEndGameDeathDmz");
  level endon("checkEndGameDeathDmz");
  level endon("dmzTimerEnd");
  wait 25;

  foreach(entry in level.teamnamelist) {
    alivecount = getteamdata(entry, "aliveCount");

    if(alivecount) {
      aliveplayers = getteamdata(entry, "alivePlayers");

      foreach(player in aliveplayers) {
        if(isDefined(player) && !istrue(player.extracted)) {
          return;
        }
      }
    }
  }

  wait 1;

  foreach(player in level.players) {
    if(isDefined(player)) {
      function_c227bd210d16e07c(player);
    }
  }

  level notify("dmzDeathEnd");
  scripts\mp\gamelogic::endgame_regularmp("none", game["end_reason"]["time_limit_reached"], game["end_reason"]["time_limit_reached"]);
}

function testtimelimit() {
  while(true) {
    if(getdvarint(@ "hash_18ee31f4b5470139", 0) == 1) {
      ontimelimit();
      setDvar(@ "hash_18ee31f4b5470139", 0);
    }

    wait 1;
  }
}

function checktimelimitevents() {
  minutesremaining = scripts\mp\gamelogic::gettimeremaining() / 1000 / 60;
  level.var_5ea7c93b496821ea = [];
  level.var_cca4e7f5433dd7d8 = 0;
  level.var_ccadf0f543480a51 = 0;
  level.var_ccadf3f5434810ea = 0;
  level.var_fc4b2bcc24f36e2a = 0;
  level.var_fc4b28cc24f36791 = 0;

  if(!level.var_cca4e7f5433dd7d8 && minutesremaining < 30) {
    level.var_cca4e7f5433dd7d8 = 1;
    scripts\cp_mp\overlord::playevent("match_remaining_30", level.players);
  }

  if(!level.var_ccadf0f543480a51 && minutesremaining < 15) {
    level.var_ccadf0f543480a51 = 1;
    scripts\cp_mp\overlord::playevent("match_remaining_15", level.players);
  }

  if(!level.var_ccadf3f5434810ea && minutesremaining < 10) {
    level.var_ccadf3f5434810ea = 1;
    scripts\cp_mp\overlord::playevent("match_remaining_10", level.players);
  }

  if(!level.var_fc4b2bcc24f36e2a && minutesremaining < 5) {
    level.var_fc4b2bcc24f36e2a = 1;
    scripts\cp_mp\overlord::playevent("match_remaining_5", level.players);
  }

  if(!level.var_fc4b28cc24f36791 && minutesremaining <= 0) {
    level.var_fc4b28cc24f36791 = 1;
    scripts\cp_mp\overlord::playevent("match_remaining_0", level.players);
  }
}

function pickclassbr() {
  return self.class;
}

function playershouldrespawn(data) {
  if(istrue(game["inLiveLobby"])) {
    return true;
  }

  return false;
}

function spawnhandled(player) {
  return istrue(player.br_infilstarted) && scripts\mp\flags::gameflag("prematch_done");
}

function playerwelcomesplashes(data) {
  self endon("disconnect");
  self waittill("spawned_player");
  wait 1;
  scripts\mp\hud_message::showsplash("br_prematch_welcome");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  wait 1;

  if(level.mapname == "<dev string:x98>" && getdvarint(@ "hash_7713e10380b6cb97", 0) == 0) {
    if(isDefined(self.plotarmor)) {
      self.plotarmor = undefined;
    }
  }

  scripts\mp\hud_message::showsplash("br_welcome");

  if(istrue(level.autoassignfirstquest) && istrue(level.br_prematchstarted)) {
    autoassignquest(self);
  }
}

function function_e283c6996bfad7ae() {
  self endon("disconnect");
  level endon("game_ended");
  scripts\mp\utility\dialog::leaderdialogonplayer("prematch_enter_mission");
  wait 3;
  scripts\mp\utility\dialog::leaderdialogonplayer("prematch_enter_gear");
}

function function_73bdf8b18e29b13f(players) {
  if(!scripts\mp\gametypes\br_gametypes::isfeaturedisabled("oneLife")) {
    setdynamicdvar(hashcat(@ "scr_", getgametype(), "_numLives"), 1);
  }

  while(!isDefined(level.players) || level.players.size == 0) {
    waitframe();
  }

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    player namespace_8bfdb6eb5a3df67a::function_334a8fe67e88bbe7();
    player thread function_8aa3182c50a3094();
  }

  startpoints = [];

  foreach(teamdata in level.teamdata) {
    if(isDefined(teamdata["startPoint"])) {
      startpoints[startpoints.size] = teamdata["startPoint"].origin;
    }
  }

  scripts\mp\ai_mp_controller::function_a767dbcb4dd41ce(startpoints);
  wait 2;
  scripts\mp\flags::gameflagset("prematch_fade_done");
  wait 2;

  foreach(player in level.players) {
    if(!isDefined(player)) {
      continue;
    }

    player thread function_927a1c74689ce55a();
  }
}

function function_daf5cd1e02931ea7(player) {
  var_2e1d1af8afe39ba8 = player getplayerdata(level.progressiongroup, "dmzPlateCarrierLevel");
  var_9a5097fe8a19dcfd = scripts\cp_mp\armor::function_1348b97715104fe2() * var_2e1d1af8afe39ba8;
  return [var_9a5097fe8a19dcfd, var_2e1d1af8afe39ba8];
}

function function_8aa3182c50a3094() {
  streampos = getspawnpoint();
  self setadditionalstreamposuntilcleared(streampos.origin);
}

function function_927a1c74689ce55a() {
  scripts\mp\gametypes\br_public::playerwaittillstreamhintcomplete();
  spawnpoint = getspawnpoint();
  spawnorigin = spawnpoint.origin;
  spawnangles = spawnpoint.angles;
  self setOrigin(spawnorigin, 1);
  self setplayerangles(spawnangles);
  namespace_8bfdb6eb5a3df67a::function_e68e4bb4f65f5fe4();
  self.plotarmor = undefined;
  self clearsoundsubmix("mp_br_lobby_fade", 1.5);
  self.var_d68b9f006bc2a1cb = 1;
}

function function_f6843e3a71516b3e() {
  self endon("disconnect");
  scripts\mp\playerlogic::spawnplayer(undefined, 0);

  if(getdvarint(@ "hash_5fa01de35b23eee0", 1) == 1) {
    timeouttime = getdvarint(@ "hash_c483c0cfe7219133", 15000);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 1, 0);
    _enableignoreme();
    self freezecontrols(1);
    self function_b88c89bb7cd1ab8e(self.origin);
    starttime = gettime();

    while(!self ispredictedstreamposready() && gettime() - starttime < timeouttime) {
      waitframe();
    }

    _disableignoreme();
    self freezecontrols(0);
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self, 0, 0.5);
  }

  self.var_d68b9f006bc2a1cb = 1;
}

function function_f38e7b13448998b4() {
  self endon("disconnect");

  if(!scripts\mp\flags::gameflag("prematch_values_reset")) {
    scripts\mp\flags::gameflagwait("prematch_values_reset");
  }

  scripts\mp\gametypes\br::brgivestartfieldupgrade();
  function_7460b890072bffbe();
  function_f09e47b124561928();
  function_f0e913c037010a9();
  function_12b9bc0f30aa8f5d();
  function_1ebd7d347b85cae3();
  scripts\mp\gametypes\br_weapons::br_ammo_update_weapons(self);

  if(getdvarint(@ "hash_4b6b3f032485abf8", 0)) {
    function_cd59d6be22c74107();
  }

  itemsonspawn = getDvar(@ "hash_65a264cd9d78ee69", "");

  if(itemsonspawn != "") {
    namespace_aead94004cf4c147::function_c2f16e2bbb4e38c0(itemsonspawn);
  }

  thread function_b68a411adf965e7f();
}

function function_cd59d6be22c74107() {
  if(isDefined(self.platecarrierlevel) && self.platecarrierlevel < 3) {
    var_347aa4935f42810 = scripts\mp\gametypes\br_public::function_c2f2bb9e0ae9a454(3);
    scripts\mp\gametypes\br_pickups::function_e98a5a4e0e001ac3(self, var_347aa4935f42810);
  }

  var_31dafc6ba15dfbc9 = namespace_aead94004cf4c147::getplayerbackpacksize(self);

  if(var_31dafc6ba15dfbc9 < 9) {
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7("brloot_backpack_large");
    namespace_a38a2e1fe7519183::function_5b7dc44bb66553a6(self);
    namespace_a38a2e1fe7519183::function_92d947129ea5ba6e(self, lootid);
    namespace_aead94004cf4c147::function_d28f52da6ede0191(self, 9, undefined, lootid);
  }

  if(!scripts\mp\gametypes\br_public::hasselfrevivetoken()) {
    scripts\mp\gametypes\br_pickups::addselfrevivetoken(1);
  }

  if(!namespace_aead94004cf4c147::function_efab78b72d131d76(self)) {
    weaponobj = scripts\mp\gametypes\br_pickups::getfullweaponobjforscriptablepartname("brloot_weapon_sm_victor_lege");
    namespace_aead94004cf4c147::function_e35a7cb7e7c8c17e(self, weaponobj, 1);
  }

  extraitems = ["brloot_valuable_car_battery", "brloot_valuable_jumper_cables", "brloot_super_oxygenmask"];

  foreach(item in extraitems) {
    backpackindex = namespace_aead94004cf4c147::getavailabledmzbackpackindex();

    if(!isDefined(backpackindex)) {
      break;
    }

    fakepickup = spawnStruct();
    fakepickup.scriptablename = item;
    fakepickup.count = 1;
    lootid = scripts\cp_mp\utility\loot::function_fae5e1d3de32d3f7(item);
    namespace_aead94004cf4c147::additemtobackpack(lootid, fakepickup);
  }
}

function function_7460b890072bffbe() {
  killstreakref = self.classstruct.loadoutkillstreak1;

  if(isDefined(killstreakref) && killstreakref != "none") {
    scripts\mp\gametypes\br_pickups::forcegivekillstreak(killstreakref, 0, 0);
  }
}

function function_62b40b6a6c2cf37a() {
  level.var_65f3f1fef64ffa68 = spawnStruct();
  level.var_f38aec9b79359af1 = getdvarint(@ "hash_1e556ff10b892938", 0) == 1;
  level.var_65f3f1fef64ffa68.perks = [];
  level.var_65f3f1fef64ffa68.perks["specialty_hustle"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_hustle");
  level.var_65f3f1fef64ffa68.perks["specialty_tac_resist"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_tac_resist");
  level.var_65f3f1fef64ffa68.perks["specialty_eod"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_eod");
  level.var_65f3f1fef64ffa68.perks["specialty_scavenger_plus"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_scavenger_plus");
  level.var_65f3f1fef64ffa68.perks["specialty_grenade_expert"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_grenade_expert");
  level.var_65f3f1fef64ffa68.perks["specialty_focus"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_focus");
  level.var_65f3f1fef64ffa68.perks["specialty_warhead"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_warhead");
  level.var_65f3f1fef64ffa68.perks["specialty_covert_ops"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_covert_ops");
  level.var_65f3f1fef64ffa68.perks["specialty_quick_fix"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_quick_fix");
  level.var_65f3f1fef64ffa68.perks["specialty_guerrilla"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_guerrilla");
  level.var_65f3f1fef64ffa68.perks["specialty_tactical_recon"] = scripts\cp_mp\utility\loot::getlootidfromref("specialty_tactical_recon");
  level.var_65f3f1fef64ffa68.var_21832626a15c50da = [];
  level.var_65f3f1fef64ffa68.var_21832626a15c50da[0] = [level.var_65f3f1fef64ffa68.perks["specialty_hustle"], level.var_65f3f1fef64ffa68.perks["specialty_tac_resist"], level.var_65f3f1fef64ffa68.perks["specialty_eod"], level.var_65f3f1fef64ffa68.perks["specialty_scavenger_plus"], level.var_65f3f1fef64ffa68.perks["specialty_grenade_expert"]];
  level.var_65f3f1fef64ffa68.var_21832626a15c50da[1] = [level.var_65f3f1fef64ffa68.perks["specialty_focus"], level.var_65f3f1fef64ffa68.perks["specialty_warhead"], level.var_65f3f1fef64ffa68.perks["specialty_covert_ops"]];
  level.var_65f3f1fef64ffa68.var_21832626a15c50da[2] = [level.var_65f3f1fef64ffa68.perks["specialty_quick_fix"], level.var_65f3f1fef64ffa68.perks["specialty_guerrilla"], level.var_65f3f1fef64ffa68.perks["specialty_tactical_recon"]];
}

function function_53109b63a7168074() {
  currentstreak = self getplayerdata(level.progressiongroup, "currentStreakCount");
  beststreak = self getplayerdata(level.progressiongroup, "bestStreakCount");

  if(!function_61f9109d0eb76f19()) {
    self setplayerdata(level.progressiongroup, "currentStreakGainedProgress", 0);
    self setplayerdata(level.progressiongroup, "bestStreakGainedProgress", 0);
    return;
  }

  newstreak = currentstreak + 1;
  self setplayerdata(level.progressiongroup, "currentStreakGainedProgress", 1);
  self setplayerdata(level.progressiongroup, "currentStreakCount", newstreak);

  if(newstreak > beststreak) {
    self setplayerdata(level.progressiongroup, "bestStreakGainedProgress", 1);
    self setplayerdata(level.progressiongroup, "bestStreakCount", newstreak);
  } else {
    self setplayerdata(level.progressiongroup, "bestStreakGainedProgress", 0);
  }

  var_203eac7388d590a9 = int(tablelookupbyrow("mp/dmz_streakrewards.csv", newstreak + 1, 1));
  newperk = undefined;

  if(isDefined(level.var_65f3f1fef64ffa68.var_21832626a15c50da[var_203eac7388d590a9])) {
    var_e59eccd90c6407da = [];
    var_df9fb2cbd434f334 = undefined;

    for(i = 0; i < 10; i++) {
      lootid = self getplayerdata(level.progressiongroup, "DMZExfilPerkStreak", i, "lootID");

      if(lootid != 0) {
        var_e59eccd90c6407da[var_e59eccd90c6407da.size] = lootid;
        continue;
      }

      if(!isDefined(var_df9fb2cbd434f334)) {
        var_df9fb2cbd434f334 = i;
      }
    }

    if(isDefined(var_df9fb2cbd434f334) && var_e59eccd90c6407da.size < level.var_65f3f1fef64ffa68.perks.size) {
      perks = array_randomize(level.var_65f3f1fef64ffa68.var_21832626a15c50da[var_203eac7388d590a9]);

      foreach(perklootid in perks) {
        if(!array_contains(var_e59eccd90c6407da, perklootid)) {
          self setplayerdata(level.progressiongroup, "DMZExfilPerkStreak", var_df9fb2cbd434f334, "lootID", perklootid);
          newperk = perklootid;
          break;
        }
      }
    }
  }

  if(isDefined(newperk)) {
    namespace_a38a2e1fe7519183::function_80a3ed28ed1b33a1(self, newstreak, newperk);
  }
}

function function_470b4aaafd986a0d(player) {
  if(!namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    return;
  }

  player setplayerdata(level.progressiongroup, "currentStreakGainedProgress", 0);
  player setplayerdata(level.progressiongroup, "bestStreakGainedProgress", 0);
  [streak, perks] = namespace_a38a2e1fe7519183::function_1558f8fb859c492a(player);

  if(streak > 0) {
    player setplayerdata(level.progressiongroup, "currentStreakCount", streak);
    perkindex = 0;

    foreach(perklootid in perks) {
      if(perklootid != 0) {
        player setplayerdata(level.progressiongroup, "DMZExfilPerkStreak", perkindex, "lootID", perklootid);
        perkindex++;
      }
    }

    return;
  }

  function_1a425272955d5f75();
}

function function_f0e913c037010a9() {
  perklootids = [];

  for(i = 0; i < 10; i++) {
    lootid = self getplayerdata(level.progressiongroup, "DMZExfilPerkStreak", i, "lootID");

    if(lootid != 0) {
      perklootids[perklootids.size] = lootid;
    }
  }

  if(level.var_f38aec9b79359af1) {
    foreach(lootid in perklootids) {
      perk = scripts\cp_mp\utility\loot::function_793e8a72cedb8ef3(lootid);
      scripts\mp\utility\perk::giveperk(perk);
    }
  }
}

function function_1ebd7d347b85cae3() {
  player = self;
  player.var_a6dd5c7e74106ce3 = [];

  if(!getdvarint(@ "hash_3d25f67e59d61b96", 1)) {
    return;
  }

  foreach(weapon in player.equippedweapons) {
    equipmentref = scripts\mp\equipment::getequipmentreffromweapon(weapon);

    if(!isDefined(equipmentref) || !isDefined(weapon.weaponblueprint) || !isDefined(weapon.variantid)) {
      continue;
    }

    slot = scripts\mp\equipment::findequipmentslot(equipmentref);
    currentammo = scripts\mp\equipment::getequipmentslotammo(slot);
    scripts\mp\equipment::takeequipment(slot);
    scripts\mp\equipment::giveequipment(equipmentref, slot, undefined, weapon.variantid);
    player.var_a6dd5c7e74106ce3[equipmentref] = weapon.variantid;
  }

  if(getdvarint(@ "hash_4106b1f86a235e22", 0)) {
    slot = scripts\mp\equipment::findequipmentslot("<dev string:xab>");
    currentammo = scripts\mp\equipment::getequipmentslotammo(slot);
    scripts\mp\equipment::takeequipment(slot);
    scripts\mp\equipment::giveequipment("<dev string:xab>", slot, 1);
    player.var_a6dd5c7e74106ce3["<dev string:xab>"] = 1;
  }
}

function function_12b9bc0f30aa8f5d() {
  if(!istrue(level.var_7f3aafcf56c9ce14) || !isDefined(self.var_4045f099f3da4bd)) {
    return;
  }

  scripts\mp\gametypes\br_pickups::function_6523c0535fdb1f1f(self, self.var_4045f099f3da4bd);
}

function function_1a425272955d5f75() {
  if(istrue(self.extracted)) {
    return;
  }

  self setplayerdata(level.progressiongroup, "currentStreakGainedProgress", 0);
  self setplayerdata(level.progressiongroup, "currentStreakCount", 0);
  self setplayerdata(level.progressiongroup, "bestStreakGainedProgress", 0);

  for(i = 0; i < 10; i++) {
    self setplayerdata(level.progressiongroup, "DMZExfilPerkStreak", i, "lootID", 0);
  }
}

function function_61f9109d0eb76f19() {
  if(level.mapname == "mp_bio_lab" || level.mapname == "mp_biobunker") {
    return true;
  }

  return istrue(self.brmissionscompleted);
}

function function_1be19e52e991d817(player) {
  player notify("overlord_extraction_streak");
  player endon("overlord_extraction_streak");
  player endon("last_stand_start");
  player endon("death");
  player endon("disconnect");
  level endon("game_ended");
  wait getdvarint(@ "hash_12db8f9058061d1b", 10);
  function_adf1fe22b2cd5bd2(player);
}

function function_adf1fe22b2cd5bd2(player) {
  if(!isDefined(player) || !isreallyalive(player)) {
    return;
  }

  if(istrue(player.var_496a6ea8cb39cd1d)) {
    return;
  }

  currentstreak = player getplayerdata(level.progressiongroup, "currentStreakCount");

  if(getdvarint(@ "hash_1ec9ac9ef82212cc", 0) > 0) {
    currentstreak = getdvarint(@ "hash_1ec9ac9ef82212cc", 0);
  }

  if(isDefined(currentstreak) && currentstreak >= getdvarint(@ "hash_f5ffdc69acc2ed9e", 2)) {
    scripts\cp_mp\overlord::playevent("streak_reminder", [player]);
    player.var_496a6ea8cb39cd1d = 1;
  }
}

function function_b68a411adf965e7f() {
  level endon("game_ended");

  if(!isDefined(self.team)) {
    return;
  }

  if(!isDefined(level.var_538b75512b4726a8)) {
    level.var_538b75512b4726a8 = [];
  }

  var_e1b5345b16363c30 = self.team;

  if(istrue(level.var_538b75512b4726a8[var_e1b5345b16363c30])) {
    return;
  }

  if(!isDefined(level.var_538b75512b4726a8[var_e1b5345b16363c30])) {
    level.var_538b75512b4726a8[var_e1b5345b16363c30] = 1;
  }

  wait 120;

  while(true) {
    alivecount = getteamdata(var_e1b5345b16363c30, "aliveCount");

    if(!isDefined(alivecount) || alivecount <= 0) {
      return;
    }

    players = getteamdata(var_e1b5345b16363c30, "players");

    if(!isDefined(players) || players.size <= 1) {
      wait getdvarint(@ "hash_69b4eb1d49243c68", 120);
      continue;
    }

    aliveplayers = [];

    foreach(player in players) {
      if(isreallyalive(player)) {
        aliveplayers[aliveplayers.size] = player;
      }
    }

    if(aliveplayers.size <= 1) {
      wait getdvarint(@ "hash_69b4eb1d49243c68", 120);
      continue;
    }

    var_c4b81997f0120a97 = undefined;

    foreach(player in aliveplayers) {
      if(!isDefined(var_c4b81997f0120a97)) {
        var_c4b81997f0120a97 = player;
        continue;
      }

      dist = distance2d(player.origin, var_c4b81997f0120a97.origin);

      if(dist >= getdvarint(@ "hash_f49edd0604d1e232", 7500)) {
        scripts\cp_mp\overlord::playevent("teammates_far_away_nag", aliveplayers);
        break;
      }
    }

    wait getdvarint(@ "hash_69b4eb1d49243c68", 120);
  }
}

function getdefaultweaponammo(weapon, maxammo) {
  ammotype = scripts\mp\gametypes\br_weapons::br_ammo_type_for_weapon(weapon);
  maxdropcount = 100;

  if(isDefined(ammotype) && isDefined(level.br_pickups.counts[ammotype])) {
    maxdropcount = level.br_pickups.counts[ammotype];
  }

  var_28aebe3dd6733ed3 = ter_op(weaponclipsize(weapon) < maxdropcount || istrue(maxammo), weaponclipsize(weapon), maxdropcount);
  var_961012dd15fa29ee = 0;

  if(weapon.hasalternate) {
    var_5d9b5b689a1846c8 = weapon getaltweapon();
    var_961012dd15fa29ee = ter_op(weaponclipsize(var_5d9b5b689a1846c8) < maxdropcount || istrue(maxammo), weaponclipsize(var_5d9b5b689a1846c8), maxdropcount);
  }

  return [var_28aebe3dd6733ed3, var_28aebe3dd6733ed3, var_961012dd15fa29ee];
}

function showdmzsplash(splash, playerlist, poiname, optionalnumber, playerforplayercard, splashlistoverride) {
  temp = level.var_cc9e990b6e83975b;
  level.var_cc9e990b6e83975b = 0;

  foreach(player in playerlist) {
    if(isPlayer(player)) {
      player setclientomnvar("ui_dmz_poi_name", scripts\mp\poi::function_80cdaea4bd3ecf70(poiname));
      player thread scripts\mp\hud_message::showsplash(splash, optionalnumber, playerforplayercard, undefined, 1, splashlistoverride);
    }
  }

  level.var_cc9e990b6e83975b = temp;
}

function function_f7920586b5a59226() {
  while(true) {
    type = getdvarint(@ "hash_aa489f8b09e8c2a3", 0);

    if(type) {
      setDvar(@ "hash_aa489f8b09e8c2a3", 0);
      poiname = undefined;

      if(scripts\mp\poi::poi_issystemactive()) {
        poiname = scripts\mp\poi::poi_findpoioriginisin(level.players[0].origin, 1);
      }

      splash = undefined;

      switch (type) {
        case 2:
          splash = "<dev string:xb9>";
          break;
        case 3:
          splash = "<dev string:xda>";
          break;
        case 4:
          splash = "<dev string:xfb>";
          break;
        case 5:
          splash = "<dev string:x11c>";
          break;
        default:
          splash = "<dev string:x13d>";
          break;
      }

      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash(splash, level.players, poiname);
    }

    wait 1;
  }
}

function function_2ff493cd8ff03634() {
  while(true) {
    type = getdvarint(@ "hash_4febbe2aa9ddab48", 0);

    if(type) {
      setDvar(@ "hash_4febbe2aa9ddab48", 0);
      splash = "<dev string:x15c>";
      poiname = undefined;

      if(type == 2) {
        splash = "<dev string:x171>";
      }

      if(type == 3) {
        splash = "<dev string:x18c>";
      }

      if(type == 4) {
        splash = "<dev string:x1a2>";
      }

      if(type == 5) {
        splash = "<dev string:x1bd>";
      }

      poiname = "<dev string:x1d6>";

      if(type == 6) {
        splash = "<dev string:x1e4>";
      }

      poiname = "<dev string:x1d6>";

      if(type == 7) {
        splash = "<dev string:x1ff>";
      }

      if(type == 8) {
        combineddata = 2 | 48;
        splash = "<dev string:x221>";
        level.var_cc9e990b6e83975b = 0;
        level.players[0] scripts\mp\hud_message::showsplash(splash, combineddata, undefined, undefined, 1);
        level.var_cc9e990b6e83975b = 1;
        continue;
      }

      if(type == 9) {
        splash = "<dev string:x241>";
      }

      if(type == 10) {
        splash = "<dev string:x260>";
      }

      scripts\mp\gametypes\br_gametype_dmz::showdmzsplash(splash, level.players, poiname);
    }

    state = getdvarint(@ "hash_6d5dafa13d3a8b94", -1);

    if(state != -1) {
      setDvar(@ "hash_6d5dafa13d3a8b94", -1);
      level.players[0] setclientomnvar("<dev string:x27c>", state);
    }

    state = getdvarint(@ "hash_5e0729bf2d69d066", 0);

    if(state) {
      setDvar(@ "hash_5e0729bf2d69d066", 0);
      level.players[0] setclientomnvar("<dev string:x2a1>", 1);
    }

    wait 1;
  }
}

function function_f917fde1df9c5506() {
  while(true) {
    if(getdvarint(@ "hash_44bd790b3a453d80", 0) == 1) {
      setDvar(@ "hash_44bd790b3a453d80", 0);
      namespace_25b25d188ef778c4::exfilplayers(level.players);
    }

    if(getdvarint(@ "hash_84a792cec0ba5b7c", 0) == 1) {
      var_27964dbaca1842f0 = [];
      setDvar(@ "hash_84a792cec0ba5b7c", 0);

      foreach(team in level.teamnamelist) {
        players = level.teamdata[team]["<dev string:x2bf>"];

        if(isDefined(players)) {
          targetplayer = players[0];

          foreach(player in players) {
            if(isDefined(player) && isreallyalive(player) && !istrue(player.extracted)) {
              targetplayer = player;

              if(getdvarint(@ "hash_533162a7d43f948f", 0) == 1) {
                break;
              }
            }
          }

          var_27964dbaca1842f0[var_27964dbaca1842f0.size] = targetplayer;
        }
      }

      namespace_25b25d188ef778c4::exfilplayers(var_27964dbaca1842f0);
    }

    if(getdvarint(@ "hash_31f19312965b3b78", 0) == 1) {
      setDvar(@ "hash_31f19312965b3b78", 0);
      level.players[0] namespace_25b25d188ef778c4::function_7ff5e35e992df372();
    }

    wait 1;
  }
}

function function_459e2558e6d936ed() {
  while(true) {
    if(getdvarint(@ "hash_b72ce628db69ef4b", 0)) {
      setDvar(@ "hash_b72ce628db69ef4b", 0);
      restock = spawnscriptable("<dev string:x2ca>", level.players[0].origin, level.players[0].angles);
    }

    if(getdvarint(@ "hash_edc010da9e9d687b", 0)) {
      setDvar(@ "hash_edc010da9e9d687b", 0);
      cache = spawnscriptable("<dev string:x2e9>", level.players[0].origin, level.players[0].angles);
      cache setscriptablepartstate("<dev string:x308>", "<dev string:x310>");
    }

    if(getdvarint(@ "hash_25f4358ca3b846e3", 0)) {
      setDvar(@ "hash_25f4358ca3b846e3", 0);
      cache = spawnscriptable("<dev string:x321>", level.players[0].origin, level.players[0].angles);
      cache setscriptablepartstate("<dev string:x308>", "<dev string:x310>");
    }

    if(getdvarint(@ "hash_8ca28a9d28344f", 0)) {
      setDvar(@ "hash_8ca28a9d28344f", 0);
      laptop = spawnscriptable("<dev string:x340>", level.players[0].origin, level.players[0].angles);
      harddrive = spawnscriptable("<dev string:x354>", level.players[0].origin, level.players[0].angles);
      laptop.harddrive = harddrive;
    }

    waitframe();
  }
}

function function_dc98aeb4dd4b727a() {
  while(true) {
    if(getdvarint(@ "hash_f2cfce8dc99e0fd4", 0)) {
      setDvar(@ "hash_f2cfce8dc99e0fd4", 0);
      hostage = spawnscriptable("<dev string:x36b>", level.players[0].origin, level.players[0].angles);
      hostage setscriptablepartstate("<dev string:x36b>", "<dev string:x37a>");

      for(i = 0; i < 5; i++) {
        plate = spawnscriptable("<dev string:x384>", level.players[0].origin + 32 * function_6174330574a2a273(), level.players[0].angles);
        plate setscriptablepartstate("<dev string:x384>", "<dev string:x39a>");
      }
    }

    if(getdvarint(@ "hash_db675935826560a", 0)) {
      setDvar(@ "hash_db675935826560a", 0);
      spawnscriptable("<dev string:x3a4>", level.players[0].origin, level.players[0].angles);

      for(i = 0; i < 5; i++) {
        plate = spawnscriptable("<dev string:x384>", level.players[0].origin + 32 * function_6174330574a2a273(), level.players[0].angles);
        plate setscriptablepartstate("<dev string:x384>", "<dev string:x39a>");
      }
    }

    waitframe();
  }
}

function function_37eaf2bc0bb3e28a() {
  while(!getdvarint(@ "hash_cd6f9528a14b2504", 0) || !isDefined(level.var_1b7407dffe81e6e8) || !isDefined(level.var_1b7407dffe81e6e8.spawndatamap)) {
    wait 1;
  }

  nodes = [];

  foreach(name, data in level.var_1b7407dffe81e6e8.spawndatamap) {
    if(name == "<dev string:x3b9>") {
      nodes[name] = namespace_5ffce5a43b2d1ec2::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x3c1>") {
      nodes[name] = namespace_e1bfa87a2a692d3c::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x3c8>") {
      nodes[name] = namespace_4f4cbea0f5b0bdb8::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x3d2>") {
      nodes[name] = namespace_300f9f7dca7fc109::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x3da>") {
      nodes[name] = namespace_b11859036e02907d::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x3e2>") {
      nodes[name] = namespace_fa9fd40f68ab8478::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x3eb>") {
      nodes[name] = namespace_b8c00f1eafbbd213::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x3f3>") {
      nodes[name] = namespace_30baceecda213256::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x3fa>") {
      nodes[name] = namespace_232aeaeb467df5bd::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x405>") {
      nodes[name] = namespace_38da3c68826ceb02::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x40d>") {
      nodes[name] = namespace_168c086126cfa488::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x41d>") {
      nodes[name] = namespace_d0483bb41cd4e112::function_a07f7c4c0c4ef8e3();
    }

    if(name == "<dev string:x42a>") {
      nodes[name] = namespace_210d6dd43cfaf195::function_a07f7c4c0c4ef8e3();
    }
  }

  nodes["<dev string:x43a>"] = getStructArray("<dev string:x43a>", "<dev string:x447>");
  nodes["<dev string:x455>"] = getStructArray("<dev string:x460>", "<dev string:x447>");
  nodes["<dev string:x405>"] = getStructArray("<dev string:x46f>", "<dev string:x47b>");
  nodes["<dev string:x490>"] = getStructArray("<dev string:x490>", "<dev string:x447>");
  nodes["<dev string:x49f>"] = getStructArray("<dev string:x4b4>", "<dev string:x447>");
  nodes["<dev string:x4cc>"] = getStructArray("<dev string:x4de>", "<dev string:x47b>");
  nodes["<dev string:x4f3>"] = getStructArray("<dev string:x4f3>", "<dev string:x47b>");
  nodes["<dev string:x509>"] = getStructArray("<dev string:x509>", "<dev string:x47b>");
  nodes["<dev string:x51e>"] = getStructArray("<dev string:x51e>", "<dev string:x47b>");
  nodes["<dev string:x539>"] = getStructArray("<dev string:x539>", "<dev string:x47b>");
  nodes["<dev string:x554>"] = getStructArray("<dev string:x554>", "<dev string:x47b>");
  nodes["<dev string:x573>"] = getStructArray("<dev string:x573>", "<dev string:x47b>");
  nodes["<dev string:x58c>"] = getStructArray("<dev string:x58c>", "<dev string:x47b>");
  nodes["<dev string:x5a9>"] = getentitylessscriptablearray("<dev string:x5b6>", "<dev string:x5d2>");

  while(true) {
    dvar = getDvar(@ "hash_5d80cf4f5ced4150", "<dev string:x5df>");

    if(dvar != "<dev string:x5df>") {
      if(isDefined(nodes[dvar])) {
        foreach(node in nodes[dvar]) {
          if(distance2dsquared(level.players[0].origin, node.origin) < 100000000) {
            sphere(node.origin, 50, (1, 0, 0), 0, 1);
          }
        }
      }
    }

    waitframe();
  }
}

function function_b0d036699b334631() {
  while(true) {
    if(getdvarint(@ "hash_8aae452771dc0496", 0)) {
      setDvar(@ "hash_8aae452771dc0496", 0);

      foreach(player in level.players) {
        if(isbot(player)) {
          namespace_aead94004cf4c147::function_8107fe0feec27866(player, level.players[0].primaryweapons[0]);
        }
      }
    }

    waitframe();
  }
}

function function_e1fa80f536692a32() {
  while(true) {
    dvar = getDvar(@ "hash_911645dd41a57d5d", "");

    if(isDefined(dvar) && dvar != "") {
      setDvar(@ "hash_911645dd41a57d5d", "");
      item = spawnscriptable(dvar, level.players[0].origin, level.players[0].angles);

      if(isDefined(item)) {
        scripts\mp\gametypes\br_pickups::registerscriptableinstance(item);
      }
    }

    if(getdvarint(@ "hash_77012bc5215f715e", 0)) {
      setDvar(@ "hash_77012bc5215f715e", 0);
      items = getentitylessscriptablearray(undefined, undefined, undefined, undefined, "brloot_black_mous_intel");

      printtoscreen2d(50, 50, "<dev string:x5e7>" + items.size);

      level.players[0] setOrigin(items[0].origin);
    }

    waitframe();
  }
}

function function_b9abf4fc2d1f7fcd(revivespawn) {}

function function_181a43d54c23236() {
  if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    return false;
  }

  if(scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1()) {
    return false;
  }

  return true;
}

function function_dbe369af1abc2991() {
  level.var_a06b389554958a4a = 1;
}

function function_4e5ca94d32370a5a() {
  return istrue(level.var_a06b389554958a4a);
}

function function_63a938bfc7ba5c2b(nodes) {
  startpoints = spawnStruct();
  startpoints.points = [];
  startpoints.var_f700d2836aab75a4 = [];
  startpoints.var_f700d2836aab75a4[0] = [];
  startpoints.var_f700d2836aab75a4[1] = [];
  startpoints.var_f700d2836aab75a4[2] = [];
  startpoints.var_f700d2836aab75a4[3] = [];

  if(!function_4e5ca94d32370a5a()) {
    randomizednodes = array_randomize(nodes);
  } else {
    randomizednodes = nodes;
  }

  foreach(node in randomizednodes) {
    if(isDefined(level.var_ab20b3a256911579) && level.var_e5993849fc7d5987 == 0 && (!isDefined(node.poi) || array_contains(level.var_ab20b3a256911579, node.poi)) && scripts\mp\poi::function_7e9cbc0f32de6578()) {
      continue;
    }

    startpoint = spawnStruct();
    startpoint.poi = node.poi;
    startpoint.origin = node.origin;
    startpoint.angles = node.angles;
    startpoint.team = undefined;

    if(isDefined(node.target)) {
      startpoint.target = node.target;
    }

    if(isDefined(node.script_label)) {
      startpoint.script_label = node.script_label;
    }

    if(isDefined(node.var_78c002be5bc09aea)) {
      startpoint.var_78c002be5bc09aea = int(node.var_78c002be5bc09aea);
      startpoints.points[startpoint.var_78c002be5bc09aea] = startpoint;
      continue;
    }

    startpoints.points[startpoints.points.size] = startpoint;
  }

  level.var_c137999ba28087df = 0;
  startpoints.var_f700d2836aab75a4[0] = startpoints.points;
  startpoints.var_f700d2836aab75a4[1] = startpoints.points;
  startpoints.var_f700d2836aab75a4[2] = startpoints.points;
  startpoints.var_f700d2836aab75a4[3] = startpoints.points;
  return startpoints;
}

function function_7eb9b366e7ee262e() {
  if(scripts\cp_mp\utility\game_utility::function_7ee65fae13124702()) {
    return "mp/dmz_spawnpoints.csv";
  }

  if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    return "mp/dmz_sealion_spawnpoints.csv";
  }

  if(scripts\cp_mp\utility\game_utility::function_5e0e3a24dbb1fae1()) {
    return "mp/dmz_delta_spawnpoints.csv";
  }

  return "mp/dmz_spawnpoints.csv";
}

function function_effb4f29bf72a97b(targetnoteworthy) {
  startpoints = spawnStruct();
  startpoints.points = [];
  startpoints.var_f700d2836aab75a4 = [];
  startpoints.var_f700d2836aab75a4[0] = [];
  startpoints.var_f700d2836aab75a4[1] = [];
  startpoints.var_f700d2836aab75a4[2] = [];
  startpoints.var_f700d2836aab75a4[3] = [];
  spawnpointsmap = getStructArray(targetnoteworthy, "script_noteworthy");
  var_d159d4c99e9374bd = [];

  foreach(point in spawnpointsmap) {
    if(isDefined(point.script_label) && point.script_label != "") {
      var_d159d4c99e9374bd[point.script_label] = point;
    }
  }

  spawnpointcsv = function_7eb9b366e7ee262e();
  rownum = tablelookupgetnumrows(spawnpointcsv);
  spawnrow = 0;

  for(rowindex = 0; rowindex < rownum; rowindex++) {
    poi = tablelookupbyrow(spawnpointcsv, rowindex, 0);

    if(isDefined(level.var_ab20b3a256911579) && level.var_e5993849fc7d5987 == 0 && (!isDefined(poi) || array_contains(level.var_ab20b3a256911579, poi)) && scripts\mp\poi::function_7e9cbc0f32de6578()) {
      continue;
    }

    noteworthy = tablelookupbyrow(spawnpointcsv, rowindex, 5);

    if(noteworthy != targetnoteworthy) {
      continue;
    }

    scriptlabel = tablelookupbyrow(spawnpointcsv, rowindex, 14);

    if(!isDefined(scriptlabel) || scriptlabel == "") {
      continue;
    }

    if(!isDefined(var_d159d4c99e9374bd[scriptlabel])) {
      continue;
    }

    point = var_d159d4c99e9374bd[scriptlabel];
    startpoint = spawnStruct();
    startpoint.poi = ter_op(isDefined(point.poi), point.poi, "");
    startpoint.origin = point.origin;
    startpoint.angles = ter_op(isDefined(point.angles), point.angles, (0, 0, 0));
    startpoint.team = undefined;

    if(isDefined(point.target)) {
      startpoint.target = point.target;
    }

    if(isDefined(point.script_label)) {
      startpoint.script_label = point.script_label;
    }

    startpoints.points[startpoints.points.size] = startpoint;
  }

  level.var_c137999ba28087df = 0;

  foreach(point in startpoints.points) {
    index = ter_op(point.origin[0] < 0, -1, 0) + ter_op(point.origin[1] < 0, 3, 1);

    if(level.disabledquads[index] != 0) {
      continue;
    }

    startpoints.var_f700d2836aab75a4[index][startpoints.var_f700d2836aab75a4[index].size] = point;
  }

  var_3bafc217f6706130 = function_47fd8fcdf90b0e() & 65535;
  previousval = var_3bafc217f6706130;

  for(i = 0; i < startpoints.var_f700d2836aab75a4.size; i++) {
    previousval = (previousval * 29 + 19) % 65535;
    randval = previousval % startpoints.var_f700d2836aab75a4.size;
    tmp = startpoints.var_f700d2836aab75a4[i];
    startpoints.var_f700d2836aab75a4[i] = startpoints.var_f700d2836aab75a4[randval];
    startpoints.var_f700d2836aab75a4[randval] = tmp;
  }

  var_3bafc217f6706130 = function_47fd8fcdf90b0e() & 65535;
  previousval = var_3bafc217f6706130;

  foreach(index, quad in startpoints.var_f700d2836aab75a4) {
    for(i = 0; i < quad.size; i++) {
      previousval = (previousval * 29 + 19) % 65535;
      randval = previousval % quad.size;
      tmp = quad[i];
      quad[i] = quad[randval];
      quad[randval] = tmp;
    }

    startpoints.var_f700d2836aab75a4[index] = quad;
  }

  println("<dev string:x5f7>" + var_3bafc217f6706130);
  return startpoints;
}

function initstartpoints() {
  level.spawnheight = getdvarfloat(@ "hash_1cdb6b91e9c4a104", 1);
  level.disabledquads = [getdvarint(@ "hash_3ec0c24faa920e9d", 0), getdvarint(@ "hash_3ec0d04faa922d67", 0), getdvarint(@ "hash_3ef9c24faad08988", 0), getdvarint(@ "hash_3ef9b44faad06abe", 0)];
  activequads = 0;

  foreach(quad in level.disabledquads) {
    if(quad == 0) {
      activequads++;
    }
  }

  level.var_68aaa2c8668cc4fb = activequads;
  level.startpoints = [];

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  primary = [];

  if(function_181a43d54c23236() && !isDefined(level.var_744dfabb8f946331)) {
    primary = getStructArray("dmz_squadSpawnPoint_GLOuterEdge1", "script_noteworthy");
  }

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
    } else if(isDefined(level.var_744dfabb8f946331)) {
      primary = [[level.var_744dfabb8f946331]]();
    }
  }

  if(primary.size == 0 && !function_181a43d54c23236()) {
    level.startpoints[0] = function_effb4f29bf72a97b("dmz_squadSpawnPoint_GLOuterEdge1");
  } else {
    level.startpoints[0] = function_63a938bfc7ba5c2b(primary);
    level.var_68aaa2c8668cc4fb = 4;
  }

  if(function_181a43d54c23236()) {
    level.startpoints[1] = function_63a938bfc7ba5c2b(getStructArray("dmz_squadSpawnPoint_GLOuterEdge2", "script_noteworthy"));
  } else {
    level.startpoints[1] = function_effb4f29bf72a97b("dmz_squadSpawnPoint_GLOuterEdge2");
  }

  level.var_41bf3dea04371564 = [];
}

function getspawnpoint() {
  teamindex = 0;

  foreach(index, team in level.allteamnamelist) {
    if(team == self.sessionteam) {
      teamindex = index;
      break;
    }
  }

  if(!isDefined(level.startpoints)) {
    initstartpoints();
  }

  overridespawnpoint = undefined;

  if(isDefined(level.var_98ae8dc756286aca)) {
    overridespawnpoint = self[[level.var_98ae8dc756286aca]](level.startpoints[0].var_f700d2836aab75a4);
  }

  spawnpointindex = undefined;

  if(!isDefined(overridespawnpoint)) {
    spawnpointindex = int(floor(teamindex / level.var_68aaa2c8668cc4fb));
  }

  quadindex = int(teamindex % level.var_68aaa2c8668cc4fb);

  if(!isDefined(self.team) || !isDefined(level.teamdata) || !isDefined(level.teamdata[self.team])) {
    point = undefined;

    if(isDefined(overridespawnpoint)) {
      point = overridespawnpoint;
    } else if(isDefined(level.startpoints[0].var_f700d2836aab75a4[quadindex][spawnpointindex])) {
      point = level.startpoints[0].var_f700d2836aab75a4[quadindex][spawnpointindex];
    } else if(isDefined(level.startpoints[1].var_f700d2836aab75a4[quadindex][spawnpointindex - level.startpoints[0].var_f700d2836aab75a4[quadindex].size + 1])) {
      point = level.startpoints[1].var_f700d2836aab75a4[quadindex][spawnpointindex];
    }

    if(!isDefined(point)) {
      point = spawnStruct();
      point.origin = (0, 0, 0);
    }

    println("<dev string:x60c>" + self.name);
    println("<dev string:x61d>" + self.sessionteam);
    println("<dev string:x642>" + "<dev string:x658>" + point.origin[0] + "<dev string:x65e>" + point.origin[1] + "<dev string:x65e>" + point.origin[2] + "<dev string:x664>");

    spawnpoint = spawnStruct();
    spawnpoint.origin = point.origin;
    spawnpoint.angles = ter_op(isDefined(point.angles), point.angles, (0, 0, 0));
    spawnpoint.time = gettime();
    spawnpoint.team = undefined;
    spawnpoint.index = -1;
    spawnpoint.lifeid = self.lifeid;
    return spawnpoint;
  }

  fallbackspawns = [];

  if(!isDefined(level.teamdata[self.team]["startPoint"])) {
    startquad = level.var_c137999ba28087df;
    var_7f6ed4bcf0db77db = 0;

    if(isDefined(overridespawnpoint)) {
      startpoint = overridespawnpoint;
      level.teamdata[self.team]["startPoint"] = startpoint;
      startpoint.team = self.team;
    } else if(isDefined(level.startpoints[0].var_f700d2836aab75a4[quadindex][spawnpointindex]) && !isDefined(level.startpoints[0].var_f700d2836aab75a4[quadindex][spawnpointindex].team)) {
      startpoint = level.startpoints[0].var_f700d2836aab75a4[quadindex][spawnpointindex];
      level.teamdata[self.team]["startPoint"] = startpoint;
      startpoint.team = self.team;
    } else if(isDefined(level.startpoints[1].var_f700d2836aab75a4[quadindex][spawnpointindex - level.startpoints[0].var_f700d2836aab75a4[quadindex].size + 1]) && !isDefined(level.startpoints[1].var_f700d2836aab75a4[quadindex][spawnpointindex - level.startpoints[0].var_f700d2836aab75a4[quadindex].size + 1].team)) {
      startpoint = level.startpoints[1].var_f700d2836aab75a4[quadindex][spawnpointindex - level.startpoints[0].var_f700d2836aab75a4[quadindex].size + 1];
      level.teamdata[self.team]["startPoint"] = startpoint;
      startpoint.team = self.team;
    } else {
      while(!isDefined(level.teamdata[self.team]["startPoint"]) && var_7f6ed4bcf0db77db < level.startpoints.size) {
        foreach(startpoint in level.startpoints[var_7f6ed4bcf0db77db].var_f700d2836aab75a4[level.var_c137999ba28087df]) {
          if(isDefined(startpoint.team)) {
            continue;
          }

          level.teamdata[self.team]["startPoint"] = startpoint;
          startpoint.team = self.team;
          break;
        }

        level.var_c137999ba28087df++;

        if(level.var_c137999ba28087df > 3) {
          level.var_c137999ba28087df = 0;
        }

        if(startquad == level.var_c137999ba28087df) {
          var_7f6ed4bcf0db77db++;
        }
      }
    }

    if(isDefined(self.team)) {
      namespace_d1a9ca87d78d9813::function_9533653868e59fb6("<dev string:x66a>", self.team, undefined, undefined, undefined, undefined, level.teamdata[self.team]["<dev string:x673>"].poi, level.teamdata[self.team]["<dev string:x673>"].origin);
    }
  }

  assertex(isDefined(level.teamdata[self.team]["<dev string:x673>"]), "<dev string:x681>");
  spawnorigin = level.teamdata[self.team]["startPoint"].origin;
  spawnangles = level.teamdata[self.team]["startPoint"].angles;
  selfindex = array_find(level.teamdata[self.team]["players"], self);

  if(isDefined(selfindex)) {
    if(isDefined(level.var_fc458ddec84c95a0)) {
      point = [[level.var_fc458ddec84c95a0]](level.teamdata[self.team]["startPoint"], selfindex);

      if(isDefined(point)) {
        spawnorigin = point.origin;
        spawnangles = point.angles;
      }
    } else {
      spawnorigin += function_9ec9c03926f7b11c(selfindex, level.maxteamsize);
    }
  }

  if(!isDefined(level.teamdata[self.team]["startPoint"].script_label) || level.teamdata[self.team]["startPoint"].script_label != "InteriorSpawnPoint") {
    tracecontents = scripts\engine\trace::create_default_contents(1);
    result = scripts\engine\trace::ray_trace(spawnorigin + (0, 0, 10000), spawnorigin - (0, 0, 20000), undefined, tracecontents)["position"];
    spawnorigin = (spawnorigin[0], spawnorigin[1], result[2] + level.spawnheight);
  }

  spawnpoint = spawnStruct();
  spawnpoint.origin = spawnorigin;
  spawnpoint.angles = ter_op(isDefined(spawnangles), spawnangles, (0, 0, 0));
  spawnpoint.time = gettime();
  spawnpoint.team = self.team;
  spawnpoint.index = -1;
  spawnpoint.lifeid = self.lifeid;
  return spawnpoint;
}

function function_9ec9c03926f7b11c(index, maxnum) {
  spawnoffset = ter_op(istrue(level.ignorespawnoffset), 0, 100);
  angle = index / maxnum * 360;
  return (cos(angle) * spawnoffset, sin(angle) * spawnoffset, 0);
}

function function_be92590a9b41dea8(givenid) {
  spawnpointcsv = function_7eb9b366e7ee262e();
  rownum = tablelookupgetnumrows(spawnpointcsv);
  spawnrow = 0;

  for(rowindex = 0; rowindex < rownum; rowindex++) {
    id = tablelookupbyrow(spawnpointcsv, rowindex, 13);

    if(int(id) == givenid) {
      spawnrow = rowindex;
      break;
    }
  }

  poi = tablelookupbyrow(spawnpointcsv, spawnrow, 0);
  csvorigin = tablelookupbyrow(spawnpointcsv, spawnrow, 1);
  var_9c8e5dab0e4fea3a = tablelookupbyrow(spawnpointcsv, spawnrow, 2);
  tmporigin = strtok(csvorigin, ", ");
  var_b91d15a3a3340001 = strtok(var_9c8e5dab0e4fea3a, ", ");
  spawnorigin = (float(tmporigin[0]), float(tmporigin[1]), float(tmporigin[2]));
  spawnangles = (float(var_b91d15a3a3340001[0]), float(var_b91d15a3a3340001[1]), float(var_b91d15a3a3340001[2]));
  output = spawnStruct();
  output.poi = poi;
  output.origin = spawnorigin;
  output.angles = spawnangles;
  return output;
}

function isvalidspectatetarget(player) {
  if(!isDefined(player) || !isDefined(player.team) || !isalive(player) || !isDefined(self) || !isDefined(self.team)) {
    return false;
  }

  return player.team == self.team;
}

function autoassignquest(player) {
  if(!isDefined(level.questinfo.teamsonquests) || array_contains(level.questinfo.teamsonquests, player.team)) {
    return;
  }

  var_73a1687c46c4d341 = [];

  foreach(type in level.validautoassignquests) {
    var_73a1687c46c4d341 = array_combine(var_73a1687c46c4d341, getlootscriptablearray("brloot_" + type + "_tablet"));
  }

  var_73a1687c46c4d341 = array_randomize(var_73a1687c46c4d341);
  closesttablet = undefined;
  var_31a0a0ed9e70e900 = undefined;

  foreach(questtablet in var_73a1687c46c4d341) {
    dist = distance_2d_squared(player.origin, questtablet.origin);

    if(dist <= 16777216 && dist >= 16384) {
      player namespace_1eb3c4e0e28fac71::function_bb413728bc5231d0(questtablet);
      return;
    }

    if(!isDefined(closesttablet) || dist < var_31a0a0ed9e70e900) {
      closesttablet = questtablet;
      var_31a0a0ed9e70e900 = dist;
    }
  }

  if(isDefined(closesttablet)) {
    player namespace_1eb3c4e0e28fac71::function_bb413728bc5231d0(closesttablet);
  }
}

function function_11750957aa915a23() {
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  timer = getdvarint(@ "scr_br_timelimit");
  level thread function_18f66bbf9aa3c9af(timer);

  timechanged = timer;

  while(timechanged == timer) {
    timechanged = getdvarint(@ "scr_br_timelimit");
    wait 1;
  }

  level notify("<dev string:x6a2>");
  setomnvar("<dev string:x6b9>", 5);
  level waittill("<dev string:x6cf>");
  setomnvar("<dev string:x6b9>", 9);
}

function function_18f66bbf9aa3c9af(timer) {
  level endon("<dev string:x6a2>");

  wait int(max(timer - timer - 600, 0));
  setomnvar("ui_br_circle_state", 5);
  level waittill("start_dmz_extracts");
  setomnvar("ui_br_circle_state", 9);
}

function eomawardplayerxp() {
  level waittill("give_match_bonus");
}

function function_f1c3982d13453d32(streakitem, slotnumber) {
  if(getdvarint(@ "hash_3d843517229cd382", 1) && isDefined(level.samsites)) {
    if(scripts\mp\gametypes\dmz_samsites::function_f3354ddc02e867c9(streakitem)) {
      return 0;
    }
  }

  return scripts\mp\gametypes\br::briskillstreakallowed(streakitem, slotnumber);
}

function function_dd432354af4c9024() {
  level.outofboundstriggers = [];
  potentialoobtriggers = getEntArray("OutOfBounds", "targetname");
  glarea = getdvarint(@ "hash_a4617fb891ca21cb", 0) == 1;

  if(glarea) {
    foreach(trigger in potentialoobtriggers) {
      if(isDefined(trigger.script_noteworthy) && trigger.script_noteworthy == "locale_32") {
        level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
        continue;
      }

      trigger delete();
    }

    return;
  }

  foreach(trigger in potentialoobtriggers) {
    if(!isDefined(trigger.script_noteworthy)) {
      level.outofboundstriggers[level.outofboundstriggers.size] = trigger;
      continue;
    }

    trigger delete();
  }
}

function function_d8431975bbec1179() {
  waitframe();

  while(!isDefined(level.struct_class_names)) {
    waitframe();
  }

  scripts\mp\ai_mp_controller::function_2fc80954fa70d153();
  helilocs = array_randomize(getStructArray("heli_loc_protected", "script_noteworthy"));

  if(scripts\mp\poi::poi_issystemactive()) {
    temparray = [];

    foreach(loc in helilocs) {
      if(!isDefined(loc.poi)) {
        loc.poi = scripts\mp\poi::poi_findpoioriginisin(loc.origin, 1);
      }

      if(isDefined(loc.poi) && scripts\mp\poi::poi_ispoiactive(loc.poi)) {
        subarea = scripts\mp\ai_mp_controller::subarea_findfromorigin(loc.origin, loc.poi);
        loc.var_71ad22c5d093d90b = subarea.var_71ad22c5d093d90b;
        temparray[temparray.size] = loc;
      }
    }

    helilocs = temparray;
  }

  var_387e5f09ea0603e8 = getdvarint(@ "hash_673ec70c6eff1e18", 2);

  for(i = 0; i < var_387e5f09ea0603e8; i++) {
    spawndata = spawnStruct();

    if(!isDefined(helilocs[i])) {
      continue;
    }

    spawndata.origin = helilocs[i].origin;
    spawndata.angles = helilocs[i].angles;
    scripts\mp\gametypes\br_vehicles::spawnavehicle("little_bird", spawndata);
    connectednodes = getStructArray(helilocs[i].target, "targetname");

    if(!isDefined(connectednodes)) {
      continue;
    }

    foreach(node in connectednodes) {
      if(isDefined(node.script_noteworthy)) {
        node.poi = helilocs[i].poi;
        node.var_71ad22c5d093d90b = helilocs[i].var_71ad22c5d093d90b;
        script_noteworthy = tolower(node.script_noteworthy);

        if(issubstr(script_noteworthy, "guard")) {
          scripts\mp\ai_mp_controller::spawnguard(node, 1, 1, "medium", "extraGuards");
          continue;
        }

        if(script_noteworthy == "patrolstart" || issubstr(script_noteworthy, "patrolpath")) {
          pathstruct = scripts\mp\ai_mp_controller::function_9edcf99159abb0b(node, issubstr(script_noteworthy, "looped"));
          scripts\mp\ai_mp_controller::spawnpatrol(pathstruct, 1, 2, undefined, "high", "extraPatrols");
        }
      }
    }
  }
}

function function_3403c13cec1cea46() {
  scripts\engine\utility::registersharedfunc("lasertrap", "createLootDropInfo", &createlootdropinfo);
  scripts\engine\utility::registersharedfunc("lasertrap", "spawnPickup", &scripts\mp\gametypes\br_pickups::spawnpickup);

  while(!isDefined(level.var_f1073fbd45b59a06) || !istrue(level.var_f1073fbd45b59a06.var_9b87fdb80920f442)) {
    waitframe();
  }

  if(isDefined(level.var_f1bff73a86c35c52)) {
    [[level.var_f1bff73a86c35c52]]();
  }

  if(isDefined(level.aisentryturrets) && isDefined(level.aisentryturrets.var_325f9f15252b4928)) {
    level thread[[level.aisentryturrets.var_325f9f15252b4928]]();
  }

  if(isDefined(level.firetraps) && isDefined(level.firetraps.var_325f9f15252b4928)) {
    level thread[[level.firetraps.var_325f9f15252b4928]]();
  }

  if(scripts\cp_mp\utility\game_utility::function_e21746abaaaf8414()) {
    level thread namespace_5fa40aef0a0c4a61::function_7142c6e9236c9683();
    level thread namespace_437d750db8e68984::function_f04c619138baafd8();
  }
}

function createlootdropinfo(baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, optionaloverridedist, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44) {
  dropstruct = scripts\mp\gametypes\br_pickups::function_7b9f3966a7a42003();
  return scripts\mp\gametypes\br_pickups::getitemdroporiginandangles(dropstruct, baseorigin, baseangles, ignoreent, var_8a600b6102da9f9b, optionaloverridedist, var_6fe2ff802d5192d4, var_3ace5ac9c7d6fa44);
}

function function_9df0ee7fcb9589d4(player, slot, oldequipment) {
  namespace_a38a2e1fe7519183::function_351fe4ac57ca37e5(player, slot);
  namespace_aead94004cf4c147::function_8237b4eeab275f08(player, slot, oldequipment);

  if(isDefined(oldequipment) && oldequipment == "equip_throwing_knife") {
    player scripts\mp\equipment\throwing_knife_mp::throwing_knife_mp_ontake();
  }
}

function sorttripwires() {
  var_1642f84b31faa340 = scripts\mp\poi::poi_issystemactive();

  if(var_1642f84b31faa340) {
    scripts\mp\poi::function_44739fe1cf82e29a("tripwires");
  }

  tripwires = array_randomize(getentitylessscriptablearray("scriptable_dmz_tripwire", "classname"));
  tripwiresremaining = [];

  foreach(tripwire in tripwires) {
    if(istrue(tripwire.var_aad14f891fb70d86)) {
      continue;
    }

    if(!isDefined(tripwire.target)) {
      continue;
    }

    var_3a6b42ab825a103e = tripwire.origin + anglesToForward(tripwire.angles) * 45;
    fortress = namespace_9823ee6035594d67::function_c0a211a69f5f8f2f(var_3a6b42ab825a103e);

    if(isDefined(fortress)) {
      if(var_1642f84b31faa340) {
        scripts\mp\poi::function_d0e7647e5538eb9d(fortress.poi, "tripwires", tripwire);
      }

      if(!isDefined(fortress.tripwires)) {
        fortress.tripwires = [];
      }

      fortress.tripwires[fortress.tripwires.size] = tripwire;
      continue;
    }

    tripwiresremaining[tripwiresremaining.size] = tripwire;
  }

  var_bb07898ec09c0f96 = getdvarint(@ "hash_b458c6effe039abd", 15);
  tripwiresremaining = array_randomize(tripwiresremaining);

  foreach(index, tripwire in tripwiresremaining) {
    if(index < var_bb07898ec09c0f96) {
      if(isDefined(level.var_e9a6fc11b0aa7eb2)) {
        [[level.var_e9a6fc11b0aa7eb2]](tripwire);
      }

      continue;
    }

    if(isDefined(level.var_d9d80893720b39df)) {
      [[level.var_d9d80893720b39df]](tripwire);
    }
  }
}

function function_f3a2435f8e39438b() {
  scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  wait getdvarint(@ "hash_4ef15172b2450728", 240);
  matchlimit = getdvarint(@ "hash_f8ce5d52364013ce", 5);

  foreach(player in level.players) {
    if(!isDefined(player.team)) {
      continue;
    }

    if(isDefined(player.brmissionscompleted) && player.brmissionscompleted > 0) {
      continue;
    }

    if(scripts\mp\gametypes\activity_manager::function_5ea5a722c499078f(player.team)) {
      continue;
    }

    matchcount = player getplayerdata(level.progressiongroup, "playerStats", "modeStats", "br_dmz", "gamesPlayed");

    if(level.mapname != "mp_bio_lab" && isDefined(matchcount) && matchcount < matchlimit) {
      scripts\cp_mp\overlord::playevent(random(["mission_reminder_1", "mission_reminder_2"]), [player]);
    }
  }
}

function playerskiplootpickup(instance, autouse) {
  if(istrue(self.var_859654e0445a36d9) && isDefined(instance) && isDefined(instance.type) && instance.type != "dmz_hostage") {
    fakepickup = spawnStruct();
    fakepickup.scriptablename = instance.type;
    fakepickup.weapon = instance.weapon;

    if(!scripts\mp\gametypes\br_pickups::isweaponpickupitem(fakepickup)) {
      return false;
    }

    if(!istrue(autouse)) {
      scripts\mp\hud_message::showerrormessage(level.br_pickups.var_355cddb773cb000d);
    }

    return true;
  }

  return false;
}

function function_865b1a5a62c49d7(var_74753a0c1c255400) {
  if(!isDefined(self) || isDefined(self.disconnecting)) {
    return;
  }

  if(istrue(self.var_3716375613ca89fd)) {
    return;
  }

  poisvisited = undefined;

  if(scripts\mp\pmc_missions::function_cff2f4f168b29b81()) {
    poisvisited = scripts\mp\utility\teams::getteamdata(self.team, "poisVisited");
  }

  if(isDefined(poisvisited)) {
    poisvisited = poisvisited.size;
  } else {
    poisvisited = 0;
  }

  explorationxp = default_to(self.pers["explorationXP"], 0);
  var_d961222798f5d01a = default_to(self.containerslooted, 0);
  lootingxp = default_to(self.pers["lootingXP"], 0);
  var_56a4e98c643a1e2d = default_to(self.var_56a4e98c643a1e2d, 0);
  missionxp = default_to(self.pers["missionXP"], 0);
  contractscompleted = default_to(self.brmissionscompleted, 0);
  contractxp = default_to(self.pers["contractXP"], 0);
  var_8ae6c90597daa60a = default_to(self.var_8ae6c90597daa60a, 0);
  var_ec9a1b9484844fbe = default_to(self.var_ec9a1b9484844fbe, 0);
  var_fd5c87130f304833 = default_to(self.var_fd5c87130f304833, 0);
  var_c26450f6e6e47b84 = default_to(self.var_c26450f6e6e47b84, 0);
  uavtowerxp = default_to(self.pers["uavTowerXP"], 0);
  var_35b94c88cc1cea97 = default_to(self.var_35b94c88cc1cea97, 0);
  safeopenedxp = default_to(self.pers["safeOpenedXP"], 0);
  doorsunlocked = default_to(self.doorsunlocked, 0);
  areaunlockedxp = default_to(self.pers["areaUnlockedXP"], 0);
  supplydropsopened = default_to(self.supplydropsopened, 0);
  supplydropsopenedxp = default_to(self.pers["supplyDropsOpenedXP"], 0);
  agentkillxp = default_to(scripts\mp\rank::getscoreinfovalue(#"kill"), 0);
  operatorkillxp = default_to(getdvarint(@ "hash_defd7006efde9127", 100), 0);
  bosskillxp = default_to(getdvarint(@ "hash_dfcad66b7ba8da13", 500), 0);
  agentkills = default_to(self.agentkills, 0);
  agentxp = agentkillxp * agentkills;
  operatorkills = default_to(self.kills, 0);
  operatorxp = operatorkillxp * operatorkills;
  var_8c8050d7d861d06c = default_to(self.var_8c8050d7d861d06c, 0);
  bossxp = default_to(self.bossxp, bosskillxp * var_8c8050d7d861d06c);
  revives = default_to(self.pers["revives"], 0);
  revivexp = default_to(self.pers["reviveXP"], 0);
  combatxp = default_to(self.pers["combatXP"], 0);
  var_cd58b8ffbeb66495 = combatxp - revivexp - bossxp - operatorxp - agentxp;
  extractionxp = 0;

  if(istrue(self.extracted) || istrue(var_74753a0c1c255400)) {
    flatbonus = scripts\mp\rank::getscoreinfoxp(#"hash_a664e407eb3e39d4");

    if(scripts\mp\gametypes\dmz_dog_tag::hasdogtag(self)) {
      flatbonus += getdvarint(@ "hash_2b3cb1f1b979a35b", 500);
    }

    extractionxp = default_to(flatbonus, 0);
  }

  var_e7faf08f327b0fb5 = default_to(self.var_e7faf08f327b0fb5, 0);

  if(istrue(level.var_fe38a7ece3409052)) {
    poisvisited += self getplayerdata(level.progressiongroup, "DMZaarValue", 0);
    explorationxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 1);
    var_d961222798f5d01a += self getplayerdata(level.progressiongroup, "DMZaarValue", 2);
    lootingxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 3);
    var_56a4e98c643a1e2d += self getplayerdata(level.progressiongroup, "DMZaarValue", 4);
    missionxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 5);
    contractscompleted += self getplayerdata(level.progressiongroup, "DMZaarValue", 6);
    contractxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 7);
    var_8ae6c90597daa60a += self getplayerdata(level.progressiongroup, "DMZaarValue", 8);
    var_ec9a1b9484844fbe += self getplayerdata(level.progressiongroup, "DMZaarValue", 9);
    var_c26450f6e6e47b84 += self getplayerdata(level.progressiongroup, "DMZaarValue", 10);
    uavtowerxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 11);
    var_35b94c88cc1cea97 += self getplayerdata(level.progressiongroup, "DMZaarValue", 12);
    safeopenedxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 13);
    doorsunlocked += self getplayerdata(level.progressiongroup, "DMZaarValue", 14);
    areaunlockedxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 15);
    supplydropsopened += self getplayerdata(level.progressiongroup, "DMZaarValue", 16);
    supplydropsopenedxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 17);
    agentkills += self getplayerdata(level.progressiongroup, "DMZaarValue", 18);
    agentxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 19);
    operatorkills += self getplayerdata(level.progressiongroup, "DMZaarValue", 20);
    operatorxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 21);
    var_8c8050d7d861d06c += self getplayerdata(level.progressiongroup, "DMZaarValue", 22);
    bossxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 23);
    revives += self getplayerdata(level.progressiongroup, "DMZaarValue", 24);
    revivexp += self getplayerdata(level.progressiongroup, "DMZaarValue", 25);
    var_cd58b8ffbeb66495 += self getplayerdata(level.progressiongroup, "DMZaarValue", 26);
    extractionxp += self getplayerdata(level.progressiongroup, "DMZaarValue", 27);
    var_e7faf08f327b0fb5 += self getplayerdata(level.progressiongroup, "DMZaarValue", 28);
    var_fd5c87130f304833 += self getplayerdata(level.progressiongroup, "DMZaarValue", 29);
  }

  self setplayerdata(level.progressiongroup, "DMZaarValue", 0, poisvisited);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 1, explorationxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 2, var_d961222798f5d01a);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 3, lootingxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 4, var_56a4e98c643a1e2d);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 5, missionxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 6, contractscompleted);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 7, contractxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 8, var_8ae6c90597daa60a);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 9, var_ec9a1b9484844fbe);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 10, var_c26450f6e6e47b84);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 11, uavtowerxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 12, var_35b94c88cc1cea97);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 13, safeopenedxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 14, doorsunlocked);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 15, areaunlockedxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 16, supplydropsopened);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 17, supplydropsopenedxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 18, agentkills);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 19, agentxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 20, operatorkills);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 21, operatorxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 22, var_8c8050d7d861d06c);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 23, bossxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 24, revives);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 25, revivexp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 26, var_cd58b8ffbeb66495);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 27, extractionxp);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 28, var_e7faf08f327b0fb5);
  self setplayerdata(level.progressiongroup, "DMZaarValue", 29, var_fd5c87130f304833);
  self.var_3716375613ca89fd = 1;
}

function onstartgametype() {
  if(namespace_a38a2e1fe7519183::function_e0fc1230452cf4e7()) {
    namespace_a38a2e1fe7519183::initteamdatafields();
  }

  level.br_plunder.plunderlimit = getdvarint(@ "hash_81ed5b282707434c", 25000);
}

function function_a7f9424636f37fb1() {
  return level.mapname != "mp_saba" && level.mapname != "mp_saba2";
}

function function_bfd9f11e955ace89(player) {
  if(!isDefined(player)) {
    return false;
  }

  if(!isDefined(level.var_fe2e551da0962c3c) || level.var_fe2e551da0962c3c.size == 0) {
    return false;
  }

  dist = getdvarint(@ "scr_overlord_enemy_proximity_radius", 4096);
  distsq = dist * dist;

  foreach(exfil in level.var_fe2e551da0962c3c) {
    if(distancesquared(exfil.origin, player.origin) < distsq) {
      return true;
    }
  }

  return false;
}

function function_b71560b07a8f979d(poiprefix) {
  if(getdvarint(@ "hash_2fda550ad7ec197f", 1) == 0) {
    return;
  }

  level thread function_83068181cca9a6ce();
  level thread function_6a65488b49f1f350();
  level thread function_c574618f682ba25e();
  level thread function_53542cd8fe181d7();

  var_cbbc69e627ec4ae0 = function_91a28c56c45a736f();
  level.var_34858ba8086735c6 = [];

  foreach(zoneid in var_cbbc69e627ec4ae0) {
    zonename = function_aae8b5dc22c12d2c(zoneid);

    if(issubstr(zonename, poiprefix)) {
      level.var_34858ba8086735c6[level.var_34858ba8086735c6.size] = zonename;
    }
  }

  if(scripts\engine\utility::issharedfuncdefined("dmzWar", "poiNameFixer")) {
    [[scripts\engine\utility::getsharedfunc("dmzWar", "poiNameFixer")]]();
  }

  temparray = [];

  foreach(poiname in level.var_34858ba8086735c6) {
    if(array_contains(level.poi_names, poiname)) {
      temparray[temparray.size] = poiname;
    }
  }

  level.var_34858ba8086735c6 = temparray;
  level.var_34858ba8086735c6 = array_remove_duplicates(level.var_34858ba8086735c6);
  level.var_e3e83f2c87707af3 = [];

  if(issubstr(level.mapname, "saba")) {
    level.var_c129fa020d92b91[0] = "aq";
    level.var_c129fa020d92b91[1] = "ru";
    return;
  }

  if(issubstr(level.mapname, "sealion")) {
    level.var_c129fa020d92b91[0] = "merc";
    level.var_c129fa020d92b91[1] = "ru";
    return;
  }

  if(issubstr(level.mapname, "delta")) {
    level.var_c129fa020d92b91[0] = "merc";
    level.var_c129fa020d92b91[1] = "ru";
  }
}

function function_7a7aa3b5455f0412(poiname) {
  if(!isDefined(level.var_34858ba8086735c6)) {
    return 0;
  }

  return array_contains(level.var_34858ba8086735c6, poiname);
}

function function_a1e18f290954a5e9() {
  if(!isDefined(level.var_34858ba8086735c6)) {
    return;
  }

  function_3e8d58a34eb71817();
  function_676d1e19647f363b();

  foreach(poiname in level.var_34858ba8086735c6) {
    function_32eeb14c9c5932ab(poiname);
    level thread function_75512afd0c09ad03(poiname);
  }
}

function function_3e8d58a34eb71817() {
  firelocs = getStructArray("dmzWar_fireLoc", "script_noteworthy");
  scripts\mp\poi::function_44739fe1cf82e29a("warFireLocs");
  level.var_d12e916057cf5f18 = getdvarint(@ "hash_aa44e542c9b99fe9", 3);

  foreach(fireloc in firelocs) {
    if(isDefined(fireloc.poi) && function_7a7aa3b5455f0412(fireloc.poi)) {
      scripts\mp\poi::function_d0e7647e5538eb9d(fireloc.poi, "warFireLocs", fireloc);
    }
  }
}

function function_32eeb14c9c5932ab(poiname) {
  firelocs = scripts\mp\poi::function_1af8a41e4c1252c7(poiname, "warFireLocs");

  if(firelocs.size == 0) {
    loc = spawnStruct();
    loc.origin = level.poi_origins[poiname];
    loc.angles = (0, 0, 0);
    firelocs[firelocs.size] = loc;
  }

  if(!isDefined(level.var_cbe618f35b332990)) {
    level.var_cbe618f35b332990 = spawn("script_origin", (0, 0, 0));
  }

  firelocs = array_randomize(firelocs);

  for(i = 0; i < level.var_d12e916057cf5f18; i++) {
    fireloc = firelocs[i];

    if(!isDefined(fireloc)) {
      break;
    }

    if(!isDefined(fireloc.script_parameters)) {
      continue;
    }

    tokens = strtok(fireloc.script_parameters, " ");
    var_1d01475f82a8218e = random(tokens);

    if(!isDefined(var_1d01475f82a8218e)) {
      break;
    }

    if(var_1d01475f82a8218e == "largefire") {
      var_1d01475f82a8218e = "fire_plume";
    } else if(var_1d01475f82a8218e == "medfire") {
      var_1d01475f82a8218e = "fire_plume_02";
    } else if(var_1d01475f82a8218e == "smoke") {
      var_1d01475f82a8218e = "fire_plume_03";
    }

    var_74484087f576ef7b = spawn("script_model", fireloc.origin);
    var_74484087f576ef7b setModel(var_1d01475f82a8218e);
    var_74484087f576ef7b forcenetfieldhighlod(1);

    if(var_1d01475f82a8218e != "fire_plume_03") {
      level thread function_7d89b4a3c059dad5(var_74484087f576ef7b, 100);
    }
  }
}

function function_7d89b4a3c059dad5(object, radius) {
  level endon("game_ended");
  navobstacle = createnavobstaclebybounds(object.origin, (radius, radius, radius), object.angles);

  while(true) {
    level.var_cbe618f35b332990 radiusdamage(object.origin, radius, 5, 5, level.var_cbe618f35b332990, "MOD_FIRE", "molotov_mp", 0, 0);
    wait 1;
  }
}

function function_676d1e19647f363b() {
  killstreaklocs = getStructArray("killstreakLoc", "script_noteworthy");
  scripts\mp\poi::function_44739fe1cf82e29a("killstreakLocs");
  level.var_b97a5a45a2dba6c = getdvarint(@ "hash_f181834d0fddd688", 45);
  level.var_d5c63047751cf4fa = getdvarint(@ "hash_d9c60a3d6d9109f2", 10);
  level.var_d1f13aadf10414cc = [];
  level.var_5d440f3b81a8afbf = [];
  level.var_5d440f3b81a8afbf["precision"] = &scripts\mp\ai_mp_controller::function_46c2d826ebb9e2cc;
  level.var_5d440f3b81a8afbf["mortar"] = &scripts\mp\ai_mp_controller::function_4a618b49270cfd25;

  if(getdvarint(@ "hash_a003311e2a2ce147", 1) == 1) {
    level.var_d1f13aadf10414cc[level.var_d1f13aadf10414cc.size] = "precision";
  }

  if(getdvarint(@ "hash_c79b251ca40d012c", 1) == 1) {
    level.var_d1f13aadf10414cc[level.var_d1f13aadf10414cc.size] = "mortar";
  }

  foreach(killstreakloc in killstreaklocs) {
    if(isDefined(killstreakloc.poi) && function_7a7aa3b5455f0412(killstreakloc.poi)) {
      tokens = strtok(killstreakloc.script_parameters, " ");
      killstreakloc.killstreakoptions = [];

      foreach(token in tokens) {
        if(array_contains(level.var_d1f13aadf10414cc, token)) {
          killstreakloc.killstreakoptions[killstreakloc.killstreakoptions.size] = token;
        }
      }

      scripts\mp\poi::function_d0e7647e5538eb9d(killstreakloc.poi, "killstreakLocs", killstreakloc);
    }
  }
}

function function_75512afd0c09ad03(poiname) {
  level endon("game_ended");
  killstreaklocs = scripts\mp\poi::function_1af8a41e4c1252c7(poiname, "killstreakLocs");

  while(true) {
    wait level.var_b97a5a45a2dba6c + randomintrange(level.var_d5c63047751cf4fa * -1, level.var_d5c63047751cf4fa + 1);
    var_1c4f6d991c751924 = array_randomize(function_7e3f22e620f3f71e(poiname, "everybody"));

    foreach(agent in var_1c4f6d991c751924) {
      if(isDefined(agent) && isagent(agent) && isalive(agent)) {
        killstreakloc = random(killstreaklocs);

        if(!isDefined(agent) || !isDefined(killstreakloc)) {
          break;
        }

        killstreakchoice = random(killstreakloc.killstreakoptions);
        fakeowner = scripts\mp\ai_mp_controller::function_af3034a7c69d7edb(agent.team);

        if(!isDefined(fakeowner)) {
          continue;
        }

        [[level.var_5d440f3b81a8afbf[killstreakchoice]]](fakeowner, killstreakloc.origin, killstreakloc.radius);
        break;
      }
    }
  }
}

function function_39aceb03c0aace46(player, meansofdeath) {
  if(!isDefined(level.var_a3de977788317ef5)) {
    level.var_a3de977788317ef5 = getdvarint(@ "hash_ec07295b05c0fe7b", 10);
  }

  if(!isDefined(player.var_c669906a542b9baf)) {
    return;
  }

  foreach(nationality, var_cb2f0f5908924bc1 in player.var_c669906a542b9baf) {
    var_24316e3669fb6dda = scripts\cp_mp\agents\agent_utils::function_1bca33010b895b0b(nationality);

    if(var_cb2f0f5908924bc1 >= level.var_a3de977788317ef5 || isDefined(meansofdeath) && meansofdeath == "MOD_EXECUTION") {
      scripts\cp_mp\agents\agent_utils::function_ab491b16f8423c8e(player, var_24316e3669fb6dda, 0);
      group = scripts\cp_mp\agents\agent_utils::function_ed5140c225d4f337(player);
      scripts\cp_mp\agents\agent_utils::function_ca2adce5c7865c20(player, group);
      player thread scripts\mp\hud_message::showsplash("dmz_friendly_faction_turned_sc", undefined, undefined, undefined, undefined, undefined, 1);
      continue;
    }

    if(var_cb2f0f5908924bc1 == int(level.var_a3de977788317ef5 / 3) && scripts\cp_mp\agents\agent_utils::function_46c0de7595d8cab2(player, var_24316e3669fb6dda)) {
      player thread scripts\mp\hud_message::showsplash("dmz_friendly_faction_warning_sc", undefined, undefined, undefined, undefined, undefined, 1);
    }
  }
}

function function_83068181cca9a6ce() {
  level endon("<dev string:x6e5>");
  setDvar(@ "hash_178542258ddf9919", 0);

  while(true) {
    debugdvar = getdvarint(@ "hash_178542258ddf9919", 0);

    if(debugdvar == 1) {
      foreach(poiname in level.var_34858ba8086735c6) {
        sphere(level.poi_origins[poiname], 512, (0, 1, 0));
        print3d(level.poi_origins[poiname] + (0, 0, 552), poiname, (1, 1, 1), 1, 10, 20);
      }
    }

    waitframe();
  }
}

function function_6a65488b49f1f350() {
  level endon("<dev string:x6e5>");
  setDvar(@ "hash_80402b3ce6537b32", 0);

  while(true) {
    debugdvar = getdvarint(@ "hash_80402b3ce6537b32", 0);

    if(debugdvar == 1) {
      foreach(poiname in level.var_34858ba8086735c6) {
        agents = function_7e3f22e620f3f71e(poiname, "<dev string:x6f3>");

        foreach(agent in agents) {
          if(isagent(agent) && isalive(agent)) {
            if(issubstr(agent.agent_type, level.var_c129fa020d92b91[0])) {
              sphere(agent.origin, 64, (1, 0, 0));
            } else if(issubstr(agent.agent_type, level.var_c129fa020d92b91[1])) {
              sphere(agent.origin, 64, (0, 0, 1));
            }

            continue;
          }

          if(isint(agent)) {
            var_46c4d85528ff976f = scripts\cp_mp\agents\agent_utils::function_2b0e82156fa6075b(agent);

            if(issubstr(var_46c4d85528ff976f.aitype, level.var_c129fa020d92b91[0])) {
              sphere(var_46c4d85528ff976f.origin, 64, (0.45, 0, 0.2));
              continue;
            }

            if(issubstr(var_46c4d85528ff976f.aitype, level.var_c129fa020d92b91[1])) {
              sphere(var_46c4d85528ff976f.origin, 64, (0.3, 0.6, 1));
            }
          }
        }
      }
    }

    waitframe();
  }
}

function function_c574618f682ba25e() {
  level endon("<dev string:x6e5>");
  setDvar(@ "hash_55d29f88459810f", 0);

  while(true) {
    debugdvar = getdvarint(@ "hash_55d29f88459810f", 0);

    if(debugdvar == 1) {
      foreach(poiname in level.var_34858ba8086735c6) {
        killstreaklocs = scripts\mp\poi::function_1af8a41e4c1252c7(poiname, "<dev string:x700>");

        foreach(killstreakloc in killstreaklocs) {
          sphere(killstreakloc.origin, killstreakloc.radius, (0, 1, 1));
          print3d(killstreakloc.origin + (0, 0, 296), killstreakloc.script_parameters, (1, 1, 1), 1, 10, 20);
        }
      }
    }

    waitframe();
  }
}

function function_53542cd8fe181d7() {
  level endon("<dev string:x6e5>");
  setDvar(@ "hash_6b3e8a08b753e1c8", 0);

  while(true) {
    debugdvar = getdvarint(@ "hash_6b3e8a08b753e1c8", 0);

    if(debugdvar == 1) {
      foreach(poiname in level.var_34858ba8086735c6) {
        firelocs = scripts\mp\poi::function_1af8a41e4c1252c7(poiname, "<dev string:x712>");

        foreach(fireloc in firelocs) {
          if(!isDefined(fireloc.script_parameters)) {
            continue;
          }

          sphere(fireloc.origin, 128, (0, 1, 1));
          print3d(fireloc.origin + (0, 0, 296), fireloc.script_parameters, (1, 1, 1), 1, 5, 20);
        }
      }
    }

    waitframe();
  }
}

function function_3fd2d65f62ca31b0() {
  while(!isDefined(level.br_pickups)) {
    waitframe();
  }

  wait 1;
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo((16445, -979, 240), (0, 0, 0));
  pickup = scripts\mp\gametypes\br_pickups::spawnpickup("<dev string:x721>", dropinfo);
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo((49287, -30290, 220), (0, 0, 0));
  pickup = scripts\mp\gametypes\br_pickups::spawnpickup("<dev string:x721>", dropinfo);
  dropinfo = scripts\mp\gametypes\br_pickups::getitemdropinfo((49323, -30377, 220), (0, 0, 0));
  pickup = scripts\mp\gametypes\br_pickups::spawnpickup("<dev string:x73d>", dropinfo);
}

# /