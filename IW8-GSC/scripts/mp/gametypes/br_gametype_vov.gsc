/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gametype_vov.gsc
****************************************************/

function init() {
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("plunderSites");
  level.ref_13ACE = [];
  scripts\mp\gametypes\br_gametype_truckwar::stoppingpower_givehcrdata();
  level thread scripts\mp\gametypes\br_gametype_truckwar::ref_13DF8();
  level.delete_airlock_ents = 0;
  level.delaystreamtomovingplane = 1;
  level.ref_12184 = 1;
  level.ref_1408B = 1;
  level.ref_12931 = "br_pe_loadout_drop_start";
  scripts\mp\gametypes\br_gametypes::load_sequence_3_vfx("drogBagLoadout");
  scripts\mp\utility\sound::besttime("mp_tu_canteen_sfx");
  _keypadscriptableused_bunkeralt::init();
  _ispointinbadarea::init();
  _initignoredtabspergamemode::init();
  _keypadscriptableused::init();

  if(level.mapname != "mp_don4" && level.mapname != "mp_br_mechanics") {
    level thread scripts\mp\gametypes\br_soa_tower::ref_13C0F();
  }

  thread ref_127F5();
}

function ref_127F5() {
  level waittill("prematch_over");
  scripts\mp\gametypes\br_armory_kiosk::ref_13169("supply_drop", 1);
  scripts\mp\gametypes\br_armory_kiosk::ref_13169("vehicle_replace", 0);
  scripts\mp\gametypes\br_armory_kiosk::ref_13169("circle_bombardment", 0);
  level.ref_12851 = &ref_13F9B;
}

function ref_13F9B() {
  scripts\mp\gametypes\br_armory_kiosk::ref_13169("vehicle_replace", 1);
  scripts\mp\gametypes\br_armory_kiosk::ref_13169("circle_bombardment", 1);
}