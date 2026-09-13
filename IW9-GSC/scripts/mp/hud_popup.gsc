/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\hud_popup.gsc
***********************************************/

init() {
  level._id_ACE3E1C42C4A94D7 = [];
}

_id_65336CC44771776E(ref) {
  _id_2C811AA33890F124 = _id_BEC00F5EABDB65EA(ref);

  if(!isDefined(_id_2C811AA33890F124) || _id_2C811AA33890F124 < 0) {
    return;
  }
  self setclientomnvar("ui_player_popup_id", _id_2C811AA33890F124);
  self._id_453B42F68499E7FC = gettime();
  self._id_942B501D544B0E0A = ref;
}

_id_233461F36BB50EF9(ref) {
  if(isDefined(ref)) {
    _id_2C811AA33890F124 = _id_BEC00F5EABDB65EA(ref);

    if(self getclientomnvar("ui_player_popup_id") != _id_2C811AA33890F124)
      return;
  }

  self setclientomnvar("ui_player_popup_id", -1);
}

_id_BEC00F5EABDB65EA(_id_3DF399F484F486B6) {
  id = level._id_ACE3E1C42C4A94D7[_id_3DF399F484F486B6];

  if(!isDefined(id)) {
    id = tablelookuprownum(_id_92B0A87F4E1A1D72(), 0, _id_3DF399F484F486B6);
    level._id_ACE3E1C42C4A94D7[_id_3DF399F484F486B6] = id;
  }

  return id;
}

_id_92B0A87F4E1A1D72() {
  return getDvar("dvar_DB7AB5886366DCDA", "mp/infoPopupTable.csv");
}