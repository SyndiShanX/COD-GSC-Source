/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\stealth\callbacks.gsc
*****************************************/

#using scripts\engine\utility;
#namespace callbacks;

function init_callbacks() {
  level.global_callbacks = [];

  foreach(callback in ["\x90\x9b\x95]\xe5\xbdwU\x18MB(G\x88}\xce\x0f{b\xc9\ne", "\x1f\xb0\xf6o\xa44\x83\xf7j\xbd\x06\xb3\xfa<\xc0\xed\x9e\x98e\xd5?\x887:\xa8x", ">\xa5\x14\n\xda\x01{x\xbf\xe3uY\xe6\x8a\x99i)\x10(8\t\x16\x1f<", "%\xebW$a\x10\x83?\xebX0b,uiewhi\xcb"]) {
    level.global_callbacks[callback] = &global_empty_callback;
  }

  if(!utility::flag_exist("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed")) {
    utility::flag_init("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
  }

  if(!utility::flag_exist("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3")) {
    utility::flag_init("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3");
  }

  if(!utility::flag_exist("G\x15[4\x90\xf0\x0f@Y\xf5\x11\xb0$\x1c\x01NF\x1bk")) {
    utility::flag_init("G\x15[4\x90\xf0\x0f@Y\xf5\x11\xb0$\x1c\x01NF\x1bk");
  }
}

function global_empty_callback(empty1, empty2, empty3, empty4, empty5) {
  assertmsg("<dev string:x24>");
}

function stealth_get_func(type) {
  if(isDefined(self.stealth.funcs) && isDefined(self.stealth) && isDefined(self.stealth.funcs[type])) {
    return self.stealth.funcs[type];
  }

  if(isDefined(level.stealth) && isDefined(level.stealth.funcs)) {
    return level.stealth.funcs[type];
  }

  return undefined;
}

function stealth_call(type, ...) {
  func = stealth_get_func(type);

  if(isDefined(func)) {
    return self[[func]](flat_args(vararg, varargcount));
  }

  return undefined;
}

function stealth_call_thread(type, ...) {
  func = stealth_get_func(type);

  if(isDefined(func)) {
    return self thread[[func]](flat_args(vararg, varargcount));
  }

  return undefined;
}