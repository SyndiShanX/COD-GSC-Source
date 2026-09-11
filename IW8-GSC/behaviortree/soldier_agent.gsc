/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\soldier_agent.gsc
***********************************************/

function soldier_agentfn0(var0) {
  return 0.3;
}

function soldier_agentfn1(var0) {
  return true;
}

function soldier_agentfn2(var0) {
  return false;
}

function soldier_agentfn3(var0) {
  return scripts\aitypes\common::returnsuccessiftrue(var0, isDefined(self.a.atconcealmentnode) && self.a.atconcealmentnode && scripts\anim\utility_common::canseeenemy());
}

function soldier_agentfn4(var0) {
  return scripts\aitypes\common::returnsuccessiftrue(var0, scripts\anim\utility_common::cansuppressenemyfromexposed());
}

function soldier_agentfn5(var0) {
  return scripts\aitypes\common::isvariabledefined(var0, anim.throwgrenadeatplayerasap);
}

function soldier_agentfn6(var0) {
  return level.player;
}

function soldier_agentfn7(var0) {
  return 0.1;
}

function soldier_agentfn8(var0) {
  return scripts\aitypes\common::returnsuccessiftrue(var0, istrue(self.aggressivemode) || scripts\anim\utility_common::enemyishiding());
}

function soldier_agentfn9(var0) {
  return scripts\aitypes\combat::reacquire_step(var0, 96);
}

function bindactionscripts() {
  if(isDefined(level._btactions["soldier_agent"])) {
    return;
  }

  var0 = spawnStruct();
  var0.actionfn = [];
  var0.actionfn[0] = &scripts\aitypes\combat::updateeveryframe_global;
  var0.actionfn[1] = &scripts\aitypes\squad_movement::shouldupdatesquadleadermovement;
  var0.actionfn[2] = &scripts\aitypes\squad_movement::updatesquadleadermovement;
  var0.actionfn[3] = &scripts\aitypes\vehicle::getbsmstate;
  var0.actionfn[4] = &scripts\aitypes\vehicle::movetovehicle;
  var0.actionfn[5] = &scripts\aitypes\vehicle::movetovehicle_init;
  var0.actionfn[6] = &scripts\aitypes\vehicle::movetovehicle_terminate;
  var0.actionfn[7] = &scripts\aitypes\vehicle::entervehicle;
  var0.actionfn[8] = &scripts\aitypes\combat::mayshoot;
  var0.actionfn[9] = &scripts\aitypes\combat::shoot_update;
  var0.actionfn[10] = &scripts\aitypes\combat::shoot_init;
  var0.actionfn[11] = &scripts\aitypes\combat::shoot_terminate;
  var0.actionfn[12] = &scripts\aitypes\vehicle::exitvehicle;
  var0.actionfn[13] = &scripts\aitypes\vehicle::vehiclecanshoot;
  var0.actionfn[14] = &scripts\aitypes\vehicle::vehicleidle;
  var0.actionfn[15] = &scripts\aitypes\combat::badplaceavoid;
  var0.actionfn[16] = &scripts\aitypes\combat::waituntilnotinbadplace;
  var0.actionfn[17] = &scripts\aitypes\combat::badplaceterminate;
  var0.actionfn[18] = &scripts\aitypes\grenade_response::cangrenaderespond;
  var0.actionfn[19] = &scripts\aitypes\grenade_response::grenadereturnthrow;
  var0.actionfn[20] = &scripts\aitypes\grenade_response::grenadereturnthrow_terminate;
  var0.actionfn[21] = &scripts\aitypes\stealth::ifinstealth;
  var0.actionfn[22] = &scripts\aitypes\stealth::stealth_shouldfriendly;
  var0.actionfn[23] = &scripts\aitypes\stealth::stealth_initfriendly;
  var0.actionfn[24] = &scripts\aitypes\stealth::stealth_shouldneutral;
  var0.actionfn[25] = &scripts\aitypes\stealth::stealth_initneutral;
  var0.actionfn[26] = &scripts\aitypes\stealth::stealth_neutral_updateeveryframe;
  var0.actionfn[27] = &scripts\aitypes\stealth::stealth_enemy_updateeveryframe;
  var0.actionfn[28] = &scripts\aitypes\stealth::stealth_enemy_getbsmstate;
  var0.actionfn[29] = &scripts\aitypes\stealth::stealth_shouldhunt;
  var0.actionfn[30] = &scripts\aitypes\stealth::hunt_shouldhunker;
  var0.actionfn[31] = &scripts\aitypes\stealth::hunt_initialdelay;
  var0.actionfn[32] = &scripts\aitypes\stealth::hunt_initialdelay_init;
  var0.actionfn[33] = &scripts\aitypes\stealth::hunt_initialdelay_terminate;
  var0.actionfn[34] = &scripts\aitypes\stealth::hunt_hunker;
  var0.actionfn[35] = &scripts\aitypes\stealth::hunt_hunker_init;
  var0.actionfn[36] = &scripts\aitypes\stealth::hunt_hunker_terminate;
  var0.actionfn[37] = &scripts\aitypes\stealth::hunt_isincover;
  var0.actionfn[38] = &scripts\aitypes\cover::initcover;
  var0.actionfn[39] = &scripts\aitypes\cover::shouldlookorpeek;
  var0.actionfn[40] = &scripts\aitypes\cover::coverlook;
  var0.actionfn[41] = &scripts\aitypes\cover::initlook;
  var0.actionfn[42] = &scripts\aitypes\cover::terminatelook;
  var0.actionfn[43] = &scripts\aitypes\cover::coverpeek;
  var0.actionfn[44] = &scripts\aitypes\cover::terminatepeek;
  var0.actionfn[45] = &scripts\aitypes\stealth::hunt_hunker_shouldexpose;
  var0.actionfn[46] = &scripts\aitypes\stealth::hunt_hunker_expose;
  var0.actionfn[47] = &scripts\aitypes\stealth::hunt_hunker_expose_init;
  var0.actionfn[48] = &scripts\aitypes\stealth::hunt_hunker_expose_terminate;
  var0.actionfn[49] = &scripts\aitypes\cover::coverhide;
  var0.actionfn[50] = &scripts\aitypes\cover::inithide;
  var0.actionfn[51] = &scripts\aitypes\cover::initcoverbb;
  var0.actionfn[52] = &scripts\aitypes\cover::clearcoverbb;
  var0.actionfn[53] = &scripts\aitypes\combat::ifshoulddosmartobject;
  var0.actionfn[54] = &scripts\aitypes\combat::dosmartobject;
  var0.actionfn[55] = &scripts\aitypes\combat::dosmartobject_init;
  var0.actionfn[56] = &scripts\aitypes\combat::dosmartobjectterminate;
  var0.actionfn[57] = &scripts\aitypes\stealth::hunt_lookaround;
  var0.actionfn[58] = &scripts\aitypes\stealth::hunt_lookaround_init;
  var0.actionfn[59] = &scripts\aitypes\stealth::hunt_lookaround_terminate;
  var0.actionfn[60] = &scripts\aitypes\stealth::hunt_move;
  var0.actionfn[61] = &scripts\aitypes\stealth::hunt_move_init;
  var0.actionfn[62] = &scripts\aitypes\stealth::hunt_move_terminate;
  var0.actionfn[63] = &scripts\aitypes\stealth::hunt_active_terminate;
  var0.actionfn[64] = &scripts\aitypes\stealth::stealth_shouldinvestigate;
  var0.actionfn[65] = &scripts\aitypes\stealth::investigate_updateeveryframe;
  var0.actionfn[66] = &scripts\aitypes\stealth::investigate_lookaround;
  var0.actionfn[67] = &scripts\aitypes\stealth::investigate_lookaround_init;
  var0.actionfn[68] = &scripts\aitypes\stealth::investigate_lookaround_terminate;
  var0.actionfn[69] = &scripts\aitypes\stealth::investigate_targetedlookaround;
  var0.actionfn[70] = &scripts\aitypes\stealth::investigate_move;
  var0.actionfn[71] = &scripts\aitypes\stealth::investigate_move_init;
  var0.actionfn[72] = &scripts\aitypes\stealth::investigate_move_terminate;
  var0.actionfn[73] = &scripts\aitypes\stealth::idle_update;
  var0.actionfn[74] = &scripts\aitypes\stealth::idle_init;
  var0.actionfn[75] = &scripts\aitypes\stealth::idle_terminate;
  var0.actionfn[76] = &scripts\aitypes\combat::updatesniperglint;
  var0.actionfn[77] = &scripts\aitypes\weapon::updateweapon;
  var0.actionfn[78] = &scripts\aitypes\cover::updateexposedatnodestate;
  var0.actionfn[79] = &scripts\aitypes\cover::isincover;
  var0.actionfn[80] = &scripts\aitypes\cover::shoulddeploylmg;
  var0.actionfn[81] = &scripts\aitypes\cover::update_lmg;
  var0.actionfn[82] = &scripts\aitypes\combat::iscoverblockedbywall;
  var0.actionfn[83] = &scripts\aitypes\cover::lookforbettercoverduetowallblock;
  var0.actionfn[84] = &soldier_agentfn0;
  var0.actionfn[85] = &scripts\aitypes\cover::initreload;
  var0.actionfn[86] = &scripts\aitypes\cover::terminatereload;
  var0.actionfn[87] = &scripts\aitypes\cover::shouldcovermultiswitch;
  var0.actionfn[88] = &scripts\aitypes\cover::covermultiswitch;
  var0.actionfn[89] = &scripts\aitypes\cover::terminatecovermultiswitch;
  var0.actionfn[90] = &scripts\aitypes\cover::coverchangestance;
  var0.actionfn[91] = &scripts\aitypes\cover::initchangestance;
  var0.actionfn[92] = &scripts\aitypes\cover::terminatechangestance;
  var0.actionfn[93] = &soldier_agentfn1;
  var0.actionfn[94] = &soldier_agentfn2;
  var0.actionfn[95] = &scripts\aitypes\cover::iscoversuppressed;
  var0.actionfn[96] = &scripts\aitypes\cover::shouldtryleavenode;
  var0.actionfn[97] = &scripts\aitypes\cover::lookforboundingoverwatchcover;
  var0.actionfn[98] = &scripts\aitypes\cover::lookforbettercover;
  var0.actionfn[99] = &soldier_agentfn3;
  var0.actionfn[100] = &scripts\aitypes\cover::isenemyvisiblefromexposed;
  var0.actionfn[101] = &soldier_agentfn4;
  var0.actionfn[102] = &soldier_agentfn5;
  var0.actionfn[103] = &soldier_agentfn6;
  var0.actionfn[104] = &scripts\aitypes\cover::coverthrowgrenade;
  var0.actionfn[105] = &scripts\aitypes\cover::initthrowgrenade;
  var0.actionfn[106] = &scripts\aitypes\cover::terminatethrowgrenade;
  var0.actionfn[107] = &scripts\aitypes\cover::shouldblindfire;
  var0.actionfn[108] = &scripts\aitypes\cover::coverblindfire;
  var0.actionfn[109] = &scripts\aitypes\cover::terminateblindfire;
  var0.actionfn[110] = &scripts\aitypes\cover::shouldthrowgrenade;
  var0.actionfn[111] = &soldier_agentfn7;
  var0.actionfn[112] = &scripts\aitypes\cover::shouldthrowgrenadeatenemyasap;
  var0.actionfn[113] = &scripts\aitypes\cover::isboredofnode;
  var0.actionfn[114] = &scripts\aitypes\cover::shouldpeekwhilecanseefromexposed;
  var0.actionfn[115] = &scripts\aitypes\cover::covershouldexpose;
  var0.actionfn[116] = &scripts\aitypes\cover::coverexpose;
  var0.actionfn[117] = &scripts\aitypes\cover::initexpose;
  var0.actionfn[118] = &scripts\aitypes\cover::terminateexpose;
  var0.actionfn[119] = &soldier_agentfn8;
  var0.actionfn[120] = &scripts\aitypes\cover::isalwayscoverexposed;
  var0.actionfn[121] = &scripts\aitypes\throwgrenade::hasgrenadetimerelapsed;
  var0.actionfn[122] = &scripts\aitypes\cover::covershouldexposelostenemy;
  var0.actionfn[123] = &scripts\aitypes\cover::coverexposenoenemy;
  var0.actionfn[124] = &scripts\aitypes\cover::initcoverexposenoenemy;
  var0.actionfn[125] = &scripts\aitypes\cover::terminatecoverexposenoenemy;
  var0.actionfn[126] = &scripts\aitypes\cover::covershouldexposenoenemy;
  var0.actionfn[127] = &scripts\aitypes\melee::shouldmelee;
  var0.actionfn[128] = &scripts\aitypes\melee::melee_init;
  var0.actionfn[129] = &scripts\aitypes\melee::meleecharge_update;
  var0.actionfn[130] = &scripts\aitypes\melee::meleecharge_init;
  var0.actionfn[131] = &scripts\aitypes\melee::meleecharge_terminate;
  var0.actionfn[132] = &scripts\aitypes\melee::domeleeaction;
  var0.actionfn[133] = &scripts\aitypes\melee::initmeleeaction;
  var0.actionfn[134] = &scripts\aitypes\melee::clearmeleeaction;
  var0.actionfn[135] = &scripts\aitypes\throwgrenade::throwgrenade_update;
  var0.actionfn[136] = &scripts\aitypes\throwgrenade::throwgrenade_init;
  var0.actionfn[137] = &scripts\aitypes\throwgrenade::throwgrenade_terminate;
  var0.actionfn[138] = &scripts\aitypes\throwgrenade::canthrowgrenade;
  var0.actionfn[139] = &scripts\aitypes\combat::isenemyinlowcover;
  var0.actionfn[140] = &scripts\aitypes\combat::enemyinlowcover_update;
  var0.actionfn[141] = &scripts\aitypes\combat::enemyinlowcover_init;
  var0.actionfn[142] = &scripts\aitypes\combat::enemyinlowcover_terminate;
  var0.actionfn[143] = &soldier_agentfn9;
  var0.actionfn[144] = &scripts\aitypes\combat::reacquire_init;
  var0.actionfn[145] = &scripts\aitypes\combat::reacquire_terminate;
  var0.actionfn[146] = &scripts\aitypes\combat::reacquire_charge;
  var0.actionfn[147] = &scripts\aitypes\combat::reacquire_charge_terminate;
  var0.actionfn[148] = &scripts\aitypes\combat::reacquire_clear;
  var0.actionfn[149] = &scripts\aitypes\combat::updateeveryframe_noncombat;
  var0.actionfn[150] = &scripts\aitypes\soldier_agent\setup::setupagent;
  var0.actionfn[151] = &scripts\aitypes\melee_sp::initmeleefunctions;
  var0.actionfn[152] = &scripts\aitypes\combat_mp::initcombatfunctions_mp;
  level._btactions["soldier_agent"] = var0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("soldier_agent");
}