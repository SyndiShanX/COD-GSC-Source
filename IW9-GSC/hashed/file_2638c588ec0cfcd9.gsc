/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2638c588ec0cfcd9.gsc
***********************************************/

_id_4FF27C88E74047B5() {
  if(!_id_2C3C990BA58FA6F5::_id_3B2142E2E66B8A60()) {
    return;
  }
  _id_AED74300DAF62896 = spawnStruct();
  _id_AED74300DAF62896.armor = getdvarfloat("dvar_843AEE88E47E70C9", 5000);
  _id_AED74300DAF62896.maxdamage = getdvarint("dvar_7B0F15773F96AAA0", 100);
  _id_AED74300DAF62896._id_BFE291B401A9BF2A = [];
  _id_AED74300DAF62896.name = "swampmonster";
  _id_AED74300DAF62896._id_649245B52DBF88A9 = undefined;
  _id_AED74300DAF62896._id_EC2EC5F083DF61CD = _id_29C0C8893A21A756::_id_2C8A5E12A23B3A6E;
  _id_AED74300DAF62896.spawnfunc = _id_29C0C8893A21A756::_id_829BCA7DC0ADC6D9;
  _id_AED74300DAF62896._id_E68429B39C75B6EE = _id_29C0C8893A21A756::_id_829BCA7DC0ADC6D9;
  _id_2636152C566D6C64::_id_613E13E7416BFAA5(_id_AED74300DAF62896);
  _id_29C0C8893A21A756::_id_2C8A5E12A23B3A6E(_id_AED74300DAF62896);
  level._id_DE0FF3B397972AFF = gettime();
}