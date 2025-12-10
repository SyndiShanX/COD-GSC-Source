/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_human_exposed.gsc
*************************************************/

#using scripts\shared\ai\archetype_utility;
#using scripts\shared\ai\systems\animation_state_machine_utility;
#using scripts\shared\ai\systems\behavior_tree_utility;
#using scripts\shared\ai\systems\blackboard;
#using scripts\shared\ai_shared;
#namespace archetype_human_exposed;

function autoexec registerbehaviorscriptfunctions() {
  behaviortreenetworkutility::registerbehaviortreescriptapi("hasCloseEnemy", &hascloseenemy);
  behaviortreenetworkutility::registerbehaviortreescriptapi("noCloseEnemyService", &nocloseenemyservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("tryReacquireService", &tryreacquireservice);
  behaviortreenetworkutility::registerbehaviortreescriptapi("prepareToReactToEnemy", &preparetoreacttoenemy);
  behaviortreenetworkutility::registerbehaviortreescriptapi("resetReactionToEnemy", &resetreactiontoenemy);
  behaviortreenetworkutility::registerbehaviortreescriptapi("exposedSetDesiredStanceToStand", &exposedsetdesiredstancetostand);
  behaviortreenetworkutility::registerbehaviortreescriptapi("setPathMoveDelayedRandom", &setpathmovedelayedrandom);
  behaviortreenetworkutility::registerbehaviortreescriptapi("vengeanceService", &vengeanceservice);
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

function private _isvalidneighbor(entity, neighbor) {
  return isDefined(neighbor) && entity.team === neighbor.team;
}

function private vengeanceservice(entity) {
  actors = getaiarray();
  if(!isDefined(entity.attacker)) {
    return;
  }
  foreach(ai in actors) {
    if(_isvalidneighbor(entity, ai) && distancesquared(entity.origin, ai.origin) <= (360 * 360) && randomfloat(1) >= 0.5) {
      ai getperfectinfo(entity.attacker, 1);
    }
  }
}

function private setpathmovedelayedrandom(behaviortreeentity, asmstatename) {
  behaviortreeentity pathmode("move delayed", 0, randomfloatrange(1, 3));
}

function private exposedsetdesiredstancetostand(behaviortreeentity, asmstatename) {
  aiutility::keepclaimnode(behaviortreeentity);
  currentstance = blackboard::getblackboardattribute(behaviortreeentity, "_stance");
  blackboard::setblackboardattribute(behaviortreeentity, "_desired_stance", "stand");
}

function private tryreacquireservice(behaviortreeentity) {
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
    case 2: {
      step_size = 32 + (behaviortreeentity.reacquire_state * 32);
      reacquirepos = behaviortreeentity reacquirestep(step_size);
      break;
    }
    case 4: {
      if(!behaviortreeentity cansee(behaviortreeentity.enemy) || !behaviortreeentity canshootenemy()) {
        behaviortreeentity flagenemyunattackable();
      }
      break;
    }
    default: {
      if(behaviortreeentity.reacquire_state > 15) {
        behaviortreeentity.reacquire_state = 0;
        return false;
      }
      break;
    }
  }
  if(isvec(reacquirepos)) {
    behaviortreeentity useposition(reacquirepos);
    return true;
  }
  behaviortreeentity.reacquire_state++;
  return false;
}