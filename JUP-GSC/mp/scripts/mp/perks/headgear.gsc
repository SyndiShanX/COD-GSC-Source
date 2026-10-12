/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\perks\headgear.gsc
***********************************************/

#using scripts\common\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\equipment;
#namespace headgear;

function init() {
  level._effect["helmet_pop"] = loadfx("vfx/iw7/core/human/helmet_sdf_army_split.vfx");
}

function removeheadgear(equipmentref, slot) {
  self notify("remove_headgear");
  self.hasheadgear = undefined;
}

function runheadgear(equipmentref, slot, variantid) {
  self endon("death_or_disconnect");
  self endon("remove_headgear");
  self.hasheadgear = 1;
  self waittill("headgear_save");
  self.hasheadgear = 0;

  if(equipmentref != "") {
    scripts\mp\equipment::setequipmentammo(equipmentref, 0);
  }

  runheadgeareffects();
}

function runheadgeareffects() {
  playFXOnTag(level._effect["helmet_pop"], self, "j_head");
  self detach(self.headmodel, "");
  self setcustomization(self.bodymodelname, self.backuphead);
  self.headmodel = self.backuphead;
  self attach(self.backuphead, "", 1);
}

function getdamagemod() {
  return 0.1;
}

function getmaxdamage() {
  return 20;
}