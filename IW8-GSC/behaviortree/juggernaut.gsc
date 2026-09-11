/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\juggernaut.gsc
***********************************************/

function bindactionscripts() {
  if(isDefined(level._btactions["juggernaut"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.actionfn = [];
  var_0.actionfn[0] = &scripts\aitypes\combat::updateeveryframe_global;
  var_0.actionfn[1] = &scripts\aitypes\vehicle::getbsmstate;
  var_0.actionfn[2] = &scripts\aitypes\vehicle::movetovehicle;
  var_0.actionfn[3] = &scripts\aitypes\vehicle::movetovehicle_init;
  var_0.actionfn[4] = &scripts\aitypes\vehicle::movetovehicle_terminate;
  var_0.actionfn[5] = &scripts\aitypes\vehicle::entervehicle;
  var_0.actionfn[6] = &scripts\aitypes\combat::mayshoot;
  var_0.actionfn[7] = &scripts\aitypes\combat::shoot_update;
  var_0.actionfn[8] = &scripts\aitypes\combat::shoot_init;
  var_0.actionfn[9] = &scripts\aitypes\combat::shoot_terminate;
  var_0.actionfn[10] = &scripts\aitypes\vehicle::exitvehicle;
  var_0.actionfn[11] = &scripts\aitypes\vehicle::vehiclecanshoot;
  var_0.actionfn[12] = &scripts\aitypes\vehicle::vehicleidle;
  var_0.actionfn[13] = &scripts\aitypes\combat::badplaceavoid;
  var_0.actionfn[14] = &scripts\aitypes\combat::waituntilnotinbadplace;
  var_0.actionfn[15] = &scripts\aitypes\combat::badplaceterminate;
  var_0.actionfn[16] = &scripts\aitypes\stealth::ifinstealth;
  var_0.actionfn[17] = &scripts\aitypes\stealth::stealth_shouldfriendly;
  var_0.actionfn[18] = &scripts\aitypes\stealth::stealth_initfriendly;
  var_0.actionfn[19] = &scripts\aitypes\stealth::stealth_shouldneutral;
  var_0.actionfn[20] = &scripts\aitypes\stealth::stealth_initneutral;
  var_0.actionfn[21] = &scripts\aitypes\stealth::stealth_neutral_updateeveryframe;
  var_0.actionfn[22] = &scripts\aitypes\stealth::stealth_enemy_updateeveryframe;
  var_0.actionfn[23] = &scripts\aitypes\stealth::stealth_enemy_getbsmstate;
  var_0.actionfn[24] = &scripts\aitypes\stealth::stealth_shouldhunt;
  var_0.actionfn[25] = &scripts\aitypes\stealth::hunt_shouldhunker;
  var_0.actionfn[26] = &scripts\aitypes\stealth::hunt_initialdelay;
  var_0.actionfn[27] = &scripts\aitypes\stealth::hunt_initialdelay_init;
  var_0.actionfn[28] = &scripts\aitypes\stealth::hunt_initialdelay_terminate;
  var_0.actionfn[29] = &scripts\aitypes\stealth::hunt_hunker;
  var_0.actionfn[30] = &scripts\aitypes\stealth::hunt_hunker_init;
  var_0.actionfn[31] = &scripts\aitypes\stealth::hunt_hunker_terminate;
  var_0.actionfn[32] = &scripts\aitypes\stealth::hunt_isincover;
  var_0.actionfn[33] = &scripts\aitypes\cover::initcover;
  var_0.actionfn[34] = &scripts\aitypes\cover::shouldlookorpeek;
  var_0.actionfn[35] = &scripts\aitypes\cover::coverlook;
  var_0.actionfn[36] = &scripts\aitypes\cover::initlook;
  var_0.actionfn[37] = &scripts\aitypes\cover::terminatelook;
  var_0.actionfn[38] = &scripts\aitypes\cover::coverpeek;
  var_0.actionfn[39] = &scripts\aitypes\cover::terminatepeek;
  var_0.actionfn[40] = &scripts\aitypes\stealth::hunt_hunker_shouldexpose;
  var_0.actionfn[41] = &scripts\aitypes\stealth::hunt_hunker_expose;
  var_0.actionfn[42] = &scripts\aitypes\stealth::hunt_hunker_expose_init;
  var_0.actionfn[43] = &scripts\aitypes\stealth::hunt_hunker_expose_terminate;
  var_0.actionfn[44] = &scripts\aitypes\cover::coverhide;
  var_0.actionfn[45] = &scripts\aitypes\cover::inithide;
  var_0.actionfn[46] = &scripts\aitypes\cover::initcoverbb;
  var_0.actionfn[47] = &scripts\aitypes\cover::clearcoverbb;
  var_0.actionfn[48] = &scripts\aitypes\combat::ifshoulddosmartobject;
  var_0.actionfn[49] = &scripts\aitypes\combat::dosmartobject;
  var_0.actionfn[50] = &scripts\aitypes\combat::dosmartobject_init;
  var_0.actionfn[51] = &scripts\aitypes\combat::dosmartobjectterminate;
  var_0.actionfn[52] = &scripts\aitypes\stealth::hunt_lookaround;
  var_0.actionfn[53] = &scripts\aitypes\stealth::hunt_lookaround_init;
  var_0.actionfn[54] = &scripts\aitypes\stealth::hunt_lookaround_terminate;
  var_0.actionfn[55] = &scripts\aitypes\stealth::hunt_move;
  var_0.actionfn[56] = &scripts\aitypes\stealth::hunt_move_init;
  var_0.actionfn[57] = &scripts\aitypes\stealth::hunt_move_terminate;
  var_0.actionfn[58] = &scripts\aitypes\stealth::hunt_active_terminate;
  var_0.actionfn[59] = &scripts\aitypes\stealth::stealth_shouldinvestigate;
  var_0.actionfn[60] = &scripts\aitypes\stealth::investigate_updateeveryframe;
  var_0.actionfn[61] = &scripts\aitypes\stealth::investigate_lookaround;
  var_0.actionfn[62] = &scripts\aitypes\stealth::investigate_lookaround_init;
  var_0.actionfn[63] = &scripts\aitypes\stealth::investigate_lookaround_terminate;
  var_0.actionfn[64] = &scripts\aitypes\stealth::investigate_targetedlookaround;
  var_0.actionfn[65] = &scripts\aitypes\stealth::investigate_move;
  var_0.actionfn[66] = &scripts\aitypes\stealth::investigate_move_init;
  var_0.actionfn[67] = &scripts\aitypes\stealth::investigate_move_terminate;
  var_0.actionfn[68] = &scripts\aitypes\stealth::idle_update;
  var_0.actionfn[69] = &scripts\aitypes\stealth::idle_init;
  var_0.actionfn[70] = &scripts\aitypes\stealth::idle_terminate;
  var_0.actionfn[71] = &scripts\aitypes\juggernaut\behaviors::juggernaut_lookforplayers;
  var_0.actionfn[72] = &scripts\aitypes\combat::updatesniperglint;
  var_0.actionfn[73] = &scripts\aitypes\weapon::updateweapon;
  var_0.actionfn[74] = &scripts\aitypes\cover::updateexposedatnodestate;
  var_0.actionfn[75] = &scripts\aitypes\juggernaut\behaviors::juggernaut_updatestance;
  var_0.actionfn[76] = &scripts\aitypes\melee::shouldmelee;
  var_0.actionfn[77] = &scripts\aitypes\melee::melee_init;
  var_0.actionfn[78] = &scripts\aitypes\melee::meleecharge_update;
  var_0.actionfn[79] = &scripts\aitypes\melee::meleecharge_init;
  var_0.actionfn[80] = &scripts\aitypes\melee::meleecharge_terminate;
  var_0.actionfn[81] = &scripts\aitypes\melee::domeleeaction;
  var_0.actionfn[82] = &scripts\aitypes\melee::initmeleeaction;
  var_0.actionfn[83] = &scripts\aitypes\melee::clearmeleeaction;
  var_0.actionfn[84] = &scripts\aitypes\throwgrenade::hasgrenadetimerelapsed;
  var_0.actionfn[85] = &scripts\aitypes\throwgrenade::canthrowgrenade;
  var_0.actionfn[86] = &scripts\aitypes\throwgrenade::throwgrenade_update;
  var_0.actionfn[87] = &scripts\aitypes\throwgrenade::throwgrenade_init;
  var_0.actionfn[88] = &scripts\aitypes\throwgrenade::throwgrenade_terminate;
  var_0.actionfn[89] = &scripts\aitypes\juggernaut\behaviors::juggernaut_shouldmove;
  var_0.actionfn[90] = &scripts\aitypes\juggernaut\behaviors::juggernaut_move;
  var_0.actionfn[91] = &scripts\aitypes\juggernaut\behaviors::juggernaut_moveinit;
  var_0.actionfn[92] = &scripts\aitypes\juggernaut\behaviors::juggernaut_moveterminate;
  var_0.actionfn[93] = &scripts\aitypes\juggernaut\behaviors::juggernaut_updateeveryframe_noncombat;
  var_0.actionfn[94] = &scripts\aitypes\combat_sp::soldier_init;
  var_0.actionfn[95] = &scripts\aitypes\melee_sp::initmeleefunctions;
  var_0.actionfn[96] = &scripts\aitypes\combat_sp::initcombatfunctions;
  var_0.actionfn[97] = &scripts\aitypes\juggernaut\behaviors::juggernaut_init;
  level._btactions["juggernaut"] = var_0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("juggernaut");
}