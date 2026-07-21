/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\utility\dialog_utility.gsc
***********************************************/

operatordialogonplayer(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }
  if(!isDefined(game["_encstr_B2DA070A5F8BAB87AF"][var_0])) {
    return;
  }
  var_5 = self.pers["_encstr_8AEF05472BC2D6"];

  if(level.gametype == "_encstr_B607038AAB") {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B472054FE12550", "_encstr_8B711228CE176F916F0B082BEBE4DF3D8F3B596A"))
      var_5 = [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8B711228CE176F916F0B082BEBE4DF3D8F3B596A")]](self);
  }

  var_6 = getteamoperatorvoicefaction(var_5);

  if(isDefined(var_4))
    var_6 = var_4;

  var_7 = "_encstr_84690847F92EFD1AD01F" + var_6 + "_encstr_8A19045A2817" + game["_encstr_B2DA070A5F8BAB87AF"][var_0];
  self queuedialogforplayer(var_7, var_0, 2, var_1, var_2, var_3);
}

getteamoperatorvoicefaction(var_0) {
  var_1 = "_encstr_92070365B6";

  if(scripts\cp_mp\utility\game_utility::_id_140A8())
    var_1 = "_encstr_A70703DF2B";
  else if(var_0 == "_encstr_8E8405EA382B2A")
    var_1 = "_encstr_9107031585";

  return var_1;
}

playoperatorstaticinterrupt() {
  if(istrue(level.little_bird_mg_mp_init)) {
    return;
  }
  var_0 = self;

  if(isDefined(self.owner))
    var_0 = self.owner;

  if(isPlayer(var_0))
    var_0 queuedialogforplayer("_encstr_A7FF14149828D24B88F1DBC3C92BB3B6CFCE933F7B68", "_encstr_B6D90DDC1D1647A56CD7369358E6A1", 2);
}