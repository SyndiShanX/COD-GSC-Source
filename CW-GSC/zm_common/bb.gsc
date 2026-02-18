/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm_common\bb.gsc
***********************************************/

#using scripts\core_common\bb_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#namespace bb;

function private autoexec __init__system__() {
  system::register(#"bb", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  init_shared();
}

function logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned) {}

function logaispawn(aient, spawner) {}

function logplayerevent(player, eventname) {
  currentweapon = "";
  beastmodeactive = 0;

  if(isDefined(player.currentweapon)) {
    currentweapon = player.currentweapon.name;
  }

  if(isDefined(player.beastmode)) {
    beastmodeactive = player.beastmode;
  }

  zmplayerevents = {};
  zmplayerevents.gametime = function_f8d53445();
  zmplayerevents.roundnumber = level.round_number;
  zmplayerevents.eventname = eventname;
  zmplayerevents.spawnid = getplayerspawnid(player);
  zmplayerevents.username = player.name;
  zmplayerevents.originx = player.origin[0];
  zmplayerevents.originy = player.origin[1];
  zmplayerevents.originz = player.origin[2];
  zmplayerevents.health = player.health;
  zmplayerevents.beastlives = player.beastlives;
  zmplayerevents.currentweapon = currentweapon;
  zmplayerevents.kills = player.kills;
  zmplayerevents.zone_name = player.zone_name;
  zmplayerevents.sessionstate = player.sessionstate;
  zmplayerevents.currentscore = player.score;
  zmplayerevents.totalscore = player.score_total;
  zmplayerevents.beastmodeon = beastmodeactive;
  function_92d1707f(#"hash_5bd2a2e3f75111c8", zmplayerevents);
}

function logpurchaseevent(player, sellerent, cost, itemname, itemupgraded, itemtype, eventname) {
  zmpurchases = {};
  zmpurchases.gametime = function_f8d53445();
  zmpurchases.roundnumber = level.round_number;
  zmpurchases.playerspawnid = getplayerspawnid(sellerent);
  zmpurchases.username = sellerent.name;
  zmpurchases.itemname = itemupgraded;
  zmpurchases.isupgraded = itemtype;
  zmpurchases.itemtype = eventname;
  zmpurchases.purchasecost = itemname;
  zmpurchases.playeroriginx = sellerent.origin[0];
  zmpurchases.playeroriginy = sellerent.origin[1];
  zmpurchases.playeroriginz = sellerent.origin[2];
  zmpurchases.selleroriginx = cost.origin[0];
  zmpurchases.selleroriginy = cost.origin[1];
  zmpurchases.selleroriginz = cost.origin[2];
  zmpurchases.playerkills = sellerent.kills;
  zmpurchases.playerhealth = sellerent.health;
  zmpurchases.playercurrentscore = sellerent.score;
  zmpurchases.playertotalscore = sellerent.score_total;
  zmpurchases.zone_name = sellerent.zone_name;
  function_92d1707f(#"hash_22cb254982ca97dc", zmpurchases);
}

function logpowerupevent(powerup, optplayer, eventname) {
  playerspawnid = -1;
  playername = "";

  if(isDefined(optplayer) && isPlayer(optplayer)) {
    playerspawnid = getplayerspawnid(optplayer);
    playername = optplayer.name;
  }

  zmpowerups = {};
  zmpowerups.gametime = function_f8d53445();
  zmpowerups.roundnumber = level.round_number;
  zmpowerups.powerupname = powerup.powerup_name;
  zmpowerups.powerupx = powerup.origin[0];
  zmpowerups.powerupy = powerup.origin[1];
  zmpowerups.powerupz = powerup.origin[2];
  zmpowerups.eventname = eventname;
  zmpowerups.playerspawnid = playerspawnid;
  zmpowerups.playername = playername;
  function_92d1707f(#"hash_7edbd2a2dee992e9", zmpowerups);

  foreach(player in getplayers()) {
    logplayerevent(player, "powerup_" + powerup.powerup_name + "_" + eventname);
  }
}