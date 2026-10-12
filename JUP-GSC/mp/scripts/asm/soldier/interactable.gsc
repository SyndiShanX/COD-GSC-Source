/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\interactable.gsc
************************************************/

#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\shared\utility;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace interactable;

function onlevelload() {
  registerinteractable("example", &run_example_interactable);
}

function run_example_interactable(asmname, statename, animationdata) {
  iprintlnbold("Example Interactable is Running.");
  covernode = scripts\asm\asm_bb::bb_getcovernode();
  assert(covernode);
  self aiclearanim(asm_getbodyknob(), 0.2);
  self setflaggedanimknobrestart(statename, animationdata, 1, 0.2, 1);
  asm_donotetracks(asmname, statename);
}

function registerinteractable(interactable, func) {
  if(!isDefined(level.interactables)) {
    level.interactables = [];
  }

  level.interactables[interactable] = func;
}

function disableinteractable() {
  assert(isnode(self));

  if(isDefined(self.interaction)) {
    self.disableinteraction = 1;
  }
}

function shouldplayinteractable(asmname, statename, tostatename, params) {
  covernode = scripts\asm\asm_bb::bb_getcovernode();

  if(isDefined(covernode) && isDefined(covernode.interactable) && !isDefined(covernode.disableinteraction)) {
    return true;
  }

  return false;
}

function interactablefinished(asmname, statename, tostatename, params) {
  return asm_eventfired(asmname, "interactable_finished");
}

function chooseaniminteractable(asmname, statename, params) {
  covernode = scripts\asm\asm_bb::bb_getcovernode();
  assert(isDefined(covernode));
  assert(isDefined(covernode.interactable));
  return asm_lookupanimfromalias(statename, covernode.interactable);
}

function playinteractable(asmname, statename, params) {
  self endon(statename + "_finished");
  animations = asm_getanim(asmname, statename);
  covernode = scripts\asm\asm_bb::bb_getcovernode();
  assert(isDefined(covernode));
  assert(isDefined(covernode.interactable));
  assertex(isDefined(level.interactables[covernode.interactable]), "<dev string:x1c>" + covernode.interactable + "<dev string:x2d>");
  covernode.disableinteraction = 1;
  [[level.interactables[covernode.interactable]]](asmname, statename, animations);
  asm_fireevent(asmname, "interactable_finished");
}

function interactableterminate(asmname, statename, params) {}