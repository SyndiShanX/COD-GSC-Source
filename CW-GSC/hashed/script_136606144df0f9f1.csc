/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_136606144df0f9f1.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace namespace_791d0451;

function private autoexec __init__system__() {
  system::register(#"hash_2d064899850813e2", &preinit, &postinit, undefined, undefined);
}

function preinit() {
  clientfield::register_clientuimodel("zm_perks_per_controller.count", #"zm_perks_per_controller", #"count", 1, 4, "int", undefined, 0, 0);

  for(i = 1; i <= 10; i++) {
    clientfield::register_clientuimodel("zm_perks_per_controller." + i + ".itemIndex", #"zm_perks_per_controller", [hash(isDefined(i) ? "" + i : ""), #"itemindex"], 1, 8, "int", undefined, 0, 0);
    clientfield::register_clientuimodel("zm_perks_per_controller." + i + ".lost", #"zm_perks_per_controller", [hash(isDefined(i) ? "" + i : ""), #"lost"], 1, 2, "int", undefined, 0, 0);
  }
}

function postinit() {}