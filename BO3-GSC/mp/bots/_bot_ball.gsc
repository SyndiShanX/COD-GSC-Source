/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: mp\bots\_bot_ball.gsc
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
#namespace bot_ball;

function init() {
  level.botidle = &bot_idle;
  level.botcombat = &bot_combat;
  level.botprecombat = &bot_pre_combat;
}

function release_control_on_landing() {
  self endon("death");
  level endon("game_ended");
  while(self isonground()) {
    wait(0.05);
  }
  while(!self isonground()) {
    wait(0.05);
  }
  self botreleasemanualcontrol();
}

function bot_pre_combat() {
  if(isDefined(self.carryobject)) {
    if(self isonground() && self botgoalset()) {
      goal = level.ball_goals[util::getotherteam(self.team)];
      radius = 300;
      radiussq = radius * radius;
      if(distance2dsquared(self.origin, goal.trigger.origin) <= radiussq) {
        if(self botsighttrace(goal.trigger)) {
          self bottakemanualcontrol();
          self thread bot::jump_to(goal.trigger.origin);
          self thread release_control_on_landing();
          return;
        }
      }
    }
    if(!self ismeleeing()) {
      self bot::use_killstreak();
    }
    return;
  }
  self bot_combat::mp_pre_combat();
}

function bot_combat() {
  if(isDefined(self.carryobject)) {
    if(self bot_combat::has_threat()) {
      self bot_combat::clear_threat();
    }
    meleethreat = bot_combat::get_greatest_threat(level.botsettings.meleerange);
    if(isDefined(meleethreat)) {
      angles = self getplayerangles();
      fwd = anglesToForward(angles);
      threatdir = meleethreat.origin - self.origin;
      threatdir = vectornormalize(threatdir);
      dot = vectordot(fwd, threatdir);
      if(dot > level.botsettings.meleedot) {
        self bot::tap_melee_button();
      }
    }
    return;
  }
  self bot_combat::combat_think();
}

function bot_idle() {
  if(isDefined(self.carryobject)) {
    if(!self botgoalset()) {
      goal = level.ball_goals[util::getotherteam(self.team)];
      goalpoint = goal.origin - vectorscale((0, 0, 1), 125);
      self bot::approach_point(goalpoint);
      self bot::sprint_to_goal();
    }
    return;
  }
  triggers = [];
  balls = array::randomize(level.balls);
  foreach(ball in balls) {
    if(!isDefined(ball.carrier) && !ball.in_goal) {
      triggers[triggers.size] = ball.trigger;
      continue;
    }
    if(isDefined(ball.carrier) && ball.carrier.team != self.team) {
      self bot::approach_point(ball.carrier.origin, 250, 1000, 128);
      self bot::sprint_to_goal();
      return;
    }
  }
  if(triggers.size > 0) {
    triggers = arraysort(triggers, self.origin);
    self botsetgoal(triggers[0].origin);
    self bot::sprint_to_goal();
    return;
  }
  self bot::bot_idle();
}