/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot_dem.gsc
*************************************************/

#using scripts\mp\bots\_bot;
#using scripts\mp\bots\_bot_combat;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\bots\bot_buttons;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace bot_dem;

function init() {
  level.botidle = & bot_idle;
  level.botcombat = & combat_think;
  level.botthreatlost = & function_211bcdc;
}

function bot_idle() {
  approachradiussq = 562500;
  foreach(zone in level.bombzones) {
    if(isDefined(zone.bombexploded) && zone.bombexploded) {
      continue;
    }
    if(self istouching(zone.trigger)) {
      if(self can_plant(zone) || self can_defuse(zone)) {
        self bot::press_use_button();
        return;
      }
    }
    if(distancesquared(self.origin, zone.trigger.origin) < approachradiussq) {
      if(self can_plant(zone) || self can_defuse(zone)) {
        self bot::path_to_trigger(zone.trigger);
        self bot::sprint_to_goal();
        return;
      }
    }
  }
  zones = array::randomize(level.bombzones);
  foreach(zone in zones) {
    if(isDefined(zone.bombexploded) && zone.bombexploded) {
      continue;
    }
    if(self can_defuse(zone) && randomint(100) < 70) {
      self bot::approach_goal_trigger(zone.trigger, 750);
      self bot::sprint_to_goal();
      return;
    }
  }
  foreach(zone in zones) {
    if(isDefined(zone.bombexploded) && zone.bombexploded) {
      continue;
    }
    if(distancesquared(self.origin, zone.trigger.origin) < approachradiussq && randomint(100) < 70) {
      triggerradius = self bot::get_trigger_radius(zone.trigger);
      self bot::approach_point(zone.trigger.origin, triggerradius, 750);
      self bot::sprint_to_goal();
      return;
    }
  }
  self bot::bot_idle();
}

function can_plant(zone) {
  return !(isDefined(zone.bombplanted) && zone.bombplanted) && self.team != zone gameobjects::get_owner_team();
}

function can_defuse(zone) {
  return isDefined(zone.bombplanted) && zone.bombplanted && self.team == zone gameobjects::get_owner_team();
}

function combat_think() {
  if(isDefined(self.isplanting) && self.isplanting || (isDefined(self.isdefusing) && self.isdefusing)) {
    return;
  }
  self bot_combat::combat_think();
}

function function_211bcdc() {
  approachradiussq = 562500;
  foreach(zone in level.bombzones) {
    if(isDefined(zone.bombexploded) && zone.bombexploded) {
      continue;
    }
    if(distancesquared(self.origin, zone.trigger.origin) < approachradiussq) {
      if(self can_plant(zone) || self can_defuse(zone)) {
        return;
      }
    }
  }
  self bot_combat::chase_threat();
}