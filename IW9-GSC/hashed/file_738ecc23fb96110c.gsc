/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_738ecc23fb96110c.gsc
***********************************************/

_id_9C8E6A1620EDC3B9(_id_B8DF88D128399821) {
  _id_20A11C870D111377 = _id_52EED65F3AF6AF91::_id_C50EA39387684E41(_id_B8DF88D128399821);

  if(!isDefined(_id_20A11C870D111377)) {
    return;
  }
  self _meth_14A669727E767840(level._id_1986E4576CC38610[_id_20A11C870D111377]);
}

_id_C858A1889A6CC094() {
  self _meth_14A669727E767840(0);
}

_id_E9BCEEAFA296CB55() {
  _id_F6586FA40D64F63E();
}

_id_F6586FA40D64F63E() {
  level._id_1986E4576CC38610 = [];
  _id_20A3C208A35FF465 = getscriptbundle("ftuehudvisibilitylist:ftuehudvisibility_list_mgl")._id_CE22599A7F93F1C3;

  foreach(_id_E98D60032AA37EF6 in level._id_CF6B53E10210D950) {
    _id_F4685368DCF821C5 = _func_06A36B14E6B79459(_func_2EF675C13CA1C4AF("enum_6B016976AFF9AE9F", _id_E98D60032AA37EF6._id_D442547D75DFFD09), "stat_AA8C9B14160855E5");

    if(isDefined(_id_F4685368DCF821C5)) {
      for(_id_FCCC3E3ABFA0E121 = 0; _id_20A3C208A35FF465[_id_FCCC3E3ABFA0E121]._id_D442547D75DFFD09 != _id_F4685368DCF821C5 && _id_FCCC3E3ABFA0E121 < _id_20A3C208A35FF465.size; _id_FCCC3E3ABFA0E121++) {}

      level._id_1986E4576CC38610[_id_E98D60032AA37EF6._id_D442547D75DFFD09] = _id_FCCC3E3ABFA0E121 + 1;
    }
  }
}