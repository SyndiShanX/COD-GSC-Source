/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\vehicles\vehicle_occupancy_mp.gsc
************************************************/

vehicle_occupancy_mp_init() {
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AC0B0F6F0BE08018A55A0779C481E8C95A", ::vehicle_occupancy_mp_onentervehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_BA110E075B45433181E1982091C8AB68", ::vehicle_occupancy_mp_onexitvehicle);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8E601133A887B3E6DB82B3EC422333A395EB9D", ::vehicle_occupancy_mp_registerinstance);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_872013FF550DBA97D860D39F80344603A9FFC5B6CD", ::vehicle_occupancy_mp_deregisterinstance);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_96B70CAE838CC2E82BD3BB3759E4", ::vehicle_occupancy_mp_updateowner);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_A12B11F0F70770BF13177E966FCAC9386D4348", ::vehicle_occupancy_mp_registersentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_ACBC13F54833EFAFA3F0230AC0EF678BABA36D96DD", ::vehicle_occupancy_mp_unregistersentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B6A90B5A6EA9CA7347B495B91D", ::vehicle_occupancy_mp_issentient);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8A400F0967525579992D736F147108197A", ::_id_141F0);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B4D20FB396CEB229D2EDA39A43A5ACB123", ::_id_141ED);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8FE511D38BB50F93B83DC9C75921DC776D60BA", ::_id_141F2);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B2BD0CE83AB77BDD3FB3F3EEB97F", ::_id_141EE);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8ACA0C0BA97BA38F37E312B8891C", ::_id_141EF);
  scripts\cp_mp\utility\script_utility::registersharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_816C0D1E9857658C751BD168B10B1F", ::_id_141EC);
  scripts\mp\playeractions::registeractionset("_encstr_9A50080BA7292FFA0DA2", ["_encstr_8F0508CE59DCA357392B", "_encstr_85190CAB8B3971B0A4DB2BCAC253", "_encstr_BEF4071AA87BDF5220", "_encstr_A1760D221BB8AF4350FB44519F388A"]);
  scripts\mp\playeractions::registeractionset("_encstr_954512A0420CCB71934D800F21873BABF50AA008", ["_encstr_8F0508CE59DCA357392B", "_encstr_BEF4071AA87BDF5220", "_encstr_A1760D221BB8AF4350FB44519F388A"]);
  level.vehicle._id_1424E = getdvarint("_encstr_AD23136E8D4EFAECB2A12DC63656F5C65A9D0D47B9", 1);
}

vehicle_occupancy_mp_onentervehicle(var_0, var_1, var_2, var_3) {
  var_2 scripts\mp\utility\perk::giveperk("_encstr_990810B8796F28FB0B6193B21770B42573B3");
  var_2 scripts\mp\utility\perk::giveperk("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");
  var_4 = level.gametype == "_encstr_B607038AAB";

  if(!var_4 || scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DF(var_0, var_1))
    var_2 scripts\mp\playeractions::allowactionset("_encstr_9A50080BA7292FFA0DA2", 0);
  else if(var_4)
    var_2 scripts\mp\playeractions::allowactionset("_encstr_954512A0420CCB71934D800F21873BABF50AA008", 0);

  if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
    _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12781(var_2, 0, 1);

  _id_141F0(var_2);
  scripts\mp\outofbounds::enableoobimmunity(var_2);

  if(scripts\mp\outofbounds::isoob(var_0, 1))
    var_0 thread scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_entercallbackforplayer(var_2);

  if(isDefined(var_2.team) && isDefined(var_2.squadindex) && istrue(var_0.israllypointvehicle))
    thread scripts\mp\spawnselection::_id_12ACB(var_2.team, var_2.squadindex);

  if(isDefined(level.playerconnectwatcher) && var_2[[level.playerconnectwatcher]]()) {
    if(isDefined(level.playerexecutionsenable))
      var_2[[level.playerexecutionsenable]]();
  }

  vehicle_occupancy_mp_updatemarkfilter(var_0);
  _id_141F1(var_0);
  _id_141F3(var_0);
}

vehicle_occupancy_mp_onexitvehicle(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3.playerdisconnect) && isDefined(var_2)) {
    if(!istrue(var_3.playerdeath)) {
      var_2 scripts\mp\utility\perk::removeperk("_encstr_990810B8796F28FB0B6193B21770B42573B3");
      var_2 scripts\mp\utility\perk::removeperk("_encstr_A97E1950E1284F5BE2D1630BF78B3BDF7E0AA713C1FDC285A81598");
      var_4 = level.gametype == "_encstr_B607038AAB";

      if(!var_4 || scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DF(var_0, var_1))
        var_2 scripts\mp\playeractions::allowactionset("_encstr_9A50080BA7292FFA0DA2", 1);
      else if(var_4)
        var_2 scripts\mp\playeractions::allowactionset("_encstr_954512A0420CCB71934D800F21873BABF50AA008", 1);

      if(getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_BE180419DAE9" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_8AE1099A0B999F2D28AF15" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_9B1F05BE4B9B52" || getDvar("_encstr_910E10D753B2D116EBE9F921D26FD528CAAD", "_encstr_B40101") == "_encstr_866209ECEDB1197DEE0B4E")
        _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_12781(var_2, 1, 1);

      if(scripts\mp\outofbounds::isoob(var_0, 1))
        var_0 thread scripts\mp\vehicles\vehicle_oob_mp::vehicle_oob_mp_exitcallbackforplayer(var_2);

      scripts\mp\outofbounds::disableoobimmunity(var_2);
    }

    _id_141ED(var_2, var_3.playerdeath, var_3.playerlaststand);

    if(isDefined(var_2.team) && isDefined(var_2.squadindex) && istrue(var_0.israllypointvehicle))
      thread scripts\mp\spawnselection::_id_12ACB(var_3.team, var_3.squadindex);

    if(isDefined(level.playerconnectwatcher) && var_2[[level.playerconnectwatcher]]()) {
      if(isDefined(level.playerexitcombatarea))
        var_2[[level.playerexitcombatarea]]();
    }

    var_2 notify("_encstr_A9130DC330104912F19DE1677B831B");
  }

  vehicle_occupancy_mp_updatemarkfilter(var_0);
  _id_141F1(var_0);
  _id_141F3(var_0);
}

_id_141EC(var_0, var_1, var_2, var_3) {
  var_4 = level.gametype == "_encstr_B607038AAB";

  if(var_4 && isDefined(var_2) && isDefined(var_3)) {
    if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DF(var_1, var_2)) {
      var_0 scripts\mp\playeractions::allowactionset("_encstr_9A50080BA7292FFA0DA2", 1);
      var_0 scripts\mp\playeractions::allowactionset("_encstr_954512A0420CCB71934D800F21873BABF50AA008", 0);
    } else if(scripts\cp_mp\vehicles\vehicle_occupancy::_id_141DF(var_1, var_3)) {
      var_0 scripts\mp\playeractions::allowactionset("_encstr_954512A0420CCB71934D800F21873BABF50AA008", 1);
      var_0 scripts\mp\playeractions::allowactionset("_encstr_9A50080BA7292FFA0DA2", 0);
    }
  }
}

vehicle_occupancy_mp_updatemarkfilter(var_0) {
  if(!isDefined(var_0.occupants)) {
    return;
  }
  if(!isDefined(var_0._id_11B19))
    var_0._id_11B19 = 1;

  var_1 = var_0._id_11B19;
  var_2 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);
  var_0._id_11B19 = var_2.size > 0;

  if(var_1 && !var_0._id_11B19)
    var_0 disableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");
  else if(!var_1 && var_0._id_11B19)
    var_0 enableplayermarks("_encstr_85CE0B9770B02C73A1760F06D2");

  if(var_0._id_11B19) {
    if(level.teambased) {
      var_3 = [];

      foreach(var_5 in var_2) {
        if(!scripts\engine\utility::array_contains(var_3, var_5.team))
          var_3[var_3.size] = var_5.team;
      }

      var_0 filteroutplayermarks(var_3);
    } else
      var_0 filteroutplayermarks(var_2);
  }
}

vehicle_occupancy_mp_registerinstance(var_0) {}

vehicle_occupancy_mp_deregisterinstance(var_0) {}

_id_141EE(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(istrue(var_4._id_13345)) {
    return;
  }
  if(isDefined(level._id_11A32) && scripts\engine\utility::array_contains(level._id_11A32, var_2)) {
    if(isDefined(var_2.carriable_set_dropped)) {
      killfxontag(level._effect["_encstr_A28815D9CC87FA9839BE6C58E61A13B2C28CB2934816CE"], var_2, "_encstr_91480BA9AF130B3B7DB1B2CC47");
      var_5 = "_encstr_B8D22868E7E6655F7AAF63C39FB96086B7AAA10DA1FF81547A9B17EB78767D40AE815979C3B413EF016A";

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6())
        var_5 = "_encstr_B1C31E0B1BC69537B97B9C2FAFECF6D891AF1358E4FA4CC29D7D1CB12CCBB227";

      var_2 hidepart("_encstr_91480BA9AF130B3B7DB1B2CC47", var_5);
    }
  }
}

_id_141EF(var_0, var_1, var_2, var_3) {
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(istrue(var_4._id_13345)) {
    return;
  }
  if(isDefined(level._id_11A32) && scripts\engine\utility::array_contains(level._id_11A32, var_2)) {
    if(isDefined(var_2.carriable_set_dropped)) {
      var_5 = "_encstr_B8D22868E7E6655F7AAF63C39FB96086B7AAA10DA1FF81547A9B17EB78767D40AE815979C3B413EF016A";

      if(_encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::_encstr_934D17B986DEABD832BA6E593B7BC61913164EC26ECDCA3AE6())
        var_5 = "_encstr_B1C31E0B1BC69537B97B9C2FAFECF6D891AF1358E4FA4CC29D7D1CB12CCBB227";

      var_2 showpart("_encstr_91480BA9AF130B3B7DB1B2CC47", var_5);
      playFXOnTag(level._effect["_encstr_A28815D9CC87FA9839BE6C58E61A13B2C28CB2934816CE"], var_2, "_encstr_91480BA9AF130B3B7DB1B2CC47");
    }
  }
}

vehicle_occupancy_mp_updateowner(var_0) {
  vehicle_occupancy_mp_updatemarkfilter(var_0);
}

_id_141F0(var_0, var_1, var_2) {
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;
  var_6 = var_0 getweaponslistprimaries();

  foreach(var_8 in var_6) {
    if(nullweapon(var_8)) {
      continue;
    }
    if(scripts\mp\riotshield::isriotshield(var_8)) {
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
      _id_141F2(var_0, var_1, var_2);

    var_0 scripts\mp\class::riotshieldonweaponchange(var_5);
    var_0 notify("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
    var_0 endon("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
    var_0 childthread scripts\cp_mp\utility\inventory_utility::forcevalidweapon(var_5);
  }
}

_id_141ED(var_0, var_1, var_2) {
  if(isDefined(var_0._id_12D53)) {
    var_3 = level.gametype == "_encstr_B607038AAB";

    if(!istrue(var_1) && (var_3 || !istrue(var_2))) {
      var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_0._id_12D53);
      var_0 scripts\mp\class::_id_13C5C();

      if(istrue(var_0._id_12D4F)) {
        var_0 notify("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
        var_0 endon("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");

        if(!istrue(var_2))
          var_0 childthread scripts\cp_mp\utility\inventory_utility::_switchtoweaponimmediate(var_0._id_12D53);
      }
    }

    var_0._id_12D53 = undefined;
    var_0._id_12D4F = undefined;
    var_0 notify("_encstr_BE4915B6ED234B994B2B23F5935ABDE8AFB90D2D958D32");
  }
}

_id_141F2(var_0, var_1, var_2) {
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

_id_141F3(var_0) {
  if(!var_0 getscriptablehaspart("_encstr_B66C0A6EE82CC4A58D2DD1BC")) {
    return;
  }
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);
  var_2 = var_0 vehicle_getspeed();

  if(var_1.size > 0)
    var_0 setscriptablepartstate("_encstr_B66C0A6EE82CC4A58D2DD1BC", "_encstr_836D07C33BC8B0219D", 1);
  else if(var_1.size == 0 && var_2 > 10)
    var_0 setscriptablepartstate("_encstr_B66C0A6EE82CC4A58D2DD1BC", "_encstr_A50909BAB9371D2C26D82B", 1);
}

_id_141F1(var_0) {
  if(!level.vehicle._id_1424E) {
    return;
  }
  if(!_id_141E6()) {
    return;
  }
  if(!var_0 getscriptablehaspart("_encstr_938A07DDE8F8A8FB0E")) {
    return;
  }
  if(!isDefined(var_0.showmapchyron))
    var_0.showmapchyron = 0;

  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(var_0);

  if(var_1.size > 0 && !var_0.showmapchyron) {
    var_0 setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_AB0703DBB9", 1);
    var_0.showmapchyron = 1;
  } else if(var_1.size == 0 && var_0.showmapchyron) {
    var_0 setscriptablepartstate("_encstr_938A07DDE8F8A8FB0E", "_encstr_BA19049F4B2D", 1);
    var_0.showmapchyron = 0;
  }
}

_id_141E6() {
  switch (level.script) {
    case "_encstr_AFFF0BE590A158DFF3D1238507":
    case "_encstr_AF3410DD9746233A1FF0C2BAC0BBF5C739FE":
    case "_encstr_9B330E11FF076B6E22C70B31FB3FB7B0":
      return 1;
    default:
      break;
  }

  return 0;
}

vehicle_occupancy_mp_registersentient(var_0) {
  var_1 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(!isDefined(var_1.threatbiasgroup)) {
    return;
  }
  if(level.teambased) {
    var_2 = var_0.team;

    if(isDefined(var_0.team) && var_0.team == "_encstr_A7A408B9CA5D1D4E2C63")
      var_2 = undefined;

    if(!isDefined(var_2) && isDefined(var_0.owner))
      var_2 = var_0.owner.team;

    if(isDefined(var_2)) {
      if(!isDefined(var_0.sentientteam) || var_0.sentientteam != var_2) {
        vehicle_occupancy_mp_unregistersentient(var_0);
        var_0 scripts\mp\sentientpoolmanager::registersentient(var_1.threatbiasgroup, var_2);
        var_0.sentientteam = var_2;
      }
    } else if(isDefined(var_0.sentientteam))
      vehicle_occupancy_mp_unregistersentient(var_0);
  }
}

vehicle_occupancy_mp_unregistersentient(var_0) {
  var_0 notify("_encstr_A67B103BB1A99FBB2B8F4B2595F004FF400B");
  var_0.sentientteam = undefined;
}

vehicle_occupancy_mp_issentient(var_0) {
  return isDefined(var_0.sentientteam);
}