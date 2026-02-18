/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\zm\chopper_gunner.csc
***********************************************/

#using script_4eecbd20dc9a462c;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\system_shared;
#using scripts\killstreaks\zm\killstreaks;
#namespace chopper_gunner;

function private autoexec __init__system__() {
  system::register(#"chopper_gunner", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  namespace_e8c18978::preinit();
  clientfield::register("vehicle", "" + # "hash_164696e86d29988d", 1, 1, "int", &function_d4e58332, 0, 0);
  clientfield::register("toplayer", "" + # "hash_dae8b06d746fac5", 8000, 1, "int", &function_99879bf2, 0, 0);
}

function private function_d4e58332(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump) {
    self thread scene::stop(#"chopper_gunner_door_open_client");
  }
}

function function_99879bf2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(level.var_a7c8e7d7 === 1) {
    self killstreaks::function_d79281c4(bwastimejump);
  }
}