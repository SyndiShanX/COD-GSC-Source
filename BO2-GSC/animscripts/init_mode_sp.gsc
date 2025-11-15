/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\init_mode_sp.gsc
****************************************/

#include animscripts\anims_table;
#include animscripts\anims_table_wounded;

init() {
  level.setup_anims_callback = ::setup_anims;
  level.setup_anim_array_callback = ::setup_anim_array;
  level.setup_wounded_anims_callback = animscripts\anims_table_wounded::setup_wounded_anims;
}