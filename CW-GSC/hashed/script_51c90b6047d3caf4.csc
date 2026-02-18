/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_51c90b6047d3caf4.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_b062407c;

function private autoexec __init__system__() {
  system::register(#"hash_17c0cbaa27663c8a", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_5f124a31eeb3904a", 24000, 1, "int", &function_6142e681, 0, 0);
}

function function_6142e681(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self.var_30598532 = util::playFXOnTag(fieldname, #"hash_2acd20deb7d56350", self, "tag_animate");
    playSound(fieldname, #"hash_5fe175ffa66e0218", self.origin + (0, 0, 8));
    self.var_bc20b97b = self playLoopSound(#"hash_4aa06f01cb7030a8");
    return;
  }

  if(isDefined(self.var_30598532)) {
    stopfx(fieldname, self.var_30598532);
    self.var_30598532 = undefined;
  }

  if(isDefined(self.var_bc20b97b)) {
    self stoploopsound(self.var_bc20b97b);
    playSound(fieldname, #"hash_13d630c8c8135e9", self.origin + (0, 0, 8));
  }
}