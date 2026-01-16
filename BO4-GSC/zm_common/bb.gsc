/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm_common\bb.gsc
***********************************************/

#include scripts\core_common\bb_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\struct;
#include scripts\core_common\system_shared;

#namespace bb;

autoexec __init__system__() {
  system::register(#"bb", &__init__, undefined, undefined);
}

__init__() {
  init_shared();
}

logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned) {}

logaispawn(aient, spawner) {}

logplayerevent(player, eventname) {
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

logroundevent(eventname) {
  zmroundevents = {
    #gametime: function_f8d53445(), 
    #roundnumber: level.round_number, 
    #eventname: eventname
  };
  function_92d1707f(#"hash_1f42d237e3407165", zmroundevents);

  if(isDefined(level.players)) {
    foreach(player in level.players) {
      logplayerevent(player, eventname);
    }
  }
}

logpurchaseevent(player, sellerent, cost, itemname, itemupgraded, itemtype, eventname) {
  zmpurchases = {};
  zmpurchases.gametime = function_f8d53445();
  zmpurchases.roundnumber = level.round_number;
  zmpurchases.playerspawnid = getplayerspawnid(player);
  zmpurchases.username = player.name;
  zmpurchases.itemname = itemname;
  zmpurchases.isupgraded = itemupgraded;
  zmpurchases.itemtype = itemtype;
  zmpurchases.purchasecost = cost;
  zmpurchases.playeroriginx = player.origin[0];
  zmpurchases.playeroriginy = player.origin[1];
  zmpurchases.playeroriginz = player.origin[2];
  zmpurchases.selleroriginx = sellerent.origin[0];
  zmpurchases.selleroriginy = sellerent.origin[1];
  zmpurchases.selleroriginz = sellerent.origin[2];
  zmpurchases.playerkills = player.kills;
  zmpurchases.playerhealth = player.health;
  zmpurchases.playercurrentscore = player.score;
  zmpurchases.playertotalscore = player.score_total;
  zmpurchases.zone_name = player.zone_name;
  function_92d1707f(#"hash_22cb254982ca97dc", zmpurchases);
}

logpowerupevent(powerup, optplayer, eventname) {
  playerspawnid = -1;
  playername = "";

  if(isDefined(optplayer) && isplayer(optplayer)) {
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

  foreach(player in level.players) {
    logplayerevent(player, "powerup_" + powerup.powerup_name + "_" + eventname);
  }
}