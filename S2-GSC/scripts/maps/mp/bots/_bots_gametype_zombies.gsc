/***********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\bots\_bots_gametype_zombies.gsc
***********************************************************/

main() {
  _id_87A7();
  _id_879C();
}

_id_87A7() {
  level._id_19D5["gametype_think"] = ::_id_1B2E;
}

_id_879C() {
  level._id_1B3E = 1;
  level._id_1B3F = 1;
}

_id_1B2E() {
  self notify("bot_zombies_think");
  self endon("bot_zombies_think");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    if(self _meth_8368() != "run_and_gun")
      maps\mp\bots\_bots_util::_id_1AD5("run_and_gun");

    if(!isDefined(self._id_19A1)) {
      var_0 = 9999;
      var_1 = undefined;

      foreach(var_3 in level.players) {
        if(isbot(var_3)) {
          continue;
        }
        if(!isDefined(var_3._id_489E))
          var_3._id_489E = 0;

        if(var_3._id_489E < var_0) {
          var_0 = var_3._id_489E;
          var_1 = var_3;
        }
      }

      if(isDefined(var_1)) {
        thread maps\mp\bots\_bots_strategy::_id_1A0C(var_1, 800);
        var_1._id_489E++;
      }
    }

    self[[self._id_6F7F]]();
    waitframe();
  }
}