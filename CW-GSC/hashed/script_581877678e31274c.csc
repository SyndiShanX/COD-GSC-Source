/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_581877678e31274c.csc
***********************************************/

#using scripts\abilities\gadgets\gadget_jammer_shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_68a80213;

function private autoexec __init__system__() {
  system::register(#"hash_512409f8a5de10e4", &preinit, &postinit, undefined, undefined);
}

function private preinit() {
  clientfield::register("actor", "" + # "hash_c5d06ae18fde4c0", 1, 1, "int", &function_870656e3, 0, 0);
}

function private postinit() {}

function function_870656e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self.death_fx = function_239993de(fieldname, "zm_ai/fx9_hound_hell_dth_aoe", self, "j_spine4");
    self playSound(fieldname, #"hash_6a76932cce379c66");
    return;
  }

  if(isDefined(self.death_fx)) {
    stopfx(fieldname, self.death_fx);
    self.death_fx = undefined;
  }
}