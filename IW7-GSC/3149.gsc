/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3149.gsc
************************/

func_2371() {
  if(scripts\asm\asm::func_232E("gesture")) {
    return;
  }

  scripts\asm\asm::func_230B("gesture", "gesture_start");
  scripts\asm\asm::func_2374("gesture", ::lib_0C4C::func_D48B, undefined, undefined, undefined, undefined, ::lib_0C4C::func_3EDA, undefined, ["gesture"], undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("gesture_start", undefined, ::func_121A5, undefined);
  scripts\asm\asm::func_2374("gesture_start", ::lib_0C4C::func_980D, undefined, undefined, undefined, undefined, ::lib_0F3D::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("gesture", undefined, ::func_121A1, undefined);
  scripts\asm\asm::func_2375("gesture_point", undefined, ::func_121A3, undefined);
  scripts\asm\asm::func_2374("gesture_point", ::lib_0C4C::func_D48B, undefined, undefined, undefined, undefined, ::lib_0C4C::func_3EDA, undefined, ["gesture"], undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2375("gesture_start", undefined, ::func_1219F, undefined);
  scripts\asm\asm::func_2327();
}

func_121A5(var_0, var_1, var_2, var_3) {
  return !lib_0C4C::func_195F();
}

func_121A1(var_0, var_1, var_2, var_3) {
  return lib_0C4C::func_195F();
}

func_121A3(var_0, var_1, var_2, var_3) {
  return lib_0C4C::func_19D2();
}

func_1219F(var_0, var_1, var_2, var_3) {
  return !lib_0C4C::func_19D2();
}