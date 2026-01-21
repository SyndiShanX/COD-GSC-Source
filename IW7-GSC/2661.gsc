/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2661.gsc
**************************************/

give_attacker_kill_rewards(var_0, var_1) {
  if(self.team == "allies") {
    return;
  }
  if(scripts\engine\utility::is_true(self.died_poorly)) {
    return;
  }
  if(scripts\cp\cp_agent_utils::get_agent_type(self) == "elite" || scripts\cp\cp_agent_utils::get_agent_type(self) == "mammoth") {
    var_2 = get_reward_point_for_kill();

    foreach(var_4 in level.players) {
      givekillreward(var_4, var_2, "large");
    }

    return;
  }

  if(isDefined(self.attacker_damage) || isDefined(self.marked_by_hybrid)) {
    if(isDefined(self.marked_by_hybrid)) {
      foreach(var_4 in level.players) {
        if(isDefined(self.player_who_tagged) && self.player_who_tagged == var_4 && var_4 != var_0) {
          var_7 = getassistbonusamount();

          if(isDefined(level.cash_scalar)) {
            var_7 = var_7 * level.cash_scalar;
          }

          givekillreward(var_4, var_7 * 2);
          var_4 scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
          self.hybrid_assist = 1;
        }
      }
    }

    if(!isDefined(self.hybrid_assist)) {
      var_9 = 0.1;
      var_10 = self.maxhealth * var_9;
      var_7 = getassistbonusamount();

      if(isDefined(level.cash_scalar)) {
        var_7 = var_7 * level.cash_scalar;
      }

      foreach(var_12 in self.attacker_damage) {
        if(var_12.player == var_0 || isDefined(var_0.owner) && var_12.player == var_0.owner) {
          continue;
        }
        if(var_12.damage >= var_10) {
          if(isDefined(var_12.player) && var_12.player != var_0) {
            var_12.player scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
            givekillreward(var_12.player, var_7);
          }
        }
      }
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(!isplayer(var_0) && (!isDefined(var_0.owner) || !isplayer(var_0.owner))) {
    return;
  }
  var_14 = 0;

  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
    var_14 = 1;
  }

  var_2 = get_reward_point_for_kill();

  if(isDefined(var_1) && var_1 == "soft" && !var_14) {
    var_2 = int(var_2 * 1.5);
  }

  givekillreward(var_0, var_2, "large", var_1);
}

getassistbonusamount() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"] * 0.5;
}

get_reward_point_for_kill() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"];
}

givekillreward(var_0, var_1, var_2, var_3) {
  var_4 = var_1 * level.cycle_reward_scalar;

  if(isDefined(level.cash_scalar)) {
    var_4 = var_4 * level.cash_scalar;
  }

  var_0 scripts\cp\cp_persistence::give_player_currency(var_4, var_2, var_3);

  if(isDefined(level.zombie_xp)) {
    var_0 scripts\cp\cp_persistence::give_player_xp(int(var_4));
  }

  if(scripts\engine\utility::flag_exist("cortex_started") && scripts\engine\utility::flag("cortex_started")) {
    if(isDefined(level.add_cortex_charge_func)) {
      [[level.add_cortex_charge_func]](var_1);
    }
  }
}