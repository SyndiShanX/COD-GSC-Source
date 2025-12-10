/**********************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_atm.gsc
**********************************************/

init_atm() {
  var_00 = scripts\engine\utility::getstructarray("atm_deposit", "script_noteworthy");
  var_01 = scripts\engine\utility::getstructarray("atm_withdrawal", "script_noteworthy");
  var_02 = scripts\engine\utility::array_combine(var_00, var_01);
  level.atm_amount_deposited = 0;
  level.atm_transaction_amount = 1000;
  foreach(var_04 in var_02) {
    var_04 func_3C5A(var_04);
    var_04.var_5237 = 0;
  }
}

func_3C5A(param_00) {
  switch (param_00.script_noteworthy) {
    case "atm_deposit":
      var_01 = scripts\engine\utility::getstruct("atm_deposit_machine", "targetname");
      var_01 thread func_1131B(param_00, var_01, "zmb_atm_machine");
      var_02 = scripts\engine\utility::getstructarray("atm_deposit_screen", "targetname");
      var_02 = sortbydistance(var_02, param_00.origin);
      var_03 = var_02[0];
      var_04 = spawn("script_model", var_03.origin);
      var_04 setModel("tag_origin");
      param_00 thread func_2419(var_03, var_04);
      param_00 thread func_136D2(var_03, var_04, "deposit_made");
      break;

    case "atm_withdrawal":
      var_05 = scripts\engine\utility::getstruct("atm_withdrawal_machine", "targetname");
      var_05 thread func_1131B(param_00, var_05, "zmb_atm_withdraw");
      var_02 = scripts\engine\utility::getstructarray("atm_withdrawal_screen", "targetname");
      var_02 = sortbydistance(var_02, param_00.origin);
      var_03 = var_02[0];
      var_04 = spawn("script_model", var_03.origin);
      var_04 setModel("tag_origin");
      param_00 thread func_2428(var_03, var_04);
      param_00 thread func_136DB(var_03, var_04, "withdrawal_made");
      break;
  }
}

func_136D2(param_00, param_01, param_02) {
  level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
  for(;;) {
    self waittill(param_02);
    param_00.recently_used = 1;
    for(var_03 = 0; var_03 < 4; var_03++) {
      wait(0.25);
      param_01 setModel("zmb_atm_screen_03a");
      wait(0.25);
      param_01 setModel("zmb_atm_screen_03b");
      wait(0.25);
    }

    param_00.recently_used = undefined;
  }
}

func_136DB(param_00, param_01, param_02) {
  level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
  for(;;) {
    self waittill(param_02);
    param_00.recently_used = 1;
    for(var_03 = 0; var_03 < 4; var_03++) {
      wait(0.25);
      param_01 setModel("zmb_atm_screen_04a");
      wait(0.25);
      param_01 setModel("zmb_atm_screen_04b");
      wait(0.25);
    }

    param_00.recently_used = undefined;
  }
}

func_2419(param_00, param_01) {
  level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
  param_01 setModel("zmb_atm_screen_01a");
  param_01.origin = param_00.origin;
  param_01.angles = param_00.angles;
  for(;;) {
    wait(1);
    if(scripts\engine\utility::istrue(param_00.recently_used)) {
      continue;
    }

    param_01 setModel("zmb_atm_screen_01a");
    wait(0.5);
    if(scripts\engine\utility::istrue(param_00.recently_used)) {
      continue;
    }

    param_01 setModel("zmb_atm_screen_01b");
  }
}

func_2428(param_00, param_01) {
  level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
  param_01 setModel("zmb_atm_screen_02a");
  param_01.origin = param_00.origin;
  param_01.angles = param_00.angles;
  for(;;) {
    wait(1);
    if(scripts\engine\utility::istrue(param_00.recently_used)) {
      continue;
    }

    param_01 setModel("zmb_atm_screen_02b");
    wait(0.5);
    if(scripts\engine\utility::istrue(param_00.recently_used)) {
      continue;
    }

    param_01 setModel("zmb_atm_screen_02a");
  }
}

func_1131B(param_00, param_01, param_02) {
  var_03 = spawn("script_model", param_01.origin);
  var_03.origin = param_01.origin;
  var_03.angles = param_01.angles;
  var_03 setModel(param_02);
  var_04 = param_02 + "_on";
  for(;;) {
    var_05 = level scripts\engine\utility::waittill_any_return("power_on", param_00.power_area + " power_on", "power_off");
    if(var_05 != "power_off") {
      param_00.powered_on = 1;
      var_03 setModel(var_04);
      continue;
    }

    if(var_05 == "power_off") {
      param_00.powered_on = 0;
      var_03 setModel(param_02);
    }
  }
}

interaction_atm_deposit(param_00, param_01) {
  param_01 notify("stop_interaction_logic");
  param_01.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited + 1000;
  scripts\cp\cp_interaction::increase_total_deposit_amount(param_01, 1000);
  param_00 notify("deposit_made", param_01);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("atm_deposit", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, param_01);
  if(scripts\cp\cp_interaction::exceed_deposit_limit(param_01)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(param_00, param_01);
  }
}

interaction_atm_withdrawal(param_00, param_01) {
  if(level.atm_amount_deposited < 1000) {
    return;
  }

  playFX(level._effect["atm_withdrawal"], param_00.origin + (-4, 0, 51));
  var_02 = 1000;
  param_01 scripts\cp\cp_persistence::give_player_currency(var_02, undefined, undefined, undefined, "atm");
  param_01 notify("stop_interaction_logic");
  param_01.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited - var_02;
  param_01 thread scripts\cp\utility::usegrenadegesture(param_01, "iw7_pickup_zm");
  param_00 notify("withdrawal_made", param_01);
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, param_01);
  param_01 thread scripts\cp\cp_vo::try_to_play_vo("withdraw_cash", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
}

atm_withdrawal_hint_logic(param_00, param_01) {
  if(param_00.requires_power && !param_00.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000) {
    return &"CP_ZMB_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
  }

  return level.interaction_hintstrings[param_00.script_noteworthy];
}