/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\mp\planemortar.csc
***********************************************/

#include scripts\core_common\clientfield_shared;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\killstreaks\planemortar_shared;

#namespace planemortar;

autoexec __init__system__() {
  system::register(#"planemortar", &__init__, undefined, #"killstreaks");
}

__init__() {
  init_shared();
  level.planemortarexhaustfx = "killstreaks/fx8_mortar_jet_thrusters";
  level.var_913789d7 = "killstreaks/fx8_mortar_jet_contrails";
  clientfield::register("scriptmover", "planemortar_contrail", 1, 1, "int", &planemortar_contrail, 0, 0);
}

planemortar_contrail(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon(#"death");
  util::waittill_dobj(localclientnum);

  if(newval) {
    self.fx = util::playFXOnTag(localclientnum, level.planemortarexhaustfx, self, "tag_fx_engine_exhaust_back");
    self.fx = util::playFXOnTag(localclientnum, level.var_913789d7, self, "tag_body_animate");
  }
}