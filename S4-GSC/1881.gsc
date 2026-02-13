/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1881.gsc
*************************************************/

_id_6ECC(var_0, var_1) {
  if(self.team == "allies") {
    return;
  }
  if(istrue(self._id_4982)) {
    return;
  }
  if(_id_06FE::_id_6305(self) == "elite" || _id_06FE::_id_6305(self) == "mammoth") {
    var_2 = _id_6708();

    foreach(var_4 in level.players) {
      _id_6FAA(var_4, var_2, "large");
    }

    return;
  }

  if(isDefined(self._id_1DD0) || isDefined(self._id_9B2B)) {
    if(isDefined(self._id_9B2B)) {
      foreach(var_4 in level.players) {
        if(isDefined(self._id_B64B) && self._id_B64B == var_4 && var_4 != var_0) {
          var_7 = _id_68DC();

          if(isDefined(level._id_32FF)) {
            var_7 = var_7 * level._id_32FF;
          }

          _id_6FAA(var_4, var_7 * 2);
          var_4 _id_074E::_id_5530("assists", 1);
          self._id_7C33 = 1;
        }
      }
    }

    if(!isDefined(self._id_7C33)) {
      var_9 = 0.1;
      var_10 = self.maxhealth * var_9;
      var_7 = _id_68DC();

      if(isDefined(level._id_32FF)) {
        var_7 = var_7 * level._id_32FF;
      }

      foreach(var_12 in self._id_1DD0) {
        if(var_12.player == var_0 || isDefined(var_0.owner) && var_12.player == var_0.owner) {
          continue;
        }
        if(var_12.damage >= var_10) {
          if(isDefined(var_12.player) && var_12.player != var_0) {
            var_12.player _id_074E::_id_5530("assists", 1);
            _id_6FAA(var_12.player, var_7);
          }
        }
      }
    }
  }

  if(!isDefined(var_0)) {
    return;
  }
  if(!isPlayer(var_0) && (!isDefined(var_0.owner) || !isPlayer(var_0.owner))) {
    return;
  }
  var_14 = 0;

  if(isDefined(var_0.owner)) {
    var_0 = var_0.owner;
    var_14 = 1;
  }

  var_2 = _id_6708();

  if(isDefined(var_1) && var_1 == "soft" && !var_14) {
    var_2 = int(var_2 * 1.5);
  }

  _id_6FAA(var_0, var_2, "large", var_1);
}

_id_68DC() {
  return level._id_11ED[_id_06FE::_id_6305(self)]["reward"] * 0.5;
}

_id_6708() {
  return level._id_11ED[_id_06FE::_id_6305(self)]["reward"];
}

_id_6FAA(var_0, var_1, var_2, var_3) {
  var_4 = var_1 * level._id_42A0;

  if(isDefined(level._id_32FF)) {
    var_4 = var_4 * level._id_32FF;
  }

  var_0 _id_074E::_id_6F28(var_4, var_2, var_3);

  if(isDefined(level._id_1105F)) {
    var_0 _id_074E::_id_6F38(int(var_4));
  }

  if(scripts\engine\utility::_id_5C0C("cortex_started") && scripts\engine\utility::_id_5C00("cortex_started")) {
    if(isDefined(level._id_0FAE)) {
      [[level._id_0FAE]](var_1);
    }
  }
}