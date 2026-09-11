/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_cp_usmc_basic_ar_3.gsc
******************************************************/

function ref_134c4(var0) {
  return scripts\aitypes\common::returnsuccessiftrue(var0, isDefined(self.a.atconcealmentnode) && self.a.atconcealmentnode && scripts\anim\utility_common::canseeenemy());
}

function ref_134c5(var0) {
  return scripts\aitypes\common::returnsuccessiftrue(var0, scripts\anim\utility_common::cansuppressenemyfromexposed());
}

function ref_134c6(var0) {
  return scripts\aitypes\common::isvariabledefined(var0, anim.throwgrenadeatplayerasap);
}

function ref_134c7(var0) {
  return level.player;
}

function ref_134c8(var0) {
  return 0.1;
}

function ref_134c9(var0) {
  return false;
}

function ref_134ca(var0) {
  return scripts\aitypes\common::returnsuccessiftrue(var0, istrue(self.aggressivemode) || scripts\anim\utility_common::enemyishiding());
}

function bindactionscripts() {
  if(isDefined(level._btactions["soldier_lw_br_agent"])) {
    return;
  }

  var0 = spawnStruct();
  var0.actionfn = [];
  var0.actionfn[0] = &scripts\aitypes\melee_sp::initmeleefunctions;
  var0.actionfn[1] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134a5;
  var0.actionfn[2] = &scripts\aitypes\combat::updateeveryframe_global;
  var0.actionfn[3] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13487;
  var0.actionfn[4] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13498;
  var0.actionfn[5] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13481;
  var0.actionfn[6] = &scripts\aitypes\combat::waituntilnotinbadplace;
  var0.actionfn[7] = &scripts\aitypes\combat::badplaceterminate;
  var0.actionfn[8] = &scripts\aitypes\combat::updatewhizby;
  var0.actionfn[9] = &scripts\aitypes\weapon::updateweapon;
  var0.actionfn[10] = &scripts\aitypes\cover::updateexposedatnodestate;
  var0.actionfn[11] = &scripts\aitypes\melee::shouldmelee;
  var0.actionfn[12] = &scripts\aitypes\melee::melee_init;
  var0.actionfn[13] = &scripts\aitypes\melee::meleecharge_update;
  var0.actionfn[14] = &scripts\aitypes\melee::meleecharge_init;
  var0.actionfn[15] = &scripts\aitypes\melee::meleecharge_terminate;
  var0.actionfn[16] = &scripts\aitypes\melee::domeleeaction;
  var0.actionfn[17] = &scripts\aitypes\melee::initmeleeaction;
  var0.actionfn[18] = &scripts\aitypes\melee::clearmeleeaction;
  var0.actionfn[19] = &scripts\aitypes\cover::shouldthrowgrenadeatenemyasap;
  var0.actionfn[20] = &scripts\aitypes\throwgrenade::throwgrenade_update;
  var0.actionfn[21] = &scripts\aitypes\throwgrenade::throwgrenade_init;
  var0.actionfn[22] = &scripts\aitypes\throwgrenade::throwgrenade_terminate;
  var0.actionfn[23] = &scripts\aitypes\throwgrenade::hasgrenadetimerelapsed;
  var0.actionfn[24] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13485;
  var0.actionfn[25] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134c0;
  var0.actionfn[26] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134c1;
  var0.actionfn[27] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134a7;
  var0.actionfn[28] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134b5;
  var0.actionfn[29] = &scripts\aitypes\combat::shoot_init;
  var0.actionfn[30] = &scripts\aitypes\combat::shoot_terminate;
  var0.actionfn[31] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134b6;
  var0.actionfn[32] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13486;
  var0.actionfn[33] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134a4;
  var0.actionfn[34] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134be;
  var0.actionfn[35] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134b7;
  var0.actionfn[36] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13491;
  var0.actionfn[37] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13492;
  var0.actionfn[38] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13493;
  var0.actionfn[39] = &scripts\aitypes\cover::isincover;
  var0.actionfn[40] = &scripts\aitypes\cover::initcover;
  var0.actionfn[41] = &scripts\aitypes\cover::coverchangestance;
  var0.actionfn[42] = &scripts\aitypes\cover::initchangestance;
  var0.actionfn[43] = &scripts\aitypes\cover::terminatechangestance;
  var0.actionfn[44] = &scripts\aitypes\cover::iscoversuppressed;
  var0.actionfn[45] = &scripts\aitypes\cover::coverhide;
  var0.actionfn[46] = &scripts\aitypes\cover::inithide;
  var0.actionfn[47] = &scripts\aitypes\cover::shouldtryleavenode;
  var0.actionfn[48] = &scripts\aitypes\cover::lookforboundingoverwatchcover;
  var0.actionfn[49] = &scripts\aitypes\cover::lookforbettercover;
  var0.actionfn[50] = &ref_134c4;
  var0.actionfn[51] = &scripts\aitypes\cover::isenemyvisiblefromexposed;
  var0.actionfn[52] = &ref_134c5;
  var0.actionfn[53] = &ref_134c6;
  var0.actionfn[54] = &ref_134c7;
  var0.actionfn[55] = &scripts\aitypes\cover::coverthrowgrenade;
  var0.actionfn[56] = &scripts\aitypes\cover::initthrowgrenade;
  var0.actionfn[57] = &scripts\aitypes\cover::terminatethrowgrenade;
  var0.actionfn[58] = &scripts\aitypes\cover::shouldblindfire;
  var0.actionfn[59] = &scripts\aitypes\cover::coverblindfire;
  var0.actionfn[60] = &scripts\aitypes\cover::terminateblindfire;
  var0.actionfn[61] = &scripts\aitypes\cover::shouldthrowgrenade;
  var0.actionfn[62] = &ref_134c8;
  var0.actionfn[63] = &scripts\aitypes\cover::initreload;
  var0.actionfn[64] = &scripts\aitypes\cover::terminatereload;
  var0.actionfn[65] = &scripts\aitypes\cover::shouldlookorpeek;
  var0.actionfn[66] = &scripts\aitypes\cover::coverpeek;
  var0.actionfn[67] = &scripts\aitypes\cover::terminatepeek;
  var0.actionfn[68] = &scripts\aitypes\cover::isboredofnode;
  var0.actionfn[69] = &scripts\aitypes\cover::shouldpeekwhilecanseefromexposed;
  var0.actionfn[70] = &ref_134c9;
  var0.actionfn[71] = &scripts\aitypes\cover::covershouldexpose;
  var0.actionfn[72] = &scripts\aitypes\cover::coverexpose;
  var0.actionfn[73] = &scripts\aitypes\cover::initexpose;
  var0.actionfn[74] = &scripts\aitypes\cover::terminateexpose;
  var0.actionfn[75] = &scripts\aitypes\combat::iscoverblockedbywall;
  var0.actionfn[76] = &scripts\aitypes\cover::lookforbettercoverduetowallblock;
  var0.actionfn[77] = &ref_134ca;
  var0.actionfn[78] = &scripts\aitypes\cover::isalwayscoverexposed;
  var0.actionfn[79] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134a6;
  var0.actionfn[80] = &scripts\aitypes\cover::covershouldexposelostenemy;
  var0.actionfn[81] = &scripts\aitypes\cover::coverexposenoenemy;
  var0.actionfn[82] = &scripts\aitypes\cover::initcoverexposenoenemy;
  var0.actionfn[83] = &scripts\aitypes\cover::terminatecoverexposenoenemy;
  var0.actionfn[84] = &scripts\aitypes\cover::covershouldexposenoenemy;
  var0.actionfn[85] = &scripts\aitypes\cover::initcoverbb;
  var0.actionfn[86] = &scripts\aitypes\cover::clearcoverbb;
  var0.actionfn[87] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134b9;
  var0.actionfn[88] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134a9;
  var0.actionfn[89] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134aa;
  var0.actionfn[90] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134ab;
  var0.actionfn[91] = &scripts\aitypes\soldier_agent\setup::setupagent;
  var0.actionfn[92] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134a3;
  level._btactions["soldier_lw_br_agent"] = var0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("soldier_lw_br_agent");
}