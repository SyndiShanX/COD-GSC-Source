/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bunker_alt.gsc
**************************************************/

isbunkeraltenabled() {
  return getdvarint("dvar_79E97EC7BBD29877", 1);
}

initnonbunkerdoors() {
  if(!isDefined(level.br_bunker_alt))
    level.br_bunker_alt = spawnStruct();

  level.br_bunker_alt.nonbunkerdoors = [];
  level.br_bunker_alt.nonbunkerdoors["barn"] = getentitylessscriptablearray("br_bunker_alt_barn", "script_noteworthy");
  level.br_bunker_alt.nonbunkerdoors["outhouse"] = getentitylessscriptablearray("br_bunker_alt_outhouse", "script_noteworthy");
  level.br_bunker_alt.nonbunkerdoors["shed_01"] = getentitylessscriptablearray("br_bunker_alt_shed_01", "script_noteworthy");
  level.br_bunker_alt.nonbunkerdoors["shed_02"] = getentitylessscriptablearray("br_bunker_alt_shed_02", "script_noteworthy");
}

init() {
  if(!isbunkeraltenabled()) {
    return;
  }
  level.br_bunker_alt = spawnStruct();
  initnonbunkerdoors();
  level.br_bunker_alt.bunkervaults = spawnStruct();
  level.br_bunker_alt.bunkervaults.doors = [];
  level.br_bunker_alt.bunkervaults.hints = [];
  _id_F37692FF3E5AAD24 = getEntArray("bunker_door_1", "targetname");
  level.br_bunker_alt.bunkervaults.doors[1] = _id_F37692FF3E5AAD24[0];
  _id_F37695FF3E5AB3BD = getEntArray("bunker_door_3", "targetname");
  level.br_bunker_alt.bunkervaults.doors[3] = _id_F37695FF3E5AB3BD[0];
  _id_F37694FF3E5AB18A = getEntArray("bunker_door_10", "targetname");
  level.br_bunker_alt.bunkervaults.doors[10] = _id_F37694FF3E5AB18A[0];
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_alt", ::keypadscriptableused_altbunker);
  level thread initpostmain();
}

initnonbr() {
  initnonbunkerdoors();
  level thread locknonbunkerdoors();
}

initbrmechanics() {
  initnonbunkerdoors();
  level initnonbunkerdoorkeypad();
  level scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_alt", ::keypadscriptableused_altbunker);
  level thread locknonbunkerdoors();
}

initpostmain() {
  waittillframeend;
  _id_56111283B44EA65D = 1;
  _id_92EBFEAE4937512F = 1;
  level thread _id_7D625073C6379D53::initbunkerdoor(level.br_bunker_alt.bunkervaults.doors[1], _id_56111283B44EA65D, _id_92EBFEAE4937512F);
  level thread _id_7D625073C6379D53::initbunkerdoor(level.br_bunker_alt.bunkervaults.doors[3], _id_56111283B44EA65D, _id_92EBFEAE4937512F);
  level thread _id_7D625073C6379D53::initbunkerdoor(level.br_bunker_alt.bunkervaults.doors[10], _id_56111283B44EA65D, _id_92EBFEAE4937512F);

  if(getdvarint("dvar_310CCFC727D89074", 0)) {
    _id_30B1A181FB7CB8D0 = 1;
    _id_F07E92F4B471331D = 1;
    level _id_6D85175C3353BA4D::initlootvaultkeypad(_id_56111283B44EA65D, 1, _id_30B1A181FB7CB8D0, _id_F07E92F4B471331D);
    level _id_6D85175C3353BA4D::initlootvaultkeypad(_id_56111283B44EA65D, 3, _id_30B1A181FB7CB8D0, _id_F07E92F4B471331D);
    level _id_6D85175C3353BA4D::initlootvaultkeypad(_id_56111283B44EA65D, 10, _id_30B1A181FB7CB8D0, _id_F07E92F4B471331D);
  }

  if(getdvarint("dvar_310CCFC727D89074", 0))
    level initnonbunkerdoorkeypad();

  level thread locknonbunkerdoors();
}

locknonbunkerdoors() {
  _id_B0D0A442C6392A74 = getdvarint("dvar_C9065088441A5BA4", 10);
  wait(_id_B0D0A442C6392A74);

  foreach(_id_A8D50C407151B462 in level.br_bunker_alt.nonbunkerdoors) {
    foreach(_id_8524C52580A0FB79 in _id_A8D50C407151B462)
    _id_8524C52580A0FB79 scriptabledoorfreeze(1);
  }
}

initnonbunkerdoorkeypad() {
  if(!getdvarint("dvar_310CCFC727D89074", 0)) {
    return;
  }
  foreach(_id_9D5E1298A954ED30, _id_A8D50C407151B462 in level.br_bunker_alt.nonbunkerdoors) {
    if(!isDefined(_id_A8D50C407151B462[0])) {
      continue;
    }
    _id_E5F4F2C965C6D2C9 = _id_A8D50C407151B462[0];
    _id_284824CB5DBCA605 = _id_A8D50C407151B462[1];
    _id_4C44BD3C9BAC5AE2 = anglesToForward(_id_E5F4F2C965C6D2C9.angles);
    _id_A62CF356AA492C1C = anglestoleft(_id_E5F4F2C965C6D2C9.angles);

    switch (_id_9D5E1298A954ED30) {
      case "barn":
        _id_84D1A3A90DAA575C = 72;
        _id_C07F1B238B929B96 = -10;
        break;
      case "outhouse":
        _id_84D1A3A90DAA575C = -28;
        _id_C07F1B238B929B96 = 10;
        break;
      case "shed_01":
        _id_84D1A3A90DAA575C = 62;
        _id_C07F1B238B929B96 = -10;
        break;
      case "shed_02":
        _id_84D1A3A90DAA575C = 62;
        _id_C07F1B238B929B96 = 10;
        break;
      default:
        _id_84D1A3A90DAA575C = 0;
        _id_C07F1B238B929B96 = 0;
    }

    _id_A10AE505A570D67E = _id_E5F4F2C965C6D2C9.origin + (0, 0, 45) + _id_4C44BD3C9BAC5AE2 * _id_84D1A3A90DAA575C + _id_A62CF356AA492C1C * _id_C07F1B238B929B96;
    _id_F09AB32F4C0BF6E2 = spawnscriptable("maphint_keypad_bunker_alt", _id_A10AE505A570D67E);
    _id_F09AB32F4C0BF6E2.door = _id_E5F4F2C965C6D2C9;

    if(isDefined(_id_284824CB5DBCA605))
      _id_F09AB32F4C0BF6E2.door2 = _id_284824CB5DBCA605;
  }
}

isaltbunkerscriptable(_id_A85979FA41F429D1) {
  _id_C0560EA98EA1FC50 = getaltbunkerkeypadindexforscriptable(_id_A85979FA41F429D1);

  if(_id_C0560EA98EA1FC50 >= 0)
    return 1;

  return 0;
}

getaltbunkerkeypadindexforscriptable(_id_A85979FA41F429D1) {
  if(!isbunkeraltenabled())
    return -1;

  _id_2E31B242E107FCAF = getbunkernamefromkeypadscriptableinstance(_id_A85979FA41F429D1);

  if(!isstring(_id_2E31B242E107FCAF))
    return -1;

  _id_C0560EA98EA1FC50 = getaltbunkerindexforname(_id_2E31B242E107FCAF);
  return _id_C0560EA98EA1FC50;
}

getbunkernamefromkeypadscriptableinstance(_id_A85979FA41F429D1) {
  if(isDefined(_id_A85979FA41F429D1) && isDefined(_id_A85979FA41F429D1.door)) {
    if(isDefined(_id_A85979FA41F429D1.door.targetname))
      return _id_A85979FA41F429D1.door.targetname;
    else if(isDefined(_id_A85979FA41F429D1.door.script_noteworthy))
      return _id_A85979FA41F429D1.door.script_noteworthy;
  }

  return 0;
}

keypadscriptableused_altbunker(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isbunkeraltenabled()) {
    return;
  }
  if(!istrue(instance.inuse))
    player thread _keypadscriptableused_bunkeralt(instance, part, state, player, _id_A5B2C541413AA895);
}

_keypadscriptableused_bunkeralt(instance, part, state, player, _id_A5B2C541413AA895) {
  _id_B0BD841CACF6D96D = isaltbunkerscriptable(instance);
  player notify("_keypadScriptableUsed_bunkerAlt");
  player endon("_keypadScriptableUsed_bunkerAlt");

  if(!scripts\mp\flags::gameflag("prematch_done") && !getdvarint("dvar_AF01339226D5DA59", 0)) {
    return;
  }
  if(getdvarint("dvar_CB72EF230BF544AE", 1) && !istrue(self.br_infilstarted)) {
    return;
  }
  _id_5F8D7D12C2C0F0FD = getaltbunkerkeypadindexforscriptable(instance);

  if(_id_5F8D7D12C2C0F0FD == -1) {
    return;
  }
  if(istrue(instance.inuse)) {
    return;
  }
  instance.inuse = 1;

  if(istrue(instance.isdooropened)) {
    return;
  }
  player bunkeralt_playerinteractwithkeypadloop(_id_5F8D7D12C2C0F0FD, instance);

  if(isDefined(player))
    player _id_0B8A0932FDC35B80::playersetkeypadstateindex(0);

  instance.inuse = undefined;
}

bunkeralt_playerinteractwithkeypadloop(_id_5F8D7D12C2C0F0FD, instance) {
  level endon("game_ended");
  self endon("bunkerAlt_kickPlayerFromKeypadMSG");
  thread bunkeralt_damagedeathdisconnectwatch();
  thread bunkeralt_playeridlewatch();
  _id_0B8A0932FDC35B80::playersetkeypadstateindex(1);
  _id_0B8A0932FDC35B80::playersetkeypadcodelengthindex(8);

  while(isDefined(self) && _id_0B8A0932FDC35B80::getkeypadstatefromomnvar() != 0) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message)) {
      if(message == "submit_br_keypad") {
        if(getdvarint("dvar_88C0A775180E459C", 0))
          thread bunkeralt_playeridlewatch();

        if(verifybunkercode(_id_5F8D7D12C2C0F0FD, value) && getdvarint(_func_2EF675C13CA1C4AF("dvar_7B8E27E53A0FF743", _id_5F8D7D12C2C0F0FD), 0)) {
          _id_0B8A0932FDC35B80::playersetkeypadstateindex(2);
          level thread waittoopenaltbunker(instance);
          break;
        } else {
          if(soundexists("br_keypad_deny"))
            playsoundatpos(self.origin, "br_keypad_deny");

          _id_0B8A0932FDC35B80::playersetkeypadstateindex(3);
          waitframe();

          if(isDefined(self))
            _id_0B8A0932FDC35B80::playersetkeypadstateindex(1);
        }

        continue;
      }

      if(message == "exit_br_keypad") {
        break;
      }
    }
  }
}

bunkeralt_damagedeathdisconnectwatch() {
  self endon("bunkerAlt_kickPlayerFromKeypadMSG");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "damage");
  self notify("bunkerAlt_kickPlayerFromKeypadMSG");
}

bunkeralt_playeridlewatch() {
  self endon("bunkerAlt_kickPlayerFromKeypadMSG");
  self notify("bunkerAlt_playerIdleWatch");
  self endon("bunkerAlt_playerIdleWatch");
  wait(getdvarint("dvar_A7F55BD602C77336", 30));
  self notify("bunkerAlt_kickPlayerFromKeypadMSG");
}

waittoopenaltbunker(_id_9DDC5B150DB39159) {
  level endon("game_ended");
  _id_9DDC5B150DB39159.isdooropened = 1;
  wait(getdvarint("dvar_487F91AD6699C497", 2));
  level openaltbunker(_id_9DDC5B150DB39159);
}

openaltbunker(_id_9DDC5B150DB39159) {
  if(isbunkeraltenabled()) {
    if(isDefined(_id_9DDC5B150DB39159.door.targetname)) {
      level thread _id_7D625073C6379D53::openbunkerdoor(_id_9DDC5B150DB39159.door, 0, "bunker_loot_shared", "door_open");
      _id_9DDC5B150DB39159 setscriptablepartstate("maphint_keypad_bunker_alt", "off");
    } else if(isDefined(_id_9DDC5B150DB39159.door.script_noteworthy)) {
      _id_9DDC5B150DB39159.door scriptabledooropen("away", _id_9DDC5B150DB39159.origin);

      if(isDefined(_id_9DDC5B150DB39159.door2))
        _id_9DDC5B150DB39159.door2 scriptabledooropen("away", _id_9DDC5B150DB39159.origin);

      _id_9DDC5B150DB39159 setscriptablepartstate("maphint_keypad_bunker_alt", "off");
    } else {}
  }
}