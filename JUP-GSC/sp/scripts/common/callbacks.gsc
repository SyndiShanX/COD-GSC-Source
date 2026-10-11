/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\callbacks.gsc
***********************************************/

#using scripts\engine\utility;
#namespace callback;

function callback(event, params) {
  if(!isDefined(params)) {
    params = spawnStruct();
  }

  assertex(isstruct(params), "Callbacks should always use a struct to pass parameters.");
  function_f3847410a67a3098(level, event, params);

  if(self != level) {
    function_f3847410a67a3098(self, event, params);

    if(isDefined(self.var_8d44c0f367e8d9c0)) {
      foreach(callback_template in self.var_8d44c0f367e8d9c0) {
        function_f3847410a67a3098(callback_template, event, params);
      }
    }
  }
}

function function_1ad95d714a56c8fa(event, params) {
  ais = getaiarray();

  foreach(ai in ais) {
    ai function_f3847410a67a3098(ai, event, params);
  }
}

function function_ca1462b402444dd6(event, params) {
  players = level.players;

  foreach(player in players) {
    player function_f3847410a67a3098(level, event, params);
    player function_f3847410a67a3098(player, event, params);
  }
}

function private function_f3847410a67a3098(ent, event, params) {
  callbacks = undefined;

  if(isDefined(ent.callbacks)) {
    callbacks = ent.callbacks[event];
  }

  if(isDefined(callbacks)) {
    for(i = 0; i < callbacks.size; i++) {
      callback_fields = callbacks[i];

      if(!isarray(callback_fields)) {
        continue;
      }

      callback = callback_fields[0];
      assert(isfunction(callback));

      if(!isfunction(callback)) {
        return;
      }

      var_732ad454c46f92fd = callback_fields[1];

      if(isDefined(var_732ad454c46f92fd)) {
        self thread[[callback]](params, var_732ad454c46f92fd);
        continue;
      }

      self thread[[callback]](params);
    }

    if(isDefined(ent.callbacks)) {
      ent.callbacks[event] = function_816601f7d8ca5b92(ent.callbacks[event]);
    }
  }
}

function add(event, func, var_732ad454c46f92fd) {
  assertex(isfunction(func), "Parameter for event '" + (isxhash(event) ? getxhashsourcename(event) : event) + "' is not a function pointer.");

  if(!isfunction(func)) {
    return;
  }

  assertex(isDefined(event), "Trying to set a callback on an undefined event.");

  if(!isDefined(self.callbacks) || !isDefined(self.callbacks[event])) {
    self.callbacks[event] = [];
  }

  foreach(callback in self.callbacks[event]) {
    if(isarray(callback) && callback[0] == func) {
      if(!isDefined(callback[1]) && !isDefined(var_732ad454c46f92fd) || is_equal(callback[1], var_732ad454c46f92fd)) {
        assertmsg("<dev string:x1c>" + event);
      }
    }
  }

  self.callbacks[event][self.callbacks[event].size] = [func, var_732ad454c46f92fd];
}

function remove(event, func, instant) {
  if(!isDefined(self.callbacks)) {
    return;
  }

  assertex(isDefined(event), "Trying to remove a callback on an undefined event.");

  if(isDefined(func) && isxhash(func) && func == #"all") {
    self.callbacks[event] = [];
    return;
  }

  if(!isDefined(self.callbacks[event])) {
    return;
  }

  foreach(func_group in self.callbacks[event]) {
    if(isarray(func_group) && func_group[0] == func) {
      self.callbacks[event][index] = 0;
      break;
    }
  }

  if(istrue(instant)) {
    self.callbacks[event] = function_816601f7d8ca5b92(self.callbacks[event]);
  }
}

function get_template(template_name) {
  if(!isDefined(level.callback_templates)) {
    level.callback_templates = [];
  }

  if(!isDefined(level.callback_templates[template_name])) {
    level.callback_templates[template_name] = spawnStruct();
  }

  return level.callback_templates[template_name];
}

function function_d4f1fdfa332469ec(template_name) {
  assertex(self != level, "<dev string:x4a>");
  template_struct = get_template(template_name);

  if(!isDefined(self.var_8d44c0f367e8d9c0) || !isDefined(self.var_8d44c0f367e8d9c0[template_name])) {
    self.var_8d44c0f367e8d9c0[template_name] = template_struct;
  }
}

function function_75a459cce09d9f29(template_name) {
  return self != level && isDefined(template_name) && isDefined(level.callback_templates) && isDefined(level.callback_templates[template_name]) && isDefined(self.var_8d44c0f367e8d9c0) && isDefined(self.var_8d44c0f367e8d9c0[template_name]) && self.var_8d44c0f367e8d9c0[template_name] == level.callback_templates[template_name];
}

function private function_816601f7d8ca5b92(callbacks) {
  result = [];

  foreach(cb in callbacks) {
    if(isint(cb) && cb == 0) {
      continue;
    }

    result[result.size] = cb;
  }

  return result;
}