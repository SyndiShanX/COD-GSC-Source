/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_prestige.gsc
***************************************/

CONST_MAX_NUM_PRESTIGE_NERF = 32;

CONST_NERF_TABLE = "mp/alien/prestige_nerf.csv";
CONST_NERF_TABLE_IDX_COLUMN = 0;
CONST_NERF_TABLE_REF_COLUMN = 1;

CONST_NERF_SCALAR_DAMAGE_TAKEN = 1.33;
CONST_NERF_SCALAR_THREATBIAS = 500;
CONST_NERF_SCALAR_WALLET_SIZE = 0.5;
CONST_NERF_SCALAR_EARN_LESS_MONEY = 0.75;
CONST_NERF_SCALAR_WEAPON_DAMAGE = 0.66;
CONST_NERF_NO_CLASS_ALLOWED = 1.0;
CONST_NERF_PISTOLS_ONLY = 1.0;
CONST_NERF_SCALAR_HEALTH_REGEN = 1.5;
CONST_NERF_SCALAR_MOVE_SLOWER = 0.7;
CONST_NERF_NO_ABILITIES = 1.0;
CONST_NERF_SCALAR_MIN_AMMO = 0.25;
CONST_NERF_NO_DEPLOYABLES = 1.0;

CONST_REF_NO_NERF = "none";
CONST_REF_TAKE_MORE_DAMAGE = "nerf_take_more_damage";
CONST_REF_HIGHER_THREATBIAS = "nerf_higher_threatbias";
CONST_REF_SMALLER_WALLET = "nerf_smaller_wallet";
CONST_REF_EARN_LESS_MONEY = "nerf_earn_less_money";
CONST_REF_LOWER_WEAPON_DAMAGE = "nerf_lower_weapon_damage";
CONST_REF_NO_CLASS_ALLOWED = "nerf_no_class";
CONST_REF_PISTOLS_ONLY = "nerf_pistols_only";
CONST_REF_SLOW_HEALTH_REGEN = "nerf_fragile";
CONST_REF_MOVE_SLOWER = "nerf_move_slower";
CONST_REF_NO_ABILITIES = "nerf_no_abilities";
CONST_REF_MIN_AMMO = "nerf_min_ammo";
CONST_REF_NO_DEPLOYABLES = "nerf_no_deployables";

init_prestige() {
  nerf_func = [];

  nerf_func[CONST_REF_NO_NERF] = ::empty;
  nerf_func[CONST_REF_TAKE_MORE_DAMAGE] = ::increase_damage_scalar;
  nerf_func[CONST_REF_HIGHER_THREATBIAS] = ::increase_threatbias;
  nerf_func[CONST_REF_SMALLER_WALLET] = ::reduce_wallet_size_and_money_earned;
  nerf_func[CONST_REF_LOWER_WEAPON_DAMAGE] = ::lower_weapon_damage;
  nerf_func[CONST_REF_NO_CLASS_ALLOWED] = ::no_class;
  nerf_func[CONST_REF_PISTOLS_ONLY] = ::pistols_only;
  nerf_func[CONST_REF_SLOW_HEALTH_REGEN] = ::slow_health_regen;
  nerf_func[CONST_REF_MOVE_SLOWER] = ::move_slower;
  nerf_func[CONST_REF_NO_ABILITIES] = ::no_abilities;
  nerf_func[CONST_REF_MIN_AMMO] = ::min_ammo;
  nerf_func[CONST_REF_NO_DEPLOYABLES] = ::no_deployables;

  level.prestige_nerf_func = nerf_func;

  table_list = [];

  for(i = 0; i < CONST_MAX_NUM_PRESTIGE_NERF; i++) {
    nerfRef = TableLookupByRow(CONST_NERF_TABLE, i, CONST_NERF_TABLE_REF_COLUMN);

    if(!isDefined(nerfRef) || nerfRef == "") {
      break;
    }

    table_list[table_list.size] = nerfRef;
  }

  level.nerf_list = table_list;
}

init_player_prestige() {
  init_nerf_scalar();

  if(is_relics_enabled()) {
    nerf_based_on_selection();
  }
}

init_nerf_scalar() {
  nerf_scalars = [];

  nerf_scalars[CONST_REF_TAKE_MORE_DAMAGE] = 1.0;
  nerf_scalars[CONST_REF_HIGHER_THREATBIAS] = 0;
  nerf_scalars[CONST_REF_SMALLER_WALLET] = 1.0;
  nerf_scalars[CONST_REF_EARN_LESS_MONEY] = 1.0;
  nerf_scalars[CONST_REF_LOWER_WEAPON_DAMAGE] = 1.0;
  nerf_scalars[CONST_REF_NO_CLASS_ALLOWED] = 0;
  nerf_scalars[CONST_REF_PISTOLS_ONLY] = 0;
  nerf_scalars[CONST_REF_SLOW_HEALTH_REGEN] = 1.0;
  nerf_scalars[CONST_REF_MOVE_SLOWER] = 1.0;
  nerf_scalars[CONST_REF_NO_ABILITIES] = 0;
  nerf_scalars[CONST_REF_MIN_AMMO] = 1.0;
  nerf_scalars[CONST_REF_NO_DEPLOYABLES] = 0;

  self.nerf_scalars = nerf_scalars;
  self.activated_nerfs = [];
}

nerf_based_on_selection() {
  foreach(nerf in level.nerf_list) {
    if(self alienscheckisrelicenabled(nerf)) {
      activate_nerf(nerf);
    }
  }
}

activate_nerf(reference) {
  register_nerf_activated(reference);

  [[level.prestige_nerf_func[reference]]]();
}

nerf_already_activated(reference) {
  return common_scripts\utility::array_contains(self.activated_nerfs, reference);
}

register_nerf_activated(reference) {
  self.activated_nerfs[self.activated_nerfs.size] = reference;
}

reduce_wallet_size_and_money_earned() {
  reduce_wallet_size();

  reduce_money_earned();
}

is_relics_enabled() {
  if(maps\mp\alien\_utility::is_chaos_mode()) {
    return false;
  }

  return true;
}

is_no_nerf(reference) {
  return reference == "none";
}
get_num_nerf_selected() {
  return self.activated_nerfs.size;
}

empty() {}
increase_damage_scalar() {
  set_nerf_scalar(CONST_REF_TAKE_MORE_DAMAGE, CONST_NERF_SCALAR_DAMAGE_TAKEN);
}
increase_threatbias() {
  set_nerf_scalar(CONST_REF_HIGHER_THREATBIAS, CONST_NERF_SCALAR_THREATBIAS);
}
reduce_wallet_size() {
  set_nerf_scalar(CONST_REF_SMALLER_WALLET, CONST_NERF_SCALAR_WALLET_SIZE);
}
reduce_money_earned() {
  set_nerf_scalar(CONST_REF_EARN_LESS_MONEY, CONST_NERF_SCALAR_EARN_LESS_MONEY);
}
lower_weapon_damage() {
  set_nerf_scalar(CONST_REF_LOWER_WEAPON_DAMAGE, CONST_NERF_SCALAR_WEAPON_DAMAGE);
}
no_class() {
  set_nerf_scalar(CONST_REF_NO_CLASS_ALLOWED, CONST_NERF_NO_CLASS_ALLOWED);
}
pistols_only() {
  set_nerf_scalar(CONST_REF_PISTOLS_ONLY, CONST_NERF_PISTOLS_ONLY);
}
slow_health_regen() {
  set_nerf_scalar(CONST_REF_SLOW_HEALTH_REGEN, CONST_NERF_SCALAR_HEALTH_REGEN);
}
move_slower() {
  set_nerf_scalar(CONST_REF_MOVE_SLOWER, CONST_NERF_SCALAR_MOVE_SLOWER);
}
no_abilities() {
  set_nerf_scalar(CONST_REF_NO_ABILITIES, CONST_NERF_NO_ABILITIES);
}
min_ammo() {
  set_nerf_scalar(CONST_REF_MIN_AMMO, CONST_NERF_SCALAR_MIN_AMMO);
}
no_deployables() {
  set_nerf_scalar(CONST_REF_NO_DEPLOYABLES, CONST_NERF_NO_DEPLOYABLES);
}

set_nerf_scalar(field, value) {
  self.nerf_scalars[field] = value;
}
get_nerf_scalar(field) {
  return self.nerf_scalars[field];
}
get_selected_nerf(index) {
  return self getcoopplayerdata("alienPlayerLoadout", "nerfs", index);
}

prestige_getDamageTakenScalar() {
  return get_nerf_scalar(CONST_REF_TAKE_MORE_DAMAGE);
}
prestige_getThreatbiasScalar() {
  return get_nerf_scalar(CONST_REF_HIGHER_THREATBIAS);
}
prestige_getWalletSizeScalar() {
  return get_nerf_scalar(CONST_REF_SMALLER_WALLET);
}
prestige_getMoneyEarnedScalar() {
  return get_nerf_scalar(CONST_REF_EARN_LESS_MONEY);
}
prestige_getWeaponDamageScalar() {
  return get_nerf_scalar(CONST_REF_LOWER_WEAPON_DAMAGE);
}
prestige_getNoClassAllowed() {
  return get_nerf_scalar(CONST_REF_NO_CLASS_ALLOWED);
}
prestige_getPistolsOnly() {
  return get_nerf_scalar(CONST_REF_PISTOLS_ONLY);
}
prestige_getSlowHealthRegenScalar() {
  return get_nerf_scalar(CONST_REF_SLOW_HEALTH_REGEN);
}
prestige_getMoveSlowScalar() {
  return get_nerf_scalar(CONST_REF_MOVE_SLOWER);
}
prestige_getNoAbilities() {
  return get_nerf_scalar(CONST_REF_NO_ABILITIES);
}
prestige_getMinAmmo() {
  return get_nerf_scalar(CONST_REF_MIN_AMMO);
}
prestige_getNoDeployables() {
  return get_nerf_scalar(CONST_REF_NO_DEPLOYABLES);
}