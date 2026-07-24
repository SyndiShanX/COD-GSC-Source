/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_moon\shipcrib_moon.gsc
***********************************************************/

main() {
  scripts\sp\utility::_id_1263F("shipcrib_moon_prime_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_prime_in_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_jackal_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_bridge_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_exterior_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_jackale_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_hangar_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_bridgee_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_halore_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_mezz_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_welldeck_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_vr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_moon_ambient_tr");
  _id_0EFB::_id_FDB2("shipcrib_moon");
  _id_0EFB::_id_FD77("shipcrib_moon");
  _id_0EFB::_id_FD73("shipcrib_moon");
  _id_0EFB::_id_FDAE("shipcrib_moon");
  _id_0EFB::_id_FDDC("shipcrib_moon");
  var_0 = ["shipcrib_moon_prime_tr", "shipcrib_moon_prime_in_tr", "shipcrib_moon_welldeck_tr", "shipcrib_moon_ambient_tr"];
  scripts\sp\utility::_id_F343("moon start");
  scripts\sp\utility::_id_1749("comicon", ::_id_BB44, "", undefined, var_0);
  scripts\sp\utility::_id_1749("bridge", ::_id_30B6, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("armory", ::_id_224A, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("flight deck", ::_id_6F23, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("tigris bridge", ::_id_118AC, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("moon gibson pip", ::_id_BB1A, "", undefined, ["shipcrib_moon_jackal_tr", "shipcrib_moon_jackale_tr", "shipcrib_moon_prime_in_tr", "shipcrib_moon_mezz_tr"]);
  scripts\sp\utility::_id_1749("moon start pre", ::_id_BB41, "", undefined, ["shipcrib_moon_jackal_tr", "shipcrib_moon_jackale_tr", "shipcrib_moon_prime_in_tr", "shipcrib_moon_mezz_tr"]);
  scripts\sp\utility::_id_1749("moon start", ::_id_BB40, "", undefined, ["shipcrib_moon_jackal_tr", "shipcrib_moon_jackale_tr", "shipcrib_moon_prime_in_tr", "shipcrib_moon_mezz_tr"]);
  scripts\sp\utility::_id_1749("moon r_elevator", ::_id_BB38, "", undefined, level._id_FD6E._id_E46F);
  scripts\sp\utility::_id_1749("moon bridge door", ::_id_BB0C, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("moon bridge", ::moon_bridge, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("moon lv_elevator", ::_id_BB28, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("moon armory", ::_id_BB05, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("moon airboss", ::_id_BB04, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("moon rig room", ::_id_BB3C, "", undefined, var_0);
  scripts\sp\utility::_id_1749("moon vehicle deck", ::_id_BB43, "", undefined, var_0);
  scripts\sp\utility::_id_1749("jeep speech", ::_id_BB23, "", undefined, var_0);
  scripts\sp\utility::_id_1749("jeep speech preload", ::_id_BB24, "", undefined, ["shipcrib_moon_welldeck_tr"]);
  scripts\sp\utility::_id_1749("transient: preload cost mainline", ::_id_BB16, "", undefined, ["shipcrib_moon_jackal_tr", "shipcrib_moon_jackale_tr", "shipcrib_moon_prime_in_tr", "shipcrib_moon_mezz_tr"]);
  scripts\sp\utility::_id_1749("transient: mainline free", ::_id_BB16, "", undefined, ["shipcrib_moon_welldeck_tr"]);
  scripts\sp\utility::_id_116CB("shipcrib_moon");
  scripts\sp\maps\shipcrib_moon\gen\shipcrib_moon_art::main();
  scripts\sp\maps\shipcrib_moon\shipcrib_moon_fx::main();
  scripts\sp\maps\shipcrib_moon\shipcrib_moon_precache::main();
  scripts\sp\maps\shipcrib_moon\shipcrib_moon_anim::main();
  setsaveddvar("spaceshipHackServerToClientDobj", 1);
  setsaveddvar("sm_spotDistCull", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setsaveddvar, "sm_spotDistCull", 450);
  level _id_0EE4::_id_FDDB();
  scripts\sp\load::main();
  level._id_C67F = _id_0EDE::_id_C67F;
  level._id_E366 = scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_1DBF;
  level._id_13567 = "shipcrib_moon_vr_tr_loaded";
  level._id_E3FB = "shipcrib_moon_exterior_tr_loaded";
  level thread _id_0EE4::_id_FDAF();
  level thread _id_0EDC::_id_448B();
  level thread _id_0EDC::_id_BBAC();
  level thread _id_0EF2::_id_9A41();
  level thread _id_0EF0::_id_FD9F();
  level thread _id_10AC::_id_97A5();
  precachemodel("axis_guide");
  precachemodel("body_hero_protagonist");
  precachemodel("head_hero_protagonist");
  precachemodel("body_hero_xo");
  precachemodel("head_hero_noHair_xo_dirty");
  precachemodel("helmet_hero_xo");
  precachemodel("hero_jackal_helmet_a");
  precachemodel("pack_un_jackal_pilots");
  precachemodel("pack_female");
  precachemodel("pack_eth3n_zerog");
  precachemodel("equipment_wall_mounted_phone_01_cordless");
  precachemodel("p7_desk_metal_military_03_tablet");
  precachemodel("equipment_push_broom_01");
  precachemodel("misc_scrub_brush");
  precachemodel("crates_plastic_tech_01");
  precachemodel("veh_mil_air_un_jackal_02_player_cracked");
  precachemodel("veh_mil_air_un_jackal_02_cockpit_glass_dmg_02");
  precachemodel("veh_mil_lnd_un_4x4_atv_vm");
  precachemodel("default_character_shadow");
  precachemodel("viewmodel_base_animated_naval");
  precachemodel("door_airlock_01_door_access");
  precachemodel("door_airlock_01_door_noaccess");
  precachemodel("head_bg_var_head_sc_male_15_head_male_bc_01");
  precachemodel("body_un_crew_ship_a_drk");
  precachemodel("head_bg_var_head_sc_comms_officer_head_hero_air_boss");
  precachemodel("head_bg_var_head_female_bc_03_head_female_bc_01");
  precachemodel("head_bg_engineering_mate");
  precachemodel("head_bg_var_head_bg_engineering_mate_head_hero_gator");
  precachemodel("head_bg_var_head_male_bc_01_head_hero_gator");
  precachemodel("head_bg_var_head_male_bc_03_head_hero_gator");
  precachemodel("head_bg_var_head_male_bc_01_head_male_bc_03");
  precachemodel("head_bg_var_head_male_bc_03_head_male_bc_01");
  precachemodel("head_bg_male_11");
  precachemodel("head_bg_var_head_male_bc_03_head_hero_armorer");
  precachemodel("head_bg_var_head_male_bc_03_head_hero_marine_2");
  precachemodel("head_bg_var_head_male_bc_06_head_hero_armorer");
  precachemodel("head_bg_var_head_male_bc_06_head_male_bc_01");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_01_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_02_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_03_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_04_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_05_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_06_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_07_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_09_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_11_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_12_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_16_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_17_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_18_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_19_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_20_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_23_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_29_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_31_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_36_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_39_periph");
  precachemodel("veh_mil_air_ca_destroyer_dst_piece_big_40_periph");
  precacherumble("light_1s");
  precacherumble("light_2s");
  _id_0EE4::_id_FDA1();
  init_flags();
  level.player._id_E7D1 = scripts\sp\utility::_id_7C23();
  level.player._id_E7D1 thread scripts\sp\utility::_id_E7C7(0.05);
  scripts\sp\maps\shipcrib_moon\shipcrib_moon_lights::main();
  level.player _meth_84C7("lastShipcribMission", level.script);
  level._id_11592 = 0;
}

init_flags() {
  scripts\engine\utility::flag_init("enable_moon_bridge_door");
  scripts\engine\utility::flag_init("salter_heading_to_bridge");
  scripts\engine\utility::flag_init("salter_at_bridge_lift");
  scripts\engine\utility::flag_init("salter_ready_to_lift");
  scripts\engine\utility::flag_init("player_ready_to_lift");
  scripts\engine\utility::flag_init("lift_in_progress");
  scripts\engine\utility::flag_init("lift_complete");
  scripts\engine\utility::flag_init("salter_opsmap_ready");
  scripts\engine\utility::flag_init("rig_room_finished");
  scripts\engine\utility::flag_init("lift_success");
  scripts\engine\utility::flag_init("lounge_commit");
  scripts\engine\utility::flag_init("salter_to_bridge");
  scripts\engine\utility::flag_init("returndeck_convo_complete");
  scripts\engine\utility::flag_init("salter_r_elev_ready");
  scripts\engine\utility::flag_init("player_elev_door_ready");
  scripts\engine\utility::flag_init("mash_complete");
  scripts\engine\utility::flag_init("play_music");
  scripts\engine\utility::flag_init("player_start_lift");
  scripts\engine\utility::flag_init("elevator_started");
  scripts\engine\utility::flag_init("moon_trans_start_ready");
  scripts\engine\utility::flag_init("start_exit_scene");
  scripts\engine\utility::flag_init("gibson_elev_ready");
  scripts\engine\utility::flag_init("rig_room_elevator_leave");
}

_id_BB16() {}

_id_30B6() {
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
}

_id_224A() {
  scripts\sp\utility::_id_11633(getEnt("armory_start", "targetname"));
}

_id_6F23() {
  scripts\sp\utility::_id_11633(getEnt("flightdeck_start", "targetname"));
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("flight", "Flight Deck", 1);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  level thread _id_0EEB::_id_60FD("return", "Flight Deck", 1);
}

_id_118AC() {
  scripts\sp\utility::_id_11633(getEnt("tigris_bridge_start", "targetname"));
}

_id_BB1A() {
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_1 = (-750.266, 898.047, -1029.9);
  var_2 = (-12.8595, -0.324697, 0);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1, var_2);
  scripts\sp\utility::_id_11633(var_3);
  level.player scripts\sp\utility::_id_F526("normal");
  _id_BB42();
  _id_FDC9();
  _id_985D();
  _id_10754();
  wait 1.0;

  for(;;) {
    var_0 scripts\sp\anim::_id_1F35(level._id_828C, "jackal_intro");
  }
}

_id_BB41() {
  level._id_FD6E._id_111D6 = 7.3;
  _id_BB42();
  _id_FDC9();
  _id_A820();
}

_id_BB40() {
  level._id_FD6E._id_111D6 = 7.3;
  level.player _meth_84C7("lastCompletedMission", "phspace");
  level thread _id_BB42();
  _id_FDC9();
  _id_A80C();
}

_id_BB42() {
  scripts\sp\utility::_id_13705();
  level scripts\sp\utility::_id_12643(["shipcrib_moon_hangar_tr", "shipcrib_moon_prime_tr", "shipcrib_moon_ambient_tr"]);
  level thread scripts\sp\utility::_id_12641("shipcrib_moon_halore_tr");
}

_id_BB38() {
  level._id_FD6E._id_111D6 = 7.3;
  _id_FDC9();
  scripts\sp\utility::_id_11633(getEnt("r_elevator_start", "targetname"));
  level._id_6024 = _id_0EEB::_id_7976("return") scripts\engine\utility::spawn_tag_origin();
  var_0 = level._id_EC85["salter"]["SH_MN_1_4A_ELEV_START_XO_scene"];
  level._id_6024.angles = level._id_6024.angles + (0, 90, 0);
  wait 0.05;
  var_1 = getstartorigin(level._id_6024.origin, level._id_6024.angles, var_0);
  var_2 = getstartangles(level._id_6024.origin, level._id_6024.angles, var_0);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1, var_2);
  _id_0EF8::_id_FDFC("spawner_salter_dirty", var_3);
  var_3 delete();
  _id_0EF8::_id_FDFC("spawner_ethan", "moon_outside_elevator_ethan_finish");
  _id_0EF8::_id_FDFC("spawner_gibson", "moon_outside_elevator_gibson_finish");
  level thread scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_8AB4();
  level thread _id_CFA7(1);
  _id_BB15();
  _id_E448();
}

_id_BB0C() {
  scripts\engine\utility::flag_init("elevator_scene_complete");
  level._id_FD6E._id_111D6 = 7.3;
  level thread _id_0EFB::_id_FDBD(7.3, 0.05);
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("moon_lounge_salter_start", "targetname"));
  level._id_EFED = "inside_slow";
  _id_FDC9();
  _id_0EF8::_id_FDFC("spawner_salter_dirty", "lounge_ai_wait");
  _id_0EF8::_id_FDFC("spawner_omar_casual", "moon_lounge_omar_wait");
  level thread _id_0B20::_id_794A("bridge")._id_5A3F _id_0E46::_id_DFE3();
  level thread _id_0B20::_id_794A("bridge")._id_5A40 _id_0E46::_id_DFE3();
  thread _id_F8E9();
  thread _id_FA36();
}

moon_bridge() {
  level._id_FD6E._id_111D6 = 7.3;
  level thread _id_0EFB::_id_FDBD(7.3, 0.05);
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("bridge_player_bink_exit", "targetname"));
  _id_FDC9();
  var_0 = _id_0B20::_id_794A("captains_quarters")._id_5A3C scripts\engine\utility::spawn_tag_origin();
  var_1 = scripts\sp\utility::_id_10639("player_rig");
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "SH_MN_CapOps_Digic_Pickup_Plr");
  level.player _meth_823C(var_1, "tag_player", 0.05, 0, 0);
  level.player scripts\engine\utility::delaycall(0.1, ::playerlinktodelta, var_1, "tag_player", 0, 10, 10, 10, 10, 1);
  level.player scripts\engine\utility::delaycall(0.15, ::_meth_8392, 0.2, 2.2, 0.6);
  level._id_EFED = "inside_slow";
  level thread _id_BB0D();
  level thread _id_BB0B();
  level thread _id_3077(var_0, var_1);
}

_id_BB28() {
  level._id_FD6E._id_111D6 = 4;
  level thread _id_0EFB::_id_FDBD(4, 0.05);
  _id_FDC9();
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  level._id_EA2C = _id_0EF8::_id_FDFC("spawner_salter_dirty", level._id_C6AA["retribution"]._id_10E52["xo"]);
  level._id_1044B = _id_0EF8::_id_FDFC("spawner_sotomura", _id_0EFB::_id_EFDB("boats"));
  level thread _id_0B21::_id_5A43("bridge_exit", "open");
  level._id_EFED = "inside_slow";
  wait 2;
  setsundirection(anglesToForward((-28, 24, 0)));
  visionsetalternate(5, 0);
  level thread scripts\sp\utility::_id_C12D("playanim_boats_exit", 1.0);
  level._id_EA2C thread scripts\sp\utility::_id_C12D("SH_MN_1_12_MOON_JUMP_XO_scene_01", 2.0);
  level._id_1044B thread scripts\sp\utility::_id_C12D("SH_MN_1_12_MOON_JUMP_BSN_exit", 2.0);
  _id_AB12();
}

_id_BB05() {
  level._id_FD6E._id_111D6 = 4;
  level thread _id_0EFB::_id_FDBD(4, 0.05);
  scripts\sp\utility::_id_11633(getEnt("armory_start_outside", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter_dirty", "armory_ai_wait");
  _id_0EE6::_id_2201(["iw7_m4"], 1);
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6("none");
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A6("iw7_m4");
  scripts\engine\utility::flag_set("lgt_trigger_leave_elevator");
  _id_FDC9();
  lerpsunangles(getmapsunangles(), (-28, 24, 0), 0.4);
}

_id_BB04() {
  scripts\sp\utility::_id_11633(getEnt("airboss_start", "targetname"));
  level._id_EFED = "safe";
  _id_0EF8::_id_FDFC("spawner_salter_dirty", "armory_ai_exit");
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  level._id_EA2C _id_0EFB::_id_EB8D("moon_port");
  level._id_EA2C attach("helmet_hero_xo");
  level._id_EA2C _id_0EF8::_id_FDFF("J_Neck");
  level thread scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_8A7F("armory");
  scripts\engine\utility::flag_init("armory_exited");
  level._id_11592 = 1;
  _id_FDC9();
  level thread _id_0B20::_id_5A2E("armory_exit", "unlocked");
  level thread _id_0A2F::_id_12642();
}

_id_BB3C() {
  level.player scripts\sp\utility::_id_F526("safe");
  scripts\sp\utility::_id_11633(getEnt("vehicle_deck_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter_dirty");
  _id_0EF8::_id_FDFC("spawner_ethan");
  _id_1081F();
  var_0 = getspawnerarray("rig_room_crew");
  level._id_E77A = [];

  foreach(var_2 in var_0) {
    var_3 = scripts\sp\utility::_id_5CC9(var_2);
    var_3 _id_0EFB::_id_FD6F("rig_room");
    var_3._id_C6EA = scripts\engine\utility::getStruct(var_3.script_noteworthy, "targetname");
    var_3._id_C6EA thread scripts\sp\anim::_id_1EEA(var_3, var_3._id_C6EA.animation, "stop_crew", undefined, undefined, "generic");
    level._id_E77A[level._id_E77A.size] = var_3;
  }

  var_5 = scripts\engine\utility::getStruct("rr_org_anim", "targetname");
  var_6 = getEntArray("rig_room_seat", "targetname");

  foreach(var_8 in var_6) {
    var_8 scripts\sp\utility::_id_23B7(var_8.script_noteworthy);

    if(!issubstr(var_8.script_noteworthy, "player")) {
      var_5 scripts\sp\anim::_id_1EC3(var_8, "rig_room_intro");
    } else {
      var_8 scripts\sp\anim::_id_1EC3(var_8, "rig_enter");
    }

    if(isDefined(var_8.script_parameters)) {
      var_8._id_A485 = spawn("script_model", (0, 0, 0));
      var_8._id_A485 setModel(var_8.script_parameters);
      var_8._id_A485 linkTo(var_8, "tag_jetpack", (0, 0, 0), (0, 0, 0));
    }
  }

  var_10 = _id_94E7("locked", var_5);
  thread _id_1F81(getEnt("rig_seat_player", "script_noteworthy"));
  thread _id_1F86(var_5);
  level._id_EA2C attach("helmet_hero_xo");
  level._id_EA2C _id_0EF8::_id_FDFF("J_Neck");
  level._id_30F6 attach(level._id_30F6._id_A489);
  level._id_30F6 _id_0EF8::_id_FE00();
  var_11 = _id_0EEB::_id_7976("gravity");
  var_11._id_92F8 = scripts\engine\utility::spawn_tag_origin((1210.16, 94.248, -2389.51), (0, 110, 0));
  _id_FDC9();
  _id_E50F();
}

_id_BB43() {
  level.player scripts\sp\utility::_id_F526("safe");
  scripts\sp\utility::_id_11633(getEnt("vehicle_deck_start", "targetname"));
  _id_1081F();
  var_0 = getspawnerarray("rig_room_crew");
  level._id_E77A = [];

  foreach(var_2 in var_0) {
    var_3 = scripts\sp\utility::_id_5CC9(var_2);
    var_3 _id_0EFB::_id_FD6F("rig_room");
    var_3._id_C6EA = scripts\engine\utility::getStruct(var_3.script_noteworthy, "targetname");
    var_3._id_C6EA thread scripts\sp\anim::_id_1EEA(var_3, var_3._id_C6EA.animation, "stop_crew", undefined, undefined, "generic");
    level._id_E77A[level._id_E77A.size] = var_3;
  }

  setsaveddvar("sm_spotdistcull", 280);
  _id_0E4B::_id_8E06();
  level._id_EA2C attach("helmet_hero_xo");
  level._id_30F6 attach(level._id_30F6._id_A489);
  level._id_30F6 _id_0EF8::_id_FE00();
  var_5 = [level._id_EA2C, level._id_6754, level._id_30F6];
  var_6 = scripts\engine\utility::getStruct("rr_org_anim", "targetname");

  foreach(var_8 in var_5) {
    var_6 thread scripts\sp\anim::_id_1EEA(var_8, "rig_room_scene_idle", "end_rig_room");
  }

  var_10 = _id_94E7(undefined, var_6);
  _id_FDC9();
  _id_131C9();
}

_id_BB44() {
  level._id_57B1 = 1;
  _id_BB43();
}

_id_BB23() {
  level.player scripts\sp\utility::_id_F526("safe");
  scripts\sp\utility::_id_11633(scripts\engine\utility::getStruct("jeep_speech_start", "targetname"));
  _id_1081F(1);
  setsaveddvar("sm_spotdistcull", 300);
  var_0 = scripts\engine\utility::getStruct("wd_org_anim", "targetname");
  var_0 notify("stop_loop");

  foreach(var_2 in level._id_13BF2) {
    var_0 thread scripts\sp\anim::_id_1EEA(var_2, "welldeck_idle");
  }

  _id_131C6();
  level._id_109D1 = scripts\sp\vehicle::_id_1080C("welldeck_speep_bravo1");
  level._id_109D2 = scripts\sp\vehicle::_id_1080C("welldeck_speep_bravo2");
  level._id_109C8 = scripts\sp\vehicle::_id_1080C("welldeck_speep_alpha1");
  level._id_109CB = scripts\sp\vehicle::_id_1080C("welldeck_speep_alpha2");
  level._id_109D2 dontcastshadows();
  level._id_109C8 hidepart("tag_light_rollbar_r");
  level._id_109C8 hidepart("tag_light_rollbar_l");
  level._id_109C8 hidepart("tag_roof");
  level._id_109C8 attach("veh_mil_lnd_un_4x4_atv_vm", "tag_origin");
  level._id_109D1 thread vehicle_deck_rider_setup();
  level._id_109D2 thread vehicle_deck_rider_setup();
  level._id_109C8 thread vehicle_deck_rider_setup();
  level._id_109CB thread vehicle_deck_rider_setup();
  level._id_109C8 scripts\sp\utility::_id_23B7("jeep_alpha");
  level._id_109D1 scripts\sp\utility::_id_23B7("jeep_bravo");
  var_0 thread _id_1ED9(level._id_109C8, "welldeck_intro", 0.95);
  var_0 thread _id_1ED9(level._id_109D1, "welldeck_intro", 0.95);
  var_4 = scripts\engine\utility::getStructArray("welldeck_ambient_actor", "targetname");
  level._id_13BF0 = [];
  level.wd_crew_cleanup = [];

  foreach(var_6 in var_4) {
    var_7 = undefined;

    if(isDefined(var_6.script_type) && issubstr(var_6.script_type, "walker")) {
      var_7 = scripts\sp\utility::_id_107EA(var_6.target, 1);
      var_7 scripts\sp\utility::_id_51E1("casual");
      var_7._id_846A = scripts\engine\utility::getStruct(var_6.script_parameters, "targetname");
      level._id_13BF0 = scripts\engine\utility::array_add(level._id_13BF0, var_7);
    } else {
      var_7 = scripts\sp\utility::_id_5CC9(getspawner(var_6.target, "targetname"));
      var_7 dontcastshadows();
      var_7 _id_0EFB::_id_FD6F("well_deck");
    }

    if(!isDefined(var_7)) {
      continue;
    }
    if(isDefined(var_7.headmodel) && isDefined(var_6._id_EF20)) {
      var_7 detach(var_7.headmodel);
      var_7 attach(var_6._id_EF20);
    }

    if(isDefined(var_6.script_type) && issubstr(var_6.script_type, "tablet")) {
      var_7._id_113CA = spawn("script_model", (0, 0, 0));
      var_7._id_113CA setModel("p7_desk_metal_military_03_tablet");
      var_7._id_113CA linkTo(var_7, "tag_inhand", (0, 0, 0), (0, 0, 0));
    }

    if(isDefined(var_6._id_EF1F) && var_6._id_EF1F) {
      level.wd_crew_cleanup = scripts\engine\utility::array_add(level.wd_crew_cleanup, var_7);
    }

    var_7._id_C6EA = var_6;
    var_6 thread scripts\sp\anim::_id_1EEA(var_7, var_6.animation, undefined, undefined, undefined, "generic");

    if(isDefined(var_6._id_ED75)) {
      var_7 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, level._id_EC85["generic"][var_6.animation][0], var_6._id_ED75);
    }
  }

  _id_0E4B::_id_8E06();
  level._id_EA2C attach("helmet_hero_xo");
  level._id_C47F _id_0EF8::_id_FE00();
  _id_FDC9();
  _id_A451();
}

_id_BB24() {
  level thread _id_BB23();
  scripts\engine\utility::waitframe();
  level thread _id_BB32();
}

#using_animtree("script_model");

_id_FDC9() {
  _id_0EE4::_id_FDC0();
  scripts\sp\maps\shipcrib_moon\shipcrib_moon_lights::init_lighting();
  level notify("init_complete");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "return_deck");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "flight_control");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "navigation_l");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "navigation_c");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "navigation_r");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "view_aft");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "systems_corner");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "cic_boats");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "comms_rear");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "tactical_l");
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "tactical_r");
  level thread _id_0B20::_id_5A52("bridge", ::_id_2FF6);
  level thread _id_0B20::_id_5A52("armory", ::_id_21E3);
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A71);
  level thread _id_0B20::_id_5A2E("captains_quarters", "open");
  _id_0B20::_id_794A("captains_quarters")._id_5A30 linkTo(_id_0B20::_id_794A("captains_quarters")._id_5A3C, "j_hinge1");
  _id_0B20::_id_794A("captains_quarters")._id_5A3C scripts\engine\utility::delaycall(0.1, ::clearanim, %root, 0);
  _id_0B20::_id_794A("captains_quarters")._id_5A3C scripts\engine\utility::delaycall(0.15, ::_meth_82A2, %shipcrib_door_right_push_long_open, 1, 0, 0);
  _id_0B20::_id_794A("captains_quarters")._id_5A3C scripts\engine\utility::delaycall(0.2, ::_meth_82B0, %shipcrib_door_right_push_long_open, 0.8);
  _id_0B20::_id_794A("captains_quarters")._id_5A30 connectpaths();
  level thread _id_0EDE::_id_C66D("retribution");
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  level.moon = getEnt("moon_model", "targetname");
  level.moon hide();
  level._id_118A8 = scripts\sp\vehicle::_id_1080C("tigris");
  level._id_118BD = scripts\engine\utility::getStruct("tigris_moon", "targetname");
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_1"]._id_5979, 0.05);
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 0.05);
  level._id_5FC1 = scripts\engine\utility::spawn_tag_origin((52381.7, 10299.5, 123.461), (0, 268.999, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_moon_space_debris_field_02_dense"), level._id_5FC1, "tag_origin");
  level thread _id_FDCA();
}

_id_FDCA() {
  scripts\sp\utility::_id_C264("OBJECTIVE_ALDER");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_ALDER"), &"SHIPCRIB_OBJECTIVE_ALDER");
  scripts\sp\utility::_id_C264("OBJECTIVE_FAST_TRAVEL");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_FAST_TRAVEL"), &"SHIPCRIB_OBJECTIVE_FAST_TRAVEL");
  scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"), &"SHIPCRIB_OBJECTIVE_ARMORY");
  scripts\sp\utility::_id_C264("OBJECTIVE_MOON");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_MOON"), &"SHIPCRIB_OBJECTIVE_MOON");
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_ALDER"), "current");
  level waittill("bridge_intro_bink_done");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_ALDER"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_FAST_TRAVEL"), "current");
  level waittill("ftl_finished");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_FAST_TRAVEL"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"), "current");
  level waittill("player_chose_loadout");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_MOON"), "current");
}

_id_A820() {
  level.player endon("death");
  _id_985D();
  _id_10754();
  level._id_EA2C._id_8E08 = ["j_helmet", "J_Visor", "J_Visor_Inner"];
  level._id_EA2C thread _id_0EF8::_id_FE00();
  level.player thread _id_0E4B::_id_8E06();
  level._id_EFED = "inside_normal";
  level notify("start_klaxon");
  var_0 = _id_0EF9::_id_FE03("jackal", "a");
  _id_0EE1::_id_E3D9(var_0, "a", 1, "dismount_shipcrib_moon");
  var_0 = _id_0EF9::_id_FE03("jackal", "b");
  _id_0EE1::_id_E3D9(var_0, "b");
  level thread _id_0BDC::_id_A10B("default");
  level thread _id_0BDC::_id_A110();
  var_1 = _id_0EE1::_id_7C10("b")._id_A056;
  var_2 = _id_0EE1::_id_7C10("a")._id_A056;
  var_3 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_1 scripts\sp\anim::_id_1EC3(level._id_EA2C, "jackal_intro");
  var_3 scripts\sp\anim::_id_1EC3(level._id_6754, "jackal_exit");
  scripts\engine\utility::waitframe();
  var_4 = var_2 gettagorigin("tag_copilot");
  var_5 = var_2 gettagangles("tag_copilot");
  level._id_6754 _meth_80F1(var_4, var_5, 10000);
  level._id_EA2C linkTo(var_1);
  level._id_6754 linkTo(var_2);
  _id_0EE1::_id_E3DA("airlock");
  thread _id_A81F();
  _id_E42B();
}

_id_A80C() {
  level scripts\engine\utility::delaythread(0.5, _id_0EE1::_id_F2CE);
  level._id_EFED = "inside_normal";
  level.player scripts\sp\utility::_id_F526("normal", 1);
  setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_naval");
  level.player endon("death");
  _id_985D();
  _id_10754();
  level._id_EA2C thread _id_0EF8::_id_FE00();
  level.player thread _id_0E4B::_id_8E06();
  var_0 = _id_0EF9::_id_FE03("jackal", "a", "player", "landed_mode");
  var_1 = _id_0EF9::_id_FE03("jackal", "b", "fake", "landed_mode");
  wait 0.15;
  _id_0EE1::_id_E3D9(var_0, "a", 1, "dismount_shipcrib_moon");
  _id_0EE1::_id_E3D9(var_1, "b");
  var_0 thread _id_0BDC::_id_A153();
  level thread _id_0BDC::_id_A10B("default");
  level thread _id_0BDC::_id_A110(1);
  level notify("start_klaxon");
  level scripts\engine\utility::delaythread(1.0, _id_0EE1::_id_F2CD);
  var_2 = _id_0EE1::_id_7C10("b")._id_A056;
  var_3 = _id_0EE1::_id_7C10("a")._id_A056;
  var_4 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_2 thread scripts\sp\anim::_id_1EC3(level._id_EA2C, "jackal_intro");
  var_4 thread scripts\sp\anim::_id_1EC3(level._id_6754, "jackal_exit");
  var_5 = var_3 gettagorigin("tag_copilot");
  var_6 = var_3 gettagangles("tag_copilot");
  level._id_6754 _meth_80F1(var_5, var_6, 10000);
  level._id_EA2C scripts\engine\utility::delaycall(0.05, ::linkto, var_2);
  level._id_6754 scripts\engine\utility::delaycall(0.05, ::linkto, var_3);
  _id_0EE1::_id_E3DA("airlock");
  thread _id_A824();
  thread _id_A81E();
  level thread scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_8AB4();
  level scripts\engine\utility::delaythread(19.0, _id_0EE1::_id_F2CF);
  level scripts\engine\utility::delaythread(19.7, ::_id_25BA);
  level scripts\engine\utility::delaythread(30.0, _id_0EE1::_id_F2D0);
  _id_E42B();
}

_id_25BA() {
  level._id_98F0 = thread scripts\engine\utility::play_loopsound_in_space("emt_sc_moon_injured_soldiers_lp", (83.8309, 899.269, -1229));
  level._id_BB47 = thread scripts\engine\utility::play_loopsound_in_space("sc_moon_hangar_alarm_high", (-784, 1699, -916));
  level._id_BB48 = thread scripts\engine\utility::play_loopsound_in_space("sc_moon_hangar_alarm_dist_01", (2043, 532, -954));
  level._id_BB49 = thread scripts\engine\utility::play_loopsound_in_space("sc_moon_hangar_alarm_dist_02", (563, 1829, -1013));
  thread _id_25BC();
  thread audio_hangar_emergency_pa();
  thread _id_25BB();
}

audio_hangar_emergency_pa() {
  level endon("stop_sc_moon_hangar_alarms");
  wait 30;
  thread scripts\engine\utility::play_sound_in_space("sc_moon_pa_firefirefire", (-96, 770, -913));
  wait 10;
  thread scripts\engine\utility::play_sound_in_space("sc_moon_pa_clearformedevac", (-96, 770, -913));
  wait 10;
  thread scripts\engine\utility::play_sound_in_space("sc_moon_pa_contwodmgctrl", (-96, 770, -913));
  wait 10;
  thread scripts\engine\utility::play_sound_in_space("sc_moon_pa_battlestationsfuspad", (-96, 770, -913));
}

audio_hallway_pa() {
  level endon("stop_hallway_scene");
  wait 3;
  thread scripts\engine\utility::play_sound_in_space("sc_moon_pa_alldivisionofficers", (-557, -124, 305));
  wait 15;
  thread scripts\engine\utility::play_sound_in_space("sc_moon_pa_alldivisionofficers", (-557, -124, 305));
}

audio_elev_ride_pa() {
  wait 13;
  thread scripts\engine\utility::play_sound_in_space("sc_moon_pa_forcestowelldeck", (1284, 287, -1210));
  wait 34;
  thread scripts\engine\utility::play_sound_in_space("sc_moon_pa_welldeckoperations", (944, 508, -2292));
}

_id_25BC() {
  level endon("stop_sc_moon_hangar_alarms");
  wait 30;
  level._id_BB49 stoploopsound();
  wait 20;
  wait 20;
  level._id_BB48 stoploopsound();
  wait 20;
  level._id_BB48 = thread scripts\engine\utility::play_loopsound_in_space("sc_moon_hangar_alarm_dist_01", (2043, 532, -954));
  wait 20;
  level._id_BB49 = thread scripts\engine\utility::play_loopsound_in_space("sc_moon_hangar_alarm_dist_02", (1104, 1253, -856));
}

_id_25BB() {
  level waittill("stopthehangaralarmsnow");
  level notify("stop_sc_moon_hangar_alarms");
  level._id_BB47 thread scripts\sp\utility::_id_10460(2.5, 1);
  level._id_BB48 thread scripts\sp\utility::_id_10460(2.5, 1);
  level._id_BB49 thread scripts\sp\utility::_id_10460(2.5, 1);
  level._id_98F0 thread scripts\sp\utility::_id_10460(2.5, 1);
}

_id_257E() {
  level._id_EB8F = thread scripts\engine\utility::play_loopsound_in_space("sc_moon_bridge_alarm_lp", (334, 123, 277));
}

_id_257F() {
  if(isDefined(level._id_EB8F)) {
    level._id_EB8F thread scripts\sp\utility::_id_10460(0.1, 1);
  }

  thread scripts\engine\utility::play_sound_in_space("sc_moon_bridge_alarm_stop", (334, 123, 277));
}

_id_985D() {
  scripts\engine\utility::flag_init("player_descend");
  scripts\engine\utility::flag_init("actors_descend");
  scripts\engine\utility::flag_init("cockpit_push_started");
  scripts\engine\utility::flag_init("cockpit_push_ended");
  scripts\engine\utility::flag_init("dismount_setup");
  scripts\engine\utility::flag_init("dismount_started");
  scripts\engine\utility::flag_init("dismount_ended");
  scripts\engine\utility::flag_init("landing_scene_ended");
}

_id_10754() {
  _id_0EF8::_id_FDFC("spawner_gibson", "jackal_return_airboss_wait");
  _id_0EF8::_id_FDFC("spawner_salter_dirty_wh", "return_deck_jackal_walkway_center");
  _id_0EF8::_id_FDFC("spawner_ethan");
  _id_0EF8::_id_FDFC("spawner_kloos", "moon_deck_kloos_wait");
}

_id_A824() {
  level waittill("salter_pip");
  wait 4.0;
  _id_0EF3::_id_FD78("pip", "sc_moon_gibson_pip");
}

_id_A81F() {
  var_0 = _id_0EE1::_id_7C10("a")._id_A056;
  _id_9859(var_0);
  level thread _id_A821();
  var_1 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_0 thread _id_A800();
  level scripts\engine\utility::delaythread(9.06, ::_id_A810);
  level._id_6754 thread _id_A7FD(var_1);
  level thread _id_A7F9();
  level._id_828C thread _id_A7FB(var_1);
  level thread _id_A7FC(var_1);
  level thread _id_A806();
  level._id_EA2C _id_A802(var_1);
}

_id_A806() {
  var_0 = scripts\engine\utility::getStruct("jackal_light_intro_struct", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2 = getEntArray("lgt_jackal_land_salter", "script_noteworthy");
  var_3 = _id_0EE1::_id_7C10("b")._id_A056;

  foreach(var_5 in var_2) {
    var_5 linkTo(var_1);
  }

  var_1 linkTo(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
}

_id_A821() {
  var_0 = _id_0EE1::_id_7C10("a")._id_A056;
  var_1 = _id_0EE1::_id_7C10("b")._id_3FFB;
  var_2 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_2.origin + anglestoup(var_2.angles) * 50;
  wait 0.05;
  var_2 linkTo(var_1);
  scripts\engine\utility::exploder("90");
  thread _id_EB93();
  wait 5.5;
  thread _id_EB92();
  wait 1.0;
  thread _id_EB91();
  var_0 scripts\engine\utility::delaycall(0.79, ::setmodel, "veh_mil_air_un_jackal_02_player_cracked");
  level scripts\engine\utility::delaythread(1.0, ::_id_EB90);
  scripts\engine\utility::exploder("jackal_return_explode");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_scmoon_decompression_exp_sparks_runner_minor"), var_2, "tag_origin");
  thread _id_A814();
  earthquake(0.75, 1, level.player.origin, 200);
  level.player playRumbleOnEntity("damage_heavy");
  wait 0.05;
  var_3 = level.player.origin + anglesToForward(level.player.angles) * 100;
  var_3 = var_3 + anglestoright(level.player.angles) * -100;
}

_id_A814() {
  wait 0.3;
  var_0 = scripts\sp\utility::_id_10639("elec_box");
  var_0._id_1FBB = "elec_box";
  var_0 scripts\sp\anim::_id_F64A();
  var_1 = _id_0EE1::_id_7C10("a")._id_A056 scripts\engine\utility::spawn_script_origin();
  var_1 linkTo(_id_0EE1::_id_7C10("a")._id_A056, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 scripts\sp\anim::_id_1F35(var_0, "jackal_moon_intro_box");
}

_id_EB93() {
  thread scripts\engine\utility::play_sound_in_space("scn_sc_moon_jackal_return_spark_pre_spark", (-991, 1610, -476));
  wait 5.0;
  thread scripts\engine\utility::play_sound_in_space("scn_sc_moon_jackal_return_spark_01", (-991, 1610, -476));
  thread scripts\engine\utility::play_sound_in_space("scn_sc_moon_jackal_return_spark_02", (-991, 1610, -476));
}

_id_EB91() {
  level.player playSound("scn_sc_moon_jackal_return_explo_lr");
  thread scripts\engine\utility::play_sound_in_space("scn_sc_moon_jackal_return_salt_settle_01", (-1246, 1331, -588));
  thread scripts\engine\utility::play_sound_in_space("scn_sc_moon_jackal_return_salt_settle_02", (-1115, 1364, -588));
}

_id_EB92() {
  level.player playSound("scn_sc_moon_canopy_crack_incoming_lr");
}

_id_EB90() {
  level.player playSound("scn_sc_moon_canopy_crack_lr");
}

_id_A818() {
  var_0 = _id_0EE1::_id_7C10("b")._id_3FFB;
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_1.origin + anglestoup(var_1.angles) * 50;
  wait 0.05;
  var_1 linkTo(var_0);
  playFXOnTag(scripts\engine\utility::getfx("vfx_scmoon_decompression_exp_sparks_runner_minor"), var_1, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_damaged_equipment_med_smolder"), var_1, "tag_origin");
}

_id_D8F2() {
  level endon("stop_anim_time_print");

  for(;;) {
    wait 0.05;
  }
}

_id_A81E() {
  var_0 = _id_0EE1::_id_7C10("a")._id_A056;
  _id_9859(var_0);
  var_1 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  level thread _id_9ADB();
  var_0 thread _id_A7FF(var_1);
  level thread _id_A823(var_1);
  level._id_EA2C _id_A801(var_1);
  level notify("send_elevator");
  scripts\engine\utility::flag_set("landing_scene_ended");
}

_id_9ADB() {
  var_0 = randomfloatrange(0.3, 0.35);
  var_1 = randomfloatrange(1.5, 2);
  var_2 = randomfloatrange(0.2, 0.25);
  var_3 = 2;
  level.player._id_E7D1 scripts\sp\utility::_id_E7C9(var_2, 0.35);
  earthquake(var_0, var_1, level.player.origin, 100000);
  wait 0.1;
  level.player playSound("scn_sc_moon_intro_quake_lr");
  level.player._id_E7D1 scripts\sp\utility::_id_E7C7(var_3);
}

_id_A823(var_0) {
  level thread _id_A817();
  level thread _id_A810();
  level thread _id_A821();
  level thread _id_A7F9();
  level._id_6754 thread _id_A7FD(var_0);
  level._id_828C thread _id_A7FA(var_0);
  level thread _id_A7FC(var_0);
  level thread _id_A813();
  level thread _id_A81D();
  level thread _id_A806();
}

_id_B515() {
  var_0 = (-991, 1610, -476);
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0, (0, 0, 0));
  level thread scripts\engine\utility::draw_angles(var_1.angles, var_1.origin, (1, 0, 0), 10000);
  wait 1.0;
  var_2 = var_1.origin - _id_0EE1::_id_7C10("a")._id_A056.origin;
  iprintln(var_2);
}

_id_A817() {
  wait 1.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_pressurization_progress");
  wait 3.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_jackal_clamp_fail", 0);
  level waittill("plr_landed_start");
  level thread scripts\sp\utility::_id_9145("fluff_messages_jackal_canopy_fail", 0);
}

_id_A810() {
  level scripts\engine\utility::delaythread(22, ::landing_transients);
  level scripts\engine\utility::delaythread(9.26, _id_0EE1::_id_E3D1, "a", "airlock", 4, 5);
  level scripts\engine\utility::delaythread(9.26, _id_0EE1::_id_E3D1, "b", "airlock", 4, 5);
  level waittill("return_door_closed");
  level thread scripts\sp\utility::_id_1264E("shipcrib_moon_jackale_tr");
}

landing_transients() {
  if(!scripts\engine\utility::flag("shipcrib_moon_hangar_tr_loaded") || !scripts\engine\utility::flag("shipcrib_moon_prime_tr_loaded") || !scripts\engine\utility::flag("shipcrib_moon_mezz_tr_loaded") || !scripts\engine\utility::flag("shipcrib_moon_ambient_tr_loaded")) {
    waitforalltransients();
  }
}

_id_A81D() {
  scripts\engine\utility::flag_wait("play_music");
}

#using_animtree("jackal");

_id_9859(var_0) {
  var_0._id_CB8B = [];
  var_0._id_CB8B["descend"] = % sh_mn_1_1c_jackal_exit_plr_decend;
  var_0._id_CB8B["descend_idle"] = % sh_mn_1_1c_jackal_exit_plr_deck_idle;
  var_0._id_CB8B["canopy_push"] = % sh_mn_1_1c_jackal_exit_plr_cockpit_lift;
  var_0._id_CB8B["dismount"] = % sh_mn_1_2_return_deck_plr_exit;
  var_0._id_CB8B["intro"] = % sh_mn_1_1c_jackal_exit_plr_intro;
  var_0._id_CB8B["intro_idle"] = % sh_mn_1_1c_jackal_exit_plr_intro_idle;
  var_0.vehicle_badplace = [];
  var_0.vehicle_badplace["dismount_default"] = % jackal_vehicle_dismount_01_port;
  var_0.vehicle_badplace["dismount"] = % sh_mn_1_2_return_deck_jackal_exit;
  var_0 _id_0EE4::_id_F93C(var_0._id_CB8B["dismount"], var_0.vehicle_badplace["dismount"]);
}

_id_CDC8() {
  _id_0EE4::_id_CDC6(self, self._id_CB8B["descend"], self._id_CB8B["descend_idle"], "player_descend");
}

_id_A800() {
  thread _id_8E89();
  scripts\engine\utility::delaycall(0.05, ::_meth_82B1, self._id_CB8B["intro"], 0);
  _id_0EE4::_id_CD5D(self._id_CB8B["intro"]);
  _id_0EE4::_id_A13C(self._id_CB8B["dismount"]);
  thread _id_0EE4::_id_CE74(self.vehicle_badplace["dismount"]);
  _id_0EE4::_id_CDC3(self._id_CB8B["dismount"]);
  _id_0EE4::_id_620D();
  level.player unlink();
  _id_0BDB::_id_A0F9();
  level._id_EFED = "inside";
  scripts\engine\utility::flag_set("dismount_ended");
  level notify("dismount_shipcrib_moon_complete");
}

_id_D8FF() {
  for(;;) {
    iprintln(level.player scripts\sp\utility::_id_7B8C());
    wait 0.05;
  }
}

_id_A7FF(var_0) {
  scripts\sp\anim::_id_17FC(level._id_A6F4._id_1FBB, "vo_sc_moon_kls_yesmaam", "vo_sc_moon_kls_yesmaam", "jackal_exit");
  scripts\sp\anim::_id_17FC(level._id_A6F4._id_1FBB, "mayhem_start", "mayhem_start", "jackal_exit");
  scripts\sp\anim::_id_17FC(level._id_A6F4._id_1FBB, "mayhem_end", "mayhem_end", "jackal_exit");
  thread _id_8E89();
  level._id_A6F4 thread _id_A81B();
  var_0 thread scripts\sp\anim::_id_1F35(level._id_A6F4, "jackal_intro");
  thread _id_1102D();
  _id_0EE4::_id_CD5D(self._id_CB8B["intro"], undefined, 0);
  level.player scripts\sp\utility::_id_F526("safe");
  level.player.disabledads = 1;
  var_1 = scripts\engine\utility::spawn_tag_origin(self gettagorigin("tag_player"), self gettagangles("tag_player"));
  var_1 linkTo(self);
  level._id_A6F4 linkTo(var_1);
  level notify("plr_landed_start");
  self clearanim(%jackal_state_anims_ai, 0.0);
  thread _id_0EE4::_id_CDC3(self._id_CB8B["dismount"]);
  var_1 thread scripts\sp\anim::_id_1F35(level._id_A6F4, "jackal_exit");
  level._id_A6F4 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, level._id_A6F4 scripts\sp\utility::_id_7DC1("jackal_exit"), 0);
  scripts\engine\utility::delaycall(0.05, ::_meth_82B0, self._id_CB8B["dismount"], 0);
  thread _id_0EE4::_id_CE74(self.vehicle_badplace["dismount"]);
  var_2 = getanimlength(self._id_CB8B["dismount"]);
  scripts\engine\utility::delaythread(var_2 - 2, _id_0BDC::_id_A10F);
  wait(var_2);
  var_3 = _id_0EE1::_id_7C10("a")._id_A056;
  var_4 = _id_0EE1::_id_7C10("b")._id_A056;
  level thread _id_A81C(level._id_A6F4, level._id_1312A);
  level.player unlink();
  level.player showviewmodel();
  _id_0BDB::_id_A0F9();
  self setModel("veh_mil_air_un_jackal_02_cockpit_glass_dmg_02");
  var_5 = scripts\engine\utility::spawn_tag_origin(var_3.origin + (0, 0, -10), var_3.angles);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_4.origin + (0, 0, -10), var_4.angles);
  var_5 linkTo(var_3);
  var_6 linkTo(var_4);
  playFXOnTag(scripts\engine\utility::getfx("vfx_scmoon_jackal_nitrogen_vent"), var_5, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scmoon_jackal_nitrogen_vent"), var_6, "tag_origin");
  scripts\engine\utility::delaycall(0.05, ::clearanim, %sh_mn_1_2_return_deck_jackal_exit, 0.0);
  scripts\engine\utility::delaycall(0.05, ::setanimknob, %jackal_vehicle_landed_state_idle, 1.0, 0.0);
  level._id_EFED = "inside";
  level notify("dismount_shipcrib_moon_complete");
  waitforalltransients();
  wait(getanimlength(level._id_A6F4 scripts\sp\utility::_id_7DC1("jackal_exit")) - level._id_A6F4 islegacyagent(level._id_A6F4 scripts\sp\utility::_id_7DC1("jackal_exit")) * getanimlength(level._id_A6F4 scripts\sp\utility::_id_7DC1("jackal_exit")));
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_A6F4, "jackal_exit_idle", "stop_kloos_loop");
}

#using_animtree("generic_human");

_id_A81B() {
  self endon("death");
  level waittill("mayhem_start");
  self _meth_82A2(%mayhem_sh_mn_1_2_return_deck_klo_exit, 1.0, 0.0, 1.0);
  self detach(self.headmodel);
  self detach(self.hatmodel);
  level waittill("mayhem_end");
  self _meth_82A2(%mayhem_sh_mn_1_2_return_deck_klo_exit, 0.0, 0.0, 1.0);
  self attach(self.headmodel);
  self attach(self.hatmodel);
}

_id_1102D() {
  level.player _meth_8391(5.0);
  level.player playerlinktodelta(self._id_AD34, "tag_origin", 1, 0, 0, 0, 0, 1);
}

_id_8E89() {
  level.player waittill("helmet_off_end");
  level thread _id_0E4B::_id_8DEA();
}

_id_A802(var_0) {
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_affirmativeyou", "salter_pip", "jackal_intro");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_gibsongetusoutt", "salter_pip", "jackal_intro");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_lookwhattheydid", "send_elevator", "jackal_exit");
  var_1 = _id_0EE1::_id_7C10("b");
  var_2 = _id_0EE1::_id_7C10("b")._id_A056;
  var_2 scripts\sp\anim::_id_1F35(self, "jackal_intro");
  level._id_EA2C unlink();
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_exit");
}

#using_animtree("script_model");

_id_A7F9() {
  wait 6.5;
  var_0 = _id_0EE1::_id_7C10("b");
  var_0._id_3FFD._id_1FBB = "crane_jackal";
  var_0._id_3FFD setanimknob(%shipcrib_moon_opening_xo_jackal, 10.0, 0.0);
  scripts\sp\utility::_id_10FEC("jackal_return_explode");
}

_id_A801(var_0) {
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_affirmativeyou", "salter_pip", "jackal_intro");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_gibsongetusoutt", "salter_pip", "jackal_intro");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_lookwhattheydid", "send_elevator", "jackal_exit");
  var_1 = _id_0EE1::_id_7C10("b");
  var_2 = _id_0EE1::_id_7C10("b")._id_A056;
  var_2 scripts\sp\anim::_id_1F35(self, "jackal_intro");
  level._id_EA2C unlink();
  scripts\engine\utility::flag_set("start_exit_scene");
  thread _id_0EF8::_id_FDFF("J_Neck");
  self detach(self.headmodel);
  self attach("head_hero_xo_dirty");
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_exit");
  self notify("jackal_exit");
}

_id_A7FD(var_0) {
  level waittill("playanim_c6i_exit");
  self unlink();
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_exit");
  self notify("jackal_exit");
}

_id_A7FA(var_0) {
  scripts\sp\anim::_id_17FC("gibson", "vo_sc_moon_gbs_trying12linesar", "boss_pip", "jackal_intro");
  scripts\sp\anim::_id_17FC("gibson", "vo_sc_moon_gbs_youshouldhaveai", "boss_pip", "jackal_intro");
  scripts\sp\anim::_id_17FC("gibson", "mayhem_start", "mayhem_start_gibson", "jackal_exit");
  scripts\sp\anim::_id_17FC("gibson", "mayhem_end", "mayhem_end_gibson", "jackal_exit");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "jackal_intro_idle", "stop_boss_loop");
  thread _id_A80E();
  scripts\engine\utility::flag_wait("start_exit_scene");
  var_0 notify("stop_boss_loop");
  level notify("playanim_c6i_exit");
  scripts\engine\utility::flag_set("play_music");
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_exit");
  self notify("jackal_exit");
}

#using_animtree("generic_human");

_id_A80E() {
  self endon("death");
  level waittill("mayhem_start_gibson");
  self _meth_82A2(%mayhem_sh_mn_1_2_return_deck_air_exit, 1.0, 0.0, 1.0);
  self detach(self.headmodel);
  level waittill("mayhem_end_gibson");
  self _meth_82A2(%mayhem_sh_mn_1_2_return_deck_air_exit, 0.0, 0.0, 1.0);
  self attach(self.headmodel);
}

_id_A7FB(var_0) {
  scripts\engine\utility::delaythread(1.5, scripts\sp\utility::_id_F3DC, scripts\engine\utility::getStruct("moon_outside_elevator_gibson_wait2", "targetname").origin);
  scripts\sp\anim::_id_17FC("gibson", "vo_sc_moon_gbs_trying12linesar", "boss_pip", "jackal_intro");
  scripts\sp\anim::_id_17FC("gibson", "vo_sc_moon_gbs_youshouldhaveai", "boss_pip", "jackal_intro");
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_intro");
  level notify("playanim_c6i_exit");
  scripts\engine\utility::flag_set("play_music");
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_exit");
}

_id_A813() {
  level waittill("playanim_c6i_exit");
  setsaveddvar("scr_dof_enable", "1");
  setsaveddvar("r_dof_hq", "1");
  thread _id_0B0A::_id_583F(0, 0, 0, 0, 122, 2, 1);
  level waittill("vo_sc_moon_kls_yesmaam");
  wait 2.0;
  thread _id_0B0A::_id_583F(0, 0, 0, 0, 122, 2, 1);
  wait 2.0;
  _id_0B0A::_id_583F(0, 0, 0, 0, 180, 0, 3);
  scripts\engine\utility::delaythread(3.0, _id_0B0A::_id_583D, 1);
  setsaveddvar("r_dof_hq", "0");
}

_id_A7FC(var_0) {
  level._id_4AB4 = scripts\sp\utility::_id_10639("crowbar", (0, 0, 0), (0, 0, 0));
  level._id_4AB4._id_1FBB = "crowbar";
  level._id_4AB4 scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1F35(level._id_4AB4, "SH_MN_1_1C_JACKAL_EXIT_CB_intro");
  var_0 scripts\sp\anim::_id_1F35(level._id_4AB4, "SH_MN_1_2_RETURN_DECK_CB_exit");
}

_id_A7FE(var_0, var_1) {
  scripts\sp\anim::_id_17FC(self._id_1FBB, "vo_sc_moon_kls_yesmaam", "vo_sc_moon_kls_yesmaam", "jackal_exit");
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_intro");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1 gettagorigin("tag_player"), var_1 gettagangles("tag_player"));
  var_2 linkTo(var_1);
  self linkTo(var_2);
  var_2 thread scripts\sp\anim::_id_1F35(self, "jackal_exit");
  scripts\engine\utility::flag_wait("dismount_ended");
  level thread _id_A81C(self, level._id_1312A);
  wait(getanimlength(scripts\sp\utility::_id_7DC1("jackal_exit")) - self islegacyagent(scripts\sp\utility::_id_7DC1("jackal_exit")) * getanimlength(scripts\sp\utility::_id_7DC1("jackal_exit")));
  var_2 thread scripts\sp\anim::_id_1EEA(self, "jackal_exit_idle", "stop_kloos_loop");
}

_id_CC6E() {
  var_0 = [level._id_828C, level._id_A6F4, level._id_6754, level._id_EA2C];
  var_1 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_2 = _id_0EE1::_id_7C10("b")._id_A056;
  level._id_EA2C unlink();
  level._id_6754 unlink();
  var_1 notify("stop_loop");
  var_2 notify("stop_loop");
  var_1 scripts\sp\anim::_id_1F2C(var_0, "jackal_exit");
  wait 8.7;
}

_id_A81C(var_0, var_1) {
  var_2 = _id_0EE1::_id_7C10("a");
  var_3 = _id_0EE1::_id_7C10("b");
  var_4 = var_2._id_A056;
  var_5 = var_3._id_A056;
  _id_0EE4::_id_984E();
  thread _id_0EE4::_id_DC44("jackal_bridge_02");
  var_2 scripts\engine\utility::delaythread(4.0, _id_0EE4::_id_B0D6);
  var_3 scripts\engine\utility::delaythread(6.0, _id_0EE4::_id_B0D6);
  scripts\engine\utility::flag_wait("landing_on_returndeck");
  thread _id_0EE4::_id_DC44("jackal_bridge_01");
}

_id_CEC5(var_0, var_1, var_2, var_3) {
  _id_CEC4(var_0, var_1, var_2);
  scripts\engine\utility::flag_set(var_3);
}

_id_CEC4(var_0, var_1, var_2) {
  var_0 scripts\sp\anim::_id_1F35(self, var_1);
  var_0 thread scripts\sp\anim::_id_1EEA(self, var_2, "stop_loop");
}

_id_E42B() {
  _id_BB15();
  _id_F957();
  level._id_6024 = _id_0EEB::_id_7976("return") scripts\engine\utility::spawn_script_origin();
  level._id_6024.angles = level._id_6024.angles + (0, 90, 0);
  wait 0.05;
  thread _id_BC66();
  thread _id_BC2F();
  thread _id_BC26();
  scripts\engine\utility::flag_wait("landing_scene_ended");
  level notify("kill_return_klaxon");
  wait 0.05;
  level thread _id_CFA7(1);
  _id_5645();
  _id_5650();
  _id_5649();
  scripts\engine\utility::delaythread(1, scripts\engine\utility::flag_set, "returndeck_convo_complete");
  scripts\engine\utility::flag_wait_all("salter_r_elev_ready", "gibson_elev_ready");
  _id_E448();
}

_id_BC2F() {
  level endon("elev_scene_start");
  level._id_828C waittill("jackal_exit");
  var_0 = level._id_828C scripts\sp\utility::_id_7DC1("SH_MN_1_4A_ELEV_START_AIR_scene");
  var_1 = getstartorigin(level._id_6024.origin, level._id_6024.angles, var_0);
  var_2 = getstartangles(level._id_6024.origin, level._id_6024.angles, var_0);
  var_3 = scripts\engine\utility::spawn_script_origin(var_1, var_2);
  level._id_828C _id_0B6A::_id_EC0B(var_3, "shipcrib_stand_stationary_talk_idle_04", undefined, undefined, undefined, undefined, undefined, 1);
  scripts\engine\utility::flag_set("gibson_elev_ready");
  scripts\engine\utility::flag_wait("returndeck_convo_complete");
  level._id_828C scripts\sp\utility::_id_77B9(0.7);
  wait 0.7;
  var_4 = _id_0EF1::_id_789F("gibson_moon");
  level._id_828C _id_0EE5::_id_202D(undefined, "sc_moon_gbs_hellbrokeloosea", var_4);
  level._id_828C waittill("first_acknowledgement_done");
  level._id_828C scripts\sp\interaction_manager::_id_11009();
  wait 6;
  level._id_828C _id_0EE5::_id_10FC4();
  level._id_828C _id_0EE5::_id_202D(4, "sc_moon_gbs_theyrelookingfor", var_4);
}

_id_BC26() {
  level._id_6754 endon("death");
  level._id_6754 waittill("jackal_exit");
  var_0 = level._id_6754 scripts\sp\utility::_id_7DC1("SH_MN_1_4A_ELEV_START_C6i_scene");
  var_1 = getstartorigin(level._id_6024.origin, level._id_6024.angles, var_0);
  var_2 = getstartangles(level._id_6024.origin, level._id_6024.angles, var_0);
  var_3 = scripts\engine\utility::spawn_script_origin(var_1, var_2);
  level._id_6754 _id_0B6A::_id_EC0A(var_3);
  var_3 delete();
  level._id_6024 scripts\sp\anim::_id_1F35(level._id_6754, "SH_MN_1_4A_ELEV_START_C6i_scene");
  level._id_6024 thread scripts\sp\anim::_id_1EEA(level._id_6754, "SH_MN_1_4A_ELEV_START_C6i_idle", "stop_ethan_loop");
  scripts\engine\utility::flag_wait("returndeck_convo_complete");
  var_4 = _id_0EF1::_id_789F("ethan_moon");
  level._id_6754 _id_0EE5::_id_202D(undefined, "sc_moon_eth_readyforwhateve", var_4);
}

_id_BC66() {
  level waittill("shipcrib_moon_prime_tr_loaded");
  var_0 = level._id_EC85["salter"]["SH_MN_1_4A_ELEV_START_XO_scene"];
  var_1 = getstartorigin(level._id_6024.origin, level._id_6024.angles, var_0);
  var_2 = getstartangles(level._id_6024.origin, level._id_6024.angles, var_0);
  var_3 = scripts\engine\utility::spawn_script_origin(var_1, var_2);
  level._id_EA2C waittill("jackal_exit");
  level._id_EA2C _id_0B6A::_id_EC0B(var_3, "shipcrib_stand_stationary_talk_idle_01", undefined, undefined, undefined, undefined, undefined, 1);
  var_3 delete();
  level._id_EA2C linkTo(_id_0EEB::_id_7976("return"));
  var_4 = _id_0EF1::_id_789F("salter_moon");
  level._id_EA2C _id_0EE5::_id_202D(1, undefined, var_4);
  level._id_EA2C scripts\sp\interaction_manager::_id_1100A();
  scripts\engine\utility::flag_set("salter_r_elev_ready");
}

_id_5645() {
  level._id_EA2C scripts\sp\utility::_id_10346("sc_moon_slt_whatwasalderthi");
  level._id_828C scripts\sp\utility::_id_10346("sc_moon_gbs_strategicmaneuv");
}

_id_5650() {
  level._id_828C scripts\sp\utility::_id_7799(level._id_EA2C);
  level._id_EA2C scripts\sp\utility::_id_10346("sc_moon_slt_alertthebridgew");
  level._id_828C scripts\sp\utility::_id_10346("sc_moon_gbs_bridgeislockedd");
}

_id_5649() {
  level.player scripts\sp\utility::_id_1034D("sc_moon_slt_ethanfallinwith");
  level._id_6754 scripts\sp\utility::_id_10346("sc_moon_eth_rogerthat");
}

_id_F957() {
  level thread _id_0B21::_id_5A43("deck_return_elevator", "locked");
  level thread _id_0EEB::_id_60FD("return", "Flight Deck", 1);
  level _id_0B21::_id_5A43("deck_return_elevator", "open");
}

_id_F220() {
  level waittill("send_elevator");
  level thread _id_0EEB::_id_60F0("return", 140);
  level thread _id_0EEB::_id_60FD("return", "Flight Deck");
  _id_0EEB::_id_7976("return") waittill("move_finished");
  _id_0EEB::_id_7976("return") notify("doors_open");
  level _id_0B21::_id_5A43("deck_return_elevator", "open");
}

_id_E448() {
  var_0 = _id_0EEB::_id_7976("return");
  thread _id_E449();
  var_0.trigger waittill("trigger");
  level notify("elev_scene_start");
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  var_0 notify("doors_close");
  thread scripts\sp\interaction_manager::_id_11037();
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_828C _id_0EE5::_id_10FC4();
  level._id_828C notify("end_idle");
  scripts\engine\utility::waitframe();
  _id_CD2B();
  _id_F8EA();
  level notify("stopthehangaralarmsnow");
  thread _id_257E();
  _id_E42E();
  var_0 waittill("move_finished");
  _id_10FE9();
  level notify("kill_return_hangar_claxons");
  scripts\engine\utility::flag_clear("elevator_started");
  _id_302F();
  wait 0.2;
  level thread _id_0B21::_id_5A43("return_elevator", "open");
  thread audio_hallway_pa();
}

_id_E449() {
  level endon("elev_scene_start");
  wait 20.0;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_moon_slt_reyesletsgoseet");
}

_id_BB15() {
  scripts\engine\utility::flag_init("elevator_scene_complete");
  var_0 = _id_0EEB::_id_7976("return");
  level._id_6021 = var_0 scripts\engine\utility::spawn_script_origin();
  level._id_6021.angles = level._id_6021.angles + (0, 90, 0);
  level._id_6021 linkTo(var_0);
  scripts\engine\utility::waitframe();
  level _id_0EEB::_id_60FD("return", "Bridge Level", 1);
  scripts\engine\utility::waitframe();
  level._id_6022 = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_6022.angles = level._id_6022.angles + (0, 90, 0);
  level _id_0EEB::_id_60FD("return", "Flight Deck", 1);
}

_id_CD2B() {
  level thread _id_E436();
  level thread _id_E446();
  level waittill("son_of_bitch");
  level._id_EA2C thread _id_E444();
}

_id_E436() {
  var_0 = level._id_6024;
  var_0 notify("stop_ethan_loop");
  scripts\sp\anim::_id_17F6("gibson", "vo_sc_moon_gbs_youreit", ::_id_DB7E, "SH_MN_1_4A_ELEV_START_AIR_scene");
  var_0 scripts\sp\anim::_id_1F35(level._id_828C, "SH_MN_1_4A_ELEV_START_AIR_scene");
}

_id_E446() {
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_plr_whatsthecountbo", "how_many", "SH_MN_1_4A_ELEV_START_XO_scene");
  level._id_EA2C linkTo(level._id_6021);
  level._id_6021 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH_MN_1_4A_ELEV_START_XO_scene");
  level notify("salter_elev_intro_done");
}

_id_DB7E(var_0) {
  var_1 = lookupsoundlength("sc_moon_gbs_youreit") / 1000;
  var_1 = var_1 + 0.1;
  wait(var_1);
  level notify("son_of_bitch");
}

_id_F8EA() {
  _id_F8EB();
  _id_F8EC();
}

_id_F8EC() {
  var_0 = scripts\engine\utility::getStruct("moon_lounge_salter_wait", "targetname");
  level._id_E44A = var_0 scripts\engine\utility::spawn_tag_origin();
  thread _id_F9CB();
  thread _id_F9CD();
  thread _id_F9CC();
  thread _id_F9CA();
}

_id_F9CC() {
  var_0 = scripts\engine\utility::getStruct("sc_sa_greeting_animnode", "targetname");
  var_1 = _id_0EF8::_id_FDFC("spawner_interior", var_0, "cheap");
  var_1 endon("death");
  var_0 scripts\sp\anim::_id_1ECA(var_1, "lounge_limping_intro");

  while(distance(_id_0EEB::_id_7976("return").origin, level._id_E44A.origin) > 600) {
    scripts\engine\utility::waitframe();
  }

  wait 7;
  var_0 scripts\sp\anim::_id_1EC7(var_1, "lounge_limping_intro");
  var_0 scripts\sp\anim::_id_1ECC(var_1, "lounge_limping_idle");
  scripts\engine\utility::flag_wait("lift_complete");
  _id_0EFB::_id_FDBA(var_1);
}

_id_F9CB() {
  var_0 = scripts\engine\utility::getStruct("moon_lounge_sitting_scene", "targetname");
  var_1 = _id_0EF8::_id_FDFC("spawner_marine_casual", var_0, "cheap");
  var_1 endon("death");
  var_0 scripts\sp\anim::_id_1ECA(var_1, "lounge_sitting_intro");

  while(distance(_id_0EEB::_id_7976("return").origin, level._id_E44A.origin) > 600) {
    scripts\engine\utility::waitframe();
  }

  wait 5;
  var_0 scripts\sp\anim::_id_1EC7(var_1, "lounge_sitting_intro");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "lounge_sitting_idle");
  scripts\engine\utility::flag_wait("lift_complete");
  _id_0EFB::_id_FDBA(var_1);
}

_id_F9CD() {
  var_0 = scripts\engine\utility::getStruct("moon_lounge_medic_scene", "targetname");
  var_1 = _id_0EF8::_id_FDFC("spawner_medic", var_0, "cheap");
  var_2 = _id_0EF8::_id_FDFC("spawner_marine_casual", var_0, "cheap");
  var_0 scripts\sp\anim::_id_1ECA(var_1, "medic_scene_guyA_intro");
  var_0 thread scripts\sp\anim::_id_1ECC(var_2, "medic_scene_guyB_idle");

  while(distance(_id_0EEB::_id_7976("return").origin, level._id_E44A.origin) > 600) {
    scripts\engine\utility::waitframe();
  }

  wait 5.5;
  var_1 scripts\engine\utility::delaythread(2.5, scripts\sp\utility::_id_10347, "sc_moon_med1_getmeanivpush");
  var_0 scripts\sp\anim::_id_1EC7(var_1, "medic_scene_guyA_intro");
  var_0 thread scripts\sp\anim::_id_1ECC(var_1, "medic_scene_guyA_idle");
  level thread _id_B0B7(var_1, var_2);
  scripts\engine\utility::flag_wait("lift_complete");
  _id_0EFB::_id_FDBA(var_1);
  _id_0EFB::_id_FDBA(var_2);
}

_id_B0B7(var_0, var_1) {
  var_0 endon("death");
  level endon("salter_hallway_midway_vo");

  if(scripts\engine\utility::flag("salter_hallway_midway_vo")) {
    return;
  }
  wait 2;
  var_1 scripts\sp\utility::_id_10347("sc_moon_crw1_theygotusman");
  wait 5;
  var_0 scripts\sp\utility::_id_10347("sc_moon_med1_keepyoureyes");
  wait 12;
  var_0 scripts\sp\utility::_id_10347("sc_moon_med1_ineedanabg");
}

_id_F9CA() {
  _id_0EF8::_id_FDFC("spawner_brooks_casual", "moon_lounge_brooks_wait", "cheap");
  thread _id_E42F();
}

_id_E42F() {
  level._id_30F6 endon("death");
  var_0 = scripts\engine\utility::getStruct("moon_lounge_brooks_wait", "targetname");
  level._id_6022 scripts\sp\anim::_id_1EC3(level._id_30F6, "lounge_intro");

  while(distance(_id_0EEB::_id_7976("return").origin, level._id_E44A.origin) > 600) {
    scripts\engine\utility::waitframe();
  }

  level._id_6022 scripts\sp\anim::_id_1F35(level._id_30F6, "lounge_intro");
  level._id_6022 thread scripts\sp\anim::_id_1EEA(level._id_30F6, "lounge_idle_1", "stop_brooks_idle");

  for(;;) {
    if(distance2d(level._id_30F6.origin, level.player.origin) < 200) {
      if(level.player scripts\sp\utility::_id_D637(level._id_30F6 gettagorigin("j_head"))) {
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }

  level._id_6022 notify("stop_brooks_idle");
  level._id_6022 scripts\sp\anim::_id_1F35(level._id_30F6, "lounge_chat");
  level._id_6022 thread scripts\sp\anim::_id_1EEA(level._id_30F6, "lounge_idle_2", "stop_brooks_idle");
  scripts\engine\utility::flag_wait("lift_complete");
  _id_0EFB::_id_FDBA(level._id_30F6);
}

_id_F8EB() {
  _id_0EF8::_id_FDFC("spawner_omar", "moon_lounge_omar_wait", "cheap");
  _id_0EF8::_id_FDFC("spawner_kash_casual", "moon_lounge_kash_wait", "cheap");
  level._id_C24B = _id_0EF8::_id_FDFC("spawner_nunez_casual", "moon_lounge_nunez_wait", "cheap");
  level._id_B33A = _id_0EF8::_id_FDFC("spawner_marcus", "moon_lounge_nunez_wait", "cheap");
  level._id_C24B._id_1FBB = "nunez";
  level._id_B33A._id_1FBB = "marcus";
  level._id_60A5 = [level._id_C47F, level._id_30F6, level._id_A538, level._id_C24B, level._id_B33A];
  level._id_C47F thread _id_E440();
  level._id_A538 thread _id_E437();
  level._id_B33A thread _id_E43A();
  level._id_C24B thread _id_E43F();
}

_id_E42E() {
  level thread _id_0B21::_id_5A43("deck_return_elevator", "locked");
  wait 1;
  level.elevators["return"] thread _id_10C2F();
  level thread _id_0EEB::_id_60F0("return", 110);
  level thread _id_0EEB::_id_60FD("return", "Bridge Level");
  scripts\engine\utility::flag_set("elevator_started");
}

_id_E444() {
  scripts\sp\anim::_id_17FC("salter", "play_anim_door_intro", "play_anim_door_intro", "SH_MN_1_4B_MEET_TEAM_XO_door_scene");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_reyesgettheothe", "on_door", "SH_MN_1_4B_MEET_TEAM_XO_door_scene");
  scripts\sp\anim::_id_17FC("salter", "end", "end", "SH_MN_1_4B_MEET_TEAM_XO_door_scene");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_whathappenedtoh", "move_elev_again", "SH_MN_1_4B_MEET_TEAM_XO_elev_scene");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_moon_slt_weneedfacetimew", "face_time", "SH_MN_1_4B_MEET_TEAM_XO_door_scene");
  level thread _id_D25F();
  level waittill("salter_elev_intro_done");
  level._id_6021 scripts\sp\anim::_id_1F35(self, "SH_MN_1_4B_MEET_TEAM_XO_door_scene");
  self unlink();
  level._id_EA2C.a.movement = "stop";
  level._id_EA2C.goalradius = 2048;
  scripts\engine\utility::flag_set("elevator_scene_complete");
}

_id_D25F() {
  level waittill("face_time");
  wait 2.0;
  level.player scripts\sp\utility::_id_1034D("sc_moon_plr_yeahwedontsacri");
}

_id_E440() {
  self endon("death");
  level endon("stop_hallway_scene");
  scripts\sp\anim::_id_17FA("omar", "swap_dogtags", "swap_dogtags", "SH_MN_1_5A_LOUNGE_MCO_hallway_scene");
  level._id_6022 thread scripts\sp\anim::_id_1EEA(self, "SH_MN_1_5A_LOUNGE_MCO_hallway_idle", "stop_omar_loop");
}

_id_E437() {
  self endon("death");
  self dontcastshadows();
  level._id_6022 thread scripts\sp\anim::_id_1EEA(self, "SH_MN_1_5A_LOUNGE_MR2_hallway_idle", "stop_loop");
  thread _id_E438();
  scripts\engine\utility::flag_wait("lift_complete");
  _id_0EFB::_id_FDBA(self);
}

_id_E438() {
  self endon("death");

  while(!scripts\sp\interaction_manager::_id_9EED(120)) {
    scripts\engine\utility::waitframe();
  }

  scripts\sp\utility::_id_10346("sc_moon_ksh_ishouldagrabbed");
}

_id_E43F() {
  self endon("death");
  level._id_6022 thread scripts\sp\anim::_id_1EEA(self, "SH_MN_1_5A_LOUNGE_NUN_hallway_idle", "stop_nunez_loop");
  scripts\engine\utility::flag_wait("lift_complete");
  _id_0EFB::_id_FDBA(self);
}

_id_E43A() {
  self endon("death");
  self dontcastshadows();
  level._id_6022 thread scripts\sp\anim::_id_1EEA(self, "SH_MN_1_5A_LOUNGE_MAR_hallway_idle", "stop_marcus_loop");
  scripts\engine\utility::flag_wait("lift_complete");
  _id_0EFB::_id_FDBA(self);
}

_id_B03B() {
  self playSound("elevator_creak");
  wait 2.0;

  while(scripts\engine\utility::flag("elevator_moving")) {
    screenshake(level.player.origin, 0, 0.5, 0.25, 1.2, 0.2, 1, 512, 10, 10, 10);
    self playSound("elevator_creak");
    wait(randomfloatrange(2.5, 4.0));
  }
}

_id_10C2F() {
  if(!scripts\engine\utility::flag_exist("elevator_moving")) {
    scripts\engine\utility::flag_init("elevator_moving");
  }

  scripts\engine\utility::flag_set("elevator_moving");
  screenshake(level.player.origin, 0, 0.75, 0.35, 2, 0.2, 1.5, 512, 15, 15, 15);
  self playSound("elevator_strain");
  _id_B03B();
}

_id_10FE9() {
  scripts\engine\utility::flag_clear("elevator_moving");
}

_id_13937() {
  level._id_828C thread _id_0B6A::_id_EC0A("moon_outside_elevator_gibson_finish");
  wait 1;
  level._id_6754 thread _id_0B6A::_id_EC0A("moon_outside_elevator_ethan_finish");
}

_id_302F() {
  thread _id_FA36();
  thread _id_F8E9();
  thread _id_30CC();
}

_id_30CC() {
  var_0 = _id_10AB::_id_780D("moon_lounge_40", "sc_ambient_lounge_moon");
  var_1 = _id_10AB::_id_780D("moon_lounge_41", "sc_ambient_lounge_moon");
  var_0 endon("death");
  var_1 endon("death");

  while(!var_1 scripts\sp\interaction_manager::_id_9EED(90)) {
    scripts\engine\utility::waitframe();
  }

  var_0 _id_AD4C("sc_moon_crw_holdonwellneed");
  var_1 _id_AD4C("sc_moon_un2_justgetme");
  var_0 _id_AD4C("sc_moon_crw_yourenogood");
}

_id_AD4C(var_0) {
  self _meth_82A2(%facial_talk_1, 7, 0.25, 1);
  scripts\sp\utility::_id_10346(var_0);
  self _meth_82A2(%facial_talk_1, 0, 0.25, 0);
}

_id_FA36() {
  scripts\engine\utility::flag_init("salter_in_lift_idle");
  scripts\engine\utility::flag_init("salter_started_lift_intro");
  scripts\engine\utility::flag_init("salter_hallway_nag_vo");
  scripts\engine\utility::flag_init("salter_hallway_entrance_vo");
  scripts\engine\utility::flag_init("salter_hallway_midway_vo");
  scripts\engine\utility::flag_init("salter_hallway_blocked_vo");
  var_0 = _id_0B20::_id_794A("bridge")._id_5A3C;
  var_1 = var_0 scripts\engine\utility::spawn_script_origin();
  var_2 = getstartorigin(var_1.origin, var_1.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_XO_down"));
  var_3 = getstartangles(var_1.origin, var_1.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_XO_down"));
  level._id_2FF3 = scripts\engine\utility::spawn_script_origin(var_2, var_3);
  level._id_2FF2 = var_1;
  level thread _id_EAF4();
  level._id_EA2C thread _id_EAC6(var_0);
  wait 1;
  level._id_EA2C _id_EA52();
  var_4 = _id_0EF1::_id_789F("salter_moon");
  level._id_EA2C _id_0EE5::_id_202D(undefined, "sc_moon_slt_halftheseguyswe", var_4);
}

_id_EAC6(var_0) {
  self endon("skip_intro");
  scripts\engine\utility::flag_wait_any("player_entered_bridgehallway", "salter_to_bridge");
  level._id_EA2C _id_0EE5::_id_10FC4();
  thread _id_EA53();
  thread _id_EA51();
  thread _id_EA55();
  scripts\engine\utility::flag_wait("elevator_scene_complete");
  _id_0B6A::_id_EC0A(level._id_2FF3, undefined, undefined, undefined, undefined, 1);
  level._id_2FF3 delete();
  scripts\engine\utility::flag_set("salter_started_lift_intro");
  var_0 scripts\sp\anim::_id_1F35(self, "SH_MN_1_6_DEBRIS_XO_down");
  level._id_EA2C thread _id_EA93(level._id_2FF2);
  level._id_EA2C thread _id_0A1E::_id_2307(::_id_3038, ::_id_11A4);
}

_id_EAF4() {
  level endon("player_entered_bridgehallway");
  scripts\engine\utility::flag_wait("player_entered_lounge");
  wait 0.1;
  scripts\engine\utility::flag_waitopen("player_entered_lounge");
  scripts\engine\utility::flag_set("salter_to_bridge");
}

_id_EA52() {
  setmusicstate("mx_200_shipcribtitan_levelstart_loop");
  self endon("kill_hallway_entrance_vo");
  scripts\engine\utility::flag_set("salter_hallway_entrance_vo");
  level._id_EA2C scripts\sp\utility::_id_10346("sc_moon_slt_letsgetonthebri");
  wait 0.5;
  scripts\engine\utility::flag_clear("salter_hallway_entrance_vo");
}

_id_EA55() {
  self endon("kill_hallway_nag_vo");
  level endon("player_reached_bridgedoor");
  wait 30;
  scripts\engine\utility::flag_waitopen("salter_hallway_entrance_vo");
  scripts\engine\utility::flag_waitopen("salter_hallway_midway_vo");
  scripts\engine\utility::flag_waitopen("salter_hallway_blocked_vo");
  thread _id_EA54();
}

_id_EA54() {
  scripts\engine\utility::flag_set("salter_hallway_nag_vo");
  scripts\sp\utility::_id_10346("sc_moon_slt_reyesimwaitinon");
  wait 0.5;
  scripts\engine\utility::flag_clear("salter_hallway_nag_vo");
}

_id_EA53() {
  self endon("kill_hallway_midway_vo");
  scripts\engine\utility::flag_wait("player_entered_bridgehallway");
  scripts\engine\utility::flag_waitopen("salter_hallway_entrance_vo");
  scripts\engine\utility::flag_waitopen("salter_hallway_nag_vo");
  scripts\engine\utility::flag_set("salter_hallway_midway_vo");
  level.player scripts\sp\utility::_id_1034D("sc_moon_plr_captainprotectshis");
  level.player scripts\sp\utility::_id_1034D("sc_moon_plr_heshouldvepulled");
  wait 0.5;
  scripts\engine\utility::flag_clear("salter_hallway_midway_vo");
}

_id_EA51() {
  self endon("kill_blocked_vo");
  scripts\engine\utility::flag_wait("salter_started_lift_intro");
  scripts\engine\utility::flag_waitopen("salter_hallway_nag_vo");
  scripts\engine\utility::flag_waitopen("salter_hallway_entrance_vo");
  scripts\engine\utility::flag_waitopen("salter_hallway_midway_vo");
  scripts\engine\utility::flag_set("salter_hallway_blocked_vo");
  scripts\sp\utility::_id_10346("sc_moon_slt_bridgeentrysblo");
  wait 0.5;
  scripts\engine\utility::flag_clear("salter_hallway_blocked_vo");
}

_id_11A4() {
  level._id_2FF2 delete();
}

#using_animtree("script_model");

_id_F8E9() {
  var_0 = _id_0B20::_id_794A("bridge")._id_5A3C;
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  setmusicstate("");
  scripts\engine\utility::exploder("omar_sparks");
  level thread _id_3040(var_1, var_0);
  var_0 clearanim(%root, 0.0);
  var_1 scripts\sp\anim::_id_1EC3(var_0, "SH_MN_1_6_DEBRIS_DOOR_open");
  var_2 = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  var_2 hide();
  var_3 = spawn("script_model", (0, 0, 0));
  var_3 scripts\sp\utility::_id_23CA();
  var_3 setModel("body_hero_protagonist");
  var_3._id_1FBB = "hero_char";
  var_3 hide();
  var_4 = getEnt("moon_lift_obstacle", "targetname");
  var_4._id_1FBB = "server";
  var_1 scripts\sp\anim::_id_1EC3(var_2, "SH_MN_1_6_DEBRIS_lift_idle");
  wait 0.05;
  var_5 = scripts\engine\utility::getStruct("moon_bridgehallway_cursorhint", "targetname");
  var_6 = scripts\engine\utility::spawn_tag_origin(var_2 gettagorigin("J_Wrist_RI"), var_2 gettagangles("J_Wrist_RI"));
  var_6 _id_0E46::_id_48C4("tag_origin", (0, 0, 0), undefined);
  var_6 _id_0E46::_id_9016();
  level thread _id_CFA7(0);
  var_0 clearanim(%root, 0.0);
  var_1 scripts\sp\anim::_id_1EC3(var_0, "SH_MN_1_6_DEBRIS_DOOR_open");
  level._id_C47F thread _id_0EE5::_id_10FC4();

  if(isDefined(level._id_6021)) {
    level._id_6021 notify("stop_omar_loop");
    level._id_6021 notify("stop_loop");
  }

  level notify("stop_hallway_scene");
  level._id_EA2C thread _id_3046(var_1);
  level._id_C47F thread _id_3041(var_1);
  level thread _id_3044(var_1, var_2, var_3);
  level thread _id_303C(var_1, var_0);
  level thread _id_303A(var_1);
  level thread _id_303E(var_1);
  level thread _id_303D();
  level thread _id_3049(var_1, [level._id_EA2C, var_2], var_4, var_0);
  level thread _id_303B();
  level thread _id_3043();
  scripts\engine\utility::flag_set("lift_in_progress");
  scripts\engine\utility::flag_wait_all("player_ready_to_lift", "salter_ready_to_lift");
  var_7 = scripts\engine\utility::spawn_tag_origin(level.player getEye() + anglesToForward(level.player.angles) * 50.0, level.player.angles);
  var_7 thread _id_0E46::_id_48C4("tag_origin", undefined, &"SHIPCRIB_MOON_HOLD", undefined, undefined, undefined, 1, undefined, undefined, undefined, undefined, 1);
  var_7 linkTo(var_4);
  scripts\engine\utility::flag_wait("lift_complete");
  scripts\engine\utility::noself_delaycall(23, ::waitforalltransients);
  var_7 thread _id_0E46::_id_DFE3();
  var_7 delete();
  level waittill("debris_lift_done");
  thread _id_257F();
  level thread _id_0B20::_id_5A2E("bridge", "unlocked");
  wait 0.45;
  level.player _meth_84FD();
  scripts\sp\utility::_id_10FEC("omar_sparks");
  level thread _id_BB0D();
  level thread _id_BB0B();
  level thread _id_2FF6();
}

_id_303B() {
  setsaveddvar("scr_dof_enable", "1");
  setsaveddvar("r_dof_hq", "1");
  thread _id_0B0A::_id_583F(0, 0, 0, 40, 70, 3, 1);
  level waittill("dof_1");
  thread _id_0B0A::_id_583F(0, 0, 0, 160, 180, 3, 1);
  wait 2.5;
  thread _id_0B0A::_id_583F(0, 0, 0, 20, 60, 3, 1);
  level waittill("dof_2");
  thread _id_0B0A::_id_583F(0, 0, 0, 160, 180, 3, 1);
  wait 2.75;
  thread _id_0B0A::_id_583F(0, 0, 0, 30, 42, 3, 1);
  level waittill("playanim_door");
  _id_0B0A::_id_583F(0, 0, 0, 160, 180, 0, 1);
  thread _id_0B0A::_id_583D(1);
  setsaveddvar("r_dof_hq", "0");
}

_id_303A(var_0) {
  scripts\engine\utility::flag_wait("shipcrib_moon_bridge_tr_loaded");

  if(!isDefined(level._id_1044B)) {
    _id_0EF8::_id_FDFC("spawner_sotomura", "homebase");
  }

  var_0 scripts\sp\anim::_id_1EC3(level._id_1044B, "SH_MN_1_6_DEBRIS_BSN_scene");
  level waittill("playanim_bsn_nav");
  var_0 scripts\sp\anim::_id_1F35(level._id_1044B, "SH_MN_1_6_DEBRIS_BSN_scene");
}

_id_303E(var_0) {
  scripts\engine\utility::flag_wait("shipcrib_moon_bridge_tr_loaded");

  if(!isDefined(level._id_76FB)) {
    _id_0EF8::_id_FDFC("spawner_gator", level._id_C6AA["retribution"]._id_EF67.origin);
  }

  var_0 scripts\sp\anim::_id_1EC3(level._id_76FB, "SH_MN_1_6_DEBRIS_NAV_scene");
  level waittill("playanim_bsn_nav");
  var_0 scripts\sp\anim::_id_1F35(level._id_76FB, "SH_MN_1_6_DEBRIS_NAV_scene");
}

_id_303D() {
  scripts\engine\utility::flag_wait("shipcrib_moon_bridge_tr_loaded");

  if(!isDefined(level._id_5CFC)) {
    _id_0EF8::_id_FDFC("spawner_drop_officer", "homebase");
  }

  var_0 = scripts\engine\utility::getStruct("cinematic_drop_officer_animnode", "targetname");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_5CFC, "SH3_11_EUR_SH_BR_OPS_DO_idle");
  var_0 = scripts\engine\utility::getStruct("cinematic_dead_xo_animnode", "targetname");
  var_1 = _id_0EF8::_id_FE01("spawner_interior", var_0.targetname, "cheap");
  level._id_4DEC = var_1;
  level._id_4DEC._id_1FBB = "dead_xo";
  level._id_4DEC setModel("body_un_crew_ship_a_drk");
  level._id_4DEC detach(level._id_4DEC.headmodel);
  level._id_4DEC attach("head_bg_var_head_sc_male_15_head_male_bc_01", "", 1);
  level._id_4DEC.headmodel = "head_bg_var_head_sc_male_15_head_male_bc_01";

  if(isDefined(level._id_4DEC.hatmodel)) {
    level._id_4DEC detach(level._id_4DEC.hatmodel);
  }

  var_0 thread scripts\sp\anim::_id_1EEA(level._id_4DEC, "moon_2_4_bodies_corpse05");
}

_id_3046(var_0) {
  if(!scripts\engine\utility::flag("salter_hallway_midway_vo")) {
    level._id_EA2C notify("kill_hallway_midway_vo");
  }

  if(!scripts\engine\utility::flag("salter_hallway_entrance_vo")) {
    level._id_EA2C notify("kill_hallway_entrance_vo");
  }

  if(!scripts\engine\utility::flag("salter_hallway_nag_vo")) {
    level._id_EA2C notify("kill_hallway_nag_vo");
  }

  if(!scripts\engine\utility::flag("salter_hallway_blocked_vo")) {
    level._id_EA2C notify("kill_blocked_vo");
  }

  if(!scripts\engine\utility::flag("salter_started_lift_intro")) {
    level._id_EA2C notify("skip_intro");

    if(isDefined(level._id_2FF3)) {
      level._id_2FF3 delete();
    }

    scripts\engine\utility::flag_wait("player_start_lift");
    level._id_EA2C notify("stop_loop");
    level._id_EA2C scripts\sp\interaction::_id_9A0F();
    level._id_EA2C _meth_83A1();
    level._id_EA2C _id_0A1E::_id_2385();
    scripts\sp\anim::_id_1F12(level._id_EA2C);
    var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH_MN_1_6_DEBRIS_XO_intro");
    var_0 scripts\sp\anim::_id_1EE0(level._id_EA2C, "SH_MN_1_6_DEBRIS_XO_intro");
  }

  scripts\engine\utility::flag_set("salter_ready_to_lift");
  scripts\engine\utility::flag_wait("player_start_lift");
  level._id_EA2C thread scripts\sp\utility::_id_7799(level.player, 1.0, 0.2);
  level._id_EA2C scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_7798, level.player);
  _id_0B20::_id_794A("bridge")._id_5A3C notify("stop_loop_salter");

  while(!isDefined(level.player._id_B3C2)) {
    scripts\engine\utility::waitframe();
  }

  level._id_EA2C thread scripts\sp\utility::_id_77B9(1.0);
  scripts\engine\utility::flag_wait("lift_complete");
  var_0 scripts\sp\anim::_id_1F35(self, "SH_MN_1_6_DEBRIS_XO_lift");
}

_id_3044(var_0, var_1, var_2) {
  scripts\sp\anim::_id_17FC("player_rig", "playanim_door", "playanim_door", "SH_MN_1_6_DEBRIS_PLR_lift");
  scripts\sp\anim::_id_17FC("player_rig", "end", "lift_anim_end", "SH_MN_1_6_DEBRIS_PLR_lift");
  scripts\sp\anim::_id_17FC("player_rig", "playanim_bsn_nav", "playanim_bsn_nav", "SH_MN_1_6_DEBRIS_PLR_lift");
  scripts\sp\anim::_id_17FC("player_rig", "hide_viewmodel", "hide_viewmodel", "SH_MN_1_6_DEBRIS_PLR_lift");
  scripts\sp\anim::_id_17FC("player_rig", "show_protag", "show_protag", "SH_MN_1_6_DEBRIS_PLR_lift");
  var_0 scripts\sp\anim::_id_1EC3(var_1, "SH_MN_1_6_DEBRIS_PLR_lift_start");
  var_0 scripts\sp\anim::_id_1EC3(var_2, "SH_MN_1_6_DEBRIS_HRO_lift");
  wait 0.05;
  var_3 = level.player scripts\engine\utility::spawn_tag_origin();
  var_3.origin = level.player.origin;
  var_3.angles = level.player getplayerangles();
  level.player playerlinkTo(var_3, "tag_origin", 1, 0, 0, 0, 0, 0);
  level.player _meth_823C(var_1, "tag_player", 0.5, 0.25, 0.25);
  wait 0.55;
  level.player playerlinktodelta(var_1, "tag_player", 0, 0, 0, 0, 0, 1);
  var_1 show();
  scripts\engine\utility::flag_set("player_start_lift");
  level thread _id_3045();
  var_0 scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_6_DEBRIS_PLR_lift_start");
  var_1 setanimknob(var_1 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"), 1.0, 0.2);
  level.player _meth_84FE();
  scripts\engine\utility::flag_set("player_ready_to_lift");
  scripts\engine\utility::flag_wait("lift_complete");
  level notify("stop_mash");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_6_DEBRIS_PLR_lift");
  var_0 thread scripts\sp\anim::_id_1F35(var_2, "SH_MN_1_6_DEBRIS_HRO_lift");
  level waittill("show_protag");
  var_1 hide();
  var_2 show();
  var_2 scripts\engine\utility::delaycall(0.25, ::attach, "head_hero_protagonist");
  level waittill("hide_viewmodel");
  _id_0B0A::_id_583F(0, 300, 3, 100, 500, 3, 1);
  wait 1.5;
  level notify("debris_lift_done");
  wait 3.0;
  level notify("lift_anim_end");
  var_1 delete();
  var_2 delete();

  if(isDefined(level._id_6021)) {
    level._id_6021 notify("stop_loop");
    level._id_6021 delete();
  }
}

_id_3045() {
  scripts\engine\utility::flag_waitopen("salter_hallway_blocked_vo");
  scripts\engine\utility::flag_waitopen("salter_hallway_entrance_vo");
  scripts\engine\utility::flag_waitopen("salter_hallway_nag_vo");
  scripts\engine\utility::flag_waitopen("salter_hallway_midway_vo");
  scripts\engine\utility::play_sound_in_space("sc_moon_plr_letsdoit", level.player.origin);
}

_id_303C(var_0, var_1) {
  level waittill("playanim_door");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_6_DEBRIS_DOOR_open");
  level waittill("lift_anim_end");
  var_1 clearanim(var_1 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_DOOR_open"), 0.2);
  level thread _id_0B20::_id_5A2E("bridge", "locked");
}

_id_3041(var_0) {
  scripts\sp\anim::_id_17FC("omar", "vo_sc_moon_omr_illhelpyoulieut", "dof_1", "SH_MN_1_6_DEBRIS_MCO_lift");
  scripts\sp\anim::_id_17FC("omar", "vo_sc_moon_omr_efforts", "dof_2", "SH_MN_1_6_DEBRIS_MCO_lift");
  scripts\sp\anim::_id_17FC("omar", "mayhem_start", "mayhem", "SH_MN_1_6_DEBRIS_MCO_lift");
  scripts\engine\utility::flag_wait("lift_complete");
  var_0 scripts\sp\anim::_id_1EC3(self, "SH_MN_1_6_DEBRIS_MCO_lift");
  thread _id_3042();
  scripts\engine\utility::flag_wait("lift_complete");
  var_0 scripts\sp\anim::_id_1F35(self, "SH_MN_1_6_DEBRIS_MCO_lift");
}

_id_3043() {
  scripts\engine\utility::flag_wait("player_ready_to_lift");
  wait 1.0;
  level waittill("mayhem");
  wait 3.0;
  level._id_EA2C hide();
}

#using_animtree("generic_human");

_id_3042() {
  self endon("death");
  level waittill("mayhem");
  self _meth_82A2(%mayhem_sh_mn_1_6_debris_mco_lift, 1.0, 0.0, 1.0);
  self detach(self.headmodel);
  wait(getanimlength(scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_MCO_lift")));
  self _meth_82A2(%mayhem_sh_mn_1_6_debris_mco_lift, 0.0, 0.0, 1.0);
  self attach(self.headmodel);
}

_id_3040(var_0, var_1) {
  var_2 = getEnt("moon_lift_obstacle", "targetname");
  var_2._id_1FBB = "server";
  var_2 scripts\sp\anim::_id_F64A();
  var_0 scripts\sp\anim::_id_1EC3(var_2, "SH_MN_1_6_DEBRIS_SERVER_lift_mash");
  scripts\engine\utility::flag_wait("salter_ready_to_lift");
  scripts\engine\utility::flag_wait("player_ready_to_lift");
  scripts\engine\utility::flag_wait("lift_complete");
  var_0 scripts\sp\anim::_id_1F35(var_2, "SH_MN_1_6_DEBRIS_SERVER_lift");
}

_id_3049(var_0, var_1, var_2, var_3) {
  setmusicstate("");
  scripts\engine\utility::flag_wait_all("player_ready_to_lift", "salter_ready_to_lift");
  var_0 notify("stop_player_loop");
  level thread _id_32DE();
  level thread _id_3047(var_0, var_1, var_2, var_3);
  level._id_EA2C thread _id_0A1E::_id_2307(::_id_3038);
  level._id_EA2C notify("skip_intro");
  level._id_EA2C notify("salter_lift_start");
}

_id_3038() {
  level endon("lift_complete_salter");
  self endon("salter_lift_start");

  for(;;) {
    wait 0.05;
  }
}

_id_3047(var_0, var_1, var_2, var_3) {
  var_2 thread _id_303F(var_0, var_3);

  foreach(var_5 in var_1) {
    var_6 = getstartorigin(var_0.origin, var_0.angles, var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"));
    var_7 = getstartangles(var_0.origin, var_0.angles, var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"));

    if(isai(var_5)) {
      var_5 _meth_80F1(var_6, var_7, 100000);
    } else {
      var_5.origin = var_6;
      var_5.angles = var_7;
      var_5 dontinterpolate();
    }

    var_5 setanimknob(var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"), 1.0, 0.5);
  }

  wait 0.5;

  for(;;) {
    if(isDefined(level.player._id_B3C2)) {
      break;
    }

    wait 0.05;
  }

  level thread _id_3048(var_0, var_1, var_2, var_3);
}

_id_EA93(var_0) {
  level endon("start_lift_state");
  self notify("salter_lift_start");
  self endon("salter_lift_start");
  self endon("skip_intro");
  var_1 = getstartorigin(var_0.origin, var_0.angles, scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"));
  var_2 = getstartangles(var_0.origin, var_0.angles, scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"));
  self _meth_80F1(var_1, var_2, 100000);
  self setanimknob(scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"), 1.0, 0.2);

  for(;;) {
    var_1 = getstartorigin(var_0.origin, var_0.angles, scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"));
    var_2 = getstartangles(var_0.origin, var_0.angles, scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"));
    self _meth_80F1(var_1, var_2, 100000);
    self setanimknob(scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"), 1.0, 0.2);
    wait 0.05;
  }
}

_id_303F(var_0, var_1) {
  var_2 = getstartorigin(var_0.origin, var_0.angles, scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_SERVER_lift_mash"));
  var_3 = getstartangles(var_0.origin, var_0.angles, scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_SERVER_lift_mash"));
  self.origin = var_2;
  self.angles = var_3;
  self setanimknob(scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_SERVER_lift_mash"), 1.0, 0.5, 0.0);
}

_id_3048(var_0, var_1, var_2, var_3) {
  level._id_EA2C thread scripts\sp\utility::play_sound_on_entity("sc_moon_slt_efforts");
  level.player thread scripts\sp\utility::play_sound_on_entity("sc_moon_plr_efforts");
  level.player thread _id_FBB6();

  foreach(var_5 in var_1) {
    var_6 = getstartorigin(var_0.origin, var_0.angles, var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"));
    var_7 = getstartangles(var_0.origin, var_0.angles, var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"));

    if(isai(var_5)) {
      var_5 _meth_80F1(var_6, var_7, 100000);
    } else {
      var_5.origin = var_6;
      var_5.angles = var_7;
    }

    var_5 setanimknob(var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_idle"), 0.0, 0.5);
    var_5 setanimknob(var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"), 1.0, 0.5);
  }

  var_2 setanimknob(var_2 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"), 1.0, 0.5);
  wait 1.0;

  for(;;) {
    var_9 = var_1[0] islegacyagent(var_1[0] scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"));

    if(isDefined(level.player._id_B3C2)) {
      foreach(var_5 in var_1) {
        var_5 setanimknob(var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"), 1.0, 0.5, 1.0);
      }

      var_2 setanimknob(var_2 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"), 1.0, 0.5, 1.0);
    } else {
      level.player notify("lift_fail");

      foreach(var_5 in var_1) {
        var_5 setanimknob(var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"), 1.0, 0.5, -1.5);
      }

      var_2 setanimknob(var_2 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"), 1.0, 0.5, -1.5);
    }

    if(var_9 <= 0.0) {
      break;
    }

    if(var_9 >= 1.0) {
      scripts\engine\utility::flag_set("lift_success");
      scripts\engine\utility::flag_set("lift_complete");
      level.player notify("lift_complete");
      return;
    }

    wait 0.25;
  }

  foreach(var_5 in var_1) {
    var_5 setanimknob(var_5 scripts\sp\utility::_id_7DC1("SH_MN_1_6_DEBRIS_lift_mash"), 0.0, 0.5, 0.0);
  }

  level thread _id_3047(var_0, var_1, var_2, var_3);
}

_id_FBB6() {
  var_0 = spawn("script_origin", level._id_EA2C.origin);
  var_1 = spawn("script_origin", level.player.origin);
  var_0 playSound("sh_mn_1_6_debris_xo_lift_mash_01");
  var_1 playSound("sh_mn_1_6_debris_plr_lift_mash_01");
  var_1 playSound("sh_mn_1_6_debris_obj_lift_mash_01");
  scripts\engine\utility::waittill_any("lift_fail", "lift_complete");
  var_0 scripts\sp\utility::_id_10460(1.5);
  var_1 scripts\sp\utility::_id_10460(1.5);
}

_id_32DE() {
  level endon("stop_mash");
  level.player notifyonplayercommand("kc_respawn", "+activate");
  level.player._id_B3C2 = undefined;
  var_0 = 0;

  for(;;) {
    if(level.player useButtonPressed()) {
      var_0 = var_0 + 1.0;
    } else {
      var_0 = 0.0;
    }

    if(var_0 >= 15.0) {
      level.player._id_B3C2 = 1;
      level.player playRumbleOnEntity("light_1s");
    } else
      level.player._id_B3C2 = undefined;

    wait 0.05;
  }
}

_id_2FF6() {
  level._id_EFED = "inside_slow";
  var_0 = _id_0B20::_id_794A("captains_quarters")._id_5A3C scripts\engine\utility::spawn_tag_origin();
  var_1 = scripts\sp\utility::_id_10639("player_rig");
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "SH_MN_CapOps_Digic_Pickup_Plr");
  level.player disableusability();
  level.player scripts\engine\utility::delaycall(0.1, ::_meth_823C, var_1, "tag_player", 0.05, 0, 0);
  level.player scripts\engine\utility::delaycall(0.2, ::playerlinktodelta, var_1, "tag_player", 0, 10, 10, 10, 10, 1);
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8392, 0.2, 2.2, 0.6);
  level thread _id_3001(var_0, var_1);
  wait 0.25;

  if(isDefined(level._id_EA2C)) {
    level thread _id_0EFB::_id_FDBA(level._id_EA2C);
  }

  if(isDefined(level._id_C47F)) {
    level thread _id_0EFB::_id_FDBA(level._id_C47F);
  }

  if(isDefined(level._id_76FB)) {
    level thread _id_0EFB::_id_FDBA(level._id_76FB);
  }

  if(isDefined(level._id_1044B)) {
    level thread _id_0EFB::_id_FDBA(level._id_1044B);
  }

  if(isDefined(level._id_5CFC)) {
    level thread _id_0EFB::_id_FDBA(level._id_5CFC);
  }

  if(isDefined(level._id_4DEC)) {
    level thread _id_0EFB::_id_FDBA(level._id_4DEC);
  }

  level waittill("bridge_intro_bink_done");
  level.player enableusability();
}

_id_2FF4() {
  level._id_EFED = "inside_slow";
  level _id_0B20::_id_AB71(self, "left_push", 0.4);
  level thread _id_0B20::_id_5A52("bridge", ::_id_2FF5);
}

_id_2FF5() {
  level._id_EFED = "inside";
  level _id_0B20::_id_AB71(self, "left_pull", 0.4);
  level thread _id_0B20::_id_5A52("bridge", ::_id_2FF4);
}

_id_3001(var_0, var_1) {
  level thread _id_0B20::_id_5A52("bridge", ::_id_2FF5);
  thread _id_0B0B::_id_257D(211.37, "shipcrib_titan_bridge", undefined, "shipcrib_titan_captain_room");
  level.player scripts\engine\utility::delaycall(0.1, ::enableweapons);
  level thread scripts\sp\utility::_id_CE10("sc_moon_cutscene_take_charge", undefined, 211.37);
  thread _id_0B0A::_id_583F(0, 100, 2, 1000, 2000, 3, 0);
  level waittill("skippable_cinematic_done");
  level notify("bridge_intro_bink_done");
  level thread _id_3077(var_0, var_1);
}

_id_4923() {
  level.moon hide();
  level._id_118A8 = scripts\sp\vehicle::_id_1080C("tigris");
  var_0 = _id_10B45();
  _id_F9E3(var_0);
}

_id_10B45() {
  var_0 = scripts\engine\utility::spawn_tag_origin((500000, -10000, 5000), (0, 0, 0));
  var_0.angles = (0, 0, 0);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_planet_moon_approach_02"), var_0, "tag_origin");
  return [var_0];
}

_id_FD51() {
  level endon("stop_ship_mover");
  level endon("stop_moon_battle");
  var_0 = randomfloatrange(1000, 1500);

  for(;;) {
    self moveTo(self.origin + anglesToForward(self.angles) * var_0, 60.0, 30.0, 30.0);
    self rotateTo(self.angles + (0, 0, 10), 60.0, 30.0, 30.0);
    wait 60.0;
    self moveTo(self.origin + anglesToForward(self.angles) * (var_0 * -1), 60.0, 30.0, 30.0);
    self rotateTo(self.angles + (0, 0, -10), 60.0, 30.0, 30.0);
    wait 60.0;
  }
}

_id_FD65() {
  level endon("stop_ship_mover");
  level endon("stop_moon_battle");

  for(;;) {
    playFX(scripts\engine\utility::getfx("vfx_muzflash_capital_30mm_looping_small"), self.origin + anglestoup(self.angles) * 250, anglesToForward(self.angles));
    wait(randomfloatrange(1, 2));
  }
}

_id_F9E3(var_0) {
  level endon("stop_moon_battle");
  level thread _id_118BF();
  level._id_1027D = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level.moon linkTo(level._id_1027D);

  foreach(var_2 in var_0) {
    var_2 linkTo(level._id_1027D);
  }

  level._id_1027D rotateTo(level._id_1027D.angles + (10, 0, 45), 0.05, 0, 0);
  level._id_1027D moveTo(level._id_1027D.origin + anglesToForward(level._id_1027D.angles) * 20000, 0.05, 0, 0);
  wait 0.05;
  level._id_1027D rotateTo((2, 5, 20), 60.0, 0, 30.0);
  level._id_1027D moveTo((0, 0, 0), 60.0, 0, 30.0);
  wait 60.0;
  level thread _id_409B(var_0);
}

_id_409B(var_0) {
  level waittill("stop_moon_battle");

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

_id_118BF() {
  level endon("stop_moon_battle");
  var_0 = level._id_118A8 scripts\engine\utility::spawn_tag_origin();
  level._id_118A8 linkTo(var_0);
  var_1 = var_0.origin + anglesToForward(level._id_E35D._id_3BB6.angles) * 10000;
  var_1 = var_1 + anglestoup(var_0.angles) * 2000;
  var_2 = var_0.angles + (0, 60, 0);
  var_0 moveTo(var_1, 60.0, 30.0, 30.0);
  var_0 rotateTo(var_2, 60.0, 30.0, 30.0);
  wait 60.0;
  level._id_118A8 unlink();
  level._id_118A8 linkTo(level._id_1027D);
  var_0 delete();
}

_id_3077(var_0, var_1) {
  _id_30AC();
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "SH_MN_CapOps_Digic_Pickup_Plr");
  level._id_EA2C thread _id_3075(var_0);
  level thread _id_13687(var_1);
  level scripts\engine\utility::delaythread(4.0, ::bridge_scene_transients);
  level thread scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_4093();
  level thread scripts\sp\interaction_manager::_id_F2A7("busy");
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(0, _id_0EDE::_id_C683, "calculation", "moon");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level thread _id_308B();
  level thread _id_3020();
  level._id_76FB scripts\engine\utility::delaythread(0.05, _id_0EFB::_id_CD3F, "opsmap_gator_react");
  level._id_5CFC scripts\engine\utility::delaythread(0.05, _id_0EFB::_id_CD3F, "opsmap_drops_react");
  scripts\engine\utility::flag_set("enable_moon_bridge_door");
  scripts\engine\utility::flag_wait("start_bridge_scene");
  thread _id_0B0A::_id_583D(2);
  level thread _id_F072();
  level thread _id_0B20::_id_5A2E("bridge", "locked");
  level thread _id_0B21::_id_5A43("bridge_exit", "locked");
  level thread _id_0B21::_id_5A43("return_elevator", "locked");
  level._id_76FB thread _id_7722();
  level thread _id_3062(var_0);
  level._id_1044B thread _id_30B5();
  level._id_4451 thread _id_2FE7();
  level._id_C6AA["retribution"] _id_0EDE::_id_C670("up");
  level._id_C6AA["retribution"]._id_7488 thread _id_0E46::_id_DFE3();
  var_2 = level._id_C6AA["retribution"]._id_7488 scripts\engine\utility::spawn_tag_origin();
  var_2.origin = var_2.origin + anglestoright(var_2.angles) * -10;
  var_2 thread _id_0E46::_id_48C4(undefined, undefined, undefined, 45, 750, 50, 0);
  var_2 waittill("trigger");
  var_2 delete();
  level thread _id_CFA7(0);
  level thread scripts\sp\interaction_manager::_id_11037();
  level notify("ftl triggered");
  wait 0.05;
  level notify("start_group_vignette");
  level thread _id_4416();
  level scripts\engine\utility::delaythread(6.0, _id_0EEE::_id_25B2);
  level thread _id_0EEE::_id_FD8B(1);
  var_0 notify("stop_loop");
  level notify("ftl_scene_start");
  level thread _id_308E();
  level waittill("player_ready");
  level._id_76FB thread _id_308C();
  level._id_EA2C thread _id_308F();
  level._id_5CFC thread _id_308A();
  level._id_1044B thread _id_3089();
  level thread _id_3087();
  level waittill("ferran_out");
  wait 0.5;
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C683("ftl", "moon");
  level thread _id_0EEE::_id_FD89("moon", "retribution", ::_id_A5D6, ::_id_4923, 7.0);
  level waittill("ftl_3_sec_left");
  level waittill("ftl_stop");
  lerpsunangles(getmapsunangles(), (-28, 24, 0), 0.4);
  level thread _id_0EFB::_id_FDBD(1, 0.05);
  level waittill("ftl_finished");
  visionsetalternate(5, 0);
  level thread _id_0EEE::_id_FD8A(1);
  _id_AB12();
}

bridge_scene_transients() {
  level thread scripts\sp\utility::_id_12651(["shipcrib_moon_halore_tr"]);
  level thread scripts\sp\utility::_id_12643(["shipcrib_moon_mezz_tr", "shipcrib_moon_hangar_tr"]);
}

_id_13687(var_0) {
  level waittill("unlock_player");
  level.player _meth_8391(0.2);
  level.player unlink();
  var_0 delete();
  level thread _id_CFA7(1);
}

_id_7722() {
  level endon("ftl triggered");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_76FB thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(level._id_76FB, "SH_MN_1_11_CREW_REACT_NAV_scene_01");
  level._id_76FB _id_0EFB::_id_CD3F("opsmap_gator_react");
  level._id_76FB thread _id_0EE5::_id_202D(undefined, "sc_moon_nav_dropcommenceson");
  self waittill("reminder_anim_done");
  level._id_76FB _id_0EE5::_id_10FC4();
  level._id_76FB _id_0EFB::_id_CD3F("opsmap_gator_react");
  level._id_76FB thread _id_0EE5::_id_202D();
}

#using_animtree("script_model");

_id_F072() {
  _id_0EE4::_id_E37A(0, 1, 1, 1);
  _id_39FD();
  _id_0B20::_id_794A("captains_quarters")._id_5A3C _meth_82A2(%shipcrib_door_right_push_long_open, 1, 0, 0);
  _id_0B20::_id_794A("captains_quarters")._id_5A3C _meth_82B0(%shipcrib_door_right_push_long_open, 0.0);
  _id_0EE4::_id_E37A(1, 0, 0, 0);
}

_id_39FD() {
  level endon("ftl_sequence_player_looking_down");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_1 = _id_0B20::_id_794A("captains_quarters")._id_5A3C;
  var_2 = 90000;

  for(;;) {
    if(distance2dsquared(level.player.origin, var_0.origin) <= var_2 && !scripts\sp\utility::_id_D1DF(var_1.origin, 0.6, 1)) {
      if(distance2dsquared(level._id_EA2C.origin, var_0.origin) <= var_2) {
        break;
      }
    }

    wait 0.05;
  }
}

_id_308B() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("ftl1", "playanim_extinguisher", "playanim_extinguisher", "ftl_sequence_moon");
  scripts\sp\anim::_id_17FC("ftl1", "stop_fire", "stop_fire", "ftl_sequence_moon");
  var_1 = scripts\sp\utility::_id_10639("extinguisher");
  var_0 scripts\sp\anim::_id_1EC3(var_1, "SH_MN_1_12_MOON_JUMP_EXTINGUISHER_scene_01");
  level waittill("fire_alert");
  var_2 = var_1.origin + anglestoright(var_1.angles) * 50;
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2, (0, 0, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_cabin_fire_small"), var_3, "tag_origin");
  thread scripts\engine\utility::exploder(75);
  level waittill("playanim_extinguisher");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_12_MOON_JUMP_EXTINGUISHER_scene_01");
  level waittill("stop_fire");
  wait 4.0;
  stopFXOnTag(scripts\engine\utility::getfx("vfx_cabin_fire_small"), var_3, "tag_origin");
  wait 10.0;
  killfxontag(scripts\engine\utility::getfx("vfx_cabin_fire_small"), var_3, "tag_origin");
  scripts\engine\utility::waitframe();
  var_3 delete();
}

_id_308C() {
  scripts\sp\anim::_id_17FC(self._id_1FBB, "playanim_farren_pip_01", "playanim_farren_pip_01", "SH_MN_1_12_MOON_JUMP_NAV_scene_01");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "playanim_farren_pip_02", "playanim_farren_pip_02", "SH_MN_1_12_MOON_JUMP_NAV_scene_01");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "playanim_ftl_jump", "playanim_ftl_jump", "SH_MN_1_12_MOON_JUMP_NAV_scene_01");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "playanim_boats_exit", "playanim_boats_exit", "SH_MN_1_12_MOON_JUMP_NAV_scene_01");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "playanim_monitor", "playanim_monitor", "SH_MN_1_12_MOON_JUMP_NAV_scene_01");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "vo_sc_moon_nav_influxin321", "ftl_3_sec_left", "SH_MN_1_12_MOON_JUMP_NAV_scene_01");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "ftl_stop", "ftl_stop", "SH_MN_1_12_MOON_JUMP_NAV_scene_01");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level waittill("start_plr_ftl");
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH_MN_1_12_MOON_JUMP_NAV_scene_01");
  thread _id_0EFB::_id_CD3F("opsmap_gator_react");

  for(;;) {
    if(distance2d(level.player.origin, self.origin) >= 200.0) {
      break;
    }

    wait 0.05;
  }

  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH_MN_1_12_MOON_JUMP_NAV_ops_to_conn");
  thread _id_0EFB::_id_CD3F("opsmap_conn_react");
}

_id_3020() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_1 = level._id_C6AA["retribution"]._id_BA11["nav"];
  var_0 scripts\sp\anim::_id_1EC3(var_1, "SH_MN_1_12_MOON_JUMP_MONITOR_scene_01");
  level waittill("playanim_monitor");
  var_0 scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_12_MOON_JUMP_MONITOR_scene_01");
}

_id_308F() {
  scripts\sp\anim::_id_17FC(self._id_1FBB, "playanim_phone", "playanim_phone", "SH_MN_1_12_MOON_JUMP_XO_scene_01");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "vo_sc_moon_slt_awayin321", "salter_pa_line", "SH_MN_1_12_MOON_JUMP_XO_scene_01");
  level thread _id_3074();
  level thread _id_3073();
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_1 = scripts\engine\utility::getStruct("bridge_ai_elevator_doors", "targetname");
  _id_7497(var_0);
  level waittill("playanim_ftl_jump");
  thread _id_0EFB::_id_11004();
  thread scripts\sp\utility::_id_F3DC(var_1.origin);
  var_0 scripts\sp\anim::_id_1F35(self, "SH_MN_1_12_MOON_JUMP_XO_scene_01");
  level._id_EA2C notify("SH_MN_1_12_MOON_JUMP_XO_scene_01");
}

_id_7497(var_0) {
  if(scripts\engine\utility::flag("salter_opsmap_ready")) {
    _id_0EFB::_id_906D();
  } else {
    level waittill("ftl_sequence_player_looking_down");
    var_0 scripts\sp\anim::_id_1EC3(self, "SH_MN_1_12_MOON_JUMP_XO_scene_01");
    wait 0.05;
    thread _id_0EFB::_id_CD3F("opsmap_salter_react");
    wait 2.0;
    _id_0EFB::_id_906D();
  }

  level notify("salter_ftl_starting");
}

_id_3074() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_1 = level._id_C6AA["retribution"]._id_CACE["xo"];
  level waittill("playanim_phone");
  var_0 scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_12_MOON_JUMP_PHONE_scene_01");
}

_id_3073() {
  level waittill("salter_pa_line");
  level.player scripts\sp\utility::play_sound_on_entity("sc_moon_slt_awayin321_pa");
}

_id_308A() {
  scripts\sp\anim::_id_17FC(self._id_1FBB, "vo_sc_moon_dpo_collisionalarms", "collision_alarms", "SH_MN_1_12_MOON_JUMP_DO_scene_01");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "vo_sc_moon_dpo_cpufireinbridge", "fire_alert", "SH_MN_1_12_MOON_JUMP_DO_scene_01");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  _id_0EFB::_id_906D();
  level waittill("playanim_ftl_jump");
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH_MN_1_12_MOON_JUMP_DO_scene_01");
  thread _id_0EFB::_id_CD3F("opsmap_drops_react");
}

_id_3089() {
  var_0 = _id_0EEB::_id_7976("bridge");
  var_1 = getstartorigin(var_0.origin, var_0.angles + (0, 180, 0), level._id_1044B scripts\sp\utility::_id_7DC1("leave_elevator_performance"));
  var_2 = level._id_C6AA["retribution"]._id_EF67;
  level._id_1044B scripts\sp\interaction::_id_9A0F();
  _id_0EFB::_id_11004();
  var_3 = _id_0EFB::_id_EFDB("boats");
  var_3 thread scripts\sp\anim::_id_1EEA(self, "shipcrib_standing_console_idle_01_fem");
  level waittill("playanim_boats_exit");
  var_3 notify("stop_loop");
  scripts\sp\utility::_id_F3DC(var_1);
  var_2 scripts\sp\anim::_id_1F35(self, "SH_MN_1_12_MOON_JUMP_BSN_exit");
  level._id_1044B notify("SH_MN_1_12_MOON_JUMP_BSN_exit");
}

_id_308E() {
  var_0 = level._id_C6AA["retribution"]._id_EF68;
  scripts\sp\anim::_id_17FC("player_rig", "start_plr_ftl", "start_plr_ftl", "SH_MN_1_12_MOON_JUMP_PLR_ftl_jump");
  level thread _id_D1AD();
  level thread _id_E655();
  var_1 = scripts\sp\utility::_id_10639("player_rig", var_0.origin, var_0.angles);
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "SH_MN_1_12_MOON_JUMP_PLR_ftl_jump");
  scripts\engine\utility::waitframe();
  level.player playerlinkTo(var_1);
  level.player _meth_823C(var_1, "tag_player", 0.5);
  wait 0.55;
  level.player playerlinktodelta(var_1, "tag_player", 1, 20, 20, 20, 0, 1);
  level.player _meth_8392(0.2, 2.2, 0.6);
  var_1 show();

  if(level._id_10CDA == level._id_5019) {
    level thread _id_0EFB::shipcrib_autosave_now_silent();
  }

  level notify("player_ready");
  level thread scripts\sp\utility::_id_C12D("ftl_sequence_player_looking_down", 7.25);
  var_0 scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_12_MOON_JUMP_PLR_ftl_jump");
  level.player unlink();
  var_1 delete();
}

_id_D1AD() {
  var_0 = level._id_C6AA["retribution"]._id_EF68;
  var_1 = scripts\sp\utility::_id_10639("keycard");
  var_1._id_1FBB = "keycard";
  var_1 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_1, "SH_MN_1_12_MOON_JUMP_keycard_ftl_jump");
  wait 0.05;
  level waittill("player_ready");
  var_1 show();
  var_0 scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_12_MOON_JUMP_keycard_ftl_jump");
  var_1 delete();
}

_id_E655() {
  var_0 = level._id_C6AA["retribution"]._id_EF68;
  var_1 = level._id_C6AA["retribution"]._id_454F["captain"];
  var_1._id_1FBB = "shipcrib_cap_console";
  var_1 scripts\sp\anim::_id_1EC3(var_1, "SH_MN_1_12_MOON_JUMP_table_ftl_jump");
  wait 0.05;
  level waittill("player_ready");
  var_1 scripts\sp\anim::_id_1F35(var_1, "SH_MN_1_12_MOON_JUMP_table_ftl_jump");
}

_id_3087() {
  level waittill("playanim_farren_pip_01");
  level thread _id_0EF3::_id_FD78("pip", "sc_world_moon_bridge_01");
  wait 7.0;
  level._id_118A8 scripts\engine\utility::delaythread(1.0, ::_id_30A6);
  level notify("ferran_out");
  level waittill("playanim_farren_pip_02");
  _id_0EF3::_id_FD78("pip", "sc_world_moon_bridge_02");
}

_id_30A6() {
  thread _id_118B5();
  level._id_118A8 thread _id_0BB8::_id_3991();
  wait 3.0;
  screenshake(level.player.origin, 2, 2, 2, 0.35, 0, 0.25, 850, 15, 15, 15);
}

_id_118B5() {
  level._id_118A8 playSound("scn_tigris_ftl_buildup_lr");
  level._id_118A8 waittill("ftl_complete");
  level._id_118A8 playSound("scn_tigris_ftl_out_lr");
}

_id_30AC() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_C6AA["retribution"]._id_10E52["xo"]._id_EE92 = "opsmap_salter_react";
  level._id_C6AA["retribution"]._id_10E52["nav"]._id_EE92 = "opsmap_gator_react";
  level._id_C6AA["retribution"]._id_10E52["drop"]._id_EE92 = "opsmap_drops_react";
  _id_0EF8::_id_FDFC("spawner_gator", level._id_C6AA["retribution"]._id_10E52["nav"]);
  _id_0EF8::_id_FDFC("spawner_drop_officer", level._id_C6AA["retribution"]._id_10E52["drop"]);
  _id_0EF8::_id_FDFC("spawner_sotomura", "homebase");
  _id_0EF8::_id_FDFC("spawner_comms", "homebase");
  _id_0EF8::_id_FDFC("spawner_salter_dirty");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl3", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac4", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys3", _id_0EFB::_id_EFDB("drop"));
  level._id_76FB scripts\engine\utility::delaythread(0.2, _id_0EFB::_id_906D);
  level scripts\engine\utility::delaythread(1.0, _id_0EF0::_id_FDA0);
}

_id_3062(var_0) {
  level._id_76FB endon("death");
  level._id_EA2C endon("death");
  level endon("ftl_scene_start");
  scripts\engine\utility::flag_wait("salter_opsmap_ready");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_moon_slt_asxoisuggestwec");
  level._id_76FB scripts\sp\interaction_manager::_id_DB7B(undefined, "SH_MN_1_11_CREW_REACT_NAV_scene_02", var_0);
  level._id_5CFC thread _id_0EE5::_id_202D(undefined, "sc_moon_dpo_bestcaseitllbea");
  level._id_EA2C thread _id_0EE5::_id_202D(undefined, "sc_moon_slt_readywhenyouare");
  level thread scripts\sp\interaction_manager::_id_E815(30.0);
}

_id_3075(var_0) {
  self endon("death");
  level endon("salter_ftl_starting");
  scripts\sp\anim::_id_17FC(level._id_EA2C._id_1FBB, "unlock_player", "unlock_player", "SH_MN_1_10B_OFFICE_XO_scene");
  var_1 = getstartorigin(level._id_C6AA["retribution"]._id_EF67.origin, level._id_C6AA["retribution"]._id_EF67.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("shipcrib_bridge_ops_hero_XO_idle_01"));
  level._id_EA2C thread scripts\sp\utility::_id_F3DC(var_1);
  wait 0.05;
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH_MN_1_10B_OFFICE_XO_scene");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 scripts\sp\anim::_id_1F0D(level._id_EA2C, "shipcrib_bridge_ops_hero_XO_idle_01");
  level._id_EA2C scripts\sp\anim::_id_1F35(level._id_EA2C, "shipcrib_bridge_stand_opsmap_transition_in_xo");
  scripts\engine\utility::flag_set("salter_opsmap_ready");
  level._id_EA2C thread _id_0EFB::_id_CD3F("opsmap_salter_react");
}

_id_2FF0(var_0) {
  self endon("death");
  level endon("ftl_scene_start");
  thread scripts\sp\interaction_manager::_id_CD24(85.0, 50.0, "sc_moon_dpo_bestcaseitllbea");
}

_id_30B5(var_0) {
  self endon("death");
  level endon("ftl_scene_start");
  thread _id_0EE5::_id_202D(undefined, "sc_moon_bts_afiercebattleah");
}

_id_2FE7(var_0) {
  self endon("death");
  level endon("ftl_scene_start");
  thread _id_0EE5::_id_202D();
}

_id_BB0D() {
  var_0 = scripts\engine\utility::getStructArray("space_welder", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = _id_0EF8::_id_FDFC("spawner_miner", var_3, "cheap");
    var_4 _id_0EFB::_id_FD6F("space_miner");
    var_3 thread scripts\sp\anim::_id_1EEA(var_4, var_3.animation, "stop_loop");
    var_4 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_4 scripts\sp\utility::_id_7DC1(var_3.animation)[0], randomfloat(1));
    var_1[var_1.size] = var_4;
  }

  level waittill("ftl_scene_start");
  _id_0EFB::_id_FDBB("space_miner");
}

_id_BB0B() {
  level thread _id_BB08();
  level thread _id_BB07();
  level waittill("ftl triggered");

  foreach(var_1 in level._id_BB08) {
    var_1 rotateTo(var_1.angles, 0.05);
    var_1 moveTo(var_1.origin, 0.05);
  }
}

_id_BB07() {
  var_0 = getEnt("debris_big_origin", "script_noteworthy");
  var_1 = getEntArray("debris_big", "script_noteworthy");
  scripts\engine\utility::array_call(var_1, ::linkto, var_0);
  var_0 thread _id_FD45();
  level._id_BB09 = var_1;
  level._id_BB0A = var_0;
}

_id_BB08() {
  var_0 = scripts\engine\utility::getStructArray("debris_rot", "script_noteworthy");
  var_1 = ["tag_fx_explo_bg", "tag_fx_explo_md", "tag_fx_explo_sm", "tag_fx_fire_bg", "tag_fx_fire_md"];
  level._id_BB08 = [];

  foreach(var_3 in var_0) {
    var_4 = spawn("script_model", var_3.origin);
    var_4.angles = var_3.angles;
    var_4 setModel(var_3.script_modelname);
    var_4 notsolid();
    var_4 dontcastshadows();
    level._id_BB08 = scripts\engine\utility::array_add(level._id_BB08, var_4);
    var_4 thread _id_4E9A();

    if(isDefined(var_3.target)) {
      var_4 thread _id_4E90(var_3.target);
    }
  }

  foreach(var_4 in level._id_BB08) {
    scripts\engine\utility::waitframe();

    if(isDefined(var_4)) {
      var_4 _id_4E85(var_1);
    }
  }
}

_id_4E85(var_0) {
  self endon("death");
  var_1 = getnumparts(self.model);

  for(var_2 = 1; var_2 < var_1; var_2++) {
    var_3 = getpartname(self.model, var_2);
    var_4 = getsubstr(var_3, 0, var_3.size - 4);

    if(scripts\engine\utility::array_contains(var_0, var_4)) {
      playFXOnTag(scripts\engine\utility::getfx(var_4), self, var_3);
    }

    switch (var_2) {
      case 18:
      case 15:
      case 12:
      case 9:
      case 6:
      case 3:
        scripts\engine\utility::waitframe();
        break;
      default:
    }
  }
}

kill_debris_fx() {
  var_0 = ["tag_fx_explo_bg", "tag_fx_explo_md", "tag_fx_explo_sm", "tag_fx_fire_bg", "tag_fx_fire_md"];
  var_1 = getnumparts(self.model);

  for(var_2 = 1; var_2 < var_1; var_2++) {
    var_3 = getpartname(self.model, var_2);
    var_4 = getsubstr(var_3, 0, var_3.size - 4);

    if(scripts\engine\utility::array_contains(var_0, var_4)) {
      killfxontag(scripts\engine\utility::getfx(var_4), self, var_3);
    }
  }
}

_id_4E9A() {
  self endon("death");
  level endon("ftl triggered");
  self.angles = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
  wait 0.05;
  thread _id_11CA();
}

_id_11CA() {
  level endon("ftl triggered");
  var_0 = (randomfloatrange(-5, 5), randomfloatrange(-5, 5), randomfloatrange(-5, 5));

  for(;;) {
    self rotateTo(self.angles + var_0, 1.0);
    wait 1.0;
  }
}

_id_4E90(var_0) {
  self endon("death");
  level endon("ftl triggered");
  var_1 = _id_0EFB::_id_7D7A(var_0);
  var_2 = 1500;
  self moveTo(var_1.origin, var_2, 0, var_2);
}

_id_4E8B() {
  level notify("kill_debris");
  level notify("stop_idle_listing_motion");

  foreach(var_1 in level._id_BB09) {
    var_1 kill_debris_fx();
  }

  foreach(var_1 in level._id_BB08) {
    var_1 kill_debris_fx();
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::array_call(level._id_BB09, ::delete);
  scripts\engine\utility::array_call(level._id_BB08, ::delete);
  level._id_BB0A delete();
}

_id_FD45() {
  self endon("death");
  self endon("stop_idle_listing_motion");
  var_0 = spawn("script_origin", self.origin);
  var_0.angles = self.angles;
  self linkTo(var_0);
  _id_FD46(var_0);
  self unlink();
  var_0 delete();
}

_id_FD46(var_0) {
  self endon("death");
  self endon("stop_idle_listing_motion");
  level endon("ftl triggered");
  var_1 = 20;
  var_2 = var_1 / 2;
  var_3 = var_1 / 2;

  for(;;) {
    var_4 = randomfloatrange(100, 300);
    var_5 = randomfloatrange(100, 300);
    var_6 = randomfloatrange(50, 200);

    if(scripts\engine\utility::cointoss()) {
      var_4 = var_4 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_5 = var_5 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_6 = var_6 * -1;
    }

    var_7 = randomfloatrange(1, 3);
    var_8 = randomfloatrange(2, 5);
    var_9 = randomfloatrange(1.5, 4);

    if(scripts\engine\utility::cointoss()) {
      var_7 = var_7 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_8 = var_8 * -1;
    }

    if(scripts\engine\utility::cointoss()) {
      var_9 = var_9 * -1;
    }

    var_0 moveTo(var_0.origin + (var_4, var_5, var_6), var_1, var_2, var_3);
    var_0 rotateTo(var_0.angles + (var_7, var_8, var_9), var_1, var_2, var_3);
    var_0 waittill("movedone");
    wait(randomfloatrange(0, 2));
    var_0 moveTo(var_0.origin - (var_4, var_5, var_6), var_1, var_2, var_3);
    var_0 rotateTo(var_0.angles - (var_7, var_8, var_9), var_1, var_2, var_3);
    var_0 waittill("movedone");
    wait(randomfloatrange(0, 2));
  }
}

_id_4416() {
  level._id_1027D = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level._id_FD6E._id_10288 linkTo(level._id_1027D);
  level._id_118A8 unlink();
  level._id_118BE = level._id_118A8 scripts\engine\utility::spawn_tag_origin();
  level._id_118A8 linkTo(level._id_118BE);

  foreach(var_1 in level._id_BB08) {
    var_1 linkTo(level._id_1027D);
  }

  level._id_BB0A linkTo(level._id_1027D);
  level._id_5FC1 linkTo(level._id_1027D);
  level._id_1027D rotateTo(level._id_1027D.angles + (2, 35, 2), 25.0, 10.0, 15.0);
  level._id_118BE rotateTo(level._id_118BE.angles + (8, 60, 8), 30.0, 10.0, 10.0);
  var_3 = level._id_118BE.origin + anglesToForward(level._id_118BE.angles) * 10000;
  var_3 = var_3 + anglestoup(level._id_118BE.angles) * 500;
  var_3 = var_3 + anglestoright(level._id_118BE.angles) * 2000;
  level._id_118BE moveTo(var_3, 30.0, 10.0, 10.0);
  wait 25.0;
  level._id_FD6E._id_10288 unlink();
}

_id_A5D6() {
  if(isDefined(level._id_118A8)) {
    level._id_118A8 unlink();
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_sc_moon_space_debris_field_02_dense"), level._id_5FC1, "tag_origin");
  level._id_5FC1 delete();

  foreach(var_1 in level._id_BB08) {
    var_1 unlink();
  }

  level._id_1027D delete();
  level._id_118BE delete();
  level thread _id_4E8B();

  if(isDefined(level._id_118A8)) {
    level._id_118A8 _id_0BA9::_id_397B();
  }

  level._id_FD6E._id_10288 hide();
}

_id_AB12() {
  _id_9860();
  _id_BBFE();
  scripts\engine\utility::flag_set("lgt_trigger_leave_elevator");
  level thread _id_CFA7(1);
  thread _id_2207();
  _id_AB0D();
  thread _id_AB10();
  var_0 = getEnt("moon_bridgeelev_player_collision", "targetname");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  _id_0EEB::_id_7976("bridge") waittill("move_finished");
  scripts\engine\utility::flag_clear("elevator_started");
  level notify("stop_moon_battle");
  _id_10FE9();
  level thread _id_0B21::_id_5A43("mezzanine_elevator", "open");
  _id_0EFB::_id_FDBA(level._id_76FB);
  _id_0EFB::_id_FDBA(level._id_5CFC);
  level thread scripts\sp\utility::_id_12651(["shipcrib_moon_bridge_tr"]);
  _id_BBFD();
}

_id_9860() {
  scripts\engine\utility::flag_init("boats_on_leave_elevator");
  scripts\engine\utility::flag_init("boats_on_leave_elevator_ready");
  scripts\engine\utility::flag_init("boats_leave_elevator_done");
  scripts\engine\utility::flag_init("salter_on_leave_elevator");
  scripts\engine\utility::flag_init("salter_on_leave_elevator_ready");
  scripts\engine\utility::flag_init("salter_leave_elevator_done");
}

_id_F70B(var_0, var_1) {
  self waittill(var_1);
  scripts\engine\utility::flag_set(var_0);
}

_id_BBFE() {
  var_0 = _id_0EEB::_id_7976("bridge");
  level._id_EA2C scripts\sp\interaction::_id_9A0F();
  thread _id_BC12(var_0);
  thread _id_BC67(var_0);
  level waittill("playanim_boats_exit");
  level scripts\engine\utility::delaythread(0.5, _id_0B21::_id_5A43, "bridge_exit", "open");
}

_id_BC12(var_0) {
  level._id_1044B waittill("SH_MN_1_12_MOON_JUMP_BSN_exit");
  wait 0.5;
  scripts\engine\utility::delaythread(0.2, ::_id_2C02);
  level._id_1044B _id_2BEA("boats_on_leave_elevator", "boats_on_leave_elevator_ready", "shipcrib_stand_idle05_arrival", 5);
}

_id_BC67(var_0) {
  level._id_EA2C waittill("SH_MN_1_12_MOON_JUMP_XO_scene_01");
  level._id_EA2C thread _id_0B6A::_id_EC0A("bridge_ai_elevator_doors");
  var_1 = scripts\engine\utility::getStruct("bridge_ai_elevator_doors", "targetname");
  level._id_EA2C _id_1375D(var_1, 150);

  if(distance2d(level.player.origin, var_1.origin) > 335 && level.player _id_9D65(level._id_EA2C)) {
    level._id_EA2C waittill("sceneblock_reach_finished");
    level._id_EA2C scripts\sp\utility::_id_7799(level.player);

    while(distance2d(level.player.origin, level._id_EA2C.origin) > 275 && !level.player _id_9D65(level._id_EA2C)) {
      scripts\engine\utility::waitframe();
    }

    level._id_EA2C scripts\sp\utility::_id_77B9(0.7);
  }

  level._id_EA2C _id_2BEA("salter_on_leave_elevator", "salter_on_leave_elevator_ready", "shipcrib_stand_idle04_arrival", 4);
}

_id_2BEA(var_0, var_1, var_2, var_3) {
  var_4 = _id_7ABE();
  _id_0B6A::_id_EC0A(var_4, undefined, undefined, undefined, undefined, 1);
  scripts\engine\utility::flag_set(var_0);
  var_5 = scripts\engine\utility::spawn_tag_origin();
  var_5 linkTo(_id_0EEB::_id_7976("bridge"));
  self linkTo(_id_0EEB::_id_7976("bridge"));
  var_5 scripts\sp\anim::_id_1EC7(self, var_2);
  scripts\engine\utility::flag_set(var_1);
  _id_0EE5::_id_202D(var_3);
  var_5 delete();
}

_id_7ABE() {
  if(!isDefined(self._id_B110)) {
    var_0 = _id_0EEB::_id_7976("bridge") scripts\engine\utility::spawn_tag_origin();
    var_0.angles = var_0.angles + (0, 180, 0);
    var_0.origin = var_0.origin + (0, 4, 0);
    var_1 = _id_7B74(var_0, self, "leave_elevator_performance");
    self._id_B110 = var_1;
  }

  return self._id_B110;
}

_id_2C02() {
  if(distance2d(level.player.origin, level._id_1044B.origin) < 300) {
    level._id_1044B scripts\sp\utility::_id_13861("on", level.player, "right");
    level._id_1044B _id_0C4C::_id_194E(level.player, 2, 1);
    wait 3;
    level._id_1044B _id_0C4C::_id_194F(1);
    level._id_1044B scripts\sp\utility::_id_13861("off", level.player, "right");
  } else
    wait 3;

  level._id_1044B waittill("sceneblock_reach_finished");
  level._id_1044B scripts\sp\utility::_id_7792(level.player, 1);
}

_id_AB0D() {
  scripts\engine\utility::flag_wait_all("boats_on_leave_elevator", "salter_on_leave_elevator");
  _id_0EEB::_id_7976("bridge").trigger waittill("trigger");
  waitforalltransients();
  level thread _id_0EE6::_id_2201(["iw7_m4"], 1);
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6("none");
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A6("iw7_m4");

  if(scripts\engine\utility::flag("salter_on_leave_elevator_ready")) {
    _id_0EEB::_id_60F0("bridge", 62);
  } else {
    _id_0EEB::_id_60F0("bridge", 54.5);
  }

  _id_0EEB::_id_7976("bridge") thread _id_10C2F();
  _id_0EEB::_id_60FD("bridge", "Mezzanine");
  scripts\engine\utility::flag_set("elevator_started");
  scripts\engine\utility::flag_wait("salter_on_leave_elevator_ready");
}

_id_F9C4() {
  var_0 = _id_0EEB::_id_7976("bridge");
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_1044B _id_0EE5::_id_10FC4();
  level._id_EA2C thread _id_12BAC(var_0, "move_finished");
  level._id_1044B thread _id_12BAC(var_0, "move_finished");
}

_id_AB10() {
  _id_F9C4();
  var_0 = _id_0EEB::_id_7976("bridge") scripts\engine\utility::spawn_tag_origin();
  var_0.angles = var_0.angles + (0, 180, 0);
  var_0.origin = var_0.origin + (0, 4, 0);
  var_0 linkTo(_id_0EEB::_id_7976("bridge"));
  level._id_EA2C thread _id_CD6E(var_0, "leave_elevator_performance", "shipcrib_stand_idle04_exit", ::_id_EABB, "salter_leave_elevator_done");
  level._id_1044B thread _id_CD6E(var_0, "leave_elevator_performance", "shipcrib_stand_idle05_exit", ::_id_2C01, "boats_leave_elevator_done");
}

_id_CD6E(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getanimlength(scripts\sp\utility::_id_7DC1(var_1));
  var_0 scripts\sp\anim::_id_1F35(self, var_1);
  var_0 scripts\sp\anim::_id_1EE0(self, var_1);
  var_6 = scripts\engine\utility::spawn_tag_origin();
  self thread[[var_3]]();
  var_6 scripts\sp\anim::_id_1EC7(self, var_2);
  _id_0B6A::_id_EC04();
  self.a.movement = "stop";
  scripts\engine\utility::flag_set(var_4);
  var_6 delete();
}

_id_1375D(var_0, var_1) {
  while(distance2d(self.origin, var_0.origin) > var_1) {
    scripts\engine\utility::waitframe();
  }
}

_id_9D65(var_0) {
  var_1 = scripts\sp\utility::_id_7951(var_0.origin, var_0.angles, self.origin);

  if(var_1 < 0) {
    return 1;
  } else {
    return 0;
  }
}

_id_7B74(var_0, var_1, var_2) {
  var_3 = level._id_EC85[var_1._id_1FBB][var_2];
  var_4 = getstartorigin(var_0.origin, var_0.angles, var_3);
  var_5 = getstartangles(var_0.origin, var_0.angles, var_3);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_4, var_5);
  return var_6;
}

_id_AD49(var_0, var_1) {
  self linkTo(var_0, "");
  var_0 waittill(var_1);
  self unlink();
}

_id_12BAC(var_0, var_1) {
  var_0 waittill(var_1);
  self unlink();
}

_id_4ED6() {
  for(;;) {
    scripts\engine\utility::draw_angles(self.angles, self.origin, (1, 0, 1), 120);
    wait 0.1;
  }
}

_id_2207() {
  thread _id_CD5A();
  scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_ADB1();
  thread _id_CC9E();
}

#using_animtree("generic_human");

_id_CD5A() {
  var_0 = scripts\engine\utility::getStruct("moon_jack_start", "targetname");
  level._id_A04F = _id_0EF8::_id_FDFC("spawner_mech_jack", var_0, "cheap");
  level._id_A04F endon("death");
  level._id_A04F._id_1FBB = "jack";
  _id_0E5E::main();
  _id_0E5F::main();
  var_0 scripts\sp\anim::_id_1EC3(level._id_A04F, "jack_intro");
  _id_0EEB::_id_7976("bridge") waittill("move_finished");
  level._id_A04F _id_10AB::_id_137C5();
  var_0 scripts\sp\anim::_id_1F35(level._id_A04F, "jack_intro");
  level._id_A04F _id_0EE5::_id_202D("hallway_jack_moon_blended_react", "Sir.");
  level._id_A04F waittill("interaction_done");
  level._id_A04F _id_0EE5::_id_10FC4();
  wait 0.5;
  level._id_A04F _id_0EE5::_id_202D("hallway_jack_moon_blended_react_2", "Sir.");
  level._id_A04F waittill("interaction_done");
  level._id_EC85["jack"]["jack_idle"][0] = % sh_mn_1_14a_arm_hall_jack_idle;
  level._id_A04F _id_0EE5::_id_10FC4();
  level._id_A04F scripts\sp\anim::_id_1EEA(level._id_A04F, "jack_idle");
}

_id_CC9E() {
  var_0 = level._id_2208[0];
  var_1 = level._id_2208[1];
  var_0 endon("death");
  var_1 endon("death");

  while(!var_0 scripts\sp\interaction_manager::_id_9EED(150)) {
    scripts\engine\utility::waitframe();
  }

  var_0 scripts\sp\utility::_id_10346("sc_moon_un5_diagnosticsaret");
  var_1 scripts\sp\utility::_id_10346("sc_moon_un6_imworkingonit");
  var_0 scripts\sp\utility::_id_10346("sc_moon_un5_youneedmeupther");
  var_1 scripts\sp\utility::_id_10346("sc_moon_un6_igotitjustletme");
}

_id_BBFD() {
  scripts\engine\utility::flag_wait("boats_leave_elevator_done");
  thread _id_2C00();
  wait 1.25;
  scripts\engine\utility::flag_wait("salter_leave_elevator_done");
  thread _id_EA85();
}

_id_EA85() {
  level endon("armory_started");
  scripts\engine\utility::flag_init("end_armoryhallway");
  level._id_EA2C _id_0B6A::_id_EC0B("moon_armoryhallway_salter_wait", "shipcrib_stand_stationary_talk_idle_04", "idle01");
  level._id_EA2C _id_0EE5::_id_202D(4, "sc_moon_slt_letsgetsomeguns");
}

_id_2C00() {
  level._id_1044B endon("death");
  level._id_1044B _id_0B6A::_id_EC0B("moon_armoryhallway_sotomura_wait", "shipcrib_stand_stationary_talk_idle_05", undefined, undefined, undefined, undefined, undefined, 1);
  level._id_1044B _id_0EE5::_id_202D(5, "sc_moon_bts_sir");
}

_id_2C01(var_0) {}

_id_EABB() {
  level._id_EA2C scripts\sp\utility::_id_7799(level._id_1044B, undefined, 1.5);
  wait 3;
  level._id_EA2C scripts\sp\utility::_id_77B9(0.5);
}

_id_21E3() {
  if(level._id_10CDA == level._id_5019) {
    level thread _id_0EFB::shipcrib_autosave_now_silent();
  }

  level notify("armory_started");
  thread _id_223C();
  level thread _id_0EE8::_id_F9E5();
  level scripts\engine\utility::delaythread(2, ::_id_2244);
  scripts\engine\utility::flag_set("lgt_trigger_leave_elevator_exit");

  if(level.player _meth_84C6("weaponsScanned", "iw7_ake") == "locked") {
    level._id_D9E5["weaponstates"]["iw7_ake"] = "scanned";
    level.player _meth_84C7("weaponsScanned", "iw7_ake", "scanned");
  }

  scripts\sp\loadout::_id_F56D("moon_port");
  level thread _id_0EE6::_id_2202();
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A7();
  level _id_0B20::_id_AB71(self, "moon_armory_enter", 0.4, undefined, 1, 1.1);
  level thread _id_0B20::_id_5A2E("armory", "locked");
}

_id_F8C2() {
  level thread scripts\sp\maps\shipcrib_moon\shipcrib_moon_lights::_id_2213();
  _id_0EFB::_id_FDBA(level._id_1044B);
  _id_0EFB::_id_FDBA(level._id_A04F);
  scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_4054();
  _id_0EF8::_id_FDFC("spawner_griff", "armory_officer_reaction_point");
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 scripts\sp\anim::_id_1EC3(level._id_8604, "armory_intro");
  level._id_8604 scripts\sp\utility::_id_65E0("ready_for_ake_intro");
  level._id_21FE = level._id_8604 scripts\sp\utility::_id_10639("armory_gun");
  var_0 scripts\sp\anim::_id_1EC3(level._id_21FE, "armory_intro");
  var_1 = getEntArray("armory_3d_printer", "targetname");

  foreach(var_3 in var_1) {
    if(distance2d(var_3.origin, level._id_8604.origin) < 300) {
      level._id_21F6 = var_3;
      level._id_21F6 scripts\sp\utility::_id_23B7("armory_3d_printer");
      level._id_21F6 scripts\sp\anim::_id_1EC3(level._id_21F6, "armory_intro");
      break;
    }
  }

  scripts\engine\utility::flag_init("armory_uniform_accessed");
  scripts\engine\utility::flag_init("terminal_use_finished");
  scripts\engine\utility::flag_init("armory_exited");
  _id_5503();
  thread _id_B9A7();
}

_id_223C() {
  _id_F8C2();
  level thread _id_CFA7(0);
  level thread scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_8A7F("armory");
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_EA2C _id_0B20::_id_5A4D("armory", 1);
  _id_CC99();
  level waittill("terminal_time");
  thread _id_8608();
  thread _id_DB89();
  _id_4965();
  _id_CE5B();
  level._id_EA2C _id_0B6A::_id_EC0D("armory_booth_salter_exit");
  _id_1380E();
  _id_EA35();
  level thread _id_0B20::_id_5A2E("armory_exit", "unlocked");
  var_0 = getEnt("armory_terminal_salter_playerclip", "targetname");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  level._id_11592 = 1;
  thread _id_564B();
  wait 1;
  _id_EA65();
}

_id_2244() {
  level _id_0A2F::_id_12642();
  level thread scripts\sp\utility::_id_12651(["shipcrib_moon_bridgee_tr", "shipcrib_moon_exterior_tr"]);
  level thread scripts\sp\utility::_id_12641("shipcrib_moon_welldeck_tr");
}

_id_DB89() {
  scripts\engine\utility::flag_wait("at_terminal");
  wait 3.5;
  _id_0EF7::_id_CD9D("ml_moon");
}

_id_5642() {}

_id_CC99() {
  thread _id_CDF2();
  thread _id_CD30();
}

_id_CDF2() {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "armory_intro");
  level._id_EA2C scripts\sp\utility::_id_F3DC(level._id_EA2C.origin);
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "armory_idle", "end_idle");
  level._id_EA2C _id_0EFB::_id_EB8D("moon_port");
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  scripts\engine\utility::flag_wait("at_terminal");
  var_0 notify("end_idle");
}

_id_CD30() {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_21FE, "armory_intro");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_8604, "armory_intro");
  level._id_21F6 thread scripts\sp\anim::_id_1F35(level._id_21F6, "armory_intro");
  var_1 = 2.5;
  var_2 = getanimlength(level._id_8604 scripts\sp\utility::_id_7DC1("armory_intro"));
  wait(var_2 - var_1);
  level notify("terminal_time");
  wait(var_1);
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_8604, "armory_idle", "end_griff_idle");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_21FE, "armory_idle", "end_gun_idle");
  level._id_21F6 thread scripts\sp\anim::_id_1EEA(level._id_21F6, "armory_idle", "end_printer_idle");
  level._id_8604 scripts\sp\utility::_id_65E1("ready_for_ake_intro");
}

_id_4965() {
  var_0 = _id_0EE8::_id_7CF3("player_terminal");
  var_0._id_EBF1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0._id_EBF1 scripts\sp\maps\shipcrib_moon\shipcrib_moon_code::_id_5B35();
  var_0._id_EBF1 delete();
}

_id_CE5B() {
  level notify("terminal_scene_started");
  var_0 = _id_0EE8::_id_7CF3("player_terminal");
  var_1 = _id_7BBB(var_0._id_BC97, "armory_scene");
  _id_BC56(var_1, 0.5);
  var_1 show();
  var_2 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  level._id_8604 scripts\sp\utility::_id_65E3("ready_for_ake_intro");
  var_2 notify("end_griff_idle");
  var_2 notify("end_gun_idle");
  var_2 notify("end_printer_idle");
  scripts\sp\anim::_id_17F6(level._id_8604._id_1FBB, "play_popup", ::_id_CCFD, "armory_scene");
  var_2 thread scripts\sp\anim::_id_1F35(level._id_8604, "armory_scene");
  var_2 thread scripts\sp\anim::_id_1F35(level._id_21FE, "armory_scene");
  level._id_21F6 thread scripts\sp\anim::_id_1F35(level._id_21F6, "armory_scene");
  var_0._id_BC97 thread scripts\sp\anim::_id_1F35(var_1, "armory_scene");
  level._id_8604 waittillmatch("single anim", "activate_armory_terminal");

  if(!level.console) {
    waitforalltransients();
  }

  var_0 notify("trigger");
  thread _id_116DE(var_1);
}

_id_116DE(var_0) {
  wait 1;
  var_0 hide();
  wait 2;
  var_0 delete();
  level._id_21FE delete();
  thread _id_2A57();
}

_id_CCFD(var_0) {
  scripts\sp\utility::_id_914C("fluff_messages_energy_weapon_header", "fluff_messages_energy_weapon_body", "eweapon_intel");
}

_id_7BBB(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_10639("player_rig");
  var_2 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_2, var_1);
  return var_2;
}

_id_BC56(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  level.player scripts\sp\utility::_id_F526("normal");
  level.player _meth_823C(var_0, "tag_player", var_1, var_1 / 2, var_1 / 2);
  wait(var_1);
  level.player _meth_823B(var_0, "tag_player");
}

_id_EA35() {
  level._id_EA2C attach("helmet_hero_xo");
  level._id_EA2C _id_0EF8::_id_FDFF("J_Neck");
}

_id_EA65() {
  level endon("airboss_scene_started");

  if(isDefined(level._id_EA2C._id_116DA)) {
    level._id_EA2C._id_116DA notify("stop_loop");
  }

  level._id_EA2C _id_0B6A::_id_EC0A("armory_ai_exit");
  level._id_EA2C thread _id_0EE5::_id_202D(undefined, "sc_moon_slt_letsgogetem");
  thread _id_EA33();
}

_id_564A() {
  while(scripts\engine\utility::flag("at_terminal")) {
    scripts\engine\utility::flag_wait("in_vr_mode");
    wait 10;

    if(scripts\engine\utility::flag("in_vr_mode")) {
      level.player playSound("sc_moon_amo_whenyouregoodtogo");
      level._id_8604 thread _id_0B6A::_id_EC0E("When you're good to go, press the Left and Right thumbsticks.");
      break;
    }
  }
}

_id_564B() {
  setmusicstate("mx_176_weapon_pickup");
  level._id_8604 scripts\sp\utility::_id_10346("sc_moon_grf_thatshouldgetth");
  level.player scripts\sp\utility::_id_1034D("sc_moon_plr_notonyourlife");
  level._id_8604 scripts\sp\utility::_id_10346("sc_moon_grf_giveemhellsirw");
}

_id_EA32() {
  if(!scripts\engine\utility::flag("armory_exited")) {
    level._id_EA2C scripts\sp\utility::_id_10346("sc_moon_slt_letsgogetem");
  }
}

_id_2A57() {
  level._id_8604 scripts\sp\utility::_id_51E1("casual_gun");
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  level._id_8604 _id_0EE4::_id_86E8();
  level._id_8604._id_110C9 scripts\sp\utility::_id_23B7("griff_weapon");
  var_0 thread _id_21FB();
}

_id_21FB() {
  level._id_8604 endon("death");
  var_0 = [level._id_8604, level._id_8604._id_110C9];
  var_1 = ["armory_ambient_vig_1", "armory_ambient_vig_2", "armory_ambient_vig_3", "armory_ambient_vig_4", "armory_ambient_vig_5", "armory_ambient_vig_6", "armory_ambient_vig_7", "armory_ambient_vig_8"];
  var_2 = var_1;
  self notify("stop_griff_idle");

  for(;;) {
    if(var_2.size == 0) {
      var_2 = var_1;
    }

    thread scripts\sp\anim::_id_1EE7(var_0, "armory_ambient_idle", "stop_armory_ambient_loop");
    var_3 = level._id_8604 scripts\sp\utility::_id_7DC1("armory_ambient_idle")[0];
    wait(getanimlength(var_3) * randomintrange(1, 2));
    self notify("stop_armory_ambient_loop");
    var_4 = var_2[randomintrange(0, var_2.size)];
    var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    scripts\sp\anim::_id_1F2C(var_0, var_4);
  }
}

_id_EAEE() {}

_id_8608() {
  level endon("terminal_scene_started");
  wait 20;

  if(!scripts\engine\utility::flag("at_terminal") && !scripts\engine\utility::flag("terminal_use_finished")) {
    var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
    var_0 notify("end_idle");
    var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "armory_nag");
    var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "armory_idle", "end_idle");
  }
}

_id_EA33() {
  level endon("airboss_scene_started");
  wait 15;

  if(!scripts\engine\utility::flag("armory_exited")) {
    level._id_EA2C scripts\sp\utility::_id_10346("sc_moon_slt_weshouldkickroc");
  }
}

_id_402E() {
  if(isDefined(level._id_8604._id_110C9)) {
    level._id_8604._id_110C9 delete();
  }

  level._id_8604 delete();
  level._id_A04F delete();
}

_id_B9A7() {
  level waittill("player_grabbed_weapon");
  scripts\engine\utility::flag_set("terminal_use_finished");
}

_id_1380E() {
  scripts\engine\utility::flag_wait("terminal_use_finished");
}

_id_61DA() {
  foreach(var_1 in level._id_116E3) {
    if(isDefined(var_1.script_parameters)) {
      if(var_1.script_parameters == "player_terminal") {
        var_1 _id_0E46::_id_48C4();
      }
    }
  }
}

_id_5503() {
  foreach(var_1 in level._id_116E3) {
    if(isDefined(var_1.script_parameters)) {
      if(var_1.script_parameters == "player_terminal") {
        var_1 _id_0E46::_id_DFE3();
      }
    }
  }
}

_id_1A71() {
  level._id_EA2C _id_0EE5::_id_10FC4();
  level notify("airboss_scene_started");
  level.player setstance("stand");
  scripts\sp\utility::_id_13C3C();
  thread audio_elev_ride_pa();
  _id_0EE6::_id_2200();
  _id_0EE6::_id_21A9();
  thread _id_1A73();
  level _id_0B20::_id_AB71(self, "airboss_door", 0.4);
  _id_0EFB::_id_FDBA(level._id_8604);
  level thread scripts\sp\utility::_id_1264E("shipcrib_moon_vr_tr");
}

_id_1A73() {
  _id_9836();
  var_0 = _id_0EEB::_id_7976("gravity");
  thread _id_8AAC();
  level.player _meth_82C0("shipcrib_moon_armory_pre_hangar", 0.0);
  level._id_BB47 = thread scripts\engine\utility::play_loopsound_in_space("sc_moon_hangar_alarm_high", (-784, 1699, -916));
  level thread scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_8A7F();
  level.player scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_D090, "ges_safe_door");
  level.player scripts\engine\utility::delaycall(1.6, ::clearclienttriggeraudiozone, 0.75);
  level.player scripts\engine\utility::delaycall(6.7, ::_meth_82C0, "shipcrib_moon_platform_ride_down", 3.0);
  thread _id_DB60();
  level scripts\engine\utility::delaythread(1, ::_id_CDF9);
  _id_8A41();
  scripts\engine\utility::flag_set("elevator_started");
  thread _id_8A40();
  var_0 waittill("doors_finished");
  thread _id_0EEB::_id_60EB("gravity", "Flight Deck", 1);
  thread _id_E50B();
  var_0._id_BFEA = 1;
  scripts\engine\utility::flag_wait("jump_complete");
  wait 2;
  thread _id_2092();
  _id_8A42();
  scripts\sp\maps\shipcrib_moon\shipcrib_moon_ambient::_id_ADA9();
  wait 10;
  var_0 waittill("doors_finished");
  level.player clearclienttriggeraudiozone(4.0);
  scripts\engine\utility::flag_clear("elevator_started");
  level notify("kill_klaxon_armory");
  _id_8A44();
  _id_E50F();
}

_id_2092() {
  thread _id_8AAD();
  wait 4.0;
  thread scripts\engine\utility::play_sound_in_space("scn_sc_moon_apc_lower_deck", (1157, 205, -1613));
}

_id_8AAC() {
  wait 0.9;
  level._id_BB47 = thread scripts\engine\utility::play_loopsound_in_space("sc_moon_hangar_alarm_dist_from_armory", (1263, 405, -741));
}

_id_8AAD() {
  level._id_BB47 thread scripts\sp\utility::_id_10460(4.5, 1);
}

_id_9836() {
  scripts\engine\utility::flag_set("armory_exited");
  scripts\engine\utility::flag_init("jump_complete");
  _id_0EF8::_id_FDFC("spawner_ethan", "ethan_elevator_jump");
  _id_0EF8::_id_FDFC("spawner_gibson", "airboss_elevator_jump");
  _id_10820("spawner_brooks", "brooks_welldeck");
  level._id_6754 scripts\sp\utility::_id_51E1("casual_gun");
  level._id_6754 _id_0EFB::_id_EB8D("moon_port");
  _id_F996();
  _id_0EEB::_id_60FD("gravity", "Mezzanine", 1);
}

_id_F996() {
  level _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  var_0 = _id_0EEB::_id_7976("gravity");
  var_1 = getstartorigin(var_0.origin, var_0.angles, %sh_mn_1_19_fli_deck_elev_air_idle);
  var_2 = var_1 * (0, 0, 1) - var_0.origin * (0, 0, 1);
  var_3 = var_0.origin - var_2;
  var_0._id_92F8 = scripts\engine\utility::spawn_tag_origin(var_3, var_0.angles);
  var_0._id_92F8 thread scripts\sp\anim::_id_1EEA(level._id_6754, "hangar_elevator_idle", "end_idle");
  var_0._id_92F8 thread scripts\sp\anim::_id_1EEA(level._id_828C, "hangar_elevator_idle", "end_idle");
  level._id_6754 thread scripts\sp\utility::_id_7799(level.player);
  level._id_828C thread scripts\sp\utility::_id_7799(level.player);
  level notify("idles_setup_complete");
}

_id_DB60() {
  wait 13.5;
  _id_CC77();
}

_id_8A41() {
  _id_0EEB::_id_7976("gravity").trigger waittill("trigger");
  _id_0EEB::_id_7976("gravity") notify("doors_close");
  level thread _id_0EEB::_id_60F0("gravity", 42);
  level thread _id_0EEB::_id_60FD("gravity", "Flight Broken");
  level.elevators["gravity"] thread _id_10C2F();
}

_id_8A42() {
  _id_0EEB::_id_7976("gravity")._id_BFEA = undefined;
  level thread _id_0EEB::_id_60F0("gravity", 70);
  level _id_0EEB::_id_60FD("gravity", "Vehicle Deck");
  _id_0EEB::_id_7976("gravity") thread _id_10C2F();
}

_id_8A40() {
  var_0 = _id_0EEB::_id_7976("gravity");
  wait 7.5;
  var_0 thread _id_CCAD();
  var_0 waittill("move_finished");
  var_0 _id_10FE9();
}

_id_CCAD() {
  self playSound("metal_slowdown");
  wait 0.5;
  self playSound("steam_release_long");
}

_id_8A44() {
  _id_0EEB::_id_7976("gravity") _id_10FE9();
  level._id_EA2C unlink();
  level._id_6754 unlink();
  level._id_828C unlink();
  thread _id_8291();
  level thread _id_0B21::_id_5A43("rig_room", "open");
  scripts\engine\utility::delaythread(0.66, ::_id_8A45);
}

_id_8291() {}

_id_8A45() {
  scripts\engine\utility::flag_wait("rig_room_elevator_leave");
  level thread scripts\sp\utility::_id_12651(["shipcrib_moon_mezz_tr"]);
  level thread _id_0B21::_id_5A43("rig_room", "locked");
  level thread _id_0EEB::_id_60F0("gravity", 65);
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck");
}

_id_CDF9() {
  var_0 = _id_0EEB::_id_7976("gravity");
  level._id_EA2C linkTo(var_0);
  _id_DB7F();
  level._id_EA2C scripts\engine\utility::delaycall(0.05, ::_meth_82B0, level._id_EA2C scripts\sp\utility::_id_7DC1("hangar_elevator_intro"), 0.1);
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "hangar_elevator_intro");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "hangar_elevator_idle", "end_idle");
  var_0._id_92F8 waittill("end_idle");
  var_0 notify("end_idle");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "hangar_elevator_scene");
}

_id_ECB0() {
  wait 3.4;
}

_id_DB7F() {
  scripts\sp\anim::_id_17F6("salter", "mayhem_start", ::_id_EA2D, "hangar_elevator_intro");
  scripts\sp\anim::_id_17FC("salter", "mayhem_end", "salter_mayhem_end", "hangar_elevator_intro");
}

_id_EA2D(var_0) {
  level._id_EA2C detach(level._id_EA2C.headmodel);
  level._id_EA2C _meth_82A2(%mayhem_sh_mn_1_19_fli_deck_elev_xo_intro, 1, 0, 1);
  level waittill("salter_mayhem_end");
  level._id_EA2C _meth_82A2(%mayhem_sh_mn_1_19_fli_deck_elev_xo_intro, 0, 0, 0);
  level._id_EA2C attach(level._id_EA2C.headmodel);
}

_id_CC77() {
  var_0 = _id_0EEB::_id_7976("gravity");
  var_0._id_92F8 notify("end_idle");
  scripts\sp\anim::_id_17F6(level._id_828C._id_1FBB, "takeoff", ::_id_7CA1, "hangar_elevator_scene");
  scripts\sp\anim::_id_17F6(level._id_828C._id_1FBB, "landed", ::_id_AD06, "hangar_elevator_scene");
  var_0._id_92F8 thread scripts\sp\anim::_id_1F35(level._id_6754, "hangar_elevator_scene");
  var_0._id_92F8 scripts\sp\anim::_id_1F35(level._id_828C, "hangar_elevator_scene");
  level._id_828C _id_0EE5::_id_202D(4);
}

_id_7CA1(var_0) {
  level._id_828C._id_6036 = gettime();
  level._id_828C._id_2A4F = level._id_828C.origin;
  var_1 = level._id_828C.origin - level._id_EA2C.origin;
}

_id_AD06(var_0) {
  var_1 = _id_0EEB::_id_7976("gravity");
  var_1._id_92F8 linkTo(var_1);
  level._id_6754 linkTo(var_1);
  level._id_828C linkTo(var_1);
  level._id_828C scripts\sp\utility::_id_77B9(0.7);
  level._id_6754 scripts\sp\utility::_id_77B9(0.7);
  scripts\engine\utility::flag_set("jump_complete");
  var_2 = gettime() - level._id_828C._id_6036;
  var_3 = level._id_828C._id_2A4F - level._id_828C.origin;
}

_id_E50B() {
  var_0 = scripts\engine\utility::getStruct("rr_org_anim", "targetname");
  var_1 = _id_94E7("locked", var_0, "rig_room_enter");
  scripts\sp\utility::_id_22CA("rig_room_walkers", scripts\sp\utility::_id_51E1, "casual");
  var_2 = scripts\sp\utility::_id_22CD("rig_room_walkers", 1);
  var_3 = getEnt("rig_room_walker_door", "targetname");
  var_2 scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_86E4);
  var_3 rotateYaw(-135, 0.05);
  var_3 dontcastshadows();
  var_4 = getspawnerarray("rig_room_crew");
  level._id_E77A = [];

  foreach(var_6 in var_4) {
    var_7 = scripts\sp\utility::_id_5CC9(var_6);
    var_7 _id_0EFB::_id_FD6F("rig_room");
    var_7._id_C6EA = scripts\engine\utility::getStruct(var_7.script_noteworthy, "targetname");

    if(isDefined(var_7._id_C6EA)) {
      var_7._id_C6EA thread scripts\sp\anim::_id_1EEA(var_7, var_7._id_C6EA.animation, "stop_crew", undefined, undefined, "generic");
      level._id_E77A[level._id_E77A.size] = var_7;
    }
  }

  var_9 = getEntArray("rig_room_seat", "targetname");

  foreach(var_11 in var_9) {
    var_11 scripts\sp\utility::_id_23B7(var_11.script_noteworthy);

    if(!issubstr(var_11.script_noteworthy, "player")) {
      var_0 scripts\sp\anim::_id_1EC3(var_11, "rig_room_intro");
    } else {
      var_11 scripts\sp\anim::_id_1EC3(var_11, "rig_enter");
    }

    if(isDefined(var_11.script_parameters)) {
      var_11._id_A485 = spawn("script_model", (0, 0, 0));
      var_11._id_A485 setModel(var_11.script_parameters);
      var_11._id_A485 linkTo(var_11, "tag_jetpack", (0, 0, 0), (0, 0, 0));
    }
  }

  thread _id_1F81(getEnt("rig_seat_player", "script_noteworthy"));
  thread _id_1F86(var_0);

  if(!isDefined(level._id_30F6) || !isai(level._id_30F6) || !isalive(level._id_30F6)) {
    level._id_30F6 = _id_0EF8::_id_FDFC("spawner_brooks", "brooks_welldeck");
  }

  var_0 scripts\sp\anim::_id_1EC3(level._id_30F6, "rig_room_enter");
  level._id_30F6 attach(level._id_30F6._id_A489);
  level._id_30F6 _id_0EF8::_id_FE00();
  var_13 = [];
  var_14 = getspawnerarray("rig_room_ally");

  foreach(var_17, var_6 in var_14) {
    var_16 = var_6 scripts\sp\utility::_id_10619(1);
    var_16._id_1FBB = "ally_" + scripts\sp\utility::string(var_17 + 1);
    var_16 scripts\sp\utility::_id_51E1("casual_gun");
    var_13[var_13.size] = var_16;
  }

  var_0 scripts\sp\anim::_id_1EC1(var_13, "rig_room_enter");
  scripts\engine\utility::flag_wait("rig_room_enter_scene");
  setsaveddvar("sm_spotdistcull", 280);
  var_18 = scripts\engine\utility::getStruct("wd_node_walkaway", "targetname");

  foreach(var_16 in var_13) {
    var_0 thread scripts\sp\anim::_id_1F35(var_16, "rig_room_enter");
    var_16 scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_7226, var_18);
    var_16 thread scripts\sp\utility::_id_5184("reached_path_end");
  }

  var_21 = scripts\sp\vehicle::_id_1080F("rig_room_speep");
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("node_rig_room_walker", "targetname"));
  scripts\engine\utility::array_thread(var_2, scripts\sp\utility::_id_5184, "reached_path_end");
  var_3 scripts\engine\utility::delaycall(6.5, ::rotateyaw, 135, 2, 0, 1);
  var_3 scripts\engine\utility::delaycall(6.5, ::playsound, "shipcrib_moon_welldeck_door_close_left");
  wait 8;
  playworldsound("shipcrib_moon_welldeck_door_close_center", (1150, 758, -2331));
  var_0 scripts\sp\anim::_id_1F35(var_1, "rig_room_enter");
}

_id_E50F() {
  setsaveddvar("sm_spotdistcull", 280);
  var_0 = scripts\engine\utility::getStruct("rr_org_anim", "targetname");
  var_1 = getEnt("welldeck_airlock_door", "targetname");
  var_2 = getEnt("rig_seat_salter", "script_noteworthy");
  var_3 = getEnt("rig_seat_ethan", "script_noteworthy");
  var_4 = getEnt("rig_seat_player", "script_noteworthy");
  level._id_F08B = [var_2, var_3, var_4];
  var_4 scripts\sp\utility::_id_23B7(var_4.script_noteworthy);
  var_0 thread _id_1F3C(level._id_30F6, "rig_room_enter", "rig_room_enter_idle", "end_intro", undefined, undefined, "end_intro");
  level thread _id_E50E(var_0, var_2);
  level thread _id_E50D(var_0, var_3);
  thread _id_E50A();
  var_5 = scripts\sp\utility::_id_10639("player_rig");
  var_5 hide();
  var_4 scripts\sp\anim::_id_1EC3(var_5, "rig_enter");
  wait 4.75;
  var_4._id_A485 thread scripts\sp\utility::_id_918B("ar_callouts_boost_rig", 0, (0, 0, 14));
  var_4 _id_0E46::_id_48C4(undefined, (0, 0, 50), &"SHIPCRIB_GET_BOOST_RIG", 45, 750);
  var_4 waittill("trigger");
  var_4._id_A485 thread scripts\sp\utility::_id_918C();
  scripts\engine\utility::flag_set("rig_room_elevator_leave");
  level.player scripts\sp\utility::_id_F526("normal");
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player freezecontrols(1);
  level.player _meth_84AF(1);
  level.player disableweapons();
  level.player _meth_823C(var_5, "tag_player", 0.7, 0.25, 0.25);
  wait 0.7;
  level.player playerlinktodelta(var_5, "tag_player", 1, 0, 0, 0, 0, 1);
  var_5 show();
  _id_94E7("locked", var_0);
  scripts\engine\utility::delaythread(6, ::_id_E50C, var_0);
  level notify("player_rig_enter");
  level thread _id_110C7(var_5);
  var_4 thread _id_1F3C(var_4, "rig_enter", "rig_idle");
  var_4 _id_1F3C(var_5, "rig_enter", "rig_idle");
  level thread scripts\sp\utility::_id_9145("fluff_messages_boost_engaged");
  level.player scripts\engine\utility::delaycall(0.1, ::playsound, "SH_MN_1_21_ETHAN_RIG_PLR_rig_on_lsrs");
  wait 2;
  level.player _meth_8573("default_character_shadow");
  var_4 thread scripts\sp\anim::_id_1F35(var_4, "rig_exit");
  var_4 scripts\sp\anim::_id_1F35(var_5, "rig_exit");
  level notify("player_rig_exit");
  level.player unlink();
  var_5 hide();
  var_5 delete();

  if(isDefined(var_4._id_A485)) {
    var_4._id_A485 delete();
  }

  level.player scripts\sp\utility::_id_F526("safe");
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player freezecontrols(0);
  level.player _meth_84AF(0);
  level.player disableweaponswitch();
  level.player enableweapons();
  scripts\engine\utility::flag_wait("rig_room_finished");
  wait 1;
  level thread _id_131C9();
}

_id_E50E(var_0, var_1) {
  level endon("rr_end_intro");
  var_2 = _id_0EEB::_id_7976("gravity");
  var_2._id_92F8 scripts\sp\anim::_id_1F35(level._id_EA2C, "rig_room_walkin", undefined, 0.2);
  var_0 thread _id_1F3C(level._id_EA2C, "rig_room_intro", "rig_room_intro_idle", "end_intro", undefined, undefined, "end_intro");
  var_0 thread _id_1F83("anim_seat_salter", var_1, "rig_room_intro", level._id_EA2C, "pack_female", "attach_rig_salter");
}

_id_E50D(var_0, var_1) {
  level endon("rr_end_intro");
  var_2 = _id_0EEB::_id_7976("gravity");
  var_2._id_92F8 scripts\sp\anim::_id_1F35(level._id_6754, "rig_room_walkin");
  var_0 thread _id_1F3C(level._id_6754, "rig_room_intro", "rig_room_intro_idle", "end_intro", undefined, undefined, "end_intro");
  var_0 thread _id_1F83("anim_seat_ethan", var_1, "rig_room_intro", level._id_6754, "pack_eth3n_zerog", "attach_rig_ethan");
}

_id_E50C(var_0) {
  level._id_6754 thread _id_82AA(undefined, "pack_eth3n_zerog");
  level._id_EA2C thread _id_82AA(undefined, "pack_female");

  foreach(var_2 in level._id_F08B) {
    if(isDefined(var_2._id_A485) && !issubstr(var_2._id_1FBB, "player")) {
      var_2._id_A485 delete();
    }
  }

  level notify("rr_end_intro");
  var_0 notify("end_intro");
  level._id_6754 scripts\sp\utility::anim_stopanimScripted();
  level._id_EA2C scripts\sp\utility::anim_stopanimScripted();
  wait 0.05;
  var_0 thread _id_1F3C(level._id_EA2C, "rig_room_scene", "rig_room_scene_idle", "end_rig_room", undefined, undefined, "end_rig_room");
  var_0 thread _id_1F3C(level._id_6754, "rig_room_scene", "rig_room_scene_idle", "end_rig_room", undefined, undefined, "end_rig_room");
  var_0 thread _id_1F3C(level._id_30F6, "rig_room_scene", "rig_room_scene_idle", "end_rig_room", undefined, undefined, "end_rig_room");
}

_id_E50A() {
  wait 5.25;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_moon_slt_doweneedgunstoo");
  scripts\sp\utility::_id_1034D("sc_moon_plr_becoolsalt");
  level._id_EA2C scripts\sp\utility::_id_10346("sc_moon_slt_likeicecaptain");
}

_id_1F83(var_0, var_1, var_2, var_3, var_4, var_5) {
  level endon("rr_end_intro");

  if(!isDefined(var_3._id_A489) && isDefined(var_4)) {
    var_3._id_A489 = var_4;
  }

  level waittill(var_0);
  thread scripts\sp\anim::_id_1F35(var_1, var_2);

  if(isDefined(var_3._id_A489) && isDefined(var_5)) {
    level waittill(var_5);
    var_3 _id_82AA();

    if(isDefined(var_1._id_A485)) {
      var_1._id_A485 delete();
    }
  }
}

_id_1F81(var_0) {
  var_1 = scripts\sp\utility::_id_10639("player_helmet");
  var_0 scripts\sp\anim::_id_1EC3(var_1, "rig_enter");
  level waittill("player_rig_enter");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "rig_enter");
  level waittill("player_helmet_on");
  var_1 delete();
  _id_0B0A::_id_583F(0, 0, 0, 8, 49, 6, 0.25);
  wait 0.75;
  _id_0B0A::_id_583F(0, 0, 0, 0, 0, 0, 1.5);
}

_id_110C7(var_0) {
  var_1 = spawn("script_model", var_0 gettagorigin("tag_weapon_right"));
  var_1 setModel(getweaponmodel(level.player getcurrentprimaryweapon()));
  var_1 linkTo(var_0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  level waittill("player_rig_exit");
  var_1 delete();
}

_id_1F86(var_0, var_1) {
  level._id_EA2C thread _id_1F85();
  var_2 = undefined;

  if(!isDefined(var_1) || !var_1) {
    var_2 = scripts\sp\utility::_id_10639("salter_helmet");
    var_0 thread scripts\sp\anim::_id_1EC3(var_2, "rig_room_intro");
    var_3 = level scripts\engine\utility::waittill_either("anim_helmet_salter", "rr_end_intro");

    if(!isDefined(var_3)) {
      var_0 scripts\sp\anim::_id_1F35(var_2, "rig_room_intro");
    }
  }

  level notify("hide_hair_salter");
  level._id_EA2C detach("helmet_hero_xo");
  level._id_EA2C attach("helmet_hero_xo");

  if(isDefined(var_2)) {
    var_2 delete();
  }
}

_id_1F85() {
  level waittill("hide_hair_salter");
  level._id_EA2C detach(level._id_EA2C.headmodel);
  level._id_EA2C attach("head_hero_noHair_xo_dirty");
}

_id_94E7(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = "rig_room_exit";
  }

  var_3 = getEnt("welldeck_airlock_door", "targetname");
  var_3._id_ECCE = _id_0EFB::_id_7994("shipcrib_door_screen", "script_noteworthy", "welldeck");
  var_3._id_ECCA = [];

  foreach(var_5 in var_3._id_ECCE) {
    if(var_5.classname != "script_model") {
      var_3._id_ECCA = scripts\engine\utility::array_add(var_3._id_ECCA, var_5);
    }
  }

  var_3._id_ECCE = scripts\engine\utility::array_remove_array(var_3._id_ECCE, var_3._id_ECCA);

  if(isDefined(var_0)) {
    var_3 _id_0B20::_id_5A42(var_0);

    if(var_0 == "open") {
      var_3 setModel("door_airlock_01_door_access");
    } else if(var_0 == "locked") {
      var_3 setModel("door_airlock_01_door_noaccess");
    }
  }

  if(isDefined(var_1)) {
    var_3 scripts\sp\utility::_id_23B7("welldeck_door");
    var_1 _id_1ED9(var_3, var_2, 0);
  }

  return var_3;
}

_id_131C9() {
  var_0 = _id_94E7("open");
  getEnt(var_0.target, "targetname") linkTo(var_0, "door_JNT");
  level thread _id_131C5(var_0);
  var_0 thread _id_0E46::_id_48C4("tag_ui_front", undefined, undefined, 45, 750, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var_0 waittill("trigger");
  thread _id_2601();

  if(isDefined(level._id_828C)) {
    level._id_828C delete();
  }

  if(isDefined(level._id_F08B)) {
    foreach(var_2 in level._id_F08B) {
      var_2 scripts\sp\utility::anim_stopanimScripted();
      var_2 delete();
    }
  }

  level _id_1081F(1);
  level._id_C47F _id_0EF8::_id_FE00();
  level._id_A538 _id_0EF8::_id_FE00();
  var_4 = scripts\engine\utility::getStructArray("welldeck_ambient_actor", "targetname");
  level._id_13BF0 = [];
  level.wd_crew_cleanup = [];

  foreach(var_6 in var_4) {
    var_7 = undefined;

    if(isDefined(var_6.script_type) && issubstr(var_6.script_type, "walker")) {
      var_7 = scripts\sp\utility::_id_107EA(var_6.target, 1);
      var_7 scripts\sp\utility::_id_51E1("casual");
      var_7._id_846A = scripts\engine\utility::getStruct(var_6.script_parameters, "targetname");
      level._id_13BF0 = scripts\engine\utility::array_add(level._id_13BF0, var_7);
    } else {
      var_7 = scripts\sp\utility::_id_5CC9(getspawner(var_6.target, "targetname"));
      var_7 dontcastshadows();
      var_7 _id_0EFB::_id_FD6F("well_deck");
    }

    if(!isDefined(var_7)) {
      continue;
    }
    if(isDefined(var_7.headmodel) && isDefined(var_6._id_EF20)) {
      var_7 detach(var_7.headmodel);
      var_7 attach(var_6._id_EF20);
    }

    if(isDefined(var_6.script_type) && issubstr(var_6.script_type, "tablet")) {
      var_7._id_113CA = spawn("script_model", (0, 0, 0));
      var_7._id_113CA setModel("p7_desk_metal_military_03_tablet");
      var_7._id_113CA linkTo(var_7, "tag_inhand", (0, 0, 0), (0, 0, 0));
    }

    if(isDefined(var_6._id_EF1F) && var_6._id_EF1F) {
      level.wd_crew_cleanup = scripts\engine\utility::array_add(level.wd_crew_cleanup, var_7);
    }

    var_7._id_C6EA = var_6;
    var_6 thread scripts\sp\anim::_id_1EEA(var_7, var_6.animation, undefined, undefined, undefined, "generic");

    if(isDefined(var_6._id_ED75)) {
      var_7 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, level._id_EC85["generic"][var_6.animation][0], var_6._id_ED75);
    }
  }

  var_9 = scripts\sp\utility::_id_10639("player_rig");
  var_9 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_9, "rig_room_exit");
  level.player scripts\sp\utility::_id_F526("normal");
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player _meth_84AF(1);
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player _meth_823C(var_9, "tag_player", 0.7, 0.25, 0.25);
  wait 0.7;
  level.player playerlinktodelta(var_9, "tag_player", 1, 15, 15, 15, 15, 1);
  var_9 show();
  setsaveddvar("sm_spotdistcull", 300);
  _id_131C6();
  scripts\sp\utility::_id_22CA("speep_park_link", scripts\sp\utility::_id_51E1, "casual");
  var_10 = scripts\sp\vehicle::_id_1080D("welldeck_speep_park");
  level._id_109D1 = scripts\sp\vehicle::_id_1080C("welldeck_speep_bravo1");
  level._id_109D2 = scripts\sp\vehicle::_id_1080C("welldeck_speep_bravo2");
  level._id_109C8 = scripts\sp\vehicle::_id_1080C("welldeck_speep_alpha1");
  level._id_109CB = scripts\sp\vehicle::_id_1080C("welldeck_speep_alpha2");
  var_10 scripts\engine\utility::delaythread(8.5, scripts\sp\vehicle::_id_1320B, "running");
  level._id_109D2 dontcastshadows();
  level._id_109C8 hidepart("tag_light_rollbar_r");
  level._id_109C8 hidepart("tag_light_rollbar_l");
  level._id_109C8 hidepart("tag_roof");
  level._id_109C8 attach("veh_mil_lnd_un_4x4_atv_vm", "tag_origin");
  level._id_109D1 thread vehicle_deck_rider_setup();
  level._id_109D2 thread vehicle_deck_rider_setup();
  level._id_109C8 thread vehicle_deck_rider_setup();
  level._id_109CB thread vehicle_deck_rider_setup();
  var_11 = getEntArray("apc_sled", "targetname");
  var_12 = getEntArray("restribution_welldeck_door", "targetname");
  scripts\engine\utility::array_call(var_11, ::dontcastshadows);
  scripts\engine\utility::array_call(var_12, ::dontcastshadows);
  scripts\sp\utility::_id_22CA("welldeck_walker", scripts\sp\utility::_id_5184, "goal");
  scripts\sp\utility::_id_22CA("welldeck_walker", scripts\sp\utility::_id_51E1, "casual_gun");
  scripts\engine\utility::delaythread(2.25, scripts\sp\utility::_id_22CD, "welldeck_walker");
  level thread _id_13CF9(2.5);
  level thread _id_BB32();
  var_0 thread scripts\sp\anim::_id_1F35(var_0, "rig_room_exit");
  var_0 scripts\sp\anim::_id_1F35(var_9, "rig_room_exit");
  _id_94E7("locked", scripts\engine\utility::getStruct("rr_org_anim", "targetname"));
  var_9 hide();
  level.player scripts\sp\utility::_id_F526("safe");
  level.player unlink();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player _meth_84AF(0);
  level.player disableweaponswitch();
  level.player enableweapons();
  level.player freezecontrols(0);
  var_9 delete();
  level waittill("welldeck_speep_ready");
  level thread _id_A451();
}

_id_2601() {
  wait 2.5;
  level.player _meth_82C0("shipcrib_lower_bay_exit", 1.0);
  wait 5.0;
  level.player clearclienttriggeraudiozone(1.0);
}

_id_131C5(var_0) {
  var_0 endon("trigger");
  wait 8;
  level._id_EA2C thread scripts\sp\utility::_id_10346("sc_moon_slt_groundpoundersa");
  wait 10;
  level._id_6754 thread scripts\sp\utility::_id_10346("sc_moon_eth_onyousir");
}

_id_131C6() {
  var_0 = level.vehicle._id_116CE._id_1A03["script_vehicle_atv_friendly"];
  var_0[4] = spawnStruct();
  var_0[4]._id_10220 = "tag_cover";
  var_0[4]._id_92CC = scripts\sp\utility::_id_7DC3("atv_turret_loop");
  var_0[4]._id_8028 = scripts\sp\utility::_id_7DC3("atv_turret_loop");
  level.vehicle._id_116CE._id_1A03["script_vehicle_atv_friendly"] = var_0;
}

vehicle_deck_rider_setup() {
  foreach(var_1 in self._id_247C) {
    var_1 dontcastshadows();

    if(isDefined(var_1.headmodel) && isDefined(var_1.script_noteworthy)) {
      var_1 detach(var_1.headmodel);
      var_1 attach(var_1.script_noteworthy);
    }
  }
}

_id_13CF9(var_0) {
  var_1 = scripts\engine\utility::getStruct("rr_org_anim", "targetname");
  var_1 notify("end_rig_room");
  scripts\engine\utility::array_call(level._id_13BF2, ::hide);
  wait 0.05;
  var_2 = scripts\engine\utility::getStruct("wd_org_anim", "targetname");
  var_2 scripts\sp\anim::_id_1EC1(level._id_13BF2, "welldeck_intro");
  thread _id_FBAE();
  wait(var_0 - 0.05);
  var_1 notify("end_rig_room");
  var_2 notify("stop_loop");
  scripts\engine\utility::array_call(level._id_13BF2, ::show);

  foreach(var_4 in level._id_13BF2) {
    var_2 thread welldeck_scene_then_loop(var_4);
  }

  level._id_109C8 scripts\sp\utility::_id_23B7("jeep_alpha");
  level._id_109D1 scripts\sp\utility::_id_23B7("jeep_bravo");
  var_2 thread _id_1F3B(level._id_109C8, "welldeck_intro");
  var_2 thread _id_1F3B(level._id_109D1, "welldeck_intro");
}

welldeck_scene_then_loop(var_0) {
  self endon("stop_loop");
  scripts\sp\anim::_id_1F35(var_0, "welldeck_intro");

  if(isDefined(var_0._id_1FBB) && !issubstr(var_0._id_1FBB, "omar")) {
    var_0 dontcastshadows();
  }

  thread scripts\sp\anim::_id_1EEA(var_0, "welldeck_idle");
}

_id_FBAE() {
  wait 1.6;
  level._id_109D1 playSound("scn_sc_moon_jeep_dock");
}

_id_A451() {
  var_0 = scripts\engine\utility::getStruct("alpha1_interact", "targetname");
  var_0 thread _id_0E46::_id_48C4(undefined, undefined, undefined, 45, 750);
  var_0 thread _id_13CF7();
  var_0 waittill("trigger");
  level.player _meth_82C0("shipcrib_moon_to_moon_port_transition", 2.0);
  thread _id_1097F();
  var_1 = scripts\sp\utility::_id_10639("player_rig");
  var_1 hide();
  level._id_109C8 scripts\sp\anim::_id_1EC3(var_1, "welldeck_jeep");
  level.player scripts\sp\utility::_id_F526("normal");
  level.player setstance("stand");
  level.player allowprone(0);
  level.player allowcrouch(0);
  level.player disableweapons();
  level.player freezecontrols(1);
  level.player _meth_823C(var_1, "tag_player", 0.75, 0.25, 0.25);
  wait 0.75;
  level.player playerlinktodelta(var_1, "tag_player", 1, 0, 0, 0, 0, 1);
  var_1 show();
  level thread _id_13BF1();

  if(isDefined(level._id_E77A)) {
    level._id_E77A = scripts\engine\utility::array_removeundefined(level._id_E77A);
    scripts\engine\utility::array_call(level._id_E77A, ::delete);
  }

  if(isDefined(level.wd_crew_cleanup)) {
    level.wd_crew_cleanup = scripts\engine\utility::array_removeundefined(level.wd_crew_cleanup);
    scripts\engine\utility::array_call(level.wd_crew_cleanup, ::delete);
  }

  thread _id_FDC8();
  level._id_109C8 thread scripts\sp\anim::_id_1F35(var_1, "welldeck_jeep");
  level waittill("start_jeep_speech");
  var_2 = scripts\engine\utility::getStruct("wd_org_anim", "targetname");
  var_3 = [level._id_EA2C, level._id_6754, level._id_C47F, level._id_8452, level._id_D956];
  var_2 notify("stop_loop");

  foreach(var_5 in [level._id_C24B, level._id_30F6, level._id_A538]) {
    var_2 thread scripts\sp\anim::_id_1EEA(var_5, "welldeck_idle");
  }

  foreach(var_5 in var_3) {
    var_2 thread _id_1F3C(var_5, "welldeck_scene", "welldeck_idle");
  }

  level._id_109C8 waittill("welldeck_jeep");
  scripts\sp\utility::_id_BF95();
}

_id_1097F() {
  wait 3.0;
  setmusicstate("mx_193_moonport_intro");
}

_id_BB32() {
  level._id_E35D._id_6A38 thread _id_0B51::_id_5155();
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_C47F);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_6754);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_30F6);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_A538);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_EA2C);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_C24B);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_8452);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_D956);
  _id_0EFB::_id_FDBB("all");
  _id_0EFB::_id_FDBB("rig_room");
  _id_0EFB::_id_FDCD();
  level thread scripts\sp\utility::_id_12651(["shipcrib_moon_hangar_tr", "shipcrib_moon_prime_tr", "shipcrib_moon_prime_in_tr", "shipcrib_moon_ambient_tr"]);
  wait 1.0;
  scripts\sp\utility::_id_BF97();
}

_id_2AE4() {
  thread _id_0B0A::_id_583F(0, 20.27, 3, 0, 400, 1.75, 3);
  var_0 = [3, 2, 5, 4, 3, 5];
  var_1 = 0.2;
  var_2 = 0.6;
  var_3 = (var_2 - var_1) / var_0.size;
  var_4 = var_1;
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideStrength", 0.025, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", -0.05, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideDistortion", 0.015, 1);

  foreach(var_6 in var_0) {
    wait(var_6);
    earthquake(var_4, randomfloatrange(1, 3.5), level.player.origin, 400);
    var_4 = var_4 + var_3;
  }
}

_id_13CF7() {
  self endon("trigger");
  wait 8;
  level._id_C47F thread scripts\sp\utility::_id_10346("sc_moon_omr_50calisallyouca");
}

_id_13BF1() {
  var_0 = scripts\engine\utility::array_removeundefined(level._id_13BF0);
  var_0 = scripts\sp\utility::array_removedeadvehicles(var_0);

  foreach(var_2 in var_0) {
    var_2._id_C6EA notify("stop_loop");
    var_2 scripts\sp\utility::anim_stopanimScripted();
    var_2 thread scripts\sp\utility::_id_7226(var_2._id_846A);
    var_2 thread scripts\sp\utility::_id_5184("reached_path_end");
  }
}

_id_13CF8() {
  var_0 = getEnt("welldeck_klaxon_right", "targetname");
  var_1 = getEnt("welldeck_klaxon_left", "targetname");
  var_2 = getEntArray("welldeck_klaxon_light_right", "targetname");
  var_3 = getEntArray("welldeck_klaxon_light_left", "targetname");
  var_0 setModel("clk_light_plasticcase_red_on");
  var_1 setModel("clk_light_plasticcase_red_on");
  scripts\engine\utility::noself_delaycall(0, ::playfxontag, scripts\engine\utility::getfx("vfx_klaxon_flare"), var_0, "light_on_LOD0");
  scripts\engine\utility::noself_delaycall(0, ::playfxontag, scripts\engine\utility::getfx("vfx_klaxon_flare"), var_1, "light_on_LOD0");
  scripts\engine\utility::array_thread(var_2, scripts\sp\lights::_id_AB83, 10, 0.5);
  scripts\engine\utility::array_call(var_2, ::linkto, var_0);
  var_0 rotatevelocity((0, -190, 0), 99999);
  scripts\engine\utility::array_thread(var_3, scripts\sp\lights::_id_AB83, 10, 0.5);
  scripts\engine\utility::array_call(var_3, ::linkto, var_1);
  var_1 rotatevelocity((0, 190, 0), 99999);
}

_id_FDC8() {
  level waittill("welldeck_hud_up");
  wait 0.23;

  if(getdvarint("skip_nextmission", 0)) {
    return;
  }
  setomnvar("ui_level_transition", 1);
  wait 1.0;
  setomnvar("ui_level_transition", 2);
  scripts\sp\utility::_id_BF95();
}

_id_1081F(var_0) {
  if(!isDefined(level._id_6754) || !isai(level._id_6754) || !isalive(level._id_6754)) {
    level._id_6754 = _id_0EF8::_id_FDFC("spawner_ethan", "ethan_welldeck");
  }

  if(!isDefined(level._id_EA2C) || !isai(level._id_EA2C) || !isalive(level._id_EA2C)) {
    level._id_EA2C = _id_0EF8::_id_FDFC("spawner_salter_dirty", "salter_welldeck");
  }

  if(!isDefined(level._id_C47F) || !isai(level._id_C47F) || !isalive(level._id_C47F)) {
    level._id_C47F = _id_0EF8::_id_FDFC("spawner_omar", "omar_welldeck");
  }

  if(!isDefined(level._id_C24B) || !isai(level._id_C24B) || !isalive(level._id_C24B)) {
    level._id_C24B = _id_0EF8::_id_FDFC("spawner_nunez", "nunez_welldeck");
  }

  if(!isDefined(level._id_30F6) || !isai(level._id_30F6) || !isalive(level._id_30F6)) {
    level._id_30F6 = _id_0EF8::_id_FDFC("spawner_brooks", "brooks_welldeck");
  }

  if(!isDefined(level._id_A538) || !isai(level._id_A538) || !isalive(level._id_A538)) {
    level._id_A538 = _id_0EF8::_id_FDFC("spawner_kash", "kash_welldeck");
  }

  if(!isDefined(level._id_8452) || !isai(level._id_8452) || !isalive(level._id_8452)) {
    level._id_8452 = _id_0EF8::_id_FDFC("spawner_goodwin", "goodwin_welldeck");
  }

  if(!isDefined(level._id_D956) || !isai(level._id_D956) || !isalive(level._id_D956)) {
    level._id_D956 = _id_0EF8::_id_FDFC("spawner_private", "private_welldeck");
  }

  level._id_13BF2 = [level._id_6754, level._id_EA2C, level._id_C47F, level._id_C24B, level._id_30F6, level._id_A538, level._id_8452, level._id_D956];
  level._id_8452._id_1FBB = "goodwin";
  level._id_D956._id_1FBB = "private";

  foreach(var_2 in level._id_13BF2) {
    var_2 _id_0EFB::_id_EB8D("moon_port");
    var_2 scripts\sp\utility::_id_51E1("casual_gun");

    if(isDefined(var_0)) {
      var_2 thread _id_82AA(undefined, "pack_un_jackal_pilots");
    }
  }
}

_id_82AA(var_0, var_1) {
  if(isDefined(var_0)) {
    self._id_A489 = var_0;
  }

  if(!isDefined(self._id_A489) && isDefined(var_1)) {
    self._id_A489 = var_1;
  }

  var_2 = self getattachsize();
  var_3 = 1;

  for(var_4 = 0; var_4 < var_2; var_4++) {
    if(issubstr(self getattachmodelname(var_4), "pack")) {
      var_3 = 0;
      break;
    }
  }

  if(var_3) {
    self attach(self._id_A489);
  }
}

_id_10820(var_0, var_1) {
  var_2 = _id_0EF8::_id_FDFC(var_0, var_1);
  var_2 scripts\sp\utility::_id_86E2();
  var_2 scripts\sp\utility::_id_51E1("casual_gun");
  return var_2;
}

_id_CFA7(var_0) {
  if(var_0) {
    level thread _id_D328();
  } else {
    level notify("stop_camera_shake");
    level.player._id_E7D1 scripts\sp\utility::_id_E7C7(1.0);
  }
}

_id_D328(var_0, var_1) {
  level notify("player_camera_shaked");
  level endon("player_camera_shaked");
  level endon("stop_camera_shake");
  var_2 = randomfloatrange(0.1, 0.15);
  var_3 = randomfloatrange(1.5, 2);
  var_4 = randomfloatrange(0.1, 0.15);
  var_5 = 2;

  for(;;) {
    wait(randomfloatrange(12, 20));
    level.player playSound("scn_sc_moon_quake_lr");
    level.player._id_E7D1 scripts\sp\utility::_id_E7C9(var_4, 0.35);
    wait 0.1;
    earthquake(var_2, var_3, level.player.origin, 100000);
    level.player._id_E7D1 scripts\sp\utility::_id_E7C7(var_5);
  }
}

_id_1ED9(var_0, var_1, var_2) {
  var_3 = var_0 scripts\sp\utility::_id_7DC1(var_1);
  var_0 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_3, var_2);
  var_0 scripts\engine\utility::delaycall(0.05, ::_meth_82B1, var_3, 0);
  thread scripts\sp\anim::_id_1F35(var_0, var_1);
}

_id_1F16(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    self endon(var_6);
  }

  scripts\sp\anim::_id_1F17(var_0, var_1, var_4);
  _id_1F3C(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

_id_1F3C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(isDefined(var_6)) {
    self endon(var_6);
  }

  scripts\sp\anim::_id_1F35(var_0, var_1, var_4, undefined, var_5);
  thread scripts\sp\anim::_id_1EEA(var_0, var_2, var_3, var_4, undefined, var_5);
}

_id_1F3B(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 scripts\sp\utility::_id_7DC1(var_1);
  var_6 = getanimlength(var_5) - 0.05;
  scripts\sp\anim::_id_1F35(var_0, var_1, var_2, undefined, var_4);
  var_0 scripts\engine\utility::delaycall(var_6, ::_meth_82B1, var_5, 0);
}

_id_1EB5(var_0, var_1) {
  var_2 = "stop_anim_move_" + self._id_1FBB;

  if(!scripts\engine\utility::flag_exist(var_2)) {
    scripts\engine\utility::flag_init(var_2);
  }

  scripts\sp\anim::_id_17FA(self._id_1FBB, "anim_movement = walk", var_2, var_1);
  scripts\engine\utility::flag_wait(var_2);
  self orientmode("face angle", self.angles[1]);
  scripts\engine\utility::flag_clear(var_2);
  self.goalradius = 32;
  var_3 = self.origin + anglesToForward(self.angles) * 200;
  scripts\sp\utility::_id_F3DC(var_3);
  wait 1.0;
  self.goalradius = 32;
  scripts\sp\utility::_id_F3DC(var_0);
  scripts\engine\utility::waitframe();
  self notify("anim_end_goal_done");
}

_id_137C8(var_0, var_1, var_2) {
  for(;;) {
    if(distance2d(level.player.origin, var_0.origin) <= var_1) {
      if(isDefined(var_2) && var_2) {
        if(scripts\sp\utility::_id_D1DF(var_0 getEye(), 0.5, 1)) {
          break;
        }
      } else
        break;
    }

    if(isai(var_0)) {
      if(scripts\sp\utility::_id_D1DF(var_0 getEye(), 0.7, 1)) {
        break;
      }
    } else {
      var_3 = length(level.player getEye() - level.player.origin);
      var_4 = var_0.origin + var_3;

      if(scripts\sp\utility::_id_D1DF(var_4, 0.7, 1)) {
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }
}