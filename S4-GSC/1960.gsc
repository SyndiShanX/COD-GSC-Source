/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 1960.gsc
*************************************************/

init() {
  _id_07A1::_id_CECC("military_ammo_restock", ::_id_1724);
  level._id_1725 = [];
  var_0 = getEntArray("ammo_restock_location", "targetname");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");

    if(!istrue(level._id_FE23) || isDefined(scripts\cp_mp\utility\game_utility::_id_6B18()) && isDefined(var_2._id_039B) && var_2._id_039B != level._id_96CC) {
      foreach(var_5 in var_3) {
        if(var_5.classname == "script_model") {
          var_5 delete();
          continue;
        }

        var_5 delete();
      }

      var_2 delete();
      continue;
    }

    var_2._id_F244 = [];
    level._id_1725[level._id_1725.size] = var_2;
  }

  if(isDefined(level._id_96CC) && level._id_96CC == "locale_6") {
    _id_171E();
  }
}

_id_1724(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(scripts\mp\utility\game::getgametype() == "br") {
    if(_id_2A0D(var_3)) {
      if(_id_07D1::_id_60BE("prematch_done") && getDvar("#x3f59526763711edc4", "") != "dmz") {
        var_0 _meth_86A8(var_3);
      } else {
        thread _id_171F(var_0, var_3, 5);
      }
    } else
      thread _id_171F(var_0, var_3, 0.1);
  } else if(scripts\mp\utility\game::getgametype() == "base" && getdvarint("#x376cf5adccd037fd6", 0))
    scripts\mp\gametypes\s4_armory_kiosk::_id_1720(var_3);
  else if(_id_1721(var_3, var_0._id_019B)) {
    thread _id_171F(var_0, var_3, 5);
  } else {
    thread _id_171F(var_0, var_3, 0.1);
  }
}

_id_171F(var_0, var_1, var_2) {
  var_1 endon("disconnect");
  var_0 _meth_86A8(var_1);
  wait(var_2);
  var_0 _meth_86A7(var_1);
}

_id_1721(var_0, var_1) {
  var_0 endon("death_or_disconnect");
  var_2 = var_0.primaryweapons;
  var_3 = [];

  foreach(var_5 in var_2) {
    if(!scripts\mp\utility\weapon::_id_88F9(var_5) && !scripts\mp\utility\weapon::_id_8A7D(var_5) && !scripts\mp\utility\weapon::_id_88F6(var_5) && !scripts\mp\utility\weapon::_id_8876(var_5) && !scripts\mp\utility\weapon::_id_8A38(var_5)) {
      var_3[var_3.size] = var_5;
    }
  }

  var_2 = var_3;
  var_7 = 0;

  foreach(var_9 in var_2) {
    if(weaponmaxammo(var_9) == var_0 getweaponammostock(var_9)) {
      var_7++;
    }
  }

  if(var_7 == var_2.size) {
    var_0 scripts\mp\hud_message::_id_DCA2("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return 0;
  }

  var_11 = [];

  foreach(var_13, var_5 in var_2) {
    var_11[var_13] = var_0 _meth_810A(var_5);
  }

  var_14 = 0;

  foreach(var_13, var_16 in var_11) {
    if(isDefined(var_11[var_13 + 1])) {
      if(var_11[var_13] == var_11[var_13 + 1]) {
        var_14 = 1;
        continue;
      }

      var_14 = 0;
    }
  }

  var_17 = 0;

  if(var_14) {
    foreach(var_5 in var_2) {
      var_17 = var_17 + weaponmaxammo(var_5);
    }
  }

  foreach(var_9 in var_2) {
    if(scripts\mp\utility\game::getgametype() == "br") {
      var_0 scripts\mp\gametypes\br_weapons::_id_2A4D(var_9, 2);
      continue;
    }

    var_21 = 0;

    if(var_9 _meth_8624("akimbo", 1)) {
      var_21 = 1;
    }

    var_22 = scripts\mp\weapons::_id_68BB(var_9);

    if(var_21) {
      var_23 = var_0 getweaponammostock(var_9);
      var_24 = int(min(weaponmaxammo(var_9), var_23 + var_22 * 2));
      var_0 setweaponammostock(var_9, var_24);

      if(weaponclipsize(var_9) != var_0 getweaponammoclip(var_9)) {
        var_0 setweaponammoclip(var_9, 0, "left");
        var_0 setweaponammoclip(var_9, 0, "right");
      }

      continue;
    }

    var_25 = var_0 getweaponammoclip(var_9);
    var_23 = var_0 getweaponammostock(var_9);

    if(scripts\mp\utility\weapon::_id_8A38(var_9)) {
      var_24 = int(min(weaponmaxammo(var_9), var_23 + var_22 * 1));
    } else if(var_14) {
      var_24 = int(min(var_17, var_23 + var_22 * 2));
    } else {
      var_24 = int(min(weaponmaxammo(var_9), var_23 + var_22 * 2));
    }

    if(var_9.basename == "iw8_lm_dblmg_mp") {
      var_0 setweaponammoclip(var_9, var_25 + var_22);
    } else {
      var_0 setweaponammostock(var_9, var_24);
    }
  }

  var_0 _id_07C4::_id_7B6B("br_ammo");
  var_0 playlocalsound("iw8_support_box_use");
  return 1;
}

_id_2A0D(var_0) {
  var_1 = 0;
  var_2 = [];
  var_3 = var_0 getweaponslistprimaries();

  foreach(var_5 in var_3) {
    var_6 = scripts\mp\gametypes\br_weapons::_id_2A07(var_5);

    if(var_5._id_0245 && scripts\mp\utility\weapon::_id_1DA5(var_5._id_04B7) == "ubshtgn") {
      var_7 = weaponclipsize(var_5);
      var_8 = int(var_7);
      var_0 setweaponammoclip(var_5, var_8);
      continue;
    } else if(!isDefined(var_6)) {
      continue;
    }
    var_9 = 1;

    if(var_2.size >= 1) {
      foreach(var_11 in var_2) {
        if(var_6 == var_11) {
          var_9 = 0;
        }
      }
    }

    if(var_9) {
      var_2[var_2.size] = var_6;
      var_0 scripts\mp\gametypes\br_weapons::_id_2A4D(var_5, 2);
      var_1 = 1;
    }
  }

  if(!var_1) {
    var_0 scripts\mp\hud_message::_id_DCA2("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    return 0;
  }

  var_0 _id_07C4::_id_7B6B("br_ammo");
  var_0 playlocalsound("iw8_support_box_use");
  return 1;
}

_id_171E() {
  var_0 = [];
  var_0[0] = (15946, -71, -469);
  var_0[1] = (16829, -8996, -333);
  var_0[2] = (16531, -13847, -154);
  var_0[3] = (24472, -14782, -134);
  var_0[4] = (22373, -19948, -36);
  var_0[5] = (18250, -2057, -439);
  var_0[6] = (17549, -4262, -432);
  var_0[7] = (19147, -11546, -257);
  var_0[8] = (19845, -21990, -98);
  var_0[9] = (19838, -18100, -23);
  var_0[10] = (21978, -11276, -58);

  foreach(var_2 in level._id_1725) {
    var_3 = 0;

    foreach(var_5 in var_0) {
      if(var_3) {
        break;
      }

      if(distance2dsquared(var_2.origin, var_5) < 10000) {
        var_3 = 1;
      }
    }

    if(var_3) {
      var_7 = getEntArray(var_2.target, "targetname");

      foreach(var_9 in var_7) {
        if(var_9.classname == "script_model") {
          var_9 delete();
          continue;
        }

        var_9 delete();
      }

      var_2 delete();
    }
  }
}