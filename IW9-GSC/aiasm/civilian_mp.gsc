/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: aiasm\civilian_mp.gsc
***********************************************/

asm_register() {
  if(!isDefined(anim.asmfuncs))
    anim.asmfuncs = [];

  if(isDefined(anim.asmfuncs["civilian"])) {
    return;
  }
  anim.asmfuncs["civilian"] = [];
  anim.asmfuncs["civilian"][0] = scripts\asm\civilian\script_funcs::civilian_init;
  anim.asmfuncs["civilian"][1] = scripts\asm\soldier\death::playdeathanim;
  anim.asmfuncs["civilian"][2] = scripts\asm\soldier\death::choosedirectionaldeathanim;
  anim.asmfuncs["civilian"][3] = scripts\asm\soldier\death::choosedirectionalcrouchdeathanim;
  anim.asmfuncs["civilian"][4] = scripts\asm\soldier\death::choosemovingdeathanim;
  anim.asmfuncs["civilian"][5] = scripts\asm\civilian\script_funcs::civilian_playsharpturnanim;
  anim.asmfuncs["civilian"][6] = scripts\asm\civilian\script_funcs::civilian_move_cleanup;
  anim.asmfuncs["civilian"][7] = scripts\asm\civilian\script_funcs::civilian_exit_cleanup;
  anim.asmfuncs["civilian"][8] = scripts\asm\civilian\script_funcs::choosecivilianreactidleanim;
  anim.asmfuncs["civilian"][9] = scripts\asm\civilian\script_funcs::cleanupcivilianreactionalias;
  anim.asmfuncs["civilian"][10] = scripts\asm\civilian\script_funcs::civilian_playmoveloopblendspace;
  anim.asmfuncs["civilian"][11] = scripts\asm\shared\utility::loopanim;
  anim.asmfuncs["civilian"][12] = scripts\asm\civilian\script_funcs::chooseciviliantransitiontoidleanim;
  anim.asmfuncs["civilian"][13] = scripts\asm\civilian\script_funcs::civilian_playexposedloop;
  anim.asmfuncs["civilian"][14] = scripts\asm\gesture::playcoveranim_gesture;
  anim.asmfuncs["civilian"][15] = scripts\asm\gesture::chooseanim_gesture;
  anim.asmfuncs["civilian"][16] = scripts\asm\gesture::cleargestureanim;
  anim.asmfuncs["civilian"][17] = scripts\asm\traverse::calctraversetype;
  anim.asmfuncs["civilian"][18] = scripts\asm\soldier\traverse::playtraverseanim_ladder;
  anim.asmfuncs["civilian"][19] = scripts\asm\soldier\mp\script_funcs::forwardpushevent;
  anim.asmfuncs["civilian"][20] = scripts\asm\civilian\script_funcs::civilian_chooseanim_playerpushed;
  anim.asmfuncs["civilian"][21] = scripts\asm\civilian\script_funcs::civilian_playmoveloop;
  anim.asmfuncs["civilian"][22] = scripts\asm\traverse::traverse_cleanup;
  anim.asmfuncs["civilian"][23] = scripts\asm\traverse::playtraversearrivalanim;
  anim.asmfuncs["civilian"][24] = scripts\asm\traverse::traversechooseanim;
  anim.asmfuncs["civilian"][25] = scripts\asm\traverse::playtraverseanim_scaled;
  anim.asmfuncs["civilian"][26] = scripts\asm\shared\utility::animscriptedstartup;
  anim.asmfuncs["civilian"][27] = scripts\asm\shared\utility::animscriptedcleanup;
  anim.asmfuncs["civilian"][28] = scripts\asm\shared\utility::animscriptedaction;
  anim.asmfuncs["civilian"][29] = scripts\asm\shared\utility::animsriptedactioncivilian_terminate;
  anim.asmfuncs["civilian"][30] = scripts\asm\civilian\script_funcs::_id_D13115C5F7B949E6;
  anim.asmfuncs["civilian"][31] = scripts\asm\civilian\script_funcs::_id_AE83A6295A6675C8;
  anim.asmfuncs["civilian"][32] = scripts\asm\civilian\script_funcs::_id_D98F49AEB63EDCE4;
  anim.asmfuncs["civilian"][33] = scripts\asm\civilian\script_funcs::_id_C4D5A733F656507F;
  anim.asmfuncs["civilian"][34] = scripts\asm\civilian\script_funcs::_id_28D7E9D4C9615969;
  anim.asmfuncs["civilian"][35] = scripts\asm\civilian\script_funcs::_id_8582E56563261E62;
  anim.asmfuncs["civilian"][36] = ::autogenfunc_0;
  anim.asmfuncs["civilian"][37] = ::autogenfunc_1;
  anim.asmfuncs["civilian"][38] = ::autogenfunc_2;
  anim.asmfuncs["civilian"][39] = scripts\asm\civilian\script_funcs::iswhizbydetected;
  anim.asmfuncs["civilian"][40] = scripts\asm\shared\utility::shouldleaveanimscripted;
  anim.asmfuncs["civilian"][41] = scripts\asm\civilian\script_funcs::shouldcustomtransition;
  anim.asmfuncs["civilian"][42] = ::autogenfunc_3;
  anim.asmfuncs["civilian"][43] = scripts\asm\civilian\script_funcs::shoulddirectlytransition;
  anim.asmfuncs["civilian"][44] = ::autogenfunc_4;
  anim.asmfuncs["civilian"][45] = scripts\asm\civilian\script_funcs::civmoverequested;
  anim.asmfuncs["civilian"][46] = scripts\asm\asm_bb::bb_canplaygesture;
  anim.asmfuncs["civilian"][47] = scripts\asm\gesture::gesture_finishearly;
  anim.asmfuncs["civilian"][48] = ::autogenfunc_5;
  anim.asmfuncs["civilian"][49] = scripts\asm\civilian\script_funcs::_id_C41DE664204E9824;
  anim.asmfuncs["civilian"][50] = scripts\asm\civilian\script_funcs::_id_B1BBE0DC316F2EFA;
  anim.asmfuncs["civilian"][51] = scripts\asm\civilian\script_funcs::_id_7490810D9786CC51;
  anim.asmfuncs["civilian"][52] = scripts\asm\civilian\script_funcs::_id_7BD81EFB0ABDBC44;
  anim.asmfuncs["civilian"][53] = scripts\asm\civilian\script_funcs::_id_0E481D310D5CB87C;
  anim.asmfuncs["civilian"][54] = scripts\asm\civilian\script_funcs::_id_4BE295E4306DC70C;
  anim.asmfuncs["civilian"][55] = ::autogenfunc_6;
}

autogenfunc_0(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self.pathgoalpos);
}

autogenfunc_1(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return isDefined(self.disableexits) && self.disableexits;
}

autogenfunc_2(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return !scripts\asm\asm_bb::bb_iswhizbyrequested();
}

autogenfunc_3(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_getcivilianstate() != "combat" && scripts\asm\asm_bb::bb_getcivilianstate() != "noncombat";
}

autogenfunc_4(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return scripts\asm\asm_bb::bb_getcivilianstate() != "stealth" && scripts\asm\asm_bb::bb_getcivilianstate() != "panic" && scripts\asm\asm_bb::bb_getcivilianstate() != "cctv" && scripts\asm\asm_bb::bb_getcivilianstate() != "relaxed";
}

autogenfunc_5(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return istrue(self.disableexits);
}

autogenfunc_6(asmname) {
  scripts\asm\gesture::gesture(asmname);
}