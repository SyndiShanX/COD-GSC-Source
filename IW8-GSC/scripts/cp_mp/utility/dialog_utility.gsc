/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\dialog_utility.gsc
****************************************************/

function operatordialogonplayer(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }

  if(!isDefined(game["dialog"][var_0])) {
    return;
  }

  var_5 = self.pers["team"];

  if(level.gametype == "br") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "brGetOperatorTeam")) {
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "brGetOperatorTeam")]](self);
    }
  }

  var_6 = getteamoperatorvoicefaction(var_5);

  if(isDefined(var_4)) {
    var_6 = var_4;
  }

  var_7 = "dx_mpo_" + var_6 + "op_" + game["dialog"][var_0];
  self queuedialogforplayer(var_7, var_0, 2, var_1, var_2, var_3);
}

function getteamoperatorvoicefaction(var_0) {
  var_1 = "us";

  if(scripts\cp_mp\utility\game_utility::ref_140a8()) {
    var_1 = "c3";
  } else if(var_0 == "axis") {
    var_1 = "ru";
  }

  return var_1;
}

function playoperatorstaticinterrupt() {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }

  var_0 = self;

  if(isDefined(self.owner)) {
    var_0 = self.owner;
  }

  if(isPlayer(var_0)) {
    var_0 queuedialogforplayer("dx_mpo_static_crash", "static_crash", 2);
    return;
  }
}