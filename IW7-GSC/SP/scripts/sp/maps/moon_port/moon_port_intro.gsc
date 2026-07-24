/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\moon_port\moon_port_intro.gsc
*********************************************************/

_id_9ACD() {
  precachemodel("veh_mil_lnd_un_4x4_atv_moon");
  precachemodel("veh_mil_air_ca_destroyer_periph_rim");
  precachemodel("veh_mil_air_un_retribution_bottom");
  precachemodel("veh_mil_lnd_un_4x4_atv_vm");
  precachemodel("trash_can_metal_01");
  precachemodel("lv_luggage_01");
  precachemodel("civ_luggage_03");
  precachemodel("fence_industrial_blast_deflector_01");
  precachemodel("veh_mil_lnd_un_4x4_atv_dst_vm_moon");
  precacheitem("iw7_lockon");
}

_id_9AB5() {
  scripts\engine\utility::flag_init("infil_ride_started");
  scripts\engine\utility::flag_init("infil_ride_complete");
  scripts\engine\utility::flag_init("infil_apc_crash_start");
  scripts\engine\utility::flag_init("infil_getup_complete");
  scripts\engine\utility::flag_init("flag_turning_flashlight_on");
  scripts\engine\utility::flag_init("flag_player_in_tutorial_airlock");
  scripts\engine\utility::flag_init("flag_allies_in_tutorial_airlock");
  scripts\engine\utility::flag_init("flag_airlock_door_closed");
  scripts\engine\utility::flag_init("flag_infil_airlock_complete");
  scripts\engine\utility::flag_init("flag_intro_cleanup");
  scripts\engine\utility::flag_init("start_tut_vo");
  scripts\engine\utility::flag_init("tut_decomp");
  scripts\engine\utility::flag_init("tut_start_suckout_event_spotter");
  scripts\engine\utility::flag_init("tut_start_suckout_event");
  scripts\engine\utility::flag_init("shutter_tut_done");
  scripts\engine\utility::flag_init("welldeck_doors_start");
  getEnt("infil_explode_shuttle", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_9453);
  getspawner("infil_welldeck_balcony_guy", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_9493);
  getspawner("infil_welldeck_mechanic_1", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_9497, 0.14, 3.5, 3);
  getspawner("infil_welldeck_mechanic_2", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_9497, 0.6, 6, 2);
  getEnt("infil_launch_chase_jackal", "script_noteworthy") scripts\sp\utility::_id_1747(::_id_9440, 2, 6.5);
  getEnt("infil_crash_jackal_jump", "targetname") scripts\sp\utility::_id_1747(::_id_9440, 1, 1.88);
  getEnt("infil_crash_jackal_bridge", "targetname") scripts\sp\utility::_id_1747(::_id_9440, 1, 1.2);
  scripts\sp\utility::_id_16EB("double_jump", &"MOON_PORT_HINT_DOUBLE_JUMP", ::_id_12AB8);
  scripts\sp\utility::_id_16EB("wallrun", &"MOON_PORT_HINT_WALLRUN", ::_id_12AB8);
  soundsettimescalefactor("music_lr", 0);
  soundsettimescalefactor("music_lsrs", 0);
  soundsettimescalefactor("weap_plr_fire_1_2d", 0.55);
  soundsettimescalefactor("weap_plr_fire_2_2d", 0.55);
  soundsettimescalefactor("weap_plr_fire_3_2d", 0.55);
  soundsettimescalefactor("weap_plr_fire_4_2d", 0.55);
  soundsettimescalefactor("weap_plr_fire_overlap_2d", 0.55);
  soundsettimescalefactor("weap_plr_fire_lfe_2d", 0);
  soundsettimescalefactor("weap_plr_fire_alt_1_2d", 0.55);
  soundsettimescalefactor("weap_plr_fire_alt_2_2d", 0.55);
  soundsettimescalefactor("weap_plr_fire_alt_3_2d", 0.55);
  soundsettimescalefactor("weap_plr_fire_alt_4_2d", 0.55);
  soundsettimescalefactor("weap_npc_main_3d", 0.35);
  soundsettimescalefactor("weap_npc_mech_3d", 0.35);
  soundsettimescalefactor("weap_npc_mid_3d", 0.35);
  soundsettimescalefactor("weap_npc_lfe_3d", 0);
  soundsettimescalefactor("weap_npc_dist_3d", 0.35);
  soundsettimescalefactor("weap_npc_lo_3d", 0.35);
  soundsettimescalefactor("explo_1_3d", 0.3);
  soundsettimescalefactor("explo_2_3d", 0.3);
  soundsettimescalefactor("explo_3_3d", 0.3);
  soundsettimescalefactor("explo_4_3d", 0.3);
  soundsettimescalefactor("explo_dist_1_3d", 0.4);
  soundsettimescalefactor("explo_dist_2_3d", 0.4);
  soundsettimescalefactor("bulletflesh_1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_lfe_unres_2d_lim", 0);
  soundsettimescalefactor("bulletflesh_npc_1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npc_2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npcnpc1_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletflesh_npcnpc2_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletimpact_unres_3d_lim", 0.2);
  soundsettimescalefactor("bulletimpact_lo_unres_3d_lim", 0.2);
  soundsettimescalefactor("bullet_ricochets_unres_3d_lim", 0.2);
  soundsettimescalefactor("bullet_rico_reflect_unres_3d_lim", 0.2);
  soundsettimescalefactor("physics_lo_unres_3d_lim", 0.2);
  soundsettimescalefactor("vehicle_air_loops_3d_lim", 0.2);
  soundsettimescalefactor("foley_npc_step_3d", 0.2);
  soundsettimescalefactor("whizby_out_unres_3d_lim", 0.2);
  soundsettimescalefactor("whizby_in_unres_3d_lim", 0.2);
  soundsettimescalefactor("special_lo_unres_1_2d", 0.15);
  soundsettimescalefactor("voice_plr_breath_2d", 0.15);
  soundsettimescalefactor("voice_radio_2d", 0);
  soundsettimescalefactor("scn_fx_unres_2d", 0);
  soundsettimescalefactor("scn_fx_unres_3d", 0);
  soundsettimescalefactor("scn_fx_res_2d", 0);
  soundsettimescalefactor("scn_lfe_unres_2d", 0);
  soundsettimescalefactor("pa_speaker", 0.15);
  soundsettimescalefactor("amb_bed_2d", 0.25);
  soundsettimescalefactor("amb_elm_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_int_unres_3d", 0.25);
  soundsettimescalefactor("amb_elm_ext_special_unres_3d", 0.25);
}

_id_E4F2() {
  setsaveddvar("sm_sunCascadeSizeMultiplier1", "4");
}

_id_E4F1() {
  thread _id_1265A();
  scripts\engine\utility::flag_set("player_indoor_p2");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_3C44((-13, 130, 0), 0.1);
  thread _id_ADB6();
  level.player _meth_84AF(1);
  level.player shellshock("default_nosound", 999999);
  _id_0E4B::_id_8E06(1);
  scripts\sp\maps\moon_port\moon_port_util::_id_48BF();
  level.allies["marineCO"] thread scripts\anim\notetracks::notetrackvisorraise();
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE49);
  var_0 = scripts\engine\utility::getStruct("infil_scenes_struct", "targetname");
  level._id_9A9D = var_0;
  [var_2, var_3, var_4, var_5] = _id_947D(var_0);
  var_2["atv1_marine4"] thread scripts\anim\notetracks::notetrackvisorraise();
  scripts\engine\utility::delaythread(0.05, scripts\sp\utility::_id_22CD, "infil_welldeck_crew", 1);
  var_0 scripts\sp\anim::_id_1EC1(var_2, "infil_ride");
  var_2["atv0"] scripts\sp\anim::_id_1EC3(level._id_9471, "infil_ride", "tag_origin");
  var_2["tigris"] thread _id_0BB6::_id_3966(1, 1, var_2["sdf_destroyer"]);
  var_2["sdf_destroyer"] thread _id_9446(var_2["tigris"], var_2["ret"]);
  var_2["ret"] thread _id_9478(var_2["sdf_destroyer"]);
  _id_947E(level._id_9471);
  level.player stopshellshock();
  thread _id_9481(var_2["shutters"]);
  thread _id_9461();
  thread _id_946B();
  var_6 = scripts\sp\vehicle::_id_1080F("infil_takeoff_shuttles");
  var_4 = scripts\engine\utility::array_combine(var_4, var_6);
  scripts\engine\utility::delaythread(5, ::_id_946E, "infil_missile_enemy_jackal_right");
  scripts\engine\utility::delaythread(5, ::_id_946E, "infil_missile_enemy_jackal_left");
  scripts\engine\utility::delaythread(8, scripts\sp\vehicle::_id_1080F, "infil_launch_enemy_jackals");
  scripts\engine\utility::delaythread(50, scripts\sp\vehicle::_id_1080F, "infil_crash_jackal_jump");
  scripts\engine\utility::delaythread(41, scripts\sp\vehicle::_id_1080F, "infil_crash_jackal_bridge");
  thread _id_B8B9();
  thread _id_946A();
  thread _id_944A();
  thread _id_9474();
  thread _id_944F(var_2);
  thread _id_9443();
  thread _id_9442();
  thread _id_9475();
  thread _id_9426();
  thread _id_9436();
  thread _id_10318();
  var_2["jackal2"] thread _id_9462(var_2["atv2"]);
  scripts\engine\utility::flag_set("infil_ride_started");
  scripts\engine\utility::delaythread(10.5, scripts\engine\utility::flag_set, "player_outdoor_noblur");
  var_0 thread scripts\sp\anim::_id_1F2C(var_2, "infil_ride");
  var_2["atv0"] thread scripts\sp\anim::_id_1F2C(var_3, "infil_ride", "tag_origin");
  wait(getanimlength(level._id_9471 scripts\sp\utility::_id_7DC1("infil_ride")));
  scripts\engine\utility::flag_set("infil_ride_complete");
  scripts\sp\utility::_id_228A(var_4);
  scripts\engine\utility::array_thread(var_5, _id_0BA9::_id_397B);
}

_id_1265A() {
  scripts\sp\utility::_id_13705();
  scripts\engine\utility::noself_delaycall(0.05, ::setomnvar, "ui_level_transition", 3);
}

_id_10318() {
  scripts\engine\utility::flag_wait("welldeck_doors_start");
  waitforalltransients();
}

_id_B8B9() {
  thread _id_BB2F();
  wait 8.5;
  scripts\sp\utility::_id_1034D("moonport_plr_breathers");
  level.player _meth_82C0("moon_port_intro_ride_in", 3.0);
}

_id_BB2F() {
  wait 4.5;
  setmusicstate("");
}

_id_3C4C(var_0) {
  level.player _meth_82C0("moon_port_intro_pre_airlock_w_amb", 0.1);
  thread moonport_jeep_end();
}

ridein_music_start_drive(var_0) {
  thread moonport_jeep();
}

moonport_jeep() {
  setmusicstate("mx_385_moonport_jeep");
}

moonport_jeep_end() {
  setmusicstate("");
}

_id_ADB6() {
  scripts\sp\utility::_id_13705();
  scripts\sp\utility::_id_12641("moon_port_base_in_tr");
  scripts\engine\utility::flag_wait("welldeck_doors_start");
  scripts\engine\utility::waitframe();
  scripts\sp\utility::_id_12641("moon_port_crash_room_tr");
  scripts\sp\utility::_id_12643(["moon_port_periph_tr", "moon_port_tutorials_tr", "moon_port_concourse_tr", "moon_port_base_tr"]);
}

_id_9426() {
  wait 11;
  wait 1.5;
  wait 0.5;
  wait 2;
  var_0 = scripts\engine\utility::spawn_tag_origin();
  wait 3;
  wait 5.5;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_lg"), (13834, -3786, -95424));
  wait 0.5;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_lg"), (13834, -3786, -95424));
  wait 3.5;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_lg"), (-1279, 26332, -98771));
  var_0 radiusdamage((16370, 21529, -100210), 500, 1000, 1000);
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_md"), (16829, 30079, -99924));
  wait 0.2;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_md"), (14500, 29200, -99924));
  wait 0.2;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_md"), (12000, 28500, -99924));
  wait 0.3;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_md"), (10000, 28000, -99924));
  wait 0.1;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_md"), (7977, 27706, -99924));
  wait 0.3;
  var_0 radiusdamage((8159, 5524, -100122), 500, 1000, 1000);
  wait 0.5;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_md"), (13112, 7733, -100360));
  wait 0.2;
  wait 0.2;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_md"), (6000, 8000, -100284));
  wait 0.2;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_lg"), (7087, 9106, -100284));
  wait 3.1;
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_md"), (12869, 12023, -100330));
  var_0 radiusdamage((12869, 12023, -100330), 500, 1000, 1000);
  wait 0.5;
  var_0 radiusdamage((12890, 23091, -100245), 500, 1000, 1000);
  playFX(scripts\engine\utility::getfx("vfx_moonjackal_mortar_exp_dirt_lg"), (10000, 28000, -99924));
  wait 0.5;
  wait 0.5;
  wait 0.5;
  wait 1;
  var_0 delete();
}

_id_946B() {
  var_0 = getmapsuncolorandintensity();
  var_1 = 1;
  var_2 = var_0[3];
  visionsetnaked("moon_port_welldeck", 0.05);
  wait 10.5;
  visionsetnaked("moon_port_ext_infil", 2);
  wait 1;
  var_3 = 0;
  var_4 = var_1 / 0.05;
  var_5 = var_2 - 0;
  var_6 = var_5 / var_4;

  for(var_7 = 0; var_7 < var_4; var_7++) {
    if(var_4 == 1) {
      break;
    }

    var_3 = var_3 + var_6;
    setsuncolorandintensity(var_3);
    scripts\engine\utility::waitframe();
  }

  setsuncolorandintensity(var_2);
  visionsetnaked("", 2);
  wait 11;
  resetsunlight();
}

_id_947D(var_0) {
  var_1 = [];
  var_2 = [];
  var_3 = [];
  var_4 = [];

  foreach(var_6 in level.allies) {
    if(var_6._id_1FBB == "marine1" || var_6._id_1FBB == "marine2") {
      continue;
    }
    var_2[var_6._id_1FBB] = var_6;
  }

  var_2["salter"] hide();
  var_8 = 17;

  for(var_9 = 0; var_9 < 4; var_9++) {
    scripts\engine\utility::waitframe();
    var_10 = scripts\sp\vehicle::_id_1080C("atv_infil_atv_spawner");
    var_10 scripts\sp\vehicle::_id_8441();
    var_10 scripts\sp\vehicle::_id_1320B("running");
    var_10 scripts\engine\utility::delaythread(var_8, scripts\sp\utility::_id_75C4, "vfx_jeep_headlight_truck_l", "tag_light_front_left");
    var_10 scripts\engine\utility::delaythread(var_8, scripts\sp\utility::_id_75C4, "vfx_jeep_headlight_truck_r", "tag_light_front_right");
    var_8 = var_8 + 2;
    var_10._id_1FBB = "atv" + var_9;
    var_10 hidepart("tag_light_rollbar_r");
    var_10 hidepart("tag_light_rollbar_l");
    var_1[var_10._id_1FBB] = var_10;
    var_11 = scripts\sp\utility::_id_10639("atv_sled");
    var_11._id_1FBB = var_10._id_1FBB + "_sled";
    var_11 thread _id_9484();
    var_11 thread _id_5174();
    var_1[var_11._id_1FBB] = var_11;
    scripts\engine\utility::waitframe();
    var_10 setModel("veh_mil_lnd_un_4x4_atv_moon");

    if(var_10._id_1FBB == "atv0") {
      var_10 hidepart("tag_roof");
      var_10 attach("veh_mil_lnd_un_4x4_atv_vm", "tag_origin");
      continue;
    } else
      var_10 thread _id_5174();

    for(var_12 = 0; var_12 < 5; var_12++) {
      if(var_10._id_1FBB == "atv3" && var_12 < 4) {
        continue;
      }
      var_13 = scripts\sp\utility::_id_107EA("atv_infil_marine_spawner", 1);
      var_13.name = "";
      var_13 scripts\sp\utility::_id_86E4();
      var_13 thread _id_5174();
      var_13._id_1FBB = var_10._id_1FBB + "_marine" + var_12;
      var_1[var_13._id_1FBB] = var_13;

      if(var_10._id_1FBB == "atv1" && var_12 < 4)
        var_13 hide();

      if(var_10._id_1FBB == "atv2")
        var_13 hide();

      if(var_10._id_1FBB == "atv3")
        var_13 hide();

      scripts\engine\utility::waitframe();
    }
  }

  getspawner("atv_infil_crew_spawner", "targetname").count = 999;

  for(var_9 = 0; var_9 < 2; var_9++) {
    var_14 = scripts\sp\utility::_id_107EA("atv_infil_crew_spawner", 1);
    var_14.name = "";
    var_14 scripts\sp\utility::_id_86E4();
    var_14._id_1FBB = "crewman" + var_9;
    var_14 thread _id_5174();
    var_1[var_14._id_1FBB] = var_14;
    scripts\engine\utility::waitframe();
  }

  for(var_9 = 0; var_9 < 6; var_9++) {
    scripts\engine\utility::waitframe();
    var_15 = scripts\sp\vehicle::_id_1080C("atv_infil_jackal_spawner");
    var_15._id_1FBB = "jackal" + var_9;
    var_15 scripts\sp\vehicle::_id_8441();
    var_15 notsolid();
    var_15 thread _id_5174();
    var_1[var_15._id_1FBB] = var_15;
    scripts\engine\utility::waitframe();
  }

  var_16 = scripts\sp\utility::_id_8200("atv_infil_retribution_spawner", "targetname");
  var_16._id_B210 = "veh_mil_air_un_retribution_bottom";
  var_17 = scripts\sp\vehicle::_id_1080C("atv_infil_retribution_spawner");
  var_17._id_1FBB = "ret";
  var_17 scripts\sp\vehicle::_id_8441();
  var_17 dontcastshadows();
  var_17 notsolid();
  var_17 hide();
  var_17._id_55A4 = 0;
  var_17 scripts\engine\utility::delaycall(20, ::show);
  var_17 scripts\engine\utility::delaythread(0.1, _id_0BB8::_id_39D0, "heavy");
  var_17 scripts\engine\utility::delaythread(0.1, _id_0BB8::_id_39CD, "heavy");
  var_17 thread _id_5174(1);
  var_17 castspotshadows(0);
  scripts\sp\vehicle_build::_id_31C6(var_17.classname, "default", "vfx/iw7/levels/moon/vfx_moon_retr_wash_lowg.vfx", 0);
  var_1[var_17._id_1FBB] = var_17;
  var_18 = scripts\sp\utility::_id_8200("atv_infil_tigris_spawner", "targetname");
  var_19 = scripts\sp\vehicle::_id_1080C("atv_infil_tigris_spawner");
  var_19._id_1FBB = "tigris";
  var_19 scripts\sp\vehicle::_id_8441();
  var_19 dontcastshadows();
  var_19 hide();
  var_19 scripts\engine\utility::delaycall(15, ::show);
  var_19 castspotshadows(0);
  var_1[var_19._id_1FBB] = var_19;
  var_4[var_4.size] = var_19;
  var_20 = scripts\sp\utility::_id_8200("atv_infil_destroyer_spawner", "targetname");
  var_21 = scripts\sp\vehicle::_id_1080C("atv_infil_destroyer_spawner");
  var_21 scripts\sp\vehicle::_id_8441();
  var_21 dontcastshadows();
  var_21 hide();
  var_21 scripts\engine\utility::delaycall(15, ::show);
  var_21._id_1FBB = "sdf_destroyer";
  var_21 castspotshadows(0);
  var_21._id_B210 = "veh_mil_air_ca_destroyer_periph_rim";
  var_1[var_21._id_1FBB] = var_21;
  var_4[var_4.size] = var_21;
  var_22 = scripts\sp\utility::_id_10639("ca_apc");
  var_22 scripts\sp\vehicle::_id_8441();
  var_22 hide();
  var_22 scripts\engine\utility::delaycall(20, ::show);
  var_1[var_22._id_1FBB] = var_22;
  var_3[var_3.size] = var_22;
  var_23 = getspawner("atv_infil_sdf_spawner", "targetname");
  var_24 = var_23 scripts\sp\utility::_id_10619(1);
  var_24._id_1FBB = "apc_enemy";
  var_24 thread _id_942E(var_22);
  level._id_942F = var_24;
  var_25 = scripts\sp\utility::_id_10639("ramp");
  var_0 scripts\sp\anim::_id_1EC3(var_25, "infil_ride");
  var_3[var_25._id_1FBB] = var_25;

  for(var_9 = 0; var_9 < 3; var_9++) {
    var_26 = scripts\sp\utility::_id_10639("infil_crate");
    var_26._id_1FBB = var_26._id_1FBB + var_9;
    var_26 notsolid();
    var_1[var_26._id_1FBB] = var_26;
    var_3[var_26.size] = var_26;
  }

  var_27 = scripts\sp\utility::_id_10639("shuttle");
  var_27 notsolid();
  var_1[var_27._id_1FBB] = var_27;
  var_3[var_27.size] = var_27;

  for(var_9 = 0; var_9 < 5; var_9++) {
    var_28 = scripts\sp\utility::_id_10639("shuttle_trailer");
    var_28._id_1FBB = var_28._id_1FBB + var_9;
    var_28 notsolid();
    var_1[var_28._id_1FBB] = var_28;
    var_3[var_28.size] = var_28;
  }

  for(var_9 = 0; var_9 < 6; var_9++) {
    var_29 = scripts\sp\utility::_id_10639("infil_barrel");
    var_29._id_1FBB = var_29._id_1FBB + var_9;
    var_29 notsolid();
    var_1[var_29._id_1FBB] = var_29;
    var_3[var_29.size] = var_29;
  }

  var_30 = scripts\sp\utility::_id_10639("infil_missile");
  var_30 notsolid();
  playFXOnTag(scripts\engine\utility::getfx("vfx_moon_welldeck_player_missile"), var_30, "tag_origin");
  var_1[var_30._id_1FBB] = var_30;
  var_30 thread _id_5174();
  var_31 = scripts\engine\utility::getStruct("infil_welldeck", "targetname");
  var_32 = var_31 scripts\sp\utility::_id_10639("welldeck");
  var_32._id_1FBB = "welldeck";
  var_1[var_32._id_1FBB] = var_32;
  var_33 = _id_E404(var_32, var_31.origin, var_31.angles);
  var_33 linkTo(var_32, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_33 thread _id_E407();
  var_0 scripts\sp\anim::_id_1EC3(var_32, "infil_ride");
  var_1 = var_33 _id_E406(var_1);
  var_34 = scripts\sp\utility::_id_10639("player_rig");
  var_2[var_34._id_1FBB] = var_34;

  foreach(var_36 in var_2)
  var_36 linkTo(var_1["atv0"], "tag_origin");

  level._id_9471 = var_34;
  level._id_9470 = var_1["atv0"];
  level._id_9463 = var_1["atv1"];
  level._id_9451 = var_1["ca_apc"];
  return [var_1, var_2, var_3, var_4];
}

_id_947E(var_0) {
  _id_943E(25, 25, 15, 15);
  _id_943D(1);
  level.player setplayerangles(var_0 gettagangles("tag_player"));
  level.player setstance("stand");
  level.player scripts\engine\utility::allow_prone(0);
  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_reload(0);
  level.player scripts\engine\utility::allow_offhand_weapons(0);
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level.player scripts\engine\utility::allow_usability(0);
  level.player scripts\engine\utility::allow_weapon(0);
  level.player thread _id_9473();
}

_id_943E(var_0, var_1, var_2, var_3) {
  if(!isDefined(level._id_9437))
    level._id_9437 = [];

  level._id_9437["right"] = var_0;
  level._id_9437["left"] = var_1;
  level._id_9437["up"] = var_2;
  level._id_9437["down"] = var_3;
}

_id_943D(var_0) {
  level._id_948F = var_0;
  var_1 = level._id_9437["right"];
  var_2 = level._id_9437["left"];
  var_3 = level._id_9437["up"];
  var_4 = level._id_9437["down"];
  level.player playerlinktodelta(level._id_9471, "tag_player", var_0, var_1, var_2, var_3, var_4, 1);
}

_id_9438(var_0) {
  _id_943D(1);
}

_id_9439(var_0) {
  _id_943D(0);
}

_id_943A(var_0) {
  var_1 = 0;
  level.player playerlinktodelta(level._id_9471, "tag_player", level._id_948F, var_1, var_1, var_1, var_1, 1);
}

_id_943B(var_0) {
  _id_943D(level._id_948F);
}

_id_9473() {
  level waittill("infil_player_visor_down");
  thread _id_0E4B::_id_13485();
  thread _id_0B0B::_id_25C2();

  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_8E05();
}

_id_9477() {
  level.player scripts\engine\utility::allow_prone(1);
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_reload(1);
  level.player scripts\engine\utility::allow_offhand_weapons(1);
  level.player scripts\engine\utility::allow_weapon_switch(1);
  level.player scripts\engine\utility::allow_usability(1);
  level.player scripts\engine\utility::allow_weapon(1);
}

_id_9450(var_0) {
  _id_943B();
  level.player scripts\engine\utility::allow_weapon_switch(1);
  level.player scripts\engine\utility::allow_weapon(1);
  level.player scripts\engine\utility::allow_reload(1);
}

_id_9448(var_0) {
  level.player scripts\engine\utility::allow_weapon_switch(0);
  level.player scripts\engine\utility::allow_weapon(0);
  level.player scripts\engine\utility::allow_reload(0);
}

_id_9492(var_0) {
  var_0 endon("death");
  level endon(var_0._id_1FBB + "_stop_infil_treads");
  var_0._id_BCC9 = -1;
  var_0 childthread _id_9490();
  var_1 = var_0.origin;

  for(;;) {
    var_2 = var_0 _id_9491();

    if(var_2 == -1) {
      wait 0.1;
      continue;
    }

    var_0 scripts\sp\vehicle_treads::_id_126EF(var_0, var_2, "tag_wheel_back_left", "back_left", 0);
    wait 0.05;
    var_0 scripts\sp\vehicle_treads::_id_126EF(var_0, var_2, "tag_wheel_back_right", "back_right", 0);
    wait 0.05;
  }
}

_id_9491() {
  var_0 = self._id_BCC9;
  var_0 = var_0 * 2.2369;

  if(!var_0)
    return -1;

  var_0 = var_0 * 17.6;
  var_1 = 1 / var_0;
  var_1 = clamp(var_1 * 35, 0.1, 0.3);
  wait(var_1);
  return var_1;
}

_id_9490() {
  var_0 = self.origin;

  for(;;) {
    self._id_BCC9 = length(var_0 - self.origin);
    var_0 = self.origin;
    wait 0.05;
  }
}

_id_9484() {
  self endon("death");
  thread _id_9483();
  var_0 = ["front_le", "front_ri", "rear_le", "rear_ri"];
  var_1 = [];

  foreach(var_4, var_3 in var_0)
  var_1[var_4] = self._id_1FBB + "_thruster_" + var_3;

  for(;;) {
    var_5 = level scripts\engine\utility::waittill_any_return(var_1[0], var_1[1], var_1[2], var_1[3]);
    var_6 = undefined;

    foreach(var_3 in var_0) {
      if(issubstr(var_5, var_3)) {
        var_6 = "tag_thrust_" + var_3 + "_0";
        break;
      }
    }

    for(var_4 = 1; var_4 < 3; var_4++)
      thread scripts\sp\utility::_id_75C4("vfx_rcs_thrusters_mid", var_6 + var_4);

    thread _id_9485(var_5, var_6);
  }
}

_id_9485(var_0, var_1) {
  self endon("death");
  level scripts\engine\utility::waittill_either(var_0 + "_stop", self._id_1FBB + "_retrorockets" + "_stop");

  for(var_2 = 1; var_2 < 3; var_2++)
    thread scripts\sp\utility::_id_75F8("vfx_rcs_thrusters_mid", var_1 + var_2);
}

_id_9483() {
  self endon("death");
  level waittill(self._id_1FBB + "_retrorockets");
  var_0 = ["front_le", "front_ri", "rear_le", "rear_ri"];

  foreach(var_2 in var_0) {
    for(var_3 = 3; var_3 < 5; var_3++) {
      var_4 = "tag_thrust_" + var_2 + "_0" + var_3;
      thread scripts\sp\utility::_id_75C4("vfx_rcs_thrusters_high", var_4);
    }
  }

  level waittill(self._id_1FBB + "_retrorockets" + "_stop");

  foreach(var_2 in var_0) {
    for(var_3 = 3; var_3 < 5; var_3++) {
      var_4 = "tag_thrust_" + var_2 + "_0" + var_3;
      thread scripts\sp\utility::_id_75F8("vfx_rcs_thrusters_high", var_4);
    }
  }
}

_id_942C(var_0) {
  level._id_9451 scripts\sp\utility::_id_918B("ar_callouts_enemyapc", 0, (0, 0, 0));
  level waittill("infil_apc_ar_off");
  level._id_9451 scripts\sp\utility::_id_918C();
}

_id_942E(var_0) {
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.angles = (0, 160, 0);
  var_2 = anglesToForward(var_0.angles);
  var_3 = anglestoup(var_0.angles);
  var_4 = anglestoright(var_0.angles);
  var_1.origin = var_1.origin + var_2 * 75;
  var_1.origin = var_1.origin + var_3 * 85;
  var_1.origin = var_1.origin + var_4 * 15;
  var_1 linkTo(var_0);
  self linkTo(var_1, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_1 scripts\sp\anim::_id_1EC3(self, "infil_ride");
  scripts\engine\utility::flag_wait("infil_ride_started");
  var_1 thread scripts\sp\anim::_id_1F35(self, "infil_ride");
  self.health = 60;
  self.maxhealth = 60;
  scripts\sp\utility::_id_5564();
  scripts\sp\utility::_id_F2D8(0.15);
  self.favoriteenemy = level.player;
  self.noragdoll = 1;
  self.nocorpsedelete = 1;
  self.ignoreme = 1;
  self.ignoreall = 1;
  self._id_4E2A = scripts\sp\utility::_id_7DC1("apc_enemy_death");
  scripts\sp\utility::_id_72EC("iw7_lockon", "primary");
  self.dropweapon = 0;
  self setCanDamage(1);
  thread _id_942D();
  level waittill("infil_apc_enemy_attack");
  self.ignoreall = 0;
  scripts\sp\utility::_id_F2A8(1);
  scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  level scripts\sp\utility::_id_178D(scripts\engine\utility::flag_wait, "infil_apc_crash_start");
  scripts\sp\utility::_id_57D6();

  if(isDefined(self) && isalive(self)) {
    scripts\sp\utility::_id_F2A8(1);
    scripts\sp\utility::_id_54C6();
  }

  var_1 delete();

  if(isDefined(self))
    self linkTo(var_0);

  if(!scripts\engine\utility::flag("infil_apc_crash_start"))
    scripts\engine\utility::flag_wait("infil_apc_crash_start");

  if(isDefined(self))
    self delete();
}

#using_animtree("generic_human");

_id_942D() {
  self endon("entitydeleted");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9);
    playFXOnTag(scripts\engine\utility::getfx("vfx_moon_body_blood_hit"), self, "j_spineupper");
    self _meth_82A2(%hm_grnd_red_exposed_extend_pain_gut_ar);
  }
}

_id_947A(var_0) {
  level endon("salter_stop_shoot");

  for(;;) {
    var_1 = randomintrange(3, 5);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_0 shoot();
      wait 0.15;
    }

    wait(randomfloatrange(0.2, 0.4));
  }
}

_id_9455(var_0) {
  wait 0.3;
  thread scripts\sp\pip_util::_id_2ADF("moon_hud_ferran_pip");
}

_id_9446(var_0, var_1) {
  thread _id_0BB6::_id_3966(1, 1, var_0);
  self._id_12FB8 = 1;
  scripts\engine\utility::delaythread(0, ::_id_9444);
  wait 35;
  thread _id_0BB6::_id_3966(1, 0, var_0, var_1);
  level notify("stop_dist_targeting");
  self._id_12FB8 = 0;
  var_2 = scripts\engine\utility::getStructArray("infil_destroyer_ground_targets", "targetname");

  foreach(var_4 in var_2)
  thread _id_9445(var_4);

  level waittill("infil_jeep_explosion_2");
  wait 0.25;
  scripts\sp\utility::_id_228A(level._id_1678);
}

_id_9444() {
  level endon("stop_dist_targeting");
  var_0 = scripts\engine\utility::getStruct("infil_destroyer_dist_target", "targetname");

  if(!isDefined(var_0)) {
    var_0 = spawnStruct();
    var_0.origin = (8112, 35024, -100244);
    var_0.radius = 4500;
  }

  for(;;) {
    var_1 = randomintrange(1, 3);

    for(var_2 = 0; var_2 < var_1; var_2++) {
      var_3 = spawnStruct();
      var_3.origin = scripts\sp\maps\moon_port\moon_port_util::_id_E45E(var_0.origin, var_0.radius);
      var_4 = self._id_8B4F["cap_missile_tube_ca"];
      var_5 = [var_3];
      var_6 = ["vfx_moon_infil_explosion_02", "jackal_missile_impact", 5];
      thread _id_0BB6::_id_3989(var_3, undefined, var_6, 0, 0);
      wait(randomfloatrange(0.15, 0.25));
    }

    wait(randomfloatrange(0.25, 1));
  }
}

_id_9445(var_0) {
  self endon("death");
  level endon("infil_jeep_explosion_2");
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_2 = vectorNormalize(var_1.origin - var_0.origin);
  var_3 = 715;
  var_4 = var_0.radius;
  var_5 = var_0.origin;

  for(;;) {
    var_6 = randomintrange(1, 3);

    for(var_7 = 0; var_7 < var_6; var_7++) {
      var_8 = spawnStruct();
      var_8.origin = scripts\sp\maps\moon_port\moon_port_util::_id_E45E(var_5, var_4);
      var_8.origin = scripts\sp\utility::_id_864C(var_8.origin);
      var_9 = self._id_8B4F["cap_missile_tube_ca"];
      var_10 = [var_8];
      var_11 = ["vfx_moon_infil_missile_impact", "jackal_missile_impact", 5];
      thread _id_0BB6::_id_3989(var_8, undefined, var_11, 0, 0);
      wait(randomfloatrange(0.15, 0.25));
    }

    wait(randomfloatrange(0.5, 1.5));
    var_5 = var_5 + var_2 * var_3;
  }
}

_id_9478(var_0) {
  wait 26.75;

  for(var_1 = 0; var_1 < 4; var_1++) {
    thread _id_0BB6::_id_3983(var_0);
    wait 0.5;
  }

  wait 10;
  thread _id_0BB6::_id_3966(1, 1, var_0);
}

_id_9440(var_0, var_1) {
  var_2 = self.spawner;
  var_3 = var_2 scripts\sp\utility::_id_7A8E();
  var_3 scripts\engine\utility::delaythread(var_0, scripts\sp\vehicle::_id_1080B);
  wait(var_1);

  if(isDefined(var_2._id_ED46))
    self._id_72B1 = scripts\sp\utility::_id_7DC3(var_2._id_ED46);

  self notify("death");
}

_id_946E(var_0) {
  level endon("infil_ride_complete");
  var_1 = getEntArray(var_0, "targetname");

  for(;;) {
    var_2 = scripts\engine\utility::array_randomize(var_1);

    foreach(var_4 in var_2) {
      var_5 = var_4 scripts\sp\utility::_id_7A97();
      var_6 = scripts\engine\utility::random(var_5);
      var_4._id_EEB2 = undefined;
      var_7 = var_4 scripts\sp\vehicle::_id_1080B();
      var_7 _meth_845F(randomintrange(200, 1000));
      var_8 = randomfloatrange(0.5, 1.5);
      var_7 scripts\engine\utility::delaythread(var_8, _id_0B76::_id_1992, "tag_flash", var_6, 1);
      wait(randomfloatrange(1, 2));
    }
  }
}

_id_9453() {
  scripts\sp\vehicle::_id_8441();
  wait 12;
  var_0 = scripts\sp\vehicle::_id_1080D("infil_explode_shuttle_jackal");
  wait 0.25;
  var_1 = var_0 _id_0B76::_id_1992("tag_flash", self, 1);
}

_id_E404(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", var_1);
  var_3.angles = var_2;
  level._id_13CF6 = [];
  var_4 = scripts\engine\utility::getStructArray("welldeck_balcony_animstructs", "script_noteworthy");

  foreach(var_6 in var_4) {
    var_7 = var_6 scripts\engine\utility::spawn_tag_origin();
    var_7.origin = var_6.origin;
    var_7.angles = var_6.angles;
    var_7.target = var_6.target;
    var_7 linkTo(var_3);

    if(isDefined(var_6.targetname))
      level._id_13CF6[var_6.targetname] = var_7;
  }

  var_9 = getEntArray("mn_welldeck_reflection", "script_noteworthy");

  foreach(var_11 in var_9)
  var_11 linkTo(var_3);

  var_13 = scripts\engine\utility::getStruct("infil_welldeck_suckout_struct", "targetname");
  var_14 = var_13 scripts\engine\utility::spawn_tag_origin();
  level._id_948A = var_14;
  var_14 linkTo(var_3);
  var_14 thread _id_E408();
  var_15 = getEntArray("infil_welldeck", "targetname");
  level._id_9494 = [];
  level._id_9494["on"] = [];
  level._id_9494["off"] = [];

  foreach(var_17 in var_15) {
    if(isDefined(var_17.script_parameters) && var_17.script_parameters == "claxon_on") {
      var_17 hide();
      level._id_9494["on"] = scripts\engine\utility::array_add(level._id_9494["on"], var_17);
    } else if(isDefined(var_17.script_parameters) && var_17.script_parameters == "claxon_off")
      level._id_9494["off"] = scripts\engine\utility::array_add(level._id_9494["off"], var_17);

    var_17 linkTo(var_3);
  }

  var_3 thread _id_E405(var_0);
  return var_3;
}

_id_E406(var_0) {
  var_1 = getEntArray("restribution_welldeck_door", "targetname");
  var_2 = undefined;
  var_3 = undefined;

  foreach(var_5 in var_1) {
    var_6 = var_5.script_noteworthy;

    if(var_6 == "top") {
      var_2 = var_5;
      continue;
    }

    if(var_6 == "bottom")
      var_3 = var_5;
  }

  var_2 _meth_83D0(level._id_EC87["welldeck"]);
  var_2._id_1FBB = "welldeck_doors_top";
  var_0[var_2._id_1FBB] = var_2;
  var_3 _meth_83D0(level._id_EC87["welldeck"]);
  var_3._id_1FBB = "welldeck_doors_btm";
  var_0[var_3._id_1FBB] = var_3;
  level._id_948A linkTo(var_3);
  return var_0;
}

_id_E408() {
  level waittill("welldeck_doors_start");
  playFXOnTag(scripts\engine\utility::getfx("vfx_moon_welldeck_suck_out"), self, "tag_origin");
  wait 10;
  self delete();
}

_id_E407(var_0) {
  var_1 = getEntArray("mn_welldeck_lights", "script_noteworthy");
  var_2 = getEntArray("mn_welldeck_claxons", "script_noteworthy");

  foreach(var_4 in var_1)
  var_4 linkTo(self);

  var_6 = undefined;
  var_7 = undefined;

  foreach(var_9 in level._id_9494["on"]) {
    var_10 = sortbydistance(var_2, var_9.origin);
    var_11 = var_9 scripts\engine\utility::spawn_tag_origin();
    var_11 linkTo(self);

    for(var_12 = 0; var_12 < 2; var_12++) {
      var_4 = var_10[var_12];
      var_4 linkTo(var_11);
    }

    if(!isDefined(var_6)) {
      var_6 = var_11;
      continue;
    }

    var_7 = var_11;
  }

  wait 6;
  scripts\engine\utility::array_call(level._id_9494["on"], ::show);
  scripts\engine\utility::array_call(level._id_9494["off"], ::hide);
  scripts\engine\utility::array_thread(var_2, scripts\sp\lights::_id_3C57, (1, 0.135294, 0.03137), 0.05);
  wait 0.07;
  scripts\engine\utility::array_thread(var_2, scripts\sp\lights::_id_AB83, 300, 0.05);

  if(isDefined(var_6))
    var_6 thread _id_E6FA(190);

  if(isDefined(var_7))
    var_7 thread _id_E6FA(-190);

  level waittill("infil_welldeck_cleanup");

  if(isDefined(var_6))
    var_6 delete();

  if(isDefined(var_7))
    var_7 delete();

  scripts\sp\utility::_id_228A(var_1);
  scripts\sp\utility::_id_228A(var_2);
}

_id_E6FA(var_0, var_1) {
  level endon("infil_welldeck_cleanup");

  for(;;) {
    self _meth_826A((0, 360, 0), 1);
    wait 1.05;
  }
}

_id_E405(var_0) {
  scripts\engine\utility::flag_wait("infil_ride_started");
  wait(getanimlength(var_0 scripts\sp\utility::_id_7DC1("infil_ride")));
  level notify("infil_welldeck_cleanup");
  scripts\sp\utility::_id_228A(getEntArray("infil_welldeck", "targetname"));
  scripts\sp\utility::_id_228A(getEntArray("restribution_welldeck_door", "targetname"));
  var_0 delete();
  self delete();
}

_id_9493() {
  var_0 = self.spawner;
  self._id_1FBB = "welldeck_crew";
  var_1 = level._id_13CF6[var_0.target];
  var_1 thread scripts\sp\anim::_id_1F35(self, "infil_welldeck_balcony");
  scripts\engine\utility::waitframe();
  var_1 scripts\sp\anim::_id_1F29(self, "infil_welldeck_balcony", 0);
  var_1 scripts\sp\anim::_id_1F2A([self], "infil_welldeck_balcony", 0.55);
  scripts\engine\utility::flag_wait("infil_ride_started");
  var_1 scripts\sp\anim::_id_1F29(self, "infil_welldeck_balcony", 1);
  wait 6;
  var_2 = level._id_13CF6[var_1.target];
  var_1 delete();
  var_2 thread scripts\sp\anim::_id_1F35(self, "infil_welldeck_jog");
  wait 2.5;
  self delete();
  var_2 delete();
}

_id_9497(var_0, var_1, var_2) {
  var_3 = self.spawner;
  var_4 = level._id_13CF6[var_3.target];
  self._id_1FBB = "welldeck_crew";
  var_4 thread scripts\sp\anim::_id_1F35(self, "infil_welldeck_sledcheck");
  scripts\engine\utility::waitframe();
  var_4 scripts\sp\anim::_id_1F29(self, "infil_welldeck_sledcheck", 0);
  var_4 scripts\sp\anim::_id_1F2A([self], "infil_welldeck_sledcheck", var_0);
  scripts\engine\utility::flag_wait("infil_ride_started");
  var_4 scripts\sp\anim::_id_1F29(self, "infil_welldeck_sledcheck", 1);
  wait(var_1);
  var_5 = level._id_13CF6[var_4.target];
  var_5 thread scripts\sp\anim::_id_1F35(self, "infil_welldeck_jog");
  var_4 delete();
  wait(var_2);
  self delete();
  var_5 delete();
}

_id_946A() {
  wait 16;
  level.player _meth_81DE(75, 0.05);
  level.player scripts\engine\utility::delaycall(0.2, ::_meth_81DE, 65, 0.75);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideStrength", 0.025, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", -0.05, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideDistortion", 0.015, 1);
  wait 3;
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideStrength", 0, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideRadius", 0, 1);
  thread scripts\sp\utility::_id_AB9A("r_mbRadialOverrideDistortion", 0, 1);
  wait 0.1;
  setsaveddvar("r_mbEnable", 2);
  setsaveddvar("r_mbVelocityScale", 2.5);
  level waittill("infil_jeep_hit_window");
  setsaveddvar("r_mbEnable", 0);
  setsaveddvar("r_mbVelocityScale", 1);
}

_id_9488(var_0) {
  var_0["infil_missile"] scripts\engine\utility::delaythread(12.5, scripts\sp\utility::play_sound_on_entity, "infil_welldeck_incoming_missile");
  level waittill("welldeck_doors_start");
  var_0["welldeck_doors_btm"] thread scripts\sp\utility::play_sound_on_entity("large_door_open");
  var_0["welldeck_doors_btm"] thread scripts\engine\utility::play_loop_sound_on_entity("large_door_loop");
  var_0["welldeck_doors_btm"] scripts\engine\utility::delaythread(5, scripts\engine\utility::stop_loop_sound_on_entity, "large_door_loop");
  level waittill("infil_jeep_hit_window");
  level.player thread scripts\sp\utility::play_sound_on_entity("infil_jeep_window_impact");
}

_id_944F(var_0) {
  scripts\engine\utility::delaythread(1, ::_id_946F, 0.2, 2.5, level.player.origin, "grenade_rumble", "infil_welldeck_explosion_1");
  scripts\engine\utility::delaythread(5.3, ::_id_946F, 0.35, 3, level.player.origin, "grenade_rumble", "infil_welldeck_explosion_2");

  if(scripts\sp\utility::_id_93A6())
    level.player _meth_80D1();

  level waittill("welldeck_doors_start");
  thread _id_9495();
  thread _id_9479("steady_rumble", 2.25);
  level waittill("infil_welldeck_missile_explode");
  radiusdamage(level.player.origin, 200, 50, 50);
  earthquake(0.25, 2, level.player.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  var_0["atv2_marine4"] show();
  var_0["atv3_marine4"] show();
  level waittill("infil_jeep_welldeck_launch");
  thread _id_9479("steady_rumble", 0.5);
  level waittill("infil_jeep_explosion_1");
  earthquake(0.25, 2, var_0["atv1"].origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0["atv1_marine" + var_1] show();

  level waittill("infil_jeep_hit_by_corpse");
  earthquake(0.25, 2, var_0["atv0"].origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  level.allies["marineCO"] hide();
  level waittill("infil_apc_hit_player_jeep");
  thread scripts\sp\maps\moon_port\moon_port_anim::_id_9454();
  _id_943A();
  earthquake(0.25, 2, var_0["ca_apc"].origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  level.allies["salter"] show();
  scripts\engine\utility::noself_delaycall(0.5, ::playfx, scripts\engine\utility::getfx("vfx_moon_infil_explosion_01"), (10400.8, 9133.2, -100311));
  level waittill("infil_shuttle_explode");
  var_2 = getEntArray("explosion_infil_01", "targetname");

  foreach(var_4 in var_2) {
    var_4 setlightintensity(30000);
    var_4 _meth_82FC((1, 0.501961, 0.25098));
  }

  radiusdamage(var_0["shuttle"].origin, 200, 25, 25);
  earthquake(0.25, 2, var_0["shuttle"].origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  scripts\engine\utility::exploder("infil_destroyer_explosion");
  level waittill("infil_jeep_explosion_2");
  thread _id_A44C();
  radiusdamage(var_0["atv2"].origin, 200, 35, 35);
  earthquake(0.25, 2, var_0["atv2"].origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");

  for(var_1 = 0; var_1 < 4; var_1++)
    var_0["atv2_marine" + var_1] show();

  level waittill("infil_jeep_hit_window");
  radiusdamage(var_0["atv0"].origin, 200, 50, 50);
  var_0["atv0"] detach("veh_mil_lnd_un_4x4_atv_vm", "tag_origin");
  var_0["atv0"] setModel("veh_mil_lnd_un_4x4_atv_dst_vm_moon");
  earthquake(0.25, 2, var_0["atv0"].origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
  level waittill("infil_jeep_hit_airlock_ground");
  level.allies["marineCO"] show();
  thread _id_9479("steady_rumble", 5);

  if(scripts\sp\utility::_id_93A6())
    level.player _meth_80A1();
}

_id_A44C() {
  var_0 = getEntArray("explosion_infil_04", "targetname");

  foreach(var_2 in var_0)
  var_2 setlightintensity(var_2._id_C3C2);

  wait 3;

  foreach(var_2 in var_0)
  var_2 setlightintensity(0);
}

_id_9495() {
  level endon("infil_jeep_explosion_1");

  for(;;) {
    earthquake(0.1, 1, level.player.origin, 999999);
    wait 0.05;
  }
}

_id_946F(var_0, var_1, var_2, var_3, var_4) {
  earthquake(var_0, var_1, var_2, 99999);
  level.player playRumbleOnEntity(var_3);
}

_id_944E(var_0, var_1, var_2, var_3) {}

_id_9479(var_0, var_1) {
  level.player _meth_8244("steady_rumble");
  wait(var_1);
  level.player stoprumble("steady_rumble");
}

_id_9462(var_0) {
  var_1 = var_0 scripts\engine\utility::spawn_tag_origin();
  var_1.origin = var_0.origin + anglesToForward(var_0.angles) * 250;
  var_1 linkTo(var_0);
  scripts\engine\utility::delaythread(45.5, scripts\sp\maps\moon_port\moon_port_anim::_id_A1BF, self);
  level waittill("infil_apc_hit_player_jeep");
  level._id_9463 = var_1;
  scripts\engine\utility::flag_wait("infil_ride_complete");
  var_1 delete();
}

_id_9430(var_0) {
  earthquake(0.25, 2, var_0.origin, 999999);
  level.player playRumbleOnEntity("grenade_rumble");
}

_id_946D(var_0) {
  playFXOnTag(scripts\engine\utility::getfx("vfx_moon_welldeck_explo"), var_0, "tag_origin");
  earthquake(0.5, 2.5, var_0.origin, 99999);
  var_1 = getEntArray("explosion_infil_03", "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(var_3._id_C3C2);

  wait 1;
  var_1 = getEntArray("explosion_infil_03", "targetname");

  foreach(var_3 in var_1)
  var_3 setlightintensity(0);
}

_id_9481(var_0) {
  var_1 = scripts\engine\utility::getStructArray("moon_infil_shutters", "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4 scripts\sp\utility::_id_10639("shutters");
    var_5 hidepart("tag_glass_fx");
    var_2[var_4.script_parameters] = var_5;
    var_5.origin = var_4.origin;
    var_5.angles = var_4.angles;
  }

  var_2["left"] thread scripts\sp\anim::_id_1EE0(var_2["left"], "shutters_close");
  var_2["right"] thread scripts\sp\anim::_id_1EC3(var_2["right"], "shutters_close");
  level waittill("infil_jeep_hit_window");
  var_2["right"] thread _id_9480();
  level waittill("infil_shutter_close");
  var_2["right"] thread scripts\sp\anim::_id_1F35(var_2["right"], "shutters_close");
  scripts\engine\utility::flag_wait("flag_intro_cleanup");

  foreach(var_5 in var_2)
  var_5 delete();
}

_id_9480() {
  for(var_0 = 1; var_0 < 4; var_0++)
    playFXOnTag(scripts\engine\utility::getfx("vfx_moon_window_red_lights"), self, "tag_light_fx" + var_0);

  wait 3;

  for(var_0 = 1; var_0 < 4; var_0++)
    playFXOnTag(scripts\engine\utility::getfx("vfx_moon_window_red_lights"), self, "tag_light_fx" + var_0);
}

_id_9482(var_0) {
  var_1 = ["tag_thrust_front_ri_03", "tag_thrust_front_ri_04", "tag_thrust_front_le_03", "tag_thrust_front_le_04", "tag_thrust_rear_ri_03", "tag_thrust_rear_ri_04", "tag_thrust_rear_le_03", "tag_thrust_rear_le_04"];

  foreach(var_3 in var_1)
  var_0 thread scripts\sp\utility::_id_75C4("vfx_moon_jeep_sled_sparks", var_3);

  wait 0.5;

  foreach(var_3 in var_1)
  var_0 thread scripts\sp\utility::_id_75F8("vfx_moon_jeep_sled_sparks", var_3);
}

_id_9443() {
  wait 55;
  var_0 = scripts\engine\utility::getStructArray("infil_decompress_physobejct_structs", "targetname");
  var_1 = ["trash_can_metal_01", "civ_luggage_03"];
  var_2 = gettime();

  while(gettime() - var_2 < 4000) {
    var_3 = scripts\engine\utility::random(var_0);
    var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_5 = spawn("script_model", (0, 0, 0));
    var_5 setModel(scripts\engine\utility::random(var_1));
    var_5.origin = scripts\sp\maps\moon_port\moon_port_util::_id_E45E(var_3.origin, var_3.radius, var_3.height);
    scripts\engine\utility::waitframe();
    var_6 = vectorNormalize(var_4.origin - var_5.origin);
    var_5 _meth_8224(var_5.origin, var_6 * randomintrange(15000, 25000));
    var_5 scripts\engine\utility::delaycall(2, ::delete);
    wait(randomfloatrange(0.15, 0.25));
  }
}

_id_9442() {
  var_0 = [];

  for(var_1 = 0; var_1 < 2; var_1++) {
    var_2 = scripts\sp\utility::_id_10639("infil_sofa");
    var_2._id_1FBB = var_2._id_1FBB + var_1;
    var_0[var_2._id_1FBB] = var_2;
  }

  var_2 = scripts\sp\utility::_id_10639("infil_sofa_2");
  var_0[var_2._id_1FBB] = var_2;

  for(var_1 = 0; var_1 < 2; var_1++) {
    var_2 = scripts\sp\utility::_id_10639("infil_sofa_3_");
    var_2._id_1FBB = var_2._id_1FBB + var_1;
    var_0[var_2._id_1FBB] = var_2;
  }

  var_3 = scripts\sp\utility::_id_10639("infil_table");
  var_0[var_3._id_1FBB] = var_3;
  level._id_9A9D thread scripts\sp\anim::_id_1EC1(var_0, "infil_ride");
  level waittill("infil_jeep_hit_window");
  wait 1.5;
  level._id_9A9D thread scripts\sp\anim::_id_1F2C(var_0, "infil_ride");
  scripts\engine\utility::flag_wait("infil_ride_complete");
  scripts\sp\utility::_id_228A(var_0);
}

_id_944A() {
  level waittill("infil_jeep_hit_window");
  thread _id_0B0A::_id_583F(0, 0, 6, 175, 200, 3, 0.05);
  level waittill("infil_jeep_hit_airlock_ground");
  thread _id_0B0A::_id_583F(0, 200, 6, 0, 0, 1.8, 0.5);
}

_id_9474() {
  var_0 = getdvarint("r_umbraminobjectcontribution");
  setsaveddvar("r_umbraminobjectcontribution", 0);
  wait 32;
  setumbraportalstate("moonport_surface_portal_01", 0);
  setumbraportalstate("moonport_surface_portal_02", 0);
  setumbraportalstate("moonport_surface_portal_04", 0);
  setumbraportalstate("moonport_surface_portal_05", 0);
  wait 19;
  setumbraportalstate("moonport_surface_portal_01", 1);
  setumbraportalstate("moonport_surface_portal_02", 1);
  setumbraportalstate("moonport_surface_portal_04", 1);
  setumbraportalstate("moonport_surface_portal_05", 1);
  wait 4;
  setumbraportalstate("moonport_surface_portal_01", 0);
  setumbraportalstate("moonport_surface_portal_02", 0);
  setumbraportalstate("moonport_surface_portal_04", 0);
  setumbraportalstate("moonport_surface_portal_05", 0);
  scripts\engine\utility::flag_wait("infil_ride_complete");
  setsaveddvar("r_umbraminobjectcontribution", var_0);
}

_id_943C(var_0) {
  level.player lerpviewangleclamp(0.05, 0, 0, 0, 0, 0, 0);
}

_id_5174(var_0) {
  scripts\engine\utility::flag_wait("infil_ride_started");
  wait(getanimlength(scripts\sp\utility::_id_7DC1("infil_ride")));

  if(isDefined(var_0))
    _id_0BA9::_id_397B();
  else
    self delete();
}

_id_9475() {}

_id_9486(var_0) {
  level.player _meth_80D1();
  thread _id_0B0A::_id_583F(0, 20.27, 3, 0, 600, 2, 0.5);
  setslowmotion(1, 0.2, 1.5);
  thread _id_9487();
  level scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "infil_slowmo_end");
  level._id_942F scripts\sp\utility::_id_178D(scripts\sp\utility::_id_137AA, "death");
  scripts\sp\utility::_id_57D6();
  level.player _meth_80A1();
  setslowmotion(0.2, 1, 1.5);
  thread _id_0B0A::_id_583D(0.5);
}

_id_9436() {
  wait 23;
  scripts\sp\utility::_id_266F();
}

_id_9487() {
  wait 2.3;

  if(level._id_942F.health > 0) {
    level._id_942F.health = 1000;
    setslowmotion(0.2, 1.0, 0.5);
    var_0 = level._id_942F gettagorigin("tag_flash") + (-20, 30, 0);
    var_1 = level.player.origin + (-160, 150, 40);
    magicbullet(level._id_942F.weapon, var_0, var_1);
    level.player _meth_80A1();
    wait 0.27;
    level.player dodamage(1000, level._id_942F.origin, level._id_942F);
    wait 0.05;
  }
}

_id_E4EF() {
  if(scripts\sp\utility::_id_93A6())
    thread scripts\sp\specialist_MAYBE::_id_8E06();

  thread _id_E4F0();
}

_id_E4F0() {}

_id_E4EE() {
  scripts\sp\maps\moon_port\moon_port_util::_id_48BF();
  _id_0E4B::_id_8E06();
  level._id_9A9D = scripts\engine\utility::getStruct("infil_scenes_struct", "targetname");
  thread _id_9461();
  var_0 = scripts\sp\vehicle::_id_1080C("atv_infil_atv_spawner");
  var_0._id_1FBB = "atv0";
  level._id_9470 = var_0;
  level._id_9471 = scripts\sp\utility::_id_10639("player_rig");
  _id_947E(level._id_9471);
  _id_943E(0, 0, 0, 0);
  _id_943D(1);
  var_1 = scripts\sp\utility::_id_10639("shutters");
  level._id_9A9D scripts\sp\anim::_id_1EE0(var_1, "infil_ride");
  thread _id_9481(var_1);
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE49);
  scripts\sp\utility::_id_228A(getEntArray("restribution_welldeck_door", "targetname"));
}

_id_E4ED() {
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 8);
  thread scripts\sp\maps\moon_port\moon_port_util::_id_3C44((-13, 130, 0), 0.1);
  scripts\engine\utility::flag_set("player_indoor_p1_noblur");
  scripts\sp\utility::_id_13705();
  thread scripts\sp\maps\moon_port\moon_port_util::_id_1AC5("red");
  var_0 = level._id_9A9D;
  var_1 = getEnt("airlock_door_security", "targetname");
  var_1._id_1FBB = "airlock_door";
  var_1 _meth_83D0(level._id_EC87["airlock_door"]);
  var_0 thread scripts\sp\anim::_id_1EC3(var_1, "infil_airlock_close");
  level._id_9427 = var_1;
  var_2 = getEnt("airlock_security_blocker", "targetname");
  var_2 notsolid();
  scripts\engine\utility::exploder("jeepcrash_fire");
  level.player _meth_82C0("moon_port_intro_pre_airlock", 12.0);
  thread _id_945E();
  level._id_9A9D thread _id_945D(level._id_9471, level._id_9470);
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_12643, ["moon_port_periph_tr", "moon_port_tutorials_tr", "moon_port_concourse_tr"]);
  scripts\engine\utility::delaythread(1, scripts\sp\utility::_id_12651, ["moon_port_infil_tr", "moon_port_welldeck_tr"]);
  var_3 = getEnt("airlock_bodies_animnode", "targetname");
  level.player _meth_8240(var_3.origin);
  var_0 thread _id_9428(level.allies["marineCO"]);
  var_0 thread _id_9428(level.allies["salter"]);
  var_0 thread _id_9428(level.allies["eth3n"]);
  var_0 thread _id_9428(level.allies["marine2"]);
  var_0 thread _id_9429(level.allies["marine1"]);
  scripts\sp\utility::_id_266F();
  thread _id_0B0F::_id_10D23("infil_airlock_battlescsapes");
  _id_0B0F::_id_10282("infil_airlock_battlescsapes", "close_right_to_left", 2.5);
  _id_0B0F::_id_10282("infil_airlock_battlescsapes", "close_left_to_right", 5);
  scripts\engine\utility::flag_wait("infil_getup_complete");
  thread _id_9449();
  scripts\engine\utility::flag_wait("flag_airlock_door_closed");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_1AC5("green");
  thread slow_load_blocker_tutorials();
  level._id_9470 delete();
  thread _id_0B0F::_id_1103F("infil_airlock_battlescsapes", 1, 1);
  level.player clearclienttriggeraudiozone(8.0);
  var_4 = getEnt("tutorial_airlock_b_entrance", "targetname");
  _id_0B1F::_id_1AD8("tutorial_airlock_tele", 1);
  var_5 = getEnt("airlock_door_security", "targetname");
  var_6 = _id_0B1E::_id_794D("airlock_bodies_peek");
  thread _id_0B1F::_id_1AA9("tutorial_airlock_a", 1, var_5, var_6);
  level waittill("airlock_gravity_on");
  wait 0.5;
  scripts\sp\maps\moon_port\moon_port_util::_id_D1E6(0.25);
  scripts\engine\utility::flag_wait("flag_infil_airlock_complete");
  resetsundirection();
  level.player scripts\sp\utility::_id_DC45("raise");
}

slow_load_blocker_tutorials() {
  if(!level.console)
    waitforalltransients();
}

_id_945E() {
  wait 0.5;
  level.allies["marineCO"] scripts\sp\utility::_id_10347("moon_omr_effort1");
  setmusicstate("mx_182_moonport_firsthall");
}

_id_945D(var_0, var_1) {
  var_2 = level._id_9461;
  level._id_9471 = var_2;
  _id_943E(0, 0, 0, 0);
  _id_943D(1);
  var_2 show();
  var_0 delete();
  thread _id_945F();
  var_3 = scripts\engine\utility::array_add(level.allies, var_2);
  thread scripts\sp\anim::_id_1EEA(var_1, "infil_getup");
  thread scripts\sp\anim::_id_1F2C(var_3, "infil_getup");
  wait(getanimlength(var_2 scripts\sp\utility::_id_7DC1("infil_getup")));
  scripts\engine\utility::array_thread(level.allies, scripts\sp\utility::_id_BE4A);
  scripts\sp\maps\moon_port\moon_port_util::_id_D1E7(undefined, "moon_low_g_interior");
  _id_9477();
  level.player unlink();
  level._id_9471 delete();
  scripts\engine\utility::flag_set("infil_getup_complete");
}

_id_9461() {
  scripts\engine\utility::flag_wait("moon_port_crash_room_tr_loaded");
  var_0 = scripts\sp\utility::_id_10639("player_rig");
  var_0 hide();
  level._id_9A9D scripts\sp\anim::_id_1EC3(var_0, "infil_getup");
  level._id_9461 = var_0;
}

_id_945F() {
  thread _id_0B0A::_id_583F(0, 40, 6, 175, 200, 1.8, 1);
  wait 6;
  level.player _meth_81DE(55, 1);
  thread _id_0B0A::_id_583F(0, 0, 6, 175, 200, 3, 1);
  wait 4;
  level.player _meth_81DE(65, 0.5);
  thread _id_0B0A::_id_583D(2);
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "player_indoor_p1");
}

_id_9460(var_0) {
  var_1 = level.allies["marineCO"];
  var_1 detach(var_1.headmodel);
  var_1 _meth_82A2(%mayhem_moon_infil_crash_mco, 1.0, 0.0, 1.0);
  level waittill("infil_getup_mayhem_end");
  var_1 _meth_82A2(%mayhem_moon_infil_crash_mco, 0.0, 0.0, 1.0);
  var_1 attach(var_1.headmodel);
}

_id_9428(var_0) {
  level endon("door_peek_blend_complete");
  wait(getanimlength(var_0 scripts\sp\utility::_id_7DC1("infil_getup")));
  thread scripts\sp\anim::_id_1EEA(var_0, "infil_airlock_idle_1", "stop_idle");
  scripts\engine\utility::flag_wait("flag_airlock_door_closed");
  self notify("stop_idle");
  scripts\sp\anim::_id_1F35(var_0, "infil_airlock_scene");
  thread scripts\sp\anim::_id_1EEA(var_0, "infil_airlock_idle_2", "stop_idle");
}

_id_9429(var_0) {
  _id_942A(var_0);

  if(!scripts\engine\utility::flag("flag_player_in_tutorial_airlock") || !scripts\engine\utility::flag("flag_allies_in_tutorial_airlock"))
    thread scripts\sp\anim::_id_1EEA(var_0, "infil_airlock_idle_1", "stop_goodwin_idle");

  scripts\engine\utility::flag_wait_all("flag_player_in_tutorial_airlock", "flag_allies_in_tutorial_airlock");
  self notify("stop_goodwin_idle");
  var_1 = getEnt("airlock_security_blocker", "targetname");
  var_1 solid();
  var_2 = cos(85);
  var_3 = [var_0, level._id_9427];
  thread scripts\sp\anim::_id_1F2C(var_3, "infil_airlock_close");
  wait 0.1;
  var_4 = 2;

  if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0 gettagorigin("j_spineupper"), var_2)) {
    var_4 = 0;
    scripts\sp\anim::_id_1F2A(var_3, "infil_airlock_close", 0.65);
  }

  self waittill("infil_airlock_close");
  thread scripts\sp\maps\moon_port\moon_port_util::_id_3C44((-44, -50, 0), 0.1);
  scripts\sp\anim::_id_1F35(var_0, "infil_airlock_scene_a");
  scripts\sp\anim::_id_1F35(var_0, "infil_airlock_scene_b");
  thread scripts\sp\anim::_id_1EEA(var_0, "infil_airlock_idle_2", "stop_idle");
}

_id_942A(var_0) {
  var_1 = cos(85);
  var_2 = getanimlength(var_0 scripts\sp\utility::_id_7DC1("infil_getup")) * 1000;
  var_3 = gettime();

  while(gettime() - var_3 < var_2) {
    if(scripts\engine\utility::flag("flag_player_in_tutorial_airlock")) {
      if(!scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), var_0 gettagorigin("j_spineupper"), var_1)) {
        var_0 _meth_83A1();
        return;
      }
    }

    wait 0.05;
  }
}

_id_9449() {
  level endon("flag_airlock_door_closed");
  var_0 = 0;
  var_1 = randomintrange(2, 3);

  for(;;) {
    wait(randomfloatrange(2.5, 5));
    var_2 = scripts\sp\maps\moon_port\moon_port_util::_id_E45E((7360, 19640, -95660), 2500);
    earthquake(randomfloatrange(0.1, 0.2), 1, var_2, 99999);

    if(var_0 == var_1) {
      wait(randomfloatrange(0.5, 0.75));
      var_2 = scripts\sp\maps\moon_port\moon_port_util::_id_E45E((7360, 19640, -95660), 2500);
      earthquake(randomfloatrange(0.1, 0.2), 1, var_2, 99999);
      var_1 = randomintrange(2, 3);
      var_0 = 0;
      continue;
    }

    var_0++;
  }
}

_id_942B(var_0) {
  wait 0.75;
  var_1 = getEnt("infil_player_lift_clip", "targetname");
  var_2 = scripts\sp\utility::_id_864C(level.player.origin);

  if(distance(var_2, level.player.origin) > 5) {
    var_1 delete();
    return;
  }

  level.player scripts\engine\utility::allow_crouch(0);
  level.player scripts\engine\utility::allow_prone(0);
  var_1 moveTo(var_1.origin + (0, 0, 15), 6, 1, 1);
  level waittill("airlock_gravity_on");
  var_1 delete();
  level.player scripts\engine\utility::allow_crouch(1);
  level.player scripts\engine\utility::allow_prone(1);
}

_id_E4EB() {
  thread _id_0B1F::_id_1AD8("tutorial_airlock_a", 1);
  thread _id_0B1F::_id_1AD8("tutorial_airlock_tele", 1);
  thread _id_E4EC();
}

_id_E4EC() {
  scripts\engine\utility::flag_wait("flag_intro_cleanup");
  scripts\sp\maps\moon_port\moon_port_util::_id_EA01(level._id_CF83);
  scripts\sp\maps\moon_port\moon_port_util::_id_EA01(level._id_1CB8);
  scripts\sp\maps\moon_port\moon_port_util::_id_EA01(level._id_1CBC);
  scripts\sp\maps\moon_port\moon_port_util::_id_EA01(level._id_1CBE);

  if(isDefined(level._id_1162["intro_rider_allies"])) {
    var_0 = scripts\sp\utility::_id_77DA("intro_rider_allies");

    foreach(var_2 in var_0)
    var_2 delete();
  }
}

_id_12ABA() {
  scripts\sp\maps\moon_port\moon_port_util::_id_BC53("start_tutorials");
  scripts\sp\maps\moon_port\moon_port_util::_id_BC05("start_tutorials");

  foreach(var_1 in level.allies)
  var_1 scripts\sp\utility::_id_61E7();

  _id_0E4B::_id_8E06();
}

_id_12AB9() {
  scripts\engine\utility::flag_set("player_indoor_p1");
  level.player scripts\sp\utility::_id_F526("relaxed");

  foreach(var_1 in level.allies)
  var_1 scripts\sp\utility::_id_61E7();

  for(;;) {
    if(istransientloaded("moon_port_periph_tr") && istransientloaded("moon_port_tutorials_tr")) {
      break;
    }

    wait 0.05;
  }

  scripts\sp\utility::_id_15F5("tutorials_corpse_start_trig");
  scripts\engine\utility::delaythread(2, scripts\engine\utility::flag_set, "play_news_bink_mp");
  wait 2;
  level.allies["salter"] scripts\engine\utility::delaythread(1.5, scripts\sp\utility::_id_10346, "moon_slt_moveout");
  thread _id_0B1E::_id_59BE("airlock_bodies_peek", 0, undefined, 0);
  level waittill("door_peek_blend_complete");
  _id_4126();
  var_3 = [level.allies["marine1"], level.allies["marine2"], level.allies["marineCO"], level.allies["salter"], level.allies["eth3n"]];
  scripts\sp\maps\moon_port\moon_port_util::_id_1163D(var_3, "teleport_01");
  scripts\engine\utility::flag_set("flag_intro_cleanup");
  thread _id_BB35();

  while(_id_0B1E::_id_794C("airlock_bodies_peek") < 64.0)
    wait 0.05;

  _id_0B1E::_id_59C9("airlock_bodies_peek");
  thread _id_896A();
  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("start_tut_color_trig");
  scripts\engine\utility::exploder("outside_explo_01");
  scripts\engine\utility::exploder("elevator_fire");
  thread _id_D6A6();
  thread _id_12AA8();
  scripts\sp\utility::_id_1264E("moon_port_crash_room_tr");
  level waittill("door_peek_finished");
  setmusicstate("");
  level.player _meth_822F();
  thread _id_5A20();
  _id_12AB3();
  scripts\engine\utility::flag_set("shutter_tut_done");
  scripts\sp\utility::_id_28D7("allies");
  scripts\sp\utility::_id_CF8B();
  scripts\engine\utility::flag_wait("commence_wallrun_2");
  scripts\sp\maps\moon_port\moon_port_util::_id_15F6("post_curve_wall_run_color_trig");
  scripts\sp\utility::_id_56BE("wallrun", 5);
  scripts\engine\utility::flag_wait("finished_tutorials");
  wait 1;
  thread _id_12AB7();
}

_id_4F16() {
  for(;;)
    wait 1;
}

_id_D6A6() {
  var_0 = getEnt("hos_moon_suit", "targetname");

  if(isDefined(var_0)) {
    var_0._id_1FBB = "generic";
    var_0 scripts\sp\anim::_id_F64A();
    var_0 scripts\sp\anim::_id_1F35(var_0, "astronaut_pose");
    scripts\engine\utility::flag_wait("start_concourse_main");
    var_0 delete();
  }
}

_id_4126() {
  var_0 = scripts\engine\utility::getStruct("infil_scenes_struct", "targetname");
  var_0 notify("stop_idle");

  foreach(var_2 in level.allies) {
    var_2 _meth_83A1();
    var_2 setgoalpos(var_2.origin);
  }
}

_id_12AA8() {
  level._id_8E56 = 0;
  level.allies["salter"] thread _id_8E3E(1);
  level.allies["eth3n"] thread _id_8E3E(2);
  level.allies["marineCO"] thread _id_8E3E(3);
  level.allies["marine1"] thread _id_DE2C(4);
  level.allies["marine2"] thread _id_DE2C(5);
}

_id_896A() {
  thread _id_6C22();
  _id_0B0F::_id_10282("bs_tut_1_jackal", "window_flyby_tut", randomfloatrange(4, 7));
  _id_0B0F::_id_10282("bs_tut_1_jackal", "jackal_tut_1", randomfloatrange(2, 5));
  scripts\sp\utility::_id_15F3("bs_tut_1");
  level._id_118A8 = scripts\sp\utility::_id_8200("tut_bs_1_tig", "targetname") scripts\sp\vehicle::_id_1080B();
  var_0 = thread _id_1065F("tut_bs_1_cap");
  scripts\sp\utility::_id_127B3("trigger_wall_run_tutorial");
  var_1 = thread _id_1065F("tut_bs2_cap");
  var_0 = scripts\engine\utility::array_combine(var_0, var_1);
  scripts\engine\utility::flag_wait("blow_out_windows");
  wait 1;
  thread _id_2BD1();
  scripts\sp\utility::_id_127AE("kill_sky_amb_tut", "script_noteworthy");

  foreach(var_3 in var_0)
  var_3 _id_0BA9::_id_397B();

  level._id_118A8 _id_0BA9::_id_397B();
}

_id_6C22() {
  var_0 = [];
  scripts\engine\utility::flag_wait("tut_cue_final_fier_vehicles_0");
  var_1 = scripts\sp\utility::_id_8201("final_tut_flier_mb", "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3 scripts\sp\vehicle::_id_1080B();
    var_0[var_0.size] = var_4;
    var_4 vehicle_setspeed(randomintrange(25, 85), 15, 5);
  }

  scripts\engine\utility::flag_wait("tut_cue_final_fier_vehicles_1");
  var_3 = scripts\sp\utility::_id_8200("final_tut_flier_ds", "targetname");
  var_6 = var_3 scripts\sp\vehicle::_id_1080B();
  var_0[var_0.size] = var_6;
  scripts\engine\utility::flag_wait("openingIGC_playerArrived");

  foreach(var_8 in var_0)
  var_8 _id_0BA9::_id_397B();
}

_id_118AE(var_0) {
  level._id_118A8 thread _id_118B3(var_0);
  scripts\sp\utility::_id_127B3("trigger_wall_run_tutorial");
  var_0 vehicle_setspeed(140, 5, 1);
  var_1 = getvehiclenode("second_explo_path_tuts_node", "targetname");
  var_0 vehicle_teleport(var_1.origin, var_1.angles);
  var_0 scripts\sp\vehicle::_id_2471(var_1);
  scripts\engine\utility::flag_wait("blow_out_windows");
  var_2 = getvehiclenode("tut_bs_2_tig_path", "targetname");
  level._id_118A8 vehicle_teleport(var_2.origin, var_2.angles);
  level._id_118A8 scripts\sp\vehicle::_id_2471(var_2);
  level._id_118A8 vehicle_setspeed(200, 50, 50);
}

_id_118B3(var_0) {
  while(!scripts\engine\utility::flag("blow_out_windows")) {
    level._id_118A8 thread _id_0BB6::_id_3983(var_0);
    wait 0.5;
  }
}

_id_1065F(var_0) {
  var_1 = scripts\sp\utility::_id_8201(var_0, "targetname");
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = var_4 scripts\sp\vehicle::_id_1080B();
    var_2[var_2.size] = var_5;
    var_5 vehicle_setspeed(10, 1, 1);
    var_5 castspotshadows(0);
    var_5 thread _id_0BB6::_id_3966(1, 1, level._id_118A8);
  }

  return var_2;
}

_id_2BD1() {
  var_0 = scripts\engine\utility::getStructArray("tut_window_damage_struct", "targetname");

  foreach(var_2 in var_0) {
    radiusdamage(var_2.origin, 128, 999, 999);
    wait 0.25;
  }

  wait 1;
  scripts\engine\utility::flag_set("tut_decomp");
  level notify("explo_decomp");
}

_id_6992() {
  thread _id_6990();
  var_0 = getspawnerarray("explo_decomp_spawner");
  var_1 = 0;
  var_2 = scripts\engine\utility::getStruct("explo_decomp_animNode", "targetname");

  foreach(var_4 in var_0) {
    var_4._id_ED1B = 1;
    var_5 = var_4 scripts\sp\utility::_id_10619(1);
    var_5._id_1FBB = "tut_decomp_corpse_" + var_1;
    var_1++;
    var_2 thread _id_6991(var_5);
  }

  var_1 = 0;
  var_7 = getEntArray("explo_decomp_sofa", "targetname");

  foreach(var_9 in var_7) {
    var_9.clip = var_9 scripts\engine\utility::get_target_ent();
    var_9.clip linkTo(var_9);
    var_9._id_1FBB = "tut_decomp_prop_" + var_1;
    var_1++;
    var_9 scripts\sp\anim::_id_F64A();
    var_2 thread _id_6991(var_9);
  }

  var_11 = getEnt("decomp_prop_charger", "targetname");
  var_11._id_1FBB = "tut_decomp_prop_charger";
  var_11.clip = var_11 scripts\engine\utility::get_target_ent();
  var_11.clip linkTo(var_11);
  var_11 scripts\sp\anim::_id_F64A();
  var_2 thread _id_6991(var_11);
  var_1 = 0;
  var_12 = getEntArray("decomp_prop_table", "targetname");

  foreach(var_14 in var_12) {
    var_14.clip = var_14 scripts\engine\utility::get_target_ent();
    var_14.clip linkTo(var_14);
    var_14._id_1FBB = "tut_decomp_prop_table_" + var_1;
    var_1++;
    var_14 scripts\sp\anim::_id_F64A();
    var_2 thread _id_6991(var_14);
  }

  var_16 = getEnt("decomp_prop_sign", "targetname");
  var_16._id_1FBB = "tut_decomp_prop_sign";
  var_16 scripts\sp\anim::_id_F64A();
  var_2 thread _id_6991(var_16);
}

_id_6990() {
  var_0 = getEntArray("fire_tutorials_01", "script_noteworthy");
  level waittill("explo_decomp");
  scripts\sp\utility::_id_10FEC("elevator_fire");

  foreach(var_2 in var_0) {
    var_2 notify("stop_script_light_loop");
    scripts\engine\utility::waitframe();
    var_2 setlightintensity(0);
  }
}

_id_6991(var_0) {
  scripts\sp\anim::_id_1EC3(var_0, "cap_ship_explo_decomp");
  level waittill("explo_decomp");
  scripts\sp\anim::_id_1F35(var_0, "cap_ship_explo_decomp");

  if(var_0 istouching(getEnt("tut_touching_tester", "targetname")))
    scripts\engine\utility::flag_wait("start_concourse_main");

  if(isDefined(var_0.clip))
    var_0.clip delete();

  var_0 delete();
}

_id_698F() {
  level.allies["salter"] stopsounds();
  level.allies["marineCO"] stopsounds();
  wait 0.5;
  level.allies["salter"] thread scripts\sp\utility::_id_10346("moon_port_slt_holyshit");
  level.allies["marineCO"] thread scripts\sp\utility::_id_10346("moon_port_cap_explo_omar");
  wait 2;
}

_id_1066D() {
  var_0 = scripts\sp\utility::_id_8201("tut_enemy_cap_spawner", "targetname");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = var_3 scripts\sp\vehicle::_id_1080B();
    var_4 vehicle_setspeed(100, 50, 50);
    var_4 castspotshadows(0);
    var_4 thread _id_0BB6::_id_3966(1, 1, level._id_12AA1);
    var_1[var_1.size] = var_4;
  }

  return var_1;
}

_id_BB35() {
  scripts\engine\utility::flag_wait("flag_intro_cleanup");
  wait 2;
  thread scripts\engine\utility::play_sound_in_space("moon_pa_attentionaterminal", level.player.origin);
  wait 6;
  thread scripts\engine\utility::play_sound_in_space("moon_pa_attentionduetoan", level.player.origin);
  scripts\engine\utility::flag_wait("tut_decomp");
  wait 1;
  thread scripts\engine\utility::play_sound_in_space("moon_pa_warningdecompr", level.player.origin);
  wait 7;
  thread scripts\engine\utility::play_sound_in_space("moon_pa_emergencyshutters", level.player.origin);
  wait 6;
  thread scripts\engine\utility::play_sound_in_space("moon_pa_attentionaterminal", level.player.origin);
  wait 7;
  thread scripts\engine\utility::play_sound_in_space("moon_pa_pleaseremaincalm", level.player.origin);
  wait 6;
  thread scripts\engine\utility::play_sound_in_space("moon_pa_dontrunremain", level.player.origin);
}

_id_5A20() {
  wait 1.75;
  level.allies["marine2"] scripts\sp\utility::_id_10346("moon_un2_ohman");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_fuckingfiringsquad");
  wait 0.2;
  level.allies["marine2"] scripts\sp\utility::_id_10346("moon_un6_theyshotemin");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_slt_notshotexectuted");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_mco_sdfdoesnttakeprisoners");
  wait 0.5;

  if(!scripts\engine\utility::flag("tut_dj_done")) {
    level.allies["marine2"] scripts\sp\utility::_id_10346("moon_un6_downheresblockedoff");
    level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_letstrythesecond");
  }

  scripts\engine\utility::flag_wait("commence_wallrun_2");
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_wecanrunthis");
}

_id_12AA7(var_0, var_1) {
  scripts\engine\utility::flag_wait("flag_player_in_tutorial_airlock");

  for(;;) {
    if(scripts\engine\utility::flag("flag_player_in_tutorial_airlock")) {
      if(scripts\engine\utility::flag("flag_all_allies_in_tutorial_airlock")) {
        break;
      }
    }

    wait 0.05;
  }

  level.player playSound("scn_moon_airlock_pressurize_lr");
  var_0 solid();
  var_1 rotateby((0, 105, 0), 1);
  wait 1.0;
}

_id_12AB8() {
  return scripts\engine\utility::flag("finished_tutorials");
}

_id_12AB6() {
  _id_12AB7();
}

_id_12AB7() {
  if(isDefined(level._id_1AA3)) {
    foreach(var_1 in level._id_1AA3)
    wait 1;
  }
}

_id_111B6() {
  var_0 = scripts\sp\utility::_id_10639("cover_crate");
  var_0._id_1FBB = "cover_crate";
  var_0 scripts\sp\anim::_id_F64A();
  var_1 = scripts\engine\utility::getStruct("destroyer_suckout_animnode", "targetname");
  var_1 scripts\sp\anim::_id_1EC3(var_0, "destroyer_suckout");
  scripts\sp\utility::_id_127B3("destroyer_suckout_start_trig");
  level.player scripts\engine\utility::delaythread(2.0, scripts\sp\utility::_id_F526, "normal");
  thread _id_111B2();
  thread _id_12ABB();
  thread _id_1D20();
  _id_12ABC();
}

_id_12ABC() {
  level endon("skipped_suckout_tut");
  var_0 = getEnt("destroyer_suckout_spawner_anim", "targetname");
  var_1 = getnodearray("suckout_tut_sdf_node", "targetname");
  var_2 = scripts\engine\utility::getStruct("destroyer_suckout_animnode", "targetname");
  var_3 = var_2;
  var_4 = [];
  var_5 = 0;

  for(var_6 = 0; var_6 < 5; var_6++) {
    var_7 = var_0 scripts\sp\utility::_id_10619(1);
    wait 0.2;
    var_7 thread _id_116CF();

    if(var_5 < 2) {
      var_7 scripts\sp\utility::_id_51E1("casual_gun");
      var_7 scripts\engine\utility::delaythread(2.0, scripts\sp\utility::_id_51E1, "frantic");
    } else
      var_7 scripts\sp\utility::_id_51E1("frantic");

    var_5++;
    var_7._id_1FBB = "suckout_guy_" + scripts\sp\utility::string(var_6 + 1);
    var_4 = scripts\engine\utility::array_add(var_4, var_7);
    var_0.count++;
    var_8 = getstartorigin(var_3.origin, var_3.angles, var_7 scripts\sp\utility::_id_7DC1("destroyer_suckout"));
    var_9 = getstartangles(var_3.origin, var_3.angles, var_7 scripts\sp\utility::_id_7DC1("destroyer_suckout"));
    var_7.goalradius = 32;
    var_7 thread scripts\sp\utility::_id_F3D9(var_1[var_6]);
  }

  level thread _id_10262(var_4);
  level waittill("suckout_start");

  foreach(var_11 in var_4) {
    if(isDefined(var_11) && isalive(var_11)) {
      var_3 thread scripts\sp\anim::_id_1F35(var_11, "destroyer_suckout");
      var_11 thread scripts\engine\utility::delaycall(0.05, ::_meth_82B0, var_11 scripts\sp\utility::_id_7DC1("destroyer_suckout"), 3.5 / getanimlength(var_11 scripts\sp\utility::_id_7DC1("destroyer_suckout")));
    }
  }
}

_id_12ABB() {
  level endon("skipped_suckout_tut");
  level.allies["salter"] thread _id_1C1F();
  level.allies["marineCO"] thread _id_1C1F();
  wait 1.0;
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_checkfront");
}

_id_111B2() {
  level endon("skipped_suckout_tut");
  var_0 = getscriptablearray("moon_shutters", "targetname");
  level._id_429B = [];
  var_1 = scripts\engine\utility::getStruct("destroyer_suckout_animnode", "targetname");

  foreach(var_3 in var_0) {
    if(distance2d(var_3.origin, var_1.origin) <= 1500)
      level._id_429B = scripts\engine\utility::array_add(level._id_429B, var_3);
  }

  var_5 = 0;

  for(;;) {
    level._id_429B[0] waittill("damage");
    var_5++;

    if(var_5 >= 7) {
      break;
    }
  }

  thread _id_1019C();
  wait 0.57;
  level notify("suckout_start");
  level._id_429B[0] notify("scriptableNotification");
  scripts\engine\utility::waitframe();
  level._id_429B[0] notify("scriptableNotification");
  radiusdamage(level._id_429B[0].origin, 200, 200, 200, level.player);
  scripts\sp\utility::_id_10327(0.2);
  scripts\sp\utility::_id_10321();
  level notify("ally_shoot_stop");
  wait 0.5;
  scripts\sp\utility::_id_10322();
}

_id_1019C() {
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_windowsbroken");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_stayclearofthe");
}

_id_1C1F() {
  level endon("ally_shoot_stop");
  level endon("skipped_suckout_tut");
  level waittill("allies_shoot_glass");
  self.ignoreall = 1;
  self shoot(1.0, level._id_429B[0].origin, 1, 1, 1);
  level waittill("suckout_start");
  self.ignoreall = 0;
}

_id_1D20() {
  level endon("skipped_suckout_tut");
  level endon("suckout_start");
  wait 7.0;
  level.player thread scripts\sp\utility::_id_D08C("ges_point_firm", level._id_429B[0]);
  level.player _id_0B6A::_id_EC0E("Shoot the glass!");
  wait 2.0;
  level notify("allies_shoot_glass");
}

_id_111B5() {
  level.allies["salter"] scripts\sp\utility::_id_10346("moon_slt_sonofabitch");
  level.allies["marineCO"] scripts\sp\utility::_id_10346("moon_omr_neutralizeandad");
}

_id_10262(var_0) {
  level endon("suckout_start");
  var_1 = 0;

  for(;;) {
    foreach(var_3 in var_0) {
      if(!isalive(var_3))
        var_1++;
    }

    if(var_1 >= 5) {
      break;
    } else
      var_1 = 0;

    wait 0.05;
  }

  wait 1.0;
  level notify("skipped_suckout_tut");
}

_id_116CF() {
  scripts\sp\vehicle::_id_8441();
  wait 6.0;
  scripts\sp\vehicle::_id_8440();
}

_id_12AB3() {
  scripts\sp\utility::_id_127B3("tut_spawn_suckout_guys_trig");
  setsaveddvar("sm_roundRobinPrioritySpotShadows", 4);
  var_0 = getspawnerarray("tut_suckout_spawner");
  thread _id_10178();
  thread _id_6992();
  thread _id_1C12();
  var_1 = 0;
  var_2 = [];
  var_3 = [];

  foreach(var_5 in var_0) {
    var_5._id_EDD2 = 0;
    var_6 = var_5 scripts\sp\utility::_id_10619(1);
    var_2[var_2.size] = var_6;
    var_6 scripts\sp\utility::_id_51E1("casual_gun");
    var_6.ignoreall = 1;
    var_6.ignoreme = 1;
    var_6.fixednode = 1;

    if(isDefined(var_6.script_noteworthy))
      var_1 = var_6;
  }

  var_8 = getEnt("get_suckout_guys_attention", "targetname");
  var_8 waittill("trigger", var_9);

  if(var_9 == level.player)
    var_10 = 1;
  else
    var_10 = 0;

  var_1 thread _id_12A9F();
  thread _id_B28F(var_2, var_1);
  var_11 = scripts\engine\utility::getStructArray("tut_window_damage_struct", "targetname");
  var_12 = [];
  var_13 = 0;

  foreach(var_15 in var_11) {
    var_16 = scripts\engine\utility::spawn_tag_origin(var_15.origin);
    var_12[var_12.size] = var_16;
  }

  thread _id_4B06(var_12, var_2);
  var_2 = scripts\sp\utility::array_removedeadvehicles(var_2);

  while(var_2.size >= 3 && !scripts\engine\utility::flag("blow_out_windows")) {
    var_2 = scripts\sp\utility::array_removedeadvehicles(var_2);
    wait 0.1;
  }

  if(getaicount("axis") >= 3) {
    var_2 = scripts\sp\utility::array_removedeadvehicles(var_2);

    foreach(var_6 in var_2) {
      var_6 scripts\sp\utility::_id_F2D8(10000);
      var_6.goalradius = 400;
      var_6 setgoalentity(level.player);
    }
  }

  level notify("stop_tut_lights");

  foreach(var_16 in var_12) {
    radiusdamage(var_16.origin, 128, 9999, 9999);
    var_16 delete();
  }
}

_id_12A9D() {
  var_0 = getEnt("tut_alert_guys", "targetname");

  if(isDefined(var_0))
    var_0 scripts\sp\utility::_id_13635(10);

  level.player notify("enemies_triggered");
}

_id_12A9F() {
  wait 1;

  if(isDefined(self))
    scripts\sp\utility::_id_10347("moon_sdf1_wedontmoveon");
}

_id_B28F(var_0, var_1) {
  thread _id_12A9D();
  level.player scripts\engine\utility::waittill_any("shutter_alerted", "weapon_fired", "enemies_triggered", "grenade_fire", "offhand_end");
  level.player scripts\sp\utility::_id_F526("normal");

  if(isDefined(var_1))
    var_1 thread _id_AAE6();

  foreach(var_3 in var_0) {
    if(isDefined(var_3)) {
      var_3 scripts\sp\utility::_id_4145();
      var_3.ignoreall = 0;
      var_3.ignoreme = 0;
    }
  }

  thread _id_CCFB(var_0);
  scripts\engine\utility::flag_set("tut_start_suckout_event");
}

_id_AAE6() {
  thread scripts\sp\utility::_id_10347("moon_sdf3_satoforces");
  self _meth_82A2(%stand_exposed_wave_move_out, 1.0, 0.2, 1.0);
}

_id_1C12() {
  foreach(var_1 in level.allies)
  var_1.ignoreall = 1;

  for(;;) {
    var_3 = getEnt("get_suckout_guys_attention", "targetname");
    var_3 waittill("trigger", var_4);

    if(var_4 == level.player) {
      break;
    }
  }

  foreach(var_1 in level.allies)
  var_1.ignoreall = 0;
}

_id_CCFB(var_0) {
  var_0 = sortbydistance(var_0, level.player.origin);
  var_0[0] playSound("SD_0_callout_clock_12");
  var_1 = 0;

  foreach(var_3 in var_0) {
    var_3 scripts\engine\utility::delaycall(randomfloatrange(0.5, 1.5), ::playsound, "SD_" + var_1 + "_response_ack_yes");
    var_1++;

    if(var_1 > 4)
      var_1 = 0;
  }

  scripts\sp\utility::_id_28D8("axis");
  scripts\sp\utility::_id_28D8("allies");
}

_id_4B06(var_0, var_1) {
  level waittill("tut_decomp");

  foreach(var_3 in var_0) {
    if(isDefined(var_3))
      radiusdamage(var_3.origin, 96, 9999, 9999);
  }

  wait 4;
  var_1 = scripts\sp\utility::array_removedeadvehicles(var_1);

  foreach(var_6 in var_1)
  var_6 _meth_81D0();

  level notify("explo_decomp");
}

_id_10178() {
  var_0 = getEnt("shut_tut_mon_clip", "targetname");
  var_1 = getEnt("shut_tut_item_clip", "targetname");
  var_0 hide();
  var_0 connectpaths();
  level waittill("explo_decomp");
  var_1 moveTo(var_1.origin + (0, 0, 65), 2);
  wait 2;
  wait 1;
  var_1 delete();
  var_0 show();
  var_0 disconnectPaths();
}

_id_8E3E(var_0) {
  self._id_12A9E = self.goalradius;
  self.goalradius = 200;
  scripts\sp\utility::_id_54F7();
  scripts\sp\utility::_id_61E7();
  thread _id_10981();
  scripts\engine\utility::flag_wait("tutorials_player_left_airlock");
  wait(var_0);
  _id_8E3D();
  _id_8E33(var_0);
  _id_8E41();
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F3B5("r");
  self.fixednode = 0;
  self.disablearrivals = 0;
  self.stopanimdistsq = 0;
}

_id_8E3D() {
  level endon("tp_service_used");
  var_0 = undefined;
  var_1 = 0;

  switch (self._id_1FBB) {
    case "salter":
      var_0 = getnode("tut_right_path", "targetname");
      var_1 = 1;
      break;
    case "eth3n":
      var_0 = getnode("tut_left_path", "targetname");
      break;
    case "marineCO":
      level.allies["eth3n"] waittill("goal");
      var_0 = getnode("tut_left_path", "targetname");
      break;
    default:
      break;
  }

  for(;;) {
    self _meth_82EE(var_0);
    self waittill("goal");

    if(isDefined(var_0.target)) {
      var_0 = getnode(var_0.target, "targetname");
      continue;
    }

    if(var_1) {
      if(!isDefined(self._id_12AA0)) {
        self._id_12AA0 = 1;

        if(self == level.allies["salter"])
          var_0 = getnode("tut_right_path0", "targetname");
        else
          var_0 = getnode("tut_right_path1", "targetname");
      } else {
        self._id_12AA0 = undefined;
        break;
      }
    } else
      break;
  }
}

_id_8E33(var_0) {
  scripts\sp\utility::_id_65E0("reached_to_wallrun");
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F3B5("r");
  scripts\engine\utility::flag_wait("shutter_tut_done");
  self.fixednode = 1;
  scripts\engine\utility::flag_wait_or_timeout("blow_out_windows", 3);

  if(self == level.allies["marineCO"])
    thread _id_D6E7();

  wait 3;
  scripts\sp\utility::_id_54F7();
  var_1 = getnode("wall_run_tut_node_2_" + self._id_1FBB, "targetname");

  if(isDefined(var_1)) {
    self _meth_82EE(var_1);
    scripts\engine\utility::flag_wait("commence_wallrun_2");
  }

  level endon("tp_service_used");
  wait(var_0);
  var_2 = scripts\engine\utility::getStruct("tut_wallrun_2_animnode", "targetname");
  var_2 scripts\sp\anim::_id_1F17(self, "tut_low_run");
  scripts\sp\utility::_id_65E1("reached_to_wallrun");
}

_id_D6E7() {
  wait 6;
  scripts\sp\utility::_id_10347("moon_mco_leadtheway");
}

_id_8E41() {
  var_0 = scripts\engine\utility::getStruct("tut_wallrun_2_animnode", "targetname");

  switch (self._id_1FBB) {
    case "salter":
      var_0 scripts\sp\anim::_id_1F35(self, "tut_low_run");
      break;
    case "marineCO":
      if(!scripts\sp\utility::_id_65DB("reached_to_wallrun"))
        wait 0.5;

      var_0 scripts\sp\anim::_id_1F35(self, "tut_low_run");
      break;
    case "eth3n":
      if(!scripts\sp\utility::_id_65DB("reached_to_wallrun"))
        wait 1;

      var_0 scripts\sp\anim::_id_1F35(self, "tut_high_run");
      break;
    default:
      break;
  }
}

_id_10981() {
  scripts\engine\utility::flag_wait("play_news_bink_mp");
  scripts\sp\utility::_id_5514();
  scripts\sp\utility::_id_4145();
}

_id_DE2C(var_0) {
  self._id_12A9E = self.goalradius;
  self.goalradius = 200;
  scripts\sp\utility::_id_54F7();
  thread _id_10981();
  scripts\engine\utility::flag_wait("tutorials_player_left_airlock");
  wait(var_0);
  _id_DE2B();
  _id_DE2A(var_0);
  _id_DE2E();
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F3B5("g");
  self.fixednode = 0;
  self.disablearrivals = 0;
  self.stopanimdistsq = 0;
}

_id_DE2B() {
  level endon("tp_service_used");
  var_0 = undefined;
  var_1 = 0;
  wait 1;

  switch (self._id_1FBB) {
    case "marine1":
      level.allies["salter"] waittill("goal");
      var_0 = getnode("tut_right_path", "targetname");
      var_1 = 1;
      break;
    case "marine2":
      level.allies["salter"] waittill("goal");
      level.allies["marine1"] waittill("goal");
      var_0 = getnode("tut_right_path", "targetname");
      var_1 = 1;
      break;
    default:
      break;
  }

  for(;;) {
    self _meth_82EE(var_0);
    self waittill("goal");

    if(isDefined(var_0.target)) {
      var_0 = getnode(var_0.target, "targetname");
      continue;
    }

    if(var_1) {
      if(!isDefined(self._id_12AA0)) {
        self._id_12AA0 = 1;

        if(self == level.allies["salter"])
          var_0 = getnode("tut_right_path0", "targetname");
        else
          var_0 = getnode("tut_right_path1", "targetname");
      } else {
        self._id_12AA0 = undefined;
        break;
      }
    } else
      break;
  }
}

_id_DE2A(var_0) {
  scripts\sp\utility::_id_65E0("reached_to_wallrun");
  scripts\sp\utility::_id_61C7();
  scripts\sp\utility::_id_F3B5("g");
  scripts\engine\utility::flag_wait("shutter_tut_done");
  self.fixednode = 1;
  scripts\engine\utility::flag_wait_or_timeout("blow_out_windows", 3);
  wait 3;
  scripts\sp\utility::_id_54F7();
  var_1 = getnode("wall_run_tut_node_2_" + self._id_1FBB, "targetname");

  if(isDefined(var_1)) {
    self _meth_82EE(var_1);
    scripts\engine\utility::flag_wait("commence_wallrun_2");
  }

  level endon("tp_service_used");
  wait(var_0);
  var_2 = scripts\engine\utility::getStruct("tut_wallrun_2_animnode", "targetname");
  var_2 scripts\sp\anim::_id_1F17(self, "tut_low_run");
  scripts\sp\utility::_id_65E1("reached_to_wallrun");
  scripts\sp\utility::_id_F3B5("g");
}

_id_DE2E() {
  var_0 = scripts\engine\utility::getStruct("tut_wallrun_2_animnode", "targetname");

  switch (self._id_1FBB) {
    case "marine1":
      if(!scripts\sp\utility::_id_65DB("reached_to_wallrun"))
        wait 1.5;

      var_0 scripts\sp\anim::_id_1F35(self, "tut_low_run");
      break;
    case "marine2":
      if(!scripts\sp\utility::_id_65DB("reached_to_wallrun"))
        wait 2;

      var_0 scripts\sp\anim::_id_1F35(self, "tut_high_run");
      break;
    default:
      break;
  }
}