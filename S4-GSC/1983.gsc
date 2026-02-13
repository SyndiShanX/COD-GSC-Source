/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1983.gsc
*************************************************/

_id_8165(var_0) {
  if(!isDefined(self._id_3A1C)) {
    self._id_3A1C = [];
  }

  if(!isDefined(self._id_3A1C[var_0])) {
    self._id_3A1C[var_0] = 0;
  }
}

_id_8164(var_0, var_1) {
  if(!isDefined(self._id_3A1C)) {
    self._id_3A1C = [];
  }

  if(!isDefined(self._id_3A1C[var_0])) {
    self._id_3A1C[var_0] = [];
  }

  if(!isDefined(self._id_3A1C[var_0][var_1])) {
    self._id_3A1C[var_0][var_1] = 0;
  }
}

_id_7D94(var_0, var_1) {
  _id_8165(var_0);
  self._id_3A1C[var_0] = self._id_3A1C[var_0] + var_1;
  _id_D4D9(var_0, self._id_3A1C[var_0]);
}

_id_D4D9(var_0, var_1) {
  if(!isPlayer(self)) {
    return;
  }
  _id_8165(var_0);
  self._id_3A1C[var_0] = var_1;
  self _meth_875F(var_0, var_1);
}

_id_D4D7(var_0, var_1, var_2) {
  if(!isPlayer(self)) {
    return;
  }
  _id_8164(var_0, var_1);
  self._id_3A1C[var_0][var_1] = var_2;
  self _meth_875F(var_0, var_2, var_1);
}

_id_6979(var_0) {
  _id_8165(var_0);
  return self._id_3A1C[var_0];
}

_id_8211(var_0) {
  if(!isDefined(self._id_96C8)) {
    self._id_96C8 = [];
  }

  if(!isDefined(self._id_96C8[var_0])) {
    self._id_96C8[var_0] = 0;
  }
}

_id_7D9A(var_0, var_1) {
  _id_8211(var_0);
  self._id_96C8[var_0] = self._id_96C8[var_0] + var_1;
  _id_D5E4(var_0, self._id_96C8[var_0]);
}

_id_D5E4(var_0, var_1) {
  if(!isPlayer(self)) {
    return;
  }
  _id_8211(var_0);
  self._id_96C8[var_0] = var_1;
  _id_FC31(var_0);
}

getlocalcodcasterclientstat(var_0) {
  _id_8211(var_0);
  return self._id_96C8[var_0];
}

_id_FC31(var_0) {
  if(var_0 == 0 || var_0 == 1) {
    _id_D4D9(0, _id_2EB0());
    return;
  }

  if(var_0 == 21) {
    var_1 = self._id_96C8[21];
    _id_D4D9(21, var_1);
    var_2 = _id_6979(22);

    if(var_1 > var_2) {
      _id_D4D9(22, var_1);
    }

    return;
  }

  if(var_0 == 3) {
    var_3 = self._id_96C8[3];
    _id_D4D9(15, _id_2EBF(var_3));
    _id_D4D9(16, _id_2EB5(var_3));
    _id_D4D9(3, _id_4BC2(_id_6979(2), var_3));
    return;
  }

  if(var_0 == 4) {
    var_4 = self._id_96C8[4];
    _id_D4D9(7, _id_2EBF(var_4));
    _id_D4D9(8, _id_2EB5(var_4));
    return;
  }

  if(var_0 == 5) {
    if(_id_DB74()) {
      _id_7D94(14, 1);
    }

    return;
  }
}

_id_DB74() {
  _id_8165(14);
  return floor(self._id_96C8[5]) > self._id_3A1C[14];
}

_id_2EB0() {
  if(!isDefined(self._id_96C8) || !isDefined(self._id_96C8[0]) || !isDefined(self._id_96C8[1])) {
    return 0.0;
  }

  var_0 = self._id_96C8[0];

  if(var_0 <= 0) {
    return 0.0;
  }

  var_1 = self._id_96C8[1];
  return var_1 / var_0;
}

_id_2EBF(var_0) {
  return _id_4BC2(self.pers["kills"], var_0);
}

_id_2EB5(var_0) {
  return _id_4BC2(_id_6979(1), var_0);
}

_id_4BC2(var_0, var_1) {
  if(!isDefined(var_0) || !isDefined(var_1) || var_1 <= 0) {
    return 0.0;
  }

  return var_0 / var_1;
}

_id_CB40() {
  game["codcasterClientStatsSaveBetweenRounds"] = [];
  game["localCodcasterClientStatsSaveBetweenRounds"] = [];

  foreach(var_1 in level.players) {
    game["codcasterClientStatsSaveBetweenRounds"][var_1.name] = var_1._id_3A1C;
    game["localCodcasterClientStatsSaveBetweenRounds"][var_1.name] = var_1._id_96C8;
  }
}

_id_C769() {
  if(!isPlayer(self)) {
    return;
  }
  if(!isDefined(game["codcasterClientStatsSaveBetweenRounds"]) || !isDefined(game["localCodcasterClientStatsSaveBetweenRounds"])) {
    return;
  }
  if(isDefined(game["codcasterClientStatsSaveBetweenRounds"][self.name])) {
    self._id_3A1C = game["codcasterClientStatsSaveBetweenRounds"][self.name];
  } else {
    self._id_3A1C = [];
  }

  if(isDefined(game["localCodcasterClientStatsSaveBetweenRounds"][self.name])) {
    self._id_96C8 = game["localCodcasterClientStatsSaveBetweenRounds"][self.name];
  } else {
    self._id_96C8 = [];
  }

  foreach(var_5, var_1 in self._id_3A1C) {
    if(!_func_0107(self._id_3A1C[var_5])) {
      _id_D4D9(var_5, var_1);
      continue;
    }

    foreach(var_4, var_3 in self._id_3A1C[var_5]) {
      _id_D4D7(var_5, var_4, var_3);
    }
  }
}

nontradedkilllogic(var_0, var_1, var_2) {
  if(!isDefined(level.tradeablekills)) {
    level.tradeablekills = [];
  }

  if(isDefined(var_2) && isDefined(var_1)) {
    if(var_1.team != var_2.team) {
      var_3 = 0;
      var_4 = scripts\mp\utility\teams::_id_6DCA(var_2.team, "livesCount");

      switch (level.gametype) {
        case "control":
          var_3 = scripts\mp\utility\teams::_id_6DCA(var_2.team, "livesCount") == 0 && scripts\mp\utility\teams::_id_6A59(var_2.team, 1).size == 0;
          break;
        case "sd":
          var_3 = scripts\mp\utility\teams::_id_6DCA(var_2.team, "aliveCount") == 0;
          break;
        default:
          var_3 = 0;
          break;
      }

      if(var_3) {
        if(isDefined(var_1.pers["inapplicableTradedKills"]) && isDefined(var_2.pers["inapplicableTradedDeaths"])) {
          var_1 scripts\mp\utility\stats::_id_7DAE("inapplicableTradedKills", 1);
          var_2 scripts\mp\utility\stats::_id_7DAE("inapplicableTradedDeaths", 1);
        }
      } else {
        if(isDefined(var_2.pers["untradedDeaths"])) {
          var_2 scripts\mp\utility\stats::_id_7DAE("untradedDeaths", 1);
        }

        var_1 _id_7D94(20, 1);
      }

      var_5 = [];
      var_5["killtime"] = var_0;
      var_5["attacker"] = var_1;

      for(var_5["victim"] = var_2; self.tradeablekills.size > 0 && var_0 - self.tradeablekills[0]["killtime"] > 5000; self.tradeablekills = scripts\engine\utility::array_remove_index(self.tradeablekills, 0, 0)) {}

      for(var_6 = self.tradeablekills.size - 1; var_6 >= 0; var_6--) {
        var_7 = self.tradeablekills[var_6];

        if(var_7["attacker"] == var_2) {
          if(var_2._id_8FFE == var_7["victim"]) {
            var_7["attacker"] _id_7D94(20, -1);

            if(isDefined(var_7["attacker"].pers["tradedKills"]) && isDefined(var_7["victim"].pers["untradedDeaths"]) && isDefined(var_7["victim"].pers["tradedDeaths"])) {
              var_7["attacker"] scripts\mp\utility\stats::_id_7DAE("tradedKills", 1);
              var_7["victim"] scripts\mp\utility\stats::_id_7DAE("untradedDeaths", -1);
              var_7["victim"] scripts\mp\utility\stats::_id_7DAE("tradedDeaths", 1);
            }
          }

          self.tradeablekills = scripts\engine\utility::array_remove_index(self.tradeablekills, var_6, 0);
        }
      }

      self.tradeablekills[self.tradeablekills.size] = var_5;
    } else if(isDefined(var_2.pers["untradedDeaths"]))
      var_2 scripts\mp\utility\stats::_id_7DAE("untradedDeaths", 1);
  }
}

_id_AB6F(var_0, var_1) {
  level nontradedkilllogic(gettime(), var_0, var_1);
}

_id_FC32() {
  var_0 = scripts\mp\utility\game::isroundbased();

  foreach(var_2 in level.players) {
    if(var_0) {
      var_2 _id_7D9A(4, 1);
      continue;
    }

    var_2 _id_7D9A(3, 1);
  }
}