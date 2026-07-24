/***************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\traverse\ship_assault_autotraverse.gsc
***************************************************************/

main() {
  var_0 = self _meth_8145();

  if(isDefined(var_0)) {
    self _meth_80F1(var_0.origin, var_0.angles, 256);
  } else {
    var_0 = self _meth_8146();

    if(isDefined(var_0)) {
      self _meth_80F1(var_0, self.angles, 256);
    } else {
      self clearpath();
    }
  }
}