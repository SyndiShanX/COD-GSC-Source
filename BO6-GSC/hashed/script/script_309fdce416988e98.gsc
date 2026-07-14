/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_309fdce416988e98.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace compass_messaging;

function private autoexec __init__system__() {
  system::register(#"compass_messaging", undefined, undefined, &post_main);
}

function private post_main() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515") != 0 || getdvarint(@ "g_connectpaths") != 0) {
    return;
  }

  thread function_48b31ac91988d9ad();
}

function private function_48b31ac91988d9ad() {
  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(!isDefined(level.compass_messaging)) {
    level.compass_messaging = spawnStruct();
  }

  level.compass_messaging.widget = hud_management::function_a1a13273e72bfe46("\x1bx\x9b\x0f\x10x\x94;\x9cF\xf2v\x8a]\xf4T\xa0zN\x92\x90;}\xd5t$\xe8\bW\x9b{ch%\xf8<");
  level.compass_messaging.combos = [];
  level.compass_messaging.var_f510c4f96dfe543b = &function_4f38256bc7f086a7;
  level.compass_messaging.var_4d085ec06e095698 = &function_50fd58c68868292a;
  ui::lui_registercallback("\"\xed#H&\xb0\xd1\x15!6\x8a,#\xd6{\x12Kn\x81;\xd2F\xf1\xd2h\xd6\xb8\xcc\xa7n\x93\xd88T\xed\x9e2~\x85\x1d", &function_7c568db38ea28258);
  level utility::flag_set("0l7F\xc9\x9bt{z\x19\n\x88\xc7\x85\xb9yT\xa2;\xc4 t0!a\xb1,?\x9a");
  function_eb8f993dcfcb3c7b(["\xd2\xb9\xf5\x9be\v\x9c\xd8\xd0\xeb,Ne\v", "\xb7y'\x10\x80\x11{8\xcb\x90\x1f\xd5k\xb3\xf7"], "\x1ai\xf9\x18c\xf46k8Gob,F7\xbf\xa6\xda\xc3 \xe4+\xa0\xfaP");

  foreach(player in level.players) {
    player thread function_4399d8f14de13af8();
  }

  utility::callsharedfunc(#"aggregator", #"registeronplayerspawncallback", &onplayerrespawn);
}

function private onplayerrespawn() {
  thread function_4399d8f14de13af8();
}

function function_eb8f993dcfcb3c7b(combo_array, combo_param) {
  level utility::flag_wait("0l7F\xc9\x9bt{z\x19\n\x88\xc7\x85\xb9yT\xa2;\xc4 t0!a\xb1,?\x9a");
  index = level.compass_messaging.combos.size;
  level.compass_messaging.combos[index] = spawnStruct();
  level.compass_messaging.combos[index].combo_array = combo_array;
  level.compass_messaging.combos[index].combo_param = combo_param;
}

function function_4f38256bc7f086a7(var_1591651b8a1eeb31, message) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("0l7F\xc9\x9bt{z\x19\n\x88\xc7\x85\xb9yT\xa2;\xc4 t0!a\xb1,?\x9a");

  if(!isDefined(level.compass_messaging.widget)) {
    return;
  }

  if(!isDefined(self.compass_messaging)) {
    self.compass_messaging = spawnStruct();
    self.compass_messaging.messages = [];
  }

  if(isDefined(message)) {
    message = function_30e4f86dded0873(message);
  }

  if(isDefined(self.compass_messaging.messages[var_1591651b8a1eeb31]) && (!isDefined(message) || arraycontains(self.compass_messaging.messages[var_1591651b8a1eeb31].messages, message))) {
    return;
  }

  function_79acc20f8ab1721a(var_1591651b8a1eeb31, message);
}

function function_50fd58c68868292a(var_1591651b8a1eeb31, message) {
  if(isDefined(self.compass_messaging) && isDefined(self.compass_messaging.messages[var_1591651b8a1eeb31])) {
    if(isDefined(message) && isistring(message)) {
      message = function_30e4f86dded0873(message);
    }

    if(!isDefined(message) || self.compass_messaging.messages[var_1591651b8a1eeb31].messages.size == 1 && self.compass_messaging.messages[var_1591651b8a1eeb31].messages[0] == message) {
      function_c7e7aa3ba43179e5(var_1591651b8a1eeb31);
      return;
    }

    update = 0;

    if(self.compass_messaging.messages[var_1591651b8a1eeb31].messages[0] == message) {
      update = 1;
    }

    self.compass_messaging.messages[var_1591651b8a1eeb31].messages = arrayremove(self.compass_messaging.messages[var_1591651b8a1eeb31].messages, message);

    if(update) {
      function_9972ac318ac0a717();
    }
  }
}

function function_1445ac7a4540e71d() {
  self notify("\x8d\xf6[\x83\xb0s\xe6\xbem+nn\x85\x9d\xca\xeb\xd8l\xb7nYF");
  self.compass_messaging = undefined;
  function_902f5023be0de97b("\x19b\xc2y");
}

function function_902f5023be0de97b(state_str) {
  assert(isDefined(state_str), "<dev string:x24>" + getxhashsourcename(level.compass_messaging.widget) + "<dev string:x58>");
  hud_management::function_d8d634ceece460("\xa7.~Z}\xf17.\x84\f\x97\xa4\x91\xe9_?\xca", state_str);
}

function private function_4399d8f14de13af8() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");

  while(true) {
    self waittill("&\xdb\xe0Q\xf7i\xddL\x8d\x8f\xb2j\f\xe2P\x97\x17),\xd4\xa5\xcf\x8d", is_allowed);

    if(is_allowed) {
      function_9972ac318ac0a717();
    }
  }
}

function private function_7c568db38ea28258(val) {
  if(isDefined(self.compass_messaging.current_ref)) {
    function_50fd58c68868292a(self.compass_messaging.current_ref, val);
  }
}

function private function_79acc20f8ab1721a(var_1591651b8a1eeb31, message, is_combo = 0) {
  if(!isDefined(self.compass_messaging.messages[var_1591651b8a1eeb31])) {
    self.compass_messaging.messages[var_1591651b8a1eeb31] = spawnStruct();
    self.compass_messaging.messages[var_1591651b8a1eeb31].index = hud_management::function_b584f43317b07b57(level.compass_messaging.widget, var_1591651b8a1eeb31);
    self.compass_messaging.messages[var_1591651b8a1eeb31].messages = [];
    self.compass_messaging.messages[var_1591651b8a1eeb31].is_combo = is_combo;
  }

  if(isDefined(message)) {
    self.compass_messaging.messages[var_1591651b8a1eeb31].messages[self.compass_messaging.messages[var_1591651b8a1eeb31].messages.size] = message;
  }

  if(var_1591651b8a1eeb31 == "\xd2\xb9\xf5\x9be\v\x9c\xd8\xd0\xeb,Ne\v") {
    function_e462bcfa1021ff0e(1);
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
        function_79acc20f8ab1721a(combo.combo_param, undefined, 1);
      }
    }
  }

  if(!is_combo) {
    function_9972ac318ac0a717();
  }
}

function private function_c7e7aa3ba43179e5(var_1591651b8a1eeb31, recursing = 0) {
  self notify("(\x19\xdaV^\xe51\x8f\xbf\xd4\x89\xfe\xc7\xf20'\x16\x06=\xa5\xb3\x85\xc2\xff" + var_1591651b8a1eeb31);
  self.compass_messaging.messages[var_1591651b8a1eeb31] = undefined;

  if(var_1591651b8a1eeb31 == "\xd2\xb9\xf5\x9be\v\x9c\xd8\xd0\xeb,Ne\v") {
    function_e462bcfa1021ff0e(0);
  }

  foreach(combo in level.compass_messaging.combos) {
    if(isDefined(self.compass_messaging.messages[combo.combo_param]) && self.compass_messaging.messages[combo.combo_param].is_combo) {
      if(arraycontains(combo.combo_array, var_1591651b8a1eeb31)) {
        function_c7e7aa3ba43179e5(combo.combo_param, 1);
      }
    }
  }

  if(!recursing) {
    function_9972ac318ac0a717();
  }
}

function private function_9972ac318ac0a717() {
  if(!isDefined(self.compass_messaging)) {
    return;
  }

  if(self.compass_messaging.messages.size == 0) {
    function_1445ac7a4540e71d();
    return;
  }

  highest_priority = -1;
  var_a0eb0ddb38adb57b = undefined;

  foreach(message in self.compass_messaging.messages) {
    if(message.index > highest_priority) {
      highest_priority = message.index;
      var_a0eb0ddb38adb57b = ref;
    }
  }

  if(isDefined(var_a0eb0ddb38adb57b) && (!isDefined(self.compass_messaging.current_ref) || self.compass_messaging.current_ref != var_a0eb0ddb38adb57b || self.compass_messaging.messages[var_a0eb0ddb38adb57b].messages.size > 0)) {
    function_af10d36dd443d912(var_a0eb0ddb38adb57b);
  }
}

function private function_af10d36dd443d912(ref) {
  if(!val::get("&\xdb\xe0Q\xf7i\xddL\x8d\x8f\xb2j\f\xe2P\x97\x17),\xd4\xa5\xcf\x8d")) {
    return;
  }

  self.compass_messaging.current_ref = ref;
  message = self.compass_messaging.messages[ref];

  if(!hud_management::function_48c98ea9a4f0da89("\xa7.~Z}\xf17.\x84\f\x97\xa4\x91\xe9_?\xca")) {
    hud_management::function_35924dfcb78711f4("\xa7.~Z}\xf17.\x84\f\x97\xa4\x91\xe9_?\xca", level.compass_messaging.widget);
    hud_management::function_aaab83e8c950f455("\xa7.~Z}\xf17.\x84\f\x97\xa4\x91\xe9_?\xca", 3);
    hud_management::function_85d8a0ba2e35b6f2("\xa7.~Z}\xf17.\x84\f\x97\xa4\x91\xe9_?\xca", 0, 85, 1, 0, 1);
  }

  hud_management::function_b683400f784cb7dc("\xa7.~Z}\xf17.\x84\f\x97\xa4\x91\xe9_?\xca", ref);
  function_902f5023be0de97b("\xf1\xba\x8f\x9d");
  fields = [];
  fields["/\xba \f\x8c\xbe+\xc0\xfc *\xc1\xeb"] = utility::array_get_first_item(message.messages) ?? 0;
  hud_management::function_41ff479ac45608d6("\xa7.~Z}\xf17.\x84\f\x97\xa4\x91\xe9_?\xca", fields, 1);
}

function private function_e462bcfa1021ff0e(var_70af42811bedf354) {
  asnumeric = var_70af42811bedf354 ? 1 : 0;
  setomnvar("V]\x9dK\x9cP\x19\x8fu\xe8'\xc7!\xa5`\xcd}^\x1c\xe7\xfc\xc0X\x14", asnumeric);
}