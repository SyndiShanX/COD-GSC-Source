/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\_fx.gsc
**************************************/

script_print_fx() {
  if(!isDefined(self.script_fxid) || !isDefined(self.seerecently) || !isDefined(self.script_delay)) {
    self delete();
    return;
  }

  if(isDefined(self.target)) {
    var_0 = _getEnt(self.target).origin;
  } else {
    var_0 = "undefined";
  }

  if(self.seerecently == "OneShotfx") {}

  if(self.seerecently == "loopfx") {}

  if(self.seerecently == "loopsound") {
    return;
  }
}

grenadeexplosionfx(var_0) {
  playFX(level._effect["mechanical explosion"], var_0);
  _earthquake(0.15, 0.5, var_0, 250);
}

soundfx(var_0, var_1, var_2) {
  var_3 = spawn("script_origin", (0, 0, 0));
  var_3.origin = var_1;
  var_3 playLoopSound(var_0);

  if(isDefined(var_2)) {
    var_3 thread soundfxdelete(var_2);
  }
}

soundfxdelete(var_0) {
  level waittill(var_0);
  self delete();
}

_id_1797(var_0) {
  self waittill("death");
  var_0 delete();
}