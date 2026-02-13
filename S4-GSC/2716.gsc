/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2716.gsc
*************************************************/

_id_AFFA() {
  return level._id_15C7;
}

_hasperk(var_0) {
  return isDefined(self.perks) && isDefined(self.perks[var_0]);
}

_id_6FC2(var_0) {
  scripts\mp\perks\perks::_setperk(var_0);
  scripts\mp\perks\perks::_id_0CE9(var_0);
}

_id_C629() {
  _id_0A6C::_id_AFE4();
}

removeperk(var_0) {
  if(istrue(level.gameended)) {
    return;
  }
  scripts\mp\perks\perks::_unsetperk(var_0);
  scripts\mp\perks\perks::_id_0DA0(var_0);
}

_id_259D(var_0) {
  if(!isDefined(self._id_AFF8[var_0])) {
    self._id_AFF8[var_0] = 1;
  } else {
    self._id_AFF8[var_0]++;
  }

  if(self._id_AFF8[var_0] == 1 && _hasperk(var_0)) {
    scripts\mp\perks\perks::_id_0DA2(var_0);

    foreach(var_6, var_2 in level._id_5853) {
      if(var_0 == var_6) {
        foreach(var_4 in var_2) {
          if(!isDefined(self._id_AFF8[var_4])) {
            self._id_AFF8[var_4] = 1;
          } else {
            self._id_AFF8[var_4]++;
          }

          if(self._id_AFF8[var_4] == 1) {
            scripts\mp\perks\perks::_id_0DA2(var_4);
          }
        }

        break;
      }
    }
  }
}

_id_F934(var_0) {
  self._id_AFF8[var_0]--;

  if(self._id_AFF8[var_0] == 0) {
    self._id_AFF8[var_0] = undefined;

    if(_hasperk(var_0)) {
      scripts\mp\perks\perks::_id_0CED(var_0);

      foreach(var_6, var_2 in level._id_5853) {
        if(var_0 == var_6) {
          foreach(var_4 in var_2) {
            self._id_AFF8[var_4]--;

            if(self._id_AFF8[var_4] == 0) {
              scripts\mp\perks\perks::_id_0CED(var_4);
              self._id_AFF8[var_4] = undefined;
            }
          }

          break;
        }
      }
    }
  }
}

_id_68FF(var_0) {
  if(_func_010C(var_0, "_ks")) {
    var_0 = _func_00D6(var_0, 0, var_0.size - 3);
  }

  return var_0;
}

_id_94CA() {
  return 0.06;
}

_id_CA5B() {
  return 0.07;
}