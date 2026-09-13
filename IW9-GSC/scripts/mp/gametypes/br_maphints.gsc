/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_maphints.gsc
************************************************/

init() {
  if(getdvarint("dvar_5420F6CDC8C693D3", 1) == 0) {
    return;
  }
  level.maphints = [];
  level.maphints["keypads"] = [];
  level.maphints["phones"] = [];
  level.maphints["computers"] = [];
  level thread onplayerconnect();
  level thread init_season3_intel_challenges();

  if(scripts\cp_mp\utility\game_utility::getmapname() == "mp_br_mechanics")
    initlocs_test();
  else
    initlocs_computer();

  scripts\engine\scriptable::scriptable_addusedcallbackbypart("maphint_computer", ::maphint_computerscriptableused);

  if(0)
    level thread maphint_debugthink();
}

initlocs_keypads() {
  level.maphints["keypads"] = [];
  level.maphints["keypads"][0] = spawnStruct();
  level.maphints["keypads"][0].origin = (-17261, -44265, 40);
  level.maphints["keypads"][1] = spawnStruct();
  level.maphints["keypads"][1].origin = (-37520, -19013, 237);
  level.maphints["keypads"][2] = spawnStruct();
  level.maphints["keypads"][2].origin = (-39523, -2395, 30);
  level.maphints["keypads"][3] = spawnStruct();
  level.maphints["keypads"][3].origin = (-38640, -1902, -103);
  level.maphints["keypads"][4] = spawnStruct();
  level.maphints["keypads"][4].origin = (-15513, 43307, 105);
  level.maphints["keypads"][5] = spawnStruct();
  level.maphints["keypads"][5].origin = (2495, 41096, 1670);
  level.maphints["keypads"][6] = spawnStruct();
  level.maphints["keypads"][6].origin = (47600, 34582, 500);
  level.maphints["keypads"][7] = spawnStruct();
  level.maphints["keypads"][7].origin = (18622, -34634, -478);
  level.maphints["keypads"][8] = spawnStruct();
  level.maphints["keypads"][8].origin = (54279, -33994, 173);
  level.maphints["keypads"][9] = spawnStruct();
  level.maphints["keypads"][9].origin = (36350, 13586, 26);
  level.maphints["keypads"][10] = spawnStruct();
  level.maphints["keypads"][10].origin = (37390, 13383, -117);

  foreach(index, hint in level.maphints["keypads"])
  level.maphints["keypads"][index].scriptable = spawnscriptable("maphint_keypad", hint.origin);
}

initlocs_phones() {
  level.maphints["phones"] = [];

  foreach(index, hint in level.maphints["phones"])
  level.maphints["phones"][index].scriptable = spawnscriptable("maphint_phone", hint.origin);
}

initlocs_computer() {
  level.maphints["computers"] = [];
  level.maphints["computers"][0] = spawnStruct();
  level.maphints["computers"][0].origin = (8490, -11874, -239);
  level.maphints["computers"][1] = spawnStruct();
  level.maphints["computers"][1].origin = (-14585, 7982, -175);
  level.maphints["computers"][2] = spawnStruct();
  level.maphints["computers"][2].origin = (-34140, 3815, -55);
  level.maphints["computers"][3] = spawnStruct();
  level.maphints["computers"][3].origin = (5358, 51419, 1080);
  level.maphints["computers"][4] = spawnStruct();
  level.maphints["computers"][4].origin = (51078, -39445, 1125);
  level.maphints["computers"][5] = spawnStruct();
  level.maphints["computers"][5].origin = (17796, -8300, 1349);
  level.maphints["computers"][6] = spawnStruct();
  level.maphints["computers"][6].origin = (37275, -26745, -472);

  foreach(index, hint in level.maphints["computers"])
  level.maphints["computers"][index].scriptable = spawnscriptable("maphint_computer", hint.origin);
}

initlocs_radio() {
  level.maphints["radios"] = [];
  level.maphints["radios"][0] = spawnStruct();
  level.maphints["radios"][0].origin = (-21440, 19434, -252);
  level.maphints["radios"][1] = spawnStruct();
  level.maphints["radios"][1].origin = (2896, 45445, 1630);

  foreach(index, hint in level.maphints["radios"])
  level.maphints["radios"][index].scriptable = spawnscriptable("maphint_radio", hint.origin);
}

maphint_keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  level thread _maphint_keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_maphint_keypadscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  if(state == "on") {
    playsoundatpos(player.origin, "br_keypad_deny");
    instance setscriptablepartstate("maphint_keypad", "off");
    wait 3;
    instance setscriptablepartstate("maphint_keypad", "on");
  }
}

maphint_phonescriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  level thread _maphint_phonescriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_maphint_phonescriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  if(state == "on") {
    playsoundatpos(player.origin, "br_phone_deny");
    instance setscriptablepartstate("maphint_phone", "off");
    wait 3;
    instance setscriptablepartstate("maphint_phone", "on");
  }
}

maphint_computerscriptableused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  level thread _maphint_computerscriptableused(instance, part, state, player, _id_A5B2C541413AA895);
}

_maphint_computerscriptableused(instance, part, state, player, _id_A5B2C541413AA895) {
  if(state == "on") {
    playsoundatpos(player.origin, "br_computer_deny");
    instance setscriptablepartstate("maphint_computer", "off");
    wait 3;
    instance setscriptablepartstate("maphint_computer", "on");
  }
}

initlocs_test() {
  wait 5;
  level.maphints["keypads"] = [];
  level.maphints["keypads"][0] = spawnStruct();
  level.maphints["keypads"][0].origin = (-237, -2721, 60);
  level.maphints["keypads"][1] = spawnStruct();
  level.maphints["keypads"][1].origin = (-237, -2721, 260);

  foreach(hint in level.maphints["keypads"])
  item = spawnscriptable("maphint_keypad", hint.origin);

  level.maphints["phones"] = [];
  level.maphints["phones"][0] = spawnStruct();
  level.maphints["phones"][0].origin = (-21, -2721, 60);
  level.maphints["phones"][1] = spawnStruct();
  level.maphints["phones"][1].origin = (-21, -2721, 260);

  foreach(hint in level.maphints["phones"])
  item = spawnscriptable("maphint_phone", hint.origin);

  level.maphints["computers"] = [];
  level.maphints["computers"][0] = spawnStruct();
  level.maphints["computers"][0].origin = (100, -2721, 60);
  level.maphints["computers"][1] = spawnStruct();
  level.maphints["computers"][1].origin = (100, -2721, 260);

  foreach(hint in level.maphints["computers"])
  item = spawnscriptable("maphint_computer", hint.origin);
}

maphint_debugthink() {
  _id_BA3BEF4F8E6E3086 = 1;

  for(;;) {
    if(_id_BA3BEF4F8E6E3086) {
      foreach(hint in level.maphints["phones"])
      thread scripts\mp\utility\debug::drawsphere(hint.scriptable.origin, 64, 1, (0, 1, 0));
    }

    if(getdvarint("dvar_87C1BBD83C66BFC9", 0) == 1) {
      foreach(hint in level.maphints["keypads"])
      hint.scriptable freescriptable();

      foreach(hint in level.maphints["phones"])
      hint.scriptable freescriptable();

      foreach(hint in level.maphints["computers"])
      hint.scriptable freescriptable();

      initlocs_keypads();
      initlocs_phones();
      initlocs_computer();
    }

    wait 1;
  }
}

init_season3_intel_challenges() {
  level.intelchallengesdata = [];
  scripts\mp\flags::gameflaginit("intel_challenges_setup_complete", 0);
  _id_1B0FD1877949FE92 = getdvarint("online_challenge_season_and_week", 0);
  _id_CB89110314447B2F = 0;

  for(;;) {
    ref = tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 0);

    if(!isDefined(ref) || ref == "") {
      break;
    }

    ingame = int(tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 2));
    week = int(tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 1));

    if(week > _id_1B0FD1877949FE92 && getdvarint("dvar_253F01D86ED6F6E4", 0) == 0) {
      _id_CB89110314447B2F++;
      continue;
    }

    backendevent = tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 3);
    modelpart = tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 4);
    _id_12B360CBEAAAAAC1 = float(tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 5));
    _id_12B35FCBEAAAA88E = float(tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 6));
    _id_12B35ECBEAAAA65B = float(tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 7));
    origin = (_id_12B360CBEAAAAAC1, _id_12B35FCBEAAAA88E, _id_12B35ECBEAAAA65B);
    _id_924B2EF42305583F = float(tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 8));
    _id_924B2DF42305560C = float(tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 9));
    _id_924B30F423055CA5 = float(tablelookupbyrow("mp/intel_challenges.csv", _id_CB89110314447B2F, 10));
    angles = (_id_924B2EF42305583F, _id_924B2DF42305560C, _id_924B30F423055CA5);
    data = spawnStruct();
    data.ref = ref;
    data.ingame = ingame;
    data.week = week;
    data.backendevent = backendevent;
    data.modelpart = modelpart;
    data.origin = origin;
    data.scriptables = [];
    _id_3D25A0D4510E22C2 = 0;

    if(ingame && !_id_3D25A0D4510E22C2) {
      instance = spawnscriptable("intel", origin, angles);
      instance.datakey = ref;
      data.scriptables[0] = instance;
    }

    level.intelchallengesdata[ref] = data;
    _id_CB89110314447B2F++;
  }

  ref = "ch_intel_season3_2_7";

  if(isDefined(level.intelchallengesdata[ref])) {
    origin = (-14280, -15350, -199);
    angles = (0, 0, 0);
    instance = spawnscriptable("intel", origin, angles);
    instance.datakey = ref;
    level.intelchallengesdata[ref].scriptables[level.intelchallengesdata[ref].scriptables.size] = instance;
  }

  ref = "ch_intel_season3_5_5";

  if(isDefined(level.intelchallengesdata[ref])) {
    origin = (-25767, -31548, 1595);
    angles = (0, 0, 0);
    instance = spawnscriptable("intel", origin, angles);
    instance.datakey = ref;
    level.intelchallengesdata[ref].scriptables[level.intelchallengesdata[ref].scriptables.size] = instance;
    origin = (14607, 15419, 1914);
    angles = (0, 0, 0);
    instance = spawnscriptable("intel", origin, angles);
    instance.datakey = ref;
    level.intelchallengesdata[ref].scriptables[level.intelchallengesdata[ref].scriptables.size] = instance;
    level.intelchallengesdata[ref].collectall = 1;
  }

  ref = "ch_intel_7_6";

  if(isDefined(level.intelchallengesdata[ref])) {
    origin = (31519, -444, 38);
    angles = (0, 0, 0);
    instance = spawnscriptable("intel", origin, angles);
    instance.datakey = ref;
    level.intelchallengesdata[ref].scriptables[level.intelchallengesdata[ref].scriptables.size] = instance;
    origin = (31514, -333, 38);
    angles = (0, 0, 0);
    instance = spawnscriptable("intel", origin, angles);
    instance.datakey = ref;
    level.intelchallengesdata[ref].scriptables[level.intelchallengesdata[ref].scriptables.size] = instance;
    level.intelchallengesdata[ref].collectall = 1;
  }

  level thread assignscriptablemodels();
  scripts\engine\scriptable::scriptable_addusedcallback(::intelused);
  scripts\mp\flags::gameflagset("intel_challenges_setup_complete");
}

assignscriptablemodels() {
  wait 1.0;

  foreach(key, _id_F90358454413407F in level.intelchallengesdata) {
    if(!_id_F90358454413407F.ingame) {
      continue;
    }
    foreach(instance in level.intelchallengesdata[key].scriptables)
    instance setscriptablepartstate("model", _id_F90358454413407F.modelpart);
  }
}

showintelscriptablestoplayer(player, key) {
  foreach(instance in level.intelchallengesdata[key].scriptables)
  instance enablescriptableplayeruse(player);
}

hideintelscriptablesfromplayer(player, key) {
  foreach(instance in level.intelchallengesdata[key].scriptables)
  instance disablescriptableplayeruse(player);
}

onplayerconnect() {
  for(;;) {
    level waittill("connected", player);
    player thread assignintelchallenges();
  }
}

assignintelchallenges() {
  self endon("disconnect");

  foreach(key, _id_F90358454413407F in level.intelchallengesdata) {
    if(!_id_F90358454413407F.ingame) {
      continue;
    }
    hideintelscriptablesfromplayer(self, key);
  }

  self.activeintelchallengekeys = [];

  if(getdvarint("dvar_253F01D86ED6F6E4", 0) == 1) {
    _id_72A9BA770FBEA73B = [];

    foreach(key, _id_F90358454413407F in level.intelchallengesdata) {
      if(!_id_F90358454413407F.ingame) {
        continue;
      }
      _id_72A9BA770FBEA73B[_id_72A9BA770FBEA73B.size] = key;
    }

    self.activeintelchallengekeys = _id_72A9BA770FBEA73B;
  } else {
    _id_1B0FD1877949FE92 = 3001;
    _id_60669594E9A721DF = undefined;

    foreach(key, _id_F90358454413407F in level.intelchallengesdata) {
      if(_id_F90358454413407F.week < _id_1B0FD1877949FE92) {
        continue;
      }
      if(_id_1B0FD1877949FE92 < _id_F90358454413407F.week)
        _id_1B0FD1877949FE92 = _id_F90358454413407F.week;

      if(isDefined(_id_60669594E9A721DF) && _id_60669594E9A721DF < _id_F90358454413407F.week)
        _id_60669594E9A721DF = undefined;

      _id_0AF8D4CC519C65DE = self getplayerdata(level._id_5D69837CF4DB0407, "missionComplete", key);

      if(!isDefined(_id_60669594E9A721DF) && !_id_0AF8D4CC519C65DE) {
        _id_60669594E9A721DF = _id_F90358454413407F.week;
        _id_1B0FD1877949FE92++;
        self.activeintelchallengekeys[self.activeintelchallengekeys.size] = key;
      }
    }
  }

  scripts\mp\flags::gameflagwait("prematch_done");

  foreach(key, _id_F90358454413407F in level.intelchallengesdata) {
    if(!_id_F90358454413407F.ingame) {
      continue;
    }
    if(scripts\engine\utility::array_contains(self.activeintelchallengekeys, key))
      showintelscriptablestoplayer(self, key);
  }
}

intelused(instance, part, state, player, _id_A5B2C541413AA895, _id_CC38472E36BE1B61) {
  if(isDefined(instance) && isDefined(instance.type) && instance.type == "intel") {
    _id_27BE02959911AE4D = 1;

    if(!scripts\engine\utility::array_contains(player.activeintelchallengekeys, instance.datakey))
      _id_27BE02959911AE4D = 0;

    if(instance.datakey == "ch_intel_season3_2_5") {
      if(!player scripts\mp\utility\perk::_hasperk("specialty_hack")) {
        _id_27BE02959911AE4D = 0;
        playsoundatpos(player.origin, "br_computer_deny");
      }
    }

    if(_id_27BE02959911AE4D) {
      if(istrue(level.intelchallengesdata[instance.datakey].collectall)) {
        if(!isDefined(player.pers[instance.datakey]))
          player.pers[instance.datakey] = 1;
        else
          player.pers[instance.datakey]++;

        count = level.intelchallengesdata[instance.datakey].scriptables.size;

        if(player.pers[instance.datakey] < count) {
          instance disablescriptableplayeruse(player);
          player playsoundtoplayer("ui_intel_interact", player);
          return;
        }
      }

      hideintelscriptablesfromplayer(player, instance.datakey);
      player reportchallengeuserevent("collect_item", level.intelchallengesdata[instance.datakey].backendevent);
      player playsoundtoplayer("ui_intel_interact", player);
    }
  }
}

isplayeronintelchallenge(player, ref) {
  return isDefined(player.activeintelchallengekeys) && scripts\engine\utility::array_contains(player.activeintelchallengekeys, ref);
}

markintelwithrecondrone(_id_6D5A295AE3C46554, ent) {
  _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(_id_6D5A295AE3C46554.team, 0);

  foreach(player in _id_6D5ED003AF1F9612) {
    if(isplayeronintelchallenge(player, ent.datakey))
      intelused(ent.scriptable, undefined, undefined, player);
  }
}

_id_511E2C2A5399F0D9() {
  level endon("game_ended");

  for(;;) {
    self waittill("emp_applied", data);
    _id_6D5ED003AF1F9612 = scripts\mp\utility\teams::getfriendlyplayers(data.attacker, 0);

    foreach(player in _id_6D5ED003AF1F9612) {
      if(isplayeronintelchallenge(player, self.datakey))
        intelused(self.scriptable, undefined, undefined, player);
    }
  }
}