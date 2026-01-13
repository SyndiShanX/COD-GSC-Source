/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3124.gsc
************************/

func_11090() {}

func_4E36() {
  self notify("terminate_ai_threads");
  self notify("killanimscript");
}

func_CF0E(var_0, var_1, var_2, var_3) {
  self gib_fx_override("gravity");
  self ghostlaunched("anim deltas");
  lib_0F3C::func_CEA8(var_0, var_1, var_2);
}

func_3EE2(var_0, var_1, var_2) {
  return 0;
}

func_3ECA(var_0, var_1, var_2) {
  return 0;
}

func_3EC6(var_0, var_1, var_2) {
  return 0;
}

func_3F00(var_0, var_1, var_2) {
  return 0;
}

func_3F02(var_0, var_1, var_2) {
  return 0;
}

func_3F01(var_0, var_1, var_2) {
  return 0;
}

func_6DB2() {
  return 1;
}

playdeathfx() {}

play_blood_pool(var_0, var_1) {}

func_C703() {}

playdeathsound() {}

func_E166(var_0) {}

func_41DC(var_0) {}

func_FFFA(var_0, var_1, var_2, var_3) {
  return 0;
}

isdepot(var_0) {
  if(var_0 == "deserteagle") {
    return 1;
  }

  return 0;
}

func_9D59(var_0, var_1) {
  if(!isDefined(var_0)) {
    return 0;
  }

  if(distance(self.origin, var_0.origin) > var_1) {
    return 0;
  }

  return 1;
}