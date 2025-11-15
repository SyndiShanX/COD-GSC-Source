/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\killcam_shared.gsc
*************************************************/

#namespace killcam;

function get_killcam_entity_start_time(killcamentity) {
  killcamentitystarttime = 0;
  if(isDefined(killcamentity)) {
    if(isDefined(killcamentity.starttime)) {
      killcamentitystarttime = killcamentity.starttime;
    } else {
      killcamentitystarttime = killcamentity.birthtime;
    }
    if(!isDefined(killcamentitystarttime)) {
      killcamentitystarttime = 0;
    }
  }
  return killcamentitystarttime;
}

function store_killcam_entity_on_entity(killcam_entity) {
  assert(isDefined(killcam_entity));
  self.killcamentitystarttime = get_killcam_entity_start_time(killcam_entity);
  self.killcamentityindex = killcam_entity getentitynumber();
}