/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\debug_graycard.gsc
************************************************/

#using scripts\common\utility;
#using scripts\engine\utility;
#namespace debug_graycard;

function init_graycard(handleplayerconnect) {
  setdevdvarifuninitialized(@ "hash_a6381f8c58314102", "<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_1dfb6641a37c41f1", "<dev string:x1c>");
  precachemodel("<dev string:x1e>");
  precachemodel("<dev string:x2e>");
  precachemodel("<dev string:x4e>");
  precachemodel("<dev string:x70>");
  precachemodel("<dev string:x8c>");
  precachemodel("<dev string:xa6>");
  precachemodel("<dev string:xba>");
  precachemodel("<dev string:xd0>");
  precachemodel("<dev string:xea>");

  if(!isDefined(level.debug)) {
    level.debug = spawnStruct();
  }

  level.debug.graycard = 0;

  if(isDefined(handleplayerconnect)) {
    thread onplayerconnect();
    return;
  }

  thread spplayerconnect();
}

function spplayerconnect() {
  while(!isDefined(level.player)) {
    waitframe();
  }

  level.player add_frame_event(&debug_gray_card);
}

function onplayerconnect() {
  if(isDefined(level.func_run_lean_threads) && [[level.func_run_lean_threads]]()) {
    return;
  }

  for(;;) {
    level waittill("<dev string:x102>", player);
    player scripts\engine\utility::add_frame_event(&debug_gray_card_mp);
  }
}

function debug_gray_card_mp() {
  debug_gray_card(1);
}

function debug_gray_card(ismp) {
  if(!isDefined(ismp)) {
    ismp = 0;
  }

  if(getDvar(@ "hash_a6381f8c58314102") == "<dev string:x10c>") {
    if(level.debug.graycard != 1) {
      remove_graycard_objects();
      create_graycard_object();
      level.debug.graycard = 1;
    }

    debug_graycard_buttons(ismp);
  } else if(getDvar(@ "hash_a6381f8c58314102") == "<dev string:x1c>" && level.debug.graycard != 0) {
    remove_graycard_objects();
    level.debug.graycard = 0;
  }

  switch (getDvar(@ "hash_1dfb6641a37c41f1")) {
    case #"hash_311010bc01bd3a0f":
      set_debug_models("<dev string:x2e>");
      break;
    case #"hash_31100fbc01bd387c":
      set_debug_models("<dev string:x4e>");
      break;
    case #"hash_311012bc01bd3d35":
      set_debug_models("<dev string:x70>");
      break;
    case #"hash_311011bc01bd3ba2":
      set_debug_models("<dev string:xa6>");
      break;
    case #"hash_31100cbc01bd33c3":
      set_debug_models("<dev string:x8c>");
      break;
    case #"hash_31100bbc01bd3230":
      set_debug_models("<dev string:xea>");
      break;
    case #"hash_31100ebc01bd36e9":
      set_debug_models("<dev string:xd0>");
      break;
    case #"hash_31100dbc01bd3556":
      set_debug_models("<dev string:x1e>");
      break;
    default:
      break;
  }
}

function set_debug_models(model) {
  if(isDefined(level.debug.graycard_objects)) {
    foreach(ent in level.debug.graycard_objects) {
      ent setModel(model);
    }
  }

  if(isDefined(self.var_56868152de824f45)) {
    self.var_56868152de824f45 setModel(model);
  }
}

function remove_graycard_objects() {
  if(isDefined(level.debug.graycard_objects)) {
    foreach(ent in level.debug.graycard_objects) {
      ent delete();
    }

    level.debug.graycard_objects = undefined;
  }

  if(isDefined(self.var_56868152de824f45)) {
    self.var_56868152de824f45 delete();
  }
}

function create_graycard_object() {
  self.var_56868152de824f45 = spawn_graycard();
  object = self.var_56868152de824f45;
  object.offset = 100;
  object.lastoffset = object.offset;
  object.copy_released = 1;
  object.offsetangles = (0, 0, 0);
}

function spawn_graycard() {
  model = spawn("<dev string:x11a>", self.origin);
  model setModel("<dev string:xa6>");
  return model;
}

function debug_graycard_buttons(ismp) {
  if(!isDefined(self.var_56868152de824f45)) {
    return;
  }

  object = self.var_56868152de824f45;

  if(self buttonPressed("<dev string:x127>")) {
    object.offset += 5;
  }

  if(self buttonPressed("<dev string:x130>")) {
    object.offset -= 5;
  }

  if(self buttonPressed("<dev string:x139>")) {
    object.offsetangles += (0, 6, 0);
  }

  if(self buttonPressed("<dev string:x142>")) {
    object.offsetangles += (0, -6, 0);
  }

  if(self buttonPressed("<dev string:x14b>")) {
    object.offsetangles += (6, 0, 0);
  }

  if(self buttonPressed("<dev string:x159>")) {
    object.offsetangles += (-6, 0, 0);
  }

  if(self buttonPressed("<dev string:x167>")) {
    object.offsetangles = (0, 0, 0);
  }

  if(object.copy_released) {
    if(self buttonPressed("<dev string:x175>")) {
      create_copy(object);
      object.copy_released = 0;
    }
  } else if(!self buttonPressed("<dev string:x175>")) {
    object.copy_released = 1;
  }

  if(object.offset > 1000) {
    object.offset = 1000;
  }

  if(object.offset < 16) {
    object.offset = 16;
  }

  if(!ismp) {
    object unlink();
  }

  object.origin = self getEye() + anglesToForward(self getplayerangles()) * object.offset;
  object.angles = combineangles(self getplayerangles(), object.offsetangles);
  object.lastoffset = object.offset;

  if(!ismp) {
    object linkTo(self);
  }
}

function create_copy(object) {
  copyobject = spawn_graycard();
  copyobject.origin = object.origin;
  copyobject.angles = object.angles;

  if(!isDefined(level.debug.graycard_objects)) {
    level.debug.graycard_objects = [copyobject];
    return;
  }

  if(level.debug.graycard_objects.size > 50) {
    level.debug.graycard_objects[0] delete();
    level.debug.graycard_objects = array_removeundefined(level.debug.graycard_objects);
  }

  level.debug.graycard_objects[level.debug.graycard_objects.size] = copyobject;
}

# /