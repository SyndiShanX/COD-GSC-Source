/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\debug_reflection.gsc
**************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace debug_reflection;

function init_reflection_probe(handleplayerconnect) {
  precachemodel("<dev string:x1c>");
}

function spplayerconnect() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player add_frame_event(&debug_reflection_probes);
}

function onplayerconnect() {
  if(isDefined(level.func_run_lean_threads) && [[level.func_run_lean_threads]]()) {
    return;
  }

  for(;;) {
    level waittill("<dev string:x2f>", player);
    player scripts\engine\utility::add_frame_event(&debug_reflection_probes);
  }
}

function debug_reflection_probes() {
  if(getDvar(@ "hash_925f7645ee214f2a") == "<dev string:x39>" && level.debug.reflection != 2 || getDvar(@ "hash_925f7645ee214f2a") == "<dev string:x3b>" && level.debug.reflection != 3) {
    function_da5718b2a8be7b0b();

    if(getDvar(@ "hash_925f7645ee214f2a") == "<dev string:x39>") {
      level.debug.reflection = 2;
    } else {
      create_reflection_object();
      level.debug.reflection = 3;
    }
  } else if(getDvar(@ "hash_925f7645ee214f2a") == "<dev string:x3d>" && level.debug.reflection != 1) {
    function_da5718b2a8be7b0b();
    create_reflection_object();
    level.debug.reflection = 1;
  } else if(getDvar(@ "hash_925f7645ee214f2a") == "<dev string:x3f>" && level.debug.reflection != 0) {
    function_da5718b2a8be7b0b();
    level.debug.reflection = 0;
  }

  debug_reflection_buttons();
}

function create_reflection_object() {
  self.debug_reflectionobject = spawn("<dev string:x41>", self getEye() + anglesToForward(self.angles) * 100);
  self.debug_reflectionobject setModel("<dev string:x1c>");
  self.debug_reflectionobject.origin = self getEye() + anglesToForward(self getplayerangles()) * 100;
  object = self.debug_reflectionobject;
  object.offset = 100;
  object.lastoffset = object.offset;
}

function function_da5718b2a8be7b0b() {
  if(level.debug.reflection == 1 || level.debug.reflection == 3) {
    self.debug_reflectionobject delete();
  }
}

function debug_reflection_buttons() {
  if(!isDefined(self.debug_reflectionobject)) {
    return;
  }

  object = self.debug_reflectionobject;

  if(self buttonPressed("<dev string:x4e>")) {
    object.offset += 50;
  }

  if(self buttonPressed("<dev string:x57>")) {
    object.offset -= 50;
  }

  object.offset = clamp(object.offset, 64, 1000);
  object.origin = self getEye() + anglesToForward(self getplayerangles()) * object.offset;
  object.lastoffset = object.offset;
}

# /