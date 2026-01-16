/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_white_nova_crawler.csc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_ai_white_nova_crawler;

autoexec __init__system__() {
  system::register(#"zm_ai_white_nova_crawler", &__init__, undefined, #"zm_ai_nova_crawler");
}

__init__() {
  level._effect[#"fx8_nova_crawler_zombie_buff"] = "zm_ai/fx8_nova_crawler_zombie_buff";
  level._effect[#"hash_fa591e70e810d4a"] = "zm_ai/fx8_nova_crawler_gas_cloud_lg";
  clientfield::register("actor", "nova_buff_aura_clientfield", 8000, 1, "int", &function_be621cc7, 0, 0);
  clientfield::register("actor", "white_nova_crawler_phase_end_clientfield", 8000, 1, "counter", &function_18c564d0, 0, 0);
  clientfield::register("actor", "nova_gas_cloud_fx_clientfield", 8000, 1, "counter", &function_c9ef107f, 0, 0);
  clientfield::register("actor", "white_nova_crawler_spore_impact_clientfield", 8000, 1, "counter", &function_2a92d45, 0, 0);
  clientfield::register("scriptmover", "white_nova_crawler_spore_clientfield", 16000, 1, "int", &function_9ed375e1, 0, 0);
  ai::add_archetype_spawn_function(#"nova_crawler", &function_582a3075);
}

private function_582a3075(localclientnum) {
  if(!isDefined(self._effect)) {
    self._effect = [];
  }

  self._effect[#"hash_219e13e8868d7af4"] = "zm_ai/fx8_nova_crawler_explode";

  if(isDefined(self.subarchetype)) {
    if(self.subarchetype == #"blue_nova_crawler") {
      self._effect[#"hash_219e13e8868d7af4"] = "zm_ai/fx8_nova_crawler_mq_explode";
      return;
    }

    if(self.subarchetype == #"ranged_nova_crawler") {
      self._effect[#"hash_219e13e8868d7af4"] = "zm_ai/fx8_nova_crawler_elec_explode";
      self._effect[#"nova_crawler_phase_teleport_end_fx"] = "zm_ai/fx8_nova_crawler_elec_teleport_appear";
    }
  }
}

private function_be621cc7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newval === 1) {
    self.var_f09d143c = util::playFXOnTag(localclientnum, level._effect[#"fx8_nova_crawler_zombie_buff"], self, "j_spine4");
    return;
  }

  if(isDefined(self.var_f09d143c)) {
    stopfx(localclientnum, self.var_f09d143c);
    self.var_f09d143c = undefined;
  }
}

private function_18c564d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self._effect) && isDefined(self._effect[#"nova_crawler_phase_teleport_end_fx"])) {
    util::playFXOnTag(localclientnum, self._effect[#"nova_crawler_phase_teleport_end_fx"], self, "j_spine4");
  }
}

private function_c9ef107f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, wasdemojump) {
  fx_location = self gettagorigin("j_mainroot");

  if(isDefined(fx_location)) {
    playFX(localclientnum, level._effect[#"hash_fa591e70e810d4a"], fx_location);
  }
}

function_2a92d45(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(localclientnum);

  if(isDefined(self) && newval) {
    function_239993de(localclientnum, "zm_ai/fx8_nova_crawler_gas_projectile_impact", self, "j_spine4");
  }
}

function_9ed375e1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  if(newval) {
    self.spore_fx = function_239993de(localclientnum, "zm_ai/fx8_nova_crawler_gas_projectile", self, "tag_origin");
    return;
  }

  if(isDefined(self.spore_fx)) {
    stopfx(localclientnum, self.spore_fx);
    self.spore_fx = undefined;
  }
}