/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: clientscripts\_triple25.csc
*****************************************************/

#include clientscripts\_vehicle;
#include clientscripts\_music;

main(model, type) {
  build_treadfx("triple25");
}

triple25_shoot() {
  notifystring = "25s" + self getentitynumber();
  level endon(notifystring);
  self endon("entityshutdown");
  level endon("save_restore");
  while(1) {
    num_shots = randomintrange(5, 15);
    waittime = randomfloatrange(0.5, 2);
    for(i = 0; i < num_shots; i++) {
      self fireweapon();
      realwait(0.1);
    }
    realwait(waittime);
  }
}