/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\notetrack.gsc
***********************************************/

function start_notetrack_wait(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("stop_sequencing_notetracks");
  thread notetrack_wait(var_0, var_1, self, var_2, var_3, var_4);
}

function notetrack_wait(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("stop_sequencing_notetracks");
  var_0 endon("death");

  if(isDefined(var_2)) {
    var_6 = var_2;
  } else {
    var_6 = self;
  }

  var_7 = undefined;

  if(isDefined(var_5)) {
    var_7 = var_5;
  } else {
    var_7 = var_1.animname;
  }

  var_8 = spawnStruct();
  var_8.dialog = [];
  var_9 = [];

  if(isDefined(var_7) && isDefined(level.scr_notetrack[var_7]) && isDefined(var_4)) {
    if(isDefined(level.scr_notetrack[var_7][var_4])) {
      GscBinSkip0(0x2e, var_4, level.scr_notetrack[var_7][var_4]);
    }

    if(isDefined(level.scr_notetrack[var_7]["any"])) {
      GscBinSkip0(0x2e, "any", level.scr_notetrack[var_7]["any"]);
    }
  }

  foreach(var_11 in var_9) {
    foreach(var_13 in level.scr_notetrack[var_7][var_18]) {
      foreach(var_15 in var_13) {
        if(isDefined(var_15["dialog"])) {
          var_8.dialog[var_15["dialog"]] = 1;
        }
      }
    }
  }

  var_19 = 0;
  var_20 = 0;

  for(;;) {
    var_8.dialoguenotetrack = 0;
    var_21 = undefined;

    if(!var_19 && isDefined(var_7) && isDefined(var_4)) {
      var_19 = 1;
      var_22 = undefined;
      var_20 = isDefined(level.scr_notetrack[var_7]) && isDefined(level.scr_notetrack[var_7][var_4]) && isDefined(level.scr_notetrack[var_7][var_4]["start"]);

      if(!var_20) {
        continue;
      }

      var_23 = ["start"];
    } else {
      var_1 waittill(var_2, var_23);
    }

    if(!isarray(var_23)) {
      var_23 = [var_23];
    }

    printnotetracks(var_1, var_23);
    validatenotetracks(var_2, var_23, var_6);
    var_24 = undefined;

    foreach(var_26 in var_23) {
      notetrack_handler(var_1, var_4, var_26, var_7, var_9, var_6, var_8);

      if(var_26 == "end") {
        var_24 = 1;
      }
    }

    if(isDefined(var_24)) {
      break;
    }
  }
}

function notetrack_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_2 == "end") {
    return 1;
  }

  foreach(var_8 in var_4) {
    if(isDefined(level.scr_notetrack[var_3][var_12][var_2])) {
      foreach(var_10 in level.scr_notetrack[var_3][var_12][var_2]) {
        [[anim.callbacks["AnimHandleNotetrack"]]](var_10, var_0, var_6, var_5);
      }
    }
  }

  if(isDefined(anim.callbacks["EntityHandleNotetrack"])) {
    [[anim.callbacks["EntityHandleNotetrack"]]](var_0, var_2);
    return;
  }
}

function anim_handle_notetrack(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0["function"])) {
    self thread[[var_0["function"]]](var_1);
  }

  if(isDefined(var_0["notify"])) {
    level notify(var_0["notify"]);
  }

  if(isDefined(var_0["attach model"])) {
    if(isDefined(var_0["selftag"])) {
      var_1 attach(var_0["attach model"], var_0["selftag"]);
      return;
    }

    var_3 attach(var_0["attach model"], var_0["tag"]);
    return;
  }

  if(isDefined(var_0["detach model"])) {
    if(isDefined(var_0["selftag"])) {
      var_1 detach(var_0["detach model"], var_0["selftag"]);
    } else {
      var_3 detach(var_0["detach model"], var_0["tag"]);
    }
  }

  if(!var_2.dialoguenotetrack) {
    if(isDefined(var_0["dialog"]) && isDefined(var_2.dialog[var_0["dialog"]])) {
      var_1 scripts\anim\face::sayspecificdialogue(var_0["dialog"]);
      var_2.dialog[var_0["dialog"]] = undefined;
      var_2.dialoguenotetrack = 1;
    }
  }

  if(isDefined(var_0["create model"])) {
    anim_addmodel(var_1, var_0);
  } else if(isDefined(var_0["delete model"])) {
    anim_removemodel(var_1, var_0);
  }

  if(isDefined(var_0["selftag"])) {
    if(isDefined(var_0["effect"])) {
      thread notetrack_effect(level, var_1);
    }

    if(isDefined(var_0["stop_effect"])) {
      stopFXOnTag(level._effect[var_0["stop_effect"]], var_1, var_0["selftag"]);
    }

    if(isDefined(var_0["swap_part_to_efx"])) {
      playFXOnTag(level._effect[var_0["swap_part_to_efx"]], var_1, var_0["selftag"]);
      var_1 hidepart(var_0["selftag"]);
    }

    if(isDefined(var_0["trace_part_for_efx"])) {
      var_4 = undefined;
      var_5 = scripts\engine\utility::getfx(var_0["trace_part_for_efx"]);

      if(isDefined(var_0["trace_part_for_efx_water"])) {
        var_4 = scripts\engine\utility::getfx(var_0["trace_part_for_efx_water"]);
      }

      var_6 = 0;

      if(isDefined(var_0["trace_part_for_efx_delete_depth"])) {
        var_6 = var_0["trace_part_for_efx_delete_depth"];
      }

      thread trace_part_for_efx(var_1, var_0["selftag"], var_5, var_4);
    }

    if(isDefined(var_0["trace_part_for_efx_canceling"])) {
      thread trace_part_for_efx_cancel(var_1);
    }
  }

  if(isDefined(var_0["tag"]) && isDefined(var_0["effect"])) {
    playFXOnTag(level._effect[var_0["effect"]], var_3, var_0["tag"]);
  }

  if(isDefined(var_0["selftag"]) && isDefined(var_0["effect_looped"])) {
    playFXOnTag(level._effect[var_0["effect_looped"]], var_1, var_0["selftag"]);
    return;
  }
}

function anim_addmodel(var_0, var_1) {
  if(!isDefined(var_0.scriptmodel)) {
    var_0.scriptmodel = [];
  }

  var_2 = var_0.scriptmodel.size;
  var_0.scriptmodel[var_2] = spawn("script_model", (0, 0, 0));
  var_0.scriptmodel[var_2] setModel(var_1["create model"]);
  var_0.scriptmodel[var_2].origin = var_0 gettagorigin(var_1["selftag"]);
  var_0.scriptmodel[var_2].angles = var_0 gettagangles(var_1["selftag"]);
}

function anim_removemodel(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.scriptmodel.size; var_2++) {
    if(isDefined(var_1["explosion"])) {
      var_3 = anglesToForward(var_0.scriptmodel[var_2].angles);
      var_3 *= 120;
      var_3 += var_0.scriptmodel[var_2].origin;
      playFX(level._effect[var_1["explosion"]], var_0.scriptmodel[var_2].origin);
      radiusdamage(var_0.scriptmodel[var_2].origin, 350, 700, 50);
    }

    var_0.scriptmodel[var_2] delete();
  }
}

function notetrack_effect(var_0, var_1) {
  var_2 = isDefined(var_1["moreThanThreeHack"]);

  if(var_2) {
    scripts\engine\utility::lock("moreThanThreeHack");
  }

  playFXOnTag(level._effect[var_1["effect"]], var_0, var_1["selftag"]);

  if(var_2) {
    scripts\engine\utility::unlock("moreThanThreeHack");
    return;
  }
}

function trace_part_for_efx_cancel(var_0) {
  self notify("cancel_trace_for_part_" + var_0);
}

function trace_part_for_efx(var_0, var_1, var_2, var_3) {
  var_4 = "trace_part_for_efx";
  self endon("cancel_trace_for_part_" + var_0);
  var_5 = self gettagorigin(var_0);
  var_6 = 0;
  var_7 = spawnStruct();
  var_7.last_pos = self gettagorigin(var_0);
  var_7.hit_surface = 0;
  var_7.part = var_0;
  var_7.hit_water = 0;
  var_7.effect = var_1;
  var_7.stationary = 0;
  var_7.last_motion_time = gettime();

  while(isDefined(self) && !var_7.hit_surface) {
    scripts\engine\utility::lock(var_4);
    test_trace_tag(var_7);
    scripts\engine\utility::unlock_wait(var_4);

    if(var_7.stationary == 1 && gettime() - var_7.last_motion_time > 3000) {
      return;
    }
  }

  if(!isDefined(self)) {
    return;
  }

  if(isDefined(var_2) && var_7.hit_water) {
    var_1 = var_2;
  }

  playFX(var_1, var_7.last_pos);

  if(var_3 == 0) {
    self hidepart(var_0);
    return;
  }

  thread hidepartatdepth(var_7.last_pos[2] - var_3, var_0);
}

function hidepartatdepth(var_0, var_1) {
  self endon("entitydeleted");

  while(self gettagorigin(var_1)[2] > var_0) {
    wait 0.05;
  }

  self hidepart(var_1);
}

function test_trace_tag(var_0) {
  var_1 = undefined;

  if(!isDefined(self)) {
    return;
  }

  var_0.current_pos = self gettagorigin(var_0.part);

  if(var_0.current_pos != var_0.last_pos) {
    var_0.last_motion_time = gettime();
    var_0.stationary = 0;

    if(!scripts\engine\trace::_bullet_trace_passed(var_0.last_pos, var_0.current_pos, 0, self)) {
      var_2 = scripts\engine\trace::_bullet_trace(var_0.last_pos, var_0.current_pos, 0, self);

      if(var_2["fraction"] < 1) {
        var_0.last_pos = var_2["position"];
        var_0.hit_water = var_2["surfacetype"] == "water";
        var_0.hit_surface = 1;
        return;
      }
    }
  } else {
    var_0.stationary = 1;
  }

  var_0.last_pos = var_0.current_pos;
}

function _add_z(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

function validatenotetracks(var_0, var_1, var_2) {}

function printnotetracks(var_0) {}

function animsound_start_tracker(var_0, var_1) {
  add_to_animsound();
  var_2 = spawnStruct();
  var_2.anime = var_0;
  var_2.notetrack = "#" + var_0;
  var_2.animname = var_1;
  var_2.end_time = gettime() + 60000;

  if(animsound_exists(var_0, var_2.notetrack)) {
    return;
  }

  add_animsound(var_2);
}

function animsound_start_tracker_loop(var_0, var_1, var_2) {
  add_to_animsound();
  var_0 = var_1 + var_0;
  var_3 = spawnStruct();
  var_3.anime = var_0;
  var_3.notetrack = "#" + var_0;
  var_3.animname = var_2;
  var_3.end_time = gettime() + 60000;

  if(animsound_exists(var_0, var_3.notetrack)) {
    return;
  }

  add_animsound(var_3);
}

function animsound_tracker(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  add_to_animsound();

  if(var_1 == "end") {
    return;
  }

  if(animsound_exists(var_0, var_1)) {
    return;
  }

  var_3 = spawnStruct();
  var_3.anime = var_0;
  var_3.notetrack = var_1;
  var_3.animname = var_2;
  var_3.end_time = gettime() + 60000;
  add_animsound(var_3);
}

function animsound_exists(var_0, var_1) {
  var_1 = tolower(var_1);
  var_2 = getarraykeys(self.animsounds);

  for(var_3 = 0; var_3 < var_2.size; var_3++) {
    var_4 = var_2[var_3];

    if(self.animsounds[var_4].anime != var_0) {
      continue;
    }

    if(self.animsounds[var_4].notetrack != var_1) {
      continue;
    }

    self.animsounds[var_4].end_time = gettime() + 60000;
    return true;
  }

  return false;
}

function add_animsound(var_0) {
  for(var_1 = 0; var_1 < level.animsound_hudlimit; var_1++) {
    if(isDefined(self.animsounds[var_1])) {
      continue;
    }

    self.animsounds[var_1] = var_0;
    return;
  }

  var_2 = getarraykeys(self.animsounds);
  var_3 = var_2[0];
  var_4 = self.animsounds[var_3].end_time;

  for(var_1 = 1; var_1 < var_2.size; var_1++) {
    var_5 = var_2[var_1];

    if(self.animsounds[var_5].end_time < var_4) {
      var_4 = self.animsounds[var_5].end_time;
      var_3 = var_5;
    }
  }

  self.animsounds[var_3] = var_0;
}

function add_to_animsound() {
  if(!isDefined(self.animsounds)) {
    self.animsounds = [];
  }

  var_0 = 0;

  for(var_1 = 0; var_1 < level.animsounds.size; var_1++) {
    if(self == level.animsounds[var_1]) {
      var_0 = 1;
      break;
    }
  }

  if(!var_0) {
    level.animsounds[level.animsounds.size] = self;
    return;
  }
}