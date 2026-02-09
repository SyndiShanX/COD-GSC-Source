/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\nml.gsc
*****************************************************/

main() {
  maps\_utility::template_level("nml");
  precacherumble("silencer_fire");
  maps\_utility::add_earthquake("moderate_4s", 0.5, 4, 2048);
  maps\_utility::add_earthquake("weak_3s", 0.18, 3, 2048);
  maps\_utility::add_earthquake("weak_4s", 0.15, 4, 2048);
  maps\_utility::add_earthquake("weak_15s", 0.2, 15, 2048);
  maps\_utility::add_earthquake("med_4s", 0.25, 4, 2048);
  vehicle_scripts\_tank_crush::init_tank_crush();
  maps\createart\nml_art::main();
  maps\nml_fx::main();
  maps\nml_precache::main();
  maps\_utility::intro_screen_create(&"NML_INTROSCREEN_LINE_1", &"NML_INTROSCREEN_LINE_2", &"NML_INTROSCREEN_LINE_5");
  maps\_utility::intro_screen_custom_func(::custom_intro_screen_func);
  precacheitem("remote_chopper_gunner");
  precacheitem("remote_chopper_gunner_nopullout");
  precacheitem("p226");
  precacheitem("p226_scripted_nml");
  precacherumble("subtle_tank_rumble");
  precachemodel("weapon_p226");
  precachemodel("tag_player");
  precachemodel("torpedo_crtplane");
  precachemodel("vfx_nml_church_lastframe");
  precachemodel("weapon_mts_255_small");
  precachemodel("factory_train_container_a_blue");
  precachemodel("fullbody_wolf_b");
  precachemodel("nml_geiger_counter");
  precachemodel("fullbody_dog_a_cam_obj");
  precachemodel("mil_wireless_dsm_small");
  precachemodel("viewmodel_p226");
  precacheshader("overlay_mask_edge");
  precacheshader("overlay_static");
  precacheshader("dogcam_antennae_1");
  precacheshader("dogcam_antennae_2");
  precacheshader("dogcam_antennae_3");
  precacheshader("dogcam_antennae_4");
  precacheshader("dogcam_edge");
  precacheshader("dogcam_dirt");
  precacheshader("dogcam_frame_bot");
  precacheshader("dogcam_frame_top");
  precacheshader("dogcam_bracket_l");
  precacheshader("dogcam_bracket_r");
  precacheshader("dogcam_center");
  precacheshader("dogcam_compass");
  precacheshader("dogcam_battery");
  precacheshader("dogcam_rec");
  precacheshader("dogcam_timestamp");
  precacheshader("dogcam_vision_off");
  precacheshader("dogcam_vision_on");
  precacheshader("dogcam_scanline");
  precacheshader("dogcam_targeting_circle");
  precacheshader("dogcam_target");
  precachestring(&"NML_DOGCAM_TARGETINRANGE");
  precachestring(&"NML_DOGCAM_OUTOFRANGE");
  precachestring(&"NML_DOGCAM_METERS");
  precachestring(&"NML_DOGCAM_TARGET");
  precachestring(&"NML_DOGCAM_NORTH");
  precachestring(&"NML_DOGCAM_NORTHWEST");
  precachestring(&"NML_DOGCAM_WEST");
  precachestring(&"NML_DOGCAM_SOUTHWEST");
  precachestring(&"NML_DOGCAM_SOUTH");
  precachestring(&"NML_DOGCAM_SOUTHEAST");
  precachestring(&"NML_DOGCAM_EAST");
  precachestring(&"NML_DOGCAM_NORTHEAST");
  precachestring(&"NML_OBJ_1");
  precachestring(&"NML_OBJ_2");
  precachestring(&"NML_OBJ_3");
  precachestring(&"NML_FAIL_INTEL");
  precachestring(&"NML_HINT_X");
  precachestring(&"NML_HINT_DOG_BARK");
  precachestring(&"NML_HINT_SYNC");
  precachestring(&"NML_HINT_X_KB");
  precachestring(&"NML_HINT_DOG_BARK_KB");
  precachestring(&"NML_HINT_SYNC_KB");
  precachestring(&"NML_HINT_DOG_SPRINTZOOM");
  precachestring(&"NML_HINT_DOG_SPRINT");
  precachestring(&"NML_HINT_DOG_ATTACK");
  precachestring(&"HINT_DOG_ATTACK_2");
  precachestring(&"NML_HINT_DOG_APPROACH");
  precachestring(&"NML_FAIL_SPOTTED");
  precachestring(&"NML_HINT_CAIRO_DEATH");
  precachestring(&"NML_HINT_CAIRO_DEATH_PLR");
  precachestring(&"NML_HINT_ZOOM");
  precachestring(&"NML_HINT_STEALTHKILL");
  precacheshellshock("dog_cam");
  maps\_utility_dogs::init_dog_pc("a");
  maps\_utility_dogs::init_dog_pc("a_cam_obj");
  maps\_utility_dogs::init_wolf_pc();
  maps\_utility::add_hint_string("hint_dog_sprintzoom", &"NML_HINT_DOG_SPRINTZOOM", maps\nml_util::check_dog_sprinting);
  maps\_utility::add_hint_string("hint_dog_sprint", &"NML_HINT_DOG_SPRINT", maps\nml_util::check_dog_sprinting);
  maps\_utility::add_hint_string("hint_dog_attack_cam", &"NML_HINT_DOG_ATTACK", maps\nml_util::is_dog_really_attacking);
  maps\_utility::add_hint_string("hint_dog_attack", &"NML_HINT_DOG_ATTACK", maps\nml_util::is_dog_attacking);
  maps\_utility::add_hint_string("hint_dog_attack_3p", &"NML_HINT_DOG_ATTACK_2", maps\nml_util::is_dog_attacking);
  maps\_utility::add_hint_string("hint_dog_approach", &"NML_HINT_DOG_APPROACH", maps\nml_util::check_dog_ready_to_attack);
  maps\_utility::add_hint_string("hint_bark_kb", &"NML_HINT_DOG_BARK_KB", maps\nml_util::check_player_bark);
  maps\_utility::add_hint_string("hint_bark", &"NML_HINT_DOG_BARK", maps\nml_util::check_player_bark);
  maps\_utility::add_hint_string("hint_zoom", &"NML_HINT_ZOOM", maps\nml_util::check_player_zoom);
  maps\_utility::add_hint_string("hint_stealthkill", &"NML_HINT_STEALTHKILL", undefined);
  maps\_utility::add_start("e3", ::setup_e3, undefined, undefined, "nml_trans_intro_tr");
  maps\_utility::add_start("intro", ::setup_intro, undefined, ::start_intro, "nml_trans_intro_tr");
  maps\_utility::add_start("cave", ::setup_cave, undefined, ::start_cave, "nml_trans_intro_tr");
  maps\_utility::add_start("jimmy", ::setup_jimmy, undefined, undefined, "nml_trans_intro_tr");
  maps\_utility::add_start("crater", ::setup_crater, undefined, ::start_crater, "nml_trans_intro_tr");
  maps\_utility::add_start("post_crater", ::setup_post_crater, undefined, ::start_post_crater, "nml_trans_intro_tr");
  maps\_utility::add_start("post_crater_dog", ::setup_post_crater_dog, undefined, ::start_post_crater_dog, "nml_trans_intro_tr");
  maps\_utility::add_start("post_crater_house", ::setup_post_crater_house, undefined, ::start_post_crater_house, "nml_trans_intro_tr");
  maps\_utility::add_start("satellite", ::setup_satellite, undefined, ::start_satellite, "nml_trans_intro_tr");
  maps\_utility::add_start("satellite_b", ::setup_satellite_b, undefined, ::start_satellite_b, "nml_trans_intro_tr");
  maps\_utility::add_start("tunnel", ::setup_tunnel, undefined, ::start_tunnel, "nml_trans_intro_tr");
  maps\_utility::add_start("mall", ::setup_mall, undefined, ::start_mall, "nml_trans_wolftown_tr");
  maps\_utility::add_start("dog_hunt", ::setup_dog_hunt, undefined, ::start_dog_hunt, "nml_trans_wolftown_tr");
  maps\_utility::add_start("dog_hunt2", ::setup_dog_hunt2, undefined, ::start_dog_hunt2, "nml_trans_wolftown_tr");
  maps\_utility::add_start("chase_dog", maps\nml_wolf::setup_chase_dog, undefined, maps\nml_wolf::start_chase_dog, "nml_trans_wolftown_tr");
  maps\_utility::add_start("wolfpack", maps\nml_wolf::setup_wolfpack, undefined, maps\nml_wolf::start_wolfpack, "nml_trans_wolftown_tr");
  maps\_utility::add_start("ghost_town", maps\nml_wolf::setup_ghost_town, undefined, maps\nml_wolf::start_ghost_town, "nml_trans_wolftown_tr");
  maps\_utility::set_default_start("intro");
  maps\_utility::transient_init("nml_trans_intro_tr");
  maps\_utility::transient_init("nml_trans_wolftown_tr");
  maps\nml_wolf::preload();
  level.hudoutline_maxdist = 1024;

  if(getDvar("createfx", "") == "on") {
    level.getnodefunction = ::getnode;
    level.getnodearrayfunction = ::getnodearray;
    level.struct_class_names = undefined;
    common_scripts\utility::struct_class_init();
    common_scripts\utility::array_thread(getEntArray("move_trigger", "script_noteworthy"), maps\_geo_mover::trigger_moveto);
    level.struct_class_names = undefined;
  }

  maps\_load::main();
  maps\_utility::setsaveddvar_cg_ng("r_specularColorScale", 2.5, 6);

  if(level.xenon)
    setsaveddvar("r_texFilterProbeBilinear", 1);

  if(!maps\_utility::is_gen4())
    setsaveddvar("sm_sunshadowscale", 0.65);

  if(maps\_utility::is_gen4()) {}

  maps\nml_audio::main();
  maps\nml_anim::main();
  maps\nml_wolf::main();
  maps\_dog_control::init_dog_control();
  maps\_idle::idle_main();
  maps\_idle_coffee::main();
  maps\_idle_smoke::main();
  maps\_idle_lean_smoke::main();
  maps\_idle_phone::main();
  maps\_idle_sleep::main();
  maps\_idle_sit_load_ak::main();
  maps\_idle_smoke_balcony::main();
  maps\_drone_ai::init();
  maps\_stealth::main();
  maps\_patrol_anims::main();
  maps\_patrol_anims_gundown::main();
  maps\_patrol_anims_patroljog::main();
  maps\_patrol_anims_creepwalk::main();
  maps\_radiation::main();
  maps\_dynamic_run_speed::main();
  level.global_callbacks["_spawner_stealth_default"] = maps\nml_stealth::_spawner_stealth_dog;
  maps\_player_rig::init_player_rig("viewhands_player_us_rangers");
  setsaveddvar("r_thermalColorScale", 1.75);
  common_scripts\utility::array_thread(getEntArray("script_vehicle_nh90", "classname"), maps\_vehicle::godon);
  common_scripts\utility::array_thread(getEntArray("move_up_when_clear", "targetname"), maps\nml_util::move_up_when_clear);
  common_scripts\utility::array_thread(getEntArray("move_trigger", "script_noteworthy"), maps\_geo_mover::trigger_moveto);
  common_scripts\utility::array_thread(getEntArray("earthquake_trigger", "targetname"), maps\nml_util::earthquake_trigger);
  common_scripts\utility::array_thread(getEntArray("tree_sway", "targetname"), maps\nml_util::tree_sway);
  common_scripts\utility::array_thread(getEntArray("tree_pitch", "targetname"), maps\nml_util::tree_pitch);
  common_scripts\utility::array_thread(getEntArray("ledge_entrance", "targetname"), maps\nml_util::ledge_trigger_logic);
  common_scripts\utility::array_thread(getEntArray("hero_follow_path_trig", "script_noteworthy"), maps\nml_util::hero_follow_path_trig);
  common_scripts\utility::array_thread(getEntArray("delete_trigger", "targetname"), maps\nml_util::delete_trigger);
  common_scripts\utility::array_thread(getEntArray("stealth_range_trigger", "targetname"), maps\nml_util::stealth_range_trigger);
  common_scripts\utility::array_thread(getEntArray("enable_sneak_trig", "targetname"), maps\nml_util::sneak_trig);
  common_scripts\utility::array_thread(getEntArray("disable_sneak_trig", "targetname"), maps\nml_util::sneak_trig);
  maps\_utility::array_spawn_function(getEntArray("script_vehicle_nh90", "classname"), maps\nml_util::link_linked_ents);
  maps\_utility::array_spawn_function_targetname("intro_heli", maps\nml_util::intro_heli_think);
  maps\_utility::array_spawn_function_targetname("tunnel_btrs", maps\nml_tunnel_new::tunnel_vehicle_think);
  maps\_utility::array_spawn_function_targetname("tunnel_guys_exit", maps\nml_tunnel_new::tunnel_guys_exit_think);
  maps\_utility::array_spawn_function_targetname("pc_courtyard", maps\nml_util::hud_outlineenable);
  maps\_utility::array_spawn_function_targetname("pc_house_2", maps\nml_util::hud_outlineenable);
  maps\_utility::array_spawn_function_targetname("pc_balcony", maps\nml_util::hud_outlineenable);
  maps\_utility::array_spawn_function_noteworthy("courtyard_hazmat_guy", maps\nml_code::courtyard_hazmat_guy_think);
  maps\_utility::array_spawn_function_noteworthy("mall_lone_patrol", maps\nml_code::mall_lone_patrol_think);
  maps\_utility::array_spawn_function_noteworthy("mall_grass_guys", maps\nml_util::hud_outlineenable);
  maps\_utility::array_spawn_function_noteworthy("mall_grass_guys", maps\nml_code::mall_walla_guys);
  maps\_utility::array_spawn_function_noteworthy("mall_grass_guys", maps\nml_stealth::dialog_player_kill);
  maps\_utility::array_spawn_function_noteworthy("mall_grass_guys", maps\nml_stealth::dialog_theyre_looking_for_you);
  maps\_utility::array_spawn_function_noteworthy("btr_respond_to_stealth", maps\nml_stealth::btr_stop_when_not_normal);
  maps\_utility::array_spawn_function_noteworthy("mg_off", maps\nml_stealth::btr_mg_off);
  maps\_utility::array_spawn_function_targetname("vargas_spawner", maps\nml_util::hud_outlineenable);
  maps\_utility::array_spawn_function_targetname("vargas_spawner", maps\nml_code::vargas_think);
  init_level_flags();
  maps\nml_util::spawn_dog();
  maps\nml_util::spawn_baker();
  level.player thread maps\_stealth_utility::stealth_default();
  level.player thread maps\_dog_control::enable_dog_control(level.dog);
  maps\nml_stealth::stealth_settings();
  level.force_next_earthquake = 1;
  level.slomobreachduration = 8.5;
  level.slowmo_viewhands = "viewhands_player_us_rangers";
  maps\_slowmo_breach::slowmo_breach_init();
  maps\_slowmo_breach::add_breach_func(::breach_explosion_notify);
  maps\nml_audio::nml_audio_set_time_scale_factors();
  level.dog_flush_functions["sat_camp_1"] = maps\nml_satellite_new::flush_sat_camp_1;
  level.custom_followpath_parameter_func = maps\_utility_dogs::dog_follow_path_func;
  setsaveddvar("cg_cinematicFullScreen", "0");
  setDvar("music_enable", 1);
  setsaveddvar("r_hudOutlineEnable", 1);
  thread maps\nml_util::reactive_grass_settings();
  thread delayed_setup();
  var_0 = common_scripts\utility::get_target_ent("pc_courtyard");

  if(isDefined(var_0)) {
    for(var_1 = var_0; isDefined(var_1.target); var_1 = var_1 common_scripts\utility::get_target_ent()) {}

    if(isDefined(var_1))
      var_1.origin = (4028.6, -170.6, -191.7);
  }

  setDvar("jimmy", 0);
  thread sat_crane();
  thread mall_crane();
  thread objectives();
  level.global_callbacks["_autosave_stealthcheck"] = maps\nml_stealth::_autosave_stealthcheck_nml;

  if(maps\_utility::is_gen4()) {
    setsaveddvar("fx_alphathreshold", 8);
    setsaveddvar("r_thermalColorOffset", 0.26);
  } else
    setsaveddvar("fx_alphathreshold", 10);

  maps\_utility::add_extra_autosave_check("radiation_check", ::radiation_check, "player inside radiation");
  var_2 = "dog bodyfall small";
  var_3 = "J_Spine4";
  var_4 = "bodyfall_";
  var_5 = "_small";
  animscripts\utility::setnotetrackeffect(var_2, var_3, "dirt", loadfx("fx/impacts/bodyfall_default_large_runner"), var_4, var_5);
  animscripts\utility::setnotetrackeffect(var_2, var_3, "concrete", loadfx("fx/impacts/bodyfall_default_large_runner"), var_4, var_5);
  animscripts\utility::setnotetrackeffect(var_2, var_3, "asphalt", loadfx("fx/impacts/bodyfall_default_large_runner"), var_4, var_5);
  animscripts\utility::setnotetrackeffect(var_2, var_3, "rock", loadfx("fx/impacts/bodyfall_default_large_runner"), var_4, var_5);
  var_6 = ["brick", "carpet", "foliage", "grass", "gravel", "ice", "metal", "painted metal", "mud", "plaster", "sand", "snow", "slush", "water", "wood", "ceramic"];

  foreach(var_8 in var_6)
  animscripts\utility::setnotetracksound(var_2, var_8, var_4, var_5);

  var_2 = "dog bodyfall small";
  var_3 = "J_Spine4";
  var_4 = "bodyfall_";
  var_5 = "_large";
  animscripts\utility::setnotetrackeffect(var_2, var_3, "dirt", loadfx("fx/impacts/bodyfall_default_large_runner"), var_4, var_5);
  animscripts\utility::setnotetrackeffect(var_2, var_3, "concrete", loadfx("fx/impacts/bodyfall_default_large_runner"), var_4, var_5);
  animscripts\utility::setnotetrackeffect(var_2, var_3, "asphalt", loadfx("fx/impacts/bodyfall_default_large_runner"), var_4, var_5);
  animscripts\utility::setnotetrackeffect(var_2, var_3, "rock", loadfx("fx/impacts/bodyfall_default_large_runner"), var_4, var_5);

  foreach(var_8 in var_6)
  animscripts\utility::setnotetracksound(var_2, var_8, var_4, var_5);

  thread track_riley_kills();
}

objectives() {
  common_scripts\utility::flag_wait("intro_clear");
  wait 3;
  objective_add(maps\_utility::obj("1"), "current", &"NML_OBJ_1");
  wait 2;
  objective_add(maps\_utility::obj("2"), "active", &"NML_OBJ_2");
  common_scripts\utility::flag_wait("wolf_start_chase_dog");
  objective_state(maps\_utility::obj("1"), "done");
  objective_current(maps\_utility::obj("2"));
  common_scripts\utility::flag_wait("merrick_scene_done");
  objective_state(maps\_utility::obj("2"), "done");
  wait 3;
  objective_add(maps\_utility::obj("3"), "current", &"NML_OBJ_3");
  common_scripts\utility::flag_wait("the_end");
  objective_state(maps\_utility::obj("3"), "done");
}

sat_crane() {
  var_0 = common_scripts\utility::get_target_ent("sat_crane");
  var_0.animname = "crane";
  var_0 maps\_anim::setanimtree();
  var_1 = common_scripts\utility::spawn_tag_origin();
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  var_1 thread maps\_anim::anim_loop([var_0], "sat_crane_hold_up");
}

mall_crane() {
  var_0 = common_scripts\utility::get_target_ent("mall_crane");
  var_0.animname = "crane";
  var_0 maps\_anim::setanimtree();
  var_1 = maps\_utility::spawn_anim_model("crate");
  var_2 = common_scripts\utility::get_target_ent("sat_crate");
  var_3 = var_2 common_scripts\utility::get_linked_ent();
  var_1.origin = var_2.origin;
  var_1.angles = var_2.angles;
  var_3 linkto(var_1);
  var_2 linkto(var_1);
  var_4 = common_scripts\utility::spawn_tag_origin();
  var_4.origin = var_0.origin;
  var_4.angles = var_0.angles;
  var_4 thread maps\_anim::anim_loop([var_0, var_1], "mall_crane_idle");
  common_scripts\utility::flag_wait("mall_inside_2");
  wait 3;
  var_3 thread bm_kill_dog();
  var_4 notify("stop_loop");
  var_4 maps\_anim::anim_single([var_0, var_1], "mall_crane_move");
  var_3 notify("dropped");
  common_scripts\utility::flag_wait("varges_heli_leave");
  wait 4;
  var_4 maps\_anim::anim_single([var_0], "mall_crane_move_out");
  var_4 thread maps\_anim::anim_loop([var_0], "mall_crane_idle_out");
}

bm_kill_dog() {
  level.dog endon("death");
  self endon("dropped");

  for(;;) {
    common_scripts\utility::waitframe();

    if(level.dog istouching(self)) {
      level.dog kill();
      break;
    }
  }
}

delayed_setup() {
  wait 0.1;
  level.dog.idlelookattargets = [level.player];
  var_0 = common_scripts\utility::get_target_ent("pc_breach_lighttarget");
  var_1 = getEntArray("pc_house_door", "targetname");

  foreach(var_3 in var_1) {
    var_3 retargetscriptmodellighting(var_0);
    var_3 moveto(var_3.origin - (0, 0, -0.01), 1);
  }

  var_0 = getent("church_cliff", "targetname");
  var_5 = getent("church_light_target", "targetname");
  var_0 retargetscriptmodellighting(var_5);
  var_0 moveto(var_0.origin - (0, 0, -0.01), 1);
}

breach_explosion_notify(var_0) {
  level notify("breach_explosion");
}

custom_intro_screen_func() {
  common_scripts\utility::flag_wait("intro_clear");
  wait 8;
  maps\_introscreen::introscreen(1);
}

init_level_flags() {
  common_scripts\utility::flag_init("test");
  common_scripts\utility::flag_init("intro_clear");
  common_scripts\utility::flag_init("intro_gunup");
  common_scripts\utility::flag_init("intro_dog_attacked");
  common_scripts\utility::flag_init("intro_guys_close");
  common_scripts\utility::flag_init("start_intro");
  common_scripts\utility::flag_init("start_post_crater_dog");
  common_scripts\utility::flag_init("start_earthquakes");
  common_scripts\utility::flag_init("start_dog_hunt");
  common_scripts\utility::flag_init("start_post_crater_house");
  common_scripts\utility::flag_init("start_sat_combat");
  common_scripts\utility::flag_init("hesh_mansion_jumpdown");
  common_scripts\utility::flag_init("hesh_mansion_jumpdown_done");
  common_scripts\utility::flag_init("hesh_ready_to_leave_cave");
  common_scripts\utility::flag_init("cave_hesh_done");
  common_scripts\utility::flag_init("house_cqb_done");
  common_scripts\utility::flag_init("baker_cliff_middle");
  common_scripts\utility::flag_init("baker_cliff_done");
  common_scripts\utility::flag_init("crater_scared_done");
  common_scripts\utility::flag_init("pc_guy_1_dead");
  common_scripts\utility::flag_init("pc_guy_2_dead");
  common_scripts\utility::flag_init("pc_sniper_dead");
  common_scripts\utility::flag_init("pc_dogdrive_courtyard");
  common_scripts\utility::flag_init("player_knows_how_to_bark");
  common_scripts\utility::flag_init("post_crater_1_clear");
  common_scripts\utility::flag_init("post_crater_take_out_bottom");
  common_scripts\utility::flag_init("baker_sees_satellite");
  common_scripts\utility::flag_init("someone_became_alert");
  common_scripts\utility::flag_init("sat_got_spotted");
  common_scripts\utility::flag_init("tunnel_tank_crush_done");
  common_scripts\utility::flag_init("tunnel_exit_clear");
  common_scripts\utility::flag_init("tunnel_exit");
  common_scripts\utility::flag_init("mall_lone_patrol_dead");
  common_scripts\utility::flag_init("mall_player_ready_to_leave");
  common_scripts\utility::flag_init("player_looking_at_vargas");
  common_scripts\utility::flag_init("baker_started_slide");
  common_scripts\utility::flag_init("skip_house_cqb");
  common_scripts\utility::flag_init("skip_church_walk");
  common_scripts\utility::flag_init("skip_cave_cqb");
  common_scripts\utility::flag_init("mall_guy_died_by_dog");
}

setup_e3() {
  common_scripts\utility::flag_set("start_intro");
  maps\nml_util::set_start_positions("start_intro");
  setDvar("e3", "1");
  level.baker.name = "";
  level.dog.name = "";
}

setup_intro() {
  common_scripts\utility::flag_set("start_intro");
  maps\nml_util::set_start_positions("start_intro");
  setDvar("e3", "0");
}

setup_cave() {
  maps\nml_util::set_start_positions("start_cave");
  common_scripts\utility::flag_set("cave_hesh_done");
  common_scripts\utility::flag_set("hesh_ready_to_leave_cave");
}

setup_crater() {
  maps\nml_util::set_start_positions("start_crater");
  common_scripts\utility::flag_set("house_cqb_done");
  maps\_art::sunflare_changes("nml_house", 0);
}

setup_jimmy() {
  maps\nml_util::set_start_positions("start_crater");
  common_scripts\utility::flag_set("house_cqb_done");
  maps\_art::sunflare_changes("nml_house", 0);
  thread jimmy_fade();
}

jimmy_fade() {
  maps\_hud_util::fade_out(0);
  maps\_utility::music_play("mus_nml_travel");
  level.player disableweapons();
  wait 3;
  setDvar("jimmy", 1);
  maps\_hud_util::fade_in(2);
  common_scripts\utility::flag_wait("hesh_mansion_jumpdown");
  wait 3;
  level.player enableweapons();
}

setup_post_crater() {
  maps\nml_util::set_start_positions("start_post_crater");
  common_scripts\utility::flag_set("baker_cliff_done");
  common_scripts\utility::flag_set("crater_scared_done");
  common_scripts\utility::flag_set("start_post_crater");
}

setup_post_crater_dog() {
  maps\nml_util::set_start_positions("start_post_crater_dog");
  common_scripts\utility::flag_set("start_post_crater_dog");
  level.baker.goalradius = 32;
}

setup_post_crater_house() {
  maps\nml_util::set_start_positions("start_post_crater_house");
  common_scripts\utility::flag_set("start_post_crater_house");
}

setup_satellite() {
  maps\nml_util::set_start_positions("start_satellite");
  maps\nml_util::team_unset_colors(196);
  maps\nml_util::hero_paths_cairo_first("sat_entrance_path");
}

setup_satellite_b() {
  maps\nml_util::set_start_positions("start_satellite_b");
  maps\nml_util::team_unset_colors(196);
  maps\_utility::delaythread(0.2, maps\nml_stealth::disable_stealth);
}

setup_tunnel() {
  maps\nml_util::set_start_positions("start_tunnel");
  maps\_utility::delaythread(0.2, maps\nml_stealth::disable_stealth);
  level.player giveweapon("fraggrenade");
  level.player givemaxammo("fraggrenade");
}

setup_mall() {
  maps\nml_util::set_start_positions("start_mall");
  maps\nml_util::hero_paths("mall_start_path", 300, 300, 200, 0, 1);
}

setup_dog_hunt() {
  maps\nml_util::set_start_positions("start_dog_hunt");
  common_scripts\utility::flag_set("start_dog_hunt");
  common_scripts\utility::flag_set("intro_clear");
  level.dog.ignoreme = 0;
}

setup_dog_hunt2() {
  maps\nml_util::set_start_positions("start_dog_hunt2");
  thread maps\nml_code::player_drive_dog();
  common_scripts\utility::flag_set("start_dog_hunt");
  level.dog.ignoreme = 0;
  thread maps\nml_code::dog_hunt_spotted();
  thread dog_hunt2_delete();
}

dog_hunt2_delete() {
  level.dog.ignoreme = 1;
  wait 1;
  var_0 = getaiarray("axis");

  foreach(var_2 in var_0) {
    if(distance(var_2.origin, level.dog.origin) < 300)
      var_2 delete();
  }

  level.dog.ignoreme = 0;
}

testing_outline() {
  for(;;) {
    wait 1;
    var_0 = getaispeciesarray();

    foreach(var_2 in var_0) {
      if(isDefined(var_2.outline_tech)) {
        continue;
      }
      var_2.outline_tech = 1;
      var_2 hudoutlineenable(0, 0);
    }
  }
}

start_intro() {
  common_scripts\utility::flag_wait("start_intro");
  level.dog.pathrandompercent = 0;
  level.baker.pathrandompercent = 0;
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  thread maps\nml_code::opening_shot();
}

start_cave() {
  thread maps\nml_code::house_deer();
  common_scripts\utility::flag_wait("cave_exit");
  setnorthyaw(223.8);
  maps\_utility::autosave_by_name("nml");
  setsaveddvar("ai_friendlyFireBlockDuration", 0);
  thread maps\nml_code::cave_exit();
  thread maps\nml_code::cave_exit_dialogue();
  thread maps\nml_code::mansion_sound_on_helis();
  thread maps\nml_code::house_enter();
}

start_crater() {
  wait 0.5;
  thread maps\nml_code::mansion_exit();
  thread maps\nml_code::hesh_crater_look();
  common_scripts\utility::flag_wait("start_crater");
  common_scripts\utility::flag_set("skip_house_cqb");
  level.dog maps\nml_util::dyn_dogspeed_disable();
  level notify("start_birds_crater");
  thread maps\nml_code::church_collapse();
  common_scripts\utility::flag_wait("hesh_mansion_jumpdown_done");
  thread maps\nml_code::crater_ledge_walk();
  wait 0.1;
  maps\_utility::autosave_by_name("nml");
  common_scripts\utility::flag_wait("start_post_crater");
  level.baker maps\nml_util::switch_from_creepwalk_to_cqb();
}

start_post_crater() {
  common_scripts\utility::flag_wait("start_post_crater");
  thread maps\nml_code::post_crater_dog_setup();
}

start_post_crater_dog() {
  common_scripts\utility::flag_wait("start_post_crater_dog");
  setnorthyaw(223.8);
  maps\nml_util::load_hazmat_guns("weapon_pickup_pc");
  level.baker maps\_utility::forceuseweapon("l115a3+scopel115a3_sp+silencerl115a3_sp", "primary");
  thread maps\nml_util::reactive_grass_settings_pc();
  thread maps\nml_code::player_drive_dog_pc();
  thread maps\nml_code::pc_dog_drive_enemies();
  thread maps\nml_code::pc_dog_drive_spotted();
  thread maps\nml_code::pc_dog_drive_end();
}

start_post_crater_house() {
  common_scripts\utility::flag_wait("start_post_crater_house");
  maps\nml_util::delete_hazmat_guns();
  level.baker maps\_utility::forceuseweapon("honeybadger+reflex_sp", "primary");
  level.dog.idlelookattargets = [level.player];
  thread maps\nml_code::post_crater_end();
}

start_satellite() {
  common_scripts\utility::flag_wait("start_satellite");
  level.dog maps\_utility::ent_flag_clear("pause_dog_command");
  level.dog.idlelookattargets = undefined;
  level notify("stop_birds_crater");

  if(getdvarint("e3", 0)) {
    return;
  }
  maps\_utility::autosave_by_name("nml");
  level.dog_alt_melee_func = undefined;
  maps\_utility_dogs::init_dog_anims();
  level.dog maps\nml_util::set_move_rate(0.65);
  thread maps\nml_code::nh90_unload();
  thread maps\nml_code::sat_combat();
}

start_satellite_b() {
  common_scripts\utility::flag_wait("satellite_slide");
  thread maps\nml_code::tunnel_slide();
  thread maps\nml_code::transition_to_tunnel();
  wait 0.5;
}

start_tunnel() {
  common_scripts\utility::flag_wait("start_tunnel");
  level.baker.old_grenadeawareness = level.baker.grenadeawareness;
  level.baker.old_badplaceawareness = level.baker.badplaceawareness;
  level.baker.grenadeawareness = 0;
  level.baker.badplaceawareness = 0;
  level.dog maps\_utility::ent_flag_set("pause_dog_command");
  common_scripts\utility::flag_set("tunnel_exit_clear");
  var_0 = getaiarray("axis");
  common_scripts\utility::array_call(var_0, ::delete);
  var_1 = maps\_utility::getvehiclearray();
  common_scripts\utility::array_call(var_1, ::delete);
  maps\nml_stealth::reenable_stealth();
  maps\_stealth_utility::stealth_detect_ranges_default();
  common_scripts\utility::flag_clear("_stealth_spotted");
  maps\_utility::transient_switch("nml_trans_intro_tr", "nml_trans_wolftown_tr");
  thread maps\nml_tunnel_new::tunnel_new();
  wait 0.1;
  thread maps\nml_util::mission_fail_on_dog_death();
  common_scripts\utility::flag_wait("nml_trans_wolftown_tr_loaded");
  wait 0.1;
  maps\_utility::autosave_by_name("nml");
}

start_mall() {
  common_scripts\utility::flag_wait("start_mall");
  common_scripts\utility::flag_set("tunnel_exit_clear");
  level.dog maps\_utility::ent_flag_set("dog_no_teleport");
  common_scripts\utility::flag_waitopen("_stealth_spotted");
  level.dog maps\_utility::ent_flag_clear("pause_dog_command");
  thread maps\nml_util::mission_fail_on_dog_death();
  maps\_stealth_utility::stealth_detect_ranges_default();
  maps\nml_stealth::stealth_settings_tunnel();
  maps\nml_util::team_unset_colors(96);
  thread maps\nml_code::mall_sniper();
  thread maps\nml_code::mall_heli();
  thread maps\nml_code::mall_blockade();
  thread maps\nml_code::mall_spotted();
  wait 0.1;
}

start_dog_hunt() {
  common_scripts\utility::flag_wait("start_dog_hunt");

  if(isDefined(level.baker.old_grenadeawareness)) {
    level.baker.grenadeawareness = level.baker.old_grenadeawareness;
    level.baker.badplaceawareness = level.baker.old_badplaceawareness;
  }

  level.dog maps\_utility::ent_flag_clear("dog_no_teleport");
  level.hudoutline_maxdist = 700;
  thread maps\nml_code::player_drive_dog();
  thread maps\nml_code::mall_dialogue();
  thread maps\nml_code::dog_hunt_spotted();
}

start_dog_hunt2() {
  common_scripts\utility::flag_wait("mall_second_spawn");
  level.hudoutline_maxdist = 700;
  maps\_utility::autosave_stealth();
  maps\nml_util::spawn_adam();
  maps\nml_util::team_unset_colors(32);
  level.baker.ignoreall = 1;
  level.adam.ignoreall = 1;
  level.baker allowedstances("crouch");
  level.adam allowedstances("crouch");
  thread maps\nml_code::mall_inside();
  thread maps\nml_code::mall_dialogue_2();
  thread maps\nml_code::mall_exit();
  thread maps\nml_code::mall_blockers();
}

radiation_check() {
  return !level.player.radiation.inside && !level.player.radiation.super_dose && !level.player maps\_utility::ent_flag("_radiation_poisoning");
}

set_default_mb_values() {
  setsaveddvar("r_mbEnable", 2);
  setsaveddvar("r_mbCameraRotationInfluence", 0.25);
  setsaveddvar("r_mbCameraTranslationInfluence", 0.01);
  setsaveddvar("r_mbModelVelocityScalar", 0.7);
  setsaveddvar("r_mbStaticVelocityScalar", 0.2);
  setsaveddvar("r_mbViewModelEnable", 0);
}

track_riley_kills() {
  level.dog endon("death");
  var_0 = 0;

  for(;;) {
    level waittill("dog_attacks_ai", var_1, var_2);

    if(var_1 == level.dog) {
      if(isDefined(var_1.controlling_dog) && var_1.controlling_dog) {
        var_0 = var_0 + 1;

        if(var_0 >= 10) {
          level.player maps\_utility::player_giveachievement_wrapper("LEVEL_3A");
          return;
        }
      }
    }
  }
}