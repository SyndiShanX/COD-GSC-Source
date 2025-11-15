/*****************************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: aitype\clientscripts\enemy_isi_pakistan_leader_millibar.csc
*****************************************************************************************/

#include character\clientscripts\c_pak_isi_leader_millibar;

main() {
  character\clientscripts\c_pak_isi_leader_millibar::main();
  self._aitype = "Enemy_ISI_Pakistan_Leader_Millibar";
}

precache(ai_index) {
  character\clientscripts\c_pak_isi_leader_millibar::precache();
  usefootsteptable(ai_index, "default_ai");
  setdemolockonvalues(ai_index, 100, 8, 0, 60, 8, 0, 60);
}