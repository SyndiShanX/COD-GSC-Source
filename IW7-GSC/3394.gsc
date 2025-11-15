/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3394.gsc
************************/

func_DDAE(param_00, param_01) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(param_00);
  var_02 = 0;
  var_03 = scripts\cp\utility::get_closest_entrance(param_01.origin);
  var_04 = 5184;
  var_05 = anglesToForward(var_03.angles);
  var_05 = scripts\cp\utility::vec_multiply(var_05, -200);
  var_06 = var_03.origin + var_05;
  param_01.var_DDB0 = param_00;
  while(!level.gameended && isDefined(param_01) && scripts\cp\utility::isreallyalive(param_01) && param_01 usebuttonpressed() && !isDefined(param_01.setlasermaterial) || !param_01.setlasermaterial) {
    if(distancesquared(param_01.origin, param_00.origin) > var_04) {
      break;
    }

    var_07 = 10;
    var_08 = var_07;
    var_09 = var_03.barrier.var_C1DE < 6;
    if(isDefined(level.cash_scalar)) {
      var_07 = 10 * level.cash_scalar;
      if(level.cash_scalar > 1) {
        var_08 = int(var_08 / 2);
      }
    }

    var_0A = scripts\cp\zombies\zombie_entrances::func_7B13(var_03);
    if(!isDefined(var_0A)) {
      wait(0.5);
      break;
    }

    if(param_01 scripts\cp\utility::is_consumable_active("faster_window_reboard")) {
      var_07 = 50 * var_0A * level.cash_scalar;
      var_08 = var_08 * var_0A;
      level func_DDB8(var_03);
      level notify("reboard", 1, param_01);
      for(var_0B = 0; var_0B < var_0A; var_0B++) {
        param_01 scripts\cp\cp_merits::processmerit("mt_rebuild_barriers");
      }

      param_01 notify("window_reboard_notify");
      param_01 scripts\cp\utility::notify_used_consumable("faster_window_reboard");
    } else {
      scripts\cp\zombies\zombie_entrances::func_F2E3(var_03, var_0A - 1, "repairing");
      func_DDB6(var_03, var_0A, var_06, param_00, param_01);
      level notify("reboard", 1, param_01);
      param_01 scripts\cp\cp_merits::processmerit("mt_rebuild_barriers");
      param_01 notify("window_reboard_notify");
      scripts\cp\zombies\zombie_entrances::func_F2E3(var_03, var_0A - 1, "boarded");
    }

    param_01.reboarding_points = param_01.reboarding_points + var_08;
    if(isDefined(param_01.reboarding_points) && param_01.reboarding_points <= level.var_B41F && var_09) {
      param_01 playlocalsound("purchase_generic");
      param_01 thread scripts\cp\cp_vo::try_to_play_vo("reinforce_window", "zmb_comment_vo", "low", 10, 0, 0, 0, 10);
      var_02 = 1;
      param_01 scripts\cp\cp_persistence::give_player_currency(var_07);
    }

    var_03.barrier.var_C1DE++;
    if(var_03.barrier.var_C1DE > 6) {
      var_03.barrier.var_C1DE = 6;
    }

    if(!isDefined(scripts\cp\zombies\zombie_entrances::func_7B13(var_03))) {
      break;
    }
  }

  param_01.var_DDB0 = undefined;
  if(var_03.barrier.var_C1DE == 6) {
    param_01 thread scripts\cp\cp_vo::try_to_play_vo("reinforce_window", "zmb_comment_vo", "low", 10, 0, 0, 1, 25);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(param_00);
}

func_DDB4(param_00) {
  var_01 = sortbydistance(level.window_entrances, param_00.origin);
  foreach(var_03 in var_01) {
    if(scripts\cp\utility::entrance_is_fully_repaired(var_03)) {
      continue;
    }

    level thread func_DDB8(var_03);
    wait(0.5);
  }

  var_05 = 200;
  if(isDefined(level.cash_scalar)) {
    var_05 = 200 * level.cash_scalar;
  }

  foreach(var_07 in level.players) {
    if(scripts\engine\utility::istrue(var_07.inlaststand)) {
      continue;
    }

    var_07 scripts\cp\cp_persistence::give_player_currency(var_05, undefined, undefined, 1, "carpenter");
  }
}

func_DDB8(param_00) {
  var_01 = anglesToForward(param_00.angles);
  var_01 = scripts\cp\utility::vec_multiply(var_01, -200);
  var_02 = param_00.origin + var_01;
  var_03 = scripts\engine\utility::getclosest(param_00.origin, level.current_interaction_structs);
  var_04 = 0;
  while(!scripts\cp\utility::entrance_is_fully_repaired(param_00)) {
    if(scripts\cp\utility::entrance_is_fully_repaired(param_00)) {
      return;
    }

    var_05 = scripts\cp\zombies\zombie_entrances::func_7B13(param_00);
    if(!isDefined(var_05)) {
      return;
    }

    func_DDB7(param_00, var_05, var_02, var_03);
  }
}

func_DDB7(param_00, param_01, param_02, param_03) {
  scripts\cp\zombies\zombie_entrances::func_F2E3(param_00, param_01 - 1, "boarded");
  param_00.barrier scripts\cp\zombies\zombie_entrances::func_F2D7("board_" + param_01, "instant_repair");
  wait(0.25);
  param_00.barrier.var_C1DE++;
  if(param_00.barrier.var_C1DE > 6) {
    param_00.barrier.var_C1DE = 6;
  }
}

func_DDB6(param_00, param_01, param_02, param_03, param_04) {
  if(param_04 scripts\cp\utility::has_zombie_perk("perk_machine_flash")) {
    var_05 = 0.5;
    param_00.barrier scripts\cp\zombies\zombie_entrances::func_F2D7("board_" + param_01, "fast_repair");
  } else {
    var_05 = 1;
    param_00.barrier scripts\cp\zombies\zombie_entrances::func_F2D7("board_" + param_01, "repair");
  }

  wait(var_05);
}

register_interactions() {
  if(isDefined(level.reboard_barriers_hint)) {
    level.interaction_hintstrings["secure_window"] = level.reboard_barriers_hint;
  } else {
    level.interaction_hintstrings["secure_window"] = & "CP_ZMB_INTERACTIONS_SECURE_WINDOW";
  }

  scripts\cp\cp_interaction::register_interaction("secure_window", "window_board", 1, undefined, ::func_DDAE, 0);
}