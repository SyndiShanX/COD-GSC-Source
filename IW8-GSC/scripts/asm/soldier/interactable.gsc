/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\interactable.gsc
************************************************/

function onlevelload() {
  registerinteractable("example", &run_example_interactable);
}

function run_example_interactable(var_0, var_1, var_2) {
  iprintlnbold("Example Interactable is Running.");
  var_3 = scripts\asm\asm_bb::bb_getcovernode();
  self aiclearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self setflaggedanimknobrestart(var_1, var_2, 1, 0.2, 1);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

function registerinteractable(var_0, var_1) {
  if(!isDefined(level.interactables)) {
    level.interactables = [];
  }

  level.interactables[var_0] = var_1;
}

function disableinteractable() {
  if(isDefined(self.interaction)) {
    self.disableinteraction = 1;
    return;
  }
}

function shouldplayinteractable(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_4) && isDefined(var_4.interactable) && !isDefined(var_4.disableinteraction)) {
    return true;
  }

  return false;
}

function interactablefinished(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_eventfired(var_0, "interactable_finished");
}

function chooseaniminteractable(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm_bb::bb_getcovernode();
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3.interactable);
}

function playinteractable(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm_bb::bb_getcovernode();
  var_4.disableinteraction = 1;
  [[level.interactables[var_4.interactable]]](var_0, var_1, var_3);
  scripts\asm\asm::asm_fireevent(var_0, "interactable_finished");
}

function interactableterminate(var_0, var_1, var_2) {}