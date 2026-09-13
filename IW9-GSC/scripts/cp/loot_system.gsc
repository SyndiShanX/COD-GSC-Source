/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\loot_system.gsc
***********************************************/

init_loot() {
  level.disable_loot_drop = 1;
  level.active_loot_spots = [];
  level.assault_weapons_array = ["brloot_weapon_ak47", "brloot_weapon_famas", "brloot_weapon_m4", "brloot_weapon_mcx"];
  level.lmg_weapons_array = ["brloot_weapon_hk121", "brloot_weapon_pkm"];
  level.smg_weapons_array = ["brloot_weapon_aug", "brloot_weapon_mp5", "brloot_weapon_mp7", "brloot_weapon_p90"];
  level.shotgun_weapons_array = ["brloot_weapon_dp12", "brloot_weapon_m870"];
  level.sniper_weapons_array = ["brloot_weapon_as50", "brloot_weapon_kar98", "brloot_weapon_m14", "brloot_weapon_marlin"];
  level.pistol_weapons_array = ["brloot_weapon_g21", "brloot_weapon_python"];
  thread init_loot_scriptables();
  _id_F3A7A75259866102();
}

init_loot_scriptables() {
  level thread _id_308763512997D07F();
  scripts\engine\scriptable::scriptable_addusedcallback(::loot_pickup);
}

loot_pickup(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance.type) && instance.type == "armor_plate_restock_cp") {
    _id_1CD29382D1867470 = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
    _id_A81ADEB0E1F89320 = player _id_07C40FA80892A721::_id_047320A25B8EE003();

    if(_id_1CD29382D1867470 >= _id_A81ADEB0E1F89320) {
      player scripts\cp\cp_hud_message::showerrormessage("MP_INGAME_ONLY/ARMOR_RESTOCK_STOCK_FULL");
      return 0;
    }

    if(getdvarint("dvar_DA81381074863C6E", 0)) {
      if(!isDefined(instance._id_5E55631C4D45E890))
        instance._id_5E55631C4D45E890 = 18;

      if(!isDefined(instance._id_973D7CE9ABB3844E))
        instance._id_973D7CE9ABB3844E = 0;
    }

    _id_06633986C5EBF1E8 = _id_A81ADEB0E1F89320 - _id_1CD29382D1867470;

    if(_id_06633986C5EBF1E8 > 3)
      _id_06633986C5EBF1E8 = 3;

    if(getdvarint("dvar_DA81381074863C6E", 0)) {
      if(_id_06633986C5EBF1E8 > instance._id_5E55631C4D45E890)
        _id_06633986C5EBF1E8 = instance._id_5E55631C4D45E890;
    }

    player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_06633986C5EBF1E8);

    if(getdvarint("dvar_DA81381074863C6E", 0)) {
      instance._id_973D7CE9ABB3844E = instance._id_973D7CE9ABB3844E + _id_06633986C5EBF1E8;
      instance._id_5E55631C4D45E890 = instance._id_5E55631C4D45E890 - _id_06633986C5EBF1E8;
    }

    if(getdvarint("dvar_DA81381074863C6E", 0)) {
      if(instance._id_973D7CE9ABB3844E >= 3) {
        _id_0D2259BBC51D8D87 = scripts\engine\utility::_id_350E192B13BEA45C(instance.entity._id_539EAB42D5D1D18D);
        _id_0D2259BBC51D8D87 delete();
        _id_6D906809844C7CB1 = scripts\engine\utility::array_remove_index(instance.entity._id_539EAB42D5D1D18D, instance.entity._id_539EAB42D5D1D18D.size - 1);
        instance._id_973D7CE9ABB3844E = instance._id_973D7CE9ABB3844E - 3;
        instance.entity._id_539EAB42D5D1D18D = _id_6D906809844C7CB1;
      }
    }

    player thread _id_66122A002AFF5D57::_id_EE5540242EF172D4();
    player playlocalsound("plr_armor_salvage");
    instance thread _id_DF1C9968B5CBF288(player, 1);

    if(getdvarint("dvar_DA81381074863C6E", 0)) {
      if(instance._id_5E55631C4D45E890 <= 0) {
        instance disablescriptableplayeruse(player);
        instance setscriptablepartstate("armor_plate_restock", "USEABLE_OFF");
      }
    }

    level notify("supplies_used", player);
    return;
  }

  if(state == "visible" || state == "noauto") {
    result = give_loot_based_on_pickup(part, player);

    if(istrue(result)) {
      level thread loot_on_pickup_success(instance, part, state, player);

      if(isDefined(instance._id_946234CE1B1416FF)) {
        if(isDefined(level._id_CCDD82907B113C40[instance._id_946234CE1B1416FF]._id_0A86F5D2BA9AFBF9)) {
          _id_F2377CCDA34275E6 = level._id_CCDD82907B113C40[instance._id_946234CE1B1416FF]._id_0A86F5D2BA9AFBF9;
          _id_1BFF94731F4CF31D = level._id_CCDD82907B113C40[instance._id_946234CE1B1416FF]._id_0A86F5D2BA9AFBF9._id_9226858A27AFACED;

          if(isDefined(_id_1BFF94731F4CF31D)) {
            level._id_CCDD82907B113C40[instance._id_946234CE1B1416FF]._id_0A86F5D2BA9AFBF9._id_9226858A27AFACED = level._id_CCDD82907B113C40[instance._id_946234CE1B1416FF]._id_0A86F5D2BA9AFBF9._id_9226858A27AFACED - 1;

            if(level._id_CCDD82907B113C40[instance._id_946234CE1B1416FF]._id_0A86F5D2BA9AFBF9._id_9226858A27AFACED <= 0) {
              _id_F2377CCDA34275E6 notify("crate_usable");
              level._id_CCDD82907B113C40[instance._id_946234CE1B1416FF]._id_0A86F5D2BA9AFBF9._id_9226858A27AFACED = 0;
            }
          }
        }
      }
    } else {}
  }
}

_id_DF1C9968B5CBF288(player, wait_time) {
  player endon("disconnect");
  self disablescriptableplayeruse(player);

  if(!isDefined(wait_time))
    wait_time = 90;

  _id_03DC0F83D387B17B = getdvarint("dvar_A97DD1A639FA9EE5");

  if(_id_03DC0F83D387B17B > 0)
    wait_time = _id_03DC0F83D387B17B;

  wait(wait_time);
  self enablescriptableplayeruse(player);
}

_id_B63754F533A6201B(instance) {
  if(!isDefined(instance.model))
    return 0;

  switch (instance.model) {
    case "electronics_keycard_office_01":
      return 1;
    default:
      return 0;
  }

  return 0;
}

loot_on_pickup_success(instance, part, state, player) {
  _id_47674C5FDAA404E4 = strtok(part, "_");
  loot_type = _id_47674C5FDAA404E4[1];
  _id_831AE682A7C552BD = _id_47674C5FDAA404E4[2];

  if(_id_B63754F533A6201B(instance))
    player playsoundtoplayer("uin_dmz_valuable_loot_pickup", player);
  else
    player playsoundtoplayer("scavenger_pack_pickup", player);

  instance setscriptablepartstate(part, "hidden");
  level notify("pickedupweapon_kill_callout_" + instance.type + instance.origin);
  level notify("pickedup_loot_success", instance.type, player, instance);

  if(loot_type == "munition") {
    boxmodel = spawn("script_model", instance.origin);
    boxmodel setModel("offhand_wm_supportbox_killstreak");
    boxmodel.angles = instance.angles;
    boxmodel setscriptablepartstate("effects", "plant");
    boxmodel setscriptablepartstate("anims", "open");
    player thread scripts\cp\utility::playerplaypickupanim("iw8_ges_pickup_br");
    wait 1;
    boxmodel delete();
  }
}

give_loot_based_on_pickup(part, player) {
  _id_47674C5FDAA404E4 = strtok(part, "_");
  loot_type = _id_47674C5FDAA404E4[1];
  _id_831AE682A7C552BD = _id_47674C5FDAA404E4[2];
  result = 0;

  switch (loot_type) {
    case "note":
      lootid = _id_600B944A95C3A7BF::_id_A50B607D2500DDA5(part);
      result = _id_1791C1E8974E9BD7(player, lootid, 1);
      break;
    case "key":
      break;
    case "offhand":
      break;
    case "weapon":
      result = give_ammo_from_scavenged_weapon(part, player);
      break;
    case "munition":
      result = give_munition(part, player);
      break;
    case "domination":
    case "attach":
    case "powerup":
    case "intel":
    case "health":
    case "ammo":
    case "plunder":
    case "scavenger":
    case "vip":
    case "super":
      break;
    case "self":
      break;
    case "equip":
      result = _id_24B4CDFB8AFEE3FF(_id_831AE682A7C552BD, player);
      break;
    case "rock":
      player _id_7EF95BBA57DC4B82::giveequipment("equip_rock", "primary");
      break;
    case "armor":
      break;
    case "plate":
      if(isDefined(level._id_AA7BBD29DBF244D7)) {
        _id_A81ADEB0E1F89320 = _id_07C40FA80892A721::_id_047320A25B8EE003();
        _id_364D691B501CD27F = _id_07C40FA80892A721::_id_0600F6CF462E983F();
        _id_687D4B05CFA572CC = _id_A81ADEB0E1F89320 - _id_364D691B501CD27F;
        player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(level._id_AA7BBD29DBF244D7);
      } else if(part == "brloot_plate_pouch") {
        if(!istrue(player.hasplatepouch))
          player.hasplatepouch = 1;

        _id_A81ADEB0E1F89320 = player _id_07C40FA80892A721::_id_047320A25B8EE003();
        _id_364D691B501CD27F = player _id_07C40FA80892A721::_id_0600F6CF462E983F();
        _id_2F7B6D2030D5B87A = int(_id_A81ADEB0E1F89320 - _id_364D691B501CD27F);

        if(_id_2F7B6D2030D5B87A <= 0)
          return 0;
        else {
          player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(_id_2F7B6D2030D5B87A);
          return 1;
        }
      } else {
        player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(1);
        return 1;
      }

      break;
    case "killstreak":
      if(part == "brloot_killstreak_recondrone") {
        if(isDefined(get_empty_munition_slot(player)))
          return 1;
        else
          return 0;
      }

      break;
    default:
      return result;
  }

  return result;
}

give_munition(part, player) {
  _id_47674C5FDAA404E4 = strtok(part, "_");
  _id_3D4263CA1AB2CC7A = "";

  for(_id_AC0E594AC96AA3A8 = 2; _id_AC0E594AC96AA3A8 < _id_47674C5FDAA404E4.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_47674C5FDAA404E4[_id_AC0E594AC96AA3A8])) {
      if(_id_3D4263CA1AB2CC7A == "") {
        _id_3D4263CA1AB2CC7A = _id_3D4263CA1AB2CC7A + _id_47674C5FDAA404E4[_id_AC0E594AC96AA3A8];
        continue;
      }

      _id_3D4263CA1AB2CC7A = _id_3D4263CA1AB2CC7A + "_" + _id_47674C5FDAA404E4[_id_AC0E594AC96AA3A8];
    }
  }

  _id_6E1EC6F2C0EE6B2C = undefined;
  _id_B8BA56B9EDD59CB7 = player getplayerdata("cp", "inventorySlots", "totalSlots");

  if(_id_B8BA56B9EDD59CB7 < 4)
    _id_6E1EC6F2C0EE6B2C = _id_B8BA56B9EDD59CB7;
  else
    _id_6E1EC6F2C0EE6B2C = player.dpad_selection_index - 1;

  _id_C64B92D56EC838B3 = get_empty_munition_slot(player);

  if(isDefined(_id_C64B92D56EC838B3))
    _id_6E1EC6F2C0EE6B2C = _id_C64B92D56EC838B3;
  else {
    player scripts\cp\utility::hint_prompt("munition_slots_full", 1, 2);
    return 0;
  }

  switch (_id_3D4263CA1AB2CC7A) {
    case "grenade_launcher":
      player _id_644C18834356D9DC::give_munition_to_slot("grenade_launcher", _id_6E1EC6F2C0EE6B2C);
      return 1;
    case "ammo":
      return player try_give_munition_to_slot(_id_3D4263CA1AB2CC7A, _id_6E1EC6F2C0EE6B2C, "ammo_crate", "pickup");
    case "munitions_crate":
      return player try_give_munition_to_slot(_id_3D4263CA1AB2CC7A, _id_6E1EC6F2C0EE6B2C, "munitions_crate", "pickup");
    case "turret":
      return player try_give_munition_to_slot(_id_3D4263CA1AB2CC7A, _id_6E1EC6F2C0EE6B2C, "manual_turret", "pickup");
    case "cluster_strike":
    case "cruise_missile":
    case "air_drop":
    case "deployable_cover":
    case "trophysystem":
    case "white_phos":
    case "grenade_crate":
    case "assault_suit":
    case "uav":
    case "precision_airstrike":
    case "hover_jet":
    case "manual_turret":
    case "cluster_spike":
    case "auto_drone":
    case "armor":
    case "sentry":
    case "juggernaut":
      return player try_give_munition_to_slot(_id_3D4263CA1AB2CC7A, _id_6E1EC6F2C0EE6B2C, undefined, "pickup");
    default:
      break;
  }

  player iprintlnbold("^1 Can't pick this up unknown munition: " + part);
  return 0;
}

try_give_munition_to_slot(_id_3D4263CA1AB2CC7A, _id_6E1EC6F2C0EE6B2C, _id_1BE1C31F65120104, source) {
  _id_4C8E00ECDDFAC46B = _id_3D4263CA1AB2CC7A;

  if(isDefined(_id_1BE1C31F65120104))
    _id_4C8E00ECDDFAC46B = _id_1BE1C31F65120104;

  _id_644C18834356D9DC::give_munition_to_slot(_id_4C8E00ECDDFAC46B, _id_6E1EC6F2C0EE6B2C, source);
  return 1;
}

force_hint_prompt_timer(_id_01CBE522F3D06682, timer) {
  self forceusehinton(_id_01CBE522F3D06682);
  wait(timer);
  self forceusehintoff();
}

get_empty_munition_slot(player) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < player.munition_slots.size; _id_AC0E594AC96AA3A8++) {
    if(player is_empty_or_none(_id_AC0E594AC96AA3A8))
      return _id_AC0E594AC96AA3A8;
  }
}

is_empty_or_none(_id_AC0E594AC96AA3A8) {
  player = self;

  if(!isDefined(player.munition_slots))
    return 1;

  if(!isDefined(player.munition_slots[_id_AC0E594AC96AA3A8]))
    return 1;

  if(player.munition_slots[_id_AC0E594AC96AA3A8].ref == "none" || player.munition_slots[_id_AC0E594AC96AA3A8].ref == "empty1" || player.munition_slots[_id_AC0E594AC96AA3A8].ref == "empty2" || player.munition_slots[_id_AC0E594AC96AA3A8].ref == "empty3")
    return 1;

  return 0;
}

give_ammo_from_scavenged_weapon(part, player) {
  weapon = player getcurrentweapon();
  _id_4BB9768282D4260D = _id_2669878CF5A1B6BC::getweaponrootname(weapon);
  classname = _id_2669878CF5A1B6BC::weapongroupmap(_id_4BB9768282D4260D);

  if(scripts\engine\utility::array_contains(level.assault_weapons_array, part) && (classname == "weapon_assault" || classname == "weapon_battle"))
    return give_ammo(part, player);
  else if(scripts\engine\utility::array_contains(level.smg_weapons_array, part) && classname == "weapon_smg")
    return give_ammo(part, player);
  else if(scripts\engine\utility::array_contains(level.sniper_weapons_array, part) && (classname == "weapon_sniper" || classname == "weapon_dmr"))
    return give_ammo(part, player);
  else if(scripts\engine\utility::array_contains(level.lmg_weapons_array, part) && classname == "weapon_lmg")
    return give_ammo(part, player);
  else if(scripts\engine\utility::array_contains(level.shotgun_weapons_array, part) && classname == "weapon_shotgun")
    return give_ammo(part, player);
  else if(scripts\engine\utility::array_contains(level.pistol_weapons_array, part) && classname == "weapon_pistol")
    return give_ammo(part, player);
  else
    return 0;
}

give_ammo(part, player) {
  return player give_ammo_clip();
}

give_ammo_clip() {
  weapon = self getcurrentweapon();
  base_weapon = scripts\cp\utility::getrawbaseweaponname(weapon);
  _id_B7A2FC1C85E2492C = weaponclipsize(weapon);

  if(weapontype(weapon) == "riotshield" || _id_74502A9E0EF1F19C::is_incompatible_weapon(weapon)) {
    _id_BC002676438672C9 = self getweaponslistprimaries();

    foreach(primaryweapon in _id_BC002676438672C9) {
      if(primaryweapon == weapon) {
        continue;
      }
      if(!scripts\cp_mp\utility\weapon_utility::isbulletweapon(weapon)) {
        continue;
      }
      _id_B7A2FC1C85E2492C = weaponclipsize(primaryweapon);
      base_weapon = scripts\cp\utility::getrawbaseweaponname(primaryweapon);

      if(self getweaponammostock(primaryweapon) < scripts\cp\utility::_id_ED18A118C6FA5C4F(primaryweapon)) {
        _id_7863B6D204A0CECE = self getweaponammostock(primaryweapon);
        self setweaponammostock(primaryweapon, _id_B7A2FC1C85E2492C + _id_7863B6D204A0CECE);
        self.itempicked = getcompleteweaponname(primaryweapon);
      } else if(self getweaponammoclip(primaryweapon) < weaponclipsize(primaryweapon))
        self setweaponammoclip(primaryweapon, weaponclipsize(primaryweapon));
      else
        return 0;

      return 1;
    }
  } else if(self getweaponammostock(weapon) < scripts\cp\utility::_id_ED18A118C6FA5C4F(weapon)) {
    _id_7863B6D204A0CECE = self getweaponammostock(weapon);
    self setweaponammostock(weapon, _id_B7A2FC1C85E2492C + _id_7863B6D204A0CECE);
    self.itempicked = getcompleteweaponname(weapon);
  } else if(self getweaponammoclip(weapon) < weaponclipsize(weapon))
    self setweaponammoclip(weapon, weaponclipsize(weapon));
  else
    return 0;

  self playlocalsound("weap_ammo_pickup");
  return 1;
}

_id_24B4CDFB8AFEE3FF(part, player) {
  result = 0;

  switch (part) {
    case "gasmask":
      if(!istrue(player._id_5968F8F2C70696E9)) {
        player._id_5968F8F2C70696E9 = 1;
        player thread _id_66122A002AFF5D57::_id_EE5540242EF172D4();
        player scripts\cp_mp\gasmask::init();
        result = 1;
      }

      break;
    case "halligan":
      if(!istrue(player._id_1FD57894D3F63B70)) {
        player thread _id_66122A002AFF5D57::_id_EE5540242EF172D4();
        player _id_780514F14B1134ED::_id_5F3A1AD41FB75140();
        result = 1;
      }

      break;
    case "c4":
      if(!isDefined(player._id_C1C897BD5219A540)) {
        player thread _id_66122A002AFF5D57::_id_EE5540242EF172D4();
        player _id_390BB92B200E27FA::_id_70C3660758C8833E();
        result = 1;
      }

      break;
    case "nvgs":
      if(isDefined(player._id_4D572A54ED8571C4) && player._id_4D572A54ED8571C4 == 0)
        result = 0;
      else if(!istrue(player._id_8ACC46A1366E9A86)) {
        player._id_8ACC46A1366E9A86 = 1;
        player thread _id_66122A002AFF5D57::_id_EE5540242EF172D4();
        player _id_644C18834356D9DC::give_munition_to_slot("nvg", 3);
        player _id_644C18834356D9DC::assign_highest_full_slot_to_active();
        player._id_4D572A54ED8571C4 = 0;
        result = 1;
      }

      break;
  }

  return result;
}

refill_grenades(player) {
  player notify("stop_restock_recharge");

  foreach(power_name, _id_FC9386BE5A415D15 in player.powers) {
    player notify("scavenged_ammo", _id_FC9386BE5A415D15.weaponuse);
    player playlocalsound("weap_ammo_pickup");
    waitframe();
  }
}

_id_308763512997D07F() {
  level endon("game_ended");
  scripts\engine\utility::flag_wait("strike_init_done");

  if(istrue(level._id_3423C60CBB355C81)) {
    return;
  }
  if(getdvarint("dvar_F1D31D1DD564FC9E", 0)) {
    return;
  }
  _id_980321A7AED74F29 = scripts\engine\utility::getStructArray("armor_pickup", "targetname");

  foreach(_id_30F8E43B68E4A540 in _id_980321A7AED74F29) {
    _id_30F8E43B68E4A540.origin = _id_30F8E43B68E4A540.origin + anglesToForward(_id_30F8E43B68E4A540.angles) * -10;
    _id_30F8E43B68E4A540.angles = _id_30F8E43B68E4A540.angles + (90, 0, 0);
    _id_CB4FAD49263E20C4 = _id_66122A002AFF5D57::getitemdropinfo(_id_30F8E43B68E4A540.origin, _id_30F8E43B68E4A540.angles);
    _id_29BED75FB4428CD5 = _id_66122A002AFF5D57::spawnpickup("brloot_plate_pouch", _id_CB4FAD49263E20C4);
  }
}

_id_BCF02EE8CB581FCD(model) {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level.players.size; _id_AC0E594AC96AA3A8++)
    model disablescriptableplayeruse(level.players[_id_AC0E594AC96AA3A8]);

  model.interact = spawn("script_model", model.origin + (0, 0, 32));
  model.interact.angles = model.angles;
  model.interact setModel("tag_origin");
  model.interact makeusable();
  hintstring = &"COOP_GAME_PLAY/ARMOR_SATCHEL";
  model.interact setHintString(hintstring);
  model.interact setCursorHint("HINT_BUTTON");
  model.interact sethintdisplayrange(190);
  model.interact sethintdisplayfov(140);
  model.interact setuserange(105);
  model.interact setusefov(65);
  model.interact sethintonobstruction("show");
  model.interact setuseholdduration("duration_short");
  model.interact thread _id_9C1CC325EACD48C1(model);
}

_id_9C1CC325EACD48C1(model) {
  self endon("death");

  for(;;) {
    self waittill("trigger", player);

    if(_id_46A2B7D2AD2BDC13(model, player)) {
      if(istrue(level._id_B17F3DC7C65B1860)) {
        model setscriptablepartstate("brloot_plate_pouch", "hidden");
        model freescriptable();
        self delete();
      }
    }
  }
}

_id_46A2B7D2AD2BDC13(interaction, player) {
  if(player _id_531CB1BE084314F7::hasplatepouch())
    return 0;

  player playsoundtoplayer("br_pickup_generic", player);
  player.hasplatepouch = 1;
  player setclientomnvar("ui_br_has_plate_pouch", 1);
  player thread scripts\cp\cp_hud_message::showsplash("br_plate_pouch_pickup");
  player _id_07C40FA80892A721::_id_9C6E9A6643B6C9A6(8);

  if(istrue(level._id_B17F3DC7C65B1860)) {
    if(isDefined(interaction.target)) {
      _id_A58FD1F4020DC65C = getEntArray(interaction.target, "targetname");

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_A58FD1F4020DC65C.size; _id_AC0E594AC96AA3A8++)
        _id_A58FD1F4020DC65C[_id_AC0E594AC96AA3A8] delete();
    }
  }

  return 1;
}

_id_F3A7A75259866102() {
  level.lootweaponcache = [];
  level.lootweaponrefs = [];
  _id_725F93C8F8F7CF9D = getdvarint("dvar_D8D8D08BFD9EC4DF", 30);
  level._id_DE221BFB117F1FD1 = _id_725F93C8F8F7CF9D * _id_725F93C8F8F7CF9D;
  level._id_87960B9CE7021569 = getdvarfloat("dvar_ED1EA4AC182C02CF", 0.8);
}

getweaponassetfromrootweapon(_id_CD13663AEE778DB6, variantid) {
  _id_6CF67C6D17CF3316 = "mp/loot/weapon/" + _id_CD13663AEE778DB6 + ".csv";
  weaponasset = tablelookup(_id_6CF67C6D17CF3316, 0, variantid, 3);
  return weaponasset;
}

lookupvariantref(_id_CD13663AEE778DB6, variantid) {
  _id_6CF67C6D17CF3316 = "mp/loot/weapon/" + _id_CD13663AEE778DB6 + ".csv";
  _id_093B3002EBEF628B = tablelookup(_id_6CF67C6D17CF3316, 0, variantid, 1);
  return _id_093B3002EBEF628B;
}

isweaponitem(_id_358E8D9068997399) {
  return _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(_id_358E8D9068997399) == "weapon";
}

getweaponqualitybyid(weapon, variantid) {
  if(!isDefined(variantid) || variantid < 0)
    return 0;

  _id_0C6C779C138E8C65 = getweaponloottable(weapon);
  quality = int(tablelookup(_id_0C6C779C138E8C65, 0, variantid, 4));
  return quality;
}

getlootweaponref(_id_358E8D9068997399) {
  return level.lootweaponrefs[_id_358E8D9068997399];
}

_id_30F5EA60517F9E06(opener, _id_69E96A4CAA72D794) {
  [items, _id_77DC0A100921C5A7] = _id_0438749EB7A7B738(_id_69E96A4CAA72D794.contents, opener, _id_69E96A4CAA72D794);
  _id_69E96A4CAA72D794.contents = items;
  opener._id_02FA5B49969DEF47 = _id_69E96A4CAA72D794;
  opener._id_F2AA9AE949179907 = opener.origin;

  if(isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44))
    opener._id_F2AA9AE949179907 = opener.origin - _id_69E96A4CAA72D794._id_BF8E5F003146AF44.origin;

  if(items.size > 10) {}

  for(_id_3793828403C6873E = 0; _id_3793828403C6873E < 10; _id_3793828403C6873E++) {
    if(_id_3793828403C6873E <= _id_77DC0A100921C5A7) {
      _id_446C7AD7BCC70992(opener, _id_3793828403C6873E, items[_id_3793828403C6873E]["lootID"], items[_id_3793828403C6873E]["quantity"]);
      continue;
    }

    _id_C7294F5B9B5006D5(opener, _id_3793828403C6873E);
  }

  if(isDefined(_id_69E96A4CAA72D794._id_04F6CDE716E0C3D7))
    opener setclientomnvar("loot_container_weapon", _id_69E96A4CAA72D794._id_04F6CDE716E0C3D7);
  else
    opener setclientomnvar("loot_container_weapon", 0);

  partname = _id_69E96A4CAA72D794 _meth_EC5F4851431F3382();
  _id_68D9E792FE9DEF4D = _id_69E96A4CAA72D794 getscriptablepartstate(partname, 1);

  if(_id_68D9E792FE9DEF4D != "opening_in_use")
    _id_69E96A4CAA72D794 setscriptablepartstate(partname, "in_use");

  if(!isDefined(_id_69E96A4CAA72D794._id_46A3A8565AC0C17C))
    _id_69E96A4CAA72D794._id_46A3A8565AC0C17C = 1;

  _id_46A3A8565AC0C17C = _id_69E96A4CAA72D794._id_46A3A8565AC0C17C;

  if(_id_46A3A8565AC0C17C == 6) {
    if(isDefined(_id_69E96A4CAA72D794.owner) && isDefined(_id_69E96A4CAA72D794.owner.team) && isDefined(opener.team) && _id_69E96A4CAA72D794.owner.team == opener.team && isDefined(_id_69E96A4CAA72D794.owner._id_3F78C6A0862F9E25))
      _id_46A3A8565AC0C17C = 7 + _id_69E96A4CAA72D794.owner._id_3F78C6A0862F9E25;

    if(isDefined(_id_69E96A4CAA72D794._id_846A20D8E6F30B8E))
      opener setclientomnvar("loot_container_dead_player_index", _id_69E96A4CAA72D794._id_846A20D8E6F30B8E);
  }

  opener setclientomnvar("loot_container_open", _id_46A3A8565AC0C17C);

  if(istrue(level._id_A101059DEA76957C) && !istrue(_id_69E96A4CAA72D794._id_4E6E38A1603F22EE) && _id_69E96A4CAA72D794._id_46A3A8565AC0C17C != 13) {
    _id_69E96A4CAA72D794._id_4E6E38A1603F22EE = 1;

    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "doScoreEvent"))
      opener thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "doScoreEvent")]]("br_cacheOpen");
  }

  _id_69E96A4CAA72D794 thread _id_71A59F067D5FE986(_id_69E96A4CAA72D794, opener);
  _id_69E96A4CAA72D794 thread _id_47B931D76FFD028F(_id_69E96A4CAA72D794, opener);
}

_id_0438749EB7A7B738(items, opener, _id_69E96A4CAA72D794) {
  _id_542AB2415C42E657 = [];
  _id_47868F432C8FCB6B = 0;
  lastindex = items.size - 1;

  foreach(item in items) {
    quantity = item["quantity"];
    lootid = item["lootID"];
    team = item["team"];
    _id_FAFCDAA6B732231A = item["visibilityCondition"];

    if(isDefined(quantity) && quantity > 0 && isDefined(lootid) && lootid > 0 && (!isDefined(team) || team == opener.team) && (!isDefined(_id_FAFCDAA6B732231A) || [[_id_FAFCDAA6B732231A]](opener, _id_69E96A4CAA72D794))) {
      _id_542AB2415C42E657[_id_47868F432C8FCB6B] = item;
      _id_47868F432C8FCB6B++;
      continue;
    }

    _id_542AB2415C42E657[lastindex] = item;
    lastindex--;
  }

  return [_id_542AB2415C42E657, lastindex];
}

_id_C7294F5B9B5006D5(player, index) {
  player setclientomnvar("loot_container_item_" + index, 0);
  player setclientomnvar("loot_container_quantity_" + index, 0);
  player setclientomnvar("loot_container_type_" + index, 0);
}

_id_47B931D76FFD028F(_id_69E96A4CAA72D794, opener) {
  _id_69E96A4CAA72D794 endon("death");
  level endon("game_ended");
  _id_69E96A4CAA72D794 endon("closed");
  opener scripts\engine\utility::waittill_any_3("close_container", "flashbang", "concussed");
  _id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener);
}

_id_71A59F067D5FE986(_id_69E96A4CAA72D794, opener) {
  _id_69E96A4CAA72D794 endon("death");
  level endon("game_ended");
  _id_69E96A4CAA72D794 endon("closed");
  opener endon("disconnect");

  while(scripts\cp_mp\utility\player_utility::isreallyalive(opener) && !istrue(opener.isdisconnecting) && isDefined(opener.origin) && (!isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44) && distancesquared(opener._id_F2AA9AE949179907, opener.origin) <= level._id_DE221BFB117F1FD1 || isDefined(_id_69E96A4CAA72D794._id_BF8E5F003146AF44) && distancesquared(opener._id_F2AA9AE949179907, opener.origin - _id_69E96A4CAA72D794._id_BF8E5F003146AF44.origin) <= level._id_DE221BFB117F1FD1))
    wait 0.05;

  _id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener);
}

_id_D3E618521013C7EB() {
  self endon("death");
  level endon("game_ended");
  self waittill("opened_in_use");
  partname = self _meth_EC5F4851431F3382();
  self setscriptablepartstate(partname, "open_usable");
}

_id_68085C72D7B628EC(_id_69E96A4CAA72D794, opener) {
  opener setclientomnvar("loot_container_open", 0);
  _id_69E96A4CAA72D794 notify("closed");
  partname = _id_69E96A4CAA72D794 _meth_EC5F4851431F3382();

  if(_id_69E96A4CAA72D794 getscriptableparthasstate(partname, "open_usable")) {
    _id_68D9E792FE9DEF4D = _id_69E96A4CAA72D794 getscriptablepartstate(partname, 1);

    if(_id_68D9E792FE9DEF4D != "opening_in_use")
      _id_69E96A4CAA72D794 setscriptablepartstate(partname, "open_usable");
    else {
      _id_69E96A4CAA72D794 thread _id_D3E618521013C7EB();
      _id_69E96A4CAA72D794 notify("opened_in_use");
    }
  } else if(_id_69E96A4CAA72D794 getscriptableparthasstate(partname, "usable"))
    _id_69E96A4CAA72D794 setscriptablepartstate(partname, "usable");
  else
    _id_69E96A4CAA72D794 setscriptablepartstate(partname, "visible");

  if(istrue(opener._id_7F15935A89EA5B13))
    opener._id_7F15935A89EA5B13 = undefined;
}

_id_6F45E7311F77EAC4(player) {
  return player getclientomnvar("loot_container_open") > 0;
}

_id_446C7AD7BCC70992(player, index, lootid, quantity) {
  _id_319F74ED8FA1A512 = _id_600B944A95C3A7BF::_id_282CF83C9EEDA744(lootid);
  _id_BA7D157F3BBF68E9 = level._id_F984BA508AE5BCB1[_id_319F74ED8FA1A512];

  if(lootid == 0)
    _id_C7294F5B9B5006D5(player, index);
  else if(isDefined(_id_BA7D157F3BBF68E9)) {
    player setclientomnvar("loot_container_item_" + index, lootid);
    player setclientomnvar("loot_container_quantity_" + index, quantity);
    player setclientomnvar("loot_container_type_" + index, _id_BA7D157F3BBF68E9._id_03A436BD812A2B86);
  } else {}
}

_id_F478CA9D3C44018C(player, index) {
  _id_5C9DDCF56D36F133 = player getclientomnvar("loot_container_item_" + index);
  return _id_5C9DDCF56D36F133;
}

_id_8E5978971B5DCD16(player, index) {
  return player getclientomnvar("loot_container_quantity_" + index);
}

_id_23A3BB1172216C05(_id_69E96A4CAA72D794) {
  if(!isDefined(_id_69E96A4CAA72D794.contents))
    return 1;

  foreach(_id_C56207BDA09B3A36 in _id_69E96A4CAA72D794.contents) {
    if(_id_C56207BDA09B3A36["lootID"] > 0 && _id_C56207BDA09B3A36["quantity"] > 0)
      return 0;
  }

  if(isDefined(_id_69E96A4CAA72D794._id_04F6CDE716E0C3D7)) {
    _id_6C2B460EA57431F8 = self getclientomnvar("loot_container_weapon");

    if(istrue(_id_6C2B460EA57431F8))
      return 0;
  }

  return 1;
}

_id_1791C1E8974E9BD7(player, lootid, quantity) {
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);
  success = 0;

  if(ref == "cash") {
    _id_3466C10973E9C476 = _id_66122A002AFF5D57::getplundernamebyamount(quantity);
    _id_60227BFF1E9478CC = spawnStruct();
    _id_60227BFF1E9478CC.scriptablename = _id_3466C10973E9C476;
    _id_66122A002AFF5D57::_id_EFDDDF60C5DB058C(_id_60227BFF1E9478CC);
    player _id_66122A002AFF5D57::playerplunderpickup(quantity);
    player scripts\cp_mp\challenges::onpickupitem("plunder");
    success = 1;
  } else if(ref == "dmz_loot_quest_intel" || ref == "dmz_trap_quest_trigger") {
    _id_66122A002AFF5D57::_id_37BE6E543436F3B3(lootid);
    success = 1;
  } else if(ref == "interactable_note_keycard_raid4_maze" || ref == "interactable_note_keycard_raid4_maze_2" || ref == "interactable_note_keycard_raid4_ee") {
    _id_4755865F44ED3D7E = _id_66122A002AFF5D57::_id_6FE7E7891D125C48(player);
    _id_4AC0D9DE9D828350 = _id_531CB1BE084314F7::_id_B13E35608B336D65(player);

    if(_id_4AC0D9DE9D828350 > 0) {
      _id_6C8D21B2E54B2478 = _id_4755865F44ED3D7E / _id_4AC0D9DE9D828350;

      if(_id_6C8D21B2E54B2478 == 1) {
        player thread scripts\cp\utility::hint_prompt("backpack_full", 1, 3);
        success = 0;
      } else
        success = player _id_66122A002AFF5D57::_id_D8CD9C1941A88194(lootid, quantity);
    }
  } else if(_id_531CB1BE084314F7::isammo(ref))
    success = player _id_66122A002AFF5D57::_id_54DAC56D15DD3D93(ref, lootid, quantity);
  else
    success = player _id_66122A002AFF5D57::_id_D8CD9C1941A88194(lootid, quantity);

  return success;
}

_id_A335AA664CAA37C9(player) {
  lootid = _id_66122A002AFF5D57::_id_D9B1550011525161(player);

  if(!isDefined(player._id_02FA5B49969DEF47._id_6FB67C8525B1D79E)) {
    return;
  }
  _id_C161EC212069668D = 1;

  foreach(weaponobj in player.primaryinventory) {
    if(weaponobj.basename == "iw9_me_fists_mp") {
      _id_C161EC212069668D = 0;
      break;
    }
  }

  if(_id_C161EC212069668D && _id_66122A002AFF5D57::_id_EFAB78B72D131D76(player)) {
    scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyequipnoroom);
    return;
  }

  if(!_id_C161EC212069668D) {
    _id_A92926D5B02CF6ED(player);
    return;
  }

  _id_66122A002AFF5D57::_id_8107FE0FEEC27866(player, player._id_02FA5B49969DEF47._id_6FB67C8525B1D79E);
  player playsoundtoplayer("br_pickup_weap", player);
  player setclientomnvar("loot_container_weapon", 0);
  player._id_02FA5B49969DEF47._id_04F6CDE716E0C3D7 = 0;
  player._id_02FA5B49969DEF47._id_6FB67C8525B1D79E = undefined;
}

_id_2F00CA0526F3EDC6(player, index, quantity) {
  lootid = _id_F478CA9D3C44018C(player, index);
  _id_35EABFFB2F0F31E3 = _id_8E5978971B5DCD16(player, index);

  if(!isDefined(quantity))
    quantity = _id_35EABFFB2F0F31E3;

  if(lootid == 0 || quantity == 0)
    return 1;

  success = _id_1791C1E8974E9BD7(player, lootid, quantity);

  if(success) {
    _id_A28BD7F30254C8A0 = _id_35EABFFB2F0F31E3 - quantity;
    _id_699DE62155C8C832 = lootid;

    if(isDefined(player._id_02FA5B49969DEF47))
      player._id_02FA5B49969DEF47.contents[index]["quantity"] = _id_A28BD7F30254C8A0;

    if(_id_A28BD7F30254C8A0 <= 0) {
      _id_699DE62155C8C832 = 0;

      if(isDefined(player._id_02FA5B49969DEF47))
        player._id_02FA5B49969DEF47.contents[index]["lootID"] = _id_699DE62155C8C832;
    }

    _id_446C7AD7BCC70992(player, index, _id_699DE62155C8C832, _id_A28BD7F30254C8A0);
  }

  return success;
}

_id_A92926D5B02CF6ED(player) {
  lootid = player getclientomnvar("loot_container_weapon");

  if(lootid == 0)
    return 1;

  if(!isDefined(player._id_02FA5B49969DEF47._id_6FB67C8525B1D79E))
    return 1;

  weapon = player._id_02FA5B49969DEF47._id_6FB67C8525B1D79E;

  foreach(_id_DE88CD14114C1E24 in self.primaryweapons) {
    if(issameweapon(_id_DE88CD14114C1E24, weapon)) {
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    }
  }

  if(_id_66122A002AFF5D57::_id_EFAB78B72D131D76(player)) {
    _id_4D2B659118F5C515 = _id_66122A002AFF5D57::_id_2985254128B1C262(player);

    if(issameweapon(_id_4D2B659118F5C515, weapon)) {
      scripts\cp\cp_hud_message::showerrormessage(level.br_pickups.br_pickupdenyalreadyhaveweapon);
      return;
    }
  }

  _id_1B47EC827F34BD5B = getcompleteweaponname(weapon);
  basename = undefined;

  if(isDefined(weapon.basename))
    basename = weapon.basename;
  else
    basename = getweaponbasename(weapon);

  success = _id_66122A002AFF5D57::br_forcegivecustomweapon(player, weapon, _id_1B47EC827F34BD5B, basename);

  if(success) {
    player setclientomnvar("loot_container_weapon", 0);
    player._id_02FA5B49969DEF47._id_04F6CDE716E0C3D7 = 0;
    player._id_02FA5B49969DEF47._id_6FB67C8525B1D79E = undefined;
  }
}

_id_3AE3712FE76D0C6A(player, index) {
  lootid = _id_F478CA9D3C44018C(player, index);
  quantity = _id_8E5978971B5DCD16(player, index);

  if(lootid == 0 || quantity == 0) {
    return;
  }
  ref = _id_600B944A95C3A7BF::_id_793E8A72CEDB8EF3(lootid);

  if(_id_531CB1BE084314F7::isammo(ref)) {
    _id_BADA25504E8844D7 = spawnStruct();
    _id_BADA25504E8844D7.scriptablename = ref;
    _id_BADA25504E8844D7.count = quantity;
    player _id_66122A002AFF5D57::_id_10F6E537F1B5763C(lootid, _id_BADA25504E8844D7);
  } else {
    _id_6A80B9F81CD7AD99 = _id_66122A002AFF5D57::_id_AE22C70A9C2474D9();
    _id_531CB1BE084314F7::_id_FE539E37B6579930(lootid, quantity, _id_6A80B9F81CD7AD99);
  }

  if(isDefined(player._id_02FA5B49969DEF47)) {
    player._id_02FA5B49969DEF47.contents[index]["quantity"] = 0;
    player._id_02FA5B49969DEF47.contents[index]["lootID"] = 0;
  }

  _id_446C7AD7BCC70992(player, index, 0, 0);
}

_id_E146F016A8A7244F(_id_EA3E3B2121E6713A, _id_E1D097C517C3AF5B) {
  if(istrue(level.infilcinematicactive)) {
    return;
  }
  if(isDefined(_id_EA3E3B2121E6713A)) {
    switch (_id_EA3E3B2121E6713A) {
      case "loot_container":
        _id_9D924AEA120C2693(self, _id_E1D097C517C3AF5B);
        _id_2F00CA0526F3EDC6(self, _id_E1D097C517C3AF5B, 1);
        break;
      case "loot_all_container":
        if(_id_E1D097C517C3AF5B == 100)
          _id_A335AA664CAA37C9(self);
        else {
          _id_9D924AEA120C2693(self, _id_E1D097C517C3AF5B);
          _id_2F00CA0526F3EDC6(self, _id_E1D097C517C3AF5B);
        }

        break;
      case "equip_loot_container":
        if(_id_E1D097C517C3AF5B == 100)
          _id_A92926D5B02CF6ED(self);
        else {
          _id_9D924AEA120C2693(self, _id_E1D097C517C3AF5B);
          _id_3AE3712FE76D0C6A(self, _id_E1D097C517C3AF5B);
        }

        break;
      case "close_loot_container":
        if(isDefined(self._id_02FA5B49969DEF47))
          _id_68085C72D7B628EC(self._id_02FA5B49969DEF47, self);

        break;
      default:
        return;
    }
  }

  if(isDefined(self._id_02FA5B49969DEF47) && _id_23A3BB1172216C05(self._id_02FA5B49969DEF47)) {
    _id_68085C72D7B628EC(self._id_02FA5B49969DEF47, self);

    if(!istrue(self._id_02FA5B49969DEF47._id_1498604DE9CF5016)) {
      self._id_02FA5B49969DEF47 notify("death");
      self._id_02FA5B49969DEF47 freescriptable();
      self._id_02FA5B49969DEF47 = undefined;
    } else {
      partname = self._id_02FA5B49969DEF47 _meth_EC5F4851431F3382();

      if(self._id_02FA5B49969DEF47 getscriptableparthasstate(partname, "open"))
        self._id_02FA5B49969DEF47 setscriptablepartstate(partname, "open");

      self._id_02FA5B49969DEF47 = undefined;
    }
  }
}

_id_9D924AEA120C2693(player, _id_E1D097C517C3AF5B) {
  lootid = _id_F478CA9D3C44018C(player, _id_E1D097C517C3AF5B);
  _id_35EABFFB2F0F31E3 = _id_8E5978971B5DCD16(player, _id_E1D097C517C3AF5B);

  if(lootid == 0 || _id_35EABFFB2F0F31E3 == 0) {
    return;
  }
  if(isDefined(self._id_02FA5B49969DEF47) && isDefined(self._id_02FA5B49969DEF47.contents) && isDefined(self._id_02FA5B49969DEF47.contents[_id_E1D097C517C3AF5B]) && isDefined(self._id_02FA5B49969DEF47.contents[_id_E1D097C517C3AF5B]["callback"]))
    thread[[self._id_02FA5B49969DEF47.contents[_id_E1D097C517C3AF5B]["callback"]]](self._id_02FA5B49969DEF47, player);
}

_id_55B384ECB923003E() {
  return getdvarint("dvar_F86A28F69E6CCC38", 1) == 1;
}

_id_4749C1A092E650BD() {
  return getdvarint("dvar_1B2E1EF116B3DE36", 0) == 1;
}

_id_8306D72EA2E8889C() {
  return getdvarint("dvar_B692410C5B56FFB5", 1) == 1;
}

_id_310AB06891CB4517() {
  return _id_4749C1A092E650BD() || _id_8306D72EA2E8889C() || _id_55B384ECB923003E();
}