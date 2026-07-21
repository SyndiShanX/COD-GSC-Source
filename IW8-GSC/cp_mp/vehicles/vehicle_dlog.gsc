/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp_mp\vehicles\vehicle_dlog.gsc
***********************************************/

vehicle_dlog_spawnevent(var_0, var_1, var_2) {
  var_3 = vehicle_dlog_getinstancedata(var_0, 1);

  if(!isDefined(var_3)) {
    return;
  }
  if(!isDefined(var_2))
    var_2 = var_0.vehiclename;

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  getentitylessscriptablearray("_encstr_A60419E8F8C0F7AF17E8D78B73E9ED89113091BA2B79C0B2465BE5", ["_encstr_8B31118BD9D3F40AC91707CF0B27301DEE5027", var_3.id, "_encstr_A33506D8AA82DF6A", var_0.origin[0], "_encstr_9335067B90C6FFD8", var_0.origin[1], "_encstr_9135061CED9BAF9E", var_0.origin[2], "_encstr_AF810DB6B0D16CD0D1B4B62B7DB6E6", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "_encstr_AA520BC3AB70BFC879738BDBA7", var_1, "_encstr_96840D9DB2A14B6CB12BBEE89738AC", var_2]);
}

vehicle_dlog_exitevent(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_1)) {
    return;
  }
  var_4 = vehicle_dlog_getinstancedata(var_0);

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  var_1 dlog_recordplayerevent("_encstr_8B741FB92D573B9012939B85B3994FE0F1C001F31996D8338ABF91AB07C293809C", ["_encstr_8B31118BD9D3F40AC91707CF0B27301DEE5027", var_4.id, "_encstr_A9C50B2BF0A58ED707DE377D1E", var_0.origin[0], "_encstr_8CC50B2B3C5AE8D70E7BDCD75E", var_0.origin[1], "_encstr_B1C50B2BC3D2D1F5387BDCEB3D", var_0.origin[2], "_encstr_A2BB0DB2F0B43AEBDC59588EAF9691", var_2, "_encstr_954D12563C2D1DD75BB01D8DD0D14BD6CAF5AD6E", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "_encstr_9A360AEB4BB8DB897B58633D", var_3]);
}

_id_1418A(var_0, var_1, var_2, var_3) {
  if(!isPlayer(var_1)) {
    return;
  }
  var_4 = vehicle_dlog_getinstancedata(var_0);

  if(!isDefined(var_4)) {
    return;
  }
  if(!isDefined(var_2)) {
    return;
  }
  if(!isDefined(var_3)) {
    return;
  }
  var_1 dlog_recordplayerevent("_encstr_9B3A20AD856A577EF553A808A33753895268952ED1932BC0D12FE8582725E8E1BA52", ["_encstr_8B31118BD9D3F40AC91707CF0B27301DEE5027", var_4.id, "_encstr_BA910C59E6E82B4EAF0EDB37AFC3", var_0.origin[0], "_encstr_A9910CDB7E13203E7FFB1883113F", var_0.origin[1], "_encstr_A2910C56B9E8CA39D71C7B6EF59E", var_0.origin[2], "_encstr_99010EB18554081ED9FFF3839BA1EB48", var_2, "_encstr_A9DA135F30E15A62FE70A7FB28303CC2BBDDA9D526", scripts\cp_mp\utility\game_utility::gettimesincegamestart(), "_encstr_B8BE0B91DAEB85A0F95CD3F975", var_3]);
}

vehicle_dlog_init() {
  var_0 = spawnStruct();
  var_0.uniqueid = 0;
  level.vehicle.dlogdata = var_0;
}

vehicle_dlog_getleveldata() {
  return level.vehicle.dlogdata;
}

vehicle_dlog_getinstancedata(var_0, var_1) {
  var_2 = vehicle_dlog_getleveldata();
  var_3 = var_0.dlogdata;

  if(!isDefined(var_3) && istrue(var_1)) {
    var_3 = spawnStruct();
    var_0.dlogdata = var_3;
    var_3.id = var_2.uniqueid;
    var_2.uniqueid++;
  }

  return var_3;
}

vehicle_dlog_getuniqueid(var_0) {
  return var_0.dlogid;
}