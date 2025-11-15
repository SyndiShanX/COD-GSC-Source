/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_human_cover.gsc
*************************************************/

#using scripts\shared\ai\archetype_cover_utility;
#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\ai_blackboard;
#using scripts\shared\ai\systems\ai_interface;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\laststand_shared;
#namespace archetype_human_cover;

function autoexec registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldReturnToCoverCondition", & shouldreturntocovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldReturnToSuppressedCover", & shouldreturntosuppressedcover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldAdjustToCover", & shouldadjusttocover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareForAdjustToCover", & prepareforadjusttocover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverBlindfireShootStart", & coverblindfireshootactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("canChangeStanceAtCoverCondition", & canchangestanceatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverChangeStanceActionStart", & coverchangestanceactionstart);
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToChangeStanceToStand", & preparetochangestancetostand);
  behaviortreenetworkutility::registerbehaviortreescriptapi("cleanUpChangeStanceToStand", & cleanupchangestancetostand);
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToChangeStanceToCrouch", & preparetochangestancetocrouch);
  behaviortreenetworkutility::registerbehaviortreescriptapi("cleanUpChangeStanceToCrouch", & cleanupchangestancetocrouch);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldVantageAtCoverCondition", & shouldvantageatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("supportsVantageCoverCondition", & supportsvantagecovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverVantageInitialize", & covervantageinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldThrowGrenadeAtCoverCondition", & shouldthrowgrenadeatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverPrepareToThrowGrenade", & coverpreparetothrowgrenade);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverCleanUpToThrowGrenade", & covercleanuptothrowgrenade);
  behaviortreenetworkutility::registerbehaviortreescriptapi("senseNearbyPlayers", & sensenearbyplayers);
}

function shouldthrowgrenadeatcovercondition(behaviortreeentity, throwifpossible = 0) {
  if(isDefined(level.aidisablegrenadethrows) && level.aidisablegrenadethrows) {
    return false;
  }
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }
  if(!issentient(behaviortreeentity.enemy)) {
    return false;
  }
  if(isvehicle(behaviortreeentity.enemy) && behaviortreeentity.enemy.vehicleclass === "helicopter") {
    return false;
  }
  if(ai::hasaiattribute(behaviortreeentity, "useGrenades") && !ai::getaiattribute(behaviortreeentity, "useGrenades")) {
    return false;
  }
  entityangles = behaviortreeentity.angles;
  if(isDefined(behaviortreeentity.node) && (behaviortreeentity.node.type == "Cover Left" || behaviortreeentity.node.type == "Cover Right" || behaviortreeentity.node.type == "Cover Pillar" || (behaviortreeentity.node.type == "Cover Stand" || behaviortreeentity.node.type == "Conceal Stand") || (behaviortreeentity.node.type == "Cover Crouch" || behaviortreeentity.node.type == "Cover Crouch Window" || behaviortreeentity.node.type == "Conceal Crouch")) && behaviortreeentity isatcovernodestrict()) {
    entityangles = behaviortreeentity.node.angles;
  }
  toenemy = behaviortreeentity.enemy.origin - behaviortreeentity.origin;
  toenemy = vectornormalize((toenemy[0], toenemy[1], 0));
  entityforward = anglesToForward(entityangles);
  entityforward = vectornormalize((entityforward[0], entityforward[1], 0));
  if(vectordot(toenemy, entityforward) < 0.5) {
    return false;
  }
  if(!throwifpossible) {
    if(behaviortreeentity.team === "allies") {
      foreach(player in level.players) {
        if(distancesquared(behaviortreeentity.enemy.origin, player.origin) <= 250000) {
          return false;
        }
      }
    }
    foreach(player in level.players) {
      if(player laststand::player_is_in_laststand() && distancesquared(behaviortreeentity.enemy.origin, player.origin) <= 250000) {
        return false;
      }
    }
    grenadethrowinfos = blackboard::getblackboardevents("team_grenade_throw");
    foreach(grenadethrowinfo in grenadethrowinfos) {
      if(grenadethrowinfo.data.grenadethrowerteam === behaviortreeentity.team) {
        return false;
      }
    }
    grenadethrowinfos = blackboard::getblackboardevents("human_grenade_throw");
    foreach(grenadethrowinfo in grenadethrowinfos) {
      if(isDefined(grenadethrowinfo.data.grenadethrownat) && isalive(grenadethrowinfo.data.grenadethrownat)) {
        if(grenadethrowinfo.data.grenadethrower == behaviortreeentity) {
          return false;
        }
        if(isDefined(grenadethrowinfo.data.grenadethrownat) && grenadethrowinfo.data.grenadethrownat == behaviortreeentity.enemy) {
          return false;
        }
        if(isDefined(grenadethrowinfo.data.grenadethrownposition) && isDefined(behaviortreeentity.grenadethrowposition) && distancesquared(grenadethrowinfo.data.grenadethrownposition, behaviortreeentity.grenadethrowposition) <= 360000) {
          return false;
        }
      }
    }
  }
  throw_dist = distance2dsquared(behaviortreeentity.origin, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
  if(throw_dist < (500 * 500) || throw_dist > (1250 * 1250)) {
    return false;
  }
  arm_offset = temp_get_arm_offset(behaviortreeentity, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
  throw_vel = behaviortreeentity canthrowgrenadepos(arm_offset, behaviortreeentity lastknownpos(behaviortreeentity.enemy));
  if(!isDefined(throw_vel)) {
    return false;
  }
  return true;
}

function private sensenearbyplayers(entity) {
  players = getplayers();
  foreach(player in players) {
    distancesq = distancesquared(player.origin, entity.origin);
    if(distancesq <= (360 * 360)) {
      distancetoplayer = sqrt(distancesq);
      chancetodetect = randomfloat(1);
      if(chancetodetect < (distancetoplayer / 360)) {
        entity getperfectinfo(player);
      }
    }
  }
}

function private coverpreparetothrowgrenade(behaviortreeentity) {
  aiutility::keepclaimednodeandchoosecoverdirection(behaviortreeentity);
  if(isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.grenadethrowposition = behaviortreeentity lastknownpos(behaviortreeentity.enemy);
  }
  grenadethrowinfo = spawnStruct();
  grenadethrowinfo.grenadethrower = behaviortreeentity;
  grenadethrowinfo.grenadethrownat = behaviortreeentity.enemy;
  grenadethrowinfo.grenadethrownposition = behaviortreeentity.grenadethrowposition;
  blackboard::addblackboardevent("human_grenade_throw", grenadethrowinfo, randomintrange(15000, 20000));
  grenadethrowinfo = spawnStruct();
  grenadethrowinfo.grenadethrowerteam = behaviortreeentity.team;
  blackboard::addblackboardevent("team_grenade_throw", grenadethrowinfo, randomintrange(1000, 2000));
  behaviortreeentity.preparegrenadeammo = behaviortreeentity.grenadeammo;
}

function private covercleanuptothrowgrenade(behaviortreeentity) {
  aiutility::resetcoverparameters(behaviortreeentity);
  if(behaviortreeentity.preparegrenadeammo == behaviortreeentity.grenadeammo) {
    if(behaviortreeentity.health <= 0) {
      grenade = undefined;
      if(isactor(behaviortreeentity.enemy) && isDefined(behaviortreeentity.grenadeweapon)) {
        grenade = behaviortreeentity.enemy magicgrenadetype(behaviortreeentity.grenadeweapon, behaviortreeentity gettagorigin("j_wrist_ri"), (0, 0, 0), behaviortreeentity.grenadeweapon.aifusetime / 1000);
      } else if(isplayer(behaviortreeentity.enemy) && isDefined(behaviortreeentity.grenadeweapon)) {
        grenade = behaviortreeentity.enemy magicgrenadeplayer(behaviortreeentity.grenadeweapon, behaviortreeentity gettagorigin("j_wrist_ri"), (0, 0, 0));
      }
      if(isDefined(grenade)) {
        grenade.owner = behaviortreeentity;
        grenade.team = behaviortreeentity.team;
        grenade setcontents(grenade setcontents(0) & (~(((32768 | 67108864) | 8388608) | 33554432)));
      }
    }
  }
}

function private canchangestanceatcovercondition(behaviortreeentity) {
  switch (blackboard::getblackboardattribute(behaviortreeentity, "_stance")) {
    case "stand": {
      return aiutility::isstanceallowedatnode("crouch", behaviortreeentity.node);
    }
    case "crouch": {
      return aiutility::isstanceallowedatnode("stand", behaviortreeentity.node);
    }
  }
  return 0;
}

function private shouldreturntosuppressedcover(entity) {
  if(!entity isatgoal()) {
    return true;
  }
  return false;
}

function private shouldreturntocovercondition(behaviortreeentity) {
  if(behaviortreeentity asmistransitionrunning()) {
    return 0;
  }
  if(isDefined(behaviortreeentity.covershootstarttime)) {
    if(gettime() < (behaviortreeentity.covershootstarttime + 800)) {
      return 0;
    }
    if(isDefined(behaviortreeentity.enemy) && isplayer(behaviortreeentity.enemy) && behaviortreeentity.enemy.health < (behaviortreeentity.enemy.maxhealth * 0.5)) {
      if(gettime() < (behaviortreeentity.covershootstarttime + 3000)) {
        return 0;
      }
    }
  }
  if(aiutility::issuppressedatcovercondition(behaviortreeentity)) {
    return 1;
  }
  if(!behaviortreeentity isatgoal()) {
    if(isDefined(behaviortreeentity.node)) {
      offsetorigin = behaviortreeentity getnodeoffsetposition(behaviortreeentity.node);
      return !behaviortreeentity isposatgoal(offsetorigin);
    }
    return 1;
  }
  if(!behaviortreeentity issafefromgrenade()) {
    return 1;
  }
  return 0;
}

function private shouldadjusttocover(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.node)) {
    return false;
  }
  highestsupportedstance = aiutility::gethighestnodestance(behaviortreeentity.node);
  currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  if(currentstance == "crouch" && highestsupportedstance == "crouch") {
    return false;
  }
  covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
  previouscovermode = blackboard::getblackboardattribute(behaviortreeentity, "_previous_cover_mode");
  if(covermode != "cover_alert" && previouscovermode != "cover_alert" && !behaviortreeentity.keepclaimednode) {
    return true;
  }
  if(!aiutility::isstanceallowedatnode(currentstance, behaviortreeentity.node)) {
    return true;
  }
  return false;
}

function private shouldvantageatcovercondition(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.node) || !isDefined(behaviortreeentity.node.type) || !isDefined(behaviortreeentity.enemy) || !isDefined(behaviortreeentity.enemy.origin)) {
    return 0;
  }
  yawtoenemyposition = aiutility::getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
  pitchtoenemyposition = aiutility::getaimpitchtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
  aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_vantage");
  legalaim = 0;
  if(yawtoenemyposition < aimlimitsforcover["aim_left"] && yawtoenemyposition > aimlimitsforcover["aim_right"] && pitchtoenemyposition < 85 && pitchtoenemyposition > 25 && (behaviortreeentity.node.origin[2] - behaviortreeentity.enemy.origin[2]) >= 36) {
    legalaim = 1;
  }
  return legalaim;
}

function private supportsvantagecovercondition(behaviortreeentity) {
  return false;
}

function private covervantageinitialize(behaviortreeentity, asmstatename) {
  aiutility::keepclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_vantage");
}

function private coverblindfireshootactionstart(behaviortreeentity, asmstatename) {
  aiutility::keepclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_blind");
  aiutility::choosecoverdirection(behaviortreeentity);
}

function private preparetochangestancetostand(behaviortreeentity, asmstatename) {
  aiutility::cleanupcovermode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
}

function private cleanupchangestancetostand(behaviortreeentity, asmstatename) {
  aiutility::releaseclaimnode(behaviortreeentity);
  behaviortreeentity.newenemyreaction = 0;
}

function private preparetochangestancetocrouch(behaviortreeentity, asmstatename) {
  aiutility::cleanupcovermode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "crouch");
}

function private cleanupchangestancetocrouch(behaviortreeentity, asmstatename) {
  aiutility::releaseclaimnode(behaviortreeentity);
  behaviortreeentity.newenemyreaction = 0;
}

function private prepareforadjusttocover(behaviortreeentity, asmstatename) {
  aiutility::keepclaimnode(behaviortreeentity);
  highestsupportedstance = aiutility::gethighestnodestance(behaviortreeentity.node);
  blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", highestsupportedstance);
}

function private coverchangestanceactionstart(behaviortreeentity, asmstatename) {
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_alert");
  aiutility::keepclaimnode(behaviortreeentity);
  switch (blackboard::getblackboardattribute(behaviortreeentity, "_stance")) {
    case "stand": {
      blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "crouch");
      break;
    }
    case "crouch": {
      blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
      break;
    }
  }
}

function temp_get_arm_offset(behaviortreeentity, throwposition) {
  stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  arm_offset = undefined;
  if(stance == "crouch") {
    arm_offset = (13, -1, 56);
  } else {
    arm_offset = (14, -3, 80);
  }
  if(isDefined(behaviortreeentity.node) && behaviortreeentity isatcovernodestrict()) {
    if(behaviortreeentity.node.type == "Cover Left") {
      if(stance == "crouch") {
        arm_offset = (-38, 15, 23);
      } else {
        arm_offset = (-45, 0, 40);
      }
    } else {
      if(behaviortreeentity.node.type == "Cover Right") {
        if(stance == "crouch") {
          arm_offset = (46, 12, 26);
        } else {
          arm_offset = (34, -21, 50);
        }
      } else {
        if(behaviortreeentity.node.type == "Cover Stand" || behaviortreeentity.node.type == "Conceal Stand") {
          arm_offset = (10, 7, 77);
        } else {
          if(behaviortreeentity.node.type == "Cover Crouch" || behaviortreeentity.node.type == "Cover Crouch Window" || behaviortreeentity.node.type == "Conceal Crouch") {
            arm_offset = (19, 5, 60);
          } else if(behaviortreeentity.node.type == "Cover Pillar") {
            leftoffset = undefined;
            rightoffset = undefined;
            if(stance == "crouch") {
              leftoffset = (-20, 0, 35);
              rightoffset = (34, 6, 50);
            } else {
              leftoffset = (-24, 0, 76);
              rightoffset = (24, 0, 76);
            }
            if(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) {
              arm_offset = rightoffset;
            } else {
              if(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048) {
                arm_offset = leftoffset;
              } else {
                yawtoenemyposition = angleclamp180((vectortoangles(throwposition - behaviortreeentity.node.origin)[1]) - behaviortreeentity.node.angles[1]);
                aimlimitsfordirectionright = behaviortreeentity getaimlimitsfromentry("pillar_right_lean");
                legalrightdirectionyaw = yawtoenemyposition >= (aimlimitsfordirectionright["aim_right"] - 10) && yawtoenemyposition <= 0;
                if(legalrightdirectionyaw) {
                  arm_offset = rightoffset;
                } else {
                  arm_offset = leftoffset;
                }
              }
            }
          }
        }
      }
    }
  }
  return arm_offset;
}