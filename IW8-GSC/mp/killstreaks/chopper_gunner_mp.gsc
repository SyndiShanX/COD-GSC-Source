/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\chopper_gunner_mp.gsc
************************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", scripts\cp_mp\killstreaks\chopper_gunner::tryusechoppergunnerfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_95831CCD95E8EBEC9534D2C6C6CA7DD04B477DC8C2B52C3B957D8C858E16", ::chopper_gunner_set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_AA991133969B23A20BC97656E86AA3E4ABD847", ::chopper_gunner_findtargetstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222", ::givephteamscore);
}

chopper_gunner_set_vehicle_hit_damage_data(var_0, var_1) {
  scripts\mp\vehicles\damage::set_vehicle_hit_damage_data(var_0, var_1);
}

chopper_gunner_findtargetStruct(var_0, var_1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var_0, var_1);
}

givephteamscore() {
  var_0 = [];
  var_1 = [];
  var_2 = level.players;

  foreach(var_4 in var_2) {
    if(level.teambased && var_4.team == self.team || var_4 == self.owner) {
      var_1[var_1.size] = var_4;
      continue;
    }

    if(var_4 scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
      continue;
    }
    var_0[var_0.size] = var_4;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_85041AA3432B9CDA0BB13BB437A57B73AC73CA6B5E91AC33C25D8DA3", self.owner, var_0, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", self.owner, var_1, self.owner, 1, 1);
}