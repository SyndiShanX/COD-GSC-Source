/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_castle_ee_bossfight.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace zm_castle_ee_bossfight;

function autoexec __init__sytem__() {
  system::register("zm_castle_ee_bossfight", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "player_snow_fx_off", 5000, 1, "counter", &player_snow_fx_off, 0, 0);
  clientfield::register("actor", "boss_skeleton_eye_glow_fx_change", 5000, 1, "counter", &boss_skeleton_eye_glow_fx_change, 0, 0);
  level._effect["boss_skeleton_eye_glow"] = "dlc1/castle/fx_glow_eye_orange_skeleton";
  clientfield::register("scriptmover", "boss_mpd_fx", 5000, 1, "int", &boss_mpd_fx, 0, 0);
  level._effect["boss_mpd_mist"] = "dlc1/castle/fx_ee_keeper_small_mist_trail";
  level._effect["boss_mpd_mouth"] = "dlc1/castle/fx_ee_keeper_small_mouth_glow";
  clientfield::register("scriptmover", "boss_fx", 5000, 1, "int", &boss_fx, 0, 0);
  clientfield::register("scriptmover", "boss_weak_point_shader", 5000, 1, "int", &boss_weak_point_shader, 0, 0);
  clientfield::register("actor", "boss_zombie_rise_fx", 1, 1, "int", &boss_zombie_rise_fx, 1, 1);
  level._effect["boss_mist"] = "dlc1/castle/fx_ee_keeper_mist_trail";
  level._effect["boss_mouth"] = "dlc1/castle/fx_ee_keeper_mouth_glow";
  level._effect["boss_rise_burst"] = "dlc1/castle/fx_ee_keeper_hand_burst_zmb";
  level._effect["boss_rise_billow"] = "dlc1/castle/fx_ee_keeper_body_billowing_zmb";
  clientfield::register("scriptmover", "boss_teleport_fx", 5000, 1, "counter", &boss_teleport_fx, 0, 0);
  level._effect["boss_teleport"] = "dlc1/castle/fx_ee_keeper_teleport";
  clientfield::register("scriptmover", "boss_elemental_storm_cast_fx", 5000, 1, "int", &boss_elemental_storm_cast_fx, 0, 0);
  clientfield::register("scriptmover", "boss_elemental_storm_explode_fx", 5000, 1, "int", &boss_elemental_storm_explode_fx, 0, 0);
  clientfield::register("scriptmover", "boss_elemental_storm_stunned_keeper_fx", 5000, 1, "int", &boss_elemental_storm_stunned_keeper_fx, 0, 0);
  clientfield::register("scriptmover", "boss_elemental_storm_stunned_spikes_fx", 5000, 1, "int", &boss_elemental_storm_stunned_spikes_fx, 0, 0);
  level._effect["boss_elemental_storm_cast"] = "dlc1/castle/fx_ee_keeper_storm_tell";
  level._effect["boss_elemental_storm_explode_loop"] = "dlc1/zmb_weapon/fx_bow_storm_funnel_loop_zmb";
  level._effect["boss_elemental_storm_explode_end"] = "dlc1/zmb_weapon/fx_bow_storm_funnel_end_zmb";
  level._effect["boss_elemental_storm_stunned_spikes"] = "dlc1/castle/fx_ee_keeper_beam_stunned_src";
  level._effect["boss_elemental_storm_stunned_keeper"] = "dlc1/castle/fx_ee_keeper_beam_stunned_tgt";
  clientfield::register("scriptmover", "boss_demongate_cast_fx", 5000, 1, "int", &boss_demongate_cast_fx, 0, 0);
  clientfield::register("scriptmover", "boss_demongate_chomper_fx", 5000, 1, "int", &boss_demongate_chomper_fx, 0, 0);
  clientfield::register("scriptmover", "boss_demongate_chomper_bite_fx", 5000, 1, "counter", &boss_demongate_chomper_bite_fx, 0, 0);
  level._effect["boss_demongate_portal_open"] = "dlc1/castle/fx_ee_keeper_demongate_portal_open";
  level._effect["boss_demongate_portal_loop"] = "dlc1/castle/fx_ee_keeper_demongate_portal_loop";
  level._effect["boss_demongate_portal_close"] = "dlc1/castle/fx_ee_keeper_demongate_portal_close";
  level._effect["boss_demongate_chomper_trail"] = "dlc1/castle/fx_ee_keeper_demonhead_trail";
  level._effect["boss_demongate_chomper_bite"] = "dlc1/castle/fx_ee_keeper_demonhead_despawn";
  level._effect["boss_demongate_chomper_despawn"] = "dlc1/castle/fx_ee_keeper_demonhead_despawn";
  clientfield::register("scriptmover", "boss_rune_prison_erupt_fx", 5000, 1, "int", &boss_rune_prison_erupt_fx, 0, 0);
  clientfield::register("scriptmover", "boss_rune_prison_rock_fx", 5000, 1, "int", &boss_rune_prison_rock_fx, 0, 0);
  clientfield::register("scriptmover", "boss_rune_prison_explode_fx", 5000, 1, "int", &boss_rune_prison_explode_fx, 0, 0);
  clientfield::register("allplayers", "boss_rune_prison_dot_fx", 5000, 1, "int", &boss_rune_prison_dot_fx, 0, 0);
  clientfield::register("world", "sndBossBattle", 5000, 1, "int", &sndbossbattle, 0, 0);
  level._effect["boss_rune_prison_erupt"] = "dlc1/castle/fx_ee_keeper_runeprison_glow";
  level._effect["boss_rune_prison_explode"] = "dlc1/castle/fx_ee_keeper_runeprison_fire";
  level._effect["boss_rune_prison_dot"] = "dlc1/zmb_weapon/fx_bow_rune_fire_torso_zmb";
  clientfield::register("world", "boss_wolf_howl_fx_change", 5000, 1, "int", &boss_wolf_howl_fx_change, 0, 0);
  clientfield::register("world", "boss_gravity_spike_fx_change", 5000, 1, "int", &boss_gravity_spike_fx_change, 0, 0);
}

function player_snow_fx_off(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(level.var_18402cb[localclientnum])) {
    deletefx(localclientnum, level.var_18402cb[localclientnum], 1);
    level.var_18402cb[localclientnum] = undefined;
  }
}

function boss_skeleton_eye_glow_fx_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self._eyeglow_fx_override = level._effect["boss_skeleton_eye_glow"];
}

function boss_mpd_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_3b5b8133 = playFXOnTag(localclientnum, level._effect["boss_mpd_mist"], self, "j_spinelower");
    self.var_20e08654 = playFXOnTag(localclientnum, level._effect["boss_mpd_mist"], self, "j_robe_front_03");
    self.var_40ad10ca = playFXOnTag(localclientnum, level._effect["boss_mpd_mouth"], self, "j_head");
  } else {
    if(isDefined(self.var_3b5b8133)) {
      deletefx(localclientnum, self.var_3b5b8133, 0);
      self.var_3b5b8133 = undefined;
    }
    if(isDefined(self.var_20e08654)) {
      deletefx(localclientnum, self.var_20e08654, 0);
      self.var_20e08654 = undefined;
    }
    if(isDefined(self.var_40ad10ca)) {
      deletefx(localclientnum, self.var_40ad10ca, 0);
      self.var_40ad10ca = undefined;
    }
  }
}

function boss_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_3b5b8133 = playFXOnTag(localclientnum, level._effect["boss_mist"], self, "j_spinelower");
    self.var_20e08654 = playFXOnTag(localclientnum, level._effect["boss_mist"], self, "j_robe_front_03");
    self.var_40ad10ca = playFXOnTag(localclientnum, level._effect["boss_mouth"], self, "j_head");
  } else {
    if(isDefined(self.var_3b5b8133)) {
      deletefx(localclientnum, self.var_3b5b8133, 0);
      self.var_3b5b8133 = undefined;
    }
    if(isDefined(self.var_20e08654)) {
      deletefx(localclientnum, self.var_20e08654, 0);
      self.var_20e08654 = undefined;
    }
    if(isDefined(self.var_40ad10ca)) {
      deletefx(localclientnum, self.var_40ad10ca, 0);
      self.var_40ad10ca = undefined;
    }
  }
}

function boss_weak_point_shader(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    var_79974a0f = 0;
    if(isDefined(self.sndid)) {
      self stoploopsound(self.sndid, 1);
      self.sndid = undefined;
    }
  } else {
    var_79974a0f = 1;
    if(!isDefined(self.sndid)) {
      self.sndid = self playLoopSound("zmb_keeper_downed_lp", 1);
    }
  }
  self mapshaderconstant(localclientnum, 0, "scriptVector3", 0, var_79974a0f, 0, 0);
}

function boss_zombie_rise_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon("demo_jump");
  self endon("entityshutdown");
  if(newval) {
    localplayers = level.localplayers;
    var_f7130542 = "zmb_zombie_spawn";
    var_7bc37da8 = level._effect["boss_rise_burst"];
    var_ee65ea53 = level._effect["boss_rise_billow"];
    playSound(0, var_f7130542, self.origin);
    for(i = 0; i < localplayers.size; i++) {
      self thread function_200d4bd2(i, var_ee65ea53, var_7bc37da8);
    }
  }
}

function function_200d4bd2(localclientnum, var_ee65ea53, var_7bc37da8) {
  self endon("entityshutdown");
  level endon("demo_jump");
  playFX(localclientnum, var_7bc37da8, self.origin + (0, 0, randomintrange(5, 10)));
  wait(0.25);
  playFX(localclientnum, var_ee65ea53, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
}

function boss_teleport_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_b1fe1ee = playFXOnTag(localclientnum, level._effect["boss_teleport"], self, "j_mainroot");
  wait(0.5);
  if(isDefined(self.var_b1fe1ee)) {
    deletefx(localclientnum, self.var_b1fe1ee, 0);
    self.var_b1fe1ee = undefined;
  }
}

function boss_elemental_storm_cast_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self playSound(0, "zmb_keeper_storm_cast");
    self function_4278d80d(localclientnum);
  } else {
    self notify("hash_1c2dfa5e");
    if(isDefined(self.var_b1fe1ee)) {
      deletefx(localclientnum, self.var_b1fe1ee, 0);
      self.var_b1fe1ee = undefined;
    }
    if(isDefined(self.var_64741ec0)) {
      self stoploopsound(self.var_64741ec0, 4);
      self.var_64741ec0 = undefined;
    }
  }
}

function function_4278d80d(localclientnum) {
  self endon("hash_1c2dfa5e");
  while(isDefined(self)) {
    if(isDefined(self.var_b1fe1ee)) {
      deletefx(localclientnum, self.var_b1fe1ee, 0);
      self.var_b1fe1ee = undefined;
    }
    if(!isDefined(self.var_64741ec0)) {
      self.var_64741ec0 = self playLoopSound("zmb_keeper_storm_cast_lp", 0.5);
    }
    self.var_b1fe1ee = playFXOnTag(localclientnum, level._effect["boss_elemental_storm_cast"], self, "tag_origin");
    wait(0.5);
  }
}

function boss_elemental_storm_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self.var_b1fe1ee)) {
      deletefx(localclientnum, self.var_b1fe1ee, 0);
      self.var_53f7dac0 = undefined;
    }
    self.var_b1fe1ee = playFXOnTag(localclientnum, level._effect["boss_elemental_storm_explode_loop"], self, "tag_origin");
  } else {
    if(isDefined(self.var_b1fe1ee)) {
      deletefx(localclientnum, self.var_b1fe1ee, 0);
      self.var_53f7dac0 = undefined;
    }
    wait(0.4);
    self.var_53f7dac0 = playFXOnTag(localclientnum, level._effect["boss_elemental_storm_explode_end"], self, "tag_origin");
  }
}

function boss_elemental_storm_stunned_spikes_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_ee45d30a = playFXOnTag(localclientnum, level._effect["boss_elemental_storm_stunned_spikes"], self, "tag_origin");
  } else if(isDefined(self.var_ee45d30a)) {
    deletefx(localclientnum, self.var_ee45d30a, 0);
    self.var_b1fe1ee = undefined;
  }
}

function boss_elemental_storm_stunned_keeper_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_ee45d30a = playFXOnTag(localclientnum, level._effect["boss_elemental_storm_stunned_keeper"], self, "j_spinelower");
  } else if(isDefined(self.var_ee45d30a)) {
    deletefx(localclientnum, self.var_ee45d30a, 0);
    self.var_b1fe1ee = undefined;
  }
}

function boss_demongate_cast_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_fd0edd83 = playFXOnTag(localclientnum, level._effect["boss_demongate_portal_open"], self, "tag_weapon_right");
    self.var_4b6fd850 = self playLoopSound("zmb_keeper_demongate_portal_lp", 1);
    wait(0.45);
    self.var_fd0edd83 = playFXOnTag(localclientnum, level._effect["boss_demongate_portal_loop"], self, "tag_weapon_right");
  } else {
    if(isDefined(self.var_fd0edd83)) {
      playFX(localclientnum, level._effect["boss_demongate_portal_close"], self.origin, anglesToForward(self.angles));
    }
    if(isDefined(self.var_4b6fd850)) {
      self stoploopsound(self.var_4b6fd850, 1);
      self.var_4b6fd850 = undefined;
    }
    wait(0.45);
    deletefx(localclientnum, self.var_fd0edd83, 0);
    self.var_fd0edd83 = undefined;
  }
}

function boss_demongate_chomper_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  if(newval) {
    if(isDefined(self.var_a581816a)) {
      deletefx(localclientnum, self.var_a581816a, 1);
    }
    self.var_a581816a = playFXOnTag(localclientnum, level._effect["boss_demongate_chomper_trail"], self, "tag_fx");
    self.var_965cdbdb = self playLoopSound("zmb_keeper_demongate_chomper_lp", 1);
  } else {
    if(isDefined(self.var_a581816a)) {
      deletefx(localclientnum, self.var_a581816a, 0);
      self.var_a581816a = undefined;
    }
    if(isDefined(self.var_965cdbdb)) {
      self stoploopsound(self.var_965cdbdb, 0.5);
      self.var_965cdbdb = undefined;
    }
    self playSound(0, "zmb_keeper_demongate_chomper_disappear");
    playFXOnTag(localclientnum, level._effect["boss_demongate_chomper_despawn"], self, "tag_fx");
  }
}

function boss_demongate_chomper_bite_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_64b4f506 = playFX(localclientnum, level._effect["boss_demongate_chomper_bite"], self.origin);
  self playSound(0, "zmb_keeper_demongate_chomper_bite");
  wait(0.1);
  stopfx(localclientnum, self.var_64b4f506);
}

function boss_rune_prison_erupt_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_92f90eb7(localclientnum);
  } else {
    self notify("hash_f40e20dc");
    if(isDefined(self.var_b1fe1ee)) {
      deletefx(localclientnum, self.var_b1fe1ee, 1);
      self.var_b1fe1ee = undefined;
    }
  }
}

function function_92f90eb7(localclientnum) {
  self endon("hash_f40e20dc");
  self endon("entityshutdown");
  while(true) {
    self.var_b1fe1ee = playFX(localclientnum, level._effect["boss_rune_prison_erupt"], self.origin);
    wait(1);
    if(isDefined(self) && isDefined(self.var_b1fe1ee)) {
      deletefx(localclientnum, self.var_b1fe1ee, 0);
      self.var_b1fe1ee = undefined;
    } else if(!isDefined(self)) {
      return;
    }
  }
}

function boss_rune_prison_rock_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 0: {
      self scene::play("p7_fxanim_zm_bow_rune_prison_red_01_bundle");
      self scene::stop(1);
      break;
    }
    case 1: {
      self thread scene::init("p7_fxanim_zm_bow_rune_prison_red_01_bundle");
      break;
    }
  }
}

function boss_rune_prison_explode_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playFX(localclientnum, level._effect["boss_rune_prison_explode"], self.origin, (0, 0, 1), (1, 0, 0));
  }
}

function boss_rune_prison_dot_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_1892be10 = playFXOnTag(localclientnum, level._effect["boss_rune_prison_dot"], self, "j_spine4");
  } else {
    deletefx(localclientnum, self.var_1892be10, 0);
  }
}

function boss_wolf_howl_fx_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level._effect["dog_trail_fire"] = "dlc1/castle/fx_ee_keeper_dog_fire_trail";
  } else {
    level._effect["dog_trail_fire"] = "zombie/fx_dog_fire_trail_zmb";
  }
}

function boss_gravity_spike_fx_change(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level._effect["gravityspikes_trap_start"] = "dlc1/castle/fx_ee_keeper_wpn_spike_trap_start";
    level._effect["gravityspikes_trap_loop"] = "dlc1/castle/fx_ee_keeper_wpn_spike_trap_loop";
  } else {
    level._effect["gravityspikes_trap_start"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_start";
    level._effect["gravityspikes_trap_loop"] = "dlc1/zmb_weapon/fx_wpn_spike_trap_loop";
  }
}

function sndbossbattle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level notify("hash_51d7bc7c", "bossbattle");
    audio::snd_set_snapshot("zmb_castle_bossbattle");
    playSound(0, "zmb_keeper_trans_into");
  } else {
    level notify("hash_51d7bc7c", "crypt");
    audio::snd_set_snapshot("default");
    playSound(0, "zmb_keeper_trans_outof");
  }
}