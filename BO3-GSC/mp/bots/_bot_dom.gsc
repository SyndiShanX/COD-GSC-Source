/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot_dom.gsc
*************************************************/

#using scripts\mp\bots\_bot;
#using scripts\mp\bots\_bot_combat;
#using scripts\mp\gametypes\dom;
#using scripts\shared\array_shared;
#using scripts\shared\bots\_bot;
#using scripts\shared\bots\_bot_combat;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\math_shared;
#using scripts\shared\util_shared;
#namespace bot_dom;

function init() {
  level.botupdate = & bot_update;
  level.botprecombat = & bot_pre_combat;
  level.botupdatethreatgoal = & bot_update_threat_goal;
  level.botidle = & bot_idle;
}

function bot_update() {
  self.bot.capturingflag = self get_capturing_flag();
  self.bot.goalflag = undefined;
  if(!self botgoalreached()) {
    foreach(flag in level.domflags) {
      if(self bot::goal_in_trigger(flag.trigger)) {
        self.bot.goalflag = flag;
        break;
      }
    }
  }
  self bot::bot_update();
}

function bot_pre_combat() {
  if(!self bot_combat::has_threat() && isDefined(self.bot.goalflag) && self.bot.goalflag gameobjects::get_owner_team() == self.team) {
    self botsetgoal(self.origin);
  }
  self bot_combat::mp_pre_combat();
}

function bot_idle() {
  if(isDefined(self.bot.capturingflag)) {
    self bot::path_to_point_in_trigger(self.bot.capturingflag.trigger);
    return;
  }
  bestflag = get_best_flag();
  if(isDefined(bestflag)) {
    self bot::approach_goal_trigger(bestflag.trigger);
    self bot::sprint_to_goal();
    return;
  }
  self bot::bot_idle();
}

function bot_update_threat_goal() {
  if(isDefined(self.bot.capturingflag)) {
    if(self botgoalreached()) {
      self bot::path_to_point_in_trigger(self.bot.capturingflag.trigger);
    }
    return;
  }
  self bot_combat::update_threat_goal();
}

function get_capturing_flag() {
  foreach(flag in level.domflags) {
    if(self.team != flag gameobjects::get_owner_team() && self istouching(flag.trigger)) {
      return flag;
    }
  }
  return undefined;
}

function get_best_flag() {
  bestflag = undefined;
  bestflagdistsq = undefined;
  foreach(flag in level.domflags) {
    ownerteam = flag gameobjects::get_owner_team();
    contested = flag gameobjects::get_num_touching_except_team(ownerteam);
    distsq = distance2dsquared(self.origin, flag.origin);
    if(ownerteam == self.team && !contested) {
      continue;
    }
    if(!isDefined(bestflag) || distsq < bestflagdistsq) {
      bestflag = flag;
      bestflagdistsq = distsq;
    }
  }
  return bestflag;
}