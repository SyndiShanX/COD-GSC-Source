/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\gunship_mp.gsc
*************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("gunship", scripts\cp_mp\killstreaks\gunship::tryusegunshipfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "findBoxCenter", ::gunship_findboxcenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "getBombingPoint", ::gunship_getbombingpoint);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "assignTargetMarkers", ::gunship_assigntargetmarkers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "attachXRays", ::_id_719B6CB36FD371A2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "lockOnLaunchers_getTargetArray", scripts\mp\weapons::lockonlaunchers_gettargetarray);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "ResetMissileLauncherLocking", scripts\mp\missilelauncher::resetmissilelauncherlocking);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "missileLauncher_finalizeLock", scripts\mp\missilelauncher::missilelauncher_finalizelock);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "stingTargStruct_create", scripts\mp\missilelauncher::stingtargstruct_create);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "stingTargStruct_getOffsets", scripts\mp\missilelauncher::stingtargstruct_getoffsets);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "stingTargStruct_getOrigins", scripts\mp\missilelauncher::stingtargstruct_getorigins);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "stingTargStruct_getInReticle", scripts\mp\missilelauncher::stingtargstruct_getinreticle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "stingTargStruct_isInReticle", scripts\mp\missilelauncher::stingtargstruct_isinreticle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "stingTargStruct_getInLOS", scripts\mp\missilelauncher::stingtargstruct_getinlos);
  scripts\cp_mp\utility\script_utility::registersharedfunc("gunship", "SoftSightTest", scripts\mp\missilelauncher::softsighttest);

  if(scripts\cp_mp\utility\game_utility::_id_BA5574C7F287C587())
    scripts\mp\utility\lui_game_event_aggregator::registeronluieventcallback(::_id_8D2D971642C69E4C);
}

gunship_findboxcenter(_id_3C59120EE220BF08, _id_C978C20E8E5AA292) {
  return scripts\mp\spawnlogic::findboxcenter(_id_3C59120EE220BF08, _id_C978C20E8E5AA292);
}

gunship_getbombingpoint(_id_01E2777328B6B536, _id_A0EDD3F59D938FB1) {
  _id_BF366EB7073782AF = scripts\cp_mp\killstreaks\toma_strike::tomastrike_getrandombombingpoint(_id_01E2777328B6B536, _id_A0EDD3F59D938FB1);
  return _id_BF366EB7073782AF.point;
}

gunship_assigntargetmarkers(gunner) {
  _id_F73788B68546B5E7 = [];
  _id_5408012D0AED529A = [];

  foreach(player in level.players) {
    if(level.teambased && player.team == self.team || player == self.owner) {
      _id_5408012D0AED529A[_id_5408012D0AED529A.size] = player;
      continue;
    }

    if(player scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }
    _id_F73788B68546B5E7[_id_F73788B68546B5E7.size] = player;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self.owner, _id_F73788B68546B5E7, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerfriendly", self.owner, _id_5408012D0AED529A, self.owner, 1, 1);
}

_id_719B6CB36FD371A2(gunship) {
  gunship _meth_5226227BCE83EBE9(3, gunship.team);
  return gunship;
}

_id_8D2D971642C69E4C(_id_7148C1A6F25491F8, _id_FE4048AD22C35D73) {
  if(_id_7148C1A6F25491F8 != "gunship_weapon_selection") {
    return;
  }
  self notify("gunship_switch_weapon_any", _id_FE4048AD22C35D73);
}