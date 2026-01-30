/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42948.gsc
**************************************/

init() {
  level.killstreak_string_table = "mp/killstreakTable.csv";
  level.killstreak_gimme_slot = 0;
  level.killstreak_slot_1 = 1;
  level.killstreak_slot_2 = 2;
  level.killstreak_slot_3 = 3;
  level.killstreak_slot_4 = 4;
  level.killstreak_stacking_start_slot = 5;
  level.ks_modules_table = "mp/killstreakModules.csv";
  level.ks_module_ref_column = 1;
  level.ks_module_killstreak_ref_column = 4;
  level.ks_module_added_points_column = 5;
  level.ks_module_slot_column = 6;
  level.ks_module_support_column = 7;
  level.killstreakrounddelay = maps\mp\_utility::getintproperty("scr_game_killstreakdelay", 10);
  level.killstreakfuncs = [];
  level.killstreaksetupfuncs = [];
  level.killstreakwieldweapons = [];
  initkillstreakdata();
  level thread maps\mp\killstreaks\_killstreaks::onplayerconnect();

  if(isDefined(level.iszombiegame) && level.iszombiegame) {
    return;
  }
  level thread maps\mp\killstreaks\_aerial_utility::init();
  level thread maps\mp\killstreaks\_coop_util::init();

  if(isDefined(level.mapcustomkillstreakfunc)) {
    [[level.mapcustomkillstreakfunc]]();
  }

  level thread maps\mp\killstreaks\_uav::init();
  level thread maps\mp\killstreaks\_airdrop::init();
  level thread maps\mp\killstreaks\_remoteturret::init();
  level thread maps\mp\killstreaks\_rippedturret::init();
  level thread maps\mp\killstreaks\_emp::init();
  level thread maps\mp\killstreaks\_nuke::init();
  level thread maps\mp\killstreaks\_juggernaut::init();
  level thread maps\mp\killstreaks\_orbital_strike::init();
  level thread maps\mp\killstreaks\_missile_strike::init();
  level thread maps\mp\killstreaks\_orbital_carepackage::init();
  level thread maps\mp\killstreaks\_warbird::init();
  level thread maps\mp\killstreaks\_drone_assault::init();
  level thread maps\mp\killstreaks\_drone_recon::init();
  level thread maps\mp\killstreaks\_orbitalsupport::init();
  level thread maps\mp\killstreaks\_airstrike::init();
  level thread maps\mp\killstreaks\_drone_carepackage::init();
  level thread maps\mp\killstreaks\_orbital_util::initstart();
}

initkillstreakdata() {
  var_0 = 0;

  for(;;) {
    var_1 = tablelookupbyrow(level.killstreak_string_table, var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    if(var_1 == "b1" || var_1 == "none") {} else {
      var_2 = tablelookupistringbyrow(level.killstreak_string_table, var_0, 5);
      var_3 = tablelookupbyrow(level.killstreak_string_table, var_0, 7);
      game["dialog"][var_1] = var_3;
      var_4 = tablelookupbyrow(level.killstreak_string_table, var_0, 8);
      game["dialog"]["allies_friendly_" + var_1 + "_inbound"] = "ks_" + var_4 + "_allyuse";
      game["dialog"]["allies_enemy_" + var_1 + "_inbound"] = "ks_" + var_4 + "_enemyuse";
      var_5 = tablelookupbyrow(level.killstreak_string_table, var_0, 9);
      game["dialog"]["axis_friendly_" + var_1 + "_inbound"] = "ks_" + var_5 + "_allyuse";
      game["dialog"]["axis_enemy_" + var_1 + "_inbound"] = "ks_" + var_5 + "_enemyuse";
      var_6 = int(tablelookupbyrow(level.killstreak_string_table, var_0, 12));
      maps\mp\gametypes\_rank::registerxpeventinfo(var_1 + "_earned", var_6);
    }

    var_0++;
  }

  additionalvo();
}

additionalvo() {
  var_0 = "allies_friendly_emp_inbound";
  var_1 = "allies_enemy_emp_inbound";
  var_2 = "axis_friendly_emp_inbound";
  var_3 = "axis_enemy_emp_inbound";

  for(var_4 = 1; var_4 < 9; var_4++) {
    var_5 = "_0" + var_4;
    game["dialog"][var_0 + var_5] = game["dialog"][var_0] + var_5;
    game["dialog"][var_1 + var_5] = game["dialog"][var_1] + var_5;
    game["dialog"][var_2 + var_5] = game["dialog"][var_2] + var_5;
    game["dialog"][var_3 + var_5] = game["dialog"][var_3] + var_5;
  }
}