/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\trials\mp_oilrig_create_script.gsc
*************************************************/

_id_1348C(var_0, var_1, var_2) {
  var_3 = scripts\asm\soldier\pain::getpainweaponsize();
  var_4 = scripts\asm\soldier\death::getpainbodypartdeath();
  var_3 = "_encstr_A71A0491BA77";
  var_5 = anglesToForward(self.angles);
  var_6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var_7 = vectorNormalize((var_5[0], var_5[1], 0));
  var_8 = scripts\asm\soldier\death::meleegetattackercardinaldirection(var_7, var_6);
  var_9 = undefined;

  if(var_8 == 2)
    var_9 = "_encstr_8B0703EBE0";
  else if(var_8 == 3)
    var_9 = "_encstr_A50703AFD8";
  else if(var_8 == 1)
    var_9 = "_encstr_AF0703DE3B";
  else
    var_9 = "_encstr_8C0703271D";

  var_10 = var_4 + var_3 + var_9;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_10);
}

_id_1348E(var_0, var_1, var_2) {
  var_3 = length(self.velocity);
  var_4 = scripts\asm\shared\utility::getbasearchetype();
  var_5 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::_id_1349E();
  var_6 = [];
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);

  if(var_6.size == 0)
    return scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_8B1608EC43B8D647A113");

  return var_6[randomint(var_6.size)];
}