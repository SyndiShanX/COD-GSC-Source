/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_europa\shipcrib_europa.gsc
***************************************************************/

main() {
  scripts\sp\utility::_id_1263F("shipcrib_europa_jackal_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_dropship_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_prime_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_prime_in_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_bridge_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_exterior_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_jackale_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_hangar_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_halore_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_bridgee_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_mezz_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_vr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_ambient_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_ambientmr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_europa_ambientml_tr");
  _id_0EFB::_id_FDB2("shipcrib_europa");
  _id_0EFB::_id_FD77("shipcrib_europa");
  _id_0EFB::_id_FD73("shipcrib_europa");
  _id_0EFB::_id_FDAE("shipcrib_europa");
  _id_0EFB::_id_FDDC("shipcrib_europa");
  var_0 = scripts\engine\utility::array_combine(level._id_FD6E._id_224C, ["shipcrib_europa_jackal_tr"]);
  var_1 = scripts\engine\utility::array_combine(level._id_FD6E._id_8ACB, ["shipcrib_europa_jackal_tr"]);
  scripts\sp\utility::_id_F343("europa start");
  scripts\sp\utility::_id_1749("bridge", ::_id_30B6, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("armory", ::_id_224A, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("flight deck", ::_id_6F23, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("flight deck lewis", ::_id_6F22, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("jackal land bink", ::_id_A246, "", undefined, level._id_FD6E._id_A248);
  scripts\sp\utility::_id_1749("jackal launch bink", ::_id_A24E, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("europa start dev", ::_id_67C0, "", undefined, ["shipcrib_europa_jackal_tr", "shipcrib_europa_jackale_tr", "shipcrib_europa_prime_in_tr"]);
  scripts\sp\utility::_id_1749("europa start", ::_id_67BF, "", undefined, ["shipcrib_europa_jackal_tr", "shipcrib_europa_jackale_tr", "shipcrib_europa_prime_in_tr"]);
  scripts\sp\utility::_id_1749("europa r_elevator", ::_id_67BA, "", undefined, level._id_FD6E._id_E46F);
  scripts\sp\utility::_id_1749("europa bridge", ::_id_67AB, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("europa bridge select", ::_id_67AD, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("europa bridge ftl", ::_id_67AC, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("europa lv_elevator", ::_id_67B4, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("europa armory", ::_id_67AA, "", undefined, var_0);
  scripts\sp\utility::_id_1749("europa airboss", ::_id_67A9, "", undefined, var_0);
  scripts\sp\utility::_id_1749("europa jackal", ::_id_67B1, "", undefined, var_1);
  scripts\sp\utility::_id_1749("transient: preload cost mainline", ::_id_67AE, "", undefined, ["shipcrib_europa_jackal_tr", "shipcrib_europa_jackale_tr", "shipcrib_europa_prime_in_tr"]);
  scripts\sp\utility::_id_1749("transient: mainline free", ::_id_67AE, "", undefined, ["shipcrib_europa_hangar_tr", "shipcrib_europa_jackal_tr"]);
  scripts\sp\utility::_id_116CB("shipcrib_europa");
  precachemodel("p7_desk_metal_military_03_tablet");
  precachemodel("hero_jackal_helmet_a");
  precachemodel("p7_desk_metal_military_03_tablet_europa");
  precachemodel("equipment_industrial_power_drill_01");
  precachemodel("equipment_push_broom_01");
  precachemodel("misc_scrub_brush");
  precachemodel("equipment_wall_mounted_phone_handset_01");
  precachemodel("veh_mil_air_un_jackal_landed_03b");
  precachemodel("weapon_vr_rifle_wm");
  precachemodel("vr_goggles_hero_xo");
  precachemodel("viewmodel_base_animated_naval");
  precachemodel("equipment_industrial_tool_caddy_01");
  precachemodel("helmet_hero_xo");
  precachemodel("helmet_hero_mco");
  precachemodel("head_hero_engineer_hqss");
  scripts\sp\maps\shipcrib_europa\gen\shipcrib_europa_art::main();
  scripts\sp\maps\shipcrib_europa\shipcrib_europa_fx::main();
  scripts\sp\maps\shipcrib_europa\shipcrib_europa_precache::main();
  scripts\sp\maps\shipcrib_europa\shipcrib_europa_anim::main();
  scripts\sp\maps\shipcrib_europa\shipcrib_europa_lights::main();
  setsaveddvar("spaceshipHackServerToClientDobj", 1);
  _id_0EE4::_id_FDA1();
  level _id_0EE4::_id_FDDB();
  scripts\sp\load::main();
  scripts\engine\utility::flag_init("lower_valet_b_jackal");
  scripts\engine\utility::flag_init("in_vo_conversation");
  scripts\engine\utility::flag_init("kloos_ready_for_exit");
  scripts\engine\utility::flag_init("jackal_valet_ready");
  scripts\engine\utility::flag_init("return_omar_ethan_exit");
  scripts\engine\utility::flag_init("xo_started");
  scripts\engine\utility::flag_init("xo_airboss_started");
  scripts\engine\utility::flag_init("elevator_started");
  scripts\engine\utility::flag_init("xo_on_elevator_talking");
  scripts\engine\utility::flag_init("armory_player_ready");
  scripts\engine\utility::flag_init("hangar_leaving_apc_move");
  setdvarifuninitialized("e3", 0);
  level._id_C67F = _id_0EDE::_id_C67F;
  level._id_67B5 = ::_id_67B8;
  level._id_67BC = ::_id_67BB;
  level._id_E366 = scripts\sp\maps\shipcrib_europa\shipcrib_europa_ambient::_id_1DBF;
  level._id_13567 = "shipcrib_europa_vr_tr_loaded";
  level._id_E3FB = "shipcrib_europa_exterior_tr_loaded";
  level thread _id_0EE4::_id_FDAF();
  level thread _id_0EDC::_id_448B();
  level thread _id_0EDC::_id_BBAC();
  level thread _id_0EF0::_id_FD9F();
  level thread _id_10AC::_id_97A5();
  level thread _id_0EF2::_id_9A41();
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa_fx::_id_CD74("vfx_light_exterior_wall_flightdeck_01", "vfx_light_exterior_wall_flightdeck_01");
  var_2 = getEnt("moon_model", "targetname");
  var_2 delete();
  level._id_FD6E.moon = scripts\engine\utility::spawn_tag_origin((500000, -10000, 5000), (0, 0, 0));
  level._id_FD6E.moon.angles = (0, 0, 15);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_planet_moon_leave"), level._id_FD6E.moon, "tag_origin");
  level.player _meth_84C7("lastShipcribMission", level.script);
  level._id_FD6E._id_111D6 = 2;
}

_id_67AE() {}

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

_id_6F22() {
  var_0 = scripts\engine\utility::spawn_tag_origin((3115, 1120, -1175), (0, 138, 0));
  scripts\sp\utility::_id_11633(var_0);
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  level thread _id_0EEB::_id_60FD("flight", "Flight Deck", 1);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  level thread _id_0EEB::_id_60FD("return", "Flight Deck", 1);
  _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_3", undefined, undefined, 1);
  _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_4", undefined, undefined, 1);
  var_1 = scripts\engine\utility::getStructArray("hangar_hustle_a", "targetname");
  level._id_A04F = _id_0EF8::_id_FDFC("spawner_mech_jack", var_1[0], "cheap");
  level._id_A04F._id_1FBB = "jack";
  wait 1.0;
  var_2 = (level._id_FD6E.jackals["jackal_bay_3"].origin[0], level._id_FD6E.jackals["jackal_bay_3"].origin[1], level._id_A04F.origin[2]);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_2, level._id_FD6E.jackals["jackal_bay_3"].angles);
  var_3 scripts\sp\anim::_id_1EC3(level._id_A04F, "pr_pose_hamilton_01");
  wait 0.05;
  var_4 = spawn("script_model", var_3.origin);
  var_4 setModel("equipment_industrial_tool_caddy_01");
  var_4.origin = var_4.origin + anglesToForward(var_3.angles) * 387.959;
  wait 0.05;
  var_4.origin = var_4.origin + anglestoright(var_3.angles) * 174.566;
  var_4.angles = var_3.angles + (0, -87.49, 0);
}

_id_A246() {}

_id_A24E() {
  scripts\sp\utility::_id_11633(getEnt("jackal_launch_1_start", "targetname"));
}

_id_67BF() {
  level thread _id_67C1();
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa_ambient::_id_1E0B();
  _id_FD84();
  level _id_0EE4::_id_FDD5();
  _id_A80C();
}

_id_67C0() {
  level.player _meth_84C7("lastCompletedMission", "sa_moon");
  _id_67BF();
}

_id_67C1() {
  scripts\sp\utility::_id_13705();
  level thread _id_CD63();
  level scripts\sp\utility::_id_12643(["shipcrib_europa_hangar_tr", "shipcrib_europa_prime_tr", "shipcrib_europa_mezz_tr", "shipcrib_europa_ambient_tr", "shipcrib_europa_ambientmr_tr"]);
  level scripts\sp\utility::_id_12641("shipcrib_europa_dropship_tr");
  scripts\engine\utility::flag_wait("jackal_elevator_finished");
  level thread scripts\sp\utility::_id_12641("shipcrib_europa_halore_tr");
}

_id_67BA() {
  _id_FD84();
  scripts\sp\utility::_id_11633(getEnt("r_elevator_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter", "return_elevator_ai_corner");
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_1 = _id_7B74(var_0, level._id_EA2C, "return_elevator_performance");
  level._id_EA2C _id_0B6A::_id_EC0D(var_1);
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "salter_e3_idle", "stop_loop");
  level._id_EA2C._id_5F99 = var_1;
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa_ambient::_id_1E0B();
  _id_E448();
}

_id_67AB() {
  scripts\sp\utility::_id_11633(getEnt("europa_bridge_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter", "europa_bridgehall_salter_waitbydoor_left");
  _id_FD84();
}

_id_67AD() {
  level._id_EFED = "inside_slow";
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  _id_FD84();
  _id_0EF8::_id_FDFC("spawner_salter");
  _id_30AC();
  _id_0B20::_id_794A("bridge")._id_5A52 = undefined;
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 notify("stop_mac_loop");
  var_0 notify("stop_gator_loop");
  var_0 notify("stop_drop_officer_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "SH3_11_EUR_SH_BR_OPS_XO_idle", "stop_salter_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_B11D, "SH3_11_EUR_SH_BR_OPS_ENG_waiting_idle", "stop_mac_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_76FB, "SH3_11_EUR_SH_BR_OPS_NAV_waiting_idle", "stop_gator_loop");
  level._id_5CFC _id_0B6A::_id_EC0D(_id_0EFB::_id_EFDB("drop"));
  var_1 = getEnt("bridge_opsmap_floor_panel", "targetname");
  var_1 rotateTo((0, 0, 0), 0.05);
  var_2 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player _meth_823B(var_2);
  stopcinematicingame();
  wait 0.5;
  cinematicingame("opsmap_table_transition_full", 1);
  wait 0.5;
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C692();
  level._id_C6AA["retribution"] thread _id_C655(var_0);
}

_id_67AC() {
  level._id_EFED = "inside_slow";
  scripts\sp\utility::_id_11633(getEnt("europa_bridge_start", "targetname"));
  _id_FD84();
  _id_0EF8::_id_FDFC("spawner_salter");
  _id_30AC();
  _id_0B20::_id_794A("bridge")._id_5A52 = undefined;
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 notify("stop_mac_loop");
  var_0 notify("stop_gator_loop");
  var_0 notify("stop_drop_officer_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "SH3_11_EUR_SH_BR_OPS_XO_idle", "stop_salter_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_B11D, "SH3_11_EUR_SH_BR_OPS_ENG_waiting_idle", "stop_mac_loop");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_76FB, "SH3_11_EUR_SH_BR_OPS_NAV_waiting_idle", "stop_gator_loop");
  level._id_5CFC _id_0B6A::_id_EC0D(_id_0EFB::_id_EFDB("drop"));
  var_1 = getEnt("bridge_opsmap_floor_panel", "targetname");
  var_1 rotateTo((0, 0, 0), 0.05);
  _id_3077();
}

_id_67B4() {
  _id_FD84();
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  level thread _id_0B21::_id_5A43("bridge_exit", "open");
  _id_0EF8::_id_FDFC("spawner_salter", "shipcrib_europa_bridge_xo_elevator");
  _id_0EF8::_id_FDFC("spawner_mac", "shipcrib_europa_bridge_engineer_elevator");
  var_0 = _id_0EEB::_id_7976("bridge");
  var_1 = _id_7B74(var_0, level._id_EA2C, "leave_elevator_performance");
  var_2 = _id_7B74(var_0, level._id_B11D, "leave_elevator_performance");
  level._id_EA2C _id_0B6A::_id_EC0D(var_1);
  level._id_B11D _id_0B6A::_id_EC0D(var_2);
  level._id_EA2C linkTo(var_0);
  level._id_B11D linkTo(var_0);
  level thread _id_0B20::_id_5A52("armory", ::_id_223D);
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A73);
  _id_AB12();
}

_id_67AA() {
  scripts\sp\utility::_id_11633(getEnt("europa_armory_start", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter", "shipcrib_europa_armory_xo_start");
  _id_0EF8::_id_FDFC("spawner_mac", "shipcrib_europa_armory_engineer_start");
  _id_FD84();
  level thread _id_0B20::_id_5A52("armory", ::_id_223D);
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A73);
}

_id_67A9() {
  level scripts\engine\utility::delaythread(1, scripts\sp\maps\shipcrib_europa\shipcrib_europa_ambient::_id_40B1);
  scripts\engine\utility::flag_init("armory_exited");
  scripts\sp\utility::_id_11633(getEnt("europa_airboss_start", "targetname"));
  level._id_EFED = "safe";
  _id_0EF8::_id_FDFC("spawner_salter", "shipcrib_europa_armory_xo_exit");
  _id_0EF8::_id_FDFC("spawner_mac", "shipcrib_europa_armory_engineer_exit");
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  level._id_EA2C scripts\sp\utility::_id_86E2();
  level._id_B11D scripts\sp\utility::_id_51E1("casual_gun");
  level._id_B11D scripts\sp\utility::_id_86E2();
  _id_FD84();
  level thread _id_0B20::_id_5A2E("armory_exit", "unlocked");
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A73);
}

_id_67B1() {
  level._id_EFED = "safe";
  _id_FD84();
  level.player._id_E9C4 = level.player scripts\engine\utility::spawn_tag_origin();
  _id_67BB();
}

_id_8AA8() {
  level endon("launch_decompression_done");
  wait 3;
  disablepaspeaker("pa_hangar");
  disablepaspeaker("pa_breakroom");
  disablepaspeaker("pa_bridge");
  wait 1;
  enablepaspeaker("pa_hangar");
  thread _id_5535();

  for(;;) {
    level.player playSound("emt_ship_hangar_pa", "sounddone");
    level.player waittill("sounddone");
    wait(randomfloatrange(6, 10));
  }
}

_id_5535() {
  level waittill("launch_decompression_done");
  disablepaspeaker("pa_hangar");
}

_id_FD84() {
  setsaveddvar("sm_sunsamplesizenear", "0");
  setsaveddvar("sm_spotdistcull", "550");
  _id_0EE4::_id_FDC0();
  scripts\sp\maps\shipcrib_europa\shipcrib_europa_lights::init_lighting();
  level thread _id_0B20::_id_5A52("bridge", ::_id_307C);
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3A28);
  level._id_C671 = ::_id_FD87;
  level thread _id_0EDE::_id_C66D("retribution");
  level._id_C6AA["retribution"] _id_0EDE::_id_C66C();
  level._id_EFED = "inside";
  level thread _id_FD86();
}

_id_FD87() {
  level _id_0EF7::_id_FDE4(level._id_FDFA);
}

_id_48DC() {
  level._id_FD6E._id_67A7 = scripts\engine\utility::spawn_tag_origin((350000, 80000, -150000), (0, 180, 0));
  playFXOnTag(scripts\engine\utility::getfx("vfx_europa_planet"), level._id_FD6E._id_67A7, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_europa_planet_cryovolcanoes"), level._id_FD6E._id_67A7, "tag_origin");
  visionsetalternate(4, 2);
  var_0 = (-30, -5, 0);
  var_1 = vectorNormalize((1, 0.92, 0.86)) * 1.5;
  var_2 = getmapsunangles();
  var_3 = (0, 0, 0);
  level thread scripts\sp\utility::_id_111DA(var_3, var_1, 3);
  lerpsunangles(var_2, var_0, 3);
}

_id_4416(var_0) {
  level scripts\engine\utility::flag_set("skybox_stop_rotating");
  var_1 = level._id_E35D._id_3BB6 scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_111D6 = 0.75;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 30);
  level._id_FD6E._id_10288 linkTo(var_1);
  level._id_FD6E.moon linkTo(var_1);
  var_1 rotateTo((22, 22, 0), 30, 15, 15);
  var_2 = (0, 0, 0);
  var_3 = getmapsunangles();
  var_4 = (9, var_3[1], var_3[2]);
  var_5 = getmapsunlight();
  var_6 = (var_5[0], var_5[1], var_5[2]);
}

_id_FD86() {
  scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), &"SHIPCRIB_OBJECTIVE_OPS_MAP");
  scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"), &"SHIPCRIB_OBJECTIVE_GO_TO_JACKAL");
  level waittill("dismount_ended");
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), "current");
  level waittill("opsmap_selection_made");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"));
  objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"), "current");
  level waittill("shipcrib_europa_launch_started");
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"));
}

_id_67BB() {
  setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated");
  level thread _id_0EEB::_id_60F0("gravity", 666);
  level thread _id_0EEB::_id_60FD("gravity", "Ship Assault");
  wait 1;
  level.player _meth_823B(level.player._id_E9C4);
  level scripts\sp\utility::_id_12651(["shipcrib_europa_vr_tr"]);
  level scripts\sp\utility::_id_12643(["shipcrib_europa_halore_tr", "shipcrib_europa_dropship_tr", "shipcrib_europa_mezz_tr", "shipcrib_europa_ambientml_tr"]);
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa_ambient::_id_8A8B("fast_travel");
  level.player._id_E9C4.origin = _id_0EFB::_id_7D7A("shipcrib_fast_travel_hangar_elevator").origin;
  level.player._id_E9C4.angles = _id_0EFB::_id_7D7A("shipcrib_fast_travel_hangar_elevator").angles;
  scripts\engine\utility::waitframe();
  level thread _id_0EEB::_id_60F0("gravity", 60);
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck");
  wait 1;
  level.player unlink();
  level notify("lgt_E3_jackal");
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa_lights::_id_10A5E();
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa_lights::_id_A24D();
  level thread scripts\sp\hud_util::_id_6A99(2, "black");
  thread _id_0EF7::_id_2602();
  level._id_FD6E.jackals["jackal_bay_3"] scripts\engine\utility::delaythread(3.0, _id_0BDC::_id_A07D);
  setomnvar("ui_hide_hud", 0);
  level scripts\engine\utility::delaythread(3.0, scripts\sp\utility::_id_914C, "fluff_messages_jackal", "fluff_messages_jackal_body", "jackal_intel", level._id_FD6E.jackals["jackal_bay_3"] gettagorigin("j_stepladder1_right"));
  level thread _id_8AA8();
}

_id_A80C() {
  level scripts\engine\utility::delaythread(0.5, _id_0EE1::_id_F2CE);
  level.player endon("death");
  setsaveddvar("spaceshipPilotModel", "viewmodel_base_animated_naval");
  _id_985B();
  _id_985C();
  thread _id_48D0();
  level notify("start_klaxon");
  level.player thread scripts\sp\utility::_id_F526("safe");
  level scripts\engine\utility::delaythread(1.0, _id_0EE1::_id_F2CD);
  level scripts\engine\utility::delaythread(19.0, _id_0EE1::_id_F2CF);
  level thread _id_A817();
  _id_0EE1::_id_E3DA("airlock");
  level scripts\engine\utility::delaythread(22, ::landing_transients);
  level thread _id_0EE1::_id_E3D1("a", "airlock", 9, 11);
  level thread _id_0EE1::_id_E3D1("b", "airlock", 9, 11);
  level.player scripts\engine\utility::delaythread(0.1, scripts\sp\utility::_id_F526, "normal");
  level waittill("jackal_elevator_finished");
  setmusicstate("mx_357f_sc_europa_start");
  level scripts\engine\utility::delaythread(3.0, _id_0EE1::_id_F2D0);
  _id_0EE1::_id_7C10("a")._id_A056 notify("stop_loop");
  _id_0EE1::_id_7C10("b")._id_A056 notify("stop_loop");
  _id_E42B();
}

landing_transients() {
  if(!scripts\engine\utility::flag("shipcrib_europa_hangar_tr_loaded") || !scripts\engine\utility::flag("shipcrib_europa_prime_tr_loaded") || !scripts\engine\utility::flag("shipcrib_europa_mezz_tr_loaded") || !scripts\engine\utility::flag("shipcrib_europa_ambient_tr_loaded") || !scripts\engine\utility::flag("shipcrib_europa_ambientmr_tr_loaded"))
    waitforalltransients();
}

_id_A806() {
  var_0 = scripts\engine\utility::getStruct("jackal_light_intro_struct", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2 = getEntArray("lgt_jackal_land_salter", "script_noteworthy");
  var_3 = _id_0EE1::_id_7C10("b")._id_A056;

  foreach(var_5 in var_2)
  var_5 linkTo(var_1);

  var_1 linkTo(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
}

_id_CD63() {
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame("sc_europa_hud_jackal_return_kotch_hvt");
  setmusicstate("mx_415_kotch_bink");

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  stopcinematicingame();
}

_id_A817() {
  wait 1.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_pressurization_progress");
  wait 5.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_pressurization_complete");
  level waittill("jackal_elevator_finished");
  level thread scripts\sp\utility::_id_9145("fluff_messages_jackal_land");
  wait 2.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_jackal_canopy");
}

_id_985B() {
  _id_0E4B::_id_8E06();
  level.player scripts\sp\utility::_id_F526("normal", 1);
  _id_0EF8::_id_FDFC("spawner_salter");
  _id_0EF8::_id_FDFC("spawner_ethan");
  _id_0EF8::_id_FDFC("spawner_omar");
  level._id_C47F thread _id_0EF8::_id_FE00();
  level._id_EA2C attach("helmet_hero_xo");
  _id_0EF8::_id_FDFC("spawner_gibson", "shipcrib_europa_jackal_airboss_elevator");
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_828C, "enemyairship_idle", "stop_gibson_loop");
  level._id_A6F4 = _id_0EF8::_id_FDFC("spawner_kloos", "shipcrib_europa_valetA_start");
  level._id_A6F4.team = "neutral";
  level._id_A6F4 scripts\engine\utility::delaythread(4, scripts\sp\utility::_id_7226, scripts\engine\utility::getStruct("shipcrib_europa_valetA_wait", "targetname"));
}

_id_985C() {
  var_0 = _id_0EF9::_id_FE03("jackal", "crane_a");
  _id_0EE1::_id_E3D9(var_0, "a", 1, "dismount_shipcrib_moon");
  var_0 = _id_0EF9::_id_FE03("jackal", "crane_b");
  _id_0EE1::_id_E3D9(var_0, "b");
  _id_0BDC::_id_A110(1);
  level._id_C47F linkTo(_id_0EE1::_id_7C10("b")._id_A056);
  level._id_EA2C linkTo(_id_0EE1::_id_7C10("b")._id_A056);
  level._id_6754 linkTo(_id_0EE1::_id_7C10("a")._id_A056);
  _id_0EE1::_id_7C10("a")._id_A056 thread scripts\sp\anim::_id_1ECC(level._id_6754, "jackal_copilot_idle", "stop_loop");
  _id_0EE1::_id_7C10("b")._id_A056 thread scripts\sp\anim::_id_1ECC(level._id_EA2C, "jackal_pilot_idle", "stop_loop");
  _id_0EE1::_id_7C10("b")._id_A056 thread scripts\sp\anim::_id_1ECC(level._id_C47F, "jackal_copilot_idle", "stop_loop");
  thread _id_A806();
}

_id_A824() {
  var_0 = _id_0EE1::_id_7C10("b")._id_A056;
  level._id_6754 scripts\sp\pip_util::_id_6A67();
  level._id_6754 scripts\sp\narrative::_id_194A("sc_europa_eth_datatransfer");
  level.player scripts\sp\utility::_id_1034D("sc_europa_plr_exeptionalwork");
  level._id_EA2C scripts\sp\pip_util::_id_6A67();
  var_0 thread scripts\sp\anim::_id_1F35(level._id_EA2C, "jackal_pip");
  var_0 scripts\sp\anim::_id_1F35(level._id_C47F, "jackal_pip");
  scripts\sp\pip_util::_id_CBA3();
}

_id_CD5E(var_0) {
  scripts\sp\pip_util::_id_6A67();
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_pip");
}

_id_48D0() {
  level waittill("dismount_shipcrib_moon");
  _id_A35C();
  level notify("dismount_shipcrib_moon_complete");
}

#using_animtree("jackal");

_id_A35C() {
  scripts\engine\utility::flag_init("dismount_started");
  scripts\engine\utility::flag_init("dismount_ended");
  var_0 = _id_0EE1::_id_7C10("a")._id_A056;
  var_1 = % sh3_1b_eur_tablet_plr_intro;
  var_2 = % sh3_1b_eur_tablet_jackal_intro;
  var_0 _id_0EE4::_id_F93C(var_1, var_2, 1);
  level waittill("jackal_elevator_finished");
  scripts\engine\utility::flag_set("dismount_started");
  level._id_EA2C detach("helmet_hero_xo");
  level._id_C47F thread _id_0EF8::_id_FDFF();
  thread _id_567F();
  thread _id_75C3(18.5);
  var_0 _id_0EE4::_id_68D1(var_1, var_2);
  level.player scripts\sp\utility::_id_F526("safe");

  if(isDefined(level.player.helmet))
    level.player.helmet delete();

  var_0 _id_0BDB::_id_A0F9();
  var_0 scripts\engine\utility::delaycall(0.75, ::clearanim, %sh3_1b_eur_tablet_jackal_intro, 0.0);
  var_0 scripts\engine\utility::delaycall(0.75, ::setanimknob, %jackal_vehicle_landed_state_idle, 1.0, 0.0);
  scripts\engine\utility::flag_set("dismount_ended");
  waitforalltransients();
  scripts\engine\utility::noself_delaycall(0.5, ::waitfortransient, "shipcrib_europa_halore_tr");
}

#using_animtree("script_model");

_id_A29A() {
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_1 = _id_0EE1::_id_7C10("a")._id_A056;
  var_2 = var_1 gettagangles("tag_player");
  var_3 = var_1 gettagorigin("tag_player");
  var_4 = getstartorigin(var_3, var_2, %sh3_1b_eur_tablet_test_intro);
  var_5 = getstartorigin(var_0.origin, var_0.angles, %sh3_1b_eur_tablet_tablet_intro);
}

_id_5651() {
  scripts\engine\utility::flag_set("in_vo_conversation");
  level._id_C47F scripts\sp\narrative::_id_194A("sc_europa_usf_afteractionreport", scripts\sp\narrative::_id_195C, level.player);
  wait 1;
  level.player scripts\sp\utility::_id_1034D("sc_europa_plr_accompanysgt");
  level._id_6754 scripts\sp\utility::_id_10346("sc_europa_eth_yessir");
  level._id_C47F scripts\sp\narrative::_id_194A("sc_europa_usf_gotitwellathand", scripts\sp\narrative::_id_195C, level.player);
  level.player notify("start_tablet_handoff");
  level.player scripts\sp\utility::_id_1034D("sc_europa_plr_nodoubtyoudo");
  wait 1.5;
  level.player scripts\sp\utility::_id_1034D("sc_europa_plr_gotyourorders");
  scripts\engine\utility::flag_clear("in_vo_conversation");
}

_id_567F() {
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_0 thread _id_5697();
  var_0 thread _id_569E();
  var_0 thread _id_5687();
  var_0 thread _id_5692();
  var_0 thread _id_56A1();
  var_0 thread _id_568C();
  level thread _id_56A5();
}

_id_5697() {
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  level._id_C47F unlink();
  var_0 scripts\sp\anim::_id_1F35(level._id_C47F, "jackal_dismount");
  _id_0EFB::_id_FDBA(level._id_C47F);
}

_id_5687() {
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  level._id_6754 unlink();
  var_0 scripts\sp\anim::_id_1F35(level._id_6754, "jackal_dismount");
  level._id_6754 scripts\sp\utility::_id_7799(level._id_C47F);
  level._id_6754 thread _id_AB77(1.5, 3);
  level._id_6754 _id_0B6A::_id_EC0A("europa_ethan_doorend");
  _id_0EFB::_id_FDBA(level._id_6754);
}

_id_569E() {
  scripts\engine\utility::flag_init("salter_returndeck_ready");
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  wait 2;
  var_0 scripts\sp\anim::_id_1EC7(level._id_EA2C, "jackal_exit");
  level._id_EA2C unlink();
  level._id_EA2C _id_0B6A::_id_EC0B("shipcrib_europa_jackal_salter_wait", "shipcrib_stand_stationary_talk_idle_03");
  scripts\engine\utility::flag_set("jackal_valet_ready");
  level._id_EA2C scripts\sp\utility::_id_7799(level.player);
  scripts\engine\utility::flag_wait("dismount_ended");
  level._id_EA2C _id_0B6A::_id_EC04();
  level._id_EA2C scripts\sp\anim::_id_1EC7(level._id_EA2C, "shipcrib_stand_idle03_exit");
  scripts\engine\utility::flag_set("salter_returndeck_ready");

  if(!scripts\engine\utility::flag("europa_walking_onto_returndeck"))
    return;
}

_id_5692() {
  _id_DB76();
  scripts\sp\anim::_id_1F35(level._id_A6F4, "jackal_dismount");
  var_0 = _id_0EE1::_id_7C10("a");
  level._id_A6F4 linkTo(var_0);
  var_1 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_1 linkTo(var_0);
  var_1 thread scripts\sp\anim::_id_1EEA(level._id_A6F4, "jackal_dismount_idle");
}

_id_DB76() {
  scripts\sp\anim::_id_17F6("kloos", "mayhem_start", ::_id_5693, "jackal_dismount_idle");
  scripts\sp\anim::_id_17FC("kloos", "mayhem_end", "kloos_mayhem_end", "jackal_dismount_idle");
}

#using_animtree("generic_human");

_id_5693(var_0) {
  level._id_A6F4 detach(level._id_A6F4.headmodel);
  level._id_A6F4 _meth_82A2(%mayhem_sh3_1b_eur_tablet_klo, 1, 0, 1);
  level waittill("kloos_mayhem_end");
  level._id_A6F4 _meth_82A2(%mayhem_sh3_1b_eur_tablet_klo, 0, 0, 0);
  level._id_A6F4 attach(level._id_A6F4.headmodel);
}

#using_animtree("script_model");

_id_56A1() {
  var_0 = getEnt("return_tablet", "targetname");
  var_0 _meth_83D0(#animtree);
  var_0._id_1FBB = "jackal_tablet";
  var_1 = getEnt("tablet_bink", "targetname");
  var_1 linkTo(var_0);
  level thread _id_56A2();
  scripts\engine\utility::waitframe();
  level thread scripts\sp\utility::_id_C12D("valet_b_start", 12);
  scripts\sp\anim::_id_1F35(var_0, "jackal_dismount");
  var_2 = _id_0EE1::_id_7C10("a");
  var_0 linkTo(var_2);
  var_3 = scripts\engine\utility::spawn_tag_origin(self.origin, self.angles);
  var_3 linkTo(var_2);
  var_3 thread scripts\sp\anim::_id_1EEA(var_0, "jackal_dismount_idle");
  level._id_A6F4._id_113CA = var_0;
}

_id_56A2() {
  wait 7;
  stopcinematicingame();
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "0");
  cinematicingame("sc_europa_world_jackal_tablet", 1);
  wait 2.75;
  pausecinematicingame(0);
}

_id_56A5() {
  level waittill("valet_b_start");
  var_0 = _id_0EE1::_id_7C10("b");
  level._id_1312A = _id_0EF8::_id_FE01("spawner_valet_b", "shipcrib_europa_valetB_start", "cheap");
  level._id_1312A.team = "neutral";
  level._id_1312A._id_1FBB = "valet_b";
  level._id_1312A _id_0EE4::_id_CE73(var_0, "entrance", "lower_valet_b_jackal");
}

_id_568C() {
  wait 12.5;

  if(isDefined(level.player.helmet))
    level.player.helmet delete();
}

_id_AB77(var_0, var_1) {
  self endon("death");
  var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
  var_3 = var_1 * 20;
  var_4 = (var_0 - var_2) / var_3;

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_2 = scripts\asm\asm::asm_getmoveplaybackrate();
    scripts\asm\asm::_id_237B(var_2 + var_4);
    scripts\engine\utility::waitframe();
  }

  scripts\asm\asm::_id_237B(var_0);
}

_id_E42B() {
  level waittill("dismount_shipcrib_moon_complete");
  _id_FA26();
  _id_F957();
  thread _id_B0D8();
  level.player clearclienttriggeraudiozone(1);
  level notify("kill_return_klaxon");
  scripts\engine\utility::flag_wait("europa_walking_onto_returndeck");
  scripts\engine\utility::flag_set("kloos_ready_for_exit");
  thread _id_BC66();
  thread _id_CDF5();
  scripts\engine\utility::flag_wait("airboss_move_to_elevator");
  thread _id_F220();
  scripts\engine\utility::flag_wait("salter_convo_complete");
  thread _id_CCFC();
  scripts\engine\utility::flag_wait("salter_on_r_elevator");
  thread _id_DB82();
  _id_E448();
}

_id_F957() {
  level thread _id_0B21::_id_5A43("deck_return_elevator", "locked");
  level thread _id_0EEB::_id_60FD("return", "Moon Stop", 1);
  var_0 = _id_0EEB::_id_7976("return");
  var_0 setanimknob(var_0.anims["4_raise"], 1);
  var_0 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_0.anims["4_raise"], 1);
}

_id_F220() {
  level thread _id_0EEB::_id_60F0("return", 84);
  level thread _id_0EEB::_id_60FD("return", "Flight Deck");
  _id_0EEB::_id_7976("return") waittill("move_finished");
  _id_0EEB::_id_7976("return") notify("doors_open");
  level _id_0B21::_id_5A43("deck_return_elevator", "open");
}

_id_FA26() {
  scripts\engine\utility::flag_init("gibson_convo_complete");
  scripts\engine\utility::flag_init("salter_convo_complete");
  scripts\engine\utility::flag_init("salter_on_r_elevator");
}

_id_BC66() {
  scripts\engine\utility::flag_init("salter_waiting_outside_elevator");
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_1 = _id_7B74(var_0, level._id_EA2C, "enemyairship_scene");
  scripts\engine\utility::flag_wait("salter_returndeck_ready");
  level._id_EA2C scripts\sp\utility::_id_77B9(0.5);
  level._id_EA2C scripts\engine\utility::delaythread(2.5, scripts\sp\utility::_id_13861, "on", level.player, "left");
  level._id_EA2C _meth_8250(1);
  var_1 scripts\sp\anim::_id_1ED0(level._id_EA2C, "shipcrib_stand_idle01_arrival", undefined, "Exposed");
  var_1 scripts\sp\anim::_id_1EC7(level._id_EA2C, "shipcrib_stand_idle01_arrival");
  var_1 thread scripts\sp\anim::_id_1ECC(level._id_EA2C, "shipcrib_stand_stationary_talk_idle_01", "stop_salter_idle");
  scripts\engine\utility::flag_set("salter_waiting_outside_elevator");
  scripts\engine\utility::flag_wait("salter_on_r_elevator");
  var_1 notify("stop_salter_idle");
  var_1 delete();
}

_id_CDF5() {
  level._id_EA2C scripts\sp\utility::_id_10346("sc_europa_slt_forcedfacetime");
  level._id_EA2C scripts\engine\utility::delaythread(1.25, scripts\sp\utility::_id_13861, "off", level.player, "left");
  level.player scripts\sp\utility::_id_1034D("sc_europa_plr_moneysonomar");
  level._id_EA2C scripts\sp\utility::_id_10346("sc_europa_slt_illtakeethan");
  scripts\engine\utility::flag_set("salter_convo_complete");
}

_id_CCFC() {
  wait 0.5;
  scripts\sp\anim::_id_17F6("gibson", "playanim_SH3_6_2_EUR_GIBSON_XO_scene", ::_id_CDF6, "enemyairship_scene");
  _id_CD29();
  scripts\engine\utility::flag_set("gibson_convo_complete");
}

_id_CD29() {
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_0 notify("stop_gibson_loop");
  level._id_EA2C scripts\sp\utility::_id_7799(level._id_828C);
  var_0 scripts\sp\anim::_id_1F35(level._id_828C, "enemyairship_scene");
  level._id_828C _id_0EE5::_id_202D(4);
  scripts\engine\utility::flag_wait("elevator_started");
  level._id_828C _id_0EE5::_id_10FC4();
  var_0 scripts\sp\anim::_id_1F35(level._id_828C, "enemyairship_exit");
}

_id_CDF6(var_0) {
  level._id_EA2C scripts\sp\utility::_id_77B9(0.5);
  var_1 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");

  if(scripts\engine\utility::flag("salter_waiting_outside_elevator")) {
    level._id_EA2C thread _id_0B6A::_id_EC04();
    var_1 scripts\sp\anim::_id_1F35(level._id_EA2C, "enemyairship_scene");
  } else {
    thread _id_EABC();
    wait 0.5;
    level._id_EA2C thread scripts\sp\utility::_id_10346("sc_europa_slt_takeitasahellyes");
    var_2 = _id_7B74(var_1, level._id_EA2C, "return_elevator_performance");
    level._id_EA2C _id_0B6A::_id_EC0B(var_2, "shipcrib_stand_stationary_talk_idle_03", "idle01", undefined, undefined, undefined, undefined, 1);
    var_2 delete();
  }

  level._id_EA2C _id_0EE5::_id_202D(3);
  scripts\engine\utility::flag_set("salter_on_r_elevator");
}

_id_EABC() {
  level._id_EA2C scripts\sp\utility::_id_7799(level._id_828C, 2, 0.75);

  while(!level._id_828C _id_9D65(level._id_EA2C))
    scripts\engine\utility::waitframe();

  level._id_EA2C scripts\sp\utility::_id_77B9(0.5);
}

_id_9D65(var_0) {
  var_1 = scripts\sp\utility::_id_7951(var_0.origin, var_0.angles, self.origin);

  if(var_1 < 0)
    return 1;
  else
    return 0;
}

_id_CD28() {
  level._id_828C _id_0EE5::_id_202D(4);
  level._id_828C scripts\sp\interaction_manager::_id_11009();
  level scripts\engine\utility::flag_wait("gibson_convo_complete");
  level._id_828C scripts\sp\interaction_manager::_id_45A6();
  scripts\engine\utility::flag_wait("elevator_started");
  level._id_828C _id_0EE5::_id_10FC4();
}

_id_CD2A() {
  var_0 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_828C, "elevator_departure");
}

_id_13617() {
  var_0 = undefined;

  if(scripts\engine\utility::flag("in_vo_conversation"))
    var_0 = 1;

  scripts\engine\utility::flag_waitopen("in_vo_conversation");

  if(isDefined(var_0))
    wait 0.4;
}

_id_DB82() {}

_id_BCBB() {}

_id_C3D5() {}

_id_C3D3() {}

_id_B0D9() {
  thread _id_B0D9();
  wait 1.5;
  level._id_A6F4 scripts\sp\utility::_id_10346("sc_europa_kls_coastguardbirdc");
}

_id_B0D8() {
  _id_0EE4::_id_984E();
  var_0 = _id_0EE1::_id_7C10("a");
  thread _id_0EE4::_id_DC44("jackal_bridge_02");
  scripts\engine\utility::flag_set("lower_valet_b_jackal");
  scripts\engine\utility::flag_wait("landing_on_returndeck");
  thread _id_0EE4::_id_DC44("jackal_bridge_01");
  var_0 _id_0EE4::_id_B0D6();
}

_id_E448(var_0) {
  setsaveddvar("r_spotlightEntityShadows", "1");
  _id_0EEB::_id_7976("return").trigger waittill("trigger");
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  scripts\engine\utility::flag_set("elevator_started");
  _id_0EEB::_id_7976("return") notify("doors_close");

  if(!isDefined(var_0)) {
    level thread _id_0EEB::_id_60F0("return", 90);
    level thread _id_0EEB::_id_60FD("return", "Bridge Level");
  }

  var_1 = getEnt("europa_return_player_collision", "targetname");
  var_1 scripts\engine\utility::delaycall(1, ::delete);
  level thread _id_E441();
  level thread _id_F9E9();
  _id_0EEB::_id_7976("return") waittill("move_finished");
  level thread _id_0EF7::_id_E465();
  level thread _id_7573();
  thread _id_0B21::_id_5A43("return_elevator", "open");
  _id_302F();
}

_id_E441() {
  level endon("entering_bridge_scene");
  var_0 = _id_0EEB::_id_7976("return");
  var_1 = scripts\engine\utility::getStruct("return_deck_jackal_walkway_center", "targetname");
  var_2 = scripts\engine\utility::spawn_tag_origin(var_1.origin, var_1.angles);
  var_2 linkTo(var_0);
  level._id_EA2C linkTo(var_0);
  level._id_EA2C _id_0EE5::_id_10FC4();

  if(isDefined(level._id_EA2C._id_5F99)) {
    level._id_EA2C._id_5F99 notify("stop_loop");
    level._id_EA2C._id_5F99 delete();
  }

  level._id_EA2C _id_DB85("return_elevator_performance");
  level._id_EA2C scripts\sp\anim::_id_17F6(level._id_EA2C._id_1FBB, "play_xo_face", ::_id_CDF8, "return_elevator_performance");
  level._id_EA2C scripts\sp\anim::_id_17F6(level._id_EA2C._id_1FBB, "anim_movement = walk", ::_id_12BB1, "return_elevator_performance");
  var_2 scripts\sp\anim::_id_1F35(level._id_EA2C, "return_elevator_performance");
  level._id_EA2C waittill("smooth_anim_exit_complete");
  scripts\engine\utility::flag_set("salter_exited_elevator");
}

_id_CDF8(var_0) {
  level._id_EA2C scripts\sp\utility::_id_10346("shipcrib_slt_illpassnonewsis");
}

_id_CDDF() {}

_id_12BB1(var_0) {
  level._id_EA2C unlink();
}

_id_DB85(var_0) {
  scripts\sp\anim::_id_17F6(self._id_1FBB, "anim_movement = walk", ::_id_CE1C, var_0);
}

_id_CE1C(var_0) {
  if(self == level._id_EA2C)
    level endon("entering_bridge_scene");

  var_0 orientmode("face angle", var_0.angles[1]);
  var_0.goalradius = 16;
  var_1 = var_0.origin + anglesToForward(var_0.angles) * 200;
  var_0 scripts\sp\utility::_id_F3DC(var_1);
  wait 1.75;
  var_0 notify("smooth_anim_exit_complete");
}

_id_F9E9() {
  level._id_BF2A = _id_0EF8::_id_FE01("spawner_mech_jack", "newsguy1");
  level._id_BF2B = _id_0EF8::_id_FDFC("spawner_marine_casual", "newsguy2");
  level._id_BF2A._id_1FBB = "newsguy1";
  level._id_BF2B._id_1FBB = "newsguy2";
}

_id_40B0() {
  if(isDefined(level._id_A6F4) && isDefined(level._id_A6F4._id_113CA))
    level._id_A6F4._id_113CA delete();

  _id_0EFB::_id_FDBA(level._id_828C);
  _id_0EFB::_id_FDBA(level._id_A6F4);

  if(isDefined(level._id_1312A)) {
    if(isDefined(level._id_1312A._id_A071))
      level._id_1312A._id_A071 delete();
  }

  _id_0EFB::_id_FDBA(level._id_1312A);
}

_id_302F() {
  level endon("entering_bridge_scene");
  _id_9845();
  thread _id_CDAD();
  scripts\engine\utility::flag_wait("salter_exited_elevator");
  _id_EAC7();
}

_id_9845() {
  scripts\engine\utility::flag_init("news_ensign_complete");
  scripts\engine\utility::flag_init("salter_exited_elevator");
  scripts\engine\utility::flag_init("newsguys_complete");
}

_id_CDAD() {
  thread _id_CDAB();
  thread _id_CDAC();
}

_id_CDAB() {
  var_0 = scripts\engine\utility::getStruct("broadcast_speaker", "targetname");
  var_1 = scripts\engine\utility::getStruct("newsguy1", "targetname");
  level._id_BF2A _id_DB85("newsguy_performance");
  var_1 thread scripts\sp\anim::_id_1F35(level._id_BF2A, "newsguy_performance");
  level._id_BF2A waittill("smooth_anim_exit_complete");
  level._id_BF2A thread _id_0B6A::_id_EC0A("newsguy1_end");
  var_2 = scripts\engine\utility::getStruct("newsguy1_end", "targetname");

  while(distance2d(level._id_BF2A.origin, var_2.origin) > 300)
    scripts\engine\utility::waitframe();

  level._id_BF2A scripts\sp\utility::_id_7799(var_0);
  level._id_BF2A waittill("sceneblock_reach_finished");
  var_2 scripts\sp\anim::_id_1F35(level._id_BF2A, "newsguy_idle_arrival");
  var_2 scripts\sp\anim::_id_1EEA(level._id_BF2A, "newsguy_idle");
  level waittill("broadcast_cinematic_complete");
  level._id_BF2A _id_0EE5::_id_202D();
}

_id_13C7(var_0, var_1) {
  scripts\sp\anim::_id_17FC(self._id_1FBB, "anim_movement = walk", "stop_anim", var_1);
  level waittill("stop_anim");
  self orientmode("face angle", self.angles[1]);
  self.goalradius = 32;
  var_2 = self.origin + anglesToForward(self.angles) * 200;
  scripts\sp\utility::_id_F3DC(var_2);
  wait 2.0;
  self.goalradius = 32;
  scripts\sp\utility::_id_F3DC(var_0);
}

_id_CDAC() {
  setmusicstate("");
  var_0 = scripts\engine\utility::getStruct("broadcast_speaker", "targetname");
  var_1 = scripts\engine\utility::getStruct("newsguy2", "targetname");
  var_1 scripts\sp\anim::_id_1F35(level._id_BF2B, "newsguy_performance");
  level._id_BF2B _id_0B6A::_id_EC0B("newsguy2_end", "shipcrib_stand_stationary_talk_idle_05");
  level._id_BF2B scripts\sp\utility::_id_7799(var_0);
  level waittill("broadcast_cinematic_complete");
  level._id_BF2B _id_0EE5::_id_202D(5);
}

_id_CDFA(var_0) {
  level._id_EA2C scripts\sp\utility::_id_7799(var_0);
  wait 3;
  level._id_EA2C thread scripts\sp\utility::_id_7799(level.player);
  level._id_EA2C scripts\sp\utility::_id_10346("sc_europa_slt_newsisbullshit");
  level._id_EA2C scripts\sp\utility::_id_77B9(0.33);
  scripts\engine\utility::flag_set("newsguys_complete");
}

_id_EAC7() {
  level._id_EA2C endon("death");
  level endon("entering_bridge_scene");
  scripts\engine\utility::flag_init("hallway_vo_finished");
  var_0 = "europa_bridgehall_salter_waitbydoor_left";
  thread _id_EA43();
  level._id_EA2C _id_0B6A::_id_EC0B(var_0, "shipcrib_stand_stationary_talk_idle_02");
  level._id_EA2C _id_0EE5::_id_202D(2);
  level._id_EA2C scripts\sp\interaction_manager::_id_1100A();
  scripts\engine\utility::flag_wait("hallway_vo_finished");
  level._id_EA2C scripts\sp\interaction::_id_137F5(300);
  level._id_EA2C scripts\sp\interaction_manager::_id_45A7();
}

_id_1375F(var_0, var_1) {
  var_2 = scripts\engine\utility::getStruct(var_1, "targetname");

  if(isDefined(self.origin) && isDefined(var_2.origin)) {
    while(distance2d(self.origin, var_2.origin) > var_0)
      scripts\engine\utility::waitframe();
  }
}

_id_EA43() {
  level endon("entering_bridge_scene");
  level._id_EA2C endon("death");
  scripts\engine\utility::flag_wait("bridge_hallway_commit");
  wait 1;
  level._id_EA2C thread _id_118E9();
  level.player scripts\sp\utility::_id_1034D("sc_europa_plr_bealongday");
  level._id_EA2C scripts\sp\utility::_id_10346("sc_europa_slt_sixontwelveoff");
  scripts\engine\utility::flag_set("hallway_vo_finished");
  level._id_EA2C scripts\sp\utility::_id_77BD(1.2);
}

_id_118E9(var_0, var_1, var_2, var_3) {
  level endon("entering_bridge_scene");
  wait 1;
  scripts\sp\utility::_id_13861("on", level.player, "right");
  wait 2.5;
  scripts\sp\utility::_id_13861("off");
}

_id_1F39(var_0, var_1, var_2, var_3) {
  self endon("death");
  scripts\sp\utility::_id_65E0("ready_for_mac_scene");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_0 scripts\sp\anim::_id_1F35(self, var_1);
  scripts\sp\utility::_id_65E1("ready_for_mac_scene");
  level endon("mac_scene_started");

  if(issubstr(var_3, "opsmap")) {
    if(self._id_1FBB == "salter" || self._id_1FBB == "gator" || self._id_1FBB == "drop_officer")
      thread _id_0EFB::_id_CD3F(var_3);
    else
      thread scripts\sp\interaction::_id_CD50(var_3);
  }

  if(isDefined(var_2)) {
    scripts\sp\interaction_manager::_id_DB71(var_2);
    thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
  } else
    _id_0EE5::_id_202D();
}

_id_3A28() {
  level notify("entered_cap_ops");
  level thread scripts\sp\interaction_manager::_id_C9C4();
  level _id_0B20::_id_AB71(self, "right_push", 0.4);
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3A29);
}

_id_3A29() {
  level thread scripts\sp\interaction_manager::_id_45A9();
  level _id_0B20::_id_AB71(self, "right_pull", 0.4);
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3A28);
}

_id_307C() {
  if(!level.console) {
    waitforalltransients();
    wait 0.15;
  }

  level notify("entering_bridge_scene");
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  _id_0EDB::early_out_broadcast();
  level _id_0B20::_id_AB71(self, "left_push_long", 0.4, ::_id_307E, 1, 0.3);
  level thread _id_0B20::_id_5A52("bridge", ::_id_3080);
  setmusicstate("");
}

_id_307F() {
  level notify("entering_bridge_scene");
  level._id_EFED = "inside_slow";
  level thread scripts\sp\interaction_manager::_id_45A9();
  level _id_0B20::_id_AB71(self, "left_push", 0.4);
  level thread _id_0B20::_id_5A52("bridge", ::_id_3080);
}

_id_3080() {
  level notify("exiting_bridge_scene");
  level._id_EFED = "inside";
  level thread scripts\sp\interaction_manager::_id_C9C4();
  level _id_0B20::_id_AB71(self, "left_pull", 0.4);
  level thread _id_0B20::_id_5A52("bridge", ::_id_307F);
}

_id_307E() {
  level._id_EA2C _id_EA49();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C683("solar_system", undefined, 1);
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level _id_30AC();
  level._id_EFED = "inside_slow";
  var_1 = scripts\sp\utility::_id_10639("do_toolbox");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "SH3_11_EUR_SH_BR_OPS_DO_idle_toolbox");
  scripts\sp\anim::_id_17FC("gator", "mac_start", "mac_start", "SH3_10_EUR_SH_BR_PRE_NAV_intro");
  scripts\sp\anim::_id_17F6("gator", "vo_sc_europa_nav_halfsteam", ::_id_4416, "SH3_10_EUR_SH_BR_PRE_NAV_intro");
  var_0 notify("stop_gator_loop");
  level._id_76FB thread _id_1F39(var_0, "SH3_10_EUR_SH_BR_PRE_NAV_intro", undefined, "opsmap_gator_react");
  wait 2.5;
  level._id_EA2C thread _id_1F39(var_0, "SH3_10_EUR_SH_BR_PRE_XO_intro", "sc_europa_slt_chiefsinherelement", "opsmap_salter_react");
  level waittill("mac_start");
  level._id_76FB thread _id_7708(var_0);
  scripts\sp\anim::_id_17FC("mac", "vo_sc_europa_mac_readyandable", "opsmap_active", "SH3_10_EUR_SH_BR_PRE_ENG_intro");
  level._id_B11D thread _id_FDB0("stop_mac_loop", var_0, "SH3_10_EUR_SH_BR_PRE_ENG_intro", "SH3_11_EUR_SH_BR_OPS_ENG_idle", "shipcrib_mac_commander");
  level._id_5CFC thread _id_FDB0("stop_drop_officer_loop", var_0, "SH3_10_EUR_SH_BR_PRE_DO_intro", "SH3_11_EUR_SH_BR_OPS_DO_idle", "shipcrib_dpo_captain");
  level waittill("opsmap_active");
  level._id_C6AA["retribution"]._id_EF68 thread scripts\sp\anim::_id_1EC3(level._id_C6AA["retribution"]._id_1339A, "SH3_11_EUR_SH_BR_OPS_PLR_intro");
  var_2 = scripts\engine\utility::getStruct("mac_interact", "targetname");
  var_3 = getEnt("mac_interact_player_pos", "targetname");
  var_2 thread _id_0E46::_id_48C4(undefined, undefined, undefined, 15, 750, 70, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
  var_2 waittill("trigger");
  level notify("mac_interact");
  level notify("bridge_scene_started");
  level._id_B11D _id_4173(var_0, "SH3_11_EUR_SH_BR_OPS_ENG_idle", "stop_mac_loop");
  level._id_5CFC _id_4173(var_0, "SH3_11_EUR_SH_BR_OPS_DO_idle", "stop_drop_officer_loop");
  level.player _meth_823C(level._id_C6AA["retribution"]._id_1339A, "tag_player", 0.4);
  wait 0.45;
  level.player _meth_8562();
  level.player playerlinktodelta(level._id_C6AA["retribution"]._id_1339A, "tag_player", 1, 20, 20, 20, 20, 1);
  level.player _meth_8392(1.0, 1, 1);
  level._id_C6AA["retribution"]._id_1339A show();
  var_4 = getEnt("bridge_opsmap_floor_panel", "targetname");
  var_4 scripts\engine\utility::delaycall(3, ::rotateto, (0, 0, 0), 1.55);
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(5, _id_0EDE::_id_C697);
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(10.6, _id_0EDE::_id_C678, "sc_europa_world_opsmap_tutorial");
  level._id_EA2C thread _id_B13F(var_0, "SH3_11_EUR_SH_BR_OPS_XO_intro");
  level._id_76FB thread _id_B13F(var_0, "SH3_11_EUR_SH_BR_OPS_NAV_intro");
  level._id_4451 _id_0EE5::_id_2037("opsmap_comms_react");
  level._id_1044B _id_0EE5::_id_2037("opsmap_boats_react");
  level._id_C6AA["retribution"]._id_EF68 thread scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_1339A, "SH3_11_EUR_SH_BR_OPS_PLR_intro");
  var_0 notify("stop_mac_loop");
  var_0 notify("stop_drop_officer_loop");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_B11D, "SH3_11_EUR_SH_BR_OPS_ENG_intro");
  level._id_5CFC thread _id_3033(var_0, var_1);
  wait 24.5;
  stopcinematicingame();
  wait 0.5;
  cinematicingame("opsmap_table_transition_full", 1);
  wait 0.5;
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C692();
  level._id_C6AA["retribution"] thread _id_C655(var_0);
}

_id_FDB0(var_0, var_1, var_2, var_3, var_4) {
  self endon("death");
  level endon("mac_interact");
  var_1 notify(var_0);
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_1 scripts\sp\anim::_id_1F35(self, var_2);
  var_1 thread scripts\sp\anim::_id_1EEA(self, var_3, var_0);
  wait 2;
  thread _id_0EE5::_id_202D(undefined, var_4);
}

_id_4173(var_0, var_1, var_2) {
  var_0 notify(var_2);
  self notify("stop_delay_thread");
  self _meth_83A1();
  _id_0EE5::_id_10FC4();
  var_0 thread scripts\sp\anim::_id_1EEA(self, var_1, var_2);
}

_id_EA49() {
  scripts\sp\utility::_id_13861("off");
  thread scripts\sp\utility::_id_77BD(0.05);
  _id_0EE5::_id_10FC4();
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
}

_id_B13F(var_0, var_1) {
  var_2 = gettime();
  scripts\sp\utility::_id_65E3("ready_for_mac_scene");

  if(scripts\sp\utility::_id_65DF("mac_nag"))
    scripts\sp\utility::_id_65E8("mac_nag");

  var_3 = gettime();
  level notify("mac_scene_started");
  thread _id_0EFB::_id_11004();
  var_0 thread scripts\sp\anim::_id_1F35(self, var_1);
  var_4 = var_3 - var_2;

  if(var_4 >= 0.05) {
    var_5 = var_4 * 0.001;
    wait 0.05;
    var_6 = scripts\sp\utility::_id_7DC1(var_1);
    var_7 = getanimlength(var_6);
    var_8 = var_5 / var_7;
    self _meth_82B0(var_6, var_8);
  }
}

_id_3033(var_0, var_1) {
  var_0 thread scripts\sp\anim::_id_1F35(self, "SH3_11_EUR_SH_BR_OPS_DO_intro");
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "SH3_11_EUR_SH_BR_OPS_DO_intro_toolbox");
  wait 10;
  self _meth_83A1();
  var_1 unlink();
  var_1 delete();
  var_2 = _id_0EFB::_id_EFDB("drop");
  level._id_5CFC _meth_80F1(var_2.origin, var_2.angles);
  level._id_5CFC orientmode("face angle", var_2.angles[1]);
  level._id_5CFC thread _id_0EE5::_id_202D();
  level._id_5CFC thread scripts\sp\anim::_id_1EEA(level._id_5CFC, "shipcrib_standing_console_idle_01_DO", "stop_drops_loop");
}

_id_7708(var_0) {
  self endon("death");
  level endon("mac_interact");
  level endon("exiting_bridge_scene");
  level endon("entered_cap_ops");
  scripts\sp\utility::_id_65E0("mac_nag");
  wait 30;
  thread _id_7709(var_0);
}

_id_7709(var_0) {
  scripts\sp\utility::_id_65E1("mac_nag");
  _id_0EFB::_id_11004();
  wait 0.7;
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_10_EUR_SH_BR_PRE_NAV_nag");
  thread _id_0EFB::_id_CD3F("opsmap_gator_react");
  scripts\sp\utility::_id_65DD("mac_nag");
}

_id_C655(var_0) {
  self endon("opsmap_disable");
  level waittill("fullscreen_opsmap_enabled");
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C683("solar_system", undefined, 0);
  var_0 notify("stop_salter_loop");
  var_0 notify("stop_mac_loop");
  var_0 notify("stop_gator_loop");
  level._id_76FB _meth_83A1();
  level._id_EA2C _meth_83A1();
  level._id_B11D _meth_83A1();
  level._id_76FB thread _id_0EFB::_id_CD3F("opsmap_gator_react");
  level._id_EA2C thread _id_0EFB::_id_CD3F("opsmap_salter_react");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_B11D, "SH3_11_EUR_SH_BR_OPS_ENG_waiting_idle");
  level._id_76FB thread _id_0EE5::_id_202D(undefined, "sc_europa_gtr_goodtoseeretribution");
  level._id_B11D thread _id_0EE5::_id_202D();
  level._id_1044B scripts\sp\interaction_manager::_id_DB71("sc_europa_bts_iknowourcrewhas");
  level._id_4451 scripts\sp\interaction_manager::_id_DB71("sc_europa_cmo_quiteanedgeweh");
  level._id_1044B thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
  level._id_4451 thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_europa_slt_thatintelsgonnapayoff");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_europa_slt_letsgotoworkcaptainigot");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_europa_slt_igotbulletsidontwant");
  wait 0.05;
  level thread scripts\sp\interaction_manager::_id_E815(30.0);
  level scripts\engine\utility::delaythread(0.5, scripts\sp\interaction_manager::_id_C9C4);
}

#using_animtree("player");

_id_67B8() {
  scripts\sp\anim::_id_17FC("mac", "start_fade", "mac_scene_fadeout", "SH3_11B_EUR_SH_BR_OPS_ENG_scene");
  var_0 = level._id_C6AA["retribution"];
  var_1 = % sh3_11b_eur_sh_br_ops_plr_scene;
  level.player playerlinkTo(var_0._id_1339A, "tag_player");
  level.player _meth_823C(var_0._id_1339A, "tag_player", 0.05);
  var_0._id_1339A.origin = getstartorigin(var_0._id_EF68.origin, var_0._id_EF68.angles, var_1);
  var_0._id_1339A.angles = getstartangles(var_0._id_EF68.origin, var_0._id_EF68.angles, var_1);
  var_0._id_1339A clearanim(%opsmap, 0);
  var_0._id_1339A _meth_82E2("single anim", var_1, 1, 0, 0);
  var_0._id_1339A thread scripts\sp\anim::_id_10CBF(var_0._id_1339A, "single anim");
  var_0._id_1339A thread scripts\sp\anim::_id_1FCA(var_0._id_1339A, "single anim");
  var_2 = var_0._id_EF67;
  level._id_76FB _id_0EE5::_id_10FC4();
  level._id_B11D notify("stop_loop");
  level scripts\sp\interaction_manager::_id_11037();
  level._id_EA2C _id_0EFB::_id_11004();
  level._id_B11D _id_0EFB::_id_11004();
  var_0._id_1339A _meth_82B1(var_1, 1);
  level.player playSound("shipcrib_europa_post_mission_select_walla");
  level._id_76FB scripts\engine\utility::delaythread(0.05, _id_0EFB::_id_CD3F, "opsmap_gator_react");
  var_2 thread scripts\sp\anim::_id_1F35(level._id_B11D, "SH3_11B_EUR_SH_BR_OPS_ENG_scene");
  var_2 thread scripts\sp\anim::_id_1F35(level._id_EA2C, "SH3_11B_EUR_SH_BR_OPS_XO_scene");
  wait 0.1;
  level.player playerlinktodelta(var_0._id_1339A, "tag_player", 1, 30, 30, 30, 5, 1);
  level.player _meth_8392(0.2, 2.2, 0.6);
  level waittill("mac_scene_fadeout");
  wait 1;
  level.player _meth_8391(1.0);
  thread _id_0EF7::_id_2605();
  level.player scripts\engine\utility::delaycall(1.05, ::stopsounds);
  scripts\sp\hud_util::_id_6AA3(1, "black");
  level.player unlink();
  var_0._id_1339A hide();
}

_id_3077() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level thread _id_0B20::_id_5A52("armory", ::_id_223D);
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A73);
  level thread scripts\sp\utility::_id_CE10("sc_europa_cutscene_mac_briefing");
  level.player allowmovement(0);
  level.player scripts\sp\utility::_id_11633(_id_0EFB::_id_7D7A("bridge_player_post_bink"));
  level.player _meth_823B(_id_0EFB::_id_7D7A("bridge_player_post_bink"));
  var_0 scripts\sp\anim::_id_1EC3(level._id_EA2C, "SH3_12_EUR_SH_BR_BRIEF_XO_ops_arrive");
  level waittill("skippable_cinematic_done");
  level.player unlink();
  level.player allowmovement(1);
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(0, _id_0EDE::_id_C683, "calculation", "europa");
  level thread _id_0EE4::_id_E37A();
  level thread _id_0EEE::_id_FD8B(2);
  scripts\sp\anim::_id_17FE("salter", "vo_sc_europa_slt_prepareforjump", "SH3_12_EUR_SH_BR_BRIEF_XO_ops_arrive", "sc_europa_slt_prepareforjump_pa");
  scripts\sp\anim::_id_17F6("salter", "sc_europa_un2_collisionalarmsup", ::_id_5789, "SH3_12_EUR_SH_BR_BRIEF_XO_ops_arrive");
  scripts\sp\anim::_id_17F6("salter", "sc_europa_un1_clearset", ::_id_4455, "SH3_12_EUR_SH_BR_BRIEF_XO_ops_arrive");
  level._id_76FB thread _id_7703(var_0);
  var_0 thread scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_CACE["xo"], "SH3_12_EUR_SH_BR_BRIEF_PHONE_intro");
  var_0 thread scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH3_12_EUR_SH_BR_BRIEF_MONITOR_intro");
  level._id_B11D thread _id_FDB1(var_0, "SH3_12_EUR_SH_BR_BRIEF_ENG_ops_setup", level._id_C6AA["retribution"]._id_10E52["drop"]);
  level._id_EA2C _id_FDB1(var_0, "SH3_12_EUR_SH_BR_BRIEF_XO_ops_arrive", level._id_C6AA["retribution"]._id_10E52["xo"]);
  level._id_C6AA["retribution"] _id_0EDE::_id_C6A7();
  level._id_FD6E._id_7498["freq_min"] = 6;
  level._id_FD6E._id_7498["freq_max"] = 7;
  level._id_FD6E._id_7498["pitch_min"] = 0.2;
  level._id_FD6E._id_7498["pitch_max"] = 0.3;
  level._id_FD6E._id_7498["yaw_min"] = 0.2;
  level._id_FD6E._id_7498["yaw_max"] = 0.3;
  level._id_FD6E._id_7498["roll_min"] = 0.3;
  level._id_FD6E._id_7498["roll_max"] = 0.4;
  level thread _id_0EEE::_id_FD89("europa", "retribution", undefined, ::_id_48DC, 6);
  scripts\sp\anim::_id_17FE("salter", "vo_sc_europa_slt_conditiontwo", "SH3_13_EUR_SH_BR_JUMP_XO_intro", "sc_europa_slt_conditiontwo_pa");
  scripts\sp\anim::_id_17FC("salter", "FTL_end_3_sec", "ftl_3_sec_left", "SH3_13_EUR_SH_BR_JUMP_XO_intro");
  scripts\sp\anim::_id_17FC("salter", "FTL_end", "ftl_stop", "SH3_13_EUR_SH_BR_JUMP_XO_intro");
  scripts\sp\anim::_id_17FC("mac", "sc_europa_un2_sequenceisgood", "sc_europa_un2_sequenceisgood", "SH3_13_EUR_SH_BR_JUMP_ENG_intro");
  scripts\sp\anim::_id_17FC("mac", "sc_europa_un2_ayesirrightaway", "sc_europa_un2_ayesirrightaway", "SH3_13_EUR_SH_BR_JUMP_ENG_intro");
  scripts\sp\anim::_id_17FC("mac", "sc_europa_un2_errormargin", "sc_europa_un2_errormargin", "SH3_13_EUR_SH_BR_JUMP_ENG_intro");
  level._id_5CFC thread _id_3084();
  level._id_EA2C thread _id_EAC8(var_0);
  level._id_B11D thread _id_B140(var_0);
  level._id_76FB thread _id_7705(var_0);
  level waittill("ftl_stop");
  level._id_C6AA["retribution"] _id_0EDE::_id_C659();
  level thread _id_0EEE::_id_FD8A(1);
  scripts\engine\utility::flag_wait_all("salter_on_elevator", "mac_on_elevator");
  stopcinematicingame();
  _id_AB12();
}

_id_FDB1(var_0, var_1, var_2) {
  self endon("death");
  level endon("mac_interact");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_0 scripts\sp\anim::_id_1F35(self, var_1);
}

_id_5789(var_0) {
  level._id_5CFC scripts\sp\utility::_id_10347("sc_europa_un2_collisionalarmsup");
}

_id_4455(var_0) {
  level._id_4451 scripts\sp\utility::_id_10347("sc_europa_un1_clearset");
}

_id_7703(var_0) {
  self endon("death");
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_12_EUR_SH_BR_BRIEF_NAV_intro");
  wait 1;
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_12_EUR_SH_BR_BRIEF_NAV_checkrange");
  level._id_76FB thread _id_7704();

  if(scripts\sp\interaction::_id_9CD7(level._id_C6AA["retribution"]._id_10E52["nav"]))
    thread scripts\sp\interaction_manager::_id_CE40(level._id_C6AA["retribution"]._id_10E52["nav"]._id_EE92);
  else
    thread _id_0EFB::_id_CD3F(level._id_C6AA["retribution"]._id_10E52["nav"]._id_EE92);
}

_id_7705(var_0, var_1) {
  self endon("death");
  var_0 notify("stop_gator_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  scripts\sp\anim::_id_1F12(self);
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_13_EUR_SH_BR_JUMP_NAV_intro");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH3_13_EUR_SH_BR_JUMP_NAV_idle", "stop_gator_loop");
  var_2 = squared(180);

  for(var_3 = scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin); var_3 < var_2; var_3 = scripts\engine\utility::distance_2d_squared(self.origin, level.player.origin))
    scripts\engine\utility::waitframe();

  var_0 notify("stop_gator_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_13_EUR_SH_BR_JUMP_NAV_move_plr_station");
}

_id_3084() {
  self endon("death");
  level waittill("sc_europa_un2_sequenceisgood");
  scripts\sp\utility::_id_10347("sc_europa_un2_sequenceisgood");
  level waittill("sc_europa_un2_ayesirrightaway");
  scripts\sp\utility::_id_10347("sc_europa_un2_ayesirrightaway");
  level waittill("sc_europa_un2_errormargin");
  scripts\sp\utility::_id_10347("sc_europa_un2_errormargin");
}

_id_B140(var_0) {
  self endon("death");
  scripts\engine\utility::flag_init("mac_on_elevator");
  var_0 notify("stop_mac_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_13_EUR_SH_BR_JUMP_ENG_intro");
  var_0 notify("stop_mac_loop");
  var_1 = _id_0EEB::_id_7976("bridge");
  var_2 = _id_7B74(var_1, self, "leave_elevator_performance");
  _id_0B6A::_id_EC0B(var_2, "shipcrib_stand_stationary_talk_idle_01");
  self linkTo(var_1);
  var_2 delete();
  _id_0EE5::_id_202D(1);
  scripts\engine\utility::flag_set("mac_on_elevator");
}

_id_EAC8(var_0) {
  self endon("death");
  scripts\engine\utility::flag_init("salter_on_elevator");
  var_0 notify("stop_salter_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_13_EUR_SH_BR_JUMP_XO_intro");
  thread _id_0B21::_id_5A43("bridge_exit", "open");
  var_1 = _id_0EEB::_id_7976("bridge");
  var_2 = _id_7B74(var_1, self, "leave_elevator_performance");
  _id_0B6A::_id_EC0B(var_2, "shipcrib_stand_stationary_talk_idle_01");
  self linkTo(var_1);
  var_2 delete();
  _id_0EE5::_id_202D(1);
  scripts\engine\utility::flag_set("salter_on_elevator");
}

_id_7B74(var_0, var_1, var_2) {
  var_3 = level._id_EC85[var_1._id_1FBB][var_2];
  var_4 = getstartorigin(var_0.origin, var_0.angles, var_3);
  var_5 = getstartangles(var_0.origin, var_0.angles, var_3);
  var_6 = scripts\engine\utility::spawn_tag_origin(var_4, var_5);
  return var_6;
}

_id_7712(var_0) {
  self endon("death");
  level endon("opsmap_selection_made");
  wait 30;
  var_0 notify("stop_gator_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_11_EUR_SH_BR_OPS_NAV_nag");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH3_11_EUR_SH_BR_OPS_NAV_waiting_idle", "stop_gator_loop");
}

_id_7704() {
  self endon("death");
  level endon("ftl triggered");
  wait 30;
  scripts\sp\narrative::_id_194A("sc_europa_nav_jumpignitionony");
}

_id_13E17() {
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_europa_slt_wegottahitit");
  thread scripts\sp\interaction_manager::_id_E815(15);
  level waittill("stop_elevator_nags");
  scripts\sp\interaction_manager::_id_11037();
}

_id_30AC() {
  var_0 = getEnt("bridge_opsmap_floor_panel", "targetname");
  var_0 rotateTo((-80, 0, 0), 0.05);
  var_1 = _id_0EF8::_id_FDFC("spawner_mac", undefined, "cheap");
  var_1 thread _id_0EFB::_id_FE0B();
  level._id_C6AA["retribution"]._id_EF67 thread scripts\sp\anim::_id_1EEA(var_1, "SH3_10_EUR_SH_BR_PRE_ENG_idle_01", "stop_mac_loop");
  var_1 = _id_0EF8::_id_FDFC("spawner_gator", undefined, "cheap");
  level._id_C6AA["retribution"]._id_EF67 thread scripts\sp\anim::_id_1EEA(var_1, "SH3_10_EUR_SH_BR_PRE_NAV_ops_idle_01", "stop_gator_loop");
  var_1 = _id_0EF8::_id_FDFC("spawner_drop_officer", undefined);
  level._id_C6AA["retribution"]._id_EF67 thread scripts\sp\anim::_id_1EEA(var_1, "SH3_10_EUR_SH_BR_PRE_DO_idle_01", "stop_drop_officer_loop");
  _id_0EF8::_id_FDFC("spawner_comms", "homebase", "cheap");
  level._id_4451 _id_0EE5::_id_2037("opsmap_comms_react", "sc_europa_cmo_signalacquisition");
  _id_0EF8::_id_FDFC("spawner_sotomura", "homebase", "cheap");
  level._id_1044B _id_0EE5::_id_2037("opsmap_boats_react", "sc_europa_bts_chiefsbeenwaiting");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_ftl3", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac3", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_tac4", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys1", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys2", "homebase", "cheap");
  _id_0EF8::_id_FDFC("spawner_bridge_sys3", "homebase", "cheap");
  level scripts\engine\utility::delaythread(1.0, _id_0EF0::_id_FDA0);
}

_id_AB12() {
  _id_0EEB::_id_7976("bridge").trigger waittill("trigger");
  thread _id_AB10();
  _id_0EEB::_id_60F0("bridge", 95);
  _id_0EEB::_id_60FD("bridge", "Mezzanine");
  _id_0EEB::_id_7976("bridge") waittill("move_finished");
  level thread _id_0B21::_id_5A43("mezzanine_elevator", "open");
}

_id_AB10() {
  level._id_EA2C _id_0EE5::_id_10FC4();
  level._id_B11D _id_0EE5::_id_10FC4();
  var_0 = _id_0EEB::_id_7976("bridge");
  var_1 = [level._id_EA2C, level._id_B11D];
  var_0 scripts\sp\anim::_id_1F2C(var_1, "leave_elevator_performance");
}

_id_AB13() {}

_id_1685() {
  scripts\engine\utility::flag_init("end_armoryhallway");
  level thread _id_F70B("end_armoryhallway", "armory_started");
  thread _id_EA85();
  wait 1.25;
  thread _id_B13E();
}

_id_EA85() {
  level._id_EA2C unlink();
  level._id_EA2C _id_0B6A::_id_EC0A("shipcrib_europa_armory_xo_start");

  if(!scripts\engine\utility::flag("end_armoryhallway")) {
    level._id_EA2C _id_0EE5::_id_202D(2, "sc_europa_slt_settojet");
    scripts\engine\utility::flag_wait("end_armoryhallway");
    level._id_EA2C _id_0EE5::_id_10FC4();
  }
}

_id_B13E() {
  level._id_B11D unlink();
  level._id_B11D _id_0B6A::_id_EC0A("shipcrib_europa_armory_engineer_start");

  if(!scripts\engine\utility::flag("end_armoryhallway")) {
    level._id_B11D _id_0EE5::_id_202D(4);
    scripts\engine\utility::flag_wait("end_armoryhallway");
    level._id_B11D _id_0EE5::_id_10FC4();
  }
}

_id_2204() {
  level._id_A04F delete();
  level._id_4A69 delete();
}

_id_F70B(var_0, var_1) {
  self waittill(var_1);
  scripts\engine\utility::flag_set(var_0);
}

_id_DB69() {}

_id_DD6E() {}

_id_A053() {}

_id_223D() {
  level notify("armory_started");
  thread _id_11616();
  level thread _id_0EE8::_id_F9E5();
  level thread _id_223C();
  level _id_0B20::_id_AB71(self, "right_push_long", 0.4, undefined, 1, 1.25);
  level thread _id_0B20::_id_5A2E("armory", "locked");
}

_id_11616() {
  level._id_EA2C _id_0B20::_id_5A4D("armory", 1);
  level._id_EA2C notify("begin_armory_scene");
  wait 1.25;
  level._id_B11D _id_0B20::_id_5A4D("armory", 0);
  level._id_B11D notify("begin_armory_scene");
}

_id_223C() {
  level endon("stop_armory_scene");
  _id_983B();
  thread _id_CC93();
  _id_137C6();
  scripts\engine\utility::flag_set("player_chose_loadout");
  level thread _id_0B20::_id_5A2E("armory_exit", "unlocked");
  _id_CC96();
}

_id_137C6() {
  scripts\engine\utility::flag_wait("at_terminal");
  scripts\engine\utility::flag_waitopen("at_terminal");
}

_id_983B() {
  _id_983E();
  thread _id_9855();
}

_id_983E() {
  scripts\engine\utility::flag_clear("armory_chose_loadout");
  scripts\engine\utility::flag_clear("at_terminal");
  scripts\engine\utility::flag_init("player_chose_loadout");
  scripts\engine\utility::flag_init("armory_exited");
  scripts\engine\utility::flag_init("armory_exit_reaction_triggered");
}

_id_9855() {
  _id_0EF8::_id_FDFC("spawner_griff", "armory_officer_reaction_point");
  level._id_8604 scripts\sp\utility::_id_86E2();
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_8604, "armory_officer_intro_idle", "stop_loop");
}

_id_CC93() {
  thread _id_CC6C();
  _id_CC94();
  thread _id_DB66();
  thread _id_2A57();
}

_id_CC6C() {
  level._id_EA2C waittill("begin_armory_scene");
  level._id_EA2C thread _id_CE57("org_armory_booth_1_anim");
  level._id_B11D waittill("begin_armory_scene");
  level._id_B11D thread _id_CE57("org_armory_booth_2_anim");
}

_id_CC94() {
  wait 2.5;
  level._id_8604 scripts\sp\narrative::_id_194A("sc_europa_grf_captlt", _id_0C4C::_id_1960, "**salute", undefined, undefined, undefined, "at_terminal");
  wait 1;
  level._id_8604 scripts\sp\narrative::_id_194A("sc_europa_grf_chiefswithyou", scripts\sp\utility::_id_7799, level._id_B11D, undefined, undefined, undefined, "at_terminal");
  wait 1;
  level._id_8604 scripts\sp\narrative::_id_194A("sc_europa_grf_letsgetyougear", scripts\sp\utility::_id_7799, level.player, undefined, undefined, undefined, "at_terminal");
}

_id_DB66() {
  wait 20;

  if(!scripts\engine\utility::flag("at_terminal")) {
    level._id_8604 thread scripts\sp\narrative::_id_194A("sc_europa_grf_hittheterminal", scripts\sp\narrative::_id_195C, level.player);
    _id_CC9A("sc_europa_grf_hittheterminal_spkr");
  }
}

_id_CC96() {
  thread _id_CC97();
  thread _id_CDF1();
  thread _id_CD89();
}

_id_CC97() {
  level._id_B11D scripts\sp\utility::_id_10346("sc_europa_mac_allset");
  level._id_8604 scripts\sp\utility::_id_10346("sc_europa_grf_goodhunting");
  level._id_8604 scripts\sp\utility::_id_10346("sc_europa_grf_orwhatever");
}

_id_CDF1() {
  level._id_EA2C _id_CE58("shipcrib_europa_armory_xo_exit");

  if(!scripts\engine\utility::flag("armory_exited")) {
    level._id_EA2C _id_0EE5::_id_202D(undefined, "sc_europa_slt_letsgetthispar");
    scripts\engine\utility::flag_wait("armory_exited");
    level._id_EA2C _id_0EE5::_id_10FC4();
  }
}

_id_CD89() {
  level._id_B11D _id_CE58("shipcrib_europa_armory_engineer_exit");

  if(!scripts\engine\utility::flag("armory_exited")) {
    level._id_B11D _id_0EE5::_id_202D(undefined, "sc_europa_mac_commander");
    scripts\engine\utility::flag_wait("armory_exited");
    level._id_B11D _id_0EE5::_id_10FC4();
  }
}

_id_DB64() {
  wait 30;

  if(!scripts\engine\utility::flag("armory_exit_reaction_triggered")) {
    level._id_B11D scripts\sp\narrative::_id_194A("sc_europa_mac_doesthecaptain", scripts\sp\narrative::_id_195C, level.player);
    level._id_B11D scripts\sp\narrative::_id_194A("sc_europa_slt_chiefhalfthetime", scripts\sp\narrative::_id_195C, level.player);
  }
}

_id_CE57(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_1 notify("stop_loop");
  var_1 scripts\sp\anim::_id_1F17(self, "armory_booth_enter");
  var_1 scripts\sp\anim::_id_1F35(self, "armory_booth_enter");
  _id_CE59(var_0);
}

_id_CE59(var_0) {
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_1 thread scripts\sp\anim::_id_1EEA(self, "armory_booth_idle");
  scripts\engine\utility::flag_wait("player_chose_loadout");
  var_1 notify("stop_loop");
}

_id_CE58(var_0) {
  scripts\sp\utility::_id_86E4();
  scripts\sp\utility::_id_51E1("casual_gun");
  wait 4;
  scripts\sp\utility::_id_86E2();
  _id_0B6A::_id_EC0A(var_0);
}

_id_CE5C(var_0) {}

_id_2A57() {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  level._id_8604 _id_0B6A::_id_EC0D("armory_officer_reaction_point");
  level _id_0E86::main();
  level._id_8604 thread scripts\sp\interaction::_id_CD4B("shipcrib_europa_armory_officer_react", var_0, 1);
  level._id_8604 thread _id_2185();
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

_id_CC9A(var_0) {
  _id_3D5F();

  foreach(var_2 in level._id_2249)
  thread scripts\engine\utility::play_sound_in_space(var_0, var_2.origin);

  var_4 = lookupsoundlength(var_0) / 1000;
  wait(var_4);
}

_id_3D5F() {
  if(!isDefined(level._id_2249))
    _id_9534();
}

_id_9534() {
  level._id_2249 = scripts\engine\utility::getStructArray("armory_speaker_system", "targetname");
}

_id_CC9B() {}

_id_DB65() {}

_id_1A73() {
  scripts\engine\utility::flag_set("armory_exited");
  level notify("stop_armory_scene");
  level thread scripts\sp\maps\shipcrib_europa\shipcrib_europa_ambient::_id_8A8B("airboss");
  _id_0EF8::_id_FDFC("spawner_gibson", "shipcrib_europa_airboss_start");
  level thread _id_0B21::_id_5A43("airboss", "open");
  var_0 = 1;
  level._id_EA2C scripts\engine\utility::delaythread(var_0, ::_id_1A84);
  level._id_828C scripts\engine\utility::delaythread(var_0, ::_id_1A75);
  level._id_B11D scripts\engine\utility::delaythread(var_0, ::_id_1A7C);
  level _id_0B20::_id_AB71(self, "right_push_long", 0.4, undefined, 1, 0.75);
  level thread _id_0B20::_id_5A2E("armory_exit", "locked");
  _id_0EEB::_id_7976("gravity") notify("doors_close");
  level thread _id_0EEB::_id_60F0("gravity", 29);
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck");
  _id_0EEB::_id_7976("gravity") waittill("move_finished");
  level waittill("airboss_airboss_done");
  level scripts\engine\utility::delaythread(0, ::_id_A305);
}

_id_1A84() {
  self endon("death");
  var_0 = _id_0EEB::_id_7976("gravity");
  scripts\sp\utility::_id_F40E("casual", "SH3_17A_EUR_ELEV_XO_idle");
  self linkTo(var_0);
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_17A_EUR_ELEV_XO_intro");
  self unlink();
}

_id_1A7C() {
  self endon("death");
  var_0 = _id_0EEB::_id_7976("gravity");
  self notify("stop_anim_single_to_loop_solo");
  scripts\sp\utility::_id_F40E("casual", "SH3_17A_EUR_ELEV_ENG_idle");
  self linkTo(var_0);
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_17A_EUR_ELEV_ENG_intro");
  self unlink();
}

_id_1A75() {
  self endon("death");
  var_0 = _id_0EEB::_id_7976("gravity");
  scripts\sp\utility::_id_F40E("casual", "SH3_17A_EUR_ELEV_AIR_idle");
  self linkTo(var_0);
  level scripts\engine\utility::delaythread(3, _id_0B21::_id_5A43, "airboss", "locked");
  var_0 scripts\sp\anim::_id_1F35(self, "SH3_17A_EUR_ELEV_AIR_intro");
  self unlink();
  level notify("airboss_airboss_done");
}

_id_A305() {
  level endon("player_has_jackal");
  level._id_828C scripts\engine\utility::delaythread(0, ::_id_A306);
  level scripts\engine\utility::delaythread(60, _id_0B6A::_id_EC02, _id_0EFB::_id_7CBC("jackal_bay_3", "script_noteworthy", "player_jackal_breadcrumb"));
  level._id_828C scripts\sp\narrative::_id_194A("sc_europa_gbs_youreuponbaytw", scripts\sp\narrative::_id_195C, level._id_EA2C);
  level._id_EA2C scripts\engine\utility::delaythread(0, ::_id_A30D);
  level._id_B11D scripts\engine\utility::delaythread(1, ::_id_A30A);
  level._id_828C scripts\sp\narrative::_id_194A("sc_europa_gbs_captainsjackwi");
  level._id_828C scripts\sp\narrative::_id_194A("sc_europa_slt_chiefyourewith", scripts\sp\narrative::_id_195C, level._id_EA2C);
  level._id_B11D scripts\sp\narrative::_id_194A("sc_europa_mac_yesmaam", scripts\sp\narrative::_id_195C, level._id_828C);
  level._id_EA2C scripts\sp\narrative::_id_194A("sc_europa_slt_werenettingall");
  level._id_828C scripts\sp\narrative::_id_194A("sc_europa_gbs_unauthorized", scripts\sp\narrative::_id_195C, level._id_EA2C);
  level._id_EA2C scripts\sp\narrative::_id_194A("sc_europa_slt_onehundredpercent", scripts\sp\narrative::_id_195C, level._id_828C);
  level._id_B11D scripts\sp\narrative::_id_194A("sc_europa_mac_keepitontheotgi", scripts\sp\narrative::_id_195C, level._id_828C);
  level._id_828C scripts\sp\narrative::_id_194A("sc_europa_gbs_airtightchief", scripts\sp\narrative::_id_195C, level._id_B11D);
  level thread _id_A30C();
}

_id_A308() {
  _id_0E88::main();
  _id_0EF8::_id_FDFC("spawner_kloos");
  level._id_A6F4 endon("death");
  var_0 = level._id_FD6E.jackals["jackal_bay_3"];
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_A6F4, "SH3_17C_EUR_JACKAL_KLO_start_idle");
  wait 4;
  level._id_A6F4 _id_A6F7();
  level._id_A6F4 scripts\sp\utility::_id_F40E("casual", "SH3_17C_EUR_JACKAL_KLO_idle");
  var_0 scripts\sp\anim::_id_1F35(level._id_A6F4, "SH3_17C_EUR_JACKAL_KLO_jump_down");
  level._id_A6F4 setgoalpos(level._id_A6F4.origin);
  level._id_A6F4 thread _id_0EE5::_id_202D("shipcrib_guard_reaction_idle_01", "");
}

_id_A6F7() {
  var_0 = 16384;
  var_1 = 490000;
  var_2 = self.origin + (0, 0, -60);
  var_3 = 0.85;

  for(;;) {
    var_4 = distance2dsquared(self.origin, level.player.origin);

    if(var_4 < var_1) {
      if(scripts\sp\utility::_id_D1DF(var_2, var_3, 1)) {
        return;
      }
      if(var_4 < var_0)
        return;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_A30D() {
  self endon("death");
  var_0 = _id_0EFB::_id_7CBC("jackal_bay_2", "script_noteworthy", "jackal_launch_front_getin");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_1.origin + anglestoright(var_1.angles) * 100;
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_415D("casual");
  var_1 scripts\sp\anim::_id_1F17(self, "jackal_getin");
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_getin");
  var_0 scripts\sp\anim::_id_1EE0(self, "jackal_getin");
  var_1 delete();
}

_id_A30A() {
  self endon("death");
  var_0 = _id_0EFB::_id_7CBC("jackal_bay_2", "script_noteworthy", "jackal_launch_rear_getin");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_1.origin + anglestoright(var_1.angles) * 136;
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_415D("casual");
  var_1 scripts\sp\anim::_id_1F17(self, "jackal_getin");
  var_0 scripts\sp\anim::_id_1F35(self, "jackal_getin");
  var_0 scripts\sp\anim::_id_1EE0(self, "jackal_getin");
  var_1 delete();
}

_id_A306() {
  self endon("death");
  scripts\sp\utility::_id_415D("casual");
  _id_0B6A::_id_EC0A("jackal_airboss_end");
}

_id_A30C() {
  level endon("player_has_jackal");
  wait 30;
  level._id_EA2C scripts\sp\pip_util::_id_6A67();
  level._id_EA2C scripts\sp\narrative::_id_194A("sc_europa_slt_weshouldgetonth");
  scripts\sp\pip_util::_id_CBA3();
  wait 60;
  level._id_828C scripts\sp\pip_util::_id_6A67();
  level._id_828C scripts\sp\narrative::_id_194A("sc_europa_gbs_yourchariotawai");
  scripts\sp\pip_util::_id_CBA3();
}

_id_A307() {
  level._id_828C scripts\sp\pip_util::_id_6A67();
  level._id_828C scripts\sp\anim::_id_1F35(level._id_828C, "SH3_18_EUR_DECK_JACKAL_AIR_pip01");
  scripts\sp\pip_util::_id_CBA3();
  level._id_EA2C scripts\sp\pip_util::_id_6A67();
  level._id_FD6E.jackals["jackal_bay_2"] scripts\sp\anim::_id_1F35(level._id_EA2C, "SH3_18_EUR_DECK_JACKAL_XO_pip01");
  scripts\sp\pip_util::_id_CBA3();
}

#using_animtree("jackal");

_id_DB75() {
  level._id_CB8A = % jackal_pilot_mount_europa;
  level.vehicle_allows_rider_death = % jackal_vehicle_mount_europa;
  var_0 = level._id_FD6E.jackals["jackal_bay_3"];
  var_0 _id_0BDC::_id_F48D("shipcrib_europa_launch");
  var_0 _id_0BDC::_id_F5BD("shipcrib");
  level waittill("shipcrib_europa_launch_started");
  scripts\engine\utility::noself_delaycall(4.85, ::cinematicingame, "sc_europa_hud_jackal_launch");
  scripts\engine\utility::delaythread(4.9, ::_id_D8E2);
  var_0 thread _id_DB78(level._id_CB8A, "start_kloos", ::_id_A6F5);
  var_0 thread _id_DB78(level._id_CB8A, "helmet_on", _id_0E4B::_id_8E05);
  var_0 thread _id_DB78(level._id_CB8A, "helmet_on", ::_id_8DE2);
  thread _id_CD62();
  thread _id_CD3D();
  level notify("lgt_jackal_mounted");
  level waittill("shipcrib_europa_launch_complete");

  if(getdvarint("e3") > 0) {
    scripts\sp\utility::_id_F305();

    if(scripts\sp\utility::_id_9BEE()) {
      if(level._id_DADC)
        setsaveddvar("r_postaa", 1);
    }
  }

  var_0 notify("launch_ready");
  level notify("lgt_jackal_launch_prep");
}

_id_D8E2() {
  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  level thread scripts\sp\utility::_id_BF98();
}

_id_CD5B() {
  wait 5.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_boost_engaged");
}

_id_CD5C() {
  wait 2.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_environmental");
  wait 2.0;
  level thread scripts\sp\utility::_id_9145("fluff_messages_oxygen");
}

_id_DB78(var_0, var_1, var_2, var_3) {
  if(animhasnotetrack(var_0, var_1)) {
    var_4 = getnotetracktimes(var_0, var_1)[0] * getanimlength(var_0);
    wait(var_4);
  } else if(isDefined(var_3))
    wait(var_3);
  else {}

  [[var_2]]();
}

_id_CD62() {
  var_0 = getanimlength(level._id_A6F4 scripts\sp\utility::_id_7DC1("jackal_mount"));
  wait(var_0 * 0.1);
  level._id_A6F4 thread _id_A6F6();
  var_1 = level._id_FD6E.jackals["jackal_bay_3"];
  level._id_A6F4 scripts\engine\utility::delaycall(0.05, ::_meth_82B0, level._id_A6F4 scripts\sp\utility::_id_7DC1("jackal_mount"), 0.1);
  var_1 scripts\sp\anim::_id_1F35(level._id_A6F4, "jackal_mount");
  level thread _id_D840();
}

#using_animtree("generic_human");

_id_A6F6() {
  self endon("death");
  level waittill("mayhem_start");
  self _meth_82A2(%mayhem_jackal_kloos_mount_europa, 1.0, 0.0, 1.0);
  self detach(self.hatmodel);
  self detach(self.headmodel);
  level waittill("mayhem_end");
  self _meth_82A2(%mayhem_jackal_kloos_mount_europa, 0.0, 0.0, 1.0);
  self attach(self.hatmodel);
  self attach(self.headmodel);
}

_id_CD3D() {
  level._id_A206 = _id_0E4B::_id_10730();
  level._id_A206 scripts\sp\utility::_id_23B7("jackal_helmet");
  var_0 = level._id_FD6E.jackals["jackal_bay_3"];
  var_0 scripts\sp\anim::_id_1F35(level._id_A206, "jackal_mount");
}

#using_animtree("jackal");

_id_490D() {
  _id_0EF9::_id_FE03("jackal", "jackal_bay_3", "player");
  level._id_FD6E.jackals["jackal_bay_3"].collision = level._id_FD6E.jackals["jackal_bay_3"] _id_0EF9::_id_A0AE();
  _id_0EF9::_id_FE03("jackal_cheap", "jackal_bay_4", undefined, undefined, 1);
  level._id_FD6E.jackals["jackal_bay_4"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_center_open_hold);
  level._id_FD6E.jackals["jackal_bay_4"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_left_open_hold);
  level._id_FD6E.jackals["jackal_bay_4"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_right_open_hold);
  level._id_FD6E.jackals["jackal_bay_4"] _meth_82A2(%shipcrib_veh_jackal_lean_hatch_top_open_hold);
  thread _id_DB75();
  _id_0BDC::_id_137CF();
  level notify("player_has_jackal");
  level._id_13CF1 scripts\engine\utility::delaythread(0, _id_10AC::_id_13CED);
  var_0 = 10;
  level scripts\engine\utility::delaythread(var_0, _id_0EE0::_id_E3BE, "jackal_bay_4", 1, 0);
  var_1 = _id_0EF1::_id_7AED("jackal_launch");
  level.player scripts\engine\utility::delaythread(21, _id_0EF7::_id_CE07, var_1);
  level._id_FD6E.jackals["jackal_bay_4"] scripts\engine\utility::delaycall(var_0, ::setanimknob, %shipcrib_veh_jackal_lean_hatch_top_close, 1, 0, 0.35);
  level._id_FD6E.jackals["jackal_bay_4"] scripts\engine\utility::delaycall(var_0 + randomfloatrange(0.5, 2), ::setanimknob, %shipcrib_veh_jackal_lean_hatch_center_closed, 1, 0, 0.5);
  level._id_FD6E.jackals["jackal_bay_4"] scripts\engine\utility::delaycall(var_0 + randomfloatrange(0.5, 2), ::setanimknob, %shipcrib_veh_jackal_lean_hatch_left_close, 1, 0, 0.5);
  level._id_FD6E.jackals["jackal_bay_4"] scripts\engine\utility::delaycall(var_0 + randomfloatrange(0.5, 2), ::setanimknob, %shipcrib_veh_jackal_lean_hatch_right_close, 1, 0, 0.5);
  level._id_FD6E.jackals["jackal_bay_3"] waittill("launch_ready");
  level.player playSound("scn_jackal_launch_alarm");
  level thread _id_0EE0::_id_E3BE("jackal_bay_3", 1);
  level waittill("player_jackal_launch_actual_started");
  level.player _meth_82C0("fade_to_black", 0.05);
  level._id_D127 _id_0BDC::_id_A226();
  scripts\sp\utility::_id_BF95();
}

_id_5FA3() {
  level scripts\engine\utility::delaythread(10.15, ::_id_5FA1);
  level scripts\engine\utility::delaythread(19, ::_id_5FA2);
  wait 1;
  level.player scripts\sp\utility::_id_1034D("shipcrib_plr_efforts");
  wait 0.0;
  level.player thread scripts\sp\utility::_id_1034D("shipcrib_plr_yousetethan");
  wait 0.9;
  level._id_6754 scripts\sp\utility::_id_10346("shipcrib_eth_goodtogosir");
}

_id_5FA1() {
  level._id_13CF0 scripts\engine\utility::delaythread(3.5, _id_10AC::_id_13CED);
  level.player scripts\sp\utility::_id_1034D("shipcrib_plr_thanksat");
  wait 5.6;
  level._id_A6F4 scripts\sp\utility::_id_10346("shipcrib_kls_letsgogreenonth");
}

_id_5FA2() {
  level.player scripts\sp\utility::_id_1034D("shipcrib_plr_youspunupfever");
  level.player scripts\sp\utility::_id_1034D("shipcrib_slt_roghydraulicspr");
  wait 2;
  level.player scripts\sp\utility::_id_1034D("shipcrib_amb_jackal1112tower");
  level.player scripts\sp\utility::_id_1034D("shipcrib_plr_check11");
  level.player scripts\sp\utility::_id_1034D("shipcrib_slt_roger12");
  wait 2.6;
  level.player scripts\sp\utility::_id_1034D("shipcrib_eth_gooddecommoving");
  wait 3.75;
  level.player scripts\sp\utility::_id_1034D("shipcrib_amb_scar11yourelock");
  level.player scripts\sp\utility::_id_1034D("shipcrib_plr_rogerwerelit");
  level.player scripts\sp\utility::_id_1034D("shipcrib_amb_launchin321");
}

_id_A6F5() {
  wait 1.25;
  _id_0B0A::_id_583F(0, 0, 0, 0, 300, 3, 2);
  wait 3;
  _id_0B0A::_id_583F(0, 0, 0, 0, 0, 0, 1);
}

_id_8DE2() {
  wait 0.75;
  _id_0B0A::_id_583F(0, 4096, 6, 0, 300, 3, 0.5);
  wait 0.25;
  _id_0B0A::_id_583F(0, 0, 0, 0, 300, 3, 1.5);
  wait 3.25;
  _id_0B0A::_id_583F(0, 0, 0, 0, 0, 0, 1);
}

_id_D840() {
  level scripts\sp\maps\shipcrib_europa\shipcrib_europa_ambient::_id_408C();
  _id_10A3::_id_3B9E();
  _id_10A2::_id_1A5E();
  _id_10AA::_id_A315(_id_0EFB::_id_FD9C("jackal_service"));
  _id_10A5::_id_5E9A(_id_0EFB::_id_FD9C("dropship_service"));
  level notify("screens_stop_thinking");

  if(scripts\engine\utility::flag("shipcrib_europa_vr_tr_loaded"))
    _id_0F2D::_id_12BA8();

  _id_0EFB::_id_FDCD();
  _id_0EFB::_id_FDBB("all");
  _id_0EFB::_id_FDBB("c12");
  _id_0EFB::_id_FDE8(level._id_FD6E._id_209C);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_5EE3);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_11A55);
  _id_0EFB::_id_FDE7(level._id_FD6E.jackals["hangar_leaving_jackal_move_veh"]);
  level scripts\sp\utility::_id_12651(["shipcrib_europa_dropship_tr", "shipcrib_europa_prime_tr", "shipcrib_europa_prime_in_tr", "shipcrib_europa_mezz_tr", "shipcrib_europa_exterior_tr", "shipcrib_europa_ambient_tr", "shipcrib_europa_ambientmr_tr", "shipcrib_europa_ambientml_tr", "shipcrib_europa_halore_tr", "shipcrib_europa_vr_tr"]);
  scripts\engine\utility::waitframe();

  switch (level._id_FDFA) {
    case "sa_wounded":
    case "sa_vips":
    case "sa_empambush":
    case "sa_assassination":
      level thread scripts\sp\utility::_id_BF97(undefined, undefined, 0);
      break;
  }
}

_id_75C3(var_0) {
  level endon("kill_jackalidle_vfx");
  wait(var_0);
  var_1 = _id_0EE1::_id_7C10("a")._id_A056;
  var_2 = _id_0EE1::_id_7C10("b")._id_A056;
  level._id_764A = scripts\engine\utility::spawn_tag_origin(var_1.origin + (0, 0, -10), var_1.angles);
  level._id_764B = scripts\engine\utility::spawn_tag_origin(var_2.origin + (0, 0, -10), var_2.angles);
  level._id_764A linkTo(var_1);
  level._id_764B linkTo(var_2);
  playFXOnTag(scripts\engine\utility::getfx("vfx_scmoon_jackal_nitrogen_vent"), level._id_764A, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scmoon_jackal_nitrogen_vent"), level._id_764B, "tag_origin");
}

_id_7573() {
  level notify("kill_jackalidle_vfx");

  if(isDefined(level._id_764A)) {
    killfxontag(scripts\engine\utility::getfx("vfx_scmoon_jackal_nitrogen_vent"), level._id_764A, "tag_origin");
    scripts\engine\utility::waitframe();
    level._id_764A delete();
  }

  if(isDefined(level._id_764B)) {
    killfxontag(scripts\engine\utility::getfx("vfx_scmoon_jackal_nitrogen_vent"), level._id_764B, "tag_origin");
    scripts\engine\utility::waitframe();
    level._id_764B delete();
  }
}