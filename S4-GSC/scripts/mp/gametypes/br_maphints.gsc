/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_maphints.gsc
*************************************************/

init() {
  if(getdvarint("#x3df6d5477030acbcd", 1) == 0) {
    return;
  }
  level._id_9ABB = [];

  if(level.mapname == "mp_br_mechanics") {
    _id_8217();
  } else {
    _id_8214();
    _id_8215();
    _id_8213();
  }

  _id_07A1::_id_CECC("maphint_keypad", ::_id_9AB9);
  _id_07A1::_id_CECC("maphint_phone", ::_id_9ABA);
  _id_07A1::_id_CECC("maphint_computer", ::_id_9AB7);

  if(0) {
    level thread _id_9AB8();
  }

  level thread onplayerconnect();
  level thread _id_80A8();
}

_id_8214() {
  level._id_9ABB["keypads"] = [];
  level._id_9ABB["keypads"][0] = spawnStruct();
  level._id_9ABB["keypads"][0].origin = (-17261, -44265, 40);
  level._id_9ABB["keypads"][1] = spawnStruct();
  level._id_9ABB["keypads"][1].origin = (-37520, -19013, 237);
  level._id_9ABB["keypads"][2] = spawnStruct();
  level._id_9ABB["keypads"][2].origin = (-39523, -2395, 30);
  level._id_9ABB["keypads"][3] = spawnStruct();
  level._id_9ABB["keypads"][3].origin = (-38640, -1902, -103);
  level._id_9ABB["keypads"][4] = spawnStruct();
  level._id_9ABB["keypads"][4].origin = (-15513, 43307, 105);
  level._id_9ABB["keypads"][5] = spawnStruct();
  level._id_9ABB["keypads"][5].origin = (2495, 41096, 1670);
  level._id_9ABB["keypads"][6] = spawnStruct();
  level._id_9ABB["keypads"][6].origin = (47600, 34582, 500);
  level._id_9ABB["keypads"][7] = spawnStruct();
  level._id_9ABB["keypads"][7].origin = (18622, -34634, -478);
  level._id_9ABB["keypads"][8] = spawnStruct();
  level._id_9ABB["keypads"][8].origin = (54279, -33994, 173);
  level._id_9ABB["keypads"][9] = spawnStruct();
  level._id_9ABB["keypads"][9].origin = (36350, 13586, 26);
  level._id_9ABB["keypads"][10] = spawnStruct();
  level._id_9ABB["keypads"][10].origin = (37390, 13383, -117);

  foreach(var_2, var_1 in level._id_9ABB["keypads"]) {
    level._id_9ABB["keypads"][var_2]._id_03A9 = _func_03C5("maphint_keypad", var_1.origin);
  }
}

_id_8215() {
  level._id_9ABB["phones"] = [];
  level._id_9ABB["phones"][0] = spawnStruct();
  level._id_9ABB["phones"][0].origin = (15510, 18142, 193);
  level._id_9ABB["phones"][1] = spawnStruct();
  level._id_9ABB["phones"][1].origin = (-22115, 27122, 1170);
  level._id_9ABB["phones"][2] = spawnStruct();
  level._id_9ABB["phones"][2].origin = (-24445, 43755, -118);
  level._id_9ABB["phones"][3] = spawnStruct();
  level._id_9ABB["phones"][3].origin = (-25179, 45438, 155);
  level._id_9ABB["phones"][4] = spawnStruct();
  level._id_9ABB["phones"][4].origin = (14565, 36646, 1500);
  level._id_9ABB["phones"][5] = spawnStruct();
  level._id_9ABB["phones"][5].origin = (2448, 29023, 80);
  level._id_9ABB["phones"][6] = spawnStruct();
  level._id_9ABB["phones"][6].origin = (21075, -15890, 1690);
  level._id_9ABB["phones"][7] = spawnStruct();
  level._id_9ABB["phones"][7].origin = (19472, -21677, 28);
  level._id_9ABB["phones"][8] = spawnStruct();
  level._id_9ABB["phones"][8].origin = (-12202, -26944, 20);
  level._id_9ABB["phones"][9] = spawnStruct();
  level._id_9ABB["phones"][9].origin = (-28148, -18152, -165);
  level._id_9ABB["phones"][10] = spawnStruct();
  level._id_9ABB["phones"][10].origin = (-6430, 1817, -250);
  level._id_9ABB["phones"][11] = spawnStruct();
  level._id_9ABB["phones"][11].origin = (-16380, -19702, -257);
  level._id_9ABB["phones"][12] = spawnStruct();
  level._id_9ABB["phones"][12].origin = (45105, 16910, -312);

  foreach(var_2, var_1 in level._id_9ABB["phones"]) {
    level._id_9ABB["phones"][var_2]._id_03A9 = _func_03C5("maphint_phone", var_1.origin);
  }
}

_id_8213() {
  level._id_9ABB["computers"] = [];
  level._id_9ABB["computers"][0] = spawnStruct();
  level._id_9ABB["computers"][0].origin = (8490, -11874, -239);
  level._id_9ABB["computers"][1] = spawnStruct();
  level._id_9ABB["computers"][1].origin = (-14585, 7982, -175);
  level._id_9ABB["computers"][2] = spawnStruct();
  level._id_9ABB["computers"][2].origin = (-34140, 3815, -55);
  level._id_9ABB["computers"][3] = spawnStruct();
  level._id_9ABB["computers"][3].origin = (5358, 51419, 1080);
  level._id_9ABB["computers"][4] = spawnStruct();
  level._id_9ABB["computers"][4].origin = (51078, -39445, 1125);
  level._id_9ABB["computers"][5] = spawnStruct();
  level._id_9ABB["computers"][5].origin = (17796, -8300, 1349);
  level._id_9ABB["computers"][6] = spawnStruct();
  level._id_9ABB["computers"][6].origin = (37275, -26745, -472);

  foreach(var_2, var_1 in level._id_9ABB["computers"]) {
    level._id_9ABB["computers"][var_2]._id_03A9 = _func_03C5("maphint_computer", var_1.origin);
  }
}

_id_8216() {
  level._id_9ABB["radios"] = [];
  level._id_9ABB["radios"][0] = spawnStruct();
  level._id_9ABB["radios"][0].origin = (-21440, 19434, -252);
  level._id_9ABB["radios"][1] = spawnStruct();
  level._id_9ABB["radios"][1].origin = (2896, 45445, 1630);

  foreach(var_2, var_1 in level._id_9ABB["radios"]) {
    level._id_9ABB["radios"][var_2]._id_03A9 = _func_03C5("maphint_radio", var_1.origin);
  }
}

_id_9AB9(var_0, var_1, var_2, var_3, var_4, var_5) {
  level thread _id_0C5D(var_0, var_1, var_2, var_3, var_4);
}

_id_0C5D(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    playsoundatpos(var_3.origin, "br_keypad_deny");
    var_0 setscriptablepartstate("maphint_keypad", "off");
    wait 3;
    var_0 setscriptablepartstate("maphint_keypad", "on");
  }
}

_id_9ABA(var_0, var_1, var_2, var_3, var_4, var_5) {
  level thread _id_0C5E(var_0, var_1, var_2, var_3, var_4);
}

_id_0C5E(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    playsoundatpos(var_3.origin, "br_phone_deny");
    var_0 setscriptablepartstate("maphint_phone", "off");
    wait 3;
    var_0 setscriptablepartstate("maphint_phone", "on");
  }
}

_id_9AB7(var_0, var_1, var_2, var_3, var_4, var_5) {
  level thread _id_0C5C(var_0, var_1, var_2, var_3, var_4);
}

_id_0C5C(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    playsoundatpos(var_3.origin, "br_computer_deny");
    var_0 setscriptablepartstate("maphint_computer", "off");
    wait 3;
    var_0 setscriptablepartstate("maphint_computer", "on");
  }
}

_id_8217() {
  level._id_9ABB["keypads"] = [];
  level._id_9ABB["keypads"][0] = spawnStruct();
  level._id_9ABB["keypads"][0].origin = (-237, -2721, 60);

  foreach(var_1 in level._id_9ABB["keypads"]) {
    var_2 = _func_03C5("maphint_keypad", var_1.origin);
  }

  level._id_9ABB["phones"] = [];
  level._id_9ABB["phones"][0] = spawnStruct();
  level._id_9ABB["phones"][0].origin = (-21, -2721, 60);

  foreach(var_1 in level._id_9ABB["phones"]) {
    var_2 = _func_03C5("maphint_phone", var_1.origin);
  }

  level._id_9ABB["computers"] = [];
  level._id_9ABB["computers"][0] = spawnStruct();
  level._id_9ABB["computers"][0].origin = (100, -2721, 60);

  foreach(var_1 in level._id_9ABB["computers"]) {
    var_2 = _func_03C5("maphint_computer", var_1.origin);
  }
}

_id_9AB8() {
  for(;;) {
    if(getdvarint("#x3ad16fdfcfa612ea3", 0) == 1) {
      foreach(var_1 in level._id_9ABB["keypads"]) {
        var_1._id_03A9 _meth_86BE();
      }

      foreach(var_1 in level._id_9ABB["phones"]) {
        var_1._id_03A9 _meth_86BE();
      }

      foreach(var_1 in level._id_9ABB["computers"]) {
        var_1._id_03A9 _meth_86BE();
      }

      _id_8214();
      _id_8215();
      _id_8213();
    }

    wait 1;
  }
}

_id_80A8() {
  level._id_8321 = [];
  _id_07D1::_id_60C0("intel_challenges_setup_complete", 0);
  var_0 = getdvarint("#x3db39ef64f5cb194e", 0);
  var_1 = 0;

  for(;;) {
    var_2 = tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 0);

    if(!isDefined(var_2) || var_2 == "") {
      break;
    }

    var_3 = int(tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 2));
    var_4 = int(tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 1));

    if(var_4 > var_0 && getdvarint("#x339c6924828a3795a", 0) == 0) {
      var_1++;
      continue;
    }

    var_5 = tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 3);
    var_6 = tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 4);
    var_7 = float(tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 5));
    var_8 = float(tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 6));
    var_9 = float(tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 7));
    var_10 = (var_7, var_8, var_9);
    var_11 = float(tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 8));
    var_12 = float(tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 9));
    var_13 = float(tablelookupbyrow("mp/intel_challenges_season_3.csv", var_1, 10));
    var_14 = (var_11, var_12, var_13);
    var_15 = spawnStruct();
    var_15._id_C189 = var_2;
    var_15._id_7EAE = var_3;
    var_15._id_10DF3 = var_4;
    var_15._id_2092 = var_5;
    var_15._id_9FDC = var_6;
    var_15.origin = var_10;
    var_15.angles = var_14;
    level._id_8321[var_2] = var_15;
    var_1++;
  }

  foreach(var_19, var_17 in level._id_8321) {
    if(!var_17._id_7EAE) {
      continue;
    }
    var_18 = _func_03C5("intel", var_17.origin, var_17.angles);
    var_18._id_435A = var_19;
    var_17._id_82FC = var_18;
  }

  wait 1.0;

  foreach(var_19, var_17 in level._id_8321) {
    if(!var_17._id_7EAE) {
      continue;
    }
    var_18 = level._id_8321[var_19]._id_82FC;
    var_18 setscriptablepartstate("model", var_17._id_9FDC);
  }

  _id_07A1::_id_CECB(::_id_8323);
  _id_07D1::_id_60C1("intel_challenges_setup_complete");
}

_id_DCBC(var_0, var_1) {
  level._id_8321[var_1]._id_82FC _meth_86A7(var_0);
}

_id_7906(var_0, var_1) {
  level._id_8321[var_1]._id_82FC _meth_86A8(var_0);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    var_0._id_0F48 = [];

    if(getdvarint("#x339c6924828a3795a", 0) == 1) {
      var_1 = [];

      foreach(var_4, var_3 in level._id_8321) {
        if(!var_3._id_7EAE) {
          continue;
        }
        var_1[var_1.size] = var_4;
      }

      var_0._id_0F48 = var_1;
    } else {
      var_5 = 3001;

      foreach(var_4, var_3 in level._id_8321) {
        if(var_3._id_10DF3 == var_5) {
          continue;
        }
        var_7 = var_0 getplayerdata(level.progressiongroup, "missionComplete", var_4);

        if(!var_7) {
          var_5++;
          var_0._id_0F48[var_0._id_0F48.size] = var_4;
        }
      }
    }

    var_0 thread _id_1D1D();
  }
}

_id_1D1D() {
  self endon("disconnect");
  _id_07D1::_id_60C2("intel_challenges_setup_complete");

  foreach(var_2, var_1 in level._id_8321) {
    if(!var_1._id_7EAE) {
      continue;
    }
    if(scripts\engine\utility::array_contains(self._id_0F48, var_2)) {
      _id_DCBC(self, var_2);
      continue;
    }

    _id_7906(self, var_2);
  }
}

_id_8323(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(isDefined(var_0) && isDefined(var_0.type) && var_0.type == "intel") {
    _id_7906(var_3, var_0._id_435A);
    var_3 reportchallengeuserevent_iw8("collect_item", level._id_8321[var_0._id_435A]._id_2092);
  }
}