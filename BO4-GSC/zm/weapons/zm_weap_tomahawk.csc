/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_tomahawk.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_tomahawk;

autoexec __init__system__() {
  system::register(#"zm_weap_tomahawk", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "tomahawk_in_use", 1, 2, "int", &tomahawk_in_use, 0, 1);
  clientfield::register("toplayer", "" + #"upgraded_tomahawk_in_use", 1, 1, "int", &tomahawk_in_use, 0, 1);
  clientfield::register("scriptmover", "play_tomahawk_fx", 1, 2, "int", &play_tomahawk_pickup_fx, 0, 0);
  clientfield::register("actor", "play_tomahawk_hit_sound", 1, 1, "int", &function_9a3953ea, 0, 0);
  clientfield::register("toplayer", "tomahawk_rumble", 1, 2, "counter", &tomahawk_rumble, 0, 0);
  clientfield::register("actor", "tomahawk_impact_fx", 1, 2, "int", &tomahawk_impact_fx, 0, 0);
  clientfield::register("allplayers", "tomahawk_charge_up_fx", 1, 2, "counter", &tomahawk_charge_up_fx, 0, 0);
  var_92c56e8d = getminbitcountfornum(3);
  clientfield::register("scriptmover", "tomahawk_trail_fx", 1, var_92c56e8d, "int", &tomahawk_trail_fx, 0, 0);
  clientfield::register("missile", "tomahawk_trail_fx", 1, var_92c56e8d, "int", &tomahawk_trail_fx, 0, 0);
  setupclientfieldcodecallbacks("toplayer", 1, "tomahawk_in_use");
  setupclientfieldcodecallbacks("toplayer", 1, "" + #"upgraded_tomahawk_in_use");
  level._effect[#"tomahawk_pickup"] = #"hash_589d0bc9c10726fb";
  level._effect[#"tomahawk_pickup_upgrade"] = #"hash_5f183257769badd4";
  level._effect[#"tomahawk_trail"] = #"hash_77b995b902df3cd9";
  level._effect[#"tomahawk_trail_ug"] = #"hash_5384d01e513526";
  level._effect[#"tomahawk_charged_trail"] = #"hash_3d47ab5cd1e7b732";
  level._effect[#"hash_f0d62b29afe4b7c"] = #"hash_5c8911bafb8efe53";
  level._effect[#"tomahawk_impact"] = #"hash_681b2b47d9fb71c9";
  level._effect[#"tomahawk_impact_ug"] = #"hash_26ef5fefeb29c436";
  level._effect[#"tomahawk_fire_dot"] = #"hash_5686def5b4c85661";
  level._effect[#"tomahawk_charge_up"] = #"hash_909f7d24e4e84e3";
  level._effect[#"tomahawk_charge_up_ug"] = #"hash_de4b918ea7d5e3c";
}

tomahawk_in_use(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {

  if(newval == 1) {
    iprintlnbold("<dev string:x38>");
    return;
  }

  iprintlnbold("<dev string:x4c>");

}

play_tomahawk_pickup_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self util::waittill_dobj(localclientnum);

  if(bwasdemojump) {
    if(newval == 1) {
      if(isDefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
        self.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
      }

      return;
    }

    if(newval == 2) {
      if(isDefined(self.n_fx_id)) {
        stopfx(localclientnum, self.n_fx_id);
        self.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
      }
    }

    return;
  }

  if(newval == 1) {
    if(isDefined(self.n_fx_id)) {
      stopfx(localclientnum, self.n_fx_id);
    }

    self.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
    return;
  }

  if(newval == 2) {
    if(isDefined(self.n_fx_id)) {
      stopfx(localclientnum, self.n_fx_id);
    }

    self.n_fx_id = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_pickup"], self, "tag_origin");
  }
}

function_9a3953ea(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  self playSound(localclientnum, #"wpn_tomahawk_impact", self.origin + (0, 0, 75));
}

tomahawk_trail_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_95eaa1e)) {
    deletefx(localclientnum, self.n_trail_fx, 1);
    self.n_trail_fx = undefined;
  }

  if(!isDefined(self.var_5681eeb0)) {
    self.var_5681eeb0 = self playLoopSound(#"hash_5e3cfa1a476b30c4");
  }

  if(newval == 1) {
    self.n_trail_fx = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_trail"], self, "tag_fx");
    return;
  }

  if(newval == 2) {
    self.n_trail_fx = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_trail_ug"], self, "tag_fx");
    return;
  }

  if(newval == 3) {
    self.n_trail_fx = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_charged_trail"], self, "tag_fx");
    return;
  }

  if(newval == 4) {
    self.n_trail_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_f0d62b29afe4b7c"], self, "tag_fx");
  }
}

tomahawk_impact_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_d634930c)) {
    deletefx(localclientnum, self.var_d634930c, 1);
    self.var_d634930c = undefined;
  }

  str_tag = "J_Head";
  var_a4c13d2 = "j_spineupper";

  if(self.archetype == #"zombie_dog") {
    str_tag = "J_Head";
    var_a4c13d2 = "J_Spine1";
  }

  if(newval == 1) {
    self.var_d634930c = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_impact"], self, str_tag);
    util::playFXOnTag(localclientnum, level._effect[#"tomahawk_fire_dot"], self, var_a4c13d2);
    return;
  }

  if(newval == 2) {
    self.var_d634930c = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_impact_ug"], self, str_tag);
    util::playFXOnTag(localclientnum, level._effect[#"tomahawk_fire_dot"], self, var_a4c13d2);
  }
}

tomahawk_charge_up_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self.var_5187b05b)) {
    deletefx(localclientnum, self.var_5187b05b, 1);
    self.var_5187b05b = undefined;
  }

  if(newval == 1) {
    self.var_5187b05b = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_charge_up"], self, "tag_origin");
    self thread function_eea02302();
    return;
  }

  if(newval == 2) {
    self.var_5187b05b = util::playFXOnTag(localclientnum, level._effect[#"tomahawk_charge_up_ug"], self, "tag_origin");
    self thread function_eea02302();
  }
}

function_eea02302(localclientnum) {
  self notify(#"hash_5de847b4a6f10108");
  self endon(#"hash_5de847b4a6f10108");
  self endon(#"death");
  self endon(#"disconnect");

  if(!isDefined(self.var_9adf602d)) {
    self.var_9adf602d = 1;
  }

  self playSound(0, "wpn_tomahawk_charge_" + self.var_9adf602d);
  self.var_9adf602d++;
  wait 1.5;
  self.var_9adf602d = 1;
}

tomahawk_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    switch (newvalue) {
      case 1:
        self playrumbleonentity(localclientnum, "zm_weap_chakram_catch_rumble");
        break;
      case 2:
        self playrumbleonentity(localclientnum, "zm_weap_chakram_throw_rumble");
        break;
    }
  }
}