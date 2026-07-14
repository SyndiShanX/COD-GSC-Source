/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\asm\soldier\custom.gsc
******************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#namespace custom;

function shouldstartcustomidle(asmname, statename, tostatename, params) {
  self notify("\xd2\x9e\xbc0L\rL\xfe\xb1\xb6\xf5\xa3\xbd\xa6\x1a\x13\xa3\xf4");
  return isDefined(self.var_86770fad21f191a3);
}

function shouldcustomexit(asmname, statename, tostatename, params) {
  return asm_bb::bb_moverequested() && isDefined(self.var_c9829cc678d083b1);
}

function shouldstopcustomidle(asmname, statename, tostatename, params) {
  return !isDefined(self.var_86770fad21f191a3);
}

function chooseanim_customidle(asmname, statename, params) {
  assert(isDefined(self.var_86770fad21f191a3));
  return asm::asm_getrandomanim(asmname, self.var_86770fad21f191a3);
}

function function_83a27bcafa74214a(asmname, statename, tostatename, params) {
  return isDefined(self.customarrivalhandler);
}

function function_95692516b3b4d337(asmname, statename, params) {
  assert(isDefined(self.customarrivalhandler));
  self[[self.customarrivalhandler]]();
}