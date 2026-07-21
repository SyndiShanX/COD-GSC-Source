/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: common\anim.gsc
***********************************************/

anim_first_frame(var_0, var_1, var_2) {
  var_3 = get_anim_position(var_2);
  var_4 = var_3["_encstr_97FE07DE392D76D2CD"];
  var_5 = var_3["_encstr_A7610758E6CED8569B"];
  scripts\engine\utility::array_levelthread(var_0, ::anim_first_frame_on_guy, var_1, var_4, var_5);
}

anim_generic_first_frame(var_0, var_1, var_2) {
  var_3 = get_anim_position(var_2);
  var_4 = var_3["_encstr_97FE07DE392D76D2CD"];
  var_5 = var_3["_encstr_A7610758E6CED8569B"];
  thread anim_first_frame_on_guy(var_0, var_1, var_4, var_5, "_encstr_979608DF73C8E70B73A1");
}

anim_generic(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  anim_single(var_3, var_1, var_2, 0, "_encstr_979608DF73C8E70B73A1");
}

anim_generic_run(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  anim_single(var_3, var_1, var_2, 0.25, "_encstr_979608DF73C8E70B73A1");
}

anim_single_solo_run(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_3[0] = var_0;
  anim_single(var_3, var_1, var_2, 0.25);
}

anim_first_frame_solo(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  anim_first_frame(var_3, var_1, var_2);
}

anim_first_frame_on_guy(var_0, var_1, var_2, var_3, var_4) {
  var_0.first_frame_time = gettime();
  var_5 = undefined;

  if(isDefined(var_4))
    var_5 = var_4;
  else
    var_5 = var_0.animname;

  var_6 = 0;

  if(isarray(level.scr_anim[var_5][var_1])) {
    var_7 = level.scr_anim[var_5][var_1][0];
    var_6 = 1;
  } else
    var_7 = level.scr_anim[var_5][var_1];

  var_0 set_start_pos(var_1, var_2, var_3, var_5, var_6);

  if(isai(var_0))
    var_0[[anim.callbacks["_encstr_BAF911824A14E696B5234B9C37E819C90BB5B2"]]](var_7, var_5);
  else {
    var_0 stopanimScripted();
    var_0 setanimknob(var_7, 1, 0, 0);

    if(!scripts\common\utility::issp()) {
      if(!isPlayer(var_0) && isDefined(level.scr_animname[var_5]) && isDefined(level.scr_animname[var_5][var_1]))
        var_0 call[[level.func["_encstr_848A141BAFF834B34DD472CA39A9EBADC823A19ED378"]]](level.scr_animname[var_5][var_1], undefined, 0, 0, "_encstr_8BBA05185F8B99");
    }
  }
}

set_start_pos(var_0, var_1, var_2, var_3, var_4) {
  var_5 = undefined;

  if(isDefined(var_3))
    var_5 = var_3;
  else
    var_5 = self.animname;

  if(isDefined(var_4) && var_4)
    var_6 = level.scr_anim[var_5][var_0][0];
  else
    var_6 = level.scr_anim[var_5][var_0];

  var_7 = getstartorigin(var_1, var_2, var_6);
  var_8 = getstartangles(var_1, var_2, var_6);
  self[[anim.callbacks["_encstr_A3AD0C3C9D5812D9C256E391C205"]]](var_7, var_8);
}

anim_start_pos(var_0, var_1, var_2) {
  var_3 = get_anim_position(var_2);
  var_4 = var_3["_encstr_97FE07DE392D76D2CD"];
  var_5 = var_3["_encstr_A7610758E6CED8569B"];
  scripts\engine\utility::array_thread(var_0, ::set_start_pos, var_1, var_4, var_5);
}

anim_start_pos_solo(var_0, var_1, var_2) {
  var_3[0] = var_0;
  anim_start_pos(var_3, var_1, var_2);
}

anim_last_frame_solo(var_0, var_1, var_2) {
  var_3 = [];
  var_3[0] = var_0;
  anim_first_frame(var_3, var_1, var_2);
  anim_set_time(var_3, var_1, 1.0);
  var_4 = var_0 scripts\engine\utility::getanim(var_1);
  var_5 = getmovedelta(var_4);
  var_6 = getangledelta3d(var_4);
  var_7 = rotatevector(var_5, var_0.angles);
  var_8 = var_0.origin + var_7;
  var_9 = combineangles(var_0.angles, var_6);
  var_0[[anim.callbacks["_encstr_A3AD0C3C9D5812D9C256E391C205"]]](var_8, var_9);
}

anim_single_solo(var_0, var_1, var_2, var_3, var_4) {
  self endon("_encstr_AD75063D571AE108");
  var_5[0] = var_0;

  if(!isDefined(var_3))
    var_3 = 0;

  anim_single(var_5, var_1, var_2, var_3, var_4);
}

anim_single_internal(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self;

  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }
    if(!isDefined(var_7._animactive))
      var_7._animactive = 0;

    var_7._animactive++;
  }

  var_9 = get_anim_position(var_2);
  var_10 = var_9["_encstr_97FE07DE392D76D2CD"];
  var_11 = var_9["_encstr_A7610758E6CED8569B"];
  var_12 = undefined;
  var_13 = 999999;
  var_14 = undefined;
  var_15 = undefined;
  var_16 = undefined;
  var_17 = undefined;
  var_18 = "_encstr_B26B0C62E310EFF82760E3BB9B80";

  foreach(var_30, var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_20 = 0;
    var_21 = 0;
    var_22 = 0;
    var_23 = 0;
    var_24 = 0;
    var_25 = undefined;
    var_26 = undefined;
    var_27 = undefined;
    var_28 = undefined;

    if(isDefined(var_4))
      var_28 = var_4;
    else
      var_28 = var_7.animname;

    if(isDefined(level.scr_sound[var_28]) && isDefined(level.scr_sound[var_28][var_1])) {
      var_22 = 1;
      var_25 = level.scr_sound[var_28][var_1];
    }

    if(isDefined(level.scr_face[var_28]) && isDefined(level.scr_face[var_28][var_1])) {
      var_20 = 1;
      var_26 = level.scr_face[var_28][var_1];
      var_16 = var_26;

      if(var_22) {
        if(animhasnotetrack(var_26, "_encstr_A2190467EDEB" + var_25)) {
          var_22 = 0;
          var_25 = undefined;
        }
      }
    }

    if(isDefined(level.scr_head[var_28]) && isDefined(level.scr_head[var_28][var_1])) {
      var_21 = 1;
      var_27 = level.scr_head[var_28][var_1];
      var_17 = var_27;
    }

    if(isDefined(level.scr_anim[var_28]) && isDefined(level.scr_anim[var_28][var_1]) && self[[anim.callbacks["_encstr_A6480D47345F98017A5397D3E3F2D9"]]]())
      var_23 = 1;

    if(isDefined(level.scr_animsound[var_28]) && isDefined(level.scr_animsound[var_28][var_1]))
      var_7 playSound(level.scr_animsound[var_28][var_1]);

    if(var_23) {
      var_29 = var_7[[anim.callbacks["_encstr_B63D0C4DB578B5480DDFF04BFF56"]]](var_10, var_11, var_28, var_1, var_18);

      if(var_29 < var_13) {
        var_13 = var_29;
        var_12 = var_30;
      }
    }

    if(var_20 || var_22) {
      if(var_7[[anim.callbacks["_encstr_8B620D11F6230BC6D258B1A0E6D2B5"]]](var_20, var_22, var_23, var_1, var_28, var_25, 0))
        var_15 = var_30;

      var_14 = var_30;
    }

    if(var_21)
      var_7 thread play_addtive_head_anim(var_7, var_17);

    if(!isPlayer(var_7) && isDefined(level.scr_animname[var_28]) && isDefined(level.scr_animname[var_28][var_1]))
      var_7 scripts\engine\utility::self_func("_encstr_848A141BAFF834B34DD472CA39A9EBADC823A19ED378", level.scr_animname[var_28][var_1]);
  }

  if(isDefined(var_12)) {
    var_31 = spawnStruct();
    var_31 thread anim_deathnotify(var_0[var_12], var_1);
    var_31 thread anim_animationendnotify(var_0[var_12], var_1, var_13, var_3);
    var_31 waittill(var_1);
  } else if(isDefined(var_15)) {
    var_31 = spawnStruct();
    var_31 thread anim_deathnotify(var_0[var_15], var_1);
    var_31 thread anim_facialendnotify(var_0[var_15], var_1, var_16);
    var_31 waittill(var_1);
  } else if(isDefined(var_14)) {
    var_31 = spawnStruct();
    var_31 thread anim_deathnotify(var_0[var_14], var_1);
    var_31 thread anim_dialogueendnotify(var_0[var_14], var_1);
    var_31 waittill(var_1);
  }

  foreach(var_7 in var_0) {
    if(!isDefined(var_7)) {
      continue;
    }
    var_7._animactive--;
    var_7._lastanimtime = gettime();
  }

  self notify(var_1);
}

anim_single(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_3))
    var_3 = 0;

  anim_single_internal(var_0, var_1, var_2, var_3, var_4);
}

anim_loop_solo(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_6[0] = var_0;
  anim_loop(var_6, var_1, var_2, var_3, var_4, var_5);
}

anim_loop_solo_with_nags(var_0, var_1, var_2, var_3) {
  self endon("_encstr_AD75063D571AE108");
  var_0 endon("_encstr_AD75063D571AE108");
  var_4[0] = var_0;
  anim_loop(var_4, var_1, var_2, var_3);
}

anim_generic_loop(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4["_encstr_BD1804DF5370"] = var_0;
  var_4["_encstr_850E077B0BF30318B9"] = self;
  var_4["_encstr_AF1904F3E3AC"] = var_3;
  var_5[0] = var_4;
  anim_loop_packet(var_5, var_1, var_2, "_encstr_979608DF73C8E70B73A1");
}

anim_loop(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = [];

  foreach(var_8 in var_0) {
    var_9 = [];
    var_9["_encstr_BD1804DF5370"] = var_8;
    var_9["_encstr_850E077B0BF30318B9"] = self;
    var_9["_encstr_AF1904F3E3AC"] = var_3;
    var_9["_encstr_9A1C0E7B4EB4D9D2E6AFDB33CCCD59A3"] = var_4;
    var_6[var_6.size] = var_9;
  }

  anim_loop_packet(var_6, var_1, var_2, var_5);
}

anim_loop_packet_solo(var_0, var_1, var_2, var_3) {
  var_4 = [];
  var_4[0] = var_0;
  anim_loop_packet(var_4, var_1, var_2, var_3);
}

pick_nag_anim(var_0) {
  var_1 = undefined;

  if(var_0.nag_anims.size == 1)
    var_1 = 0;
  else if(var_0.currentnagindex == var_0.nag_anims.size - 1)
    var_1 = 0;
  else
    var_1 = var_0.currentnagindex + 1;

  var_0.currentnagindex = var_1;
  var_0.last_nag_time = gettime();
  return var_0.currentnagindex;
}

anim_loop_packet(var_0, var_1, var_2, var_3) {
  foreach(var_5 in var_0) {
    var_6 = var_5["_encstr_BD1804DF5370"];

    if(!isDefined(var_6)) {
      continue;
    }
    if(!isDefined(var_6._animactive))
      var_6._animactive = 0;

    var_6 endon("_encstr_AD75063D571AE108");
    var_6._animactive++;
  }

  var_8 = var_0[0]["_encstr_BD1804DF5370"];

  if(!isDefined(var_2))
    var_2 = "_encstr_8B2D0AD00B95B1BEEB0FD057";

  thread endonremoveanimactive(var_2, var_0);
  self endon(var_2);
  var_9 = "_encstr_A5C90DF1F8384B2182C7415F5BE9A9";
  var_10 = var_1;
  var_11 = undefined;

  if(isDefined(var_3))
    var_11 = var_3;
  else
    var_11 = var_8.animname;

  var_12 = 0;
  var_13 = 0;
  var_14 = 0;
  var_15 = isDefined(level.scr_anim[var_11][var_1 + "_encstr_887306179540979F"]);

  if(var_15 && scripts\common\utility::issp()) {
    var_16 = 0;

    foreach(var_18, var_5 in var_0) {
      if(isai(var_5["_encstr_BD1804DF5370"]))
        var_16++;
    }

    if(isDefined(level.scr_anim[var_11][var_1 + "_encstr_95EE0C78685F6F3BDF91CB2BB593"]))
      var_14 = level.scr_anim[var_11][var_1 + "_encstr_95EE0C78685F6F3BDF91CB2BB593"];
    else
      var_14 = 15;
  }

  var_19 = 0;
  var_20 = undefined;
  var_21 = 0;

  if(var_15) {
    setdvarifuninitialized("_encstr_974C0F73297E3757789D150FCF08DE0F26", 0);
    var_20 = spawnStruct();
    var_20.last_nag_time = gettime();
    var_20.nag_anims = level.scr_anim[var_11][var_1 + "_encstr_887306179540979F"];
    var_20.currentnagindex = 0;
    childthread nag_timer(var_14, var_8);
  }

  for(;;) {
    if(!var_19) {
      var_1 = var_10;

      for(var_12 = anim_weight(var_11, var_1); var_12 == var_13 && var_12 != 0; var_12 = anim_weight(var_11, var_1)) {}
    } else {
      var_12 = pick_nag_anim(var_20);
      var_1 = var_10 + "_encstr_887306179540979F";
      childthread nag_timer(var_14, var_8);
      var_19 = 0;
    }

    var_13 = var_12;
    var_22 = undefined;
    var_23 = 999999;
    var_24 = undefined;
    var_6 = undefined;

    foreach(var_18, var_5 in var_0) {
      var_26 = var_5["_encstr_850E077B0BF30318B9"];
      var_6 = var_5["_encstr_BD1804DF5370"];
      var_27 = var_26 get_anim_position(var_5["_encstr_AF1904F3E3AC"]);
      var_28 = var_27["_encstr_97FE07DE392D76D2CD"];
      var_29 = var_27["_encstr_A7610758E6CED8569B"];

      if(isDefined(var_5["_encstr_9A1C0E7B4EB4D9D2E6AFDB33CCCD59A3"])) {
        var_30 = var_5["_encstr_9A1C0E7B4EB4D9D2E6AFDB33CCCD59A3"];
        var_31 = anglesToForward(var_29);
        var_32 = anglestoright(var_29);
        var_33 = anglestoup(var_29);
        var_28 = var_28 + var_31 * var_30[0];
        var_28 = var_28 + var_32 * var_30[1];
        var_28 = var_28 + var_33 * var_30[2];
      }

      if(isDefined(var_6.remove_from_animloop)) {
        var_6.remove_from_animloop = undefined;
        var_0[var_18] = undefined;
        continue;
      }

      var_34 = 0;
      var_35 = 0;
      var_36 = 0;
      var_37 = 0;
      var_38 = undefined;
      var_39 = undefined;
      var_40 = undefined;

      if(isDefined(var_3))
        var_40 = var_3;
      else
        var_40 = var_6.animname;

      if(isDefined(level.scr_face[var_40]) && isDefined(level.scr_face[var_40][var_1]) && isDefined(level.scr_face[var_40][var_1][var_12])) {
        var_34 = 1;
        var_38 = level.scr_face[var_40][var_1][var_12];
      }

      if(isDefined(level.scr_sound[var_40]) && isDefined(level.scr_sound[var_40][var_1]) && isDefined(level.scr_sound[var_40][var_1][var_12])) {
        var_35 = 1;
        var_39 = level.scr_sound[var_40][var_1][var_12];
      }

      if(isDefined(level.scr_animsound[var_40]) && isDefined(level.scr_animsound[var_40][var_12 + var_1]))
        var_6 playSound(level.scr_animsound[var_40][var_12 + var_1]);

      if(isDefined(level.scr_anim[var_40]) && isDefined(level.scr_anim[var_40][var_1]) && self[[anim.callbacks["_encstr_A6480D47345F98017A5397D3E3F2D9"]]]())
        var_36 = 1;

      if(var_36) {
        var_41 = var_6[[anim.callbacks["_encstr_B63D0C4DB578B5480DDFF04BFF56"]]](var_28, var_29, var_40, var_1, var_9, var_12);

        if(var_41 < var_23) {
          var_23 = var_41;
          var_22 = var_18;
        }
      }

      if(var_34 || var_35) {
        var_6[[anim.callbacks["_encstr_8B620D11F6230BC6D258B1A0E6D2B5"]]](var_34, var_35, var_36, var_1, var_40, var_39, 1);
        var_24 = var_18;
      }
    }

    if(!isDefined(var_6)) {
      break;
    }

    if(isDefined(var_22)) {
      var_42 = waittill_animend(var_0[var_22]["_encstr_BD1804DF5370"], var_9);

      if(!isDefined(var_42) && var_15) {
        var_19 = 1;

        if(isDefined(anim.callbacks["_encstr_855911C7613083C1085835BA31C0213B15EB83"]))
          var_6[[anim.callbacks["_encstr_855911C7613083C1085835BA31C0213B15EB83"]]]();
      }
    } else if(isDefined(var_24))
      var_0[var_24]["_encstr_BD1804DF5370"] waittill(var_9);

    if(var_21) {
      break;
    }
  }
}

waittill_animend(var_0, var_1) {
  self endon("_encstr_ADE407B9AF6F2DB1DA");
  var_0 waittillmatch(var_1, "_encstr_961804BD954A");
  return 1;
}

nag_timer(var_0, var_1) {
  self endon("_encstr_AD75063D571AE108");
  var_2 = var_0;
  var_3 = gettime();

  while(var_3 + var_0 * 1000 > gettime())
    wait 1;

  self notify("_encstr_ADE407B9AF6F2DB1DA");
}

anim_set_time_solo(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_3[0] = var_0;
  anim_set_time(var_3, var_1, var_2);
}

anim_set_time(var_0, var_1, var_2) {
  scripts\engine\utility::array_thread(var_0, ::anim_self_set_time, var_1, var_2);
}

anim_self_set_time(var_0, var_1) {
  var_2 = scripts\engine\utility::getanim(var_0);
  self setanimtime(var_2, var_1);
}

last_anim_time_check() {
  if(!isDefined(self.last_anim_time)) {
    self.last_anim_time = gettime();
    return;
  }

  var_0 = gettime();

  if(self.last_anim_time == var_0) {
    self endon("_encstr_AD75063D571AE108");
    wait 0.05;
  }

  self.last_anim_time = var_0;
}

anim_moveTo(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_anim_position(var_2);
  var_7 = var_6["_encstr_97FE07DE392D76D2CD"];
  var_8 = var_6["_encstr_A7610758E6CED8569B"];

  foreach(var_10 in var_0) {
    var_11 = getstartorigin(var_7, var_8, level.scr_anim[var_10.animname][var_1]);
    var_12 = getstartangles(var_7, var_8, level.scr_anim[var_10.animname][var_1]);

    if(isai(var_10)) {
      continue;
    }
    var_10 moveTo(var_11, var_3, var_4, var_5);
    var_10 rotateTo(var_12, var_3, var_4, var_5);
  }
}

anim_teleport_solo(var_0, var_1, var_2) {
  self endon("_encstr_AD75063D571AE108");
  var_3[0] = var_0;
  anim_teleport(var_3, var_1, var_2);
}

anim_teleport(var_0, var_1, var_2) {
  var_3 = get_anim_position(var_2);
  var_4 = var_3["_encstr_97FE07DE392D76D2CD"];
  var_5 = var_3["_encstr_A7610758E6CED8569B"];

  foreach(var_7 in var_0) {
    var_8 = getstartorigin(var_4, var_5, level.scr_anim[var_7.animname][var_1]);
    var_9 = getstartangles(var_4, var_5, level.scr_anim[var_7.animname][var_1]);
    var_7[[anim.callbacks["_encstr_A3AD0C3C9D5812D9C256E391C205"]]](var_8, var_9);
  }
}

anim_generic_teleport(var_0, var_1, var_2) {
  var_3 = get_anim_position(var_2);
  var_4 = var_3["_encstr_97FE07DE392D76D2CD"];
  var_5 = var_3["_encstr_A7610758E6CED8569B"];
  var_6 = getstartorigin(var_4, var_5, level.scr_anim["_encstr_979608DF73C8E70B73A1"][var_1]);
  var_7 = getstartangles(var_4, var_5, level.scr_anim["_encstr_979608DF73C8E70B73A1"][var_1]);
  var_0[[anim.callbacks["_encstr_A3AD0C3C9D5812D9C256E391C205"]]](var_6, var_7);
}

anim_spawn_generic_model(var_0, var_1, var_2) {
  return anim_spawn_model(var_0, "_encstr_979608DF73C8E70B73A1", var_1, var_2);
}

anim_spawn_model(var_0, var_1, var_2, var_3) {
  var_4 = get_anim_position(var_3);
  var_5 = var_4["_encstr_97FE07DE392D76D2CD"];
  var_6 = var_4["_encstr_A7610758E6CED8569B"];
  var_7 = getstartorigin(var_5, var_6, level.scr_anim[var_1][var_2]);
  var_8 = getstartorigin(var_5, var_6, level.scr_anim[var_1][var_2]);
  var_9 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_7);
  var_9 setModel(var_0);
  var_9.angles = var_8;
  return var_9;
}

anim_spawn_tag_model(var_0, var_1) {
  self attach(var_0, var_1);
}

anim_link_tag_model(var_0, var_1) {
  var_2 = self gettagorigin(var_1);
  var_3 = spawn("_encstr_82DC0DC6CB18BB5744B8C3978DEFB0", var_2);
  var_3 setModel(var_0);
  var_3 linkTo(self, var_1, (0, 0, 0), (0, 0, 0));
  return var_3;
}

removenotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_5 = level.scr_notetrack[var_0][var_2][var_1];
  var_2 = get_generic_anime(var_2);
  var_6 = -1;

  if(!isDefined(var_5) || !isarray(var_5) || var_5.size < 1) {
    return;
  }
  for(var_7 = 0; var_7 < var_5.size; var_7++) {
    if(isDefined(var_5[var_7][var_3])) {
      if(!isDefined(var_4) || var_5[var_7][var_3] == var_4) {
        var_6 = var_7;
        break;
      }
    }
  }

  if(var_6 < 0) {
    return;
  }
  if(var_5.size == 1)
    var_5 = [];
  else
    var_5 = scripts\engine\utility::array_remove_index(var_5, var_6);

  level.scr_notetrack[var_0][var_2][var_1] = var_5;
}

addnotetrack_flag(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = get_generic_anime(var_3);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_3);
  var_5 = [];
  var_5["_encstr_8F7905C4EDE23F"] = var_2;
  level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;

  if(scripts\common\utility::issp()) {
    if(!isDefined(level.flag) || !isDefined(level.flag[var_2]))
      scripts\engine\utility::flag_init(var_2);
  }
}

addnotetrack_flag_clear(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = get_generic_anime(var_3);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_3);
  var_5 = [];
  var_5["_encstr_B26E0B1F0888E789C6A9FFE7BD"] = var_2;
  level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;

  if(!isDefined(level.flag) || !isDefined(level.flag[var_2]))
    scripts\engine\utility::flag_init(var_2);
}

addnotetrack_dialogue(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_2);
  level.scr_notetrack[var_0][var_2][var_1][var_4] = [];
  level.scr_notetrack[var_0][var_2][var_1][var_4]["_encstr_B2DA070A5F8BAB87AF"] = var_3;
}

add_notetrack_and_get_index(var_0, var_1, var_2) {
  var_1 = tolower(var_1);
  add_notetrack_array(var_0, var_1, var_2);
  return level.scr_notetrack[var_0][var_2][var_1].size;
}

add_notetrack_array(var_0, var_1, var_2) {
  var_1 = tolower(var_1);

  if(!isDefined(level.scr_notetrack))
    level.scr_notetrack = [];

  if(!isDefined(level.scr_notetrack[var_0]))
    level.scr_notetrack[var_0] = [];

  if(!isDefined(level.scr_notetrack[var_0][var_2]))
    level.scr_notetrack[var_0][var_2] = [];

  if(!isDefined(level.scr_notetrack[var_0][var_2][var_1]))
    level.scr_notetrack[var_0][var_2][var_1] = [];
}

addnotetrack_sound(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_6 = add_notetrack_and_get_index(var_0, var_1, var_2);
  level.scr_notetrack[var_0][var_2][var_1][var_6] = [];
  level.scr_notetrack[var_0][var_2][var_1][var_6]["_encstr_8260069BDBBACD46"] = var_3;

  if(isDefined(var_4))
    level.scr_notetrack[var_0][var_2][var_1][var_6]["_encstr_9673124FF82BE6CA2F2E83FE135F31B471E02BAB"] = 1;

  if(isDefined(var_5))
    level.scr_notetrack[var_0][var_2][var_1][var_6]["_encstr_84A60DE355E5E0A5691F750F6BD27C"] = var_5;
}

note_track_start_sound(var_0, var_1, var_2, var_3) {
  var_4 = get_datascene();
  addnotetrack_sound(var_4.animname, var_0, var_4.anim_sequence, var_1, var_2, var_3);
}

addnotetrack_playersound(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_2);
  level.scr_notetrack[var_0][var_2][var_1][var_4] = [];
  level.scr_notetrack[var_0][var_2][var_1][var_4]["_encstr_85DE0C07362C2F2B9CDCBDEAB919"] = var_3;
}

get_generic_anime(var_0) {
  if(!isDefined(var_0))
    return "_encstr_9A19040BCDBC";

  return var_0;
}

addonstart_animsound(var_0, var_1, var_2) {
  if(!isDefined(level.scr_animsound[var_0]))
    level.scr_animsound[var_0] = [];

  level.scr_animsound[var_0][var_1] = var_2;
}

addnotetrack_playerdialogue(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_2);
  level.scr_notetrack[var_0][var_2][var_1][var_4] = [];
  level.scr_notetrack[var_0][var_2][var_1][var_4]["_encstr_AAF60FB220A0D1F2A651370F59C01A1578"] = var_3;
}

addnotetrack_animsound(var_0, var_1, var_2, var_3) {
  var_2 = tolower(var_2);
  var_1 = get_generic_anime(var_1);
  var_4 = add_notetrack_and_get_index(var_0, var_2, var_1);
  var_5 = [];
  var_5["_encstr_8260069BDBBACD46"] = var_3;
  var_5["_encstr_88E81581E34941FB372D6990975982438380D9E0A3C003"] = 1;
  level.scr_notetrack[var_0][var_1][var_2][var_4] = var_5;
}

addnotetrack_attach(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = get_generic_anime(var_4);
  var_5 = add_notetrack_and_get_index(var_0, var_1, var_4);
  var_6 = [];
  var_6["_encstr_B6190DB0A33A58C64302B67B4695C6"] = var_2;
  var_6["_encstr_B8150853D568125B7379"] = var_3;
  level.scr_notetrack[var_0][var_4][var_1][var_5] = var_6;
}

addnotetrack_detach(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_4 = get_generic_anime(var_4);
  var_5 = add_notetrack_and_get_index(var_0, var_1, var_4);
  var_6 = [];
  var_6["_encstr_BAD90D7043BB592B03098205DDD75B"] = var_2;
  var_6["_encstr_B8150853D568125B7379"] = var_3;
  level.scr_notetrack[var_0][var_4][var_1][var_5] = var_6;
}

addnotetrack_detach_gun(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_2);
  var_5 = [];
  var_5["_encstr_8CDD0B3B639DB2C3D89157DBB0"] = 1;
  var_5["_encstr_AF1904F3E3AC"] = "_encstr_91AC11A5C6EA277BF50F837BCB371383322C1D";

  if(isDefined(var_3))
    var_5["_encstr_B2E908B0FF5B2BEBFA0F"] = var_3;

  level.scr_notetrack[var_0][var_2][var_1][var_4] = var_5;
}

addnotetrack_attach_gun(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_2);
  var_5 = [];

  if(isDefined(var_3))
    var_5["_encstr_8F800C274B8BC1B35831A815CD57" + var_3] = 1;
  else
    var_5["_encstr_B13C1169E1A8569F2319527BF82F830C58A1F4"] = 1;

  level.scr_notetrack[var_0][var_2][var_1][var_4] = var_5;
}

addnotetrack_customfunction(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = get_generic_anime(var_3);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_3);
  var_5 = [];
  var_5["_encstr_B2BB0998FB35773B1FAFF0"] = var_2;
  level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;
}

addnotetrack_startfxontag(var_0, var_1, var_2, var_3, var_4, var_5) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_6 = add_notetrack_and_get_index(var_0, var_1, var_2);
  var_7 = [];
  var_7["_encstr_A23B07456F923B819C"] = var_3;
  var_7["_encstr_B8150853D568125B7379"] = var_4;

  if(isDefined(var_5))
    var_7["_encstr_BE3912AD7B27B2A20D5837454327ACAC900B6CAD"] = var_5;

  level.scr_notetrack[var_0][var_2][var_1][var_6] = var_7;
}

addnotetrack_stopFXOnTag(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_5 = add_notetrack_and_get_index(var_0, var_1, var_2);
  var_6 = [];
  var_6["_encstr_83BD0C3B7DA883E9F3334A721BF9"] = var_3;
  var_6["_encstr_B8150853D568125B7379"] = var_4;
  level.scr_notetrack[var_0][var_2][var_1][var_5] = var_6;
}

addnotetrack_mayhemstart(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_3 = get_generic_anime(var_3);
  var_5 = add_notetrack_and_get_index(var_0, var_1, var_3);
  var_6 = [];
  var_6["_encstr_88B50DB6582F0D56AD7DDC8E164E8E"] = var_2;
  var_6["_encstr_8C900E2542CA2798F15B7910CF0CF189"] = var_4;
  level.scr_notetrack[var_0][var_3][var_1][var_5] = var_6;
}

addnotetrack_mayhemend(var_0, var_1, var_2, var_3, var_4) {
  var_1 = tolower(var_1);
  var_3 = get_generic_anime(var_3);
  var_5 = add_notetrack_and_get_index(var_0, var_1, var_3);
  var_6 = [];
  var_6["_encstr_B65C0B6BC2BC34B2ADBE59CD19"] = var_2;
  var_6["_encstr_8C900E2542CA2798F15B7910CF0CF189"] = var_4;
  level.scr_notetrack[var_0][var_3][var_1][var_5] = var_6;
}

note_track_swap_to_efx(var_0, var_1, var_2) {
  var_3 = get_datascene();
  scripts\engine\utility::add_fx(var_1, var_1);
  addnotetrack_swapparttoefx(var_3.animname, var_0, var_3.animsequence, var_1, var_2);
}

note_track_stop_efx_on_tag(var_0, var_1, var_2) {
  var_3 = get_datascene();
  scripts\engine\utility::add_fx(var_1, var_1);
  addnotetrack_stopFXOnTag(var_3.animname, var_0, var_3.animsequence, var_1, var_2);
}

addnotetrack_swapparttoefx(var_0, var_1, var_2, var_3, var_4) {
  scripts\engine\utility::getfx(var_3);
  var_1 = tolower(var_1);
  var_2 = get_generic_anime(var_2);
  var_5 = add_notetrack_and_get_index(var_0, var_1, var_2);
  var_6 = [];
  var_6["_encstr_9612118B530F03114813AA9457502577A5E9B3"] = var_3;
  var_6["_encstr_B8150853D568125B7379"] = var_4;
  level.scr_notetrack[var_0][var_2][var_1][var_5] = var_6;
}

note_track_trace_to_efx(var_0, var_1, var_2, var_3, var_4, var_5) {
  var_6 = get_datascene();

  if(var_0 != "_encstr_99AD06D3A5B1538B" && !animhasnotetrack(var_6 scripts\engine\utility::getanim(var_6.anim_sequence), var_0)) {
    return;
  }
  scripts\engine\utility::add_fx(var_3, var_3);

  if(isDefined(var_4))
    scripts\engine\utility::add_fx(var_4, var_4);

  addnotetrack_tracepartforefx(var_6.animname, var_0, var_1, var_6.anim_sequence, var_2, var_3, var_4, var_5);
}

note_track_start_fx_on_tag(var_0, var_1, var_2) {
  var_3 = get_datascene();

  if(var_0 != "_encstr_99AD06D3A5B1538B" && !animhasnotetrack(var_3 scripts\engine\utility::getanim(var_3.anim_sequence), var_0)) {
    return;
  }
  scripts\engine\utility::add_fx(var_2, var_2);
  addnotetrack_startfxontag(var_3.animname, var_0, var_3.anim_sequence, var_2, var_1, 1);
}

get_datascene() {
  var_0 = level.current_anim_data_scene;
  return var_0;
}

addnotetrack_tracepartforefx(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  scripts\engine\utility::getfx(var_5);
  var_1 = tolower(var_1);
  var_3 = get_generic_anime(var_3);
  var_8 = add_notetrack_and_get_index(var_0, var_1, var_3);
  var_9 = [];
  var_9["_encstr_957013795B8226B0FFBA81FBA397E068CB87C3D5CB"] = var_5;
  var_9["_encstr_8DB1194739166CAC7D0E2C39A3AF99DB4EBE95990FD7BB163A594E"] = var_6;
  var_9["_encstr_87531A13250F8ADD49A3FE021B71E6825EE7DFA3D9B83291A8A9F78D"] = var_2;
  var_9["_encstr_BE6E208E390BC656FA07C2E4A3F533DB4EAF9566F0EB19CA8D56472BF53295E03AD0"] = var_7;
  var_9["_encstr_B8150853D568125B7379"] = var_4;
  level.scr_notetrack[var_0][var_3][var_1][var_8] = var_9;

  if(isDefined(var_2)) {
    var_9 = [];
    var_9["_encstr_B4051DE839B06CAC7DC158E48EBE99DBC9F5ACCCF0AFB1C2738D56B196CD9D"] = var_2;
    var_9["_encstr_B8150853D568125B7379"] = var_4;
    var_8 = add_notetrack_and_get_index(var_0, var_2, var_3);
    level.scr_notetrack[var_0][var_3][var_2][var_8] = var_9;
  }
}

addnotetrack_notify(var_0, var_1, var_2, var_3) {
  var_1 = tolower(var_1);
  var_3 = get_generic_anime(var_3);
  var_4 = add_notetrack_and_get_index(var_0, var_1, var_3);
  var_5 = [];
  var_5["_encstr_853D07F580C80102E3"] = var_2;
  level.scr_notetrack[var_0][var_3][var_1][var_4] = var_5;
}

setanimtree() {
  self useanimtree(level.scr_animtree[self.animname]);
}

initanim() {
  if(!isDefined(level.scr_notetrack))
    level.scr_notetrack = [];

  if(!isDefined(level.scr_face))
    level.scr_face = [];

  if(!isDefined(level.scr_head))
    level.scr_head = [];

  if(!isDefined(level.scr_look))
    level.scr_look = [];

  if(!isDefined(level.scr_animsound))
    level.scr_animsound = [];

  if(!isDefined(level.scr_sound))
    level.scr_sound = [];

  if(!isDefined(level.scr_radio))
    level.scr_radio = [];

  if(!isDefined(level.scr_text))
    level.scr_text = [];

  if(!isDefined(level.scr_anim))
    level.scr_anim[0][0] = 0;

  if(!isDefined(level.scr_animname))
    level.scr_animname = [];

  if(!isDefined(level.scr_radio))
    level.scr_radio = [];

  if(!isDefined(level.scr_plrdialogue))
    level.scr_plrdialogue = [];

  if(!isDefined(level.scr_goaltime))
    level.scr_goaltime = [];

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  if(!isDefined(level.scr_blockin))
    level.scr_blockin = [];

  thread precache_script_models_thread();
  thread precache_weapon_models_thread();
  scripts\engine\utility::create_lock("_encstr_BE3912AD7B27B2A20D5837454327ACAC900B6CAD", 3);
  scripts\engine\utility::create_lock("_encstr_957013795B8226B0FFBA81FBA397E068CB87C3D5CB", 12);
  init_animsounds();
}

precache_script_models_thread() {
  waittillframeend;

  if(!isDefined(level.scr_model)) {
    return;
  }
  var_0 = getarraykeys(level.scr_model);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    if(isarray(level.scr_model[var_0[var_1]])) {
      for(var_2 = 0; var_2 < level.scr_model[var_0[var_1]].size; var_2++)
        precachemodel(level.scr_model[var_0[var_1]][var_2]);

      continue;
    }

    precachemodel(level.scr_model[var_0[var_1]]);
  }
}

precache_weapon_models_thread() {
  waittillframeend;

  if(!isDefined(level.scr_weapon)) {
    return;
  }
  var_0 = getarraykeys(level.scr_weapon);

  for(var_1 = 0; var_1 < var_0.size; var_1++) {
    var_2 = [];

    if(isDefined(level.scr_weapon[var_0[var_1]][1]))
      var_2 = level.scr_weapon[var_0[var_1]][1];

    scripts\common\utility::make_weapon_model(level.scr_weapon[var_0[var_1]][0], var_2, 1, 1);
  }
}

init_animsounds() {
  level.animsounds = [];
  level.animsound_aliases = [];
  var_0 = getarraykeys(level.scr_notetrack);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    init_notetracks_for_animname(var_0[var_1]);

  var_0 = getarraykeys(level.scr_animsound);

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    init_animsounds_for_animname(var_0[var_1]);
}

init_animsounds_for_animname(var_0) {
  var_1 = getarraykeys(level.scr_animsound[var_0]);

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_3 = var_1[var_2];
    var_4 = level.scr_animsound[var_0][var_3];
    level.animsound_aliases[var_0][var_3]["_encstr_AA4C0223" + var_3]["_encstr_8D760BA3EF33C54D42B1B4A19B"] = var_4;
    level.animsound_aliases[var_0][var_3]["_encstr_AA4C0223" + var_3]["_encstr_88E81581E34941FB372D6990975982438380D9E0A3C003"] = 1;
  }
}

init_notetracks_for_animname(var_0) {
  foreach(var_10, var_2 in level.scr_notetrack[var_0]) {
    foreach(var_9, var_4 in var_2) {
      foreach(var_6 in var_4) {
        var_7 = var_6["_encstr_8260069BDBBACD46"];

        if(!isDefined(var_7)) {
          continue;
        }
        level.animsound_aliases[var_0][var_10][var_9]["_encstr_8D760BA3EF33C54D42B1B4A19B"] = var_7;

        if(isDefined(var_6["_encstr_88E81581E34941FB372D6990975982438380D9E0A3C003"]))
          level.animsound_aliases[var_0][var_10][var_9]["_encstr_88E81581E34941FB372D6990975982438380D9E0A3C003"] = 1;
      }
    }
  }
}

endonremoveanimactive(var_0, var_1) {
  self waittill(var_0);

  foreach(var_3 in var_1) {
    var_4 = var_3["_encstr_BD1804DF5370"];

    if(!isDefined(var_4)) {
      continue;
    }
    var_4._animactive--;
    var_4._lastanimtime = gettime();
  }
}

anim_deathnotify(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("_encstr_AD75063D571AE108");

  if(isDefined(var_0.anim_is_death) && var_0.anim_is_death) {
    return;
  }
  self notify(var_1);
}

anim_facialendnotify(var_0, var_1, var_2) {
  self endon(var_1);
  var_3 = getanimlength(var_2);
  wait(var_3);
  self notify(var_1);
}

anim_dialogueendnotify(var_0, var_1) {
  self endon(var_1);
  var_0 waittill("_encstr_ADFC102B49DB54CDB0F83C5F2722A0AFD562");
  self notify(var_1);
}

anim_animationendnotify(var_0, var_1, var_2, var_3) {
  self endon(var_1);
  var_0 endon("_encstr_AD75063D571AE108");
  var_2 = var_2 - var_3;

  if(var_3 > 0 && var_2 > 0) {
    var_0 scripts\engine\utility::waittill_match_or_timeout("_encstr_B26B0C62E310EFF82760E3BB9B80", "_encstr_961804BD954A", var_2);
    var_0 stopanimScripted();
  } else
    var_0 waittillmatch("_encstr_B26B0C62E310EFF82760E3BB9B80", "_encstr_961804BD954A");

  self notify(var_1);
}

anim_weight(var_0, var_1) {
  var_2 = level.scr_anim[var_0][var_1].size;
  var_3 = randomint(var_2);

  if(isDefined(level.scr_anim[var_0][var_1 + "_encstr_8FDE0783D823374B6B"]))
    var_3 = get_weighted_anim(var_0, var_1, var_2);

  return var_3;
}

get_weighted_anim(var_0, var_1, var_2) {
  var_3 = undefined;

  if(var_2 > 1) {
    var_4 = 0;
    var_5 = 0;

    for(var_6 = 0; var_6 < var_2; var_6++) {
      if(isDefined(level.scr_anim[var_0][var_1 + "_encstr_8FDE0783D823374B6B"])) {
        if(isDefined(level.scr_anim[var_0][var_1 + "_encstr_8FDE0783D823374B6B"][var_6])) {
          var_4++;
          var_5 = var_5 + level.scr_anim[var_0][var_1 + "_encstr_8FDE0783D823374B6B"][var_6];
        }
      }
    }

    if(var_4 == var_2) {
      var_7 = randomfloat(var_5);
      var_5 = 0;

      for(var_6 = 0; var_6 < var_2; var_6++) {
        var_5 = var_5 + level.scr_anim[var_0][var_1 + "_encstr_8FDE0783D823374B6B"][var_6];

        if(var_7 < var_5) {
          var_3 = var_6;
          break;
        }
      }
    }
  }

  return var_3;
}

#using_animtree("_encstr_A5AD0EDA0198272AF00797B83388B643");
#using_animtree("_encstr_B40101");

play_addtive_head_anim(var_0, var_1) {
  var_0 setanimlimited(%_encstr_9A151358914647D2CEB2AF43CAB019FA0B3796D6DC, 1.0, 0.2);
  var_0 setanimlimited(var_1, 1.0, 0.2);
  wait(getanimlength(var_1));
  var_0 clearanim(%_encstr_9A151358914647D2CEB2AF43CAB019FA0B3796D6DC, 0.2);
  var_0 clearanim(var_1, 0.2);
}

get_anim_position(var_0) {
  var_1 = undefined;
  var_2 = undefined;

  if(isDefined(var_0)) {
    var_1 = self gettagorigin(var_0);
    var_2 = self gettagangles(var_0);
  } else {
    var_1 = self.origin;
    var_2 = self.angles;

    if(!isDefined(var_2))
      var_2 = (0, 0, 0);
  }

  var_3 = [];
  var_3["_encstr_A7610758E6CED8569B"] = var_2;
  var_3["_encstr_97FE07DE392D76D2CD"] = var_1;
  return var_3;
}

anim_at_self(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_BD1804DF5370"] = self;
  var_2["_encstr_850E077B0BF30318B9"] = self;
  return var_2;
}

anim_at_entity(var_0, var_1) {
  var_2 = [];
  var_2["_encstr_BD1804DF5370"] = self;
  var_2["_encstr_850E077B0BF30318B9"] = var_0;
  var_2["_encstr_AF1904F3E3AC"] = var_1;
  return var_2;
}

assert_existance_of_anim(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = self.animname;

  var_2 = 0;

  if(isDefined(level.scr_anim[var_1])) {
    var_2 = 1;

    if(isDefined(level.scr_anim[var_1][var_0]))
      return;
  }

  var_3 = 0;

  if(isDefined(level.scr_face[var_1])) {
    var_3 = 1;

    if(isDefined(level.scr_face[var_1][var_0]))
      return;
  }

  var_4 = 0;

  if(isDefined(level.scr_sound[var_1])) {
    var_4 = 1;

    if(isDefined(level.scr_sound[var_1][var_0]))
      return;
  }

  var_5 = 0;

  if(isDefined(level.scr_blockin[var_1])) {
    var_5 = 1;

    if(isDefined(level.scr_blockin[var_1][var_0]))
      return;
  }

  if(var_2 || var_4 || var_3 || var_5) {
    if(var_2) {
      var_6 = getarraykeys(level.scr_anim[var_1]);

      foreach(var_8 in var_6) {}
    }

    if(var_4) {
      var_6 = getarraykeys(level.scr_sound[var_1]);

      foreach(var_8 in var_6) {}
    }

    if(var_3) {
      var_6 = getarraykeys(level.scr_face[var_1]);

      foreach(var_8 in var_6) {}
    }

    if(var_5) {
      var_6 = getarraykeys(level.scr_blockin[var_1]);

      foreach(var_8 in var_6) {}
    }

    return;
  }

  var_16 = getarraykeys(level.scr_anim);
  var_16 = scripts\engine\utility::array_combine(var_16, getarraykeys(level.scr_sound));

  foreach(var_18 in var_16) {}
}

anim_single_failsafeonguy(var_0, var_1) {}

anim_single_failsafe(var_0, var_1) {
  foreach(var_3 in var_0)
  var_3 thread anim_single_failsafeonguy(self, var_1);
}

anim_get_goal_time(var_0, var_1) {
  if(isDefined(level.scr_goaltime[var_0]) && isDefined(level.scr_goaltime[var_0][var_1]))
    return level.scr_goaltime[var_0][var_1];
  else
    return 0.5;
}