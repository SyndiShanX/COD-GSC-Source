/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3327.gsc
************************/

initprestige() {
  var_00 = [];
  var_00["none"] = ::empty;
  var_00["nerf_take_more_damage"] = ::increase_damage_scalar;
  var_00["nerf_higher_threatbias"] = ::increase_threatbias;
  var_00["nerf_smaller_wallet"] = ::reduce_wallet_size_and_money_earned;
  var_00["nerf_lower_weapon_damage"] = ::lower_weapon_damage;
  var_00["nerf_no_class"] = ::no_class;
  var_00["nerf_pistols_only"] = ::pistols_only;
  var_00["nerf_fragile"] = ::slow_health_regen;
  var_00["nerf_move_slower"] = ::move_slower;
  var_00["nerf_no_abilities"] = ::no_abilities;
  var_00["nerf_min_ammo"] = ::min_ammo;
  var_00["nerf_no_deployables"] = ::no_deployables;
  level.prestige_nerf_func = var_00;
  var_01 = [];
  for(var_02 = 0; var_02 < 10; var_02++) {
    var_03 = tablelookupbyrow("cp\alien\prestige_nerf.csv", var_02, 1);
    if(!isDefined(var_03) || var_03 == "") {
      break;
    }

    var_01[var_01.size] = var_03;
  }

  level.nerf_list = var_01;
}

initplayerprestige() {
  init_nerf_scalar();
}

init_nerf_scalar() {
  var_00 = [];
  var_00["nerf_take_more_damage"] = 1;
  var_00["nerf_higher_threatbias"] = 0;
  var_00["nerf_smaller_wallet"] = 1;
  var_00["nerf_earn_less_money"] = 1;
  var_00["nerf_lower_weapon_damage"] = 1;
  var_00["nerf_no_class"] = 0;
  var_00["nerf_pistols_only"] = 0;
  var_00["nerf_fragile"] = 1;
  var_00["nerf_move_slower"] = 1;
  var_00["nerf_no_abilities"] = 0;
  var_00["nerf_min_ammo"] = 1;
  var_00["nerf_no_deployables"] = 0;
  self.nerf_scalars = var_00;
  self.activated_nerfs = [];
}

nerf_based_on_selection() {
  for(var_00 = 0; var_00 < 10; var_00++) {
    var_01 = get_selected_nerf(var_00);
    activate_nerf(var_01);
  }
}

activate_nerf(param_00) {
  if(is_no_nerf(param_00)) {
    return;
  }

  if(nerf_already_activated(param_00)) {
    return;
  }

  register_nerf_activated(param_00);
  [[level.prestige_nerf_func[param_00]]]();
}

nerf_already_activated(param_00) {
  return scripts\engine\utility::array_contains(self.activated_nerfs, param_00);
}

register_nerf_activated(param_00) {
  self.activated_nerfs[self.activated_nerfs.size] = param_00;
}

reduce_wallet_size_and_money_earned() {
  reduce_wallet_size();
  reduce_money_earned();
}

is_relics_enabled() {
  return 1;
}

is_no_nerf(param_00) {
  return param_00 == "none";
}

get_num_nerf_selected() {
  return self.activated_nerfs.size;
}

empty() {}

increase_damage_scalar() {
  set_nerf_scalar("nerf_take_more_damage", 1.33);
}

increase_threatbias() {
  set_nerf_scalar("nerf_higher_threatbias", 500);
}

reduce_wallet_size() {
  set_nerf_scalar("nerf_smaller_wallet", 0.5);
}

reduce_money_earned() {
  set_nerf_scalar("nerf_earn_less_money", 0.75);
}

lower_weapon_damage() {
  set_nerf_scalar("nerf_lower_weapon_damage", 0.66);
}

no_class() {
  set_nerf_scalar("nerf_no_class", 1);
}

pistols_only() {
  set_nerf_scalar("nerf_pistols_only", 1);
}

slow_health_regen() {
  set_nerf_scalar("nerf_fragile", 1.5);
}

move_slower() {
  set_nerf_scalar("nerf_move_slower", 0.7);
}

no_abilities() {
  set_nerf_scalar("nerf_no_abilities", 1);
}

min_ammo() {
  set_nerf_scalar("nerf_min_ammo", 0.25);
}

no_deployables() {
  set_nerf_scalar("nerf_no_deployables", 1);
}

set_nerf_scalar(param_00, param_01) {
  self.nerf_scalars[param_00] = param_01;
}

get_nerf_scalar(param_00) {
  return self.nerf_scalars[param_00];
}

get_selected_nerf(param_00) {}

prestige_getdamagetakenscalar() {
  return get_nerf_scalar("nerf_take_more_damage");
}

prestige_getthreatbiasscalar() {
  return get_nerf_scalar("nerf_higher_threatbias");
}

prestige_getwalletsizescalar() {
  return get_nerf_scalar("nerf_smaller_wallet");
}

prestige_getmoneyearnedscalar() {
  return get_nerf_scalar("nerf_earn_less_money");
}

prestige_getweapondamagescalar() {
  return get_nerf_scalar("nerf_lower_weapon_damage");
}

prestige_getnoclassallowed() {
  return get_nerf_scalar("nerf_no_class");
}

prestige_getpistolsonly() {
  return get_nerf_scalar("nerf_pistols_only");
}

prestige_getslowhealthregenscalar() {
  return get_nerf_scalar("nerf_fragile");
}

prestige_getmoveslowscalar() {
  return get_nerf_scalar("nerf_move_slower");
}

prestige_getnoabilities() {
  return get_nerf_scalar("nerf_no_abilities");
}

prestige_getminammo() {
  return get_nerf_scalar("nerf_min_ammo");
}

prestige_getnodeployables() {
  return get_nerf_scalar("nerf_no_deployables");
}