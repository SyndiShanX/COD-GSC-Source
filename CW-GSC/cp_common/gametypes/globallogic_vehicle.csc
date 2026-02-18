/*******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: cp_common\gametypes\globallogic_vehicle.csc
*******************************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace vehicles;

function private autoexec __init__system__() {
  system::register(#"globallogic_vehicle", &preinit, undefined, undefined, undefined);
}

function private preinit() {}