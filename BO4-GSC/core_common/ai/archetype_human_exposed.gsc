/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human_exposed.gsc
******************************************************/

#include scripts\core_common\ai\archetype_utility;
#include scripts\core_common\ai\systems\behavior_tree_utility;

#namespace archetype_human_exposed;

autoexec registerbehaviorscriptfunctions() {
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
  assert(isscriptfunctionptr(&exposedsetdesiredstancetostand));
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedSetDesiredStanceToStand", &exposedsetdesiredstancetostand);
  assert(isscriptfunctionptr(&setpathmovedelayedrandom));
  behaviortreenetworkutility::registerbehaviortreescriptapi("setPathMoveDelayedRandom", &setpathmovedelayedrandom);
}

private preparetoreacttoenemy(behaviortreeentity) {
  behaviortreeentity.newenemyreaction = 0;
  behaviortreeentity.malfunctionreaction = 0;
  behaviortreeentity pathmode("move delayed", 1, 3);
}

private resetreactiontoenemy(behaviortreeentity) {
  behaviortreeentity.newenemyreaction = 0;
  behaviortreeentity.malfunctionreaction = 0;
}

private nocloseenemyservice(behaviortreeentity) {
  if(isDefined(behaviortreeentity.enemy) && aiutility::hascloseenemytomelee(behaviortreeentity)) {
    behaviortreeentity clearpath();
    return true;
  }

  return false;
}

private hascloseenemy(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.enemy)) {
    return false;
  }

  if(distancesquared(behaviortreeentity.origin, behaviortreeentity.enemy.origin) < 22500) {
    return true;
  }

  return false;
}

private setpathmovedelayedrandom(behaviortreeentity, asmstatename) {
  behaviortreeentity pathmode("move delayed", 0, randomfloatrange(1, 3));
}

private exposedsetdesiredstancetostand(behaviortreeentity, asmstatename) {
  aiutility::keepclaimnode(behaviortreeentity);
  currentstance = behaviortreeentity getblackboardattribute("_stance");
  behaviortreeentity setblackboardattribute("_desired_stance", "stand");
}

private tryreacquireservice(behaviortreeentity) {
  if(!isDefined(behaviortreeentity.reacquire_state)) {
    behaviortreeentity.reacquire_state = 0;
  }

  if(!isDefined(behaviortreeentity.enemy)) {
    behaviortreeentity.reacquire_state = 0;
    return false;
  }

  if(behaviortreeentity haspath()) {
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
    behaviortreeentity function_a57c34b7(reacquirepos);
    return true;
  }

  behaviortreeentity.reacquire_state++;
  return false;
}