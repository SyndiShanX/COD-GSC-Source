/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\phspace\phspace.gsc
***********************************************/

main() {
  scripts\sp\utility::func_116CB("phspace");
  setdvarifuninitialized("dont_load_nextmission", 0);
  setdvarifuninitialized("E3", 0);

  if(getdvarint("e3", 1)) {
    scripts\sp\utility::func_F305();

    if(scripts\sp\utility::func_9BEE()) {
      if(level.func_DADC) {
        _setsaveddvar("r_postaa", 5);
      }
    }
  }

  scripts\sp\maps\phspace\gen\phspace_art::main();
  scripts\sp\maps\phspace\phspace_fx::main();
  scripts\sp\maps\phspace\phspace_precache::main();
  scripts\sp\maps\phspace\phspace_anim::main();
  func_0B53::func_B908("veh_mil_air_ca_destroyer", "sp\model_damage_tables\veh_mil_air_ca_destroyer_weapons.csv", "sp\model_damage_tables\veh_mil_air_ca_destroyer_fx.csv");
  var_00 = ["phspace_ground_lite_tr"];
  var_01 = ["phspace_base_tr", "phspace_shared_tr", "phspace_ground_tr", "phspace_ground_lite_tr"];
  var_02 = ["phspace_base_tr", "phspace_shared_tr", "phspace_ground_tr"];
  var_03 = ["phspace_base_tr", "phspace_shared_tr", "phspace_space_tr"];
  var_04 = ["phspace_shared_tr", "phspace_space_tr"];
  scripts\sp\utility::func_F343("hvt_handoff");
  scripts\sp\utility::func_1749("hvt_handoff", scripts\sp\maps\phspace\phspace_launch::func_8A08, "", scripts\sp\maps\phspace\phspace_launch::func_8A06, var_01, scripts\sp\maps\phspace\phspace_launch::func_89FF);
  scripts\sp\utility::func_1749("jackals", scripts\sp\maps\phspace\phspace_launch::func_A418, "", scripts\sp\maps\phspace\phspace_launch::func_A417, var_01, scripts\sp\maps\phspace\phspace_launch::func_A413);
  scripts\sp\utility::func_1749("space_approach", scripts\sp\maps\phspace\phspace_battle::func_104B7, "", scripts\sp\maps\phspace\phspace_battle::func_104B6, var_03, scripts\sp\maps\phspace\phspace_battle::func_104B4);
  scripts\sp\utility::func_1749("jackal_assault", scripts\sp\maps\phspace\phspace_battle::func_A0AC, "", scripts\sp\maps\phspace\phspace_battle::func_A0A9, var_03, scripts\sp\maps\phspace\phspace_battle::func_A0A4);
  scripts\sp\utility::func_1749("ship_assault", scripts\sp\maps\phspace\phspace_battle::func_FD19, "", scripts\sp\maps\phspace\phspace_battle::func_FCFF, var_03, scripts\sp\maps\phspace\phspace_battle::func_FCEB);
  scripts\sp\utility::func_1749("mons_intro", scripts\sp\maps\phspace\phspace_mons::func_BAB2, "", scripts\sp\maps\phspace\phspace_mons::func_BAAC, var_03, scripts\sp\maps\phspace\phspace_mons::func_BAA1);
  scripts\sp\utility::func_1749("trench_run", scripts\sp\maps\phspace\phspace_mons::func_12705, "", scripts\sp\maps\phspace\phspace_mons::func_126F9, var_03, scripts\sp\maps\phspace\phspace_mons::func_126F8);
  scripts\sp\utility::func_1749("ram", scripts\sp\maps\phspace\phspace_mons::func_DC53, "", scripts\sp\maps\phspace\phspace_mons::func_DC51, var_03, scripts\sp\maps\phspace\phspace_mons::func_DC4D);
  scripts\sp\utility::func_1749("landing", scripts\sp\maps\phspace\phspace_mons::func_A82E, "", scripts\sp\maps\phspace\phspace_mons::func_A7F5, var_03, scripts\sp\maps\phspace\phspace_mons::func_A7DD);
  scripts\sp\utility::func_1749("post_impact_damage_test", scripts\sp\maps\phspace\phspace_mons::func_9347, "", scripts\sp\maps\phspace\phspace_mons::func_9346, var_03, scripts\sp\maps\phspace\phspace_mons::func_A7DD);
  scripts\sp\utility::func_1263F("phspace_base_tr");
  scripts\sp\utility::func_1263F("phspace_ground_lite_tr");
  scripts\sp\utility::func_1263F("phspace_ground_tr");
  scripts\sp\utility::func_1263F("phspace_shared_tr");
  scripts\sp\utility::func_1263F("phspace_space_tr");
  scripts\sp\load::main();
  _setsaveddvar("r_dof_hq", 0);
  func_CAE3();
  scripts\sp\maps\phspace\phspace_lights::main();

  if(getdvarint("r_reflectionProbeGenerate") != 1) {
    func_CAE4();
  }

  _setsaveddvar("fx_lighting_shscale", "1 0.5 1 1");
}

func_CAE3() {
  precacherumble("damage_heavy");
  precacherumble("heavygun_fire");
  scripts\sp\maps\phspace\phspace_launch::func_CADC();
  scripts\sp\maps\phspace\phspace_battle::func_CADB();
  scripts\sp\maps\phspace\phspace_mons::func_CAE0();
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
  scripts\sp\utility::func_16EB("basic_controls", &"PHSPACE_BASICS", ::func_8FFB);
  scripts\sp\utility::func_16EB("basic_controls_pc", &"PHSPACE_BASICS_PC", ::func_8FFB);
  scripts\sp\utility::func_16EB("basic_boosters", &"JACKAL_BOOST", ::func_8FFC);
  scripts\sp\utility::func_16EB("basic_boosters_pc", &"JACKAL_BOOST_PC", ::func_8FFC);
  scripts\sp\utility::func_16EB("basic_updown", &"PHSPACE_UPDOWN", ::func_9002);
  scripts\sp\utility::func_16EB("hint_shoot_jackals", &"PHSPACE_HINT_ATTACK_JACKALS", ::func_8FFD);
  scripts\sp\utility::func_16EB("hint_lockon", &"JACKAL_ADS", ::func_8FFF);
  scripts\sp\utility::func_16EB("hint_shoot_ships", &"PHSPACE_HINT_ATTACK_SHIPS", ::func_9001);
  scripts\sp\utility::func_16EB("hint_return_to_ret", &"PHSPACE_HINT_RETURN", ::func_9000);
  scripts\sp\utility::func_16EB("hint_leaving_battle", &"PHSPACE_HINT_LEAVING", ::func_8FFE);
  scripts\sp\utility::func_16EB("hint_switch_cannons", &"PHSPACE_HINT_CANNON", ::func_9012);
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
  thread func_CF3C();
}

func_CAE4() {
  _setsaveddvar("sm_sunSampleSizeNear", 0.72);
  _setsaveddvar("sm_sunCascadeSizeMultiplier2", 6);
  level.func_4D4D = "brackish";
  _setsaveddvar("sm_sunTransCascadeSize1", 3);
  _setsaveddvar("fx_lightmap_max_level", 4);
  _setsaveddvar("spaceshipAiMinFlySpeed", 100);
  _setsaveddvar("spaceshipAiMinFlyAngleDot", -1);
  func_0BDC::func_10CD8();
  level.func_52D1 = [];
  level.func_A242 = 0;
  level.func_A06E = 0;
  level.func_A1A3 = 0;
  level.func_B81B = 30;
  level.func_11937 = 0.05;
  thread scripts\sp\utility::func_241F(1);
  scripts\engine\utility::array_thread(getEntArray("animated_models", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::func_1F8A);
  scripts\engine\utility::array_thread(getEntArray("player_disable_stance", "script_noteworthy"), scripts\sp\maps\pearlharbor\pearlharbor_util::func_D024);
  var_00 = getent("jackal_callin_player_clip", "targetname");
  var_01 = getent("jackal_callin_salter_clip", "targetname");

  if(isDefined(var_00)) {
    var_00 notsolid();
  }

  if(isDefined(var_01)) {
    var_01 notsolid();
  }

  level.player scripts\engine\utility::allow_doublejump(0);
  level.player scripts\engine\utility::allow_wallrun(0);
  thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_1028E();
  thread func_B8C5();
  var_02 = getent("viz_ret", "targetname");

  if(isDefined(var_02)) {
    var_02 hide();
    var_02 notsolid();
    var_03 = getent("viz_tigris", "targetname");
    var_03 hide();
    var_03 notsolid();
  }

  if(level.func_10CDA != "test_lighttweaks_enabled") {
    thread func_CADF();
  }

  if(level.func_10CDA != "hvt_handoff" && level.func_10CDA != "jackals" && level.func_10CDA != "jackals_reveal") {
    thread func_CA28();
    scripts\sp\utility::func_10FEC("ground_fx");
    thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_1028C();

    if(level.func_10CDA == "space_approach") {
      scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_E485, 0.05);
      scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C46(level.func_111D0.func_E487, level.func_111D0.func_E486, 0.05);
    } else if(level.func_10CDA != "test_lighttweaks_enabled") {
      scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C44(level.func_111D0.func_1022B, 0.05);
      scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C46(level.func_111D0.func_6C28, level.func_111D0.func_6C27, 0.05);
      scripts\sp\maps\pearlharbor\pearlharbor_util::func_3C47(level.func_111D0.func_6C23, 0.05);
    }

    setglobalsoundcontext("atmosphere", "space", 2);
    scripts\sp\maps\phspace\phspace_launch::func_1050B();
    thread func_0F0E::func_F901();
    thread scripts\sp\maps\phspace\phspace_battle::func_CF9B();
  } else
    thread scripts\sp\maps\pearlharbor\pearlharbor_util::func_48BF();

  var_04 = getent("tower_left_door", "targetname");
  var_05 = getent("tower_right_door", "targetname");

  if(isDefined(var_04)) {
    var_4.clip = var_04 scripts\engine\utility::get_target_ent();
    var_4.clip connectpaths();
    var_4.clip delete();
    var_04 delete();
  }

  if(isDefined(var_05)) {
    var_5.clip = var_05 scripts\engine\utility::get_target_ent();
    var_5.clip connectpaths();
    var_5.clip delete();
    var_05 delete();
  }

  func_970B();

  if(getdvarint("e3", 0) == 1 || getdvarint("exec_review", 0) == 1) {
    _setsaveddvar("sm_spotUpdateLimit", 8);
    _setsaveddvar("r_umbraMinObjectContribution", 0);
  }

  var_06 = scripts\engine\utility::getstruct("e3_door_struct", "targetname");

  if(isDefined(var_06)) {
    var_07 = getent(var_6.target, "targetname");
    var_08 = getent(var_7.target, "targetname");
    var_07 delete();
    var_08 delete();
  }

  var_09 = getent("runway_hangar_door", "targetname");
  var_07 = getent(var_9.target, "targetname");

  if(isDefined(var_09)) {
    var_09 delete();
  }

  if(isDefined(var_07)) {
    var_07 delete();
  }
}

func_970B() {
  scripts\engine\utility::flag_wait("phspace_shared_tr_loaded");
  func_0B51::func_B8CA();
  level.func_FD6E.func_E35D func_0B51::func_FDCB("hide");
  level.func_FD6E.func_E35D func_0B51::func_FDCB("notsolid");
}

func_8FFB() {
  if(scripts\engine\utility::flag("hint_did_basics")) {
    return 1;
  }

  return 0;
}

func_8FFC() {
  if(scripts\engine\utility::flag("hint_did_boosters")) {
    return 1;
  }

  return 0;
}

func_9002() {
  if(scripts\engine\utility::flag("hint_did_updown")) {
    return 1;
  }

  return 0;
}

func_8FFD() {
  return 0;
}

func_8FFF() {
  var_00 = level.player _meth_848A();

  if(isDefined(var_00) && var_0[1] == 1) {
    level notify("player_did_lockon");
    return 1;
  }

  return 0;
}

func_9001() {
  if(!isDefined(level.func_A8B9) || !isalive(level.func_A8B9)) {
    return 1;
  }

  return 0;
}

func_9000() {
  if(scripts\engine\utility::flag("olympus_arrived")) {
    return 1;
  }

  return 0;
}

func_8FFE() {
  return 0;
}

func_9012() {
  if(scripts\engine\utility::flag("hint_did_cannons")) {
    return 1;
  }

  return 0;
}

func_107A0() {
  scripts\sp\vehicle::func_1080C("jackal_player");
}

func_107C0() {
  if(!isDefined(level.func_EA99)) {
    level.func_EA99 = scripts\sp\vehicle::func_1080C("jackal_salter");
    level.func_A06E = level.func_A06E + 1;
  }

  level.func_EA99.func_1FBB = "salter_jackal";
  level.func_EA99.unittype = "jackal";
  level.func_EA99 func_0BDC::func_6B4C("fly", 1);
  level.func_EA99 func_0BDC::func_1998();
  level.func_EA99 scripts\engine\utility::delaythread(2.0, func_0BDC::func_A077, "veh_mil_air_un_jackal_livery_shell_02");
}

func_1062E() {
  if(!isDefined(level.func_1CB9)) {
    level.func_1CB9 = func_1062D("jackal_ally1");
    level.func_1CB9.func_1FBB = "jackal_ally1";
    level.func_A06E = level.func_A06E + 1;
  }
}

func_1062B() {
  if(!isDefined(level.func_1D0B)) {
    level.func_1D0B = [];
  }

  level.func_1D0B[level.func_1D0B.size] = func_1062D("jackal_ally_ambient1", 1);
  level.func_1D0B[level.func_1D0B.size] = func_1062D("jackal_ally_ambient2", 1);
  level.func_1D0B[level.func_1D0B.size] = func_1062D("jackal_ally_ambient3", 1);
  level.func_1D0B[level.func_1D0B.size] = func_1062D("jackal_ally_ambient4", 1);
  level.func_1D0B[level.func_1D0B.size] = func_1062D("jackal_ally_ambient5", 1);
  level.func_1D0B[level.func_1D0B.size] = func_1062D("jackal_ally_ambient6", 1);
}

func_1062D(var_00, var_01) {
  var_02 = scripts\sp\vehicle::func_1080C(var_00);
  var_2.unittype = "jackal";
  var_2.func_1FBB = "generic";
  var_2._meth_843F = 1;
  var_02 scripts\sp\vehicle::playgestureviewmodel();
  level.func_A06E = level.func_A06E + 1;
  var_02 thread func_1CFF();
  var_02 func_0BDC::func_19AE("shoot_at_will");
  var_02 func_0BDC::func_A144();

  if(scripts\engine\utility::is_true(var_01)) {
    var_02 setModel("veh_mil_air_un_jackal_drone_space_periph");
  }

  return var_02;
}

func_1CFF() {
  self waittill("death");
  level.func_A06E = level.func_A06E - 1;
}

func_107B6() {
  if(isDefined(level.func_12B67)) {
    return;
  }
  var_00 = getent("un_retribution", "targetname");
  var_0.func_EEF9 = "missile_cluster_turret_un cannon_small_un,1,1,amb_turret_sml_t_l_1,amb_turret_sml_t_l_2,amb_turret_sml_t_l_3,amb_turret_sml_t_l_4,amb_turret_sml_t_r_1,amb_turret_sml_t_r_2,amb_turret_sml_t_r_3,amb_turret_sml_t_r_4";
  level.func_12B67 = scripts\sp\vehicle::func_1080C("un_retribution");
  level.func_12B67 scripts\sp\vehicle::playgestureviewmodel();
  level.func_12B67.func_1FBB = "retribution";
  level.func_12B67 func_0BB8::func_39AE();
  level.func_12B67 _meth_8064();
  level.func_12B67.func_E7D0 = 0;
  level.func_12B67 scripts\sp\anim::func_F64A();
  thread func_FBFB();
}

func_FBFB() {
  wait 3;
  var_00 = spawn("script_origin", level.func_12B67.origin);
  var_00 linkto(level.func_12B67);
  var_00 thread scripts\sp\utility::func_10461("scn_phparade_capital_ship_close_lp", 1, 5, 1);
  level.player waittill("sfx_retr_loop_stop");
  wait 6;
  var_00 scripts\sp\utility::func_10460(7, 1);
}

func_107F6() {
  if(isDefined(level.func_12B7D)) {
    return;
  }
  level.func_12B7D = scripts\sp\vehicle::func_1080C("un_tigris");
  level.func_12B7D scripts\sp\vehicle::playgestureviewmodel();
  level.func_12B7D solid();
  level.func_12B7D.func_1FBB = "tigris";
  level.func_12B7D _meth_8064();
  level.func_12B7D.func_E7D0 = 0;
}

func_10801() {
  if(!isDefined(level.func_395A)) {
    level.func_395A = scripts\sp\vehicle::func_1080C("cap_ship_escort1");
  }
}

func_CA28() {
  var_00 = getent("periph_mountains1", "targetname");

  if(isDefined(var_00)) {
    var_00 delete();
  }

  var_01 = getent("geneva_periph", "targetname");

  if(isDefined(var_01)) {
    var_01 delete();
  }
}

func_D91E() {
  for(;;) {
    iprintln("angles\\t = " + level.func_111D0.func_1120D);
    iprintln("light\\t = " + level.func_111D0.suncolor);
    iprintln("intensity = " + level.func_111D0.func_99E5);
    wait 5;
  }
}

func_CADF() {
  level.func_111D0 = scripts\engine\utility::spawn_tag_origin();
  level.func_111D0.func_1120D = _getmapsunangles();
  level.func_111D0.suncolor = _getmapsuncolorandintensity();
  level.func_111D0.func_99E5 = level.func_111D0.suncolor[3];
  level.func_111D0.suncolor = (level.func_111D0.suncolor[0], level.func_111D0.suncolor[1], level.func_111D0.suncolor[2]);
  level.func_111D0.func_75AC = (0, 0, 0);
  level.func_111D0.func_E487 = (1, 1, 1);
  level.func_111D0.func_E486 = 120;
  level.func_111D0.func_E481 = (0, 0, 0);
  level.func_111D0.func_6C28 = level.func_111D0.func_E487;
  level.func_111D0.func_6C27 = level.func_111D0.func_E486;
  level.func_111D0.func_6C23 = (-5, 0, 0);
  level.func_111D0.func_42D2 = (-72, 15, 0);
  level.func_111D0.func_42D3 = (-25, -157, 0);
  level.func_111D0.func_E485 = (-25, -157, 0);
  level.func_111D0.func_1022B = (-25, -157, 0);
  level.func_111D0.func_BA9E = (-48, -53, 0);
  level.func_111D0.func_DC4C = (-60, 167, 0);
  level.func_111D0.mons_warp_angles = (-13, 66, 0);
  level.func_111D0.func_A7D8 = (-31, 63.5, 0);
  scripts\engine\utility::flag_init("flag_pause_sun_fx_updates");

  for(;;) {
    if(scripts\engine\utility::flag("flag_pause_sun_fx_updates")) {
      wait 0.05;
      continue;
    }

    if(isDefined(level.func_D127) && level.func_D127 func_0BDC::func_A2A7()) {
      var_00 = level.func_D127.origin;
    } else {
      var_00 = level.player.origin;
    }

    var_01 = (200000, 0, 0);
    var_01 = rotatevector(var_01, level.func_111D0.func_1120D + level.func_111D0.func_75AC);
    level.func_111D0.origin = var_00 + var_01;
    wait 0.05;
  }
}

func_ACBB() {
  scripts\sp\maps\pearlharbor\pearlharbor_util::func_BC53("start_jackals_dps");
}

func_ACBA() {}

func_104FD() {
  _setsaveddvar("r_MBEnable", 1);
  _setsaveddvar("r_mbViewModelEnable", 0);
  _setsaveddvar("r_mbCameraTranslationInfluence", 0.25);
}

func_CF3C() {
  setdvarifuninitialized("player_helmet", 0);

  for(;;) {
    if(!getdvarint("player_helmet")) {
      wait 0.05;
    }

    var_00 = spawn("script_model", (0, 0, 0));
    var_00 setModel("vm_hero_protagonist_helmet");
    var_00 _meth_81E2(level.player, "tag_camera", (0, 0, 0), (0, 0, 0), 1, "view_jostle");
    level.player setviewmodeldepthoffield(2, 10);

    while(getdvarint("player_helmet")) {
      wait 0.05;
    }

    level.player setviewmodeldepthoffield(0, 0);
    var_00 delete();
  }
}

func_10C49() {}

func_B8C5() {
  scripts\sp\utility::func_C264("OBJ_PLAYER_JACKAL");
  scripts\sp\utility::func_C264("OBJ_ASSIST_REPEL");
  scripts\sp\utility::func_C264("OBJ_SDF_SQUADRON");
  scripts\sp\utility::func_C264("OBJ_SDF_DESTROYER");
  scripts\sp\utility::func_C264("OBJ_RET_MONS");
  waittillframeend;
  var_00 = 0;

  if(level.func_10CDA != "default") {
    var_00 = 1;
  }

  switch (level.func_10CDA) {
    case "default":
    case "hvt_handoff":
      scripts\engine\utility::flag_wait("jackal_call_down");
    case "jackals":
      _objective_add(scripts\sp\utility::func_C264("OBJ_PLAYER_JACKAL"), "active", &"PHSPACE_OBJ_PLAYER_JACKAL");
      objective_state(scripts\sp\utility::func_C264("OBJ_PLAYER_JACKAL"), "current");
      _objective_add(scripts\sp\utility::func_C264("OBJ_ASSIST_REPEL"), "active", &"PHSPACE_OBJ_ASSIST_REPEL");
      objective_state(scripts\sp\utility::func_C264("OBJ_ASSIST_REPEL"), "current");
      func_0BDC::func_137CF();
      objective_state(scripts\sp\utility::func_C264("OBJ_PLAYER_JACKAL"), "done");
      level.player notify("sfx_retr_loop_stop");
    case "space_approach":
      scripts\engine\utility::flag_wait("obj_sdf_squadron_start");
    case "jackal_assault":
      _objective_add(scripts\sp\utility::func_C264("OBJ_SDF_SQUADRON"), "active", &"PHSPACE_OBJ_SDF_SQUADRON");
      objective_state(scripts\sp\utility::func_C264("OBJ_SDF_SQUADRON"), "current");
      scripts\engine\utility::flag_wait("jackal_assault_complete");
      objective_state(scripts\sp\utility::func_C264("OBJ_SDF_SQUADRON"), "done");
    case "ship_assault":
      _objective_add(scripts\sp\utility::func_C264("OBJ_SDF_DESTROYER"), "active", &"PHSPACE_OBJ_SDF_DESTROYER");
      objective_state(scripts\sp\utility::func_C264("OBJ_SDF_DESTROYER"), "current");
      scripts\engine\utility::flag_wait("ship_assault_complete");
      objective_state(scripts\sp\utility::func_C264("OBJ_ASSIST_REPEL"), "done");
      objective_state(scripts\sp\utility::func_C264("OBJ_SDF_DESTROYER"), "done");
    case "ram":
    case "trench_run":
    case "mons_intro":
      _objective_add(scripts\sp\utility::func_C264("OBJ_RET_MONS"), "active", &"PHSPACE_OBJ_RETURN_TO_RET");
      objective_state(scripts\sp\utility::func_C264("OBJ_RET_MONS"), "current");
      scripts\engine\utility::flag_wait("olympus_arrived");
      _objective_string(scripts\sp\utility::func_C264("OBJ_RET_MONS"), &"PHSPACE_OBJ_MONS");

      while(!scripts\engine\utility::flag_exist("flag_player_land")) {
        wait 0.05;
      }

      scripts\engine\utility::flag_wait("flag_player_land");
    case "landing":
      _objective_string(scripts\sp\utility::func_C264("OBJ_RET_MONS"), &"PHSPACE_OBJ_RETURN_TO_RET");
    default:
  }
}