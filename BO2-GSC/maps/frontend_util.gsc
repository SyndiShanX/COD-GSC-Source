/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\frontend_util.gsc
**************************************/

#include maps\_dialog;
#include maps\_objectives;
#include maps\_scene;
#include maps\_utility;
#include maps\_endmission;
#include common_scripts\utility;
#include maps\war_room_util;
#include maps\_music;
#include maps\_anim;
#include maps\_patrol;
#include maps\_glasses;
#include maps\frontend_sf_a;
#include maps\frontend_sf_b;
#include maps\frontend_sf_c;
#include maps\createart\frontend_art;
#include maps\_vehicle;
#include maps\_osprey;

setup_basic_scene() {
  ambient_scene_list = [];

  for(i = 1; i <= 5; i++)
    ambient_scene_list[ambient_scene_list.size] = "ambient_0" + i;

  if(!isDefined(level.m_bridge_workers)) {
    level.m_bridge_workers = [];
    num_worker_scenes = 3;

    if(randomfloat(2.0) <= 1.0)
      num_worker_scenes = 4;

    for(i = 0; i < num_worker_scenes; i++) {
      ambient_scene = random(ambient_scene_list);
      arrayremovevalue(ambient_scene_list, ambient_scene);
      level thread run_scene(ambient_scene);
      drone_list = get_model_or_models_from_scene(ambient_scene);
      level.m_bridge_workers = arraycombine(level.m_bridge_workers, drone_list, 1, 0);
    }
  }

  level_num = get_level_number_completed();
  setup_war_map(level_num + 1);
  level_list = get_strikeforce_available_level_list(level_num + 1);

  if(get_campaign_state() != 0 && (level_list.size != 0 || frontend_just_finished_rts()))
    level thread run_scene("sf_briggs_idle");

  use_vtol = frontend_should_use_vtol(level_num + 1);

  if(use_vtol) {
    if(!isDefined(level.vtol_scene_running)) {
      level thread run_scene("vtol_ambient_00");
      level.vtol_scene_running = 1;
    }

    warp_to_player_start("vtol_player_start");
    frontend_run_ospreys();

    if(level.menustate == 0) {
      level.menustate = 1;
      toggle_main_menu();
    }
  } else if(get_campaign_state() == 0 || level_num == 0)
    warp_to_player_start();
  else
    warp_to_random_player_start();

  if(is_true(level.player.is_glove_shown)) {
    player_body = getent("player_body", "targetname");
    old_blend_time = 0.1;

    if(isDefined(player_body)) {
      old_blend_time = player_body._anim_blend_in_time;
      player_body maps\_anim::anim_set_blend_in_time(0.1);
    }

    end_scene("data_glove_idle");
    wait_network_frame();
    level thread run_scene("data_glove_idle");
    wait 0.1;

    if(isDefined(player_body))
      player_body maps\_anim::anim_set_blend_in_time(old_blend_time);
  }

  wait_network_frame();
  show_globe(1, 0, 1);
  show_holotable_fuzz(0);

  if(get_campaign_state() != 0) {
    if(frontend_just_finished_rts())
      level thread frontend_rts_level_respond();
  }
}

frontend_rts_level_respond() {
  run_scene_first_frame("player_look_at_war_map");
  level thread run_scene("sf_briggs_idle");
  flag_wait("strikeforce_stats_loaded");
  last_level = get_level_number_completed();
  cur_level = last_level + 1;
  map_list = get_strikeforce_available_level_list(cur_level);
  last_map = getdvar(#"_id_D614D075");
  success = rts_map_completed(last_map);
  color_id = 2;

  if(success)
    color_id = 3;

  warmap_offset = level.m_rts_warmap_offset[last_map];
  map_id = level.m_rts_map_id[last_map];

  if(isDefined(map_id)) {
    set_world_map_marker(map_id, 1);
    set_world_map_widget(map_id, 0);
    level thread war_map_blink_country(map_id, color_id, "stop_war_blink");
  }

  if(isDefined(warmap_offset))
    world_map_zoom_to(warmap_offset[0], warmap_offset[1], warmap_offset[2]);

  positive_lines = array("brig_nice_work_mason_0", "brig_i_knew_i_could_rely_0", "brig_hell_of_a_job_there_0", "brig_that_s_what_i_like_t_0", "brig_that_s_how_we_get_sh_0", "brig_that_was_one_for_the_0");
  negative_lines = array("brig_what_the_fuck_was_th_0", "brig_i_ve_never_seen_such_0", "brig_that_was_a_full_scal_0", "brig_what_the_hell_went_w_0", "brig_we_ll_talk_about_thi_0", "brig_i_m_disappointed_and_0");
  response_line = undefined;

  if(success)
    response_line = random(positive_lines);
  else
    response_line = random(negative_lines);

  if(isDefined(response_line))
    level.player thread say_dialog(response_line, 2.0);

  wait 2.0;
  run_scene("player_look_at_war_map");
  level notify("stop_war_blink");

  if(isDefined(map_id)) {
    set_world_map_marker(map_id, 0);

    if(!success)
      set_world_map_widget(map_id, 1);
  }

  world_map_zoom_to(0.0, 0.0, 1.0);
  toggle_main_menu();
}

hide_holo_table_props() {
  props = getentarray("holo_table_prop", "script_noteworthy");

  foreach(prop in props)
  prop hide();
}

frontend_do_save(force) {
  if(!isDefined(force))
    force = 0;

  if(force || getdvarint(#"_id_26C61C3F") != 0) {
    do_frontend_save = getdvarint(#"_id_E42F28A4");

    if(do_frontend_save < 2) {
      stats_only = !force && do_frontend_save == 0;
      savegame("auto", stats_only);
      level waittill("savegame_done");
    }
  }

  setdvarint("ui_dofrontendsave", 0);
  flag_set("save_complete");
}

frontend_just_finished_rts() {
  str_prev_level = getdvar(#"_id_D614D075");

  if(!isDefined(str_prev_level))
    return 0;

  return issubstr(str_prev_level, "so_rts");
}

rts_map_completed(str_map_name) {
  str_stat_name = level.m_rts_stats[str_map_name];
  assert(isDefined(str_stat_name));
  stat_val = level.player get_story_stat(str_stat_name);
  return stat_val != 0;
}

warp_to_random_player_start() {
  start_list = array("player_start_01", "player_start_02", "player_start_03", "player_start_04");
  warp_to_player_start(random(start_list));
}

warp_to_player_start(warp_targetname) {
  if(!isDefined(warp_targetname))
    warp_targetname = "default_player_start";

  s_warp = getstruct(warp_targetname);
  skipto_teleport_players(warp_targetname);
  wait_network_frame();
  level.player.origin = s_warp.origin;
  level.player.angles = (s_warp.angles[0], s_warp.angles[1], 0);
  level.e_player_align.origin = s_warp.origin;
  level.e_player_align.angles = (s_warp.angles[0], s_warp.angles[1], 0);
}

get_level_number_completed() {
  return level.player getdstat("PlayerStatsList", "HIGHESTLEVELCOMPLETED", "statValue");
}

start_patrollers() {
  patrollers = simple_spawn("idle_patroller");

  foreach(ai in patrollers) {
    ai.disable_melee = 1;
    ai thread maps\_patrol::patrol(ai.target);
  }
}

init_viewarm() {
  self.is_glove_shown = 0;
}

data_glove_input_button() {
  pressed = 0;

  if(!level.console && !level.player gamepadusedlast())
    pressed = level.player buttonpressed("MOUSE1") || level.player buttonpressed("ESCAPE") || level.player buttonpressed("ENTER");
  else
    pressed = level.player buttonpressed("BUTTON_A") || level.player buttonpressed("BUTTON_B") || level.player buttonpressed("BUTTON_X") || level.player buttonpressed("BUTTON_Y");

  return pressed;
}

data_glove_input() {
  self endon("menu_closed");

  while(true) {
    if(data_glove_input_button()) {
      run_scene("data_glove_input");

      while(data_glove_input_button())
        wait_network_frame();
    }

    wait_network_frame();
  }
}

strikeforce_get_num_levels_till_gone(campaign_level_num, rts_level_name) {
  end_level = int(tablelookup("sp/levelLookup.csv", 1, rts_level_name, 14));

  if(campaign_level_num >= end_level)
    return -1;

  cur_level_type = "";
  chances_remaining = 0;

  for(cur_level = campaign_level_num; cur_level < end_level; cur_level++) {
    cur_level_type = tablelookup("sp/levelLookup.csv", 0, cur_level, 8);

    if(cur_level_type == "CMP") {
      chances_remaining++;
      continue;
    }

    if(cur_level_type == "RTS") {
      break;
    }
  }

  return chances_remaining;
}

frontend_should_use_vtol(cur_level) {
  last_level_num = int(tablelookup("sp/levelLookup.csv", 0, "last_campaign_level", 1));

  println("vtollevel: last_level: " + last_level_num);

  println("vtollevel: cur_level: " + cur_level);

  if(cur_level > last_level_num)
    return false;
  else {
    blackout_level_num = int(tablelookup("sp/levelLookup.csv", 1, "blackout", 0));
    return cur_level > blackout_level_num;
  }
}

get_campaign_state() {
  campaign_state = getdvarint(#"_id_1E1641E3");
  return campaign_state;
}

stop_credits_button() {
  pressed = 0;

  if(!level.console && !level.player gamepadusedlast())
    pressed = level.player buttonpressed("MOUSE1");
  else
    pressed = level.player buttonpressed(getenterbutton());

  return pressed;
}

run_glasses_input() {
  level endon("disconnect");

  while(true) {
    if(!isDefined(level.luimodal) || level.luimodal == 0) {
      switch (level.menustate) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
        case 4:
          break;
        case 5:
          if(stop_credits_button()) {
            level notify("credits_skip");

            if(stop_credits_button()) {
            }
          }

          break;
      }
    }

    wait 0.05;
  }
}

scene_glasses_on() {
  level run_scene_first_frame("glasses_on");
  flag_wait_any("lockout_screen_passed", "lockout_screen_skipped", "lockout_screen_skipped_freeroam");
  level thread run_scene("glasses_on");
  wait_network_frame();
  glasses = get_model_or_models_from_scene("glasses_on", "glasses");
  glasses setviewmodelrenderflag(1);
}

turn_on_glasses(glasses_on) {
  if(!isDefined(glasses_on))
    glasses_on = 1;

  level endon("disconnect");
  flag_wait("frontend_scene_ready");
  level.e_player_align.origin = level.player.origin;
  level.e_player_align.angles = (level.player.angles[0], level.player.angles[1], 0);

  if(!flag("lockout_screen_skipped") && !flag("lockout_screen_skipped_freeroam"))
    level thread scene_glasses_on();

  level thread control_vision_set_glasses();
  flag_wait_any("lockout_screen_passed", "lockout_screen_skipped", "lockout_screen_skipped_freeroam");

  if(!flag("lockout_screen_skipped") && !flag("lockout_screen_skipped_freeroam")) {
    wait 1.0;
    flag_wait("headsupdisplay");
    wait 0.5;
    level.player setblur(1.6, 2.5);
    maps\_glasses::play_bootup();
  }

  skipanim = getdvar(#"_id_D614D075") != "";

  if(!flag("lockout_screen_skipped_freeroam"))
    level.player toggle_viewarm(1, skipanim);

  level thread run_glasses_input();
}

attach_data_glove() {
  if(!is_true(self.m_data_glove_attached)) {
    self setviewmodelrenderflag(1);
    self attach("c_usa_cia_frnd_viewbody_vson", "J_WristTwist_LE");
    self.m_data_glove_attached = 1;
  }

  if(is_true(self.glove_fx_on)) {
    if(flag("briefing_active")) {
      self notify("stop_glove_fx");
      self.glove_fx_on = 0;
    }
  } else if(flag("briefing_active")) {
    self play_fx("data_glove_glow", undefined, undefined, "stop_glove_fx", 1, "J_WristTwist_LE");
    self.glove_fx_on = 1;
  }
}

attach_data_pads() {
  drone_names = array("troop_01_drone", "troop_02_drone");

  foreach(name in drone_names) {
    drone = getent(name, "targetname");

    if(isDefined(drone)) {
      if(!is_true(drone.has_tablet)) {
        drone attach("p6_anim_sf_tablet", "tag_weapon_left", 1);
        drone.has_tablet = 1;
      }
    }
  }
}

toggle_viewarm(do_show, skipanim) {
  if(!isDefined(skipanim))
    skipanim = 0;

  if(!isDefined(self.is_glove_shown)) {
    return;
  }
  if(!isDefined(do_show))
    do_show = !self.is_glove_shown;

  if(self.is_glove_shown == do_show) {
    return;
  }
  level_num = get_level_number_completed();
  use_vtol = frontend_should_use_vtol(level_num + 1);

  if(do_show) {
    if(use_vtol)
      visionsetnaked("sp_front_end_menu_vtol", 1.0);
    else
      visionsetnaked("sp_front_end_menu", 1.0);

    level.e_player_align.origin = level.player.origin;
    level.e_player_align.angles = (level.player.angles[0], level.player.angles[1], 0);
    level.player setblur(1.6, 2.5);

    if(!skipanim) {
      level thread run_scene("data_glove_start");
      wait_network_frame();
      player_body = get_model_or_models_from_scene("data_glove_start", "player_body");
      player_body attach_data_glove();
      scene_wait("data_glove_start");
      end_scene("data_glove_idle");
      wait_network_frame();
      level thread run_scene("data_glove_idle");
    } else {
      end_scene("data_glove_idle");
      wait_network_frame();
      level thread run_scene("data_glove_idle");
      wait_network_frame();
      player_body = get_model_or_models_from_scene("data_glove_idle", "player_body");
      player_body attach_data_glove();
    }

    level.player thread data_glove_input();
  } else {
    visionsetnaked("sp_frontend_bridge", 1.0);
    level.player notify("menu_closed");
    run_scene("data_glove_finish");
    level.player setblur(0, 0.5);
  }

  self.is_glove_shown = do_show;
}

toggle_main_menu() {
  luinotifyevent(&"toggle_glasses");
  wait_network_frame();
  level.player toggle_viewarm();
}

control_vision_set_glasses() {
  flag_wait("glasses_tint");
  level.player visionsetnaked("sp_front_end_glasses_up", 0.05);
  wait 0.15;
  level.player visionsetnaked("sp_frontend_bridge", 2.0);
}

watch_for_lockout_screen() {
  flag_wait("level.player");

  while(true) {
    level.player waittill("menuresponse", str_menu_action, str_action_arg);

    if(str_menu_action == "lockout") {
      switch (str_action_arg) {
        case "activated":
          level.menustate = 4;
          level notify("frontend_refresh_scene");
          level clientnotify("sndNOAMB");
          setmusicstate("FRONT_END_START");
          break;
        case "deactivated":
          flag_set("bootup_sequence_done_first_time");
          level.menustate = 1;
          level clientnotify("sndAMB");
          setmusicstate("FRONT_END_MAIN");
          break;
        case "skipped":
          level notify("frontend_refresh_scene");
          flag_set("lockout_screen_skipped");
          level.menustate = 1;
          level clientnotify("sndAMB");
          setmusicstate("FRONT_END_MAIN");
          break;
        case "skipped_freeroam":
          level notify("frontend_refresh_scene");
          flag_set("lockout_screen_skipped_freeroam");
          level.menustate = 0;
          level clientnotify("sndAMB");
          setmusicstate("FRONT_END_MAIN");
          break;
        case "need_glasses":
          level notify("frontend_refresh_scene");
          flag_set("lockout_screen_passed");
          level.menustate = -1;
          level clientnotify("sndAMB");
          setmusicstate("FRONT_END_MAIN");
          break;
        case "glasses_boot_complete":
          level clientnotify("sndAMB");
          setmusicstate("FRONT_END_MAIN");
          break;
        case "start_credits":
          level notify("frontend_refresh_scene");
          flag_set("lockout_screen_skipped_freeroam");
          level.menustate = 5;
          level clientnotify("sndNOAMB");
          level thread credits_scroll_with_movies_sequence();
          break;
      }
    }
  }
}

listen_for_luisystem_messages() {
  while(true) {
    self waittill("menuresponse", str_menu_action, str_action_arg);

    if(str_menu_action == "luisystem") {
      switch (str_action_arg) {
        case "modal_start":
          level.luimodal = 1;
          break;
        case "modal_stop":
          level.luimodal = 0;
          break;
        case "cm_start":
          level thread cm_input_watcher();
          break;
        case "cm_stop":
          level notify("terminate_cm_watcher");
          break;
      }
    }
  }
}

play_phase_intro() {
  last_level = get_level_number_completed();
  hub_num = frontend_get_hub_number(last_level + 1);

  switch (hub_num) {
    case 1:
      if(level.player get_story_stat("SO_WAR_HUB_ONE_INTRO") != 0) {
        return;
      }
      maps\frontend_sf_a::scene_pre_briefing();
      break;
    case 2:
      if(level.player get_story_stat("SO_WAR_HUB_TWO_INTRO") != 0) {
        return;
      }
      maps\frontend_sf_b::scene_pre_briefing();
      break;
    case 3:
      if(level.player get_story_stat("SO_WAR_HUB_THREE_INTRO") != 0) {
        return;
      }
      maps\frontend_sf_c::scene_pre_briefing();
      break;
    case 4:
      maps\frontend_sf_c::scene_pre_briefing_phase4();
      break;
  }
}

briefing_fade_up() {
  setmusicstate("MUS_FE_STRIKEFORCE");
  wait 0.5;
  attach_data_pads();
  fade_in(0.5);
}

listen_for_launchlevel_messages() {
  while(true) {
    self waittill("menuresponse", str_menu_action, str_action_arg);

    if(str_menu_action == "launchlevel") {
      get_players()[0] strikeforce_decrement_unit_tokens();
      fade_out(0.5);
      toggle_main_menu();
      level thread maps\createart\frontend_art::run_war_room_mixers();
      flag_set("briefing_active");

      if(str_action_arg == "so_tut_mp_drone")
        level_for_briefing = getdvar(#"_id_D614D075");
      else
        level_for_briefing = str_action_arg;

      show_holotable_fuzz(1);
      show_globe(0, 1);
      holo_table_exploder_switch(117);
      level thread frontend_watch_scene_skip(str_action_arg);

      switch (level_for_briefing) {
        case "so_rts_mp_dockside":
          level.player set_story_stat("SO_WAR_SINGAPORE_INTRO", 1);
          break;
        case "so_rts_mp_drone":
          level.player set_story_stat("SO_WAR_DRONE_INTRO", 1);
          break;
        case "so_rts_mp_overflow":
          level.player set_story_stat("SO_WAR_PAKISTAN_INTRO", 1);
          break;
        case "so_rts_mp_socotra":
          level.player set_story_stat("SO_WAR_SOCOTRA_INTRO", 1);
          break;
        case "so_rts_afghanistan":
          level.player set_story_stat("SO_WAR_AFGHANISTAN_INTRO", 1);
          break;
      }

      level thread briefing_fade_up();
      play_phase_intro();

      switch (level_for_briefing) {
        case "so_rts_mp_dockside":
          maps\frontend_sf_a::scene_dockside_briefing();
          break;
        case "so_rts_mp_drone":
          maps\frontend_sf_a::scene_drone_briefing();
          break;
        case "so_rts_mp_overflow":
          maps\frontend_sf_c::scene_overflow_briefing();
          break;
        case "so_rts_mp_socotra":
          maps\frontend_sf_c::scene_socotra_briefing();
          break;
        case "so_rts_afghanistan":
          maps\frontend_sf_b::scene_afghanistan_briefing();
          break;
      }

      launchlevel(str_action_arg);
    }
  }
}

cm_input_watcher() {
  level endon("terminate_cm_watcher");
  lvl = array(1, 5, 3, 4, 3, 1, 1);
  unit = array(1, 2, 3, 4, 5);
  version = array(5, 0, 2, 4, 1, 3);
  buttons = array("BUTTON_RTRIG", "BUTTON_LTRIG", "BUTTON_RSHLDR", "BUTTON_LSHLDR", "BUTTON_X", "BUTTON_Y");
  lvl_index = 0;
  unit_index = 0;
  version_index = 0;

  while(true) {
    for(i = 0; i < buttons.size; i++) {
      if(level.player buttonpressed(buttons[i])) {
        while(level.player buttonpressed(buttons[i]))
          wait 0.05;

        if(lvl[lvl_index] == i)
          lvl_index++;
        else
          lvl_index = 0;

        if(unit[unit_index] == i)
          unit_index++;
        else
          unit_index = 0;

        if(version[version_index] == i) {
          version_index++;
          continue;
        }

        version_index = 0;
      }
    }

    if(level.player buttonpressed("BUTTON_RSTICK")) {
      lvl_index = 0;
      unit_index = 0;
    }

    if(lvl_index >= lvl.size) {
      return;
    }
    if(unit_index >= unit.size) {
      saved_num = get_strikeforce_tokens_remaining();
      saved_num = saved_num + 5;
      return;
    }

    if(version_index >= version.size) {
      iprintln(getdvar(#"version"));
      return;
    }

    wait 0.05;
  }
}

listen_for_campaign_state_change() {
  while(true) {
    self waittill("menuresponse", str_menu_action, str_action_arg);

    if(str_menu_action == "campaign_state") {
      switch (str_action_arg) {
        case "start":
          level notify("frontend_refresh_scene");
          break;
        case "start_difficulty":
          level thread play_intro_movie();
          break;
        case "stop":
          setdvar("ui_aarmapname", "");
          setdvar("ui_mapname", "");
          break;
      }
    }
  }
}

play_intro_movie() {
  level endon("intro_movie_abort");
  rpc("clientscripts/frontend", "stop_env_movie");
  setmusicstate("FRONT_END_NO_MUSIC");
  wait 0.05;
  level thread movie_hide_hud();
  check_for_webm = 1;
  level.iscinematicwebm = 1;
  level.intro_cin_id = play_movie_async("prologue", 0, 0, undefined, 0, "intro_movie_done", undefined, undefined, 0, check_for_webm);
  level thread skip_intro_prompt();
  level waittill("intro_movie_done");
  level.intro_cin_id = undefined;
  rpc("clientscripts/frontend", "start_env_movie");
  wait 0.05;
  level.player show_hud();
  luinotifyevent(&"intro_complete");
  level notify("intro_movie_prompt_abort");
  setmusicstate("FRONT_END_MAIN");
  level thread frontend_do_save(1);
}

movie_hide_hud() {
  level waittill("movie_started");
  level.player hide_hud();
}

skip_intro_prompt() {
  level endon("intro_movie_prompt_abort");
  wait 2;
  flag_clear("frontend_scene_ready");
  teardown_basic_scene();
  setup_basic_scene();
  flag_set("frontend_scene_ready");
  wait 8;
  luinotifyevent(&"show_skip_prompt");

  while(true) {
    if(level.player buttonpressed(getenterbutton())) {
      break;
    }

    if(!level.console && (level.player buttonpressed("MOUSE1") || level.player buttonpressed("ENTER"))) {
      break;
    }

    wait 0.05;
  }

  level notify("intro_movie_abort");

  if(isDefined(level.intro_cin_id))
    stop3dcinematic(level.intro_cin_id);

  rpc("clientscripts/frontend", "start_env_movie");
  setmusicstate("FRONT_END_MAIN");
  wait 0.05;
  level.player show_hud();
  luinotifyevent(&"intro_complete");
  level thread frontend_do_save(1);
}

credits_scroll_with_movies_sequence() {
  level endon("credits_abort");

  if(!level.ps3)
    flag_wait("save_complete");

  luinotifyevent(&"start_credits");
  setdvar("r_loadingScreen", 1);
  setculldist(0.1);
  menendez_alive = !level.player get_story_stat("MENENDEZ_DEAD_IN_HAITI");
  jr_alive = !level.player get_story_stat("MASONJR_DEAD_IN_HAITI");
  sr_alive = !level.player get_story_stat("MASON_SR_DEAD");
  karma_alive = !level.player get_story_stat("KARMA_DEAD_IN_KARMA") && !level.player get_story_stat("KARMA_DEAD_IN_COMMAND_CENTER") && (!level.player get_story_stat("KARMA_CAPTURED") || level.player get_story_stat("SO_WAR_SOCOTRA_SUCCESS"));
  music_num = 0;

  if(!menendez_alive) {
    if(!sr_alive) {
      str_movie_1_name = "a3_grave_jr_alive_1";
      str_movie_2_name = "a3_grave_jr_alive_2";
      str_movie_3_name = "a3_grave_jr_alive_3";
      str_movie_4_name = "a3_grave_jr_alive_4";
      str_movie_5_name = "a3_grave_jr_alive_5";
      str_movie_6_name = "a3_grave_jr_alive_6";
      str_movie_7_name = "a3_grave_jr_alive_7";
      str_movie_8_name = "c3_dead";
      str_movie_9_name = "a7x";
      music_num = 0;
    } else {
      str_movie_1_name = "a2_vault_reunite_1";
      str_movie_2_name = "a2_vault_reunite_2";
      str_movie_3_name = "a2_vault_reunite_3";
      str_movie_4_name = "a2_vault_reunite_4";
      str_movie_5_name = "a2_vault_reunite_5";
      str_movie_6_name = "a2_vault_reunite_6";
      str_movie_7_name = "a2_vault_reunite_7";
      str_movie_8_name = "c3_dead";
      str_movie_9_name = "a7x";
      music_num = 1;
    }
  } else if(!sr_alive) {
    if(karma_alive) {
      str_movie_1_name = "a3_grave_jr_alive_1";
      str_movie_2_name = "a3_grave_jr_alive_2";
      str_movie_3_name = "a3_grave_jr_alive_3";
      str_movie_4_name = "a3_grave_jr_alive_4";
      str_movie_5_name = "a3_grave_jr_alive_5";
      str_movie_6_name = "a3_grave_jr_alive_6";
      str_movie_7_name = "a3_grave_jr_alive_7";
      str_movie_8_name = "c1_karma_alive";
      str_movie_9_name = "a7x";
      music_num = 0;
    } else {
      str_movie_1_name = "a1_vault_menendez_1";
      str_movie_2_name = "a1_vault_menendez_2";
      str_movie_3_name = "a1_vault_menendez_3";
      str_movie_4_name = "a1_vault_menendez_4";
      str_movie_5_name = "a1_vault_menendez_5";
      str_movie_6_name = "a1_vault_menendez_6";
      str_movie_7_name = "a1_vault_menendez_7";
      str_movie_8_name = "c2_karma_alive";
      str_movie_9_name = "a7x";
      music_num = 2;
    }
  } else if(karma_alive) {
    str_movie_1_name = "a2_vault_reunite_1";
    str_movie_2_name = "a2_vault_reunite_2";
    str_movie_3_name = "a2_vault_reunite_3";
    str_movie_4_name = "a2_vault_reunite_4";
    str_movie_5_name = "a2_vault_reunite_5";
    str_movie_6_name = "a2_vault_reunite_6";
    str_movie_7_name = "a2_vault_reunite_7";
    str_movie_8_name = "c1_karma_alive";
    str_movie_9_name = "a7x";
    music_num = 1;
  } else {
    str_movie_1_name = "a1_vault_menendez_1";
    str_movie_2_name = "a1_vault_menendez_2";
    str_movie_3_name = "a1_vault_menendez_3";
    str_movie_4_name = "a1_vault_menendez_4";
    str_movie_5_name = "a1_vault_menendez_5";
    str_movie_6_name = "a1_vault_menendez_6";
    str_movie_7_name = "a1_vault_menendez_7";
    str_movie_8_name = "c2_karma_alive";
    str_movie_9_name = "a7x";
    music_num = 2;
  }

  assert(isDefined(str_movie_1_name));
  assert(isDefined(str_movie_2_name));
  assert(isDefined(str_movie_3_name));
  assert(isDefined(str_movie_4_name));
  assert(isDefined(str_movie_5_name));
  assert(isDefined(str_movie_6_name));
  assert(isDefined(str_movie_7_name));
  assert(isDefined(str_movie_8_name));
  assert(isDefined(str_movie_9_name));
  rpc("clientscripts/frontend", "stop_env_movie");
  level.iscinematicwebm = 1;
  check_for_webm = 1;
  level thread credits_sequence1_abort();
  level thread credits_sequence1(str_movie_1_name, str_movie_2_name, str_movie_3_name, str_movie_4_name, str_movie_5_name, str_movie_6_name, str_movie_7_name, music_num, check_for_webm);
  level waittill("credits_sequence1_done");
  level thread credits_sequence1a_abort();
  level thread credits_sequence1a();
  level waittill("credits_sequence1a_done");
  level thread credits_sequence2_abort();
  level thread credits_sequence2(str_movie_8_name, music_num, check_for_webm);
  level waittill("credits_sequence2_done");
  level thread credits_sequence2a_abort();
  level thread credits_sequence2a();
  level waittill("credits_sequence2a_done");
  level thread credits_sequence3_abort();
  level thread credits_sequence3(str_movie_9_name, music_num, check_for_webm);
  level waittill("credits_sequence3_done");
  level notify("credits_movie_complete");
  rpc("clientscripts/frontend", "start_env_movie");
  level thread waitforendcreditschangemusic();
  level.iscinematicwebm = 0;
  wait 0.1;
  luinotifyevent(&"stop_credits");
  setdvar("r_loadingScreen", 0);
  level.menustate = 1;
  toggle_main_menu();
  setculldist(10000);

  if(level.ps3)
    frontend_do_save();
}

credits_sequence1(str_movie_1_name, str_movie_2_name, str_movie_3_name, str_movie_4_name, str_movie_5_name, str_movie_6_name, str_movie_7_name, music_num, check_for_webm) {
  level endon("credits_sequence1_skip");
  level waittill("credits_movie_1");
  setmusicstate("FRONT_END_NO_MUSIC");
  rpc("clientscripts/frontend_amb", "sndCreditsMusic", music_num, 1);
  level.credits_cin_id = play_movie_async(str_movie_1_name, 0, 0, undefined, 1, "credits_movie1_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie1_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level waittill("credits_movie_2");
  level.credits_cin_id = play_movie_async(str_movie_2_name, 0, 0, undefined, 1, "credits_movie2_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie2_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level waittill("credits_movie_3");
  level.credits_cin_id = play_movie_async(str_movie_3_name, 0, 0, undefined, 1, "credits_movie3_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie3_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level waittill("credits_movie_4");
  level.credits_cin_id = play_movie_async(str_movie_4_name, 0, 0, undefined, 1, "credits_movie4_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie4_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level waittill("credits_movie_5");
  level.credits_cin_id = play_movie_async(str_movie_5_name, 0, 0, undefined, 1, "credits_movie5_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie5_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level waittill("credits_movie_6");
  level.credits_cin_id = play_movie_async(str_movie_6_name, 0, 0, undefined, 1, "credits_movie6_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie6_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level waittill("credits_movie_7");
  level.credits_cin_id = play_movie_async(str_movie_7_name, 0, 0, undefined, 1, "credits_movie7_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie7_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level notify("credits_sequence1_done");
}

credits_sequence1a() {
  level endon("credits_sequence1a_skip");
  level notify("credits_sequence1a");
  level waittill("credits_movie_8");
  level notify("credits_sequence1a_done");
}

credits_sequence2(str_movie_8_name, music_num, check_for_webm) {
  level endon("credits_sequence2_skip");
  level notify("credits_sequence2");
  rpc("clientscripts/frontend_amb", "sndStopCreditsMusic");
  setmusicstate("FRONT_END_NO_MUSIC");
  level.credits_cin_id = play_movie_async(str_movie_8_name, 0, 0, undefined, 1, "credits_movie8_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie8_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level notify("credits_sequence2_done");
}

credits_sequence2a() {
  level endon("credits_sequence2a_skip");
  level notify("credits_sequence2a");
  rpc("clientscripts/frontend_amb", "sndPlayCreditsMusic", 2);
  level waittill("credits_movie_9");
  level notify("credits_sequence2a_done");
}

credits_sequence3(str_movie_9_name, music_num, check_for_webm) {
  level notify("credits_sequence3");
  rpc("clientscripts/frontend_amb", "sndStopCreditsMusic");
  setmusicstate("FRONT_END_NO_MUSIC");
  level.credits_cin_id = play_movie_async(str_movie_9_name, 0, 0, undefined, 1, "credits_movie9_done", undefined, undefined, 0, check_for_webm);
  level waittill("credits_movie9_done");
  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  level notify("credits_sequence3_done");
}

waitforendcreditschangemusic() {
  level waittill_either("credits_abort", "credits_done");
  level notify("credits_abort");
  setculldist(10000);
  wait 0.1;
  luinotifyevent(&"stop_credits");
  level.iscinematicwebm = 0;
  level.menustate = 1;
  toggle_main_menu();

  if(level.ps3)
    frontend_do_save();

  rpc("clientscripts/frontend_amb", "sndStopCreditsMusic");
  setmusicstate("FRONT_END_MAIN");
  level clientnotify("sndAMB");
}

credits_sequence1_abort() {
  level endon("credits_movie_complete");
  level endon("credits_sequence1a");
  level waittill("credits_skip");
  level notify("credits_sequence1_skip");

  if(isDefined(level.credits_cin_id))
    stop3dcinematic(level.credits_cin_id);

  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  setdvar("ui_creditSkipTo", "scroll_sequence_1");
  level notify("credits_sequence1_done");
}

credits_sequence1a_abort() {
  level endon("credits_movie_complete");
  level endon("credits_sequence2");
  level waittill("credits_skip");
  level notify("credits_sequence1a_skip");
  setdvar("ui_creditSkipTo", "credits_movie_8");
  level notify("credits_sequence1a_done");
}

credits_sequence2_abort() {
  level endon("credits_movie_complete");
  level endon("credits_sequence2a");
  level waittill("credits_skip");
  level notify("credits_sequence2_skip");

  if(isDefined(level.credits_cin_id))
    stop3dcinematic(level.credits_cin_id);

  level.credits_cin_id = undefined;
  setdvarint("ui_creditMovieNack", 1);
  setdvar("ui_creditSkipTo", "scroll_sequence_2");
  level notify("credits_sequence2_done");
}

credits_sequence2a_abort() {
  level endon("credits_movie_complete");
  level endon("credits_sequence3");
  level waittill("credits_skip");
  level notify("credits_sequence2a_skip");
  setdvar("ui_creditSkipTo", "credits_movie_9");
  level notify("credits_sequence2a_done");
}

credits_sequence3_abort() {
  level endon("credits_movie_complete");
  level waittill("credits_skip");

  if(isDefined(level.credits_cin_id))
    stop3dcinematic(level.credits_cin_id);

  rpc("clientscripts/frontend", "start_env_movie");
  setmusicstate("FRONT_END_MAIN");
  level clientnotify("sndAMB");
  rpc("clientscripts/frontend_amb", "sndStopCreditsMusic");
  level.iscinematicwebm = 0;
}

build_globe() {
  globe = getent("world_globe", "targetname");
  countries = getentarray(globe.target, "targetname");

  foreach(country in countries) {
    country linkto(globe);
    country hide();
    country ignorecheapentityflag(1);
    country clearclientflag(14);
  }

  level.m_rts_map_angle["so_rts_mp_dockside"] = (0, 210, 30);
  level.m_rts_map_angle["so_rts_afghanistan"] = (0, 220, 40);
  level.m_rts_map_angle["so_rts_mp_drone"] = (0, 190, 30);
  level.m_rts_map_angle["so_rts_mp_socotra"] = (0, 245, 20);
  level.m_rts_map_angle["so_rts_mp_overflow"] = (0, 225, 35);
  return globe;
}

toggle_hologram_fx(fx_on) {
  if(fx_on)
    holo_table_exploder_switch(113);
  else
    holo_table_exploder_switch(undefined);
}

process_globe_glow() {
  if(is_true(self.camera_facing)) {
    return;
  }
  self.camera_facing = 1;
  self endon("death");
  globe = getent("world_globe", "targetname");
  self.angles = globe.angles;

  while(true) {
    self.origin = globe.origin;
    cam_pos = level.player getplayercamerapos();
    self_to_camera = cam_pos - self.origin;
    newangles = vectortoangles(self_to_camera);
    newangles = (newangles[0], newangles[1] + 90, newangles[2]);
    self rotateto(newangles, 0.05, 0, 0);
    wait_network_frame();
  }
}

show_holotable_fuzz(do_show) {
  if(!isDefined(do_show))
    do_show = 1;

  fuzz = getent("holotable_static", "targetname");

  if(!isDefined(do_show) && !isDefined(fuzz.shown) || isDefined(do_show) && isDefined(fuzz.shown) && do_show == fuzz.shown) {
    return;
  }
  fuzz ignorecheapentityflag(1);

  if(do_show)
    fuzz setclientflag(15);
  else
    fuzz clearclientflag(15);

  fuzz.shown = do_show;
}

show_globe(do_show, toggle_countries, ambient_spin) {
  if(!isDefined(do_show))
    do_show = 1;

  if(!isDefined(toggle_countries))
    toggle_countries = 0;

  if(!isDefined(ambient_spin))
    ambient_spin = 0;

  globe = getent("world_globe", "targetname");

  if(!isDefined(globe.glow_ring)) {
    globe.glow_ring = getent("world_globe_ring", "targetname");
    globe.glow_ring thread process_globe_glow();
  }

  if(!ambient_spin)
    globe notify("stop_spinning");
  else {
    globe notify("kill_globe_marker_fx");
    globe thread rotate_indefinitely(120);
  }

  if(!isDefined(level.m_globe_shown))
    level.m_globe_shown = !do_show;

  if(do_show != level.m_globe_shown) {
    if(do_show) {
      globe setclientflag(15);
      globe.glow_ring show();
      globe play_fx("globe_satellite_fx", globe.origin, globe.angles, "kill_globe_satellite_fx", 1);
    } else {
      globe notify("kill_globe_satellite_fx");
      globe notify("kill_globe_marker_fx");
      globe clearclientflag(15);
      globe.glow_ring hide();
    }
  }

  level.m_globe_shown = do_show;

  if(toggle_countries || ambient_spin) {
    countries = getentarray(globe.target, "targetname");

    foreach(country in countries) {
      if(do_show && !ambient_spin) {
        country show();
        continue;
      }

      country hide();
    }
  }
}

globe_show_map(map_name) {
  angles = level.m_rts_map_angle[map_name];

  if(!isDefined(angles))
    angles = (0, 0, 0);

  globe = getent("world_globe", "targetname");
  disputed_territory = level.m_rts_territory[map_name];
  city_marker = level.m_rts_city_tag[map_name];
  wait_network_frame();
  territories = getentarray(globe.target, "targetname");

  foreach(territory in territories) {
    hide = 1;

    if(isDefined(disputed_territory)) {
      if(territory.script_noteworthy == disputed_territory)
        hide = 0;
    }

    if(hide) {
      territory hide();
      continue;
    }

    territory show();
  }

  tweak_x = angles[0];
  tweak_y = angles[1];
  tweak_z = angles[2];
  angles = (tweak_x, tweak_y, tweak_z);

  globe notify("kill_globe_marker_fx");
  globe play_fx("globe_city_marker", globe.origin, globe.angles, "kill_globe_marker_fx", 1, city_marker);
  globe rotateto(angles, 0.5, 0, 0);
}

frontend_get_hub_number(current_level) {
  hub_number = int(tablelookup("sp/levelLookup.csv", 0, current_level, 17));

  if(!isDefined(hub_number))
    hub_number = 0;
  else if(hub_number <= 0)
    hub_number = 0;

  return hub_number;
}

teardown_basic_scene() {
  level notify("teardown_basic_scene");
  hide_holo_table_props();
  briggs = getent("briggs_ai", "targetname");

  if(isDefined(briggs))
    briggs delete();

  briggs_spawner = getent("briggs", "targetname");
  briggs_spawner.count = 1;

  if(isDefined(level.m_mission_team)) {
    array_delete(level.m_mission_team);
    level.m_mission_team = undefined;
  }

  show_globe(1, 0);
  show_holotable_fuzz(0);
  frontend_delete_ospreys();
}

frontend_run_scene() {
  level waittill("frontend_refresh_scene");

  while(true) {
    setup_basic_scene();

    if(level.menustate != 4) {
      if(get_campaign_state() == 1) {
        level_num = int(tablelookup("sp/levelLookup.csv", 1, getdvar(#"ui_mapname"), 0));
        luinotifyevent(&"frontend_restore2", 1, is_any_new_strikeforce_maps(level_num) ? 1 : 0);
      }
    }

    flag_set("frontend_scene_ready");

    if(get_campaign_state() != 0)
      wait 0.5;

    fade_in(0.5);
    level waittill("frontend_refresh_scene");
    flag_clear("frontend_scene_ready");

    if(level.menustate != 4 && level.menustate != -1)
      fade_out(0.5);

    teardown_basic_scene();
  }
}

frontend_watch_resume() {
  while(true) {
    level waittill("frontend_resume");
    fade_out(0.5);
    luinotifyevent(&"frontend_restore");
  }
}

flag_is_set_and_defined(flag_name) {
  if(!isDefined(flag_name))
    return 0;
  else
    return flag(flag_name);
}

frontend_platform_skip_button_check() {
  if(!level.console && !level.player gamepadusedlast())
    return level.player buttonpressed("MOUSE1") || level.player buttonpressed("ENTER") || level.player buttonpressed("ESCAPE");
  else
    return level.player buttonpressed(getenterbutton());
}

frontend_watch_scene_skip(level_name) {
  wait 4.0;
  luinotifyevent(&"show_skip_prompt");

  while(frontend_platform_skip_button_check())
    wait_network_frame();

  while(true) {
    if(frontend_platform_skip_button_check()) {
      while(frontend_platform_skip_button_check())
        wait_network_frame();

      break;
    }

    wait_network_frame();
  }

  level thread fade_out(0.5);
  wait 0.7;
  launchlevel(level_name);
}

fade_out(n_time) {
  if(!isDefined(n_time))
    n_time = 1.0;

  if(!isDefined(level.hudalpha))
    level.hudalpha = 0;

  if(level.hudalpha == 0) {
    hud = get_fade_hud("black");
    hud.foreground = 1;

    if(n_time > 0) {
      hud.alpha = 0;
      hud fadeovertime(n_time);
      hud.alpha = 1;
      wait(n_time);
    } else
      hud.alpha = 1;

    level.hudalpha = 1;
  }
}

fade_in(n_time) {
  if(!isDefined(n_time))
    n_time = 1.0;

  if(!isDefined(level.hudalpha))
    level.hudalpha = 0;

  if(level.hudalpha == 1) {
    hud = get_fade_hud("black");
    hud.foreground = 1;

    if(n_time > 0) {
      hud.alpha = 1;
      hud fadeovertime(n_time);
      hud.alpha = 0;
      wait(n_time);
    } else
      hud.alpha = 0;

    level.hudalpha = 0;

    if(isDefined(level.fade_hud))
      level.fade_hud destroy();
  }
}

setup_war_map(cur_level) {
  map_names = getarraykeys(level.m_rts_map_id);
  num_tokens = level.player get_strikeforce_tokens_remaining();
  num_claimed = 0;
  num_fallen = 0;
  flag_wait("strikeforce_stats_loaded");
  campaign_state = get_campaign_state();

  for(i = 0; i < map_names.size; i++) {
    map_name = map_names[i];
    map_id = level.m_rts_map_id[map_name];
    stat_id = level.m_rts_stats[map_name];
    color_id = 4;
    map_done = level.player get_story_stat(stat_id);

    if(campaign_state == 0)
      color_id = 4;
    else if(map_done != 0) {
      color_id = 3;
      num_claimed++;
    } else if(num_tokens == 0)
      color_id = 2;
    else {
      levels_left = strikeforce_get_num_levels_till_gone(cur_level, map_name);

      if(levels_left < 0) {
        color_id = 2;
        num_fallen++;
      } else
        color_id = 0;
    }

    set_world_map_tint(map_id, color_id);
    set_world_map_marker(map_id, 0);
    set_world_map_widget(map_id, 0);
  }

  if(campaign_state == 0)
    set_world_map_tint(4, 4);
  else if(num_tokens == 0 || num_fallen >= 3)
    set_world_map_tint(4, 2);
  else if(num_claimed >= 3)
    set_world_map_tint(4, 3);
  else
    set_world_map_tint(4, 0);

  set_world_map_marker(4, 0);
  set_world_map_widget(4, 0);
  refresh_war_map_shader();
}

frontend_run_ospreys() {
  osprey_name_list = array("frontend_osprey1", "frontend_osprey2", "frontend_osprey3", "frontend_osprey4");
  level.m_ospreys = [];

  foreach(name in osprey_name_list) {
    osprey = maps\_vehicle::spawn_vehicle_from_targetname(name);
    osprey thread frontend_run_osprey();
    level.m_ospreys[level.m_ospreys.size] = osprey;
  }
}

frontend_delete_ospreys() {
  if(isDefined(level.m_ospreys))
    array_delete(level.m_ospreys);

  level.m_ospreys = undefined;
}

player_boat_sim(angle_min, angle_max, time) {
  if(!isDefined(angle_min))
    angle_min = 0.5;

  if(!isDefined(angle_max))
    angle_max = 1.0;

  if(!isDefined(time))
    time = 4.0;

  wait 1;
  self notify("stop_boat_sim");
  self endon("stop_boat_sim");

  if(!isDefined(self.m_ground_ref))
    self.m_ground_ref = spawn_model("tag_origin", self.origin);

  self playersetgroundreferenceent(self.m_ground_ref);

  while(true) {
    n_time = time;
    n_angle = randomfloatrange(angle_min, angle_max);
    self.m_ground_ref rotateto((n_angle, 0, 0), n_time, n_time / 2, n_time / 2);
    self.m_ground_ref waittill("rotatedone");
    self.m_ground_ref rotateto((n_angle * -1, 0, 0), n_time, n_time / 2, n_time / 2);
    self.m_ground_ref waittill("rotatedone");
  }
}

stop_player_boat_sim() {
  self notify("stop_boat_sim");

  if(isDefined(self.m_ground_ref))
    self.m_ground_ref rotateto((0, 0, 0), 4.0, 2.0, 2.0);
}

frontend_run_osprey() {
  self endon("death");
  wait_network_frame();
  self setclientflag(11);
  self thread maps\_osprey::close_hatch();
  fvec = anglestoforward(self.angles);
  uvec = anglestoup(self.angles);
  self.look_target = spawn("script_origin", self.origin + fvec * 2048);
  self setlookatent(self.look_target);
  self setturningability(0.1);
  self sethoverparams(512, 0.01);
  original_pos = self.origin;

  while(true) {
    self setvehgoalpos(original_pos + randomfloatrange(-128.0, 128.0) * fvec + randomfloatrange(-128.0, 128.0) * uvec, 0);
    self setvehmaxspeed(1.0);
    self setspeed(1.0);
    self waittill("goal");
  }
}

frontend_setup_devgui() {
  setdvar("cmd_skipto", "");
  adddebugcommand("devgui_cmd \"|Frontend|/Toggle Freeroam:1\" \"cmd_skipto freeroam\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Phase Intro:2/None:1\" \"cmd_skipto hub_none\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Phase Intro:2/HUB A:2\" \"cmd_skipto hub_a\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Phase Intro:2/HUB B:3\" \"cmd_skipto hub_b\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Phase Intro:2/HUB C:4\" \"cmd_skipto hub_c\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Phase Intro:2/HUB D:5\" \"cmd_skipto hub_d\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Mission Briefing:3/Dockside:1\" \"cmd_skipto so_rts_mp_dockside\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Mission Briefing:3/Drone:2\" \"cmd_skipto so_rts_mp_drone\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Mission Briefing:3/Afghanistan:3\" \"cmd_skipto so_rts_afghanistan\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Mission Briefing:3/Socotra:4\" \"cmd_skipto so_rts_mp_socotra\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Mission Briefing:3/Overflow:5\" \"cmd_skipto so_rts_mp_overflow\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Stats:4/Toggle Iran Safe:1\" \"cmd_skipto toggle_iran_safe\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Stats:4/Toggle India Safe:2\" \"cmd_skipto toggle_india_safe\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Stats:4/Toggle Afghanistan Safe:3\" \"cmd_skipto toggle_afghan_safe\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Stats:4/Toggle Pakistan Intel:4\" \"cmd_skipto toggle_pak_intel\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Stats:4/Toggle Karma Captured:5\" \"cmd_skipto toggle_karma_captured\"\n");
  adddebugcommand("devgui_cmd \"|Frontend|/Toggle Globe:5\" \"cmd_skipto toggle_globe\"\n");
  level thread frontend_watch_devgui();
}

frontend_watch_devgui() {
  level.m_debug_phase = "hub_none";

  while(true) {
    cmd_skipto = getdvar(#"_id_4D60CDD2");

    if(cmd_skipto != "") {
      if(issubstr(cmd_skipto, "so_rts")) {
        toggle_main_menu();
        fade_out(0);
        show_globe(0, 1);
        show_holotable_fuzz(1);
        holo_table_exploder_switch(117);
        flag_set("briefing_active");
        level thread maps\createart\frontend_art::run_war_room_mixers();
        wait 2.0;
        level thread briefing_fade_up();

        switch (level.m_debug_phase) {
          case "hub_a":
            maps\frontend_sf_a::scene_pre_briefing();
            break;
          case "hub_b":
            maps\frontend_sf_b::scene_pre_briefing();
            break;
          case "hub_c":
            maps\frontend_sf_c::scene_pre_briefing();
            break;
          case "hub_d":
            maps\frontend_sf_c::scene_pre_briefing_phase4();
            break;
          default:
            break;
        }

        switch (cmd_skipto) {
          case "so_rts_mp_dockside":
            level.player set_story_stat("SO_WAR_SINGAPORE_INTRO", 0);
            maps\frontend_sf_a::scene_dockside_briefing();
            break;
          case "so_rts_mp_drone":
            level.player set_story_stat("SO_WAR_DRONE_INTRO", 0);
            maps\frontend_sf_a::scene_drone_briefing();
            break;
          case "so_rts_mp_overflow":
            level.player set_story_stat("SO_WAR_PAKISTAN_INTRO", 0);
            maps\frontend_sf_c::scene_overflow_briefing();
            break;
          case "so_rts_mp_socotra":
            level.player set_story_stat("SO_WAR_SOCOTRA_INTRO", 0);
            maps\frontend_sf_c::scene_socotra_briefing();
            break;
          case "so_rts_afghanistan":
            level.player set_story_stat("SO_WAR_AFGHANISTAN_INTRO", 0);
            maps\frontend_sf_b::scene_afghanistan_briefing();
            break;
          default:
            break;
        }

        level notify("frontend_reset_mixers");
        wait 2.0;
        flag_clear("briefing_active");
        show_globe(1, 1, 1);
        show_holotable_fuzz(0);
        toggle_main_menu();
        fade_in(0.5);
      } else if(issubstr(cmd_skipto, "hub_")) {
        level.m_debug_phase = cmd_skipto;
        iprintlnbold("Now select a briefing.");
      } else {
        stat_to_swap = undefined;

        switch (cmd_skipto) {
          case "toggle_iran_safe":
            stat_to_swap = "SO_WAR_SINGAPORE_SUCCESS";
            break;
          case "toggle_india_safe":
            stat_to_swap = "SO_WAR_DRONE_SUCCESS";
            break;
          case "toggle_afghan_safe":
            stat_to_swap = "SO_WAR_AFGHANISTAN_SUCCESS";
            break;
          case "toggle_pak_intel":
            stat_to_swap = "ALL_PAKISTAN_RECORDINGS";
            break;
          case "toggle_karma_captured":
            stat_to_swap = "KARMA_CAPTURED";
            break;
          case "freeroam":
            if(level.menustate == 0) {
              level.menustate = 1;
              toggle_main_menu();
              level.player freezecontrols(1);
            } else {
              level.menustate = 0;
              toggle_main_menu();
              level.player freezecontrols(0);
            }

            break;
          case "toggle_globe":
            if(is_true(level.m_globe_shown)) {
              setmusicstate("FRONT_END_NO_MUSIC");
              show_holotable_fuzz(0);
              show_globe(0, 1);
            } else {
              show_holotable_fuzz(1);
              show_globe(1, 0, 1);
            }

            break;
          default:
            break;
        }

        if(isDefined(stat_to_swap)) {
          cur_val = level.player get_story_stat(stat_to_swap) != 0;
          level.player set_story_stat(stat_to_swap, !cur_val);

          if(cur_val)
            iprintlnbold("Stat now FALSE");
          else
            iprintlnbold("Stat now TRUE");
        }
      }
    }

    setdvar("cmd_skipto", "");
    wait 0.05;
  }

}