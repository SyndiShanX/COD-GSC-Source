/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_2d4725bf070ac3b.gsc
************************************************/

#namespace namespace_712ed31f24d3b469;

function init() {
  level.var_1569f12089147662 = [];
  level thread ongameended();
}

function function_7a894394e9924dc6(callback) {
  level.var_1569f12089147662[level.var_1569f12089147662.size] = callback;
}

function ongameended() {
  level waittill("game_ended");

  foreach(callback in level.var_1569f12089147662) {
    level thread[[callback]]();
  }
}