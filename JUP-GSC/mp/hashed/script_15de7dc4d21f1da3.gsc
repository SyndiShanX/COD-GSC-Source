/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_15de7dc4d21f1da3.gsc
*************************************************/

#namespace namespace_ee5e52a75fbcf489;

function init() {
  if(!isDefined(level.var_170a29e0c0e257b7)) {
    level.var_170a29e0c0e257b7 = [];
    level.var_6d69e5fde1ae8e9e = [];
  }

  level thread function_5b1d60872d5f7d1f();
}

function function_5b1d60872d5f7d1f() {
  for(;;) {
    level waittill("connected", player);
    player thread function_6b1fcec8b1789d65();
    player thread function_df97371d5dcee28c();
  }
}

function function_ba46cf958ae0cbda(callback) {
  if(!isDefined(level.var_170a29e0c0e257b7)) {
    level.var_170a29e0c0e257b7 = [];
  }

  level.var_170a29e0c0e257b7[level.var_170a29e0c0e257b7.size] = callback;
}

function function_7f4116eba8c42fa0(weapondropcallback) {
  temparray = [];

  foreach(callback in level.var_170a29e0c0e257b7) {
    if(weapondropcallback != callback) {
      temparray[temparray.size] = callback;
    }
  }

  level.var_170a29e0c0e257b7 = temparray;
}

function function_39027364b9c16127(callback) {
  if(!isDefined(level.var_6d69e5fde1ae8e9e)) {
    level.var_6d69e5fde1ae8e9e = [];
  }

  level.var_6d69e5fde1ae8e9e[level.var_6d69e5fde1ae8e9e.size] = callback;
}

function function_e7aae5b770c4747b(var_2d2deddadd177b34) {
  temparray = [];

  foreach(callback in level.var_6d69e5fde1ae8e9e) {
    if(var_2d2deddadd177b34 != callback) {
      temparray[temparray.size] = callback;
    }
  }

  level.var_6d69e5fde1ae8e9e = temparray;
}

function function_6b1fcec8b1789d65() {
  self endon("disconnect");

  for(;;) {
    self waittill("weapon_dropped", droppedentity, weaponobject);

    foreach(callback in level.var_170a29e0c0e257b7) {
      self[[callback]](droppedentity, weaponobject);
    }
  }
}

function function_df97371d5dcee28c() {
  self endon("disconnect");

  for(;;) {
    self waittill("dropped_weapon_scriptable", droppedweapon, secondparam, soundposition);

    foreach(callback in level.var_6d69e5fde1ae8e9e) {
      self[[callback]](droppedweapon, secondparam, soundposition);
    }
  }
}