/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1366.gsc
**************************************/

init() {
  level thread maps\mp\_utility::_id_6F74(::_id_5330);
}

_id_5330() {
  if(!isbot(self)) {
    self._id_7871 = [];
    thread _id_63A0();
    thread _id_63FA();
  }
}

_id_A6B8() {
  while(!isDefined(self._id_7871)) {
    waitframe();
  }

  waitframe();
}

_id_63A0() {
  self endon("disconnect");
  self._id_293A = -1;
  self setclientomnvar("ui_zm_selected_quest_item", self._id_293A);
  self setclientomnvar("ui_zm_owns_quest_items", 0);
}

_id_63FA() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_change", var_0);
    var_1 = 0;
    var_2 = -1;

    foreach(var_5, var_4 in self._id_7871) {
      if(var_4.name == var_0) {
        self._id_293A = var_5;
        var_2 = var_4._id_502A;
        var_1 = 1;
        break;
      }
    }

    if(!var_1) {
      self._id_293A = -1;
    }

    self setclientomnvar("ui_zm_selected_quest_item", var_2);
  }
}

_id_4B71(var_0) {
  var_1 = 0;

  if(isDefined(self._id_7871)) {
    foreach(var_4, var_3 in self._id_7871) {
      if(var_3._id_7B79 == var_0) {
        var_1 = 1;
      }
    }
  }

  return var_1;
}

getbasequestitemname(var_0) {
  if(!_id_0547::_id_5843(var_0)) {
    return var_0;
  }

  var_1 = _id_0547::_id_AAF9(var_0, 0, 0);
  return var_1;
}

_id_24DD(var_0, var_1, var_2) {
  var_0 = getbasequestitemname(var_0);

  if(_id_4B71(var_0)) {
    return;
  }
  var_3 = spawnStruct();
  var_3.name = var_1;
  var_3._id_7B79 = var_0;
  var_3._id_0CAF = var_2;
  self._id_7871 = common_scripts\utility::_id_0F6F(self._id_7871, var_3);
  var_4 = int(tablelookup("mp/zombieUsableQuestItems.csv", 1, var_0, 0));
  var_3._id_502A = var_4;
  self setclientomnvar("ui_zm_owns_quest_items", var_4);
}

_id_5F16(var_0) {
  var_0 = getbasequestitemname(var_0);

  if(isDefined(self._id_7871)) {
    foreach(var_4, var_2 in self._id_7871) {
      if(var_2._id_7B79 == var_0 || isDefined(var_2._id_0CAF) && var_0 == var_2._id_0CAF) {
        self._id_7871 = common_scripts\utility::_id_0F9A(self._id_7871, var_4);
        var_3 = int(tablelookup("mp/zombieUsableQuestItems.csv", 1, var_0, 0));
        self setclientomnvar("ui_zm_owns_quest_items", var_3);
        self._id_293A = -1;
        self setclientomnvar("ui_zm_selected_quest_item", self._id_293A);
        break;
      }
    }
  }
}