/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_57c654576cdec173.gsc
***********************************************/

_id_689BD8AE264F0531(_id_649F9B194DF395CD) {
  if(!isDefined(level.br_armory_kiosk))
    return undefined;

  _id_03681B432675353B = undefined;

  foreach(item in level.br_armory_kiosk.items) {
    if(item.cost < _id_03681B432675353B.cost || !isDefined(_id_03681B432675353B)) {
      if(isDefined(_id_649F9B194DF395CD) && _id_649F9B194DF395CD && item.cost == 0) {
        continue;
      }
      _id_03681B432675353B = item;
    }
  }

  return _id_03681B432675353B;
}

_id_380DFD54B395EC1B(_id_2CE272546E3AE7F0) {
  if(!isDefined(self))
    return undefined;

  foreach(item in self.items) {
    if(item._id_2CE272546E3AE7F0 == _id_2CE272546E3AE7F0)
      return item.cost;
  }

  return undefined;
}

_id_CD83759E21F3FF42(callback) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, class);

    if(_id_7148C1A6F25491F8 == "buy_menu_open") {
      self[[callback]]();
      return;
    }
  }
}

_id_B40F17685DBCC4E6(callback) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, class);

    if(_id_7148C1A6F25491F8 == "br_cancel_purchase") {
      self[[callback]]();
      return;
    }

    if(_id_7148C1A6F25491F8 == "br_item_purchase" || _id_7148C1A6F25491F8 == "br_loadout_purchase") {
      if(getdvarint("dvar_ED6E4FFA933AF621", 0) == 0) {
        self[[callback]]();
        return;
      }
    }
  }
}

_id_DADEE81D5CE668BD(callback, _id_0D24AF1A0B7BC04D) {
  self endon("death");
  self endon("disconnect");

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, class);

    if(_id_7148C1A6F25491F8 == "br_item_purchase" || _id_7148C1A6F25491F8 == "br_loadout_purchase" || _id_7148C1A6F25491F8 == "br_team_revive") {
      _id_A365E25AA9D7BCDA = level.br_armory_kiosk.items[class];

      if(isDefined(_id_0D24AF1A0B7BC04D)) {
        if(isDefined(_id_A365E25AA9D7BCDA) && _id_A365E25AA9D7BCDA.type == _id_0D24AF1A0B7BC04D) {
          self[[callback]]();
          return;
        }
      } else {
        self[[callback]]();
        return;
      }
    }
  }
}

_id_4BFC467C67D38FE0(callback, _id_8E87A15650C9E63F) {
  self endon("death");
  self endon("disconnect");
  _id_3793828403C6873E = 0;

  if(isDefined(_id_8E87A15650C9E63F))
    _id_3793828403C6873E = level.br_armory_kiosk _id_0F7826C1D489E51E(_id_8E87A15650C9E63F);

  for(;;) {
    self waittill("luinotifyserver", _id_7148C1A6F25491F8, id);

    if(_id_7148C1A6F25491F8 == "buy_menu_option_selected") {
      if(isDefined(_id_8E87A15650C9E63F)) {
        if(_id_3793828403C6873E == id) {
          self[[callback]]();
          return;
        }
      } else {
        self[[callback]]();
        return;
      }
    }

    waitframe();
  }
}

_id_0F7826C1D489E51E(_id_CB325DDB4A764623) {
  if(!isDefined(self))
    return undefined;

  for(index = 0; index < self.items.size; index++) {
    if(self.items[index]._id_2CE272546E3AE7F0 == _id_CB325DDB4A764623)
      return index;
  }

  return undefined;
}