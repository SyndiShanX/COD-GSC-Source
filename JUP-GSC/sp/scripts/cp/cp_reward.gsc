/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\cp_reward.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\persistence;
#using scripts\cp\utility;
#using scripts\engine\utility;
#namespace cp_reward;

function give_attacker_kill_rewards(attacker, shitloc) {
  if(self.team == "allies") {
    return;
  }

  if(istrue(self.died_poorly)) {
    return;
  }

  if(scripts\cp\cp_agent_utils::get_agent_type(self) == "elite" || scripts\cp\cp_agent_utils::get_agent_type(self) == "mammoth") {
    reward_point = get_reward_point_for_kill();

    foreach(player in level.players) {
      givekillreward(player, reward_point, "large");
    }

    return;
  }

  if(isDefined(self.attacker_damage) || isDefined(self.marked_by_hybrid)) {
    if(isDefined(self.marked_by_hybrid)) {
      foreach(player in level.players) {
        if(isDefined(self.player_who_tagged) && self.player_who_tagged == player && player != attacker) {
          var_c514d611c295eb = getassistbonusamount();
          givekillreward(player, var_c514d611c295eb * 2);
          player scripts\cp\persistence::eog_player_update_stat("assists", 1);
          self.hybrid_assist = 1;
        }
      }
    }

    if(!isDefined(self.hybrid_assist)) {
      var_a9a6e8c32b90ca45 = 0.1;
      var_8bb17efd6eb74e3d = self.maxhealth * var_a9a6e8c32b90ca45;
      var_c514d611c295eb = getassistbonusamount();

      foreach(attacker_struct in self.attacker_damage) {
        if(attacker_struct.player == attacker || isDefined(attacker.owner) && attacker_struct.player == attacker.owner) {
          continue;
        }

        if(attacker_struct.damage >= var_8bb17efd6eb74e3d) {
          if(isDefined(attacker_struct.player) && attacker_struct.player != attacker) {
            assertex(isPlayer(attacker_struct.player), "Tried to give non-player rewards");
            attacker_struct.player scripts\cp\persistence::eog_player_update_stat("assists", 1);
            givekillreward(attacker_struct.player, var_c514d611c295eb);
          }
        }
      }
    }
  }

  if(!isDefined(attacker)) {
    return;
  }

  if(!isPlayer(attacker) && (!isDefined(attacker.owner) || !isPlayer(attacker.owner))) {
    return;
  }

  var_33242ca76a448f6b = 0;

  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
    var_33242ca76a448f6b = 1;
  }

  reward_point = get_reward_point_for_kill();

  if(isDefined(shitloc) && shitloc == "soft" && !var_33242ca76a448f6b) {
    reward_point = int(reward_point * 1.5);
  }

  givekillreward(attacker, reward_point, "large", shitloc);
}

function getassistbonusamount() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"] * 0.5;
}

function get_reward_point_for_kill() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"];
}

function givekillreward(attacker, amount, size, shitloc) {
  currency_reward = amount;
  attacker scripts\cp\persistence::give_player_currency(currency_reward, size, shitloc);

  if(isDefined(level.zombie_xp)) {
    attacker scripts\cp\persistence::give_player_xp(int(currency_reward));
  }

  if(scripts\engine\utility::flag_exist("cortex_started") && scripts\engine\utility::flag("cortex_started")) {
    if(isDefined(level.add_cortex_charge_func)) {
      [[level.add_cortex_charge_func]](amount);
    }
  }
}