/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\notetrack.gsc
***********************************************/

start_notetrack_wait(var_0, var_1, var_2, var_3, var_4) {
  var_0 notify("_encstr_877F1B2E8B627166FB17F0D8FF0E399BDAF7B03825AB134BC21F98309F");
  thread notetrack_wait(var_0, var_1, self, var_2, var_3, var_4);
}

notetrack_wait(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_0 endon("_encstr_877F1B2E8B627166FB17F0D8FF0E399BDAF7B03825AB134BC21F98309F");
  var_0 endon("_encstr_AD75063D571AE108");

  if(isDefined(var_2))
    var_6 = var_2;
  else
    var_6 = self;

  var_7 = undefined;

  if(isDefined(var_4))
    var_7 = var_4;
  else
    var_7 = var_0.animname;

  var_8 = spawnStruct();
  var_8.dialog = [];
  var_9 = [];

  if(isDefined(var_7) && isDefined(level.scr_notetrack[var_7]) && isDefined(var_3)) {
    if(isDefined(level.scr_notetrack[var_7][var_3]))
      var_9[var_3] = level.scr_notetrack[var_7][var_3];

    if(isDefined(level.scr_notetrack[var_7]["_encstr_9A19040BCDBC"]))
      var_9["_encstr_9A19040BCDBC"] = level.scr_notetrack[var_7]["_encstr_9A19040BCDBC"];
  }

  foreach(var_18, var_11 in var_9) {
    foreach(var_13 in level.scr_notetrack[var_7][var_18]) {
      foreach(var_15 in var_13) {
        if(isDefined(var_15["_encstr_B2DA070A5F8BAB87AF"]))
          var_8.dialog[var_15["_encstr_B2DA070A5F8BAB87AF"]] = 1;
      }
    }
  }

  var_19 = 0;
  var_20 = 0;

  for(;;) {
    var_8.dialoguenotetrack = 0;
    var_21 = undefined;

    if(!var_19 && isDefined(var_7) && isDefined(var_3)) {
      var_19 = 1;
      var_22 = undefined;
      var_20 = isDefined(level.scr_notetrack[var_7]) && isDefined(level.scr_notetrack[var_7][var_3]) && isDefined(level.scr_notetrack[var_7][var_3]["_encstr_99AD06D3A5B1538B"]);

      if(!var_20) {
        continue;
      }
      var_23 = ["_encstr_99AD06D3A5B1538B"];
    } else
      var_0 waittill(var_1, var_23);

    if(!isarray(var_23))
      var_23 = [var_23];

    var_0 printnotetracks(var_23);
    validatenotetracks(var_1, var_23, var_5);
    var_24 = undefined;

    foreach(var_26 in var_23) {
      notetrack_handler(var_0, var_3, var_26, var_7, var_9, var_6, var_8);

      if(var_26 == "_encstr_961804BD954A")
        var_24 = 1;
    }

    if(isDefined(var_24)) {
      break;
    }
  }
}

notetrack_handler(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(var_2 == "_encstr_961804BD954A")
    return 1;

  foreach(var_12, var_8 in var_4) {
    if(isDefined(level.scr_notetrack[var_3][var_12][var_2])) {
      foreach(var_10 in level.scr_notetrack[var_3][var_12][var_2])[[anim.callbacks["_encstr_A73F14974D3B5AC088B06F75C9293F0385C1D38F3F52"]]](var_10, var_0, var_6, var_5);
    }
  }

  if(isDefined(anim.callbacks["_encstr_822916FDC51B8BDB296B4848A344B18DF2EB55ED5AA267E0"]))
    [[anim.callbacks["_encstr_822916FDC51B8BDB296B4848A344B18DF2EB55ED5AA267E0"]]](var_0, var_2);
}

anim_handle_notetrack(var_0, var_1, var_2, var_3) {
  if(isDefined(var_0["_encstr_B2BB0998FB35773B1FAFF0"]))
    self thread[[var_0["_encstr_B2BB0998FB35773B1FAFF0"]]](var_1);

  if(isDefined(var_0["_encstr_853D07F580C80102E3"]))
    level notify(var_0["_encstr_853D07F580C80102E3"]);

  if(isDefined(var_0["_encstr_B6190DB0A33A58C64302B67B4695C6"])) {
    if(isDefined(var_0["_encstr_B8150853D568125B7379"]))
      var_1 attach(var_0["_encstr_B6190DB0A33A58C64302B67B4695C6"], var_0["_encstr_B8150853D568125B7379"]);
    else
      var_3 attach(var_0["_encstr_B6190DB0A33A58C64302B67B4695C6"], var_0["_encstr_AF1904F3E3AC"]);

    return;
  }

  if(isDefined(var_0["_encstr_BAD90D7043BB592B03098205DDD75B"])) {
    if(isDefined(var_0["_encstr_B8150853D568125B7379"]))
      var_1 detach(var_0["_encstr_BAD90D7043BB592B03098205DDD75B"], var_0["_encstr_B8150853D568125B7379"]);
    else
      var_3 detach(var_0["_encstr_BAD90D7043BB592B03098205DDD75B"], var_0["_encstr_AF1904F3E3AC"]);
  }

  if(!var_2.dialoguenotetrack) {
    if(isDefined(var_0["_encstr_B2DA070A5F8BAB87AF"]) && isDefined(var_2.dialog[var_0["_encstr_B2DA070A5F8BAB87AF"]])) {
      var_1 _encstr_B282169B8DE496C13ACDE52C9BB4B6F29958D8595C3B6E1B::sayspecificdialogue(var_0["_encstr_B2DA070A5F8BAB87AF"]);
      var_2.dialog[var_0["_encstr_B2DA070A5F8BAB87AF"]] = undefined;
      var_2.dialoguenotetrack = 1;
    }
  }

  if(isDefined(var_0["_encstr_85B70D1EB2F8A17DA199B21895E16D"]))
    anim_addmodel(var_1, var_0);
  else if(isDefined(var_0["_encstr_91770D6520418813B35F2DCF309308"]))
    anim_removemodel(var_1, var_0);

  if(isDefined(var_0["_encstr_B8150853D568125B7379"])) {
    if(isDefined(var_0["_encstr_A23B07456F923B819C"]))
      level thread notetrack_effect(var_1, var_0);

    if(isDefined(var_0["_encstr_83BD0C3B7DA883E9F3334A721BF9"]))
      stopFXOnTag(level._effect[var_0["_encstr_83BD0C3B7DA883E9F3334A721BF9"]], var_1, var_0["_encstr_B8150853D568125B7379"]);

    if(isDefined(var_0["_encstr_9612118B530F03114813AA9457502577A5E9B3"])) {
      playFXOnTag(level._effect[var_0["_encstr_9612118B530F03114813AA9457502577A5E9B3"]], var_1, var_0["_encstr_B8150853D568125B7379"]);
      var_1 hidepart(var_0["_encstr_B8150853D568125B7379"]);
    }

    if(isDefined(var_0["_encstr_957013795B8226B0FFBA81FBA397E068CB87C3D5CB"])) {
      var_4 = undefined;
      var_5 = scripts\engine\utility::getfx(var_0["_encstr_957013795B8226B0FFBA81FBA397E068CB87C3D5CB"]);

      if(isDefined(var_0["_encstr_8DB1194739166CAC7D0E2C39A3AF99DB4EBE95990FD7BB163A594E"]))
        var_4 = scripts\engine\utility::getfx(var_0["_encstr_8DB1194739166CAC7D0E2C39A3AF99DB4EBE95990FD7BB163A594E"]);

      var_6 = 0;

      if(isDefined(var_0["_encstr_BE6E208E390BC656FA07C2E4A3F533DB4EAF9566F0EB19CA8D56472BF53295E03AD0"]))
        var_6 = var_0["_encstr_BE6E208E390BC656FA07C2E4A3F533DB4EAF9566F0EB19CA8D56472BF53295E03AD0"];

      var_1 thread trace_part_for_efx(var_0["_encstr_B8150853D568125B7379"], var_5, var_4, var_6);
    }

    if(isDefined(var_0["_encstr_B4051DE839B06CAC7DC158E48EBE99DBC9F5ACCCF0AFB1C2738D56B196CD9D"]))
      var_1 thread trace_part_for_efx_cancel(var_0["_encstr_B8150853D568125B7379"]);
  }

  if(isDefined(var_0["_encstr_AF1904F3E3AC"]) && isDefined(var_0["_encstr_A23B07456F923B819C"]))
    playFXOnTag(level._effect[var_0["_encstr_A23B07456F923B819C"]], var_3, var_0["_encstr_AF1904F3E3AC"]);

  if(isDefined(var_0["_encstr_B8150853D568125B7379"]) && isDefined(var_0["_encstr_85840E519A6345E8F3B73907BFDA909D"]))
    playFXOnTag(level._effect[var_0["_encstr_85840E519A6345E8F3B73907BFDA909D"]], var_1, var_0["_encstr_B8150853D568125B7379"]);
}

anim_addmodel(var_0, var_1) {
  if(!isDefined(var_0.scriptmodel))
    var_0.scriptmodel = [];

  var_2 = var_0.scriptmodel.size;
  var_0.scriptmodel[var_2] = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", (0, 0, 0));
  var_0.scriptmodel[var_2] setModel(var_1["_encstr_85B70D1EB2F8A17DA199B21895E16D"]);
  var_0.scriptmodel[var_2].origin = var_0 gettagorigin(var_1["_encstr_B8150853D568125B7379"]);
  var_0.scriptmodel[var_2].angles = var_0 gettagangles(var_1["_encstr_B8150853D568125B7379"]);
}

anim_removemodel(var_0, var_1) {
  for(var_2 = 0; var_2 < var_0.scriptmodel.size; var_2++) {
    if(isDefined(var_1["_encstr_8E440A950FE01BB76E96BDE6"])) {
      var_3 = anglesToForward(var_0.scriptmodel[var_2].angles);
      var_3 = var_3 * 120;
      var_3 = var_3 + var_0.scriptmodel[var_2].origin;
      playFX(level._effect[var_1["_encstr_8E440A950FE01BB76E96BDE6"]], var_0.scriptmodel[var_2].origin);
      radiusdamage(var_0.scriptmodel[var_2].origin, 350, 700, 50);
    }

    var_0.scriptmodel[var_2] delete();
  }
}

notetrack_effect(var_0, var_1) {
  var_2 = isDefined(var_1["_encstr_BE3912AD7B27B2A20D5837454327ACAC900B6CAD"]);

  if(var_2)
    scripts\engine\utility::lock("_encstr_BE3912AD7B27B2A20D5837454327ACAC900B6CAD");

  playFXOnTag(level._effect[var_1["_encstr_A23B07456F923B819C"]], var_0, var_1["_encstr_B8150853D568125B7379"]);

  if(var_2)
    scripts\engine\utility::unlock("_encstr_BE3912AD7B27B2A20D5837454327ACAC900B6CAD");
}

trace_part_for_efx_cancel(var_0) {
  self notify("_encstr_ADD9179F39CD48FDFBB1B37B3AAFA5F1679F056FB0F608BD0F" + var_0);
}

trace_part_for_efx(var_0, var_1, var_2, var_3) {
  var_4 = "_encstr_957013795B8226B0FFBA81FBA397E068CB87C3D5CB";
  self endon("_encstr_ADD9179F39CD48FDFBB1B37B3AAFA5F1679F056FB0F608BD0F" + var_0);
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

    if(var_7.stationary == 1 && gettime() - var_7.last_motion_time > 3000)
      return;
  }

  if(!isDefined(self)) {
    return;
  }
  if(isDefined(var_2) && var_7.hit_water)
    var_1 = var_2;

  playFX(var_1, var_7.last_pos);

  if(var_3 == 0)
    self hidepart(var_0);
  else
    thread hidepartatdepth(var_7.last_pos[2] - var_3, var_0);
}

hidepartatdepth(var_0, var_1) {
  self endon("_encstr_8A490E5973475A8EE546CA63B23ACA46");

  while(self gettagorigin(var_1)[2] > var_0)
    wait 0.05;

  self hidepart(var_1);
}

test_trace_tag(var_0) {
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

      if(var_2["_encstr_A53009A25003666B9818C6"] < 1.0) {
        var_0.last_pos = var_2["_encstr_BD260953AA97E3F014279D"];
        var_0.hit_water = var_2["_encstr_8BCA0C2BFD504F333E6D7513637B"] == "_encstr_854C06DD0B8E959C";
        var_0.hit_surface = 1;
        return;
      } else {}
    }
  } else
    var_0.stationary = 1;

  var_0.last_pos = var_0.current_pos;
}

_add_z(var_0, var_1) {
  return (var_0[0], var_0[1], var_0[2] + var_1);
}

validatenotetracks(var_0, var_1, var_2) {}

printnotetracks(var_0) {}

animsound_start_tracker(var_0, var_1) {
  add_to_animsound();
  var_2 = spawnStruct();
  var_2.anime = var_0;
  var_2.notetrack = "_encstr_AA4C0223" + var_0;
  var_2.animname = var_1;
  var_2.end_time = gettime() + 60000;

  if(animsound_exists(var_0, var_2.notetrack)) {
    return;
  }
  add_animsound(var_2);
}

animsound_start_tracker_loop(var_0, var_1, var_2) {
  add_to_animsound();
  var_0 = var_1 + var_0;
  var_3 = spawnStruct();
  var_3.anime = var_0;
  var_3.notetrack = "_encstr_AA4C0223" + var_0;
  var_3.animname = var_2;
  var_3.end_time = gettime() + 60000;

  if(animsound_exists(var_0, var_3.notetrack)) {
    return;
  }
  add_animsound(var_3);
}

animsound_tracker(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  add_to_animsound();

  if(var_1 == "_encstr_961804BD954A") {
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

animsound_exists(var_0, var_1) {
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
    return 1;
  }

  return 0;
}

add_animsound(var_0) {
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

add_to_animsound() {
  if(!isDefined(self.animsounds))
    self.animsounds = [];

  var_0 = 0;

  for(var_1 = 0; var_1 < level.animsounds.size; var_1++) {
    if(self == level.animsounds[var_1]) {
      var_0 = 1;
      break;
    }
  }

  if(!var_0)
    level.animsounds[level.animsounds.size] = self;
}