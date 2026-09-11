/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\gesture_lw_mp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["gesture_lw"])) {
    return;
  }

  anim.asmfuncs["gesture_lw"] = [];
  anim.asmfuncs["gesture_lw"][0] = &scripts\asm\soldier\mp\gesture_script_funcs::ai_gesture_requested;
  anim.asmfuncs["gesture_lw"][1] = &scripts\asm\soldier\mp\gesture_script_funcs::ai_point_gesture_requested;
}