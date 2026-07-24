/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\shipcrib_rogue\shipcrib_rogue.gsc
*************************************************************/

main() {
  scripts\sp\utility::_id_1263F("shipcrib_rogue_prime_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_prime_in_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_jackal_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_dropship_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_bridgee_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_bridgem_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_halore_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_mezz_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_bridge_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_exterior_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_jackale_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_hangar_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_vr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_ambient_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_ambientmr_tr");
  scripts\sp\utility::_id_1263F("shipcrib_rogue_ambientml_tr");
  _id_0EFB::_id_FDB2("shipcrib_rogue");
  _id_0EFB::_id_FD77("shipcrib_rogue");
  _id_0EFB::_id_FD73("shipcrib_rogue");
  _id_0EFB::_id_FDAE("shipcrib_rogue");
  var_0 = ["shipcrib_rogue_bridge_tr", "shipcrib_rogue_bridgem_tr", "shipcrib_rogue_bridgee_tr", "shipcrib_rogue_prime_tr", "shipcrib_rogue_prime_in_tr", "shipcrib_rogue_exterior_tr"];
  var_1 = ["shipcrib_rogue_halore_tr", "shipcrib_rogue_exterior_tr", "shipcrib_rogue_bridge_tr", "shipcrib_rogue_prime_in_tr"];
  scripts\sp\utility::_id_F343("rogue start");
  scripts\sp\utility::_id_F344("rogue start alt");
  scripts\sp\utility::_id_1749("pod_return_blockout", ::_id_D624, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("bridge", ::_id_30B6, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("armory", ::_id_224A, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("flight deck", ::_id_6F23, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("rogue start dev", ::_id_E66F, "", undefined, var_0);
  scripts\sp\utility::_id_1749("rogue start", ::_id_E66E, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("rogue start alt", ::_id_E66E, "", undefined, var_1);
  scripts\sp\utility::_id_1749("rogue start sa", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("rogue bridge", ::_id_E66E, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("rogue bridge pre ftl", ::_id_E638, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("rogue lv_elevator", ::_id_E661, "", undefined, level._id_FD6E._id_30B8);
  scripts\sp\utility::_id_1749("rogue armory", ::_id_E615, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("rogue airboss", ::_id_E614, "", undefined, level._id_FD6E._id_224C);
  scripts\sp\utility::_id_1749("rogue dropship", ::_id_E648, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("rogue end", ::_id_E64C, "", undefined, level._id_FD6E._id_8ACB);
  scripts\sp\utility::_id_1749("transient: preload cost sa", ::_id_E64B, "", undefined, var_1);
  scripts\sp\utility::_id_1749("transient: preload cost mainline", ::_id_E64B, "", undefined, var_0);
  scripts\sp\utility::_id_1749("transient: sa free", ::_id_E64B, "", undefined, ["shipcrib_rogue_hangar_tr", "shipcrib_rogue_jackal_tr"]);
  scripts\sp\utility::_id_1749("transient: mainline free", ::_id_E64B, "", undefined, ["shipcrib_rogue_hangar_tr", "shipcrib_rogue_dropship_tr"]);
  scripts\sp\utility::_id_1749("sc_sa_assa", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_sa_emp", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_sa_vips", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_sa_wound", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_asteroid", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_mining", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_spacestation", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_titan", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_1749("sc_ja_wreckage", ::_id_E670, "", undefined, var_1);
  scripts\sp\utility::_id_116CB("shipcrib_rogue");
  scripts\sp\maps\shipcrib_rogue\gen\shipcrib_rogue_art::main();
  scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_fx::main();
  scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_precache::main();
  scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_anim::main();
  scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_lights::main();
  level _id_0EE4::_id_FDDB();
  scripts\sp\load::main();
  _id_FDDE();
  level._id_C67F = _id_0EDE::_id_C67F;
  level._id_E366 = scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_1DBF;
  level._id_13567 = "shipcrib_rogue_vr_tr_loaded";
  level._id_E3FB = "shipcrib_rogue_exterior_tr_loaded";
  level._id_FD69 = _id_10A3::_id_3B9D;
  level._id_FD68 = _id_10A3::_id_3B9E;
  level thread init_flags();
  level thread _id_0EE4::_id_FDAF();
  level thread _id_0EDC::_id_448B();
  level thread _id_0EDC::_id_BBAC();
  level thread _id_0EF0::_id_FD9F();
  level thread _id_10AC::_id_97A5();
  level thread _id_0EF2::_id_9A41();
  level thread _id_0EC5::main();
  level thread _id_0ECF::main();
  level.player _meth_84C7("lastShipcribMission", level.script);
}

_id_FDDE() {
  precacherumble("steady_rumble");
  precacheitem("jackal_mg_projectile_zerog");
  precachemodel("equipment_push_broom_01");
  precachemodel("crates_plastic_tech_01");
  precachemodel("veh_mil_air_un_pocketdrone_alt_wm");
  precachemodel("veh_mil_air_un_pocketdrone");
  precachemodel("viewmodel_base_viewhands_iw7_desert");
  precachemodel("body_hero_protagonist_vm_legs_desert");
  precachemodel("default_character_shadow");
}

init_flags() {
  scripts\engine\utility::flag_init("salter_at_admiral_monitor");
  scripts\engine\utility::flag_init("salter_at_cic");
  scripts\engine\utility::flag_init("player_in_dropship");
  scripts\engine\utility::flag_init("salter_entering_ship");
  scripts\engine\utility::flag_init("salter_in_ship");
  scripts\engine\utility::flag_init("salter_in_seat");
  scripts\engine\utility::flag_init("kash_sent_to_seat");
  scripts\engine\utility::flag_init("kash_at_seat");
  scripts\engine\utility::flag_init("brooks_at_seat");
  scripts\engine\utility::flag_init("omar_at_seat");
  scripts\engine\utility::flag_init("player_at_panel");
  scripts\engine\utility::flag_init("dropship_omar_complete");
  scripts\engine\utility::flag_init("dropship_omar_started");
  scripts\engine\utility::flag_init("dropship_salt_direct_player");
  scripts\engine\utility::flag_init("dropship_launch_complete");
  scripts\engine\utility::flag_init("at_rogue_start");
  scripts\engine\utility::flag_init("start_launch");
  scripts\engine\utility::flag_init("start_launch_pre");
  scripts\engine\utility::flag_init("bridge_setup");
  scripts\engine\utility::flag_init("moving_to_mezz");
  scripts\engine\utility::flag_init("cic_done");
  scripts\engine\utility::flag_init("at_cic");
  scripts\engine\utility::flag_init("brooks_kash_reaction_started");
  scripts\engine\utility::flag_init("brooks_kash_reaction_end");
  scripts\engine\utility::flag_init("brooks_and_kash_can_react");
  scripts\engine\utility::flag_init("gone_in_60");
  scripts\engine\utility::flag_init("dropship_scene_start");
  scripts\engine\utility::flag_init("brooks_kash_salute_player");
  scripts\engine\utility::flag_init("rotate_sky");
  scripts\engine\utility::flag_init("flt_pre_done");
  scripts\engine\utility::flag_init("start_briefing");
  scripts\engine\utility::flag_init("end_bridge_intro");
  scripts\engine\utility::flag_init("c12_scare");
  scripts\engine\utility::flag_init("jackal_taxi_clear");
  scripts\engine\utility::flag_init("sun_outro_intense");
  scripts\engine\utility::flag_init("player_dropship_scene_start");
  scripts\engine\utility::flag_init("airboss_door_scene_start");
  scripts\engine\utility::flag_init("start_panel");
  scripts\engine\utility::flag_init("elevator_scene_done");
}

_id_E64B() {}

_id_D624() {
  wait 2;
  level._id_118A8 = scripts\sp\vehicle::_id_1080E("tigris");
  var_0 = _id_0EFB::_id_798D("pod", "targetname", "origin");
  scripts\sp\utility::_id_11633(var_0);
  level.player playerlinktodelta(var_0, "", 1);
  level.player _meth_823F(var_0);
  var_1 = _id_0EFB::_id_7992("pod", "targetname", "brush");
  var_1 = scripts\engine\utility::array_combine(var_1, _id_0EFB::_id_7992("pod", "targetname", "model"));
  var_1 = scripts\engine\utility::array_add(var_1, _id_0EFB::_id_798D("pod", "targetname", "door"));
  scripts\engine\utility::array_call(var_1, ::linkto, var_0);
  var_2 = getEnt("pod_test_vehicle", "targetname");
  var_0.angles = var_2.angles;
  wait 1;
  var_0 linkTo(var_2);
  var_3 = getvehiclenode(var_2.target, "targetname");
  var_2 vehicle_setspeedimmediate(10, 1, 1);
  var_2 startpath(var_3);
}

_id_30B6() {
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  level._id_EFED = "inside";
  wait 1.0;
  level thread _id_2405();
  _id_11943();
  _id_11942();

  for(;;) {
    _id_11942();
    wait 3.0;
    _id_11944();
    wait 2.0;
  }

  wait 7.0;
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

_id_E66E() {
  _id_E66A();
  var_0 = getEnt("rogue_bridgeelev_player_collision", "targetname");
  var_0 hide();

  if(!isDefined(level.player _meth_84C6("lastCompletedMission"))) {
    level.player _meth_84C7("lastCompletedMission", "titanjackal");
  }

  if(isDefined(level.player _meth_84C6("lastCompletedMission")) && level.player _meth_84C6("lastCompletedMission") == "titanjackal") {
    level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
    _id_0EFB::_id_FDD7();
    level thread _id_E671();
    level _id_0EE4::_id_FDD5();
    _id_E629();
  } else {
    level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_naval");
    _id_0EFB::_id_FDD7();
    level thread _id_E672();
    level thread _id_0EF7::_id_FDE6();
    level _id_0EE4::_id_FDD5();
    level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_1E04();
  }
}

_id_E661() {
  level.player _meth_84C7("lastCompletedMission", "titanjackal");
  level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
  _id_0EFB::_id_FDD7();
  _id_E66A();
  scripts\sp\utility::_id_11633(getEnt("bridge_start", "targetname"));
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_1E04();
  level thread _id_0B21::_id_5A43("bridge_exit", "open");
  level._id_FD6E._id_111D6 = 4;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
  _id_0EF8::_id_FDFC("spawner_salter", "bridge_ai_elevator_doors");
  level._id_EA2C._id_D6E2 = level._id_EA2C _id_0EF1::_id_789F();
  level._id_EA2C._id_D6E0 = _id_0EE5::_id_202D;
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_EA2C scripts\engine\utility::delaycall(0.05, ::_meth_82B0, level._id_EA2C scripts\sp\utility::_id_7DC1("SH6_13_RA_JUMP_XO_scene"), 0.95);
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH6_13_RA_JUMP_XO_scene");
  var_1 = getEnt("rogue_bridgeelev_player_collision", "targetname");
  var_1 show();
  _id_AB12();
}

_id_E671() {
  scripts\sp\utility::_id_13705();
  level thread scripts\sp\utility::_id_12643(["shipcrib_rogue_halore_tr"]);
}

_id_E672() {
  scripts\sp\utility::_id_13705();
  level scripts\sp\utility::_id_12641("shipcrib_rogue_prime_tr");
  level scripts\sp\utility::_id_12641("shipcrib_rogue_bridgem_tr");
  level thread scripts\sp\utility::_id_12643(["shipcrib_rogue_bridgee_tr"]);
}

_id_E670() {
  _id_0EE4::_id_A919();
  _id_E66E();
}

_id_E66F() {
  level.player _meth_84C7("lastCompletedMission", "titanjackal");
  _id_E66E();
}

_id_118C0() {
  var_0 = getEnt("tigris", "targetname");
  var_0._id_ED7C = "idle_light off";
  level._id_118A8 = scripts\sp\vehicle::_id_1080E("tigris")[0];
  wait 0.1;
  level._id_118BE = level._id_118A8 scripts\engine\utility::spawn_script_origin();
  level._id_118A8 linkTo(level._id_118BE);
  level._id_118BE.angles = (0, 15, -10);
  wait 0.1;
  level._id_118BE.origin = (40000, -8000, 1500);
}

_id_E629() {
  thread _id_0B0A::_id_583F(0, 0, 5.181, 0, 200, 4.175, 0);
  thread sc_rogue_dof_fade_down();
  var_0 = getEnt("rogue_bridge_start", "targetname") scripts\engine\utility::spawn_tag_origin();
  var_1 = scripts\common\trace::create_contents(1, 1, 1, 1, 0, 1, 1);
  var_2 = scripts\common\trace::ray_trace(var_0.origin + (0, 0, 30), var_0.origin - (0, 0, 100), var_0, var_1);
  var_3 = var_2["position"];
  var_0.origin = var_3;
  wait 0.05;
  scripts\sp\utility::_id_11633(var_0);
  var_0 scripts\engine\utility::delaycall(0.05, ::delete);
  level.player scripts\sp\utility::_id_F526("normal");
  level.player thread _id_D237();
  level thread _id_118C0();
  level._id_EA2C = _id_0EF8::_id_FDFC("spawner_salter", "rogue_salter_bridge_wait_2");
  level._id_EA2C._id_D6E2 = level._id_EA2C _id_0EF1::_id_789F();
  level._id_EA2C._id_D6E0 = _id_0EE5::_id_202D;
  level._id_EA2C _meth_80F1(level._id_EA2C.origin, vectortoangles(level.player.origin - level._id_EA2C.origin));
  level._id_EA2C thread scripts\sp\interaction::_id_9A3B("stop");
  level._id_EA2C clearpath();
  level._id_EA2C thread _id_0A1E::_id_2307(::_id_EAE4);
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_1E04();
  _id_2FEA();
  _id_E62F();
}

sc_rogue_dof_fade_down() {
  wait 1;
  thread _id_0B0A::_id_583D(2);
}

_id_D237() {
  for(;;) {
    var_0 = level.player.origin;
    wait 0.05;
    var_1 = level.player.origin;
    var_2 = length2d(var_1 - var_0);

    if(var_2 > 1.0) {
      break;
    }
  }

  level._id_EFED = "inside_slow";
  level.player scripts\sp\utility::_id_F526("safe");
}

_id_EAE4() {
  level._id_EA2C thread _id_0B6A::_id_EC06("shipcrib_stand_stationary_talk_idle_01");
  wait 0.1;
}

_id_E638() {
  level.player _meth_84C7("lastCompletedMission", "titanjackal");
  level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
  _id_E66A();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C642();
  var_0 = level._id_C6AA["retribution"]._id_10E52["captain"];
  var_0 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0.origin = var_0.origin + anglesToForward(var_0.angles) * -100;
  scripts\sp\utility::_id_11633(var_0);
  level thread _id_118C0();
  level._id_EA2C = _id_0EF8::_id_FDFC("spawner_salter", level._id_C6AA["retribution"]._id_10E52["xo"]);
  _id_2403();
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_1E04();
  _id_2FEA();
  level thread _id_3A2A();
  level._id_EFED = "inside_slow";
  wait 1.0;
  level._id_76FB thread _id_0B6A::_id_EC0D(level._id_C6AA["retribution"]._id_10E52["nav"], 1);
  level scripts\engine\utility::delaythread(1.0, _id_0EF0::_id_FDA0);
}

_id_E62D() {
  level.player _meth_84C7("lastCompletedMission", "titanjackal");
  level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
  _id_0EFB::_id_FDD7();
  _id_E66A();
  var_0 = level._id_C6AA["retribution"]._id_10E52["captain"];
  var_0 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0.origin = var_0.origin + anglesToForward(var_0.angles) * -100;
  scripts\sp\utility::_id_11633(var_0);
  level._id_EFED = "inside_slow";
  _id_2403();
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_1E04();
  _id_2FEA();
  level thread _id_0EE4::_id_E37A();
  level._id_EA2C = _id_0EF8::_id_FDFC("spawner_salter", level._id_C6AA["retribution"]._id_10E52["xo"]);
  level._id_76FB thread _id_0B6A::_id_EC0D(level._id_C6AA["retribution"]._id_10E52["nav"]);
  level._id_C6AA["retribution"] thread _id_0E46::_id_DFE3();
  level scripts\engine\utility::delaythread(1.0, _id_0EF0::_id_FDA0);
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C698("rogue");
  scripts\engine\utility::waitframe();
  level notify("playanim_monitor_scene");
  _id_3058();
}

_id_E639() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("salter", "vo_sc_rogue_slt_commopatchthead", "patch_him_through", "SH6_2_RA_PRE_XO_admscreen_01");
  level._id_EA2C thread scripts\sp\utility::_id_7792(level.player, 1);
  level waittill("start_salter");
  level._id_EA2C thread scripts\sp\utility::_id_10346("sc_rogue_slt_letsgoreyes");
  level notify("start_bridge_scene");
  level._id_EA2C scripts\engine\utility::delaythread(3.5, scripts\sp\utility::_id_10346, "sc_rogue_slt_captainisontheb");
  level._id_EA2C scripts\engine\utility::delaythread(7.5, scripts\sp\utility::_id_10346, "sc_rogue_slt_rainmandoesntw");
  level thread scripts\sp\utility::_id_C12D("captain_on_bridge", 2.0);
  level._id_EA2C scripts\engine\utility::delaythread(6.5, scripts\sp\utility::_id_779C, level.player);
  level._id_EA2C scripts\engine\utility::delaythread(8.0, scripts\sp\utility::_id_77BD, 1.0);
  var_1 = getstartorigin(var_0.origin, var_0.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("SH6_2_RA_PRE_XO_admscreen_idle_01")[0]);
  var_2 = getstartangles(var_0.origin, var_0.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("SH6_2_RA_PRE_XO_admscreen_idle_01")[0]);
  var_3 = scripts\engine\utility::spawn_tag_origin(var_1, var_2);
  level._id_EA2C.script_pushable = 1;
  level._id_EA2C thread _id_0B6A::_id_EC0B(var_3, "shipcrib_stand_stationary_talk_idle_04", undefined, undefined, undefined, undefined, undefined, 0);
  level._id_EA2C waittill("sceneblock_reach_finished");
  level._id_EA2C.goalradius = 2048;
  level._id_EA2C.script_pushable = 0;
  wait 0.75;
  var_3 delete();
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "SH6_2_RA_PRE_XO_admscreen_idle_01", "stop_loop_salter");
  level._id_EA2C _id_0B6A::_id_EC04();
  scripts\engine\utility::flag_set("salter_at_admiral_monitor");
  level._id_EA2C thread scripts\sp\utility::_id_77B9(0.7);
  scripts\engine\utility::flag_wait("start_briefing");
  var_0 notify("stop_loop_salter");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH6_2_RA_PRE_XO_admscreen_01");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "SH6_2_RA_PRE_XO_admscreen_idle_02", "stop_loop");
  scripts\engine\utility::flag_set("end_bridge_intro");
  level waittill("start_viewer");
  var_0 notify("stop_loop");
  level._id_EA2C thread _id_0EFB::_id_CD3F("opsmap_salter_react");
}

_id_E62A() {
  scripts\engine\utility::flag_wait("start_briefing");
  level waittill("bring_him_up");
  wait 2.0;
  level.player scripts\engine\utility::delaythread(10.0, scripts\sp\utility::_id_1034D, "sc_rogue_plr_yessir");
  level _id_0EF3::_id_FD78("admiral_main", "sc_rogue_world_bridge_adm");
  level notify("end_admiral_convo");
  wait 2.0;
}

_id_E62E() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_1 = level._id_C6AA["retribution"]._id_10E52["nav"];
  level._id_76FB thread _id_0EFB::_id_CD3F("opsmap_conn_react");
  level waittill("captain_on_bridge");
  level._id_76FB _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(level._id_76FB, "SH6_2_RA_PRE_NAV_scene_01");
  level._id_76FB thread _id_0EFB::_id_CD3F("opsmap_conn_react");
  level._id_76FB _id_0EE5::_id_202D(undefined, "sc_rogue_nav_goodtohaveyouba");
}

_id_E63D() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level waittill("start_bridge_scene");
  var_1 = getEnt("bridge_bell", "targetname");
  var_1._id_1FBB = "shipcrib_bell";
  var_1 scripts\sp\anim::_id_F64A();
  var_0 thread scripts\sp\anim::_id_1F35(var_1, "SH6_2_RA_PRE_BSN2_bell_scene_01");
  var_0 scripts\sp\anim::_id_1F35(level._id_1044B, "SH6_2_RA_PRE_BSN2_scene_01");
  level._id_1044B thread scripts\sp\interaction::_id_CD50(level._id_1044B._id_9A30);
  scripts\engine\utility::flag_wait("start_briefing");
  level._id_1044B scripts\engine\utility::delaythread(0.75, scripts\sp\utility::_id_10346, "sc_rogue_bsw_bridgeissealed");
  level._id_1044B _id_0EE5::_id_202D(undefined, "sc_rogue_sip_pettyofficersipesc");
}

_id_E62B() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level waittill("captain_on_bridge");
  wait 3;
  level._id_4451 scripts\sp\utility::_id_10346("sc_rogue_cmo_siradmiralraine");
  level waittill("patch_him_through");
  wait 3.0;
  level._id_4451 scripts\sp\utility::_id_10346("sc_rogue_cmo_checkconnecting");
}

_id_E62C() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_5CFC thread _id_0EFB::_id_CD3F(level._id_5CFC._id_9A30);
  level waittill("captain_on_bridge");
  level._id_5CFC _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(level._id_5CFC, "SH6_2_RA_PRE_DO_scene_01");
  level._id_5CFC thread _id_0EFB::_id_CD3F(level._id_5CFC._id_9A30);
  level._id_5CFC _id_0EE5::_id_202D(undefined, "sc_rogue_dpo_goodtoseeyouback");
}

_id_1065D() {
  var_0 = _id_10AC::_id_107D9("rogue_bridge_welder_01", "welding_high", "welding_sparks_small");
  var_1 = _id_10AC::_id_107D9("rogue_bridge_welder_02", "welding_low", "welding_sparks_small");
  level waittill("start_viewer");
  _id_0EFB::_id_FDBA(var_0);
  _id_0EFB::_id_FDBA(var_1);
}

_id_E62F() {
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(0.5, _id_0EDE::_id_C683, "solar_system", undefined, 0);
  level thread _id_E640();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  level thread _id_0B21::_id_5A43("bridge_exit", "open");
  level thread _id_0B20::_id_5A2E("captains_quarters", "locked");
  level thread _id_0B20::_id_5A2E("bridge", "locked");
  thread _id_1065D();
  level thread _id_E639();
  level thread _id_E62E();
  level thread _id_E62C();
  level thread _id_E62B();
  level thread _id_E62A();
  level thread _id_E63D();
  var_0 = getEnt("rogue_bridge_enter", "targetname");
  thread _id_E663();
  var_0 waittill("trigger");
  level notify("start_salter");
  level waittill("start_bridge_scene");
  level scripts\engine\utility::delaythread(2.0, _id_0EDC::_id_54FA);
  level scripts\engine\utility::delaythread(0.2, ::_id_309C);
  level scripts\engine\utility::delaythread(6.0, ::_id_D7AA);

  for(;;) {
    if(scripts\engine\utility::flag("salter_at_admiral_monitor")) {
      if(distance2d(level.player.origin, level._id_EA2C.origin) <= 200.0) {
        if(scripts\sp\utility::_id_D1DF(level._id_EA2C getEye(), 0.35, 1)) {
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }

  level scripts\engine\utility::delaythread(1.0, _id_0EF0::_id_FDA0);
  level thread _id_D7A9();
  scripts\engine\utility::flag_set("start_briefing");
  scripts\engine\utility::flag_clear("allow_bridge_ffa_move");
  scripts\engine\utility::waitframe();
  level notify("bring_him_up");
  level.player thread scripts\sp\utility::_id_1034D("sc_rogue_plr_bringhimup");
  level waittill("patch_him_through");
  wait 2.0;
  level thread _id_0B20::_id_5A2E("captains_quarters", "unlocked", "aggressive");
  level thread _id_0B20::_id_794A("captains_quarters")._id_5A3F _id_0E46::_id_DFE3();
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3035);
  scripts\engine\utility::flag_wait("end_bridge_intro");
  scripts\engine\utility::flag_set("allow_bridge_ffa_move");
  level thread scripts\sp\interaction_manager::_id_45A7();
  level thread scripts\sp\interaction_manager::_id_F2A7("busy");
  level thread _id_3097();
}

_id_E663() {
  wait 4;
  setmusicstate("mx_357h_rogue_sc_vibe");
}

_id_D7AA() {
  level._id_4451 scripts\sp\interaction_manager::_id_DB7B("sc_rogue_cmo_theadmiralishol");
  scripts\engine\utility::waitframe();
  level thread scripts\sp\interaction_manager::_id_E815(20.0);
}

_id_D7A9() {
  level thread scripts\sp\interaction_manager::_id_11037();
}

_id_3097() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_4451 scripts\sp\interaction_manager::_id_DB7B("sc_rogue_cmo_securetransmiss");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7C("none", "SH6_2_RA_PRE_XO_admscreen_nag", var_0, "SH6_2_RA_PRE_XO_admscreen_idle_02");
  scripts\engine\utility::waitframe();
  level thread scripts\sp\interaction_manager::_id_E815(20.0);
}

_id_30A5() {
  level thread scripts\sp\interaction_manager::_id_11037();
}

_id_3035() {
  level thread _id_E637();
  level _id_0B20::_id_AB71(self, "right_push", 0.4);
}

_id_E637() {
  level notify("enter_quarters");
  wait 2;
  var_0 = scripts\engine\utility::getStruct("quarters_viewer_int", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_2 = var_1.origin + anglesToForward(var_1.angles) * -3.3;
  var_2 = var_2 + anglestoright(var_1.angles) * 0.5;
  var_2 = var_2 + anglestoup(var_1.angles) * 3.1;
  var_1.origin = var_2;
  playFXOnTag(scripts\engine\utility::getfx("vfx_ui_capops_pad_message"), var_1, "tag_origin");
  var_0 thread _id_0E46::_id_48C4(undefined, undefined, &"SHIPCRIB_ROGUE_ANSWER", 30, 175, 70, 1);
  var_0 waittill("trigger");
  level thread _id_30A5();
  wait 0.05;
  level._id_C6AA["retribution"]._id_EF67 notify("stop_salter_loop");
  scripts\engine\utility::waitframe();
  level._id_EA2C thread _id_0EFB::_id_CD3F("opsmap_salter_react");
  level scripts\engine\utility::delaythread(1.0, _id_0B20::_id_5A2E, "captains_quarters", "locked");
  level thread _id_D2F4(var_0);
  level waittill("start_viewer");
  level thread _id_13653();
  stopFXOnTag(scripts\engine\utility::getfx("vfx_ui_capops_pad_message"), var_1, "tag_origin");
  var_1 delete();
  level thread _id_E644();
  level waittill("admiral_capops_done");
  level._id_76FB thread scripts\sp\interaction::_id_9A0F();
  scripts\engine\utility::waitframe();
  level._id_76FB thread _id_0B6A::_id_EC0D(level._id_C6AA["retribution"]._id_10E52["nav"], 1);
  wait 0.5;
  level._id_4451 scripts\sp\utility::_id_10346("sc_rogue_cmo_secureconnectio");
  level.player scripts\sp\utility::_id_1034D("sc_rogue_plr_thankscommo");
  wait 0.5;
  level._id_EA2C thread scripts\sp\utility::_id_10346("sc_rogue_slt_moredetailedrep");
  level thread _id_0EDC::_id_61CE();
  level notify("objective_add_opsmap");
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C642();
  level thread _id_0B20::_id_5A52("captains_quarters", ::_id_3A29);
  level thread _id_0EE4::_id_E378();
}

_id_13653() {
  while(!iscinematicplaying()) {
    wait 0.05;
  }

  for(;;) {
    var_0 = cinematicgettimeinmsec() / 1000;

    if(var_0 >= 14.533) {
      break;
    }

    wait 0.05;
  }

  level.player scripts\sp\utility::_id_1034D("sc_rogue_plr_whatmessageisit");
}

_id_D2F4(var_0) {
  var_1 = scripts\engine\utility::spawn_tag_origin(var_0.origin, (0, 0, 0));
  scripts\engine\utility::waitframe();
  var_2 = _id_0EFB::_id_FE02("player_rig", var_1.origin, var_1.angles);
  var_2 hide();
  var_1 scripts\sp\anim::_id_1EC3(var_2, "shipcrib_rogue_monitor_on_cpn_quarters");
  scripts\engine\utility::waitframe();
  level.player _meth_823C(var_2, "tag_player", 0.5);
  wait 0.55;
  level.player playerlinktodelta(var_2, "tag_player", 0, 0, 0, 0, 0, 1);
  var_2 show();
  level thread scripts\sp\utility::_id_C12D("start_viewer", 2.0);
  level.player scripts\engine\utility::delaythread(2.0, scripts\sp\utility::_id_1034D, "sc_rogue_plr_goaheadadmiral");
  var_1 scripts\sp\anim::_id_1F35(var_2, "shipcrib_rogue_monitor_on_cpn_quarters");
  level.player unlink();
  var_1 delete();
  var_2 delete();
}

_id_E644() {
  level _id_0EF3::_id_FD78("admiral_captains", "sc_rogue_world_capops_hvt");
  wait 1.0;
  level notify("admiral_capops_done");
}

_id_3A29() {
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  level thread scripts\sp\interaction_manager::_id_F2A7("nag", "opsmap");
  level _id_0B20::_id_AB71(self, "right_pull", 0.4);
  level thread _id_3A2A();
  level thread _id_0EF7::_id_E465();
}

_id_C67C() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_EA2C thread _id_0EFB::_id_11004();
  var_0 notify("stop_loop_salter");
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH6_5_RA_POST_GRAV_XO_scene");
  level._id_EA2C thread _id_0EFB::_id_CD3F("opsmap_salter_react");
}

_id_C67B() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("gator", "pvo_sc_rogue_plr_goodflightferra", "safe_flight", "SH6_5_RA_POST_GRAV_NAV_scene");
  level._id_76FB thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(level._id_76FB, "SH6_5_RA_POST_GRAV_NAV_scene");
  level._id_76FB thread _id_0EFB::_id_CD3F("opsmap_gator_react");
}

_id_C679() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_5CFC thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(level._id_5CFC, "SH6_5_RA_POST_GRAV_DO_scene");
  level._id_5CFC thread _id_0EFB::_id_CD3F("opsmap_drops_react");
}

_id_C67E() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level._id_1044B thread scripts\sp\interaction::_id_9A0F();
  var_0 scripts\sp\anim::_id_1F35(level._id_1044B, "SH6_5_RA_POST_GRAV_BSN_scene");
  level._id_1044B thread scripts\sp\interaction::_id_CD50(level._id_1044B._id_9A30);
}

_id_C67A() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  level thread _id_118AD();
  level waittill("safe_flight");
  level thread _id_0EF3::_id_FD78("pip", "sc_world_rogue_ferran_pip");
  level thread _id_118B4();
}

_id_118B4() {
  wait 1.5;
  thread _id_118B5();
  level._id_118A8 _id_0BB8::_id_3991();
  level._id_118A8 detachall();
  level._id_118A8 _id_0BA9::_id_397B();
}

_id_118B5() {
  level._id_118A8 playSound("scn_tigris_ftl_buildup_lr");
  level._id_118A8 waittill("ftl_complete");
  level._id_118A8 playSound("scn_tigris_ftl_out_lr");
}

_id_118AD() {
  var_0 = level._id_118BE.angles + (0, 20, -15);
  level._id_118BE rotateTo(var_0, 8.0, 4.0, 4.0);
}

#using_animtree("player");

_id_3A2A() {
  level._id_76FB scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_10346, "sc_rogue_nav_theopsmapisupda");
  level thread _id_E63E();
  level thread _id_E63F();
  level._id_C6AA["retribution"]._id_C645 = % shipcrib_plr_opsmap_interact_rogue;
  level._id_C6AA["retribution"] waittill("trigger");
  scripts\engine\utility::flag_set("pip_hold");
  level thread scripts\sp\interaction_manager::_id_1100A();
  level notify("stop_narrative");
  level thread _id_C67B();
  level thread _id_C679();
  level thread _id_C67E();
  level thread _id_C67A();
  _id_C67C();
  wait 3.0;
  level._id_C6AA["retribution"]._id_C645 = % shipcrib_plr_opsmap_interact;
  level thread _id_E63E();
  level thread _id_E63F();
  level thread scripts\sp\interaction_manager::_id_45A7();
}

_id_E63E() {
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_rogue_slt_whatsourtarget");
  level._id_76FB scripts\sp\interaction_manager::_id_DB7B("sc_rogue_nav_illplotacourse");
  level._id_76FB thread _id_0EE5::_id_202D();
  level._id_EA2C thread _id_0EE5::_id_202D(undefined, "sc_rogue_slt_whateveryouandt");
  var_0 = ["sc_rogue_dpo_dropsarepushing", 0.15, "sc_rogue_nav_nothingwecanth"];
  level._id_5CFC scripts\sp\interaction_manager::_id_DB71(var_0);
  level._id_4451 thread _id_0EE5::_id_202D(undefined, "sc_rogue_cmo_clearsignals");
  scripts\engine\utility::waitframe();
  level thread scripts\sp\interaction_manager::_id_E815(20.0);
  level._id_5CFC thread scripts\sp\interaction_manager::_id_CD27(85.0, 50.0);
}

_id_E63F() {
  level scripts\engine\utility::waittill_any("mission_selected", "stop_narrative");
  level thread scripts\sp\interaction_manager::_id_11037();
  level._id_5CFC thread scripts\sp\interaction_manager::_id_10FF9();
}

_id_E634() {
  if(!level.console) {
    while(!scripts\engine\utility::flag(level.script + "_bridgee_tr_loaded")) {
      waitforalltransients();
      wait 0.15;
    }
  }

  _id_0EDB::early_out_broadcast();
  scripts\sp\interaction_manager::_id_C9C4();
  _id_0B20::_id_AB71(self, "left_pull", 0.4, undefined);
  level thread _id_0B20::_id_5A52("bridge", ::_id_307F);
}

_id_307F() {
  level _id_0B20::_id_AB71(self, "left_push", 0.4);
  scripts\sp\interaction_manager::_id_45A9();
  level thread _id_0B20::_id_5A52("bridge", ::_id_3080);
  setmusicstate("");
}

_id_3080() {
  scripts\sp\interaction_manager::_id_C9C4();
  level _id_0B20::_id_AB71(self, "left_pull", 0.4);
  level thread _id_0B20::_id_5A52("bridge", ::_id_307F);
}

_id_E633() {
  level endon("ftl_scene_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  thread scripts\sp\utility::_id_F3DC(level._id_C6AA["retribution"]._id_10E52["xo"].origin);
  scripts\sp\anim::_id_17FC("salter", "playanim_nav_attention", "playanim_nav_attention", "SH6_6_RA_MISSION_RS_XO_FORWARD");
  scripts\engine\utility::flag_set("allow_bridge_ffa_move");
  level thread _id_0E78::main();
  thread _id_0EFB::_id_11004();
  _id_0B6A::_id_EC04();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_6_RA_MISSION_XO_intro");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH6_6_RA_MISSION_XO_idle", "stop_salter_loop");
  level notify("salter_cic");
  scripts\engine\utility::flag_set("salter_at_cic");
  scripts\engine\utility::flag_wait("at_cic");
  var_1 = getanimlength(level._id_EA2C scripts\sp\utility::_id_7DC1("SH6_6_RA_MISSION_XO_briefing"));
  var_0 notify("stop_salter_loop");
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_6_RA_MISSION_XO_briefing");
  thread scripts\sp\interaction::_id_CD4D("salter_cic_ra_blended_react");
  scripts\engine\utility::waitframe();
  thread scripts\sp\interaction_manager::_id_12753();
  self waittill("interaction_done");
  level notify("playanim_nav_attention");
  scripts\engine\utility::flag_set("cic_done");
  var_0 thread scripts\sp\anim::_id_1F35(self, "SH6_6_RA_MISSION_XO_briefing_exit");
  self waittill("anim_end_goal_done");
  _id_0B6A::_id_EC0A(level._id_C6AA["retribution"]._id_10E52["xo"]);
  level notify("salter_at_ops");
  thread _id_0EE5::_id_202D(undefined, "sc_rogue_slt_thiscantberight");
}

_id_E631() {
  level endon("ftl_scene_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("gator", "playanim_monitor_scene", "playanim_monitor_scene", "SH6_6_RA_MISSION_NAV_intro");
  level thread _id_E632();
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_6_RA_MISSION_NAV_intro");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
  level waittill("playanim_nav_attention");
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_6_RA_MISSION_NAV_attention");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
}

_id_E632() {
  level endon("ftl_scene_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 scripts\sp\anim::_id_1EC3(level._id_C6AA["retribution"]._id_BA11["nav"], "SH6_6_RA_MISSION_MONITOR_intro");
  level waittill("playanim_monitor_scene");
  var_0 scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH6_6_RA_MISSION_MONITOR_intro");
}

_id_E630() {
  level endon("ftl_scene_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_6_RA_MISSION_DO_intro");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
}

_id_E636() {
  level endon("ftl_scene_start");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  thread scripts\sp\interaction::_id_9A0F();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_6_RA_MISSION_BSN_intro");
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH6_6_RA_MISSION_BSN_idle", "stop_sotomura_loop");
}

_id_E63B() {
  level notify("mission_selected");
  level thread _id_0B20::_id_5A52("armory", ::_id_223D);
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A78);
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  wait 0.05;
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C683("calculation", "rogue");
  wait 0.15;
  level thread _id_0EE4::_id_E381("sc_rogue_world_cic_briefing", ::_id_304F);
  level._id_EA2C thread _id_E633();
  level._id_76FB thread _id_E631();
  level._id_5CFC thread _id_E630();
  level._id_1044B thread _id_E636();
  level thread _id_0EE4::_id_E37A();
  scripts\engine\utility::flag_wait("salter_at_cic");
  level thread _id_3060();
  level thread _id_0EEE::_id_FD8B(1);
  level thread scripts\sp\interaction_manager::_id_F2A7("nag", "cic");

  for(;;) {
    if(distance2d(level.player.origin, level._id_EA2C.origin) <= 200.0) {
      if(scripts\sp\utility::_id_D1DF(level._id_EA2C getEye(), 0.5, 1)) {
        scripts\engine\utility::flag_set("at_cic");
        break;
      }
    }

    scripts\engine\utility::waitframe();
  }

  level thread _id_3061();
  level notify("shipcrib_play_cic_briefing");
}

_id_3060() {
  level thread scripts\sp\interaction_manager::_id_45A7();
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_rogue_slt_letsgeteyesont");
  level._id_76FB _id_0EE5::_id_202D(undefined, "sc_rogue_gtr_plottingacourset");
  level._id_5CFC _id_0EE5::_id_202D(undefined, "sc_rogue_dpo_lookingatoptimal");
  level._id_4451 _id_0EE5::_id_202D(undefined, "sc_rogue_cmo_nocommswithvesta");
  level thread scripts\sp\interaction_manager::_id_E815(90.0);
}

_id_3061() {
  level thread scripts\sp\interaction_manager::_id_11037();
}

_id_304F() {
  scripts\engine\utility::flag_set("salter_at_cic");
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  scripts\engine\utility::flag_wait("cic_done");
  stopcinematicingame();
  level._id_C6AA["retribution"]._id_2AE2 show();
  wait 2.0;
  level thread _id_3058();
  level thread _id_3059();
}

_id_3F6C() {
  level waittill("cic_done");
  scripts\engine\utility::flag_set("cic_done");
}

_id_3059() {
  level thread scripts\sp\interaction_manager::_id_45A7();
  level._id_5CFC scripts\sp\interaction_manager::_id_DB7B("sc_rogue_dpo_weneedyouhereco.");
  level._id_76FB _id_0EE5::_id_202D(undefined, "sc_rogue_gtr_doesntmakeany");
  level._id_4451 _id_0EE5::_id_202D(undefined, "sc_rogue_cmo_stillnocontact");
  level._id_1044B _id_0EE5::_id_202D(undefined, "sc_rogue_sip_isthereaproblem");
  level._id_5CFC _id_0EE5::_id_202D();
  scripts\engine\utility::waitframe();
  level thread scripts\sp\interaction_manager::_id_E815(90.0);
  level thread scripts\sp\interaction_manager::_id_F2A7("busy");
}

_id_305A() {
  level thread scripts\sp\interaction_manager::_id_11037();
}

_id_E657() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("salter", "vo_sc_rogue_slt_allhandsdropsta", "all_hands", "SH6_13_RA_JUMP_XO_scene");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_rogue_slt_jumpin321", "jump_in321", "SH6_13_RA_JUMP_XO_scene");
  scripts\sp\anim::_id_17FC("salter", "violent_shift", "violent_shift", "SH6_13_RA_JUMP_XO_scene");
  scripts\sp\anim::_id_17FC("salter", "pvo_sc_rogue_plr_niceworkeveryon", "nice_work", "SH6_13_RA_JUMP_XO_scene");
  scripts\sp\anim::_id_17FC("salter", "pvo_sc_rogue_plr_boatswaintellom", "unlock_doors", "SH6_13_RA_JUMP_XO_scene");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_rogue_slt_yourcall", "your_call", "SH6_13_RA_JUMP_XO_scene");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_rogue_slt_uvfilterspolari", "tinted_glass", "SH6_13_RA_JUMP_XO_scene");
  scripts\sp\anim::_id_17FC("salter", "playanim_phone_scene", "phone_anim", "SH6_13_RA_JUMP_XO_scene");
  scripts\sp\anim::_id_17FC("salter", "first_alarm", "first_alarm", "SH6_13_RA_JUMP_XO_scene");
  level thread _id_EA80();
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_7_RA_BRIEF_XO_scene");
  scripts\sp\utility::_id_F3DC(scripts\engine\utility::getStruct("bridge_ai_elevator_doors", "targetname").origin);
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_13_RA_JUMP_XO_scene");
  level notify("salter_exit_bridge");
}

_id_E653() {
  level waittill("brief_done");
  wait 2;
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C683("ftl", "rogue");
  level waittill("ftl_finished");
  wait 8;
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C696();
}

_id_EA80() {
  level waittill("phone_anim");
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_CACE["xo"], "SH6_13_RA_JUMP_PHONE_scene");
}

_id_E651() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("gator", "vo_sc_rogue_nav_shipisprimewer", "ship_is_primed", "SH6_13_RA_JUMP_NAV_scene");
  scripts\sp\anim::_id_17FC("gator", "vo_sc_rogue_bsw_roger", "roger_polarize", "SH6_13_RA_JUMP_NAV_scene");
  scripts\sp\anim::_id_17FC("gator", "playanim_bsn_scene", "playanim_bsn_scene", "SH6_13_RA_JUMP_NAV_scene");
  scripts\sp\anim::_id_17FC("gator", "playanim_monitor_scene", "playanim_monitor_scene", "SH6_13_RA_JUMP_NAV_scene");
  level thread _id_E652();
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_7_RA_BRIEF_NAV_scene");
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_13_RA_JUMP_NAV_scene");
  thread _id_0EFB::_id_CD3F(self._id_9A30);
  level waittill("unlock_doors");
  wait 7.5;
  scripts\sp\utility::_id_10346("sc_rogue_nav_ayesirunlockthe");
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_13_RA_JUMP_NAV_ops_to_con");
  thread _id_0EFB::_id_CD3F("opsmap_conn_react_alert");
  thread _id_0EE5::_id_202D();
}

_id_E652() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 scripts\sp\anim::_id_1EC3(level._id_C6AA["retribution"]._id_BA11["nav"], "SH6_13_RA_JUMP_MONITOR_scene");
  level waittill("playanim_monitor_scene");
  var_0 scripts\sp\anim::_id_1F35(level._id_C6AA["retribution"]._id_BA11["nav"], "SH6_13_RA_JUMP_MONITOR_scene");
}

_id_E65A() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_7_RA_BRIEF_BSN_scene");
  thread scripts\sp\interaction::_id_CD50("opsmap_boats_react");
  level waittill("playanim_bsn_scene");
  _id_0EFB::_id_11004();
  thread scripts\sp\interaction::_id_CD50("opsmap_boats_react");
  thread _id_0EE5::_id_202D();
}

_id_E650() {
  var_0 = level._id_C6AA["retribution"]._id_EF67;
  scripts\sp\anim::_id_17FC("drop_officer", "vo_sc_rogue_dpo_influxin321", "ftl_3_sec_left", "SH6_13_RA_JUMP_DO_scene");
  scripts\sp\anim::_id_17FC("drop_officer", "vo_sc_rogue_bsw_confirmedvesta3", "following_asteroid", "SH6_13_RA_JUMP_DO_scene");
  thread _id_0EFB::_id_11004();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_7_RA_BRIEF_DO_scene");
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_13_RA_JUMP_DO_scene");
  thread _id_0EFB::_id_CD3F("opsmap_drops_react_alert");
  thread _id_0EE5::_id_202D();
}

_id_E64F() {
  level waittill("unlock_doors");
  thread scripts\sp\interaction::_id_CD50("opsmap_comms_react_alert");
  thread _id_0EE5::_id_202D();
}

_id_20F7() {
  level waittill("following_asteroid");
  level.player thread scripts\sp\utility::play_sound_on_entity("ui_sc_rogue_asteroid_popup");
  level._id_23FD thread scripts\sp\utility::_id_918B("ar_callouts_vesta3");
  wait 7.0;
  level._id_23FD thread scripts\sp\utility::_id_918C();
}

_id_E654() {
  scripts\sp\anim::_id_17FC("player_rig", "lets_leap", "lets_leap", "shipcrib_rogue_player_ftl_brief");
  var_0 = level._id_C6AA["retribution"]._id_EF68;
  var_1 = level._id_C6AA["retribution"];
  var_2 = % shipcrib_rogue_player_ftl_brief;
  level.player playerlinkTo(var_1._id_1339A, "tag_player");
  level.player _meth_823C(var_1._id_1339A, "tag_player", 0.05);
  var_1._id_1339A.origin = getstartorigin(var_1._id_EF68.origin, var_1._id_EF68.angles, var_2);
  var_1._id_1339A.angles = getstartangles(var_1._id_EF68.origin, var_1._id_EF68.angles, var_2);
  var_1._id_1339A clearanim(%opsmap, 0);
  var_1._id_1339A _meth_82E2("single anim", var_2, 1, 0, 0);
  var_1._id_1339A thread scripts\sp\anim::_id_10CBF(var_1._id_1339A, "single anim");
  var_1._id_1339A thread scripts\sp\anim::_id_1FCA(var_1._id_1339A, "single anim");
  wait 0.1;
  level notify("ftl_linkto_done");
  level.player playerlinktodelta(var_1._id_1339A, "tag_player", 1.0, 15, 15, 15, 0, 1);
  level.player _meth_8392(0.2, 2.2, 0.6);
  level notify("player_ftl_ready");
  var_1._id_1339A _meth_82B1(var_2, 1);
  wait(getanimlength(var_2));
  level notify("brief_done");
  level scripts\engine\utility::delaythread(getanimlength(var_1._id_1339A scripts\sp\utility::_id_7DC1("shipcrib_rogue_player_ftl")) - 1.0, ::show_floaters);
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C658("shipcrib_rogue_player_ftl_keycard");
  var_0 scripts\sp\anim::_id_1F35(var_1._id_1339A, "shipcrib_rogue_player_ftl");
  level.player unlink();
  var_1._id_1339A hide();
  level waittill("nice_work");
  wait 1.0;
  level.player thread scripts\sp\utility::_id_1034D("sc_rogue_plr_boatswaintellom");
  level notify("unlock_doors");
}

hide_floaters() {
  if(isDefined(level._id_30BD)) {
    level._id_30BD hide();
  }

  if(isDefined(level._id_30C2)) {
    level._id_30C2 hide();
  }
}

show_floaters() {
  if(isDefined(level._id_30BD)) {
    level._id_30BD thread _wait_show_floater();
  }

  if(isDefined(level._id_30C2)) {
    level._id_30C2 thread _wait_show_floater();
  }
}

_wait_show_floater() {
  self endon("death");
  self endon("entitydeleted");

  for(;;) {
    if(!scripts\engine\utility::within_fov(level.player getEye(), level.player.angles, self.origin, cos(45))) {
      break;
    }

    wait 0.05;
  }

  self show();
}

_id_E655() {
  var_0 = level._id_C6AA["retribution"]._id_EF68;
  var_1 = level._id_C6AA["retribution"]._id_454F["captain"];
  var_1._id_1FBB = "shipcrib_cap_console";
  level waittill("lets_leap");
  var_1 scripts\sp\anim::_id_1EC3(var_1, "shipcrib_rogue_player_ftl_table");
  level waittill("brief_done");
  var_1 scripts\sp\anim::_id_1F35(var_1, "shipcrib_rogue_player_ftl_table");
}

_id_3058() {
  level thread scripts\sp\utility::_id_12651(["shipcrib_rogue_halore_tr"]);
  level thread scripts\sp\utility::_id_12643(["shipcrib_rogue_vr_tr", "shipcrib_rogue_mezz_tr", "shipcrib_rogue_hangar_tr", "shipcrib_rogue_ambient_tr", "shipcrib_rogue_ambientml_tr"]);
  hide_floaters();
  level thread scripts\sp\interaction_manager::_id_11037();
  level thread _id_0EE4::_id_E37A();
  level._id_C6AA["retribution"] thread _id_0EDE::_id_C66C();
  thread _id_0EEE::_id_25B2();
  level thread _id_0EEE::_id_FD8B(1);
  level._id_C6AA["retribution"] scripts\engine\utility::delaythread(2.0, _id_0EDE::_id_C683, "all_off", "rogue");
  level thread _id_E654();
  level waittill("ftl_linkto_done");
  level notify("ftl_scene_start");
  scripts\engine\utility::flag_clear("allow_bridge_ffa_move");
  _id_0EF0::pause_group_vignettes();
  level thread _id_305A();
  level._id_EA2C thread _id_E657();
  level._id_76FB thread _id_E651();
  level._id_1044B thread _id_E65A();
  level._id_5CFC thread _id_E650();
  level._id_4451 thread _id_E64F();
  level thread _id_20F7();
  level thread _id_7474();
  level thread _id_E653();
  level thread _id_E655();
  level notify("at_ops");
  level thread _id_7490();
  level waittill("brief_done");
  level thread _id_7484();
  scripts\engine\utility::flag_set("flt_pre_done");
  level waittill("all_hands");
  level waittill("ship_is_primed");
  level thread _id_0EEE::_id_FD89("rogue", "retribution", undefined, ::_id_4947, 7.25);
  level.player._id_E7D1 scripts\engine\utility::delaythread(7.0, ::_id_902F, 1, 0.1, 2);
  level waittill("violent_shift");
  earthquake(0.5, 2, level.player.origin, 100000);
  level.player._id_E7D1 thread _id_902F(1, 0.1, 2);
  level waittill("ftl_3_sec_left");
  wait 3.0;
  level notify("ftl_stop");
  wait 0.5;
  level thread scripts\sp\interaction_manager::_id_F2A7("nag", "bridge_elev");
  level thread _id_0EEE::_id_FD8A(1);
  _id_0EF0::release_group_vignettes();
  level thread _id_305F();
}

_id_7484() {
  level notify("ftl triggered");
  wait 0.05;
  level notify("start_group_vignette");
}

_id_7490() {
  while(iscinematicplaying()) {
    wait 0.05;
  }

  stopcinematicingame();
  level._id_C6AA["retribution"] _id_0EDE::_id_C678("sc_rogue_world_opsmap_rad_trail");
  scripts\engine\utility::waitframe();
}

_id_7474() {
  level waittill("jump_in321");
  wait 6.0;
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("shipcrib_rogue_ftl_alarm_2");
  level waittill("violent_shift");
  level.player thread scripts\engine\utility::play_loop_sound_on_entity("shipcrib_rogue_ftl_alarm_3");
  level waittill("ftl_stop");
  level.player scripts\engine\utility::stop_loop_sound_on_entity("shipcrib_rogue_ftl_alarm_3");
  level waittill("stop_ftl_alarms");
  level.player scripts\engine\utility::stop_loop_sound_on_entity("shipcrib_rogue_ftl_alarm_2");
}

_id_305F() {
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  var_0 = getEnt("rogue_bridgeelev_player_collision", "targetname");
  var_0 show();
  level waittill("roger_polarize");
  wait 1.5;
  level notify("stop_ftl_alarms");
  level waittill("nice_work");
  level waittill("unlock_doors");
  scripts\engine\utility::flag_set("allow_bridge_ffa_move");
  wait 1.0;
  level thread _id_0B21::_id_5A43("bridge_exit", "open");
  level thread _id_305B();
  level _id_AB12();
}

_id_305B() {
  wait 0.1;
  level.player scripts\sp\utility::_id_1034D("sc_rogue_plr_saltyourwithme");
  wait 0.1;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_rogue_slt_youknowit");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_rogue_slt_letsknockthiso");
  scripts\engine\utility::waitframe();
  level thread scripts\sp\interaction_manager::_id_E815(20.0);
}

_id_305D() {
  level thread scripts\sp\interaction_manager::_id_11037();
}

_id_A5E3() {}

_id_4947() {
  wait 0.75;
  level thread _id_495F();
  level._id_23FD = getEnt("asteroid_rogue", "targetname");
  level._id_23FD show();
  level thread _id_BC39();
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
  wait 0.2;
}

_id_4930() {
  if(isDefined(level._id_111C3)) {
    stopFXOnTag(scripts\engine\utility::getfx("vfx_sc_ra_sun_mainsystem_01"), level._id_111C3, "tag_origin");
    level._id_111C3 delete();
  }

  level._id_111C3 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  var_0 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 90, -90));
  level._id_111C3 show();
  var_0 linkTo(level._id_111C3);
  playFXOnTag(scripts\engine\utility::getfx("rogue_sun_sprite"), var_0, "tag_origin");
  level._id_111C3.angles = (90, 1, 0);
  level._id_111C3.origin = level._id_111C3.origin + anglestoup(level._id_111C3.angles) * 300000;
  var_1 = level._id_111C3.origin + anglestoup(level._id_111C3.angles) * -30000;
  level._id_111C3 moveTo(var_1, 0.2, 0.0, 0.1);
  wait 0.2;
  level._id_23F7 dontcastdistantshadows();
  level._id_23FE dontcastdistantshadows();
}

_id_BC39() {
  level endon("stop_starting_sky_rot");
  level._id_23FD castdistantshadows();
  level._id_23FD castshadows();
  var_0 = scripts\engine\utility::getStruct("asteroid_sm_dest", "targetname").origin + (0, -15000, 2000);
  level._id_23FD.origin = var_0 + (0, -40000, 20000);
  level thread _id_E71F();
  var_1 = scripts\engine\utility::spawn_tag_origin(level._id_23FD.origin);
  var_1.angles = (0, 30, -90);
  var_2 = scripts\engine\utility::spawn_tag_origin(level._id_23FD.origin);
  var_2 linkTo(level._id_23FD);
  var_3 = scripts\engine\utility::spawn_tag_origin(level._id_23FD.origin);
  var_4 = scripts\engine\utility::spawn_tag_origin(level._id_23FD.origin);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_planet_rogue_asteroid_main"), var_1, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_trail"), var_2, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_follow"), var_3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_follow_2"), var_4, "tag_origin");
  scripts\engine\utility::waitframe();
  var_1 moveTo(var_0, 20.0, 0.0, 5.0);
  var_1 rotateTo((0, 5, 0), 20.0);
  var_3 moveTo(var_0, 20.0, 0.0, 5.0);
  var_3 rotateTo((-90, 5, 0), 20.0);
  var_4 moveTo(var_0, 20.0, 0.0, 5.0);
  var_4 rotateTo((-90, 5, 0), 20.0);
  level._id_23FD moveTo(var_0, 20.0, 0.0, 5.0);
  scripts\engine\utility::waitframe();

  for(;;) {
    var_1 rotateTo(var_1.angles + (0, 0, 90), 20.0);
    var_3 rotateTo(var_3.angles + (0, 30, 30), 20.0);
    var_4 rotateTo(var_3.angles + (0, 10, 10), 22.0);
    level._id_23FD rotateTo(level._id_23FD.angles + (0, 90, 90), 20.0);
    wait 20.0;
  }
}

_id_19D4(var_0, var_1) {
  _id_0B6A::_id_EC0A(var_0);
  scripts\engine\utility::flag_set(var_1);
}

_id_19C6(var_0, var_1, var_2) {
  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    if(var_3 != var_0.size - 1) {
      thread _id_0B6A::_id_EC0A(var_0[var_3]);

      for(;;) {
        if(distance2d(self.origin, _id_0EFB::_id_7D7A(var_0[var_3]).origin) <= var_1) {
          break;
        }

        scripts\engine\utility::waitframe();
      }
    }
  }

  _id_0B6A::_id_EC0A(var_0[var_0.size - 1]);
  scripts\engine\utility::flag_set(var_2);
}

_id_E640() {
  var_0 = getEnt("rogue_bridge_secure", "targetname");
  var_0 waittill("trigger");
  wait 1.0;
  scripts\engine\utility::flag_wait("start_briefing");
  level thread _id_0EE4::_id_E37A();
}

_id_2FEA() {
  var_0 = _id_0EF8::_id_FDFC("spawner_gator", level._id_C6AA["retribution"]._id_10E52["captain"]);
  var_0._id_D6E2 = var_0 _id_0EF1::_id_789F();
  var_0._id_D6E0 = _id_0EE5::_id_202D;

  if(!isDefined(level._id_1044B)) {
    var_0 = _id_0EF8::_id_FDFC("spawner_sotomura", "homebase");
    var_0._id_10C01 = var_0._id_907D;
    var_0._id_D6E2 = var_0 _id_0EF1::_id_789F();
    var_0._id_D6E0 = _id_0EE5::_id_202D;
  } else
    level._id_1044B _id_0B6A::_id_EC0D(var_0._id_907D, 1);

  var_0 = _id_0EF8::_id_FDFC("spawner_comms", "homebase");
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
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys3", _id_0EFB::_id_EFDB("sysend"));
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys1", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  var_0 = _id_0EF8::_id_FDFC("spawner_bridge_sys2", "homebase", "cheap");
  var_0._id_10C01 = var_0._id_907D;
  level scripts\engine\utility::delaythread(0.5, scripts\sp\interaction_manager::_id_F2A7, "busy");
  scripts\engine\utility::flag_set("bridge_setup");
  level._id_30BD scripts\engine\utility::delaythread(1.0, ::_id_30A0);
  level._id_30C2 scripts\engine\utility::delaythread(1.0, ::_id_30A1);
}

_id_309C() {
  level._id_3014 thread _id_309B(undefined, undefined, "shipcrib_brdg_srvr1_salute_01");
  level._id_3015 thread _id_309B(undefined, undefined, "shipcrib_brdg_srvr2_salute_01");
  level._id_3016 thread _id_309B(undefined, undefined, "shipcrib_brdg_srvr1_salute_01");
  level._id_30C4 thread _id_309B(undefined, undefined, "shipcrib_brdg_door1_salute_01");
}

_id_30A0() {
  self endon("death");
  self endon("stop_ffa");
  thread _id_10AB::_id_300D();
}

_id_30A1() {
  self endon("death");
  self endon("stop_ffa");
  thread _id_10AB::_id_300F();
}

_id_309B(var_0, var_1, var_2) {
  self endon("death");

  if(!isDefined(var_0)) {
    var_0 = 0.0;
  }

  if(!isDefined(var_1)) {
    var_1 = 0.2;
  }

  wait(randomfloatrange(var_0, var_1));
  scripts\sp\interaction_manager::_id_11048();
  scripts\engine\utility::waitframe();
  scripts\sp\anim::_id_1EC7(self, var_2);

  if(isDefined(self._id_10C01)) {
    if(isDefined(self._id_9A30) && issubstr(self._id_9A30, "opsmap")) {
      thread scripts\sp\interaction::_id_CD50(self._id_9A30);
    } else {
      thread scripts\sp\interaction_manager::_id_CE40(self._id_10C01._id_EE92, undefined, "busy");
    }
  }
}

_id_902F(var_0, var_1, var_2) {
  level.player._id_E7D1 scripts\sp\utility::_id_E7C9(var_0, 0.5);
  wait(var_1);
  level.player._id_E7D1 scripts\sp\utility::_id_E7C7(var_2);
}

_id_2FEE(var_0, var_1, var_2) {
  if(isDefined(var_1)) {
    var_1 thread scripts\sp\utility::_id_10347(var_0);
  }

  var_3 = getEntArray(var_2, "targetname");

  for(var_4 = 0; var_4 < var_3.size; var_4++) {
    if(var_4 + 1 == var_3.size) {
      var_3[var_4] scripts\sp\utility::_id_10347(var_0);
      continue;
    }

    var_3[var_4] thread scripts\sp\utility::_id_10347(var_0);
  }
}

_id_11943() {
  level._id_11940 = getEnt("tinted_glass", "targetname");
  level._id_11941 = getEnt("tinted_glass_capops", "targetname");
  level._id_11940.partnerheli = scripts\sp\utility::_id_7CCC(level._id_11940.model);
}

_id_11942() {
  for(var_0 = 1; var_0 < level._id_11940.partnerheli.size; var_0++) {
    level._id_11940 hidepart("j_panel_" + var_0);
    wait 0.05;
  }

  level._id_11941 hide();
}

_id_11944() {
  for(var_0 = 1; var_0 < level._id_11940.partnerheli.size; var_0++) {
    level._id_11940 showpart("j_panel_" + var_0);
    wait 0.05;
  }

  level._id_11941 show();
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

_id_AB12() {
  _id_EA87();
  thread _id_EABE();
  _id_0EEB::_id_7976("bridge").trigger waittill("trigger");
  level notify("lv_elevator_starting");
  level thread _id_0EE6::_id_2201();
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6("none");
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A6();

  if(!level.console) {
    waitforalltransients();
  }

  _id_0EEB::_id_60F0("bridge", 58);
  _id_0EEB::_id_60FD("bridge", "Mezzanine");
  scripts\engine\utility::flag_set("moving_to_mezz");
  setsaveddvar("sm_sundynamics", "0");
  setsaveddvar("sm_sunsamplesizenear", 1.75);
  lerpsunangles((-28, 2, 0), (-14, -6, 0), 2);
  thread _id_AB10();
  thread _id_2207();
  thread _id_305D();
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_1E0A();
  var_0 = getEnt("rogue_bridgeelev_player_collision", "targetname");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  _id_0EEB::_id_7976("bridge") waittill("move_finished");
  level notify("kill_bridge_ai");
  level thread _id_0B21::_id_5A43("mezzanine_elevator", "open");
  _id_0EFB::_id_FDBA(level._id_76FB);
  level thread scripts\sp\utility::_id_12651(["shipcrib_rogue_bridge_tr", "shipcrib_rogue_bridgem_tr"]);
  level thread scripts\sp\utility::_id_12643(["shipcrib_rogue_dropship_tr"]);
}

_id_EA87() {
  level._id_EA2C thread _id_0B6A::_id_EC0A("bridge_ai_elevator_doors");
  var_0 = scripts\engine\utility::getStruct("bridge_ai_elevator_doors", "targetname");

  for(;;) {
    if(distance2d(level._id_EA2C.origin, var_0.origin) <= 150.0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  var_1 = _id_0EEB::_id_7976("bridge") scripts\engine\utility::spawn_tag_origin();
  var_1.angles = var_1.angles + (0, 180, 0);
  var_2 = getstartorigin(var_1.origin, var_1.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("SH6_14_RA_ELEV_XO_pcap"));
  var_3 = getstartangles(var_1.origin, var_1.angles, level._id_EA2C scripts\sp\utility::_id_7DC1("SH6_14_RA_ELEV_XO_pcap"));
  var_4 = scripts\engine\utility::spawn_tag_origin(var_2, var_3);
  var_1 delete();
  level._id_EA2C _id_0B6A::_id_EC0A(var_4, undefined, undefined, undefined, undefined, 1);
  level._id_EA2C scripts\sp\utility::_id_7799(level.player);
  var_4 delete();
  level notify("salter_in_elev");
}

_id_EABE() {
  level endon("lv_elevator_starting");
  wait 10;

  while(distance2d(_id_0EEB::_id_7976("bridge").origin, level.player.origin) < 250) {
    scripts\engine\utility::waitframe();
  }

  level._id_EA2C thread scripts\sp\utility::_id_10346("sc_rogue_slt_letsknockthiso");
}

_id_AB10() {
  level endon("armory_started");
  level._id_EA2C notify("stop_loop");
  level._id_EA2C thread _id_0EFB::_id_11004();
  var_0 = _id_0EEB::_id_7976("bridge") scripts\engine\utility::spawn_tag_origin();
  var_0.angles = var_0.angles + (0, 180, 0);
  var_0 linkTo(_id_0EEB::_id_7976("bridge"));
  level._id_EA2C linkTo(var_0);
  var_0 scripts\sp\anim::_id_1F35(level._id_EA2C, "SH6_14_RA_ELEV_XO_pcap");
  level._id_EA2C unlink();
  var_0 delete();
  level._id_EA2C _id_0B6A::_id_EC0B("armory_ai_wait", "shipcrib_stand_stationary_talk_idle_02", undefined, undefined, undefined, undefined, undefined, 1);
  level._id_EA2C thread _id_0EE5::_id_202D("stand_idle_2_back_reaction", "sc_rogue_slt_letsknockthiso");
}

_id_F70B(var_0, var_1) {
  self waittill(var_1);
  scripts\engine\utility::flag_set(var_0);
}

_id_2207() {
  _id_1063E();
}

_id_1063E() {
  var_0 = _id_10AC::_id_107D9("rogue_armoryhall_ai_start1", "welding_low");
  var_1 = _id_10AC::_id_107D9("rogue_armoryhall_ai_start2", "welding_medium");
  level waittill("armory_started");
  _id_0EFB::_id_FDBA(var_0);
  _id_0EFB::_id_FDBA(var_1);
}

_id_E615() {
  level._id_FD6E._id_111D6 = 4;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.05);
  setsundirection(anglesToForward((-14, -6, 0)));
  level.player _meth_84C7("lastCompletedMission", "titanjackal");
  level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7_desert");
  _id_0EFB::_id_FDD7();
  scripts\sp\utility::_id_11633(getEnt("armory_start_outside", "targetname"));
  _id_0EF8::_id_FDFC("spawner_salter", "armory_ai_wait");
  _id_0EE6::_id_2201(["iw7_m4"]);
  level._id_FD6E._id_21A8[0] thread _id_0EE6::_id_21A6("none");
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A6("iw7_m4");
  _id_E66A();
}

_id_223D() {
  level thread scripts\sp\utility::_id_12651(["shipcrib_rogue_bridgee_tr", "shipcrib_rogue_exterior_tr"]);
  level notify("armory_started");
  level thread _id_0EE8::_id_F9E5();
  _id_5503();
  _id_ADB0();
  _id_ADAF();
  level thread _id_0A2F::_id_12642();
  thread _id_CC92();
  _id_223C();
}

_id_223C() {
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
  thread _id_DB88();
  thread _id_DB89();
  thread _id_DB87();
  level waittill("player_chose_loadout");
  var_0 = getEnt("armory_terminal_salter_playerclip", "targetname");
  var_0 scripts\engine\utility::delaycall(1, ::delete);
  thread _id_CC95();
}

_id_ADB0() {
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_8A80();
  level thread _id_0EE6::_id_2202();
  level._id_FD6E._id_21A8[1] thread _id_0EE6::_id_21A7();
}

_id_ADAF() {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  _id_0EF8::_id_FDFC("spawner_mac", "armory_officer_reaction_point");
  var_0 thread scripts\sp\anim::_id_1EEA(level._id_B11D, "armory_idle", "stop_mac_idle");
  _id_0EF8::_id_FDFC("spawner_griff", "armory_officer_reaction_point");
  var_0 scripts\sp\anim::_id_1EC3(level._id_8604, "armory_intro");
  level._id_8604 scripts\sp\utility::_id_51E1("casual_gun");
  level._id_8604 scripts\sp\utility::_id_86E2();
  level._id_21EB = scripts\sp\utility::_id_10639("drone", level._id_B11D.origin, level._id_B11D.angles);
  var_0 scripts\sp\anim::_id_1EC3(level._id_21EB, "armory_scene");
  var_1 = getEntArray("armory_3d_printer", "targetname");

  foreach(var_3 in var_1) {
    if(distance2d(var_3.origin, level._id_B11D.origin) < 100) {
      level._id_21F6 = var_3;
      level._id_21F6 scripts\sp\utility::_id_23B7("armory_3d_printer");
      var_0 scripts\sp\anim::_id_1EC3(level._id_21F6, "armory_scene");
      break;
    }
  }
}

_id_CC92() {
  level thread _id_0EFB::shipcrib_autosave_now_silent();
  _id_0B20::_id_AB71(self, "armory_enter", 0.4, undefined, 1, 0.5);
  _id_0B20::_id_5A2E("armory", "locked");
}

_id_CC98() {
  thread _id_CDF2();
  thread _id_CD30();
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
  var_0 scripts\sp\anim::_id_1EEA(level._id_8604, "armory_ambient_idle", "stop_griff_idle");
}

_id_DB88() {
  _id_0A2F::_id_66A4("supportdrone");
  var_0 = _id_0EE8::_id_7CF3("player_terminal");
  var_0._id_EBF1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_0._id_EBF1 _id_5B35();
  var_0._id_EBF1 delete();
  var_1 = spawn("script_origin", level.player.origin);
  var_1 linkTo(level.player);
  level notify("terminal_scene_started");
  var_2 = _id_7BBB(var_0._id_BC97, "armory_scene");
  _id_BC56(var_2, 0.5);
  var_2 show();
  var_3 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_3 notify("stop_mac_idle");
  var_1 playSound("SH6_16_RA_ENT_DRONE");
  thread _id_DB80();
  var_0._id_BC97 thread scripts\sp\anim::_id_1F35(var_2, "armory_scene");
  var_3 thread scripts\sp\anim::_id_1F35(level._id_21EB, "armory_scene");
  var_3 thread scripts\sp\anim::_id_1F35(level._id_B11D, "armory_scene");
  var_0._id_BC97 thread scripts\sp\anim::_id_1F35(var_2, "armory_scene");
  level._id_B11D waittillmatch("single anim", "activate_armory_terminal");

  if(!level.console) {
    waitforalltransients();
  }

  var_0 notify("trigger");
  var_1 _meth_8278(0.0, 2.0);
  wait 1.05;
  var_1 stopsounds();
  wait 0.05;
  var_1 delete();
  var_2 delete();
  wait 4;
  var_3 thread scripts\sp\anim::_id_1EEA(level._id_B11D, "armory_idle", "stop_mac_idle");
  level._id_21EB clearanim(level._id_21EB scripts\sp\utility::_id_7DC1("armory_scene"), 0.05);
  scripts\engine\utility::waitframe();
  var_3 thread scripts\sp\anim::_id_1EC3(level._id_21EB, "armory_scene");
  thread _id_2A57();
}

_id_DB80() {
  scripts\sp\anim::_id_17FC("player_rig", "play_alias_sc_rogue_slt_ithinkiminlove", "play_salter_armory_scene_vo", "armory_scene");
  level waittill("play_salter_armory_scene_vo");
  level._id_EA2C scripts\sp\utility::_id_10346("sc_rogue_slt_ithinkiminlove");
}

_id_DB89() {
  scripts\engine\utility::flag_wait("at_terminal");

  if(!isDefined(level._id_FDFA)) {
    _id_0EFB::_id_F59B("rogue");
  }

  _id_0EF7::_id_CD9D();
}

_id_7BBB(var_0, var_1) {
  var_2 = _id_0EFB::_id_FE02("player_rig");
  var_2 hide();
  var_0 scripts\sp\anim::_id_1EC3(var_2, var_1);
  return var_2;
}

_id_BC56(var_0, var_1) {
  if(!isDefined(var_1)) {
    var_1 = 0.5;
  }

  level.player _meth_823C(var_0, "tag_player", var_1, var_1 / 2, var_1 / 2);
  wait(var_1);
  level.player _meth_823B(var_0, "tag_player");
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

_id_5B35(var_0, var_1) {
  if(!isDefined(var_0)) {
    var_0 = "tag_origin";
  }

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  _id_0E46::_id_48C4(var_0, var_1, &"SHIPCRIB_USETERMINAL");
  _id_0E46::_id_9016();
}

_id_CC95() {
  scripts\engine\utility::delaythread(0.1, _id_0EF7::_id_CD9C);
  thread _id_DB63();
  _id_0B20::_id_5A2E("armory_exit", "unlocked");
  thread _id_EA65();
}

_id_EA65() {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 notify("stop_salter_idle");
  level._id_EA2C _id_0EFB::_id_EB8D("rogue");
  level._id_EA2C scripts\sp\utility::_id_86E2();
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  level._id_EA2C _id_0B6A::_id_EC0D("armory_booth_salter_exit");
  level._id_EA2C _id_0B6A::_id_EC0A("armory_ai_exit");
  level._id_EA2C _id_0EE5::_id_202D(undefined, "sc_rogue_slt_letsgetitonrai");
}

_id_DB63() {
  scripts\engine\utility::flag_wait("airboss_door_scene_start");
  level._id_EA2C _id_0EE5::_id_10FC4();

  if(isDefined(level._id_8604._id_110C9)) {
    level._id_8604._id_110C9 delete();
  }

  _id_0EFB::_id_FDBA(level._id_8604);
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
  thread scripts\sp\anim::_id_1EE7(var_0, "armory_ambient_idle", "stop_armory_ambient_loop");
  level waittill("player_chose_loadout");
  setmusicstate("mx_377_weppickup");
  self notify("stop_armory_ambient_loop");

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

_id_DB87() {
  level endon("terminal_scene_started");
  wait 10;
  thread _id_CE5A();
}

_id_CE5A() {
  var_0 = scripts\engine\utility::getStruct("armory_officer_reaction_point", "targetname");
  var_0 notify("stop_griff_idle");
  level._id_8604 scripts\sp\utility::_id_7799(level.player);
  var_0 scripts\sp\anim::_id_1F35(level._id_8604, "armory_nag");
  level._id_8604 scripts\sp\utility::_id_77B9(0.7);
  var_0 scripts\sp\anim::_id_1EEA(level._id_8604, "armory_ambient_idle", "stop_griff_idle");
}

_id_21F3() {
  level endon("armory_player_near_exit");
  wait 12;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_rogue_slt_letsgetamoveon");
  wait 15;
  level._id_EA2C scripts\sp\utility::_id_10346("sc_rogue_slt_yknowyoutakefo");
}

_id_E614() {
  level._id_FD6E._id_111D6 = 1;
  level.player _meth_84C7("lastCompletedMission", "titanjackal");
  level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
  _id_0EFB::_id_FDD7();
  level._id_EFED = "safe";
  setDvar("loadout_chosen", 1);
  setDvar("loadout_shipcrib", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hide_hud", 0);
  _id_E66A();
  level thread _id_0A2F::_id_12642();
  scripts\sp\utility::_id_11633(getEnt("airboss_start", "targetname"));
  level._id_EA2C = _id_0EF8::_id_FDFC("spawner_salter", "armory_ai_exit");
  level._id_EA2C._id_D6E2 = level._id_EA2C _id_0EF1::_id_789F();
  level._id_EA2C._id_D6E0 = _id_0EE5::_id_202D;
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  level._id_EA2C _id_0EFB::_id_EB8D("rogue");
  level._id_EA2C scripts\sp\utility::_id_86E2();
  _id_0EF8::_id_FDFC("spawner_griff", "armory_officer_reaction_point");
  level._id_8604 scripts\sp\utility::_id_86E2();
  thread _id_2A57();
  level thread _id_DB63();
  level thread _id_0B20::_id_5A2E("armory_exit", "unlocked");
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_8A80();
  setsundirection(anglesToForward((-4, -71, 0)));
}

_id_E648() {
  level._id_FD6E._id_111D6 = 1;
  level.player _meth_84C7("lastCompletedMission", "titanjackal");
  level.player _meth_84C7("currentViewModel", "viewmodel_base_viewhands_iw7");
  _id_0EFB::_id_FDD7();
  level._id_EFED = "safe";
  setDvar("loadout_chosen", 1);
  setDvar("loadout_shipcrib", 1);
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_hide_hud", 0);
  _id_E66A();
  var_0 = scripts\engine\utility::getStruct("shipcrib_rogue_gibson_dropship_ramp", "targetname") scripts\engine\utility::spawn_tag_origin();
  scripts\sp\utility::_id_11633(var_0);
  level._id_EA2C = _id_0EF8::_id_FDFC("spawner_salter", "shipcrib_rogue_salter_dropship_ramp");
  level._id_EA2C._id_D6E2 = level._id_EA2C _id_0EF1::_id_789F();
  level._id_EA2C._id_D6E0 = _id_0EE5::_id_202D;
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  level._id_EA2C scripts\sp\utility::_id_86E2();
  level._id_828C = _id_0EF8::_id_FDFC("spawner_gibson", "shipcrib_rogue_gibson_c12");
  level._id_828C thread scripts\sp\interaction::_id_CE16("sc_rogue_gbs_commandertheyr", self._id_D6E2);
  level thread _id_0B20::_id_5A2E("armory_exit", "locked");
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_8A80();
  level thread _id_2406();
  level thread _id_4930();
  level scripts\engine\utility::delaythread(1.0, ::_id_E71E);
  level._id_23FD hide();
  _id_5E95();
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  level thread _id_5E80();
  level thread _id_EA95();

  for(;;) {
    if(distance2d(level._id_EA2C.origin, level.player.origin) <= 200.0 || scripts\engine\utility::flag("player_in_dropship")) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("salter_entering_ship");
}

_id_1A78() {
  level.player setstance("stand");
  scripts\sp\utility::_id_13C3C();
  level thread _id_1A73();
  _id_0EFB::_id_FDBA(level._id_B11D);
  _id_0EFB::_id_FDBA(level._id_8604);
  level thread scripts\sp\utility::_id_1264E("shipcrib_rogue_vr_tr");
  level thread scripts\sp\utility::_id_12641("shipcrib_rogue_halore_tr");
  level.player scripts\engine\utility::delaythread(2, scripts\sp\utility::_id_D090, "ges_safe_door");
  level _id_0B20::_id_AB71(self, "rogue_armory_exit", 0.4);
  level thread _id_0B20::_id_5A2E("armory_exit", "locked");
}

_id_EA2E(var_0) {
  scripts\sp\anim::_id_17FC("salter", "vo_sc_rogue_slt_werenotrocket", "start_elev", "SH6_18_RA_DECK_ELEV_XO_intro_01");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_rogue_slt_howdoesanastero", "salter_question", "SH6_18_RA_DECK_ELEV_XO_intro_01");
  scripts\sp\anim::_id_17FC("salter", "vo_sc_rogue_slt_yougotitboss", "salter_release", "SH6_18_RA_DECK_ELEV_XO_intro_01");
  self linkTo(var_0);
  var_1 = scripts\engine\utility::getStruct("shipcrib_rogue_salter_dropship_ramp", "targetname");
  _id_DB7F();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_18_RA_DECK_ELEV_XO_intro_01");
  level notify("start_airboss_anim");
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_18_RA_DECK_ELEV_XO_intro_02");
  scripts\engine\utility::flag_set("elevator_scene_done");
  scripts\engine\utility::delaythread(3.5, scripts\sp\utility::_id_10346, "sc_rogue_slt_yougotitboss");
  wait 1;
  level._id_5D78 scripts\sp\anim::_id_1F0D(self, "dropship_start_ramp");
  level thread _id_EA95();

  for(;;) {
    if(distance2d(self.origin, var_1.origin) <= 75.0) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  for(;;) {
    if(distance2d(self.origin, level.player.origin) <= 200.0 || scripts\engine\utility::flag("player_in_dropship")) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("salter_entering_ship");
}

_id_DB7F() {
  scripts\sp\anim::_id_17F6("salter", "mayhem_start", ::_id_EA2D, "SH6_18_RA_DECK_ELEV_XO_intro_01");
  scripts\sp\anim::_id_17FC("salter", "mayhem_end", "salter_mayhem_end", "SH6_18_RA_DECK_ELEV_XO_intro_01");
}

#using_animtree("generic_human");

_id_EA2D(var_0) {
  level._id_EA2C detach(level._id_EA2C.headmodel);
  level._id_EA2C _meth_82A2(%mayhem_sh6_18_ra_deck_elev_salter, 1, 0, 1);
  level waittill("salter_mayhem_end");
  level._id_EA2C _meth_82A2(%mayhem_sh6_18_ra_deck_elev_salter, 0, 0, 0);
  level._id_EA2C attach(level._id_EA2C.headmodel);
}

_id_828D(var_0) {
  self endon("death");
  thread scripts\sp\interaction::_id_9A3B("stop");
  scripts\sp\anim::_id_17FC(self._id_1FBB, "vo_sc_rogue_gbs_flaresllwreakh", "set_boss_start_pos", "SH6_18_RA_DECK_ELEV_AIR_scene");
  self._id_D6E2 = _id_0EF1::_id_789F();
  self._id_D6E0 = _id_0EE5::_id_202D;
  var_0 thread scripts\sp\anim::_id_1EEA(self, "SH6_18_RA_DECK_ELEV_AIR_idle", "stop_loop_gibson");
  level waittill("start_airboss_anim");
  var_0 notify("stop_loop_gibson");
  level thread _id_1A85();
  var_0 scripts\sp\anim::_id_1F35(self, "SH6_18_RA_DECK_ELEV_AIR_scene");
  thread _id_828E();
  level thread _id_EA59();
}

_id_828E() {
  level._id_828C endon("death");

  while(!level._id_828C scripts\sp\interaction_manager::_id_9EED(256)) {
    scripts\engine\utility::waitframe();
  }

  level._id_828C scripts\sp\utility::_id_7798(level.player);
  level._id_828C scripts\sp\utility::_id_7799(level.player);
  thread scripts\sp\utility::_id_77B7("shrug");
  thread scripts\sp\utility::_id_10346("sc_rogue_gbs_heyreyes");
  wait 5.5;
  level._id_828C _id_0B6A::_id_EC0B("shipcrib_rogue_gibson_c12", "shipcrib_stand_stationary_talk_idle_04");
  level._id_828C _id_0EE5::_id_202D(undefined, "sc_rogue_gbs_commandertheyr");
}

_id_1A85() {
  level waittill("set_boss_start_pos");
  wait 4.0;
  level._id_828C orientmode("face angle", level._id_828C.angles[1]);
  level._id_828C thread scripts\sp\utility::_id_F3DC(level._id_828C.origin);
}

_id_EA2A() {
  thread scripts\sp\anim::_id_1EEA(level._id_EA29, "shipcrib_salute_reaction_idle_01", "stop_loop");
}

_id_CF4E() {
  level waittill("salter_question");
  wait 2.0;
  level.player scripts\sp\utility::_id_1034D("sc_rogue_plr_letsseeifwecan");
  level waittill("missed_ya_playa");
}

_id_EA59() {
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_rogue_slt_letsgetthisone");
  wait 0.05;
  level thread scripts\sp\interaction_manager::_id_E815(20.0);
}

_id_1A73() {
  scripts\engine\utility::flag_set("airboss_door_scene_start");
  _id_0EE6::_id_2200();
  _id_0EE6::_id_21A9();
  level.player _meth_82C0("shipcrib_rogue_armory_pre_hangar", 0.0);
  level.player scripts\engine\utility::delaycall(1.6, ::clearclienttriggeraudiozone, 0.75);
  level.player scripts\engine\utility::delaycall(6.7, ::_meth_82C0, "shipcrib_rogue_platform_ride_down", 3.0);
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 0.05);
  level._id_EA2C scripts\sp\utility::_id_51E1("casual_gun");
  level._id_EA2C scripts\sp\utility::_id_86E2();
  level thread _id_2406();
  level thread _id_4930();
  level scripts\engine\utility::delaythread(1.0, ::_id_E71E);
  level._id_23FD hide();
  level._id_828C = _id_0EF8::_id_FDFC("spawner_gibson", "shipcrib_rogue_gibson_dropship_start");
  level._id_EA29 = _id_0EF8::_id_FDFC("spawner_sahora", "shipcrib_rogue_airboss_sahora");
  level._id_EA29._id_1FBB = "sahora";
  level thread _id_5E95();
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck", 1);
  scripts\engine\utility::waitframe();
  var_0 = _id_0EEB::_id_7976("gravity") scripts\engine\utility::spawn_tag_origin();
  level thread _id_0EEB::_id_60FD("gravity", "Mezzanine", 1);
  scripts\engine\utility::waitframe();
  var_1 = _id_0EEB::_id_7976("gravity") scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(_id_0EEB::_id_7976("gravity"));
  level._id_EA2C _id_0B20::_id_5A4D("armory_exit", 1);
  level._id_EA2C thread _id_EA2E(var_1);
  level._id_828C thread _id_828D(var_0);
  level._id_EA29 thread _id_EA2A();
  level thread _id_CF4E();
  level waittill("start_elev");
  _id_0EEB::_id_7976("gravity") notify("doors_close");
  wait 1.0;
  level thread _id_0EEB::_id_60F0("gravity", 20.0);
  level thread _id_0EEB::_id_60FD("gravity", "Flight Deck");
  _id_0EEB::_id_7976("gravity") waittill("move_finished");
  level notify("airboss_elevator_arrived");
  level thread scripts\sp\utility::_id_C12D("c12_reveal", 0.5);
  level._id_EA2C unlink();
  var_2 = scripts\engine\utility::getStruct("shipcrib_rogue_salter_dropship_ramp", "targetname");
  level._id_EA2C scripts\sp\utility::_id_F3DC(var_2.origin);
  level.player clearclienttriggeraudiozone(2);
  scripts\engine\utility::flag_wait("elevator_scene_done");
  _id_5E80();
}

_id_E71E() {
  level notify("stop_starting_sky_rot");

  if(isDefined(level._id_1027D)) {
    level._id_1027D.angles = (0, 0, 0);
    scripts\engine\utility::waitframe();
    level._id_FD6E._id_10288 unlink();
    level._id_1027D delete();
  }

  var_0 = scripts\engine\utility::spawn_script_origin((0, 0, 0), (0, 0, 0));
  var_1 = level._id_23F7 scripts\engine\utility::spawn_script_origin();
  level._id_FD6E._id_10288 linkTo(var_0);
  level._id_23FE linkTo(var_1);
  level._id_111E2 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level._id_111C3 linkTo(level._id_111E2);
  level._id_111E2.angles = level._id_111E2.angles + (0, -75, 0);
  scripts\engine\utility::waitframe();
  var_2 = scripts\engine\utility::spawn_tag_origin(level._id_23F7.origin);
  var_2.angles = (0, -30, -90);
  var_3 = scripts\engine\utility::spawn_tag_origin(level._id_23F7.origin);
  var_3 linkTo(level._id_23F7);
  var_4 = scripts\engine\utility::spawn_tag_origin(level._id_23F7.origin);
  var_5 = scripts\engine\utility::spawn_tag_origin(level._id_23F7.origin);
  playFXOnTag(scripts\engine\utility::getfx("vfx_sc_planet_rogue_asteroid_main_big"), var_2, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_trail_big"), var_3, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_follow_big"), var_4, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx("vfx_scr_asteroid_debris_follow_2_big"), var_5, "tag_origin");
  scripts\engine\utility::waitframe();
  var_6 = level._id_23F7.angles;

  for(;;) {
    var_2 rotateTo(var_2.angles + (0, 0, 90), 20.0);
    var_4 rotateTo(var_4.angles + (0, 30, 30), 20.0);
    var_5 rotateTo(var_4.angles + (0, 10, 10), 22.0);
    var_7 = level._id_23F7.angles + (-3, 0, 0);
    var_8 = var_1.angles + (-1, 0, 0);
    level._id_23F7 rotateTo(var_7, 1, 0, 0);
    var_1 rotateTo(var_8, 1, 0, 0);
    var_0 rotateTo(var_0.angles + (-0.5, -1, 0), 1.0, 0, 0);
    wait 1.0;

    if(scripts\engine\utility::flag("rotate_sky")) {
      break;
    }
  }

  level._id_23F7 rotateTo(var_6, 26, 10, 10);
  var_0 rotateTo(var_0.angles + (6, 0, 0), 3.0, 1.5, 0);
  wait 3.0;

  for(;;) {
    var_0 rotateTo(var_0.angles + (2, 0, 0), 1.0, 0, 0);
    wait 1.0;
  }
}

_id_111DF() {
  var_0 = level._id_111E2.angles;
  scripts\engine\utility::flag_wait("start_launch");
  visionsetalternate(1, 5.0);
  wait 13;
  level._id_111E2 rotateTo(var_0 + (0, 8, 0), 5, 2.5, 2.5);
  visionsetalternate(2, 5.0);
  level scripts\engine\utility::delaythread(2.0, ::_id_5E74);
  wait 8.0;
  level._id_111E2 rotateTo(var_0 + (0, -8, 0), 13, 5, 5);
  visionsetalternate(1, 5.0);
  level scripts\engine\utility::delaythread(2.0, ::_id_5E73);
  wait 13;
  level._id_111E2 rotateTo(var_0 + (0, 4, 0), 15, 2.5, 2.5);
  wait 15;
}

_id_11229() {
  level endon("stop_sun_follow");

  for(;;) {
    var_0 = vectortoangles(level._id_111C3.origin - level.player.origin);
    scripts\engine\utility::waitframe();
    var_1 = vectortoangles(level._id_111C3.origin - level.player.origin);
    lerpsunangles(var_0, var_1, 0.05);
    scripts\engine\utility::waitframe();
  }
}

_id_E71F() {
  level endon("stop_starting_sky_rot");
  level._id_1027D = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level._id_111E2 = scripts\engine\utility::spawn_tag_origin((0, 0, 0), (0, 0, 0));
  level._id_FD6E._id_10288 linkTo(level._id_1027D);
  level._id_111C3 linkTo(level._id_111E2);
  setsaveddvar("sm_sundynamics", "1");
  setsaveddvar("sm_sunsamplesizenear", 0.8);
  childthread _id_BC74();
  childthread _id_1193F();
  level._id_1027D rotateTo(level._id_1027D.angles + (-24, -55, 0), 20.0, 5, 0);
  level._id_111E2 rotateTo(level._id_111E2.angles + (-24, -55, 0), 20.0, 5, 10);
  wait 20.0;
  level._id_111C3 unlink();

  for(;;) {
    level._id_1027D rotateTo(level._id_1027D.angles + (-0.5, -1, 0), 1.0, 0, 0);
    wait 1.0;
  }
}

_id_1193F() {
  level waittill("tinted_glass");
  wait 7.0;
}

_id_BC74() {
  level._id_FD6E._id_111D6 = 35;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.25);
  visionsetnaked("shipcrib_rogue_bright", 0.75);
  var_0 = anglesToForward((-6, 34, 0));
  var_1 = anglesToForward((-28, 2, 0));
  setsundirection(var_0);
  scripts\engine\utility::noself_delaycall(8, ::lerpsundirection, var_0, var_1, 10.0);
  scripts\engine\utility::noself_delaycall(4, ::visionsetnaked, "", 3);
  visionsetalternate(5, 0.75);
  level waittill("tinted_glass");
  wait 1.0;
  visionsetalternate(4, 16);
  level._id_FD6E._id_111D6 = 4;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 5);
}

_id_D2CF() {
  level endon("stop_speed_control");

  for(;;) {
    if(distance2dsquared(level.player.origin, level._id_FD6E._id_5EE3["dropship_bay_2"].origin) <= squared(1000.0)) {
      scripts\sp\utility::_id_D2CD(60, 1.0);
    } else {
      scripts\sp\utility::_id_D2CD(100, 1.0);
    }

    scripts\engine\utility::waitframe();
  }
}

_id_118D2() {
  var_0 = gettime() / 1000;

  for(;;) {
    if(level.player attackButtonPressed()) {
      break;
    }

    scripts\engine\utility::waitframe();
  }
}

_id_5E80() {
  level._id_EA2C thread _id_5E7B();
  level._id_EA2C thread _id_5E7C();
  level._id_C47F thread _id_5E46();
  level._id_30F6 thread _id_5D8B();
  level._id_30F6 thread _id_5D8D();
  level._id_A538 thread _id_5E26();
  level._id_A538 thread _id_5E27();
  level thread _id_A53C();
  level thread _id_5E32();
  _id_100D4();
  var_0 = scripts\engine\utility::getStruct("shipcrib_rogue_player_seat_int", "targetname");
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_2 = getEnt("shipcrib_rogue_dropship_trigger", "targetname");
  var_2 waittill("trigger");
  scripts\engine\utility::flag_set("player_in_dropship");
  level thread scripts\sp\interaction_manager::_id_11037();
  level thread _id_C488();

  for(;;) {
    if(scripts\engine\utility::flag("salter_in_ship") && scripts\engine\utility::flag("player_really_enter_dash2")) {
      break;
    }

    if(scripts\engine\utility::flag("player_dropship_scene_start")) {
      break;
    }

    wait 0.05;
  }

  level notify("player_in_ship");
  level.player playSound("scn_ship_launch_alarm_lr");
  level.player playRumbleOnEntity("heavy_2s");
  level.player playSound("scn_ship_launch_impt_shake");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.3, 0, 0, 0, 14, 14, 14);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread _id_0BBC::_id_4265(["back"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\utility::play_sound_on_tag("scn_ship_launch_bkdoor_close", "j_lowerbackdoor1");
  level thread _id_D851();
  wait 1.0;
  scripts\engine\utility::flag_wait("start_panel");
  level thread _id_6F8E();
  var_1 thread _id_0E46::_id_48C4(undefined, undefined, &"SHIPCRIB_ROGUE_USE", 180, 700, 70, 1);
  var_1 waittill("trigger");
  level notify("player_at_panel");
  scripts\engine\utility::flag_set("player_at_panel");
  level thread scripts\sp\interaction_manager::_id_11037();
  wait 4.0;
  level.player playRumbleOnEntity("heavy_2s");
  level.player playSound("scn_ship_launch_impt_shake");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.3, 0, 0, 0, 14, 14, 14);
  level.player _meth_82C0("fade_to_black_minus_music", 0.3);
  scripts\sp\utility::_id_BF95();
}

_id_C488() {
  var_0 = level._id_C47F scripts\engine\utility::spawn_tag_origin();
  var_0.origin = level._id_C47F gettagorigin("tag_accessory_right");
  var_0 linkTo(level._id_C47F, "tag_accessory_right");
  var_0 thread _id_0E46::_id_48C4(undefined, undefined, &"SHIPCRIB_ROGUE_TALK", 30, 250, 70, 1);
  var_0 waittill("trigger");
  level thread _id_2406();
  level thread scripts\sp\maps\shipcrib_rogue\shipcrib_rogue_ambient::_id_A5F7();
  scripts\engine\utility::flag_set("player_dropship_scene_start");
}

_id_6F8E() {
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_script_origin();
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_1FBB = "dropship";
  scripts\engine\utility::flag_wait("player_at_panel");
  level waittill("start_panel_anim");
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\anim::_id_1F35(level._id_FD6E._id_5EE3["dropship_bay_2"], "shipcrib_rogue_dropship_screen_enter");
}

_id_5E74(var_0) {
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_2"];
  playFXOnTag(level._effect["vfx_ra_inflight_dropship_heatup_ext"], var_0._id_C0A1, "tag_origin");
  var_0 thread _id_5EAB();
}

_id_5E73(var_0) {
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_2"];
  var_0 notify("red_state_off");
  stopFXOnTag(level._effect["vfx_ra_inflight_dropship_heatup_ext"], var_0._id_C0A1, "tag_origin");
  var_0 _id_0BBF::_id_F459(1);
  level._id_99ED = 1;
}

_id_5EAB() {
  self endon("red_state_off");
  level._id_99ED = 1;
  wait(randomfloatrange(0.2, 1));
  var_0 = randomfloatrange(0.1, 1);
  var_1 = randomfloatrange(0.1, 0.3);
  level.player thread _id_B0CB(self);
  level.player thread _id_8EE4(self);

  for(;;) {
    var_0 = randomfloatrange(0.1, 1.0) * level._id_99ED;
    var_1 = randomfloatrange(0.2, 0.4) * level._id_99ED;
    level.player _meth_8291(var_1, var_1, var_1, var_0, var_0 * 0.25, var_0 * 0.25, 500, 8, 15, 12);

    if(level._id_99ED < 3) {
      level._id_99ED = level._id_99ED + randomfloatrange(0.1, 0.3);
    }

    wait(var_0 * randomfloatrange(0.5, 1.1));
  }
}

_id_B0CB(var_0) {
  var_0 endon("red_state_off");

  while(level._id_99ED < 1.5) {
    self playRumbleOnEntity("damage_light");
    wait(randomfloatrange(0.3, 0.6));
  }
}

_id_8EE4(var_0) {
  var_0 endon("red_state_off");

  while(level._id_99ED > 1.5) {
    wait 0.15;
  }

  var_0 _id_0BBF::_id_F457(1);

  for(;;) {
    self playRumbleOnEntity("damage_heavy");
    wait(randomfloatrange(0.15, 0.3));
  }
}

_id_5E32() {
  var_0 = scripts\engine\utility::flag_wait_any_return("brooks_kash_salute_player", "gone_in_60", "player_dropship_scene_start");

  if(var_0 == "brooks_kash_salute_player") {
    wait 1.0;
    level.player thread scripts\sp\utility::_id_1034D("shipcrib_plr_atease");
  }

  scripts\engine\utility::flag_wait("player_dropship_scene_start");
  level.player disableweapons();
  scripts\engine\utility::waitframe();
  level.player setstance("stand");
  level.player playerlinkTo(level._id_CF5B);
  level.player _meth_823C(level._id_CF5B, "tag_player", 0.5, 0.25, 0.25);
  wait 0.55;
  level.player playerlinktodelta(level._id_CF5B, "tag_player", 0, 0, 0, 0, 0, 1);
  level._id_CF5B show();
  scripts\engine\utility::flag_set("dropship_scene_start");
  level._id_5D78 scripts\sp\anim::_id_1F35(level._id_CF5B, "dropship_launch_plr_int");
  level.player enableweapons();
  level.player unlink();
  level._id_CF5B hide();
  level._id_CF5B unlink();
  var_1 = level._id_5D78;
  level._id_5D78 scripts\sp\anim::_id_1EC3(level._id_CF5B, "dropship_plr_screen_enter");
  level._id_CF5B linkTo(level._id_5D78);
  scripts\engine\utility::flag_wait("player_at_panel");
  level thread _id_5E6C();
  level scripts\engine\utility::delaythread(2.0, ::_id_CCF0);
  scripts\engine\utility::waitframe();
  level.player setstance("stand");
  level.player playerlinkTo(level._id_CF5B);
  level.player _meth_823C(level._id_CF5B, "tag_player", 0.5, 0.25, 0.25);
  wait 0.55;
  level.player playerlinktodelta(level._id_CF5B, "tag_player", 0, 0, 0, 0, 0, 1);
  level._id_CF5B show();
  level notify("start_panel_anim");
  level.player thread scripts\sp\utility::_id_1034D("sc_rogue_plr_lieutenantsalte");
  level._id_5D78 scripts\sp\anim::_id_1F35(level._id_CF5B, "dropship_plr_screen_enter");
  level._id_5D78 thread scripts\sp\anim::_id_1EEA(level._id_CF5B, "dropship_plr_screen_idle", "stop_loop");
  wait 3.0;
  level notify("player_anims_done");
}

_id_5E6C() {
  level.player allowcrouch(0);
  level.player scripts\sp\utility::_id_D090("ges_quick_drop");
  wait 0.25;
  level.player giveweapon("iw7_gunless");
  level.player switchtoweaponimmediate("iw7_gunless");
  level.player disableweaponswitch();
}

_id_5E7B() {
  level endon("dropship_scene_start");
  scripts\engine\utility::flag_wait("salter_entering_ship");
  self notify("stop_loop");
  scripts\sp\interaction::_id_9A0F();
  self _meth_83A1();
  _id_0A1E::_id_2385();
  level._id_5D78 scripts\sp\anim::_id_1F35(self, "dropship_start_ramp");
  scripts\sp\anim::_id_1F12(self);
  level._id_5D78 scripts\sp\anim::_id_1F17(self, "dropship_start_enter");
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  scripts\engine\utility::flag_wait("player_in_dropship");
  level._id_5D78 scripts\sp\anim::_id_1F35(self, "dropship_start_enter");
  level._id_5D78 thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_start_idle", "stop_loop");
  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_set("salter_in_seat");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_rogue_slt_letsgetthisone");
  level._id_EA2C scripts\sp\interaction_manager::_id_DB7B("sc_rogue_slt_letslightthefi");
  level thread scripts\sp\interaction_manager::_id_E815(90.0);
}

_id_5E7C() {
  scripts\engine\utility::flag_wait("dropship_scene_start");
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level thread scripts\sp\interaction_manager::_id_11037();
  level._id_EA2C thread scripts\sp\interaction_manager::_id_10FF9();
  level._id_5D78 notify("stop_loop");
  scripts\sp\anim::_id_17FA("salter", "plr_to_seat", "start_launch", "dropship_launch_scene");
  scripts\sp\anim::_id_17FA("salter", "plr_to_seat", "start_panel", "dropship_launch_scene");
  level._id_5D78 thread scripts\sp\anim::_id_1F35(self, "dropship_launch_scene");
  thread _id_EAB1();
  scripts\engine\utility::flag_wait_any("start_launch", "player_at_panel");
  level._id_5D78 thread scripts\sp\anim::_id_1EEA(self, "dropship_launch_scene_post_idle", "stop_loop_salter");
  scripts\engine\utility::flag_wait("player_at_panel");
  wait 1.0;
}

_id_EAB1() {
  level endon("player_at_panel");
  scripts\engine\utility::flag_wait("start_panel");
  wait 0.5;
  scripts\sp\utility::_id_10346("sc_rogue_slt_thisisourwindow");
  wait 15.0;
  scripts\sp\utility::_id_10346("sc_rogue_slt_wereinscanningr");
}

_id_5E46() {
  self._id_DD4C = 1;
  var_0 = scripts\sp\utility::_id_10639("mco_grenade");
  var_0 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_5D78 thread scripts\sp\anim::_id_1EE7([self, var_0], "dropship_launch_scene_idle", "stop_loop");
  scripts\engine\utility::flag_wait("dropship_scene_start");
  level._id_5D78 notify("stop_loop");
  level._id_5D78 thread scripts\sp\anim::_id_1F2C([self, var_0], "dropship_launch_scene");
  thread _id_5E47();
  scripts\engine\utility::flag_wait("start_launch");
  level._id_5D78 thread scripts\sp\anim::_id_1EE7([self, var_0], "dropship_launch_scene_post_idle", "stop_loop");
}

_id_5E47() {
  level waittill("omar_dropship_mayhem_start");
  self _meth_82A2(%mayhem_shipcrib_rogue_mco_scene_a, 1.0, 0.0, 1.0);
  self detach(self.headmodel);
  wait 10.8;
  self _meth_82A2(%mayhem_shipcrib_rogue_mco_scene_a, 0.0, 0.0, 1.0);
  self attach(self.headmodel);
}

_id_5E26() {
  level endon("dropship_scene_start");
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_start_idle", "stop_loop");
  var_0 = scripts\engine\utility::flag_wait_any_return("player_in_dropship", "salter_in_ship", "brooks_kash_reaction_started");
  level._id_A53B notify("stop_loop");

  if(var_0 == "player_in_dropship") {
    scripts\engine\utility::flag_set("brooks_kash_salute_player");
    thread scripts\sp\utility::_id_7792(level.player, 1);
  }

  level._id_A53B scripts\sp\anim::_id_1F35(self, "rogue_dropship_start_salute");
  level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_salute_end_idle", "stop_loop");
  var_0 = scripts\engine\utility::flag_wait_any_return("brooks_kash_reaction_started", "gone_in_60");

  if(var_0 == "gone_in_60") {
    thread scripts\sp\utility::_id_77B9(0.7);
    level._id_A53B notify("stop_loop");
    level._id_A53B scripts\sp\anim::_id_1F35(self, "rogue_dropship_start_look");
    level._id_A53B scripts\sp\anim::_id_1F35(self, "rogue_dropship_start_react_exit");
    level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_react_end_idle", "stop_loop");
  } else if(var_0 == "brooks_kash_reaction_started") {
    level waittill("brooks_kash_reaction_exit");
    level._id_A53B scripts\sp\anim::_id_1F35(self, "rogue_dropship_start_react_exit");
    level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_react_end_idle", "stop_loop");
  }

  thread scripts\sp\utility::_id_77B9(0.7);
}

_id_5E27() {
  scripts\engine\utility::flag_wait("dropship_scene_start");
  thread scripts\sp\utility::_id_77B9(0.7);
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_A53B notify("stop_loop");
  scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_7792, level.player, 1);
  level._id_A53B thread scripts\sp\anim::_id_1F35(self, "dropship_launch_scene");
  scripts\engine\utility::flag_wait_any("start_launch", "player_at_panel");
  level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "dropship_launch_scene_post_idle", "stop_loop");
}

_id_5D8B() {
  level endon("dropship_scene_start");
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_start_idle", "stop_loop");
  var_0 = scripts\engine\utility::flag_wait_any_return("player_in_dropship", "salter_in_ship", "brooks_kash_reaction_started");

  if(var_0 == "player_in_dropship") {
    scripts\engine\utility::flag_set("brooks_kash_salute_player");
    thread scripts\sp\utility::_id_7792(level.player, 1);
  }

  level._id_A53B scripts\sp\anim::_id_1F35(self, "rogue_dropship_start_salute");
  level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_salute_end_idle", "stop_loop");
  scripts\engine\utility::flag_set("brooks_and_kash_can_react");
  var_0 = scripts\engine\utility::flag_wait_any_return("brooks_kash_reaction_started", "gone_in_60");

  if(var_0 == "gone_in_60") {
    thread scripts\sp\utility::_id_77B9(0.7);
    level._id_A53B notify("stop_loop");
    level notify("brooks_cash_reaction_stop");
    scripts\engine\utility::flag_clear("brooks_and_kash_can_react");
    level._id_A53B scripts\sp\anim::_id_1F35(self, "rogue_dropship_start_look");
    level._id_A53B scripts\sp\anim::_id_1F35(self, "rogue_dropship_start_react_exit");
    level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_react_end_idle", "stop_loop");
    scripts\engine\utility::waitframe();
    scripts\engine\utility::flag_set("brooks_kash_reaction_end");
  } else if(var_0 == "brooks_kash_reaction_started") {
    level waittill("brooks_kash_reaction_exit");
    level._id_A53B scripts\sp\anim::_id_1F35(self, "rogue_dropship_start_react_exit");
    level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "rogue_dropship_react_end_idle", "stop_loop");
    scripts\engine\utility::waitframe();
    scripts\engine\utility::flag_set("brooks_kash_reaction_end");
  }

  thread scripts\sp\utility::_id_77B9(0.7);
}

_id_5D8D() {
  scripts\engine\utility::flag_wait("dropship_scene_start");
  thread scripts\sp\utility::_id_77B9(0.7);
  self linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_A53B notify("stop_loop");
  scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_7792, level.player, 1);
  level._id_A53B thread scripts\sp\anim::_id_1EEA(self, "dropship_launch_scene_post_idle", "stop_loop");
}

_id_5E7D() {
  level endon("player_at_panel");
  scripts\engine\utility::flag_wait("start_launch");
  wait 15.0;
  level._id_EA2C thread scripts\sp\utility::_id_10346("sc_rogue_slt_letsgetamoveon");
}

_id_A53C() {
  level endon("dropship_scene_start");
  level endon("brooks_cash_reaction_stop");
  var_0 = length(level.player.origin - level.player getEye());

  for(;;) {
    if(scripts\engine\utility::flag("brooks_and_kash_can_react")) {
      if(distance2dsquared(level._id_A538.origin, level.player.origin) <= squared(100.0)) {
        if(level.player scripts\sp\utility::_id_D1DF(level._id_A538.origin + anglestoup(level._id_A538.angles) * var_0, 0.75, 1)) {
          break;
        }
      }
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("brooks_kash_reaction_started");
  var_1 = [level._id_A538, level._id_30F6];
  level._id_A53B notify("stop_loop");
  var_1[0] thread scripts\sp\utility::_id_77B9(0.5);
  var_1[1] thread scripts\sp\utility::_id_77B9(0.5);
  var_1[0] scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_7792, level.player, 1);
  var_1[1] scripts\engine\utility::delaythread(1.0, scripts\sp\utility::_id_7792, level.player, 1);
  var_2 = "rogue_dropship_start_brooks_react";

  if(scripts\engine\utility::cointoss()) {
    var_2 = "rogue_dropship_start_kash_react";
  } else {
    var_2 = "rogue_dropship_start_brooks_react";
  }

  level._id_A53B scripts\sp\anim::_id_1F2C(var_1, var_2);
  var_1[0] thread scripts\sp\utility::_id_77B9(0.7);
  var_1[1] thread scripts\sp\utility::_id_77B9(0.7);
  level notify("brooks_kash_reaction_exit");
}

_id_EA95() {
  for(;;) {
    if(distance2dsquared(level._id_EA2C.origin, level._id_A538.origin) <= squared(200.0)) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_set("salter_in_ship");
  wait 1.0;

  if(!scripts\engine\utility::flag("brooks_kash_reaction_started") && !scripts\engine\utility::flag("brooks_kash_salute_player")) {
    level._id_EA2C thread scripts\sp\utility::_id_10346("sc_rogue_slt_saveitforthe");
  }
}

_id_E64C() {
  level._id_FD6E._id_111D6 = 1;
  _id_E66A();
  level._id_EFED = "safe";
  level thread _id_2406();
  level thread _id_4930();
  wait 0.3;
  var_0 = level._id_23F7 scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_10288 linkTo(var_0);
  level._id_23FE linkTo(var_0);
  visionsetalternate(0, 1.0);
  level thread _id_E71E();
  scripts\engine\utility::flag_set_delayed("rotate_sky", 2);
  wait 0.2;
  _id_0EF8::_id_FDFC("spawner_salter", "armory_ai_exit");
  level._id_EA2C._id_D6E2 = level._id_EA2C _id_0EF1::_id_789F();
  level._id_EA2C._id_D6E0 = _id_0EE5::_id_202D;
  _id_5E95();
  level._id_EA2C linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_C47F linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_30F6 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_A538 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread _id_0BBC::_id_4265(["back"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"] thread scripts\sp\utility::play_sound_on_tag("scn_ship_launch_bkdoor_close", "j_lowerbackdoor1");
  var_1 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_5EE3["dropship_bay_2"] linkTo(var_1);
  var_2 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos3").origin;
  var_1.origin = var_2;
  scripts\engine\utility::waitframe();
  var_1 delete();
  level._id_CF5B = _id_0EFB::_id_FE02("player_rig", level.player.origin, level.player.angles);
  level._id_CF5B show();
  var_3 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_1FBB = "dropship";
  var_4 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  var_4.angles = (0, 0, 0);
  var_4 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level.player setworldupreference(var_4);
  var_5 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  var_5 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_5 scripts\sp\anim::_id_1EC3(level._id_CF5B, "dropship_plr_screen_enter");
  scripts\engine\utility::waitframe();
  level._id_CF5B linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level.player playerlinkTo(level._id_CF5B, "tag_player");
  level.player _meth_823C(level._id_CF5B, "tag_player", 0.2, 0.1, 0.1);
  level.player disableweapons();
  wait 0.2;
  level.player playerlinktodelta(level._id_CF5B, "tag_player", 0, 0, 0, 0, 0);
  wait 0.25;
  var_5 thread scripts\sp\anim::_id_1EEA(level._id_EA2C, "dropship_launch_scene_post_idle", "stop_loop");
  var_5 thread scripts\sp\anim::_id_1EEA(level._id_C47F, "dropship_launch_scene_post_idle", "stop_loop");
  var_5 thread scripts\sp\anim::_id_1EEA(level._id_A538, "dropship_launch_scene_post_idle", "stop_loop");
  var_5 thread scripts\sp\anim::_id_1EEA(level._id_30F6, "dropship_launch_scene_post_idle", "stop_loop");
  wait 0.25;
  var_3 thread scripts\sp\anim::_id_1EEA(level._id_FD6E._id_5EE3["dropship_bay_2"], "sc_asteroid_flyin_idle", "stop_loop");
  wait 0.25;
  var_3 notify("stop_loop");
  var_6 = level._id_FD6E._id_5EE3["dropship_bay_2"]._id_12FF;
  var_7 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\utility::_id_7DC1("sc_asteroid_flyin_idle")[0];
  level._id_FD6E._id_5EE3["dropship_bay_2"] clearanim(var_7, 0.2);
  var_5 thread scripts\sp\anim::_id_1F35(level._id_FD6E._id_5EE3["dropship_bay_2"], "shipcrib_rogue_dropship_screen_enter");
  var_5 scripts\sp\anim::_id_1F35(level._id_CF5B, "dropship_plr_screen_enter");
  var_5 scripts\sp\anim::_id_1EEA(level._id_CF5B, "dropship_plr_screen_idle", "stop_player_loop");
}

_id_E66A() {
  _id_0EE4::_id_FDC0();
  level._id_C68F = 1;
  level._id_EFED = "inside";
  level thread _id_0EDE::_id_C66D("retribution");
  level thread _id_10AB::_id_300C();
  _id_2405();
  _id_2403();
  _id_11943();
  _id_F94E();
  level scripts\engine\utility::delaythread(0.25, ::_id_11942);

  if(!isDefined(level.player._id_E7D1)) {
    level.player._id_E7D1 = scripts\sp\utility::_id_7C23();
    level.player._id_E7D1 thread scripts\sp\utility::_id_E7C7(0.05);
  }

  if(!isDefined(level.player _meth_84C6("lastCompletedMission"))) {
    level.player _meth_84C7("lastCompletedMission", "titanjackal");
  }

  if(isDefined(level.player _meth_84C6("lastCompletedMission")) && level.player _meth_84C6("lastCompletedMission") == "titanjackal") {
    level thread _id_0B20::_id_5A52("bridge", ::_id_E634);
    level thread _id_FDDD(1);
  } else {
    level thread _id_FDDD(0);
    level thread _id_0B20::_id_5A52("bridge", _id_0EF7::_id_30AD);
  }

  level._id_C671 = ::_id_3058;
  level thread _id_0B20::_id_5A52("armory", ::_id_223D);
  level thread _id_0B20::_id_5A52("armory_exit", ::_id_1A78);
  level thread _id_0EEB::_id_60FD("dropship", "Return Deck", 1);
  level thread _id_0B21::_id_5A43("return_elevator", "locked");
}

_id_FDDD(var_0) {
  scripts\sp\utility::_id_C264("OBJECTIVE_ADMIRAL_UPDATE");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_ADMIRAL_UPDATE"), &"SHIPCRIB_OBJECTIVE_ADMIRAL_UPDATE");
  scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), &"SHIPCRIB_OBJECTIVE_OPS_MAP");
  scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"), &"SHIPCRIB_OBJECTIVE_GO_TO_JACKAL");
  scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"), &"SHIPCRIB_OBJECTIVE_ARMORY");
  scripts\sp\utility::_id_C264("OBJECTIVE_ROGUE");
  objective_string(scripts\sp\utility::_id_C264("OBJECTIVE_ROGUE"), &"SHIPCRIB_OBJECTIVE_ROGUE");

  if(var_0) {
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_ADMIRAL_UPDATE"), "current");
    level waittill("objective_add_opsmap");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_ADMIRAL_UPDATE"));
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), "current");
  } else
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"), "current");

  level waittill("opsmap_selection_made");

  if(level._id_FDFA == "rogue") {
    var_0 = 1;
  } else {
    var_0 = 0;
  }

  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_OPS_MAP"));

  if(var_0) {
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"), "current");
    scripts\engine\utility::flag_wait("armory_chose_loadout");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_ARMORY"));
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_ROGUE"), "current");
    level waittill("player_in_ship");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_ROGUE"));
  } else {
    objective_add(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"), "current");
    level waittill("shipcrib_jackal_launch_started");
    scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("OBJECTIVE_GO_TO_JACKAL"));
  }
}

_id_12BCC() {
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_C47F);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_EA2C);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_30F6);
  level._id_FD6E._id_1912["all"] = ::scripts\engine\utility::array_remove(level._id_FD6E._id_1912["all"], level._id_A538);
  _id_0EFB::_id_FDBB("all");
  _id_0EFB::_id_FDE8(level._id_FD6E.jackals);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_7316);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_11A55);
  _id_0EFB::_id_FDE8(level._id_FD6E._id_209C);
  _id_0EFB::_id_FDCD();
  level scripts\sp\utility::_id_12651(["shipcrib_rogue_prime_tr", "shipcrib_rogue_prime_in_tr", "shipcrib_rogue_halore_tr", "shipcrib_rogue_mezz_tr", "shipcrib_rogue_ambient_tr", "shipcrib_rogue_ambientml_tr", "shipcrib_rogue_jackal_tr", "shipcrib_rogue_vr_tr"]);
  wait 0.25;
  level scripts\sp\utility::_id_BF97(undefined, undefined, 0);
}

_id_F94E() {
  level._id_5D7F = getEnt("dropship_screen", "targetname");
  level._id_5D7F hide();
}

_id_100D4() {
  if(isDefined(level._id_5D7F)) {
    level._id_5D7F linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"], "j_seatscreenslide_ri", (0, -1.05, 0.105), (0, 90, 0));
    level._id_5D7F show();
  }
}

_id_CCF0() {
  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingameloop("sc_rogue_world_dropship_scan");
}

_id_2405() {
  level._id_23FD = getEnt("asteroid_rogue", "targetname");
  level._id_2402 = getEntArray("asteroid_piece", "targetname");
  level._id_23FE = getEnt("asteroid_sm_group", "targetname");
  level._id_23F7 = getEnt("asteroid_piece_main", "targetname");
  level._id_23F7 castdistantshadows();
  level._id_23F7 castshadows();
  level._id_23FE castdistantshadows();
  level._id_23FE castshadows();

  foreach(var_1 in level._id_2402) {
    var_1 castdistantshadows();
    var_1 castshadows();
    var_1 thread _id_23F8();
  }
}

_id_2406() {
  foreach(var_1 in level._id_2402) {
    var_1 show();
  }

  level._id_23F7 show();
  level._id_23FE show();
}

_id_2403() {
  level._id_23FD hide();
  level._id_23F7 hide();

  if(isDefined(level._id_23FE)) {
    level._id_23FE hide();
  }

  foreach(var_1 in level._id_2402) {
    var_1 hide();
  }
}

_id_23F8() {
  self endon("stop_asteroid");
  self endon("missile_hit");
  var_0 = (randomfloatrange(0, 360), randomfloatrange(0, 360), randomfloatrange(0, 360));
  self.angles = var_0;

  for(;;) {
    self rotateTo(self.angles + var_0, 60);
    wait 60.0;
  }
}

_id_5DA2() {
  if(isDefined(level._id_FD6E._id_5EE3["dropship_bay_2"])) {
    return;
  }
  _id_0EF9::_id_FE03("dropship", "dropship_bay_2");
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_106BA(undefined, 1);
  var_0 = scripts\engine\utility::play_loopsound_in_space("shipcrib_dropship_warmup", (1969, -268, -1125));
  var_0 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_1 = scripts\engine\utility::play_loopsound_in_space("emt_dropship_cockpit_radio_lp", (2072, -557, -1083));
  var_1 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F452("loading", "scrogueload");
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F452("tactical", "scroguerunning");
}

_id_5EA6(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F08B[var_0] = ::scripts\sp\utility::_id_10639("dropship_seat0" + var_0, level._id_FD6E._id_5EE3["dropship_bay_2"].origin);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1EC3(level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F08B[var_0], "seat_ff");
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F08B[var_0] linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
}

_id_5EA8(var_0, var_1) {
  var_2 = scripts\sp\utility::_id_10639("dropship_seat01", level._id_FD6E._id_5EE3["dropship_bay_2"] gettagorigin(var_0), level._id_FD6E._id_5EE3["dropship_bay_2"] gettagangles(var_0) + (0, var_1, 0));
  var_2 scripts\sp\anim::_id_1EC3(var_2, "static_seat_ff");
  var_2 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
}

_id_5EA7(var_0) {
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F088[var_0] = ::scripts\sp\utility::_id_10639("dropship_seat_mount0" + var_0, level._id_FD6E._id_5EE3["dropship_bay_2"].origin);
  level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\sp\anim::_id_1EC3(level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F088[var_0], "seat_mount_ff");
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_F088[var_0] linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
}

_id_5E95() {
  _id_5DA2();
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F458(1);
  level._id_5D78 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  level._id_A53B = level._id_5D78 scripts\engine\utility::spawn_tag_origin();
  level._id_5D78 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_A53B linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_C47F = _id_0EF8::_id_FDFC("spawner_omar", "shipcrib_rogue_mco_dropship_start");
  level._id_A538 = _id_0EF8::_id_FDFC("spawner_kash", "shipcrib_rogue_marine2_dropship_ramp");
  level._id_30F6 = _id_0EF8::_id_FDFC("spawner_brooks", "shipcrib_rogue_marine1_dropship_ramp");
  level._id_C47F _id_0EFB::_id_EB8D("rogue", 1);
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_C0A1 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  var_0 = level._id_FD6E._id_5EE3["dropship_bay_2"] gettagorigin("j_frontlandinggear");
  var_1 = level._id_FD6E._id_5EE3["dropship_bay_2"] gettagangles("j_frontlandinggear");
  var_2 = var_0 + anglesToForward(var_1) * 200 + anglestoup(var_1) * 75;
  var_3 = var_1 + (-35, 180, 0);
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_C0A1.origin = var_2;
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_C0A1.angles = var_3;
  scripts\engine\utility::waitframe();
  var_4 = scripts\engine\utility::spawn_tag_origin(level._id_FD6E._id_5EE3["dropship_bay_2"].origin, level._id_FD6E._id_5EE3["dropship_bay_2"].angles);
  var_5 = scripts\engine\utility::spawn_tag_origin(level._id_FD6E._id_5EE3["dropship_bay_2"].origin, level._id_FD6E._id_5EE3["dropship_bay_2"].angles);
  var_4._id_1FBB = "dropship_gun";
  var_5._id_1FBB = "dropship_gun";
  var_4 scripts\sp\anim::_id_F64A();
  var_5 scripts\sp\anim::_id_F64A();
  var_4 setModel(getweaponmodel("iw7_ripper"));
  var_5 setModel(getweaponmodel("iw7_ake"));
  var_4 show();
  var_5 show();
  level._id_5D78 scripts\sp\anim::_id_1EC3(var_4, "sh_rogue_intro_mr1_gun");
  level._id_5D78 scripts\sp\anim::_id_1EC3(var_5, "sh_rogue_intro_mr2_gun");
  wait 0.05;
  var_4 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  var_5 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_FD6E._id_5EE3["dropship_bay_2"]._id_C0A1 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_CF5B = _id_0EFB::_id_FE02("player_rig", level.player.origin, level.player.angles);
  level._id_5D78 scripts\sp\anim::_id_1EC3(level._id_CF5B, "dropship_launch_plr_int");
  var_6 = getEntArray("gren_crate_piece", "targetname");
  var_7 = scripts\engine\utility::spawn_script_origin((0, 0, 0), (0, 0, 0));

  foreach(var_9 in var_6) {
    if(isDefined(var_9.model)) {
      if(var_9.model == "container_equipment_crate_no_lid") {
        var_7 = var_9 scripts\engine\utility::spawn_script_origin();
      }
    }
  }

  foreach(var_12 in var_6) {
    var_12 linkTo(var_7);
  }

  var_14 = level._id_EC85["crate"]["shipcrib_rogue_grenade_box"];
  var_15 = getstartorigin(level._id_5D78.origin, level._id_5D78.angles, var_14);
  var_16 = getstartangles(level._id_5D78.origin, level._id_5D78.angles, var_14);
  var_7.origin = var_15;
  var_7.angles = var_16;
  var_7 dontinterpolate();
  scripts\engine\utility::waitframe();
  level._id_CF5B linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  level._id_CF5B hide();
  var_7 linkTo(level._id_FD6E._id_5EE3["dropship_bay_2"]);
  scripts\engine\utility::waitframe();
}

_id_D851() {
  level thread _id_0EE4::_id_E399(level._id_E35D._id_AA5F["dropship_bay_2"]._id_597A, 10);
  level._id_E35D._id_AA5F["dropship_bay_2"]._id_597A scripts\engine\utility::delaycall(1, ::playsound, "scn_ship_launch_door_open_02");
  wait 9;
  level.player scripts\engine\utility::delaycall(2, ::_meth_82C0, "shipcrib_titan_dropship_fly", 3);
  level.player scripts\engine\utility::delaycall(1.3, ::playsound, "scn_ship_launch_move_01_lr");
  wait 2;
  level.player playRumbleOnEntity("heavy_2s");
  level.player playSound("scn_ship_launch_impt_shake");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.3, 0, 0, 0, 14, 14, 14);
  wait 1;
  var_0 = 8;
  level.player playRumbleOnEntity("heavy_2s");
  level.player playSound("scn_ship_launch_impt_shake");
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8244, "subtle_tank_rumble");
  screenshake(level.player.origin, 0.035, 0.035, 0.035, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 5, 5, 5);
  var_1 = level._id_FD6E._id_5EE3["dropship_bay_2"] scripts\engine\utility::spawn_tag_origin();
  level._id_FD6E._id_5EE3["dropship_bay_2"] linkTo(var_1);
  var_2 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos2").origin;
  var_1 moveTo(var_2, var_0);
  level.player scripts\engine\utility::delaycall(var_0 - 0.25, ::stoprumble, "subtle_tank_rumble");
  level._id_FD6E._id_5EE3["dropship_bay_2"] _id_0BBF::_id_F459(1);
  scripts\engine\utility::waitframe();
  setsundirection(anglesToForward((-28, -64, 0)));
  setsuncolorandintensity(1, 0.83, 0.71);
  level._id_FD6E._id_111D6 = 0;
  level thread _id_0EFB::_id_FDBD(level._id_FD6E._id_111D6, 0.4);
  visionsetnaked("shipcrib_rogue_outro_bright", 2);
  scripts\engine\utility::waitframe();
  scripts\engine\utility::waitframe();
  wait(var_0);
  level.player playRumbleOnEntity("heavy_2s");
  level.player playSound("scn_ship_launch_impt_shake");
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.35, 0, 0, 0, 7, 7, 7);
  level thread _id_0EE4::_id_E398(level._id_E35D._id_AA5F["dropship_bay_2"]._id_5979, 5);
  scripts\engine\utility::flag_set("dropship_launch_complete");
  scripts\engine\utility::flag_wait("start_launch");
  scripts\engine\utility::flag_wait("player_at_panel");
  level._id_E35D._id_AA5F["dropship_bay_2"]._id_597C playSound("scn_ship_launch_door_open");
  var_0 = 5;
  level.player playRumbleOnEntity("heavy_2s");
  level.player scripts\engine\utility::delaycall(0.25, ::_meth_8244, "subtle_tank_rumble");
  screenshake(level.player.origin, 0.035, 0.035, 0.025, var_0, 0, 0, 0, 8, 8, 8);
  screenshake(level.player.origin, 0.5, 0.5, 0.5, 0.2, 0, 0, 0, 5, 5, 5);
  level.player playSound("scn_ship_launch_move_02_lr");
  level.player scripts\engine\utility::delaycall(var_0 - 0.25, ::stoprumble, "subtle_tank_rumble");
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

_id_F94F() {
  var_0 = _id_0EF9::_id_7C9E("dropship_spawner", "dropship");
  var_1 = _id_0EFB::_id_7CBC("dropship_bay_2", "script_noteworthy", "dropship_pos1") scripts\engine\utility::spawn_tag_origin();
  var_2 = getEnt("dropship_reflection_only", "targetname");
  var_3 = getEnt("dropship_reflection_int_only", "targetname");
  var_4 = undefined;
  var_5 = _id_0EFB::_id_7991("dropship_bay_2", "script_noteworthy", "door_1");

  foreach(var_7 in var_5) {
    var_7 hide();
  }

  if(!isDefined(var_3)) {
    return;
  }
  var_3 linkTo(var_2);
  var_9 = getEntArray("dropship_player_parts2", "script_noteworthy");

  foreach(var_11 in var_9) {
    if(isDefined(var_11.targetname)) {
      if(var_11.targetname == "delete_on_load") {
        var_4 = var_11 scripts\engine\utility::spawn_tag_origin();
      }
    }
  }

  foreach(var_14 in var_9) {
    if(isDefined(var_14.code_classname) && var_14.code_classname != "trigger_multiple") {
      var_14 linkTo(var_4);
    }
  }

  var_4.origin = var_2.origin;
  var_4.angles = var_2.angles;
  var_4 dontinterpolate();
  var_4 linkTo(var_2);
  var_2 linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_2 dontinterpolate();
}