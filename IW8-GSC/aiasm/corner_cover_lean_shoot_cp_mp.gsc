/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\corner_cover_lean_shoot_cp_mp.gsc
***************************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["corner_cover_lean_shoot_cp"])) {
    return;
  }

  anim.asmfuncs["corner_cover_lean_shoot_cp"] = [];
  anim.asmfuncs["corner_cover_lean_shoot_cp"][0] = &scripts\asm\soldier\script_funcs::shoot_generic;
  anim.asmfuncs["corner_cover_lean_shoot_cp"][1] = &scripts\asm\shoot\script_funcs::shoot_playidleanimloop;
  anim.asmfuncs["corner_cover_lean_shoot_cp"][2] = &autogenfunc_0;
}

function autogenfunc_0(var_0, var_1, var_2, var_3) {
  return isDefined(self.node) && self.node.type == "Cover Left";
}