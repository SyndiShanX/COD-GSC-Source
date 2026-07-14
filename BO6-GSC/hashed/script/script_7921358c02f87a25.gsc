/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_7921358c02f87a25.gsc
*****************************************************/

#using scripts\common\system;
#using scripts\common\ui;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace namespace_7f07c02a991efda5;

function private autoexec __init__system__() {
  system::register(#"hudcountdown", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_ab8f389f2bf1ee12();
}

function private function_ab8f389f2bf1ee12() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");
  ui::lui_registercallback("\xb0\x9e\x83$\x80\x1c\x04\xd7\x10\xfe\x8bg\x9b\x90C", &set_started);
  ui::lui_registercallback("$\xacz\xed\xfc.\x17\xc1\x06am\xa0\xfd", &function_4fc65d0291e15f24);
  level utility::flag_set("F\f\x1f \xafa\xcd\xc4f\x03\a\x19\xb6\xd7P\x87J1\xe1\xa7\xf5]\xaa\xf6H");
}

function private function_5e59d832da8014fc(int_countdown = 0, var_b6b463d1d46024ec = undefined, str_msg = undefined, var_8dd496afceb9498c = 1) {
  if(!isDefined(self.countdown_data)) {
    self.countdown_data = {};
    self.countdown_data.int_countdown = int_countdown;
    self.countdown_data.var_b6b463d1d46024ec = isDefined(var_b6b463d1d46024ec) ? var_b6b463d1d46024ec : 1;
    self.countdown_data.str_msg = str_msg;
    self.countdown_data.var_8dd496afceb9498c = var_8dd496afceb9498c;
  }
}

function private function_3e8868db1c4e5e40() {
  fields = [];
  fields["\xae\x90\xf8^}\x99\xe5p\xb8"] = self.countdown_data.int_countdown;
  fields["\x16\x1a\xc7\x1f\x1d`Yi&\x99\xfc\x8d\x9c\x9f"] = self.countdown_data.var_b6b463d1d46024ec;
  fields["(1\xe7\xcb\xb6E\xe2\xef\x18\xb50X?k\xd6\x06\x17E\x8c\xae\xf8\xc4\xc1"] = isDefined(self.countdown_data.str_msg) ? function_30e4f86dded0873(self.countdown_data.str_msg) : undefined;
  fields["FV\xe9IX\x8dsW\x18\xf0\x97"] = self.countdown_data.var_8dd496afceb9498c;
  return fields;
}

function private function_dde0be00114bb72d(cancel_notify) {
  self endon("$\xacz\xed\xfc.\x17\xc1\x06am\xa0\xfd");
  self waittill(cancel_notify);
  function_4fc65d0291e15f24();
}

function private function_39406dab6f6cb64a(var_dabc1aa9e3233010, init_struct = undefined) {
  if(!hud_management::function_48c98ea9a4f0da89("\xa14s\xe4=Q6JA\x17\xc6\xfc\xd5\x17\\\xc4\x86\xb4\x95\xd0\xa0\x81\n\xc5\x9c")) {
    var_ad34dc0b4dddaa51 = hud_management::function_a1a13273e72bfe46("\xa14s\xe4=Q6JA\x17\xc6\xfc\xd5\x17\\\xc4\x86\xb4\x95\xd0\xa0\x81\n\xc5\x9c");
    hud_management::function_35924dfcb78711f4("\x81T\xe0O\x96]x\x06\n\xb1\xbd\xe6N-R\x89", var_ad34dc0b4dddaa51, init_struct);
    hud_management::function_d8d634ceece460("\x81T\xe0O\x96]x\x06\n\xb1\xbd\xe6N-R\x89", var_dabc1aa9e3233010);
  }

  fields = function_3e8868db1c4e5e40();
  hud_management::function_41ff479ac45608d6("\x81T\xe0O\x96]x\x06\n\xb1\xbd\xe6N-R\x89", fields, 0);
}

function function_4b14801d0a7f438(int_countdown, var_dabc1aa9e3233010 = "\xfc\x91\xcd\xec\xddz\xf4\xabRw\xa45XYkb\x90#\xb9\xf1\x85>g\xab\xb7\xd20", cancel_notify, var_b6b463d1d46024ec = 1, str_msg = undefined, initial_param = undefined, var_8dd496afceb9498c = 1) {
  function_5e59d832da8014fc(int_countdown, var_b6b463d1d46024ec, str_msg, var_8dd496afceb9498c);

  if(isstring(initial_param)) {
    init_struct = spawnStruct();
    init_struct.param = initial_param;
  }

  function_39406dab6f6cb64a(var_dabc1aa9e3233010, init_struct);

  if(isDefined(cancel_notify)) {
    thread function_dde0be00114bb72d(cancel_notify);
  }
}

function init_count(var_33ca2b5812fdc768, var_dabc1aa9e3233010 = "\xa7 FJF\x8f\xc1U^\xe9k\x14\x8d\x8d\x8c\xe2[S\x05\xd6A=\xeb\xcc\x0fY\x9d", cancel_notify, var_b6b463d1d46024ec = 1, str_msg = undefined, initial_param = undefined, var_8dd496afceb9498c = 1) {
  function_5e59d832da8014fc(var_33ca2b5812fdc768, var_b6b463d1d46024ec, str_msg, var_8dd496afceb9498c);

  if(isstring(initial_param)) {
    init_struct = spawnStruct();
    init_struct.param = initial_param;
  }

  function_39406dab6f6cb64a(var_dabc1aa9e3233010, init_struct);

  if(isDefined(cancel_notify)) {
    thread function_dde0be00114bb72d(cancel_notify);
  }
}

function function_4253adc7555e73b2(str_msg) {
  assert(isstring(str_msg) && isDefined(self.countdown_data));
  self.countdown_data.str_msg = str_msg;
  hud_management::function_d3b457baa69dec73("\x81T\xe0O\x96]x\x06\n\xb1\xbd\xe6N-R\x89", "(1\xe7\xcb\xb6E\xe2\xef\x18\xb50X?k\xd6\x06\x17E\x8c\xae\xf8\xc4\xc1", function_30e4f86dded0873(str_msg));
}

function update_count(var_3bfdd98cf2076b65) {
  assert(isint(var_3bfdd98cf2076b65) && isDefined(self.countdown_data));
  self.countdown_data.int_count = var_3bfdd98cf2076b65;
  hud_management::function_d3b457baa69dec73("\x81T\xe0O\x96]x\x06\n\xb1\xbd\xe6N-R\x89", "\xae\x90\xf8^}\x99\xe5p\xb8", var_3bfdd98cf2076b65);
}

function function_199b92a398f5660c(var_f7a95deee99e3814) {
  assert(isstring(var_f7a95deee99e3814) && isDefined(self.countdown_data));
  hud_management::function_d8d634ceece460("\x81T\xe0O\x96]x\x06\n\xb1\xbd\xe6N-R\x89", var_f7a95deee99e3814);
}

function function_4fc65d0291e15f24(val) {
  hud_management::scripted_widget_destroy("\x81T\xe0O\x96]x\x06\n\xb1\xbd\xe6N-R\x89");
  self.countdown_data = undefined;
  waitframe();
  self notify("$\xacz\xed\xfc.\x17\xc1\x06am\xa0\xfd");
}

function private set_started(val) {
  level notify("\xb0\x9e\x83$\x80\x1c\x04\xd7\x10\xfe\x8bg\x9b\x90C");
}