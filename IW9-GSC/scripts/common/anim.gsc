/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\common\anim.gsc
***********************************************/

anim_first_frame(guys, anime, tag) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];
  guys = _id_1EBA925251530689(guys, anime);
  scripts\engine\utility::array_levelthread(guys, ::anim_first_frame_on_guy, anime, org, angles);
}

anim_generic_first_frame(guy, anime, tag) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];
  thread anim_first_frame_on_guy(guy, anime, org, angles, "generic");
}

anim_generic(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_single(guys, anime, tag, 0, "generic");
}

anim_generic_run(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_single(guys, anime, tag, 0.25, "generic");
}

anim_single_solo_run(guy, anime, tag) {
  self endon("death");
  _id_280EE35A5ECCE148[0] = guy;
  anim_single(_id_280EE35A5ECCE148, anime, tag, 0.25);
}

anim_first_frame_solo(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_first_frame(guys, anime, tag);
}

anim_first_frame_on_guy(guy, anime, org, angles, _id_8E3B87ACAAD3DE58) {
  guy.first_frame_time = gettime();
  animname = undefined;

  if(isDefined(_id_8E3B87ACAAD3DE58))
    animname = _id_8E3B87ACAAD3DE58;
  else
    animname = guy.animname;

  _id_469F8A33356C276F = 0;

  if(_id_F1E7EE8DDEECE062(anime))
    animation = guy _id_C099F6FD9C19F5A6(anime, org, angles, animname);
  else if(isarray(level.scr_anim[animname][anime])) {
    animation = level.scr_anim[animname][anime][0];
    _id_469F8A33356C276F = 1;
  } else
    animation = level.scr_anim[animname][anime];

  guy set_start_pos(anime, org, angles, animname, _id_469F8A33356C276F, animation);

  if(isai(guy))
    guy[[anim.callbacks["AIAnimFirstFrame"]]](animation, animname);
  else {
    guy stopanimScripted();
    guy setanimknob(animation, 1, 0, 0);

    if(!scripts\common\utility::issp()) {
      if(!isPlayer(guy) && isDefined(level.scr_animname[animname]) && isDefined(level.scr_animname[animname][anime]))
        guy call[[level.func["scriptModelPlayAnim"]]](level.scr_animname[animname][anime], undefined, 0, 0, "none");
    }
  }
}

set_start_pos(anime, org, angles, _id_8E3B87ACAAD3DE58, anim_array, animation) {
  animname = undefined;

  if(isDefined(_id_8E3B87ACAAD3DE58))
    animname = _id_8E3B87ACAAD3DE58;
  else
    animname = self.animname;

  if(!isDefined(animation)) {
    if(_id_F1E7EE8DDEECE062(anime))
      animation = _id_C099F6FD9C19F5A6(anime, org, angles, animname);
    else if(isDefined(anim_array) && anim_array)
      animation = level.scr_anim[animname][anime][0];
    else
      animation = level.scr_anim[animname][anime];
  }

  _id_B48C995A0A557FF1 = getstartorigin(org, angles, animation);
  _id_B98CF035C97EDEE9 = getstartangles(org, angles, animation);
  self[[anim.callbacks["TeleportEnt"]]](_id_B48C995A0A557FF1, _id_B98CF035C97EDEE9);
}

anim_start_pos(_id_76CA61EAD2153A39, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  scripts\engine\utility::array_thread(_id_76CA61EAD2153A39, ::set_start_pos, anime, org, angles);
}

anim_start_pos_solo(guy, anime, tag) {
  _id_280EE35A5ECCE148[0] = guy;
  anim_start_pos(_id_280EE35A5ECCE148, anime, tag);
}

anim_last_frame_solo(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_first_frame(guys, anime, tag);
  anim_set_time(guys, anime, 1.0);
  animation = guy scripts\engine\utility::getanim(anime);
  _id_01079B2F7AE39DD0 = getmovedelta(animation);
  rotation = getangledelta3d(animation);
  _id_357AE03F80F39459 = rotatevector(_id_01079B2F7AE39DD0, guy.angles);
  origin = guy.origin + _id_357AE03F80F39459;
  angles = combineangles(guy.angles, rotation);
  guy[[anim.callbacks["TeleportEnt"]]](origin, angles);
}

anim_single_solo(guy, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58) {
  self endon("death");
  _id_280EE35A5ECCE148[0] = guy;

  if(!isDefined(_id_9E8A16D47A03007A))
    _id_9E8A16D47A03007A = 0;

  anim_single(_id_280EE35A5ECCE148, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58);
}

anim_single_internal(guys, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58) {
  entity = self;

  foreach(guy in guys) {
    if(!isDefined(guy)) {
      continue;
    }
    if(!isDefined(guy._animactive))
      guy._animactive = 0;

    guy._animactive++;
  }

  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  _id_C89CF41205D8055D = undefined;
  _id_2AFD32F7CAD8AF86 = 999999;
  _id_7D006C3A8C8FF60A = undefined;
  _id_A3D52619ED30853A = undefined;
  _id_2A44BD45833FC3EF = undefined;
  _id_910E49245FADFC70 = undefined;
  _id_314C4455B996B224 = "single anim";
  _id_328B6E3CD8CA1AF4 = 0;

  if(isDefined(level._id_79C41A27B516111F) && isDefined(level._id_79C41A27B516111F[anime]))
    _id_328B6E3CD8CA1AF4 = 1;

  guys = _id_1EBA925251530689(guys, anime);

  foreach(_id_AC0E594AC96AA3A8, guy in guys) {
    if(!isDefined(guy)) {
      continue;
    }
    _id_63A1F320F9C2DDF5 = 0;
    _id_AE4F6E4D11BB5ADB = 0;
    _id_09AC73A1996D2DAE = 0;
    _id_83D9EFDEA230AF8E = 0;
    _id_B6EFD5E31167B2F7 = 0;
    dialogue = undefined;
    _id_FC40661B94DE2C5C = undefined;
    _id_6ABAD61CA454F906 = undefined;
    animname = undefined;

    if(isDefined(_id_8E3B87ACAAD3DE58))
      animname = _id_8E3B87ACAAD3DE58;
    else
      animname = guy.animname;

    if(isDefined(level.scr_sound[animname]) && isDefined(level.scr_sound[animname][anime])) {
      _id_09AC73A1996D2DAE = 1;
      dialogue = level.scr_sound[animname][anime];
    }

    if(isDefined(level.scr_face[animname]) && isDefined(level.scr_face[animname][anime])) {
      _id_63A1F320F9C2DDF5 = 1;
      _id_FC40661B94DE2C5C = level.scr_face[animname][anime];
      _id_2A44BD45833FC3EF = _id_FC40661B94DE2C5C;

      if(_id_09AC73A1996D2DAE) {
        if(animhasnotetrack(_id_FC40661B94DE2C5C, "vo_" + dialogue)) {
          _id_09AC73A1996D2DAE = 0;
          dialogue = undefined;
        }
      }
    }

    if(isDefined(level.scr_head[animname]) && isDefined(level.scr_head[animname][anime])) {
      _id_AE4F6E4D11BB5ADB = 1;
      _id_6ABAD61CA454F906 = level.scr_head[animname][anime];
      _id_910E49245FADFC70 = _id_6ABAD61CA454F906;
    }

    if(isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][anime]) && self[[anim.callbacks["ShouldDoAnim"]]]())
      _id_83D9EFDEA230AF8E = 1;

    if(isDefined(level.scr_animsound[animname]) && isDefined(level.scr_animsound[animname][anime]))
      guy playSound(level.scr_animsound[animname][anime]);

    if(_id_83D9EFDEA230AF8E) {
      _id_43E50904D011917E = undefined;

      if(_id_6BC36C81FC28A22E())
        _id_43E50904D011917E = self;

      _id_EB5B1F36E255152D = guy[[anim.callbacks["DoAnimation"]]](org, angles, animname, anime, _id_314C4455B996B224, undefined, _id_43E50904D011917E);

      if(_id_EB5B1F36E255152D < _id_2AFD32F7CAD8AF86) {
        _id_2AFD32F7CAD8AF86 = _id_EB5B1F36E255152D;
        _id_C89CF41205D8055D = _id_AC0E594AC96AA3A8;
      }
    }

    if(_id_63A1F320F9C2DDF5 || _id_09AC73A1996D2DAE) {
      if(guy[[anim.callbacks["DoFacialAnim"]]](_id_63A1F320F9C2DDF5, _id_09AC73A1996D2DAE, _id_83D9EFDEA230AF8E, anime, animname, dialogue, 0))
        _id_A3D52619ED30853A = _id_AC0E594AC96AA3A8;

      _id_7D006C3A8C8FF60A = _id_AC0E594AC96AA3A8;
    }

    if(isai(guy)) {}

    if(_id_AE4F6E4D11BB5ADB)
      guy thread play_addtive_head_anim(guy, _id_910E49245FADFC70);

    if(!isPlayer(guy) && !isagent(guy) && !isDefined(guy.vehiclename) && isDefined(level.scr_animname[animname]) && isDefined(level.scr_animname[animname][anime]))
      guy scripts\engine\utility::self_func("scriptModelPlayAnim", level.scr_animname[animname][anime]);

    if(guy _id_E42B762E098C8F9E())
      guy _meth_4BEB9F7715504995(guy._id_37B96012304143D7, guy._id_F1A075B476CA91F1, "tag_camera");
  }

  if(_id_328B6E3CD8CA1AF4)
    [[anim.callbacks["playXcam"]]](level._id_79C41A27B516111F[anime], org, angles);
  else if(isDefined(_id_C89CF41205D8055D)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[_id_C89CF41205D8055D], anime);
    ent thread anim_animationendnotify(guys[_id_C89CF41205D8055D], anime, _id_2AFD32F7CAD8AF86, _id_9E8A16D47A03007A);
    ent waittill(anime);
  } else if(isDefined(_id_A3D52619ED30853A)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[_id_A3D52619ED30853A], anime);
    ent thread anim_facialendnotify(guys[_id_A3D52619ED30853A], anime, _id_2A44BD45833FC3EF);
    ent waittill(anime);
  } else if(isDefined(_id_7D006C3A8C8FF60A)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[_id_7D006C3A8C8FF60A], anime);
    ent thread anim_dialogueendnotify(guys[_id_7D006C3A8C8FF60A], anime);
    ent waittill(anime);
  }

  foreach(guy in guys) {
    if(!isDefined(guy))
      continue;
    else if(isagent(guy) && !isalive(guy)) {
      continue;
    }
    guy._animactive--;
    guy._lastanimtime = gettime();
  }

  self notify(anime);
}

anim_single(guys, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58) {
  if(!isDefined(_id_9E8A16D47A03007A))
    _id_9E8A16D47A03007A = 0;

  anim_single_internal(guys, anime, tag, _id_9E8A16D47A03007A, _id_8E3B87ACAAD3DE58);
}

anim_loop_solo(guy, anime, ender, tag, _id_656E3D548572FAF6, _id_8E3B87ACAAD3DE58) {
  self endon("death");
  guy endon("death");
  _id_280EE35A5ECCE148[0] = guy;
  anim_loop(_id_280EE35A5ECCE148, anime, ender, tag, _id_656E3D548572FAF6, _id_8E3B87ACAAD3DE58);
}

anim_loop_solo_with_nags(guy, anime, ender, tag) {
  self endon("death");
  guy endon("death");
  _id_280EE35A5ECCE148[0] = guy;
  anim_loop(_id_280EE35A5ECCE148, anime, ender, tag);
}

anim_generic_loop(guy, anime, ender, tag) {
  _id_AD98E6D70679846D = [];
  _id_AD98E6D70679846D["guy"] = guy;
  _id_AD98E6D70679846D["entity"] = self;
  _id_AD98E6D70679846D["tag"] = tag;
  _id_3D308E5CD595225D[0] = _id_AD98E6D70679846D;
  anim_loop_packet(_id_3D308E5CD595225D, anime, ender, "generic");
}

anim_loop(guys, anime, ender, tag, _id_656E3D548572FAF6, _id_8E3B87ACAAD3DE58) {
  _id_3D308E5CD595225D = [];

  foreach(guy in guys) {
    _id_AD98E6D70679846D = [];
    _id_AD98E6D70679846D["guy"] = guy;
    _id_AD98E6D70679846D["entity"] = self;
    _id_AD98E6D70679846D["tag"] = tag;
    _id_AD98E6D70679846D["origin_offset"] = _id_656E3D548572FAF6;
    _id_3D308E5CD595225D[_id_3D308E5CD595225D.size] = _id_AD98E6D70679846D;
  }

  anim_loop_packet(_id_3D308E5CD595225D, anime, ender, _id_8E3B87ACAAD3DE58);
}

anim_loop_packet_solo(_id_6FAB270F71D41318, anime, ender, _id_8E3B87ACAAD3DE58) {
  _id_9A78A1C57E90A3FB = [];
  _id_9A78A1C57E90A3FB[0] = _id_6FAB270F71D41318;
  anim_loop_packet(_id_9A78A1C57E90A3FB, anime, ender, _id_8E3B87ACAAD3DE58);
}

pick_nag_anim(_id_5842E592DDCEF384) {
  _id_0E77B7DA8D8132C4 = undefined;

  if(_id_5842E592DDCEF384.nag_anims.size == 1)
    _id_0E77B7DA8D8132C4 = 0;
  else if(_id_5842E592DDCEF384.currentnagindex == _id_5842E592DDCEF384.nag_anims.size - 1)
    _id_0E77B7DA8D8132C4 = 0;
  else
    _id_0E77B7DA8D8132C4 = _id_5842E592DDCEF384.currentnagindex + 1;

  _id_5842E592DDCEF384.currentnagindex = _id_0E77B7DA8D8132C4;
  _id_5842E592DDCEF384.last_nag_time = gettime();
  return _id_5842E592DDCEF384.currentnagindex;
}

anim_loop_packet(_id_3D308E5CD595225D, anime, ender, _id_8E3B87ACAAD3DE58) {
  foreach(_id_F2811089F0EB595C in _id_3D308E5CD595225D) {
    guy = _id_F2811089F0EB595C["guy"];

    if(!isDefined(guy)) {
      continue;
    }
    if(!isDefined(guy._animactive))
      guy._animactive = 0;

    guy endon("death");
    guy._animactive++;
  }

  _id_BB7E95C4F524E79F = _id_3D308E5CD595225D[0]["guy"];

  if(!isDefined(ender))
    ender = "stop_loop";

  thread endonremoveanimactive(ender, _id_3D308E5CD595225D);
  self endon(ender);
  _id_314C4455B996B224 = "looping anim";
  base_anime = anime;
  _id_F9909A84715A4DDF = undefined;

  if(isDefined(_id_8E3B87ACAAD3DE58))
    _id_F9909A84715A4DDF = _id_8E3B87ACAAD3DE58;
  else
    _id_F9909A84715A4DDF = _id_BB7E95C4F524E79F.animname;

  idleanim = 0;
  _id_81D62D85676996DA = 0;
  _id_AC74514763A944F4 = 0;
  _id_6BEB6C37769023F8 = isDefined(level.scr_anim[_id_F9909A84715A4DDF][anime + "_nags"]);

  if(_id_6BEB6C37769023F8 && scripts\common\utility::issp()) {
    ai = 0;

    foreach(_id_AC0E594AC96AA3A8, _id_F2811089F0EB595C in _id_3D308E5CD595225D) {
      if(isai(_id_F2811089F0EB595C["guy"]))
        ai++;
    }

    if(isDefined(level.scr_anim[_id_F9909A84715A4DDF][anime + "_nags_timer"]))
      _id_AC74514763A944F4 = level.scr_anim[_id_F9909A84715A4DDF][anime + "_nags_timer"];
    else
      _id_AC74514763A944F4 = 15;
  }

  _id_9A2893FB28421D42 = 0;
  _id_D851A74F8DF27DE9 = undefined;
  _id_405D3683254D21E8 = 0;

  if(_id_6BEB6C37769023F8) {
    setdvarifuninitialized("scr_debug_nags", 0);
    _id_D851A74F8DF27DE9 = spawnStruct();
    _id_D851A74F8DF27DE9.last_nag_time = gettime();
    _id_D851A74F8DF27DE9.nag_anims = level.scr_anim[_id_F9909A84715A4DDF][anime + "_nags"];
    _id_D851A74F8DF27DE9.currentnagindex = 0;
    childthread nag_timer(_id_AC74514763A944F4, _id_BB7E95C4F524E79F);
  }

  for(;;) {
    if(!_id_9A2893FB28421D42 && !isagent(_id_BB7E95C4F524E79F)) {
      anime = base_anime;

      for(idleanim = anim_weight(_id_F9909A84715A4DDF, anime); idleanim == _id_81D62D85676996DA && idleanim != 0; idleanim = anim_weight(_id_F9909A84715A4DDF, anime)) {}
    } else if(!isagent(_id_BB7E95C4F524E79F)) {
      idleanim = pick_nag_anim(_id_D851A74F8DF27DE9);
      anime = base_anime + "_nags";
      childthread nag_timer(_id_AC74514763A944F4, _id_BB7E95C4F524E79F);
      _id_9A2893FB28421D42 = 0;
    } else
      idleanim = anime;

    _id_81D62D85676996DA = idleanim;
    _id_C89CF41205D8055D = undefined;
    _id_2AFD32F7CAD8AF86 = 999999;
    _id_7D006C3A8C8FF60A = undefined;
    guy = undefined;

    foreach(_id_AC0E594AC96AA3A8, _id_F2811089F0EB595C in _id_3D308E5CD595225D) {
      entity = _id_F2811089F0EB595C["entity"];
      guy = _id_F2811089F0EB595C["guy"];
      pos = entity get_anim_position(_id_F2811089F0EB595C["tag"]);
      org = pos["origin"];
      angles = pos["angles"];

      if(isDefined(_id_F2811089F0EB595C["origin_offset"])) {
        offset = _id_F2811089F0EB595C["origin_offset"];
        forward = anglesToForward(angles);
        right = anglestoright(angles);
        up = anglestoup(angles);
        org = org + forward * offset[0];
        org = org + right * offset[1];
        org = org + up * offset[2];
      }

      if(isDefined(guy.remove_from_animloop)) {
        guy.remove_from_animloop = undefined;
        _id_3D308E5CD595225D[_id_AC0E594AC96AA3A8] = undefined;
        continue;
      }

      _id_63A1F320F9C2DDF5 = 0;
      _id_09AC73A1996D2DAE = 0;
      _id_83D9EFDEA230AF8E = 0;
      _id_B6EFD5E31167B2F7 = 0;
      _id_FC40661B94DE2C5C = undefined;
      dialogue = undefined;
      animname = undefined;

      if(isDefined(_id_8E3B87ACAAD3DE58))
        animname = _id_8E3B87ACAAD3DE58;
      else
        animname = guy.animname;

      if(isDefined(level.scr_face[animname]) && isDefined(level.scr_face[animname][anime]) && isDefined(level.scr_face[animname][anime][idleanim])) {
        _id_63A1F320F9C2DDF5 = 1;
        _id_FC40661B94DE2C5C = level.scr_face[animname][anime][idleanim];
      }

      if(isDefined(level.scr_sound[animname]) && isDefined(level.scr_sound[animname][anime]) && isDefined(level.scr_sound[animname][anime][idleanim])) {
        _id_09AC73A1996D2DAE = 1;
        dialogue = level.scr_sound[animname][anime][idleanim];
      }

      if(isDefined(level.scr_animsound[animname]) && isDefined(level.scr_animsound[animname][idleanim + anime]))
        guy playSound(level.scr_animsound[animname][idleanim + anime]);

      if(isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][anime]) && self[[anim.callbacks["ShouldDoAnim"]]]())
        _id_83D9EFDEA230AF8E = 1;
      else if(isagent(guy) && self[[anim.callbacks["ShouldDoAnim"]]]())
        _id_83D9EFDEA230AF8E = 1;

      if(_id_83D9EFDEA230AF8E) {
        _id_EB5B1F36E255152D = guy[[anim.callbacks["DoAnimation"]]](org, angles, animname, anime, _id_314C4455B996B224, idleanim, undefined);

        if(_id_EB5B1F36E255152D < _id_2AFD32F7CAD8AF86) {
          _id_2AFD32F7CAD8AF86 = _id_EB5B1F36E255152D;
          _id_C89CF41205D8055D = _id_AC0E594AC96AA3A8;
        }
      }

      if(_id_63A1F320F9C2DDF5 || _id_09AC73A1996D2DAE) {
        guy[[anim.callbacks["DoFacialAnim"]]](_id_63A1F320F9C2DDF5, _id_09AC73A1996D2DAE, _id_83D9EFDEA230AF8E, anime, animname, dialogue, 1);
        _id_7D006C3A8C8FF60A = _id_AC0E594AC96AA3A8;
      }
    }

    if(!isDefined(guy)) {
      break;
    }

    if(isDefined(_id_C89CF41205D8055D)) {
      _id_D06DE988641FD606 = waittill_animend(_id_3D308E5CD595225D[_id_C89CF41205D8055D]["guy"], _id_314C4455B996B224, _id_6BEB6C37769023F8);

      if(!isDefined(_id_D06DE988641FD606) && _id_6BEB6C37769023F8) {
        _id_9A2893FB28421D42 = 1;

        if(isDefined(anim.callbacks["StopAnimscripted"]))
          guy[[anim.callbacks["StopAnimscripted"]]]();
      }
    } else if(isDefined(_id_7D006C3A8C8FF60A))
      _id_3D308E5CD595225D[_id_7D006C3A8C8FF60A]["guy"] waittill(_id_314C4455B996B224);

    if(_id_405D3683254D21E8) {
      break;
    }
  }
}

waittill_animend(guy, _id_65DC1767352C19CD, _id_6BEB6C37769023F8) {
  if(istrue(_id_6BEB6C37769023F8))
    self endon("do_nag");

  guy waittillmatch(_id_65DC1767352C19CD, "end");
  return 1;
}

nag_timer(timer, guy) {
  self endon("death");
  temp = timer;
  currenttime = gettime();

  while(currenttime + timer * 1000 > gettime())
    wait 1;

  self notify("do_nag");
}

anim_set_time_solo(guy, anime, time) {
  self endon("death");
  _id_280EE35A5ECCE148[0] = guy;
  anim_set_time(_id_280EE35A5ECCE148, anime, time);
}

anim_set_time(guys, anime, time) {
  scripts\engine\utility::array_thread(guys, ::anim_self_set_time, anime, time);
}

anim_self_set_time(anime, time) {
  animation = scripts\engine\utility::getanim(anime);
  self setanimtime(animation, time);
}

last_anim_time_check() {
  if(!isDefined(self.last_anim_time)) {
    self.last_anim_time = gettime();
    return;
  }

  time = gettime();

  if(self.last_anim_time == time) {
    self endon("death");
    wait 0.05;
  }

  self.last_anim_time = time;
}

anim_moveTo(guys, anime, tag, time, _id_5FCD68807ADA6113, _id_EFE93C754F5124E6) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  foreach(guy in guys) {
    _id_D917428537562C1F = getstartorigin(org, angles, level.scr_anim[guy.animname][anime]);
    startang = getstartangles(org, angles, level.scr_anim[guy.animname][anime]);

    if(isai(guy)) {
      continue;
    }
    guy moveTo(_id_D917428537562C1F, time, _id_5FCD68807ADA6113, _id_EFE93C754F5124E6);
    guy rotateTo(startang, time, _id_5FCD68807ADA6113, _id_EFE93C754F5124E6);
  }
}

anim_teleport_solo(guy, anime, tag) {
  self endon("death");
  _id_280EE35A5ECCE148[0] = guy;
  anim_teleport(_id_280EE35A5ECCE148, anime, tag);
}

anim_teleport(guys, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  foreach(guy in guys) {
    _id_D917428537562C1F = getstartorigin(org, angles, level.scr_anim[guy.animname][anime]);
    startang = getstartangles(org, angles, level.scr_anim[guy.animname][anime]);
    guy[[anim.callbacks["TeleportEnt"]]](_id_D917428537562C1F, startang);
  }
}

anim_generic_teleport(guy, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  _id_D917428537562C1F = getstartorigin(org, angles, level.scr_anim["generic"][anime]);
  startang = getstartangles(org, angles, level.scr_anim["generic"][anime]);
  guy[[anim.callbacks["TeleportEnt"]]](_id_D917428537562C1F, startang);
}

anim_spawn_generic_model(model, anime, tag) {
  return anim_spawn_model(model, "generic", anime, tag);
}

anim_spawn_model(model, animname, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  _id_D917428537562C1F = getstartorigin(org, angles, level.scr_anim[animname][anime]);
  startangles = getstartorigin(org, angles, level.scr_anim[animname][anime]);
  spawned = spawn("script_model", _id_D917428537562C1F);
  spawned setModel(model);
  spawned.angles = startangles;
  return spawned;
}

anim_spawn_tag_model(model, tag) {
  self attach(model, tag);
}

anim_link_tag_model(model, tag) {
  org = self gettagorigin(tag);
  spawned = spawn("script_model", org);
  spawned setModel(model);
  spawned linkTo(self, tag, (0, 0, 0), (0, 0, 0));
  return spawned;
}

removenotetrack(animname, notetrack, anime, _id_EFEC8B343B47B761, ent) {
  notetrack = tolower(notetrack);
  array = level.scr_notetrack[animname][anime][notetrack];
  anime = get_generic_anime(anime);
  index = -1;

  if(!isDefined(array) || !isarray(array) || array.size < 1) {
    return;
  }
  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < array.size; _id_AC0E594AC96AA3A8++) {
    if(isDefined(array[_id_AC0E594AC96AA3A8][_id_EFEC8B343B47B761])) {
      if(!isDefined(ent) || array[_id_AC0E594AC96AA3A8][_id_EFEC8B343B47B761] == ent) {
        index = _id_AC0E594AC96AA3A8;
        break;
      }
    }
  }

  if(index < 0) {
    return;
  }
  if(array.size == 1)
    array = [];
  else
    array = scripts\engine\utility::array_remove_index(array, index);

  level.scr_notetrack[animname][anime][notetrack] = array;
}

addnotetrack_flag(animname, notetrack, _id_3F594777B26BB842, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["flag"] = _id_3F594777B26BB842;
  level.scr_notetrack[animname][anime][notetrack][index] = array;

  if(scripts\common\utility::issp()) {
    if(!isDefined(level.flag) || !isDefined(level.flag[_id_3F594777B26BB842]))
      scripts\engine\utility::flag_init(_id_3F594777B26BB842);
  }
}

addnotetrack_flag_clear(animname, notetrack, _id_3F594777B26BB842, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["flag_clear"] = _id_3F594777B26BB842;
  level.scr_notetrack[animname][anime][notetrack][index] = array;

  if(!isDefined(level.flag) || !isDefined(level.flag[_id_3F594777B26BB842]))
    scripts\engine\utility::flag_init(_id_3F594777B26BB842);
}

addnotetrack_dialogue(animname, notetrack, anime, soundalias) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["dialog"] = soundalias;
}

add_notetrack_and_get_index(animname, notetrack, anime) {
  notetrack = tolower(notetrack);
  add_notetrack_array(animname, notetrack, anime);
  return level.scr_notetrack[animname][anime][notetrack].size;
}

add_notetrack_array(animname, notetrack, anime) {
  notetrack = tolower(notetrack);

  if(!isDefined(level.scr_notetrack))
    level.scr_notetrack = [];

  if(!isDefined(level.scr_notetrack[animname]))
    level.scr_notetrack[animname] = [];

  if(!isDefined(level.scr_notetrack[animname][anime]))
    level.scr_notetrack[animname][anime] = [];

  if(!isDefined(level.scr_notetrack[animname][anime][notetrack]))
    level.scr_notetrack[animname][anime][notetrack] = [];
}

addnotetrack_sound(animname, notetrack, anime, soundalias, _id_726D01A949D1F3C0, tag) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["sound"] = soundalias;

  if(isDefined(_id_726D01A949D1F3C0))
    level.scr_notetrack[animname][anime][notetrack][index]["sound_stays_death"] = 1;

  if(isDefined(tag))
    level.scr_notetrack[animname][anime][notetrack][index]["sound_on_tag"] = tag;
}

note_track_start_sound(notetrack, soundalias, _id_726D01A949D1F3C0, tag) {
  _id_84B542BB7490BEA7 = get_datascene();
  addnotetrack_sound(_id_84B542BB7490BEA7.animname, notetrack, _id_84B542BB7490BEA7.anim_sequence, soundalias, _id_726D01A949D1F3C0, tag);
}

addnotetrack_playersound(animname, notetrack, anime, soundalias) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["playersound"] = soundalias;
}

get_generic_anime(anime) {
  if(!isDefined(anime))
    return "any";

  return anime;
}

addonstart_animsound(animname, anime, soundalias) {
  if(!isDefined(level.scr_animsound[animname]))
    level.scr_animsound[animname] = [];

  level.scr_animsound[animname][anime] = soundalias;
}

addnotetrack_playerdialogue(animname, notetrack, anime, soundalias) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["playerdialogue"] = soundalias;
}

addnotetrack_animsound(animname, anime, notetrack, soundalias) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["sound"] = soundalias;
  array["created_by_animSound"] = 1;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_attach(animname, notetrack, model, tag, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["attach model"] = model;
  array["selftag"] = tag;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_detach(animname, notetrack, model, tag, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["detach model"] = model;
  array["selftag"] = tag;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_detach_gun(animname, notetrack, anime, _id_EA111DE8E9327C27) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["detach gun"] = 1;
  array["tag"] = "tag_weapon_right";

  if(isDefined(_id_EA111DE8E9327C27))
    array["suspend"] = _id_EA111DE8E9327C27;

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_attach_gun(animname, notetrack, anime, _id_4C37AFCAAEE1C603) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];

  if(isDefined(_id_4C37AFCAAEE1C603))
    array["attach gun " + _id_4C37AFCAAEE1C603] = 1;
  else
    array["attach gun right"] = 1;

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_customfunction(animname, notetrack, function, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["function"] = function;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_startfxontag(animname, notetrack, anime, _id_9ACB3E153A9DC5F6, tagname, _id_5B177E6195F463E0) {
  scripts\engine\utility::getfx(_id_9ACB3E153A9DC5F6);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["effect"] = _id_9ACB3E153A9DC5F6;
  array["selftag"] = tagname;

  if(isDefined(_id_5B177E6195F463E0))
    array["moreThanThreeHack"] = _id_5B177E6195F463E0;

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_stopFXOnTag(animname, notetrack, anime, _id_9ACB3E153A9DC5F6, tagname) {
  scripts\engine\utility::getfx(_id_9ACB3E153A9DC5F6);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["stop_effect"] = _id_9ACB3E153A9DC5F6;
  array["selftag"] = tagname;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_mayhemstart(animname, notetrack, animation, anime, _id_5A75409EF0C9A36A) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["mayhem_start"] = animation;
  array["use_hat_model"] = _id_5A75409EF0C9A36A;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

addnotetrack_mayhemend(animname, notetrack, animation, anime, _id_5A75409EF0C9A36A) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["mayhem_end"] = animation;
  array["use_hat_model"] = _id_5A75409EF0C9A36A;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

note_track_swap_to_efx(notetrack, _id_94C7BB1299AD3A66, tagname) {
  _id_84B542BB7490BEA7 = get_datascene();
  scripts\engine\utility::add_fx(_id_94C7BB1299AD3A66, _id_94C7BB1299AD3A66);
  addnotetrack_swapparttoefx(_id_84B542BB7490BEA7.animname, notetrack, _id_84B542BB7490BEA7.animsequence, _id_94C7BB1299AD3A66, tagname);
}

note_track_stop_efx_on_tag(notetrack, _id_94C7BB1299AD3A66, tagname) {
  _id_84B542BB7490BEA7 = get_datascene();
  scripts\engine\utility::add_fx(_id_94C7BB1299AD3A66, _id_94C7BB1299AD3A66);
  addnotetrack_stopFXOnTag(_id_84B542BB7490BEA7.animname, notetrack, _id_84B542BB7490BEA7.animsequence, _id_94C7BB1299AD3A66, tagname);
}

addnotetrack_swapparttoefx(animname, notetrack, anime, _id_9ACB3E153A9DC5F6, tagname) {
  scripts\engine\utility::getfx(_id_9ACB3E153A9DC5F6);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["swap_part_to_efx"] = _id_9ACB3E153A9DC5F6;
  array["selftag"] = tagname;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

note_track_trace_to_efx(notetrack, _id_C7C4553CAAE5C97E, tagname, _id_94C7BB1299AD3A66, _id_56AEF90205769A90, _id_420B93892AD918C4) {
  _id_84B542BB7490BEA7 = get_datascene();

  if(notetrack != "start" && !animhasnotetrack(_id_84B542BB7490BEA7 scripts\engine\utility::getanim(_id_84B542BB7490BEA7.anim_sequence), notetrack)) {
    return;
  }
  scripts\engine\utility::add_fx(_id_94C7BB1299AD3A66, _id_94C7BB1299AD3A66);

  if(isDefined(_id_56AEF90205769A90))
    scripts\engine\utility::add_fx(_id_56AEF90205769A90, _id_56AEF90205769A90);

  addnotetrack_tracepartforefx(_id_84B542BB7490BEA7.animname, notetrack, _id_C7C4553CAAE5C97E, _id_84B542BB7490BEA7.anim_sequence, tagname, _id_94C7BB1299AD3A66, _id_56AEF90205769A90, _id_420B93892AD918C4);
}

note_track_start_fx_on_tag(notetrack, tagname, _id_94C7BB1299AD3A66) {
  _id_84B542BB7490BEA7 = get_datascene();

  if(notetrack != "start" && !animhasnotetrack(_id_84B542BB7490BEA7 scripts\engine\utility::getanim(_id_84B542BB7490BEA7.anim_sequence), notetrack)) {
    return;
  }
  scripts\engine\utility::add_fx(_id_94C7BB1299AD3A66, _id_94C7BB1299AD3A66);
  addnotetrack_startfxontag(_id_84B542BB7490BEA7.animname, notetrack, _id_84B542BB7490BEA7.anim_sequence, _id_94C7BB1299AD3A66, tagname, 1);
}

get_datascene() {
  _id_84B542BB7490BEA7 = level.current_anim_data_scene;
  return _id_84B542BB7490BEA7;
}

addnotetrack_tracepartforefx(animname, notetrack, _id_C7C4553CAAE5C97E, anime, tagname, _id_9ACB3E153A9DC5F6, _id_6C3CB0B533910C44, _id_420B93892AD918C4) {
  scripts\engine\utility::getfx(_id_9ACB3E153A9DC5F6);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["trace_part_for_efx"] = _id_9ACB3E153A9DC5F6;
  array["trace_part_for_efx_water"] = _id_6C3CB0B533910C44;
  array["trace_part_for_efx_cancel"] = _id_C7C4553CAAE5C97E;
  array["trace_part_for_efx_delete_depth"] = _id_420B93892AD918C4;
  array["selftag"] = tagname;
  level.scr_notetrack[animname][anime][notetrack][index] = array;

  if(isDefined(_id_C7C4553CAAE5C97E)) {
    array = [];
    array["trace_part_for_efx_canceling"] = _id_C7C4553CAAE5C97E;
    array["selftag"] = tagname;
    index = add_notetrack_and_get_index(animname, _id_C7C4553CAAE5C97E, anime);
    level.scr_notetrack[animname][anime][_id_C7C4553CAAE5C97E][index] = array;
  }
}

addnotetrack_notify(animname, notetrack, _id_511F299FA4FAC739, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["notify"] = _id_511F299FA4FAC739;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
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

  if(!isDefined(level._id_539E9DC23256F26D))
    level._id_539E9DC23256F26D[0][0] = 0;

  if(!isDefined(level.scr_radio))
    level.scr_radio = [];

  if(!isDefined(level.scr_plrdialogue))
    level.scr_plrdialogue = [];

  if(!isDefined(level.scr_goaltime))
    level.scr_goaltime = [];

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  if(!isDefined(level._id_79C41A27B516111F))
    level._id_79C41A27B516111F = [];

  thread precache_script_models_thread();
  thread precache_weapon_models_thread();
  scripts\engine\utility::create_lock("moreThanThreeHack", 3);
  scripts\engine\utility::create_lock("trace_part_for_efx", 12);
  init_animsounds();
}

precache_script_models_thread() {
  waittillframeend;

  if(!isDefined(level.scr_model)) {
    return;
  }
  models = getarraykeys(level.scr_model);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < models.size; _id_AC0E594AC96AA3A8++) {
    if(isarray(level.scr_model[models[_id_AC0E594AC96AA3A8]])) {
      for(modelindex = 0; modelindex < level.scr_model[models[_id_AC0E594AC96AA3A8]].size; modelindex++)
        precachemodel(level.scr_model[models[_id_AC0E594AC96AA3A8]][modelindex]);

      continue;
    }

    precachemodel(level.scr_model[models[_id_AC0E594AC96AA3A8]]);
  }
}

precache_weapon_models_thread() {
  waittillframeend;

  if(!isDefined(level.scr_weapon)) {
    return;
  }
  weapons = getarraykeys(level.scr_weapon);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < weapons.size; _id_AC0E594AC96AA3A8++) {
    attachments = [];

    if(isDefined(level.scr_weapon[weapons[_id_AC0E594AC96AA3A8]][1]))
      attachments = level.scr_weapon[weapons[_id_AC0E594AC96AA3A8]][1];

    scripts\common\utility::make_weapon_model(level.scr_weapon[weapons[_id_AC0E594AC96AA3A8]][0], attachments, 1, 1);
  }
}

init_animsounds() {
  level.animsounds = [];
  level.animsound_aliases = [];
  _id_1F6148CE8D91365C = getarraykeys(level.scr_notetrack);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F6148CE8D91365C.size; _id_AC0E594AC96AA3A8++)
    init_notetracks_for_animname(_id_1F6148CE8D91365C[_id_AC0E594AC96AA3A8]);

  _id_1F6148CE8D91365C = getarraykeys(level.scr_animsound);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_1F6148CE8D91365C.size; _id_AC0E594AC96AA3A8++)
    init_animsounds_for_animname(_id_1F6148CE8D91365C[_id_AC0E594AC96AA3A8]);
}

init_animsounds_for_animname(animname) {
  _id_2C9B1FD08F99D088 = getarraykeys(level.scr_animsound[animname]);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_2C9B1FD08F99D088.size; _id_AC0E594AC96AA3A8++) {
    anime = _id_2C9B1FD08F99D088[_id_AC0E594AC96AA3A8];
    soundalias = level.scr_animsound[animname][anime];
    level.animsound_aliases[animname][anime]["#" + anime]["soundalias"] = soundalias;
    level.animsound_aliases[animname][anime]["#" + anime]["created_by_animSound"] = 1;
  }
}

init_notetracks_for_animname(animname) {
  foreach(anime, _id_72E7F473BBAB5D91 in level.scr_notetrack[animname]) {
    foreach(notetrack, _id_039B955B6EA2A96E in _id_72E7F473BBAB5D91) {
      foreach(scr_notetrack in _id_039B955B6EA2A96E) {
        soundalias = scr_notetrack["sound"];

        if(!isDefined(soundalias)) {
          continue;
        }
        level.animsound_aliases[animname][anime][notetrack]["soundalias"] = soundalias;

        if(isDefined(scr_notetrack["created_by_animSound"]))
          level.animsound_aliases[animname][anime][notetrack]["created_by_animSound"] = 1;
      }
    }
  }
}

endonremoveanimactive(endonstring, _id_3D308E5CD595225D) {
  self waittill(endonstring);

  foreach(_id_F2811089F0EB595C in _id_3D308E5CD595225D) {
    guy = _id_F2811089F0EB595C["guy"];

    if(!isDefined(guy)) {
      continue;
    }
    guy._animactive--;
    guy._lastanimtime = gettime();
  }
}

anim_deathnotify(guy, anime) {
  self endon(anime);
  guy waittill("death");

  if(isDefined(guy.anim_is_death) && guy.anim_is_death) {
    return;
  }
  self notify(anime);
}

anim_facialendnotify(guy, anime, _id_2A44BD45833FC3EF) {
  self endon(anime);
  time = getanimlength(_id_2A44BD45833FC3EF);
  wait(time);
  self notify(anime);
}

anim_dialogueendnotify(guy, anime) {
  self endon(anime);
  guy waittill("single dialogue");
  self notify(anime);
}

anim_animationendnotify(guy, anime, _id_2AFD32F7CAD8AF86, _id_9E8A16D47A03007A) {
  self endon(anime);
  guy endon("death");
  _id_2AFD32F7CAD8AF86 = _id_2AFD32F7CAD8AF86 - _id_9E8A16D47A03007A;

  if(_id_9E8A16D47A03007A > 0 && _id_2AFD32F7CAD8AF86 > 0) {
    guy scripts\engine\utility::waittill_match_or_timeout("single anim", "end", _id_2AFD32F7CAD8AF86);
    guy stopanimScripted();
  } else
    guy waittillmatch("single anim", "end");

  self notify(anime);
}

anim_weight(animname, anime) {
  _id_BA527C84A3321BF0 = level.scr_anim[animname][anime].size;
  idleanim = randomint(_id_BA527C84A3321BF0);

  if(isDefined(level.scr_anim[animname][anime + "weight"]))
    idleanim = get_weighted_anim(animname, anime, _id_BA527C84A3321BF0);

  return idleanim;
}

get_weighted_anim(animname, anime, _id_BA527C84A3321BF0) {
  idleanim = undefined;

  if(_id_BA527C84A3321BF0 > 1) {
    weights = 0;
    anim_weight = 0;

    for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BA527C84A3321BF0; _id_AC0E594AC96AA3A8++) {
      if(isDefined(level.scr_anim[animname][anime + "weight"])) {
        if(isDefined(level.scr_anim[animname][anime + "weight"][_id_AC0E594AC96AA3A8])) {
          weights++;
          anim_weight = anim_weight + level.scr_anim[animname][anime + "weight"][_id_AC0E594AC96AA3A8];
        }
      }
    }

    if(weights == _id_BA527C84A3321BF0) {
      _id_F1DBBA80D0040D7F = randomfloat(anim_weight);
      anim_weight = 0;

      for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < _id_BA527C84A3321BF0; _id_AC0E594AC96AA3A8++) {
        anim_weight = anim_weight + level.scr_anim[animname][anime + "weight"][_id_AC0E594AC96AA3A8];

        if(_id_F1DBBA80D0040D7F < anim_weight) {
          idleanim = _id_AC0E594AC96AA3A8;
          break;
        }
      }
    }
  }

  return idleanim;
}

#using_animtree("generic_human");

play_addtive_head_anim(guy, animation) {
  guy setanimlimited(%addtive_head_anims, 1.0, 0.2);
  guy setanimlimited(animation, 1.0, 0.2);
  wait(getanimlength(animation));
  guy clearanim(%addtive_head_anims, 0.2);
  guy clearanim(animation, 0.2);
}

get_anim_position(tag) {
  org = undefined;
  angles = undefined;

  if(isDefined(tag)) {
    org = self gettagorigin(tag);
    angles = self gettagangles(tag);
  } else {
    org = self.origin;
    angles = self.angles;

    if(!isDefined(angles))
      angles = (0, 0, 0);
  }

  array = [];
  array["angles"] = angles;
  array["origin"] = org;
  return array;
}

anim_at_self(entity, tag) {
  _id_AD98E6D70679846D = [];
  _id_AD98E6D70679846D["guy"] = self;
  _id_AD98E6D70679846D["entity"] = self;
  return _id_AD98E6D70679846D;
}

anim_at_entity(entity, tag) {
  _id_AD98E6D70679846D = [];
  _id_AD98E6D70679846D["guy"] = self;
  _id_AD98E6D70679846D["entity"] = entity;
  _id_AD98E6D70679846D["tag"] = tag;
  return _id_AD98E6D70679846D;
}

assert_existance_of_anim(anime, animname, animation) {
  if(isagent(self)) {
    return;
  }
  if(!isDefined(animname))
    animname = self.animname;

  _id_869E4EEFB559F49D = 0;

  if(isDefined(level.scr_anim[animname])) {
    _id_869E4EEFB559F49D = 1;

    if(isDefined(level.scr_anim[animname][anime]))
      return;
  }

  _id_A5DB3464F3C53649 = 0;

  if(isDefined(level.scr_face[animname])) {
    _id_A5DB3464F3C53649 = 1;

    if(isDefined(level.scr_face[animname][anime]))
      return;
  }

  _id_130A721269939A47 = 0;

  if(isDefined(level.scr_sound[animname])) {
    _id_130A721269939A47 = 1;

    if(isDefined(level.scr_sound[animname][anime]))
      return;
  }

  if(_id_869E4EEFB559F49D || _id_130A721269939A47 || _id_A5DB3464F3C53649) {
    if(_id_869E4EEFB559F49D) {
      array = getarraykeys(level.scr_anim[animname]);

      foreach(_id_80EF668C09FFB70F in array) {}
    }

    if(_id_130A721269939A47) {
      array = getarraykeys(level.scr_sound[animname]);

      foreach(_id_80EF668C09FFB70F in array) {}
    }

    if(_id_A5DB3464F3C53649) {
      array = getarraykeys(level.scr_face[animname]);

      foreach(_id_80EF668C09FFB70F in array) {}
    }

    return;
  }

  keys = getarraykeys(level.scr_anim);
  keys = scripts\engine\utility::array_combine(keys, getarraykeys(level.scr_sound));

  foreach(key in keys) {}
}

anim_single_failsafeonguy(owner, anime) {}

anim_single_failsafe(guys, anime) {
  foreach(guy in guys)
  guy thread anim_single_failsafeonguy(self, anime);
}

anim_get_goal_time(animname, anime) {
  if(isDefined(level.scr_goaltime[animname]) && isDefined(level.scr_goaltime[animname][anime]))
    return level.scr_goaltime[animname][anime];
  else
    return 0.5;
}

_id_89B3EABD606FCDA3(animation) {
  if(scripts\common\utility::issp())
    return 0.5;

  return 0;
}

_id_F1E7EE8DDEECE062(anime) {
  if(scripts\common\utility::issp() && isDefined(level._id_DF7711B84D224BCF) && istrue(level._id_DF7711B84D224BCF[anime]))
    return 1;

  return 0;
}

_id_1EBA925251530689(guys, anime) {
  if(_id_F1E7EE8DDEECE062(anime) && guys.size > 1) {
    foreach(guy in guys) {
      if(!isDefined(guy.animname) || !guy _id_9C6A9B923786F602(guy.animname) && !guy _id_84A46F10A88351CD(guy.animname)) {
        guys = scripts\engine\utility::array_remove(guys, guy);
        guys = scripts\engine\utility::array_add(guys, guy);
      }
    }
  }

  return guys;
}

_id_56BD620E57A834AF(anime, animname, animation) {
  _id_4F51EF0BD97A4707 = anime + "_entrance";
  level.scr_anim[animname][_id_4F51EF0BD97A4707] = animation;
  return _id_4F51EF0BD97A4707;
}

_id_C099F6FD9C19F5A6(anime, org, angles, animname) {
  if(_id_9C6A9B923786F602(animname))
    return _id_096B3D74019CD30A(anime, org, angles, animname);
  else if(_id_84A46F10A88351CD(animname))
    return _id_1ED6444C29DA9045(anime, org, angles, animname);

  if(!isDefined(level._id_AC0205CB091A126E))
    level._id_AC0205CB091A126E = 0;

  if(isarray(level.scr_anim[animname][anime]))
    return level.scr_anim[animname][anime][level._id_AC0205CB091A126E];
  else
    return level.scr_anim[animname][anime];
}

_id_096B3D74019CD30A(anime, org, angles, animname) {
  if(isDefined(level._id_AC0205CB091A126E) && istrue(level._id_99364109F9F9B3F4) && level._id_99364109F9F9B3F4 == gettime())
    return level.scr_anim[animname][anime][level._id_AC0205CB091A126E];

  _id_48C468C35E48FD78 = 0;
  _id_EB785C749968FCD1 = undefined;
  level._id_AC0205CB091A126E = undefined;

  foreach(_id_AC0E594AC96AA3A8, animation in level.scr_anim[animname][anime]) {
    _id_B48C995A0A557FF1 = getstartorigin(org, angles, animation);

    if(!isDefined(_id_EB785C749968FCD1)) {
      _id_EB785C749968FCD1 = distancesquared(_id_B48C995A0A557FF1, level.player.origin);
      continue;
    }

    dist = distancesquared(level.player.origin, _id_B48C995A0A557FF1);

    if(dist < _id_EB785C749968FCD1) {
      _id_48C468C35E48FD78 = _id_AC0E594AC96AA3A8;
      _id_EB785C749968FCD1 = dist;
    }
  }

  animation = level.scr_anim[animname][anime][_id_48C468C35E48FD78];
  level._id_99364109F9F9B3F4 = gettime();
  level._id_AC0205CB091A126E = _id_48C468C35E48FD78;
  return animation;
}

_id_1ED6444C29DA9045(anime, org, angles, animname) {
  level._id_AC0205CB091A126E = undefined;
  animation = level.scr_anim[animname][anime][0];
  level._id_AC0205CB091A126E = 0;
  return animation;
}

_id_84A46F10A88351CD(animname) {
  if(isDefined(level.scr_animtree[animname]) && level.scr_animtree[animname] == #animtree)
    return 1;

  return 0;
}

_id_9C6A9B923786F602(animname) {
  return [[anim.callbacks["CheckPlayerAnimtree"]]](animname);
}

_id_2C88F6E05AF61090(animation) {
  if(!animhasnotetrack(animation, "blend_into"))
    return 0;

  return scripts\engine\utility::get_notetrack_time(animation, "blend_into");
}

_id_F92DE130E8613662(animation) {
  if(!animhasnotetrack(animation, "blend_out"))
    return undefined;

  return scripts\engine\utility::get_notetrack_time(animation, "blend_out");
}

_id_070B77E26541E095(animation) {
  speed = 128;

  if(animhasnotetrack(animation, "blend_speed = walk"))
    speed = 128;
  else if(animhasnotetrack(animation, "blend_speed = run"))
    speed = 145;

  return speed * 0.7;
}

_id_48AF09F152896047(animation) {
  _id_05730C0AA523383E = [];

  if(animhasnotetrack(animation, "start_stance = stand"))
    _id_05730C0AA523383E = scripts\engine\utility::array_add(_id_05730C0AA523383E, "stand");
  else if(animhasnotetrack(animation, "start_stance = crouch"))
    _id_05730C0AA523383E = scripts\engine\utility::array_add(_id_05730C0AA523383E, "crouch");
  else if(animhasnotetrack(animation, "start_stance = prone"))
    _id_05730C0AA523383E = scripts\engine\utility::array_add(_id_05730C0AA523383E, "prone");
  else
    _id_05730C0AA523383E = scripts\engine\utility::array_add(_id_05730C0AA523383E, "none");

  if(animhasnotetrack(animation, "end_stance = stand"))
    _id_05730C0AA523383E = scripts\engine\utility::array_add(_id_05730C0AA523383E, "stand");
  else if(animhasnotetrack(animation, "end_stance = crouch"))
    _id_05730C0AA523383E = scripts\engine\utility::array_add(_id_05730C0AA523383E, "crouch");
  else if(animhasnotetrack(animation, "end_stance = prone"))
    _id_05730C0AA523383E = scripts\engine\utility::array_add(_id_05730C0AA523383E, "prone");
  else
    _id_05730C0AA523383E = scripts\engine\utility::array_add(_id_05730C0AA523383E, "none");

  return _id_05730C0AA523383E;
}

_id_D0FAFBACBA98A40F(_id_1925D24D0AE333E6, _id_BCF9684C0529009A, _id_039DCD05ABB67207, _id_594E1161FB38DF07, _id_EC165A067AF34F8F, _id_8831FC7320076829, _id_E123FEE5AE019570) {
  _id_EC165A067AF34F8F = scripts\engine\utility::ter_op(isDefined(_id_EC165A067AF34F8F), _id_EC165A067AF34F8F, 1);
  _id_8831FC7320076829 = scripts\engine\utility::ter_op(isDefined(_id_8831FC7320076829), _id_8831FC7320076829, 0);
  _id_E123FEE5AE019570 = scripts\engine\utility::ter_op(isDefined(_id_E123FEE5AE019570), _id_E123FEE5AE019570, 0);

  if(istrue(_id_EC165A067AF34F8F))
    _id_D3910721ABE5F9C5 = level.player getgestureanimlength("proto_vm_gesture_gun_drop");
  else if(istrue(_id_8831FC7320076829))
    _id_D3910721ABE5F9C5 = 0.5;
  else
    _id_D3910721ABE5F9C5 = 0;

  _id_6A78CF7A8410BBDB = 0;

  if(istrue(_id_E123FEE5AE019570)) {
    _id_6A78CF7A8410BBDB = 1;
    _id_D3910721ABE5F9C5 = 0;
  } else if(level.player getdemeanorviewmodel() == "relaxed") {
    _id_6A78CF7A8410BBDB = 1;
    _id_D3910721ABE5F9C5 = 0.2;
  }

  _id_60163A10465B892C = distance2d(_id_1925D24D0AE333E6, _id_BCF9684C0529009A) / _id_039DCD05ABB67207;
  _id_A46CDF78D1CD46DC = _id_594E1161FB38DF07 + _id_D3910721ABE5F9C5;

  if(_id_594E1161FB38DF07 > 0) {
    frac = _id_60163A10465B892C / _id_A46CDF78D1CD46DC;

    if(frac < 1.4 && frac > 0.4)
      _id_D180B535A33B044D = _id_A46CDF78D1CD46DC;
    else if(_id_60163A10465B892C < _id_594E1161FB38DF07)
      _id_D180B535A33B044D = scripts\engine\utility::ter_op(_id_594E1161FB38DF07 < 1, _id_594E1161FB38DF07 + _id_D3910721ABE5F9C5, 1 + _id_D3910721ABE5F9C5);
    else if(_id_60163A10465B892C > 0.5)
      _id_D180B535A33B044D = _id_60163A10465B892C;
    else
      _id_D180B535A33B044D = 0.5;
  } else
    _id_D180B535A33B044D = 0.5;

  if(_id_D180B535A33B044D > _id_A46CDF78D1CD46DC)
    _id_D3910721ABE5F9C5 = _id_D180B535A33B044D - _id_594E1161FB38DF07;

  level._id_64FEE87637DE3B30["weaponDropQuick"] = _id_6A78CF7A8410BBDB;
  level._id_64FEE87637DE3B30["weaponDropTime"] = _id_D3910721ABE5F9C5;
  return _id_D180B535A33B044D;
}

_id_309BB9DE5DB13227(_id_1925D24D0AE333E6, _id_BCF9684C0529009A, _id_039DCD05ABB67207, _id_594E1161FB38DF07, _id_EC165A067AF34F8F, _id_8831FC7320076829, _id_E123FEE5AE019570) {
  _id_EC165A067AF34F8F = scripts\engine\utility::ter_op(isDefined(_id_EC165A067AF34F8F), _id_EC165A067AF34F8F, 1);
  _id_8831FC7320076829 = scripts\engine\utility::ter_op(isDefined(_id_8831FC7320076829), _id_8831FC7320076829, 0);
  _id_E123FEE5AE019570 = scripts\engine\utility::ter_op(isDefined(_id_E123FEE5AE019570), _id_E123FEE5AE019570, 0);

  if(!_id_8831FC7320076829) {
    _id_360C2C32E76C9434 = 0;
    _id_BE4234AFA13BA43A = 0;
  } else {
    _id_360C2C32E76C9434 = 0.2;

    if(_id_EC165A067AF34F8F)
      _id_BE4234AFA13BA43A = level.player getgestureanimlength("proto_vm_gesture_gun_drop");
    else
      _id_BE4234AFA13BA43A = 0.5;
  }

  _id_D180B535A33B044D = distance2d(_id_1925D24D0AE333E6, _id_BCF9684C0529009A) / _id_039DCD05ABB67207;
  _id_A46CDF78D1CD46DC = _id_594E1161FB38DF07 + _id_BE4234AFA13BA43A;

  if(_id_A46CDF78D1CD46DC > 0) {
    frac = _id_D180B535A33B044D / _id_A46CDF78D1CD46DC;

    if(frac < 1.4 && frac > 0.4)
      _id_D180B535A33B044D = _id_A46CDF78D1CD46DC;
    else if(_id_D180B535A33B044D < _id_594E1161FB38DF07)
      _id_D180B535A33B044D = scripts\engine\utility::ter_op(_id_594E1161FB38DF07 <= 1, _id_594E1161FB38DF07, 1);
  }

  if(istrue(_id_EC165A067AF34F8F) && istrue(_id_8831FC7320076829))
    _id_D180B535A33B044D = scripts\engine\utility::ter_op(_id_D180B535A33B044D < _id_BE4234AFA13BA43A, _id_BE4234AFA13BA43A, _id_D180B535A33B044D);
  else if(!istrue(_id_8831FC7320076829))
    _id_D180B535A33B044D = scripts\engine\utility::ter_op(_id_D180B535A33B044D < 0.5, 0.5, _id_D180B535A33B044D);
  else
    _id_D180B535A33B044D = scripts\engine\utility::ter_op(_id_D180B535A33B044D < _id_360C2C32E76C9434, _id_360C2C32E76C9434, _id_D180B535A33B044D);

  _id_6A78CF7A8410BBDB = 0;
  _id_D3910721ABE5F9C5 = _id_BE4234AFA13BA43A;

  if(_id_D180B535A33B044D < _id_BE4234AFA13BA43A || level.player getdemeanorviewmodel() == "relaxed") {
    _id_6A78CF7A8410BBDB = 1;
    _id_D3910721ABE5F9C5 = _id_360C2C32E76C9434;
  } else if(_id_D180B535A33B044D > _id_A46CDF78D1CD46DC)
    _id_D3910721ABE5F9C5 = _id_D180B535A33B044D - _id_594E1161FB38DF07;

  if(istrue(_id_E123FEE5AE019570)) {
    _id_6A78CF7A8410BBDB = 1;
    _id_D3910721ABE5F9C5 = 0;
  }

  level._id_64FEE87637DE3B30["weaponDropQuick"] = _id_6A78CF7A8410BBDB;
  level._id_64FEE87637DE3B30["weaponDropTime"] = _id_D3910721ABE5F9C5;
  return _id_D180B535A33B044D;
}

_id_0DBA8EC1939D3F1A(anime, animname, _id_EC165A067AF34F8F, _id_8831FC7320076829, _id_E123FEE5AE019570) {
  if(_id_F1E7EE8DDEECE062(anime))
    animation = _id_C099F6FD9C19F5A6(anime, self.origin, self.angles, animname);
  else
    animation = level.scr_anim[animname][anime];

  _id_C458EDAC96D58B16 = getstartorigin(self.origin, self.angles, animation);
  level._id_64FEE87637DE3B30 = [];
  _id_594E1161FB38DF07 = _id_2C88F6E05AF61090(animation);
  _id_24FA1B56C39C25A9 = _id_F92DE130E8613662(animation);
  _id_039DCD05ABB67207 = _id_070B77E26541E095(animation);
  _id_D180B535A33B044D = _id_D0FAFBACBA98A40F(level.player.origin, _id_C458EDAC96D58B16, _id_039DCD05ABB67207, _id_594E1161FB38DF07, _id_EC165A067AF34F8F, _id_8831FC7320076829, _id_E123FEE5AE019570);
  _id_05730C0AA523383E = _id_48AF09F152896047(animation);
  level._id_64FEE87637DE3B30["blendIntoTime"] = _id_594E1161FB38DF07;
  level._id_64FEE87637DE3B30["blendOutTime"] = _id_24FA1B56C39C25A9;
  level._id_64FEE87637DE3B30["blendSpeed"] = _id_039DCD05ABB67207;
  level._id_64FEE87637DE3B30["blendTime"] = _id_D180B535A33B044D;
  level._id_64FEE87637DE3B30["stances"] = _id_05730C0AA523383E;
}

_id_5CFFE82F5E70231B(_id_E3108E412AFB3811) {
  if(istrue(_id_E3108E412AFB3811))
    self._id_C7B88C656F64AD0D = 1;
  else
    self._id_C7B88C656F64AD0D = undefined;
}

_id_6BC36C81FC28A22E() {
  if(istrue(self._id_C7B88C656F64AD0D))
    return 1;

  return 0;
}

_id_01CB661B457551A3(_id_E3108E412AFB3811, _id_B271BFFB6A81ED13, _id_D180B535A33B044D) {
  if(istrue(_id_E3108E412AFB3811)) {
    self._id_A986B9D4A1BE703B = 1;
    self._id_F1A075B476CA91F1 = _id_B271BFFB6A81ED13 getvelocity();

    if(isDefined(_id_D180B535A33B044D))
      self._id_37B96012304143D7 = _id_D180B535A33B044D;
    else
      self._id_37B96012304143D7 = 0.2;
  } else {
    self._id_A986B9D4A1BE703B = undefined;
    self._id_F1A075B476CA91F1 = undefined;
    self._id_37B96012304143D7 = undefined;
  }
}

_id_E42B762E098C8F9E() {
  if(istrue(self._id_A986B9D4A1BE703B) && isDefined(self._id_F1A075B476CA91F1) && isDefined(self._id_37B96012304143D7))
    return 1;

  return 0;
}

_id_52351C3338DA63F4(_id_0CD1BD02E8922204, animindex) {
  animlength = 0;

  if(isDefined(level._id_539E9DC23256F26D) && isDefined(level._id_539E9DC23256F26D[_id_0CD1BD02E8922204]) && isDefined(level._id_539E9DC23256F26D[_id_0CD1BD02E8922204][animindex]))
    animlength = level._id_539E9DC23256F26D[_id_0CD1BD02E8922204][animindex];
  else if(isDefined(level.scr_anim) && isDefined(level.scr_anim[_id_0CD1BD02E8922204]) && isDefined(level.scr_anim[_id_0CD1BD02E8922204][animindex]))
    animlength = getanimlength(level.scr_anim[_id_0CD1BD02E8922204][animindex]);
  else {}

  return animlength;
}