/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\weapons\ww_setup.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\system;
#using scripts\engine\utility;
#namespace ww_setup;

function private autoexec __init__system__() {
  system::register(#"ww_setup", undefined, undefined, &post_main);
}

function private post_main() {
  utility::callsharedfunc("ww_setup", "init");
}