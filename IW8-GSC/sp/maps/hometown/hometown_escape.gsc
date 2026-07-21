/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\hometown\hometown_escape.gsc
************************************************/

gas_main() {
  thread scripts\sp\maps\hometown\hometown_util.gsc::transient_unload_boss();
  gas_main_setup();
  thread audio_fire_loop_start();
  scripts\engine\sp\utility::enable_trigger_with_noteworthy("house_door_approach_trigger");
  scripts\engine\sp\utility::enable_trigger_with_noteworthy("road_cross_trigger");
  scripts\engine\sp\utility::enable_trigger_with_noteworthy("road_cross_mid_trigger");
  scripts\engine\utility::exploder("gas_cam_01");
  level.hadir_ai thread scripts\sp\maps\hometown\hometown_util.gsc::stayahead_turbo_check();
  level.hadir_ai pushplayer(1);
  thread scripts\sp\maps\hometown\hometown_vo.gsc::gas_start_vo();
  var_0 = scripts\engine\sp\utility::spawn_anim_model("Bottle_tunnel", level.playground_anim_node.origin, level.playground_anim_node.angles);
  level.playground_anim_node scripts\common\anim::anim_first_frame_solo(var_0, "hadir_tunnel_crawl");
  thread scripts\sp\analytics::analytics_kleenex_update("Gas Start to Poppies Start");
  waitframe();
  level.player allowprone(1);
  level.player allowcrouch(1);
  level.player allowstand(1);
  thread gas_start_execution();
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_gas_start_execution();
  var_1 = getnode("mid_road_gas_node", "script_noteworthy");
  level.hadir_ai setgoalnode(var_1);
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  scripts\engine\utility::flag_wait("road_cross_mid_flag");

  while(!level.hadir_ready_to_cross_street)
    waitframe();

  level.hadir_ai scripts\engine\sp\utility::disable_ai_color();
  level.playground_anim_node scripts\sp\anim::anim_reach_solo(level.hadir_ai, "hadir_to_tunnel");
  level.playground_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "hadir_to_tunnel");
  level.playground_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "hadir_tunnel_idle", "hadir_loop_stop");
  scripts\engine\utility::flag_wait("playground_pre_flag");
  level.playground_anim_node notify("hadir_loop_stop");
  thread hadir_move_speed_gas_start(1);
  thread audio_music_streets_fade_out();
  setsaveddvar("LROTTMQLQO", 30);
  setsaveddvar("MPOOMRMSML", 20);
  level.gas_crawl_start_blocker scripts\engine\utility::delaycall(4.0, ::delete);
  level.playground_anim_node thread scripts\common\anim::anim_single_solo(level.pipe_dying_boy, "hadir_tunnel_crawl");
  level.playground_anim_node thread scripts\common\anim::anim_single_solo(var_0, "hadir_tunnel_crawl");
  level.playground_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "hadir_tunnel_crawl");
  level.playground_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "hadir_body_moment", "hadir_loop_stop");
  level.playground_anim_node thread scripts\common\anim::anim_loop_solo(level.pipe_dying_boy, "boy_dead_idle");
  scripts\engine\utility::flag_wait("playground_pipe_exit_flag");
  level notify("playground_pipe_exit_vo");
  level.playground_anim_node notify("hadir_loop_stop");

  if(scripts\sp\autosave::autosavethreatcheck(1))
    thread scripts\engine\sp\utility::autosave_by_name("pipe_exit");

  level.gas_crawl_end_blocker scripts\engine\utility::delaycall(getanimlength(level.scr_anim["hadir"]["hadir_run_gate"]) - 3.0, ::delete);
  level.playground_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "hadir_run_gate");
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  scripts\engine\utility::flag_wait("playground_mid_flag");
  setsaveddvar("LROTTMQLQO", 60);
  setsaveddvar("MPOOMRMSML", 50);
  level.playground_anim_node scripts\sp\anim::anim_reach_solo(level.hadir_ai, "hadir_gate_enter");
  level.playground_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "hadir_gate_enter");
  level.playground_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "hadir_gate_idle", "hadir_loop_stop");
  scripts\engine\utility::flag_wait("playground_gate_flag");
  level.playground_anim_node notify("hadir_loop_stop");

  if(scripts\sp\autosave::autosavethreatcheck(1))
    thread scripts\engine\sp\utility::autosave_by_name("playground_exit");
}

audio_music_streets_fade_out() {
  setmusicstate("mx_hometown_14_escape_gas_kid");
}

audio_fire_loop_start() {
  level.fire_sfx_org = spawn("script_origin", (2453, -2286, 38));
  level.fire_sfx_org playLoopSound("emt_fire_small_lp_hwy");
}

hadir_beckon_loop() {
  self endon("death");
  level endon("stop_hadir_gesture_loop");
  var_0 = ["beckon", "look"];
  var_1 = ["beckon", "look", "cough"];
  level.kill_hadir_gesture_loop = 0;
  level.hadir_in_gas = 0;
  var_2 = [];
  var_2[var_2.size] = "dx_vom_had_poppies_start_cough_10";
  var_2[var_2.size] = "dx_vom_had_poppies_start_cough_20";
  var_2[var_2.size] = "dx_vom_had_poppies_start_fields_43";
  var_2 = scripts\engine\sp\utility::create_deck(var_2);
  waitframe();
  thread hadir_beckon_loop_suspend();

  for(;;) {
    var_3 = level.hadir_ai scripts\engine\utility::waittill_notify_or_timeout_return("started_nag", 8);

    if(!level.kill_hadir_gesture_loop) {
      if(var_3 == "started_nag") {
        level.hadir_ai scripts\asm\gesture::ai_request_gesture("beckon", level.player, 500);
        continue;
      }

      if(level.hadir_in_gas) {
        level.hadir_ai scripts\asm\gesture::ai_request_gesture(scripts\engine\utility::random(var_0), level.player, 10000);
        continue;
      }

      var_4 = scripts\engine\utility::random(var_1);

      if(var_4 == "cough") {
        var_5 = var_2 scripts\engine\sp\utility::deck_draw();
        thread gesture_on_start_cough(var_5);
        level.hadir_ai scripts\sp\maps\hometown\hometown_vo_util.gsc::say(var_5);
      } else
        level.hadir_ai scripts\asm\gesture::ai_request_gesture(var_4, level.player, 10000);
    }
  }
}

gesture_on_start_cough(var_0) {
  level.hadir_ai waittillmatch("started_speaking", var_0);
  level.hadir_ai scripts\asm\gesture::ai_request_gesture("cough", level.player);
}

hadir_beckon_loop_suspend() {
  level endon("stop_hadir_gesture_loop");

  for(;;) {
    level waittill("hadir_beckon_loop_suspend");
    level.kill_hadir_gesture_loop = 1;
    level waittill("hadir_beckon_loop_restart");
    level.kill_hadir_gesture_loop = 0;
  }
}

gas_main_setup(var_0) {
  level.playground_anim_node = scripts\engine\utility::getStruct("playground_exit_anim_node", "script_noteworthy");
  level.special_autosavecondition = ::gas_can_save;
  level.player setsuit("iw8_kid_slow_sprint");
  thread hadir_objective_icon();
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_gas_start();
  thread gas_trigger_monitor();
  thread gas_mid_trigger_monitor();
  thread gas_exit_trigger_monitor();
  thread hadir_beckon_loop();
  thread gas_blockers();
  thread scripts\sp\maps\hometown\hometown_util.gsc::force_ai_see_player_car_flank();
  setsaveddvar("OLMLOTTLRM", 1.0);
  level.player takeallweapons();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  scripts\engine\sp\utility::array_spawn_function_noteworthy("russian_gas_blocker", scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("russian_gas_patrol", scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  level.russian_gas_blocker_array = scripts\engine\sp\utility::array_spawn_noteworthy("russian_gas_blocker", 1);
  level.russian_gas_patrol_array = scripts\engine\sp\utility::array_spawn_noteworthy("russian_gas_patrol", 1);
  var_1 = getspawner("russian_gas_start", "script_noteworthy");
  var_1 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  level.gas_start_soldier = var_1 scripts\engine\sp\utility::spawn_ai(1);
  level.gas_start_soldier.animname = "gas_start_soldier";
  level.gas_start_soldier.goalradius = 32;
  level.player scripts\engine\utility::ent_flag_clear("stealth_use_real_lighting");
  level.stealth.detect.range["hidden"]["prone"] = 50;
  level.stealth.detect.range["hidden"]["crouch"] = 100;
  level.stealth.detect.range["hidden"]["stand"] = 200;
  thread gas_victims();
  thread mass_execution_a();
  thread mass_execution_b();
  thread single_execution_a();
  thread single_execution_b();
  level.alley_grab_anim_node = scripts\engine\utility::getStruct("alley_grab_node", "script_noteworthy");
  level.alley_grab_guy_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("alley_grab_guy", level.alley_grab_anim_node, 1);
  level.alley_grab_anim_node scripts\common\anim::anim_first_frame_solo(level.alley_grab_guy_model, "alley_grab_scene");
  scripts\engine\utility::flag_set("objective_escape_the_gas");
  thread hadir_move_speed_gas_start(var_0);
  level.pipe_dying_boy = scripts\engine\sp\utility::spawn_anim_model("pipe_dying_boy", level.playground_anim_node.origin, level.playground_anim_node.angles);
  level.pipe_dying_boy.fakeactor_face_anim = 1;
  level.pipe_dying_boy.animationarchetype = "soldier";
  level.pipe_dying_boy attach("head_sc_m_naficy_civ_dust");
  level.playground_anim_node thread scripts\common\anim::anim_first_frame_solo(level.pipe_dying_boy, "hadir_tunnel_crawl");
  var_2 = scripts\engine\sp\utility::spawn_anim_model("dead_dog_playground", level.playground_anim_node.origin, level.playground_anim_node.angles);
  var_2 scriptmoverdistancefade();
  level.playground_anim_node thread scripts\common\anim::anim_loop_solo(var_2, "dog_dead_idle");
  waitframe();
  scripts\sp\player\youngfarrah::setplayerviewmodel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel(), undefined, "viewmodel_farah_child_shadowcaster");
  level.hadir_in_gas = 1;
  var_3 = getspawner("russian_shooter_1", "script_noteworthy");
  var_3.count = 1;
  level.russian_shooter_1_ai = var_3 scripts\engine\sp\utility::spawn_ai(1);
  var_4 = getspawner("russian_shooter_2", "script_noteworthy");
  var_4.count = 1;
  level.russian_shooter_2_ai = var_4 scripts\engine\sp\utility::spawn_ai(1);
  var_5 = getspawner("russian_shooter_3", "script_noteworthy");
  var_5.count = 1;
  level.russian_shooter_3_ai = var_5 scripts\engine\sp\utility::spawn_ai(1);
  var_6 = getspawner("russian_shooter_4", "script_noteworthy");
  var_6.count = 1;
  level.russian_shooter_4_ai = var_6 scripts\engine\sp\utility::spawn_ai(1);
}

hadir_objective_icon() {
  level endon("remove_blocker");
  level.hadir_icon_showing = 0;

  for(;;) {
    if(getomnvar("ui_show_objectives") && !level.hadir_icon_showing) {
      var_0 = level.hadir_ai getentitynumber();
      setomnvar("ui_hadir_entnum", var_0);
      level.hadir_icon_showing = 1;

      while(getomnvar("ui_show_objectives"))
        waitframe();
    } else {
      setomnvar("ui_hadir_entnum", -1);
      level.hadir_icon_showing = 0;
    }

    waitframe();
  }
}

gas_blockers() {
  level.gas_alley_hadir_blocker = getEnt("gas_alley_hadir_blocker", "script_noteworthy");
  level.gas_window_blocker = getEnt("gas_window_blocker", "script_noteworthy");
  level.gas_alley_start_blocker = getEnt("gas_alley_start_blocker", "script_noteworthy");
  level.gas_crawl_end_blocker = getEnt("gas_crawl_end_blocker", "script_noteworthy");
  level.gas_crawl_start_blocker = getEnt("gas_crawl_start_blocker", "script_noteworthy");
  level.gas_alley_hadir_blocker delete();
}

gas_trigger_monitor() {
  scripts\engine\sp\utility::trigger_wait("road_cross_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("road_cross_flag");
  scripts\engine\sp\utility::trigger_wait("road_cross_mid_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("road_cross_mid_flag");
  scripts\engine\sp\utility::trigger_wait("playground_pre_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("playground_pre_flag");
  scripts\engine\sp\utility::trigger_wait("playground_pipe_exit_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("playground_pipe_exit_flag");
  scripts\engine\sp\utility::trigger_wait("playground_mid_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("playground_mid_flag");
  scripts\engine\sp\utility::trigger_wait("playground_gate_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("playground_gate_flag");
}

gas_mid_trigger_monitor() {
  scripts\engine\sp\utility::trigger_wait("cars_street_start_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("cars_street_start_flag");
  scripts\engine\sp\utility::trigger_wait("cars_flank_mid_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("cars_flank_mid_flag");
}

gas_exit_trigger_monitor() {
  scripts\engine\sp\utility::trigger_wait("town_exit_gate_start_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("town_exit_gate_start_flag");
  scripts\engine\sp\utility::trigger_wait("town_exit_alley_mid_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("town_exit_alley_mid_flag");
  scripts\engine\sp\utility::trigger_wait("gas_last_building_enter_pre", "script_noteworthy");
  scripts\engine\utility::flag_set("gas_last_building_enter_pre_flag");
  scripts\engine\sp\utility::trigger_wait("gas_last_building_enter", "script_noteworthy");
  scripts\engine\utility::flag_set("gas_last_building_enter_flag");
  scripts\engine\sp\utility::trigger_wait("village_exit_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("village_exit_flag");
}

gas_can_save() {
  foreach(var_1 in getaiarray("axis")) {
    if(isDefined(var_1.stealth) && !var_1[[var_1.fnisinstealthidle]]())
      return 0;
  }

  return 1;
}

gas_mid_main() {
  scripts\engine\utility::flag_set("straggler_start");
  waitframe();
  thread scripts\sp\maps\hometown\hometown_util.gsc::transient_load_poppies();
  level.hadir_ai scripts\engine\sp\utility::disable_ai_color();
  level.hadir_ai hadir_stayahead_pause_when_enabled();
  level.hadir_ai thread scripts\sp\spawner::go_to_node(getnode("post_playground_gate_node", "script_noteworthy"));
  thread scripts\sp\maps\hometown\hometown_vo.gsc::gas_mid_start_vo();
  thread flashing_lights_decho_loop();
  level.playground_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "hadir_gate_exit");
  level.hadir_ai scripts\engine\utility::set_movement_speed(120);
  level.hadir_ai aisettargetspeed(120);
  scripts\engine\utility::flag_wait("cars_street_start_flag");
  scripts\engine\utility::flag_wait("safe_for_hadir_to_progress");
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  level.hadir_ai scripts\sp\utility::stayahead_pause(0);
}

hadir_stayahead_pause_when_enabled() {
  self endon("death");

  while(!scripts\engine\utility::ent_flag_exist("stayahead_pause"))
    waitframe();

  scripts\sp\utility::stayahead_pause(1);
}

flashing_lights_decho_loop() {
  var_0 = getscriptablearray("flashing_lights_decho", "script_noteworthy");

  foreach(var_2 in var_0) {
    var_2 setscriptablepartstate("car_alarm", "hazards_only");
    var_2 setscriptablepartstate("door_front_left", "door_front_left_dmg");
    var_2 setscriptablepartstate("door_back_left", "door_back_left_dmg");
  }
}

alley_grab_mask_line() {
  for(;;) {
    thread scripts\engine\sp\utility::draw_line_to_ent_for_time(level.player.origin, level.alley_grab_mask_model, 0, 0, 0, 0.1);
    wait 0.1;
  }
}

gas_mask_swap() {
  wait 3.0;
  level.hadir_ai detach("hat_child_hadir_gas_mask");
  level.alley_grab_mask_model show();
  wait 5.75;
  earthquake(0.3, 0.2, level.hadir_ai.origin, 250);
  level.hadir_ai playRumbleOnEntity("light_1s");
}

gas_exit_main() {
  thread scripts\sp\maps\hometown\hometown_vo.gsc::gas_exit_start_vo();
  var_0 = scripts\engine\utility::getStruct("poppies_enter_anim_node", "script_noteworthy");
  var_1 = scripts\engine\sp\utility::spawn_anim_model("Hole_enter_hadir_L_curtain", var_0.origin, var_0.angles);
  var_2 = scripts\engine\sp\utility::spawn_anim_model("Hole_enter_hadir_R_curtain", var_0.origin, var_0.angles);
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_1, "Hole_enter_hadir");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_2, "Hole_enter_hadir");
  scripts\engine\utility::flag_wait("town_exit_gate_start_flag");
  scripts\sp\utility::nvidiaansel_overridecollisionradius(10.0);
  level.hadir_ai.anglelerprate = 20;
  level.alley_grab_anim_node scripts\sp\anim::anim_reach_and_arrive(level.hadir_ai, "alley_grab_scene_enter", undefined, "exposed");
  level.hadir_ai scripts\sp\utility::disable_stayahead(120, 0);
  level.alley_grab_anim_node thread scripts\sp\maps\hometown\hometown_util.gsc::play_anim_and_then_loop(level.hadir_ai, "alley_grab_scene_enter", "alley_grab_scene_idle");
  scripts\engine\utility::flag_wait("town_exit_alley_mid_flag");
  level.alley_grab_guy_model makefakeai();
  level.alley_grab_guy_model.health = 100;
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  level.hadir_ai thread scripts\sp\utility::enable_stayahead(level.player);
  level.alley_grab_mask_model = scripts\engine\sp\utility::spawn_anim_model("mask_grab_mask", level.alley_grab_anim_node.origin, level.alley_grab_anim_node.angles);
  level.alley_grab_anim_node notify("stop_loop");
  level.alley_grab_anim_node notify("stop_play_anim_and_then_loop");
  level.alley_grab_mask_model hide();
  thread audio_music_streets_grab_player();
  thread vfx_stop_gas_cam();
  thread gas_mask_swap();
  level.gas_alley_start_blocker scripts\engine\utility::delaycall(2.0, ::delete);
  setsaveddvar("LROTTMQLQO", 40);
  setsaveddvar("MPOOMRMSML", 30);
  level.alley_grab_anim_node thread scripts\common\anim::anim_single_solo(level.alley_grab_guy_model, "alley_grab_scene");
  level.alley_grab_anim_node thread scripts\common\anim::anim_single_solo(level.alley_grab_mask_model, "alley_grab_scene");
  level.alley_grab_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "alley_grab_scene");
  level.hadir_ai attach("hat_child_hadir_gas_mask");
  level.alley_grab_mask_model delete();
  var_0 scripts\sp\anim::anim_reach_solo(level.hadir_ai, "Hole_enter_hadir");
  var_0 thread scripts\common\anim::anim_single_solo(var_1, "Hole_enter_hadir");
  var_0 thread scripts\common\anim::anim_single_solo(var_2, "Hole_enter_hadir");
  var_0 scripts\common\anim::anim_single_solo(level.hadir_ai, "Hole_enter_hadir");
  var_0 thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "Hole_idle_hadir");

  if(scripts\sp\autosave::autosavethreatcheck(1))
    thread scripts\engine\sp\utility::autosave_by_name("final_gas_alley");

  scripts\engine\utility::flag_wait("gas_last_building_enter_flag");
  setsaveddvar("LROTTMQLQO", 60);
  setsaveddvar("MPOOMRMSML", 50);
  var_0 notify("stop_loop");
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  thread delete_window_blocker();
  var_0 thread scripts\common\anim::anim_single_solo(level.hadir_ai, "Hole_exit_hadir");
  scripts\engine\utility::flag_wait("village_exit_flag");
  level.special_autosavecondition = undefined;
  level notify("poppies_start");
  level notify("clean_up_civs");

  foreach(var_4 in level.russian_gas_blocker_array)
  var_4 delete();

  foreach(var_4 in level.russian_gas_patrol_array)
  var_4 delete();

  if(!scripts\engine\utility::flag("disable_autosaves"))
    thread scripts\engine\sp\utility::autosave_now();
}

delete_window_blocker() {
  wait 3.25;
  level.gas_window_blocker delete();
}

audio_music_streets_grab_player() {
  level waittill("exitguy_grabbing_hadir");
  wait 5.4;
  level.player playSound("mus_mx_hometown_16_escape_streets_grab_intro");
  wait 10.0;
  setmusicstate("");
}

vfx_stop_gas_cam() {
  level waittill("exitguy_grabbing_hadir");
  scripts\engine\utility::stop_exploder("gas_cam_01");
}

hadir_move_speed_gas_start(var_0) {
  wait 0.5;

  if(istrue(var_0)) {
    level.hadir_ai scripts\sp\utility::set_stayahead_values(1, 220, 75, 0.2);
    level.hadir_ai scripts\sp\utility::set_stayahead_values(2, 149, -25, 0.2);
    level.hadir_ai scripts\sp\utility::set_stayahead_values(3, 85, -100, 0.1);
    level.hadir_ai scripts\sp\utility::set_stayahead_values(4, 30, -150, 0.2);
    level.hadir_ai scripts\sp\utility::set_stayahead_wait_values(-200, 1);
    level.hadir_ai scripts\sp\utility::enable_stayahead(level.player);
    level.hadir_ai scripts\sp\utility::stayahead_set_wait_node_radius(200);
  } else {
    level.hadir_ai scripts\sp\utility::set_stayahead_values(1, 220, 75, 0.2);
    level.hadir_ai scripts\sp\utility::set_stayahead_values(2, 149, -25, 0.2);
    level.hadir_ai scripts\sp\utility::set_stayahead_values(3, 85, -100, 0.1);
    level.hadir_ai scripts\sp\utility::set_stayahead_values(4, 30, -150, 0.2);
    level.hadir_ai scripts\sp\utility::enable_stayahead(level.player);
  }
}

hadir_move_speed_gas_exit(var_0) {
  level.hadir_ai scripts\sp\utility::set_stayahead_values(1, 250, 40, 0.2);
  level.hadir_ai scripts\sp\utility::set_stayahead_values(2, 149, -50, 0.2);
  level.hadir_ai scripts\sp\utility::set_stayahead_values(3, 85, -125, 0.1);
  level.hadir_ai scripts\sp\utility::set_stayahead_values(4, 30, -175, 0.2);
  level.hadir_ai scripts\sp\utility::set_stayahead_wait_values(-225, 2);
  level.hadir_ai scripts\sp\utility::enable_stayahead(level.player);
  level.hadir_ai scripts\sp\utility::stayahead_set_wait_node_radius(400);

  if(istrue(var_0)) {
    level.hadir_ai thread hadir_disable_wait();
    scripts\engine\sp\utility::trigger_wait("cars_flank_end_trigger", "script_noteworthy");
    level.hadir_ai scripts\sp\utility::stayahead_disable_wait();
  }
}

hadir_move_speed_execution() {
  level.hadir_ai scripts\sp\utility::set_stayahead_values(1, 250, 40, 0.2);
  level.hadir_ai scripts\sp\utility::set_stayahead_values(2, 149, -50, 0.2);
  level.hadir_ai scripts\sp\utility::set_stayahead_values(3, 100, -125, 0.0);
  level.hadir_ai scripts\sp\utility::set_stayahead_values(4, 100, -175, 0.0);
  level.hadir_ai scripts\sp\utility::enable_stayahead(level.player);
}

hadir_disable_wait() {
  scripts\engine\sp\utility::trigger_wait("hadir_scramble_trigger", "script_noteworthy");
  scripts\sp\utility::stayahead_disable_wait();
  var_0 = getEnt("cars_flank_end_trigger", "script_noteworthy");
  var_0 notify("trigger");
}

mass_execution_a() {
  var_0 = scripts\engine\utility::getStruct("mass_execution_group_a_node", "script_noteworthy");
  var_1 = getspawner("russian_gas_execution_a1", "script_noteworthy");
  var_1 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1);
  var_2.animname = "gas_mass_execution_01_enemy01";
  var_3 = getspawner("russian_gas_execution_a2", "script_noteworthy");
  var_3 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  var_4 = var_3 scripts\engine\sp\utility::spawn_ai(1);
  var_4.animname = "gas_mass_execution_01_enemy02";
  var_5 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_01_civ01", var_0, 1, 1);
  var_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_01_civ02", var_0, 1, 1);
  var_7 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_01_civ03", var_0, 1, 1);
  var_8 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_01_civ04", var_0, 1, 1);
  var_9 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_01_civ05", var_0, 1, 1);
  var_10 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_01_civ06", var_0, 1, 1);
  var_5 scriptmoverdistancefade();
  var_6 scriptmoverdistancefade();
  var_7 scriptmoverdistancefade();
  var_8 scriptmoverdistancefade();
  var_9 scriptmoverdistancefade();
  var_10 scriptmoverdistancefade();
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_2;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_4;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_5;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_6;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_7;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_8;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_9;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_10;
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_5, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_6, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_7, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_8, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_9, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_10, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_2, "gas_mass_executions_01_intro");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_4, "gas_mass_executions_01_intro");
  scripts\engine\sp\utility::trigger_wait("road_cross_mid_trigger", "script_noteworthy");
  var_0 notify("stop_loop");
  var_0 thread scripts\common\anim::anim_single_solo(var_5, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_6, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_7, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_8, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_9, "gas_mass_executions_01_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_10, "gas_mass_executions_01_scene");
  var_0 scripts\sp\anim::anim_react([var_2, var_4], "gas_mass_executions_01");
}

mass_execution_b() {
  var_0 = scripts\engine\utility::getStruct("mass_execution_group_b_node", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("mass_execution_group_b_node_b", "script_noteworthy");
  var_2 = getspawner("russian_gas_execution_b1", "script_noteworthy");
  var_2 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  var_3 = var_2 scripts\engine\sp\utility::spawn_ai(1);
  var_3.animname = "gas_mass_execution_02_enemy01";
  var_4 = getspawner("russian_gas_execution_b2", "script_noteworthy");
  var_4 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  var_5 = var_4 scripts\engine\sp\utility::spawn_ai(1);
  var_5.animname = "gas_mass_execution_02_enemy02";
  var_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_02_civ01", var_0, 1, 1);
  var_7 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_02_civ02", var_0, 1, 1);
  var_8 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_02_civ03", var_0, 1, 1);
  var_9 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_02_civ04", var_0, 1, 1);
  var_10 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_02_civ05", var_0, 1, 1);
  var_11 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_mass_execution_02_civ06", var_0, 1, 1);
  var_6 scriptmoverdistancefade();
  var_7 scriptmoverdistancefade();
  var_8 scriptmoverdistancefade();
  var_9 scriptmoverdistancefade();
  var_10 scriptmoverdistancefade();
  var_11 scriptmoverdistancefade();
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_3;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_5;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_6;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_7;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_8;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_9;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_10;
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_11;
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_6, "gas_mass_executions_02_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_7, "gas_mass_executions_02_scene");
  var_1 thread scripts\common\anim::anim_first_frame_solo(var_8, "gas_mass_executions_02_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_9, "gas_mass_executions_02_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_10, "gas_mass_executions_02_scene");
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_11, "gas_mass_executions_02_scene");
  scripts\engine\sp\utility::trigger_wait("cars_street_start_trigger", "script_noteworthy");
  var_0 scripts\sp\anim::anim_reach([var_3, var_5], "gas_mass_executions_02_intro");
  var_0 notify("stop_loop");
  var_0 thread scripts\common\anim::anim_single_solo(var_6, "gas_mass_executions_02_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_7, "gas_mass_executions_02_scene");
  var_1 thread scripts\common\anim::anim_single_solo(var_8, "gas_mass_executions_02_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_9, "gas_mass_executions_02_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_10, "gas_mass_executions_02_scene");
  var_0 thread scripts\common\anim::anim_single_solo(var_11, "gas_mass_executions_02_scene");
  var_0 scripts\sp\anim::anim_react([var_3, var_5], "gas_mass_executions_02");
  var_3 scripts\engine\sp\utility::set_goal_pos(var_3.origin);
  var_5 scripts\engine\sp\utility::set_goal_pos(var_5.origin);
  var_3 scripts\engine\sp\utility::set_goalRadius(32);
  var_5 scripts\engine\sp\utility::set_goalRadius(32);
}

single_execution_a() {
  var_0 = getspawner("russian_gas_briefing_straggler", "script_noteworthy");
  var_0 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  level.russian_gas_briefing_straggler_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  level.russian_gas_briefing_straggler_ai.animname = "gas_single_execution01_soldier";
  thread square_search_dead_bodies();
}

gas_start_execution() {
  level.gas_start_soldier endon("stealth_combat");
  level.gas_start_soldier endon("stealth_investigate");
  level.gas_start_soldier endon("death");
  level.hadir_ready_to_cross_street = 0;
  level.gas_start_soldier thread search_cleanup();
  var_0 = getnode("gas_start_end_node", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("gas_start_body_node", "script_noteworthy");
  var_2 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_start_dead_body", var_1);
  var_2 scriptmoverdistancefade();
  var_2 setModel("body_civ_syrkistan_male_6_1");
  var_1 scripts\common\anim::anim_first_frame_solo(var_2, "gas_start_execution");
  scripts\engine\sp\utility::trigger_wait("road_cross_trigger", "script_noteworthy");
  level.hadir_ai scripts\engine\sp\utility::disable_ai_color();
  level notify("hadir_beckon_loop_suspend");
  level.hadir_ai scripts\asm\gesture::ai_request_gesture("stop", level.player, 10000);
  var_1 scripts\sp\anim::anim_reach_and_approach_solo(level.gas_start_soldier, "gas_start_execution_intro");
  thread hadir_beckon_gas_start();
  var_1 thread scripts\common\anim::anim_single_solo(var_2, "gas_start_execution");
  var_1 scripts\sp\anim::anim_react([level.gas_start_soldier], "gas_start_execution");
  level notify("hadir_ready_to_cross_street");
  level.hadir_ready_to_cross_street = 1;
  level.gas_start_soldier scripts\engine\sp\utility::set_goal_node(var_0);

  if(!scripts\engine\utility::flag("road_cross_mid_flag"))
    level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
}

hadir_beckon_gas_start() {
  wait(getanimlength(level.scr_anim["gas_start_soldier"]["gas_start_execution_intro"]) - 2.0);
  level notify("hadir_beckon_loop_restart");
  level.hadir_ai scripts\asm\gesture::ai_request_gesture("beckon", level.player, 10000);
}

square_search_dead_bodies() {
  level.russian_gas_briefing_straggler_ai endon("stealth_alertlevel_change");
  var_0 = scripts\engine\utility::getStruct("single_execution_a_node", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("square_search_body_a_loc", "script_noteworthy");
  var_2 = scripts\engine\utility::getStruct("square_search_body_b_loc", "script_noteworthy");
  var_3 = scripts\engine\utility::getStruct("square_search_body_c_loc", "script_noteworthy");
  var_4 = scripts\engine\utility::getStruct("square_search_body_d_loc", "script_noteworthy");
  var_5 = scripts\engine\utility::getStruct("square_search_body_e_loc", "script_noteworthy");
  var_6 = scripts\engine\utility::getStruct("square_search_body_f_loc", "script_noteworthy");
  var_7 = scripts\engine\utility::getStruct("square_search_body_g_loc", "script_noteworthy");
  var_8 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("square_dead_body_a", var_1);
  var_9 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("square_dead_body_b", var_2);
  var_10 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("square_dead_body_c", var_3);
  var_11 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("square_dead_body_d", var_1);
  var_12 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("square_dead_body_e", var_2);
  var_13 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_single_execution03_civ", var_3);
  var_14 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_single_execution04_civ", var_1);
  var_8 scriptmoverdistancefade();
  var_9 scriptmoverdistancefade();
  var_10 scriptmoverdistancefade();
  var_11 scriptmoverdistancefade();
  var_12 scriptmoverdistancefade();
  var_13 scriptmoverdistancefade();
  var_14 scriptmoverdistancefade();
  var_1 scripts\common\anim::anim_first_frame_solo(var_12, "search_body_e");
  var_2 scripts\common\anim::anim_first_frame_solo(var_10, "search_body_c");
  var_3 scripts\common\anim::anim_first_frame_solo(var_11, "search_body_d");
  var_4 scripts\common\anim::anim_first_frame_solo(var_8, "search_body_a");
  var_5 scripts\common\anim::anim_first_frame_solo(var_9, "search_body_b");
  var_6 scripts\common\anim::anim_first_frame_solo(var_13, "gas_single_execution03");
  var_7 scripts\common\anim::anim_first_frame_solo(var_14, "gas_single_execution04");
  var_15 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_single_execution01_civ", var_0, 1, 1);
  var_15 scriptmoverdistancefade();
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_15;
  var_0 thread scripts\common\anim::anim_first_frame_solo(var_15, "gas_single_execution01");
  scripts\engine\utility::flag_wait("straggler_start");
  level.russian_gas_briefing_straggler_ai scripts\engine\sp\utility::set_goalRadius(32);
  var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.russian_gas_briefing_straggler_ai, "gas_single_execution01");
  thread hadir_russian_wait_flag();
  var_0 thread scripts\common\anim::anim_single_solo(var_15, "gas_single_execution01");
  var_0 scripts\common\anim::anim_single_solo(level.russian_gas_briefing_straggler_ai, "gas_single_execution01");
  var_6 scripts\sp\anim::anim_reach_and_approach_solo(level.russian_gas_briefing_straggler_ai, "gas_single_execution03_intro");
  var_6 thread scripts\common\anim::anim_single_solo(var_13, "gas_single_execution03");
  var_6 scripts\sp\anim::anim_react([level.russian_gas_briefing_straggler_ai], "gas_single_execution03");
  var_7 scripts\sp\anim::anim_reach_and_approach_solo(level.russian_gas_briefing_straggler_ai, "gas_single_execution04_intro");
  var_7 thread scripts\common\anim::anim_single_solo(var_14, "gas_single_execution04");
  var_7 scripts\sp\anim::anim_react([level.russian_gas_briefing_straggler_ai], "gas_single_execution04");
  var_4 scripts\sp\anim::anim_reach_and_approach_solo(level.russian_gas_briefing_straggler_ai, "search_body_a_intro");
  var_4 thread scripts\common\anim::anim_single_solo(var_8, "search_body_a");
  var_4 scripts\sp\anim::anim_react([level.russian_gas_briefing_straggler_ai], "search_body_a");
  var_5 scripts\sp\anim::anim_reach_and_approach_solo(level.russian_gas_briefing_straggler_ai, "search_body_b_intro");
  var_5 thread scripts\common\anim::anim_single_solo(var_9, "search_body_b");
  var_5 scripts\sp\anim::anim_react([level.russian_gas_briefing_straggler_ai], "search_body_b");
  var_1 scripts\sp\anim::anim_reach_and_approach_solo(level.russian_gas_briefing_straggler_ai, "search_body_e_intro");
  var_1 thread scripts\common\anim::anim_single_solo(var_12, "search_body_e");
  var_1 scripts\sp\anim::anim_react([level.russian_gas_briefing_straggler_ai], "search_body_e");
  var_2 scripts\sp\anim::anim_reach_and_approach_solo(level.russian_gas_briefing_straggler_ai, "search_body_c_intro");
  var_2 thread scripts\common\anim::anim_single_solo(var_10, "search_body_c");
  var_2 scripts\sp\anim::anim_react([level.russian_gas_briefing_straggler_ai], "search_body_c");
  var_3 scripts\sp\anim::anim_reach_and_approach_solo(level.russian_gas_briefing_straggler_ai, "search_body_d_intro");
  var_3 thread scripts\common\anim::anim_single_solo(var_11, "search_body_d");
  var_3 scripts\sp\anim::anim_react([level.russian_gas_briefing_straggler_ai], "search_body_d");
}

hadir_russian_wait_flag() {
  thread hadir_advance_flank_trigger_wait();
  wait(getanimlength(level.scr_anim["gas_single_execution01_soldier"]["gas_single_execution01"]) - 4.0);
  scripts\engine\utility::flag_set("safe_for_hadir_to_progress");
  var_0 = scripts\engine\utility::getStruct("mass_execution_group_b_node", "script_noteworthy");
  var_1 = createnavbadplacebybounds(var_0.origin - (75, 0, 0), (200, 250, 200), var_0.angles, "allies");
}

hadir_advance_flank_trigger_wait() {
  scripts\engine\sp\utility::trigger_wait("hadir_advance_car_flank_trigger", "script_noteworthy");
  scripts\engine\utility::flag_set("safe_for_hadir_to_progress");
}

single_execution_b() {
  var_0 = scripts\engine\utility::getStruct("single_execution_b_node", "script_noteworthy");
  var_1 = getspawner("russian_gas_briefing_latecomer", "script_noteworthy");
  var_1 scripts\engine\sp\utility::add_spawn_function(scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func);
  var_2 = var_1 scripts\engine\sp\utility::spawn_ai(1);
  var_2.animname = "gas_single_execution02_soldier";
  var_2.anglelerprate = 20;
  var_3 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("gas_single_execution02_civ", var_0, 1, 1);
  var_3 scriptmoverdistancefade();
  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_3;
  var_0 thread scripts\common\anim::anim_loop_solo(var_3, "gas_single_execution02_idle");
  scripts\engine\utility::flag_wait("cars_flank_mid_flag");
  level.hadir_ai scripts\engine\sp\utility::disable_ai_color();
  level.hadir_ai scripts\sp\utility::disable_stayahead(70);
  level notify("hadir_beckon_loop_suspend");
  level.hadir_ai scripts\asm\gesture::ai_request_gesture("stop", level.player, 10000);
  var_0 scripts\sp\anim::anim_reach_solo(var_2, "gas_single_execution02_enter");
  var_4 = getnode("latecomer_idle_node", "script_noteworthy");
  var_2 setgoalnode(var_4);
  var_2 scripts\engine\sp\utility::set_goalRadius(32);
  var_0 scripts\common\anim::anim_single_solo(var_2, "gas_single_execution02_enter");
  var_0 thread scripts\common\anim::anim_single_solo(var_2, "gas_single_execution02");
  var_0 thread scripts\common\anim::anim_single_solo(var_3, "gas_single_execution02");
  wait(getanimlength(level.scr_anim["gas_single_execution02_soldier"]["gas_single_execution02"]) - 3.0);
  level.hadir_ai scripts\asm\gesture::ai_request_gesture("beckon", level.player, 10000);
  wait 1.25;
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  level.hadir_ai scripts\engine\utility::delaythread(3.5, ::hadir_move_speed_gas_exit, 1);
  wait 4.0;
  level notify("hadir_beckon_loop_restart");
}

remove_gas_mask() {
  level.player scripts\common\utility::allow_melee(0);
  wait 3.5;
  level.player takeallweapons();
  level.player enableweapons();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweaponimmediate("iw8_gunless_farrah");
  waitframe();
  thread mask_remove_fade();
  play_mask_remove();
  thread scripts\sp\art::dof_enable_script(0, 0, 0, 0, 0, 0, 1.0);
  wait 1.0;
  level.player scripts\common\utility::allow_melee(1);
}

mask_remove_fade() {
  wait 0.5;
  level.gas_mask_overlay fadeovertime(0.3);
  level.gas_mask_overlay.alpha = 0;
  wait 1.0;
  level.gas_mask_overlay destroy();
}

play_mask_remove() {
  level.player takeallweapons();
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweaponimmediate("iw8_gunless_farrah");
  waitframe();
  var_0 = spawn("script_model", level.player.origin);
  var_0 setModel("prop_gasmask_russian_soldier_boss");
  var_0 scripts\engine\sp\utility::assign_animtree("farah_mask_off_mask");
  var_0 notsolid();
  var_0 linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  level.player playSound("htf_farah_mask_off_plr_01");
  level.player scripts\engine\sp\utility::player_gesture_force("ges_htf_farah_maskoff");
  level.player setentitysoundcontext("gender", "child_female", 1);
  var_0 setflaggedanimknobrestart("gasmask", var_0 scripts\engine\utility::getanim("remove_mask"), 1);
  wait 3.2;
  var_0 delete();
}

gas_victims() {
  level thread gas_victim_spawn_and_loop("GasVictim1", "gas_victim_01", "male");
  level thread gas_victim_spawn_and_loop("GasVictim2", "gas_victim_02", "female");
  level thread gas_victim_spawn_and_loop("GasVictim3", "gas_victim_03", "male");
  level thread gas_victim_spawn_and_loop("GasVictim4", "gas_victim_04", "female");
  level thread gas_victim_spawn_and_loop("GasVictim5", "gas_victim_13", "male");
  level thread gas_victim_spawn_and_loop("GasVictim6", "gas_victim_18", "female");
  level thread gas_victim_spawn_and_loop("GasVictim7", "gas_victim_07", "male");
  level thread gas_victim_spawn_and_loop("GasVictim8", "gas_victim_08", "female", (0, 0, -2.2), (0, 0, 2));
  level thread gas_victim_spawn_and_loop("dead_goat_a", "gas_victim_21", "none");
  level thread gas_victim_spawn_and_loop("dead_chicken_b", "gas_victim_22", "none");
  level thread gas_victim_spawn_and_loop("dead_chicken_c", "gas_victim_23", "none");
  level thread gas_victim_spawn_and_loop("dead_chicken_d", "gas_victim_24", "none");
  level thread gas_victim_spawn_and_loop("dead_goat_a", "gas_victim_25", "none");
  level thread gas_victim_spawn_and_loop("dead_goat_a", "gas_victim_26", "none");
  level thread gas_victim_spawn_and_loop("dead_goat_a", "gas_victim_27", "none");
  level thread gas_victim_spawn_and_loop("dead_goat_a", "gas_victim_28", "none");
  level thread gas_victim_spawn_and_loop("dead_chicken_b", "gas_victim_29", "none");
  level thread gas_victim_spawn_and_loop("dead_chicken_c", "gas_victim_30", "none");
  level thread gas_victim_spawn_and_loop("dead_chicken_d", "gas_victim_31", "none");
}

gas_victim_spawn_and_loop(var_0, var_1, var_2, var_3, var_4) {
  var_5 = scripts\engine\utility::getStruct(var_1, "script_noteworthy");

  if(var_2 == "male") {
    var_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ(var_0, var_5);
    var_6 playLoopSound("dx_vom_male_gasp");
  } else if(var_2 == "female") {
    var_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female(var_0, var_5);
    var_6 playLoopSound("dx_vom_female_gasp");
  } else if(var_2 == "child_male")
    var_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child(var_0, var_5);
  else if(var_2 == "child_female")
    var_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child_female(var_0, var_5);
  else if(var_2 == "none")
    var_6 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_5.origin, var_5.angles);
  else
    var_6 = scripts\engine\sp\utility::spawn_anim_model(var_0, var_5.origin, var_5.angles);

  level.civ_cleanup_array[level.civ_cleanup_array.size] = var_6;

  if(isDefined(var_3))
    var_5.angles = var_5.angles + var_3;

  if(isDefined(var_4))
    var_5.origin = var_5.origin + var_4;

  var_6 scriptmoverdistancefade();
  var_5 thread scripts\common\anim::anim_loop_solo(var_6, "gas_death_idle");
}

poppies_main() {
  setsaveddvar("OLMLOTTLRM", 1.0);
  setaudiotriggerstate("gas_outsidehouse", "", 1.0);
  level.hadir_in_gas = 0;
  thread scripts\sp\maps\hometown\hometown_vo.gsc::poppies_start_vo();
  visionsetnaked("hometown_poppy_reveal", 2.0);
  scripts\engine\utility::stop_exploder("gas_cam_01");
  scripts\engine\utility::exploder("cam_dust");
  thread scripts\sp\analytics::analytics_kleenex_update("Poppies Start to Pistol Fight Start");
  level.hadir_ai thread tempdisabledynmovementspeed();
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  thread gas_mask_remove_trigger_monitor();
  thread hadir_duck();
  thread set_bloody_model();
  scripts\engine\utility::flag_set("lighting_poppies_progression");
  scripts\engine\utility::flag_set("objective_find_a_way_out_of_town");
  scripts\engine\sp\utility::trigger_wait("start_execution_trigger", "script_noteworthy");
  setmusicstate("mx_hometown_17_poppies_execution");

  if(isDefined(level.fire_sfx_org))
    level.fire_sfx_org thread scripts\engine\sp\utility::sound_fade_and_delete(4.0, 1);

  if(isDefined(level.childsoundorg))
    level.childsoundorg thread scripts\engine\sp\utility::sound_fade_and_delete(1.0, 1);

  poppies_enemies_spawn();
  thread execution_scene();
  level.player scripts\engine\utility::ent_flag_clear("stealth_use_real_lighting");
  level.stealth.detect.range["hidden"]["prone"] = 250;
  level.stealth.detect.range["hidden"]["crouch"] = 350;
  level.stealth.detect.range["hidden"]["stand"] = 550;
  scripts\engine\sp\utility::trigger_wait("pistol_intro_start_trigger", "script_noteworthy");

  if(!scripts\engine\utility::flag("disable_autosaves"))
    thread scripts\engine\sp\utility::autosave_now();
}

audio_poppies_mix_change() {
  wait 4;
  level.player setclienttriggeraudiozonepartialwithfade("ht_poppyfields_poppyup_mix", 2.0, "mix");
}

tempdisabledynmovementspeed() {
  self aisetdesiredspeed(140);
  self aisettargetspeed(140);
  scripts\sp\utility::stayahead_pause(1);
  scripts\engine\sp\utility::trigger_wait("gas_mask_remove_trigger", "script_noteworthy");
  scripts\sp\utility::stayahead_pause(0);
  level.hadir_ai scripts\sp\utility::set_stayahead_wait_values(-225, 1);
}

set_bloody_model() {
  waitframe();
  scripts\sp\player\youngfarrah::setplayerviewmodel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel(), undefined, "viewmodel_farah_child_shadowcaster");
}

foliage_react_radius_monitor() {
  level endon("remove_blocker");
  var_0 = getEnt("foliage_react_radius_trigger", "script_noteworthy");
  thread foliage_react_radius_set();

  for(;;) {
    while(!level.hadir_ai istouching(var_0))
      waitframe();

    level notify("hadir_near_branch");

    while(level.hadir_ai istouching(var_0))
      waitframe();

    level notify("hadir_away_from_branch");
  }
}

foliage_react_radius_set() {
  for(;;) {
    level waittill("hadir_near_branch");
    setsaveddvar("MPLOLNMSRO", 40.0);
    level notify("hadir_beckon_loop_suspend");
    waitframe();
    level.hadir_ai scripts\asm\gesture::ai_request_gesture("move_branch", level.player, 10000);
    level waittill("hadir_away_from_branch");
    level notify("hadir_beckon_loop_restart");
    setsaveddvar("MPLOLNMSRO", 20.0);
  }
}

hadir_field_start_scene() {
  var_0 = scripts\engine\utility::getStruct("poppies_enter_anim_node", "script_noteworthy");
  scripts\engine\sp\utility::trigger_wait("village_exit_trigger", "script_noteworthy");
  var_0 notify("stop_loop");
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
}

poppies_enemies_spawn() {
  wait 0.5;
  scripts\engine\sp\utility::array_spawn_function_noteworthy("russian_poppies", scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func_no_flashlight_ignore);
  level.poppies_enemies = scripts\engine\sp\utility::array_spawn_noteworthy("russian_poppies", 1);
  scripts\engine\sp\utility::array_spawn_function_noteworthy("russian_poppies_traffickers", scripts\sp\maps\hometown\hometown_util.gsc::russian_patroller_spawn_func_no_flashlight_ignore);
  level.poppies_trafficker_enemies = scripts\engine\sp\utility::array_spawn_noteworthy("russian_poppies_traffickers", 1);
}

execution_scene() {
  level endon("pistol_fight_start");
  level.execution_anim_node = scripts\engine\utility::getStruct("execution_anim_node", "script_noteworthy");
  level.trafficking_anim_node = getEnt("trafficking_truck_poppies_anim_node", "script_noteworthy");
  thread truckmove02();
  level.trafficking_truck_vehicle = scripts\engine\sp\utility::spawn_anim_model("trafficking_truck_01", level.trafficking_anim_node.origin, level.trafficking_anim_node.angles);
  level.civ_2 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("execution_malevictim", level.execution_anim_node);
  level.civ_3 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("execution_victim_01", level.execution_anim_node);
  level.civ_4 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("execution_victim_02", level.execution_anim_node);
  level.civ_5 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("execution_victim_03", level.execution_anim_node);
  level.civ_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("execution_victim_04", level.execution_anim_node);
  level.traffick_civ_1 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("trafficking_woman_01", level.execution_anim_node);
  level.traffick_civ_2 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("trafficking_woman_02", level.execution_anim_node);
  level.traffick_civ_3 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("trafficking_woman_03", level.execution_anim_node);
  level.traffick_civ_4 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("trafficking_woman_04", level.execution_anim_node);
  level.traffick_civ_5 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("trafficking_kid_01", level.execution_anim_node);
  level.execution_civs_array = [];
  level.execution_civs_array[level.execution_civs_array.size] = level.civ_1;
  level.execution_civs_array[level.execution_civs_array.size] = level.civ_2;
  level.execution_civs_array[level.execution_civs_array.size] = level.civ_3;
  level.execution_civs_array[level.execution_civs_array.size] = level.civ_4;
  level.execution_civs_array[level.execution_civs_array.size] = level.civ_5;
  level.execution_civs_array[level.execution_civs_array.size] = level.civ_6;
  level.execution_civs_array[level.execution_civs_array.size] = level.traffick_civ_1;
  level.execution_civs_array[level.execution_civs_array.size] = level.traffick_civ_2;
  level.execution_civs_array[level.execution_civs_array.size] = level.traffick_civ_3;
  level.execution_civs_array[level.execution_civs_array.size] = level.traffick_civ_4;
  level.execution_civs_array[level.execution_civs_array.size] = level.traffick_civ_5;
  level.execution_civs_array[level.execution_civs_array.size] = level.traffick_civ_6;
  thread execution_scene_end();
  thread execution_skip_monitor();
  thread hadir_scramble_monitor();
  thread audio_shed_truck_idle_monitor();
  var_0 = 1;

  foreach(var_2 in level.poppies_enemies) {
    var_2.animname = "execution_terry_0" + var_0;
    level.execution_anim_node thread scripts\common\anim::anim_single_solo(var_2, "Execution_scene");
    var_0++;
  }

  var_0 = 1;

  foreach(var_2 in level.poppies_trafficker_enemies) {
    var_2.animname = "trafficking_russian_0" + var_0;
    thread trafficked_scene_solo(var_2);
    thread trafficked_scene_kill(var_2);
    var_0++;
  }

  thread trafficked_scene();
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_2, "Execution_scene");
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_3, "Execution_scene");
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_4, "Execution_scene");
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_5, "Execution_scene");
  level.execution_anim_node scripts\common\anim::anim_single_solo(level.civ_6, "Execution_scene");
  level notify("shoot_all_the_civs");
  level.civs_executed = 1;
}

truckmove02() {
  scripts\engine\utility::flag_wait("truckmove02");
  level notify("truckmove02");
  level.trafficking_truck_vehicle delete();
  level.trafficking_anim_node linkTo(level.shed_umike);
  level.trafficking_anim_node notify("stop_loop");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_1, "trafficked_scene_idle");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_2, "trafficked_scene_idle");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_3, "trafficked_scene_idle");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_4, "trafficked_scene_idle");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_5, "trafficked_scene_idle");
}

trafficked_scene_solo(var_0) {
  level endon("truckmove02");
  level.trafficking_anim_node scripts\common\anim::anim_single_solo(var_0, "trafficked_scene");

  if(var_0.animname == "trafficking_russian_02")
    level.trafficking_anim_node scripts\common\anim::anim_loop_solo(var_0, "trafficked_scene_idle");
}

trafficked_scene_kill(var_0) {
  scripts\engine\utility::flag_wait("truckmove02");
  var_0 stopanimScripted();

  if(var_0.animname == "trafficking_russian_02")
    var_0 delete();
}

trafficked_scene() {
  level endon("truckmove02");
  level.traffick_civ_1 linkTo(level.trafficking_anim_node);
  level.traffick_civ_2 linkTo(level.trafficking_anim_node);
  level.traffick_civ_3 linkTo(level.trafficking_anim_node);
  level.traffick_civ_4 linkTo(level.trafficking_anim_node);
  level.traffick_civ_5 linkTo(level.trafficking_anim_node);
  level.trafficking_anim_node thread scripts\common\anim::anim_single_solo(level.traffick_civ_1, "trafficked_scene");
  level.trafficking_anim_node thread scripts\common\anim::anim_single_solo(level.traffick_civ_2, "trafficked_scene");
  level.trafficking_anim_node thread scripts\common\anim::anim_single_solo(level.traffick_civ_3, "trafficked_scene");
  level.trafficking_anim_node thread scripts\common\anim::anim_single_solo(level.traffick_civ_4, "trafficked_scene");
  level.trafficking_anim_node thread scripts\common\anim::anim_single_solo(level.traffick_civ_5, "trafficked_scene");
  level.trafficking_anim_node scripts\common\anim::anim_single_solo(level.trafficking_truck_vehicle, "trafficked_scene");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_1, "trafficked_scene_idle");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_2, "trafficked_scene_idle");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_3, "trafficked_scene_idle");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_4, "trafficked_scene_idle");
  level.trafficking_anim_node thread scripts\common\anim::anim_loop_solo(level.traffick_civ_5, "trafficked_scene_idle");
}

audio_shed_truck_idle_monitor() {
  var_0 = spawn("script_origin", (5268, -3661, -298));
  var_1 = scripts\engine\utility::play_loopsound_in_space("scn_hometown_truck_by_engine_idle_lp", (5268, -3661, -298));
  level waittill("audio_stop_shed_truck_idle_lp");
  var_1 thread scripts\engine\sp\utility::sound_fade_and_delete(1.5, 1);
  var_0 delete();
  var_0 = undefined;
}

execution_scene_end() {
  level.hadir_in_shed = 0;
  level waittill("shoot_all_the_civs");

  if(level.hadir_in_shed) {
    var_0 = scripts\engine\utility::getStruct("hadir_scramble_anim_node", "script_noteworthy");
    var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.hadir_ai, "Execution_end");
    level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
    var_0 thread scripts\common\anim::anim_single_solo(level.hadir_ai, "Execution_end");
  }

  thread shed_bullet_fx();
  var_1 = 1;

  foreach(var_3 in level.poppies_enemies) {
    var_3.animname = "execution_terry_0" + var_1;
    level.execution_anim_node thread scripts\common\anim::anim_single_solo(var_3, "Execution_end");
    var_1++;
  }

  level.player enableinvulnerability();
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_1, "Execution_end");
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_2, "Execution_end");
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_3, "Execution_end");
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_4, "Execution_end");
  level.execution_anim_node thread scripts\common\anim::anim_single_solo(level.civ_5, "Execution_end");
  level.execution_anim_node scripts\common\anim::anim_single_solo(level.civ_6, "Execution_end");
  level.player disableinvulnerability();
}

shed_bullet_fx() {
  wait 2;
  scripts\engine\utility::exploder("shed_bullethole");
}

execution_skip_monitor() {
  level.civs_executed = 0;
  scripts\engine\sp\utility::trigger_wait("civ_execution_trigger", "script_noteworthy");
  level notify("shoot_all_the_civs");
  level.civs_executed = 1;
  level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
}

hadir_scramble_monitor() {
  var_0 = scripts\engine\utility::getStruct("hadir_scramble_anim_node", "script_noteworthy");
  scripts\engine\sp\utility::trigger_wait("hadir_scramble_trigger", "script_noteworthy");

  if(!level.civs_executed) {
    level.hadir_ai scripts\engine\sp\utility::disable_ai_color();
    level.hadir_ai scripts\sp\utility::disable_stayahead();
    level notify("stop_stayahead_turbo_check");
    var_1 = scripts\engine\utility::getStruct("hadir_scramble_start_node", "script_noteworthy");
    var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.hadir_ai, "Execution_end");
    level.hadir_in_shed = 1;
  } else {
    var_1 = scripts\engine\utility::getStruct("hadir_scramble_start_node", "script_noteworthy");
    var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.hadir_ai, "Execution_end");
    wait 0.1;
    level.hadir_ai scripts\engine\sp\utility::enable_ai_color();
  }
}

pistol_enemies_spawn() {
  level.pistol_enemies_number = 1;
  waitframe();
  scripts\engine\sp\utility::array_spawn_function_noteworthy("russian_pistol_fight", ::pistol_enemies_spawn_func);
  level.pistol_enemies = scripts\engine\sp\utility::array_spawn_noteworthy("russian_pistol_fight", 1);
  scripts\engine\sp\utility::set_group_advance_to_enemy_parameters(1000, 1);
  var_0 = 1;

  foreach(var_2 in level.pistol_enemies) {
    if(!isDefined(level.pistol_enemy_01_ai))
      level.pistol_enemy_01_ai = var_2;
    else
      level.pistol_enemy_02_ai = var_2;

    var_3 = scripts\sp\utility::make_weapon("iw8_ar_akilo47", ["reflexstable_west01", "barsmg_akilo47", "calsmg_akilo47_sp", "taclight"]);
    var_2 scripts\anim\shared.gsc::forceuseweapon(var_3, "primary");
    var_2.dropweapon = 0;
    var_2.animname = "pistol_enemy_0" + var_0;
    var_0++;
  }

  thread pistol_fight_start_monitor();
}

pistol_enemies_spawn_func() {
  scripts\engine\sp\utility::set_grenadeammo(0);
  self.goalradius = 30;
  self.baseaccuracy = 2;
  self.combatmode = "no_cover";
  self.script_combatmode = "no_cover";
  self.limitstealthturning = 1;
  self.noarmor = 1;
  self.aggressivemode = 1;
  self.meleechargedistvsplayer = 60;
  self.providecoveringfire = 1;
  self.aggressivelowcovermode = 1;
  thread achievement_pistol_enemies();
  pistol_enemies_setup_stealth();
  thread pistol_enemy_combat_think();
  wait 0.5;
  self removeaieventlistener("footstep_sprint");
  self.fnshouldplaypainanim = scripts\sp\maps\hometown\hometown_util.gsc::wasaimeleedbyplayer;
}

pistol_enemy_combat_think() {
  self endon("death");
  self waittill("stealth_combat");
  self.combat_volume = level.stealth.hunt_volumes[self.script_stealthgroup];
  self setgoalvolumeauto(self.combat_volume);
}

achievement_pistol_enemies() {
  if(!isDefined(level.pistol_enemy_deaths))
    level.pistol_enemy_deaths = 0;

  self waittill("death", var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_2) && getweaponbasename(var_2) == "iw8_pi_cpapa_farah_sp_a") {
    level.pistol_enemy_deaths = level.pistol_enemy_deaths + 1;

    if(level.pistol_enemy_deaths == 1)
      level.pistol_enemy_deaths_time = gettime();
  }

  if(level.pistol_enemy_deaths > 1 && gettime() - level.pistol_enemy_deaths_time < 400)
    level thread scripts\sp\utility::giveachievement_wrapper("twobirds");
}

pistol_fight_start_monitor() {
  scripts\engine\sp\utility::trigger_wait("pistol_fight_start_trigger", "script_noteworthy");
  level notify("pistol_fight_start");
  thread scripts\sp\maps\hometown\hometown_util.gsc::transient_unload_town();

  if(isDefined(level.poppies_enemies)) {
    foreach(var_1 in level.poppies_enemies) {
      if(isalive(var_1))
        var_1 delete();
    }
  }

  if(isDefined(level.poppies_trafficker_enemies)) {
    foreach(var_1 in level.poppies_trafficker_enemies) {
      if(isalive(var_1))
        var_1 delete();
    }
  }
}

pistol_enemies_has_lost_enemy() {
  level.ctimetolose = 15000;
  level.cstillrighttheredistsq = 2500;
  var_0 = 8000;
  var_1 = gettime();
  var_2 = self.enemy;

  if(isDefined(var_2) && issentient(var_2) && isalive(var_2)) {
    if(var_2.team != "allies")
      return 0;

    var_3 = self lastknowntime(var_2);

    if(var_1 < var_3 + level.ctimetolose)
      return 0;

    var_4 = self lastknownpos(var_2);

    if(var_3 > 0 && distancesquared(var_2.origin, var_4) < level.cstillrighttheredistsq)
      return 0;

    if(isDefined(self.benemyinlowcover))
      return 0;
  }

  return 1;
}

pistol_enemies_setup_stealth() {
  if(!isDefined(self.stealth.funcs))
    self.stealth.funcs = [];

  self.stealth.funcs["has_lost_enemy"] = ::pistol_enemies_has_lost_enemy;
}

pistol_skip_fight() {
  var_0 = scripts\sp\hud_util::create_client_overlay("black", 0);
  var_0.foreground = 0;
  var_1 = scripts\sp\hud_util::createfontstring("default", 1.8);
  var_1 settext(&"HOMETOWN/PISTOL_SOLDIERS_KILLED");
  var_1 scripts\sp\hud_util::setpoint("CENTER", undefined, 0, -90);
  var_1.alpha = 0;
  var_1.foreground = 1;

  foreach(var_3 in level.pistol_enemies)
  var_3.ignoreall = 1;

  level.player freezecontrols(1);
  var_5 = 2.0;
  var_0 fadeovertime(var_5);
  var_0.alpha = 1.0;
  var_1 fadeovertime(var_5);
  var_1.alpha = 1.0;
  wait 2;

  for(var_6 = 0; var_6 < level.pistol_enemies.size; var_6++)
    level.pistol_enemies[var_6] scripts\sp\maps\hometown\hometown_util.gsc::kill_and_delete_quietly(level.player);

  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweaponimmediate("iw8_gunless_farrah");
  var_7 = scripts\engine\utility::get_target_array("drive_start");
  var_8 = scripts\engine\utility::getStruct("get_to_car_objective", "script_noteworthy");
  level.player setOrigin((var_7[0].origin[0], var_7[0].origin[1], var_7[0].origin[2] + 20));
  level.player setplayerangles(vectortoangles(var_8.origin - var_7[0].origin));
  wait 3;
  var_9 = 1.0;
  var_0 fadeovertime(var_9);
  var_0.alpha = 0;
  var_1 fadeovertime(var_9);
  var_1.alpha = 0;
  wait(var_9);
  var_1 scripts\sp\hud_util::destroyelem();
  var_0 scripts\sp\hud_util::destroyelem();
  level.player freezecontrols(0);
}

pistol_main() {
  setsaveddvar("OLMLOTTLRM", 1.4);

  if(getdvarint("greenlight") || getdvarint("greenlight_three_stab"))
    thread greenlight_mission_end_monitor();

  var_0 = getEnt("end_russian_truck", "script_noteworthy");
  var_0 delete();
  pistol_enemies_spawn();
  thread pistol_fight_death_monitor();
  thread player_adsed_monitor();
  level.pistol_intro_anim_node = scripts\engine\utility::getStruct("pistol_intro_anim_node", "script_noteworthy");
  level.pistol_intro_anim_node_truck = scripts\engine\utility::getStruct("pistol_intro_anim_node_truck", "script_noteworthy");
  level.pistol_intro_anim_node_truck01 = scripts\engine\utility::getStruct("pistol_intro_anim_node_truck01", "script_noteworthy");
  thread ending_truck_idle_scene();
  thread loading_kids_into_trucks_scene();
  thread scripts\sp\maps\hometown\hometown_vo.gsc::pistol_start_vo();
  level.player takeallweapons();
  waitframe();
  scripts\sp\player\youngfarrah::setplayerviewmodel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel(), undefined, "viewmodel_farah_child_shadowcaster");
  level.player scripts\engine\utility::ent_flag_clear("stealth_use_real_lighting");
  var_1["prone"] = 250;
  var_1["crouch"] = 350;
  var_1["stand"] = 550;
  var_1["shadow"] = 0.17;
  scripts\stealth\utility::set_detect_ranges(var_1);
  var_2["prone"] = 60;
  var_2["crouch"] = 60;
  var_2["stand"] = 90;
  scripts\stealth\utility::set_min_detect_range_darkness(var_2);
  var_3["ai_eventDistFootstepSprint"]["spotted"] = 120;
  var_3["ai_eventDistFootstepSprint"]["hidden"] = 120;
  scripts\stealth\manager::set_custom_distances(var_3);
  level.player giveweapon("iw8_gunless_farrah");
  level.player switchtoweapon("iw8_gunless_farrah");
  level.player scripts\engine\sp\utility::add_damage_function(::player_pistol_damage_func);
  level.pistol_intro_anim_node scripts\sp\anim::anim_reach_solo(level.hadir_ai, "phone_enter_hadir");
  level.hadir_ai scripts\sp\utility::disable_stayahead();
  level.pistol_intro_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "phone_enter_hadir");
  level.pistol_intro_anim_node thread scripts\common\anim::anim_loop_solo(level.hadir_ai, "phone_idle_hadir", "hadir_loop_stop");
  scripts\engine\sp\utility::trigger_wait("pistol_start_trigger", "script_noteworthy");
  level.pistol_intro_anim_node notify("hadir_loop_stop");
  level notify("stop_hadir_gesture_loop");
  thread player_gesture_cellphone_show();
  thread player_gesture_cellphone_call();
  thread remove_pistol_arena_blocker();

  if(!scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene()) {
    var_4 = getEnt("farah_pistol_pickup", "script_noteworthy");
    var_4 thread pistol_weapon_interact();
  }

  level.hadir_ai detach("head_sc_m_coto");
  level.hadir_ai attach("head_sc_m_coto_blendshape");
  level.pistol_intro_anim_node scripts\common\anim::anim_single_solo(level.hadir_ai, "phone_scene_hadir");
  level.hadir_ai attach("head_sc_m_coto");
  level.hadir_ai detach("head_sc_m_coto_blendshape");
  thread scripts\sp\analytics::analytics_kleenex_update("Pistol Fight Start to Got Pistol");
  level.special_autosavecondition = ::pistol_can_save;
  level.hadir_ai thread scripts\sp\spawner::go_to_node(getnode("hadir_hide_node_d", "script_noteworthy"));
  level.hadir_ai scripts\sp\utility::disable_stayahead();
  var_5 = scripts\engine\utility::getStruct("get_to_car_objective", "script_noteworthy");
  var_5 thread car_interact();
  thread hadir_go_to_vehicle();

  if(scripts\sp\maps\hometown\hometown_util.gsc::skipchildrenkillingscene()) {
    level waittill("use_cellphone_finish");
    pistol_skip_fight();
  }

  level waittill("car_door_interacted");
  level.special_autosavecondition = undefined;
  thread scripts\engine\sp\utility::autosave_by_name("enter_car");
}

player_pistol_damage_func(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9) {
  if(isai(var_1))
    self kill(var_3, var_1, var_1, var_4);
}

pistol_can_save() {
  foreach(var_1 in getaiarray("axis")) {
    if(isDefined(var_1.stealth) && var_1[[var_1.fnisinstealthcombat]]())
      return 0;
  }

  return 1;
}

remove_pistol_arena_blocker() {
  level waittill("remove_blocker");
  var_0 = getEnt("pistol_arena_blocker", "script_noteworthy");
  var_0 scripts\engine\sp\utility::hide_entity();

  if(!scripts\engine\utility::flag("disable_autosaves"))
    thread scripts\engine\sp\utility::autosave_now();
}

ending_truck_idle_scene() {
  var_0 = scripts\engine\utility::getStruct("end_anim_node", "script_noteworthy");
  level.phone_kid_idle_child01_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("phone_kid_idle_child01", level.pistol_intro_anim_node);
  level.phone_kid_idle_child02_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("phone_kid_idle_child02", level.pistol_intro_anim_node);
  level.phone_kid_idle_child03_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("phone_kid_idle_child03", level.pistol_intro_anim_node);
  level.phone_kid_idle_cage02_model = scripts\engine\sp\utility::spawn_anim_model("phone_kid_idle_cage02", level.pistol_intro_anim_node.origin, level.pistol_intro_anim_node.angles);
  level.end_russian_truck_model = scripts\engine\sp\utility::spawn_anim_model("end_russian_truck", level.pistol_intro_anim_node.origin, level.pistol_intro_anim_node.angles);
  level.phone_kid_idle_child01_model hide();
  level.phone_kid_idle_child02_model hide();
  level.phone_kid_idle_child03_model hide();
  var_0 thread scripts\common\anim::anim_loop_solo(level.phone_kid_idle_child01_model, "phone_kid_truck02_idle");
  var_0 thread scripts\common\anim::anim_loop_solo(level.phone_kid_idle_child02_model, "phone_kid_truck02_idle");
  var_0 thread scripts\common\anim::anim_loop_solo(level.phone_kid_idle_child03_model, "phone_kid_truck02_idle");
  var_0 thread scripts\common\anim::anim_loop_solo(level.phone_kid_idle_cage02_model, "phone_kid_truck02_idle");
  var_0 thread scripts\common\anim::anim_loop_solo(level.end_russian_truck_model, "phone_kid_truck02_idle");
}

loading_kids_into_trucks_scene() {
  var_0 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_child("pistol_loading_boy03", level.pistol_intro_anim_node);
  var_1 = scripts\engine\sp\utility::spawn_anim_model("phone_kid_loading_truck", level.pistol_intro_anim_node.origin, level.pistol_intro_anim_node.angles);
  var_2 = scripts\engine\sp\utility::spawn_anim_model("phone_kid_loading_cage", level.pistol_intro_anim_node.origin, level.pistol_intro_anim_node.angles);
  var_3 = scripts\engine\sp\utility::spawn_anim_model("phone_kid_leaving_gateR", level.pistol_intro_anim_node.origin, level.pistol_intro_anim_node.angles);
  var_4 = scripts\engine\sp\utility::spawn_anim_model("phone_kid_leaving_gateL", level.pistol_intro_anim_node.origin, level.pistol_intro_anim_node.angles);
  thread dead_body_search_patrol();
  thread soldier_finds_pistol();
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(level.pistol_enemy_01_ai, "phone_kid_enter_idle");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(level.pistol_enemy_02_ai, "phone_kid_enter_idle");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(var_0, "phone_kid_enter_idle");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(var_1, "phone_kid_enter_idle");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(var_2, "phone_kid_enter_idle");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_first_frame_solo(var_3, "phone_kid_leaving");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_first_frame_solo(var_4, "phone_kid_leaving");
  scripts\engine\sp\utility::trigger_wait("pistol_start_trigger", "script_noteworthy");
  level.pistol_intro_anim_node_truck01 notify("stop_loop");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(level.pistol_enemy_01_ai, "phone_kid_loading");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(level.pistol_enemy_02_ai, "phone_kid_loading");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(var_0, "phone_kid_loading");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(var_2, "phone_kid_loading");
  level.pistol_intro_anim_node_truck01 scripts\common\anim::anim_single_solo(var_1, "phone_kid_loading");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(level.pistol_enemy_02_ai, "phone_kid_mid_idle");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(var_0, "phone_kid_mid_idle");
  thread audio_hometown_truck_kid_loaded_idle(var_1);
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(var_1, "phone_kid_mid_idle");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_loop_solo(var_2, "phone_kid_mid_idle");
  scripts\engine\sp\utility::trigger_wait("pistol_fight_start_trigger", "script_noteworthy");
  level.pistol_intro_anim_node_truck01 notify("stop_loop");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(var_3, "phone_kid_leaving");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(var_4, "phone_kid_leaving");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(level.pistol_enemy_02_ai, "phone_kid_leaving");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(var_0, "phone_kid_leaving");
  level.pistol_intro_anim_node_truck01 thread scripts\common\anim::anim_single_solo(var_2, "phone_kid_leaving");
  thread audio_hometown_truck_kid_loaded_leaving(var_1);
  level.pistol_intro_anim_node_truck01 scripts\common\anim::anim_single_solo(var_1, "phone_kid_leaving");
  var_0 delete();
  var_1 delete();
  var_2 delete();
}

audio_hometown_truck_kid_loaded_idle(var_0) {
  var_1 = spawn("script_origin", var_0.origin);
  var_2 = scripts\engine\utility::play_loopsound_in_space("scn_hometown_truck_kid_loaded_engine_idle_lp", var_0.origin);
  var_0 waittill("audio_truck_kid_loaded_leaving");
  var_2 thread scripts\engine\sp\utility::sound_fade_and_delete(1.5, 1);
  var_1 delete();
  var_1 = undefined;
}

audio_hometown_truck_kid_loaded_leaving(var_0) {
  var_0 notify("audio_truck_kid_loaded_leaving");
  thread audio_hometown_truck_kid_loaded_gate();
  var_0 thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_kid_loaded_engine_01");
  wait 9.122;
  var_0 thread scripts\engine\sp\utility::play_sound_on_entity("scn_hometown_truck_kid_loaded_engine_02");
}

audio_hometown_truck_kid_loaded_gate() {
  scripts\engine\utility::play_sound_in_space("scn_hometown_truck_kid_loaded_gate", (5930, -5092, -477));
}

player_gesture_cellphone_show() {
  wait 16.5;
  setsaveddvar("RMLOTKMMM", 0);
  var_0 = spawn("script_model", level.player.origin);
  var_0 setModel("offhand_vm_cellphone_old");
  var_0 notsolid();
  var_0 linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");
  level.player scripts\engine\sp\utility::player_gesture_force("ges_htf_phone_show");
  scripts\engine\utility::flag_set("lighting_cellphone_moment");
  wait 1.0;
  var_0 setModel("offhand_vm_cellphone_old_on");
  wait 1.5;
  setsaveddvar("NMLOKNMRSK", 0);
  var_0 delete();
  waitframe();
  level.player setsuit("iw8_kid");
  setsaveddvar("RMLOTKMMM", 1);
}

hadir_call_interact() {
  level endon("pistol_enemies_dead");
  level waittill("pistol_fight_start");
  level.hadir_interact = scripts\engine\utility::spawn_tag_origin(level.hadir_ai.origin);
  level.hadir_interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/CALL_HADIR", 360, 5000, 5000, 1);
  level.hadir_interact.origin = level.hadir_ai gettagorigin("j_helmet");
  level.hadir_interact.origin = level.hadir_interact.origin + (0, 0, 10);
  level.hadir_interact linkTo(level.hadir_ai, "j_helmet");

  for(;;) {
    level.hadir_interact waittill("trigger");
    level notify("interact_on_hadir");
    level.hadir_interact delete();
    level waittill("cell_available");
    level.hadir_interact = scripts\engine\utility::spawn_tag_origin(level.hadir_ai.origin);
    level.hadir_interact scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/CALL_HADIR", 360, 5000, 5000, 1);
    level.hadir_interact.origin = level.hadir_ai gettagorigin("j_helmet");
    level.hadir_interact.origin = level.hadir_interact.origin + (0, 0, 10);
    level.hadir_interact linkTo(level.hadir_ai, "j_helmet");
  }
}

player_fired_gun_monitor() {
  level endon("pistol_enemies_dead");
  level.player_fired_gun = 0;

  for(;;) {
    level.player waittill("weapon_fired");
    level.player_fired_gun = 1;
    wait 3.4;
    level.player_fired_gun = 0;
  }
}

player_gesture_cellphone_call() {
  level endon("pistol_enemies_dead");
  level waittill("pistol_fight_start");
  thread cellphone_hint();
  thread player_fired_gun_monitor();
  level.player scripts\engine\sp\utility::actionslotoverride(1, "hud_icon_equipment_cellphone", -1);
  level.player notifyonplayercommand("use_cellphone", "+actionslot 1");
  var_0 = 0;

  for(;;) {
    level.player waittill("use_cellphone");

    if(level.player_fired_gun) {
      continue;
    }
    setsaveddvar("RMLOTKMMM", 0);
    var_1 = spawn("script_model", level.player.origin);
    var_1 setModel("offhand_vm_cellphone_old");
    var_1 notsolid();
    var_1 linktoplayerview(level.player, "tag_accessory_left", (0, 0, 0), (0, 0, 0), 1, "none");

    if(isDefined(level.pistol_picked_up)) {
      level.player takeallweapons();
      level.player giveweapon("iw8_gunless_farrah");
      level.player switchtoweaponimmediate("iw8_gunless_farrah");

      while(nullweapon(level.player.currentweapon))
        waitframe();
    }

    level.player playSound("scn_hometown_cell_call_plr");
    level.player scripts\engine\sp\utility::player_gesture_force("ges_htf_phone_call");
    wait 1.0;
    var_1 setModel("offhand_vm_cellphone_old_on");
    wait 1.0;
    setsaveddvar("NMLOKNMRSK", 0);
    var_1 delete();
    level.hadir_ai playSound("scn_hometown_cell_call_hadir");

    if(isDefined(level.pistol_picked_up)) {
      level.player takeweapon("iw8_gunless_farrah");
      var_2 = scripts\sp\utility::make_weapon("iw8_pi_cpapa_farah_sp_a", ["ammo_cpapa", "front_cpapa", "rec_cpapa", "backno_cpapa"]);
      level.player giveweapon(var_2);
      level.player switchtoweapon(var_2);
    }

    var_3 = level.hadir_ai.origin;
    var_4 = level.hadir_ai.angles;
    var_5 = scripts\engine\utility::getclosest(level.hadir_ai.origin, scripts\engine\utility::getStructArray("cell_call_loc", "targetname"));
    thread set_pistol_interactable_before_anim();

    foreach(var_7 in level.pistol_enemies) {
      if(isalive(var_7))
        var_7 thread cellphone_react(var_5.origin);
    }

    wait 0.5;

    if(var_0 == 3) {
      level.hadir_ai thread scripts\sp\spawner::go_to_node(getnode("hadir_hide_node_d", "script_noteworthy"));
      var_0 = 0;
    } else if(var_0 == 2) {
      level.hadir_ai thread scripts\sp\spawner::go_to_node(getnode("hadir_hide_node_c", "script_noteworthy"));
      var_0++;
    } else if(var_0 == 1) {
      level.hadir_ai thread scripts\sp\spawner::go_to_node(getnode("hadir_hide_node_b", "script_noteworthy"));
      var_0++;
    } else if(var_0 == 0) {
      level.hadir_ai thread scripts\sp\spawner::go_to_node(getnode("hadir_hide_node_a", "script_noteworthy"));
      var_0++;
    }

    wait 2.0;
    setsaveddvar("RMLOTKMMM", 1);
    level notify("use_cellphone_finish");
  }
}

set_pistol_interactable_before_anim() {
  wait 0.1;
  level notify("pistol_can_interact");
}

cellphone_hint() {
  level.player endon("use_cellphone");
  level.player endon("death");
  var_0 = getEnt("farah_pistol_pickup", "script_noteworthy");

  if(!isDefined(var_0.cursor_hint_ent))
    level waittill("pistol_can_interact");

  scripts\engine\sp\utility::display_hint_forced("cell_hint", 10, 2, level.player, ["use_cellphone", "death"]);

  if(isDefined(level.hadir_icon_showing)) {
    if(!level.hadir_icon_showing) {
      var_1 = level.hadir_ai getentitynumber();
      setomnvar("ui_hadir_entnum", var_1);
    }
  } else {
    var_1 = level.hadir_ai getentitynumber();
    setomnvar("ui_hadir_entnum", var_1);
  }

  thread cellphone_hint_backup();
}

cellphone_hint_backup() {
  level.player endon("death");
  level endon("pistol_enemies_dead");
  level.cellphone_timer = 0;
  thread cellphone_hint_listener();

  while(level.cellphone_timer < 30) {
    wait 1.0;
    level.cellphone_timer = level.cellphone_timer + 1;
  }

  scripts\engine\sp\utility::display_hint_forced("cell_hint", 10, 2, level.player, ["use_cellphone", "death"]);
}

cellphone_hint_listener() {
  for(;;) {
    level.player waittill("use_cellphone");
    level.cellphone_timer = 0;
  }
}

cellphone_react(var_0) {
  self endon("death");

  if(self[[self.fnisinstealthcombat]]()) {
    if(isDefined(self.melee)) {
      return;
    }
    var_1 = self lastknownpos(level.player);
    var_1 = getclosestpointonnavmesh(var_1);
    self.dontevershoot = 1;
    level.player.ignoreme = 1;
    level.hadir_ai.ignoreme = 0;
    self getenemyinfo(level.hadir_ai);
    wait 2;
    self.dontevershoot = 0;
    level.hadir_ai.ignoreme = 1;
    level.player.ignoreme = 0;

    if(self cansee(level.player)) {
      self._blackboard.reacquiresteptime = 0;
      self getenemyinfo(level.player);
      self.lastenemysightpos = level.player getEye();
      return;
    }

    self cleargoalvolume();
    self.goalradius = 30;
    self setgoalpos(var_1);
    var_2 = scripts\engine\utility::waittill_any_return("known_event", "stealth_hunt", "goal");
    self setgoalvolumeauto(self.combat_volume);
    return;
  } else {
    level.hadir_ai.ignoreme = 0;
    waitframe();
    self aieventlistenerevent("cover_blown", level.hadir_ai, var_0);
    waitframe();
    level.hadir_ai.ignoreme = 1;
  }
}

player_take_cellphone() {
  level.player notify("player_take_cellphone");
}

hadir_go_to_vehicle() {
  level.hadir_vehicle_node_blocker = getEnt("hadir_vehicle_node_blocker", "script_noteworthy");
  level.hadir_vehicle_node_blocker scripts\engine\sp\utility::hide_entity();
  scripts\engine\sp\utility::waittill_dead_or_dying(level.pistol_enemies);

  if(getdvarint("greenlight") || getdvarint("greenlight_three_stab")) {
    return;
  }
  thread scripts\engine\sp\utility::autosave_by_name("pistol_enemies_dead");
  scripts\engine\utility::flag_set("objective_steal_the_vehicle");
  thread scripts\sp\analytics::analytics_kleenex_update("Pistol Fight End to Bunker End");
  level.hadir_vehicle_node_blocker scripts\engine\sp\utility::show_entity();
  level.hadir_ai.goalradius = 40;
  level.hadir_ai thread scripts\sp\spawner::go_to_node(getnode("hadir_vehicle_node", "script_noteworthy"));
  setomnvar("ui_hadir_entnum", -1);
  level notify("pistol_enemies_dead");
  level.pistol_enemies_dead = 1;
  level.player scripts\engine\sp\utility::actionslotoverrideremove(1);
}

car_interact() {
  level.pistol_enemies_dead = 0;

  if(getdvarint("greenlight") || getdvarint("greenlight_three_stab")) {
    return;
  }
  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/OPEN");
  var_1 = 0;

  while(!var_1) {
    var_0 waittill("trigger");

    if(!level.pistol_enemies_dead) {
      var_2 = scripts\engine\utility::getStruct("end_anim_node", "script_noteworthy");
      level.end_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", var_2.origin, var_2.angles);
      level.player_rig = level.end_player_model;
      var_2 scripts\sp\player_rig::link_player_to_rig("captured_jump_down", "stand", 1, 0.2, 0, 0, 0, 0, 0, 1);
      level.end_player_model setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
      wait 0.2;
      level.player scripts\engine\utility::delaycall(1, ::lerpviewangleclamp, 1, 0.5, 0.5, 40, 40, 40, 40);
      level notify("car_door_interacted_early");
      var_0 delete();
      var_2 scripts\common\anim::anim_single_solo(level.end_player_model, "captured_jump_down");
      scripts\sp\player_rig::unlink_player_from_rig(0, "stand");

      foreach(var_4 in level.pistol_enemies) {
        if(isalive(var_4)) {
          var_4 aieventlistenerevent("cover_blown", level.player, level.player.origin);
          wait 1.0;
          var_4 aieventlistenerevent("combat", level.player, level.player.origin);
        }
      }

      var_0 = scripts\engine\utility::spawn_tag_origin(self.origin);
      var_0 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/OPEN");
      continue;
    }

    level notify("car_door_interacted");
    var_0 delete();
    var_1 = 1;
  }
}

pistol_weapon_interact() {
  level waittill("pistol_can_interact");

  if(!getdvarint("scr_pistol_physics_hack_off"))
    thread pistol_physics_hack();

  scripts\engine\utility::flag_set("objective_get_the_pistol");
  scripts\sp\player\cursor_hint::create_cursor_hint("j_trigger", (0, 0, 0), &"HOMETOWN/PISTOL", undefined, undefined, 50, 0);
  var_0 = 0;

  while(var_0 == 0) {
    self waittill("trigger");
    scripts\engine\utility::flag_set("objective_shoot_the_soldiers");

    if(scripts\engine\sp\utility::player_has_weapon("iw8_pi_cpapa_farah_sp_a")) {
      iprintlnbold("Already Have Weapon");
      wait 1.0;
      scripts\sp\player\cursor_hint::create_cursor_hint("j_trigger", (0, 0, 0), &"HOMETOWN/PISTOL", undefined, undefined, undefined, 1);
      continue;
    } else
      var_0 = 1;
  }

  level.pistol_picked_up = 1;
  level.ctimetolose = 10000;
  level.cstillrighttheredistsq = 25;
  thread scripts\sp\analytics::analytics_kleenex_update("Got Pistol to Pistol Fight End");
  thread pistol_pickup_monitor();

  if(scripts\sp\autosave::autosavethreatcheck(1))
    thread scripts\engine\sp\utility::autosave_by_name("got_pistol");

  self delete();
}

pistol_physics_hack() {
  var_0 = -485.0;

  while(!isDefined(level.pistol_picked_up)) {
    var_1 = self.origin[2];

    if(var_1 < var_0) {
      if(isDefined(level.gun_launched))
        self physicsstopserver();

      self.origin = (5745.53, -4701.93, -459.768);
      self.angles = (2.07642, 329.303, -88.702);
      return;
    }

    waitframe();
  }
}

player_adsed_monitor() {
  level.player_adsed = 0;

  for(;;) {
    if(level.player adsButtonPressed()) {
      if(isDefined(level.pistol_picked_up)) {
        level.player_adsed = 1;
        return;
      }
    }

    waitframe();
  }
}

pistol_fight_death_monitor() {
  level.player waittill("death");

  if(isDefined(level.pistol_picked_up)) {
    if(!level.player_adsed)
      level scripts\sp\player_death::set_custom_death_quote(14);
    else
      level scripts\sp\player_death::set_custom_death_quote(81);
  } else
    level scripts\sp\player_death::set_custom_death_quote(82);
}

pistol_weapon_interact_b() {
  var_0 = scripts\engine\utility::spawn_tag_origin(self.origin);
  var_0 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/PISTOL", undefined, undefined, undefined, 1);
  var_1 = 0;

  while(var_1 == 0) {
    var_0 waittill("trigger");
    scripts\engine\utility::flag_set("objective_shoot_the_soldiers");

    if(scripts\engine\sp\utility::player_has_weapon("iw8_pi_cpapa_farah_sp_b")) {
      iprintlnbold("Already Have Weapon");
      wait 1.0;
      var_0 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"HOMETOWN/PISTOL", undefined, undefined, undefined, 1);
      continue;
    } else
      var_1 = 1;
  }

  var_0 delete();
  level.ctimetolose = 10000;
  level.cstillrighttheredistsq = 25;
  self delete();
}

give_pistol_ammo(var_0) {
  level endon("pistol_enemies_dead");
  level.player setweaponammostock(var_0, 12);

  for(;;) {
    var_1 = level.player getweaponammostock(var_0);

    if(var_1 < 6)
      level.player setweaponammostock(var_0, 12);

    waitframe();
  }
}

pistol_pickup_monitor() {
  level.player takeweapon("iw8_gunless_farrah");
  var_0 = scripts\sp\utility::make_weapon("iw8_pi_cpapa_farah_sp_a", ["ammo_cpapa", "front_cpapa", "rec_cpapa", "backno_cpapa"]);
  level.player giveweapon(var_0);
  level.player switchtoweapon(var_0);
  level.player thread adshint();
  level.player thread give_pistol_ammo(var_0);
  level.player thread scripts\sp\player\youngfarrah::weapcoltfireblur();
}

adshint() {
  self endon("stopYoungFarrahPistLogic");
  thread audio_farrah_cpapa_ads_handler();
  var_0 = 0;

  for(;;) {
    self waittill("weapon_fired");
    var_1 = self playerads();

    if(var_1 < 0.8)
      var_0++;
    else
      var_0 = 0;

    if(var_0 >= 2)
      scripts\engine\sp\utility::display_hint("ads", 5);
  }
}

audio_farrah_cpapa_ads_handler() {
  scripts\engine\utility::flag_init("aud_farrah_revolver_ads_started");
  var_0 = spawn("script_origin", self.origin);
  var_1 = spawn("script_origin", self.origin);
  level.aud_car_door_opened = 0;
  thread audio_truck_door_interaction_check();

  while(!level.aud_car_door_opened) {
    var_2 = self playerads();

    if(var_2 > 0 && !scripts\engine\utility::flag("aud_farrah_revolver_ads_started")) {
      scripts\engine\utility::flag_set("aud_farrah_revolver_ads_started");
      var_0 scalevolume(0.0, 0.0);
      var_0 playLoopSound("scn_hometown_farrah_revolver_ads_up_lp");
      var_0 scalevolume(1.0, 1.25);
    }

    if(var_2 == 0) {
      if(scripts\engine\utility::flag("aud_farrah_revolver_ads_started")) {
        var_0 scalevolume(0.0, 0.1);
        var_1 scalevolume(0.0, 0.0);
        var_1 playLoopSound("scn_hometown_farrah_revolver_ads_down_lp");
        var_1 scalevolume(1.0, 0.0);
        var_1 scalevolume(0.0, 0.4);
      }

      scripts\engine\utility::flag_clear("aud_farrah_revolver_ads_started");
    }

    wait 0.3;
  }

  scripts\engine\utility::flag_clear("aud_farrah_revolver_ads_started");
  var_0 delete();
  var_0 = undefined;
  var_1 delete();
  var_1 = undefined;
}

audio_truck_door_interaction_check() {
  level waittill("car_door_interacted");
  level.aud_car_door_opened = 1;
  wait 7.0;
  setmusicstate("mx_hometown_18_poppies_grab");
}

playerhaspistol() {
  return 1;
}

firepistolhint() {
  self endon("farrahFire");
  scripts\engine\utility::flag_init("flag_pistol_hint");
  thread watchplayerfiredpistol();
  thread watchplayerfailtoshoot();
  thread watchplayeradstoolong();
  self waittill("shouldHintFire");
  hintfirepistol();
}

watchplayerfailtoshoot() {
  self endon("shouldHintFire");
  self endon("farrahFire");

  for(var_0 = 0; var_0 < 3; var_0++) {
    while(!level.player buttonPressed("BUTTON_RTRIG"))
      wait 0.05;

    while(level.player buttonPressed("BUTTON_RTRIG"))
      wait 0.05;
  }

  self notify("shouldHintFire");
}

watchplayeradstoolong() {
  self endon("shouldHintFire");
  self endon("farrahFire");
  var_0 = 5;

  while(var_0 > 0) {
    var_1 = getaiarray("axis");

    if(level.player playerads() > 0) {
      var_2 = anglesToForward(level.player getplayerangles());
      var_3 = level.player getEye();
      var_4 = var_3 + var_2 * 1500;
      var_5 = scripts\engine\trace::create_contents(1, 0, 0, 0, 0, 0, 0, 0);
      var_6 = scripts\engine\trace::capsule_trace(var_3, var_4, 30, 60, (0, 0, 0), level.player, var_5);

      if(isDefined(var_6["entity"]) && isai(var_6["entity"]))
        var_0 = var_0 - 0.05;
    }

    wait 0.05;
  }

  self notify("shouldHintFire");
}

watchplayerfiredpistol() {
  self waittill("farrahFire");

  if(scripts\engine\utility::flag("flag_pistol_hint"))
    scripts\engine\utility::flag_clear("flag_pistol_hint");
}

hintfirepistol() {
  for(;;) {
    scripts\engine\utility::flag_set("flag_pistol_hint");
    scripts\engine\sp\utility::display_hint("hint_hold_fire");

    while(!level.player buttonPressed("BUTTON_RTRIG"))
      wait 0.05;

    scripts\engine\utility::flag_clear("flag_pistol_hint");

    while(level.player buttonPressed("BUTTON_RTRIG"))
      wait 0.05;

    wait 3;
  }
}

hintfirepistolcheck() {
  return !scripts\engine\utility::flag("flag_pistol_hint");
}

drive_main() {
  thread scripts\sp\maps\hometown\hometown_vo.gsc::drive_start_vo();
  var_0 = scripts\engine\utility::getStruct("end_anim_node", "script_noteworthy");
  level.end_player_model = scripts\engine\sp\utility::spawn_anim_model("hometown_player_rig", var_0.origin, var_0.angles);
  level.player_rig = level.end_player_model;
  var_0 scripts\sp\player_rig::link_player_to_rig("captured", "stand", 1, 0.3, 0, 0, 0, 0, 0, 1);
  level.end_player_model setModel(scripts\sp\maps\hometown\hometown_util.gsc::getfarrahbloodymodel());
  level.player scripts\engine\utility::delaycall(1, ::lerpfovscalefactor, 0, 0.5);
  level.player scripts\engine\utility::delaycall(1, ::lerpviewangleclamp, 1, 0.5, 0.5, 40, 40, 40, 40);
  level.player scripts\engine\utility::delaycall(10.0, ::playrumbleonentity, "heavy_1s");
  level.player scripts\engine\utility::delaycall(12.75, ::playrumbleonentity, "heavy_1s");
  level.player scripts\engine\utility::delaycall(31.5, ::playrumbleonentity, "heavy_1s");
  thread skippable_drive_scene();
  level.end_barkov_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_russian("barkov", var_0);
  level.end_russian_01_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_russian("end_russian_01", var_0);
  level.end_russian_02_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_russian("end_russian_02", var_0);
  level.end_russian_03_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_russian("end_russian_03", var_0);
  level.end_captive_01_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("end_captive_01", var_0);
  level.end_captive_02_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("end_captive_02", var_0);
  level.end_captive_03_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("end_captive_03", var_0);
  level.end_captive_04_model = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ_female("end_captive_04", var_0);
  level.end_captive_truck_model = scripts\engine\sp\utility::spawn_anim_model("end_captive_truck", var_0.origin, var_0.angles);
  level.end_prisoner_hood_model = scripts\engine\sp\utility::spawn_anim_model("captured_hood", var_0.origin, var_0.angles);
  level.end_barkov_model detachall();
  level.end_barkov_model setModel("body_villain_hometown_barkov");
  level.end_barkov_model attach("head_villain_barkov");
  level.end_barkov_model.anim_getrootfunc = scripts\asm\gesture\script_funcs::set_root;
  level.end_barkov_model.anin_playvo_func = scripts\engine\utility::playsoundontag;
  level.player scripts\engine\utility::delaycall(1, ::setclienttriggeraudiozone, "ht_poppyfields_pistol", 1.0);
  level.player takeallweapons();
  thread drive_black_fade();

  if(!getdvarint("scr_no_springcam"))
    level.player scripts\engine\utility::delaycall(1.0, ::springcamenabled, 0, 5, 5);

  level.phone_kid_idle_child01_model show();
  level.phone_kid_idle_child02_model show();
  level.phone_kid_idle_child03_model show();
  thread barkov_mayhem_end();
  level.pistol_intro_anim_node notify("stop_loop");
  level.pistol_intro_anim_node_truck notify("stop_loop");
  thread drive_cine_dof_settings();
  var_0 thread scripts\common\anim::anim_single_solo(level.phone_kid_idle_child01_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.phone_kid_idle_child02_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.phone_kid_idle_child03_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.phone_kid_idle_cage02_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_barkov_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_russian_01_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_russian_02_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_russian_03_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_captive_01_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_captive_02_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_captive_03_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_captive_04_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_captive_truck_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_russian_truck_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.end_prisoner_hood_model, "captured");
  var_0 thread scripts\common\anim::anim_single_solo(level.hadir_ai, "captured");
  var_0 scripts\common\anim::anim_single_solo(level.end_player_model, "captured");
  scripts\sp\utility::userskip_stop();
  wait 1.5;
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  waitframe();
  scripts\engine\sp\utility::teleport_player(scripts\engine\utility::getStruct("bunker_start", "targetname"));
}

drive_cine_dof_settings() {
  setsaveddvar("SLSMSSTQP", ".1");
  level scripts\engine\sp\utility::dof_enable(5.6, 10);
  level.hadir_ai scripts\engine\utility::delaythread(3, scripts\engine\sp\utility::dof_enable_autofocus, 2, 3, undefined, undefined, "tag_eye", undefined, 1);
  level.end_barkov_model scripts\engine\utility::delaythread(10, scripts\engine\sp\utility::dof_enable_autofocus, 2, 50, undefined, undefined, "tag_eye", undefined, 1);
  level.end_barkov_model scripts\engine\utility::delaythread(18, scripts\engine\sp\utility::dof_enable_autofocus, 2, 50, undefined, undefined, "j_spine4", undefined, 1);
  level.end_barkov_model scripts\engine\utility::delaythread(20.2, scripts\engine\sp\utility::dof_enable_autofocus, 2, 50, undefined, undefined, "tag_eye", undefined, 1);
  level.end_barkov_model scripts\engine\utility::delaythread(21, scripts\engine\sp\utility::dof_enable_autofocus, 2, 50, undefined, undefined, "j_spine4", undefined, 1);
  level.end_barkov_model scripts\engine\utility::delaythread(22, scripts\engine\sp\utility::dof_enable_autofocus, 2, 50, undefined, undefined, "tag_eye", undefined, 1);
  level.end_russian_03_model scripts\engine\utility::delaythread(28, scripts\engine\sp\utility::dof_enable_autofocus, 2, 50, undefined, undefined, "tag_eye", undefined, 1);
  level.end_russian_03_model scripts\engine\utility::delaythread(30, scripts\engine\sp\utility::dof_enable_autofocus, 2, 50, undefined, undefined, "j_spine4", undefined, 1);
  level.end_russian_03_model scripts\engine\utility::delaythread(31, scripts\engine\sp\utility::dof_enable_autofocus, 2, 50, undefined, undefined, "tag_eye", undefined, 1);
  level.hadir_ai scripts\engine\utility::delaythread(33, scripts\engine\sp\utility::dof_enable_autofocus, 2, 5, undefined, undefined, "tag_eye", undefined, 1);
  level.end_barkov_model scripts\engine\utility::delaythread(36, scripts\engine\sp\utility::dof_enable_autofocus, 2, 25, undefined, undefined, "j_knee_ri", undefined, 1);
  level.end_barkov_model scripts\engine\utility::delaythread(39.5, scripts\engine\sp\utility::dof_enable_autofocus, 2, 25, undefined, undefined, "j_spine4", undefined, 1);
  level.end_barkov_model scripts\engine\utility::delaythread(40.8, scripts\engine\sp\utility::dof_enable_autofocus, 2, 25, undefined, undefined, "tag_eye", undefined, 1);
  level.player scripts\engine\utility::delaycall(47, ::lerpviewangleclamp, 2, 0.5, 0.5, 0, 0, 0, 0);
  level scripts\engine\utility::delaythread(52, scripts\engine\sp\utility::dof_disable);
  wait 52;
  setsaveddvar("SLSMSSTQP", "9");
}

drive_caption_vo() {
  wait 6.0;
  iprintlnbold("HADIR: I'll drive!");
  wait 4.0;
  iprintlnbold("FARAH: *screams*");
  wait 5.0;
  iprintlnbold("HADIR: Farah!");
  wait 2.0;
  iprintlnbold("HADIR: No-! Get off me!-");
  wait 5.0;
  iprintlnbold("FARAH: No! Let go! Let go!");
  wait 5.0;
  iprintlnbold("RUSSIAN SOLDIER 4: Two more, General. They just took out K4 and 5.");
  wait 2.0;
  iprintlnbold("RUSSIAN SOLDIER 3: General Barkov. We caught them.");
  wait 12.0;
  iprintlnbold("BARKOV: So you're the little devils that killed my soldiers.");
  wait 6.0;
  iprintlnbold("BARKOV: Perfect.");
}

drive_black_fade() {
  level.bunker_gas_mask_overlay = scripts\sp\hud_util::create_client_overlay("gasmask_overlay_russian", 0.0);
  level.bunker_gas_mask_overlay.lowresbackground = 1;
  level.bunkerblackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level.bunkerblackoverlay.lowresbackground = 1;
  level waittill("hood_on_head");
  wait 0.2;
  level.player scripts\engine\utility::delaycall(1, ::setclienttriggeraudiozone, "fade_to_black_minus_scripted5_and_music", 0.2);
  level.bunkerblackoverlay fadeovertime(0.5);
  level.bunkerblackoverlay.alpha = 1.0;
  level.bunkerblackoverlay.sort = 1;
  wait 1.0;
  level.bunker_gas_mask_overlay fadeovertime(0.5);
  level.bunker_gas_mask_overlay.alpha = 1.0;
  level.bunker_gas_mask_overlay.sort = 0;
}

bunker_hint() {
  level.player endon("pressed_any_button");
  wait 15.0;
  scripts\engine\sp\utility::display_hint("rubble_hint", 10, 0, [level.player], ["pressed_any_button"]);
}

bunker_main() {
  scripts\engine\utility::flag_set("lighting_bunker_start");
  waitframe();
  alex_setup();
  thread bunker_hint();
  waitframe();
  scripts\engine\utility::flag_set("objective_return_to_base");
  setsaveddvar("MTLLLKROOM", 1);
  setsaveddvar("OMNONNMOTP", "0.1 400 1.5 1000");
  level.player scripts\engine\utility::delaycall(1, ::setclienttriggeraudiozone, "ht_bunker_ending", 5.0);
  level.player setentitysoundcontext("gender", "gasmask_male");
  level.player setstance("stand");
  var_0 = getspawner("bunker_farah", "script_noteworthy");
  var_1 = getspawner("bunker_price", "script_noteworthy");
  var_2 = getspawner("bunker_kyle", "script_noteworthy");
  var_3 = getspawner("bunker_alex", "script_noteworthy");
  var_4 = getspawner("bunker_rescue_soldier01", "script_noteworthy");
  var_5 = getspawner("bunker_rescue_soldier02", "script_noteworthy");
  var_6 = getspawner("bunker_kyleb", "script_noteworthy");
  var_7 = getspawner("bunker_rescue_soldier01b", "script_noteworthy");
  var_8 = getEnt("bunker_blima", "script_noteworthy");
  level.farah_ai = var_0 scripts\engine\sp\utility::spawn_ai(1);
  level.price_ai = var_1 scripts\engine\sp\utility::spawn_ai(1);
  level.kyle_ai = var_2 scripts\engine\sp\utility::spawn_ai(1);
  level.alex_ai = var_3 scripts\engine\sp\utility::spawn_ai(1);
  level.rescue_soldier01_ai = var_4 scripts\engine\sp\utility::spawn_ai(1);
  level.rescue_soldier02_ai = var_5 scripts\engine\sp\utility::spawn_ai(1);
  level.kyleb_ai = var_6 scripts\engine\sp\utility::spawn_ai(1);
  level.rescue_soldier01b_ai = var_7 scripts\engine\sp\utility::spawn_ai(1);
  waitframe();
  level.farah_ai.animname = "farah";
  level.price_ai.animname = "price";
  level.kyle_ai.animname = "kyle";
  level.alex_ai.animname = "alex";
  level.rescue_soldier01_ai.animname = "rescue_scene_soldier01";
  level.rescue_soldier02_ai.animname = "rescue_scene_soldier02";
  level.kyleb_ai.animname = "kyleb";
  level.rescue_soldier01b_ai.animname = "rescue_scene_soldier01b";
  var_8 scripts\engine\sp\utility::assign_animtree("rescue_scene_blima");
  var_8 setscriptablepartstate("engine", "on");
  level.farah_ai.script_friendname = "";
  level.price_ai.script_friendname = "";
  level.kyle_ai.script_friendname = "";
  level.alex_ai.script_friendname = "";
  level.rescue_soldier01_ai.script_friendname = "";
  level.rescue_soldier02_ai.script_friendname = "";
  level.kyleb_ai.script_friendname = "";
  level.rescue_soldier01b_ai.script_friendname = "";
  level.farah_ai.name = "";
  level.price_ai.name = "";
  level.kyle_ai.name = "";
  level.alex_ai.name = "";
  level.rescue_soldier01_ai.name = "";
  level.rescue_soldier02_ai.name = "";
  level.kyleb_ai.name = "";
  level.rescue_soldier01b_ai.name = "";
  waitframe();
  level.farah_ai scripts\common\ai::gun_remove();
  level.kyle_ai scripts\common\ai::gun_remove();
  level.kyleb_ai scripts\common\ai::gun_remove();
  level.alex_ai scripts\common\ai::gun_remove();
  level.rescue_soldier02_ai scripts\common\ai::gun_remove();
  level.rescue_soldier01b_ai.anim_playvo_func = ::empty_vo_func;
  var_9 = scripts\engine\utility::getStruct("bunker_anim_node_main", "script_noteworthy");
  level.bunker_player_model = scripts\engine\sp\utility::spawn_anim_model("bunker_player_rig", var_9.origin, var_9.angles);
  var_10 = scripts\engine\sp\utility::spawn_anim_model("rescue_scene_gasmask_alex", var_9.origin, var_9.angles);
  var_11 = scripts\engine\sp\utility::spawn_anim_model("rescue_scene_gasmask", var_9.origin, var_9.angles);
  level.player_rig = level.bunker_player_model;
  var_9 scripts\sp\player_rig::link_player_to_rig("bunker_getup", "stand", 0, undefined, 0, 15, 15, 15, 15, 1);

  if(!getdvarint("scr_no_springcam"))
    level.player springcamenabled(0, 5, 5);

  thread cine_idle_bunker_dof();
  thread bunker_black_fade();
  level.price_ai hide();
  level.kyle_ai hide();
  level.alex_ai hide();
  level.rescue_soldier01_ai hide();
  level.rescue_soldier02_ai hide();
  level.kyleb_ai hide();
  level.rescue_soldier01b_ai hide();
  var_9 thread scripts\common\anim::anim_loop_solo(level.farah_ai, "bunker_getup_idle");
  var_9 thread scripts\common\anim::anim_loop_solo(level.bunker_player_model, "bunker_getup_idle");
  var_9 thread scripts\common\anim::anim_loop_solo(var_10, "bunker_getup_idle");
  var_9 thread scripts\common\anim::anim_loop_solo(var_11, "bunker_getup_idle");
  var_11 hide();
  level.farah_ai attach("hat_hero_farah_sas_gasmask");
  wait 3.0;

  if(!scripts\engine\utility::flag("disable_autosaves"))
    thread scripts\engine\sp\utility::autosave_now();

  scripts\sp\maps\hometown\hometown_util.gsc::wait_any_input();
  thread skippable_bunker_ending();
  level.player notify("pressed_any_button");
  level.player scripts\engine\utility::delaycall(1.0, ::lerpviewangleclamp, 1.0, 0.5, 0.5, 15, 15, 15, 15);
  thread bunker_black_bars();
  thread bunker_remove_gas_mask();
  thread sfx_bunker_heli_outro();
  thread farah_gasmask_swap(var_11);
  level.price_ai scripts\engine\utility::delaycall(0.5, ::show);
  level.kyle_ai scripts\engine\utility::delaycall(0.5, ::show);
  level.alex_ai scripts\engine\utility::delaycall(0.5, ::show);
  level.rescue_soldier01_ai scripts\engine\utility::delaycall(0.5, ::show);
  level.rescue_soldier02_ai scripts\engine\utility::delaycall(0.5, ::show);
  level.kyleb_ai scripts\engine\utility::delaycall(18.0, ::show);
  level.rescue_soldier01b_ai scripts\engine\utility::delaycall(18.0, ::show);
  level.rescue_soldier01_ai scripts\engine\utility::delaycall(18.0, ::hide);
  level.price_ai.anim_playvo_func = scripts\engine\utility::playsoundontag;
  level.farah_ai.anim_playvo_func = scripts\engine\utility::playsoundontag;
  level.kyleb_ai.anim_playvo_func = scripts\engine\utility::playsoundontag;
  var_9 notify("stop_loop");
  scripts\engine\utility::flag_set("lighting_bunker_exit");
  thread bunker_cine_dof_settings();
  var_9 thread scripts\common\anim::anim_single_solo(var_8, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(var_10, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(var_11, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(level.price_ai, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(level.farah_ai, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(level.kyle_ai, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(level.alex_ai, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(level.rescue_soldier01_ai, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(level.rescue_soldier02_ai, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(level.kyleb_ai, "bunker_getup");
  var_9 thread scripts\common\anim::anim_single_solo(level.rescue_soldier01b_ai, "bunker_getup");
  var_9 scripts\common\anim::anim_single_solo(level.bunker_player_model, "bunker_getup");
  var_9 scripts\common\anim::anim_last_frame_solo(level.bunker_player_model, "bunker_getup");
  level.player unlink();
  var_12 = level.bunker_player_model scripts\engine\utility::getanim("bunker_getup_b");
  var_13 = getstartorigin(var_9.origin, var_9.angles, var_12);
  var_14 = getstartangles(var_9.origin, var_9.angles, var_12);
  level.player setOrigin(var_13);
  level.player setplayerangles(var_14);
  var_9 scripts\common\anim::anim_first_frame_solo(level.bunker_player_model, "bunker_getup_b");
  level.player playerlinktoabsolute(level.bunker_player_model, "tag_player");
  var_9 notify("stop_first_frame");
  var_9 scripts\common\anim::anim_single_solo(level.bunker_player_model, "bunker_getup_b");
  wait 5;
  scripts\engine\sp\utility::nextmission();
}

empty_vo_func(var_0, var_1, var_2) {}

bunker_cine_dof_settings() {
  level.farah_ai scripts\engine\sp\utility::dof_enable_autofocus(2, 50, undefined, undefined, "tag_eye", undefined, 1);
  wait 5;
  level.alex_ai scripts\engine\sp\utility::dof_enable_autofocus(2, 50, undefined, undefined, "tag_hand", undefined, 1);
  wait 5;
  level.farah_ai scripts\engine\sp\utility::dof_enable_autofocus(2, 50, undefined, undefined, "tag_eye", undefined, 1);
  wait 4;
  level.kyle_ai scripts\engine\sp\utility::dof_enable_autofocus(1.4, 50, undefined, undefined, "tag_eye", undefined, 1);
  wait 5;
  level.farah_ai scripts\engine\sp\utility::dof_enable_autofocus(1.2, 50, undefined, undefined, "tag_eye", undefined, 1);
  wait 17;
  scripts\engine\sp\utility::dof_disable();
}

cine_idle_bunker_dof() {
  level.farah_ai scripts\engine\sp\utility::dof_enable_autofocus(1.5, 50, undefined, undefined, "tag_eye", undefined, 1);
}

skippable_bunker_ending() {
  var_0 = scripts\sp\utility::userskip_wait();

  if(!var_0) {
    return;
  }
  scripts\sp\hud_util::fade_out(0);
  scripts\engine\sp\utility::nextmission();
}

farah_gasmask_swap(var_0) {
  wait 6.0;
  var_0 show();
  level.farah_ai detach("hat_hero_farah_sas_gasmask");
}

player_cinematic_swap(var_0, var_1) {
  var_2 = scripts\engine\utility::getanim(var_1 + "_b");
  var_3 = getstartorigin(var_0.origin, var_0.angles, var_2);
  var_4 = getstartangles(var_0.origin, var_0.angles, var_2);
  var_0 scripts\common\anim::anim_single_solo(self, var_1);
  var_0 scripts\common\anim::anim_last_frame_solo(self, var_1);
  level.player unlink();
  level.player setOrigin(var_3);
  level.player setplayerangles(var_4);
  var_0 scripts\common\anim::anim_first_frame_solo(self, var_1 + "_b");
  level.player playerlinktoabsolute(self, "tag_player");
  var_0 notify("stop_first_frame");
  var_0 scripts\common\anim::anim_single_solo(self, var_1 + "_b");
}

bunker_black_bars() {
  wait(getanimlength(level.scr_anim["bunker_player_rig"]["bunker_getup"]) - 2.0);
  hidecinematicletterboxing(2.0, 0);
}

bunker_remove_gas_mask() {
  wait 9.0;
  level.bunker_gas_mask_overlay fadeovertime(1.5);
  level.bunker_gas_mask_overlay.alpha = 0.0;
}

bunker_caption_vo() {
  wait 12.0;
  iprintlnbold("ALEX: Captain!");
  wait 2.0;
  iprintlnbold("KYLE: You alright...?");
  wait 2.0;
  iprintlnbold("ALEX: Been better...");
  wait 2.0;
  iprintlnbold("FARAH: Where is he...?!");
  wait 2.0;
  iprintlnbold("ALEX: He's gone Farah...");
  wait 2.0;
  iprintlnbold("FARAH: No... Hadir... HADIR!!");
  wait 2.0;
  iprintlnbold("FARAH: You dirty fucking terrorist DOG!!");
  wait 2.0;
  iprintlnbold("FARAH: WHERE ARE YOU?!");
  wait 2.0;
  iprintlnbold("PRICE: Stop it, Farah. STOP!");
  wait 2.0;
  iprintlnbold("FARAH: It was Hadir, Captain... Hadir is the thief...");
  wait 2.0;
  iprintlnbold("FARAH: I'm sorry, Captain... I didn't know...");
  wait 2.0;
  iprintlnbold("PRICE: No way you could have.");
  wait 2.0;
  iprintlnbold("ALEX: It's okay, Farah, we'll get him.");
  wait 2.0;
  iprintlnbold("PRICE: We need to un-ass this target. NOW!");
  wait 2.0;
  iprintlnbold("PRICE: Load in... Let's go!");
}

sfx_bunker_heli_outro() {
  level waittill("sfx_heli_outro_start");
  level.player scripts\engine\utility::delaycall(15, ::setclienttriggeraudiozone, "ht_bunker_ending_ext", 5.0);
  var_0 = spawn("script_origin", (-740, 140, -16246));
  var_1 = spawn("script_origin", (-740, 140, -16246));
  var_0 playSound("scn_hometown_bunker_heli_01");
  var_1 playLoopSound("scn_hometown_bunker_heli_idle_wind_lp");
  level waittill("sfx_fade_out");
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 2.0);
  var_1 scripts\engine\sp\utility::sound_fade_and_delete(0.1, 1);
  thread bunker_outro_fade();
}

bunker_outro_fade() {
  level.bunkeroutroblackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  wait 4;
  level.bunkeroutroblackoverlay fadeovertime(3.0);
  level.bunkeroutroblackoverlay.alpha = 1;
}

bunker_black_fade() {
  wait 4.0;

  if(isDefined(level.drive_skip_blackoverlay))
    level.drive_skip_blackoverlay.alpha = 0;

  level.bunkerblackoverlay fadeovertime(4.0);
  level.bunkerblackoverlay.alpha = 0;
  wait 5.0;
  level.bunkerblackoverlay destroy();
}

alex_setup() {
  scripts\sp\player\youngfarrah::setplayerviewmodel("viewhands_alex_fullbody", undefined, "default_character_shadow");
  level.player enableweapons();
  level.player setsuit("iw8_defaultsuit");
  level.player takeallweapons();
  level.player giveweapon("iw8_gunless");
  level.player switchtoweapon("iw8_gunless");
  level.player modifybasefov(65, 0.05);
  setsaveddvar("NKTRSSTMRQ", 0.0);
  setsaveddvar("LSOPQMRPNR", 0.0);
  setsaveddvar("MLTTMLTKOR", 0.0);
  level.player scripts\sp\utility::allow_cg_drawcrosshair(0);
  level.player scripts\common\utility::allow_weapon_pickup(0);
  level.player setmovespeedscale(0.1);
  level.player.movespeedscale = 0.1;
  level.player modifybasefov(65, 0.05);
  level.player thread scripts\sp\player::remove_all_armor();
  thread scripts\sp\player::disable_player_weapon_info();
}

#using_animtree("generic_human");

hadir_remove_mask_gesture() {
  level.hadir_ai setanim(%htf_hadir_maskoff, 1.0);
  thread remove_gas_mask();
  wait 2.25;
  thread launch_mask();
  level notify("hadir_beckon_loop_restart");
  level.hadir_ai clearanim(%scripted_overlays, 0.2);
}

launch_mask() {
  var_0 = level.hadir_ai gettagangles("j_gasmask_1");
  var_1 = level.hadir_ai gettagorigin("j_gasmask_1");
  var_2 = spawn("script_model", var_1);
  var_2 setModel("hat_child_hadir_gas_mask_wm");
  var_2.angles = var_0;
  var_3 = anglesToForward(var_0);
  var_3 = var_3 * randomfloatrange(20, 25) * -1;
  var_4 = var_3[0];
  var_5 = 10;
  var_6 = 50;
  var_2 physicslaunchserver(var_2.origin, (var_4, var_5, var_6));
  level.hadir_ai detach("hat_child_hadir_gas_mask");
}

gas_mask_remove_trigger_monitor() {
  thread suspend_beckon_poppies_start();
  scripts\engine\sp\utility::trigger_wait("gas_mask_remove_trigger", "script_noteworthy");
  wait 2.0;
  scripts\engine\utility::flag_set("gas_mask_remove_flag");
}

suspend_beckon_poppies_start() {
  wait 1.0;
  level notify("hadir_beckon_loop_suspend");
}

hadir_duck() {
  scripts\engine\utility::flag_wait("gas_mask_remove_flag");
  thread hadir_remove_mask_gesture();
}

truck_setup() {
  level endon("vehicle_truck_spawned");
  level.trafficking_truck_vehicle = scripts\engine\sp\utility::spawn_anim_model("trafficking_truck_01", level.trafficking_anim_node.origin, level.trafficking_anim_node.angles);
  level.trafficking_anim_node scripts\common\anim::anim_single_solo(level.trafficking_truck_vehicle, "trafficked_scene");
}

truck_delete() {
  scripts\engine\sp\utility::trigger_wait("trafficking_truck_poppies_spawn", "script_noteworthy");
  level.trafficking_truck_vehicle delete();
  level notify("vehicle_truck_spawned");
}

#using_animtree("script_model");

soldier_finds_pistol() {
  level.pistol_enemy_01_ai endon("stealth_combat");
  level.pistol_enemy_01_ai endon("stealth_investigate");
  level.pistol_enemy_01_ai endon("death");
  level.pistol_enemy_01_ai thread search_cleanup();
  var_0 = scripts\engine\utility::getStruct("dead_body_search_node_d", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("dead_body_search_node_e", "script_noteworthy");
  var_2 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("dead_body_c", var_0);
  var_3 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("dead_body_d", var_1);
  var_2 scriptmoverdistancefade();
  var_3 scriptmoverdistancefade();
  var_0 scripts\common\anim::anim_first_frame_solo(var_2, "search_body_c");
  var_1 scripts\common\anim::anim_first_frame_solo(var_3, "search_body_d");
  var_4 = scripts\engine\utility::getStruct("soldier_finds_pistol_anim_node", "script_noteworthy");
  var_5 = getEnt("farah_pistol_pickup", "script_noteworthy");
  var_5 setModel("weapon_wm_pi_cpapa");
  var_5 attach("attachment_wm_pi_cpapa_receiver");
  var_5 attach("attachment_wm_pi_cpapa_barrel");
  var_5.animname = "soldier_finds_pistol_gun";
  var_5 useanimtree(#animtree);
  var_6 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("soldier_finds_pistol_body", var_4, 1);
  var_6 scriptmoverdistancefade();
  var_4 thread scripts\common\anim::anim_first_frame_solo(var_6, "soldier_finds_pistol_intro");
  var_4 thread scripts\common\anim::anim_first_frame_solo(var_5, "soldier_finds_pistol_intro");
  scripts\engine\sp\utility::trigger_wait("pistol_start_trigger", "script_noteworthy");
  level.pistol_enemy_01_ai.radius = 4;
  level.pistol_enemy_01_ai.animents = [var_5, var_6];
  var_4 scripts\sp\anim::anim_reach_and_approach_solo(level.pistol_enemy_01_ai, "soldier_finds_pistol_intro");
  var_4 scripts\sp\anim::anim_react(level.pistol_enemy_01_ai, "soldier_finds_pistol", ::soldier_finds_pistol_react);
  level.pistol_enemy_01_ai.animents = undefined;
  scripts\engine\sp\utility::trigger_wait("pistol_fight_start_trigger", "script_noteworthy");
  var_1 scripts\sp\anim::anim_reach_and_approach_solo(level.pistol_enemy_01_ai, "search_body_d_intro");
  var_1 thread scripts\common\anim::anim_single_solo(var_3, "search_body_d");
  var_1 scripts\sp\anim::anim_react([level.pistol_enemy_01_ai], "search_body_d");
  wait 3.0;
  var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.pistol_enemy_01_ai, "search_body_c_intro");
  var_0 thread scripts\common\anim::anim_single_solo(var_2, "search_body_c");
  var_0 scripts\sp\anim::anim_react([level.pistol_enemy_01_ai], "search_body_c");
  level.pistol_enemy_01_ai notify("done_searching");
}

soldier_finds_pistol_react(var_0) {
  var_1 = getEnt("farah_pistol_pickup", "script_noteworthy");
  var_1 scripts\engine\sp\utility::anim_stopanimScripted();

  if(!isDefined(var_1.cursor_hint_ent) && scripts\engine\utility::flag("enemy_picked_up_pistol")) {
    var_2 = anglesToForward(level.pistol_enemy_01_ai.angles);
    var_3 = anglestoup(level.pistol_enemy_01_ai.angles);
    var_4 = var_2 * 200 + var_3 * -100;
    level.gun_launched = 1;
    var_1 physicslaunchserver(var_1 gettagorigin("j_trigger"), var_4);
  }

  level notify("pistol_can_interact");
  return "skip_reaction";
}

dead_body_search_patrol() {
  level.pistol_enemy_02_ai endon("stealth_combat");
  level.pistol_enemy_02_ai endon("stealth_investigate");
  level.pistol_enemy_02_ai endon("death");
  level.pistol_enemy_02_ai thread search_cleanup();
  var_0 = scripts\engine\utility::getStruct("dead_body_search_node_a", "script_noteworthy");
  var_1 = scripts\engine\utility::getStruct("dead_body_search_node_b", "script_noteworthy");
  var_2 = scripts\engine\utility::getStruct("dead_body_search_node_c", "script_noteworthy");
  var_3 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("dead_body_a", var_0);
  var_4 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("dead_body_b", var_1);
  var_5 = scripts\sp\maps\hometown\hometown_util.gsc::make_script_model_civ("dead_body_e", var_2);
  var_3 scriptmoverdistancefade();
  var_4 scriptmoverdistancefade();
  var_5 scriptmoverdistancefade();
  var_0 scripts\common\anim::anim_first_frame_solo(var_3, "search_body_a");
  var_1 scripts\common\anim::anim_first_frame_solo(var_4, "search_body_b");
  var_2 scripts\common\anim::anim_first_frame_solo(var_5, "search_body_e");
  scripts\engine\sp\utility::trigger_wait("pistol_fight_start_trigger", "script_noteworthy");
  level.pistol_intro_anim_node_truck01 notify("stop_loop");
  var_0 scripts\sp\anim::anim_reach_and_approach_solo(level.pistol_enemy_02_ai, "search_body_a_intro");
  var_0 thread scripts\common\anim::anim_single_solo(var_3, "search_body_a");
  var_0 scripts\sp\anim::anim_react([level.pistol_enemy_02_ai], "search_body_a");
  wait 3.0;
  var_1 scripts\sp\anim::anim_reach_and_approach_solo(level.pistol_enemy_02_ai, "search_body_b_intro");
  var_1 thread scripts\common\anim::anim_single_solo(var_4, "search_body_b");
  var_1 scripts\sp\anim::anim_react([level.pistol_enemy_02_ai], "search_body_b");
  wait 3.0;
  var_2 scripts\sp\anim::anim_reach_and_approach_solo(level.pistol_enemy_02_ai, "search_body_e_intro");
  var_2 thread scripts\common\anim::anim_single_solo(var_5, "search_body_e");
  var_2 scripts\sp\anim::anim_react([level.pistol_enemy_02_ai], "search_body_e");
  level.pistol_enemy_02_ai notify("done_searching");
}

search_cleanup() {
  self endon("death");
  self endon("done_searching");
  scripts\engine\utility::waittill_any("stealth_investigate", "stealth_combat");
  scripts\sp\anim::anim_reach_cleanup_solo(self);
}

greenlight_mission_end_monitor() {
  level.greenlight_end_blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 0);
  level waittill("player_fired_gun");
  wait 0.2;
  level.player setclientomnvar("ui_hide_full_hud", 1);
  level.greenlight_end_blackoverlay.alpha = 1.0;
  level.greenlight_end_blackoverlay.sort = 0;
  level.greenlight_end_blackoverlay.foreground = 1;

  if(isalive(level.pistol_enemy_01_ai))
    level.pistol_enemy_01_ai delete();

  if(isalive(level.pistol_enemy_02_ai))
    level.pistol_enemy_02_ai delete();

  if(isalive(level.hadir_ai))
    level.hadir_ai delete();

  wait 0.25;
  setmusicstate("");
  level.player setclienttriggeraudiozone("fade_to_black_minus_scripted5_and_music", 0.4);
  wait 0.25;
}

#using_animtree("generic_human");

hadir_mayhem_phone() {
  if(!getdvarint("scr_no_pistol_mayhem")) {
    level waittill("mayhem_hadir_start");
    level.hadir_ai detach("head_sc_m_coto");
    level.hadir_ai setanim(%htf_pop_030_phone_scene_hadir_face, 1.0, 0.0, 1.0);
    level waittill("mayhem_hadir_end");
    level.hadir_ai setanim(%htf_pop_030_phone_scene_hadir_face, 0.0, 0.0, 1.0);
    level.hadir_ai attach("head_sc_m_coto");
  }
}

dying_boy_face() {
  level endon("poppies_start");
  level waittill("dying_boy_gasps_playing");

  for(;;) {
    level.pipe_dying_boy setanim(%htf_esc_010_boy_dead_face);
    wait(getanimlength(%htf_esc_010_boy_dead_face));
  }
}

barkov_mayhem_end() {
  level.barkov_has_no_head = 0;

  if(!getdvarint("scr_no_pistol_mayhem")) {
    level waittill("mayhem_start_02_barkov");
    level.barkov_has_no_head = 1;
    level.end_barkov_model detach("head_villain_barkov");
    level.end_barkov_model setanim(%htf_pop_050_captured_barkov_face_02, 1.0, 0.0, 1.0);
    level waittill("mayhem_end_02_barkov");
    level.barkov_has_no_head = 0;
    level.end_barkov_model setanim(%htf_pop_050_captured_barkov_face_02, 0.0, 0.0, 1.0);
    level.end_barkov_model attach("head_villain_barkov");
    level waittill("mayhem_start_barkov");
    level.barkov_has_no_head = 1;
    level.end_barkov_model detach("head_villain_barkov");
    level.end_barkov_model setanim(%htf_pop_050_captured_barkov_face, 1.0, 0.0, 1.0);
    level waittill("mayhem_end_barkov");
    level.barkov_has_no_head = 0;
    level.end_barkov_model setanim(%htf_pop_050_captured_barkov_face, 0.0, 0.0, 1.0);
    level.end_barkov_model attach("head_villain_barkov");
  }
}

skippable_drive_scene() {
  wait 1.0;
  var_0 = scripts\sp\utility::userskip_wait();

  if(!var_0) {
    return;
  }
  level notify("hood_on_head");
  level notify("drive_start_vo_kill");

  if(level.barkov_has_no_head) {
    level.end_barkov_model setanim(%htf_pop_050_captured_barkov_face, 0.0, 0.0, 1.0);
    level.end_barkov_model attach("head_villain_barkov");
  }

  var_1 = scripts\engine\utility::getStruct("end_anim_node", "script_noteworthy");
  level.pistol_intro_anim_node notify("stop_loop");
  level.pistol_intro_anim_node_truck notify("stop_loop");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.phone_kid_idle_child01_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.phone_kid_idle_child02_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.phone_kid_idle_child03_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.phone_kid_idle_cage02_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_barkov_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_russian_01_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_russian_02_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_russian_03_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_captive_01_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_captive_02_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_captive_03_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_captive_04_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_captive_truck_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_russian_truck_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_prisoner_hood_model, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.hadir_ai, "captured");
  var_1 thread scripts\common\anim::anim_last_frame_solo(level.end_player_model, "captured");
  level.drive_skip_blackoverlay = scripts\sp\hud_util::create_client_overlay("black", 1.0);
  level.player scripts\sp\player_rig::unlink_player_from_rig(0, "stand");
  waitframe();
  scripts\engine\sp\utility::teleport_player(scripts\engine\utility::getStruct("bunker_start", "targetname"));
}