/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_89c4e8e66e8a360.gsc
************************************************/

#using scripts\mp\utility\player;
#namespace namespace_39a53563bf72cee5;

function function_1efd3ef097bc71ef(player, checkads, ondamagedcallback) {
  thread function_52d6054e90ed0551(player, checkads, ondamagedcallback);
}

function private function_52d6054e90ed0551(player, checkads, ondamagedcallback) {
  self endon("entitydeleted");
  level endon("game_ended");
  player endon("disconnect");

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, type, modelname, tagname, partname, idflags, weapon);

    if((!checkads || player scripts\mp\utility\player::isplayerads()) && attacker == player) {
      if(isDefined(ondamagedcallback)) {
        self[[ondamagedcallback]](player);
      }

      return;
    }
  }
}