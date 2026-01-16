/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_stance.gsc
***********************************************/

#include scripts\core_common\ai_shared;
#include scripts\core_common\bots\bot;
#include scripts\core_common\system_shared;

#namespace bot_stance;

autoexec __init__system__() {
  system::register(#"bot_stance", &__init__, undefined, undefined);
}

__init__() {
  level.var_17a3a139 = [];
  level.botstances = [];
  register_handler(#"default", &handle_default);
  register_handler(#"hash_2405aec12988c1f7", &function_7857357b);
  register_handler(#"hash_ca2f8909b847c6f", &function_f1b497ec);
  register_handler(#"hash_7a468797a3a33424", &function_41d967fe);
  register_handler(#"hash_2ebb09bf5581043d", &function_f71302f4);
  register_handler(#"hash_3173f482acc24ec8", &function_821cce69);
  register_handler(#"sprint_set", &function_5485fc7b);
  register_handler(#"sprint_set", &function_5485fc7b);
  register_handler(#"hash_59db68c04af7aab5", &function_e4f752b9);
  register_handler(#"hash_51f609ea675fecde", &function_d22ff818);
  register_handler(#"hash_21f619ce507cec96", &function_1989cfaf);
  register_stance(#"stand", &stand);
  register_stance(#"sprint", &sprint);
  register_stance(#"crouch", &crouch);
  register_stance(#"prone", &prone);
  register_stance(#"slide", &slide);
}

start() {
  self thread handle_path_success();
  self thread handle_goal_reached();
  self.bot.var_9bd97adb = undefined;
}

stop() {
  self notify(#"hash_399ca08ed5c94410");
}

reset() {
  self.bot.var_857c5ea8 = 0;
}

update(tacbundle) {
  if(self.bot.var_857c5ea8 > gettime()) {
    return;
  }

  self bot::record_text("<dev string:x38>", (1, 1, 0), "<dev string:x4c>");

  self function_7beea81f(tacbundle);
  self.bot.var_857c5ea8 = bot::function_7aeb27f1(0.4, 1);
}

handle_path_success() {
  self endon(#"death", #"hash_399ca08ed5c94410");
  level endon(#"game_ended");

  while(isDefined(self.bot)) {
    self waittill(#"bot_path_success");

    if(!isbot(self)) {
      return;
    }

    self.bot.var_857c5ea8 = 0;
  }
}

handle_goal_reached() {
  self endon(#"death", #"hash_399ca08ed5c94410");
  level endon(#"game_ended");

  while(isDefined(self.bot)) {
    self waittill(#"bot_goal_reached");

    if(!isbot(self)) {
      return;
    }

    self.bot.var_857c5ea8 = 0;
  }
}

register_handler(name, func) {
  level.var_17a3a139[name] = func;
}

register_stance(name, func) {
  level.botstances[name] = func;
}

function_7beea81f(tacbundle) {
  var_f307a84d = tacbundle.stationarystancehandlerlist;

  if(self haspath()) {
    var_f307a84d = tacbundle.movingstancehandlerlist;
  }

  if(!isDefined(var_f307a84d)) {
    self bot::record_text("<dev string:x5f>", (1, 0, 0), "<dev string:x4c>");

    return;
  }

  pixbeginevent(#"bot_stance_update");
  aiprofile_beginentry("bot_stance_update");
  handled = 0;
  node = self bot::get_position_node();

  foreach(params in var_f307a84d) {
    if(self function_ab5be907(tacbundle, params, node)) {
      self.bot.var_9bd97adb = params.name;
      handled = 1;
      break;
    }
  }

  pixendevent();
  aiprofile_endentry();
}

function_ab5be907(tacbundle, params, node) {
  if(!isDefined(params)) {
    return 0;
  }

  func = level.var_17a3a139[params.name];

  if(!isDefined(func)) {
    self botprinterror("<dev string:x76>" + function_9e72a96(params.name));

    return 0;
  }

  self bot::record_text(function_9e72a96(params.name), (1, 1, 1), "<dev string:x4c>");

  pixbeginevent("bot_stance_handler: " + params.name);
  aiprofile_beginentry("bot_stance_handler: " + params.name);
  handled = self[[func]](tacbundle, params, node);
  pixendevent();
  aiprofile_endentry();
  return handled;
}

g_stop_player_too_many_weapons_monitor(name) {
  if(!isDefined(name)) {
    return false;
  }

  func = level.botstances[name];

  if(!isDefined(func)) {
    self botprinterror("<dev string:x98>" + function_9e72a96(name));

    return false;
  }

  self bot::record_text("<dev string:xb2>" + function_9e72a96(name), (1, 1, 0), "<dev string:x4c>");

  self[[func]]();
  return true;
}

handle_default(tacbundle, params, node) {
  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_7857357b(tacbundle, params, node) {
  if(!isDefined(node)) {
    self bot::record_text("<dev string:xb7>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!iscrouchcovernode(node)) {
    self bot::record_text("<dev string:xc7>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(self bot::in_combat() && !self iscovervalid(node)) {
    self bot::record_text("<dev string:xdf>", (1, 0, 0), "<dev string:x4c>");

  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_f1b497ec(tacbundle, params, node) {
  if(!isDefined(node)) {
    self bot::record_text("<dev string:xb7>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!isstandcovernode(node)) {
    self bot::record_text("<dev string:xf2>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(self bot::in_combat() && !self iscovervalid(node)) {
    self bot::record_text("<dev string:xdf>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_41d967fe(tacbundle, params, node) {
  if(!isDefined(node)) {
    self bot::record_text("<dev string:xb7>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!isfullcovernode(node)) {
    self bot::record_text("<dev string:x109>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(self bot::in_combat() && !self iscovervalid(node)) {
    self bot::record_text("<dev string:xdf>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_f71302f4(tacbundle, params, node) {
  if(!isDefined(self.enemy)) {
    self bot::record_text("<dev string:x11f>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!isDefined(node)) {
    self bot::record_text("<dev string:xb7>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!isstandcovernode(node)) {
    self bot::record_text("<dev string:xf2>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(self bot::in_combat() && !self iscovervalid(node)) {
    self bot::record_text("<dev string:xdf>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!self bot::function_e0aceb0c(tacbundle, "bot_recordStance")) {
    return false;
  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_821cce69(tacbundle, params, node) {
  if(!isDefined(node)) {
    self bot::record_text("<dev string:xb7>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!(node.spawnflags&8)) {
    self bot::record_text("<dev string:x12c>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(node.spawnflags&4) {
    self bot::record_text("<dev string:x147>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(self bot::in_combat() && !self iscovervalid(node)) {
    self bot::record_text("<dev string:xdf>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_5485fc7b(tacbundle, params, node) {
  if(!self ai::has_behavior_attribute("sprint")) {
    self bot::record_text("<dev string:x15d>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!self ai::get_behavior_attribute("sprint")) {
    self bot::record_text("<dev string:x175>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_e4f752b9(tacbundle, params, node) {
  if(self issprinting()) {
    self bot::record_text("<dev string:x192>", (1, 1, 0), "<dev string:x4c>");

    return true;
  }

  if(isDefined(tacbundle.sprintdist)) {
    var_8be65bb9 = self function_f04bd922();
    movepoint = self.goalpos;

    if(isDefined(var_8be65bb9) && isDefined(var_8be65bb9.var_2cfdc66d)) {
      movepoint = var_8be65bb9.var_2cfdc66d;
    } else if(isDefined(self.overridegoalpos)) {
      movepoint = self.overridegoalpos;
    }

    distsq = distance2dsquared(self.origin, movepoint);
    var_ce946146 = tacbundle.sprintdist * tacbundle.sprintdist;

    if(distsq < var_ce946146) {
      self bot::record_text("<dev string:x1a5>", (1, 0, 0), "<dev string:x4c>");

      return false;
    }
  }

  dir = self getnormalizedmovement();

  if(vectordot(dir, (1, 0, 0)) < 0.82) {
    self bot::record_text("<dev string:x1c2>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_d22ff818(tacbundle, params, node) {
  if(!self ai::get_behavior_attribute("slide")) {
    self bot::record_text("<dev string:x1d9>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(self issliding()) {
    self bot::record_text("<dev string:x1f5>", (1, 1, 0), "<dev string:x4c>");

    return true;
  }

  if(!self issprinting()) {
    self bot::record_text("<dev string:x206>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(isDefined(tacbundle.var_1f5429aa) && isDefined(tacbundle.var_48aa05a1)) {
    var_8be65bb9 = self function_f04bd922();
    movepoint = self.goalpos;

    if(isDefined(var_8be65bb9) && isDefined(var_8be65bb9.var_2cfdc66d)) {
      movepoint = var_8be65bb9.var_2cfdc66d;
    } else if(isDefined(self.overridegoalpos)) {
      movepoint = self.overridegoalpos;
    }

    distsq = distance2dsquared(self.origin, movepoint);
    var_d6ff7b1b = tacbundle.var_1f5429aa * tacbundle.var_1f5429aa;
    var_e70d67bc = tacbundle.var_48aa05a1 * tacbundle.var_48aa05a1;

    if(distsq < var_d6ff7b1b) {
      self bot::record_text("<dev string:x1a5>", (1, 0, 0), "<dev string:x4c>");

      return false;
    }

    if(distsq > var_e70d67bc) {
      self bot::record_text("<dev string:x218>", (1, 0, 0), "<dev string:x4c>");

      return false;
    }
  }

  dir = self getnormalizedmovement();

  if(vectordot(dir, (1, 0, 0)) < 0.82) {
    self bot::record_text("<dev string:x1c2>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

function_1989cfaf(tacbundle, params, node) {
  if(!self ai::get_behavior_attribute("slide")) {
    self bot::record_text("<dev string:x1d9>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(self issliding()) {
    self bot::record_text("<dev string:x1f5>", (1, 1, 0), "<dev string:x4c>");

    return true;
  }

  if(!self issprinting()) {
    self bot::record_text("<dev string:x206>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(!isDefined(node) || !iscovernode(node)) {
    self bot::record_text("<dev string:x235>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  if(isDefined(self function_f04bd922())) {
    self bot::record_text("<dev string:x251>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  distsq = distance2dsquared(self.origin, node.origin);
  mindistsq = isDefined(tacbundle.var_1f5429aa) ? tacbundle.var_1f5429aa : 0;
  mindistsq *= mindistsq;

  if(distsq < mindistsq) {
    self bot::record_text("<dev string:x272>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  maxdistsq = isDefined(tacbundle.var_48aa05a1) ? tacbundle.var_48aa05a1 : 0;
  maxdistsq *= maxdistsq;

  if(distsq > maxdistsq) {
    self bot::record_text("<dev string:x288>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  mindot = isDefined(tacbundle.var_f58a14bd) ? tacbundle.var_f58a14bd : 0;
  dir = vectornormalize(node.origin - self.origin);

  if(vectordot(dir, anglesToForward(node.angles)) <= mindot) {
    self bot::record_text("<dev string:x29e>", (1, 0, 0), "<dev string:x4c>");

    return false;
  }

  return self g_stop_player_too_many_weapons_monitor(params.stance);
}

sprint() {
  self botpressbutton(1);
  self botreleasebutton(9);
  self botreleasebutton(8);
  self botreleasebutton(39);
}

stand() {
  self botreleasebutton(1);
  self botreleasebutton(9);
  self botreleasebutton(8);
  self botreleasebutton(39);
}

crouch() {
  self botreleasebutton(1);
  self botpressbutton(9);
  self botreleasebutton(8);
  self botreleasebutton(39);
}

prone() {
  self botreleasebutton(1);
  self botreleasebutton(9);
  self botpressbutton(8);
  self botreleasebutton(39);
}

slide() {
  self botreleasebutton(1);
  self botreleasebutton(9);
  self botreleasebutton(8);
  self bottapbutton(39);
}