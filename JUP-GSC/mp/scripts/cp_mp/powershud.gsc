/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\cp_mp\powershud.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace powershud;

function powershud_init() {
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

function powershud_assignpower(slot, power_id, fill_meter, charges) {
  if(slot == "scripted") {
    return;
  }

  self setclientomnvar(powershud_getslotomnvar(slot, 3), power_id);
  meter_value = ter_op(fill_meter, 1000, 0);
  self setclientomnvar(powershud_getslotomnvar(slot, 2), meter_value);

  if(!isDefined(charges)) {
    charges = 0;
  }

  self setclientomnvar(powershud_getslotomnvar(slot, 0), charges);
  self setclientomnvar(powershud_getslotomnvar(slot, 4), 0);
}

function powershud_clearpower(slot) {
  if(slot == "scripted") {
    return;
  }

  self setclientomnvar(powershud_getslotomnvar(slot, 3), -1);
  self setclientomnvar(powershud_getslotomnvar(slot, 2), -1);
  self setclientomnvar(powershud_getslotomnvar(slot, 0), 0);
  self setclientomnvar(powershud_getslotomnvar(slot, 4), -1);
}

function powershud_updatepowercharges(slot, charges) {
  self setclientomnvar(powershud_getslotomnvar(slot, 0), int(charges));
}

function powershud_updatepowermaxcharges(slot, maxcharges) {
  self setclientomnvar(powershud_getslotomnvar(slot, 1), int(maxcharges));
}

function powershud_updatepowerdrain(slot, var_bc08c87c9773ae0) {
  self setclientomnvar(powershud_getslotomnvar(slot, 4), var_bc08c87c9773ae0);
}

function powershud_updatepowermeter(slot, meter_value) {
  self setclientomnvar(powershud_getslotomnvar(slot, 2), int(meter_value));
}

function powershud_updatepowerdisabled(slot, disabled) {
  self setclientomnvar(powershud_getslotomnvar(slot, 5), disabled);
}

function powershud_updatepoweroffcooldown(slot, oncooldown) {
  var_cabc886d846dd979 = ter_op(oncooldown, 1, 0);
  self setclientomnvar(powershud_getslotomnvar(slot, 6), var_cabc886d846dd979);
}

function powershud_updatepowerstate(slot, state) {
  self setclientomnvar(powershud_getslotomnvar(slot, 6), state);
}

function powershud_beginpowerdrain(slot) {
  powershud_updatepowerdrain(slot, 1);
}

function powershud_endpowerdrain(slot) {
  powershud_updatepowerdrain(slot, 0);
}

function powershud_beginpowercooldown(slot, var_df05da7990d6888f) {
  powershud_updatepowermeter(slot, 0);

  if(isDefined(var_df05da7990d6888f) && var_df05da7990d6888f) {
    powershud_updatepowerdisabled(slot, 1);
  }

  powershud_updatepowerstate(slot, 1);
}

function powershud_finishpowercooldown(slot, var_df05da7990d6888f) {
  powershud_updatepowermeter(slot, 1000);

  if(isDefined(var_df05da7990d6888f) && var_df05da7990d6888f) {
    powershud_updatepowerdisabled(slot, 0);
  }

  if(slot == "primary") {
    self playlocalsound("iw8_new_objective_sfx");
  } else {
    self playlocalsound("iw8_new_objective_sfx");
  }

  powershud_updatepowerstate(slot, 0);
}

function powershud_updatepowercooldown(slot, percent) {
  powershud_updatepowermeter(slot, 1000 * percent);
}

function powershud_updatepowerdrainprogress(slot, percent) {
  powershud_updatepowermeter(slot, 1000 * percent);
}

function powershud_getslotomnvar(slot, var_b09f732395c5d400) {
  if(slot == "scripted") {
    return;
  }

  assert(isDefined(level.power_hud_info));
  assert(isDefined(level.power_hud_info.omnvarnames));
  assert(isDefined(level.power_hud_info.omnvarnames[slot]));
  return level.power_hud_info.omnvarnames[slot][var_b09f732395c5d400];
}