/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_15c10cf294641928.gsc
***********************************************/

_id_80E9E5AE4DE38D22(player, position, callback) {
  _id_C46075DFA7CA36D4 = _id_4D5A55FCA0ED1835::getdropbagspawntypeenum(0, 0, 0, 0, 0, 1);
  player _id_4D5A55FCA0ED1835::spawndropbagatposition(position, _id_C46075DFA7CA36D4);
  level thread _id_4D5A55FCA0ED1835::managedropbags();

  if(isDefined(callback))
    player thread _id_9F43FC17CA294D1B(callback);
}

_id_83964876B5D39A1E() {
  return level.br_pickups.crates;
}

_id_4AE36036BF751ABE(callback) {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, class);

    if(_id_7148C1A6F25491F8 == "open_loadout_bag") {
      self[[callback]]();
      return;
    }

    waitframe();
  }
}

_id_43A9B7793648C22A(callback) {
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, class);

    if(_id_7148C1A6F25491F8 == "exit_loadout_bag") {
      self[[callback]](-1);
      return;
    } else if(_id_7148C1A6F25491F8 == "class_select") {
      self[[callback]](class);
      return;
    }

    waitframe();
  }
}

_id_9F43FC17CA294D1B(callback) {
  self endon("death");
  self endon("disconnect");
  _id_26462D8FCD79EB0C = level.br_pickups.crates.size;

  while(_id_26462D8FCD79EB0C == level.br_pickups.crates.size) {
    waitframe();

    if(level.br_pickups.crates.size < _id_26462D8FCD79EB0C)
      _id_26462D8FCD79EB0C = level.br_pickups.crates.size;
  }

  self[[callback]](level.br_pickups.crates);
}