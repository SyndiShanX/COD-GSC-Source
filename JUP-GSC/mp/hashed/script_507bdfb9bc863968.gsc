/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_507bdfb9bc863968.gsc
*************************************************/

#using script_57bdd8aff28a4717;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\cp_mp\loot\common_item;
#using scripts\engine\utility;
#using scripts\mp\utility\teams;
#namespace namespace_8af2bc2591598d10;

function private function_b1c0de32a8385673(player, var_f877158dac9d9e99, var_2536710f0f1f411a, isdebug) {
  itembundlename = istrue(var_2536710f0f1f411a) ? "ob_jup_item_key_rift_gate_season3_giraffe_attuned" : "ob_jup_item_key_rift_gate_season3_giraffe";
  namespace_fc89f9b99b72df11::function_9426e2a8c6789b97(player, var_f877158dac9d9e99, itembundlename, 1);
}