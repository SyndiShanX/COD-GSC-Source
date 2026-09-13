/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\cp_equipment.gsc
***********************************************/

init_equipment() {
  if(!getdvarint("dvar_A464CB031C16EE87", 0))
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_iw9_mp";
  else
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_t10_mp";

  level.equipment = spawnStruct();
  _id_29D51C2A86346A9C();
}

_id_29D51C2A86346A9C() {
  level.equipment.table = [];
  _id_9DF9FE298AEF6003 = getscriptbundle(level._id_E5255D7C501309DD);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9DF9FE298AEF6003._id_BD5D1F5A11586ED4.size; _id_AC0E594AC96AA3A8++) {
    equipmentref = _id_9DF9FE298AEF6003._id_BD5D1F5A11586ED4[_id_AC0E594AC96AA3A8].ref;
    _id_68CD8193F877CF60 = _id_9DF9FE298AEF6003._id_BD5D1F5A11586ED4[_id_AC0E594AC96AA3A8]._id_D442547D75DFFD09;

    if(isDefined(_id_68CD8193F877CF60)) {
      _id_85A1E8B6A105E2BB = getscriptbundle("equipment:" + _id_68CD8193F877CF60);

      if(isDefined(_id_85A1E8B6A105E2BB)) {
        struct = spawnStruct();
        struct.ref = equipmentref;
        weaponname = _id_85A1E8B6A105E2BB.useweapon;

        if(weaponname != "none") {
          attachments = undefined;
          baseweapon = makeweapon(_id_85A1E8B6A105E2BB.useweapon);

          if(!isnullweapon(baseweapon))
            attachments = _func_6527364C1ECCA6C6(_id_85A1E8B6A105E2BB.useweapon);

          struct.objweapon = makeweapon(_id_85A1E8B6A105E2BB.useweapon, attachments);
        }

        struct.id = _id_AC0E594AC96AA3A8;
        struct.image = _id_85A1E8B6A105E2BB.image;
        struct.defaultslot = scripts\engine\utility::ter_op(isDefined(_id_85A1E8B6A105E2BB._id_5472B77A1E1124B3) && _id_85A1E8B6A105E2BB._id_5472B77A1E1124B3 == 2, "secondary", "primary");
        struct.scavengerammo = scripts\engine\utility::ter_op(isDefined(_id_85A1E8B6A105E2BB.scavengerammo), _id_85A1E8B6A105E2BB.scavengerammo, 0);
        struct.ispassive = isDefined(_id_85A1E8B6A105E2BB.ispassive) && _id_85A1E8B6A105E2BB.ispassive;
        struct.isselectable = !isDefined(_id_85A1E8B6A105E2BB._id_F9C517FD9D746051) || _id_85A1E8B6A105E2BB._id_F9C517FD9D746051 != -1;
        struct.weaponname = _id_85A1E8B6A105E2BB.useweapon;
        struct._id_D442547D75DFFD09 = _id_85A1E8B6A105E2BB;
        _id_DA24FA61707AA57F = _id_85A1E8B6A105E2BB._id_E2A7D54C199DB889;

        if(!isDefined(_id_DA24FA61707AA57F)) {
          if(_id_85A1E8B6A105E2BB.useweapon != "none")
            struct.damageweaponnames = [_id_85A1E8B6A105E2BB.useweapon];
        } else if(_id_DA24FA61707AA57F == "none") {} else {
          damageweaponnames = [];

          if(_id_85A1E8B6A105E2BB.useweapon != "none")
            damageweaponnames[damageweaponnames.size] = _id_85A1E8B6A105E2BB.useweapon;

          _id_A2643F257EE064A3 = strtok(_id_DA24FA61707AA57F, " ");

          foreach(_id_F9EC6C92C0FF1F63 in _id_A2643F257EE064A3)
          damageweaponnames[damageweaponnames.size] = _id_F9EC6C92C0FF1F63;

          struct.damageweaponnames = damageweaponnames;
        }

        level.equipment.table[equipmentref] = struct;
      }
    }
  }
}

get_sticky_grenade_destination(grenade, _id_F432E8F2C3B65BAD, _id_76831D64528B6D31, _id_8DF3FF6D9DB28011, fusetime, data) {
  grenade endon("death");

  if(!isDefined(data))
    data = spawnStruct();

  if(!isDefined(data.contents))
    data.contents = get_grenade_cast_contents();

  if(!isDefined(data.divisions))
    data.divisions = 5;

  if(!isDefined(data.amortize))
    data.amortize = 1;

  if(!isDefined(data.ignorelist))
    data.ignorelist = [grenade, grenade.owner];

  if(!isDefined(data.ignorclutter))
    data.ignoreclutter = 1;

  if(!isDefined(fusetime))
    fusetime = 10;

  if(!isDefined(data.maxtime))
    data.maxtime = fusetime - fusetime * grenade.tickpercent;

  _id_46BCCF24774BA912 = data.maxtime / data.divisions;
  times[0] = 0;
  _id_E4B7E99A96C8829F[0] = grenade.origin;
  _id_CBE776EFC22487C7 = data.divisions;
  _id_198A19F5087C274D = anglesToForward(_id_F432E8F2C3B65BAD);
  _id_6DEA3F838287BDED = (0, 0, 1);
  vel = _id_198A19F5087C274D * _id_76831D64528B6D31 + _id_6DEA3F838287BDED * _id_8DF3FF6D9DB28011;
  _id_71B049FF6296DC2F = _id_6DEA3F838287BDED * vectordot(_id_6DEA3F838287BDED, vel);
  _id_60CECC5D1218A89E = vel - _id_71B049FF6296DC2F;

  for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < data.divisions; _id_AC0E594AC96AA3A8++) {
    _id_B1EA6E95CD5257DD = times[_id_AC0E594AC96AA3A8 - 1];
    _id_CD5F2EF778B5875F = _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8 - 1];
    nexttime = _id_AC0E594AC96AA3A8 * _id_46BCCF24774BA912;
    _id_3E6B57D717B688D8 = _id_60CECC5D1218A89E * nexttime;
    _id_46DE56D5EB869951 = _id_71B049FF6296DC2F * nexttime + (0, 0, -400) * nexttime * nexttime;
    _id_AC1DA71286DBEADF = _id_E4B7E99A96C8829F[0] + _id_3E6B57D717B688D8 + _id_46DE56D5EB869951;
    times[_id_AC0E594AC96AA3A8] = nexttime;
    _id_E4B7E99A96C8829F[_id_AC0E594AC96AA3A8] = _id_AC1DA71286DBEADF;
    results = physics_raycast(_id_CD5F2EF778B5875F, _id_AC1DA71286DBEADF, data.contents, data.ignorelist, 1, "physicsquery_closest", data.ignoreclutter);

    if(isDefined(results) && results.size > 0) {
      data.destination = results[0]["position"];
      data.destinationnormal = results[0]["normal"];
      data.destinationentity = results[0]["entity"];
      data.destinationhit = 1;
      _id_EC7B20B1054D5D98 = _id_AC1DA71286DBEADF - _id_CD5F2EF778B5875F;
      _id_5805327F64D62D38 = length(_id_EC7B20B1054D5D98);
      _id_35EBF7955EC217CF = _id_EC7B20B1054D5D98 / _id_5805327F64D62D38;
      _id_75C0B9C719A5FC05 = _id_CD5F2EF778B5875F - data.destination;
      _id_59D191507790C7C9 = vectordot(_id_35EBF7955EC217CF, _id_75C0B9C719A5FC05);
      _id_FB921BEB20AA928D = clamp(_id_59D191507790C7C9 / _id_5805327F64D62D38, 0, 1);
      data.destinationtime = _id_B1EA6E95CD5257DD + _id_46BCCF24774BA912 * _id_FB921BEB20AA928D;
      break;
    } else if(_id_AC0E594AC96AA3A8 == data.divisions - 1) {
      data.destination = _id_AC1DA71286DBEADF;
      break;
    }

    if(data.amortize)
      waitframe();
  }

  return data;
}

get_grenade_cast_contents(_id_AAFB624F1DD4F653) {
  contents = undefined;

  if(istrue(_id_AAFB624F1DD4F653))
    contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water", "physicscontents_characterproxy"]);
  else
    contents = physics_createcontents(["physicscontents_missileclip", "physicscontents_item", "physicscontents_vehicle", "physicscontents_glass", "physicscontents_water"]);

  return contents;
}

plant(grenade, data) {
  self endon("death");
  self endon("disconnect");
  grenade endon("death");
  grenade.releasegrenadeorigin = grenade.origin;
  grenade.releaseownerorigin = self.origin;
  grenade.releaseownereye = self getEye();
  grenade.releaseownerangles = self getgunangles();

  if(!isDefined(data.plantmaxtime))
    data.plantmaxtime = 0.5;

  if(!isDefined(data.plantmaxroll))
    data.plantmaxroll = 0;

  if(!isDefined(data.plantmindistbeloweye))
    data.plantmindistbeloweye = 12;

  if(!isDefined(data.plantmaxdistbelowownerfeet))
    data.plantmaxdistbelowownerfeet = 20;

  if(!isDefined(data.plantmindisteyetofeet))
    data.plantmindisteyetofeet = 45;

  if(!isDefined(data.plantnormalcos))
    data.plantnormalcos = 0.342;

  if(!isDefined(data.plantoffsetz))
    data.plantoffsetz = 1;

  plant_watch_stuck(grenade, data);
  _id_6EB1CCFDF22D82B7 = 0;
  position = data.notifyorigin;
  normal = data.notifynormal;
  _id_BF8E5F003146AF44 = data.notifyentity;
  _id_7DBDA545F37B475F = data.notifyhit;
  angles = undefined;

  if(!istrue(_id_7DBDA545F37B475F)) {
    position = data.calcorigin;
    normal = data.calcnormal;
    _id_BF8E5F003146AF44 = data.calcentity;
    _id_7DBDA545F37B475F = data.calchit;

    if(istrue(_id_7DBDA545F37B475F) && isDefined(_id_BF8E5F003146AF44) && _id_BF8E5F003146AF44 getnonstick())
      _id_7DBDA545F37B475F = undefined;
  } else
    angles = plant_clamp_angles(grenade.angles, data);

  if(istrue(_id_7DBDA545F37B475F)) {
    if(isDefined(normal) && vectordot(normal, (0, 0, 1)) < data.plantnormalcos)
      _id_6EB1CCFDF22D82B7 = 1;
    else {
      _id_F4EF78DE9CF3220A = vectordot(grenade.releaseownerorigin - position, (0, 0, 1));

      if(_id_F4EF78DE9CF3220A > 0) {
        if(_id_F4EF78DE9CF3220A > data.plantmaxdistbelowownerfeet)
          _id_6EB1CCFDF22D82B7 = 1;
      } else {
        _id_89CC128C05B322D1 = vectordot(grenade.releaseownereye - grenade.releaseownerorigin, (0, 0, 1));

        if(_id_89CC128C05B322D1 > data.plantmindisteyetofeet) {
          _id_AB4DB4E369E3FB13 = vectordot(grenade.releaseownereye - position, (0, 0, 1));

          if(_id_AB4DB4E369E3FB13 >= 0) {
            if(_id_AB4DB4E369E3FB13 < data.plantmindistbeloweye)
              _id_6EB1CCFDF22D82B7 = 1;
          } else
            _id_6EB1CCFDF22D82B7 = 1;
        }
      }
    }
  } else
    _id_6EB1CCFDF22D82B7 = 1;

  if(_id_6EB1CCFDF22D82B7) {
    contents = data.castcontents;

    if(!isDefined(contents))
      contents = get_grenade_cast_contents();

    ignorelist = [grenade, self];
    caststart = grenade.releaseownerorigin;
    castend = caststart + (0, 0, -1 * data.plantmaxdistbelowownerfeet);
    results = physics_raycast(caststart, castend, contents, ignorelist, 1, "physicsquery_closest", 1);

    if(isDefined(results) && results.size > 0) {
      position = results[0]["position"];
      normal = results[0]["normal"];

      if(isDefined(normal) && vectordot(normal, (0, 0, 1)) < data.plantnormalcos)
        return 0;

      _id_28B3F77BB0070F33 = grenade.releaseownerangles * (0, 1, 0);

      if(isDefined(normal)) {
        angles = scripts\cp\utility::vectortoanglessafe(anglesToForward(_id_28B3F77BB0070F33), normal);
        angles = plant_clamp_angles(angles, data);
      } else
        angles = _id_28B3F77BB0070F33;

      position = position + anglestoup(angles) * data.plantoffsetz;
      _id_BF8E5F003146AF44 = results[0]["entity"];
      grenade dontinterpolate();
      grenade.origin = position;
      grenade.angles = angles;
    } else
      return 0;
  } else {
    if(!isDefined(angles)) {
      _id_28B3F77BB0070F33 = grenade.releaseownerangles * (0, 1, 0);

      if(isDefined(normal)) {
        angles = scripts\cp\utility::vectortoanglessafe(anglesToForward(_id_28B3F77BB0070F33), normal);
        angles = plant_clamp_angles(angles, data);
      } else
        angles = _id_28B3F77BB0070F33;
    }

    position = position + anglestoup(angles) * data.plantoffsetz;
    grenade dontinterpolate();
    grenade.origin = position;
    grenade.angles = angles;
  }

  if(isDefined(_id_BF8E5F003146AF44))
    grenade linkTo(_id_BF8E5F003146AF44);

  return 1;
}

plant_watch_stuck(grenade, data) {
  childthread plant_watch_stuck_notify(grenade, data);
  childthread plant_watch_stuck_calculate(grenade, data);
  childthread plant_watch_stuck_timeout(grenade, data);
  data waittill("start_race");
  waittillframeend;
  data notify("end_race");
  return data;
}

plant_watch_stuck_notify(grenade, data) {
  data endon("end_race");
  grenade waittill("missile_stuck", stuckto);
  data.notifyorigin = grenade.origin;
  data.notifyangles = grenade.angles;
  data.notifyentity = stuckto;
  data.notifyhit = 1;
  data notify("start_race");
}

plant_watch_stuck_calculate(grenade, data) {
  data endon("end_race");
  data = get_sticky_grenade_destination(grenade, grenade.releaseownerangles, data.throwspeedforward, data.throwspeedup, data.castmaxtime, data);
  data.calcorigin = data.destination;
  data.calcnormal = data.destinationnormal;
  data.calcentity = data.destinationentity;
  data.calchit = data.destinationhit;
  data notify("start_race");
}

plant_watch_stuck_timeout(grenade, data) {
  data endon("end_race");
  wait(data.plantmaxtime);
  data notify("start_race");
}

plant_clamp_angles(angles, data) {
  pitch = 0;
  yaw = angles[1];
  roll = scripts\engine\utility::ter_op(data.plantmaxroll != 0, angles[2], 0);

  if(roll != 0) {
    if(roll > 0)
      roll = clamp(angles[2], 0, data.plantmaxroll);
    else
      roll = clamp(angles[2], -1 * data.plantmaxroll, 0);
  }

  return (pitch, yaw, roll);
}

makeexplosiveusabletag(tagname, isgrenade, _id_023C5CD24079AAA6) {
  self endon("death");
  self endon("makeExplosiveUnusable");
  owner = self.owner;
  weaponname = self.weapon_name;
  equipmentref = _id_7EF95BBA57DC4B82::_id_7F245729FCB6414D(weaponname);

  if(!isDefined(isgrenade))
    isgrenade = 0;

  scripts\cp\utility::setselfusable(owner);

  if(isgrenade)
    self enablemissilehint(1);
  else
    self setCursorHint("HINT_NOICON");

  self sethinttag(tagname);
  self setuserange(72);
  setexplosiveusablehintstring(self.weapon_name);
  childthread scripts\cp\utility::notusableforjoiningplayers(owner);
  extra = 0;

  if(isDefined(_id_023C5CD24079AAA6))
    extra = _id_023C5CD24079AAA6;

  for(;;) {
    self waittillmatch("trigger", owner);

    if(!self.owner _id_7EF95BBA57DC4B82::hasequipment(equipmentref)) {
      self.owner thread _id_7EF95BBA57DC4B82::giveequipment(equipmentref, "primary");
      self.owner _id_7EF95BBA57DC4B82::setequipmentammo(equipmentref, extra);
    }

    owner playlocalsound("grenade_pickup");
    owner notify("pickup_equipment", weaponname);

    if(isDefined(equipmentref) && self.owner _id_7EF95BBA57DC4B82::hasequipment(equipmentref))
      self.owner _id_7EF95BBA57DC4B82::incrementequipmentammo(equipmentref, 1);

    if(isDefined(self.useobj))
      self.useobj delete();

    thread _id_74502A9E0EF1F19C::deleteexplosive();
    return;
  }
}

setexplosiveusablehintstring(weaponname) {
  if(!isDefined(weaponname)) {
    return;
  }
  switch (weaponname) {
    case "c4_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_C4");
      break;
    case "at_mine_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_AT_MINE");
      break;
    case "claymore_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_CLAYMORE");
      break;
    case "gas_grenade_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_GAS_GRENADE");
      break;
    case "trophy_mp":
      self setHintString(&"EQUIPMENT_HINTS/PICKUP_TROPHY");
      break;
  }
}

hasequipment(ref) {
  if(!isDefined(self.equipment)) {
    if(isDefined(self.powers)) {
      foreach(key, value in self.powers) {
        if(key == ref)
          return 1;
      }
    }

    return 0;
  }

  foreach(_id_F03830BD1CD0CF91 in self.equipment) {
    if(_id_F03830BD1CD0CF91 == ref)
      return 1;
  }

  return 0;
}

equipment_init(_id_584994FAB4A8712B) {
  _id_584994FAB4A8712B.callbacks["equip_adrenaline"]["onFired"] = scripts\cp\equipment\cp_adrenaline::onequipmentfired;
  _id_584994FAB4A8712B.callbacks["equip_adrenaline"]["onTake"] = scripts\cp\equipment\cp_adrenaline::onequipmenttaken;
  return _id_584994FAB4A8712B;
}

getequipmentreffromweapon(objweapon) {
  objweapon = mapequipmentweaponforref(objweapon);

  foreach(_id_8BF83D28BE4C2D4F in level.equipment.table) {
    if(isDefined(_id_8BF83D28BE4C2D4F.objweapon) && objweapon == _id_8BF83D28BE4C2D4F.objweapon)
      return _id_8BF83D28BE4C2D4F.ref;
  }

  return undefined;
}

mapequipmentweaponforref(objweapon) {
  switch (objweapon.basename) {
    case "throwingknife_fire_mp":
    case "throwingknife_mp":
      return makeweapon("throwingknife_mp");
    case "claymore_radial_mp":
      return makeweapon("claymore_mp");
    case "at_mine_ap_mp":
      return makeweapon("at_mine_mp");
    case "thermite_ap_mp":
    case "thermite_av_mp":
      return makeweapon("thermite_mp");
  }

  return objweapon;
}

getequipmentammo(ref) {
  if(!isweapon(ref))
    ref = makeweaponfromstring(ref);

  if(!isDefined(ref))
    return 0;

  return self getammocount(ref);
}

getequipmenttableinfo(ref) {
  return level.equipment.table[ref];
}

setequipmentammo(ref, amount) {
  if(!isDefined(ref)) {
    return;
  }
  self setweaponammoclip(ref, amount);
}

_id_E0EF70F764B4A4C7(player) {
  self setscriptablepartstate("hacked", "active", 0);
  _id_7EF95BBA57DC4B82::hackequipment(player);
  self setscriptablepartstate("arm", "neutral", 0);
  self notify("hacked");
  player thread scripts\engine\utility::delaythread(1, _id_293BC33BD79CABD1::killeventtextpopup, "stat_2E07BBCC73ED19E8", 0);

  if(!isDefined(self.equipmentref)) {
    return;
  }
  _id_F79F311C1ED5A958 = _id_4FD4273C8A15AC00(self.equipmentref);

  if(_id_F79F311C1ED5A958 != "") {
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdropinfo(self.origin, self.angles);
    item = _id_66122A002AFF5D57::spawnpickup(_id_F79F311C1ED5A958, _id_CB4FAD49263E20C4);

    if(isDefined(self._id_3DBA99677FD840CD))
      self[[self._id_3DBA99677FD840CD]]();
  }
}

_id_4FD4273C8A15AC00(equipmentref) {
  _id_F79F311C1ED5A958 = "";

  switch (equipmentref) {
    case "equip_frag":
      _id_F79F311C1ED5A958 = "brloot_offhand_frag";
      break;
    case "equip_semtex":
      _id_F79F311C1ED5A958 = "brloot_offhand_semtex";
      break;
    case "equip_molotov":
      _id_F79F311C1ED5A958 = "brloot_offhand_molotov";
      break;
    case "equip_claymore":
      _id_F79F311C1ED5A958 = "brloot_offhand_claymore";
      break;
    case "equip_throwing_knife":
      _id_F79F311C1ED5A958 = "brloot_offhand_throwingknife";
      break;
    case "equip_throwing_knife_fire":
      _id_F79F311C1ED5A958 = "brloot_offhand_throwingknife_fire";
      break;
    case "equip_throwing_knife_electric":
      _id_F79F311C1ED5A958 = "brloot_offhand_shockstick";
      break;
    case "equip_c4":
      _id_F79F311C1ED5A958 = "brloot_offhand_c4";
      break;
    case "equip_thermite":
      _id_F79F311C1ED5A958 = "brloot_offhand_thermite";
      break;
    case "equip_at_mine":
      _id_F79F311C1ED5A958 = "brloot_offhand_atmine";
      break;
  }

  return _id_F79F311C1ED5A958;
}