/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\corner_cover_lean_shoot_cp_mp.gsc
***************************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["corner_cover_lean_shoot_cp"])) {
    return;
  }
  anim.asmfuncs["corner_cover_lean_shoot_cp"] = [];
  anim.asmfuncs["corner_cover_lean_shoot_cp"][0] = ::autogenfunc_0;
}

autogenfunc_0(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self.node) && self.node.type == "Cover Left";
}