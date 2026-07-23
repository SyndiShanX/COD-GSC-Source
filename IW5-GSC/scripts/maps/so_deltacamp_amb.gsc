/*********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_deltacamp_amb.gsc
*********************************************/

main() {
  maps\_audio::aud_use_string_tables();
  maps\_audio::aud_set_occlusion("default");
  maps\_audio::aud_set_timescale();
  thread maps\_utility::set_ambient("so_deltacamp_ext");
}