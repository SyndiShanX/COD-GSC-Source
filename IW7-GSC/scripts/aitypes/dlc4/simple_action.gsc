/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\simple_action.gsc
**************************************************/

setupsimplebtaction(param_00, param_01, param_02) {
  if(!isDefined(param_00)) {
    param_00 = ::simpleaction_begin;
  }

  if(!isDefined(param_01)) {
    param_01 = ::simpleaction_tick;
  }

  if(!isDefined(param_02)) {
    param_02 = ::simpleaction_end;
  }

  scripts\aitypes\dlc4\bt_action_api::setupbtaction("simple_action", param_00, param_01, param_02);
}

simpleaction_begin(param_00) {
  scripts\asm\dlc4\dlc4_asm::setasmaction(self.simple_action);
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(param_00, self.simple_action, self.simple_action);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(param_00, self.simple_action);
  var_01 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
  var_01.simple_action = self.simple_action;
  self.simple_action = undefined;
}

simpleaction_tick(param_00) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(param_00)) {
    return level.running;
  }

  return level.success;
}

simpleaction_end(param_00) {
  self clearpath();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  var_01 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(param_00);
  var_02 = var_01.simple_action;
  var_01.simple_action = undefined;
  self notify(var_02 + "_done");
}

dosimpleaction_immediate(param_00, param_01) {
  self.simple_action = param_01;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(param_00, "simple_action");
}

dosimpleaction(param_00, param_01) {
  self.simple_action = param_01;
  self.nextaction = "simple_action";
}