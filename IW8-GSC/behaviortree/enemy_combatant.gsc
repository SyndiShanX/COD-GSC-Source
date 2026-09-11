/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\enemy_combatant.gsc
***********************************************/

function enemy_combatantfn0(var_0) {
  return 0.3;
}

function enemy_combatantfn1(var_0) {
  return true;
}

function enemy_combatantfn2(var_0) {
  return false;
}

function enemy_combatantfn3(var_0) {
  return scripts\aitypes\common::returnsuccessiftrue(var_0, isDefined(self.a.atconcealmentnode) && self.a.atconcealmentnode && scripts\anim\utility_common::canseeenemy());
}

function enemy_combatantfn4(var_0) {
  return scripts\aitypes\common::returnsuccessiftrue(var_0, scripts\anim\utility_common::cansuppressenemyfromexposed());
}

function enemy_combatantfn5(var_0) {
  return scripts\aitypes\common::isvariabledefined(var_0, anim.throwgrenadeatplayerasap);
}

function enemy_combatantfn6(var_0) {
  return level.player;
}

function enemy_combatantfn7(var_0) {
  return 0.1;
}

function enemy_combatantfn8(var_0) {
  return scripts\aitypes\common::returnsuccessiftrue(var_0, istrue(self.aggressivemode) || scripts\anim\utility_common::enemyishiding());
}

function enemy_combatantfn9(var_0) {
  return scripts\aitypes\combat::reacquire_step(var_0, 96);
}

function bindactionscripts() {
  if(isDefined(level._btactions["enemy_combatant"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.actionfn = [];
  var_0.actionfn[0] = &scripts\aitypes\combat::updateeveryframe_global;
  var_0.actionfn[1] = &scripts\aitypes\squad_movement::shouldupdatesquadleadermovement;
  var_0.actionfn[2] = &scripts\aitypes\squad_movement::updatesquadleadermovement;
  var_0.actionfn[3] = &scripts\aitypes\vehicle::getbsmstate;
  var_0.actionfn[4] = &scripts\aitypes\vehicle::movetovehicle;
  var_0.actionfn[5] = &scripts\aitypes\vehicle::movetovehicle_init;
  var_0.actionfn[6] = &scripts\aitypes\vehicle::movetovehicle_terminate;
  var_0.actionfn[7] = &scripts\aitypes\vehicle::entervehicle;
  var_0.actionfn[8] = &scripts\aitypes\combat::mayshoot;
  var_0.actionfn[9] = &scripts\aitypes\combat::shoot_update;
  var_0.actionfn[10] = &scripts\aitypes\combat::shoot_init;
  var_0.actionfn[11] = &scripts\aitypes\combat::shoot_terminate;
  var_0.actionfn[12] = &scripts\aitypes\vehicle::exitvehicle;
  var_0.actionfn[13] = &scripts\aitypes\vehicle::vehiclecanshoot;
  var_0.actionfn[14] = &scripts\aitypes\vehicle::vehicleidle;
  var_0.actionfn[15] = &scripts\aitypes\combat::badplaceavoid;
  var_0.actionfn[16] = &scripts\aitypes\combat::waituntilnotinbadplace;
  var_0.actionfn[17] = &scripts\aitypes\combat::badplaceterminate;
  var_0.actionfn[18] = &scripts\aitypes\grenade_response::cangrenaderespond;
  var_0.actionfn[19] = &scripts\aitypes\grenade_response::grenadereturnthrow;
  var_0.actionfn[20] = &scripts\aitypes\grenade_response::grenadereturnthrow_terminate;
  var_0.actionfn[21] = &scripts\aitypes\stealth::ifinstealth;
  var_0.actionfn[22] = &scripts\aitypes\stealth::stealth_shouldfriendly;
  var_0.actionfn[23] = &scripts\aitypes\stealth::stealth_initfriendly;
  var_0.actionfn[24] = &scripts\aitypes\stealth::stealth_shouldneutral;
  var_0.actionfn[25] = &scripts\aitypes\stealth::stealth_initneutral;
  var_0.actionfn[26] = &scripts\aitypes\stealth::stealth_neutral_updateeveryframe;
  var_0.actionfn[27] = &scripts\aitypes\stealth::stealth_enemy_updateeveryframe;
  var_0.actionfn[28] = &scripts\aitypes\stealth::stealth_enemy_getbsmstate;
  var_0.actionfn[29] = &scripts\aitypes\stealth::stealth_shouldhunt;
  var_0.actionfn[30] = &scripts\aitypes\stealth::hunt_shouldhunker;
  var_0.actionfn[31] = &scripts\aitypes\stealth::hunt_initialdelay;
  var_0.actionfn[32] = &scripts\aitypes\stealth::hunt_initialdelay_init;
  var_0.actionfn[33] = &scripts\aitypes\stealth::hunt_initialdelay_terminate;
  var_0.actionfn[34] = &scripts\aitypes\stealth::hunt_hunker;
  var_0.actionfn[35] = &scripts\aitypes\stealth::hunt_hunker_init;
  var_0.actionfn[36] = &scripts\aitypes\stealth::hunt_hunker_terminate;
  var_0.actionfn[37] = &scripts\aitypes\stealth::hunt_isincover;
  var_0.actionfn[38] = &scripts\aitypes\cover::initcover;
  var_0.actionfn[39] = &scripts\aitypes\cover::shouldlookorpeek;
  var_0.actionfn[40] = &scripts\aitypes\cover::coverlook;
  var_0.actionfn[41] = &scripts\aitypes\cover::initlook;
  var_0.actionfn[42] = &scripts\aitypes\cover::terminatelook;
  var_0.actionfn[43] = &scripts\aitypes\cover::coverpeek;
  var_0.actionfn[44] = &scripts\aitypes\cover::terminatepeek;
  var_0.actionfn[45] = &scripts\aitypes\stealth::hunt_hunker_shouldexpose;
  var_0.actionfn[46] = &scripts\aitypes\stealth::hunt_hunker_expose;
  var_0.actionfn[47] = &scripts\aitypes\stealth::hunt_hunker_expose_init;
  var_0.actionfn[48] = &scripts\aitypes\stealth::hunt_hunker_expose_terminate;
  var_0.actionfn[49] = &scripts\aitypes\cover::coverhide;
  var_0.actionfn[50] = &scripts\aitypes\cover::inithide;
  var_0.actionfn[51] = &scripts\aitypes\cover::initcoverbb;
  var_0.actionfn[52] = &scripts\aitypes\cover::clearcoverbb;
  var_0.actionfn[53] = &scripts\aitypes\combat::ifshoulddosmartobject;
  var_0.actionfn[54] = &scripts\aitypes\combat::dosmartobject;
  var_0.actionfn[55] = &scripts\aitypes\combat::dosmartobject_init;
  var_0.actionfn[56] = &scripts\aitypes\combat::dosmartobjectterminate;
  var_0.actionfn[57] = &scripts\aitypes\stealth::hunt_lookaround;
  var_0.actionfn[58] = &scripts\aitypes\stealth::hunt_lookaround_init;
  var_0.actionfn[59] = &scripts\aitypes\stealth::hunt_lookaround_terminate;
  var_0.actionfn[60] = &scripts\aitypes\stealth::hunt_move;
  var_0.actionfn[61] = &scripts\aitypes\stealth::hunt_move_init;
  var_0.actionfn[62] = &scripts\aitypes\stealth::hunt_move_terminate;
  var_0.actionfn[63] = &scripts\aitypes\stealth::hunt_active_terminate;
  var_0.actionfn[64] = &scripts\aitypes\stealth::stealth_shouldinvestigate;
  var_0.actionfn[65] = &scripts\aitypes\stealth::investigate_updateeveryframe;
  var_0.actionfn[66] = &scripts\aitypes\stealth::investigate_lookaround;
  var_0.actionfn[67] = &scripts\aitypes\stealth::investigate_lookaround_init;
  var_0.actionfn[68] = &scripts\aitypes\stealth::investigate_lookaround_terminate;
  var_0.actionfn[69] = &scripts\aitypes\stealth::investigate_targetedlookaround;
  var_0.actionfn[70] = &scripts\aitypes\stealth::investigate_move;
  var_0.actionfn[71] = &scripts\aitypes\stealth::investigate_move_init;
  var_0.actionfn[72] = &scripts\aitypes\stealth::investigate_move_terminate;
  var_0.actionfn[73] = &scripts\aitypes\stealth::idle_update;
  var_0.actionfn[74] = &scripts\aitypes\stealth::idle_init;
  var_0.actionfn[75] = &scripts\aitypes\stealth::idle_terminate;
  var_0.actionfn[76] = &scripts\aitypes\combat::updatesniperglint;
  var_0.actionfn[77] = &scripts\aitypes\weapon::updateweapon;
  var_0.actionfn[78] = &scripts\aitypes\cover::updateexposedatnodestate;
  var_0.actionfn[79] = &scripts\aitypes\cover::isincover;
  var_0.actionfn[80] = &scripts\aitypes\cover::shoulddeploylmg;
  var_0.actionfn[81] = &scripts\aitypes\cover::update_lmg;
  var_0.actionfn[82] = &scripts\aitypes\combat::iscoverblockedbywall;
  var_0.actionfn[83] = &scripts\aitypes\cover::lookforbettercoverduetowallblock;
  var_0.actionfn[84] = &enemy_combatantfn0;
  var_0.actionfn[85] = &scripts\aitypes\cover::initreload;
  var_0.actionfn[86] = &scripts\aitypes\cover::terminatereload;
  var_0.actionfn[87] = &scripts\aitypes\cover::shouldcovermultiswitch;
  var_0.actionfn[88] = &scripts\aitypes\cover::covermultiswitch;
  var_0.actionfn[89] = &scripts\aitypes\cover::terminatecovermultiswitch;
  var_0.actionfn[90] = &scripts\aitypes\cover::coverchangestance;
  var_0.actionfn[91] = &scripts\aitypes\cover::initchangestance;
  var_0.actionfn[92] = &scripts\aitypes\cover::terminatechangestance;
  var_0.actionfn[93] = &enemy_combatantfn1;
  var_0.actionfn[94] = &enemy_combatantfn2;
  var_0.actionfn[95] = &scripts\aitypes\cover::iscoversuppressed;
  var_0.actionfn[96] = &scripts\aitypes\cover::shouldtryleavenode;
  var_0.actionfn[97] = &scripts\aitypes\cover::lookforboundingoverwatchcover;
  var_0.actionfn[98] = &scripts\aitypes\cover::lookforbettercover;
  var_0.actionfn[99] = &enemy_combatantfn3;
  var_0.actionfn[100] = &scripts\aitypes\cover::isenemyvisiblefromexposed;
  var_0.actionfn[101] = &enemy_combatantfn4;
  var_0.actionfn[102] = &enemy_combatantfn5;
  var_0.actionfn[103] = &enemy_combatantfn6;
  var_0.actionfn[104] = &scripts\aitypes\cover::coverthrowgrenade;
  var_0.actionfn[105] = &scripts\aitypes\cover::initthrowgrenade;
  var_0.actionfn[106] = &scripts\aitypes\cover::terminatethrowgrenade;
  var_0.actionfn[107] = &scripts\aitypes\cover::shouldblindfire;
  var_0.actionfn[108] = &scripts\aitypes\cover::coverblindfire;
  var_0.actionfn[109] = &scripts\aitypes\cover::terminateblindfire;
  var_0.actionfn[110] = &scripts\aitypes\cover::shouldthrowgrenade;
  var_0.actionfn[111] = &enemy_combatantfn7;
  var_0.actionfn[112] = &scripts\aitypes\cover::shouldthrowgrenadeatenemyasap;
  var_0.actionfn[113] = &scripts\aitypes\cover::isboredofnode;
  var_0.actionfn[114] = &scripts\aitypes\cover::shouldpeekwhilecanseefromexposed;
  var_0.actionfn[115] = &scripts\aitypes\cover::covershouldexpose;
  var_0.actionfn[116] = &scripts\aitypes\cover::coverexpose;
  var_0.actionfn[117] = &scripts\aitypes\cover::initexpose;
  var_0.actionfn[118] = &scripts\aitypes\cover::terminateexpose;
  var_0.actionfn[119] = &enemy_combatantfn8;
  var_0.actionfn[120] = &scripts\aitypes\cover::isalwayscoverexposed;
  var_0.actionfn[121] = &scripts\aitypes\throwgrenade::hasgrenadetimerelapsed;
  var_0.actionfn[122] = &scripts\aitypes\cover::covershouldexposelostenemy;
  var_0.actionfn[123] = &scripts\aitypes\cover::coverexposenoenemy;
  var_0.actionfn[124] = &scripts\aitypes\cover::initcoverexposenoenemy;
  var_0.actionfn[125] = &scripts\aitypes\cover::terminatecoverexposenoenemy;
  var_0.actionfn[126] = &scripts\aitypes\cover::covershouldexposenoenemy;
  var_0.actionfn[127] = &scripts\aitypes\melee::shouldmelee;
  var_0.actionfn[128] = &scripts\aitypes\melee::melee_init;
  var_0.actionfn[129] = &scripts\aitypes\melee::meleecharge_update;
  var_0.actionfn[130] = &scripts\aitypes\melee::meleecharge_init;
  var_0.actionfn[131] = &scripts\aitypes\melee::meleecharge_terminate;
  var_0.actionfn[132] = &scripts\aitypes\melee::domeleeaction;
  var_0.actionfn[133] = &scripts\aitypes\melee::initmeleeaction;
  var_0.actionfn[134] = &scripts\aitypes\melee::clearmeleeaction;
  var_0.actionfn[135] = &scripts\aitypes\throwgrenade::throwgrenade_update;
  var_0.actionfn[136] = &scripts\aitypes\throwgrenade::throwgrenade_init;
  var_0.actionfn[137] = &scripts\aitypes\throwgrenade::throwgrenade_terminate;
  var_0.actionfn[138] = &scripts\aitypes\throwgrenade::canthrowgrenade;
  var_0.actionfn[139] = &scripts\aitypes\combat::isenemyinlowcover;
  var_0.actionfn[140] = &scripts\aitypes\combat::enemyinlowcover_update;
  var_0.actionfn[141] = &scripts\aitypes\combat::enemyinlowcover_init;
  var_0.actionfn[142] = &scripts\aitypes\combat::enemyinlowcover_terminate;
  var_0.actionfn[143] = &enemy_combatantfn9;
  var_0.actionfn[144] = &scripts\aitypes\combat::reacquire_init;
  var_0.actionfn[145] = &scripts\aitypes\combat::reacquire_terminate;
  var_0.actionfn[146] = &scripts\aitypes\combat::reacquire_charge;
  var_0.actionfn[147] = &scripts\aitypes\combat::reacquire_charge_terminate;
  var_0.actionfn[148] = &scripts\aitypes\combat::reacquire_clear;
  var_0.actionfn[149] = &scripts\aitypes\combat::updateeveryframe_noncombat;
  var_0.actionfn[150] = &scripts\aitypes\combat_sp::soldier_init;
  var_0.actionfn[151] = &scripts\aitypes\melee_sp::initmeleefunctions;
  var_0.actionfn[152] = &scripts\aitypes\combat_sp::initcombatfunctions;
  level._btactions["enemy_combatant"] = var_0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("enemy_combatant");
}