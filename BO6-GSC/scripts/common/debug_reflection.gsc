/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\debug_reflection.gsc
***********************************************/

#using scripts\engine\utility;
#namespace debug_reflection;

function init_reflection_probe(handleplayerconnect) {
  precachemodel("<dev string:x24>");
}

function spplayerconnect() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player utility::add_frame_event(&debug_reflection_probes);
}

function onplayerconnect() {
  if(isDefined(level.func_run_lean_threads) && [[level.func_run_lean_threads]]()) {
    return;
  }

  for(;;) {
    level waittill("<dev string:x3a>", player);
    player utility::add_frame_event(&debug_reflection_probes);
  }
}

function debug_reflection_probes() {
  if(getDvar(@ "scr_debug_reflection") == "<dev string:x47>" && level.debug.reflection != 2 || getDvar(@ "scr_debug_reflection") == "<dev string:x4c>" && level.debug.reflection != 3) {
    function_c399b333d2e9cd16();

    if(getDvar(@ "scr_debug_reflection") == "<dev string:x47>") {
      level.debug.reflection = 2;
    } else {
      create_reflection_object();
      level.debug.reflection = 3;
    }
  } else if(getDvar(@ "scr_debug_reflection") == "<dev string:x51>" && level.debug.reflection != 1) {
    function_c399b333d2e9cd16();
    create_reflection_object();
    level.debug.reflection = 1;
  } else if(getDvar(@ "scr_debug_reflection") == "<dev string:x56>" && level.debug.reflection != 0) {
    function_c399b333d2e9cd16();
    level.debug.reflection = 0;
  }

  debug_reflection_buttons();
}

function create_reflection_object() {
  self.var_ceae67f663702fa2 = spawn("<dev string:x5b>", self getEye() + anglesToForward(self.angles) * 100);
  self.var_ceae67f663702fa2 setModel("<dev string:x24>");
  self.var_ceae67f663702fa2.origin = self getEye() + anglesToForward(self getplayerangles()) * 100;
  object = self.var_ceae67f663702fa2;
  object.offset = 100;
  object.lastoffset = object.offset;
}

function function_c399b333d2e9cd16() {
  if(level.debug.reflection == 1 || level.debug.reflection == 3) {
    self.var_ceae67f663702fa2 delete();
  }
}

function debug_reflection_buttons() {
  if(!isDefined(self.var_ceae67f663702fa2)) {
    return;
  }

  object = self.var_ceae67f663702fa2;

  if(self buttonPressed("<dev string:x6b>")) {
    object.offset += 50;
  }

  if(self buttonPressed("<dev string:x77>")) {
    object.offset -= 50;
  }

  object.offset = clamp(object.offset, 64, 1000);
  object.origin = self getEye() + anglesToForward(self getplayerangles()) * object.offset;
  object.lastoffset = object.offset;
}

# /