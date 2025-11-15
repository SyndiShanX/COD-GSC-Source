/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\dog_shared.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\renderoverridebundle;
#include scripts\core_common\util_shared;

#namespace dog;

init_shared() {
  if(!isDefined(level.system_dog)) {
    level.system_dog = {};
    clientfield::register("clientuimodel", "hudItems.dogState", 1, 2, "int", undefined, 0, 0);
    clientfield::register("actor", "dogState", 1, 1, "int", &function_654bd68b, 0, 0);
    clientfield::register("actor", "ks_dog_bark", 1, 1, "int", &function_14740469, 0, 0);
    clientfield::register("actor", "ks_shocked", 1, 1, "int", &function_e464e22b, 0, 0);
  }

  ai::add_archetype_spawn_function("mp_dog", &function_b0f3bc1f);
}

function_b0f3bc1f(localclientnum) {
  self thread watchdeath(localclientnum);
}

watchdeath(localclientnum) {
  self waittill(#"death");

  if(isDefined(self) && self hasdobj(localclientnum)) {
    self clearanim(#"ai_nomad_dog_additive_bark_01", 0.1);
  }
}

private function_654bd68b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    if(self flag::exists(#"friendly")) {
      self renderoverridebundle::stop_bundle(#"friendly", sessionmodeiscampaigngame() ? #"rob_sonar_set_friendlyequip_cp" : #"rob_sonar_set_friendlyequip_mp", 0);
    }
  }
}

function_14740469(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self) && self hasdobj(localclientnum)) {
      self setflaggedanimknobrestart(#"hash_506d2ece42569653", #"ai_nomad_dog_additive_bark_01", 1, 0.1, 1);
    }

    return;
  }

  if(isDefined(self) && self hasdobj(localclientnum)) {
    self clearanim(#"ai_nomad_dog_additive_bark_01", 0.1);
  }
}

function_e464e22b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isDefined(self.zmpowerupinstakill_introduction)) {
      stopfx(localclientnum, self.zmpowerupinstakill_introduction);
    }

    self.zmpowerupinstakill_introduction = util::playFXOnTag(localclientnum, "weapon/fx8_hero_sig_lightning_death_dog", self, "j_spine3");
    return;
  }

  if(isDefined(self.zmpowerupinstakill_introduction)) {
    stopfx(localclientnum, self.zmpowerupinstakill_introduction);
  }
}