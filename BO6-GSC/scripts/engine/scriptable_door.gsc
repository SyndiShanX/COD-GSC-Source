/**********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\scriptable_door.gsc
**********************************************/

#namespace scriptable_door;

function system_init() {
  if(isDefined(level.scriptable_door_initialized)) {
    return;
  }

  level.scriptable_door_initialized = 1;
}

function function_25c67271e41d8eee(var_67522cf358185ea) {
  level.var_bbccd45f89372404 = var_67522cf358185ea;
}

function function_b5d32f7fadb9b184(var_41709000f9757468) {
  level.var_1ce8a257d35d7d02 = var_41709000f9757468;
}

function function_a152092746ef29b0(var_665db4eeecbac78c) {
  level.var_352a82622fcefd6e = var_665db4eeecbac78c;
}

function function_c0049536af4b1117(canunlockcallback) {
  level.var_25a1b0883ae0f2c8 = canunlockcallback;
}

function function_369c460bb0ed0820(unlockedcallback) {
  level.door_unlocked = unlockedcallback;
}

function function_ca3d8a38c027141(instance, player) {
  if(isDefined(level.var_bbccd45f89372404)) {
    return [[level.var_bbccd45f89372404]](instance, player);
  }

  return &"";
}

function function_71b8ebf388a66887(instance, player) {
  if(isDefined(level.var_1ce8a257d35d7d02)) {
    return [[level.var_1ce8a257d35d7d02]](instance, player);
  }

  return &"";
}

function function_657d18ac1a0fb2fb(instance, player) {
  if(isDefined(level.var_352a82622fcefd6e)) {
    return [[level.var_352a82622fcefd6e]](instance, player);
  }

  return &"";
}

function function_dc8c68480632f4dc(instance, player, var_867f7d84083437ee) {
  if(isDefined(level.var_25a1b0883ae0f2c8)) {
    return [[level.var_25a1b0883ae0f2c8]](instance, player, var_867f7d84083437ee);
  }

  return 0;
}

function event_handler[scriptabledoor_unlocked] scriptabledoor_unlocked(instance, player) {
  if(isDefined(level.door_unlocked)) {
    [[level.door_unlocked]](instance, player);
  }
}

function isscriptabledoor(door) {
  if(isent(door) && door isscriptable() || !isent(door) && door isscriptableinstance()) {
    return door scriptableisdoor();
  }

  return 0;
}

function scriptabledoor_open(door, t) {
  door scriptabledooropen("away", self.origin);

  if(door scriptabledoorisdouble()) {
    doorlist = getentitylessscriptablearray(undefined, undefined, door.origin, 64);

    foreach(otherdoor in doorlist) {
      if(otherdoor scriptabledoorisdouble()) {
        otherdoor scriptabledooropen("away", self.origin);
      }
    }
  }
}

function scriptabledoor_close(door) {
  door scriptabledoorclose();
}

function function_ebc4f081a7104b46(door) {
  return abs(door scriptabledoorangle()) > 60;
}