/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_436add9de781cdfb.gsc
***********************************************/

init() {
  if(!isDefined(level._id_CBF08F5916CAB0B0))
    level._id_CBF08F5916CAB0B0 = [];

  level thread _id_5B1D60872D5F7D1F();
}

_id_5B1D60872D5F7D1F() {
  for(;;) {
    level waittill("connected", player);
    player thread _id_030AE32F045A9401();
  }
}

_id_3A363AE38F309166(callback) {
  if(!isDefined(level._id_CBF08F5916CAB0B0))
    level._id_CBF08F5916CAB0B0 = [];

  level._id_CBF08F5916CAB0B0[level._id_CBF08F5916CAB0B0.size] = callback;
}

_id_C954B1A939FEAE65(_id_31AB61E6884F3BC2) {
  _id_50F783A5617F8940 = [];

  foreach(callback in level._id_CBF08F5916CAB0B0) {
    if(_id_31AB61E6884F3BC2 != callback)
      _id_50F783A5617F8940[_id_50F783A5617F8940.size] = callback;
  }

  level._id_CBF08F5916CAB0B0 = _id_50F783A5617F8940;
}

_id_030AE32F045A9401() {
  self endon("disconnect");

  for(;;) {
    self waittill("reload_start");

    foreach(callback in level._id_CBF08F5916CAB0B0)
    self[[callback]]();
  }
}