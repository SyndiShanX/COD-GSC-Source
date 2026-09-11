/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\dialog_utility.gsc
****************************************************/

function operatordialogonplayer(var0, var1, var2, var3, var4) {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }

  if(!isDefined(game["dialog"][var0])) {
    return;
  }

  var5 = self.pers["team"];

  if(level.gametype == "br") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "brGetOperatorTeam")) {
      var5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "brGetOperatorTeam")]](self);
    }
  }

  var6 = getteamoperatorvoicefaction(var5);

  if(isDefined(var4)) {
    var6 = var4;
  }

  var7 = "dx_mpo_" + var6 + "op_" + game["dialog"][var0];
  self queuedialogforplayer(var7, var0, 2, var1, var2, var3);
}

function getteamoperatorvoicefaction(var0) {
  var1 = "us";

  if(scripts\cp_mp\utility\game_utility::ref_140a8()) {
    var1 = "c3";
  } else if(var0 == "axis") {
    var1 = "ru";
  }

  return var1;
}

function playoperatorstaticinterrupt() {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }

  var0 = self;

  if(isDefined(self.owner)) {
    var0 = self.owner;
  }

  if(isPlayer(var0)) {
    var0 queuedialogforplayer("dx_mpo_static_crash", "static_crash", 2);
    return;
  }
}