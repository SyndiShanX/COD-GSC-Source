/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_spider_quest.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_zm_weapons;
#using_animtree("generic");
#namespace zm_island_spider_quest;

function init() {
  var_8b462b02 = getminbitcountfornum(2);
  var_fbab08c0 = getminbitcountfornum(3);
  clientfield::register("scriptmover", "spider_queen_mouth_weakspot", 9000, var_8b462b02, "int", & spider_queen_mouth_weakspot, 0, 0);
  clientfield::register("scriptmover", "spider_queen_bleed", 9000, 1, "counter", & spider_queen_bleed, 0, 0);
  clientfield::register("scriptmover", "spider_queen_stage_bleed", 9000, var_fbab08c0, "int", & spider_queen_stage_bleed, 0, 0);
  clientfield::register("scriptmover", "spider_queen_emissive_material", 9000, 1, "int", & spider_queen_emissive_material, 0, 0);
}

function spider_queen_mouth_weakspot(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(isDefined(self.var_8dd4267f)) {
    stopfx(localclientnum, self.var_8dd4267f);
    self.var_8dd4267f = undefined;
  }
  if(newval == 1) {
    self.var_8dd4267f = playFXOnTag(localclientnum, level._effect["spider_queen_weakspot"], self, "tag_turret");
  } else if(newval == 2) {
    self.var_8dd4267f = playFXOnTag(localclientnum, level._effect["spider_queen_mouth_glow"], self, "tag_turret");
  }
}

function spider_queen_bleed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  playFXOnTag(localclientnum, level._effect["spider_queen_bleed_sm"], self, "tag_turret");
}

function spider_queen_stage_bleed(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_770499e7 = playFXOnTag(localclientnum, level._effect["spider_queen_bleed_lg"], self, "tag_turret");
  }
  if(newval == 2) {
    self.var_770499e7 = playFXOnTag(localclientnum, level._effect["spider_queen_bleed_md"], self, "tag_turret");
  }
  if(newval == 3) {
    self.var_770499e7 = playFXOnTag(localclientnum, level._effect["spider_queen_bleed_md"], self, "tag_turret");
  }
  wait(2.5);
  if(isDefined(self.var_770499e7)) {
    stopfx(localclientnum, self.var_770499e7);
    self.var_770499e7 = undefined;
  }
}

function spider_queen_emissive_material(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 1, 1, 1, 0);
  } else {
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, 0, 0, 0);
  }
}