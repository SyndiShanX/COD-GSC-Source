/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\player\note.gsc
**************************************/

#using scripts\common\values;
#using scripts\engine\hud_management;
#using scripts\engine\utility;
#using scripts\sp\player\cursor_hint;
#namespace note;

function private function_9b9a292a9abc3104(allow_exit = 1) {
  helper_prompts = [];

  if(allow_exit) {
    helper_prompts["\xf9}\v\xd8\xea8D\xde\xeelp]"] = &"hash_5b915e03c39bdbe4";
  }

  return helper_prompts;
}

function note_init() {
  notes = getEntArray("\xfa\xae\x8d\xb2\xadIMq\x81\xb4\xbc\x81\x81-\xf9\xf4\x01", #classname);

  foreach(note in notes) {
    note thread function_e8320fe19e414123();
  }
}

function private function_e8320fe19e414123() {
  self notify("\xd5\xc2\x138%\x97\fs\x16#\xe5\x842`;K");
  self endon("\xd5\xc2\x138%\x97\fs\x16#\xe5\x842`;K");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self endon("\xf52\xb1,\xa9\xc0\xe4\xc4\xda\x19\xaf");
  self.var_e703a981d06a1192 = 1;
  self.note_fov = getdvarfloat(@ "cg_fov");
  cursor_hint::create_cursor_hint(undefined, undefined, self.var_4a1b64a72d646b14, undefined, 320, 56, self.var_f1ae53edb68d5bf5);

  switch (self.var_5db850237dcb7346) {
    case #"hash_c9b3133a17a3b2d0":
      self.var_5db850237dcb7346 = 0;
      break;
    case #"hash_bf1a695c21e57fe4":
      self.var_5db850237dcb7346 = 1;
      break;
    case #"hash_96815ce4f2a3dbc5":
      self.var_5db850237dcb7346 = 2;
      break;
    default:
      self.var_5db850237dcb7346 = undefined;
      break;
  }

  switch (self.var_729b9491e4846c54) {
    case #"hash_6d308d6c437ce11c":
      self.var_729b9491e4846c54 = 0;
      break;
    case #"hash_ae8958d4b4a21d78":
      self.var_729b9491e4846c54 = 1;
      break;
    case #"hash_dcbcc9b3083fb78a":
      self.var_729b9491e4846c54 = 2;
      break;
    default:
      self.var_729b9491e4846c54 = undefined;
      break;
  }

  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>", player);
    player note_open(self.script_note_text, self.script_note_widget, self.script_note_param, self.script_note_x, self.script_note_y, self.var_5db850237dcb7346, self.var_729b9491e4846c54);
  }
}

function note_remove(just_remove = 0) {
  if(!just_remove) {
    prev_fov = self.note_fov ?? 65;
    level.player lerpfov(prev_fov);
  }

  cursor_hint::remove_cursor_hint();
  self notify("\xf52\xb1,\xa9\xc0\xe4\xc4\xda\x19\xaf");
}

function note_open(var_218b9b0248e51558, widget, param, x, y, horz_anchor, vert_anchor) {
  if(hud_management::function_48c98ea9a4f0da89("$)\xc1\xfb")) {
    assert("<dev string:x24>");
    return;
  }

  if(!isDefined(widget)) {
    widget = "\xbb\xdbC\x8eT\xef\x1c\xa1\x17U\xd9EI\x84\xfd\x19\xfdBCA";
  }

  if(!isDefined(x)) {
    x = 0;
  }

  if(!isDefined(y)) {
    y = 0;
  }

  if(!isDefined(horz_anchor)) {
    horz_anchor = 1;
  }

  if(!isDefined(vert_anchor)) {
    vert_anchor = 1;
  }

  assert(isPlayer(self));
  val::set("$)\xc1\xfb", " \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[", 1);
  val::set("$)\xc1\xfb", "\xa8Jl\x84\xb3b\x95o", 0);
  val::set("$)\xc1\xfb", "\xc3<\xbcpe\xd4\xf6=\x8d5\xbc\xeb\x18A", 1);

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"add_array")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"add_array", "$)\xc1\xfb", function_9b9a292a9abc3104());
  }

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"set_position")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"set_position", 0, -30, 1, 2);
  }

  self enablephysicaldepthoffieldscripting(3);
  self setphysicaldepthoffield(1, 0, 10);
  self lerpfov(48, 0.6, 0.5, 0.1);
  wait 0.2;
  hud_management::function_35924dfcb78711f4("$)\xc1\xfb", widget);
  hud_management::function_85d8a0ba2e35b6f2("$)\xc1\xfb", x, y, horz_anchor, vert_anchor);

  if(isDefined(param)) {
    hud_management::function_b683400f784cb7dc("$)\xc1\xfb", param);
  }

  hud_management::function_d3b457baa69dec73("$)\xc1\xfb", "\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:", function_30e4f86dded0873(var_218b9b0248e51558));
  thread function_b9d821f232a4c232();
  thread function_22a26a79e20d79d1();
}

function function_5b39998686d7f04d(var_218b9b0248e51558) {
  assert(isPlayer(self));
  assert(hud_management::function_48c98ea9a4f0da89("<dev string:x4d>"), "<dev string:x55>");
  hud_management::function_d3b457baa69dec73("$)\xc1\xfb", "\xe2\xa7.m\xa5\xf2\x18\x84\f\xc45~x\x9f:", function_30e4f86dded0873(var_218b9b0248e51558));
}

function note_close() {
  assert(isPlayer(self));
  self notify("\xca\x8b)\xc1\xee\xc1\x8ax\x93[>");
  hud_management::scripted_widget_destroy("$)\xc1\xfb");

  if(utility::issharedfuncdefined(#"helper_bar_prompts", #"remove_group")) {
    utility::callsharedfunc(#"helper_bar_prompts", #"remove_group", "$)\xc1\xfb");
  }

  val::reset_all("$)\xc1\xfb");
  self disablephysicaldepthoffieldscripting();
  prev_fov = self.note_fov ?? 65;
  self lerpfov(prev_fov, 0.5, 0, 0.5);
}

function private function_b9d821f232a4c232() {
  self endon("\xca\x8b)\xc1\xee\xc1\x8ax\x93[>");
  self waittill("\xe3C\x05\x14y\x87Z\xc4\x85\x0ez\xde\xe8\x9f\xcc\x8bE\xf6\xaa\x06g\x1e;C\xe5)\xb7 \x057");
  thread note_close();
}

function private function_22a26a79e20d79d1() {
  self endon("F\xa5\xe66\xde\xcd\xb9\xac\xd8\xd1+2");
  self endon("\xca\x8b)\xc1\xee\xc1\x8ax\x93[>");
  self waittill("\x1e\xfd\xd1\xa2\a");
  thread note_close();
}