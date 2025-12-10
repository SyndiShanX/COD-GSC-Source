/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\weapons\_decoy.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#namespace decoy;

function init_shared() {
  level thread level_watch_for_fake_fire();
  callback::add_weapon_type("nightingale", &spawned);
}

function spawned(localclientnum) {
  self thread watch_for_fake_fire(localclientnum);
}

function watch_for_fake_fire(localclientnum) {
  self endon("entityshutdown");
  while(true) {
    self waittill("fake_fire");
    playFXOnTag(localclientnum, level._effect["decoy_fire"], self, "tag_origin");
  }
}

function level_watch_for_fake_fire() {
  while(true) {
    self waittill("fake_fire", origin);
  }
}