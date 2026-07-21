/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\equipment\semtex.gsc
***********************************************/

precache(var_0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var_0, ::semtexfiremain);
}

semtexfiremain(var_0, var_1) {
  if(!isDefined(var_0)) {
    return;
  }
  thread scripts\anim\battlechatter_ai.gsc::evaluateattackevent("frag");
  var_0 setentityowner(self);
  var_0 setotherent(self);
  var_0 makeunusable();
  var_0 thread semtex_watch_beacon(self, var_1);
  var_0 thread semtex_watch_stuck();
  var_0 thread semtex_watch_fuse();
}

semtex_watch_beacon(var_0, var_1) {
  var_2 = self getscriptablepartstate("state");
  self endon("entitydeleted");

  if(var_2 == "beacon_ai" || var_2 == "beacon") {
    return;
  }
  if(isai(var_0)) {
    var_3 = 2;

    if(isDefined(var_1))
      var_3 = var_1;

    self setscriptablepartstate("state", "beacon_ai", 0);
    wait(var_3);
  }

  self setscriptablepartstate("state", "beacon", 0);
}

semtex_watch_stuck() {
  self endon("death");
  self waittill("missile_stuck", var_0);

  if(isai(var_0) && isalive(var_0))
    semtexstucktoenemy(self, var_0);

  if(isPlayer(var_0) && isalive(var_0))
    semtexstucktoplayer();
}

semtexstucktoplayer() {}

semtexstucktoenemy(var_0, var_1, var_2) {
  var_1._blackboard.isburning = 1;
  var_1.burningtodeath = 0;
  var_1.burningdirection = undefined;
  var_1.semtexstuckto = 1;
  var_3 = anglestoright(var_1.angles);
  var_4 = vectorNormalize(var_0.origin - var_1.origin);

  if(vectordot(var_3, var_4) > 0)
    var_1.burningdirection = "right";
  else
    var_1.burningdirection = "left";

  var_1 scripts\sp\utility::do_damage(1, var_0.origin, var_0.owner, var_0.owner, "MOD_GRENADE", "molotov");
  level thread scripts\sp\equipment\offhands::remove_blackboard_isburning(var_1);
  var_0.stucktoai = var_1;
}

semtex_watch_fuse() {
  self waittill("explode", var_0);
  playrumbleonposition("grenade_rumble", var_0);
  earthquake(0.45, 0.7, var_0, 800);
}