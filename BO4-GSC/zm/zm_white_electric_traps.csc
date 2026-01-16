/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_white_electric_traps.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_white_electric_traps;

autoexec __init__system__() {
  system::register(#"zm_white_electric_trap", &__init__, undefined, undefined);
}

__init__() {
  level init_fx();
  level init_clientfields();
}

init_fx() {
  level._effect[#"hash_6d40a3f1944d81b2"] = #"hash_3a5776a6c23c9563";
  level._effect[#"hash_3d339d7ae7b008d3"] = #"hash_6a84f61b7271e098";
  level._effect[#"hash_6a97de5de4ae14a"] = #"zombie/fx_tesla_shock_zmb";
  level._effect[#"hash_21e93d9faa37cad"] = #"zombie/fx_tesla_shock_eyes_zmb";
}

init_clientfields() {
  clientfield::register("scriptmover", "" + #"hash_6d40a3f1944d81b2", 20000, 2, "int", &function_946acaec, 0, 0);
  clientfield::register("actor", "" + #"electrocute_ai_fx", 20000, 1, "int", &electrocute_ai, 0, 0);
}

function_946acaec(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 2) {
    self.blinking_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_6d40a3f1944d81b2"], self, "tag_origin");
    return;
  }

  if(newval == 1) {
    self.blinking_fx = util::playFXOnTag(localclientnum, level._effect[#"hash_3d339d7ae7b008d3"], self, "tag_origin");
    return;
  }

  if(isDefined(self.blinking_fx)) {
    deletefx(localclientnum, self.blinking_fx);
  }
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