/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: soundscripts\_snd_common_zmb_dlc3.gsc
*************************************************/

snd_zmb_init_dlc3() {
  level snd_zmb_register_messages_dlc3();
  level _id_0366::snd_set_round_countdown_aliases("dlc3_round_countdown", "dlc3_round_countdown_end");
}

snd_zmb_register_messages_dlc3() {
  _id_0378::_id_8DC7("dlc3_barbarosa_swrd_knockback", ::dlc3_barbarosa_swrd_knockback);
  _id_0378::_id_8DC7("dlc3_barbarosa_sword_empowered", ::dlc3_barbarosa_sword_empowered);
  _id_0378::_id_8DC7("dlc3_barbarosa_sword_stun", ::dlc3_barbarosa_sword_stun);
  _id_0378::_id_8DC7("dlc3_geist_bomb_activate", ::dlc3_geist_bomb_activate);
  _id_0378::_id_8DC7("dlc3_giest_bomb_revive", ::dlc3_giest_bomb_revive);
  _id_0378::_id_8DC7("dlc3_giest_bomb_arm", ::dlc3_giest_bomb_arm);
  _id_0378::_id_8DC7("dlc3_geist_bomb_detonate", ::dlc3_geist_bomb_detonate);
  _id_0378::_id_8DC7("ks_carepackage_flyby", ::dlc3_carepackage_flyby);
  _id_0378::_id_8DC7("ks_emergency_carepackage", ::dlc3_emergency_airdrop);
  _id_0378::_id_8DC7("ks_carepackage_parachute", ::dlc3_carepackage_parachute);
  _id_0378::_id_8DC7("ks_carepackage_firstImpact", ::dlc3_carepackage_firstimpact);
  _id_0378::_id_8DC7("dlc3_player_repair_start", ::dlc3_player_repair_start);
  _id_0378::_id_8DC7("dlc3_player_repair_stop", ::dlc3_player_repair_stop);
  _id_0378::_id_8DC7("dlc3_start_escape_music", ::dlc3_start_escape_music);
  _id_0378::_id_8DC7("dlc3_stop_escape_music", ::dlc3_stop_escape_music);
  _id_0378::_id_8DC7("dlc3_fireman_enable_shield", ::dlc3_fireman_enable_shield);
  _id_0378::_id_8DC7("dlc3_fireman_disable_shield", ::dlc3_fireman_disable_shield);
  _id_0378::_id_8DC7("dlc3_magic_poof", ::dlc3_magic_poof);
  _id_0378::_id_8DC7("dlc3_altered_state_fade", ::dlc3_altered_state_fade);
  _id_0378::_id_8DC7("dlc3_altered_state_apply", ::dlc3_altered_state_apply);
  _id_0378::_id_8DC7("dlc3_bob_engine", ::dlc3_bob_engine);
  _id_0378::_id_8DC7("dlc3_bob_smoke_attack_strt", ::dlc3_bob_smoke_attack_strt);
  _id_0378::_id_8DC7("dlc3_bob_smoke_attack_loop", ::dlc3_bob_smoke_attack_loop);
  _id_0378::_id_8DC7("dlc3_bob_stab_leg", ::dlc3_bob_stab_leg);
  _id_0378::_id_8DC7("dlc3_bob_shoot_gun", ::dlc3_bob_shoot_gun);
  _id_0378::_id_8DC7("dlc3_bob_throw_grenade", ::dlc3_bob_throw_grenade);
  _id_0378::_id_8DC7("dlc3_guardian_drain_plate_vox", ::dlc3_guardian_drain_plate_vox);
  _id_0378::_id_8DC7("dlc3_guardian_drain_plate_vox_stop", ::dlc3_guardian_drain_plate_vox_stop);
  _id_0378::_id_8DC7("dlc3_guardian_smash_feast_zed", ::dlc3_guardian_smash_feast_zed);
  _id_0378::_id_8DC7("dlc3_guardian_pulse", ::dlc3_guardian_pulse);
  _id_0378::_id_8DC7("dlc3_guardian_drain_success", ::dlc3_guardian_drain_success);
  _id_0378::_id_8DC7("dlc3_guardian_drain_fail", ::dlc3_guardian_drain_fail);
  _id_0378::_id_8DC7("dlc3_zmb_redskull_pu", ::dlc3_zmb_redskull_pu);
  _id_0378::_id_8DC7("dlc3_redskull_accept", ::dlc3_redskull_accept);
  _id_0378::_id_8DC7("dlc3_rune_jolt_absorb", ::dlc3_rune_jolt_absorb);
}

dlc3_barbarosa_swrd_knockback() {
  var_0 = self;
  wait 0.4;
  _id_0380::_id_288B("zmb_barb_sword_knockback_swetener", undefined, var_0);
}

dlc3_barbarosa_sword_empowered() {
  var_0 = self;
  var_0.empowered_lp = _id_0380::_id_6846("zmb_barb_sword_empower_loop", undefined, var_0, 0.1, undefined, 0.1);
}

dlc3_barbarosa_sword_stun(var_0) {
  var_1 = self;

  switch (var_0) {
    case "stun_on":
      var_1.stun_lp = _id_0380::_id_6844("zmb_barb_sword_stun_lp", undefined, var_1, 0.1);
      break;
    case "stun_off":
      _id_0380::_id_6850(var_1.stun_lp, 0.4);
      break;
  }
}

dlc3_geist_bomb_activate(var_0) {
  var_0.geist_bomb_lp = _id_0380::_id_6846("zmb_barb_sword_orb_loop", undefined, var_0._id_8203, 0.1, undefined, 0.5);
}

dlc3_giest_bomb_revive(var_0, var_1) {
  var_0 endon("death");
  var_0 endon("disconnect");
  _id_0380::_id_6846("zmb_barb_sword_revive_loop", undefined, var_1, 0.1, undefined, 0.3);
  var_0 waittill("revive");
  _id_0380::_id_288B("zmb_barb_sword_revive_oneshot", undefined, var_0);
}

dlc3_giest_bomb_arm(var_0) {
  var_0.giest_bomb_armed_strt = _id_0380::_id_6844("zmb_geistbomb_strt", undefined, var_0._id_8203);
  var_0.giest_bomb_armed_lp = _id_0380::_id_6844("zmb_geistbomb_activated_lp", undefined, var_0._id_8203, 0.1);
  var_0 common_scripts\utility::_id_A70A("geist_bomb_cleanup", "geist_bomb_end_priming");
  _id_0380::_id_6850(var_0.giest_bomb_armed_lp, 0.3);
  var_0.giest_bomb_armed_end = _id_0380::_id_6844("zmb_geistbomb_end", undefined, var_0._id_8203);
}

dlc3_geist_bomb_detonate(var_0) {
  var_0.giest_bomb_detonate = _id_0380::_id_288B("zmb_geistbomb_detonate_boom", undefined, var_0._id_8203);
  var_0.geist_bomb_detonate_lp = _id_0380::_id_6844("zmb_geistbomb_detonate_warble_lp", undefined, var_0._id_8203, 0.1);
  var_0 waittill("geist_bomb_detonate_end");
  _id_0380::_id_6850(var_0.geist_bomb_detonate_lp, 1.5);
  wait 1;
  _id_0380::_id_288B("zmb_geistbomb_detonate_end", undefined, var_0._id_8203);
}

dlc3_carepackage_flyby() {
  var_0 = self;
  _id_0380::_id_6844("ks_plane_by_supply_drop", undefined, var_0);
}

dlc3_emergency_airdrop() {
  var_0 = self;
  _id_0380::_id_6846("ks_plane_by_emergency_drop", undefined, var_0);
}

dlc3_carepackage_parachute() {
  var_0 = self;
  var_1 = 0.5;
  var_2 = 0.5;
  var_3 = _id_0380::_id_6844("ks_crpkg_parachute_lp", undefined, var_0, var_1);
  var_0 waittill("detach");
  _id_0380::_id_6850(var_3, var_2);
  _id_0380::_id_6842("ks_crpkg_parachute_release", undefined, var_0.origin);
}

dlc3_carepackage_firstimpact() {
  var_0 = self;

  if(self.team == "allies") {
    _id_0380::_id_6844("mp_ks_crpkg_imp_allies", undefined, self);
  } else {
    _id_0380::_id_6844("mp_ks_crpkg_imp_axis", undefined, self);
  }
}

dlc3_player_repair_start(var_0, var_1) {
  var_2 = self;
  wait 1.2;

  if(var_0 == "war_wrench_assemble_mp") {
    level._id_11CB.repair_wrench_snd = _id_0380::_id_2889("buildable_barbed_wire_wrench", undefined, var_1.origin);
  }
}

dlc3_player_repair_stop(var_0) {
  if(isDefined(level._id_11CB.repair_wrench_snd)) {
    _id_0380::_stoplocalsound(level._id_11CB.repair_wrench_snd, 0.1);
    level._id_11CB.repair_wrench_snd = undefined;
  }
}

dlc3_start_escape_music() {
  if(!isDefined(level._id_11CB.escape_music_playing)) {
    level._id_11CB.escape_music_playing = 1;

    foreach(var_1 in level.players) {
      var_1 _id_0366::snd_set_auto_wave_music_enabled(0);
      var_1 notify("kill_dlc3_wave_mus_switcher");
      var_1 _id_0366::_id_8E31("escape_01", 0.25, 3);
    }
  }
}

dlc3_stop_escape_music(var_0) {
  var_1 = _id_0378::_id_8D49(0, var_0);

  if(isDefined(level._id_11CB.escape_music_playing)) {
    var_2 = 10;

    foreach(var_4 in level.players) {
      var_4 thread dlc3_play_escape_complete_stinger(var_2);
    }

    wait(var_2);
    wait(var_1);
    var_6 = 10;

    foreach(var_4 in level.players) {
      var_4 _id_0366::_id_8E32(var_6);
    }

    foreach(var_4 in level.players) {
      var_4 _id_0366::snd_set_auto_wave_music_enabled(1);
      var_4 thread dlc3_wave_mus_switcher();
    }

    level._id_11CB.escape_music_playing = 0;
  }
}

dlc3_play_escape_complete_stinger(var_0) {
  if(!isDefined(self.playing_escape_complete_stinger)) {
    self.playing_escape_complete_stinger = 1;
    self clientaddsoundsubmix("dlc3_escape_complete_stinger", 4.0);
    _id_0380::_id_2888("dlc3_escape_complete_stinger_01", self);
    wait(var_0);
    self clientclearsoundsubmix("dlc3_escape_complete_stinger", 4.0);
    self.playing_escape_complete_stinger = undefined;
  }
}

dlc3_fireman_enable_shield(var_0) {
  if(isDefined(var_0.aud_fireman_shield_loop)) {
    _id_0380::_id_6850(var_0.aud_fireman_shield_loop, 2.0);
    waitframe();
  }

  _id_0380::_id_6842("dlc3_fireman_shield_begin", undefined, var_0.origin);
  var_0.aud_fireman_shield_loop = _id_0380::_id_6846("dlc3_fireman_shield_lp", undefined, var_0, 0.5, 1.0, 2.0);
}

dlc3_fireman_disable_shield(var_0) {
  if(isDefined(var_0)) {
    _id_0380::_id_6850(var_0.aud_fireman_shield_loop, 2.0);
    var_0.aud_fireman_shield_loop = undefined;
    _id_0380::_id_6842("dlc3_fireman_shield_end", undefined, var_0.origin);
  }
}

dlc3_magic_poof(var_0) {
  _id_0380::_id_2889("dlc3_magic_poof", undefined, var_0);
}

dlc3_altered_state_init() {
  self clientaddsoundsubmix("dlc3_pre_altered_state");
}

dlc3_altered_state_fade() {
  var_0 = gettime();

  if(!isDefined(self._id_071D.altered_state_fade_start_time) || var_0 - self._id_071D.altered_state_fade_start_time > 2000.0) {
    var_1 = _id_0380::_id_2888("dlc3_altered_state_fade", self);
    self._id_071D.altered_state_fade_start_time = var_0;
  }
}

dlc3_altered_state_apply(var_0, var_1) {
  if(isDefined(self._id_11CB.dlc3_altered_state_submix)) {
    dlc3_altered_state_clear();
  }

  if(isDefined(self._id_11CB.in_the_void)) {
    return;
  }
  var_0 = _id_0378::_id_8D49(1, var_0);

  if(var_0 == 1 || var_0 == 2 || var_0 == 3) {
    if(var_0 == 1) {
      self clientclearsoundsubmix("dlc3_pre_altered_state", 1.0);
      self notify("kill_dlc3_wave_mus_switcher");
      self clientclearsoundsubmix("dlc3_plr_idle_mus_fade", 1.0);
      _id_0366::snd_set_auto_wave_music_enabled(0);
      _id_0366::_id_8E47(0);
    } else if(var_0 == 2)
      self._id_071D.altered_state_sfx_loop = _id_0380::_id_6840("dlc3_altered_state_02", self);
    else if(var_0 == 3) {
      _id_0380::_id_6850(self._id_071D.altered_state_sfx_loop, 3.0);
      self._id_071D.altered_state_sfx_loop = _id_0380::_id_6840("dlc3_altered_state_03", self);
    }

    _id_0366::_id_8E32(4);
    var_2 = ["zmb_mus_creepy_amb_lp_01", "zmb_mus_creepy_amb_lp_02", "zmb_mus_creepy_amb_lp_03", "zmb_mus_creepy_amb_lp_04", "zmb_mus_creepy_amb_lp_05", "zmb_mus_creepy_amb_lp_06"];
    _id_0366::_id_8E31(var_2[randomint(var_2.size)], 4);
    var_3 = "dlc3_altered_state" + var_0;
    self clientaddsoundsubmix(var_3, 3.0);
    self._id_11CB.dlc3_altered_state_submix = var_3;
    var_1 = _id_0378::_id_8D49("altered_state_end", var_1);
    self waittill(var_1);
    dlc3_altered_state_clear();
  }
}

dlc3_altered_state_clear() {
  if(_isstring(self._id_11CB.dlc3_altered_state_submix)) {
    self clientclearsoundsubmix(self._id_11CB.dlc3_altered_state_submix, 3.0);

    if(self._id_11CB.dlc3_altered_state_submix == "dlc3_altered_state3") {
      _id_0366::snd_set_auto_wave_music_enabled(1);
      _id_0366::_id_8E09();
      thread dlc3_wave_mus_switcher();
    }

    self._id_11CB.dlc3_altered_state_submix = undefined;
    _id_0380::_id_6850(self._id_071D.altered_state_sfx_loop, 3.0);
  }
}

dlc3_bob_engine(var_0) {
  var_1 = self;
  thread dlc_handle_bob_spawned_music();

  switch (var_0) {
    case "bob_punch":
      level._id_11CB.bob_engine_loop = _id_0380::_id_6844("zmb_berl_bob_engine_lp", undefined, var_1, 0.2);
      level._id_11CB.bob_engine_loop_hi = _id_0380::_id_6844("zmb_berl_bob_engine_hi_lp", undefined, var_1, 0.2);
      level._id_11CB.curr_phase = "bob_punch";
      break;
    case "bob_smoke":
      wait 1;
      _id_0380::_id_6850(level._id_11CB.bob_engine_loop, 0.5);
      _id_0380::_id_6850(level._id_11CB.bob_engine_loop_hi, 0.5);
      level._id_11CB.bob_engine_phase3_loop = _id_0380::_id_6844("zmb_berl_bob_engine_phase_3_lp", undefined, var_1, 0.2);
      level._id_11CB.bob_engine_phase3_loop_hi = _id_0380::_id_6844("zmb_berl_bob_engine_phase_3_hi_lp", undefined, var_1, 0.2);
      level._id_11CB.bob_engine_phase3_loop_dmgd = _id_0380::_id_6844("zmb_berl_bob_engine_phase_3_dmged_lp", undefined, var_1, 0.2);
      level._id_11CB.curr_phase = "bob_smoke";
      break;
    case "bob_killed":
      _id_0380::_id_6850(level._id_11CB.bob_engine_loop, 0.5);
      _id_0380::_id_6850(level._id_11CB.bob_engine_loop_hi, 0.5);
      wait 1.5;
      _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop, 0.65, 0.25);
      _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_hi, 0.65, 0.25);
      _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_dmgd, 0.65, 0.25);
      wait 11;
      _id_0380::_id_6850(level._id_11CB.bob_engine_phase3_loop, 0.5);
      _id_0380::_id_6850(level._id_11CB.bob_engine_phase3_loop_hi, 0.5);
      _id_0380::_id_6850(level._id_11CB.bob_engine_phase3_loop_dmgd, 0.5);
      _id_0380::_id_288B("zmb_berl_bob_engine_turn_off", undefined, var_1);
      wait 2;
      level._id_11CB.bob_engine_loop = undefined;
      level._id_11CB.bob_engine_loop_hi = undefined;
      level._id_11CB.bob_engine_phase3_loop = undefined;
      level._id_11CB.bob_engine_phase3_loop_hi = undefined;
      level._id_11CB.bob_engine_phase3_loop_dmgd = undefined;
      thread dlc_handle_bob_killed_music();
      break;
    case "bob_engine_rev":
      if(level._id_11CB.curr_phase == "bob_punch") {
        _id_0380::_id_684E(level._id_11CB.bob_engine_loop, 0, 0.7);
        _id_0380::_id_684E(level._id_11CB.bob_engine_loop_hi, 0, 0.7);
        _id_0380::_id_288B("zmb_berl_bob_engine_rev", undefined, var_1);
        wait 1.75;
        _id_0380::_id_684E(level._id_11CB.bob_engine_loop, 1, 1);
        _id_0380::_id_684E(level._id_11CB.bob_engine_loop_hi, 1, 1);
      }

      if(level._id_11CB.curr_phase == "bob_smoke") {
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop, 0, 0.7);
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_hi, 0, 0.7);
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_dmgd, 0, 0.7);
        _id_0380::_id_288B("zmb_berl_bob_engine_rev_dmg", undefined, var_1);
        wait 1.75;
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop, 1, 1);
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_hi, 1, 1);
        _id_0380::_id_684E(level._id_11CB.bob_engine_phase3_loop_dmgd, 1, 1);
      }

      break;
    default:
      break;
  }
}

dlc_handle_bob_spawned_music() {
  if(!isDefined(level._id_11CB.bob_music_playing) && !isDefined(level._id_11CB.bob_is_dead)) {
    level._id_11CB.bob_music_playing = 1;

    foreach(var_1 in level.players) {
      var_1 _id_0366::snd_set_auto_wave_music_enabled(0);
      var_1 notify("kill_wave_mus_switcher");
      var_1 _id_0366::_id_8E31("bob_fight", 0.25, 3);
    }
  }
}

dlc_handle_bob_killed_music() {
  level._id_11CB.bob_music_playing = undefined;
  level._id_11CB.bob_is_dead = 1;

  foreach(var_1 in level.players) {
    var_1 thread dlc_play_boss_killed_stinger();
  }
}

dlc_play_boss_killed_stinger() {
  self clientaddsoundsubmix("bob_death_stinger", 0.2);
  _id_0380::_id_2888("mus_bob_death_stinger", self);
  wait 10;
  self clientclearsoundsubmix("bob_death_stinger", 4.0);
}

dlc3_bob_smoke_attack_strt() {
  var_0 = self;
  wait 1.25;
  _id_0380::_id_288B("zmb_berl_bob_smoke_atk_explo", undefined, var_0);
}

dlc3_bob_smoke_attack_loop(var_0, var_1) {
  var_2 = _id_0380::_id_6842("zmb_berl_bob_smoke_atk_smk_lp", undefined, var_1, 0.5);
  var_3 = _id_0380::_id_6842("zmb_berl_bob_smoke_atk_elec_hum_lp", undefined, var_1, 0.5);
  var_4 = _id_0380::_id_6842("zmb_berl_bob_smoke_atk_elec_static_lp", undefined, var_1, 0.5);
  wait(var_0);
  _id_0380::_id_6850(var_2, 0.5);
  _id_0380::_id_6850(var_3, 0.5);
  _id_0380::_id_6850(var_4, 0.5);
  _id_0380::_id_2889("zmb_berl_bob_smoke_atk_end", undefined, var_1);
}

dlc3_bob_stab_leg() {
  var_0 = self;
  wait 1.4;
  _id_0380::_id_288B("zmb_berl_bob_shoot_leg", undefined, var_0);
}

dlc3_bob_shoot_gun(var_0) {
  var_1 = self;

  if(!isDefined(level._id_11CB.bob_shoot_snd)) {
    level._id_11CB.bob_shoot_snd = _id_0380::_id_2889("zmb_bob_gun_fire", undefined, var_0);
    _id_0380::_id_288F(level._id_11CB.bob_shoot_snd, var_1, "shoot_sound_done");
    var_1 waittill("shoot_sound_done");
    level._id_11CB.bob_shoot_snd = undefined;
  }
}

dlc3_bob_throw_grenade(var_0) {
  _id_0380::_id_2889("zmb_bob_shoot_grenade", undefined, var_0);
}

dlc3_guardian_drain_plate_vox() {
  var_0 = self;
  level._id_11CB.grd_drain_plate_vox_lp = _id_0380::_id_6844("zvox_grd_plate_absorb_lp", undefined, var_0, 0.2);
  level._id_11CB.grd_absorb_lp = _id_0380::_id_6844("zmb_grd_absorb_lp", undefined, var_0, 0.2);
}

dlc3_guardian_drain_plate_vox_stop() {
  var_0 = self;
  _id_0380::_id_6850(level._id_11CB.grd_drain_plate_vox_lp, 0.3);
}

dlc3_guardian_smash_feast_zed() {
  _id_0380::_id_288B("zmb_grd_smash_absorb", undefined, self);
}

dlc3_guardian_pulse() {
  wait 0.75;
  _id_0380::_id_288B("zmb_grd_pulse", undefined, self);
}

dlc3_guardian_drain_success() {
  var_0 = self;
  _id_0380::_id_6850(level._id_11CB.grd_absorb_lp, 0.5);
  _id_0380::_id_288B("zmb_grd_absorb_success_end", undefined, var_0);
}

dlc3_guardian_drain_fail() {
  var_0 = self;
  _id_0380::_id_6850(level._id_11CB.grd_absorb_lp, 0.3);
  _id_0380::_id_288B("zmb_grd_absorb_end", undefined, var_0);
}

dlc3_zmb_redskull_pu() {
  var_0 = _id_0380::_id_6846("zmb_redskull_pu_lp", undefined, self, 0.1, undefined, 0.3);
  _id_0380::_id_684C(var_0, self, "redskull_lp_done");
  thread redskull_mumble_oneshot();
  thread redskull_scream_oneshot();
  self waittill("redskull_lp_done");
  self notify("stop_redskull_oneshots");
}

redskull_mumble_oneshot() {
  self endon("stop_redskull_oneshots");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_0 = _randomfloatrange(8, 14);
    _id_0380::_id_288B("zmb_redskull_pu_mumble_oneshot", undefined, self);
    wait(var_0);
  }
}

redskull_scream_oneshot() {
  self endon("stop_redskull_oneshots");
  self endon("death");
  self endon("disconnect");

  for(;;) {
    var_0 = _randomfloatrange(10, 15);
    _id_0380::_id_288B("zmb_redskull_pu_scream_oneshot", undefined, self);
    wait(var_0);
  }
}

dlc3_redskull_accept() {
  _id_0380::_id_288B("zmb_redskull_accept", undefined, self);
}

dlc3_rune_jolt_absorb() {
  _id_0380::_id_288B("zmb_srv_rune_jolt_absorb", undefined, self);
}

dlc3_player_spawned() {
  self clientaddsoundsubmix("dlc3_default_mix");
  _id_0366::snd_zmb_set_plr_vox_scare_count_max(0);
}

dlc3_wave_begin(var_0) {
  var_1 = self;
  var_1 endon("disconnect");

  if(var_1 _id_0366::snd_get_auto_wave_music_enabled()) {
    self _meth_85A7("snd_randomize_ambient_mus_layers");
    waitframe();
    thread dlc3_wave_mus_switcher();
  }
}

dlc3_wave_end() {
  self notify("kill_dlc3_wave_mus_switcher");
  self clientclearsoundsubmix("dlc3_plr_idle_mus_fade", 3.0);
}

dlc3_wave_mus_switcher() {
  self endon("death");
  self endon("kill_dlc3_wave_mus_switcher");
  self endon("disconnect");
  var_0 = self;
  var_1 = 60000;
  var_2 = 240000;
  var_3 = _randomintrange(var_1, var_2);
  var_4 = 2000;
  var_5 = 0.1;
  var_6 = gettime();
  var_7 = 0;
  var_8 = 0;
  var_9 = 0;
  var_10 = 1;
  var_11 = var_0.origin;
  var_12 = 1;
  var_13 = 6;
  var_14 = 14;
  var_15 = 3;
  var_16 = _id_0366::snd_get_curr_combat_cue_name();
  wait 1;

  for(;;) {
    if(!_id_0366::snd_get_auto_wave_music_enabled()) {
      wait 1;
      continue;
    }

    var_17 = gettime() - var_6;
    var_18 = var_0 _id_0366::_id_8E14();
    var_19 = var_0.origin != var_11;
    var_11 = var_0.origin;
    var_20 = var_4;

    if(var_19) {
      if(!var_10) {
        var_10 = 1;
        var_9 = var_17;
      }
    } else if(var_10) {
      var_10 = 0;
      var_8 = var_17;
    }

    if(!var_19 && var_17 - var_8 > var_20 && var_18 <= var_5 && var_12) {
      var_12 = 0;
      var_0 clientaddsoundsubmix("dlc3_plr_idle_mus_fade", var_14);
    } else if(!var_12 && (var_19 || var_18 > var_5 && var_17 - var_9 > var_20 * 0.5)) {
      var_12 = 1;
      var_0 clientclearsoundsubmix("dlc3_plr_idle_mus_fade", var_13);
    } else if(var_12 && var_17 - var_7 > var_3) {
      var_7 = var_17;
      var_16 = var_0 _id_0366::_id_8D46();

      if(_id_0378::_id_8D1B(0.02)) {
        var_16 = "ravens";
      }

      var_0 _id_0366::_id_8DCF(var_16);
      _id_0366::_id_8E32(var_14);
      wait 0.1;
      _id_0366::_id_8E31(var_16, var_15);
      var_3 = _randomintrange(var_1, var_2);
    }

    wait 0.5;
  }
}