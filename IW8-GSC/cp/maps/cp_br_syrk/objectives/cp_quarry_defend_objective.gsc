/************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_br_syrk\objectives\cp_quarry_defend_objective.gsc
************************************************************************/

registerquarryobjectives() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  scripts\engine\utility::flag_wait("_encstr_B4E91970C2E3CDCA9999392B85B89F399C6358CB48C3E34A62453B");
  scripts\cp\cp_objectives::registerobjective("_encstr_B66D102EEA2CE4C92FEB91B29956B98CAF4C", undefined, ::startquarrydef1, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_B46D10038B37957B37E9D4394BDA58096F0F", undefined, ::startquarrydef2, undefined);
  scripts\cp\cp_objectives::registerobjective("_encstr_956D10734782AE08D971211927ADA0ED1936", undefined, ::startquarrydef3, undefined);
  initobjspawners();
}

initobjspawners() {
  var_0 = scripts\cp\cp_modular_spawning::registerambientgroup;
  [[var_0]]("_encstr_92FD154B30094B4580BF79E2230E2B03B95F8A6775F8BF", 10, 10, 10, 0.5, ::wait_for_all_group_dead, "_encstr_87C90D0F2377E3B2705EB7FF5169B9", undefined, ::getnextquarrydefensespawnmodule, undefined);
  [[var_0]]("_encstr_82FD1503BBA7D382E897545D8DB18AA3DF936ACAE3061A", 10, 10, 10, 0.5, ::wait_for_all_group_dead, "_encstr_81C90D0AFB58226BFBFFABA7E5B037", undefined, ::getnextquarrydefensespawnmodule, undefined);
  [[var_0]]("_encstr_BDFD1587632ADD7B495723308B579311F20BF0053AA3E7", 10, 10, 10, 0.5, ::wait_for_all_group_dead, "_encstr_88C90D17BA0B93935ED7C82B667D66", undefined, ::getnextquarrydefensespawnmodule, undefined);
}

waitforallplayersnearpoint(var_0, var_1) {
  var_2 = 0;

  while(!var_2) {
    var_2 = 1;

    foreach(var_4 in level.players) {
      if(distance(var_4.origin, var_0) > 100) {
        var_2 = 0;
        continue;
      }
    }

    wait 0.5;
  }
}

startquarrydef1(var_0, var_1) {
  waitforallplayersnearpoint(var_0.iconpos[0], 100);
  level.activequarrydefense = 1;
  iprintlnbold("_encstr_8C3818E5AD53610DCFDE40A8A2F6EBBBA74206F340B3684B3583");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_92FD154B30094B4580BF79E2230E2B03B95F8A6775F8BF");
  wait 20;
  level.activequarrydefense = undefined;
}

startquarrydef2(var_0, var_1) {
  waitforallplayersnearpoint(var_0.iconpos[0], 100);
  level.activequarrydefense = 2;
  iprintlnbold("_encstr_8C3818E5AD53610DCFDE40A8A2F6EBBBA74206F340B3684B3583");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_82FD1503BBA7D382E897545D8DB18AA3DF936ACAE3061A");
  wait 20;
  level.activequarrydefense = undefined;
}

startquarrydef3(var_0, var_1) {
  waitforallplayersnearpoint(var_0.iconpos[0], 100);
  level.activequarrydefense = 3;
  iprintlnbold("_encstr_8C3818E5AD53610DCFDE40A8A2F6EBBBA74206F340B3684B3583");
  thread scripts\cp\cp_modular_spawning::run_spawn_module("_encstr_BDFD1587632ADD7B495723308B579311F20BF0053AA3E7");
  wait 20;
  level.activequarrydefense = undefined;
}

getnextquarrydefensespawnmodule(var_0) {
  if(!isDefined(level.activequarrydefense)) {
    return;
  }
  var_1 = undefined;

  switch (level.activequarrydefense) {
    case 1:
      var_1 = "_encstr_92FD154B30094B4580BF79E2230E2B03B95F8A6775F8BF";
      break;
    case 2:
      var_1 = "_encstr_82FD1503BBA7D382E897545D8DB18AA3DF936ACAE3061A";
      break;
    case 3:
      var_1 = "_encstr_BDFD1587632ADD7B495723308B579311F20BF0053AA3E7";
      break;
    default:
      var_1 = undefined;
      break;
  }

  return var_1;
}

wait_for_all_group_dead(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1))
    var_0 scripts\engine\utility::_id_143B9(var_1, "_encstr_AA5E19F7B6605F9A3FE0737AD88514FBD9887B6741EB63E741B83A");
  else
    var_0 waittill("_encstr_AA5E19F7B6605F9A3FE0737AD88514FBD9887B6741EB63E741B83A");
}