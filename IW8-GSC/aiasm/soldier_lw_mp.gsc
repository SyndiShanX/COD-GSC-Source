/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\soldier_lw_mp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["shoot_lw"])) {
    return;
  }

  anim.asmfuncs["shoot_lw"] = [];
  anim.asmfuncs["shoot_lw"][0] = &scripts\asm\shoot\script_funcs::shoot_playidleanimloop;
  anim.asmfuncs["shoot_lw"][1] = &scripts\asm\shoot\script_funcs::chooseshootidle;
  anim.asmfuncs["shoot_lw"][2] = &scripts\asm\soldier\script_funcs::shoot_generic;
  anim.asmfuncs["shoot_lw"][3] = &scripts\asm\shoot\script_funcs::initshoot;
  anim.asmfuncs["shoot_lw"][4] = &scripts\asm\shared\utility::chooseanimshoot;
  anim.asmfuncs["shoot_lw"][5] = &scripts\asm\shoot\script_funcs::shoot_mg;
  anim.asmfuncs["shoot_lw"][6] = &scripts\asm\soldier\script_funcs::shoot_playidleanimloop_sniper;
  anim.asmfuncs["shoot_lw"][7] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["shoot_lw"][8] = &scripts\asm\shoot\script_funcs::shootstylemgturret;
  anim.asmfuncs["shoot_lw"][9] = &scripts\asm\soldier\script_funcs::shouldsniperidle;
  anim.asmfuncs["shoot_lw"][10] = &scripts\asm\soldier\script_funcs::shouldendsniperidle;
  anim.asmfuncs["shoot_lw"][11] = &scripts\asm\soldier\script_funcs::shouldsniperbeginfiring;
}