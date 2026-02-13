/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1978.gsc
*************************************************/

init() {
  level._id_2F7C = spawnStruct();
  level._id_2F7C._id_2FCD = "mp/map_callouts/" + level.mapname + "_callouts.csv";
  _id_3FA1();

  if(scripts\mp\utility\game::getgametype() == "br") {
    return;
  }
  level._id_2F7C._id_1A53 = getEntArray("callout_area", "targetname");

  foreach(var_1 in level._id_2F7C._id_1A53) {
    var_1 thread _id_2F7A();
  }

  thread _id_A135();
}

_id_3FA1() {
  var_0 = level._id_2F7C;
  var_0._id_1A51 = [];
  var_0._id_1A51["none"] = -1;

  if(!_func_0221(level._id_2F7C._id_2FCD)) {
    return;
  }
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_1, 0);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_2 = int(var_2);
    var_3 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_1, 3);

    if(var_3 != "area") {} else {
      var_4 = tablelookupbyrow(level._id_2F7C._id_2FCD, var_1, 1);
      var_0._id_1A51[var_4] = var_2;
    }

    var_1++;
  }
}

_id_A135() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 thread _id_3929();
    var_0 _id_D65C("none");
  }
}

_id_2F7A() {
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", var_0);

    if(!isPlayer(var_0)) {
      continue;
    }
    var_0 _id_D65C(self._id_039B, self);
  }
}

_id_D65C(var_0, var_1) {
  if(isDefined(self._id_2F79) && self._id_2F79 == var_0) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() != "br") {
    if(isDefined(self._id_2F79) && var_0 != "none" && self._id_2F79 != "none") {
      return;
    }
  }

  self._id_2F79 = var_0;

  if(isDefined(var_1)) {
    thread _id_10BE1(var_1, var_1._id_039B);
  }

  var_2 = level._id_2F7C._id_1A51[var_0];

  if(isDefined(var_2)) {
    self setclientomnvar("ui_callout_area_id", var_2);
    var_3 = scripts\mp\utility\player::_id_66AA(1, 0);

    foreach(var_5 in var_3) {
      if(var_5 _meth_81D3()) {
        var_5 setclientomnvar("ui_callout_area_id", var_2);
      }
    }
  } else if(var_0 != "none")
    return;
}

_id_10BE1(var_0, var_1) {
  self endon("death_or_disconnect");

  for(;;) {
    if(self._id_2F79 != var_1) {
      return;
    }
    if(!self istouching(var_0)) {
      _id_D65C("none");
      return;
    }

    wait 0.5;
  }
}

_id_3929() {
  self endon("disconnect");

  for(;;) {
    self waittill("death");
    _id_D65C("none");
  }
}