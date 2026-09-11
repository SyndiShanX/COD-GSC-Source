/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\perks\cp_prestige.gsc
***********************************************/

function initprestige() {
  var0 = [];
  GscBinSkip0(0x2e, "none", &empty);
}

function initplayerprestige() {
  init_nerf_scalar();
}

function init_nerf_scalar() {
  var0 = [];
  GscBinSkip0(0x2e, "nerf_take_more_damage", 1);
}

function nerf_based_on_selection() {
  for(var0 = 0; var0 < 10; var0++) {
    var1 = get_selected_nerf(var0);
    activate_nerf(var1);
  }
}

function activate_nerf(var0) {
  if(is_no_nerf(var0)) {
    return;
  }

  if(nerf_already_activated(var0)) {
    return;
  }

  register_nerf_activated(var0);
  [[level.prestige_nerf_func[var0]]]();
}

function nerf_already_activated(var0) {
  return scripts\engine\utility::array_contains(self.activated_nerfs, var0);
}

function register_nerf_activated(var0) {
  self.activated_nerfs[self.activated_nerfs.size] = var0;
}

function reduce_wallet_size_and_money_earned() {
  reduce_wallet_size();
  reduce_money_earned();
}

function is_relics_enabled() {
  return true;
}

function is_no_nerf(var0) {
  return var0 == "none";
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

function set_nerf_scalar(var0, var1) {
  self.nerf_scalars[var0] = var1;
}

function get_nerf_scalar(var0) {
  return self.nerf_scalars[var0];
}

function get_selected_nerf(var0) {}

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