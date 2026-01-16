/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\archetype_human_blackboard.gsc
*********************************************************/

#include scripts\core_common\ai\systems\ai_interface;
#include scripts\core_common\ai_shared;

#namespace blackboard;

private bb_getarrivaltype() {
  if(self ai::get_behavior_attribute("disablearrivals")) {
    return "dont_arrive_at_goal";
  }

  return "arrive_at_goal";
}

private bb_gettacticalarrivalfacingyaw() {
  return angleclamp180(self.angles[1] - self.node.angles[1]);
}

private bb_getlocomotionmovementtype() {
  if(!ai::getaiattribute(self, "disablesprint")) {
    if(ai::getaiattribute(self, "sprint")) {
      return "human_locomotion_movement_sprint";
    }

    if(!isDefined(self.nearbyfriendlycheck)) {
      self.nearbyfriendlycheck = 0;
    }

    now = gettime();

    if(now >= self.nearbyfriendlycheck) {
      self.nearbyfriendlycount = getactorteamcountradius(self.origin, 120, self.team, #"neutral");
      self.nearbyfriendlycheck = now + 500;
    }

    if(self.nearbyfriendlycount >= 3) {
      return "human_locomotion_movement_default";
    }

    if(isDefined(self.enemy) && isDefined(self.runandgundist)) {
      if(distancesquared(self.origin, self lastknownpos(self.enemy)) > self.runandgundist * self.runandgundist) {
        return "human_locomotion_movement_sprint";
      }
    } else if(isDefined(self.goalpos) && isDefined(self.runandgundist)) {
      if(distancesquared(self.origin, self.goalpos) > self.runandgundist * self.runandgundist) {
        return "human_locomotion_movement_sprint";
      }
    }
  }

  return "human_locomotion_movement_default";
}

private bb_getcoverflankability() {
  if(self asmistransitionrunning()) {
    return "unflankable";
  }

  if(!isDefined(self.node)) {
    return "unflankable";
  }

  covermode = self getblackboardattribute("_cover_mode");

  if(isDefined(covermode)) {
    covernode = self.node;

    if(covermode == "cover_alert" || covermode == "cover_mode_none") {
      return "flankable";
    }

    if(covernode.type == #"cover pillar") {
      return (covermode == "cover_blind");
    } else if(covernode.type == #"cover left" || covernode.type == #"cover right") {
      return (covermode == "cover_blind" || covermode == "cover_over");
    } else if(covernode.type == #"cover stand" || covernode.type == #"conceal stand" || covernode.type == #"cover crouch" || covernode.type == #"cover crouch window" || covernode.type == #"conceal crouch") {
      return "flankable";
    }
  }

  return "unflankable";
}