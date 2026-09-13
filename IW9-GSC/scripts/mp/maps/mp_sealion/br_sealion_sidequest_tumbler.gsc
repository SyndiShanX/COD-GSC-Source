/***********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_sealion\br_sealion_sidequest_tumbler.gsc
***********************************************************************/

main() {
  level thread _id_DEEE3B97BF9C0945();
}

_id_DEEE3B97BF9C0945() {
  if(!getdvarint("dvar_76DA247EEC8572DA", 0)) {
    return;
  }
  waitframe();

  if(!scripts\cp_mp\utility\game_utility::_id_E21746ABAAAF8414()) {
    return;
  }
  level thread init();
}

init() {
  _id_3A28A49B6680A7A4((2964, -2706, 718), (0, 0, 0));
  _id_3A28A49B6680A7A4((2632, -2706, 718), (0, 0, 0));
  _id_3A28A49B6680A7A4((2796, -2474, 718), (0, 180, 0));
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("electrical_box", ::_id_A433229E4D68E79E);
  level thread _id_0145448C505DEFF0();
}

_id_3A28A49B6680A7A4(_id_254F9C6C23AD6894, _id_D07056AD0C95B812) {
  _id_B038ED928EC17A81 = spawnscriptable("br_loot_cache_lege", _id_254F9C6C23AD6894, _id_D07056AD0C95B812);
  _id_B038ED928EC17A81 setscriptablepartstate("body", "closed_usable");
}

_id_0145448C505DEFF0() {
  level._id_D7A96E0A1FEF37F9 = [];

  switch (level.mapname) {
    case "mp_sealion":
      _id_8397B7CBF34866F1();
      break;
    case "mp_br_hms_mechanics":
      break;
    default:
      return;
  }

  waitframe();

  foreach(door in getentitylessscriptablearray("power_switch_door", "targetname"))
  door scriptabledoorfreeze();

  _id_60B7A9E45CD7C79D();
  _id_2F7C743FB67157D2();
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  _id_F5BB3D2370981428();
}

_id_8397B7CBF34866F1() {
  level._id_D7A96E0A1FEF37F9 = getentitylessscriptablearray("scriptable_electrical_box", "classname");
  level._id_6F33C24C1A5B5C76 = spawnscriptable("sealion_sidequest_tumbler_light", (2797.5, -2086, 872.5));
}

_id_60B7A9E45CD7C79D() {
  level._id_D7A96E0A1FEF37F9 = scripts\engine\utility::array_randomize(level._id_D7A96E0A1FEF37F9);
  _id_A98D17FF717B9380 = level._id_D7A96E0A1FEF37F9;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D7A96E0A1FEF37F9.size; _id_AC0E594AC96AA3A8++) {
    level._id_D7A96E0A1FEF37F9[_id_AC0E594AC96AA3A8]._id_A98D17FF717B9380 = _id_A98D17FF717B9380;
    _id_A98D17FF717B9380 = scripts\engine\utility::array_remove(_id_A98D17FF717B9380, level._id_D7A96E0A1FEF37F9[_id_AC0E594AC96AA3A8]);
  }

  waitframe();

  foreach(scriptable in level._id_D7A96E0A1FEF37F9)
  scriptable setscriptablepartstate("electrical_box", "on");

  waitframe();

  foreach(scriptable in level._id_D7A96E0A1FEF37F9) {
    foreach(_id_4E333F60B3B1F754 in scriptable._id_A98D17FF717B9380)
    _id_4E333F60B3B1F754 thread _id_DF6F05E4FAD5FFC1();

    waitframe();
  }

  if(getdvarint("dvar_C754BED592FE1223", 0)) {
    _id_337BE55E5DBA8832 = randomint(level._id_D7A96E0A1FEF37F9.size);

    if(_id_337BE55E5DBA8832) {
      foreach(scriptable in level._id_D7A96E0A1FEF37F9) {
        if(scriptable._id_A98D17FF717B9380.size == _id_337BE55E5DBA8832) {
          foreach(_id_4E333F60B3B1F754 in scriptable._id_A98D17FF717B9380)
          _id_4E333F60B3B1F754 thread _id_DF6F05E4FAD5FFC1();
        }
      }
    }

    _id_6FB50BDA7202DC23();
  }

  _id_18D291DEDF03BE59();
}

_id_18D291DEDF03BE59() {
  level._id_0EB982E08BC6C700 = [];

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D7A96E0A1FEF37F9.size; _id_AC0E594AC96AA3A8++)
    level._id_0EB982E08BC6C700[level._id_0EB982E08BC6C700.size] = level._id_D7A96E0A1FEF37F9[_id_AC0E594AC96AA3A8] getscriptablepartstate("electrical_box");
}

_id_2F7C743FB67157D2() {
  foreach(scriptable in level._id_D7A96E0A1FEF37F9)
  scriptable setscriptablepartstate("electrical_box", "on");
}

_id_F5BB3D2370981428() {
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D7A96E0A1FEF37F9.size; _id_AC0E594AC96AA3A8++)
    level._id_D7A96E0A1FEF37F9[_id_AC0E594AC96AA3A8] setscriptablepartstate("electrical_box", level._id_0EB982E08BC6C700[_id_AC0E594AC96AA3A8]);
}

_id_6FB50BDA7202DC23() {
  foreach(scriptable in level._id_D7A96E0A1FEF37F9) {
    if(scriptable._id_A98D17FF717B9380.size == 1) {
      scriptable._id_DD4626ECAFED6572 = [];

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D7A96E0A1FEF37F9.size; _id_AC0E594AC96AA3A8++)
        scriptable._id_DD4626ECAFED6572[scriptable._id_DD4626ECAFED6572.size] = level._id_D7A96E0A1FEF37F9[_id_AC0E594AC96AA3A8] getscriptablepartstate("electrical_box");

      break;
    }
  }
}

_id_A433229E4D68E79E(scriptable, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(scriptable._id_DD4626ECAFED6572)) {
    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < level._id_D7A96E0A1FEF37F9.size; _id_AC0E594AC96AA3A8++) {
      if(level._id_D7A96E0A1FEF37F9[_id_AC0E594AC96AA3A8] == scriptable) {
        scriptable thread _id_DF6F05E4FAD5FFC1();
        continue;
      }

      level._id_D7A96E0A1FEF37F9[_id_AC0E594AC96AA3A8] setscriptablepartstate("electrical_box", scriptable._id_DD4626ECAFED6572[_id_AC0E594AC96AA3A8]);
    }

    scriptable thread _id_1A5EAE1BF070AF71();
    return;
  }

  foreach(_id_4E333F60B3B1F754 in scriptable._id_A98D17FF717B9380)
  _id_4E333F60B3B1F754 thread _id_DF6F05E4FAD5FFC1();

  if(scripts\mp\flags::gameflag("prematch_fade_done") && _id_5FC48BE49EBB2952())
    scripts\engine\utility::delaythread(0.55, ::_id_4FD0ACC9359046CB, player);
}

_id_1A5EAE1BF070AF71() {
  self setscriptablepartstate("electrical_sparks", "on");
  wait 1;
  self setscriptablepartstate("electrical_sparks", "off");
}

_id_DF6F05E4FAD5FFC1() {
  if(self getscriptablepartstate("electrical_box") == "on") {
    self setscriptablepartstate("electrical_box", "off");
    wait 0.5;
    self setscriptablepartstate("switch_sfx", "sfx_switch_off");
  } else {
    self setscriptablepartstate("electrical_box", "on");
    wait 0.5;
    self setscriptablepartstate("switch_sfx", "sfx_switch_on");
  }
}

_id_5FC48BE49EBB2952() {
  foreach(scriptable in level._id_D7A96E0A1FEF37F9) {
    if(scriptable getscriptablepartstate("electrical_box") == "off")
      return 0;
  }

  return 1;
}

_id_4FD0ACC9359046CB(player) {
  level endon("game_ended");
  sfx = spawnscriptable("electrical_box_puzzle_success_sfx", (2798, -2024, 870));

  foreach(scriptable in level._id_D7A96E0A1FEF37F9)
  scriptable setscriptablepartstate("electrical_box", "success");

  level._id_6F33C24C1A5B5C76 setscriptablepartstate("tumbler_light", "tumbler_light_green");

  foreach(door in getentitylessscriptablearray("power_switch_door", "targetname"))
  door scriptabledooropen("away", (2800, -2000, 0));

  game["dialog"]["pwrs_wzan_swco"] = "pwrs_wzan_swco";
  level thread _id_05C607EF7F46F361::_id_4E9ADC9D9FEB74EA("pwrs_wzan_swco", player, 1, 0, 2.5);

  foreach(_id_AC0E424AC96A7113 in scripts\mp\utility\teams::getteamdata(player.team, "players"))
  _id_AC0E424AC96A7113 scripts\mp\utility\points::_id_0366980B6A8796AE("stat_434762AEEA8BA08C");

  wait 10;
  sfx freescriptable();
}