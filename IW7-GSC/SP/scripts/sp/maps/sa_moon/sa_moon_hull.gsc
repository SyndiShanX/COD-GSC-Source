/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\maps\sa_moon\sa_moon_hull.gsc
****************************************************/

_id_E93C() {
  scripts\engine\utility::flag_init("hull_combat_wave2kill");
  scripts\engine\utility::flag_init("zg_hull_start");
  scripts\engine\utility::flag_init("zerog_combat_space_end");
  scripts\engine\utility::flag_init("open_bay");
  scripts\engine\utility::flag_init("tube_cleanup");
  scripts\engine\utility::flag_init("zero_g_end");
  scripts\engine\utility::flag_init("hull_combat_wave1a");
}

_id_E93E() {
  _id_0F16::_id_3E3F("zerog_air_start");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_10628();
  _id_0F16::_id_3E3B("zerog_air_start");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_91B5();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_A127();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_3970();
  scripts\sp\maps\sa_moon\sa_moon_util::_id_E9CA(0);
  thread _id_91B6();
  thread _id_8918();
  thread _id_91C3();
  thread _id_91C4();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_8E92(1);
  var_0 = getEnt("carrier_damage_model", "targetname");
  var_0 hide();
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF9(1, 1);

  if(isDefined(level._id_9DD0)) {
    level.player _meth_80CB(1);
  }

  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_board", "current", &"SA_MOON_BOARD");
}

_id_E93A() {
  level.player thread _id_0F35::_id_D385();
  setsaveddvar("cg_helmetLinearVelocityToAngleRate", (1.2, 1.2, 2));
  setsaveddvar("cg_helmetViewSwayRate", -0.3);

  if(!scripts\engine\utility::flag("game_saving")) {
    scripts\sp\utility::_id_2679();
  }

  scripts\sp\utility::_id_F44E(0);
  setsaveddvar("antilagAllowHighDetailBroadphaseArchive", 0);
  thread _id_E93F();
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_91B4();
  scripts\sp\maps\sa_moon\sa_moon_fx::_id_132C5(0);
  thread _id_0F35::_id_FAFC();
  thread _id_13E9A();
  var_0 = getEntArray("hull_grap_vol", "targetname");
  scripts\engine\utility::array_thread(var_0, _id_0F31::_id_13544, 1);
  var_0 = getEntArray("hull_cover_grap_vol", "targetname");
  scripts\engine\utility::array_thread(var_0, _id_0F31::_id_13544, 1);
  wait 0.1;
  scripts\sp\utility::_id_28D8();
  scripts\sp\utility::_id_CF8D();
  scripts\sp\utility::_id_C27C(scripts\sp\utility::_id_C264("obj_board"));
  scripts\sp\maps\sa_moon\sa_moon_util::_id_1723("obj_shutdown_primary_defenses", "current", &"SA_MOON_OBJ_SHUTDOWN_PRIMARY_DEFENSES");
  var_1 = scripts\engine\utility::getStruct("hull_breach_point_obj", "targetname");
  scripts\sp\maps\sa_moon\sa_moon_util::_id_12DFB("obj_shutdown_primary_defenses", var_1.origin);
  level._id_3965 notsolid();
  wait 0.1;

  if(!isDefined(level._id_9DD0)) {
    thread scripts\sp\maps\sa_moon\sa_moon_util::_id_E9C8();
  }

  scripts\engine\utility::flag_wait("zerog_combat_space_end");
  scripts\sp\utility::_id_28D7();
  scripts\sp\utility::_id_CF8B();
  scripts\sp\utility::_id_6EEB("allies", 0);
}

sa01_hull_delete_spawners_e3() {
  var_0 = [];
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1s_e3", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1a_e3", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave2_e3", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1right_e3", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1left_e3", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1center_e3", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave3_e3", "script_noteworthy"));

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

sa01_hull_delete_spawners() {
  var_0 = [];
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1s", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1a", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave2", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1right", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave1left", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_7C84("hull_guys_wave3", "script_noteworthy"));
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\sp\utility::_id_8201("zerog_dropship1", "targetname"));

  foreach(var_2 in var_0) {
    var_2 delete();
  }
}

_id_E93F() {
  level endon("zerog_combat_space_end");
  scripts\engine\utility::flag_set("jackal_vo_done");
  _id_E93D();
  _id_E961();
  _id_E964();
  _id_E973();
  _id_E929();
}

_id_E93D() {
  level._id_679E scripts\sp\utility::_id_10346("mn_eth_bridge_dead_ahead");
  wait 0.5;
  scripts\sp\utility::_id_1034D("mn_plr_lets_get_there");
  wait 0.5;
}

_id_E961() {
  level endon("hull_combat_wave1a");
  scripts\engine\utility::flag_wait("open_bay");
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_we_got_hostiles");
  wait 0.5;
  scripts\sp\utility::_id_1034D("mn_plr_take_em");
  wait 2;
  level._id_C49F scripts\sp\utility::_id_10346("mn_omr_force_up");
}

_id_E964() {
  level endon("hull_combat_wave2spawn");
  scripts\engine\utility::flag_wait("hull_combat_wave1a");
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_more_incoming");
  wait 3;
  level._id_C49F scripts\sp\utility::_id_10346("mn_omr_dig_in");
  wait 4;
  level._id_C49F scripts\sp\utility::_id_10346("mn_omr_drive_em");
}

_id_E973() {
  level endon("hull_combat_wave3");
  scripts\engine\utility::flag_wait("hull_combat_wave2spawn");
  level._id_679E scripts\sp\utility::_id_10346("mn_eth_more_from_below");
  wait 2;
  scripts\sp\utility::_id_1034D("mn_plr_keep_pushing_48");
  wait 3;
}

_id_E929() {
  level endon("zerog_combat_space_end");
  scripts\engine\utility::flag_wait("hull_combat_wave3");
  level._id_679E scripts\sp\utility::_id_10346("mn_eth_on_debris");
  wait 0.1;
}

_id_13E9A() {
  wait 1;

  if(!isDefined(level._id_9DD0)) {
    sa01_hull_delete_spawners_e3();
  }

  if(isDefined(level._id_9DD0)) {
    foreach(var_1 in level._id_1C24) {
      var_1.accuracy = 10;
      var_1._id_2894 = 10;
    }
  }

  foreach(var_4 in level._id_3965.turrets) {
    foreach(var_6 in var_4) {
      var_6 setCanDamage(0);
    }
  }

  scripts\engine\utility::flag_set("open_bay");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_BB1F();
  thread _id_88DD();
  thread _id_8962();
  wait 1;
  thread _id_0F0E::_id_B2DB("axis_jackal_hull_alt", "axis_jackal_hull_alt_path", 2, 2);
  thread _id_0F0E::_id_B2DB("ally_jackal_hull_alt", "ally_jackal_hull_alt_path", 2, 2, undefined, 1);
  var_9 = getEnt("ally_jackal_hull_alt1", "script_noteworthy");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_91B7(var_9);

  if(!isDefined(level._id_9DD0)) {
    thread _id_0F16::_id_B2CC("hull_combat_wave1", "hull_guys_wave1s", "hull_combat_vol1", 2, "hull_combat_wave1a");
    thread _id_0F16::_id_B2CC("hull_combat_wave1a", "hull_guys_wave1a", "hull_combat_vol1a", 2, "hull_combat_wave2kill");
    thread _id_0F16::_id_B2CC("hull_combat_wave2spawn", "hull_guys_wave2", "hull_combat_vol2", 2, "hull_combat_wave3");
    thread _id_0F16::_id_B2CC("hull_combat_wave1right", "hull_guys_wave1right", "hull_combat_vol1right");
    thread _id_0F16::_id_B2CC("hull_combat_wave1left", "hull_guys_wave1left", "hull_combat_vol1left");
  } else {
    thread _id_0F16::_id_B2CC("hull_combat_wave1", "hull_guys_wave1s_e3", "hull_combat_vol1", 2, "hull_combat_wave1a");
    thread _id_0F16::_id_B2CC("hull_combat_wave1a", "hull_guys_wave1a_e3", "hull_combat_vol1a", 2, "hull_combat_wave2kill");
    thread _id_0F16::_id_B2CC("hull_combat_wave2spawn", "hull_guys_wave2_e3", "hull_combat_vol2", 2, "hull_combat_wave3");
    thread _id_0F16::_id_B2CC("hull_combat_wave1right", "hull_guys_wave1right_e3", "hull_combat_vol1right");
    thread _id_0F16::_id_B2CC("hull_combat_wave1left", "hull_guys_wave1left_e3", "hull_combat_vol1left");
  }

  wait 0.25;
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_13EF8();
  wait 1;
  thread _id_88F1();
  thread _id_0F16::_id_68BF("hull_combat_wave1", "hull_combat_vol1a", undefined, "hull_combat_wave1b", 1);
  thread _id_0F16::_id_68BF("hull_combat_wave1b", "hull_combat_vol1b", undefined, "hull_combat_wave2", 1);
  thread _id_F3A2(5, "hull_combat_wave2kill");
  scripts\engine\utility::flag_wait_any("hull_combat_wave2kill", "hull_combat_wave2spawn");

  if(!scripts\engine\utility::flag("game_saving")) {
    scripts\sp\utility::_id_2679();
  }

  thread _id_0F16::_id_68BF("hull_combat_wave2", "hull_combat_vol2", undefined, "hull_combat_wave2a", 1);
  thread _id_0F16::_id_68BF("hull_combat_wave2a", "hull_combat_vol2a", undefined, "hull_combat_wave3", 1);
  thread _id_0F16::_id_68BF("hull_combat_wave2kill", "hull_combat_vol2a", undefined, "hull_combat_wave3", 1);
  thread _id_1C18("hull_combat_wave2kill", "exterior_zg_friendly2", "hull_combat_wave3");
  thread _id_1C18("hull_combat_wave2spawn", "exterior_zg_friendly2", "hull_combat_wave3");
  scripts\engine\utility::waitframe();
  thread _id_F3A2(5, "hull_combat_wave3");
  scripts\engine\utility::flag_wait("hull_combat_wave3");
  thread _id_0F0E::_id_B2DB("axis_jackal_hull", "axis_jackal_hull_path", 1, 1);
  thread _id_0F0E::_id_B2DB("ally_jackal_hull", "ally_jackal_hull_path", 2, 2, undefined, 1);
  var_9 = getEnt("ally_jackal_hull0", "script_noteworthy");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_91B7(var_9);

  if(!scripts\engine\utility::flag("game_saving")) {
    scripts\sp\utility::_id_2679();
  }

  var_10 = getaiarray("axis");

  if(isDefined(var_10) && var_10.size <= 3) {
    if(!isDefined(level._id_9DD0)) {
      thread _id_0F16::_id_B2CC("hull_combat_wave3", "hull_guys_wave3", "hull_combat_vol3");
    } else {
      thread _id_0F16::_id_B2CC("hull_combat_wave3", "hull_guys_wave3_e3", "hull_combat_vol3");
    }
  }

  wait 1;
  thread _id_1C18("hull_combat_wave3", "exterior_zg_friendly3", "zerog_combat_space_end");
  thread _id_0F16::_id_68BF("hull_combat_wave3", "hull_combat_vol3", undefined, undefined, 1);
  var_10 = getaiarray("axis");

  if(isDefined(var_10) && var_10.size > 0) {
    scripts\sp\utility::_id_13754(var_10, var_10.size, 10);
  }

  foreach(var_1 in level._id_1C24) {
    var_1.accuracy = 10;
    var_1._id_2894 = 10;
  }

  scripts\engine\utility::flag_set("spawn_e3_grapple_guy");
  thread _id_0F16::_id_68BF("hull_combat_wave3", "hull_combat_vol3", undefined, undefined, 1);
  var_10 = getaiarray("axis");

  if(isDefined(var_10) && var_10.size > 0) {
    scripts\sp\utility::_id_13754(var_10, var_10.size);
  }

  sa01_hull_delete_spawners();
  scripts\sp\utility::_id_266F();
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_zone_is_clear_91");
  thread scripts\sp\utility::_id_15F1("exterior_zg_friendly_breach", "targetname", level.player);
  scripts\engine\utility::flag_set("zerog_combat_space_end");
  thread scripts\sp\utility::_id_6EEA("allies");
  thread scripts\sp\utility::_id_6EEA("allies", 1);
}

_id_88DD() {
  scripts\engine\utility::flag_wait("hull_combat_wave1");
  var_0 = scripts\sp\vehicle::_id_1080D("zerog_dropship1");
  thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_BB13(var_0);
  wait 5;
  level._id_679E scripts\sp\utility::_id_10346("mn_eth_transport_inbound");
  wait 4;
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_inserting_reinforcement");
}

_id_8962() {
  scripts\engine\utility::flag_wait_any("hull_combat_wave2", "hull_combat_wave1right", "hull_combat_wave1left");
  level._id_EAFE scripts\sp\utility::_id_10346("mn_slt_skelters_close");
  wait 0.1;
  scripts\sp\utility::_id_1034D("mn_plr_suppression_skelts");
  var_0 = spawnStruct();
  var_0 thread _id_0F0E::_id_B2DB("ally_jackal_hull_hover", "ally_jackal_hull_hover_path", 1, 1, undefined, 1);
  scripts\sp\utility::_id_10350("mn_fer_were_on_em");
  var_0._id_FE2D[0] thread _id_0F0E::_id_A1BD(level._id_3965, "missile");
  scripts\engine\utility::waitframe();
  var_0._id_FE2D[0] thread _id_0F0E::_id_A1BD(level._id_3965, "missile");
}

_id_88F1() {
  wait 10;
  thread _id_1C18("hull_combat_wave1", "exterior_zg_friendly1a", "hull_combat_wave1b");
}

_id_F3A2(var_0, var_1) {
  var_2 = getaiarray("axis");

  if(var_0 >= var_2.size - 1) {
    var_0 = var_2.size - 1;
  }

  scripts\sp\utility::_id_13753(var_2, var_0);
  scripts\engine\utility::flag_set(var_1);
}

_id_1C18(var_0, var_1, var_2) {
  level endon("death");

  if(isDefined(var_2)) {
    level endon(var_2);
  }

  scripts\engine\utility::flag_wait(var_0);
  var_3 = getEnt(var_1, "targetname");

  if(!isDefined(var_3) || isDefined(var_3) && isDefined(var_3.trigger_off)) {
    return;
  }
  scripts\sp\utility::_id_15F1(var_1, "targetname", level.player);
}

_id_91B6() {
  var_0 = getEntArray("large_maintenance_door_left", "targetname");
  var_1 = getEntArray("large_maintenance_door_right", "targetname");
  var_2 = var_0[2] scripts\engine\utility::get_target_array();
  var_3 = var_1[2] scripts\engine\utility::get_target_array();

  foreach(var_5 in var_2) {
    var_5 linkTo(var_0[2]);
  }

  foreach(var_5 in var_3) {
    var_5 linkTo(var_1[2]);
  }

  foreach(var_10 in var_0) {
    var_10 rotateTo((0, 0, -60), 0.05);
  }

  foreach(var_10 in var_1) {
    var_10 rotateTo((0, 0, 60), 0.05);
  }

  scripts\engine\utility::waitframe();
  scripts\engine\utility::flag_wait("open_bay");
  playFX(scripts\engine\utility::getfx("vfx_sa_moon_hull_decomp"), var_0[2].origin);

  foreach(var_10 in var_0) {
    var_10 rotateTo((0, 0, 0), 3, 1, 0.05);
  }

  foreach(var_10 in var_1) {
    var_10 rotateTo((0, 0, 0), 3, 1, 0.05);
  }
}

_id_91C3() {
  for(var_0 = 1; var_0 <= 6; var_0++) {
    var_1 = setup_door("animated_missile_port" + var_0);
    var_1.tag thread scripts\sp\anim::_id_1EC3(var_1, "sa_moon_deck_missilebaydoors_open", "tag_origin");
    var_2 = setup_door("animated_missile_star" + var_0, 1);
    var_2.tag thread scripts\sp\anim::_id_1EC3(var_2, "sa_moon_deck_missilebaydoors_open", "tag_origin");
    scripts\engine\utility::waitframe();
  }

  scripts\engine\utility::flag_wait("hull_combat_wave1");

  for(var_0 = 1; var_0 <= 6; var_0++) {
    var_1 = getEnt("animated_missile_port" + var_0, "script_noteworthy");
    var_1.tag thread scripts\sp\anim::_id_1F35(var_1, "sa_moon_deck_missilebaydoors_open", "tag_origin");
    thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_BB3F(var_1);
    var_2 = getEnt("animated_missile_star" + var_0, "script_noteworthy");
    var_2.tag thread scripts\sp\anim::_id_1F35(var_2, "sa_moon_deck_missilebaydoors_open", "tag_origin");
    wait 1;
  }

  var_3 = [];
  var_3[1] = getEnt("missile_kill_trigger1", "targetname");
  var_3[2] = getEnt("missile_kill_trigger2", "targetname");
  var_3[3] = getEnt("missile_kill_trigger3", "targetname");
  var_3[4] = getEnt("missile_kill_trigger4", "targetname");
  var_3[5] = getEnt("missile_kill_trigger5", "targetname");
  var_3[6] = getEnt("missile_kill_trigger6", "targetname");

  for(var_0 = 1; var_0 <= 6; var_0++) {
    var_3[var_0] thread _id_B843();
  }

  for(;;) {
    if(scripts\engine\utility::flag("breach_end")) {
      return;
    }
    var_4 = "amb_missile_l_";

    for(var_0 = 1; var_0 <= 6; var_0++) {
      playFXOnTag(scripts\engine\utility::getfx("vfx_missile_fire"), level._id_3965, var_4 + var_0);
      var_3[var_0] thread _id_B80B();
      level._id_3965 thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_BB37(var_4, var_0);
      level._id_3965 thread scripts\sp\maps\sa_moon\sa_moon_audio::_id_BB1E(var_4, var_0);
      wait 0.5;
    }

    wait 10;
  }
}

_id_B80B() {
  wait 0.75;
  var_0 = scripts\engine\utility::waittill_any_timeout(0.25, "trigger");

  if(isDefined(var_0) && var_0 != "timeout") {
    if(!scripts\engine\utility::is_true(level.player.grapple_invulnerable)) {
      _id_0B60::_id_F322("SA_MOON_DEATH_MISSILE");
      setomnvar("ui_death_hint", 49);
      level.player dodamage(level.player.health + 100, (0, 0, 0));
      scripts\engine\utility::waitframe();
      level.player dodamage(level.player.health + 100, (0, 0, 0));

      if(isalive(level.player)) {
        level.player _meth_81D0();
      }
    }
  }
}

_id_B843() {
  level endon("missile_warning_triggered");
  self waittill("trigger");
  level._id_679E thread scripts\sp\utility::_id_10346("mn_eth_avoid_launchers");
  scripts\engine\utility::waitframe();
  level notify("missile_warning_triggered");
}

#using_animtree("script_model");

setup_door(var_0, var_1) {
  var_2 = getEnt(var_0, "script_noteworthy");
  var_2._id_1FBB = "missile_hatch";
  var_2 _meth_83D0(#animtree);

  if(isDefined(var_1)) {
    var_3 = 90;
    var_4 = 17;
  } else {
    var_3 = -90;
    var_4 = -17;
  }

  var_2.tag = scripts\engine\utility::spawn_tag_origin(var_2.origin + (0, var_4, 40.5), (0, var_3, 0));
  return var_2;
}

_id_91C4() {
  var_0 = _id_0F31::_id_7EDE();
  scripts\engine\utility::array_thread(var_0, _id_0F31::_id_310C, 1);
  thread _id_0F31::_id_E727();
  var_1 = scripts\sp\maps\sa_moon\sa_moon_util::_id_8004();
  scripts\engine\utility::array_thread(var_1, _id_0F16::_id_310D, 1);

  foreach(var_3 in var_1) {
    var_3 thread _id_0F31::_id_3109(10);
  }

  var_5 = getEntArray("tube", "script_noteworthy");
  scripts\engine\utility::array_thread(var_5, _id_0F16::_id_310D, 1);

  foreach(var_3 in var_5) {
    var_3 thread _id_0F31::_id_3109(10);
  }

  thread _id_BC48("space_small_movers", 120);
}

_id_8918() {
  level endon("bridge_gravity_restored");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(102, "hull_combat_wave1");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(111, "hull_combat_wave1", 3);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(110, "open_bay");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(112, "open_bay", 1);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(106, "hull_combat_wave1a");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(109, "hull_combat_wave1a");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(104, "hull_combat_wave1a", 3);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(111, "hull_combat_wave2spawn");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(105, "hull_combat_wave2spawn", 3);
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(104, "hull_combat_wave1right");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(112, "hull_combat_wave1left");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(105, "hull_combat_wave3");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(112, "hull_combat_wave3");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(113, "hull_combat_wave3");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(114, "hull_combat_wave3");
  thread scripts\sp\maps\sa_moon\sa_moon_util::_id_88E9(115, "hull_combat_wave3");

  for(;;) {
    if(scripts\engine\utility::cointoss()) {
      scripts\engine\utility::exploder(116);
      wait(randomfloatrange(1, 2));
    }

    if(scripts\engine\utility::cointoss()) {
      scripts\engine\utility::exploder(117);
      wait(randomfloatrange(1, 2));
    }

    if(scripts\engine\utility::cointoss()) {
      scripts\engine\utility::exploder(118);
      wait(randomfloatrange(1, 2));
    }

    if(scripts\engine\utility::cointoss()) {
      scripts\engine\utility::exploder(119);
      wait(randomfloatrange(1, 2));
    }

    if(scripts\engine\utility::cointoss()) {
      scripts\engine\utility::exploder(120);
      wait(randomfloatrange(1, 2));
    }

    wait(randomfloatrange(2, 3));
  }
}

_id_BC48(var_0, var_1) {
  var_2 = getEntArray(var_0, "targetname");

  foreach(var_4 in var_2) {
    var_5 = var_4 scripts\engine\utility::get_target_ent();
    var_6 = randomfloatrange(var_1 - var_1 / 2, var_1);
    var_4 moveTo(var_5.origin, var_6);
    var_4 rotateTo(var_5.angles, var_6);
    var_4 thread _id_0F31::_id_3109(var_6 / 2);
  }
}