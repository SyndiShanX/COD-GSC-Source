/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2225.gsc
*************************************************/

main() {
  if(isDefined(level._id_0408)) {
    return;
  }
  init();

  if(scripts\common\utility::issp()) {
    level.player thread _id_FBCF();
    level thread _id_9A2C();
    level thread _id_EFA3();
    level thread _id_7BC7();

    if(getdvarint("#x31360de7767011290")) {
      _id_E7E9();
    }
  } else
    level thread _id_EFA3();
}

init() {
  scripts\engine\utility::_id_5C1B("stealth_enabled");
  level._id_0408 = spawnStruct();
  level._id_0408._id_4892 = spawnStruct();
  level._id_0408._id_CB31 = spawnStruct();
  level._id_0408._id_0031 = [];
  level._id_0408._id_6035 = [];
  level._id_0408._id_4892._id_E747 = "hidden";
  level._id_0408._id_4892._id_C01B = [];
  level._id_0408._id_4892._id_C01B["hidden"] = [];
  level._id_0408._id_4892._id_C01B["spotted"] = [];
  level._id_0408._id_4892._id_9F37["hidden"] = [];
  level._id_0408._id_4892._id_9F37["spotted"] = [];
  level._id_0408._id_4892._id_F224 = 5;
  _id_08AA::_id_3D7E();
  _id_08AD::_id_56A3();
  level._id_0408._id_A482 = 3000;
  level._id_0408._id_75E5 = 8;
  level._id_0408._id_71F4 = spawnStruct();
  level._id_0408._id_71F4._id_01C4 = [];
  level._id_0408._id_71F4._id_722F = [];
  level._id_0408._id_71F4._id_160C = [];
  level._id_0408._id_71F4._id_43AA = [];
  level._id_0408._id_7BDC = [];
  _id_D1BA();
  _id_80C7();
  _id_08A9::_id_7FBC();
  _id_809C();
  _id_08B5::_id_1432();
  level._id_0408._id_9E97 = 1;
  _id_D828();
}

_id_D828() {
  level _id_08B5::_id_D3C4("do_stealth", _id_08B5::_id_4C28);
  _id_08AC::_id_D1C0();
  level._id_0408._id_5D93 = _id_08B5::_id_721C;
  level._id_0408._id_5D96 = undefined;
  level._id_0408._id_5DBC = _id_08B5::_id_D1DD;
}

_id_D1BA() {
  var_0 = [];
  var_0["prone"] = 400;
  var_0["crouch"] = 800;
  var_0["stand"] = 1500;
  var_1 = [];
  var_1["prone"] = 800;
  var_1["crouch"] = 1500;
  var_1["stand"] = 3000;
  _id_08B5::_id_D1CD(var_0, var_1);
  var_2 = [];
  var_2["prone"] = 130;
  var_2["crouch"] = 215;
  var_2["stand"] = 300;
  var_3 = [];
  var_3["prone"] = 300;
  var_3["crouch"] = 375;
  var_3["stand"] = 450;
  _id_08B5::_id_D290(var_2, var_3);
  _id_08AA::_id_D19B();
  _id_7F78();
  _id_08B5::_id_D1DC(0);
  _id_5692("hidden");
}

_id_7F78() {
  level._id_0408.ai_busyevent_map = [];
  level._id_0408.ai_busyevent_map["#x35998ba8dd580bdc7"] = "#x3ed1654136a244458";
  level._id_0408.ai_busyevent_map["#x373a9875920e67a02"] = "#x3db48583f9d3da2f9";
  level._id_0408.ai_busyevent_map["#x3f9f87892596f8c5b"] = "#x3b210bedc140ecbfc";
  level._id_0408.ai_busyevent_map["#x3bf45bb1a5c2c039b"] = "#x31547dae7ffd52578";
  level._id_0408.ai_busyevent_map["#x3d0d4d1b1c5b701b1"] = "#x3dd627f9af5ecf06";
  level._id_0408.ai_busyevent_map["#x3e3aea368d0f05a41"] = "#x3692b0d605afe3348";
  level._id_0408.ai_busyevent_map["#x3880bc12d25f7a444"] = "#x3a49f956a9aee908d";
  level._id_0408.ai_busyevent_map["#x37929a001710dc835"] = "#x31db43df8bcbe5318";
  level._id_0408.ai_busyevent_map["#x33c210edd023e28ea"] = "#x34d86d264134dea95";
  level._id_0408.ai_busyevent_map["#x3ef635512ff6ce39"] = "#x347460d918887c2e8";
  level._id_0408.ai_busyevent_map["#x32c98ebd0b6c9b1e8"] = "#x33a7acbdb5242551";
  level._id_0408.ai_busyevent_map["#x34972b4db59cdf484"] = "#x34549bed3f0b7b0cb";
  level._id_0408.ai_busyevent_map["#x34c7ff02ee4f244a5"] = "#x311b3b021ff8c7876";
  level._id_0408.ai_busyevent_map["#x37306782a1d3aeb48"] = "#x31676e9dbfeb4f943";
  level._id_0408.ai_busyevent_map["#x3f96721fa8caf2ad7"] = "#x320cfeb542a456e34";
  level._id_0408.ai_busyevent_map["#x3199f59ce6c2f7fe6"] = "#x357f7d5771719dc21";
  var_0["#x3e3aea368d0f05a41"]["spotted"] = getdvarint("#x3e3aea368d0f05a41");
  var_0["#x3e3aea368d0f05a41"]["hidden"] = 512;
  var_0["#x3d0d4d1b1c5b701b1"]["spotted"] = getdvarint("#x3d0d4d1b1c5b701b1");
  var_0["#x3d0d4d1b1c5b701b1"]["hidden"] = 256;
  var_0["#x3880bc12d25f7a444"]["spotted"] = getdvarint("#x3880bc12d25f7a444");
  var_0["#x3880bc12d25f7a444"]["hidden"] = 2048;
  var_0["#x34c7ff02ee4f244a5"]["spotted"] = getdvarint("#x34c7ff02ee4f244a5");
  var_0["#x34c7ff02ee4f244a5"]["hidden"] = 64;
  var_0["#x373a9875920e67a02"]["spotted"] = getdvarint("#x373a9875920e67a02");
  var_0["#x373a9875920e67a02"]["hidden"] = 50;
  var_0["#x35998ba8dd580bdc7"]["spotted"] = getdvarint("#x35998ba8dd580bdc7");
  var_0["#x35998ba8dd580bdc7"]["hidden"] = 100;
  var_0["#x3f9f87892596f8c5b"]["spotted"] = getdvarint("#x3f9f87892596f8c5b");
  var_0["#x3f9f87892596f8c5b"]["hidden"] = 400;
  var_0["#x3ef635512ff6ce39"]["spotted"] = getdvarint("#x3ef635512ff6ce39");
  var_0["#x3ef635512ff6ce39"]["hidden"] = 1500;
  var_0["#x34972b4db59cdf484"]["spotted"] = getdvarint("#x34972b4db59cdf484");
  var_0["#x34972b4db59cdf484"]["hidden"] = 180;
  var_0["#x3199f59ce6c2f7fe6"]["spotted"] = getdvarint("#x3199f59ce6c2f7fe6");
  var_0["#x3199f59ce6c2f7fe6"]["hidden"] = 384;

  if(getdvarint("#x31811843c5bb7ca71", 0)) {
    var_0["#x32c98ebd0b6c9b1e8"]["spotted"] = 256;
    var_0["#x32c98ebd0b6c9b1e8"]["hidden"] = 256;
  } else {
    var_0["#x32c98ebd0b6c9b1e8"]["spotted"] = getdvarint("#x32c98ebd0b6c9b1e8");
    var_0["#x32c98ebd0b6c9b1e8"]["hidden"] = 750;
  }

  var_0["#x3bf45bb1a5c2c039b"]["spotted"] = 128;
  var_0["#x3bf45bb1a5c2c039b"]["hidden"] = 128;
  _id_D1F2(var_0);
}

_id_D1F2(var_0) {
  foreach(var_6, var_2 in var_0) {
    foreach(var_5, var_4 in var_2) {
      level._id_0408._id_0031[var_6][var_5] = var_4;
    }
  }
}

_id_D1AA(var_0) {
  foreach(var_7, var_2 in var_0) {
    foreach(var_6, var_4 in var_2) {
      level._id_0408._id_0031[var_7][var_6] = var_4;

      if(level._id_0408._id_4892._id_E747 == var_6) {
        setsaveddvar(var_7, var_4);
        var_5 = level._id_0408.ai_busyevent_map[var_7];
        setsaveddvar(var_5, var_4);
      }
    }
  }
}

_id_D1CE(var_0, var_1) {
  var_2 = 0.25;

  if(isDefined(var_0)) {
    level._id_0408._id_4892._id_C01B["hidden"]["prone"] = var_0["prone"];
    level._id_0408._id_4892._id_C01B["hidden"]["crouch"] = var_0["crouch"];
    level._id_0408._id_4892._id_C01B["hidden"]["stand"] = var_0["stand"];

    if(!isDefined(var_0["shadow"])) {
      var_0["shadow"] = var_2;
    }

    level._id_0408._id_4892._id_C01B["hidden"]["shadow"] = var_0["shadow"];
  }

  if(isDefined(var_1)) {
    level._id_0408._id_4892._id_C01B["spotted"]["prone"] = var_1["prone"];
    level._id_0408._id_4892._id_C01B["spotted"]["crouch"] = var_1["crouch"];
    level._id_0408._id_4892._id_C01B["spotted"]["stand"] = var_1["stand"];

    if(!isDefined(var_1["shadow"])) {
      var_1["shadow"] = var_2;
    }

    level._id_0408._id_4892._id_C01B["spotted"]["shadow"] = var_1["shadow"];
  }
}

_id_9A2C() {
  for(;;) {
    scripts\engine\utility::_id_5C24("stealth_enabled");
    _id_08B4::_id_F14F(1);

    if(!_id_B712()) {
      setsaveddvar("#x336944afd3a2ab6f0", 1);
    }

    scripts\engine\utility::_id_5C24("stealth_spotted");

    if(!_id_B712()) {
      setsaveddvar("#x336944afd3a2ab6f0", 0);
    }

    if(!scripts\engine\utility::_id_5C00("stealth_enabled")) {
      continue;
    }
    _id_5692("spotted");
    scripts\engine\utility::_id_5C30("stealth_spotted");

    if(!scripts\engine\utility::_id_5C00("stealth_enabled")) {
      continue;
    }
    _id_5692("hidden");
    waittillframeend;
  }
}

_id_1915() {
  if(isDefined(level._id_0408._id_7225)) {
    foreach(var_1 in level._id_0408._id_7225._id_722F) {
      if(_id_08AF::_id_71F8(var_1.name)) {
        return 1;
      }
    }
  }

  var_3 = _func_0074("bad_guys", "all");

  foreach(var_5 in var_3) {
    if(!isDefined(var_5._id_0408) && isDefined(var_5._id_0192) && var_5._id_0192 == self) {
      return 1;
    }
  }

  return 0;
}

_id_FBCF() {
  waitframe();
  var_0 = 0;

  for(;;) {
    var_1 = _id_1915();

    if(var_1) {
      if(!var_0 && isDefined(level._id_0408._id_E7E7)) {
        wait(level._id_0408._id_E7E7);

        if(!_id_1915()) {
          waitframe();
          continue;
        }
      }

      if(!scripts\engine\utility::_id_5C00("stealth_spotted")) {
        scripts\engine\utility::_id_5C1B("stealth_spotted");

        if(isDefined(self._id_0408)) {
          var_2 = _id_08B5::_id_64D2("stealth_spotted");
          scripts\engine\utility::_id_5C1B(var_2);
        }
      }
    } else if(scripts\engine\utility::_id_5C00("stealth_spotted")) {
      scripts\engine\utility::_id_5C04("stealth_spotted");

      if(isDefined(self._id_0408)) {
        var_2 = _id_08B5::_id_64D2("stealth_spotted");
        scripts\engine\utility::_id_5C04(var_2);
      }
    }

    var_0 = var_1;
    waitframe();
  }
}

_id_EFA3() {
  level._id_0408._id_535F["axis"] = [];
  level._id_0408._id_535F["allies"] = [];

  for(;;) {
    scripts\engine\utility::_id_5C24("stealth_enabled");
    level._id_0408._id_535F["axis"] = level.players;
    level._id_0408._id_535F["allies"] = _func_0070("axis");
    wait 0.05;
  }
}

_id_7BC7() {
  for(;;) {
    scripts\engine\utility::_id_5C24("stealth_enabled");

    if(isDefined(level._id_0408._id_7BC5) && level._id_0408._id_7BC5.size != 0) {
      foreach(var_2, var_1 in level._id_0408._id_7BC5) {
        _id_08A9::_id_7BCD(var_2, var_1);
        wait 0.2;
      }

      continue;
    }

    wait 0.5;
  }
}

_id_5692(var_0) {
  level._id_0408._id_4892._id_E747 = var_0;

  foreach(var_4, var_2 in level._id_0408._id_0031) {
    setsaveddvar(var_4, var_2[var_0]);
    var_3 = level._id_0408.ai_busyevent_map[var_4];
    setsaveddvar(var_3, var_2[var_0]);
  }
}

_id_809C() {
  scripts\engine\utility::_id_5C11("stealth_player_nade");
  level._id_0408._id_CB31._id_B556 = 0;
  scripts\engine\utility::_id_1BE2(level.players, ::_id_B4BD);
}

_id_B4BD() {
  for(;;) {
    self waittill("grenade_pullback");
    scripts\engine\utility::_id_5C1B("stealth_player_nade");
    self waittill("grenade_fire", var_0);
    thread _id_B4BE(var_0);
  }
}

_id_B4BE(var_0) {
  level._id_0408._id_CB31._id_B556++;
  var_0 scripts\engine\utility::_id_108F5("death", 10);
  level._id_0408._id_CB31._id_B556--;
  waittillframeend;

  if(!level._id_0408._id_CB31._id_B556) {
    scripts\engine\utility::_id_5C04("stealth_player_nade");
  }
}

_id_E7E9() {
  if(istrue(level._id_D9DE)) {
    return;
  }
  if(isDefined(level._id_0408)) {
    if(!isDefined(level._id_0408._id_EBEA)) {
      level._id_0408._id_EBEA = spawnStruct();
      level._id_0408._id_EBEA._id_4E4C = [];
      level._id_0408._id_EBEA._id_C5F4 = 30;
      level._id_0408._id_EBEA._id_DD32 = _func_0219(600);
      level._id_0408._id_EBEA._id_4894 = _func_0219(500);
      level._id_0408._id_EBEA._id_5F10 = _func_0219(300);
    }

    level _id_08B5::_id_D3C4("suspicious_door", _id_08AA::_id_EBEB);
    level _id_08AD::_id_56AC("investigate", "suspicious_door", 20);
  }
}

_id_80C7() {
  level._id_0408._id_3AAA = [];
  level._id_0408._id_7BCA = [];
  level._id_0408._id_851E = [];
  var_0 = getEntArray("info_volume_stealth_all", "classname");
  var_1 = getEntArray("info_volume_stealth_combat", "classname");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3._id_CE6E, " ");

      foreach(var_6 in var_4) {
        level._id_0408._id_3AAA[var_6] = var_3;
      }
    }
  }

  var_1 = getEntArray("info_volume_stealth_hunt", "classname");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3._id_CE6E, " ");

      foreach(var_6 in var_4) {
        level._id_0408._id_7BCA[var_6] = var_3;
      }
    }
  }

  var_1 = getEntArray("info_volume_stealth_investigate", "classname");
  var_1 = scripts\engine\utility::array_combine(var_1, var_0);

  if(isDefined(var_1)) {
    foreach(var_3 in var_1) {
      var_4 = strtok(var_3._id_CE6E, " ");

      foreach(var_6 in var_4) {
        level._id_0408._id_851E[var_6] = var_3;
      }
    }
  }
}

_id_B712() {
  if(isDefined(level._id_0408) && isDefined(level._id_0408._id_5DB1)) {
    return [[level._id_0408._id_5DB1]]();
  }

  return 0;
}