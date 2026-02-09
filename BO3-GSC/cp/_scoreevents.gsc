/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_scoreevents.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_challenges;
#using scripts\cp\_util;
#using scripts\cp\gametypes\_globallogic_score;
#using scripts\shared\callbacks_shared;
#using scripts\shared\challenges_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace scoreevents;

function autoexec __init__sytem__() {
  system::register("scoreevents", &__init__, undefined, undefined);
}

function __init__() {
  callback::on_start_gametype(&main);
}

function main() {
  level.scoreeventcallbacks = [];
  level.scoreeventgameendcallback = &ongameend;
  registerscoreeventcallback("playerKilled", &scoreeventplayerkill);
  registerscoreeventcallback("actorKilled", &scoreeventactorkill);
}

function scoreeventtablelookupint(index, scoreeventcolumn) {
  return int(tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn));
}

function scoreeventtablelookup(index, scoreeventcolumn) {
  return tablelookup(getscoreeventtablename(), 0, index, scoreeventcolumn);
}

function processteamscoreevent(event) {
  foreach(e_player in level.players) {
    processscoreevent(event, e_player);
  }
  if(isDefined(level.teamscoreuicallback)) {
    level thread[[level.teamscoreuicallback]](event);
  }
}

function registerscoreeventcallback(callback, func) {
  if(!isDefined(level.scoreeventcallbacks[callback])) {
    level.scoreeventcallbacks[callback] = [];
  }
  level.scoreeventcallbacks[callback][level.scoreeventcallbacks[callback].size] = func;
}

function scoreeventactorkill(data, time) {
  victim = data.victim;
  attacker = data.attacker;
  time = data.time;
  victim = data.victim;
  meansofdeath = data.smeansofdeath;
  weapon = level.weaponnone;
  if(!level.gametype === "raid") {
    return;
  }
  if(!isDefined(attacker)) {
    return;
  }
  if(!isPlayer(attacker)) {
    return;
  }
  if(isDefined(data.weapon)) {
    weapon = data.weapon;
    weaponclass = util::getweaponclass(data.weapon);
  }
  attacker thread updatemultikills(weapon, weaponclass);
}

function scoreeventplayerkill(data, time) {
  victim = data.victim;
  attacker = data.attacker;
  time = data.time;
  level.numkills++;
  victim = data.victim;
  attacker.lastkilledplayer = victim;
  wasdefusing = data.wasdefusing;
  wasplanting = data.wasplanting;
  wasonground = data.victimonground;
  meansofdeath = data.smeansofdeath;
  weapon = level.weaponnone;
  if(isDefined(data.weapon)) {
    weapon = data.weapon;
    weaponclass = util::getweaponclass(data.weapon);
  }
  victim.anglesondeath = victim getplayerangles();
  if(meansofdeath == "MOD_GRENADE" || meansofdeath == "MOD_GRENADE_SPLASH" || meansofdeath == "MOD_EXPLOSIVE" || meansofdeath == "MOD_EXPLOSIVE_SPLASH" || meansofdeath == "MOD_PROJECTILE" || meansofdeath == "MOD_PROJECTILE_SPLASH") {
    if(weapon == level.weaponnone && isDefined(data.victim.explosiveinfo["weapon"])) {
      weapon = data.victim.explosiveinfo["weapon"];
    }
  }
  if(level.teambased) {
    attacker.lastkilltime = time;
    if(isDefined(victim.lastkilltime) && victim.lastkilltime > (time - 3000)) {
      if(isDefined(victim.lastkilledplayer) && victim.lastkilledplayer util::isenemyplayer(attacker) == 0 && attacker != victim.lastkilledplayer) {
        processscoreevent("kill_enemy_who_killed_teammate", attacker, victim, weapon);
        victim recordkillmodifier("avenger");
      }
    }
    if(isDefined(victim.damagedplayers)) {
      keys = getarraykeys(victim.damagedplayers);
      for(i = 0; i < keys.size; i++) {
        key = keys[i];
        if(key == attacker.clientid) {
          continue;
        }
        if(!isDefined(victim.damagedplayers[key].entity)) {
          continue;
        }
        if(attacker util::isenemyplayer(victim.damagedplayers[key].entity)) {
          continue;
        }
        if((time - victim.damagedplayers[key].time) < 1000) {
          processscoreevent("kill_enemy_injuring_teammate", attacker, victim, weapon);
          if(isDefined(victim.damagedplayers[key].entity)) {
            victim.damagedplayers[key].entity.lastrescuedby = attacker;
            victim.damagedplayers[key].entity.lastrescuedtime = time;
          }
          victim recordkillmodifier("defender");
        }
      }
    }
  }
  switch (weapon.name) {
    case "hatchet": {
      attacker.pers["tomahawks"]++;
      attacker.tomahawks = attacker.pers["tomahawks"];
      processscoreevent("hatchet_kill", attacker, victim, weapon);
      if(isDefined(data.victim.explosiveinfo["projectile_bounced"]) && data.victim.explosiveinfo["projectile_bounced"] == 1) {
        level.globalbankshots++;
        processscoreevent("bounce_hatchet_kill", attacker, victim, weapon);
      }
      break;
    }
    case "inventory_supplydrop":
    case "supplydrop": {
      if(meansofdeath == "MOD_HIT_BY_OBJECT" || meansofdeath == "MOD_CRUSH") {
        processscoreevent("kill_enemy_with_care_package_crush", attacker, victim, weapon);
      } else {
        processscoreevent("kill_enemy_with_hacked_care_package", attacker, victim, weapon);
      }
      break;
    }
  }
  if(isDefined(data.victimweapon)) {
    if(data.victimweapon.name == "minigun") {
      processscoreevent("killed_death_machine_enemy", attacker, victim, weapon);
    } else if(data.victimweapon.name == "m32") {
      processscoreevent("killed_multiple_grenade_launcher_enemy", attacker, victim, weapon);
    }
  }
  attacker thread updatemultikills(weapon, weaponclass);
  if(level.numkills == 1) {
    victim recordkillmodifier("firstblood");
    processscoreevent("first_kill", attacker, victim, weapon);
  } else {
    if(isDefined(attacker.lastkilledby)) {
      if(attacker.lastkilledby == victim) {
        level.globalpaybacks++;
        processscoreevent("revenge_kill", attacker, victim, weapon);
        attacker addweaponstat(weapon, "revenge_kill", 1);
        victim recordkillmodifier("revenge");
        attacker.lastkilledby = undefined;
      }
    }
    if(isDefined(victim.lastmansd) && victim.lastmansd == 1) {
      processscoreevent("final_kill_elimination", attacker, victim, weapon);
      if(isDefined(attacker.lastmansd) && attacker.lastmansd == 1) {
        processscoreevent("elimination_and_last_player_alive", attacker, victim, weapon);
      }
    }
  }
  if(is_weapon_valid(meansofdeath, weapon, weaponclass)) {
    if(isDefined(victim.vattackerorigin)) {
      attackerorigin = victim.vattackerorigin;
    } else {
      attackerorigin = attacker.origin;
    }
    disttovictim = distancesquared(victim.origin, attackerorigin);
    weap_min_dmg_range = get_distance_for_weapon(weapon, weaponclass);
    if(disttovictim > weap_min_dmg_range) {
      attacker challenges::longdistancekill();
      if(weapon.name == "hatchet") {
        attacker challenges::longdistancehatchetkill();
      }
      processscoreevent("longshot_kill", attacker, victim, weapon);
      attacker addweaponstat(weapon, "longshot_kill", 1);
      attacker.pers["longshots"]++;
      attacker.longshots = attacker.pers["longshots"];
      victim recordkillmodifier("longshot");
    }
  }
  if(isalive(attacker)) {
    if(attacker.health < (attacker.maxhealth * 0.35)) {
      attacker.lastkillwheninjured = time;
      processscoreevent("kill_enemy_when_injured", attacker, victim, weapon);
      attacker addweaponstat(weapon, "kill_enemy_when_injured", 1);
      if(attacker hasperk("specialty_bulletflinch")) {
        attacker addplayerstat("perk_bulletflinch_kills", 1);
      }
    }
  } else if(isDefined(attacker.deathtime) && (attacker.deathtime + 800) < time && !attacker isinvehicle()) {
    level.globalafterlifes++;
    processscoreevent("kill_enemy_after_death", attacker, victim, weapon);
    victim recordkillmodifier("posthumous");
  }
  if(attacker.cur_death_streak >= 3) {
    level.globalcomebacks++;
    processscoreevent("comeback_from_deathstreak", attacker, victim, weapon);
    victim recordkillmodifier("comeback");
  }
  if(meansofdeath == "MOD_MELEE" || meansofdeath == "MOD_MELEE_ASSASSINATE" && !weapon.isriotshield) {
    attacker.pers["stabs"]++;
    attacker.stabs = attacker.pers["stabs"];
    vangles = victim.anglesondeath[1];
    pangles = attacker.anglesonkill[1];
    anglediff = angleclamp180(vangles - pangles);
    if(anglediff > -30 && anglediff < 70) {
      level.globalbackstabs++;
      processscoreevent("backstabber_kill", attacker, victim, weapon);
      attacker addweaponstat(weapon, "backstabber_kill", 1);
      attacker.pers["backstabs"]++;
      attacker.backstabs = attacker.pers["backstabs"];
    }
  } else {
    if(isDefined(victim.firsttimedamaged) && victim.firsttimedamaged == time) {
      if(weaponclass == "weapon_sniper") {
        attacker thread updateoneshotmultikills(victim, weapon, victim.firsttimedamaged);
        attacker addweaponstat(weapon, "kill_enemy_one_bullet", 1);
      }
    }
    if(isDefined(attacker.tookweaponfrom[weapon]) && isDefined(attacker.tookweaponfrom[weapon].previousowner)) {
      pickedupweapon = attacker.tookweaponfrom[weapon];
      if(pickedupweapon.previousowner == victim) {
        processscoreevent("kill_enemy_with_their_weapon", attacker, victim, weapon);
        attacker addweaponstat(weapon, "kill_enemy_with_their_weapon", 1);
        if(isDefined(pickedupweapon.weapon) && isDefined(pickedupweapon.smeansofdeath)) {
          if(pickedupweapon.weapon == level.weaponbasemeleeheld && (pickedupweapon.smeansofdeath == "MOD_MELEE" || pickedupweapon.smeansofdeath == "MOD_MELEE_ASSASSINATE")) {
            attacker addweaponstat(level.weaponbasemeleeheld, "kill_enemy_with_their_weapon", 1);
          }
        }
      }
    }
  }
  if(wasdefusing) {
    processscoreevent("killed_bomb_defuser", attacker, victim, weapon);
  } else if(wasplanting) {
    processscoreevent("killed_bomb_planter", attacker, victim, weapon);
  }
  specificweaponkill(attacker, victim, weapon);
  attacker.cur_death_streak = 0;
  attacker disabledeathstreak();
}

function specificweaponkill(attacker, victim, weapon, killstreak) {}

function multikill(killcount, weapon) {
  assert(killcount > 1);
  self challenges::multikill(killcount, weapon);
  if(killcount > 8) {
    processscoreevent("multikill_more_than_8", self, undefined, weapon);
  } else {
    processscoreevent("multikill_" + killcount, self, undefined, weapon);
  }
  self recordmultikill(killcount);
}

function is_weapon_valid(meansofdeath, weapon, weaponclass) {
  valid_weapon = 0;
  if(get_distance_for_weapon(weapon, weaponclass) == 0) {
    valid_weapon = 0;
  } else {
    if(meansofdeath == "MOD_PISTOL_BULLET" || meansofdeath == "MOD_RIFLE_BULLET") {
      valid_weapon = 1;
    } else {
      if(meansofdeath == "MOD_HEAD_SHOT") {
        valid_weapon = 1;
      } else if(weapon.name == "hatchet" && meansofdeath == "MOD_IMPACT") {
        valid_weapon = 1;
      }
    }
  }
  return valid_weapon;
}

function updatemultikills(weapon, weaponclass, killstreak) {
  self endon("disconnect");
  level endon("game_ended");
  self notify("updaterecentkills");
  self endon("updaterecentkills");
  baseweapon = getweapon(getreffromitemindex(getbaseweaponitemindex(weapon)));
  if(!isDefined(self.recentkillcount)) {
    self.recentkillcount = 0;
  }
  if(!isDefined(self.recentkillcountweapon) || self.recentkillcountweapon != baseweapon) {
    self.recentkillcountsameweapon = 0;
    self.recentkillcountweapon = baseweapon;
  }
  if(!isDefined(killstreak)) {
    self.recentkillcountsameweapon++;
    self.recentkillcount++;
  }
  if(!isDefined(self.recent_lmg_smg_killcount)) {
    self.recent_lmg_smg_killcount = 0;
  }
  if(!isDefined(self.recentremotemissilekillcount)) {
    self.recentremotemissilekillcount = 0;
  }
  if(!isDefined(self.recentrcbombkillcount)) {
    self.recentrcbombkillcount = 0;
  }
  if(!isDefined(self.recentmglkillcount)) {
    self.recentmglkillcount = 0;
  }
  if(isDefined(weaponclass)) {
    if(weaponclass == "weapon_lmg" || weaponclass == "weapon_smg") {
      if(self playerads() < 1) {
        self.recent_lmg_smg_killcount++;
      }
    }
  }
  if(isDefined(killstreak)) {
    switch (killstreak) {
      case "remote_missile": {
        self.recentremotemissilekillcount++;
        break;
      }
      case "rcbomb": {
        self.recentrcbombkillcount++;
        break;
      }
      case "inventory_m32":
      case "m32": {
        self.recentmglkillcount++;
        break;
      }
    }
  }
  if(self.recentkillcountsameweapon == 2) {
    self addweaponstat(weapon, "multikill_2", 1);
  } else if(self.recentkillcountsameweapon == 3) {
    self addweaponstat(weapon, "multikill_3", 1);
  }
  self waittilltimeoutordeath(4);
  if(self.recent_lmg_smg_killcount >= 3) {
    self challenges::multi_lmg_smg_kill();
  }
  if(self.recentrcbombkillcount >= 2) {
    self challenges::multi_rcbomb_kill();
  }
  if(self.recentmglkillcount >= 3) {
    self challenges::multi_mgl_kill();
  }
  if(self.recentremotemissilekillcount >= 3) {
    self challenges::multi_remotemissile_kill();
  }
  if(self.recentkillcount > 1) {
    self multikill(self.recentkillcount, weapon);
  }
  self.recentkillcount = 0;
  self.recentkillcountsameweapon = 0;
  self.recentkillcountweapon = undefined;
  self.recent_lmg_smg_killcount = 0;
  self.recentremotemissilekillcount = 0;
  self.recentrcbombkillcount = 0;
  self.recentmglkillcount = 0;
}

function waittilltimeoutordeath(timeout) {
  self endon("death");
  wait(timeout);
}

function updateoneshotmultikills(victim, weapon, firsttimedamaged) {
  self endon("death");
  self endon("disconnect");
  self notify("updateoneshotmultikills" + firsttimedamaged);
  self endon("updateoneshotmultikills" + firsttimedamaged);
  if(!isDefined(self.oneshotmultikills)) {
    self.oneshotmultikills = 0;
  }
  self.oneshotmultikills++;
  wait(1);
  if(self.oneshotmultikills > 1) {
    processscoreevent("kill_enemies_one_bullet", self, victim, weapon);
  } else {
    processscoreevent("kill_enemy_one_bullet", self, victim, weapon);
  }
  self.oneshotmultikills = 0;
}

function get_distance_for_weapon(weapon, weaponclass) {
  distance = 0;
  switch (weaponclass) {
    case "weapon_smg": {
      distance = 1562500;
      break;
    }
    case "weapon_assault": {
      distance = 2250000;
      break;
    }
    case "weapon_lmg": {
      distance = 2250000;
      break;
    }
    case "weapon_sniper": {
      distance = 3062500;
      break;
    }
    case "weapon_pistol": {
      distance = 490000;
      break;
    }
    case "weapon_cqb": {
      distance = 422500;
      break;
    }
    case "weapon_special": {
      if(weapon == level.weaponballisticknife) {
        distance = 2250000;
      }
      break;
    }
    case "weapon_grenade": {
      if(weapon.name == "hatchet") {
        distance = 6250000;
      }
      break;
    }
    default: {
      distance = 0;
      break;
    }
  }
  return distance;
}

function ongameend(data) {
  player = data.player;
  winner = data.winner;
  if(isDefined(winner)) {
    if(level.teambased) {
      if(winner != "tie" && player.team == winner) {
        processscoreevent("won_match", player);
        return;
      }
    } else {
      placement = level.placement["all"];
      topthreeplayers = min(3, placement.size);
      for(index = 0; index < topthreeplayers; index++) {
        if(level.placement["all"][index] == player) {
          processscoreevent("won_match", player);
          return;
        }
      }
    }
  }
  processscoreevent("completed_match", player);
}