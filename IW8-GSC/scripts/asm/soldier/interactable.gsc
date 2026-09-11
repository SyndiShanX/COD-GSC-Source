/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\interactable.gsc
************************************************/

function onlevelload() {
  registerinteractable("example", &run_example_interactable);
}

function run_example_interactable(var0, var1, var2) {
  iprintlnbold("Example Interactable is Running.");
  var3 = scripts\asm\asm_bb::bb_getcovernode();
  self aiclearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self setflaggedanimknobrestart(var1, var2, 1, 0.2, 1);
  scripts\asm\asm::asm_donotetracks(var0, var1);
}

function registerinteractable(var0, var1) {
  if(!isDefined(level.interactables)) {
    level.interactables = [];
  }

  level.interactables[var0] = var1;
}

function disableinteractable() {
  if(isDefined(self.interaction)) {
    self.disableinteraction = 1;
    return;
  }
}

function shouldplayinteractable(var0, var1, var2, var3) {
  var4 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var4) && isDefined(var4.interactable) && !isDefined(var4.disableinteraction)) {
    return true;
  }

  return false;
}

function interactablefinished(var0, var1, var2, var3) {
  return scripts\asm\asm::asm_eventfired(var0, "interactable_finished");
}

function chooseaniminteractable(var0, var1, var2) {
  var3 = scripts\asm\asm_bb::bb_getcovernode();
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var3.interactable);
}

function playinteractable(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm_bb::bb_getcovernode();
  var4.disableinteraction = 1;
  [[level.interactables[var4.interactable]]](var0, var1, var3);
  scripts\asm\asm::asm_fireevent(var0, "interactable_finished");
}

function interactableterminate(var0, var1, var2) {}