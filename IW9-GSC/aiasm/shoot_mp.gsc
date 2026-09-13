/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\shoot_mp.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["shoot"])) {
    return;
  }
  anim.asmfuncs["shoot"] = [];
  anim.asmfuncs["shoot"][0] = scripts\asm\shoot\script_funcs::chooseshootidle;
  anim.asmfuncs["shoot"][1] = scripts\asm\shared\utility::chooseanimshoot;
  anim.asmfuncs["shoot"][2] = scripts\asm\shoot\script_funcs::shoot_mg;
  anim.asmfuncs["shoot"][3] = scripts\asm\soldier\script_funcs::shoot_playidleanimloop_sniper;
  anim.asmfuncs["shoot"][4] = scripts\asm\shoot\script_funcs::_id_DF456D335FE508DA;
  anim.asmfuncs["shoot"][5] = scripts\asm\shoot\script_funcs::shootstylemgturret;
}