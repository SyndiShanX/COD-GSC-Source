/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_782c244f72aad82a.gsc
*****************************************************/

#using scripts\common\queue;
#using scripts\common\system;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#namespace hud_notification;

function private autoexec __init__system__() {
  system::register(#"hud_notification", undefined, undefined, &post_main);
}

function private post_main() {
  thread function_8cf5dda1d60171dc();
}

function private function_8cf5dda1d60171dc() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515", 0) != 0) {
    return;
  }

  level utility::flag_wait("\x1b\x9a\xb5p\xb5E\xdfV0\x9b\xe6{\x89\xd1\xd9\xfb\x9ez\xb0P\xf8\xf6AT\xf70w9");

  if(!isDefined(level.hud_notification)) {
    level.hud_notification = spawnStruct();
  }

  level.hud_notification.widget = hud_management::function_a1a13273e72bfe46("\x1f\x80\xeemk\t\x9eY]\x9a\xa3\xc7_\xd7v=\xe7\xb4\xcc\x7f\x03\xe5\x92\x15w\x91&\x17=\xc3\x1b\xfb");
  level utility::flag_set("b\xac|\x12\ao.\xa3\x8bDN\xe5`\xe6\xe2\xb6\xfcH\xb5\r\xa9_/\x01&v\xe2\xaa");
}

function show_notification(message_title, message_desc, var_28e6251a6ded0bb4, timeout, var_671bf70d6a070853, var_61ef3d357eaf64d4) {
  assert(isDefined(message_title), "<dev string:x24>");
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("b\xac|\x12\ao.\xa3\x8bDN\xe5`\xe6\xe2\xb6\xfcH\xb5\r\xa9_/\x01&v\xe2\xaa");

  if(!isDefined(level.hud_notification.widget)) {
    return;
  }

  archetype_fields = [];
  archetype_fields["\xed\x0f\xb6\xb1\xb6\x82\xd2\x1b,8\xa3Z|k\xcb\x05\xee\x93:\xd3\xa9"] = message_title ? function_30e4f86dded0873(message_title) : undefined;
  archetype_fields["(1\xe7\xcb\xb6E\xe2\xef\x18\xb50X?k\xd6\x06\x17E\x8c\xae\xf8\xc4\xc1"] = message_desc ? function_30e4f86dded0873(message_desc) : undefined;
  data = {
    #var_61ef3d357eaf64d4: var_61ef3d357eaf64d4, #var_671bf70d6a070853: var_671bf70d6a070853, #timeout: timeout, #archetype_fields: archetype_fields, #param: var_28e6251a6ded0bb4, #widget: level.hud_notification.widget, #ref: "\rW#_\xdc\xf6t-\x99Zl\v:i{\x9b"};
  thread function_d38a85726cad0943(data);
}

function function_90f5d2120c11889d(challenge_index, timeout = 5, is_blueprint = 0) {
  archetype_fields["d]\x16\xec\xef:Q\reE\x91\x13\x18\x8d\x98[gu\xd7y\xb8\xf5\x85\xa6y\xbb\x10U\xc2\xd9"] = challenge_index;
  archetype_fields["\xd3\xd9_xJ\x97(\x19DGE*"] = is_blueprint;
  function_6253b68335c33631("\xbfP\xce\xcf~\xec\x8e5\x98\x92\xe4\xf72l\xb4\xc4\xba\x7f\xceYwI\xd2[\xa7\xae\xbd!H\x16\xef.\xe0\xff\xebM\xcfT\x01\xa2\xd2;\x8f\xf7\n\x1f\xf4", archetype_fields, undefined, timeout);
}

function function_6253b68335c33631(widget_asset, archetype_fields, widget_param, timeout, var_671bf70d6a070853, var_61ef3d357eaf64d4) {
  data = {
    #var_61ef3d357eaf64d4: var_61ef3d357eaf64d4, #var_671bf70d6a070853: var_671bf70d6a070853, #timeout: timeout, #archetype_fields: archetype_fields, #param: widget_param, #widget: widget_asset, #ref: "\rW#_\xdc\xf6t-\x99Zl\v:i{\x9b"};
  thread function_d38a85726cad0943(data);
}

function function_2918feaa61035936(state_string) {
  hud_management::function_d8d634ceece460("\rW#_\xdc\xf6t-\x99Zl\v:i{\x9b", state_string);
}

function function_69dcd96ff9f48ced() {
  hud_management::scripted_widget_destroy("\rW#_\xdc\xf6t-\x99Zl\v:i{\x9b");
  self notify("\x05\xa8\xf3M2yu'N\xf7\xf3\xcd\xee\xa2");
}

function private function_d38a85726cad0943(data) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  level utility::flag_wait("b\xac|\x12\ao.\xa3\x8bDN\xe5`\xe6\xe2\xb6\xfcH\xb5\r\xa9_/\x01&v\xe2\xaa");
  self notify("1\xec\a\xc1V%\xc3\xc3\xfe\xbf\xd7\xdb\x94");
  item = spawnStruct();
  item.init_func = &function_135fd0f4d00857f0;
  item.break_func = &function_82bac626842d075f;
  item.interrupt_func = &function_69dcd96ff9f48ced;
  item.func_params = data;
  thread queue::function_e964ae838fe2a244(data.ref, item);
}

function private function_135fd0f4d00857f0(params, start_time, endons) {
  hud_management::function_35924dfcb78711f4("\rW#_\xdc\xf6t-\x99Zl\v:i{\x9b", params.widget);

  if(isDefined(params.param)) {
    hud_management::function_b683400f784cb7dc("\rW#_\xdc\xf6t-\x99Zl\v:i{\x9b", params.param);
  }

  hud_management::function_41ff479ac45608d6("\rW#_\xdc\xf6t-\x99Zl\v:i{\x9b", params.archetype_fields, 1);
  function_2918feaa61035936("\xf1\xba\x8f\x9d");

  if(isDefined(params.timeout)) {
    thread function_23efacb07652ee8(params.timeout);
  }

  if(isDefined(params.var_671bf70d6a070853)) {
    thread function_564529d690a11706(params.var_671bf70d6a070853);
  }

  if(isDefined(params.var_61ef3d357eaf64d4)) {
    thread function_8ffd7f3686972689(params.var_61ef3d357eaf64d4);
  }
}

function private function_82bac626842d075f(params, start_time, before_init) {
  if(istrue(before_init)) {
    return false;
  }

  if(isDefined(params.timeout) && gettime() < start_time + params.timeout * 1000 + 0.05) {
    return false;
  }

  return !hud_management::function_48c98ea9a4f0da89(params.ref);
}

function private function_acc3c87d3219b1aa() {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\x05\xa8\xf3M2yu'N\xf7\xf3\xcd\xee\xa2");
  function_2918feaa61035936("\x19b\xc2y");
  self notify("\x05\xa8\xf3M2yu'N\xf7\xf3\xcd\xee\xa2");
}

function private function_23efacb07652ee8(timeout) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\x05\xa8\xf3M2yu'N\xf7\xf3\xcd\xee\xa2");
  wait timeout;
  thread function_acc3c87d3219b1aa();
}

function private function_564529d690a11706(var_671bf70d6a070853) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\x05\xa8\xf3M2yu'N\xf7\xf3\xcd\xee\xa2");

  if(isstring(var_671bf70d6a070853)) {
    var_671bf70d6a070853 = [var_671bf70d6a070853];
  }

  utility::waittill_any_in_array(var_671bf70d6a070853);
  thread function_acc3c87d3219b1aa();
}

function private function_8ffd7f3686972689(var_4b68e11de0c61454) {
  self endon("\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2");
  self endon("\x05\xa8\xf3M2yu'N\xf7\xf3\xcd\xee\xa2");

  if(isstring(var_4b68e11de0c61454)) {
    var_4b68e11de0c61454 = [var_4b68e11de0c61454];
  }

  utility::flag_waitopen_all_array(var_4b68e11de0c61454);
  thread function_acc3c87d3219b1aa();
}