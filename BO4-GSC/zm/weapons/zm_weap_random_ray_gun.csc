/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_random_ray_gun.csc
*************************************************/

#include scripts\core_common\animation_shared;
#include scripts\core_common\audio_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\scene_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace ww_random_ray_gun;

autoexec __init__system__() {
  system::register(#"mansion_ww", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("scriptmover", "" + #"hash_64f62d9a3170948e", 1, 1, "int", &shrink_globe, 0, 0);
  clientfield::register("actor", "" + #"hash_6848ec3d200d443b", 1, 1, "int", &shrink_zombie, 0, 0);
  clientfield::register("vehicle", "" + #"hash_6848ec3d200d443b", 1, 1, "int", &shrink_zombie, 0, 0);
  clientfield::register("actor", "" + #"hash_6f59675863e19a50", 1, 1, "int", &function_d8cf1bd7, 0, 0);
  clientfield::register("vehicle", "" + #"hash_6f59675863e19a50", 1, 1, "int", &function_d8cf1bd7, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_32156a79f13e8c37", 1, 1, "int", &function_751c64a4, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_30c86f39ae8ea002", 1, 1, "int", &function_7fe3e4c8, 0, 0);
  clientfield::register("actor", "" + #"hash_1dd40649a6474f30", 1, 1, "int", &function_1af615a9, 0, 0);
  clientfield::register("vehicle", "" + #"hash_1dd40649a6474f30", 1, 1, "int", &function_1af615a9, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_12b19992ccb300e7", 1, 1, "int", &function_ac54fdec, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_54fdcf7f8eb5449e", 1, 1, "int", &drag_portal, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_69b312bcaae6308b", 1, 1, "int", &function_68a87cde, 0, 0);
  clientfield::register("actor", "" + #"hash_2ff818c8cb4c17ba", 1, 1, "int", &function_332e7c58, 0, 0);
  clientfield::register("vehicle", "" + #"hash_2ff818c8cb4c17ba", 1, 1, "int", &function_3b7e3b9, 0, 0);
  clientfield::register("actor", "" + #"hash_3bedaaea2c17af23", 1, 1, "int", &function_dd9a8d7c, 0, 0);
  clientfield::register("vehicle", "" + #"hash_3bedaaea2c17af23", 1, 1, "int", &function_51595e12, 0, 0);
}

shrink_globe(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  v_up = (360, 0, 0);
  v_forward = (0, 0, 360);

  if(newval == 1) {
    self.fx_globe = playFX(localclientnum, "zm_weapons/fx8_www_shrink_globe", self.origin, v_forward, v_up);

    if(!isDefined(self.var_66db8b1a)) {
      self playSound(localclientnum, #"hash_fe927ec8b31e2d");
      self.var_66db8b1a = self playLoopSound(#"hash_57b1409fb6e001f3");
    }

    return;
  }

  if(isDefined(self.fx_globe)) {
    stopfx(localclientnum, self.fx_globe);
    self.fx_globe = undefined;
  }

  playFX(localclientnum, "zm_weapons/fx8_www_shrink_globe_death", self.origin, v_forward, v_up);

  if(isDefined(self.var_66db8b1a)) {
    self stoploopsound(self.var_66db8b1a);
    self.var_66db8b1a = undefined;
    self playSound(localclientnum, #"hash_12c7ff63913e6a34");
  }
}

shrink_zombie(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread function_847080fa(localclientnum);
  }
}

function_847080fa(localclientnum) {
  e_model = util::spawn_anim_model(localclientnum, self.model, self.origin, self.angles);

  if(!isDefined(e_model)) {
    return;
  }

  self.var_d8b9c4bf = 1;

  if(isDefined(self.head)) {
    e_model attach(self.head, "J_Head");
  }

  playSound(localclientnum, #"hash_1b7646cdadf52c4d", self.origin + (0, 0, 35));

  switch (self.archetype) {
    case #"zombie":
      var_99d5ab4f = #"aib_t8_zm_zombie_base_dth_shrink_ww_wkud";
      break;
    case #"nosferatu":
      var_99d5ab4f = #"aib_t8_zm_nfrtu_dth_shrink_ww_wkud";
      break;
    case #"bat":
      var_99d5ab4f = #"aib_t8_zm_bat_dth_shrink_ww_wkud";
      break;
  }

  if(isDefined(var_99d5ab4f)) {
    e_model thread scene::play(var_99d5ab4f, e_model);
  }

  var_1f698175 = 1;
  var_cf6d072d = 0.02;

  while(var_1f698175 > 0.1) {
    waitframe(1);
    var_1f698175 -= var_cf6d072d;

    if(var_1f698175 > 0) {
      e_model setscale(var_1f698175);
    }

    var_cf6d072d *= 1.00433;
  }

  playSound(localclientnum, #"hash_6abe8c2d3548831c", e_model.origin + (0, 0, 35));
  playFX(localclientnum, "zm_weapons/fx8_www_shrink_enemy_death", e_model.origin + (0, 0, 35));
  e_model delete();
}

function_d8cf1bd7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_121a6632)) {
    stopfx(localclientnum, self.var_121a6632);
    self.var_121a6632 = undefined;
  }

  if(newval) {
    self.var_121a6632 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_shrink_enemy_torso", self, "j_spine4");
  }
}

function_751c64a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  v_up = (360, 0, 0);
  v_forward = (0, 0, 360);

  if(!isDefined(self.sound_origin)) {
    self.sound_origin = self.origin + (0, 0, 50);
  }

  if(newval == 1) {
    self.registerplayer_lift_clipbamfupdate = playFX(localclientnum, "zm_weapons/fx8_www_dazed_vortex", self.origin, v_forward, v_up);
    playSound(localclientnum, #"hash_65790bfd14f9d80e", self.sound_origin);
    audio::playloopat(#"hash_23133277b3364bd2", self.sound_origin);
    return;
  }

  if(isDefined(self.registerplayer_lift_clipbamfupdate)) {
    stopfx(localclientnum, self.registerplayer_lift_clipbamfupdate);
    self.registerplayer_lift_clipbamfupdate = undefined;
  }

  v_origin = self.origin;
  playSound(localclientnum, #"hash_1bb8f665af965ffb", self.sound_origin);
  audio::stoploopat(#"hash_23133277b3364bd2", self.sound_origin);
  wait 1;
  playFX(localclientnum, "zm_weapons/fx8_www_dazed_vortex_end", v_origin, v_forward, v_up);
}

function_7fe3e4c8(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_22166a07 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_dazed_bubble_trail", self, "tag_eye");
    return;
  }

  if(isDefined(self.var_22166a07)) {
    stopfx(localclientnum, self.var_22166a07);
    self.var_22166a07 = undefined;
  }
}

function_1af615a9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    sound_origin = self gettagorigin("j_head");
    playSound(localclientnum, #"hash_483ba5ccc74b82ae", sound_origin);
    self.var_3403f7a9 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_dazed_enemy_glow_eye", self, "j_head");
    return;
  }

  if(isDefined(self.var_3403f7a9)) {
    stopfx(localclientnum, self.var_3403f7a9);
    self.var_3403f7a9 = undefined;
  }
}

function_ac54fdec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    v_up = (360, 0, 0);
    v_forward = (0, 0, 360);
    self.fx_tornado = playFX(localclientnum, "zm_weapons/fx8_www_spin_tornado", self.origin, v_forward, v_up);

    if(!isDefined(self.sound_origin)) {
      self.sound_origin = self.origin + (0, 0, 50);
      playSound(localclientnum, #"hash_2d629f848398a470", self.sound_origin);
      audio::playloopat(#"hash_5a6410f04ce4b3a0", self.sound_origin);
    }

    return;
  }

  if(isDefined(self.sound_origin)) {
    playSound(localclientnum, #"hash_49211352d3711451", self.sound_origin);
    audio::stoploopat(#"hash_5a6410f04ce4b3a0", self.sound_origin);
  }

  if(isDefined(self.fx_tornado)) {
    stopfx(localclientnum, self.fx_tornado);
    self.fx_tornado = undefined;
  }
}

drag_portal(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.fx_portal = util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_portal", self, "tag_origin");

    if(!isDefined(self.sound_origin)) {
      self.sound_origin = self.origin + (0, 0, 50);
      playSound(localclientnum, #"hash_457eb103eafefe25", self.sound_origin);
      audio::playloopat(#"hash_31a9e607641ce8eb", self.sound_origin);
      self thread function_872ccd5b(#"hash_31a9e607641ce8eb", #"hash_3ab7968f3d5362bc");
    }

    return;
  }

  if(isDefined(self.sound_origin)) {
    self notify(#"hash_d35390d5b5c613b");
    playSound(localclientnum, #"hash_3ab7968f3d5362bc", self.sound_origin);
    audio::stoploopat(#"hash_31a9e607641ce8eb", self.sound_origin);
  }

  if(isDefined(self.fx_portal)) {
    killfx(localclientnum, self.fx_portal);
    self.fx_portal = undefined;
  }

  util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_portal_end", self, "tag_origin");
}

function_872ccd5b(var_ff3c5ccc, var_fc01b069) {
  self endon(#"hash_d35390d5b5c613b");
  a_origin = self.sound_origin;
  self waittill(#"death");
  playSound(0, var_fc01b069, a_origin);
  audio::stoploopat(var_ff3c5ccc, a_origin);
}

function_68a87cde(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_39a7e416)) {
    stopfx(localclientnum, self.var_39a7e416);
    self.var_39a7e416 = undefined;
  }

  if(newval) {
    self.var_39a7e416 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_ash_trail", self, "tag_origin");
  }
}

function_332e7c58(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_9fe38370(localclientnum, newval, "j_spine4");
}

function_3b7e3b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_9fe38370(localclientnum, newval, "tag_chest_ws");
}

function_9fe38370(localclientnum, newval, str_tag) {
  if(isDefined(self.var_4b8417f6)) {
    stopfx(localclientnum, self.var_4b8417f6);
    self.var_4b8417f6 = undefined;
  }

  if(newval) {
    self.var_4b8417f6 = util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_torso", self, str_tag);

    if(self.archetype === #"zombie" || self.archetype === #"nosferatu") {
      self thread function_84884488(localclientnum);
    }

    self playSound(localclientnum, #"hash_71ccbe40ffaafe22");
  }
}

function_84884488(localclientnum) {
  self endon(#"death");
  self zm_utility::good_barricade_damaged(localclientnum);
  wait 0.7;
  self playrenderoverridebundle(#"hash_429426f01ad84c8b");
  wait 0.7;

  if(self.archetype === #"zombie" || self.archetype === #"catalyst" || self.archetype === #"nosferatu") {
    if(!isDefined(level.var_4fea6622)) {
      level.var_4fea6622 = 0;
    }

    self thread function_30c6d85();
    util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_torso", self, "j_spine4");
    util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_waist", self, "j_spinelower");
    util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_head", self, "j_head");

    if(level.var_4fea6622 < 9) {
      util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_arm_left", self, "j_elbow_le");
      util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_arm_right", self, "j_elbow_ri");
      util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_hip_left", self, "j_hip_le");
      util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_hip_right", self, "j_hip_ri");
      util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_leg_left", self, "j_knee_le");
      util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_leg_right", self, "j_knee_ri");
      return;
    }

    if(level.var_4fea6622 < 17) {
      if(math::cointoss()) {
        util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_arm_left", self, "j_elbow_le");
      } else {
        util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_arm_right", self, "j_elbow_ri");
      }

      if(math::cointoss()) {
        util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_hip_left", self, "j_hip_le");
        return;
      }

      util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_ember_hip_right", self, "j_hip_ri");
    }
  }
}

function_30c6d85() {
  level.var_4fea6622++;

  iprintlnbold("<dev string:x38>" + level.var_4fea6622);

    self waittilltimeout(1.2, #"death");
  level.var_4fea6622--;

  iprintlnbold("<dev string:x4f>" + level.var_4fea6622);

}

function_dd9a8d7c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_df636944(localclientnum, newval, "j_spine4");
}

function_51595e12(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_df636944(localclientnum, newval, "tag_chest_ws");
}

function_df636944(localclientnum, newval, str_tag) {
  util::playFXOnTag(localclientnum, "zm_weapons/fx8_www_drag_enemy_death", self, str_tag);
}