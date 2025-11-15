/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3896.gsc
************************/

func_B063(param_00, param_01, param_02, param_03) {
  self setscriptablepartstate("run", "active", 0);
  self gib_fx_override("gravity");
  scripts\asm\asm_mp::func_2364(param_00, param_01, param_02, 1.3);
}

func_F173(param_00, param_01, param_02, param_03) {
  self setscriptablepartstate("run", "activeEnd", 0);
}

func_F178(param_00, param_01, param_02, param_03) {
  self.var_9FB2 = 0;
  self setscriptablepartstate("jump", "activeEnd", 0);
}

func_D560(param_00, param_01, param_02, param_03) {
  self endon("death");
  self.var_9FB2 = 1;
  self setscriptablepartstate("jump", "active", 0);
  var_04 = self getspectatepoint();
  var_05 = self _meth_8145();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_04.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_06 = var_05.origin - var_04.origin;
  var_07 = self getsafecircleorigin(param_01, 0);
  var_08 = getanimlength(var_07);
  var_09 = getmovedelta(var_07);
  self ghostexplode(self.origin, var_05.origin, var_08);
  self setanimstate(param_01, 0);
  wait(var_08);
  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(param_00, param_01);
}

func_D562(param_00, param_01, param_02, param_03) {
  self endon("death");
  var_04 = self getspectatepoint();
  var_05 = self _meth_8145();
  self gib_fx_override("noclip");
  self orientmode("face angle abs", var_04.angles);
  self ghostlaunched("anim deltas");
  self scragentsetanimscale(1, 1);
  var_06 = var_05.origin - var_04.origin;
  var_07 = self getsafecircleorigin(param_01, 0);
  var_08 = getanimlength(var_07);
  self setanimstate(param_01, 0);
  var_09 = undefined;
  var_0A = var_04.origin[2] - var_05.origin[2];
  if(var_0A < -16) {
    var_09 = var_05.origin + (0, 0, 32);
    self ghostexplode(self.origin, var_09, var_08);
    wait(var_08);
    self setanimstate(param_01, 1);
  } else if(var_0A > 16) {
    var_09 = (var_05.origin[0], var_05.origin[1], var_04.origin[2]);
    self ghostexplode(self.origin, var_09, var_08 * 0.5);
    wait(var_08 * 0.5);
  } else {
    self ghostexplode(self.origin, var_05.origin, var_08);
    wait(var_08);
  }

  self gib_fx_override("gravity");
  self notify("traverse_end");
  func_11701(param_00, param_01);
}

func_BBC2(param_00) {
  self endon("stop_motion_hack");
  for(;;) {
    self setorigin(param_00.origin, 1);
    self.angles = param_00.angles;
    wait(0.05);
  }
}

func_11701(param_00, param_01) {
  var_02 = level.asm[param_00].states[param_01];
  var_03 = undefined;
  if(isarray(var_02.var_116FB)) {
    var_03 = var_02.var_116FB[0];
  } else {
    var_03 = var_02.var_116FB;
  }

  scripts\asm\asm::func_2388(param_00, param_01, var_02, var_02.var_116FB);
  scripts\asm\asm::func_238A(param_00, var_03, 0, undefined, undefined, undefined);
  self notify("killanimscript");
}

func_F16E(param_00, param_01, param_02, param_03) {
  self notify("terminate_ai_threads");
  self notify("killanimscript");
}

isfactorinuse(param_00, param_01, param_02, param_03) {
  if(!isDefined(self.vehicle_getspawnerarray)) {
    return 0;
  }

  var_04 = anglesToForward(self.angles);
  var_05 = vectortoangles(var_04);
  var_06 = vectordot(vectornormalize((var_04[0], var_04[1], 0)), anglesToForward(self.angles));
  var_07 = 0.966;
  return var_06 > var_07;
}