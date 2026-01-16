/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: maps\mp\_destructables.gsc
********************************/

init() {
  var_0 = getentarray("destructable", "targetname");

  if(getdvar("scr_destructables") == "0") {
    for (var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] delete();
  } else {
    for (var_1 = 0; var_1 < var_0.size; var_1++)
      var_0[var_1] thread destructable_think();
  }
}

destructable_think() {
  var_0 = 40;
  var_1 = 0;

  if(isdefined(self.script_accumulate))
    var_0 = self.script_accumulate;

  if(isdefined(self.script_threshold))
    var_1 = self.script_threshold;

  if(isdefined(self.script_destructable_area)) {
    var_2 = strtok(self.script_destructable_area, " ");

    for (var_3 = 0; var_3 < var_2.size; var_3++)
      blockarea(var_2[var_3]);
  }

  if(isdefined(self.script_fxid))
    self.fx = loadfx(self.script_fxid);

  var_4 = 0;
  self setcandamage(1);

  for (;;) {
    self waittill("damage", var_5, var_6);

    if(var_5 >= var_1) {
      var_4 = var_4 + var_5;

      if(var_4 >= var_0) {
        thread destructable_destruct();
        return;
      }
    }
  }
}

destructable_destruct() {
  var_0 = self;

  if(isdefined(self.script_destructable_area)) {
    var_1 = strtok(self.script_destructable_area, " ");

    for (var_2 = 0; var_2 < var_1.size; var_2++)
      unblockarea(var_1[var_2]);
  }

  if(isdefined(var_0.fx))
    playfx(var_0.fx, var_0.origin + (0, 0, 6));

  var_0 delete();
}

blockarea(var_0) {}

blockentsinarea(var_0, var_1) {}

unblockarea(var_0) {}

unblockentsinarea(var_0, var_1) {}