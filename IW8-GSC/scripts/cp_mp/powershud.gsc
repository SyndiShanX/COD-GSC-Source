/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\powershud.gsc
***********************************************/

function powershud_init() {
  var_0 = spawnStruct();
  level.power_hud_info = var_0;
  var_0.omnvarnames = ["primary", "secondary"];
  var_0.omnvarnames["primary"][0] = "ui_power_num_charges";
  var_0.omnvarnames["primary"][1] = "ui_power_max_charges";
  var_0.omnvarnames["primary"][2] = "ui_power_recharge";
  var_0.omnvarnames["primary"][3] = "ui_power_id";
  var_0.omnvarnames["primary"][4] = "ui_power_consume";
  var_0.omnvarnames["primary"][5] = "ui_power_disabled";
  var_0.omnvarnames["primary"][6] = "ui_power_state";
  var_0.omnvarnames["secondary"][0] = "ui_power_secondary_num_charges";
  var_0.omnvarnames["secondary"][1] = "ui_power_secondary_max_charges";
  var_0.omnvarnames["secondary"][2] = "ui_power_secondary_recharge";
  var_0.omnvarnames["secondary"][3] = "ui_power_id_secondary";
  var_0.omnvarnames["secondary"][4] = "ui_power_secondary_consume";
  var_0.omnvarnames["secondary"][5] = "ui_power_secondary_disabled";
  var_0.omnvarnames["secondary"][6] = "ui_power_secondary_state";
}

function powershud_assignpower(var_0, var_1, var_2, var_3) {
  if(var_0 == "scripted") {
    return;
  }

  self setclientomnvar(powershud_getslotomnvar(var_0, 3), var_1);
  var_4 = scripts\engine\utility::ter_op(var_2, 1000, 0);
  self setclientomnvar(powershud_getslotomnvar(var_0, 2), var_4);

  if(!isDefined(var_3)) {
    var_3 = 0;
  }

  self setclientomnvar(powershud_getslotomnvar(var_0, 0), var_3);
  self setclientomnvar(powershud_getslotomnvar(var_0, 4), 0);
}

function powershud_clearpower(var_0) {
  if(var_0 == "scripted") {
    return;
  }

  self setclientomnvar(powershud_getslotomnvar(var_0, 3), -1);
  self setclientomnvar(powershud_getslotomnvar(var_0, 2), -1);
  self setclientomnvar(powershud_getslotomnvar(var_0, 0), 0);
  self setclientomnvar(powershud_getslotomnvar(var_0, 4), -1);
}

function powershud_updatepowercharges(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 0), int(var_1));
}

function powershud_updatepowermaxcharges(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 1), int(var_1));
}

function powershud_updatepowerdrain(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 4), var_1);
}

function powershud_updatepowermeter(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 2), int(var_1));
}

function powershud_updatepowerdisabled(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 5), var_1);
}

function powershud_updatepoweroffcooldown(var_0, var_1) {
  var_2 = scripts\engine\utility::ter_op(var_1, 1, 0);
  self setclientomnvar(powershud_getslotomnvar(var_0, 6), var_2);
}

function powershud_updatepowerstate(var_0, var_1) {
  self setclientomnvar(powershud_getslotomnvar(var_0, 6), var_1);
}

function powershud_beginpowerdrain(var_0) {
  powershud_updatepowerdrain(var_0, 1);
}

function powershud_endpowerdrain(var_0) {
  powershud_updatepowerdrain(var_0, 0);
}

function powershud_beginpowercooldown(var_0, var_1) {
  powershud_updatepowermeter(var_0, 0);

  if(isDefined(var_1) && var_1) {
    powershud_updatepowerdisabled(var_0, 1);
  }

  powershud_updatepowerstate(var_0, 1);
}

function powershud_finishpowercooldown(var_0, var_1) {
  powershud_updatepowermeter(var_0, 1000);

  if(isDefined(var_1) && var_1) {
    powershud_updatepowerdisabled(var_0, 0);
  }

  if(var_0 == "primary") {
    self playlocalsound("iw8_new_objective_sfx");
  } else {
    self playlocalsound("iw8_new_objective_sfx");
  }

  powershud_updatepowerstate(var_0, 0);
}

function powershud_updatepowercooldown(var_0, var_1) {
  powershud_updatepowermeter(var_0, 1000 * var_1);
}

function powershud_updatepowerdrainprogress(var_0, var_1) {
  powershud_updatepowermeter(var_0, 1000 * var_1);
}

function powershud_getslotomnvar(var_0, var_1) {
  if(var_0 == "scripted") {
    return;
  }

  return level.power_hud_info.omnvarnames[var_0][var_1];
}