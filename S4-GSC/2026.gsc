/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2026.gsc
*************************************************/

_id_7580(var_0) {
  return _id_6B09(var_0) > 0;
}

_id_6B09(var_0) {
  if(isDefined(var_0._id_9457)) {
    return var_0._id_9457;
  }

  return 0;
}

_id_D5E2(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 1;
  }

  if(!isDefined(var_3)) {
    var_3 = 1;
  }

  if(_id_9450(var_0)) {
    var_1 = 0;
    var_2 = 1;
  }

  var_4 = _id_6B09(var_0);

  if(!var_2 && var_4 > var_1) {
    var_1 = var_4;
  }

  if(var_4 <= 0 && var_1 > 0) {
    _id_9453(var_0, var_1, var_3);
    return;
  }

  if(var_4 > 0 && var_1 <= 0) {
    _id_9455(var_0);
    return;
  }

  var_0._id_9457 = var_1;

  if(isPlayer(var_0) && var_4 <= var_1 && var_1 > 0 && var_3 == 1) {
    thread _id_9454(var_0);
  }

  if(isPlayer(var_0)) {
    _id_9456(var_0);
  }
}

init() {
  level._effect["lightArmor_persistent"] = loadfx("vfx/core/mp/core/vfx_uplink_carrier.vfx");
}

_id_9453(var_0, var_1, var_2) {
  var_0 notify("lightArmor_set");
  var_0._id_9457 = var_1;
  var_0._id_9459 = var_1;

  if(getdvarint("#x3d89605100dc8a2bb", 0) > 0) {
    var_0._id_9459 = getdvarint("#x3d89605100dc8a2bb", 0);
  }

  if(getdvarint("#x33e6eddcc51ceb436", 0) > 0) {
    iprintlnbold("New armor value: " + var_0._id_9457);
  }

  _id_9456(var_0);
  thread _id_9452(var_0);

  if(isPlayer(var_0) && var_2 == 1) {
    thread _id_9454(var_0);
  }
}

_id_9455(var_0) {
  var_0 notify("lightArmor_unset");
  var_0._id_9457 = undefined;
  _id_9456(var_0);

  if(isPlayer(var_0)) {}

  var_0 notify("remove_light_armor");
}

_id_9451(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  var_11 = 0;
  var_12 = 0;
  var_13 = var_0._id_9457;

  if(!isDefined(var_10)) {
    var_10 = 1;
  }

  if(!var_11) {
    if(var_4 == "MOD_FALLING") {
      var_11 = 1;
    }
  }

  if(!var_11) {
    if(scripts\engine\utility::_id_8794(var_4) && var_4 == "MOD_HEAD_SHOT") {
      var_11 = 1;
    }
  }

  if(!var_11) {
    if(_func_010F(var_4)) {
      if(isDefined(var_9) && isDefined(var_9._id_EA8F) && var_9._id_EA8F == var_0) {
        var_11 = 1;
      }
    }
  }

  if(!var_11) {
    if(scripts\mp\utility\weapon::_id_8A76(var_5)) {
      var_11 = 1;
    }
  }

  if(!var_11) {
    if(isDefined(var_6) && isDefined(var_7)) {
      playFX(level._effect["steel_bib_bullet_impact"], var_6, (0, 0, 0) - var_7);
    }

    var_12 = min(var_2 + var_3, var_0._id_9457);
    var_13 = var_13 - (var_2 + var_3);

    if(!var_10) {
      var_0._id_9457 = var_0._id_9457 - (var_2 + var_3);
    }

    var_2 = 0;
    var_3 = 0;

    if(var_13 <= 0) {
      var_2 = abs(var_13);
      var_3 = 0;

      if(!var_10) {
        var_1._id_2BFB = gettime();
        _id_9455(var_0);
      }
    }
  }

  if(!var_10) {
    _id_9456(self);
  }

  if(var_12 > 0 && var_2 == 0) {
    var_2 = 1;
  }

  return [var_12, var_2, var_3];
}

_id_9450(var_0) {
  if(var_0 _id_07DE::_id_756F()) {
    return 1;
  }

  return 0;
}

_id_9452(var_0) {
  var_0 endon("disconnect");
  var_0 endon("lightArmor_set");
  var_0 endon("lightArmor_unset");
  var_0 waittill("death");
  thread _id_9455(var_0);
}

_id_9456(var_0) {
  if(!isPlayer(var_0)) {
    return;
  }
  if(!isDefined(var_0._id_9457) || !isDefined(var_0._id_9459)) {
    var_0 setclientomnvar("ui_light_armor_health", 0);
    return;
  }

  var_1 = var_0._id_9457 / var_0._id_9459;
  var_0 setclientomnvar("ui_light_armor_health", var_1);
}

_id_9454(var_0) {}