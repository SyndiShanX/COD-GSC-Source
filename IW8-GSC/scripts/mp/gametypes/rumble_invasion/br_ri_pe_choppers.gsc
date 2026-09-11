/**********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\rumble_invasion\br_ri_pe_choppers.gsc
**********************************************************************/

function init() {
  level.ref_1229d = &ref_1229e;
  level.ref_12073 = &infilsactive;
}

function infilsactive(var0, var1, var2, var3) {
  if(var2 != "br_loot_chopper_box_open") {
    return;
  }

  if(!isDefined(var0) || !isDefined(var0.team)) {
    return;
  }

  if(!isalive(var0)) {
    return;
  }

  if(var1 <= 0) {
    return;
  }

  level scripts\mp\gamescore::giveteamscoreforobjective(var0.team, var1, 0);
}

function ref_1229e() {
  var0 = getdvarint("scr_br_pe_choppers_score", 2);

  if(isDefined(self.viphud_hidefromplayer) && isPlayer(self.viphud_hidefromplayer) && var0) {
    level scripts\mp\gamescore::giveteamscoreforobjective(self.viphud_hidefromplayer.team, var0, 0);
  }

  scripts\mp\gametypes\br_publicevent_choppers::dropcrate();
}