/***********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_napalmburst.csc
***********************************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace ammomod_napalmburst;

function init_napalmburst() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  aat::register("ammomod_napalmburst", #"zmui/zm_ammomod_napalmburst", "ui_icon_zombie_ammomod_napalmburst_stacked");
  aat::register("ammomod_napalmburst_1", #"zmui/zm_ammomod_napalmburst", "ui_icon_zombie_ammomod_napalmburst_stacked");
  aat::register("ammomod_napalmburst_2", #"zmui/zm_ammomod_napalmburst", "ui_icon_zombie_ammomod_napalmburst_stacked");
  aat::register("ammomod_napalmburst_3", #"zmui/zm_ammomod_napalmburst", "ui_icon_zombie_ammomod_napalmburst_stacked");
  aat::register("ammomod_napalmburst_4", #"zmui/zm_ammomod_napalmburst", "ui_icon_zombie_ammomod_napalmburst_stacked");
  aat::register("ammomod_napalmburst_5", #"zmui/zm_ammomod_napalmburst", "ui_icon_zombie_ammomod_napalmburst_stacked");
  clientfield::register("actor", "zm_ammomod_napalmburst_explosion", 1, 1, "counter", &function_c8e3a0dc, 0, 0);
  clientfield::register("vehicle", "zm_ammomod_napalmburst_explosion", 1, 1, "counter", &function_c8e3a0dc, 0, 0);
  clientfield::register("actor", "zm_ammomod_napalmburst_burn", 1, 1, "int", &function_f3b43353, 0, 0);
  clientfield::register("vehicle", "zm_ammomod_napalmburst_burn", 1, 1, "int", &function_2d64f265, 0, 0);
  clientfield::register("toplayer", "ammomod_napalmburst_proc", 1, 1, "counter", &function_15482148, 1, 0);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_left", "j_shoulder_le", 32);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_right", "j_shoulder_ri", 16);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_head", "j_head", 8);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_left", "j_hip_le", 256);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_right", "j_hip_ri", 128);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_left", "j_knee_le", 256);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_right", "j_knee_ri", 128);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_waist", "j_spinelower", undefined);
  function_c487d6b1(#"zombie", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_torso", "j_spine4", undefined);
  function_c487d6b1(#"zombie_dog", "zm_weapons/fx9_aat_burnination_lvl1_fire_hound_torso", "j_spine4", undefined);
  function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_hip_left", "j_hip_le", 256);
  function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_hip_right", "j_hip_ri", 128);
  function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_leg_left", "j_knee_le", 256);
  function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_leg_right", "j_knee_ri", 128);
  function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_waist", "j_spinelower", undefined);
  function_c487d6b1(#"raz", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_torso", "j_spine4", undefined);
  function_c487d6b1(#"mimic", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_hip_left", "j_hip_le", 256);
  function_c487d6b1(#"mimic", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_hip_right", "j_hip_ri", 128);
  function_c487d6b1(#"mimic", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_leg_left", "j_knee_le", 256);
  function_c487d6b1(#"mimic", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_leg_right", "j_knee_ri", 128);
  function_c487d6b1(#"mimic", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_waist", "j_spinelower", undefined);
  function_c487d6b1(#"mimic", "zm_weapons/fx9_aat_burnination_lvl1_fire_raz_torso", "j_spine4", undefined);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_left", "j_shoulder_le", 32);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_right", "j_shoulder_ri", 16);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_head", "j_head", 8);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_left", "j_hip_le", 256);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_right", "j_hip_ri", 128);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_left", "j_knee_le", 256);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_right", "j_knee_ri", 128);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_waist", "j_spinelower", undefined);
  function_c487d6b1(#"avogadro", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_torso", "j_spine4", undefined);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_left", "j_shoulder_le", 32);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_right", "j_shoulder_ri", 16);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_head", "j_head", 8);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_left", "j_hip_le", 256);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_right", "j_hip_ri", 128);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_left", "j_knee_le", 256);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_right", "j_knee_ri", 128);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_waist", "j_spinelower", undefined);
  function_c487d6b1(#"soa", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_torso", "j_spine4", undefined);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_left", "j_shoulder_le", 32);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_arm_right", "j_shoulder_ri", 16);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_head", "j_head", 8);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_left", "j_hip_le", 256);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_hip_right", "j_hip_ri", 128);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_left", "j_knee_le", 256);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_leg_right", "j_knee_ri", 128);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_waist", "j_spinelower", undefined);
  function_c487d6b1(#"tormentor", "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_torso", "j_spine4", undefined);
}

function function_15482148(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playviewmodelfx(bwastimejump, #"hash_308bd3bf83b35604", "tag_fx1", 0);
}

function function_c487d6b1(archetype, fx, joint, gibflag) {
  if(!isDefined(level.var_fd6cbce7)) {
    level.var_fd6cbce7 = [];
  }

  if(!isDefined(level.var_fd6cbce7[archetype])) {
    level.var_fd6cbce7[archetype] = [];
  }

  level.var_fd6cbce7[archetype][fx] = spawnStruct();
  level.var_fd6cbce7[archetype][fx].joint = joint;
  level.var_fd6cbce7[archetype][fx].gibflag = gibflag;
}

function function_c8e3a0dc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    str_tag = isDefined(self gettagorigin("j_spine4")) ? "j_spine4" : "tag_origin";
    self playSound(bwastimejump, #"hash_1b3441156c512173");
    self util::playFXOnTag(bwastimejump, "zm_weapons/fx9_aat_burnination_lvl5_aoe", self, str_tag);
  }
}

function function_f3b43353(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_a681160a(fieldname);
    return;
  }

  self function_725a593f(fieldname);
}

function function_2d64f265(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self function_a681160a(fieldname, 1);
    return;
  }

  self function_725a593f(fieldname);
}

function function_a681160a(localclientnum, is_vehicle = 0) {
  if(is_vehicle) {
    str_tag = isDefined(self gettagorigin("tag_body")) ? "tag_body" : "tag_origin";
    self.var_b1312f24 = util::playFXOnTag(localclientnum, "zm_weapons/fx9_aat_burnination_lvl1_fire_zmb_torso", self, str_tag);
  } else {
    if(isDefined(self.var_9bdf44ae)) {
      function_725a593f();
    }

    if(!isDefined(self.var_9bdf44ae)) {
      self.var_9bdf44ae = [];

      if(isarray(level.var_fd6cbce7[self.archetype])) {
        foreach(i, fx in level.var_fd6cbce7[self.archetype]) {
          if(isDefined(fx.gibflag)) {
            if(isDefined(self gettagorigin(fx.joint)) && !gibclientutils::isgibbed(localclientnum, self, fx.gibflag)) {
              fxid = util::playFXOnTag(localclientnum, i, self, fx.joint);

              if(!isDefined(self.var_9bdf44ae)) {
                self.var_9bdf44ae = [];
              } else if(!isarray(self.var_9bdf44ae)) {
                self.var_9bdf44ae = array(self.var_9bdf44ae);
              }

              self.var_9bdf44ae[self.var_9bdf44ae.size] = fxid;
            }

            continue;
          }

          if(isDefined(self gettagorigin(fx.joint))) {
            fxid = util::playFXOnTag(localclientnum, i, self, fx.joint);

            if(!isDefined(self.var_9bdf44ae)) {
              self.var_9bdf44ae = [];
            } else if(!isarray(self.var_9bdf44ae)) {
              self.var_9bdf44ae = array(self.var_9bdf44ae);
            }

            self.var_9bdf44ae[self.var_9bdf44ae.size] = fxid;
          }
        }
      }
    }
  }

  if(!isDefined(self.var_428ce87c)) {
    self playSound(localclientnum, #"hash_60984c7920920c54", self.origin + (0, 0, 50));
    self.var_428ce87c = self playLoopSound(#"hash_aed7c693cd1b7cd");
  }
}

function function_725a593f(localclientnum) {
  if(isDefined(self.var_428ce87c)) {
    self stoploopsound(self.var_428ce87c);
  }

  if(isDefined(self.var_9bdf44ae)) {
    foreach(fxid in self.var_9bdf44ae) {
      if(isint(fxid) && isint(localclientnum)) {
        stopfx(localclientnum, fxid);
      }
    }

    self.var_9bdf44ae = undefined;
  }
}