/***************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\agents\_agents_gametype_dom.gsc
***************************************************/

func_00F9() {
  func_87A7();
}

func_87A7() {
  level.var_0A41["squadmate"]["gametype_update"] = ::func_0A49;
  level.var_0A41["player"]["think"] = ::func_0A45;
}

func_0A45() {
  thread maps\mp\bots\_bots_gametype_dom::func_19B7();
}

func_0A49() {
  var_00 = undefined;
  foreach(var_02 in self.var_0117.var_9AC5) {
    if(var_02.var_A222.var_502A == "domFlag") {
      var_00 = var_02;
    }
  }

  if(isDefined(var_00)) {
    var_04 = var_00 maps\mp\gametypes\dom::func_44E3();
    if(var_04 != self.var_01A7) {
      if(!maps\mp\bots\_bots_gametype_dom::func_1A29(var_00)) {
        maps\mp\bots\_bots_gametype_dom::func_1FAD(var_00, "critical", 1);
      }

      return 1;
    }
  }

  return 0;
}