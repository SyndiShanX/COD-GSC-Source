/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\toma_strike_cp.gsc
*****************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("toma_strike", "munitionUsed", ::toma_strike_munitionused);
}

toma_strike_munitionused(streakinfo, _id_6152D24062D26039) {
  self notify("munitions_used", "cluster_strike");
}