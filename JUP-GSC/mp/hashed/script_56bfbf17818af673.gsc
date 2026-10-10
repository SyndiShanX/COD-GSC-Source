/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_56bfbf17818af673.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_30997c5077be5db6;
#using scripts\common\system;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapons\ww_setup;
#using scripts\engine\utility;
#namespace namespace_9791aee7cc89723a;

function private autoexec __init__system__() {
  system::register(#"hash_eb288affe3ef61e", #"ww_setup", &pre_main, undefined);
}

function private pre_main() {
  utility::registersharedfunc("ww_setup", "init", &init);
}

function private init() {}