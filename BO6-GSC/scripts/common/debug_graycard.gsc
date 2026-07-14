/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\debug_graycard.gsc
*********************************************/

#using scripts\engine\utility;
#namespace debug_graycard;

function init_graycard(handleplayerconnect) {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  setdevdvarifuninitialized(@ "scr_debug_graycard", "<dev string:x24>");
  setdevdvarifuninitialized(@ "debug_graycard_model", "<dev string:x24>");
  precachemodel("<dev string:x29>");
  precachemodel("<dev string:x3c>");
  precachemodel("<dev string:x5f>");
  precachemodel("<dev string:x84>");
  precachemodel("<dev string:xa3>");
  precachemodel("<dev string:xc0>");
  precachemodel("<dev string:xd7>");
  precachemodel("<dev string:xf0>");
  precachemodel("<dev string:x10d>");

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

  level.player utility::add_frame_event(&debug_gray_card);
}

function onplayerconnect() {
  if(isDefined(level.func_run_lean_threads) && [[level.func_run_lean_threads]]()) {
    return;
  }

  for(;;) {
    level waittill("<dev string:x128>", player);
    player utility::add_frame_event(&debug_gray_card_mp);
  }
}

function debug_gray_card_mp() {
  debug_gray_card(1);
}

function debug_gray_card(ismp) {
  if(!isDefined(ismp)) {
    ismp = 0;
  }

  if(getDvar(@ "scr_debug_graycard") == "<dev string:x135>") {
    if(level.debug.graycard != 1) {
      remove_graycard_objects();
      create_graycard_object();
      level.debug.graycard = 1;
    }

    debug_graycard_buttons(ismp);
  } else if(getDvar(@ "scr_debug_graycard") == "<dev string:x24>" && level.debug.graycard != 0) {
    remove_graycard_objects();
    level.debug.graycard = 0;
  }

  switch (getDvar(@ "debug_graycard_model")) {
    case #"hash_311010bc01bd3a0f":
      set_debug_models("<dev string:x3c>");
      break;
    case #"hash_31100fbc01bd387c":
      set_debug_models("<dev string:x5f>");
      break;
    case #"hash_311012bc01bd3d35":
      set_debug_models("<dev string:x84>");
      break;
    case #"hash_311011bc01bd3ba2":
      set_debug_models("<dev string:xc0>");
      break;
    case #"hash_31100cbc01bd33c3":
      set_debug_models("<dev string:xa3>");
      break;
    case #"hash_31100bbc01bd3230":
      set_debug_models("<dev string:x10d>");
      break;
    case #"hash_31100ebc01bd36e9":
      set_debug_models("<dev string:xf0>");
      break;
    case #"hash_31100dbc01bd3556":
      set_debug_models("<dev string:x29>");
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

  if(isDefined(self.var_3a128a46d012cc0)) {
    self.var_3a128a46d012cc0 setModel(model);
  }
}

function remove_graycard_objects() {
  if(isDefined(level.debug.graycard_objects)) {
    foreach(ent in level.debug.graycard_objects) {
      ent delete();
    }

    level.debug.graycard_objects = undefined;
  }

  if(isDefined(self.var_3a128a46d012cc0)) {
    self.var_3a128a46d012cc0 delete();
  }
}

function create_graycard_object() {
  self.var_3a128a46d012cc0 = spawn_graycard();
  object = self.var_3a128a46d012cc0;
  object.offset = 100;
  object.lastoffset = object.offset;
  object.copy_released = 1;
  object.offsetangles = (0, 0, 0);
}

function spawn_graycard() {
  model = spawn("<dev string:x158>", self.origin);
  model setModel("<dev string:xc0>");
  return model;
}

function debug_graycard_buttons(ismp) {
  if(!isDefined(self.var_3a128a46d012cc0)) {
    return;
  }

  object = self.var_3a128a46d012cc0;

  if(self buttonPressed("<dev string:x168>")) {
    object.offset += 5;
  }

  if(self buttonPressed("<dev string:x174>")) {
    object.offset -= 5;
  }

  if(self buttonPressed("<dev string:x180>")) {
    object.offsetangles += (0, 6, 0);
  }

  if(self buttonPressed("<dev string:x18c>")) {
    object.offsetangles += (0, -6, 0);
  }

  if(self buttonPressed("<dev string:x198>")) {
    object.offsetangles += (6, 0, 0);
  }

  if(self buttonPressed("<dev string:x1a9>")) {
    object.offsetangles += (-6, 0, 0);
  }

  if(self buttonPressed("<dev string:x1ba>")) {
    object.offsetangles = (0, 0, 0);
  }

  if(object.copy_released) {
    if(self buttonPressed("<dev string:x1cb>")) {
      create_copy(object);
      object.copy_released = 0;
    }
  } else if(!self buttonPressed("<dev string:x1cb>")) {
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
    level.debug.graycard_objects = utility::array_removeundefined(level.debug.graycard_objects);
  }

  level.debug.graycard_objects[level.debug.graycard_objects.size] = copyobject;
}

# /