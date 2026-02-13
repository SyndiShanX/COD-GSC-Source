/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_rbz_utility.gsc
*************************************************/

rbz_initialize() {
  level.get_rbz_starting_currency = ::get_rbz_starting_currency;
  level._id_BBEB = scripts\cp\zombies\zm_round_logic::on_forced_respawn;
  level.special_ai_weapon_drop_multiplier = 0.25;
  level.special_ai_raygun_drop_multiplier = 0.25;
  level.rbz_register_ai_drop_table = ::rbz_register_ai_drop_table;
  level.rbz_on_player_hot_join = ::enter_spectator_on_hot_join;
  level thread rbz_jugg_setting();
  level thread register_rbz_magicbox_loots();
  level thread watch_join_in_progress();
}

rbz_jugg_setting() {
  if(!getdvarint("#x3dee089cb49164e4e", 0)) {
    return;
  }
  level.custom_jugg_shoot_cooldown_min = 2000;
  level.custom_jugg_shoot_cooldown_max = 3000;
  level.custom_jugg_sprint_dist_sq = 360000;
  level.jugg_stop_chase_enemy_chance = 0.25;
  level.jugg_can_charge_melee = 1;
}

register_rbz_magicbox_loots() {
  level endon("game_ended");

  while(!isDefined(level._id_9860)) {
    waitframe();
  }

  for(var_0 = 1; var_0 <= 37; var_0++) {
    _id_073D::register_loot_table("magicbox", var_0, "zm_loot_magicbox_rbz_level_" + var_0);
  }
}

register_rbz_rspecial_ai_drop_table() {
  var_0 = 0;
  var_1 = tablelookupgetnumrows("cp/zm_loot_special_enemy_rbz.csv");

  for(var_0 = 0; var_0 < var_1; var_0++) {
    var_2 = tablelookupbyrow("cp/zm_loot_special_enemy_rbz.csv", var_0, 0);
    var_3 = tablelookupbyrow("cp/zm_loot_special_enemy_rbz.csv", var_0, 1);
    var_4 = tablelookupbyrow("cp/zm_loot_special_enemy_rbz.csv", var_0, 2);

    if(var_2 == "" || var_3 == "" || var_4 == "") {
      continue;
    }
    var_3 = int(var_3);
    var_4 = int(var_4);

    if(var_3 > 0 && var_4 == -1) {
      _id_073D::_id_C1C5("special", var_3, var_2);
      _id_073D::_id_C1C5("elite", var_3, var_2);
      continue;
    }

    if(var_4 >= var_3) {
      for(var_5 = var_3; var_5 <= var_4; var_5++) {
        _id_073D::_id_C1C5("special", var_5, var_2);
        _id_073D::_id_C1C5("elite", var_5, var_2);
      }
    }
  }
}

rbz_register_ai_drop_table() {
  var_0 = "zm_loot_normal_enemies_rbz_";
  var_1 = 10;
  var_2 = 3;
  var_3 = 1;

  for(var_4 = 1; var_4 <= var_1; var_4++) {
    for(var_5 = 0; var_5 < var_2; var_5++) {
      _id_073D::_id_C1C5("normal", var_3, var_0 + var_4);
      var_3++;
    }
  }

  register_rbz_rspecial_ai_drop_table();
}

get_rbz_starting_currency() {
  var_0 = 0;

  if(isDefined(level._id_11049)) {
    if(level._id_11049 == 1) {
      var_0 = 500;
    } else if(level._id_11049 == 2) {
      var_0 = 600;
    } else {
      var_0 = level._id_11049 * 1000;
    }
  }

  if(var_0 > 9500) {
    var_0 = 9500;
  }

  return var_0;
}

wait_to_set_player_starting_heart() {
  self endon("disconnect");
  level endon("game_ended");
  self.needinitializeheart = undefined;
  var_0 = 0;

  if(isDefined(level._id_11049)) {
    var_0 = int(level._id_11049 / 3);
  }

  wait 1.0;
  scripts\cp\cp_sacrificial_heart::giveplayersacrificialheart(var_0);
}

wait_to_set_player_starting_salvage() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = 0;
  var_1 = self.starting_salvage_after_revived_from_spectator;

  if(isDefined(var_1)) {
    self.starting_salvage_after_revived_from_spectator = undefined;
    var_0 = var_1;
  } else {
    if(isDefined(level._id_11049)) {
      if(level._id_11049 != 1) {
        if(level._id_11049 == 2) {
          var_0 = 100;
        } else {
          var_0 = level._id_11049 * 100;
        }
      }
    }

    if(var_0 > 900) {
      var_0 = 900;
    }
  }

  wait 1.0;
  _id_075A::_id_826C();
  _id_075A::_id_6FCE(var_0, "Objective");
}

watch_join_in_progress() {
  level endon("game_ended");
  scripts\engine\utility::_id_5C11("rbz_player_join_in_progress");

  for(;;) {
    level waittill("round_complete");
    var_0 = scripts\cp\zombies\zm_round_logic::get_round();

    if(var_0 >= 2) {
      break;
    }
  }

  scripts\engine\utility::_id_5C1B("rbz_player_join_in_progress");
}

enter_spectator_on_hot_join() {
  level endon("game_ended");
  self endon("disconnect");
  waitframe();
  self.is_rbz_hot_join = undefined;
  self._id_E3E5 = 1;
  self._id_24A1 = undefined;
  self.on_initializing = 1;
  self._id_0E05 = 1;
  scripts\cp\utility::_id_1566(1);

  if(!istrue(self._id_9BA4)) {
    _id_072E::_id_FCBD();
  }

  if(isDefined(level._id_54E2)) {
    self thread[[level._id_54E2]]();
  }

  thread watch_auto_respawn();
}

watch_auto_respawn() {
  level endon("game_ended");
  self endon("disconnect");
  self waittill("auto_respawn");
  self._id_E3E5 = undefined;
  self._id_24A1 = undefined;
  scripts\cp\utility::_id_FD26("playing");

  if(scripts\cp\utility::_id_88B5()) {
    scripts\cp\utility::_id_1566(0);
  }

  self._id_0E05 = undefined;

  if(isDefined(level._id_BBEB)) {
    [[level._id_BBEB]](self);
  }

  self[[level._id_E33A]]();
}