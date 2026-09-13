/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\gesture_cp_mp.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["gesture_cp"])) {
    return;
  }
  anim.asmfuncs["gesture_cp"] = [];
  anim.asmfuncs["gesture_cp"][0] = scripts\asm\soldier\mp\gesture_script_funcs::ai_gesture_requested;
  anim.asmfuncs["gesture_cp"][1] = scripts\asm\soldier\mp\gesture_script_funcs::ai_point_gesture_requested;
}