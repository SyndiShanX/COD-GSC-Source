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

function thrown(var0) {
  if(!isDefined(level.tacopsspawnbeacons)) {
    level.tacopsspawnbeacons = [];
  }

  var1 = level.tacopsspawnbeacons[var0.owner.team];

  if(isDefined(level.tacopsspawnbeacons[var0.owner.team])) {
    thread dovisualdeath();
    level.tacopsspawnbeacons[var0.owner.team] = undefined;
  }

  level.tacopsspawnbeacons[var0.owner.team] = var0;
  var0.team = var0.owner.team;
  var0.throwangles2d = (var0.angles[0], var0.angles[1], 0);
  var0 waittill("missile_stuck");
  playFXOnTag(scripts\engine\utility::getfx("vfx_spawn_beacon_smoke"), var0, "tag_origin");
  var0 thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, 0.1);
  addtotacopsmap(var0);
  thread ownermonitor();
  thread damagemonitor();
  thread deathmonitor();
}

function damagemonitor() {
  self endon("death");
  var0 = undefined;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.grenadehealth = 60;

  for(;;) {
    self waittill("damage", var1, var0, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13);
    var9 = scripts\mp\utility\weapon::mapweapon(var9, var13);

    if(!isPlayer(var0) && !isagent(var0)) {
      continue;
    }

    if(!scripts\mp\weapons::friendlyfirecheck(self.owner, var0)) {
      continue;
    }

    if(scripts\mp\utility\damage::non_player_should_ignore_damage(var0, var9, var13, var4)) {
      continue;
    }

    self.grenadehealth -= var1;

    if(self.grenadehealth <= 0) {
      break;
    }

    var0 scripts\mp\damagefeedback::updatedamagefeedback("");
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
  self.owner scripts\engine\utility::ref_143a6("joined_team", "joined_spectators", "disconnect");
  dovisualdeath();
}

function addtotacopsmap() {
  self.getspawninfofunc = &getspawninfo;
  scripts\mp\tac_ops_map::addglobalspawnarea("spawn_beacon", self.team, self, "spawn_beacon");
}

function removefromtacopsmap() {
  scripts\mp\tac_ops_map::removeglobalspawnarea("spawn_beacon", self.team);
}

function getspawninfo(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, "origin", determinespawnorigin(var0, var1));
}

function determinespawnorigin(var0, var1) {
  var2 = getnodesinradiussorted(var0.origin, 512, 0, 64, "path", 1);

  if(!isDefined(var2) || var2.size <= 0) {
    return var0.origin;
  }

  return var2[0].origin;
}

function determinespawnangles(var0, var1, var2) {
  var3 = undefined;
  var4 = undefined;

  foreach(var6 in level.players) {
    if(var6.team != var1.team && scripts\mp\utility\player::isreallyalive(var6) && var6 != var2) {
      var7 = distance2dsquared(var6.origin, var0);

      if(!isDefined(var4) || var7 < var4) {
        var3 = var6;
        var4 = var7;
      }
    }
  }

  if(!isDefined(var3)) {
    return var1.throwangles2d;
  }

  var9 = var2 findpath(var0, var3.origin, 1, 1);
  var10 = undefined;

  if(var9.size <= 1) {
    return var1.throwangles2d;
  } else {
    var10 = var9[1];
  }

  var11 = var10 - var0;
  var11 = (var11[0], var11[1], 0);
  var12 = vectortoangles(var11);
  return var12;
}