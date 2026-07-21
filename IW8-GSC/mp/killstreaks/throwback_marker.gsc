/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\killstreaks\throwback_marker.gsc
***********************************************/

init() {
  scripts\mp\playeractions::registeractionset("_encstr_B4DE118E43E47B7731C21BDAD7B68593DACAC9", ["_encstr_9BE40A0BC09BCEF7C0F33441", "_encstr_8F0508CE59DCA357392B"]);
}

throwbackmarker_trythrowbackmarker(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  var_8 = ::throwbackmarker_weapongiven;
  var_9 = ::throwbackmarker_weaponswitchended;
  var_10 = ::throwbackmarker_weaponfired;
  var_11 = ::throwbackmarker_weapontaken;
  var_0.throwbackmarker_weapondetonatefunc = var_1;
  var_0.throwbackmarker_weapongivenfunc = var_3;
  var_0.throwbackmarker_weaponswitchendedfunc = var_4;
  var_0.throwbackmarker_weaponfiredfunc = var_5;
  var_0.throwbackmarker_weapontakenfunc = var_7;
  var_12 = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_dothrowbackmarkerdeploy(var_0, var_2, var_8, var_9, var_10, var_6, var_11);

  if(!istrue(var_12))
    return 0;

  return 1;
}

throwbackmarker_weapongiven(var_0) {
  var_1 = 1;

  if(isDefined(var_0.throwbackmarker_weapongivenfunc))
    var_1 = level[[var_0.throwbackmarker_weapongivenfunc]](var_0);

  return var_1;
}

throwbackmarker_weaponswitchended(var_0, var_1) {
  if(istrue(var_1))
    thread throwbackmarker_watchplayerweapon(var_0);

  if(isDefined(var_0.throwbackmarker_weaponswitchendedfunc))
    level thread[[var_0.throwbackmarker_weaponswitchendedfunc]](var_0, var_1);
}

throwbackmarker_watchplayerweapon(var_0) {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_8C5C0E95C2C63A5AED9BDCC6B7A30199");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_835C0EF00E5F3B9B32C2427B929587A2");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_8B5C0ECA58B1A32DDE73E6B1DBE804A6");
  self notifyonplayercommand("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_865C0EBE0BCF1BA710C08384685B4A33");
  var_1 = scripts\engine\utility::_id_143AD("_encstr_A61D0E08A6E098C131CF33A5B2BB3A9A", "_encstr_93C2166B057BBBAF08311F07A8639B82AFA63366768922EC");

  if(!isDefined(var_1)) {
    return;
  }
  var_0 notify("_encstr_83602787F79261C014FAC159A4D7A02B4A1F2F097FBAA098515368968FD548D1F2C7FF8F17B2FF907E");
}

throwbackmarker_weaponfired(var_0, var_1, var_2) {
  var_3 = "_encstr_88E30897BDF1B71F7823";
  level thread throwbackmarker_watchdetonate(var_0, var_2, self);
  level thread throwbackmarker_watchthrowback(var_0, var_2);

  if(isDefined(var_0.throwbackmarker_weaponfiredfunc))
    var_3 = [[var_0.throwbackmarker_weaponfiredfunc]](var_0, var_1, var_2);

  return var_3;
}

throwbackmarker_watchdetonate(var_0, var_1, var_2) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 endon("_encstr_8F5C086405E70FBA4B4A");
  var_1 waittill("_encstr_860808CB78E2984063BA", var_3);

  if(isDefined(var_0.throwbackmarker_weapondetonatefunc))
    [[var_0.throwbackmarker_weapondetonatefunc]](var_0, var_3, var_2);
}

throwbackmarker_watchthrowback(var_0, var_1) {
  var_1 endon("_encstr_BE2C0A3EE31BC757F7385A52");
  var_1 waittill("_encstr_8F5C086405E70FBA4B4A", var_2);
  var_2 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_2 waittill("_encstr_9B620D8F0DC07577C551F16A3826BF", var_3, var_4);
  level thread throwbackmarker_watchdetonate(var_0, var_3, var_2);
  level thread throwbackmarker_watchthrowback(var_0, var_3);
  var_2 thread throwbackmarker_takeweapon(var_4);
}

throwbackmarker_takeweapon(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 = 0;

  while(var_1 < 5) {
    if(self hasweapon(var_0))
      scripts\cp_mp\utility\inventory_utility::_takeweapon(var_0);
    else
      var_1 = var_1 + 1;

    wait 0.05;
  }
}

throwbackmarker_weapontaken(var_0) {
  if(isDefined(var_0.throwbackmarker_weapontakenfunc))
    [[var_0.throwbackmarker_weapontakenfunc]](var_0);
}