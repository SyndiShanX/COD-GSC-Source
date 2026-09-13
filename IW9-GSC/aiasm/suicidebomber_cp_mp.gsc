/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\suicidebomber_cp_mp.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["suicidebomber_cp"])) {
    return;
  }
  anim.asmfuncs["suicidebomber_cp"] = [];
  anim.asmfuncs["suicidebomber_cp"][0] = scripts\asm\suicidebomber\suicidebomber::bomber_init;
  anim.asmfuncs["suicidebomber_cp"][1] = scripts\asm\suicidebomber\suicidebomber::playanim_bombermoveloop;
  anim.asmfuncs["suicidebomber_cp"][2] = scripts\asm\shared\utility::loopanim;
  anim.asmfuncs["suicidebomber_cp"][3] = scripts\asm\suicidebomber\suicidebomber::playanim_bomberdeath;
  anim.asmfuncs["suicidebomber_cp"][4] = scripts\asm\soldier\pain::playpainanim;
  anim.asmfuncs["suicidebomber_cp"][5] = scripts\asm\soldier\pain::cleanuppainanim;
  anim.asmfuncs["suicidebomber_cp"][6] = scripts\asm\suicidebomber\suicidebomber::playanim_explode;
  anim.asmfuncs["suicidebomber_cp"][7] = scripts\asm\soldier\pain::playanim_flashed;
  anim.asmfuncs["suicidebomber_cp"][8] = scripts\asm\soldier\pain::cleanupflashanim;
  anim.asmfuncs["suicidebomber_cp"][9] = scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["suicidebomber_cp"][10] = scripts\asm\shared\utility::animscriptedaction_terminate;
  anim.asmfuncs["suicidebomber_cp"][11] = scripts\asm\traverse::calctraversetype;
  anim.asmfuncs["suicidebomber_cp"][12] = scripts\asm\traverse::traverse_cleanup;
  anim.asmfuncs["suicidebomber_cp"][13] = scripts\asm\traverse::playtraversearrivalanim;
  anim.asmfuncs["suicidebomber_cp"][14] = scripts\asm\traverse::traversechooseanim;
  anim.asmfuncs["suicidebomber_cp"][15] = scripts\asm\traverse::playtraverseanim_scaled;
  anim.asmfuncs["suicidebomber_cp"][16] = scripts\asm\soldier\traverse::playtraverseanim_ladder;
  anim.asmfuncs["suicidebomber_cp"][17] = scripts\asm\soldier\traverse::terminate_ladder;
  anim.asmfuncs["suicidebomber_cp"][18] = scripts\asm\soldier\traverse::playtraverseanim_external;
  anim.asmfuncs["suicidebomber_cp"][19] = scripts\asm\soldier\traverse::choosetraverseanim_external;
  anim.asmfuncs["suicidebomber_cp"][20] = scripts\asm\suicidebomber\suicidebomber::shouldexplode;
  anim.asmfuncs["suicidebomber_cp"][21] = scripts\asm\shared\utility::transition_isflashed;
  anim.asmfuncs["suicidebomber_cp"][22] = scripts\asm\soldier\pain::isdamagelocation_head;
  anim.asmfuncs["suicidebomber_cp"][23] = scripts\asm\soldier\pain::isdamagelocation_larm;
  anim.asmfuncs["suicidebomber_cp"][24] = scripts\asm\soldier\pain::isdamagelocation_lleg;
  anim.asmfuncs["suicidebomber_cp"][25] = scripts\asm\soldier\pain::isdamagelocation_rarm;
  anim.asmfuncs["suicidebomber_cp"][26] = scripts\asm\soldier\pain::isdamagelocation_rleg;
  anim.asmfuncs["suicidebomber_cp"][27] = scripts\asm\soldier\pain::isdamagelocation_torso;
  anim.asmfuncs["suicidebomber_cp"][28] = scripts\asm\shared\utility::shouldleaveanimscripted;
  anim.asmfuncs["suicidebomber_cp"][29] = scripts\asm\suicidebomber\suicidebomber::bomber_shouldraisearm;
}