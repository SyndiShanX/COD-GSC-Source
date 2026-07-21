/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\supers\spawnbeacon.gsc
***********************************************/

init() {
  level._effect["_encstr_833017D4776B578B905F68B8BFDA0163A25D40C88A92EF706D"] = loadfx("_encstr_B2BF3018CAB0EF9867F86879A85E061D5F038818734B8F984BCE837883CB09AFC5898890CA26FF8817E3016863A798652F63");
}

beginuse() {
  self giveandfireoffhand("_encstr_B63519953187B7EF1FE6575071AE7C3E69470295E840C0A2217212");
  return 1;
}

thrown(var_0) {
  if(!isDefined(level.tacopsspawnbeacons))
    level.tacopsspawnbeacons = [];

  var_1 = level.tacopsspawnbeacons[var_0.owner.team];

  if(isDefined(level.tacopsspawnbeacons[var_0.owner.team])) {
    var_1 thread dovisualdeath();
    level.tacopsspawnbeacons[var_0.owner.team] = undefined;
  }

  level.tacopsspawnbeacons[var_0.owner.team] = var_0;
  var_0.team = var_0.owner.team;
  var_0.throwangles2d = (var_0.angles[0], var_0.angles[1], 0);
  var_0 waittill("_encstr_8DE90E4D31C35370B84D709B4B6DEE42");
  playFXOnTag(scripts\engine\utility::getfx("_encstr_833017D4776B578B905F68B8BFDA0163A25D40C88A92EF706D"), var_0, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  var_0 thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, 0.1);
  var_0 addtotacopsmap();
  var_0 thread ownermonitor();
  var_0 thread damagemonitor();
  var_0 thread deathmonitor();
}

damagemonitor() {
  self endon("_encstr_AD75063D571AE108");
  var_0 = undefined;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.grenadehealth = 60;

  for(;;) {
    self waittill("_encstr_B2BE0788BAF573592F", var_1, var_0, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13);
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
    self.grenadehealth = self.grenadehealth - var_1;

    if(self.grenadehealth <= 0) {
      break;
    } else
      var_0 scripts\mp\damagefeedback::updatedamagefeedback("_encstr_B40101");
  }

  dovisualdeath();
}

dovisualdeath() {
  playFX(scripts\engine\utility::getfx("_encstr_861E11938B2350E0A0598A7D97C053EF155417"), self.origin);
  self notify("_encstr_AD75063D571AE108");
}

deathmonitor() {
  self waittill("_encstr_AD75063D571AE108");
  stopFXOnTag(scripts\engine\utility::getfx("_encstr_833017D4776B578B905F68B8BFDA0163A25D40C88A92EF706D"), self, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
  removefromtacopsmap();
  self delete();
}

ownermonitor() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self.owner scripts\engine\utility::_id_143A6("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B", "_encstr_8D820B49520F0EC02DDE6367EC");
  dovisualdeath();
}

addtotacopsmap() {
  self.getspawninfofunc = ::getspawninfo;
  scripts\mp\tac_ops_map::addglobalspawnarea("_encstr_86EC0D6F412FEBF669C1DF2619100E", self.team, self, "_encstr_86EC0D6F412FEBF669C1DF2619100E");
}

removefromtacopsmap() {
  scripts\mp\tac_ops_map::removeglobalspawnarea("_encstr_86EC0D6F412FEBF669C1DF2619100E", self.team);
}

getspawninfo(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_97FE07DE392D76D2CD"] = determinespawnorigin(var_0, var_1);
  var_2["_encstr_A7610758E6CED8569B"] = determinespawnangles(var_2["_encstr_97FE07DE392D76D2CD"], var_0, var_1);
  return var_2;
}

determinespawnorigin(var_0, var_1) {
  var_2 = getnodesinradiussorted(var_0.origin, 512, 0, 64, "_encstr_8F0D0583C21D43", 1);

  if(!isDefined(var_2) || var_2.size <= 0)
    return var_0.origin;

  return var_2[0].origin;
}

determinespawnangles(var_0, var_1, var_2) {
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

  if(!isDefined(var_3))
    return var_1.throwangles2d;

  var_9 = var_2 findpath(var_0, var_3.origin, 1, 1);
  var_10 = undefined;

  if(var_9.size <= 1)
    return var_1.throwangles2d;
  else
    var_10 = var_9[1];

  var_11 = var_10 - var_0;
  var_11 = (var_11[0], var_11[1], 0);
  var_12 = vectortoangles(var_11);
  return var_12;
}