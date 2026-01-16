/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_cover_utility.gsc
******************************************************/

#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;
#include scripts\core_common\ai_shared;
#include scripts\core_common\math_shared;

#namespace aiutility;

autoexec registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&isatcrouchnode));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcrouchnode", &isatcrouchnode);
  assert(iscodefunctionptr(&btapi_isatcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_isatcovercondition", &btapi_isatcovercondition);
  assert(isscriptfunctionptr(&isatcoverstrictcondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcoverstrictcondition", &isatcoverstrictcondition);
  assert(isscriptfunctionptr(&isatcovermodeover));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodeover", &isatcovermodeover);
  assert(isscriptfunctionptr(&isatcovermodenone));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isatcovermodenone", &isatcovermodenone);
  assert(isscriptfunctionptr(&isexposedatcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isexposedatcovercondition", &isexposedatcovercondition);
  assert(isscriptfunctionptr(&keepclaimednodeandchoosecoverdirection));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"keepclaimednodeandchoosecoverdirection", &keepclaimednodeandchoosecoverdirection);
  assert(isscriptfunctionptr(&resetcoverparameters));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"resetcoverparameters", &resetcoverparameters);
  assert(isscriptfunctionptr(&cleanupcovermode));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"cleanupcovermode", &cleanupcovermode);
  assert(isscriptfunctionptr(&canbeflankedservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"canbeflankedservice", &canbeflankedservice);
  assert(isscriptfunctionptr(&shouldcoveridleonly));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldcoveridleonly", &shouldcoveridleonly);
  assert(isscriptfunctionptr(&issuppressedatcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"issuppressedatcovercondition", &issuppressedatcovercondition);
  assert(isscriptfunctionptr(&coveridleinitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleinitialize", &coveridleinitialize);
  assert(iscodefunctionptr(&btapi_coveridleupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"btapi_coveridleupdate", &btapi_coveridleupdate);
  assert(isscriptfunctionptr(&coveridleupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleupdate", &coveridleupdate);
  assert(isscriptfunctionptr(&coveridleterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveridleterminate", &coveridleterminate);
  assert(isscriptfunctionptr(&shouldleanatcoveridlecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldleanatcoveridlecondition", &shouldleanatcoveridlecondition);
  assert(isscriptfunctionptr(&continueleaningatcoveridlecondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"continueleaningatcoveridlecondition", &continueleaningatcoveridlecondition, 5);
  assert(isscriptfunctionptr(&isflankedbyenemyatcover));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"isflankedbyenemyatcover", &isflankedbyenemyatcover);
  assert(isscriptfunctionptr(&coverflankedinitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverflankedactionstart", &coverflankedinitialize);
  assert(isscriptfunctionptr(&coverflankedactionterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverflankedactionterminate", &coverflankedactionterminate);
  assert(isscriptfunctionptr(&supportsovercovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsovercovercondition", &supportsovercovercondition);
  assert(isscriptfunctionptr(&shouldoveratcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldoveratcovercondition", &shouldoveratcovercondition);
  assert(isscriptfunctionptr(&coveroverinitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverinitialize", &coveroverinitialize);
  assert(isscriptfunctionptr(&coveroverterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coveroverterminate", &coveroverterminate);
  assert(isscriptfunctionptr(&function_b605a3b2));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_58ddf57d938c96a6", &function_b605a3b2);
  assert(isscriptfunctionptr(&supportsleancovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportsleancovercondition", &supportsleancovercondition);
  assert(isscriptfunctionptr(&shouldleanatcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"shouldleanatcovercondition", &shouldleanatcovercondition);
  assert(isscriptfunctionptr(&continueleaningatcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"continueleaningatcovercondition", &continueleaningatcovercondition, 1);
  assert(isscriptfunctionptr(&coverleaninitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverleaninitialize", &coverleaninitialize);
  assert(isscriptfunctionptr(&coverleanterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverleanterminate", &coverleanterminate);
  assert(isscriptfunctionptr(&function_9e5575be));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_72e14fa3a8f112e4", &function_9e5575be);
  assert(isscriptfunctionptr(&function_dc503571));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_229844e28015a254", &function_dc503571);
  assert(isscriptfunctionptr(&function_eb148f38));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_65aba356fa88122c", &function_eb148f38);
  assert(isscriptfunctionptr(&function_4c672ae3));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_35b14110efcdb018", &function_4c672ae3, 1);
  assert(isscriptfunctionptr(&function_a938cb03));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_636e311aa7ebc589", &function_a938cb03);
  assert(isscriptfunctionptr(&function_f82f8634));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2005ffaf6edd8e46", &function_f82f8634);
  assert(isscriptfunctionptr(&supportspeekcovercondition));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"supportspeekcovercondition", &supportspeekcovercondition);
  assert(isscriptfunctionptr(&coverpeekinitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpeekinitialize", &coverpeekinitialize);
  assert(isscriptfunctionptr(&coverpeekterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverpeekterminate", &coverpeekterminate);
  assert(isscriptfunctionptr(&coverreloadinitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"coverreloadinitialize", &coverreloadinitialize);
  assert(isscriptfunctionptr(&refillammoandcleanupcovermode));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"refillammoandcleanupcovermode", &refillammoandcleanupcovermode);
}

private coverreloadinitialize(entity) {
  entity setblackboardattribute("_cover_mode", "cover_alert");
  keepclaimnode(entity);
}

refillammoandcleanupcovermode(entity) {
  if(isalive(entity)) {
    refillammo(entity);
  }

  cleanupcovermode(entity);
}

private supportspeekcovercondition(entity) {
  return isDefined(entity.node);
}

private coverpeekinitialize(entity) {
  entity setblackboardattribute("_cover_mode", "cover_alert");
  keepclaimnode(entity);
  choosecoverdirection(entity);
}

private coverpeekterminate(entity) {
  choosefrontcoverdirection(entity);
  cleanupcovermode(entity);
}

private function_dc503571(entity) {
  if(isDefined(entity.node)) {
    if(entity.node.type == #"cover left" || entity.node.type == #"cover right") {
      return true;
    } else if(entity.node.type == #"cover pillar") {
      if(!(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024) || !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048)) {
        return true;
      }
    }
  }

  return false;
}

private function_eb148f38(entity) {
  if(!isDefined(entity.node) || !isDefined(entity.node.type) || !isDefined(entity.enemy) || !isDefined(entity.enemy.origin)) {
    return 0;
  }

  yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
  legalaimyaw = 0;

  if(entity.node.type == #"cover left") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
    legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= -10;
  } else if(entity.node.type == #"cover right") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
    legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= 10;
  } else if(entity.node.type == #"cover pillar") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover");
    supportsleft = !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024);
    supportsright = !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048);
    angleleeway = 10;

    if(supportsright && supportsleft) {
      angleleeway = 0;
    }

    if(supportsleft) {
      legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
    }

    if(!legalaimyaw && supportsright) {
      legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= angleleeway;
    }
  }

  return legalaimyaw;
}

private function_4c672ae3(entity) {
  if(entity asmistransitionrunning()) {
    return 1;
  }

  return function_eb148f38(entity);
}

private function_7353f95b(entity) {
  if(!isDefined(entity.node) || !isDefined(entity.node.type)) {
    return 0;
  }

  if(isDefined(entity.enemy)) {
    yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
  } else {
    pos = entity.node.origin + 250 * entity.node.angles;
    yawtoenemyposition = angleclamp180(vectortoangles(pos - entity.node.origin)[1] - entity.node.angles[1]);
  }

  legalaimyaw = 0;

  if(entity.node.type == #"cover left") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
    legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= -10;
  } else if(entity.node.type == #"cover right") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
    legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= 10;
  } else if(entity.node.type == #"cover pillar") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover");
    supportsleft = !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024);
    supportsright = !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048);
    angleleeway = 10;

    if(supportsright && supportsleft) {
      angleleeway = 0;
    }

    if(supportsleft) {
      legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
    }

    if(!legalaimyaw && supportsright) {
      legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= angleleeway;
    }
  }

  return legalaimyaw;
}

private function_e9788bfb(entity) {
  if(entity asmistransitionrunning()) {
    return 1;
  }

  return function_7353f95b(entity);
}

private function_a938cb03(entity) {
  setcovershootstarttime(entity);
  keepclaimnode(entity);
  entity setblackboardattribute("_cover_mode", "cover_lean");
  choosecoverdirection(entity);
}

private function_f82f8634(entity) {
  choosefrontcoverdirection(entity);
  cleanupcovermode(entity);
  clearcovershootstarttime(entity);
}

private supportsleancovercondition(entity) {
  if(isDefined(entity.node)) {
    if(entity.node.type == #"cover left" || entity.node.type == #"cover right") {
      return true;
    } else if(entity.node.type == #"cover pillar") {
      if(!(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024) || !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048)) {
        return true;
      }
    }
  }

  return false;
}

private shouldleanatcovercondition(entity) {
  if(!isDefined(entity.node) || !isDefined(entity.node.type) || !isDefined(entity.enemy) || !isDefined(entity.enemy.origin)) {
    return 0;
  }

  yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
  legalaimyaw = 0;

  if(entity.node.type == #"cover left") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
    legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= -10;
  } else if(entity.node.type == #"cover right") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
    legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= 10;
  } else if(entity.node.type == #"cover pillar") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover");
    supportsleft = !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024);
    supportsright = !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048);
    angleleeway = 10;

    if(supportsright && supportsleft) {
      angleleeway = 0;
    }

    if(supportsleft) {
      legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
    }

    if(!legalaimyaw && supportsright) {
      legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= angleleeway;
    }
  }

  return legalaimyaw;
}

private continueleaningatcovercondition(entity) {
  if(entity asmistransitionrunning()) {
    return 1;
  }

  return shouldleanatcovercondition(entity);
}

private shouldleanatcoveridlecondition(entity) {
  if(!isDefined(entity.node) || !isDefined(entity.node.type)) {
    return 0;
  }

  if(isDefined(entity.enemy)) {
    yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
  } else {
    pos = entity.node.origin + 250 * entity.node.angles;
    yawtoenemyposition = angleclamp180(vectortoangles(pos - entity.node.origin)[1] - entity.node.angles[1]);
  }

  legalaimyaw = 0;

  if(entity.node.type == #"cover left") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover_left_lean");
    legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= -10;
  } else if(entity.node.type == #"cover right") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover_right_lean");
    legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= 10;
  } else if(entity.node.type == #"cover pillar") {
    aimlimitsforcover = entity getaimlimitsfromentry("cover");
    supportsleft = !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024);
    supportsright = !(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048);
    angleleeway = 10;

    if(supportsright && supportsleft) {
      angleleeway = 0;
    }

    if(supportsleft) {
      legalaimyaw = yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10 && yawtoenemyposition >= angleleeway * -1;
    }

    if(!legalaimyaw && supportsright) {
      legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= angleleeway;
    }
  }

  return legalaimyaw;
}

private continueleaningatcoveridlecondition(entity) {
  if(entity asmistransitionrunning()) {
    return 1;
  }

  return shouldleanatcoveridlecondition(entity);
}

private coverleaninitialize(entity) {
  setcovershootstarttime(entity);
  keepclaimnode(entity);
  entity setblackboardattribute("_cover_mode", "cover_lean");
  choosecoverdirection(entity);
}

private coverleanterminate(entity) {
  choosefrontcoverdirection(entity);
  cleanupcovermode(entity);
  clearcovershootstarttime(entity);
}

private function_9e5575be(entity) {
  choosefrontcoverdirection(entity);
  cleanupcovermode(entity);
  clearcovershootstarttime(entity);
  entity ai::gun_recall();
  entity.blockingpain = 0;
}

private supportsovercovercondition(entity) {
  stance = entity getblackboardattribute("_stance");

  if(isDefined(entity.node)) {
    if(entity.node.type == #"conceal crouch" || entity.node.type == #"conceal stand") {
      return true;
    }

    if(!isinarray(getvalidcoverpeekouts(entity.node), "over")) {
      return false;
    }

    if(entity.node.type == #"cover left" || entity.node.type == #"cover right" || entity.node.type == #"cover crouch" || entity.node.type == #"cover crouch window" || entity.node.type == #"conceal crouch") {
      if(stance == "crouch") {
        return true;
      }
    } else if(entity.node.type == #"cover stand" || entity.node.type == #"conceal stand") {
      if(stance == "stand") {
        return true;
      }
    }
  }

  return false;
}

private shouldoveratcovercondition(entity) {
  if(!isDefined(entity.node) || !isDefined(entity.node.type) || !isDefined(entity.enemy) || !isDefined(entity.enemy.origin)) {
    return false;
  }

  aimtable = iscoverconcealed(entity.node) ? "cover_concealed_over" : "cover_over";
  aimlimitsforcover = entity getaimlimitsfromentry(aimtable);
  yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
  legalaimyaw = yawtoenemyposition >= aimlimitsforcover[#"aim_right"] - 10 && yawtoenemyposition <= aimlimitsforcover[#"aim_left"] + 10;

  if(!legalaimyaw) {
    return false;
  }

  pitchtoenemyposition = getaimpitchtoenemyfromnode(entity, entity.node, entity.enemy);
  legalaimpitch = pitchtoenemyposition >= aimlimitsforcover[#"aim_up"] + 10 && pitchtoenemyposition <= aimlimitsforcover[#"aim_down"] + 10;

  if(!legalaimpitch) {
    return false;
  }

  return true;
}

private coveroverinitialize(entity) {
  setcovershootstarttime(entity);
  keepclaimnode(entity);
  entity setblackboardattribute("_cover_mode", "cover_over");
}

private coveroverterminate(entity) {
  cleanupcovermode(entity);
  clearcovershootstarttime(entity);
}

private function_b605a3b2(entity) {
  coveroverterminate(entity);
  entity ai::gun_recall();
  entity.blockingpain = 0;
}

private coveridleinitialize(entity) {
  keepclaimnode(entity);
  entity setblackboardattribute("_cover_mode", "cover_alert");
}

private coveridleupdate(entity) {
  if(!entity asmistransitionrunning()) {
    releaseclaimnode(entity);
  }
}

private coveridleterminate(entity) {
  releaseclaimnode(entity);
  cleanupcovermode(entity);
}

private isflankedbyenemyatcover(entity) {
  return canbeflanked(entity) && entity isatcovernodestrict() && entity isflankedatcovernode() && !entity haspath();
}

private canbeflankedservice(entity) {
  setcanbeflanked(entity, 1);
}

private coverflankedinitialize(entity) {
  if(isDefined(entity.enemy)) {
    entity getperfectinfo(entity.enemy);
    entity pathmode("move delayed", 0, 2);
  }

  setcanbeflanked(entity, 0);
  cleanupcovermode(entity);
  keepclaimnode(entity);
  entity setblackboardattribute("_desired_stance", "stand");
}

private coverflankedactionterminate(entity) {
  entity.newenemyreaction = 0;
  releaseclaimnode(entity);
}

isatcrouchnode(entity) {
  if(isDefined(entity.node) && (entity.node.type == #"exposed" || entity.node.type == #"guard" || entity.node.type == #"path")) {
    if(distancesquared(entity.origin, entity.node.origin) <= 24 * 24) {
      return (!isstanceallowedatnode("stand", entity.node) && isstanceallowedatnode("crouch", entity.node));
    }
  }

  return false;
}

isatcoverstrictcondition(entity) {
  return entity isatcovernodestrict() && !entity haspath();
}

isatcovermodeover(entity) {
  covermode = entity getblackboardattribute("_cover_mode");
  return covermode == "cover_over";
}

isatcovermodenone(entity) {
  covermode = entity getblackboardattribute("_cover_mode");
  return covermode == "cover_mode_none";
}

isexposedatcovercondition(entity) {
  return entity isatcovernodestrict() && !entity shouldusecovernode();
}

shouldcoveridleonly(entity) {
  if(entity ai::get_behavior_attribute("coverIdleOnly")) {
    return true;
  }

  if(isDefined(entity.node.script_onlyidle) && entity.node.script_onlyidle) {
    return true;
  }

  return false;
}

issuppressedatcovercondition(entity) {
  return entity.suppressionmeter > entity.suppressionthreshold;
}

keepclaimednodeandchoosecoverdirection(entity) {
  keepclaimnode(entity);
  choosecoverdirection(entity);
}

resetcoverparameters(entity) {
  choosefrontcoverdirection(entity);
  cleanupcovermode(entity);
  clearcovershootstarttime(entity);
}

choosecoverdirection(entity, stepout) {
  if(!isDefined(entity.node)) {
    return;
  }

  coverdirection = entity getblackboardattribute("_cover_direction");
  entity setblackboardattribute("_previous_cover_direction", coverdirection);
  entity setblackboardattribute("_cover_direction", calculatecoverdirection(entity, stepout));
}

calculatecoverdirection(entity, stepout) {
  if(isDefined(entity.treatallcoversasgeneric)) {
    if(!isDefined(stepout)) {
      stepout = 0;
    }

    coverdirection = "cover_front_direction";

    if(entity.node.type == #"cover left") {
      if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&4) == 4 || math::cointoss() || stepout) {
        coverdirection = "cover_left_direction";
      }
    } else if(entity.node.type == #"cover right") {
      if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&4) == 4 || math::cointoss() || stepout) {
        coverdirection = "cover_right_direction";
      }
    } else if(entity.node.type == #"cover pillar") {
      if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024) {
        return "cover_right_direction";
      }

      if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048) {
        return "cover_left_direction";
      }

      coverdirection = "cover_left_direction";

      if(isDefined(entity.enemy)) {
        yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
        aimlimitsfordirectionright = entity getaimlimitsfromentry("pillar_right_lean");
        legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright[#"aim_right"] - 10 && yawtoenemyposition <= 0;

        if(legalrightdirectionyaw) {
          coverdirection = "cover_right_direction";
        }
      }
    }

    return coverdirection;
  } else {
    coverdirection = "cover_front_direction";

    if(entity.node.type == #"cover pillar") {
      if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&1024) == 1024) {
        return "cover_right_direction";
      }

      if(isDefined(entity.node.spawnflags) && (entity.node.spawnflags&2048) == 2048) {
        return "cover_left_direction";
      }

      coverdirection = "cover_left_direction";

      if(isDefined(entity.enemy)) {
        yawtoenemyposition = getaimyawtoenemyfromnode(entity, entity.node, entity.enemy);
        aimlimitsfordirectionright = entity getaimlimitsfromentry("pillar_right_lean");
        legalrightdirectionyaw = yawtoenemyposition >= aimlimitsfordirectionright[#"aim_right"] - 10 && yawtoenemyposition <= 0;

        if(legalrightdirectionyaw) {
          coverdirection = "cover_right_direction";
        }
      }
    }
  }

  return coverdirection;
}

clearcovershootstarttime(entity) {
  entity.covershootstarttime = undefined;
}

setcovershootstarttime(entity) {
  entity.covershootstarttime = gettime();
}

canbeflanked(entity) {
  return isDefined(entity.canbeflanked) && entity.canbeflanked;
}

setcanbeflanked(entity, canbeflanked) {
  entity.canbeflanked = canbeflanked;
}

cleanupcovermode(entity) {
  if(btapi_isatcovercondition(entity)) {
    covermode = entity getblackboardattribute("_cover_mode");
    entity setblackboardattribute("_previous_cover_mode", covermode);
    entity setblackboardattribute("_cover_mode", "cover_mode_none");
    return;
  }

  entity setblackboardattribute("_previous_cover_mode", "cover_mode_none");
  entity setblackboardattribute("_cover_mode", "cover_mode_none");
}