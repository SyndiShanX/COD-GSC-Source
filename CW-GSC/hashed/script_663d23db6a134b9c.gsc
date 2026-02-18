/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_663d23db6a134b9c.gsc
***********************************************/

#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\util_shared;
#namespace namespace_8dac58da;

function init() {
  clientfield::register("world", "" + # "hash_5a41b1632428880c", 1, 1, "int");
  clientfield::register("world", "" + # "hash_22f0944e4bd4dea9", 1, 1, "int");
  clientfield::register("world", "" + # "hash_c9774e0d25f882a", 1, 1, "int");
  clientfield::register("world", "" + # "hash_21e00c65edc6594c", 1, 1, "int");
  clientfield::register("world", "" + # "hash_249ac6ef9989bee4", 1, 1, "int");
  level thread function_d20f5e48();
}

function function_a7e6c47e(state) {
  if(state) {
    level clientfield::set("" + # "hash_21e00c65edc6594c", 1);
    return;
  }

  level clientfield::set("" + # "hash_21e00c65edc6594c", 0);
}

function function_1a3aacac(state) {
  level endon(#"end_game");

  switch (state) {
    case 1:
      level clientfield::set("" + # "hash_5a41b1632428880c", 1);
      break;
    case 2:
      level clientfield::set("" + # "hash_22f0944e4bd4dea9", 1);
      break;
    case 3:
      level clientfield::set("" + # "hash_c9774e0d25f882a", 1);
      break;
    case 4:
      level clientfield::set("" + # "hash_5a41b1632428880c", 0);
      break;
    case 5:
      level clientfield::set("" + # "hash_22f0944e4bd4dea9", 0);
      break;
    case 6:
      level clientfield::set("" + # "hash_c9774e0d25f882a", 0);
      break;
  }
}

function function_d20f5e48() {
  level endon(#"end_game");

  while(true) {
    level flag::wait_till("power_on");
    level clientfield::set("" + # "hash_249ac6ef9989bee4", 1);
    level flag::wait_till_clear("power_on");
    level clientfield::set("" + # "hash_249ac6ef9989bee4", 0);
  }
}