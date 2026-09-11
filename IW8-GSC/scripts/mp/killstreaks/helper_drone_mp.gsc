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
  var0 = getarraykeys(level.helperdronesettings);

  foreach(var2 in var0) {
    var3 = level.helperdronesettings[var2].hitstokill;

    if(isDefined(var3)) {
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var2, var3);
      scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle("emp_grenade_mp", var3, var2);
    }
  }

  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(&helperdrone_updateheadicononjointeam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helperDrone", "onReconDroneSuperStarted", &spawn_addtoarrays);
}

function helperdrone_updateheadicononjointeam(var0) {}

function spawn_addtoarrays() {
  if(scripts\mp\utility\game::getgametype() == "br" && !scripts\mp\flags::gameflag("prematch_fade_done")) {
    thread ref_12a97();
    return;
  }
}

function ref_12a97() {
  self endon("death_or_disconnect");
  self endon("reconDroneEnded");
  self endon("reconDroneUnset");
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  var0 = getcompleteweaponname("ks_remote_drone_mp");

  if(self hasweapon(var0)) {
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var0);
    return;
  }
}