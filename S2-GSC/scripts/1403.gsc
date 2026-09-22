/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\1403.gsc
**************************************/

init() {
  level._id_1EB9 = 20;
  level._id_5A61["zm_camouflage"] = ::_id_9E3E;
}

_id_9E3E(var_0, var_1) {
  thread _id_73BA();
  return 1;
}

_id_73BA(var_0) {
  if(!isDefined(var_0)) {
    var_0 = level._id_1EB9;
  }

  var_1 = int(gettime() + var_0 * 1000);

  if(isDefined(self._id_2747) && self._id_2747) {
    var_2 = self getclientomnvar("ui_zm_camo");

    if(var_2 >= var_1) {
      return;
    }
  }

  self notify("playerCamouflageMode");

  if(!isDefined(self._id_2747)) {
    self._id_2747 = 0;
  }

  self playlocalsound("zmb_ss_camo_use");
  self._id_2747++;
  _id_0547::_id_8A6D(1);
  self setclientomnvar("ui_zm_camo", var_1);
  _id_73BB(var_0);

  if(isDefined(self)) {
    _id_0547::_id_8A6D(0);
    self._id_2747--;
  }
}

_id_73BB(var_0) {
  self endon("playerCamouflageMode");
  wait(var_0);
}