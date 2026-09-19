/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_dom.gsc
***********************************************************/

main() {
  _id_87A7();
}

_id_87A7() {
  level._id_0A41["squadmate"]["gametype_update"] = ::_id_0A49;
  level._id_0A41["player"]["think"] = ::_id_0A45;
}

_id_0A45() {
  thread maps\mp\bots\_bots_gametype_dom::_id_19B7();
}

_id_0A49() {
  var_0 = undefined;

  foreach(var_2 in self._id_0117._id_9AC5) {
    if(var_2._id_A222._id_502A == "domFlag")
      var_0 = var_2;
  }

  if(isDefined(var_0)) {
    var_4 = var_0 maps\mp\gametypes\dom::_id_44E3();

    if(var_4 != self.team) {
      if(!maps\mp\bots\_bots_gametype_dom::_id_1A29(var_0))
        maps\mp\bots\_bots_gametype_dom::_id_1FAD(var_0, "critical", 1);

      return 1;
    }
  }

  return 0;
}