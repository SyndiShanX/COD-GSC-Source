/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_human.csc
*************************************************/

#using scripts\shared\ai\systems\fx_character;
#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace archetype_human;

function autoexec precache() {}

function autoexec main() {
  clientfield::register("actor", "facial_dial", 1, 1, "int", &humanclientutils::facialdialoguehandler, 0, 1);
}

#namespace humanclientutils;

function facialdialoguehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self.facialdialogueactive = 1;
  } else if(isDefined(self.facialdialogueactive) && self.facialdialogueactive) {
    self clearanim(%generic::faces, 0);
  }
}