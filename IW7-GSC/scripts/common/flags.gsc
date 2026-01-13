/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: scripts\common\flags.gsc
*********************************************/

init_flags() {
  if(!scripts\engine\utility::add_init_script("init_flags", ::init_flags)) {
    return;
  }

  level.flag = [];
  level.flags_lock = [];
  level.generic_index = 0;
  scripts\engine\utility::init_empty_func_ref_MAYBE("sp_stat_tracking_func");
  level.flag_struct = spawnStruct();
  level.flag_struct assign_unique_id();
}

assign_unique_id() {
  self.unique_id = "generic" + level.generic_index;
  level.generic_index++;
}