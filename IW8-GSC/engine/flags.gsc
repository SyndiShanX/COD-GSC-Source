/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: engine\flags.gsc
***********************************************/

init_flags() {
  if(!scripts\engine\utility::add_init_script("_encstr_BA810BF830A7C3E7C0F5718497", ::init_flags)) {
    return;
  }
  level.flag = [];
  level.flags_lock = [];
  level.generic_index = 0;
  level.flag_struct = spawnStruct();
  level.flag_struct assign_unique_id();
}

assign_unique_id() {
  self.unique_id = "_encstr_979608DF73C8E70B73A1" + level.generic_index;
  level.generic_index++;
}