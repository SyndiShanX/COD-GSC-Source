/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_trap_electric.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\exploder_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_trap_electric;

autoexec __init__system__() {
  system::register(#"zm_trap_electric", &__init__, undefined, undefined);
}

__init__() {
  a_traps = struct::get_array("trap_electric", "targetname");

  foreach(trap in a_traps) {
    clientfield::register("world", trap.script_noteworthy, 1, 1, "int", &trap_fx_monitor, 0, 0);
  }

  clientfield::register("actor", "electrocute_ai_fx", 1, 1, "int", &electrocute_ai, 0, 0);
  level._effect[#"hash_6a97de5de4ae14a"] = #"zombie/fx_tesla_shock_zmb";
  level._effect[#"hash_21e93d9faa37cad"] = #"zombie/fx_tesla_shock_eyes_zmb";
}

trap_fx_monitor(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  exploder_name = "trap_electric_" + fieldname;

  if(newval) {
    exploder::exploder(exploder_name);
    return;
  }

  exploder::stop_exploder(exploder_name);
}

electrocute_ai(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    str_tag = "J_SpineUpper";

    if(isDefined(self.var_c8b0b5be)) {
      str_tag = self.var_c8b0b5be;
    } else if(self.archetype === #"zombie_dog") {
      str_tag = "J_Spine1";
    }

    self.n_shock_eyes_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_21e93d9faa37cad"], self, "J_Eyeball_LE");

    if(isDefined(self) && isDefined(self.n_shock_eyes_fx)) {
      setfxignorepause(localclientnum, self.n_shock_eyes_fx, 1);
    }

    self.n_shock_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_6a97de5de4ae14a"], self, str_tag);

    if(isDefined(self) && isDefined(self.n_shock_eyes_fx)) {
      setfxignorepause(localclientnum, self.n_shock_fx, 1);
    }

    return;
  }

  if(isDefined(self.n_shock_eyes_fx)) {
    deletefx(localclientnum, self.n_shock_eyes_fx, 1);
    self.n_shock_eyes_fx = undefined;
  }

  if(isDefined(self.n_shock_fx)) {
    deletefx(localclientnum, self.n_shock_fx, 1);
    self.n_shock_fx = undefined;
  }
}