/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot_escort.gsc
*************************************************/

#using scripts\mp\_util;
#using scripts\mp\bots\_bot;
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
#namespace namespace_ebd80b8b;

function init() {
  level.botidle = & bot_idle;
}

function bot_idle() {
  if(self.team == game["attackers"]) {
    self function_69879c50();
  } else {
    self function_16ce4b24();
  }
}

function function_69879c50() {
  if(isdefined(level.moveobject) && (level.robot.active || level.rebootplayers > 0)) {
    if(!level.robot.moving || math::cointoss()) {
      self bot::path_to_point_in_trigger(level.moveobject.trigger);
    } else {
      self bot::approach_point(level.moveobject.trigger.origin, 160, 400);
    }
    self bot::sprint_to_goal();
    return;
  }
  self bot::bot_idle();
}

function function_16ce4b24() {
  if(isdefined(level.moveobject) && level.robot.active) {
    self bot::approach_point(level.moveobject.trigger.origin, 160, 400);
    self bot::sprint_to_goal();
    return;
  }
  self bot::bot_idle();
}