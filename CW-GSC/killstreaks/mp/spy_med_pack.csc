/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\mp\spy_med_pack.csc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace spy_med_pack;

function private autoexec __init__system__() {
  system::register(#"spy_med_pack", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {}

function private function_b9c8f3cf(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {}