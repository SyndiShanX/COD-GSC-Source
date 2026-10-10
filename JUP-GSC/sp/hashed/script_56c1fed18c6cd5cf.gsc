/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_56c1fed18c6cd5cf.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace namespace_c05035b64370f782;

function autoexec main() {
  scripts\engine\utility::registersharedfunc("switchblade_drone", "init", &init);
}

function init() {
  scripts\engine\utility::registersharedfunc("switchblade_drone", "munitionUsed", &function_63ef15a26ef7e9f1);
}

function function_63ef15a26ef7e9f1() {
  self notify("munitions_used", "switchblade_drone");
}