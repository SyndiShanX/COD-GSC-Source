/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2666.gsc
*************************************************/

_id_9B88() {}

_id_9B89(var_0, var_1) {
  self endon("death_or_disconnect");
  level endon("game_ended");

  if(scripts\engine\utility::_id_8794(var_1) && isPlayer(var_0) && var_0.team != self.team && !var_0 scripts\mp\utility\perk::_hasperk("specialty_empimmune") && !isDefined(var_0._id_8921)) {
    thread _id_9B87(var_0);
  }
}

_id_9B87(var_0) {
  var_0._id_8921 = 1;
  var_0._id_7647 = 1;
  wait 0.1;
  _id_ED6A(var_0);
  wait 0.1;

  if(isDefined(var_0)) {
    var_0 _id_C4E5();
  }
}

_id_ED6A(var_0) {
  self endon("death_or_disconnect");
  var_1 = gettime() + 3500;

  while(isalive(var_0) && gettime() < var_1) {
    wait 1.1;
  }
}

_id_C4E5() {
  self._id_8921 = undefined;
  self._id_7647 = undefined;
}