/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_53d55f01b3a5be93.csc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\zm\ai\zm_ai_hulk;
#namespace namespace_45b55437;

function private autoexec __init__system__() {
  system::register(#"hash_7d755ebddd333af6", &preinit, undefined, undefined, undefined);
}

function preinit() {
  ai::add_archetype_spawn_function(#"hulk", &function_6f88ed29);
  clientfield::register("scriptmover", "hs_heal_station_cf", 1, 1, "int", &function_41cca91a, 0, 0);
}

function private function_6f88ed29(localclientnum) {}

function private function_41cca91a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self)) {
    return;
  }

  if(bwastimejump) {
    self.fx = playFX(fieldname, #"hash_5e283544fff6e3d0", self.origin);
    soundloopemitter(#"hash_50ad83fb3ade2891", self.origin + (0, 0, 20));
    return;
  }

  if(isDefined(self.fx)) {
    stopfx(fieldname, self.fx);
  }

  soundstoploopemitter(#"hash_50ad83fb3ade2891", self.origin + (0, 0, 20));
}