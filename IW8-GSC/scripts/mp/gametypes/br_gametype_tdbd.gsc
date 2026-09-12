/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_tdbd.gsc
*****************************************************/

function init() {
  setDvar("scr_br_altprematchloadout", "classtable_brdbd_prematch");
  scripts\mp\gametypes\br_gametypes::ref_12b11("regenHealthAdd", &ref_1264b);
  scripts\mp\gametypes\br_gametypes::ref_12b11("postMainInit", &ref_12803);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerNakedDropLoadout", &ref_12604);
  scripts\mp\gametypes\br_gametypes::ref_12b11("playerAdditionalGulagDropLogic", &playergulagdroploadout);

  if(getdvarint("scr_br_tdbd_hunter_enabled", 1) == 1) {
    _keypadscriptableused_bunkeralt::init();
    _ispointinbadarea::init();
  }

  if(getdvarint("scr_br_resurgence_respawn_enable", 0) == 1) {
    level thread scripts\mp\gametypes\br_gametype_rebirth::enabledskiplaststand();
    level thread scripts\mp\gametypes\br_gametype_rebirth::enable_traversals_for_bombers();
  }

  if(getdvarint("scr_br_dbd_vehicle_littlebird", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("littleBirdSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_truck", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("truckSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_jeep", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("jeepSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_tacrover", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("tacRoverSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_atv", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("atvSpawns");
  }

  if(getdvarint("scr_br_dbd_vehicle_motorcycle", 0) == 0) {
    scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("motorcycleSpawns");
  }

  level.ref_11c95 = &ref_11c95;
  level.disable_super_in_turret.iscontender = getdvarfloat("scr_br_dbd_healthregenrate", 1);
  level.disable_super_in_turret.iscloseto = getdvarfloat("scr_br_dbd_gasdamagesclar", 1.5);
  level.disable_super_in_turret.iscrossbowbolt = getdvarfloat("scr_br_dbd_stimregenscalar", 4);
}

function ref_12803() {
  if(getdvarint("scr_dbd_fall_height_modifier_enable", 1) == 0) {
    return;
  }

  setDvar("bg_fallDamageMinHeight", getdvarint("scr_br_dbd_fallheightmin", 1120));
  setDvar("bg_fallDamageMaxHeight", getdvarint("scr_br_dbd_fallheightmax", 1121));
  setDvar("bg_softLandingMinHeight", getdvarint("scr_br_dbd_fallheightmin", 1120));
  setDvar("bg_softLandingMaxHeight", getdvarint("scr_br_dbd_fallheightmax", 1121));
  thread soundbank_load();
}

function ref_1264b(var_0) {
  if(istrue(self.adrenalinepoweractive)) {
    return float(level.disable_super_in_turret.iscontender * level.disable_super_in_turret.iscrossbowbolt);
  }

  return float(level.disable_super_in_turret.iscontender);
}

function ref_11c95(var_0) {
  return int(var_0 * level.disable_super_in_turret.iscloseto);
}

function ref_12604() {
  scripts\mp\gametypes\br::searchcircleorigin(0, 1, 0);
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_self_revive", 1);
}

function playergulagdroploadout() {
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_self_revive", 1);
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_armor_plate", 1, 2);
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_ammo_12g", 1, 12);
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_ammo_50cal", 1, 10);
  scripts\mp\gametypes\br_pickups::br_forcegivecustompickupitem(self, "brloot_ammo_762", 1, 60);
}

function soundbank_load() {
  wait 5;
  scripts\mp\utility\sound::besttime("br_mode_titanium_trials");
}