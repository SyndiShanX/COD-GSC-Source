/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\soldier_cp_mp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["shoot_cp"])) {
    return;
  }

  anim.asmfuncs["shoot_cp"] = [];
  anim.asmfuncs["shoot_cp"][0] = &scripts\asm\shoot\script_funcs::shoot_playidleanimloop;
  anim.asmfuncs["shoot_cp"][1] = &scripts\asm\shoot\script_funcs::chooseshootidle;
  anim.asmfuncs["shoot_cp"][2] = &scripts\asm\soldier\script_funcs::shoot_generic;
  anim.asmfuncs["shoot_cp"][3] = &scripts\asm\shoot\script_funcs::initshoot;
  anim.asmfuncs["shoot_cp"][4] = &scripts\asm\shared\utility::chooseanimshoot;
  anim.asmfuncs["shoot_cp"][5] = &scripts\asm\shoot\script_funcs::shoot_mg;
  anim.asmfuncs["shoot_cp"][6] = &scripts\asm\soldier\script_funcs::shoot_playidleanimloop_sniper;
  anim.asmfuncs["shoot_cp"][7] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["shoot_cp"][8] = &scripts\asm\shoot\script_funcs::shootstylemgturret;
  anim.asmfuncs["shoot_cp"][9] = &scripts\asm\soldier\script_funcs::shouldsniperidle;
  anim.asmfuncs["shoot_cp"][10] = &scripts\asm\soldier\script_funcs::shouldendsniperidle;
  anim.asmfuncs["shoot_cp"][11] = &scripts\asm\soldier\script_funcs::shouldsniperbeginfiring;
}