/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot_clean.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\bots\_bot;
#using scripts\mp\bots\_bot_combat;
#using scripts\mp\teams\_teams;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\bots\bot_buttons;
#using scripts\shared\bots\bot_traversals;
#using scripts\shared\callbacks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace bot_clean;

function init() {
  level.botpostcombat = & bot_post_combat;
  level.botidle = & bot_idle;
  level.botupdatethreatgoal = & update_threat_goal;
}

function bot_post_combat() {
  if(isDefined(self.targethub)) {
    if(self.carriedtacos == 0 || self.targethub.interactteam == "none") {
      self.targethub = undefined;
      self botsetgoal(self.origin);
    }
  }
  if(isDefined(self.targettaco)) {
    if(self.targettaco.interactteam == "none" || self.targettaco.droptime != self.targettacodroptime) {
      self.targettaco = undefined;
      self botsetgoal(self.origin);
    }
  }
  if(!self bot_combat::has_threat()) {
    look_for_taco(1024);
  }
  self bot_combat::mp_post_combat();
}

function bot_idle() {
  if(isDefined(self.targethub)) {
    self bot::path_to_point_in_trigger(self.targethub.trigger);
    self bot::sprint_to_goal();
    return;
  }
  if(randomint(10) < self.carriedtacos) {
    foreach(hub in level.cleandeposithubs) {
      if(hub.interactteam == "any") {
        self.targethub = hub;
        self.targettaco = undefined;
        self bot::path_to_point_in_trigger(self.targethub.trigger);
        self bot::sprint_to_goal();
        return;
      }
    }
  }
  if(look_for_taco(1024)) {
    return;
  }
  self bot::bot_idle();
}

function look_for_taco(radius) {
  besttaco = get_best_taco(radius);
  if(!isDefined(besttaco)) {
    return false;
  }
  self.targettaco = besttaco;
  self.targettacodroptime = besttaco.droptime;
  self bot::path_to_point_in_trigger(besttaco.trigger);
  self bot::sprint_to_goal();
  return true;
}

function get_best_taco(radius) {
  radiussq = radius * radius;
  besttaco = undefined;
  besttacodistsq = undefined;
  foreach(taco in level.tacos) {
    if(taco.interactteam == "none" || !ispointonnavmesh(taco.origin, self)) {
      continue;
    }
    tacodistsq = distance2dsquared(self.origin, taco.origin);
    if(taco.attacker != self && tacodistsq > radiussq) {
      continue;
    }
    if(!isDefined(besttaco) || tacodistsq < besttacodistsq) {
      besttaco = taco;
      besttacodistsq = tacodistsq;
    }
  }
  return besttaco;
}

function update_threat_goal() {
  if(isDefined(self.targethub)) {
    if(!self botgoalset()) {
      self bot::path_to_point_in_trigger(self.targethub.trigger);
      self bot::sprint_to_goal();
    }
    return;
  }
  radiussq = 65536;
  if(isDefined(self.targettaco)) {
    tacodistsq = distance2dsquared(self.origin, self.targettaco.origin);
    if(tacodistsq > radiussq) {
      self.targettaco = undefined;
    }
  }
  if(isDefined(self.targettaco) || self look_for_taco(1024)) {
    return;
  }
  self bot_combat::update_threat_goal();
}