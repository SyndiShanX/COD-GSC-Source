/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\vehicles\vehicle_occupancy_cp.gsc
************************************************/

vehicle_occupancy_cp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AC0B0F6F0BE08018A55A0779C481E8C95A", ::vehicle_occupancy_cp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_BA110E075B45433181E1982091C8AB68", ::vehicle_occupancy_cp_onexitvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AB651A9BD10B3961E7F16098EABC3951136A90811ECF60534E6AE840", ::_id_141CE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8A400F0967525579992D736F147108197A", ::_id_141CF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B4D20FB396CEB229D2EDA39A43A5ACB123", ::_id_141CD);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8FE511D38BB50F93B83DC9C75921DC776D60BA", ::_id_141D0);
  scripts\mp\playeractions::registeractionset("_encstr_9A50080BA7292FFA0DA2", ["_encstr_8F0508CE59DCA357392B", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_A1760D221BB8AF4350FB44519F388A"]);
}

vehicle_occupancy_cp_onentervehicle(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.vehicle_specific_onentervehicle))
    [[var_0.vehicle_specific_onentervehicle]](var_0, var_1, var_2, var_3);

  var_2 scripts\mp\playeractions::allowactionset("_encstr_9A50080BA7292FFA0DA2", 0);
  scripts\cp\cp_outofbounds::enableoobimmunity(var_2);

  if(scripts\cp\cp_outofbounds::isoob(var_0, 1))
    var_0 thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_entercallbackforplayer(var_2);

  if(isDefined(var_2.x1circletime)) {
    var_2.x1circletime hide();
    var_2.x1circletime unlink();
  }

  if(istrue(var_0.bshouldoccupantsbeignored))
    var_2 scripts\cp\utility::allow_player_ignore_me(1);

  var_2.binvehicle = 1;
  var_2.dontmelee = 1;
  var_2.dontmeleeme = 1;
  var_2 notify("_encstr_B6F4108D9DFB87CA4858AFBB0960603AA3CF");
}

vehicle_occupancy_cp_onexitvehicle(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0.vehicle_specific_onexitvehicle))
    [[var_0.vehicle_specific_onexitvehicle]](var_0, var_1, var_2, var_3);

  if(!istrue(var_3.playerdisconnect)) {
    if(!istrue(var_3.playerdeath)) {
      var_2 scripts\mp\playeractions::allowactionset("_encstr_9A50080BA7292FFA0DA2", 1);

      if(scripts\cp\cp_outofbounds::isoob(var_0, 1))
        var_0 thread scripts\cp\vehicles\vehicle_oob_cp::vehicle_oob_cp_exitcallbackforplayer(var_2);

      scripts\cp\cp_outofbounds::disableoobimmunity(var_2);
    }

    var_2 notify("_encstr_A9130DC330104912F19DE1677B831B");
  }

  if(istrue(var_0.bshouldoccupantsbeignored))
    var_2 scripts\cp\utility::allow_player_ignore_me(0);

  if(isDefined(var_2.x1circletime)) {
    var_2.x1circletime linkTo(var_2, "_encstr_81941033E6A7397E4A7713397B01CE0B7BFC", (5, 10, 0), (0, 0, 90));
    var_2.x1circletime show();
  }

  var_2.shouldskiplaststand = undefined;
  var_2.binvehicle = 0;
  var_2.dontmelee = undefined;
  var_2.dontmeleeme = undefined;
  var_2 notify("_encstr_9A010FA803DC612103C7A415D81FA90987");
}

_id_141CE(var_0) {
  var_0.shouldskipdeathsshield = 1;
  var_0.shouldskiplaststand = 1;
  var_0 dodamage(var_0.health + 50, var_0.origin);
}

_id_141CF(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = var_0 getweaponslistprimaries();

  foreach(var_8 in var_6) {
    if(nullweapon(var_8)) {
      continue;
    }
    if(scripts\cp\utility::isriotshield(var_8)) {
      var_3 = var_8;

      if(isnullweapon(var_3, var_0 getcurrentprimaryweapon()))
        var_4 = 1;

      continue;
    }

    if(!isDefined(var_5)) {
      var_9 = var_8 getnoaltweapon();

      if(var_9.inventorytype != "_encstr_BA7F0830B3A7859B60B0") {
        continue;
      }
      var_5 = var_8;
    }
  }

  if(isDefined(var_3)) {
    var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_3);
    var_0._id_12D53 = var_3;
    var_0._id_12D4F = var_4;

    if(istrue(var_4))
      _id_141D0(var_0, var_1, var_2);

    var_0 scripts\cp\cp_weapon::riotshieldonweaponchange(var_5);
    var_0 notify("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
    var_0 endon("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
    var_0 childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_5);
  }
}

_id_141CD(var_0, var_1, var_2) {
  if(isDefined(var_0._id_12D53)) {
    if(!istrue(var_1) && !istrue(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0._id_12D53);
      var_0 scripts\cp\cp_weapon::_id_13C5C();

      if(istrue(var_0._id_12D4F)) {
        var_0 notify("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
        var_0 endon("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
        var_0 childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0._id_12D53);
      }
    } else if(!istrue(var_1) && istrue(var_2))
      var_0._id_12D4D = var_0._id_12D53;

    var_0._id_12D53 = undefined;
    var_0._id_12D4F = undefined;
    var_0 notify("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
  }
}

_id_141D0(var_0, var_1, var_2) {
  if(isDefined(var_0._id_12D53) && istrue(var_0._id_12D4F)) {
    if(!isDefined(var_2)) {
      return;
    }
    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DF(var_1, var_2)) {
      return;
    }
    if(scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_shouldhideoccupantforseat(var_1, var_2)) {
      return;
    }
    var_3 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_1.vehiclename, var_2);

    if(isDefined(var_3._id_13E8A)) {
      return;
    }
    var_0._id_12D4F = undefined;
  }
}