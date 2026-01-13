/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: 2833.gsc
*********************************************/

func_37A9() {
  precachemodel("fx_org_view");
}

func_CCBE() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("tag_origin");
  var_0 linkto(level.player, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.var_C04F = 1;
  level.player.var_763C = var_0;
  var_1 = scripts\engine\utility::getstructarray("fxchain_start", "script_noteworthy");
  level.var_AD40 = [];
  level.var_C1E0 = var_1.size;
  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_1[var_2].var_3C0A = var_2;
    var_1[var_2] func_6C76();
  }

  var_1 = undefined;
  level.var_C1E0 = undefined;
  level.var_AD40 = scripts\engine\utility::array_sort_with_func(level.var_AD40, ::func_445A);
  level.var_37CF = level.var_AD40[0]["start_struct"];
  level.var_37CE = 0;
  playFXOnTag(scripts\engine\utility::getfx(level.var_37CF.script_parameters), var_0, "tag_origin");
  level.var_AD40 = undefined;
  var_3 = scripts\engine\utility::getstructarray("fxchain_transition", "targetname");
  thread func_68A8(var_0);
  for(;;) {
    wait(0.25);
    if(level.var_37CE) {
      continue;
    }

    if(var_3.size > 0) {
      var_4 = sortbydistance(var_3, level.player.origin)[0];
      if(distance2dsquared(level.player.origin, var_4.origin) <= squared(var_4.fgetarg)) {
        var_5 = scripts\engine\utility::getstruct(var_4.script_noteworthy, "targetname");
        var_6 = scripts\engine\utility::getstruct(var_4.script_parameters, "targetname");
        var_7 = vectordot(anglesToForward(var_4.angles), level.player.origin - var_4.origin);
        var_8 = undefined;
        if(var_7 > 0 && level.var_37CF.var_3C0A == var_6.var_3C0A) {
          var_8 = var_5;
        }

        if(var_7 < 0 && level.var_37CF.var_3C0A == var_5.var_3C0A) {
          var_8 = var_6;
        }

        if(isDefined(var_8)) {
          func_12660(var_8, var_0);
        }
      }
    }

    var_9 = [];
    foreach(var_0B in scripts\engine\utility::getstructarray(level.var_37CF.var_336, "target")) {
      var_9[var_9.size] = func_7A8D(var_0B, level.var_37CF);
    }

    if(isDefined(level.var_37CF.target)) {
      var_0D = scripts\engine\utility::getstructarray(level.var_37CF.target, "targetname");
      foreach(var_0F in var_0D) {
        var_9[var_9.size] = func_7A8D(level.var_37CF, var_0F);
        if(isDefined(var_0F.target)) {
          var_10 = scripts\engine\utility::getstructarray(var_0F.target, "targetname");
          foreach(var_12 in var_10) {
            var_9[var_9.size] = func_7A8D(var_0F, var_12);
          }
        }
      }
    }

    var_9 = scripts\engine\utility::array_sort_with_func(var_9, ::func_445A);
    var_8 = var_9[0]["start_struct"];
    if(var_8.origin != level.var_37CF.origin) {
      if(var_8.script_parameters != level.var_37CF.script_parameters) {
        func_12660(var_8, var_0);
        continue;
      }

      level.var_37CF = var_8;
    }
  }
}

func_6C76() {
  if(isDefined(self.target)) {
    var_0 = scripts\engine\utility::getstructarray(self.target, "targetname");
    foreach(var_2 in var_0) {
      if(!isDefined(var_2.var_3C0A)) {
        var_2.var_3C0A = self.var_3C0A;
        level.var_AD40[level.var_AD40.size] = func_7A8D(self, var_2);
        level.var_C1E0++;
        var_2 func_6C76();
      }
    }
  }
}

func_7A8D(var_0, var_1) {
  var_2 = [];
  var_2["start_struct"] = var_0;
  var_2["closest_point"] = pointonsegmentnearesttopoint(var_0.origin, var_1.origin, level.player.origin);
  return var_2;
}

func_445A(var_0, var_1) {
  return distancesquared(var_0["closest_point"], level.player.origin) < distancesquared(var_1["closest_point"], level.player.origin);
}

func_68A8(var_0) {}

func_12660(var_0, var_1) {
  stopFXOnTag(scripts\engine\utility::getfx(level.var_37CF.script_parameters), var_1, "tag_origin");
  playFXOnTag(scripts\engine\utility::getfx(var_0.script_parameters), var_1, "tag_origin");
  level.var_37CF = var_0;
}