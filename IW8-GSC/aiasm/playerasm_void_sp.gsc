/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\playerasm_void_sp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["playerasm_void"])) {
    return;
  }

  anim.asmfuncs["playerasm_void"] = [];
}