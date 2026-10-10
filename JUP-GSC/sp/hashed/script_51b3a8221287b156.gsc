/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_51b3a8221287b156.gsc
*************************************************/

#using script_51b3a8221287b156;
#using script_56abda53e9dd9317;
#using scripts\common\anim;
#using scripts\common\lighting;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace namespace_9d9b8fc271e476d8;

function main() {
  setDvar(@ "hash_e08232af8b8b695c", 4);
  setDvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  thread function_8870942e8175774d();
  thread function_a71d0cb5448ce707();
  thread function_9f9e4e08ba93c02f();
  thread function_e8766b38b7d651bd();
  thread function_d76646e31621fe70();
  thread function_2ebd22cf76e2c70a();
  thread function_250cd30d870df29a();
  thread function_7959e8d2e655d16();
  thread function_3e3876e39f105d48();
  thread function_576a53015b7e0487();
  thread function_ed298a2ecae488fc();
  thread function_6e3df37ada02dc26();
  flag_init("wind_on");
  flag_init("lgt_airlocks_passed");
  flag_init("lgt_gas_released");
}

function function_b02ce5451b2a3f4a() {
  level flag_wait("flag_dungeon_intro_complete");
  visionsetnaked("cp_jup_chemical", 0);
  setDvar(@ "hash_e08232af8b8b695c", 4);
  setDvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  thread namespace_d1eabe4308f7c3e0::function_b4df42d037666638();
}

function function_50f821da2df0f2f7() {
  level flag_wait("flag_dungeon_intro_complete");
  setDvar(@ "hash_e08232af8b8b695c", 4);
  setDvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  thread namespace_d1eabe4308f7c3e0::function_b4df42d037666638();
}

function function_1d37f9a755d93118() {
  flag_clear("lgt_gas_released");
  setDvar(@ "hash_d559c6b906603ff1", 0);
  level flag_wait("flag_dungeon_intro_complete");
  level flag_wait("flag_escape_start");
  visionsetnaked("cp_jup_chemical_interior", 0);
  wait 0.5;
  visionsetnaked("cp_jup_chemical_interior_gas_release", 20);
  setDvar(@ "hash_e08232af8b8b695c", 4);
  setDvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  thread namespace_d1eabe4308f7c3e0::function_b4df42d037666638();
}

function function_a03a8a9f23f22041() {
  flag_clear("lgt_airlocks_passed");
  flag_clear("lgt_gas_released");
  setDvar(@ "hash_d559c6b906603ff1", 0);
  level flag_wait("flag_dungeon_intro_complete");
  wait 0.1;
  visionsetnaked("cp_jup_chemical_interior_gas_release_exfil", 0);
  thread function_238c2a0aae70e973("lgt_work_light_before_gas", 0, 0);
  thread function_238c2a0aae70e973("lgt_work_light_after_gas", 0, 40);
  setDvar(@ "hash_e08232af8b8b695c", 4);
  setDvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  thread namespace_d1eabe4308f7c3e0::function_b4df42d037666638();
}

function function_d76646e31621fe70() {
  thread function_238c2a0aae70e973("infil_hatch_exterior_bounce_static", 0, 0);
  thread function_238c2a0aae70e973("reactor_sun_light", 0, 0);
  thread function_238c2a0aae70e973("reactor_overhead_airlock_light", 0, 0);
  thread function_238c2a0aae70e973("infil_blue_jump_master_rim", 0, 0.4);
  thread function_238c2a0aae70e973("infil_blue_light_source", 0, 20);
  thread function_238c2a0aae70e973("infil_blue_team_rim", 0, 1.2);
  thread function_238c2a0aae70e973("infil_jump_master_rim", 0, 20);
  thread function_238c2a0aae70e973("infil_jump_master_rim_fixture_light", 0, 1.6);
  thread function_238c2a0aae70e973("infil_jump_master_rim_fixture_light_omni", 0, 0.2);
  thread function_238c2a0aae70e973("infil_team_red_key_01", 0, 6.8);
  thread function_238c2a0aae70e973("infil_team_red_key_02", 0, 6.8);
  thread function_238c2a0aae70e973("infil_team_red_key_omni", 0, 6);
}

function function_6e3df37ada02dc26() {
  wait 0.01;
  var_9ad5454cbbbd1ddf = getEnt("infil_gunship", "targetname");
  var_9ad5454cbbbd1ddf hide();
  var_c3bd79a9ec7ebc5f = getEntArray("infil_chopper_brushes", "targetname");

  foreach(brush in var_c3bd79a9ec7ebc5f) {
    brush hide();
  }
}

function function_8870942e8175774d() {
  level thread function_f37b4a0ea465f7c6();
  level endon("intro_skipped");
  flag_wait("lgt_infil_begin");

  if(flag("flag_dungeon_intro_complete")) {
    return;
  }

  visionsetnaked("cp_jup_chemical_infil", 0);
  thread function_61a998996cc98831();
  showcinematicletterboxing(0, 0);
  level.var_f86dca03b4e10a79 = 1;
  wait 0.2;
  setDvar(@ "hash_e08232af8b8b695c", 6);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
  setDvar(@ "hash_5d66c2ef5a9612e0", 0);
  setDvar(@ "hash_cb82c01fec2d534b", 32);
  setDvar(@ "hash_dacffbfd52c2fdc5", 32);
  setDvar(@ "hash_eca4b727b01fd254", 10);

  if(level.player isxb3player()) {
    setDvar(@ "hash_1dde331a8e0153d8", 3);
  }

  if(level.player isps4player()) {
    setDvar(@ "hash_1dde331a8e0153d8", 3);
  }

  flag_wait("lgt_infil_team_stop");
  thread function_238c2a0aae70e973("infil_team_red_rim", 1, 20);
  flag_wait("lgt_infil_jump_price_focus");
  setDvar(@ "hash_eca4b727b01fd254", 4);
  thread function_238c2a0aae70e973("infil_blue_team_rim", 0, 20);
  thread function_238c2a0aae70e973("infil_team_red_rim", 0, 0);
  flag_wait("lgt_infil_button_pressed");
  var_cd66ba3f93f5aa27 = getEnt("infil_jump_master_rim_fixture_light_omni", "targetname");
  var_cd66ba3f93f5aa27 setlightcolor((0.8, 1, 0.612));
  var_cc79eff03700ee3d = getEnt("infil_jump_master_rim_fixture_light", "targetname");
  var_cc79eff03700ee3d setlightcolor((0.8, 1, 0.612));
  var_cc79eff03700ee3d setlightintensity(0.5);
  var_fd8ac35c117e2d23 = getEnt("infil_jump_master_rim", "targetname");
  var_fd8ac35c117e2d23 setlightcolor((0.8, 1, 0.612));
  var_fd8ac35c117e2d23 setlightintensity(0.25);
  thread function_238c2a0aae70e973("infil_plane_accent_lights", 0, 0.1);
  thread function_238c2a0aae70e973("infil_plane_accent_lights_omni", 0, 0.04);
  thread function_238c2a0aae70e973("infil_plane_back_accent_lights", 0, 0.16);
  thread function_238c2a0aae70e973("infil_plane_back_accent_lights_omni", 0, 0.04);
  thread function_238c2a0aae70e973("infil_team_red_key_01", 0, 0);
  thread function_238c2a0aae70e973("infil_team_red_key_02", 0, 0);
  thread function_238c2a0aae70e973("infil_team_red_key_omni", 0, 0);
  thread function_238c2a0aae70e973("infil_team_red_rim_after_hatch", 0, 0);
  flag_wait("lgt_infil_hatch_shot");
  thread function_238c2a0aae70e973("infil_jump_master_rim_fixture_light_omni", 0, 0);
  thread function_238c2a0aae70e973("infil_jump_master_rim_fixture_light", 0, 0);
  thread function_238c2a0aae70e973("infil_jump_master_rim", 0, 0);
  thread function_238c2a0aae70e973("infil_hatch_exterior_light_01", 0, 80);
  thread function_238c2a0aae70e973("infil_exterior_sun_1", 0, 40);
  flag_wait("lgt_infil_hatch_open_start");
  visionsetnaked("cp_jup_chemical_infil_hatch_open", 1);
  wait 0.75;
  thread function_238c2a0aae70e973("infil_blue_team_rim", 0.1, 0);
  thread function_238c2a0aae70e973("infil_blue_jump_master_rim", 0.1, 0);
  thread function_238c2a0aae70e973("infil_blue_light_source", 0.1, 0);
  flag_wait("lgt_infil_hatch_open");
  visionsetnaked("cp_jup_chemical_infil_2_exterior", 2);
  thread function_238c2a0aae70e973("infil_hatch_exterior_bounce_static", 0.5, 60);
  flag_wait("lgt_infil_face_team");
  visionsetnaked("cp_jup_chemical_infil_2_exposure", 0);
  setDvar(@ "hash_eca4b727b01fd254", 4);
  thread function_238c2a0aae70e973("infil_hatch_exterior_light_2", 0, 716);
  thread function_238c2a0aae70e973("infil_exterior_sun_1", 0, 0);
  thread function_238c2a0aae70e973("infil_team_sun_key", 0, 477);
  thread function_238c2a0aae70e973("infil_team_sun_key_2", 0, 477);
  thread function_238c2a0aae70e973("infil_plane_back_accent_lights_omni", 0, 0);
  thread function_238c2a0aae70e973("infil_plane_back_accent_lights", 0, 0);
  thread function_238c2a0aae70e973("infil_plane_back_accent_lights_green_omni", 0, 0.04);
  thread function_238c2a0aae70e973("infil_plane_back_accent_green_lights", 0, 6);
  thread function_238c2a0aae70e973("infil_team_green_key_01", 0, 24);
  thread function_238c2a0aae70e973("infil_team_green_key_02", 0, 24);
  thread function_238c2a0aae70e973("infil_team_green_key_omni", 0, 60);
  thread function_238c2a0aae70e973("infil_team_green_rim", 0, 40);
  thread function_238c2a0aae70e973("infil_plane_accent_lights_green_omni", 0, 0.8);
  thread function_238c2a0aae70e973("infil_plane_accent_lights", 0, 0);
  thread function_238c2a0aae70e973("infil_plane_accent_lights_omni", 0, 0);
  wait 0.5;
  visionsetnaked("cp_jup_chemical_infil_2", 0.5);
  flag_wait("lgt_infil_price_screen_space_switch");
  setDvar(@ "hash_eca4b727b01fd254", 8);
  flag_wait("lgt_infil_prepare_crate");
  visionsetnaked("cp_jup_chemical_infil_2_exposure", 0);
  setDvar(@ "hash_eca4b727b01fd254", 16);
  thread function_238c2a0aae70e973("infil_hatch_exterior_light_2", 0, 398);
  thread function_238c2a0aae70e973("infil_team_green_key_01", 0, 0.8);
  thread function_238c2a0aae70e973("infil_team_green_key_02", 0, 0.8);
  thread function_238c2a0aae70e973("infil_team_green_key_omni", 0, 1.2);
  thread function_238c2a0aae70e973("infil_team_green_rim", 0, 8);
  thread function_238c2a0aae70e973("infil_team_green_plane_spec", 0, 1);
  thread function_238c2a0aae70e973("infil_team_sun_key", 0, 0);
  thread function_238c2a0aae70e973("infil_team_sun_key_2", 0, 0);
  wait 0.5;
  visionsetnaked("cp_jup_chemical_infil_2", 0.5);
  flag_wait("lgt_infil_parachute_focus");
  visionsetnaked("cp_jup_chemical_infil_2_exterior", 0);
  setDvar(@ "hash_eca4b727b01fd254", 16);
  thread function_238c2a0aae70e973("infil_team_green_parachute_light", 0, 12);
  thread function_238c2a0aae70e973("infil_hatch_exterior_light_2", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_key_01", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_key_02", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_key_omni", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_rim", 0, 1.2);
  thread function_238c2a0aae70e973("infil_team_green_plane_spec", 0, 4);
  thread function_238c2a0aae70e973("infil_hatch_exterior_light_01", 0, 40);
  thread function_238c2a0aae70e973("infil_exterior_sun_2", 0, 80);
  wait 0.5;
  thread function_238c2a0aae70e973("infil_hatch_exterior_light_01", 1, 0);
  thread function_238c2a0aae70e973("infil_team_green_parachute_light", 1, 0);
  flag_wait("lgt_infil_plane_focus");
  visionsetnaked("cp_jup_chemical_infil_plane_exterior", 0);
  setDvar(@ "hash_eca4b727b01fd254", 10);
  thread function_238c2a0aae70e973("infil_exterior_sun_2", 0, 0);
  thread function_238c2a0aae70e973("infil_hatch_exterior_bounce_static", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_key_01", 0, 0.4);
  thread function_238c2a0aae70e973("infil_team_green_key_02", 0, 0.4);
  thread function_238c2a0aae70e973("infil_team_green_key_omni", 0, 0.4);
  thread function_238c2a0aae70e973("infil_team_green_rim", 0, 0.6);
  thread function_238c2a0aae70e973("infil_team_green_plane_spec", 0, 0.06);
  thread function_238c2a0aae70e973("infil_plane_exterior_sun", 0, 360);
  thread function_238c2a0aae70e973("infil_plane_exterior_sky", 0, 6.4);
  thread function_238c2a0aae70e973("infil_hatch_exterior_plane_team_sun", 0, 80);
  level waittill("lgt_infil_back_inside_plane_test");
  visionsetnaked("cp_jup_chemical_infil_2_exterior", 0);
  setDvar(@ "hash_eca4b727b01fd254", 10);
  thread function_238c2a0aae70e973("infil_hatch_exterior_light_01", 0, 80);
  thread function_238c2a0aae70e973("infil_exterior_sun_2", 0, 80);
  thread function_238c2a0aae70e973("infil_hatch_exterior_bounce_static", 0, 60);
  thread function_238c2a0aae70e973("infil_final_stance_sky_rim", 0, 20);
  thread function_238c2a0aae70e973("infil_team_green_rim", 0, 0.15);
  thread function_238c2a0aae70e973("infil_hatch_exterior_plane_team_sun", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_plane_spec", 0, 0);
  thread function_238c2a0aae70e973("infil_plane_back_accent_lights_green_omni", 0, 0);
  thread function_238c2a0aae70e973("infil_plane_back_accent_green_lights", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_key_01", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_key_02", 0, 0);
  thread function_238c2a0aae70e973("infil_team_green_key_omni", 0, 0);
  thread function_238c2a0aae70e973("infil_plane_exterior_sun", 0, 0);
  thread function_238c2a0aae70e973("infil_plane_exterior_sky", 0, 0);
  level waittill("lgt_infil_jump_time_test");
  thread function_238c2a0aae70e973("infil_final_stance_sky_rim", 1.5, 0);
  thread function_238c2a0aae70e973("infil_hatch_exterior_light_01", 2, 0);
  flag_wait("lgt_infil_team_jump");
  visionsetnaked("cp_jup_chemical_infil_2_transition", 1.5);
  wait 1;
  visionsetnaked("", 1.25);
  setDvar(@ "hash_eca4b727b01fd254", 4);
  setDvar(@ "hash_6157be5fe5b7cd6e", 8);
  level waittill("lgt_infil_completely_off_plane");
  thread function_238c2a0aae70e973("infil_exterior_sun_2", 1, 0);
  thread function_238c2a0aae70e973("infil_plane_accent_lights_green_omni", 0, 0);
  thread function_238c2a0aae70e973("infil_hatch_exterior_bounce_static", 1, 0);
  thread function_238c2a0aae70e973("infil_team_green_rim", 0, 0);
  level waittill("lgt_infil_price_sky_floating");
  var_8f5ecd5725a46e24 = getEntArray("infil_light_fixtures", "targetname");

  foreach(fixture in var_8f5ecd5725a46e24) {
    fixture hide();
  }

  wait 4.75;
  hidecinematicletterboxing(1.5, 0);
  thread function_9160006a3f10b2cd();
}

function function_f37b4a0ea465f7c6() {
  level waittill("lgt_infil_end");
  wait 0.5;
  setDvar(@ "hash_e08232af8b8b695c", 4);
  setDvar(@ "hash_63eb1893f96ac98d", 6);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  setDvar(@ "hash_6157be5fe5b7cd6e", 4);
  setDvar(@ "hash_cb82c01fec2d534b", 8);
  level.var_f86dca03b4e10a79 = undefined;

  if(level.player isxb3player()) {
    setDvar(@ "hash_1dde331a8e0153d8", 16);
  }

  if(level.player isps4player()) {
    setDvar(@ "hash_1dde331a8e0153d8", 16);
  }

  thread function_b4df42d037666638();
}

function function_b4df42d037666638() {
  light_array = getEntArray("infil_lights", "script_noteworthy");

  if(isDefined(light_array)) {
    foreach(light in light_array) {
      light delete();
    }
  }
}

function function_8c304f6c47246a43(anim_org) {
  level thread function_5bc6a1f81acec478();
  level endon("intro_skipped");
  flag_wait("lgt_infil_team_jump");
  wait 2;
  price_body = anim_org scene::get_entity("price_body_wind");
  var_7859aff8929d4de0 = getEnt("infil_price_sky_floating_light", "targetname");
  var_85831d915364f737 = getEnt("infil_price_sky_floating_light_02", "targetname");
  thread function_238c2a0aae70e973("infil_price_sky_floating_light", 2, 5);
  thread function_238c2a0aae70e973("infil_price_sky_floating_light_02", 2, 1.2);

  if(!isDefined(anim_org)) {
    return;
  }

  var_7859aff8929d4de0 linkTo(price_body, "tag_origin");
  var_85831d915364f737 linkTo(price_body, "tag_origin");
}

function function_5bc6a1f81acec478() {
  var_7859aff8929d4de0 = getEnt("infil_price_sky_floating_light", "targetname");
  var_85831d915364f737 = getEnt("infil_price_sky_floating_light_02", "targetname");
  level waittill("lgt_infil_end");

  if(isDefined(var_7859aff8929d4de0)) {
    var_7859aff8929d4de0 setlightintensity(0);
  }

  if(isDefined(var_85831d915364f737)) {
    var_85831d915364f737 setlightintensity(0);
  }
}

function function_a71d0cb5448ce707() {
  level thread function_c969ef0a28d69774();
  level endon("intro_skipped");
  flag_wait("lgt_infil_begin");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(1, 40, 15, 50);
  flag_wait("lgt_infil_team_reveal");
  level.player setphysicaldepthoffield(2, 150, 15, 50);
  flag_wait("lgt_infil_team_walk_forward");
  level.player setphysicaldepthoffield(2, 125, 15, 50);
  flag_wait("lgt_infil_price_walks_up");
  level.player setphysicaldepthoffield(1, 70, 15, 50);
  wait 1;
  level.player setphysicaldepthoffield(1, 60, 15, 50);
  wait 1;
  level.player setphysicaldepthoffield(1, 50, 15, 50);
  flag_wait("lgt_infil_jump_price_focus");
  level.player setphysicaldepthoffield(2, 24, 15, 50);
  flag_wait("lgt_infil_jump_master_focus");
  level.player setphysicaldepthoffield(1, 105, 15, 50);
  flag_wait("lgt_infil_hatch_shot");
  level.player setphysicaldepthoffield(1, 15, 15, 50);
  flag_wait("lgt_infil_hatch_open");
  level.player setphysicaldepthoffield(1, 100, 15, 50);
  flag_wait("lgt_infil_face_team");
  level.player setphysicaldepthoffield(2, 75, 15, 50);
  flag_wait("lgt_infil_price_face_team");
  level.player setphysicaldepthoffield(2, 10, 15, 50);
  flag_wait("lgt_infil_team_in_focus");
  level.player setphysicaldepthoffield(1, 100, 15, 50);
  wait 3;
  level.player setphysicaldepthoffield(1, 75, 15, 50);
  flag_wait("lgt_infil_price_back_with_team");
  level.player setphysicaldepthoffield(1, 27, 15, 50);
  flag_wait("lgt_infil_prepare_crate");
  level.player setphysicaldepthoffield(1, 100, 15, 50);
  flag_wait("lgt_infil_drop_parachute");
  level.player setphysicaldepthoffield(2, 80, 15, 50);
  flag_wait("lgt_infil_parachute_fall");
  level.player setphysicaldepthoffield(2, 50, 15, 50);
  flag_wait("lgt_infil_parachute_focus");
  level.player setphysicaldepthoffield(1, 150, 15, 50);
  flag_wait("lgt_infil_plane_focus");
  level.player setphysicaldepthoffield(1, 250, 15, 50);
  flag_wait("lgt_infil_crate_out_of_frame");
  level.player setphysicaldepthoffield(1, 200, 15, 50);
  level waittill("lgt_infil_back_inside_plane_test");
  level.player setphysicaldepthoffield(1, 75, 15, 50);
  level waittill("lgt_infil_ghost_price_stance");
  level.player setphysicaldepthoffield(1, 50, 15, 50);
  level waittill("lgt_infil_jump_time_test");
  level.player setphysicaldepthoffield(1, 50, 15, 50);
  flag_wait("lgt_infil_team_jump");
  level.player setphysicaldepthoffield(1, 150, 15, 50);
  level waittill("lgt_infil_completely_off_plane");
  level.player setphysicaldepthoffield(4, 50, 15, 50);
  level waittill("lgt_infil_price_sky_floating");
  level.player setphysicaldepthoffield(3, 50, 15, 50);
  level waittill("lgt_infil_price_sky_close");
  level.player setphysicaldepthoffield(3, 50, 15, 50);
  level waittill("lgt_infil_price_sky_turn");
  level.player setphysicaldepthoffield(3, 15, 15, 50);
  wait 0.3;
  level.player setphysicaldepthoffield(3, 28, 15, 50);
  level waittill("lgt_infil_price_sky_face");
  level.player setphysicaldepthoffield(4, 18, 15, 50);
  wait 0.6;
  level.player setphysicaldepthoffield(3, 11, 15, 50);
}

function function_c969ef0a28d69774() {
  level waittill("lgt_infil_end");
  level.player disablephysicaldepthoffieldscripting();
}

function function_2ebd22cf76e2c70a() {
  flag_wait("flag_obj_all_helis_killed");
  airlocks_ready = getEntArray("airlocks_ready", "targetname");

  foreach(light in airlocks_ready) {
    light setlightcolor((0.32, 1, 0));
  }
}

function function_250cd30d870df29a() {
  wait 0.01;
  var_5c51cb825dbead0e = getEntArray("button_pushed_green", "targetname");

  foreach(prop in var_5c51cb825dbead0e) {
    prop hide();
  }

  flag_wait("flag_reactor_airlock_passed");
  flag_wait("lgt_airlocks_passed");
  wait 1;
  var_5a34d9e43f42c69e = getEntArray("button_pushed_red", "targetname");

  foreach(prop in var_5a34d9e43f42c69e) {
    prop hide();
  }

  foreach(prop in var_5c51cb825dbead0e) {
    prop show();
  }
}

function function_7959e8d2e655d16() {
  flag_wait("scriptables_ready");
  var_3398c0dabca1148f = getentitylessscriptablearray("airlock_emergency_fixtures", "targetname");

  if(!isDefined(var_3398c0dabca1148f) || var_3398c0dabca1148f.size == 0) {
    var_3398c0dabca1148f = getEntArray("airlock_emergency_fixtures", "targetname");
    var_ef6933f866531138 = [];

    foreach(var_ede74e03e931f704 in var_3398c0dabca1148f) {
      var_15479b80d264b1e9 = spawnscriptable("jup_lighting_sov_plasticcase_yellow_fixture_01_noent", var_ede74e03e931f704.origin, var_ede74e03e931f704.angles);

      if(isDefined(var_15479b80d264b1e9)) {
        var_ef6933f866531138 = array_add(var_ef6933f866531138, var_15479b80d264b1e9);
      }
    }

    if(var_ef6933f866531138.size > 0) {
      array_delete(var_3398c0dabca1148f);
      var_3398c0dabca1148f = var_ef6933f866531138;
    }
  }

  flag_wait("flag_reactor_airlock_passed");
  flag_wait("lgt_airlocks_passed");
  wait 1;
  visionsetnaked("cp_jup_chemical_exfil_black", 0);
  wait 0.1;
  setDvar(@ "hash_d559c6b906603ff1", 0);
  thread function_238c2a0aae70e973("airlock_initial_lights", 0, 0);
  thread namespace_11fae4a66a43bd3f::function_505b5d4f03fcfa5d();
  wait 2;
  visionsetnaked("cp_jup_chemical_interior", 0.5);
  thread function_238c2a0aae70e973("reactor_sun_light", 0, 40);
  thread function_238c2a0aae70e973("reactor_overhead_airlock_light", 0, 2);
  thread namespace_11fae4a66a43bd3f::function_f0b25c48410693c3();

  foreach(fixture in var_3398c0dabca1148f) {
    thread namespace_11fae4a66a43bd3f::function_805331ab2b56bc58(fixture);

    if(isent(fixture)) {
      fixture.light_tag = spawn_tag_origin();
      fixture.light_tag show();
      light_tag = fixture.light_tag;
      light_tag.origin = fixture.origin;
      light_tag.angles = fixture.angles;
      playFXOnTag(level._effect["vfx_chemical_red_rotating_light_01"], light_tag, "tag_origin");
      fixture hide();
      continue;
    }

    fixture setscriptablepartstate("body", "enabled");
  }

  flag_wait("reactor_doors_force_closed");

  foreach(fixture in var_3398c0dabca1148f) {
    if(isent(fixture)) {
      fixture.light_tag delete();
      fixture show();
      continue;
    }

    fixture setscriptablepartstate("body", "disabled");
  }
}

function function_3e3876e39f105d48() {
  flag_wait("reactor_doors_force_closed");
  thread function_238c2a0aae70e973("airlock_green_lights", 0, 0.001);
}

function function_576a53015b7e0487() {
  flag_wait("flag_escape_start");
  thread function_238c2a0aae70e973("palette_sunlight", 0.5, 0);
  thread function_238c2a0aae70e973("palette_rim", 0.5, 0);
  thread function_238c2a0aae70e973("reactor_small_emergency_lights_omni", 0, 1.6);
  var_63d69370dbfe7826 = getEntArray("reactor_small_emergency_lights_omni", "targetname");

  foreach(light in var_63d69370dbfe7826) {
    light thread blink_light(1.5, 0.5, 0, 0.5, 0.75);
  }

  var_a5b3ca8f887d67f2 = getEntArray("reactor_emergency_lights", "targetname");
  var_42c6d12ff9f4225e = getEntArray("reactor_emergency_lights_omni", "targetname");
  var_7f5ff0063d4d7cbd = getEntArray("reactor_emergency_lights_static", "targetname");
  var_3f2a6aa199ce3090 = array_combine(var_a5b3ca8f887d67f2, var_42c6d12ff9f4225e);

  foreach(light in var_3f2a6aa199ce3090) {
    light setlightcolor((1, 0.29, 0));
  }

  wait 0.5;

  foreach(light in var_a5b3ca8f887d67f2) {
    light thread blink_light(1.5, 0.5, 0, 0.5, 0.75);
  }

  foreach(light in var_42c6d12ff9f4225e) {
    light thread blink_light(1.5, 0.5, 0, 0.5, 0.75);
  }

  foreach(light in var_7f5ff0063d4d7cbd) {
    light thread blink_light(1.5, 0.5, 0, 0.5, 0.75);
  }

  flag_wait("lgt_gas_released");
  wait 0.5;
  visionsetnaked("cp_jup_chemical_interior_gas_release", 20);
  wait 0.5;
  thread function_238c2a0aae70e973("lgt_work_light_before_gas", 20, 0);
  thread function_238c2a0aae70e973("lgt_work_light_after_gas", 20, 40);
}

function function_ed298a2ecae488fc() {
  flag_wait("flag_gas_at_floor3");
  thread function_ee3c5a9a02050510("lgt_work_light_after_gas", 40, 250);
}

function function_9f9e4e08ba93c02f() {
  level thread function_fe4fe27e7e33ac4c();
  level endon("outro_skipped");
  level waittill("lgt_exfil_begin");
  wait 0.1;
  visionsetnaked("cp_jup_chemical_interior_gas_release_exfil", 2);
  wait 0.1;
  level.var_f86dca03b4e10a79 = 1;
  thread function_61a998996cc98831();
  wait 0.1;
  setDvar(@ "sm_sunsamplesizenear", 0.1);
  setDvar(@ "hash_e08232af8b8b695c", 6);
  setDvar(@ "hash_63eb1893f96ac98d", 8);
  setDvar(@ "hash_6157be5fe5b7cd6e", 12);
  setDvar(@ "hash_cb82c01fec2d534b", 32);
  setDvar(@ "hash_5d66c2ef5a9612e0", 0);
  setDvar(@ "hash_dacffbfd52c2fdc5", 32);
  setDvar(@ "hash_eca4b727b01fd254", 8);
  wait 0.1;
  thread function_238c2a0aae70e973("1_exfil_begin_fixture", 1, 1.2);
  thread function_238c2a0aae70e973("1_exfil_melty_run_rim", 1, 2);
  thread function_238c2a0aae70e973("1_exfil_price_rappel_key", 0.5, 6);
  thread function_238c2a0aae70e973("1_exfil_price_rappel_fill", 0.5, 1.6);
  flag_wait("lgt_exfil_face_exit");
  thread function_238c2a0aae70e973("reactor_sun_light", 1, 0);
  thread function_238c2a0aae70e973("1_exfil_melty_run_rim", 0.5, 0);
  thread function_238c2a0aae70e973("1_exfil_price_rappel_key", 0.5, 0);
  thread function_238c2a0aae70e973("1_exfil_price_rappel_fill", 0.5, 0);
  thread function_238c2a0aae70e973("1_exfil_melty_face_key", 0.5, 3.2);
  thread function_238c2a0aae70e973("1_exfil_melty_face_rim", 0.5, 4);
  thread function_238c2a0aae70e973("1_exfil_melty_face_green_rim", 0.5, 2);
  thread function_238c2a0aae70e973("1_exfil_melty_face_green_fill", 0.5, 12);
  flag_wait("lgt_exfil_melty_end");
  thread function_238c2a0aae70e973("1_exfil_top_rappel_rim", 1, 160);
  thread function_238c2a0aae70e973("1_exfil_top_rappel_fill", 1, 60);
  flag_wait("lgt_exfil_rope_up");
  thread function_238c2a0aae70e973("1_exfil_melty_face_key", 1, 0);
  thread function_238c2a0aae70e973("1_exfil_melty_face_rim", 1, 0);
  thread function_238c2a0aae70e973("1_exfil_melty_face_green_rim", 1, 0);
  thread function_238c2a0aae70e973("1_exfil_melty_face_green_fill", 1, 0);
  flag_wait("lgt_exfil_look_up");
  wait 0.1;
  thread function_fd6901fbd5afbe90();
  visionsetnaked("cp_jup_chemical_exfil_bright", 0.5);
  setDvar(@ "hash_d559c6b906603ff1", 1);
  thread function_238c2a0aae70e973("1_exfil_top_rappel_rim", 0.5, 0);
  thread function_238c2a0aae70e973("1_exfil_top_rappel_fill", 0.5, 0);
  thread function_238c2a0aae70e973("1_exfil_reach_top_key", 1, 2);
  thread function_238c2a0aae70e973("1_exfil_top_rim", 1, 1.2);
  flag_wait("lgt_exfil_vision_lerp");
  visionsetnaked("cp_jup_chemical_exfil", 1);
  flag_wait("lgt_exfil_letterbox_trigger");
  thread function_de10ba73d5b3559();
  flag_wait("lgt_exfil_pull_up");
  thread function_238c2a0aae70e973("1_exfil_reach_top_rim", 1, 0.4);
  thread function_238c2a0aae70e973("1_exfil_reach_top_key", 1, 0.2);
  wait 4.2;
  thread function_238c2a0aae70e973("1_exfil_reach_top_key", 1, 0);
  thread function_238c2a0aae70e973("1_exfil_top_rim", 1, 0);
  thread function_238c2a0aae70e973("1_exfil_reach_top_rim", 1, 0);
  thread function_238c2a0aae70e973("1_exfil_top_price_key", 2, 2.4);
  thread function_238c2a0aae70e973("1_exfil_top_price_blue_rim", 2, 0.08);
  flag_wait("lgt_exfil_soap_focus");
  thread function_238c2a0aae70e973("1_exfil_top_price_key", 0, 0);
  thread function_238c2a0aae70e973("1_exfil_top_price_blue_rim", 0, 0);
  thread function_238c2a0aae70e973("1_exfil_top_team_key", 0, 0.2);
  thread function_238c2a0aae70e973("1_exfil_top_team_rim", 0, 3.6);
  thread function_238c2a0aae70e973("1_exfil_top_rim", 0, 0.8);
  flag_wait("lgt_exfil_price_passed_out");
  thread function_238c2a0aae70e973("1_exfil_top_team_key", 0, 0);
  thread function_238c2a0aae70e973("1_exfil_top_rim", 0, 0.8);
  thread function_238c2a0aae70e973("1_exfil_top_price_rim", 0, 0.4);
  flag_wait("lgt_exfil_price_mid_fall");
  thread function_238c2a0aae70e973("1_exfil_top_rim", 1, 0.4);
  thread function_238c2a0aae70e973("1_exfil_top_price_rim", 1, 0.2);
  thread function_238c2a0aae70e973("1_exfil_top_team_rim", 1, 3.6);
  flag_wait("lgt_exfil_cut_to_black");
  visionsetnaked("cp_jup_chemical_exfil_black_fade", 0);
  level waittill("lgt_exfil_end");
  wait 0.5;
  thread function_238c2a0aae70e973("1_exfil_top_rim", 0, 0);
  thread function_238c2a0aae70e973("1_exfil_top_price_rim", 0, 0);
  thread function_238c2a0aae70e973("1_exfil_top_team_rim", 0, 0);
  setDvar(@ "hash_6157be5fe5b7cd6e", 4);
  setDvar(@ "hash_cb82c01fec2d534b", 8);
  level.var_f86dca03b4e10a79 = undefined;
  thread function_9160006a3f10b2cd();
}

function function_de10ba73d5b3559() {
  showcinematicletterboxing(1.5, 0);
}

function function_fe4fe27e7e33ac4c() {
  level waittill("lgt_exfil_end");
  visionsetnaked("", 0);
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
}

function function_e8766b38b7d651bd() {
  level waittill("lgt_exfil_begin");
  level.player thread utility::dof_disable_autofocus();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(7, 14, 15, 50);
  flag_wait("lgt_exfil_melty_emerge");
  level.player setphysicaldepthoffield(3, 80, 15, 50);
  flag_wait("lgt_exfil_face_exit");
  level.player setphysicaldepthoffield(3, 10, 15, 50);
  flag_wait("lgt_exfil_melty_face");
  setDvar(@ "hash_eca4b727b01fd254", 12);
  level.player setphysicaldepthoffield(1, 60, 15, 50);
  flag_wait("lgt_exfil_melty_let_go");
  setDvar(@ "hash_eca4b727b01fd254", 16);
  level.player setphysicaldepthoffield(1, 100, 15, 50);
  flag_wait("lgt_exfil_rope_up");
  level.player setphysicaldepthoffield(1, 13, 15, 50);
  flag_wait("lgt_exfil_look_up");
  setDvar(@ "hash_eca4b727b01fd254", 10);
  level.player setphysicaldepthoffield(1, 80, 15, 50);
  flag_wait("lgt_exfil_vision_lerp");
  setDvar(@ "hash_eca4b727b01fd254", 8);
  setDvar(@ "hash_6157be5fe5b7cd6e", 8);
  level.player setphysicaldepthoffield(1, 30, 15, 50);
  flag_wait("lgt_exfil_pull_up");
  setDvar(@ "hash_eca4b727b01fd254", 4);
  level.player setphysicaldepthoffield(3, 40, 15, 50);
  flag_wait("lgt_exfil_full_gang_on_screen");
  level.player setphysicaldepthoffield(3, 30, 15, 50);
  setDvar(@ "hash_eca4b727b01fd254", 12);
  setDvar(@ "hash_6157be5fe5b7cd6e", 32);
  wait 1;
  level.player setphysicaldepthoffield(3, 25, 15, 50);
  flag_wait("lgt_exfil_focus_on_price");
  level.player setphysicaldepthoffield(2, 50, 15, 50);
  flag_wait("lgt_exfil_focus_on_price_lean_back");
  level.player setphysicaldepthoffield(2, 60, 15, 50);
  flag_wait("lgt_exfil_soap_focus_dof");
  level.player setphysicaldepthoffield(1, 35, 15, 50);
  flag_wait("lgt_exfil_price_passed_out");
  level.player setphysicaldepthoffield(1, 19, 15, 50);
  flag_wait("lgt_exfil_price_mid_fall");
  level.player setphysicaldepthoffield(1, 30, 15, 50);
  flag_wait("lgt_exfil_cut_to_black");
  level.player setphysicaldepthoffield(1, 30, 15, 50);
}

function function_292e53c2238646ea(anim_org) {
  wait 0.1;
  setdvarifuninitialized(@ "hash_8483522c1e47a279", 0);

  if(!isDefined(anim_org)) {
    return;
  }

  level thread function_4e2aad35f7a1fc59();
  level endon("intro_skipped");
  player_1 = anim_org scene::get_entity("Player 1");
  soap_body = anim_org scene::get_entity("soap_body_wind");
  price_body = anim_org scene::get_entity("price_body_wind");
  gaz_body = anim_org scene::get_entity("gaz_body_wind");
  ghost_body = anim_org scene::get_entity("ghost_body_wind");
  jm_body = anim_org scene::get_entity("jm_body");
  var_7f39dd5784699e01 = anim_org scene::get_entity("Prop 2");
  flag_wait("lgt_infil_face_team");
  guys = [player_1, soap_body, price_body, gaz_body, ghost_body, jm_body];

  foreach(guy in guys) {
    if(!guy isscriptable()) {
      if(getdvarint(@ "hash_8483522c1e47a279")) {
        if(isDefined(guy.model)) {
          println("<dev string:x1c>" + guy.classname + "<dev string:x49>" + guy.model);
        } else {
          println("<dev string:x1c>" + guy.classname);
        }
      }
    }
  }

  soap_body setscriptablepartstate("wind", "80", 0);
  price_body setscriptablepartstate("wind", "80", 0);
  gaz_body setscriptablepartstate("wind", "80", 0);
  ghost_body setscriptablepartstate("wind", "80", 0);
  jm_body setscriptablepartstate("wind", "80", 0);
}

function function_4e2aad35f7a1fc59() {
  level waittill("lgt_infil_end");
}

function function_fd6901fbd5afbe90(anim_org) {
  wait 0.1;
  flag_wait("lgt_exfil_look_up");

  if(!isDefined(anim_org)) {
    return;
  }

  soap_body = anim_org scene::get_entity("soap_body");
  price_body = anim_org scene::get_entity("price_body");
  gaz_body = anim_org scene::get_entity("gaz_body");
  ghost_body = anim_org scene::get_entity("ghost_body");
  npc_body = anim_org scene::get_entity("npc_body");
  soap_body setscriptablepartstate("wind", "100", 0);
  price_body setscriptablepartstate("wind", "100", 0);
  gaz_body setscriptablepartstate("wind", "100", 0);
  ghost_body setscriptablepartstate("wind", "100", 0);
  flag_wait("lgt_exfil_price_passed_out");
  soap_body setscriptablepartstate("wind", "0", 0);
  price_body setscriptablepartstate("wind", "0", 0);
  gaz_body setscriptablepartstate("wind", "0", 0);
  ghost_body setscriptablepartstate("wind", "0", 0);
}

function function_dea862127c0706ab(light, start_pos, end_pos) {
  light = getEnt("2_exfil_price_key_window", "targetname");
  start_pos = getStruct("lgt_start_pos", "targetname");
  end_pos = getStruct("lgt_end_pos", "targetname");
  thread function_bb9b60091de365cc(light, 0, start_pos.origin);
  waitframe();
  thread function_238c2a0aae70e973("2_exfil_price_key_window", 0, 4);
  thread function_bb9b60091de365cc(light, 4, end_pos.origin);
  wait 4;
  thread function_bb9b60091de365cc(light, 0, start_pos.origin);
  thread function_238c2a0aae70e973("2_exfil_price_key_window", 0, 0);
}

function function_bb9b60091de365cc(ent, time, target) {
  startorigin = ent.origin;
  t = 0;

  while(t < time) {
    ent.origin = vectorlerp(startorigin, target, t / time);
    t += 0.05;
    wait 0.05;
  }

  ent.origin = target;
}