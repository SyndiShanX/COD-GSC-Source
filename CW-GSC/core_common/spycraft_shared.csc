/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\spycraft_shared.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\weapons\weaponobjects;
#namespace spycraft;

function private autoexec __init__system__() {
  system::register(#"spycraft", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  register_clientfields();
}

function private register_clientfields() {
  clientfield::register("vehicle", "" + # "hash_2d5a2cd7892a4fdc", 1, 1, "counter", &function_a874e85b, 0, 0);
  clientfield::register("missile", "" + # "hash_2d5a2cd7892a4fdc", 1, 1, "counter", &function_a874e85b, 0, 0);
}

function function_a874e85b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self weaponobjects::updateenemyequipment(bwastimejump);
}