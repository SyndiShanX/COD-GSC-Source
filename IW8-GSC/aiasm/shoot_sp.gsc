/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\shoot_sp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["shoot"])) {
    return;
  }

  anim.asmfuncs["shoot"] = [];
  anim.asmfuncs["shoot"][0] = &scripts\asm\shoot\script_funcs::shoot_playidleanimloop;
  anim.asmfuncs["shoot"][1] = &scripts\asm\shoot\script_funcs::chooseshootidle;
  anim.asmfuncs["shoot"][2] = &scripts\asm\soldier\script_funcs::shoot_generic;
  anim.asmfuncs["shoot"][3] = &scripts\asm\shoot\script_funcs::initshoot;
  anim.asmfuncs["shoot"][4] = &scripts\asm\shared\utility::chooseanimshoot;
  anim.asmfuncs["shoot"][5] = &scripts\asm\shoot\script_funcs::shoot_mg;
  anim.asmfuncs["shoot"][6] = &scripts\asm\soldier\script_funcs::shoot_playidleanimloop_sniper;
  anim.asmfuncs["shoot"][7] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["shoot"][8] = &scripts\asm\shoot\script_funcs::shootstylemgturret;
  anim.asmfuncs["shoot"][9] = &scripts\asm\soldier\script_funcs::shouldsniperidle;
  anim.asmfuncs["shoot"][10] = &scripts\asm\soldier\script_funcs::shouldendsniperidle;
  anim.asmfuncs["shoot"][11] = &scripts\asm\soldier\script_funcs::shouldsniperbeginfiring;
}