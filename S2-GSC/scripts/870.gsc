/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\870.gsc
**************************************/

_id_8E25() {
  level _id_8E44();
  level _id_8E27();
  level thread snd_level_handle_zombie_round_countdown_started();
  level thread snd_level_handle_zombie_wave_started();
  level thread snd_level_handle_zombie_wave_ended();
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_3 = _func_27A("mp/zmCharacterIdTable.csv");

  for(var_4 = 0; var_4 < var_3; var_4++) {
    var_5 = var_0.size;
    var_6 = _func_1AE("mp/zmCharacterIdTable.csv", var_4, 13);
    var_0[var_5] = var_6;
    var_7 = _func_1AE("mp/zmCharacterIdTable.csv", var_4, 15);

    if(isDefined(var_7))
      var_1[var_5] = var_7;

    var_8 = _func_1AE("mp/zmCharacterIdTable.csv", var_4, 16);

    if(isDefined(var_8))
      var_2[var_5] = var_8;
  }

  level _id_0367::_id_8E3A(var_0, ::_id_8E75, var_1, var_2);
  level._id_071D.threat_to_dlg_vol_scalar = [[0, 0.75], [1, 1.0]];
  level._id_071D.round_countdown_alias = "hvox_breath_countdown";
  level._id_071D.round_countdown_end_alias = undefined;
  level._id_071D.global_threat_scalar = 0.666;
  level._snd_num_players_in_combat = 0;
  level._id_071D.map_wave_music_master_volume_scalar = 1.0;
  level._id_071D.zombie_vox_attack_hit_prev_time = 0;
  level._id_071D.zombie_vox_attack_hit_wait_time_min = 3;
  level._id_071D.zombie_vox_attack_hit_wait_time_max = 5;
  level._id_071D.zombie_vox_attack_hit_wait_time = _func_0A4(2, 4);
  level._id_071D.zombie_vox_attack_hit_req_names = ["attack_hit", "anim_sprint_attack_1", "anim_sprint_attack_2", "anim_sprint_attack_3", "anim_stand_attack_1", "anim_stand_attack_2", "anim_stand_attack_3"];
  level thread sndx_monitor_num_players_in_combat(::sndx_update_global_threat_scalar);
  _id_0547::_id_7BA9(::_id_8E2E);
}

_id_8E75(var_0, var_1, var_2) {
  var_3 = self;
  var_4 = 1.0;

  if(var_0 == "begin") {
    var_3 _meth_85A7("snd_zmb_player_is_speaking", 1);
    var_3 _meth_8626("zmb_mute_player_vox", 0.0);
    var_4 = var_3 sndx_get_threat_dialog_volume();
  } else if(var_0 == "end") {
    var_3 _meth_85A7("snd_zmb_player_is_speaking", 0);
    var_3 _meth_8627("zmb_mute_player_vox", 0.5);
  }

  return var_4;
}

sndx_get_threat_dialog_volume() {
  var_0 = _id_8E14();
  return _id_0378::_id_8D72(var_0, level._id_071D.threat_to_dlg_vol_scalar);
}

_id_8E44() {
  _id_0378::_id_8DC7("player_connect", ::_id_7247);
  _id_0378::_id_8DC7("onZombieSpawn", ::_id_ABFA);
  _id_0378::_id_8DC7("onZombieDamaged", ::_id_6BD1);
  _id_0378::_id_8DC7("onZombieKilled", ::_id_6BD4);
  _id_0378::_id_8DC7("objective_complete", ::_id_690B);
  _id_0378::_id_8DC7("snd_zmb_mus_start", ::_id_8E31);
  _id_0378::_id_8DC7("snd_zmb_mus_stop", ::_id_8E32);
  _id_0378::_id_8DC7("snd_zmb_mus_stop_all_players", ::_id_8E33);
  _id_0378::_id_8DC7("simple_jump_scare", ::_id_8C59);
  _id_0378::_id_8DC7("zombie_set_anim_state", ::_id_ABF0);
  _id_0378::_id_8DC7("set_client_sticky_threat", ::_id_8E47);
  _id_0378::_id_8DC7("clear_client_sticky_threat", ::_id_8E09);
  _id_0378::_id_8DC7("vox_request", ::_id_8E4B);
  _id_0378::_id_8DC7("aud_raven_sword_power_up", ::_id_7A83);
  _id_0378::_id_8DC7("aud_raven_sword_power_dwn", ::_id_7A82);
  _id_0378::_id_8DC7("aud_raven_sword_aoe", ::_id_7A7A);
  _id_0378::_id_8DC7("zombies_2016_gl_ending", ::_id_AC3C);
  _id_0378::_id_8DC7("trap_spinner_activate", ::_id_9CC9);
  _id_0378::_id_8DC7("money_spend", ::_id_62D2);
  _id_0378::_id_8DC7("found_collectible", ::_id_3E42);
  _id_0378::_id_8DC7("zombie_ignite", ::_id_ABCE);
  _id_0378::_id_8DC7("zombie_extinguish", ::_id_ABA2);
  _id_0378::_id_8DC7("zombie_fall_impact", ::_id_ABA3);
  _id_0378::_id_8DC7("mystery_box_attract_on", ::_id_65F0);
  _id_0378::_id_8DC7("mystery_box_attract_off", ::_id_65EF);
  _id_0378::_id_8DC7("mystery_box_attract_open", ::_id_65F1);
  _id_0378::_id_8DC7("mystery_box_attract_closed", ::_id_65EE);
  _id_0378::_id_8DC7("mystery_box_elec", ::_id_65F3);
  _id_0378::_id_8DC7("mystery_box_open", ::_id_65F5);
  _id_0378::_id_8DC7("mystery_box_close", ::_id_65F2);
  _id_0378::_id_8DC7("play_bird_loop", ::_id_70C3);
  _id_0378::_id_8DC7("stop_bird_loop", ::_id_93BD);
  _id_0378::_id_8DC7("play_bird_retreat", ::_id_70C4);
  _id_0378::_id_8DC7("electric_cherry_vfx", ::_id_35AE);
  _id_0378::_id_8DC7("flamethrower_start", ::_id_3D25);
  _id_0378::_id_8DC7("flamethrower_stop", ::_id_3D26);
  _id_0378::_id_8DC7("uber_battery_spawn", ::_id_9FE4);
  _id_0378::_id_8DC7("tesla_hc_energy_lamp_destruct", ::_id_98F1);
  _id_0378::_id_8DC7("tesla_hc_energy_lamp_loop_on", ::_id_98F3);
  _id_0378::_id_8DC7("tesla_hc_energy_lamp_loop_off", ::_id_98F2);
  _id_0378::_id_8DC7("wpn_bouncingbetty_trigger", ::_id_AA91);
  _id_0378::_id_8DC7("wpn_bouncingbetty_spin", ::_id_AA90);
  _id_0378::_id_8DC7("wpn_bouncingbetty_exp", ::_id_AA8F);
  _id_0378::_id_8DC7("aud_jack_in_box_land", ::_id_5872);
  _id_0378::_id_8DC7("aud_jack_open", ::_id_5873);
  _id_0378::_id_8DC7("aud_jack_in_box_explode", ::_id_5871);
  _id_0378::_id_8DC7("aud_use_armor_machine", ::_id_A1D6);
  _id_0378::_id_8DC7("aud_stunning_burst_use", ::_id_94BC);
  _id_0378::_id_8DC7("aud_stun_zombies_strt", ::_id_94B8);
  _id_0378::_id_8DC7("aud_stun_zombies_end", ::_id_94B7);
  _id_0378::_id_8DC7("aud_mad_minute_use", ::_id_5F5B);
  _id_0378::_id_8DC7("aud_taunt_use", ::_id_983A);
  _id_0378::_id_8DC7("aud_camo_use", ::_id_1EBA);
  _id_0378::_id_8DC7("aud_assassin_use_camoflage", ::assassin_use_camoflage);
  _id_0378::_id_8DC7("aud_assassin_use_shell_shock", ::assassin_use_shell_shock);
  _id_0378::_id_8DC7("aud_assassin_use_taunt", ::assassin_use_taunt);
  _id_0378::_id_8DC7("aud_strt_asn_camo_blur", ::strt_asn_camo_blur);
  _id_0378::_id_8DC7("aud_stp_asn_camo_blur", ::stp_asn_camo_blur);
  _id_0378::_id_8DC7("aud_treasurer_strt_timer", ::_id_9D33);
  _id_0378::_id_8DC7("aud_treasurer_end_timer", ::_id_9D21);
  _id_0378::_id_8DC7("aud_treasurer_fuse", ::_id_9D22);
  _id_0378::_id_8DC7("zmb_points_pickup", ::_id_AB0A);
  _id_0378::_id_8DC7("zmb_points_share", ::_id_AB0B);
  _id_0378::_id_8DC7("zmb_ravens_key_pickup", ::_id_AB0C);
  _id_0378::_id_8DC7("zmb_ballistic_aura", ::zmb_ballistic_aura);
  _id_0378::_id_8DC7("brute_battle_complete_notification", ::_id_1CB9);
  _id_0378::_id_8DC7("ripsaw_spine_cut", ::ripsaw_spine_cut);
  _id_0378::_id_8DC7("ripsaw_fatal_melee", ::ripsaw_fatal_melee);
  _id_0378::_id_8DC7("aud_ripsaw_start_spinning", ::ripsaw_start_spinning);
  _id_0378::_id_8DC7("aud_ripsaw_stop_spinning", ::ripsaw_stop_spinning);
  _id_0378::_id_8DC7("aud_ber_wunderbuss_charge_beam", ::wunderbuss_bolt_charge_beam);
  _id_0378::_id_8DC7("aud_ber_wunderbuss_charge_beam_end", ::wunderbuss_charge_beam_end);
  _id_0378::_id_8DC7("zmb_bat_melee_hit_wooden", ::zmb_bat_melee_hit_wooden);
  _id_0378::_id_8DC7("zmb_bat_melee_hit_metal", ::zmb_bat_melee_hit_metal);
  _id_0378::_id_8DC7("zmb_hc_bat_aoe_fx", ::zmb_hc_bat_aoe_fx);
  _id_0378::_id_8DC7("zmb_sword_melee_hit", ::zmb_sword_melee_hit);
  _id_0378::_id_8DC7("zmb_sword_melee_hit_delayed", ::zmb_sword_melee_hit_delayed);
  _id_0378::_id_8DC7("zmb_sword_aoe", ::zmb_sword_aoe);
  _id_0378::_id_8DC7("zmb_knife_melee_hit", ::zmb_knife_melee_hit);
  _id_0378::_id_8DC7("zmb_knife_finisher_effects", ::zmb_knife_finisher_effects);
  _id_0378::_id_8DC7("zmb_axe_melee_hit", ::zmb_axe_melee_hit);
  _id_0378::_id_8DC7("zmb_axe_melee_alt_hit", ::zmb_axe_melee_alt_hit);
  _id_0378::_id_8DC7("zmb_axe_hc_melee_hit", ::zmb_axe_hc_melee_hit);
  _id_0378::_id_8DC7("zmb_axe_hc_melee_alt_hit", ::zmb_axe_hc_melee_alt_hit);
  _id_0378::_id_8DC7("zmb_siz_trans_fx_burst", ::zmb_siz_trans_fx_burst);
  _id_0378::_id_8DC7("aud_zmb_uberschnell_pickup", ::zmb_uberschnell_pickup);
  _id_0378::_id_8DC7("aud_wonder_weapon_electrocute_strt", ::_id_AA59);
  _id_0378::_id_8DC7("aud_wonder_weapon_electrocute_end", ::wonder_weapon_electrocute_end);
  _id_0378::_id_8DC7("aud_moon_projectile_strt", ::_id_6401);
  _id_0378::_id_8DC7("aud_moon_projectile_end", ::_id_6400);
  _id_0378::_id_8DC7("aud_storm_proj_loop_strt", ::_id_9433);
  _id_0378::_id_8DC7("aud_storm_proj_loop_end", ::_id_9432);
  _id_0378::_id_8DC7("aud_ww_projectile_zap", ::_id_AAC9);
  _id_0378::_id_8DC7("aud_ww_blood_explode", ::_id_AAC2);
  _id_0378::_id_8DC7("aud_ww_death_explode", ::_id_AAC3);
  _id_0378::_id_8DC7("aud_pap_wpn_charlton_vortex", ::pap_wpn_charlton_vortex);
  _id_0378::_id_8DC7("aud_pap_wpn_crossbow_cricket_shot", ::pap_wpn_crossbow_cricket_shot);
  _id_0378::_id_8DC7("aud_pap_wpn_crossbow_cricket_explo", ::pap_wpn_crossbow_cricket_explo);
  _id_0378::_id_8DC7("aud_pap_wpn_emp44_bomb_reload", ::pap_wpn_emp44_bomb_reload);
  _id_0378::_id_8DC7("aud_pap_wpn_sdk_shottysnipe_fire", ::pap_wpn_sdk_shottysnipe_fire);
}

_id_8E0C() {
  var_0 = "zombie_generic";
  var_0 = "zombie_generic2";
  var_0 = "zombie_berserker";
  var_0 = "zombie_heavy";
  var_0 = "zombie_exploder";
  var_0 = "zombie_fireman";
  var_0 = "zombie_boss_village";
  var_0 = "zombie_klaus";
  var_0 = "zombie_treasurer";
  var_0 = "zombie_assassin";
  var_0 = "zombie_sizzler";
  var_0 = "zombie_bob";
  var_0 = "zombie_guardian";
  var_0 = "zombie_king";
  var_0 = "zombie_dlc4";
  var_0 = "zde_taunt";
  var_0 = "growl_lev1";
  var_0 = "growl_lev2";
  var_0 = "growl_lev3";
  var_0 = "growl_lev4";
  var_0 = "sneakattack_busted";
  var_0 = "charge";
  var_0 = "sneakattack_success";
  var_0 = "sneakattack_success_2d";
  var_0 = "jumpscare1";
  var_0 = "attack";
  var_0 = "pain";
  var_0 = "death";
  var_0 = "mus_stinger_lrg";
  var_0 = "mus_stinger_med";
  var_0 = "mus_stinger_sml";
  var_0 = "attack_hit";
  var_0 = "attack_miss";
}

_id_8E27() {
  _id_8E0C();
  common_scripts\utility::_id_3799("zombie_passive");
  level._id_071D._id_A974 = 0;
  level._id_071D._id_5AB6 = 16;
  level._id_071D._id_4031 = 0;
  var_0 = [[0.0, 1.0], [0.0667, 0.95], [0.1333, 0.650963], [0.2, 0.512], [0.2667, 0.39437], [0.3333, 0.296296], [0.4, 0.216], [0.4667, 0.151704], [0.5333, 0.10163], [0.6, 0.064], [0.6667, 0.037037], [0.7333, 0.018963], [0.8, 0.008], [0.8667, 0.00237037], [0.9333, 0.000296296], [1.0, 0.0]];
  level._id_071D._id_725F = _id_0378::_id_8DCB(var_0, 1.0, 0.5);
  level._id_071D._id_AB8E = [[0.0, 1.0], [0.0667, 0.978023], [0.1333, 0.914947], [0.2, 0.818731], [0.2667, 0.700784], [0.3333, 0.573753], [0.4, 0.449329], [0.4667, 0.33659], [0.5333, 0.241177], [0.6, 0.165299], [0.6667, 0.108368], [0.7333, 0.0679564], [0.8, 0.0407622], [0.8667, 0.0233875], [0.9333, 0.0128353], [1.0, 0.0]];
  level._id_071D._id_7500 = [[0.0, 0.666], [1.0, 1.0]];
  level._id_071D._id_AC07 = 1;
  level._id_071D._id_0CB8 = [[0.0, 1000], [1.0, 10000]];
}

snd_level_handle_zombie_round_countdown_started() {
  for(;;) {
    level common_scripts\utility::_id_A70A("zombie_round_countdown_started", "zombies_manual_start");
    var_0 = 1.0;
    level._id_071D.round_countdown_snd = _id_0380::_id_6840(level._id_071D.round_countdown_alias, undefined, var_0);
  }
}

snd_level_handle_zombie_wave_started() {
  for(;;) {
    level waittill("zombie_wave_started");

    if(isDefined(level._id_071D.round_countdown_end_alias)) {
      _id_0380::_id_6850(level._id_071D.round_countdown_snd, 0.5);
      level._id_071D.round_countdown_snd = undefined;
      _id_0380::_id_6840(level._id_071D.round_countdown_end_alias);
    }

    _id_0380::_id_6840("zmb_ui_wave_splash");
    level._id_071D._id_A974 = 1;

    foreach(var_1 in level.players) {
      var_1 _id_8E4D();
      var_1 _id_0378::_id_8D74("wave_begin");
    }
  }
}

snd_level_handle_zombie_wave_ended() {
  for(;;) {
    level waittill("zombie_wave_ended");
    level._id_071D._id_A974 = 0;

    foreach(var_1 in level.players) {
      var_1 _id_8E4E();
      var_1 _id_0378::_id_8D74("wave_end");
    }
  }
}

_id_8E00(var_0) {
  if(isDefined(level.players) && level.players.size > 0) {
    foreach(var_2 in level.players) {
      if(isDefined(var_2)) {
        var_2 _meth_8626(var_0);
        waitframe();
      }
    }
  }
}

_id_7247() {
  self _meth_85A7("ClientScriptInit", "zombies");
  self _meth_8626("zmb_init_mix");
  self _meth_8626("zmb_init_overrides_mix");
  self _meth_8626("zmb_headroom_mix");
  _id_8E45();
  thread _id_8E21();
  thread _id_8E1C();
  thread _id_8E20();
  thread _id_8E1E();
  thread _id_8E1F();
  thread _id_8E1B();
  thread _id_8E1D();
  thread _id_8E2C();
  thread _id_8E2B();
  thread _id_8E40();
  _id_8E2F(1.0, 0.1, self);
  _id_0378::_id_8D74("player_connect_map");
  self._id_071D._id_6599 = 0;
}

_id_ABFA() {
  self._id_071D = spawnStruct();
  self._id_071D._id_502A = snd_zmb_new_guid();
  self._id_071D._id_9977 = 0;
  self._id_071D._id_900C = gettime();
  self._id_071D._id_99E0 = [];
  self._id_071D._id_0A47 = self._id_0A4B;

  switch (self._id_071D._id_0A47) {
    case "zombie_generic":
      self._id_071D._id_9979 = 1.0;
      var_0 = 3;
      var_1 = common_scripts\utility::_id_627D(level._id_071D._id_4031, var_0);

      if(var_1 < var_0 - 1)
        self._id_071D._id_0A47 = self._id_071D._id_0A47 + "2";

      level._id_071D._id_4031++;
      _id_8E26(::_id_8E05);
      break;
    case "zombie_berserker":
      self._id_071D._id_9979 = 1.0;
      _id_8E26(::_id_8E01);
      _id_0380::_id_6846("fly_swarm_npc", undefined, self, 4, 1.0, 5);
      break;
    case "zombie_sizzler":
      self._id_071D._id_9979 = 1.0;
      break;
    case "zombie_fireman":
      self._id_071D._id_9979 = 3.5;
      _id_8E26(::_id_8E04);
      break;
    case "zombie_exploder":
      self._id_071D._id_9979 = 3.0;
      _id_8E26(::_id_8E03);
      break;
    case "zombie_treasurer":
      self._id_071D._id_9979 = 3.5;
      _id_8E26(::_id_8E03);
      break;
    case "zombie_heavy":
      self._id_071D._id_9979 = 3.0;
      _id_8E26(::_id_8E06);
      break;
    case "zombie_assassin":
      self._id_071D._id_9979 = 3.5;
      _id_8E26(::_id_8E02);
      break;
    case "zombie_boss_village":
      self._id_071D._id_9979 = 10.0;
      _id_8E26(::_id_8E06);
      break;
    case "zombie_bob":
      self._id_071D._id_9979 = 10.0;
      break;
    case "zombie_guardian":
      self._id_071D._id_9979 = 10.0;
      break;
    default:
      self._id_071D._id_9979 = 1.0;
      _id_8E26(::_id_8E02);
      break;
  }

  if(_id_8E19())
    _id_8E37();

  thread _id_8E2A();
  thread _id_8E2D();
}

_id_6BD1(var_0) {
  if(var_0._id_60B8 == "MELEE" || var_0._id_60B8 == "MOD_MELEE")
    var_0.player _meth_85A7("snd_zmb_handle_plr_melee");

  if(issubstr(var_0._id_01D0, "shovel")) {
    if(isalive(self))
      _id_8E8D("zm_melee_shovel_head_2d", "zm_melee_shovel_head", var_0.player.origin, 72, 1.0);
    else
      _id_8E8D("zm_melee_shovel_head_2d", "zm_melee_shovel_head", var_0.player.origin, 72, 0.5);
  }

  if(var_0._id_01D0 == "raven_sword_zm")
    _id_8E8D("zmb_raven_swrd_hit_2d", "zmb_raven_swrd_hit", var_0.player.origin, 72);
}

_id_8E8D(var_0, var_1, var_2, var_3, var_4) {
  foreach(var_6 in level.players) {
    var_7 = distance(var_6.origin, var_2);

    if(var_7 < var_3) {
      _id_0380::_id_6840(var_0, var_6, 0, var_4);
      continue;
    }

    _id_0380::_id_6842(var_1, var_6, var_2, 0, var_4);
  }
}

_id_7A83() {
  var_0 = self;
  level._id_11CB._id_9571 = _id_0380::_id_288B("zmb_raven_swrd_power_up", undefined, var_0);
  _id_0378::_id_8D14(level._id_11CB._id_9571);

  if(!isDefined(level._id_11CB._id_9570)) {
    level._id_11CB._id_9570 = _id_0380::_id_288B("zmb_raven_swrd_power_lp", undefined, var_0, 0.25);
    _id_0378::_id_8D14(level._id_11CB._id_9570);
  }
}

_id_7A82() {
  _id_0380::_stoplocalsound(level._id_11CB._id_9570, 0.25);
  level._id_11CB._id_9570 = undefined;
}

_id_7A7A() {
  var_0 = self;
  var_1 = _id_0380::_id_288B("zmb_raven_swrd_aoe", undefined, var_0);
  _id_0378::_id_8D14(var_1);
}

_id_6BD4(var_0) {
  switch (var_0._id_4DCF) {
    case "head":
      var_0.player playlocalsound("zm_hit_kill_head_impact");
      wait 0.25;
      _id_046C::_id_8DA0("zm_hit_kill_headshot_splatter", var_0._id_ABE6);
      break;
    case "helmet":
      var_0.player playlocalsound("zm_hit_kill_head_impact");
      _id_046C::_id_8DA0("zm_hit_kill_helmet_impact", var_0._id_ABE6);
      wait 0.25;
      _id_046C::_id_8DA0("zm_hit_kill_headshot_splatter", var_0._id_ABE6);
      break;
    default:
      var_0.player playlocalsound("zm_hit_kill");
      break;
  }
}

_id_690B(var_0) {
  level notify("stop_objective_complete");
  level endon("objective_complete");
  _id_0378::_id_8DC2("objective_complete: " + var_0);

  if(!isDefined(level._id_071D._id_690D))
    level._id_071D._id_690D = [["mus_objective_complete_01", 13], ["mus_objective_complete_02", 13], ["mus_objective_complete_03", 16], ["mus_objective_complete_04", 14], ["mus_objective_complete_05", 15], ["mus_objective_complete_06", 14]];

  if(isDefined(self._id_071D._id_690C)) {
    _id_0380::_stoplocalsound(self._id_071D._id_690C, 1.0);
    self._id_071D._id_690C = undefined;
  } else
    self _meth_8626("zmb_objective_complete_mix");

  var_1 = level._id_071D._id_690D[randomint(level._id_071D._id_690D.size)];
  self._id_071D._id_690C = _id_0380::_id_2888(var_1[0], self);
  wait(var_1[1]);
  self _meth_8627("zmb_objective_complete_mix");
  self._id_071D._id_690C = undefined;
}

snd_set_round_countdown_aliases(var_0, var_1) {
  level._id_071D.round_countdown_alias = var_0;
  level._id_071D.round_countdown_end_alias = var_1;
}

snd_get_round_countdown_aliases() {
  var_0 = spawnStruct();
  var_0.round_countdown_alias = level._id_071D.round_countdown_alias;
  var_0.round_countdown_end_alias = level._id_071D.round_countdown_end_alias;
  return var_0;
}

snd_set_mus_combat_cues_override(var_0) {
  level._id_071D.mus_combat_cues_override = var_0;
}

snd_clear_mus_combat_cues_override() {
  level._id_071D.mus_combat_cues_override = undefined;
}

_id_8D46() {
  if(!isDefined(level._id_071D._id_6552))
    level._id_071D._id_6552 = ["zom_movin", "zmb_mus_wave_02", "zmb_mus_wave_03", "zmb_mus_wave_04", "zom_screetchy1", "zmb_mus_wave_01", "zmb_mus_wave_05"];

  var_0 = level._id_071D._id_6552;

  if(isDefined(level._id_071D.mus_combat_cues_override))
    var_0 = level._id_071D.mus_combat_cues_override;

  if(_func_033("ui_zm_round_number") > 10)
    var_1 = var_0[randomint(var_0.size)];
  else {
    var_1 = var_0[self._id_071D._id_6551];
    self._id_071D._id_6551 = (self._id_071D._id_6551 + 1) % var_0.size;
  }

  return var_1;
}

_id_8DCF(var_0) {
  self._id_071D._id_A97B = var_0;
}

snd_get_curr_combat_cue_name() {
  return self._id_071D._id_A97B;
}

_id_8D9F() {
  _id_0380::_id_2888("fly_swarm_player", self);
}

_id_8C59(var_0) {
  var_1 = self;
  thread _id_8E34("mus_stinger_lrg", var_1, 1.0, var_0);
  wait 0.1;

  foreach(var_3 in level.players) {
    if(var_3 == var_1 && distance(var_3.origin, var_0.origin) < 108) {
      var_3 thread _id_8E49(var_0, "sneakattack_success", 1);
      continue;
    }

    var_3 thread _id_8E49(var_0, "sneakattack_success", 0);
  }
}

snd_not_so_simple_jump_scare(var_0) {
  var_0 = self;
  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.players) {
    var_5 = distance(var_4.origin, var_0.origin);

    if(var_5 < 540) {
      var_2[var_2.size] = var_4;

      if(var_5 < 144)
        var_1[var_1.size] = var_4;
    }
  }

  foreach(var_4 in var_1)
  thread _id_8E34("mus_stinger_lrg", var_4, 1.0, var_0);

  wait 0.1;

  foreach(var_4 in var_2)
  var_4 thread _id_8E49(var_0, "sneakattack_success");
}

_id_8E2A() {}

_id_8E26(var_0) {
  self._id_071D._id_AB00 = var_0;
}

_id_ABF0(var_0, var_1) {
  if(isDefined(self._id_071D._id_AB00))
    self[[self._id_071D._id_AB00]](var_0, var_1);
}

_id_8E01(var_0, var_1) {
  switch (var_1) {
    case "s2_zom_spr_sprint_death_v1":
      _id_8E4B("anim_death");
      break;
    case "s2_zom_spr_sprint_stun_react_left":
      _id_8E4B("anim_hit_react_left");
      break;
    case "s2_zom_spr_sprint_stun_react_right":
      _id_8E4B("anim_hit_react_right");
      break;
    case "s2_zom_spr_sprint_v1":
      _id_8E4B("anim_sprint_1");
      break;
    case "s2_zom_spr_sprint_v2":
      _id_8E4B("anim_sprint_2");
      break;
    case "s2_zom_spr_sprint_v3":
      _id_8E4B("anim_sprint_3");
      break;
    case "s2_zom_spr_sprint_attack_v1":
      _id_8E4B("anim_sprint_attack_1");
      break;
    case "s2_zom_spr_sprint_attack_v2":
      _id_8E4B("anim_sprint_attack_2");
      break;
    case "s2_zom_spr_sprint_attack_v3":
      _id_8E4B("anim_sprint_attack_3");
      break;
    case "s2_zom_sprinter_stand_attack_1":
      _id_8E4B("anim_stand_attack_1");
      break;
    case "s2_zom_sprinter_stand_attack_2":
      _id_8E4B("anim_stand_attack_2");
      break;
    case "s2_zom_sprinter_stand_attack_3":
      _id_8E4B("anim_stand_attack_3");
      break;
    case "s2_zom_core_idle_twitch_v1":
      _id_8E4B("snarl");
      break;
    default:
      break;
  }
}

_id_8E05(var_0, var_1) {
  switch (var_1) {
    default:
      break;
  }
}

_id_8E04(var_0, var_1) {
  switch (var_1) {
    default:
      break;
  }
}

_id_8E03(var_0, var_1) {
  switch (var_1) {
    default:
      break;
  }
}

_id_8E06(var_0, var_1) {
  switch (var_1) {
    default:
      break;
  }
}

_id_8E02(var_0, var_1) {
  switch (var_1) {
    default:
      break;
  }
}

_id_9916() {
  var_0 = self;
  var_1 = 180;

  for(;;) {
    var_2 = level.players[0];

    if(isDefined(var_2)) {
      var_3 = _func_0E1(var_0.origin, var_2.origin);

      if(var_3 < var_1) {
        _id_0378::_id_8D74("zombie_ignite");
        wait 10;
        _id_0378::_id_8D74("zombie_extinguish");
        return;
      }
    }

    wait 0.1;
  }
}

_id_8E37() {
  if(!level._id_071D._id_A974) {
    return;
  }
  if(!isDefined(level._id_071D._id_ABFB))
    level._id_071D._id_ABFB = ["zmb_spawn_cardboard_pallet_default", "zmb_spawn_const_barrel_default", "zmb_spawn_const_sawhorse_default", "zmb_spawn_const_sign_default", "zmb_spawn_mesh_container_default", "zmb_spawn_chain_default", "zmb_spawn_wood_default", "zmb_spawn_wood_lrg_default", "zmb_spawn_light_lrg_default", "zmb_spawn_light_sml_default", "zmb_spawn_metal_hollow_default"];

  if(_id_0378::_id_8D1B(0.5))
    _id_8E4B("spawn");
  else {
    var_0 = randomint(level._id_071D._id_ABFB.size);
    var_1 = level._id_071D._id_ABFB[var_0];
    _id_0380::_id_2889(var_1, undefined, self.origin);
  }
}

_id_9CC9(var_0) {
  _id_046C::_id_8DA2("trap_spinner_activate", self);
  _id_046C::_id_8DA4("trap_spinner_spin_lp", self, var_0);
}

_id_62D2() {}

_id_3E42() {
  _id_0380::_id_2888("zmb_pickup_general", self);
}

_id_ABA3() {
  if(isDefined(self) && isDefined(self.origin) && _func_344("zmb_bodyfall_hv")) {
    thread _id_046C::_id_8DA0("zmb_falling_zombie_impact", self.origin);
    _id_8E4B("pain");
  } else
    _id_0378::_id_8D14(0, "wtf");
}

_id_ABCE(var_0) {
  waitframe();

  if(!common_scripts\utility::_id_562E(self._id_55CB)) {
    self._id_55CB = 1;
    _id_046C::_id_8DA2("burning_zombie_ignite", self);
    var_1 = 0.25;
    var_2 = 3.0;
    var_3 = "soft";
    var_4 = _id_0380::_id_6846("burning_zombie_lp", undefined, self, var_1);

    if(isDefined(var_0)) {
      wait(var_0);
      _id_0380::_id_6850(var_4, var_2);
      self._id_55CB = 0;
    } else
      self._id_071D._id_4FF5 = var_4;
  }
}

_id_ABA2() {
  if(isDefined(self) && isDefined(self._id_071D._id_4FF5)) {
    var_0 = 3.0;
    _id_0380::_id_6850(self._id_071D._id_4FF5, var_0);
    self._id_55CB = 0;
  }
}

_id_8E21() {
  self endon("disconnect");

  for(;;) {
    self waittill("spawned");
    _id_8E41("Recieved Message:spawened");
    wait 1;

    if(!_func_367()) {
      thread _id_0378::_id_92F3(0.003, 0.01);
      thread _id_0378::_id_1BBD();
      thread _id_0378::_id_1BBE();
      thread _id_0378::_id_1BBF();
      _id_0378::set_expletive_chance(0.4);
      _id_0378::set_max_breath_lev_num(4);
      _id_0378::_id_851F(200);
    }

    _id_0378::_id_8D74("player_spawned");
  }
}

snd_is_level_wave_active() {
  return level._id_071D._id_A974;
}

snd_get_auto_wave_music_enabled() {
  var_0 = self;
  return var_0._id_071D.auto_wave_music_enabled;
}

snd_set_auto_wave_music_enabled(var_0) {
  var_1 = self;
  var_1._id_071D.auto_wave_music_enabled = var_0;
}

_id_8E4D() {
  if(snd_get_auto_wave_music_enabled()) {
    _id_8DCF(_id_8D46());
    var_0 = 5.0;
    var_1 = 10.0;
    _id_8E31(self._id_071D._id_A97B, var_0, var_1);
    _id_8E2F(0.9 * level._id_071D.map_wave_music_master_volume_scalar, 2.0, self);
  }

  if(level._id_7F24 == 0)
    thread _id_8D9F();
}

_id_8E4E() {
  if(snd_get_auto_wave_music_enabled()) {
    var_0 = "stinger_round_end_hit";
    var_1 = 0.0;
    _id_8E31(var_0, var_1);
    _id_8DCF(undefined);
    wait 1;
    _id_AB0D();
    _id_8E2F(1.0, 2.0, self);
  }
}

_id_AB0D() {
  if(isDefined(level._id_071D.start_intermission_music_override)) {
    [[level._id_071D.start_intermission_music_override]]();
    return;
  }

  var_0 = "mus_intermission";
  var_1 = "mus_intermission_long";

  if(_id_0378::_id_8D1B(0.5))
    var_0 = var_1;

  var_2 = 4.0;
  var_3 = 5.0;
  _id_8E31(var_0, var_2, var_3);
}

snd_zmb_set_start_intermission_music_override_callback(var_0) {
  level._id_071D.start_intermission_music_override = var_0;
}

_id_8E1C() {
  self endon("disconnect");

  for(;;) {
    self waittill("enter_last_stand");
    self._id_5BF3 = gettime();
    _id_8E41("Recieved Message:spawened");
    _id_0378::_id_8D74("enter_last_stand");
  }
}

_id_8E20() {
  self endon("disconnect");

  for(;;) {
    self waittill("revive");
    _id_8E41("Recieved Message:spawened");
    var_0 = gettime();

    if(isDefined(self._id_5BEF))
      self._id_32CD = self._id_32CD + int((var_0 - self._id_5BEF._id_5BF4) / 1000);

    self._id_99F8 = self._id_99F8 + self._id_32CD;
    _id_0378::_id_8D74("revive");
  }
}

_id_8E1E() {
  self endon("disconnect");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11);

    if(var_0 > 0) {
      var_0 = clamp(var_0 * 1.5, 0, 100);
      self _meth_85A7("snd_zmb_handle_plr_damage", var_0);
    }
  }
}

_id_8E1F() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");
    _id_8E41("Recieved Message:spawened");
    _id_0378::_id_8D74("death");
    var_0 = level._id_A980 - 1;
    var_1 = self getentitynumber();
    self._id_2AB8 = gettime();

    if(var_0 >= 0 && var_0 < level._id_609D)
      setmatchdata("rounds", var_0, "player_rounds", var_1, "died", 1);

    _id_0378::_id_93E2();

    if(isDefined(self._id_071D._id_3D90))
      _id_0380::_id_6850(self._id_071D._id_3D90);
  }
}

_id_8E1B() {
  self endon("disconnect");

  for(;;) {
    self waittill("end_respawn");
    _id_8E41("Recieved Message:spawened");
    _id_0378::_id_8D74("end_respawn");
  }
}

_id_8E1D() {
  self endon("disconnect");

  for(;;) {
    self waittill("joined_spectators");
    _id_8E41("Recieved Message:spawened");
    _id_0378::_id_8D74("joined_spectators");
  }
}

_id_8E45() {
  if(!isDefined(level._id_071D._id_74F7))
    level._id_071D._id_74F7 = [];

  var_0 = spawnStruct();
  var_1 = _id_0378::_id_8D86();
  var_0._id_2417 = var_1;
  var_0._id_74F3 = self;
  level._id_071D._id_74F7[var_1] = var_0;
  self._id_071D._id_2417 = var_1;
  self._id_071D._id_28BF = [];
  self._id_071D._id_6551 = 0;
  self._id_071D.auto_wave_music_enabled = 1;
}

_id_8E0A(var_0) {
  var_1 = undefined;
  _id_8E07(_func_2A2(var_0));
  var_2 = level._id_071D._id_74F7[var_0];

  if(isDefined(var_2))
    var_1 = var_2._id_74F3;

  return var_1;
}

_id_8E3F(var_0) {
  var_1 = undefined;
  _id_8E07(isDefined(var_0));

  foreach(var_3 in level._id_071D._id_74F7) {
    if(var_3._id_74F3 == var_0) {
      var_1 = var_3._id_2417;
      break;
    }
  }

  return var_1;
}

_id_8E0E() {
  return self._id_071D._id_2417;
}

_id_AC3C() {
  _id_046C::_id_8DA0("zombies_2016_gl_ending_hit");
  _id_8E00("zombies_2016_gl_ending");
}

_id_65F3(var_0, var_1) {
  if(var_1 == 1) {
    wait 4.55;
    level._id_11CB._id_65F4 = _id_0380::_id_2889("zmb_mystery_box_elec", undefined, var_0.origin);
  } else
    _func_352(level._id_11CB._id_65F4);
}

_id_65F5(var_0) {
  _id_0380::_id_2889("interact_mystery_box_open", undefined, var_0.origin);
}

_id_65F2(var_0) {
  _id_0380::_id_2889("interact_mystery_box_close", undefined, var_0.origin);
}

_id_65F0(var_0) {
  if(!isDefined(var_0._id_11C6)) {
    var_0._id_11C6 = _id_0380::_id_6844("zmb_interact_mystery_box_attract", undefined, var_0, 3.0);
    wait 2;
    _id_65EE(var_0);
  }
}

_id_65EF(var_0) {
  if(isDefined(var_0._id_11C6)) {
    _id_0380::_id_6850(var_0._id_11C6, 3.0);
    var_0._id_11C6 = undefined;
  }
}

_id_65F1(var_0) {
  if(!isDefined(var_0._id_11C6))
    _id_65F0(var_0);

  _id_0380::_id_684E(var_0._id_11C6, 1.0, 3.0);
}

_id_65EE(var_0) {
  if(isDefined(var_0._id_11C6))
    _id_0380::_id_684E(var_0._id_11C6, 0.25, 3.0);
}

_id_8E31(var_0, var_1, var_2) {
  var_3 = _id_8E14();
  self _meth_85A7("snd_start_mus", var_0, var_3, var_1, var_2);
}

_id_8E32(var_0) {
  self _meth_85A7("snd_stop_mus", var_0);
}

_id_8E33(var_0) {
  _func_307(level.players, "snd_stop_mus", var_0);
}

_id_8E34(var_0, var_1, var_2, var_3) {
  var_4 = _id_0378::_id_8D49(1.0, var_2);

  if(isDefined(var_1)) {
    var_5 = gettime();
    var_6 = var_1 _id_8E10();

    if(var_5 > var_6 + 4000) {
      var_1 _id_8E46(var_5);
      var_7 = _id_8E15();
      var_4 = var_4 * _id_0378::_id_8D72(var_1._id_071D._id_74FF, var_7);

      if(var_0 != "player_vox_only")
        var_1 _meth_85A7("snd_zmb_play_mus_stinger", var_0, var_4);

      var_1 _id_8E0D(var_0);
      return;
    }
  } else if(var_0 != "player_vox_only")
    _func_307(level.players, "snd_zmb_play_mus_stinger", var_0, var_4);
}

snd_zmb_set_plr_vox_scare_count_max(var_0) {
  self _meth_85A7("snd_zmb_set_plr_vox_scare_count_max", var_0);
}

_id_8E0D(var_0) {
  wait 0.5;
  self _meth_85A7("snd_zmb_plr_stinger_scare_vox", var_0);
}

_id_8E35(var_0, var_1, var_2) {
  thread _id_8E9D(var_0, var_1, var_2);
}

_id_8E9D(var_0, var_1, var_2) {
  var_1 endon("death");
  var_1 endon("disconnect");
  var_2 endon("death");
  var_2 notify("sndx_zmb_play_mus_stinger_when_plr_sees_zmb");
  var_2 endon("sndx_zmb_play_mus_stinger_when_plr_sees_zmb");

  while(isDefined(var_1) && isDefined(var_2)) {
    if(var_1 common_scripts\utility::_id_7237(var_2)) {
      if(!_id_0547::_id_577E(var_1)) {
        var_3 = _func_0E1(var_1.origin, var_2.origin);

        if(var_3 < 180.0)
          _id_8E34(var_0, var_1, 1.0, var_2);
      }

      break;
    }

    waitframe();
  }
}

snd_zmb_set_map_wave_music_master_volume_scalar(var_0) {
  level._id_071D.map_wave_music_master_volume_scalar = var_0;
}

_id_8E30(var_0, var_1, var_2) {
  var_3 = 1.0 * var_0;
  _id_8E2F(var_3, var_1, var_2);
}

_id_8E2F(var_0, var_1, var_2) {
  if(isDefined(var_2))
    self _meth_85A7("snd_set_mus_master_vol", var_0, var_1);
  else
    _func_307(level.players, "snd_set_mus_master_vol", var_0, var_1);
}

_id_8E2C() {
  self endon("disconnect");
  var_0 = 0.5;
  var_1 = -666;
  self _meth_85A7("snd_set_threat_update_period", var_0);

  for(;;) {
    if(_id_8E19()) {
      if(isDefined(self._id_071D._id_93A0))
        self._id_071D._id_74FF = self._id_071D._id_93A0;
      else
        self._id_071D._id_74FF = _id_8E08();
    } else
      self._id_071D._id_74FF = 0;

    if(self._id_071D._id_74FF != var_1) {
      var_1 = self._id_071D._id_74FF;
      self _meth_85A7("snd_update_plr_threat", self._id_071D._id_74FF);
    }

    wait(var_0);
  }
}

_id_8E47(var_0) {
  self._id_071D._id_93A0 = var_0;
}

_id_8E09() {
  self._id_071D._id_93A0 = undefined;
}

_id_8E18() {
  var_0 = [];
  var_1 = self;
  var_2 = _id_8E1A();
  var_3 = var_2.size;
  var_4 = 100000000;

  for(var_5 = 0; var_5 < var_3; var_5++) {
    var_6 = var_2[var_5];

    if(isDefined(var_6.origin) && isDefined(var_6._id_0A4B)) {
      var_7 = _id_8E17(var_6);
      var_8 = spawnStruct();
      var_8._id_AB4D = var_6;
      var_8._id_502A = var_7;
      var_8._id_3018 = distance(var_1.origin, var_6.origin);
      var_8.is_closest = 0;
      var_8._id_1F21 = var_1 common_scripts\utility::_id_7237(var_6);
      var_8.is_passive = var_6 snd_zmb_zom_is_passive();
      var_8._id_28E4 = _func_0E4(var_6 _meth_833D()) * 0.0568182;

      if(var_8._id_1F21 && var_8._id_3018 < var_4) {
        var_8.is_closest = 1;
        var_4 = var_8._id_3018;
      }

      var_0[var_5] = var_8;
    }
  }

  return var_0;
}

_id_8E0B(var_0) {
  var_1 = [];
  var_2 = var_0.size;

  if(var_2 > 0) {
    var_3 = common_scripts\utility::_id_7897(var_0, ::_id_8E29);
    var_4 = 0;

    foreach(var_6 in var_3) {
      if(var_4 >= 5) {
        break;
      }

      var_4++;
      var_1[var_6._id_502A] = var_6;
    }
  }

  return var_1;
}

_id_8E29(var_0, var_1) {
  return var_0._id_3018 <= var_1._id_3018;
}

_id_8E0F() {
  var_0 = self;
  return var_0._id_071D._id_28BF;
}

snd_zmb_plr_is_in_thick_fog() {
  var_0 = common_scripts\utility::_id_562E(self.isinfogzone) && common_scripts\utility::_id_562E(level.island_fog_is_thick);
  return var_0;
}

snd_zmb_zom_is_passive() {
  var_0 = 0;

  if(common_scripts\utility::_id_3798("zombie_passive"))
    var_0 = common_scripts\utility::_id_3794("zombie_passive");

  return var_0;
}

_id_8E2B() {
  self endon("disconnect");

  while(self.health <= 0)
    waitframe();

  self _meth_85A7("snd_update_plr_health", self.health);
  var_0 = 0.1;
  var_1 = self.health;

  for(;;) {
    if(self.health != var_1) {
      var_1 = self.health;
      self _meth_85A7("snd_update_plr_health", self.health);
    }

    wait(var_0);
  }
}

_id_8E08() {
  var_0 = self;
  var_1 = 0;
  var_2 = _id_8E1A();
  var_3 = self.origin;
  var_4 = var_0 snd_zmb_plr_is_in_thick_fog();
  var_5 = 1800;
  var_6 = var_5 * 0.333;
  var_7 = _id_8E13();
  var_8 = _id_8E0E();
  var_9 = gettime();
  var_10 = 60000;
  var_11 = 1.0;

  if(var_4) {
    var_5 = var_6;
    var_11 = 1.2;
  }

  foreach(var_13 in var_2) {
    var_14 = 0;
    var_15 = distance(var_3, var_13.origin);
    var_16 = var_13 snd_zmb_zom_is_passive();
    var_17 = var_13._id_071D._id_0A47;
    var_18 = isDefined(var_13._id_28D2) && var_13._id_28D2 == var_0;

    if(var_4 && var_16)
      continue;
    else if(var_15 < var_5) {
      var_19 = var_13._id_071D._id_99E0[var_8];
      var_20 = isDefined(var_19);
      var_21 = var_0 common_scripts\utility::_id_7237(var_13);

      if(!var_21 && var_20) {
        var_22 = var_9 - var_19;

        if(var_22 < var_10)
          var_14 = 1;
        else
          var_13._id_071D._id_99E0[var_8] = undefined;
      } else if(var_21) {
        var_14 = 1;
        var_13._id_071D._id_99E0[var_8] = var_9;
      }

      if(var_14) {
        if(var_17 == "zombie_assassin" && var_4)
          var_1 = 1.0;
        else {
          var_23 = _id_0378::_id_8D73(var_15, 0, var_5, var_7);
          var_23 = var_23 * var_13._id_071D._id_9979;
          var_23 = var_23 * level._id_071D.global_threat_scalar;
          var_23 = var_23 * var_11;
          var_1 = var_1 + var_23;
        }
      }
    }
  }

  return clamp(var_1, 0, 1);
}

sndx_update_global_threat_scalar(var_0) {
  if(var_0 > 0) {
    level._id_071D.global_threat_scalar = 0.666 + (var_0 - 1) * 0.177822;
    _id_0378::_id_8D64("in_combat: " + var_0);
  } else
    level._id_071D.global_threat_scalar = 0.666;
}

sndx_monitor_num_players_in_combat(var_0) {
  for(;;) {
    level common_scripts\utility::_id_A70A("player_spawned", "player_last_stand", "player_bleedout", "player_revived", "player_disconnected");
    var_1 = 0;
    var_2 = 0;

    foreach(var_4 in level.players) {
      if(maps\mp\_utility::isreallyalive(var_4)) {
        if(_id_0547::_id_577E(var_4)) {
          var_2 = 1;
          continue;
        }

        var_1++;
      }
    }

    if(var_1 == 0 && var_2)
      var_1 = 1;

    level._id_071D.num_players_in_combat = var_1;

    if(isDefined(var_0))
      [[var_0]](var_1);
  }
}

snd_zmb_get_num_players_in_combat() {
  return level._id_071D.num_players_in_combat;
}

_id_8E14(var_0) {
  var_1 = 0;
  var_2 = self;

  if(_func_2A2(var_0)) {
    var_2 = _id_8E0A(var_0);
    _id_8E07(isDefined(var_2));
  }

  if(isDefined(var_2))
    var_1 = var_2._id_071D._id_74FF;

  return var_1;
}

_id_8E13() {
  return level._id_071D._id_725F;
}

_id_8E17(var_0) {
  return var_0._id_071D._id_502A;
}

_id_8E16() {
  return level._id_071D._id_AB8E;
}

_id_8E15() {
  return level._id_071D._id_7500;
}

_id_8E1A() {
  var_0 = [];
  var_1 = maps\mp\agents\_agent_utility::_id_43FD("all");

  foreach(var_3 in var_1) {
    if(isDefined(var_3._id_000A) && var_3._id_000A == level._id_746E) {
      continue;
    }
    var_0[var_0.size] = var_3;
  }

  return var_0;
}

snd_zmb_new_guid() {
  if(!isDefined(level._id_071D.zmb_guid))
    level._id_071D.zmb_guid = 0;

  if(level._id_071D.zmb_guid > 500)
    level._id_071D.zmb_guid = 0;

  level._id_071D.zmb_guid++;
  return level._id_071D.zmb_guid;
}

_id_8E2E(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = self._id_071D._id_0A47;
  var_10 = self.origin;
  var_11 = _id_8E17(self);

  foreach(var_13 in level.players) {
    if(isDefined(var_13.zombie_sighting_times[var_11]))
      var_13.zombie_sighting_times[var_11] = undefined;

    if(isDefined(var_13.amb_zvox_prev_try_times[var_11]))
      var_13.amb_zvox_prev_try_times[var_11] = undefined;

    if(isDefined(var_13.prev_charge_times[var_11]))
      var_13.prev_charge_times[var_11] = undefined;
  }

  if(!((var_9 == "zombie_generic" || var_9 == "zombie_generic2") && _id_0378::_id_8D1B(0.5)))
    _id_8E4B("death", undefined, var_10, var_9);
}

_id_8E48(var_0) {
  level._id_071D._id_AC07 = var_0;
}

_id_8E19() {
  return level._id_071D._id_AC07;
}

_id_8E40() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");
  var_0 = self;
  var_1 = 0.3;
  var_0.zombie_sighting_times = [];
  var_0.amb_zvox_prev_try_times = [];
  var_0.prev_charge_times = [];
  var_2 = 0;
  var_3 = _func_0A4(5000, 10000);
  var_4 = 360;
  var_5 = 180;
  var_0._id_071D.stinger_filter_prev_stinger_time = 0;
  wait(_func_0A3(var_1));

  for(;;) {
    wait(var_1);
    var_6 = var_0 snd_zmb_plr_is_in_thick_fog();
    var_7 = _id_8E18();
    var_8 = undefined;
    var_9 = gettime();

    foreach(var_11 in var_7) {
      var_12 = var_11._id_AB4D;
      var_13 = var_11._id_502A;
      var_14 = var_11._id_3018;
      var_15 = var_11.is_closest;
      var_16 = var_11._id_28E4;
      var_17 = var_0.zombie_sighting_times[var_13];
      var_18 = isDefined(var_17);
      var_19 = var_11._id_1F21;
      var_20 = var_11.is_passive;
      var_21 = isDefined(var_12._id_28D2) && var_12._id_28D2 == var_0;
      var_22 = undefined;
      var_23 = undefined;
      var_24 = 0;

      if(var_6)
        var_4 = var_5;

      if(!var_18 && var_19 && !var_20) {
        var_0.zombie_sighting_times[var_13] = var_9;

        if(var_15 && var_14 < var_4) {
          if(var_14 < var_4 * 0.5) {
            var_25 = "mus_stinger_med";
            var_26 = 0.33;
            var_27 = var_0;

            if(var_14 < var_4 * 0.25) {
              var_25 = "mus_stinger_lrg";
              var_26 = 0.66;
            }

            var_25 = sndx_zmb_choose_stinger_or_player_vox(var_25, var_0, var_9);

            if(!var_6)
              _id_8E34(var_25, var_27, var_26, var_12);
          }

          var_22 = "sneakattack_busted";
        }
      } else if(!var_18 && !var_19 && var_21 && var_14 <= var_4 && !var_20) {
        var_22 = "sneakattack_success";
        var_11._id_1F21 = 1;
        var_0.zombie_sighting_times[var_13] = var_9;
        var_25 = sndx_zmb_choose_stinger_or_player_vox("mus_stinger_lrg", var_0, var_9);
        thread _id_8E35(var_25, var_0, var_12);
      } else if(var_18 && !var_19 && var_9 - var_17 > 60000)
        var_0.zombie_sighting_times[var_13] = undefined;
      else if(var_19)
        var_0.zombie_sighting_times[var_13] = var_9;

      if(!isDefined(var_22)) {
        if(!isDefined(var_0.prev_charge_times[var_13]))
          var_0.prev_charge_times[var_13] = 0;

        if(var_21 && var_14 < 720.0 && var_12 _id_8E28() && var_9 - var_0.prev_charge_times[var_13] > 3000) {
          var_22 = "charge";
          var_0.prev_charge_times[var_13] = var_9;
        } else {
          if(_id_0547::_id_5565(var_12._id_0A4B, "zombie_fireman")) {
            if(_id_0378::_id_8D1B(0.75))
              continue;
          }

          if(!isDefined(var_8))
            var_8 = _id_8E0B(var_7);

          if(isDefined(var_8[var_13])) {
            if(!isDefined(var_0.amb_zvox_prev_try_times[var_13]))
              var_0.amb_zvox_prev_try_times[var_13] = 0;

            var_28 = _id_8E11(var_14);
            var_29 = var_9 - var_0.amb_zvox_prev_try_times[var_13];

            if(var_18 && var_29 > var_28) {
              var_0.amb_zvox_prev_try_times[var_13] = var_9;

              if(_id_0378::_id_8D1B(0.999) && var_9 - var_2 > var_3 && var_21 && !var_20) {
                var_22 = "zde_taunt";
                var_2 = var_9;
                var_3 = _func_0A4(3000, 6000);
                var_23 = "ZOMDEUTSCH!";
              } else {
                var_30 = _func_0A3(1.0);

                if(var_30 < 0.4 && !var_20) {
                  var_31 = _id_8E16();
                  var_32 = _id_0378::_id_8D73(var_14, 0, 1800, var_31);
                  var_22 = _id_8E4A(var_32);
                } else if(var_30 < 0.9)
                  var_22 = "snarl";
                else
                  var_23 = "<NO AMB VOX>";
              }
            }
          }
        }
      }

      if(isDefined(var_22))
        var_0 _id_8E49(var_12, var_22, var_24);
    }
  }
}

sndx_zmb_choose_stinger_or_player_vox(var_0, var_1, var_2) {
  var_3 = var_1 _id_8E14();

  if(var_3 > 0.95 || var_2 - var_1._id_071D.stinger_filter_prev_stinger_time < 12)
    var_0 = "player_vox_only";
  else
    var_1._id_071D.stinger_filter_prev_stinger_time = var_2;

  return var_0;
}

_id_8E11(var_0) {
  var_1 = _id_0378::_id_8D73(var_0, 0, 1800, level._id_071D._id_0CB8);
  var_2 = _func_0A5(var_1 * -0.5, var_1 * 0.5);
  return var_1 + var_2;
}

_id_8E36(var_0, var_1) {
  if(isDefined(var_0))
    _id_8E9E(var_1);
  else
    thread _id_8E9E(var_1);
}

_id_8E9E(var_0) {
  var_0 = _id_0378::_id_8D49(0, var_0);
  var_1 = _id_8E1A();

  foreach(var_3 in var_1) {
    if(isDefined(var_3) && isDefined(var_3._id_071D)) {
      var_3._id_071D._id_9977 = 1.0;
      var_4 = "sneakattack_busted";

      if(!var_0) {
        var_0 = 1;
        var_4 = "sneakattack_success";
      } else if(_id_0378::_id_8D1B(0.5))
        var_4 = "growl_lev4";

      var_3 _id_8E4B(var_4);
    }

    wait 0.3;
  }
}

_id_8E28() {
  return isDefined(self._id_071D._id_5542) && self._id_071D._id_5542;
}

_id_8E2D() {
  self endon("death");
  var_0 = self;
  var_1 = 0.25;
  var_2 = 0;
  var_3 = undefined;
  var_0._id_071D._id_5542 = 0;

  for(;;) {
    wait(var_1);
    var_4 = _func_0E4(var_0 _meth_833D()) * 0.0568182;

    if(var_4 > 5) {
      var_5 = gettime();

      if(!isDefined(var_3))
        var_3 = var_5;
      else if(var_5 - var_3 > 750)
        var_0._id_071D._id_5542 = 1;

      continue;
    }

    var_0._id_071D._id_5542 = 0;
    var_3 = undefined;
  }
}

_id_8E12(var_0, var_1, var_2) {
  var_3 = 1000 + 4000 * _id_0378::_id_8D73(var_1, 0, 1800, var_2) + randomint(1000);
  return var_0 + var_3;
}

_id_8E4A(var_0) {
  var_1 = 4;
  var_2 = 0.25;

  for(var_3 = 1.0 - var_2; var_3 > var_0; var_1 = var_1 - 1)
    var_3 = var_3 - var_2;

  return "growl_lev" + var_1;
}

_id_8E49(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;
  var_6 = _id_0378::_id_8D49(0, var_2);
  var_7 = _id_0378::_id_8D49(self._id_0A4B, var_4);

  if(isDefined(var_0._id_071D) && isDefined(var_0._id_071D._id_0A47))
    var_7 = var_0._id_071D._id_0A47;

  var_1 = _id_8E4C(var_1);

  if(isDefined(var_0) && common_scripts\utility::_id_562E(var_0._id_6701)) {
    return;
  }
  if(isDefined(var_1)) {
    if(var_6)
      var_1 = var_1 + "_2d";

    var_5 _meth_85A7("snd_zmb_handle_vox_request", var_0, var_7, var_1, var_3);
  }
}

_id_8E4B(var_0, var_1, var_2, var_3) {
  if(common_scripts\utility::_id_562E(self._id_6701)) {
    return;
  }
  var_4 = 0;

  foreach(var_6 in level._id_071D.zombie_vox_attack_hit_req_names) {
    if(var_0 == var_6) {
      var_4 = 1;
      break;
    }
  }

  if(var_4) {
    var_8 = gettime();

    if(var_8 - level._id_071D.zombie_vox_attack_hit_prev_time < level._id_071D.zombie_vox_attack_hit_wait_time)
      return;
    else {
      level._id_071D.zombie_vox_attack_hit_prev_time = var_8;
      level._id_071D.zombie_vox_attack_hit_wait_time = _func_0A4(level._id_071D.zombie_vox_attack_hit_wait_time_min, level._id_071D.zombie_vox_attack_hit_wait_time_max);
    }
  }

  var_9 = self;
  var_10 = _id_0378::_id_8D49(self._id_0A4B, var_3);

  if(isDefined(var_9._id_071D) && isDefined(var_9._id_071D._id_0A47))
    var_10 = var_9._id_071D._id_0A47;

  var_0 = _id_8E4C(var_0);

  if(isDefined(var_0) && var_0 == "death") {
    var_11 = distance(level.players[0].origin, var_2);
    var_12 = var_11 / 36;
  }

  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      foreach(var_14 in level.players) {
        var_15 = var_0;

        if(var_14 == var_1)
          var_15 = var_15 + "_2d";

        var_14 _meth_85A7("snd_zmb_handle_vox_request", var_9, var_10, var_15, var_2);
      }
    } else
      _func_307(level.players, "snd_zmb_handle_vox_request", var_9, var_10, var_0, var_2);
  }
}

_id_8E4C(var_0) {
  switch (var_0) {
    case "foo":
      break;
    default:
      break;
  }

  return var_0;
}

_id_8E46(var_0) {
  self._id_071D._id_6599 = var_0;
}

_id_8E10() {
  return self._id_071D._id_6599;
}

_id_70C3(var_0) {}

_id_93BD(var_0) {
  if(isDefined(var_0._id_8E52)) {
    var_1 = 3;
    var_2 = var_0._id_8E52;
    _id_0380::_stoplocalsound(var_2, var_1);
    var_0._id_8E52 = undefined;
  }
}

_id_70C4(var_0) {
  var_1 = 0;
  var_2 = 1.0;
  var_3 = undefined;
  _id_0380::_id_2889("tf_bird_retreat", var_3, var_0._id_78CB.origin, var_1, var_2);
}

_id_35AE() {
  _id_0380::_id_2888("perk_electric_cherry", self);
}

_id_A1D6() {
  var_0 = _id_0380::_id_288B("zmb_armor_machine_use", undefined, self);
  _id_0378::_id_8D14(var_0);
}

_id_94BC() {
  level._id_11CB._id_94BC = _id_0380::_id_288B("zmb_ablty_stun_burst_use", undefined, self);
  _id_0378::_id_8D14(level._id_11CB._id_94BC);
}

_id_94B8() {
  var_0 = self;
  level._id_11CB._id_94B6 = _id_0380::_id_288E("zmb_wonder_weapon_electrocute_lp", undefined, var_0, 0.25, 1, 0.25, "aud_stop_stun_lp");
  _id_0378::_id_8D14(level._id_11CB._id_94B6);
}

_id_94B7() {
  var_0 = self;
  var_0 notify("aud_stop_stun_lp");
  level._id_11CB._id_94B6 = undefined;
  level._id_11CB._id_94B5 = _id_0380::_id_288B("zmb_wonder_weapon_electrocute_end", undefined, var_0);
  _id_0378::_id_8D14(level._id_11CB._id_94B5);
}

_id_5F5B() {
  level._id_11CB._id_5F5B = _id_0380::_id_288B("zmb_ablty_mad_minute_use", undefined, self);
  _id_0378::_id_8D14(level._id_11CB._id_5F5B);
}

_id_983A() {
  level._id_11CB._id_983A = _id_0380::_id_288B("zmb_ablty_taunt_use", undefined, self);
  _id_0378::_id_8D14(level._id_11CB._id_983A);
}

_id_1EBA() {
  level._id_11CB._id_1EBA = _id_0380::_id_288B("zmb_ablty_camo_use", undefined, self);
  _id_0378::_id_8D14(level._id_11CB._id_1EBA);
}

assassin_use_camoflage() {
  var_0 = self;
  _id_0380::_id_288B("zmb_asn_ablty_camo_use", undefined, self);
}

strt_asn_camo_blur(var_0) {
  var_1 = self;
  var_1 _meth_8626("zmb_blurry_vision");
  var_1._id_071D.blurry_vision_snd = _id_0380::_id_6840("zmb_blurry_vision", var_1, 0.2);
}

stp_asn_camo_blur() {
  var_0 = self;
  var_0 _meth_8627("zmb_blurry_vision");
  _id_0380::_id_6850(var_0._id_071D.blurry_vision_snd, 2.5);
}

assassin_use_shell_shock() {
  var_0 = self;
  _id_0380::_id_288B("zmb_asn_ablty_stun_burst_use", undefined, self);
}

assassin_use_taunt() {
  var_0 = self;
  _id_0380::_id_288B("zmb_asn_ablty_taunt_use", undefined, self);
}

_id_9D33() {
  var_0 = self;

  if(!isDefined(level._id_11CB._id_9D36)) {
    level._id_11CB._id_9D36 = _id_0380::_id_288B("zmb_treasure_timer", undefined, var_0);
    _id_0378::_id_8D14(level._id_11CB._id_9D36);
    _id_0380::_id_288F(level._id_11CB._id_9D36, var_0, "treasurer_timer_done");
  }

  var_0 waittill("treasurer_timer_done");
  level._id_11CB._id_9D36 = undefined;
}

_id_9D22() {
  var_0 = self;
  level._id_11CB._id_9A0D = _id_0380::_id_288B("zmb_treasure_fuse", undefined, var_0);
  _id_0378::_id_8D14(level._id_11CB._id_9A0D);
}

_id_9D21() {
  var_0 = self;
  _id_0380::_stoplocalsound(level._id_11CB._id_9D36);
  level._id_11CB._id_9D36 = undefined;
}

_id_AB0A(var_0) {
  _id_0380::_id_2889("zmb_points_pickup", undefined, var_0);
}

_id_AB0B(var_0) {
  _id_0380::_id_2889("zmb_points_share", undefined, var_0);
}

_id_AB0C() {
  _id_0380::_id_2888("zmb_ravens_key_pickup", self);
}

zmb_ballistic_aura() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  var_1 = self.origin;
  _id_0380::_id_288B("zmb_ballistic_aura_start", undefined, var_0);
  var_2 = _id_0380::_id_6844("zmb_ballistic_aura_lp", undefined, var_0, 4.0);
  level waittill("aud_stop_ballistic_aura_snd");

  if(isDefined(var_2)) {
    _id_0380::_id_6850(var_2);
    _id_0380::_id_2889("zmb_ballistic_aura_stop", undefined, var_1);
  }
}

_id_3D25(var_0) {
  _id_3D03("zmb_flamethrower_start", undefined, self, 0, 1, var_0);
  var_1 = _id_0380::_id_684A("zmb_flamethrower_lp", undefined, self, var_0, 0, 1);
  self._id_071D._id_3D19 = var_1;
  thread _id_3D1C(var_0, var_1);
}

_id_3D1C(var_0, var_1) {
  self endon("stop_flame_sfx");
  self waittill("death");
  _id_3D26(var_0, var_1);
}

_id_3D26(var_0, var_1) {
  if(isDefined(self._id_071D) && isDefined(self._id_071D._id_3D19)) {
    _id_0380::_id_6850(self._id_071D._id_3D19, 1);
    self._id_071D._id_3D19 = undefined;
    _id_3D03("zmb_flamethrower_stop", undefined, self, 0, 1, var_0);
  } else if(isDefined(var_1))
    _id_0380::_id_6850(var_1, 1);

  self notify("stop_flame_sfx");
}

_id_3D03(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = undefined;

  if(isDefined(var_2))
    var_6 = _func_351(var_0, var_2, undefined, undefined, var_5, "hard", var_3, undefined, var_4, undefined, var_1, undefined);

  _id_0380::_id_0787(isDefined(var_6), "Call to csnd failed for alias: " + var_0);
  return var_6;
}

_id_9FE4() {
  _id_0380::_id_6846("zmb_uber_battery_lp", undefined, self, 0.5, 1.0, 0.5);
}

_id_98F1(var_0) {
  _id_0380::_id_2889("zmb_tesla_hc_energy_lamp_destruct", undefined, var_0);
}

_id_98F3(var_0) {
  _id_98F2();
  level._id_071D._id_98F4 = _id_0380::_id_6842("zmb_tesla_hc_energy_lamp_lp", undefined, var_0);
}

_id_98F2() {
  if(isDefined(level._id_071D._id_98F4))
    _id_0380::_id_6850(level._id_071D._id_98F4, 0.1);
}

_id_AA91() {
  var_0 = self;
  _id_0380::_id_6842("mp_wpn_betty_triggered", undefined, var_0.origin);
}

_id_AA90() {}

_id_AA8F() {
  var_0 = self;
  _id_0380::_id_6842("mp_wpn_betty_exp", undefined, var_0.origin);
}

_id_5872() {
  var_0 = self;
  var_1 = _id_0380::_id_2889("zmb_jack_box_land", undefined, var_0.origin);
  _id_0378::_id_8D14(var_1);
  var_2 = _id_0380::_id_2889("zmb_jack_box_idle", undefined, var_0.origin);
  _id_0378::_id_8D14(var_2);
}

_id_5873() {
  var_0 = self;
  var_1 = _id_0380::_id_2889("zmb_jack_box_pop_up", undefined, var_0.origin);
  _id_0378::_id_8D14(var_1);
  wait 0.25;
  var_2 = _id_0380::_id_2889("zmb_jack_box_fuse", undefined, var_0.origin);
  _id_0378::_id_8D14(var_2);
}

_id_5871() {
  var_0 = self;
  var_1 = _id_0380::_id_2889("wpn_grenade_exp", undefined, var_0.origin);
  _id_0378::_id_8D14(var_1);
}

_id_1CB9() {
  _func_307(level.players, "snd_brute_defeated");
}

ripsaw_spine_cut() {
  wait 1.0;
  _id_0380::_id_288B("zmb_spine_cut", self, self);
}

ripsaw_fatal_melee() {
  if(common_scripts\utility::_id_562E(self._id_165B) || self _meth_8343())
    _id_0380::_id_288B("wpn_ripsaw_bayonet_charge_hit", undefined, self);
  else
    _id_0380::_id_288B("wpn_ripsaw_jab_impact", undefined, self);
}

ripsaw_start_spinning() {
  _id_0380::_id_6844("wpn_ripsaw_spin", self, self);
  var_0 = _id_0380::_id_6844("wpn_ripsaw_spin_loop", self, self);
  _id_0380::_id_684F(var_0, 0.5, "stop_ripsaw_idle_loop");
}

ripsaw_stop_spinning() {
  level notify("stop_ripsaw_idle_loop");
}

wunderbuss_bolt_charge_beam(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  var_3 = 0;
  var_4 = 1;
  _id_0380::_id_288E("wpn_wunderbuss_charge_beam", undefined, var_2, 0, var_4, 1.0, "aud_stop_beam_charge");
  var_2 _meth_82B1(var_1, 0.9);
  self waittill("aud_stop_beam_charge");
  var_2 delete();
}

wunderbuss_charge_beam_end() {
  _id_0380::_id_288B("wpn_wunderbuss_charge_beam_end", undefined, self);
}

zmb_bat_melee_hit_wooden(var_0) {
  var_1 = self;

  if(isDefined(var_0.delaysec))
    wait(var_0.delaysec * 0.5);

  foreach(var_3 in level.players) {
    if(var_3 == var_0.player) {
      _id_0380::_id_2889("zmb_bat_melee_hit_wooden", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_bat_melee_hit_wooden_npc", undefined, var_0._id_ABE6, undefined, 0.5);
  }
}

zmb_bat_melee_hit_metal(var_0) {
  if(isDefined(var_0.delaysec))
    wait(var_0.delaysec * 0.5);

  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_bat_melee_hit_metal", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_bat_melee_hit_metal", undefined, var_0._id_ABE6, undefined, 0.5);
  }
}

zmb_hc_bat_aoe_fx(var_0, var_1) {
  var_2 = self;

  foreach(var_4 in level.players) {
    if(var_4 == var_2) {
      _id_0380::_id_2889("zmb_hc_bat_aoe_fx", undefined, var_0.origin);
      continue;
    }

    _id_0380::_id_2889("zmb_hc_bat_aoe_fx", undefined, var_0.origin, undefined, 0.5);
  }
}

zmb_sword_melee_hit(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_barbarosa_swrd_hit", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_barbarosa_swrd_hit", undefined, var_0._id_ABE6, undefined, 0.5);
  }
}

zmb_sword_melee_hit_delayed(var_0) {
  var_1 = self;

  foreach(var_3 in level.players) {
    if(var_3 == var_1) {
      _id_0380::_id_2889("zmb_barbarosa_swrd_hit", undefined, var_0);
      continue;
    }

    _id_0380::_id_2889("zmb_barbarosa_swrd_hit", undefined, var_0, undefined, 0.5);
  }
}

zmb_sword_aoe(var_0) {
  var_1 = self;

  foreach(var_3 in level.players) {
    if(var_3 == var_1) {
      _id_0380::_id_2889("zmb_barbarosa_swrd_aoe", undefined, var_0);
      continue;
    }

    _id_0380::_id_2889("zmb_barbarosa_swrd_aoe", undefined, var_0, undefined, 0.5);
  }
}

zmb_knife_melee_hit(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_trenchknife_hit", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_trenchknife_hit", undefined, var_0._id_ABE6, undefined, 1);
  }
}

zmb_knife_finisher_effects() {
  var_0 = self;
  _id_0380::_id_288B("zmb_trenchknife_alt_hit_hc", undefined, var_0);
  wait 0.5;
  _id_0380::_id_288B("zmb_trenchknife_armor_gain", undefined, var_0);
}

zmb_axe_melee_hit(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_axe_hit", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_axe_hit", undefined, var_0._id_ABE6, undefined, 1);
  }
}

zmb_axe_melee_alt_hit(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_axe_hit_alt_hit", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_axe_hit_alt_hit", undefined, var_0._id_ABE6, undefined, 1);
  }
}

zmb_axe_hc_melee_hit(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_axe_hc_hit", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_axe_hc_hit", undefined, var_0._id_ABE6, undefined, 1);
  }
}

zmb_axe_hc_melee_alt_hit(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_axe_hit_alt_hit", undefined, var_0._id_ABE6);
      _id_0380::_id_2889("zmb_axe_hit_alt_hit_hc", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_axe_hit_alt_hit", undefined, var_0._id_ABE6, undefined, 1);
    _id_0380::_id_2889("zmb_axe_hit_alt_hit_hc", undefined, var_0._id_ABE6, undefined, 1);
  }
}

_id_AA59() {
  var_0 = "ww_electrocute_end" + self getentitynumber();
  level._id_11CB._id_AAC4 = level _id_0380::_id_6847("zmb_wonder_weapon_electrocute_lp", undefined, self, 0.25, undefined, 0.25, level, var_0);
}

wonder_weapon_electrocute_end() {
  var_0 = "ww_electrocute_end" + self getentitynumber();
  level notify(var_0);
}

_id_6401() {
  var_0 = _id_0380::_id_6846("zmb_wonder_weapon_proj_moon_lp", undefined, self, 0.25);
}

_id_6400() {
  var_0 = _id_0380::_id_2889("zmb_wonder_weapon_proj_moon_end", undefined, self.origin);
}

_id_9433() {
  var_0 = _id_0380::_id_6846("zmb_wonder_weapon_storm_proj_lp", undefined, self, 0.25);
}

_id_9432() {
  var_0 = _id_0380::_id_2889("zmb_wonder_weapon_storm_proj_end", undefined, self.origin);
}

_id_AAC9() {
  if(!isDefined(level._id_11CB._id_AAC9)) {
    level._id_11CB._id_AAC9 = _id_0380::_id_2889("zmb_wonder_weapon_proj_zap", undefined, self.origin);
    wait 1;
    level._id_11CB._id_AAC9 = undefined;
  }
}

_id_AAC2() {
  level._id_11CB._id_17F1 = _id_0380::_id_2889("zmb_ww_projectile_blood_explode", undefined, self.origin);
}

_id_AAC3() {
  level._id_11CB._id_AAC3 = _id_0380::_id_2889("zmb_ww_projectile_raven_explode", undefined, self.origin);
}

zmb_siz_trans_fx_burst(var_0) {
  _id_0380::_id_2889("zmb_siz_trans_fx_burst", undefined, var_0);
}

zmb_uberschnell_pickup() {
  if(!isDefined(self)) {
    return;
  }
  _id_0380::_id_288B("zmb_uberschnell_pickup", undefined, self);
}

pap_wpn_charlton_vortex() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  _id_0380::_id_288E("zmb_wpn_charlton_vortex", undefined, var_0, 0.0, 1.0, 1.5, "vortex_end");
}

pap_wpn_crossbow_cricket_shot() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  _id_0380::_id_288B("zmb_wpn_crossbow_cricket_shot", undefined, var_0);
}

pap_wpn_crossbow_cricket_explo() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;
  _id_0380::_id_288B("zmb_wpn_crossbow_cricket_explo", undefined, var_0);
}

pap_wpn_emp44_bomb_reload(var_0, var_1) {
  switch (var_0) {
    case "spawn":
      var_1.spawn_lp = _id_0380::_id_6846("zmb_wpn_emp44_spawn_bomb_lp", undefined, var_1, 0.2, undefined, 0.75);
      break;
    case "activate":
      var_1.activate_strt_snd = _id_0380::_id_6844("zmb_wpn_emp44_bomb_start", undefined, var_1);
      var_1.activate_lp_snd = _id_0380::_id_6846("zmb_wpn_emp44_bomb_activated_lp", undefined, var_1, 0.2, undefined, 0.5);
      break;
    case "explode":
      var_1.activate_end_snd = _id_0380::_id_6844("zmb_wpn_emp44_bomb_end", undefined, var_1);
      var_1.boom_snd = _id_0380::_id_6844("zmb_wpn_emp44_bomb_detonate", undefined, var_1);
    default:
      break;
  }
}

pap_wpn_sdk_shottysnipe_fire(var_0) {
  if(!isDefined(var_0)) {
    return;
  }
  _id_0380::_id_2889("zmb_wpn_sdk_pap_add", undefined, var_0);
}

_id_8E41(var_0) {}

_id_8E07(var_0, var_1) {}