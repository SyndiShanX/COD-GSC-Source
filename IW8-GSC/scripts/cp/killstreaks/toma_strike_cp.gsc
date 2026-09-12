/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\toma_strike_cp.gsc
*****************************************************/

function init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "munitionUsed", &ref_13BD2);
}

function ref_13BD2(var_0, var_1) {
  self notify("munitions_used", "cluster_strike");
}