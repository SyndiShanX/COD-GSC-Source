/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: wz_common\character_unlock_ajax.gsc
***********************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\system_shared;
#include scripts\mp_common\item_drop;
#include scripts\wz_common\character_unlock;
#include scripts\wz_common\character_unlock_fixup;

#namespace character_unlock_ajax;

autoexec __init__system__() {
  system::register(#"character_unlock_ajax", &__init__, undefined, #"character_unlock_ajax_fixup");
}

__init__() {
  character_unlock_fixup::function_90ee7a97(#"ajax_unlock", &function_2613aeec);
}

function_2613aeec(enabled) {
  if(enabled) {
    callback::add_callback(#"hash_48bcdfea6f43fecb", &function_1c4b5097);
    callback::add_callback(#"on_drop_item", &on_drop_item);
    callback::on_item_use(&on_item_use);
    item_drop::function_f3f9788a(#"cu01_item", 0.35);
  }
}

function_1c4b5097(item) {
  itementry = item.itementry;

  if(isDefined(itementry) && itementry.name === #"cu01_item") {
    var_b6015a5d = self function_b854ffba();

    if(var_b6015a5d >= 3 && self character_unlock::function_f0406288(#"ajax_unlock")) {
      self character_unlock::function_c8beca5e(#"ajax_unlock", #"hash_6e5a10ffa958d875", 1);
    }
  }
}

on_drop_item(params) {
  if(!isplayer(self)) {
    return;
  }

  itementry = params.item.itementry;
  deathstash = params.item.deathstash;

  if(isDefined(deathstash) && deathstash) {
    return;
  }

  if(isDefined(itementry) && itementry.name === #"cu01_item") {
    var_b6015a5d = self function_b854ffba();

    if(var_b6015a5d < 3 && self character_unlock::function_c70bcc7a(#"ajax_unlock")) {
      self character_unlock::function_c8beca5e(#"ajax_unlock", #"hash_6e5a10ffa958d875", 0);
    }
  }
}

on_item_use(params) {
  itementry = params.item.itementry;

  if(isDefined(itementry) && itementry.name === #"cu01_item") {
    if(self character_unlock::function_c70bcc7a(#"ajax_unlock")) {
      var_b6015a5d = self function_b854ffba();

      if(var_b6015a5d < 3) {
        self character_unlock::function_c8beca5e(#"ajax_unlock", #"hash_6e5a10ffa958d875", 0);
      }
    }
  }
}

private function_b854ffba() {
  var_b6015a5d = 0;

  if(isDefined(self.inventory) && isDefined(self.inventory.items)) {
    foreach(item in self.inventory.items) {
      itementry = item.itementry;

      if(isDefined(itementry) && itementry.name === #"cu01_item") {
        var_b6015a5d += item.count;
      }
    }
  }

  return var_b6015a5d;
}