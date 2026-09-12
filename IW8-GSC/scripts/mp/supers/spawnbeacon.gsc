/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\spawnbeacon.gsc
***********************************************/

function init() {
  level._effect["vfx_spawn_beacon_smoke"] = loadfx("vfx/iw8_mp/_requests/vfx_spawn_beacon_smoke.vfx");
}

function beginuse() {
  self giveandfireoffhand("tac_ops_spawn_grenade_mp");
  return true;
}

function thrown(var_0) {
  if(!isDefined(level.tacopsspawnbeacons)) {
    level.tacopsspawnbeacons = [];
  }

  var_1 = level.tacopsspawnbeacons[var_0.owner.team];

  if(isDefined(level.tacopsspawnbeacons[var_0.owner.team])) {
    thread dovisualdeath();
    level.tacopsspawnbeacons[var_0.owner.team] = undefined;
  }

  level.tacopsspawnbeacons[var_0.owner.team] = var_0;
  var_0.team = var_0.owner.team;
  var_0.throwangles2d = (var_0.angles[0], var_0.angles[1], 0);
  var_0 waittill("missile_stuck");
  playFXOnTag(scripts\engine\utility::getfx("vfx_spawn_beacon_smoke"), var_0, "tag_origin");
  var_0 thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, 0.1);
  addtotacopsmap(var_0);
  thread ownermonitor();
  thread damagemonitor();
  thread deathmonitor();
}

function damagemonitor() {
  self endon("death");
  var_0 = undefined;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.grenadehealth = 60;

  for(;;) {
    self waittill("damage", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
    var_9 = scripts\mp\utility\weapon::mapweapon(var_9, var_13);

    if(!isPlayer(var_0) && !isagent(var_0)) {
      continue;
    }

    if(!scripts\mp\weapons::friendlyfirecheck(self.owner, var_0)) {
      continue;
    }

    if(scripts\mp\utility\damage::non_player_should_ignore_damage(var_0, var_9, var_13, var_4)) {
      continue;
    }

    self.grenadehealth -= var_1;

    if(self.grenadehealth <= 0) {
      break;
    }

    var_0 scripts\mp\damagefeedback::updatedamagefeedback("");
  }

  dovisualdeath();
}

function dovisualdeath() {
  playFX(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  self notify("death");
}

function deathmonitor() {
  self waittill("death");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_spawn_beacon_smoke"), self, "tag_origin");
  removefromtacopsmap();
  self delete();
}

function ownermonitor() {
  level endon("game_ended");
  self endon("death");
  self.owner scripts\engine\utility::ref_143A6("joined_team", "joined_spectators", "disconnect");
  dovisualdeath();
}

function addtotacopsmap() {
  self.getspawninfofunc = &getspawninfo;
  scripts\mp\tac_ops_map::addglobalspawnarea("spawn_beacon", self.team, self, "spawn_beacon");
}

function removefromtacopsmap() {
  scripts\mp\tac_ops_map::removeglobalspawnarea("spawn_beacon", self.team);
}

function getspawninfo(var_0, var_1) {
  var_2 = [];
  GscBinSkip0(0x2e, "origin", determinespawnorigin(var_0, var_1));
}

function determinespawnorigin(var_0, var_1) {
  var_2 = getnodesinradiussorted(var_0.origin, 512, 0, 64, "path", 1);

  if(!isDefined(var_2) || var_2.size <= 0) {
    return var_0.origin;
  }

  return var_2[0].origin;
}

function determinespawnangles(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;

  foreach(var_6 in level.players) {
    if(var_6.team != var_1.team && scripts\mp\utility\player::isreallyalive(var_6) && var_6 != var_2) {
      var_7 = distance2dsquared(var_6.origin, var_0);

      if(!isDefined(var_4) || var_7 < var_4) {
        var_3 = var_6;
        var_4 = var_7;
      }
    }
  }

  if(!isDefined(var_3)) {
    return var_1.throwangles2d;
  }

  var_9 = var_2 findpath(var_0, var_3.origin, 1, 1);
  var_10 = undefined;

  if(var_9.size <= 1) {
    return var_1.throwangles2d;
  } else {
    var_10 = var_9[1];
  }

  var_11 = var_10 - var_0;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectortoangles(var_11);
  return var_12;
}