/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\archetype_direwolf.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\system_shared;
#namespace archetypedirewolf;

function autoexec __init__sytem__() {
  system::register("direwolf", & __init__, undefined, undefined);
}

function autoexec precache() {
  level._effect["fx_bio_direwolf_eyes"] = "animals/fx_bio_direwolf_eyes";
}

function __init__() {
  if(ai::shouldregisterclientfieldforarchetype("direwolf")) {
    clientfield::register("actor", "direwolf_eye_glow_fx", 1, 1, "int", & direwolfeyeglowfxhandler, 0, 1);
  }
}

function private direwolfeyeglowfxhandler(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  entity = self;
  if(isDefined(entity.archetype) && entity.archetype != "direwolf") {
    return;
  }
  if(isDefined(entity.eyeglowfx)) {
    stopfx(localclientnum, entity.eyeglowfx);
    entity.eyeglowfx = undefined;
  }
  if(newvalue) {
    entity.eyeglowfx = playFXOnTag(localclientnum, level._effect["fx_bio_direwolf_eyes"], entity, "tag_eye");
  }
}