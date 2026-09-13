/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_243677330bc33d66.gsc
***********************************************/

bindactionscripts() {
  if(isDefined(level._btactions["zombie"])) {
    return;
  }
  bt = spawnStruct();
  bt.actionfn = [];
  bt.actionfn[0] = _id_08673E0244B7DF2F::_id_8225E9DBF1FD31A5;
  bt.actionfn[1] = _id_08673E0244B7DF2F::_id_1ABC3A6C25B2532C;
  bt.actionfn[2] = _id_08673E0244B7DF2F::_id_76059E9B4C48EB43;
  bt.actionfn[3] = _id_08673E0244B7DF2F::_id_1C0A6BBCC552B6F6;
  bt.actionfn[4] = _id_08673E0244B7DF2F::_id_78B8A2B2A51787CB;
  bt.actionfn[5] = scripts\aitypes\common::dowait;
  bt.actionfn[6] = scripts\aitypes\common::setupwait;
  bt.actionfn[7] = _id_08673E0244B7DF2F::_id_1FE8127365E94575;
  bt.actionfn[8] = _id_08673E0244B7DF2F::_id_14627B1045DA03DD;
  bt.actionfn[9] = _id_08673E0244B7DF2F::_id_262E486F37ACA7C5;
  bt.actionfn[10] = _id_08673E0244B7DF2F::_id_B04028D06F64F4C7;
  bt.actionfn[11] = _id_08673E0244B7DF2F::_id_56A13C24FDAAF353;
  bt.actionfn[12] = _id_08673E0244B7DF2F::_id_3771B152C7260E89;
  bt.actionfn[13] = _id_08673E0244B7DF2F::_id_4AD27A07D0C6B1D5;
  level._btactions["zombie"] = bt;
}

registerbehaviortree() {
  bindactionscripts();
  _func_866EF0680E03FE86("zombie");
}