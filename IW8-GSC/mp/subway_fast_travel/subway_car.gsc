/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\subway_fast_travel\subway_car.gsc
************************************************/

init() {
  level thread supply_crate_vo_when_used();
  scripts\mp\utility\sound::besttime("_encstr_B489150751AFDBD259F18C426E101F43EE8347A7C735A2");
}

supply_crate_vo_when_used() {
  level waittill("_encstr_957F0FC1B1C22FCAC9AFE6E016EEB9CA23");
  var_0 = getentitylessscriptablearrayinradius("_encstr_AB4A1A7FA8FBD1BB297756CD6D57226F4380BF4750B014D227165FC0", "_encstr_AC110A7F14873B5B3D073009");

  foreach(var_2 in var_0)
  var_2 thread _id_11D28();
}

_id_11D28() {
  if(isDefined(self.script_noteworthy)) {
    for(;;) {
      self setscriptablepartstate("_encstr_973D0F65B04BCFA747E81AA2F06F1A23A2", self.script_noteworthy);
      wait 32.5;
      self setscriptablepartstate("_encstr_973D0F65B04BCFA747E81AA2F06F1A23A2", "_encstr_BA19049F4B2D");
      wait 32.5;
    }
  } else {}
}