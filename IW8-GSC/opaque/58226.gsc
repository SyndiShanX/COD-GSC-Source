/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58226.gsc
***********************************************/

_id_12F67(var_0, var_1, var_2) {
  var_3 = getentitylessscriptablearrayinradius(undefined, undefined, var_0, var_1, "_encstr_B16705D9AFE22E");

  if(isDefined(var_2)) {
    var_4 = [];

    foreach(var_6 in var_3) {
      var_7 = var_6.origin[2] - var_0[2];

      if(var_7 <= var_2)
        var_4[var_4.size] = var_6;
    }

    var_3 = var_4;
  }

  return var_3;
}

_id_12F66(var_0) {
  self notify("_encstr_B81E1CE6D8275AC1E8B0C46359FAC87BF64EFA99E42B2BF42BD7F638B29B");
  self endon("_encstr_B81E1CE6D8275AC1E8B0C46359FAC87BF64EFA99E42B2BF42BD7F638B29B");
  var_1 = undefined;
  var_2 = undefined;

  if(istrue(var_0)) {
    var_1 = "_encstr_A6320DF8FA32211E4B65343547C62B";
    var_2 = self.heli_intro + (0, 90, 0);
  } else {
    var_1 = "_encstr_A5370E8BC3467AA760C03FC45B31F9B7";
    var_2 = self.heli_intro + (0, -90, 0);
  }

  while(anglesdelta(self.angles, var_2) > 1) {
    var_3 = self getscriptablepartstate("_encstr_B16705D9AFE22E");

    if(var_3 != var_1)
      self setscriptablepartstate("_encstr_B16705D9AFE22E", var_1, 0);

    wait 0.05;
  }

  self setscriptablepartstate("_encstr_B16705D9AFE22E", "_encstr_A583052E42BB5B", 0);
  self scriptabledoorfreeze(1);
}

_id_12F68(var_0) {
  if(self == var_0)
    return 0;

  var_1 = self.heli_intro_vo_done;
  var_2 = var_0.heli_intro_vo_done;
  var_3 = distancesquared(var_1, var_2);

  if(var_3 > 5)
    return 0;

  return 1;
}

matchslopekey(var_0, var_1) {
  var_2 = !var_0;
  var_3 = scripts\common\input_allow::allow_input_internal("_encstr_9A210C32BDB727FACC39BD4F5673", var_2, var_1);

  if(isDefined(var_3))
    self scriptabledoorfreeze(!var_3);
}

matching_correct_bomb_wire_pair() {
  return scripts\common\input_allow::is_input_allowed_internal("_encstr_9A210C32BDB727FACC39BD4F5673");
}