/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_fx.gsc
**************************************/

_id_8274() {
  if(!isDefined(self._id_81BB) || !isDefined(self._id_81BA) || !isDefined(self.script_delay)) {
    self delete();
    return;
  }

  if(isDefined(self.target))
    var_0 = _func_18E(self.target).origin;
  else
    var_0 = "undefined";

  if(self._id_81BA == "OneShotfx") {}

  if(self._id_81BA == "loopfx") {}

  if(self._id_81BA == "loopsound")
    return;
}

_id_4866(var_0) {
  playFX(level._effect["mechanical explosion"], var_0);
  _func_17F(0.15, 0.5, var_0, 250);
}

_id_8F42(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3.origin = var_1;
  var_3 _meth_861D(var_0);

  if(isDefined(var_2))
    var_3 thread _id_8F43(var_2);
}

_id_8F43(var_0) {
  level waittill(var_0);
  self delete();
}

_id_1797(var_0) {
  self waittill("death");
  var_0 delete();
}