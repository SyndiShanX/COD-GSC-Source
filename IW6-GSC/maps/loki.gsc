/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\loki.gsc
*****************************************************/

main() {
  checkpoint_setup();
  level.jkudebug = 0;
  level.primary_weapon = "arx160_space+acog_sp+glarx160_sp";
  level.breach_weapon = "arx160_single_space+acogspacebreach_sp+glarx160_sp";
  level.accuracy_ally = 1;
  level.accuracy_enemy = 1;
  maps\_utility::template_level("loki");
  maps\createart\loki_art::main();
  maps\loki_fx::main();
  maps\loki_precache::main();
  common_scripts\utility::flag_init("infil_introscreen_done");
  maps\_load::main();
  maps\loki_audio::main();
  maps\loki_anim::main();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9.01);
  mission_flag_inits();
  mission_precache();
  mission_mains();
  level thread mission_objectives();
  level thread mission_object_control();
  level maps\_utility::delaythread(1.0, maps\_utility::set_team_bcvoice, "allies", "taskforce");
  maps\_utility::intro_screen_create(&"LOKI_INTROSCREEN_LINE_0", & "LOKI_INTROSCREEN_LINE_1", & "LOKI_INTROSCREEN_LINE_2", & "LOKI_INTROSCREEN_LINE_6");
  maps\_utility::intro_screen_custom_func(::introscreen);
  level.player player_helmet();
  space_script_setup();
  thread common_scripts\_pipes::main();
  level.pipesdamage = 0;
}

space_script_setup() {
  if(isDefined(level.script_setup)) {
    return;
  }
  level.script_setup = 1;
  maps\_space::set_glass_zero_gravity();
  maps\_space_player::init_player_space();
  maps\_space_ai::init_ai_space();
  level.player loki_give_weapons();
  level.player thread space_sprinting_adjustments();
  maps\_colors::add_cover_node("Path 3D");
  maps\_colors::add_cover_node("Cover Stand 3D");
  maps\_colors::add_cover_node("Cover Right 3D");
  maps\_colors::add_cover_node("Cover Left 3D");
  maps\_colors::add_cover_node("Cover Up 3D");
  maps\_colors::add_cover_node("Exposed 3D");
  maps\_space_player::init_player_space_anims();
  level.water_level_z = level.player.origin[2];
  level.default_goalradius = 64;
  level.player maps\_space_player::enable_player_space();
  level.player notify("stop_space_breathe");
  setsaveddvar("bg_viewBobAmplitudeStanding", "0.0 0.0");
  setsaveddvar("bg_viewBobAmplitudeStandingAds", "0.0 0.0");
  setsaveddvar("bg_viewBobAmplitudeDucked", "0.0 0.0");
  setsaveddvar("bg_viewBobAmplitudeDuckedAds", "0.0 0.0");
  setsaveddvar("bg_viewBobAmplitudeSprinting", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeStanding", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeDucked", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeSprinting", "0.0 0.0");
  setsaveddvar("bg_weaponBobAmplitudeBase", 0.0);
  setsaveddvar("bg_viewBobMax", 0);
  setsaveddvar("g_gravity", 1);
  setsaveddvar("compass", 0);
}

space_sprinting_adjustments() {
  self endon("death");
  self endon("stop_space_sprinting_adjustments");
  var_0 = getdvarfloat("cg_fov");
  var_1 = var_0 * 0.975;
  var_2 = 0.5;
  var_3 = 0.75;

  for(;;) {
    maps\loki_util::jkuprint("not sprinting");

    while(!self issprinting())
      common_scripts\utility::waitframe();

    maps\loki_util::jkuprint("sprinting");
    earthquake(0.05, 1, level.player.origin, 200);
    var_4 = maps\loki_util::create_rumble_ent(925, "blaa", 1.5);
    var_4 playrumbleonentity("light_2s");

    while(self issprinting())
      common_scripts\utility::waitframe();

    if(!self adsbuttonpressed()) {
      maps\loki_util::jkuprint("lerp out no ads");
      continue;
    }

    while(self adsbuttonpressed())
      common_scripts\utility::waitframe();

    maps\loki_util::jkuprint("fov post ads");
    setsaveddvar("cg_fov", var_0);
  }
}

player_helmet(var_0, var_1) {
  if(getdvarint("sg_scuba_mask_off") == 1) {
    return;
  }
  if(getdvarint("demo_mode")) {
    return;
  }
  var_2 = "halo_overlay_scuba";

  if(isDefined(var_1))
    var_2 = var_1;

  self.hud_scubamask = maps\_hud_util::create_client_overlay(var_2, 1, self);
  self.hud_scubamask.foreground = 0;
  self.hud_scubamask.sort = -99;
  self.hud_scubamask_model = spawn("script_model", level.player getEye());
  self.hud_scubamask_model setModel("viewmodel_us_space_helmet");
  self.hud_scubamask_model linktoplayerview(self, "tag_origin", (0, 0, 0), (0, 90, -4), 1);

  if(getdvarint("demo_mode"))
    self.hud_scubamask_model delete();
}

player_helmet_disable(var_0) {
  if(getdvarint("sg_scuba_mask_off") == 1) {
    return;
  }
  if(getdvarint("demo_mode")) {
    return;
  }
  if(isDefined(self.hud_scubamask)) {
    self.hud_scubamask maps\_hud_util::destroyelem();
    self.hud_scubamask_model unlinkfromplayerview(self);
    self.hud_scubamask_model delete();
  }
}

loki_give_weapons() {
  level.player thread maps\loki_util::ammo_hack();
  self disableweaponpickup();
}

checkpoint_setup() {
  maps\_utility::default_start(::infil_start);
  maps\_utility::set_default_start("infil");
  maps\_utility::add_start("infil", ::infil_start, "Infil", ::infil);
  maps\_utility::add_start("combat_one", ::combat_one_start, "Combat One", ::combat_one);
  maps\_utility::add_start("moving_cover", ::moving_cover_start, "Moving Cover", ::moving_cover);
  maps\_utility::add_start("combat_two", ::combat_two_start, "Combat Two", ::combat_two);
  maps\_utility::add_start("space_breach", ::space_breach_start, "Space Breach", ::space_breach);
  maps\_utility::add_start("rog", ::rog_start, "R.O.G.", ::rog);
  maps\_utility::add_start("ending", ::ending_start, "Ending", ::ending);
}

mission_flag_inits() {
  common_scripts\utility::flag_init("infil_done");
  common_scripts\utility::flag_init("combat_one_done");
  common_scripts\utility::flag_init("moving_cover_done2");
  common_scripts\utility::flag_init("combat_two_done");
  common_scripts\utility::flag_init("space_breach_done");
  common_scripts\utility::flag_init("rog_done");
  common_scripts\utility::flag_init("boundary_system_on");
  common_scripts\utility::flag_init("turn_off_rogs");
  common_scripts\utility::flag_init("explosion");
  level thread maps\loki_infil::section_flag_inits();
  level thread maps\loki_combat_one::section_flag_inits();
  level thread maps\loki_moving_cover::section_flag_inits();
  level thread maps\loki_combat_two::section_flag_inits();
  level thread maps\loki_space_breach::section_flag_inits();
  level thread maps\loki_rog::section_flag_inits();
  level thread maps\loki_ending::section_flag_inits();
  maps\loki_audio::audio_flag_inits();
}

mission_precache() {
  objective_string_precache();
  precacheitem("arx160_single_space");
  precacheshader("hud_xm25_temp");
  precacheshader("hud_xm25_scanlines");
  precacheshader("apache_target_lock");
  precacheshader("veh_hud_target_invalid");
  level thread maps\_space::precache();
  level thread maps\loki_infil::section_precache();
  level thread maps\loki_combat_one::section_precache();
  level thread maps\loki_moving_cover::section_precache();
  level thread maps\loki_combat_two::section_precache();
  level thread maps\loki_space_breach::section_precache();
  level thread maps\loki_rog::section_precache();
  level thread maps\loki_ending::section_precache();
}

mission_mains() {
  level thread maps\loki_infil::section_main();
  level thread maps\loki_combat_one::section_main();
  level thread maps\loki_moving_cover::section_main();
  level thread maps\loki_combat_two::section_main();
  level thread maps\loki_space_breach::section_main();
  level thread maps\loki_rog::section_main();
  level thread maps\loki_ending::section_main();
}

objective_string_precache() {
  precachestring(&"LOKI_INTROSCREEN_LINE_0");
  precachestring(&"LOKI_INTROSCREEN_LINE_1");
  precachestring(&"LOKI_INTROSCREEN_LINE_2");
  precachestring(&"LOKI_OBJ_LAND");
  precachestring(&"LOKI_OBJ_ADVANCE");
  precachestring(&"LOKI_OBJ_BREACH");
  precachestring(&"LOKI_OBJ_SAVE_DAY");
  precachestring(&"LOKI_OBJ_START_ROG");
  precachestring(&"LOKI_OBJ_ROG_DEFEND");
  precachestring(&"LOKI_OBJ_ROG_ELIMINATE");
  precachestring(&"LOKI_OBJ_ROG_TRAIN_TARGET");
  precachestring(&"LOKI_OBJ_LOCATE_ENTRANCE");
  precachestring(&"LOKI_OBJ_ENTER_HATCH");
  precachestring(&"LOKI_OBJ_LOCATE_CONTROL");
}

mission_objectives() {
  switch (level.start_point) {
    case "infil":
      wait 25.5;
      objective_add(maps\_utility::obj("obj_land"), "current", & "LOKI_OBJ_LAND");
      common_scripts\utility::flag_wait("infil_done");
      wait 6.0;
    case "combat_one":
      if(level.start_point == "combat_one")
        objective_add(maps\_utility::obj("obj_land"), "current", & "LOKI_OBJ_LAND");

      objective_add(maps\_utility::obj("obj_locate_entrance"), "current", & "LOKI_OBJ_LOCATE_ENTRANCE");
      var_0 = getent("combat_one_trig_wave3", "targetname");
      var_0 waittill("trigger");
      wait 3.0;
      objective_state(maps\_utility::obj("obj_locate_entrance"), "done");
      level waittill("player_can_move_to_door");
      wait 1.0;

      if(!common_scripts\utility::flag("start_fuel_explosion")) {
        objective_add(maps\_utility::obj("obj_enter_hatch"), "current", & "LOKI_OBJ_ENTER_HATCH");
        common_scripts\utility::flag_wait("combat_one_done");
        wait 1.0;
        objective_state(maps\_utility::obj("obj_enter_hatch"), "failed");
        wait 0.5;
      }

      common_scripts\utility::flag_wait("combat_one_done");
      objective_delete(maps\_utility::obj("obj_land"));
    case "moving_cover":
      common_scripts\utility::flag_wait("moving_cover_done2");
    case "combat_two":
      level waittill("combat_2_unlinked");
      objective_add(maps\_utility::obj("obj_locate_control"), "current", & "LOKI_OBJ_LOCATE_CONTROL");
      maps\loki_combat_two::waittill_trigger_targetname("combat_two_third_wave_extra");
      objective_state(maps\_utility::obj("obj_locate_control"), "done");
      wait 0.5;
      objective_add(maps\_utility::obj("obj_advance"), "current", & "LOKI_OBJ_ADVANCE");
      common_scripts\utility::flag_wait("combat_two_done");
      maps\_utility::objective_complete(maps\_utility::obj("obj_advance"));
      wait 1.5;
    case "space_breach":
      objective_add(maps\_utility::obj("obj_breach"), "current", & "LOKI_OBJ_BREACH");
      common_scripts\utility::flag_wait("space_breach_done");
      maps\_utility::objective_complete(maps\_utility::obj("obj_breach"));
      wait 0.5;

      if(!common_scripts\utility::flag("attack_pressed")) {
        objective_add(maps\_utility::obj("obj_start_rog"), "current", & "LOKI_OBJ_START_ROG");
        common_scripts\utility::flag_wait("console_activated");
        maps\_utility::objective_complete(maps\_utility::obj("obj_start_rog"));
      }
    case "rog":
      common_scripts\utility::flag_wait("ROG_look_at_sat_farm");
      wait 1.5;
      objective_add(maps\_utility::obj("obj_rog_airfield"), "current", & "LOKI_OBJ_ROG_ELIMINATE");
      common_scripts\utility::flag_wait("ROG_look_at_train");
      maps\_utility::objective_complete(maps\_utility::obj("obj_rog_airfield"));
      common_scripts\utility::flag_wait("ROG_look_at_main_base");
      wait 1.5;
      objective_add(maps\_utility::obj("obj_rog_train_protect"), "current", & "LOKI_OBJ_ROG_DEFEND");
      common_scripts\utility::flag_wait("ROG_take_in_destruction");
      maps\_utility::objective_complete(maps\_utility::obj("obj_rog_train_protect"));
      common_scripts\utility::flag_wait("ROG_exit");
    case "ending":
      level waittill("waiting_for_player_to_fire");
      objective_add(maps\_utility::obj("obj_rog_train_destroy"), "current", & "LOKI_OBJ_ROG_TRAIN_TARGET");
      common_scripts\utility::flag_wait("player_flipped_switch");
  }
}

mission_object_control() {
  mission_object_control_global();

  switch (level.start_point) {
    case "infil":
      loki_earth_control("combat_one");
      thread maps\loki_fx::fx_infil_rog();
      thread maps\loki_fx::fx_rog_satelittes_firing_c1();
      thread maps\loki_fx::fx_rog_satelittes_close_01();
      thread maps\loki_fx::fx_rog_satelittes_close_02();
      thread maps\loki_fx::fx_rog_satelittes_close_03();
      common_scripts\utility::flag_wait("infil_done");
    case "combat_one":
      if(level.start_point == "combat_one") {
        thread maps\loki_fx::fx_rog_satelittes_firing_c1();
        thread maps\loki_fx::fx_rog_satelittes_close_01();
        thread maps\loki_fx::fx_rog_satelittes_close_02();
        thread maps\loki_fx::fx_rog_satelittes_close_03();
        loki_earth_control("combat_one");
      }

      thread maps\loki_infil::infil_cleanup();
      common_scripts\utility::flag_wait("combat_one_done");
    case "moving_cover":
      thread maps\loki_fx::fx_c2_rog_satelittes_close_01();
      thread maps\loki_fx::fx_rog_satelittes_firing_c2();
      loki_earth_control("combat_two");
      thread maps\loki_infil::infil_cleanup();
      thread maps\loki_combat_one::combat_one_cleanup();
      common_scripts\utility::flag_wait("moving_cover_done2");
    case "combat_two":
      if(level.start_point == "combat_two") {
        loki_earth_control("combat_two");
        thread maps\loki_fx::fx_c2_rog_satelittes_close_01();
        thread maps\loki_fx::fx_rog_satelittes_firing_c2();
      }

      thread maps\loki_infil::infil_cleanup();
      thread maps\loki_combat_one::combat_one_cleanup();
      common_scripts\utility::flag_wait("combat_two_done");
    case "space_breach":
      if(level.start_point == "space_breach") {
        loki_earth_control("combat_two");
        thread maps\loki_fx::fx_c2_rog_satelittes_close_01();
        thread maps\loki_fx::fx_rog_satelittes_firing_c2();
      }

      thread maps\loki_infil::infil_cleanup();
      thread maps\loki_combat_one::combat_one_cleanup();
      thread maps\loki_moving_cover::moving_cover_cleanup();
      common_scripts\utility::flag_wait("charge_set");
      wait 1.0;
      loki_earth_control("breach");
      common_scripts\utility::flag_wait("player_breach_anim_done");
      loki_earth_control("control_room");
      common_scripts\utility::flag_wait("space_breach_done");
      level thread maps\loki_util::player_boundaries_on(undefined, 1, 1);
    case "rog":
      if(!(level.start_point == "rog")) {
        level waittill("switching_to_rog");
        loki_earth_control("hidden");
      }

      level notify("boundary_system_off");
      thread maps\loki_infil::infil_cleanup();
      thread maps\loki_combat_one::combat_one_cleanup();
      thread maps\loki_moving_cover::moving_cover_cleanup();
      common_scripts\utility::flag_wait("ROG_exit");
    case "ending":
      loki_earth_control("control_room");
  }
}

mission_object_control_global() {
  loki_earth_control("hidden");
  thread loki_intro_lod_hide();
  thread loki_control_room_boundaries();
  maps\loki_space_breach::move_controlroom_to_new_location();
  maps\loki_combat_two::hide_combat_two_intro_debris();
  setsaveddvar("r_hudoutlineenable", 1);
  setsaveddvar("r_hudOutlineWidth", 2);
  thread maps\loki_util::player_physics_pulse("console_activated");
}

loki_intro_lod_hide() {
  wait 0.05;
  var_0 = getent("loki_combat1_lod", "targetname");
  var_1 = 10000;

  if(level.start_point == "infil") {
    while(var_1 > 3500) {
      var_1 = distance(level.player.origin, var_0.origin);
      wait 0.05;
    }
  }

  var_0 delete();
}

loki_control_room_boundaries() {
  var_0 = getEntArray("control_room_boundary_collision", "targetname");

  foreach(var_2 in var_0)
  var_2 notsolid();
}

loki_earth_control(var_0) {
  var_1 = getent("earth_model", "targetname");

  if(!isDefined(level.earth_origin_start))
    level.earth_origin_start = var_1.origin;

  switch (var_0) {
    case "hidden":
      var_1 hide();
      break;
    case "combat_one":
      var_1.angles = (12.4236, 280.161, -105.534);
      var_1.origin = level.earth_origin_start;
      var_1 show();
      break;
    case "combat_two":
      var_1.angles = (347.208, 277.522, -177.143);
      var_2 = (79452, -11839, -12702);
      var_1.origin = var_2 + level.earth_origin_start;
      var_1 show();
      break;
    case "breach":
      var_1.angles = (347.208, 277.522, -177.143);
      var_2 = (79452, -11839, -12702);
      var_1.origin = var_2 + level.earth_origin_start;
      maps\loki_space_breach::set_earth_pos_during_breach(var_1);
      var_1 show();
      break;
    case "control_room":
      var_1.angles = (328.351, 281.676, -113.929);
      var_2 = (0, -1321.5, 8785);
      var_1.origin = var_2 + level.earth_origin_start;
      var_1 show();
      break;
  }
}

introscreen() {
  var_0 = 11.51;
  level maps\_utility::delaythread(0.412, maps\_utility::smart_radio_dialogue, "loki_mrk_icarusactualthisis");
  level maps\_utility::delaythread(6.898, maps\_utility::smart_radio_dialogue, "loki_kgn_merrickweneedthe");
  level maps\_utility::delaythread(9.97, maps\_utility::smart_radio_dialogue, "loki_mrk_makeitfasticarus");
  level maps\_utility::delaythread(13.933, maps\_utility::smart_radio_dialogue, "loki_shp1_icarusdeimosiscoming");
  level maps\_utility::delaythread(20.938, maps\_utility::smart_radio_dialogue, "loki_kgn_readyforsomerevenge");
  level maps\_utility::delaythread(24.899, maps\_utility::smart_radio_dialogue, "loki_kgn_evasuitsareen");
  level maps\_utility::delaythread(28.83, maps\_utility::smart_radio_dialogue, "loki_kgn_weaponshot");
  level maps\_utility::delaythread(27.5, common_scripts\utility::flag_set, "combat_one_music_start");
  maps\_utility::delaythread(var_0 - 0.1, common_scripts\utility::flag_set, "infil_introscreen_done");
  thread maps\_introscreen::introscreen(1);
  thread introscreen_black_alternate(var_0);
  wait(var_0);
}

introscreen_flicker() {
  level.player maps\_hud_util::fade_out(1, "black");
  wait 0.05;
  level.player maps\_hud_util::fade_in(0.15, "black");
  wait 0.1;
  level.player maps\_hud_util::fade_out(0.1, "black");
  wait 0.05;
  level.player maps\_hud_util::fade_in(0.15, "black");
  wait 0.1;
  level.player maps\_hud_util::fade_out(0.1, "black");
  wait 0.15;
  level.player maps\_hud_util::fade_in(0.15, "black");
}

introscreen_black_alternate(var_0) {
  setsaveddvar("cg_drawCrosshair", 0);
  setsaveddvar("ammoCounterHide", 1);
  var_1 = maps\_hud_util::create_client_overlay("black", 1, level.player);
  level.player freezecontrols(1);
  wait 0.5;
  var_1.foreground = 0;
  wait(var_0 - 0.5);
  level.player freezecontrols(0);
  var_1 fadeovertime(2.0);
  var_1.alpha = 0;
  wait 2.0;
  level notify("intro_faded_in");
  setsaveddvar("cg_drawCrosshair", 1);
  setsaveddvar("ammoCounterHide", 0);
}

infil_start() {
  maps\loki_infil::infil_start();
}

infil() {
  maps\loki_infil::infil();
}

combat_one_start() {
  maps\loki_combat_one::combat_one_start();
  thread maps\loki_audio::sfx_loki_breathing_logic(1);
}

combat_one() {
  maps\loki_combat_one::combat_one();
}

moving_cover_start() {
  maps\loki_moving_cover::moving_cover_start();
  thread maps\loki_audio::sfx_loki_breathing_logic(1);
}

moving_cover() {
  maps\loki_moving_cover::moving_cover();
}

combat_two_start() {
  maps\loki_combat_two::combat_two_start();
  thread maps\loki_audio::sfx_loki_breathing_logic(1);
}

combat_two() {
  maps\loki_combat_two::combat_two();
}

space_breach_start() {
  maps\loki_space_breach::space_breach_start();
  thread maps\loki_audio::sfx_loki_breathing_logic(0);
}

space_breach() {
  maps\loki_space_breach::space_breach();
  thread maps\loki_audio::sfx_loki_breathing_logic(0);
}

rog_start() {
  maps\loki_rog::rog_start();
  thread maps\loki_audio::sfx_loki_breathing_logic(0);
}

rog() {
  maps\loki_rog::rog();
}

ending_start() {
  maps\loki_ending::ending_start();
  thread maps\loki_audio::sfx_loki_breathing_logic(1);
}

ending() {
  maps\loki_ending::ending();
}