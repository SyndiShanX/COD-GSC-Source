/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3394.gsc
************************/

func_DDAE(var_0, var_1) {
  scripts\cp\cp_interaction::remove_from_current_interaction_list(var_0);
  var_2 = 0;
  var_3 = scripts\cp\utility::get_closest_entrance(var_1.origin);
  var_4 = 5184;
  var_5 = anglesToForward(var_3.angles);
  var_5 = scripts\cp\utility::vec_multiply(var_5, -200);
  var_6 = var_3.origin + var_5;
  var_1.var_DDB0 = var_0;
  while(!level.gameended && isDefined(var_1) && scripts\cp\utility::isreallyalive(var_1) && var_1 usebuttonpressed() && !isDefined(var_1.setlasermaterial) || !var_1.setlasermaterial) {
    if(distancesquared(var_1.origin, var_0.origin) > var_4) {
      break;
    }

    var_7 = 10;
    var_8 = var_7;
    var_9 = var_3.barrier.var_C1DE < 6;
    if(isDefined(level.cash_scalar)) {
      var_7 = 10 * level.cash_scalar;
      if(level.cash_scalar > 1) {
        var_8 = int(var_8 / 2);
      }
    }

    var_0A = scripts\cp\zombies\zombie_entrances::func_7B13(var_3);
    if(!isDefined(var_0A)) {
      wait(0.5);
      break;
    }

    if(var_1 scripts\cp\utility::is_consumable_active("faster_window_reboard")) {
      var_7 = 50 * var_0A * level.cash_scalar;
      var_8 = var_8 * var_0A;
      level func_DDB8(var_3);
      level notify("reboard", 1, var_1);
      for(var_0B = 0; var_0B < var_0A; var_0B++) {
        var_1 scripts\cp\cp_merits::processmerit("mt_rebuild_barriers");
      }

      var_1 notify("window_reboard_notify");
      var_1 scripts\cp\utility::notify_used_consumable("faster_window_reboard");
    } else {
      scripts\cp\zombies\zombie_entrances::func_F2E3(var_3, var_0A - 1, "repairing");
      func_DDB6(var_3, var_0A, var_6, var_0, var_1);
      level notify("reboard", 1, var_1);
      var_1 scripts\cp\cp_merits::processmerit("mt_rebuild_barriers");
      var_1 notify("window_reboard_notify");
      scripts\cp\zombies\zombie_entrances::func_F2E3(var_3, var_0A - 1, "boarded");
    }

    var_1.reboarding_points = var_1.reboarding_points + var_8;
    if(isDefined(var_1.reboarding_points) && var_1.reboarding_points <= level.var_B41F && var_9) {
      var_1 playlocalsound("purchase_generic");
      var_1 thread scripts\cp\cp_vo::try_to_play_vo("reinforce_window", "zmb_comment_vo", "low", 10, 0, 0, 0, 10);
      var_2 = 1;
      var_1 scripts\cp\cp_persistence::give_player_currency(var_7);
    }

    var_3.barrier.var_C1DE++;
    if(var_3.barrier.var_C1DE > 6) {
      var_3.barrier.var_C1DE = 6;
    }

    if(!isDefined(scripts\cp\zombies\zombie_entrances::func_7B13(var_3))) {
      break;
    }
  }

  var_1.var_DDB0 = undefined;
  if(var_3.barrier.var_C1DE == 6) {
    var_1 thread scripts\cp\cp_vo::try_to_play_vo("reinforce_window", "zmb_comment_vo", "low", 10, 0, 0, 1, 25);
  }

  scripts\cp\cp_interaction::add_to_current_interaction_list(var_0);
}

func_DDB4(var_0) {
  var_1 = sortbydistance(level.window_entrances, var_0.origin);
  foreach(var_3 in var_1) {
    if(scripts\cp\utility::entrance_is_fully_repaired(var_3)) {
      continue;
    }

    level thread func_DDB8(var_3);
    wait(0.5);
  }

  var_5 = 200;
  if(isDefined(level.cash_scalar)) {
    var_5 = 200 * level.cash_scalar;
  }

  foreach(var_7 in level.players) {
    if(scripts\engine\utility::istrue(var_7.inlaststand)) {
      continue;
    }

    var_7 scripts\cp\cp_persistence::give_player_currency(var_5, undefined, undefined, 1, "carpenter");
  }
}

func_DDB8(var_0) {
  var_1 = anglesToForward(var_0.angles);
  var_1 = scripts\cp\utility::vec_multiply(var_1, -200);
  var_2 = var_0.origin + var_1;
  var_3 = scripts\engine\utility::getclosest(var_0.origin, level.current_interaction_structs);
  var_4 = 0;
  while(!scripts\cp\utility::entrance_is_fully_repaired(var_0)) {
    if(scripts\cp\utility::entrance_is_fully_repaired(var_0)) {
      return;
    }

    var_5 = scripts\cp\zombies\zombie_entrances::func_7B13(var_0);
    if(!isDefined(var_5)) {
      return;
    }

    func_DDB7(var_0, var_5, var_2, var_3);
  }
}

func_DDB7(var_0, var_1, var_2, var_3) {
  scripts\cp\zombies\zombie_entrances::func_F2E3(var_0, var_1 - 1, "boarded");
  var_0.barrier scripts\cp\zombies\zombie_entrances::func_F2D7("board_" + var_1, "instant_repair");
  wait(0.25);
  var_0.barrier.var_C1DE++;
  if(var_0.barrier.var_C1DE > 6) {
    var_0.barrier.var_C1DE = 6;
  }
}

func_DDB6(var_0, var_1, var_2, var_3, var_4) {
  if(var_4 scripts\cp\utility::has_zombie_perk("perk_machine_flash")) {
    var_5 = 0.5;
    var_0.barrier scripts\cp\zombies\zombie_entrances::func_F2D7("board_" + var_1, "fast_repair");
  } else {
    var_5 = 1;
    var_0.barrier scripts\cp\zombies\zombie_entrances::func_F2D7("board_" + var_1, "repair");
  }

  wait(var_5);
}

register_interactions() {
  if(isDefined(level.reboard_barriers_hint)) {
    level.interaction_hintstrings["secure_window"] = level.reboard_barriers_hint;
  } else {
    level.interaction_hintstrings["secure_window"] = &"CP_ZMB_INTERACTIONS_SECURE_WINDOW";
  }

  scripts\cp\cp_interaction::register_interaction("secure_window", "window_board", 1, undefined, ::func_DDAE, 0);
}