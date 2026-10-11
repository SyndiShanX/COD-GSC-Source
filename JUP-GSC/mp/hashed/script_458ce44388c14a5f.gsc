/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_458ce44388c14a5f.gsc
*************************************************/

#using scripts\mp\gametypes\br;
#namespace ftue_inventory;

function function_59ded31f4834f8de(callback) {
  function_38202445901a52d4(callback, 0);
}

function function_7d664ce89c1009ca(callback) {
  function_38202445901a52d4(callback, 1);
}

function function_85ddcac5eded3985(itemindex, callback) {
  function_6c2a61aa8ec80c16(itemindex, callback);
}

function function_bd09b7d6832880c4(callback, itemtype) {
  function_13aee3d35bd71f6b(callback, itemtype);
}

function private function_38202445901a52d4(callback, typeaction) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, action);

    if(channel == "inventory_action") {
      if(action == typeaction) {
        self[[callback]]();
        return;
      }
    }

    waitframe();
  }
}

function private function_6c2a61aa8ec80c16(item, callback) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  assert(isDefined(item));

  while(true) {
    self waittill("luinotifyserver", channel, itemindex);

    if(channel == "inventory_select_option") {
      if(item == itemindex) {
        self[[callback]](itemindex);
        return;
      }
    }

    waitframe();
  }
}

function private function_13aee3d35bd71f6b(callback, itemtype) {
  level endon("game_ended");
  self endon("death_or_disconnect");

  while(true) {
    self waittill("luinotifyserver", channel, id);

    if(channel != "drop_all_items" && channel != "drop_item") {
      continue;
    }

    dropall = channel == "drop_all_items";
    itemtypedropped = getinventoryitemtype(id);
    itemindexdropped = function_ab41acc7ac2f6642(id);

    if(isDefined(itemtype)) {
      if(itemtypedropped == itemtype) {
        self[[callback]](id, itemtypedropped, itemindexdropped, dropall);
      }

      return;
    }

    self[[callback]](id, itemtypedropped, itemindexdropped, dropall);
    return;
  }
}