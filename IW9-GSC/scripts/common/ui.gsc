/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ui.gsc
***********************************************/

lui_registercallback(_id_7148C1A6F25491F8, callback) {
  if(!isDefined(level.lui_callbacks))
    level.lui_callbacks = [];

  if(!isDefined(level.lui_callbacks[_id_7148C1A6F25491F8]) || !scripts\engine\utility::array_contains(level.lui_callbacks[_id_7148C1A6F25491F8], callback))
    level.lui_callbacks[_id_7148C1A6F25491F8] = scripts\engine\utility::array_add_safe(level.lui_callbacks[_id_7148C1A6F25491F8], callback);
}

lui_notify_callback(_id_7148C1A6F25491F8, value, _id_456C37B4CCDC86C4) {
  if(isDefined(self)) {
    if(isDefined(level.lui_callbacks) && isDefined(level.lui_callbacks[_id_7148C1A6F25491F8])) {
      foreach(callback in level.lui_callbacks[_id_7148C1A6F25491F8]) {
        if(isDefined(_id_456C37B4CCDC86C4)) {
          self thread[[callback]](value, _id_456C37B4CCDC86C4);
          continue;
        }

        self thread[[callback]](value);
      }
    }

    if(isDefined(_id_456C37B4CCDC86C4))
      self notify("luinotifyserver", _id_7148C1A6F25491F8, value, _id_456C37B4CCDC86C4);
    else
      self notify("luinotifyserver", _id_7148C1A6F25491F8, value);
  }
}