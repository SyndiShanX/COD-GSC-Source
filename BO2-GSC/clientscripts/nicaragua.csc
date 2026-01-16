/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\nicaragua.csc
***************************************/

#include clientscripts\_utility;
#include clientscripts\_filter;
#include clientscripts\_horse_ride;
#include clientscripts\_ambientpackage;
#include clientscripts\_audio;
#include clientscripts\nicaragua_fx;
#include clientscripts\_load;
#include clientscripts\nicaragua_amb;

main() {
  clientscripts\nicaragua_fx::main();
  clientscripts\_load::main();
  thread clientscripts\_audio::audio_init(0);
  thread clientscripts\nicaragua_amb::main();
  register_clientflag_callback("actor", 15, ::toggle_flame_char_actor);
  waitforclient(0);

  println("*** Client : nicaragua running...");

  level thread setup_scope();
  level thread enable_bunker_lightflares();
  setup_rage();

  level thread debug_loop();
}

debug_loop() {
  while(true)
    wait 0.05;
}

setup_rage() {
  e_player = level.localplayers[0];
  init_filter_blood_droplets(e_player);
  init_filter_blood_splats(e_player);
  level.str_rage_mode = "reset";
  level.is_rage_image_on = 1;
  level.is_rage_mode_low = 0;
  level.n_rage_warp_final = 0;
  level.n_rage_value_high = 0;
  level.n_rage_image_position_index = randomint(2);
  level.b_rage_sprinting = 0;
  enable_filter_blood_droplets(e_player, 5, 1, 0);
  enable_filter_blood_splats(e_player, 6, 1, 0);
}

rage_mode_disable() {
  level.str_rage_mode = "disable";
  level.is_rage_image_on = 0;

  if(isDefined(level.rageloopent) && isDefined(level.rageloopid)) {
    level.rageloopent delete();
    level.rageloopent = undefined;
    level.rageloopid = undefined;
  }

  level.n_rage_warp_final = 0;
  level.n_rage_value_high = 0;
  e_player = level.localplayers[0];
  disable_filter_rage(e_player, 1);
  disable_filter_blood_droplets(e_player, 5);
  disable_filter_blood_splats(e_player, 6);
  setlutvolumeactivebank(0, 1);
}

rage_mode_reset() {
  if(level.str_rage_mode != "reset") {
    if(!isDefined(level.rageloopid))
      level setuprageloopid();

    level.str_rage_mode = "reset";
    level.is_rage_mode_low = 0;
    deactivateambientroom(0, "rage_mode_high", 50);
    setsoundvolume(level.rageloopid, 0);
    snd_set_snapshot("default");
    setlutvolumeactivebank(0, 2);
    n_rage_warp_previous = level.n_rage_warp_final;
    level.n_rage_warp_final = 0;

    if(n_rage_warp_previous < level.n_rage_warp_final)
      level thread fade_warp_low_to_high(n_rage_warp_previous, level.n_rage_warp_final, 1);
    else if(n_rage_warp_previous > level.n_rage_warp_final)
      level thread fade_warp_high_to_low(n_rage_warp_previous, level.n_rage_warp_final, 1);

    n_rage_value_previous = level.n_rage_value_high;
    level.n_rage_value_high = 0;
    rage_mode_fade(n_rage_value_previous);
  }
}

rage_mode_low() {
  if(level.str_rage_mode != "low") {
    if(!isDefined(level.rageloopid))
      level setuprageloopid();

    level.str_rage_mode = "low";
    deactivateambientroom(0, "rage_mode_high", 50);
    setsoundvolume(level.rageloopid, 0.2);
    snd_set_snapshot("default");
    level.is_rage_mode_low = 1;
    setlutvolumeactivebank(0, 2);
    n_rage_warp_previous = level.n_rage_warp_final;
    level.n_rage_warp_final = 0;

    if(n_rage_warp_previous < level.n_rage_warp_final)
      level thread fade_warp_low_to_high(n_rage_warp_previous, level.n_rage_warp_final, 0.5);
    else if(n_rage_warp_previous > level.n_rage_warp_final)
      level thread fade_warp_high_to_low(n_rage_warp_previous, level.n_rage_warp_final, 0.5);

    n_rage_value_previous = level.n_rage_value_high;
    level.n_rage_value_high = 0.5;
    rage_mode_fade(n_rage_value_previous);
  }
}

rage_mode_medium() {
  if(level.str_rage_mode != "medium") {
    if(!isDefined(level.rageloopid))
      level setuprageloopid();

    level.str_rage_mode = "medium";
    deactivateambientroom(0, "rage_mode_high", 50);
    setsoundvolume(level.rageloopid, 0.5);
    snd_set_snapshot("default");
    level.is_rage_mode_low = 0;
    n_rage_value_previous = level.n_rage_value_high;
    level.n_rage_value_high = 0.65;
    rage_mode_fade(n_rage_value_previous);
  }
}

rage_mode_high() {
  e_player = level.localplayers[0];

  if(level.str_rage_mode != "high") {
    if(!isDefined(level.rageloopid))
      level setuprageloopid();

    level.str_rage_mode = "high";
    activateambientroom(0, "rage_mode_high", 50);
    setsoundvolume(level.rageloopid, 1);
    snd_set_snapshot("spl_nic_rage_high");
    level.is_rage_mode_low = 0;
    level notify("rage_off");
    set_filter_rage_ghost_amount(e_player, 1, 0);
    setlutvolumeactivebank(0, 4);
    level thread rage_mode_high_warping();
    wait 0.5;
    n_rage_value_previous = level.n_rage_value_high;
    level.n_rage_value_high = 1;
    rage_mode_fade(n_rage_value_previous);
  }
}

rage_toggle(b_is_high) {
  e_player = level.localplayers[0];
  toggle_rage_filter(e_player, 1, level.n_rage_value_high, b_is_high);
}

rage_mode_high_warping() {
  n_fov_default = getdvarfloat(#"cg_fov");
  level thread fade_fov_lerp(n_fov_default, 50, 0.25);
  fade_warp_high_to_low(0.1, -0.5, 0.25);
  level thread fade_fov_lerp(50, 75, 0.35);
  fade_warp_low_to_high(-0.5, 0.4, 0.35);
  level thread fade_fov_lerp(75, 58, 0.2);
  fade_warp_high_to_low(0.4, 0.25, 0.2);
  level thread fade_fov_lerp(58, 67, 0.1);
  fade_warp_low_to_high(0.25, 0.35, 0.1);
  level thread fade_fov_lerp(67, n_fov_default, 0.1);
  fade_warp_high_to_low(0.35, 0.18, 0.1);
  level.n_rage_warp_final = 0.18;
  setclientdvar("cg_fov", n_fov_default);
}

fade_fov_lerp(n_fov_1, n_fov_2, n_fade_time, n_time_increment) {
  e_player = level.localplayers[0];

  if(!isDefined(n_time_increment))
    n_time_increment = 0.0166667;

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;

    if(n_fov_1 < n_fov_2)
      n_fov = n_fov_1 * (1 - n_time) + n_fov_2 * n_time;
    else
      n_fov = n_fov_1 + n_fov_2 - (n_fov_2 * (1 - n_time) + n_fov_1 * n_time);

    setclientdvar("cg_fov", n_fov);
    wait(n_time_increment);
  }
}

setuprageloopid() {
  level.rageloopent = spawn(0, (0, 0, 0), "script_origin");
  level.rageloopid = level.rageloopent playloopsound("evt_menendez_rage_loop");
  setsoundvolume(level.rageloopid, 0);
  setsoundvolumerate(level.rageloopid, 3);
}

rage_mode_fade(n_rage_value_previous) {
  e_player = level.localplayers[0];
  level.n_start_value = 0;
  level.n_rage_values_diff = 0;
  level.n_steps = 0;
  level.n_blend_amount = 0;
  level.n_rage_value = 0;
  level.n_start_value = n_rage_value_previous;
  level.n_rage_values_diff = abs(level.n_rage_value_high - n_rage_value_previous);
  level.n_steps = _get_number_of_steps(0.05, level.n_rage_values_diff);
  level.n_blend_amount = level.n_rage_values_diff / level.n_steps;

  for(i = 0; i <= level.n_steps; i++) {
    if(n_rage_value_previous < level.n_rage_value_high)
      level.n_rage_value = level.n_start_value + i * level.n_blend_amount;
    else
      level.n_rage_value = level.n_start_value - i * level.n_blend_amount;

    set_filter_rage_amount(e_player, 1, level.n_rage_value);
    wait 0.05;
  }
}

_get_number_of_steps(n_step_size, n_rage_values_diff) {
  if(n_rage_values_diff == 0)
    n_steps = 1;
  else
    n_steps = n_rage_values_diff / n_step_size;

  return n_steps;
}

fade_rage_low_to_high(n_rage_low, n_rage_high, n_fade_time) {
  e_player = level.localplayers[0];
  n_time_increment = 0.0166667;
  set_filter_rage_amount(e_player, 1, n_rage_low);

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;
    n_rage_amount = n_rage_low * (1 - n_time) + n_rage_high * n_time;
    set_filter_rage_amount(e_player, 1, n_rage_amount);
    wait(n_time_increment);
  }

  set_filter_rage_amount(e_player, 1, n_rage_high);
}

fade_rage_high_to_low(n_rage_high, n_rage_low, n_fade_time) {
  e_player = level.localplayers[0];
  n_time_increment = 0.0166667;
  set_filter_rage_amount(e_player, 1, n_rage_high);

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;
    n_rage_amount = n_rage_high + n_rage_low - (n_rage_low * (1 - n_time) + n_rage_high * n_time);
    set_filter_rage_amount(e_player, 1, n_rage_amount);
    wait(n_time_increment);
  }

  set_filter_rage_amount(e_player, 1, n_rage_low);
}

blood_splat(n_time_max, n_alpha_max, n_alpha_reset) {
  e_player = level.localplayers[0];

  if(n_alpha_max > 0) {
    level notify("blood_splat_started");
    level endon("blood_splat_started");
    set_filter_blood_droplets_amount(e_player, 5, n_alpha_max);
    set_filter_blood_droplets_count(e_player, 5, n_alpha_max);
    set_filter_blood_splats_amount(e_player, 6, n_alpha_max);
    set_filter_blood_splats_count(e_player, 6, n_alpha_max);
    playsound(0, "evt_menendez_rage_blood_splat", (0, 0, 0));
    wait 0.15;

    for(i = n_alpha_reset; i < n_time_max; i = i + 0.05) {
      n_time = i / n_time_max;
      n_blood_amount = n_alpha_max + n_alpha_reset - (n_alpha_reset * (1 - n_time) + n_alpha_max * n_time);
      set_filter_blood_droplets_amount(e_player, 5, n_blood_amount);
      set_filter_blood_splats_amount(e_player, 6, n_blood_amount);
      wait 0.05;
    }

    set_filter_blood_droplets_amount(e_player, 5, n_alpha_reset);
    set_filter_blood_splats_amount(e_player, 6, n_alpha_reset);
  }
}

blood_splat_life_change(n_life_new) {
  e_player = level.localplayers[0];
  set_filter_blood_droplets_life(e_player, 5, n_life_new);
  set_filter_blood_splats_life(e_player, 6, n_life_new);
}

rage_mode_low_images() {
  while(level.is_rage_image_on) {
    if(level.is_rage_mode_low)
      rage_mode_fade_image();

    wait 6;
  }
}

rage_mode_fade_image() {
  level endon("rage_off");
  e_player = level.localplayers[0];

  if(level.n_rage_image_position_index == 0) {
    set_filter_rage_ghost_offset(e_player, 1, -0.5, 0);
    set_filter_rage_ghost_image(e_player, 1, 0);
    level.n_rage_image_position_index++;
  } else if(level.n_rage_image_position_index == 1) {
    set_filter_rage_ghost_offset(e_player, 1, 0.5, 0);
    set_filter_rage_ghost_image(e_player, 1, 1);
    level.n_rage_image_position_index = 0;
  }

  n_alpha_high = randomfloatrange(0.85, 1);
  fade_hud_low_to_high(0, n_alpha_high, 1.3);
  wait 0.5;
  fade_hud_high_to_low(n_alpha_high, 0, 1.3);
}

fade_hud_low_to_high(n_alpha_low, n_alpha_high, n_fade_time) {
  e_player = level.localplayers[0];
  n_time_increment = 0.0166667;
  set_filter_rage_ghost_amount(e_player, 1, n_alpha_low);

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;
    n_alpha_amount = n_alpha_low * (1 - n_time) + n_alpha_high * n_time;
    set_filter_rage_ghost_amount(e_player, 1, n_alpha_amount);
    wait(n_time_increment);
  }

  set_filter_rage_ghost_amount(e_player, 1, n_alpha_high);
}

fade_hud_high_to_low(n_alpha_high, n_alpha_low, n_fade_time) {
  e_player = level.localplayers[0];
  n_time_increment = 0.0166667;
  set_filter_rage_ghost_amount(e_player, 1, n_alpha_high);

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;
    n_alpha_amount = n_alpha_high + n_alpha_low - (n_alpha_low * (1 - n_time) + n_alpha_high * n_time);
    set_filter_rage_ghost_amount(e_player, 1, n_alpha_amount);
    wait(n_time_increment);
  }

  set_filter_rage_ghost_amount(e_player, 1, n_alpha_low);
}

rage_mode_fade_shift_to_high(n_fade_time) {
  e_player = level.localplayers[0];
  wait 0.25;
  fade_shift_low_to_high(0, 0.7, 0.35);
  fade_shift_high_to_low(0.7, 0.35, 0.15);
  fade_shift_high_to_low(0.35, 0.07, 1.1);
  fade_shift_high_to_low(0.07, 0, 0.15);
  set_filter_rage_shift_amount(e_player, 1, 0);
}

rage_mode_fade_shift_to_low(n_fade_time) {
  e_player = level.localplayers[0];
  fade_shift_high_to_low(1, 0.15, 0.35);
  fade_shift_high_to_low(1, 0.15, 0.15);
  fade_shift_high_to_low(1, 0.15, 1.1);
  fade_shift_high_to_low(1, 0, 0.15);
  set_filter_rage_shift_amount(e_player, 1, 0);
}

fade_shift_low_to_high(n_shift_low, n_shift_high, n_fade_time) {
  e_player = level.localplayers[0];
  n_time_increment = 0.0166667;
  set_filter_rage_shift_amount(e_player, 1, n_shift_low);

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;
    n_shift_amount = n_shift_low * (1 - n_time) + n_shift_high * n_time;
    set_filter_rage_shift_amount(e_player, 1, n_shift_amount);
    wait(n_time_increment);
  }

  set_filter_rage_shift_amount(e_player, 1, n_shift_high);
}

fade_shift_high_to_low(n_shift_high, n_shift_low, n_fade_time) {
  e_player = level.localplayers[0];
  n_time_increment = 0.0166667;
  set_filter_rage_shift_amount(e_player, 1, n_shift_high);

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;
    n_shift_amount = n_shift_high + n_shift_low - (n_shift_low * (1 - n_time) + n_shift_high * n_time);
    set_filter_rage_shift_amount(e_player, 1, n_shift_amount);
    wait(n_time_increment);
  }

  set_filter_rage_shift_amount(e_player, 1, n_shift_low);
}

fade_warp_low_to_high(n_warp_low, n_warp_high, n_fade_time) {
  n_time_increment = 0.0166667;
  e_player = level.localplayers[0];
  set_filter_rage_warp_amount(e_player, 1, n_warp_low);

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;
    n_warp_amount = n_warp_low * (1 - n_time) + n_warp_high * n_time;
    set_filter_rage_warp_amount(e_player, 1, n_warp_amount);
    wait(n_time_increment);
  }

  set_filter_rage_warp_amount(e_player, 1, n_warp_high);
}

fade_warp_high_to_low(n_warp_high, n_warp_low, n_fade_time) {
  n_time_increment = 0.0166667;
  e_player = level.localplayers[0];
  set_filter_rage_warp_amount(e_player, 1, n_warp_high);

  for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
    n_time = i / n_fade_time;
    n_warp_amount = n_warp_high + n_warp_low - (n_warp_low * (1 - n_time) + n_warp_high * n_time);
    set_filter_rage_warp_amount(e_player, 1, n_warp_amount);
    wait(n_time_increment);
  }

  set_filter_rage_warp_amount(e_player, 1, n_warp_low);
}

rage_health_fade(n_alpha_1, n_alpha_2, n_fade_time) {
  e_player = level.localplayers[0];
  n_time_increment = 0.0166667;

  if(isDefined(n_fade_time)) {
    level notify("end_rage_health_fade");
    level endon("end_rage_health_fade");

    for(i = 0; i <= n_fade_time; i = i + n_time_increment) {
      n_time = i / n_fade_time;

      if(n_alpha_1 < n_alpha_2)
        n_alpha = n_alpha_1 * (1 - n_time) + n_alpha_2 * n_time;
      else
        n_alpha = n_alpha_1 + n_alpha_2 - (n_alpha_2 * (1 - n_time) + n_alpha_1 * n_time);

      set_filter_rage_hit(e_player, 1, n_alpha);
      wait(n_time_increment);
    }
  } else {
    set_filter_rage_hit(e_player, 1, n_alpha_1);
    rage_health_state_change(n_alpha_1, n_alpha_2, 1);
  }
}

rage_health_state_change(n_alpha, n_alpha_previous, b_do_health_hit) {
  e_player = level.localplayers[0];

  if(n_alpha_previous < 0.2 && n_alpha >= 0.2) {
    if(isDefined(b_do_health_hit))
      rage_health_hit();
  } else if(n_alpha_previous < 0.25 && n_alpha >= 0.25) {
    if(isDefined(b_do_health_hit))
      rage_health_hit();
  } else if(n_alpha_previous < 0.5 && n_alpha >= 0.5) {
    if(isDefined(b_do_health_hit))
      rage_health_hit();
  }
}

rage_health_color_yellow() {
  e_player = level.localplayers[0];
}

rage_health_hit() {
  rage_health_hit_fade(0.8, 1);
  rage_health_hit_fade(1, 0.8);
}

rage_health_hit_fade(n_opacity_1, n_opacity_2) {
  e_player = level.localplayers[0];
  n_time_increment = 0.0166667;

  for(i = 0; i <= 0.25; i = i + n_time_increment) {
    n_time = i / 0.25;

    if(n_opacity_1 < n_opacity_2)
      n_opacity = n_opacity_1 * (1 - n_time) + n_opacity_2 * n_time;
    else
      n_opacity = n_opacity_1 + n_opacity_2 - (n_opacity_2 * (1 - n_time) + n_opacity_1 * n_time);

    set_filter_rage_hit(e_player, 1, n_opacity);
    wait(n_time_increment);
  }
}

rage_health_fade_end_notify() {
  level notify("end_rage_health_fade");
}

rage_sprint_play() {
  playviewmodelfx(0, level._effect["sprint_blur"], "tag_view");

  if(isDefined(level.b_rage_sprinting) && level.b_rage_sprinting == 0) {
    level.b_rage_sprinting = 1;
    fade_fov_lerp(getdvarfloat(#"cg_fov_default"), 61, 0.15, 0.02);
  }
}

rage_sprint_stop() {
  stopfx(0, level._effect["sprint_blur"]);

  if(isDefined(level.b_rage_sprinting) && level.b_rage_sprinting == 1) {
    level.b_rage_sprinting = 0;
    fade_fov_lerp(61, getdvarfloat(#"cg_fov_default"), 0.15, 0.02);
  }
}

setup_scope() {
  init_filter_binoculars(level.localplayers[0]);
  enable_scope();
}

enable_scope() {
  while(true) {
    level waittill("scope_on");
    enable_filter_binoculars(level.localplayers[0], 0);
    level waittill("scope_off");
    disable_filter_binoculars(level.localplayers[0], 0);
  }
}

toggle_flame_char_actor(localclientnum, set, newent) {
  self mapshaderconstant(localclientnum, 0, "ScriptVector0");
  s_timer = new_timer();

  do {
    wait 0.01;
    n_current_time = s_timer get_time_in_seconds();
    n_delta_val = lerpfloat(0, 1.0, n_current_time / 3);
    self setshaderconstant(localclientnum, 0, 0, 0, n_delta_val, 0);
  }
  while(n_current_time < 3);
}

enable_bunker_lightflares() {
  level waittill("bunker_lightflares_on");
  a_lights = [];
  a_light_fx = [];

  for(i = 1; i < 28; i++) {
    e_light = getdynent("bunker_light_" + i);

    if(isDefined(e_light)) {
      a_lights[a_lights.size] = e_light;
      continue;
    }

    break;
  }

  foreach(light in a_lights)
  a_light_fx[a_light_fx.size] = playfxondynent(level._effect["fx_nic_tinhat_cage"], light);

  disable_bunker_lightflares(a_light_fx);
}

disable_bunker_lightflares(a_fx) {
  level waittill("bunker_lightflares_off");

  foreach(fx in a_fx)
  deletefx(0, fx);
}

set_lut_bank(n_bank) {
  setlutvolumeactivebank(0, n_bank);
}