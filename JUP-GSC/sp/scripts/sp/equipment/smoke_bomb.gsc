/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\smoke_bomb.gsc
***********************************************/



#using scripts\anim\face;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace smoke_bomb;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &function_172b68e9ea28c13);
}

function function_172b68e9ea28c13(grenade, weapon) {
  grenadeowner = self;
  grenade waittill("missile_stuck", null, null, null, null, grenadeorigin);
  earthquake(0.25, 0.35, grenadeorigin, 1000);
  playrumbleonposition("grenade_rumble", grenadeorigin);
  playerdistancesquared = distancesquared(level.player.origin, grenadeorigin);

  if(playerdistancesquared <= 22500) {
    thread function_14dd7fe1d23f9dc3("iw9_ges_gas_cough_long", grenadeorigin, "smoke_bomb", 150);
  }

  enemies = getaiarray("axis");

  foreach(enemy in enemies) {
    distancesquared = distancesquared(enemy.origin, grenadeorigin);
    hasstealth = isDefined(enemy.stealth);
    incombat = isDefined(enemy.fnisinstealthcombat) && enemy[[enemy.fnisinstealthcombat]]();

    if(hasstealth && !incombat && distancesquared <= 1000000) {
      enemy aieventlistenerevent("explosion", level.player, grenadeorigin);
    }

    if(distancesquared <= 57600) {
      enemy thread function_281e000bb98136ed(9);
      enemy notify("flashbang", (0, 0, 0), 1, 1, grenadeowner, "allies", 9);
      enemy scripts\anim\face::saygenericdialogue("cough_fit");
    }
  }
}

function function_281e000bb98136ed(duration) {
  self endon("death");
  self notify("smoked_bombed");
  self endon("smoked_bombed");
  self.var_8be07fc13ba66777 = 1;
  wait duration;
  self.var_8be07fc13ba66777 = undefined;
}