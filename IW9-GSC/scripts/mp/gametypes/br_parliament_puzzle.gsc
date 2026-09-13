/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_parliament_puzzle.gsc
*********************************************************/

init() {
  level._id_4556E51A733145B4 = getdvarint("dvar_4F4F4598B9CFCBCD", 1);
  level._id_BA18E950012E7D13 = spawnStruct();

  if(level._id_4556E51A733145B4) {
    level._id_BA18E950012E7D13.hints = [];
    level._id_BA18E950012E7D13._id_66647DAB4AD2648B = [];
    scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_computer", ::codecomputerscriptableused);
  }

  level._effect["vfx_br_traproom_vent_gas_1"] = loadfx("vfx/iw8_br/gameplay/subway/vfx_br_traproom_vent_gas_1.vfx");
  level thread initpostmain();
}

initpostmain() {
  waittillframeend;
  level thread _id_07A416269C3C3336();

  if(!level._id_4556E51A733145B4) {
    return;
  }
  scripts\mp\flags::gameflagwait("prematch_done");

  if(!istrue(level._id_BA18E950012E7D13._id_7525CCC097F6EF8D))
    _id_1F4FE3D56A5BE372();
}

codecomputerscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(!isDefined(instance._id_9C3BC381E6121293)) {
    return;
  }
  level thread _codecomputerscriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_codecomputerscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  if(state == "on") {
    if(!scripts\mp\flags::gameflag("prematch_done") || !istrue(level._id_BA18E950012E7D13._id_2C1BEB232DEF3373)) {
      playsoundatpos(instance.origin, "br_computer_deny");
      instance setscriptablepartstate("maphint_computer", "off");
      wait 3;
      instance setscriptablepartstate("maphint_computer", "on");
    } else {
      player scripts\mp\playerlogic::_id_E636E108DFFE6AB7();
      instance setscriptablepartstate("maphint_computer", "off");
      playsoundatpos(instance.origin, "stadium_computer_code_start");
      wait 2;

      foreach(_id_5D8B57CC867A9F80 in level._id_BA18E950012E7D13.pattern) {
        if(!isDefined(player) || !isalive(player)) {
          break;
        }

        instance._id_D408A87AC65916AE setscriptablepartstate("parliament_code_computer", _id_5D8B57CC867A9F80);
        playsoundatpos(instance.origin, "stadium_computer_code_number");
        wait 1;
      }

      if(isDefined(player) && isalive(player)) {
        _id_7D625073C6379D53::keypadscriptableused(level._id_BA18E950012E7D13.hints["escaperoom_terminal_keypad"].scriptable, "maphint_stadium_keypad", "on", player);
        instance._id_D408A87AC65916AE setscriptablepartstate("parliament_code_computer", "keypad");
        player scripts\engine\utility::waittill_any_return_3("doneWithKeypad", "keypad_kickPlayerFromKeypadMSG");
      }

      instance._id_B50F67B6D7636D0B = 1;
      playsoundatpos(instance.origin, "stadium_computer_code_end");
      wait 3;
      instance._id_D408A87AC65916AE setscriptablepartstate("parliament_code_computer", "intro");
      instance setscriptablepartstate("maphint_computer", "on");
    }
  }
}

_id_9FDADB62B1BDF018(instance) {
  playsoundatpos(instance.origin, "br_phone_code_correct");
  instance._id_B50F7CB6D7639B3A = 2;
  _id_7D625073C6379D53::unlockscriptabledoors(instance);
}

_id_07A416269C3C3336() {
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("placard_holmes", "targetname");
  level._id_BA18E950012E7D13._id_66647DAB4AD2648B["holmes"] = _id_9577902B42FBD7F6;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("placard_whitehouse", "targetname");
  level._id_BA18E950012E7D13._id_66647DAB4AD2648B["whitehouse"] = _id_9577902B42FBD7F6;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("placard_blackhouse", "targetname");
  level._id_BA18E950012E7D13._id_66647DAB4AD2648B["blackhouse"] = _id_9577902B42FBD7F6;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("placard_daryl", "targetname");
  level._id_BA18E950012E7D13._id_66647DAB4AD2648B["daryl"] = _id_9577902B42FBD7F6;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("placard_horse", "targetname");
  level._id_BA18E950012E7D13._id_66647DAB4AD2648B["horse"] = _id_9577902B42FBD7F6;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("placard_tinyhouse", "targetname");
  level._id_BA18E950012E7D13._id_66647DAB4AD2648B["tinyhouse"] = _id_9577902B42FBD7F6;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("placard_franz", "targetname");
  level._id_BA18E950012E7D13._id_66647DAB4AD2648B["jolyon"] = _id_9577902B42FBD7F6;
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("placard_missing", "targetname");
  level._id_BA18E950012E7D13._id_66647DAB4AD2648B["blank"] = _id_9577902B42FBD7F6;
  level._id_BA18E950012E7D13._id_903C5EF5126C054F = getEnt("parliament_interior_trigger", "targetname");
}

_id_062D0219553B4DEC() {
  _id_9577902B42FBD7F6 = scripts\engine\utility::getStructArray("secret_subway_serverTV", "targetname");
  level._id_BA18E950012E7D13._id_AA165CABA5290EEE["secret_subway_serverTV"] = _id_9577902B42FBD7F6;
  loc = scripts\engine\utility::getStruct("secret_subway_layover_computer", "targetname");
  level._id_BA18E950012E7D13._id_AA165CABA5290EEE["secret_subway_layover_computer"] = loc;
  loc = scripts\engine\utility::getStruct("secret_subway_departure_computer", "targetname");
  level._id_BA18E950012E7D13._id_AA165CABA5290EEE["secret_subway_departure_computer"] = loc;
}

_id_1F4FE3D56A5BE372() {
  doornode = scripts\engine\utility::getStruct("parliament_door", "targetname");
  doors = getentitylessscriptablearray(doornode.target, "targetname");
  loc = scripts\engine\utility::getStruct("maphint_keypad_escaperoom_lock", "targetname");
  loc.scriptable = spawnscriptable("maphint_stadium_keypad", loc.origin);
  loc.scriptable.name = "escaperoom_start_keypad";
  loc.scriptable.code = [];
  loc.scriptable.code["string"] = "2179";
  loc.scriptable.code["array"] = [2, 1, 7, 9];
  loc.scriptable._id_885780D268327BA4 = 4;
  loc.scriptable.successfunction = ::_id_A7DA6DAE9B8CA5EA;
  loc.scriptable.doors = doors;
  level._id_BA18E950012E7D13.hints["escaperoom_start_keypad"] = loc;
  loc = spawnStruct();
  loc.scriptable = spawnscriptable("maphint_stadium_keypad", level._id_BA18E950012E7D13.hints["escaperoom_start_keypad"].origin);
  loc.scriptable.name = "escaperoom_terminal_keypad";
  loc.scriptable.code = [];
  loc.scriptable.code["string"] = "2179";
  loc.scriptable.code["array"] = [2, 1, 7, 9];
  loc.scriptable._id_885780D268327BA4 = 4;
  loc.scriptable.successfunction = ::_id_7DF49F51F4834135;
  loc.scriptable.doors = doors;
  level._id_BA18E950012E7D13.hints["escaperoom_terminal_keypad"] = loc;
  loc = scripts\engine\utility::getStruct("maphint_parliament_terminal", "targetname");
  loc.scriptable = spawnscriptable("maphint_computer", loc.origin, loc.angles);
  loc.scriptable._id_9C3BC381E6121293 = 1;
  loc.scriptable._id_6EB04909CB5CA84D = level._id_BA18E950012E7D13.hints["escaperoom_terminal_keypad"].scriptable;
  loc.scriptable._id_B50F7CB6D7639B3A = 1;
  _id_B557DDC2BE0781FD = scripts\engine\utility::getStruct("parliament_terminal_monitor", "targetname");
  loc.scriptable._id_D408A87AC65916AE = spawnscriptable("parliament_code_computer", _id_B557DDC2BE0781FD.origin, _id_B557DDC2BE0781FD.angles);
  level._id_BA18E950012E7D13.hints["maphint_parliament_terminal"] = loc;

  if(1)
    level thread computer_debugtestloop(loc.scriptable._id_D408A87AC65916AE);

  level._id_BA18E950012E7D13._id_7525CCC097F6EF8D = 1;
}

_id_A7DA6DAE9B8CA5EA(instance) {
  level._id_BA18E950012E7D13._id_2C1BEB232DEF3373 = 1;
  _id_7D625073C6379D53::closescriptabledoors(instance, 1);
  level._id_BA18E950012E7D13._id_3E9FEDFEA8104A09 = [];

  foreach(player in level.players) {
    if(isDefined(player) && isalive(player) && player istouching(level._id_BA18E950012E7D13._id_903C5EF5126C054F))
      level._id_BA18E950012E7D13._id_3E9FEDFEA8104A09[level._id_BA18E950012E7D13._id_3E9FEDFEA8104A09.size] = player;
  }

  _id_022859C35105EAB3();
  _id_9FDCE6FD13B04C1C();
  _id_EED67C3B87D257F1();
  level thread _id_FBA005DEACE9B861();
}

_id_FBA005DEACE9B861() {
  level endon("parliament_puzzle_solved");
  _id_BD72523EE36F951E = getdvarint("dvar_B881F9D1B1278F0F", 90);
  scripts\engine\utility::exploder("gas_stage_1");
  wait(_id_BD72523EE36F951E);
  scripts\engine\utility::stop_exploder("gas_stage_1");
  scripts\engine\utility::exploder("gas_stage_2");
  level thread _id_BE4056EFFAD83342();

  while(level._id_BA18E950012E7D13._id_3E9FEDFEA8104A09.size > 0)
    wait 1;

  scripts\engine\utility::stop_exploder("gas_stage_2");
  level notify("endParliamentGasDamageTick");
  level._id_BA18E950012E7D13._id_2C1BEB232DEF3373 = 0;
  _id_7D625073C6379D53::unlockscriptabledoors(level._id_BA18E950012E7D13.hints["escaperoom_start_keypad"].scriptable);
  _id_7D625073C6379D53::openscriptabledoors(level._id_BA18E950012E7D13.hints["escaperoom_start_keypad"].scriptable);
  _id_A2AFC477C3EC9C61();
}

_id_7DF49F51F4834135(instance) {
  level notify("parliament_puzzle_solved");
  level notify("endParliamentGasDamageTick");
  level._id_BA18E950012E7D13._id_2C1BEB232DEF3373 = 0;

  if(!isDefined(level._id_BA18E950012E7D13._id_A7E7B4170E816665))
    level._id_BA18E950012E7D13._id_A7E7B4170E816665 = [];

  level._id_BA18E950012E7D13._id_A7E7B4170E816665[level._id_BA18E950012E7D13._id_A7E7B4170E816665.size] = self.team;
  _id_7D625073C6379D53::unlockscriptabledoors(level._id_BA18E950012E7D13.hints["escaperoom_start_keypad"].scriptable);
  _id_7D625073C6379D53::openscriptabledoors(level._id_BA18E950012E7D13.hints["escaperoom_start_keypad"].scriptable);
}

_id_EED67C3B87D257F1() {
  foreach(key, _id_DE9F8F62EB8BB154 in level._id_BA18E950012E7D13._id_E9B051B4A987405F) {
    foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B[key]) {
      angles = undefined;

      if(key == "blank")
        angles = (360, 359.999, -8.79989);
      else
        angles = loc.angles + (0, 180, 0);

      if(!isDefined(loc.scriptable))
        loc.scriptable = spawnscriptable("parliament_placard", loc.origin, angles);

      loc.scriptable setscriptablepartstate("parliament_placard", _id_DE9F8F62EB8BB154);
    }
  }

  _id_2813847C63A770E9 = getarraykeys(level._id_BA18E950012E7D13._id_E9B051B4A987405F);
  _id_6E634C3A5020C0A6 = getarraykeys(level._id_BA18E950012E7D13._id_66647DAB4AD2648B);

  foreach(key in _id_6E634C3A5020C0A6) {
    if(!scripts\engine\utility::array_contains(_id_2813847C63A770E9, key)) {
      foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B[key]) {
        angles = undefined;

        if(key == "blank")
          angles = (360, 359.999, -8.79989);
        else
          angles = loc.angles + (0, 180, 0);

        if(!isDefined(loc.scriptable))
          loc.scriptable = spawnscriptable("parliament_placard", loc.origin, angles);

        loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
      }
    }
  }
}

_id_A2AFC477C3EC9C61() {
  foreach(_id_71F68A71A1C9346D in level._id_BA18E950012E7D13._id_66647DAB4AD2648B) {
    foreach(loc in _id_71F68A71A1C9346D)
    loc.scriptable setscriptablepartstate("parliament_placard", "blank");
  }
}

_id_022859C35105EAB3() {
  _id_2B32D871F51C34F1 = level._id_BA18E950012E7D13.hints["escaperoom_terminal_keypad"].scriptable;
  _id_2B32D871F51C34F1.code = [];
  _id_2B32D871F51C34F1.code["number_part"] = [];
  _id_2B32D871F51C34F1.code["string"] = "";
  _id_048CDF3767789993 = [2, 3, 4, 5, 7];
  _id_048CDF3767789993 = scripts\engine\utility::array_randomize(_id_048CDF3767789993);
  _id_EB002DF09B83B915 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 4; _id_AC0E594AC96AA3A8++)
    _id_EB002DF09B83B915[_id_AC0E594AC96AA3A8] = _id_048CDF3767789993[_id_AC0E594AC96AA3A8];

  _id_2B32D871F51C34F1.code["player_facing"] = _id_EB002DF09B83B915;

  foreach(number in _id_EB002DF09B83B915)
  _id_2B32D871F51C34F1.code["number_part"][_id_2B32D871F51C34F1.code["number_part"].size] = "top" + number;

  foreach(number in _id_EB002DF09B83B915)
  _id_2B32D871F51C34F1.code["number_part"][_id_2B32D871F51C34F1.code["number_part"].size] = "bottom" + number;

  _id_2B32D871F51C34F1.code["array"] = _id_2350E7D1796E79C8(_id_2B32D871F51C34F1.code);

  foreach(num in _id_2B32D871F51C34F1.code["array"]) {
    _id_E30EE4AE67D05D90 = "" + num;
    _id_2B32D871F51C34F1.code["string"] = _id_2B32D871F51C34F1.code["string"] + _id_E30EE4AE67D05D90;
  }

  _id_2B32D871F51C34F1.successfunction = ::_id_9FDADB62B1BDF018;
}

_id_2350E7D1796E79C8(_id_EB002DF09B83B915) {
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86 = [];
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["top2"] = 1;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["bottom2"] = 2;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["top3"] = 3;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["bottom3"] = 4;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["top4"] = 5;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["bottom4"] = 6;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["top5"] = 7;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["bottom5"] = 8;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["top7"] = 9;
  level._id_BA18E950012E7D13._id_544A7DBC681BBE86["bottom7"] = 0;
  _id_36BDB0FE15A777B1 = [];

  foreach(key in _id_EB002DF09B83B915["number_part"])
  _id_36BDB0FE15A777B1[_id_36BDB0FE15A777B1.size] = level._id_BA18E950012E7D13._id_544A7DBC681BBE86[key];

  return _id_36BDB0FE15A777B1;
}

_id_9FDCE6FD13B04C1C() {
  _id_2B32D871F51C34F1 = level._id_BA18E950012E7D13.hints["escaperoom_terminal_keypad"].scriptable;
  level._id_BA18E950012E7D13.pattern = [];
  level._id_BA18E950012E7D13._id_E9B051B4A987405F = [];
  _id_EE317DC6506CDE30 = scripts\engine\utility::array_randomize(getarraykeys(level._id_BA18E950012E7D13._id_66647DAB4AD2648B));

  foreach(number in _id_2B32D871F51C34F1.code["player_facing"]) {
    level._id_BA18E950012E7D13.pattern[level._id_BA18E950012E7D13.pattern.size] = _id_EE317DC6506CDE30[0];
    _id_0882C98CB9757BCC = scripts\engine\utility::ter_op(number - 3 < 1, 1, number - 3);
    _id_FB7961C7E608EDAE = scripts\engine\utility::ter_op(number + 3 > 10, 10, number + 3);
    _id_0650142A1B7F8CA7 = randomintrange(_id_0882C98CB9757BCC, _id_FB7961C7E608EDAE);
    level._id_BA18E950012E7D13._id_E9B051B4A987405F[_id_EE317DC6506CDE30[0]] = "num" + _id_0650142A1B7F8CA7;
    offset = number - _id_0650142A1B7F8CA7;

    if(offset < 0)
      level._id_BA18E950012E7D13.pattern[level._id_BA18E950012E7D13.pattern.size] = "minus" + int(abs(offset));
    else if(offset > 0)
      level._id_BA18E950012E7D13.pattern[level._id_BA18E950012E7D13.pattern.size] = "add" + offset;

    level._id_BA18E950012E7D13.pattern[level._id_BA18E950012E7D13.pattern.size] = "stop";
    _id_EE317DC6506CDE30 = scripts\engine\utility::array_remove(_id_EE317DC6506CDE30, _id_EE317DC6506CDE30[0]);
  }
}

_id_BE4056EFFAD83342() {
  level endon("game_ended");
  level endon("endParliamentGasDamageTick");

  for(;;) {
    damagetick = 9;

    foreach(player in level._id_BA18E950012E7D13._id_3E9FEDFEA8104A09) {
      if(!isDefined(player) || !isDefined(player.origin) || !isalive(player)) {
        level._id_BA18E950012E7D13._id_3E9FEDFEA8104A09 = scripts\engine\utility::array_remove(level._id_BA18E950012E7D13._id_3E9FEDFEA8104A09, player);
        continue;
      }

      if(scripts\cp_mp\gasmask::hasgasmask(player)) {
        player _id_7E52B56769FA7774::_id_00CDF7F2F6BD3207("parliament_puzzle");
        player scripts\cp_mp\gasmask::processdamage(damagetick);
        continue;
      }

      if(isDefined(level.modifybrgasdamage))
        damagetick = player[[level.modifybrgasdamage]](damagetick);

      if(player scripts\mp\utility\killstreak::isjuggernaut())
        damagetick = _id_29C32B7117E01180::modifybrgasdamage(damagetick);

      player dodamage(damagetick, player.origin, player, undefined, "MOD_TRIGGER_HURT", "danger_circle_br");
      player _id_07C40FA80892A721::damagearmor(damagetick);
      player _id_2695A20D4011076D::tryplaycoughaudio();
    }

    wait 1;
  }
}

showdebugresult(_id_1B0D855F76756D57) {
  for(_id_018DA35A53F30FFD = 0; _id_018DA35A53F30FFD < 5; _id_018DA35A53F30FFD = _id_018DA35A53F30FFD + 0.05)
    waitframe();
}

debug_printcode(_id_48B11326257052F1) {
  level notify("endStadiumCodeDebugPrint");
  level endon("endStadiumCodeDebugPrint");
  _id_DD1003EA8B91BB85 = 10;

  for(;;) {
    if(!scripts\mp\flags::gameflag("prematch_done")) {} else {
      foreach(_id_AC0E594AC96AA3A8, number in _id_48B11326257052F1.code["array"]) {}
    }

    waitframe();
  }
}

debug_spawnrewardstest() {
  angles = (0, 0, 0);
  origin = (1563, -3289, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_killstreak_auav");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_auav", _id_CB4FAD49263E20C4, count, 0);
  origin = (1563, -3402, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_specialist_bonus");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_specialist_bonus", _id_CB4FAD49263E20C4, 1, 0);
  origin = (1563, -3533, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_offhand_advancedsupplydrop");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_offhand_advancedsupplydrop", _id_CB4FAD49263E20C4, 1, 0);
  origin = (1563, -3650, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_equip_gasmask_durable");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_equip_gasmask_durable", _id_CB4FAD49263E20C4, 1, 0);
  origin = (1690, -3289, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_weapon_lm_dblmg_lege");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_weapon_lm_dblmg_lege", _id_CB4FAD49263E20C4, 1, 0);
  origin = (1690, -3402, 300);
  count = _id_7D625073C6379D53::getitemcount("brloot_killstreak_juggernaut");
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(origin, angles);
  scriptable = _id_7E52B56769FA7774::spawnpickup("brloot_killstreak_juggernaut", _id_CB4FAD49263E20C4, 1, 0);
}

computer_debugtestloop(scriptable) {
  for(;;) {
    scriptable setscriptablepartstate("parliament_code_computer", "intro");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "blackhouse");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "blank");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "daryl");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "holmes");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "horse");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "jolyon");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "tinyhouse");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "whitehouse");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "keypad");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "overauthorized");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "add1");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "add2");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "add3");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "minus1");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "minus2");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "minus3");
    wait 1;
    scriptable setscriptablepartstate("parliament_code_computer", "stop");
    wait 1;
  }
}

debug_show2dvotext(text, time) {
  if(!1) {
    return;
  }
  for(_id_6B7BEE46F2C6DA28 = 0; _id_6B7BEE46F2C6DA28 < time; _id_6B7BEE46F2C6DA28 = _id_6B7BEE46F2C6DA28 + 0.05)
    waitframe();
}

_id_ECF6F13AB4EDF73E() {
  foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B["holmes"]) {
    loc.scriptable = spawnscriptable("parliament_placard", loc.origin, loc.angles + (0, 180, 0));
    loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
  }

  foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B["whitehouse"]) {
    loc.scriptable = spawnscriptable("parliament_placard", loc.origin, loc.angles + (0, 180, 0));
    loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
  }

  foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B["blackhouse"]) {
    loc.scriptable = spawnscriptable("parliament_placard", loc.origin, loc.angles + (0, 180, 0));
    loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
  }

  foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B["daryl"]) {
    loc.scriptable = spawnscriptable("parliament_placard", loc.origin, loc.angles);
    loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
  }

  foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B["horse"]) {
    loc.scriptable = spawnscriptable("parliament_placard", loc.origin, loc.angles + (0, 180, 0));
    loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
  }

  foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B["tinyhouse"]) {
    loc.scriptable = spawnscriptable("parliament_placard", loc.origin, loc.angles + (0, 180, 0));
    loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
  }

  foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B["jolyon"]) {
    loc.scriptable = spawnscriptable("parliament_placard", loc.origin, loc.angles + (0, 180, 0));
    loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
  }

  foreach(loc in level._id_BA18E950012E7D13._id_66647DAB4AD2648B["blank"]) {
    loc.scriptable = spawnscriptable("parliament_placard", loc.origin, (360, 359.999, -8.79989));
    loc.scriptable setscriptablepartstate("parliament_placard", "num" + randomintrange(1, 10));
  }
}