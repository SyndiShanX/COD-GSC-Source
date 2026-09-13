/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\powershud.gsc
***********************************************/

powershud_init() {
  power_hud_info = spawnStruct();
  level.power_hud_info = power_hud_info;
  power_hud_info.omnvarnames = ["primary", "secondary"];
  power_hud_info.omnvarnames["primary"][0] = "ui_power_num_charges";
  power_hud_info.omnvarnames["primary"][1] = "ui_power_max_charges";
  power_hud_info.omnvarnames["primary"][2] = "ui_power_recharge";
  power_hud_info.omnvarnames["primary"][3] = "ui_power_id";
  power_hud_info.omnvarnames["primary"][4] = "ui_power_consume";
  power_hud_info.omnvarnames["primary"][5] = "ui_power_disabled";
  power_hud_info.omnvarnames["primary"][6] = "ui_power_state";
  power_hud_info.omnvarnames["secondary"][0] = "ui_power_secondary_num_charges";
  power_hud_info.omnvarnames["secondary"][1] = "ui_power_secondary_max_charges";
  power_hud_info.omnvarnames["secondary"][2] = "ui_power_secondary_recharge";
  power_hud_info.omnvarnames["secondary"][3] = "ui_power_id_secondary";
  power_hud_info.omnvarnames["secondary"][4] = "ui_power_secondary_consume";
  power_hud_info.omnvarnames["secondary"][5] = "ui_power_secondary_disabled";
  power_hud_info.omnvarnames["secondary"][6] = "ui_power_secondary_state";
}

powershud_assignpower(slot, _id_7D87AEC0310CA8BA, _id_E6A275C0D8D523FE, charges) {
  if(slot == "scripted") {
    return;
  }
  self setclientomnvar(powershud_getslotomnvar(slot, 3), _id_7D87AEC0310CA8BA);
  _id_CACE223E2AFC3C58 = scripts\engine\utility::ter_op(_id_E6A275C0D8D523FE, 1000, 0);
  self setclientomnvar(powershud_getslotomnvar(slot, 2), _id_CACE223E2AFC3C58);

  if(!isDefined(charges))
    charges = 0;

  self setclientomnvar(powershud_getslotomnvar(slot, 0), charges);
  self setclientomnvar(powershud_getslotomnvar(slot, 4), 0);
}

powershud_clearpower(slot) {
  if(slot == "scripted") {
    return;
  }
  self setclientomnvar(powershud_getslotomnvar(slot, 3), -1);
  self setclientomnvar(powershud_getslotomnvar(slot, 2), -1);
  self setclientomnvar(powershud_getslotomnvar(slot, 0), 0);
  self setclientomnvar(powershud_getslotomnvar(slot, 4), -1);
}

powershud_updatepowercharges(slot, charges) {
  self setclientomnvar(powershud_getslotomnvar(slot, 0), int(charges));
}

powershud_updatepowermaxcharges(slot, maxcharges) {
  self setclientomnvar(powershud_getslotomnvar(slot, 1), int(maxcharges));
}

powershud_updatepowerdrain(slot, _id_0BC08C87C9773AE0) {
  self setclientomnvar(powershud_getslotomnvar(slot, 4), _id_0BC08C87C9773AE0);
}

powershud_updatepowermeter(slot, _id_CACE223E2AFC3C58) {
  self setclientomnvar(powershud_getslotomnvar(slot, 2), int(_id_CACE223E2AFC3C58));
}

powershud_updatepowerdisabled(slot, disabled) {
  self setclientomnvar(powershud_getslotomnvar(slot, 5), disabled);
}

powershud_updatepoweroffcooldown(slot, oncooldown) {
  _id_CABC886D846DD979 = scripts\engine\utility::ter_op(oncooldown, 1, 0);
  self setclientomnvar(powershud_getslotomnvar(slot, 6), _id_CABC886D846DD979);
}

powershud_updatepowerstate(slot, state) {
  self setclientomnvar(powershud_getslotomnvar(slot, 6), state);
}

powershud_beginpowerdrain(slot) {
  powershud_updatepowerdrain(slot, 1);
}

powershud_endpowerdrain(slot) {
  powershud_updatepowerdrain(slot, 0);
}

powershud_beginpowercooldown(slot, _id_DF05DA7990D6888F) {
  powershud_updatepowermeter(slot, 0);

  if(isDefined(_id_DF05DA7990D6888F) && _id_DF05DA7990D6888F)
    powershud_updatepowerdisabled(slot, 1);

  powershud_updatepowerstate(slot, 1);
}

powershud_finishpowercooldown(slot, _id_DF05DA7990D6888F) {
  powershud_updatepowermeter(slot, 1000);

  if(isDefined(_id_DF05DA7990D6888F) && _id_DF05DA7990D6888F)
    powershud_updatepowerdisabled(slot, 0);

  if(slot == "primary")
    self playlocalsound("iw8_new_objective_sfx");
  else
    self playlocalsound("iw8_new_objective_sfx");

  powershud_updatepowerstate(slot, 0);
}

powershud_updatepowercooldown(slot, _id_477C1209E5432ABE) {
  powershud_updatepowermeter(slot, 1000 * _id_477C1209E5432ABE);
}

powershud_updatepowerdrainprogress(slot, _id_477C1209E5432ABE) {
  powershud_updatepowermeter(slot, 1000 * _id_477C1209E5432ABE);
}

powershud_getslotomnvar(slot, _id_B09F732395C5D400) {
  if(slot == "scripted") {
    return;
  }
  return level.power_hud_info.omnvarnames[slot][_id_B09F732395C5D400];
}