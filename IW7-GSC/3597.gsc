/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 3597.gsc
*********************************************/

func_12F9B() {
  self setscriptablepartstate("amplify", "active", 0);
  self.var_1E57 = 500;
  level thread scripts\mp\battlechatter_mp::saytoself(self, "plr_perk_amplify", undefined, 0.75);
  return 1;
}

end(var_0) {
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
  var_0 = scripts\mp\supers::getcurrentsuperref();
  if(!isDefined(var_0) || var_0 != "super_amplify") {
    return 0;
  }

  if(!scripts\mp\supers::issuperinuse()) {
    return 0;
  }

  return 1;
}

func_1E58(var_0) {
  if(!func_9D41()) {
    return 0;
  }

  var_1 = int(min(self.var_1E57, var_0 * 1));
  self.var_1E57 = self.var_1E57 - var_1;
  var_2 = 100;
  if(self.var_1E57 > 0) {
    var_2 = int(min(floor(var_1 / 10), 1));
  }

  for(var_3 = 0; var_3 <= var_2; var_3++) {
    scripts\mp\supers::func_1613();
    if(!scripts\mp\supers::issuperinuse()) {
      break;
    }
  }

  return var_1;
}