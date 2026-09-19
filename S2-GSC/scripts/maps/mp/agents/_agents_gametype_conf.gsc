/************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_conf.gsc
************************************************************/

main() {
  _id_87A7();
}

_id_87A7() {
  level._id_0A41["squadmate"]["gametype_update"] = ::_id_0A48;
  level._id_0A41["player"]["think"] = ::_id_0A44;
}

_id_0A44() {
  thread maps\mp\bots\_bots_gametype_conf::_id_197D();
}

_id_0A48() {
  if(!isDefined(self._id_95BC))
    self._id_95BC = [];

  if(!isDefined(self._id_66B7))
    self._id_66B7 = gettime() + 500;

  if(gettime() > self._id_66B7) {
    self._id_66B7 = gettime() + 500;
    var_0 = 0.78;
    var_1 = self._id_0117 getnearestnode();

    if(isDefined(var_1)) {
      var_2 = self._id_0117 maps\mp\bots\_bots_gametype_conf::_id_19D1(1, var_1, var_0);
      self._id_95BC = maps\mp\bots\_bots_gametype_conf::_id_197C(var_2, self._id_95BC);
    }
  }

  self._id_95BC = maps\mp\bots\_bots_gametype_conf::_id_1AB5(self._id_95BC);
  var_3 = maps\mp\bots\_bots_gametype_conf::_id_19C9(self._id_95BC, 0);

  if(isDefined(var_3)) {
    if(!isDefined(self._id_95A8) || distancesquared(var_3._id_28D4, self._id_95A8._id_28D4) > 1) {
      self._id_95A8 = var_3;
      maps\mp\bots\_bots_strategy::_id_19A3();
      self botsetscriptgoal(self._id_95A8._id_28D4, 0, "objective", undefined, level._id_1AF6);
    }

    return 1;
  } else if(isDefined(self._id_95A8)) {
    self botclearscriptgoal();
    self._id_95A8 = undefined;
  }

  return 0;
}