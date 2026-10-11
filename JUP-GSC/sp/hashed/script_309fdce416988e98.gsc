/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_309fdce416988e98.gsc
*************************************************/

#using script_72ef6b9f0cf1f55a;
#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace compass_messaging;

function private autoexec __init__system__() {
  system::register(#"compass_messaging", #"hash_58f5dc856591d010", &pre_main, undefined);
}

function private pre_main() {
  if(!isDefined(level.compass_messaging)) {
    level.compass_messaging = spawnStruct();
  }

  level.compass_messaging.widget = function_6cd0a8e23ff14e13("scripted_widget_compass_area_display");
  level.compass_messaging.combos = [];
  scripts\common\ui::lui_registercallback("compass_area_display_simple_message_done", &function_e8b07426ecc4985d);
  function_38e800ec19177b32(["in_search_area", "restricted_area"], "in_restricted_search_area");
}

function function_38e800ec19177b32(combo_array, combo_param) {
  index = level.compass_messaging.combos.size;
  level.compass_messaging.combos[index] = spawnStruct();
  level.compass_messaging.combos[index].combo_array = combo_array;
  level.compass_messaging.combos[index].combo_param = combo_param;
}

function function_2d2bf9bf75ae791e(var_bd4d9cdcb3a696c8, message) {
  if(!isDefined(level.compass_messaging.widget)) {
    return;
  }

  if(!isDefined(self.compass_messaging)) {
    self.compass_messaging = spawnStruct();
    self.compass_messaging.messages = [];
  }

  if(isDefined(message)) {
    message = getlocstringindex(message);
  }

  if(isDefined(self.compass_messaging.messages[var_bd4d9cdcb3a696c8]) && (!isDefined(message) || array_contains(self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages, message))) {
    return;
  }

  function_995628fd8247db2f(var_bd4d9cdcb3a696c8, message);
}

function function_376aee39c931c5ff(var_bd4d9cdcb3a696c8, message) {
  if(isDefined(self.compass_messaging) && isDefined(self.compass_messaging.messages[var_bd4d9cdcb3a696c8])) {
    if(isDefined(message) && isistring(message)) {
      message = getlocstringindex(message);
    }

    if(!isDefined(message) || self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages.size == 1 && self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages[0] == message) {
      function_7c17bfd98aea6570(var_bd4d9cdcb3a696c8);
      return;
    }

    update = 0;

    if(self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages[0] == message) {
      update = 1;
    }

    self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages = array_remove(self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages, message);

    if(update) {
      function_8466c8d7d5bfa33a();
    }
  }
}

function function_716cd5eee423ff24() {
  self notify("compass_message_closed");
  self.compass_messaging = undefined;
  function_f2784cc23bce336("hide");
}

function function_f2784cc23bce336(state_str) {
  assertex(isDefined(state_str), "You must specify a state string defined in the <" + level.compass_messaging.widget + "> asset.");
  function_d28fa5295a04d555("compass_messaging", state_str);
}

function private function_e8b07426ecc4985d(val) {
  if(isDefined(self.compass_messaging.current_ref)) {
    function_376aee39c931c5ff(self.compass_messaging.current_ref, val);
  }
}

function private function_995628fd8247db2f(var_bd4d9cdcb3a696c8, message, is_combo) {
  if(!isDefined(is_combo)) {
    is_combo = 0;
  }

  if(!isDefined(self.compass_messaging.messages[var_bd4d9cdcb3a696c8])) {
    self.compass_messaging.messages[var_bd4d9cdcb3a696c8] = spawnStruct();
    self.compass_messaging.messages[var_bd4d9cdcb3a696c8].index = function_7be2b65191088c8a(level.compass_messaging.widget, var_bd4d9cdcb3a696c8);
    self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages = [];
    self.compass_messaging.messages[var_bd4d9cdcb3a696c8].is_combo = is_combo;
  }

  if(isDefined(message)) {
    self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages = array_add(self.compass_messaging.messages[var_bd4d9cdcb3a696c8].messages, message);
  }

  foreach(combo in level.compass_messaging.combos) {
    if(!isDefined(self.compass_messaging.messages[combo.combo_param])) {
      add_combo = 1;

      foreach(param in combo.combo_array) {
        if(!isDefined(self.compass_messaging.messages[param])) {
          add_combo = 0;
          break;
        }
      }

      if(add_combo) {
        function_995628fd8247db2f(combo.combo_param, undefined, 1);
      }
    }
  }

  if(!is_combo) {
    function_8466c8d7d5bfa33a();
  }
}

function private function_7c17bfd98aea6570(var_bd4d9cdcb3a696c8, recursing) {
  if(!isDefined(recursing)) {
    recursing = 0;
  }

  self notify("compass_message_removed_" + var_bd4d9cdcb3a696c8);
  self.compass_messaging.messages[var_bd4d9cdcb3a696c8] = undefined;

  foreach(combo in level.compass_messaging.combos) {
    if(isDefined(self.compass_messaging.messages[combo.combo_param]) && self.compass_messaging.messages[combo.combo_param].is_combo) {
      if(array_contains(combo.combo_array, var_bd4d9cdcb3a696c8)) {
        function_7c17bfd98aea6570(combo.combo_param, 1);
      }
    }
  }

  if(!recursing) {
    function_8466c8d7d5bfa33a();
  }
}

function private function_8466c8d7d5bfa33a() {
  if(self.compass_messaging.messages.size == 0) {
    function_716cd5eee423ff24();
    return;
  }

  highest_priority = -1;
  var_9bcb4f4973c9c5e6 = undefined;

  foreach(message in self.compass_messaging.messages) {
    if(message.index > highest_priority) {
      highest_priority = message.index;
      var_9bcb4f4973c9c5e6 = ref;
    }
  }

  if(isDefined(var_9bcb4f4973c9c5e6) && (!isDefined(self.compass_messaging.current_ref) || self.compass_messaging.current_ref != var_9bcb4f4973c9c5e6 || self.compass_messaging.messages[var_9bcb4f4973c9c5e6].messages.size > 0)) {
    function_309fb06c47e16c0f(var_9bcb4f4973c9c5e6);
  }
}

function private function_309fb06c47e16c0f(ref) {
  self.compass_messaging.current_ref = ref;
  message = self.compass_messaging.messages[ref];

  if(!function_ada0825249682644("compass_messaging")) {
    function_90de31b2cbef19f9("compass_messaging", level.compass_messaging.widget);
    function_f4c37324750dc183("compass_messaging", 0, 40, 1, 0, 1);
  }

  function_af4f62f0f944a8f1("compass_messaging", ref);
  function_f2784cc23bce336("show");
  fields = [];
  fields["message_param"] = default_to(array_get_first_item(message.messages), 0);
  function_14a0ee2aaf9128c3("compass_messaging", fields, 1);
}