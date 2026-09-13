/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\perks\cp_prestige.gsc
***********************************************/

initprestige() {
  _id_45BFA5617A4F3EB7 = [];
  _id_45BFA5617A4F3EB7["none"] = ::empty;
  _id_45BFA5617A4F3EB7["nerf_take_more_damage"] = ::increase_damage_scalar;
  _id_45BFA5617A4F3EB7["nerf_higher_threatbias"] = ::increase_threatbias;
  _id_45BFA5617A4F3EB7["nerf_smaller_wallet"] = ::reduce_wallet_size_and_money_earned;
  _id_45BFA5617A4F3EB7["nerf_lower_weapon_damage"] = ::lower_weapon_damage;
  _id_45BFA5617A4F3EB7["nerf_no_class"] = ::no_class;
  _id_45BFA5617A4F3EB7["nerf_pistols_only"] = ::pistols_only;
  _id_45BFA5617A4F3EB7["nerf_fragile"] = ::slow_health_regen;
  _id_45BFA5617A4F3EB7["nerf_move_slower"] = ::move_slower;
  _id_45BFA5617A4F3EB7["nerf_no_abilities"] = ::no_abilities;
  _id_45BFA5617A4F3EB7["nerf_min_ammo"] = ::min_ammo;
  _id_45BFA5617A4F3EB7["nerf_no_deployables"] = ::no_deployables;
  level.prestige_nerf_func = _id_45BFA5617A4F3EB7;
  _id_8E93036AB1BE43A4 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 10; _id_AC0E594AC96AA3A8++) {
    _id_6E8C4A470D8AC8B5 = tablelookupbyrow("cp/alien/prestige_nerf.csv", _id_AC0E594AC96AA3A8, 1);

    if(!isDefined(_id_6E8C4A470D8AC8B5) || _id_6E8C4A470D8AC8B5 == "") {
      break;
    }

    _id_8E93036AB1BE43A4[_id_8E93036AB1BE43A4.size] = _id_6E8C4A470D8AC8B5;
  }

  level.nerf_list = _id_8E93036AB1BE43A4;
}

initplayerprestige() {
  init_nerf_scalar();
}

init_nerf_scalar() {
  nerf_scalars = [];
  nerf_scalars["nerf_take_more_damage"] = 1.0;
  nerf_scalars["nerf_higher_threatbias"] = 0;
  nerf_scalars["nerf_smaller_wallet"] = 1.0;
  nerf_scalars["nerf_earn_less_money"] = 1.0;
  nerf_scalars["nerf_lower_weapon_damage"] = 1.0;
  nerf_scalars["nerf_no_class"] = 0;
  nerf_scalars["nerf_pistols_only"] = 0;
  nerf_scalars["nerf_fragile"] = 1.0;
  nerf_scalars["nerf_move_slower"] = 1.0;
  nerf_scalars["nerf_no_abilities"] = 0;
  nerf_scalars["nerf_min_ammo"] = 1.0;
  nerf_scalars["nerf_no_deployables"] = 0;
  self.nerf_scalars = nerf_scalars;
  self.activated_nerfs = [];
}

nerf_based_on_selection() {
  for(_id_7851CD80E78DA43B = 0; _id_7851CD80E78DA43B < 10; _id_7851CD80E78DA43B++) {
    _id_0F54DDBF646676FC = get_selected_nerf(_id_7851CD80E78DA43B);
    activate_nerf(_id_0F54DDBF646676FC);
  }
}

activate_nerf(_id_D79CAAB4489A152E) {
  if(is_no_nerf(_id_D79CAAB4489A152E)) {
    return;
  }
  if(nerf_already_activated(_id_D79CAAB4489A152E)) {
    return;
  }
  register_nerf_activated(_id_D79CAAB4489A152E);
  [[level.prestige_nerf_func[_id_D79CAAB4489A152E]]]();
}

nerf_already_activated(_id_D79CAAB4489A152E) {
  return scripts\engine\utility::array_contains(self.activated_nerfs, _id_D79CAAB4489A152E);
}

register_nerf_activated(_id_D79CAAB4489A152E) {
  self.activated_nerfs[self.activated_nerfs.size] = _id_D79CAAB4489A152E;
}

reduce_wallet_size_and_money_earned() {
  reduce_wallet_size();
  reduce_money_earned();
}

is_relics_enabled() {
  return 1;
}

is_no_nerf(_id_D79CAAB4489A152E) {
  return _id_D79CAAB4489A152E == "none";
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
  set_nerf_scalar("nerf_no_class", 1.0);
}

pistols_only() {
  set_nerf_scalar("nerf_pistols_only", 1.0);
}

slow_health_regen() {
  set_nerf_scalar("nerf_fragile", 1.5);
}

move_slower() {
  set_nerf_scalar("nerf_move_slower", 0.7);
}

no_abilities() {
  set_nerf_scalar("nerf_no_abilities", 1.0);
}

min_ammo() {
  set_nerf_scalar("nerf_min_ammo", 0.25);
}

no_deployables() {
  set_nerf_scalar("nerf_no_deployables", 1.0);
}

set_nerf_scalar(_id_BC35CB5830C7F81B, value) {
  self.nerf_scalars[_id_BC35CB5830C7F81B] = value;
}

get_nerf_scalar(_id_BC35CB5830C7F81B) {
  return self.nerf_scalars[_id_BC35CB5830C7F81B];
}

get_selected_nerf(index) {}

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