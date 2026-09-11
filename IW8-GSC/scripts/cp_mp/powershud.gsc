/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\powershud.gsc
***********************************************/

function powershud_init() {
  var0 = spawnStruct();
  level.power_hud_info = var0;
  var0.omnvarnames = ["primary", "secondary"];
  var0.omnvarnames["primary"][0] = "ui_power_num_charges";
  var0.omnvarnames["primary"][1] = "ui_power_max_charges";
  var0.omnvarnames["primary"][2] = "ui_power_recharge";
  var0.omnvarnames["primary"][3] = "ui_power_id";
  var0.omnvarnames["primary"][4] = "ui_power_consume";
  var0.omnvarnames["primary"][5] = "ui_power_disabled";
  var0.omnvarnames["primary"][6] = "ui_power_state";
  var0.omnvarnames["secondary"][0] = "ui_power_secondary_num_charges";
  var0.omnvarnames["secondary"][1] = "ui_power_secondary_max_charges";
  var0.omnvarnames["secondary"][2] = "ui_power_secondary_recharge";
  var0.omnvarnames["secondary"][3] = "ui_power_id_secondary";
  var0.omnvarnames["secondary"][4] = "ui_power_secondary_consume";
  var0.omnvarnames["secondary"][5] = "ui_power_secondary_disabled";
  var0.omnvarnames["secondary"][6] = "ui_power_secondary_state";
}

function powershud_assignpower(var0, var1, var2, var3) {
  if(var0 == "scripted") {
    return;
  }

  self setclientomnvar(powershud_getslotomnvar(var0, 3), var1);
  var4 = scripts\engine\utility::ter_op(var2, 1000, 0);
  self setclientomnvar(powershud_getslotomnvar(var0, 2), var4);

  if(!isDefined(var3)) {
    var3 = 0;
  }

  self setclientomnvar(powershud_getslotomnvar(var0, 0), var3);
  self setclientomnvar(powershud_getslotomnvar(var0, 4), 0);
}

function powershud_clearpower(var0) {
  if(var0 == "scripted") {
    return;
  }

  self setclientomnvar(powershud_getslotomnvar(var0, 3), -1);
  self setclientomnvar(powershud_getslotomnvar(var0, 2), -1);
  self setclientomnvar(powershud_getslotomnvar(var0, 0), 0);
  self setclientomnvar(powershud_getslotomnvar(var0, 4), -1);
}

function powershud_updatepowercharges(var0, var1) {
  self setclientomnvar(powershud_getslotomnvar(var0, 0), int(var1));
}

function powershud_updatepowermaxcharges(var0, var1) {
  self setclientomnvar(powershud_getslotomnvar(var0, 1), int(var1));
}

function powershud_updatepowerdrain(var0, var1) {
  self setclientomnvar(powershud_getslotomnvar(var0, 4), var1);
}

function powershud_updatepowermeter(var0, var1) {
  self setclientomnvar(powershud_getslotomnvar(var0, 2), int(var1));
}

function powershud_updatepowerdisabled(var0, var1) {
  self setclientomnvar(powershud_getslotomnvar(var0, 5), var1);
}

function powershud_updatepoweroffcooldown(var0, var1) {
  var2 = scripts\engine\utility::ter_op(var1, 1, 0);
  self setclientomnvar(powershud_getslotomnvar(var0, 6), var2);
}

function powershud_updatepowerstate(var0, var1) {
  self setclientomnvar(powershud_getslotomnvar(var0, 6), var1);
}

function powershud_beginpowerdrain(var0) {
  powershud_updatepowerdrain(var0, 1);
}

function powershud_endpowerdrain(var0) {
  powershud_updatepowerdrain(var0, 0);
}

function powershud_beginpowercooldown(var0, var1) {
  powershud_updatepowermeter(var0, 0);

  if(isDefined(var1) && var1) {
    powershud_updatepowerdisabled(var0, 1);
  }

  powershud_updatepowerstate(var0, 1);
}

function powershud_finishpowercooldown(var0, var1) {
  powershud_updatepowermeter(var0, 1000);

  if(isDefined(var1) && var1) {
    powershud_updatepowerdisabled(var0, 0);
  }

  if(var0 == "primary") {
    self playlocalsound("iw8_new_objective_sfx");
  } else {
    self playlocalsound("iw8_new_objective_sfx");
  }

  powershud_updatepowerstate(var0, 0);
}

function powershud_updatepowercooldown(var0, var1) {
  powershud_updatepowermeter(var0, 1000 * var1);
}

function powershud_updatepowerdrainprogress(var0, var1) {
  powershud_updatepowermeter(var0, 1000 * var1);
}

function powershud_getslotomnvar(var0, var1) {
  if(var0 == "scripted") {
    return;
  }

  return level.power_hud_info.omnvarnames[var0][var1];
}