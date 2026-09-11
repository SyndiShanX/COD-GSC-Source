/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\corner_cover_lean_shoot_lw_mp.gsc
***************************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["corner_cover_lean_shoot_lw"])) {
    return;
  }

  anim.asmfuncs["corner_cover_lean_shoot_lw"] = [];
  anim.asmfuncs["corner_cover_lean_shoot_lw"][0] = &scripts\asm\soldier\script_funcs::shoot_generic;
  anim.asmfuncs["corner_cover_lean_shoot_lw"][1] = &scripts\asm\shoot\script_funcs::shoot_playidleanimloop;
  anim.asmfuncs["corner_cover_lean_shoot_lw"][2] = &autogenfunc_0;
}

function autogenfunc_0(var0, var1, var2, var3) {
  return isDefined(self.node) && self.node.type == "Cover Left";
}