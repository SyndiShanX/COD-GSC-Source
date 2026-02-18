/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\battletracks.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace battletracks;

function private autoexec __init__system__() {
  system::register(#"battletracks", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register("vehicle", "battletrack_active", 1, 1, "int", &function_14657fe9, 0, 0);
}

function private function_14657fe9(local_client_num, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.battletrack_active = bwastimejump;
  waitframe(1);
  players = getlocalplayers();

  foreach(player in players) {
    vehicle = getplayervehicle(player);

    if(isDefined(vehicle)) {
      if(vehicle.battletrack_active !== 0) {
        setDvar(#"hash_30d02c7f5a4acf54", 1);
        return;
      }
    }
  }

  setDvar(#"hash_30d02c7f5a4acf54", 0);
}