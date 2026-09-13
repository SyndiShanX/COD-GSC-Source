/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\killstreaks\chopper_gunner_cp.gsc
********************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "set_vehicle_hit_damage_data", ::chopper_gunner_set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "findTargetStruct", ::chopper_gunner_findtargetstruct);

  if(!scripts\cp\utility::is_specops_gametype())
    scripts\cp_mp\utility\script_utility::registersharedfunc("chopper_gunner", "assignTargetMarkers", ::chopper_gunner_assigntargetmarkers);
}

chopper_gunner_set_vehicle_hit_damage_data(ref, hitstokill) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(ref, hitstokill);
}

chopper_gunner_findtargetStruct(_id_8571897DAA3F69BF, _id_6E1E1E75FC237EB1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(_id_8571897DAA3F69BF, _id_6E1E1E75FC237EB1);
}

chopper_gunner_assigntargetmarkers() {
  _id_2CD52BBC2A67B7CF = [];
  _id_FF93381949523976 = [];
  _id_4496855DEC276732 = [];
  _id_01D4621C77C9108F = scripts\cp\cp_agent_utils::getactiveenemyagents("allies");
  _id_45D25409ACB2D4F9 = level.players;
  _id_EBA1C5743194000D = [];

  if(isDefined(level.killstreak_additional_targets)) {
    foreach(target in level.killstreak_additional_targets)
    _id_EBA1C5743194000D = scripts\engine\utility::array_add(_id_EBA1C5743194000D, target);
  }

  _id_4496855DEC276732 = scripts\engine\utility::array_combine(_id_EBA1C5743194000D, _id_01D4621C77C9108F, _id_45D25409ACB2D4F9);

  foreach(enemy in _id_4496855DEC276732) {
    if(!isDefined(enemy.team)) {
      continue;
    }
    if(level.teambased && enemy.team == self.team) {
      continue;
    }
    if(enemy == self.owner) {
      continue;
    }
    if(enemy scripts\cp\utility::_hasperk("specialty_noscopeoutline")) {
      continue;
    }
    _id_2CD52BBC2A67B7CF[_id_2CD52BBC2A67B7CF.size] = enemy;
  }

  foreach(player in _id_45D25409ACB2D4F9) {
    if(level.teambased && player.team != self.team) {
      continue;
    }
    _id_FF93381949523976[_id_FF93381949523976.size] = player;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionenemydefault", self.owner, _id_2CD52BBC2A67B7CF, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("thermalvisionfriendlydefault", self.owner, _id_FF93381949523976, self.owner, 1, 1);
  level thread chopper_gunner_assignedtargetmarkers_onnewai(self.enemytargetmarkergroup, 0);
}

chopper_gunner_assignedtargetmarkers_onnewai(_id_4226C12910D867D4, _id_262F4B55AA151DE1) {
  level endon("game_ended ");
  level endon("removed_targetMarkerGroup_" + _id_4226C12910D867D4);

  for(;;) {
    level waittill("spawned_group_soldier", soldier);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(soldier, _id_4226C12910D867D4, _id_262F4B55AA151DE1);
  }
}