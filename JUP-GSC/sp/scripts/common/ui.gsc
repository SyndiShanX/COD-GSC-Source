/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\ui.gsc
***********************************************/



#using scripts\engine\utility;
#namespace ui;

function lui_registercallback(channel, callback) {
  if(!isDefined(level.lui_callbacks)) {
    level.lui_callbacks = [];
  }

  assert(isstring(channel) && channel != "" && isfunction(callback));

  if(!isDefined(level.lui_callbacks[channel]) || !array_contains(level.lui_callbacks[channel], callback)) {
    level.lui_callbacks[channel] = array_add_safe(level.lui_callbacks[channel], callback);
  }
}

function lui_notify_callback(channel, value, value2) {
  if(isDefined(self)) {
    if(isDefined(level.lui_callbacks) && isDefined(level.lui_callbacks[channel])) {
      foreach(callback in level.lui_callbacks[channel]) {
        if(isDefined(value2)) {
          self thread[[callback]](value, value2);
          continue;
        }

        self thread[[callback]](value);
      }
    }

    if(isDefined(value2)) {
      self notify("luinotifyserver", channel, value, value2);
      return;
    }

    self notify("luinotifyserver", channel, value);
  }
}