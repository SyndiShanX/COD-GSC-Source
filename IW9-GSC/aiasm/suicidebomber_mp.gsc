/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\suicidebomber_mp.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["suicidebomber"])) {
    return;
  }
  anim.asmfuncs["suicidebomber"] = [];
  anim.asmfuncs["suicidebomber"][0] = scripts\asm\suicidebomber\suicidebomber::bomber_init;
  anim.asmfuncs["suicidebomber"][1] = scripts\asm\suicidebomber\suicidebomber::playanim_bombermoveloop;
  anim.asmfuncs["suicidebomber"][2] = scripts\asm\shared\utility::loopanim;
  anim.asmfuncs["suicidebomber"][3] = scripts\asm\suicidebomber\suicidebomber::playanim_bomberdeath;
  anim.asmfuncs["suicidebomber"][4] = scripts\asm\soldier\pain::playpainanim;
  anim.asmfuncs["suicidebomber"][5] = scripts\asm\soldier\pain::cleanuppainanim;
  anim.asmfuncs["suicidebomber"][6] = scripts\asm\suicidebomber\suicidebomber::playanim_explode;
  anim.asmfuncs["suicidebomber"][7] = scripts\asm\soldier\pain::playanim_flashed;
  anim.asmfuncs["suicidebomber"][8] = scripts\asm\soldier\pain::cleanupflashanim;
  anim.asmfuncs["suicidebomber"][9] = scripts\asm\suicidebomber\suicidebomber::bomber_finishpainhead;
  anim.asmfuncs["suicidebomber"][10] = scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["suicidebomber"][11] = scripts\asm\shared\utility::animscriptedaction_terminate;
  anim.asmfuncs["suicidebomber"][12] = scripts\asm\traverse::playtraverseanim_scaled;
  anim.asmfuncs["suicidebomber"][13] = scripts\asm\soldier\traverse::playtraverseanim_deprecated;
  anim.asmfuncs["suicidebomber"][14] = scripts\asm\traverse::traverse_cleanup;
  anim.asmfuncs["suicidebomber"][15] = scripts\asm\soldier\traverse::playtraverseanim_external;
  anim.asmfuncs["suicidebomber"][16] = scripts\asm\soldier\traverse::choosetraverseanim_external;
  anim.asmfuncs["suicidebomber"][17] = scripts\asm\soldier\traverse::playtraverseanim_ladder;
  anim.asmfuncs["suicidebomber"][18] = scripts\asm\soldier\traverse::terminate_ladder;
  anim.asmfuncs["suicidebomber"][19] = scripts\asm\soldier\traverse::playtraverseanim;
  anim.asmfuncs["suicidebomber"][20] = scripts\asm\traverse::playtraversearrivalanim;
  anim.asmfuncs["suicidebomber"][21] = scripts\asm\traverse::traversechooseanim;
  anim.asmfuncs["suicidebomber"][22] = scripts\asm\traverse::_id_E9CC41DF0C7DFD7B;
  anim.asmfuncs["suicidebomber"][23] = scripts\asm\traverse::_id_EADD4123F9B2DA38;
  anim.asmfuncs["suicidebomber"][24] = scripts\asm\traverse::calctraversetype;
  anim.asmfuncs["suicidebomber"][25] = scripts\asm\suicidebomber\suicidebomber::shouldexplode;
  anim.asmfuncs["suicidebomber"][26] = scripts\asm\shared\utility::transition_isflashed;
  anim.asmfuncs["suicidebomber"][27] = scripts\asm\soldier\pain::isdamagelocation_head;
  anim.asmfuncs["suicidebomber"][28] = scripts\asm\soldier\pain::isdamagelocation_larm;
  anim.asmfuncs["suicidebomber"][29] = scripts\asm\soldier\pain::isdamagelocation_lleg;
  anim.asmfuncs["suicidebomber"][30] = scripts\asm\soldier\pain::isdamagelocation_rarm;
  anim.asmfuncs["suicidebomber"][31] = scripts\asm\soldier\pain::isdamagelocation_rleg;
  anim.asmfuncs["suicidebomber"][32] = scripts\asm\soldier\pain::isdamagelocation_torso;
  anim.asmfuncs["suicidebomber"][33] = scripts\asm\shared\utility::shouldleaveanimscripted;
  anim.asmfuncs["suicidebomber"][34] = scripts\asm\suicidebomber\suicidebomber::bomber_shouldraisearm;
}