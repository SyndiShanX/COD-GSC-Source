/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot_combat.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\bots\_bot;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\bots\bot_traversals;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\killstreaks_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#using scripts\shared\weapons\_weapon_utils;
#using scripts\shared\weapons\_weapons;
#using scripts\shared\weapons_shared;
#namespace bot_combat;

function bot_ignore_threat(entity) {
  if(threat_requires_launcher(entity) && !self bot::has_launcher()) {
    return true;
  }
  return false;
}

function mp_pre_combat() {
  self bot_pre_combat();
  if(self isreloading() || self isswitchingweapons() || self isthrowinggrenade() || self ismeleeing() || self isremotecontrolling() || self isinvehicle() || self isweaponviewonlylinked()) {
    return;
  }
  if(self has_threat()) {
    self threat_switch_weapon();
    return;
  }
  if(self switch_weapon()) {
    return;
  }
  if(self reload_weapon()) {
    return;
  }
  self bot::use_killstreak();
}

function mp_post_combat() {
  if(!isdefined(level.dogtags)) {
    return;
  }
  if(isdefined(self.bot.goaltag)) {
    if(!self.bot.goaltag gameobjects::can_interact_with(self)) {
      self.bot.goaltag = undefined;
      if(!self has_threat() && self botgoalset()) {
        self botsetgoal(self.origin);
      }
    } else if(!self.bot.goaltagonground && !self has_threat() && self isonground() && distance2dsquared(self.origin, self.bot.goaltag.origin) < 16384 && self botsighttrace(self.bot.goaltag)) {
      self thread bot::jump_to(self.bot.goaltag.origin);
    }
  } else if(!self botgoalset()) {
    closesttag = self get_closest_tag();
    if(isdefined(closesttag)) {
      self set_goal_tag(closesttag);
    }
  }
}

function threat_requires_launcher(enemy) {
  if(!isdefined(enemy) || isplayer(enemy)) {
    return false;
  }
  killstreaktype = undefined;
  if(isdefined(enemy.killstreaktype)) {
    killstreaktype = enemy.killstreaktype;
  } else if(isdefined(enemy.parentstruct) && isdefined(enemy.parentstruct.killstreaktype)) {
    killstreaktype = enemy.parentstruct.killstreaktype;
  }
  if(!isdefined(killstreaktype)) {
    return false;
  }
  switch (killstreaktype) {
    case "counteruav":
    case "helicopter_gunner":
    case "satellite":
    case "uav": {
      return true;
    }
  }
  return false;
}

function combat_throw_proximity(origin) {}

function combat_throw_smoke(origin) {}

function combat_throw_lethal(origin) {}

function combat_throw_tactical(origin) {}

function combat_toss_frag(origin) {}

function combat_toss_flash(origin) {}

function combat_tactical_insertion(origin) {
  return false;
}

function nearest_node(origin) {
  return undefined;
}

function dot_product(origin) {
  return bot::fwd_dot(origin);
}

function get_closest_tag() {
  closesttag = undefined;
  closesttagdistsq = undefined;
  foreach(tag in level.dogtags) {
    if(!tag gameobjects::can_interact_with(self)) {
      continue;
    }
    distsq = distancesquared(self.origin, tag.origin);
    if(!isdefined(closesttag) || distsq < closesttagdistsq) {
      closesttag = tag;
      closesttagdistsq = distsq;
    }
  }
  return closesttag;
}

function set_goal_tag(tag) {
  self.bot.goaltag = tag;
  tracestart = tag.origin;
  traceend = tag.origin + (vectorscale((0, 0, -1), 64));
  trace = bullettrace(tracestart, traceend, 0, undefined);
  self.bot.goaltagonground = trace["fraction"] < 1;
  self bot::path_to_trigger(tag.trigger);
  self bot::sprint_to_goal();
}