/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2f5a7fde37cb4ee8.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("hover_jet", _id_1EDDEC53ABF6E24C::tryusehoverjetfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hover_jet", "set_vehicle_hit_damage_data", ::_id_C414D20013783E62);
  scripts\cp_mp\utility\script_utility::registersharedfunc("hover_jet", "registerSentient", ::_id_C8ABABCAC24AD291);
}

_id_C414D20013783E62(ref, hitstokill) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(ref, hitstokill);
}

_id_C8ABABCAC24AD291(threatbiasgroup, _id_5C00772332CE642C) {
  scripts\mp\sentientpoolmanager::registersentient(threatbiasgroup, _id_5C00772332CE642C);
}