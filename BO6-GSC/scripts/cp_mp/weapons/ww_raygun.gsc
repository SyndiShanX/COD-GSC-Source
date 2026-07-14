/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\cp_mp\weapons\ww_raygun.gsc
***********************************************/

#using scripts\common\system;
#using scripts\engine\utility;
#namespace ww_raygun;

function private autoexec __init__system__() {
  system::register(#"ww_raygun", undefined, undefined, &post_main);
}

function private post_main() {
  utility::callsharedfunc(#"ww_raygun", #"init");
}