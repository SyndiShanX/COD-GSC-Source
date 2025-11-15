/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\weapons\zm_weap_minigun.csc
***********************************************/

#include script_70ab01a7690ea256;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;
#include scripts\zm_common\zm_utility;

#namespace zm_weap_minigun;

autoexec __init__system__() {
  system::register(#"zm_weap_minigun", &__init__, undefined, undefined);
}

__init__() {
  clientfield::register("toplayer", "hero_minigun_vigor_postfx", 1, 1, "counter", &function_d05553c6, 0, 0);
  clientfield::register("allplayers", "minigun_launcher_muzzle_fx", 1, 1, "counter", &minigun_launcher_muzzle_fx, 0, 0);
  clientfield::register("missile", "minigun_nuke_rob", 1, 1, "int", &minigun_nuke_rob, 0, 0);
  clientfield::register("toplayer", "minigun_nuke_rumble", 1, 1, "counter", &minigun_nuke_rumble, 0, 0);
  level._effect[#"hash_319b0ab74b8b1f3c"] = #"hash_296e81a6f8cea122";
  level._effect[#"hash_31a216b74b91524e"] = #"hash_296775a6f8c86e10";
}

private function_d05553c6(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue && !namespace_a6aea2c6::is_active(#"silent_film")) {
    self thread postfx::playpostfxbundle(#"hash_1663ca7cc81f9b17");
  }
}

private minigun_nuke_rob(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue == 1) {
    self playrenderoverridebundle("rob_zm_going_nuclear");
    return;
  }

  self stoprenderoverridebundle("rob_zm_going_nuclear");
}

private minigun_nuke_rumble(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  self playrumbleonentity(localclientnum, "damage_heavy");

  if(function_65b9eb0f(localclientnum)) {
    return;
  }

  self thread postfx::playpostfxbundle(#"pstfx_slowed");
  self waittilltimeout(1, #"death");

  if(isDefined(self)) {
    self thread postfx::exitpostfxbundle(#"pstfx_slowed");
  }
}

minigun_launcher_muzzle_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_83a410ad)) {
    deletefx(localclientnum, self.var_83a410ad, 1);
  }

  if(self zm_utility::function_f8796df3(localclientnum)) {
    self.var_83a410ad = playviewmodelfx(localclientnum, level._effect[#"hash_319b0ab74b8b1f3c"], "tag_flash2");
    return;
  }

  self.var_83a410ad = util::playFXOnTag(localclientnum, level._effect[#"hash_31a216b74b91524e"], self, "tag_flash2");
}