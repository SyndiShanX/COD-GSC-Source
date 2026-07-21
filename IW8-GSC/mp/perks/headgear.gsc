/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\perks\headgear.gsc
***********************************************/

init() {
  level._effect["_encstr_84FB0BB0679C4023A309EF78DA"] = loadfx("_encstr_A31E2D644E7006D83FA35747DA03726F596BADE7956699FF99AFA3D32F6045CEA97E08553979CB41FB7C3B1DF33790");
}

removeheadgear(var_0, var_1) {
  self notify("_encstr_AFC7104BC1D9CFEB503FE0F55B80772F779B");
  self.hasheadgear = undefined;
}

runheadgear(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_AFC7104BC1D9CFEB503FE0F55B80772F779B");
  self.hasheadgear = 1;
  self waittill("_encstr_888D0ED059C2913B2B85C9F5B985EC59");
  self.hasheadgear = 0;

  if(var_0 != "_encstr_B40101")
    scripts\mp\equipment::setequipmentammo(var_0, 0);

  runheadgeareffects();
}

runheadgeareffects() {
  playFXOnTag(level._effect["_encstr_84FB0BB0679C4023A309EF78DA"], self, "_encstr_AADA07DBF19A4A81D7");
  self detach(self.headmodel, "_encstr_B40101");
  self setcustomization(self.bodymodelname, self.backuphead);
  self.headmodel = self.backuphead;
  self attach(self.backuphead, "_encstr_B40101", 1);
}

getdamagemod() {
  return 0.1;
}

getmaxdamage() {
  return 20;
}