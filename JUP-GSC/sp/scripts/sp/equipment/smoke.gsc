/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\smoke.gsc
***********************************************/



#using scripts\anim\face;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\equipment\offhands;
#using scripts\sp\utility;
#namespace smoke;

function precache(offhand) {
  registeroffhandfirefunc(offhand, &smokefiremain);
}

function smokefiremain(grenade, weapon) {
  grenadeowner = self;
  addbattlechatternotify(grenadeowner, undefined, "grenade_throw", "smoke_grenade");
  grenade waittill("explode", grenadeorigin);
  earthquake(0.25, 0.35, grenadeorigin, 1000);
  playrumbleonposition("grenade_rumble", grenadeorigin);
  playerdistancesquared = distancesquared(level.player.origin, grenadeorigin);

  if(playerdistancesquared <= 22500) {
    traceoffset = (0, 0, 18);

    if(!ray_trace_passed(level.player.origin + traceoffset, grenadeorigin + traceoffset, level.player)) {
      return;
    }

    level.player forceplaygestureviewmodel("iw9_ges_gas_cough_long", undefined, 0.5, 0, 1, 0);
  }

  enemies = getaiarray("axis");

  foreach(enemy in enemies) {
    distancesquared = distancesquared(enemy.origin, grenadeorigin);
    hasstealth = isDefined(enemy.stealth);
    incombat = isDefined(enemy.fnisinstealthcombat) && enemy[[enemy.fnisinstealthcombat]]();

    if(hasstealth && !incombat && distancesquared <= 1000000) {
      event = spawnStruct();
      event.typeorig = "explosion";
      event.type = "cover_blown";
      event.entity = level.player;
      event.origin = grenadeorigin;
      event.investigate_pos = grenadeorigin;
      enemy[[enemy.fnsetstealthstate]]("hunt", event);
    }

    if(distancesquared <= 57600) {
      enemy scripts\anim\face::saygenericdialogue("cough_fit");

      if(!isDefined(enemy.stealth)) {
        enemy aieventlistenerevent("explosion", self, grenadeorigin);
      }
    }
  }
}