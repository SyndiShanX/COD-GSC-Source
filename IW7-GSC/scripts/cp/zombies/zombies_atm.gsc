/**********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zombies_atm.gsc
**********************************************/

init_atm() {
  var_0 = scripts\engine\utility::getStructArray("atm_deposit", "script_noteworthy");
  var_1 = scripts\engine\utility::getStructArray("atm_withdrawal", "script_noteworthy");
  var_2 = scripts\engine\utility::array_combine(var_0, var_1);
  level.atm_amount_deposited = 0;
  level.atm_transaction_amount = 1000;
  foreach(var_4 in var_2) {
    var_4 func_3C5A(var_4);
    var_4.var_5237 = 0;
  }
}

func_3C5A(var_0) {
  switch (var_0.script_noteworthy) {
    case "atm_deposit":
      var_1 = scripts\engine\utility::getstruct("atm_deposit_machine", "targetname");
      var_1 thread func_1131B(var_0, var_1, "zmb_atm_machine");
      var_2 = scripts\engine\utility::getStructArray("atm_deposit_screen", "targetname");
      var_2 = sortbydistance(var_2, var_0.origin);
      var_3 = var_2[0];
      var_4 = spawn("script_model", var_3.origin);
      var_4 setModel("tag_origin");
      var_0 thread func_2419(var_3, var_4);
      var_0 thread func_136D2(var_3, var_4, "deposit_made");
      break;

    case "atm_withdrawal":
      var_5 = scripts\engine\utility::getstruct("atm_withdrawal_machine", "targetname");
      var_5 thread func_1131B(var_0, var_5, "zmb_atm_withdraw");
      var_2 = scripts\engine\utility::getStructArray("atm_withdrawal_screen", "targetname");
      var_2 = sortbydistance(var_2, var_0.origin);
      var_3 = var_2[0];
      var_4 = spawn("script_model", var_3.origin);
      var_4 setModel("tag_origin");
      var_0 thread func_2428(var_3, var_4);
      var_0 thread func_136DB(var_3, var_4, "withdrawal_made");
      break;
  }
}

func_136D2(var_0, var_1, var_2) {
  level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
  for(;;) {
    self waittill(var_2);
    var_0.recently_used = 1;
    for(var_3 = 0; var_3 < 4; var_3++) {
      wait(0.25);
      var_1 setModel("zmb_atm_screen_03a");
      wait(0.25);
      var_1 setModel("zmb_atm_screen_03b");
      wait(0.25);
    }

    var_0.recently_used = undefined;
  }
}

func_136DB(var_0, var_1, var_2) {
  level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
  for(;;) {
    self waittill(var_2);
    var_0.recently_used = 1;
    for(var_3 = 0; var_3 < 4; var_3++) {
      wait(0.25);
      var_1 setModel("zmb_atm_screen_04a");
      wait(0.25);
      var_1 setModel("zmb_atm_screen_04b");
      wait(0.25);
    }

    var_0.recently_used = undefined;
  }
}

func_2419(var_0, var_1) {
  level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
  var_1 setModel("zmb_atm_screen_01a");
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  for(;;) {
    wait(1);
    if(scripts\engine\utility::istrue(var_0.recently_used)) {
      continue;
    }

    var_1 setModel("zmb_atm_screen_01a");
    wait(0.5);
    if(scripts\engine\utility::istrue(var_0.recently_used)) {
      continue;
    }

    var_1 setModel("zmb_atm_screen_01b");
  }
}

func_2428(var_0, var_1) {
  level scripts\engine\utility::waittill_any_return("power_on", self.power_area + " power_on", "power_off");
  var_1 setModel("zmb_atm_screen_02a");
  var_1.origin = var_0.origin;
  var_1.angles = var_0.angles;
  for(;;) {
    wait(1);
    if(scripts\engine\utility::istrue(var_0.recently_used)) {
      continue;
    }

    var_1 setModel("zmb_atm_screen_02b");
    wait(0.5);
    if(scripts\engine\utility::istrue(var_0.recently_used)) {
      continue;
    }

    var_1 setModel("zmb_atm_screen_02a");
  }
}

func_1131B(var_0, var_1, var_2) {
  var_3 = spawn("script_model", var_1.origin);
  var_3.origin = var_1.origin;
  var_3.angles = var_1.angles;
  var_3 setModel(var_2);
  var_4 = var_2 + "_on";
  for(;;) {
    var_5 = level scripts\engine\utility::waittill_any_return("power_on", var_0.power_area + " power_on", "power_off");
    if(var_5 != "power_off") {
      var_0.powered_on = 1;
      var_3 setModel(var_4);
      continue;
    }

    if(var_5 == "power_off") {
      var_0.powered_on = 0;
      var_3 setModel(var_2);
    }
  }
}

interaction_atm_deposit(var_0, var_1) {
  var_1 notify("stop_interaction_logic");
  var_1.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited + 1000;
  scripts\cp\cp_interaction::increase_total_deposit_amount(var_1, 1000);
  var_0 notify("deposit_made", var_1);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("atm_deposit", "zmb_comment_vo", "low", 10, 0, 0, 1, 40);
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  if(scripts\cp\cp_interaction::exceed_deposit_limit(var_1)) {
    scripts\cp\cp_interaction::remove_from_current_interaction_list_for_player(var_0, var_1);
  }
}

interaction_atm_withdrawal(var_0, var_1) {
  if(level.atm_amount_deposited < 1000) {
    return;
  }

  playFX(level._effect["atm_withdrawal"], var_0.origin + (-4, 0, 51));
  var_2 = 1000;
  var_1 scripts\cp\cp_persistence::give_player_currency(var_2, undefined, undefined, undefined, "atm");
  var_1 notify("stop_interaction_logic");
  var_1.last_interaction_point = undefined;
  level.atm_amount_deposited = level.atm_amount_deposited - var_2;
  var_1 thread scripts\cp\utility::usegrenadegesture(var_1, "iw7_pickup_zm");
  var_0 notify("withdrawal_made", var_1);
  scripts\cp\zombies\zombie_analytics::log_atmused(1, level.wave_num, var_1);
  var_1 thread scripts\cp\cp_vo::try_to_play_vo("withdraw_cash", "zmb_comment_vo", "low", 10, 0, 1, 0, 40);
}

atm_withdrawal_hint_logic(var_0, var_1) {
  if(var_0.requires_power && !var_0.powered_on) {
    if(isDefined(level.needspowerstring)) {
      return level.needspowerstring;
    } else {
      return &"COOP_INTERACTIONS_REQUIRES_POWER";
    }
  }

  if(isDefined(level.atm_amount_deposited) && level.atm_amount_deposited < 1000) {
    return &"CP_ZMB_INTERACTIONS_ATM_INSUFFICIENT_FUNDS";
  }

  return level.interaction_hintstrings[var_0.script_noteworthy];
}