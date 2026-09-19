/***************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_lsrmissileguidance.gsc
***************************************************/

_id_631C() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");

  for(;;) {
    self waittill("missile_fire", var_0, var_1);

    if(issubstr(var_1, "maaws")) {
      if(!isDefined(self._id_5F39)) {
        self._id_5F39 = spawn("script_origin", self.origin);
        self._id_5F39.targetname = "lsr_missile";
      }

      self._id_5F39 thread _id_5F3A(var_0);
      var_0 thread _id_5F38(self);
    }
  }
}

_id_5F38(var_0) {
  self endon("death");
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 endon("faux_spawn");

  for(;;) {
    if(var_0 _meth_8345() > 0.3) {
      var_1 = anglesToForward(var_0 getplayerangles());
      var_2 = var_0 getEye();
      var_3 = var_2 + var_1 * 15000;
      var_4 = bulletTrace(var_2, var_3, 1, var_0, 1, 0, 0, 0, 0);
      var_0._id_5F39.origin = var_4["position"];
      self _meth_81D9(var_0._id_5F39);
    }

    waitframe();
  }
}

_id_5F3A(var_0) {
  if(!isDefined(self._id_5F37))
    self._id_5F37 = 1;
  else
    self._id_5F37++;

  var_0 waittill("death");
  self._id_5F37--;

  if(self._id_5F37 == 0)
    self delete();
}