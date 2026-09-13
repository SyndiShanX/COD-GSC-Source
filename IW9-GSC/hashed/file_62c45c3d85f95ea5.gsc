/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_62c45c3d85f95ea5.gsc
***********************************************/

_id_F36EC32AC1889838(_id_506C6E78C81FB92A, _id_3D7881FA3B0D3B9E, _id_4622FE3166EE36A1, _id_7239F8830EF22B43, _id_99F6C4779B3EDA61, _id_27FF0692112DA50C, _id_B7F16AC1D260657A) {
  level endon("game_ended");
  _id_2A54ADD44D7DDF42 = getdvarint("dvar_DC95D37637846BE1", 300);
  wait(_id_2A54ADD44D7DDF42);
  _id_55E8D3A65F807853(_id_506C6E78C81FB92A, _id_3D7881FA3B0D3B9E);
  _id_553E7E34CC056CE9(_id_506C6E78C81FB92A);
  _id_0A61989C59374608(_id_506C6E78C81FB92A, _id_3D7881FA3B0D3B9E, _id_4622FE3166EE36A1, _id_7239F8830EF22B43, _id_99F6C4779B3EDA61, _id_27FF0692112DA50C, _id_B7F16AC1D260657A);
}

_id_55E8D3A65F807853(_id_506C6E78C81FB92A, _id_3D7881FA3B0D3B9E) {
  for(;;) {
    wait 1;
    _id_78122E18403A8DC4 = scripts\common\utility::playersinsphere(_id_506C6E78C81FB92A, _id_3D7881FA3B0D3B9E);

    if(_id_78122E18403A8DC4.size > 0) {
      continue;
    }
    break;
  }
}

_id_0A61989C59374608(_id_D83CA5E4517EB74E, _id_1F07D07D0434B28E, _id_4622FE3166EE36A1, _id_7239F8830EF22B43, _id_99F6C4779B3EDA61, _id_27FF0692112DA50C, _id_B7F16AC1D260657A) {
  level endon("game_ended");
  scriptable = spawn("script_model", _id_D83CA5E4517EB74E);

  if(isDefined(_id_99F6C4779B3EDA61))
    scriptable setModel("mp_saba_pm_tag_transition_sphere");
  else
    scriptable setModel("mp_saba_pm_tag_transition_sphere");

  scriptable forcenetfieldhighlod(1);
  _id_78122E18403A8DC4 = scripts\common\utility::playersinsphere(_id_D83CA5E4517EB74E, _id_1F07D07D0434B28E);
  _id_EF1BD90168AF5FED = "expand";

  if(isDefined(_id_B7F16AC1D260657A))
    _id_EF1BD90168AF5FED = _id_B7F16AC1D260657A;

  scriptable setscriptablepartstate("transition_sphere", _id_EF1BD90168AF5FED);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_78122E18403A8DC4.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_78122E18403A8DC4[_id_AC0E594AC96AA3A8]))
      _id_78122E18403A8DC4[_id_AC0E594AC96AA3A8] visionsetnakedforplayer("mp_saba_pm_transition_sphere");
  }

  if(isDefined(_id_7239F8830EF22B43))
    level notify(_id_7239F8830EF22B43);

  if(isDefined(_id_4622FE3166EE36A1))
    level thread[[_id_4622FE3166EE36A1]]();

  waittime = 5;

  if(isDefined(_id_27FF0692112DA50C))
    waittime = _id_27FF0692112DA50C;

  wait(waittime);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_78122E18403A8DC4.size; _id_AC0E594AC96AA3A8++) {
    if(isalive(_id_78122E18403A8DC4[_id_AC0E594AC96AA3A8]))
      _id_78122E18403A8DC4[_id_AC0E594AC96AA3A8] visionsetnakedforplayer("mp_saba_pm");
  }

  scriptable delete();
}

_id_553E7E34CC056CE9(_id_506C6E78C81FB92A) {
  if(getdvarint("dvar_CEE3535A15FB2297", -1) > 0) {
    return;
  }
  if(scripts\mp\utility\game::getsubgametype() == "dmz") {
    return;
  }
  while(_id_2695A20D4011076D::_id_024C5A8D31AE262F(_id_506C6E78C81FB92A))
    wait 5;
}

_id_043AB23D816E98F8() {
  if(!isDefined(level._id_B205D90302DA2F07) || !isDefined(level._id_B205D90302DA2F07["bossArea"]) || !isDefined(level._id_B205D90302DA2F07["bossArea"]["subAreas"]))
    return [];

  if(!isDefined(level._id_B205D90302DA2F07["bossArea"]["subAreas"][0]))
    return [];

  return level._id_B205D90302DA2F07["bossArea"]["subAreas"][0]._id_3EBB6024E3F220CA;
}