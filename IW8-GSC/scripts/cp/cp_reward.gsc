/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_reward.gsc
***********************************************/

function give_attacker_kill_rewards(var0, var1) {
  if(self.team == "allies") {
    return;
  }

  if(istrue(self.died_poorly)) {
    return;
  }

  if(scripts\cp\cp_agent_utils::get_agent_type(self) == "elite" || scripts\cp\cp_agent_utils::get_agent_type(self) == "mammoth") {
    var2 = get_reward_point_for_kill();

    foreach(var5, var4 in level.players) {
      givekillreward(var4, var2, "large");
    }

    return;
  }

  if(isDefined(self.attacker_damage) || isDefined(self.marked_by_hybrid)) {
    if(isDefined(self.marked_by_hybrid)) {
      foreach(var4 in level.players) {
        if(isDefined(self.player_who_tagged) && self.player_who_tagged == var4 && var4 != var4) {
          var7 = getassistbonusamount();

          if(isDefined(level.cash_scalar)) {
            var7 *= level.cash_scalar;
          }

          givekillreward(var4, var7 * 2);
          var4 scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
          self.hybrid_assist = 1;
        }
      }
    }

    if(!isDefined(self.hybrid_assist)) {
      var9 = 0.1;
      var10 = self.maxhealth * var9;
      var7 = getassistbonusamount();

      if(isDefined(level.cash_scalar)) {
        var7 *= level.cash_scalar;
      }

      foreach(var12 in self.attacker_damage) {
        if(var12.player == var4 || isDefined(var4.owner) && var12.player == var4.owner) {
          continue;
        }

        if(var12.damage >= var10) {
          if(isDefined(var12.player) && var12.player != var4) {
            var12.player scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
            givekillreward(var12.player, var7);
          }
        }
      }
    }
  }

  if(!isDefined(var4)) {
    return;
  }

  if(!isPlayer(var4) && (!isDefined(var4.owner) || !isPlayer(var4.owner))) {
    return;
  }

  var14 = 0;

  if(isDefined(var4.owner)) {
    var4 = var4.owner;
    var14 = 1;
  }

  var2 = get_reward_point_for_kill();

  if(isDefined(var5) && var5 == "soft" && !var14) {
    var2 = int(var2 * 1.5);
  }

  givekillreward(var4, var2, "large", var5);
}

function getassistbonusamount() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"] * 0.5;
}

function get_reward_point_for_kill() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"];
}

function givekillreward(var0, var1, var2, var3) {
  var4 = var1 * level.cycle_reward_scalar;

  if(isDefined(level.cash_scalar)) {
    var4 *= level.cash_scalar;
  }

  var0 scripts\cp\cp_persistence::give_player_currency(var4, var2, var3);

  if(isDefined(level.zombie_xp)) {
    var0 scripts\cp\cp_persistence::give_player_xp(int(var4));
  }

  if(scripts\engine\utility::flag_exist("cortex_started") && scripts\engine\utility::flag("cortex_started")) {
    if(isDefined(level.add_cortex_charge_func)) {
      [[level.add_cortex_charge_func]](var1);
      return;
    }

    return;
  }
}