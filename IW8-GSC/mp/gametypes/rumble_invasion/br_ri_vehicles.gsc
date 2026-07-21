/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\rumble_invasion\br_ri_vehicles.gsc
***********************************************************/

_id_14216(var_0) {
  var_1 = spawnStruct();
  var_2 = scripts\engine\utility::getStruct("_encstr_B89E181B165D9BD843EBD87B322B7D914EDE1C7DC45D8E47DBCD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1.origin = var_2.origin + (0, 0, 50000);

  if(isDefined(var_0))
    var_2.origin = var_0;

  var_3 = _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_14263(var_1);

  if(isDefined(var_3))
    level thread _encstr_87A32ED71B534923C196FD657F0F2A09D8A843473069AB1EC52EF99FEFA3C2C4E2689F57E823E5820F447ED2606FFB9B::_id_13DE4(var_3, var_2.origin, var_3.angles, 1);
}

_id_13570() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = 0;

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    if(getdvarint("_encstr_824722B2BE0597689196AA09813F0D692BA88803E183B0802FDB404FFB08BD75D17BAE02", 1) == 1)
      var_0 = 1;
  } else
    var_0 = 1;

  if(!var_0) {
    return;
  }
  if(getdvarint("_encstr_8E531AB30EF3C72A6351E2CAA04B23C3EBF83E5D13FECFF21B784AA3", 0)) {
    _encstr_AD9C2570679AC8019B0A5871A24667B1FD17D0A89325434722727884FF0AA339548F60AA27EB19::spawninitialvehicles();
    return;
  }

  if(!isDefined(level.start_reach_exhaust_waste._id_12E2C._id_141BE)) {
    return;
  }
  foreach(var_4, var_2 in level.start_reach_exhaust_waste._id_12E2C._id_141BE) {
    var_3 = spawnStruct();
    var_3.ref = var_2[0];
    var_3.origin = var_2[1];
    var_3.angles = var_2[2];
    var_3._id_13A22 = var_4;
    level thread _id_1421B(var_3);
  }
}

_id_12B07(var_0) {
  level.start_reach_exhaust_waste.spawned_vehicles[var_0._id_1352E._id_13A22] = var_0;
}

lasttuttxt(var_0) {
  level.start_reach_exhaust_waste.spawned_vehicles[var_0._id_1352E._id_13A22] = undefined;
}

_id_1421B(var_0) {
  if(var_0.ref == "_encstr_87680AB085AF1DBA93C92B1D") {
    if(isDefined(level.arenaflag_setenabled)) {
      var_1 = var_0[[level.arenaflag_setenabled]]();

      if(isDefined(var_1)) {
        var_1._id_1352E = var_0;
        var_2 = var_0.origin;
        var_2 = var_2 - anglesToForward(var_0.angles) * 5;
        var_3 = easepower("_encstr_81C32AEC2B0D7D9BD0AFB62DD8AF8DB9197D3A5D279C59D1D75C5DC232AFB016EBEED3BE36369683BE8CF29B", var_2, var_0.angles);
        var_3 setscriptablepartstate("_encstr_BA9105D8C6D283", "_encstr_A18008BD35E222F01BD0");
        var_1.clip = var_3;
      } else {}
    }
  } else {
    var_4 = scripts\cp_mp\vehicles\vehicle_spawn::vehicle_spawn_spawnVehicle(var_0.ref, var_0);

    if(isDefined(var_4)) {
      var_4._id_1352E = var_0;

      if(scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
        _id_12B07(var_4);
        var_4 thread vehicle_death_watcher();
        var_4 thread _id_141C5();
      }
    } else {}
  }
}

_id_1420B(var_0) {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  wait 45.0;
  _id_1421B(var_0);
}

_id_141C5() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");
  self endon("_encstr_99421808AF7190BE7049770160D0FFE9123FD11347C3338A4B18");
  var_0 = self.origin;
  var_1 = 1500.0;
  var_2 = getdvarfloat("_encstr_969C1C373693BE932DF5CEAC34F573569D3659B18EF58CAB27C247D2F6E6", 30.0);
  self._id_11E49 = undefined;
  self._id_11E4A = 0;
  self._id_1381C = undefined;
  self.mp_layover_patch = undefined;

  for(;;) {
    self.loot_nag = distance2d(var_0, self.origin);
    self._id_141FA = isDefined(self getvehicleowner());

    if(!self._id_11E4A && self.loot_nag > var_1 && !self._id_141FA) {
      self._id_1381C = gettime();
      self.mp_layover_patch = gettime() + var_2 * 1000;
      self._id_11E4A = 1;
    } else if(self._id_11E4A && self._id_141FA) {
      self._id_11E4A = 0;
      self._id_1381C = undefined;
      self.mp_layover_patch = undefined;
      self._id_11E49 = undefined;
    }

    if(isDefined(self._id_1381C) && isDefined(self.mp_layover_patch)) {
      var_3 = gettime();
      self._id_11E49 = (self.mp_layover_patch - var_3) / 1000;
      var_4 = 0;

      if(var_3 >= self.mp_layover_patch) {
        foreach(var_6 in level.players) {
          if(distance(var_6.origin, self.origin) < var_1) {
            self.mp_layover_patch = var_3 + var_2 / 2 * 1000;
            var_4 = 1;
            break;
          }
        }

        if(!var_4) {
          var_8 = self.health * 0.95;
          self dodamage(var_8, self.origin);
          break;
        }
      }
    }

    wait 1.0;
  }
}

vehicle_death_watcher() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_8DD8122BE68C7D9159581D0DAFDDC2A38D0DB293");
  var_0 = self._id_1352E;
  self waittill("_encstr_AD75063D571AE108");
  self notify("_encstr_99421808AF7190BE7049770160D0FFE9123FD11347C3338A4B18");
  lasttuttxt(self);
  _id_1420B(var_0);
}

_id_141B6() {
  return self.vehiclename == "_encstr_BDC80A5437EAD749519A6068" || self.vehiclename == "_encstr_83F40783ADF1D14AA3";
}

_id_141B5() {
  return self.vehiclename == "_encstr_BDC80A5437EAD749519A6068";
}

_id_12D35() {
  level endon("_encstr_B23B1DB2495DE774899FF4E97538717B0DA38AAB16BFA7E1E88B0AE2636002");
  level endon("_encstr_9B1D0BC7932875276230426AA1");

  if(!scripts\mp\flags::gameflag("_encstr_BA9F0EC13959DA2C47D8437D91EDB92B")) {
    return;
  }
  var_0 = (0, 0, 60);
  var_1 = self.origin + var_0;
  var_1 = var_1 - anglesToForward(self.angles) * 28;
  self.useownerobj = scripts\mp\gameobjects::createhintobject(var_1, "_encstr_BA110C20C7C0F307EDF9111CB7A1", undefined, &"_encstr_847D212973677F9BF8B639B5D9906527A19F89C99BBF37E3516E832621996BEFDA7FE9", -1, "_encstr_97C20EB5FD43A179CC6AD05152651579", undefined, 100, 60, 60, 60);

  for(;;) {
    self.useownerobj waittill("_encstr_8F5C086405E70FBA4B4A", var_2);

    if(isDefined(var_2) && var_2.plundercount >= 5) {
      break;
    }

    playsoundatpos(self.useownerobj.origin, "_encstr_A5A918FB80AF7FEFD80BABA46760B333B6183203E9F8FB27E05B");
  }

  self.useownerobj delete();
  var_2 _encstr_9186249B6C39B438E8CD5EB6C1E5CE85B6953AF283599B9789C9AF83D8BAE69159E41776DC8D::_id_1261E(5);
  playsoundatpos(self.origin, "_encstr_922B1B33B101487D7B92D13B59632D18A618A3B725F91BB04BBAE8E342");
  var_2 thread scripts\mp\hud_message::showsplash("_encstr_AB7B134997CEF343FD805A430115BF1BE10BC2C5BD");
  var_2 thread scripts\mp\rank::giverankxp("_encstr_AC37139C2DBED15727272B1DD7E42B1CB04B939591", 25, var_2 getcurrentprimaryweapon());
  var_2 thread scripts\mp\rank::scoreeventpopup("_encstr_AC37139C2DBED15727272B1DD7E42B1CB04B939591");
  var_3 = spawnStruct();
  var_3.origin = self.origin;
  var_3.angles = self.angles;

  if(isDefined(level.arenaknivesout))
    level.arenaknivesout = scripts\engine\utility::array_remove(level.arenaknivesout, self);

  if(isDefined(level.arenaflag_setenabled))
    var_3[[level.arenaflag_setenabled]]();

  self delete();
}