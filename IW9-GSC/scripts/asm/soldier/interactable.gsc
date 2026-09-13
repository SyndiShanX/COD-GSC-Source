/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\interactable.gsc
************************************************/

onlevelload() {
  registerinteractable("example", ::run_example_interactable);
}

run_example_interactable(asmname, statename, _id_62B78F0013665CE9) {
  iprintlnbold("Example Interactable is Running.");
  covernode = scripts\asm\asm_bb::bb_getcovernode();
  self aiclearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self setflaggedanimknobrestart(statename, _id_62B78F0013665CE9, 1.0, 0.2, 1.0);
  scripts\asm\asm::asm_donotetracks(asmname, statename);
}

registerinteractable(interactable, func) {
  if(!isDefined(level.interactables))
    level.interactables = [];

  level.interactables[interactable] = func;
}

disableinteractable() {
  if(isDefined(self.interaction))
    self.disableinteraction = 1;
}

shouldplayinteractable(asmname, statename, _id_F2B19B25D457C2A6, params) {
  covernode = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(covernode) && isDefined(covernode.interactable) && !isDefined(covernode.disableinteraction))
    return 1;

  return 0;
}

interactablefinished(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm::asm_eventfired(asmname, "interactable_finished");
}

chooseaniminteractable(asmname, statename, params) {
  covernode = scripts\asm\asm_bb::bb_getcovernode();
  return scripts\asm\asm::asm_lookupanimfromalias(statename, covernode.interactable);
}

playinteractable(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_0C18282FA5D72EBE = scripts\asm\asm::asm_getanim(asmname, statename);
  covernode = scripts\asm\asm_bb::bb_getcovernode();
  covernode.disableinteraction = 1;
  [[level.interactables[covernode.interactable]]](asmname, statename, _id_0C18282FA5D72EBE);
  scripts\asm\asm::asm_fireevent(asmname, "interactable_finished");
}

interactableterminate(asmname, statename, params) {}