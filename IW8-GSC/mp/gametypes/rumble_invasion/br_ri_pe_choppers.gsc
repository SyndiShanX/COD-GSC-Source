/**************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_pe_choppers.gsc
**************************************************************/

init() {
  level._id_1229D = ::_id_1229E;
  level._id_12073 = ::infilsactive;
}

infilsactive(var_0, var_1, var_2, var_3) {
  if(var_2 != "_encstr_92611950639191A0EF2CF0D618C78B71C78B41D82AF0BFF8EB2560") {
    return;
  }
  if(!isDefined(var_0) || !isDefined(var_0.team)) {
    return;
  }
  if(!isalive(var_0)) {
    return;
  }
  if(var_1 <= 0) {
    return;
  }
  level scripts\mp\gamescore::giveteamscoreforobjective(var_0.team, var_1, 0);
}

_id_1229E() {
  var_0 = getdvarint("_encstr_B189195780D3FF824DAFAAE768175A87FB8087EBA8AE2B5A5FAEF7", 2);

  if(isDefined(self.viphud_hidefromplayer) && isPlayer(self.viphud_hidefromplayer) && var_0)
    level scripts\mp\gamescore::giveteamscoreforobjective(self.viphud_hidefromplayer.team, var_0, 0);

  _encstr_AD7E3137364EA583A36EF25BE097CE85B6B2A32F83569BCB13E4EBC1571336A5C62BEC2B73A3EB1B0DB71C1C5993B9C59DCDC6::dropcrate();
}