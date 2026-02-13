/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2677.gsc
*************************************************/

_id_81D4() {
  level._id_ED1A = [];
  level thread _id_BF3A();
}

_id_BF3A() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    level._id_ED1A[var_0 scripts\mp\utility\player::getuniqueid()] = spawn("script_model", (0, 0, 0));
  }
}

_id_BEC0(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    level._id_ED1A[var_1 scripts\mp\utility\player::getuniqueid()] _id_603A();
  }

  var_4 = 0;

  if(!isDefined(var_3)) {
    var_4 = level._id_ED1A[var_1 scripts\mp\utility\player::getuniqueid()] thread _id_6038(::_id_B28D, var_0, var_1);
  } else {
    var_4 = level._id_ED1A[var_1 scripts\mp\utility\player::getuniqueid()] thread _id_603E(var_3, ::_id_B28D, var_0, var_1);
  }

  return var_4;
}

_id_BEC1(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2)) {
    foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(var_1, "players")) {
      level._id_ED1A[var_5 scripts\mp\utility\player::getuniqueid()] _id_603A();
    }
  }

  var_7 = 0;

  foreach(var_5 in scripts\mp\utility\teams::_id_6DCA(var_1, "players")) {
    if(!isDefined(var_3)) {
      var_7 = level._id_ED1A[var_5 scripts\mp\utility\player::getuniqueid()] thread _id_6038(::_id_B28D, var_0, var_5);
      continue;
    }

    var_7 = level._id_ED1A[var_5 scripts\mp\utility\player::getuniqueid()] thread _id_603E(var_3, ::_id_B28D, var_0, var_5);
  }

  return var_7;
}

_id_B28D(var_0, var_1, var_2) {
  var_1 playlocalsound(var_0, var_2);
  var_3 = _func_0142(var_0);
  wait(0.5 + var_3 / 1000.0);

  if(isDefined(var_2)) {
    self notify(var_2);
  }
}

_id_6038(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = spawnStruct();
  var_6 thread _id_603C(self, var_0, var_1, var_2, var_3, var_4, var_5);
  return _id_6040(var_6);
}

_id_603E(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = spawnStruct();
  var_7 thread _id_603C(self, var_1, var_2, var_3, var_4, var_5, var_6);

  if(isDefined(var_7._id_603B) || var_7 scripts\engine\utility::_id_108A7(var_0, "function_stack_func_begun") != "timeout") {
    return _id_6040(var_7);
  } else {
    var_7 notify("death");
    return 0;
  }
}

_id_603A() {
  if(!isDefined(self._id_6038)) {
    return;
  }
  var_0 = [];

  if(isDefined(self._id_6038[0]) && isDefined(self._id_6038[0]._id_603B)) {
    var_0[0] = self._id_6038[0];
  }

  self._id_6038 = undefined;
  self notify("clear_function_stack");
  waittillframeend;

  if(!var_0.size) {
    return;
  }
  if(!var_0[0]._id_603B) {
    return;
  }
  self._id_6038 = var_0;
}

_id_603F(var_0) {
  self endon("death");
  var_0 scripts\engine\utility::_id_108C5("function_done", "death");
}

_id_6040(var_0) {
  _id_603F(var_0);

  if(!isDefined(self)) {
    return 0;
  }

  if(!_func_011D(self)) {
    return 1;
  }

  if(isalive(self)) {
    return 1;
  }

  return 0;
}

_id_603C(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  self endon("death");

  if(!isDefined(var_0._id_6038)) {
    var_0._id_6038 = [];
  }

  var_0._id_6038[var_0._id_6038.size] = self;
  thread _id_603D(var_0);
  _id_6039(var_0);

  if(isDefined(var_0) && isDefined(var_0._id_6038)) {
    self._id_603B = 1;
    self notify("function_stack_func_begun");

    if(isDefined(var_6)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5, var_6);
    } else if(isDefined(var_5)) {
      var_0[[var_1]](var_2, var_3, var_4, var_5);
    } else if(isDefined(var_4)) {
      var_0[[var_1]](var_2, var_3, var_4);
    } else if(isDefined(var_3)) {
      var_0[[var_1]](var_2, var_3);
    } else if(isDefined(var_2)) {
      var_0[[var_1]](var_2);
    } else {
      var_0[[var_1]]();
    }

    if(isDefined(var_0) && isDefined(var_0._id_6038)) {
      var_0._id_6038 = scripts\engine\utility::array_remove(var_0._id_6038, self);
      var_0 notify("level_function_stack_ready");
    }
  }

  if(isDefined(self)) {
    self._id_603B = 0;
    self notify("function_done");
  }
}

_id_603D(var_0) {
  self endon("function_done");
  self waittill("death");

  if(isDefined(var_0)) {
    var_0._id_6038 = scripts\engine\utility::array_remove(var_0._id_6038, self);
    var_0 notify("level_function_stack_ready");
  }
}

_id_6039(var_0) {
  var_0 endon("death");
  self endon("death");
  var_0 endon("clear_function_stack");

  while(var_0._id_6038[0] != self) {
    var_0 waittill("level_function_stack_ready");
  }
}

_id_244C() {
  anim._id_CF72 = gettime();
}