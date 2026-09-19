/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_zm_breadcrumbdata.gsc
**************************************************/

init() {
  if(!isDefined(game["gamestarted"])) {
    _func_377("mp/ddl/zm_breadcrumbdata.ddl");
    _func_378();
  }
}

_id_5EB1() {
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
      var_1 = self _meth_8345() > 0.5;
      var_2 = self getcurrentweapon();
      var_3 = _id_0547::_id_AAF9(var_2, 1, 0);
      _func_3A0(self, self._id_5CC6, var_1, var_3);
      wait(var_0);
    }
  }
}