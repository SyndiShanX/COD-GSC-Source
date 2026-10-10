/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_315ecb59881c4ff.gsc
************************************************/

#using scripts\common\utility;
#using scripts\cp\cp_hud_message;
#using scripts\cp\utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\engine\utility;
#namespace namespace_d411239fd629cf92;

function init() {
  scripts\engine\utility::registersharedfunc("cluster_spike", "munitionUsed", &function_fe25039b3e24f942);
  scripts\engine\utility::registersharedfunc("cluster_spike", "lifetimeOverride", &function_12f3623076efb2e9);
}

function function_fe25039b3e24f942() {
  self notify("munitions_used", "cluster_spike");

  foreach(player in level.players) {
    player thread scripts\cp\cp_hud_message::showsplash("used_cluster_spike", undefined, self);
  }

  scripts\cp\utility::function_98f7ca3781dac77c(self, "cluster_spike");
}

function function_12f3623076efb2e9() {
  return 180;
}