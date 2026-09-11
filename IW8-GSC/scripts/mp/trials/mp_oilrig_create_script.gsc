/*********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\trials\mp_oilrig_create_script.gsc
*********************************************************/

function ref_1348c(var0, var1, var2) {
  var3 = scripts\asm\soldier\pain::getpainweaponsize();
  var4 = scripts\asm\soldier\death::getpainbodypartdeath();
  var3 = "_md";
  var5 = anglesToForward(self.angles);
  var6 = vectorNormalize((self.damagedir[0], self.damagedir[1], 0));
  var7 = vectorNormalize((var5[0], var5[1], 0));
  var8 = scripts\asm\soldier\death::meleegetattackercardinaldirection(var7, var6);
  var9 = undefined;

  if(var8 == 2) {
    var9 = "_8";
  } else if(var8 == 3) {
    var9 = "_6";
  } else if(var8 == 1) {
    var9 = "_4";
  } else {
    var9 = "_2";
  }

  var10 = var4 + var3 + var9;
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var10);
}

function ref_1348e(var0, var1, var2) {
  var3 = length(self.velocity);
  var4 = scripts\asm\shared\utility::getbasearchetype();
  var5 = scripts\mp\trials\mp_euphrates_create_script_gunnonlinear::ref_1349e();
  var6 = [];
  return scripts\asm\asm::asm_lookupanimfromalias(var1, var5);
}