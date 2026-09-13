/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\killstreaks\chopper_gunner_mp.gsc
********************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("chopper_gunner", scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunnerfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "set_vehicle_hit_damage_data", ::chopper_gunner_set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "findTargetStruct", ::chopper_gunner_findtargetstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "assignTargetMarkers", ::chopper_gunner_assigntargetmarkers);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "attachXRays", ::_id_DACD2CEE9C44366F);
}

chopper_gunner_set_vehicle_hit_damage_data(ref, hitstokill) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(ref, hitstokill);
}

chopper_gunner_findtargetStruct(_id_8571897DAA3F69BF, _id_6E1E1E75FC237EB1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(_id_8571897DAA3F69BF, _id_6E1E1E75FC237EB1);
}

chopper_gunner_assigntargetmarkers() {
  _id_2CD52BBC2A67B7CF = [];
  _id_5408012D0AED529A = [];
  _id_72B9F31491F124AA = level.players;

  foreach(player in _id_72B9F31491F124AA) {
    if(level.teambased && player.team == self.team || player == self.owner) {
      _id_5408012D0AED529A[_id_5408012D0AED529A.size] = player;
      continue;
    }

    if(player scripts\mp\utility\perk::_hasperk("specialty_noscopeoutline")) {
      continue;
    }
    _id_2CD52BBC2A67B7CF[_id_2CD52BBC2A67B7CF.size] = player;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerenemy", self.owner, _id_2CD52BBC2A67B7CF, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("overlaytargetmarkerfriendly", self.owner, _id_5408012D0AED529A, self.owner, 1, 1);
}

_id_DACD2CEE9C44366F(_id_16AADB33939B88FF) {
  _id_16AADB33939B88FF _meth_5226227BCE83EBE9(3, _id_16AADB33939B88FF.team);
  return _id_16AADB33939B88FF;
}