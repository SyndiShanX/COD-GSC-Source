/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\helper_drone_mp.gsc
******************************************************/

helper_drone_init() {
  _id_041297C155FDEE34::_id_98A4E2A877EF7BB1();
  _id_295B6CC01B40780C::_id_C260CD16A5C5A2D9();
  scripts\mp\killstreaks\killstreaks::registerkillstreak("radar_drone_overwatch", scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\killstreaks\killstreaks::registerkillstreak("scrambler_drone_guard", scripts\cp_mp\killstreaks\helper_drone::tryusehelperdronefromstruct);
  scripts\mp\utility\join_team_aggregator::registeronplayerjointeamcallback(::helperdrone_updateheadicononjointeam);
  scripts\cp_mp\utility\script_utility::registersharedfunc("helper_drone", "attachXRays", ::_id_3E5187005523C45C);
}

helperdrone_updateheadicononjointeam(player) {}

_id_3E5187005523C45C(helperdrone) {
  helperdrone _meth_5226227BCE83EBE9(3, helperdrone.team);
  return helperdrone;
}