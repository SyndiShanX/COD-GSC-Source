/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\agents\_agents_gametype_lockdown.gsc
****************************************************************/

main() {
  setup_callbacks();
}

setup_callbacks() {
  level._id_0A41["squadmate"]["gametype_update"] = ::_id_0A49;
  level._id_0A41["player"]["think"] = ::_id_0A45;
}

_id_0A45() {
  thread maps\mp\bots\_bots_gametype_dom::bot_dom_think();
}

_id_0A49() {
  var_0 = undefined;

  foreach(var_2 in self._id_0117.touchtriggers) {
    if(var_2.useobj.id == "domFlag") {
      var_0 = var_2;
    }
  }

  if(isDefined(var_0)) {
    var_4 = var_0 maps\mp\gametypes\dom::getflagteam();

    if(var_4 != self.team) {
      if(!maps\mp\bots\_bots_gametype_dom::bot_is_capturing_flag(var_0)) {
        maps\mp\bots\_bots_gametype_dom::capture_flag(var_0, "critical", 1);
      }

      return 1;
    }
  }

  return 0;
}