/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\soldier_agent_lw.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["soldier_lw_br_shoot"])) {
    return;
  }

  anim.asmfuncs["soldier_lw_br_shoot"] = [];
  anim.asmfuncs["soldier_lw_br_shoot"][0] = &scripts\mp\trials\mp_trials_patches_petrograd::ref_134B3;
  anim.asmfuncs["soldier_lw_br_shoot"][1] = &scripts\asm\shoot\script_funcs::chooseshootidle;
  anim.asmfuncs["soldier_lw_br_shoot"][2] = &scripts\asm\soldier\script_funcs::shoot_generic;
  anim.asmfuncs["soldier_lw_br_shoot"][3] = &scripts\asm\shoot\script_funcs::initshoot;
  anim.asmfuncs["soldier_lw_br_shoot"][4] = &scripts\asm\shoot\script_funcs::shoot_mg;
  anim.asmfuncs["soldier_lw_br_shoot"][5] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["soldier_lw_br_shoot"][6] = &scripts\asm\shared\utility::chooseanimshoot;
  anim.asmfuncs["soldier_lw_br_shoot"][7] = &scripts\asm\shoot\script_funcs::shoot_playidleanimloop;
  anim.asmfuncs["soldier_lw_br_shoot"][8] = &scripts\asm\shoot\script_funcs::shootstylemgturret;
  anim.asmfuncs["soldier_lw_br_shoot"][9] = &scripts\asm\soldier\script_funcs::shouldendsniperidle;
  anim.asmfuncs["soldier_lw_br_shoot"][10] = &scripts\asm\soldier\script_funcs::shouldsniperbeginfiring;
  anim.asmfuncs["soldier_lw_br_shoot"][11] = &scripts\asm\soldier\script_funcs::shouldsniperidle;
}