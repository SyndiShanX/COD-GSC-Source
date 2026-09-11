/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_pe_choppers.gsc
**********************************************************************/

function init() {
  level.ref_1229d = &ref_1229e;
  level.ref_12073 = &infilsactive;
}

function infilsactive(var_0, var_1, var_2, var_3) {
  if(var_2 != "br_loot_chopper_box_open") {
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

function ref_1229e() {
  var_0 = getdvarint("scr_br_pe_choppers_score", 2);

  if(isDefined(self.viphud_hidefromplayer) && isPlayer(self.viphud_hidefromplayer) && var_0) {
    level scripts\mp\gamescore::giveteamscoreforobjective(self.viphud_hidefromplayer.team, var_0, 0);
  }

  scripts\mp\gametypes\br_publicevent_choppers::dropcrate();
}