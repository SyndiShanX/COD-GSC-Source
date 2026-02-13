/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2125.gsc
*************************************************/

_id_DEFA() {
  _id_0847::_id_DEEC();
  _id_0846::_id_C04E();
  level._id_0D00._id_5DB3 = ::_id_0D4A;
  level thread _id_DF09();
}

_id_DF09() {
  level endon("game_ended");

  for(;;) {
    level waittill("connected", var_0);
    var_0 _meth_867F("mp_default_mix", 0.0, 1);
  }
}

_id_DF0A() {
  var_0 = self;
  var_0 endon("disconnect");

  for(;;) {
    var_0 waittill("spawned_player");
  }
}

set_operator_context(var_0) {
  self _meth_84A8("mp_operator", var_0);
}

_id_0D4A(var_0) {
  self _meth_827E(var_0);
}

_id_2F49(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  foreach(var_12 in level.players) {
    if(_func_011F() == 1) {
      if(var_12 _meth_81E2() == 1 && var_12 _meth_81E3() == 0) {
        continue;
      }
    }

    if(isDefined(var_0) == 1 && isDefined(var_12.pers["team"]) == 1 && var_12.pers["team"] != var_0) {
      continue;
    }
    var_12 _id_0850::_id_2F47(var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
  }
}

_id_EABC(var_0) {
  if(!isDefined(level._id_EABB)) {
    level._id_EABB = [];
  }

  if(isDefined(level._id_EABB[var_0])) {
    return level._id_EABB[var_0];
  }

  var_1 = 0;
  level._id_EABB[var_0] = var_1;
  return var_1;
}

_id_0D4D() {
  var_0 = self;

  if(isDefined(var_0) == 0) {
    return;
  }
  if(isDefined(var_0._id_0B5D) == 0) {
    var_0._id_0B5D = [];
  }
}

_id_DF0B(var_0, var_1, var_2, var_3) {
  var_4 = self;

  if(_func_0458(var_4) == 1) {
    return;
  }
  var_4 _id_0D4D();

  if(_id_EABC(var_0) == 0) {
    return;
  }
  if(isDefined(var_1) == 0) {
    var_1 = 0.1;
  }

  if(isDefined(var_2) == 0) {
    var_2 = 1.0;
  }

  if(isDefined(var_3) == 1) {} else {}

  var_4._id_0B5D[var_0] = var_2;
  var_4 _id_DF0C(var_0, var_2, var_1);
}

_id_0D4C(var_0, var_1, var_2) {
  var_3 = self;
  var_3 notify("snd_player_submix_blend_calc_stop");
  var_3 endon("snd_player_submix_blend_calc_stop");
  var_3 endon("disconnect");

  if(var_2 > 0) {
    var_4 = var_3._id_0B5D[var_0];
    var_5 = var_1 - var_4;
    var_6 = int(var_2 / 0.05);
    var_7 = var_5 / (var_2 / 0.05);

    while(var_6 > 0) {
      if(!isDefined(var_3._id_0B5D[var_0])) {
        return;
      }
      var_3._id_0B5D[var_0] = var_3._id_0B5D[var_0] + var_7;
      var_6--;
      waitframe();
    }
  }

  var_3._id_0B5D[var_0] = var_1;
}

_id_DF0C(var_0, var_1, var_2) {
  var_3 = self;

  if(_func_0458(var_3) == 1) {
    return;
  }
  var_3 _id_0D4D();

  if(_id_EABC(var_0) == 0) {
    return;
  }
  if(isDefined(var_3._id_0B5D[var_0]) == 0) {
    var_3 _id_DF0B(var_0, 0.0, 0.0);
  }

  if(isDefined(var_2) == 1) {
    var_3 thread _id_0D4C(var_0, var_1, var_2);
  } else if(isDefined(var_1) == 1) {
    var_3._id_0B5D[var_0] = var_1;
  } else {
    var_3._id_0B5D[var_0] = var_1;
  }
}

_id_DF0D(var_0, var_1) {
  var_2 = self;

  if(_func_0458(var_2) == 1) {
    return;
  }
  var_2 _id_0D4D();

  if(_id_EABC(var_0) == 0) {
    return;
  }
  if(isDefined(var_1) == 1 && var_1 > 0.0) {
    var_2 _id_DF0C(var_0, 0.0, var_1);
  } else {
    var_2._id_0B5D[var_0] = undefined;
  }
}

_id_DF0E(var_0) {
  var_1 = self;
  return isDefined(var_1._id_0B5D) && isDefined(var_1._id_0B5D[var_0]);
}

_id_DF27(var_0, var_1, var_2, var_3, var_4) {
  thread _id_2F49(var_0, ::_id_DF0B, var_1, var_2, var_3, var_4);
}

_id_DF28(var_0, var_1, var_2, var_3) {
  thread _id_2F49(var_0, ::_id_DF0C, var_1, var_2, var_3);
}

_id_DF29(var_0, var_1, var_2) {
  thread _id_2F49(var_0, ::_id_DF0D, var_1, var_2);
}

krampus_spawn_sound(var_0) {
  _id_0847::_id_DF08("mp_krampus_spawn", var_0.origin);
  var_0 _meth_84A8("mp_operator", "krampus");
}

krampus_despawn_sound(var_0) {
  _id_0847::_id_DF08("mp_krampus_despawn", var_0.origin);
}