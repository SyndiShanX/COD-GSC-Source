/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_breadcrumbdata.gsc
***********************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    _func_377("mp/ddl/breadcrumbdata.ddl");
    _func_378();
  }
}

_id_5E8B() {
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  if(!maps\mp\_utility::gameflag("prematch_done"))
    level waittill("prematch_over");

  if(isbot(self) || istestclient(self)) {
    return;
  }
  if(maps\mp\_utility::isreallyalive(self) && isDefined(self._id_5CC6) && _id_0485::_id_1F59(self._id_5CC6)) {
    var_0 = getdvarfloat("34");

    for(;;) {
      var_1 = self playerads() > 0.5;
      _func_29B(self, self._id_5CC6, var_1);
      wait(var_0);
    }
  }
}