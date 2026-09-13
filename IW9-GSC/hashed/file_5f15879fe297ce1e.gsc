/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_5f15879fe297ce1e.gsc
***********************************************/

_id_9648C9D5F466804A() {
  level._id_B0DCCA55C78DA517 = _id_0530002CCBAA5E3B::_id_54DFCA3641C2C1AB("ftue_configuration_ds_download_test.json");

  if(!isDefined(level._id_B0DCCA55C78DA517))
    level._id_B0DCCA55C78DA517 = _func_FA18D3AA2D584A77("ftue/mobile/configuration/ftue_configuration.json");

  return isDefined(level._id_B0DCCA55C78DA517);
}

_id_93F5074380E8C2B8() {
  if(isDefined(level._id_B0DCCA55C78DA517))
    return level._id_B0DCCA55C78DA517["version"];
  else
    return "0.0.0";
}