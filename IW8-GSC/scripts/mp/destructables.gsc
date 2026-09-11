/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\destructables.gsc
***********************************************/

function init() {
  var0 = getEntArray("destructable", "targetname");

  if(getDvar("scr_destructables") == "0") {
    for(var1 = 0; var1 < var0.size; var1++) {
      var0[var1] delete();
    }

    return;
  }

  for(var1 = 0; var1 < var1.size; var1++) {
    thread destructable_think();
  }
}

function destructable_think() {
  var0 = 40;
  var1 = 0;

  if(isDefined(self.script_accumulate)) {
    var0 = self.script_accumulate;
  }

  if(isDefined(self.script_threshold)) {
    var1 = self.script_threshold;
  }

  if(isDefined(self.script_destructable_area)) {
    var2 = strtok(self.script_destructable_area, " ");

    for(var3 = 0; var3 < var2.size; var3++) {
      blockarea(var2[var3]);
    }
  }

  if(isDefined(self.script_fxid)) {
    self.fx = loadfx(self.script_fxid);
  }

  var4 = 0;
  self setCanDamage(1);

  for(;;) {
    self waittill("damage", var5, var6);

    if(var5 >= var1) {
      var4 += var5;

      if(var4 >= var0) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

function destructable_destruct() {
  var0 = self;

  if(isDefined(self.script_destructable_area)) {
    var1 = strtok(self.script_destructable_area, " ");

    for(var2 = 0; var2 < var1.size; var2++) {
      unblockarea(var1[var2]);
    }
  }

  if(isDefined(var0.fx)) {
    playFX(var0.fx, var0.origin + (0, 0, 6));
  }

  var0 delete();
}

function blockarea(var0) {}

function blockentsinarea(var0, var1) {}

function unblockarea(var0) {}

function unblockentsinarea(var0, var1) {}