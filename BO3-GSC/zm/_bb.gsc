/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_bb.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\bb_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace bb;

function autoexec __init__sytem__() {
  system::register("bb", & __init__, undefined, undefined);
}

function __init__() {
  init_shared();
}

function logdamage(attacker, victim, weapon, damage, damagetype, hitlocation, victimkilled, victimdowned) {
  victimid = -1;
  victimtype = "";
  victimorigin = (0, 0, 0);
  victimignoreme = 0;
  victimignoreall = 0;
  victimfovcos = 0;
  victimmaxsightdistsqrd = 0;
  victimanimname = "";
  victimname = "";
  victimdowns = 0;
  attackerid = -1;
  attackertype = "";
  attackerorigin = (0, 0, 0);
  attackerignoreme = 0;
  attackerignoreall = 0;
  attackerfovcos = 0;
  attackermaxsightdistsqrd = 0;
  attackeranimname = "";
  attackername = "";
  var_e5f9350b = "";
  var_b8b49851 = "";
  aivictimcombatmode = "";
  var_c46938ee = "";
  var_5833b024 = "";
  aiattackercombatmode = "";
  if(isdefined(attacker)) {
    if(isplayer(attacker)) {
      attackerid = getplayerspawnid(attacker);
      attackertype = "_player";
      attackername = attacker.name;
    } else {
      if(isai(attacker)) {
        attackertype = "_ai";
        aiattackercombatmode = attacker.combatmode;
        attackerid = attacker.actor_id;
      } else {
        attackertype = "_other";
      }
    }
    attackerorigin = attacker.origin;
    attackerignoreme = attacker.ignoreme;
    attackerfovcos = attacker.fovcosine;
    attackermaxsightdistsqrd = attacker.maxsightdistsqrd;
    if(isdefined(attacker.animname)) {
      attackeranimname = attacker.animname;
    }
  }
  if(isdefined(victim)) {
    if(isplayer(victim)) {
      victimid = getplayerspawnid(victim);
      victimtype = "_player";
      victimname = victim.name;
      victimdowns = victim.downs;
    } else {
      if(isai(victim)) {
        victimtype = "_ai";
        aivictimcombatmode = victim.combatmode;
        victimid = victim.actor_id;
      } else {
        victimtype = "_other";
      }
    }
    victimorigin = victim.origin;
    victimignoreme = victim.ignoreme;
    victimfovcos = victim.fovcosine;
    victimmaxsightdistsqrd = victim.maxsightdistsqrd;
    if(isdefined(victim.animname)) {
      victimanimname = victim.animname;
    }
  }
  bbprint("zmattacks", "gametime %d roundnumber %d attackerid %d attackername %s attackertype %s attackerweapon %s attackerx %d attackery %d attackerz %d aiattckercombatmode %s attackerignoreme %d attackerignoreall %d attackerfovcos %d attackermaxsightdistsqrd %d attackeranimname %s victimid %d victimname %s victimtype %s victimx %d victimy %d victimz %d aivictimcombatmode %s victimignoreme %d victimignoreall %d victimfovcos %d victimmaxsightdistsqrd %d victimanimname %s damage %d damagetype %s damagelocation %s death %d downed %d downs %d", gettime(), level.round_number, attackerid, attackername, attackertype, weapon.name, attackerorigin, aiattackercombatmode, attackerignoreme, attackerignoreall, attackerfovcos, attackermaxsightdistsqrd, attackeranimname, victimid, victimname, victimtype, victimorigin, aivictimcombatmode, victimignoreme, victimignoreall, victimfovcos, victimmaxsightdistsqrd, victimanimname, damage, damagetype, hitlocation, victimkilled, victimdowned, victimdowns);
}

function logaispawn(aient, spawner) {
  bbprint("zmaispawn", "gametime %d actorid %d aitype %s archetype %s airank %s accuracy %d originx %d originy %d originz %d weapon %s melee_weapon %s health %d roundNum %d", gettime(), aient.actor_id, aient.aitype, aient.archetype, aient.airank, aient.accuracy, aient.origin, aient.primaryweapon.name, aient.meleeweapon.name, aient.health, level.round_number);
}

function logplayerevent(player, eventname) {
  currentweapon = "";
  beastmodeactive = 0;
  if(isdefined(player.currentweapon)) {
    currentweapon = player.currentweapon.name;
  }
  if(isdefined(player.beastmode)) {
    beastmodeactive = player.beastmode;
  }
  bbprint("zmplayerevents", "gametime %d roundnumber %d eventname %s spawnid %d username %s originx %d originy %d originz %d health %d beastlives %d currentweapon %s kills %d zone_name %s sessionstate %s currentscore %d totalscore %d beastmodeon %d", gettime(), level.round_number, eventname, getplayerspawnid(player), player.name, player.origin, player.health, player.beastlives, currentweapon, player.kills, player.zone_name, player.sessionstate, player.score, player.score_total, beastmodeactive);
}

function logroundevent(eventname) {
  bbprint("zmroundevents", "gametime %d roundnumber %d eventname %s", gettime(), level.round_number, eventname);
  foreach(player in level.players) {
    logplayerevent(player, eventname);
  }
}

function logpurchaseevent(player, sellerent, cost, itemname, itemupgraded, itemtype, eventname) {
  bbprint("zmpurchases", "gametime %d roundnumber %d playerspawnid %d username %s itemname %s isupgraded %d itemtype %s purchasecost %d playeroriginx %d playeroriginy %d playeroriginz %d selleroriginx %d selleroriginy %d selleroriginz %d playerkills %d playerhealth %d playercurrentscore %d playertotalscore %d zone_name %s", gettime(), level.round_number, getplayerspawnid(player), player.name, itemname, itemupgraded, itemtype, cost, player.origin, sellerent.origin, player.kills, player.health, player.score, player.score_total, player.zone_name);
}

function logpowerupevent(powerup, optplayer, eventname) {
  playerspawnid = -1;
  playername = "";
  if(isdefined(optplayer) && isplayer(optplayer)) {
    playerspawnid = getplayerspawnid(optplayer);
    playername = optplayer.name;
  }
  bbprint("zmpowerups", "gametime %d roundnumber %d powerupname %s powerupx %d powerupy %d powerupz %d, eventname %s playerspawnid %d playername %s", gettime(), level.round_number, powerup.powerup_name, powerup.origin, eventname, playerspawnid, playername);
  foreach(player in level.players) {
    logplayerevent(player, (("powerup_" + powerup.powerup_name) + "_") + eventname);
  }
}