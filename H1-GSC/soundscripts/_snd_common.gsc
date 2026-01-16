/****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: soundscripts\_snd_common.gsc
****************************************/

snd_common_init() {
  register_common_snd_messages();
  create_common_envelop_arrays();
  register_radio_squelches();
  apply_common_globalmix();
  level.mute_device_active = 0;
  level.player.radiation_state = "radiation_none";
  level._snd.context_overrides = [["mute", 0],
    ["slomo", 0],
    ["deathsdoor", 0],
    ["underwater", 0],
    ["diveboat", 0],
    ["wpn_int_med", 0],
    ["bullet_metal_vehicle", 0],
    ["bullet_whizby_glass", 0],
    ["finale_handgun", 0]
  ];
  soundsettimescalefactor("interface", 0);
  soundsettimescalefactor("notimescale", 0);

  if(common_scripts\utility::issp())
    thread snd_ads_mix();
}

register_radio_squelches() {
  level.scr_radio["squelches"]["plt"]["on"] = "squelch_on_plt";
  level.scr_radio["squelches"]["plt"]["off"] = "squelch_off_plt";
  level.scr_radio["squelches"]["hqr"]["on"] = "squelch_on_hqr";
  level.scr_radio["squelches"]["hqr"]["off"] = "squelch_off_hqr";
  level.scr_radio["squelches"]["prophet"]["on"] = "squelch_on_prophet";
  level.scr_radio["squelches"]["prophet"]["off"] = "squelch_off_hqr";
  level.scr_radio["squelches"]["battle_commander"]["on"] = "squelch_on_plt";
  level.scr_radio["squelches"]["battle_commander"]["off"] = "squelch_off_hqr";
  level.scr_radio["squelches"]["cormack_sfa"]["on"] = "squelch_on_plt";
  level.scr_radio["squelches"]["cormack_sfa"]["off"] = "squelch_off_hqr";
}

create_common_envelop_arrays() {
  level._snd.envs["explo_shake_over_distance"] = [[0.0, 1.0],
    [0.25, 0.65],
    [0.35, 0.5],
    [0.75, 0.2],
    [1.0, 0.1]
  ];
  level._snd.envs["veh_crash_intensity_to_pitch"] = [[0.0, 0.7],
    [0.1, 0.7],
    [0.5, 0.8],
    [0.9, 1.0],
    [1.0, 1.1]
  ];
  level._snd.envs["veh_crash_vel_to_lfe_vol"] = [[0.0, 0.0],
    [200, 0.05],
    [500, 0.25],
    [850, 0.35],
    [1000, 0.6]
  ];
  level._snd.envs["aud_mute_device_falloff"] = [[0.0, 1.0],
    [0.1, 0.9],
    [0.2, 0.88],
    [0.3, 0.85],
    [0.4, 0.82],
    [0.5, 0.8],
    [0.6, 0.65],
    [0.7, 0.5],
    [0.8, 0.35],
    [0.9, 0.15],
    [1.0, 0.0]
  ];
}

apply_common_globalmix() {
  if(common_scripts\utility::issp())
    soundscripts\_audio_mix_manager::mm_add_submix("sp_common_global_mix");
}

init_ambient_explosion_arrays() {
  if(level.currentgen)
    level._snd.ambientexp["exp_generic_explo_shot"] = [
      ["exp_generic_explo_shot_04", 0.17],
      ["exp_generic_explo_shot_07", 0.11],
      ["exp_generic_explo_shot_10", 0.22],
      ["exp_generic_explo_shot_12", 0.15],
      ["exp_generic_explo_shot_13", 0.08],
      ["exp_generic_explo_shot_20", 0.15],
      ["exp_generic_explo_shot_22", 0.25]
    ];
  else
    level._snd.ambientexp["exp_generic_explo_shot"] = [
      ["exp_generic_explo_shot_01", 0.13],
      ["exp_generic_explo_shot_02", 0.25],
      ["exp_generic_explo_shot_03", 0.12],
      ["exp_generic_explo_shot_04", 0.17],
      ["exp_generic_explo_shot_05", 0.16],
      ["exp_generic_explo_shot_06", 0.14],
      ["exp_generic_explo_shot_07", 0.11],
      ["exp_generic_explo_shot_08", 0.21],
      ["exp_generic_explo_shot_09", 0.16],
      ["exp_generic_explo_shot_10", 0.22],
      ["exp_generic_explo_shot_11", 0.13],
      ["exp_generic_explo_shot_12", 0.15],
      ["exp_generic_explo_shot_13", 0.08],
      ["exp_generic_explo_shot_14", 0.16],
      ["exp_generic_explo_shot_16", 0.2],
      ["exp_generic_explo_shot_17", 0.1],
      ["exp_generic_explo_shot_18", 0.08],
      ["exp_generic_explo_shot_19", 0.12],
      ["exp_generic_explo_shot_20", 0.15],
      ["exp_generic_explo_shot_21", 0.15],
      ["exp_generic_explo_shot_22", 0.25]
    ];
}

init_impact_system_arrays() {
  level._snd.veh_collision.surfaces = ["vehicle", "wood", "metal"];
}

init_boost_land_arrays() {
  level._snd.boost_jump.surfaces = ["ice", "asphalt", "concrete", "metal", "metal_solid"];
}

register_common_snd_messages() {
  soundscripts\_snd::snd_register_message("player_death", ::player_death);
  soundscripts\_snd::snd_register_message("friendly_fire_mission_failed", ::friendly_fire_mission_failed);
  soundscripts\_snd::snd_register_message("end_mission_fade_to_black", ::end_mission_fade_to_black);
  soundscripts\_snd::snd_register_message("wpn_deam160_init", ::wpn_deam160_init);
  soundscripts\_snd::snd_register_message("wpn_deam160_charge", ::wpn_deam160_charge);
  soundscripts\_snd::snd_register_message("wpn_deam160_charge_dots_increase", ::wpn_deam160_charge_dots_increase);
  soundscripts\_snd::snd_register_message("wpn_deam160_full_charge", ::wpn_deam160_full_charge);
  soundscripts\_snd::snd_register_message("wpn_deam160_shot", ::wpn_deam160_shot);
  soundscripts\_snd::snd_register_message("variable_grenade_type_switch", ::variable_grenade_type_switch);
  soundscripts\_snd::snd_register_message("paint_grenade_detonate", ::paint_grenade_detonate);
  soundscripts\_snd::snd_register_message("emp_grenade_detonate", ::emp_grenade_detonate);
  soundscripts\_snd::snd_register_message("smart_grenade_detonate", ::smart_grenade_detonate);
  soundscripts\_snd::snd_register_message("foam_grenade", ::foam_grenade);
  soundscripts\_snd::snd_register_message("aud_sonar_vision_on", ::aud_sonar_vision_on);
  soundscripts\_snd::snd_register_message("aud_sonar_vision_off", ::aud_sonar_vision_off);
  soundscripts\_snd::snd_register_message("explo_ambientExp_dirt", ::explo_ambientexp_dirt);
  soundscripts\_snd::snd_register_message("explo_ambientExp_fireball", ::explo_ambientexp_fireball);
  soundscripts\_snd::snd_register_message("play_vehicle_collision", ::snd_play_vehicle_collision);
  soundscripts\_snd::snd_register_message("start_vehicle_shell_shock", ::start_vehicle_shell_shock);
  soundscripts\_snd::snd_register_message("aud_radiation_shellshock", ::aud_radiation_shellshock);
  soundscripts\_snd::snd_register_message("boost_jump_enable", ::boost_jump_enable);
  soundscripts\_snd::snd_register_message("boost_jump_disable", ::boost_jump_disable);
  soundscripts\_snd::snd_register_message("boost_jump_disable_npc", ::boost_jump_disable_npc);
  soundscripts\_snd::snd_register_message("boost_jump_player", ::boost_jump_player);
  soundscripts\_snd::snd_register_message("boost_land_player", ::boost_land_player);
  soundscripts\_snd::snd_register_message("boost_jump_npc", ::boost_jump_npc);
  soundscripts\_snd::snd_register_message("boost_land_npc", ::boost_land_npc);
  soundscripts\_snd::snd_register_message("pdrone_death_explode", ::pdrone_death_explode);
  soundscripts\_snd::snd_register_message("pdrone_emp_death", ::pdrone_emp_death);
  soundscripts\_snd::snd_register_message("pdrone_crash_land", ::pdrone_crash_land);
  soundscripts\_snd::snd_register_message("doorshield_ripoff", ::doorshield_ripoff);
  soundscripts\_snd::snd_register_message("doorshield_throw", ::doorshield_throw);
  soundscripts\_snd::snd_register_message("exo_raise_shield", ::exo_raise_shield);
  soundscripts\_snd::snd_register_message("exo_lower_shield", ::exo_lower_shield);
  soundscripts\_snd::snd_register_message("snd_cloak_init", ::snd_cloak_init);
  soundscripts\_snd::snd_register_message("exo_cloak_button_press", ::exo_cloak_button_press);
  soundscripts\_snd::snd_register_message("exo_cloak_enable", ::exo_cloak_enable);
  soundscripts\_snd::snd_register_message("exo_cloak_disable", ::exo_cloak_disable);
  soundscripts\_snd::snd_register_message("exo_cloak_battery_low", ::exo_cloak_battery_low);
  soundscripts\_snd::snd_register_message("exo_cloak_battery_dead", ::exo_cloak_battery_dead);
  soundscripts\_snd::snd_register_message("exo_cloak_battery_recharge", ::exo_cloak_battery_recharge);
  soundscripts\_snd::snd_register_message("npc_cloak_buttons", ::npc_cloak_buttons);
  soundscripts\_snd::snd_register_message("npc_cloak_enable", ::npc_cloak_enable);
  soundscripts\_snd::snd_register_message("npc_cloak_disable", ::npc_cloak_enable);
  soundscripts\_snd::snd_register_message("overdrive_on", ::overdrive_on);
  soundscripts\_snd::snd_register_message("overdrive_off", ::overdrive_off);
  soundscripts\_snd::snd_register_message("sonic_blast", ::sonic_blast);
  soundscripts\_snd::snd_register_message("sonic_blast_aftershock", ::sonic_blast_aftershock);
  soundscripts\_snd::snd_register_message("sonic_blast_done", ::sonic_blast_done);
  soundscripts\_snd::snd_register_message("exo_stim_on", ::exo_stim_on);
  soundscripts\_snd::snd_register_message("boost_dodge_activate_plr", ::boost_dodge_activate_plr);
  soundscripts\_snd::snd_register_message("boost_land_hud_enable", ::boost_land_hud_enable);
  soundscripts\_snd::snd_register_message("boost_land_hud_disable", ::boost_land_hud_disable);
  soundscripts\_snd::snd_register_message("boost_land_out_of_fuel", ::boost_land_out_of_fuel);
  soundscripts\_snd::snd_register_message("boost_land_use_fuel", ::boost_land_use_fuel);
  soundscripts\_snd::snd_register_message("boost_land_assist_npc", ::boost_land_assist_npc);
  soundscripts\_snd::snd_register_message("boost_land_assist_npc_ground", ::boost_land_assist_npc_ground);
  soundscripts\_snd::snd_register_message("tracking_grenade_hover", ::tracking_grenade_hover);
  soundscripts\_snd::snd_register_message("tracking_grenade_jump", ::tracking_grenade_jump);
  soundscripts\_snd::snd_register_message("tracking_grenade_strike", ::tracking_grenade_strike);
  soundscripts\_snd::snd_register_message("tracking_grenade_dud", ::tracking_grenade_dud);
  soundscripts\_snd::snd_register_message("tracking_grenade_beep", ::tracking_grenade_beep);
  soundscripts\_snd::snd_register_message("anml_doberman", ::anml_doberman);
  soundscripts\_snd::snd_register_message("finish_mission_fade", ::finish_mission_fade);
  soundscripts\_snd::snd_register_message("aud_start_ragtime_warfare", ::aud_start_ragtime_warfare);
  soundscripts\_snd::snd_register_message("aud_stop_ragtime_warfare", ::aud_stop_ragtime_warfare);
}

player_death() {
  level notify("kill_deaths_door_audio");
  soundscripts\_audio_mix_manager::mm_clear_submix("deaths_door");
  soundscripts\_audio_mix_manager::mm_add_submix("player_dead");
  soundscripts\_snd_playsound::snd_play_2d("bullet_large_fatal");
}

friendly_fire_mission_failed() {
  if(!isdefined(level.ff_mission_failed_already_playing) && common_scripts\utility::issp()) {
    soundscripts\_audio_mix_manager::mm_add_submix("friendly_fire_failed_mix");
    soundscripts\_snd_playsound::snd_play_2d("friendly_fire_mission_failed");
    level.ff_mission_failed_already_playing = 1;
  }
}

end_mission_fade_to_black() {
  if(common_scripts\utility::issp())
    soundscripts\_audio_mix_manager::mm_add_submix("fade_to_black_end_mix");
}

wpn_deam160_init() {
  level.wpn_deam160_aud_charges = 0;
}

wpn_deam160_shot(var_0) {
  var_1 = var_0;
  level.wpn_deam160_aud_charges = 0;

  switch (var_1) {
    case "large":
      soundscripts\_audio::deprecated_aud_play_2d_sound("wpn_deam160_shot_max");
      level notify("aud_deam160_charge_break");
      break;
    case "medium":
      soundscripts\_audio::deprecated_aud_play_2d_sound("wpn_deam160_shot_med");
      level notify("aud_deam160_charge_break");
      break;
    case "small":
      soundscripts\_audio::deprecated_aud_play_2d_sound("wpn_deam160_shot_sml");
      level notify("aud_deam160_charge_break");
      break;
  }
}

wpn_deam160_charge(var_0) {
  var_1 = soundscripts\_audio::deprecated_aud_play_linked_sound("wpn_deam160_charge_hi", level.player, "oneshot");
  thread wpn_deam160_play_charge_loop_sfx();
  level.player thread wpn_deam160_watch_weapon_change();
  level.player thread wpn_deam160_is_chargeable();
  level waittill("aud_deam160_charge_break");

  if(isdefined(var_1))
    var_1 scalevolume(0, 0.05);
}

wpn_deam160_watch_weapon_change() {
  level endon("aud_deam160_charge_break");

  for (;;) {
    if(self isthrowinggrenade() || self isreloading() || self ismeleeing() || self ismantling()) {
      level notify("aud_deam160_charge_break");
      break;
    }

    wait 0.05;
  }
}

wpn_deam160_is_chargeable() {
  level endon("aud_deam160_charge_break");

  for (;;) {
    var_0 = weaponischargeable(self getcurrentweapon());

    if(!var_0) {
      level notify("aud_deam160_charge_break");
      break;
    }

    wait 0.05;
  }
}

wpn_deam160_play_charge_loop_sfx() {
  level endon("aud_deam160_charge_break");
  var_0 = soundscripts\_audio::deprecated_aud_play_linked_sound("wpn_deam160_charge_hi_lp", level.player, "loop", "aud_deam160_charge_break");
  var_0 scalevolume(0, 0.05);
  wait 2;

  if(isdefined(var_0))
    var_0 scalevolume(1, 0.4);
}

wpn_deam160_charge_dots_increase(var_0) {
  level.wpn_deam160_aud_charges++;
}

wpn_deam160_full_charge() {
  var_0 = soundscripts\_audio::deprecated_aud_play_linked_sound("wpn_deam160_full_charge_beep_lp", level.player, "loop", "aud_deam160_charge_break");
  level waittill("aud_deam160_charge_break");
}

variable_grenade_type_switch(var_0) {
  level.aud_var_nade_type = var_0;
  soundscripts\_snd_playsound::snd_play_2d("var_grenade_change_type");
}

paint_grenade_detonate() {
  var_0 = self;
  soundscripts\_snd_playsound::snd_play_at("wpn_paint_grenade_exp", var_0.origin);
}

emp_grenade_detonate() {
  var_0 = self;
  soundscripts\_snd_playsound::snd_play_at("wpn_emp_grenade_exp", var_0.origin);
}

smart_grenade_detonate() {
  level notify("kill_tracking_loop");
  var_0 = self;
  soundscripts\_snd_playsound::snd_play_at("wpn_smart_grenade_exp", var_0.origin);
}

foam_grenade(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("foam_grenade_mix", 0.5);
  var_1 = self.origin;
  wait 2.1;
  soundscripts\_audio::deprecated_aud_play_linked_sound("foam_bomb_equip", var_0);
  wait 1.1;
  soundscripts\_audio::deprecated_aud_play_linked_sound("foam_bomb_pin_pull", var_0);
  wait 1.3;
  soundscripts\_audio::deprecated_aud_play_sound_at("foam_bomb_wall_stick", var_1);
  level waittill("vfx_foam_corridor_explode_start");
  soundscripts\_audio::deprecated_aud_play_sound_at("foam_bomb_corridor_exp", var_1);
  wait 2.0;
  soundscripts\_audio_mix_manager::mm_clear_submix("foam_grenade_mix", 0.5);
}

aud_microwave_grenade() {
  var_0 = self.origin;
  thread soundscripts\_snd_playsound::snd_play_at("wpn_mw_grenade_exp", var_0);
  var_1 = thread soundscripts\_snd_playsound::snd_play_loop_at("wpn_mw_grenade_pulse_sweeps_lp", var_0, "mw_nade_death", 0.2, 0.45);
  var_2 = thread soundscripts\_snd_playsound::snd_play_loop_at("wpn_mw_grenade_pulse_big_lp", var_0, "mw_nade_death", 0.2, 0.45);
  self waittill("death");
  thread soundscripts\_snd_playsound::snd_play_at("wpn_mw_grenade_die", var_0);

  if(isdefined(var_2))
    var_2 scalevolume(0, 0.3);

  if(isdefined(var_1))
    var_1 scalevolume(0, 0.3);

  wait 0.3;

  if(isdefined(var_2))
    var_2 stopsounds();

  if(isdefined(var_1))
    var_1 stopsounds();
}

aud_microwave_grenade_sparks_env(var_0) {
  if(isdefined(var_0))
    thread soundscripts\_snd_playsound::snd_play_at("wpn_mw_grenade_elect", var_0);
}

aud_microwave_grenade_sparks_dude(var_0) {
  if(isdefined(var_0))
    var_0 thread soundscripts\_snd_playsound::snd_play_linked("wpn_mw_grenade_elect");
}

snd_ads_mix() {
  level.player endon("death");

  for (;;) {
    while (!level.player maps\_utility::isads())
      wait 0.05;

    if(weaponclass(level.player getcurrentweapon()) == "sniper")
      soundscripts\_audio_mix_manager::mm_add_submix("sniper_ads_mix");
    else
      soundscripts\_audio_mix_manager::mm_add_submix("ads_mix");

    while (level.player maps\_utility::isads())
      wait 0.05;

    soundscripts\_audio_mix_manager::mm_clear_submix("ads_mix");
    soundscripts\_audio_mix_manager::mm_clear_submix("sniper_ads_mix");
  }
}

snd_mute_device(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death");
  thread sndx_mute_device_bubble_fx();
  thread sndx_mute_device_bubble_off_fx();

  if(!isdefined(self.aud))
    self.aud = spawnstruct();

  self.aud.mute_device_mix_enable = 1;
  self.aud.mute_device_in_bubble = 1;

  if(isdefined(var_2))
    var_6 = var_2;
  else
    var_6 = var_1 + 250;

  level.mute_device_active = 1;

  if(isdefined(var_4)) {
    self.aud.mute_device_filter = 1;
    thread soundscripts\_snd_filters::snd_fade_in_filter(var_4, 0.5);
  }

  var_7 = 0;
  thread sndx_mute_device_stopper(var_0, var_3, var_7);

  while (isdefined(self.aud.mute_device_mix_enable)) {
    var_8 = distance(self.origin, level.player.origin);

    if(var_8 < var_1) {
      if(!isdefined(self.aud.mute_device_start)) {
        self notify("mute_device_bubble_enter");
        soundscripts\_audio_mix_manager::mm_add_submix(var_0, 0.05);
        self.aud.loop_ent = soundscripts\_snd_playsound::snd_play_loop_2d("mute_device_active_lp", "stop_mute_device_lp", 5, 3, 1);
        self.aud.mute_device_start = 1;
      }

      soundscripts\_audio_mix_manager::mm_blend_submix(var_0, 1);

      if(!isdefined(self.aud.mute_device_filter) && isdefined(var_4)) {
        self.aud.mute_device_filter = 1;
        thread soundscripts\_snd_filters::snd_fade_in_filter(var_4, 0.5);

        if(!isdefined(self.aud.mute_device_enter)) {
          self notify("mute_device_bubble_enter");
          soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_active_enter", 0.05);
          self.aud.mute_device_in_bubble = 1;
          thread sndx_mute_device_wait_to_play(self.aud.mute_device_enter);
          self.aud.loop_ent scalevolume(1.0, 2);
        }
      }
    } else if(var_8 < var_6 && self.aud.mute_device_start == 1) {
      var_9 = (var_8 - var_1) / (var_6 - var_1);
      clamp(var_9, 0, 1);
      var_10 = soundscripts\_snd::snd_map(var_9, level._snd.envs["aud_mute_device_falloff"]);
      soundscripts\_audio_mix_manager::mm_blend_submix(var_0, var_10);

      if(isdefined(self.aud.mute_device_filter)) {
        self.aud.mute_device_filter = undefined;
        thread soundscripts\_snd_filters::snd_fade_out_filter(1);

        if(!isdefined(self.aud.mute_device_exit)) {
          thread sndx_mute_device_delay_notify("mute_device_bubble_exit", 0.5);
          soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_active_exit", 0.05);
          self.aud.mute_device_in_bubble = 0;
          thread sndx_mute_device_wait_to_play(self.aud.mute_device_exit);
          self.aud.loop_ent scalevolume(0.0, 2);
        }
      }
    } else if(self.aud.mute_device_start == 1) {
      soundscripts\_audio_mix_manager::mm_blend_submix(var_0, 0);

      if(isdefined(self.aud.mute_device_filter)) {
        wait 0.05;
        self.aud.mute_device_filter = undefined;
        thread soundscripts\_snd_filters::snd_fade_out_filter(1);
        self.aud.loop_ent scalevolume(0.0, 2);
      }
    }

    wait 0.05;
  }

  level.mute_device_active = 0;
}

sndx_mute_device_delay_notify(var_0, var_1) {
  var_2 = 0;

  if(isdefined(var_1))
    var_2 = var_1;

  wait(var_2);
  self notify(var_0);
}

sndx_mute_device_stopper(var_0, var_1, var_2) {
  self endon("death");
  self endon("turn_off");
  thread sndx_mute_device_kill(var_0, "death");
  thread sndx_mute_device_kill(var_0, "turn_off");
  var_3 = 30;

  if(isdefined(var_1))
    var_3 = var_1;

  wait(var_3);
  self notify("complete");
  thread sndx_mute_device_stop(var_0);
}

sndx_mute_device_stop(var_0) {
  if(isdefined(self.aud.loop_ent))
    level notify("stop_mute_device_lp");

  if(self.aud.mute_device_in_bubble) {
    thread sndx_mute_device_delay_notify("mute_device_bubble_exit", 0.5);
    thread sndx_mute_device_delay_notify("mute_device_bubble_off", 1);

    if(!isdefined(self.aud.mute_device_exit))
      soundscripts\_snd_playsound::snd_play_delayed_2d("mute_device_active_exit", 0.05);
  }

  self.aud.mute_device_mix_enable = undefined;
  soundscripts\_audio_mix_manager::mm_clear_submix(var_0, 3);
  self.aud.mute_device_filter = undefined;
  soundscripts\_snd_filters::snd_fade_out_filter(3);
}

sndx_mute_device_kill(var_0, var_1) {
  self endon("complete");
  var_2 = "death";

  if(isdefined(var_1))
    var_2 = var_1;

  self waittill(var_2);
  thread sndx_mute_device_stop(var_0);
  self notify("complete");
}

sndx_mute_device_wait_to_play(var_0) {
  var_0 = 1;
  wait 2;
  var_0 = undefined;
}

sndx_mute_device_debug_timer(var_0) {
  self endon("death");
  var_1 = var_0;
}

sndx_mute_device_bubble_fx() {
  self endon("mute_device_bubble_off");

  while (isdefined(self)) {
    self waittill("mute_device_bubble_enter");
    playfxontag_safe("mute_breach_distort_vm_enter");
    self waittill("mute_device_bubble_exit");
    killfxontag_safe("mute_breach_distort_vm_enter");
    playfxontag_safe("mute_breach_distort_vm_exit");
    wait 0.05;
  }
}

sndx_mute_device_bubble_off_fx() {
  while (isdefined(self)) {
    self waittill("mute_device_bubble_off");
    wait 0.05;
  }
}

playfxontag_safe(var_0) {
  if(isdefined(self) && isdefined(level._effect[var_0]))
    playfxontag(common_scripts\utility::getfx(var_0), self, "tag_origin");
  else {}
}

killfxontag_safe(var_0) {
  if(isdefined(self) && isdefined(level._effect[var_0]))
    killfxontag(common_scripts\utility::getfx(var_0), self, "tag_origin");
  else {}
}

aud_sonar_vision_on() {
  soundscripts\_audio_mix_manager::mm_add_submix("sonar_vision", 0.05);
  soundscripts\_audio::deprecated_aud_play_2d_sound("sonar_vision_on");
}

aud_sonar_vision_off() {
  soundscripts\_audio::deprecated_aud_play_2d_sound("sonar_vision_off");
  soundscripts\_audio_mix_manager::mm_clear_submix("sonar_vision", 1.0);
}

pdrone_death_explode() {
  var_0 = self;
  var_1 = var_0.origin;

  while (isdefined(var_0)) {
    var_1 = var_0.origin;
    wait 0.05;
  }

  soundscripts\_snd_playsound::snd_play_at("pdrone_exp", var_1);
}

pdrone_emp_death(var_0) {
  var_0 soundscripts\_snd_playsound::snd_play_linked("pdrone_emp_death");
  var_0 soundscripts\_snd_playsound::snd_play_linked("pdrone_deathspin", "kill_drone_deathspin");
}

pdrone_crash_land(var_0) {
  soundscripts\_snd_playsound::snd_play_at("pdrone_exp", var_0);
  level notify("kill_drone_deathspin");
}

doorshield_ripoff() {
  snd_enable_soundcontextoverride("bullet_metal_vehicle");
  soundscripts\_audio_mix_manager::mm_add_submix("doorshield_rip_player");
  soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_foley_plr", 0.15);
  soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_grabs_plr", 0.2);
  soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_tension_plr", 0.85);
  soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_rip_plr", 1.1);
  soundscripts\_snd_playsound::snd_play_delayed_2d("doorshield_debris_plr", 1.15);
  wait 3;
  soundscripts\_audio_mix_manager::mm_clear_submix("doorshield_rip_player");
}

doorshield_throw() {
  soundscripts\_snd_playsound::snd_play_2d("exo_throw_start");
  snd_disable_soundcontextoverride("bullet_metal_vehicle");
}

exo_raise_shield() {
  soundscripts\_snd_playsound::snd_play_delayed_2d("exo_shield_open", 0.5);
  snd_enable_soundcontextoverride("bullet_metal_vehicle");
}

exo_lower_shield() {
  soundscripts\_snd_playsound::snd_play_delayed_2d("exo_shield_close", 0.05);
  snd_disable_soundcontextoverride("bullet_metal_vehicle");
}

boost_jump_enable() {}

boost_jump_disable() {}

boost_jump_disable_npc(var_0) {
  var_1 = var_0;
  soundscripts\_audio::deprecated_aud_play_linked_sound("tac_npc_boost_power_dwn", var_1);
}

boost_jump_player() {
  if(!isdefined(level._snd.boost_jump)) {
    level._snd.boost_jump = spawnstruct();
    level._snd.boost_jump.is_jumping = 0;
    thread init_boost_land_arrays();
  }

  var_0 = self;

  if(var_0 == level.player)
    level._snd.boost_jump.is_jumping = 1;
}

boost_land_player(var_0) {
  var_1 = 40;
  var_2 = 10;

  if(!isdefined(level._snd.boost_jump)) {
    level._snd.boost_jump = spawnstruct();
    level._snd.boost_jump.is_jumping = 0;
    thread init_boost_land_arrays();
  }

  var_3 = self;

  if(var_3 == level.player) {
    if(level._snd.boost_jump.is_jumping == 1) {
      var_4 = sndx_boost_land_get_impact_vol(var_0, var_1, var_2);
      var_5 = sndx_boost_land_get_impact_size(var_0, var_1, var_2);
      var_6 = "pc_boost_land_" + var_5;
      level._snd.boost_jump.is_jumping = 0;

      if(isdefined(level._snd.boost_jump.jump_sound))
        soundscripts\_audio::aud_fade_out_and_delete(level._snd.boost_jump.jump_sound, 0.5);

      if(var_0 < var_2) {
        return;
      }
      var_7 = playerphysicstraceinfo(var_3.origin + (0, 0, 16), var_3.origin + (0, 0, -16), var_3)["surfacetype"];
      var_8 = snd_is_valid_surface(var_7, level._snd.boost_jump.surfaces);

      if(var_8)
        var_9 = "boost_land_surface_" + var_5 + "_" + var_7;
    }
  }
}

sndx_boost_land_get_impact_vol(var_0, var_1, var_2) {
  var_0 = clamp(var_0, var_2, var_1);
  var_3 = var_0 / var_1;
  return var_3;
}

sndx_boost_land_get_impact_size(var_0, var_1, var_2) {
  if(var_0 <= var_2)
    var_3 = "lt";
  else if(var_0 <= var_1)
    var_3 = "med";
  else
    var_3 = "hvy";

  return var_3;
}

boost_jump_npc() {
  var_0 = self;

  if(level.script == "recovery")
    soundscripts\_audio::deprecated_aud_play_linked_sound("npc_boost_jump_rec", var_0);
  else
    soundscripts\_audio::deprecated_aud_play_linked_sound("npc_boost_jump", var_0);
}

boost_land_npc() {
  var_0 = self;

  if(level.script == "recovery")
    soundscripts\_audio::deprecated_aud_play_linked_sound("npc_boost_land_med_rec", var_0);
  else
    soundscripts\_audio::deprecated_aud_play_linked_sound("npc_boost_land_med", var_0);
}

boost_dodge_activate_plr() {
  level._snd.boost_jump.is_jumping = 0;

  if(isdefined(level._snd.boost_jump.jump_sound))
    soundscripts\_audio::aud_fade_out_and_delete(level._snd.boost_jump.jump_sound, 0.5);
}

boost_land_hud_enable() {
  soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_pwrup");
}

boost_land_hud_disable() {
  soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_pwrdown");
}

boost_land_use_fuel(var_0) {
  var_1 = 0.5;

  if(!isdefined(level.aud.boost_land_on)) {
    level.aud.boost_land_on = 1;
    thread boost_land_play_oneshot();
    level.player soundscripts\_snd_playsound::snd_play_loop_linked("tac_pc_boost_land_assist_jet_lp", var_0, 0.1, 0.2);
    level waittill(var_0);
    var_2 = getlevelticks();

    if(!isdefined(level.aud.boost_land_release_start_time)) {
      level.aud.boost_land_release_start_time = var_2;
      soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_release");
    } else if(var_2 - level.aud.boost_land_release_start_time >= var_1 / 0.05) {
      level.aud.boost_land_release_start_time = var_2;
      soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_release");
    }

    level.aud.boost_land_on = undefined;
  }
}

boost_land_velocity_finder() {
  for (;;) {
    var_0 = length(level.player getvelocity());
    iprintlnbold(var_0);
    wait 0.05;
  }
}

boost_land_play_oneshot() {
  var_0 = 1000;
  var_1 = 7500;
  var_2 = 500;

  if(!isdefined(level.aud.boost_land_first_shot))
    level.aud.boost_land_first_shot = 1;

  if(!isdefined(level.aud.boost_land_max_locked_out))
    level.aud.boost_land_max_locked_out = 0;

  var_3 = length(level.player getvelocity());

  if(var_3 >= var_0 || level.aud.boost_land_first_shot == 1) {
    if(level.aud.boost_land_max_locked_out == 0) {
      thread boost_land_max_shot_timer();
      soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_shot_max");
      level.aud.boost_land_first_shot = 0;
    } else if(level.aud.boost_land_max_locked_out == 1)
      soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_shot_sml");
  } else if(var_3 < var_0 && var_3 >= var_2)
    soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_shot_med");
  else if(var_3 < var_1)
    soundscripts\_snd_playsound::snd_play_2d("tac_pc_boost_land_assist_shot_sml");
}

boost_land_max_shot_timer() {
  var_0 = 4.0;

  if(!isdefined(level.aud.boost_land_max_shot_timer))
    level.aud.boost_land_max_shot_timer = 0;

  for (;;) {
    level.aud.boost_land_max_shot_timer = level.aud.boost_land_max_shot_timer + 0.1;
    level.aud.boost_land_max_locked_out = 1;
    wait 0.1;

    if(level.aud.boost_land_max_shot_timer > var_0) {
      level.aud.boost_land_max_shot_timer = 0;
      level.aud.boost_land_max_locked_out = 0;
      break;
    }
  }
}

boost_land_release_shot_timer() {
  var_0 = 0.1;

  if(!isdefined(level.aud.boost_land_release_shot_timer))
    level.aud.boost_land_release_shot_timer = 0;

  for (;;) {
    level.aud.boost_land_release_shot_timer = level.aud.boost_land_release_shot_timer + 0.1;
    level.aud.boost_land_release_locked_out = 1;
    wait 0.1;

    if(level.aud.boost_land_release_shot_timer > var_0) {
      level.aud.boost_land_release_shot_timer = 0;
      level.aud.boost_land_release_locked_out = 0;
      break;
    }
  }
}

boost_land_assist_npc() {
  soundscripts\_snd_playsound::snd_play_linked("boost_land_assist_npc");
}

boost_land_assist_npc_ground() {
  soundscripts\_snd_playsound::snd_play_linked("boost_land_assist_npc_ground");
}

boost_land_out_of_fuel() {}

tracking_grenade_hover(var_0) {
  var_0 soundscripts\_snd_playsound::snd_play_linked("track_grenade_hover", "kill_tracking_loop");
  var_0 soundscripts\_snd_playsound::snd_play_loop_linked("track_grenade_loop", "kill_tracking_loop", undefined, 1.2);
  var_0 waittill("death");
  level notify("kill_tracking_loop");
}

tracking_grenade_jump(var_0) {
  var_0 soundscripts\_snd_playsound::snd_play_linked("track_grenade_jump");
}

tracking_grenade_strike(var_0) {
  var_0 soundscripts\_snd_playsound::snd_play_linked("track_grenade_strike");
  var_0 notify("kill_tracking_loop");
}

tracking_grenade_dud(var_0) {
  var_0 soundscripts\_snd_playsound::snd_play_linked("track_grenade_dud");
  level notify("kill_tracking_loop");
}

tracking_grenade_beep(var_0) {
  var_0 soundscripts\_snd_playsound::snd_play_linked("track_grenade_beep");
}

anml_doberman(var_0) {
  var_1 = "anml_doberman_" + var_0;

  if(isdefined(self.snd_guid))
    level notify(self.snd_guid);

  self.snd_guid = "anml_doberman_" + soundscripts\_snd::snd_new_guid();

  if(var_0 == "death")
    soundscripts\_snd_playsound::snd_play_at(var_1, self.origin, self.snd_guid, 0, 0.1);
  else
    soundscripts\_snd_playsound::snd_play_linked(var_1, self.snd_guid, 0, 0.15);
}

finish_mission_fade(var_0) {
  soundscripts\_audio_mix_manager::mm_add_submix("mute_all", var_0);
}

snd_cloak_init() {
  common_scripts\utility::flag_init("snd_cloak_is_enabled");
}

exo_cloak_button_press() {
  soundscripts\_audio::deprecated_aud_play_2d_sound("exo_cloak_buttons");
}

exo_cloak_enable() {
  if(!common_scripts\utility::flag("snd_cloak_is_enabled")) {
    common_scripts\utility::flag_set("snd_cloak_is_enabled");
    soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_enable_click", level.player);
    soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_enable", level.player);
    soundscripts\_audio::deprecated_aud_delay_play_2d_sound("exo_cloak_enable_wide", 0.4);
  }

  thread exo_cloak_battery_low();
}

exo_cloak_disable() {
  common_scripts\utility::flag_clear("snd_cloak_is_enabled");
  soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_enable_click", level.player);
  soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_disable", level.player);
  soundscripts\_audio::deprecated_aud_delay_play_2d_sound("exo_cloak_disable_wide", 0.2);
  wait 1;
  thread exo_cloak_battery_recharge();
}

exo_cloak_battery_low() {
  level notify("kill_exo_cloak_battery_low");
  level endon("kill_exo_cloak_battery_low");
  var_0 = level._cloaked_stealth_settings.cloak_battery_level;
  var_1 = undefined;

  while (common_scripts\utility::flag("snd_cloak_is_enabled")) {
    var_2 = level._cloaked_stealth_settings.cloak_battery_level;

    if(var_2 <= 0.26 && var_0 > 0.26)
      var_1 = soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_battery_low", level.player, "loop", "notify_stop_exo_cloak_battery_low");
    else if(var_2 >= 0.26 && var_0 < 0.26)
      level notify("notify_stop_exo_cloak_battery_low");

    var_0 = var_2;
    wait 0.05;
  }

  if(isdefined(var_1)) {
    var_1 scalevolume(0, 0.25);
    wait 0.25;
    level notify("notify_stop_exo_cloak_battery_low");
  }
}

exo_cloak_battery_dead() {
  common_scripts\utility::flag_clear("snd_cloak_is_enabled");
  soundscripts\_audio::deprecated_aud_play_linked_sound("exo_cloak_disable", level.player);
  soundscripts\_audio::deprecated_aud_delay_play_2d_sound("exo_cloak_battery_dead", 0.25);
  wait 3;
  thread exo_cloak_battery_recharge();
}

exo_cloak_battery_recharge() {
  var_0 = soundscripts\_audio::deprecated_aud_play_2d_sound("exo_cloak_battery_recharge");

  while (level._cloaked_stealth_settings.cloak_battery_level < 1.0 && !common_scripts\utility::flag("snd_cloak_is_enabled"))
    wait 0.1;

  if(isdefined(var_0))
    var_0 scalevolume(0, 0.25);
}

npc_cloak_buttons(var_0) {
  var_1 = self;

  if(var_0 == "cornercrouch_right_cloak_toggle") {
    soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons", var_1, 1);
    soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons", var_1, 6.5);
  } else if(var_0 == "cornercrouch_left_cloak_toggle") {
    soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons", var_1, 1);
    soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons", var_1, 6.75);
  } else {
    soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons", var_1, 1.2);
    soundscripts\_audio::deprecated_aud_delay_play_linked_sound("exo_cloak_npc_buttons", var_1, 6.4);
  }
}

npc_cloak_enable() {
  var_0 = self;
  var_1 = gettime();

  if(var_1 > 1000)
    return;
}

overdrive_on() {
  level.player enablecustomweaponcontext();
  snd_enable_soundcontextoverride("slomo");
  soundscripts\_audio_zone_manager::azm_set_reverb_bypass(1);
  level.player setreverb("snd_enveffectsprio_level", "sewer", 1, 0.7, 1);
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
  soundscripts\_snd_filters::snd_fade_in_filter("overdrive", 1);
  soundscripts\_audio_mix_manager::mm_add_submix("overdrive", 1);
  soundscripts\_snd_timescale::snd_set_timescale("overdrive_timescale");
  soundscripts\_snd_playsound::snd_play_2d("overdrive_start", undefined, undefined, 0.25);
  soundscripts\_snd_playsound::snd_play_loop_2d("overdrive_loop", "kill_overdrive_loop", 1, 2);
  level.player waittill("death");
  soundscripts\_audio_mix_manager::mm_clear_submix("overdrive", 2.5);
  level notify("kill_overdrive_loop");
}

overdrive_off() {
  soundscripts\_snd_playsound::snd_play_2d("overdrive_stop");
  level notify("kill_overdrive_loop");
  soundscripts\_audio_mix_manager::mm_clear_submix("overdrive", 2);
  soundscripts\_snd_timescale::snd_set_timescale("default");
  level.player deactivatereverb("snd_enveffectsprio_level", 1);
  soundscripts\_audio_zone_manager::azm_set_reverb_bypass(0);
  soundscripts\_snd_filters::snd_fade_out_filter(2);
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
  snd_disable_soundcontextoverride("slomo");
  level.player disablecustomweaponcontext();
}

sonic_blast() {
  level.aud.sonic_blast_started = 1;
  soundscripts\_audio_mix_manager::mm_add_submix("sonic_attack");
  soundscripts\_snd_playsound::snd_play_2d("sonic_attack_shoot");
  soundscripts\_snd_filters::snd_fade_in_filter("sonic_attack", 0.25);
  wait 1.5;
  soundscripts\_snd_filters::snd_fade_out_filter(3.0);
}

sonic_blast_aftershock() {
  if(isdefined(level.aud.sonic_blast_started) && level.aud.sonic_blast_started == 1)
    level.aud.sonic_blast_started = 0;
  else
    soundscripts\_snd_playsound::snd_play_2d("sonic_attack_aftershock");
}

sonic_blast_done() {
  soundscripts\_audio_mix_manager::mm_clear_submix("sonic_attack");
}

exo_stim_on() {
  soundscripts\_snd_playsound::snd_play_2d("stim_activate");
}

aud_start_ragtime_warfare() {
  soundscripts\_audio_mix_manager::mm_add_submix("ragtime_warfare_cheat_mix");
  soundsettimescalefactor("music", 0);
  level.player thread common_scripts\utility::play_loop_sound_on_entity("cheat_chaplin_music", undefined, undefined, 2);
  level.player thread common_scripts\utility::play_loop_sound_on_entity("cheat_chaplin_projector_loop", undefined, undefined, 2);
}

aud_stop_ragtime_warfare() {
  soundscripts\_audio_mix_manager::mm_clear_submix("ragtime_warfare_cheat_mix");
  level.player common_scripts\utility::stop_loop_sound_on_entity("cheat_chaplin_music");
  level.player common_scripts\utility::stop_loop_sound_on_entity("cheat_chaplin_projector_loop");
}

aud_radiation_shellshock(var_0, var_1) {
  level.player endon("death");
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);

  if(level.player.radiation_state != var_0) {
    level.player.radiation_state = var_0;

    switch (level.player.radiation_state) {
      case "radiation_high":
        start_next_radiation_level("rad_shellshock_high", "item_geigercounter_high", "breathing_hurt");
        break;
      case "radiation_med":
        start_next_radiation_level("rad_shellshock_med", "item_geigercounter_med", "breathing_hurt");
        break;
      case "radiation_low":
        start_next_radiation_level("rad_shellshock_low", "item_geigercounter_med", "breathing_hurt");
        break;
      case "radiation_none":
        stop_radiation_level(4.0, "breathing_better");
        break;
    }
  }
}

start_next_radiation_level(var_0, var_1, var_2) {
  var_3 = 0.5;
  soundscripts\_snd_filters::snd_fade_out_filter(var_3);
  soundscripts\_snd_filters::snd_fade_in_filter(var_0, var_3);
  stop_shellshock_loop();
  level.player thread common_scripts\utility::play_loop_sound_on_entity(var_1);
  level.player playsound(var_2);
}

stop_radiation_level(var_0, var_1) {
  var_2 = 0.5;
  wait(var_0);
  soundscripts\_snd_filters::snd_fade_out_filter(var_2);
  wait 1.0;
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
  stop_shellshock_loop();
  level.player playsound(var_1);
}

stop_shellshock_loop() {
  level.player common_scripts\utility::stop_loop_sound_on_entity("item_geigercounter_high");
  level.player common_scripts\utility::stop_loop_sound_on_entity("item_geigercounter_med");
}

explo_ambientexp_dirt(var_0, var_1) {
  var_2 = spawnstruct();
  var_2.pos = var_0;
  var_2.exploder_num_ = var_1;
  var_2.incoming_alias_ = "exp_generic_incoming";
  var_2.speed_of_sound_ = 1;
  var_2.duck_alias_ = "exp_generic_explo_sub_kick";
  var_2.duck_dist_threshold_ = 1000;
  var_2.explo_delay_chance_ = 60;
  var_2.shake_dist_threshold_ = 2000;
  var_2.explo_debris_alias_ = "exp_debris_dirt_chunks";
  var_2.ground_zero_alias_ = "exp_grnd_zero_stone";
  var_2.ground_zero_dist_threshold_ = 500;
  snd_ambient_explosion(var_2);
}

explo_ambientexp_fireball(var_0) {
  var_1 = spawnstruct();
  var_1.pos = var_0;
  var_1.speed_of_sound_ = 1;
  var_1.duck_alias_ = "exp_generic_explo_sub_kick";
  var_1.duck_dist_threshold_ = 1000;
  var_1.explo_delay_chance_ = 60;
  var_1.shake_dist_threshold_ = 2000;
  var_1.explo_debris_alias_ = "exp_debris_dirt_chunks";
  var_1.ground_zero_alias_ = "exp_grnd_zero_stone";
  var_1.ground_zero_dist_threshold_ = 500;
  snd_ambient_explosion(var_1);
}

snd_air_vehicle_smart_flyby(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isdefined(var_2))
    var_5 = var_2;

  var_6 = 0;

  if(isdefined(var_3))
    var_6 = var_3;

  while (isdefined(self)) {
    if(var_6)
      var_7 = distance(self.origin, level.player.origin);
    else
      var_7 = distance2d(self.origin, level.player.origin);

    if(var_7 < var_1) {
      var_8 = spawn("script_origin", self.origin);
      var_8 linkto(self);
      var_8 playsound(var_0, "sounddone");
      var_8 thread sndx_air_vehicle_smart_flyby_deathspin(self, var_4);
      var_8 thread sndx_air_vehicle_smart_flyby_sounddone();
      var_8 waittill("flyby_ent", var_9);

      if(var_9 == "deathspin") {
        var_8 scalevolume(0.0, 0.3);
        wait 0.4;
        var_8 stopsounds();
        var_8 delete();
        return;
      } else if(var_9 == "sounddone") {
        wait 0.1;
        var_8 delete();
        return;
      }

      continue;
    }

    wait 0.05;
  }
}

sndx_air_vehicle_smart_flyby_deathspin(var_0, var_1) {
  self endon("flyby_ent");
  var_0 waittill("deathspin");
  self notify("flyby_ent", "deathspin");

  if(isdefined(var_1)) {
    var_2 = spawn("script_origin", self.origin);
    var_2 linkto(self);
    var_2 playsound(var_1, "sounddone");
    var_2 waittill("sounddone");
    var_2 delete();
  }
}

sndx_air_vehicle_smart_flyby_sounddone() {
  self endon("flyby_ent");
  self waittill("sounddone");
  self notify("flyby_ent", "sounddone");
}

snd_advanced_flyby_system(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("death");
  self endon("deathspin");
  self vehicle_turnengineoff();

  if(!isdefined(self.audio))
    self.audio = spawnstruct();

  self.audio.prev_dist = sndx_advanced_flyby_dist_check(var_4);
  self.audio.flying_over = 0;
  self.audio.flying_by = 0;
  self.audio.death_spining = 0;
  self.audio.approaching = 1;
  self.audio.debug_id = var_10;

  if(isdefined(var_5))
    thread sndx_advanced_flyby_deathspin(var_5, var_10);

  if(isdefined(var_6)) {
    var_12 = spawn("script_origin", self.origin);
    var_12 linkto(self);
    thread sndx_advanced_flyby_destruct(var_12, var_6, var_10);
  }

  self.audio.min_flyingover_wait = 5;

  if(isdefined(var_7))
    self.audio.min_flyingover_wait = var_7;

  self.audio.min_flyingby_wait = 3;

  if(isdefined(var_8))
    self.audio.min_flyingby_wait = var_8;

  var_13 = 0.05;

  if(isdefined(var_9))
    var_13 = var_9;

  if(isarray(var_1)) {
    foreach(var_16, var_15 in var_1)
    thread sndx_advanced_flyby_spawn_sound(var_16, var_15, var_10);
  }

  if(isarray(var_2)) {
    while (isdefined(self)) {
      var_17 = sndx_advanced_flyby_dist_check(var_4);

      for (var_18 = 0; var_18 < var_2.size; var_18++) {
        if(var_17 < var_2[var_18]) {
          if(var_18 == 0) {
            if(self.audio.approaching && self.audio.flying_over == 0 && self.audio.death_spining == 0) {
              var_19 = sndx_advanced_flyby_construct_alias(var_0, var_18, var_3, var_10);

              if(isdefined(var_19))
                thread sndx_advanced_flyby_playsound(var_19, var_18);
            } else if(var_17 < self.audio.prev_dist)
              self.audio.approaching = 1;
            else
              self.audio.approaching = 0;
          } else if(var_17 > self.audio.prev_dist) {
            if(self.audio.approaching && self.audio.flying_over == 0 && self.audio.flying_by == 0 && self.audio.death_spining == 0) {
              self.audio.approaching = 0;
              var_19 = sndx_advanced_flyby_construct_alias(var_0, var_18, var_3, var_10);

              if(isdefined(var_19))
                thread sndx_advanced_flyby_playsound(var_19, var_18);
            }
          } else
            self.audio.approaching = 1;

          break;
        }
      }

      self.audio.prev_dist = var_17;
      wait(var_13);
    }
  }
}

sndx_advanced_flyby_spawn_sound(var_0, var_1, var_2) {
  self endon("death");
  self endon("deathspin");
  wait(var_1);
  thread sndx_advanced_flyby_playsound(var_0);
}

sndx_advanced_flyby_dist_check(var_0) {
  var_1 = 0;

  if(isdefined(var_0))
    var_1 = var_0;

  if(var_1)
    var_2 = distance(self.origin, level.player.origin);
  else
    var_2 = distance2d(self.origin, level.player.origin);

  return var_2;
}

sndx_advanced_flyby_construct_alias(var_0, var_1, var_2, var_3) {
  var_4 = 0;
  var_5 = self vehicle_getvelocity();
  var_6 = length(var_5) * 0.0568182;

  if(var_6 > 5) {
    if(isarray(var_2)) {
      var_7 = level.player getvelocity();
      var_8 = var_5 - var_7;
      var_9 = length(var_8) * 0.0568182;

      for (var_10 = 0; var_10 < var_2.size; var_10++) {
        var_4 = var_10 + 1;

        if(var_9 > var_2[var_10]) {
          var_4 = var_10;
          break;
        }
      }
    }

    if(var_4 == 0)
      var_11 = "fast";
    else if(var_4 == 1)
      var_11 = "med";
    else
      var_11 = "slow";

    if(var_1 == 0)
      var_12 = "close";
    else if(var_1 == 1)
      var_12 = "mid";
    else if(var_1 == 2)
      var_12 = "far";
    else
      return undefined;

    var_13 = var_0 + "_" + var_11 + "_" + var_12;

    if(var_1 == 0)
      self.audio.flying_over = 1;
    else
      self.audio.flying_by = 1;

    return var_13;
  } else
    return undefined;
}

sndx_advanced_flyby_playsound(var_0, var_1) {
  thread sndx_advanced_flyby_retrigger_wait(var_1);
  var_2 = soundscripts\_audio::deprecated_aud_play_linked_sound(var_0, self);
  thread sndx_advanced_flyby_cleanup(var_2, "deathspin");
}

sndx_advanced_flyby_deathspin(var_0, var_1) {
  self endon("crash_done");
  self waittill("deathspin");
  var_2 = soundscripts\_audio::deprecated_aud_play_linked_sound(var_0, self);
  thread sndx_advanced_flyby_cleanup(var_2, "crash_done");
}

sndx_advanced_flyby_destruct(var_0, var_1, var_2) {
  self waittill("crash_done");
  var_3 = spawn("script_origin", var_0.origin);
  var_3 soundscripts\_snd_playsound::snd_play(var_1, "sounddone");
  var_3 waittill("sounddone");
  var_3 delete();
}

sndx_advanced_flyby_retrigger_wait(var_0) {
  if(isdefined(var_0)) {
    if(var_0 == 0) {
      wait(self.audio.min_flyingover_wait);

      if(isdefined(self))
        self.audio.flying_over = 0;
    } else {
      wait(self.audio.min_flyingby_wait);

      if(isdefined(self))
        self.audio.flying_by = 0;
    }
  }
}

sndx_advanced_flyby_cleanup(var_0, var_1, var_2) {
  self waittill(var_1);

  if(isdefined(var_0)) {
    var_3 = 0.3;

    if(isdefined(var_2))
      var_3 = var_2;

    var_0 scalevolume(0.0, var_3);
    wait(var_3);

    if(isdefined(var_0)) {
      var_0 stopsounds();
      wait 0.1;

      if(isdefined(var_0))
        var_0 delete();
    }
  }
}

snd_ambient_explosion(var_0) {
  var_1 = sndx_ambient_explosion_args_validation(var_0);
  thread sndx_ambient_explosion_internal(var_1);
}

sndx_ambient_explosion_args_validation(var_0) {
  if(!isdefined(level._snd.ambientexp))
    init_ambient_explosion_arrays();

  if(!isdefined(var_0.explo_shot_array_)) {
    var_0.explo_shot_array_ = level._snd.ambientexp["exp_generic_explo_shot"];

    if(!isdefined(var_0.explo_tail_alias_))
      var_0.explo_tail_alias_ = "exp_generic_explo_tail";
  }

  if(isdefined(var_0.duck_alias_)) {
    if(isdefined(var_0.duck_dist_threshold_))
      var_0.duck_dist_threshold_ = max(var_0.duck_dist_threshold_, 0);
    else
      var_0.duck_dist_threshold_ = 1000;
  }

  if(isdefined(var_0.explo_delay_chance_))
    var_0.explo_delay_chance_ = max(var_0.explo_delay_chance_, 0);
  else
    var_0.explo_delay_chance_ = 50;

  if(isdefined(var_0.shake_dist_threshold_))
    var_0.shake_dist_threshold_ = max(var_0.shake_dist_threshold_, 0);

  if(!isdefined(var_0.shake_envelope_))
    var_0.shake_envelope_ = level._snd.envs["explo_shake_over_distance"];

  if(isdefined(var_0.shake_durration_))
    var_0.shake_durration_ = max(var_0.shake_durration_, 0);
  else
    var_0.shake_durration_ = 0.5;

  if(isdefined(var_0.ground_zero_alias_)) {
    if(isdefined(var_0.ground_zero_dist_threshold_))
      var_0.ground_zero_dist_threshold_ = max(var_0.ground_zero_dist_threshold_, 0);
    else
      var_0.ground_zero_dist_threshold_ = 500;
  }

  return var_0;
}

sndx_ambient_explosion_internal(var_0) {
  var_1 = var_0.pos;
  var_2 = var_0.exploder_num_;
  var_3 = var_0.incoming_alias_;
  var_4 = var_0.speed_of_sound_;
  var_5 = var_0.explo_shot_array_;
  var_6 = var_0.duck_alias_;
  var_7 = var_0.duck_dist_threshold_;
  var_8 = var_0.explo_delay_chance_;
  var_9 = var_0.explo_tail_alias_;
  var_10 = var_0.shake_dist_threshold_;
  var_11 = var_0.shake_envelope_;
  var_12 = var_0.shake_durration_;
  var_13 = var_0.explo_debris_alias_;
  var_14 = var_0.ground_zero_alias_;
  var_15 = var_0.ground_zero_dist_threshold_;
  var_16 = distance(level.player.origin, var_1);

  if(isdefined(var_4) && var_4 == 1) {
    var_17 = var_16 * 0.0000833333;
    wait(var_17);
  }

  if(isdefined(var_2)) {
    if(isdefined(var_3))
      common_scripts\utility::play_sound_in_space(var_3, var_1);

    common_scripts\_exploder::exploder(var_2);
  }

  var_18 = randomint(var_5.size);
  var_19 = var_5[var_18];
  var_20 = var_19[0];
  thread common_scripts\utility::play_sound_in_space(var_20, var_1);

  if(isdefined(var_6)) {
    if(var_16 < var_7)
      thread common_scripts\utility::play_sound_in_space(var_6, var_1);
  }

  var_21 = var_19[1];

  if(isdefined(var_21)) {
    if(soundscripts\_audio::aud_percent_chance(var_8))
      wait(var_21);
  }

  if(isdefined(var_9))
    thread common_scripts\utility::play_sound_in_space(var_9, var_1);

  if(isdefined(var_10)) {
    if(var_16 < var_10) {
      var_22 = var_16 / var_10;
      var_23 = soundscripts\_audio::deprecated_aud_map2(var_22, var_11);
      earthquake(var_23, var_12, level.player.origin, var_10);
    }
  }

  if(isdefined(var_13))
    thread common_scripts\utility::play_sound_in_space(var_13, var_1);

  if(isdefined(var_14) && var_16 < var_15)
    thread common_scripts\utility::play_sound_in_space(var_14, var_1);
}

snd_impact(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_0 + "_" + var_1 + "_" + var_2;

  if(isdefined(var_4))
    var_6 = soundscripts\_audio::deprecated_aud_play_linked_sound(var_5, var_4, undefined, undefined, undefined, undefined, var_3);
  else
    var_6 = soundscripts\_audio::deprecated_aud_play_sound_at(var_5, var_3);

  return var_6;
}

snd_play_vehicle_collision(var_0, var_1, var_2) {
  var_3 = var_0["vehicle"];
  var_4 = var_3 sndx_vehicle_collision_args_setup(var_0, var_1, var_2);
  var_3 thread sndx_play_vehicle_collision_internal(var_4);
}

start_vehicle_shell_shock(var_0) {
  level.player endon("death");
  var_1 = 1.0;
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(1);
  soundscripts\_snd_filters::snd_fade_in_filter("vehicle_shellshock", 0.5);
  var_2 = min(0, var_0 - var_1);
  wait(var_2);
  soundscripts\_snd_filters::snd_fade_out_filter(var_1);
  soundscripts\_audio_zone_manager::azm_set_filter_bypass(0);
}

sndx_vehicle_collision_args_setup(var_0, var_1, var_2) {
  if(!isdefined(self.audio))
    self.audio = spawnstruct();

  if(!isarray(var_1))
    var_1 = [];

  self.audio.debug = soundscripts\_audio::aud_get_optional_param(0, var_1["Debug"]);
  self.audio.vehicleid = soundscripts\_audio::aud_get_optional_param("veh_impact", var_1["VehicleID"]);
  self.audio.pv_minvelocitythreshold = soundscripts\_audio::aud_get_optional_param(25, var_1["PV_MinVelocityThreshold"]);
  self.audio.pv_maxvelocity = soundscripts\_audio::aud_get_optional_param(1000, var_1["PV_MaxVelocity"]);
  self.audio.pv_numvelocityranges = soundscripts\_audio::aud_get_optional_param(3, var_1["PV_NumVelocityRanges"]);
  self.audio.pv_maxsmlvelocity = soundscripts\_audio::aud_get_optional_param(100, var_1["PV_MaxSmlVelocity"]);
  self.audio.pv_maxmedvelocity = soundscripts\_audio::aud_get_optional_param(600, var_1["PV_MaxMedVelocity"]);
  self.audio.pv_maxlrgvelocity = soundscripts\_audio::aud_get_optional_param(1000, var_1["PV_MaxLrgVelocity"]);
  self.audio.npc_minvelocitythreshold = soundscripts\_audio::aud_get_optional_param(25, var_1["NPC_MinVelocityThreshold"]);
  self.audio.npc_maxvelocity = soundscripts\_audio::aud_get_optional_param(800, var_1["NPC_MaxVelocity"]);
  self.audio.npc_numvelocityranges = soundscripts\_audio::aud_get_optional_param(3, var_1["NPC_NumVelocityRanges"]);
  self.audio.npc_maxsmlvelocity = soundscripts\_audio::aud_get_optional_param(100, var_1["NPC_MaxSmlVelocity"]);
  self.audio.npc_maxmedvelocity = soundscripts\_audio::aud_get_optional_param(400, var_1["NPC_MaxMedVelocity"]);
  self.audio.npc_maxlrgvelocity = soundscripts\_audio::aud_get_optional_param(800, var_1["NPC_MaxLrgVelocity"]);
  self.audio.minlfevolumethreshold = soundscripts\_audio::aud_get_optional_param(0.0, var_1["MinLFEVolumeThreshold"]);
  self.audio.fallvelmultiplier = soundscripts\_audio::aud_get_optional_param(2, var_1["FallVelMultiplier"]);
  self.audio.mintimethreshold = soundscripts\_audio::aud_get_optional_param(250, var_1["MinTimeThreshold"]);
  self.audio.tireskidprobability = soundscripts\_audio::aud_get_optional_param(35, var_1["TireSkidProbability"]);
  self.audio.maxdistancethreshold = soundscripts\_audio::aud_get_optional_param(6000, var_1["MaxDistanceThreshold"]);
  self.audio.medvolmin = soundscripts\_audio::aud_get_optional_param(0.1, var_1["MedVolMin"]);
  self.audio.lrgvolmin = soundscripts\_audio::aud_get_optional_param(0.3, var_1["LrgVolMin"]);
  self.audio.nonplayerimpvolreduction = soundscripts\_audio::aud_get_optional_param(0.0, var_1["NonPlayerImpVolReduction"]);

  if(!isdefined(self.audio.prev_impacttime))
    self.audio.prev_impacttime = 0;

  if(!isdefined(level._snd.veh_collision)) {
    level._snd.veh_collision = spawnstruct();
    init_impact_system_arrays();
    level._snd.veh_collision.is_scraping = 0;
    level._snd.veh_collision.scrapeenabled = soundscripts\_audio::aud_get_optional_param(1, var_1["ScrapeEnabled"]);
    level._snd.veh_collision.scrapeseperationtime = soundscripts\_audio::aud_get_optional_param(0.5, var_1["ScrapeSeperationTime"]);
    level._snd.veh_collision.scrapefadeouttime = soundscripts\_audio::aud_get_optional_param(0.5, var_1["ScrapeFadeOutTime"]);
    level._snd.veh_collision.scrapeupdaterate = soundscripts\_audio::aud_get_optional_param(0.05, var_1["ScrapeUpdateRate"]);
  }

  if(var_0["surface"] == "none")
    var_0["surface"] = "vehicle";

  var_3 = level._snd.veh_collision.surfaces;

  if(isdefined(var_2))
    var_3 = var_2;

  if(!snd_is_valid_surface(var_0["surface"], var_3))
    var_0["surface"] = "default";

  return var_0;
}

sndx_play_vehicle_collision_internal(var_0) {
  var_1 = self;
  var_2 = var_0["hit_entity"];
  var_3 = var_0["pos"];
  var_4 = var_0["impulse"];
  var_5 = var_0["relativeVel"];
  var_6 = var_0["surface"];
  var_7 = (var_5[0], var_5[1], 0);
  var_8 = length(var_7);
  var_9 = abs(var_5[2]) * self.audio.fallvelmultiplier;
  var_10 = distance(var_3, level.player.origin);
  var_11 = gettime();
  var_12 = var_11 - self.audio.prev_impacttime;
  var_13 = undefined;
  var_14 = undefined;
  var_15 = 0;

  if(isdefined(level.player.drivingvehicle)) {
    var_13 = level.player.drivingvehicle;

    if(isdefined(var_2) && var_2 == var_13 || var_1 == var_13) {
      var_14 = var_13;
      var_15 = 1;

      if(level._snd.veh_collision.is_scraping)
        thread sndx_vehicle_collision_scrape_timer();
    }
  }

  if(var_10 < self.audio.maxdistancethreshold && var_8 > self.audio.pv_minvelocitythreshold) {
    var_8 = clamp(var_8, 0, self.audio.pv_maxvelocity);
    var_9 = clamp(var_9, 0, self.audio.pv_maxvelocity);
    var_16 = var_8;

    if(var_9 > var_8)
      var_16 = var_9;

    if(var_15) {
      var_17 = sndx_vehicle_collision_get_impact_size(var_16, self.audio.pv_maxsmlvelocity, self.audio.pv_maxmedvelocity);
      var_18 = sndx_vehicle_collision_get_impact_vol(var_16, self.audio.pv_maxsmlvelocity, self.audio.pv_maxmedvelocity, self.audio.pv_maxlrgvelocity);
      var_19 = "PV-IMPACT";
    } else {
      var_17 = sndx_vehicle_collision_get_impact_size(var_16, self.audio.npc_maxsmlvelocity, self.audio.npc_maxmedvelocity);
      var_18 = sndx_vehicle_collision_get_impact_vol(var_16, self.audio.npc_maxsmlvelocity, self.audio.npc_maxmedvelocity, self.audio.npc_maxlrgvelocity);
      var_19 = "NPC-IMPACT";

      if(var_17 == "sml") {
        return;
      }
      clamp(var_18, self.audio.nonplayerimpvolreduction, 1.0);
      var_18 = var_18 - self.audio.nonplayerimpvolreduction;
    }

    if(var_12 < self.audio.mintimethreshold) {
      if(var_17 == "sml") {
        return;
      }
      if(!var_15)
        return;
    }

    self.audio.prev_impacttime = var_11;

    if(var_15) {
      if(level._snd.veh_collision.scrapeenabled) {
        if(var_12 <= self.audio.mintimethreshold) {
          level._snd.veh_collision.scrape_pos = var_3;

          if(!level._snd.veh_collision.is_scraping)
            thread sndx_vehicle_collision_scrape(var_13);
          else
            return;
        } else if(level._snd.veh_collision.is_scraping)
          sndx_vehicle_collision_stop_scrapes();
      }
    }

    if(isdefined(var_13) && var_1 != var_13) {
      if(randomint(100) < self.audio.tireskidprobability)
        soundscripts\_audio::deprecated_aud_play_sound_at("vehicle_tire_skid", var_3);
    }

    var_20 = soundscripts\_audio::deprecated_aud_map2(var_18, level._snd.envs["veh_crash_intensity_to_pitch"]);
    var_21 = snd_impact(self.audio.vehicleid, var_6, var_17, var_3, var_14);
    var_21 scalevolume(var_18, 0.1);
    var_21 scalepitch(var_20, 0.1);

    if(var_15 && var_17 != "sml") {
      var_22 = soundscripts\_audio::deprecated_aud_map2(var_16, level._snd.envs["veh_crash_vel_to_lfe_vol"]);

      if(var_22 > self.audio.minlfevolumethreshold) {
        var_23 = snd_impact(self.audio.vehicleid, var_6, "lfe", var_3);
        var_23 scalevolume(var_22, 0.1);
      }
    }
  }
}

sndx_vehicle_collision_get_impact_size(var_0, var_1, var_2) {
  if(var_0 <= var_1)
    var_3 = "sml";
  else if(var_0 <= var_2)
    var_3 = "med";
  else
    var_3 = "lrg";

  return var_3;
}

sndx_vehicle_collision_get_impact_vol(var_0, var_1, var_2, var_3) {
  if(var_0 <= var_1)
    var_4 = var_0 / var_1;
  else if(var_0 <= self.audio.pv_maxmedvelocity) {
    var_4 = var_0 / var_2;

    if(var_4 < self.audio.medvolmin)
      var_4 = self.audio.medvolmin;
  } else {
    var_4 = var_0 / var_3;

    if(var_4 < self.audio.lrgvolmin)
      var_4 = self.audio.lrgvolmin;
  }

  return var_4;
}

sndx_vehicle_collision_scrape(var_0) {
  level._snd.veh_collision.is_scraping = 1;
  level endon("aud_stop_vehicle_scraping");

  while (level._snd.veh_collision.is_scraping) {
    if(isdefined(var_0)) {
      var_1 = var_0.origin;

      if(isdefined(level._snd.veh_collision.scrape_pos))
        var_1 = level._snd.veh_collision.scrape_pos;

      var_2 = var_0.audio.vehicleid + "_scrape";
      var_3 = soundscripts\_audio::deprecated_aud_play_linked_sound(var_2, var_0, undefined, undefined, undefined, undefined, var_1);

      if(!isdefined(level._snd.veh_collision.scrape_sounds))
        level._snd.veh_collision.scrape_sounds = [];

      level._snd.veh_collision.scrape_sounds[level._snd.veh_collision.scrape_sounds.size] = var_3;
    }

    wait 0.05;
    wait(level._snd.veh_collision.scrapeseperationtime);
  }
}

sndx_vehicle_collision_scrape_timer() {
  level notify("aud_vehicle_collision_scrape_timer_reset");
  level endon("aud_vehicle_collision_scrape_timer_reset");
  wait(level._snd.veh_collision.scrapeupdaterate);
  waittillframeend;
  sndx_vehicle_collision_stop_scrapes();
}

sndx_vehicle_collision_stop_scrapes(var_0) {
  var_1 = level._snd.veh_collision.scrapefadeouttime;

  if(isdefined(var_0))
    var_1 = var_0;

  level notify("aud_stop_vehicle_scraping");
  level._snd.veh_collision.is_scraping = 0;

  if(isdefined(level._snd.veh_collision.scrape_sounds)) {
    for (var_2 = 0; var_2 < level._snd.veh_collision.scrape_sounds.size; var_2++) {
      if(isdefined(level._snd.veh_collision.scrape_sounds[var_2])) {
        var_3 = level._snd.veh_collision.scrape_sounds[var_2];
        thread soundscripts\_audio::aud_fade_out_and_delete(var_3, var_1);
      }
    }

    level._snd.veh_collision.scrape_sounds = undefined;
  }
}

sndx_vehicle_collision_print_stats(var_0, var_1, var_2, var_3) {
  if(self.audio.debug) {
    if(!isdefined(var_1))
      var_1 = "-";

    if(!isdefined(var_2))
      var_2 = "-";

    if(!isdefined(var_3))
      var_3 = "-";

    if(self.audio.output_type) {
      if(isdefined(var_0))
        return;
    } else {

    }
  }
}

sndx_vehicle_collision_print_impact(var_0, var_1, var_2, var_3) {
  if(self.audio.debug) {
    if(!isdefined(var_0))
      var_0 = "-";

    if(!isdefined(var_1))
      var_1 = "-";

    if(!isdefined(var_2))
      var_2 = "-";

    if(!isdefined(var_3))
      var_3 = "-";
  }
}

sndx_vehicle_collision_dpad_up() {
  soundscripts\_audio_mix_manager::mm_add_submix("impact_system_solo");
}

sndx_vehicle_collision_dpad_down() {
  soundscripts\_audio_mix_manager::mm_clear_submix("impact_system_solo");
}

sndx_vehicle_collision_dpad_left() {
  if(isdefined(self.audio.input_type))
    self.audio.output_type = 1;
}

sndx_vehicle_collision_dpad_right() {
  if(isdefined(self.audio.input_type))
    self.audio.output_type = 0;
}

snd_is_valid_surface(var_0, var_1) {
  var_2 = 0;

  for (var_3 = 0; var_3 < var_1.size; var_3++) {
    if(var_0 == var_1[var_3]) {
      var_2 = 1;
      break;
    }
  }

  return var_2;
}

snd_dpad_functions(var_0, var_1, var_2, var_3) {
  level.player notifyonplayercommand("dpad_action_01", "+actionslot 1");
  level.player notifyonplayercommand("dpad_action_02", "+actionslot 2");
  level.player notifyonplayercommand("dpad_action_03", "+actionslot 3");
  level.player notifyonplayercommand("dpad_action_04", "+actionslot 4");
  thread sndx_dpad_function_watch("dpad_action_01", var_0);
  thread sndx_dpad_function_watch("dpad_action_02", var_1);
  thread sndx_dpad_function_watch("dpad_action_03", var_2);
  thread sndx_dpad_function_watch("dpad_action_04", var_3);
}

sndx_dpad_function_watch(var_0, var_1) {
  if(isdefined(var_0)) {
    for (;;) {
      level.player waittill(var_0);

      if(isdefined(var_1))
        thread[[var_1]]();

      wait 0.05;
    }
  }
}

snd_waittill_within_radius(var_0, var_1, var_2) {
  var_3 = 0;
  var_1 = soundscripts\_audio::aud_get_optional_param(1, var_1);
  var_2 = soundscripts\_audio::aud_get_optional_param(0.1, var_2);

  while (isdefined(self) && !var_3) {
    if(var_1) {
      if(distance(self.origin, level.player.origin) < var_0)
        var_3 = 1;
    } else if(distance2d(self.origin, level.player.origin) < var_0)
      var_3 = 1;

    wait(var_2);
  }

  return var_3;
}

snd_notify_within_radius(var_0, var_1, var_2, var_3) {
  thread sndx_notify_within_radius(var_0, var_1, var_2);
}

sndx_notify_within_radius(var_0, var_1, var_2, var_3) {
  var_4 = snd_waittill_within_radius(var_1, var_2, var_3);
  level notify(var_0, var_4);
}

snd_debug_value_add(var_0, var_1, var_2) {}

snd_debug_value_update(var_0, var_1) {}

snd_debug_value_delete(var_0) {}

sndx_debug_value_add(var_0, var_1, var_2, var_3) {}

sndx_debug_value_reorder(var_0, var_1) {}

sndx_debug_value_destroy(var_0) {}

snd_debug_timer(var_0, var_1) {}

snd_wait_for_enemies_aware(var_0) {
  for (;;) {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(var_3 isenemyaware()) {
        if(isstring(var_0))
          level notify(var_0);

        return;
      }
    }

    wait 0.2;
  }
}

snd_wait_for_enemies_see_player(var_0) {
  for (;;) {
    var_1 = getaiarray("axis");

    foreach(var_3 in var_1) {
      if(var_3 cansee(level.player)) {
        if(isstring(var_0))
          level notify(var_0);

        return;
      }
    }

    wait 0.2;
  }
}

snd_enemies_can_see_player() {
  var_0 = 0;
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(var_3 cansee(level.player)) {
      var_0 = 1;
      break;
    }
  }

  return var_0;
}

snd_get_num_enemies_aware() {
  var_0 = 0;
  var_1 = getaiarray("axis");

  foreach(var_3 in var_1) {
    if(var_3 isenemyaware())
      var_0 = var_0 + 1;
  }

  return var_0;
}

_snd_update_soundcontextoverride() {
  foreach(var_1 in level._snd.context_overrides) {
    if(var_1[1]) {
      enablesoundcontextoverride(var_1[0]);
      return;
    }
  }

  disablesoundcontextoverride();
}

snd_enable_soundcontextoverride(var_0) {
  foreach(var_3, var_2 in level._snd.context_overrides) {
    if(var_2[0] == var_0) {
      level._snd.context_overrides[var_3][1] = 1;
      _snd_update_soundcontextoverride();
      return;
    }
  }

  soundscripts\_audio::aud_print_error("Trying to enable override sound context that was not configured: " + var_0);
}

snd_disable_soundcontextoverride(var_0) {
  foreach(var_3, var_2 in level._snd.context_overrides) {
    if(var_2[0] == var_0) {
      level._snd.context_overrides[var_3][1] = 0;
      _snd_update_soundcontextoverride();
      return;
    }
  }

  soundscripts\_audio::aud_print_error("Trying to disable override sound context that was not configured: " + var_0);
}