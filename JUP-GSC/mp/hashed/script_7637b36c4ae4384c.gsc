/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7637b36c4ae4384c.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_61c5258ded4d690d;
#using scripts\common\system;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapons\ww_setup;
#using scripts\engine\utility;
#namespace ww_setup;

function private autoexec __init__system__() {
  system::register(#"hash_eae80affe3affaf", #"ww_setup", &pre_main, undefined);
}

function private pre_main() {
  utility::registersharedfunc("ww_setup", "init", &init);
}

function private init() {}