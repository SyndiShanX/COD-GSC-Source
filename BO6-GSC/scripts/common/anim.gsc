/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\common\anim.gsc
**************************************/

#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\visibility_mode;
#using scripts\engine\utility;
#namespace animation;

function anim_first_frame(guys, anime, tag) {
  assert(isarray(guys), "<dev string:x24>");
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];
  guys = function_c5c322095ca966be(guys, anime);
  utility::array_levelthread(guys, &anim_first_frame_on_guy, anime, org, angles);
}

function anim_generic_first_frame(guy, anime, tag) {
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];
  thread anim_first_frame_on_guy(guy, anime, org, angles, "generic");
}

function anim_generic(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_single(guys, anime, tag, 0, "generic");
}

function anim_generic_run(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_single(guys, anime, tag, 0.25, "generic");
}

function anim_single_solo_run(guy, anime, tag) {
  self endon("death");
  newguy[0] = guy;
  anim_single(newguy, anime, tag, 0.25);
}

function anim_first_frame_solo(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_first_frame(guys, anime, tag);
}

function anim_first_frame_on_guy(guy, anime, org, angles, animname_override) {
  guy.first_frame_time = gettime();
  animname = undefined;

  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = guy.animname;
  }

  isloop = 0;

  if(function_b8e0e318104693fb(anime)) {
    animation = guy function_c662ac26794ce12f(anime, org, angles, animname);
  } else if(isarray(level.scr_anim[animname][anime])) {
    animation = level.scr_anim[animname][anime][0];
    isloop = 1;
  } else {
    animation = level.scr_anim[animname][anime];
  }

  guy assert_existance_of_anim(anime, animname, animation);

  guy set_start_pos(anime, org, angles, animname, isloop, animation);

  if(isai(guy)) {
    assert(isDefined(anim.callbacks["<dev string:x41>"]), "<dev string:x55>");
    guy[[anim.callbacks["AIAnimFirstFrame"]]](animation, animname);
    return;
  }

  guy stopanimScripted();
  guy setanimknob(animation, 1, 0, 0);

  if(!utility::issp()) {
    if(isDefined(level.scr_anim[animname]) && !isPlayer(guy) && guy.classname != "script_vehicle" && !guy vehicle::is_vehicle() && isDefined(level.scr_anim[animname][anime])) {
      if(isarray(level.scr_anim[animname][anime])) {
        guy builtin[[level.func["scriptModelPlayAnim"]]](level.scr_anim[animname][anime][0], undefined, 0, 0, "none");
        return;
      }

      guy builtin[[level.func["scriptModelPlayAnim"]]](level.scr_anim[animname][anime], undefined, 0, 0, "none");
    }
  }
}

function set_start_pos(anime, org, angles, animname_override, anim_array, animation) {
  assert(isDefined(org) && isDefined(angles), "<dev string:xb2>");
  animname = undefined;

  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = self.animname;
  }

  if(!isDefined(animation)) {
    if(function_b8e0e318104693fb(anime)) {
      animation = function_c662ac26794ce12f(anime, org, angles, animname);
    } else if(anim_array) {
      animation = level.scr_anim[animname][anime][0];
    } else {
      animation = level.scr_anim[animname][anime];
    }
  }

  neworg = getstartorigin(org, angles, animation);
  newangles = getstartangles(org, angles, animation);
  self[[anim.callbacks["TeleportEnt"]]](neworg, newangles);
}

function anim_start_pos(guyarray, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  utility::array_thread(guyarray, &set_start_pos, anime, org, angles);
}

function anim_start_pos_solo(guy, anime, tag) {
  newguy[0] = guy;
  anim_start_pos(newguy, anime, tag);
}

function anim_last_frame_solo(guy, anime, tag) {
  guys = [];
  guys[0] = guy;
  anim_first_frame(guys, anime, tag);
  anim_set_time(guys, anime, 1);
  animation = guy utility::getanim(anime);
  translation = getmovedelta(animation);
  rotation = getangledelta3d(animation);
  rotatedtranslation = rotatevector(translation, guy.angles);
  origin = guy.origin + rotatedtranslation;
  angles = combineangles(guy.angles, rotation);
  guy[[anim.callbacks["TeleportEnt"]]](origin, angles);
}

function anim_single_solo(guy, anime, tag, anim_end_time, animname_override) {
  self endon("death");
  newguy[0] = guy;

  if(!isDefined(anim_end_time)) {
    anim_end_time = 0;
  }

  anim_single(newguy, anime, tag, anim_end_time, animname_override);
}

function anim_single_internal(guys, anime, tag, anim_end_time, animname_override) {
  thread anim_single_failsafe(guys, anime);

  foreach(guy in guys) {
    if(!isDefined(guy)) {
      continue;
    }

    if(!isDefined(guy._animactive)) {
      guy._animactive = 0;
    }

    guy._animactive++;
  }

  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  scriptedanimationindex = undefined;
  scriptedanimationtime = 999999;
  var_162d21f9b7b6a2f1 = undefined;
  var_167d3eac42022adb = undefined;
  scriptedfaceanim = undefined;
  scriptedheadanim = undefined;
  anim_string = "single anim";
  hasxcam = 0;

  if(isDefined(level.scr_xcam) && level.scr_xcam.size != 0 && isDefined(level.scr_xcam[anime])) {
    hasxcam = 1;
  }

  guys = function_c5c322095ca966be(guys, anime);

  foreach(i, guy in guys) {
    if(!isDefined(guy)) {
      continue;
    }

    dofacialanim = 0;
    doheadanim = 0;
    dodialogue = 0;
    doanimation = 0;
    dotext = 0;
    dialogue = undefined;
    facialanim = undefined;
    headanim = undefined;
    animname = undefined;

    if(isDefined(animname_override)) {
      animname = animname_override;
    } else {
      animname = guy.animname;
    }

    guy assert_existance_of_anim(anime, animname);

    if(!isDefined(animname)) {
      continue;
    }

    if(isDefined(level.scr_sound[animname]) && isDefined(level.scr_sound[animname][anime])) {
      dodialogue = 1;
      dialogue = level.scr_sound[animname][anime];
    }

    if(isDefined(level.scr_face[animname]) && isDefined(level.scr_face[animname][anime])) {
      dofacialanim = 1;
      facialanim = level.scr_face[animname][anime];
      scriptedfaceanim = facialanim;

      if(dodialogue) {
        if(animhasnotetrack(facialanim, "vo_" + dialogue)) {
          dodialogue = 0;
          dialogue = undefined;
        }
      }
    }

    if(isDefined(level.scr_head[animname]) && isDefined(level.scr_head[animname][anime])) {
      doheadanim = 1;
      headanim = level.scr_head[animname][anime];
      scriptedheadanim = headanim;
    }

    if(isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][anime]) && self[[anim.callbacks["ShouldDoAnim"]]]()) {
      doanimation = 1;
    }

    if(isDefined(level.scr_animsound[animname]) && isDefined(level.scr_animsound[animname][anime])) {
      guy playSound(level.scr_animsound[animname][anime]);
    }

    if(isDefined(level.scr_text[animname]) && isDefined(level.scr_text[animname][anime])) {
      dotext = 1;
    }

    if(doanimation) {
      scripted_node_ent = undefined;

      if(function_6ee84ba29eeda4f()) {
        scripted_node_ent = self;
      }

      assert(isDefined(guy.model) && guy.model != "<dev string:xd8>", "<dev string:xdc>" + debug::function_4496bef4cfc0d07(guy) + "<dev string:x100>" + animname + "<dev string:x114>" + anime + "<dev string:x131>");
      guy visibility_mode::function_db9ed9dc5c19305b();
      animtime = guy[[anim.callbacks["DoAnimation"]]](org, angles, animname, anime, anim_string, undefined, scripted_node_ent);

      if(animtime < scriptedanimationtime) {
        scriptedanimationtime = animtime;
        scriptedanimationindex = i;
      }
    }

    if(dofacialanim || dodialogue) {
      if(guy[[anim.callbacks["DoFacialAnim"]]](dofacialanim, dodialogue, doanimation, anime, animname, dialogue, 0)) {
        var_167d3eac42022adb = i;
      }

      var_162d21f9b7b6a2f1 = i;
    }

    if(isai(guy)) {
      assert(!(doanimation && guy utility::doinglongdeath()), "<dev string:x14b>");
    }

    assert(doanimation || dofacialanim || dodialogue || dotext, "<dev string:x199>" + anime + "<dev string:x1b4>" + animname + "<dev string:x1ce>");

    if(doheadanim) {
      guy thread play_addtive_head_anim(guy, scriptedheadanim);
    }

    if(dotext && !dodialogue) {
      guy thread[[anim.callbacks["<dev string:x1f7>"]]](level.scr_text[animname][anime]);
    }

    if(!utility::issp()) {
      if(isDefined(level.scr_anim[animname]) && !isPlayer(guy) && !isagent(guy) && !(guy vehicle::is_vehicle() || isDefined(guy.isinfilelevator)) && isDefined(level.scr_anim[animname][anime])) {
        blendtype = function_cd8b99431e720772(animname, anime);

        if(isDefined(level.var_b8373a77bd36aa7d)) {
          blendtype = [[level.var_b8373a77bd36aa7d]](animname);
        }

        guy utility::self_func("scriptModelPlayAnim", level.scr_anim[animname][anime], undefined, undefined, undefined, blendtype);
      }
    }

    if(guy function_1d2dd6f111ac6b37()) {
      guy animscripted_blendin(guy.animscripted_blendin_time, guy.animscripted_blendin_vel, "tag_camera");
    }
  }

  if(hasxcam) {
    [[anim.callbacks["playXcam"]]](level.scr_xcam[anime], org, angles);
  } else if(isDefined(scriptedanimationindex)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[scriptedanimationindex], anime);
    ent thread anim_animationendnotify(guys[scriptedanimationindex], anime, scriptedanimationtime, anim_end_time);
    ent waittill(anime);
  } else if(isDefined(var_167d3eac42022adb)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[var_167d3eac42022adb], anime);
    ent thread anim_facialendnotify(guys[var_167d3eac42022adb], anime, scriptedfaceanim);
    ent waittill(anime);
  } else if(isDefined(var_162d21f9b7b6a2f1)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[var_162d21f9b7b6a2f1], anime);
    ent thread anim_dialogueendnotify(guys[var_162d21f9b7b6a2f1], anime);
    ent waittill(anime);
  }

  foreach(guy in guys) {
    if(!(isDefined(guy) && isDefined(guy._animactive))) {
      continue;
    }

    visibility_mode::function_4e6c654251b854e0(guy);
    guy._animactive--;
    guy._lastanimtime = gettime();
    assert(guy._animactive >= 0);
  }

  self notify(anime);
}

function function_cd8b99431e720772(animname, anime) {
  blendtype = undefined;

  if(isDefined(level.scr_goaltime[animname]) && isDefined(level.scr_goaltime[animname][anime])) {
    if(level.scr_goaltime[animname][anime] == 0) {
      blendtype = "none";
    }
  }

  return blendtype;
}

function anim_single(guys, anime, tag, anim_end_time, animname_override) {
  assert(isarray(guys), "<dev string:x204>");

  if(!isDefined(anim_end_time)) {
    anim_end_time = 0;
  }

  anim_single_internal(guys, anime, tag, anim_end_time, animname_override);
}

function anim_loop_solo(guy, anime, ender, tag, var_70057cba8262ab87, animname_override) {
  assert(!isarray(guy), "<dev string:x232>");
  self endon("death");
  guy endon("death");
  newguy[0] = guy;
  anim_loop(newguy, anime, ender, tag, var_70057cba8262ab87, animname_override);
}

function anim_loop_solo_with_nags(guy, anime, ender, tag) {
  assert(!isarray(guy), "<dev string:x266>");
  self endon("death");
  guy endon("death");
  assert(isDefined(level.scr_anim[guy.animname][anime + "<dev string:x2a4>"]), "<dev string:x2ad>" + anime);
  newguy[0] = guy;
  anim_loop(newguy, anime, ender, tag);
}

function anim_generic_loop(guy, anime, ender, tag) {
  assert(!isarray(guy), "<dev string:x2d9>");
  packet = [];
  packet["guy"] = guy;
  packet["entity"] = self;
  packet["tag"] = tag;
  guypackets[0] = packet;
  anim_loop_packet(guypackets, anime, ender, "generic");
}

function anim_loop(guys, anime, ender, tag, var_70057cba8262ab87, animname_override) {
  assert(isarray(guys), "<dev string:x310>");
  guypackets = [];

  foreach(guy in guys) {
    packet = [];
    packet["guy"] = guy;
    packet["entity"] = self;
    packet["tag"] = tag;
    packet["origin_offset"] = var_70057cba8262ab87;
    guypackets[guypackets.size] = packet;
  }

  anim_loop_packet(guypackets, anime, ender, animname_override);
}

function anim_loop_packet_solo(var_fff29eb52d8db12d, anime, ender, animname_override) {
  looppacket = [];
  looppacket[0] = var_fff29eb52d8db12d;
  anim_loop_packet(looppacket, anime, ender, animname_override);
}

function pick_nag_anim(datastruct) {
  naganim = undefined;

  if(datastruct.nag_anims.size == 1) {
    naganim = 0;
  } else if(datastruct.currentnagindex == datastruct.nag_anims.size - 1) {
    naganim = 0;
  } else {
    naganim = datastruct.currentnagindex + 1;
  }

  assert(isDefined(naganim));
  datastruct.currentnagindex = naganim;
  datastruct.last_nag_time = gettime();
  return datastruct.currentnagindex;
}

function anim_loop_packet(guypackets, anime, ender, animname_override) {
  assert(!isDefined(level.scr_xcam[anime]), "<dev string:x33c>");

  foreach(guypacket in guypackets) {
    guy = guypacket["guy"];

    if(!isDefined(guy)) {
      continue;
    }

    if(!isDefined(guy._animactive)) {
      guy._animactive = 0;
    }

    guy endon("death");
    guy._animactive++;
  }

  baseguy = guypackets[0]["guy"];

  if(!isDefined(baseguy.loops)) {
    baseguy.loops = 0;
    baseguy.loopanims = [];
  }

  thread printloops(baseguy, anime);

  if(!isDefined(ender)) {
    ender = "stop_loop";
  }

  thread endonremoveanimactive(ender, guypackets);
  self endon(ender);

  thread function_22388de1d368ad59(baseguy, ender, anime);

  anim_string = "looping anim";
  base_anime = anime;
  base_animname = undefined;

  if(isDefined(animname_override)) {
    base_animname = animname_override;
  } else {
    base_animname = baseguy.animname;
  }

  idleanim = 0;
  lastidleanim = 0;
  naginterval = 0;
  hasnags = isDefined(level.scr_anim[base_animname][anime + "_nags"]);

  if(hasnags && utility::issp()) {
    ai = 0;

    foreach(i, guypacket in guypackets) {
      if(isai(guypacket["guy"])) {
        ai++;
      }
    }

    assert(ai == 1, "<dev string:x36e>");

    if(isDefined(level.scr_anim[base_animname][anime + "_nags_timer"])) {
      naginterval = level.scr_anim[base_animname][anime + "_nags_timer"];
    } else {
      naginterval = 15;
    }
  }

  donag = 0;
  nagdata = undefined;
  abandonloop = 0;

  if(hasnags) {
    setdvarifuninitialized(@ "scr_debug_nags", 0);
    nagdata = spawnStruct();
    nagdata.last_nag_time = gettime();
    nagdata.nag_anims = level.scr_anim[base_animname][anime + "_nags"];
    nagdata.currentnagindex = 0;
    childthread nag_timer(naginterval, baseguy);
  }

  while(true) {
    if(!donag && !isagent(baseguy)) {
      anime = base_anime;

      for(idleanim = anim_weight(base_animname, anime); idleanim == lastidleanim && idleanim != 0; idleanim = anim_weight(base_animname, anime)) {}
    } else if(!isagent(baseguy)) {
      idleanim = pick_nag_anim(nagdata);
      anime = base_anime + "_nags";
      childthread nag_timer(naginterval, baseguy);
      donag = 0;
    } else {
      idleanim = anime;
    }

    lastidleanim = idleanim;
    scriptedanimationindex = undefined;
    scriptedanimationtime = 999999;
    var_162d21f9b7b6a2f1 = undefined;
    guy = undefined;

    foreach(i, guypacket in guypackets) {
      entity = guypacket["entity"];
      guy = guypacket["guy"];
      pos = entity get_anim_position(guypacket["tag"]);
      org = pos["origin"];
      angles = pos["angles"];

      if(isDefined(guypacket["origin_offset"])) {
        offset = guypacket["origin_offset"];
        forward = anglesToForward(angles);
        right = anglestoright(angles);
        up = anglestoup(angles);
        org += forward * offset[0];
        org += right * offset[1];
        org += up * offset[2];
      }

      if(isDefined(guy.remove_from_animloop)) {
        guy.remove_from_animloop = undefined;
        guypackets[i] = undefined;
        continue;
      }

      dofacialanim = 0;
      dodialogue = 0;
      doanimation = 0;

      dotext = 0;

      facialanim = undefined;
      dialogue = undefined;
      animname = undefined;

      if(isDefined(animname_override)) {
        animname = animname_override;
      } else {
        animname = guy.animname;
      }

      if(isDefined(level.scr_face[animname]) && isDefined(level.scr_face[animname][anime]) && isDefined(level.scr_face[animname][anime][idleanim])) {
        dofacialanim = 1;
        facialanim = level.scr_face[animname][anime][idleanim];
      }

      if(isDefined(level.scr_sound[animname]) && isDefined(level.scr_sound[animname][anime]) && isDefined(level.scr_sound[animname][anime][idleanim])) {
        dodialogue = 1;
        dialogue = level.scr_sound[animname][anime][idleanim];
      }

      if(isDefined(level.scr_animsound[animname]) && isDefined(level.scr_animsound[animname][idleanim + anime])) {
        guy playSound(level.scr_animsound[animname][idleanim + anime]);
      }

      if(isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][anime]) && self[[anim.callbacks["ShouldDoAnim"]]]()) {
        doanimation = 1;
      } else if(isagent(guy) && self[[anim.callbacks["ShouldDoAnim"]]]()) {
        doanimation = 1;
      }

      if(isDefined(level.scr_text[animname]) && isDefined(level.scr_text[animname][anime])) {
        dotext = 1;
      }

      if(!dofacialanim && !dodialogue && !doanimation && !dotext) {
        assertmsg("<dev string:x3a7>" + guy getentitynumber() + "<dev string:x3b6>" + anime + "<dev string:x3d7>");
        abandonloop = 1;
        break;
      }

      if(doanimation) {
        guy visibility_mode::function_db9ed9dc5c19305b();
        animtime = guy[[anim.callbacks["DoAnimation"]]](org, angles, animname, anime, anim_string, idleanim, undefined);

        if(animtime < scriptedanimationtime) {
          scriptedanimationtime = animtime;
          scriptedanimationindex = i;
        }
      }

      if(!utility::issp()) {
        if(isDefined(level.scr_anim[animname][anime]) && isDefined(level.scr_anim[animname]) && !isPlayer(guy) && !isagent(guy) && !guy vehicle::is_vehicle() && !isDefined(guy vehicle::get_ref()) && isDefined(level.scr_anim[animname][anime][idleanim])) {
          guy utility::self_func("scriptModelPlayAnim", level.scr_anim[animname][anime][idleanim], undefined, undefined, undefined, function_cd8b99431e720772(animname, anime));
        }
      }

      if(dofacialanim || dodialogue) {
        guy[[anim.callbacks["DoFacialAnim"]]](dofacialanim, dodialogue, doanimation, anime, animname, dialogue, 1);
        var_162d21f9b7b6a2f1 = i;
      }

      if(dotext && !dodialogue) {
        guy thread[[anim.callbacks["<dev string:x1f7>"]]](level.scr_text[animname][anime]);
      }
    }

    if(!isDefined(guy)) {
      break;
    }

    if(isDefined(scriptedanimationindex)) {
      finishedanim = waittill_animend(guypackets[scriptedanimationindex]["guy"], anim_string, hasnags);

      if(!isDefined(finishedanim) && hasnags) {
        donag = 1;

        if(isDefined(anim.callbacks["StopAnimscripted"])) {
          guy[[anim.callbacks["StopAnimscripted"]]]();
        }
      }
    } else if(isDefined(var_162d21f9b7b6a2f1)) {
      guypackets[var_162d21f9b7b6a2f1]["guy"] waittill(anim_string);
    }

    if(abandonloop) {
      break;
    }
  }
}

function waittill_animend(guy, animstring, hasnags) {
  if(hasnags) {
    self endon("do_nag");
  }

  guy waittillmatch(animstring, "end");
  return true;
}

function nag_timer(timer, guy) {
  self endon("death");

  temp = timer;

  currenttime = gettime();

  while(currenttime + timer * 1000 > gettime()) {
    if(getdvarint(@ "scr_debug_nags")) {
      print3d(guy.origin + (0, 0, 70), temp + "<dev string:x3ee>", (1, 1, 0.5), 1, 0.6, 20);
      temp--;
    }

    wait 1;
  }

  self notify("do_nag");
}

function anim_set_time_solo(guy, anime, time) {
  self endon("death");
  newguy[0] = guy;
  anim_set_time(newguy, anime, time);
}

function anim_set_time(guys, anime, time) {
  utility::array_thread(guys, &anim_self_set_time, anime, time);
}

function anim_self_set_time(anime, time) {
  animation = utility::getanim(anime);

  if(isarray(animation)) {
    animation = animation[0];
  }

  self setanimtime(animation, time);
}

function last_anim_time_check() {
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

function anim_moveTo(guys, anime, tag, time, acceleration_time, deceleration_time) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  foreach(guy in guys) {
    startorg = getstartorigin(org, angles, level.scr_anim[guy.animname][anime]);
    startang = getstartangles(org, angles, level.scr_anim[guy.animname][anime]);

    if(isai(guy)) {
      assertmsg("<dev string:x401>");
      continue;
    }

    guy moveTo(startorg, time, acceleration_time, deceleration_time);
    guy rotateTo(startang, time, acceleration_time, deceleration_time);
  }
}

function anim_teleport_solo(guy, anime, tag) {
  self endon("death");
  newguy[0] = guy;
  anim_teleport(newguy, anime, tag);
}

function anim_teleport(guys, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];

  foreach(guy in guys) {
    startorg = getstartorigin(org, angles, level.scr_anim[guy.animname][anime]);
    startang = getstartangles(org, angles, level.scr_anim[guy.animname][anime]);
    guy[[anim.callbacks["TeleportEnt"]]](startorg, startang);
  }
}

function anim_generic_teleport(guy, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  startorg = getstartorigin(org, angles, level.scr_anim["generic"][anime]);
  startang = getstartangles(org, angles, level.scr_anim["generic"][anime]);
  guy[[anim.callbacks["TeleportEnt"]]](startorg, startang);
}

function anim_spawn_generic_model(model, anime, tag) {
  return anim_spawn_model(model, "generic", anime, tag);
}

function anim_spawn_model(model, animname, anime, tag) {
  pos = get_anim_position(tag);
  org = pos["origin"];
  angles = pos["angles"];
  startorg = getstartorigin(org, angles, level.scr_anim[animname][anime]);
  startangles = getstartorigin(org, angles, level.scr_anim[animname][anime]);
  spawned = spawn("script_model", startorg);
  spawned setModel(model);
  spawned.angles = startangles;
  return spawned;
}

function anim_spawn_tag_model(model, tag) {
  self attach(model, tag);
}

function anim_link_tag_model(model, tag) {
  org = self gettagorigin(tag);
  spawned = spawn("script_model", org);
  spawned setModel(model);
  spawned linkTo(self, tag, (0, 0, 0), (0, 0, 0));
  return spawned;
}

function removenotetrack(animname, notetrack, anime, notetype, ent) {
  notetrack = tolower(notetrack);
  array = level.scr_notetrack[animname][anime][notetrack];
  anime = get_generic_anime(anime);
  index = -1;

  if(!isDefined(array) || !isarray(array) || array.size < 1) {
    return;
  }

  for(i = 0; i < array.size; i++) {
    if(isDefined(array[i][notetype])) {
      if(!isDefined(ent) || array[i][notetype] == ent) {
        index = i;
        break;
      }
    }
  }

  if(index < 0) {
    return;
  }

  if(array.size == 1) {
    array = [];
  } else {
    array[index] = undefined;
  }

  if(isint(index)) {
    function_cdc669dbc8ea2101(array);
  }

  level.scr_notetrack[animname][anime][notetrack] = array;
}

function addnotetrack_flag(animname, notetrack, theflag, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["flag"] = theflag;
  level.scr_notetrack[animname][anime][notetrack][index] = array;

  if(utility::issp()) {
    if(!(isDefined(level.flag) && isDefined(level.flag[theflag]))) {
      utility::flag_init(theflag);
    }
  }
}

function addnotetrack_flag_clear(animname, notetrack, theflag, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["flag_clear"] = theflag;
  level.scr_notetrack[animname][anime][notetrack][index] = array;

  if(!(isDefined(level.flag) && isDefined(level.flag[theflag]))) {
    utility::flag_init(theflag);
  }
}

function addnotetrack_dialogue(animname, notetrack, anime, soundalias) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["dialog"] = soundalias;
}

function add_notetrack_and_get_index(animname, notetrack, anime) {
  notetrack = tolower(notetrack);
  add_notetrack_array(animname, notetrack, anime);
  return level.scr_notetrack[animname][anime][notetrack].size;
}

function add_notetrack_array(animname, notetrack, anime) {
  notetrack = tolower(notetrack);

  if(!isDefined(level.scr_notetrack)) {
    level.scr_notetrack = [];
  }

  if(!isDefined(level.scr_notetrack[animname])) {
    level.scr_notetrack[animname] = [];
  }

  if(!isDefined(level.scr_notetrack[animname][anime])) {
    level.scr_notetrack[animname][anime] = [];
  }

  if(!isDefined(level.scr_notetrack[animname][anime][notetrack])) {
    level.scr_notetrack[animname][anime][notetrack] = [];
  }
}

function addnotetrack_sound(animname, notetrack, anime, soundalias, sound_stays_death, tag) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["sound"] = soundalias;

  if(isDefined(sound_stays_death)) {
    level.scr_notetrack[animname][anime][notetrack][index]["sound_stays_death"] = 1;
  }

  if(isDefined(tag)) {
    level.scr_notetrack[animname][anime][notetrack][index]["sound_on_tag"] = tag;
  }
}

function note_track_start_sound(notetrack, soundalias, sound_stays_death, tag) {
  scenedata = get_datascene();
  addnotetrack_sound(scenedata.animname, notetrack, scenedata.anim_sequence, soundalias, sound_stays_death, tag);
}

function addnotetrack_playersound(animname, notetrack, anime, soundalias) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["playersound"] = soundalias;
}

function get_generic_anime(anime) {
  if(!isDefined(anime)) {
    return "any";
  }

  return anime;
}

function addonstart_animsound(animname, anime, soundalias) {
  if(!isDefined(level.scr_animsound[animname])) {
    level.scr_animsound[animname] = [];
  }

  level.scr_animsound[animname][anime] = soundalias;
}

function addnotetrack_playerdialogue(animname, notetrack, anime, soundalias) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  level.scr_notetrack[animname][anime][notetrack][index] = [];
  level.scr_notetrack[animname][anime][notetrack][index]["playerdialogue"] = soundalias;
}

function addnotetrack_animsound(animname, anime, notetrack, soundalias) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["sound"] = soundalias;
  array["created_by_animSound"] = 1;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_attach(animname, notetrack, model, tag, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["attach model"] = model;
  array["selftag"] = tag;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_detach(animname, notetrack, model, tag, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["detach model"] = model;
  array["selftag"] = tag;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_detach_gun(animname, notetrack, anime, suspend) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["detach gun"] = 1;
  array["tag"] = "tag_weapon_right";

  if(isDefined(suspend)) {
    array["suspend"] = suspend;
  }

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_attach_gun(animname, notetrack, anime, weapplacement) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];

  if(isDefined(weapplacement)) {
    array["attach gun " + weapplacement] = 1;
  } else {
    array["attach gun right"] = 1;
  }

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_customfunction(animname, notetrack, function, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["function"] = function;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_startfxontag(animname, notetrack, anime, effect_name, tagname, moreThanThreeHack) {
  utility::getfx(effect_name);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["effect"] = effect_name;
  array["selftag"] = tagname;

  if(isDefined(moreThanThreeHack)) {
    array["moreThanThreeHack"] = moreThanThreeHack;
  }

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_stopFXOnTag(animname, notetrack, anime, effect_name, tagname) {
  utility::getfx(effect_name);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["stop_effect"] = effect_name;
  array["selftag"] = tagname;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_mayhemstart(animname, notetrack, animation, anime, usehatmodel) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["mayhem_start"] = animation;
  array["use_hat_model"] = usehatmodel;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_mayhemend(animname, notetrack, animation, anime, usehatmodel) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["mayhem_end"] = animation;
  array["use_hat_model"] = usehatmodel;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function note_track_swap_to_efx(notetrack, effect_path, tagname) {
  scenedata = get_datascene();
  utility::add_fx(effect_path, effect_path);
  addnotetrack_swapparttoefx(scenedata.animname, notetrack, scenedata.animsequence, effect_path, tagname);
}

function note_track_stop_efx_on_tag(notetrack, effect_path, tagname) {
  scenedata = get_datascene();
  utility::add_fx(effect_path, effect_path);
  addnotetrack_stopFXOnTag(scenedata.animname, notetrack, scenedata.animsequence, effect_path, tagname);
}

function addnotetrack_swapparttoefx(animname, notetrack, anime, effect_name, tagname) {
  utility::getfx(effect_name);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["swap_part_to_efx"] = effect_name;
  array["selftag"] = tagname;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function note_track_trace_to_efx(notetrack, canceltrack, tagname, effect_path, waterfx_path, delete_depth) {
  scenedata = get_datascene();

  if(notetrack != "start" && !animhasnotetrack(scenedata utility::getanim(scenedata.anim_sequence), notetrack)) {
    println("<dev string:x424>" + scenedata.anim_sequence + "<dev string:x443>" + notetrack);
    return;
  }

  utility::add_fx(effect_path, effect_path);

  if(isDefined(waterfx_path)) {
    utility::add_fx(waterfx_path, waterfx_path);
  }

  addnotetrack_tracepartforefx(scenedata.animname, notetrack, canceltrack, scenedata.anim_sequence, tagname, effect_path, waterfx_path, delete_depth);
}

function note_track_start_fx_on_tag(notetrack, tagname, effect_path) {
  scenedata = get_datascene();

  if(notetrack != "start" && !animhasnotetrack(scenedata utility::getanim(scenedata.anim_sequence), notetrack)) {
    println("<dev string:x461>" + scenedata.anim_sequence + "<dev string:x443>" + notetrack);
    return;
  }

  utility::add_fx(effect_path, effect_path);
  addnotetrack_startfxontag(scenedata.animname, notetrack, scenedata.anim_sequence, effect_path, tagname, 1);
}

function get_datascene() {
  assert(isDefined(level.current_anim_data_scene));
  scenedata = level.current_anim_data_scene;
  assert(isDefined(scenedata.animtree), "<dev string:x47a>");
  return scenedata;
}

function addnotetrack_tracepartforefx(animname, notetrack, canceltrack, anime, tagname, effect_name, waterfx_name, delete_depth) {
  utility::getfx(effect_name);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["trace_part_for_efx"] = effect_name;
  array["trace_part_for_efx_water"] = waterfx_name;
  array["trace_part_for_efx_cancel"] = canceltrack;
  array["trace_part_for_efx_delete_depth"] = delete_depth;
  array["selftag"] = tagname;
  level.scr_notetrack[animname][anime][notetrack][index] = array;

  if(isDefined(canceltrack)) {
    array = [];
    array["trace_part_for_efx_canceling"] = canceltrack;
    array["selftag"] = tagname;
    index = add_notetrack_and_get_index(animname, canceltrack, anime);
    level.scr_notetrack[animname][anime][canceltrack][index] = array;
  }
}

function addnotetrack_notify(animname, notetrack, thenotify, anime) {
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["notify"] = thenotify;
  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function setanimtree() {
  id = self useanimtree(level.scr_animtree[self.animname]);
  return id;
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

  if(!isDefined(level.scr_animlength)) {
    level.scr_animlength[0][0] = 0;
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

  if(!isDefined(level.scr_xcam)) {
    level.scr_xcam = [];
  }

  thread precache_script_models_thread();
  thread precache_weapon_models_thread();
  utility::create_lock("moreThanThreeHack", 3);
  utility::create_lock("trace_part_for_efx", 12);

  setdevdvarifuninitialized(@ "hash_b46df2b57cc019b", 0);

  init_animsounds();

  level thread function_2cff1618834b2ab7();
  level thread function_95203209b32581ca();
}

function precache_script_models_thread() {
  waittillframeend();

  if(!isDefined(level.scr_model)) {
    return;
  }

  models = getarraykeys(level.scr_model);

  for(i = 0; i < models.size; i++) {
    if(isarray(level.scr_model[models[i]])) {
      for(modelindex = 0; modelindex < level.scr_model[models[i]].size; modelindex++) {
        precachemodel(level.scr_model[models[i]][modelindex]);
      }

      continue;
    }

    precachemodel(level.scr_model[models[i]]);
  }
}

function precache_weapon_models_thread() {
  waittillframeend();

  if(!isDefined(level.scr_weapon)) {
    return;
  }

  weapons = getarraykeys(level.scr_weapon);

  for(i = 0; i < weapons.size; i++) {
    assert(isarray(level.scr_weapon[weapons[i]]), weapons[i] + "<dev string:x4b2>");
    attachments = [];

    if(isDefined(level.scr_weapon[weapons[i]][1])) {
      assert(isarray(level.scr_weapon[weapons[i]][1]), "<dev string:x4e3>");
      attachments = level.scr_weapon[weapons[i]][1];
    }

    utility::make_weapon_model(level.scr_weapon[weapons[i]][0], attachments, 1, 1);
  }
}

function init_animsounds() {
  level.animsounds = [];
  level.animsound_aliases = [];
  animnames = getarraykeys(level.scr_notetrack);

  for(i = 0; i < animnames.size; i++) {
    init_notetracks_for_animname(animnames[i]);
  }

  animnames = getarraykeys(level.scr_animsound);

  for(i = 0; i < animnames.size; i++) {
    init_animsounds_for_animname(animnames[i]);
  }
}

function init_animsounds_for_animname(animname) {
  animes = getarraykeys(level.scr_animsound[animname]);

  for(i = 0; i < animes.size; i++) {
    anime = animes[i];
    soundalias = level.scr_animsound[animname][anime];
    level.animsound_aliases[animname][anime]["#" + anime]["soundalias"] = soundalias;
    level.animsound_aliases[animname][anime]["#" + anime]["created_by_animSound"] = 1;
  }
}

function init_notetracks_for_animname(animname) {
  foreach(anime, anime_array in level.scr_notetrack[animname]) {
    foreach(notetrack, notetrack_array in anime_array) {
      foreach(scr_notetrack in notetrack_array) {
        soundalias = scr_notetrack["sound"];

        if(!isDefined(soundalias)) {
          continue;
        }

        level.animsound_aliases[animname][anime][notetrack]["soundalias"] = soundalias;

        if(isDefined(scr_notetrack["created_by_animSound"])) {
          level.animsound_aliases[animname][anime][notetrack]["created_by_animSound"] = 1;
        }
      }
    }
  }
}

function endonremoveanimactive(endonstring, guypackets) {
  self waittill(endonstring);

  foreach(guypacket in guypackets) {
    guy = guypacket["guy"];

    if(!isDefined(guy)) {
      continue;
    }

    visibility_mode::function_4e6c654251b854e0(guy);
    guy._animactive--;
    guy._lastanimtime = gettime();
    assert(guy._animactive >= 0);
  }
}

function anim_deathnotify(guy, anime) {
  self endon(anime);
  guy waittill("death");

  if(isDefined(guy.anim_is_death) && guy.anim_is_death) {
    return;
  }

  self notify(anime);
}

function anim_facialendnotify(guy, anime, scriptedfaceanim) {
  self endon(anime);
  time = getanimlength(scriptedfaceanim);
  wait time;
  self notify(anime);
}

function anim_dialogueendnotify(guy, anime) {
  self endon(anime);
  guy waittill("single dialogue");
  self notify(anime);
}

function anim_animationendnotify(guy, anime, scriptedanimationtime, anim_end_time) {
  self endon(anime);
  guy endon("death");
  scriptedanimationtime -= anim_end_time;

  if(anim_end_time > 0 && scriptedanimationtime > 0) {
    guy utility::waittill_match_or_timeout("single anim", "end", scriptedanimationtime);
    guy stopanimScripted();
  } else {
    guy waittillmatch("single anim", "end");
  }

  self notify(anime);
}

function anim_weight(animname, anime) {
  assert(isDefined(level.scr_anim[animname][anime]), "<dev string:x51d>" + anime + "<dev string:x53e>" + animname);
  assert(isarray(level.scr_anim[animname][anime]), "<dev string:x551>" + animname + "<dev string:x57d>" + anime + "<dev string:x585>");
  total_anims = level.scr_anim[animname][anime].size;
  idleanim = randomint(total_anims);

  if(isDefined(level.scr_anim[animname][anime + "weight"])) {
    idleanim = get_weighted_anim(animname, anime, total_anims);
  }

  return idleanim;
}

function get_weighted_anim(animname, anime, total_anims) {
  idleanim = undefined;

  if(total_anims > 1) {
    weights = 0;
    anim_weight = 0;

    for(i = 0; i < total_anims; i++) {
      if(isDefined(level.scr_anim[animname][anime + "weight"])) {
        if(isDefined(level.scr_anim[animname][anime + "weight"][i])) {
          weights++;
          anim_weight += level.scr_anim[animname][anime + "weight"][i];
        }
      }
    }

    if(weights == total_anims) {
      anim_play = randomfloat(anim_weight);
      anim_weight = 0;

      for(i = 0; i < total_anims; i++) {
        anim_weight += level.scr_anim[animname][anime + "weight"][i];

        if(anim_play < anim_weight) {
          idleanim = i;
          break;
        }
      }
    }
  }

  return idleanim;
}

#using_animtree("generic_human");

function play_addtive_head_anim(guy, animation) {
  guy setanimlimited(%addtive_head_anims, 1, 0.2);
  guy setanimlimited(animation, 1, 0.2);
  wait getanimlength(animation);
  guy clearanim(%addtive_head_anims, 0.2);
  guy clearanim(animation, 0.2);
}

function get_anim_position(tag) {
  org = undefined;
  angles = undefined;

  if(isDefined(tag)) {
    org = self gettagorigin(tag);
    angles = self gettagangles(tag);
  } else {
    org = self.origin;
    angles = self.angles;

    if(!isDefined(angles)) {
      angles = (0, 0, 0);
    }
  }

  array = [];
  array["angles"] = angles;
  array["origin"] = org;
  return array;
}

function function_bcb776397b6f4ce(xanim, tag, time, baseorigin, baseangles, var_84dbd854571920e7) {
  result = self function_69d089914c13dc3a(xanim, tag, time, var_84dbd854571920e7);

  if(isDefined(result)) {
    result["origin"] = coordtransform(result["origin"], baseorigin, baseangles);
    result["angles"] = combineangles(baseangles, result["angles"]);
  }

  return result;
}

function anim_at_self(entity, tag) {
  packet = [];
  packet["guy"] = self;
  packet["entity"] = self;
  return packet;
}

function anim_at_entity(entity, tag) {
  packet = [];
  packet["guy"] = self;
  packet["entity"] = entity;
  packet["tag"] = tag;
  return packet;
}

function assert_existance_of_anim(anime, animname, animation) {
  if(!isDefined(self)) {
    return;
  }

  if(isagent(self)) {
    return;
  }

  if(!isDefined(animname)) {
    animname = self.animname;
  }

  if(!isDefined(animname)) {
    assertmsg("<dev string:x5ce>" + self.classname + "<dev string:x5ee>");
    return;
  }

  has_anim = 0;

  if(isDefined(level.scr_anim[animname])) {
    has_anim = 1;

    if(isDefined(level.scr_anim[animname][anime])) {
      return;
    }
  }

  has_face = 0;

  if(isDefined(level.scr_face[animname])) {
    has_face = 1;

    if(isDefined(level.scr_face[animname][anime])) {
      return;
    }
  }

  has_sound = 0;

  if(isDefined(level.scr_sound[animname])) {
    has_sound = 1;

    if(isDefined(level.scr_sound[animname][anime])) {
      return;
    }
  }

  if(has_anim || has_sound || has_face) {
    if(has_anim) {
      array = getarraykeys(level.scr_anim[animname]);

      println("<dev string:x603>" + animname + "<dev string:x61e>");

      foreach(member in array) {
        println(member);
      }
    }

    if(has_sound) {
      array = getarraykeys(level.scr_sound[animname]);

      println("<dev string:x623>" + animname + "<dev string:x61e>");

      foreach(member in array) {
        println(member);
      }
    }

    if(has_face) {
      array = getarraykeys(level.scr_face[animname]);

      println("<dev string:x642>" + animname + "<dev string:x61e>");

      foreach(member in array) {
        println(member);
      }
    }

    assertmsg("<dev string:x660>" + debug::function_4496bef4cfc0d07(self) + "<dev string:x100>" + animname + "<dev string:x114>" + anime + "<dev string:x666>");
    return;
  }

  keys = getarraykeys(level.scr_anim);
  keys = arraycombine(keys, getarraykeys(level.scr_sound));

  foreach(key in keys) {
    println(key);
  }

  assertmsg("<dev string:x6a9>" + animname + "<dev string:x6b6>");
}

function printloops(guy, anime) {
  if(!isDefined(guy)) {
    return;
  }

  guy endon("<dev string:x700>");
  waittillframeend();
  guy.loops++;

  if(guy.loops > 0) {
    guy.loopanims[guy.loopanims.size] = anime;
  }

  if(guy.loops > 1) {
    println("<dev string:x709>" + guy.animname + "<dev string:x71d>" + guy.loops + "<dev string:x726>");

    for(i = 0; i < guy.loopanims.size; i++) {
      println("<dev string:x746>" + guy.loopanims[i]);
    }

    assertmsg("<dev string:x752>");
  }
}

function function_22388de1d368ad59(guy, ender, anime) {
  guy endon("<dev string:x700>");
  self waittill(ender);
  guy.loopanims = arrayremove(guy.loopanims, anime);
  guy.loops--;
}

function anim_single_failsafeonguy(owner, anime) {
  if(getDvar(@ "hash_27494f1d75fc0809") != "<dev string:x795>") {
    return;
  }

  owner endon(anime);
  owner endon("<dev string:x700>");
  self endon("<dev string:x700>");
  name = self.classname;
  num = self getentitynumber();
  wait 60;
  println("<dev string:x79b>" + name + "<dev string:x7b3>" + num);
  waittillframeend();
  assert(0, "<dev string:x7c3>" + anime + "<dev string:x7d2>");
}

function anim_single_failsafe(guys, anime) {
  foreach(guy in guys) {
    guy thread anim_single_failsafeonguy(self, anime);
  }
}

function anim_get_goal_time(animname, anime) {
  if(isDefined(level.scr_goaltime[animname]) && isDefined(level.scr_goaltime[animname][anime])) {
    return level.scr_goaltime[animname][anime];
  }

  return 0.2;
}

function function_221025fccd3803be(animation) {
  if(utility::issp()) {
    return 0.5;
  }

  return 0;
}

function function_b8e0e318104693fb(anime) {
  if(utility::issp() && isDefined(level.scr_entrances) && level.scr_entrances[anime]) {
    return true;
  }

  return false;
}

function function_c5c322095ca966be(guys, anime) {
  if(function_b8e0e318104693fb(anime) && guys.size > 1) {
    foreach(guy in guys) {
      if(!isDefined(guy.animname) || !guy function_38c78e116af0cf61(guy.animname) && !guy function_861174907e3fbdba(guy.animname)) {
        guys = arrayremove(guys, guy);
        guys[guys.size] = guy;
      }
    }
  }

  return guys;
}

function function_179fdcb8d53829fe(anime, animname, animation) {
  newanime = anime + "_entrance";
  level.scr_anim[animname][newanime] = animation;
  return newanime;
}

function function_c662ac26794ce12f(anime, org, angles, animname) {
  setdvarifuninitialized(@ "hash_4140c00f3efa94c6", 0);

  if(function_38c78e116af0cf61(animname)) {
    return function_ec05bbabe0c3c845(anime, org, angles, animname);
  } else if(function_861174907e3fbdba(animname)) {
    return function_6fc6ea53161df7de(anime, org, angles, animname);
  }

  if(!isDefined(level.var_fdce85e9ff138573)) {
    level.var_fdce85e9ff138573 = 0;

    if(getdvarint(@ "hash_4140c00f3efa94c6", 0)) {
      iprintln("<dev string:x807>");
    }
  }

  if(isarray(level.scr_anim[animname][anime])) {
    return level.scr_anim[animname][anime][level.var_fdce85e9ff138573];
  }

  return level.scr_anim[animname][anime];
}

function function_ec05bbabe0c3c845(anime, org, angles, animname) {
  if(isDefined(level.var_fdce85e9ff138573) && level.var_f9ffc25dbcc85a5b && level.var_f9ffc25dbcc85a5b == gettime()) {
    return level.scr_anim[animname][anime][level.var_fdce85e9ff138573];
  }

  closest_anim = 0;
  closest_dist = undefined;
  level.var_fdce85e9ff138573 = undefined;

  foreach(i, animation in level.scr_anim[animname][anime]) {
    neworg = getstartorigin(org, angles, animation);

    if(getdvarint(@ "hash_4140c00f3efa94c6", 0)) {
      line(self.origin, neworg, (1, 1, 1), 1, 0, 1000);
      print3d(neworg + (0, 0, 2), animation, (1, 1, 1), 1, 0.075, 1000, 1);
      print3d(neworg, "<dev string:x82f>", (1, 1, 1), 1, 0.2, 1000, 1);
    }

    if(!isDefined(closest_dist)) {
      closest_dist = distancesquared(neworg, level.player.origin);
      continue;
    }

    dist = distancesquared(level.player.origin, neworg);

    if(dist < closest_dist) {
      closest_anim = i;
      closest_dist = dist;
    }
  }

  animation = level.scr_anim[animname][anime][closest_anim];

  if(getdvarint(@ "hash_4140c00f3efa94c6", 0)) {
    iprintln("<dev string:x834>" + animation);
  }

  level.var_f9ffc25dbcc85a5b = gettime();
  level.var_fdce85e9ff138573 = closest_anim;
  return animation;
}

function function_6fc6ea53161df7de(anime, org, angles, animname) {
  level.var_fdce85e9ff138573 = undefined;
  animation = level.scr_anim[animname][anime][0];
  level.var_fdce85e9ff138573 = 0;
  return animation;
}

function function_861174907e3fbdba(animname) {
  if(level.scr_animtree[animname] == #animtree) {
    return true;
  }

  return false;
}

function function_38c78e116af0cf61(animname) {
  return [[anim.callbacks["CheckPlayerAnimtree"]]](animname);
}

function function_1e45b56fb88a49ff(animation) {
  if(!animhasnotetrack(animation, "blend_into")) {
    return 0;
  }

  return utility::get_notetrack_time(animation, "blend_into");
}

function function_823734400cf3f21b(animation) {
  if(!animhasnotetrack(animation, "blend_out")) {
    return undefined;
  }

  return utility::get_notetrack_time(animation, "blend_out");
}

function function_665c2978bc67586a(animation) {
  speed = 128;

  if(animhasnotetrack(animation, "blend_speed = walk")) {
    speed = 128;
  } else if(animhasnotetrack(animation, "blend_speed = run")) {
    speed = 145;
  }

  return speed * 0.7;
}

function function_42bfba55ba08d414(animation) {
  stances = [];

  if(animhasnotetrack(animation, "start_stance = stand")) {
    stances[stances.size] = "stand";
  } else if(animhasnotetrack(animation, "start_stance = crouch")) {
    stances[stances.size] = "crouch";
  } else if(animhasnotetrack(animation, "start_stance = prone")) {
    stances[stances.size] = "prone";
  } else {
    stances[stances.size] = "none";
  }

  if(animhasnotetrack(animation, "end_stance = stand")) {
    stances[stances.size] = "stand";
  } else if(animhasnotetrack(animation, "end_stance = crouch")) {
    stances[stances.size] = "crouch";
  } else if(animhasnotetrack(animation, "end_stance = prone")) {
    stances[stances.size] = "prone";
  } else {
    stances[stances.size] = "none";
  }

  return stances;
}

function function_7722e93889a8baa8(playerpos, animstartpos, blendspeed, blendIntoTime, var_a264bf3497092f5a = 1, var_6bc01e70cc97e942 = 0, simultaneous = 0) {
  assert(!(var_a264bf3497092f5a && var_6bc01e70cc97e942), "<dev string:x84e>");

  if(var_a264bf3497092f5a) {
    weaponDropTime = level.player getgestureanimlength("proto_vm_gesture_gun_drop");
  } else if(var_6bc01e70cc97e942) {
    weaponDropTime = 0.5;
  } else {
    weaponDropTime = 0;
  }

  weaponDropQuick = 0;

  if(simultaneous) {
    weaponDropQuick = 1;
    weaponDropTime = 0;
  } else if(level.player getdemeanorviewmodel() == "relaxed") {
    weaponDropQuick = 1;
    weaponDropTime = 0.2;
  }

  blendtimecalc = distance2d(playerpos, animstartpos) / blendspeed;
  idealblendtime = blendIntoTime + weaponDropTime;

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    iprintln("<dev string:x894>" + blendtimecalc);
  }

  if(blendIntoTime > 0) {
    frac = blendtimecalc / idealblendtime;

    if(frac < 1.4 && frac > 0.4) {
      blendtime = idealblendtime;
    } else if(blendtimecalc < blendIntoTime) {
      blendtime = blendIntoTime < 1 ? blendIntoTime + weaponDropTime : 1 + weaponDropTime;
    } else if(blendtimecalc > 0.5) {
      blendtime = blendtimecalc;
    } else {
      blendtime = 0.5;
    }
  } else {
    blendtime = 0.5;
  }

  if(blendtime > idealblendtime) {
    if(getdvarint(@ "hash_398da46238160a6", 0)) {
      iprintln("<dev string:x8ae>");
    }

    weaponDropTime = blendtime - blendIntoTime;
  }

  level.blendinfo["weaponDropQuick"] = weaponDropQuick;
  level.blendinfo["weaponDropTime"] = weaponDropTime;
  return blendtime;
}

function function_aa818156be1260ae(playerpos, animstartpos, blendspeed, blendIntoTime, var_a264bf3497092f5a = 1, var_6bc01e70cc97e942 = 0, simultaneous = 0) {
  if(!var_6bc01e70cc97e942) {
    quickdroptime = 0;
    normaldroptime = 0;
  } else {
    quickdroptime = 0.2;

    if(var_a264bf3497092f5a) {
      normaldroptime = level.player getgestureanimlength("proto_vm_gesture_gun_drop");
    } else {
      normaldroptime = 0.5;
    }
  }

  blendtime = distance2d(playerpos, animstartpos) / blendspeed;

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    iprintln("<dev string:x894>" + blendtime);
  }

  idealblendtime = blendIntoTime + normaldroptime;

  if(idealblendtime > 0) {
    frac = blendtime / idealblendtime;

    if(frac < 1.4 && frac > 0.4) {
      blendtime = idealblendtime;
    } else if(blendtime < blendIntoTime) {
      blendtime = blendIntoTime <= 1 ? blendIntoTime : 1;
    }
  }

  if(var_a264bf3497092f5a && var_6bc01e70cc97e942) {
    blendtime = blendtime < normaldroptime ? normaldroptime : blendtime;
  } else if(!var_6bc01e70cc97e942) {
    blendtime = blendtime < 0.5 ? 0.5 : blendtime;
  } else {
    blendtime = blendtime < quickdroptime ? quickdroptime : blendtime;
  }

  weaponDropQuick = 0;
  weaponDropTime = normaldroptime;

  if(blendtime < normaldroptime || level.player getdemeanorviewmodel() == "relaxed") {
    weaponDropQuick = 1;
    weaponDropTime = quickdroptime;
  } else if(blendtime > idealblendtime) {
    if(getdvarint(@ "hash_398da46238160a6", 0)) {
      iprintln("<dev string:x8ae>");
    }

    weaponDropTime = blendtime - blendIntoTime;
  }

  if(simultaneous) {
    weaponDropQuick = 1;
    weaponDropTime = 0;
  }

  level.blendinfo["weaponDropQuick"] = weaponDropQuick;
  level.blendinfo["weaponDropTime"] = weaponDropTime;
  return blendtime;
}

function function_164e271703d2775b(anime, animname, var_a264bf3497092f5a, var_6bc01e70cc97e942, simultaneous) {
  if(function_b8e0e318104693fb(anime)) {
    animation = function_c662ac26794ce12f(anime, self.origin, self.angles, animname);
  } else {
    animation = level.scr_anim[animname][anime];
  }

  function_53dcb1bbf4af9078(animation, var_a264bf3497092f5a, var_6bc01e70cc97e942, simultaneous);
}

function function_53dcb1bbf4af9078(animation, var_a264bf3497092f5a, var_6bc01e70cc97e942, simultaneous) {
  animpos = getstartorigin(self.origin, self.angles, animation);
  level.blendinfo = [];
  blendIntoTime = function_1e45b56fb88a49ff(animation);
  blendouttime = function_823734400cf3f21b(animation);
  blendspeed = function_665c2978bc67586a(animation);
  blendtime = function_7722e93889a8baa8(level.player.origin, animpos, blendspeed, blendIntoTime, var_a264bf3497092f5a, var_6bc01e70cc97e942, simultaneous);
  stances = function_42bfba55ba08d414(animation);
  level.blendinfo["blendIntoTime"] = blendIntoTime;
  level.blendinfo["blendOutTime"] = blendouttime;
  level.blendinfo["blendSpeed"] = blendspeed;
  level.blendinfo["blendTime"] = blendtime;
  level.blendinfo["stances"] = stances;

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    iprintln("<dev string:x902>" + blendtime);
    iprintln("<dev string:x911>" + blendIntoTime);

    if(isDefined(blendouttime)) {
      iprintln("<dev string:x924>" + blendouttime);
    }

    iprintln("<dev string:x936>" + level.blendinfo["<dev string:x94a>"]);
    iprintln("<dev string:x95c>" + level.blendinfo["<dev string:x969>"][0] + "<dev string:x974>" + level.blendinfo["<dev string:x969>"][1]);
  }
}

function animscripted_enable_collision(bool) {
  assert(isDefined(bool), "<dev string:x97a>");

  if(bool) {
    self.animscripted_collision = 1;
    return;
  }

  self.animscripted_collision = undefined;
}

function function_6ee84ba29eeda4f() {
  if(self.animscripted_collision) {
    return true;
  }

  return false;
}

function function_bbb72e6208fc69de(bool, velocityent, blendtime) {
  assert(isDefined(bool), "<dev string:x97a>");

  if(bool) {
    assert(isDefined(velocityent), "<dev string:x98f>");
    self.animscripted_blendin_enabled = 1;
    self.animscripted_blendin_vel = velocityent getvelocity();

    if(isDefined(blendtime)) {
      self.animscripted_blendin_time = blendtime;
    } else {
      self.animscripted_blendin_time = 0.2;
    }

    return;
  }

  self.animscripted_blendin_enabled = undefined;
  self.animscripted_blendin_vel = undefined;
  self.animscripted_blendin_time = undefined;
}

function function_1d2dd6f111ac6b37() {
  if(isDefined(self.animscripted_blendin_vel) && self.animscripted_blendin_enabled && isDefined(self.animscripted_blendin_time)) {
    return true;
  }

  return false;
}

function get_scr_animlength(animcategory, animindex) {
  assert(isDefined(animcategory) && isDefined(animindex), "<dev string:x9b1>");
  animlength = 0;

  if(isDefined(level.scr_animlength[animcategory]) && isDefined(level.scr_animlength) && isDefined(level.scr_animlength[animcategory][animindex])) {
    animlength = level.scr_animlength[animcategory][animindex];
  } else if(isDefined(level.scr_anim[animcategory]) && isDefined(level.scr_anim) && isDefined(level.scr_anim[animcategory][animindex])) {
    animlength = getanimlength(level.scr_anim[animcategory][animindex]);
  } else {
    assertmsg("<dev string:x9ea>");
  }

  return animlength;
}

function function_2cff1618834b2ab7() {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  while(true) {
    requestflag = getdvarint(@ "hash_300079a74221ae45", 0);

    if(requestflag != 0) {
      origin = (0, 0, 0);
      angles = (0, 0, 0);
      align_target = getDvar(@ "hash_43022f85e8f590a5");
      align_tag = getDvar(@ "hash_9dfd128a6efc97b4");
      aligntarget = utility::getent_or_struct(align_target, "<dev string:xa76>");

      if(isDefined(aligntarget)) {
        if(isDefined(aligntarget.origin)) {
          origin = aligntarget.origin;
        }

        if(isDefined(aligntarget.angles)) {
          angles = aligntarget.angles;
        }
      }

      setDvar(@ "hash_aac2e2e60bc546c8", origin[0]);
      setDvar(@ "hash_aac2e3e60bc548fb", origin[1]);
      setDvar(@ "hash_aac2e4e60bc54b2e", origin[2]);
      setDvar(@ "hash_8961ba30d631ddb0", angles[0]);
      setDvar(@ "hash_8961bb30d631dfe3", angles[1]);
      setDvar(@ "hash_8961bc30d631e216", angles[2]);
      setDvar(@ "hash_300079a74221ae45", 0);
    }

    waitframe();
  }
}

function function_95203209b32581ca() {
  if(getdvarint(@ "nodebug", 0) >= 1) {
    return;
  }

  while(true) {
    requestflag = getdvarint(@ "hash_2c086d284345ecd4", 0);

    if(requestflag != 0) {
      var_f2913efe9015051c = getDvar(@ "hash_e5834102b73a09bb");
      var_282a59898f087e15 = getDvar(@ "hash_af17ebf34f961ade");
      targets = strtok(var_f2913efe9015051c, "<dev string:xa84>");

      foreach(targetname in targets) {
        foundentities = getEntArray(targetname, "<dev string:xa76>");
        foundentities = arraycombine(foundentities, getEntArray(targetname, "<dev string:xa8b>"));
        utility::array_call(foundentities, &hide);
      }

      targets = strtok(var_282a59898f087e15, "<dev string:xa84>");

      foreach(targetname in targets) {
        foundentities = getEntArray(targetname, "<dev string:xa76>");
        foundentities = arraycombine(foundentities, getEntArray(targetname, "<dev string:xa8b>"));
        utility::array_call(foundentities, &show);
      }

      setDvar(@ "hash_2c086d284345ecd4", 0);
    }

    waitframe();
  }
}

function function_91a1da37e0f88ea8(guys_with_anims, speed_baseline) {
  thread anim_reach_speed_control(guys_with_anims, speed_baseline);
  anim_reach_with_funcs_guys_with_anims(guys_with_anims, &reach_with_standard_adjustments_begin, &reach_with_standard_adjustments_end);
}

function anim_reach_with_funcs(guys, anime, tag, animname_override, start_func, end_func, arrival_type) {
  array = get_anim_position(tag);
  alignmentinfo = spawnStruct();
  alignmentinfo.origin = array["origin"];
  alignmentinfo.angles = array["angles"];
  guys_with_anims = [];

  foreach(guy in guys) {
    if(isDefined(animname_override)) {
      animname = animname_override;
    } else {
      animname = guy.animname;
    }

    animation = undefined;

    if(isDefined(level.scr_anim[animname][anime])) {
      if(isarray(level.scr_anim[animname][anime])) {
        animation = level.scr_anim[animname][anime][0];
      } else {
        animation = level.scr_anim[animname][anime];
      }
    }

    guys_with_anims[guys_with_anims.size] = [guy, animation, alignmentinfo];
  }

  anim_reach_with_funcs_guys_with_anims(guys_with_anims, start_func, end_func, arrival_type);
}

function anim_reach_with_funcs_guys_with_anims(guys_with_anims, start_func, end_func, arrival_type) {
  ent = spawnStruct();

  debugstartpos = getDvar(@ "hash_34dab4f8f3a04f4a") == "<dev string:x795>";

  threads = 0;
  guys = [];

  foreach(guy_anim in guys_with_anims) {
    guy = guy_anim[0];
    animation = guy_anim[1];
    alignment = guy_anim[2];
    guy_arrival_type = guy_anim[3];
    startorg = self.origin;
    startangles = self.angles;

    if(isDefined(alignment)) {
      startorg = alignment.origin;
      startangles = alignment.angles;
    }

    if(isDefined(animation)) {
      animorg = getstartorigin(startorg, startangles, animation);
      animangles = getstartangles(startorg, startangles, animation);
      startorg = animorg;
      startangles = animangles;
    }

    if(!isDefined(guy_arrival_type)) {
      guy_arrival_type = arrival_type;
    }

    if(isDefined(guy_arrival_type)) {
      if(isDefined(guy.scriptedarrivalent)) {
        guy.scriptedarrivalent delete();
        guy.scriptedarrivalent = undefined;
      }

      guy.scriptedarrivalent = spawn("script_origin", startorg);
      guy.scriptedarrivalent.targetname = "anim_reach_with_funcs_guys_with_anims";
      guy.scriptedarrivalent.angles = startangles;
      guy.scriptedarrivalent.type = guy_arrival_type;
      guy.scriptedarrivalent.arrivalstance = "stand";
      guy.forcenextpathfindimmediate = 1;

      if(isPlayer(guy) || isactor(guy)) {
        platform = guy getmovingplatformparent();

        if(isDefined(platform)) {
          guy.scriptedarrivalent linkTo(platform);
        }
      }
    }

    threads++;
    guy thread begin_anim_reach(ent, startorg, startangles, start_func, end_func);
  }

  while(threads) {
    ent waittill("reach_notify");
    threads--;
  }

  if(debugstartpos) {
    level notify("<dev string:xaa0>" + "<dev string:xaa5>");
  }

  foreach(guy_anim in guys_with_anims) {
    guy = guy_anim[0];

    if(!isalive(guy)) {
      continue;
    }

    guy.goalradius = guy.oldgoalradius;

    if(isDefined(guy.scriptedarrivalent)) {
      guy.scriptedarrivalent delete();
      guy.scriptedarrivalent = undefined;
    }

    guy.stopanimdistsq = 0;
  }
}

function private reach_death_notify(ent) {
  utility::waittill_any("death", "goal");

  while(isalive(self) && self.arriving) {
    wait 0.05;
  }

  ent notify("reach_notify");
}

function private begin_anim_reach(ent, startorg, startangles, start_func, end_func) {
  self endon("death");
  self endon("new_anim_reach");
  thread reach_death_notify(ent);
  startorg = [[start_func]](startorg, startangles);
  points = [];

  if(!(isDefined(self.scriptedarrivalent) && isDefined(self.scriptedarrivalent.type)) && distance2dsquared(startorg, self.origin) > 2500) {
    forward = anglesToForward(startangles);
    var_13a1ba1966151a3a = startorg - forward * 50;

    if(navisstraightlinereachable(startorg, var_13a1ba1966151a3a, self)) {
      points[points.size] = var_13a1ba1966151a3a;
    }
  }

  points[points.size] = startorg;
  self setgoalpath(points);
  self.reach_goal_pos = startorg;
  self.goalradius = 0;
  self.stopanimdistsq = squared(120);
  self waittill("goal");
  self notify("anim_reach_complete");
  [[end_func]]();
  self notify("new_anim_reach");
}

function anim_reach_speed_control(guys_with_anims, speed_baseline, var_b5dae1c694158f04) {
  waittillframeend();

  if(!isDefined(speed_baseline)) {
    speed_baseline = 140;
  }

  if(!isDefined(var_b5dae1c694158f04)) {
    var_b5dae1c694158f04 = 4;
  }

  foreach(index, guy_anim in guys_with_anims) {
    guy = guy_anim[0];
    guy_arrival_type = guy_anim[3];
    moving_destination = guy_arrival_type == "Exposed Moving";
    track_speed = moving_destination;

    track_speed = track_speed || getdvarint(@ "scr_debug_reach");

    if(track_speed) {
      guy childthread anim_reach_speed_control_avg(var_b5dae1c694158f04, speed_baseline);
    }

    guy aisetdesiredspeed(speed_baseline);
  }

  while(true) {
    furthestguy = undefined;
    furthestdist = 0;
    dist = [];
    dist_normal = [];
    remove = [];

    foreach(index, guy_anim in guys_with_anims) {
      guy = guy_anim[0];

      if(!isalive(guy)) {
        remove[remove.size] = index;
        continue;
      }

      dist[index] = guy pathdisttogoal();

      if(dist[index] == 0) {
        pos = guy.goalpos;

        if(isDefined(guy.reach_goal_pos)) {
          pos = guy.reach_goal_pos;
        }

        dist[index] = distance(guy.origin, pos);
      }

      if(dist[index] <= 4) {
        remove[remove.size] = index;
        continue;
      }

      if(dist[index] > furthestdist) {
        furthestguy = guy;
        furthestdist = dist[index];
      }
    }

    foreach(index in remove) {
      guy = guys_with_anims[index][0];

      if(isalive(guy)) {
        guy val::reset_all("anim_reach_speed_control");
        guy enableavoidance(1, 1);
        guy.reachspeed = undefined;
        guy notify("anim_reach_speed_control_avg");
      }

      guys_with_anims[index] = undefined;
    }

    if(guys_with_anims.size == 0) {
      break;
    }

    foreach(index, guy_anim in guys_with_anims) {
      guy = guy_anim[0];
      guy_arrival_type = guy_anim[3];
      moving_destination = guy_arrival_type == "Exposed Moving";

      if(dist[index] < 96) {
        guy enableavoidance(0, 0);
      }

      dist_normal[index] = dist[index] / furthestdist;
      speedscale = 1;

      if(furthestguy != guy) {
        if(moving_destination && dist[index] <= 16) {
          speedscale = min(1, guy.reachspeed.speed_avg + 0.05);
        } else {
          speedscale = max(dist_normal[index], 0.4);
        }
      }

      desiredspeed = speedscale * speed_baseline;

      if(getdvarint(@ "scr_debug_reach")) {
        if(furthestguy == guy) {
          print3d(guy.origin + (0, 0, 36), "<dev string:xab7>", (0, 1, 0), 1, 0.3, 1, 1);
        }

        line(guy.origin, guy.goalpos, (1, 1, 1), 1, 0, 1);
        print3d(guy.origin, "<dev string:xd8>" + int(speed_baseline), (0, 1, 0), 1, 0.3, 1, 1);
        print3d(guy.origin + (0, 0, 10), "<dev string:xd8>" + int(desiredspeed), (1, 1, 1), 1, 0.3, 1, 1);

        if(isDefined(guy.reachspeed)) {
          print3d(guy.origin + (0, 0, 20), "<dev string:xd8>" + int(guy.reachspeed.speed_avg), (0, 1, 1), 1, 0.3, 1, 1);
        }

        print3d(guy.origin + (0, 0, 80), string(speedscale), (0, 0, 1), 1, 0.3, 1, 1);
        print3d(guy.goalpos + (0, 0, 12), "<dev string:xd8>" + int(dist[index]), (0, 0, 1), 1, 1, 1, 1);
        sphere(guy.goalpos, 16);
      }

      switch (guy getdemeanor()) {
        case #"hash_186d745a92c317d9":
        case #"hash_9128327eb51e0b7b":
          guy val::set("anim_reach_speed_control", "move_speed_scale", speedscale);
          guy val::reset("anim_reach_speed_control", "desired_speed");
          break;
        default:
          guy val::set("anim_reach_speed_control", "desired_speed", desiredspeed);
          guy val::reset("anim_reach_speed_control", "move_speed_scale");
          break;
      }
    }

    waitframe();
  }
}

function anim_reach_speed_control_avg(var_b5dae1c694158f04, speed_baseline) {
  self endon("death");
  self notify("anim_reach_speed_control_avg");
  self endon("anim_reach_speed_control_avg");
  self.reachspeed = spawnStruct();
  reachspeed = self.reachspeed;
  reachspeed.speed_avg = speed_baseline;
  reachspeed.speed_samples = [];
  reachspeed.speed_total = 0;
  curr = 0;

  while(true) {
    index = curr % int(var_b5dae1c694158f04);
    curr++;

    if(isDefined(reachspeed.speed_samples[index])) {
      reachspeed.speed_total -= reachspeed.speed_samples[index];
    }

    reachspeed.speed_samples[index] = length(self.velocity);
    reachspeed.speed_total += reachspeed.speed_samples[index];
    reachspeed.speed_avg = reachspeed.speed_total / reachspeed.speed_samples.size;
    waitframe();
  }
}

function reach_with_standard_adjustments_begin(startorg, startangles) {
  assert(isDefined(anim.callbacks["<dev string:xac3>"]), "<dev string:xaec>");
  return self[[anim.callbacks["reach_with_standard_adjustments_begin"]]](startorg, startangles);
}

function reach_with_standard_adjustments_end() {
  assert(isDefined(anim.callbacks["<dev string:xb5e>"]), "<dev string:xb85>");
  self[[anim.callbacks["reach_with_standard_adjustments_end"]]]();
}