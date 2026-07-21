/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\gametypes\br_publicevent_restock.gsc
***************************************************/

init() {
  var_0 = spawnStruct();
  var_0.weight = getdvarfloat("_encstr_B2F019EB5EFA71BEB3E74163CF9B754894359160C94768E31A2371", 0);
  var_0._id_140CF = ::_id_140CF;
  var_0._id_14382 = ::_id_14382;
  var_0.attackerswaittime = ::attackerswaittime;
  var_0.isfeaturedisabled = ::isfeaturedisabled;
  var_0._encstr_8BC10D10BFF87BCF58583BE223A02F = ::_encstr_8BC10D10BFF87BCF58583BE223A02F;
  var_0._id_11B78 = getdvarint("_encstr_9AC51C9B36E47D13E4F5C12BEB272B37D17B36DAF5AD1687AFE8A5B5B237", 2);
  var_0.guard_door_clip = _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::relic_squadlink_init_vfx("_encstr_8A29083959DC8EEDB1AD", "_encstr_85FD28F7E6EEA9E1D05AD2CA1698A9E1C78E67775E4671192872DAC26EA071192F53EFCFF2CF395101C6");
  var_0._encstr_A3BC1423775D180D6A8B83BDCF8255C0EDCC49B8DBAB = _encstr_99B82F4BFFA864837D23A68A6BF8E7DEF86BC4B931C82AB62E7BB963D3A60394F0C35E2DB52872AF41B1033ADBA877CA58::_encstr_BD2A1BFF8980447BA7F5CB97235DA3BD581133C740D81F028BE7B32B07("_encstr_8A29083959DC8EEDB1AD");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_12B35(6, var_0);
}

_encstr_8BC10D10BFF87BCF58583BE223A02F() {
  game["_encstr_B2DA070A5F8BAB87AF"]["_encstr_8BC81828F0788F153165775F0263A0A10BB9EA5B927BBB531123"] = "_encstr_8BC81828F0788F153165775F0263A0A10BB9EA5B927BBB531123";
  level._id_12129 = [];
}

_id_140CF() {
  return 1;
}

_id_14382() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8A431478F7784BCAC97FDB3836432F5B17EDD3F7F8EB");
}

attackerswaittime() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  _encstr_8BBE299653FB18D9237332385BADBF513FFD9D0BB84F835F8E0BB9D8231671E86F65248D0E53CB95372320::_id_13371("_encstr_835114F643A9783D8F4B5253F188DE54AF46732A3BC0");
  _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::brleaderdialog("_encstr_8BC81828F0788F153165775F0263A0A10BB9EA5B927BBB531123", 1);

  foreach(var_1 in level._id_12129) {
    if(var_1.type == "_encstr_95D0174C277D9CAC5D37B0263659AF63EDED8EFA6C0BD8A156") {
      var_1 setscriptablepartstate("_encstr_AD9B0589ED9197", "_encstr_970105D3C53B97");
      var_2 = getdvarint("_encstr_AA0C1D485FA2262D92E30E1F3E5A5B6E1BEF4008AF7798DF1ACB101ED733BF", 3);
      var_1.intel_collected = (var_1.intel_collected + 1) % var_2;
      var_1 notify("_encstr_A350079E35DACF8944");
      var_3 = "_encstr_BEE608BF50D84BAA9DF4";
    } else
      var_3 = "_encstr_BA560EB9951DEBA3EDD78DC6F6B9CA8C";

    var_1 setscriptablepartstate("_encstr_AD9B0589ED9197", var_3);
  }
}

isfeaturedisabled() {}

_id_12CC0() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  self endon("_encstr_AD75063D571AE108");

  switch (self.type) {
    case "_encstr_BA2116BE6BD94CEAA0F9778F3B5E62BD31F3F787017B0773":
    case "_encstr_8E0114B5E6B9D0CF40C4293F21FF4AB13730A0FFCB2D":
    case "_encstr_95D0174C277D9CAC5D37B0263659AF63EDED8EFA6C0BD8A156":
    case "_encstr_B4D90E9636AFD277F08057BF3029380A":
    case "_encstr_912213069327B01747A37913EA7E6C40AF691DDC1D":
      level._id_12129[level._id_12129.size] = self;
      break;
    default:
      return;
  }
}

use_dropkit_marker() {
  return istrue(level.delayeventfired) && getdvarfloat("_encstr_B2F019EB5EFA71BEB3E74163CF9B754894359160C94768E31A2371", 0) || istrue(level.delete_crate_objectives);
}

_id_12C00() {
  if(scripts\engine\utility::array_contains(level._id_12129, self))
    level._id_12129 = scripts\engine\utility::array_remove(level._id_12129, self);
}