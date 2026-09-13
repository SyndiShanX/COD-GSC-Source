/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\headgear.gsc
***********************************************/

init() {
  level._effect["helmet_pop"] = loadfx("vfx/iw7/core/human/helmet_sdf_army_split.vfx");
}

removeheadgear(equipmentref, slot) {
  self notify("remove_headgear");
  self.hasheadgear = undefined;
}

runheadgear(equipmentref, slot, variantid) {
  self endon("death_or_disconnect");
  self endon("remove_headgear");
  self.hasheadgear = 1;
  self waittill("headgear_save");
  self.hasheadgear = 0;

  if(equipmentref != "")
    scripts\mp\equipment::setequipmentammo(equipmentref, 0);

  runheadgeareffects();
}

runheadgeareffects() {
  playFXOnTag(level._effect["helmet_pop"], self, "j_head");
  self detach(self.headmodel, "");
  self setcustomization(self.bodymodelname, self.backuphead);
  self.headmodel = self.backuphead;
  self attach(self.backuphead, "", 1);
}

getdamagemod() {
  return 0.1;
}

getmaxdamage() {
  return 20;
}