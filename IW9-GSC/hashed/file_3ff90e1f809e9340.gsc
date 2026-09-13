/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_3ff90e1f809e9340.gsc
***********************************************/

_id_59DED31F4834F8DE(callback) {
  _id_38202445901A52D4(callback, 0);
}

_id_7D664CE89C1009CA(callback) {
  _id_38202445901A52D4(callback, 1);
}

_id_85DDCAC5EDED3985(_id_3793828403C6873E, callback) {
  _id_6C2A61AA8EC80C16(_id_3793828403C6873E, callback);
}

_id_BD09B7D6832880C4(callback, itemtype) {
  _id_13AEE3D35BD71F6B(callback, itemtype);
}

_id_38202445901A52D4(callback, _id_7C075EBCA2F22B7B) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, action);

    if(_id_7148C1A6F25491F8 == "inventory_action") {
      if(action == _id_7C075EBCA2F22B7B) {
        self[[callback]]();
        return;
      }
    }

    waitframe();
  }
}

_id_6C2A61AA8EC80C16(item, callback) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, _id_3793828403C6873E);

    if(_id_7148C1A6F25491F8 == "inventory_select_option") {
      if(item == _id_3793828403C6873E) {
        self[[callback]](_id_3793828403C6873E);
        return;
      }
    }

    waitframe();
  }
}

_id_13AEE3D35BD71F6B(callback, itemtype) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, id);

    if(_id_7148C1A6F25491F8 != "drop_all_items" && _id_7148C1A6F25491F8 != "drop_item") {
      continue;
    }
    _id_53AAAE2C915F815B = _id_7148C1A6F25491F8 == "drop_all_items";
    _id_04C119A29C3F6914 = _id_1E4A61DB11011446::_id_86081F65C04E8EBE(id);
    _id_49136C32CEB59180 = _id_1E4A61DB11011446::_id_AB41ACC7AC2F6642(id);

    if(isDefined(itemtype)) {
      if(_id_04C119A29C3F6914 == itemtype)
        self[[callback]](id, _id_04C119A29C3F6914, _id_49136C32CEB59180, _id_53AAAE2C915F815B);

      return;
    }

    self[[callback]](id, _id_04C119A29C3F6914, _id_49136C32CEB59180, _id_53AAAE2C915F815B);
    return;
  }
}