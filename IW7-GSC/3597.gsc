/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3597.gsc
************************/

func_12F9B() {
  self setscriptablepartstate("amplify", "active", 0);
  self.var_1E57 = 500;
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_amplify", undefined, 0.75);
  return 1;
}

end(param_00) {
  self notify("amplify_end");
  self.var_1E57 = undefined;
  if(self.loadoutarchetype == "archetype_assault") {
    self setscriptablepartstate("amplify", "neutral", 0);
  }
}

unset() {
  end();
}

func_9D41() {
  var_00 = scripts\mp\supers::getcurrentsuperref();
  if(!isDefined(var_00) || var_00 != "super_amplify") {
    return 0;
  }

  if(!scripts\mp\supers::issuperinuse()) {
    return 0;
  }

  return 1;
}

func_1E58(param_00) {
  if(!func_9D41()) {
    return 0;
  }

  var_01 = int(min(self.var_1E57, param_00 * 1));
  self.var_1E57 = self.var_1E57 - var_01;
  var_02 = 100;
  if(self.var_1E57 > 0) {
    var_02 = int(min(floor(var_01 / 10), 1));
  }

  for(var_03 = 0; var_03 <= var_02; var_03++) {
    scripts\mp\supers::func_1613();
    if(!scripts\mp\supers::issuperinuse()) {
      break;
    }
  }

  return var_01;
}