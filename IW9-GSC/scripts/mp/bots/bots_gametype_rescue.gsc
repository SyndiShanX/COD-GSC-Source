/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\bots\bots_gametype_rescue.gsc
****************************************************/

main() {
  setup_callbacks();
  _id_A342A902F130FFD8();
}

setup_callbacks() {
  level.bot_funcs["gametype_think"] = ::_id_D5F52587F2E4B3F9;
}

_id_A342A902F130FFD8() {
  level._id_765B019E692C1BEB = game["attackers"];
  level._id_350E53E094AC2A9F = game["defenders"];
  thread _id_AB0F485FE8ACBCF6();
}

_id_D5F52587F2E4B3F9() {
  self notify("bot_rescue_think");
  self endon("bot_rescue_think");
  self endon("death_or_disconnect");
  self endon("revivedAlive");
  level endon("game_ended");
  self botsetflag("separation", 0);
  self botsetflag("use_obj_path_style", 1);

  for(;;) {
    if(self.health <= 0 || istrue(self._id_C4C8B91E0B16AA5E)) {
      wait 0.05;
      continue;
    }

    if(!isDefined(self.role))
      _id_A6592C048F7B884A();

    if(!isDefined(self._id_1131C442FDB61642))
      self._id_1131C442FDB61642 = scripts\engine\utility::random(level.hostages);

    if(isDefined(self._id_1131C442FDB61642) && self._id_1131C442FDB61642.interactteam == "none" && !isDefined(self._id_1131C442FDB61642.ownerteam))
      self._id_1131C442FDB61642 = scripts\engine\utility::random(level.hostages);

    if(!isDefined(self._id_1131C442FDB61642)) {
      wait 0.05;
      continue;
    }

    if(self.team == level._id_765B019E692C1BEB) {
      if(isDefined(self._id_1131C442FDB61642.carrier)) {
        clear_defend();

        if(isalive(self._id_1131C442FDB61642.carrier))
          self botsetscriptgoal(self._id_1131C442FDB61642.carrier.origin, 16, "critical");
        else
          self botsetscriptgoal(self._id_1131C442FDB61642.curorigin, 16, "critical");
      } else if(!scripts\mp\bots\bots_util::bot_is_defending_point(self._id_1131C442FDB61642.curorigin) && self._id_1131C442FDB61642.interactteam != "none") {
        optional_params["score_flags"] = "strict_los";
        self botclearscriptgoal();
        scripts\mp\bots\bots_strategy::bot_protect_point(self._id_1131C442FDB61642.curorigin, level.protect_radius, optional_params);
      }
    } else if(self.team == level._id_350E53E094AC2A9F) {
      if(_id_7EEB6264CCE0F89F()) {
        if(!isDefined(self._id_11953C95B4BF4BCC))
          self._id_11953C95B4BF4BCC = scripts\engine\utility::random(level._id_F57A27B32E66A765);

        clear_defend();
        self botsetscriptgoal(self._id_11953C95B4BF4BCC.curorigin, 16, "critical");
      } else if(isDefined(self._id_1131C442FDB61642.carrier)) {
        if(!scripts\mp\bots\bots_util::bot_is_bodyguarding()) {
          clear_defend();
          self botclearscriptgoal();
          scripts\mp\bots\bots_strategy::bot_guard_player(self._id_1131C442FDB61642.carrier, 500);
        }
      } else {
        clear_defend();

        if(self botgetscriptgoaltype() == "critical")
          self botclearscriptgoal();

        self botsetscriptgoal(self._id_1131C442FDB61642.curorigin, 16, "objective", undefined, 50);
        result = scripts\mp\bots\bots_util::bot_waittill_goal_or_fail();

        if(result == "goal") {
          self botpressbutton("use", 1.0);
          result = scripts\mp\bots\bots_util::bot_usebutton_wait(1.0);
        }
      }
    }

    wait 0.05;
  }
}

_id_7EEB6264CCE0F89F() {
  return istrue(self._id_5B3C77E2EAFAB370);
}

_id_A6592C048F7B884A() {
  if(self.team == level._id_765B019E692C1BEB)
    _id_7F989E71B934C9FC::bot_gametype_set_role("defender");
  else if(self.team == level._id_350E53E094AC2A9F)
    _id_7F989E71B934C9FC::bot_gametype_set_role("attacker");
}

_id_4E910D37A5B529BF(hostage) {
  _id_9E69834A9745A8B6 = [];
  _id_1D98CB7C4CF3C277 = _id_7F989E71B934C9FC::get_living_players_on_team(level._id_765B019E692C1BEB);

  foreach(player in _id_1D98CB7C4CF3C277) {
    if(isai(player) && isDefined(player.role) && player.role == "defender") {
      if(isDefined(player._id_1131C442FDB61642) && player._id_1131C442FDB61642 == hostage)
        _id_9E69834A9745A8B6 = scripts\engine\utility::array_add(_id_9E69834A9745A8B6, player);

      continue;
    }

    if(distancesquared(player.origin, hostage.curorigin) < level.protect_radius * level.protect_radius)
      _id_9E69834A9745A8B6 = scripts\engine\utility::array_add(_id_9E69834A9745A8B6, player);
  }

  return _id_9E69834A9745A8B6;
}

clear_defend() {
  if(scripts\mp\bots\bots_util::bot_is_defending())
    scripts\mp\bots\bots_strategy::bot_defend_stop();
}

_id_AB0F485FE8ACBCF6() {
  level notify("bot_rescue_ai_director_update");
  level endon("bot_rescue_ai_director_update");
  level endon("game_ended");
  level.protect_radius = 725;

  for(;;) {
    foreach(_id_AC0E594AC96AA3A8 in level.hostages) {
      foreach(_id_AC0E5C4AC96AAA41 in level.hostages) {
        _id_EAEA273876FE3E3E = _id_4E910D37A5B529BF(_id_AC0E594AC96AA3A8);
        _id_EAEA263876FE3C0B = _id_4E910D37A5B529BF(_id_AC0E5C4AC96AAA41);

        if(_id_EAEA273876FE3E3E.size > _id_EAEA263876FE3C0B.size + 1) {
          _id_24050F51453437C9 = [];

          foreach(player in _id_EAEA273876FE3E3E) {
            if(isai(player))
              _id_24050F51453437C9 = scripts\engine\utility::array_add(_id_24050F51453437C9, player);
          }

          if(_id_24050F51453437C9.size > 0) {
            _id_EE2753C1176F5C7E = scripts\engine\utility::random(_id_24050F51453437C9);
            _id_EE2753C1176F5C7E scripts\mp\bots\bots_strategy::bot_defend_stop();
            _id_EE2753C1176F5C7E._id_1131C442FDB61642 = _id_AC0E5C4AC96AAA41;
          }
        }
      }
    }

    wait 0.5;
  }
}