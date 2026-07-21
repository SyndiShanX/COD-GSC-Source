/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\gunship_mp.gsc
***********************************************/

init() {
  scripts\mp\killstreaks\killstreaks::registerkillstreak("_encstr_86FD08B775CD07DC1338", scripts\cp_mp\killstreaks\gunship::tryusegunshipfromstruct);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_BA150EC95C66282EE2FBA7E38B7BF5C0", ::gunship_findboxcenter);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_AD2610CABAF523255B9BB2E034139702403B", ::set_unloadtype_at_end_path);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_86FD08B775CD07DC1338", "_encstr_9A54146BDB7AE82C23D1A1CB0AE75D311632E7EB6222", ::gunship_assigntargetmarkers);
}

gunship_findboxcenter(var_0, var_1) {
  return scripts\mp\spawnlogic::findboxcenter(var_0, var_1);
}

set_unloadtype_at_end_path(var_0, var_1) {
  var_2 = scripts\cp_mp\killstreaks\toma_strike::_id_13BD6(var_0, var_1);
  return var_2.point;
}

gunship_assigntargetmarkers(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in level.players) {
    if(level.teambased && var_4.team == self.team || var_4 == self.owner) {
      var_2[var_2.size] = var_4;
      continue;
    }

    if(var_4 scripts\mp\utility\perk::_hasperk("_encstr_AF36191733A246B0611D833AC94648867AE789B337CB95A0B175A9")) {
      continue;
    }
    var_1[var_1.size] = var_4;
  }

  self.enemytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_85041AA3432B9CDA0BB13BB437A57B73AC73CA6B5E91AC33C25D8DA3", self.owner, var_1, self.owner, 0, 1, 1);
  self.friendlytargetmarkergroup = scripts\cp_mp\targetmarkergroups::targetmarkergroup_on("_encstr_8AA71D73E46590B11AA3F5F3E7A288383EFA58290DCCD873A26FDDEB979A4D", self.owner, var_2, self.owner, 1, 1);
}