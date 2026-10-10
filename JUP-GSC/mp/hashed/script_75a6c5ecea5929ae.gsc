/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_75a6c5ecea5929ae.gsc
*************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\utility\inventory_utility;
#using scripts\engine\utility;
#using scripts\mp\class;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\spawn_event_aggregator;
#namespace namespace_2d3858b0486afd15;

function function_17a8b3a21e25bce4() {
  level.denyclasschoice = 1;
  setDvar(@ "scr_skip_infils", 1);
  level thread onstartgametypefinished();
  level scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(&onplayerspawned);
  level.bypassclasschoicefunc = &scripts\mp\class::alwaysgamemodeclass;
}

function onstartgametypefinished() {
  utility::flag_wait("onStartGameTypeFinished");
  setspecialloadouts();
  level.blockweapondrops = 1;
  level thread onplayerconnect();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player scripts\mp\class::function_a16868d4dcd81a4b();
    player.pers["gamemodeLoadout"] = level.var_e2c0087725abdea2["allies"];
    player loadweaponsforplayer(["jup_jp31_dm_compound_mp", "jup_jp23_me_spear_mp"], 1);
  }
}

function onplayerspawned() {
  var_14ad7dfe17275303 = ["specialty_stalker_boots", "specialty_lightweight", "specialty_fastreload", "specialty_longslide", "specialty_sliding_ads", "specialty_fastcrouchmovement"];
  function_177aaacdaae75fd6(var_14ad7dfe17275303);
}

function setspecialloadouts() {
  level.var_e2c0087725abdea2["loadoutArchetype"] = "archetype_assault";
  level.var_e2c0087725abdea2["allies"]["loadoutPrimary"] = "jup_jp31_dm_compound_mp";
  level.var_e2c0087725abdea2["allies"]["loadoutSecondary"] = "jup_jp23_me_spear_mp";
  level.var_e2c0087725abdea2["allies"]["loadoutEquipmentPrimary"] = "none";
  level.var_e2c0087725abdea2["allies"]["loadoutEquipmentSecondary"] = "none";
  level.var_e2c0087725abdea2["allies"]["loadoutStreakType"] = "assault";
  level.var_e2c0087725abdea2["allies"]["loadoutGesture"] = "playerData";
  level.var_e2c0087725abdea2["axis"]["loadoutPrimary"] = "jup_jp31_dm_compound_mp";
  level.var_e2c0087725abdea2["axis"]["loadoutSecondary"] = "jup_jp23_me_spear_mp";
  level.var_e2c0087725abdea2["axis"]["loadoutEquipmentPrimary"] = "none";
  level.var_e2c0087725abdea2["axis"]["loadoutEquipmentSecondary"] = "none";
  level.var_e2c0087725abdea2["axis"]["loadoutStreakType"] = "assault";
  level.var_e2c0087725abdea2["axis"]["loadoutGesture"] = "playerData";
}

function function_177aaacdaae75fd6(var_608cc23373c0fd33) {
  scripts\mp\class::loadout_clearperks();

  foreach(perk in var_608cc23373c0fd33) {
    if(!scripts\mp\utility\perk::_hasperk(perk)) {
      scripts\mp\utility\perk::giveperk(perk);
    }
  }
}