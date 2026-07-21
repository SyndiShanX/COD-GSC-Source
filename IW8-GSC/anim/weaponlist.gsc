/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\weaponlist.gsc
***********************************************/

usingautomaticweapon() {
  return weaponisauto(self.weapon) || weaponisbeam(self.weapon) || weaponburstcount(self.weapon) > 0;
}

usingsemiautoweapon() {
  return weaponissemiauto(self.weapon) || weaponburstcount(self.weapon) == 1;
}

autoshootanimrate() {
  if(usingautomaticweapon())
    return 0.1 / weaponfiretime(self.weapon);
  else
    return 0.5;
}

burstshootanimrate() {
  if(usingautomaticweapon())
    return 0.1 / weaponfiretime(self.weapon);
  else if(_encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::usingpistol())
    return 1;
  else
    return 0.2;
}

waitaftershot() {
  return 0.25;
}

shootanimtime(var_0) {
  if(!usingautomaticweapon() || isDefined(var_0) && var_0 == 1) {
    var_1 = 0.5 + randomfloat(1);
    return weaponfiretime(self.weapon) * var_1;
  } else
    return weaponfiretime(self.weapon);
}

refillclip() {
  if(nullweapon(self.weapon)) {
    self.bulletsinclip = 0;
    return 0;
  }

  if(!isDefined(self.bulletsinclip))
    self.bulletsinclip = weaponclipsize(self.weapon);
  else
    self.bulletsinclip = weaponclipsize(self.weapon);

  if(self.bulletsinclip <= 0)
    return 0;
  else
    return 1;
}

add_weapon(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_2))
    var_2 = 3.0;

  if(!isDefined(var_3))
    var_2 = 1;

  if(!isDefined(var_4))
    var_4 = "_encstr_965306392D3336B2";

  var_0 = tolower(var_0);
  anim.aiweapon[var_0]["_encstr_81EF05D197C12B"] = var_1;
  anim.aiweapon[var_0]["_encstr_84EF055338A18F"] = var_2;
  anim.aiweapon[var_0]["_encstr_88280999EC9B882E7FBAFD"] = var_3;
  anim.aiweapon[var_0]["_encstr_A3CD06BF48102D73"] = var_4;
}

addturret(var_0) {
  anim.aiweapon[tolower(var_0)]["_encstr_81EF05D197C12B"] = "_encstr_A7AF07D1EF1B06683C";
}