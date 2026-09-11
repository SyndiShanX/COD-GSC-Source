/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\anim.gsc
***********************************************/

function anim_first_frame(var0, var1, var2) {
  var3 = get_anim_position(var2);
  var4 = var3["origin"];
  var5 = var3["angles"];
  scripts\engine\utility::array_levelthread(var0, &anim_first_frame_on_guy, var1, var4, var5);
}

function anim_generic_first_frame(var0, var1, var2) {
  var3 = get_anim_position(var2);
  var4 = var3["origin"];
  var5 = var3["angles"];
  thread anim_first_frame_on_guy(var0, var1, var4, var5, "generic");
}

function anim_generic(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function anim_generic_run(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function anim_single_solo_run(var0, var1, var2) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_first_frame_solo(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function anim_first_frame_on_guy(var0, var1, var2, var3, var4) {
  var0.first_frame_time = gettime();
  var5 = undefined;

  if(isDefined(var4)) {
    var5 = var4;
  } else {
    var5 = var0.animname;
  }

  var6 = 0;

  if(isarray(level.scr_anim[var5][var1])) {
    var7 = level.scr_anim[var5][var1][0];
    var6 = 1;
  } else {
    var7 = level.scr_anim[var6][var2];
  }

  set_start_pos(var1, var2, var3, var4, var6, var7);

  if(isai(var1)) {
    var1[[anim.callbacks["AIAnimFirstFrame"]]](var7, var6);
    return;
  }

  var1 stopanimScripted();
  var1 setanimknob(var7, 1, 0, 0);

  if(!scripts\common\utility::issp()) {
    if(!isPlayer(var1) && isDefined(level.scr_animname[var6]) && isDefined(level.scr_animname[var6][var2])) {
      var1 builtin[[level.func["scriptModelPlayAnim"]]](level.scr_animname[var6][var2], undefined, 0, 0, "none");
      return;
    }

    return;
  }
}

function set_start_pos(var0, var1, var2, var3, var4) {
  var5 = undefined;

  if(isDefined(var3)) {
    var5 = var3;
  } else {
    var5 = self.animname;
  }

  if(isDefined(var4) && var4) {
    var6 = level.scr_anim[var5][var0][0];
  } else {
    var6 = level.scr_anim[var6][var1];
  }

  var7 = getstartorigin(var2, var3, var6);
  var8 = getstartangles(var2, var3, var6);
  self[[anim.callbacks["TeleportEnt"]]](var7, var8);
}

function anim_start_pos(var0, var1, var2) {
  var3 = get_anim_position(var2);
  var4 = var3["origin"];
  var5 = var3["angles"];
  scripts\engine\utility::array_thread(var0, &set_start_pos, var1, var4, var5);
}

function anim_start_pos_solo(var0, var1, var2) {
  GscBinSkip1(0x45, 0, var0);
}

function anim_last_frame_solo(var0, var1, var2) {
  var3 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function anim_single_solo(var0, var1, var2, var3, var4) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_single_internal(var0, var1, var2, var3, var4) {
  var5 = self;

  foreach(var7 in var0) {
    if(!isDefined(var7)) {
      continue;
    }

    if(!isDefined(var7._animactive)) {
      var7._animactive = 0;
    }

    var7._animactive++;
  }

  var9 = get_anim_position(var2);
  var10 = var9["origin"];
  var11 = var9["angles"];
  var12 = undefined;
  var13 = 999999;
  var14 = undefined;
  var15 = undefined;
  var16 = undefined;
  var17 = undefined;
  var18 = "single anim";

  foreach(var30, var7 in var0) {
    if(!isDefined(var7)) {
      continue;
    }

    var20 = 0;
    var21 = 0;
    var22 = 0;
    var23 = 0;
    var24 = 0;
    var25 = undefined;
    var26 = undefined;
    var27 = undefined;
    var28 = undefined;

    if(isDefined(var4)) {
      var28 = var4;
    } else {
      var28 = var7.animname;
    }

    if(isDefined(level.scr_sound[var28]) && isDefined(level.scr_sound[var28][var1])) {
      var22 = 1;
      var25 = level.scr_sound[var28][var1];
    }

    if(isDefined(level.scr_face[var28]) && isDefined(level.scr_face[var28][var1])) {
      var20 = 1;
      var26 = level.scr_face[var28][var1];
      var16 = var26;

      if(var22) {
        if(animhasnotetrack(var26, "vo_" + var25)) {
          var22 = 0;
          var25 = undefined;
        }
      }
    }

    if(isDefined(level.scr_head[var28]) && isDefined(level.scr_head[var28][var1])) {
      var21 = 1;
      var27 = level.scr_head[var28][var1];
      var17 = var27;
    }

    if(isDefined(level.scr_anim[var28]) && isDefined(level.scr_anim[var28][var1]) && self[[anim.callbacks["ShouldDoAnim"]]]()) {
      var23 = 1;
    }

    if(isDefined(level.scr_animsound[var28]) && isDefined(level.scr_animsound[var28][var1])) {
      var7 playSound(level.scr_animsound[var28][var1]);
    }

    if(var23) {
      var29 = var7[[anim.callbacks["DoAnimation"]]](var10, var11, var28, var1, var18);

      if(var29 < var13) {
        var13 = var29;
        var12 = var30;
      }
    }

    if(var20 || var22) {
      if(var7[[anim.callbacks["DoFacialAnim"]]](var20, var22, var23, var1, var28, var25, 0)) {
        var15 = var30;
      }

      var14 = var30;
    }

    if(var21) {
      thread play_addtive_head_anim(var7, var7);
    }

    if(!isPlayer(var7) && isDefined(level.scr_animname[var28]) && isDefined(level.scr_animname[var28][var1])) {
      var7 scripts\engine\utility::self_func("scriptModelPlayAnim", level.scr_animname[var28][var1]);
    }
  }

  if(isDefined(var12)) {
    var31 = spawnStruct();
    thread anim_deathnotify(var31, var0[var12]);
    thread anim_animationendnotify(var31, var0[var12], var1, var13);
    var31 waittill(var1);
  } else if(isDefined(var15)) {
    var31 = spawnStruct();
    thread anim_deathnotify(var31, var0[var15]);
    thread anim_facialendnotify(var31, var0[var15], var1);
    var31 waittill(var1);
  } else if(isDefined(var14)) {
    var31 = spawnStruct();
    thread anim_deathnotify(var31, var0[var14]);
    thread anim_dialogueendnotify(var31, var0[var14]);
    var31 waittill(var1);
  }

  foreach(var7 in var0) {
    var7._animactive--;
    var7._lastanimtime = gettime();
    LOC_0000035e:
  }

  self notify(var1);
}

function anim_single(var0, var1, var2, var3, var4) {
  if(!isDefined(var3)) {
    var3 = 0;
  }

  anim_single_internal(var0, var1, var2, var3, var4);
}

function anim_loop_solo(var0, var1, var2, var3, var4, var5) {
  self endon("death");
  var0 endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_loop_solo_with_nags(var0, var1, var2, var3) {
  self endon("death");
  var0 endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_generic_loop(var0, var1, var2, var3) {
  var4 = [];
  GscBinSkip0(0x2e, "guy", var0);
}

function anim_loop(var0, var1, var2, var3, var4, var5) {
  var6 = [];

  foreach(var8 in var0) {
    var9 = [];
    var9 = var8;
    var9 = self;
    var9 = var3;
    var9 = var4;
    var6 = var9;
  }

  anim_loop_packet(var6, var1, var2, var5);
}

function anim_loop_packet_solo(var0, var1, var2, var3) {
  var4 = [];
  GscBinSkip0(0x2e, 0, var0);
}

function pick_nag_anim(var0) {
  var1 = undefined;

  if(var0.nag_anims.size == 1) {
    var1 = 0;
  } else if(var0.currentnagindex == var0.nag_anims.size - 1) {
    var1 = 0;
  } else {
    var1 = var0.currentnagindex + 1;
  }

  var0.currentnagindex = var1;
  var0.last_nag_time = gettime();
  return var0.currentnagindex;
}

function anim_loop_packet(var0, var1, var2, var3) {
  foreach(var5 in var0) {
    var6 = var5["guy"];

    if(!isDefined(var6)) {
      continue;
    }

    if(!isDefined(var6._animactive)) {
      var6._animactive = 0;
    }

    var6 endon("death");
    var6._animactive++;
  }

  var8 = var0[0]["guy"];

  if(!isDefined(var2)) {
    var2 = "stop_loop";
  }

  thread endonremoveanimactive(var2, var0);
  self endon(var2);
  var9 = "looping anim";
  var10 = var1;
  var11 = undefined;

  if(isDefined(var3)) {
    var11 = var3;
  } else {
    var11 = var8.animname;
  }

  var12 = 0;
  var13 = 0;
  var14 = 0;
  var15 = isDefined(level.scr_anim[var11][var1 + "_nags"]);

  if(var15 && scripts\common\utility::issp()) {
    var16 = 0;

    foreach(var18, var5 in var0) {
      if(isai(var5["guy"])) {
        var16++;
      }
    }

    if(isDefined(level.scr_anim[var11][var1 + "_nags_timer"])) {
      var14 = level.scr_anim[var11][var1 + "_nags_timer"];
    } else {
      var14 = 15;
    }
  }

  var19 = 0;
  var20 = undefined;
  var21 = 0;
  jumpiffalse(var15) LOC_0000018a;
  setdvarifuninitialized("scr_debug_nags", 0);
  var20 = spawnStruct();
  var20.last_nag_time = gettime();
  var20.nag_anims = level.scr_anim[var11][var1 + "_nags"];
  var20.currentnagindex = 0;
  GscBinSkip4(0x35, var14, var8);

  for(;;) {
    if(!var19) {
      var1 = var10;

      for(var12 = anim_weight(var11, var1); var12 == var13 && var12 != 0; var12 = anim_weight(var11, var1)) {}
    } else {
      var12 = pick_nag_anim(var20);
      var1 = var10 + "_nags";
      GscBinSkip4(0x35, var14, var8);
    }

    var13 = var12;
    var22 = undefined;
    var23 = 999999;
    var24 = undefined;
    var6 = undefined;

    foreach(var5 in var0) {
      var26 = var5["entity"];
      var6 = var5["guy"];
      var27 = get_anim_position(var26, var5["tag"]);
      var28 = var27["origin"];
      var29 = var27["angles"];

      if(isDefined(var5["origin_offset"])) {
        var30 = var5["origin_offset"];
        var31 = anglesToForward(var29);
        var32 = anglestoright(var29);
        var33 = anglestoup(var29);
        var28 += var31 * var30[0];
        var28 += var32 * var30[1];
        var28 += var33 * var30[2];
      }

      if(isDefined(var6.remove_from_animloop)) {
        var6.remove_from_animloop = undefined;
        var0[var18] = undefined;
        continue;
      }

      var34 = 0;
      var35 = 0;
      var36 = 0;
      var37 = 0;
      var38 = undefined;
      var39 = undefined;
      var40 = undefined;

      if(isDefined(var3)) {
        var40 = var3;
      } else {
        var40 = var6.animname;
      }

      if(isDefined(level.scr_face[var40]) && isDefined(level.scr_face[var40][var1]) && isDefined(level.scr_face[var40][var1][var12])) {
        var34 = 1;
        var38 = level.scr_face[var40][var1][var12];
      }

      if(isDefined(level.scr_sound[var40]) && isDefined(level.scr_sound[var40][var1]) && isDefined(level.scr_sound[var40][var1][var12])) {
        var35 = 1;
        var39 = level.scr_sound[var40][var1][var12];
      }

      if(isDefined(level.scr_animsound[var40]) && isDefined(level.scr_animsound[var40][var12 + var1])) {
        var6 playSound(level.scr_animsound[var40][var12 + var1]);
      }

      if(isDefined(level.scr_anim[var40]) && isDefined(level.scr_anim[var40][var1]) && self[[anim.callbacks["ShouldDoAnim"]]]()) {
        var36 = 1;
      }

      if(var36) {
        var41 = var6[[anim.callbacks["DoAnimation"]]](var28, var29, var40, var1, var9, var12);

        if(var41 < var23) {
          var23 = var41;
          var22 = var18;
        }
      }

      if(var34 || var35) {
        var6[[anim.callbacks["DoFacialAnim"]]](var34, var35, var36, var1, var40, var39, 1);
        var24 = var18;
      }
    }

    if(!isDefined(var6)) {
      break;
    }

    if(isDefined(var22)) {
      var42 = waittill_animend(var0[var22]["guy"], var9);

      if(!isDefined(var42) && var15) {
        var19 = 1;

        if(isDefined(anim.callbacks["StopAnimscripted"])) {
          var6[[anim.callbacks["StopAnimscripted"]]]();
        }
      }
    } else if(isDefined(var24)) {
      var0[var24]["guy"] waittill(var9);
    }

    if(var21) {
      break;
    }
  }
}

function waittill_animend(var0, var1) {
  self endon("do_nag");
  var0 waittillmatch(var1, "end");
  return true;
}

function nag_timer(var0, var1) {
  self endon("death");
  var2 = var0;
  var3 = gettime();

  while(var3 + var0 * 1000 > gettime()) {
    wait 1;
  }

  self notify("do_nag");
}

function anim_set_time_solo(var0, var1, var2) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_set_time(var0, var1, var2) {
  scripts\engine\utility::array_thread(var0, &anim_self_set_time, var1, var2);
}

function anim_self_set_time(var0, var1) {
  var2 = scripts\engine\utility::getanim(var0);
  self setanimtime(var2, var1);
}

function last_anim_time_check() {
  if(!isDefined(self.last_anim_time)) {
    self.last_anim_time = gettime();
    return;
  }

  var0 = gettime();

  if(self.last_anim_time == var0) {
    self endon("death");
    wait 0.05;
  }

  self.last_anim_time = var0;
}

function anim_moveTo(var0, var1, var2, var3, var4, var5) {
  var6 = get_anim_position(var2);
  var7 = var6["origin"];
  var8 = var6["angles"];

  foreach(var10 in var0) {
    var11 = getstartorigin(var7, var8, level.scr_anim[var10.animname][var1]);
    var12 = getstartangles(var7, var8, level.scr_anim[var10.animname][var1]);

    if(isai(var10)) {
      continue;
    }

    var10 moveTo(var11, var3, var4, var5);
    var10 rotateTo(var12, var3, var4, var5);
  }
}

function anim_teleport_solo(var0, var1, var2) {
  self endon("death");
  GscBinSkip1(0x45, 0, var0);
}

function anim_teleport(var0, var1, var2) {
  var3 = get_anim_position(var2);
  var4 = var3["origin"];
  var5 = var3["angles"];

  foreach(var7 in var0) {
    var8 = getstartorigin(var4, var5, level.scr_anim[var7.animname][var1]);
    var9 = getstartangles(var4, var5, level.scr_anim[var7.animname][var1]);
    var7[[anim.callbacks["TeleportEnt"]]](var8, var9);
  }
}

function anim_generic_teleport(var0, var1, var2) {
  var3 = get_anim_position(var2);
  var4 = var3["origin"];
  var5 = var3["angles"];
  var6 = getstartorigin(var4, var5, level.scr_anim["generic"][var1]);
  var7 = getstartangles(var4, var5, level.scr_anim["generic"][var1]);
  var0[[anim.callbacks["TeleportEnt"]]](var6, var7);
}

function anim_spawn_generic_model(var0, var1, var2) {
  return anim_spawn_model(var0, "generic", var1, var2);
}

function anim_spawn_model(var0, var1, var2, var3) {
  var4 = get_anim_position(var3);
  var5 = var4["origin"];
  var6 = var4["angles"];
  var7 = getstartorigin(var5, var6, level.scr_anim[var1][var2]);
  var8 = getstartorigin(var5, var6, level.scr_anim[var1][var2]);
  var9 = spawn("script_model", var7);
  var9 setModel(var0);
  var9.angles = var8;
  return var9;
}

function anim_spawn_tag_model(var0, var1) {
  self attach(var0, var1);
}

function anim_link_tag_model(var0, var1) {
  var2 = self gettagorigin(var1);
  var3 = spawn("script_model", var2);
  var3 setModel(var0);
  var3 linkTo(self, var1, (0, 0, 0), (0, 0, 0));
  return var3;
}

function removenotetrack(var0, var1, var2, var3, var4) {
  var1 = tolower(var1);
  var5 = level.scr_notetrack[var0][var2][var1];
  var2 = get_generic_anime(var2);
  var6 = -1;

  if(!isDefined(var5) || !isarray(var5) || var5.size < 1) {
    return;
  }

  for(var7 = 0; var7 < var5.size; var7++) {
    if(isDefined(var5[var7][var3])) {
      if(!isDefined(var4) || var5[var7][var3] == var4) {
        var6 = var7;
        break;
      }
    }
  }

  if(var6 < 0) {
    return;
  }

  if(var5.size == 1) {
    var5 = [];
  } else {
    var5 = scripts\engine\utility::array_remove_index(var5, var6);
  }

  level.scr_notetrack[var0][var2][var1] = var5;
}

function addnotetrack_flag(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var3 = get_generic_anime(var3);
  var4 = add_notetrack_and_get_index(var0, var1, var3);
  var5 = [];
  GscBinSkip0(0x2e, "flag", var2);
}

function addnotetrack_flag_clear(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var3 = get_generic_anime(var3);
  var4 = add_notetrack_and_get_index(var0, var1, var3);
  var5 = [];
  GscBinSkip0(0x2e, "flag_clear", var2);
}

function addnotetrack_dialogue(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var4 = add_notetrack_and_get_index(var0, var1, var2);
  level.scr_notetrack[var0][var2][var1][var4] = [];
  level.scr_notetrack[var0][var2][var1][var4]["dialog"] = var3;
}

function add_notetrack_and_get_index(var0, var1, var2) {
  var1 = tolower(var1);
  add_notetrack_array(var0, var1, var2);
  return level.scr_notetrack[var0][var2][var1].size;
}

function add_notetrack_array(var0, var1, var2) {
  var1 = tolower(var1);

  if(!isDefined(level.scr_notetrack)) {
    level.scr_notetrack = [];
  }

  if(!isDefined(level.scr_notetrack[var0])) {
    level.scr_notetrack[var0] = [];
  }

  if(!isDefined(level.scr_notetrack[var0][var2])) {
    level.scr_notetrack[var0][var2] = [];
  }

  if(!isDefined(level.scr_notetrack[var0][var2][var1])) {
    level.scr_notetrack[var0][var2][var1] = [];
    return;
  }
}

function addnotetrack_sound(var0, var1, var2, var3, var4, var5) {
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var6 = add_notetrack_and_get_index(var0, var1, var2);
  level.scr_notetrack[var0][var2][var1][var6] = [];
  level.scr_notetrack[var0][var2][var1][var6]["sound"] = var3;

  if(isDefined(var4)) {
    level.scr_notetrack[var0][var2][var1][var6]["sound_stays_death"] = 1;
  }

  if(isDefined(var5)) {
    level.scr_notetrack[var0][var2][var1][var6]["sound_on_tag"] = var5;
    return;
  }
}

function note_track_start_sound(var0, var1, var2, var3) {
  var4 = get_datascene();
  addnotetrack_sound(var4.animname, var0, var4.anim_sequence, var1, var2, var3);
}

function addnotetrack_playersound(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var4 = add_notetrack_and_get_index(var0, var1, var2);
  level.scr_notetrack[var0][var2][var1][var4] = [];
  level.scr_notetrack[var0][var2][var1][var4]["playersound"] = var3;
}

function get_generic_anime(var0) {
  if(!isDefined(var0)) {
    return "any";
  }

  return var0;
}

function addonstart_animsound(var0, var1, var2) {
  if(!isDefined(level.scr_animsound[var0])) {
    level.scr_animsound[var0] = [];
  }

  level.scr_animsound[var0][var1] = var2;
}

function addnotetrack_playerdialogue(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var4 = add_notetrack_and_get_index(var0, var1, var2);
  level.scr_notetrack[var0][var2][var1][var4] = [];
  level.scr_notetrack[var0][var2][var1][var4]["playerdialogue"] = var3;
}

function addnotetrack_animsound(var0, var1, var2, var3) {
  var2 = tolower(var2);
  var1 = get_generic_anime(var1);
  var4 = add_notetrack_and_get_index(var0, var2, var1);
  var5 = [];
  GscBinSkip0(0x2e, "sound", var3);
}

function addnotetrack_attach(var0, var1, var2, var3, var4) {
  var1 = tolower(var1);
  var4 = get_generic_anime(var4);
  var5 = add_notetrack_and_get_index(var0, var1, var4);
  var6 = [];
  GscBinSkip0(0x2e, "attach model", var2);
}

function addnotetrack_detach(var0, var1, var2, var3, var4) {
  var1 = tolower(var1);
  var4 = get_generic_anime(var4);
  var5 = add_notetrack_and_get_index(var0, var1, var4);
  var6 = [];
  GscBinSkip0(0x2e, "detach model", var2);
}

function addnotetrack_detach_gun(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var4 = add_notetrack_and_get_index(var0, var1, var2);
  var5 = [];
  GscBinSkip0(0x2e, "detach gun", 1);
}

function addnotetrack_attach_gun(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var4 = add_notetrack_and_get_index(var0, var1, var2);
  var5 = [];

  if(isDefined(var3)) {
    GscBinSkip0(0x2e, "attach gun " + var3, 1);
  }

  GscBinSkip0(0x2e, "attach gun right", 1);
}

function addnotetrack_customfunction(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var3 = get_generic_anime(var3);
  var4 = add_notetrack_and_get_index(var0, var1, var3);
  var5 = [];
  GscBinSkip0(0x2e, "function", var2);
}

function addnotetrack_startfxontag(var0, var1, var2, var3, var4, var5) {
  scripts\engine\utility::getfx(var3);
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var6 = add_notetrack_and_get_index(var0, var1, var2);
  var7 = [];
  GscBinSkip0(0x2e, "effect", var3);
}

function addnotetrack_stopFXOnTag(var0, var1, var2, var3, var4) {
  scripts\engine\utility::getfx(var3);
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var5 = add_notetrack_and_get_index(var0, var1, var2);
  var6 = [];
  GscBinSkip0(0x2e, "stop_effect", var3);
}

function addnotetrack_mayhemstart(var0, var1, var2, var3, var4) {
  var1 = tolower(var1);
  var3 = get_generic_anime(var3);
  var5 = add_notetrack_and_get_index(var0, var1, var3);
  var6 = [];
  GscBinSkip0(0x2e, "mayhem_start", var2);
}

function addnotetrack_mayhemend(var0, var1, var2, var3, var4) {
  var1 = tolower(var1);
  var3 = get_generic_anime(var3);
  var5 = add_notetrack_and_get_index(var0, var1, var3);
  var6 = [];
  GscBinSkip0(0x2e, "mayhem_end", var2);
}

function note_track_swap_to_efx(var0, var1, var2) {
  var3 = get_datascene();
  scripts\engine\utility::add_fx(var1, var1);
  addnotetrack_swapparttoefx(var3.animname, var0, var3.animsequence, var1, var2);
}

function note_track_stop_efx_on_tag(var0, var1, var2) {
  var3 = get_datascene();
  scripts\engine\utility::add_fx(var1, var1);
  addnotetrack_stopFXOnTag(var3.animname, var0, var3.animsequence, var1, var2);
}

function addnotetrack_swapparttoefx(var0, var1, var2, var3, var4) {
  scripts\engine\utility::getfx(var3);
  var1 = tolower(var1);
  var2 = get_generic_anime(var2);
  var5 = add_notetrack_and_get_index(var0, var1, var2);
  var6 = [];
  GscBinSkip0(0x2e, "swap_part_to_efx", var3);
}

function note_track_trace_to_efx(var0, var1, var2, var3, var4, var5) {
  var6 = get_datascene();

  if(var0 != "start" && !animhasnotetrack(var6 scripts\engine\utility::getanim(var6.anim_sequence), var0)) {
    return;
  }

  scripts\engine\utility::add_fx(var3, var3);

  if(isDefined(var4)) {
    scripts\engine\utility::add_fx(var4, var4);
  }

  addnotetrack_tracepartforefx(var6.animname, var0, var1, var6.anim_sequence, var2, var3, var4, var5);
}

function note_track_start_fx_on_tag(var0, var1, var2) {
  var3 = get_datascene();

  if(var0 != "start" && !animhasnotetrack(var3 scripts\engine\utility::getanim(var3.anim_sequence), var0)) {
    return;
  }

  scripts\engine\utility::add_fx(var2, var2);
  addnotetrack_startfxontag(var3.animname, var0, var3.anim_sequence, var2, var1, 1);
}

function get_datascene() {
  var0 = level.current_anim_data_scene;
  return var0;
}

function addnotetrack_tracepartforefx(var0, var1, var2, var3, var4, var5, var6, var7) {
  scripts\engine\utility::getfx(var5);
  var1 = tolower(var1);
  var3 = get_generic_anime(var3);
  var8 = add_notetrack_and_get_index(var0, var1, var3);
  var9 = [];
  GscBinSkip0(0x2e, "trace_part_for_efx", var5);
}

function addnotetrack_notify(var0, var1, var2, var3) {
  var1 = tolower(var1);
  var3 = get_generic_anime(var3);
  var4 = add_notetrack_and_get_index(var0, var1, var3);
  var5 = [];
  GscBinSkip0(0x2e, "notify", var2);
}

function setanimtree() {
  self useanimtree(level.scr_animtree[self.animname]);
}

function initanim() {
  if(!isDefined(level.scr_notetrack)) {
    level.scr_notetrack = [];
  }

  if(!isDefined(level.scr_face)) {
    level.scr_face = [];
  }

  if(!isDefined(level.scr_head)) {
    level.scr_head = [];
  }

  if(!isDefined(level.scr_look)) {
    level.scr_look = [];
  }

  if(!isDefined(level.scr_animsound)) {
    level.scr_animsound = [];
  }

  if(!isDefined(level.scr_sound)) {
    level.scr_sound = [];
  }

  if(!isDefined(level.scr_radio)) {
    level.scr_radio = [];
  }

  if(!isDefined(level.scr_text)) {
    level.scr_text = [];
  }

  if(!isDefined(level.scr_anim)) {
    level.scr_anim[0][0] = 0;
  }

  if(!isDefined(level.scr_animname)) {
    level.scr_animname = [];
  }

  if(!isDefined(level.scr_radio)) {
    level.scr_radio = [];
  }

  if(!isDefined(level.scr_plrdialogue)) {
    level.scr_plrdialogue = [];
  }

  if(!isDefined(level.scr_goaltime)) {
    level.scr_goaltime = [];
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  if(!isDefined(level.scr_blockin)) {
    level.scr_blockin = [];
  }

  thread precache_script_models_thread();
  thread precache_weapon_models_thread();
  scripts\engine\utility::create_lock("moreThanThreeHack", 3);
  scripts\engine\utility::create_lock("trace_part_for_efx", 12);
  init_animsounds();
}

function precache_script_models_thread() {
  waittillframeend();

  if(!isDefined(level.scr_model)) {
    return;
  }

  var0 = getarraykeys(level.scr_model);

  for(var1 = 0; var1 < var0.size; var1++) {
    if(isarray(level.scr_model[var0[var1]])) {
      for(var2 = 0; var2 < level.scr_model[var0[var1]].size; var2++) {
        precachemodel(level.scr_model[var0[var1]][var2]);
      }

      continue;
    }

    precachemodel(level.scr_model[var0[var1]]);
  }
}

function precache_weapon_models_thread() {
  waittillframeend();

  if(!isDefined(level.scr_weapon)) {
    return;
  }

  var0 = getarraykeys(level.scr_weapon);

  for(var1 = 0; var1 < var0.size; var1++) {
    var2 = [];

    if(isDefined(level.scr_weapon[var0[var1]][1])) {
      var2 = level.scr_weapon[var0[var1]][1];
    }

    scripts\common\utility::make_weapon_model(level.scr_weapon[var0[var1]][0], var2, 1, 1);
  }
}

function init_animsounds() {
  level.animsounds = [];
  level.animsound_aliases = [];
  var0 = getarraykeys(level.scr_notetrack);

  for(var1 = 0; var1 < var0.size; var1++) {
    init_notetracks_for_animname(var0[var1]);
  }

  var0 = getarraykeys(level.scr_animsound);

  for(var1 = 0; var1 < var0.size; var1++) {
    init_animsounds_for_animname(var0[var1]);
  }
}

function init_animsounds_for_animname(var0) {
  var1 = getarraykeys(level.scr_animsound[var0]);

  for(var2 = 0; var2 < var1.size; var2++) {
    var3 = var1[var2];
    var4 = level.scr_animsound[var0][var3];
    level.animsound_aliases[var0][var3]["#" + var3]["soundalias"] = var4;
    level.animsound_aliases[var0][var3]["#" + var3]["created_by_animSound"] = 1;
  }
}

function init_notetracks_for_animname(var0) {
  foreach(var2 in level.scr_notetrack[var0]) {
    foreach(var9, var4 in var2) {
      foreach(var6 in var4) {
        var7 = var6["sound"];

        if(!isDefined(var7)) {
          continue;
        }

        level.animsound_aliases[var0][var10][var9]["soundalias"] = var7;

        if(isDefined(var6["created_by_animSound"])) {
          level.animsound_aliases[var0][var10][var9]["created_by_animSound"] = 1;
        }
      }
    }
  }
}

function endonremoveanimactive(var0, var1) {
  self waittill(var0);

  foreach(var3 in var1) {
    var4 = var3["guy"];

    if(!isDefined(var4)) {
      continue;
    }

    var4._animactive--;
    var4._lastanimtime = gettime();
  }
}

function anim_deathnotify(var0, var1) {
  self endon(var1);
  var0 waittill("death");

  if(isDefined(var0.anim_is_death) && var0.anim_is_death) {
    return;
  }

  self notify(var1);
}

function anim_facialendnotify(var0, var1, var2) {
  self endon(var1);
  var3 = getanimlength(var2);
  wait var3;
  self notify(var1);
}

function anim_dialogueendnotify(var0, var1) {
  self endon(var1);
  var0 waittill("single dialogue");
  self notify(var1);
}

function anim_animationendnotify(var0, var1, var2, var3) {
  self endon(var1);
  var0 endon("death");
  var2 -= var3;

  if(var3 > 0 && var2 > 0) {
    var0 scripts\engine\utility::waittill_match_or_timeout("single anim", "end", var2);
    var0 stopanimScripted();
  } else {
    var0 waittillmatch("single anim", "end");
  }

  self notify(var1);
}

function anim_weight(var0, var1) {
  var2 = level.scr_anim[var0][var1].size;
  var3 = randomint(var2);

  if(isDefined(level.scr_anim[var0][var1 + "weight"])) {
    var3 = get_weighted_anim(var0, var1, var2);
  }

  return var3;
}

function get_weighted_anim(var0, var1, var2) {
  var3 = undefined;

  if(var2 > 1) {
    var4 = 0;
    var5 = 0;

    for(var6 = 0; var6 < var2; var6++) {
      if(isDefined(level.scr_anim[var0][var1 + "weight"])) {
        if(isDefined(level.scr_anim[var0][var1 + "weight"][var6])) {
          var4++;
          var5 += level.scr_anim[var0][var1 + "weight"][var6];
        }
      }
    }

    if(var4 == var2) {
      var7 = randomfloat(var5);
      var5 = 0;

      for(var6 = 0; var6 < var2; var6++) {
        var5 += level.scr_anim[var0][var1 + "weight"][var6];

        if(var7 < var5) {
          var3 = var6;
          break;
        }
      }
    }
  }

  return var3;
}

#using_animtree("");

function play_addtive_head_anim(var0, var1) {
  var0 setanimlimited(%addtive_head_anims, 1, 0.2);
  var0 setanimlimited(var1, 1, 0.2);
  wait getanimlength(var1);
  var0 clearanim($addtive_head_anims, 0.2);
  var0 clearanim(var1, 0.2);
}

function get_anim_position(var0) {
  var1 = undefined;
  var2 = undefined;

  if(isDefined(var0)) {
    var1 = self gettagorigin(var0);
    var2 = self gettagangles(var0);
  } else {
    var1 = self.origin;
    var2 = self.angles;

    if(!isDefined(var2)) {
      var2 = (0, 0, 0);
    }
  }

  var3 = [];
  GscBinSkip0(0x2e, "angles", var2);
}

function anim_at_self(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, "guy", self);
}

function anim_at_entity(var0, var1) {
  var2 = [];
  GscBinSkip0(0x2e, "guy", self);
}

function assert_existance_of_anim(var0, var1) {
  if(!isDefined(var1)) {
    var1 = self.animname;
  }

  var2 = 0;

  if(isDefined(level.scr_anim[var1])) {
    var2 = 1;

    if(isDefined(level.scr_anim[var1][var0])) {
      return;
    }
  }

  var3 = 0;

  if(isDefined(level.scr_face[var1])) {
    var3 = 1;

    if(isDefined(level.scr_face[var1][var0])) {
      return;
    }
  }

  var4 = 0;

  if(isDefined(level.scr_sound[var1])) {
    var4 = 1;

    if(isDefined(level.scr_sound[var1][var0])) {
      return;
    }
  }

  var5 = 0;

  if(isDefined(level.scr_blockin[var1])) {
    var5 = 1;

    if(isDefined(level.scr_blockin[var1][var0])) {
      return;
    }
  }

  if(var2 || var4 || var3 || var5) {
    if(var2) {
      var6 = getarraykeys(level.scr_anim[var1]);

      foreach(var8 in var6) {}
    }

    if(var4) {
      var6 = getarraykeys(level.scr_sound[var1]);

      foreach(var8 in var6) {}
    }

    if(var3) {
      var6 = getarraykeys(level.scr_face[var1]);

      foreach(var8 in var6) {}
    }

    if(var5) {
      var6 = getarraykeys(level.scr_blockin[var1]);

      foreach(var8 in var6) {}
    }

    return;
  }

  var16 = getarraykeys(level.scr_anim);
  var16 = scripts\engine\utility::array_combine(var16, getarraykeys(level.scr_sound));

  foreach(var18 in var16) {}
}

function anim_single_failsafeonguy(var0, var1) {}

function anim_single_failsafe(var0, var1) {
  foreach(var3 in var0) {
    thread anim_single_failsafeonguy(var3, self);
  }
}

function anim_get_goal_time(var0, var1) {
  if(isDefined(level.scr_goaltime[var0]) && isDefined(level.scr_goaltime[var0][var1])) {
    return level.scr_goaltime[var0][var1];
  }

  return 0.5;
}