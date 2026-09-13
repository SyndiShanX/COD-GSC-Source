/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_keypad_util.gsc
***************************************************/

getkeypadstatefromomnvar() {
  return playerunpackdatafromomnvar("ui_keypad_data", 0, 2);
}

getkeypadcodelengthfromomnvar() {
  return playerunpackdatafromomnvar("ui_keypad_data", 2, 4);
}

playersetkeypadstateindex(_id_D73C9918509F8D36) {
  playersetomnvarkeypad(0, _id_D73C9918509F8D36);
}

playersetkeypadcodelengthindex(_id_27772E126A007B40) {
  playersetomnvarkeypad(1, _id_27772E126A007B40);
}

playersetomnvarkeypad(_id_AC85B79DFC4E45C6, value) {
  [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63, value] = getkeypadomnvarbitpackinginfo(_id_AC85B79DFC4E45C6, value);

  if(_id_8E90FA6D5789AD63 == "") {
    return;
  }
  playerpackdataintoomnvar(_id_8E90FA6D5789AD63, value, _id_64571E3AECCD1A07, _id_8534515023AFC188);
}

getkeypadomnvarbitpackinginfo(_id_AC85B79DFC4E45C6, value) {
  _id_64571E3AECCD1A07 = 0;
  _id_8534515023AFC188 = 0;
  _id_8E90FA6D5789AD63 = "";

  switch (_id_AC85B79DFC4E45C6) {
    case 0:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188] = [0, 2];
      _id_8E90FA6D5789AD63 = "ui_keypad_data";
      break;
    case 1:
      [_id_64571E3AECCD1A07, _id_8534515023AFC188] = [2, 4];
      _id_8E90FA6D5789AD63 = "ui_keypad_data";
      break;
    default:
      break;
  }

  return [_id_64571E3AECCD1A07, _id_8534515023AFC188, _id_8E90FA6D5789AD63, value];
}

playerpackdataintoomnvar(_id_8E90FA6D5789AD63, value, _id_64571E3AECCD1A07, _id_8534515023AFC188) {
  mask = int(pow(2, _id_8534515023AFC188)) - 1;
  _id_A463992091F1D483 = (value &mask) << _id_64571E3AECCD1A07;
  _id_F8F977081D3DA8B4 = ~(mask << _id_64571E3AECCD1A07);
  _id_EE27F3F198276535 = self getclientomnvar(_id_8E90FA6D5789AD63);
  _id_ED711AEAF5E8CB76 = _id_EE27F3F198276535 &_id_F8F977081D3DA8B4;
  _id_82A90E56E416FA55 = _id_ED711AEAF5E8CB76 + _id_A463992091F1D483;

  if(_id_82A90E56E416FA55 != _id_EE27F3F198276535)
    self setclientomnvar(_id_8E90FA6D5789AD63, _id_82A90E56E416FA55);
}

playerunpackdatafromomnvar(_id_8E90FA6D5789AD63, _id_C20319AA0598DC14, _id_7214ADEAFEE0FC1B) {
  _id_EE27F3F198276535 = self getclientomnvar(_id_8E90FA6D5789AD63);
  _id_0081829A47D6020A = (1 << _id_7214ADEAFEE0FC1B) - 1;
  _id_8221E91D323E06D1 = _id_EE27F3F198276535 >> _id_C20319AA0598DC14;
  _id_F94E3B11A17A0398 = _id_0081829A47D6020A &_id_8221E91D323E06D1;
  return _id_F94E3B11A17A0398;
}