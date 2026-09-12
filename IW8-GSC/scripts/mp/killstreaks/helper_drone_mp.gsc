/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\helper_drone_mp.gsc
******************************************************/

function helper_drone_init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("radar_drone_recon", &scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("radar_drone_escort", &scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("radar_drone_overwatch", &scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("scrambler_drone_escort", &scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("scrambler_drone_guard", &scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("assault_drone", &scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  var_0 = getarraykeys(level.helperdronesettings);

  foreach(var_2 in var_0) {
    var_3 = level.helperdronesettings[var_2].hitstokill;

    if(isDefined(var_3)) {
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_2, var_3);
      scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle("emp_grenade_mp", var_3, var_2);
    }
  }

  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&helperdrone_updateheadicononjointeam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helperDrone", "onReconDroneSuperStarted", &spawn_addtoarrays);
}

function helperdrone_updateheadicononjointeam(var_0) {}

function spawn_addtoarrays() {
  if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread ref_12A97();
    return;
  }
}

function ref_12A97() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var_0 = getcompleteweaponname("ks_remote_drone_mp");

  if(self hasweapon(var_0)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    return;
  }
}