/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: behaviortree\pamgrier.gsc
**************************************/

_id_2AD0() {
  if(isDefined(level._id_119E["pamgrier"])) {
    return;
  }
  var_0 = spawnStruct();
  var_0._id_1581 = [];
  var_0._id_1581[0] = ::scripts\aitypes\pamgrier\behaviors::init;
  var_0._id_1581[1] = ::scripts\aitypes\pamgrier\behaviors::updateeveryframe;
  var_0._id_1581[2] = _id_0C2B::_id_3E48;
  var_0._id_1581[3] = ::scripts\aitypes\pamgrier\behaviors::decideaction;
  var_0._id_1581[4] = ::scripts\aitypes\pamgrier\behaviors::doaction_tick;
  var_0._id_1581[5] = ::scripts\aitypes\pamgrier\behaviors::doaction_begin;
  var_0._id_1581[6] = ::scripts\aitypes\pamgrier\behaviors::doaction_end;
  var_0._id_1581[7] = ::scripts\aitypes\pamgrier\behaviors::followenemy_tick;
  var_0._id_1581[8] = ::scripts\aitypes\pamgrier\behaviors::followenemy_begin;
  var_0._id_1581[9] = ::scripts\aitypes\pamgrier\behaviors::followenemy_end;
  level._id_119E["pamgrier"] = var_0;
}

_id_DEE8() {
  _id_2AD0();
  btregistertree("pamgrier");
}