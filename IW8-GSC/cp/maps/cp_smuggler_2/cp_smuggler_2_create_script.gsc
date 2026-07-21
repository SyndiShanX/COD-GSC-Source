/*****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\maps\cp_smuggler_2\cp_smuggler_2_create_script.gsc
*****************************************************************/

main(var_0, var_1) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_2 = spawnStruct();
  scripts\engine\utility::flag_init("_encstr_8A081CD9B3CF16C0FBC75749EDE2897E277A73810ADB451912DB455B704B");
  level thread cs_return_and_wait_for_flag(var_0, var_1, var_2, "_encstr_8A081CD9B3CF16C0FBC75749EDE2897E277A73810ADB451912DB455B704B");

  if(!scripts\cp\cp_create_script_utility::cs_is_starttime())
    scripts\cp\cp_create_script_utility::endcreatescript(var_2);
}

cs_return_and_wait_for_flag(var_0, var_1, var_2, var_3) {
  scripts\cp\cp_create_script_utility::wait_for_cs_flag(var_3);

  if(!isDefined(var_1))
    var_1 = "_encstr_B81904B98E5B";

  scripts\cp\cp_create_script_utility::strike_setup_arrays(var_1);
  scripts\cp\cp_create_script_utility::cs_init_flags(var_2);
  level thread createstructs(var_2, var_1, var_3);
  level thread createtriggers(var_2, var_1, var_3);
  level thread createmodels(var_2, var_1, var_3);

  if(istrue(var_0))
    level thread scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_8A081CD9B3CF16C0FBC75749EDE2897E277A73810ADB451912DB455B704B");
  else
    scripts\cp\cp_create_script_utility::wait_for_flags(var_2, "_encstr_8A081CD9B3CF16C0FBC75749EDE2897E277A73810ADB451912DB455B704B");
}

createstructs(var_0, var_1, var_2) {
  var_3 = spawnStruct();
  var_3.origin = (0, 0, 0);
  scripts\cp\cp_create_script_utility::strike_additem(var_3, var_1, var_2);
  var_0 scripts\engine\utility::ent_flag_set("_encstr_A31214DAFEAE23830EC7C33B1899F260A9C399C9B5E9");
}

createtriggers(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_81121566531189BB21C0F7999368599F604D0335CA43D5");
}

createmodels(var_0, var_1, var_2) {
  var_0 scripts\engine\utility::ent_flag_set("_encstr_B8AD136F675919C8DCE748A30183904103A3EBD9D7");
}