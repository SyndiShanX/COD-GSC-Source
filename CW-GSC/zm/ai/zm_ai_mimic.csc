/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\ai\zm_ai_mimic.csc
***********************************************/

#using scripts\core_common\ai\archetype_mimic;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace zm_ai_mimic;

function private autoexec __init__system__() {
  system::register(#"zm_ai_mimic", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "mimic_show_on_minimap", 16000, 1, "int", &function_78505cdf, 0, 0);
  clientfield::register("actor", "mimic_cleanup_teleport", 16000, 1, "counter", &mimic_cleanup_teleport, 0, 0);
  clientfield::register("toplayer", "mimic_range_hit", 16000, 1, "counter", &function_4bc65819, 0, 0);
}

function function_78505cdf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(bwasdemojump) {
    self function_811196d1(1);
    return;
  }

  self function_811196d1(0);
}

function mimic_cleanup_teleport(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(isDefined(self)) {
    util::playFXOnTag(bwasdemojump, #"hash_784a8bc7b9b17876", self, "tag_origin");
  }
}

function function_4bc65819(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  util::waittill_dobj(bwasdemojump);

  if(!isDefined(self)) {
    return;
  }

  self endon(#"death");

  if(!self function_d2cb869e(#"hash_58e9d4772527f71a")) {
    self codeplaypostfxbundle(#"hash_58e9d4772527f71a");
  }

  self thread function_119c2eb0();
}

function function_119c2eb0() {
  self notify("3987c1b16f6c185b");
  self endon("3987c1b16f6c185b");
  self waittilltimeout(1, #"death");
  self codestoppostfxbundle(#"hash_58e9d4772527f71a");
}