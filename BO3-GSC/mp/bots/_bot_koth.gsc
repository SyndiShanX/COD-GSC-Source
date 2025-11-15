/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot_koth.gsc
*************************************************/

#using scripts\mp\bots\_bot;
#using scripts\mp\bots\_bot_combat;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace bot_koth;

function init() {
  level.onbotspawned = & on_bot_spawned;
  level.botupdatethreatgoal = & bot_update_threat_goal;
  level.botidle = & bot_idle;
}

function on_bot_spawned() {
  self thread wait_zone_moved();
  self bot::on_bot_spawned();
}

function wait_zone_moved() {
  self endon("death");
  level endon("game_ended");
  while(true) {
    level waittill("zone_moved");
    if(!self bot_combat::has_threat() && self botgoalset()) {
      self botsetgoal(self.origin);
    }
  }
}

function bot_update_threat_goal() {
  if(isDefined(level.zone) && self istouching(level.zone.gameobject.trigger)) {
    if(self botgoalreached()) {
      self bot::path_to_point_in_trigger(level.zone.gameobject.trigger);
    }
    return;
  }
  self bot_combat::update_threat_goal();
}

function bot_idle() {
  if(isDefined(level.zone)) {
    if(self istouching(level.zone.gameobject.trigger)) {
      self bot::path_to_point_in_trigger(level.zone.gameobject.trigger);
    } else {
      self bot::approach_goal_trigger(level.zone.gameobject.trigger);
      self bot::sprint_to_goal();
    }
    return;
  }
  self bot::bot_idle();
}