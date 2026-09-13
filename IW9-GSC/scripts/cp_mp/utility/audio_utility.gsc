/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\utility\audio_utility.gsc
***************************************************/

_id_6DCA6F439CA0A74F() {
  if(!isDefined(level._id_BE3605030AEF1714)) {
    level._id_BE3605030AEF1714 = spawnStruct();
    level._id_BE3605030AEF1714.objects = [];
    level._id_BE3605030AEF1714._id_A79BB46C42FFE2FD = [];
    level._id_BE3605030AEF1714._id_5EE4ABA82383469E = ::playsoundonmovingent;
  }
}

_id_B3E5599C9F6A8895(obj) {
  if(!isstruct(obj._id_BE3605030AEF1714))
    obj._id_BE3605030AEF1714 = spawnStruct();
}

_id_F0B5522EE5CE0CB1() {
  if(isstruct(level._id_BE3605030AEF1714))
    return 1;

  return 0;
}

_id_40A17693396019A7() {
  while(_id_F0B5522EE5CE0CB1() == 0)
    waitframe();
}

_id_55F5473E977F265F(_id_A3BF560B25C4A33E) {
  players = [];

  if(isarray(level.teamdata) && isarray(level.teamdata[_id_A3BF560B25C4A33E]) && isarray(level.teamdata[_id_A3BF560B25C4A33E]["players"]))
    players = level.teamdata[_id_A3BF560B25C4A33E]["players"];

  return players;
}

_id_D6FE092BC83DA45B(_id_6E077719C0EFCB61, radius, _id_A3BF560B25C4A33E) {
  origin = undefined;
  radius = scripts\engine\utility::_id_53C4C53197386572(radius, 240);
  _id_A3BF560B25C4A33E = scripts\engine\utility::_id_53C4C53197386572(_id_A3BF560B25C4A33E, "");
  players = [];

  if(isvector(_id_6E077719C0EFCB61))
    origin = _id_6E077719C0EFCB61;
  else if(isent(_id_6E077719C0EFCB61))
    origin = _id_6E077719C0EFCB61.origin;

  if(isvector(origin)) {
    _id_3A35F39B95DF3BF5 = getentarrayinradius("player", "classname", origin, radius);

    foreach(player in _id_3A35F39B95DF3BF5) {
      if(isPlayer(player) && !isagent(player)) {
        if(_id_A3BF560B25C4A33E == "" || isstring(player.team) && player.team == _id_A3BF560B25C4A33E)
          players[players.size] = player;
      }
    }

    return players;
  } else {}

  return players;
}

_id_AD9F5152BFDEBCFE(_id_34C51814A444FA62, _id_647F0D4FB967A7E9, value) {
  game[_id_34C51814A444FA62][_id_647F0D4FB967A7E9] = value;
}

_id_0D05E164D112AB01(_id_34C51814A444FA62, _id_647F0D4FB967A7E9) {
  _id_AD9F5152BFDEBCFE(_id_34C51814A444FA62, _id_647F0D4FB967A7E9, undefined);
}

_id_9A0F23D8ADCD6392(_id_34C51814A444FA62, _id_647F0D4FB967A7E9) {
  data = game[_id_34C51814A444FA62][_id_647F0D4FB967A7E9];
  return data;
}

_id_5CB73579174212FD(_id_34C51814A444FA62, _id_647F0D4FB967A7E9) {
  value = _id_9A0F23D8ADCD6392(_id_34C51814A444FA62, _id_647F0D4FB967A7E9);

  if(isarray(value)) {
    index = 0;

    if(value.size > 1)
      index = randomintrange(0, value.size);

    value = value[index];
  }

  return value;
}

_id_7ACDE5FEB50C98F2(players, soundalias) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, []);
  soundalias = scripts\engine\utility::_id_53C4C53197386572(soundalias, "");

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player))
        player playlocalsound(soundalias);
    }
  } else {}
}

_id_66F41F0823BD279C(players, soundalias) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, []);
  soundalias = scripts\engine\utility::_id_53C4C53197386572(soundalias, "");

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player))
        player stoplocalsound(soundalias);
    }
  } else {}
}

_id_B11CFEE3350D246A(_id_CE3D772E6CC183B8, value) {
  _id_AD9F5152BFDEBCFE("music", _id_CE3D772E6CC183B8, value);
}

_id_A771505A563DA506(_id_CE3D772E6CC183B8) {
  state = _id_9A0F23D8ADCD6392("music", _id_CE3D772E6CC183B8);

  if(isarray(state)) {
    if(state.size == 0)
      state = undefined;
    else
      state = state[0];
  } else if(!isstring(state))
    state = undefined;

  if(!isDefined(state))
    return "";

  return state;
}

_id_17EE301CF0B5BA85(_id_CE3D772E6CC183B8) {
  state = _id_5CB73579174212FD("music", _id_CE3D772E6CC183B8);

  if(!isDefined(state) || !isstring(state))
    return "";

  return state;
}

_id_5DF2F278F44A6FFD(style) {
  if(isstring(style) && isDefined(level.music_style) && isstring(level.music_style) && level.music_style == style)
    return 1;

  return 0;
}

_id_FE75A89529DD0FD0(players, _id_9ADC1BCDCE9CF8B0, _id_C342527A25F10CC5, _id_AA00C7EB0E7E9C94, _id_206C8DFDB8C43D68) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, []);
  _id_9ADC1BCDCE9CF8B0 = scripts\engine\utility::_id_53C4C53197386572(_id_9ADC1BCDCE9CF8B0, "");
  _id_206C8DFDB8C43D68 = scripts\engine\utility::_id_53C4C53197386572(_id_206C8DFDB8C43D68, "");

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player)) {
        if(_id_9ADC1BCDCE9CF8B0 == "" && isDefined(_id_AA00C7EB0E7E9C94))
          player _meth_9BB444FE81766F7E(_id_AA00C7EB0E7E9C94);
        else if(isarray(_id_C342527A25F10CC5))
          player setplayermusicstate(_id_9ADC1BCDCE9CF8B0, _id_C342527A25F10CC5);
        else if(isDefined(player._id_ACFBB9CAED7125F9) && player._id_ACFBB9CAED7125F9 == 1)
          player setplayermusicstate(_id_206C8DFDB8C43D68);
        else
          player setplayermusicstate(_id_9ADC1BCDCE9CF8B0);

        player.nosuspensemusic = 1;
      }
    }
  } else {}
}

_id_46979D2FD81A6D4B(_id_A3BF560B25C4A33E, _id_9ADC1BCDCE9CF8B0, _id_C342527A25F10CC5, _id_206C8DFDB8C43D68) {
  _id_A3BF560B25C4A33E = scripts\engine\utility::_id_53C4C53197386572(_id_A3BF560B25C4A33E, "");
  _id_9ADC1BCDCE9CF8B0 = scripts\engine\utility::_id_53C4C53197386572(_id_9ADC1BCDCE9CF8B0, "");
  _id_206C8DFDB8C43D68 = scripts\engine\utility::_id_53C4C53197386572(_id_206C8DFDB8C43D68, "");
  players = _id_55F5473E977F265F(_id_A3BF560B25C4A33E);
  _id_FE75A89529DD0FD0(players, _id_9ADC1BCDCE9CF8B0, _id_C342527A25F10CC5, undefined, _id_206C8DFDB8C43D68);
}

_id_FDD0934F1A32F70D(_id_6E077719C0EFCB61, radius, _id_9ADC1BCDCE9CF8B0, _id_A3BF560B25C4A33E, _id_C342527A25F10CC5, _id_206C8DFDB8C43D68) {
  _id_9ADC1BCDCE9CF8B0 = scripts\engine\utility::_id_53C4C53197386572(_id_9ADC1BCDCE9CF8B0, "");
  _id_206C8DFDB8C43D68 = scripts\engine\utility::_id_53C4C53197386572(_id_206C8DFDB8C43D68, "");
  players = _id_D6FE092BC83DA45B(_id_6E077719C0EFCB61, radius, _id_A3BF560B25C4A33E);
  _id_FE75A89529DD0FD0(players, _id_9ADC1BCDCE9CF8B0, _id_C342527A25F10CC5, undefined, _id_206C8DFDB8C43D68);
}

_id_42A8A4F269E8483C(_id_6E077719C0EFCB61, radius, _id_C903171C88765F0F) {
  players = _id_D6FE092BC83DA45B(_id_6E077719C0EFCB61, radius);

  foreach(player in players)
  player.nosuspensemusic = _id_C903171C88765F0F;
}

_id_4E8BA327EB12540C(players, _id_220CFD744ED0BA55, _id_F69BA8D7B96E8326, scale) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, []);
  _id_220CFD744ED0BA55 = scripts\engine\utility::_id_53C4C53197386572(_id_220CFD744ED0BA55, "");
  _id_F69BA8D7B96E8326 = scripts\engine\utility::_id_53C4C53197386572(_id_F69BA8D7B96E8326, -1);
  scale = scripts\engine\utility::_id_53C4C53197386572(scale, 1.0);

  if(isarray(players)) {
    foreach(player in players) {
      if(isPlayer(player) && !isagent(player))
        player setsoundsubmix(_id_220CFD744ED0BA55, _id_F69BA8D7B96E8326, scale);
    }
  } else {}
}

_id_C7F38D0611AA82E7(_id_A3BF560B25C4A33E, _id_220CFD744ED0BA55, _id_F69BA8D7B96E8326, scale) {
  _id_220CFD744ED0BA55 = scripts\engine\utility::_id_53C4C53197386572(_id_220CFD744ED0BA55, "");
  _id_A3BF560B25C4A33E = scripts\engine\utility::_id_53C4C53197386572(_id_A3BF560B25C4A33E, "");
  players = _id_55F5473E977F265F(_id_A3BF560B25C4A33E);
  _id_4E8BA327EB12540C(players, _id_220CFD744ED0BA55, _id_F69BA8D7B96E8326, scale);
}

_id_C79F9300EE85F805(players, _id_220CFD744ED0BA55, _id_F69BA8D7B96E8326) {
  players = scripts\engine\utility::_id_53C4C53197386572(players, []);
  _id_220CFD744ED0BA55 = scripts\engine\utility::_id_53C4C53197386572(_id_220CFD744ED0BA55, "");
  _id_F69BA8D7B96E8326 = scripts\engine\utility::_id_53C4C53197386572(_id_F69BA8D7B96E8326, -1);

  if(isarray(players)) {
    foreach(player in players)
    player clearsoundsubmix(_id_220CFD744ED0BA55, _id_F69BA8D7B96E8326);
  } else {}
}

_id_E3A3A924D8604018(_id_A3BF560B25C4A33E, _id_220CFD744ED0BA55, _id_F69BA8D7B96E8326, scale) {
  _id_220CFD744ED0BA55 = scripts\engine\utility::_id_53C4C53197386572(_id_220CFD744ED0BA55, "");
  _id_A3BF560B25C4A33E = scripts\engine\utility::_id_53C4C53197386572(_id_A3BF560B25C4A33E, "");
  players = _id_55F5473E977F265F(_id_A3BF560B25C4A33E);
  _id_C79F9300EE85F805(players, _id_220CFD744ED0BA55, _id_F69BA8D7B96E8326);
}

_id_110D3AB280057F5B(_id_46260B6EEE9C6E62, _id_D2B72F7C2D3AF70E) {
  return _id_46260B6EEE9C6E62;
}

_id_5B159F140BD186DF() {
  _id_40A17693396019A7();

  if(!isarray(level._id_BE3605030AEF1714._id_0828AB610E771905))
    level._id_BE3605030AEF1714._id_0828AB610E771905 = [];

  if(!isent(level._id_BE3605030AEF1714._id_4388174FD6467686))
    level._id_BE3605030AEF1714._id_4388174FD6467686 = spawn("sound_transient_soundbanks", (0, 0, 0));
}

_id_1186CA4E2E51AFEA(name) {
  if(isstruct(level._id_BE3605030AEF1714) && isDefined(level._id_BE3605030AEF1714._id_0828AB610E771905) && isDefined(level._id_BE3605030AEF1714._id_0828AB610E771905[name]))
    return 1;

  return 0;
}

_id_0F1AED36AB4598EA(name) {
  if(getdvarint("r_reflectionprobegenerate") != 0 || getdvarint("g_connectpaths") != 0) {
    return;
  }
  _id_5B159F140BD186DF();
  _id_97453ABD88B8CEE4 = _id_1186CA4E2E51AFEA(name);

  if(_id_110D3AB280057F5B(_id_97453ABD88B8CEE4, "snd_transient_load loaded '" + name + "'"))
    return;
  else {
    level._id_BE3605030AEF1714._id_4388174FD6467686 settransientsoundbank(name + ".all", 1);
    level._id_BE3605030AEF1714._id_0828AB610E771905[name] = level._id_BE3605030AEF1714._id_0828AB610E771905.size;
  }
}

_id_F4E0FF5CB899686D(name) {
  if(getdvarint("r_reflectionprobegenerate") != 0 || getdvarint("g_connectpaths") != 0) {
    return;
  }
  _id_5B159F140BD186DF();
  _id_97453ABD88B8CEE4 = _id_1186CA4E2E51AFEA(name);

  if(_id_110D3AB280057F5B(!_id_97453ABD88B8CEE4, "snd_transient_unload '" + name + "' not loaded")) {
    return;
  }
  level._id_BE3605030AEF1714._id_4388174FD6467686 settransientsoundbank(name + ".all", 0);
  level._id_BE3605030AEF1714._id_0828AB610E771905[name] = undefined;
}