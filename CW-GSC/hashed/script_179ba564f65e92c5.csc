/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_179ba564f65e92c5.csc
***********************************************/

#using script_5da58df20c85a0e;
#using scripts\core_common\ai\systems\fx_character;
#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_abfee9ba;

function private autoexec __init__system__() {
  system::register(#"hash_55f568f82a7aea28", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("scriptmover", "" + # "hash_3220b44880f1807c", 24000, 1, "counter", &function_9eb59632, 0, 0);
  ai::add_archetype_spawn_function(#"tormentor", &function_a5cd9e54);
}

function function_a5cd9e54(localclientnum) {
  util::playFXOnTag(localclientnum, #"hash_59ec528273a2d3f0", self, "tag_eye");

  if(isDefined(self.fxdef)) {
    fxclientutils::playfxbundle(localclientnum, self, self.fxdef);
  }
}

function function_9eb59632(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon(#"end_game");
  util::waittill_dobj(bwastimejump);

  if(!isDefined(self)) {
    return;
  }

  var_d1dc644a = playFX(bwastimejump, #"hash_2de6c1300bec68cd", self.origin + (0, 0, 36), anglestoup(self.angles));
  playSound(bwastimejump, #"hash_22dd31bb07fa0a72", self.origin + (0, 0, 36));
  wait 1;

  if(isDefined(var_d1dc644a)) {
    stopfx(bwastimejump, var_d1dc644a);
  }

  if(isDefined(self)) {
    var_b064d016 = playFX(bwastimejump, #"hash_44214bf58f0e6d87", self.origin + (0, 0, 36), anglestoup(self.angles));
    playSound(bwastimejump, #"hash_2b575d8db3a60a95", self.origin + (0, 0, 36));
  }
}