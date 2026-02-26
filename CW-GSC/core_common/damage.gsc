/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\damage.gsc
***********************************************/

#using scripts\core_common\util_shared;
#using scripts\core_common\vehicle_shared;
#namespace damage;

function friendlyfirecheck(owner, attacker, forcedfriendlyfirerule) {
  if(!isDefined(owner)) {
    return true;
  }

  if(!level.teambased) {
    return true;
  }

  friendlyfirerule = 0;

  if(isDefined(level.figure_out_friendly_fire)) {
    friendlyfirerule = [[level.figure_out_friendly_fire]](undefined, attacker);
  }

  if(isDefined(forcedfriendlyfirerule)) {
    friendlyfirerule = forcedfriendlyfirerule;
  }

  if(friendlyfirerule != 0) {
    return true;
  }

  if(attacker === owner) {
    return true;
  }

  if(is_true(self.var_24ac884b)) {
    return true;
  }

  if(isPlayer(attacker)) {
    ownerteam = owner.team;

    if(!isDefined(ownerteam) && isDefined(owner.pers)) {
      ownerteam = owner.pers[#"team"];
    }

    if(isDefined(attacker.pers) && !isDefined(attacker.pers[#"team"])) {
      return true;
    }

    if(isDefined(attacker.pers) && util::function_fbce7263(attacker.pers[#"team"], ownerteam)) {
      return true;
    }
  } else if(isactor(attacker)) {
    ownerteam = owner.team;

    if(!isDefined(ownerteam) && isDefined(owner.pers)) {
      ownerteam = owner.pers[#"team"];
    }

    if(util::function_fbce7263(attacker.team, ownerteam)) {
      return true;
    }
  } else if(isvehicle(attacker)) {
    if(isDefined(attacker.owner) && isPlayer(attacker.owner)) {
      ownerteam = owner.team;

      if(!isDefined(ownerteam) && isDefined(owner.pers)) {
        ownerteam = owner.pers[#"team"];
      }

      if(util::function_fbce7263(attacker.owner.pers[#"team"], ownerteam)) {
        return true;
      }
    } else {
      occupant_team = attacker vehicle::vehicle_get_occupant_team();

      if(isPlayer(owner)) {
        if(util::function_fbce7263(occupant_team, owner.pers[#"team"]) && occupant_team != # "spectator") {
          return true;
        }
      } else if(util::function_fbce7263(owner.team, occupant_team)) {
        return true;
      }
    }
  } else if(attacker.classname === "worldspawn") {
    return true;
  }

  return false;
}