/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\interactable.gsc
***********************************************/

onlevelload() {
  registerinteractable("_encstr_8F8308258BDA40A05C99", ::run_example_interactable);
}

run_example_interactable(var_0, var_1, var_2) {
  iprintlnbold("_encstr_A5AB21F8A21F07AAD80BE8990540B733B77963220961FF76D84FE08A1B78BDE768917E");
  var_3 = scripts\asm\asm_bb::bb_getcovernode();
  self aiclearanim(scripts\asm\asm::asm_getbodyknob(), 0.2);
  self setflaggedanimknobrestart(var_1, var_2, 1.0, 0.2, 1.0);
  scripts\asm\asm::asm_donotetracks(var_0, var_1);
}

registerinteractable(var_0, var_1) {
  if(!isDefined(level.interactables))
    level.interactables = [];

  level.interactables[var_0] = var_1;
}

disableinteractable() {
  if(isDefined(self.interaction))
    self.disableinteraction = 1;
}

shouldplayinteractable(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(var_4) && isDefined(var_4.interactable) && !isDefined(var_4.disableinteraction))
    return 1;

  return 0;
}

interactablefinished(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm::asm_eventfired(var_0, "_encstr_B4E81670C2E3CDCA9999392FC6A8B3395F7FB81A98D1C79A");
}

chooseaniminteractable(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm_bb::bb_getcovernode();
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3.interactable);
}

playinteractable(var_0, var_1, var_2) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm_bb::bb_getcovernode();
  var_4.disableinteraction = 1;
  [[level.interactables[var_4.interactable]]](var_0, var_1, var_3);
  scripts\asm\asm::asm_fireevent(var_0, "_encstr_B4E81670C2E3CDCA9999392FC6A8B3395F7FB81A98D1C79A");
}

interactableterminate(var_0, var_1, var_2) {}