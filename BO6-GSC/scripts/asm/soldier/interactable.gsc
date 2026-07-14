/************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\interactable.gsc
************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#namespace interactable;

function onlevelload() {
  registerinteractable("\xb0\a\x11[\xe8]\x8c", &run_example_interactable);
}

function run_example_interactable(asmname, statename, animationdata) {
  iprintlnbold("McgiX\xcd\xb5\x89S\xd6\xb3\x88\xae\x0fJ\xe3qj\x8b\x95\x12\xa4\x9b\x91\x1d\xd5\x1d\x18\xfb\x8bb0");
  covernode = asm_bb::bb_getcovernode();
  assert(covernode);
  self aiclearanim(asm::asm_getbodyknob(), 0.2);
  self setflaggedanimknobrestart(statename, animationdata, 1, 0.2, 1);
  asm::asm_donotetracks(asmname, statename);
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
  covernode = asm_bb::bb_getcovernode();

  if(isDefined(covernode) && isDefined(covernode.interactable) && !isDefined(covernode.disableinteraction)) {
    return true;
  }

  return false;
}

function interactablefinished(asmname, statename, tostatename, params) {
  return asm::asm_eventfired(asmname, "\xd0S\nJ$>$\x84P#\x16y\xb0\xc3\x1f\xf4\xd8W{X\xbc");
}

function chooseaniminteractable(asmname, statename, params) {
  covernode = asm_bb::bb_getcovernode();
  assert(isDefined(covernode));
  assert(isDefined(covernode.interactable));
  return asm::asm_lookupanimfromalias(statename, covernode.interactable);
}

function playinteractable(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  animations = asm::asm_getanim(asmname, statename);
  covernode = asm_bb::bb_getcovernode();
  assert(isDefined(covernode));
  assert(isDefined(covernode.interactable));
  assert(isDefined(level.interactables[covernode.interactable]), "<dev string:x24>" + covernode.interactable + "<dev string:x35>");
  covernode.disableinteraction = 1;
  [[level.interactables[covernode.interactable]]](asmname, statename, animations);
  asm::asm_fireevent(asmname, "\xd0S\nJ$>$\x84P#\x16y\xb0\xc3\x1f\xf4\xd8W{X\xbc");
}

function interactableterminate(asmname, statename, params) {}