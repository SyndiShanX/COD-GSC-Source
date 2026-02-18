/********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_brainrot.csc
********************************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\renderoverridebundle;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace ammomod_brainrot;

function init_brainrot() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  aat::register("ammomod_brainrot", #"zmui/zm_ammomod_brainrot", "ui_icon_zombie_ammomod_brainrot_stacked");
  aat::register("ammomod_brainrot_1", #"zmui/zm_ammomod_brainrot", "ui_icon_zombie_ammomod_brainrot_stacked");
  aat::register("ammomod_brainrot_2", #"zmui/zm_ammomod_brainrot", "ui_icon_zombie_ammomod_brainrot_stacked");
  aat::register("ammomod_brainrot_3", #"zmui/zm_ammomod_brainrot", "ui_icon_zombie_ammomod_brainrot_stacked");
  aat::register("ammomod_brainrot_4", #"zmui/zm_ammomod_brainrot", "ui_icon_zombie_ammomod_brainrot_stacked");
  aat::register("ammomod_brainrot_5", #"zmui/zm_ammomod_brainrot", "ui_icon_zombie_ammomod_brainrot_stacked");
  clientfield::register("actor", "ammomod_brainrot", 1, 1, "int", &function_d500905a, 0, 0);
  clientfield::register("vehicle", "ammomod_brainrot", 1, 1, "int", &function_d500905a, 0, 0);
  clientfield::register("actor", "zm_ammomod_brainrot_exp", 1, 1, "counter", &function_1d8434b9, 0, 0);
  clientfield::register("vehicle", "zm_ammomod_brainrot_exp", 1, 1, "counter", &function_1d8434b9, 0, 0);
  clientfield::register("toplayer", "ammomod_brainrot_proc", 1, 1, "counter", &function_e437bd26, 1, 0);
}

function function_e437bd26(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playviewmodelfx(bwastimejump, #"hash_3538aa737ab364c7", "tag_fx1", 0);
}

function function_d500905a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self renderoverridebundle::function_c8d97b8e(fieldname, #"zm_friendly", #"hash_4e9065fcc3da0f7f");

  if(bwastimejump) {
    self setdrawname(#"hash_3bbbc2abb11e8ec1", 1);

    if(!gibclientutils::isgibbed(fieldname, self, 8)) {
      if(isDefined(self.archetype)) {
        switch (self.archetype) {
          case # "raz":
            if(isDefined(self gettagorigin("j_head"))) {
              self.var_d59aa7bb = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_raz_eye", self, "j_head");
            }

            break;
          case # "avogadro":
            if(isDefined(self gettagorigin("j_head"))) {
              self.var_d59aa7bb = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_avo_eye", self, "j_head");
            }

            break;
          case # "mimic":
            if(isDefined(self gettagorigin("j_head"))) {
              self.var_d59aa7bb = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_mimic_eye", self, "j_head");
            }

            break;
          case # "zombie_dog":
            if(isDefined(self gettagorigin("j_eyeball_le"))) {
              if(self.subarchetype === # "hash_28e36e7b7d5421f") {
                self.var_d59aa7bb = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_hound_hell_eye", self, "j_eyeball_le");
              }

              if(self.subarchetype === # "hash_2a5479b83161cb35") {
                self.var_d59aa7bb = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_hound_plague_eye", self, "j_eyeball_le");
              }
            }

            break;
          default:
            if(isDefined(self gettagorigin("j_eyeball_le"))) {
              self.var_d59aa7bb = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_eye", self, "j_eyeball_le");
            }

            break;
        }
      }
    }

    if(isDefined(self gettagorigin("j_spine4"))) {
      self.var_6e431702 = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_brain_rot_lvl1_mc_torso", self, "j_spine4");
    }

    if(!isDefined(self.var_85f16cb5)) {
      self playSound(fieldname, #"hash_2d155a1b76096d88");
      self.var_85f16cb5 = self playLoopSound(#"hash_530331283b555ef9");
    }

    if(isDefined(self.var_5da36454)) {
      self[[self.var_5da36454]](fieldname, bwastimejump);
    }

    if(self function_d2503806(#"hash_30651f363ef055e9")) {
      self stoprenderoverridebundle(#"hash_30651f363ef055e9");
    }

    return;
  }

  if(isDefined(self.var_d59aa7bb)) {
    stopfx(fieldname, self.var_d59aa7bb);
    self.var_d59aa7bb = undefined;
  }

  if(isDefined(self.var_8a31e8f)) {
    stopfx(fieldname, self.var_8a31e8f);
    self.var_8a31e8f = undefined;
  }

  if(isDefined(self.var_6e431702)) {
    stopfx(fieldname, self.var_6e431702);
    self.var_6e431702 = undefined;
  }

  if(isDefined(self.var_85f16cb5)) {
    self stoploopsound(self.var_85f16cb5);
    self.var_85f16cb5 = undefined;
  }

  if(isDefined(self.var_5da36454)) {
    self[[self.var_5da36454]](fieldname, bwastimejump);
  }
}

function function_b9c917cc(localclientnum, str_bundle) {
  if(!self function_ca024039() || is_true(level.var_dc60105c) || isigcactive(str_bundle)) {
    return false;
  }

  return true;
}

function function_1d8434b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self gettagorigin("j_head"))) {
    util::playFXOnTag(bwastimejump, "zm_weapons/fx9_aat_brain_rot_lvl5_aoe", self, "j_head");
  }

  self playSound(0, #"hash_70173e20912069e7");
}