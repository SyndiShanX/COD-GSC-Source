/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_red_pap_quest.csc
***********************************************/

#include scripts\core_common\array_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\postfx_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;
#include scripts\core_common\util_shared;

#namespace zm_red_pap_quest;

init_clientfield() {
  clientfield::register("scriptmover", "" + #"hash_38dbf4f346c0b609", -15000, 1, "counter", &function_56b9111c, 0, 0);
  clientfield::register("scriptmover", "" + #"hash_9055852bfeb9f00", -15000, 1, "counter", &function_f2332be2, 0, 0);
  clientfield::register("scriptmover", "" + #"crystal_explosion", 16000, 1, "counter", &crystal_explosion_func, 0, 0);
  clientfield::register("vehicle", "" + #"spartoi_charge", 16000, 1, "counter", &function_417c12e1, 0, 0);
  clientfield::register("toplayer", "" + #"hash_687fbbd292ea6be0", 16000, 1, "int", &function_5783c958, 0, 0);
  clientfield::register("toplayer", "" + #"pegasus_shellshock", 16000, 1, "int", &function_e83bf3a, 0, 0);
  clientfield::register("toplayer", "" + #"waterfall_passthrough", 16000, 1, "int", &function_11d62eb0, 0, 0);
  clientfield::register("world", "" + #"hash_28eb5e403f599ce2", 17000, 1, "int", &function_6c40f793, 0, 0);
  level._effect[#"hash_38dbf4f346c0b609"] = #"hash_66e87f89740f4b2c";
  level._effect[#"crystal_explosion"] = #"hash_6e87fbd77320ada5";
  level._effect[#"spartoi_charged"] = #"hash_1a06427eff8dfe13";
}

function_56b9111c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function_f2332be2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}

function_11d62eb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle(#"pstfx_watertransition");
    return;
  }

  self thread postfx::exitpostfxbundle(#"pstfx_watertransition");
}

function_e83bf3a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle(#"pstfx_slowed");
    return;
  }

  self thread postfx::exitpostfxbundle(#"pstfx_slowed");
}

function_417c12e1(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::playFXOnTag(localclientnum, level._effect[#"hash_38dbf4f346c0b609"], self, "tag_origin");
}

crystal_explosion_func(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self util::playFXOnTag(localclientnum, level._effect[#"crystal_explosion"], self, "tag_origin");
  playSound(localclientnum, #"hash_66b733441d74cd21", self.origin);
}

function_5783c958(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self thread postfx::playpostfxbundle(#"pstfx_shock_charge");
    return;
  }

  self thread postfx::exitpostfxbundle(#"pstfx_shock_charge");
}

function_6c40f793(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    forcestreamxmodel(#"hash_d8483cb5cc65489");
    return;
  }

  stopforcestreamingxmodel(#"hash_d8483cb5cc65489");
}