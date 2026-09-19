/*******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\hub_vl_base.gsc
*******************************************/

_id_A59E(var_0) {}

_id_A59F(var_0) {}

_id_A58F() {
  _id_A591();
}

_id_A591() {
  setDvar("1932", 0.15);
  setDvar("1175", 3);
  setDvar("190", 1.5);
  _func_2BB();
  level.partymembers_cb = maps\mp\hub_vl_camera::_id_6EA2;
  level._id_A595 = [];
  level._id_AAE2 = [];
  level._id_13B8 = [];
  var_0 = 48;

  for(var_1 = 0; var_1 < var_0; var_1++) {
    level._id_13B8[var_1] = spawnStruct();
    level._id_13B8[var_1]._id_9A1A = 0;
    level._id_13B8[var_1]._id_01D6 = "";
  }

  level._id_6077 = var_0;
  thread maps\mp\hub_vl_camera::_id_631E();
  thread maps\mp\hub_vl_camera::_id_6320();
  setDvar("1999", 0);
  level._id_6871 = 4;
  maps\mp\hub_vl_firingrange::_id_51D0();
}

_id_5167() {}

_id_0C0E() {
  if(level._id_A1FE)
    var_0 = spawnStruct();
  else
    var_0 = spawn("script_model", (0, 0, 0), 0);

  var_0.team = "free";
  return var_0;
}

_id_3E76(var_0) {
  var_0 notify("free_avatar");

  if(level._id_A1FE) {
    for(var_1 = 0; var_1 < 48; var_1++) {
      if(var_0._id_A561[var_1]) {
        var_2 = level.players[var_1];

        if(isDefined(var_2))
          maps\mp\hub_vl_camera::_id_05E0(var_2 getentitynumber(), var_0._id_20F1, "free");
      }
    }
  } else
    var_0 delete();
}

_id_6BA7() {
  level._id_0A41["player"]["on_killed"] = ::_id_6A75;
  thread maps\mp\hub_vl_camera::_id_A59C();
  thread maps\mp\hub_vl_camera::_id_631F();
  thread maps\mp\hub_vl_camera::_id_62F9(0);
  thread maps\mp\hub_vl_camera::_id_62F8(0);
  thread maps\mp\hub_vl_camera::_id_62F4();
  thread _id_6323(self);
  _id_2F52();
}

_id_6A75(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {}

_id_734C() {
  if(common_scripts\utility::_id_55E0()) {
    var_0 = undefined;
    return isDefined(var_0) && (var_0 == "thumbstick_southpaw" || var_0 == "thumbstick_legacy");
  }

  return 0;
}

_id_7323(var_0) {
  if(!isDefined(var_0._id_3A08)) {
    if(isDefined(var_0._id_942C))
      var_0._id_3A08 = var_0._id_942C;
    else
      var_0._id_3A08 = 0;
  }
}

_id_7283(var_0) {
  if(_id_734C()) {
    _id_7323(var_0);
    return var_0._id_3A08;
  } else {
    var_1 = self getunnormalizedcameramovement();
    return var_1[1];
  }
}

_id_738B(var_0) {
  var_1 = 0;

  if(_id_734C()) {
    _id_7323(var_0);
    var_2 = self getnormalizedmovement();
    var_3 = -12;
    var_4 = var_2[1] * var_3;
    var_0._id_3A08 = _angleclamp(var_0._id_3A08 + var_4);
    var_1 = var_0._id_3A08;
  } else {
    var_2 = self getunnormalizedcameramovement();
    var_1 = var_2[1];

    if(isDefined(var_0._id_3A08))
      var_0._id_3A08 = undefined;
  }

  return var_1;
}

_id_7699(var_0, var_1) {
  var_0._id_942C = _id_7283(var_0);
  var_0._id_7EF8 = 0;
  var_0._id_942A = var_0.angles[1];
  var_0._id_6469 = 0;
  var_0._id_7593 = 0;
  var_0._id_6652 = 0;
  var_0._id_09F8 = 0;
  var_1 = (0, var_1[1], 0);

  if(isDefined(var_1))
    var_0.angles = var_1;
}

_id_13B5(var_0) {
  return level._id_13B8[var_0]._id_9A1A > 0;
}

springcamdisabled(var_0, var_1) {
  maps\mp\hub_vl_camera::_id_7C75(var_0);
}

_id_0BC6() {
  if(level._id_A595.size == 0)
    return 0;

  foreach(var_2, var_1 in level._id_13B8) {
    if(!isDefined(level._id_A595[var_2])) {
      continue;
    }
    if(var_1._id_9A1A == 0)
      return 0;
  }

  return 1;
}

_id_7E37(var_0) {
  var_1 = undefined;

  foreach(var_4, var_3 in level._id_AAE2) {
    var_1 = level._id_A595[var_3];
    level._id_A595[var_3] = undefined;
    _setentplayerxuidforemblem(var_1, var_4, 1);
    level._id_AAE2[var_4] = undefined;
  }

  level._id_AAE2[var_0] = 0;
  level._id_13B8[0]._id_9A1A = 0;
  level._id_13B8[0]._id_01D6 = var_0;

  if(isDefined(var_1)) {
    _setentplayerxuidforemblem(var_1, var_0);
    level._id_A595[0] = var_1;
  }
}

_id_0902(var_0) {
  var_1 = -1;
  var_2 = -1;

  while(var_2 == var_1) {
    var_1++;

    foreach(var_2 in level._id_AAE2) {
      if(var_2 == var_1) {
        break;
      }
    }
  }

  _id_A59E("Adding new xuid " + var_0 + " with ownerId=" + var_1 + "\n");
  level._id_AAE2[var_0] = var_1;
  level._id_13B8[var_1]._id_01D6 = var_0;
  level._id_13B8[var_1]._id_9A1A = 0;
  return var_1;
}

_id_13B4(var_0) {
  if(isDefined(level._id_6651))
    thread maps\mp\hub_vl_camera::_id_8A5F();
}

_id_A095() {
  var_0 = 0;

  foreach(var_3, var_2 in level._id_13B8) {
    if(var_2._id_9A1A > 0 && gettime() > var_2._id_9A1A) {
      _id_A59E("update_avatars removing ownerId" + var_3 + "\n");
      maps\mp\hub_vl_camera::_id_7C75(var_3);
      var_0 = 1;
    }
  }

  if(var_0)
    wait 0.1;
}

_id_8BD4() {
  foreach(var_2, var_1 in level._id_A595) {
    if(var_2 == 0) {
      continue;
    }
    maps\mp\hub_vl_camera::_id_8BBB(var_1);
  }
}

_id_7E92(var_0, var_1) {
  var_2 = _id_738B(var_0);
  var_3 = _angleclamp(var_2 - var_0._id_942C);
  var_4 = getdvarfloat("ui_mouse_char_rot", 0);

  if(var_4 != 0) {
    var_0._id_6469 = _angleclamp(var_0._id_6469 + var_4);
    _setdynamicdvar("ui_mouse_char_rot", 0);
  }

  var_5 = maps\mp\hub_vl_camera::_id_4590(var_0, var_3, var_1);
  var_5 = var_5 * -1;
  var_6 = _angleclamp(var_0._id_942A + var_5 + var_0._id_6469);
  var_7 = (0, var_6, 0);

  if(_isagent(var_0))
    var_0 setplayerangles(var_7);
  else {
    var_8 = distance(var_7, var_0.angles);

    if(var_8 > 0.01)
      maps\mp\hub_vl_camera::_id_05E0(var_0.player getentitynumber(), var_0._id_20F1, "angles", var_7);

    var_0.angles = var_7;
  }
}

_id_73F8(var_0) {
  var_1 = _id_7283(var_0);
  var_2 = _angleclamp(var_1 - var_0._id_942C);

  if(self._id_4B9E == 0) {
    if(_abs(var_2) >= 1) {
      var_0._id_942A = var_0.angles[1];
      return 1;
    } else
      return 0;
  } else
    return 1;
}

_id_2F52() {
  self notify("kill_enable_weapons");
  self allowfire(0);
}

_id_3639() {
  self endon("enter_lobby");
  self endon("kill_enable_weapons");
  var_0 = getdvarint("2454", 0);

  if(var_0 == 1 && self._id_50CA == 1)
    self allowfire(1);
}

_id_37B6(var_0) {
  maps\mp\hub_vl_firingrange::_id_2A72();
  var_1 = var_0._id_1E99;

  if(!level._id_A1FE) {
    var_0 setOrigin(var_1.origin);
    var_0 playerlinkto(var_1, "tag_player");
    var_0 cameralinkto(var_1, "tag_player");
  }

  if(isDefined(var_0._id_A595) && isDefined(var_0._id_6A4F) && isDefined(level._id_A595[var_0._id_6A4F]))
    var_0 _id_7699(level._id_A595[var_0._id_6A4F], level._id_A595[var_0._id_6A4F].angles);

  var_0._id_50CA = 0;
  var_0 allowfire(0);
  maps\mp\_utility::_id_A165("spectator");
}

_id_6323(var_0) {
  for(;;) {
    if(isDefined(var_0._id_50CA)) {
      var_1 = getdvarint("2454", 0);

      if(var_1 == 1 && !var_0._id_50CA) {
        var_2 = maps\mp\_utility::getclassindex("lobby" + (var_0._id_294D + 1));
        var_3 = maps\mp\_utility::_id_1E01();
        var_4 = var_0._id_5E01[var_3][var_2];
        var_5 = var_4["primaryWeaponStruct"];
        var_6 = var_4["secondaryWeaponStruct"];
        var_7 = var_4["meleeWeaponStruct"];

        if(isDefined(level._id_A595) && isDefined(var_0._id_6A4F) && isDefined(level._id_A595[var_0._id_6A4F]))
          var_0 _id_7699(level._id_A595[var_0._id_6A4F], level._id_A595[var_0._id_6A4F].angles);

        var_8 = [];

        if(isDefined(var_5) && isDefined(var_5.guid) && var_5.guid != 0) {
          var_9 = maps\mp\_utility::_id_4737(var_5);
          var_8[var_8.size] = maps\mp\gametypes\_class::_id_1D66(var_9, var_4["primaryAttachmentsGUID"][0], var_4["primaryAttachmentsGUID"][1], var_4["primaryAttachmentsGUID"][2], var_4["primaryAttachmentsGUID"][3], var_4["primaryAttachmentsGUID"][4], var_4["primaryAttachmentsGUID"][5], maps\mp\_utility::_id_472D(var_5), 0, 0, 0, 0);
        }

        if(isDefined(var_6) && isDefined(var_6.guid) && var_6.guid != 0) {
          var_9 = maps\mp\_utility::_id_4737(var_6);
          var_8[var_8.size] = maps\mp\gametypes\_class::_id_1D66(var_9, var_4["secondaryAttachmentsGUID"][0], var_4["secondaryAttachmentsGUID"][1], var_4["secondaryAttachmentsGUID"][2], var_4["secondaryAttachmentsGUID"][3], var_4["secondaryAttachmentsGUID"][4], var_4["secondaryAttachmentsGUID"][5], maps\mp\_utility::_id_472D(var_6), 0, 0, 0, 0);
        }

        if(isDefined(var_7) && isDefined(var_7.guid) && var_7.guid != 0)
          var_8[var_8.size] = maps\mp\_utility::_id_4737(var_7);

        while(var_8.size > 0) {
          var_10 = var_0 loadweapons(var_8);

          if(var_10 == 1) {
            break;
          }

          waitframe();
        }

        var_0 showviewmodel();
        maps\mp\hub_vl_firingrange::_id_37B1(var_0);
        var_0 clientclearsoundsubmix("mp_no_foley", 1);
        setDvar("1175", 0);
        setDvar("190", 1);
      } else if(var_1 == 0 && var_0._id_50CA) {
        var_0 hideviewmodel();
        var_0 _id_3C3C();
        var_0 _id_2F52();

        if(isDefined(var_0.primaryweapon))
          var_0 switchtoweapon(var_0.primaryweapon);

        var_0 notify("enter_lobby");
        _id_37B6(var_0);
        var_0 clientaddsoundsubmix("mp_no_foley", 1);
        setDvar("1175", 3);
        setDvar("190", 1.5);
      }
    }

    waitframe();
  }
}

_id_3C3C() {
  var_0 = self;
  var_0 maps\mp\hub_vl_firingrange::_id_4864();
  var_1 = var_0 getweaponslistoffhands();

  foreach(var_3 in var_1)
  var_0 maps\mp\gametypes\_class::_id_95EE(var_3);
}

_id_636A(var_0) {
  for(;;) {
    var_0 waittill("luinotifyserver", var_1);

    if(var_1 != "hub_firing_range_selected") {
      continue;
    }
    if(isDefined(var_0._id_5721)) {
      waitframe();
      var_0 setclientdvar("3078", "1.0");
      var_0 maps\mp\hub_vl_camera::_id_8662();

      if(!var_0._id_5721) {
        var_0 _id_04DB::_id_98C7();
        var_0 unlink();
        var_0 cameraunlink();
        continue;
      }

      var_0 _id_04DB::_id_21C0();
    }
  }
}