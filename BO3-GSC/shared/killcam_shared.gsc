/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\killcam_shared.gsc
*************************************************/

#namespace killcam;

function get_killcam_entity_start_time(killcamentity) {
  killcamentitystarttime = 0;
  if(isdefined(killcamentity)) {
    if(isdefined(killcamentity.starttime)) {
      killcamentitystarttime = killcamentity.starttime;
    } else {
      killcamentitystarttime = killcamentity.birthtime;
    }
    if(!isdefined(killcamentitystarttime)) {
      killcamentitystarttime = 0;
    }
  }
  return killcamentitystarttime;
}

function store_killcam_entity_on_entity(killcam_entity) {
  assert(isdefined(killcam_entity));
  self.killcamentitystarttime = get_killcam_entity_start_time(killcam_entity);
  self.killcamentityindex = killcam_entity getentitynumber();
}