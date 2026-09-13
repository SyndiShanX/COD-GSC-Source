/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_74b851b7aa1ef32d.gsc
***********************************************/

_id_693D12AA2C1C02C5(eventtype, eventname, cooldown) {
  if(getdvarint(_func_2EF675C13CA1C4AF("scr_", scripts\mp\utility\game::getsubgametype(), "_disable_onactionscoreevents"), 0) == 1) {
    return;
  }
  if(scripts\mp\utility\game::getgametype() == "br" && !isDefined(level.prematchendtime)) {
    return;
  }
  if(!isDefined(cooldown))
    cooldown = 2.0;

  _id_2BC27CD3D02037D0 = cooldown * 1000.0;
  _id_0B7D39A4661F3460 = gettime();

  if(!isDefined(self._id_6D7A36C9233E010D))
    self._id_6D7A36C9233E010D = [];

  if(!isDefined(self._id_6D7A36C9233E010D[eventname]))
    self._id_6D7A36C9233E010D[eventname] = 0;
  else if(self._id_6D7A36C9233E010D[eventname] > _id_0B7D39A4661F3460) {
    return;
  }
  self._id_6D7A36C9233E010D[eventname] = _id_0B7D39A4661F3460 + _id_2BC27CD3D02037D0;

  switch (eventtype) {
    case 0:
      _id_A56759F3DEC70990(eventname);
      break;
    case 1:
      _id_E4278547AD0EE8C8(eventname);
      break;
    case 2:
      _id_D25FEB1DA4499BAE(eventname);
      break;
    default:
      break;
  }
}

_id_A56759F3DEC70990(eventname) {
  _id_C7CBA7D0DB108110 = _func_1823FF50BB28148D("altScore_equipment_" + eventname);
  _id_558E5516EE7925AA(_id_C7CBA7D0DB108110);
}

_id_E4278547AD0EE8C8(eventname) {
  _id_C7CBA7D0DB108110 = _func_1823FF50BB28148D("altScore_fieldUp_" + eventname);
  _id_558E5516EE7925AA(_id_C7CBA7D0DB108110);
}

_id_D25FEB1DA4499BAE(eventname) {
  _id_C7CBA7D0DB108110 = _func_1823FF50BB28148D("altScore_killstreak_" + eventname);
  _id_558E5516EE7925AA(_id_C7CBA7D0DB108110);
}

_id_558E5516EE7925AA(_id_C7CBA7D0DB108110) {
  points = scripts\mp\rank::getscoreinfovalue(_id_C7CBA7D0DB108110);

  if(isDefined(points))
    thread scripts\mp\utility\points::_id_0366980B6A8796AE(_id_C7CBA7D0DB108110, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, undefined, 1);
}