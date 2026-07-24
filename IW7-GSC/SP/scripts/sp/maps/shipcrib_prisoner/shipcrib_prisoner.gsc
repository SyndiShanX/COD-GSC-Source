/*******************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner.gsc
*******************************************************************/

main() {
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_prime_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_prime_in_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_jackal_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_dropship_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_bridge_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_bridgee_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_bridgem_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_halore_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_mezz_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_exterior_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_jackale_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_hangar_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_vr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_ambient_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_ambientmr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_prisoner_ambientml_tr");
  _id_0EFB::_id_FDB2("shipcrib_prisoner");
  _id_0EFB::_id_FD77("shipcrib_prisoner");
  _id_0EFB::_id_FD73("shipcrib_prisoner");
  _id_0EFB::_id_FDAE("shipcrib_prisoner");
  _id_0EFB::_id_FDDC("shipcrib_prisoner");
  var_0 = ["shipcrib_prisoner_hangar_tr", "shipcrib_prisoner_dropship_tr", "shipcrib_prisoner_prime_tr", "shipcrib_prisoner_prime_in_tr", "shipcrib_prisoner_mezz_tr", "shipcrib_prisoner_ambient_tr", "shipcrib_prisoner_ambientmr_tr", "shipcrib_prisoner_halore_tr", "shipcrib_prisoner_jackale_tr"];
  var_1 = ["shipcrib_prisoner_halore_tr", "shipcrib_prisoner_exterior_tr", "shipcrib_prisoner_bridge_tr", "shipcrib_prisoner_prime_in_tr"];
  var_2 = ["shipcrib_prisoner_halore_tr", "shipcrib_prisoner_exterior_tr", "shipcrib_prisoner_bridge_tr", "shipcrib_prisoner_prime_in_tr", "shipcrib_prisoner_prime_tr", "shipcrib_prisoner_bridgem_tr", "shipcrib_prisoner_bridgee_tr"];
  scripts\sp\utility::_id_F343("prisoner start");
  scripts\sp\utility::_id_F344("prisoner start alt");
  scripts\sp\utility::_id_1749("bridge", ::_id_30B6, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("armory", ::_id_224A, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("flight deck", ::_id_6F23, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("prisoner start dev", ::_id_D94A, "", undefined, var_0);
  scripts\sp\utility::_id_1749("prisoner start", ::_id_D948, "", undefined, var_0);
  scripts\sp\utility::_id_1749("prisoner start alt", ::_id_D949, "", undefined, var_1);
  scripts\sp\utility::_id_1749("prisoner start sa", ::_id_D94C, "", undefined, var_1);
  scripts\sp\utility::_id_1749("prisoner r_elevator", ::_id_D945, "", undefined, level._id_FD6E._id_E46F);
  scripts\sp\utility::_id_1749("prisoner bridge", ::_id_D936, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("prisoner bridge pre ftl", ::_id_D934, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("prisoner lv_elevator", ::_id_D943, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("prisoner armory", ::_id_D932, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("prisoner airboss", ::_id_D931, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("leaving mem best case", ::_id_6F23, "", undefined, ["shipcrib_prisoner_hangar_tr"]);
  scripts\sp\utility::_id_1749("leaving mem best case preload", ::_id_D944, "", undefined, ["shipcrib_prisoner_hangar_tr"]);
  scripts\sp\utility::_id_1749("transient: preload cost sa", ::_id_D93A, "", undefined, var_1);
  scripts\sp\utility::_id_1749("transient: preload cost mainline", ::_id_D93A, "", undefined, var_0);
  scripts\sp\utility::_id_1749("transient: sa free", ::_id_D93A, "", undefined, ["shipcrib_prisoner_hangar_tr", "shipcrib_prisoner_jackal_tr"]);
  scripts\sp\utility::_id_1749("transient: mainline free", ::_id_D93A, "", undefined, ["shipcrib_prisoner_hangar_tr", "shipcrib_prisoner_dropship_tr"]);
  scripts\sp\utility::_id_1749("sc_sa_assa", ::_id_D94C, "", undefined, var_2);
  scripts\sp\utility::_id_1749("sc_sa_emp", ::_id_D94C, "", undefined, var_2);
  scripts\sp\utility::_id_1749("sc_sa_vips", ::_id_D94C, "", undefined, var_2);
  scripts\sp\utility::_id_1749("sc_sa_wound", ::_id_D94C, "", undefined, var_2);
  scripts\sp\utility::_id_1749("sc_ja_asteroid", ::_id_D94C, "", undefined, var_2);
  scripts\sp\utility::_id_1749("sc_ja_mining", ::_id_D94B, "", undefined, var_2);
  scripts\sp\utility::_id_1749("sc_ja_spacestation", ::_id_D94C, "", undefined, var_2);
  scripts\sp\utility::_id_1749("sc_ja_titan", ::_id_D94C, "", undefined, var_2);
  scripts\sp\utility::_id_1749("sc_ja_wreckage", ::_id_D94C, "", undefined, var_2);
  scripts\sp\utility::_id_116CB("shipcrib_prisoner");
  scripts\sp\maps\shipcrib_prisoner\gen\shipcrib_prisoner_art::main();
  scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_fx::main();
  scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_precache::main();
  scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_anim::main();
  level _id_0EE4::_id_FDDB();
  scripts\sp\load::main();
  _id_F980();
  level._id_C67F = _id_0EDE::_id_C67F;
  level._id_E366 = scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_ambient::_id_1DBF;
  level._id_13567 = "shipcrib_prisoner_vr_tr_loaded";
  level._id_E3FB = "shipcrib_prisoner_exterior_tr_loaded";
  level._id_FD69 = _id_10A3::_id_3B9D;
  level._id_FD68 = _id_10A3::_id_3B9E;
  level thread _id_0EE4::_id_FDAF();
  level thread _id_0EDC::_id_448B();
  level thread _id_0EDC::_id_BBAC();
  level thread _id_0EF0::_id_FD9F();
  level thread _id_10AC::_id_97A5();
  level thread _id_0EF2::_id_9A41();
  precachemodel("ally_robot_c12");
  precachemodel("hero_jackal_helmet_a");
  precachemodel("vr_goggles_hero_xo");
  precachemodel("weapon_vr_rifle_wm");
  precachemodel("pack_un_jackal_pilots");
  precachemodel("pack_eth3n_zerog");
  precachemodel("default_character_shadow");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_20");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_19");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_18");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_17");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_15");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_14");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_13");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_12");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_11");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_10");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_09");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_08");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_07");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_06");
  precachemodel("veh_mil_air_un_destroyer_periph_dst_piece_05");
  level.player _meth_84C7("lastShipcribMission", level.script);
  level._id_EC84 = level.player _meth_84C6("scPrisonerFirstPlay");

  if(!isDefined(level._id_EC84))
    level._id_EC84 = 1;
}

_id_F980() {
  scripts\engine\utility::flag_init("jackal_taxi_clear");
  scripts\engine\utility::flag_init("forklift_a_clear");
  scripts\engine\utility::flag_init("forklift_c_clear");
  scripts\engine\utility::flag_init("return_jackal_elevator_done");
  scripts\engine\utility::flag_init("return_deck_conversation_done");
  scripts\engine\utility::flag_init("moving_to_bridge");
  scripts\engine\utility::flag_init("bridge_setup");
  scripts\engine\utility::flag_init("moving_to_mezz");
  scripts\engine\utility::flag_init("c12_elevator_ready");
  scripts\engine\utility::flag_init("player_in_dropship");
  scripts\engine\utility::flag_init("dropship_scene_start");
  scripts\engine\utility::flag_init("dropship_launch_complete");
  scripts\engine\utility::flag_init("start_launch");
  scripts\engine\utility::flag_init("salter_entering_ship");
  scripts\engine\utility::flag_init("salter_in_ship");
  scripts\engine\utility::flag_init("ethen_in_ship");
  scripts\engine\utility::flag_init("salter_in_seat");
  scripts\engine\utility::flag_init("player_at_seat");
  scripts\engine\utility::flag_init("dialog_done");
  scripts\engine\utility::flag_init("tigris_setup");
  scripts\engine\utility::flag_init("unlock_quarters");
  scripts\engine\utility::flag_init("salter_at_cic");
  scripts\engine\utility::flag_init("cic_started");
  scripts\engine\utility::flag_init("prisoner_bridge_enter");
  scripts\engine\utility::flag_init("capops_ftl_triggered");
}

_id_D93A() {}

_id_30B6() {
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  _id_118B0();
  _id_118B1();
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

_id_D948() {
  _id_D946();

  if(!isDefined(level.player _meth_84C6("lastCompletedMission")))
    level.player _meth_84C7("lastCompletedMission", "rogue");

  if(isDefined(level.player _meth_84C6("lastCompletedMission")) && level.player _meth_84C6("lastCompletedMission") == "rogue") {
    level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
    _id_0EFB::_id_FDD7();
    level _id_0EE4::_id_FDD5();
    scripts\engine\utility::flag_wait("shipcrib_prisoner_dropship_tr_loaded");
    _id_0EF9::_id_FE03("dropship", "vehicle_dropship_return");
    level._id_FD6E._id_5EE3["vehicle_dropship_return"] _id_0BBF::_id_106BA(undefined, 1);
    level._id_FD6E._id_5EE3["vehicle_dropship_return"] _id_0BBF::_id_F37F("right_cockpit");
    level._id_FD6E._id_5EE3["vehicle_dropship_return"] _id_0BBC::_id_4265(["back"], 1);
    level._id_FD6E._id_5EE3["vehicle_dropship_return"] _id_0BBF::_id_F456();
    var_0 = scripts\engine\utility::play_loopsound_in_space("shipcrib_dropship_warmup", (-624, 2578, -907));
    var_0 linkTo(level._id_FD6E._id_5EE3["vehicle_dropship_return"]);
    scripts\sp\utility::_id_11633(getEnt("dropship_return_player_start", "targetname"));
    thread intro_dof_blend();
    _id_A80C();
  } else {
    level thread _id_D94E();
    level thread _id_0EF7::_id_FDE6();
    level _id_0EE4::_id_FDD5();
  }
}

intro_dof_blend() {
  thread _id_0B0A::_id_583F(0, 65, 7, 0.05, 75, 6, 0);
  wait 4.0;
  thread _id_0B0A::_id_583D(3);
}

_id_D949() {
  _id_D948();
}

_id_D94C() {
  var_0 = getmapsuncolorandintensity();
  level._id_FD6E._id_111D6 = var_0[3];
  level._id_EC84 = 0;
  _id_0EE4::_id_A919();
  _id_D948();
}

_id_D94B() {
  level._id_EC84 = 0;
  _id_0EE4::_id_A919();
  level.player _meth_84C7("missionStateData", "ja_mining", "incomplete");
  level.player _meth_84C7("opsmapMissionStateData", "ja_mining", "incomplete");
  _id_D948();
}

_id_D94A() {
  var_0 = getmapsuncolorandintensity();
  level._id_FD6E._id_111D6 = var_0[3];
  level._id_EC84 = 1;
  level.player _meth_84C7("lastCompletedMission", "rogue");
  level.player _meth_84C7("scPrisonerFirstPlay", 1);
  _id_D948();
}

_id_D945() {
  var_0 = getmapsuncolorandintensity();
  level._id_FD6E._id_111D6 = var_0[3];
  _id_0EE4::_id_E389("hangar_claxon");
  _id_0EE4::_id_E389("return_deck_claxon");
  level._id_EC84 = 1;
  level.player _meth_84C7("lastCompletedMission", "rogue");
  level.player _meth_84C7("scPrisonerFirstPlay", 1);
  _id_D946();
  scripts\engine\utility::flag_set("landing_walk_and_talk_start");
  _id_0EF8::_id_FDFC("spawner_salter", "shipcrib_prisoner_salter_return_elevator_on");
  _id_0EF8::_id_FDFC("spawner_ethan", "shipcrib_prisoner_ethan_return_elevator_on");
  _id_0EF8::_id_FDFC("spawner_gibson", "catwalk_return_gibson_idle");
  scripts\engine\utility::flag_init("salter_on_elevator_ready");
  scripts\engine\utility::flag_init("ethan_on_elevator_ready");
  scripts\engine\utility::flag_set("salter_on_elevator_ready");
  scripts\engine\utility::flag_set("ethan_on_elevator_ready");
  scripts\sp\utility::_id_11633(getEnt("r_elevator_start", "targetname"));
  _id_E448();
}

_id_D943() {
  level._id_FD6E._id_111D6 = 0.9;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.5);
  setsundirection(anglesToForward((-35, 28, 0)));
  setsuncolorandintensity(1, 0.87, 0.836);
  level.player _meth_84C7("lastCompletedMission", "rogue");
  level.player _meth_84C7("scPrisonerFirstPlay", 1);
  _id_D946();
  level._id_11940 hide();
  level._id_11941 hide();
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter", "bridge_elevator_ai_corner");
  level thread _id_0B21::_id_5A43("bridge_exit", "open");
  level scripts\engine\utility::delaythread(3.0, ::_id_48D7);
  var_0 = _id_0EEB::_id_7976("bridge");
  var_1 = getstartorigin(var_0.origin, var_0.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("leave_elevator_performance"));
  var_2 = getstartangles(var_0.origin, var_0.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("leave_elevator_performance"));
  level._id_EA2C _meth_80F1(var_1, var_2, 100000);
  _id_AB12();
}

_id_D94D() {
  scripts\sp\utility::_id_13705();
}

_id_D94E() {
  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_12641("shipcrib_prisoner_prime_tr");
  scripts\sp\utility::_id_12641("shipcrib_prisoner_bridgem_tr");
  level thread scripts\sp\utility::_id_12643(["shipcrib_prisoner_bridgee_tr"]);
}

_id_D944() {
  level thread _id_6F23();
  wait 5;
  preloadzones("sa_assassination");
}

_id_A80C() {
  _id_0EEB::_id_7976("return") scripts\sp\utility::_id_C12D("doors_close", 0.3);
  scripts\engine\utility::delaythread(0.3, _id_0B21::_id_5A43, "deck_return_elevator", "locked");
  level thread _id_A7EF();
  scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_ambient::_id_8AB5();
  _id_0EF8::_id_FDFC("spawner_salter", "dropship_return_salter_start");
  level._id_EA2C scripts\sp\utility::_id_C81A("casual");
  level._id_EA2C scripts\sp\utility::_id_65E0("return_dropship_nag");
  _id_0EF8::_id_FDFC("spawner_ethan", "dropship_return_ethan_start");
  level._id_6754 scripts\sp\utility::_id_C81A("casual");
  _id_0EE4::_id_E389("hangar_claxon");
  _id_0EE4::_id_E389("return_deck_claxon");
  level thread _id_A7E2();
  level thread _id_E42B();
}

_id_A7EF() {
  level thread _id_A7F0();
  wait 1;
  level._id_EA2C thread _id_0B6A::_id_EC0A("dropship_return_salter_wait");
  level._id_6754 scripts\engine\utility::delaythread(4, scripts\sp\anim::_id_1F35, level._id_6754, "greet_salter");
  wait 1;
  level endon("landing_walk_and_talk_start");
  wait 10;
  level._id_30F6 scripts\sp\utility::_id_65E8("return_dropship_conversation");
  level thread _id_A80A();
}

_id_A7F0() {
  level._id_EFED = "inside";
  var_0 = _id_0EFB::_id_FE02("player_rig");
  var_0 hide();
  var_1 = level._id_FD6E._id_5EE3["vehicle_dropship_return"];
  var_1 _id_0BBF::_id_F37F("right_cockpit");
  var_2 = var_1 _id_0BBF::_id_796D("right_cockpit");
  var_2._id_1FBB = "seat";
  var_3 = var_2 scripts\sp\utility::_id_7DC1("shipcrib_prisoner_camo_change_seat");
  var_4 = var_0 scripts\sp\utility::_id_7DC1("shipcrib_prisoner_camo_change_plr");
  var_0.origin = getstartorigin(var_2.origin, var_2.angles, var_4);
  var_0.angles = getstartangles(var_2.origin, var_2.angles, var_4);
  var_0 _meth_82E2("single anim", var_4, 1, 0, 0);
  var_0 thread scripts\sp\anim::_id_10CBF(var_0, "single anim");
  var_0 thread scripts\sp\anim::_id_1FCA(var_0, "single anim");
  var_2 _meth_82E2("single anim", var_3, 1, 0, 0);
  var_2 thread scripts\sp\anim::_id_10CBF(var_2, "single anim");
  var_2 thread scripts\sp\anim::_id_1FCA(var_2, "single anim");
  var_0 show();
  level.player _meth_823B(var_0, "tag_player");
  wait 1;
  level thread _id_0EFB::_id_FDD6(var_0, "Naval");
  var_0 _meth_82B1(var_4, 1);
  var_2 _meth_82B1(var_3, 1);
  wait(getanimlength(var_4));
  level.player unlink();
  var_0 delete();
}

_id_A80A() {
  level._id_EA2C scripts\sp\utility::_id_65E1("return_dropship_nag");
  level._id_EA2C scripts\sp\utility::_id_10347("sc_prisoner_slt_letsgetyoutothe");
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_65DD("return_dropship_nag");
}

_id_A7E2() {
  _id_0E9E::main();
  var_0 = level._id_FD6E._id_5EE3["vehicle_dropship_return"];
  var_0 scripts\engine\utility::delaythread(0.2, _id_0BBC::_id_C5F1, ["back"]);
  var_1 = scripts\engine\utility::getStruct("returndeck_brooks_idle1", "targetname");
  _id_0EF8::_id_FDFC("spawner_brooks", var_1.targetname);
  level._id_30F6 scripts\sp\utility::_id_65E0("return_dropship_conversation");
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_30F6, "dropship_idle");
  _id_0EF8::_id_FDFC("spawner_kash", "returndeck_kashima_idle1");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_A538, "shipcrib_prisoner_mr2_idle");
  var_2 = getEnt("landing_brooks_reaction", "targetname");
  var_2 thread _id_A7E1();
  var_3 = _id_0EF8::_id_FE01("spawner_medic", "vehicle_dropship_return", "cheap");
  var_3._id_1FBB = "dropship_medic1";
  var_4 = _id_0EF8::_id_FDFC("spawner_miner_male", "vehicle_dropship_return", "cheap");
  var_4._id_1FBB = "dropship_civilian1";
  var_5 = _id_0EF8::_id_FDFD("spawner_medic", "vehicle_dropship_return", "cheap");
  var_5._id_1FBB = "dropship_medic2";
  var_6 = _id_0EF8::_id_FDFC("spawner_miner_male", "vehicle_dropship_return", "cheap");
  var_6._id_1FBB = "dropship_civilian2";
  var_7 = _id_0EF8::_id_FE01("spawner_medic", "vehicle_dropship_return", "cheap");
  var_7._id_1FBB = "dropship_medic3";
  var_8 = _id_0EF8::_id_FDFC("spawner_miner_male", "vehicle_dropship_return", "cheap");
  var_8._id_1FBB = "dropship_civilian3";
  var_3 _id_0EFB::_id_FD6F("medics");
  var_5 _id_0EFB::_id_FD6F("medics");
  var_7 _id_0EFB::_id_FD6F("medics");
  var_4 _id_0EFB::_id_FD6F("civilians");
  var_6 _id_0EFB::_id_FD6F("civilians");
  var_8 _id_0EFB::_id_FD6F("civilians");
  var_0 thread scripts\sp\anim::_id_1EE7([var_3, var_4], "pre_idle", "stop_group1");
  var_0 thread scripts\sp\anim::_id_1EE7([var_5, var_6], "pre_idle", "stop_group2");
  var_0 thread scripts\sp\anim::_id_1EE7([var_7, var_8], "pre_idle", "stop_group3");
  var_9 = _id_0EF8::_id_FDFC("spawner_miner_male", "vehicle_dropship_return", "cheap");
  var_9 _id_0EFB::_id_FD6F("civilians");
  var_0 thread scripts\sp\anim::_id_1ECC(var_9, "SH_PRI_7_1_RETURN_FEMALE_A_idle");
  var_9 = _id_0EF8::_id_FDFC("spawner_miner_male", "vehicle_dropship_return", "cheap");
  var_9 _id_0EFB::_id_FD6F("civilians");
  var_0 thread scripts\sp\anim::_id_1ECC(var_9, "SH_PRI_7_1_RETURN_MALE_A_idle");
  var_9 = _id_0EF8::_id_FDFC("spawner_miner_male", "vehicle_dropship_return", "cheap");
  var_9 _id_0EFB::_id_FD6F("civilians");
  var_0 thread scripts\sp\anim::_id_1ECC(var_9, "SH_PRI_7_1_RETURN_MALE_B_idle");
  var_9 = _id_0EF8::_id_FDFC("spawner_miner_male", "vehicle_dropship_return", "cheap");
  var_9 _id_0EFB::_id_FD6F("civilians");
  var_0 thread scripts\sp\anim::_id_1ECC(var_9, "SH_PRI_7_1_RETURN_MALE_C_idle");
  var_9 = _id_0EF8::_id_FE01("spawner_flightdeck", "returndeck_prisoner_catwalkguy1a", "cheap", undefined, undefined, 1);
  var_1 = scripts\engine\utility::getStruct("returndeck_prisoner_catwalkguy1a", "targetname");
  var_1 thread scripts\sp\anim::_id_1EEA(var_9, var_1.animation);
  var_9 = _id_0EF8::_id_FE01("spawner_flightdeck", "returndeck_prisoner_catwalkguy1b", "cheap", undefined, undefined, 1);
  var_1 = scripts\engine\utility::getStruct("returndeck_prisoner_catwalkguy1b", "targetname");
  var_1 thread scripts\sp\anim::_id_1EEA(var_9, var_1.animation);
  var_1 = scripts\engine\utility::getStruct("hangar_catwalk_flat_struct", "targetname");
  var_9 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "hangar_catwalk_flat_struct", "cheap", undefined, undefined, 1);
  var_9 thread scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_ambient::_id_3B9A();
  var_1 thread scripts\sp\anim::_id_1ECC(var_9, "shipcrib_hangar_catwalk_flat_guyA_02");
  var_9 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", "hangar_catwalk_flat_struct", "cheap", undefined, undefined, 1);
  var_9 thread scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_ambient::_id_3B9B();
  var_1 thread scripts\sp\anim::_id_1ECC(var_9, "shipcrib_hangar_catwalk_flat_guyB_02");
  var_9 = _id_0EF8::_id_FE01("spawner_interior", "returndeck_prisoner_catwalkguy3", "cheap");
  var_9._id_1FBB = "phone_guy";
  var_9 attach("equipment_wall_mounted_phone_handset_01", "tag_accessory_right");
  var_1 = scripts\engine\utility::getStruct("returndeck_prisoner_catwalkguy3", "targetname");
  var_1 thread scripts\sp\anim::_id_1EEA(var_9, "shipcrib_hangar_phone_idle_01");
  var_9 thread scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_ambient::_id_CACD();
  var_1 = scripts\engine\utility::getStruct("returndeck_prisoner_scrubber", "targetname");
  var_9 = _id_0EF8::_id_FE01("spawner_flightdeck_maintenance", var_1.targetname, "cheap");
  var_9._id_1FBB = "scrubber";
  var_9._id_1EF1 = scripts\sp\utility::_id_10639("brush", var_1.origin);
  var_1 thread scripts\sp\anim::_id_1EE7([var_9, var_9._id_1EF1], "Shipcrib_hangar_scrubbing_01_guy");
  var_1 = scripts\engine\utility::getStruct("returndeck_prisoner_dropshipguy3", "targetname");
  var_9 = _id_0EF8::_id_FE01("spawner_marine", "returndeck_prisoner_dropshipguy3", "cheap", 1);
  var_1 thread scripts\sp\anim::_id_1ECC(var_9, "shipcrib_stand_stationary_talk_idle_05");
  level thread _id_A7E3();
  wait 2;
  var_0 thread _id_CD90([var_3, var_4], "stop_group1");
  var_0 thread _id_CD90([var_5, var_6], "stop_group2");
  var_0 thread _id_CD90([var_7, var_8], "stop_group3");
}

_id_A7E1() {
  self waittill("trigger");
  level._id_30F6 scripts\sp\utility::_id_65E1("return_dropship_conversation");
  level._id_30F6 thread scripts\sp\utility::_id_7792(level.player, 1);
  wait 0.5;
  level._id_30F6 scripts\sp\utility::_id_10346("sc_prisoner_brk_wellhandlethiss");
  wait 0.125;
  level.player scripts\sp\utility::_id_1034D("sc_prisoner_plr_meetmeonthebrid");
  level._id_30F6 thread scripts\sp\utility::_id_77B7("salute");
  level._id_30F6 scripts\sp\utility::_id_10346("sc_prisoner_brk_yessir");
  level._id_A538 scripts\engine\utility::delaythread(1, _id_0EE5::_id_202D, undefined, "sc_prisoner_ksh_didagoodthinghe");
  level._id_30F6 thread scripts\sp\utility::_id_65DE("return_dropship_conversation", 8);
  level._id_30F6 thread scripts\sp\utility::_id_77B9(0.7);
  wait 2.0;
  level._id_30F6 thread _id_0EE5::_id_202D();
}

_id_CD90(var_0, var_1) {
  level endon("kill_return_deck_ambient");
  self notify(var_1);
  scripts\sp\anim::_id_1F2C(var_0, "medic_goto_civilian");
  thread scripts\sp\anim::_id_1EE7(var_0, "post_idle", "stop_loop");
}

_id_A7E3() {
  var_0 = level._id_FD6E._id_5EE3["vehicle_dropship_return"];
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "returndeck_prisoner_dropshipguy2b", "cheap");
  var_0 thread scripts\sp\anim::_id_1EEA(var_1, "shipcrib_dropship_serv_grnd_B_00_idle");
  scripts\engine\utility::flag_wait("landing_walk_and_talk_start");
  var_1 = _id_0EF8::_id_FE01("spawner_flightdeck", "returndeck_prisoner_dropshipguy2a", "cheap");
  var_0 thread scripts\sp\anim::_id_1EC7(var_1, "shipcrib_dropship_serv_grnd_A_03_A");
  var_0 waittill("shipcrib_dropship_serv_grnd_A_03_A");
  var_0 thread scripts\sp\anim::_id_1EEA(var_1, "shipcrib_dropship_serv_grnd_A_03_idle");
}

_id_E42B() {
  scripts\engine\utility::flag_wait("landing_walk_and_talk_start");
  level._id_EA2C scripts\sp\utility::_id_65E8("return_dropship_nag");
  level._id_EA2C scripts\sp\utility::_id_F492(1.1);
  var_0 = getnode("catwalk_return_ethan_wait_1", "targetname");
  level._id_6754 thread scripts\sp\utility::_id_F3DC(var_0.origin);
  level._id_6754 thread scripts\sp\anim::_id_1F35(level._id_6754, "beckon_player");
  level._id_6754 scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_779C, level.player);
  level thread _id_E42D();
  level thread _id_E42C();
  setmusicstate("mx_357f_scpris_start");
  scripts\engine\utility::flag_wait("return_deck_open_elevator");
  level.player clearclienttriggeraudiozone(1);
  level thread _id_0B21::_id_5A43("deck_return_elevator", "open");
  _id_0EEB::_id_7976("return") notify("doors_open");
  wait 0.25;
  _id_BCA3();
  scripts\engine\utility::flag_wait("return_deck_conversation_done");
  level thread _id_E43E();
  _id_E448();
}

_id_E42D() {
  wait 3;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_giveusthesitrep");
  level.player scripts\sp\utility::_id_1034D("sc_prisoner_plr_whathappenedeth");
  wait 0.5;
  level._id_6754 scripts\sp\utility::_id_10346("sc_prisoner_eth_distresscallfro");
  wait 0.5;
  level._id_6754 scripts\sp\utility::_id_10346("sc_prisoner_eth_shouldbeinyourh");
  wait 0.75;
  level _id_0EF3::_id_FD78("pip", "sc_prisoner_ferran_pip");
  wait 0.5;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_tigrisisunderat");
  level.player scripts\sp\utility::_id_1034D("sc_prisoner_plr_areweincontactw");
  level._id_6754 scripts\sp\utility::_id_10346("sc_prisoner_eth_solarflaresareb");
  level._id_EA2C scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_77BD, 1);
  level._id_6754 scripts\sp\utility::_id_10346("sc_prisoner_eth_gatoristryingto");
  level._id_6754 scripts\engine\utility::delaythread(0.5, scripts\sp\utility::_id_77BD, 1);
  scripts\engine\utility::flag_set("return_deck_conversation_done");
}

_id_E42C() {
  wait 0.75;
  level._id_EA2C thread _id_0B6A::_id_EC0A("catwalk_return_salter_wait_1");
  level._id_EA2C scripts\sp\utility::_id_779C(level._id_6754);
  scripts\engine\utility::flag_wait("return_deck_walkntalk_p1");
  level._id_6754 thread _id_0B6A::_id_EC0A("catwalk_return_ethan_wait_2");
  level._id_EA2C scripts\engine\utility::delaythread(0.5, _id_0B6A::_id_EC0A, "catwalk_return_salter_wait_2");
  scripts\engine\utility::flag_wait("return_deck_walkntalk_p2");
  level._id_6754 thread _id_0B6A::_id_EC0A("catwalk_return_ethan_wait_3");
  level._id_EA2C scripts\engine\utility::delaythread(0.5, _id_0B6A::_id_EC0A, "catwalk_return_salter_wait_3");
  level._id_6754 waittill("sceneblock_reach_finished");
  level._id_EA2C scripts\sp\utility::_id_F492(1);
}

_id_BCA3() {
  scripts\engine\utility::flag_init("ethan_on_elevator");
  scripts\engine\utility::flag_init("ethan_on_elevator_ready");
  scripts\engine\utility::flag_init("salter_on_elevator");
  scripts\engine\utility::flag_init("salter_on_elevator_ready");
  var_0 = _id_0EEB::_id_7976("return") createendzone((0, 0, 0), (0, -90, 0));
  thread _id_DD09(var_0);
  thread _id_DD0A(var_0);
  scripts\engine\utility::flag_wait_all("ethan_on_elevator", "salter_on_elevator");
}

_id_DD09(var_0) {
  var_1 = getstartorigin(var_0.origin, var_0.angles, level._id_6754 scripts\sp\utility::_id_7DC1("return_elevator_idle")[0]);
  var_2 = getstartangles(var_0.origin, var_0.angles, level._id_6754 scripts\sp\utility::_id_7DC1("return_elevator_idle")[0]);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1, var_2);
  var_3 linkTo(var_0);
  level._id_6754 thread _id_0B6A::_id_EC0A(var_3, undefined, undefined, undefined, undefined, 1);
  level._id_6754 waittill("sceneblock_reach_finished");
  level._id_6754 thread _id_AD15(_id_0EEB::_id_7976("return"), "move_finished");
  scripts\engine\utility::flag_set("ethan_on_elevator");
  var_3 scripts\sp\anim::_id_1EC7(level._id_6754, "shipcrib_stand_idle01_arrival");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_6754, "return_elevator_idle", "stop_ethan_loop");
  scripts\engine\utility::flag_set("ethan_on_elevator_ready");
  scripts\engine\utility::flag_wait("moving_to_bridge");
  var_0 notify("stop_ethan_loop");
  var_3 delete();
}

_id_DD0A(var_0) {
  var_1 = getstartorigin(var_0.origin, var_0.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("return_elevator_idle")[0]);
  var_2 = getstartangles(var_0.origin, var_0.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("return_elevator_idle")[0]);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1, var_2);
  var_3 linkTo(var_0);
  level._id_EA2C thread _id_0B6A::_id_EC0A(var_3, undefined, undefined, undefined, undefined, 1);
  level._id_EA2C waittill("sceneblock_reach_finished");
  level._id_EA2C thread _id_AD15(_id_0EEB::_id_7976("return"), "move_finished");
  scripts\engine\utility::flag_set("salter_on_elevator");
  var_3 scripts\sp\anim::_id_1EC7(level._id_EA2C, "shipcrib_stand_idle04_arrival");
  scripts\engine\utility::flag_set("salter_on_elevator_ready");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "return_elevator_idle", "stop_salter_loop");
  scripts\engine\utility::flag_wait("moving_to_bridge");
  var_0 notify("stop_salter_loop");
  var_3 delete();
}

_id_E43E() {
  level._id_EA2C scripts\sp\utility::_id_65E0("return_elevator_nag");
  level thread _id_E43D();
  _id_0EEB::_id_7976("return").trigger endon("trigger");
  wait 6;
  level._id_EA2C scripts\sp\utility::_id_65E1("return_elevator_nag");
}

_id_E43D() {
  _id_0EEB::_id_7976("return") endon("move_finished");
  level._id_EA2C scripts\sp\utility::_id_65E3("return_elevator_nag");
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_comeonreyesnoth");
  level._id_EA2C scripts\sp\utility::_id_65DD("return_elevator_nag");
}

_id_5576() {
  if(level._id_EA2C scripts\sp\utility::_id_65DF("return_elevator_nag")) {
    if(level._id_EA2C scripts\sp\utility::_id_65DB("return_elevator_nag"))
      level._id_EA2C scripts\sp\utility::_id_65E8("return_elevator_nag");
  }
}

_id_E448() {
  _id_0EEB::_id_7976("return").trigger waittill("trigger");
  _id_E430();
  _id_E42E();
  scripts\engine\utility::flag_wait_all("ethan_on_elevator_ready", "salter_on_elevator_ready");
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  var_0 = getEnt("prisoner_return_player_collision", "targetname");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  thread _id_CDE0();
  scripts\engine\utility::flag_set("moving_to_bridge");
  _id_0EEB::_id_7976("return") waittill("move_finished");
  level thread _id_0B21::_id_5A43("return_elevator", "open");
  _id_0EEB::_id_7976("return") notify("doors_open");
  level thread scripts\sp\utility::_id_1264E("shipcrib_prisoner_ambient_tr");
  _id_0EE4::_id_E388("hangar_claxon");
  _id_0EE4::_id_E388("return_deck_claxon");
  level thread _id_0EF7::_id_E465();
  _id_B0BB();
}

_id_E430() {
  level thread _id_0B21::_id_5A43("deck_return_elevator", "locked");
  _id_0EEB::_id_7976("return") notify("doors_close");
  _id_5576();
  level._id_EFED = "inside";
}

createendzone(var_0, var_1) {
  var_2 = scripts\engine\utility::spawn_tag_origin();

  if(isDefined(var_1))
    var_2.angles = var_2.angles + var_1;

  if(isDefined(var_0))
    var_2.origin = var_2.origin + var_0;

  var_2 linkTo(self);
  return var_2;
}

_id_E42E() {
  if(scripts\engine\utility::flag("ethan_on_elevator_ready") && scripts\engine\utility::flag("salter_on_elevator_ready"))
    _id_0EEB::_id_60F0("return", 63);
  else
    _id_0EEB::_id_60F0("return", 58);

  thread _id_0EEB::_id_60FD("return", "Bridge Level");
}

_id_CDE0() {
  var_0 = [level._id_EA2C, level._id_6754];
  var_1 = "return_elevator_performance";
  var_2 = _id_0EEB::_id_7976("return") createendzone(undefined, (0, -90, 0));
  scripts\engine\utility::waitframe();
  var_2 scripts\sp\anim::_id_1F2C(var_0, var_1);
}

_id_ACFD() {
  var_0 = _id_0EEB::_id_7976("return");
  level._id_EA2C thread _id_AD15(var_0, "move_finished");
  level._id_6754 thread _id_AD15(var_0, "move_finished");
}

_id_AD15(var_0, var_1) {
  self linkTo(var_0, "");
  var_0 waittill(var_1);
  self unlink();
}

_id_B0BB() {
  scripts\engine\utility::flag_init("salter_at_door");
  scripts\engine\utility::flag_init("ethan_at_door");
  level._id_EA2C scripts\engine\utility::delaythread(1, ::_id_B0BD);
  level._id_6754 thread _id_B0BC();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  scripts\engine\utility::flag_wait_all("salter_at_door", "ethan_at_door");
  level thread _id_B0BA();
}

_id_B0BD() {
  level endon("prisoner_bridge_enter");
  thread _id_B0BE();
  _id_0B6A::_id_EC0B("lounge_hallway_salter_wait", "shipcrib_stand_stationary_talk_idle_03", undefined, undefined, undefined, undefined, undefined, 1);
  scripts\engine\utility::flag_set("salter_at_door");
  thread _id_0EE5::_id_202D(3, "sc_prisoner_slt_letsnotsweatthi");
}

_id_B0BC() {
  level endon("prisoner_bridge_enter");
  thread _id_B0BE();
  _id_0B6A::_id_EC0B("lounge_hallway_ethan_wait", "shipcrib_stand_stationary_talk_idle_01", undefined, undefined, undefined, undefined, undefined, 1);
  scripts\engine\utility::flag_set("ethan_at_door");
  thread _id_0EE5::_id_202D(1, "sc_prisoner_eth_commander");
}

_id_B0BE() {
  scripts\engine\utility::flag_wait("prisoner_bridge_enter");
  thread _id_0EE5::_id_10FC4();
}

_id_B0BA() {}

_id_D936() {
  var_0 = getmapsuncolorandintensity();
  level._id_FD6E._id_111D6 = var_0[3];
  thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
  level._id_EC84 = 1;
  level.player _meth_84C7("lastCompletedMission", "rogue");
  level.player _meth_84C7("scPrisonerFirstPlay", 1);
  scripts\sp\utility::_id_11633(getEnt("outside_bridge_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter", "lounge_hallway_salter_wait");
  _id_0EF8::_id_FDFC("spawner_ethan", "lounge_hallway_ethan_wait");
  level._id_EA2C thread scripts\sp\utility::_id_7792(level.player, 1);
  _id_D946();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
}

_id_D934() {
  level._id_FD6E._id_111D6 = 2;
  setsuncolorandintensity(0.84, 0.91, 1);
  scripts\engine\utility::waitframe();
  setsundirection(anglesToForward((-35, -54, 0)));
  thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
  level._id_EC84 = 1;
  level.player _meth_84C7("lastCompletedMission", "rogue");
  level.player _meth_84C7("scPrisonerFirstPlay", 1);
  _id_D946();
  level._id_11940 hide();
  level._id_11941 hide();
  var_0 = level._id_C6AA["retribution"]._id_10E52["captain"];
  var_0 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0.origin = var_0.origin + anglesToForward(var_0.angles) * -100;
  scripts\sp\utility::_id_11633(var_0);
  level thread _id_118B1();
  level._id_EFED = "inside_slow";
  _id_30B1();
  _id_0EF8::_id_FDFC("spawner_salter", level._id_C6AA["retribution"]._id_10E52["xo"]);
  level thread _id_0EE4::_id_E37A();
  wait 0.5;
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C642();
  level thread scripts\sp\interaction_manager::_id_45A7();
}

_id_D933() {
  level.player _meth_84C7("lastCompletedMission", "rogue");
  level.player _meth_84C7("scPrisonerFirstPlay", 1);
  _id_D946();
  var_0 = level._id_C6AA["retribution"]._id_10E52["captain"];
  var_0 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0.origin = var_0.origin + anglesToForward(var_0.angles) * -100;
  scripts\sp\utility::_id_11633(var_0);
  level thread _id_118B1();
  level._id_EFED = "inside_slow";
  _id_30B1();
  level thread _id_0EEE::_id_FD8C();
  _id_0EF8::_id_FDFC("spawner_salter", level._id_C6AA["retribution"]._id_10E52["xo"]);
  level thread _id_0EE4::_id_E37A();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  wait 0.5;
  level thread _id_3058();
}

_id_D935() {
  if(!level.console) {
    while(!scripts\engine\utility::flag(level.script + "_bridgee_tr_loaded")) {
      waitforalltransients();
      wait 0.15;
    }
  }

  scripts\engine\utility::flag_set("prisoner_bridge_enter");
  level._id_EA2C thread _id_0EE5::_id_10FC4();
  level._id_6754 thread _id_0EE5::_id_10FC4();
  level thread _id_495F();
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  _id_0EDB::early_out_broadcast();
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(3, _id_0EDE::_id_C683, "solar_system", undefined, 0);
  level _id_0B20::_id_AB71(self, "left_push_long", 0.4, ::_id_3081, 1, 1.0);
}

_id_3003() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level waittill("play_anim_ethan");
  var_0 scripts\sp\anim::_id_1F35(self, "pris_bridge_intro");
  var_0 scripts\sp\anim::_id_1F35(self, "pris_bridge_intro_comm_idle");
  scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_7799, level.player);
  scripts\engine\utility::flag_set("unlock_quarters");
  var_0 scripts\sp\anim::_id_1F35(self, "pris_bridge_intro_scene");
  scripts\engine\utility::flag_set("ethan_intro_done");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "pris_bridge_intro_scene_idle", "stop_ethan_loop");
  level scripts\engine\utility::delaythread(1.0, ::_id_304D);

  if(scripts\engine\utility::flag_exist("computer_started") && !scripts\engine\utility::flag("computer_started"))
    level scripts\sp\utility::_id_914C("fluff_messages_capops", "fluff_messages_capops_body", "capops_intel", level._id_448C._id_99FC.origin);

  if(scripts\engine\utility::flag_exist("computer_started"))
    scripts\engine\utility::flag_wait("computer_started");

  var_0 notify("stop_ethan_loop");
  scripts\sp\utility::_id_77B9(0.7);
}

_id_3072() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("salter", "playanim_sh_pri_7_5_ethan_br_c6i_intro", "play_anim_ethan", "pris_bridge_intro");
  scripts\sp\anim::_id_17FC("salter", "pvo_sc_prisoner_plr_justdoitsalt", "just_do_it", "pris_bridge_intro");
  thread scripts\sp\utility::_id_416A();
  level waittill("play_anim_salter");
  scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_7792, level.player, 1);
  var_0 scripts\sp\anim::_id_1F35(self, "pris_bridge_intro");
  thread _id_0EFB::_id_CD3F("opsmap_salter_react");
  thread scripts\sp\utility::_id_77B9(0.7);
  _id_137C9(200.0);
  scripts\engine\utility::flag_set("player_away_from_salter_on_bridge");
  self waittill("move_to_con");
  var_0 notify("stop_salter_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "pris_bridge_intro_ops_to_conn");
  thread _id_0EFB::_id_CD3F("opsmap_conn_react");

  if(scripts\engine\utility::flag_exist("computer_started"))
    scripts\engine\utility::flag_wait("computer_started");

  thread _id_0EFB::_id_11004();
  scripts\engine\utility::waitframe();
  thread _id_0EFB::_id_CD3F("opsmap_salter_react");
}

_id_D337() {
  level endon("kill_reyes_salter_has_con_vo");
  scripts\engine\utility::flag_wait("player_away_from_salter_on_bridge");
  scripts\engine\utility::flag_wait("ethan_intro_done");
  scripts\engine\utility::flag_waitopen("ethan_anim_nag");
  scripts\engine\utility::flag_set("reyes_salter_has_con_vo");
  level.player scripts\sp\utility::_id_1034D("sc_prisoner_plr_lieutenantsalte");
  level._id_EA2C notify("move_to_con");
  scripts\engine\utility::flag_clear("reyes_salter_has_con_vo");
}

_id_301F() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("gator", "playanim_sh_pri_7_5_ethan_br_xo_intro", "play_anim_salter", "pris_bridge_intro");
  var_0 scripts\sp\anim::_id_1F35(self, "pris_bridge_intro");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
}

_id_3020() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH_PRI_7_5_Ethan_BR_monitor_intro");
}

_id_2FFA() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  wait 0.05;
  level._id_5CFC thread _id_0EFB::_id_CD3F("opsmap_drops_react");
}

_id_3034() {
  level waittill("just_do_it");

  if(scripts\sp\utility::_id_D1DF(level._id_EA2C getEye(), 0.7, 1))
    return;
}

_id_3081() {
  setmusicstate("");
  scripts\engine\utility::flag_init("player_away_from_salter_on_bridge");
  scripts\engine\utility::flag_init("ethan_intro_done");
  scripts\engine\utility::flag_init("reyes_salter_has_con_vo");
  scripts\engine\utility::flag_init("ethan_anim_nag");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_EFED = "inside_slow";
  _id_30B1();
  wait 2.0;
  level._id_6754 thread _id_3003();
  level._id_EA2C thread _id_3072();
  level._id_76FB thread _id_301F();
  level thread _id_3020();
  level._id_5CFC thread _id_2FFA();
  level thread _id_3034();
  level thread _id_D337();
  level thread scripts\sp\interaction_manager::_id_F2A7("busy");
  level scripts\engine\utility::delaythread(4, _id_0EE4::_id_E37A);
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(1.5, _id_0EDE::_id_C670, "down");
  scripts\engine\utility::flag_wait("unlock_quarters");
  level thread _id_0EEE::_id_FD8B(1);
  level thread _id_0EEE::_id_25B2();
  level thread _id_0B20::_id_5A2E("captains_quarters", "unlocked", "aggressive");
  level thread _id_0B20::_id_794A("captains_quarters")._id_5A3F _id_0E46::_id_DFE3();
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3068);
  level thread _id_0EDC::_id_448D("message");
}

_id_304D() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_EA2C thread _id_0EE5::_id_202D(undefined, "sc_prisoner_slt_rainmanswaitinr");
  level thread _id_3004();
  level._id_76FB thread _id_0EE5::_id_202D(undefined, "sc_prisoner_nav_wellbeheadingou");
  level._id_5CFC thread _id_0EE5::_id_202D(undefined, "sc_prisoner_dpo_calculatingourr");
  level._id_4451 thread _id_0EE5::_id_202D(undefined, "sc_prisoner_cmo_sirtheadmiralsu");
  level._id_1044B thread _id_0EE5::_id_202D(undefined, "sc_prisoner_sip_youhaveacalliny");
  scripts\engine\utility::flag_wait("computer_started");
  level._id_76FB thread _id_0EE5::_id_10FC4();
  level._id_EA2C thread _id_0EE5::_id_10FC4();
  level._id_5CFC thread _id_0EE5::_id_10FC4();
  level._id_1044B thread _id_0EE5::_id_10FC4();
  level._id_4451 thread _id_0EE5::_id_10FC4();
  level._id_6754 thread _id_0EE5::_id_10FC4();
}

_id_3004() {
  level endon("kill_ethan_anim_nag");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_6754 thread scripts\sp\utility::_id_7799(level.player);

  if(distance2dsquared(level._id_6754.origin, level.player.origin) <= 7225) {
    scripts\engine\utility::flag_waitopen("reyes_salter_has_con_vo");
    scripts\engine\utility::flag_set("ethan_anim_nag");
    var_0 scripts\sp\anim::_id_1F35(level._id_6754, "pris_bridge_intro_nag");
    scripts\engine\utility::flag_clear("ethan_anim_nag");
  }

  level._id_6754 _id_0EE5::_id_202D();
}

_id_3005() {
  level endon("stop_reminders");
  wait 30.0;
  scripts\engine\utility::flag_wait("ethan_anim_nag");
  level._id_6754 scripts\sp\utility::_id_10346("sc_prisoner_eth_ibelievethecomm");
}

_id_3068() {
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  level thread _id_3067(self);
  level _id_0B20::_id_AB71(self, "right_push", 0.4);
}

_id_3067(var_0) {
  level notify("enter_quarters");
  level thread scripts\sp\interaction_manager::_id_11037();

  if(!scripts\engine\utility::flag("reyes_salter_has_con_vo")) {
    level notify("kill_reyes_salter_has_con_vo");
    level._id_EA2C notify("move_to_con");
  }

  if(!scripts\engine\utility::flag("ethan_anim_nag"))
    level notify("kill_ethan_anim_nag");

  level thread _id_0EDC::_id_54FA();
  wait 0.1;
  level thread _id_6ADF();
  scripts\engine\utility::flag_wait("computer_started");
  level._id_EA2C thread scripts\sp\utility::_id_10346("sc_prisoner_slt_allhandsdrop_pa");
  stopcinematicingame();
  level._id_C6AA["retribution"]._id_BA11["nav"] clearanim(level._id_C6AA["retribution"]._id_BA11["nav"] scripts\sp\utility::_id_7DC1("SH_PRI_7_5_Ethan_BR_monitor_intro"), 0.2);
  scripts\engine\utility::flag_set("capops_ftl_triggered");
  level thread _id_0EEE::_id_FD89("prisoner", "retribution", ::_id_A612, ::_id_7478, 10.5);
  level._id_EA2C scripts\engine\utility::delaythread(7.0, scripts\sp\utility::_id_10346, "sc_prisoner_nav_dropin321_pa");
  level.player scripts\engine\utility::delaythread(6.5, scripts\sp\utility::_id_1034D, "sc_prisoner_plr_commandernickre");
  level thread _id_0B20::_id_5A2E("captains_quarters", "locked");
  wait 1.0;
  level thread _id_EB8A("sc_prisoner_world_hvt_briefing", 1, 1);
  level._id_3A2D scripts\engine\utility::delaycall(0.1, ::show);
  level thread _id_3066(var_0);
  level._id_EA2C scripts\engine\utility::delaythread(17.5, scripts\sp\utility::_id_10346, "sc_prisoner_nav_destinationin32_pa");
  level thread scripts\sp\utility::_id_C12D("ftl_3_sec_left", 18.0);
  level thread scripts\sp\utility::_id_C12D("ftl_stop", 21.0);
  level thread _id_39FF();
  level waittill("sc_bink_done");
  level thread _id_6AE0();
  level thread _id_0EEE::_id_FD8A(1);
  wait 0.5;
  level thread _id_3069();
  wait 1.0;
}

_id_7478() {
  visionsetnaked("shipcrib_prisoner_tigris", 0.5);
  level._id_FD6E._id_111D6 = 4;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.5);
  setsundirection(anglesToForward((16, -105, 0)));
  setsuncolorandintensity(1, 0.5, 0.253);
}

_id_39FF() {
  wait 10.0;
  level._id_11940 hide();
  level._id_11941 hide();
}

_id_6ADF() {
  var_0 = scripts\engine\utility::getStruct("captains_computer_moveto", "targetname");

  if(!isDefined(level._id_1FBD))
    level._id_1FBD = var_0 scripts\engine\utility::spawn_tag_origin();

  var_1 = level._id_448C._id_99FC;
  var_1 thread _id_0E46::_id_48C4(undefined, undefined, &"SHIPCRIB_COMPUTER", 180, 240, 70, 0, undefined, undefined, undefined, 0);
  var_1 waittill("trigger");
  level._id_CFB9 = _id_0EFB::_id_FE02("player_rig", level.player.origin, level.player.angles);
  level._id_CFB9 hide();
  level._id_1FBD scripts\sp\anim::_id_1EC3(level._id_CFB9, "computer_enter", "tag_player");
  scripts\engine\utility::waitframe();
  level.player _meth_823C(level._id_CFB9, "tag_player", 0.5, 0.1, 0.1);
  level._id_CFB9 scripts\engine\utility::delaycall(0.5, ::show);
  level.player scripts\sp\utility::_id_F526("normal");
  wait 0.55;
  level.player _meth_823B(level._id_CFB9, "tag_player");
  level thread _id_0EDC::_id_39FB();
  level._id_1FBD thread scripts\sp\anim::_id_1F35(level._id_3A2C, "computer_enter");
  level._id_1FBD scripts\sp\anim::_id_1F35(level._id_CFB9, "computer_enter", "tag_player");

  if(isDefined(level.console) && level.console) {
    level.player playerlinktodelta(level._id_CFB9, "tag_player", 0.3, 45, 45, 45, 45, 1);
    level.player _meth_8392(1, 2.2, 0.6);
  }

  level._id_1FBD thread scripts\sp\anim::_id_1EEA(level._id_CFB9, "computer_idle", "stop_loop", "tag_player");
  level._id_1FBD thread scripts\sp\anim::_id_1EEA(level._id_3A2C, "computer_idle", "stop_loop");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("computer_started");
  level thread _id_0EDC::_id_448D("off");
}

_id_6AE0() {
  level._id_1FBD notify("stop_loop");
  level thread _id_0EDC::_id_448D("on");
  level.player scripts\sp\utility::_id_F526("safe");
  level._id_EFED = "inside";
  level thread _id_0EDC::_id_39FC();
  level.player _meth_8391(1.0);
  level._id_1FBD thread scripts\sp\anim::_id_1F35(level._id_3A2C, "computer_exit");
  level._id_1FBD scripts\sp\anim::_id_1F35(level._id_CFB9, "computer_exit", "tag_player");
  level.player unlink();
  level._id_CFB9 delete();
  level._id_3A2D hide();
  level._id_EB94 = 1;

  for(;;) {
    var_0 = scripts\sp\utility::_id_D1DF(level._id_448C._id_99FC.origin, 0.5, 1);

    if(!var_0) {
      break;
    }

    wait 0.05;
  }

  level thread _id_0EDC::_id_448C();
}

_id_3066(var_0) {
  wait 26.0;
  var_0._id_5A3C showpart("door_unlocked");
  var_0._id_5A3C hidepart("door_locked");
  var_0._id_5A3C hidepart("door_inactive");
  var_0 thread _id_0B20::_id_5A42("unlocked");
  level._id_6790 = var_0 scripts\engine\utility::spawn_tag_origin();
  level._id_6790 scripts\sp\anim::_id_1F2C([level._id_6754, var_0._id_5A3C], "pris_office_intro");
  level thread _id_0B20::_id_5A2E("captains_quarters", "unlocked");
  level notify("objective_add_opsmap");
  level thread _id_0EDC::_id_BBA6();
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3099);
  level._id_6790 thread scripts\sp\anim::_id_1EEA(level._id_6754, "pris_office_idle", "stop_loop");
  level._id_6754 _id_0EE5::_id_202D(undefined, "sc_prisoner_eth_weshouldgetoutt");
}

_id_3069() {
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_prisoner_slt_reyesyouneedtog");
  level thread scripts\sp\interaction_manager::_id_E815(10.0);
  level waittill("exit_quarters");
  level thread scripts\sp\interaction_manager::_id_11037();
}

_id_3099() {
  level notify("exit_quarters");
  thread _id_0B0B::_id_257D(190, "shipcrib_titan_captain_room", undefined, "shipcrib_titan_bridge");
  level._id_6790 notify("stop_loop");
  level thread scripts\sp\interaction_manager::_id_1100A();
  level._id_6754 thread scripts\sp\interaction_manager::_id_10FF9();
  level._id_EA2C _id_0EE5::_id_10FC4();
  scripts\engine\utility::flag_clear("capops_ftl_triggered");
  var_0 = getEnt("shipcrib_prisoner_opsmap_hold_frame", "targetname");
  level scripts\engine\utility::delaythread(2.0, ::_id_EB8A, "sc_prisoner_cutscene_new_plan", 0, 1);
  level scripts\engine\utility::delaythread(4.5, ::_id_3098);
  var_0 scripts\engine\utility::delaycall(2.1, ::show);
  level thread _id_118B1();
  level.player disableusability();
  level._id_EFED = "inside_slow";
  level _id_0B20::_id_AB71(self, "right_pull", 0.4);
  level thread _id_0EFB::_id_FDBA(level._id_6754);
  level thread _id_0EF5::_id_FDF6("prisoner");
  level._id_76FB thread _id_0EFB::_id_CD3F("opsmap_gator_react");
  level._id_5CFC thread _id_0EFB::_id_CD3F("opsmap_drops_react");
  level._id_EA2C thread _id_0EFB::_id_CD3F("opsmap_salter_react");
  level waittill("player_bink_end_done");
  level.player _meth_84C7("captainComputerAudioState", "audiologFerran2", "open");
  level.player enableusability();
  level scripts\engine\utility::delaythread(1.0, ::_id_304E);
  level thread _id_C647();
  level._id_76FB scripts\sp\utility::_id_10346("sc_prisoner_nav_callitcaptainwi");
  level thread scripts\sp\interaction_manager::_id_45A7();
}

_id_7702() {
  if(isDefined(level._id_EC84) && level._id_EC84)
    scripts\engine\utility::flag_wait("at_fullscreen_opsmap");
}

_id_3098() {
  var_0 = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  var_0 hide();
  var_1 = level._id_C6AA["retribution"]._id_EF68;
  level._id_C6AA["retribution"] _id_0EDE::_id_C683("all_off");
  var_1 scripts\sp\anim::_id_1EC3(var_0, "player_bridge_bink_end");
  scripts\engine\utility::waitframe();
  var_0 show();
  level.player playerlinkTo(var_0, "tag_player", 1);
  level.player _meth_823C(var_0, "tag_player", 0.2, 0.1, 0.1);
  wait 0.25;
  level.player _meth_823B(var_0, "tag_player");
  level waittill("sc_bink_done");
  thread cutscene_new_plan_dof();
  var_2 = getEnt("shipcrib_prisoner_opsmap_hold_frame", "targetname");
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C678("shipcrib_prisoner_post_bridge_bink");
  var_2 scripts\engine\utility::delaycall(0.1, ::delete);
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(1, _id_0EDE::_id_C683, "solar_system", "prisoner", 0);
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(1.25, _id_0EDE::_id_C670, "up");
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(1.5, _id_0EDE::_id_C642);
  var_0 show();
  var_1 scripts\sp\anim::_id_1F35(var_0, "player_bridge_bink_end");
  level.player unlink();
  var_0 delete();
  level notify("player_bink_end_done");
}

cutscene_new_plan_dof() {
  thread _id_0B0A::_id_583F(0, 80, 7, 0.05, 120, 6, 0);
  wait 1.0;
  thread _id_0B0A::_id_583F(0, 80, 7, 0.05, 160, 6, 1.5);
  wait 1.5;
  thread _id_0B0A::_id_583D(1);
}

_id_C647() {
  level endon("mainline_selected");
  level waittill("opsmap_backed_out");
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_thisisagraveyar");
}

_id_304E() {
  level._id_76FB _id_0EE5::_id_202D(undefined, "sc_prisoner_nav_readywhenyouare");
  level._id_5CFC _id_0EE5::_id_202D(undefined, "sc_prisoner_dpo_preparedforwhat");
  level._id_1044B _id_0EE5::_id_2037("opsmap_boats_react", "sc_prisoner_bsw_tryingtimeshuhs");
  level._id_4451 _id_0EE5::_id_202D(undefined, "sc_prisoner_cmo_readyforordersc");
  level._id_EA2C thread _id_0EE5::_id_202D(undefined, "sc_prisoner_slt_thisisagraveyar");
  level._id_76FB scripts\sp\interaction_manager::_id_DB7B("sc_prisoner_nav_illplotacourse");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_prisoner_slt_whatsourtarget");
  scripts\engine\utility::waitframe();
  level thread scripts\sp\interaction_manager::_id_E815(30.0);
  level waittill("mainline_selected");
  level thread scripts\sp\interaction_manager::_id_11037();
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_76FB _id_0EE5::_id_10FC4();
  level._id_1044B _id_0EE5::_id_10FC4();
  level._id_5CFC _id_0EE5::_id_10FC4();
  level._id_4451 _id_0EE5::_id_10FC4();
}

_id_3071() {
  level endon("ftl_early_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("salter", "playanim_bsn_response_01", "playanim_bsn_response_01", "SH_PRI_7_11B_PRE_JUMP_XO_arrive");
  scripts\sp\anim::_id_17FC("salter", "playanim_bsn_response_02", "playanim_bsn_response_02", "SH_PRI_7_11B_PRE_JUMP_XO_briefing");
  scripts\sp\anim::_id_17FC("salter", "playanim_outro", "playanim_outro", "SH_PRI_7_11B_PRE_JUMP_XO_briefing");
  scripts\sp\anim::_id_17FC("salter", "playanim_phone", "playanim_phone_salter", "SH_PRI_7_11B_PRE_JUMP_XO_briefing");
  thread _id_0EFB::_id_11004();
  var_0 notify("stop_salter_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_XO_arrive");
  scripts\engine\utility::flag_set("salter_at_cic");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH_PRI_7_11B_PRE_JUMP_XO_arrive_idle", "stop_salter_loop");
  wait 0.05;

  for(;;) {
    if(distance2d(level.player.origin, self.origin) <= 300.0 || scripts\sp\utility::_id_D1DF(level._id_EA2C getEye(), 0.5, 1)) {
      break;
    }

    wait 0.05;
  }

  var_0 notify("stop_salter_loop");
  scripts\engine\utility::flag_set("cic_started");
  var_0 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_XO_briefing");
  thread _id_0EFB::_id_CD3F("opsmap_salter_react");
}

_id_3074() {
  level endon("ftl_early_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level waittill("playanim_phone_salter");
  var_0 scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_CACE["xo"], "SH_PRI_7_11B_PRE_JUMP_PHONE");
}

_id_2FFB() {
  level endon("ftl_early_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_DO_intro");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
  level waittill("playanim_outro");
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_DO_outro");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
}

_id_301E() {
  level endon("ftl_early_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("gator", "playanim_monitor", "playanim_monitor_pre", "SH_PRI_7_11B_PRE_JUMP_NAV_intro");
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_NAV_intro");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
  level waittill("playanim_outro");
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_NAV_outro");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
  level notify("cic_complete");
}

_id_3021() {
  level endon("ftl_early_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level waittill("playanim_monitor_pre");
  var_0 scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH_PRI_7_11B_PRE_JUMP_MONITOR");
}

_id_2FD6() {
  level endon("ftl_early_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level thread _id_2FCD();
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH_PRI_7_11B_PRE_JUMP_BSN_idle", "stop_boats_loop");
  level waittill("playanim_bsn_response_01");
  var_0 notify("stop_boats_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_BSN_response_01");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH_PRI_7_11B_PRE_JUMP_BSN_idle", "stop_boats_loop");
  level waittill("playanim_bsn_response_02");
  var_0 notify("stop_boats_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_BSN_response_02");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH_PRI_7_11B_PRE_JUMP_BSN_idle", "stop_boats_loop");
}

_id_2FCB() {
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_ivebeeninformed", "vo_sc_prisoner_adm_ivebeeninformed", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_captainlieutena", "speakers", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_wevesufferedunt", "speakers", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_thatsashamehewa", "speakers", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_cantblameyourse", "speakers", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_hindsightsatact", "speakers", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_ivebeeninformed", "speakers", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_atyourbehestthe", "speakers", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_ifallgoesasplan", "speakers", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  scripts\sp\anim::_id_17FC("admiral", "vo_sc_prisoner_adm_colonelpressfie", "speakers_done", "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  thread scripts\sp\anim::_id_1EEA(self, "SH_PRI_7_11B_PRE_JUMP_ADM_idle", "stop_admiral_loop");
  scripts\engine\utility::flag_wait("cic_started");
  self notify("stop_admiral_loop");
  level thread _id_0EF3::_id_FDCE("admiral_cic", 1);
  scripts\sp\anim::_id_1F35(self, "SH_PRI_7_11B_PRE_JUMP_ADM_briefing");
  level thread _id_0EF3::_id_FDCF();
}

_id_2FCD() {
  var_0 = "retribution_bridge_speaker_monitor_cic";
  level waittill("speakers");
  level thread _id_2FEE("sc_prisoner_adm_captainlieutena", level._id_188A, var_0);
  level waittill("speakers");
  level thread _id_2FEE("sc_prisoner_adm_wevesufferedunt", level._id_188A, var_0);
  level waittill("speakers");
  level thread _id_2FEE("sc_prisoner_adm_thatsashamehewa", level._id_188A, var_0);
  level waittill("speakers");
  level thread _id_2FEE("sc_prisoner_adm_cantblameyourse", level._id_188A, var_0);
  level waittill("speakers");
  level thread _id_2FEE("sc_prisoner_adm_hindsightsatact", level._id_188A, var_0);
  level waittill("speakers");
  level thread _id_2FEE("sc_prisoner_adm_ivebeeninformed", level._id_188A, var_0);
  level waittill("speakers");
  level thread _id_2FEE("sc_prisoner_adm_atyourbehestthe", level._id_188A, var_0);
  level waittill("speakers");
  level thread _id_2FEE("sc_prisoner_adm_ifallgoesasplan", level._id_188A, var_0);
  level waittill("speakers_done");
  level thread _id_2FEE("sc_prisoner_adm_colonelpressfie", level._id_188A, var_0);
}

_id_3093() {
  level notify("mainline_selected");
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  level thread _id_0EE4::_id_E381("sc_prisoner_world_cic_briefing", ::_id_304F);
  level thread _id_0EE4::_id_E37A();
  scripts\engine\utility::flag_clear("allow_bridge_ffa_move");
  level._id_EA2C thread _id_3071();
  level._id_5CFC thread _id_2FFB();
  level._id_76FB thread _id_301E();
  level._id_1044B thread _id_2FD6();
  level._id_188A thread _id_2FCB();
  level thread _id_3074();
  level thread _id_3021();
  level thread scripts\sp\interaction_manager::_id_F2A7("busy");
  scripts\engine\utility::flag_wait("salter_at_cic");
  level thread _id_2FE4();
  scripts\engine\utility::flag_wait("cic_started");
  level thread _id_2FE5();
  level waittill("vo_sc_prisoner_adm_ivebeeninformed");
  level notify("shipcrib_play_cic_briefing");
}

_id_2FE4() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_76FB thread scripts\sp\interaction_manager::_id_DB71("sc_prisoner_nav_goodlucksir");
  level._id_5CFC thread scripts\sp\interaction_manager::_id_DB71("sc_prisoner_dpo_didwegetthegree");
  level._id_4451 thread scripts\sp\interaction_manager::_id_DB71("sc_prisoner_cmo_solidconnection");
  scripts\engine\utility::waitframe();
  level._id_5CFC thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
  level._id_76FB thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
  level._id_4451 thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
}

_id_2FE5() {
  level._id_76FB thread scripts\sp\interaction_manager::_id_10FF9();
  level._id_5CFC thread scripts\sp\interaction_manager::_id_10FF9();
  level._id_4451 thread scripts\sp\interaction_manager::_id_10FF9();
}

_id_304F() {
  level waittill("cic_done");
  stopcinematicingame();
  level thread _id_0EEE::_id_FD8B(1);
  level thread _id_3058();
  level waittill("cic_complete");
}

_id_3019() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("salter", "vo_sc_prisoner_slt_amen", "ftl_buildup_start", "pris_ftl_intro");
  var_0 scripts\sp\anim::_id_1EC3(self, "pris_ftl_intro");
  var_0 notify("stop_loop_salter");
  scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_F3DC, scripts\engine\utility::getStruct("bridge_ai_elevator_doors", "targetname").origin);
  level waittill("ftl_Scene_start");
  var_0 scripts\sp\anim::_id_1F35(self, "pris_ftl_intro");
  level notify("salter_exit_bridge");
}

_id_3018() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("gator", "playanim_SH_PRI_7_12_JUMP_XO_intro", "salter_intro_start", "pris_ftl_intro");
  scripts\sp\anim::_id_17FC("gator", "ftl_stop", "ftl_stop_gator", "pris_ftl_intro");
  scripts\sp\anim::_id_17FC("gator", "vo_sc_prisoner_nav_in321", "ftl_3_sec_left", "pris_ftl_intro");
  scripts\sp\anim::_id_17FC("gator", "playanim_monitor", "playanim_monitor_ftl", "pris_ftl_intro");
  scripts\sp\anim::_id_17FC("gator", "playanim_phone", "playanim_phone_gator", "pris_ftl_intro");
  scripts\sp\anim::_id_17FC("gator", "vo_sc_prisoner_nav_awayin321", "gator_vo_pa_line", "pris_ftl_intro");
  thread _id_0EFB::_id_11004();
  thread _id_3023();
  var_0 scripts\sp\anim::_id_1EC3(self, "pris_ftl_intro");
  level waittill("ftl_Scene_start");
  var_0 scripts\sp\anim::_id_1F35(self, "pris_ftl_intro");
  thread _id_0EFB::_id_CD3F("opsmap_gator_react");

  for(;;) {
    if(distance2dsquared(level.player.origin, self.origin) >= squared(150.0)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  thread _id_0EFB::_id_11004();
  scripts\sp\anim::_id_1F35(self, "pris_ftl_post_move_to_conn");
  thread _id_0EFB::_id_CD3F("opsmap_conn_react");
  wait 0.1;
  thread _id_0EE5::_id_202D(undefined, "sc_prisoner_nav_goodlucksir");
}

_id_3023() {
  level waittill("gator_vo_pa_line");
  level.player scripts\sp\utility::play_sound_on_entity("sc_prisoner_nav_awayin321_pa");
}

_id_3022() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 scripts\sp\anim::_id_1EC3(level._id_C6AA["retribution"]._id_BA11["nav"], "SH_PRI_7_12_JUMP_MONITOR_intro");
  level waittill("playanim_monitor_ftl");
  var_0 scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH_PRI_7_12_JUMP_MONITOR_intro");
}

_id_3024() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level waittill("playanim_phone_gator");
  var_0 scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_CACE["nav"], "SH_PRI_7_12_JUMP_PHONE_intro");
}

_id_3017() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("drop_officer", "vo_sc_prisoner_dpo_collisionalarms", "collision_alarms", "pris_ftl_intro");
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1EC3(self, "pris_ftl_intro");
  level waittill("ftl_Scene_start");
  var_0 scripts\sp\anim::_id_1F35(self, "pris_ftl_intro");
  thread _id_0EFB::_id_CD3F("opsmap_drops_react");
  wait 0.1;
  thread _id_0EE5::_id_202D();
}

#using_animtree("player");

_id_D940() {
  var_0 = level._id_C6AA["retribution"];
  var_1 = var_0._id_EF68;
  var_2 = % sh_pri_7_12_jump_plr_intro;
  var_0._id_1339A._id_1FBB = "player_rig";
  scripts\sp\anim::_id_17FC("player_rig", "ftl_Scene_start", "ftl_Scene_start", "SH_PRI_7_12_JUMP_plr_intro");
  level.player playerlinkTo(var_0._id_1339A, "tag_player");
  level.player _meth_823C(var_0._id_1339A, "tag_player", 0.05);
  var_0._id_1339A.origin = getstartorigin(var_1.origin, var_1.angles, var_2);
  var_0._id_1339A.angles = getstartangles(var_1.origin, var_1.angles, var_2);
  var_0._id_1339A clearanim(%opsmap, 0);
  var_0._id_1339A _meth_82E2("single anim", var_2, 1, 0, 0);
  var_0._id_1339A show();
  wait 0.1;
  level notify("ftl_linkto_done");
  level.player playerlinktodelta(var_0._id_1339A, "tag_player", 0, 15, 15, 15, 0, 1);
  level.player _meth_8392(0.2, 2.2, 0.6);
  level notify("player_ftl_ready");
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C658("SH_PRI_7_12_JUMP_plr_keycard");
  var_3 = level._id_C6AA["retribution"]._id_454F["captain"];
  var_3._id_1FBB = "shipcrib_cap_console";
  var_3 thread scripts\sp\anim::_id_1F35(var_3, "SH_PRI_7_12_JUMP_plr_table");
  var_0._id_1339A clearanim(%opsmap, 0);
  var_1 scripts\sp\anim::_id_1F35(var_0._id_1339A, "SH_PRI_7_12_JUMP_plr_intro");
  level.player unlink();
  var_0._id_1339A hide();
}

_id_3058() {
  level thread scripts\sp\utility::_id_12651(["shipcrib_prisoner_halore_tr", "shipcrib_prisoner_ambientmr_tr"]);
  level thread scripts\sp\utility::_id_12643(["shipcrib_prisoner_vr_tr", "shipcrib_prisoner_mezz_tr", "shipcrib_prisoner_hangar_tr", "shipcrib_prisoner_ambient_tr", "shipcrib_prisoner_dropship_tr", "shipcrib_prisoner_ambientml_tr"]);
  level thread scripts\sp\interaction_manager::_id_11037();
  level thread _id_0EE4::_id_E37A();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  level thread _id_0EEE::_id_FD8B(0);
  thread _id_0EEE::_id_25B3();
  level thread _id_4416();
  level thread _id_D940();
  level._id_EA2C thread _id_3019();
  level._id_76FB thread _id_3018();
  level thread _id_3022();
  level thread _id_3024();
  level._id_5CFC thread _id_3017();
  level._id_1044B _id_0EE5::_id_2037("opsmap_boats_react");
  level._id_4451 _id_0EE5::_id_2037("opsmap_comms_react");
  level waittill("ftl_Scene_start");
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(2, _id_0EDE::_id_C683, "ftl", "prisoner");
  level thread scripts\sp\interaction_manager::_id_1100A();
  level thread scripts\sp\interaction_manager::_id_F2A7("busy");
  wait 2.96;
  level thread _id_0EEE::_id_FD89("prisoner", "retribution", ::_id_A611, ::_id_48D7, 7);
  level waittill("collision_alarms");
  level waittill("ftl_stop_gator");
  level notify("ftl_stop");
  level._id_FD6E._id_111D6 = 0.9;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.5);
  setsundirection(anglesToForward((-35, 28, 0)));
  setsuncolorandintensity(1, 0.87, 0.836);
  wait 0.5;
  level thread _id_0EEE::_id_FD8A(1);
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(2, _id_0EDE::_id_C696);
  level.player _meth_8391(1.0);
  level thread scripts\sp\interaction_manager::_id_45A7();
  level thread _id_305E();
}

_id_4416() {
  level._id_1027D = scripts\engine\utility::spawn_script_origin((0, 0, 0), (0, 0, 0));
  level._id_FD6E._id_10288 linkTo(level._id_1027D);

  if(isDefined(level._id_4E8F)) {
    foreach(var_1 in level._id_4E8F)
    var_1 linkTo(level._id_1027D);
  }

  if(isDefined(level._id_118B6))
    level._id_118B6 linkTo(level._id_1027D);

  level._id_1027D rotateTo(level._id_1027D.angles + (2, 35, 2), 15.0, 7.0, 7.0);
}

_id_7480() {
  level endon("cic_complete");
  level waittill("ftl triggered");
  level notify("ftl_early_start");
  wait 1.0;
  level notify("pris_ftl_intro");
}

_id_3063() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_EA2C thread scripts\sp\interaction_manager::_id_DB7B("sc_prisoner_slt_takeusoutraider");
  level._id_76FB thread scripts\sp\interaction_manager::_id_DB7B("sc_prisoner_nav_earthcoordinate");
  level._id_5CFC thread scripts\sp\interaction_manager::_id_DB71("sc_prisoner_dpo_blockisholdingf");
  level._id_4451 thread scripts\sp\interaction_manager::_id_DB71("sc_prisoner_cmo_hqisawaitingour");
  level._id_1044B thread scripts\sp\interaction_manager::_id_DB71("sc_prisoner_sip_goodtogocaptain");
  scripts\engine\utility::waitframe();
  level thread scripts\sp\interaction_manager::_id_E815(30.0);
  level._id_1044B thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
  level._id_5CFC thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
  level._id_4451 thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
}

_id_3064() {
  level._id_76FB thread scripts\sp\interaction_manager::_id_10FF9();
  level._id_EA2C thread scripts\sp\interaction_manager::_id_10FF9();
  level._id_4451 thread scripts\sp\interaction_manager::_id_10FF9();
  level._id_5CFC thread scripts\sp\interaction_manager::_id_10FF9();
  level._id_1044B thread scripts\sp\interaction_manager::_id_10FF9();
  level thread scripts\sp\interaction_manager::_id_11037();
}

_id_305E() {
  wait 0.5;
  level thread _id_0B21::_id_5A43("bridge_exit", "open");
  level waittill("salter_exit_bridge");
  level thread _id_AB12();
}

_id_305B() {
  level._id_EA2C thread scripts\sp\interaction_manager::_id_DB7B("sc_prisoner_slt_thisistheoneive");
  scripts\engine\utility::waitframe();
  level thread scripts\sp\interaction_manager::_id_E815(30.0);
}

_id_305C() {
  level._id_EA2C thread scripts\sp\interaction_manager::_id_10FF9();
  level thread scripts\sp\interaction_manager::_id_11037();
}

_id_A611() {
  level notify("stop_debris");

  foreach(var_1 in level._id_4E8F) {
    if(isDefined(var_1))
      var_1 delete();
  }

  if(isDefined(level._id_118B6)) {
    killfxontag(scripts\engine\utility::getfx("vfx_sc_tigris_debris"), level._id_118B6, "tag_origin");
    scripts\engine\utility::waitframe();
    level._id_118B6 delete();
  }

  visionsetnaked("", 5);
}

_id_48D7() {
  visionsetalternate(5, 0.5);
  scripts\engine\utility::exploder("earth_approach");
}

_id_30B1() {
  var_0 = _id_0EF8::_id_FDFC("spawner_gator", level._id_C6AA["retribution"]._id_10E52["nav"]);
  var_0._id_D6E2 = var_0 _id_0EF1::_id_789F();
  var_0._id_D6E0 = _id_0EE5::_id_202D;

  if(!isDefined(level._id_1044B)) {
    var_0 = _id_0EF8::_id_FDFC("spawner_sotomura", "homebase");
    var_0._id_10C01 = var_0._id_907D;
    var_0._id_D6E2 = var_0 _id_0EF1::_id_789F();
    var_0._id_D6E0 = _id_0EE5::_id_202D;
  } else
    level._id_1044B _id_0B6A::_id_EC0D(var_0._id_907D, 1);

  var_0 = _id_0EF8::_id_FDFC("spawner_comms", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0._id_D6E2 = var_0 _id_0EF1::_id_789F();
  var_0._id_D6E0 = _id_0EE5::_id_202D;
  var_0 = _id_0EF8::_id_FDFC("spawner_drop_officer", level._id_C6AA["retribution"]._id_10E52["drop"]);
  var_0._id_D6E2 = var_0 _id_0EF1::_id_789F();
  var_0._id_D6E0 = _id_0EE5::_id_202D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_ftl1", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_ftl2", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_ftl3", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_tac1", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_tac2", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_tac4", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_tac3", _id_0EFB::_id_EFDB("radiation"));
  var_0 thread _id_10AB::_id_300F();
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys3", _id_0EFB::_id_EFDB("grease"));
  var_0 thread _id_10AB::_id_300D();
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys1", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys2", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  level scripts\engine\utility::delaythread(1.0, _id_0EF0::_id_FDA0);
  level scripts\engine\utility::delaythread(1.0, scripts\sp\interaction_manager::_id_F2A7, "busy");
  scripts\engine\utility::flag_set("bridge_setup");
}

_id_137C8(var_0, var_1, var_2) {
  for(;;) {
    if(distance2d(level.player.origin, var_0.origin) <= var_1) {
      if(isDefined(var_2) && var_2) {
        if(scripts\sp\utility::_id_D1DF(level._id_EA2C.origin, 0.5, 1)) {
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

_id_137C9(var_0) {
  for(;;) {
    if(distance2d(level.player.origin, self.origin) >= var_0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_EB8A(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 0;

  if(!isDefined(var_1))
    var_1 = 0;

  if(isDefined(var_1) && var_1) {
    setsaveddvar("bg_cinematicFullScreen", "0");
    setsaveddvar("bg_cinematicCanPause", "1");
  } else {
    setsaveddvar("bg_cinematicFullScreen", "1");
    setsaveddvar("bg_cinematicCanPause", "0");
    setomnvar("ui_hide_hud", 1);
  }

  if(!var_1 && var_2) {
    level thread scripts\sp\utility::_id_C12D("prisoner_cutscene_start_skip", 4.0);
    level.player scripts\engine\utility::delaycall(0.1, ::enableweapons);
    level thread scripts\sp\utility::_id_CE10(var_0, "prisoner_cutscene_start_skip");
  } else
    cinematicingame(var_0);

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  if(!var_1 && var_2)
    level waittill("skippable_cinematic_done");
  else {
    while(iscinematicplaying())
      scripts\engine\utility::waitframe();

    stopcinematicingame();
    setomnvar("ui_hide_hud", 0);
  }

  scripts\engine\utility::waitframe();
  level notify("sc_bink_done");
}

_id_118B0() {
  level._id_4E8F = [];
  var_0 = scripts\engine\utility::getStructArray("tigris_debris_piece", "script_noteworthy");

  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_modelname)) {
      var_3 = spawn("script_model", var_2.origin);
      var_3 setModel(var_2.script_modelname);
      var_3.angles = scripts\engine\utility::randomvectorrange(0, 360);
      var_3 hide();
      level._id_4E8F = scripts\engine\utility::array_add(level._id_4E8F, var_3);
    }
  }

  scripts\engine\utility::flag_set("tigris_setup");
}

_id_118B1() {
  foreach(var_1 in level._id_4E8F) {
    if(isDefined(var_1)) {
      var_1 show();
      var_1 thread _id_E722();
    }
  }

  level._id_118B6 = scripts\engine\utility::spawn_tag_origin((35099, 2975, 241), (0, -110, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_tigris_debris"), level._id_118B6, "tag_origin");
}

_id_E722() {
  level endon("stop_debris");

  for(;;) {
    var_0 = scripts\engine\utility::randomvectorrange(0, 360);
    self rotateTo(self.angles + var_0, 60.0);
    wait 60.0;
  }
}

_id_2FEE(var_0, var_1, var_2) {
  if(isDefined(var_1))
    var_1 thread scripts\sp\utility::_id_10347(var_0);

  var_3 = getEntArray(var_2, "targetname");

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_4 + 1 == var_3.size) {
      var_3[var_4] scripts\sp\utility::_id_10347(var_0);
      continue;
    }

    var_3[var_4] thread scripts\sp\utility::_id_10347(var_0);
  }
}

_id_495F() {
  level._id_111C3 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level._id_111C3 show();
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_ra_sun_mainsystem_01"), level._id_111C3, "tag_origin");
  level._id_111C3.angles = (95, 60, 0);
  level._id_111C3.origin = level._id_111C3.origin + anglestoup(level._id_111C3.angles) * 300000;
  var_0 = level._id_111C3.origin + anglestoup(level._id_111C3.angles) * -30000;
  scripts\engine\utility::waitframe();
  level._id_111C3 moveTo(var_0, 0.2, 0.0, 0.1);
  level._id_23FD = getEnt("asteroid_rogue", "targetname");
  level._id_23FD castdistantshadows();
  level._id_23FD castshadows();
  level._id_23FD notsolid();
  var_1 = scripts\engine\utility::getStruct("asteroid_sm_dest", "targetname").origin + (0, -15000, 2000);
  level._id_23FD.origin = var_1 + (0, -10000, 0);
  level._id_75FD = scripts\engine\utility::spawn_tag_origin(level._id_23FD.origin);
  level._id_75FD.angles = (0, -30, -90);
  level._id_75FE = scripts\engine\utility::spawn_tag_origin(level._id_23FD.origin);
  level._id_75FE linkTo(level._id_23FD);
  level._id_75FF = scripts\engine\utility::spawn_tag_origin(level._id_23FD.origin);
  level._id_7600 = scripts\engine\utility::spawn_tag_origin(level._id_23FD.origin);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_planet_prisoner_asteroid_main"), level._id_75FD, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_trail"), level._id_75FE, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_follow"), level._id_75FF, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_follow_2"), level._id_7600, "tag_origin");
  wait 0.2;
  level thread _id_E71F();
}

_id_E71F() {
  level endon("stop_starting_sky_rot");
  level._id_1027D = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level._id_111E2 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level._id_FD6E._id_10288 linkTo(level._id_1027D);
  level._id_111C3 linkTo(level._id_111E2);
  childthread _id_BC74();
  level._id_1027D rotateTo(level._id_1027D.angles + (-34, -85, 0), 0.05, 0, 0);
  level._id_111E2 rotateTo(level._id_111E2.angles + (-34, -85, 0), 0.05, 0, 0);
  wait 0.1;
  level._id_111C3 unlink();

  for(;;) {
    level._id_75FD rotateTo(level._id_75FD.angles + (0, 0, 90), 20.0);
    level._id_75FF rotateTo(level._id_75FF.angles + (0, 30, 30), 20.0);
    level._id_7600 rotateTo(level._id_75FF.angles + (0, 10, 10), 22.0);
    level._id_1027D rotateTo(level._id_1027D.angles + (-0.5, -1, 0), 1.0, 0, 0);
    level._id_23FD rotateTo(level._id_23FD.angles + (2, -2, 4), 1.0, 0, 0);
    wait 1.0;
  }
}

_id_BC74() {
  level._id_FD6E._id_111D6 = 2;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
}

_id_A612() {
  level notify("stop_starting_sky_rot");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_sc_ra_sun_mainsystem_01"), level._id_111C3, "tag_origin");
  var_0 = vectortoangles(level._id_111C3.origin - level.player.origin);
  var_1 = getmapsunlight();
  var_2 = (var_1[0], var_1[1], var_1[2]);
  var_3 = 55;
  var_4 = vectorNormalize(var_2) * 1;
  var_5 = vectorNormalize(var_2) * 0.5;
  var_6 = var_0 + (-24, -55, 0);
  lerpsunangles(var_0, var_6, 13.0, 0, 0);
  level._id_75FD delete();
  level._id_75FE delete();
  level._id_75FF delete();
  level._id_7600 delete();
  level._id_23FD delete();
}

_id_AB12() {
  level scripts\engine\utility::delaythread(0.5, _id_0EFB::shipcrib_autosave_now_silent);
  level thread _id_AB0E();
  _id_B10E();
  _id_EAB5();
  scripts\engine\utility::flag_wait("salter_on_leave_elevator");
  level thread _id_AB20();
  _id_0EEB::_id_7976("bridge").trigger waittill("trigger");
  _id_B10C();
  _id_AB0D();
  scripts\engine\utility::flag_wait("salter_on_leave_elevator_ready");
  var_0 = getEnt("prisoner_bridgeelev_player_collision", "targetname");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  thread _id_AB10();
  _id_0EEB::_id_7976("bridge") waittill("move_finished");
  level thread _id_0B21::_id_5A43("mezzanine_elevator", "open");
  thread _id_B10D();
  level thread scripts\sp\utility::_id_12651(["shipcrib_prisoner_bridge_tr", "shipcrib_prisoner_bridgem_tr"]);
  level._id_EA2C unlink();
  level endon("armory_started");
  wait 0.33;
  level._id_EA2C _id_0B6A::_id_EC0B("armory_ai_wait", "shipcrib_stand_stationary_talk_idle_02", undefined, undefined, undefined, undefined, undefined, 1);
  level._id_EA2C _id_0EE5::_id_202D("stand_idle_2_back_reaction", "sc_prisoner_slt_timeforustohead");
}

_id_AB0E() {
  scripts\engine\utility::flag_wait("ambient_bridge_elevator_1f");
  level._id_FD6E._id_111D6 = 0.9;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.5);
  setsundirection(anglesToForward((-35, 28, 0)));
  setsuncolorandintensity(1, 0.87, 0.836);
}

_id_B10E() {
  scripts\engine\utility::flag_init("salter_on_leave_elevator");
  scripts\engine\utility::flag_init("salter_on_leave_elevator_ready");
}

_id_B10C() {
  level notify("player_in_elevator");
  thread _id_2207();
  thread _id_B10F();
}

_id_B10F() {
  level thread _id_0EE6::_id_2201();
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6();
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A6();
}

_id_B10D() {
  if(isDefined(level._id_76FB))
    _id_0EFB::_id_FDBA(level._id_76FB);

  if(isDefined(level._id_5CFC))
    _id_0EFB::_id_FDBA(level._id_5CFC);

  if(isDefined(level._id_1044B))
    _id_0EFB::_id_FDBA(level._id_1044B);
}

_id_EAB5() {
  wait 1.5;
  level._id_EA2C thread _id_0B6A::_id_EC0A("bridge_ai_elevator_doors");
  var_0 = scripts\engine\utility::getStruct("bridge_ai_elevator_doors", "targetname");
  level._id_EA2C _id_1375D(var_0, 150);

  if(distance2d(level.player.origin, var_0.origin) > 300 && level.player _id_9D65(level._id_EA2C)) {
    level._id_EA2C waittill("sceneblock_reach_finished");
    level._id_EA2C scripts\sp\utility::_id_7799(level.player);
    thread _id_EA3E();

    while(distance2d(level.player.origin, level._id_EA2C.origin) > 256 && !level.player _id_9D65(level._id_EA2C))
      scripts\engine\utility::waitframe();

    level._id_EA2C scripts\sp\utility::_id_77B9(0.7);
  }

  scripts\engine\utility::waitframe();
  level._id_EA2C notify("moving_to_elevator");
  level._id_EA2C _id_2BEA("salter_on_leave_elevator", "salter_on_leave_elevator_ready", "shipcrib_stand_idle01_arrival", 1);
  level notify("salter_in_elev");
}

_id_EA3E() {
  level._id_EA2C endon("moving_to_elevator");
  wait 15;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_letsgoseegriffa");
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
}

_id_7ABE() {
  if(!isDefined(self._id_B110)) {
    var_0 = _id_0EEB::_id_7976("bridge") scripts\engine\utility::spawn_tag_origin();
    var_0.angles = var_0.angles + (0, 180, 0);
    var_1 = _id_7B74(var_0, self, "leave_elevator_performance");
    self._id_B110 = var_1;
  }

  return self._id_B110;
}

_id_AB20() {
  level endon("player_in_elevator");
  wait 15.0;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_thisistheoneive");
}

_id_AB0D() {
  if(scripts\engine\utility::flag("salter_on_leave_elevator_ready"))
    _id_0EEB::_id_60F0("bridge", 77);
  else
    _id_0EEB::_id_60F0("bridge", 72);

  if(!level.console)
    waitforalltransients();

  _id_0EEB::_id_60FD("bridge", "Mezzanine");
}

_id_AB10() {
  var_0 = _id_0EEB::_id_7976("bridge") scripts\engine\utility::spawn_tag_origin();
  var_0.angles = var_0.angles + (0, 180, 0);
  var_0 linkTo(_id_0EEB::_id_7976("bridge"));
  level._id_EA2C linkTo(var_0);
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "leave_elevator_performance");
  var_0 delete();
  level._id_EA2C setgoalpos(level._id_EA2C.origin);
}

_id_1375D(var_0, var_1) {
  while(distance2d(self.origin, var_0.origin) > var_1)
    scripts\engine\utility::waitframe();
}

_id_9D65(var_0) {
  var_1 = scripts\sp\utility::_id_7951(var_0.origin, var_0.angles, self.origin);

  if(var_1 < 0)
    return 1;
  else
    return 0;
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

_id_2207() {
  thread _id_D942();
  thread _id_D950();
}

_id_D950() {
  var_0 = _id_10AC::_id_107D9("prisoner_armoryhallway_ai_start2", "welding_medium");
  level waittill("armory_started");
  _id_0EFB::_id_FDBA(var_0);
}

#using_animtree("generic_human");

_id_D942() {
  level._id_A04F = _id_0EF8::_id_FDFC("spawner_mech_jack", "prisoner_jack_start");
  level._id_A04F endon("death");
  level._id_A04F._id_1FBB = "jack";
  thread _id_DB74();
  _id_0E5A::main();
  _id_0E5B::main();
  level._id_A04F _id_0EE5::_id_202D("hallway_jack_blended_react", "Sir.");
  level._id_A04F waittill("interaction_done");
  level._id_EC85["jack"]["jack_idle"][0] = % sh4_2_10b_arm_hall_jack_idle;
  level._id_A04F _id_0EE5::_id_10FC4();
  level._id_A04F scripts\sp\anim::_id_1EEA(level._id_A04F, "jack_idle");
}

_id_DB74() {
  level waittill("armory_started");
  _id_0EFB::_id_FDBA(level._id_A04F);
}

_id_D932() {
  level._id_FD6E._id_111D6 = 0.9;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.5);
  setsundirection(anglesToForward((-35, 28, 0)));
  setsuncolorandintensity(1, 0.87, 0.836);
  level.player _meth_84C7("lastCompletedMission", "rogue");
  level.player _meth_84C7("scPrisonerFirstPlay", 1);
  scripts\sp\utility::_id_11633(getEnt("armory_start_outside", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter", "armory_ai_wait");
  _id_0EE6::_id_2201(["iw7_m4"]);
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6("iw7_m4");
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A6("iw7_m4");
  _id_D946();
}

_id_223D() {
  level thread scripts\sp\utility::_id_12651(["shipcrib_prisoner_bridgee_tr", "shipcrib_prisoner_exterior_tr"]);
  level notify("armory_started");
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  level._id_EA2C thread _id_0EE5::_id_10FC4();
  level thread _id_0A2F::_id_12642();
  level thread _id_0EE4::_id_E389("hangar_claxon");
  level thread _id_0EE4::_id_E389("return_deck_claxon");
  level thread _id_0EE8::_id_F9E5();
  _id_ADB0();
  _id_ADAF();
  thread _id_CC92();
  _id_223C();
}

_id_223C() {
  setsaveddvar("sm_spotdistcull", 400);
  wait 2.5;
  level._id_EA2C _id_0B6A::_id_EC04();
  level._id_EA2C notify("stop_loop");
  level._id_EA2C scripts\sp\interaction::_id_9A0F();
  level._id_EA2C _meth_83A1();
  level._id_EA2C _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(level._id_EA2C);
  level._id_EA2C _id_0EE5::_id_10FC4();
  wait 0.5;
  thread _id_CC98();
  thread _id_DB89();
  level waittill("player_chose_loadout");
  thread rogue_wep_music();
  var_0 = getEnt("armory_terminal_salter_playerclip", "targetname");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  thread _id_CC95();
}

rogue_wep_music() {
  wait 4;
  setmusicstate("mx_390_weppickup");
}

_id_ADAF() {
  _id_0EF8::_id_FDFC("spawner_griff", "armory_officer_reaction_point");
  level._id_8604 scripts\sp\utility::_id_51E1("casual_gun");
  level._id_8604 scripts\sp\utility::_id_86E2();
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 scripts\sp\anim::_id_1EC3(level._id_8604, "armory_intro");
}

_id_ADB0() {
  level thread _id_0EE6::_id_2202();
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A7();
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A7();
  level thread scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_ambient::_id_8A8A();
}

_id_CC92() {
  _id_0B20::_id_AB71(self, "armory_enter", 0.4, undefined, 1, 0.5);
  scripts\engine\utility::waitframe();
  _id_0B20::_id_5A2E("armory", "locked");
}

_id_CC98() {
  thread _id_CDF2();
  thread _id_CD30();
  thread _id_DB87();
}

_id_CDF2() {
  level endon("player_chose_loadout");
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "armory_intro");
  var_0 scripts\sp\anim::_id_1EEA(level._id_EA2C, "armory_idle", "stop_salter_idle");
}

_id_CD30() {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 scripts\sp\anim::_id_1F35(level._id_8604, "armory_intro");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_8604, "armory_idle", "stop_griff_idle");
  _id_2A57();
}

_id_DB87() {
  level endon("at_terminal");
  wait 30;

  if(!scripts\engine\utility::flag("at_terminal"))
    level.player scripts\sp\utility::_id_1034D("sc_prisoner_grf_yourarmamentsar_spkr");
}

_id_DB89() {
  scripts\engine\utility::flag_wait("at_terminal");

  if(!isDefined(level._id_FDFA))
    _id_0EFB::_id_F59B("prisoner");

  _id_0EF7::_id_CD9D();
}

_id_CC95() {
  _id_0B20::_id_5A2E("armory", "locked");
  _id_0B20::_id_5A2E("armory_exit", "unlocked");
  thread _id_CD33();
  thread _id_EA65();
  thread _id_DB63();
}

_id_CD33() {
  level.player scripts\sp\utility::_id_1034D("sc_prisoner_plr_thanksgriffyour");
  wait 2.25;
  level.player thread scripts\sp\utility::_id_1034D("sc_prisoner_grf_staysafedownthe_spkr");
}

_id_EA65() {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 notify("stop_salter_idle");
  level._id_EA2C _id_0EFB::_id_EB8D("prisoner");
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  level._id_EA2C _id_0B6A::_id_EC0D("armory_booth_salter_exit");
  level._id_EA2C _id_0B6A::_id_EC0A("armory_ai_exit");
  level._id_EA2C _id_0EE5::_id_202D(undefined, "sc_prisoner_slt_homesweethome");
}

_id_DB63() {
  level waittill("airboss_door_scene_start");
  level._id_EA2C _id_0EE5::_id_10FC4();

  if(isDefined(level._id_8604._id_110C9))
    level._id_8604._id_110C9 delete();

  _id_0EFB::_id_FDBA(level._id_8604);
}

_id_21F3() {
  level endon("armory_player_near_exit");
  wait 12;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_theyrewaitingf");
  wait 15;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_timeforustohead");
}

_id_21FC() {
  level endon("at_terminal");
  wait 10;
  level._id_8604 _id_0B6A::_id_EC0E("Your armaments are in their usual place when you're ready sir.");
}

_id_2A57() {
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
    if(var_2.size == 0)
      var_2 = var_1;

    thread scripts\sp\anim::_id_1EE7(var_0, "armory_ambient_idle", "stop_armory_ambient_loop");
    var_3 = level._id_8604 scripts\sp\utility::_id_7DC1("armory_ambient_idle")[0];
    wait(getanimlength(var_3) * randomintrange(1, 2));
    self notify("stop_armory_ambient_loop");
    var_4 = var_2[randomintrange(0, var_2.size)];
    var_2 = scripts\engine\utility::array_remove(var_2, var_4);
    scripts\sp\anim::_id_1F2C(var_0, var_4);
  }
}

_id_2185() {
  self endon("death");

  for(;;) {
    self waittill("vig_idle");
    thread _id_0EE4::_id_86E8();
    self waittill("vig_idle");
    thread _id_0EE4::_id_86D3();
  }
}

_id_2250() {
  level._id_8604 _id_0B6A::_id_EC0E("Geneva still has pockets of SetDef soldiers on the ground.");
  level._id_8604 _id_0B6A::_id_EC0E("I'd go with antipersonnel all day on this one.");
}

_id_D931() {
  level.player _meth_84C7("lastCompletedMission", "rogue");
  level.player _meth_84C7("scPrisonerFirstPlay", 1);
  level._id_EFED = "safe";
  setDvar("loadout_chosen", 1);
  setDvar("loadout_shipcrib", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hide_hud", 1);
  _id_D946();
  level thread _id_0A2F::_id_12642();
  scripts\sp\utility::_id_11633(getEnt("airboss_start", "targetname"));
  level._id_EA2C = _id_0EF8::_id_FDFC("spawner_salter", "armory_ai_exit");
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  level._id_EA2C scripts\sp\utility::_id_86E2();
  _id_0EF8::_id_FDFC("spawner_griff", "armory_officer_reaction_point");
  level._id_8604 scripts\sp\utility::_id_86E2();
  _id_2A57();
  level thread _id_DB63();
  level thread _id_0B20::_id_5A2E("armory_exit", "unlocked");
  level thread scripts\sp\maps\shipcrib_prisoner\shipcrib_prisoner_ambient::_id_8A8A();
  _id_48D7();
}

_id_1A82(var_0) {
  self linkTo(var_0);
  var_1 = scripts\engine\utility::getStruct("shipcrib_prisoner_salter_dropship_ramp", "targetname");
  _id_DB7F();
  var_0 thread scripts\sp\anim::_id_1F35(self, "SH_PRI_7_16_DECK_ELEV_XO_enter");
  level waittill("elev_done_moving");
  self unlink();
  self.goalradius = 32;
  scripts\sp\utility::_id_F3DC(var_1.origin);
  wait 1.0;
  level notify("salter_elev_done");
}

_id_DB7F() {
  scripts\sp\anim::_id_17F6("salter", "mayhem_start", ::_id_EA2D, "SH_PRI_7_16_DECK_ELEV_XO_enter");
  scripts\sp\anim::_id_17FC("salter", "mayhem_end", "kloos_mayhem_end", "SH_PRI_7_16_DECK_ELEV_XO_enter");
}

_id_EA2D(var_0) {
  level._id_EA2C detach(level._id_EA2C.headmodel);
  level._id_EA2C _meth_82A2(%mayhem_sh_pri_7_16_deck_elev_xo, 1, 0, 1);
  level waittill("kloos_mayhem_end");
  level._id_EA2C _meth_82A2(%mayhem_sh_pri_7_16_deck_elev_xo, 0, 0, 0);
  level._id_EA2C attach(level._id_EA2C.headmodel);
}

_id_1A74(var_0) {
  level endon("kill_leave_deck_ambient");
  scripts\sp\anim::_id_17FC("gibson", "jump_gate", "jump_gate", "SH_PRI_7_16_DECK_ELEV_AIR_enter");
  self linkTo(var_0);
  var_0 thread scripts\sp\anim::_id_1F35(self, "SH_PRI_7_16_DECK_ELEV_AIR_enter");
  level waittill("elev_done_moving");
  self unlink();
  thread scripts\sp\utility::_id_F3DC(scripts\engine\utility::getStruct("shipcrib_prisoner_gibson_moveto", "targetname").origin);
  wait 5.0;
  _id_0B6A::_id_EC0B("shipcrib_prisoner_gibson_moveto", "shipcrib_stand_stationary_talk_idle_03");
  thread _id_0EE5::_id_202D();
}

_id_1EB5(var_0, var_1) {
  scripts\sp\anim::_id_17FC(self._id_1FBB, "anim_movement = walk", "stop_anim_move", var_1);
  level waittill("stop_anim_move");
  self orientmode("face angle", self.angles[1]);
  self.goalradius = 32;
  var_2 = self.origin + anglesToForward(self.angles) * 200;
  scripts\sp\utility::_id_F3DC(var_2);
  wait 1.0;
  self.goalradius = 32;
  scripts\sp\utility::_id_F3DC(var_0);
  scripts\engine\utility::waitframe();
  self notify("anim_end_goal_done");
}

_id_1A78() {
  level notify("airboss_door_scene_start");
  setsaveddvar("sm_spotdistcull", 550);
  level.player _meth_82C0("shipcrib_prisoner_armory_pre_hangar", 0.0);
  level.player scripts\engine\utility::delaycall(1.6, ::clearclienttriggeraudiozone, 0.75);
  level.player scripts\engine\utility::delaycall(6.7, ::_meth_82C0, "shipcrib_prisoner_platform_ride_down", 3.0);
  level._id_EA2C notify("stop_loop");
  level._id_EA2C scripts\sp\interaction::_id_9A0F();
  level._id_EA2C _meth_83A1();
  level._id_EA2C _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(level._id_EA2C);
  level.player setstance("stand");
  scripts\sp\utility::_id_13C3C();
  level thread scripts\sp\utility::_id_1264E("shipcrib_prisoner_vr_tr");
  level thread scripts\sp\utility::_id_12643(["shipcrib_prisoner_halore_tr"]);
  level.player scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_D090, "ges_safe_door");
  level thread _id_0B20::_id_AB71(self, "prisoner_armory_exit", 0.4);
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 0.05);
  level thread _id_0EE6::_id_2200();
  level thread _id_0EE6::_id_21A9();
  level._id_828C = _id_0EF8::_id_FDFC("spawner_gibson", "hangar_elevator_ai_back");
  level._id_EA29 = _id_0EF8::_id_FDFC("spawner_sahora", "shipcrib_prisoner_airboss_sahora");
  level._id_EA29._id_1FBB = "sahora";
  level._id_EA29 thread scripts\sp\anim::_id_1EEA(level._id_EA29, "shipcrib_salute_reaction_idle_01", "stop_loop");
  var_0 = _id_0EEB::_id_7976("gravity") scripts\engine\utility::spawn_tag_origin();
  var_0 linkTo(_id_0EEB::_id_7976("gravity"));
  level._id_EA2C thread _id_1A82(var_0);
  level._id_828C thread _id_1A74(var_0);
  level thread _id_5E95();
  level._id_EA2C _id_0B20::_id_5A4D("armory_exit", 1);
  level thread _id_0B20::_id_5A2E("armory_exit", "locked");
  _id_0EEB::_id_7976("gravity") scripts\sp\utility::_id_C12D("doors_close", 3.5);
  level._id_FD6E.jackals["jackal_bay_3"] _id_0BDC::_id_A07D();
  level waittill("jump_gate");
  level thread _id_0EEB::_id_60F0("gravity", 30);
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck");
  level thread scripts\sp\utility::_id_C12D("hangar_start_c12", 2);
  level thread scripts\sp\utility::_id_C12D("hangar_scar_peprally_disperse", 14);
  _id_0EEB::_id_7976("gravity") waittill("move_finished");
  level notify("elev_done_moving");
  level.player clearclienttriggeraudiozone(2);
  _id_5E80();
}

_id_5E80() {
  level._id_EA2C thread _id_5E7B();
  level._id_EA2C thread _id_5E7C();
  level._id_6754 thread _id_5DD6();
  level._id_6754 thread _id_5DD7();
  level.player thread _id_5E62();
  level thread _id_5E2F();
  var_0 = getEnt("shipcrib_prisoner_dropship_trigger", "targetname");
  var_0 waittill("trigger");
  scripts\engine\utility::flag_set("player_in_dropship");

  for(;;) {
    if(scripts\engine\utility::flag("player_at_seat")) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  setsundirection(anglesToForward((-35, -85, 0)));
  setsuncolorandintensity(0.88, 0.957, 1);
  level._id_FD6E._id_111D6 = 0.9;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.5);
  setsaveddvar("sm_sundynamics", 1);
  level.player playSound("scn_ship_launch_alarm_lr");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread _id_0BBC::_id_4265(["back"]);
  var_1 = getEntArray("lgt_dropship_character_fills", "script_noteworthy");
  scripts\engine\utility::array_thread(var_1, scripts\sp\lights::_id_AB83, 0, 1.5);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\utility::play_sound_on_tag("scn_ship_launch_bkdoor_close", "j_lowerbackdoor1");
  level thread _id_D851();
  wait 1.0;
  scripts\engine\utility::flag_wait("player_at_seat");
  scripts\engine\utility::flag_wait("dialog_done");
  scripts\engine\utility::flag_wait("dropship_launch_complete");
  scripts\sp\utility::_id_BF98();
  scripts\engine\utility::waitframe();
  level.player _meth_84C7("scPrisonerFirstPlay", 0);
  level._id_EC84 = 0;
  level.player _meth_82C0("fade_to_black_minus_music", 0.3);
  scripts\sp\utility::_id_BF95();
}

_id_5E2F() {
  scripts\engine\utility::flag_wait("player_at_seat");
  cinematicingame("sc_prisoner_hud_dropship_hvt", 1);
  wait 3.0;
  level._id_6754 scripts\sp\utility::_id_10346("sc_prisoner_eth_sirtheyreloadin");
  wait 0.1;
  level.player scripts\sp\utility::_id_1034D("sc_prisoner_plr_patchhimtoourhu");
  wait 0.1;
  level._id_6754 scripts\sp\utility::_id_10346("sc_prisoner_eth_rogerthat");
  level.player scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_1034D, "sc_prisoner_plr_youwatchinthiss");
  level._id_EA2C scripts\engine\utility::delaythread(1.3, scripts\sp\utility::_id_10346, "sc_prisoner_slt_likeahawk");
  wait 1.8;
  scripts\engine\utility::flag_set("dialog_done");
  level thread _id_5E10();
  wait 1.0;
  wait 1.7;
  level.player thread scripts\sp\utility::_id_1034D("sc_prisoner_plr_colonel");
  wait 12.5;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_prisoner_slt_threeminutesill");
  wait 0.1;
  setomnvar("ui_hide_hud", 1);
}

_id_5E10() {
  setomnvar("ui_hide_hud", 0);
  thread scripts\sp\utility::_id_9131("sc_prisoner_hud_dropship_hvt");
  setsaveddvar("scr_dof_enable", "1");
  setsaveddvar("r_dof_hq", "1");
  thread _id_0B0A::_id_583F(0, 0, 0, 10, 40, 20, 1);
  wait 14.0;
  setomnvar("ui_hide_hud", 0);
  thread _id_0B0A::_id_583F(0, 0, 0, 10, 40, 0, 1);
  thread _id_0B0A::_id_583D(1);
  setsaveddvar("r_dof_hq", "0");

  while(iscinematicplaying())
    wait 0.05;

  scripts\engine\utility::flag_set("dropship_launch_complete");
}

_id_5E62() {
  var_0 = scripts\engine\utility::getStruct("shipcrib_prisoner_plr_seat_int", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_1 thread _id_0E46::_id_48C4(undefined, undefined, undefined, 90, 450, 70, 1);
  var_1 waittill("trigger");
  level thread _id_12BCB();
  level notify("player_at_seat");
  var_2 = level._id_D27E;
  var_3 = getweaponmodel(level.player getcurrentprimaryweapon());
  level thread _id_5E6C();
  level.player _meth_823C(level._id_CF5B, "tag_player", 0.5, 0.25, 0.25);
  wait 0.55;
  level.player playerlinktodelta(level._id_CF5B, "tag_player", 0, 45, 45, 45, 45, 1);
  level.player _meth_8392(1.0, 2.2, 0.6);
  level thread _id_110C7(level._id_CF5B, var_3);
  level thread _id_5E8A();
  level._id_CF5B show();
  scripts\engine\utility::flag_set("player_at_seat");
  scripts\engine\utility::flag_set("dropship_scene_start");
  var_2 thread scripts\sp\anim::_id_1F35(level._id_D27E, "SH_PRI_7_19_MISSION_SEAT_PLR_enter");
  var_2 thread scripts\sp\anim::_id_1F35(level.player.helmet, "SH_PRI_7_19_MISSION_HELMET_PLR_enter");
  var_2 scripts\sp\anim::_id_1F35(level._id_CF5B, "SH_PRI_7_19_MISSION_PLR_enter");
  level.player _meth_8573("default_character_shadow");
  level notify("player_rig_exit");
}

_id_5E6C() {
  level.player allowcrouch(0);
  level.player scripts\sp\utility::_id_D090("ges_quick_drop");
  wait 0.25;
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
  level.player disableweaponswitch();
}

_id_5E8A() {
  setomnvar("ui_hide_hud", 0);
  wait 5.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_environmental");
  wait 5.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_boost_engaged");
}

_id_110C7(var_0, var_1) {
  var_2 = spawn("script_model", var_0 gettagorigin("tag_weapon_right"));

  if(isDefined(var_1))
    var_2 setModel(var_1);
  else
    var_2 setModel(getweaponmodel(level.player getcurrentprimaryweapon()));

  var_2 linkTo(var_0, "tag_weapon_right", (0, 0, 0), (0, 0, 0));
  level waittill("player_rig_exit");
  var_2 delete();
}

_id_5E7B() {
  level endon("dropship_scene_start");
  var_0 = scripts\engine\utility::getStruct("shipcrib_prisoner_salter_dropship_ramp", "targetname");
  level waittill("salter_elev_done");
  level._id_5D78 scripts\sp\anim::_id_1F0D(self, "dropship_start_ramp");

  for(;;) {
    if(distance2dsquared(var_0.origin, self.origin) <= 10000) {
      break;
    }

    wait 0.05;
  }

  for(;;) {
    if(distance2dsquared(level.player.origin, self.origin) <= 40000 || scripts\engine\utility::flag("player_in_dropship")) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("salter_entering_ship");
  scripts\engine\utility::delaythread(5.0, scripts\sp\utility::_id_10346, "sc_prisoner_slt_takeyourseatsge");
  self.goalradius = 36;
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  level._id_5D78 scripts\sp\anim::_id_1F35(self, "dropship_start_ramp");
  scripts\sp\anim::_id_1F12(self);
  level._id_5D78 scripts\sp\anim::_id_1F17(self, "SH_PRI_7_19_MISSION_XO_enter");
  scripts\engine\utility::flag_set("salter_in_ship");
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_5D78 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_19_MISSION_XO_enter");
  level thread scripts\sp\utility::_id_9145("fluff_messages_sc_dropship");
  scripts\engine\utility::flag_set("salter_in_seat");
}

_id_5E7C() {
  scripts\engine\utility::flag_wait_any("salter_in_seat", "dropship_scene_start");
  self unlink();
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_5D78 thread scripts\sp\anim::_id_1EEA(self, "sh_rogue_intro_xo_idle", "stop_loop", "tag_origin");
}

_id_5DD6() {
  level endon("dropship_scene_start");

  for(;;) {
    if(distance2d(level.player.origin, level._id_6754.origin) <= 300.0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  thread scripts\sp\utility::_id_10346("sc_prisoner_eth_allreadytosetsa");
  _id_0B6A::_id_EC0A("shipcrib_prisoner_ethan_seat");
  scripts\engine\utility::flag_set("ethen_in_ship");
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);

  for(;;) {
    if(distance2d(level.player.origin, self.origin) <= 100.0) {
      break;
    }

    wait 0.05;
  }

  scripts\sp\utility::_id_10346("sc_prisoner_eth_afteryoucaptain");
}

_id_5DD7() {
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796D("left_cockpit");
  var_0._id_1FBB = "ethan_seat";
  scripts\engine\utility::flag_wait("dropship_scene_start");
  self unlink();
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_5D78 thread scripts\sp\anim::_id_1F35(var_0, "SH_PRI_7_19_MISSION_SEAT_C6I_enter");
  level._id_5D78 scripts\sp\anim::_id_1F35(self, "SH_PRI_7_19_MISSION_C6I_enter");
  level._id_5D78 thread scripts\sp\anim::_id_1EEA(self, "SH_PRI_7_19_MISSION_C6I_idle", "stop_loop");
  _id_0EE5::_id_202D();
}

_id_5E95() {
  level _id_5DA2();
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F458(1);
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F459(1);
  level._id_5D78 = level._id_FD6E._id_5EE3["dropship_bay_2"];
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_106BA(0, 1);
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F37F("right_cockpit");
  level._id_D27E = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796D("right_cockpit");
  level._id_6791 = level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_796D("left_cockpit");
  level._id_D27E._id_1FBB = "seat";
  level._id_6791._id_1FBB = "seat";
  level.player.helmet = _id_0E4B::_id_10730();
  level.player.helmet._id_1FBB = "helmet";
  scripts\engine\utility::waitframe();
  level._id_6791._id_8711 = scripts\sp\utility::_id_10639("dropship_seat_mount01", level._id_6791.origin, level._id_6791.angles);
  level._id_6791._id_8711 scripts\sp\anim::_id_F64A();
  level._id_6791 scripts\sp\anim::_id_1EC3(level._id_6791._id_8711, "SH_PRI_7_19_MISSION_SEAT_MNT_enter");
  scripts\engine\utility::waitframe();
  level._id_6791._id_8711 linkTo(level._id_6791);
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("pack_eth3n_zerog");
  var_0 linkTo(level._id_6791, "tag_jetpack", (0, 0, 0), (0, 0, 0));
  level._id_D27E._id_8711 = scripts\sp\utility::_id_10639("dropship_seat_mount01", level._id_D27E.origin, level._id_D27E.angles);
  level._id_D27E._id_8711 scripts\sp\anim::_id_F64A();
  level._id_D27E scripts\sp\anim::_id_1EC3(level._id_D27E._id_8711, "SH_PRI_7_19_MISSION_SEAT_MNT_enter");
  scripts\engine\utility::waitframe();
  level._id_D27E._id_8711 linkTo(level._id_D27E);
  var_1 = spawn("script_model", (0, 0, 0));
  var_1 setModel("pack_un_jackal_pilots");
  var_1 linkTo(level._id_D27E, "tag_jetpack", (0, 0, 0), (0, 0, 0));
  scripts\engine\utility::waitframe();
  level._id_CF5B = scripts\sp\utility::_id_10639("player_rig", level.player.origin, level.player.angles);
  level._id_CF5B hide();
  level._id_D27E scripts\sp\anim::_id_1EC3(level._id_CF5B, "SH_PRI_7_19_MISSION_PLR_enter");
  level._id_D27E scripts\sp\anim::_id_1EC3(level.player.helmet, "SH_PRI_7_19_MISSION_HELMET_PLR_enter");
  scripts\engine\utility::waitframe();
  level._id_CF5B linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level.player.helmet linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_6754 = _id_0EF8::_id_FDFC("spawner_ethan", "shipcrib_prisoner_ethan_dropship_ramp");
  level._id_6754 scripts\sp\utility::_id_51E1("casual_gun");
  level._id_6754 _id_0EFB::_id_EB8D("prisoner");
}

_id_5DA2() {
  if(isDefined(level._id_FD6E._id_5EE3["dropship_bay_2"])) {
    return;
  }
  _id_0EF9::_id_FE03("dropship", "dropship_bay_2");
  var_0 = scripts\engine\utility::play_loopsound_in_space("shipcrib_dropship_warmup", (1969, -268, -1125));
  var_0 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_1 = scripts\engine\utility::play_loopsound_in_space("emt_dropship_cockpit_radio_lp", (2072, -557, -1083));
  var_1 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F452("loading", "scprisonerload");
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F452("tactical", "scprisonerrunning");
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F452("emergency", "scprisonerrunning");
}

_id_5EA6(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F08B[var_0] = scripts\sp\utility::_id_10639("dropship_seat0" + var_0, level._id_FD6E._id_5EE3["dropship_bay_2"].origin);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1EC3(level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F08B[var_0], "seat_ff");
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F08B[var_0] linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
}

_id_5EA8(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_10639("dropship_seat01", level._id_FD6E._id_5EE3["dropship_bay_2"] gettagorigin(var_0), level._id_FD6E._id_5EE3["dropship_bay_2"] gettagangles(var_0) + (0, var_1, 0));
  var_2 scripts\sp\anim::_id_1EC3(var_2, "static_seat_ff");
  var_2 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
}

_id_5EA7(var_0) {
  var_1 = [];
  var_2 = ["left_cockpit", "right_cockpit"];

  foreach(var_5, var_4 in var_0 _id_0BBF::_id_796E()) {
    if(isDefined(scripts\engine\utility::array_find(var_2, var_5)))
      var_1[var_1.size] = var_4;
  }

  var_6 = 3;
  var_0._id_86D9 = [];

  for(var_7 = 1; var_7 < var_6; var_7++) {
    var_0._id_86D9[var_7] = scripts\sp\utility::_id_10639("dropship_seat_mount0" + var_7, var_0.origin);
    var_0 scripts\sp\anim::_id_1EC3(var_0._id_86D9[var_7], "seat_mount_ff", "tag_origin");
    var_0._id_86D9[var_7] linkTo(var_0, "tag_origin");
  }
}

_id_D851() {
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597A, 10);
  wait 9;
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread _id_0BBF::_id_F458(0);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread _id_0BBF::_id_F459(1);
  level.player playSound("scn_ship_launch_alarm_lr");
  level.player scripts\engine\utility::delaycall(2, ::_meth_82C0, "shipcrib_titan_dropship_fly", 3);
  level.player scripts\engine\utility::delaycall(1.3, ::playsound, "scn_ship_launch_move_01_lr");
  wait 2;
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.3, 0, 0, 0, 14, 14, 14);
  wait 1;
  var_0 = 8;
  level.player playRumbleOnEntity("heavy_2s");
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8244, "subtle_tank_rumble");
  screenshake(level.player.origin, 0.035, 0.035, 0.035, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 5, 5, 5);
  var_1 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_5EE3["dropship_bay_2"] linkTo(var_1);
  var_2 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos2").origin;
  var_1 moveTo(var_2, var_0);
  level.player scripts\engine\utility::delaycall(var_0 - 0.25, ::stoprumble, "subtle_tank_rumble");
  wait(var_0);
  level.player playRumbleOnEntity("heavy_2s");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0, 0, 0, 7, 7, 7);
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 5);
  level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C playSound("scn_ship_launch_door_open");
  level _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C, 5);
  var_0 = 10;
  level.player playRumbleOnEntity("heavy_2s");
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8244, "subtle_tank_rumble");
  screenshake(level.player.origin, 0.035, 0.035, 0.025, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 5, 5, 5);
  level.player playSound("scn_ship_launch_move_02_lr");
  var_2 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos3").origin;
  var_1 moveTo(var_2, var_0);
  level.player scripts\engine\utility::delaycall(var_0 - 0.25, ::stoprumble, "subtle_tank_rumble");
  wait(var_0);
  level.player playRumbleOnEntity("heavy_2s");
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C, 5);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0.35, 0, 0, 10, 10, 10);
  scripts\engine\utility::flag_wait("start_launch");
  level._id_FD6E._id_5EE3["dropship_bay_2"] unlink();
  var_1 delete();
  _id_6F8D();
}

_id_6F8D() {}

_id_D2CF() {
  level endon("stop_speed_control");

  for(;;) {
    if(distance2dsquared(level.player.origin, level._id_FD6E._id_5EE3["dropship_bay_2"].origin) <= squared(1000.0))
      scripts\sp\utility::_id_D2CD(60, 1.0);
    else
      scripts\sp\utility::_id_D2CD(100, 1.0);

    scripts\engine\utility::waitframe();
  }
}

_id_12BCB() {
  level notify("kill_leave_deck_ambient");
  level notify("screens_stop_thinking");
  level._id_FD6E._id_1912["all"] = scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_EA2C);
  level._id_FD6E._id_1912["all"] = scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_6754);
  _id_0EFB::_id_FDBB("c12");
  _id_0EFB::_id_FDE8(level._id_FD6E.jackals);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_11A55);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_209C);
  _id_0EFB::_id_FDCD();
  level scripts\sp\utility::_id_12651(["shipcrib_prisoner_prime_tr", "shipcrib_prisoner_prime_in_tr", "shipcrib_prisoner_mezz_tr", "shipcrib_prisoner_ambient_tr", "shipcrib_prisoner_ambientml_tr", "shipcrib_prisoner_jackal_tr", "shipcrib_prisoner_halore_tr", "shipcrib_prisoner_vr_tr"]);
  wait 0.25;
  scripts\sp\utility::_id_BF97(undefined, undefined, 0);
}

_id_D946() {
  level._id_11940 = getEnt("tinted_glass", "targetname");
  level._id_11941 = getEnt("tinted_glass_capops", "targetname");
  var_0 = getEnt("shipcrib_prisoner_opsmap_hold_frame", "targetname");
  var_0 hide();
  level._id_11940 hide();
  level._id_11941 hide();
  level thread _id_0EF5::_id_FDF6("red_force", 0.01, "flight_control");
  setsaveddvar("sm_spotDistCull", 550);
  _id_0EE4::_id_FDC0();
  level thread _id_0EDE::_id_C66D("retribution");
  level._id_C68F = 1;

  if(!isDefined(level.player _meth_84C6("lastCompletedMission")))
    level.player _meth_84C7("lastCompletedMission", "rogue");

  if(isDefined(level.player _meth_84C6("lastCompletedMission")) && level.player _meth_84C6("lastCompletedMission") == "rogue") {
    level thread _id_0B20::_id_5A52("bridge", ::_id_D935);
    level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3068);

    if(!scripts\engine\utility::flag("tigris_setup"))
      level thread _id_118B0();

    level thread _id_10AB::_id_300C();
    level thread _id_FDDA(1);
  } else {
    if(!scripts\engine\utility::flag("tigris_setup"))
      level thread _id_118B0();

    level thread _id_0B20::_id_5A52("bridge", _id_0EF7::_id_30AD);
    level thread _id_FDDA(0);
  }

  level thread _id_0B20::_id_5A52("armory", ::_id_223D);
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A78);
  level._id_C671 = ::_id_3058;
}

_id_FDDA(var_0) {
  scripts\sp\utility::_id_C264("OBJECTIVE_BRIDGE");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_BRIDGE"), &"SHIPCRIB_OBJECTIVE_BRIDGE");
  scripts\sp\utility::_id_C264("OBJECTIVE_ADMIRAL_UPDATE");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_ADMIRAL_UPDATE"), &"SHIPCRIB_OBJECTIVE_ADMIRAL_UPDATE");
  scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), &"SHIPCRIB_OBJECTIVE_OPS_MAP");
  scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"), &"SHIPCRIB_OBJECTIVE_GO_TO_JACKAL");
  scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"), &"SHIPCRIB_OBJECTIVE_ARMORY");
  scripts\sp\utility::_id_C264("OBJECTIVE_PRISONER");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_PRISONER"), &"SHIPCRIB_OBJECTIVE_PRISONER");

  if(var_0) {
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_BRIDGE"), "current");
    scripts\engine\utility::flag_wait("prisoner_bridge_enter");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_BRIDGE"));
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_ADMIRAL_UPDATE"), "current");
    level waittill("objective_add_opsmap");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_ADMIRAL_UPDATE"));
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), "current");
  } else
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), "current");

  level waittill("opsmap_selection_made");

  if(level._id_FDFA == "prisoner")
    var_0 = 1;
  else
    var_0 = 0;

  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"));

  if(var_0) {
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"), "current");
    scripts\engine\utility::flag_wait("armory_chose_loadout");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"));
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_PRISONER"), "current");
    level waittill("player_at_seat");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_PRISONER"));
  } else {
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"), "current");
    level waittill("shipcrib_jackal_launch_started");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"));
  }
}

_id_11E2(var_0, var_1) {
  self endon("stop_dist_check");
  self endon("death");
  var_2 = undefined;

  for(;;) {
    var_2 = distance2dsquared(self.origin, var_0.origin);

    if(var_2 < squared(var_1)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self notify("distance_reached");
}

_id_11E1(var_0, var_1) {
  self endon("stop_dist_check");
  self endon("death");
  var_2 = undefined;

  for(;;) {
    var_2 = distance2dsquared(self.origin, var_0.origin);

    if(var_2 > squared(var_1)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  self notify("distance_behind");
}

_id_19BC(var_0, var_1) {
  self endon("death");
  self endon("stop_leading");

  if(!isDefined(var_0))
    var_0 = 200.0;

  var_2 = _id_0EFB::_id_7D7A(var_1);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2.origin, var_2.angles);
  var_4 = undefined;

  for(;;) {
    thread scripts\sp\utility::_id_F3D5(var_3);
    thread _id_11E1(level.player, var_0);
    thread _id_11E2(level.player, var_0 * 0.5);
    var_5 = scripts\engine\utility::waittill_any_return("distance_behind", "distance_reached", "near_goal", "goal");

    if(var_5 == "distance_behind") {
      var_6 = self.origin + anglesToForward(self.angles) * 20.0;
      var_7 = rotatepointaroundvector(anglestoup(self.angles), var_6, 180.0);
      var_4 = scripts\engine\utility::spawn_tag_origin(self.origin, var_7);
      thread scripts\sp\utility::_id_F3D5(var_4);
      thread _id_11E2(level.player, 100.0);
      self waittill("distance_reached");
      var_4 delete();
    } else if("distance_reached")
      continue;
    else
      break;

    scripts\engine\utility::waitframe();
  }
}