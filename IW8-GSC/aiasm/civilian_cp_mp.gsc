/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\civilian_cp_mp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["civilian_cp"])) {
    return;
  }

  anim.asmfuncs["civilian_cp"] = [];
  anim.asmfuncs["civilian_cp"][0] = &scripts\asm\civilian\script_funcs::civilian_init;
  anim.asmfuncs["civilian_cp"][1] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["civilian_cp"][2] = &scripts\asm\soldier\death::playdeathanim;
  anim.asmfuncs["civilian_cp"][3] = &scripts\asm\soldier\death::choosedirectionaldeathanim;
  anim.asmfuncs["civilian_cp"][4] = &scripts\asm\soldier\death::choosedirectionalcrouchdeathanim;
  anim.asmfuncs["civilian_cp"][5] = &scripts\asm\soldier\death::choosemovingdeathanim;
  anim.asmfuncs["civilian_cp"][6] = &scripts\asm\civilian\script_funcs::civilian_playsharpturnanim;
  anim.asmfuncs["civilian_cp"][7] = &scripts\asm\soldier\move::choosesharpturnanim;
  anim.asmfuncs["civilian_cp"][8] = &scripts\asm\civilian\script_funcs::civilian_move_cleanup;
  anim.asmfuncs["civilian_cp"][9] = &scripts\asm\civilian\script_funcs::civilian_playanim_exit;
  anim.asmfuncs["civilian_cp"][10] = &scripts\asm\civilian\script_funcs::civilian_chooseanim_exit;
  anim.asmfuncs["civilian_cp"][11] = &scripts\asm\civilian\script_funcs::civilian_exit_cleanup;
  anim.asmfuncs["civilian_cp"][12] = &scripts\asm\shared\utility::calcarrivaltype;
  anim.asmfuncs["civilian_cp"][13] = &scripts\asm\civilian\script_funcs::choosecivilianreactidleanim;
  anim.asmfuncs["civilian_cp"][14] = &scripts\asm\civilian\script_funcs::cleanupcivilianreactionalias;
  anim.asmfuncs["civilian_cp"][15] = &scripts\asm\civilian\script_funcs::civilian_playmoveloop;
  anim.asmfuncs["civilian_cp"][16] = &scripts\asm\civilian\script_funcs::civilian_playmoveloopblendspace;
  anim.asmfuncs["civilian_cp"][17] = &scripts\asm\soldier\arrival::playanim_arrival;
  anim.asmfuncs["civilian_cp"][18] = &scripts\asm\soldier\arrival::chooseanim_arrival;
  anim.asmfuncs["civilian_cp"][19] = &scripts\asm\soldier\arrival::finisharrival;
  anim.asmfuncs["civilian_cp"][20] = &scripts\asm\civilian\script_funcs::civilian_loopidleanim;
  anim.asmfuncs["civilian_cp"][21] = &scripts\asm\shared\utility::loopanim;
  anim.asmfuncs["civilian_cp"][22] = &scripts\asm\civilian\script_funcs::chooseciviliantransitiontoidleanim;
  anim.asmfuncs["civilian_cp"][23] = &scripts\asm\civilian\script_funcs::civilian_playexposedloop;
  anim.asmfuncs["civilian_cp"][24] = &scripts\asm\soldier\move::chooseanim_exit;
  anim.asmfuncs["civilian_cp"][25] = &scripts\asm\gesture::playcoveranim_gesture;
  anim.asmfuncs["civilian_cp"][26] = &scripts\asm\gesture::chooseanim_gesture;
  anim.asmfuncs["civilian_cp"][27] = &scripts\asm\gesture::cleargestureanim;
  anim.asmfuncs["civilian_cp"][28] = &scripts\asm\traverse::calctraversetype;
  anim.asmfuncs["civilian_cp"][29] = &scripts\asm\soldier\traverse::playtraverseanim_ladder;
  anim.asmfuncs["civilian_cp"][30] = &scripts\asm\soldier\mp\script_funcs::forwardpushevent;
  anim.asmfuncs["civilian_cp"][31] = &scripts\asm\civilian\script_funcs::civilian_chooseanim_playerpushed;
  anim.asmfuncs["civilian_cp"][32] = &scripts\asm\traverse::traverse_cleanup;
  anim.asmfuncs["civilian_cp"][33] = &scripts\asm\traverse::playtraversearrivalanim;
  anim.asmfuncs["civilian_cp"][34] = &scripts\asm\traverse::traversechooseanim;
  anim.asmfuncs["civilian_cp"][35] = &scripts\asm\traverse::playtraverseanim_scaled;
  anim.asmfuncs["civilian_cp"][36] = &scripts\asm\shared\utility::animscriptedstartup;
  anim.asmfuncs["civilian_cp"][37] = &scripts\asm\shared\utility::animscriptedcleanup;
  anim.asmfuncs["civilian_cp"][38] = &scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["civilian_cp"][39] = &scripts\asm\shared\utility::animsriptedactioncivilian_terminate;
  anim.asmfuncs["civilian_cp"][40] = &scripts\asm\soldier\arrival::shouldconsiderarrivalaftercodemove;
  anim.asmfuncs["civilian_cp"][41] = &autogenfunc_0;
  anim.asmfuncs["civilian_cp"][42] = &autogenfunc_1;
  anim.asmfuncs["civilian_cp"][43] = &autogenfunc_2;
  anim.asmfuncs["civilian_cp"][44] = &scripts\asm\civilian\script_funcs::civilianstateis;
  anim.asmfuncs["civilian_cp"][45] = &scripts\asm\civilian\script_funcs::iswhizbydetected;
  anim.asmfuncs["civilian_cp"][46] = &scripts\asm\shared\utility::shouldleaveanimscripted;
  anim.asmfuncs["civilian_cp"][47] = &scripts\asm\soldier\move::shoulddosharpturn;
  anim.asmfuncs["civilian_cp"][48] = &scripts\asm\soldier\arrival::shouldconsiderarrival;
  anim.asmfuncs["civilian_cp"][49] = &scripts\asm\soldier\arrival::shouldstartarrivalpassthroughcivilian;
  anim.asmfuncs["civilian_cp"][50] = &scripts\asm\civilian\script_funcs::civarrival_finishearly;
  anim.asmfuncs["civilian_cp"][51] = &scripts\asm\civilian\script_funcs::civilianstateisnot;
  anim.asmfuncs["civilian_cp"][52] = &scripts\asm\civilian\script_funcs::shouldcustomtransition;
  anim.asmfuncs["civilian_cp"][53] = &autogenfunc_3;
  anim.asmfuncs["civilian_cp"][54] = &scripts\asm\civilian\script_funcs::shoulddirectlytransition;
  anim.asmfuncs["civilian_cp"][55] = &autogenfunc_4;
  anim.asmfuncs["civilian_cp"][56] = &scripts\asm\civilian\script_funcs::civmoverequested;
  anim.asmfuncs["civilian_cp"][57] = &scripts\asm\asm_bb::bb_canplaygesture;
  anim.asmfuncs["civilian_cp"][58] = &scripts\asm\gesture::gesture_finishearly;
  anim.asmfuncs["civilian_cp"][59] = &scripts\asm\traverse::shouldconsidertraversearrival;
  anim.asmfuncs["civilian_cp"][60] = &scripts\asm\traverse::shouldstarttraverse;
  anim.asmfuncs["civilian_cp"][61] = &scripts\asm\traverse::setuptraversaltransitioncheck;
  anim.asmfuncs["civilian_cp"][62] = &scripts\asm\civilian\script_funcs::checkarrivaltypecivilian;
  anim.asmfuncs["civilian_cp"][63] = &autogenfunc_5;
  anim.asmfuncs["civilian_cp"][64] = &scripts\asm\civilian\script_funcs::currentsnaptonodeis;
  anim.asmfuncs["civilian_cp"][65] = &scripts\asm\soldier\mp\script_funcs::shouldplaypushedanim;
  anim.asmfuncs["civilian_cp"][66] = &scripts\asm\soldier\move::determinecurrentstairsstate;
  anim.asmfuncs["civilian_cp"][67] = &scripts\asm\traverse::shoulddotraversalarrival;
  anim.asmfuncs["civilian_cp"][68] = &autogenfunc_6;
}

function autogenfunc_0(var_0, var_1, var_2, var_3) {
  return isDefined(self.pathgoalpos);
}

function autogenfunc_1(var_0, var_1, var_2, var_3) {
  return isDefined(self.disableexits) && self.disableexits;
}

function autogenfunc_2(var_0, var_1, var_2, var_3) {
  return !scripts\asm\asm_bb::bb_iswhizbyrequested();
}

function autogenfunc_3(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_getcivilianstate() != "combat" && scripts\asm\asm_bb::bb_getcivilianstate() != "noncombat";
}

function autogenfunc_4(var_0, var_1, var_2, var_3) {
  return scripts\asm\asm_bb::bb_getcivilianstate() != "stealth" && scripts\asm\asm_bb::bb_getcivilianstate() != "panic" && scripts\asm\asm_bb::bb_getcivilianstate() != "cctv" && scripts\asm\asm_bb::bb_getcivilianstate() != "casual";
}

function autogenfunc_5(var_0, var_1, var_2, var_3) {
  return istrue(self.disableexits);
}

function autogenfunc_6(var_0) {
  scripts\asm\gesture::gesture(var_0);
}