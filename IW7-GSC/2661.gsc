/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2661.gsc
***************************************/

give_attacker_kill_rewards(var_00, var_01) {
  if(self.team == "allies") {
    return;
  }
  if(scripts\engine\utility::is_true(self.died_poorly)) {
    return;
  }
  if(scripts\cp\cp_agent_utils::get_agent_type(self) == "elite" || scripts\cp\cp_agent_utils::get_agent_type(self) == "mammoth") {
    var_02 = get_reward_point_for_kill();

    foreach(var_04 in level.players) {
    givekillreward(var_04, var_02, "large");
    }

    return;
  }

  if(isDefined(self.attacker_damage) || isDefined(self.marked_by_hybrid)) {
    if(isDefined(self.marked_by_hybrid)) {
      foreach(var_04 in level.players) {
        if(isDefined(self.player_who_tagged) && self.player_who_tagged == var_04 && var_04 != var_00) {
          var_07 = getassistbonusamount();

          if(isDefined(level.cash_scalar)) {
            var_07 = var_07 * level.cash_scalar;
          }

          givekillreward(var_04, var_07 * 2);
          var_04 scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
          self.hybrid_assist = 1;
        }
      }
    }

    if(!isDefined(self.hybrid_assist)) {
      var_09 = 0.1;
      var_10 = self.maxhealth * var_09;
      var_07 = getassistbonusamount();

      if(isDefined(level.cash_scalar)) {
        var_07 = var_07 * level.cash_scalar;
      }

      foreach(var_12 in self.attacker_damage) {
        if(var_12.player == var_00 || isDefined(var_0.owner) && var_12.player == var_0.owner) {
          continue;
        }
        if(var_12.damage >= var_10) {
          if(isDefined(var_12.player) && var_12.player != var_00) {
            var_12.player scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
            givekillreward(var_12.player, var_07);
          }
        }
      }
    }
  }

  if(!isDefined(var_00)) {
    return;
  }
  if(!isplayer(var_00) && (!isDefined(var_0.owner) || !isplayer(var_0.owner))) {
    return;
  }
  var_14 = 0;

  if(isDefined(var_0.owner)) {
    var_00 = var_0.owner;
    var_14 = 1;
  }

  var_02 = get_reward_point_for_kill();

  if(isDefined(var_01) && var_01 == "soft" && !var_14) {
    var_02 = int(var_02 * 1.5);
  }

  givekillreward(var_00, var_02, "large", var_01);
}

getassistbonusamount() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"] * 0.5;
}

get_reward_point_for_kill() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"];
}

givekillreward(var_00, var_01, var_02, var_03) {
  var_04 = var_01 * level.cycle_reward_scalar;

  if(isDefined(level.cash_scalar)) {
    var_04 = var_04 * level.cash_scalar;
  }

  var_00 scripts\cp\cp_persistence::give_player_currency(var_04, var_02, var_03);

  if(isDefined(level.zombie_xp)) {
    var_00 scripts\cp\cp_persistence::give_player_xp(int(var_04));
  }

  if(scripts\engine\utility::flag_exist("cortex_started") && scripts\engine\utility::flag("cortex_started")) {
    if(isDefined(level.add_cortex_charge_func)) {
      [[level.add_cortex_charge_func]](var_01);
    }
  }
}