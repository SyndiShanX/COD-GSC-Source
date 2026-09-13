/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\shoot_cp_mp.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["shoot_cp"])) {
    return;
  }
  anim.asmfuncs["shoot_cp"] = [];
  anim.asmfuncs["shoot_cp"][0] = scripts\asm\shoot\script_funcs::chooseshootidle;
  anim.asmfuncs["shoot_cp"][1] = scripts\asm\shared\utility::chooseanimshoot;
  anim.asmfuncs["shoot_cp"][2] = scripts\asm\shoot\script_funcs::shoot_mg;
  anim.asmfuncs["shoot_cp"][3] = scripts\asm\soldier\script_funcs::shoot_playidleanimloop_sniper;
  anim.asmfuncs["shoot_cp"][4] = scripts\asm\shoot\script_funcs::shootstylemgturret;
}