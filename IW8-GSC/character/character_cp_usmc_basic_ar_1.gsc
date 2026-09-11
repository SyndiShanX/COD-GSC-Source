/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: character\character_cp_usmc_basic_ar_1.gsc
******************************************************/

function bindactionscripts() {
  if(isDefined(level._btactions["riotshield_cp"])) {
    return;
  }

  var_0 = spawnStruct();
  var_0.actionfn = [];
  var_0.actionfn[0] = &scripts\mp\trials\mp_euphrates_create_script::ref_12d49;
  var_0.actionfn[1] = &scripts\aitypes\combat::updateeveryframe_global;
  var_0.actionfn[2] = &scripts\aitypes\juggernaut\behaviors::juggernaut_lookforplayers;
  var_0.actionfn[3] = &scripts\aitypes\combat::badplaceavoid;
  var_0.actionfn[4] = &scripts\aitypes\combat::waituntilnotinbadplace;
  var_0.actionfn[5] = &scripts\aitypes\combat::badplaceterminate;
  var_0.actionfn[6] = &scripts\aitypes\combat::updatewhizby;
  var_0.actionfn[7] = &scripts\aitypes\weapon::updateweapon;
  var_0.actionfn[8] = &scripts\aitypes\cover::updateexposedatnodestate;
  var_0.actionfn[9] = &scripts\aitypes\melee::shouldmelee;
  var_0.actionfn[10] = &scripts\aitypes\melee::melee_init;
  var_0.actionfn[11] = &scripts\aitypes\melee::meleecharge_update;
  var_0.actionfn[12] = &scripts\aitypes\melee::meleecharge_init;
  var_0.actionfn[13] = &scripts\aitypes\melee::meleecharge_terminate;
  var_0.actionfn[14] = &scripts\aitypes\melee::domeleeaction;
  var_0.actionfn[15] = &scripts\aitypes\melee::initmeleeaction;
  var_0.actionfn[16] = &scripts\aitypes\melee::clearmeleeaction;
  var_0.actionfn[17] = &scripts\aitypes\combat::mayshoot;
  var_0.actionfn[18] = &scripts\aitypes\combat::shoot_update;
  var_0.actionfn[19] = &scripts\aitypes\combat::shoot_init;
  var_0.actionfn[20] = &scripts\aitypes\combat::shoot_terminate;
  var_0.actionfn[21] = &scripts\aitypes\juggernaut\behaviors::juggernaut_shouldmove;
  var_0.actionfn[22] = &scripts\aitypes\juggernaut\behaviors::juggernaut_move;
  var_0.actionfn[23] = &scripts\aitypes\juggernaut\behaviors::juggernaut_moveinit;
  var_0.actionfn[24] = &scripts\aitypes\juggernaut\behaviors::juggernaut_moveterminate;
  var_0.actionfn[25] = &scripts\aitypes\soldier_agent\setup::setupagent;
  var_0.actionfn[26] = &scripts\aitypes\melee_sp::initmeleefunctions;
  var_0.actionfn[27] = &scripts\aitypes\combat_mp::initcombatfunctions_mp;
  var_0.actionfn[28] = &scripts\aitypes\juggernaut\behaviors::juggernaut_init;
  var_0.actionfn[29] = &scripts\mp\trials\mp_euphrates_create_script::ref_12d4b;
  level._btactions["riotshield_cp"] = var_0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("riotshield_cp");
}