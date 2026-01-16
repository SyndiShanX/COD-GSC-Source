/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_util.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\bots\bot_action;
#include scripts\core_common\bots\bot_chain;
#include scripts\core_common\struct;

#namespace bot_util;

function_23cbc6c1(goal, b_force = 0, n_radius, n_height) {
  assert(isbot(self), "<dev string:x38>" + "<dev string:x56>");
  assert(isDefined(goal), "<dev string:x38>" + "<dev string:x77>");

  if(!isbot(self) || !isDefined(goal)) {
    return;
  }

  self ai::set_behavior_attribute("control", "autonomous");

  if(self bot_chain::function_58b429fb()) {
    self bot_chain::function_73d1cfe6();
  }

  if(isDefined(n_radius)) {
    if(isDefined(n_height)) {
      self setgoal(goal, b_force, n_radius, n_height);
    } else {
      self setgoal(goal, b_force, n_radius);
    }
  } else {
    self setgoal(goal, b_force);
  }

  self.bot.var_bd883a25 = goal;
  self.bot.var_4e3a654 = b_force;
}

function_33834a13() {
  assert(isbot(self), "<dev string:x9b>" + "<dev string:x56>");

  if(!isbot(self) || !isDefined(self.bot.var_bd883a25)) {
    return;
  }

  self clearforcedgoal();
  self ai::set_behavior_attribute("control", "commander");
  self.bot.var_bd883a25 = undefined;
  self.bot.var_4e3a654 = undefined;
}

function_e449b57(gameobject) {
  assert(isbot(self), "<dev string:xbb>" + "<dev string:x56>");
  assert(isDefined(gameobject), "<dev string:xbb>" + "<dev string:xe0>");

  if(!isbot(self) || !isDefined(gameobject)) {
    return;
  }

  self bot::set_interact(gameobject);
}

function_cf70f2fe(startstruct) {
  self endon(#"disconnect");
  level endon(#"game_ended");
  self notify(#"hash_5efbaef0ca9e2136");
  self endon(#"hash_5efbaef0ca9e2136");
  assert(isbot(self), "<dev string:x10a>" + "<dev string:x56>");
  assert(isstruct(startstruct) || isstring(startstruct), "<dev string:x10a>" + "<dev string:x127>");

  if(isstring(startstruct)) {
    assert(isDefined(struct::get(startstruct)), "<dev string:x10a>" + "<dev string:x15d>" + startstruct);
  }

  if(!isbot(self)) {
    return;
  }

  if(!isstruct(startstruct) && !isstring(startstruct)) {
    return;
  } else if(isstring(startstruct) && !isDefined(struct::get(startstruct))) {
    return;
  }

  if(self bot_chain::function_58b429fb()) {
    self bot_chain::function_73d1cfe6();
  }

  self.bot.var_bd883a25 = undefined;
  self.bot.var_4e3a654 = undefined;
  self ai::set_behavior_attribute("control", "autonomous");
  self thread bot_chain::function_cf70f2fe(startstruct);

  while(self bot_chain::function_58b429fb()) {
    self waittill(#"hash_382a628dad5ecbb5");
  }

  if(!isDefined(self.bot.var_bd883a25)) {
    self ai::set_behavior_attribute("control", "commander");
  }
}

function_f89d0427() {
  if(!self bot_chain::function_58b429fb()) {
    return;
  }

  self bot_chain::function_73d1cfe6();
}

function_cae2c3ac() {
  self bot_action::function_ee2eaccc(0);
}

function_de6c5bcb() {
  self bot_action::function_ee2eaccc(1);
}

function_f1f5be0f() {
  self bot_action::function_ee2eaccc(2);
}