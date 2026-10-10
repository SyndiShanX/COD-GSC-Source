/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\supers\spawnbeacon.gsc
************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\entityheadicons;
#using scripts\engine\utility;
#using scripts\mp\utility\damage;
#using scripts\mp\utility\player;
#using scripts\mp\utility\weapon;
#using scripts\mp\weapons;
#namespace spawnbeacon;

function init() {
  level._effect["vfx_spawn_beacon_smoke"] = loadfx("vfx/iw8_mp/_requests/vfx_spawn_beacon_smoke.vfx");
}

function beginuse() {
  self giveandfireoffhand("tac_ops_spawn_grenade_mp");
  return true;
}

function thrown(grenade) {
  if(!isDefined(level.tacopsspawnbeacons)) {
    level.tacopsspawnbeacons = [];
  }

  oldbeacon = level.tacopsspawnbeacons[grenade.owner.team];

  if(isDefined(level.tacopsspawnbeacons[grenade.owner.team])) {
    oldbeacon thread dovisualdeath();
    level.tacopsspawnbeacons[grenade.owner.team] = undefined;
  }

  level.tacopsspawnbeacons[grenade.owner.team] = grenade;
  grenade.team = grenade.owner.team;
  grenade.throwangles2d = (grenade.angles[0], grenade.angles[1], 0);
  grenade waittill("missile_stuck");
  playFXOnTag(getfx("vfx_spawn_beacon_smoke"), grenade, "tag_origin");
  grenade thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, 0.1);
  grenade addtotacopsmap();
  grenade thread ownermonitor();
  grenade thread damagemonitor();
  grenade thread deathmonitor();
}

function damagemonitor() {
  self endon("death");
  attacker = undefined;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.grenadehealth = 60;

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = mapweapon(objweapon, inflictor);

    if(!isPlayer(attacker) && !isagent(attacker)) {
      continue;
    }

    if(!scripts\mp\weapons::friendlyfirecheck(self.owner, attacker)) {
      continue;
    }

    if(non_player_should_ignore_damage(attacker, objweapon, inflictor, type)) {
      continue;
    }

    self.grenadehealth -= damage;

    if(self.grenadehealth <= 0) {
      break;
    }

    attacker updatedamagefeedback("");
  }

  dovisualdeath();
}

function dovisualdeath() {
  playFX(getfx("equipment_sparks"), self.origin);
  self notify("death");
}

function deathmonitor() {
  self waittill("death");
  stopFXOnTag(getfx("vfx_spawn_beacon_smoke"), self, "tag_origin");
  removefromtacopsmap();
  self delete();
}

function ownermonitor() {
  level endon("game_ended");
  self endon("death");
  self.owner waittill_any_3("joined_team", "joined_spectators", "disconnect");
  dovisualdeath();
}

function addtotacopsmap() {
  self.getspawninfofunc = &getspawninfo;
}

function removefromtacopsmap() {}

function getspawninfo(grenade, player) {
  info = [];
  info["origin"] = determinespawnorigin(grenade, player);
  info["angles"] = determinespawnangles(info["origin"], grenade, player);
  return info;
}

function determinespawnorigin(grenade, spawningplayer) {
  pathnodes = getnodesinradiussorted(grenade.origin, 512, 0, 64, "path", 1);

  if(!isDefined(pathnodes) || pathnodes.size <= 0) {
    return grenade.origin;
  }

  return pathnodes[0].origin;
}

function determinespawnangles(spawnpos, grenade, spawningplayer) {
  var_510d77329cd1b3b7 = undefined;
  var_9f6ce604177e3317 = undefined;

  foreach(player in level.players) {
    if(player.team != grenade.team && isreallyalive(player) && player != spawningplayer) {
      distsq = distance2dsquared(player.origin, spawnpos);

      if(!isDefined(var_9f6ce604177e3317) || distsq < var_9f6ce604177e3317) {
        var_510d77329cd1b3b7 = player;
        var_9f6ce604177e3317 = distsq;
      }
    }
  }

  if(!isDefined(var_510d77329cd1b3b7)) {
    return grenade.throwangles2d;
  }

  path = spawningplayer findpath(spawnpos, var_510d77329cd1b3b7.origin, 1, 1);
  targetpos = undefined;

  if(path.size <= 1) {
    return grenade.throwangles2d;
  } else {
    targetpos = path[1];
  }

  var_2f36c92c71d2093 = targetpos - spawnpos;
  var_2f36c92c71d2093 = (var_2f36c92c71d2093[0], var_2f36c92c71d2093[1], 0);
  anglestotarget = vectortoangles(var_2f36c92c71d2093);
  return anglestotarget;
}