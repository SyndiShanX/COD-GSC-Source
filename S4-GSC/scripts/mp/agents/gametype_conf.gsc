/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_conf.gsc
*************************************************/

main() {
  _id_D795();
}

_id_D795() {
  level._id_11EF["player"]["think"] = ::_id_11FD;
}

_id_11FD() {
  thread scripts\mp\bots\bots_gametype_conf::_id_273C();
}

_id_120A() {
  if(!isDefined(self._id_ED72)) {
    self._id_ED72 = [];
  }

  if(!isDefined(self._id_A487)) {
    self._id_A487 = gettime() + 500;
  }

  if(gettime() > self._id_A487) {
    self._id_A487 = gettime() + 500;
    var_0 = 0.78;
    var_1 = self.owner _meth_815E();

    if(isDefined(var_1)) {
      var_2 = self.owner scripts\mp\bots\bots_gametype_conf::_id_2796(1, var_1, var_0);
      self._id_ED72 = scripts\mp\bots\bots_gametype_conf::_id_273B(var_2, self._id_ED72);
    }
  }

  self._id_ED72 = scripts\mp\bots\bots_gametype_conf::_id_28A7(self._id_ED72);
  var_3 = scripts\mp\bots\bots_gametype_conf::_id_278D(self._id_ED72, 0);

  if(isDefined(var_3)) {
    if(!isDefined(self._id_ED39) || distancesquared(var_3._id_4140, self._id_ED39._id_4140) > 1) {
      self._id_ED39 = var_3;
      _id_09F9::_id_2766();
      self _meth_8058(self._id_ED39._id_4140, 0, "objective", undefined, level._id_28F3);
    }

    return 1;
  } else if(isDefined(self._id_ED39)) {
    self _meth_802B();
    self._id_ED39 = undefined;
  }

  return 0;
}