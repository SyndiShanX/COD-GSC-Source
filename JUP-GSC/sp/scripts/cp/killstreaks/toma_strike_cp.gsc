/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\toma_strike_cp.gsc
*****************************************************/



#using scripts\common\utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\engine\utility;
#namespace toma_strike_cp;

function init() {
  scripts\engine\utility::registersharedfunc("toma_strike", "munitionUsed", &toma_strike_munitionused);
}

function toma_strike_munitionused(streakinfo, ignorecancel) {
  self notify("munitions_used", "cluster_strike");
}