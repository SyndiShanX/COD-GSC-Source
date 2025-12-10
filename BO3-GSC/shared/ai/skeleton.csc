/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\skeleton.csc
*************************************************/

#using scripts\shared\ai\systems\gib;
#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace skeleton;

function autoexec __init__sytem__() {
  system::register("skeleton", &__init__, undefined, undefined);
}

function autoexec precache() {}

function __init__() {
  if(ai::shouldregisterclientfieldforarchetype("skeleton")) {
    clientfield::register("actor", "skeleton", 1, 1, "int", &zombieclientutils::zombiehandler, 0, 0);
  }
}

#namespace zombieclientutils;

function zombiehandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(isDefined(entity.archetype) && entity.archetype != "zombie") {
    return;
  }
  if(!isDefined(entity.initializedgibcallbacks) || !entity.initializedgibcallbacks) {
    entity.initializedgibcallbacks = 1;
    gibclientutils::addgibcallback(localclientnum, entity, 8, &_gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 16, &_gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 32, &_gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 128, &_gibcallback);
    gibclientutils::addgibcallback(localclientnum, entity, 256, &_gibcallback);
  }
}

function private _gibcallback(localclientnum, entity, gibflag) {
  switch (gibflag) {
    case 8: {
      playSound(0, "zmb_zombie_head_gib", self.origin);
      break;
    }
    case 16:
    case 32:
    case 128:
    case 256: {
      playSound(0, "zmb_death_gibs", self.origin);
      break;
    }
  }
}