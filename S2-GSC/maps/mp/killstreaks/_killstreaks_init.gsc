/*****************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\killstreaks\_killstreaks_init.gsc
*****************************************************/

init() {
  if(isDefined(level.iszombiegame) && level.iszombiegame && !isDefined(level.zombiekillstreaksenabled) || isDefined(level.zombiekillstreaksenabled) && !level.zombiekillstreaksenabled) {
    return;
  }

  if(maps\mp\_utility::func_571D()) {
    maps\mp\_utility::func_2F6D();
  }

  if(maps\mp\_utility::func_571D()) {
    return;
  }

  level.var_5A70 = maps\mp\_utility::getintproperty("scr_game_killstreakdelay", 10);
  level.killstreakfuncs = [];
  level.var_5A75 = [];
  level.var_5A7D = [];
  if(maps\mp\_utility::func_585F() && isDefined(level.zombiekillstreaksenabled) && level.zombiekillstreaksenabled) {
    level thread lib_0527::func_52F7();
    return;
  }

  func_5312();
  level thread maps\mp\killstreaks\_killstreaks::onplayerconnect();
  if(maps\mp\_utility::func_579B() || maps\mp\_utility::isprophuntgametype()) {
    level thread lib_0527::func_52F7();
    level thread maps\mp\killstreaks\_paratroopers::init();
    level thread maps / mp / killstreaks / _basic_training_serum::init();
    return;
  }

  setDvar("scorestreak_enabled_uav", 1);
  setDvar("scorestreak_enabled_carepackage", 1);
  setDvar("scorestreak_enabled_counter_uav", 1);
  setDvar("scorestreak_enabled_flamethrower", 1);
  setDvar("scorestreak_enabled_fritzx", 1);
  setDvar("scorestreak_enabled_mortar_strike", 1);
  setDvar("scorestreak_enabled_missile_strike", 1);
  setDvar("scorestreak_enabled_airstrike", 1);
  setDvar("scorestreak_enabled_firebomb", 1);
  setDvar("scorestreak_enabled_emergency_carepackage", 1);
  setDvar("scorestreak_enabled_fighter_strike", 1);
  setDvar("scorestreak_enabled_advanced_uav", 0);
  setDvar("scorestreak_enabled_attack_dogs", 1);
  setDvar("scorestreak_enabled_flak_gun", 1);
  setDvar("scorestreak_enabled_v2_rocket", 1);
  setDvar("scorestreak_enabled_plane_gunner", 1);
  setDvar("scorestreak_enabled_paratroopers", 1);
  setDvar("scorestreak_enabled_molotovs", 1);
  level thread lib_0526::func_52F6();
  level thread lib_0527::func_52F7();
  level thread lib_0529::func_52F4();
  level thread maps\mp\killstreaks\_v2_missle_strike::func_52F5();
  level thread lib_0528::func_52F3();
  level thread maps\mp\killstreaks\_uav::init();
  level thread maps\mp\killstreaks\_missile_strike::init();
  level thread maps\mp\killstreaks\_airstrike::init();
  level thread maps\mp\killstreaks\_glidebomb::init();
  level thread lib_0517::init();
  level thread maps\mp\killstreaks\_mortarstrike::init();
  level thread lib_0518::init();
  level thread maps\mp\killstreaks\_dog_killstreak::init();
  level thread maps\mp\killstreaks\_firebomb::init();
  level thread maps\mp\killstreaks\_flamethrower::init();
  level thread maps\mp\killstreaks\_v2_nuke::init();
  level thread maps\mp\killstreaks\_flak_gun::init();
  level thread maps\mp\killstreaks\_plane_gunner::init();
  level thread maps\mp\killstreaks\_fighter_strike::init();
  level thread maps\mp\killstreaks\_paratroopers::init();
  level thread maps\mp\killstreaks\_molotovs::init();
  level thread maps / mp / killstreaks / _basic_training_serum::init();
}

func_5312() {
  var_00 = 0;
  for(;;) {
    var_01 = tablelookupbyrow("mp/killstreakTable.csv", var_00, 1);
    if(!isDefined(var_01) || var_01 == "") {
      break;
    }

    if(var_01 == "b1" || var_01 == "none") {} else {
      var_02 = function_01B0("mp/killstreakTable.csv", var_00, 10);
      var_03 = tablelookupbyrow("mp/killstreakTable.csv", var_00, 12);
      game["dialog"][var_01] = var_03;
      var_04 = tablelookupbyrow("mp/killstreakTable.csv", var_00, 13);
      game["dialog"]["allies_friendly_" + var_01 + "_inbound"] = "ss_" + var_04 + "_allyuse";
      game["dialog"]["allies_enemy_" + var_01 + "_inbound"] = "ss_" + var_04 + "_enemyuse";
      var_05 = tablelookupbyrow("mp/killstreakTable.csv", var_00, 14);
      game["dialog"]["axis_friendly_" + var_01 + "_inbound"] = "ss_" + var_05 + "_allyuse";
      game["dialog"]["axis_enemy_" + var_01 + "_inbound"] = "ss_" + var_05 + "_enemyuse";
      var_06 = int(tablelookupbyrow("mp/killstreakTable.csv", var_00, 17));
      maps\mp\gametypes\_rank::func_7C06(var_01 + "_earned", var_06);
    }

    var_00++;
  }
}