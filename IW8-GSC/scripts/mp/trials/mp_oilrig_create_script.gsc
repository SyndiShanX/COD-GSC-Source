/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_oilrig_create_script.gsc
*********************************************************/

function ref_1348C(var_0, var_1, var_2) {
  var_3 = scripts\asm\soldier\pain::getpainweaponsize();
  var_4 = scripts\asm\soldier\death::getpainbodypartdeath();
  var_3 = "_md";
  var_5 = anglesToForward(self.angles);
  var_6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var_7 = vectorNormalize((var_5[0], var_5[1], 0));
  var_8 = scripts\asm\soldier\death::meleegetattackercardinaldirection(var_7, var_6);
  var_9 = undefined;

  if(var_8 == 2) {
    var_9 = "_8";
  } else if(var_8 == 3) {
    var_9 = "_6";
  } else if(var_8 == 1) {
    var_9 = "_4";
  } else {
    var_9 = "_2";
  }

  var_10 = var_4 + var_3 + var_9;
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_10);
}

function ref_1348E(var_0, var_1, var_2) {
  var_3 = length(self.velocity);
  var_4 = scripts\asm\shared\utility::getbasearchetype();
  var_5 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349E();
  var_6 = [];
  return scripts\asm\asm::asm_lookupanimfromalias(var_1, var_5);
}