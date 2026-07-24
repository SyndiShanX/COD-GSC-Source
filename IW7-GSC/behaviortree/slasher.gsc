/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\slasher.gsc
**************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["slasher"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = ::scripts\aitypes\slasher\behaviors::initslasher;
  var_0._id_1581[1] = ::scripts\aitypes\slasher\behaviors::updateslashereveryframe;
  var_0._id_1581[2] = _id_0C2B::_id_3E48;
  var_0._id_1581[3] = ::scripts\aitypes\slasher\behaviors::decideslasheraction;
  var_0._id_1581[4] = ::scripts\aitypes\slasher\behaviors::doslasheraction_tick;
  var_0._id_1581[5] = ::scripts\aitypes\slasher\behaviors::doslasheraction_begin;
  var_0._id_1581[6] = ::scripts\aitypes\slasher\behaviors::doslasheraction_end;
  var_0._id_1581[7] = ::scripts\aitypes\slasher\behaviors::followenemy_tick;
  var_0._id_1581[8] = ::scripts\aitypes\slasher\behaviors::followenemy_begin;
  var_0._id_1581[9] = ::scripts\aitypes\slasher\behaviors::followenemy_end;
  var_0._id_1581[10] = ::scripts\aitypes\slasher\behaviors::findenemy_tick;
  var_0._id_1581[11] = ::scripts\aitypes\slasher\behaviors::findenemy_begin;
  var_0._id_1581[12] = ::scripts\aitypes\slasher\behaviors::findenemy_end;
  level._id_119E["slasher"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("slasher");
}