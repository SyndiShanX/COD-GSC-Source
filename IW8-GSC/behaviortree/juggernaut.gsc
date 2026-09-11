/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\juggernaut.gsc
***********************************************/

function bindactionscripts() {
  if(isDefined(level._btactions["juggernaut"])) {
    return;
  }

  var0 = spawnStruct();
  var0.actionfn = [];
  var0.actionfn[0] = &scripts\aitypes\combat::updateeveryframe_global;
  var0.actionfn[1] = &scripts\aitypes\vehicle::getbsmstate;
  var0.actionfn[2] = &scripts\aitypes\vehicle::movetovehicle;
  var0.actionfn[3] = &scripts\aitypes\vehicle::movetovehicle_init;
  var0.actionfn[4] = &scripts\aitypes\vehicle::movetovehicle_terminate;
  var0.actionfn[5] = &scripts\aitypes\vehicle::entervehicle;
  var0.actionfn[6] = &scripts\aitypes\combat::mayshoot;
  var0.actionfn[7] = &scripts\aitypes\combat::shoot_update;
  var0.actionfn[8] = &scripts\aitypes\combat::shoot_init;
  var0.actionfn[9] = &scripts\aitypes\combat::shoot_terminate;
  var0.actionfn[10] = &scripts\aitypes\vehicle::exitvehicle;
  var0.actionfn[11] = &scripts\aitypes\vehicle::vehiclecanshoot;
  var0.actionfn[12] = &scripts\aitypes\vehicle::vehicleidle;
  var0.actionfn[13] = &scripts\aitypes\combat::badplaceavoid;
  var0.actionfn[14] = &scripts\aitypes\combat::waituntilnotinbadplace;
  var0.actionfn[15] = &scripts\aitypes\combat::badplaceterminate;
  var0.actionfn[16] = &scripts\aitypes\stealth::ifinstealth;
  var0.actionfn[17] = &scripts\aitypes\stealth::stealth_shouldfriendly;
  var0.actionfn[18] = &scripts\aitypes\stealth::stealth_initfriendly;
  var0.actionfn[19] = &scripts\aitypes\stealth::stealth_shouldneutral;
  var0.actionfn[20] = &scripts\aitypes\stealth::stealth_initneutral;
  var0.actionfn[21] = &scripts\aitypes\stealth::stealth_neutral_updateeveryframe;
  var0.actionfn[22] = &scripts\aitypes\stealth::stealth_enemy_updateeveryframe;
  var0.actionfn[23] = &scripts\aitypes\stealth::stealth_enemy_getbsmstate;
  var0.actionfn[24] = &scripts\aitypes\stealth::stealth_shouldhunt;
  var0.actionfn[25] = &scripts\aitypes\stealth::hunt_shouldhunker;
  var0.actionfn[26] = &scripts\aitypes\stealth::hunt_initialdelay;
  var0.actionfn[27] = &scripts\aitypes\stealth::hunt_initialdelay_init;
  var0.actionfn[28] = &scripts\aitypes\stealth::hunt_initialdelay_terminate;
  var0.actionfn[29] = &scripts\aitypes\stealth::hunt_hunker;
  var0.actionfn[30] = &scripts\aitypes\stealth::hunt_hunker_init;
  var0.actionfn[31] = &scripts\aitypes\stealth::hunt_hunker_terminate;
  var0.actionfn[32] = &scripts\aitypes\stealth::hunt_isincover;
  var0.actionfn[33] = &scripts\aitypes\cover::initcover;
  var0.actionfn[34] = &scripts\aitypes\cover::shouldlookorpeek;
  var0.actionfn[35] = &scripts\aitypes\cover::coverlook;
  var0.actionfn[36] = &scripts\aitypes\cover::initlook;
  var0.actionfn[37] = &scripts\aitypes\cover::terminatelook;
  var0.actionfn[38] = &scripts\aitypes\cover::coverpeek;
  var0.actionfn[39] = &scripts\aitypes\cover::terminatepeek;
  var0.actionfn[40] = &scripts\aitypes\stealth::hunt_hunker_shouldexpose;
  var0.actionfn[41] = &scripts\aitypes\stealth::hunt_hunker_expose;
  var0.actionfn[42] = &scripts\aitypes\stealth::hunt_hunker_expose_init;
  var0.actionfn[43] = &scripts\aitypes\stealth::hunt_hunker_expose_terminate;
  var0.actionfn[44] = &scripts\aitypes\cover::coverhide;
  var0.actionfn[45] = &scripts\aitypes\cover::inithide;
  var0.actionfn[46] = &scripts\aitypes\cover::initcoverbb;
  var0.actionfn[47] = &scripts\aitypes\cover::clearcoverbb;
  var0.actionfn[48] = &scripts\aitypes\combat::ifshoulddosmartobject;
  var0.actionfn[49] = &scripts\aitypes\combat::dosmartobject;
  var0.actionfn[50] = &scripts\aitypes\combat::dosmartobject_init;
  var0.actionfn[51] = &scripts\aitypes\combat::dosmartobjectterminate;
  var0.actionfn[52] = &scripts\aitypes\stealth::hunt_lookaround;
  var0.actionfn[53] = &scripts\aitypes\stealth::hunt_lookaround_init;
  var0.actionfn[54] = &scripts\aitypes\stealth::hunt_lookaround_terminate;
  var0.actionfn[55] = &scripts\aitypes\stealth::hunt_move;
  var0.actionfn[56] = &scripts\aitypes\stealth::hunt_move_init;
  var0.actionfn[57] = &scripts\aitypes\stealth::hunt_move_terminate;
  var0.actionfn[58] = &scripts\aitypes\stealth::hunt_active_terminate;
  var0.actionfn[59] = &scripts\aitypes\stealth::stealth_shouldinvestigate;
  var0.actionfn[60] = &scripts\aitypes\stealth::investigate_updateeveryframe;
  var0.actionfn[61] = &scripts\aitypes\stealth::investigate_lookaround;
  var0.actionfn[62] = &scripts\aitypes\stealth::investigate_lookaround_init;
  var0.actionfn[63] = &scripts\aitypes\stealth::investigate_lookaround_terminate;
  var0.actionfn[64] = &scripts\aitypes\stealth::investigate_targetedlookaround;
  var0.actionfn[65] = &scripts\aitypes\stealth::investigate_move;
  var0.actionfn[66] = &scripts\aitypes\stealth::investigate_move_init;
  var0.actionfn[67] = &scripts\aitypes\stealth::investigate_move_terminate;
  var0.actionfn[68] = &scripts\aitypes\stealth::idle_update;
  var0.actionfn[69] = &scripts\aitypes\stealth::idle_init;
  var0.actionfn[70] = &scripts\aitypes\stealth::idle_terminate;
  var0.actionfn[71] = &scripts\aitypes\juggernaut\behaviors::juggernaut_lookforplayers;
  var0.actionfn[72] = &scripts\aitypes\combat::updatesniperglint;
  var0.actionfn[73] = &scripts\aitypes\weapon::updateweapon;
  var0.actionfn[74] = &scripts\aitypes\cover::updateexposedatnodestate;
  var0.actionfn[75] = &scripts\aitypes\juggernaut\behaviors::juggernaut_updatestance;
  var0.actionfn[76] = &scripts\aitypes\melee::shouldmelee;
  var0.actionfn[77] = &scripts\aitypes\melee::melee_init;
  var0.actionfn[78] = &scripts\aitypes\melee::meleecharge_update;
  var0.actionfn[79] = &scripts\aitypes\melee::meleecharge_init;
  var0.actionfn[80] = &scripts\aitypes\melee::meleecharge_terminate;
  var0.actionfn[81] = &scripts\aitypes\melee::domeleeaction;
  var0.actionfn[82] = &scripts\aitypes\melee::initmeleeaction;
  var0.actionfn[83] = &scripts\aitypes\melee::clearmeleeaction;
  var0.actionfn[84] = &scripts\aitypes\throwgrenade::hasgrenadetimerelapsed;
  var0.actionfn[85] = &scripts\aitypes\throwgrenade::canthrowgrenade;
  var0.actionfn[86] = &scripts\aitypes\throwgrenade::throwgrenade_update;
  var0.actionfn[87] = &scripts\aitypes\throwgrenade::throwgrenade_init;
  var0.actionfn[88] = &scripts\aitypes\throwgrenade::throwgrenade_terminate;
  var0.actionfn[89] = &scripts\aitypes\juggernaut\behaviors::juggernaut_shouldmove;
  var0.actionfn[90] = &scripts\aitypes\juggernaut\behaviors::juggernaut_move;
  var0.actionfn[91] = &scripts\aitypes\juggernaut\behaviors::juggernaut_moveinit;
  var0.actionfn[92] = &scripts\aitypes\juggernaut\behaviors::juggernaut_moveterminate;
  var0.actionfn[93] = &scripts\aitypes\juggernaut\behaviors::juggernaut_updateeveryframe_noncombat;
  var0.actionfn[94] = &scripts\aitypes\combat_sp::soldier_init;
  var0.actionfn[95] = &scripts\aitypes\melee_sp::initmeleefunctions;
  var0.actionfn[96] = &scripts\aitypes\combat_sp::initcombatfunctions;
  var0.actionfn[97] = &scripts\aitypes\juggernaut\behaviors::juggernaut_init;
  level._btactions["juggernaut"] = var0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("juggernaut");
}