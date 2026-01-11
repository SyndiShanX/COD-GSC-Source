/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\youngblood.gsc
*****************************************************/

main() {
  maps\_utility::template_level("youngblood");
  youngblood_earthquake_setup();
  maps\createart\youngblood_art::main();
  maps\youngblood_fx::main();
  maps\youngblood_precache::main();
  maps\_player_limp::init_player_limp();
  maps\_utility::add_start("start_deer", ::setup_deer, undefined, ::start_deer);
  maps\_utility::add_start("start_after_hunt", ::setup_after_hunt, undefined, ::start_after_hunt);
  maps\_utility::add_start("start_woods", ::setup_woods, undefined, ::start_woods);
  maps\_utility::add_start("start_neighborhood", ::setup_neighborhood, undefined, ::start_neighborhood);
  maps\_utility::add_start("start_mansion_ext", ::setup_mansion_ext, undefined, ::start_mansion_ext);
  maps\_utility::add_start("start_mansion", ::setup_mansion, undefined, ::start_mansion);
  maps\_utility::add_start("start_chaos_a", ::setup_chaos_a, undefined, ::start_chaos_a);
  maps\_utility::add_start("start_chaos_b", ::setup_chaos_b, undefined, ::start_chaos_b);
  maps\_utility::add_start("start_pickup", ::setup_pickup, undefined, ::start_pickup);
  maps\_utility::add_start("start_test", ::start_test, undefined);
  maps\_utility::add_start("start_test_area_a", ::start_test_area_a, undefined);
  maps\_utility::add_start("start_test_area_b", ::start_test_area_b, undefined);
  maps\_load::main();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);

  if(maps\_utility::is_gen4()) {
    set_default_mb_values();
  }

  maps\youngblood_audio::main();
  maps\youngblood_anim::main();
  yb_precache();
  youngblood_script_setup();
  yb_flag_inits();
  yb_setup();
  thread entity_counter();
}

yb_precache() {
  precachemodel("electronics_camera_pointandshoot_low");
  precachemodel("electronics_camera_cellphone_low");
  precachemodel("cup_paper_open_iw6");
  precachemodel("viewhands_gs_hostage");
  precachemodel("viewhands_gs_hostage_clean");
  precachemodel("viewhands_player_gs_hostage");
  precachemodel("viewhands_player_gs_hostage_clean");
  precachemodel("vfx_ygb_roadcrack_a_to_e_first_frame");
  precachemodel("vfx_ygb_roadcrack_a_to_e_last_frame");
  precachemodel("vfx_ygb_churchcollapse_first_frame");
  precacheitem("noweapon_youngblood");
  precachestring(&"YOUNGBLOOD_INTROSCREEN_LINE_1");
  precachestring(&"YOUNGBLOOD_INTROSCREEN_LINE_5");
  precachestring(&"YOUNGBLOOD_HINT_SPRINT");
  precachestring(&"YOUNGBLOOD_LEFTBEHIND");
  precachestring(&"YOUNGBLOOD_AVOIDCARS");
  precacherumble("light_1s");
  precacherumble("light_2s");
  precacherumble("heavy_3s");
  precacherumble("tank_rumble");
  precacherumble("prologue_chaos_a");
  precacheshellshock("ygb_crash");
  precacheshellshock("ygb_end");
  precacheshellshock("ygb_end_lite");
  maps\_utility::add_hint_string("hint_sprint", &"YOUNGBLOOD_HINT_SPRINT", ::sprint_hint_check);
}

custom_intro_screen_func() {
  common_scripts\utility::flag_wait("yb_intro_plr_unlink");
  maps\_introscreen::introscreen(1);
}

yb_flag_inits() {
  level.woods_movement = "walk";
  level.player maps\_utility::ent_flag_init("fall");
  level.player maps\_utility::ent_flag_init("collapse");
  common_scripts\utility::flag_init("yb_intro_plr_unlink");
  common_scripts\utility::flag_init("player_unsafe");
  common_scripts\utility::flag_init("chaos_insta_death");
  common_scripts\utility::flag_init("chaos_player_safe");
  common_scripts\utility::flag_init("suppress_crash_player_fx");
  common_scripts\utility::flag_init("do_player_crash_fx");
  common_scripts\utility::flag_init("town_car_spawn");
  common_scripts\utility::flag_init("campfire_start");
  common_scripts\utility::flag_init("new_start_after_hunt");
  common_scripts\utility::flag_init("ah_tremor_2");
  common_scripts\utility::flag_init("new_treefall");
  common_scripts\utility::flag_init("load_car_1");
  common_scripts\utility::flag_init("load_car_2");
  common_scripts\utility::flag_init("hesh_middle_room_in_position");
  common_scripts\utility::flag_init("player_near_fence");
  common_scripts\utility::flag_init("player_past_fence");
  common_scripts\utility::flag_init("play_street_cracking");
  common_scripts\utility::flag_init("intro_clear");
  common_scripts\utility::flag_init("start_deer");
  common_scripts\utility::flag_init("deer_awaiting_death");
  common_scripts\utility::flag_init("start_after_hunt");
  common_scripts\utility::flag_init("start_woods");
  common_scripts\utility::flag_init("start_neighborhood");
  common_scripts\utility::flag_init("start_mansion");
  common_scripts\utility::flag_init("start_chaos_b");
  common_scripts\utility::flag_init("pool_crack");
  common_scripts\utility::flag_init("yb_player_crests_hill");
  common_scripts\utility::flag_init("player_top_hill");
  common_scripts\utility::flag_init("hesh_climbs_into_mansion");
  common_scripts\utility::flag_init("pool_crack");
  common_scripts\utility::flag_init("hesh_finish_1st");
  common_scripts\utility::flag_init("start_pickup");
  common_scripts\utility::flag_init("player_near_first_jump");
  common_scripts\utility::flag_init("player_jumped_into_house");
  common_scripts\utility::flag_init("player_exits_sliding_house");
  common_scripts\utility::flag_init("hesh_sequence_done");
  common_scripts\utility::flag_init("house_k2_k3_anim");
  common_scripts\utility::flag_init("player_area_1");
  common_scripts\utility::flag_init("player_area_2");
  common_scripts\utility::flag_init("player_area_3");
  common_scripts\utility::flag_init("player_area_4");
  common_scripts\utility::flag_init("player_near_debris_door");
  common_scripts\utility::flag_init("watchout_car");
  common_scripts\utility::flag_init("chaos_hesh_go");
  common_scripts\utility::flag_init("hesh_in_truck");
  common_scripts\utility::flag_init("end_truck_in_pos");
  common_scripts\utility::flag_init("yb_mission_over");
  common_scripts\utility::flag_init("load_1");
  common_scripts\utility::flag_init("load_2");
  common_scripts\utility::flag_init("load_3");
  common_scripts\utility::flag_init("car_move_forward");
  common_scripts\utility::flag_init("passenger_1_in");
  common_scripts\utility::flag_init("passenger_2_in");
  common_scripts\utility::flag_init("player_on_house_floor");
  common_scripts\utility::flag_init("trig_player_inside_house");
  common_scripts\utility::flag_init("both_chars_on_floor");
  common_scripts\utility::flag_init("truck_landed_exit_scene");
  common_scripts\utility::flag_init("player_enter_2nd_door");
  common_scripts\utility::flag_init("player_near_mansion_exit");
  common_scripts\utility::flag_init("truck_near_vista");
  common_scripts\utility::flag_init("church_fall_go");
  common_scripts\utility::flag_init("hesh_moving_to_truck");
  common_scripts\utility::flag_init("truck_incoming");
  common_scripts\utility::flag_init("truck_2nd_position");
  common_scripts\utility::flag_init("truck_1st_position");
  common_scripts\utility::flag_init("truck_2nd_position");
  common_scripts\utility::flag_init("truck_3rd_position");
  common_scripts\utility::flag_init("truck_arrived_pos_1");
  common_scripts\utility::flag_init("truck_pickup_npcs");
  common_scripts\utility::flag_init("truck_arrived_npc_pos");
  common_scripts\utility::flag_init("truck_exit_map");
  common_scripts\utility::flag_init("npc_near_truck");

  if(!common_scripts\utility::flag_exist("transition_from_odin_to_yb_done")) {
    common_scripts\utility::flag_init("transition_from_odin_to_yb_done");
  }
}

yb_setup() {
  level.player setviewmodel("viewhands_gs_hostage");
  level.player takeallweapons();
  level.player giveweapon("noweapon_youngblood");
  level.player giveweapon("noweapon_youngblood+yb_state_chaos");
  level.player giveweapon("noweapon_youngblood+yb_state_hill");
  level.player giveweapon("noweapon_youngblood+yb_state_tremor");
  level.player disableweaponswitch();
  level.player switchtoweapon("noweapon_youngblood");
  level.player allowmelee(0);
  level.saved_speed_percent = 56;
  level.no_tremor = 1;
  level.player_anim_not_on = 1;
  level.player_location = undefined;
  setsaveddvar("ammoCounterHide", "1");
  common_scripts\utility::create_dvar("chaos_long_end", 0);
  common_scripts\utility::trigger_off("start_chaos_a", "targetname");
  setsaveddvar("fx_alphathreshold", 9);
  soundsettimescalefactor("Music", 0);
  soundsettimescalefactor("Menu", 0);
  soundsettimescalefactor("local3", 0.0);
  soundsettimescalefactor("Mission", 0.0);
  soundsettimescalefactor("Announcer", 0.0);
  soundsettimescalefactor("Bulletimpact", 0.6);
  soundsettimescalefactor("Voice", 0.4);
  soundsettimescalefactor("effects2", 0.2);
  soundsettimescalefactor("local", 0.4);
  soundsettimescalefactor("physics", 0.2);
  soundsettimescalefactor("ambient", 0.5);
  soundsettimescalefactor("auto", 0.5);
  maps\_utility::intro_screen_create(&"YOUNGBLOOD_INTROSCREEN_LINE_1", &"YOUNGBLOOD_INTROSCREEN_LINE_5", "");
  maps\_utility::intro_screen_custom_func(::custom_intro_screen_func);
  maps\_utility::array_spawn_function_noteworthy("videotaper", maps\youngblood_util::videotaper_think);
  maps\_utility::array_spawn_function_noteworthy("n_watchers", maps\youngblood_code::n_watchers_think);
  maps\_drone_civilian::init();
}

setup_deer() {
  maps\youngblood_util::spawn_hesh();
  maps\youngblood_util::spawn_elias();
  level.elias thread maps\youngblood_util::enable_elias_walk();
  level.hesh thread maps\youngblood_util::enable_hesh_walk();
  maps\youngblood_util::set_start_positions("start_deer");
}

setup_after_hunt() {
  level.player setclienttriggeraudiozone("youngblood_forest_start", 0.0);
  maps\youngblood_util::spawn_elias();
  maps\youngblood_util::spawn_hesh();
  level.elias maps\_utility::disable_sprint();
  level.hesh maps\_utility::disable_sprint();
  level.hesh thread maps\youngblood_util::enable_hesh_walk();
  level.elias thread maps\youngblood_util::enable_elias_walk();
  level.elias.goalradius = 64;
  level.hesh.goalradius = 64;
  level.elias thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("ah_path_elias"), 0);
  level.hesh thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("ah_path_hesh"), 150);
  maps\youngblood_util::yb_player_speed_percent(80);
  level.player allowsprint(0);
  maps\youngblood_util::set_start_positions("start_deer");
}

setup_woods() {
  level.player setclienttriggeraudiozone("youngblood_forest_upper", 0.0);
  maps\youngblood_util::spawn_elias();
  maps\youngblood_util::spawn_hesh();
  level.hesh thread maps\youngblood_util::enable_hesh_walk();
  level.elias thread maps\youngblood_util::enable_elias_walk();
  maps\youngblood_util::set_start_positions("start_woods");
  common_scripts\utility::flag_set("new_treefall");
  level.player_location_vfx = "vfx_yb_onplayer_02_trunkroll";
  level.player thread maps\youngblood_code::vfx_on_player_location_to_odin();
}

setup_neighborhood() {
  maps\youngblood_util::spawn_elias();
  maps\youngblood_util::spawn_hesh();
  level.player setclienttriggeraudiozone("youngblood_forest_upper", 2.0);
  level.elias thread maps\youngblood_util::enable_elias_walk();
  level.hesh thread maps\youngblood_util::enable_hesh_walk();
  level.hesh maps\_utility::enable_sprint();
  level.hesh maps\youngblood_util::set_move_rate(1);
  level.elias maps\_utility::enable_sprint();
  level.elias maps\youngblood_util::set_move_rate(1);
  level.saved_speed_percent = 56;
  common_scripts\utility::exploder("evilclouds");
  maps\youngblood_util::set_start_positions("start_neighborhood");
  level.hesh thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("fence_pos_hesh"));
  level.elias thread maps\_utility::follow_path_and_animate(common_scripts\utility::get_target_ent("fence_pos_elias"));
  level.player_location_vfx = "vfx_yb_onplayer_03_afterfence";
  level.player thread maps\youngblood_code::vfx_on_player_location_to_odin();
}

setup_mansion_ext() {
  level.player setclienttriggeraudiozone("youngblood_forest_upper", 0.0);
  maps\youngblood_util::spawn_elias();
  maps\youngblood_util::spawn_hesh();
  level.elias thread maps\youngblood_util::enable_elias_walk();
  level.hesh thread maps\youngblood_util::enable_hesh_walk();
  level.hesh maps\youngblood_util::init_run_animset_alert();
  level.hesh maps\_utility::enable_sprint();
  level.hesh maps\youngblood_util::set_move_rate(1);
  level.elias maps\_utility::enable_sprint();
  level.elias maps\youngblood_util::set_move_rate(1);
  level.player maps\youngblood_util::yb_player_speed_percent(56);
  common_scripts\utility::exploder("evilclouds");
  maps\youngblood_util::set_start_positions("start_mansion_ext");
}

setup_mansion() {
  level.player setclienttriggeraudiozone("youngblood_forest_upper", 0.0);
  maps\youngblood_util::spawn_hesh();
  level.hesh thread maps\youngblood_util::enable_hesh_walk();
  level.hesh maps\_utility::enable_sprint();
  level.hesh maps\youngblood_util::set_move_rate(1);
  level.player maps\youngblood_util::yb_player_speed_percent(56);
  maps\youngblood_util::set_start_positions("start_mansion");
}

setup_chaos_a() {
  level.player setclienttriggeraudiozone("youngblood_slomo_impact", 0.0);
  var_0 = common_scripts\utility::getstruct("player_setup_chaos_pos", "targetname");
  level.player setorigin(var_0.origin);
  level.player setplayerangles(var_0.angles);
  common_scripts\utility::flag_set("new_treefall");
  common_scripts\utility::flag_set("transition_from_odin_to_yb_done");
}

setup_chaos_b() {
  maps\youngblood_util::spawn_hesh();

  if(isDefined(level.prologue) && level.prologue == 1) {
    level.player setviewmodel("viewhands_gs_hostage");
    level.scr_model["player_rig"] = "viewhands_player_gs_hostage";
  }

  level.player setclienttriggeraudiozone("youngblood_chaos", 1.5);
  common_scripts\utility::array_thread(getEntArray("trig_player_rog", "targetname"), maps\youngblood_code::chaos_rog_think);
  level.hesh thread maps\youngblood_util::enable_hesh_walk();
  level.player maps\youngblood_util::yb_player_speed_percent(90);
  maps\youngblood_util::set_start_positions("start_chaos_b");
  level.hesh maps\youngblood_util::init_chaos_animset();
  thread maps\youngblood_code::chaos_b_hide_debris();
  maps\_utility::activate_trigger_with_targetname("basement_vfx_trig");
  maps\_utility::activate_trigger_with_noteworthy("street_flying_house");
}

setup_pickup() {
  maps\youngblood_util::spawn_hesh();
  maps\youngblood_util::spawn_elias();
  maps\_hud_util::fade_out(0.05);
  thread maps\_utility::vision_set_fog_changes("ygb_chaos_b", 0.05);
  level.player setblurforplayer(10, 0.05);

  if(isDefined(level.prologue) && level.prologue == 1) {
    level.player setviewmodel("viewhands_gs_hostage");
    level.scr_model["player_rig"] = "viewhands_player_gs_hostage";
  }

  level.truck = maps\_vehicle::spawn_vehicle_from_targetname("truck");
  level.truck.animname = "pickup";
  level.truck useanimtree(level.scr_animtree["pickup"]);
  level.player setclienttriggeraudiozone("youngblood_chaos", 1.5);
  soundsettimescalefactor("Music", 0);
  soundsettimescalefactor("Menu", 0);
  soundsettimescalefactor("local3", 0.0);
  soundsettimescalefactor("Mission", 0.0);
  soundsettimescalefactor("Announcer", 0.0);
  soundsettimescalefactor("Bulletimpact", 0.6);
  soundsettimescalefactor("Voice", 0.1);
  soundsettimescalefactor("effects2", 0.2);
  soundsettimescalefactor("local", 0.4);
  soundsettimescalefactor("physics", 0.2);
  soundsettimescalefactor("ambient", 0.5);
  soundsettimescalefactor("auto", 0.5);
  common_scripts\utility::exploder("city");
  wait 5;
  setslowmotion(1, 0.4, 0.25);
  common_scripts\utility::flag_set("start_pickup");
}

start_test() {
  maps\youngblood_util::set_start_positions("start_test");
}

start_test_area_a() {
  maps\youngblood_util::set_start_positions("start_test_area_a");
}

start_test_area_b() {
  maps\youngblood_util::set_start_positions("start_test_area_b");
}

start_deer() {
  level.player setclienttriggeraudiozone("youngblood_start_black", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  thread maps\youngblood_code::chaos_hide_on_start();
  maps\youngblood_code::deer();
}

start_after_hunt() {
  setdvar("hud_showObjectives", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  maps\youngblood_code::after_hunt();
}

start_woods() {
  setdvar("hud_showObjectives", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  maps\youngblood_code::woods();
}

start_neighborhood() {
  setdvar("hud_showObjectives", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  maps\youngblood_code::neighborhood();
}

start_mansion_ext() {
  setdvar("hud_showObjectives", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  maps\youngblood_code::mansion_ext();
}

start_mansion() {
  setdvar("hud_showObjectives", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  maps\youngblood_code::mansion();
}

start_chaos_a() {
  setdvar("hud_showObjectives", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  common_scripts\utility::trigger_off("start_chaos_a", "targetname");
  maps\youngblood_code::chaos_a();
}

start_chaos_b() {
  level.player setclienttriggeraudiozone("youngblood_chaos", 1.5);
  setdvar("hud_showObjectives", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  maps\youngblood_code::chaos_b();
}

start_pickup() {
  setdvar("hud_showObjectives", 0);
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 9);
  maps\youngblood_code::pickup();
}

deer_rumble_movewait() {
  wait 1.75;
  self notify("move");
}

youngblood_script_setup() {
  common_scripts\utility::array_thread(getEntArray("chaos_checkpoint", "targetname"), maps\youngblood_util::chaos_checkpoint_trigger);
  common_scripts\utility::array_thread(getEntArray("chaos_chunk_fall", "targetname"), maps\youngblood_util::chaos_chunk_fall);
  common_scripts\utility::array_thread(getEntArray("move_trigger", "targetname"), maps\youngblood_util::trigger_moveto);
  common_scripts\utility::array_thread(getEntArray("link_to_trigger", "targetname"), maps\youngblood_util::trigger_sort_and_attach);
  common_scripts\utility::array_thread(getEntArray("uphill_trigger", "targetname"), maps\youngblood_util::uphill_trigger);
  common_scripts\utility::array_thread(getEntArray("flat_trigger", "targetname"), maps\youngblood_util::flat_trigger);
  var_0 = getEntArray("fxchunknames", "targetname");

  foreach(var_2 in var_0) {
  var_2 hide();
  }

  var_4 = common_scripts\utility::get_target_ent("campfire_player_blocker");
  var_4 delete();
}

player_speed() {
  for(;;) {
    self waittill("trigger", var_0);
    var_1 = float(self.script_speed) * 0.01;
    level.player setmovespeedscale(var_1);

    while(var_0 istouching(self)) {
      wait 0.05;
    }

    level.player setmovespeedscale(1);
    wait 0.05;
  }
}

entity_counter() {
  common_scripts\utility::create_dvar("entity_counter", 1);
}

youngblood_earthquake_setup() {
  maps\_utility::add_earthquake("small_long", 0.15, 10, 2048);
  maps\_utility::add_earthquake("small_med", 0.15, 5, 2048);
  maps\_utility::add_earthquake("small_short", 0.15, 1, 2048);
  maps\_utility::add_earthquake("medium_medium", 0.25, 3, 2048);
  maps\_utility::add_earthquake("large_short", 0.45, 1, 2048);
}

set_default_mb_values() {
  setsaveddvar("r_mbEnable", 2);
  setsaveddvar("r_mbCameraRotationInfluence", 0.25);
  setsaveddvar("r_mbCameraTranslationInfluence", 0.01);
  setsaveddvar("r_mbModelVelocityScalar", 0.1);
  setsaveddvar("r_mbStaticVelocityScalar", 0.2);
  setsaveddvar("r_mbViewModelEnable", 0);
}

sprint_hint_check() {
  var_0 = getdvarint("g_speed");
  var_1 = level.player getvelocity();
  var_1 = length(var_1);
  return var_1 > var_0 || common_scripts\utility::flag("truck_landed_exit_scene");
}