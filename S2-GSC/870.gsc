/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 870.gsc
*********************************************/

lib_0366::func_8E25() {
  level lib_0366::func_8E44();
  level lib_0366::func_8E27();
  level thread snd_level_handle_zombie_round_countdown_started();
  level thread snd_level_handle_zombie_wave_started();
  level thread snd_level_handle_zombie_wave_ended();
  var_00 = [];
  var_01 = [];
  var_02 = [];
  var_03 = function_027A("mp/zmCharacterIdTable.csv");
  for(var_04 = 0; var_04 < var_03; var_04++) {
    var_05 = var_00.size;
    var_06 = tablelookupbyrow("mp/zmCharacterIdTable.csv", var_04, 13);
    var_00[var_05] = var_06;
    var_07 = tablelookupbyrow("mp/zmCharacterIdTable.csv", var_04, 15);
    if(isDefined(var_07)) {
      var_01[var_05] = var_07;
    }

    var_08 = tablelookupbyrow("mp/zmCharacterIdTable.csv", var_04, 16);
    if(isDefined(var_08)) {
      var_02[var_05] = var_08;
    }
  }

  level lib_0367::func_8E3A(var_00, ::lib_0366::func_8E75, var_01, var_02);
  level.var_071D.threat_to_dlg_vol_scalar = [[0, 0.75], [1, 1]];
  level.var_071D.round_countdown_alias = "hvox_breath_countdown";
  level.var_071D.round_countdown_end_alias = undefined;
  level.var_071D.global_threat_scalar = 0.666;
  level._snd_num_players_in_combat = 0;
  level.var_071D.map_wave_music_master_volume_scalar = 1;
  level.var_071D.zombie_vox_attack_hit_prev_time = 0;
  level.var_071D.zombie_vox_attack_hit_wait_time_min = 3;
  level.var_071D.zombie_vox_attack_hit_wait_time_max = 5;
  level.var_071D.zombie_vox_attack_hit_wait_time = randomintrange(2, 4);
  level.var_071D.zombie_vox_attack_hit_req_names = ["attack_hit", "anim_sprint_attack_1", "anim_sprint_attack_2", "anim_sprint_attack_3", "anim_stand_attack_1", "anim_stand_attack_2", "anim_stand_attack_3"];
  level thread sndx_monitor_num_players_in_combat(::sndx_update_global_threat_scalar);
  lib_0547::func_7BA9(::lib_0366::func_8E2E);
}

lib_0366::func_8E75(param_00, param_01, param_02) {
  var_03 = self;
  var_04 = 1;
  if(param_00 == "begin") {
    var_03 method_85A7("snd_zmb_player_is_speaking", 1);
    var_03 method_8626("zmb_mute_player_vox", 0);
    var_04 = var_03 sndx_get_threat_dialog_volume();
  } else if(param_00 == "end") {
    var_03 method_85A7("snd_zmb_player_is_speaking", 0);
    var_03 method_8627("zmb_mute_player_vox", 0.5);
  }

  return var_04;
}

sndx_get_threat_dialog_volume() {
  var_00 = lib_0366::func_8E14();
  return lib_0378::func_8D72(var_00, level.var_071D.threat_to_dlg_vol_scalar);
}

lib_0366::func_8E44() {
  lib_0378::func_8DC7("player_connect", ::lib_0366::func_7247);
  lib_0378::func_8DC7("onZombieSpawn", ::lib_0366::func_ABFA);
  lib_0378::func_8DC7("onZombieDamaged", ::lib_0366::func_6BD1);
  lib_0378::func_8DC7("onZombieKilled", ::lib_0366::func_6BD4);
  lib_0378::func_8DC7("objective_complete", ::lib_0366::func_690B);
  lib_0378::func_8DC7("snd_zmb_mus_start", ::lib_0366::func_8E31);
  lib_0378::func_8DC7("snd_zmb_mus_stop", ::lib_0366::func_8E32);
  lib_0378::func_8DC7("snd_zmb_mus_stop_all_players", ::lib_0366::func_8E33);
  lib_0378::func_8DC7("simple_jump_scare", ::lib_0366::func_8C59);
  lib_0378::func_8DC7("zombie_set_anim_state", ::lib_0366::func_ABF0);
  lib_0378::func_8DC7("set_client_sticky_threat", ::lib_0366::func_8E47);
  lib_0378::func_8DC7("clear_client_sticky_threat", ::lib_0366::func_8E09);
  lib_0378::func_8DC7("vox_request", ::lib_0366::func_8E4B);
  lib_0378::func_8DC7("aud_raven_sword_power_up", ::lib_0366::func_7A83);
  lib_0378::func_8DC7("aud_raven_sword_power_dwn", ::lib_0366::func_7A82);
  lib_0378::func_8DC7("aud_raven_sword_aoe", ::lib_0366::func_7A7A);
  lib_0378::func_8DC7("zombies_2016_gl_ending", ::lib_0366::func_AC3C);
  lib_0378::func_8DC7("trap_spinner_activate", ::lib_0366::func_9CC9);
  lib_0378::func_8DC7("money_spend", ::lib_0366::func_62D2);
  lib_0378::func_8DC7("found_collectible", ::lib_0366::func_3E42);
  lib_0378::func_8DC7("zombie_ignite", ::lib_0366::func_ABCE);
  lib_0378::func_8DC7("zombie_extinguish", ::lib_0366::func_ABA2);
  lib_0378::func_8DC7("zombie_fall_impact", ::lib_0366::func_ABA3);
  lib_0378::func_8DC7("mystery_box_attract_on", ::lib_0366::func_65F0);
  lib_0378::func_8DC7("mystery_box_attract_off", ::lib_0366::func_65EF);
  lib_0378::func_8DC7("mystery_box_attract_open", ::lib_0366::func_65F1);
  lib_0378::func_8DC7("mystery_box_attract_closed", ::lib_0366::func_65EE);
  lib_0378::func_8DC7("mystery_box_elec", ::lib_0366::func_65F3);
  lib_0378::func_8DC7("mystery_box_open", ::lib_0366::func_65F5);
  lib_0378::func_8DC7("mystery_box_close", ::lib_0366::func_65F2);
  lib_0378::func_8DC7("play_bird_loop", ::lib_0366::func_70C3);
  lib_0378::func_8DC7("stop_bird_loop", ::lib_0366::func_93BD);
  lib_0378::func_8DC7("play_bird_retreat", ::lib_0366::func_70C4);
  lib_0378::func_8DC7("electric_cherry_vfx", ::lib_0366::func_35AE);
  lib_0378::func_8DC7("flamethrower_start", ::lib_0366::func_3D25);
  lib_0378::func_8DC7("flamethrower_stop", ::lib_0366::func_3D26);
  lib_0378::func_8DC7("uber_battery_spawn", ::lib_0366::func_9FE4);
  lib_0378::func_8DC7("tesla_hc_energy_lamp_destruct", ::lib_0366::func_98F1);
  lib_0378::func_8DC7("tesla_hc_energy_lamp_loop_on", ::lib_0366::func_98F3);
  lib_0378::func_8DC7("tesla_hc_energy_lamp_loop_off", ::lib_0366::func_98F2);
  lib_0378::func_8DC7("wpn_bouncingbetty_trigger", ::lib_0366::func_AA91);
  lib_0378::func_8DC7("wpn_bouncingbetty_spin", ::lib_0366::func_AA90);
  lib_0378::func_8DC7("wpn_bouncingbetty_exp", ::lib_0366::func_AA8F);
  lib_0378::func_8DC7("aud_jack_in_box_land", ::lib_0366::func_5872);
  lib_0378::func_8DC7("aud_jack_open", ::lib_0366::func_5873);
  lib_0378::func_8DC7("aud_jack_in_box_explode", ::lib_0366::func_5871);
  lib_0378::func_8DC7("aud_use_armor_machine", ::lib_0366::func_A1D6);
  lib_0378::func_8DC7("aud_stunning_burst_use", ::lib_0366::func_94BC);
  lib_0378::func_8DC7("aud_stun_zombies_strt", ::lib_0366::func_94B8);
  lib_0378::func_8DC7("aud_stun_zombies_end", ::lib_0366::func_94B7);
  lib_0378::func_8DC7("aud_mad_minute_use", ::lib_0366::func_5F5B);
  lib_0378::func_8DC7("aud_taunt_use", ::lib_0366::func_983A);
  lib_0378::func_8DC7("aud_camo_use", ::lib_0366::func_1EBA);
  lib_0378::func_8DC7("aud_assassin_use_camoflage", ::assassin_use_camoflage);
  lib_0378::func_8DC7("aud_assassin_use_shell_shock", ::assassin_use_shell_shock);
  lib_0378::func_8DC7("aud_assassin_use_taunt", ::assassin_use_taunt);
  lib_0378::func_8DC7("aud_strt_asn_camo_blur", ::strt_asn_camo_blur);
  lib_0378::func_8DC7("aud_stp_asn_camo_blur", ::stp_asn_camo_blur);
  lib_0378::func_8DC7("aud_treasurer_strt_timer", ::lib_0366::func_9D33);
  lib_0378::func_8DC7("aud_treasurer_end_timer", ::lib_0366::func_9D21);
  lib_0378::func_8DC7("aud_treasurer_fuse", ::lib_0366::func_9D22);
  lib_0378::func_8DC7("zmb_points_pickup", ::lib_0366::func_AB0A);
  lib_0378::func_8DC7("zmb_points_share", ::lib_0366::func_AB0B);
  lib_0378::func_8DC7("zmb_ravens_key_pickup", ::lib_0366::func_AB0C);
  lib_0378::func_8DC7("zmb_ballistic_aura", ::zmb_ballistic_aura);
  lib_0378::func_8DC7("brute_battle_complete_notification", ::lib_0366::func_1CB9);
  lib_0378::func_8DC7("ripsaw_spine_cut", ::ripsaw_spine_cut);
  lib_0378::func_8DC7("ripsaw_fatal_melee", ::ripsaw_fatal_melee);
  lib_0378::func_8DC7("aud_ripsaw_start_spinning", ::ripsaw_start_spinning);
  lib_0378::func_8DC7("aud_ripsaw_stop_spinning", ::ripsaw_stop_spinning);
  lib_0378::func_8DC7("aud_ber_wunderbuss_charge_beam", ::wunderbuss_bolt_charge_beam);
  lib_0378::func_8DC7("aud_ber_wunderbuss_charge_beam_end", ::wunderbuss_charge_beam_end);
  lib_0378::func_8DC7("zmb_bat_melee_hit_wooden", ::zmb_bat_melee_hit_wooden);
  lib_0378::func_8DC7("zmb_bat_melee_hit_metal", ::zmb_bat_melee_hit_metal);
  lib_0378::func_8DC7("zmb_hc_bat_aoe_fx", ::zmb_hc_bat_aoe_fx);
  lib_0378::func_8DC7("zmb_sword_melee_hit", ::zmb_sword_melee_hit);
  lib_0378::func_8DC7("zmb_sword_melee_hit_delayed", ::zmb_sword_melee_hit_delayed);
  lib_0378::func_8DC7("zmb_sword_aoe", ::zmb_sword_aoe);
  lib_0378::func_8DC7("zmb_knife_melee_hit", ::zmb_knife_melee_hit);
  lib_0378::func_8DC7("zmb_knife_finisher_effects", ::zmb_knife_finisher_effects);
  lib_0378::func_8DC7("zmb_axe_melee_hit", ::zmb_axe_melee_hit);
  lib_0378::func_8DC7("zmb_axe_melee_alt_hit", ::zmb_axe_melee_alt_hit);
  lib_0378::func_8DC7("zmb_axe_hc_melee_hit", ::zmb_axe_hc_melee_hit);
  lib_0378::func_8DC7("zmb_axe_hc_melee_alt_hit", ::zmb_axe_hc_melee_alt_hit);
  lib_0378::func_8DC7("zmb_siz_trans_fx_burst", ::zmb_siz_trans_fx_burst);
  lib_0378::func_8DC7("aud_zmb_uberschnell_pickup", ::zmb_uberschnell_pickup);
  lib_0378::func_8DC7("aud_wonder_weapon_electrocute_strt", ::lib_0366::func_AA59);
  lib_0378::func_8DC7("aud_wonder_weapon_electrocute_end", ::wonder_weapon_electrocute_end);
  lib_0378::func_8DC7("aud_moon_projectile_strt", ::lib_0366::func_6401);
  lib_0378::func_8DC7("aud_moon_projectile_end", ::lib_0366::func_6400);
  lib_0378::func_8DC7("aud_storm_proj_loop_strt", ::lib_0366::func_9433);
  lib_0378::func_8DC7("aud_storm_proj_loop_end", ::lib_0366::func_9432);
  lib_0378::func_8DC7("aud_ww_projectile_zap", ::lib_0366::func_AAC9);
  lib_0378::func_8DC7("aud_ww_blood_explode", ::lib_0366::func_AAC2);
  lib_0378::func_8DC7("aud_ww_death_explode", ::lib_0366::func_AAC3);
  lib_0378::func_8DC7("aud_pap_wpn_charlton_vortex", ::pap_wpn_charlton_vortex);
  lib_0378::func_8DC7("aud_pap_wpn_crossbow_cricket_shot", ::pap_wpn_crossbow_cricket_shot);
  lib_0378::func_8DC7("aud_pap_wpn_crossbow_cricket_explo", ::pap_wpn_crossbow_cricket_explo);
  lib_0378::func_8DC7("aud_pap_wpn_emp44_bomb_reload", ::pap_wpn_emp44_bomb_reload);
  lib_0378::func_8DC7("aud_pap_wpn_sdk_shottysnipe_fire", ::pap_wpn_sdk_shottysnipe_fire);
}

lib_0366::func_8E0C() {
  var_00 = "zombie_generic";
  var_00 = "zombie_generic2";
  var_00 = "zombie_berserker";
  var_00 = "zombie_heavy";
  var_00 = "zombie_exploder";
  var_00 = "zombie_fireman";
  var_00 = "zombie_boss_village";
  var_00 = "zombie_klaus";
  var_00 = "zombie_treasurer";
  var_00 = "zombie_assassin";
  var_00 = "zombie_sizzler";
  var_00 = "zombie_bob";
  var_00 = "zombie_guardian";
  var_00 = "zombie_king";
  var_00 = "zombie_dlc4";
  var_00 = "zde_taunt";
  var_00 = "growl_lev1";
  var_00 = "growl_lev2";
  var_00 = "growl_lev3";
  var_00 = "growl_lev4";
  var_00 = "sneakattack_busted";
  var_00 = "charge";
  var_00 = "sneakattack_success";
  var_00 = "sneakattack_success_2d";
  var_00 = "jumpscare1";
  var_00 = "attack";
  var_00 = "pain";
  var_00 = "death";
  var_00 = "mus_stinger_lrg";
  var_00 = "mus_stinger_med";
  var_00 = "mus_stinger_sml";
  var_00 = "attack_hit";
  var_00 = "attack_miss";
}

lib_0366::func_8E27() {
  lib_0366::func_8E0C();
  common_scripts\utility::func_3799("zombie_passive");
  level.var_071D.var_A974 = 0;
  level.var_071D.var_5AB6 = 16;
  level.var_071D.var_4031 = 0;
  var_00 = [[0, 1], [0.0667, 0.95], [0.1333, 0.6509629], [0.2, 0.512], [0.2667, 0.3943704], [0.3333, 0.2962963], [0.4, 0.216], [0.4667, 0.1517037], [0.5333, 0.1016296], [0.6, 0.064], [0.6667, 0.03703704], [0.7333, 0.01896296], [0.8, 0.008], [0.8667, 0.00237037], [0.9333, 0.0002962963], [1, 0]];
  level.var_071D.var_725F = lib_0378::func_8DCB(var_00, 1, 0.5);
  level.var_071D.var_AB8E = [[0, 1], [0.0667, 0.9780229], [0.1333, 0.9149472], [0.2, 0.8187308], [0.2667, 0.700784], [0.3333, 0.5737534], [0.4, 0.449329], [0.4667, 0.3365903], [0.5333, 0.2411775], [0.6, 0.1652989], [0.6667, 0.108368], [0.7333, 0.0679564], [0.8, 0.0407622], [0.8667, 0.02338745], [0.9333, 0.01283531], [1, 0]];
  level.var_071D.var_7500 = [[0, 0.666], [1, 1]];
  level.var_071D.var_AC07 = 1;
  level.var_071D.var_0CB8 = [[0, 1000], [1, 10000]];
}

snd_level_handle_zombie_round_countdown_started() {
  for(;;) {
    level common_scripts\utility::func_A70A("zombie_round_countdown_started", "zombies_manual_start");
    var_00 = 1;
    level.var_071D.round_countdown_snd = lib_0380::func_6840(level.var_071D.round_countdown_alias, undefined, var_00);
  }
}

snd_level_handle_zombie_wave_started() {
  for(;;) {
    level waittill("zombie_wave_started");
    if(isDefined(level.var_071D.round_countdown_end_alias)) {
      lib_0380::func_6850(level.var_071D.round_countdown_snd, 0.5);
      level.var_071D.round_countdown_snd = undefined;
      lib_0380::func_6840(level.var_071D.round_countdown_end_alias);
    }

    lib_0380::func_6840("zmb_ui_wave_splash");
    level.var_071D.var_A974 = 1;
    foreach(var_01 in level.var_744A) {
      var_01 lib_0366::func_8E4D();
      var_01 lib_0378::func_8D74("wave_begin");
    }
  }
}

snd_level_handle_zombie_wave_ended() {
  for(;;) {
    level waittill("zombie_wave_ended");
    level.var_071D.var_A974 = 0;
    foreach(var_01 in level.var_744A) {
      var_01 lib_0366::func_8E4E();
      var_01 lib_0378::func_8D74("wave_end");
    }
  }
}

lib_0366::func_8E00(param_00) {
  if(isDefined(level.var_744A) && level.var_744A.size > 0) {
    foreach(var_02 in level.var_744A) {
      if(isDefined(var_02)) {
        var_02 method_8626(param_00);
        wait 0.05;
      }
    }
  }
}

lib_0366::func_7247() {
  self method_85A7("ClientScriptInit", "zombies");
  self method_8626("zmb_init_mix");
  self method_8626("zmb_init_overrides_mix");
  self method_8626("zmb_headroom_mix");
  lib_0366::func_8E45();
  thread lib_0366::func_8E21();
  thread lib_0366::func_8E1C();
  thread lib_0366::func_8E20();
  thread lib_0366::func_8E1E();
  thread lib_0366::func_8E1F();
  thread lib_0366::func_8E1B();
  thread lib_0366::func_8E1D();
  thread lib_0366::func_8E2C();
  thread lib_0366::func_8E2B();
  thread lib_0366::func_8E40();
  lib_0366::func_8E2F(1, 0.1, self);
  lib_0378::func_8D74("player_connect_map");
  self.var_071D.var_6599 = 0;
}

lib_0366::func_ABFA() {
  self.var_071D = spawnStruct();
  self.var_071D.var_502A = snd_zmb_new_guid();
  self.var_071D.var_9977 = 0;
  self.var_071D.var_900C = gettime();
  self.var_071D.var_99E0 = [];
  self.var_071D.var_0A47 = self.var_0A4B;
  switch (self.var_071D.var_0A47) {
    case "zombie_generic":
      self.var_071D.var_9979 = 1;
      var_00 = 3;
      var_01 = common_scripts\utility::func_627D(level.var_071D.var_4031, var_00);
      if(var_01 < var_00 - 1) {
        self.var_071D.var_0A47 = self.var_071D.var_0A47 + "2";
      }

      level.var_071D.var_4031++;
      lib_0366::func_8E26(::lib_0366::func_8E05);
      break;

    case "zombie_berserker":
      self.var_071D.var_9979 = 1;
      lib_0366::func_8E26(::lib_0366::func_8E01);
      lib_0380::func_6846("fly_swarm_npc", undefined, self, 4, 1, 5);
      break;

    case "zombie_sizzler":
      self.var_071D.var_9979 = 1;
      break;

    case "zombie_fireman":
      self.var_071D.var_9979 = 3.5;
      lib_0366::func_8E26(::lib_0366::func_8E04);
      break;

    case "zombie_exploder":
      self.var_071D.var_9979 = 3;
      lib_0366::func_8E26(::lib_0366::func_8E03);
      break;

    case "zombie_treasurer":
      self.var_071D.var_9979 = 3.5;
      lib_0366::func_8E26(::lib_0366::func_8E03);
      break;

    case "zombie_heavy":
      self.var_071D.var_9979 = 3;
      lib_0366::func_8E26(::lib_0366::func_8E06);
      break;

    case "zombie_assassin":
      self.var_071D.var_9979 = 3.5;
      lib_0366::func_8E26(::lib_0366::func_8E02);
      break;

    case "zombie_boss_village":
      self.var_071D.var_9979 = 10;
      lib_0366::func_8E26(::lib_0366::func_8E06);
      break;

    case "zombie_bob":
      self.var_071D.var_9979 = 10;
      break;

    case "zombie_guardian":
      self.var_071D.var_9979 = 10;
      break;

    default:
      self.var_071D.var_9979 = 1;
      lib_0366::func_8E26(::lib_0366::func_8E02);
      break;
  }

  if(lib_0366::func_8E19()) {
    lib_0366::func_8E37();
  }

  thread lib_0366::func_8E2A();
  thread lib_0366::func_8E2D();
}

lib_0366::func_6BD1(param_00) {
  if(param_00.var_60B8 == "MELEE" || param_00.var_60B8 == "MOD_MELEE") {
    param_00.var_721C method_85A7("snd_zmb_handle_plr_melee");
  }

  if(issubstr(param_00.var_01D0, "shovel")) {
    if(isalive(self)) {
      lib_0366::func_8E8D("zm_melee_shovel_head_2d", "zm_melee_shovel_head", param_00.var_721C.var_0116, 72, 1);
    } else {
      lib_0366::func_8E8D("zm_melee_shovel_head_2d", "zm_melee_shovel_head", param_00.var_721C.var_0116, 72, 0.5);
    }
  }

  if(param_00.var_01D0 == "raven_sword_zm") {
    lib_0366::func_8E8D("zmb_raven_swrd_hit_2d", "zmb_raven_swrd_hit", param_00.var_721C.var_0116, 72);
  }
}

lib_0366::func_8E8D(param_00, param_01, param_02, param_03, param_04) {
  foreach(var_06 in level.var_744A) {
    var_07 = distance(var_06.var_0116, param_02);
    if(var_07 < param_03) {
      lib_0380::func_6840(param_00, var_06, 0, param_04);
      continue;
    }

    lib_0380::func_6842(param_01, var_06, param_02, 0, param_04);
  }
}

lib_0366::func_7A83() {
  var_00 = self;
  level.var_11CB.var_9571 = lib_0380::func_288B("zmb_raven_swrd_power_up", undefined, var_00);
  lib_0378::func_8D14(level.var_11CB.var_9571);
  if(!isDefined(level.var_11CB.var_9570)) {
    level.var_11CB.var_9570 = lib_0380::func_288B("zmb_raven_swrd_power_lp", undefined, var_00, 0.25);
    lib_0378::func_8D14(level.var_11CB.var_9570);
  }
}

lib_0366::func_7A82() {
  lib_0380::func_2893(level.var_11CB.var_9570, 0.25);
  level.var_11CB.var_9570 = undefined;
}

lib_0366::func_7A7A() {
  var_00 = self;
  var_01 = lib_0380::func_288B("zmb_raven_swrd_aoe", undefined, var_00);
  lib_0378::func_8D14(var_01);
}

lib_0366::func_6BD4(param_00) {
  switch (param_00.var_4DCF) {
    case "head":
      param_00.var_721C method_8615("zm_hit_kill_head_impact");
      wait(0.25);
      maps\mp\_audio::func_8DA0("zm_hit_kill_headshot_splatter", param_00.var_ABE6);
      break;

    case "helmet":
      param_00.var_721C method_8615("zm_hit_kill_head_impact");
      maps\mp\_audio::func_8DA0("zm_hit_kill_helmet_impact", param_00.var_ABE6);
      wait(0.25);
      maps\mp\_audio::func_8DA0("zm_hit_kill_headshot_splatter", param_00.var_ABE6);
      break;

    default:
      param_00.var_721C method_8615("zm_hit_kill");
      break;
  }
}

lib_0366::func_690B(param_00) {
  level notify("stop_objective_complete");
  level endon("objective_complete");
  lib_0378::func_8DC2("objective_complete: " + param_00);
  if(!isDefined(level.var_071D.var_690D)) {
    level.var_071D.var_690D = [["mus_objective_complete_01", 13], ["mus_objective_complete_02", 13], ["mus_objective_complete_03", 16], ["mus_objective_complete_04", 14], ["mus_objective_complete_05", 15], ["mus_objective_complete_06", 14]];
  }

  if(isDefined(self.var_071D.var_690C)) {
    lib_0380::func_2893(self.var_071D.var_690C, 1);
    self.var_071D.var_690C = undefined;
  } else {
    self method_8626("zmb_objective_complete_mix");
  }

  var_01 = level.var_071D.var_690D[randomint(level.var_071D.var_690D.size)];
  self.var_071D.var_690C = lib_0380::func_2888(var_01[0], self);
  wait(var_01[1]);
  self method_8627("zmb_objective_complete_mix");
  self.var_071D.var_690C = undefined;
}

snd_set_round_countdown_aliases(param_00, param_01) {
  level.var_071D.round_countdown_alias = param_00;
  level.var_071D.round_countdown_end_alias = param_01;
}

snd_get_round_countdown_aliases() {
  var_00 = spawnStruct();
  var_00.round_countdown_alias = level.var_071D.round_countdown_alias;
  var_00.round_countdown_end_alias = level.var_071D.round_countdown_end_alias;
  return var_00;
}

snd_set_mus_combat_cues_override(param_00) {
  level.var_071D.mus_combat_cues_override = param_00;
}

snd_clear_mus_combat_cues_override() {
  level.var_071D.mus_combat_cues_override = undefined;
}

lib_0366::func_8D46() {
  if(!isDefined(level.var_071D.var_6552)) {
    level.var_071D.var_6552 = ["zom_movin", "zmb_mus_wave_02", "zmb_mus_wave_03", "zmb_mus_wave_04", "zom_screetchy1", "zmb_mus_wave_01", "zmb_mus_wave_05"];
  }

  var_00 = level.var_071D.var_6552;
  if(isDefined(level.var_071D.mus_combat_cues_override)) {
    var_00 = level.var_071D.mus_combat_cues_override;
  }

  if(getomnvar("ui_zm_round_number") > 10) {
    var_01 = var_00[randomint(var_00.size)];
  } else {
    var_01 = var_01[self.var_071D.var_6551];
    self.var_071D.var_6551 = self.var_071D.var_6551 + 1 % var_00.size;
  }

  return var_01;
}

lib_0366::func_8DCF(param_00) {
  self.var_071D.var_A97B = param_00;
}

snd_get_curr_combat_cue_name() {
  return self.var_071D.var_A97B;
}

lib_0366::func_8D9F() {
  lib_0380::func_2888("fly_swarm_player", self);
}

lib_0366::func_8C59(param_00) {
  var_01 = self;
  thread lib_0366::func_8E34("mus_stinger_lrg", var_01, 1, param_00);
  wait(0.1);
  foreach(var_03 in level.var_744A) {
    if(var_03 == var_01 && distance(var_03.var_0116, param_00.var_0116) < 108) {
      var_03 thread lib_0366::func_8E49(param_00, "sneakattack_success", 1);
      continue;
    }

    var_03 thread lib_0366::func_8E49(param_00, "sneakattack_success", 0);
  }
}

snd_not_so_simple_jump_scare(param_00) {
  param_00 = self;
  var_01 = [];
  var_02 = [];
  foreach(var_04 in level.var_744A) {
    var_05 = distance(var_04.var_0116, param_00.var_0116);
    if(var_05 < 540) {
      var_02[var_02.size] = var_04;
      if(var_05 < 144) {
        var_01[var_01.size] = var_04;
      }
    }
  }

  foreach(var_04 in var_01) {
    thread lib_0366::func_8E34("mus_stinger_lrg", var_04, 1, param_00);
  }

  wait(0.1);
  foreach(var_04 in var_02) {
    var_04 thread lib_0366::func_8E49(param_00, "sneakattack_success");
  }
}

lib_0366::func_8E2A() {}

lib_0366::func_8E26(param_00) {
  self.var_071D.var_AB00 = param_00;
}

lib_0366::func_ABF0(param_00, param_01) {
  if(isDefined(self.var_071D.var_AB00)) {
    self[[self.var_071D.var_AB00]](param_00, param_01);
  }
}

lib_0366::func_8E01(param_00, param_01) {
  switch (param_01) {
    case "s2_zom_spr_sprint_death_v1":
      lib_0366::func_8E4B("anim_death");
      break;

    case "s2_zom_spr_sprint_stun_react_left":
      lib_0366::func_8E4B("anim_hit_react_left");
      break;

    case "s2_zom_spr_sprint_stun_react_right":
      lib_0366::func_8E4B("anim_hit_react_right");
      break;

    case "s2_zom_spr_sprint_v1":
      lib_0366::func_8E4B("anim_sprint_1");
      break;

    case "s2_zom_spr_sprint_v2":
      lib_0366::func_8E4B("anim_sprint_2");
      break;

    case "s2_zom_spr_sprint_v3":
      lib_0366::func_8E4B("anim_sprint_3");
      break;

    case "s2_zom_spr_sprint_attack_v1":
      lib_0366::func_8E4B("anim_sprint_attack_1");
      break;

    case "s2_zom_spr_sprint_attack_v2":
      lib_0366::func_8E4B("anim_sprint_attack_2");
      break;

    case "s2_zom_spr_sprint_attack_v3":
      lib_0366::func_8E4B("anim_sprint_attack_3");
      break;

    case "s2_zom_sprinter_stand_attack_1":
      lib_0366::func_8E4B("anim_stand_attack_1");
      break;

    case "s2_zom_sprinter_stand_attack_2":
      lib_0366::func_8E4B("anim_stand_attack_2");
      break;

    case "s2_zom_sprinter_stand_attack_3":
      lib_0366::func_8E4B("anim_stand_attack_3");
      break;

    case "s2_zom_core_idle_twitch_v1":
      lib_0366::func_8E4B("snarl");
      break;

    default:
      break;
  }
}

lib_0366::func_8E05(param_00, param_01) {
  switch (param_01) {
    default:
      break;
  }
}

lib_0366::func_8E04(param_00, param_01) {
  switch (param_01) {
    default:
      break;
  }
}

lib_0366::func_8E03(param_00, param_01) {
  switch (param_01) {
    default:
      break;
  }
}

lib_0366::func_8E06(param_00, param_01) {
  switch (param_01) {
    default:
      break;
  }
}

lib_0366::func_8E02(param_00, param_01) {
  switch (param_01) {
    default:
      break;
  }
}

lib_0366::func_9916() {
  var_00 = self;
  var_01 = 180;
  for(;;) {
    var_02 = level.var_744A[0];
    if(isDefined(var_02)) {
      var_03 = distance2d(var_00.var_0116, var_02.var_0116);
      if(var_03 < var_01) {
        lib_0378::func_8D74("zombie_ignite");
        wait(10);
        lib_0378::func_8D74("zombie_extinguish");
        return;
      }
    }

    wait(0.1);
  }
}

lib_0366::func_8E37() {
  if(!level.var_071D.var_A974) {
    return;
  }

  if(!isDefined(level.var_071D.var_ABFB)) {
    level.var_071D.var_ABFB = ["zmb_spawn_cardboard_pallet_default", "zmb_spawn_const_barrel_default", "zmb_spawn_const_sawhorse_default", "zmb_spawn_const_sign_default", "zmb_spawn_mesh_container_default", "zmb_spawn_chain_default", "zmb_spawn_wood_default", "zmb_spawn_wood_lrg_default", "zmb_spawn_light_lrg_default", "zmb_spawn_light_sml_default", "zmb_spawn_metal_hollow_default"];
  }

  if(lib_0378::func_8D1B(0.5)) {
    lib_0366::func_8E4B("spawn");
    return;
  }

  var_00 = randomint(level.var_071D.var_ABFB.size);
  var_01 = level.var_071D.var_ABFB[var_00];
  lib_0380::func_2889(var_01, undefined, self.var_0116);
}

lib_0366::func_9CC9(param_00) {
  maps\mp\_audio::func_8DA2("trap_spinner_activate", self);
  maps\mp\_audio::func_8DA4("trap_spinner_spin_lp", self, param_00);
}

lib_0366::func_62D2() {}

lib_0366::func_3E42() {
  lib_0380::func_2888("zmb_pickup_general", self);
}

lib_0366::func_ABA3() {
  if(isDefined(self) && isDefined(self.var_0116) && function_0344("zmb_bodyfall_hv")) {
    thread maps\mp\_audio::func_8DA0("zmb_falling_zombie_impact", self.var_0116);
    lib_0366::func_8E4B("pain");
    return;
  }

  lib_0378::func_8D14(0, "wtf");
}

lib_0366::func_ABCE(param_00) {
  wait 0.05;
  if(!common_scripts\utility::func_562E(self.var_55CB)) {
    self.var_55CB = 1;
    maps\mp\_audio::func_8DA2("burning_zombie_ignite", self);
    var_01 = 0.25;
    var_02 = 3;
    var_03 = "soft";
    var_04 = lib_0380::func_6846("burning_zombie_lp", undefined, self, var_01);
    if(isDefined(param_00)) {
      wait(param_00);
      lib_0380::func_6850(var_04, var_02);
      self.var_55CB = 0;
      return;
    }

    self.var_071D.var_4FF5 = var_04;
  }
}

lib_0366::func_ABA2() {
  if(isDefined(self) && isDefined(self.var_071D.var_4FF5)) {
    var_00 = 3;
    lib_0380::func_6850(self.var_071D.var_4FF5, var_00);
    self.var_55CB = 0;
  }
}

lib_0366::func_8E21() {
  self endon("disconnect");
  for(;;) {
    self waittill("spawned");
    lib_0366::func_8E41("Recieved Message:spawened");
    wait(1);
    if(!function_0367()) {
      thread lib_0378::func_92F3(0.003, 0.01);
      thread lib_0378::func_1BBD();
      thread lib_0378::func_1BBE();
      thread lib_0378::func_1BBF();
      lib_0378::set_expletive_chance(0.4);
      lib_0378::set_max_breath_lev_num(4);
      lib_0378::func_851F(200);
    }

    lib_0378::func_8D74("player_spawned");
  }
}

snd_is_level_wave_active() {
  return level.var_071D.var_A974;
}

snd_get_auto_wave_music_enabled() {
  var_00 = self;
  return var_00.var_071D.auto_wave_music_enabled;
}

snd_set_auto_wave_music_enabled(param_00) {
  var_01 = self;
  var_01.var_071D.auto_wave_music_enabled = param_00;
}

lib_0366::func_8E4D() {
  if(snd_get_auto_wave_music_enabled()) {
    lib_0366::func_8DCF(lib_0366::func_8D46());
    var_00 = 5;
    var_01 = 10;
    lib_0366::func_8E31(self.var_071D.var_A97B, var_00, var_01);
    lib_0366::func_8E2F(0.9 * level.var_071D.map_wave_music_master_volume_scalar, 2, self);
  }

  if(level.var_7F24 == 0) {
    thread lib_0366::func_8D9F();
  }
}

lib_0366::func_8E4E() {
  if(snd_get_auto_wave_music_enabled()) {
    var_00 = "stinger_round_end_hit";
    var_01 = 0;
    lib_0366::func_8E31(var_00, var_01);
    lib_0366::func_8DCF(undefined);
    wait(1);
    lib_0366::func_AB0D();
    lib_0366::func_8E2F(1, 2, self);
  }
}

lib_0366::func_AB0D() {
  if(isDefined(level.var_071D.start_intermission_music_override)) {
    [[level.var_071D.start_intermission_music_override]]();
    return;
  }

  var_00 = "mus_intermission";
  var_01 = "mus_intermission_long";
  if(lib_0378::func_8D1B(0.5)) {
    var_00 = var_01;
  }

  var_02 = 4;
  var_03 = 5;
  lib_0366::func_8E31(var_00, var_02, var_03);
}

snd_zmb_set_start_intermission_music_override_callback(param_00) {
  level.var_071D.start_intermission_music_override = param_00;
}

lib_0366::func_8E1C() {
  self endon("disconnect");
  for(;;) {
    self waittill("enter_last_stand");
    self.var_5BF3 = gettime();
    lib_0366::func_8E41("Recieved Message:spawened");
    lib_0378::func_8D74("enter_last_stand");
  }
}

lib_0366::func_8E20() {
  self endon("disconnect");
  for(;;) {
    self waittill("revive");
    lib_0366::func_8E41("Recieved Message:spawened");
    var_00 = gettime();
    if(isDefined(self.var_5BEF)) {
      self.var_32CD = self.var_32CD + int(var_00 - self.var_5BEF.var_5BF4 / 1000);
    }

    self.var_99F8 = self.var_99F8 + self.var_32CD;
    lib_0378::func_8D74("revive");
  }
}

lib_0366::func_8E1E() {
  self endon("disconnect");
  for(;;) {
    self waittill("damage", var_00, var_01, var_02, var_03, var_04, var_05, var_06, var_07, var_08, var_09, var_0A, var_0B);
    if(var_00 > 0) {
      var_00 = clamp(var_00 * 1.5, 0, 100);
      self method_85A7("snd_zmb_handle_plr_damage", var_00);
    }
  }
}

lib_0366::func_8E1F() {
  self endon("disconnect");
  for(;;) {
    self waittill("death");
    lib_0366::func_8E41("Recieved Message:spawened");
    lib_0378::func_8D74("death");
    var_00 = level.var_A980 - 1;
    var_01 = self getentitynumber();
    self.var_2AB8 = gettime();
    if(var_00 >= 0 && var_00 < level.var_609D) {
      setmatchdata("rounds", var_00, "player_rounds", var_01, "died", 1);
    }

    lib_0378::func_93E2();
    if(isDefined(self.var_071D.var_3D90)) {
      lib_0380::func_6850(self.var_071D.var_3D90);
    }
  }
}

lib_0366::func_8E1B() {
  self endon("disconnect");
  for(;;) {
    self waittill("end_respawn");
    lib_0366::func_8E41("Recieved Message:spawened");
    lib_0378::func_8D74("end_respawn");
  }
}

lib_0366::func_8E1D() {
  self endon("disconnect");
  for(;;) {
    self waittill("joined_spectators");
    lib_0366::func_8E41("Recieved Message:spawened");
    lib_0378::func_8D74("joined_spectators");
  }
}

lib_0366::func_8E45() {
  if(!isDefined(level.var_071D.var_74F7)) {
    level.var_071D.var_74F7 = [];
  }

  var_00 = spawnStruct();
  var_01 = lib_0378::func_8D86();
  var_00.var_2417 = var_01;
  var_00.var_74F3 = self;
  level.var_071D.var_74F7[var_01] = var_00;
  self.var_071D.var_2417 = var_01;
  self.var_071D.var_28BF = [];
  self.var_071D.var_6551 = 0;
  self.var_071D.auto_wave_music_enabled = 1;
}

lib_0366::func_8E0A(param_00) {
  var_01 = undefined;
  lib_0366::func_8E07(function_02A2(param_00));
  var_02 = level.var_071D.var_74F7[param_00];
  if(isDefined(var_02)) {
    var_01 = var_02.var_74F3;
  }

  return var_01;
}

lib_0366::func_8E3F(param_00) {
  var_01 = undefined;
  lib_0366::func_8E07(isDefined(param_00));
  foreach(var_03 in level.var_071D.var_74F7) {
    if(var_03.var_74F3 == param_00) {
      var_01 = var_03.var_2417;
      break;
    }
  }

  return var_01;
}

lib_0366::func_8E0E() {
  return self.var_071D.var_2417;
}

lib_0366::func_AC3C() {
  maps\mp\_audio::func_8DA0("zombies_2016_gl_ending_hit");
  lib_0366::func_8E00("zombies_2016_gl_ending");
}

lib_0366::func_65F3(param_00, param_01) {
  if(param_01 == 1) {
    wait(4.55);
    level.var_11CB.var_65F4 = lib_0380::func_2889("zmb_mystery_box_elec", undefined, param_00.var_0116);
    return;
  }

  stopclientsound(level.var_11CB.var_65F4);
}

lib_0366::func_65F5(param_00) {
  lib_0380::func_2889("interact_mystery_box_open", undefined, param_00.var_0116);
}

lib_0366::func_65F2(param_00) {
  lib_0380::func_2889("interact_mystery_box_close", undefined, param_00.var_0116);
}

lib_0366::func_65F0(param_00) {
  if(!isDefined(param_00.var_11C6)) {
    param_00.var_11C6 = lib_0380::func_6844("zmb_interact_mystery_box_attract", undefined, param_00, 3);
    wait(2);
    lib_0366::func_65EE(param_00);
  }
}

lib_0366::func_65EF(param_00) {
  if(isDefined(param_00.var_11C6)) {
    lib_0380::func_6850(param_00.var_11C6, 3);
    param_00.var_11C6 = undefined;
  }
}

lib_0366::func_65F1(param_00) {
  if(!isDefined(param_00.var_11C6)) {
    lib_0366::func_65F0(param_00);
  }

  lib_0380::func_684E(param_00.var_11C6, 1, 3);
}

lib_0366::func_65EE(param_00) {
  if(isDefined(param_00.var_11C6)) {
    lib_0380::func_684E(param_00.var_11C6, 0.25, 3);
  }
}

lib_0366::func_8E31(param_00, param_01, param_02) {
  var_03 = lib_0366::func_8E14();
  self method_85A7("snd_start_mus", param_00, var_03, param_01, param_02);
}

lib_0366::func_8E32(param_00) {
  self method_85A7("snd_stop_mus", param_00);
}

lib_0366::func_8E33(param_00) {
  callclientscript(level.var_744A, "snd_stop_mus", param_00);
}

lib_0366::func_8E34(param_00, param_01, param_02, param_03) {
  var_04 = lib_0378::func_8D49(1, param_02);
  if(isDefined(param_01)) {
    var_05 = gettime();
    var_06 = param_01 lib_0366::func_8E10();
    if(var_05 > var_06 + 4000) {
      param_01 lib_0366::func_8E46(var_05);
      var_07 = lib_0366::func_8E15();
      var_04 = var_04 * lib_0378::func_8D72(param_01.var_071D.var_74FF, var_07);
      if(param_00 != "player_vox_only") {
        param_01 method_85A7("snd_zmb_play_mus_stinger", param_00, var_04);
      }

      param_01 lib_0366::func_8E0D(param_00);
      return;
    }

    return;
  }

  if(param_00 != "player_vox_only") {
    callclientscript(level.var_744A, "snd_zmb_play_mus_stinger", param_00, var_04);
  }
}

snd_zmb_set_plr_vox_scare_count_max(param_00) {
  self method_85A7("snd_zmb_set_plr_vox_scare_count_max", param_00);
}

lib_0366::func_8E0D(param_00) {
  wait(0.5);
  self method_85A7("snd_zmb_plr_stinger_scare_vox", param_00);
}

lib_0366::func_8E35(param_00, param_01, param_02) {
  thread lib_0366::func_8E9D(param_00, param_01, param_02);
}

lib_0366::func_8E9D(param_00, param_01, param_02) {
  param_01 endon("death");
  param_01 endon("disconnect");
  param_02 endon("death");
  param_02 notify("sndx_zmb_play_mus_stinger_when_plr_sees_zmb");
  param_02 endon("sndx_zmb_play_mus_stinger_when_plr_sees_zmb");
  while(isDefined(param_01) && isDefined(param_02)) {
    if(param_01 common_scripts\utility::func_7237(param_02)) {
      if(!lib_0547::func_577E(param_01)) {
        var_03 = distance2d(param_01.var_0116, param_02.var_0116);
        if(var_03 < 180) {
          lib_0366::func_8E34(param_00, param_01, 1, param_02);
        }
      }

      break;
    }

    wait 0.05;
  }
}

snd_zmb_set_map_wave_music_master_volume_scalar(param_00) {
  level.var_071D.map_wave_music_master_volume_scalar = param_00;
}

lib_0366::func_8E30(param_00, param_01, param_02) {
  var_03 = 1 * param_00;
  lib_0366::func_8E2F(var_03, param_01, param_02);
}

lib_0366::func_8E2F(param_00, param_01, param_02) {
  if(isDefined(param_02)) {
    self method_85A7("snd_set_mus_master_vol", param_00, param_01);
    return;
  }

  callclientscript(level.var_744A, "snd_set_mus_master_vol", param_00, param_01);
}

lib_0366::func_8E2C() {
  self endon("disconnect");
  var_00 = 0.5;
  var_01 = -666;
  self method_85A7("snd_set_threat_update_period", var_00);
  for(;;) {
    if(lib_0366::func_8E19()) {
      if(isDefined(self.var_071D.var_93A0)) {
        self.var_071D.var_74FF = self.var_071D.var_93A0;
      } else {
        self.var_071D.var_74FF = lib_0366::func_8E08();
      }
    } else {
      self.var_071D.var_74FF = 0;
    }

    if(self.var_071D.var_74FF != var_01) {
      var_01 = self.var_071D.var_74FF;
      self method_85A7("snd_update_plr_threat", self.var_071D.var_74FF);
    }

    wait(var_00);
  }
}

lib_0366::func_8E47(param_00) {
  self.var_071D.var_93A0 = param_00;
}

lib_0366::func_8E09() {
  self.var_071D.var_93A0 = undefined;
}

lib_0366::func_8E18() {
  var_00 = [];
  var_01 = self;
  var_02 = lib_0366::func_8E1A();
  var_03 = var_02.size;
  var_04 = 100000000;
  for(var_05 = 0; var_05 < var_03; var_05++) {
    var_06 = var_02[var_05];
    if(isDefined(var_06.var_0116) && isDefined(var_06.var_0A4B)) {
      var_07 = lib_0366::func_8E17(var_06);
      var_08 = spawnStruct();
      var_08.var_AB4D = var_06;
      var_08.var_502A = var_07;
      var_08.var_3018 = distance(var_01.var_0116, var_06.var_0116);
      var_08.is_closest = 0;
      var_08.var_1F21 = var_01 common_scripts\utility::func_7237(var_06);
      var_08.is_passive = var_06 snd_zmb_zom_is_passive();
      var_08.var_28E4 = length2d(var_06 getvelocity()) * 0.05681818;
      if(var_08.var_1F21 && var_08.var_3018 < var_04) {
        var_08.is_closest = 1;
        var_04 = var_08.var_3018;
      }

      var_00[var_05] = var_08;
    }
  }

  return var_00;
}

lib_0366::func_8E0B(param_00) {
  var_01 = [];
  var_02 = param_00.size;
  if(var_02 > 0) {
    var_03 = common_scripts\utility::func_7897(param_00, ::lib_0366::func_8E29);
    var_04 = 0;
    foreach(var_06 in var_03) {
      if(var_04 >= 5) {
        break;
      }

      var_04++;
      var_01[var_06.var_502A] = var_06;
    }
  }

  return var_01;
}

lib_0366::func_8E29(param_00, param_01) {
  return param_00.var_3018 <= param_01.var_3018;
}

lib_0366::func_8E0F() {
  var_00 = self;
  return var_00.var_071D.var_28BF;
}

snd_zmb_plr_is_in_thick_fog() {
  var_00 = common_scripts\utility::func_562E(self.isinfogzone) && common_scripts\utility::func_562E(level.island_fog_is_thick);
  return var_00;
}

snd_zmb_zom_is_passive() {
  var_00 = 0;
  if(common_scripts\utility::func_3798("zombie_passive")) {
    var_00 = common_scripts\utility::func_3794("zombie_passive");
  }

  return var_00;
}

lib_0366::func_8E2B() {
  self endon("disconnect");
  while(self.var_00BC <= 0) {
    wait 0.05;
  }

  self method_85A7("snd_update_plr_health", self.var_00BC);
  var_00 = 0.1;
  var_01 = self.var_00BC;
  for(;;) {
    if(self.var_00BC != var_01) {
      var_01 = self.var_00BC;
      self method_85A7("snd_update_plr_health", self.var_00BC);
    }

    wait(var_00);
  }
}

lib_0366::func_8E08() {
  var_00 = self;
  var_01 = 0;
  var_02 = lib_0366::func_8E1A();
  var_03 = self.var_0116;
  var_04 = var_00 snd_zmb_plr_is_in_thick_fog();
  var_05 = 1800;
  var_06 = var_05 * 0.333;
  var_07 = lib_0366::func_8E13();
  var_08 = lib_0366::func_8E0E();
  var_09 = gettime();
  var_0A = -5536;
  var_0B = 1;
  if(var_04) {
    var_05 = var_06;
    var_0B = 1.2;
  }

  foreach(var_0D in var_02) {
    var_0E = 0;
    var_0F = distance(var_03, var_0D.var_0116);
    var_10 = var_0D snd_zmb_zom_is_passive();
    var_11 = var_0D.var_071D.var_0A47;
    var_12 = isDefined(var_0D.var_28D2) && var_0D.var_28D2 == var_00;
    if(var_04 && var_10) {
      continue;
    } else if(var_0F < var_05) {
      var_13 = var_0D.var_071D.var_99E0[var_08];
      var_14 = isDefined(var_13);
      var_15 = var_00 common_scripts\utility::func_7237(var_0D);
      if(!var_15 && var_14) {
        var_16 = var_09 - var_13;
        if(var_16 < var_0A) {
          var_0E = 1;
        } else {
          var_0D.var_071D.var_99E0[var_08] = undefined;
        }
      } else if(var_16) {
        var_0F = 1;
        var_0E.var_071D.var_99E0[var_09] = var_0A;
      }

      if(var_0F) {
        if(var_12 == "zombie_assassin" && var_05) {
          var_02 = 1;
        } else {
          var_17 = lib_0378::func_8D73(var_10, 0, var_06, var_08);
          var_17 = var_17 * var_0E.var_071D.var_9979;
          var_17 = var_17 * level.var_071D.global_threat_scalar;
          var_17 = var_17 * var_0C;
          var_02 = var_02 + var_17;
        }
      }
    }
  }

  return clamp(var_04, 0, 1);
}

sndx_update_global_threat_scalar(param_00) {
  if(param_00 > 0) {
    level.var_071D.global_threat_scalar = 0.666 + param_00 - 1 * 0.177822;
    lib_0378::func_8D64("in_combat: " + param_00);
    return;
  }

  level.var_071D.global_threat_scalar = 0.666;
}

sndx_monitor_num_players_in_combat(param_00) {
  for(;;) {
    level common_scripts\utility::func_A70A("player_spawned", "player_last_stand", "player_bleedout", "player_revived", "player_disconnected");
    var_01 = 0;
    var_02 = 0;
    foreach(var_04 in level.var_744A) {
      if(maps\mp\_utility::func_57A0(var_04)) {
        if(lib_0547::func_577E(var_04)) {
          var_02 = 1;
          continue;
        }

        var_01++;
      }
    }

    if(var_01 == 0 && var_02) {
      var_01 = 1;
    }

    level.var_071D.num_players_in_combat = var_01;
    if(isDefined(param_00)) {
      [[param_00]](var_01);
    }
  }
}

snd_zmb_get_num_players_in_combat() {
  return level.var_071D.num_players_in_combat;
}

lib_0366::func_8E14(param_00) {
  var_01 = 0;
  var_02 = self;
  if(function_02A2(param_00)) {
    var_02 = lib_0366::func_8E0A(param_00);
    lib_0366::func_8E07(isDefined(var_02));
  }

  if(isDefined(var_02)) {
    var_01 = var_02.var_071D.var_74FF;
  }

  return var_01;
}

lib_0366::func_8E13() {
  return level.var_071D.var_725F;
}

lib_0366::func_8E17(param_00) {
  return param_00.var_071D.var_502A;
}

lib_0366::func_8E16() {
  return level.var_071D.var_AB8E;
}

lib_0366::func_8E15() {
  return level.var_071D.var_7500;
}

lib_0366::func_8E1A() {
  var_00 = [];
  var_01 = maps\mp\agents\_agent_utility::func_43FD("all");
  foreach(var_03 in var_01) {
    if(isDefined(var_03.var_000A) && var_03.var_000A == level.var_746E) {
      continue;
    }

    var_00[var_00.size] = var_03;
  }

  return var_00;
}

snd_zmb_new_guid() {
  if(!isDefined(level.var_071D.zmb_guid)) {
    level.var_071D.zmb_guid = 0;
  }

  if(level.var_071D.zmb_guid > 500) {
    level.var_071D.zmb_guid = 0;
  }

  level.var_071D.zmb_guid++;
  return level.var_071D.zmb_guid;
}

lib_0366::func_8E2E(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08) {
  var_09 = self.var_071D.var_0A47;
  var_0A = self.var_0116;
  var_0B = lib_0366::func_8E17(self);
  foreach(var_0D in level.var_744A) {
    if(isDefined(var_0D.zombie_sighting_times[var_0B])) {
      var_0D.zombie_sighting_times[var_0B] = undefined;
    }

    if(isDefined(var_0D.amb_zvox_prev_try_times[var_0B])) {
      var_0D.amb_zvox_prev_try_times[var_0B] = undefined;
    }

    if(isDefined(var_0D.prev_charge_times[var_0B])) {
      var_0D.prev_charge_times[var_0B] = undefined;
    }
  }

  if(!(var_09 == "zombie_generic" || var_09 == "zombie_generic2") && lib_0378::func_8D1B(0.5)) {
    lib_0366::func_8E4B("death", undefined, var_0A, var_09);
  }
}

lib_0366::func_8E48(param_00) {
  level.var_071D.var_AC07 = param_00;
}

lib_0366::func_8E19() {
  return level.var_071D.var_AC07;
}

lib_0366::func_8E40() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_00 = self;
  var_01 = 0.3;
  var_00.zombie_sighting_times = [];
  var_00.amb_zvox_prev_try_times = [];
  var_00.prev_charge_times = [];
  var_02 = 0;
  var_03 = randomintrange(5000, 10000);
  var_04 = 360;
  var_05 = 180;
  var_00.var_071D.stinger_filter_prev_stinger_time = 0;
  wait(randomfloat(var_01));
  for(;;) {
    wait(var_01);
    var_06 = var_00 snd_zmb_plr_is_in_thick_fog();
    var_07 = lib_0366::func_8E18();
    var_08 = undefined;
    var_09 = gettime();
    foreach(var_0B in var_07) {
      var_0C = var_0B.var_AB4D;
      var_0D = var_0B.var_502A;
      var_0E = var_0B.var_3018;
      var_0F = var_0B.is_closest;
      var_10 = var_0B.var_28E4;
      var_11 = var_00.zombie_sighting_times[var_0D];
      var_12 = isDefined(var_11);
      var_13 = var_0B.var_1F21;
      var_14 = var_0B.is_passive;
      var_15 = isDefined(var_0C.var_28D2) && var_0C.var_28D2 == var_00;
      var_16 = undefined;
      var_17 = undefined;
      var_18 = 0;
      if(var_06) {
        var_04 = var_05;
      }

      if(!var_12 && var_13 && !var_14) {
        var_00.zombie_sighting_times[var_0D] = var_09;
        if(var_0F && var_0E < var_04) {
          if(var_0E < var_04 * 0.5) {
            var_19 = "mus_stinger_med";
            var_1A = 0.33;
            var_1B = var_00;
            if(var_0E < var_04 * 0.25) {
              var_19 = "mus_stinger_lrg";
              var_1A = 0.66;
            }

            var_19 = sndx_zmb_choose_stinger_or_player_vox(var_19, var_00, var_09);
            if(!var_06) {
              lib_0366::func_8E34(var_19, var_1B, var_1A, var_0C);
            }
          }

          var_16 = "sneakattack_busted";
        }
      } else if(!var_12 && !var_13 && var_15 && var_0E <= var_04 && !var_14) {
        var_16 = "sneakattack_success";
        var_0B.var_1F21 = 1;
        var_00.zombie_sighting_times[var_0D] = var_09;
        var_19 = sndx_zmb_choose_stinger_or_player_vox("mus_stinger_lrg", var_00, var_09);
        thread lib_0366::func_8E35(var_19, var_00, var_0C);
      } else if(var_12 && !var_13 && var_09 - var_11 > -5536) {
        var_00.zombie_sighting_times[var_0D] = undefined;
      } else if(var_13) {
        var_00.zombie_sighting_times[var_0D] = var_09;
      }

      if(!isDefined(var_16)) {
        if(!isDefined(var_00.prev_charge_times[var_0D])) {
          var_00.prev_charge_times[var_0D] = 0;
        }

        if(var_15 && var_0E < 720 && var_0C lib_0366::func_8E28() && var_09 - var_00.prev_charge_times[var_0D] > 3000) {
          var_16 = "charge";
          var_00.prev_charge_times[var_0D] = var_09;
        } else {
          if(lib_0547::func_5565(var_0C.var_0A4B, "zombie_fireman")) {
            if(lib_0378::func_8D1B(0.75)) {
              continue;
            }
          }

          if(!isDefined(var_08)) {
            var_08 = lib_0366::func_8E0B(var_07);
          }

          if(isDefined(var_08[var_0D])) {
            if(!isDefined(var_00.amb_zvox_prev_try_times[var_0D])) {
              var_00.amb_zvox_prev_try_times[var_0D] = 0;
            }

            var_1C = lib_0366::func_8E11(var_0E);
            var_1D = var_09 - var_00.amb_zvox_prev_try_times[var_0D];
            if(var_12 && var_1D > var_1C) {
              var_00.amb_zvox_prev_try_times[var_0D] = var_09;
              if(lib_0378::func_8D1B(0.999) && var_09 - var_02 > var_03 && var_15 && !var_14) {
                var_16 = "zde_taunt";
                var_02 = var_09;
                var_03 = randomintrange(3000, 6000);
                var_17 = "ZOMDEUTSCH!";
              } else {
                var_1E = randomfloat(1);
                if(var_1E < 0.4 && !var_14) {
                  var_1F = lib_0366::func_8E16();
                  var_20 = lib_0378::func_8D73(var_0E, 0, 1800, var_1F);
                  var_16 = lib_0366::func_8E4A(var_20);
                } else if(var_1E < 0.9) {
                  var_16 = "snarl";
                } else {
                  var_17 = "<NO AMB VOX>";
                }
              }
            }
          }
        }
      }

      if(isDefined(var_18)) {
        var_02 lib_0366::func_8E49(var_0E, var_18, var_1C);
      }
    }
  }
}

sndx_zmb_choose_stinger_or_player_vox(param_00, param_01, param_02) {
  var_03 = param_01 lib_0366::func_8E14();
  if(var_03 > 0.95 || param_02 - param_01.var_071D.stinger_filter_prev_stinger_time < 12) {
    param_00 = "player_vox_only";
  } else {
    param_01.var_071D.stinger_filter_prev_stinger_time = param_02;
  }

  return param_00;
}

lib_0366::func_8E11(param_00) {
  var_01 = lib_0378::func_8D73(param_00, 0, 1800, level.var_071D.var_0CB8);
  var_02 = randomfloatrange(var_01 * -0.5, var_01 * 0.5);
  return var_01 + var_02;
}

lib_0366::func_8E36(param_00, param_01) {
  if(isDefined(param_00)) {
    lib_0366::func_8E9E(param_01);
    return;
  }

  thread lib_0366::func_8E9E(param_01);
}

lib_0366::func_8E9E(param_00) {
  param_00 = lib_0378::func_8D49(0, param_00);
  var_01 = lib_0366::func_8E1A();
  foreach(var_03 in var_01) {
    if(isDefined(var_03) && isDefined(var_03.var_071D)) {
      var_03.var_071D.var_9977 = 1;
      var_04 = "sneakattack_busted";
      if(!param_00) {
        param_00 = 1;
        var_04 = "sneakattack_success";
      } else if(lib_0378::func_8D1B(0.5)) {
        var_04 = "growl_lev4";
      }

      var_03 lib_0366::func_8E4B(var_04);
    }

    wait(0.3);
  }
}

lib_0366::func_8E28() {
  return isDefined(self.var_071D.var_5542) && self.var_071D.var_5542;
}

lib_0366::func_8E2D() {
  self endon("death");
  var_00 = self;
  var_01 = 0.25;
  var_02 = 0;
  var_03 = undefined;
  var_00.var_071D.var_5542 = 0;
  for(;;) {
    wait(var_01);
    var_04 = length2d(var_00 getvelocity()) * 0.05681818;
    if(var_04 > 5) {
      var_05 = gettime();
      if(!isDefined(var_03)) {
        var_03 = var_05;
      } else if(var_05 - var_03 > 750) {
        var_00.var_071D.var_5542 = 1;
      }

      continue;
    }

    var_01.var_071D.var_5542 = 0;
    var_04 = undefined;
  }
}

lib_0366::func_8E12(param_00, param_01, param_02) {
  var_03 = 1000 + 4000 * lib_0378::func_8D73(param_01, 0, 1800, param_02) + randomint(1000);
  return param_00 + var_03;
}

lib_0366::func_8E4A(param_00) {
  var_01 = 4;
  var_02 = 0.25;
  var_03 = 1 - var_02;
  while(var_03 > param_00) {
    var_03 = var_03 - var_02;
    var_01 = var_01 - 1;
  }

  return "growl_lev" + var_01;
}

lib_0366::func_8E49(param_00, param_01, param_02, param_03, param_04) {
  var_05 = self;
  var_06 = lib_0378::func_8D49(0, param_02);
  var_07 = lib_0378::func_8D49(self.var_0A4B, param_04);
  if(isDefined(param_00.var_071D) && isDefined(param_00.var_071D.var_0A47)) {
    var_07 = param_00.var_071D.var_0A47;
  }

  param_01 = lib_0366::func_8E4C(param_01);
  if(isDefined(param_00) && common_scripts\utility::func_562E(param_00.var_6701)) {
    return;
  }

  if(isDefined(param_01)) {
    if(var_06) {
      param_01 = param_01 + "_2d";
    }

    var_05 method_85A7("snd_zmb_handle_vox_request", param_00, var_07, param_01, param_03);
  }
}

lib_0366::func_8E4B(param_00, param_01, param_02, param_03) {
  if(common_scripts\utility::func_562E(self.var_6701)) {
    return;
  }

  var_04 = 0;
  foreach(var_06 in level.var_071D.zombie_vox_attack_hit_req_names) {
    if(param_00 == var_06) {
      var_04 = 1;
      break;
    }
  }

  if(var_04) {
    var_08 = gettime();
    if(var_08 - level.var_071D.zombie_vox_attack_hit_prev_time < level.var_071D.zombie_vox_attack_hit_wait_time) {
      return;
    } else {
      level.var_071D.zombie_vox_attack_hit_prev_time = var_08;
      level.var_071D.zombie_vox_attack_hit_wait_time = randomintrange(level.var_071D.zombie_vox_attack_hit_wait_time_min, level.var_071D.zombie_vox_attack_hit_wait_time_max);
    }
  }

  var_09 = self;
  var_0A = lib_0378::func_8D49(self.var_0A4B, var_04);
  if(isDefined(var_09.var_071D) && isDefined(var_09.var_071D.var_0A47)) {
    var_0A = var_09.var_071D.var_0A47;
  }

  param_01 = lib_0366::func_8E4C(param_01);
  if(isDefined(param_01) && param_01 == "death") {
    var_0B = distance(level.var_744A[0].var_0116, param_03);
    var_0C = var_0B / 36;
  }

  if(isDefined(param_01)) {
    if(isDefined(param_02)) {
      foreach(var_0E in level.var_744A) {
        var_0F = param_01;
        if(var_0E == param_02) {
          var_0F = var_0F + "_2d";
        }

        var_0E method_85A7("snd_zmb_handle_vox_request", var_09, var_0A, var_0F, param_03);
      }

      return;
    }

    callclientscript(level.var_744A, "snd_zmb_handle_vox_request", var_09, var_0A, param_01, param_03);
  }
}

lib_0366::func_8E4C(param_00) {
  switch (param_00) {
    case "foo":
      break;

    default:
      break;
  }

  return param_00;
}

lib_0366::func_8E46(param_00) {
  self.var_071D.var_6599 = param_00;
}

lib_0366::func_8E10() {
  return self.var_071D.var_6599;
}

lib_0366::func_70C3(param_00) {}

lib_0366::func_93BD(param_00) {
  if(isDefined(param_00.var_8E52)) {
    var_01 = 3;
    var_02 = param_00.var_8E52;
    lib_0380::func_2893(var_02, var_01);
    param_00.var_8E52 = undefined;
  }
}

lib_0366::func_70C4(param_00) {
  var_01 = 0;
  var_02 = 1;
  var_03 = undefined;
  lib_0380::func_2889("tf_bird_retreat", var_03, param_00.var_78CB.var_0116, var_01, var_02);
}

lib_0366::func_35AE() {
  lib_0380::func_2888("perk_electric_cherry", self);
}

lib_0366::func_A1D6() {
  var_00 = lib_0380::func_288B("zmb_armor_machine_use", undefined, self);
  lib_0378::func_8D14(var_00);
}

lib_0366::func_94BC() {
  level.var_11CB.var_94BC = lib_0380::func_288B("zmb_ablty_stun_burst_use", undefined, self);
  lib_0378::func_8D14(level.var_11CB.var_94BC);
}

lib_0366::func_94B8() {
  var_00 = self;
  level.var_11CB.var_94B6 = lib_0380::func_288E("zmb_wonder_weapon_electrocute_lp", undefined, var_00, 0.25, 1, 0.25, "aud_stop_stun_lp");
  lib_0378::func_8D14(level.var_11CB.var_94B6);
}

lib_0366::func_94B7() {
  var_00 = self;
  var_00 notify("aud_stop_stun_lp");
  level.var_11CB.var_94B6 = undefined;
  level.var_11CB.var_94B5 = lib_0380::func_288B("zmb_wonder_weapon_electrocute_end", undefined, var_00);
  lib_0378::func_8D14(level.var_11CB.var_94B5);
}

lib_0366::func_5F5B() {
  level.var_11CB.var_5F5B = lib_0380::func_288B("zmb_ablty_mad_minute_use", undefined, self);
  lib_0378::func_8D14(level.var_11CB.var_5F5B);
}

lib_0366::func_983A() {
  level.var_11CB.var_983A = lib_0380::func_288B("zmb_ablty_taunt_use", undefined, self);
  lib_0378::func_8D14(level.var_11CB.var_983A);
}

lib_0366::func_1EBA() {
  level.var_11CB.var_1EBA = lib_0380::func_288B("zmb_ablty_camo_use", undefined, self);
  lib_0378::func_8D14(level.var_11CB.var_1EBA);
}

assassin_use_camoflage() {
  var_00 = self;
  lib_0380::func_288B("zmb_asn_ablty_camo_use", undefined, self);
}

strt_asn_camo_blur(param_00) {
  var_01 = self;
  var_01 method_8626("zmb_blurry_vision");
  var_01.var_071D.blurry_vision_snd = lib_0380::func_6840("zmb_blurry_vision", var_01, 0.2);
}

stp_asn_camo_blur() {
  var_00 = self;
  var_00 method_8627("zmb_blurry_vision");
  lib_0380::func_6850(var_00.var_071D.blurry_vision_snd, 2.5);
}

assassin_use_shell_shock() {
  var_00 = self;
  lib_0380::func_288B("zmb_asn_ablty_stun_burst_use", undefined, self);
}

assassin_use_taunt() {
  var_00 = self;
  lib_0380::func_288B("zmb_asn_ablty_taunt_use", undefined, self);
}

lib_0366::func_9D33() {
  var_00 = self;
  if(!isDefined(level.var_11CB.var_9D36)) {
    level.var_11CB.var_9D36 = lib_0380::func_288B("zmb_treasure_timer", undefined, var_00);
    lib_0378::func_8D14(level.var_11CB.var_9D36);
    lib_0380::func_288F(level.var_11CB.var_9D36, var_00, "treasurer_timer_done");
  }

  var_00 waittill("treasurer_timer_done");
  level.var_11CB.var_9D36 = undefined;
}

lib_0366::func_9D22() {
  var_00 = self;
  level.var_11CB.var_9A0D = lib_0380::func_288B("zmb_treasure_fuse", undefined, var_00);
  lib_0378::func_8D14(level.var_11CB.var_9A0D);
}

lib_0366::func_9D21() {
  var_00 = self;
  lib_0380::func_2893(level.var_11CB.var_9D36);
  level.var_11CB.var_9D36 = undefined;
}

lib_0366::func_AB0A(param_00) {
  lib_0380::func_2889("zmb_points_pickup", undefined, param_00);
}

lib_0366::func_AB0B(param_00) {
  lib_0380::func_2889("zmb_points_share", undefined, param_00);
}

lib_0366::func_AB0C() {
  lib_0380::func_2888("zmb_ravens_key_pickup", self);
}

zmb_ballistic_aura() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  var_01 = self.var_0116;
  lib_0380::func_288B("zmb_ballistic_aura_start", undefined, var_00);
  var_02 = lib_0380::func_6844("zmb_ballistic_aura_lp", undefined, var_00, 4);
  level waittill("aud_stop_ballistic_aura_snd");
  if(isDefined(var_02)) {
    lib_0380::func_6850(var_02);
    lib_0380::func_2889("zmb_ballistic_aura_stop", undefined, var_01);
  }
}

lib_0366::func_3D25(param_00) {
  lib_0366::func_3D03("zmb_flamethrower_start", undefined, self, 0, 1, param_00);
  var_01 = lib_0380::func_684A("zmb_flamethrower_lp", undefined, self, param_00, 0, 1);
  self.var_071D.var_3D19 = var_01;
  thread lib_0366::func_3D1C(param_00, var_01);
}

lib_0366::func_3D1C(param_00, param_01) {
  self endon("stop_flame_sfx");
  self waittill("death");
  lib_0366::func_3D26(param_00, param_01);
}

lib_0366::func_3D26(param_00, param_01) {
  if(isDefined(self.var_071D) && isDefined(self.var_071D.var_3D19)) {
    lib_0380::func_6850(self.var_071D.var_3D19, 1);
    self.var_071D.var_3D19 = undefined;
    lib_0366::func_3D03("zmb_flamethrower_stop", undefined, self, 0, 1, param_00);
  } else if(isDefined(param_01)) {
    lib_0380::func_6850(param_01, 1);
  }

  self notify("stop_flame_sfx");
}

lib_0366::func_3D03(param_00, param_01, param_02, param_03, param_04, param_05) {
  var_06 = undefined;
  if(isDefined(param_02)) {
    var_06 = playclientsound(param_00, param_02, undefined, undefined, param_05, "hard", param_03, undefined, param_04, undefined, param_01, undefined);
  }

  lib_0380::func_0787(isDefined(var_06), "Call to csnd failed for alias: " + param_00);
  return var_06;
}

lib_0366::func_9FE4() {
  lib_0380::func_6846("zmb_uber_battery_lp", undefined, self, 0.5, 1, 0.5);
}

lib_0366::func_98F1(param_00) {
  lib_0380::func_2889("zmb_tesla_hc_energy_lamp_destruct", undefined, param_00);
}

lib_0366::func_98F3(param_00) {
  lib_0366::func_98F2();
  level.var_071D.var_98F4 = lib_0380::func_6842("zmb_tesla_hc_energy_lamp_lp", undefined, param_00);
}

lib_0366::func_98F2() {
  if(isDefined(level.var_071D.var_98F4)) {
    lib_0380::func_6850(level.var_071D.var_98F4, 0.1);
  }
}

lib_0366::func_AA91() {
  var_00 = self;
  lib_0380::func_6842("mp_wpn_betty_triggered", undefined, var_00.var_0116);
}

lib_0366::func_AA90() {}

lib_0366::func_AA8F() {
  var_00 = self;
  lib_0380::func_6842("mp_wpn_betty_exp", undefined, var_00.var_0116);
}

lib_0366::func_5872() {
  var_00 = self;
  var_01 = lib_0380::func_2889("zmb_jack_box_land", undefined, var_00.var_0116);
  lib_0378::func_8D14(var_01);
  var_02 = lib_0380::func_2889("zmb_jack_box_idle", undefined, var_00.var_0116);
  lib_0378::func_8D14(var_02);
}

lib_0366::func_5873() {
  var_00 = self;
  var_01 = lib_0380::func_2889("zmb_jack_box_pop_up", undefined, var_00.var_0116);
  lib_0378::func_8D14(var_01);
  wait(0.25);
  var_02 = lib_0380::func_2889("zmb_jack_box_fuse", undefined, var_00.var_0116);
  lib_0378::func_8D14(var_02);
}

lib_0366::func_5871() {
  var_00 = self;
  var_01 = lib_0380::func_2889("wpn_grenade_exp", undefined, var_00.var_0116);
  lib_0378::func_8D14(var_01);
}

lib_0366::func_1CB9() {
  callclientscript(level.var_744A, "snd_brute_defeated");
}

ripsaw_spine_cut() {
  wait(1);
  lib_0380::func_288B("zmb_spine_cut", self, self);
}

ripsaw_fatal_melee() {
  if(common_scripts\utility::func_562E(self.var_165B) || self adsButtonPressed()) {
    lib_0380::func_288B("wpn_ripsaw_bayonet_charge_hit", undefined, self);
    return;
  }

  lib_0380::func_288B("wpn_ripsaw_jab_impact", undefined, self);
}

ripsaw_start_spinning() {
  lib_0380::func_6844("wpn_ripsaw_spin", self, self);
  var_00 = lib_0380::func_6844("wpn_ripsaw_spin_loop", self, self);
  lib_0380::func_684F(var_00, 0.5, "stop_ripsaw_idle_loop");
}

ripsaw_stop_spinning() {
  level notify("stop_ripsaw_idle_loop");
}

wunderbuss_bolt_charge_beam(param_00, param_01) {
  var_02 = spawn("script_origin", param_00);
  var_03 = 0;
  var_04 = 1;
  lib_0380::func_288E("wpn_wunderbuss_charge_beam", undefined, var_02, 0, var_04, 1, "aud_stop_beam_charge");
  var_02 moveto(param_01, 0.9);
  self waittill("aud_stop_beam_charge");
  var_02 delete();
}

wunderbuss_charge_beam_end() {
  lib_0380::func_288B("wpn_wunderbuss_charge_beam_end", undefined, self);
}

zmb_bat_melee_hit_wooden(param_00) {
  var_01 = self;
  if(isDefined(param_00.delaysec)) {
    wait(param_00.delaysec * 0.5);
  }

  foreach(var_03 in level.var_744A) {
    if(var_03 == param_00.var_721C) {
      lib_0380::func_2889("zmb_bat_melee_hit_wooden", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_bat_melee_hit_wooden_npc", undefined, param_00.var_ABE6, undefined, 0.5);
  }
}

zmb_bat_melee_hit_metal(param_00) {
  if(isDefined(param_00.delaysec)) {
    wait(param_00.delaysec * 0.5);
  }

  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_bat_melee_hit_metal", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_bat_melee_hit_metal", undefined, param_00.var_ABE6, undefined, 0.5);
  }
}

zmb_hc_bat_aoe_fx(param_00, param_01) {
  var_02 = self;
  foreach(var_04 in level.var_744A) {
    if(var_04 == var_02) {
      lib_0380::func_2889("zmb_hc_bat_aoe_fx", undefined, param_00.var_0116);
      continue;
    }

    lib_0380::func_2889("zmb_hc_bat_aoe_fx", undefined, param_00.var_0116, undefined, 0.5);
  }
}

zmb_sword_melee_hit(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_barbarosa_swrd_hit", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_barbarosa_swrd_hit", undefined, param_00.var_ABE6, undefined, 0.5);
  }
}

zmb_sword_melee_hit_delayed(param_00) {
  var_01 = self;
  foreach(var_03 in level.var_744A) {
    if(var_03 == var_01) {
      lib_0380::func_2889("zmb_barbarosa_swrd_hit", undefined, param_00);
      continue;
    }

    lib_0380::func_2889("zmb_barbarosa_swrd_hit", undefined, param_00, undefined, 0.5);
  }
}

zmb_sword_aoe(param_00) {
  var_01 = self;
  foreach(var_03 in level.var_744A) {
    if(var_03 == var_01) {
      lib_0380::func_2889("zmb_barbarosa_swrd_aoe", undefined, param_00);
      continue;
    }

    lib_0380::func_2889("zmb_barbarosa_swrd_aoe", undefined, param_00, undefined, 0.5);
  }
}

zmb_knife_melee_hit(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_trenchknife_hit", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_trenchknife_hit", undefined, param_00.var_ABE6, undefined, 1);
  }
}

zmb_knife_finisher_effects() {
  var_00 = self;
  lib_0380::func_288B("zmb_trenchknife_alt_hit_hc", undefined, var_00);
  wait(0.5);
  lib_0380::func_288B("zmb_trenchknife_armor_gain", undefined, var_00);
}

zmb_axe_melee_hit(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_axe_hit", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_axe_hit", undefined, param_00.var_ABE6, undefined, 1);
  }
}

zmb_axe_melee_alt_hit(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_axe_hit_alt_hit", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_axe_hit_alt_hit", undefined, param_00.var_ABE6, undefined, 1);
  }
}

zmb_axe_hc_melee_hit(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_axe_hc_hit", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_axe_hc_hit", undefined, param_00.var_ABE6, undefined, 1);
  }
}

zmb_axe_hc_melee_alt_hit(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_axe_hit_alt_hit", undefined, param_00.var_ABE6);
      lib_0380::func_2889("zmb_axe_hit_alt_hit_hc", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_axe_hit_alt_hit", undefined, param_00.var_ABE6, undefined, 1);
    lib_0380::func_2889("zmb_axe_hit_alt_hit_hc", undefined, param_00.var_ABE6, undefined, 1);
  }
}

lib_0366::func_AA59() {
  var_00 = "ww_electrocute_end" + self getentitynumber();
  level.var_11CB.var_AAC4 = level lib_0380::func_6847("zmb_wonder_weapon_electrocute_lp", undefined, self, 0.25, undefined, 0.25, level, var_00);
}

wonder_weapon_electrocute_end() {
  var_00 = "ww_electrocute_end" + self getentitynumber();
  level notify(var_00);
}

lib_0366::func_6401() {
  var_00 = lib_0380::func_6846("zmb_wonder_weapon_proj_moon_lp", undefined, self, 0.25);
}

lib_0366::func_6400() {
  var_00 = lib_0380::func_2889("zmb_wonder_weapon_proj_moon_end", undefined, self.var_0116);
}

lib_0366::func_9433() {
  var_00 = lib_0380::func_6846("zmb_wonder_weapon_storm_proj_lp", undefined, self, 0.25);
}

lib_0366::func_9432() {
  var_00 = lib_0380::func_2889("zmb_wonder_weapon_storm_proj_end", undefined, self.var_0116);
}

lib_0366::func_AAC9() {
  if(!isDefined(level.var_11CB.var_AAC9)) {
    level.var_11CB.var_AAC9 = lib_0380::func_2889("zmb_wonder_weapon_proj_zap", undefined, self.var_0116);
    wait(1);
    level.var_11CB.var_AAC9 = undefined;
  }
}

lib_0366::func_AAC2() {
  level.var_11CB.var_17F1 = lib_0380::func_2889("zmb_ww_projectile_blood_explode", undefined, self.var_0116);
}

lib_0366::func_AAC3() {
  level.var_11CB.var_AAC3 = lib_0380::func_2889("zmb_ww_projectile_raven_explode", undefined, self.var_0116);
}

zmb_siz_trans_fx_burst(param_00) {
  lib_0380::func_2889("zmb_siz_trans_fx_burst", undefined, param_00);
}

zmb_uberschnell_pickup() {
  if(!isDefined(self)) {
    return;
  }

  lib_0380::func_288B("zmb_uberschnell_pickup", undefined, self);
}

pap_wpn_charlton_vortex() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  lib_0380::func_288E("zmb_wpn_charlton_vortex", undefined, var_00, 0, 1, 1.5, "vortex_end");
}

pap_wpn_crossbow_cricket_shot() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  lib_0380::func_288B("zmb_wpn_crossbow_cricket_shot", undefined, var_00);
}

pap_wpn_crossbow_cricket_explo() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  lib_0380::func_288B("zmb_wpn_crossbow_cricket_explo", undefined, var_00);
}

pap_wpn_emp44_bomb_reload(param_00, param_01) {
  switch (param_00) {
    case "spawn":
      param_01.spawn_lp = lib_0380::func_6846("zmb_wpn_emp44_spawn_bomb_lp", undefined, param_01, 0.2, undefined, 0.75);
      break;

    case "activate":
      param_01.activate_strt_snd = lib_0380::func_6844("zmb_wpn_emp44_bomb_start", undefined, param_01);
      param_01.activate_lp_snd = lib_0380::func_6846("zmb_wpn_emp44_bomb_activated_lp", undefined, param_01, 0.2, undefined, 0.5);
      break;

    case "explode":
      param_01.activate_end_snd = lib_0380::func_6844("zmb_wpn_emp44_bomb_end", undefined, param_01);
      param_01.boom_snd = lib_0380::func_6844("zmb_wpn_emp44_bomb_detonate", undefined, param_01);
      break;

    default:
      break;
  }
}

pap_wpn_sdk_shottysnipe_fire(param_00) {
  if(!isDefined(param_00)) {
    return;
  }

  lib_0380::func_2889("zmb_wpn_sdk_pap_add", undefined, param_00);
}

lib_0366::func_8E41(param_00) {}

lib_0366::func_8E07(param_00, param_01) {}