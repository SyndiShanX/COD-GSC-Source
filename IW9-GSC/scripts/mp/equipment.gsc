/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\equipment.gsc
***********************************************/

init() {
  if(getdvarint("dvar_A464CB031C16EE87", 0) > 0)
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_t10_mp";
  else if(getdvarint("mgl", 0) > 0)
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_mgl_mp";
  else
    level._id_E5255D7C501309DD = "equipmentlist:equipment_list_iw9_mp";

  level.equipment = spawnStruct();
  level.equipment.table = [];
  inititems();
  _id_29D51C2A86346A9C(level._id_E5255D7C501309DD);
  initlethalmaxoffsetmap();
  scripts\mp\equipment\adrenaline::_id_22FD49689920FDB1();
  scripts\mp\utility\spawn_event_aggregator::registeronplayerspawncallback(::equiponplayerspawned);
}

inititems() {
  level.equipment.callbacks = [];

  if(getdvarint("dvar_742CAA13B3C2E685")) {
    return;
  }
  _id_584994FAB4A8712B = level.equipment;
  scripts\mp\equipment_interact::equipmentinteract_init();

  if(!istrue(game["isLaunchChunk"])) {
    scripts\mp\perks\headgear::init();
    scripts\mp\equipment\tactical_cover::tac_cover_init();
    scripts\mp\equipment\trophy_system::trophy_init();
    scripts\mp\equipment\decoy_grenade::decoy_init();
    scripts\mp\equipment\at_mine::at_mine_init();
    scripts\mp\equipment\tac_insert::tacinsert_init();
  }

  _id_479E458F6F530F0D::_id_58BF160252F94E21();
  scripts\mp\equipment\claymore::claymore_init();
  scripts\mp\equipment\molotov::molotov_init();
  scripts\mp\equipment\weapon_drop::weapondrop_init();
  scripts\cp_mp\equipment\throwing_knife::throwing_knife_init();
  _id_52D91CB28006A5BD::_id_12D7CA3FF609CABA();
  _id_1CF2ED809496BF4E::_id_35F02578B0C90838();
  _id_156835EF9924856A::_id_80B2D6867C192094();
  _id_13F9DDE7EECFBC71::_id_7C59B9D44AFF939B();
  _id_584994FAB4A8712B.callbacks["equip_helmet"]["onGive"] = scripts\mp\perks\headgear::runheadgear;
  _id_584994FAB4A8712B.callbacks["equip_helmet"]["onTake"] = scripts\mp\perks\headgear::removeheadgear;
  _id_584994FAB4A8712B.callbacks["equip_adrenaline"]["onFired"] = scripts\mp\equipment\adrenaline::onequipmentfired;
  _id_584994FAB4A8712B.callbacks["equip_adrenaline"]["onTake"] = scripts\mp\equipment\adrenaline::onequipmenttaken;
  _id_584994FAB4A8712B.callbacks["equip_c4"]["onGive"] = scripts\mp\equipment\c4::c4_set;
  _id_584994FAB4A8712B.callbacks["equip_trophy"]["onGive"] = scripts\mp\equipment\trophy_system::trophy_set;
  _id_584994FAB4A8712B.callbacks["equip_trophy"]["onTake"] = scripts\mp\equipment\trophy_system::trophy_unset;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife"]["onIncrement"] = scripts\cp_mp\equipment\throwing_knife::_id_D763DF6D36A1E34A;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife_fire"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife_fire"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife_electric"]["onGive"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ongive;
  _id_584994FAB4A8712B.callbacks["equip_throwing_knife_electric"]["onTake"] = scripts\cp_mp\equipment\throwing_knife::throwing_knife_ontake;
  _id_584994FAB4A8712B.callbacks["equip_throwstar"]["onGive"] = _id_52D91CB28006A5BD::_id_E7715FFB329C1B40;
  _id_584994FAB4A8712B.callbacks["equip_throwstar"]["onTake"] = _id_52D91CB28006A5BD::_id_092E126D1A5D3FB2;
  _id_584994FAB4A8712B.callbacks["equip_molotov"]["onGive"] = scripts\mp\equipment\molotov::molotov_on_give;
  _id_584994FAB4A8712B.callbacks["equip_molotov"]["onTake"] = scripts\mp\equipment\molotov::molotov_on_take;
  _id_584994FAB4A8712B.callbacks["equip_tac_cover"]["onGive"] = scripts\mp\equipment\tactical_cover::tac_cover_on_give;
  _id_584994FAB4A8712B.callbacks["equip_tac_cover"]["onTake"] = scripts\mp\equipment\tactical_cover::tac_cover_on_take;
  _id_584994FAB4A8712B.callbacks["equip_tac_cover"]["onFired"] = scripts\mp\equipment\tactical_cover::tac_cover_on_fired;
  _id_584994FAB4A8712B.callbacks["equip_tac_insert"]["onGive"] = scripts\mp\equipment\tac_insert::tacinsert_set;
  _id_584994FAB4A8712B.callbacks["equip_tac_insert"]["onTake"] = scripts\mp\equipment\tac_insert::tacinsert_unset;
  _id_584994FAB4A8712B.callbacks["equip_binoculars"]["onGive"] = scripts\mp\equipment\binoculars::binoculars_ongive;
  _id_584994FAB4A8712B.callbacks["equip_binoculars"]["onTake"] = scripts\mp\equipment\binoculars::binoculars_ontake;
  _id_584994FAB4A8712B.callbacks["equip_iodine_pills"]["onGive"] = _id_156835EF9924856A::_id_43FE8CCC8B4E6146;
  _id_584994FAB4A8712B.callbacks["equip_iodine_pills"]["onTake"] = _id_156835EF9924856A::_id_D41FE283435E26C4;
  _id_584994FAB4A8712B.callbacks["equip_geigercounter"]["onGive"] = _id_479E458F6F530F0D::_id_60CBA38635FD35CB;
  _id_584994FAB4A8712B.callbacks["equip_geigercounter"]["onTake"] = _id_479E458F6F530F0D::_id_BDD02627BCAFE359;
  _id_584994FAB4A8712B.callbacks["equip_hb_sensor"]["onGive"] = _id_0EC0F9AD939B29E0::_id_78CE4BFDA3E762B3;
  _id_584994FAB4A8712B.callbacks["equip_hb_sensor"]["onTake"] = _id_0EC0F9AD939B29E0::_id_7F948B7F43448EA9;
  _id_584994FAB4A8712B.callbacks["equip_hb_sensor"]["onIncrement"] = _id_0EC0F9AD939B29E0::_id_3EFD622905908041;
  _id_584994FAB4A8712B.callbacks["equip_thermal_phone"]["onGive"] = _id_13F9DDE7EECFBC71::_id_D7B50D4592CD5421;
  _id_584994FAB4A8712B.callbacks["equip_thermal_phone"]["onTake"] = _id_13F9DDE7EECFBC71::_id_E49FA2736F79E04B;
  _id_584994FAB4A8712B.callbacks["equip_gas_grenade"]["onPlayerDamaged"] = scripts\mp\equipment\gas_grenade::gas_onplayerdamaged;
  _id_584994FAB4A8712B.callbacks["equip_flash"]["onPlayerDamaged"] = scripts\mp\equipment\flash_grenade::onplayerdamaged;
  _id_584994FAB4A8712B.callbacks["equip_concussion"]["onPlayerDamaged"] = scripts\mp\equipment\concussion_grenade::onplayerdamaged;
  _id_584994FAB4A8712B.callbacks["equip_thermite"]["onPlayerDamaged"] = scripts\mp\equipment\thermite::thermite_onplayerdamaged;
  _id_584994FAB4A8712B.callbacks["equip_molotov"]["onPlayerDamaged"] = scripts\mp\equipment\molotov::molotov_on_player_damaged;
  _id_584994FAB4A8712B.callbacks["equip_emp"]["onPlayerDamaged"] = scripts\mp\equipment\emp_grenade::_id_16E153EA7C832F71;
  _id_584994FAB4A8712B.callbacks["equip_shockstick"]["onPlayerDamaged"] = _id_0A35012B9B75A996::_id_CA6C37E5D8F35C8B;
  _id_584994FAB4A8712B.callbacks["equip_bunkerbuster"]["onPlayerDamaged"] = _id_6E2BB9330396AFCB::_id_66629D921C921905;
  _id_584994FAB4A8712B.callbacks["equip_at_mine"]["onOwnerChanged"] = scripts\mp\equipment\at_mine::at_mine_onownerchanged;
  _id_584994FAB4A8712B.callbacks["equip_claymore"]["onOwnerChanged"] = scripts\mp\equipment\claymore::claymore_onownerchanged;
  _id_584994FAB4A8712B.callbacks["equip_c4"]["onOwnerChanged"] = scripts\mp\equipment\c4::c4_onownerchanged;
  _id_584994FAB4A8712B.callbacks["equip_trophy"]["onOwnerChanged"] = scripts\mp\equipment\trophy_system::_id_D70F6FA2C37C1230;
  _id_584994FAB4A8712B.callbacks["equip_at_mine"]["onDestroyedByTrophy"] = scripts\mp\equipment\at_mine::at_mine_delete;
  _id_584994FAB4A8712B.callbacks["equip_claymore"]["onDestroyedByTrophy"] = scripts\mp\equipment\claymore::claymore_delete;
  _id_584994FAB4A8712B.callbacks["equip_trophy"]["onDestroyedByTrophy"] = scripts\mp\equipment\trophy_system::trophy_delete;
  _id_584994FAB4A8712B.callbacks["equip_c4"]["onDestroyedByTrophy"] = scripts\mp\equipment\c4::c4_delete;
  _id_584994FAB4A8712B.callbacks["equip_snapshot_grenade"]["onDestroyedByTrophy"] = scripts\mp\equipment\snapshot_grenade::snapshot_grenade_delete;
  _id_584994FAB4A8712B.callbacks["equip_deployed_decoy"]["onDestroyedByTrophy"] = _id_1CF2ED809496BF4E::_id_0EC4ED8B35F49093;
  _id_584994FAB4A8712B.callbacks["cluster_spike"]["onDestroyedByTrophy"] = _id_10AD6174C8938599::_id_B89726DBBC1C74F6;
  _id_584994FAB4A8712B.callbacks["cluster_spike_proj"]["onDestroyedByTrophy"] = _id_10AD6174C8938599::_id_B89726DBBC1C74F6;
  thread watchlethaldelay();
  scripts\mp\utility\disconnect_event_aggregator::registerondisconnecteventcallback(::onownerdisconnect);
}

getcallback(ref, callback) {
  if(!isDefined(level.equipment.callbacks[ref]))
    return undefined;

  return level.equipment.callbacks[ref][callback];
}

_id_29D51C2A86346A9C(_id_E5255D7C501309DD) {
  level._id_A1E3B0D7B2A7836F = [];
  _id_9DF9FE298AEF6003 = getscriptbundle(_id_E5255D7C501309DD);

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

          if(!isnullweapon(baseweapon)) {
            attachments = _func_6527364C1ECCA6C6(weaponname);
            attachments = _id_59479D0D49471ED7(attachments, equipmentref);
          }

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

_id_59479D0D49471ED7(attachments, equipmentref) {
  if(scripts\cp_mp\utility\game_utility::isnightmap()) {
    if(equipmentref == "equip_binoculars")
      attachments = scripts\engine\utility::_id_3F20731855B91679(attachments, "iw9_spotterscope_offhand", "iw9_spotterscope_offhand_therm");
  }

  return attachments;
}

getequipmenttableinfo(ref) {
  if(!isDefined(ref))
    return undefined;

  return level.equipment.table[ref];
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
  takeequipment(slot);
  weapon = undefined;

  if(!isDefined(variantid) && isDefined(self._id_A6DD5C7E74106CE3) && isDefined(self._id_A6DD5C7E74106CE3[ref]))
    variantid = self._id_A6DD5C7E74106CE3[ref];

  if(isDefined(variantid) && variantid > 0)
    weapon = _id_7EF95BBA57DC4B82::_id_9E77A3E4BB6C6E31(_id_8BF83D28BE4C2D4F.weaponname, variantid);
  else
    weapon = _id_8BF83D28BE4C2D4F.objweapon;

  if(isDefined(weapon)) {
    self giveweapon(weapon);
    _id_AFDCB24F5375AC21 = is_equipment_slot_allowed(slot) || istrue(level._id_AEFA27A676322B3F) && !scripts\mp\flags::gameflag("prematch_done");

    if(_id_AFDCB24F5375AC21 && !_id_8BF83D28BE4C2D4F.ispassive) {
      if(slot == "primary")
        self assignweaponoffhandprimary(weapon);
      else if(slot == "secondary")
        self assignweaponoffhandsecondary(weapon);
      else if(slot == "super")
        self assignweaponoffhandspecial(weapon);
    }
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

  if(isDefined(_id_8BF83D28BE4C2D4F) && isDefined(_id_8BF83D28BE4C2D4F.objweapon)) {
    weapon = _id_8BF83D28BE4C2D4F.objweapon;

    if(isDefined(self._id_A6DD5C7E74106CE3) && isDefined(self._id_A6DD5C7E74106CE3[ref])) {
      variantid = self._id_A6DD5C7E74106CE3[ref];
      weapon = _id_7EF95BBA57DC4B82::_id_9E77A3E4BB6C6E31(_id_8BF83D28BE4C2D4F.weaponname, variantid);
    }

    if(self hasweapon(weapon)) {
      scripts\cp_mp\utility\inventory_utility::_takeweapon(weapon);

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
    } else if(scripts\mp\weapons::isplantedequipment(self)) {
      thread scripts\mp\weapons::deleteexplosive();
      return 1;
    }
  }

  return 0;
}

_id_4967838290CB31B9(index) {
  switch (index) {
    case 0:
      return "primary";
    case 1:
      return "secondary";
    case 2:
      return "health";
    default:
  }
}

disableslotinternal(slot) {
  if(slot == "primary")
    self clearoffhandprimary();
  else if(slot == "secondary")
    self clearoffhandsecondary();
  else if(slot == "super")
    self clearoffhandspecial();
}

enableslotinternal(slot) {
  ref = getcurrentequipment(slot);

  if(!isDefined(ref)) {
    return;
  }
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(isDefined(_id_8BF83D28BE4C2D4F) && isDefined(_id_8BF83D28BE4C2D4F.objweapon) && !_id_8BF83D28BE4C2D4F.ispassive) {
    if(slot == "primary")
      self assignweaponoffhandprimary(_id_8BF83D28BE4C2D4F.objweapon);
    else if(slot == "secondary")
      self assignweaponoffhandsecondary(_id_8BF83D28BE4C2D4F.objweapon);
    else if(slot == "super")
      self assignweaponoffhandspecial(_id_8BF83D28BE4C2D4F.objweapon);
  }
}

is_equipment_slot_allowed(slot) {
  switch (slot) {
    case "primary":
      return _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("equipment_primary");
    case "secondary":
      return _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("equipment_secondary");
    default:
      return _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("equipment_primary") && _id_3B64EB40368C1450::_id_E0751B03DFB9EB43("equipment_secondary");
  }
}

sethudslot(slot, id) {
  if(slot != "super")
    self setclientomnvar("ui_equipment_id_" + slot, id);
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
    if(ref == "equip_armorplate")
      return _id_07C40FA80892A721::_id_047320A25B8EE003();

    _id_3002827BCA3DC613 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
    maxammo = weaponmaxammo(_id_8BF83D28BE4C2D4F.objweapon, _id_3002827BCA3DC613);

    switch (ref) {
      case "equip_tac_insert":
      case "equip_hb_sensor":
      case "equip_binoculars":
      case "equip_geigercounter":
      case "equip_tac_cover":
        break;
      default:
        maxammo--;
        break;
    }

    slot = findequipmentslot(ref);

    if(scripts\mp\utility\perk::_hasperk("specialty_extra_deadly") && slot == "primary")
      maxammo++;

    if(scripts\mp\utility\perk::_hasperk("specialty_extra_tactical") && slot == "secondary")
      maxammo++;
  } else {
    if(!isDefined(_id_8BF83D28BE4C2D4F.ref))
      return 0;

    _id_F4692D0892428480 = level.br_pickups.br_equipnametoscriptable[_id_8BF83D28BE4C2D4F.ref];
    maxammo = level.br_pickups.maxcounts[_id_F4692D0892428480];

    if(!isDefined(maxammo))
      maxammo = 0;

    if(ref == "equip_armorplate") {
      if(_id_2CEDCC356F1B9FC8::hasplatepouch())
        maxammo = maxammo + getdvarint("dvar_A5AB8ED6CC1B486A", 5);

      if(istrue(level._id_06D1D9E1B59C6F37))
        maxammo = level._id_06D1D9E1B59C6F37;
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

  _id_3002827BCA3DC613 = scripts\mp\utility\perk::_hasperk("specialty_extraoffhandammo");
  return weaponstartammo(_id_8BF83D28BE4C2D4F.objweapon, _id_3002827BCA3DC613);
}

getequipmentammo(ref) {
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F))
    return undefined;

  if(!isDefined(_id_8BF83D28BE4C2D4F.objweapon))
    return 0;

  ammocount = self getammocount(_id_8BF83D28BE4C2D4F.objweapon);

  if(ammocount == 0) {
    _id_45AC76D4327FA160 = _id_8BF83D28BE4C2D4F.objweapon.basename;

    foreach(weaponobj in self.offhandinventory) {
      if(weaponobj.basename == _id_45AC76D4327FA160)
        ammocount = self getammocount(weaponobj);
    }
  }

  return ammocount;
}

setequipmentammo(ref, amount) {
  _id_8BF83D28BE4C2D4F = getequipmenttableinfo(ref);

  if(!isDefined(_id_8BF83D28BE4C2D4F) || !isDefined(_id_8BF83D28BE4C2D4F.objweapon)) {
    return;
  }
  _id_A1A3722FB9707783 = self getweaponslistoffhands();
  found = 0;

  foreach(_id_2EB789D043254817 in _id_A1A3722FB9707783) {
    _id_1189BD7FBE2861F8 = _id_7F245729FCB6414D(_id_2EB789D043254817.basename);

    if(isDefined(_id_1189BD7FBE2861F8) && _id_1189BD7FBE2861F8 == ref) {
      variantid = undefined;
      weapon = undefined;
      found = 1;

      if(isDefined(_id_2EB789D043254817.variantid) && _id_2EB789D043254817.variantid > 0) {
        variantid = _id_2EB789D043254817.variantid;
        weapon = _id_7EF95BBA57DC4B82::_id_9E77A3E4BB6C6E31(_id_2EB789D043254817.basename, variantid);
      } else
        weapon = _id_8BF83D28BE4C2D4F.objweapon;

      self setweaponammoclip(weapon, amount);
      break;
    }
  }

  if(!istrue(found)) {
    weapon = _id_8BF83D28BE4C2D4F.objweapon;
    self setweaponammoclip(weapon, amount);
  }

  _id_22BF78ECA6578D7D(findequipmentslot(ref));
}

incrementequipmentammo(ref, _id_930290D7F474A0AE, _id_7AF3206C6EF0C3F0) {
  if(!isDefined(_id_930290D7F474A0AE))
    _id_930290D7F474A0AE = 1;

  _id_3DBC3B058135CBFB = getequipmentammo(ref);
  _id_2AA9CAEF99C9AF77 = int(min(_id_3DBC3B058135CBFB + _id_930290D7F474A0AE, getequipmentmaxammo(ref)));

  if(!istrue(_id_7AF3206C6EF0C3F0)) {
    _id_CD1C409BF48E2722 = getcallback(ref, "onIncrement");

    if(isDefined(_id_CD1C409BF48E2722))
      self thread[[_id_CD1C409BF48E2722]](ref, _id_3DBC3B058135CBFB);
  }

  setequipmentammo(ref, _id_2AA9CAEF99C9AF77);
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
  foreach(_id_8BF83D28BE4C2D4F in level.equipment.table) {
    if(isDefined(_id_8BF83D28BE4C2D4F.weaponname) && weaponname == _id_8BF83D28BE4C2D4F.weaponname)
      return _id_8BF83D28BE4C2D4F.ref;
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
    case "bunkerbuster_round_mp":
    case "bunkerbuster_not_burrowed_mp":
    case "bunkerbuster_burrowed_mp":
      weaponname = "bunkerbuster_mp";
      break;
    case "thermite_av_mp":
    case "thermite_ap_mp":
      weaponname = "thermite_mp";
      break;
    case "trophy_submunition":
      weaponname = "trophy_mp";
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
    if(isDefined(_id_8BF83D28BE4C2D4F.weaponname) && objweapon.basename == _id_8BF83D28BE4C2D4F.weaponname)
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
  if(isDefined(level.equipment.table[ref]))
    return level.equipment.table[ref].defaultslot == "primary";
  else
    return 0;
}

isequipmenttactical(ref) {
  return isequipmentsecondary(ref);
}

isequipmentsecondary(ref) {
  if(isDefined(level.equipment.table[ref]))
    return level.equipment.table[ref].defaultslot == "secondary";
  else
    return 0;
}

_id_F648873E06EE9326(ref) {
  if(isDefined(level.equipment.table[ref]))
    return level.equipment.table[ref].defaultslot == "super";
  else
    return 0;
}

isequipmentselectable(ref) {
  if(isDefined(level.equipment.table[ref]))
    return istrue(level.equipment.table[ref].isselectable);
  else
    return 0;
}

_id_22BF78ECA6578D7D(slot) {
  if(!isDefined(self.equipment)) {
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

    self setclientomnvar("ui_equipment_id_health_numCharges", ammo);
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

    if(isDefined(_id_8BF83D28BE4C2D4F) && isDefined(_id_8BF83D28BE4C2D4F.objweapon) && objweapon == _id_8BF83D28BE4C2D4F.objweapon) {
      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508())
        _id_715028F54BAD19A1::branalytics_equipmentuse(self, objweapon);

      weaponref = getequipmentreffromweapon(objweapon);

      if(!_id_F648873E06EE9326(weaponref))
        scripts\mp\damage::combatrecordequipmentused(weaponref);

      _id_98806EF14E691FF7 = getcallback(ref, "onFired");

      if(isDefined(_id_98806EF14E691FF7))
        self thread[[_id_98806EF14E691FF7]](ref, slot, objweapon);

      if(isDefined(self.team))
        level notify("equipment_used_" + self.team, weaponref);

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

      if(scripts\cp_mp\utility\game_utility::_id_0BEFF479639E6508() && _id_2D9D24F7C63AC143::_id_8B121DD10A442DD2() && !getdvarint("dvar_CED962345FF6ECD0", 0) && !_id_2D9D24F7C63AC143::_id_5BF048439A846222(ref)) {
        scriptablename = level.br_pickups.br_equipnametoscriptable[ref];

        if(_id_2CEDCC356F1B9FC8::_id_6B531C76815D77F3(scriptablename) && !_id_2CEDCC356F1B9FC8::_id_AC3376FECC550EF0(scriptablename)) {
          _id_2D9D24F7C63AC143::_id_51F5AAFA38A37F0F(scriptablename, 1);
          incrementequipmentammo(ref, 1);
        }
      }

      _id_3F61508D8A5C4764 = "tacticalsUsed";

      if(isequipmentlethal(weaponref))
        _id_3F61508D8A5C4764 = "lethalsUsed";

      if(isDefined(self.pers[_id_3F61508D8A5C4764]))
        scripts\mp\utility\stats::incpersstat(_id_3F61508D8A5C4764, 1);

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

    if(isDefined(_id_8BF83D28BE4C2D4F) && _id_8BF83D28BE4C2D4F.scavengerammo > 0)
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
  else
    level.lethaldelaystarttime = scripts\mp\utility\game::gettimepassed();

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
    else
      currenttime = scripts\mp\utility\game::gettimepassed();

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

    if(slot == "primary")
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
    else
      currenttime = scripts\mp\utility\game::gettimepassed();

    n = (level.lethaldelayendtime - currenttime) / 1000;
    n = int(max(0, ceil(n)));
    player scripts\mp\hud_message::showerrormessage("MP/LETHALS_UNAVAILABLE_FOR_N", n);
  }
}

cancellethaldelay() {
  level.lethaldelay = 0;

  if(currentgametypestopsclock())
    level.lethaldelaystarttime = gettime();
  else
    level.lethaldelaystarttime = scripts\mp\utility\game::gettimepassed();

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
    else
      currenttime = scripts\mp\utility\game::gettimepassed();

    return currenttime > level.lethaldelayendtime;
  }

  return 0;
}

currentgametypestopsclock() {
  gametype = scripts\mp\utility\game::getgametype();

  if(gametype == "hq" || gametype == "grnd" || gametype == "koth")
    return 1;

  return 0;
}

onownerdisconnect(player) {
  _id_7C3CE7FF13FBD7FC = player scripts\mp\weapons::getallequip();

  foreach(_id_2EB789D043254817 in _id_7C3CE7FF13FBD7FC)
  _id_2EB789D043254817 notify("owner_disconnect");
}

hackequipment(_id_838778220EEDE9FC) {
  self.ishacked = 1;
  _id_838778220EEDE9FC scripts\mp\gamelogic::sethasdonecombat(_id_838778220EEDE9FC, 1);
  _id_838778220EEDE9FC scripts\cp_mp\challenges::onhack(self.equipmentref);
  changeowner(_id_838778220EEDE9FC);

  if(level.teambased)
    self filteroutplayermarks(_id_838778220EEDE9FC.team);
  else
    self filteroutplayermarks(_id_838778220EEDE9FC);

  _id_838778220EEDE9FC scripts\mp\killstreaks\killstreaks::givescoreforhack();
}

changeowner(_id_838778220EEDE9FC) {
  _id_C0F9139FFD72E62D = self.owner;
  self setentityowner(_id_838778220EEDE9FC);
  self.owner = _id_838778220EEDE9FC;
  self.team = _id_838778220EEDE9FC.team;
  self setotherent(_id_838778220EEDE9FC);
  _id_C0F9139FFD72E62D scripts\mp\weapons::removeequip(self);
  self.owner scripts\mp\weapons::updateplantedarray(self);
  _id_DAE55EE219002CD1 = getcallback(self.equipmentref, "onOwnerChanged");
  self notify("ownerChanged");

  if(isDefined(_id_DAE55EE219002CD1))
    self[[_id_DAE55EE219002CD1]](_id_C0F9139FFD72E62D);
}

_id_F69ED22535D90B78() {
  self endon("death");
  level endon("game_ended");
  _id_A681B7890CD017C7 = spawnStruct();
  childthread _id_BDDE0931ACCF955B(_id_A681B7890CD017C7);
  childthread _id_449E67A68FA04968(_id_A681B7890CD017C7);
  self waittill("missile_impact");
  return _id_A681B7890CD017C7;
}

_id_BDDE0931ACCF955B(_id_A681B7890CD017C7) {
  self endon("missile_impact");
  self waittill("missile_stuck", stuckto);

  if(isDefined(stuckto))
    _id_A681B7890CD017C7.stuckto = stuckto;

  self notify("missile_impact");
}

_id_449E67A68FA04968(_id_A681B7890CD017C7) {
  self endon("missile_impact");
  self waittill("missile_water_impact");
  _id_A681B7890CD017C7._id_6150B9D03028F80C = 1;
  self notify("missile_impact");
}

_id_4AF015619E2534BA(stuckto, _id_4C663252DABD1483, _id_6A94CF09AA6E486E) {
  level endon("game_ended");
  self endon("death");

  if(isDefined(self.owner))
    self.owner endon("disconnect");

  stuckto scripts\engine\utility::waittill_any_2("death", "destroy");
  self thread[[_id_4C663252DABD1483]](_id_6A94CF09AA6E486E);
}

debughackequipment() {
  for(;;) {
    if(getdvarint("scr_debughackequipment") != 0) {
      _id_DAD9C3E8B724D629 = level.players[0];
      _id_AA74D78F1A2354AE = undefined;

      for(_id_AC0E594AC96AA3A8 = 1; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++) {
        if(_id_DAD9C3E8B724D629 scripts\cp_mp\utility\player_utility::isenemy(level.players[_id_AC0E594AC96AA3A8])) {
          _id_AA74D78F1A2354AE = level.players[_id_AC0E594AC96AA3A8];
          break;
        }
      }

      if(!isDefined(_id_AA74D78F1A2354AE)) {
        iprintlnbold("Need a player on the other team to scr_debugHackEquipment");
        continue;
      }

      _id_7C3CE7FF13FBD7FC = _id_DAD9C3E8B724D629 scripts\mp\weapons::getallequip();
      equipment = undefined;

      if(_id_7C3CE7FF13FBD7FC.size > 0)
        equipment = _id_7C3CE7FF13FBD7FC[0];

      if(!isDefined(equipment)) {
        iprintlnbold("First player must have at least one piece of equipment to scr_debugHackEquipment");
        continue;
      }

      equipment hackequipment(_id_AA74D78F1A2354AE);
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
      _id_204DA528AA0A3464 scripts\mp\utility\weapon::_launchgrenade("emp_grenade_mp", (0, 0, 0), (0, 0, 0), 0.05, 0);
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