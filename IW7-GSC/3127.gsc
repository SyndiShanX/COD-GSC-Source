/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3127.gsc
*********************************************/

func_3EE5(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

func_3EE6(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

func_3EE7(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

func_3EEB(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

func_3EEC(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

func_3EE8(var_0, var_1, var_2) {
  return lib_0F3C::func_3EF4(var_0, var_1, var_2);
}

func_CF04(var_0, var_1, var_2, var_3) {}

func_D4EE(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("terminate_ai_threads");
  var_4 = level.asm[var_0].states[var_1].var_71A5;
  var_5 = self[[var_4]](var_0, var_1, var_3);
  if(isDefined(self.vehicle_getspawnerarray)) {
    self ghostlaunched("anim deltas");
    self orientmode("face angle abs", self.angles);
  }

  scripts\asm\asm_mp::func_2365(var_0, var_1, var_2, var_5);
  func_6CE0(var_0, var_1, var_3);
}

func_6CE0(var_0, var_1, var_2) {
  self notify("killanimscript");
  var_3 = level.asm[var_0].states[var_1];
  var_4 = var_2;
  if(!isDefined(var_4)) {
    if(isDefined(var_3.transitions) && var_3.transitions.size > 0) {
      return;
    }

    var_4 = "exposed_idle";
  }

  scripts\asm\asm::func_2388(var_0, var_1, var_3, var_3.var_116FB);
  scripts\asm\asm::func_238A(var_0, var_4, 0.2, undefined, undefined, undefined);
}

func_4109(var_0, var_1, var_2) {}