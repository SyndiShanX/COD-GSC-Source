/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\aats\zm_aat_frostbite.csc
***********************************************/

#include scripts\core_common\aat_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_aat_frostbite;

autoexec __init__system__() {
  system::register("zm_aat_frostbite", &__init__, undefined, undefined);
}

__init__() {
  if(!(isDefined(level.aat_in_use) && level.aat_in_use)) {
    return;
  }

  aat::register("zm_aat_frostbite", #"hash_5386c3e338c1b314", "t7_icon_zm_aat_thunder_wall");
  clientfield::register("actor", "zm_aat_frostbite_trail_clientfield", 1, 1, "int", &function_bad6b477, 1, 0);
  clientfield::register("vehicle", "zm_aat_frostbite_trail_clientfield", 1, 1, "int", &function_bad6b477, 1, 0);
  clientfield::register("actor", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter", &aat_frostbite_explosion, 1, 0);
  clientfield::register("vehicle", "zm_aat_frostbite_explosion_clientfield", 1, 1, "counter", &aat_frostbite_explosion, 1, 0);
  level._effect[#"hash_139ac9f86d1a96cd"] = "zm_weapons/fx8_aat_water_torso";
  level._effect[#"aat_frostbite_explosion"] = "zm_weapons/fx8_aat_water_exp";
}

function_bad6b477(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    str_fx_tag = self zm_utility::function_467efa7b(1);

    if(!isDefined(str_fx_tag)) {
      str_fx_tag = "tag_origin";
    }

    self.var_c19403bf = util::playFXOnTag(localclientnum, level._effect[#"hash_139ac9f86d1a96cd"], self, str_fx_tag);

    if(self.archetype === #"catalyst" || self.archetype === #"tiger") {
      self thread function_b8cda358(localclientnum);
    }

    if(!isDefined(self.var_dacf22f6)) {
      self.var_dacf22f6 = self playLoopSound(#"hash_f5d043ac36e0244");
    }

    self thread function_d84b013b(localclientnum, 1);
    return;
  }

  self thread function_d84b013b(localclientnum, 0);
}

function_d84b013b(localclientnum, b_freeze) {
  self notify(#"end_frosty");
  self endon(#"death", #"end_frosty");
  self playrenderoverridebundle("rob_test_character_ice");

  if(!isDefined(self.var_82fb67e7)) {
    self.var_82fb67e7 = 0;
  }

  if(b_freeze) {
    var_875c79c1 = self.var_82fb67e7 + 0.5;
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
      self stoprenderoverridebundle("rob_test_character_ice");

      if(isDefined(self.var_c19403bf)) {
        stopfx(localclientnum, self.var_c19403bf);
        self.var_c19403bf = undefined;
      }

      if(isDefined(self.var_dacf22f6)) {
        self stoploopsound(self.var_dacf22f6);
        self.var_dacf22f6 = undefined;
      }

      break;
    }

    wait 0.1;
  }
}

function_b8cda358(localclientnum) {
  self notify("38bbbe5a5d69da68");
  self endon("38bbbe5a5d69da68");
  var_c19403bf = self.var_c19403bf;
  self waittill(#"death");

  if(isDefined(var_c19403bf)) {
    killfx(localclientnum, var_c19403bf);
  }
}

aat_frostbite_explosion(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self)) {
    v_fx_origin = self gettagorigin(self zm_utility::function_467efa7b(1));

    if(!isDefined(v_fx_origin)) {
      v_fx_origin = self.origin;
    }

    playFX(localclientnum, level._effect[#"aat_frostbite_explosion"], v_fx_origin);
    self playSound(localclientnum, #"hash_7de1026336539baa");
  }
}