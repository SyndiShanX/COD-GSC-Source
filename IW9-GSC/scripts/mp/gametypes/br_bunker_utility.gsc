/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_bunker_utility.gsc
******************************************************/

init() {
  initbunkeranims();
  initbunkervfx();
  initbunkerbackwallkeypads();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_keypad_bunker_interior", ::keypadscriptableused);
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_stadium_keypad", ::keypadscriptableused);
}

#using_animtree("animated_props");

initbunkeranims() {
  level.scr_animtree["bunker_door"] = #animtree;
  level.scr_anim["bunker_door"]["door_open"] = % mp_verdansk_bunkerdoor_open;
  level.scr_animname["bunker_door"]["door_open"] = "mp_verdansk_bunkerdoor_open";
  level.scr_anim["bunker_door"]["door_open_puzzle"] = % mp_verdansk_bunkerdoor_open_puzzle;
  level.scr_animname["bunker_door"]["door_open_puzzle"] = "mp_verdansk_bunkerdoor_open_puzzle";
}

initbunkervfx() {
  level._effect["vfx_br_bunker_open"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_open.vfx");
  level._effect["vfx_br_bunker_open_2"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_open_2.vfx");
  level._effect["vfx_br_bunker_open_puzzle"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_open_puzzle.vfx");
  level._effect["vfx_br_bulb_lensflare_green"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_bulb_lensflare_green.vfx");
  level._effect["vfx_br_bulb_lensflare_red"] = loadfx("vfx/iw8_br/gen_amb/vfx_br_bulb_lensflare_red.vfx");
  level._effect["vfx_br_bunker_screen_crashed"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_screen_crashed.vfx");
  level._effect["vfx_br_bunker_screen_rebooting"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_screen_rebooting.vfx");
  level._effect["vfx_br_bunker_screen_ready"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_screen_ready.vfx");
  level._effect["vfx_br_bunker_screen_crashed2"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_screen_crashed2.vfx");
  level._effect["vfx_br_bunker_screen_rebooting2"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_screen_rebooting2.vfx");
  level._effect["vfx_br_bunker_screen_countdown"] = loadfx("vfx/iw8_br/gameplay/bunker/vfx_br_bunker_screen_countdown.vfx");
}

initbunkerdoor(door, _id_56111283B44EA65D, _id_6C797412FA41D3AC) {
  parts = getEntArray(door.target, "targetname");

  foreach(part in parts) {
    if(part.script_noteworthy == "right_door_clip") {
      door.clipleft = part;
      door.clipleft setnonstick(1);
      continue;
    }

    if(part.script_noteworthy == "left_door_clip") {
      door.clipright = part;
      door.clipright setnonstick(1);
    }
  }

  door.animname = "bunker_door";
  door scripts\common\anim::setanimtree();

  if(!istrue(_id_6C797412FA41D3AC))
    level thread initbunkerdooreffects(door, _id_56111283B44EA65D);

  forward = anglesToForward(door.angles);
  _id_C548D45F1D62279A = door.origin + (0, 0, -110) + forward * -128;
  _id_1E15CA204F179886 = getEnt("clip256x256x256", "targetname");
  _id_10688B3021ACC893 = spawn("script_model", _id_C548D45F1D62279A);
  _id_10688B3021ACC893.angles = (0, 0, 0);
  _id_10688B3021ACC893 clonebrushmodeltoscriptmodel(_id_1E15CA204F179886);
  door.addedcollision = _id_10688B3021ACC893;
}

initbunkerdooreffects(door, _id_56111283B44EA65D) {
  wait 10;
  forward = anglesToForward(door.angles);
  _id_F6F6DC0578A5AB9B = door.origin + (0, 0, 109) + forward * 12.5;
  door.lightscriptable = spawnscriptable("bunker_active_indicator_light", _id_F6F6DC0578A5AB9B);

  if(istrue(_id_56111283B44EA65D))
    door.lightscriptable setscriptablepartstate("bunker_active_indicator_light", "active");
}

openbunkerdoor(door, _id_6F1440DA20ACA842, _id_D5A6386C41776B72, _id_87CD25F89FF7DD7C) {
  _id_7F980E69DEF745B8 = scripts\engine\utility::ter_op(isDefined(_id_87CD25F89FF7DD7C), _id_87CD25F89FF7DD7C, "door_open");
  door thread scripts\common\anim::anim_single_solo(door, _id_7F980E69DEF745B8);

  if(soundexists("br_bunker_door_open_01"))
    door playSound("br_bunker_door_open_01");

  if(istrue(_id_6F1440DA20ACA842) && isDefined(_id_D5A6386C41776B72))
    spawnbunkerloot(door.origin, _id_D5A6386C41776B72);

  animlength = getanimlength(level.scr_anim["bunker_door"][_id_7F980E69DEF745B8]);
  _id_1827F38F62DB2456 = spawn("script_model", door.origin);
  _id_1827F38F62DB2456 setModel("x1_bunker_door_01_anim_open");
  _id_1827F38F62DB2456.angles = door.angles;
  _id_1827F38F62DB2456.origin = _id_1827F38F62DB2456.origin - (0, 0, 200);
  waitframe();

  if(isDefined(door.addedcollision))
    door.addedcollision delete();

  wait 8;
  forward = anglesToForward(door.angles);
  door.clipleft.origin = door.clipleft.origin + forward * -3.0;
  door.clipright.origin = door.clipright.origin + forward * -3.0;
  door.clipleft rotateTo(door.clipleft.angles - (0, 90, 0), 5, 0.2, 0.8);
  door.clipright rotateTo(door.clipright.angles + (0, 90, 0), 5, 0.2, 0.8);

  if(soundexists("br_bunker_door_open_02"))
    door playSound("br_bunker_door_open_02");

  wait(animlength - 8.1);
  _id_1827F38F62DB2456.origin = _id_1827F38F62DB2456.origin + (0, 0, 200);
  wait 0.1;
  door hide();
  door.clipleft delete();
  door.clipright delete();
}

spawnbunkerloot(_id_E6B931CF5EE6F106, _id_F7696F3F59F35F14) {
  if(!isDefined(level.br_pickups)) {
    return;
  }
  _id_EACC19A16536FA99 = getclosestmatchingmasterlootnode(_id_E6B931CF5EE6F106, _id_F7696F3F59F35F14);
  _id_D7EF84C88D8F5C02 = scripts\engine\utility::getStructArray(_id_EACC19A16536FA99.target, "targetname");
  _id_472C2AA584E7C759 = [];
  _id_45CAFE5DF2AC0350 = [];
  _id_B134786095FA37C0 = [];
  _id_74C0315F0DA36A59 = [];
  _id_346BA8DDBBAC6872 = getdvarint("dvar_35A1A079B733DAAE", 3);
  _id_C9CABEEA5ADD433C = getdvarint("dvar_357E9279B70D742C", 5);
  _id_412A308A15A75881 = getdvarint("dvar_76CD14E5D929A7A7", 3);
  _id_760E71B0B094D28F = getdvarint("dvar_76F002E5D94FC7C9", 5);

  foreach(item in _id_D7EF84C88D8F5C02) {
    if(item.script_noteworthy == "br_loot_cache_lege") {
      _id_472C2AA584E7C759[_id_472C2AA584E7C759.size] = item;
      continue;
    }

    if(item.script_noteworthy == "br_loot_cache") {
      _id_45CAFE5DF2AC0350[_id_45CAFE5DF2AC0350.size] = item;
      continue;
    }

    if(issubstr(item.script_noteworthy, "uniqueLootItem")) {
      _id_B134786095FA37C0[_id_B134786095FA37C0.size] = item;
      continue;
    }

    _id_74C0315F0DA36A59[_id_74C0315F0DA36A59.size] = item;
  }

  _id_FC617751F654A141 = randomintrange(_id_346BA8DDBBAC6872, _id_C9CABEEA5ADD433C);
  _id_472C2AA584E7C759 = scripts\engine\utility::array_randomize(_id_472C2AA584E7C759);
  _id_45CAFE5DF2AC0350 = scripts\engine\utility::array_randomize(_id_45CAFE5DF2AC0350);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_472C2AA584E7C759[_id_AC0E594AC96AA3A8])) {
      scriptable = spawnscriptable(_id_472C2AA584E7C759[_id_AC0E594AC96AA3A8].script_noteworthy, _id_472C2AA584E7C759[_id_AC0E594AC96AA3A8].origin, _id_472C2AA584E7C759[_id_AC0E594AC96AA3A8].angles);
      _id_7E52B56769FA7774::registerscriptableinstance(scriptable);
    }
  }

  _id_FC617751F654A141 = randomintrange(_id_412A308A15A75881, _id_760E71B0B094D28F);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_FC617751F654A141; _id_AC0E594AC96AA3A8++) {
    if(isDefined(_id_45CAFE5DF2AC0350[_id_AC0E594AC96AA3A8])) {
      scriptable = spawnscriptable(_id_45CAFE5DF2AC0350[_id_AC0E594AC96AA3A8].script_noteworthy, _id_45CAFE5DF2AC0350[_id_AC0E594AC96AA3A8].origin, _id_45CAFE5DF2AC0350[_id_AC0E594AC96AA3A8].angles);
      _id_7E52B56769FA7774::registerscriptableinstance(scriptable);
    }
  }

  foreach(index, item in _id_B134786095FA37C0) {
    if(isDefined(item.script_noteworthy)) {
      _id_7957AE38C168F3DF = uniquelootitemlookup(item.script_noteworthy);
      count = getitemcount(_id_7957AE38C168F3DF);
      _id_11B3BB0A908E9D8D = item.origin;
      _id_E4D6313644ECB5E3 = item.angles;

      if(item.script_noteworthy == "uniqueLootItem_1") {
        if(level.mapname == "mp_bm_bunker01") {
          switch (index) {
            case 0:
              continue;
            case 1:
              _id_11B3BB0A908E9D8D = (1969, 639, 68);
              _id_E4D6313644ECB5E3 = (0, 106.6, 75);
              break;
            case 2:
              _id_11B3BB0A908E9D8D = (1962, 665, 68);
              _id_E4D6313644ECB5E3 = (0, 106.6, 75);
              break;
          }
        } else if(scripts\cp_mp\utility\game_utility::isdonetskmap()) {
          switch (index) {
            case 0:
              continue;
            case 1:
              _id_11B3BB0A908E9D8D = (-3858, 62596, 573);
              _id_E4D6313644ECB5E3 = (0, 106.6, 75);
              break;
            case 2:
              _id_11B3BB0A908E9D8D = (-3850, 62571, 573);
              _id_E4D6313644ECB5E3 = (0, 106.6, 75);
              break;
          }
        }
      }

      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(_id_11B3BB0A908E9D8D, _id_E4D6313644ECB5E3);
      scriptable = _id_7E52B56769FA7774::spawnpickup(_id_7957AE38C168F3DF, _id_CB4FAD49263E20C4, count, 0);

      if(isDefined(scriptable))
        scriptable.uniquelootitemid = item.script_noteworthy;
    }
  }

  foreach(item in _id_74C0315F0DA36A59) {
    if(isDefined(item.script_noteworthy)) {
      _id_4B4B03CC9E68B30A = item.script_noteworthy;

      if(item.script_noteworthy == "jugg_minigun") {
        if(getdvarint("dvar_7B80600D0CF3B471", 1) == 0) {
          continue;
        }
        _id_4B4B03CC9E68B30A = "brloot_weapon_lm_dblmg_lege";
      } else if(item.script_noteworthy == "jugg_minigun_chance") {
        roll = randomintrange(1, 100);

        if(roll > getdvarint("dvar_AAB4799A77E73A1D", 25))
          continue;
        else
          _id_4B4B03CC9E68B30A = "brloot_weapon_lm_dblmg_lege";
      }

      count = getitemcount(_id_4B4B03CC9E68B30A);
      _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(item.origin, item.angles);
      scriptable = _id_7E52B56769FA7774::spawnpickup(_id_4B4B03CC9E68B30A, _id_CB4FAD49263E20C4, count, 0);
    }
  }
}

getitemcount(_id_4B4B03CC9E68B30A) {
  if(isDefined(level.br_lootiteminfo[_id_4B4B03CC9E68B30A]))
    return level.br_lootiteminfo[_id_4B4B03CC9E68B30A].fullweaponobj.clipsize;
  else if(isDefined(level.br_ammo_clipsize[_id_4B4B03CC9E68B30A]))
    return level.br_ammo_clipsize[_id_4B4B03CC9E68B30A];
  else
    return 1;
}

uniquelootitemlookup(index) {
  switch (index) {
    case "uniqueLootItem_1":
      return "brloot_weapon_bp_reward_sm_mpapa7_lege";
    case "uniqueLootItem_2":
      return "brloot_weapon_bp_reward_sm_mpapa7_lege";
    default:
      return "brloot_weapon_bp_reward_sm_mpapa7_lege";
  }
}

getclosestmatchingmasterlootnode(_id_E6B931CF5EE6F106, _id_F7696F3F59F35F14) {
  _id_5AF9689121F18502 = scripts\engine\utility::getStructArray(_id_F7696F3F59F35F14, "targetname");

  if(isDefined(_id_5AF9689121F18502)) {
    if(_id_5AF9689121F18502.size == 1)
      return _id_5AF9689121F18502[0];
    else {
      _id_D6EB01B1DC33FFDC = undefined;
      _id_42CA41C7DADAE0C0 = undefined;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_5AF9689121F18502.size; _id_AC0E594AC96AA3A8++) {
        dist = distance2dsquared(_id_E6B931CF5EE6F106, _id_5AF9689121F18502[_id_AC0E594AC96AA3A8].origin);

        if(!isDefined(_id_42CA41C7DADAE0C0) || dist < _id_42CA41C7DADAE0C0) {
          _id_42CA41C7DADAE0C0 = dist;
          _id_D6EB01B1DC33FFDC = _id_5AF9689121F18502[_id_AC0E594AC96AA3A8];
        }
      }

      return _id_D6EB01B1DC33FFDC;
    }
  }

  return undefined;
}

adjustuniqueitemposition(item) {
  if(iscloseto(item.angles[1], 106, 1)) {
    forward = anglesToForward(item.angles);
    return [item.origin + forward * 30, (item.angles[0], 106, 90)];
  } else if(iscloseto(item.angles[1], 90, 1)) {
    forward = anglesToForward(item.angles);
    return [item.origin - forward * 10, item.angles];
  } else if(iscloseto(item.angles[1], 70, 1))
    return [item.origin, (item.angles[0], item.angles[1], 0)];

  return [item.origin, item.angles];
}

iscloseto(_id_456C3AB4CCDC8D5D, _id_456C37B4CCDC86C4, tolerance) {
  return abs(_id_456C3AB4CCDC8D5D - _id_456C37B4CCDC86C4) <= tolerance;
}

disablelootbunkercachelocations() {
  diablecachesaroundorigin((-17923, -42192, -252));
  diablecachesaroundorigin((-15045, 45467, -186));
  diablecachesaroundorigin((1992, 38955, 1378));
  diablecachesaroundorigin((49764, 34322, 206));
  diablecachesaroundorigin((52510, -32696, -119));
  diablecachesaroundorigin((47158, -10562, 131));
  diablecachesaroundorigin((-39282, -2005, -78));
  diablecachesaroundorigin((41919, -41349, -580));
  diablecachesaroundorigin((-38426, -19360, 403));
  diablecachesaroundorigin((21085, 16700, 246));
  diablecachesaroundorigin((17893, -34039, -561));
}

disablebunker11cachelocations() {
  diablecachesaroundorigin((-4337, 62466, 580));
}

diablecachesaroundorigin(origin) {
  _id_4EAD6B4FF3816236 = getunusedlootcachepoints(origin, 2000, 0, 0);

  foreach(_id_0CB979617C1B66D1 in _id_4EAD6B4FF3816236) {
    if(iscloseto(origin[2], _id_0CB979617C1B66D1.origin[2], 100))
      disablelootspawnpoint(_id_0CB979617C1B66D1.index);
  }
}

initbunkerbackwallkeypads() {
  level.bunkerinteriorkeypads = [];
  _id_C347D25E165AC454 = scripts\engine\utility::getStructArray("bunker_back_keypad", "targetname");

  foreach(_id_6EFE0C080EEEDD55 in _id_C347D25E165AC454) {
    scriptable = spawnscriptable("maphint_keypad_bunker_interior", _id_6EFE0C080EEEDD55.origin);
    scriptable.backwallkeypad = 1;

    if(isDefined(_id_6EFE0C080EEEDD55.script_noteworthy)) {
      scriptable.bunkernum = int(_id_6EFE0C080EEEDD55.script_noteworthy);
      level.bunkerinteriorkeypads[scriptable.bunkernum] = scriptable;
    }
  }
}

keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  instance setscriptablepartstate(part, "off");
  player keypad_playerinteractwithkeypadloop(instance);

  if(isDefined(player))
    player _id_0B8A0932FDC35B80::playersetkeypadstateindex(0);

  wait 1;
  instance setscriptablepartstate(part, "on");
}

keypad_playerinteractwithkeypadloop(instance) {
  level endon("game_ended");
  self endon("keypad_kickPlayerFromKeypadMSG");
  thread keypad_damagedeathdisconnectwatch();
  thread _id_5FD9CF8258FBA16D();
  thread keypad_playeridlewatch();
  _id_0B8A0932FDC35B80::playersetkeypadstateindex(1);
  _id_885780D268327BA4 = 8;

  if(isDefined(instance._id_885780D268327BA4))
    _id_885780D268327BA4 = instance._id_885780D268327BA4;

  _id_0B8A0932FDC35B80::playersetkeypadcodelengthindex(_id_885780D268327BA4);

  while(isDefined(self) && _id_0B8A0932FDC35B80::getkeypadstatefromomnvar() != 0) {
    self waittill("luinotifyserver", message, value);

    if(isDefined(message)) {
      if(message == "submit_br_keypad") {
        if(getdvarint("dvar_CC6142F2BF8A87B7", 0))
          thread keypad_playeridlewatch();

        if(isDefined(instance.code) && iscodecorrect(instance, value)) {
          _id_0B8A0932FDC35B80::playersetkeypadstateindex(2);
          instance._id_B50F7CB6D7639B3A = 2;

          if(isDefined(instance.successfunction))
            self[[instance.successfunction]](instance);

          break;
        } else {
          if(soundexists("br_keypad_deny"))
            playsoundatpos(self.origin, "br_keypad_deny");

          instance._id_B50F7CB6D7639B3A = 3;
          _id_0B8A0932FDC35B80::playersetkeypadstateindex(3);
          wait 2;

          if(isDefined(self))
            _id_0B8A0932FDC35B80::playersetkeypadstateindex(1);
        }

        continue;
      }

      if(message == "exit_br_keypad") {
        instance._id_B50F7CB6D7639B3A = 3;
        break;
      }
    }
  }

  self notify("doneWithKeypad");
}

keypad_damagedeathdisconnectwatch() {
  self endon("keypad_kickPlayerFromKeypadMSG");
  level endon("game_ended");
  scripts\engine\utility::waittill_any_3("death", "disconnect", "damage");
  self notify("keypad_kickPlayerFromKeypadMSG");
}

_id_5FD9CF8258FBA16D() {
  self endon("keypad_kickPlayerFromKeypadMSG");
  level endon("game_ended");
  self waittill("last_stand_start");
  self notify("keypad_kickPlayerFromKeypadMSG");
}

keypad_playeridlewatch() {
  self endon("keypad_kickPlayerFromKeypadMSG");
  self notify("keypad_playerIdleWatch");
  self endon("keypad_playerIdleWatch");
  wait(getdvarint("dvar_778FEF1BD71D5583", 30));
  self notify("keypad_kickPlayerFromKeypadMSG");
}

iscodecorrect(instance, value) {
  if(!isDefined(instance.code["string"])) {
    return;
  }
  _id_391DF67337EEDFF2 = int(instance.code["string"]);

  if(value == _id_391DF67337EEDFF2)
    return 1;

  return 0;
}

generatenumbercode_array(_id_885780D268327BA4, _id_48B11326257052F1) {
  numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_885780D268327BA4; _id_AC0E594AC96AA3A8++) {
    numbers = scripts\engine\utility::array_randomize(numbers);
    _id_48B11326257052F1.code[_id_AC0E594AC96AA3A8] = numbers[0];
    numbers = scripts\engine\utility::array_remove(numbers, numbers[0]);
  }
}

generatenumbercode(_id_885780D268327BA4, _id_48B11326257052F1, _id_2E698AED0DE1CE13, _id_D3DA81DF8D468200) {
  numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9];
  _id_48B11326257052F1.code = [];

  if(!isDefined(_id_2E698AED0DE1CE13))
    _id_2E698AED0DE1CE13 = 0;
  else
    _id_48B11326257052F1.code["doubles"] = [];

  if(!isDefined(_id_D3DA81DF8D468200))
    _id_D3DA81DF8D468200 = 0;
  else
    _id_48B11326257052F1.code["triples"] = [];

  _id_6CB4C9E48F55503E = _id_885780D268327BA4 - _id_2E698AED0DE1CE13 - _id_D3DA81DF8D468200 * 2;
  numbers = scripts\engine\utility::array_randomize(numbers);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_6CB4C9E48F55503E; _id_AC0E594AC96AA3A8++)
    _id_48B11326257052F1.code["array"][_id_AC0E594AC96AA3A8] = numbers[_id_AC0E594AC96AA3A8];

  _id_91EF66919BFE4233 = _id_48B11326257052F1.code["array"];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2E698AED0DE1CE13; _id_AC0E594AC96AA3A8++) {
    _id_19F414B6862A5D43 = _id_91EF66919BFE4233[_id_AC0E594AC96AA3A8];
    _id_48B11326257052F1.code["array"][_id_48B11326257052F1.code["array"].size] = _id_19F414B6862A5D43;
    _id_48B11326257052F1.code["doubles"][_id_48B11326257052F1.code["doubles"].size] = _id_19F414B6862A5D43;
    _id_91EF66919BFE4233 = scripts\engine\utility::array_remove(_id_91EF66919BFE4233, _id_91EF66919BFE4233[_id_AC0E594AC96AA3A8]);
  }

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_D3DA81DF8D468200; _id_AC0E594AC96AA3A8++) {
    _id_7E2E31FBE4946A0A = _id_91EF66919BFE4233[_id_AC0E594AC96AA3A8];

    for(x = 0; x < 2; x++)
      _id_48B11326257052F1.code["array"][_id_48B11326257052F1.code["array"].size] = _id_7E2E31FBE4946A0A;

    _id_48B11326257052F1.code["triples"][_id_48B11326257052F1.code["triples"].size] = _id_7E2E31FBE4946A0A;
    _id_91EF66919BFE4233 = scripts\engine\utility::array_remove(_id_91EF66919BFE4233, _id_91EF66919BFE4233[_id_AC0E594AC96AA3A8]);
  }

  _id_48B11326257052F1.code["array"] = scripts\engine\utility::array_randomize(_id_48B11326257052F1.code["array"]);
  _id_48B11326257052F1.code["string"] = "";

  foreach(num in _id_48B11326257052F1.code["array"]) {
    _id_E30EE4AE67D05D90 = "" + num;
    _id_48B11326257052F1.code["string"] = _id_48B11326257052F1.code["string"] + _id_E30EE4AE67D05D90;
  }
}

generatecodestoshow(code, _id_9453F59EFCD1ED15, _id_A889768A352BA094, _id_C36F81528CF3AA0D) {
  if(_id_A889768A352BA094 > code["doubles"].size)
    _id_A889768A352BA094 = 0;

  if(_id_C36F81528CF3AA0D > code["triples"].size)
    _id_C36F81528CF3AA0D = 0;

  _id_A5F8F3404BCC96DD = 0;
  _id_B2A520A3D92A633A = 0;
  _id_AE116A6217A88727 = scripts\engine\utility::array_randomize(scripts\engine\utility::array_remove_duplicates(code["array"]));
  _id_CB805991D3BB8626 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_9453F59EFCD1ED15; _id_AC0E594AC96AA3A8++) {
    if(_id_A5F8F3404BCC96DD < _id_A889768A352BA094) {
      _id_42C5483C4E175FD6 = code["doubles"][_id_A5F8F3404BCC96DD];
      _id_A5F8F3404BCC96DD++;
    } else if(_id_B2A520A3D92A633A < _id_C36F81528CF3AA0D) {
      _id_42C5483C4E175FD6 = code["triples"][_id_B2A520A3D92A633A];
      _id_B2A520A3D92A633A++;
    } else
      _id_42C5483C4E175FD6 = _id_AE116A6217A88727[0];

    _id_CB805991D3BB8626[_id_42C5483C4E175FD6] = _id_AC0E594AC96AA3A8 + 1;
    _id_AE116A6217A88727 = scripts\engine\utility::array_remove(_id_AE116A6217A88727, _id_42C5483C4E175FD6);
  }

  _id_9A3CCD47DAEBAAE6 = [];
  _id_759D7590979FC897 = getarraykeys(_id_CB805991D3BB8626);

  foreach(index, num in _id_759D7590979FC897) {
    _id_9A3CCD47DAEBAAE6[index] = code["array"];
    _id_A85371480849C439 = 0;

    foreach(_id_485BD2F8DFA66158, _id_8C32589FF913F848 in _id_9A3CCD47DAEBAAE6[index]) {
      if(_id_8C32589FF913F848 == num && _id_A85371480849C439) {
        _id_9A3CCD47DAEBAAE6[index][_id_485BD2F8DFA66158] = "symbol" + _id_CB805991D3BB8626[num];
        numfound = 1;
        continue;
      }

      if(_id_8C32589FF913F848 == num && !_id_A85371480849C439) {
        _id_A85371480849C439 = 1;
        continue;
      }

      if(scripts\engine\utility::array_contains(_id_759D7590979FC897, _id_8C32589FF913F848))
        _id_9A3CCD47DAEBAAE6[index][_id_485BD2F8DFA66158] = "symbol" + _id_CB805991D3BB8626[_id_8C32589FF913F848];
    }
  }

  return _id_9A3CCD47DAEBAAE6;
}

assigncodecomputersdisplaycodes(_id_406981C6D2ED9301, displaycodes) {
  _id_406981C6D2ED9301 = scripts\engine\utility::array_randomize(_id_406981C6D2ED9301);

  foreach(_id_AC0E594AC96AA3A8, computer in _id_406981C6D2ED9301) {
    if(_id_AC0E594AC96AA3A8 > displaycodes.size)
      _id_AC0E594AC96AA3A8 = 0;

    computer.scriptable.displaycodeindex = _id_AC0E594AC96AA3A8;
  }
}

getcodecomputerdisplaycode(_id_48B11326257052F1, displaycodeindex) {
  return _id_48B11326257052F1.displaycodes[displaycodeindex];
}

lockscriptabledoors(scriptable) {
  if(isDefined(scriptable.doors)) {
    foreach(door in scriptable.doors)
    door scriptabledoorfreeze(1);
  }
}

unlockscriptabledoors(scriptable) {
  if(isDefined(scriptable.doors)) {
    foreach(door in scriptable.doors)
    door scriptabledoorfreeze(0);
  }
}

openscriptabledoors(scriptable, _id_D647B24E544508F6) {
  foreach(door in scriptable.doors)
  door scriptabledooropen("away", scriptable.origin);

  if(istrue(_id_D647B24E544508F6)) {
    wait 1;
    lockscriptabledoors(scriptable);
  }
}

closescriptabledoors(scriptable, _id_D647B24E544508F6) {
  foreach(door in scriptable.doors)
  door scriptabledoorclose(1);

  if(istrue(_id_D647B24E544508F6)) {
    while(!scriptable.doors[0] scriptabledoorisclosed())
      waitframe();

    lockscriptabledoors(scriptable);
  }
}