/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\equipment.gsc
***********************************************/

init() {
  level.equipment = spawnStruct();
  inititems();

  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_t10_mp";
  else if(getdvarint("mgl", 0) > 0)
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_mgl_mp";
  else if(scripts\common\utility::iscp())
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_iw9_cp";
  else
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_iw9_mp";

  _id_29D51C2A86346A9C();
  initlethalmaxoffsetmap();

  if(!isDefined(level.onplayerspawncallbacks))
    level.onplayerspawncallbacks = [];

  level.onplayerspawncallbacks[level.onplayerspawncallbacks.size] = ::equiponplayerspawned;
}

inititems() {
  level.equipment.callbacks = [];
  _id_584994FAB4A8712B = level.equipment;
  _id_6159D9FD44490F13::equipmentinteract_init();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "equipment_init"))
    _id_584994FAB4A8712B = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "equipment_init")]](_id_584994FAB4A8712B);

  scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  _id_52D91CB28006A5BD::_id_12D7CA3FF609CABA();
  _id_584994FAB4A8712B.callbacks["equip_hb_sensor"]["onGive"] = _id_0EC0F9AD939B29E0::_id_78CE4BFDA3E762B3;
  _id_584994FAB4A8712B.callbacks["equip_hb_sensor"]["onTake"] = _id_0EC0F9AD939B29E0::_id_7F948B7F43448EA9;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife_fire"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife_fire"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife_electric"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife_electric"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  _id_584994FAB4A8712B.callbacks["equip_throwstar"]["onGive"] = _id_52D91CB28006A5BD::_id_E7715FFB329C1B40;
  _id_584994FAB4A8712B.callbacks["equip_throwstar"]["onTake"] = _id_52D91CB28006A5BD::_id_092E126D1A5D3FB2;
  _id_584994FAB4A8712B.callbacks["equip_geigercounter"]["onGive"] = _id_479E458F6F530F0D::_id_60CBA38635FD35CB;
  _id_584994FAB4A8712B.callbacks["equip_geigercounter"]["onTake"] = _id_479E458F6F530F0D::_id_BDD02627BCAFE359;
  thread watchlethaldelay();

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "registerOnDisconnectEventCallback"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "registerOnDisconnectEventCallback")]](::onownerdisconnect);
}

getcallback(ref, callback) {
  if(!isDefined(level.equipment.callbacks[ref]))
    return undefined;

  return level.equipment.callbacks[ref][callback];
}

loadtable() {
  level.equipment.table = [];
  _id_CB89110314447B2F = 1;

  for(;;) {
    ref = tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 1);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    _id_39061D840C9E9B1F = tolower(ref);
    struct = spawnStruct();
    struct.ref = _id_39061D840C9E9B1F;
    weaponname = tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 6);

    if(weaponname != "none") {
      _id_FF180C307F2BAFD3 = tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 19);
      attachments = undefined;

      if(_id_FF180C307F2BAFD3 != "") {
        baseweapon = makeweapon(weaponname);

        if(!isnullweapon(baseweapon))
          attachments = [_id_FF180C307F2BAFD3];
      }

      struct.objweapon = makeweapon(weaponname, attachments);
    }

    struct.id = _id_CB89110314447B2F;
    struct.image = tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 4);
    struct.defaultslot = scripts\engine\utility::ter_op(tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 7) == "2", "secondary", "primary");
    struct.scavengerammo = int(tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 10));
    struct.ispassive = tolower(tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 11)) == "true";
    struct.isselectable = tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 8) != "-1";
    struct.weaponname = weaponname;
    _id_DA24FA61707AA57F = tablelookupbyrow(level._id_E5255D7C501309DD, _id_CB89110314447B2F, 12);

    if(_id_DA24FA61707AA57F == "none") {} else if(_id_DA24FA61707AA57F == "") {
      if(weaponname != "none")
        struct.damageweaponnames = [weaponname];
    } else {
      damageweaponnames = [];

      if(weaponname != "none")
        damageweaponnames[damageweaponnames.size] = weaponname;

      _id_A2643F257EE064A3 = strtok(_id_DA24FA61707AA57F, " ");

      foreach(_id_F9EC6C92C0FF1F63 in _id_A2643F257EE064A3)
      damageweaponnames[damageweaponnames.size] = _id_F9EC6C92C0FF1F63;

      struct.damageweaponnames = damageweaponnames;
    }

    level.equipment.table[_id_39061D840C9E9B1F] = struct;
    _id_CB89110314447B2F++;
  }
}

_id_29D51C2A86346A9C() {
  level.equipment.table = [];
  level._id_A1E3B0D7B2A7836F = [];
  _id_9DF9FE298AEF6003 = getscriptbundle(level._id_E5255D7C501309DD);

  if(isDefined(_id_9DF9FE298AEF6003)) {
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
            baseweapon = makeweapon(weaponname);

            if(!isnullweapon(baseweapon))
              attachments = _func_6527364C1ECCA6C6(weaponname);

            struct.objweapon = makeweapon(weaponname, attachments);
            _id_4F62FB945AD6AF8D = _func_BB92A5000082832A(weaponname);

            foreach(_id_134C70A5C6DE474C, id in _id_4F62FB945AD6AF8D) {
              _id_1092BC40C58C1C9A = weaponname + "|" + scripts\engine\utility::string(id);
              level._id_A1E3B0D7B2A7836F[_id_1092BC40C58C1C9A] = _func_3211981142EC5AEE(weaponname, _id_134C70A5C6DE474C);
            }
          }

          struct.id = _id_AC0E594AC96AA3A8;
          struct.image = _id_85A1E8B6A105E2BB.image;
          struct.defaultslot = scripts\engine\utility::ter_op(isDefined(_id_85A1E8B6A105E2BB._id_5472B77A1E1124B3) && _id_85A1E8B6A105E2BB._id_5472B77A1E1124B3 == 2, "secondary", "primary");
          struct.scavengerammo = scripts\engine\utility::ter_op(isDefined(_id_85A1E8B6A105E2BB.scavengerammo), _id_85A1E8B6A105E2BB.scavengerammo, 0);
          struct.ispassive = isDefined(_id_85A1E8B6A105E2BB.ispassive) && _id_85A1E8B6A105E2BB.ispassive;
          struct.isselectable = !isDefined(_id_85A1E8B6A105E2BB._id_F9C517FD9D746051) || _id_85A1E8B6A105E2BB._id_F9C517FD9D746051 != -1;
          struct.weaponname = weaponname;
          struct._id_D442547D75DFFD09 = _id_85A1E8B6A105E2BB;
          _id_DA24FA61707AA57F = _id_85A1E8B6A105E2BB._id_E2A7D54C199DB889;

          if(!isDefined(_id_DA24FA61707AA57F)) {
            if(weaponname != "none")
              struct.damageweaponnames = [weaponname];
          } else if(_id_DA24FA61707AA57F == "none") {} else {
            damageweaponnames = [];

            if(weaponname != "none")
              damageweaponnames[damageweaponnames.size] = weaponname;

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
}

getequipmenttableinfo(ref) {
  if(isDefined(ref) && !isDefined(level.equipment.table[ref])) {}

  return level.equipment.table[ref];
}

_id_F4F687E4E1EDB923(_id_F4692D0892428480) {
  _id_67F14F8315CB0F2F = strtok(_id_F4692D0892428480, "_");
  _id_67F14F8315CB0F2F = scripts\engine\utility::array_remove_index(_id_67F14F8315CB0F2F, _id_67F14F8315CB0F2F.size - 1);
  _id_70A60EECF7EF55D7 = "";
  counter = 0;

  foreach(_id_E97377032A878881 in _id_67F14F8315CB0F2F) {
    if(counter == 0) {
      _id_70A60EECF7EF55D7 = _id_70A60EECF7EF55D7 + _id_E97377032A878881;
      counter++;
      continue;
    }

    _id_70A60EECF7EF55D7 = _id_70A60EECF7EF55D7 + "_" + _id_E97377032A878881;
  }

  return _id_70A60EECF7EF55D7;
}

_id_9E77A3E4BB6C6E31(weaponname, variantid) {
  if(!isDefined(weaponname))
    return undefined;

  if(isDefined(variantid) && variantid > 0) {
    weapon = makeweapon(weaponname, [], undefined, undefined, variantid);
    _id_1092BC40C58C1C9A = weaponname + "|" + scripts\engine\utility::string(variantid);
    attachments = level._id_A1E3B0D7B2A7836F[_id_1092BC40C58C1C9A];

    foreach(attachment, _id_6794F7417ED0B5A2 in attachments)
    weapon = weapon withattachment(attachment, _id_6794F7417ED0B5A2);
  } else
    weapon = makeweapon(weaponname);

  return weapon;
}

giveequipment(ref, slot, variantid) {
  if(!isDefined(self.equipment))
    self.equipment = [];

  if(ref == "none") {
    return;
  }
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F)) {
    return;
  }
  if(slot == "super") {
    _id_5237A188CCDA4D7B = level.br_pickups._id_14BD11727C4B6629[level.br_pickups.br_equipnametoscriptable[ref]];

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("supers", "getSuperID"))
      _id_8BF83D28BE4C2D4F.id = [[scripts\cp_mp\utility\script_utility::getsharedfunc("supers", "getSuperID")]](_id_5237A188CCDA4D7B);
  }

  takeequipment(slot);
  weapon = undefined;

  if(isDefined(variantid))
    weapon = _id_9E77A3E4BB6C6E31(_id_8BF83D28BE4C2D4F.weaponname, variantid);
  else
    weapon = _id_8BF83D28BE4C2D4F.objweapon;

  if(isDefined(weapon) && (is_equipment_slot_allowed(slot) && !_id_8BF83D28BE4C2D4F.ispassive)) {
    self giveweapon(weapon);

    if(slot == "primary")
      self assignweaponoffhandprimary(weapon);
    else if(slot == "secondary")
      self assignweaponoffhandsecondary(weapon);
    else if(slot == "super")
      self assignweaponoffhandspecial(weapon);
  }

  sethudslot(slot, _id_8BF83D28BE4C2D4F.id);
  self.equipment[slot] = ref;
  _id_645972186625DAEE = getcallback(ref, "onGive");

  if(isDefined(_id_645972186625DAEE))
    self thread[[_id_645972186625DAEE]](ref, slot, variantid);

  _id_22BF78ECA6578D7D(slot);
  _id_4E8271CF261E45DD = ref == "equip_throwing_knife" || ref == "equip_throwing_knife_fire" || ref == "equip_throwing_knife_electric" || ref == "equip_shuriken";

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]() == "arena" && _id_4E8271CF261E45DD) {} else
    thread watchlethaldelayplayer(ref, slot);

  self notify("equipment_given", ref);
}

takeequipment(slot) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return;
  }
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(isDefined(_id_8BF83D28BE4C2D4F.objweapon)) {
    if(self hasweapon(_id_8BF83D28BE4C2D4F.objweapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(_id_8BF83D28BE4C2D4F.objweapon);

      if(slot == "primary")
        self clearoffhandprimary();
      else if(slot == "secondary")
        self clearoffhandsecondary();
    }
  }

  sethudslot(slot, 0);
  self.equipment[slot] = undefined;
  _id_C96C25B8A1F6FE18 = getcallback(ref, "onTake");

  if(isDefined(_id_C96C25B8A1F6FE18))
    self thread[[_id_C96C25B8A1F6FE18]](ref, slot);

  _id_22BF78ECA6578D7D(slot);
  self notify("equipment_taken_" + ref);
}

equiponplayerdamaged(data) {
  weaponname = data.objweapon.basename;

  foreach(ref, _id_8BF83D28BE4C2D4F in level.equipment.table) {
    _id_148E2D88D1DEFFD3 = getcallback(ref, "onPlayerDamaged");

    if(isDefined(_id_148E2D88D1DEFFD3) && isDefined(_id_8BF83D28BE4C2D4F.damageweaponnames)) {
      foreach(_id_F9EC6C92C0FF1F63 in _id_8BF83D28BE4C2D4F.damageweaponnames) {
        if(_id_F9EC6C92C0FF1F63 == weaponname) {
          _id_B4998CF105F4856B = gettime();
          result = [[_id_148E2D88D1DEFFD3]](data);
          return result;
        }
      }
    }
  }
}

ondestroyedbytrophy() {
  if(isDefined(self.equipmentref)) {
    _id_99115207769478FF = getcallback(self.equipmentref, "onDestroyedByTrophy");

    if(isDefined(_id_99115207769478FF)) {
      self thread[[_id_99115207769478FF]]();
      return 1;
    } else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "isPlantedEquipment") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "isPlantedEquipment")]](self)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "deleteExplosive")) {
        self thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "deleteExplosive")]]();
        return 1;
      }
    }
  }

  return 0;
}

is_equipment_slot_allowed(slot) {
  switch (slot) {
    case "primary":
      return _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("equipment_primary");
    case "secondary":
      return _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("equipment_secondary");
    default:
      return 1;
  }
}

sethudslot(slot, id) {
  if(slot != "super")
    self setclientomnvar("ui_equipment_id_" + slot, id);
  else
    self setclientomnvar("ui_perk_package_super1", id);
}

getcurrentequipment(slot) {
  if(!isDefined(self.equipment))
    return undefined;

  return self.equipment[slot];
}

clearallequipment() {
  if(!isDefined(self.equipment)) {
    return;
  }
  foreach(slot, ref in self.equipment)
  takeequipment(slot);
}

getequipmentmaxammo(ref) {
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F))
    return undefined;

  if(!isDefined(_id_8BF83D28BE4C2D4F.objweapon))
    return 0;

  if(!scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508()) {
    slot = findequipmentslot(ref);
    maxammo = undefined;

    if(isDefined(level._id_7EA1A9DB4C78BE14) && isDefined(slot) && (slot == "primary" || slot == "secondary"))
      maxammo = self[[level._id_7EA1A9DB4C78BE14]](ref, slot);

    if(!isDefined(maxammo)) {
      if(ref == "equip_armorplate")
        return _id_07C40FA80892A721::_id_047320A25B8EE003();

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk"))
        _id_3002827BCA3DC613 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_extraoffhandammo");
      else
        _id_3002827BCA3DC613 = 0;

      maxammo = weaponmaxammo(_id_8BF83D28BE4C2D4F.objweapon, _id_3002827BCA3DC613);

      switch (ref) {
        case "equip_binoculars":
        case "equip_hb_sensor":
        case "equip_geigercounter":
        case "equip_tac_cover":
          break;
        default:
          if(level.gametype != "missions")
            maxammo--;

          break;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk")) {
        if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_extra_deadly") && isDefined(slot) && slot == "primary")
          maxammo++;

        if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_extra_tactical") && isDefined(slot) && slot == "primary")
          maxammo++;
      }
    }
  } else {
    _id_F4692D0892428480 = level.br_pickups.br_equipnametoscriptable[_id_8BF83D28BE4C2D4F.ref];
    maxammo = level.br_pickups.maxcounts[_id_F4692D0892428480];

    if(!isDefined(maxammo))
      maxammo = 0;

    if(ref == "equip_armorplate") {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "hasPlatePouch")) {
        if(self[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "hasPlatePouch")]]())
          maxammo = maxammo + getdvarint("dvar_A5AB8ED6CC1B486A", 3);
      }
    }
  }

  return maxammo;
}

getequipmentstartammo(ref) {
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F))
    return undefined;

  if(!isDefined(_id_8BF83D28BE4C2D4F.objweapon))
    return 0;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("perk", "hasPerk"))
    _id_3002827BCA3DC613 = self[[scripts\cp_mp\utility\script_utility::getsharedfunc("perk", "hasPerk")]]("specialty_extraoffhandammo");
  else
    _id_3002827BCA3DC613 = 0;

  return weaponstartammo(_id_8BF83D28BE4C2D4F.objweapon, _id_3002827BCA3DC613);
}

getequipmentammo(ref) {
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F))
    return undefined;

  if(!isDefined(_id_8BF83D28BE4C2D4F.objweapon))
    return 0;

  return self getammocount(_id_8BF83D28BE4C2D4F.objweapon);
}

setequipmentammo(ref, amount) {
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F) || !isDefined(_id_8BF83D28BE4C2D4F.objweapon)) {
    return;
  }
  _id_A1A3722FB9707783 = self getweaponslistoffhands();

  foreach(_id_2EB789D043254817 in _id_A1A3722FB9707783) {
    _id_1189BD7FBE2861F8 = _id_7F245729FCB6414D(_id_2EB789D043254817.basename);

    if(isDefined(_id_1189BD7FBE2861F8) && _id_1189BD7FBE2861F8 == ref) {
      variantid = undefined;
      weapon = undefined;

      if(isDefined(_id_2EB789D043254817.variantid) && _id_2EB789D043254817.variantid > 0) {
        variantid = _id_2EB789D043254817.variantid;
        weapon = _id_9E77A3E4BB6C6E31(_id_2EB789D043254817.basename, variantid);
      } else
        weapon = _id_8BF83D28BE4C2D4F.objweapon;

      self setweaponammoclip(weapon, amount);
      break;
    }
  }

  _id_22BF78ECA6578D7D(findequipmentslot(ref));
}

_id_1AB06E1478168800() {
  _id_6B7CFC68E3D8BE96 = 0;
  primary = getcurrentequipment("primary");

  if(isDefined(primary))
    _id_6B7CFC68E3D8BE96 = incrementequipmentammo(primary, getequipmentmaxammo(primary));

  _id_A13BCA6B74DB722A = 0;
  _id_D7B9856A19F9B6B5 = getcurrentequipment("secondary");

  if(isDefined(_id_D7B9856A19F9B6B5))
    _id_A13BCA6B74DB722A = incrementequipmentammo(_id_D7B9856A19F9B6B5, getequipmentmaxammo(_id_D7B9856A19F9B6B5));

  return _id_6B7CFC68E3D8BE96 || _id_A13BCA6B74DB722A;
}

_id_91BD2A98062313CB(slot, amount) {
  ref = getcurrentequipment(slot);
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F.objweapon)) {
    return;
  }
  self setweaponammoclip(_id_8BF83D28BE4C2D4F.objweapon, amount);
  _id_22BF78ECA6578D7D(findequipmentslot(ref));
}

incrementequipmentammo(ref, _id_930290D7F474A0AE) {
  if(!isDefined(_id_930290D7F474A0AE))
    _id_930290D7F474A0AE = 1;

  _id_3DBC3B058135CBFB = getequipmentammo(ref);
  _id_2AA9CAEF99C9AF77 = int(min(_id_3DBC3B058135CBFB + _id_930290D7F474A0AE, getequipmentmaxammo(ref)));
  setequipmentammo(ref, _id_2AA9CAEF99C9AF77);
  return _id_3DBC3B058135CBFB != _id_2AA9CAEF99C9AF77;
}

decrementequipmentammo(ref, _id_7D2E0EA9107A4C02) {
  if(!isDefined(_id_7D2E0EA9107A4C02))
    _id_7D2E0EA9107A4C02 = 1;

  _id_3DBC3B058135CBFB = getequipmentammo(ref);
  _id_7D2E0EA9107A4C02 = int(min(_id_7D2E0EA9107A4C02, _id_3DBC3B058135CBFB));

  if(_id_7D2E0EA9107A4C02 > 0) {
    _id_2AA9CAEF99C9AF77 = int(min(_id_3DBC3B058135CBFB - _id_7D2E0EA9107A4C02, getequipmentmaxammo(ref)));
    setequipmentammo(ref, _id_2AA9CAEF99C9AF77);
  }
}

incrementequipmentslotammo(slot, _id_930290D7F474A0AE) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref))
    return undefined;

  if(!isDefined(_id_930290D7F474A0AE))
    _id_930290D7F474A0AE = 1;

  _id_3DBC3B058135CBFB = getequipmentammo(ref);
  _id_2AA9CAEF99C9AF77 = int(min(_id_3DBC3B058135CBFB + _id_930290D7F474A0AE, getequipmentmaxammo(ref)));
  setequipmentammo(ref, _id_2AA9CAEF99C9AF77);
}

decrementequipmentslotammo(slot, _id_7D2E0EA9107A4C02) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref))
    return undefined;

  if(!isDefined(_id_7D2E0EA9107A4C02))
    _id_7D2E0EA9107A4C02 = 1;

  _id_3DBC3B058135CBFB = getequipmentammo(ref);
  _id_2AA9CAEF99C9AF77 = int(min(_id_3DBC3B058135CBFB - _id_7D2E0EA9107A4C02, getequipmentmaxammo(ref)));

  if(scripts\common\utility::iscp() && ref == "equip_armorplate")
    _id_07C40FA80892A721::_id_774133DC8DF0CCD5(_id_2AA9CAEF99C9AF77);
  else
    setequipmentammo(ref, _id_2AA9CAEF99C9AF77);
}

getequipmentslotammo(slot) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref))
    return undefined;

  return getequipmentammo(ref);
}

setequipmentslotammo(slot, count) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref))
    return undefined;

  return setequipmentammo(ref, count);
}

_id_7F245729FCB6414D(weaponname) {
  if(!isDefined(weaponname))
    return undefined;

  foreach(_id_8BF83D28BE4C2D4F in level.equipment.table) {
    if(isDefined(_id_8BF83D28BE4C2D4F.weaponname) && weaponname == _id_8BF83D28BE4C2D4F.weaponname)
      return _id_8BF83D28BE4C2D4F.ref;
  }

  return undefined;
}

_id_2113B6F7CB462692(weaponname) {
  if(!isDefined(weaponname))
    return undefined;

  foreach(_id_8BF83D28BE4C2D4F in level.equipment.table) {
    if(isDefined(_id_8BF83D28BE4C2D4F.weaponname) && weaponname == _id_8BF83D28BE4C2D4F.weaponname)
      return _id_8BF83D28BE4C2D4F._id_D442547D75DFFD09;
  }

  return undefined;
}

mapequipmentweaponforref(objweapon) {
  weaponname = undefined;

  switch (objweapon.basename) {
    case "throwingknife_fire_mp":
    case "throwingknife_mp":
      weaponname = "throwingknife_mp";
      break;
    case "claymore_radial_mp":
      weaponname = "claymore_mp";
      break;
    case "at_mine_ap_mp":
      weaponname = "at_mine_mp";
      break;
    case "thermite_ap_mp":
    case "thermite_av_mp":
      weaponname = "thermite_mp";
      break;
    case "bunkerbuster_round_mp":
    case "bunkerbuster_not_burrowed_mp":
    case "bunkerbuster_burrowed_mp":
      weaponname = "bunkerbuster_mp";
      break;
    case "shock_stick_underwater_mp":
      weaponname = "shock_stick_mp";
      break;
  }

  if(isDefined(weaponname)) {
    attachments = _func_6527364C1ECCA6C6(weaponname);
    return makeweapon(weaponname, attachments);
  }

  return objweapon;
}

getequipmentreffromweapon(objweapon) {
  objweapon = mapequipmentweaponforref(objweapon);

  foreach(_id_8BF83D28BE4C2D4F in level.equipment.table) {
    if(isDefined(_id_8BF83D28BE4C2D4F.objweapon) && objweapon == _id_8BF83D28BE4C2D4F.objweapon)
      return _id_8BF83D28BE4C2D4F.ref;
  }

  return undefined;
}

getweaponfromequipmentref(_id_1189BD7FBE2861F8) {
  foreach(_id_8BF83D28BE4C2D4F in level.equipment.table) {
    if(isDefined(_id_8BF83D28BE4C2D4F.ref) && _id_1189BD7FBE2861F8 == _id_8BF83D28BE4C2D4F.ref)
      return _id_8BF83D28BE4C2D4F.objweapon;
  }

  return undefined;
}

hasequipment(ref) {
  if(!isDefined(self.equipment))
    return 0;

  foreach(_id_F03830BD1CD0CF91 in self.equipment) {
    if(_id_F03830BD1CD0CF91 == ref)
      return 1;
  }

  return 0;
}

findequipmentslot(ref) {
  if(!isDefined(self.equipment))
    return undefined;

  foreach(slot, _id_F03830BD1CD0CF91 in self.equipment) {
    if(_id_F03830BD1CD0CF91 == ref)
      return slot;
  }
}

isequipmentlethal(ref) {
  return isequipmentprimary(ref);
}

isequipmentprimary(ref) {
  if(isDefined(ref) && isDefined(level.equipment.table[ref]))
    return level.equipment.table[ref].defaultslot == "primary";
  else
    return 0;
}

isequipmenttactical(ref) {
  return isequipmentsecondary(ref);
}

isequipmentsecondary(ref) {
  if(isDefined(ref) && isDefined(level.equipment.table[ref]))
    return level.equipment.table[ref].defaultslot == "secondary";
  else
    return 0;
}

isequipmentselectable(ref) {
  if(!isDefined(ref))
    return 0;

  if(isDefined(level.equipment.table[ref]))
    return istrue(level.equipment.table[ref].isselectable);
  else
    return 0;
}

_id_22BF78ECA6578D7D(slot) {
  if(!isDefined(self.equipment) || self.equipment.size == 0) {
    return;
  }
  ammo = 0;
  maxammo = 0;
  ref = getcurrentequipment(slot);

  if(isDefined(ref)) {
    ammo = getequipmentslotammo(slot);
    maxammo = getequipmentmaxammo(ref);
  }

  if(slot == "primary") {
    self setclientomnvar("ui_power_num_charges", ammo);
    self setpowerammo("primary", ammo, maxammo);
  } else if(slot == "secondary") {
    self setclientomnvar("ui_power_secondary_num_charges", ammo);
    self setpowerammo("secondary", ammo, maxammo);
  } else if(slot == "health") {
    if(isDefined(self.pers["telemetry"]._id_D5E1E009ED9EB9A8))
      self.pers["telemetry"]._id_D5E1E009ED9EB9A8++;

    self setclientomnvar("ui_equipment_id_health_numCharges", ammo, maxammo);
  }
}

equiponplayerspawned() {
  thread watchoffhandfired();
}

resetequipment() {
  self.equipment = [];
}

executeoffhandfired(objweapon) {
  foreach(slot, ref in self.equipment) {
    _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

    if(isDefined(_id_8BF83D28BE4C2D4F.objweapon) && objweapon == _id_8BF83D28BE4C2D4F.objweapon) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "isBRStyleGameType") && [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "isBRStyleGameType")]]()) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("dlog", "brAnalytics_equipmentUse"))
          [[scripts\cp_mp\utility\script_utility::getsharedfunc("dlog", "brAnalytics_equipmentUse")]](self, objweapon);
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getEquipmentRefFromWeapon")) {
        weaponref = [[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getEquipmentRefFromWeapon")]](objweapon);

        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "combatRecordEquipmentUsed"))
          self[[scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "combatRecordEquipmentUsed")]](weaponref);
      }

      _id_98806EF14E691FF7 = getcallback(ref, "onFired");

      if(isDefined(_id_98806EF14E691FF7))
        self thread[[_id_98806EF14E691FF7]](ref, slot, objweapon);

      ammo = 0;
      ref = getcurrentequipment(slot);

      if(isDefined(ref))
        ammo = getequipmentslotammo(slot);

      if(ammo == 0 && isDefined(level._id_87A4731D4DCE4C3F)) {
        success = self[[level._id_87A4731D4DCE4C3F]](self, slot, ref);

        if(istrue(success)) {
          break;
        }
      }

      _id_22BF78ECA6578D7D(slot);
      break;
    }
  }
}

watchoffhandfired() {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("offhand_fired", objweapon);
    executeoffhandfired(objweapon);
  }
}

givescavengerammo() {
  foreach(slot, ref in self.equipment) {
    _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

    if(_id_8BF83D28BE4C2D4F.scavengerammo > 0)
      incrementequipmentammo(ref, _id_8BF83D28BE4C2D4F.scavengerammo);
  }
}

getdefaultslot(ref) {
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F))
    return undefined;

  return _id_8BF83D28BE4C2D4F.defaultslot;
}

watchlethaldelay() {
  level endon("lethal_delay_end");
  level endon("round_end");
  level endon("game_ended");
  scripts\mp\flags::gameflagwait("prematch_done");
  currentgametypestopsclock = currentgametypestopsclock();

  if(currentgametypestopsclock)
    level.lethaldelaystarttime = gettime();
  else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTimePassed"))
    level.lethaldelaystarttime = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTimePassed")]]();

  if(level.lethaldelay == 0) {
    level.lethaldelayendtime = level.lethaldelaystarttime;
    level notify("lethal_delay_end");
  }

  level.lethaldelayendtime = level.lethaldelaystarttime + level.lethaldelay * 1000;
  level notify("lethal_delay_start");

  for(;;) {
    currenttime = undefined;

    if(currentgametypestopsclock)
      currenttime = gettime();
    else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTimePassed"))
      currenttime = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTimePassed")]]();

    if(currenttime >= level.lethaldelayendtime) {
      break;
    }

    waitframe();
  }

  level notify("lethal_delay_end");
}

watchlethaldelayplayer(equipmentref, slot) {
  self endon("death_or_disconnect");
  level endon("round_end");
  level endon("game_ended");

  if(lethaldelaypassed()) {
    return;
  }
  self notify("watchLethalDelayPlayer_" + slot);
  self endon("watchLethalDelayPlayer_" + slot);
  self endon("equipment_taken_" + equipmentref);

  if(!isDefined(self.lethaldelayallows) || !istrue(self.lethaldelayallows[slot])) {
    if(!isDefined(self.lethaldelayallows))
      self.lethaldelayallows = [];

    self.lethaldelayallows[slot] = 1;

    if(slot == "primary ")
      _id_3B64EB40368C1450::set("watchLethalDelayPlayer", "equipment_primary", 0);
    else
      _id_3B64EB40368C1450::set("watchLethalDelayPlayer", "equipment_secondary", 0);
  }

  watchlethaldelayfeedbackplayer(self, slot);

  if(isDefined(self.lethaldelayallows) && istrue(self.lethaldelayallows[slot])) {
    self.lethaldelayallows[slot] = undefined;

    if(self.lethaldelayallows.size == 0)
      self.lethaldelayallows = undefined;

    _id_3B64EB40368C1450::_id_C9D0B43701BDBA00("watchLethalDelayPlayer");
  }
}

watchlethaldelayfeedbackplayer(player, slot) {
  level endon("lethal_delay_end");

  if(!istrue(scripts\mp\flags::gameflag("prematch_done")))
    level waittill("lethal_delay_start");

  _id_10D8148F3496F8DE = "+frag";

  if(slot != "primary")
    _id_10D8148F3496F8DE = "+smoke";

  if(!isai(player))
    player notifyonplayercommand("lethal_attempt_" + slot, _id_10D8148F3496F8DE);

  currentgametypestopsclock = currentgametypestopsclock();

  for(;;) {
    self waittill("lethal_attempt_" + slot);
    currenttime = undefined;

    if(currentgametypestopsclock)
      currenttime = gettime();
    else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTimePassed"))
      currenttime = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTimePassed")]]();

    n = (level.lethaldelayendtime - currenttime) / 1000;
    n = int(max(0, ceil(n)));

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("hud", "showErrorMessage"))
      player[[scripts\cp_mp\utility\script_utility::getsharedfunc("hud", "showErrorMessage")]]("MP/LETHALS_UNAVAILABLE_FOR_N", n);
  }
}

cancellethaldelay() {
  level.lethaldelay = 0;

  if(currentgametypestopsclock())
    level.lethaldelaystarttime = gettime();
  else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTimePassed"))
    level.lethaldelaystarttime = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTimePassed")]]();

  level.lethaldelayendtime = level.lethaldelaystarttime;
  level notify("lethal_delay_end");
}

lethaldelaypassed() {
  if(isDefined(level.lethaldelay) && level.lethaldelay == 0)
    return 1;

  if(isDefined(level.lethaldelayendtime)) {
    currenttime = undefined;

    if(currentgametypestopsclock())
      currenttime = gettime();
    else if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getTimePassed"))
      currenttime = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getTimePassed")]]();

    return currenttime > level.lethaldelayendtime;
  }

  return 0;
}

currentgametypestopsclock() {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "getGameType")) {
    gametype = [[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "getGameType")]]();

    if(gametype == "hq" || gametype == "grnd" || gametype == "koth")
      return 1;
  }

  return 0;
}

onownerdisconnect(player) {
  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getAllEquip")) {
    _id_7C3CE7FF13FBD7FC = player[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getAllEquip")]]();

    foreach(_id_2EB789D043254817 in _id_7C3CE7FF13FBD7FC)
    _id_2EB789D043254817 notify("owner_disconnect");
  }
}

hackequipment(_id_838778220EEDE9FC) {
  self.ishacked = 1;

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("game", "setHasDoneCombat"))
    _id_838778220EEDE9FC[[scripts\cp_mp\utility\script_utility::getsharedfunc("game", "setHasDoneCombat")]](_id_838778220EEDE9FC, 1);

  _id_838778220EEDE9FC scripts\cp_mp\challenges::onhack(self.equipmentref);
  changeowner(_id_838778220EEDE9FC);

  if(level.teambased)
    self filteroutplayermarks(_id_838778220EEDE9FC.team);
  else
    self filteroutplayermarks(_id_838778220EEDE9FC);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("killstreak", "giveScoreForHack"))
    _id_838778220EEDE9FC[[scripts\cp_mp\utility\script_utility::getsharedfunc("killstreak", "giveScoreForHack")]]();
}

changeowner(_id_838778220EEDE9FC) {
  _id_C0F9139FFD72E62D = self.owner;
  self setentityowner(_id_838778220EEDE9FC);
  self.owner = _id_838778220EEDE9FC;
  self.team = _id_838778220EEDE9FC.team;
  self setotherent(_id_838778220EEDE9FC);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "removeEquip"))
    _id_C0F9139FFD72E62D[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "removeEquip")]](self);

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "updatePlantedArray"))
    self.owner[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "updatePlantedArray")]](self);

  _id_DAE55EE219002CD1 = getcallback(self.equipmentref, "onOwnerChanged");
  self notify("ownerChanged");

  if(isDefined(_id_DAE55EE219002CD1))
    self[[_id_DAE55EE219002CD1]](_id_C0F9139FFD72E62D);
}

debughackequipment() {
  for(;;) {
    if(getdvarint("scr_debughackequipment") != 0) {
      _id_DAD9C3E8B724D629 = level.players[0];
      _id_AA74D78F1A2354AE = undefined;

      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "isEnemy") && _id_DAD9C3E8B724D629[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "isEnemy")]](level.players[_id_AC0E594AC96AA3A8])) {
          _id_AA74D78F1A2354AE = level.players[_id_AC0E594AC96AA3A8];
          break;
        }
      }

      if(!isDefined(_id_AA74D78F1A2354AE)) {
        iprintlnbold("Need a player on the other team to scr_debugHackEquipment");
        continue;
      }

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("equipment", "getAllEquip")) {
        _id_7C3CE7FF13FBD7FC = _id_DAD9C3E8B724D629[[scripts\cp_mp\utility\script_utility::getsharedfunc("equipment", "getAllEquip")]]();
        equipment = undefined;

        if(_id_7C3CE7FF13FBD7FC.size > 0)
          equipment = _id_7C3CE7FF13FBD7FC[0];

        if(!isDefined(equipment)) {
          iprintlnbold("First player must have at least one piece of equipment to scr_debugHackEquipment");
          continue;
        }

        equipment hackequipment(_id_AA74D78F1A2354AE);
      }
    }

    waitframe();
  }
}

debugemp() {
  for(;;) {
    if(getdvarint("scr_testempgrenade") != 0) {
      if(level.players.size < 2) {
        iprintlnbold("Need at least two players to scr_testEMPGrenade");
        continue;
      }

      _id_204DA528AA0A3464 = level.players[1];

      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("weapons", "_launchGrenade"))
        _id_204DA528AA0A3464[[scripts\cp_mp\utility\script_utility::getsharedfunc("weapons", "_launchGrenade")]]("emp_grenade_mp", (0, 0, 0), (0, 0, 0), 0.05, 0);
    }

    waitframe();
  }
}

debugempdrone() {
  for(;;) {
    if(getdvarint("scr_testempdrone") != 0) {
      if(level.players.size < 2) {
        iprintlnbold("Need at least two players to scr_testEMPDrone");
        continue;
      }

      _id_17F832B5DE7083A0 = level.players[0];
      _id_204DA528AA0A3464 = level.players[1];
      streakinfo = spawnStruct();
      streakinfo.streakname = "emp_drone";
      streakinfo.owner = _id_204DA528AA0A3464;
      streakinfo.id = scripts\cp_mp\utility\killstreak_utility::getuniquekillstreakid(_id_204DA528AA0A3464);
      streakinfo.lifeid = 0;
      targetpos = _id_17F832B5DE7083A0.origin;
      drone = _id_204DA528AA0A3464 scripts\cp_mp\killstreaks\emp_drone_targeted::empdrone_createdrone(streakinfo, targetpos);
    }

    waitframe();
  }
}

debugdestroyempdrones() {
  for(;;) {
    if(getdvarint("dvar_196B4FEBB9F4DD1F") != 0) {
      foreach(_id_F406BE343AB9CC93 in level.activekillstreaks) {
        if(isDefined(_id_F406BE343AB9CC93.streakinfo) && _id_F406BE343AB9CC93.streakinfo.streakname == "emp_drone")
          _id_F406BE343AB9CC93 scripts\cp_mp\killstreaks\emp_drone::empdrone_destroy();
      }
    }

    waitframe();
  }
}

initlethalmaxoffsetmap() {
  level.lethal_equipmentmaskoffsets = [];
  _id_A76C71DA7297BB58 = 0;

  foreach(equipment in level.equipment.table) {
    if(!equipment.isselectable) {
      continue;
    }
    if(equipment.id <= 0) {
      continue;
    }
    if(equipment.defaultslot == "secondary") {
      continue;
    }
    level.lethal_equipmentmaskoffsets[equipment.ref] = 1 << _id_A76C71DA7297BB58;
    _id_A76C71DA7297BB58++;
  }
}

_id_707926E6CE8DDC60(slot, _id_317D7E8B927BD393) {
  if(slot == "primary") {
    _id_F366AF1BB183316C = getcurrentequipment(slot);
    _id_8BF83D28BE4C2D4F = getequipmenttableinfo(_id_F366AF1BB183316C);

    if(!isDefined(_id_8BF83D28BE4C2D4F))
      _id_F366AF1BB183316C = "equip_frag";

    thread giveequipment(_id_F366AF1BB183316C, "primary");
    setequipmentammo(_id_F366AF1BB183316C, _id_317D7E8B927BD393);
  } else if(slot == "secondary") {
    _id_5E7BDAD4B7D0C7AC = getcurrentequipment(slot);
    _id_8BF83D28BE4C2D4F = getequipmenttableinfo(_id_5E7BDAD4B7D0C7AC);

    if(!isDefined(_id_8BF83D28BE4C2D4F))
      _id_5E7BDAD4B7D0C7AC = "equip_flash";

    thread giveequipment(_id_5E7BDAD4B7D0C7AC, "secondary");
    setequipmentammo(_id_5E7BDAD4B7D0C7AC, _id_317D7E8B927BD393);
  }
}