/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 3134.gsc
**************************************/

_id_3EA2(var_0, var_1, var_2) {
  var_3 = isexplosivedamagemod(self.damagemod) && self.damagetaken > 50 || isDefined(self._blackboard._id_A983) && self._blackboard._id_A983 == gettime();
  var_4 = _id_0A1E::_id_7E5A();

  if(var_3)
    var_5 = var_4;
  else
    var_5 = var_4 + "_small";

  var_6 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);

  if(!var_3 || _id_8C21(var_6))
    return var_6;

  return scripts\asm\asm::asm_lookupanimfromalias(var_1, "default");
}

_id_8C21(var_0) {
  var_1 = getmovedelta(var_0);
  var_2 = self _meth_84AC();
  var_3 = rotatevector(var_1, self.angles);
  var_4 = var_2 + var_3;
  var_5 = navtrace(var_2, var_4, self, 1);

  if(var_5["fraction"] > 0.9)
    return 1;

  return 0;
}

_id_3433(var_0, var_1, var_2) {
  var_3 = _id_0A1E::_id_7E5A();
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
}

_id_3430(var_0, var_1, var_2) {
  if(self.asm.footsteps.foot == "right")
    var_3 = "right8";
  else
    var_3 = "left8";

  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_3);
  return var_4;
}