/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\ui.gsc
**************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace ui;

function lui_registercallback(channel, callback) {
  if(!isDefined(level.lui_callbacks)) {
    level.lui_callbacks = [];
  }

  assert(isstring(channel) && channel != "<dev string:x24>" && isfunction(callback));

  if(!isDefined(level.lui_callbacks[channel]) || !arraycontains(level.lui_callbacks[channel], callback)) {
    if(!isDefined(level.lui_callbacks[channel])) {
      level.lui_callbacks[channel] = [];
    }

    level.lui_callbacks[channel][level.lui_callbacks[channel].size] = callback;
  }
}

function function_6c9f8c2a6da4d92b(channel, callback) {
  assert(utility::issp());
  assert(isstring(channel) && channel != "<dev string:x24>" && isfunction(callback));

  if(!isDefined(level.var_7885951511acf7b5)) {
    level.var_7885951511acf7b5 = [];
  }

  if(!isDefined(level.var_1042038ec3eff6a4)) {
    level.var_1042038ec3eff6a4 = [];
  }

  if(!isDefined(level.var_1042038ec3eff6a4[channel]) || !arraycontains(level.var_1042038ec3eff6a4[channel], callback)) {
    if(!isDefined(level.var_1042038ec3eff6a4[channel])) {
      level.var_1042038ec3eff6a4[channel] = [];
    }

    level.var_1042038ec3eff6a4[channel][level.var_1042038ec3eff6a4[channel].size] = callback;
  }
}

function function_770abf131329ffc7(channel, callback) {
  assert(isinfrontend());
  assert(isstring(channel) && channel != "<dev string:x24>" && isfunction(callback));

  if(!isDefined(level.var_8140645f7e3c6266)) {
    level.var_8140645f7e3c6266 = [];
  }

  if(!isDefined(level.var_8140645f7e3c6266[channel]) || !arraycontains(level.var_8140645f7e3c6266[channel], callback)) {
    if(!isDefined(level.var_8140645f7e3c6266[channel])) {
      level.var_8140645f7e3c6266[channel] = [];
    }

    level.var_8140645f7e3c6266[channel][level.var_8140645f7e3c6266[channel].size] = callback;
  }
}

function function_52f4e497797fadd8(channel) {
  if(!isDefined(level.var_1537394bb444852c)) {
    level.var_1537394bb444852c = [];
  }

  assert(isstring(channel) && channel != "<dev string:x24>");

  if(!isDefined(level.var_1537394bb444852c[channel])) {
    level.var_1537394bb444852c[channel] = channel;
  }
}

function event_handler[lui_callback] lui_notify_callback(channel, value, value2) {
  if(isDefined(self)) {
    if(isDefined(level.lui_callbacks) && isDefined(level.lui_callbacks[channel])) {
      foreach(callback in level.lui_callbacks[channel]) {
        self.var_b458a7ace288c777 = channel;

        if(isDefined(value2)) {
          self thread[[callback]](value, value2);
          continue;
        }

        self thread[[callback]](value);
      }
    } else if(isDefined(level.var_1537394bb444852c) && isDefined(level.var_1537394bb444852c[channel])) {
      if(value) {
        utility::flag_set(channel);
      } else {
        utility::flag_clear(channel);
      }
    }

    if(utility::issp()) {
      args = strtok(channel, ",");
      channelarg = args[0];

      if(isDefined(level.var_1042038ec3eff6a4) && isDefined(level.var_1042038ec3eff6a4[channelarg])) {
        foreach(callback in level.var_1042038ec3eff6a4[channelarg]) {
          if(isDefined(value2)) {
            self thread[[callback]](value, value2, args);
            continue;
          }

          self thread[[callback]](value, args);
        }
      }
    }

    if(isinfrontend()) {
      args = strtok(channel, ",", 1);
      channelarg = args[0];

      if(isDefined(level.var_8140645f7e3c6266) && isDefined(level.var_8140645f7e3c6266[channelarg])) {
        foreach(callback in level.var_8140645f7e3c6266[channelarg]) {
          if(isDefined(value2)) {
            self thread[[callback]](value, value2, args);
            continue;
          }

          self thread[[callback]](value, args);
        }
      }
    }

    thread debugnotify(channel);

    if(isDefined(value2)) {
      self notify("luinotifyserver", channel, value, value2);
      return;
    }

    self notify("luinotifyserver", channel, value);
  }
}

function function_ca488d3659619c7(shouldbevisible = 1) {
  asnumeric = shouldbevisible ? 1 : 0;
  setomnvar("ui_toggle_subtitle_visibility", asnumeric);
}

function debugnotify(channel) {
  if(isDefined(self.luinotify)) {
    println("<dev string:x28>" + self.luinotify + "<dev string:x41>" + channel);
  }

  self.luinotify = channel;
  waittillframeend();
  self.luinotify = undefined;
}

# /