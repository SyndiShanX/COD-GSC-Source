/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace.gsc
***********************************************/

main() {
  scripts\sp\utility::_id_116CB("phspace");
  setdvarifuninitialized("dont_load_nextmission", 0);
  setdvarifuninitialized("E3", 0);

  if(getdvarint("e3", 1)) {
    scripts\sp\utility::_id_F305();

    if(scripts\sp\utility::_id_9BEE()) {
      if(level._id_DADC) {
        setsaveddvar("r_postaa", 5);
      }
    }
  }

  scripts\sp\maps\phspace\gen\phspace_art::main();
  scripts\sp\maps\phspace\phspace_fx::main();
  scripts\sp\maps\phspace\phspace_precache::main();
  scripts\sp\maps\phspace\phspace_anim::main();
  _id_0B53::_id_B908("veh_mil_air_ca_destroyer", "sp/model_damage_tables/veh_mil_air_ca_destroyer_weapons.csv", "sp/model_damage_tables/veh_mil_air_ca_destroyer_fx.csv");
  var_0 = ["phspace_ground_lite_tr"];
  var_1 = ["phspace_base_tr", "phspace_shared_tr", "phspace_ground_tr", "phspace_ground_lite_tr"];
  var_2 = ["phspace_base_tr", "phspace_shared_tr", "phspace_ground_tr"];
  var_3 = ["phspace_base_tr", "phspace_shared_tr", "phspace_space_tr"];
  var_4 = ["phspace_shared_tr", "phspace_space_tr"];
  scripts\sp\utility::_id_F343("hvt_handoff");
  scripts\sp\utility::_id_1749("hvt_handoff", scripts\sp\maps\phspace\phspace_launch::_id_8A08, "", scripts\sp\maps\phspace\phspace_launch::_id_8A06, var_1, scripts\sp\maps\phspace\phspace_launch::_id_89FF);
  scripts\sp\utility::_id_1749("jackals", scripts\sp\maps\phspace\phspace_launch::_id_A418, "", scripts\sp\maps\phspace\phspace_launch::_id_A417, var_1, scripts\sp\maps\phspace\phspace_launch::_id_A413);
  scripts\sp\utility::_id_1749("space_approach", scripts\sp\maps\phspace\phspace_battle::_id_104B7, "", scripts\sp\maps\phspace\phspace_battle::_id_104B6, var_3, scripts\sp\maps\phspace\phspace_battle::_id_104B4);
  scripts\sp\utility::_id_1749("jackal_assault", scripts\sp\maps\phspace\phspace_battle::_id_A0AC, "", scripts\sp\maps\phspace\phspace_battle::_id_A0A9, var_3, scripts\sp\maps\phspace\phspace_battle::_id_A0A4);
  scripts\sp\utility::_id_1749("ship_assault", scripts\sp\maps\phspace\phspace_battle::_id_FD19, "", scripts\sp\maps\phspace\phspace_battle::_id_FCFF, var_3, scripts\sp\maps\phspace\phspace_battle::_id_FCEB);
  scripts\sp\utility::_id_1749("mons_intro", scripts\sp\maps\phspace\phspace_mons::_id_BAB2, "", scripts\sp\maps\phspace\phspace_mons::_id_BAAC, var_3, scripts\sp\maps\phspace\phspace_mons::_id_BAA1);
  scripts\sp\utility::_id_1749("trench_run", scripts\sp\maps\phspace\phspace_mons::_id_12705, "", scripts\sp\maps\phspace\phspace_mons::_id_126F9, var_3, scripts\sp\maps\phspace\phspace_mons::_id_126F8);
  scripts\sp\utility::_id_1749("ram", scripts\sp\maps\phspace\phspace_mons::_id_DC53, "", scripts\sp\maps\phspace\phspace_mons::_id_DC51, var_3, scripts\sp\maps\phspace\phspace_mons::_id_DC4D);
  scripts\sp\utility::_id_1749("landing", scripts\sp\maps\phspace\phspace_mons::_id_A82E, "", scripts\sp\maps\phspace\phspace_mons::_id_A7F5, var_3, scripts\sp\maps\phspace\phspace_mons::_id_A7DD);
  scripts\sp\utility::_id_1749("post_impact_damage_test", scripts\sp\maps\phspace\phspace_mons::_id_9347, "", scripts\sp\maps\phspace\phspace_mons::_id_9346, var_3, scripts\sp\maps\phspace\phspace_mons::_id_A7DD);
  scripts\sp\utility::_id_1263F("phspace_base_tr");
  scripts\sp\utility::_id_1263F("phspace_ground_lite_tr");
  scripts\sp\utility::_id_1263F("phspace_ground_tr");
  scripts\sp\utility::_id_1263F("phspace_shared_tr");
  scripts\sp\utility::_id_1263F("phspace_space_tr");
  scripts\sp\load::main();
  setsaveddvar("r_dof_hq", 0);
  _id_CAE3();
  scripts\sp\maps\phspace\phspace_lights::main();

  if(getdvarint("r_reflectionProbeGenerate") != 1) {
    _id_CAE4();
  }

  setsaveddvar("fx_lighting_shscale", "1 0.5 1 1");
}

_id_CAE3() {
  precacherumble("damage_heavy");
  precacherumble("heavygun_fire");
  scripts\sp\maps\phspace\phspace_launch::_id_CADC();
  scripts\sp\maps\phspace\phspace_battle::_id_CADB();
  scripts\sp\maps\phspace\phspace_mons::_id_CAE0();
  scripts\engine\utility::flag_init("hint_did_basics");
  scripts\engine\utility::flag_init("hint_did_boosters");
  scripts\engine\utility::flag_init("hint_did_updown");
  scripts\engine\utility::flag_init("hint_did_cannons");
  scripts\engine\utility::flag_init("hill_allies_start");
  scripts\engine\utility::flag_set("hill_allies_start");
  scripts\engine\utility::flag_init("jackals_start_call_in");
  scripts\engine\utility::flag_init("jackals_landed");
  precachestring(&"PHSPACE_OBJ_PLAYER_JACKAL");
  precachestring(&"PHSPACE_OBJ_ASSIST_REPEL");
  precachestring(&"PHSPACE_OBJ_SDF_SQUADRON");
  precachestring(&"PHSPACE_OBJ_SDF_DESTROYER");
  precachestring(&"PHSPACE_OBJ_RETURN_TO_RET");
  precachestring(&"PHSPACE_OBJ_MONS");
  scripts\sp\utility::_id_16EB("basic_controls", &"PHSPACE_BASICS", ::_id_8FFB);
  scripts\sp\utility::_id_16EB("basic_controls_pc", &"PHSPACE_BASICS_PC", ::_id_8FFB);
  scripts\sp\utility::_id_16EB("basic_boosters", &"JACKAL_BOOST", ::_id_8FFC);
  scripts\sp\utility::_id_16EB("basic_boosters_pc", &"JACKAL_BOOST_PC", ::_id_8FFC);
  scripts\sp\utility::_id_16EB("basic_updown", &"PHSPACE_UPDOWN", ::_id_9002);
  scripts\sp\utility::_id_16EB("hint_shoot_jackals", &"PHSPACE_HINT_ATTACK_JACKALS", ::_id_8FFD);
  scripts\sp\utility::_id_16EB("hint_lockon", &"JACKAL_ADS", ::_id_8FFF);
  scripts\sp\utility::_id_16EB("hint_shoot_ships", &"PHSPACE_HINT_ATTACK_SHIPS", ::_id_9001);
  scripts\sp\utility::_id_16EB("hint_return_to_ret", &"PHSPACE_HINT_RETURN", ::_id_9000);
  scripts\sp\utility::_id_16EB("hint_leaving_battle", &"PHSPACE_HINT_LEAVING", ::_id_8FFE);
  scripts\sp\utility::_id_16EB("hint_switch_cannons", &"PHSPACE_HINT_CANNON", ::_id_9012);
  precachemodel("s1_handcuffs");
  precachemodel("decor_aatis_tower_globe_01");
  precachemodel("vm_hero_protagonist_helmet");
  precachemodel("veh_mil_air_un_jackal_01_rocket");
  precachemodel("veh_mil_air_ca_olympus_mons_bridge_piece");
  precachemodel("veh_mil_air_un_jackal_drone_space_periph");
  precachemodel("veh_mil_air_un_retribution_ftl_a");
  precachemodel("veh_mil_air_un_retribution_ftl_a_r");
  precachemodel("veh_mil_air_un_retribution_ftl_b");
  precachemodel("veh_mil_air_un_retribution_ftl_b_r");
  precachemodel("viewmodel_base_animated_naval");
  precachemodel("body_hero_protagonist_vm_legs_naval");
  precachemodel("viewmodel_base_viewhands_iw7_naval");
  precachemodel("veh_mil_air_un_retribution_details_door");
  precachemodel("veh_mil_air_ca_olympus_mons_dmg");
  precachemodel("veh_mil_air_un_retribution_dmg");
  precacheitem("spaceship_30mm_projectile_large_radius");
  thread _id_CF3C();
}

_id_CAE4() {
  setsaveddvar("sm_sunSampleSizeNear", 0.72);
  setsaveddvar("sm_sunCascadeSizeMultiplier2", 6);
  level._id_4D4D = "brackish";
  setsaveddvar("sm_sunTransCascadeSize1", 3);
  setsaveddvar("fx_lightmap_max_level", 4);
  setsaveddvar("spaceshipAiMinFlySpeed", 100);
  setsaveddvar("spaceshipAiMinFlyAngleDot", -1);
  _id_0BDC::_id_10CD8();
  level._id_52D1 = [];
  level._id_A242 = 0;
  level._id_A06E = 0;
  level._id_A1A3 = 0;
  level._id_B81B = 30;
  level._id_11937 = 0.05;
  thread scripts\sp\utility::_id_241F(1);
  scripts\engine\utility::array_thread(getEntArray("animated_models", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1F8A);
  scripts\engine\utility::array_thread(getEntArray("player_disable_stance", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::_id_D024);
  var_0 = getEnt("jackal_callin_player_clip", "targetname");
  var_1 = getEnt("jackal_callin_salter_clip", "targetname");

  if(isDefined(var_0)) {
    var_0 notsolid();
  }

  if(isDefined(var_1)) {
    var_1 notsolid();
  }

  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_wallrun(0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1028E();
  thread _id_B8C5();
  var_2 = getEnt("viz_ret", "targetname");

  if(isDefined(var_2)) {
    var_2 hide();
    var_2 notsolid();
    var_3 = getEnt("viz_tigris", "targetname");
    var_3 hide();
    var_3 notsolid();
  }

  if(level._id_10CDA != "test_lighttweaks_enabled") {
    thread _id_CADF();
  }

  if(level._id_10CDA != "hvt_handoff" && level._id_10CDA != "jackals" && level._id_10CDA != "jackals_reveal") {
    thread _id_CA28();
    scripts\sp\utility::_id_10FEC("ground_fx");
    thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_1028C();

    if(level._id_10CDA == "space_approach") {
      scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_E485, 0.05);
      scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C46(level._id_111D0._id_E487, level._id_111D0._id_E486, 0.05);
    } else if(level._id_10CDA != "test_lighttweaks_enabled") {
      scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C44(level._id_111D0._id_1022B, 0.05);
      scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C46(level._id_111D0._id_6C28, level._id_111D0._id_6C27, 0.05);
      scripts\sp\maps\pearlharbor\pearlharbor_util::_id_3C47(level._id_111D0._id_6C23, 0.05);
    }

    setglobalsoundcontext("atmosphere", "space", 2);
    scripts\sp\maps\phspace\phspace_launch::_id_1050B();
    thread _id_0F0E::_id_F901();
    thread scripts\sp\maps\phspace\phspace_battle::_id_CF9B();
  } else
    thread scripts\sp\maps\pearlharbor\pearlharbor_util::_id_48BF();

  var_4 = getEnt("tower_left_door", "targetname");
  var_5 = getEnt("tower_right_door", "targetname");

  if(isDefined(var_4)) {
    var_4.clip = var_4 scripts\engine\utility::get_target_ent();
    var_4.clip connectpaths();
    var_4.clip delete();
    var_4 delete();
  }

  if(isDefined(var_5)) {
    var_5.clip = var_5 scripts\engine\utility::get_target_ent();
    var_5.clip connectpaths();
    var_5.clip delete();
    var_5 delete();
  }

  _id_970B();

  if(getdvarint("e3", 0) == 1 || getdvarint("exec_review", 0) == 1) {
    setsaveddvar("sm_spotUpdateLimit", 8);
    setsaveddvar("r_umbraMinObjectContribution", 0);
  }

  var_6 = scripts\engine\utility::getStruct("e3_door_struct", "targetname");

  if(isDefined(var_6)) {
    var_7 = getEnt(var_6.target, "targetname");
    var_8 = getEnt(var_7.target, "targetname");
    var_7 delete();
    var_8 delete();
  }

  var_9 = getEnt("runway_hangar_door", "targetname");
  var_7 = getEnt(var_9.target, "targetname");

  if(isDefined(var_9)) {
    var_9 delete();
  }

  if(isDefined(var_7)) {
    var_7 delete();
  }
}

_id_970B() {
  scripts\engine\utility::flag_wait("phspace_shared_tr_loaded");
  _id_0B51::_id_B8CA();
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("hide");
  level._id_FD6E._id_E35D _id_0B51::_id_FDCB("notsolid");
}

_id_8FFB() {
  if(scripts\engine\utility::flag("hint_did_basics")) {
    return 1;
  }

  return 0;
}

_id_8FFC() {
  if(scripts\engine\utility::flag("hint_did_boosters")) {
    return 1;
  }

  return 0;
}

_id_9002() {
  if(scripts\engine\utility::flag("hint_did_updown")) {
    return 1;
  }

  return 0;
}

_id_8FFD() {
  return 0;
}

_id_8FFF() {
  var_0 = level.player _meth_848A();

  if(isDefined(var_0) && var_0[1] == 1) {
    level notify("player_did_lockon");
    return 1;
  }

  return 0;
}

_id_9001() {
  if(!isDefined(level._id_A8B9) || !isalive(level._id_A8B9)) {
    return 1;
  }

  return 0;
}

_id_9000() {
  if(scripts\engine\utility::flag("olympus_arrived")) {
    return 1;
  }

  return 0;
}

_id_8FFE() {
  return 0;
}

_id_9012() {
  if(scripts\engine\utility::flag("hint_did_cannons")) {
    return 1;
  }

  return 0;
}

_id_107A0() {
  scripts\sp\vehicle::_id_1080C("jackal_player");
}

_id_107C0() {
  if(!isDefined(level._id_EA99)) {
    level._id_EA99 = scripts\sp\vehicle::_id_1080C("jackal_salter");
    level._id_A06E = level._id_A06E + 1;
  }

  level._id_EA99._id_1FBB = "salter_jackal";
  level._id_EA99.unittype = "jackal";
  level._id_EA99 _id_0BDC::_id_6B4C("fly", 1);
  level._id_EA99 _id_0BDC::_id_1998();
  level._id_EA99 scripts\engine\utility::delaythread(2.0, _id_0BDC::_id_A077, "veh_mil_air_un_jackal_livery_shell_02");
}

_id_1062E() {
  if(!isDefined(level._id_1CB9)) {
    level._id_1CB9 = _id_1062D("jackal_ally1");
    level._id_1CB9._id_1FBB = "jackal_ally1";
    level._id_A06E = level._id_A06E + 1;
  }
}

_id_1062B() {
  if(!isDefined(level._id_1D0B)) {
    level._id_1D0B = [];
  }

  level._id_1D0B[level._id_1D0B.size] = _id_1062D("jackal_ally_ambient1", 1);
  level._id_1D0B[level._id_1D0B.size] = _id_1062D("jackal_ally_ambient2", 1);
  level._id_1D0B[level._id_1D0B.size] = _id_1062D("jackal_ally_ambient3", 1);
  level._id_1D0B[level._id_1D0B.size] = _id_1062D("jackal_ally_ambient4", 1);
  level._id_1D0B[level._id_1D0B.size] = _id_1062D("jackal_ally_ambient5", 1);
  level._id_1D0B[level._id_1D0B.size] = _id_1062D("jackal_ally_ambient6", 1);
}

_id_1062D(var_0, var_1) {
  var_2 = scripts\sp\vehicle::_id_1080C(var_0);
  var_2.unittype = "jackal";
  var_2._id_1FBB = "generic";
  var_2._id_843F = 1;
  var_2 scripts\sp\vehicle::_id_8441();
  level._id_A06E = level._id_A06E + 1;
  var_2 thread _id_1CFF();
  var_2 _id_0BDC::_id_19AE("shoot_at_will");
  var_2 _id_0BDC::_id_A144();

  if(scripts\engine\utility::is_true(var_1)) {
    var_2 setModel("veh_mil_air_un_jackal_drone_space_periph");
  }

  return var_2;
}

_id_1CFF() {
  self waittill("death");
  level._id_A06E = level._id_A06E - 1;
}

_id_107B6() {
  if(isDefined(level._id_12B67)) {
    return;
  }
  var_0 = getEnt("un_retribution", "targetname");
  var_0._id_EEF9 = "missile_cluster_turret_un cannon_small_un,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  level._id_12B67 = scripts\sp\vehicle::_id_1080C("un_retribution");
  level._id_12B67 scripts\sp\vehicle::_id_8441();
  level._id_12B67._id_1FBB = "retribution";
  level._id_12B67 _id_0BB8::_id_39AE();
  level._id_12B67 castdistantshadows();
  level._id_12B67._id_E7D0 = 0;
  level._id_12B67 scripts\sp\anim::_id_F64A();
  thread _id_FBFB();
}

_id_FBFB() {
  wait 3;
  var_0 = spawn("script_origin", level._id_12B67.origin);
  var_0 linkTo(level._id_12B67);
  var_0 thread scripts\sp\utility::_id_10461("scn_phparade_capital_ship_close_lp", 1, 5, 1);
  level.player waittill("sfx_retr_loop_stop");
  wait 6;
  var_0 scripts\sp\utility::_id_10460(7, 1);
}

_id_107F6() {
  if(isDefined(level._id_12B7D)) {
    return;
  }
  level._id_12B7D = scripts\sp\vehicle::_id_1080C("un_tigris");
  level._id_12B7D scripts\sp\vehicle::_id_8441();
  level._id_12B7D solid();
  level._id_12B7D._id_1FBB = "tigris";
  level._id_12B7D castdistantshadows();
  level._id_12B7D._id_E7D0 = 0;
}

_id_10801() {
  if(!isDefined(level._id_395A)) {
    level._id_395A = scripts\sp\vehicle::_id_1080C("cap_ship_escort1");
  }
}

_id_CA28() {
  var_0 = getEnt("periph_mountains1", "targetname");

  if(isDefined(var_0)) {
    var_0 delete();
  }

  var_1 = getEnt("geneva_periph", "targetname");

  if(isDefined(var_1)) {
    var_1 delete();
  }
}

_id_D91E() {
  for(;;) {
    iprintln("angles\t = " + level._id_111D0._id_1120D);
    iprintln("light\t = " + level._id_111D0.suncolor);
    iprintln("intensity = " + level._id_111D0._id_99E5);
    wait 5;
  }
}

_id_CADF() {
  level._id_111D0 = scripts\engine\utility::spawn_tag_origin();
  level._id_111D0._id_1120D = getmapsunangles();
  level._id_111D0.suncolor = getmapsuncolorandintensity();
  level._id_111D0._id_99E5 = level._id_111D0.suncolor[3];
  level._id_111D0.suncolor = (level._id_111D0.suncolor[0], level._id_111D0.suncolor[1], level._id_111D0.suncolor[2]);
  level._id_111D0._id_75AC = (0, 0, 0);
  level._id_111D0._id_E487 = (1, 1, 1);
  level._id_111D0._id_E486 = 120;
  level._id_111D0._id_E481 = (0, 0, 0);
  level._id_111D0._id_6C28 = level._id_111D0._id_E487;
  level._id_111D0._id_6C27 = level._id_111D0._id_E486;
  level._id_111D0._id_6C23 = (-5, 0, 0);
  level._id_111D0._id_42D2 = (-72, 15, 0);
  level._id_111D0._id_42D3 = (-25, -157, 0);
  level._id_111D0._id_E485 = (-25, -157, 0);
  level._id_111D0._id_1022B = (-25, -157, 0);
  level._id_111D0._id_BA9E = (-48, -53, 0);
  level._id_111D0._id_DC4C = (-60, 167, 0);
  level._id_111D0.mons_warp_angles = (-13, 66, 0);
  level._id_111D0._id_A7D8 = (-31, 63.5, 0);
  scripts\engine\utility::flag_init("flag_pause_sun_fx_updates");

  for(;;) {
    if(scripts\engine\utility::flag("flag_pause_sun_fx_updates")) {
      wait 0.05;
      continue;
    }

    if(isDefined(level._id_D127) && level._id_D127 _id_0BDC::_id_A2A7()) {
      var_0 = level._id_D127.origin;
    } else {
      var_0 = level.player.origin;
    }

    var_1 = (200000, 0, 0);
    var_1 = rotatevector(var_1, level._id_111D0._id_1120D + level._id_111D0._id_75AC);
    level._id_111D0.origin = var_0 + var_1;
    wait 0.05;
  }
}

_id_ACBB() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::_id_BC53("start_jackals_dps");
}

_id_ACBA() {}

_id_104FD() {
  setsaveddvar("r_MBEnable", 1);
  setsaveddvar("r_mbViewModelEnable", 0);
  setsaveddvar("r_mbCameraTranslationInfluence", 0.25);
}

_id_CF3C() {
  setdvarifuninitialized("player_helmet", 0);

  for(;;) {
    if(!getdvarint("player_helmet")) {
      wait 0.05;
    }

    var_0 = spawn("script_model", (0, 0, 0));
    var_0 setModel("vm_hero_protagonist_helmet");
    var_0 _meth_81E2(level.player, "tag_camera", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
    level.player setviewmodeldepthoffield(2, 10);

    while(getdvarint("player_helmet")) {
      wait 0.05;
    }

    level.player setviewmodeldepthoffield(0, 0);
    var_0 delete();
  }
}

_id_10C49() {}

_id_B8C5() {
  scripts\sp\utility::_id_C264("OBJ_PLAYER_JACKAL");
  scripts\sp\utility::_id_C264("OBJ_ASSIST_REPEL");
  scripts\sp\utility::_id_C264("OBJ_SDF_SQUADRON");
  scripts\sp\utility::_id_C264("OBJ_SDF_DESTROYER");
  scripts\sp\utility::_id_C264("OBJ_RET_MONS");
  waittillframeend;
  var_0 = 0;

  if(level._id_10CDA != "default") {
    var_0 = 1;
  }

  switch (level._id_10CDA) {
    case "default":
    case "hvt_handoff":
      scripts\engine\utility::flag_wait("jackal_call_down");
    case "jackals":
      objective_add(scripts\sp\utility::_id_C264("OBJ_PLAYER_JACKAL"), "active", &"PHSPACE_OBJ_PLAYER_JACKAL");
      objective_state(scripts\sp\utility::_id_C264("OBJ_PLAYER_JACKAL"), "current");
      objective_add(scripts\sp\utility::_id_C264("OBJ_ASSIST_REPEL"), "active", &"PHSPACE_OBJ_ASSIST_REPEL");
      objective_state(scripts\sp\utility::_id_C264("OBJ_ASSIST_REPEL"), "current");
      _id_0BDC::_id_137CF();
      objective_state(scripts\sp\utility::_id_C264("OBJ_PLAYER_JACKAL"), "done");
      level.player notify("sfx_retr_loop_stop");
    case "space_approach":
      scripts\engine\utility::flag_wait("obj_sdf_squadron_start");
    case "jackal_assault":
      objective_add(scripts\sp\utility::_id_C264("OBJ_SDF_SQUADRON"), "active", &"PHSPACE_OBJ_SDF_SQUADRON");
      objective_state(scripts\sp\utility::_id_C264("OBJ_SDF_SQUADRON"), "current");
      scripts\engine\utility::flag_wait("jackal_assault_complete");
      objective_state(scripts\sp\utility::_id_C264("OBJ_SDF_SQUADRON"), "done");
    case "ship_assault":
      objective_add(scripts\sp\utility::_id_C264("OBJ_SDF_DESTROYER"), "active", &"PHSPACE_OBJ_SDF_DESTROYER");
      objective_state(scripts\sp\utility::_id_C264("OBJ_SDF_DESTROYER"), "current");
      scripts\engine\utility::flag_wait("ship_assault_complete");
      objective_state(scripts\sp\utility::_id_C264("OBJ_ASSIST_REPEL"), "done");
      objective_state(scripts\sp\utility::_id_C264("OBJ_SDF_DESTROYER"), "done");
    case "ram":
    case "trench_run":
    case "mons_intro":
      objective_add(scripts\sp\utility::_id_C264("OBJ_RET_MONS"), "active", &"PHSPACE_OBJ_RETURN_TO_RET");
      objective_state(scripts\sp\utility::_id_C264("OBJ_RET_MONS"), "current");
      scripts\engine\utility::flag_wait("olympus_arrived");
      objective_string(scripts\sp\utility::_id_C264("OBJ_RET_MONS"), &"PHSPACE_OBJ_MONS");

      while(!scripts\engine\utility::flag_exist("flag_player_land")) {
        wait 0.05;
      }

      scripts\engine\utility::flag_wait("flag_player_land");
    case "landing":
      objective_string(scripts\sp\utility::_id_C264("OBJ_RET_MONS"), &"PHSPACE_OBJ_RETURN_TO_RET");
    default:
  }
}