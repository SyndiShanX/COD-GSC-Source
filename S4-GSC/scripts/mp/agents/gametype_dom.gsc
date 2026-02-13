/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\agents\gametype_dom.gsc
*************************************************/

main() {
  _id_D795();
}

_id_D795() {
  level._id_11EF["player"]["think"] = ::_id_11FE;
}

_id_11FE() {
  thread scripts\mp\bots\bots_gametype_dom::_id_277D();
}

_id_120B() {
  var_0 = undefined;

  foreach(var_2 in self.owner._id_F398) {
    if(var_2._id_7C8C == "domFlag") {
      var_0 = var_2;
    }
  }

  if(isDefined(var_0)) {
    var_4 = var_0 scripts\mp\gametypes\dom::_id_6A45();

    if(var_4 != self.team) {
      if(!scripts\mp\bots\bots_gametype_dom::_id_2802(var_0)) {
        scripts\mp\bots\bots_gametype_dom::_id_3221(var_0, "critical", 1);
      }

      return 1;
    }
  }

  return 0;
}