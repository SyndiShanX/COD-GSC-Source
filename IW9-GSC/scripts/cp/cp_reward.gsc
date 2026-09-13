/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_reward.gsc
***********************************************/

give_attacker_kill_rewards(attacker, shitloc) {
  if(self.team == "allies") {
    return;
  }
  if(istrue(self.died_poorly)) {
    return;
  }
  if(scripts\cp\cp_agent_utils::get_agent_type(self) == "elite" || scripts\cp\cp_agent_utils::get_agent_type(self) == "mammoth") {
    _id_4AD66E8A50624BDB = get_reward_point_for_kill();

    foreach(player in level.players)
    givekillreward(player, _id_4AD66E8A50624BDB, "large");

    return;
  }

  if(isDefined(self.attacker_damage) || isDefined(self.marked_by_hybrid)) {
    if(isDefined(self.marked_by_hybrid)) {
      foreach(player in level.players) {
        if(isDefined(self.player_who_tagged) && self.player_who_tagged == player && player != attacker) {
          _id_00C514D611C295EB = getassistbonusamount();

          if(isDefined(level.cash_scalar))
            _id_00C514D611C295EB = _id_00C514D611C295EB * level.cash_scalar;

          givekillreward(player, _id_00C514D611C295EB * 2);
          player scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
          self.hybrid_assist = 1;
        }
      }
    }

    if(!isDefined(self.hybrid_assist)) {
      _id_A9A6E8C32B90CA45 = 0.1;
      _id_8BB17EFD6EB74E3D = self.maxhealth * _id_A9A6E8C32B90CA45;
      _id_00C514D611C295EB = getassistbonusamount();

      if(isDefined(level.cash_scalar))
        _id_00C514D611C295EB = _id_00C514D611C295EB * level.cash_scalar;

      foreach(_id_9AE6BE01E200A866 in self.attacker_damage) {
        if(_id_9AE6BE01E200A866.player == attacker || isDefined(attacker.owner) && _id_9AE6BE01E200A866.player == attacker.owner) {
          continue;
        }
        if(_id_9AE6BE01E200A866.damage >= _id_8BB17EFD6EB74E3D) {
          if(isDefined(_id_9AE6BE01E200A866.player) && _id_9AE6BE01E200A866.player != attacker) {
            _id_9AE6BE01E200A866.player scripts\cp\cp_persistence::eog_player_update_stat("assists", 1);
            givekillreward(_id_9AE6BE01E200A866.player, _id_00C514D611C295EB);
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
  _id_33242CA76A448F6B = 0;

  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
    _id_33242CA76A448F6B = 1;
  }

  _id_4AD66E8A50624BDB = get_reward_point_for_kill();

  if(isDefined(shitloc) && shitloc == "soft" && !_id_33242CA76A448F6B)
    _id_4AD66E8A50624BDB = int(_id_4AD66E8A50624BDB * 1.5);

  givekillreward(attacker, _id_4AD66E8A50624BDB, "large", shitloc);
}

getassistbonusamount() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"] * 0.5;
}

get_reward_point_for_kill() {
  return level.agent_definition[scripts\cp\cp_agent_utils::get_agent_type(self)]["reward"];
}

givekillreward(attacker, amount, _id_A61C75B156FC1EE0, shitloc) {
  _id_4024268B4FD10E68 = amount * level.cycle_reward_scalar;

  if(isDefined(level.cash_scalar))
    _id_4024268B4FD10E68 = _id_4024268B4FD10E68 * level.cash_scalar;

  attacker scripts\cp\cp_persistence::give_player_currency(_id_4024268B4FD10E68, _id_A61C75B156FC1EE0, shitloc);

  if(isDefined(level.zombie_xp))
    attacker scripts\cp\cp_persistence::give_player_xp(int(_id_4024268B4FD10E68));

  if(scripts\engine\utility::flag_exist("cortex_started") && scripts\engine\utility::flag("cortex_started")) {
    if(isDefined(level.add_cortex_charge_func))
      [[level.add_cortex_charge_func]](amount);
  }
}