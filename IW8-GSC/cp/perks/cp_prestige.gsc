/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\perks\cp_prestige.gsc
***********************************************/

initprestige() {
  var_0 = [];
  var_0["_encstr_8BBA05185F8B99"] = ::empty;
  var_0["_encstr_AC9A16265FF83320C3F19843518D58DA41B1FF0217D7F85F"] = ::increase_damage_scalar;
  var_0["_encstr_B1561795DF6B7CA9300489602FF271AD227B0B1333D2B31043"] = ::increase_threatbias;
  var_0["_encstr_935E1473592799EBDC6BB08D8D59C9BEDDB03663591D"] = ::reduce_wallet_size_and_money_earned;
  var_0["_encstr_8A6E1937CA27CC7DD8EDBB2B93D7DDCA2C0EDE73F5460BB52C76B2"] = ::lower_weapon_damage;
  var_0["_encstr_8C4A0E3A71E67B31982FA763D118C2E7"] = ::no_class;
  var_0["_encstr_9335129AD1461B510843EBD477D062B760283293"] = ::pistols_only;
  var_0["_encstr_A9500D37CA3999D7CC932CD92DC62B"] = ::slow_health_regen;
  var_0["_encstr_AF0811F86F4A089092F7BD931F5B41F8E7C7E3"] = ::move_slower;
  var_0["_encstr_8A18124A804D3FDF5020CFE94E58DB04B9086213"] = ::no_abilities;
  var_0["_encstr_85F50EA8C7BB557EFD2FF081F705F08F"] = ::min_ammo;
  var_0["_encstr_8F8A14BD0503FA19C6FF4FC4CA4A0CF7C38A4AB3256B"] = ::no_deployables;
  level.prestige_nerf_func = var_0;
  var_1 = [];

  for(var_2 = 0; var_2 < 10; var_2++) {
    var_3 = tablelookupbyrow("_encstr_A6F91B92F8BF826B183F90B0DB13C5433D40845F5FFB8D932A3E2EE33C", var_2, 1);

    if(!isDefined(var_3) || var_3 == "_encstr_B40101") {
      break;
    }

    var_1[var_1.size] = var_3;
  }

  level.nerf_list = var_1;
}

initplayerprestige() {
  init_nerf_scalar();
}

init_nerf_scalar() {
  var_0 = [];
  var_0["_encstr_AC9A16265FF83320C3F19843518D58DA41B1FF0217D7F85F"] = 1.0;
  var_0["_encstr_B1561795DF6B7CA9300489602FF271AD227B0B1333D2B31043"] = 0;
  var_0["_encstr_935E1473592799EBDC6BB08D8D59C9BEDDB03663591D"] = 1.0;
  var_0["_encstr_9BC915EB2F082C71679918488114031733378037BA8AE1"] = 1.0;
  var_0["_encstr_8A6E1937CA27CC7DD8EDBB2B93D7DDCA2C0EDE73F5460BB52C76B2"] = 1.0;
  var_0["_encstr_8C4A0E3A71E67B31982FA763D118C2E7"] = 0;
  var_0["_encstr_9335129AD1461B510843EBD477D062B760283293"] = 0;
  var_0["_encstr_A9500D37CA3999D7CC932CD92DC62B"] = 1.0;
  var_0["_encstr_AF0811F86F4A089092F7BD931F5B41F8E7C7E3"] = 1.0;
  var_0["_encstr_8A18124A804D3FDF5020CFE94E58DB04B9086213"] = 0;
  var_0["_encstr_85F50EA8C7BB557EFD2FF081F705F08F"] = 1.0;
  var_0["_encstr_8F8A14BD0503FA19C6FF4FC4CA4A0CF7C38A4AB3256B"] = 0;
  self.nerf_scalars = var_0;
  self.activated_nerfs = [];
}

nerf_based_on_selection() {
  for(var_0 = 0; var_0 < 10; var_0++) {
    var_1 = get_selected_nerf(var_0);
    activate_nerf(var_1);
  }
}

activate_nerf(var_0) {
  if(is_no_nerf(var_0)) {
    return;
  }
  if(nerf_already_activated(var_0)) {
    return;
  }
  register_nerf_activated(var_0);
  [[level.prestige_nerf_func[var_0]]]();
}

nerf_already_activated(var_0) {
  return scripts\engine\utility::array_contains(self.activated_nerfs, var_0);
}

register_nerf_activated(var_0) {
  self.activated_nerfs[self.activated_nerfs.size] = var_0;
}

reduce_wallet_size_and_money_earned() {
  reduce_wallet_size();
  reduce_money_earned();
}

is_relics_enabled() {
  return 1;
}

is_no_nerf(var_0) {
  return var_0 == "_encstr_8BBA05185F8B99";
}

get_num_nerf_selected() {
  return self.activated_nerfs.size;
}

empty() {}

increase_damage_scalar() {
  set_nerf_scalar("_encstr_AC9A16265FF83320C3F19843518D58DA41B1FF0217D7F85F", 1.33);
}

increase_threatbias() {
  set_nerf_scalar("_encstr_B1561795DF6B7CA9300489602FF271AD227B0B1333D2B31043", 500);
}

reduce_wallet_size() {
  set_nerf_scalar("_encstr_935E1473592799EBDC6BB08D8D59C9BEDDB03663591D", 0.5);
}

reduce_money_earned() {
  set_nerf_scalar("_encstr_9BC915EB2F082C71679918488114031733378037BA8AE1", 0.75);
}

lower_weapon_damage() {
  set_nerf_scalar("_encstr_8A6E1937CA27CC7DD8EDBB2B93D7DDCA2C0EDE73F5460BB52C76B2", 0.66);
}

no_class() {
  set_nerf_scalar("_encstr_8C4A0E3A71E67B31982FA763D118C2E7", 1.0);
}

pistols_only() {
  set_nerf_scalar("_encstr_9335129AD1461B510843EBD477D062B760283293", 1.0);
}

slow_health_regen() {
  set_nerf_scalar("_encstr_A9500D37CA3999D7CC932CD92DC62B", 1.5);
}

move_slower() {
  set_nerf_scalar("_encstr_AF0811F86F4A089092F7BD931F5B41F8E7C7E3", 0.7);
}

no_abilities() {
  set_nerf_scalar("_encstr_8A18124A804D3FDF5020CFE94E58DB04B9086213", 1.0);
}

min_ammo() {
  set_nerf_scalar("_encstr_85F50EA8C7BB557EFD2FF081F705F08F", 0.25);
}

no_deployables() {
  set_nerf_scalar("_encstr_8F8A14BD0503FA19C6FF4FC4CA4A0CF7C38A4AB3256B", 1.0);
}

set_nerf_scalar(var_0, var_1) {
  self.nerf_scalars[var_0] = var_1;
}

get_nerf_scalar(var_0) {
  return self.nerf_scalars[var_0];
}

get_selected_nerf(var_0) {}

prestige_getdamagetakenscalar() {
  return get_nerf_scalar("_encstr_AC9A16265FF83320C3F19843518D58DA41B1FF0217D7F85F");
}

prestige_getthreatbiasscalar() {
  return get_nerf_scalar("_encstr_B1561795DF6B7CA9300489602FF271AD227B0B1333D2B31043");
}

prestige_getwalletsizescalar() {
  return get_nerf_scalar("_encstr_935E1473592799EBDC6BB08D8D59C9BEDDB03663591D");
}

prestige_getmoneyearnedscalar() {
  return get_nerf_scalar("_encstr_9BC915EB2F082C71679918488114031733378037BA8AE1");
}

prestige_getweapondamagescalar() {
  return get_nerf_scalar("_encstr_8A6E1937CA27CC7DD8EDBB2B93D7DDCA2C0EDE73F5460BB52C76B2");
}

prestige_getnoclassallowed() {
  return get_nerf_scalar("_encstr_8C4A0E3A71E67B31982FA763D118C2E7");
}

prestige_getpistolsonly() {
  return get_nerf_scalar("_encstr_9335129AD1461B510843EBD477D062B760283293");
}

prestige_getslowhealthregenscalar() {
  return get_nerf_scalar("_encstr_A9500D37CA3999D7CC932CD92DC62B");
}

prestige_getmoveslowscalar() {
  return get_nerf_scalar("_encstr_AF0811F86F4A089092F7BD931F5B41F8E7C7E3");
}

prestige_getnoabilities() {
  return get_nerf_scalar("_encstr_8A18124A804D3FDF5020CFE94E58DB04B9086213");
}

prestige_getminammo() {
  return get_nerf_scalar("_encstr_85F50EA8C7BB557EFD2FF081F705F08F");
}

prestige_getnodeployables() {
  return get_nerf_scalar("_encstr_8F8A14BD0503FA19C6FF4FC4CA4A0CF7C38A4AB3256B");
}