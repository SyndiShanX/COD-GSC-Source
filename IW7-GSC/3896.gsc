/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3896.gsc
************************/

func_B063(var_0, var_1, var_2, var_3) {
  self setscriptablepartstate("run", "active", 0);
  self gib_fx_override("gravity");
  scripts\asm\asm_mp::func_2364(var_0, var_1, var_2, 1.3);
}

func_F173(var_0, var_1, var_2, var_3) {
  self setscriptablepartstate("run", "activeEnd", 0);
}

func_F178(var_0, var_1, var_2, var_3) {
  self.var_9FB2 = 0;
  self setscriptablepartstate("jump", "activeEnd", 0);
}

func_D560(var_0, var_1, var_2, var_3) {
  self endon("death");
  self.var_9FB2 = 1;
  self setscriptablepartstate("jump", "active", 0);
  var_4 = self getspectatepoint();
  var_5 = self _meth_8145();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_4.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_6 = var_5.origin - var_4.origin;
  var_7 = self getsafecircleorigin(var_1, 0);
  var_8 = getanimlength(var_7);
  var_9 = getmovedelta(var_7);
  self ghostexplode(self.origin, var_5.origin, var_8);
  self setanimstate(var_1, 0);
  wait(var_8);
  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(var_0, var_1);
}

func_D562(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = self getspectatepoint();
  var_5 = self _meth_8145();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_4.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_6 = var_5.origin - var_4.origin;
  var_7 = self getsafecircleorigin(var_1, 0);
  var_8 = getanimlength(var_7);
  self setanimstate(var_1, 0);
  var_9 = undefined;
  var_0A = var_4.origin[2] - var_5.origin[2];
  if(var_0A < -16) {
    var_9 = var_5.origin + (0, 0, 32);
    self ghostexplode(self.origin, var_9, var_8);
    wait(var_8);
    self setanimstate(var_1, 1);
  } else if(var_0A > 16) {
    var_9 = (var_5.origin[0], var_5.origin[1], var_4.origin[2]);
    self ghostexplode(self.origin, var_9, var_8 * 0.5);
    wait(var_8 * 0.5);
  } else {
    self ghostexplode(self.origin, var_5.origin, var_8);
    wait(var_8);
  }

  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(var_0, var_1);
}

func_BBC2(var_0) {
  self endon("stop_motion_hack");
  for(;;) {
    self setorigin(var_0.origin, 1);
    self.angles = var_0.angles;
    wait(0.05);
  }
}

func_11701(var_0, var_1) {
  var_2 = level.asm[var_0].states[var_1];
  var_3 = undefined;
  if(isarray(var_2.var_116FB)) {
    var_3 = var_2.var_116FB[0];
  } else {
    var_3 = var_2.var_116FB;
  }

  scripts\asm\asm::func_2388(var_0, var_1, var_2, var_2.var_116FB);
  scripts\asm\asm::func_238A(var_0, var_3, 0, undefined, undefined, undefined);
  self notify("killanimscript");
}

func_F16E(var_0, var_1, var_2, var_3) {
  self notify("terminate_ai_threads");
  self notify("killanimscript");
}

isfactorinuse(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_4 = anglesToForward(self.angles);
  var_5 = vectortoangles(var_4);
  var_6 = vectordot(vectornormalize((var_4[0], var_4[1], 0)), anglesToForward(self.angles));
  var_7 = 0.966;
  return var_6 > var_7;
}