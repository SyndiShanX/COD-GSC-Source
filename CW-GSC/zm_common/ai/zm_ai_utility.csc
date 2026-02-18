/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\ai\zm_ai_utility.csc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace zm_ai_utility;

function private autoexec __init__system__() {
  system::register(#"zm_ai_utility", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  ai::add_ai_spawn_function(&function_f3a051c6);
  clientfield::register("actor", "actor_enable_on_radar", 1, 1, "int", &on_radar, 0, 0);
}

function private function_f3a051c6(localclientnum) {}

function private on_radar(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self enableonradar();
    return;
  }

  self disableonradar();
}