/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\civilian.gsc
***********************************************/

function bindactionscripts() {
  if(isDefined(level._btactions["civilian"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.actionfn = [];
  var_0.actionfn[0] = &scripts\aitypes\human\civilian_logic::updateeveryframe_civ_global;
  var_0.actionfn[1] = &scripts\aitypes\stealth::ifinstealth;
  var_0.actionfn[2] = &scripts\aitypes\stealth::stealth_shouldfriendly;
  var_0.actionfn[3] = &scripts\aitypes\stealth::stealth_initfriendly;
  var_0.actionfn[4] = &scripts\aitypes\stealth::stealth_shouldneutral;
  var_0.actionfn[5] = &scripts\aitypes\stealth::stealth_initneutral;
  var_0.actionfn[6] = &scripts\aitypes\stealth::stealth_neutral_updateeveryframe;
  var_0.actionfn[7] = &scripts\aitypes\stealth::stealth_enemy_updateeveryframe;
  var_0.actionfn[8] = &scripts\aitypes\stealth::stealth_enemy_getbsmstate;
  var_0.actionfn[9] = &scripts\aitypes\stealth::stealth_shouldhunt;
  var_0.actionfn[10] = &scripts\aitypes\stealth::hunt_shouldhunker;
  var_0.actionfn[11] = &scripts\aitypes\stealth::hunt_initialdelay;
  var_0.actionfn[12] = &scripts\aitypes\stealth::hunt_initialdelay_init;
  var_0.actionfn[13] = &scripts\aitypes\stealth::hunt_initialdelay_terminate;
  var_0.actionfn[14] = &scripts\aitypes\stealth::hunt_hunker;
  var_0.actionfn[15] = &scripts\aitypes\stealth::hunt_hunker_init;
  var_0.actionfn[16] = &scripts\aitypes\stealth::hunt_hunker_terminate;
  var_0.actionfn[17] = &scripts\aitypes\stealth::hunt_isincover;
  var_0.actionfn[18] = &scripts\aitypes\cover::initcover;
  var_0.actionfn[19] = &scripts\aitypes\cover::shouldlookorpeek;
  var_0.actionfn[20] = &scripts\aitypes\cover::coverlook;
  var_0.actionfn[21] = &scripts\aitypes\cover::initlook;
  var_0.actionfn[22] = &scripts\aitypes\cover::terminatelook;
  var_0.actionfn[23] = &scripts\aitypes\cover::coverpeek;
  var_0.actionfn[24] = &scripts\aitypes\cover::terminatepeek;
  var_0.actionfn[25] = &scripts\aitypes\stealth::hunt_hunker_shouldexpose;
  var_0.actionfn[26] = &scripts\aitypes\stealth::hunt_hunker_expose;
  var_0.actionfn[27] = &scripts\aitypes\stealth::hunt_hunker_expose_init;
  var_0.actionfn[28] = &scripts\aitypes\stealth::hunt_hunker_expose_terminate;
  var_0.actionfn[29] = &scripts\aitypes\cover::coverhide;
  var_0.actionfn[30] = &scripts\aitypes\cover::inithide;
  var_0.actionfn[31] = &scripts\aitypes\cover::initcoverbb;
  var_0.actionfn[32] = &scripts\aitypes\cover::clearcoverbb;
  var_0.actionfn[33] = &scripts\aitypes\combat::ifshoulddosmartobject;
  var_0.actionfn[34] = &scripts\aitypes\combat::dosmartobject;
  var_0.actionfn[35] = &scripts\aitypes\combat::dosmartobject_init;
  var_0.actionfn[36] = &scripts\aitypes\combat::dosmartobjectterminate;
  var_0.actionfn[37] = &scripts\aitypes\stealth::hunt_lookaround;
  var_0.actionfn[38] = &scripts\aitypes\stealth::hunt_lookaround_init;
  var_0.actionfn[39] = &scripts\aitypes\stealth::hunt_lookaround_terminate;
  var_0.actionfn[40] = &scripts\aitypes\stealth::hunt_move;
  var_0.actionfn[41] = &scripts\aitypes\stealth::hunt_move_init;
  var_0.actionfn[42] = &scripts\aitypes\stealth::hunt_move_terminate;
  var_0.actionfn[43] = &scripts\aitypes\stealth::hunt_active_terminate;
  var_0.actionfn[44] = &scripts\aitypes\stealth::stealth_shouldinvestigate;
  var_0.actionfn[45] = &scripts\aitypes\stealth::investigate_updateeveryframe;
  var_0.actionfn[46] = &scripts\aitypes\stealth::investigate_lookaround;
  var_0.actionfn[47] = &scripts\aitypes\stealth::investigate_lookaround_init;
  var_0.actionfn[48] = &scripts\aitypes\stealth::investigate_lookaround_terminate;
  var_0.actionfn[49] = &scripts\aitypes\stealth::investigate_targetedlookaround;
  var_0.actionfn[50] = &scripts\aitypes\stealth::investigate_move;
  var_0.actionfn[51] = &scripts\aitypes\stealth::investigate_move_init;
  var_0.actionfn[52] = &scripts\aitypes\stealth::investigate_move_terminate;
  var_0.actionfn[53] = &scripts\aitypes\stealth::idle_update;
  var_0.actionfn[54] = &scripts\aitypes\stealth::idle_init;
  var_0.actionfn[55] = &scripts\aitypes\stealth::idle_terminate;
  var_0.actionfn[56] = &scripts\aitypes\human\civilian_logic::updateeveryframe_civ_default;
  var_0.actionfn[57] = &scripts\aitypes\human\civilian_logic::isincover;
  var_0.actionfn[58] = &scripts\aitypes\human\civilian_logic::clearcover;
  var_0.actionfn[59] = &scripts\aitypes\human\civilian_logic::initcivilian;
  level._btactions["civilian"] = var_0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("civilian");
}