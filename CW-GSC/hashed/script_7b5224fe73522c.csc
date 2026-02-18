/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_7b5224fe73522c.csc
***********************************************/

#using script_4e53735256f112ac;
#using script_d67878983e3d7c;
#using scripts\core_common\ai\systems\gib;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_cf2b4f27;

function private autoexec __init__system__() {
  system::register(#"hash_62a392bb15b68ccd", &preinit, undefined, undefined, #"hash_13a43d760497b54d");
}

function private preinit() {
  clientfield::register("actor", "fx_frost_blast_clientfield", 1, 3, "int", &function_78f4a9dc, 1, 0);
  clientfield::register("toplayer", "fx_frost_blast_1p_lv1_clientfield", 1, 1, "counter", &function_e557117b, 1, 0);
  clientfield::register("toplayer", "fx_frost_blast_1p_lv3_clientfield", 1, 1, "counter", &function_fea42db5, 1, 0);
}

function function_e557117b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playviewmodelfx(bwastimejump, "zm_weapons/fx9_fld_frost_blast_lvl1_1p", "tag_torso");
}

function function_fea42db5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playviewmodelfx(bwastimejump, "zm_weapons/fx9_fld_frost_blast_lvl3_1p", "tag_torso");
}

function function_78f4a9dc(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    if(isDefined(self.var_feabd9ee)) {
      stopfx(fieldname, self.var_feabd9ee);
    }

    if(self.archetype === # "zombie_dog") {
      self.var_feabd9ee = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_hound", self, "j_spine2");
    } else if(self.archetype === # "raz") {
      self.var_feabd9ee = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_raz", self, "j_spine4");
    } else if(self.archetype === # "hash_7c0d83ac1e845ac2") {
      self.var_feabd9ee = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_steiner", self, "j_spine4");
    } else if(self.archetype === # "zombie") {
      self.var_feabd9ee = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow", self, "j_spine4");

      if(isDefined(self.var_e109cfb8) && isDefined(self.var_e1a27f4e) && isDefined(self.var_39236a3c) && isDefined(self.var_e03ac221) && isDefined(self.var_31612490) && isDefined(self.var_5023dc3f) && isDefined(self.var_a76dc6cf) && isDefined(self.var_abe559b3)) {
        stopfx(fieldname, self.var_e109cfb8);
        stopfx(fieldname, self.var_e1a27f4e);
        stopfx(fieldname, self.var_39236a3c);
        stopfx(fieldname, self.var_e03ac221);
        stopfx(fieldname, self.var_31612490);
        stopfx(fieldname, self.var_5023dc3f);
        stopfx(fieldname, self.var_a76dc6cf);
        stopfx(fieldname, self.var_abe559b3);
      }

      self.var_bfdb4186 = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_limb_le", self, "j_shoulder_le");
      self.var_e1a27f4e = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_limb_le", self, "j_elbow_le");
      self.var_39236a3c = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_limb_le", self, "j_hip_le");
      self.var_e03ac221 = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_limb_le", self, "j_knee_le");
      self.var_31612490 = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_limb_ri", self, "j_shoulder_ri");
      self.var_5023dc3f = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_limb_ri", self, "j_elbow_ri");
      self.var_a76dc6cf = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_limb_ri", self, "j_hip_ri");
      self.var_abe559b3 = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow_limb_ri", self, "j_knee_ri");
    } else {
      self.var_feabd9ee = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow", self, "tag_origin");
    }
  }

  switch (bwastimejump) {
    case 0:
      self thread function_46e16bf3(fieldname, 0);
      break;
    case 1:
    case 2:
    case 3:
    case 4:
      if(!isDefined(self.var_1b11d1e)) {
        self.var_1b11d1e = self playLoopSound(#"hash_7ee016c54396fd0e");
      }

      self thread function_46e16bf3(fieldname, 1);
      break;
    case 5:
      if(self.archetype == # "zombie_dog") {
        self.var_565ef52d = util::playFXOnTag(fieldname, "zm_weapons/fx9_fld_frost_blast_lvl5_hound_torso", self, "j_spine2");
      } else {
        self.var_565ef52d = util::playFXOnTag(fieldname, "zm_weapons/fx9_fld_frost_blast_lvl5_zombie_torso", self, "j_spine4");
      }

      if(self.archetype === # "zombie_dog") {
        self thread function_ef31a880(fieldname);
      }

      if(!isDefined(self.var_1b11d1e)) {
        self.var_1b11d1e = self playLoopSound(#"hash_7ee016c54396fd0e");
      }

      self thread function_46e16bf3(fieldname, 1);
      break;
  }
}

function function_46e16bf3(localclientnum, b_freeze) {
  self notify(#"end_frosty");
  self endoncallback(&function_ed5b4054, #"death", #"end_frosty");
  self playrenderoverridebundle("rob_test_character_ice");

  if(!isDefined(self.var_82fb67e7)) {
    self.var_82fb67e7 = 0;
  }

  if(b_freeze) {
    var_875c79c1 = self.var_82fb67e7 + 0.5;
    self.var_958cf9c5 = 1;
  }

  while(true) {
    self function_78233d29("rob_test_character_ice", "", "Threshold", self.var_82fb67e7);

    if(b_freeze) {
      self.var_82fb67e7 += 0.2;
    } else {
      self.var_82fb67e7 -= 0.05;
    }

    if(b_freeze && (self.var_82fb67e7 >= var_875c79c1 || self.var_82fb67e7 >= 1)) {
      break;
    } else if(self.var_82fb67e7 <= 0) {
      self.var_958cf9c5 = undefined;
      self stoprenderoverridebundle("rob_test_character_ice");

      if(isDefined(self.var_565ef52d)) {
        stopfx(localclientnum, self.var_565ef52d);
        self.var_565ef52d = undefined;
      }

      if(isDefined(self.var_1b11d1e)) {
        self stoploopsound(self.var_1b11d1e);
        self.var_1b11d1e = undefined;
      }

      if(isDefined(self.var_feabd9ee)) {
        stopfx(localclientnum, self.var_feabd9ee);
        self.var_feabd9ee = undefined;
      }

      if(isDefined(self.var_e109cfb8) && isDefined(self.var_e1a27f4e) && isDefined(self.var_39236a3c) && isDefined(self.var_e03ac221) && isDefined(self.var_31612490) && isDefined(self.var_5023dc3f) && isDefined(self.var_a76dc6cf) && isDefined(self.var_abe559b3)) {
        stopfx(localclientnum, self.var_e109cfb8);
        stopfx(localclientnum, self.var_e1a27f4e);
        stopfx(localclientnum, self.var_39236a3c);
        stopfx(localclientnum, self.var_e03ac221);
        stopfx(localclientnum, self.var_31612490);
        stopfx(localclientnum, self.var_5023dc3f);
        stopfx(localclientnum, self.var_a76dc6cf);
        stopfx(localclientnum, self.var_abe559b3);
        self.var_e109cfb8 = undefined;
        self.var_e1a27f4e = undefined;
        self.var_39236a3c = undefined;
        self.var_e03ac221 = undefined;
        self.var_31612490 = undefined;
        self.var_5023dc3f = undefined;
        self.var_a76dc6cf = undefined;
        self.var_abe559b3 = undefined;
      }

      break;
    } else if(gibclientutils::isgibbed(localclientnum, self, 2)) {
      self.var_958cf9c5 = undefined;

      if(isDefined(self.var_48152abe)) {
        foreach(gib in self.var_48152abe) {
          if(isdynentvalid(gib)) {
            gib playrenderoverridebundle("rob_test_character_ice");
          }
        }
      }

      self stoprenderoverridebundle("rob_test_character_ice");

      if(isDefined(self.var_565ef52d)) {
        killfx(localclientnum, self.var_565ef52d);
        self.var_565ef52d = undefined;
      }

      if(isDefined(self.var_1b11d1e)) {
        self stoploopsound(self.var_1b11d1e);
        self.var_1b11d1e = undefined;
      }

      break;
    }

    wait 0.1;
  }
}

function function_ed5b4054() {
  self.var_958cf9c5 = undefined;
  self.var_82fb67e7 = undefined;
  players = getlocalplayers();

  foreach(player in players) {
    localclientnum = player getlocalclientnumber();

    if(isint(localclientnum) && isint(self.var_565ef52d)) {
      stopfx(localclientnum, self.var_565ef52d);
      self.var_565ef52d = undefined;
    }
  }
}

function function_ef31a880(localclientnum) {
  self notify("4f4ca8475176f10d");
  self endon("4f4ca8475176f10d");
  self.var_958cf9c5 = undefined;
  var_565ef52d = self.var_565ef52d;
  self waittill(#"death");

  if(isDefined(var_565ef52d)) {
    killfx(localclientnum, var_565ef52d);
  }
}