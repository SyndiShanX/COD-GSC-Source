/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2ba81d8d4f69cfad.gsc
***********************************************/

_id_E1B062A375B4A629() {
  return self.plundercount;
}

_id_91B0046262BD8519() {
  return getdvarint("scr_br_plunder_start_amount", 0);
}

_id_E22745F1660C79DE(_id_0E318E240DD21247, position, _id_AB57E86CA58B81F2) {
  _id_CB4FAD49263E20C4 = _id_7E52B56769FA7774::getitemdropinfo(position);

  if(!isDefined(_id_AB57E86CA58B81F2) && isDefined(level.br_pickups.counts[_id_0E318E240DD21247]))
    _id_AB57E86CA58B81F2 = level.br_pickups.counts[_id_0E318E240DD21247];

  item = _id_7E52B56769FA7774::spawnpickup(_id_0E318E240DD21247, _id_CB4FAD49263E20C4, _id_AB57E86CA58B81F2);

  if(!isDefined(item)) {
    return;
  }
  return item;
}

_id_72C1EC67D589D251(callback, _id_88AD0E9A7561EA8D) {
  self endon("death_or_disconnect");

  if(isDefined(_id_88AD0E9A7561EA8D))
    level waittill("pickedupweapon_kill_callout_" + _id_88AD0E9A7561EA8D.type + _id_88AD0E9A7561EA8D.origin);
  else
    self waittill("self_pickedupitem_plunder");

  self[[callback]]();
}

_id_AD5378568B077260(_id_88AD0E9A7561EA8D) {
  if(!isDefined(_id_88AD0E9A7561EA8D))
    return 0;

  itemtype = _id_88AD0E9A7561EA8D.type;
  _id_88CF5D42344516FF = _id_88AD0E9A7561EA8D getscriptablepartstate(itemtype);
  return _id_88CF5D42344516FF != "hidden";
}

_id_A380CF8DD38A32EE(params) {
  return self.plundercount * 10 >= params.amount;
}