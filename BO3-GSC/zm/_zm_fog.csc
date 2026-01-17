/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_fog.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#namespace zm_fog;

function autoexec __init__sytem__() {
  system::register("zm_fog", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("world", "globalfog_bank", 15000, 2, "int", &function_83c92b90, 0, 0);
  clientfield::register("world", "litfog_scriptid_to_edit", 15000, 4, "int", undefined, 0, 0);
  clientfield::register("world", "litfog_bank", 15000, 2, "int", &function_7ac70b3c, 0, 0);
}

function function_83c92b90(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  setworldfogactivebank(localclientnum, newval + 1);
}

function function_7ac70b3c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  var_18b9a65a = clientfield::get("litfog_scriptid_to_edit");
  setlitfogbank(localclientnum, var_18b9a65a, newval, -1);
}