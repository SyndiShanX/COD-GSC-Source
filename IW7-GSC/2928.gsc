/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 2928.gsc
**************************************/

_id_1032A() {
  if(!scripts\engine\utility::add_init_script("slowmo", ::_id_1032A)) {
    return;
  }
  level._id_1031B = spawnStruct();
  _id_10329();
  notifyoncommand("_cheat_player_press_slowmo", "+melee");
  notifyoncommand("_cheat_player_press_slowmo", "+melee_breath");
  notifyoncommand("_cheat_player_press_slowmo", "+melee_zoom");
}

_id_10329() {
  level._id_1031B._id_ABA1 = 0.0;
  level._id_1031B._id_ABA2 = 0.25;
  level._id_1031B._id_1098F = 0.4;
  level._id_1031B._id_1098C = 1.0;
}