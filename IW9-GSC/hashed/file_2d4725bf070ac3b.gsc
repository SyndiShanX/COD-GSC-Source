/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_2d4725bf070ac3b.gsc
***********************************************/

init() {
  level._id_1569F12089147662 = [];
  level thread ongameended();
}

_id_7A894394E9924DC6(callback) {
  level._id_1569F12089147662[level._id_1569F12089147662.size] = callback;
}

ongameended() {
  level waittill("game_ended");

  foreach(callback in level._id_1569F12089147662)
  level thread[[callback]]();
}