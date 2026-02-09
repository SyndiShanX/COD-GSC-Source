/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: 42836.gsc
**************************************/

target_enhancer_think() {
  self endon("death");
  self endon("disconnect");
  self endon("faux_spawn");
  var_0 = 10;
  var_1 = cos(var_0);
  var_2 = 0.5;
  self.has_target_enhancer = 0;

  for(;;) {
    while(self.has_target_enhancer && self playerads() < var_2) {
      wait 0.05;
    }

    if(!self.has_target_enhancer) {
      wait 0.05;
      continue;
    }

    if(self isusingturret()) {
      wait 0.05;
      continue;
    }

    if(isDefined(self.empon) && self.empon) {
      waitframe();
      continue;
    }

    if(isPlayer(self)) {
      childthread maps\mp\_threatdetection::detection_highlight_hud_effect(self, 0.05, 1);
    }

    wait 0.05;
  }
}