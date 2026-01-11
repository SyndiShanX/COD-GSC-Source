/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\alien\_perkfunctions.gsc
********************************************/

#include maps\mp\_utility;
#include maps\mp\alien\_utility;
#include maps\mp\alien\_perk_utility;

init_perk_none() {
  perk_data = spawnStruct();
  return perk_data;
}

DEFAULT_MAX_HEALTH = 100;
LEVEL_0_MAX_HEALTH = 125;
LEVEL_1_MAX_HEALTH = 125;
LEVEL_2_MAX_HEALTH = 150;
LEVEL_3_MAX_HEALTH = 175;
LEVEL_4_MAX_HEALTH = 200;

DEFAULT_MELEE_SCALAR = 1.0;
LEVEL_1_MELEE_SCALAR = 1.25;
LEVEL_3_MELEE_SCALAR = 1.5;
LEVEL_4_MELEE_SCALAR = 2.0;

init_perk_health() {
  perk_data = spawnStruct();

  perk_data.melee_scalar = DEFAULT_MELEE_SCALAR;

  return perk_data;
}

set_perk_health_level_0() {
  self.perk_data["health"].max_health = LEVEL_0_MAX_HEALTH;
  self.perk_data["health"].melee_scalar = DEFAULT_MELEE_SCALAR;
}

unset_perk_health_level_0() {
  self.perk_data["health"].melee_scalar = DEFAULT_MELEE_SCALAR;
}

set_perk_health_level_1() {
  self.perk_data["health"].max_health = LEVEL_1_MAX_HEALTH;
  self.maxhealth = self.perk_data["health"].max_health;
  self notify("health_perk_upgrade");
  self.perk_data["health"].melee_scalar = LEVEL_1_MELEE_SCALAR;
}

unset_perk_health_level_1() {
  self.perk_data["health"].melee_scalar = DEFAULT_MELEE_SCALAR;
}

set_perk_health_level_2() {
  self.perk_data["health"].max_health = LEVEL_2_MAX_HEALTH;
  self.maxhealth = self.perk_data["health"].max_health;
  self notify("health_perk_upgrade");
  self.perk_data["health"].melee_scalar = LEVEL_1_MELEE_SCALAR;
}

unset_perk_health_level_2() {
  self.perk_data["health"].melee_scalar = DEFAULT_MELEE_SCALAR;
}

set_perk_health_level_3() {
  self.perk_data["health"].max_health = LEVEL_3_MAX_HEALTH;
  self.maxhealth = self.perk_data["health"].max_health;
  self notify("health_perk_upgrade");
  self.perk_data["health"].melee_scalar = LEVEL_3_MELEE_SCALAR;
}

unset_perk_health_level_3() {
  self.perk_data["health"].melee_scalar = DEFAULT_MELEE_SCALAR;
}

set_perk_health_level_4() {
  self.perk_data["health"].max_health = LEVEL_4_MAX_HEALTH;
  self.maxhealth = self.perk_data["health"].max_health;
  self notify("health_perk_upgrade");
  self.perk_data["health"].melee_scalar = LEVEL_4_MELEE_SCALAR;
}

unset_perk_health_level_4() {
  self.perk_data["health"].melee_scalar = DEFAULT_MELEE_SCALAR;
}

DEFAULT_BULLET_DAMAGE_SCALAR = 1.0;
LEVEL_0_BULLET_DAMAGE_SCALAR = 1.2;

LEVEL_2_BULLET_DAMAGE_SCALAR = 1.3;
LEVEL_3_BULLET_DAMAGE_SCALAR = 1.4;
LEVEL_4_BULLET_DAMAGE_SCALAR = 1.5;

init_perk_bullet_damage() {
  perk_data = spawnStruct();

  perk_data.bullet_damage_scalar = DEFAULT_BULLET_DAMAGE_SCALAR;

  return perk_data;
}

set_perk_bullet_damage_0() {
  self.perk_data["damagemod"].bullet_damage_scalar = LEVEL_0_BULLET_DAMAGE_SCALAR;
}

unset_perk_bullet_damage_0() {
  self.perk_data["damagemod"].bullet_damage_scalar = DEFAULT_BULLET_DAMAGE_SCALAR;
}

set_perk_bullet_damage_1() {
  self.perk_data["damagemod"].bullet_damage_scalar = LEVEL_0_BULLET_DAMAGE_SCALAR;
  self givePerk("specialty_quickswap", false);
  self givePerk("specialty_stalker", false);
  self givePerk("specialty_fastoffhand", false);
}

unset_perk_bullet_damage_1() {
  self.perk_data["damagemod"].bullet_damage_scalar = DEFAULT_BULLET_DAMAGE_SCALAR;
  self _unsetPerk("specialty_quickswap");
  self _unsetPerk("specialty_stalker");
  self _unsetPerk("specialty_fastoffhand");
}

set_perk_bullet_damage_2() {
  self.perk_data["damagemod"].bullet_damage_scalar = LEVEL_0_BULLET_DAMAGE_SCALAR;
  self givePerk("specialty_quickswap", false);
  self givePerk("specialty_stalker", false);
  self givePerk("specialty_fastoffhand", false);
  self givePerk("specialty_quickdraw", false);
}

unset_perk_bullet_damage_2() {
  self.perk_data["damagemod"].bullet_damage_scalar = DEFAULT_BULLET_DAMAGE_SCALAR;
  self _unsetPerk("specialty_quickswap");
  self _unsetPerk("specialty_stalker");
  self _unsetPerk("specialty_fastoffhand");
  self _unsetPerk("specialty_quickdraw");
}

set_perk_bullet_damage_3() {
  self.perk_data["damagemod"].bullet_damage_scalar = LEVEL_0_BULLET_DAMAGE_SCALAR;
  self givePerk("specialty_quickswap", false);
  self givePerk("specialty_stalker", false);
  self givePerk("specialty_fastoffhand", false);
  self givePerk("specialty_quickdraw", false);
  self givePerk("specialty_fastreload", false);
}

unset_perk_bullet_damage_3() {
  self.perk_data["damagemod"].bullet_damage_scalar = DEFAULT_BULLET_DAMAGE_SCALAR;
  self _unsetPerk("specialty_quickswap");
  self _unsetPerk("specialty_stalker");
  self _unsetPerk("specialty_fastoffhand");
  self _unsetPerk("specialty_quickdraw");
  self givePerk("specialty_fastreload", false);
}

set_perk_bullet_damage_4() {
  self.perk_data["damagemod"].bullet_damage_scalar = LEVEL_4_BULLET_DAMAGE_SCALAR;
  self givePerk("specialty_quickswap", false);
  self givePerk("specialty_stalker", false);
  self givePerk("specialty_fastoffhand", false);
  self givePerk("specialty_quickdraw", false);
  self setaimspreadmovementscale(0.5);

  self givePerk("specialty_fastreload", false);
}

unset_perk_bullet_damage_4() {
  self.perk_data["damagemod"].bullet_damage_scalar = DEFAULT_BULLET_DAMAGE_SCALAR;
  self _unsetPerk("specialty_quickswap");
  self _unsetPerk("specialty_stalker");
  self _unsetPerk("specialty_fastoffhand");
  self _unsetPerk("specialty_quickdraw");
  self setaimspreadmovementscale(1.0);

  self _unsetPerk("specialty_fastreload");
}

DEFAULT_GAS_DAMAGE_SCALAR = 1.0;
LEVEL_1_MEDIC_GAS_DAMAGE_SCALAR = 0.0;

DEFAULT_REVIVE_TIME_SCALAR = 1.0;
LEVEL_0_MEDIC_REVIVE_TIME_SCALAR = 1.5;
LEVEL_2_MEDIC_REGEN_RATE = 5.0;
LEVEL_2_MEDIC_HEALTH_REGEN_DIST_SQR = 65536.0;

LEVEL_4_MEDIC_HEALTH_REGEN_DIST_SQR = 0.0;

DEFAULT_MOVE_SPEED_SCALAR = 1.0;
LEVEL_2_MOVE_SPEED_SCALAR = 1.06;
LEVEL_4_MOVE_SPEED_SCALAR = 1.12;

DEFAULT_REVIVE_DAMAGE_SCALAR = 1.0;
LEVEL_3_REVIVE_DAMAGE_SCALAR = 0.75;

init_perk_medic() {
  perk_data = spawnStruct();

  perk_data.revive_time_scalar = DEFAULT_REVIVE_TIME_SCALAR;
  perk_data.gas_damage_scalar = DEFAULT_GAS_DAMAGE_SCALAR;
  perk_data.move_speed_scalar = DEFAULT_MOVE_SPEED_SCALAR;
  perk_data.revive_damage_scalar = DEFAULT_REVIVE_DAMAGE_SCALAR;

  return perk_data;
}

set_perk_medic_0() {
  self.perk_data["medic"].revive_time_scalar = LEVEL_0_MEDIC_REVIVE_TIME_SCALAR;
  self.moveSpeedScaler = self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
}

unset_perk_medic_0() {
  self.perk_data["medic"].revive_time_scalar = DEFAULT_REVIVE_TIME_SCALAR;
  self.moveSpeedScaler = DEFAULT_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
}

set_perk_medic_1() {
  self.perk_data["medic"].revive_time_scalar = LEVEL_0_MEDIC_REVIVE_TIME_SCALAR;
  self.moveSpeedScaler = LEVEL_2_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
  self.perk_data["medic"].revive_damage_scalar = LEVEL_3_REVIVE_DAMAGE_SCALAR;
}

unset_perk_medic_1() {
  self.perk_data["medic"].revive_time_scalar = DEFAULT_REVIVE_TIME_SCALAR;
  self.moveSpeedScaler = DEFAULT_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
  self.perk_data["medic"].revive_damage_scalar = DEFAULT_REVIVE_DAMAGE_SCALAR;
}

set_perk_medic_2() {
  self givePerk("specialty_longersprint", false);
  self thread medic_health_regen(LEVEL_2_MEDIC_HEALTH_REGEN_DIST_SQR);
  self.perk_data["medic"].revive_time_scalar = LEVEL_0_MEDIC_REVIVE_TIME_SCALAR;
  self.moveSpeedScaler = LEVEL_2_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
  self.perk_data["medic"].revive_damage_scalar = LEVEL_3_REVIVE_DAMAGE_SCALAR;
}

unset_perk_medic_2() {
  self _unsetPerk("specialty_longersprint");
  self notify("end_medic_health_regen");
  self.perk_data["medic"].revive_time_scalar = DEFAULT_REVIVE_TIME_SCALAR;
  self.moveSpeedScaler = DEFAULT_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
  self.perk_data["medic"].revive_damage_scalar = DEFAULT_REVIVE_DAMAGE_SCALAR;
}

set_perk_medic_3() {
  self.perk_data["medic"].gas_damage_scalar = LEVEL_1_MEDIC_GAS_DAMAGE_SCALAR;
  self givePerk("specialty_longersprint", false);
  self thread medic_health_regen(LEVEL_2_MEDIC_HEALTH_REGEN_DIST_SQR);
  self.perk_data["medic"].revive_time_scalar = LEVEL_0_MEDIC_REVIVE_TIME_SCALAR;
  self.moveSpeedScaler = LEVEL_2_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
  self.perk_data["medic"].revive_damage_scalar = LEVEL_3_REVIVE_DAMAGE_SCALAR;
}

unset_perk_medic_3() {
  self.perk_data["medic"].gas_damage_scalar = DEFAULT_GAS_DAMAGE_SCALAR;
  self _unsetPerk("specialty_longersprint");
  self notify("end_medic_health_regen");
  self.perk_data["medic"].revive_time_scalar = DEFAULT_REVIVE_TIME_SCALAR;
  self.moveSpeedScaler = DEFAULT_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
  self.perk_data["medic"].revive_damage_scalar = DEFAULT_REVIVE_DAMAGE_SCALAR;
}

set_perk_medic_4() {
  self.perk_data["medic"].revive_time_scalar = LEVEL_0_MEDIC_REVIVE_TIME_SCALAR;
  self.perk_data["medic"].gas_damage_scalar = LEVEL_1_MEDIC_GAS_DAMAGE_SCALAR;
  self thread medic_health_regen(LEVEL_4_MEDIC_HEALTH_REGEN_DIST_SQR);
  self.moveSpeedScaler = LEVEL_4_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
  self givePerk("specialty_longersprint", false);
  self givePerk("specialty_fastsprintrecovery", false);
  self.perk_data["medic"].revive_damage_scalar = LEVEL_3_REVIVE_DAMAGE_SCALAR;
}

unset_perk_medic_4() {
  self.perk_data["medic"].revive_time_scalar = DEFAULT_REVIVE_TIME_SCALAR;
  self.perk_data["medic"].gas_damage_scalar = DEFAULT_GAS_DAMAGE_SCALAR;
  self notify("end_medic_health_regen");
  self.moveSpeedScaler = DEFAULT_MOVE_SPEED_SCALAR * self maps\mp\alien\_prestige::prestige_getMoveSlowScalar();
  self.perk_data["medic"].move_speed_scalar = self.moveSpeedScaler;
  self _unsetPerk("specialty_longersprint");
  self _unsetPerk("specialty_fastsprintrecovery");
  self.perk_data["medic"].revive_damage_scalar = DEFAULT_REVIVE_DAMAGE_SCALAR;
}

medic_health_regen(dist_sqr) {
  self endon("death");
  self endon("disconnect");
  self endon("end_medic_health_regen");
  do_dist_check = dist_sqr > 0.0;
  while(1) {
    foreach(player in level.players) {
      if(isReallyAlive(player) &&
        !isDefined(player.medic_regeneration)) {
        if(do_dist_check && DistanceSquared(self.origin, player.origin) > dist_sqr) {
          continue;
        }

        player thread medic_regenerate_health_once();
      }
    }
    wait 1.0;
  }
}

medic_regenerate_health_once() {
  self endon("death");
  self endon("disconnect");
  if(!self has_fragile_relic_and_is_sprinting()) {
    self.medic_regeneration = true;
    wait 1.0;
    self.health = int(min(self.maxhealth, self.health + LEVEL_2_MEDIC_REGEN_RATE));
    self.medic_regeneration = undefined;
  }
}

DEFAULT_DRILL_HEALTH_SCALAR = 1.0;
LEVEL_0_DRILL_HEALTH_SCALAR = 1.256;
DEFAULT_DRILL_TIME_SCALAR = 1.0;
LEVEL_1_DRILL_TIME_SCALAR = 0.5;
DEFAULT_TRAP_COST_SCALAR = 1;
LEVEL_2_TRAP_COST_SCALAR = 0.8;
DEFAULT_TRAP_DURATION_SCALAR = 1;
LEVEL_3_TRAP_DURATION_SCALAR = 1.5;
DEFAULT_TRAP_DAMAGE_SCALAR = 1;
LEVEL_4_TRAP_DAMAGE_SCALAR = 2;
DEFAULT_MONEY_SCALE_PER_HIVE = 1.0;
LEVEL_0_MONEY_SCALE_PER_HIVE = 1.2;
DEFAULT_WALLET_SIZE = 6000;
LEVEL_4_WALLET_SIZE = 8000;
DEFAULT_EXPLOSIVE_DAMAGE_SCALAR = 1.0;
LEVEL_4_EXPLOSIVE_DAMAGE_SCALAR = 1.5;
DEFAULT_REPAIR_DAMAGE_SCALAR = 1.0;
LEVEL_3_REPAIR_DAMAGE_SCALAR = 0.75;

init_perk_rigger() {
  perk_data = spawnStruct();
  perk_data.drill_health_scalar = DEFAULT_DRILL_HEALTH_SCALAR;
  perk_data.drill_time_scalar = DEFAULT_DRILL_TIME_SCALAR;
  perk_data.trap_cost_scalar = DEFAULT_TRAP_COST_SCALAR;
  perk_data.trap_duration_scalar = DEFAULT_TRAP_DURATION_SCALAR;
  perk_data.trap_damage_scalar = DEFAULT_TRAP_DAMAGE_SCALAR;
  perk_data.currency_scale_per_hive = DEFAULT_MONEY_SCALE_PER_HIVE;
  perk_data.explosive_damage_scalar = DEFAULT_EXPLOSIVE_DAMAGE_SCALAR;
  perk_data.repair_damage_scalar = DEFAULT_REPAIR_DAMAGE_SCALAR;

  return perk_data;
}

set_perk_rigger_0() {
  self.perk_data["rigger"].drill_health_scalar = LEVEL_0_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = LEVEL_0_MONEY_SCALE_PER_HIVE;
}

unset_perk_rigger_0() {
  self.perk_data["rigger"].drill_health_scalar = DEFAULT_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = DEFAULT_MONEY_SCALE_PER_HIVE;
}

set_perk_rigger_1() {
  self.perk_data["rigger"].drill_health_scalar = LEVEL_0_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = LEVEL_0_MONEY_SCALE_PER_HIVE;
  self.perk_data["rigger"].drill_time_scalar = LEVEL_1_DRILL_TIME_SCALAR;
}

unset_perk_rigger_1() {
  self.perk_data["rigger"].drill_health_scalar = DEFAULT_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].drill_time_scalar = DEFAULT_DRILL_TIME_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = DEFAULT_MONEY_SCALE_PER_HIVE;
}

set_perk_rigger_2() {
  self.perk_data["rigger"].drill_health_scalar = LEVEL_0_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = LEVEL_0_MONEY_SCALE_PER_HIVE;
  self.perk_data["rigger"].drill_time_scalar = LEVEL_1_DRILL_TIME_SCALAR;
  self.perk_data["rigger"].trap_cost_scalar = LEVEL_2_TRAP_COST_SCALAR;
}

unset_perk_rigger_2() {
  self.perk_data["rigger"].drill_health_scalar = DEFAULT_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].drill_time_scalar = DEFAULT_TRAP_COST_SCALAR;
  self.perk_data["rigger"].trap_cost_scalar = DEFAULT_DRILL_TIME_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = DEFAULT_MONEY_SCALE_PER_HIVE;
}

set_perk_rigger_3() {
  self.perk_data["rigger"].drill_health_scalar = LEVEL_0_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = LEVEL_0_MONEY_SCALE_PER_HIVE;
  self.perk_data["rigger"].drill_time_scalar = LEVEL_1_DRILL_TIME_SCALAR;
  self.perk_data["rigger"].trap_cost_scalar = LEVEL_2_TRAP_COST_SCALAR;
  self.perk_data["rigger"].trap_duration_scalar = LEVEL_3_TRAP_DURATION_SCALAR;
  self.perk_data["rigger"].repair_damage_scalar = LEVEL_3_REPAIR_DAMAGE_SCALAR;
}

unset_perk_rigger_3() {
  self.perk_data["rigger"].drill_health_scalar = DEFAULT_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].drill_time_scalar = DEFAULT_TRAP_COST_SCALAR;
  self.perk_data["rigger"].trap_cost_scalar = DEFAULT_DRILL_TIME_SCALAR;
  self.perk_data["rigger"].trap_duration_scalar = DEFAULT_TRAP_DURATION_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = DEFAULT_MONEY_SCALE_PER_HIVE;
  self.perk_data["rigger"].repair_damage_scalar = DEFAULT_REPAIR_DAMAGE_SCALAR;
}

set_perk_rigger_4() {
  self.perk_data["rigger"].drill_health_scalar = LEVEL_0_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = LEVEL_0_MONEY_SCALE_PER_HIVE;
  self.perk_data["rigger"].drill_time_scalar = LEVEL_1_DRILL_TIME_SCALAR;
  self.perk_data["rigger"].trap_cost_scalar = LEVEL_2_TRAP_COST_SCALAR;
  self.perk_data["rigger"].trap_duration_scalar = LEVEL_3_TRAP_DURATION_SCALAR;
  self.perk_data["rigger"].trap_damage_scalar = LEVEL_4_TRAP_DAMAGE_SCALAR;
  self maps\mp\alien\_persistence::set_player_max_currency(LEVEL_4_WALLET_SIZE * maps\mp\alien\_prestige::prestige_getWalletSizeScalar());
  self.perk_data["rigger"].repair_damage_scalar = LEVEL_3_REPAIR_DAMAGE_SCALAR;
  self.perk_data["rigger"].explosive_damage_scalar = LEVEL_4_EXPLOSIVE_DAMAGE_SCALAR;
}

unset_perk_rigger_4() {
  self.perk_data["rigger"].drill_health_scalar = DEFAULT_DRILL_HEALTH_SCALAR;
  self.perk_data["rigger"].drill_time_scalar = DEFAULT_TRAP_COST_SCALAR;
  self.perk_data["rigger"].trap_cost_scalar = DEFAULT_DRILL_TIME_SCALAR;
  self.perk_data["rigger"].trap_duration_scalar = DEFAULT_TRAP_DURATION_SCALAR;
  self.perk_data["rigger"].trap_damage_scalar = DEFAULT_TRAP_DAMAGE_SCALAR;
  self.perk_data["rigger"].currency_scale_per_hive = DEFAULT_MONEY_SCALE_PER_HIVE;
  self maps\mp\alien\_persistence::set_player_max_currency(DEFAULT_WALLET_SIZE * maps\mp\alien\_prestige::prestige_getWalletSizeScalar());
  self.perk_data["rigger"].repair_damage_scalar = DEFAULT_REPAIR_DAMAGE_SCALAR;
  self.perk_data["rigger"].explosive_damage_scalar = DEFAULT_EXPLOSIVE_DAMAGE_SCALAR;
}

init_perk_pistol() {
  perk_data = spawnStruct();
  perk_data.pistol_overkill = false;
  perk_data.pistol_regen = false;

  return perk_data;
}

check_for_pistol_ammo(base_pistol_name, full_pistol_name) {
  self.lastWeapon = self GetCurrentWeapon();
  self.pistol_clip_ammo_right = self GetWeaponAmmoClip(full_pistol_name, "right");
  self.pistol_ammo_remaining = self GetWeaponAmmoStock(full_pistol_name);
}

give_new_pistol(new_pistol_name) {
  pistol = new_pistol_name;
  self _giveWeapon(pistol);
  self SetWeaponAmmoClip(pistol, self.pistol_clip_ammo_right, "right");
  self SetWeaponAmmoStock(pistol, self.pistol_ammo_remaining);
  weaponlist = self GetWeaponsListPrimaries();
  if(!self HasWeapon(self.lastWeapon) && !self has_special_weapon() && !self is_holding_deployable()) {
    self SwitchToWeapon(pistol);
  }
}

set_perk_pistol_p226_0() {}

unset_perk_pistol_p226_0() {
  self store_ammo_and_take_pistol("iw6_alienp226_mp");
}

set_perk_pistol_p226_1() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienp226_mp_alienmuzzlebrakepi");
  }
  else {
    self give_new_pistol("iw6_alienp226_mp_barrelrange02");
  }
}

unset_perk_pistol_p226_1() {
  self store_ammo_and_take_pistol("iw6_alienp226_mp");
}

set_perk_pistol_p226_2() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienp226_mp_alienmuzzlebrakepi_xmags");
  }
  else {
    self give_new_pistol("iw6_alienp226_mp_barrelrange02_xmags");
  }
}

unset_perk_pistol_p226_2() {
  self store_ammo_and_take_pistol("iw6_alienp226_mp");
}

set_perk_pistol_p226_3() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienp226_mp_alienmuzzlebrakepi_xmags");
  }
  else {
    self give_new_pistol("iw6_alienp226_mp_barrelrange02_xmags");
  }

  self.perk_data["pistol"].pistol_overkill = true;
}

unset_perk_pistol_p226_3() {
  self store_ammo_and_take_pistol("iw6_alienp226_mp");
  self.perk_data["pistol"].pistol_overkill = false;
}

set_perk_pistol_p226_4() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw5_alienp226_mp_akimbo_alienmuzzlebrakepi_xmags");
  }
  else {
    self give_new_pistol("iw5_alienp226_mp_akimbo_barrelrange02_xmags");
  }

  self.perk_data["pistol"].pistol_overkill = true;
}

unset_perk_pistol_p226_4() {
  self store_ammo_and_take_pistol("iw5_alienp226_mp");
  self.perk_data["pistol"].pistol_overkill = false;
}

unset_perk_pistol_magnum_0() {
  self store_ammo_and_take_pistol("iw6_alienmagnum_mp");
}

set_perk_pistol_magnum_1() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && !self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_acogpistol_barrelrange02_scope5");
  }
  else if(!self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_alienmuzzlebrakepi");
  }
  else if(self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_acogpistol_alienmuzzlebrakepi_scope5");
  }
  else {
    self give_new_pistol("iw6_alienmagnum_mp_barrelrange02");
  }
}

unset_perk_pistol_magnum_1() {
  self store_ammo_and_take_pistol("iw6_alienmagnum_mp");
}

set_perk_pistol_magnum_2() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && !self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_acogpistol_barrelrange02_xmags_scope5");
  }
  else if(!self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_alienmuzzlebrakepi_xmags");
  }
  else if(self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_acogpistol_alienmuzzlebrakepi_xmags_scope5");
  }
  else {
    self give_new_pistol("iw6_alienmagnum_mp_barrelrange02_xmags");
  }
}

unset_perk_pistol_magnum_2() {
  self store_ammo_and_take_pistol("iw6_alienmagnum_mp");
}

set_perk_pistol_magnum_3() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && !self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_acogpistol_barrelrange02_xmags_scope5");
  }
  else if(!self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_alienmuzzlebrakepi_xmags");
  }
  else if(self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmagnum_mp_acogpistol_alienmuzzlebrakepi_xmags_scope5");
  }
  else {
    self give_new_pistol("iw6_alienmagnum_mp_barrelrange02_xmags");
  }

  self.perk_data["pistol"].pistol_overkill = true;
}

unset_perk_pistol_magnum_3() {
  self store_ammo_and_take_pistol("iw6_alienmagnum_mp");
  self.perk_data["pistol"].pistol_overkill = false;
}

set_perk_pistol_magnum_4() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && !self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw5_alienmagnum_mp_acogpistol_akimbo_barrelrange02_xmags_scope5");
  }
  else if(!self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw5_alienmagnum_mp_akimbo_alienmuzzlebrakepi_xmags");
  }
  else if(self maps\mp\alien\_persistence::is_upgrade_enabled("magnum_acog_upgrade") && self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw5_alienmagnum_mp_acogpistol_akimbo_alienmuzzlebrakepi_xmags_scope5");
  }
  else {
    self give_new_pistol("iw5_alienmagnum_mp_akimbo_barrelrange02_xmags");
  }
  self.perk_data["pistol"].pistol_overkill = true;
}

unset_perk_pistol_magnum_4() {
  self store_ammo_and_take_pistol("iw5_alienmagnum_mp");
  self.perk_data["pistol"].pistol_overkill = false;
}

unset_perk_pistol_m9a1_0() {
  self store_ammo_and_take_pistol("iw6_alienm9a1_mp");
}

set_perk_pistol_m9a1_1() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienm9a1_mp_alienmuzzlebrakep3");
  }
  else {
    self give_new_pistol("iw6_alienm9a1_mp_barrelrange02");
  }
}

unset_perk_pistol_m9a1_1() {
  self store_ammo_and_take_pistol("iw6_alienm9a1_mp");
}

set_perk_pistol_m9a1_2() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienm9a1_mp_alienmuzzlebrakep3_xmags");
  }
  else {
    self give_new_pistol("iw6_alienm9a1_mp_barrelrange02_xmags");
  }
}

unset_perk_pistol_m9a1_2() {
  self store_ammo_and_take_pistol("iw6_alienm9a1_mp");
}

set_perk_pistol_m9a1_3() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienm9a1_mp_alienmuzzlebrakep3_xmags");
  }
  else {
    self give_new_pistol("iw6_alienm9a1_mp_barrelrange02_xmags");
  }

  self.perk_data["pistol"].pistol_overkill = true;
}

unset_perk_pistol_m9a1_3() {
  self store_ammo_and_take_pistol("iw6_alienm9a1_mp");
  self.perk_data["pistol"].pistol_overkill = false;
}

set_perk_pistol_m9a1_4() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw5_alienm9a1_mp_akimbo_alienmuzzlebrakep3_xmags");
  }
  else {
    self give_new_pistol("iw5_alienm9a1_mp_akimbo_barrelrange02_xmags");
  }

  self.perk_data["pistol"].pistol_overkill = true;
}

unset_perk_pistol_m9a1_4() {
  self store_ammo_and_take_pistol("iw5_alienm9a1_mp");
  self.perk_data["pistol"].pistol_overkill = false;
}

store_ammo_and_take_pistol(baseweapon) {
  current_pistol = self get_current_pistol();
  self check_for_pistol_ammo(baseweapon, current_pistol);
  self TakeWeapon(current_pistol);
}

unset_perk_pistol_mp443_0() {
  self store_ammo_and_take_pistol("iw6_alienmp443_mp");
}

set_perk_pistol_mp443_1() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmp443_mp_alienmuzzlebrakepa");
  }
  else {
    self give_new_pistol("iw6_alienmp443_mp_barrelrange02");
  }
}

unset_perk_pistol_mp443_1() {
  self store_ammo_and_take_pistol("iw6_alienmp443_mp");
}

set_perk_pistol_mp443_2() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmp443_mp_alienmuzzlebrakepa_xmags");
  }
  else {
    self give_new_pistol("iw6_alienmp443_mp_barrelrange02_xmags");
  }
}

unset_perk_pistol_mp443_2() {
  self store_ammo_and_take_pistol("iw6_alienmp443_mp");
}

set_perk_pistol_mp443_3() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw6_alienmp443_mp_alienmuzzlebrakepa_xmags");
  }
  else {
    self give_new_pistol("iw6_alienmp443_mp_barrelrange02_xmags");
  }
  self.perk_data["pistol"].pistol_overkill = true;
}

unset_perk_pistol_mp443_3() {
  self store_ammo_and_take_pistol("iw6_alienmp443_mp");
  self.perk_data["pistol"].pistol_overkill = false;
}

set_perk_pistol_mp443_4() {
  if(self maps\mp\alien\_persistence::is_upgrade_enabled("ark_pistol_upgrade")) {
    self give_new_pistol("iw5_alienmp443_mp_akimbo_alienmuzzlebrakepa_xmags");
  }
  else {
    self give_new_pistol("iw5_alienmp443_mp_akimbo_barrelrange02_xmags");
  }
  self.perk_data["pistol"].pistol_overkill = true;
}

unset_perk_pistol_mp443_4() {
  self store_ammo_and_take_pistol("iw5_alienmp443_mp");
  self.perk_data["pistol"].pistol_overkill = false;
}

watchCombatSpeedScaler() {
  self endon("death");
  self endon("disconnect");

  self.pistolCombatSpeedScalar = 1.0;
  self.alienSnareSpeedScalar = 1.0;

  self.alienSnareCount = 0;

  self.combatSpeedScalar = getCombatSpeedScalar();
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();

  while(true) {
    self waittill("weapon_change", newWeapon);
    if(self has_perk("perk_pistol_p226", [1, 2, 3, 4]) || self has_perk("perk_pistol_magnum", [1, 2, 3, 4]) || self has_perk("perk_pistol_m9a1", [1, 2, 3, 4]) || self has_perk("perk_pistol_mp443", [1, 2, 3, 4])) {
      currentweapon = self GetCurrentWeapon();
      baseweapon = getRawBaseWeaponName(currentweapon);
      if(isDefined(baseweapon)) {
        if(baseweapon == "alienp226" || baseweapon == "alienmagnum" || baseweapon == "alienm9a1" || baseweapon == "alienmp443") {
          self.pistolCombatSpeedScalar = 1.1;
        } else {
          self.pistolCombatSpeedScalar = 1.0;
        }

        wait 0.05;
        updateCombatSpeedScalar();
      }
    }
    wait 0.05;
  }
}

updateCombatSpeedScalar() {
  self.combatSpeedScalar = getCombatSpeedScalar();
  self maps\mp\gametypes\_weapons::updateMoveSpeedScale();
}

getCombatSpeedScalar() {
  return (self.pistolCombatSpeedScalar * self.alienSnareSpeedScalar);
}

watchFlamingRiotShield() {
  self endon("death");
  self endon("disconnect");

  while(true) {
    currentweapon = self GetCurrentWeapon();
    if(isDefined(currentweapon)) {
      if(currentweapon == "iw5_alienriotshield4_mp_camo05" && self.fireShield == 1.0) {
        playFXOnTag(level._effect["Riotshield_fire"], self, "TAG_origin");
      } else {
        stopFXOnTag(level._effect["Riotshield_fire"], self, "TAG_origin");
      }
    }
  }
  wait 0.05;
}