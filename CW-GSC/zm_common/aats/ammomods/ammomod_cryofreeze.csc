/**********************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\aats\ammomods\ammomod_cryofreeze.csc
**********************************************************/

#using scripts\core_common\aat_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace ammomod_cryofreeze;

function init_cryofreeze() {
  if(!is_true(level.aat_in_use)) {
    return;
  }

  aat::register("ammomod_cryofreeze", #"zmui/zm_ammomod_cryofreeze", "ui_icon_zombie_ammomod_cryofreeze_stacked");
  aat::register("ammomod_cryofreeze_1", #"zmui/zm_ammomod_cryofreeze", "ui_icon_zombie_ammomod_cryofreeze_stacked");
  aat::register("ammomod_cryofreeze_2", #"zmui/zm_ammomod_cryofreeze", "ui_icon_zombie_ammomod_cryofreeze_stacked");
  aat::register("ammomod_cryofreeze_3", #"zmui/zm_ammomod_cryofreeze", "ui_icon_zombie_ammomod_cryofreeze_stacked");
  aat::register("ammomod_cryofreeze_4", #"zmui/zm_ammomod_cryofreeze", "ui_icon_zombie_ammomod_cryofreeze_stacked");
  aat::register("ammomod_cryofreeze_5", #"zmui/zm_ammomod_cryofreeze", "ui_icon_zombie_ammomod_cryofreeze_stacked");
  clientfield::register("actor", "zm_ammomod_cryofreeze_trail_clientfield", 1, 1, "int", &function_a7a5e842, 1, 0);
  clientfield::register("vehicle", "zm_ammomod_cryofreeze_trail_clientfield", 1, 1, "int", &function_a7a5e842, 1, 0);
  clientfield::register("actor", "zm_ammomod_cryofreeze_explosion_clientfield", 1, 1, "counter", &function_de7bde57, 1, 0);
  clientfield::register("vehicle", "zm_ammomod_cryofreeze_explosion_clientfield", 1, 1, "counter", &function_de7bde57, 1, 0);
  clientfield::register("toplayer", "ammomod_cryofreeze_proc", 1, 1, "counter", &function_b43ea396, 1, 0);
}

function function_b43ea396(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playviewmodelfx(bwastimejump, #"hash_49415c5017d46d03", "tag_fx1", 0);
}

function function_a7a5e842(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    str_fx_tag = self aat::function_467efa7b(1);

    if(!isDefined(str_fx_tag)) {
      str_fx_tag = "tag_origin";
    }

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
      self.var_feabd9ee = util::playFXOnTag(fieldname, "zm_weapons/fx9_aat_cryofreeze_lvl1_slow", self, str_fx_tag);
    }

    if(self.archetype === # "zombie_dog") {
      self thread function_a565490f(fieldname);
    }

    if(!isDefined(self.var_f41344b)) {
      self playSound(fieldname, #"hash_1b0ce890be5c595", self.origin + (0, 0, 50));
      self.var_f41344b = self playLoopSound(#"hash_6274adb83dbbdbe");
    }

    self thread function_bfdbfcd(fieldname, 1);
    return;
  }

  self thread function_bfdbfcd(fieldname, 0);
}

function function_bfdbfcd(localclientnum, b_freeze) {
  self notify(#"end_frosty");
  self endoncallback(&function_2734889d, #"death", #"end_frosty");
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

      if(isDefined(self.var_f41344b)) {
        self stoploopsound(self.var_f41344b);
        self.var_f41344b = undefined;
      }

      break;
    }

    wait 0.1;
  }
}

function function_2734889d() {
  self.var_958cf9c5 = undefined;
  self.var_82fb67e7 = undefined;
  players = getlocalplayers();

  foreach(player in players) {
    localclientnum = player getlocalclientnumber();

    if(isDefined(self.var_565ef52d) && isDefined(localclientnum)) {
      stopfx(localclientnum, self.var_565ef52d);
      self.var_565ef52d = undefined;
    }
  }
}

function function_a565490f(localclientnum) {
  self notify("b5b410ea96d8149");
  self endon("b5b410ea96d8149");
  self.var_958cf9c5 = undefined;
  var_feabd9ee = self.var_feabd9ee;
  self waittill(#"death");

  if(isDefined(var_feabd9ee)) {
    killfx(localclientnum, var_feabd9ee);
  }
}

function function_de7bde57(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    str_tag = isDefined(self gettagorigin("j_spine4")) ? "j_spine4" : "tag_origin";
    util::playFXOnTag(bwastimejump, "zm_weapons/fx9_aat_cryofreeze_lvl5_aoe", self, str_tag);
    self playSound(bwastimejump, #"hash_174fb9aaead8f904");
  }
}