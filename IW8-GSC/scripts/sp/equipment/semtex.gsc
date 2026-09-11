/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\equipment\semtex.gsc
***********************************************/

function precache(var0) {
  scripts\sp\equipment\offhands::registeroffhandfirefunc(var0, &semtexfiremain);
}

function semtexfiremain(var0, var1) {
  if(!isDefined(var0)) {
    return;
  }

  thread scripts\anim\battlechatter_ai::evaluateattackevent("frag");
  var0 setentityowner(self);
  var0 setotherent(self);
  var0 makeunusable();
  thread semtex_watch_beacon(var0, self);
  thread semtex_watch_stuck();
  thread semtex_watch_fuse();
}

function semtex_watch_beacon(var0, var1) {
  var2 = self getscriptablepartstate("state");
  self endon("entitydeleted");

  if(var2 == "beacon_ai" || var2 == "beacon") {
    return;
  }

  if(isai(var0)) {
    var3 = 2;

    if(isDefined(var1)) {
      var3 = var1;
    }

    self setscriptablepartstate("state", "beacon_ai", 0);
    wait var3;
  }

  self setscriptablepartstate("state", "beacon", 0);
}

function semtex_watch_stuck() {
  self endon("death");
  self waittill("missile_stuck", var0);

  if(isai(var0) && isalive(var0)) {
    semtexstucktoenemy(self, var0);
  }

  if(isPlayer(var0) && isalive(var0)) {
    semtexstucktoplayer();
    return;
  }
}

function semtexstucktoplayer() {}

function semtexstucktoenemy(var0, var1, var2) {
  var1._blackboard.isburning = 1;
  var1.burningtodeath = 0;
  var1.burningdirection = undefined;
  var1.semtexstuckto = 1;
  var3 = anglestoright(var1.angles);
  var4 = vectorNormalize(var0.origin - var1.origin);

  if(vectordot(var3, var4) > 0) {
    var1.burningdirection = "right";
  } else {
    var1.burningdirection = "left";
  }

  var1 scripts\sp\utility::do_damage(1, var0.origin, var0.owner, var0.owner, "MOD_GRENADE", "molotov");
  level thread scripts\sp\equipment\offhands::remove_blackboard_isburning(var1);
  var0.stucktoai = var1;
}

function semtex_watch_fuse() {
  self waittill("explode", var0);
  playrumbleonposition("grenade_rumble", var0);
  earthquake(0.45, 0.7, var0, 800);
}