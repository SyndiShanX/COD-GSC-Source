/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: core\_multi_extracam.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#namespace multi_extracam;

function extracam_reset_index(localclientnum, index) {
  if(!isdefined(level.camera_ents) || !isdefined(level.camera_ents[localclientnum])) {
    return;
  }
  if(isdefined(level.camera_ents[localclientnum][index])) {
    level.camera_ents[localclientnum][index] clearextracam();
    level.camera_ents[localclientnum][index] delete();
    level.camera_ents[localclientnum][index] = undefined;
  }
}

function extracam_init_index(localclientnum, target, index) {
  camerastruct = struct::get(target, "targetname");
  return extracam_init_item(localclientnum, camerastruct, index);
}

function extracam_init_item(localclientnum, copy_ent, index) {
  if(!isdefined(level.camera_ents)) {
    level.camera_ents = [];
  }
  if(!isdefined(level.camera_ents[localclientnum])) {
    level.camera_ents[localclientnum] = [];
  }
  if(isdefined(level.camera_ents[localclientnum][index])) {
    level.camera_ents[localclientnum][index] clearextracam();
    level.camera_ents[localclientnum][index] delete();
    level.camera_ents[localclientnum][index] = undefined;
  }
  if(isdefined(copy_ent)) {
    level.camera_ents[localclientnum][index] = spawn(localclientnum, copy_ent.origin, "script_origin");
    level.camera_ents[localclientnum][index].angles = copy_ent.angles;
    level.camera_ents[localclientnum][index] setextracam(index);
    return level.camera_ents[localclientnum][index];
  }
  return undefined;
}