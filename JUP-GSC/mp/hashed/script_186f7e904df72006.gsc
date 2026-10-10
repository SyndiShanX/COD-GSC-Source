/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_186f7e904df72006.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_37a51e846783d065;

function private autoexec __init__system__() {
  system::register(#"hash_8fb59c54d63f6b9", #"lightning_chain", &pre_main, undefined);
}

function private pre_main() {
  utility::registersharedfunc("lightning_chain", "init", &init);
}

function private init() {}