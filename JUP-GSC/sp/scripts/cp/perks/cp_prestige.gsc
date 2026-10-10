/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\perks\cp_prestige.gsc
***********************************************/

#using scripts\engine\utility;
#namespace cp_prestige;

function initprestige() {
  nerf_func = [];
  nerf_func["none"] = &empty;
  nerf_func["nerf_take_more_damage"] = &increase_damage_scalar;
  nerf_func["nerf_higher_threatbias"] = &increase_threatbias;
  nerf_func["nerf_smaller_wallet"] = &reduce_wallet_size_and_money_earned;
  nerf_func["nerf_lower_weapon_damage"] = &lower_weapon_damage;
  nerf_func["nerf_no_class"] = &no_class;
  nerf_func["nerf_pistols_only"] = &pistols_only;
  nerf_func["nerf_fragile"] = &slow_health_regen;
  nerf_func["nerf_move_slower"] = &move_slower;
  nerf_func["nerf_no_abilities"] = &no_abilities;
  nerf_func["nerf_min_ammo"] = &min_ammo;
  nerf_func["nerf_no_deployables"] = &no_deployables;
  level.prestige_nerf_func = nerf_func;
  table_list = [];

  for(i = 0; i < 10; i++) {
    var_6e8c4a470d8ac8b5 = tablelookupbyrow("cp/alien/prestige_nerf.csv", i, 1);

    if(!isDefined(var_6e8c4a470d8ac8b5) || var_6e8c4a470d8ac8b5 == "") {
      break;
    }

    table_list[table_list.size] = var_6e8c4a470d8ac8b5;
  }

  level.nerf_list = table_list;
}

function initplayerprestige() {
  init_nerf_scalar();
}

function init_nerf_scalar() {
  nerf_scalars = [];
  nerf_scalars["nerf_take_more_damage"] = 1;
  nerf_scalars["nerf_higher_threatbias"] = 0;
  nerf_scalars["nerf_smaller_wallet"] = 1;
  nerf_scalars["nerf_earn_less_money"] = 1;
  nerf_scalars["nerf_lower_weapon_damage"] = 1;
  nerf_scalars["nerf_no_class"] = 0;
  nerf_scalars["nerf_pistols_only"] = 0;
  nerf_scalars["nerf_fragile"] = 1;
  nerf_scalars["nerf_move_slower"] = 1;
  nerf_scalars["nerf_no_abilities"] = 0;
  nerf_scalars["nerf_min_ammo"] = 1;
  nerf_scalars["nerf_no_deployables"] = 0;
  self.nerf_scalars = nerf_scalars;
  self.activated_nerfs = [];
}

function nerf_based_on_selection() {
  for(var_7851cd80e78da43b = 0; var_7851cd80e78da43b < 10; var_7851cd80e78da43b++) {
    selected_nerf = get_selected_nerf(var_7851cd80e78da43b);
    activate_nerf(selected_nerf);
  }
}

function activate_nerf(reference) {
  if(is_no_nerf(reference)) {
    return;
  }

  if(nerf_already_activated(reference)) {
    return;
  }

  register_nerf_activated(reference);
  [[level.prestige_nerf_func[reference]]]();
}

function nerf_already_activated(reference) {
  return scripts\engine\utility::array_contains(self.activated_nerfs, reference);
}

function register_nerf_activated(reference) {
  self.activated_nerfs[self.activated_nerfs.size] = reference;
}

function reduce_wallet_size_and_money_earned() {
  reduce_wallet_size();
  reduce_money_earned();
}

function is_relics_enabled() {
  return true;
}

function is_no_nerf(reference) {
  return reference == "none";
}

function get_num_nerf_selected() {
  return self.activated_nerfs.size;
}

function empty() {}

function increase_damage_scalar() {
  set_nerf_scalar("nerf_take_more_damage", 1.33);
}

function increase_threatbias() {
  set_nerf_scalar("nerf_higher_threatbias", 500);
}

function reduce_wallet_size() {
  set_nerf_scalar("nerf_smaller_wallet", 0.5);
}

function reduce_money_earned() {
  set_nerf_scalar("nerf_earn_less_money", 0.75);
}

function lower_weapon_damage() {
  set_nerf_scalar("nerf_lower_weapon_damage", 0.66);
}

function no_class() {
  set_nerf_scalar("nerf_no_class", 1);
}

function pistols_only() {
  set_nerf_scalar("nerf_pistols_only", 1);
}

function slow_health_regen() {
  set_nerf_scalar("nerf_fragile", 1.5);
}

function move_slower() {
  set_nerf_scalar("nerf_move_slower", 0.7);
}

function no_abilities() {
  set_nerf_scalar("nerf_no_abilities", 1);
}

function min_ammo() {
  set_nerf_scalar("nerf_min_ammo", 0.25);
}

function no_deployables() {
  set_nerf_scalar("nerf_no_deployables", 1);
}

function set_nerf_scalar(field, value) {
  self.nerf_scalars[field] = value;
}

function get_nerf_scalar(field) {
  return self.nerf_scalars[field];
}

function get_selected_nerf(index) {}

function prestige_getdamagetakenscalar() {
  return get_nerf_scalar("nerf_take_more_damage");
}

function prestige_getthreatbiasscalar() {
  return get_nerf_scalar("nerf_higher_threatbias");
}

function prestige_getwalletsizescalar() {
  return get_nerf_scalar("nerf_smaller_wallet");
}

function prestige_getmoneyearnedscalar() {
  return get_nerf_scalar("nerf_earn_less_money");
}

function prestige_getweapondamagescalar() {
  return get_nerf_scalar("nerf_lower_weapon_damage");
}

function prestige_getnoclassallowed() {
  return get_nerf_scalar("nerf_no_class");
}

function prestige_getpistolsonly() {
  return get_nerf_scalar("nerf_pistols_only");
}

function prestige_getslowhealthregenscalar() {
  return get_nerf_scalar("nerf_fragile");
}

function prestige_getmoveslowscalar() {
  return get_nerf_scalar("nerf_move_slower");
}

function prestige_getnoabilities() {
  return get_nerf_scalar("nerf_no_abilities");
}

function prestige_getminammo() {
  return get_nerf_scalar("nerf_min_ammo");
}

function prestige_getnodeployables() {
  return get_nerf_scalar("nerf_no_deployables");
}