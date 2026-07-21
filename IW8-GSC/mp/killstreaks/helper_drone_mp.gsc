/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\helper_drone_mp.gsc
***********************************************/

helper_drone_init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_B6B612C91623C239D7C893DBCD2BEB93B26CDEDC", scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_81E01312A3403EA3C0F95B724025DFF7200FB79A11", scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_836216B5D712E7C83F7F2398E5ED6928CB2F2D376FBBBE60", scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8FBC173B6136974D08F94D428760D2E750D971C2CB06774250", scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_AB031643F64238811AF383B52722567BE6CF4E599BB978CD", scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_8C950E2F42AB5B3BFC5B7958BB07909B", scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  var_0 = getarraykeys(level.helperdronesettings);

  foreach(var_2 in var_0) {
    var_3 = level.helperdronesettings[var_2].hitstokill;

    if(isDefined(var_3)) {
      scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_2, var_3);
      scripts\mp\vehicles\damage::set_weapon_hit_damage_data_for_vehicle("_encstr_B1D20FB2D6077DB34E5673C29156D7DA0E", var_3, var_2);
    }
  }

  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::helperdrone_updateheadicononjointeam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86E50C038828D8FA5595221DF813", "_encstr_A34D19707AD3258855E6099D1FFD70E69733895B31236F58ABC541", ::spawn_addtoarrays);
}

helperdrone_updateheadicononjointeam(var_0) {}

spawn_addtoarrays() {
  if(scripts\mp\utility\game::getgametype() == "_encstr_B607038AAB" && !scripts\mp\flags::gameflag("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F"))
    thread _id_12A97();
}

_id_12A97() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_9196100D8D3E98E8CBF32008EAA790B8D7E4");
  self endon("_encstr_9969107307C2C01041C528880BE9703B35B3");
  scripts\mp\flags::gameflagwait("_encstr_A6411333A22528F70BDF89DFF3624DA0C7BF58088F");
  var_0 = getcompleteweaponname("_encstr_8AEA13B69BBE27956BB7E8B2EB1993DE3795F56B0E");

  if(self hasweapon(var_0))
    scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
}