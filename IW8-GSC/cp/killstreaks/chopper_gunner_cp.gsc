/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\killstreaks\chopper_gunner_cp.gsc
************************************************/

init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_95831CCD95E8EBEC9534D2C6C6CA7DD04B477DC8C2B52C3B957D8C858E16", ::chopper_gunner_set_vehicle_hit_damage_data);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_AA991133969B23A20BC97656E86AA3E4ABD847", ::chopper_gunner_findtargetstruct);

  if(!scripts\cp\utility::tryingtoleave())
    scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A3330F40DA85816BFF02D8CCFD2B50632A", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222", ::givephteamscore);
}

chopper_gunner_set_vehicle_hit_damage_data(var_0, var_1) {
  scripts\cp\vehicles\damage_cp::set_vehicle_hit_damage_data(var_0, var_1);
}

chopper_gunner_findtargetStruct(var_0, var_1) {
  return scripts\cp_mp\killstreaks\chopper_support::choppersupport_findtargetStruct(var_0, var_1);
}

givephteamscore() {
  var_0 = [];
  var_1 = [];
  var_2 = [];
  var_3 = scripts\cp\cp_agent_utils::getactiveenemyagents("_encstr_9A8507BA4040188D08");
  var_4 = level.players;
  var_5 = [];

  if(isDefined(level.vo_paratroopers)) {
    foreach(var_7 in level.vo_paratroopers)
    var_5 = scripts\engine\utility::array_add(var_5, var_7);
  }

  var_2 = scripts\engine\utility::array_combine(var_5, var_3, var_4);

  foreach(var_10 in var_2) {
    if(!isDefined(var_10.team)) {
      continue;
    }
    if(level.teambased && var_10.team == self.team) {
      continue;
    }
    if(var_10 == self.owner) {
      continue;
    }
    if(var_10 scripts\cp\utility::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
      continue;
    }
    var_0[var_0.size] = var_10;
  }

  foreach(var_13 in var_4) {
    if(level.teambased && var_13.team != self.team) {
      continue;
    }
    var_1[var_1.size] = var_13;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_85041AA3432B9CDA0BB13BB437A57B73AC73CA6B5E91AC33C25D8DA3", self.owner, var_0, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", self.owner, var_1, self.owner, 1, 1);
  level thread given_achievement(self.enemytargetmarkergroup, 0);
}

given_achievement(var_0, var_1) {
  level endon("_encstr_BD710C3A61F9C78170BD0C15B182");
  level endon("_encstr_A6E91BE81F37BAFB10A4D0AB6FB0B7478CC9386A73E97260A30FBBF350" + var_0);

  for(;;) {
    level waittill("_encstr_A3DD1637382CEEDC56C8EBEC27DEAB83AFCD7B63C84B569C", var_2);
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_markentity(var_2, var_0, var_1);
  }
}