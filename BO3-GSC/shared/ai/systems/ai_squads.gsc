/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\systems\ai_squads.gsc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;

class squad {
  var squadleader;
  var squadmembers;
  var squadbreadcrumb;

  constructor() {
    squadleader = 0;
    squadmembers = [];
    squadbreadcrumb = [];
  }

  destructor() {}

  function think() {
    if(isint(squadleader) && squadleader == 0 || !isDefined(squadleader)) {
      if(squadmembers.size > 0) {
        squadleader = squadmembers[0];
        squadbreadcrumb = squadleader.origin;
      } else {
        return false;
      }
    }
    return true;
  }

  function removeaifromsqaud(ai) {
    if(isinarray(squadmembers, ai)) {
      arrayremovevalue(squadmembers, ai, 0);
      if(squadleader === ai) {
        squadleader = undefined;
      }
    }
  }

  function addaitosquad(ai) {
    if(!isinarray(squadmembers, ai)) {
      if(ai.archetype == "robot") {
        ai ai::set_behavior_attribute("move_mode", "squadmember");
      }
      squadmembers[squadmembers.size] = ai;
    }
  }

  function getmembers() {
    return squadmembers;
  }

  function getleader() {
    return squadleader;
  }

  function getsquadbreadcrumb() {
    return squadbreadcrumb;
  }

  function addsquadbreadcrumbs(ai) {
    assert(squadleader == ai);
    if(distance2dsquared(squadbreadcrumb, ai.origin) >= 9216) {
      recordcircle(ai.origin, 4, (0, 0, 1), "", ai);
      squadbreadcrumb = ai.origin;
    }
  }

}

#namespace aisquads;

function autoexec __init__sytem__() {
  system::register("ai_squads", &__init__, undefined, undefined);
}

function __init__() {
  level._squads = [];
  actorspawnerarray = getactorspawnerteamarray("axis");
  array::run_all(actorspawnerarray, &spawner::add_spawn_function, &squadmemberthink);
}

function private createsquad(squadname) {
  level._squads[squadname] = new squad();
  return level._squads[squadname];
}

function private removesquad(squadname) {
  if(isDefined(level._squads) && isDefined(level._squads[squadname])) {
    level._squads[squadname] = undefined;
  }
}

function private getsquad(squadname) {
  return level._squads[squadname];
}

function private thinksquad(squadname) {
  while(true) {
    if([
        [level._squads[squadname]]
      ] - > think()) {
      wait(0.5);
    } else {
      removesquad(squadname);
      break;
    }
  }
}

function private squadmemberdeath() {
  self waittill("death");
  if(isDefined(self.squadname) && isDefined(level._squads[self.squadname])) {
    [[level._squads[self.squadname]]] - > removeaifromsqaud(self);
  }
}

function private squadmemberthink() {
  self endon("death");
  if(!isDefined(self.script_aisquadname)) {
    return;
  }
  wait(0.5);
  self.squadname = self.script_aisquadname;
  if(isDefined(self.squadname)) {
    if(!isDefined(level._squads[self.squadname])) {
      squad = createsquad(self.squadname);
      newsquadcreated = 1;
    } else {
      squad = getsquad(self.squadname);
    }
    [[squad]] - > addaitosquad(self);
    self thread squadmemberdeath();
    if(isDefined(newsquadcreated) && newsquadcreated) {
      level thread thinksquad(self.squadname);
    }
    while(true) {
      squadleader = [
        [level._squads[self.squadname]]
      ] - > getleader();
      if(isDefined(squadleader) && (!(isint(squadleader) && squadleader == 0))) {
        if(squadleader == self) {
          recordenttext(self.squadname + "", self, (0, 1, 0), "");
          recordenttext(self.squadname + "", self, (0, 1, 0), "");
          recordcircle(self.origin, 300, (1, 0.5, 0), "", self);
          if(isDefined(self.enemy)) {
            self setgoal(self.enemy);
          }
          [
            [squad]
          ] - > addsquadbreadcrumbs(self);
        } else {
          recordline(self.origin, squadleader.origin, (0, 1, 0), "", self);
          recordenttext(self.squadname + "", self, (0, 1, 0), "");
          followposition = [
            [squad]
          ] - > getsquadbreadcrumb();
          followdistsq = distance2dsquared(self.goalpos, followposition);
          if(isDefined(squadleader.enemy)) {
            if(!isDefined(self.enemy) || (isDefined(self.enemy) && self.enemy != squadleader.enemy)) {
              self setentitytarget(squadleader.enemy, 1);
            }
          }
          if(isDefined(self.goalpos) && followdistsq >= 256) {
            if(followdistsq >= 22500) {
              self ai::set_behavior_attribute("sprint", 1);
            } else {
              self ai::set_behavior_attribute("sprint", 0);
            }
            self setgoal(followposition, 1);
          }
        }
      }
      wait(1);
    }
  }
}

function isfollowingsquadleader(ai) {
  if(ai ai::get_behavior_attribute("move_mode") != "squadmember") {
    return false;
  }
  squadmember = issquadmember(ai);
  currentsquadleader = getsquadleader(ai);
  isaisquadleader = isDefined(currentsquadleader) && currentsquadleader == ai;
  if(squadmember && !isaisquadleader) {
    return true;
  }
  return false;
}

function issquadmember(ai) {
  if(isDefined(ai.squadname)) {
    squad = getsquad(ai.squadname);
    if(isDefined(squad)) {
      return isinarray([
        [squad]
      ] - > getmembers(), ai);
    }
  }
  return 0;
}

function issquadleader(ai) {
  if(isDefined(ai.squadname)) {
    squad = getsquad(ai.squadname);
    if(isDefined(squad)) {
      squadleader = [
        [squad]
      ] - > getleader();
      return isDefined(squadleader) && squadleader == ai;
    }
  }
  return 0;
}

function getsquadleader(ai) {
  if(isDefined(ai.squadname)) {
    squad = getsquad(ai.squadname);
    if(isDefined(squad)) {
      return [
        [squad]
      ] - > getleader();
    }
  }
  return undefined;
}