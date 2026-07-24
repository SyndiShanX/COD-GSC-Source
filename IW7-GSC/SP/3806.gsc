/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3806.gsc
**************************************/

_id_C67F() {
  precachemodel("tag_player");
  precachemodel("equipment_military_keycard_01");
  precachemodel("opsmap_solar_system");
  precachemodel("opsmap_solar_system_control_tray");
  precachemodel("opsmap_solar_system_reflection");
  precachemodel("opsmap_3d_ftl");
  precachemodel("opsmap_3d_ftl_reflection");
  precachemodel("opsmap_3d_calculation");
  scripts\engine\utility::flag_init("opsmap_solar_system_state_active");
  scripts\engine\utility::flag_init("opsmap_calculation_state_active");
  scripts\engine\utility::flag_init("opsmap_ftl_state_active");
  scripts\engine\utility::flag_init("opsmap_tutorial_shown");
  scripts\engine\utility::flag_init("opsmap_run_mission_preload_complete");
  scripts\engine\utility::flag_init("player_in_opsmap");
  scripts\engine\utility::flag_init("at_fullscreen_opsmap");
  scripts\engine\utility::flag_init("pip_hold");
  scripts\engine\utility::flag_init("opsmap_nag1");
  scripts\engine\utility::flag_init("opsmap_nag2");
  scripts\sp\utility::_id_16EB("opsmap_tutorial", &"PLATFORM_OPSMAP_TUTORIAL", ::_id_C69B);
  scripts\sp\utility::_id_16EB("opsmap_tutorial_pc_gamepad", &"PLATFORM_OPSMAP_TUTORIAL_GAMEPAD", ::_id_C69B);
  level._effect["vfx_opsmap_3d_planet_sol"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_sun.vfx");
  level._effect["vfx_opsmap_3d_planet_mercury"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_mercury.vfx");
  level._effect["vfx_opsmap_3d_planet_venus"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_venus.vfx");
  level._effect["vfx_opsmap_3d_planet_earth"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_earth.vfx");
  level._effect["vfx_opsmap_3d_planet_mars"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_mars.vfx");
  level._effect["vfx_opsmap_3d_planet_jupiter"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_jupiter.vfx");
  level._effect["vfx_opsmap_3d_planet_saturn"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_saturn.vfx");
  level._effect["vfx_opsmap_3d_planet_uranus"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_uranus.vfx");
  level._effect["vfx_opsmap_3d_planet_neptune"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_neptune.vfx");
  level._effect["vfx_opsmap_3d_planet_sol_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_sun_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_mercury_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_mercury_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_venus_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_venus_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_earth_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_earth_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_mars_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_mars_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_jupiter_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_jupiter_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_saturn_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_saturn_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_uranus_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_uranus_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_neptune_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_solarsystem_neptune_flicker.vfx");
  level._effect["vfx_opsmap_3d_planet_sol_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_sol_tag.vfx");
  level._effect["vfx_opsmap_3d_planet_mercury_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_mercury_tag.vfx");
  level._effect["vfx_opsmap_3d_planet_venus_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_venus_tag.vfx");
  level._effect["vfx_opsmap_3d_planet_earth_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_earth_tag.vfx");
  level._effect["vfx_opsmap_3d_planet_mars_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_mars_tag.vfx");
  level._effect["vfx_opsmap_3d_planet_jupiter_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_jupiter_tag.vfx");
  level._effect["vfx_opsmap_3d_planet_saturn_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_saturn_tag.vfx");
  level._effect["vfx_opsmap_3d_planet_uranus_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_uranus_tag.vfx");
  level._effect["vfx_opsmap_3d_planet_neptune_tag"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_neptune_tag.vfx");
  level._effect["vfx_opsmap_3d_asteroid_cluster"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_asteroid_cluster.vfx");
  level._effect["vfx_opsmap_3d_fluff_1"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_3dfluff_1.vfx");
  level._effect["vfx_opsmap_3d_fluff_2"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_3dfluff_2.vfx");
  level._effect["vfx_opsmap_3d_fluff_3"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_3dfluff_3.vfx");
  level._effect["vfx_opsmap_3d_fluff_3_flip"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_fluff3_flip.vfx");
  level._effect["vfx_opsmap_3d_fluff_4"] = loadfx("vfx/iw7/core/ui/vfx_ui_opsmap_3dfluff_4.vfx");
  level._effect["vfx_opsmap_3d_ambient"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_ops_projection_under_glow_02.vfx");
  level._effect["vfx_opsmap_3d_calculation_titan_path"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_calc_master_titan.vfx");
  level._effect["vfx_opsmap_3d_calculation_luna_path"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_calc_master_luna.vfx");
  level._effect["vfx_opsmap_3d_calculation_rogue_path"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_calc_master_rogue.vfx");
  level._effect["vfx_opsmap_3d_calculation_prisoner_path"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_calc_master_prisoner.vfx");
  level._effect["vfx_opsmap_3d_calculation_rezout"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_calc_table_rezout.vfx");
  level._effect["vfx_opsmap_3d_ftl_retribution"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_titan.vfx");
  level._effect["vfx_opsmap_3d_ftl_databox_nose"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_databox_nose.vfx");
  level._effect["vfx_opsmap_3d_ftl_box_tall"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_box_tall.vfx");
  level._effect["vfx_opsmap_3d_ftl_box_tall_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_box_tall_turnoff.vfx");
  level._effect["vfx_opsmap_3d_ftl_box_tall_small"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_box_tall_small.vfx");
  level._effect["vfx_opsmap_3d_ftl_box_tall_small_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_box_tall_small_turnoff.vfx");
  level._effect["vfx_opsmap_3d_ftl_box_wide"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_box_wide.vfx");
  level._effect["vfx_opsmap_3d_ftl_box_wide_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_box_wide_turnoff.vfx");
  level._effect["vfx_opsmap_3d_ftl_popup1"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_popup1.vfx");
  level._effect["vfx_opsmap_3d_ftl_popup2"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_popup2.vfx");
  level._effect["vfx_opsmap_3d_ftl_popup3"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_popup3.vfx");
  level._effect["vfx_opsmap_3d_ftl_popup4"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_popup4.vfx");
  level._effect["vfx_opsmap_3d_ftl_popup1_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_popup1_turnoff.vfx");
  level._effect["vfx_opsmap_3d_ftl_popup2_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_popup2_turnoff.vfx");
  level._effect["vfx_opsmap_3d_ftl_popup3_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_popup3_turnoff.vfx");
  level._effect["vfx_opsmap_3d_ftl_popup4_off"] = loadfx("vfx/iw7/levels/ship_crib/ops_table/vfx_opsmap_3d_ftl_popup4_turnoff.vfx");
  precacherumble("ops_map_hover");
}

_id_C66D(var_0) {
  level thread _id_0E72::main();

  if(!isDefined(level._id_C6AA))
    level._id_C6AA = [];

  if(var_0 == "retribution")
    level._id_C6AA[var_0] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "interact", var_0);
  else
    level._id_C6AA[var_0] = spawnStruct();

  level._id_C6AA[var_0] _id_C64F(var_0);

  if(var_0 == "retribution") {
    level._id_C6AA[var_0] _id_C642();

    if(level.script != "shipcrib_moon")
      level._id_C6AA[var_0] _id_C676();
  }

  _id_C682(0);
}

#using_animtree("script_model");

_id_C64F(var_0) {
  self._id_10E52["captain"] = _id_0EFB::_id_7CBE("opsmap_station_captain", "targetname", var_0);
  self._id_10E52["xo"] = _id_0EFB::_id_7CBE("opsmap_station_xo", "targetname", var_0);
  self._id_10E52["nav"] = _id_0EFB::_id_7CBE("opsmap_station_nav", "targetname", var_0);
  self._id_10E52["drop"] = _id_0EFB::_id_7CBE("opsmap_station_drop", "targetname", var_0);
  self._id_10E52["captain"]._id_EE92 = "opsmap_gator_react";

  if(var_0 != "retribution") {
    return;
  }
  self._id_CACE["captain"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "phone_captain", var_0);
  self._id_CACE["xo"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "phone_xo", var_0);
  self._id_CACE["nav"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "phone_nav", var_0);
  self._id_CACE["drop"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "phone_drop", var_0);
  _id_C686();
  self._id_454F["captain"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "captain", var_0);
  self._id_454F["xo"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "xo", var_0);
  self._id_454F["nav"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "nav", var_0);
  self._id_454F["drop"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "drop", var_0);
  self._id_454F["captain"] _meth_83D0(#animtree);
  self._id_BA11["nav"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "monitor_nav", var_0);
  self._id_BA11["nav_screen"] = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "monitor_nav_screen", var_0);
  self._id_BA11["nav_screen"] _id_EA0A(self._id_BA11["nav"], "j_monitor");
  _id_C685();
  self._id_7488 = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "ftl_interact", var_0);
  self._id_ECBE = 0;
  self._id_ECC8 = 0;
  self._id_EF68 = self._id_454F["captain"];
  self._id_EF67 = _id_0EFB::_id_7CBD("opsmap", "script_noteworthy", "scripted_node2", var_0);
  self._id_2AE2 = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "bink", var_0);
  self._id_2AE2 hide();
  self._id_2AD4 = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "bink_blend", var_0);
  self._id_2AD4 hide();
  self._id_113AF = _id_0EFB::_id_798B("opsmap", "script_noteworthy", "opsmap_table", var_0);
  self._id_113AF _meth_83D0(#animtree);
  self._id_907B = spawn("script_model", self._id_113AF.origin);
  self._id_907B.angles = self._id_113AF.angles;
  self._id_907B setModel("opsmap_solar_system_control_tray");
  thread _id_C684();
  self._id_1339A = _id_0EFB::_id_FE02("player_rig");
  self._id_1339A hide();
  self._id_1339A _id_C687();
  self._id_6665 = [];

  foreach(var_2 in self._id_CACE)
  self._id_6665[self._id_6665.size] = var_2;

  foreach(var_5 in self._id_454F)
  self._id_6665[self._id_6665.size] = var_5;

  self._id_6665[self._id_6665.size] = self._id_BA11["nav"];
  self._id_6665[self._id_6665.size] = self._id_7488;
  self._id_6665[self._id_6665.size] = self._id_2AE2;
  self._id_6665[self._id_6665.size] = self._id_2AD4;
  self._id_6665[self._id_6665.size] = self._id_113AF;
  self._id_6665[self._id_6665.size] = self._id_1339A;
  self._id_6665[self._id_6665.size] = self._id_907B;
}

_id_EA0A(var_0, var_1) {
  var_2 = undefined;

  for(var_3 = 0; var_3 < getnumparts(var_0.model); var_3++) {
    if(var_1 == getpartname(var_0.model, var_3)) {
      var_2 = 1;
      break;
    }
  }

  if(isDefined(var_2))
    self linkTo(var_0, var_1);
  else
    self linkTo(var_0);
}

#using_animtree("player");

_id_C687() {
  self _meth_83D0(#animtree);
}

#using_animtree("script_model");

_id_C686() {
  foreach(var_2, var_1 in self._id_CACE) {
    var_1 _meth_83D0(#animtree);
    var_1._id_1FBB = "opsmap_phone_" + var_2;
  }
}

_id_C685() {
  foreach(var_2, var_1 in self._id_BA11) {
    var_1 _meth_83D0(#animtree);
    var_1._id_1FBB = "opsmap_monitor_" + var_2;
  }
}

_id_C650() {
  var_0 = level._id_C6AA["retribution"];
  var_0 notify("opsmap_disable");
  var_0 _id_C683("all_off");
  scripts\engine\utility::flag_waitopen("opsmap_solar_system_state_active");
  scripts\engine\utility::flag_waitopen("opsmap_calculation_state_active");
  scripts\engine\utility::flag_waitopen("opsmap_ftl_state_active");

  foreach(var_2 in var_0._id_6665)
  var_2 delete();

  var_0 delete();
}

_id_C691() {
  self endon("opsmap_disable");
  self.active = 1;

  for(;;) {
    _id_0E46::_id_48C4(undefined, undefined, undefined, 45, 750, 50, 0);
    self waittill("trigger");
    level.player._id_9951 = 1;
    thread _id_C676();
    _id_C694();
    scripts\engine\utility::waitframe();
  }
}

#using_animtree("player");

_id_C694() {
  self endon("opsmap_disable");
  scripts\engine\utility::flag_set("player_in_opsmap");
  level.player notify("player_in_opsmap");
  var_0 = % shipcrib_plr_opsmap_interact;
  var_1 = % shipcrib_plr_opsmap_interact_backaway;

  if(isDefined(self._id_C645))
    var_0 = self._id_C645;

  if(isDefined(level._id_C664)) {
    var_0 = % shipcrib_plr_opsmap_grab;
    var_1 = % shipcrib_plr_opsmap_grab_backaway;
  }

  self._id_1339A _id_0EFB::_id_FDD7(1);
  self._id_1339A clearanim(%opsmap, 0);
  self._id_1339A setanimknob(var_0, 1, 0, 0);
  self._id_1339A.origin = getstartorigin(self._id_EF68.origin, self._id_EF68.angles, var_0);
  self._id_1339A.angles = getstartangles(self._id_EF68.origin, self._id_EF68.angles, var_0);
  var_2 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player playerlinkTo(var_2);
  level.player _meth_823C(self._id_1339A, "tag_player", 0.5, 0.2, 0.2);
  wait 0.55;
  level.player playSound("shipcrib_player_opsmap_interact_update_01");

  for(;;) {
    if(!isDefined(self._id_162E) || isDefined(self._id_162E) && !self._id_162E) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level.player _meth_8497(1);
  self._id_1339A scripts\engine\utility::delaycall(0.0, ::show);
  level thread _id_C6A8(var_0, "opsmap_start_fullscreen_transition");
  self._id_1339A _meth_82A2(var_0, 1, 0);

  if(scripts\engine\utility::flag_exist("pip_hold") && scripts\engine\utility::flag("pip_hold")) {
    while(scripts\engine\utility::flag("pip_hold"))
      wait 0.05;

    wait 0.05;
  }

  cinematicingame("opsmap_table_transition_full", 1);
  level waittill("opsmap_start_fullscreen_transition");
  _id_C666(var_1, var_2);
  var_2 delete();
  scripts\engine\utility::flag_clear("player_in_opsmap");
}

waittilbinkend() {
  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  setsaveddvar("bg_cinematicAboveUI", "0");
}

_id_C666(var_0, var_1) {
  self endon("opsmap_disable");
  setsaveddvar("bg_cinematicAboveUI", "1");
  setsaveddvar("bg_cinematicFullScreen", "1");
  setsaveddvar("bg_cinematicCanPause", "1");
  pausecinematicingame(0);
  level.player playSound("ui_map_enter");
  level thread _id_C667();
  level thread waittilbinkend();

  while(iscinematicplaying()) {
    var_2 = cinematicgettimeinmsec();

    if(var_2 > 750) {
      break;
    }

    scripts\engine\utility::waitframe();
  }

  level notify("fullscreen_opsmap_enabled");
  scripts\engine\utility::flag_set("at_fullscreen_opsmap");
  level thread scripts\sp\interaction_manager::_id_C9C4();
  var_3 = getEnt("blackroom_start", "targetname");
  level.player playerlinkweaponviewtodelta(var_3, "tag_player", 1, 0, 0, 0, 0, 1);
  level.player scripts\engine\utility::allow_weapon(0);
  setsaveddvar("cg_drawCrosshair", 0);
  var_4 = spawn("script_origin", var_3.origin);
  var_4 thread scripts\sp\utility::_id_10461("ui_map_bg_lp", 1, 1, 1);
  level.player _meth_84FA(1);
  level.player _meth_82C0("shipcrib_opsmap", 0.5);
  visionsetnaked("shipcrib_opsmap_fullscreen", 0.05);

  if(level.script == "shipcrib_europa" || level.script == "shipcrib_titan")
    _id_C69C();

  level thread _id_C668();

  for(;;) {
    level.player waittill("luinotifyserver", var_5);

    if(var_5 == "opsmap_cancel") {
      level notify("opsmap_nag_cancel");
      scripts\sp\utility::_id_DBF5();
      stopcinematicingame();
      setsaveddvar("bg_cinematicAboveUI", "0");
      level notify("opsmap_backed_out");
      self._id_272B = 1;
      scripts\engine\utility::flag_set("opsmap_tutorial_shown");
      break;
    } else {
      if(var_5 == "opsmap_zoomed_in") {
        scripts\engine\utility::flag_set("opsmap_tutorial_shown");
        continue;
      }

      if(issubstr(var_5, "opsmap_bink_")) {
        level notify("opsmap_nag_cancel");
        scripts\sp\utility::_id_DBF5();
        level thread scripts\sp\interaction_manager::_id_11037();
        scripts\engine\utility::flag_set("opsmap_tutorial_shown");
        var_6 = getsubstr(var_5, 12, var_5.size);

        if(var_6 != "rogue" && var_6 != "titan" && var_6 != "prisoner")
          level thread _id_C681(var_6);
        else {
          if(var_6 == "titan" || var_6 == "prisoner")
            level._id_C6AA["retribution"] thread _id_C683("calculation", var_6);

          if(var_6 == "rogue")
            setmusicstate("mx_429_rogue_briefing");
        }

        continue;
      }

      if(!issubstr(var_5, "restart")) {
        level notify("opsmap_nag_cancel");
        scripts\sp\utility::_id_DBF5();
        level thread scripts\sp\interaction_manager::_id_11037();
        stopcinematicingame();
        setsaveddvar("bg_cinematicAboveUI", "0");
        self.active = 1;
        self._id_272B = undefined;
        var_7 = getsubstr(var_5, 7, var_5.size);
        scripts\engine\utility::flag_set("opsmap_tutorial_shown");

        if(issubstr(level.script, "shipcrib"))
          thread _id_C680(var_7, var_4, var_1);

        break;
      }
    }
  }

  _id_C665(var_4);

  if(var_5 == "opsmap_cancel" || !isDefined(level._id_C68F)) {
    level thread scripts\sp\interaction_manager::_id_45A9();
    level.player _meth_823B(self._id_1339A, "tag_player");
    self._id_1339A.origin = getstartorigin(self._id_EF68.origin, self._id_EF68.angles, var_0);
    self._id_1339A.angles = getstartangles(self._id_EF68.origin, self._id_EF68.angles, var_0);
    self._id_1339A clearanim(%opsmap, 0);
    level.player playSound("shipcrib_player_opsmap_backaway");
    self._id_1339A _meth_82A2(var_0, 1, 0);
    wait(getanimlength(var_0));
    self._id_1339A hide();
    level.player unlink();
  }

  level thread scripts\sp\utility::_id_6E2B("at_fullscreen_opsmap", 0.5);
}

_id_C69C() {
  if(scripts\engine\utility::flag("opsmap_tutorial_shown")) {
    return;
  }
  if(level.script == "shipcrib_europa") {
    setomnvar("ui_loadout_tut_index", 0);
    thread _id_F5DA(3.0, 7);
    _id_C648("sc_assault_hud_europa_opsmap_tut", "sc_europa_gtr_newtargetsofopportunity");
    setomnvar("ui_loadout_tut_index", 0);
  } else if(level.script == "shipcrib_titan") {
    if(!isDefined(level._id_EFF2) || !level._id_EFF2) {
      setomnvar("ui_loadout_tut_index", 0);
      thread _id_F5DA(3.0, 8);
      _id_C648("sc_assault_hud_titan_opsmap_tut", "sc_titan_gtr_siradmiralraines");
      setomnvar("ui_loadout_tut_index", 0);
    } else
      return;
  }

  if(level.console)
    scripts\sp\utility::_id_56BA("opsmap_tutorial");
  else if(level.player usinggamepad())
    scripts\sp\utility::_id_56BA("opsmap_tutorial_pc_gamepad");
  else
    scripts\sp\utility::_id_56BA("opsmap_tutorial");

  level thread scripts\engine\utility::flag_set_delayed("opsmap_tutorial_shown", 10);
}

_id_F5DA(var_0, var_1) {
  wait(var_0);
  setomnvar("ui_loadout_tut_index", var_1);
}

_id_C648(var_0, var_1) {
  level.player freezecontrols(1);
  setomnvar("ui_opsmap_in_tutorial", 1);

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  stopcinematicingame();
  scripts\engine\utility::waitframe();
  level._id_76FB playSound(var_1);
  cinematicingame(var_0);

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  stopcinematicingame();
  level.player freezecontrols(0);
  setomnvar("ui_opsmap_in_tutorial", 0);

  if(level.script == "shipcrib_titan") {
    level._id_EFF2 = 1;
    level.player _meth_84C7("scTaughtOpsmap", 1);
  }
}

_id_C668() {
  level endon("opsmap_nag_cancel");
  var_0 = level.player _meth_84C6("lastCompletedMission");

  if(issubstr(var_0, "sa_") || issubstr(var_0, "ja_"))
    var_1 = 0;
  else
    var_1 = 1;

  if(level.script == "shipcrib_europa") {
    if(!scripts\engine\utility::flag("opsmap_nag1")) {
      wait 8;
      scripts\engine\utility::flag_set("opsmap_nag1");
      scripts\sp\utility::_id_10350("sc_europa_gtr_triadsindicatetargets");
    }

    if(!scripts\engine\utility::flag("opsmap_nag2")) {
      wait 12;
      scripts\engine\utility::flag_set("opsmap_nag1");
      scripts\sp\utility::_id_10350("shipcrib_nav_onyourorderscom");
    }
  } else if(level.script == "shipcrib_titan") {
    if(_id_0EFB::_id_9CB4()) {
      if(!scripts\engine\utility::flag("opsmap_nag1")) {
        wait 12;
        scripts\engine\utility::flag_set("opsmap_nag1");
        scripts\sp\utility::_id_10350("sc_titan_gtr_sirmissionsdesig");
      }
    } else if(!scripts\engine\utility::flag("opsmap_nag1")) {
      wait 12;
      scripts\engine\utility::flag_set("opsmap_nag1");
      scripts\sp\utility::_id_10350("sc_titan_gtr_siroperationburn");
    }
  } else if(level.script == "shipcrib_rogue") {
    if(var_1) {
      if(!scripts\engine\utility::flag("opsmap_nag1")) {
        wait 2;
        scripts\engine\utility::flag_set("opsmap_nag1");
        scripts\sp\utility::_id_10350("sc_rogue_nav_theresanewmission");
      }
    } else if(!scripts\engine\utility::flag("opsmap_nag1")) {
      wait 12;
      scripts\engine\utility::flag_set("opsmap_nag1");
      scripts\sp\utility::_id_10350("sc_rogue_nav_operationdarkquarry");
    }
  } else if(level.script == "shipcrib_prisoner") {
    if(var_1) {
      if(!scripts\engine\utility::flag("opsmap_nag1")) {
        wait 2;
        scripts\engine\utility::flag_set("opsmap_nag1");
        scripts\sp\utility::_id_10350("sc_rogue_nav_amarkerforyourmis");
        wait 0.25;
        scripts\sp\utility::_id_10350("sc_rogue_nav_itsourlastchance");
      }
    } else {
      var_2 = 1;
      var_3 = ["sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "sa_moon", "ja_spacestation", "ja_wreckage", "ja_asteroid", "ja_titan", "ja_mining"];

      foreach(var_5 in var_3) {
        var_6 = level.player _meth_84C6("opsmapMissionStateData", var_5);

        if(!isDefined(var_6) || var_6 != "complete") {
          var_2 = 0;
          break;
        }
      }

      if(var_2) {
        if(!scripts\engine\utility::flag("opsmap_nag1")) {
          wait 2;
          scripts\engine\utility::flag_set("opsmap_nag1");
          scripts\sp\utility::_id_10350("sc_rogue_nav_itstimeforoperation");
        }
      } else if(!scripts\engine\utility::flag("opsmap_nag2")) {
        if(level.player _meth_84C6("opsmapMissionStateData", "ja_mining") == "incomplete") {
          wait 2;
          scripts\engine\utility::flag_set("opsmap_nag2");
          scripts\sp\utility::_id_10350("sc_rogue_nav_theresanewairtoair");
          scripts\sp\utility::_id_10350("sc_rogue_nav_operationtracekill");
        }
      }
    }
  }
}

_id_C665(var_0) {
  visionsetnaked("", 0.05);
  level.player _meth_84FA(0);
  var_0 scripts\sp\utility::_id_10460(0.5);
  level.player clearclienttriggeraudiozone(0.5);
  level.player scripts\engine\utility::allow_weapon(1);
  _id_0EE4::_id_D28D();
  setsaveddvar("cg_drawCrosshair", 1);
}

_id_C69B() {
  return scripts\engine\utility::flag("opsmap_tutorial_shown");
}

_id_C667() {
  wait 0.25;
  _id_0B0A::_id_583F(1, 1000, 5, 2, 4000, 6, 2.5);
  level waittill("fullscreen_opsmap_enabled");
  _id_0B0A::_id_583F(0, 0, 0, 0, 0, 0, 0.0);
  level scripts\engine\utility::waittill_any("opsmap_backed_out", "opsmap_selection_made");
  _id_0B0A::_id_583F(1, 1000, 5, 2, 4000, 6, 0.0);
  scripts\engine\utility::waitframe();
  _id_0B0A::_id_583F(0, 0, 0, 0, 0, 0, 1);
}

_id_C690() {
  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  stopcinematicingame();
}

_id_C692() {
  self endon("opsmap_disable");
  var_0 = % shipcrib_plr_opsmap_interact_backaway;
  scripts\engine\utility::flag_set("player_in_opsmap");
  level.player notify("player_in_opsmap");
  _id_C666(var_0);

  if(isDefined(self._id_272B) && self._id_272B)
    thread _id_C691();
}

_id_C642() {
  if(!isDefined(self.active))
    self.active = 0;

  if(!self.active) {
    self notify("opsmap_disable");
    thread _id_C691();
  }
}

_id_C66C() {
  if(self.active) {
    scripts\engine\utility::flag_waitopen("player_in_opsmap");
    _id_0E46::_id_DFE3();
    self notify("opsmap_disable");
    self.active = 0;
  }
}

#using_animtree("script_model");

_id_C670(var_0) {
  if(var_0 == "up") {
    self._id_454F["captain"] clearanim(%shipcrib_opsmap_table_keyboard_down, 0.2);
    self._id_454F["captain"] _meth_82A2(%shipcrib_opsmap_table_keyboard_up, 1, 0.2);
    self playSound("ship_holo_console_raise");
  } else {
    self._id_454F["captain"] clearanim(%shipcrib_opsmap_table_keyboard_up, 0.2);
    self._id_454F["captain"] _meth_82A2(%shipcrib_opsmap_table_keyboard_down, 1, 0.2);
    self playSound("ship_holo_console_lower");
  }
}

_id_C643() {
  if(self.active) {
    if(!isDefined(self._id_162E) || isDefined(self._id_162E) && !self._id_162E) {
      self._id_162E = 1;
      _id_0E46::_id_DFE3();
    }
  }
}

_id_C644() {
  if(self.active)
    self._id_162E = undefined;
}

#using_animtree("player");

_id_C6A7(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  self._id_7488 thread _id_0E46::_id_48C4(undefined, undefined, undefined, 45, 750, 50, 0);
  self._id_7488 waittill("trigger");
  var_2 = % shipcrib_plr_opsmap_grab;

  if(isDefined(var_0))
    var_2 = var_0;

  level notify("ftl triggered");
  self._id_1339A _id_0EFB::_id_FDD7(1);
  self._id_1339A.origin = getstartorigin(self._id_EF68.origin, self._id_EF68.angles, var_2);
  self._id_1339A.angles = getstartangles(self._id_EF68.origin, self._id_EF68.angles, var_2);
  self._id_1339A clearanim(%opsmap, 0);
  self._id_1339A setanimknob(var_2, 1, 0, 0);
  var_3 = level.player scripts\engine\utility::spawn_tag_origin();
  level.player playerlinkTo(var_3);
  level.player _meth_823C(self._id_1339A, "tag_player", 0.5, 0.2, 0.2);
  wait 0.55;
  self._id_1339A show();
  self._id_1339A _meth_82A2(var_2, 1, 0);
  thread _id_C658();

  if(var_1)
    wait(getanimlength(var_2));

  level thread scripts\sp\utility::_id_C12D("opsmap_ftl_key_anim_done", getanimlength(var_2));
  level.player playerlinktodelta(self._id_1339A, "tag_player", 1, 20, 20, 30, 8, 1);
  var_3 delete();
  level notify("ftl_linkto_done");
}

_id_C659() {
  var_0 = % shipcrib_plr_opsmap_grab_backaway;
  self._id_1339A clearanim(%opsmap, 0);
  self._id_1339A _meth_82A2(var_0, 1, 0);
  thread _id_C65D();
  wait(getanimlength(var_0));
  self._id_A59C delete();
  self._id_1339A hide();
  level.player unlink();
  _id_C696();
}

#using_animtree("script_model");

_id_C658(var_0) {
  self._id_A59C = spawn("script_model", level.player.origin);
  self._id_A59C setModel("equipment_military_keycard_01");
  self._id_A59C _meth_83D0(#animtree);

  if(isDefined(var_0)) {
    self._id_A59C._id_1FBB = "shipcrib_keycard";
    self._id_EF68 scripts\sp\anim::_id_1F35(self._id_A59C, var_0);
    self._id_A59C delete();
  } else {
    self._id_A59C.origin = getstartorigin(self._id_EF68.origin, self._id_EF68.angles, %shipcrib_plr_opsmap_grab_keycard);
    self._id_A59C.angles = getstartangles(self._id_EF68.origin, self._id_EF68.angles, %shipcrib_plr_opsmap_grab_keycard);
    self._id_A59C _meth_82A2(%shipcrib_plr_opsmap_grab_keycard, 1, 0);
  }
}

_id_C65D() {
  self._id_A59C clearanim(%opsmap, 0);
  self._id_A59C _meth_82A2(%shipcrib_plr_opsmap_grab_backaway_keycard, 1, 0);
}

_id_C6A8(var_0, var_1, var_2) {
  if(animhasnotetrack(var_0, var_1)) {
    var_3 = getnotetracktimes(var_0, var_1)[0] * getanimlength(var_0);
    wait(var_3);
  } else if(isDefined(var_2))
    wait(var_2);
  else {}

  level notify(var_1);
}

_id_C682(var_0) {
  var_1 = getEnt("lgt_bridge_opsmap", "script_noteworthy");

  if(isDefined(var_1)) {
    if(var_0)
      var_1 setlightintensity(12);
    else
      var_1 setlightintensity(1.5);
  }
}

_id_C683(var_0, var_1, var_2) {
  if(var_0 == "solar_system") {
    if(scripts\engine\utility::flag("opsmap_ftl_state_active")) {
      _id_C696();
      wait 2;
    }

    _id_C69A(var_2);
  } else if(var_0 == "calculation") {
    if(scripts\engine\utility::flag("opsmap_solar_system_state_active")) {
      _id_C697();
      wait 2;
    }

    _id_C698(var_1);
  } else if(var_0 == "ftl") {
    if(scripts\engine\utility::flag("opsmap_calculation_state_active"))
      _id_C695();

    wait 1;
    _id_C699(var_1);
  } else if(var_0 == "all_off") {
    if(scripts\engine\utility::flag("opsmap_solar_system_state_active"))
      thread _id_C697();

    if(scripts\engine\utility::flag("opsmap_calculation_state_active"))
      thread _id_C695();

    if(scripts\engine\utility::flag("opsmap_ftl_state_active"))
      thread _id_C696();
  }
}

_id_C657(var_0, var_1, var_2, var_3) {
  if(isDefined(var_3)) {
    foreach(var_5 in var_3) {
      if(!var_5 scripts\sp\utility::_id_65DF("flickering"))
        var_5 scripts\sp\utility::_id_65E0("flickering");

      var_5 scripts\sp\utility::_id_65E1("flickering");
    }
  } else {
    if(!scripts\sp\utility::_id_65DF("flickering"))
      scripts\sp\utility::_id_65E0("flickering");

    scripts\sp\utility::_id_65E1("flickering");
  }

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = 1;

  if(var_0)
    var_7 = 3;
  else
    var_7 = 8;

  if(var_1) {
    for(var_8 = 0; var_8 < var_7; var_8++) {
      if(var_8 < 3)
        var_9 = 0.05;
      else
        var_9 = randomfloatrange(0.05, 0.15);

      if(isDefined(var_2))
        self hidepart(var_2);
      else if(isDefined(var_3)) {
        foreach(var_5 in var_3)
        var_5 hide();
      } else
        self hide();

      wait(var_9);

      if(isDefined(var_2))
        self showpart(var_2);
      else if(isDefined(var_3)) {
        foreach(var_5 in var_3)
        var_5 show();
      } else
        self show();

      wait(var_9);
    }
  } else {
    for(var_8 = 0; var_8 < var_7; var_8++) {
      if(var_8 < 3)
        var_9 = 0.05;
      else
        var_9 = randomfloatrange(0.05, 0.15);

      if(isDefined(var_2))
        self showpart(var_2);
      else if(isDefined(var_3)) {
        foreach(var_5 in var_3)
        var_5 show();
      } else
        self show();

      wait(var_9);

      if(isDefined(var_2))
        self hidepart(var_2);
      else if(isDefined(var_3)) {
        foreach(var_5 in var_3)
        var_5 hide();
      } else
        self hide();

      wait(var_9);
    }
  }

  if(isDefined(var_3)) {
    foreach(var_5 in var_3)
    var_5 scripts\sp\utility::_id_65DD("flickering");
  } else
    scripts\sp\utility::_id_65DD("flickering");
}

_id_C684() {
  self._id_907B _meth_83D0(#animtree);
  var_0 = anglestoright(self._id_113AF.angles) * 18;
  var_1 = anglestoup(self._id_113AF.angles) * 38;
  var_2 = anglesToForward(self._id_113AF.angles) * 22;
  playFX(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_3"), self._id_113AF.origin + var_0 + var_1 + var_2);
  var_0 = anglestoright(self._id_113AF.angles) * 18;
  var_1 = anglestoup(self._id_113AF.angles) * 38;
  var_2 = anglesToForward(self._id_113AF.angles) * -22;
  playFX(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_3_flip"), self._id_113AF.origin + var_0 + var_1 + var_2);
  var_0 = anglestoright(self._id_113AF.angles) * -18;
  var_1 = anglestoup(self._id_113AF.angles) * 38;
  var_2 = anglesToForward(self._id_113AF.angles) * -22;
  playFX(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_3"), self._id_113AF.origin + var_0 + var_1 + var_2);
  var_0 = anglestoright(self._id_113AF.angles) * -18;
  var_1 = anglestoup(self._id_113AF.angles) * 38;
  var_2 = anglesToForward(self._id_113AF.angles) * 22;
  playFX(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_3_flip"), self._id_113AF.origin + var_0 + var_1 + var_2);
}

_id_C69A(var_0) {
  if(scripts\engine\utility::flag("opsmap_solar_system_state_active"))
    return;
  else
    scripts\engine\utility::flag_set("opsmap_solar_system_state_active");

  if(!isDefined(var_0))
    var_0 = 1;

  if(var_0) {
    var_1 = 65536;

    for(;;) {
      if(distance2dsquared(level.player.origin, self._id_113AF.origin) < var_1) {
        break;
      }

      scripts\engine\utility::waitframe();
    }
  }

  playworldsound("ui_map_startup", self._id_113AF.origin);
  _id_C682(1);
  self._id_103F1 = spawn("script_model", self._id_113AF.origin);
  self._id_103F1.angles = self._id_113AF.angles;
  self._id_103F1 setModel("opsmap_solar_system");
  self._id_103F1 hide();
  self._id_103F1 _meth_83D0(#animtree);
  self._id_103F1._id_DE58 = spawn("script_model", self._id_113AF.origin);
  self._id_103F1._id_DE58.angles = self._id_113AF.angles;
  self._id_103F1._id_DE58 setModel("opsmap_solar_system_reflection");
  self._id_103F1._id_DE58 hide();
  self._id_103F1._id_DE58 _meth_83D0(#animtree);
  self._id_103F1 _meth_82A2(%opsmap_solar_system_intro_idle, 1, 0, 1);
  self._id_103F1._id_DE58 _meth_82A2(%opsmap_solar_system_intro_reflection_idle, 1, 0, 1);
  level thread _id_C657(0, 1, undefined, [self._id_103F1, self._id_103F1._id_DE58]);
  var_2 = [];
  var_3 = anglestoright(self._id_113AF.angles) * 18;
  var_4 = anglestoup(self._id_113AF.angles) * 48;
  var_5 = anglesToForward(self._id_113AF.angles) * -4;
  var_6 = self._id_113AF.origin + var_3 + var_4 + var_5;
  var_7 = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_1"), var_6);
  triggerfx(var_7);
  var_2[var_2.size] = var_7;
  var_3 = anglestoright(self._id_113AF.angles) * 22;
  var_4 = anglestoup(self._id_113AF.angles) * 48;
  var_5 = anglesToForward(self._id_113AF.angles) * -22;
  var_6 = self._id_113AF.origin + var_3 + var_4 + var_5;
  var_7 = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_1"), var_6);
  triggerfx(var_7);
  var_2[var_2.size] = var_7;
  var_3 = anglestoright(self._id_113AF.angles) * -14;
  var_4 = anglestoup(self._id_113AF.angles) * 44;
  var_5 = anglesToForward(self._id_113AF.angles) * -15.5;
  var_6 = self._id_113AF.origin + var_3 + var_4 + var_5;
  var_7 = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_1"), var_6);
  triggerfx(var_7);
  var_2[var_2.size] = var_7;
  var_3 = anglestoright(self._id_113AF.angles) * 2;
  var_4 = anglestoup(self._id_113AF.angles) * 46;
  var_5 = anglesToForward(self._id_113AF.angles) * -26;
  var_6 = self._id_113AF.origin + var_3 + var_4 + var_5;
  var_7 = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_2"), var_6);
  triggerfx(var_7);
  var_2[var_2.size] = var_7;
  scripts\engine\utility::waitframe();
  var_3 = anglestoright(self._id_113AF.angles) * -6;
  var_4 = anglestoup(self._id_113AF.angles) * 40;
  var_5 = anglesToForward(self._id_113AF.angles) * 14;
  var_6 = self._id_113AF.origin + var_3 + var_4 + var_5;
  var_7 = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_fluff_4"), var_6);
  triggerfx(var_7);
  var_2[var_2.size] = var_7;
  var_7 = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_ambient"), self._id_113AF.origin);
  triggerfx(var_7);
  var_2[var_2.size] = var_7;
  self._id_103F1._id_7583 = var_2;
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_1");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_2");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_3");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_4");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_5");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_6");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_7");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_8");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_9");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_10");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_11");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_12");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_13");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_14");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_15");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_16");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_sol_tag"), self._id_103F1, "tag_planet_sun");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mercury_tag"), self._id_103F1, "tag_planet_mercury");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_venus_tag"), self._id_103F1, "tag_planet_venus");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_earth_tag"), self._id_103F1, "tag_planet_earth");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mars_tag"), self._id_103F1, "tag_planet_mars");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_jupiter_tag"), self._id_103F1, "tag_planet_jupiter");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_saturn_tag"), self._id_103F1, "tag_planet_saturn");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_uranus_tag"), self._id_103F1, "tag_planet_uranus");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_neptune_tag"), self._id_103F1, "tag_planet_neptune");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_sol"), self._id_103F1, "tag_planet_sun");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mercury"), self._id_103F1, "tag_planet_mercury");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_venus"), self._id_103F1, "tag_planet_venus");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_earth"), self._id_103F1, "tag_planet_earth");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mars"), self._id_103F1, "tag_planet_mars");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_jupiter"), self._id_103F1, "tag_planet_jupiter");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_saturn"), self._id_103F1, "tag_planet_saturn");
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_uranus"), self._id_103F1, "tag_planet_uranus");
  scripts\engine\utility::waitframe();
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_neptune"), self._id_103F1, "tag_planet_neptune");
  wait 0.5;
  self._id_103F1 clearanim(%opsmap_solar_system_intro_idle, 0.2);
  self._id_103F1._id_DE58 clearanim(%opsmap_solar_system_intro_reflection_idle, 0.2);
  self._id_103F1 _meth_82A2(%opsmap_solar_system_intro, 1, 0.2, 1);
  self._id_103F1._id_DE58 _meth_82A2(%opsmap_solar_system_reflection_intro, 1, 0.2, 1);
  wait(getanimlength(%opsmap_solar_system_intro));
  self._id_103F1 clearanim(%opsmap_solar_system_intro, 1);
  self._id_103F1._id_DE58 clearanim(%opsmap_solar_system_reflection_intro, 1);
  self._id_103F1 _meth_82A2(%opsmap_solar_system_idle, 1, 1, 0.25);
  self._id_103F1._id_DE58 _meth_82A2(%opsmap_solar_system_reflection_idle, 1, 1, 0.25);
}

_id_C697() {
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_1");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_2");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_3");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_4");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_5");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_6");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_7");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_8");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_9");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_10");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_11");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_12");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_13");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_14");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_15");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_asteroid_cluster"), self._id_103F1, "tag_asteroid_16");

  foreach(var_1 in self._id_103F1._id_7583)
  var_1 delete();

  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_sol_tag"), self._id_103F1, "tag_planet_sun");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mercury_tag"), self._id_103F1, "tag_planet_mercury");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_venus_tag"), self._id_103F1, "tag_planet_venus");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_earth_tag"), self._id_103F1, "tag_planet_earth");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mars_tag"), self._id_103F1, "tag_planet_mars");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_jupiter_tag"), self._id_103F1, "tag_planet_jupiter");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_saturn_tag"), self._id_103F1, "tag_planet_saturn");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_uranus_tag"), self._id_103F1, "tag_planet_uranus");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_neptune_tag"), self._id_103F1, "tag_planet_neptune");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_sol"), self._id_103F1, "tag_planet_sun");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mercury"), self._id_103F1, "tag_planet_mercury");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_venus"), self._id_103F1, "tag_planet_venus");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_earth"), self._id_103F1, "tag_planet_earth");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_mars"), self._id_103F1, "tag_planet_mars");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_jupiter"), self._id_103F1, "tag_planet_jupiter");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_saturn"), self._id_103F1, "tag_planet_saturn");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_uranus"), self._id_103F1, "tag_planet_uranus");
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_planet_neptune"), self._id_103F1, "tag_planet_neptune");
  _id_C682(0);
  self._id_103F1 delete();
  self._id_103F1._id_DE58 delete();
  scripts\engine\utility::flag_clear("opsmap_solar_system_state_active");
}

_id_C698(var_0) {
  if(scripts\engine\utility::flag("opsmap_calculation_state_active"))
    return;
  else
    scripts\engine\utility::flag_set("opsmap_calculation_state_active");

  if(var_0 == "moon") {
    var_1 = self._id_113AF gettagorigin("tag_origin");
    self._id_372F = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_luna_path"), var_1);
    self._id_3730 = scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_rezout");
    var_2 = 3;
  } else if(var_0 == "titan") {
    var_1 = self._id_113AF gettagorigin("tag_origin");
    self._id_372F = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_titan_path"), var_1);
    self._id_3730 = scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_rezout");
    var_2 = 60.5;
  } else if(var_0 == "rogue") {
    var_1 = self._id_113AF gettagorigin("tag_origin");
    self._id_372F = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_rogue_path"), var_1);
    self._id_3730 = scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_rezout");
    var_2 = 35;
  } else if(var_0 == "prisoner") {
    var_1 = self._id_113AF gettagorigin("tag_origin");
    self._id_372F = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_prisoner_path"), var_1);
    self._id_3730 = scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_rezout");
    var_2 = 42;
  } else {
    var_1 = self._id_113AF gettagorigin("tag_origin");
    self._id_372F = spawnfx(scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_titan_path"), var_1);
    self._id_3730 = scripts\engine\utility::getfx("vfx_opsmap_3d_calculation_rezout");
    var_2 = 60.5;
  }

  level._id_36D7 = spawn("script_origin", var_1);
  level._id_36D7 thread _id_FBD6(var_2);
  triggerfx(self._id_372F);
  _id_C682(1);
}

_id_C695() {
  if(!isDefined(self._id_3730)) {
    return;
  }
  playFX(self._id_3730, self._id_113AF gettagorigin("tag_origin"));
  level._id_36D7 notify("state_off");
  wait 0.75;
  self._id_372F delete();
  _id_C682(0);
  scripts\engine\utility::flag_clear("opsmap_calculation_state_active");
}

_id_FBD6(var_0) {
  playworldsound("ui_map_calc_mode_on", self.origin);
  thread scripts\sp\utility::_id_10461("ui_map_calc_lp", 1, 0.3, 1);
  self waittill("state_off");
  self stoploopsound();
  playworldsound("ui_map_path_mode_off", self.origin);
  scripts\sp\utility::_id_10460(0.75, 1);
}

_id_C699(var_0) {
  level endon("opsmap_kill_ftl_state");

  if(scripts\engine\utility::flag("opsmap_ftl_state_active"))
    return;
  else
    scripts\engine\utility::flag_set("opsmap_ftl_state_active");

  playworldsound("ui_map_ftl_mode_on", self._id_113AF.origin);
  self._id_7496 = spawn("script_model", self._id_113AF.origin);
  self._id_7496.angles = self._id_113AF.angles;
  self._id_7496 setModel("opsmap_3d_ftl");
  self._id_7496 _meth_83D0(#animtree);
  self._id_7496 hide();
  self._id_7496._id_DE56 = spawn("script_model", self._id_113AF.origin);
  self._id_7496._id_DE56.angles = self._id_113AF.angles;
  self._id_7496._id_DE56 setModel("opsmap_3d_ftl_reflection");
  self._id_7496._id_DE56 _meth_83D0(#animtree);
  self._id_7496._id_DE56 hide();
  self._id_7496 scripts\sp\utility::_id_65E0("widget_radar");
  self._id_7496 scripts\sp\utility::_id_65E0("widget_text1");
  self._id_7496 scripts\sp\utility::_id_65E0("widget_text2");
  self._id_7496 scripts\sp\utility::_id_65E0("widget_waves");
  self._id_7496._id_4D3A = [];
  self._id_7496._id_4D3B = [];
  var_1 = scripts\sp\utility::_id_7CCC(self._id_7496.model);

  foreach(var_3 in var_1) {
    if(issubstr(var_3, "tag_damage")) {
      self._id_7496 hidepart(var_3);
      continue;
    }

    if(var_3 == "tag_diagnostic_front_radar") {
      self._id_7496 hidepart(var_3);
      continue;
    }

    if(var_3 == "j_diagnostic_front_radar_box") {
      self._id_7496 hidepart(var_3);
      continue;
    }

    if(var_3 == "tag_diagnostic_front_text1") {
      self._id_7496 hidepart(var_3);
      continue;
    }

    if(var_3 == "tag_diagnostic_front_text2") {
      self._id_7496 hidepart(var_3);
      continue;
    }

    if(var_3 == "tag_diagnostic_front_waves")
      self._id_7496 hidepart(var_3);
  }

  _id_C682(1);
  self._id_7496 _meth_82A2(%opsmap_ftl_root_idle, 1, 0);
  self._id_7496._id_DE56 _meth_82A2(%opsmap_ftl_root_idle_reflection, 1, 0);
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_retribution"), self._id_7496, "tag_retribution");
  scripts\engine\utility::waitframe();
  self._id_7496 _meth_82A2(%opsmap_ftl_intro, 1, 0.2);
  self._id_7496._id_DE56 _meth_82A2(%opsmap_ftl_intro, 1, 0.2);
  level scripts\engine\utility::delaythread(0.125, ::_id_C657, 0, 1, undefined, [self._id_7496, self._id_7496._id_DE56]);
  wait(getanimlength(%opsmap_ftl_intro) + 1);
  playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_databox_nose"), self._id_7496, "tag_diagnostic_nose");
  self._id_7496 _meth_82A2(%opsmap_ftl_scan_idle, 1, 0);
  self._id_7496._id_DE56 _meth_82A2(%opsmap_ftl_scan_idle, 1, 0);
  self._id_7496 clearanim(%opsmap_ftl_intro, 0.2);
  self._id_7496 _meth_82A2(%opsmap_ftl_box_idle, 0.2);
  self._id_7496._id_DE56 clearanim(%opsmap_ftl_intro, 0.2);
  self._id_7496._id_DE56 _meth_82A2(%opsmap_ftl_box_idle, 0.2);

  if(var_0 == "moon") {
    wait 0.75;
    _id_C65A();
  } else if(var_0 == "titan")
    _id_C662();
  else if(var_0 == "rogue")
    _id_C65E();
  else if(var_0 == "prisoner")
    _id_C65B();
  else
    _id_C661();
}

_id_C65F(var_0, var_1) {
  level endon("opsmap_kill_ftl_state");

  if(var_0 == "positive_45")
    var_2 = % opsmap_ftl_pos45;
  else if(var_0 == "negative_45")
    var_2 = % opsmap_ftl_neg45;
  else
    var_2 = undefined;

  self clearanim(%opsmap_ftl_box_idle, 0.2);
  self _meth_82A2(var_2, 1, 0.2, 1);
  self._id_DE56 clearanim(%opsmap_ftl_box_idle, 0.2);
  self._id_DE56 _meth_82A2(var_2, 1, 0.2, 1);
  wait(getanimlength(var_2) + var_1);
  self clearanim(var_2, 0.2);
  self _meth_82A2(var_2, 1, 0.2, -1);
  self._id_DE56 clearanim(var_2, 0.2);
  self._id_DE56 _meth_82A2(var_2, 1, 0.2, -1);
  wait(getanimlength(var_2));
  self clearanim(var_2, 0.2);
  self _meth_82A2(%opsmap_ftl_box_idle, 1, 0.2, 1);
  self._id_DE56 clearanim(var_2, 0.2);
  self._id_DE56 _meth_82A2(%opsmap_ftl_box_idle, 1, 0.2, 1);
  wait 0.25;
}

_id_C660() {
  level endon("opsmap_kill_ftl_state");
  var_0 = self._id_7496 islegacyagent(%opsmap_ftl_scan_idle);
  var_1 = undefined;

  if(var_0 > 0 && var_0 <= 0.1 || var_0 > 0.9)
    var_2 = ["tag_damage_warning_0", "tag_damage_warning_1"];
  else if(var_0 > 0.1 && var_0 <= 0.15 || var_0 > 0.85 && var_0 <= 0.9)
    var_2 = ["tag_damage_warning_2", "tag_damage_warning_3"];
  else if(var_0 > 0.15 && var_0 <= 0.21 || var_0 > 0.79 && var_0 <= 0.85)
    var_2 = ["tag_damage_warning_4", "tag_damage_warning_5"];
  else if(var_0 > 0.21 && var_0 <= 0.26 || var_0 > 0.74 && var_0 <= 0.79)
    var_2 = ["tag_damage_warning_6", "tag_damage_warning_7"];
  else if(var_0 > 0.26 && var_0 <= 0.32 || var_0 > 0.69 && var_0 <= 0.74)
    var_2 = ["tag_damage_warning_8", "tag_damage_warning_9"];
  else if(var_0 > 0.32 && var_0 <= 0.37 || var_0 > 0.63 && var_0 <= 0.69)
    var_2 = ["tag_damage_warning_10", "tag_damage_warning_11"];
  else if(var_0 > 0.37 && var_0 <= 0.43 || var_0 > 0.575 && var_0 <= 0.63)
    var_2 = ["tag_damage_warning_12", "tag_damage_warning_13"];
  else
    var_2 = ["tag_damage_warning_14", "tag_damage_warning_15"];

  var_2 = scripts\engine\utility::array_randomize(var_2);

  foreach(var_4 in var_2) {
    if(scripts\engine\utility::array_contains(self._id_7496._id_4D3A, var_4))
      continue;
    else {
      var_1 = var_4;
      break;
    }
  }

  if(isDefined(var_1)) {
    playworldsound("ui_map_ftl_error_01", self._id_113AF.origin);
    self._id_7496 thread _id_C657(0, 1, var_1);
    wait 0.25;

    switch (var_1) {
      case "tag_damage_warning_14":
      case "tag_damage_warning_12":
      case "tag_damage_warning_10":
      case "tag_damage_warning_8":
      case "tag_damage_warning_6":
      case "tag_damage_warning_4":
      case "tag_damage_warning_2":
      case "tag_damage_warning_0":
        var_6 = ["vfx_opsmap_3d_ftl_popup3", "vfx_opsmap_3d_ftl_popup4"];
        break;
      default:
        var_6 = ["vfx_opsmap_3d_ftl_popup1", "vfx_opsmap_3d_ftl_popup2"];
        break;
    }

    var_7 = var_6[randomint(2)];
    playFXOnTag(scripts\engine\utility::getfx(var_7), self._id_7496, var_1);
    self._id_7496._id_4D3A[self._id_7496._id_4D3A.size] = var_1;
    self._id_7496._id_4D3B[var_1] = var_7;
    scripts\engine\utility::waitframe();
  }
}

_id_C663(var_0, var_1) {
  level endon("opsmap_kill_ftl_state");

  if(var_0 == "radar") {
    if(var_1) {
      if(scripts\sp\utility::_id_65DB("widget_radar"))
        return;
      else
        scripts\sp\utility::_id_65E1("widget_radar");

      playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall"), self, "tag_diagnostic_front_radar");
      wait 1.5;
      thread _id_C657(0, 1, "tag_diagnostic_front_radar");
      _id_C657(0, 1, "j_diagnostic_front_radar_box");
      self _meth_82A2(%opsmap_ftl_radar_bracket_idle, 1, 0.2, 0.5);
    } else {
      if(!scripts\sp\utility::_id_65DB("widget_radar")) {
        return;
      }
      thread _id_C657(1, 0, "tag_diagnostic_front_radar");
      _id_C657(1, 0, "j_diagnostic_front_radar_box");
      killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall"), self, "tag_diagnostic_front_radar");
      playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall_off"), self, "tag_diagnostic_front_radar");
      wait 1.5;
      scripts\sp\utility::_id_65DD("widget_radar");
    }
  } else if(var_0 == "text1") {
    if(var_1) {
      if(scripts\sp\utility::_id_65DB("widget_text1"))
        return;
      else
        scripts\sp\utility::_id_65E1("widget_text1");

      playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall"), self, "tag_diagnostic_front_text1");
      wait 1.5;
      _id_C657(0, 1, "tag_diagnostic_front_text1");
    } else {
      if(!scripts\sp\utility::_id_65DB("widget_text1")) {
        return;
      }
      _id_C657(1, 0, "tag_diagnostic_front_text1");
      killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall"), self, "tag_diagnostic_front_text1");
      playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall_off"), self, "tag_diagnostic_front_text1");
      wait 1.5;
      scripts\sp\utility::_id_65DD("widget_text1");
    }
  } else if(var_0 == "text2") {
    if(var_1) {
      if(scripts\sp\utility::_id_65DB("widget_text2"))
        return;
      else
        scripts\sp\utility::_id_65E1("widget_text2");

      playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall_small"), self, "tag_diagnostic_front_text2");
      wait 1.5;
      _id_C657(0, 1, "tag_diagnostic_front_text2");
    } else {
      if(!scripts\sp\utility::_id_65DB("widget_text2")) {
        return;
      }
      _id_C657(1, 0, "tag_diagnostic_front_text2");
      killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall_small"), self, "tag_diagnostic_front_text2");
      playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_tall_small_off"), self, "tag_diagnostic_front_text2");
      wait 1.5;
      scripts\sp\utility::_id_65DD("widget_text2");
    }
  } else if(var_0 == "waves") {
    if(var_1) {
      if(scripts\sp\utility::_id_65DB("widget_waves"))
        return;
      else
        scripts\sp\utility::_id_65E1("widget_waves");

      playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_wide"), self, "tag_diagnostic_front_waves");
      wait 1.5;
      _id_C657(0, 1, "tag_diagnostic_front_waves");
    } else {
      if(!scripts\sp\utility::_id_65DB("widget_waves")) {
        return;
      }
      _id_C657(1, 0, "tag_diagnostic_front_waves");
      killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_wide"), self, "tag_diagnostic_front_waves");
      playFXOnTag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_box_wide_off"), self, "tag_diagnostic_front_waves");
      wait 1.5;
      scripts\sp\utility::_id_65DD("widget_waves");
    }
  }
}

_id_C696() {
  level notify("opsmap_kill_ftl_state");
  playworldsound("ui_map_ftl_mode_off", self._id_113AF.origin);

  foreach(var_1 in self._id_7496._id_4D3A) {
    self._id_7496 thread _id_C657(0, 0, var_1);
    killfxontag(scripts\engine\utility::getfx(self._id_7496._id_4D3B[var_1]), self._id_7496, var_1);
    playFXOnTag(scripts\engine\utility::getfx(self._id_7496._id_4D3B[var_1] + "_off"), self._id_7496, var_1);
    scripts\engine\utility::waitframe();
  }

  self._id_7496 thread _id_C663("radar", 0);
  scripts\engine\utility::waitframe();
  self._id_7496 thread _id_C663("text1", 0);
  scripts\engine\utility::waitframe();
  self._id_7496 thread _id_C663("text2", 0);
  scripts\engine\utility::waitframe();
  self._id_7496 thread _id_C663("waves", 0);
  scripts\engine\utility::waitframe();
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_retribution"), self._id_7496, "tag_retribution");
  killfxontag(scripts\engine\utility::getfx("vfx_opsmap_3d_ftl_databox_nose"), self._id_7496, "tag_diagnostic_nose");
  self._id_7496 hidepart("tag_retribution");
  self._id_7496._id_DE56 hidepart("tag_retribution");
  scripts\engine\utility::waitframe();
  level thread _id_C657(0, 0, undefined, [self._id_7496, self._id_7496._id_DE56]);
  level scripts\engine\utility::delaythread(1, ::_id_C682, 0);
  self._id_7496 scripts\sp\utility::_id_65E8("widget_radar");
  self._id_7496 scripts\sp\utility::_id_65E8("widget_text1");
  self._id_7496 scripts\sp\utility::_id_65E8("widget_text2");
  self._id_7496 scripts\sp\utility::_id_65E8("widget_waves");
  wait 2;
  self._id_7496._id_DE56 delete();
  self._id_7496 delete();
  scripts\engine\utility::flag_clear("opsmap_ftl_state_active");
}

_id_C65A() {
  wait 2;
  self._id_7496 thread _id_C663("waves", 1);
  wait 1.25;
  thread _id_C660();
  wait 0.5;
  self._id_7496 thread _id_C65F("positive_45", 3);
  scripts\engine\utility::delaythread(2.5, ::_id_C660);
  wait 0.25;
  self._id_7496 thread _id_C663("text2", 1);
  wait 5.5;
  thread _id_C660();
  wait 2;
  self._id_7496 _id_C65F("negative_45", 6);
  wait 2;
  self._id_7496 thread _id_C663("waves", 0);
  wait 0.5;
  self._id_7496 thread _id_C663("text2", 0);
  wait 2;
  thread _id_C696();
}

_id_C662() {
  level endon("opsmap_kill_ftl_state");
  self._id_7496 thread _id_C663("waves", 1);
  wait 2.75;
  thread _id_C660();
  wait 3;
  thread _id_C660();
  self._id_7496 thread _id_C65F("positive_45", 3);
  wait 1;
  self._id_7496 thread _id_C663("radar", 1);
  wait 0.5;
  self._id_7496 thread _id_C663("text1", 1);
  wait 4;
  thread _id_C660();
  wait 2.5;
  self._id_7496 thread _id_C65F("negative_45", 3.5);
}

_id_C65E() {
  level endon("opsmap_kill_ftl_state");
  wait 1;
  self._id_7496 thread _id_C663("waves", 1);
  wait 1;
  self._id_7496 thread _id_C663("radar", 1);
  level waittill("first_alarm");
  thread _id_C660();
  self._id_7496 thread _id_C663("text1", 1);
  wait 1;
  wait 0.5;
  self._id_7496 thread _id_C65F("negative_45", 1.5);
  level waittill("violent_shift");
  thread _id_C660();
  self._id_7496 thread _id_C663("text2", 1);
  wait 1;
  self._id_7496 thread _id_C65F("positive_45", 2);
}

_id_C65B() {
  level endon("opsmap_kill_ftl_state");
  self._id_7496 thread _id_C663("waves", 1);
  wait 0.25;
  self._id_7496 thread _id_C663("radar", 1);
  level waittill("collision_alarms");
  wait 6.5;
  self._id_7496 thread _id_C65F("positive_45", 2);
}

_id_C661() {
  level endon("opsmap_kill_ftl_state");
  self._id_7496 _id_C663("radar", 1);
  wait 0.5;
  self._id_7496 _id_C663("waves", 1);
  wait 0.5;
  self._id_7496 _id_C663("text1", 1);
  wait 0.5;
  self._id_7496 _id_C663("text2", 1);
  wait 0.5;
  self._id_7496 _id_C65F("positive_45", 4);
  wait 1;
  self._id_7496 _id_C65F("negative_45", 4);
  wait 1;
  _id_C660();
  wait 2;
  _id_C660();
  wait 2;
  self._id_7496 _id_C663("radar", 0);
  wait 0.5;
  self._id_7496 _id_C663("text1", 0);
  wait 0.5;
  self._id_7496 _id_C663("text2", 0);
  wait 0.5;
  self._id_7496 _id_C663("waves", 0);
  wait 0.5;
}

_id_C678(var_0, var_1, var_2) {
  if(isDefined(var_1))
    self._id_2AD4 show();
  else
    self._id_2AE2 show();

  if(!isDefined(var_2))
    var_2 = 1;

  setsaveddvar("bg_cinematicFullScreen", "0");
  setsaveddvar("bg_cinematicCanPause", "1");
  cinematicingame(var_0);

  while(!iscinematicplaying())
    scripts\engine\utility::waitframe();

  while(iscinematicplaying())
    scripts\engine\utility::waitframe();

  if(var_2) {
    self._id_2AE2 hide();
    self._id_2AD4 hide();
  }

  stopcinematicingame();
}

_id_C681(var_0) {
  _id_0EF7::_id_FDE5(var_0);
  scripts\engine\utility::flag_set("opsmap_run_mission_preload_complete");
}

_id_C680(var_0, var_1, var_2) {
  _id_0EFB::_id_F59B(var_0);
  level notify("opsmap_selection_made");

  if(issubstr(var_0, "sa_") || issubstr(var_0, "ja_")) {
    self notify("opsmap_disable");

    if(level.script == "shipcrib_europa") {
      _id_C665(var_1);
      level[[level._id_67B5]]();
    } else {
      scripts\sp\hud_util::_id_6AA3(0.05, "black");
      _id_C665(var_1);
    }

    thread _id_0EF7::_id_2605();

    switch (var_0) {
      case "sa_wounded":
      case "sa_vips":
      case "sa_empambush":
      case "sa_moon":
      case "sa_assassination":
        scripts\engine\utility::flag_wait("opsmap_run_mission_preload_complete");
        level thread _id_0EF7::_id_FDE4(var_0, var_2);

        if(level.script == "shipcrib_titan")
          level.player _meth_84C7("scTitanFirstPlay", 0);

        break;
      case "ja_wreckage":
      case "ja_titan":
      case "ja_spacestation":
      case "ja_mining":
      case "ja_asteroid":
        scripts\engine\utility::flag_wait("opsmap_run_mission_preload_complete");
        level thread _id_0EF7::_id_FDE4(var_0, var_2);
        break;
    }
  } else if(isDefined(level._id_C671)) {
    level thread _id_0EF7::_id_119C();
    level thread[[level._id_C671]]();
  }
}

_id_C676() {
  _id_C674();
  var_0 = ["yard", "mars", "heist", "prisoner", "rogue", "titan", "europa", "moon_port", "pearlharbor"];
  var_1 = ["sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "sa_moon", "ja_spacestation", "ja_asteroid", "ja_mining", "ja_titan", "ja_wreckage"];
  var_2 = 0;

  for(var_3 = 0; var_3 < var_1.size; var_3++) {
    var_4 = level.player _meth_84C6("opsmapMissionStateData", var_1[var_3]);

    if(!isDefined(var_4) || var_4 == "") {
      level.player _meth_84C7("opsmapMissionStateData", var_1[var_3], "incomplete");
      var_4 = level.player _meth_84C6("opsmapMissionStateData", var_1[var_3]);
    }

    if(isDefined(var_4) && var_4 == "complete")
      var_2++;

    if(isDefined(var_4) && var_4 == "incomplete")
      level.player _meth_84C7("missionProbability", var_1[var_3], randomintrange(81, 95));
  }

  for(var_3 = 0; var_3 < var_0.size; var_3++) {
    var_5 = var_0[var_3];
    var_6 = strtok(var_5, "_");

    if(var_6.size > 0 && var_6[0] != "sa" && var_6[0] != "ja") {
      var_7 = level.player _meth_84C6("opsmapMissionStateData", var_5);

      if(!isDefined(var_7) || var_7 == "") {
        level.player _meth_84C7("opsmapMissionStateData", var_5, "incomplete");
        var_7 = level.player _meth_84C6("opsmapMissionStateData", var_5);
      }

      if(isDefined(var_7) && var_7 == "incomplete") {
        var_8 = randomintrange(65, 75) + var_2 * 3;
        level.player _meth_84C7("missionProbability", var_5, var_8);
      }
    }
  }
}

_id_C674() {
  switch (level.script) {
    case "shipcrib_moon":
      level.player _meth_84C7("opsmapMissionStateData", "moon_port", "incomplete");
      level.player _meth_84C7("opsmapMissionStateData", "europa", "locked");
      level.player _meth_84C7("opsmapMissionStateData", "titan", "locked");
      level.player _meth_84C7("opsmapMissionStateData", "rogue", "locked");
      level.player _meth_84C7("opsmapMissionStateData", "prisoner", "locked");
      _id_C675();
      break;
    case "shipcrib_europa":
      level.player _meth_84C7("opsmapMissionStateData", "moon_port", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "europa", "incomplete");
      level.player _meth_84C7("opsmapMissionStateData", "titan", "locked");
      level.player _meth_84C7("opsmapMissionStateData", "rogue", "locked");
      level.player _meth_84C7("opsmapMissionStateData", "prisoner", "locked");
      _id_C675();
      break;
    case "shipcrib_titan":
      level.player _meth_84C7("opsmapMissionStateData", "moon_port", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "europa", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "titan", "incomplete");
      level.player _meth_84C7("opsmapMissionStateData", "rogue", "locked");
      level.player _meth_84C7("opsmapMissionStateData", "prisoner", "locked");
      _id_C675();
      break;
    case "shipcrib_rogue":
      level.player _meth_84C7("opsmapMissionStateData", "moon_port", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "europa", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "titan", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "rogue", "incomplete");
      level.player _meth_84C7("opsmapMissionStateData", "prisoner", "locked");
      _id_C675();
      break;
    case "shipcrib_prisoner":
      level.player _meth_84C7("opsmapMissionStateData", "moon_port", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "europa", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "titan", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "rogue", "complete");
      level.player _meth_84C7("opsmapMissionStateData", "prisoner", "incomplete");
      _id_C675();
      break;
  }
}

_id_C675() {
  var_0 = level.player _meth_84C6("opsmapMissionStateData", "ja_spacestation");
  var_1 = level.player _meth_84C6("opsmapMissionStateData", "ja_wreckage");
  var_2 = level.player _meth_84C6("opsmapMissionStateData", "ja_asteroid");
  var_3 = level.player _meth_84C6("opsmapMissionStateData", "ja_titan");
  var_4 = level.player _meth_84C6("opsmapMissionStateData", "ja_mining");
  var_5 = level.player _meth_84C6("missionStateData", "ja_spacestation");
  var_6 = level.player _meth_84C6("missionStateData", "ja_wreckage");
  var_7 = level.player _meth_84C6("missionStateData", "ja_asteroid");
  var_8 = level.player _meth_84C6("missionStateData", "ja_titan");
  var_9 = level.player _meth_84C6("missionStateData", "ja_mining");
  var_10 = ["ja_spacestation", "ja_wreckage", "ja_asteroid", "ja_titan", "ja_mining"];

  switch (level.script) {
    case "shipcrib_moon":
      foreach(var_12 in var_10) {
        var_13 = level.player _meth_84C6("opsmapMissionStateData", var_12);

        if(isDefined(var_13) && var_13 != "complete")
          level.player _meth_84C7("opsmapMissionStateData", var_12, "locked");
      }

      break;
    case "shipcrib_europa":
      foreach(var_12 in var_10) {
        var_13 = level.player _meth_84C6("opsmapMissionStateData", var_12);

        if(isDefined(var_13) && var_13 != "complete")
          level.player _meth_84C7("opsmapMissionStateData", var_12, "locked");
      }

      break;
    case "shipcrib_titan":
      if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
        if(var_0 == "locked" || var_1 == "locked" || var_2 == "locked") {
          check_and_set_opsmap_state("ja_spacestation", "incomplete");
          check_and_set_opsmap_state("ja_wreckage", "incomplete");
          check_and_set_opsmap_state("ja_asteroid", "incomplete");
          check_and_set_opsmap_state("ja_titan", "locked");
          check_and_set_opsmap_state("ja_mining", "locked");
        }
      }

      if(isDefined(var_5) && isDefined(var_6) && isDefined(var_7)) {
        if(var_5 == "locked" || var_6 == "locked" || var_7 == "locked") {
          level.player _meth_84C7("missionStateData", "ja_spacestation", "incomplete");
          level.player _meth_84C7("missionStateData", "ja_wreckage", "incomplete");
          level.player _meth_84C7("missionStateData", "ja_asteroid", "incomplete");
        }
      }

      if(isDefined(var_3) && isDefined(var_4)) {
        if(var_3 != "locked" || var_4 != "locked") {
          check_and_set_opsmap_state("ja_titan", "locked");
          check_and_set_opsmap_state("ja_mining", "locked");
        }
      }

      break;
    case "shipcrib_rogue":
      if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2)) {
        if(var_0 == "locked")
          level.player _meth_84C7("opsmapMissionStateData", "ja_spacestation", "incomplete");

        if(var_1 == "locked")
          level.player _meth_84C7("opsmapMissionStateData", "ja_wreckage", "incomplete");

        if(var_2 == "locked")
          level.player _meth_84C7("opsmapMissionStateData", "ja_asteroid", "incomplete");
      }

      if(isDefined(var_3)) {
        if(var_3 == "locked")
          level.player _meth_84C7("opsmapMissionStateData", "ja_titan", "incomplete");
      }

      if(isDefined(var_4)) {
        if(var_4 != "locked" && var_4 != "complete")
          level.player _meth_84C7("opsmapMissionStateData", "ja_mining", "locked");
      }

      if(isDefined(var_5) && isDefined(var_6) && isDefined(var_7)) {
        if(var_5 == "locked")
          level.player _meth_84C7("missionStateData", "ja_spacestation", "incomplete");

        if(var_6 == "locked")
          level.player _meth_84C7("missionStateData", "ja_wreckage", "incomplete");

        if(var_7 == "locked")
          level.player _meth_84C7("missionStateData", "ja_asteroid", "incomplete");
      }

      if(isDefined(var_8)) {
        if(var_8 == "locked")
          level.player _meth_84C7("missionStateData", "ja_titan", "incomplete");
      }

      break;
    case "shipcrib_prisoner":
      if(isDefined(var_0) && isDefined(var_1) && isDefined(var_2) && isDefined(var_3)) {
        if(var_0 == "locked" || var_1 == "locked" || var_2 == "locked" || var_3 == "locked") {
          check_and_set_opsmap_state("ja_spacestation", "incomplete");
          check_and_set_opsmap_state("ja_wreckage", "incomplete");
          check_and_set_opsmap_state("ja_asteroid", "incomplete");
          check_and_set_opsmap_state("ja_titan", "incomplete");
        }

        if(var_0 == "complete" && var_1 == "complete" && var_2 == "complete" && var_3 == "complete") {
          if(isDefined(var_4) && var_4 == "locked")
            level.player _meth_84C7("opsmapMissionStateData", "ja_mining", "incomplete");
        }
      }

      if(isDefined(var_5) && isDefined(var_6) && isDefined(var_7) && isDefined(var_8)) {
        if(var_5 == "locked" || var_6 == "locked" || var_7 == "locked" || var_8 == "locked") {
          level.player _meth_84C7("missionStateData", "ja_spacestation", "incomplete");
          level.player _meth_84C7("missionStateData", "ja_wreckage", "incomplete");
          level.player _meth_84C7("missionStateData", "ja_asteroid", "incomplete");
          level.player _meth_84C7("missionStateData", "ja_titan", "incomplete");
        }

        if(var_5 == "complete" && var_6 == "complete" && var_7 == "complete" && var_8 == "complete") {
          if(level.player _meth_84C6("missionStateData", "ja_mining") == "locked") {
            level.player _meth_84C7("missionStateData", "ja_mining", "incomplete");
            check_and_set_opsmap_state("ja_mining", "incomplete");
          }
        }
      }

      break;
  }

  var_17 = ["sa_assassination", "sa_empambush", "sa_vips", "sa_wounded", "sa_moon"];

  foreach(var_12 in var_17) {
    var_13 = level.player _meth_84C6("opsmapMissionStateData", var_12);

    if(!isDefined(var_13) || var_13 == "locked")
      level.player _meth_84C7("opsmapMissionStateData", var_12, "incomplete");

    var_19 = level.player _meth_84C6("missionStateData", var_12);

    if(!isDefined(var_13) || var_13 == "locked")
      level.player _meth_84C7("missionStateData", var_12, "incomplete");
  }
}

check_and_set_opsmap_state(var_0, var_1) {
  var_2 = level.player _meth_84C6("opsmapMissionStateData", var_0);

  if(isDefined(var_2) && var_2 != "complete")
    level.player _meth_84C7("opsmapMissionStateData", var_0, var_1);
}