/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3127.gsc
************************/

func_3EE5(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

func_3EE6(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

func_3EE7(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

func_3EEB(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

func_3EEC(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

func_3EE8(param_00, param_01, param_02) {
  return lib_0F3C::func_3EF4(param_00, param_01, param_02);
}

func_CF04(param_00, param_01, param_02, param_03) {}

func_D4EE(param_00, param_01, param_02, param_03) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_04 = level.asm[param_00].states[param_01].var_71A5;
  var_05 = self[[var_04]](param_00, param_01, param_03);
  if(isDefined(self.vehicle_getspawnerarray)) {
    self ghostlaunched("anim deltas");
    self orientmode("face angle abs", self.angles);
  }

  scripts\asm\asm_mp::func_2365(param_00, param_01, param_02, var_05);
  func_6CE0(param_00, param_01, param_03);
}

func_6CE0(param_00, param_01, param_02) {
  self notify("killanimscript");
  var_03 = level.asm[param_00].states[param_01];
  var_04 = param_02;
  if(!isDefined(var_04)) {
    if(isDefined(var_03.transitions) && var_03.transitions.size > 0) {
      return;
    }

    var_04 = "exposed_idle";
  }

  scripts\asm\asm::func_2388(param_00, param_01, var_03, var_03.var_116FB);
  scripts\asm\asm::func_238A(param_00, var_04, 0.2, undefined, undefined, undefined);
}

func_4109(param_00, param_01, param_02) {}