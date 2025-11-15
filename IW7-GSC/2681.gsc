/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2681.gsc
***************************************/

powershud_init() {
  var_00 = spawnStruct();
  level.power_hud_info = var_00;
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
  var_0.omnvarnames["secondary"][3] = "ui_powerfunc_secondary";
  var_0.omnvarnames["secondary"][4] = "ui_power_secondary_consume";
  var_0.omnvarnames["secondary"][5] = "ui_power_secondary_disabled";
  var_0.omnvarnames["secondary"][6] = "ui_power_secondary_state";
}

powershud_assignpower(var_00, var_01, var_02, var_03) {
  if(var_00 == "scripted") {
    return;
  }
  self setclientomnvar(powershud_getslotomnvar(var_00, 3), var_01);
  var_04 = scripts\engine\utility::ter_op(var_02, 1000, 0);
  self setclientomnvar(powershud_getslotomnvar(var_00, 2), var_04);

  if(!isDefined(var_03))
    var_03 = 0;

  self setclientomnvar(powershud_getslotomnvar(var_00, 0), var_03);
  self setclientomnvar(powershud_getslotomnvar(var_00, 4), 0);
}

powershud_clearpower(var_00) {
  if(var_00 == "scripted") {
    return;
  }
  self setclientomnvar(powershud_getslotomnvar(var_00, 3), -1);
  self setclientomnvar(powershud_getslotomnvar(var_00, 2), -1);
  self setclientomnvar(powershud_getslotomnvar(var_00, 0), 0);
  self setclientomnvar(powershud_getslotomnvar(var_00, 4), -1);
}

powershud_updatepowercharges(var_00, var_01) {
  self setclientomnvar(powershud_getslotomnvar(var_00, 0), int(var_01));
}

powershud_updatepowermaxcharges(var_00, var_01) {
  self setclientomnvar(powershud_getslotomnvar(var_00, 1), int(var_01));
}

powershud_updatepowerdrain(var_00, var_01) {
  self setclientomnvar(powershud_getslotomnvar(var_00, 4), var_01);
}

powershud_updatepowermeter(var_00, var_01) {
  self setclientomnvar(powershud_getslotomnvar(var_00, 2), int(var_01));
}

powershud_updatepowerdisabled(var_00, var_01) {
  self setclientomnvar(powershud_getslotomnvar(var_00, 5), var_01);
}

powershud_updatepoweroffcooldown(var_00, var_01) {
  var_02 = scripts\engine\utility::ter_op(var_01, 1, 0);
  self setclientomnvar(powershud_getslotomnvar(var_00, 6), var_02);
}

powershud_updatepowerstate(var_00, var_01) {
  self setclientomnvar(powershud_getslotomnvar(var_00, 6), var_01);
}

powershud_beginpowerdrain(var_00) {
  powershud_updatepowerdrain(var_00, 1);
}

powershud_endpowerdrain(var_00) {
  powershud_updatepowerdrain(var_00, 0);
}

powershud_beginpowercooldown(var_00, var_01) {
  powershud_updatepowermeter(var_00, 0);

  if(isDefined(var_01) && var_01)
    powershud_updatepowerdisabled(var_00, 1);

  powershud_updatepowerstate(var_00, 1);
}

powershud_finishpowercooldown(var_00, var_01) {
  powershud_updatepowermeter(var_00, 1000);

  if(isDefined(var_01) && var_01)
    powershud_updatepowerdisabled(var_00, 0);

  if(var_00 == "primary")
    self playlocalsound("mp_ability_ready_L1");
  else
    self playlocalsound("mp_ability_ready_R1");

  powershud_updatepowerstate(var_00, 0);
}

powershud_updatepowercooldown(var_00, var_01) {
  powershud_updatepowermeter(var_00, 1000 * var_01);
}

powershud_updatepowerdrainprogress(var_00, var_01) {
  powershud_updatepowermeter(var_00, 1000 * var_01);
}

powershud_getslotomnvar(var_00, var_01) {
  if(var_00 == "scripted") {
    return;
  }
  return level.power_hud_info.omnvarnames[var_00][var_01];
}