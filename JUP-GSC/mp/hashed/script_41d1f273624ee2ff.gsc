/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_41d1f273624ee2ff.gsc
*************************************************/

#using scripts\common\system;
#using scripts\engine\utility;
#namespace namespace_4126fdfb94a2125e;

function private autoexec __init__system__() {
  system::register(#"hash_ffa629c8a67e2a72", #"ww_raygun", &pre_main, undefined);
}

function private pre_main() {
  utility::registersharedfunc("ww_raygun", "init", &init);
}

function private init() {}