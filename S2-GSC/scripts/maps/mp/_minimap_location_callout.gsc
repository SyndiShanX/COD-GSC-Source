/*********************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_minimap_location_callout.gsc
*********************************************************/

init() {
  level._id_620F = getEntArray("minimap_location_callout", "targetname");
}

_id_63C2() {
  level endon("game_ended");
  self endon("death");
  self endon("disconnect");
  self._id_2942 = -1;
  self _meth_82FF("ui_minimap_location_callout", -1);
  waitframe();
  _id_21D1(1);

  while(isDefined(self)) {
    wait 0.1;
    _id_21D1(0);
  }
}

_id_21D1(var_0) {
  var_1 = 0;
  var_2 = -1;

  foreach(var_4 in level._id_620F) {
    if(var_4 _meth_858B(self.origin)) {
      var_1 = 1;
      var_2 = int(var_4._id_0165);
      continue;
    }
  }

  if(var_1) {
    if(var_0 || var_2 != self._id_2942) {
      self._id_2942 = var_2;
      self _meth_82FF("ui_minimap_location_callout", self._id_2942);
    }

    self._id_99F2 = gettime();
  }

  if(!var_1 && self._id_2942 != -1 && (!isDefined(self._id_99F2) || self._id_99F2 + 2000 < gettime())) {
    self._id_2942 = -1;
    self _meth_82FF("ui_minimap_location_callout", -1);
  }
}