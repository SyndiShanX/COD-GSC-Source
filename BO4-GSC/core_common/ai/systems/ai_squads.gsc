/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\systems\ai_squads.gsc
************************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\array_shared;
#include scripts\core_common\spawner_shared;
#include scripts\core_common\system_shared;

#namespace aisquads;

class squad {
  var squadbreadcrumb;
  var squadleader;
  var squadmembers;

  constructor() {
    squadleader = 0;
    squadmembers = [];
    squadbreadcrumb = [];
  }

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
      if(ai.archetype == #"robot") {
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
      recordcircle(ai.origin, 4, (0, 0, 1), "<dev string:x38>", ai);

      squadbreadcrumb = ai.origin;
    }
  }

}

autoexec __init__system__() {
  system::register(#"ai_squads", &__init__, undefined, undefined);
}

__init__() {
  level._squads = [];
  actorspawnerarray = getactorspawnerteamarray(#"axis");
  array::run_all(actorspawnerarray, &spawner::add_spawn_function, &squadmemberthink);
}

private createsquad(squadname) {
  level._squads[squadname] = new squad();
  return level._squads[squadname];
}

private removesquad(squadname) {
  if(isDefined(level._squads) && isDefined(level._squads[squadname])) {
    level._squads[squadname] = undefined;
  }
}

private getsquad(squadname) {
  return level._squads[squadname];
}

private thinksquad(squadname) {
  while(true) {
    if([
        [level._squads[squadname]]
      ] - > think()) {
      wait 0.5;
      continue;
    }

    removesquad(squadname);
    break;
  }
}

private squadmemberdeath() {
  self waittill(#"death");

  if(isDefined(self.squadname) && isDefined(level._squads[self.squadname])) {
    [[level._squads[self.squadname]]] - > removeaifromsqaud(self);
  }
}

private squadmemberthink() {
  self endon(#"death");

  if(!isDefined(self.script_aisquadname)) {
    return;
  }

  wait 0.5;
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

      if(isDefined(squadleader) && !(isint(squadleader) && squadleader == 0)) {
        if(squadleader == self) {
          recordenttext(self.squadname + "<dev string:x45>", self, (0, 1, 0), "<dev string:x38>");

          recordenttext(self.squadname + "<dev string:x45>", self, (0, 1, 0), "<dev string:x38>");

          recordcircle(self.origin, 300, (1, 0.5, 0), "<dev string:x38>", self);

          if(isDefined(self.enemy)) {
            self setgoal(self.enemy);
          }

          [
            [squad]
          ] - > addsquadbreadcrumbs(self);
        } else {
          recordline(self.origin, squadleader.origin, (0, 1, 0), "<dev string:x38>", self);

          recordenttext(self.squadname + "<dev string:x50>", self, (0, 1, 0), "<dev string:x38>");

          followposition = [
            [squad]
          ] - > getsquadbreadcrumb();
          followdistsq = distance2dsquared(self.goalpos, followposition);

          if(isDefined(squadleader.enemy)) {
            if(!isDefined(self.enemy) || isDefined(self.enemy) && self.enemy != squadleader.enemy) {
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

      wait 1;
    }
  }
}

isfollowingsquadleader(ai) {
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

issquadmember(ai) {
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

issquadleader(ai) {
  if(isDefined(ai.squadname)) {
    squad = getsquad(ai.squadname);

    if(isDefined(squad)) {
      squadleader = [
        [squad]
      ] - > getleader();
      return (isDefined(squadleader) && squadleader == ai);
    }
  }

  return false;
}

getsquadleader(ai) {
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