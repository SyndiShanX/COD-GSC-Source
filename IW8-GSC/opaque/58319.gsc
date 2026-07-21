/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: opaque\58319.gsc
***********************************************/

_id_12425(var_0, var_1, var_2) {
  var_3 = undefined;

  if(isDefined(var_2)) {
    var_3 = spawnStruct();
    var_3.intvar = var_2;
  }

  if(isalive(var_0))
    _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, var_1, var_3);
  else
    var_0 thread _id_12981(_encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_0, var_1, var_3));
}

_id_12424(var_0, var_1) {
  foreach(var_3 in level.players) {
    if(!isDefined(var_3)) {
      continue;
    }
    var_4 = undefined;

    if(isalive(var_3)) {
      if(isDefined(var_1)) {
        var_4 = spawnStruct();
        var_4.intvar = var_1;
      }

      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(var_3, var_0, var_4);
      continue;
    }

    if(!isDefined(var_4))
      var_4 = spawnStruct();

    var_4.intvar = var_1;
    var_4._id_136F3 = var_0;
    var_3 thread _id_12981(var_4);
  }
}

_id_12981(var_0) {
  self notify("_encstr_999A1C873190FC61366933FF9753A921E8997B4FEE50925A046F1FBB930D");
  self endon("_encstr_999A1C873190FC61366933FF9753A921E8997B4FEE50925A046F1FBB930D");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  level endon("_encstr_8D820B49520F0EC02DDE6367EC");

  if(!isDefined(self.isflagcarrymode))
    self.isflagcarrymode = [];

  self.isflagcarrymode = scripts\engine\utility::array_add(self.isflagcarrymode, var_0);

  while(self.isflagcarrymode.size > 0) {
    if(isalive(self)) {
      wait 0.5;

      foreach(var_2 in self.isflagcarrymode)
      _encstr_A6352770DA7223FB2B7390B9689EC1FB1D02C0B883CF4F585B9A50AF45DF0B6949EB78B0DAB5AFEB27::displayplayersplash(self, var_2._id_136F3, var_2);

      self.isflagcarrymode = [];
      break;
    }

    wait 1.0;
  }
}