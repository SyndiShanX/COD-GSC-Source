/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle_occupancy.gsc
************************************************/

vehicle_occupancy_getleveldataforvehicle(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldata();
  var_3 = var_2.vehicledata[var_0];

  if(!isDefined(var_3)) {
    if(isDefined(var_1)) {
      var_3 = spawnStruct();
      var_2.vehicledata[var_0] = var_3;
      var_3.seatdata = [];
      var_3.enterstartcallback = undefined;
      var_3.enterendcallback = undefined;
      var_3.exitstartcallback = undefined;
      var_3.exitendcallback = undefined;
      var_3.reentercallback = undefined;
      var_3._id_11D02 = undefined;
      var_3.restrictions = [];
      var_3.damagemodifier = -1;
      var_3.hideoccupant = undefined;
      var_3.camera = "_encstr_8BBA05185F8B99";
      var_3.threatbiasgroup = "_encstr_BE230E64859CE87B09557DB81153BB97";
      var_3.exitextents = [];
      var_3.exitextents["_encstr_AA5606FD1AF05085"] = undefined;
      var_3.exitextents["_encstr_B69B0589C236B6"] = undefined;
      var_3.exitextents["_encstr_A5AD056A019C63"] = undefined;
      var_3.exitextents["_encstr_8253060E2B5FE330"] = undefined;
      var_3.exitextents["_encstr_AC190479FF92"] = undefined;
      var_3.exitextents["_encstr_A146078E65FB5158DD"] = undefined;
      var_3.exitoffsets = [];
      var_3.exitdirections = [];
      var_3.exittopcastoffset = undefined;
      var_3.damagefeedbackgrouplight = "_encstr_9AE307B956E345D0AB";
      var_3.damagefeedbackgroupheavy = "_encstr_AF1904A7F929";
    }
  }

  return var_3;
}

vehicle_occupancy_getleveldataforseat(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getleveldataforvehicle(var_0, var_2);
  var_4 = var_3.seatdata[var_1];

  if(!isDefined(var_4)) {
    if(istrue(var_2)) {
      var_4 = spawnStruct();
      var_3.seatdata[var_1] = var_4;
      var_4.vehicledata = var_3;
      var_4.seatswitcharray = [];
      var_4.exitids = [];
      var_4.spawnpriority = undefined;
      var_4.viewclamps = [];
      var_4.viewclamps["_encstr_AC190479FF92"] = undefined;
      var_4.viewclamps["_encstr_A146078E65FB5158DD"] = undefined;
      var_4.viewclamps["_encstr_A5AD056A019C63"] = undefined;
      var_4.viewclamps["_encstr_8253060E2B5FE330"] = undefined;
      var_4.hideheldweapon = undefined;
      var_4.hidestowedweapon = undefined;
      var_4._id_13345 = undefined;
      var_4._id_13E8A = undefined;
      var_4._id_13E8B = undefined;
      var_4._id_13E92 = undefined;
    }
  }

  return var_4;
}

vehicle_occupancy_registerinstance(var_0) {
  var_0.occupants = [];
  var_0.occupantsreserving = [];
  var_0.isempty = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8E601133A887B3E6DB82B3EC422333A395EB9D"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8E601133A887B3E6DB82B3EC422333A395EB9D")]](var_0);
}

vehicle_occupancy_deregisterinstance(var_0) {
  var_0.occupants = undefined;
  var_0.occupantsreserving = undefined;
  var_0.isempty = undefined;
  var_0._id_1287D = undefined;
  var_0.brking_rankupdate = undefined;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_872013FF550DBA97D860D39F80344603A9FFC5B6CD"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_872013FF550DBA97D860D39F80344603A9FFC5B6CD")]](var_0);
}

_id_141DE(var_0) {
  return isDefined(var_0.occupants);
}

vehicle_occupancy_getallvehicleseats(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_2))
    return getarraykeys(var_2.seatdata);
  else
    return [];
}

vehicle_occupancy_getavailablevehicleseats(var_0, var_1, var_2) {
  var_3 = [];
  var_4 = vehicle_occupancy_getallvehicleseats(var_0);

  foreach(var_6 in var_4) {
    if(!vehicle_occupancy_seatisavailable(var_0, var_6)) {
      continue;
    }
    var_3[var_3.size] = var_6;
  }

  if(istrue(var_1)) {
    if(var_3.size > 0) {
      var_8 = [];

      foreach(var_6 in var_3) {
        var_10 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_6);
        var_11 = var_10.spawnpriority;

        if(!isDefined(var_11))
          var_11 = 0;
        else
          var_11 = int(max(0, var_11));

        var_8[var_6] = var_11;
      }

      if(istrue(var_2)) {
        for(var_13 = 0; var_13 < var_3.size - 1; var_13++) {
          var_14 = var_13;

          for(var_15 = var_13 + 1; var_15 < var_3.size; var_15++) {
            if(var_8[var_3[var_15]] > var_8[var_3[var_14]])
              var_14 = var_15;
          }

          if(var_14 != var_13) {
            var_16 = var_3[var_13];
            var_3[var_13] = var_3[var_14];
            var_3[var_14] = var_16;
          }
        }
      } else {
        for(var_13 = 0; var_13 < var_3.size - 1; var_13++) {
          var_17 = var_3[var_13];

          for(var_15 = var_13 + 1; var_15 < var_3.size; var_15++) {
            var_18 = var_3[var_15];

            if(var_8[var_18] > var_8[var_17]) {
              var_16 = var_17;
              var_3[var_13] = var_18;
              var_3[var_15] = var_16;
            }
          }
        }
      }
    }
  }

  return var_3;
}

vehicle_occupancy_seatisavailable(var_0, var_1, var_2) {
  var_3 = var_0.occupants[var_1];
  var_4 = var_0.occupantsreserving[var_1];

  if(istrue(var_0.brking_rankupdate))
    return 0;

  if(!isDefined(var_3) && !isDefined(var_4))
    return 1;

  if(isDefined(var_2)) {
    if(isDefined(var_3) && var_3 == var_2)
      return 1;

    if(isDefined(var_4) && var_4 == var_2)
      return 1;
  }

  return 0;
}

vehicle_occupancy_getseatoccupant(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 1;

  if(isDefined(var_0.occupants))
    return var_0.occupants[var_1];
  else
    return undefined;
}

vehicle_occupancy_getalloccupants(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  return var_0.occupants;
}

vehicle_occupancy_getalloccupantsandreserving(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_0.occupants))
    return undefined;

  return scripts\engine\utility::array_combine_unique(var_0.occupants, var_0.occupantsreserving);
}

_id_141D6(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_0.occupants))
    return undefined;

  return var_0.occupantsreserving;
}

vehicle_occupancy_getoccupantseat(var_0, var_1) {
  foreach(var_4, var_3 in var_0.occupants) {
    if(var_3 == var_1)
      return var_4;
  }

  return undefined;
}

vehicle_occupancy_occupantisvehicledriver(var_0) {
  if(isDefined(var_0.vehicle)) {
    var_1 = vehicle_occupancy_getoccupantseat(var_0.vehicle, var_0);
    var_2 = vehicle_occupancy_getleveldataforseat(var_0.vehicle.vehiclename, var_1);

    if(isDefined(var_2.animtag)) {
      var_3 = tolower(var_2.animtag);

      if(var_3 == "_encstr_A10D0BA3B27F17C327D98568E0")
        return 1;
    }
  }

  return 0;
}

vehicle_occupancy_getdriver(var_0, var_1) {
  var_2 = vehicle_occupancy_getdriverseat(var_0, var_1);

  if(isDefined(var_2))
    return vehicle_occupancy_getseatoccupant(var_0, var_2, !istrue(var_1));

  return undefined;
}

vehicle_occupancy_getdriverseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename, !istrue(var_1));

  if(!isDefined(var_2))
    return undefined;

  var_3 = var_2.driverseatid;

  if(!isDefined(var_3)) {
    foreach(var_6, var_5 in var_2.seatdata) {
      if(isDefined(var_5.animtag) && tolower(var_5.animtag) == "_encstr_A10D0BA3B27F17C327D98568E0") {
        var_3 = var_6;
        break;
      }
    }

    var_2.driverseatid = var_3;
  }

  return var_3;
}

_id_141DF(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(!isDefined(var_2.animtag))
    return 0;

  if(tolower(var_2.animtag) != "_encstr_A10D0BA3B27F17C327D98568E0")
    return 0;

  return 1;
}

vehicle_occupancy_enter(var_0, var_1, var_2, var_3, var_4) {
  var_5 = 0;

  if(isDefined(var_3) && isDefined(var_3.useonspawn))
    var_5 = 1;

  if(!var_5 && !var_2 scripts\cp_mp\utility\player_utility::_isalive()) {
    return;
  }
  if(istrue(var_2.inlaststand)) {
    return;
  }
  if(istrue(var_0.isdestroyed)) {
    return;
  }
  if(istrue(var_0.oob)) {
    if(isDefined(var_0.oobendtime) && var_0.oobendtime - gettime() < 100)
      return;
  }

  if(isDefined(var_0.vehicletype) && var_0.vehicletype == "_encstr_BABC16DABD1D7B4E36CBD8B1B2FAE0D0F29B2D6CDC7DB6C1") {
    var_6 = [var_0];
    var_7 = ["_encstr_BAC1197AA4A00BC432A281DA954387A2981390DFE5A0239BC8E8E4", "_encstr_B8431C7754DBAF6823F728509B6CA1DDB33A7871EC93775004C72040AF80", "_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"];
    var_8 = physics_createcontents(var_7);

    if(isDefined(var_8)) {
      var_9 = (0, 0, 1);
      var_10 = getdvarfloat("_encstr_828C1B9B2E8A0149F2DBCF939B6B85D002064211D6D310E38A57C7F1EB", 30);
      var_11 = getdvarfloat("_encstr_82821B633AC3A868258C2F638ECBE086FBB2BAE962AF75A97E742B0BBB", 0.5);
      var_12 = var_0 physics_getentitycenterofmass()["_encstr_AC04092555EB696184F1D9"];

      if(isDefined(var_12)) {
        var_13 = var_12 + var_9 * var_10;
        var_14 = scripts\engine\trace::sphere_trace(var_12, var_13, var_11, var_6, var_8);

        if(isDefined(var_14)) {
          var_15 = distance(var_12, var_14["_encstr_BD260953AA97E3F014279D"]);

          if(var_15 < var_10)
            return;
        }
      }
    }
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::_wakeupvehicle(var_0, 0, 0))
    return 0;

  foreach(var_17 in var_0.occupantsreserving) {
    if(isDefined(var_17) && var_17 == var_2)
      return;
  }

  var_19 = vehicle_occupancy_getoccupantseat(var_0, var_2);

  if(istrue(vehicle_occupancy_seatisavailable(var_0, var_1, var_2))) {
    vehicle_occupancy_stopmonitoringoccupant(var_2);

    if(!isDefined(var_3))
      var_3 = spawnStruct();

    var_3.immediate = istrue(var_4);
    var_3.raceendnotify = "_encstr_85D017E31030297291FD81C2D7B72AD718A87F13298999CAF9";
    var_3.raceendon = "_encstr_B6BD1683173818E69AF7D795FFB23D61CEEC08F83A90202D";

    if(!var_3.immediate) {
      thread vehicle_occupancy_raceplayerdeathdisconnect(var_2, var_3);
      thread vehicle_occupancy_racevehicledeath(var_0, var_3);
      thread vehicle_occupancy_raceseatunavailable(var_0, var_2, var_1, var_19, var_3);
      thread vehicle_occupancy_racecomplete(var_19, var_1, var_3);
    }

    if(isDefined(var_19))
      thread vehicle_occupancy_exitstart(var_0, var_19, var_1, var_2, var_3);

    if(isDefined(var_1))
      thread vehicle_occupancy_enterstart(var_0, var_1, var_19, var_2, var_3);

    vehicle_occupancy_updatefull(var_0);
    vehicle_occupancy_updateempty(var_0);

    if(!var_3.immediate) {
      var_3 waittill(var_3.raceendnotify);
      waittillframeend;
      var_3 notify(var_3.raceendon);
    }

    if(!scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_instanceisregistered(var_0)) {
      var_3.success = 0;

      if(isDefined(var_1))
        thread vehicle_occupancy_enterend(var_0, var_1, var_19, var_2, var_3);
    } else {
      var_20 = vehicle_occupancy_raceresults(var_0, var_2, var_19, var_1, var_3);

      if(isDefined(var_19))
        thread vehicle_occupancy_exitend(var_0, var_19, var_1, var_2, var_3);

      if(isDefined(var_1))
        thread vehicle_occupancy_enterend(var_0, var_1, var_19, var_2, var_3);

      vehicle_occupancy_updatefull(var_0);
      vehicle_occupancy_updateempty(var_0);

      if(var_20) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_816C0D1E9857658C751BD168B10B1F"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_816C0D1E9857658C751BD168B10B1F")]](var_2, var_0, var_19, var_1);

        thread vehicle_occupancy_monitoroccupant(var_0, var_2, var_1);
        var_2 cancelreloading();

        if(istrue(var_2.tracking_max_health))
          var_2 notify("_encstr_869A146EBB0984CB5B5F5F1B130893F780A1E5B6F128");

        if(isDefined(var_19)) {
          var_21 = _id_141DF(var_0, var_19);

          if(istrue(var_21) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_923B13D7F1A013534829E5ED4190BF9A9563170765"))
            var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_923B13D7F1A013534829E5ED4190BF9A9563170765")]]("_encstr_9933089193CA642806B7");
        }

        if(isDefined(var_1)) {
          var_21 = _id_141DF(var_0, var_1);

          if(istrue(var_21) && !istrue(level.loadoutbrfieldupgrade)) {
            var_22 = 0;
            var_23 = "_encstr_B40101";
            var_24 = "_encstr_B40101";
            var_25 = "_encstr_B40101";
            var_26 = "_encstr_B40101";

            switch (var_0.targetname) {
              case "_encstr_86510C82737817CD40B38B720A15":
                var_23 = var_2._id_14238.apc;
                var_24 = var_2._id_14238.c4_pick_up_listener;
                var_22 = 1;
                var_25 = var_2._id_14238.c130airdrop_heightoverride;
                break;
              case "_encstr_8C190467402B":
                var_23 = var_2._id_14238.check_cannot_spawn_tank;
                var_25 = var_2._id_14238.check_carrier_status;
                var_26 = var_2._id_14238.check_for_damage_scalar_change;
                break;
              case "_encstr_BAC20FBEE6F88945F163A37BD68409923B":
              case "_encstr_82120C6C2C4EB3BDAF1D4EBA8DB6":
                var_23 = var_2._id_14238.get_extra_focus_fire_multipler;
                var_25 = var_2._id_14238.get_fake_digit_from_pool;
                break;
              case "_encstr_85DE05A6B2AC0E":
                var_23 = var_2._id_14238.vehicle_damage_endburndown;
                var_25 = var_2._id_14238.vehicle_damage_enginevisualclearcallback;
                break;
              case "_encstr_B4E90FD0B2E3DC4D191E152BC2E8C7B51F":
              case "_encstr_9A8F0CB1A5E8471BB2EB894B39C8":
                var_23 = var_2._id_14238.x1opsenableelimination;
                var_25 = var_2._id_14238.x1opsendgame;
                var_26 = var_2._id_14238.zombieingas;
                break;
              case "_encstr_9A120A1D8536F5E4ED3BB293":
                var_23 = var_2._id_14238._id_139F7;
                var_25 = var_2._id_14238._id_139F8;
                var_26 = var_2._id_14238._id_139FC;
                break;
              case "_encstr_AF390B295782C3585F1B21D8C4":
                var_23 = scripts\engine\utility::ter_op(isDefined(var_0.spawndata.usealtmodel), var_2._id_14238._id_13A47, var_2._id_14238._id_13A52);
                var_24 = scripts\engine\utility::ter_op(isDefined(var_0.spawndata.usealtmodel), var_2._id_14238._id_13A48, var_2._id_14238._id_13A53);
                var_22 = 1;
                break;
              case "_encstr_99C20BA548E9F27A61D897932B":
                var_23 = var_2._id_14238._id_11D4D;
                var_25 = var_2._id_14238._id_11D5F;
                var_26 = var_2._id_14238._id_11D70;
                break;
              case "_encstr_BDC80A5437EAD749519A6068":
                var_23 = var_2._id_14238.br_is_allowed_armor_insert;
                var_26 = var_2._id_14238.br_isplayerbeforeinitialinfildeploy;
                break;
              case "_encstr_B4920771CA8F0618B2":
                var_23 = var_2._id_14238.create_head_icon_for_crate;
                var_26 = var_2._id_14238.createjuggdroplocation;
                break;
              case "_encstr_93FE141A20CDFF9FF62D627D4E9897023B58B3519843":
              case "_encstr_8C6E11D6F862F71F6E2336352728973BB09BDB":
                var_23 = "_encstr_B40101";
                var_25 = var_2._id_14238.get_fake_digit_from_pool;
                break;
              case "_encstr_97AE0AF6E0959BEB4D2B95C1":
                var_23 = "_encstr_B40101";
                var_25 = var_2._id_14238.vehicle_damage_enginevisualclearcallback;
                break;
              case "_encstr_91F511673FA9BB292DD8BAE321179E73A328F3":
                var_23 = var_2._id_14238._encstr_91F511673FA9BB292DD8BAE321179E73A328F3;
                var_24 = var_2._id_14238._encstr_8CEF1807A88FA060639211BB592F2718621FA7EF3473883E679B;
                var_22 = 1;
                var_25 = var_2._id_14238._encstr_858C16A71ADFAD5F40D0D16009AA4A7379780FFE6C2FAEFB;
                break;
              default:
                var_23 = "_encstr_B40101";
                var_25 = "_encstr_B40101";
            }

            var_0 setfacialindexfromasm(var_25);

            if(var_23 != "_encstr_B40101" && !isDefined(var_0.gasfxair)) {
              var_0 setvehiclecamo();
              var_0 getmountconfigenabled(var_23);

              if(var_22) {
                foreach(var_28 in var_0.turrets) {
                  var_28 sendclientmatchdataforclient(var_24);
                  break;
                }
              }

              var_0._id_1426C = var_26;
              var_0.gasfxair = 1;
            }

            if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_92B3146AAD7A42AB56187721804350F281D1FC7DC12A"))
              var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_92B3146AAD7A42AB56187721804350F281D1FC7DC12A")]]("_encstr_9933089193CA642806B7");
          }
        }

        if(!isDefined(var_19))
          var_30 = "_encstr_B6F410AD957B07C24959AFB90D646438234F";
        else
          var_30 = "_encstr_8E5B0CA98A28A27D9ABA4AA8D042";

        abilityleft::cleanuparenamolotovs(var_0, var_2, var_1, var_19);
        scripts\cp_mp\vehicles\vehicle_dlog::_id_1418A(var_0, var_2, var_1, var_30);
        return;
      }

      if(isDefined(var_19) && !istrue(var_3.vehicledeath)) {
        if(istrue(var_3.playerdeath) || istrue(var_3.playerlaststand) || istrue(var_3.playerdisconnect)) {
          var_31 = spawnStruct();
          var_31.playerdeath = var_3.playerdeath;
          var_31.playerlaststand = var_3.playerlaststand;
          var_31.playerdisconnect = var_3.playerdisconnect;
          thread vehicle_occupancy_exit(var_0, var_19, var_2, var_31, 1);
        } else
          vehicle_occupancy_reenter(var_0, var_19, var_1, var_2, var_3);
      }
    }
  }
}

vehicle_occupancy_exit(var_0, var_1, var_2, var_3, var_4) {
  var_5 = var_1;

  if(isDefined(var_2)) {
    if(!isDefined(var_5))
      var_5 = vehicle_occupancy_getoccupantseat(var_0, var_2);

    if(!var_2 scripts\cp_mp\utility\player_utility::_isalive())
      var_4 = 1;

    if(istrue(var_2.inlaststand))
      var_4 = 1;

    vehicle_occupancy_stopmonitoringoccupant(var_2);
  } else {
    var_4 = 1;
    vehicle_occupancy_purgedataforseatinstance(var_0, var_5);
  }

  if(istrue(var_0.isdestroyed))
    var_4 = 1;

  if(!isDefined(var_3))
    var_3 = spawnStruct();

  var_3.immediate = istrue(var_4);
  var_3.raceendnotify = "_encstr_85D017E31030297291FD81C2D7B72AD718A87F13298999CAF9";
  var_3.raceendon = "_encstr_B6BD1683173818E69AF7D795FFB23D61CEEC08F83A90202D";

  if(!var_3.immediate) {
    thread vehicle_occupancy_raceplayerdeathdisconnect(var_2, var_3);
    thread vehicle_occupancy_racevehicledeath(var_0, var_3);
    thread vehicle_occupancy_racecomplete(var_5, undefined, var_3);
  }

  thread vehicle_occupancy_exitstart(var_0, var_5, undefined, var_2, var_3);

  if(!var_3.immediate) {
    var_3 waittill(var_3.raceendnotify);
    waittillframeend;
    var_3 notify(var_3.raceendon);
  }

  var_6 = vehicle_occupancy_raceresults(var_0, var_2, var_5, undefined, var_3);
  thread vehicle_occupancy_exitend(var_0, var_5, undefined, var_2, var_3);
  vehicle_occupancy_updatefull(var_0);
  vehicle_occupancy_updateempty(var_0);

  if(!var_6) {
    if(!istrue(var_3.playerdeath) && !istrue(var_3.playerlaststand) && !istrue(var_3.playerdisconnect) && !istrue(var_3.vehicledeath))
      vehicle_occupancy_reenter(var_0, var_5, undefined, var_2, var_3);
  } else if(isDefined(var_2)) {
    var_2 cancelreloading();
    var_7 = _id_141DF(var_0, var_5);

    if(istrue(var_7) && scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_923B13D7F1A013534829E5ED4190BF9A9563170765"))
      var_2[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A5580B6C43B0B163CA9BB395CD", "_encstr_923B13D7F1A013534829E5ED4190BF9A9563170765")]]("_encstr_9933089193CA642806B7");
  }
}

_id_141E2(var_0, var_1) {
  if(level.teambased)
    return _id_141E3(var_0, var_1.team);
  else {
    if(istrue(var_0.playersetattractionoff))
      var_0 _id_141C8(var_0);

    return isDefined(var_0._id_12564) && var_0._id_12564 == var_1;
  }
}

_id_141E0(var_0, var_1) {
  if(level.teambased)
    return _id_141E1(var_0, var_1.team);
  else {
    if(istrue(var_0.playersetattractionoff))
      var_0 _id_141C8(var_0);

    return isDefined(var_0._id_12564) && var_0._id_12564 != var_1;
  }
}

_id_141E4(var_0, var_1) {
  if(level.teambased)
    return _id_141E5(var_0, var_1.team);
  else {
    if(istrue(var_0.playersetattractionoff))
      var_0 _id_141C8(var_0);

    return !isDefined(var_0._id_12564);
  }
}

_id_141D5(var_0) {
  if(!level.teambased) {
    if(istrue(var_0.playersetattractionoff))
      var_0 _id_141C8(var_0);

    return var_0._id_12564;
  }

  return undefined;
}

_id_141E3(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0.playersetattractionoff))
      var_0 _id_141C8(var_0);

    return isDefined(var_0._id_13AAD) && var_0._id_13AAD == var_1;
  }

  return undefined;
}

_id_141E1(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0.playersetattractionoff))
      var_0 _id_141C8(var_0);

    return isDefined(var_0._id_13AAD) && var_0._id_13AAD != var_1;
  }

  return undefined;
}

_id_141E5(var_0, var_1) {
  if(level.teambased) {
    if(istrue(var_0.playersetattractionoff))
      var_0 _id_141C8(var_0);

    return !isDefined(var_0._id_13AAD);
  }

  return undefined;
}

_id_141D7(var_0) {
  if(level.teambased) {
    if(istrue(var_0.playersetattractionoff))
      var_0 _id_141C8(var_0);

    return var_0._id_13AAD;
  }

  return undefined;
}

_id_141F4(var_0) {
  var_0.playersetattractionoff = 1;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(var_0);
}

_id_141C8(var_0) {
  if(level.teambased) {
    var_1 = 0;
    var_2 = var_0._id_13AAD;

    if(isDefined(var_0.team) && var_0.team != "_encstr_A7A408B9CA5D1D4E2C63") {
      var_0._id_13AAD = var_0.team;
      var_0.playersetattractionoff = undefined;
      var_1 = 1;
    }

    if(!var_1) {
      foreach(var_4 in var_0.occupants) {
        if(isDefined(var_4)) {
          var_0._id_13AAD = var_4.team;
          var_0.playersetattractionoff = undefined;
          var_1 = 1;
          break;
        }
      }
    }

    if(!var_1) {
      var_0._id_13AAD = undefined;
      var_0.playersetattractionoff = undefined;
    }

    if(!isDefined(var_2) && !isDefined(var_0._id_13AAD))
      return 0;

    if(isDefined(var_2) && isDefined(var_0._id_13AAD) && var_2 == var_0._id_13AAD)
      return 0;

    _id_141D4(var_0, var_2, var_0._id_13AAD);
    return 1;
  } else {
    var_1 = 0;
    var_6 = var_0._id_12564;

    if(isDefined(var_0.originalowner)) {
      var_0._id_12564 = var_0.originalowner;
      var_0.playersetattractionoff = undefined;
      var_1 = 1;
    }

    if(!var_1) {
      var_7 = vehicle_occupancy_getalloccupants(var_0);

      foreach(var_4 in var_7) {
        if(isDefined(var_4)) {
          var_0._id_12564 = var_4;
          var_0.playersetattractionoff = undefined;
          return;
        }
      }
    }

    if(!isDefined(var_6) && !isDefined(var_0._id_12564))
      return 0;

    if(isDefined(var_6) && isDefined(var_0._id_12564) && var_6 == var_0._id_12564)
      return 0;

    _id_141D4(var_0, var_6, var_0._id_12564);
    return 1;
  }
}

_id_141D4(var_0, var_1, var_2) {
  _calloutmarkerping_predicted_timeout::_id_14121(var_0, var_1, var_2);
  var_3 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(!isDefined(var_3.playersetattractionlocationindex)) {
    return;
  }
  thread[[var_3.playersetattractionlocationindex]](var_0, var_1, var_2);
}

vehicle_occupancy_setoriginalowner(var_0, var_1) {
  var_0.originalowner = var_1;
  vehicle_occupancy_updateowner(var_0);
}

vehicle_occupancy_setowner(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_0.owners))
    var_0.owners = [];
  else {
    vehicle_occupancy_clearowner(var_0, var_1);
    var_0.owners = scripts\engine\utility::array_removeundefined(var_0.owners);
  }

  var_0.owners[var_0.owners.size] = var_1;

  if(isDefined(var_3) && var_3 == -1) {} else
    thread vehicle_occupancy_watchowner(var_0, var_1, var_2, var_3);

  vehicle_occupancy_updateowner(var_0);
}

vehicle_occupancy_updateowner(var_0) {
  var_0 notify("_encstr_857C15BB4868015AA9C5A95D3445F2C256601B7BF08345");
  var_1 = var_0.owner;
  var_2 = var_0.ownerteam;
  var_3 = undefined;

  if(isDefined(var_0.owners)) {
    for(var_4 = var_0.owners.size - 1; var_4 >= 0; var_4--) {
      if(vehicle_occupancy_isplayervalidowner(var_0, var_0.owners[var_4])) {
        var_3 = var_0.owners[var_4];
        break;
      }
    }
  }

  if(!isDefined(var_3)) {
    if(vehicle_occupancy_isplayervalidowner(var_0, var_0.originalowner))
      var_3 = var_0.originalowner;
  }

  var_0.owner = var_3;
  var_5 = 0;

  if(isDefined(var_3) || isDefined(var_1)) {
    if(!isDefined(var_3) && isDefined(var_1))
      var_5 = 1;
    else if(isDefined(var_3) && !isDefined(var_1))
      var_5 = 1;
    else if(var_3 != var_1)
      var_5 = 1;
  }

  var_6 = 0;

  if(isDefined(var_3)) {
    if(!isDefined(var_2) || var_2 != var_3.team)
      var_6 = 1;

    var_0.ownerteam = var_3.team;
    var_0 setvehicleteam(var_3.team);
    thread vehicle_occupancy_watchownerjoinedteam(var_0, var_3);
  } else {
    if(var_5)
      var_6 = 1;

    var_0.ownerteam = undefined;
  }

  if(var_5) {
    if(!level.teambased)
      _id_141F4(var_0);
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_96B70CAE838CC2E82BD3BB3759E4"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_96B70CAE838CC2E82BD3BB3759E4")]](var_0);

  var_7 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_7) && isDefined(var_7.updateownercallback))
    [[var_7.updateownercallback]](var_0, var_3, var_5, var_6);
}

vehicle_occupancy_clearowner(var_0, var_1) {
  var_0 notify("_encstr_AC6B15D84A52BBEEF96B195AC977E742404DC8B3A1F3E7" + var_1 getentitynumber());

  if(isDefined(var_0.owners))
    var_0.owners = scripts\engine\utility::array_remove(var_0.owners, var_1);

  if(isDefined(var_0.owner) && var_0.owner == var_1)
    vehicle_occupancy_updateowner(var_0);
}

vehicle_occupancy_setteam(var_0, var_1) {
  var_2 = !isDefined(var_0.team) || var_0.team != var_1;
  var_0.team = var_1;

  if(var_0.classname == "_encstr_86440FCD8D9CD2833AFA3B2B34B4D81B56")
    var_0 setvehicleteam(var_1);

  if(var_2) {
    if(level.teambased)
      _id_141F4(var_0);
  }

  var_3 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_3) && isDefined(var_3.updateteamcallback))
    [[var_3.updateteamcallback]](var_0, var_1, var_2);

  vehicle_occupancy_updateowner(var_0);
}

vehicle_occupancy_init() {
  var_0 = spawnStruct();
  level.vehicle.occupancy = var_0;
  var_0.vehicledata = [];
  var_0._id_13CEA = getdvarint("_encstr_AFE71A9B3627BE47E40B739BA53AD2BD9B249619565473C2C4B1B2C8", 1) > 0;

  if(var_0._id_13CEA) {
    var_0._id_13CEB = 0;
    var_0._id_13CEC = [];
  }

  vehicle_occupancy_initdebug();
  [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_88C5055208731B")]]();
}

vehicle_occupancy_enterstart(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4.raceendon);
  var_0.occupantsreserving[var_1] = var_3;
  var_3._id_1425D = var_0;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  var_5 = undefined;

  if(var_4.immediate)
    var_5 = gettime();

  if(isDefined(var_4.enterstartwaitmsg))
    var_3 waittill(var_4.enterstartwaitmsg);

  vehicle_occupancy_deleteseatcorpse(var_0, var_1, 1);

  if(isDefined(var_3) && var_3 isthrowinggrenade()) {
    if(!isDefined(var_4.enterstartcomplete))
      var_4.enterstartcomplete = 1;

    var_4.success = 0;
    return;
  }

  var_6 = vehicle_occupancy_getenterstartcallbackforseat(var_0, var_1);

  if(isDefined(var_6))
    [[var_6]](var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_4.enterstartcomplete))
    var_4.enterstartcomplete = 1;

  if(var_4.immediate)
    return;
}

vehicle_occupancy_exitstart(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4.raceendon);
  var_5 = undefined;

  if(var_4.immediate)
    var_5 = gettime();

  var_6 = vehicle_occupancy_getexitstartcallbackforseat(var_0, var_1);

  if(isDefined(var_6))
    [[var_6]](var_0, var_1, var_2, var_3, var_4);

  if(!isDefined(var_4.exitstartcomplete))
    var_4.exitstartcomplete = 1;

  if(var_4.immediate)
    return;
}

vehicle_occupancy_exitstartcallback(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4.raceendon);
  var_5 = vehicle_occupancy_findplayerexit(var_3, var_0, var_1, var_2, var_4);

  if(!var_5) {
    var_4.exitstartcomplete = 0;
    _id_141D1(var_3, 2);

    if(!istrue(var_4.immediate)) {
      waitframe();
      var_4 notify(var_4.raceendnotify);
    }
  }
}

vehicle_occupancy_enterend(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_4.success)) {
    var_0.occupants[var_1] = var_3;
    var_0.occupantsreserving[var_1] = undefined;
    var_3.vehicle = var_0;
    var_3._id_1425D = undefined;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_8BB007E03658CBCAE4", "_encstr_8F7A18C5ACC333A18477C1B04FB3DB0FEBD647CF458AE7CB756B"))
      self[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_8BB007E03658CBCAE4", "_encstr_8F7A18C5ACC333A18477C1B04FB3DB0FEBD647CF458AE7CB756B")]]();

    vehicle_occupancy_applyrestrictionstooccupant(var_0, var_1, var_3, var_4);
    _id_141F9(var_3, var_0, var_1);
    vehicle_occupancy_hideoccupant(var_0, var_1, var_3, var_4);
    vehicle_occupancy_applycameratooccupant(var_0, var_1, var_2, var_3, var_4);
    vehicle_occupancy_applydamagemodifiertooccupant(var_0, var_1, var_3, var_4);
    _id_141DB(var_0, var_1, var_3, var_4);

    if(!isDefined(var_2))
      vehicle_occupancy_onentervehicle(var_0, var_1, var_3, var_4);

    var_5 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

    if(isDefined(var_5.animtag) && tolower(var_5.animtag) == tolower("_encstr_A10D0BA3B27F17C327D98568E0"))
      vehicle_occupancy_setowner(var_0, var_3, 1);

    if(!isDefined(var_2)) {
      var_3 notify("_encstr_911C0E46025264AE3098DF12985BA553");

      if(isDefined(var_5._id_12023))
        thread _id_141DA(var_3, var_5, 1);
    } else {
      var_3 notify("_encstr_A68614E329B32F56F053FFCB61B05D4F6D06CB5A3115");

      if(isDefined(var_5._id_12023))
        thread _id_141DA(var_3, var_5, 0);
    }
  } else {
    if(isDefined(var_3)) {
      var_3._id_1425D = undefined;
      var_5 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

      if(isDefined(var_5._id_13E92))
        vehicle_occupancy_taketurret(var_3, var_0, var_5._id_13E92, var_4, 1);

      vehicle_occupancy_showoccupant(var_0, var_1, var_3, var_4, 1);
    }

    if(!istrue(var_4.vehicledeath))
      var_0.occupantsreserving[var_1] = undefined;
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  var_6 = gettime();
  var_7 = vehicle_occupancy_getenterendcallbackforseat(var_0, var_1);

  if(isDefined(var_7))
    [[var_7]](var_0, var_1, var_2, var_3, var_4);
}

vehicle_occupancy_exitend(var_0, var_1, var_2, var_3, var_4) {
  if(var_4.success) {
    var_0.occupants[var_1] = undefined;

    if(isDefined(var_3)) {
      var_3 notify("_encstr_939D1243D0687BBE49BDDFE381D6D34F7508A01B");
      var_5 = 0;

      if(!isDefined(var_2)) {
        var_3.vehicle = undefined;
        var_5 = 1;
      }

      vehicle_occupancy_removerestrictionsfromoccupant(var_0, var_1, var_3, var_4);
      _id_141F9(var_3, var_0, var_2);
      vehicle_occupancy_showoccupant(var_0, var_1, var_3, var_4, var_5);
      vehicle_occupancy_removecamerafromoccupant(var_0, var_2, var_3, var_4);
      vehicle_occupancy_removedamagemodifierfromoccupant(var_0, var_1, var_3, var_4);
      _id_141F5(var_0, var_1, var_3, var_4);
    }

    if(!isDefined(var_2))
      vehicle_occupancy_onexitvehicle(var_0, var_1, var_3, var_4);

    if(!var_0 scripts\common\vehicle_code::vehicle_is_stopped() && _id_141DF(var_0, var_1)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_B607038AAB", "_encstr_9179131B34C23663CAB9CE59516785365DB0A3DE39")) {
        var_6 = spawnStruct();
        var_6.onplayerkillednew = 1;
        var_3 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B607038AAB", "_encstr_9179131B34C23663CAB9CE59516785365DB0A3DE39")]]("_encstr_A7311980D01767F9A33B0F22D37F2F54A5D37B764B3F1F81CC51C2", var_6);
      }
    }
  }

  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setvehicledirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointsdirty(var_0);
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  var_7 = gettime();
  var_8 = vehicle_occupancy_getexitendcallbackforseat(var_0, var_1);

  if(isDefined(var_8))
    [[var_8]](var_0, var_1, var_2, var_3, var_4);

  if(isDefined(var_3)) {
    var_3 usebuttondone();

    if(!isDefined(var_2)) {
      if(isDefined(var_3._id_14277))
        var_3._id_14277 = undefined;

      if(isDefined(var_3._id_14276))
        var_3._id_14276 = undefined;
    }
  }
}

vehicle_occupancy_reenter(var_0, var_1, var_2, var_3, var_4) {
  thread vehicle_occupancy_monitoroccupant(var_0, var_3, var_1);
  var_5 = gettime();
  var_6 = vehicle_occupancy_getreentercallbackforseat(var_0, var_1);

  if(isDefined(var_6))
    [[var_6]](var_0, var_1, var_2, var_3, var_4);
}

vehicle_occupancy_getleveldata() {
  return level.vehicle.occupancy;
}

_id_141DA(var_0, var_1, var_2) {
  var_3 = 5000;

  if(istrue(var_2)) {
    var_0._id_14277 = var_1._id_12023;
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](var_0, var_1._id_12023, undefined, 1);
    var_0._id_14276 = gettime();
  } else if(isDefined(var_0._id_14277) && isDefined(var_0._id_14276) && var_0._id_14277 != var_1._id_12023 && gettime() - var_0._id_14276 > var_3) {
    thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B472054FE12550", "_encstr_8E8311D9FBA39E303955A0390604E9C8DB2361")]](var_0, var_1._id_12023);
    var_0._id_14277 = var_1._id_12023;
    var_0._id_14276 = gettime();
  }
}

vehicle_occupancy_purgedataforseatinstance(var_0, var_1) {
  var_0.occupants[var_1] = undefined;
  var_0.occupantsreserving[var_1] = undefined;
}

vehicle_occupancy_onentervehicle(var_0, var_1, var_2, var_3) {
  _id_141F4(var_0);
  var_0 scripts\cp_mp\vehicles\vehicle_spawn::_id_1421A();
  var_2 setstance("_encstr_A5AD069B231F0BAF");
  var_2 scripts\common\utility::allow_array(vehicle_occupancy_getoccupantrestrictions(), 0);
  thread _id_141F8(var_2, var_0, var_1);
  abilityleft::claymore_crate_use(var_0, var_2);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AC0B0F6F0BE08018A55A0779C481E8C95A", 1))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_AC0B0F6F0BE08018A55A0779C481E8C95A")]](var_0, var_1, var_2, var_3);
}

vehicle_occupancy_onexitvehicle(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3.playerdisconnect)) {
    var_2 vehicle_occupancy_stopmovefeedbackforplayer();
    var_2 vehicle_occupancy_cleardamagefeedbackforplayer();

    if(!istrue(var_3.playerdeath)) {
      if(istrue(var_3.playerlaststand))
        var_3.onprematchfadedone2 = "_encstr_AD75062D5F18A10C";
      else if(!isDefined(var_3.onprematchfadedone2))
        var_3.onprematchfadedone2 = "_encstr_84B20A95A7C4AAE451A049AC";

      var_2 scripts\common\utility::allow_array(vehicle_occupancy_getoccupantrestrictions(), 1);
      thread scripts\cp_mp\vehicles\vehicle::_id_14203(var_0, var_2);
    } else
      var_3.onprematchfadedone2 = "_encstr_AD75062D5F18A10C";

    thread _id_141D9(var_2, var_3.playerdeath, var_3.playerlaststand);
  } else
    var_3.onprematchfadedone2 = "_encstr_8D820B4D508F1EC125FE2327CC";

  _id_141F4(var_0);

  if(scripts\cp_mp\vehicles\vehicle_spawn::_id_14214() && var_0.occupants.size == 0)
    var_0 thread scripts\cp_mp\vehicles\vehicle_spawn::_id_1421D();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_BA110E075B45433181E1982091C8AB68", 1))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_BA110E075B45433181E1982091C8AB68")]](var_0, var_1, var_2, var_3);

  var_2 notify("_encstr_8B18148B28612902BDF0FB374353BAF409495733A87B");
  scripts\cp_mp\vehicles\vehicle_dlog::vehicle_dlog_exitevent(var_0, var_2, var_1, var_3.onprematchfadedone2);
  abilityleft::claymore_forceclampangles(var_0, var_2, var_1);
}

vehicle_occupancy_updatefull(var_0) {
  var_1 = vehicle_occupancy_getavailablevehicleseats(var_0).size <= 0;

  if(var_1) {
    if(!istrue(var_0.isfull)) {
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointdirty(var_0, "_encstr_BDDC07EBCCB5CA4BED");
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
      var_0.isfull = 1;
    } else
      scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  } else if(istrue(var_0.isfull)) {
    var_0.isfull = undefined;
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_setpointdirty(var_0, "_encstr_BDDC07EBCCB5CA4BED");
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
  } else
    scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_updateusability(var_0);
}

vehicle_occupancy_updateempty(var_0) {
  var_1 = vehicle_occupancy_getavailablevehicleseats(var_0);
  var_2 = vehicle_occupancy_getallvehicleseats(var_0);
  var_3 = var_1.size == var_2.size;

  if(!istrue(var_0.isempty) && var_3)
    scripts\cp_mp\vehicles\vehicle_tracking::vehiclecannotbesuspended(var_0, 0);

  if(istrue(var_0.isempty) && !var_3)
    var_4 = scripts\cp_mp\vehicles\vehicle_tracking::vehiclecannotbesuspended(var_0, 1, 0);

  var_0.isempty = var_3;
}

vehicle_occupancy_getenterstartcallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.enterstartcallback), var_3.enterstartcallback, var_2.enterstartcallback);
}

vehicle_occupancy_getenterendcallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.enterendcallback), var_3.enterendcallback, var_2.enterendcallback);
}

vehicle_occupancy_getexitstartcallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.exitstartcallback), var_3.exitstartcallback, var_2.exitstartcallback);
}

vehicle_occupancy_getexitendcallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.exitendcallback), var_3.exitendcallback, var_2.exitendcallback);
}

vehicle_occupancy_getreentercallbackforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.reentercallback), var_3.reentercallback, var_2.reentercallback);
}

vehicle_occupancy_applyrestrictionstooccupant(var_0, var_1, var_2, var_3) {
  if(!vehicle_occupancy_movementisallowed(var_0)) {
    if(var_1 == vehicle_occupancy_getdriverseat(var_0))
      vehicle_occupancy_allowmovementplayer(var_0, var_2, 0, var_1);
  }

  var_4 = vehicle_occupancy_getrestrictionsforseat(var_0, var_1);
  var_2 scripts\common\utility::allow_array(var_4, 0);
  var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("_encstr_9A50080BA7292FFA0DA2");
}

vehicle_occupancy_removerestrictionsfromoccupant(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3.playerdeath)) {
    vehicle_occupancy_allowmovementplayer(var_0, var_2, 1, undefined);
    var_4 = vehicle_occupancy_getrestrictionsforseat(var_0, var_1);
    var_2 scripts\common\utility::allow_array(var_4, 1);
    var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_9A50080BA7292FFA0DA2");
  }
}

_id_141DD() {
  if(!isDefined(level.spawn_deceleration))
    level.spawn_deceleration = getdvarint("_encstr_AAFA1A72C138F7222B5107B747C63B1058882BF338A098E9FD73172F", 1);

  return level.spawn_deceleration;
}

vehicle_occupancy_hideoccupant(var_0, var_1, var_2, var_3) {
  if(vehicle_shouldhideoccupantforseat(var_0, var_1)) {
    var_2.nocorpse = 1;

    if(_id_141DD())
      var_2 scripts\cp_mp\utility\player_utility::allowunresolvedcollision();
    else
      var_2 playerhide();

    var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("_encstr_9A50080BA7292FFA0DA2");
  }
}

_id_141DC(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldata();

  if(!var_2._id_13CEA) {
    return;
  }
  var_3 = var_2._id_13CEB;
  var_2._id_13CEB++;
  var_0 scripts\cp_mp\utility\player_utility::allowunresolvedcollision();
  var_2._id_13CEC[var_3] = var_0;

  if(!isDefined(var_1._id_13CEC))
    var_1._id_13CEC = [];

  var_1._id_13CEC[var_3] = var_0;
  var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::loadout_finalizeweapons("_encstr_9A50080BA7292FFA0DA2");
  return var_3;
}

_id_141F7(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getleveldata();

  if(!var_3._id_13CEA) {
    return;
  }
  if(istrue(var_2)) {
    waitframe();
    waitframe();
  }

  if(!var_3._id_13CEA) {
    return;
  }
  if(!isDefined(var_3._id_13CEC[var_0])) {
    return;
  }
  var_4 = var_3._id_13CEC[var_0];

  if(isDefined(var_1) && isDefined(var_1._id_13CEC))
    var_1._id_13CEC[var_0] = undefined;

  if(isDefined(var_4)) {
    var_4 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
    var_4 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_9A50080BA7292FFA0DA2");
  }
}

_id_141F6(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldata();

  if(!var_2._id_13CEA) {
    return;
  }
  if(istrue(var_1)) {
    waitframe();
    waitframe();
  }

  if(!isDefined(var_0._id_13CEC)) {
    return;
  }
  foreach(var_5, var_4 in var_0._id_13CEC) {
    if(isDefined(var_2._id_13CEC[var_5])) {
      var_2._id_13CEC[var_5] = undefined;

      if(isDefined(var_4))
        var_4 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
    }
  }

  var_0._id_13CEC = undefined;
}

_id_141C9() {
  var_0 = vehicle_occupancy_getleveldata();

  if(!var_0._id_13CEA) {
    return;
  }
  foreach(var_3, var_2 in var_0._id_13CEC) {
    if(!isDefined(var_2))
      var_0._id_13CEC[var_3] = undefined;
  }
}

vehicle_occupancy_showoccupant(var_0, var_1, var_2, var_3, var_4) {
  if(!istrue(var_3.playerdeath))
    var_2.nocorpse = undefined;

  if(vehicle_shouldhideoccupantforseat(var_0, var_1) || istrue(var_4)) {
    if(_id_141DD()) {
      if(istrue(var_4)) {
        var_2 scripts\cp_mp\utility\player_utility::_id_125D0();
        var_2 playershow();
        var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_9A50080BA7292FFA0DA2");
      } else {
        var_2 scripts\cp_mp\utility\player_utility::allplayers_clearphysicaldof();
        var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_9A50080BA7292FFA0DA2");
      }
    } else {
      var_2 playershow();
      var_2 _calloutmarkerping_isvehicleoccupiedbyenemy::move_structs("_encstr_9A50080BA7292FFA0DA2");
    }
  }
}

vehicle_occupancy_applycameratooccupant(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_getcameraforseat(var_0, var_1);

  if(isDefined(var_5) && var_5 != "_encstr_8BBA05185F8B99") {
    var_6 = vehicle_getcameraforseat(var_0, var_2);

    if(var_6 != var_5)
      var_3 cameraset(var_5);
  }
}

vehicle_occupancy_removecamerafromoccupant(var_0, var_1, var_2, var_3) {
  if(isDefined(var_1)) {
    var_4 = vehicle_getcameraforseat(var_0, var_1);

    if(var_4 == "_encstr_8BBA05185F8B99") {
      var_2 cameradefault();
      return;
    }
  } else
    var_2 cameradefault();
}

vehicle_occupancy_applydamagemodifiertooccupant(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_occupancy_getdamagemodifierforseat(var_0, var_1);

  if(isDefined(var_4) && var_4 != -1)
    var_2 scripts\cp_mp\utility\damage_utility::adddamagemodifier(var_0.vehiclename + "_encstr_BA4C02DF" + var_1, var_4, 0, ::vehicle_occupancy_damagemodifierignorefunc);
}

vehicle_occupancy_removedamagemodifierfromoccupant(var_0, var_1, var_2, var_3) {
  if(!istrue(var_3.playerdeath)) {
    var_4 = vehicle_occupancy_getdamagemodifierforseat(var_0, var_1);

    if(isDefined(var_4) && var_4 != -1)
      var_2 scripts\cp_mp\utility\damage_utility::removedamagemodifier(var_0.vehiclename + "_encstr_BA4C02DF" + var_1, 0);
  }
}

vehicle_occupancy_getrestrictionsforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.restrictions), var_3.restrictions, var_2.restrictions);
}

vehicle_shouldhideoccupantforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];

  if(isDefined(var_3.hideoccupant))
    return istrue(var_3.hideoccupant);
  else
    return istrue(var_2.hideoccupant);
}

vehicle_getcameraforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_1)) {
    var_3 = var_2.seatdata[var_1];
    var_4 = var_2.camera;

    if(isDefined(var_3.camera))
      var_4 = var_3.camera;

    if(isDefined(var_3.animtag) && tolower(var_3.animtag) == "_encstr_A10D0BA3B27F17C327D98568E0")
      var_4 = "_encstr_8BBA05185F8B99";
  } else
    var_4 = "_encstr_8BBA05185F8B99";

  return var_4;
}

vehicle_occupancy_getdamagemodifierforseat(var_0, var_1) {
  var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_3 = var_2.seatdata[var_1];
  return scripts\engine\utility::ter_op(isDefined(var_3.damagemodifier), var_3.damagemodifier, var_2.damagemodifier);
}

vehicle_occupancy_damagemodifierignorefunc(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = scripts\cp_mp\utility\damage_utility::packdamagedata(var_1, var_2, var_3, var_5, var_4, var_0);

  if(var_4 == "_encstr_B43E114DF4394751269B1FE77BCE299869FFB3")
    return 1;

  if(isDefined(var_5) && var_5.basename == "_encstr_A9F00D4CBDAD4CEB9BD2E8957DAD0E")
    return 1;

  if(var_2 scripts\cp_mp\utility\damage_utility::isstuckdamage(var_7))
    return 1;

  return 0;
}

vehicle_occupancy_monitoroccupant(var_0, var_1, var_2) {
  thread _id_141E8(var_0, var_1, var_2);
  thread vehicle_occupancy_monitorseatswitch(var_0, var_1, var_2, 1);
  thread vehicle_occupancy_monitorexit(var_0, var_1, var_2);
  thread _id_141E9(var_0, var_1, var_2);
}

vehicle_occupancy_stopmonitoringoccupant(var_0) {
  var_0 notify("_encstr_B616226407DA8B393CDFB940BF4BB3F1126D566B11627F4011B330A0176F28218B5559F6");
  var_0 notify("_encstr_87FD2410F2BC7BC103DD1070B3574B11A6EA1BE0C915BFB82FD4B7F6BB9731D18203D810E2EC");
  var_0 notify("_encstr_B2091EF6CD70DFAEA94091AA488F63F309206B8148787F354B209A7311D15C3B");
  var_0 notify("_encstr_961323DB118B671EA81B878F2FE8A3CBA7E802D3BED1C715E851BF9A8F106DC7CD40EA9A61");
}

vehicle_occupancy_monitorseatswitch(var_0, var_1, var_2, var_3) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_8B1A098BD8E134029B657C");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 notify("_encstr_87FD2410F2BC7BC103DD1070B3574B11A6EA1BE0C915BFB82FD4B7F6BB9731D18203D810E2EC");
  var_1 endon("_encstr_87FD2410F2BC7BC103DD1070B3574B11A6EA1BE0C915BFB82FD4B7F6BB9731D18203D810E2EC");
  var_4 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(var_4.seatdata.size <= 1) {
    return;
  }
  var_5 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);

  if(!isDefined(var_5.seatswitcharray) || var_5.seatswitcharray.size <= 0) {
    return;
  }
  if(!isbot(var_1)) {
    if(var_3)
      wait 0.2;

    while(var_1 aicalcsuppressspot())
      waitframe();

    while(!var_1 aicalcsuppressspot())
      waitframe();

    var_6 = vehicle_occupancy_getnextavailableseat(var_0, var_1, var_2);

    if(isDefined(var_6))
      thread vehicle_occupancy_enter(var_0, var_6, var_1);

    _id_141D1(var_1, 1);
    thread vehicle_occupancy_monitorseatswitch(var_0, var_1, var_2, 0);
  }
}

vehicle_occupancy_getnextavailableseat(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);

  if(!isDefined(var_3.seatswitcharray) || var_3.seatswitcharray.size <= 0)
    return undefined;

  foreach(var_5 in var_3.seatswitcharray) {
    if(vehicle_occupancy_seatisavailable(var_0, var_5, var_1))
      return var_5;
  }
}

vehicle_occupancy_monitorexit(var_0, var_1, var_2) {
  var_1 notify("_encstr_B2091EF6CD70DFAEA94091AA488F63F309206B8148787F354B209A7311D15C3B");
  var_1 endon("_encstr_B2091EF6CD70DFAEA94091AA488F63F309206B8148787F354B209A7311D15C3B");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  vehicle_occupancy_monitorexitinternal(var_0, var_1, var_2);
  var_3 = spawnStruct();

  if(isDefined(var_1)) {
    if(!var_1 scripts\cp_mp\utility\player_utility::_isalive())
      var_3.playerdeath = 1;

    if(istrue(var_1.inlaststand))
      var_3.playerlaststand = 1;
  } else
    var_3.playerdisconnect = 1;

  thread vehicle_occupancy_exit(var_0, var_2, var_1, var_3);
}

vehicle_occupancy_monitorexitinternal(var_0, var_1, var_2) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_3 = gettime() + 1000;
  var_4 = 0;
  var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", 0);

  for(;;) {
    if(!var_1 useButtonPressed())
      var_4 = 1;

    if(var_4 && gettime() >= var_3) {
      break;
    }

    waitframe();
  }

  var_5 = level.framedurationseconds;
  var_6 = getdvarint("_encstr_923D0BEB217B114153E83CC451", 250) / 1000;

  for(;;) {
    var_7 = 0;
    var_8 = var_1 ismlgfreecamenabled();
    var_9 = 0;
    var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", 0);
    var_10 = isDefined(var_0) && istrue(var_0.loadandplayholoeffect);

    while(var_1 useButtonPressed()) {
      var_1 forcereloading();
      var_1 startragdollfromvehicleimpact();
      var_9 = 1;
      var_7 = var_7 + var_5;
      var_11 = var_1 usinggamepad();
      var_12 = var_1 setvehiclehornsound();
      var_13 = !var_11 && !var_12;
      var_14 = !var_11 && var_12;
      var_15 = var_11 && var_8 == 0;
      var_16 = var_11 && var_8 > 0;
      var_17 = var_15 || var_14;

      if(var_15 || var_14)
        var_1 setclientomnvar("_encstr_A90D1CEA2DAF3B5986AF95C3A5D1BE26D58EA3DECDAF34DBC619A3966BB2", var_7 / 0.3);

      if((var_17 && var_7 > 0.3 || var_13) && !var_10)
        return;
      else if(var_16 && var_7 >= var_6) {
        var_1 cancelreloading();
        var_1 reloadbuttonPressed();
      }

      wait(var_5);
    }

    if(var_9 && var_1 usinggamepad() && var_8 > 0 && var_7 < var_6 && !var_10)
      return;
    else if(var_9) {
      var_1 cancelreloading();
      var_1 reloadbuttonPressed();
    }

    waitframe();
  }
}

_id_141D1(var_0, var_1) {
  var_2 = undefined;

  switch (var_1) {
    case 1:
      var_2 = "_encstr_BD681E3465030CAF3D60A13A7907E3E707DB3C03ECC7D44FD52829E1612C133D";
      break;
    case 2:
      var_2 = "_encstr_A10D1511F0B43BC583FD165093DF2C6D2D49E101B91CC9";
      break;
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF"))
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_88190486BA32", "_encstr_B485117F6118DBED30D34D122C500353E787AF")]](var_2);
}

_id_141E9(var_0, var_1, var_2) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_1 notify("_encstr_961323DB118B671EA81B878F2FE8A3CBA7E802D3BED1C715E851BF9A8F106DC7CD40EA9A61");
  var_1 endon("_encstr_961323DB118B671EA81B878F2FE8A3CBA7E802D3BED1C715E851BF9A8F106DC7CD40EA9A61");

  if(var_2 == vehicle_occupancy_getdriverseat(var_0)) {
    level waittill("_encstr_9B1D0BC7932875276230426AA1");
    var_1 allowmovement(0);
  }
}

_id_141E8(var_0, var_1, var_2) {
  var_1 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_1 endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");
  var_0 endon("_encstr_AD75063D571AE108");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_1 notify("_encstr_B616226407DA8B393CDFB940BF4BB3F1126D566B11627F4011B330A0176F28218B5559F6");
  var_1 endon("_encstr_B616226407DA8B393CDFB940BF4BB3F1126D566B11627F4011B330A0176F28218B5559F6");

  if(scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427A(var_1)) {
    return;
  }
  if(1)
    wait 1.5;

  childthread _id_141EA(var_0, var_1, var_2);
  childthread _id_141EB(var_0, var_1, var_2, 0);
  var_3 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);

  if(isDefined(var_3._id_13E8B))
    childthread _id_141EB(var_0, var_1, var_2, 1);

  var_4 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

  if(isDefined(var_4._id_11D02))
    childthread[[var_4._id_11D02]](var_0, var_1, var_2, "_encstr_B616226407DA8B393CDFB940BF4BB3F1126D566B11627F4011B330A0176F28218B5559F6");
}

_id_141D2(var_0) {
  scripts\cp_mp\utility\vehicle_omnvar_utility::_id_1427B(var_0);
  var_0 notify("_encstr_B616226407DA8B393CDFB940BF4BB3F1126D566B11627F4011B330A0176F28218B5559F6");
}

_id_141EA(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getdriverseat(var_0);

  if(var_2 == var_3) {
    var_4 = var_0 scripts\cp_mp\vehicles\vehicle::vehiclecanfly();

    if(var_4) {
      for(;;) {
        var_5 = var_0 setstrafereverse(0);
        var_6 = var_0 setstrafereverse(2);
        var_7 = var_0 setstrafereverse(1);
        var_8 = var_0 setstrafereverse(3);

        if(abs(var_5) > 0 || abs(var_6) > 0 || abs(var_7) > 0 || abs(var_8) > 0)
          _id_141D2(var_1);

        wait 0.05;
      }
    } else {
      for(;;) {
        var_9 = var_0 setstrafereverse(4);

        if(abs(var_9) >= 0.2)
          _id_141D2(var_1);

        wait 0.05;
      }
    }
  }
}

_id_141EB(var_0, var_1, var_2, var_3) {
  var_4 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);
  var_5 = var_4._id_13E8A;

  if(istrue(var_3))
    var_5 = var_4._id_13E8B;

  if(var_0 _calloutmarkerping_isvehicleoccupiedbyenemy::unreachable_function() || var_0 _calloutmarkerping_handleluinotify_mappingdeletemarker::unresolvedcollisiontolerancesqr()) {
    return;
  }
  if(isDefined(var_5)) {
    var_6 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_0, var_5);

    if(isDefined(var_6)) {
      var_6 scripts\engine\utility::_id_143A5("_encstr_BDBA0C4757C927CA477DCC5A4EAC", "_encstr_88BE0EEC1B3B5D9D6886F837997067AC");
      _id_141D2(var_1);
    }
  }
}

vehicle_occupancy_raceplayerdeathdisconnect(var_0, var_1) {
  var_1 endon(var_1.raceendon);
  var_2 = var_0 scripts\engine\utility::_id_143B5("_encstr_AD75063D571AE108", "_encstr_8D820B49520F0EC02DDE6367EC", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  if(var_2 == "_encstr_AD75063D571AE108")
    var_1.playerdeath = 1;
  else if(var_2 == "_encstr_8D820B49520F0EC02DDE6367EC")
    var_1.playerdisconnect = 1;
  else if(var_2 == "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B")
    var_1.playerlaststand = 1;

  var_1 notify(var_1.raceendnotify);
}

vehicle_occupancy_racevehicledeath(var_0, var_1) {
  var_1 endon(var_1.raceendon);
  var_0 waittill("_encstr_AD75063D571AE108");
  var_1.vehicledeath = 1;
  var_1 notify(var_1.raceendnotify);
}

vehicle_occupancy_raceseatunavailable(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon(var_4.raceendon);

  while(isDefined(var_0)) {
    if(!vehicle_occupancy_seatisavailable(var_0, var_2, var_1)) {
      var_4.seatunavailable = 1;
      var_4 notify(var_4.raceendnotify);
      break;
    }

    waitframe();
  }
}

vehicle_occupancy_racecomplete(var_0, var_1, var_2) {
  var_2 endon(var_2.raceendon);

  if(isDefined(var_0) && isDefined(var_1)) {
    while(!istrue(var_2.enterstartcomplete) || !istrue(var_2.exitstartcomplete))
      waitframe();
  } else if(isDefined(var_0)) {
    while(!istrue(var_2.exitstartcomplete))
      waitframe();
  } else {
    while(!istrue(var_2.enterstartcomplete))
      waitframe();
  }

  var_2 notify(var_2.raceendnotify);
}

vehicle_occupancy_raceresults(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4.success))
    var_4.success = 1;

  if(var_4.immediate) {
    var_4.playerdisconnect = scripts\engine\utility::ter_op(isDefined(var_1), 0, 1);

    if(!var_4.playerdisconnect) {
      var_4.playerdeath = !var_1 scripts\cp_mp\utility\player_utility::_isalive();
      var_4.playerlaststand = istrue(var_1.inlaststand);
    }

    var_4.vehicledeath = istrue(var_0.isdestroyed);
  } else if(var_4.success) {
    if(isDefined(var_2) && !istrue(var_4.exitstartcomplete))
      var_4.success = 0;

    if(isDefined(var_3) && !istrue(var_4.enterstartcomplete))
      var_4.success = 0;

    if(istrue(var_4.vehicledeath))
      var_4.success = 0;
  } else
    return 0;

  if(isDefined(var_3)) {
    if(istrue(var_4.playerdeath) || istrue(var_4.playerlaststand) || istrue(var_4.playerdisconnect) || istrue(var_4.vehicledeath) || istrue(var_4.seatunavailable))
      var_4.success = 0;
  } else {}

  return var_4.success;
}

vehicle_occupancy_watchowner(var_0, var_1, var_2, var_3) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AC6B15D84A52BBEEF96B195AC977E742404DC8B3A1F3E7" + var_1 getentitynumber());

  if(istrue(var_2))
    var_1 waittill("_encstr_939D1243D0687BBE49BDDFE381D6D34F7508A01B");

  var_4 = scripts\engine\utility::ter_op(isDefined(var_3), var_3, 20);
  wait(var_4);
  thread vehicle_occupancy_clearowner(var_0, var_1);
}

vehicle_occupancy_watchownerjoinedteam(var_0, var_1) {
  var_1 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_857C15BB4868015AA9C5A95D3445F2C256601B7BF08345");
  var_1 scripts\engine\utility::_id_143A5("_encstr_81170C244F9CBDE72C01BB99A298", "_encstr_A2D01235B7B4B95919F5371C2B361D5847B7E49B");
  thread vehicle_occupancy_updateowner(var_0);
}

vehicle_occupancy_isplayervalidowner(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  if(level.teambased && isDefined(var_0.team)) {
    if(var_0.team != "_encstr_A7A408B9CA5D1D4E2C63" && var_1.team != var_0.team)
      return 0;
  } else if(isDefined(var_0.originalowner)) {
    if(var_1 != var_0.originalowner)
      return 0;
  }

  return 1;
}

vehicle_occupancy_animateplayer(var_0, var_1, var_2, var_3, var_4, var_5) {
  thread vehicle_occupancy_stopanimatingplayer();
  self endon("_encstr_8DC026ABA20BF3893DB2DF30BAD9257F4FF5CB679153430A33C935EC62D643C268576B39E6224A9E");
  var_6 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(!isDefined(var_6.animtag)) {
    return;
  }
  var_7 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_0 gettagorigin(var_6.animtag));
  var_7.angles = var_0 gettagangles(var_6.animtag);
  var_7 linkTo(var_0, var_6.animtag, (0, 0, 0), (0, 0, 0));
  var_7 setModel("_encstr_A7C813BBBC6B7C6BBB68413B5883D623473903130A");
  var_7 hide();
  self.animrig = var_7;

  if(isDefined(var_4) || isDefined(var_5)) {
    allowfultondropondeath(var_4, var_5);
    thread allowleaderboardstatsupdates(1);
  }

  self animscriptentervehicle();

  if(tolower(var_6.animtag) == "_encstr_A10D0BA3B27F17C327D98568E0") {
    self vehicle_setstowedweaponvisibility(0);
    self vehicle_setheldweaponvisibility(0);
  } else if(vehicle_shouldhideoccupantforseat(var_0, var_1)) {
    self vehicle_setstowedweaponvisibility(0);
    self vehicle_setheldweaponvisibility(0);
  } else {
    if(istrue(var_6.hidestowedweapon))
      self vehicle_setstowedweaponvisibility(0);

    if(istrue(var_6.hideheldweapon))
      self vehicle_setheldweaponvisibility(0);
  }

  if(!isDefined(var_6._id_13E8A)) {
    if(!isDefined(var_2))
      self setplayerangles(var_7.angles * (0, 1, 0));
    else if(tolower(var_6.animtag) == "_encstr_A10D0BA3B27F17C327D98568E0")
      self setplayerangles(var_7.angles * (0, 1, 0));
  }

  self cancelmantle();
  var_8 = undefined;
  var_9 = istrue(var_6._id_1409C);

  if(istrue(var_8))
    self playerlinktodelta(var_7, "_encstr_8E010B996FB7B6B3C1D1183343", 0, getdvarfloat("_encstr_8B532237C627F5ECB28696C636ACCA5ACAEEA136855B1CD3CE2B9CC94B32AC295A76348E", 180), getdvarfloat("_encstr_B879217F1AB2C8BBDAAB61FB98E50913C737B6CAC1E94B5FBB750B8A60C205C1218D03", 180), getdvarfloat("_encstr_85CA203EEB43667DCF1AE8B072E765F877875E3941874BC7F3D208205AFFCB978728", 180), getdvarfloat("_encstr_A517236A065D49B6698877578041AE92DBA4FE25FFBB73C75398032BB0995568B7BDBB1D51", 180), var_9, 1, 0);
  else if(var_6.viewclamps.size > 0)
    self playerlinktodelta(var_7, "_encstr_8E010B996FB7B6B3C1D1183343", 0, var_6.viewclamps["_encstr_8253060E2B5FE330"], var_6.viewclamps["_encstr_A5AD056A019C63"], var_6.viewclamps["_encstr_AC190479FF92"], var_6.viewclamps["_encstr_A146078E65FB5158DD"], var_9, 1, 0);
  else
    self playerlinktodelta(var_7, "_encstr_8E010B996FB7B6B3C1D1183343", 0, 180, 180, 180, 180, var_9, 1, 0);

  if(istrue(var_6._id_145E0)) {
    self.animrig._id_145E0 = 1;
    self setworldupreference(var_0);
  }

  var_10 = vehicle_occupancy_getanimbasename(var_0.vehiclename, var_1);

  if(vehicle_occupancy_checkvalidanimtype(var_10, var_3)) {
    self.animname = var_10;
    var_7.animname = var_10;
    var_7 useanimtree(level.scr_animtree[var_10]);
    vehicle_occupancy_watchplayeranimate(var_0, var_3, var_6.animtag);
  } else
    scripts\engine\utility::_id_143A5("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5", "_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  if(isDefined(self))
    thread vehicle_occupancy_stopanimatingplayer();

  var_7 delete();
}

vehicle_occupancy_watchplayeranimate(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8FE01132F817F3978BE5B9BEF5567FBB5B183B");

  for(;;)
    var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_B68305BA601B07", "_encstr_91360C90E16F51DD2379A28FE580")]](self, self.animrig, var_1, var_2);
}

vehicle_occupancy_stopanimatingplayer() {
  if(!isDefined(self.animrig)) {
    return;
  }
  self notify("_encstr_8DC026ABA20BF3893DB2DF30BAD9257F4FF5CB679153430A33C935EC62D643C268576B39E6224A9E");
  self vehicle_setstowedweaponvisibility(1);
  self vehicle_setheldweaponvisibility(1);
  self animscriptexitvehicle();
  self stopanimscriptsceneevent();

  if(istrue(self.animrig._id_145E0))
    self setworldupreference(undefined);

  self.animname = undefined;
  self.animrig delete();
}

allowfultondropondeath(var_0, var_1) {
  self notify("_encstr_8E87240848336A3BC0D5858E7DC81F7679B8B12268B96E933849ABBF8011277B9B50EAFAA84F");
  self overridevehicleseatanimconditionals(var_0, var_1);
}

allowleaderboardstatsupdates(var_0) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self notify("_encstr_8E87240848336A3BC0D5858E7DC81F7679B8B12268B96E933849ABBF8011277B9B50EAFAA84F");
  self endon("_encstr_8E87240848336A3BC0D5858E7DC81F7679B8B12268B96E933849ABBF8011277B9B50EAFAA84F");

  if(istrue(var_0))
    waitframe();

  self overridevehicleseatanimconditionals("_encstr_B40101", 0);
}

vehicle_occupancy_checkvalidanimtype(var_0, var_1) {
  if(!isDefined(level.scr_anim[var_0]))
    return 0;

  return isDefined(level.scr_anim[var_0][var_1]);
}

vehicle_occupancy_getanimbasename(var_0, var_1) {
  return var_0 + "_encstr_BA4C02DF" + var_1;
}

vehicle_occupancy_allowmovement(var_0, var_1) {
  if(var_1) {
    var_0.movementdisabled--;

    if(var_0.movementdisabled == 0) {
      if(isDefined(var_0.occupants)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("_encstr_82E411B6F6D9565B95E68E114B9BB026D8AC23", var_0.occupants, var_0.vehiclename);

        foreach(var_4, var_3 in var_0.occupants)
        vehicle_occupancy_allowmovementplayer(var_0, var_3, 1, var_4);
      }

      return 1;
    }
  } else {
    if(!isDefined(var_0.movementdisabled))
      var_0.movementdisabled = 0;

    var_0.movementdisabled++;

    if(var_0.movementdisabled == 1) {
      if(isDefined(var_0.occupants)) {
        scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("_encstr_82E411B6F6D9565B95E68E114B9BB026D8AC23", var_0.occupants, var_0.vehiclename);

        foreach(var_4, var_3 in var_0.occupants)
        vehicle_occupancy_allowmovementplayer(var_0, var_3, 0, var_4);
      }

      return 0;
    }
  }
}

vehicle_occupancy_clearallowmovement(var_0) {
  if(isDefined(self.occupants)) {
    foreach(var_3, var_2 in self.occupants)
    vehicle_occupancy_allowmovementplayer(1, var_2, var_3);
  }

  var_0.movementdisabled = undefined;
}

vehicle_occupancy_allowmovementplayer(var_0, var_1, var_2, var_3) {
  if(var_2) {
    if(istrue(var_1.vehicledisabledmovement)) {
      if(var_1 scripts\cp_mp\utility\player_utility::_isalive())
        var_1 scripts\common\utility::allow_movement(1);

      var_1.vehicledisabledmovement = undefined;
    }
  } else {
    var_4 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_3);

    if(isDefined(var_4.animtag) && var_4.animtag == "_encstr_A10D0BA3B27F17C327D98568E0") {
      if(!istrue(var_1.vehicledisabledmovement)) {
        if(var_1 scripts\cp_mp\utility\player_utility::_isalive()) {
          var_1 scripts\common\utility::allow_movement(0);
          var_1.vehicledisabledmovement = 1;
        }
      }
    }
  }
}

_id_141CA(var_0, var_1) {
  if(!istrue(var_1) && istrue(var_0.vehicledisabledmovement))
    var_0 scripts\common\utility::allow_movement(1);

  var_0.vehicledisabledmovement = undefined;
}

vehicle_occupancy_movementisallowed(var_0) {
  return !isDefined(var_0.movementdisabled) || var_0.movementdisabled <= 0;
}

vehicle_occupancy_getexitpositionandangles(var_0, var_1, var_2, var_3, var_4) {
  var_5 = vehicle_occupancy_getexitboundinginfo(var_0);
  var_6 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_2);
  var_7 = [];

  foreach(var_9 in var_6.exitids) {
    var_10 = vehicle_occupancy_getexitposition(var_0, var_1, var_9, var_5, var_3);

    if(isDefined(var_10)) {
      var_7[0] = var_10;
      var_11 = undefined;

      if(!isDefined(var_6.animtag) || var_6.animtag != "_encstr_A10D0BA3B27F17C327D98568E0")
        var_11 = vehicle_occupancy_getexitangles(var_0, var_1, var_9, var_4);

      if(isDefined(var_0.vehiclename) && (var_0.vehiclename == "_encstr_BDC80A5437EAD749519A6068" || var_0.vehiclename == "_encstr_83F40783ADF1D14AA3"))
        var_11 = (0, var_0.angles[1], 0);

      var_7[1] = var_11;
      return var_7;
    }
  }

  return undefined;
}

vehicle_occupancy_getexitposition(var_0, var_1, var_2, var_3, var_4) {
  if(istrue(var_3.exitsfailed[var_2]))
    return undefined;

  if(isDefined(var_3.exitpositions[var_2]))
    return var_3.exitpositions[var_2];

  var_5 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_6 = var_5.exitoffsets[var_2];
  var_7 = var_5.exitdirections[var_2];

  if(!isDefined(var_6))
    var_6 = (0, 0, 0);

  var_8 = ["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C"];

  if(getdvarint("_encstr_BDF5154B1146FF1BA041F1C37198EF2B636B81129B95F3", 1) == 0)
    var_8[var_8.size] = "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39";

  var_9 = physics_createcontents(var_8);
  var_10 = var_0 getlinkedchildren(1);

  if(!isDefined(var_10))
    var_10 = [];

  var_10[var_10.size] = var_0;
  var_11 = scripts\engine\utility::ter_op(isDefined(var_5.exittopcastoffset), var_5.exittopcastoffset, 20);
  var_12 = var_6[0];
  var_12 = clamp(var_12, var_3.offsets["_encstr_B69B0589C236B6"], var_3.offsets["_encstr_AA5606FD1AF05085"]);
  var_13 = scripts\engine\utility::ter_op(var_3.flipleftright, var_6[1] * -1, var_6[1]);
  var_13 = clamp(var_13, var_3.offsets["_encstr_8253060E2B5FE330"], var_3.offsets["_encstr_A5AD056A019C63"]);
  var_14 = (0, var_0.angles[1], 0);
  var_15 = var_0.origin;
  var_15 = var_15 + var_12 * anglesToForward(var_14);
  var_15 = var_15 + var_13 * anglestoright(var_14);
  var_16 = var_3.offsets["_encstr_A146078E65FB5158DD"] + (var_3.offsets["_encstr_AC190479FF92"] - var_3.offsets["_encstr_A146078E65FB5158DD"]) / 2;
  var_17 = var_3.offsets["_encstr_AC190479FF92"] + var_11;
  var_18 = undefined;
  var_19 = undefined;
  var_20 = var_15 + (0, 0, var_17);
  var_15 = var_15 + (0, 0, var_16);
  var_21 = "_encstr_B1EF119152CF6E90DF9AEB07F2CD583DEB5118";

  if(!var_0 tagexists(var_21))
    var_21 = "_encstr_8F1E092CC9F71178C01941";

  var_22 = var_0 gettagorigin(var_21);
  var_23 = 0;
  var_24 = physics_raycast(var_22, var_15, var_9, var_10, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

  if(isDefined(var_24) && var_24.size > 0)
    var_23 = 1;

  if(var_23)
    var_3.exitsfailed[var_2] = 1;
  else {
    var_23 = 0;
    var_24 = physics_raycast(var_15, var_20, var_9, var_10, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_24) && var_24.size > 0) {
      var_25 = 2;
      var_26 = (var_17 - var_16) * var_24[0]["_encstr_A53009A25003666B9818C6"];

      if(var_26 <= 72 + var_25)
        var_23 = 1;
      else
        var_20 = var_24[0]["_encstr_BD260953AA97E3F014279D"] - (0, 0, var_25);
    }

    if(var_23) {
      var_3.exitsfailed[var_2] = 1;
      return;
    }

    var_7 = tolower(var_7);

    if(var_3.flipleftright) {
      if(var_7 == "_encstr_A5AD056A019C63")
        var_7 = "_encstr_8253060E2B5FE330";
      else if(var_7 == "_encstr_8253060E2B5FE330")
        var_7 = "_encstr_A5AD056A019C63";
    }

    var_15 = var_20;
    var_27 = (0, 0, 0);
    var_28 = (0, 0, 0);
    var_29 = (0, 0, 0);
    var_30 = (0, 0, 0);
    var_31 = (0, 0, 0);
    var_32 = (0, 0, 0);

    if(var_7 == "_encstr_A5AD056A019C63") {
      var_27 = var_27 + (var_12, 0, 0);
      var_27 = var_27 + (0, var_3.offsets["_encstr_A5AD056A019C63"], 0);
      var_30 = var_30 + (0, 32, 0);
    } else if(var_7 == "_encstr_8253060E2B5FE330") {
      var_27 = var_27 + (var_12, 0, 0);
      var_27 = var_27 + (0, var_3.offsets["_encstr_8253060E2B5FE330"], 0);
      var_30 = var_30 + (0, -32, 0);
    } else if(var_7 == "_encstr_AA5606FD1AF05085") {
      var_27 = var_27 + (var_3.offsets["_encstr_AA5606FD1AF05085"], 0, 0);
      var_27 = var_27 + (0, var_13, 0);
      var_30 = var_30 + (32, 0, 0);
    } else if(var_7 == "_encstr_B69B0589C236B6") {
      var_27 = var_27 + (var_3.offsets["_encstr_B69B0589C236B6"], 0, 0);
      var_27 = var_27 + (0, var_13, 0);
      var_30 = var_30 + (-32, 0, 0);
    }

    var_28 = (0, 0, var_17);
    var_29 = var_27 + var_28;
    var_32 = var_30;
    var_15 = var_20;
    var_20 = var_0.origin + rotatevector(var_29 + var_32, var_14);
    var_23 = 0;
    var_24 = physics_raycast(var_15, var_20, var_9, var_10, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_24) && var_24.size > 0)
      var_23 = 1;

    if(var_23) {
      var_3.exitsfailed[var_2] = 1;
      return;
    }

    var_30 = var_30 / 2;
    var_31 = (0, 0, -72);
    var_32 = var_30 + var_31;
    var_28 = (0, 0, var_3.offsets["_encstr_AC190479FF92"]) + (0, 0, var_11);
    var_29 = var_27 + var_28;
    var_15 = var_0.origin + rotatevector(var_29 + var_32, var_14);
    var_28 = (0, 0, var_3.offsets["_encstr_A146078E65FB5158DD"]) - (0, 0, 40);
    var_29 = var_27 + var_28;
    var_31 = (0, 0, 0);
    var_32 = var_30 + var_31;
    var_20 = var_0.origin + rotatevector(var_29 + var_32, var_14);
    var_23 = 0;
    var_24 = physics_charactercast(var_15, var_20, var_1, 0, (0, 0, 0), var_9, var_10, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", "_encstr_93C411AA834B8BA9A950170FC8A381F1D32870");

    if(isDefined(var_24) && var_24.size > 0) {
      if(var_24[1])
        var_23 = 1;
      else if(var_24[0].size == 0) {
        if(!istrue(var_4))
          var_23 = 1;
        else
          var_20 = var_20 + (0, 0, 40);
      } else
        var_20 = var_24[0][0]["_encstr_8F320F36949A6929DFBB08F0C72C609FD2"];
    }

    if(var_23) {
      var_3.exitsfailed[var_2] = 1;
      return;
    }

    var_3.exitpositions[var_2] = var_20;
  }
}

vehicle_occupancy_getexitboundinginfo(var_0) {
  var_1 = undefined;

  if(isDefined(var_0.exitboundinginfo) && var_0.exitboundinginfo.timestamp == gettime())
    var_1 = var_0.exitboundinginfo;
  else {
    var_2 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);

    if(isDefined(var_2) && isDefined(var_2.exitextents)) {
      var_3 = rotatevector((var_2.exitextents["_encstr_AA5606FD1AF05085"], var_2.exitextents["_encstr_A5AD056A019C63"] * -1, var_2.exitextents["_encstr_AC190479FF92"]), var_0.angles);
      var_4 = rotatevector((var_2.exitextents["_encstr_AA5606FD1AF05085"], var_2.exitextents["_encstr_8253060E2B5FE330"], var_2.exitextents["_encstr_AC190479FF92"]), var_0.angles);
      var_5 = rotatevector((var_2.exitextents["_encstr_B69B0589C236B6"] * -1, var_2.exitextents["_encstr_A5AD056A019C63"] * -1, var_2.exitextents["_encstr_AC190479FF92"]), var_0.angles);
      var_6 = rotatevector((var_2.exitextents["_encstr_B69B0589C236B6"] * -1, var_2.exitextents["_encstr_8253060E2B5FE330"], var_2.exitextents["_encstr_AC190479FF92"]), var_0.angles);
      var_7 = rotatevector((var_2.exitextents["_encstr_AA5606FD1AF05085"], var_2.exitextents["_encstr_A5AD056A019C63"] * -1, var_2.exitextents["_encstr_A146078E65FB5158DD"] * -1), var_0.angles);
      var_8 = rotatevector((var_2.exitextents["_encstr_AA5606FD1AF05085"], var_2.exitextents["_encstr_8253060E2B5FE330"], var_2.exitextents["_encstr_A146078E65FB5158DD"] * -1), var_0.angles);
      var_9 = rotatevector((var_2.exitextents["_encstr_B69B0589C236B6"] * -1, var_2.exitextents["_encstr_A5AD056A019C63"] * -1, var_2.exitextents["_encstr_A146078E65FB5158DD"] * -1), var_0.angles);
      var_10 = rotatevector((var_2.exitextents["_encstr_B69B0589C236B6"] * -1, var_2.exitextents["_encstr_8253060E2B5FE330"], var_2.exitextents["_encstr_A146078E65FB5158DD"] * -1), var_0.angles);
      var_11 = [var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10];
      var_12 = -99999;
      var_13 = 99999;
      var_14 = -99999;
      var_15 = 99999;
      var_16 = -99999;
      var_17 = 99999;
      var_18 = (0, var_0.angles[1], 0);

      foreach(var_20 in var_11) {
        var_20 = rotatevectorinverted(var_20, var_18);

        if(var_20[0] > var_12)
          var_12 = var_20[0];

        if(var_20[0] < var_13)
          var_13 = var_20[0];

        if(var_20[1] < var_15)
          var_15 = var_20[1];

        if(var_20[1] > var_14)
          var_14 = var_20[1];

        if(var_20[2] > var_16)
          var_16 = var_20[2];

        if(var_20[2] < var_17)
          var_17 = var_20[2];
      }

      var_1 = spawnStruct();
      var_0.exitboundinginfo = var_1;
      var_1 = var_1;
      var_1.vehicle = var_0;
      var_1.timestamp = gettime();
      var_1.offsets["_encstr_AA5606FD1AF05085"] = var_12;
      var_1.offsets["_encstr_B69B0589C236B6"] = var_13;
      var_1.offsets["_encstr_A5AD056A019C63"] = var_14;
      var_1.offsets["_encstr_8253060E2B5FE330"] = var_15;
      var_1.offsets["_encstr_AC190479FF92"] = var_16;
      var_1.offsets["_encstr_A146078E65FB5158DD"] = var_17;
      var_1.exitsfailed = [];
      var_1.exitpositions = [];
      var_1.orientedboxpoints = [];
      var_1.unorientedboxpoints = [];
      var_1.flipleftright = abs(angleclamp180(var_0.angles[2])) > 90;
      var_1 thread vehicle_cleanupexitboundinginfo();
    }
  }

  return var_1;
}

vehicle_cleanupexitboundinginfo() {
  waitframe();

  if(isDefined(self.vehicle)) {
    return;
  }
  if(!isDefined(self.vehicle.exitboundinginfo)) {
    return;
  }
  if(self.vehicle.exitboundinginfo.timestamp != self.timestamp) {
    return;
  }
  self.vehicle.exitboundinginfo = undefined;
}

vehicle_occupancy_getexitangles(var_0, var_1, var_2, var_3) {
  if(istrue(level.playerlocationtriggerexit)) {
    var_4 = (0, var_0.angles[1], 0);
    return var_4;
  }

  var_5 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_6 = vehicle_occupancy_getexitboundinginfo(var_0);
  var_7 = var_6.exitpositions[var_2];
  var_8 = undefined;
  var_9 = 0;

  if(istrue(var_3)) {
    var_8 = var_0.origin + rotatevector(var_5.exitoffsets[var_2], var_0.angles);
    var_9 = 1;
  }

  if(!isDefined(var_8))
    var_8 = var_1 getvieworigin() + anglesToForward(var_1 getplayerangles()) * 550;

  var_10 = undefined;

  if(istrue(var_3))
    var_10 = var_7 + (0, 0, 22);
  else
    var_10 = var_7 + (0, 0, 60);

  var_11 = vectorNormalize(var_8 - var_10);

  if(!var_9) {
    var_12 = physics_createcontents(["_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3"]);
    var_13 = physics_raycast(var_10, var_10 + var_11 * 300, var_12, undefined, 0, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11", 1);

    if(isDefined(var_13) && var_13.size > 0) {
      var_14 = var_13[0]["_encstr_850E077B0BF30318B9"];
      var_15 = 0;

      if(isDefined(var_14)) {
        var_16 = var_0 getlinkedchildren(1);

        if(!isDefined(var_16))
          var_16 = [];

        var_16[var_16.size] = var_0;

        foreach(var_18 in var_16) {
          if(var_14 == var_18) {
            var_15 = 1;
            break;
          }
        }
      }

      if(var_15) {
        var_20 = var_5.exitdirections[var_2];
        var_4 = (0, var_0.angles[1], 0);

        if(var_20 == "_encstr_A5AD056A019C63" || var_20 == "_encstr_8253060E2B5FE330")
          var_21 = anglestoright(var_4);
        else
          var_21 = anglesToForward(var_4);

        var_11 = var_11 - var_21 * vectordot(var_11, var_21);
      }
    }
  }

  var_22 = vectortoangles(var_11);
  var_22 = (clamp(var_22[0], -12, 12), var_22[1], 0);
  return var_22;
}

vehicle_occupancy_getfallbackexitpositionandangles(var_0, var_1, var_2) {
  var_3 = vectordot((0, 0, 1), anglestoup(var_0.angles)) < 0;
  var_4 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_5 = undefined;
  var_6 = undefined;

  if(var_3) {
    if(!isDefined(var_4.exitfallbackoffsetinverted))
      return undefined;

    var_5 = var_4.exitfallbackoffsetinverted;
    var_6 = anglestoup(var_0.angles) * -1;
  } else {
    if(!isDefined(var_4.exitfallbackoffset))
      return undefined;

    var_5 = var_4.exitfallbackoffset;
    var_6 = anglestoup(var_0.angles);
  }

  var_7 = vehicle_occupancy_getexitcastcontents();
  var_8 = vehicle_occupancy_getexitcastignorelist(var_0);
  var_9 = var_0.origin + var_6 * var_5;
  var_10 = physics_getclosestpointtocapsule(var_9, 16, 36, (0, 0, 0), 0, var_7, var_8, "_encstr_838C158FAC235780CB6F10381FF25AD76A558896473B11");

  if(!isDefined(var_10) || var_10.size <= 0)
    return [var_9, var_0.angles * (0, 1, 0)];
  else
    return undefined;
}

vehicle_occupancy_findplayerexit(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_0) || isDefined(var_3) || istrue(var_4.playerdeath) && !istrue(var_4.playerlaststand))
    return 1;

  var_5 = vehicle_occupancy_getleveldataforvehicle(var_1.vehiclename);
  var_6 = istrue(var_5.allowairexit) || istrue(var_4.allowairexit) || !var_1 scripts\cp_mp\vehicles\vehicle_tracking::_issuspendedvehicle() && !var_1 vehicle_isonground();
  var_7 = vehicle_occupancy_getexitpositionandangles(var_1, var_0, var_2, var_6, var_4.playerlaststand);

  if(isDefined(var_7)) {
    var_4.exitposition = var_7[0];
    var_4.exitangles = var_7[1];
    return 1;
  } else {
    if(istrue(var_5.onprematchstarted2)) {
      var_8 = var_1 physics_getentitycenterofmass();
      var_9 = var_0 getboundsmidpoint();
      var_4.exitposition = var_8["_encstr_AC04092555EB696184F1D9"] - var_9;
      var_4.exitangles = undefined;
      return 1;
    }

    return 0;
  }
}

vehicle_occupancy_moveplayertoexit(var_0, var_1, var_2) {
  if(!isDefined(var_0) || istrue(var_2.playerdeath) && !istrue(var_2.playerlaststand) || isDefined(var_1))
    return 1;

  if(isDefined(var_2.exitposition)) {
    var_0 unlink();
    var_0 dontinterpolate();
    var_0 setOrigin(var_2.exitposition, 1, 1);
    var_0 setstance("_encstr_A5AD069B231F0BAF");

    if(isDefined(var_2.exitangles))
      var_0 setplayerangles(var_2.exitangles);

    return 1;
  } else
    return 0;
}

vehicle_occupancy_getexitcastcontents() {
  return physics_createcontents(["_encstr_959C16B3A1D35B0178338E95889855C22DEF872707F122C4", "_encstr_9911163886E537A5B1CD1BBDB98EACB91DCDFA9DD82CE69B", "_encstr_918816830DBCB9B4C6CDC6B7B98ECAB93ACDAFEE0B1D2B39", "_encstr_BDF91458130AEF44DF883AF28819BF634306EFD33A52", "_encstr_A9D615B373CA8B4BDEFABEFFE0EB656594733F2BF3DBD3", "_encstr_BDD01838A1F2E62DD8371BB79BA3B273A3B97DD956435AB1B1CA", "_encstr_8E411B07D05E9B5AB1E6C6B7DCD1ACB947CD7D831B162F599CB136A51C"]);
}

vehicle_occupancy_getexitcastignorelist(var_0) {
  var_1 = vehicle_occupancy_getleveldataforvehicle(var_0.vehiclename);
  var_2 = [var_0];

  if(isDefined(var_1.exitignorelistcallback))
    var_2 = [[var_1.exitignorelistcallback]](var_0);

  return var_2;
}

vehicle_occupancy_animtagtoexittag(var_0) {
  var_0 = tolower(var_0);
  var_1 = getsubstr(var_0, 8, var_0.size);
  return "_encstr_AA6F0EF167D1CEA31D2F9CC071EBAAA3" + var_1;
}

vehicle_occupancy_watchmovefeedback(var_0) {
  self endon("_encstr_AD75063D571AE108");

  for(;;) {
    vehicle_occupancy_updatemovefeedback(var_0);
    waitframe();
  }
}

vehicle_occupancy_updatemovefeedback(var_0) {
  var_1 = vehicle_occupancy_getseatoccupant(self, var_0);
  var_2 = vehicle_occupancy_getalloccupants(self);

  if(isDefined(var_1)) {
    var_3 = var_1 getnormalizedmovement()[0];

    if(abs(var_3) > 0.15) {
      foreach(var_5 in var_2) {
        if(var_5 scripts\cp_mp\utility\player_utility::_isalive())
          var_5 vehicle_occupancy_startmovefeedbackforplayer();
      }

      return;
    }

    foreach(var_5 in var_2) {
      if(var_5 scripts\cp_mp\utility\player_utility::_isalive())
        var_5 vehicle_occupancy_stopmovefeedbackforplayer();
    }

    return;
  } else if(isDefined(var_2)) {
    foreach(var_5 in var_2) {
      if(var_5 scripts\cp_mp\utility\player_utility::_isalive())
        var_5 vehicle_occupancy_stopmovefeedbackforplayer();
    }
  }
}

vehicle_occupancy_startmovefeedbackforplayer() {
  if(istrue(self.vehiclemoveshakeenabled)) {
    return;
  }
  self.vehiclemoveshakeenabled = 1;
  self setscriptablepartstate("_encstr_8A12111ED568C786817898B288FBF2BB214A95", "_encstr_97B60827B82BC1CB7B2F", 0);
}

vehicle_occupancy_stopmovefeedbackforplayer() {
  if(!istrue(self.vehiclemoveshakeenabled)) {
    return;
  }
  self.vehiclemoveshakeenabled = undefined;
  self setscriptablepartstate("_encstr_8A12111ED568C786817898B288FBF2BB214A95", "_encstr_A7A408B9CA5D1D4E2C63", 0);
}

vehicle_occupancy_updatedamagefeedback(var_0) {
  var_1 = vehicle_occupancy_getleveldataforvehicle(self.vehiclename);

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0.damage) || var_0.damage <= 0) {
    return;
  }
  if(!isDefined(var_0.meansofdeath)) {
    return;
  }
  var_2 = undefined;
  var_3 = undefined;

  switch (var_0.meansofdeath) {
    case "_encstr_A7E3151D0854967FE86A69475ED92EC387C0A129A1BFE5":
    case "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421":
    case "_encstr_911B0C7DA090E9A7F799FD50DD48":
    case "_encstr_84670F0D974DCF124E3F7A931851A1FB9F":
    case "_encstr_950A12A99E887D284AD42A7A31D748AA98C4A215":
    case "_encstr_A68211A30F035922EF7BF1F55F0E4B59EB2BB9":
      var_2 = "_encstr_8FA906CC80677438";
      var_3 = var_1.damagefeedbackgrouplight;
      break;
    case "_encstr_B45C0E2DFF41B17F437FB870E733FBFF":
    case "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B":
    case "_encstr_A1ED0BA9FF84562B60BA073E83":
      var_2 = "_encstr_B846067B175AA56A";
      var_3 = var_1.damagefeedbackgroupheavy;
      break;
  }

  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3) || var_3 == "_encstr_8BBA05185F8B99") {
    return;
  }
  var_4 = [];

  if(var_3 == "_encstr_9AE307B956E345D0AB") {
    foreach(var_7, var_6 in var_1.seatdata) {
      if(!isDefined(var_6.animtag)) {
        continue;
      }
      if(var_6.animtag == "_encstr_A10D0BA3B27F17C327D98568E0") {
        var_4 = [vehicle_occupancy_getseatoccupant(self, var_7)];
        break;
      }
    }
  } else if(var_3 == "_encstr_AF1904A7F929")
    var_4 = vehicle_occupancy_getalloccupants(self);

  if(!isDefined(var_4) || var_4.size == 0) {
    return;
  }
  foreach(var_9 in var_4) {
    if(!isDefined(var_9)) {
      continue;
    }
    if(!var_9 scripts\cp_mp\utility\player_utility::_isalive()) {
      continue;
    }
    if(var_2 == "_encstr_8FA906CC80677438") {
      var_9 thread vehicle_occupancy_lightdamagefeedbackforplayer();
      continue;
    }

    if(var_2 == "_encstr_B846067B175AA56A")
      var_9 thread vehicle_occupancy_heavydamagefeedbackforplayer();
  }
}

vehicle_occupancy_lightdamagefeedbackforplayer() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_848431C3D323827368A9292D81F8ADCB0F6D2F773FDE9A2D385315B439F8D4C0D793AF9723E4F2E57879563ED011042AB32B7B");

  if(!isDefined(self.vehiclelightdamagefeedbackid))
    self.vehiclelightdamagefeedbackid = 1;

  self setscriptablepartstate("_encstr_84B1189DB286D236B1B211B0B516D956A90DC2B595894B9D438E", "_encstr_930B07BB1B6B3854FF" + self.vehiclelightdamagefeedbackid, 0);
  self.vehiclelightdamagefeedbackid = 1 + scripts\engine\utility::mod(self.vehiclelightdamagefeedbackid + 1, 3);
  wait 0.15;
  thread vehicle_occupancy_clearlightdamagefeedbackplayer();
}

vehicle_occupancy_clearlightdamagefeedbackplayer() {
  self notify("_encstr_848431C3D323827368A9292D81F8ADCB0F6D2F773FDE9A2D385315B439F8D4C0D793AF9723E4F2E57879563ED011042AB32B7B");
  self setscriptablepartstate("_encstr_84B1189DB286D236B1B211B0B516D956A90DC2B595894B9D438E", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self.vehiclelightdamagefeedbackid = undefined;
}

vehicle_occupancy_heavydamagefeedbackforplayer() {
  self endon("_encstr_8D820B49520F0EC02DDE6367EC");
  self endon("_encstr_BEA23180A7582DEFE247B8B8DECA1BEBB973A060E7EBF8AB5AAA3BB5B6B34B15E1D7481897A6115332D6974E0CA95979516F58");

  if(!isDefined(self.vehicleheavydamagefeedbackid))
    self.vehicleheavydamagefeedbackid = 1;

  self setscriptablepartstate("_encstr_BE3E18DD55346096934A9D21D27F5CC802A07B7FFD9458EF93A3", "_encstr_930B07BB1B6B3854FF" + self.vehicleheavydamagefeedbackid, 0);
  self.vehicleheavydamagefeedbackid = 1 + scripts\engine\utility::mod(self.vehicleheavydamagefeedbackid + 1, 3);
  wait 0.3;
  thread vehicle_occupancy_clearheavydamagefeedbackplayer();
}

vehicle_occupancy_clearheavydamagefeedbackplayer() {
  self notify("_encstr_BEA23180A7582DEFE247B8B8DECA1BEBB973A060E7EBF8AB5AAA3BB5B6B34B15E1D7481897A6115332D6974E0CA95979516F58");
  self setscriptablepartstate("_encstr_BE3E18DD55346096934A9D21D27F5CC802A07B7FFD9458EF93A3", "_encstr_A7A408B9CA5D1D4E2C63", 0);
  self.vehicleheavydamagefeedbackid = undefined;
}

vehicle_occupancy_cleardamagefeedbackforplayer() {
  vehicle_occupancy_clearlightdamagefeedbackplayer();
  vehicle_occupancy_clearheavydamagefeedbackplayer();
}

vehicle_occupancy_giveturret(var_0, var_1, var_2, var_3) {
  if(isDefined(var_2.raceendon))
    var_2 endon(var_2.raceendon);

  if(istrue(var_3))
    childthread vehicle_occupancy_givetaketurrettimeout(var_2, 1.5);

  if(!var_0 hasweapon(var_1))
    var_0 scripts\cp_mp\utility\inventory_utility::_giveweapon(var_1);

  var_4 = undefined;

  if(var_0 scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_1))
    var_4 = 1;
  else {
    thread _id_141D3(var_0, var_2);
    var_4 = var_0 scripts\cp_mp\utility\inventory_utility::domonitoredweaponswitch(var_1, 1, 1);
  }

  _id_141CB(var_0);

  if(isDefined(var_2) && isDefined(var_4) && !var_4) {
    var_2.success = 0;
    var_2 notify(var_2.raceendnotify);
  }
}

vehicle_occupancy_taketurret(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_3.raceendon))
    var_3 endon(var_3.raceendon);

  if(istrue(var_4))
    childthread vehicle_occupancy_givetaketurrettimeout(var_3, 1.5);

  if(var_0 hasweapon(var_2)) {
    var_6 = undefined;
    thread _id_141CB(var_0);

    if(var_0 scripts\cp_mp\utility\inventory_utility::isswitchingtoweaponwithmonitoring(var_2)) {
      var_0 scripts\cp_mp\utility\inventory_utility::abortmonitoredweaponswitch(getcompleteweaponname(var_2));
      var_6 = 1;
    } else {
      if(isDefined(var_5))
        var_7 = scripts\cp_mp\vehicles\vehicle::_id_14191(var_1, var_5);
      else
        var_7 = scripts\cp_mp\vehicles\vehicle::_id_14192(var_1, var_2);

      if(isDefined(var_7))
        var_0 controlturretoff(var_7);

      if(var_0 hasweapon(var_2)) {
        var_8 = var_0 scripts\cp_mp\utility\inventory_utility::iscurrentweapon(var_2);

        if(var_8) {
          var_0 scripts\cp_mp\utility\inventory_utility::_takeweapon(var_2);
          var_0 thread scripts\cp_mp\utility\inventory_utility::forcevalidweapon();
        } else
          var_0 thread scripts\cp_mp\utility\inventory_utility::getridofweapon(var_2, 1);
      }

      var_6 = 1;
    }

    if(isDefined(var_6) && !var_6) {
      var_3.success = 0;
      var_3 notify(var_3.raceendnotify);
    }
  }
}

vehicle_occupancy_givetaketurrettimeout(var_0, var_1) {
  wait(var_1);
  var_0.success = 0;
  var_0 notify(var_0.raceendnotify);
}

_id_141D3(var_0, var_1) {
  var_0 endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  var_0 notify("_encstr_A7D02B537D0142BB50C8974FE069651BEB379E08C8B57AD2D9E0BF6F182327822724E4C34EF150048DC8079708");
  var_0 endon("_encstr_A7D02B537D0142BB50C8974FE069651BEB379E08C8B57AD2D9E0BF6F182327822724E4C34EF150048DC8079708");

  if(var_0 scripts\common\utility::is_weapon_switch_allowed()) {
    return;
  }
  var_0 enableweaponswitch();
  var_1 waittill(var_1.raceendon);
  thread _id_141CB(var_0);
}

_id_141CB(var_0) {
  var_0 notify("_encstr_A7D02B537D0142BB50C8974FE069651BEB379E08C8B57AD2D9E0BF6F182327822724E4C34EF150048DC8079708");

  if(var_0 scripts\common\utility::is_weapon_switch_allowed())
    var_0 enableweaponswitch();
  else
    var_0 disableweaponswitch();
}

vehicle_occupancy_ejectalloccupants(var_0) {
  var_1 = vehicle_occupancy_getallvehicleseats(var_0);

  foreach(var_3 in var_1) {
    var_4 = vehicle_occupancy_getseatoccupant(var_0, var_3);

    if(isDefined(var_4)) {
      var_5 = spawnStruct();
      var_5.allowairexit = 1;
      var_5.onprematchfadedone2 = "_encstr_B6690C29C959A78955E4A21449B2";
      thread vehicle_occupancy_exit(var_0, var_3, var_4, var_5, 1);
    }
  }
}

vehicle_occupancy_getoccupantrestrictions() {
  return ["_encstr_B13D076BED70539F23", "_encstr_922406F1A6FD5E05", "_encstr_92100762872552A643", "_encstr_919007AA5148539DA0", "_encstr_83230A7F177D22B4413B75BA", "_encstr_86A00B412DA32D63B72F90F05F", "_encstr_962F0CB3560DD236D8CAD7576E59", "_encstr_84B60AC693C2E8B27D5DCDCA", "_encstr_872F11E872F36D70CA0FA99959F608A19F1A63", "_encstr_880811DD703AAFCB14FF28383F59A3C902DE42", "_encstr_B24E11E8C140668309413A234F0BE9176B9185"];
}

_id_141D8() {
  return ["_encstr_BD70131B23FFDB0C38B31C09C788D34B105E93E349", "_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_A6C7065BACB1CA95", "_encstr_AF4D07932B1BDE5846", "_encstr_96EB0B0BABD1DB39598DF616C8", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_A91E0E983FF591A981B7D5E64B1BA599"];
}

vehicle_occupancy_getdriverrestrictions() {
  return ["_encstr_BD70131B23FFDB0C38B31C09C788D34B105E93E349", "_encstr_A1AF107FB41FA3596A69773FD20858C85627", "_encstr_A6C7065BACB1CA95", "_encstr_88780599B4E495", "_encstr_AF4D07932B1BDE5846", "_encstr_96EB0B0BABD1DB39598DF616C8", "_encstr_A60F0E030703D180A0665F43BA558F28", "_encstr_A91E0E983FF591A981B7D5E64B1BA599"];
}

vehicle_occupancy_getcombatpassengerrestrictions() {
  return ["_encstr_914C0EDDB20B837BB97D38D2365BAB83"];
}

vehicle_occupancy_getcombatcabpassengerrestrictions() {
  var_0 = vehicle_occupancy_getcombatpassengerrestrictions();
  return var_0;
}

vehicle_occupancy_getpassivepassengerrestrictions() {
  return vehicle_occupancy_getdriverrestrictions();
}

vehicle_occupancy_getturretpassengerrestrictions() {
  var_0 = vehicle_occupancy_getcombatpassengerrestrictions();
  var_0[var_0.size] = "_encstr_A91E0E983FF591A981B7D5E64B1BA599";
  var_0[var_0.size] = "_encstr_A1AF107FB41FA3596A69773FD20858C85627";
  return scripts\engine\utility::array_remove_duplicates(var_0);
}

vehicle_occupancy_disablefirefortime(var_0, var_1, var_2) {
  var_0 endon("_encstr_8D820B49520F0EC02DDE6367EC");
  var_0 notify("_encstr_99FD25AB9970591A11EB67AFCF4EA398D0CD66F076A81153FFFD939F7D639BC5B188DA332888A5");
  var_0 endon("_encstr_99FD25AB9970591A11EB67AFCF4EA398D0CD66F076A81153FFFD939F7D639BC5B188DA332888A5");

  if(!istrue(self.vehicledisablefire)) {
    var_0.vehicledisablefire = 1;
    var_0 scripts\common\utility::allow_fire(0, "_encstr_BA2313BB8960492A21DB1BA71F5FC2B4E075F40221");
  }

  if(!isDefined(var_0.vehicledisablefireendtime) || !istrue(var_2))
    var_0.vehicledisablefireendtime = gettime() + var_1;

  while(isDefined(var_0.vehicledisablefireendtime) && gettime() < var_0.vehicledisablefireendtime)
    wait 0.05;

  thread vehicle_occupancy_cleardisablefirefortime(var_0);
}

vehicle_occupancy_cleardisablefirefortime(var_0, var_1) {
  var_0 notify("_encstr_99FD25AB9970591A11EB67AFCF4EA398D0CD66F076A81153FFFD939F7D639BC5B188DA332888A5");

  if(isDefined(var_0.vehicledisablefire)) {
    if(!istrue(var_1))
      var_0 scripts\common\utility::allow_fire(1, "_encstr_BA2313BB8960492A21DB1BA71F5FC2B4E075F40221");
  }

  var_0.vehicledisablefire = undefined;
  var_0.vehicledisablefireendtime = undefined;
}

_id_141F8(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8A400F0967525579992D736F147108197A"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8A400F0967525579992D736F147108197A")]](var_0, var_1, var_2);
}

_id_141D9(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B4D20FB396CEB229D2EDA39A43A5ACB123"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B4D20FB396CEB229D2EDA39A43A5ACB123")]](var_0, var_1, var_2);
}

_id_141F9(var_0, var_1, var_2) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8FE511D38BB50F93B83DC9C75921DC776D60BA"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8FE511D38BB50F93B83DC9C75921DC776D60BA")]](var_0, var_1, var_2);
}

_id_141DB(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B2BD0CE83AB77BDD3FB3F3EEB97F"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B2BD0CE83AB77BDD3FB3F3EEB97F")]](var_0, var_1, var_2, var_3);
}

_id_141F5(var_0, var_1, var_2, var_3) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8ACA0C0BA97BA38F37E312B8891C"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_8ACA0C0BA97BA38F37E312B8891C")]](var_0, var_1, var_2, var_3);
}

vehicle_occupancy_registersentient(var_0) {
  if(isDefined(var_0.sentientdisabled) && var_0.sentientdisabled > 0) {
    return;
  }
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_A12B11F0F70770BF13177E966FCAC9386D4348"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_A12B11F0F70770BF13177E966FCAC9386D4348")]](var_0);
}

vehicle_occupancy_unregistersentient(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_ACBC13F54833EFAFA3F0230AC0EF678BABA36D96DD"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_ACBC13F54833EFAFA3F0230AC0EF678BABA36D96DD")]](var_0);
}

vehicle_occupancy_issentient(var_0) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B6A90B5A6EA9CA7347B495B91D"))
    return [[scripts\cp_mp\utility\script_utility::getsharedfunc("_encstr_A6EF12CD450450A6A35AEE10C26765509ED66F6B", "_encstr_B6A90B5A6EA9CA7347B495B91D")]](var_0);
}

vehicle_occupancy_allowsentient(var_0) {
  if(var_0) {
    self.sentientdisabled--;

    if(self.sentientdisabled == 0)
      vehicle_occupancy_registersentient(self);
  } else {
    if(!isDefined(self.sentientdisabled))
      self.sentientdisabled = 0;

    self.sentientdisabled++;

    if(self.sentientdisabled == 1)
      vehicle_occupancy_unregistersentient(self);
  }
}

_id_141E7(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.seatid = var_1;
  var_3 = vehicle_occupancy_getleveldataforseat(var_0.vehiclename, var_1);

  if(isDefined(var_3.animtag)) {
    var_2.origin = var_0 gettagorigin(var_3.animtag);
    var_2.angles = var_0 gettagangles(var_3.animtag);
  } else {
    var_2.origin = var_0.origin;
    var_2.angles = var_0.angles;
  }

  return var_2;
}

vehicle_occupancy_linkseatcorpse(var_0, var_1, var_2) {
  var_3 = vehicle_occupancy_getleveldataforseat(var_1.vehiclename, var_2);

  if(isDefined(var_3.animtag)) {
    var_0 enablelinkTo();
    var_0 linkTo(var_1, var_3.animtag);
  } else {
    var_0 enablelinkTo();
    var_0 linkTo(var_1);
  }
}

vehicle_occupancy_assignseatcorpse(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1.corpses))
    var_1.corpses = [];

  vehicle_occupancy_deleteseatcorpse(var_1, var_2, 0);
  var_1.corpses[var_2] = var_0;

  if(!var_3)
    var_0.matchdata_logmultikill = 1;
}

_id_141CC(var_0, var_1, var_2) {
  if(isDefined(var_1.corpses) && isDefined(var_1.corpses[var_2]))
    var_1.corpses[var_2] = undefined;

  var_0.matchdata_logmultikill = undefined;
}

vehicle_occupancy_deleteseatcorpse(var_0, var_1, var_2) {
  if(isDefined(var_0.corpses) && isDefined(var_0.corpses[var_1])) {
    var_3 = var_0.corpses[var_1];

    if(isDefined(var_3)) {
      if(!istrue(var_3.matchdata_logmultikill) || !var_2) {
        var_0.corpses[var_1] delete();
        var_0.corpses[var_1] = undefined;
      }
    }
  }
}

vehicle_occupancy_deleteseatcorpses(var_0) {
  if(isDefined(var_0.corpses)) {
    foreach(var_2 in var_0.corpses) {
      if(isDefined(var_2))
        var_2 delete();
    }
  }

  var_0.corpses = undefined;
}

_id_141C6(var_0, var_1) {
  if(istrue(var_0.isdestroyed) || !isDefined(var_0.occupants))
    var_0._id_1287D = undefined;
  else {
    if(var_1) {
      var_0._id_1287D--;
      return;
    }

    if(!isDefined(var_0._id_1287D))
      var_0._id_1287D = 0;

    var_0._id_1287D++;
  }
}

_id_141C7(var_0) {
  if(istrue(var_0.isdestroyed) || !isDefined(var_0.occupants))
    return 0;

  if(isDefined(var_0._id_1287D) && var_0._id_1287D > 0)
    return 0;

  return 1;
}

vehicle_occupancy_generateseatswitcharray(var_0, var_1) {
  var_2 = [];
  var_3 = 0;
  var_4 = 0;

  for(;;) {
    if(!var_3) {
      if(var_0 == var_1[var_4])
        var_3 = 1;
    } else {
      var_4 = scripts\engine\utility::mod(var_4, var_1.size);

      if(var_0 == var_1[var_4]) {
        break;
      }

      var_2[var_2.size] = var_1[var_4];
    }

    var_4++;
  }

  return var_2;
}

vehicle_occupancy_killoccupants(var_0, var_1) {
  if(!isDefined(var_1.inflictor)) {
    switch (var_1.meansofdeath) {
      case "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421":
      case "_encstr_911B0C7DA090E9A7F799FD50DD48":
      case "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B":
      case "_encstr_84670F0D974DCF124E3F7A931851A1FB9F":
        if(isDefined(var_0.killcament))
          var_0.killcament delete();

        var_0.killcament = var_1.inflictor;
        var_1.inflictor = var_0;
    }
  }

  if(!isDefined(var_1.inflictor))
    var_1.inflictor = undefined;

  var_2 = var_1.meansofdeath;

  if(var_2 == "_encstr_84670F0D974DCF124E3F7A931851A1FB9F")
    var_2 = "_encstr_8E39168B5F1FF12F4B08BC45D08B6BA1E7F73F293436C91B";
  else if(var_2 == "_encstr_911B0C7DA090E9A7F799FD50DD48")
    var_2 = "_encstr_950B13A99E887DA39251270A1151EBA6A0C4A0D421";

  var_3 = vehicle_occupancy_getallvehicleseats(self);

  foreach(var_5 in var_3) {
    var_6 = vehicle_occupancy_getseatoccupant(self, var_5);

    if(isDefined(var_6) && var_6 scripts\cp_mp\utility\player_utility::_isalive()) {
      var_7 = var_1.attacker;

      if(scripts\common\utility::iscp()) {
        var_6.shouldskipdeathsshield = 1;

        if(!isDefined(var_7)) {
          if(isDefined(var_1.inflictor))
            var_7 = var_1.inflictor;
        }

        if(!isDefined(var_7))
          var_7 = var_6;

        if(isDefined(var_7) && isDefined(var_7.team)) {
          if(var_7.team == var_6.team) {
            vehicle_occupancy_exit(self, var_5, var_6, undefined, 1);
            var_6.skipvehiclespashdamage = 1;
            continue;
          }
        }
      } else if(!isDefined(var_7) || !istrue(scripts\cp_mp\utility\player_utility::playersareenemies(var_7, var_6)))
        var_7 = var_6;

      var_6.donotmodifydamage = 1;
      var_8 = 0;

      if(level.gametype == "_encstr_B607038AAB" && istrue(var_6.isjuggernaut)) {
        if(isDefined(var_6.juggcontext.juggconfig._id_14232) && var_6.health > var_6.juggcontext.juggconfig._id_14232)
          var_8 = 1;
      }

      if(!istrue(var_8)) {
        var_9 = scripts\engine\utility::ter_op(isent(var_7), var_7, undefined);
        var_6 dodamage(var_6.maxhealth, var_0.origin, var_9, var_1.inflictor, var_2, var_1.objweapon, "_encstr_952B0C65857BBFB80F9FC0B8A75A");

        if(isDefined(level._id_14254))
          var_6 thread[[level._id_14254]]();
      }

      var_6.donotmodifydamage = undefined;
      thread vehicle_occupancy_exit(var_0, var_5, var_6, undefined, 1);
    }
  }

  vehicle_occupancy_deleteseatcorpses(var_0);
}

vehicle_occupancy_initdebug() {
  var_0 = vehicle_occupancy_getleveldata();
  var_0.debuginstances = [];
}