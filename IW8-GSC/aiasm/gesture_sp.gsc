/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\gesture_sp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["gesture"])) {
    return;
  }

  anim.asmfuncs["gesture"] = [];
  anim.asmfuncs["gesture"][0] = &scripts\asm\gesture\script_funcs::ai_gesture_requested;
  anim.asmfuncs["gesture"][1] = &scripts\asm\gesture\script_funcs::ai_point_gesture_requested;
}