/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\perks.gsc
***********************************************/

#namespace perks;

perk_setperk(str_perk) {
  if(!isDefined(self.var_fb3c9d6a)) {
    self.var_fb3c9d6a = [];
  }

  if(!isDefined(self.var_fb3c9d6a[str_perk])) {
    self.var_fb3c9d6a[str_perk] = 0;
  }

  assert(self.var_fb3c9d6a[str_perk] >= 0, "<dev string:x38>");
  assert(self.var_fb3c9d6a[str_perk] < 23, "<dev string:x52>");
  self.var_fb3c9d6a[str_perk]++;
  self setperk(str_perk);
}

perk_unsetperk(str_perk) {
  if(!isDefined(self.var_fb3c9d6a)) {
    self.var_fb3c9d6a = [];
  }

  if(!isDefined(self.var_fb3c9d6a[str_perk])) {
    self.var_fb3c9d6a[str_perk] = 0;
  }

  self.var_fb3c9d6a[str_perk]--;
  assert(self.var_fb3c9d6a[str_perk] >= 0, "<dev string:x38>");

  if(self.var_fb3c9d6a[str_perk] <= 0) {
    self unsetperk(str_perk);
  }
}

perk_hasperk(str_perk) {
  if(isDefined(self.var_fb3c9d6a) && isDefined(self.var_fb3c9d6a[str_perk]) && self.var_fb3c9d6a[str_perk] > 0) {
    return true;
  }

  return false;
}

perk_reset_all() {
  self clearperks();
  self.var_fb3c9d6a = [];
}