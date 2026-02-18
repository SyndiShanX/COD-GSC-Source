/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: core_common\bots\bot_stance.gsc
***********************************************/

#namespace bot_stance;

function preinit() {}

function think() {
  if(isDefined(self.bot.traversal) || self isplayinganimscripted() || self arecontrolsfrozen() || self function_5972c3cf()) {
    return;
  }

  if(is_true(self.bot.var_9cf66413)) {
    self bottapbutton(8);
    return;
  }

  if(is_true(self.bot.var_ce28855b)) {
    self bottapbutton(9);
    return;
  }

  if(self function_29975d32()) {
    self bottapbutton(39);
    return;
  }

  if(self function_a4a505a9()) {
    self bottapbutton(1);
  }
}

function private function_29975d32() {
  if(!(!isDefined(self.bot.difficulty) || is_true(self.bot.difficulty.allowslide))) {
    return false;
  }

  if(self issliding()) {
    return true;
  }

  if(!self issprinting()) {
    return false;
  }

  var_8be65bb9 = self function_f04bd922();

  if(!isDefined(var_8be65bb9) || !isDefined(var_8be65bb9.var_b8c123c0)) {
    return false;
  }

  mindist = 250;

  if(isDefined(var_8be65bb9.var_2cfdc66d)) {
    if(self.bot.order !== # "chase_enemy") {
      return false;
    }

    mindist *= 0.8;
  }

  var_b8c123c0 = var_8be65bb9.var_b8c123c0;

  if(var_b8c123c0[2] - self.origin[2] >= 16) {
    return false;
  }

  maxdist = mindist + 75;
  distsq = distance2dsquared(self.origin, var_b8c123c0);

  if(distsq > maxdist * maxdist || distsq < mindist * mindist) {
    return false;
  }

  return true;
}

function private function_a4a505a9() {
  if(!(!isDefined(self.bot.difficulty) || is_true(self.bot.difficulty.allowsprint))) {
    return false;
  }

  if(self playerads() > 0) {
    return false;
  }

  move = self getnormalizedmovement();

  if(move[0] < 0.826772) {
    return false;
  }

  if(self.bot.order === # "assault" || self.bot.order === # "chase_enemy") {
    return true;
  }

  var_8be65bb9 = self function_f04bd922();

  if(!isDefined(var_8be65bb9) || !isDefined(var_8be65bb9.var_b8c123c0)) {
    return false;
  }

  distsq = distance2dsquared(self.origin, var_8be65bb9.var_b8c123c0);

  if(distsq < 202500) {
    return false;
  }

  return true;
}