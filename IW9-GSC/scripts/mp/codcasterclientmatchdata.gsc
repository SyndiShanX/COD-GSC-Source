/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\codcasterclientmatchdata.gsc
***************************************************/

_id_05281975E60EAC3A(_id_127743BEFE53DA2E) {
  if(!isDefined(self._id_A8F9789EDD592F29))
    self._id_A8F9789EDD592F29 = [];

  if(!isDefined(self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E]))
    self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E] = 0;
}

_id_CC33F4ECE5DCA487(_id_127743BEFE53DA2E, index) {
  if(!isDefined(self._id_A8F9789EDD592F29))
    self._id_A8F9789EDD592F29 = [];

  if(!isDefined(self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E]))
    self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E] = [];

  if(!isDefined(self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E][index]))
    self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E][index] = 0;
}

_id_B899BCE95B7D6A94(_id_CF76A3550B35080C) {
  if(!isDefined(self._id_E41D482461D4594F))
    self._id_E41D482461D4594F = [];

  if(!isDefined(self._id_E41D482461D4594F[_id_CF76A3550B35080C]))
    self._id_E41D482461D4594F[_id_CF76A3550B35080C] = 0;
}

_id_D16498B27251DA56(_id_127743BEFE53DA2E, _id_2F977E27FA739602) {
  _id_05281975E60EAC3A(_id_127743BEFE53DA2E);
  self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E] = self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E] + _id_2F977E27FA739602;
  _id_7EE466E81B1AFC12(_id_127743BEFE53DA2E, self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E]);
}

_id_48544E365F4F5648(_id_CF76A3550B35080C, _id_2F977E27FA739602) {
  _id_B899BCE95B7D6A94(_id_CF76A3550B35080C);
  self._id_E41D482461D4594F[_id_CF76A3550B35080C] = self._id_E41D482461D4594F[_id_CF76A3550B35080C] + _id_2F977E27FA739602;
  _id_F8B808CD6473E6CC(_id_CF76A3550B35080C, self._id_E41D482461D4594F[_id_CF76A3550B35080C]);
}

_id_7EE466E81B1AFC12(_id_127743BEFE53DA2E, value) {
  if(!isPlayer(self)) {
    return;
  }
  _id_05281975E60EAC3A(_id_127743BEFE53DA2E);
  self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E] = value;
  self _meth_AC1512504BA75F25(_id_127743BEFE53DA2E, value);
}

_id_6807ED320B73BE7F(_id_127743BEFE53DA2E, index, value) {
  if(!isPlayer(self)) {
    return;
  }
  _id_CC33F4ECE5DCA487(_id_127743BEFE53DA2E, index);
  self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E][index] = value;
  self _meth_AC1512504BA75F25(_id_127743BEFE53DA2E, value, index);
}

_id_F8B808CD6473E6CC(_id_CF76A3550B35080C, value) {
  if(!isPlayer(self)) {
    return;
  }
  _id_B899BCE95B7D6A94(_id_CF76A3550B35080C);
  self._id_E41D482461D4594F[_id_CF76A3550B35080C] = value;
  self _meth_D743EBE29C5A6E7F(_id_CF76A3550B35080C, value);
}

_id_815FEE43D577E1B6(_id_127743BEFE53DA2E) {
  _id_05281975E60EAC3A(_id_127743BEFE53DA2E);
  return self._id_A8F9789EDD592F29[_id_127743BEFE53DA2E];
}

_id_A08FEA26A49145A8(_id_CF76A3550B35080C) {
  _id_B899BCE95B7D6A94(_id_CF76A3550B35080C);
  return self._id_E41D482461D4594F[_id_CF76A3550B35080C];
}

_id_AEF8A28143D1F9AD(_id_9138AB59FF517F7B) {
  if(!isDefined(self._id_01A34ED8EB5C6E9C))
    self._id_01A34ED8EB5C6E9C = [];

  if(!isDefined(self._id_01A34ED8EB5C6E9C[_id_9138AB59FF517F7B]))
    self._id_01A34ED8EB5C6E9C[_id_9138AB59FF517F7B] = 0;
}

_id_1882F80B14421089(_id_9138AB59FF517F7B, _id_2F977E27FA739602) {
  _id_AEF8A28143D1F9AD(_id_9138AB59FF517F7B);
  self._id_01A34ED8EB5C6E9C[_id_9138AB59FF517F7B] = self._id_01A34ED8EB5C6E9C[_id_9138AB59FF517F7B] + _id_2F977E27FA739602;
  _id_5A82C337B996BAA5(_id_9138AB59FF517F7B, self._id_01A34ED8EB5C6E9C[_id_9138AB59FF517F7B]);
}

_id_5A82C337B996BAA5(_id_9138AB59FF517F7B, value) {
  if(!isPlayer(self)) {
    return;
  }
  _id_AEF8A28143D1F9AD(_id_9138AB59FF517F7B);
  self._id_01A34ED8EB5C6E9C[_id_9138AB59FF517F7B] = value;
  _id_AD829FAB97971B4B(_id_9138AB59FF517F7B);
}

_id_E42724FBFACFF469(_id_9138AB59FF517F7B) {
  _id_AEF8A28143D1F9AD(_id_9138AB59FF517F7B);
  return self._id_01A34ED8EB5C6E9C[_id_9138AB59FF517F7B];
}

_id_AD829FAB97971B4B(_id_9138AB59FF517F7B) {
  if(_id_9138AB59FF517F7B == 0 || _id_9138AB59FF517F7B == 1) {
    _id_7EE466E81B1AFC12(0, _id_1B32A33893BECBCF());
    return;
  }

  if(_id_9138AB59FF517F7B == 6) {
    consecutiveKills = self._id_01A34ED8EB5C6E9C[6];
    _id_7EE466E81B1AFC12(6, consecutiveKills);
    _id_51538FE8520E4052 = _id_815FEE43D577E1B6(7);

    if(consecutiveKills > _id_51538FE8520E4052)
      _id_7EE466E81B1AFC12(7, consecutiveKills);

    return;
  }

  if(_id_9138AB59FF517F7B == 3) {
    _id_128CE76C9C22E1BC = self._id_01A34ED8EB5C6E9C[3];
    _id_F8B808CD6473E6CC(13, _id_D1F982E1E54336EC(_id_128CE76C9C22E1BC));
    _id_F8B808CD6473E6CC(14, _id_D6A8339D07D64D73(_id_128CE76C9C22E1BC));
    _id_F8B808CD6473E6CC(1, _id_9D923691177CE2A7(_id_A08FEA26A49145A8(0), _id_128CE76C9C22E1BC));
    return;
  }

  if(_id_9138AB59FF517F7B == 4) {
    _id_B39BB65D413613B6 = self._id_01A34ED8EB5C6E9C[4];
    _id_F8B808CD6473E6CC(5, _id_D1F982E1E54336EC(_id_B39BB65D413613B6));
    _id_F8B808CD6473E6CC(6, _id_D6A8339D07D64D73(_id_B39BB65D413613B6));
    return;
  }

  if(_id_9138AB59FF517F7B == 5) {
    if(_id_726F071C1F349DD4())
      _id_48544E365F4F5648(12, 1);

    return;
  }
}

_id_726F071C1F349DD4() {
  _id_B899BCE95B7D6A94(12);
  return floor(self._id_01A34ED8EB5C6E9C[5]) > self._id_E41D482461D4594F[12];
}

_id_1B32A33893BECBCF() {
  if(!isDefined(self._id_01A34ED8EB5C6E9C) || !isDefined(self._id_01A34ED8EB5C6E9C[0]) || !isDefined(self._id_01A34ED8EB5C6E9C[1]))
    return 0.0;

  _id_58E50AEE46852766 = self._id_01A34ED8EB5C6E9C[0];

  if(_id_58E50AEE46852766 <= 0)
    return 0.0;

  hits = self._id_01A34ED8EB5C6E9C[1];
  return hits / _id_58E50AEE46852766;
}

_id_D1F982E1E54336EC(_id_3436F757AEE9EF90) {
  return _id_9D923691177CE2A7(self.pers["kills"], _id_3436F757AEE9EF90);
}

_id_D6A8339D07D64D73(_id_3436F757AEE9EF90) {
  return _id_9D923691177CE2A7(_id_815FEE43D577E1B6(1), _id_3436F757AEE9EF90);
}

_id_9D923691177CE2A7(_id_D0F001B1761FBF53, _id_EC940180FF00F497) {
  if(!isDefined(_id_D0F001B1761FBF53) || !isDefined(_id_EC940180FF00F497) || _id_EC940180FF00F497 <= 0)
    return 0.0;

  return _id_D0F001B1761FBF53 / _id_EC940180FF00F497;
}

_id_2E28105E6500A144(player) {
  if(!isDefined(player)) {
    return;
  }
  logstring(player.name + ": ");
  _id_CF75101FA0F3C9DD = "\t\tcodcasterClientStats: ";

  if(isDefined(player._id_A8F9789EDD592F29)) {
    foreach(index, value in player._id_A8F9789EDD592F29) {
      if(!isarray(value)) {
        _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + (value + "~ [" + index + "]" + " / ");
        continue;
      }

      foreach(_id_AC0E594AC96AA3A8, _id_9F08102FF8F6A887 in value)
      _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + (_id_9F08102FF8F6A887 + ",");

      _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + ("~ [" + index + "]" + " / ");
    }
  }

  logstring(_id_CF75101FA0F3C9DD);
  _id_CF75101FA0F3C9DD = "\t\tlocalCodcasterClientStat: ";

  if(isDefined(player._id_01A34ED8EB5C6E9C)) {
    foreach(index, value in player._id_01A34ED8EB5C6E9C) {
      if(!isarray(value)) {
        _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + (value + "~ [" + index + "]" + " / ");
        continue;
      }

      foreach(_id_AC0E594AC96AA3A8, _id_9F08102FF8F6A887 in value)
      _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + (_id_9F08102FF8F6A887 + ",");

      _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + ("~ [" + index + "]" + " / ");
    }
  }

  logstring(_id_CF75101FA0F3C9DD);
  _id_CF75101FA0F3C9DD = "\t\tcodcasterGametypeClientStats: ";

  if(isDefined(player._id_E41D482461D4594F)) {
    foreach(index, value in player._id_E41D482461D4594F) {
      if(!isarray(value)) {
        _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + (value + "~ [" + index + "]" + " / ");
        continue;
      }

      foreach(_id_AC0E594AC96AA3A8, _id_9F08102FF8F6A887 in value)
      _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + (_id_9F08102FF8F6A887 + ",");

      _id_CF75101FA0F3C9DD = _id_CF75101FA0F3C9DD + ("~ [" + index + "]" + " / ");
    }
  }

  logstring(_id_CF75101FA0F3C9DD);
}

_id_0EDBA1EE7C2375A5() {
  game["codcasterClientStatsSaveBetweenRounds"] = [];
  game["localCodcasterClientStatsSaveBetweenRounds"] = [];
  game["codcasterGametypeClientStatsSaveBetweenRounds"] = [];

  foreach(player in level.players) {
    if(getdvarint("dvar_B0B065FCEE59B58D", 0) == 1)
      _id_2E28105E6500A144(player);

    game["codcasterClientStatsSaveBetweenRounds"][player.guid] = player._id_A8F9789EDD592F29;
    game["localCodcasterClientStatsSaveBetweenRounds"][player.guid] = player._id_01A34ED8EB5C6E9C;
    game["codcasterGametypeClientStatsSaveBetweenRounds"][player.guid] = player._id_E41D482461D4594F;
  }
}

_id_9B229B18B0750BAD() {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(game["codcasterClientStatsSaveBetweenRounds"]) || !isDefined(game["localCodcasterClientStatsSaveBetweenRounds"])) {
    return;
  }
  if(isDefined(game["codcasterClientStatsSaveBetweenRounds"][self.guid]))
    self._id_A8F9789EDD592F29 = game["codcasterClientStatsSaveBetweenRounds"][self.guid];
  else
    self._id_A8F9789EDD592F29 = [];

  if(isDefined(game["localCodcasterClientStatsSaveBetweenRounds"][self.guid]))
    self._id_01A34ED8EB5C6E9C = game["localCodcasterClientStatsSaveBetweenRounds"][self.guid];
  else
    self._id_01A34ED8EB5C6E9C = [];

  if(isDefined(game["codcasterGametypeClientStatsSaveBetweenRounds"][self.guid]))
    self._id_E41D482461D4594F = game["codcasterGametypeClientStatsSaveBetweenRounds"][self.guid];
  else
    self._id_E41D482461D4594F = [];

  if(getdvarint("dvar_B0B065FCEE59B58D", 0) == 1) {
    logstring("=========================== retrieveCodcasterClientStats ==============================");
    _id_2E28105E6500A144(self);
  }

  foreach(_id_C1B9EEA971D8E69E, _id_A2B0850689543530 in self._id_A8F9789EDD592F29) {
    if(!isarray(self._id_A8F9789EDD592F29[_id_C1B9EEA971D8E69E])) {
      _id_7EE466E81B1AFC12(_id_C1B9EEA971D8E69E, _id_A2B0850689543530);
      continue;
    }

    foreach(index, value in self._id_A8F9789EDD592F29[_id_C1B9EEA971D8E69E])
    _id_6807ED320B73BE7F(_id_C1B9EEA971D8E69E, index, value);
  }

  foreach(_id_C1B9EEA971D8E69E, _id_A2B0850689543530 in self._id_E41D482461D4594F)
  _id_F8B808CD6473E6CC(_id_C1B9EEA971D8E69E, _id_A2B0850689543530);
}

_id_EE3ACF6A8BAA2FF8(_id_9D23608AB3D0D6C4, attacker, victim) {
  if(!isDefined(level._id_B33B6A18519B1BBE))
    level._id_B33B6A18519B1BBE = [];

  if(isDefined(victim) && isDefined(attacker)) {
    if(attacker.team != victim.team) {
      _id_C7169D94937C6C29 = 0;
      _id_51E466D7B408895D = scripts\mp\utility\teams::getteamdata(victim.team, "livesCount");

      switch (level.gametype) {
        case "control":
          _id_C7169D94937C6C29 = scripts\mp\utility\teams::getteamdata(victim.team, "livesCount") == 0 && scripts\mp\utility\teams::getfriendlyplayers(victim.team, 1).size == 0;
          break;
        case "sd":
          _id_C7169D94937C6C29 = scripts\mp\utility\teams::getteamdata(victim.team, "aliveCount") == 0;
          break;
        default:
          _id_C7169D94937C6C29 = 0;
          break;
      }

      if(_id_C7169D94937C6C29) {
        if(isDefined(attacker.pers["inapplicableTradedKills"]) && isDefined(victim.pers["inapplicableTradedDeaths"])) {
          attacker scripts\mp\utility\stats::incpersstat("inapplicableTradedKills", 1);
          victim scripts\mp\utility\stats::incpersstat("inapplicableTradedDeaths", 1);
        }
      } else {
        if(isDefined(victim.pers["untradedDeaths"]))
          victim scripts\mp\utility\stats::incpersstat("untradedDeaths", 1);

        attacker _id_D16498B27251DA56(5, 1);
      }

      _id_92884735D8E33FBB = [];
      _id_92884735D8E33FBB["killtime"] = _id_9D23608AB3D0D6C4;
      _id_92884735D8E33FBB["attacker"] = attacker;

      for(_id_92884735D8E33FBB["victim"] = victim; self._id_B33B6A18519B1BBE.size > 0 && _id_9D23608AB3D0D6C4 - self._id_B33B6A18519B1BBE[0]["killtime"] > 5000; self._id_B33B6A18519B1BBE = scripts\engine\utility::array_remove_index(self._id_B33B6A18519B1BBE, 0, 0)) {}

      for(_id_43348865D9126A85 = self._id_B33B6A18519B1BBE.size - 1; _id_43348865D9126A85 >= 0; _id_43348865D9126A85--) {
        _id_F90358454413407F = self._id_B33B6A18519B1BBE[_id_43348865D9126A85];

        if(isDefined(_id_F90358454413407F) && isDefined(_id_F90358454413407F["attacker"]) && isDefined(_id_F90358454413407F["victim"])) {
          if(_id_F90358454413407F["attacker"] == victim) {
            if(victim.lastkilledplayer == _id_F90358454413407F["victim"]) {
              if(isDefined(_id_F90358454413407F["attacker"].pers["tradedKills"]) && isDefined(_id_F90358454413407F["victim"].pers["untradedDeaths"]) && isDefined(_id_F90358454413407F["victim"].pers["tradedDeaths"])) {
                _id_F90358454413407F["attacker"] _id_D16498B27251DA56(5, -1);
                _id_F90358454413407F["victim"] _id_D16498B27251DA56(9, 1);
                _id_F90358454413407F["attacker"] scripts\mp\utility\stats::incpersstat("tradedKills", 1);
                _id_F90358454413407F["victim"] scripts\mp\utility\stats::incpersstat("untradedDeaths", -1);
                _id_F90358454413407F["victim"] scripts\mp\utility\stats::incpersstat("tradedDeaths", 1);
              }
            }

            self._id_B33B6A18519B1BBE = scripts\engine\utility::array_remove_index(self._id_B33B6A18519B1BBE, _id_43348865D9126A85, 0);
          }
        }
      }

      self._id_B33B6A18519B1BBE[self._id_B33B6A18519B1BBE.size] = _id_92884735D8E33FBB;
    } else if(isDefined(victim.pers["untradedDeaths"]))
      victim scripts\mp\utility\stats::incpersstat("untradedDeaths", 1);
  }
}

_id_6F792F70FFE4CD4D(attacker, victim) {
  level _id_EE3ACF6A8BAA2FF8(gettime(), attacker, victim);
}

_id_94C8F3722D550646() {
  if(isDefined(level._id_BB581BB447E5A6A6)) {
    return;
  }
  _id_56EB566F7AE12FA3 = scripts\mp\utility\game::isroundbased();

  foreach(player in level.players) {
    if(_id_56EB566F7AE12FA3) {
      player _id_1882F80B14421089(4, 1);
      continue;
    }

    player _id_1882F80B14421089(3, 1);
  }

  level._id_BB581BB447E5A6A6 = 1;
}