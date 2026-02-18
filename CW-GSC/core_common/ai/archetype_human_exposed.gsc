/******************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human_exposed.gsc
******************************************************/

#using scripts\core_common\ai\archetype_cover_utility;
#using scripts\core_common\ai\archetype_human_cover;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\behavior_state_machine;
#using scripts\core_common\ai\systems\behavior_tree_utility;
#namespace archetype_human_exposed;

function autoexec registerbehaviorscriptfunctions() {
  assert(isscriptfunctionptr(&hascloseenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi("hasCloseEnemy", &hascloseenemy);
  assert(isscriptfunctionptr(&nocloseenemyservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("noCloseEnemyService", &nocloseenemyservice);
  assert(isscriptfunctionptr(&tryreacquireservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("tryReacquireService", &tryreacquireservice);
  assert(isscriptfunctionptr(&preparetoreacttoenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToReactToEnemy", &preparetoreacttoenemy);
  assert(isscriptfunctionptr(&resetreactiontoenemy));
  behaviortreenetworkutility::registerbehaviortreescriptapi("resetReactionToEnemy", &resetreactiontoenemy);
  assert(isscriptfunctionptr(&function_fa6d93ea));
  behaviortreenetworkutility::registerbehaviortreescriptapi(#"hash_2ec2006a59a43ce", &function_fa6d93ea);
  assert(isscriptfunctionptr(&exposedupdateservice));
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedUpdateService", &exposedupdateservice);
  assert(isscriptfunctionptr(&exposedshootstart));
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedShootStart", &exposedshootstart);
  assert(isscriptfunctionptr(&exposedshootupdate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedShootUpdate", &exposedshootupdate);
  assert(isscriptfunctionptr(&exposedshootterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedShootTerminate", &exposedshootterminate);
  assert(isscriptfunctionptr(&exposedreloadinitialize));
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedReloadInitialize", &exposedreloadinitialize);
  assert(isscriptfunctionptr(&exposedreloadterminate));
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedReloadTerminate", &exposedreloadterminate);
  assert(isscriptfunctionptr(&exposedsetdesiredstancetostand));
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedSetDesiredStanceToStand", &exposedsetdesiredstancetostand);
  assert(isscriptfunctionptr(&setpathmovedelayedrandom));
  behaviortreenetworkutility::registerbehaviortreescriptapi("setPathMoveDelayedRandom", &setpathmovedelayedrandom);
  assert(isscriptfunctionptr(&shouldusesidearmpistol));
  behaviortreenetworkutility::registerbehaviortreescriptapi("shouldUseSidearmPistol", &shouldusesidearmpistol);
  assert(isscriptfunctionptr(&function_ec3ea122));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_bf0ead963f57001", &function_ec3ea122);
  assert(isscriptfunctionptr(&function_bb575b62));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_30b41b7040b96c68", &function_bb575b62);
  assert(isscriptfunctionptr(&isusingsidearm));
  behaviorstatemachine::registerbsmscriptapiinternal(#"isusingsidearm", &isusingsidearm);
  assert(isscriptfunctionptr(&outofammo));
  behaviorstatemachine::registerbsmscriptapiinternal(#"outofammo", &outofammo);
  assert(isscriptfunctionptr(&function_56512b87));
  behaviorstatemachine::registerbsmscriptapiinternal(#"hash_b01c4c3e55f7cd", &function_56512b87);
}

function function_fa6d93ea(entity) {
  if(btapi_locomotionbehaviorcondition(entity) && !entity shouldholdgroundagainstenemy()) {
    return false;
  }

  if(btapi_isatcovercondition(entity)) {
    if(entity isatcovernodestrict() && is_true(entity.var_342553bc)) {
      if(archetype_human_cover::function_1fa73a96(entity)) {
        return true;
      }

      if(is_true(entity.ai.reloading)) {
        return true;
      }

      if(isDefined(entity.var_541abeb7) && gettime() - entity.var_541abeb7 < 3000) {
        if(distancesquared(entity.origin, entity.var_99d0daef) < sqr(32)) {
          return true;
        }
      }
    }

    return false;
  }

  return true;
}

function private exposedupdateservice(entity) {
  if(entity isatcovernode()) {
    aiutility::function_3823e69e(entity);
    entity.var_342553bc = 1;
    entity.var_b8cc25c = 0;
    entity.var_f13fb34f = gettime();
    entity.var_39226de1 = entity.origin;
  }
}

function private exposedshootstart(entity) {
  aiutility::releaseclaimnode(entity);
  entity.var_b636f23b = 0;
  entity.var_a4f84a7f = entity.lastshottime;
}

function private exposedshootupdate(entity) {
  if(entity asmistransitionrunning()) {
    return;
  }

  if(entity.lastshottime > entity.var_a4f84a7f) {
    entity.var_b636f23b = 0;
    entity.var_a4f84a7f = entity.lastshottime;
  }

  if(isDefined(entity.enemy) && entity cansee(entity.enemy)) {
    entity.var_b636f23b += 0.05;
  } else {
    entity.var_b636f23b = 0;
  }

  if(entity.var_b636f23b >= 5) {
    entity.nextfindbestcovertime = gettime();
    entity.var_b636f23b = 0;
  }
}

function private exposedshootterminate(entity) {
  entity.var_b636f23b = undefined;
  entity.var_a4f84a7f = undefined;
}

function private exposedreloadinitialize(entity) {
  aiutility::keepclaimnode(entity);
  aiutility::function_43a090a8(entity);
}

function private exposedreloadterminate(entity) {
  if(isalive(entity)) {
    aiutility::reloadterminate(entity);
  }

  aiutility::releaseclaimnode(entity);
}

function private preparetoreacttoenemy(behaviortreeentity) {
  behaviortreeentity.newenemyreaction = 0;
  behaviortreeentity.malfunctionreaction = 0;
  behaviortreeentity pathmode("move delayed", 1, 3);
}

function private resetreactiontoenemy(behaviortreeentity) {
  behaviortreeentity.newenemyreaction = 0;
  behaviortreeentity.malfunctionreaction = 0;
}

function private nocloseenemyservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy) && aiutility::hascloseenemytomelee(behaviortreeentity)) {
    behaviortreeentity clearpath();
    return true;
  }

  return false;
}

function private hascloseenemy(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }

  if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 22500) {
    return true;
  }

  return false;
}

function private function_56512b87(entity) {
  entity.bulletsinclip = entity.sidearm.clipsize;
  return true;
}

function private outofammo(entity) {
  outofammo = 0;

  if(entity.bulletsinclip <= 0) {
    outofammo = 1;
  }

  return outofammo;
}

function private function_bb575b62(entity) {
  return true;
}

function private isusingsidearm(entity) {
  return entity.weapon != entity.primaryweapon;
}

function private function_ec3ea122(entity) {
  return !shouldusesidearmpistol(entity, sqr(500));
}

function private shouldusesidearmpistol(entity, checkdistance = sqr(300)) {
  var_64c23a1b = 0;

  if(isDefined(entity.sidearm)) {
    if(is_true(entity.forcesidearm)) {
      var_64c23a1b = 1;
    } else if(is_true(entity.var_742cee23)) {
      if(isDefined(entity.enemy) && distancesquared(entity.origin, entity.enemy.origin) < checkdistance) {
        targetangles = vectortoangles(entity.enemy.origin - entity.origin);
        entityangles = entity.angles;

        if(isDefined(entity.node) && (entity.node.type == # "cover left" || entity.node.type == # "cover right" || entity.node.type == # "cover pillar" || entity.node.type == # "cover stand" || entity.node.type == # "conceal stand" || entity.node.type == # "cover crouch" || entity.node.type == # "cover crouch window" || entity.node.type == # "conceal crouch") && btapi_isatcovercondition(entity)) {
          entityangles = entity.node.angles;
        }

        var_507685eb = angleclamp180(targetangles[1] - entityangles[1]);

        if(abs(var_507685eb) < 60) {
          var_64c23a1b = 1;
        }
      }
    }
  }

  var_f5093b66 = is_true(entity.usingsidearm);

  if(var_64c23a1b != var_f5093b66) {
    println("<dev string:x38>" + entity getentnum() + "<dev string:x43>" + var_64c23a1b + "<dev string:x6b>");
  }

  entity.usingsidearm = var_64c23a1b;
  return var_64c23a1b;
}

function private setpathmovedelayedrandom(behaviortreeentity, asmstatename) {
  asmstatename pathmode("move delayed", 0, randomfloatrange(1, 3));
}

function private exposedsetdesiredstancetostand(behaviortreeentity, asmstatename) {
  aiutility::keepclaimnode(asmstatename);
  currentstance = asmstatename getblackboardattribute("_stance");
  asmstatename setblackboardattribute("_desired_stance", "stand");
}

function private tryreacquireservice(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.reacquire_state)) {
    behaviortreeentity.reacquire_state = 0;
  }

  var_d78ca29a = aiutility::function_589c524f(behaviortreeentity);

  if(var_d78ca29a == 4) {
    behaviortreeentity function_d4c687c9();
    behaviortreeentity.ai.var_47823ae7 = gettime() + 5000;
  }

  if(!isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  if(aiutility::isexposedatcovercondition(behaviortreeentity)) {
    return false;
  }

  if(isDefined(behaviortreeentity.ai.var_47823ae7) && gettime() < behaviortreeentity.ai.var_47823ae7) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  if(behaviortreeentity.birthtime + 1000 > gettime()) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  if(behaviortreeentity haspath()) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  if(is_true(behaviortreeentity.fixednode)) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  if(behaviortreeentity seerecently(behaviortreeentity.enemy, 4)) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  dirtoenemy = vectornormalize(behaviortreeentity.enemy.origin - behaviortreeentity.origin);
  forward = anglesToForward(behaviortreeentity.angles);

  if(vectordot(dirtoenemy, forward) < 0.5) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  switch (behaviortreeentity.reacquire_state) {
    case 0:
    case 1:
    case 2:
      step_size = 32 + behaviortreeentity.reacquire_state * 32;
      reacquirepos = behaviortreeentity reacquirestep(step_size);
      break;
    case 4:
      if(!behaviortreeentity cansee(behaviortreeentity.enemy) || !behaviortreeentity canshootenemy()) {
        behaviortreeentity flagenemyunattackable();
      }

      break;
    default:
      if(behaviortreeentity.reacquire_state > 15) {
        behaviortreeentity.reacquire_state = 0;
        return false;
      }

      break;
  }

  if(isvec(reacquirepos)) {
    behaviortreeentity.ai.var_bb3caa0f = gettime();
    behaviortreeentity function_a57c34b7(reacquirepos, undefined, "exposed_reacquire");
    return true;
  }

  behaviortreeentity.reacquire_state++;
  return false;
}