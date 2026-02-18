/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\vehicle.csc
***********************************************/

#using scripts\core_common\system_shared;
#using scripts\core_common\vehicle_shared;
#namespace vehicle;

function private autoexec __init__system__() {
  system::register(#"vehicle", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  if(!isDefined(level._effect)) {
    level._effect = [];
  }

  level.vehicles_inited = 1;
}

function vehicle_variants(localclientnum) {}