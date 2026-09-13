/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\supers\spawnbeacon.gsc
***********************************************/

init() {
  level._effect["vfx_spawn_beacon_smoke"] = loadfx("vfx/iw8_mp/_requests/vfx_spawn_beacon_smoke.vfx");
}

beginuse() {
  self giveandfireoffhand("tac_ops_spawn_grenade_mp");
  return 1;
}

thrown(grenade) {
  if(!isDefined(level.tacopsspawnbeacons))
    level.tacopsspawnbeacons = [];

  _id_584E87EF265C1426 = level.tacopsspawnbeacons[grenade.owner.team];

  if(isDefined(level.tacopsspawnbeacons[grenade.owner.team])) {
    _id_584E87EF265C1426 thread dovisualdeath();
    level.tacopsspawnbeacons[grenade.owner.team] = undefined;
  }

  level.tacopsspawnbeacons[grenade.owner.team] = grenade;
  grenade.team = grenade.owner.team;
  grenade.throwangles2d = (grenade.angles[0], grenade.angles[1], 0);
  grenade waittill("missile_stuck");
  playFXOnTag(scripts\engine\utility::getfx("vfx_spawn_beacon_smoke"), grenade, "tag_origin");
  grenade thread scripts\cp_mp\entityheadicons::setheadicon_factionimage(0, 20, undefined, undefined, undefined, 0.1);
  grenade addtotacopsmap();
  grenade thread ownermonitor();
  grenade thread damagemonitor();
  grenade thread deathmonitor();
}

damagemonitor() {
  self endon("death");
  attacker = undefined;
  self setCanDamage(1);
  self.maxhealth = 100000;
  self.health = self.maxhealth;
  self.grenadehealth = 60;

  for(;;) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);
    objweapon = scripts\mp\utility\weapon::mapweapon(objweapon, inflictor);

    if(!isPlayer(attacker) && !isagent(attacker)) {
      continue;
    }
    if(!scripts\mp\weapons::friendlyfirecheck(self.owner, attacker)) {
      continue;
    }
    if(scripts\mp\utility\damage::non_player_should_ignore_damage(attacker, objweapon, inflictor, type)) {
      continue;
    }
    self.grenadehealth = self.grenadehealth - damage;

    if(self.grenadehealth <= 0) {
      break;
    } else
      attacker _id_5762AC2F22202BA2::updatedamagefeedback("");
  }

  dovisualdeath();
}

dovisualdeath() {
  playFX(scripts\engine\utility::getfx("equipment_sparks"), self.origin);
  self notify("death");
}

deathmonitor() {
  self waittill("death");
  stopFXOnTag(scripts\engine\utility::getfx("vfx_spawn_beacon_smoke"), self, "tag_origin");
  removefromtacopsmap();
  self delete();
}

ownermonitor() {
  level endon("game_ended");
  self endon("death");
  self.owner scripts\engine\utility::waittill_any_3("joined_team", "joined_spectators", "disconnect");
  dovisualdeath();
}

addtotacopsmap() {
  self.getspawninfofunc = ::getspawninfo;
}

removefromtacopsmap() {}

getspawninfo(grenade, player) {
  info = [];
  info["origin"] = determinespawnorigin(grenade, player);
  info["angles"] = determinespawnangles(info["origin"], grenade, player);
  return info;
}

determinespawnorigin(grenade, _id_1A329A914F290661) {
  _id_F1A894F81AD453AF = getnodesinradiussorted(grenade.origin, 512, 0, 64, "path", 1);

  if(!isDefined(_id_F1A894F81AD453AF) || _id_F1A894F81AD453AF.size <= 0)
    return grenade.origin;

  return _id_F1A894F81AD453AF[0].origin;
}

determinespawnangles(spawnpos, grenade, _id_1A329A914F290661) {
  _id_510D77329CD1B3B7 = undefined;
  _id_9F6CE604177E3317 = undefined;

  foreach(player in level.players) {
    if(player.team != grenade.team && scripts\mp\utility\player::isreallyalive(player) && player != _id_1A329A914F290661) {
      distsq = distance2dsquared(player.origin, spawnpos);

      if(!isDefined(_id_9F6CE604177E3317) || distsq < _id_9F6CE604177E3317) {
        _id_510D77329CD1B3B7 = player;
        _id_9F6CE604177E3317 = distsq;
      }
    }
  }

  if(!isDefined(_id_510D77329CD1B3B7))
    return grenade.throwangles2d;

  path = _id_1A329A914F290661 findpath(spawnpos, _id_510D77329CD1B3B7.origin, 1, 1);
  targetpos = undefined;

  if(path.size <= 1)
    return grenade.throwangles2d;
  else
    targetpos = path[1];

  _id_02F36C92C71D2093 = targetpos - spawnpos;
  _id_02F36C92C71D2093 = (_id_02F36C92C71D2093[0], _id_02F36C92C71D2093[1], 0);
  _id_1EE149ACF5AC75F5 = vectortoangles(_id_02F36C92C71D2093);
  return _id_1EE149ACF5AC75F5;
}