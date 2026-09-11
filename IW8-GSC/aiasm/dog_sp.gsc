/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\dog_sp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["dog"])) {
    return;
  }

  anim.asmfuncs["dog"] = [];
  anim.asmfuncs["dog"][0] = &scripts\asm\dog\move::dog_init;
  anim.asmfuncs["dog"][1] = &scripts\asm\dog\move::playanim_idle;
  anim.asmfuncs["dog"][2] = &scripts\asm\dog\move::dog_notehandler;
  anim.asmfuncs["dog"][3] = &scripts\asm\soldier\death::playdeathanim;
  anim.asmfuncs["dog"][4] = &scripts\asm\dog\move::playturnanim;
  anim.asmfuncs["dog"][5] = &scripts\asm\dog\move::chooseturnanim;
  anim.asmfuncs["dog"][6] = &scripts\asm\dog\move::playturnanim_cleanup;
  anim.asmfuncs["dog"][7] = &scripts\asm\soldier\move::playsharpturnanim;
  anim.asmfuncs["dog"][8] = &scripts\asm\soldier\move::choosesharpturnanim;
  anim.asmfuncs["dog"][9] = &scripts\asm\soldier\move::sharpturn_terminate;
  anim.asmfuncs["dog"][10] = &scripts\asm\shared\utility::playmoveloop;
  anim.asmfuncs["dog"][11] = &scripts\asm\dog\move::playanim_arrival;
  anim.asmfuncs["dog"][12] = &scripts\asm\dog\move::chooseanim_arrival;
  anim.asmfuncs["dog"][13] = &scripts\asm\dog\move::playanim_arrival_cleanup;
  anim.asmfuncs["dog"][14] = &scripts\asm\soldier\move::playanim_exit;
  anim.asmfuncs["dog"][15] = &scripts\asm\soldier\move::chooseanim_exit;
  anim.asmfuncs["dog"][16] = &scripts\asm\soldier\move::terminateexitstartanim;
  anim.asmfuncs["dog"][17] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["dog"][18] = &scripts\asm\soldier\melee::playmeleeanim_vsplayer;
  anim.asmfuncs["dog"][19] = &scripts\asm\dog\move::playanim_bark;
  anim.asmfuncs["dog"][20] = &scripts\asm\soldier\pain::playpainanim;
  anim.asmfuncs["dog"][21] = &scripts\asm\soldier\pain::finishpain;
  anim.asmfuncs["dog"][22] = &scripts\asm\soldier\pain::cleanupflashanim;
  anim.asmfuncs["dog"][23] = &scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["dog"][24] = &scripts\asm\shared\utility::animscriptedaction_terminate;
  anim.asmfuncs["dog"][25] = &scripts\asm\dog\move::needtoturn;
  anim.asmfuncs["dog"][26] = &scripts\asm\dog\move::shouldstartarrival;
  anim.asmfuncs["dog"][27] = &scripts\asm\soldier\move::shoulddosharpturn;
  anim.asmfuncs["dog"][28] = &scripts\asm\dog\move::needtoturnforexit;
  anim.asmfuncs["dog"][29] = &scripts\asm\dog\move::shouldidlebark;
  anim.asmfuncs["dog"][30] = &scripts\asm\dog\move::notshouldidlebark;
  anim.asmfuncs["dog"][31] = &scripts\asm\shared\utility::shouldleaveanimscripted;
}