/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_cover_utility.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#using scripts\shared\math_shared;
#namespace aiutility;

function autoexec registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCrouchNode", &isatcrouchnode);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverCondition", &isatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverStrictCondition", &isatcoverstrictcondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverModeOver", &isatcovermodeover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isAtCoverModeNone", &isatcovermodenone);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isExposedAtCoverCondition", &isexposedatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("keepClaimedNodeAndChooseCoverDirection", &keepclaimednodeandchoosecoverdirection);
  behaviortreenetworkutility::registerbehaviortreescriptapi("resetCoverParameters", &resetcoverparameters);
  behaviortreenetworkutility::registerbehaviortreescriptapi("cleanupCoverMode", &cleanupcovermode);
  behaviortreenetworkutility::registerbehaviortreescriptapi("canBeFlankedService", &canbeflankedservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldCoverIdleOnly", &shouldcoveridleonly);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isSuppressedAtCoverCondition", &issuppressedatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleInitialize", &coveridleinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleUpdate", &coveridleupdate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverIdleTerminate", &coveridleterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("isFlankedByEnemyAtCover", &isflankedbyenemyatcover);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverFlankedActionStart", &coverflankedinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverFlankedActionTerminate", &coverflankedactionterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("supportsOverCoverCondition", &supportsovercovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldOverAtCoverCondition", &shouldoveratcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverOverInitialize", &coveroverinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverOverTerminate", &coveroverterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("supportsLeanCoverCondition", &supportsleancovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldLeanAtCoverCondition", &shouldleanatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("continueLeaningAtCoverCondition", &continueleaningatcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverLeanInitialize", &coverleaninitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverLeanTerminate", &coverleanterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("supportsPeekCoverCondition", &supportspeekcovercondition);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverPeekInitialize", &coverpeekinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverPeekTerminate", &coverpeekterminate);
  behaviortreenetworkutility::registerbehaviortreescriptapi("coverReloadInitialize", &coverreloadinitialize);
  behaviortreenetworkutility::registerbehaviortreescriptapi("refillAmmoAndCleanupCoverMode", &refillammoandcleanupcovermode);
}

function private coverreloadinitialize(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_alert");
  keepclaimnode(behaviortreeentity);
}

function refillammoandcleanupcovermode(behaviortreeentity) {
  if(isalive(behaviortreeentity)) {
    refillammo(behaviortreeentity);
  }
  cleanupcovermode(behaviortreeentity);
}

function private supportspeekcovercondition(behaviortreeentity) {
  return isDefined(behaviortreeentity.node);
}

function private coverpeekinitialize(behaviortreeentity) {
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_alert");
  keepclaimnode(behaviortreeentity);
  choosecoverdirection(behaviortreeentity);
}

function private coverpeekterminate(behaviortreeentity) {
  choosefrontcoverdirection(behaviortreeentity);
  cleanupcovermode(behaviortreeentity);
}

function private supportsleancovercondition(behaviortreeentity) {
  if(isDefined(behaviortreeentity.node)) {
    if(behaviortreeentity.node.type == "Cover Left" || behaviortreeentity.node.type == "Cover Right") {
      return true;
    }
    if(behaviortreeentity.node.type == "Cover Pillar") {
      if(!(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) || (!(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048))) {
        return true;
      }
    }
  }
  return false;
}

function private shouldleanatcovercondition(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.node) || !isDefined(behaviortreeentity.node.type) || !isDefined(behaviortreeentity.enemy) || !isDefined(behaviortreeentity.enemy.origin)) {
    return 0;
  }
  yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
  legalaimyaw = 0;
  if(behaviortreeentity.node.type == "Cover Left") {
    aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_left_lean");
    legalaimyaw = yawtoenemyposition <= (aimlimitsforcover["aim_left"] + 10) && yawtoenemyposition >= -10;
  } else {
    if(behaviortreeentity.node.type == "Cover Right") {
      aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover_right_lean");
      legalaimyaw = yawtoenemyposition >= (aimlimitsforcover["aim_right"] - 10) && yawtoenemyposition <= 10;
    } else if(behaviortreeentity.node.type == "Cover Pillar") {
      aimlimitsforcover = behaviortreeentity getaimlimitsfromentry("cover");
      supportsleft = !(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024);
      supportsright = !(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048);
      angleleeway = 10;
      if(supportsright && supportsleft) {
        angleleeway = 0;
      }
      if(supportsleft) {
        legalaimyaw = yawtoenemyposition <= (aimlimitsforcover["aim_left"] + 10) && yawtoenemyposition >= (angleleeway * -1);
      }
      if(!legalaimyaw && supportsright) {
        legalaimyaw = yawtoenemyposition >= (aimlimitsforcover["aim_right"] - 10) && yawtoenemyposition <= angleleeway;
      }
    }
  }
  return legalaimyaw;
}

function private continueleaningatcovercondition(behaviortreeentity) {
  if(behaviortreeentity asmistransitionrunning()) {
    return 1;
  }
  return shouldleanatcovercondition(behaviortreeentity);
}

function private coverleaninitialize(behaviortreeentity) {
  setcovershootstarttime(behaviortreeentity);
  keepclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_lean");
  choosecoverdirection(behaviortreeentity);
}

function private coverleanterminate(behaviortreeentity) {
  choosefrontcoverdirection(behaviortreeentity);
  cleanupcovermode(behaviortreeentity);
  clearcovershootstarttime(behaviortreeentity);
}

function private supportsovercovercondition(behaviortreeentity) {
  stance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  if(isDefined(behaviortreeentity.node)) {
    if(!isinarray(getvalidcoverpeekouts(behaviortreeentity.node), "over")) {
      return false;
    }
    if(behaviortreeentity.node.type == "Cover Left" || behaviortreeentity.node.type == "Cover Right" || (behaviortreeentity.node.type == "Cover Crouch" || behaviortreeentity.node.type == "Cover Crouch Window" || behaviortreeentity.node.type == "Conceal Crouch")) {
      if(stance == "crouch") {
        return true;
      }
    } else if(behaviortreeentity.node.type == "Cover Stand" || behaviortreeentity.node.type == "Conceal Stand") {
      if(stance == "stand") {
        return true;
      }
    }
  }
  return false;
}

function private shouldoveratcovercondition(entity) {
  if(!isDefined(entity.node) || !isDefined(entity.node.type) || !isDefined(entity.enemy) || !isDefined(entity.enemy.origin)) {
    return false;
  }
  aimtable = (iscoverconcealed(entity.node) ? "cover_concealed_over" : "cover_over");
  aimlimitsforcover = entity getaimlimitsfromentry(aimtable);
  yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
  legalaimyaw = yawtoenemyposition >= (aimlimitsforcover["aim_right"] - 10) && yawtoenemyposition <= (aimlimitsforcover["aim_left"] + 10);
  if(!legalaimyaw) {
    return false;
  }
  pitchtoenemyposition = getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
  legalaimpitch = pitchtoenemyposition >= (aimlimitsforcover["aim_up"] + 10) && pitchtoenemyposition <= (aimlimitsforcover["aim_down"] + 10);
  if(!legalaimpitch) {
    return false;
  }
  return true;
}

function private coveroverinitialize(behaviortreeentity) {
  setcovershootstarttime(behaviortreeentity);
  keepclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_over");
}

function private coveroverterminate(behaviortreeentity) {
  cleanupcovermode(behaviortreeentity);
  clearcovershootstarttime(behaviortreeentity);
}

function private coveridleinitialize(behaviortreeentity) {
  keepclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_alert");
}

function private coveridleupdate(behaviortreeentity) {
  if(!behaviortreeentity asmistransitionrunning()) {
    releaseclaimnode(behaviortreeentity);
  }
}

function private coveridleterminate(behaviortreeentity) {
  releaseclaimnode(behaviortreeentity);
  cleanupcovermode(behaviortreeentity);
}

function private isflankedbyenemyatcover(behaviortreeentity) {
  return canbeflanked(behaviortreeentity) && behaviortreeentity isatcovernodestrict() && behaviortreeentity isflankedatcovernode() && !behaviortreeentity haspath();
}

function private canbeflankedservice(behaviortreeentity) {
  setcanbeflanked(behaviortreeentity, 1);
}

function private coverflankedinitialize(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity getperfectinfo(behaviortreeentity.enemy);
    behaviortreeentity pathmode("move delayed", 0, 2);
  }
  setcanbeflanked(behaviortreeentity, 0);
  cleanupcovermode(behaviortreeentity);
  keepclaimnode(behaviortreeentity);
  blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
}

function private coverflankedactionterminate(behaviortreeentity) {
  behaviortreeentity.newenemyreaction = 0;
  releaseclaimnode(behaviortreeentity);
}

function isatcrouchnode(behaviortreeentity) {
  if(isDefined(behaviortreeentity.node) && (behaviortreeentity.node.type == "Exposed" || behaviortreeentity.node.type == "Guard" || behaviortreeentity.node.type == "Path")) {
    if(distancesquared(behaviortreeentity.origin, behaviortreeentity.node.origin) <= (24 * 24)) {
      return !isstanceallowedatnode("stand", behaviortreeentity.node) && isstanceallowedatnode("crouch", behaviortreeentity.node);
    }
  }
  return 0;
}

function isatcovercondition(behaviortreeentity) {
  return behaviortreeentity isatcovernodestrict() && behaviortreeentity shouldusecovernode() && !behaviortreeentity haspath();
}

function isatcoverstrictcondition(behaviortreeentity) {
  return behaviortreeentity isatcovernodestrict() && !behaviortreeentity haspath();
}

function isatcovermodeover(behaviortreeentity) {
  covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
  return covermode == "cover_over";
}

function isatcovermodenone(behaviortreeentity) {
  covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
  return covermode == "cover_mode_none";
}

function isexposedatcovercondition(behaviortreeentity) {
  return behaviortreeentity isatcovernodestrict() && !behaviortreeentity shouldusecovernode();
}

function shouldcoveridleonly(behaviortreeentity) {
  if(behaviortreeentity ai::get_behavior_attribute("coverIdleOnly")) {
    return true;
  }
  if(isDefined(behaviortreeentity.node.script_onlyidle) && behaviortreeentity.node.script_onlyidle) {
    return true;
  }
  return false;
}

function issuppressedatcovercondition(behaviortreeentity) {
  return behaviortreeentity.suppressionmeter > behaviortreeentity.suppressionthreshold;
}

function keepclaimednodeandchoosecoverdirection(behaviortreeentity) {
  keepclaimnode(behaviortreeentity);
  choosecoverdirection(behaviortreeentity);
}

function resetcoverparameters(behaviortreeentity) {
  choosefrontcoverdirection(behaviortreeentity);
  cleanupcovermode(behaviortreeentity);
  clearcovershootstarttime(behaviortreeentity);
}

function choosecoverdirection(behaviortreeentity, stepout) {
  if(!isDefined(behaviortreeentity.node)) {
    return;
  }
  coverdirection = blackboard::getblackboardattribute(behaviortreeentity, "_cover_direction");
  blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_direction", coverdirection);
  blackboard::setblackboardattribute(behaviortreeentity, "_cover_direction", calculatecoverdirection(behaviortreeentity, stepout));
}

function calculatecoverdirection(behaviortreeentity, stepout) {
  if(isDefined(behaviortreeentity.treatallcoversasgeneric)) {
    if(!isDefined(stepout)) {
      stepout = 0;
    }
    coverdirection = "cover_front_direction";
    if(behaviortreeentity.node.type == "Cover Left") {
      if(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 4) == 4 || math::cointoss() || stepout) {
        coverdirection = "cover_left_direction";
      }
    } else {
      if(behaviortreeentity.node.type == "Cover Right") {
        if(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 4) == 4 || math::cointoss() || stepout) {
          coverdirection = "cover_right_direction";
        }
      } else if(behaviortreeentity.node.type == "Cover Pillar") {
        if(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) {
          return "cover_right_direction";
        }
        if(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048) {
          return "cover_left_direction";
        }
        coverdirection = "cover_left_direction";
        if(isDefined(behaviortreeentity.enemy)) {
          yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
          aimlimitsfordirectionright = behaviortreeentity getaimlimitsfromentry("pillar_right_lean");
          legalrightdirectionyaw = yawtoenemyposition >= (aimlimitsfordirectionright["aim_right"] - 10) && yawtoenemyposition <= 0;
          if(legalrightdirectionyaw) {
            coverdirection = "cover_right_direction";
          }
        }
      }
    }
    return coverdirection;
  }
  coverdirection = "cover_front_direction";
  if(behaviortreeentity.node.type == "Cover Pillar") {
    if(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 1024) == 1024) {
      return "cover_right_direction";
    }
    if(isDefined(behaviortreeentity.node.spawnflags) && (behaviortreeentity.node.spawnflags & 2048) == 2048) {
      return "cover_left_direction";
    }
    coverdirection = "cover_left_direction";
    if(isDefined(behaviortreeentity.enemy)) {
      yawtoenemyposition = getaimyawtoenemyfromnode(behaviortreeentity, behaviortreeentity.node, behaviortreeentity.enemy);
      aimlimitsfordirectionright = behaviortreeentity getaimlimitsfromentry("pillar_right_lean");
      legalrightdirectionyaw = yawtoenemyposition >= (aimlimitsfordirectionright["aim_right"] - 10) && yawtoenemyposition <= 0;
      if(legalrightdirectionyaw) {
        coverdirection = "cover_right_direction";
      }
    }
  }
  return coverdirection;
}

function clearcovershootstarttime(behaviortreeentity) {
  behaviortreeentity.covershootstarttime = undefined;
}

function setcovershootstarttime(behaviortreeentity) {
  behaviortreeentity.covershootstarttime = gettime();
}

function canbeflanked(behaviortreeentity) {
  return isDefined(behaviortreeentity.canbeflanked) && behaviortreeentity.canbeflanked;
}

function setcanbeflanked(behaviortreeentity, canbeflanked) {
  behaviortreeentity.canbeflanked = canbeflanked;
}

function cleanupcovermode(behaviortreeentity) {
  if(isatcovercondition(behaviortreeentity)) {
    covermode = blackboard::getblackboardattribute(behaviortreeentity, "_cover_mode");
    blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_mode", covermode);
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_mode_none");
  } else {
    blackboard::setblackboardattribute(behaviortreeentity, "_previous_cover_mode", "cover_mode_none");
    blackboard::setblackboardattribute(behaviortreeentity, "_cover_mode", "cover_mode_none");
  }
}