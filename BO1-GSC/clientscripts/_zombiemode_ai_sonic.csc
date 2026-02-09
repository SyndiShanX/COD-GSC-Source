/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_zombiemode_ai_sonic\.csc
**************************************************/

#include clientscripts\_utility;

init_sonic_zombie() {
  register_clientflag_callback("actor", level._CF_ACTOR_IS_SONIC_ZOMBIE, ::sonic_zombie_callback);
}
sonic_zombie_callback(client_num, set, newEnt) {
  if(set) {
    self thread sonic_ambient_sounds(client_num);
  } else {
    self thread sonic_ambiet_sounds_stop(client_num);
  }
}
sonic_ambient_sounds(client_num) {
  if(client_num != 0) {
    return;
  }
  self playLoopSound("evt_sonic_ambient_loop", 1);
}
sonic_ambiet_sounds_stop(client_num) {
  self notify("stop_sounds");
}