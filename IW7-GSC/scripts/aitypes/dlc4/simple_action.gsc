/**************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\aitypes\dlc4\simple_action.gsc
**************************************************/

setupsimplebtaction(var_0, var_1, var_2) {
  if(!isDefined(var_0)) {
    var_0 = ::simpleaction_begin;
  }

  if(!isDefined(var_1)) {
    var_1 = ::simpleaction_tick;
  }

  if(!isDefined(var_2)) {
    var_2 = ::simpleaction_end;
  }

  scripts\aitypes\dlc4\bt_action_api::setupbtaction("simple_action", var_0, var_1, var_2);
}

simpleaction_begin(var_0) {
  scripts\asm\dlc4\dlc4_asm::setasmaction(self.simple_action);
  scripts\aitypes\dlc4\bt_state_api::asm_wait_state_setup(var_0, self.simple_action, self.simple_action);
  scripts\aitypes\dlc4\bt_state_api::btstate_transitionstate(var_0, self.simple_action);
  var_1 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(var_0);
  var_1.simple_action = self.simple_action;
  self.simple_action = undefined;
}

simpleaction_tick(var_0) {
  if(scripts\aitypes\dlc4\bt_state_api::btstate_tickstates(var_0)) {
    return level.running;
  }

  return level.success;
}

simpleaction_end(var_0) {
  self clearpath();
  scripts\asm\dlc4\dlc4_asm::clearasmaction();
  var_1 = scripts\aitypes\dlc4\bt_state_api::btstate_getinstancedata(var_0);
  var_2 = var_1.simple_action;
  var_1.simple_action = undefined;
  self notify(var_2 + "_done");
}

dosimpleaction_immediate(var_0, var_1) {
  self.simple_action = var_1;
  scripts\aitypes\dlc4\bt_action_api::setdesiredbtaction(var_0, "simple_action");
}

dosimpleaction(var_0, var_1) {
  self.simple_action = var_1;
  self.nextaction = "simple_action";
}