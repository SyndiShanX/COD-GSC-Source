/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\ammorestock.gsc
***********************************************/

init() {
  level._id_644BC8D2FAA9B475 = [];
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("military_ammo_restock", ::ammorestock_used);

  if(!isDefined(level.ammorestocklocs))
    level.ammorestocklocs = [];

  ammorestocklocs = getEntArray("ammo_restock_location", "targetname");
  level._id_CCDB05CFCF9A6CA2 = undefined;

  foreach(loc in ammorestocklocs) {
    if(isDefined(loc.target)) {
      foreach(ent in getEntArray(loc.target, "targetname")) {
        if(ent.classname == "script_brushmodel") {
          _id_D805A86A5FE7AAF2 = getEntArray("tactical_cover_col", "targetname");
          origin = _id_D805A86A5FE7AAF2[0].origin;
          angles = _id_D805A86A5FE7AAF2[0].angles;
          model = spawn("script_model", origin);
          model.angles = angles;
          model clonebrushmodeltoscriptmodel(ent);
          level._id_CCDB05CFCF9A6CA2 = model;
          break;
        }
      }
    }

    if(isDefined(level._id_CCDB05CFCF9A6CA2)) {
      break;
    }
  }

  foreach(loc in ammorestocklocs) {
    _id_C3E7E5CA1B13E5E7 = isDefined(scripts\cp_mp\utility\game_utility::getlocaleid()) && isDefined(loc.script_noteworthy) && loc.script_noteworthy != level.localeid;
    _id_7B5B7F461E35DE92 = _id_A5980D3E4E2511A2(loc);
    _id_D0B46EA391E3A82A = isDefined(loc.script_gameobjectname) && loc.script_gameobjectname == "br";
    _id_DAA757858BB6C771 = scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() || _id_7923460CE1EE31C5(loc);

    if(!istrue(level.useammorestocklocs) || _id_C3E7E5CA1B13E5E7 && !_id_6C420D3454DAE534(loc) || _id_7B5B7F461E35DE92 || _id_D0B46EA391E3A82A && !_id_DAA757858BB6C771) {
      _id_D01D67695C07223A(loc);
      continue;
    }

    if(_id_5DEF7AF2A9F04234::_id_47D356083884F913() && !_id_5DEF7AF2A9F04234::_id_9C93E67F90980177(loc.origin)) {
      _id_D01D67695C07223A(loc);
      continue;
    }

    if(isDefined(loc._id_9E40BFB0CE8B77F6) && _id_D0B46EA391E3A82A) {
      _id_9F2FEDDFE7ED94D3 = scripts\cp_mp\utility\game_utility::_id_6C1FCE6F6B8779D5();
      _id_67F14F8315CB0F2F = strtok(loc._id_9E40BFB0CE8B77F6, " ");

      if(_id_67F14F8315CB0F2F.size > 0 && scripts\engine\utility::array_contains(_id_67F14F8315CB0F2F, _id_9F2FEDDFE7ED94D3)) {
        _id_D01D67695C07223A(loc);
        continue;
      }
    }

    _id_DB4C236B8AE8D47F(loc);
  }

  if(isDefined(level.localeid) && level.localeid == "locale_6")
    ammorestock_customlocale6cleanup();

  _id_6D661C09A2EE037B = scripts\engine\utility::ter_op(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508(), "dvar_9946861F4644413F", "dvar_C95A149E3FB09E8C");
  _id_2E6129BC01D788FE = getDvar(_id_6D661C09A2EE037B, "ON");

  foreach(_id_D24A7EA5713CC597 in level.ammorestocklocs) {
    if(!isDefined(_id_D24A7EA5713CC597.target)) {
      continue;
    }
    foreach(_id_7242647EFDEBE760 in getEntArray(_id_D24A7EA5713CC597.target, "targetname")) {
      if(!_id_7242647EFDEBE760 isscriptable()) {
        continue;
      }
      if(_id_2E6129BC01D788FE == "ON")
        _id_7242647EFDEBE760 setscriptablepartstate("military_ammo_restock", "useable_on");
      else if(_id_2E6129BC01D788FE == "OFF")
        _id_7242647EFDEBE760 setscriptablepartstate("military_ammo_restock", "useable_on_no_icon");

      break;
    }
  }
}

_id_D01D67695C07223A(loc) {
  if(isDefined(loc.target)) {
    _id_FD5EF62C4BDE358E = getEntArray(loc.target, "targetname");

    if(_id_FD5EF62C4BDE358E.size > 0) {
      foreach(ent in _id_FD5EF62C4BDE358E)
      ent delete();
    }

    _id_FD5EF62C4BDE358E = getentitylessscriptablearray(loc.target, "targetname");

    if(_id_FD5EF62C4BDE358E.size > 0) {
      foreach(scriptable in _id_FD5EF62C4BDE358E)
      scriptable setscriptablepartstate("military_ammo_restock", "hidden");
    }
  }

  loc delete();
}

_id_2AC210AF318CF38B(struct) {
  _id_5D581375A67558B9(struct);
  _id_8813391B99C36304(struct);
  return struct;
}

_id_DB4C236B8AE8D47F(loc) {
  if(!isDefined(level.ammorestocklocs))
    level.ammorestocklocs = [];

  if(_id_9B45D31903431D9B(loc)) {
    return;
  }
  _id_54F6E59D9CC6D3E2(loc);
  loc.timeplayerused = [];
  level.ammorestocklocs[level.ammorestocklocs.size] = loc;
}

_id_6C420D3454DAE534(loc) {
  switch (level.mapname) {
    case "mp_historic_gw2":
    case "mp_nogales_gw2":
      return 1;
    case "mp_fishtown_gw":
      if(loc.script_noteworthy == "locale_28" || loc.script_noteworthy == "locale_34")
        return 1;

      break;
    case "mp_sira_gw":
      if(loc.script_noteworthy == "locale_50" || loc.script_noteworthy == "locale_51")
        return 1;

      break;
    case "mp_wartorn_gw":
      if(loc.script_noteworthy == "locale_26" || loc.script_noteworthy == "locale_27")
        return 1;

      break;
    case "mp_regional_gw":
      if(loc.script_noteworthy == "locale_22" || loc.script_noteworthy == "locale_88")
        return 1;

      break;
    case "mp_observe_gw":
      if(loc.script_noteworthy == "locale_24" || loc.script_noteworthy == "locale_25")
        return 1;

      break;
  }

  return 0;
}

_id_7923460CE1EE31C5(loc) {
  switch (level.mapname) {
    case "mp_sira_gw":
      if(distance2dsquared(loc.origin, (-34993, -21635.7, 308)) < 65536)
        return 1;

      break;
    case "mp_fishtown_gw":
      if(distance2dsquared(loc.origin, (2248.88, -38875.6, 216)) < 65536)
        return 1;

      break;
    case "mp_nogales_gw2":
      if(distance2dsquared(loc.origin, (22721.7, 23480.7, 1668.93)) < 65536)
        return 1;

      break;
  }

  return 0;
}

_id_54F6E59D9CC6D3E2(loc) {
  switch (level.mapname) {
    case "mp_fishtown_gw":
      break;
    case "mp_nogales_gw2":
      if(distance2dsquared(loc.origin, (26214, 33992, 1650)) < 65536) {
        origin = (26215, 33993.5, 1624);
        angles = loc.angles + (0, 180, 0);
        model = spawn("script_model", origin);
        model.angles = angles;
        model setModel("military_ammo_restock_location");
      }

      if(distance2dsquared(loc.origin, (25609.8, 31617.3, 1669.66)) < 65536) {
        origin = (25642, 31626, 1625);
        angles = loc.angles + (0, 180, 0);
        model = spawn("script_model", origin);
        model.angles = angles;
        model setModel("military_ammo_restock_location");
      }

      if(distance2dsquared(loc.origin, (27155.5, 27512.2, 1777.76)) < 65536) {
        if(isDefined(level._id_CCDB05CFCF9A6CA2)) {
          origin = (27186.1, 27524.5, 1760);
          angles = loc.angles + (0, 315, 0);
          model = spawn("script_model", origin);
          model.angles = angles;
          model clonebrushmodeltoscriptmodel(level._id_CCDB05CFCF9A6CA2);
        }
      }

      if(distance2dsquared(loc.origin, (28623.1, 31207.5, 1681.75)) < 65536)
        _id_5D581375A67558B9(loc);

      break;
    case "mp_wartorn_gw":
      if(distance2dsquared(loc.origin, (-7699.69, 50690.9, 284.391)) < 65536)
        _id_5D581375A67558B9(loc);

      if(distance2dsquared(loc.origin, (-5924.76, 44588.8, 284.861)) < 65536)
        _id_8813391B99C36304(loc);

      if(distance2dsquared(loc.origin, (-7280.71, 48236.9, 443.596)) < 65536) {
        model = _id_5D581375A67558B9(loc);
        col = _id_8813391B99C36304(loc);
      }

      if(distance2dsquared(loc.origin, (-9064.73, 41041, 300.758)) < 65536) {
        model = _id_5D581375A67558B9(loc);
        col = _id_8813391B99C36304(loc);
      }

      if(distance2dsquared(loc.origin, (-10185.3, 35049.8, 547.523)) < 65536) {
        model = _id_5D581375A67558B9(loc);
        col = _id_8813391B99C36304(loc);
      }

      if(distance2dsquared(loc.origin, (-7660.12, 35053.6, 332.271)) < 65536) {
        model = _id_5D581375A67558B9(loc);
        model.origin = model.origin + anglestoright(model.angles) * 64;
      }

      break;
  }
}

_id_5D581375A67558B9(loc) {
  origin = loc.origin + (-9.04004, -31.8008, -44);
  angles = loc.angles + (0, 180, 0);
  model = spawn("script_model", origin);
  model.angles = angles;
  model setModel("military_ammo_restock_location");
  return model;
}

_id_8813391B99C36304(loc) {
  if(!isDefined(level._id_CCDB05CFCF9A6CA2)) {
    return;
  }
  origin = loc.origin + (-9.04004, -31.8008, -19.861);
  angles = loc.angles + (0, 90.901, 0);
  col = spawn("script_model", origin);
  col.angles = angles;
  col clonebrushmodeltoscriptmodel(level._id_CCDB05CFCF9A6CA2);
  return col;
}

_id_A5980D3E4E2511A2(loc) {
  foreach(_id_D24A7EA5713CC597 in level.ammorestocklocs) {
    if(distance2dsquared(loc.origin, _id_D24A7EA5713CC597.origin) < 65536)
      return 1;
  }

  return 0;
}

_id_9B45D31903431D9B(loc) {
  switch (level.mapname) {
    case "mp_historic_gw2":
      if(distance2dsquared(loc.origin, (27585, -29335, 3209)) < 65536 || distance2dsquared(loc.origin, (32187.5, -34962.8, 3139.13)) < 65536 || distance2dsquared(loc.origin, (22908.5, -31250.1, 3192)) < 65536) {
        _id_D01D67695C07223A(loc);
        return 1;
      }

      break;
    case "mp_nogales_gw2":
      if(distance2dsquared(loc.origin, (34922, 16940, 1550)) < 65536 || distance2dsquared(loc.origin, (29681, 33095.8, 1674)) < 65536 || distance2dsquared(loc.origin, (30032.3, 29652.4, 1669.66)) < 65536 || distance2dsquared(loc.origin, (28574.3, 28187.4, 1674)) < 65536 || distance2dsquared(loc.origin, (31164.6, 32598.1, 1666)) < 65536 || distance2dsquared(loc.origin, (24806.9, 29899.7, 1680)) < 65536 || distance2dsquared(loc.origin, (25007.2, 26987.8, 1293)) < 65536 || distance2dsquared(loc.origin, (27094.5, 29440, 1674)) < 65536 || distance2dsquared(loc.origin, (26380.5, 25555.4, 1677.27)) < 65536 || distance2dsquared(loc.origin, (28506.1, 22508.5, 1914.25)) < 65536 || distance2dsquared(loc.origin, (30202.3, 23396.5, 1332.92)) < 65536 || distance2dsquared(loc.origin, (21877, 27019, 1668)) < 65536 || distance2dsquared(loc.origin, (29313.7, 25313, 1258.43)) < 65536) {
        _id_D01D67695C07223A(loc);
        return 1;
      }

      break;
    case "mp_regional_gw":
    case "mp_wartorn_gw":
      if(distance2dsquared(loc.origin, (-24068.8, -5005.74, 2080)) < 65536 || distance2dsquared(loc.origin, (-6611.97, 50858, 288.512)) < 65536 || distance2dsquared(loc.origin, (-7647.53, 49632.1, 329.7)) < 65536 || distance2dsquared(loc.origin, (-10818.5, 47390.5, 274.765)) < 65536 || distance2dsquared(loc.origin, (-9077.3, 47987.4, 360.799)) < 65536 || distance2dsquared(loc.origin, (-8043.09, 46428.5, 403.384)) < 65536 || distance2dsquared(loc.origin, (-8052.51, 44386.2, 306.807)) < 65536 || distance2dsquared(loc.origin, (-9094.11, 44151.5, 297.895)) < 65536 || distance2dsquared(loc.origin, (-8235.79, 43038.2, 306.207)) < 65536 || distance2dsquared(loc.origin, (-6724.8, 42424.4, 259.02)) < 65536 || distance2dsquared(loc.origin, (-7015.17, 40804.3, 218.733)) < 65536 || distance2dsquared(loc.origin, (-10678.2, 42638.1, 271.852)) < 65536 || distance2dsquared(loc.origin, (-9775.65, 40978.9, 132.481)) < 65536 || distance2dsquared(loc.origin, (-8632.71, 39498, 263.335)) < 65536 || distance2dsquared(loc.origin, (-8842.61, 41604.6, 305.341)) < 65536 || distance2dsquared(loc.origin, (-10148.6, 39588, 294.909)) < 65536 || distance2dsquared(loc.origin, (-7032.02, 36217.1, 552.224)) < 65536 || distance2dsquared(loc.origin, (-7850.63, 37874.3, 422.542)) < 65536 || distance2dsquared(loc.origin, (-7595.55, 34161, 310.81)) < 65536 || distance2dsquared(loc.origin, (-23719.8, -3455.37, 2102.24)) < 65536) {
        _id_D01D67695C07223A(loc);
        return 1;
      }
    case "mp_fishtown_gw":
      if(distance2dsquared(loc.origin, (6003.04, -38388.4, 256.987)) < 65536 || distance2dsquared(loc.origin, (4172.42, -36837.8, 333.041)) < 65536 || distance2dsquared(loc.origin, (1273.09, -41459.6, 257)) < 65536 || distance2dsquared(loc.origin, (1311.22, -39883.5, 252.392)) < 65536 || distance2dsquared(loc.origin, (644.51, -41408, 257)) < 65536 || distance2dsquared(loc.origin, (1594.75, -37749.8, 252)) < 65536 || distance2dsquared(loc.origin, (3059.22, -38664.9, 257.905)) < 65536 || distance2dsquared(loc.origin, (-2121.11, -42953.5, 257.5)) < 65536 || distance2dsquared(loc.origin, (-2971.54, -42092.5, 244)) < 65536 || distance2dsquared(loc.origin, (-4386.93, -43629.1, 242.893)) < 65536 || distance2dsquared(loc.origin, (-2508.26, -40082.4, 428.444)) < 65536 || distance2dsquared(loc.origin, (-4990.83, -45574.4, 247.751)) < 65536 || distance2dsquared(loc.origin, (3173.23, -41330.2, 300)) < 65536) {
        _id_D01D67695C07223A(loc);
        return 1;
      }
    case "mp_sira_gw":
      if(distance2dsquared(loc.origin, (-22231.6, -21681.7, 612)) < 65536 || distance2dsquared(loc.origin, (42365, -4481, 786)) < 65536 || distance2dsquared(loc.origin, (-36878, -23688, 264)) < 65536 || distance2dsquared(loc.origin, (-36012, -22546, 260)) < 65536 || distance2dsquared(loc.origin, (-35208, -24096, 264)) < 65536 || distance2dsquared(loc.origin, (-34808, -22240, 264)) < 65536 || distance2dsquared(loc.origin, (-31860, -22846, 264)) < 65536 || distance2dsquared(loc.origin, (-32038, -20154, 272)) < 65536 || distance2dsquared(loc.origin, (-33783, -23470, 264)) < 65536 || distance2dsquared(loc.origin, (-33930, -21932, 264)) < 65536) {
        _id_D01D67695C07223A(loc);
        return 1;
      }

      break;
  }

  return 0;
}

ammorestock_used(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    result = _id_42F888E2E819CC64(player, instance);

    if(result == 1) {
      if(scripts\mp\flags::gameflag("prematch_done") && (getDvar("dvar_7611A2790A0BF7FE", "") != "plunder" && getDvar("dvar_7611A2790A0BF7FE", "") != "risk" && getDvar("dvar_7611A2790A0BF7FE", "") != "rumble_mgl")) {
        thread ammorestock_disableusefortime(instance, player, 0.1);
        thread _id_9F58210B67259AC8(player, instance, getdvarint("ammorestockcooldown", 60));
      } else
        thread ammorestock_disableusefortime(instance, player, 5);
    } else if(result == 0)
      thread ammorestock_disableusefortime(instance, player, 0.1);
    else
      thread ammorestock_disableusefortime(instance, player, 0.1);
  } else {
    result = ammorestock_playeruse(player, instance);

    if(result == 1) {
      thread ammorestock_disableusefortime(instance, player, 0.1);
      thread _id_9F58210B67259AC8(player, instance, getdvarint("ammorestockcooldown", 60));
    } else if(result == 0)
      thread ammorestock_disableusefortime(instance, player, 0.1);
    else
      thread ammorestock_disableusefortime(instance, player, 0.1);
  }
}

_id_AFAB07CF819C5ED4(guid) {
  level._id_644BC8D2FAA9B475[guid] = undefined;
}

_id_9039BC1E302709D0(guid, instance) {
  level._id_644BC8D2FAA9B475[guid][instance.index] = undefined;
}

_id_9F58210B67259AC8(player, instance, time) {
  guid = player scripts\mp\utility\player::getuniqueid();
  level._id_644BC8D2FAA9B475[guid][instance.index] = 1;
  player scripts\engine\utility::waittill_notify_or_timeout("death", time);

  if(!isDefined(player) || !scripts\mp\utility\player::isreallyalive(player))
    _id_AFAB07CF819C5ED4(guid);
  else
    _id_9039BC1E302709D0(guid, instance);
}

ammorestock_disableusefortime(scriptable, player, time) {
  player endon("disconnect");
  scriptable disablescriptableplayeruse(player);
  wait(time);
  scriptable enablescriptableplayeruse(player);
}

ammorestock_playeruse(player, instance) {
  player endon("death_or_disconnect");
  guid = player scripts\mp\utility\player::getuniqueid();

  if(!isDefined(level._id_644BC8D2FAA9B475[guid]))
    level._id_644BC8D2FAA9B475[guid] = [];

  if(isDefined(level._id_644BC8D2FAA9B475[guid][instance.index])) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_ON_COOLDOWN");
    player playlocalsound("br_pickup_deny");
    return 2;
  }

  _id_12A372E8CAA042BB = player.primaryweapons;
  _id_50F783A5617F8940 = [];

  foreach(item in _id_12A372E8CAA042BB) {
    if(!scripts\mp\utility\weapon::ismeleeonly(item) && !scripts\mp\utility\weapon::issuperweapon(item) && !_id_2669878CF5A1B6BC::iskillstreakweapon(item) && !scripts\mp\utility\weapon::isgamemodeweapon(item))
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = item;
  }

  _id_12A372E8CAA042BB = _id_50F783A5617F8940;
  _id_DF04395B59031A4D = 0;

  foreach(weaponobj in _id_12A372E8CAA042BB) {
    if(weaponmaxammo(weaponobj) <= player getweaponammostock(weaponobj))
      _id_DF04395B59031A4D++;
  }

  _id_2A0D5DA772612A32 = 0;

  foreach(_id_220AE48084C1BFFC in player.equipment) {
    _id_8BF83D28BE4C2D4F = player scripts\mp\equipment::getequipmenttableinfo(_id_220AE48084C1BFFC);

    if(isDefined(_id_8BF83D28BE4C2D4F)) {
      _id_08C1092AA0A87661 = player scripts\mp\equipment::getequipmentmaxammo(_id_220AE48084C1BFFC);
      _id_B64209459DA65860 = player scripts\mp\equipment::getequipmentammo(_id_220AE48084C1BFFC);

      if(_id_08C1092AA0A87661 == _id_B64209459DA65860)
        _id_2A0D5DA772612A32++;
    }
  }

  if(_id_DF04395B59031A4D == _id_12A372E8CAA042BB.size && _id_2A0D5DA772612A32 == player.equipment.size) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    player playlocalsound("br_pickup_deny");
    return 0;
  } else {
    foreach(weaponobj in _id_12A372E8CAA042BB) {
      _id_CF4209C200F8BBF4 = scripts\mp\utility\weapon::getweapongroup(weaponobj);
      _id_662B420C8B2FCB2D = undefined;

      if(scripts\mp\utility\weapon::issinglehitweapon(weaponobj))
        _id_662B420C8B2FCB2D = 1;
      else if(_id_CF4209C200F8BBF4 == "weapon_sniper")
        _id_662B420C8B2FCB2D = 3;
      else
        _id_662B420C8B2FCB2D = 3;

      if(istrue(weaponobj.hasalternate)) {
        _id_6890A4CE965BBA99 = weaponobj getaltweapon();
        _id_91093EF03654702C = weaponclass(_id_6890A4CE965BBA99);

        if(_id_91093EF03654702C == "grenade") {
          _id_26F669E2F4686446 = scripts\mp\weapons::getammooverride(_id_6890A4CE965BBA99);
          stockammo = player getweaponammostock(_id_6890A4CE965BBA99);
          _id_2AA9CAEF99C9AF77 = int(stockammo + _id_26F669E2F4686446);
          player setweaponammostock(_id_6890A4CE965BBA99, _id_2AA9CAEF99C9AF77);
        } else if(_id_6890A4CE965BBA99.type == "bullet") {
          if(_id_91093EF03654702C == "spread") {
            _id_26F669E2F4686446 = scripts\mp\weapons::getammooverride(_id_6890A4CE965BBA99);
            stockammo = player getweaponammostock(_id_6890A4CE965BBA99);
            _id_2AA9CAEF99C9AF77 = int(stockammo + _id_26F669E2F4686446);
            player setweaponammostock(_id_6890A4CE965BBA99, _id_2AA9CAEF99C9AF77);
          }
        } else {
          _id_26F669E2F4686446 = scripts\mp\weapons::getammooverride(_id_6890A4CE965BBA99);
          stockammo = player getweaponammostock(_id_6890A4CE965BBA99);
          _id_2AA9CAEF99C9AF77 = int(stockammo + _id_26F669E2F4686446);
          player setweaponammostock(_id_6890A4CE965BBA99, _id_2AA9CAEF99C9AF77);
        }
      }

      _id_26F669E2F4686446 = scripts\mp\weapons::getammooverride(weaponobj) * _id_662B420C8B2FCB2D;
      stockammo = player getweaponammostock(weaponobj);
      _id_2AA9CAEF99C9AF77 = int(stockammo + _id_26F669E2F4686446);
      _id_F05AA030D9FAF1B9 = scripts\mp\weapons::getammooverride(weaponobj);
      clipammo = player getweaponammoclip(weaponobj);

      if(weaponobj.basename == "iw8_lm_dblmg_mp") {
        player setweaponammoclip(weaponobj, clipammo + _id_F05AA030D9FAF1B9);
        continue;
      }

      player setweaponammostock(weaponobj, _id_2AA9CAEF99C9AF77);
    }
  }

  primary = player scripts\mp\equipment::getcurrentequipment("primary");

  if(isDefined(primary))
    player scripts\mp\equipment::incrementequipmentammo(primary);

  _id_D7B9856A19F9B6B5 = player scripts\mp\equipment::getcurrentequipment("secondary");

  if(isDefined(_id_D7B9856A19F9B6B5))
    player scripts\mp\equipment::incrementequipmentammo(_id_D7B9856A19F9B6B5);

  player _id_5762AC2F22202BA2::hudicontype("br_ammo");
  player playlocalsound("iw9_support_box_use");
  return 1;
}

_id_42F888E2E819CC64(player, instance) {
  player endon("death_or_disconnect");
  guid = player scripts\mp\utility\player::getuniqueid();

  if(!isDefined(level._id_644BC8D2FAA9B475[guid]))
    level._id_644BC8D2FAA9B475[guid] = [];

  if(isDefined(level._id_644BC8D2FAA9B475[guid][instance.index])) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_ON_COOLDOWN");
    player playlocalsound("br_pickup_deny");
    return 2;
  }

  _id_BF00BD1D7DA56C26 = 0;
  _id_509D86412C9D7426 = player getweaponslistprimaries();
  _id_12A372E8CAA042BB = [];

  foreach(item in _id_509D86412C9D7426) {
    if(!scripts\mp\utility\weapon::ismeleeonly(item) && !scripts\mp\utility\weapon::issuperweapon(item) && !_id_2669878CF5A1B6BC::iskillstreakweapon(item) && !scripts\mp\utility\weapon::isgamemodeweapon(item))
      _id_12A372E8CAA042BB = scripts\engine\utility::array_add(_id_12A372E8CAA042BB, item);
  }

  if(player scripts\mp\utility\killstreak::isjuggernaut()) {
    if(!isDefined(_id_509D86412C9D7426) || _id_509D86412C9D7426.size == 0) {
      minigun = player getcurrentweapon();
      _id_D0BAE9FA43B9E424 = player getcurrentweaponclipammo();
      _id_E21A1FE75EA20307 = weaponclipsize(minigun);

      if(_id_D0BAE9FA43B9E424 < _id_E21A1FE75EA20307) {
        player setweaponammoclip(minigun, _id_E21A1FE75EA20307);
        player _id_5762AC2F22202BA2::hudicontype("br_ammo");
        player playlocalsound("iw9_support_box_use");
        return 1;
      }
    }
  }

  _id_FAD892A207D23D14 = 1;

  foreach(weaponobj in _id_12A372E8CAA042BB) {
    _id_B928C399C807AC2E = _id_724736FCF0FB6604::br_ammo_type_for_weapon(weaponobj);

    if(isDefined(_id_B928C399C807AC2E)) {
      if(level._id_E6EA72FC5E3FCD00[_id_B928C399C807AC2E] > player getweaponammostock(weaponobj)) {
        _id_FAD892A207D23D14 = 0;
        break;
      }
    }
  }

  _id_BB7A7034F796AF47 = player scripts\mp\equipment::getcurrentequipment("primary");
  _id_79A42E6A2F51CF87 = player scripts\mp\equipment::getcurrentequipment("secondary");
  _id_C7A61B8CF2433E2A = scripts\engine\utility::array_removeundefined([_id_BB7A7034F796AF47, _id_79A42E6A2F51CF87]);
  _id_5F947642C6E09E85 = 1;

  foreach(equipment in _id_C7A61B8CF2433E2A) {
    _id_6088850C9E835589 = player scripts\mp\equipment::getequipmentammo(equipment);
    _id_93622E40B0AE3BDD = player scripts\mp\equipment::getequipmentmaxammo(equipment);

    if(_id_6088850C9E835589 < _id_93622E40B0AE3BDD) {
      _id_5F947642C6E09E85 = 0;
      break;
    }
  }

  if(istrue(_id_FAD892A207D23D14) && istrue(_id_5F947642C6E09E85)) {
    player scripts\mp\hud_message::showerrormessage("MP_INGAME_ONLY/AMMO_RESTOCK_STOCK_FULL");
    player playlocalsound("br_pickup_deny");
    return 0;
  } else {
    _id_0A0115A87500B34B = [];

    foreach(_id_DE88CD14114C1E24 in _id_12A372E8CAA042BB) {
      _id_B928C399C807AC2E = _id_724736FCF0FB6604::br_ammo_type_for_weapon(_id_DE88CD14114C1E24);
      _id_DD2DECF8DB7E69B8 = player getweaponammostock(_id_DE88CD14114C1E24);

      if(isDefined(_id_B928C399C807AC2E)) {
        if(level._id_E6EA72FC5E3FCD00[_id_B928C399C807AC2E] <= _id_DD2DECF8DB7E69B8)
          continue;
      }

      if(_id_DE88CD14114C1E24.isalternate && _id_2669878CF5A1B6BC::_id_DE04E13AB01E1A10(_id_DE88CD14114C1E24.underbarrel)) {
        clipammo = weaponclipsize(_id_DE88CD14114C1E24);
        _id_2AA9CAEF99C9AF77 = int(clipammo);
        player setweaponammoclip(_id_DE88CD14114C1E24, _id_2AA9CAEF99C9AF77);
        continue;
      } else if(_id_2669878CF5A1B6BC::isminigunweapon(_id_DE88CD14114C1E24)) {
        player setweaponammoclip(_id_DE88CD14114C1E24, _id_DE88CD14114C1E24.clipsize);
        continue;
      } else if(!isDefined(_id_B928C399C807AC2E)) {
        continue;
      }
      if(!isDefined(_id_0A0115A87500B34B[_id_B928C399C807AC2E])) {
        _id_310549FED85359EC = int(min(level._id_E6EA72FC5E3FCD00[_id_B928C399C807AC2E] - _id_DD2DECF8DB7E69B8, weaponclipsize(_id_DE88CD14114C1E24) * 2));
        _id_60227BFF1E9478CC = spawnStruct();
        _id_60227BFF1E9478CC.count = _id_310549FED85359EC;
        _id_60227BFF1E9478CC.scriptablename = _id_B928C399C807AC2E;
        _id_60227BFF1E9478CC.stackable = _id_60227BFF1E9478CC.count;
        _id_0A0115A87500B34B[_id_60227BFF1E9478CC.scriptablename] = _id_60227BFF1E9478CC;
      }

      player _id_724736FCF0FB6604::br_give_weapon_clip(_id_DE88CD14114C1E24, 2);
    }

    foreach(equipment in _id_C7A61B8CF2433E2A) {
      _id_93622E40B0AE3BDD = player scripts\mp\equipment::getequipmentmaxammo(equipment);

      if(isDefined(level.br_pickups.br_equipnametoscriptable[equipment]) && !isDefined(_id_0A0115A87500B34B[level.br_pickups.br_equipnametoscriptable[equipment]])) {
        _id_B971E09CE070BD58 = player scripts\mp\equipment::getequipmentammo(equipment);
        _id_310549FED85359EC = _id_93622E40B0AE3BDD - _id_B971E09CE070BD58;
        _id_60227BFF1E9478CC = spawnStruct();
        _id_60227BFF1E9478CC.count = _id_310549FED85359EC;
        _id_60227BFF1E9478CC.scriptablename = level.br_pickups.br_equipnametoscriptable[equipment];
        _id_60227BFF1E9478CC.stackable = _id_60227BFF1E9478CC.count;
        _id_0A0115A87500B34B[_id_60227BFF1E9478CC.scriptablename] = _id_60227BFF1E9478CC;
      }

      player scripts\mp\equipment::incrementequipmentammo(equipment, _id_93622E40B0AE3BDD);
    }

    player _id_5762AC2F22202BA2::hudicontype("br_ammo");
    level thread _id_7AC7AC25B4003BEC(player, _id_0A0115A87500B34B);
    player playlocalsound("iw9_support_box_use");
    return 1;
  }
}

_id_7AC7AC25B4003BEC(player, _id_0A0115A87500B34B) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  count = 0;

  foreach(item in _id_0A0115A87500B34B) {
    count++;
    waittime = 0.1;

    if(count % 3 == 0)
      waittime = 1.5;

    if(!isDefined(item.count) || item.count <= 0) {
      continue;
    }
    if(!isDefined(item.scriptablename)) {
      continue;
    }
    player _id_7E52B56769FA7774::_id_54CBF68F2E4A6D31(item);
    wait(waittime);
  }
}

ammorestock_customlocale6cleanup() {
  _id_79D6F370510C1F94 = [];
  _id_79D6F370510C1F94[0] = (15946, -71, -469);
  _id_79D6F370510C1F94[1] = (16829, -8996, -333);
  _id_79D6F370510C1F94[2] = (16531, -13847, -154);
  _id_79D6F370510C1F94[3] = (24472, -14782, -134);
  _id_79D6F370510C1F94[4] = (22373, -19948, -36);
  _id_79D6F370510C1F94[5] = (18250, -2057, -439);
  _id_79D6F370510C1F94[6] = (17549, -4262, -432);
  _id_79D6F370510C1F94[7] = (19147, -11546, -257);
  _id_79D6F370510C1F94[8] = (19845, -21990, -98);
  _id_79D6F370510C1F94[9] = (19838, -18100, -23);
  _id_79D6F370510C1F94[10] = (21978, -11276, -58);

  foreach(loc in level.ammorestocklocs) {
    _id_E24C6C7277A83762 = 0;

    foreach(_id_41BACC270E368C94 in _id_79D6F370510C1F94) {
      if(_id_E24C6C7277A83762) {
        break;
      }

      if(distance2dsquared(loc.origin, _id_41BACC270E368C94) < 10000)
        _id_E24C6C7277A83762 = 1;
    }

    if(_id_E24C6C7277A83762) {
      _id_FD5EF62C4BDE358E = getEntArray(loc.target, "targetname");

      foreach(ent in _id_FD5EF62C4BDE358E) {
        if(ent.classname == "script_model") {
          ent delete();
          continue;
        }

        ent delete();
      }

      loc delete();
    }
  }
}

_id_B122437A5AC7F9F9(origin, radius) {
  array = getentarrayinradius(undefined, undefined, origin, radius);
  _id_409925A6818F41F2 = 0;

  foreach(ent in array) {
    if(ent.classname == "script_model" && ent.model == "military_ammo_restock_location") {
      _id_409925A6818F41F2 = 1;
      break;
    }
  }

  if(_id_409925A6818F41F2)
    scripts\engine\utility::array_delete(array);
}