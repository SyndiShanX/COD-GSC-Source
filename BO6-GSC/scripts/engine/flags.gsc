/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\engine\flags.gsc
**************************************/

#using scripts\engine\utility;
#namespace flags;

function init_flags() {
  if(!utility::add_init_script("init_flags", &init_flags)) {
    return;
  }

  level.flag = [];
  level.flags_lock = [];
  level.generic_index = 0;
  level.flag_struct = spawnStruct();
  level.flag_struct assign_unique_id();
}

function assign_unique_id() {
  self.unique_id = "generic" + level.generic_index;
  level.generic_index++;
}