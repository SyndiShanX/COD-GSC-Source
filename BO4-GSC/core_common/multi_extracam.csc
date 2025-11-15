/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\multi_extracam.csc
***********************************************/

#include scripts\core_common\struct;

#namespace multi_extracam;

extracam_reset_index(localclientnum, index) {
  if(!isDefined(level.camera_ents) || !isDefined(level.camera_ents[localclientnum])) {
    return;
  }

  if(isDefined(level.camera_ents[localclientnum][index])) {
    level.camera_ents[localclientnum][index] clearextracam();
    level.camera_ents[localclientnum][index] delete();
    level.camera_ents[localclientnum][index] = undefined;
  }
}

extracam_init_index(localclientnum, target, index) {
  camerastruct = struct::get(target, "targetname");
  return extracam_init_item(localclientnum, camerastruct, index);
}

extracam_init_item(localclientnum, copy_ent, index) {
  if(!isDefined(level.camera_ents)) {
    level.camera_ents = [];
  }

  if(!isDefined(level.camera_ents[localclientnum])) {
    level.camera_ents[localclientnum] = [];
  }

  if(isDefined(level.camera_ents[localclientnum][index])) {
    level.camera_ents[localclientnum][index] clearextracam();
    level.camera_ents[localclientnum][index] delete();
    level.camera_ents[localclientnum][index] = undefined;
  }

  if(isDefined(copy_ent)) {
    level.camera_ents[localclientnum][index] = spawn(localclientnum, copy_ent.origin, "script_origin");
    level.camera_ents[localclientnum][index].angles = copy_ent.angles;
    level.camera_ents[localclientnum][index] setextracam(index);
    return level.camera_ents[localclientnum][index];
  }

  return undefined;
}