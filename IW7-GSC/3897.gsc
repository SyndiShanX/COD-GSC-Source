/***********************************************
 * Decompiled by Mjkzy and Edited by SyndiShanX
 * Script: 3897.gsc
***********************************************/

func_2371() {
  if(scripts\asm\asm::func_232E("seeker_mp")) {
    return;
  }
  scripts\asm\asm::func_230B("seeker_mp", "seeker_init");
  scripts\asm\asm::func_2374("idle", lib_0F3C::func_B050, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("exit", undefined, ::func_12244, undefined);
  scripts\asm\asm::func_2374("run_loop", lib_0F38::func_B063, undefined, undefined, lib_0F38::func_F173, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face motion", "code_move", undefined);
  scripts\asm\asm::func_2375("idle", undefined, ::func_1243F, undefined);
  scripts\asm\asm::func_2374("seeker_init", scripts\asm\shared\utility::func_2B58, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, undefined, undefined, 1);
  scripts\asm\asm::func_2375("idle", undefined, scripts\asm\shared\utility::func_12668, undefined);
  scripts\asm\asm::func_2374("traverse_external", lib_0F38::func_D560, undefined, undefined, lib_0F38::func_F178, "run_loop", lib_0F3C::func_3E96, 0, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2374("death_generic", lib_0F38::func_F16E, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined);
  scripts\asm\asm::func_2374("exit", lib_0F3C::func_CEA8, undefined, undefined, undefined, undefined, lib_0F3C::func_3E96, undefined, undefined, undefined, undefined, undefined, undefined, undefined, "death_generic", undefined, undefined, undefined, undefined, "face current", "anim deltas", undefined);
  scripts\asm\asm::func_2375("run_loop", undefined, lib_0F38::isfactorinuse, undefined);
  scripts\asm\asm::func_2327();
}

func_12244(var_0, var_1, var_2, var_3) {
  return isDefined(self.pathgoalpos);
}

func_1243F(var_0, var_1, var_2, var_3) {
  return !isDefined(self.pathgoalpos);
}