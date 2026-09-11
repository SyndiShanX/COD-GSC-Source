/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\civilian_sp.gsc
***********************************************/

function asm_register() {
  if(!isDefined(anim.asmfuncs)) {
    anim.asmfuncs = [];
  }

  if(isDefined(anim.asmfuncs["civilian"])) {
    return;
  }

  anim.asmfuncs["civilian"] = [];
  anim.asmfuncs["civilian"][0] = &scripts\asm\civilian\script_funcs::civilian_init;
  anim.asmfuncs["civilian"][1] = &scripts\asm\shared\utility::playanim;
  anim.asmfuncs["civilian"][2] = &scripts\asm\soldier\death::playdeathanim;
  anim.asmfuncs["civilian"][3] = &scripts\asm\soldier\death::choosedirectionaldeathanim;
  anim.asmfuncs["civilian"][4] = &scripts\asm\soldier\death::choosedirectionalcrouchdeathanim;
  anim.asmfuncs["civilian"][5] = &scripts\asm\soldier\death::choosemovingdeathanim;
  anim.asmfuncs["civilian"][6] = &scripts\asm\civilian\script_funcs::civilian_playsharpturnanim;
  anim.asmfuncs["civilian"][7] = &scripts\asm\soldier\move::choosesharpturnanim;
  anim.asmfuncs["civilian"][8] = &scripts\asm\civilian\script_funcs::civilian_move_cleanup;
  anim.asmfuncs["civilian"][9] = &scripts\asm\civilian\script_funcs::civilian_playanim_exit;
  anim.asmfuncs["civilian"][10] = &scripts\asm\civilian\script_funcs::civilian_chooseanim_exit;
  anim.asmfuncs["civilian"][11] = &scripts\asm\civilian\script_funcs::civilian_exit_cleanup;
  anim.asmfuncs["civilian"][12] = &scripts\asm\shared\utility::calcarrivaltype;
  anim.asmfuncs["civilian"][13] = &scripts\asm\civilian\script_funcs::choosecivilianreactidleanim;
  anim.asmfuncs["civilian"][14] = &scripts\asm\civilian\script_funcs::cleanupcivilianreactionalias;
  anim.asmfuncs["civilian"][15] = &scripts\asm\civilian\script_funcs::civilian_playmoveloop;
  anim.asmfuncs["civilian"][16] = &scripts\asm\civilian\script_funcs::civilian_playmoveloopblendspace;
  anim.asmfuncs["civilian"][17] = &scripts\asm\soldier\arrival::playanim_arrival;
  anim.asmfuncs["civilian"][18] = &scripts\asm\soldier\arrival::chooseanim_arrival;
  anim.asmfuncs["civilian"][19] = &scripts\asm\soldier\arrival::finisharrival;
  anim.asmfuncs["civilian"][20] = &scripts\asm\civilian\script_funcs::civilian_loopidleanim;
  anim.asmfuncs["civilian"][21] = &scripts\asm\shared\utility::loopanim;
  anim.asmfuncs["civilian"][22] = &scripts\asm\civilian\script_funcs::chooseciviliantransitiontoidleanim;
  anim.asmfuncs["civilian"][23] = &scripts\asm\civilian\script_funcs::civilian_playexposedloop;
  anim.asmfuncs["civilian"][24] = &scripts\asm\soldier\move::chooseanim_exit;
  anim.asmfuncs["civilian"][25] = &scripts\asm\gesture::playcoveranim_gesture;
  anim.asmfuncs["civilian"][26] = &scripts\asm\gesture::chooseanim_gesture;
  anim.asmfuncs["civilian"][27] = &scripts\asm\gesture::cleargestureanim;
  anim.asmfuncs["civilian"][28] = &scripts\asm\traverse::calctraversetype;
  anim.asmfuncs["civilian"][29] = &scripts\asm\soldier\traverse::playtraverseanim_ladder;
  anim.asmfuncs["civilian"][30] = &scripts\asm\soldier\sp\script_funcs::forwardpushevent;
  anim.asmfuncs["civilian"][31] = &scripts\asm\civilian\script_funcs::civilian_chooseanim_playerpushed;
  anim.asmfuncs["civilian"][32] = &scripts\asm\traverse::traverse_cleanup;
  anim.asmfuncs["civilian"][33] = &scripts\asm\traverse::playtraversearrivalanim;
  anim.asmfuncs["civilian"][34] = &scripts\asm\traverse::traversechooseanim;
  anim.asmfuncs["civilian"][35] = &scripts\asm\traverse::playtraverseanim_scaled;
  anim.asmfuncs["civilian"][36] = &scripts\asm\shared\utility::animscriptedstartup;
  anim.asmfuncs["civilian"][37] = &scripts\asm\shared\utility::animscriptedcleanup;
  anim.asmfuncs["civilian"][38] = &scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["civilian"][39] = &scripts\asm\shared\utility::animsriptedactioncivilian_terminate;
  anim.asmfuncs["civilian"][40] = &scripts\asm\soldier\arrival::shouldconsiderarrivalaftercodemove;
  anim.asmfuncs["civilian"][41] = &autogenfunc_0;
  anim.asmfuncs["civilian"][42] = &autogenfunc_1;
  anim.asmfuncs["civilian"][43] = &autogenfunc_2;
  anim.asmfuncs["civilian"][44] = &scripts\asm\civilian\script_funcs::civilianstateis;
  anim.asmfuncs["civilian"][45] = &scripts\asm\civilian\script_funcs::iswhizbydetected;
  anim.asmfuncs["civilian"][46] = &scripts\asm\shared\utility::shouldleaveanimscripted;
  anim.asmfuncs["civilian"][47] = &scripts\asm\soldier\move::shoulddosharpturn;
  anim.asmfuncs["civilian"][48] = &scripts\asm\soldier\arrival::shouldconsiderarrival;
  anim.asmfuncs["civilian"][49] = &scripts\asm\soldier\arrival::shouldstartarrivalpassthroughcivilian;
  anim.asmfuncs["civilian"][50] = &scripts\asm\civilian\script_funcs::civarrival_finishearly;
  anim.asmfuncs["civilian"][51] = &scripts\asm\civilian\script_funcs::civilianstateisnot;
  anim.asmfuncs["civilian"][52] = &scripts\asm\civilian\script_funcs::shouldcustomtransition;
  anim.asmfuncs["civilian"][53] = &autogenfunc_3;
  anim.asmfuncs["civilian"][54] = &scripts\asm\civilian\script_funcs::shoulddirectlytransition;
  anim.asmfuncs["civilian"][55] = &autogenfunc_4;
  anim.asmfuncs["civilian"][56] = &scripts\asm\civilian\script_funcs::civmoverequested;
  anim.asmfuncs["civilian"][57] = &scripts\asm\asm_bb::bb_canplaygesture;
  anim.asmfuncs["civilian"][58] = &scripts\asm\gesture::gesture_finishearly;
  anim.asmfuncs["civilian"][59] = &scripts\asm\traverse::shouldconsidertraversearrival;
  anim.asmfuncs["civilian"][60] = &scripts\asm\traverse::shouldstarttraverse;
  anim.asmfuncs["civilian"][61] = &scripts\asm\traverse::setuptraversaltransitioncheck;
  anim.asmfuncs["civilian"][62] = &scripts\asm\civilian\script_funcs::checkarrivaltypecivilian;
  anim.asmfuncs["civilian"][63] = &autogenfunc_5;
  anim.asmfuncs["civilian"][64] = &scripts\asm\civilian\script_funcs::currentsnaptonodeis;
  anim.asmfuncs["civilian"][65] = &scripts\asm\soldier\sp\script_funcs::shouldplaypushedanim;
  anim.asmfuncs["civilian"][66] = &scripts\asm\soldier\move::determinecurrentstairsstate;
  anim.asmfuncs["civilian"][67] = &scripts\asm\traverse::shoulddotraversalarrival;
  anim.asmfuncs["civilian"][68] = &autogenfunc_6;
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