/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_glasses.gsc
**************************************/

#include maps\_utility;
#include common_scripts\utility;

autoexec init() {
  get_extracam();
  glasses_precache();
  flag_init("glasses_bink_playing");
}

get_extracam() {
  if(!isDefined(level.e_extra_cam)) {
    level.e_extra_cam = spawn("script_model", (0, 0, 0));
    level.e_extra_cam setmodel("tag_origin");
    level.e_extra_cam.angles = (0, 0, 0);
  }

  return level.e_extra_cam;
}

glasses_precache() {
  precachestring(&"hud_shades_bootup");
  precachestring(&"extracam_show");
  precachestring(&"extracam_show_large");
  precachestring(&"extracam_hide");
  precachestring(&"cinematic_start");
  precachestring(&"cinematic_stop");
  precachestring(&"hud_hide_shadesHud");
  precachestring(&"hud_show_shadesHud");
  precachestring(&"fullscreen_pip");
  precachestring(&"minimize_fullscreen_pip");
  precachestring(&"hud_perform_wipe");
  precachestring(&"hud_add_visor_text");
  precachestring(&"hud_remove_visor_text");
  precachestring(&"hud_create_timer");
  precachestring(&"hud_destroy_timer");
  precachestring(&"extracam_glasses");
  precachestring(&"cinematic2d");
  precacheshader("cinematic2d");
  precachemenu("lui");
  precachemenu("cinematic");
}

add_visor_timer(start_time, second_hundreths_threshold, is_countup_timer, show_hours, show_minutes, show_milliseconds) {
  if(!isDefined(start_time))
    start_time = 30;

  if(!isDefined(second_hundreths_threshold))
    second_hundreths_threshold = 30;

  if(!isDefined(is_countup_timer))
    is_countup_timer = 0;

  if(!isDefined(show_hours))
    show_hours = 0;

  if(!isDefined(show_minutes))
    show_minutes = 1;

  if(!isDefined(show_milliseconds))
    show_milliseconds = 0;

  v_is_countup_timer = 1;

  if(!is_countup_timer)
    v_is_countup_timer = 0;

  v_show_hours = 1;

  if(!show_hours)
    v_show_hours = 0;

  v_show_minutes = 1;

  if(!show_minutes)
    v_show_minutes = 0;

  v_show_milliseconds = 1;

  if(!show_milliseconds)
    v_show_milliseconds = 0;

  luinotifyevent(&"hud_create_timer", 6, start_time, v_is_countup_timer, v_show_hours, v_show_minutes, v_show_milliseconds, second_hundreths_threshold);
  level thread restore_timer_on_save_restored(start_time, v_is_countup_timer, v_show_hours, v_show_minutes, v_show_milliseconds, second_hundreths_threshold);
}

restore_timer_on_save_restored(start_time, v_is_countup_timer, v_show_hours, v_show_minutes, v_show_milliseconds, second_hundreths_threshold) {
  level endon("remove_visor_timer");
  n_timer_start_time = gettime();

  while(true) {
    level waittill("save_restored");
    wait 1;

    if(v_is_countup_timer == 1)
      start_time = start_time + (level.checkpoint_time - n_timer_start_time) / 1000;
    else
      start_time = start_time - (level.checkpoint_time - n_timer_start_time) / 1000;

    if(start_time > 0)
      luinotifyevent(&"hud_create_timer", 6, int(start_time), v_is_countup_timer, v_show_hours, v_show_minutes, v_show_milliseconds, second_hundreths_threshold);
  }
}

remove_visor_timer() {
  level notify("remove_visor_timer");
  luinotifyevent(&"hud_destroy_timer");
}

play_bootup() {
  luinotifyevent(&"hud_shades_bootup");
}

perform_visor_wipe(duration) {
  if(!isDefined(duration))
    duration = 2;

  luinotifyevent(&"hud_perform_wipe", 1, int(duration * 1000));
  playsoundatposition("evt_hud_sweep", (0, 0, 0));
}

add_visor_text(string_to_display, duration, color, alpha, flicker, flicker_time_low, flicker_time_high) {
  if(!isDefined(duration))
    duration = 5;

  if(!isDefined(color))
    color = "default";

  if(!isDefined(alpha))
    alpha = 100;

  if(!isDefined(flicker))
    flicker = 0;

  if(!isDefined(flicker_time_low))
    flicker_time_low = 0.5;

  if(!isDefined(flicker_time_high))
    flicker_time_high = 0.5;

  v_duration = duration;

  if(!isDefined(v_duration) || v_duration < 0)
    v_duration = 5;

  switch (color) {
    case "orange":
      v_color = 2;
      break;
    case "default":
    default:
      v_color = 1;
      break;
  }

  switch (alpha) {
    case "low":
      v_alpha = 40;
      break;
    case "medium":
      v_alpha = 60;
      break;
    case "less_bright":
      v_alpha = 80;
      break;
    case "bright":
    default:
      v_alpha = 100;
      break;
  }

  if(flicker)
    v_flicker = 1;
  else
    v_flicker = 0;

  v_flicker_time_low = int(flicker_time_low * 1000);
  v_flicker_time_high = int(flicker_time_high * 1000);
  luinotifyevent(&"hud_add_visor_text", 7, istring(string_to_display), v_duration, v_color, v_alpha, v_flicker, v_flicker_time_low, v_flicker_time_high);
}

remove_visor_text(string_to_remove) {
  luinotifyevent(&"hud_remove_visor_text", 1, istring(string_to_remove));
}

make_pip_fullscreen(duration) {
  if(!isDefined(duration))
    duration = 1;

  luinotifyevent(&"fullscreen_pip", 1, int(duration * 1000));
}

shrink_pip_fullscreen(duration) {
  if(!isDefined(duration))
    duration = 1;

  luinotifyevent(&"minimize_fullscreen_pip", 1, int(duration * 1000));
}

turn_on_extra_cam(str_shader_override, str_custom_notify, should_start_fullscreen) {
  if(!isDefined(should_start_fullscreen))
    should_start_fullscreen = 0;

  str_extracam_show = & "extracam_show";

  if(isDefined(str_custom_notify))
    str_extracam_show = str_custom_notify;

  str_shader = & "extracam_glasses";

  if(isDefined(str_shader_override))
    str_shader = str_shader_override;

  infullscreen = 0;

  if(should_start_fullscreen)
    infullscreen = 1;

  level.pip_sound_ent = spawn("script_origin", level.player.origin);
  level.player playsound("evt_pip_on");
  level.pip_sound_ent playloopsound("evt_pip_loop", 1);
  level.e_extra_cam setclientflag(1);
  luinotifyevent(str_extracam_show, 2, str_shader, infullscreen);
}

turn_off_extra_cam(str_shader_override, str_custom_notify) {
  assert(isDefined(level.e_extra_cam), "level.e_extra_cam isn't defined, call _glasses::main");
  str_extracam_hide = & "extracam_hide";

  if(isDefined(str_custom_notify))
    str_extracam_hide = str_custom_notify;

  str_shader = & "extracam_glasses";

  if(isDefined(str_shader_override))
    str_shader = str_shader_override;

  level.player playsound("evt_pip_off");
  level.pip_sound_ent stoploopsound();
  level.pip_sound_ent delete();
  level.e_extra_cam clearclientflag(1);
  luinotifyevent(str_extracam_hide, 1, str_shader);
}

play_bink_on_hud(str_bink_name, b_looping, b_in_memory, b_paused, b_sync_audio, start_size) {
  if(!isDefined(b_looping))
    b_looping = 0;

  if(!isDefined(b_in_memory))
    b_in_memory = 0;

  if(!isDefined(b_paused))
    b_paused = 0;

  if(!isDefined(b_sync_audio))
    b_sync_audio = 0;

  if(!isDefined(start_size))
    start_size = 0;

  assert(isDefined(str_bink_name), "Undefined Bink name");
  luinotifyevent(&"cinematic_start", 7, & "cinematic2d", istring(str_bink_name), b_looping, b_in_memory, b_paused, b_sync_audio, start_size);
  str_menu = "";

  while(str_menu != "cinematic")
    level.player waittill("menuresponse", str_menu, str_cin_id);

  flag_set("glasses_bink_playing");
  level.pip_sound_bink_ent = spawn("script_origin", level.player.origin);
  level.player playsound("evt_pip_on");
  level.pip_sound_bink_ent playloopsound("evt_pip_loop", 1);

  if(!b_looping) {
    n_cin_id = int(str_cin_id);

    while(iscinematicpreloading(n_cin_id))
      wait 0.05;

    time_remaining = getcinematictimeremaining(n_cin_id);
    assert(time_remaining >= 0, "GetCinematicTimeRemaining for " + str_bink_name + " returned less than 0 time remaining.");

    if(time_remaining > 1)
      wait(time_remaining);
    else
      wait(time_remaining - 1);

    stop_bink_on_hud();
  }
}

stop_bink_on_hud() {
  level endon("bink_timeout");
  level.player playsound("evt_pip_off");
  level.pip_sound_bink_ent stoploopsound();
  level.pip_sound_bink_ent delete();
  thread _bink_timeout(1.5);
  luinotifyevent(&"cinematic_stop", 1, & "cinematic2d");
  str_menu = "";

  while(str_menu != "cinematic")
    level.player waittill("menuresponse", str_menu, n_cin_id);

  flag_clear("glasses_bink_playing");
}

_bink_timeout(n_time) {
  wait(n_time);
  level notify("bink_timeout");
  flag_clear("glasses_bink_playing");
}