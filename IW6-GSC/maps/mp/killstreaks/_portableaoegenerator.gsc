/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_portableaoegenerator.gsc
*********************************************************/

#include maps\mp\_utility;
#include common_scripts\utility;

init() {
  if(!isDefined(level.portableAOEgeneratorSettings)) {
    level.portableAOEgeneratorSettings = [];
    level.generators = [];
  }

}

setWeapon(generatorType) {
  config = level.portableAOEgeneratorSettings[generatorType];
  self SetOffhandSecondaryClass("flash");
  self _giveWeapon(config.weaponName, 0);
  self giveStartAmmo(config.weaponName);

  if(!isDefined(self.deployedGenerators)) {
    self.deployedGenerators = [];
  }

  self thread monitorGeneratorUse(generatorType);
}

unsetWeapon(generatorType) {
  self notify("end_monitorUse_" + generatorType);
}

deleteGenerator(generator, generatorType) {
  if(!isDefined(generator)) {
    return;
  }

  foreach(player in level.players) {
    if(isDefined(player) &&
      isDefined(player.inGeneratorAOE)
    ) {
      player.inGeneratorAOE[generatorType] = undefined;
    }
  }

  self registerGenerator(generator, generatorType, undefined);

  generator notify("death");
  generator Delete();
}

registerGenerator(generator, generatorType, bRegister) {
  if(isDefined(bRegister) && bRegister) {
    self.deployedGenerators[generatorType] = generator;
  } else {
    self.deployedGenerators[generatorType] = undefined;
    bRegister = undefined;
  }

  allGeneratorsOfThisType = level.generators[generatorType];
  if(!isDefined(allGeneratorsOfThisType)) {
    level.generators[generatorType] = [];
    allGeneratorsOfThisType = level.generators[generatorType];
  }
  id = getID(generator);
  allGeneratorsOfThisType[id] = bRegister;
}

monitorGeneratorUse(generatorType) {
  self notify("end_monitorUse_" + generatorType);
  self endon("end_monitorUse_" + generatorType);
  self endon("disconnect");
  level endon("game_ended");

  config = level.portableAOEgeneratorSettings[generatorType];
  while(true) {
    self waittill("grenade_fire", grenade, weapName);

    if(weapName == config.weaponName || weapName == generatorType) {
      if(!IsAlive(self)) {
        grenade delete();
        return;
      }

      if(checkGeneratorPlacement(grenade, config.placementZTolerance)) {
        previousGenerator = self.deployedGenerators[generatorType];
        if(isDefined(previousGenerator)) {
          deleteGenerator(previousGenerator, generatorType);
        }

        generator = self spawnNewGenerator(generatorType, grenade.origin);

        parent = grenade GetLinkedParent();
        if(isDefined(parent)) {
          generator LinkTo(parent);
        }

        if(isDefined(grenade)) {
          grenade Delete();
        }
      } else {
        self SetWeaponAmmoStock(config.weaponName, self GetWeaponAmmoStock("trophy_mp") + 1);
      }
    }
  }
}

checkGeneratorPlacement(grenade, maxZDistance) {
  grenade Hide();
  grenade waittill("missile_stuck", stuckTo);

  if(maxZDistance * maxZDistance < DistanceSquared(grenade.origin, self.origin)) {
    secTrace = bulletTrace(self.origin, self.origin - (0, 0, maxZDistance), false, self);

    if(secTrace["fraction"] == 1) {
      grenade delete();
      return false;
    }

    grenade.origin = secTrace["position"];
  }

  grenade Show();

  return true;
}

spawnNewGenerator(generatorType, origin) {
  config = level.portableAOEgeneratorSettings[generatorType];

  generator = spawn("script_model", origin);
  generator.health = config.health;
  generator.team = self.team;
  generator.owner = self;

  generator setCanDamage(true);

  generator setModel(config.placedModel);

  if(level.teamBased) {
    generator maps\mp\_entityheadIcons::setTeamHeadIcon(self.team, (0, 0, config.headIconHeight));
  }
  else {
    generator maps\mp\_entityheadicons::setPlayerHeadIcon(self, (0, 0, config.headIconHeight));
  }

  generator thread watchOwner(self, generatorType);
  generator thread watchDamage(self, generatorType);
  generator thread watchUse(self, generatorType);

  generator thread notUsableForJoiningPlayers(self);

  if(isDefined(config.onDeployCallback)) {
    generator[[config.onDeployCallback]](self, generatorType);
  }

  generator thread maps\mp\gametypes\_weapons::createBombSquadModel(config.bombSquadModel, "tag_origin", self);

  self registerGenerator(generator, generatorType, true);

  self.changingWeapon = undefined;

  wait(0.05);

  if(isDefined(generator) && (generator touchingBadTrigger())) {
    generator notify("death");
  }

  return generator;
}

watchOwner(owner, generatorType) {
  self endon("death");
  level endon("game_ended");

  if(bot_is_fireteam_mode()) {
    owner waittill("killstreak_disowned");
  } else {
    owner waittill_either("killstreak_disowned", "death");
  }

  owner thread deleteGenerator(self, generatorType);
}

watchDamage(owner, generatorType) {
  self.generatorType = generatorType;
  config = level.portableAOEgeneratorSettings[generatorType];

  self maps\mp\gametypes\_damage::monitorDamage(
    config.health,
    config.damageFeedback, ::handleDeathDamage, ::modifyDamage,
    false
  );
}

modifyDamage(attacker, weapon, type, damage) {
  modifiedDamage = damage;

  modifiedDamage = self maps\mp\gametypes\_damage::handleMeleeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleEmpDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleMissileDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleGrenadeDamage(weapon, type, modifiedDamage);
  modifiedDamage = self maps\mp\gametypes\_damage::handleAPDamage(weapon, type, modifiedDamage, attacker);

  return modifiedDamage;
}

handleDeathDamage(attacker, weapon, type) {
  owner = self.owner;
  config = level.portableAOEgeneratorSettings[self.generatorType];

  if(isDefined(owner) && attacker != owner) {
    attacker notify("destroyed_equipment");
  }

  if(isDefined(config.onDestroyCallback)) {
    owner[[config.onDestroyCallback]](self, self.generatorType);
  }
  owner thread deleteGenerator(self, self.generatorType);
}

watchUse(owner, generatorType) {
  self endon("death");
  level endon("game_ended");
  owner endon("disconnect");

  config = level.portableAOEgeneratorSettings[generatorType];
  self setCursorHint("HINT_NOICON");
  self setHintString(config.useHintString);
  self setSelfUsable(owner);

  while(true) {
    self waittill("trigger", player);

    player playLocalSound(config.useSound);

    if(player getAmmoCount(config.weaponName) == 0 && !player isJuggernaut()) {
      player setWeapon(generatorType);
    }

    player thread deleteGenerator(self, generatorType);
  }
}

generatorAOETracker() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  level endon("game_ended");

  delay = RandomFloat(0.5);
  wait(delay);

  self.inGeneratorAOE = [];

  while(true) {
    wait(0.05);

    if(level.generators.size > 0 || self.inGeneratorAOE.size > 0) {
      foreach(config in level.portableAOEgeneratorSettings) {
        self checkAllGeneratorsOfThisType(config.generatorType);
      }
    }
  }
}

checkAllGeneratorsOfThisType(generatorType) {
  generators = level.generators[generatorType];
  if(isDefined(generators)) {
    config = level.portableAOEgeneratorSettings[generatorType];
    maxDistSq = config.aoeRadius * config.aoeRadius;
    result = undefined;
    foreach(generator in generators) {
      if(isDefined(generator) && isReallyAlive(generator)) {
        if((level.teamBased && matchesTargetTeam(generator.team, self.team, config.targetType)) ||
          (!level.teamBased && matchesOwner(generator.owner, self, config.targetType))
        ) {
          distSq = DistanceSquared(generator.origin, self.origin);
          if(distSq < maxDistSq) {
            result = generator;
            break;
          }
        }
      }
    }

    isInThisGenerator = isDefined(result);
    wasInGeneratorOfThisType = isDefined(self.inGeneratorAOE[generatorType]);
    if(isInThisGenerator && !wasInGeneratorOfThisType) {
      self[[config.onEnterCallback]]();
    } else if(!isInThisGenerator && wasInGeneratorOfThisType) {
      self[[config.onExitCallback]]();
    }

    self.inGeneratorAOE[generatorType] = result;
  }
}

matchesTargetTeam(myTeam, theirTeam, teamType) {
  return (
    (teamType == "all") ||
    (teamType == "friendly" && myTeam == theirTeam) ||
    (teamType == "enemy" && myTeam != theirTeam)
  );
}

matchesOwner(myOwner, player, teamType) {
  return (
    (teamType == "all") ||
    (teamType == "friendly" && myOwner == player) ||
    (teamType == "enemy" && myOwner != player)
  );
}

getID(generator) {
  return generator.owner.guid + generator.birthtime;
}