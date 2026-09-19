/*************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\killstreaks\_killstreaks_init.gsc
*************************************************************/

init() {
  if(isDefined(level._id_585D) && level._id_585D && (!isDefined(level.zombiekillstreaksenabled) || isDefined(level.zombiekillstreaksenabled) && !level.zombiekillstreaksenabled)) {
    return;
  }
  if(maps\mp\_utility::_id_571D())
    maps\mp\_utility::_id_2F6D();

  if(maps\mp\_utility::_id_571D()) {
    return;
  }
  level._id_5A70 = maps\mp\_utility::getintproperty("scr_game_killstreakdelay", 10);
  level._id_5A61 = [];
  level._id_5A75 = [];
  level._id_5A7D = [];

  if(maps\mp\_utility::_id_585F() && isDefined(level.zombiekillstreaksenabled) && level.zombiekillstreaksenabled) {
    level thread _id_0527::_id_52F7();
    return;
  }

  _id_5312();
  level thread _id_051E::onplayerconnect();

  if(maps\mp\_utility::_id_579B() || maps\mp\_utility::isprophuntgametype()) {
    level thread _id_0527::_id_52F7();
    level thread _id_0523::init();
    level thread maps\mp\killstreaks\_basic_training_serum::init();
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
  level thread _id_0526::_id_52F6();
  level thread _id_0527::_id_52F7();
  level thread _id_0529::_id_52F4();
  level thread _id_052A::_id_52F5();
  level thread _id_0528::_id_52F3();
  level thread _id_0525::init();
  level thread _id_0520::init();
  level thread _id_0515::init();
  level thread _id_051D::init();
  level thread _id_0517::init();
  level thread _id_0522::init();
  level thread _id_0518::init();
  level thread _id_0516::init();
  level thread _id_051A::init();
  level thread _id_051C::init();
  level thread _id_052B::init();
  level thread _id_051B::init();
  level thread _id_0524::init();
  level thread _id_0519::init();
  level thread _id_0523::init();
  level thread _id_0521::init();
  level thread maps\mp\killstreaks\_basic_training_serum::init();
}

_id_5312() {
  var_0 = 0;

  for(;;) {
    var_1 = _tablelookupbyrow("mp/killstreakTable.csv", var_0, 1);

    if(!isDefined(var_1) || var_1 == "") {
      break;
    }

    if(var_1 == "b1" || var_1 == "none") {} else {
      var_2 = _tablelookupistringbyrow("mp/killstreakTable.csv", var_0, 10);
      var_3 = _tablelookupbyrow("mp/killstreakTable.csv", var_0, 12);
      game["dialog"][var_1] = var_3;
      var_4 = _tablelookupbyrow("mp/killstreakTable.csv", var_0, 13);
      game["dialog"]["allies_friendly_" + var_1 + "_inbound"] = "ss_" + var_4 + "_allyuse";
      game["dialog"]["allies_enemy_" + var_1 + "_inbound"] = "ss_" + var_4 + "_enemyuse";
      var_5 = _tablelookupbyrow("mp/killstreakTable.csv", var_0, 14);
      game["dialog"]["axis_friendly_" + var_1 + "_inbound"] = "ss_" + var_5 + "_allyuse";
      game["dialog"]["axis_enemy_" + var_1 + "_inbound"] = "ss_" + var_5 + "_enemyuse";
      var_6 = int(_tablelookupbyrow("mp/killstreakTable.csv", var_0, 17));
      maps\mp\gametypes\_rank::_id_7C06(var_1 + "_earned", var_6);
    }

    var_0++;
  }
}