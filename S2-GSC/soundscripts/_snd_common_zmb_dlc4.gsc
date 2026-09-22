/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: soundscripts\_snd_common_zmb_dlc4.gsc
*************************************************/

snd_zmb_init_dlc4() {
  level snd_zmb_register_messages_dlc4();
  level _id_0366::snd_set_round_countdown_aliases("dlc4_round_countdown", "dlc4_round_countdown_end");
}

snd_zmb_register_messages_dlc4() {
  _id_0378::_id_8DC7("zmb_HAMMER_melee_hit_wooden", ::zmb_hammer_melee_hit_wooden);
  _id_0378::_id_8DC7("zmb_HAMMER_melee_hit_metal", ::zmb_hammer_melee_hit_metal);
  _id_0378::_id_8DC7("dlc4_throw_hammer", ::dlc4_throw_hammer);
  _id_0378::_id_8DC7("dlc4_hammer_catch", ::dlc4_hammer_catch);
  _id_0378::_id_8DC7("zmb_HAMMER_throw_hit_metal", ::zmb_hammer_throw_hit_metal);
  _id_0378::_id_8DC7("aud_hammer_lightning", ::hammer_lightning);
  _id_0378::_id_8DC7("aud_hammer_trail_lp", ::hammer_trail_lp);
  _id_0378::_id_8DC7("aud_hammer_emp_charged", ::hammer_emp_charged);
  _id_0378::_id_8DC7("zmb_shield_bash", ::zmb_shield_bash);
  _id_0378::_id_8DC7("zmb_shield_hit", ::zmb_shield_hit);
  _id_0378::_id_8DC7("zmb_shield_break", ::zmb_shield_break);
  _id_0378::_id_8DC7("zmb_bloodraven_shield_bash", ::zmb_bloodraven_shield_bash);
  _id_0378::_id_8DC7("aud_zmb_scythe_swing", ::scythe_swing);
  _id_0378::_id_8DC7("aud_zmb_scythe_impact", ::scythe_impact);
  _id_0378::_id_8DC7("aud_zmb_scythe_emp_swing", ::scythe_emp_swing);
  _id_0378::_id_8DC7("aud_zmb_scythe_burst", ::scythe_burst);
  _id_0378::_id_8DC7("aud_zmb_scythe_proj_shoot", ::scythe_proj_shoot);
  _id_0378::_id_8DC7("aud_zmb_scythe_proj_loop", ::scythe_proj_loop);
  _id_0378::_id_8DC7("aud_zmb_scythe_proj_impact", ::scythe_proj_impact);
  _id_0378::_id_8DC7("aud_zmb_scythe_charged_loop_start", ::scythe_charged_loop_start);
  _id_0378::_id_8DC7("aud_zmb_scythe_charged_loop_stop", ::scythe_charged_loop_stop);
  _id_0378::_id_8DC7("aud_corpse_eater_soul_suck", ::corpse_eater_soul_suck);
  _id_0378::_id_8DC7("aud_corpse_eater_fully_charged", ::corpse_eater_fully_charged);
  _id_0378::_id_8DC7("aud_corpse_eater_pre_explosion", ::corpse_eater_pre_explosion);
  _id_0378::_id_8DC7("aud_corpse_eater_explosion", ::corpse_eater_explosion);
  _id_0378::_id_8DC7("aud_moonorb_stuck", ::moonorb_stuck);
  _id_0378::_id_8DC7("aud_moonorb_orphaned_lp", ::moonorb_orphaned_lp);
  _id_0378::_id_8DC7("aud_moonorb_control_burst", ::moonorb_control_burst);
  _id_0378::_id_8DC7("aud_moonorb_control_lp", ::moonorb_control_lp);
  _id_0378::_id_8DC7("aud_moonorb_teleport", ::moonorb_teleport);
  _id_0378::_id_8DC7("aud_dlc4_magic_poof", ::dlc4_magic_poof);
  _id_0378::_id_8DC7("god_king_giestblast_charge", ::god_king_giestblast_charge);
  _id_0378::_id_8DC7("god_king_giestblast_throw", ::god_king_giestblast_throw);
  _id_0378::_id_8DC7("god_king_giestbomb_projectile", ::god_king_giestbomb_projectile);
  _id_0378::_id_8DC7("god_king_pull_summon", ::god_king_pull_summon);
  _id_0378::_id_8DC7("god_king_pull", ::god_king_pull);
  _id_0378::_id_8DC7("god_king_melee", ::god_king_melee);
  _id_0378::_id_8DC7("flame_wave_runner_start", ::god_king_flame_wave_runner_start);
  _id_0378::_id_8DC7("flame_wave_runner_stop", ::god_king_flame_wave_runner_stop);
  _id_0378::_id_8DC7("flame_wave_runner_inside", ::god_king_flame_wave_runner_inside);
  _id_0378::_id_8DC7("flame_wave_runner_outside", ::god_king_flame_wave_runner_outside);
  _id_0378::_id_8DC7("god_king_giestdrain", ::god_king_giestdrain);
  _id_0378::_id_8DC7("god_king_giestdrain_plate_destroyed", ::god_king_giestdrain_plate_destroyed);
  _id_0378::_id_8DC7("aud_clear_mute_zvox_for_drain", ::clear_mute_zvox_for_drain);
  _id_0378::_id_8DC7("god_king_sun_cast", ::god_king_sun_cast);
  _id_0378::_id_8DC7("god_king_sun_blast", ::god_king_sun_blast);
  _id_0378::_id_8DC7("god_king_sun_blast_hit_plr", ::god_king_sun_blast_hit_plr);
  _id_0378::_id_8DC7("god_king_lightning_summon", ::god_king_lightning_summon);
  _id_0378::_id_8DC7("god_king_lightning", ::god_king_lightning);
  _id_0378::_id_8DC7("god_king_detonate_cast", ::god_king_detonate_cast);
  _id_0378::_id_8DC7("god_king_detonate_throw", ::god_king_detonate_throw);
  _id_0378::_id_8DC7("god_king_force_summon", ::god_king_force_summon);
  _id_0378::_id_8DC7("god_king_force_kneel", ::god_king_force_kneel);
  _id_0378::_id_8DC7("god_king_finale_drain_first", ::god_king_finale_drain_first);
  _id_0378::_id_8DC7("god_king_finale_melee", ::god_king_finale_melee);
  _id_0378::_id_8DC7("god_king_finale_drain_end", ::god_king_finale_drain_end);
  _id_0378::_id_8DC7("god_king_death", ::god_king_death);
}

dlc4_player_spawned() {
  self clientaddsoundsubmix("dlc4_default_mix");
  _id_0366::snd_zmb_set_plr_vox_scare_count_max(0);
}

dlc4_wave_begin(var_0) {
  var_1 = self;
  var_1 endon("disconnect");

  if(var_1 _id_0366::snd_get_auto_wave_music_enabled()) {
    self _meth_85A7("snd_randomize_ambient_mus_layers");
    waitframe();
    thread dlc4_wave_mus_switcher();
  }
}

dlc4_wave_end() {
  self notify("kill_dlc3_wave_mus_switcher");
  self clientclearsoundsubmix("dlc3_plr_idle_mus_fade", 3.0);
}

dlc4_wave_mus_switcher() {
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

zmb_hammer_melee_hit_wooden(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_weap_hammer_imp_main", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_weap_hammer_imp_main", undefined, var_0._id_ABE6, undefined, 0.5);
  }
}

zmb_hammer_melee_hit_metal(var_0) {
  foreach(var_2 in level.players) {
    if(var_2 == var_0.player) {
      _id_0380::_id_2889("zmb_weap_hammer_imp_main", undefined, var_0._id_ABE6);
      continue;
    }

    _id_0380::_id_2889("zmb_weap_hammer_imp_main", undefined, var_0._id_ABE6, undefined, 0.5);
  }
}

dlc4_throw_hammer() {
  _id_0380::_id_288B("zmb_weap_hammer_throw", undefined, self);
}

dlc4_hammer_catch(var_0, var_1) {
  var_2 = self;

  if(var_1 < 400 && !isDefined(var_2.catch_snd)) {
    var_2.catch_snd = _id_0380::_id_2889("zmb_weap_hammer_catch", undefined, var_0);
  }

  wait 2;
  var_2.catch_snd = undefined;
}

zmb_hammer_throw_hit_metal() {
  var_0 = self;
  _id_0380::_id_2889("zmb_weap_hammer_imp_main", undefined, var_0.origin);
}

hammer_lightning(var_0) {
  _id_0380::_id_2889("zmb_weap_hammer_lightning", undefined, var_0);
}

hammer_trail_lp() {
  _id_0380::_id_6846("zmb_weap_hammer_throw_lp", undefined, self, 0.2, undefined, 0.2);
}

hammer_emp_charged() {
  _id_0380::_id_6846("zmb_weap_hammer_charged_lp", undefined, self, 0.2, undefined, 0.2);
}

zmb_shield_bash(var_0) {
  var_1 = self;

  foreach(var_3 in level.players) {
    if(var_3 == var_1) {
      var_3.plr_shield_hit_snd = _id_0380::_id_2889("zmb_wpn_shield_hit_plr", var_1, var_0);
      continue;
    }

    var_3.npc_shield_hit_snd = _id_0380::_id_2889("zmb_wpn_shield_hit_npc", undefined, var_0, undefined, 0.5);
  }
}

zmb_shield_hit() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      _id_0380::_id_288B("zmb_wpn_shield_dmg_plr", var_0, var_0);
      continue;
    }

    _id_0380::_id_288B("zmb_wpn_shield_dmg_npc", undefined, var_0, undefined, 0.5);
  }
}

zmb_shield_break() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      _id_0380::_id_288B("zmb_wpn_shield_break_plr", var_0, var_0);
      continue;
    }

    _id_0380::_id_288B("zmb_wpn_shield_break_npc", undefined, var_0, undefined, 0.5);
  }
}

zmb_bloodraven_shield_bash(var_0) {
  var_1 = self;

  foreach(var_3 in level.players) {
    if(var_3 == var_1) {
      var_3.plr_br_shield_hit_snd = _id_0380::_id_2889("zmb_wpn_bloodraven_shield_hit_plr", var_1, var_0);
      continue;
    }

    var_3.npc_br_shield_hit_snd = _id_0380::_id_2889("zmb_wpn_bloodraven_shield_hit_npc", undefined, var_0, undefined, 0.5);
  }
}

scythe_swing() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      _id_0380::_id_288B("zmb_weap_scythe_whoosh_2d", var_0, var_0);
      continue;
    }

    _id_0380::_id_288B("zmb_weap_scythe_whoosh", undefined, var_0, undefined, 0.5);
  }
}

scythe_impact() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      _id_0380::_id_288B("zmb_weap_scythe_hit_2d", var_0, var_0);
      continue;
    }

    _id_0380::_id_288B("zmb_weap_scythe_hit", undefined, var_0, undefined, 0.5);
  }
}

scythe_emp_swing() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      _id_0380::_id_288B("zmb_weap_scythe_emp_whoosh_2d", var_0, var_0);
      continue;
    }

    _id_0380::_id_288B("zmb_weap_scythe_emp_whoosh", undefined, var_0, undefined, 0.5);
  }
}

scythe_burst() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      _id_0380::_id_288B("zmb_weap_scythe_burst_2d", var_0, var_0);
      continue;
    }

    _id_0380::_id_288B("zmb_weap_scythe_burst", undefined, var_0, undefined, 0.5);
  }
}

scythe_proj_shoot() {
  if(!isDefined(self)) {
    return;
  }
  var_0 = self;

  foreach(var_2 in level.players) {
    if(var_2 == var_0) {
      _id_0380::_id_288B("zmb_weap_scythe_proj_shoot_2d", var_0, var_0);
      continue;
    }

    _id_0380::_id_288B("zmb_weap_scythe_proj_shoot", undefined, var_0, undefined, 0.5);
  }
}

scythe_proj_loop() {
  var_0 = _id_0380::_id_288B("zmb_weap_scythe_proj_lp", undefined, self);
  common_scripts\utility::waittill_notify_or_timeout("death", 3);
  _id_0380::_stoplocalsound(var_0, 1);
}

scythe_proj_impact() {
  _id_0380::_id_288B("zmb_weap_scythe_proj_imp", undefined, self);
}

scythe_charged_loop_start() {
  if(!isDefined(self.scythe_charged_loop)) {
    self.scythe_charged_loop = _id_0380::_id_288B("zmb_weap_scythe_charged_lp", self, self, 0);
  }
}

scythe_charged_loop_stop() {
  if(isDefined(self.scythe_charged_loop)) {
    _id_0380::_stoplocalsound(self.scythe_charged_loop, 0);
    waitframe();
    self.scythe_charged_loop = undefined;
  }
}

corpse_eater_soul_suck(var_0, var_1) {
  var_2 = spawn("script_origin", var_0);
  var_3 = 0;
  var_4 = 0.875;
  _id_0380::_id_288B("zombie_soul_suck", undefined, var_2, 0, var_4);
  var_2 moveTo(var_1, 1.9);
  wait 2.0;
  var_2 delete();
}

corpse_eater_fully_charged() {
  if(!isDefined(self)) {
    return;
  }
  self.transform_snd_handle = _id_0380::_id_288B("zmb_corpse_eater_transform", undefined, self);
  self.charged_up_snd_handle = _id_0380::_id_288B("zmb_corpse_eater_charged_up", undefined, self);
  self.charge_decay_snd_handle = _id_0380::_id_288B("zmb_corpse_eater_charge_decay", undefined, self, 2.5);
  self.corpse_eater_charged_lp = _id_0380::_id_6846("zmb_corpse_eater_energy_lp", undefined, self, 1.5);
}

corpse_eater_pre_explosion() {
  if(!isDefined(self)) {
    return;
  }
  self.pre_explosion_scream_snd_handle = _id_0380::_id_288B("zmb_corpse_eater_explo_scream", undefined, self);
}

corpse_eater_explosion() {
  if(!isDefined(self)) {
    return;
  }
  self.explo_snd_handle = _id_0380::_id_288B("zmb_corpse_eater_explosion", undefined, self);
}

moonorb_stuck() {
  var_0 = self;
  var_0.moonorb_stuck_lp = _id_0380::_id_6846("zmb_wpn_mstar_grnd_lp", undefined, self, 0.2, undefined, 0.3);
}

moonorb_orphaned_lp() {
  var_0 = self;
  var_0.moonorb_orphaned_lp = _id_0380::_id_6846("zmb_wpn_mstar_mind_lp", undefined, self, 0.2, undefined, 0.3);
}

moonorb_control_burst() {
  var_0 = self;
  var_0._id_8CFF = _id_0380::_id_288B("zmb_wpn_mstar_grnd_explo", undefined, self);
}

moonorb_control_lp() {
  var_0 = self;
  var_0.moon_orb_control_lp = _id_0380::_id_6846("zmb_wpn_mstar_mind_lp", undefined, self, 0.2, undefined, 0.3);
}

moonorb_teleport() {
  _id_0380::_id_288B("zmb_wpn_mstar_teleport", undefined, self);
}

dlc4_magic_poof(var_0) {
  _id_0380::_id_2889("dlc4_magic_poof", undefined, self.origin);
}

god_king_giestblast_charge() {
  _id_0380::_id_288B("zmb_gdkng_geistblast_charge", undefined, self);
}

god_king_giestblast_throw(var_0, var_1) {
  var_2 = _id_0380::_id_288B("zmb_gdkng_geistblast_fire", undefined, var_0);

  if(!isDefined(var_1)) {
    return;
  }
  var_1 waittill("projectile_impact", var_3, var_4);
  _id_0380::_stoplocalsound(var_2, 0.5);
  _id_0380::_id_2889("zmb_gdkng_geistblast_impact", undefined, var_4);
}

god_king_giestbomb_projectile(var_0, var_1) {
  switch (var_0) {
    case "spawn":
      var_1.spawn_lp = _id_0380::_id_6846("zmb_gdkng_geistbomb_spawn_orb_loop", undefined, var_1, 0.2, undefined, 0.75);
      break;
    case "activate":
      var_1.activate_strt_snd = _id_0380::_id_6844("zmb_gdkng_geistbomb_strt", undefined, var_1);
      var_1.activate_lp_snd = _id_0380::_id_6846("zmb_gdkng_geistbomb_activated_lp", undefined, var_1, 0.2, undefined, 0.5);
      break;
    case "explode":
      var_1.activate_end_snd = _id_0380::_id_6844("zmb_gdkng_geistbomb_end", undefined, var_1);
      var_1.boom_snd = _id_0380::_id_6844("zmb_gdkng_geistbomb_detonate_boom", undefined, var_1);
    default:
      break;
  }
}

god_king_pull_summon() {
  var_0 = self;
  wait 0.5;
  _id_0380::_id_288B("zmb_gdkng_pull_summon", undefined, var_0);
  wait 0.75;
  _id_0380::_id_288B("zmb_gdkng_pull_summon_b", undefined, var_0);
}

god_king_pull() {
  var_0 = self;
  _id_0380::_id_288B("zmb_gdkng_pull_detonate", undefined, var_0);
}

god_king_melee() {
  var_0 = self;
  wait 0.4;
  _id_0380::_id_288B("zmb_gdkng_melee", undefined, var_0);
}

god_king_flame_wave_runner_start(var_0, var_1) {
  var_1.flamewave_lp = _id_0380::_id_6844("zmb_gdkng_flamewave_main_lp", var_1, var_0, 0.2);
  var_1.flamewave_close_lp = _id_0380::_id_6844("zmb_gdkng_flamewave_close_sizzle_lp", var_1, var_0, 0.2);
  _id_0380::_id_288B("zmb_gdkng_flamewave_strt", var_1, var_0);
}

god_king_flame_wave_runner_stop(var_0, var_1) {
  if(isDefined(var_1.flamewave_lp)) {
    _id_0380::_id_6850(var_1.flamewave_lp, 2);
  }

  if(isDefined(var_1.flamewave_close_lp)) {
    _id_0380::_id_6850(var_1.flamewave_close_lp, 2);
  }

  wait 1;
  _id_0380::_id_288B("zmb_gdkng_flamewave_end", var_1, var_0);
}

god_king_flame_wave_runner_inside(var_0, var_1) {}

god_king_flame_wave_runner_outside(var_0, var_1) {}

god_king_giestdrain(var_0, var_1) {
  var_0 thread drain_king(var_0, var_1);

  foreach(var_3 in level.blood_plates) {
    if(_id_0547::_id_5565(var_3.setlookatent, "plate_boss_room")) {
      thread drain_plate(var_3, var_1);
    }
  }

  thread zombie_giestdrain_submix(var_0, var_1);
}

zombie_giestdrain_submix(var_0, var_1) {
  level endon("end_geistdrain_submix");
  var_1 endon("attack_geist_drain_stop");

  foreach(var_3 in level.players) {
    for(;;) {
      var_4 = _distance2d(var_3.origin, var_0.origin);

      if(var_4 < 800) {
        var_3 clientaddsoundsubmix("godking_giestdrain_mute_zvox");
      } else {
        var_3 clientclearsoundsubmix("godking_giestdrain_mute_zvox");
      }

      wait 0.2;
    }
  }
}

drain_king(var_0, var_1) {
  var_1 endon("attack_geist_drain_stop");

  for(;;) {
    var_2 = _id_0380::_id_6842("zmb_gdkng_drain", undefined, var_0.origin);
    wait 1;
  }
}

drain_plate(var_0, var_1) {
  var_0 endon("drain_ended");
  var_0 endon("plate_destroyed");
  thread blood_plate_drain_blood(var_0);

  for(;;) {
    var_0.soul_snd = _id_0380::_id_6842("zmb_gdkng_drain", undefined, var_0.plate_model.origin);
    wait 1;
  }
}

blood_plate_drain_blood(var_0) {
  var_0.blood_strt = _id_0380::_id_2889("zmb_gdkng_drain_blood_strt", undefined, var_0.plate_model.origin);
  var_0.blood_lp = _id_0380::_id_6842("zmb_gdkng_drain_blood_lp", undefined, var_0.plate_model.origin, 0.3);
  var_0 common_scripts\utility::_id_A70A("drain_ended", "plate_destroyed");
  _id_0380::_id_6850(var_0.blood_lp, 0.5);
  var_0.blood_stop = _id_0380::_id_2889("zmb_gdkng_drain_blood_end", undefined, var_0.plate_model.origin);
}

god_king_giestdrain_plate_destroyed() {
  var_0 = self;
  var_0.destroyed_snd = _id_0380::_id_288B("zmb_gdkng_absorb_success_end", undefined, var_0);
}

clear_mute_zvox_for_drain() {
  level notify("end_geistdrain_submix");

  foreach(var_1 in level.players) {
    var_1 clientclearsoundsubmix("godking_giestdrain_mute_zvox");
  }
}

god_king_sun_cast() {
  var_0 = self;
  _id_0380::_id_288B("zmb_gdk_spell_sun_charge_start_main", undefined, var_0);
  _id_0380::_id_6846("zmb_gdk_spell_sun_charge_lp", undefined, var_0, 0.2, undefined, 0.5);
}

god_king_sun_blast() {
  _id_0380::_id_288B("zmb_gdk_spell_sun_strike_main", undefined, self);
}

god_king_sun_blast_hit_plr(var_0) {
  _id_0380::_id_288B("zmb_gdk_spell_sun_strike_plr_hit", var_0, self);
}

god_king_lightning_summon() {
  _id_0380::_id_288B("zmb_gdk_spell_lightning_charge_main", undefined, self);
}

god_king_lightning() {
  _id_0380::_id_288B("zmb_gdk_spell_lightning_main", undefined, self);
}

god_king_detonate_cast() {
  var_0 = self;
  wait 0.3;
  _id_0380::_id_288B("zmb_gdkng_summon_generic", undefined, var_0);
}

god_king_detonate_throw(var_0) {
  var_1 = self;
  var_1.drain_ent = spawn("script_origin", var_1.origin);
  var_1.beam_snd = _id_0380::_id_288B("zmb_gdkng_drain", undefined, var_1.drain_ent);
  var_1.drain_ent moveTo(var_0.origin, 1.5);
  wait 1.6;
  var_1.drain_ent delete();
}

god_king_force_summon() {
  var_0 = _id_0380::_id_6844("zmb_gdkng_absorb_lp", undefined, self, 0.3);
  self waittill("notify_force_unleash");
  wait 1.0;
  _id_0380::_id_6850(var_0, 0.3);
  _id_0380::_id_288B("zmb_gdkng_force", undefined, self);
}

god_king_force_kneel() {
  wait 1;

  foreach(var_1 in level.players) {
    _id_0380::_id_2888("zmb_gdkng_kneel", var_1);
  }
}

god_king_finale_drain_first() {
  self endon("death");
  level endon("aud_stop_godking_finale_sfx");
  _id_0380::_id_6844("zmb_gdkng_giest_finale_buildup", undefined, self);
  wait 0.5;
  level._id_11CB.final_drain_lp = _id_0380::_id_6844("zmb_gdkng_giest_finale_lp", undefined, self);
  thread finale_elec_oneshots();
  thread finale_whoosh_oneshots();
}

finale_elec_oneshots() {
  self endon("death");
  level endon("aud_stop_godking_finale_sfx");
  wait 3;

  for(;;) {
    var_0 = _randomintrange(5, 8);
    var_1 = self.origin + (_randomintrange(-200, 200), _randomintrange(-200, 200), 0);
    _id_0380::_id_2889("zmb_gdkng_giest_finale_elec_oneshot", undefined, var_1);
    wait(var_0);
  }
}

finale_whoosh_oneshots() {
  self endon("death");
  level endon("aud_stop_godking_finale_sfx");
  wait 3;

  for(;;) {
    var_0 = _randomintrange(4, 9);
    var_1 = self.origin + (_randomintrange(-200, 200), _randomintrange(-200, 200), 0);
    _id_0380::_id_2889("zmb_gdkng_giest_finale_whoosh_oneshot", undefined, var_1);
    wait(var_0);
  }
}

god_king_finale_melee() {
  wait 2;
  _id_0380::_id_288B("zmb_gdkng_melee", undefined, self);
}

god_king_finale_drain_end() {
  _id_0380::_id_6850(level._id_11CB.final_drain_lp, 0.5);
  _id_0380::_id_288B("zmb_gdkng_giest_finale_end", undefined, self);
  level notify("aud_stop_godking_finale_sfx");
}

god_king_death() {
  wait 7;
  _id_0380::_id_288B("zmb_gdkng_finale_death_fx_into", undefined, self);
}