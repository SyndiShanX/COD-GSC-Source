/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\notetrack.gsc
***********************************************/

function start_notetrack_wait(var0, var1, var2, var3, var4) {
  var0 notify("stop_sequencing_notetracks");
  thread notetrack_wait(var0, var1, self, var2, var3, var4);
}

function notetrack_wait(var0, var1, var2, var3, var4, var5) {
  var0 endon("stop_sequencing_notetracks");
  var0 endon("death");

  if(isDefined(var2)) {
    var6 = var2;
  } else {
    var6 = self;
  }

  var7 = undefined;

  if(isDefined(var5)) {
    var7 = var5;
  } else {
    var7 = var1.animname;
  }

  var8 = spawnStruct();
  var8.dialog = [];
  var9 = [];

  if(isDefined(var7) && isDefined(level.scr_notetrack[var7]) && isDefined(var4)) {
    if(isDefined(level.scr_notetrack[var7][var4])) {
      GscBinSkip0(0x2e, var4, level.scr_notetrack[var7][var4]);
    }

    if(isDefined(level.scr_notetrack[var7]["any"])) {
      GscBinSkip0(0x2e, "any", level.scr_notetrack[var7]["any"]);
    }
  }

  foreach(var11 in var9) {
    foreach(var13 in level.scr_notetrack[var7][var18]) {
      foreach(var15 in var13) {
        if(isDefined(var15["dialog"])) {
          var8.dialog[var15["dialog"]] = 1;
        }
      }
    }
  }

  var19 = 0;
  var20 = 0;

  for(;;) {
    var8.dialoguenotetrack = 0;
    var21 = undefined;

    if(!var19 && isDefined(var7) && isDefined(var4)) {
      var19 = 1;
      var22 = undefined;
      var20 = isDefined(level.scr_notetrack[var7]) && isDefined(level.scr_notetrack[var7][var4]) && isDefined(level.scr_notetrack[var7][var4]["start"]);

      if(!var20) {
        continue;
      }

      var23 = ["start"];
    } else {
      var1 waittill(var2, var23);
    }

    if(!isarray(var23)) {
      var23 = [var23];
    }

    printnotetracks(var1, var23);
    validatenotetracks(var2, var23, var6);
    var24 = undefined;

    foreach(var26 in var23) {
      notetrack_handler(var1, var4, var26, var7, var9, var6, var8);

      if(var26 == "end") {
        var24 = 1;
      }
    }

    if(isDefined(var24)) {
      break;
    }
  }
}

function notetrack_handler(var0, var1, var2, var3, var4, var5, var6) {
  if(var2 == "end") {
    return 1;
  }

  foreach(var8 in var4) {
    if(isDefined(level.scr_notetrack[var3][var12][var2])) {
      foreach(var10 in level.scr_notetrack[var3][var12][var2]) {
        [[anim.callbacks["AnimHandleNotetrack"]]](var10, var0, var6, var5);
      }
    }
  }

  if(isDefined(anim.callbacks["EntityHandleNotetrack"])) {
    [[anim.callbacks["EntityHandleNotetrack"]]](var0, var2);
    return;
  }
}

function anim_handle_notetrack(var0, var1, var2, var3) {
  if(isDefined(var0["function"])) {
    self thread[[var0["function"]]](var1);
  }

  if(isDefined(var0["notify"])) {
    level notify(var0["notify"]);
  }

  if(isDefined(var0["attach model"])) {
    if(isDefined(var0["selftag"])) {
      var1 attach(var0["attach model"], var0["selftag"]);
      return;
    }

    var3 attach(var0["attach model"], var0["tag"]);
    return;
  }

  if(isDefined(var0["detach model"])) {
    if(isDefined(var0["selftag"])) {
      var1 detach(var0["detach model"], var0["selftag"]);
    } else {
      var3 detach(var0["detach model"], var0["tag"]);
    }
  }

  if(!var2.dialoguenotetrack) {
    if(isDefined(var0["dialog"]) && isDefined(var2.dialog[var0["dialog"]])) {
      var1 scripts\anim\face::sayspecificdialogue(var0["dialog"]);
      var2.dialog[var0["dialog"]] = undefined;
      var2.dialoguenotetrack = 1;
    }
  }

  if(isDefined(var0["create model"])) {
    anim_addmodel(var1, var0);
  } else if(isDefined(var0["delete model"])) {
    anim_removemodel(var1, var0);
  }

  if(isDefined(var0["selftag"])) {
    if(isDefined(var0["effect"])) {
      thread notetrack_effect(level, var1);
    }

    if(isDefined(var0["stop_effect"])) {
      stopFXOnTag(level._effect[var0["stop_effect"]], var1, var0["selftag"]);
    }

    if(isDefined(var0["swap_part_to_efx"])) {
      playFXOnTag(level._effect[var0["swap_part_to_efx"]], var1, var0["selftag"]);
      var1 hidepart(var0["selftag"]);
    }

    if(isDefined(var0["trace_part_for_efx"])) {
      var4 = undefined;
      var5 = scripts\engine\utility::getfx(var0["trace_part_for_efx"]);

      if(isDefined(var0["trace_part_for_efx_water"])) {
        var4 = scripts\engine\utility::getfx(var0["trace_part_for_efx_water"]);
      }

      var6 = 0;

      if(isDefined(var0["trace_part_for_efx_delete_depth"])) {
        var6 = var0["trace_part_for_efx_delete_depth"];
      }

      thread trace_part_for_efx(var1, var0["selftag"], var5, var4);
    }

    if(isDefined(var0["trace_part_for_efx_canceling"])) {
      thread trace_part_for_efx_cancel(var1);
    }
  }

  if(isDefined(var0["tag"]) && isDefined(var0["effect"])) {
    playFXOnTag(level._effect[var0["effect"]], var3, var0["tag"]);
  }

  if(isDefined(var0["selftag"]) && isDefined(var0["effect_looped"])) {
    playFXOnTag(level._effect[var0["effect_looped"]], var1, var0["selftag"]);
    return;
  }
}

function anim_addmodel(var0, var1) {
  if(!isDefined(var0.scriptmodel)) {
    var0.scriptmodel = [];
  }

  var2 = var0.scriptmodel.size;
  var0.scriptmodel[var2] = spawn("script_model", (0, 0, 0));
  var0.scriptmodel[var2] setModel(var1["create model"]);
  var0.scriptmodel[var2].origin = var0 gettagorigin(var1["selftag"]);
  var0.scriptmodel[var2].angles = var0 gettagangles(var1["selftag"]);
}

function anim_removemodel(var0, var1) {
  for(var2 = 0; var2 < var0.scriptmodel.size; var2++) {
    if(isDefined(var1["explosion"])) {
      var3 = anglesToForward(var0.scriptmodel[var2].angles);
      var3 *= 120;
      var3 += var0.scriptmodel[var2].origin;
      playFX(level._effect[var1["explosion"]], var0.scriptmodel[var2].origin);
      radiusdamage(var0.scriptmodel[var2].origin, 350, 700, 50);
    }

    var0.scriptmodel[var2] delete();
  }
}

function notetrack_effect(var0, var1) {
  var2 = isDefined(var1["moreThanThreeHack"]);

  if(var2) {
    scripts\engine\utility::lock("moreThanThreeHack");
  }

  playFXOnTag(level._effect[var1["effect"]], var0, var1["selftag"]);

  if(var2) {
    scripts\engine\utility::unlock("moreThanThreeHack");
    return;
  }
}

function trace_part_for_efx_cancel(var0) {
  self notify("cancel_trace_for_part_" + var0);
}

function trace_part_for_efx(var0, var1, var2, var3) {
  var4 = "trace_part_for_efx";
  self endon("cancel_trace_for_part_" + var0);
  var5 = self gettagorigin(var0);
  var6 = 0;
  var7 = spawnStruct();
  var7.last_pos = self gettagorigin(var0);
  var7.hit_surface = 0;
  var7.part = var0;
  var7.hit_water = 0;
  var7.effect = var1;
  var7.stationary = 0;
  var7.last_motion_time = gettime();

  while(isDefined(self) && !var7.hit_surface) {
    scripts\engine\utility::lock(var4);
    test_trace_tag(var7);
    scripts\engine\utility::unlock_wait(var4);

    if(var7.stationary == 1 && gettime() - var7.last_motion_time > 3000) {
      return;
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var2) && var7.hit_water) {
    var1 = var2;
  }

  playFX(var1, var7.last_pos);

  if(var3 == 0) {
    self hidepart(var0);
    return;
  }

  thread hidepartatdepth(var7.last_pos[2] - var3, var0);
}

function hidepartatdepth(var0, var1) {
  self endon("entitydeleted");

  while(self gettagorigin(var1)[2] > var0) {
    wait 0.05;
  }

  self hidepart(var1);
}

function test_trace_tag(var0) {
  var1 = undefined;

  if(!isDefined(self)) {
    return;
  }

  var0.current_pos = self gettagorigin(var0.part);

  if(var0.current_pos != var0.last_pos) {
    var0.last_motion_time = gettime();
    var0.stationary = 0;

    if(!scripts\engine\trace::_bullet_trace_passed(var0.last_pos, var0.current_pos, 0, self)) {
      var2 = scripts\engine\trace::_bullet_trace(var0.last_pos, var0.current_pos, 0, self);

      if(var2["fraction"] < 1) {
        var0.last_pos = var2["position"];
        var0.hit_water = var2["surfacetype"] == "water";
        var0.hit_surface = 1;
        return;
      }
    }
  } else {
    var0.stationary = 1;
  }

  var0.last_pos = var0.current_pos;
}

function _add_z(var0, var1) {
  return (var0[0], var0[1], var0[2] + var1);
}

function validatenotetracks(var0, var1, var2) {}

function printnotetracks(var0) {}

function animsound_start_tracker(var0, var1) {
  add_to_animsound();
  var2 = spawnStruct();
  var2.anime = var0;
  var2.notetrack = "#" + var0;
  var2.animname = var1;
  var2.end_time = gettime() + 60000;

  if(animsound_exists(var0, var2.notetrack)) {
    return;
  }

  add_animsound(var2);
}

function animsound_start_tracker_loop(var0, var1, var2) {
  add_to_animsound();
  var0 = var1 + var0;
  var3 = spawnStruct();
  var3.anime = var0;
  var3.notetrack = "#" + var0;
  var3.animname = var2;
  var3.end_time = gettime() + 60000;

  if(animsound_exists(var0, var3.notetrack)) {
    return;
  }

  add_animsound(var3);
}

function animsound_tracker(var0, var1, var2) {
  var1 = tolower(var1);
  add_to_animsound();

  if(var1 == "end") {
    return;
  }

  if(animsound_exists(var0, var1)) {
    return;
  }

  var3 = spawnStruct();
  var3.anime = var0;
  var3.notetrack = var1;
  var3.animname = var2;
  var3.end_time = gettime() + 60000;
  add_animsound(var3);
}

function animsound_exists(var0, var1) {
  var1 = tolower(var1);
  var2 = getarraykeys(self.animsounds);

  for(var3 = 0; var3 < var2.size; var3++) {
    var4 = var2[var3];

    if(self.animsounds[var4].anime != var0) {
      continue;
    }

    if(self.animsounds[var4].notetrack != var1) {
      continue;
    }

    self.animsounds[var4].end_time = gettime() + 60000;
    return true;
  }

  return false;
}

function add_animsound(var0) {
  for(var1 = 0; var1 < level.animsound_hudlimit; var1++) {
    if(isDefined(self.animsounds[var1])) {
      continue;
    }

    self.animsounds[var1] = var0;
    return;
  }

  var2 = getarraykeys(self.animsounds);
  var3 = var2[0];
  var4 = self.animsounds[var3].end_time;

  for(var1 = 1; var1 < var2.size; var1++) {
    var5 = var2[var1];

    if(self.animsounds[var5].end_time < var4) {
      var4 = self.animsounds[var5].end_time;
      var3 = var5;
    }
  }

  self.animsounds[var3] = var0;
}

function add_to_animsound() {
  if(!isDefined(self.animsounds)) {
    self.animsounds = [];
  }

  var0 = 0;

  for(var1 = 0; var1 < level.animsounds.size; var1++) {
    if(self == level.animsounds[var1]) {
      var0 = 1;
      break;
    }
  }

  if(!var0) {
    level.animsounds[level.animsounds.size] = self;
    return;
  }
}