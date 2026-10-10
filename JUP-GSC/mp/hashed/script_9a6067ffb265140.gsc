/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_9a6067ffb265140.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using script_7edf952f8921aa6b;
#using scripts\common\callbacks;
#using scripts\common\system;
#using scripts\common\utility;
#using scripts\cp_mp\weapons\lightning_chain;
#using scripts\cp_mp\weapons\ww_dg2;
#using scripts\engine\utility;
#namespace namespace_53f736f2313f7747;

function private autoexec __init__system__() {
  system::register(#"hash_43b335a7dd98c1fb", #"ww_dg2", &pre_main, undefined);
}

function private pre_main() {
  utility::registersharedfunc("ww_dg2", "init", &init);
}

function private init() {
  level.var_b8d710fc87c905a1 = lightning_chain::create_lightning_chain_params(5, 200, 0, 0.5, 3);
}