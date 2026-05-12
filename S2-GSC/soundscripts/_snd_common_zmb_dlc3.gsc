/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: soundscripts\_snd_common_zmb_dlc3.gsc
*************************************************/

snd_zmb_init_dlc3() {
  level snd_zmb_register_messages_dlc3();
  level lib_0366::snd_set_round_countdown_aliases("dlc3_round_countdown", "dlc3_round_countdown_end");
}

snd_zmb_register_messages_dlc3() {
  lib_0378::func_8DC7("dlc3_barbarosa_swrd_knockback", ::dlc3_barbarosa_swrd_knockback);
  lib_0378::func_8DC7("dlc3_barbarosa_sword_empowered", ::dlc3_barbarosa_sword_empowered);
  lib_0378::func_8DC7("dlc3_barbarosa_sword_stun", ::dlc3_barbarosa_sword_stun);
  lib_0378::func_8DC7("dlc3_geist_bomb_activate", ::dlc3_geist_bomb_activate);
  lib_0378::func_8DC7("dlc3_giest_bomb_revive", ::dlc3_giest_bomb_revive);
  lib_0378::func_8DC7("dlc3_giest_bomb_arm", ::dlc3_giest_bomb_arm);
  lib_0378::func_8DC7("dlc3_geist_bomb_detonate", ::dlc3_geist_bomb_detonate);
  lib_0378::func_8DC7("ks_carepackage_flyby", ::dlc3_carepackage_flyby);
  lib_0378::func_8DC7("ks_emergency_carepackage", ::dlc3_emergency_airdrop);
  lib_0378::func_8DC7("ks_carepackage_parachute", ::dlc3_carepackage_parachute);
  lib_0378::func_8DC7("ks_carepackage_firstImpact", ::dlc3_carepackage_firstimpact);
  lib_0378::func_8DC7("dlc3_player_repair_start", ::dlc3_player_repair_start);
  lib_0378::func_8DC7("dlc3_player_repair_stop", ::dlc3_player_repair_stop);
  lib_0378::func_8DC7("dlc3_start_escape_music", ::dlc3_start_escape_music);
  lib_0378::func_8DC7("dlc3_stop_escape_music", ::dlc3_stop_escape_music);
  lib_0378::func_8DC7("dlc3_fireman_enable_shield", ::dlc3_fireman_enable_shield);
  lib_0378::func_8DC7("dlc3_fireman_disable_shield", ::dlc3_fireman_disable_shield);
  lib_0378::func_8DC7("dlc3_magic_poof", ::dlc3_magic_poof);
  lib_0378::func_8DC7("dlc3_altered_state_fade", ::dlc3_altered_state_fade);
  lib_0378::func_8DC7("dlc3_altered_state_apply", ::dlc3_altered_state_apply);
  lib_0378::func_8DC7("dlc3_bob_engine", ::dlc3_bob_engine);
  lib_0378::func_8DC7("dlc3_bob_smoke_attack_strt", ::dlc3_bob_smoke_attack_strt);
  lib_0378::func_8DC7("dlc3_bob_smoke_attack_loop", ::dlc3_bob_smoke_attack_loop);
  lib_0378::func_8DC7("dlc3_bob_stab_leg", ::dlc3_bob_stab_leg);
  lib_0378::func_8DC7("dlc3_bob_shoot_gun", ::dlc3_bob_shoot_gun);
  lib_0378::func_8DC7("dlc3_bob_throw_grenade", ::dlc3_bob_throw_grenade);
  lib_0378::func_8DC7("dlc3_guardian_drain_plate_vox", ::dlc3_guardian_drain_plate_vox);
  lib_0378::func_8DC7("dlc3_guardian_drain_plate_vox_stop", ::dlc3_guardian_drain_plate_vox_stop);
  lib_0378::func_8DC7("dlc3_guardian_smash_feast_zed", ::dlc3_guardian_smash_feast_zed);
  lib_0378::func_8DC7("dlc3_guardian_pulse", ::dlc3_guardian_pulse);
  lib_0378::func_8DC7("dlc3_guardian_drain_success", ::dlc3_guardian_drain_success);
  lib_0378::func_8DC7("dlc3_guardian_drain_fail", ::dlc3_guardian_drain_fail);
  lib_0378::func_8DC7("dlc3_zmb_redskull_pu", ::dlc3_zmb_redskull_pu);
  lib_0378::func_8DC7("dlc3_redskull_accept", ::dlc3_redskull_accept);
  lib_0378::func_8DC7("dlc3_rune_jolt_absorb", ::dlc3_rune_jolt_absorb);
}

dlc3_barbarosa_swrd_knockback() {
  var_00 = self;
  wait(0.4);
  lib_0380::func_288B("zmb_barb_sword_knockback_swetener", undefined, var_00);
}

dlc3_barbarosa_sword_empowered() {
  var_00 = self;
  var_00.empowered_lp = lib_0380::func_6846("zmb_barb_sword_empower_loop", undefined, var_00, 0.1, undefined, 0.1);
}

dlc3_barbarosa_sword_stun(param_00) {
  var_01 = self;
  switch (param_00) {
    case "stun_on":
      var_01.stun_lp = lib_0380::func_6844("zmb_barb_sword_stun_lp", undefined, var_01, 0.1);
      break;

    case "stun_off":
      lib_0380::func_6850(var_01.stun_lp, 0.4);
      break;
  }
}

dlc3_geist_bomb_activate(param_00) {
  param_00.geist_bomb_lp = lib_0380::func_6846("zmb_barb_sword_orb_loop", undefined, param_00.var_8203, 0.1, undefined, 0.5);
}

dlc3_giest_bomb_revive(param_00, param_01) {
  param_00 endon("death");
  param_00 endon("disconnect");
  lib_0380::func_6846("zmb_barb_sword_revive_loop", undefined, param_01, 0.1, undefined, 0.3);
  param_00 waittill("revive");
  lib_0380::func_288B("zmb_barb_sword_revive_oneshot", undefined, param_00);
}

dlc3_giest_bomb_arm(param_00) {
  param_00.giest_bomb_armed_strt = lib_0380::func_6844("zmb_geistbomb_strt", undefined, param_00.var_8203);
  param_00.giest_bomb_armed_lp = lib_0380::func_6844("zmb_geistbomb_activated_lp", undefined, param_00.var_8203, 0.1);
  param_00 common_scripts\utility::knock_off_battery("geist_bomb_cleanup", "geist_bomb_end_priming");
  lib_0380::func_6850(param_00.giest_bomb_armed_lp, 0.3);
  param_00.giest_bomb_armed_end = lib_0380::func_6844("zmb_geistbomb_end", undefined, param_00.var_8203);
}

dlc3_geist_bomb_detonate(param_00) {
  param_00.giest_bomb_detonate = lib_0380::func_288B("zmb_geistbomb_detonate_boom", undefined, param_00.var_8203);
  param_00.geist_bomb_detonate_lp = lib_0380::func_6844("zmb_geistbomb_detonate_warble_lp", undefined, param_00.var_8203, 0.1);
  param_00 waittill("geist_bomb_detonate_end");
  lib_0380::func_6850(param_00.geist_bomb_detonate_lp, 1.5);
  wait(1);
  lib_0380::func_288B("zmb_geistbomb_detonate_end", undefined, param_00.var_8203);
}

dlc3_carepackage_flyby() {
  var_00 = self;
  lib_0380::func_6844("ks_plane_by_supply_drop", undefined, var_00);
}

dlc3_emergency_airdrop() {
  var_00 = self;
  lib_0380::func_6846("ks_plane_by_emergency_drop", undefined, var_00);
}

dlc3_carepackage_parachute() {
  var_00 = self;
  var_01 = 0.5;
  var_02 = 0.5;
  var_03 = lib_0380::func_6844("ks_crpkg_parachute_lp", undefined, var_00, var_01);
  var_00 waittill("detach");
  lib_0380::func_6850(var_03, var_02);
  lib_0380::func_6842("ks_crpkg_parachute_release", undefined, var_00.var_116);
}

dlc3_carepackage_firstimpact() {
  var_00 = self;
  if(self.var_1A7 == "allies") {
    lib_0380::func_6844("mp_ks_crpkg_imp_allies", undefined, self);
    return;
  }

  lib_0380::func_6844("mp_ks_crpkg_imp_axis", undefined, self);
}

dlc3_player_repair_start(param_00, param_01) {
  var_02 = self;
  wait(1.2);
  if(param_00 == "war_wrench_assemble_mp") {
    level.var_11CB.repair_wrench_snd = lib_0380::func_2889("buildable_barbed_wire_wrench", undefined, param_01.var_116);
  }
}

dlc3_player_repair_stop(param_00) {
  if(isDefined(level.var_11CB.repair_wrench_snd)) {
    lib_0380::func_2893(level.var_11CB.repair_wrench_snd, 0.1);
    level.var_11CB.repair_wrench_snd = undefined;
  }
}

dlc3_start_escape_music() {
  if(!isDefined(level.var_11CB.escape_music_playing)) {
    level.var_11CB.escape_music_playing = 1;
    foreach(var_01 in level.var_744A) {
      var_01 lib_0366::snd_set_auto_wave_music_enabled(0);
      var_01 notify("kill_dlc3_wave_mus_switcher");
      var_01 lib_0366::func_8E31("escape_01", 0.25, 3);
    }
  }
}

dlc3_stop_escape_music(param_00) {
  var_01 = lib_0378::func_8D49(0, param_00);
  if(isDefined(level.var_11CB.escape_music_playing)) {
    var_02 = 10;
    foreach(var_04 in level.var_744A) {
      var_04 thread dlc3_play_escape_complete_stinger(var_02);
    }

    wait(var_02);
    wait(var_01);
    var_06 = 10;
    foreach(var_04 in level.var_744A) {
      var_04 lib_0366::func_8E32(var_06);
    }

    foreach(var_04 in level.var_744A) {
      var_04 lib_0366::snd_set_auto_wave_music_enabled(1);
      var_04 thread dlc3_wave_mus_switcher();
    }

    level.var_11CB.escape_music_playing = 0;
  }
}

dlc3_play_escape_complete_stinger(param_00) {
  if(!isDefined(self.playing_escape_complete_stinger)) {
    self.playing_escape_complete_stinger = 1;
    self method_8626("dlc3_escape_complete_stinger", 4);
    lib_0380::func_2888("dlc3_escape_complete_stinger_01", self);
    wait(param_00);
    self method_8627("dlc3_escape_complete_stinger", 4);
    self.playing_escape_complete_stinger = undefined;
  }
}

dlc3_fireman_enable_shield(param_00) {
  if(isDefined(param_00.aud_fireman_shield_loop)) {
    lib_0380::func_6850(param_00.aud_fireman_shield_loop, 2);
    wait 0.05;
  }

  lib_0380::func_6842("dlc3_fireman_shield_begin", undefined, param_00.var_116);
  param_00.aud_fireman_shield_loop = lib_0380::func_6846("dlc3_fireman_shield_lp", undefined, param_00, 0.5, 1, 2);
}

dlc3_fireman_disable_shield(param_00) {
  if(isDefined(param_00)) {
    lib_0380::func_6850(param_00.aud_fireman_shield_loop, 2);
    param_00.aud_fireman_shield_loop = undefined;
    lib_0380::func_6842("dlc3_fireman_shield_end", undefined, param_00.var_116);
  }
}

dlc3_magic_poof(param_00) {
  lib_0380::func_2889("dlc3_magic_poof", undefined, param_00);
}

dlc3_altered_state_init() {
  self method_8626("dlc3_pre_altered_state");
}

dlc3_altered_state_fade() {
  var_00 = gettime();
  if(!isDefined(self.var_71D.altered_state_fade_start_time) || var_00 - self.var_71D.altered_state_fade_start_time > 2000) {
    var_01 = lib_0380::func_2888("dlc3_altered_state_fade", self);
    self.var_71D.altered_state_fade_start_time = var_00;
  }
}

dlc3_altered_state_apply(param_00, param_01) {
  if(isDefined(self.var_11CB.dlc3_altered_state_submix)) {
    dlc3_altered_state_clear();
  }

  if(isDefined(self.var_11CB.in_the_void)) {
    return;
  }

  param_00 = lib_0378::func_8D49(1, param_00);
  if(param_00 == 1 || param_00 == 2 || param_00 == 3) {
    if(param_00 == 1) {
      self method_8627("dlc3_pre_altered_state", 1);
      self notify("kill_dlc3_wave_mus_switcher");
      self method_8627("dlc3_plr_idle_mus_fade", 1);
      lib_0366::snd_set_auto_wave_music_enabled(0);
      lib_0366::func_8E47(0);
    } else if(param_00 == 2) {
      self.var_71D.altered_state_sfx_loop = lib_0380::func_6840("dlc3_altered_state_02", self);
    } else if(param_00 == 3) {
      lib_0380::func_6850(self.var_71D.altered_state_sfx_loop, 3);
      self.var_71D.altered_state_sfx_loop = lib_0380::func_6840("dlc3_altered_state_03", self);
    }

    lib_0366::func_8E32(4);
    var_02 = ["zmb_mus_creepy_amb_lp_01", "zmb_mus_creepy_amb_lp_02", "zmb_mus_creepy_amb_lp_03", "zmb_mus_creepy_amb_lp_04", "zmb_mus_creepy_amb_lp_05", "zmb_mus_creepy_amb_lp_06"];
    lib_0366::func_8E31(var_02[randomint(var_02.size)], 4);
    var_03 = "dlc3_altered_state" + param_00;
    self method_8626(var_03, 3);
    self.var_11CB.dlc3_altered_state_submix = var_03;
    param_01 = lib_0378::func_8D49("altered_state_end", param_01);
    self waittill(param_01);
    dlc3_altered_state_clear();
  }
}

dlc3_altered_state_clear() {
  if(isstring(self.var_11CB.dlc3_altered_state_submix)) {
    self method_8627(self.var_11CB.dlc3_altered_state_submix, 3);
    if(self.var_11CB.dlc3_altered_state_submix == "dlc3_altered_state3") {
      lib_0366::snd_set_auto_wave_music_enabled(1);
      lib_0366::func_8E09();
      thread dlc3_wave_mus_switcher();
    }

    self.var_11CB.dlc3_altered_state_submix = undefined;
    lib_0380::func_6850(self.var_71D.altered_state_sfx_loop, 3);
  }
}

dlc3_bob_engine(param_00) {
  var_01 = self;
  thread dlc_handle_bob_spawned_music();
  switch (param_00) {
    case "bob_punch":
      level.var_11CB.bob_engine_loop = lib_0380::func_6844("zmb_berl_bob_engine_lp", undefined, var_01, 0.2);
      level.var_11CB.bob_engine_loop_hi = lib_0380::func_6844("zmb_berl_bob_engine_hi_lp", undefined, var_01, 0.2);
      level.var_11CB.curr_phase = "bob_punch";
      break;

    case "bob_smoke":
      wait(1);
      lib_0380::func_6850(level.var_11CB.bob_engine_loop, 0.5);
      lib_0380::func_6850(level.var_11CB.bob_engine_loop_hi, 0.5);
      level.var_11CB.bob_engine_phase3_loop = lib_0380::func_6844("zmb_berl_bob_engine_phase_3_lp", undefined, var_01, 0.2);
      level.var_11CB.bob_engine_phase3_loop_hi = lib_0380::func_6844("zmb_berl_bob_engine_phase_3_hi_lp", undefined, var_01, 0.2);
      level.var_11CB.bob_engine_phase3_loop_dmgd = lib_0380::func_6844("zmb_berl_bob_engine_phase_3_dmged_lp", undefined, var_01, 0.2);
      level.var_11CB.curr_phase = "bob_smoke";
      break;

    case "bob_killed":
      lib_0380::func_6850(level.var_11CB.bob_engine_loop, 0.5);
      lib_0380::func_6850(level.var_11CB.bob_engine_loop_hi, 0.5);
      wait(1.5);
      lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop, 0.65, 0.25);
      lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_hi, 0.65, 0.25);
      lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_dmgd, 0.65, 0.25);
      wait(11);
      lib_0380::func_6850(level.var_11CB.bob_engine_phase3_loop, 0.5);
      lib_0380::func_6850(level.var_11CB.bob_engine_phase3_loop_hi, 0.5);
      lib_0380::func_6850(level.var_11CB.bob_engine_phase3_loop_dmgd, 0.5);
      lib_0380::func_288B("zmb_berl_bob_engine_turn_off", undefined, var_01);
      wait(2);
      level.var_11CB.bob_engine_loop = undefined;
      level.var_11CB.bob_engine_loop_hi = undefined;
      level.var_11CB.bob_engine_phase3_loop = undefined;
      level.var_11CB.bob_engine_phase3_loop_hi = undefined;
      level.var_11CB.bob_engine_phase3_loop_dmgd = undefined;
      thread dlc_handle_bob_killed_music();
      break;

    case "bob_engine_rev":
      if(level.var_11CB.curr_phase == "bob_punch") {
        lib_0380::func_684E(level.var_11CB.bob_engine_loop, 0, 0.7);
        lib_0380::func_684E(level.var_11CB.bob_engine_loop_hi, 0, 0.7);
        lib_0380::func_288B("zmb_berl_bob_engine_rev", undefined, var_01);
        wait(1.75);
        lib_0380::func_684E(level.var_11CB.bob_engine_loop, 1, 1);
        lib_0380::func_684E(level.var_11CB.bob_engine_loop_hi, 1, 1);
      }

      if(level.var_11CB.curr_phase == "bob_smoke") {
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop, 0, 0.7);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_hi, 0, 0.7);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_dmgd, 0, 0.7);
        lib_0380::func_288B("zmb_berl_bob_engine_rev_dmg", undefined, var_01);
        wait(1.75);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop, 1, 1);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_hi, 1, 1);
        lib_0380::func_684E(level.var_11CB.bob_engine_phase3_loop_dmgd, 1, 1);
      }
      break;

    default:
      break;
  }
}

dlc_handle_bob_spawned_music() {
  if(!isDefined(level.var_11CB.bob_music_playing) && !isDefined(level.var_11CB.bob_is_dead)) {
    level.var_11CB.bob_music_playing = 1;
    foreach(var_01 in level.var_744A) {
      var_01 lib_0366::snd_set_auto_wave_music_enabled(0);
      var_01 notify("kill_wave_mus_switcher");
      var_01 lib_0366::func_8E31("bob_fight", 0.25, 3);
    }
  }
}

dlc_handle_bob_killed_music() {
  level.var_11CB.bob_music_playing = undefined;
  level.var_11CB.bob_is_dead = 1;
  foreach(var_01 in level.var_744A) {
    var_01 thread dlc_play_boss_killed_stinger();
  }
}

dlc_play_boss_killed_stinger() {
  self method_8626("bob_death_stinger", 0.2);
  lib_0380::func_2888("mus_bob_death_stinger", self);
  wait(10);
  self method_8627("bob_death_stinger", 4);
}

dlc3_bob_smoke_attack_strt() {
  var_00 = self;
  wait(1.25);
  lib_0380::func_288B("zmb_berl_bob_smoke_atk_explo", undefined, var_00);
}

dlc3_bob_smoke_attack_loop(param_00, param_01) {
  var_02 = lib_0380::func_6842("zmb_berl_bob_smoke_atk_smk_lp", undefined, param_01, 0.5);
  var_03 = lib_0380::func_6842("zmb_berl_bob_smoke_atk_elec_hum_lp", undefined, param_01, 0.5);
  var_04 = lib_0380::func_6842("zmb_berl_bob_smoke_atk_elec_static_lp", undefined, param_01, 0.5);
  wait(param_00);
  lib_0380::func_6850(var_02, 0.5);
  lib_0380::func_6850(var_03, 0.5);
  lib_0380::func_6850(var_04, 0.5);
  lib_0380::func_2889("zmb_berl_bob_smoke_atk_end", undefined, param_01);
}

dlc3_bob_stab_leg() {
  var_00 = self;
  wait(1.4);
  lib_0380::func_288B("zmb_berl_bob_shoot_leg", undefined, var_00);
}

dlc3_bob_shoot_gun(param_00) {
  var_01 = self;
  if(!isDefined(level.var_11CB.bob_shoot_snd)) {
    level.var_11CB.bob_shoot_snd = lib_0380::func_2889("zmb_bob_gun_fire", undefined, param_00);
    lib_0380::func_288F(level.var_11CB.bob_shoot_snd, var_01, "shoot_sound_done");
    var_01 waittill("shoot_sound_done");
    level.var_11CB.bob_shoot_snd = undefined;
  }
}

dlc3_bob_throw_grenade(param_00) {
  lib_0380::func_2889("zmb_bob_shoot_grenade", undefined, param_00);
}

dlc3_guardian_drain_plate_vox() {
  var_00 = self;
  level.var_11CB.grd_drain_plate_vox_lp = lib_0380::func_6844("zvox_grd_plate_absorb_lp", undefined, var_00, 0.2);
  level.var_11CB.grd_absorb_lp = lib_0380::func_6844("zmb_grd_absorb_lp", undefined, var_00, 0.2);
}

dlc3_guardian_drain_plate_vox_stop() {
  var_00 = self;
  lib_0380::func_6850(level.var_11CB.grd_drain_plate_vox_lp, 0.3);
}

dlc3_guardian_smash_feast_zed() {
  lib_0380::func_288B("zmb_grd_smash_absorb", undefined, self);
}

dlc3_guardian_pulse() {
  wait(0.75);
  lib_0380::func_288B("zmb_grd_pulse", undefined, self);
}

dlc3_guardian_drain_success() {
  var_00 = self;
  lib_0380::func_6850(level.var_11CB.grd_absorb_lp, 0.5);
  lib_0380::func_288B("zmb_grd_absorb_success_end", undefined, var_00);
}

dlc3_guardian_drain_fail() {
  var_00 = self;
  lib_0380::func_6850(level.var_11CB.grd_absorb_lp, 0.3);
  lib_0380::func_288B("zmb_grd_absorb_end", undefined, var_00);
}

dlc3_zmb_redskull_pu() {
  var_00 = lib_0380::func_6846("zmb_redskull_pu_lp", undefined, self, 0.1, undefined, 0.3);
  lib_0380::func_684C(var_00, self, "redskull_lp_done");
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
    var_00 = randomfloatrange(8, 14);
    lib_0380::func_288B("zmb_redskull_pu_mumble_oneshot", undefined, self);
    wait(var_00);
  }
}

redskull_scream_oneshot() {
  self endon("stop_redskull_oneshots");
  self endon("death");
  self endon("disconnect");
  for(;;) {
    var_00 = randomfloatrange(10, 15);
    lib_0380::func_288B("zmb_redskull_pu_scream_oneshot", undefined, self);
    wait(var_00);
  }
}

dlc3_redskull_accept() {
  lib_0380::func_288B("zmb_redskull_accept", undefined, self);
}

dlc3_rune_jolt_absorb() {
  lib_0380::func_288B("zmb_srv_rune_jolt_absorb", undefined, self);
}

dlc3_player_spawned() {
  self method_8626("dlc3_default_mix");
  lib_0366::snd_zmb_set_plr_vox_scare_count_max(0);
}

dlc3_wave_begin(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  if(var_01 lib_0366::snd_get_auto_wave_music_enabled()) {
    self method_85A7("snd_randomize_ambient_mus_layers");
    wait 0.05;
    thread dlc3_wave_mus_switcher();
  }
}

dlc3_wave_end() {
  self notify("kill_dlc3_wave_mus_switcher");
  self method_8627("dlc3_plr_idle_mus_fade", 3);
}

dlc3_wave_mus_switcher() {
  self endon("death");
  self endon("kill_dlc3_wave_mus_switcher");
  self endon("disconnect");
  var_00 = self;
  var_01 = -5536;
  var_02 = 240000;
  var_03 = randomintrange(var_01, var_02);
  var_04 = 2000;
  var_05 = 0.1;
  var_06 = gettime();
  var_07 = 0;
  var_08 = 0;
  var_09 = 0;
  var_0A = 1;
  var_0B = var_00.var_116;
  var_0C = 1;
  var_0D = 6;
  var_0E = 14;
  var_0F = 3;
  var_10 = lib_0366::snd_get_curr_combat_cue_name();
  wait(1);
  for(;;) {
    if(!lib_0366::snd_get_auto_wave_music_enabled()) {
      wait(1);
      continue;
    }

    var_11 = gettime() - var_06;
    var_12 = var_00 lib_0366::func_8E14();
    var_13 = var_00.var_116 != var_0B;
    var_0B = var_00.var_116;
    var_14 = var_04;
    if(var_13) {
      if(!var_0A) {
        var_0A = 1;
        var_09 = var_11;
      }
    } else if(var_0A) {
      var_0A = 0;
      var_08 = var_11;
    }

    if(!var_13 && var_11 - var_08 > var_14 && var_12 <= var_05 && var_0C) {
      var_0C = 0;
      var_00 method_8626("dlc3_plr_idle_mus_fade", var_0E);
    } else if(!var_0C && var_13 || var_12 > var_05 && var_11 - var_09 > var_14 * 0.5) {
      var_0C = 1;
      var_00 method_8627("dlc3_plr_idle_mus_fade", var_0D);
    } else if(var_0C && var_11 - var_07 > var_03) {
      var_07 = var_11;
      var_10 = var_00 lib_0366::func_8D46();
      if(lib_0378::func_8D1B(0.02)) {
        var_10 = "ravens";
      }

      var_00 lib_0366::func_8DCF(var_10);
      lib_0366::func_8E32(var_0E);
      wait(0.1);
      lib_0366::func_8E31(var_10, var_0F);
      var_03 = randomintrange(var_01, var_02);
    }

    wait(0.5);
  }
}