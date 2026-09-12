/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_cp_usmc_basic_ar_3.gsc
******************************************************/

function ref_134C4(var_0) {
  return scripts\aitypes\common::returnsuccessiftrue(var_0, isDefined(self.a.atconcealmentnode) && self.a.atconcealmentnode && scripts\anim\utility_common::canseeenemy());
}

function ref_134C5(var_0) {
  return scripts\aitypes\common::returnsuccessiftrue(var_0, scripts\anim\utility_common::cansuppressenemyfromexposed());
}

function ref_134C6(var_0) {
  return scripts\aitypes\common::isvariabledefined(var_0, anim.throwgrenadeatplayerasap);
}

function ref_134C7(var_0) {
  return level.player;
}

function ref_134C8(var_0) {
  return 0.1;
}

function ref_134C9(var_0) {
  return false;
}

function ref_134CA(var_0) {
  return scripts\aitypes\common::returnsuccessiftrue(var_0, istrue(self.aggressivemode) || scripts\anim\utility_common::enemyishiding());
}

function bindactionscripts() {
  if(isDefined(level._btactions["soldier_lw_br_agent"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.actionfn = [];
  var_0.actionfn[0] = &scripts\aitypes\melee_sp::initmeleefunctions;
  var_0.actionfn[1] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134A5;
  var_0.actionfn[2] = &scripts\aitypes\combat::updateeveryframe_global;
  var_0.actionfn[3] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13487;
  var_0.actionfn[4] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13498;
  var_0.actionfn[5] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13481;
  var_0.actionfn[6] = &scripts\aitypes\combat::waituntilnotinbadplace;
  var_0.actionfn[7] = &scripts\aitypes\combat::badplaceterminate;
  var_0.actionfn[8] = &scripts\aitypes\combat::updatewhizby;
  var_0.actionfn[9] = &scripts\aitypes\weapon::updateweapon;
  var_0.actionfn[10] = &scripts\aitypes\cover::updateexposedatnodestate;
  var_0.actionfn[11] = &scripts\aitypes\melee::shouldmelee;
  var_0.actionfn[12] = &scripts\aitypes\melee::melee_init;
  var_0.actionfn[13] = &scripts\aitypes\melee::meleecharge_update;
  var_0.actionfn[14] = &scripts\aitypes\melee::meleecharge_init;
  var_0.actionfn[15] = &scripts\aitypes\melee::meleecharge_terminate;
  var_0.actionfn[16] = &scripts\aitypes\melee::domeleeaction;
  var_0.actionfn[17] = &scripts\aitypes\melee::initmeleeaction;
  var_0.actionfn[18] = &scripts\aitypes\melee::clearmeleeaction;
  var_0.actionfn[19] = &scripts\aitypes\cover::shouldthrowgrenadeatenemyasap;
  var_0.actionfn[20] = &scripts\aitypes\throwgrenade::throwgrenade_update;
  var_0.actionfn[21] = &scripts\aitypes\throwgrenade::throwgrenade_init;
  var_0.actionfn[22] = &scripts\aitypes\throwgrenade::throwgrenade_terminate;
  var_0.actionfn[23] = &scripts\aitypes\throwgrenade::hasgrenadetimerelapsed;
  var_0.actionfn[24] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13485;
  var_0.actionfn[25] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134C0;
  var_0.actionfn[26] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134C1;
  var_0.actionfn[27] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134A7;
  var_0.actionfn[28] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134B5;
  var_0.actionfn[29] = &scripts\aitypes\combat::shoot_init;
  var_0.actionfn[30] = &scripts\aitypes\combat::shoot_terminate;
  var_0.actionfn[31] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134B6;
  var_0.actionfn[32] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13486;
  var_0.actionfn[33] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134A4;
  var_0.actionfn[34] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134BE;
  var_0.actionfn[35] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134B7;
  var_0.actionfn[36] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13491;
  var_0.actionfn[37] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13492;
  var_0.actionfn[38] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_13493;
  var_0.actionfn[39] = &scripts\aitypes\cover::isincover;
  var_0.actionfn[40] = &scripts\aitypes\cover::initcover;
  var_0.actionfn[41] = &scripts\aitypes\cover::coverchangestance;
  var_0.actionfn[42] = &scripts\aitypes\cover::initchangestance;
  var_0.actionfn[43] = &scripts\aitypes\cover::terminatechangestance;
  var_0.actionfn[44] = &scripts\aitypes\cover::iscoversuppressed;
  var_0.actionfn[45] = &scripts\aitypes\cover::coverhide;
  var_0.actionfn[46] = &scripts\aitypes\cover::inithide;
  var_0.actionfn[47] = &scripts\aitypes\cover::shouldtryleavenode;
  var_0.actionfn[48] = &scripts\aitypes\cover::lookforboundingoverwatchcover;
  var_0.actionfn[49] = &scripts\aitypes\cover::lookforbettercover;
  var_0.actionfn[50] = &ref_134C4;
  var_0.actionfn[51] = &scripts\aitypes\cover::isenemyvisiblefromexposed;
  var_0.actionfn[52] = &ref_134C5;
  var_0.actionfn[53] = &ref_134C6;
  var_0.actionfn[54] = &ref_134C7;
  var_0.actionfn[55] = &scripts\aitypes\cover::coverthrowgrenade;
  var_0.actionfn[56] = &scripts\aitypes\cover::initthrowgrenade;
  var_0.actionfn[57] = &scripts\aitypes\cover::terminatethrowgrenade;
  var_0.actionfn[58] = &scripts\aitypes\cover::shouldblindfire;
  var_0.actionfn[59] = &scripts\aitypes\cover::coverblindfire;
  var_0.actionfn[60] = &scripts\aitypes\cover::terminateblindfire;
  var_0.actionfn[61] = &scripts\aitypes\cover::shouldthrowgrenade;
  var_0.actionfn[62] = &ref_134C8;
  var_0.actionfn[63] = &scripts\aitypes\cover::initreload;
  var_0.actionfn[64] = &scripts\aitypes\cover::terminatereload;
  var_0.actionfn[65] = &scripts\aitypes\cover::shouldlookorpeek;
  var_0.actionfn[66] = &scripts\aitypes\cover::coverpeek;
  var_0.actionfn[67] = &scripts\aitypes\cover::terminatepeek;
  var_0.actionfn[68] = &scripts\aitypes\cover::isboredofnode;
  var_0.actionfn[69] = &scripts\aitypes\cover::shouldpeekwhilecanseefromexposed;
  var_0.actionfn[70] = &ref_134C9;
  var_0.actionfn[71] = &scripts\aitypes\cover::covershouldexpose;
  var_0.actionfn[72] = &scripts\aitypes\cover::coverexpose;
  var_0.actionfn[73] = &scripts\aitypes\cover::initexpose;
  var_0.actionfn[74] = &scripts\aitypes\cover::terminateexpose;
  var_0.actionfn[75] = &scripts\aitypes\combat::iscoverblockedbywall;
  var_0.actionfn[76] = &scripts\aitypes\cover::lookforbettercoverduetowallblock;
  var_0.actionfn[77] = &ref_134CA;
  var_0.actionfn[78] = &scripts\aitypes\cover::isalwayscoverexposed;
  var_0.actionfn[79] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134A6;
  var_0.actionfn[80] = &scripts\aitypes\cover::covershouldexposelostenemy;
  var_0.actionfn[81] = &scripts\aitypes\cover::coverexposenoenemy;
  var_0.actionfn[82] = &scripts\aitypes\cover::initcoverexposenoenemy;
  var_0.actionfn[83] = &scripts\aitypes\cover::terminatecoverexposenoenemy;
  var_0.actionfn[84] = &scripts\aitypes\cover::covershouldexposenoenemy;
  var_0.actionfn[85] = &scripts\aitypes\cover::initcoverbb;
  var_0.actionfn[86] = &scripts\aitypes\cover::clearcoverbb;
  var_0.actionfn[87] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134B9;
  var_0.actionfn[88] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134A9;
  var_0.actionfn[89] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134AA;
  var_0.actionfn[90] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134AB;
  var_0.actionfn[91] = &scripts\aitypes\soldier_agent\setup::setupagent;
  var_0.actionfn[92] = &scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_134A3;
  level._btactions["soldier_lw_br_agent"] = var_0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("soldier_lw_br_agent");
}