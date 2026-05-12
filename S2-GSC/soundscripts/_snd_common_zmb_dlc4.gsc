/*************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: soundscripts\_snd_common_zmb_dlc4.gsc
*************************************************/

snd_zmb_init_dlc4() {
  level snd_zmb_register_messages_dlc4();
  level lib_0366::snd_set_round_countdown_aliases("dlc4_round_countdown", "dlc4_round_countdown_end");
}

snd_zmb_register_messages_dlc4() {
  lib_0378::func_8DC7("zmb_HAMMER_melee_hit_wooden", ::zmb_hammer_melee_hit_wooden);
  lib_0378::func_8DC7("zmb_HAMMER_melee_hit_metal", ::zmb_hammer_melee_hit_metal);
  lib_0378::func_8DC7("dlc4_throw_hammer", ::dlc4_throw_hammer);
  lib_0378::func_8DC7("dlc4_hammer_catch", ::dlc4_hammer_catch);
  lib_0378::func_8DC7("zmb_HAMMER_throw_hit_metal", ::zmb_hammer_throw_hit_metal);
  lib_0378::func_8DC7("aud_hammer_lightning", ::hammer_lightning);
  lib_0378::func_8DC7("aud_hammer_trail_lp", ::hammer_trail_lp);
  lib_0378::func_8DC7("aud_hammer_emp_charged", ::hammer_emp_charged);
  lib_0378::func_8DC7("zmb_shield_bash", ::zmb_shield_bash);
  lib_0378::func_8DC7("zmb_shield_hit", ::zmb_shield_hit);
  lib_0378::func_8DC7("zmb_shield_break", ::zmb_shield_break);
  lib_0378::func_8DC7("zmb_bloodraven_shield_bash", ::zmb_bloodraven_shield_bash);
  lib_0378::func_8DC7("aud_zmb_scythe_swing", ::scythe_swing);
  lib_0378::func_8DC7("aud_zmb_scythe_impact", ::scythe_impact);
  lib_0378::func_8DC7("aud_zmb_scythe_emp_swing", ::scythe_emp_swing);
  lib_0378::func_8DC7("aud_zmb_scythe_burst", ::scythe_burst);
  lib_0378::func_8DC7("aud_zmb_scythe_proj_shoot", ::scythe_proj_shoot);
  lib_0378::func_8DC7("aud_zmb_scythe_proj_loop", ::scythe_proj_loop);
  lib_0378::func_8DC7("aud_zmb_scythe_proj_impact", ::scythe_proj_impact);
  lib_0378::func_8DC7("aud_zmb_scythe_charged_loop_start", ::scythe_charged_loop_start);
  lib_0378::func_8DC7("aud_zmb_scythe_charged_loop_stop", ::scythe_charged_loop_stop);
  lib_0378::func_8DC7("aud_corpse_eater_soul_suck", ::corpse_eater_soul_suck);
  lib_0378::func_8DC7("aud_corpse_eater_fully_charged", ::corpse_eater_fully_charged);
  lib_0378::func_8DC7("aud_corpse_eater_pre_explosion", ::corpse_eater_pre_explosion);
  lib_0378::func_8DC7("aud_corpse_eater_explosion", ::corpse_eater_explosion);
  lib_0378::func_8DC7("aud_moonorb_stuck", ::moonorb_stuck);
  lib_0378::func_8DC7("aud_moonorb_orphaned_lp", ::moonorb_orphaned_lp);
  lib_0378::func_8DC7("aud_moonorb_control_burst", ::moonorb_control_burst);
  lib_0378::func_8DC7("aud_moonorb_control_lp", ::moonorb_control_lp);
  lib_0378::func_8DC7("aud_moonorb_teleport", ::moonorb_teleport);
  lib_0378::func_8DC7("aud_dlc4_magic_poof", ::dlc4_magic_poof);
  lib_0378::func_8DC7("god_king_giestblast_charge", ::god_king_giestblast_charge);
  lib_0378::func_8DC7("god_king_giestblast_throw", ::god_king_giestblast_throw);
  lib_0378::func_8DC7("god_king_giestbomb_projectile", ::god_king_giestbomb_projectile);
  lib_0378::func_8DC7("god_king_pull_summon", ::god_king_pull_summon);
  lib_0378::func_8DC7("god_king_pull", ::god_king_pull);
  lib_0378::func_8DC7("god_king_melee", ::god_king_melee);
  lib_0378::func_8DC7("flame_wave_runner_start", ::god_king_flame_wave_runner_start);
  lib_0378::func_8DC7("flame_wave_runner_stop", ::god_king_flame_wave_runner_stop);
  lib_0378::func_8DC7("flame_wave_runner_inside", ::god_king_flame_wave_runner_inside);
  lib_0378::func_8DC7("flame_wave_runner_outside", ::god_king_flame_wave_runner_outside);
  lib_0378::func_8DC7("god_king_giestdrain", ::god_king_giestdrain);
  lib_0378::func_8DC7("god_king_giestdrain_plate_destroyed", ::god_king_giestdrain_plate_destroyed);
  lib_0378::func_8DC7("aud_clear_mute_zvox_for_drain", ::clear_mute_zvox_for_drain);
  lib_0378::func_8DC7("god_king_sun_cast", ::god_king_sun_cast);
  lib_0378::func_8DC7("god_king_sun_blast", ::god_king_sun_blast);
  lib_0378::func_8DC7("god_king_sun_blast_hit_plr", ::god_king_sun_blast_hit_plr);
  lib_0378::func_8DC7("god_king_lightning_summon", ::god_king_lightning_summon);
  lib_0378::func_8DC7("god_king_lightning", ::god_king_lightning);
  lib_0378::func_8DC7("god_king_detonate_cast", ::god_king_detonate_cast);
  lib_0378::func_8DC7("god_king_detonate_throw", ::god_king_detonate_throw);
  lib_0378::func_8DC7("god_king_force_summon", ::god_king_force_summon);
  lib_0378::func_8DC7("god_king_force_kneel", ::god_king_force_kneel);
  lib_0378::func_8DC7("god_king_finale_drain_first", ::god_king_finale_drain_first);
  lib_0378::func_8DC7("god_king_finale_melee", ::god_king_finale_melee);
  lib_0378::func_8DC7("god_king_finale_drain_end", ::god_king_finale_drain_end);
  lib_0378::func_8DC7("god_king_death", ::god_king_death);
}

dlc4_player_spawned() {
  self method_8626("dlc4_default_mix");
  lib_0366::snd_zmb_set_plr_vox_scare_count_max(0);
}

dlc4_wave_begin(param_00) {
  var_01 = self;
  var_01 endon("disconnect");
  if(var_01 lib_0366::snd_get_auto_wave_music_enabled()) {
    self method_85A7("snd_randomize_ambient_mus_layers");
    wait 0.05;
    thread dlc4_wave_mus_switcher();
  }
}

dlc4_wave_end() {
  self notify("kill_dlc3_wave_mus_switcher");
  self method_8627("dlc3_plr_idle_mus_fade", 3);
}

dlc4_wave_mus_switcher() {
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

zmb_hammer_melee_hit_wooden(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_weap_hammer_imp_main", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_weap_hammer_imp_main", undefined, param_00.var_ABE6, undefined, 0.5);
  }
}

zmb_hammer_melee_hit_metal(param_00) {
  foreach(var_02 in level.var_744A) {
    if(var_02 == param_00.var_721C) {
      lib_0380::func_2889("zmb_weap_hammer_imp_main", undefined, param_00.var_ABE6);
      continue;
    }

    lib_0380::func_2889("zmb_weap_hammer_imp_main", undefined, param_00.var_ABE6, undefined, 0.5);
  }
}

dlc4_throw_hammer() {
  lib_0380::func_288B("zmb_weap_hammer_throw", undefined, self);
}

dlc4_hammer_catch(param_00, param_01) {
  var_02 = self;
  if(param_01 < 400 && !isDefined(var_02.catch_snd)) {
    var_02.catch_snd = lib_0380::func_2889("zmb_weap_hammer_catch", undefined, param_00);
  }

  wait(2);
  var_02.catch_snd = undefined;
}

zmb_hammer_throw_hit_metal() {
  var_00 = self;
  lib_0380::func_2889("zmb_weap_hammer_imp_main", undefined, var_00.var_116);
}

hammer_lightning(param_00) {
  lib_0380::func_2889("zmb_weap_hammer_lightning", undefined, param_00);
}

hammer_trail_lp() {
  lib_0380::func_6846("zmb_weap_hammer_throw_lp", undefined, self, 0.2, undefined, 0.2);
}

hammer_emp_charged() {
  lib_0380::func_6846("zmb_weap_hammer_charged_lp", undefined, self, 0.2, undefined, 0.2);
}

zmb_shield_bash(param_00) {
  var_01 = self;
  foreach(var_03 in level.var_744A) {
    if(var_03 == var_01) {
      var_03.plr_shield_hit_snd = lib_0380::func_2889("zmb_wpn_shield_hit_plr", var_01, param_00);
      continue;
    }

    var_03.npc_shield_hit_snd = lib_0380::func_2889("zmb_wpn_shield_hit_npc", undefined, param_00, undefined, 0.5);
  }
}

zmb_shield_hit() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  foreach(var_02 in level.var_744A) {
    if(var_02 == var_00) {
      lib_0380::func_288B("zmb_wpn_shield_dmg_plr", var_00, var_00);
      continue;
    }

    lib_0380::func_288B("zmb_wpn_shield_dmg_npc", undefined, var_00, undefined, 0.5);
  }
}

zmb_shield_break() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  foreach(var_02 in level.var_744A) {
    if(var_02 == var_00) {
      lib_0380::func_288B("zmb_wpn_shield_break_plr", var_00, var_00);
      continue;
    }

    lib_0380::func_288B("zmb_wpn_shield_break_npc", undefined, var_00, undefined, 0.5);
  }
}

zmb_bloodraven_shield_bash(param_00) {
  var_01 = self;
  foreach(var_03 in level.var_744A) {
    if(var_03 == var_01) {
      var_03.plr_br_shield_hit_snd = lib_0380::func_2889("zmb_wpn_bloodraven_shield_hit_plr", var_01, param_00);
      continue;
    }

    var_03.npc_br_shield_hit_snd = lib_0380::func_2889("zmb_wpn_bloodraven_shield_hit_npc", undefined, param_00, undefined, 0.5);
  }
}

scythe_swing() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  foreach(var_02 in level.var_744A) {
    if(var_02 == var_00) {
      lib_0380::func_288B("zmb_weap_scythe_whoosh_2d", var_00, var_00);
      continue;
    }

    lib_0380::func_288B("zmb_weap_scythe_whoosh", undefined, var_00, undefined, 0.5);
  }
}

scythe_impact() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  foreach(var_02 in level.var_744A) {
    if(var_02 == var_00) {
      lib_0380::func_288B("zmb_weap_scythe_hit_2d", var_00, var_00);
      continue;
    }

    lib_0380::func_288B("zmb_weap_scythe_hit", undefined, var_00, undefined, 0.5);
  }
}

scythe_emp_swing() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  foreach(var_02 in level.var_744A) {
    if(var_02 == var_00) {
      lib_0380::func_288B("zmb_weap_scythe_emp_whoosh_2d", var_00, var_00);
      continue;
    }

    lib_0380::func_288B("zmb_weap_scythe_emp_whoosh", undefined, var_00, undefined, 0.5);
  }
}

scythe_burst() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  foreach(var_02 in level.var_744A) {
    if(var_02 == var_00) {
      lib_0380::func_288B("zmb_weap_scythe_burst_2d", var_00, var_00);
      continue;
    }

    lib_0380::func_288B("zmb_weap_scythe_burst", undefined, var_00, undefined, 0.5);
  }
}

scythe_proj_shoot() {
  if(!isDefined(self)) {
    return;
  }

  var_00 = self;
  foreach(var_02 in level.var_744A) {
    if(var_02 == var_00) {
      lib_0380::func_288B("zmb_weap_scythe_proj_shoot_2d", var_00, var_00);
      continue;
    }

    lib_0380::func_288B("zmb_weap_scythe_proj_shoot", undefined, var_00, undefined, 0.5);
  }
}

scythe_proj_loop() {
  var_00 = lib_0380::func_288B("zmb_weap_scythe_proj_lp", undefined, self);
  common_scripts\utility::func_A74B("death", 3);
  lib_0380::func_2893(var_00, 1);
}

scythe_proj_impact() {
  lib_0380::func_288B("zmb_weap_scythe_proj_imp", undefined, self);
}

scythe_charged_loop_start() {
  if(!isDefined(self.scythe_charged_loop)) {
    self.scythe_charged_loop = lib_0380::func_288B("zmb_weap_scythe_charged_lp", self, self, 0);
  }
}

scythe_charged_loop_stop() {
  if(isDefined(self.scythe_charged_loop)) {
    lib_0380::func_2893(self.scythe_charged_loop, 0);
    wait 0.05;
    self.scythe_charged_loop = undefined;
  }
}

corpse_eater_soul_suck(param_00, param_01) {
  var_02 = spawn("script_origin", param_00);
  var_03 = 0;
  var_04 = 0.875;
  lib_0380::func_288B("zombie_soul_suck", undefined, var_02, 0, var_04);
  var_02 moveto(param_01, 1.9);
  wait(2);
  var_02 delete();
}

corpse_eater_fully_charged() {
  if(!isDefined(self)) {
    return;
  }

  self.transform_snd_handle = lib_0380::func_288B("zmb_corpse_eater_transform", undefined, self);
  self.charged_up_snd_handle = lib_0380::func_288B("zmb_corpse_eater_charged_up", undefined, self);
  self.charge_decay_snd_handle = lib_0380::func_288B("zmb_corpse_eater_charge_decay", undefined, self, 2.5);
  self.corpse_eater_charged_lp = lib_0380::func_6846("zmb_corpse_eater_energy_lp", undefined, self, 1.5);
}

corpse_eater_pre_explosion() {
  if(!isDefined(self)) {
    return;
  }

  self.pre_explosion_scream_snd_handle = lib_0380::func_288B("zmb_corpse_eater_explo_scream", undefined, self);
}

corpse_eater_explosion() {
  if(!isDefined(self)) {
    return;
  }

  self.explo_snd_handle = lib_0380::func_288B("zmb_corpse_eater_explosion", undefined, self);
}

moonorb_stuck() {
  var_00 = self;
  var_00.moonorb_stuck_lp = lib_0380::func_6846("zmb_wpn_mstar_grnd_lp", undefined, self, 0.2, undefined, 0.3);
}

moonorb_orphaned_lp() {
  var_00 = self;
  var_00.moonorb_orphaned_lp = lib_0380::func_6846("zmb_wpn_mstar_mind_lp", undefined, self, 0.2, undefined, 0.3);
}

moonorb_control_burst() {
  var_00 = self;
  var_00.var_8CFF = lib_0380::func_288B("zmb_wpn_mstar_grnd_explo", undefined, self);
}

moonorb_control_lp() {
  var_00 = self;
  var_00.moon_orb_control_lp = lib_0380::func_6846("zmb_wpn_mstar_mind_lp", undefined, self, 0.2, undefined, 0.3);
}

moonorb_teleport() {
  lib_0380::func_288B("zmb_wpn_mstar_teleport", undefined, self);
}

dlc4_magic_poof(param_00) {
  lib_0380::func_2889("dlc4_magic_poof", undefined, self.var_116);
}

god_king_giestblast_charge() {
  lib_0380::func_288B("zmb_gdkng_geistblast_charge", undefined, self);
}

god_king_giestblast_throw(param_00, param_01) {
  var_02 = lib_0380::func_288B("zmb_gdkng_geistblast_fire", undefined, param_00);
  if(!isDefined(param_01)) {
    return;
  }

  param_01 waittill("projectile_impact", var_03, var_04);
  lib_0380::func_2893(var_02, 0.5);
  lib_0380::func_2889("zmb_gdkng_geistblast_impact", undefined, var_04);
}

god_king_giestbomb_projectile(param_00, param_01) {
  switch (param_00) {
    case "spawn":
      param_01.spawn_lp = lib_0380::func_6846("zmb_gdkng_geistbomb_spawn_orb_loop", undefined, param_01, 0.2, undefined, 0.75);
      break;

    case "activate":
      param_01.activate_strt_snd = lib_0380::func_6844("zmb_gdkng_geistbomb_strt", undefined, param_01);
      param_01.activate_lp_snd = lib_0380::func_6846("zmb_gdkng_geistbomb_activated_lp", undefined, param_01, 0.2, undefined, 0.5);
      break;

    case "explode":
      param_01.activate_end_snd = lib_0380::func_6844("zmb_gdkng_geistbomb_end", undefined, param_01);
      param_01.boom_snd = lib_0380::func_6844("zmb_gdkng_geistbomb_detonate_boom", undefined, param_01);
      break;

    default:
      break;
  }
}

god_king_pull_summon() {
  var_00 = self;
  wait(0.5);
  lib_0380::func_288B("zmb_gdkng_pull_summon", undefined, var_00);
  wait(0.75);
  lib_0380::func_288B("zmb_gdkng_pull_summon_b", undefined, var_00);
}

god_king_pull() {
  var_00 = self;
  lib_0380::func_288B("zmb_gdkng_pull_detonate", undefined, var_00);
}

god_king_melee() {
  var_00 = self;
  wait(0.4);
  lib_0380::func_288B("zmb_gdkng_melee", undefined, var_00);
}

god_king_flame_wave_runner_start(param_00, param_01) {
  param_01.flamewave_lp = lib_0380::func_6844("zmb_gdkng_flamewave_main_lp", param_01, param_00, 0.2);
  param_01.flamewave_close_lp = lib_0380::func_6844("zmb_gdkng_flamewave_close_sizzle_lp", param_01, param_00, 0.2);
  lib_0380::func_288B("zmb_gdkng_flamewave_strt", param_01, param_00);
}

god_king_flame_wave_runner_stop(param_00, param_01) {
  if(isDefined(param_01.flamewave_lp)) {
    lib_0380::func_6850(param_01.flamewave_lp, 2);
  }

  if(isDefined(param_01.flamewave_close_lp)) {
    lib_0380::func_6850(param_01.flamewave_close_lp, 2);
  }

  wait(1);
  lib_0380::func_288B("zmb_gdkng_flamewave_end", param_01, param_00);
}

god_king_flame_wave_runner_inside(param_00, param_01) {}

god_king_flame_wave_runner_outside(param_00, param_01) {}

god_king_giestdrain(param_00, param_01) {
  param_00 thread drain_king(param_00, param_01);
  foreach(var_03 in level.blood_plates) {
    if(lib_0547::func_5565(var_03.var_8260, "plate_boss_room")) {
      thread drain_plate(var_03, param_01);
    }
  }

  thread zombie_giestdrain_submix(param_00, param_01);
}

zombie_giestdrain_submix(param_00, param_01) {
  level endon("end_geistdrain_submix");
  param_01 endon("attack_geist_drain_stop");
  foreach(var_03 in level.var_744A) {
    for(;;) {
      var_04 = distance2d(var_03.var_116, param_00.var_116);
      if(var_04 < 800) {
        var_03 method_8626("godking_giestdrain_mute_zvox");
        continue;
      }

      var_03 method_8627("godking_giestdrain_mute_zvox");
      wait(0.2);
    }
  }
}

drain_king(param_00, param_01) {
  param_01 endon("attack_geist_drain_stop");
  for(;;) {
    var_02 = lib_0380::func_6842("zmb_gdkng_drain", undefined, param_00.var_116);
    wait(1);
  }
}

drain_plate(param_00, param_01) {
  param_00 endon("drain_ended");
  param_00 endon("plate_destroyed");
  thread blood_plate_drain_blood(param_00);
  for(;;) {
    param_00.soul_snd = lib_0380::func_6842("zmb_gdkng_drain", undefined, param_00.plate_model.var_116);
    wait(1);
  }
}

blood_plate_drain_blood(param_00) {
  param_00.blood_strt = lib_0380::func_2889("zmb_gdkng_drain_blood_strt", undefined, param_00.plate_model.var_116);
  param_00.blood_lp = lib_0380::func_6842("zmb_gdkng_drain_blood_lp", undefined, param_00.plate_model.var_116, 0.3);
  param_00 common_scripts\utility::knock_off_battery("drain_ended", "plate_destroyed");
  lib_0380::func_6850(param_00.blood_lp, 0.5);
  param_00.blood_stop = lib_0380::func_2889("zmb_gdkng_drain_blood_end", undefined, param_00.plate_model.var_116);
}

god_king_giestdrain_plate_destroyed() {
  var_00 = self;
  var_00.destroyed_snd = lib_0380::func_288B("zmb_gdkng_absorb_success_end", undefined, var_00);
}

clear_mute_zvox_for_drain() {
  level notify("end_geistdrain_submix");
  foreach(var_01 in level.var_744A) {
    var_01 method_8627("godking_giestdrain_mute_zvox");
  }
}

god_king_sun_cast() {
  var_00 = self;
  lib_0380::func_288B("zmb_gdk_spell_sun_charge_start_main", undefined, var_00);
  lib_0380::func_6846("zmb_gdk_spell_sun_charge_lp", undefined, var_00, 0.2, undefined, 0.5);
}

god_king_sun_blast() {
  lib_0380::func_288B("zmb_gdk_spell_sun_strike_main", undefined, self);
}

god_king_sun_blast_hit_plr(param_00) {
  lib_0380::func_288B("zmb_gdk_spell_sun_strike_plr_hit", param_00, self);
}

god_king_lightning_summon() {
  lib_0380::func_288B("zmb_gdk_spell_lightning_charge_main", undefined, self);
}

god_king_lightning() {
  lib_0380::func_288B("zmb_gdk_spell_lightning_main", undefined, self);
}

god_king_detonate_cast() {
  var_00 = self;
  wait(0.3);
  lib_0380::func_288B("zmb_gdkng_summon_generic", undefined, var_00);
}

god_king_detonate_throw(param_00) {
  var_01 = self;
  var_01.drain_ent = spawn("script_origin", var_01.var_116);
  var_01.beam_snd = lib_0380::func_288B("zmb_gdkng_drain", undefined, var_01.drain_ent);
  var_01.drain_ent moveto(param_00.var_116, 1.5);
  wait(1.6);
  var_01.drain_ent delete();
}

god_king_force_summon() {
  var_00 = lib_0380::func_6844("zmb_gdkng_absorb_lp", undefined, self, 0.3);
  self waittill("notify_force_unleash");
  wait(1);
  lib_0380::func_6850(var_00, 0.3);
  lib_0380::func_288B("zmb_gdkng_force", undefined, self);
}

god_king_force_kneel() {
  wait(1);
  foreach(var_01 in level.var_744A) {
    lib_0380::func_2888("zmb_gdkng_kneel", var_01);
  }
}

god_king_finale_drain_first() {
  self endon("death");
  level endon("aud_stop_godking_finale_sfx");
  lib_0380::func_6844("zmb_gdkng_giest_finale_buildup", undefined, self);
  wait(0.5);
  level.var_11CB.final_drain_lp = lib_0380::func_6844("zmb_gdkng_giest_finale_lp", undefined, self);
  thread finale_elec_oneshots();
  thread finale_whoosh_oneshots();
}

finale_elec_oneshots() {
  self endon("death");
  level endon("aud_stop_godking_finale_sfx");
  wait(3);
  for(;;) {
    var_00 = randomintrange(5, 8);
    var_01 = self.var_116 + (randomintrange(-200, 200), randomintrange(-200, 200), 0);
    lib_0380::func_2889("zmb_gdkng_giest_finale_elec_oneshot", undefined, var_01);
    wait(var_00);
  }
}

finale_whoosh_oneshots() {
  self endon("death");
  level endon("aud_stop_godking_finale_sfx");
  wait(3);
  for(;;) {
    var_00 = randomintrange(4, 9);
    var_01 = self.var_116 + (randomintrange(-200, 200), randomintrange(-200, 200), 0);
    lib_0380::func_2889("zmb_gdkng_giest_finale_whoosh_oneshot", undefined, var_01);
    wait(var_00);
  }
}

god_king_finale_melee() {
  wait(2);
  lib_0380::func_288B("zmb_gdkng_melee", undefined, self);
}

god_king_finale_drain_end() {
  lib_0380::func_6850(level.var_11CB.final_drain_lp, 0.5);
  lib_0380::func_288B("zmb_gdkng_giest_finale_end", undefined, self);
  level notify("aud_stop_godking_finale_sfx");
}

god_king_death() {
  wait(7);
  lib_0380::func_288B("zmb_gdkng_finale_death_fx_into", undefined, self);
}