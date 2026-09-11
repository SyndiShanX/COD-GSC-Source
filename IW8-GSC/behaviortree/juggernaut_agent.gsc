/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: behaviortree\juggernaut_agent.gsc
***********************************************/

function bindactionscripts() {
  if(isDefined(level._btactions["juggernaut_agent"])) {
    return;
  }

  var0 = spawnStruct();
  var0.actionfn = [];
  var0.actionfn[0] = &scripts\aitypes\melee_sp::initmeleefunctions;
  var0.actionfn[1] = &scripts\aitypes\combat_mp::initcombatfunctions_mp;
  var0.actionfn[2] = &scripts\aitypes\combat::updateeveryframe_global;
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
  var0.actionfn[15] = &scripts\aitypes\juggernaut\behaviors::juggernaut_lookforplayers;
  var0.actionfn[16] = &scripts\aitypes\combat::badplaceavoid;
  var0.actionfn[17] = &scripts\aitypes\combat::waituntilnotinbadplace;
  var0.actionfn[18] = &scripts\aitypes\combat::badplaceterminate;
  var0.actionfn[19] = &scripts\aitypes\combat::updatewhizby;
  var0.actionfn[20] = &scripts\aitypes\weapon::updateweapon;
  var0.actionfn[21] = &scripts\aitypes\cover::updateexposedatnodestate;
  var0.actionfn[22] = &scripts\aitypes\melee::shouldmelee;
  var0.actionfn[23] = &scripts\aitypes\melee::melee_init;
  var0.actionfn[24] = &scripts\aitypes\melee::meleecharge_update;
  var0.actionfn[25] = &scripts\aitypes\melee::meleecharge_init;
  var0.actionfn[26] = &scripts\aitypes\melee::meleecharge_terminate;
  var0.actionfn[27] = &scripts\aitypes\juggernaut\behaviors::vehicle_occupancy_cp_giveriotshield;
  var0.actionfn[28] = &scripts\aitypes\juggernaut\behaviors::vehicle_occupancy_clearseatcorpse;
  var0.actionfn[29] = &scripts\aitypes\melee::clearmeleeaction;
  var0.actionfn[30] = &scripts\aitypes\melee::domeleeaction;
  var0.actionfn[31] = &scripts\aitypes\melee::initmeleeaction;
  var0.actionfn[32] = &scripts\aitypes\juggernaut\behaviors::juggernaut_shouldmove;
  var0.actionfn[33] = &scripts\aitypes\juggernaut\behaviors::juggernaut_move;
  var0.actionfn[34] = &scripts\aitypes\juggernaut\behaviors::juggernaut_moveinit;
  var0.actionfn[35] = &scripts\aitypes\juggernaut\behaviors::juggernaut_moveterminate;
  var0.actionfn[36] = &scripts\aitypes\soldier_agent\setup::setupagent;
  var0.actionfn[37] = &scripts\aitypes\juggernaut\behaviors::juggernaut_init;
  level._btactions["juggernaut_agent"] = var0;
}

function registerbehaviortree() {
  bindactionscripts();
  btregistertree("juggernaut_agent");
}