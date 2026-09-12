/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_cp_al_qatala_desert_ar_tmtyl.gsc
****************************************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["suicidebomber_cp"])) {
    return;
  }

  anim.asmfuncs["suicidebomber_cp"] = [];
  anim.asmfuncs["suicidebomber_cp"][0] = &scripts\asm\suicidebomber\suicidebomber::bomber_init;
  anim.asmfuncs["suicidebomber_cp"][1] = &scripts\asm\suicidebomber\suicidebomber::playanim_bombermoveloop;
  anim.asmfuncs["suicidebomber_cp"][2] = &scripts\asm\shared\utility::loopanim;
  anim.asmfuncs["suicidebomber_cp"][3] = &scripts\asm\suicidebomber\suicidebomber::playanim_bomberdeath;
  anim.asmfuncs["suicidebomber_cp"][4] = &scripts\asm\soldier\pain::playpainanim;
  anim.asmfuncs["suicidebomber_cp"][5] = &scripts\asm\soldier\pain::cleanuppainanim;
  anim.asmfuncs["suicidebomber_cp"][6] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["suicidebomber_cp"][7] = &scripts\asm\suicidebomber\suicidebomber::playanim_explode;
  anim.asmfuncs["suicidebomber_cp"][8] = &scripts\asm\soldier\pain::playanim_flashed;
  anim.asmfuncs["suicidebomber_cp"][9] = &scripts\asm\soldier\pain::cleanupflashanim;
  anim.asmfuncs["suicidebomber_cp"][10] = &scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["suicidebomber_cp"][11] = &scripts\asm\shared\utility::animscriptedaction_terminate;
  anim.asmfuncs["suicidebomber_cp"][12] = &scripts\asm\soldier\move::playsharpturnanim;
  anim.asmfuncs["suicidebomber_cp"][13] = &scripts\asm\soldier\move::choosesharpturnanim;
  anim.asmfuncs["suicidebomber_cp"][14] = &scripts\asm\soldier\move::sharpturn_terminate;
  anim.asmfuncs["suicidebomber_cp"][15] = &scripts\asm\traverse::setuptraversaltransitioncheck;
  anim.asmfuncs["suicidebomber_cp"][16] = &scripts\asm\traverse::calctraversetype;
  anim.asmfuncs["suicidebomber_cp"][17] = &scripts\asm\traverse::traverse_cleanup;
  anim.asmfuncs["suicidebomber_cp"][18] = &scripts\asm\traverse::playtraversearrivalanim;
  anim.asmfuncs["suicidebomber_cp"][19] = &scripts\asm\traverse::traversechooseanim;
  anim.asmfuncs["suicidebomber_cp"][20] = &scripts\asm\traverse::playtraverseanim_scaled;
  anim.asmfuncs["suicidebomber_cp"][21] = &scripts\asm\soldier\traverse::playtraverseanim_ladder;
  anim.asmfuncs["suicidebomber_cp"][22] = &scripts\asm\soldier\traverse::terminate_ladder;
  anim.asmfuncs["suicidebomber_cp"][23] = &scripts\asm\soldier\traverse::playtraverseanim_external;
  anim.asmfuncs["suicidebomber_cp"][24] = &scripts\asm\soldier\traverse::choosetraverseanim_external;
  anim.asmfuncs["suicidebomber_cp"][25] = &scripts\asm\soldier\traverse::cleanupwallruntransitioncheck;
  anim.asmfuncs["suicidebomber_cp"][26] = &scripts\asm\traverse::shouldconsidertraversearrival;
  anim.asmfuncs["suicidebomber_cp"][27] = &scripts\asm\traverse::shouldstarttraverse;
  anim.asmfuncs["suicidebomber_cp"][28] = &scripts\asm\traverse::shoulddotraversalarrival;
  anim.asmfuncs["suicidebomber_cp"][29] = &scripts\asm\traverse::ref_13D12;
  anim.asmfuncs["suicidebomber_cp"][30] = &scripts\asm\suicidebomber\suicidebomber::shouldexplode;
  anim.asmfuncs["suicidebomber_cp"][31] = &scripts\asm\shared\utility::transition_isflashed;
  anim.asmfuncs["suicidebomber_cp"][32] = &scripts\asm\soldier\pain::isdamagelocation_head;
  anim.asmfuncs["suicidebomber_cp"][33] = &scripts\asm\soldier\pain::isdamagelocation_larm;
  anim.asmfuncs["suicidebomber_cp"][34] = &scripts\asm\soldier\pain::isdamagelocation_lleg;
  anim.asmfuncs["suicidebomber_cp"][35] = &scripts\asm\soldier\pain::isdamagelocation_rarm;
  anim.asmfuncs["suicidebomber_cp"][36] = &scripts\asm\soldier\pain::isdamagelocation_rleg;
  anim.asmfuncs["suicidebomber_cp"][37] = &scripts\asm\soldier\pain::isdamagelocation_torso;
  anim.asmfuncs["suicidebomber_cp"][38] = &scripts\asm\shared\utility::shouldleaveanimscripted;
  anim.asmfuncs["suicidebomber_cp"][39] = &scripts\asm\suicidebomber\suicidebomber::bomber_shouldraisearm;
  anim.asmfuncs["suicidebomber_cp"][40] = &scripts\asm\soldier\move::shoulddosharpturn;
}