/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1850.gsc
*************************************************/

_id_C1F2() {}

_id_8E8D(var_0, var_1) {
  var_2 = &"COOP_CRAFTING/PLACE_LADDER";
  return var_2;
}

_id_8E8B(var_0, var_1) {
  if(_id_B16B(var_0, var_1)) {
    _id_0737::_id_C3C5(var_0);
  }
}

_id_8E8E(var_0) {
  foreach(var_2 in var_0) {
    if(var_2._id_039B == "dynamicLadder") {
      _id_CDBE();
      var_3 = scripts\engine\utility::_id_5000(var_2.origin, 50.0, -200.0);
      var_2._id_CBD0 = spawn("script_origin", var_3);
      var_2._id_CBD0.angles = (0, var_2.angles[1], 0);
      var_4 = spawnStruct();
      _id_0FCE(var_4, var_2);

      if(!isDefined(level._id_50B5)) {
        level._id_50B5 = [];
      }

      level._id_50B5[level._id_50B5.size] = var_4;

      if(abs(var_3[2] - var_4._id_5526[0].origin[2]) > 32) {
        var_2._id_88A3 = 1;
      }

      if(isDefined(var_4._id_5526) && isDefined(var_4._id_5526[var_4._id_5526.size - 1])) {
        var_4._id_5526[var_4._id_5526.size - 1].origin = var_4._id_5526[var_4._id_5526.size - 1].origin - (0, 5000, 0);
      }
    }
  }
}

_id_4A17() {
  foreach(var_1 in level._id_50B5) {
    foreach(var_3 in var_1._id_5526) {
      _id_0737::_id_C3C5(var_3);
    }
  }
}

_id_CDBE() {}

_id_D867() {
  _id_CDBE();
  var_0 = getEntArray("dynamicLadder", "targetname");

  foreach(var_2 in var_0) {
    var_3 = spawnStruct();
    _id_0FCE(var_3, var_2);

    if(!isDefined(level._id_50B5)) {
      level._id_50B5 = [];
    }

    level._id_50B5[level._id_50B5.size] = var_3;
  }
}

_id_0FCE(var_0, var_1) {
  if(!isDefined(var_0._id_5526)) {
    var_0._id_5526 = [];
  }

  var_0._id_5526[var_0._id_5526.size] = var_1;

  if(isDefined(var_1.target)) {
    var_2 = getEntArray(var_1.target, "targetname");

    if(isDefined(var_2) && var_2.size > 0) {
      foreach(var_4 in var_2) {
        _id_0FCE(var_0, var_4);
      }
    }
  }
}

#using_animtree("script_model");

_id_3F5D(var_0, var_1, var_2) {
  if(!isDefined(var_0) || isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0._id_18AF = var_1;

  if(!isDefined(var_2)) {
    var_2 = "viewhands_base_iw8";
  }

  var_0 _meth_8282(var_0.origin);
  var_3 = spawn("script_arms", var_0.origin, 0, 0, var_0);
  var_3.player = var_0;
  var_0._id_B5A4 = var_3;
  var_0._id_B5A4 hide();
  var_0._id_B5A4._id_18AF = var_1;
  var_0._id_B5A4 useanimtree(#animtree);
  var_0 playerlinktodelta(var_0._id_B5A4, "tag_player", 1, 0, 0, 0, 0, 0, 0);
  var_0 _id_10A7E();
  _id_C436(var_0);
}

_id_C436(var_0) {
  if(!isDefined(var_0) || !isDefined(var_0._id_B5A4)) {
    return;
  }
  var_0 unlink();
  var_1 = var_0 _meth_812D(var_0.origin);

  if(isDefined(var_1)) {
    var_0 setorigin(var_1);
  } else {
    var_0 setorigin(var_0.origin + (0, 0, 100));
  }

  var_0._id_B5A4 delete();
  var_0._id_B5A4 = undefined;
}

_id_10A7E(var_0) {
  scripts\engine\utility::waittill_any_3("remove_rig", "death", "disconnect");
}

_id_10BD6(var_0) {
  self endon("ladder_complete");
  self._id_315E = 0;

  for(;;) {
    if(!isDefined(var_0) || !var_0 scripts\cp_mp\utility\player_utility::_isalive()) {
      self._id_315E = 1;
      break;
    }

    waitframe();
  }
}

_id_B16B(var_0, var_1) {
  var_0 thread _id_10BD6(var_1);
  var_1._id_9515 = var_1 scripts\engine\utility::spawn_tag_origin();
  var_1 playerlinktodelta(var_1._id_9515, "tag_origin", 1, 0, 0, 0, 0, 0);
  var_1._id_9515 moveto(var_0._id_CBD0.origin, 0.25, 0.1, 0.1);
  var_1._id_9515 rotateto(var_0._id_CBD0.angles, 0.25, 0.1, 0.1);
  var_1 setstance("stand");
  wait 0.25;

  if(istrue(self._id_315E)) {
    return 0;
  }

  var_1 unlink();
  var_1._id_9515 delete();
  var_1._id_9515 = undefined;
  var_1 setorigin(var_0._id_CBD0.origin);
  var_1 setplayerangles(var_0._id_CBD0.angles);
  var_2 = "place";
  var_2 = scripts\engine\utility::ter_op(istrue(var_0._id_88A3), "place_high", "place");
  setDvar("#x3a581704564ef6d45", 1);
  thread _id_3F5D(var_1, "player");
  var_0._id_CBD0 thread _id_0706::_id_17FD(var_1, var_1._id_B5A4, var_2);

  if(isDefined(var_0.target)) {
    getent(var_0.target, "targetname").origin = getent(var_0.target, "targetname").origin + (0, 5000, 0);
  }

  var_3 = spawn("script_model", var_0._id_CBD0.origin);
  var_3 setModel("tactical_ladder_vm");
  var_3._id_18AF = "ladder";
  var_3 useanimtree(#animtree);
  var_0._id_B15E = var_3;
  var_0._id_CBD0 thread _id_06C6::_id_1845(var_3, var_2);
  var_4 = _func_0079(level._id_CC31["player"][var_2]);
  wait(var_4);
  setDvar("#x3a581704564ef6d45", 0);

  if(istrue(var_0._id_315E)) {
    return 0;
  }

  var_1 notify("ladder_complete");
  _id_C436(var_1);
  var_0 notify("ladder_complete");
  return 1;
}