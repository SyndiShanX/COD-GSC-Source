/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\soldier\custom.gsc
***********************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#namespace custom;

function shouldstartcustomidle(asmname, statename, tostatename, params) {
  self notify("cap_custom_arrival");
  return isDefined(self.var_85ecbbe4fae7c0ae);
}

function shouldcustomexit(asmname, statename, tostatename, params) {
  return bb_moverequested() && isDefined(self.var_57e1b0c4ad45db70);
}

function shouldstopcustomidle(asmname, statename, tostatename, params) {
  return !isDefined(self.var_85ecbbe4fae7c0ae);
}

function chooseanim_customidle(asmname, statename, params) {
  assert(isDefined(self.var_85ecbbe4fae7c0ae));
  return asm_getrandomanim(asmname, self.var_85ecbbe4fae7c0ae);
}

function function_c929d0a507d24467(asmname, statename, tostatename, params) {
  return isDefined(self.customarrivalhandler);
}

function function_a08c428057e0222a(asmname, statename, params) {
  assert(isDefined(self.customarrivalhandler));
  self[[self.customarrivalhandler]]();
}