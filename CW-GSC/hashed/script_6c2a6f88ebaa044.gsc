/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_6c2a6f88ebaa044.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\system_shared;
#namespace cinematicmotion;

function private autoexec __init__system__() {
  system::register(#"cinematicmotion", &preinit, undefined, undefined, undefined);
}

function preinit() {
  n_bits = getminbitcountfornum(11);
  clientfield::register("toplayer", "cinematicMotion", 1, n_bits, "int");
}

function function_92dd9a20(param) {
  if(!isPlayer(self)) {
    return;
  }

  switch (param) {
    case # "hash_5a4e4aa2a78f38a5":
      self clientfield::set_to_player("cinematicMotion", 0);
      break;
    case # "min1":
      self clientfield::set_to_player("cinematicMotion", 1);
      break;
    case # "min2":
      self clientfield::set_to_player("cinematicMotion", 2);
      break;
    case # "hash_5a4e47a2a78f338c":
      self clientfield::set_to_player("cinematicMotion", 3);
      break;
    case # "hash_5a4e46a2a78f31d9":
      self clientfield::set_to_player("cinematicMotion", 4);
      break;
    case # "hash_5a4e45a2a78f3026":
      self clientfield::set_to_player("cinematicMotion", 5);
      break;
    case # "hash_1f2696a2ce6d028b":
      self clientfield::set_to_player("cinematicMotion", 6);
      break;
    case # "max1":
      self clientfield::set_to_player("cinematicMotion", 7);
      break;
    case # "max2":
      self clientfield::set_to_player("cinematicMotion", 8);
      break;
    case # "hash_1f2697a2ce6d043e":
      self clientfield::set_to_player("cinematicMotion", 9);
      break;
    case # "hash_1f269aa2ce6d0957":
      self clientfield::set_to_player("cinematicMotion", 10);
      break;
    case # "hash_1f2699a2ce6d07a4":
      self clientfield::set_to_player("cinematicMotion", 11);
      break;
    default:
      break;
  }
}

function function_bbf6e778(param) {
  if(!isPlayer(self)) {
    return;
  }

  if(param != "") {
    self setcinematicmotionoverride(param);
    return;
  }

  self setcinematicmotionoverride();
}