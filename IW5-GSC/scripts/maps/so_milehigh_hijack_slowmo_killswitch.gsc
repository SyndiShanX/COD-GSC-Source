/*****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\so_milehigh_hijack_slowmo_killswitch.gsc
*****************************************************************/

init() {
  if(maps\_utility::is_coop()) {
    level.no_slowmo = 0;
  }
}