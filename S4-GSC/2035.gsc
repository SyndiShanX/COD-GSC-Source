/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: 2035.gsc
*************************************************/

_id_9EDE() {
  var_0 = getEntArray("minefield", "targetname");

  if(var_0.size > 0) {
    level._effect["mine_explosion"] = loadfx("vfx/core/expl/weap/gre/vfx_exp_gre_dirt_cg");
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_0[var_1] thread _id_9EDD();
  }
}

_id_9EDD() {
  _id_07D1::_id_60C2("prematch_done");

  for(;;) {
    self waittill("trigger", var_0);

    if(isPlayer(var_0)) {
      var_0 thread _id_9EDC(self);
    }
  }
}

_id_9EDC(var_0) {
  if(isDefined(self._id_9EDB)) {
    return;
  }
  self._id_9EDB = 1;
  wait 0.5;
  wait(randomfloat(0.5));

  if(isDefined(self) && self istouching(var_0)) {
    var_1 = self _meth_8169();
    var_2 = 300;
    var_3 = 2000;
    var_4 = 50;
    _func_01BA(var_1, var_2, var_3, var_4);
  }

  self._id_9EDB = undefined;
}