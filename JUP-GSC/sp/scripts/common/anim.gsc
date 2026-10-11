/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\common\anim.gsc
***********************************************/

#using scripts\common\debug;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\common\visibility_mode;
#using scripts\engine\utility;
#namespace animation;

function anim_first_frame(guys, anime, tag) {
  assertex(isarray(guys), "guys needs to be an array");
  array = get_anim_position(tag);
  org = array["origin"];
  angles = array["angles"];
  guys = function_1eba925251530689(guys, anime);
  array_levelthread(guys, &anim_first_frame_on_guy, anime, org, angles);
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

  if(function_f1e7ee8ddeece062(anime)) {
    animation = guy function_c099f6fd9c19f5a6(anime, org, angles, animname);
  } else if(isarray(level.scr_anim[animname][anime])) {
    animation = level.scr_anim[animname][anime][0];
    isloop = 1;
  } else {
    animation = level.scr_anim[animname][anime];
  }

  guy assert_existance_of_anim(anime, animname, animation);

  guy set_start_pos(anime, org, angles, animname, isloop, animation);

  if(isai(guy)) {
    assertex(isDefined(anim.callbacks["AIAnimFirstFrame"]), "You must define anim.callbacks[ AIAnimFirstFrame ] if you are first frame animating an AI");
    guy[[anim.callbacks["AIAnimFirstFrame"]]](animation, animname);
    return;
  }

  guy stopanimScripted();
  guy setanimknob(animation, 1, 0, 0);

  if(!issp()) {
    if(!isPlayer(guy) && !guy isvehicle() && isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][anime])) {
      if(isarray(level.scr_anim[animname][anime])) {
        guy builtin[[level.func["scriptModelPlayAnim"]]](level.scr_anim[animname][anime][0], undefined, 0, 0, "none");
        return;
      }

      guy builtin[[level.func["scriptModelPlayAnim"]]](level.scr_anim[animname][anime], undefined, 0, 0, "none");
    }
  }
}

function set_start_pos(anime, org, angles, animname_override, anim_array, animation) {
  animname = undefined;

  if(isDefined(animname_override)) {
    animname = animname_override;
  } else {
    animname = self.animname;
  }

  if(!isDefined(animation)) {
    if(function_f1e7ee8ddeece062(anime)) {
      animation = function_c099f6fd9c19f5a6(anime, org, angles, animname);
    } else if(isDefined(anim_array) && anim_array) {
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
  array_thread(guyarray, &set_start_pos, anime, org, angles);
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
  animation = guy getanim(anime);
  translation = getmovedelta(animation);
  rotation = getangledelta3d(animation);
  rotatedtranslation = rotatevector(translation, guy.angles);
  origin = guy.origin + rotatedtranslation;
  angles = combineangles(guy.angles, rotation);
  guy[[anim.callbacks["TeleportEnt"]]](origin, angles);
}

function anim_single_solo(guy, anime, tag, var_9e8a16d47a03007a, animname_override) {
  self endon("death");
  newguy[0] = guy;

  if(!isDefined(var_9e8a16d47a03007a)) {
    var_9e8a16d47a03007a = 0;
  }

  anim_single(newguy, anime, tag, var_9e8a16d47a03007a, animname_override);
}

function anim_single_internal(guys, anime, tag, var_9e8a16d47a03007a, animname_override) {
  entity = self;

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
  scriptedsoundindex = undefined;
  scriptedfaceindex = undefined;
  scriptedfaceanim = undefined;
  scriptedheadanim = undefined;
  anim_string = "single anim";
  hasxcam = 0;

  if(isDefined(level.scr_xcam) && isDefined(level.scr_xcam[anime])) {
    hasxcam = 1;
  }

  guys = function_1eba925251530689(guys, anime);

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

      if(function_6bc36c81fc28a22e()) {
        scripted_node_ent = self;
      }

      assertex(isDefined(guy.model) && guy.model != "<dev string:x1c>", "<dev string:x1d>" + function_a2eaafb222316a2(guy) + "<dev string:x3e>" + animname + "<dev string:x4f>" + anime + "<dev string:x69>");
      guy scripts\common\visibility_mode::function_d5f76e611c78509a();
      animtime = guy[[anim.callbacks["DoAnimation"]]](org, angles, animname, anime, anim_string, undefined, scripted_node_ent);

      if(animtime < scriptedanimationtime) {
        scriptedanimationtime = animtime;
        scriptedanimationindex = i;
      }
    }

    if(dofacialanim || dodialogue) {
      if(guy[[anim.callbacks["DoFacialAnim"]]](dofacialanim, dodialogue, doanimation, anime, animname, dialogue, 0)) {
        scriptedfaceindex = i;
      }

      scriptedsoundindex = i;
    }

    if(isai(guy)) {
      assertex(!(doanimation && guy doinglongdeath()), "AI is doing a long death, you cannot call animscripted on ai in long death");
    }

    assertex(doanimation || dofacialanim || dodialogue || dotext, "Tried to do anim scene " + anime + " on guy with animname " + animname + ", but he didn't have that anim scene.");

    if(doheadanim) {
      guy thread play_addtive_head_anim(guy, scriptedheadanim);
    }

    if(dotext && !dodialogue) {
      guy thread[[anim.callbacks["<dev string:x80>"]]](level.scr_text[animname][anime]);
    }

    if(!issp()) {
      if(!isPlayer(guy) && !isagent(guy) && !guy isvehicle() && isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][anime])) {
        blendtype = function_4a2dd4b9088bd637(animname, anime);

        if(isDefined(level.var_96c8e55e70edd512)) {
          blendtype = [[level.var_96c8e55e70edd512]](animname);
        }

        guy self_func("scriptModelPlayAnim", level.scr_anim[animname][anime], undefined, undefined, undefined, blendtype);
      }
    }

    if(guy function_e42b762e098c8f9e()) {
      guy animscripted_blendin(guy.var_37b96012304143d7, guy.var_f1a075b476ca91f1, "tag_camera");
    }
  }

  if(hasxcam) {
    [[anim.callbacks["playXcam"]]](level.scr_xcam[anime], org, angles);
  } else if(isDefined(scriptedanimationindex)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[scriptedanimationindex], anime);
    ent thread anim_animationendnotify(guys[scriptedanimationindex], anime, scriptedanimationtime, var_9e8a16d47a03007a);
    ent waittill(anime);
  } else if(isDefined(scriptedfaceindex)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[scriptedfaceindex], anime);
    ent thread anim_facialendnotify(guys[scriptedfaceindex], anime, scriptedfaceanim);
    ent waittill(anime);
  } else if(isDefined(scriptedsoundindex)) {
    ent = spawnStruct();
    ent thread anim_deathnotify(guys[scriptedsoundindex], anime);
    ent thread anim_dialogueendnotify(guys[scriptedsoundindex], anime);
    ent waittill(anime);
  }

  foreach(guy in guys) {
    if(!isDefined(guy) || !isDefined(guy._animactive)) {
      continue;
    }

    scripts\common\visibility_mode::function_b6e23e71bb7ad50f(guy);
    guy._animactive--;
    guy._lastanimtime = gettime();
    assert(guy._animactive >= 0);
  }

  self notify(anime);
}

function function_4a2dd4b9088bd637(animname, anime) {
  blendtype = undefined;

  if(isDefined(level.scr_goaltime[animname]) && isDefined(level.scr_goaltime[animname][anime])) {
    if(level.scr_goaltime[animname][anime] == 0) {
      blendtype = "none";
    }
  }

  return blendtype;
}

function anim_single(guys, anime, tag, var_9e8a16d47a03007a, animname_override) {
  if(!isDefined(var_9e8a16d47a03007a)) {
    var_9e8a16d47a03007a = 0;
  }

  anim_single_internal(guys, anime, tag, var_9e8a16d47a03007a, animname_override);
}

function anim_loop_solo(guy, anime, ender, tag, var_656e3d548572faf6, animname_override) {
  self endon("death");
  guy endon("death");
  newguy[0] = guy;
  anim_loop(newguy, anime, ender, tag, var_656e3d548572faf6, animname_override);
}

function anim_loop_solo_with_nags(guy, anime, ender, tag) {
  self endon("death");
  guy endon("death");
  assertex(isDefined(level.scr_anim[guy.animname][anime + "_nags"]), "No nag anims registered for anime scene " + anime);
  newguy[0] = guy;
  anim_loop(newguy, anime, ender, tag);
}

function anim_generic_loop(guy, anime, ender, tag) {
  packet = [];
  packet["guy"] = guy;
  packet["entity"] = self;
  packet["tag"] = tag;
  guypackets[0] = packet;
  anim_loop_packet(guypackets, anime, ender, "generic");
}

function anim_loop(guys, anime, ender, tag, var_656e3d548572faf6, animname_override) {
  guypackets = [];

  foreach(guy in guys) {
    packet = [];
    packet["guy"] = guy;
    packet["entity"] = self;
    packet["tag"] = tag;
    packet["origin_offset"] = var_656e3d548572faf6;
    guypackets[guypackets.size] = packet;
  }

  anim_loop_packet(guypackets, anime, ender, animname_override);
}

function anim_loop_packet_solo(singleguypacket, anime, ender, animname_override) {
  looppacket = [];
  looppacket[0] = singleguypacket;
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
  assertex(!isDefined(level.scr_xcam[anime]), "Xcams shouldn't be used in looping animations.");

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

  thread looping_anim_ender(baseguy, ender, anime);

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

    assertex(ai == 1, "Loop anims with _nags should only be done with one AI");

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
    setdvarifuninitialized(@ "hash_e35578a601bcd680", 0);
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
    scriptedsoundindex = undefined;
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
        assertmsg("<dev string:x8a>" + guy getentitynumber() + "<dev string:x96>" + anime + "<dev string:xb4>");
        abandonloop = 1;
        break;
      }

      if(doanimation) {
        guy scripts\common\visibility_mode::function_d5f76e611c78509a();
        animtime = guy[[anim.callbacks["DoAnimation"]]](org, angles, animname, anime, anim_string, idleanim, undefined);

        if(animtime < scriptedanimationtime) {
          scriptedanimationtime = animtime;
          scriptedanimationindex = i;
        }
      }

      if(!issp()) {
        if(!isPlayer(guy) && !isagent(guy) && !guy isvehicle() && !isDefined(guy.vehiclename) && isDefined(level.scr_anim[animname]) && isDefined(level.scr_anim[animname][anime]) && isDefined(level.scr_anim[animname][anime][idleanim])) {
          guy self_func("scriptModelPlayAnim", level.scr_anim[animname][anime][idleanim], undefined, undefined, undefined, function_4a2dd4b9088bd637(animname, anime));
        }
      }

      if(dofacialanim || dodialogue) {
        guy[[anim.callbacks["DoFacialAnim"]]](dofacialanim, dodialogue, doanimation, anime, animname, dialogue, 1);
        scriptedsoundindex = i;
      }

      if(dotext && !dodialogue) {
        guy thread[[anim.callbacks["<dev string:x80>"]]](level.scr_text[animname][anime]);
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
    } else if(isDefined(scriptedsoundindex)) {
      guypackets[scriptedsoundindex]["guy"] waittill(anim_string);
    }

    if(abandonloop) {
      break;
    }
  }
}

function waittill_animend(guy, animstring, hasnags) {
  if(istrue(hasnags)) {
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
    if(getdvarint(@ "hash_e35578a601bcd680")) {
      print3d(guy.origin + (0, 0, 70), temp + "<dev string:xc8>", (1, 1, 0.5), 1, 0.6, 20);
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
  array_thread(guys, &anim_self_set_time, anime, time);
}

function anim_self_set_time(anime, time) {
  animation = getanim(anime);

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
      assertmsg("ai not supported by anim_moveto");
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
    array = array_remove_index(array, index);
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
    if(!isDefined(level.flag) || !isDefined(level.flag[theflag])) {
      flag_init(theflag);
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

  if(!isDefined(level.flag) || !isDefined(level.flag[theflag])) {
    flag_init(theflag);
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

function addnotetrack_startfxontag(animname, notetrack, anime, effect_name, tagname, morethanthreehack) {
  getfx(effect_name);
  notetrack = tolower(notetrack);
  anime = get_generic_anime(anime);
  index = add_notetrack_and_get_index(animname, notetrack, anime);
  array = [];
  array["effect"] = effect_name;
  array["selftag"] = tagname;

  if(isDefined(morethanthreehack)) {
    array["moreThanThreeHack"] = morethanthreehack;
  }

  level.scr_notetrack[animname][anime][notetrack][index] = array;
}

function addnotetrack_stopFXOnTag(animname, notetrack, anime, effect_name, tagname) {
  getfx(effect_name);
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
  add_fx(effect_path, effect_path);
  addnotetrack_swapparttoefx(scenedata.animname, notetrack, scenedata.animsequence, effect_path, tagname);
}

function note_track_stop_efx_on_tag(notetrack, effect_path, tagname) {
  scenedata = get_datascene();
  add_fx(effect_path, effect_path);
  addnotetrack_stopFXOnTag(scenedata.animname, notetrack, scenedata.animsequence, effect_path, tagname);
}

function addnotetrack_swapparttoefx(animname, notetrack, anime, effect_name, tagname) {
  getfx(effect_name);
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

  if(notetrack != "start" && !animhasnotetrack(scenedata getanim(scenedata.anim_sequence), notetrack)) {
    println("<dev string:xd8>" + scenedata.anim_sequence + "<dev string:xf4>" + notetrack);
    return;
  }

  add_fx(effect_path, effect_path);

  if(isDefined(waterfx_path)) {
    add_fx(waterfx_path, waterfx_path);
  }

  addnotetrack_tracepartforefx(scenedata.animname, notetrack, canceltrack, scenedata.anim_sequence, tagname, effect_path, waterfx_path, delete_depth);
}

function note_track_start_fx_on_tag(notetrack, tagname, effect_path) {
  scenedata = get_datascene();

  if(notetrack != "start" && !animhasnotetrack(scenedata getanim(scenedata.anim_sequence), notetrack)) {
    println("<dev string:x10f>" + scenedata.anim_sequence + "<dev string:xf4>" + notetrack);
    return;
  }

  add_fx(effect_path, effect_path);
  addnotetrack_startfxontag(scenedata.animname, notetrack, scenedata.anim_sequence, effect_path, tagname, 1);
}

function get_datascene() {
  assertex(isDefined(level.current_anim_data_scene));
  scenedata = level.current_anim_data_scene;
  assertex(isDefined(scenedata.animtree), "Missing calling scene, Must use create_anim_scene() ");
  return scenedata;
}

function addnotetrack_tracepartforefx(animname, notetrack, canceltrack, anime, tagname, effect_name, waterfx_name, delete_depth) {
  getfx(effect_name);
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
  create_lock("moreThanThreeHack", 3);
  create_lock("trace_part_for_efx", 12);

  setdevdvarifuninitialized(@ "hash_b46df2b57cc019b", 0);

  init_animsounds();

  level thread function_65e9f4b64110bb5c();
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
    assertex(isarray(level.scr_weapon[weapons[i]]), weapons[i] + ": scr_weapon needs to be defined as an array!");
    attachments = [];

    if(isDefined(level.scr_weapon[weapons[i]][1])) {
      assertex(isarray(level.scr_weapon[weapons[i]][1]), "scr_weapon attachments need to be defined as an array!");
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

    scripts\common\visibility_mode::function_b6e23e71bb7ad50f(guy);
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

function anim_animationendnotify(guy, anime, scriptedanimationtime, var_9e8a16d47a03007a) {
  self endon(anime);
  guy endon("death");
  scriptedanimationtime -= var_9e8a16d47a03007a;

  if(var_9e8a16d47a03007a > 0 && scriptedanimationtime > 0) {
    guy waittill_match_or_timeout("single anim", "end", scriptedanimationtime);
    guy stopanimScripted();
  } else {
    guy waittillmatch("single anim", "end");
  }

  self notify(anime);
}

function anim_weight(animname, anime) {
  assertex(isDefined(level.scr_anim[animname][anime]), "There is no animation scene \"" + anime + "\" for animname " + animname);
  assertex(isarray(level.scr_anim[animname][anime]), "the animation entry for level.scr_anim[ " + animname + " ][ " + anime + " ] needs to be an array of looping animations, not a single animation");
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

function function_d2e8597ff01310ed(xanim, tag, time, baseorigin, baseangles) {
  result = self function_bbf5cb43caa911b7(xanim, tag, time);

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
    assertmsg("Animating character of type " + self.classname + " has no animname.");
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

      println("<dev string:x125>" + animname + "<dev string:x13d>");

      foreach(member in array) {
        println(member);
      }
    }

    if(has_sound) {
      array = getarraykeys(level.scr_sound[animname]);

      println("<dev string:x13f>" + animname + "<dev string:x13d>");

      foreach(member in array) {
        println(member);
      }
    }

    if(has_face) {
      array = getarraykeys(level.scr_face[animname]);

      println("<dev string:x15b>" + animname + "<dev string:x13d>");

      foreach(member in array) {
        println(member);
      }
    }

    assertmsg("<dev string:x176>" + function_a2eaafb222316a2(self) + "<dev string:x3e>" + animname + "<dev string:x4f>" + anime + "<dev string:x179>");
    return;
  }

  keys = getarraykeys(level.scr_anim);
  keys = array_combine(keys, getarraykeys(level.scr_sound));

  foreach(key in keys) {
    println(key);
  }

  assertmsg("Animname " + animname + " is not setup to do animations. See above for list of legal animnames.");
}

function printloops(guy, anime) {
  if(!isDefined(guy)) {
    return;
  }

  guy endon("<dev string:x1b9>");
  waittillframeend();
  guy.loops++;

  if(guy.loops > 0) {
    guy.loopanims[guy.loopanims.size] = anime;
  }

  if(guy.loops > 1) {
    println("<dev string:x1bf>" + guy.animname + "<dev string:x1d0>" + guy.loops + "<dev string:x1d6>");

    for(i = 0; i < guy.loopanims.size; i++) {
      println("<dev string:x1f3>" + guy.loopanims[i]);
    }

    assertmsg("<dev string:x1fc>");
  }
}

function looping_anim_ender(guy, ender, anime) {
  guy endon("<dev string:x1b9>");
  self waittill(ender);
  guy.loopanims = array_remove(guy.loopanims, anime);
  guy.loops--;
}

function anim_single_failsafeonguy(owner, anime) {
  if(getDvar(@ "hash_27494f1d75fc0809") != "<dev string:x23c>") {
    return;
  }

  owner endon(anime);
  owner endon("<dev string:x1b9>");
  self endon("<dev string:x1b9>");
  name = self.classname;
  num = self getentitynumber();
  wait 60;
  println("<dev string:x23f>" + name + "<dev string:x254>" + num);
  waittillframeend();
  assertex(0, "<dev string:x261>" + anime + "<dev string:x26d>");
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

  return 0.5;
}

function function_89b3eabd606fcda3(animation) {
  if(utility::issp()) {
    return 0.5;
  }

  return 0;
}

function function_f1e7ee8ddeece062(anime) {
  if(utility::issp() && isDefined(level.scr_entrances) && istrue(level.scr_entrances[anime])) {
    return true;
  }

  return false;
}

function function_1eba925251530689(guys, anime) {
  if(function_f1e7ee8ddeece062(anime) && guys.size > 1) {
    foreach(guy in guys) {
      if(!isDefined(guy.animname) || !guy function_9c6a9b923786f602(guy.animname) && !guy function_84a46f10a88351cd(guy.animname)) {
        guys = array_remove(guys, guy);
        guys = array_add(guys, guy);
      }
    }
  }

  return guys;
}

function function_56bd620e57a834af(anime, animname, animation) {
  newanime = anime + "_entrance";
  level.scr_anim[animname][newanime] = animation;
  return newanime;
}

function function_c099f6fd9c19f5a6(anime, org, angles, animname) {
  setdvarifuninitialized(@ "hash_4140c00f3efa94c6", 0);

  if(function_9c6a9b923786f602(animname)) {
    return function_96b3d74019cd30a(anime, org, angles, animname);
  } else if(function_84a46f10a88351cd(animname)) {
    return function_1ed6444c29da9045(anime, org, angles, animname);
  }

  if(!isDefined(level.var_ac0205cb091a126e)) {
    level.var_ac0205cb091a126e = 0;

    if(getdvarint(@ "hash_4140c00f3efa94c6", 0)) {
      iprintln("<dev string:x29f>");
    }
  }

  if(isarray(level.scr_anim[animname][anime])) {
    return level.scr_anim[animname][anime][level.var_ac0205cb091a126e];
  }

  return level.scr_anim[animname][anime];
}

function function_96b3d74019cd30a(anime, org, angles, animname) {
  if(isDefined(level.var_ac0205cb091a126e) && istrue(level.var_99364109f9f9b3f4) && level.var_99364109f9f9b3f4 == gettime()) {
    return level.scr_anim[animname][anime][level.var_ac0205cb091a126e];
  }

  closest_anim = 0;
  closest_dist = undefined;
  level.var_ac0205cb091a126e = undefined;

  foreach(animation in level.scr_anim[animname][anime]) {
    neworg = getstartorigin(org, angles, animation);

    if(getdvarint(@ "hash_4140c00f3efa94c6", 0)) {
      line(self.origin, neworg, (1, 1, 1), 1, 0, 1000);
      print3d(neworg + (0, 0, 2), animation, (1, 1, 1), 1, 0.075, 1000, 1);
      print3d(neworg, "<dev string:x2c4>", (1, 1, 1), 1, 0.2, 1000, 1);
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
    iprintln("<dev string:x2c6>" + animation);
  }

  level.var_99364109f9f9b3f4 = gettime();
  level.var_ac0205cb091a126e = closest_anim;
  return animation;
}

function function_1ed6444c29da9045(anime, org, angles, animname) {
  level.var_ac0205cb091a126e = undefined;
  animation = level.scr_anim[animname][anime][0];
  level.var_ac0205cb091a126e = 0;
  return animation;
}

function function_84a46f10a88351cd(animname) {
  if(isDefined(level.scr_animtree[animname]) && level.scr_animtree[animname] == #animtree) {
    return true;
  }

  return false;
}

function function_9c6a9b923786f602(animname) {
  return [[anim.callbacks["CheckPlayerAnimtree"]]](animname);
}

function function_2c88f6e05af61090(animation) {
  if(!animhasnotetrack(animation, "blend_into")) {
    return 0;
  }

  return get_notetrack_time(animation, "blend_into");
}

function function_f92de130e8613662(animation) {
  if(!animhasnotetrack(animation, "blend_out")) {
    return undefined;
  }

  return get_notetrack_time(animation, "blend_out");
}

function function_70b77e26541e095(animation) {
  speed = 128;

  if(animhasnotetrack(animation, "blend_speed = walk")) {
    speed = 128;
  } else if(animhasnotetrack(animation, "blend_speed = run")) {
    speed = 145;
  }

  return speed * 0.7;
}

function function_48af09f152896047(animation) {
  stances = [];

  if(animhasnotetrack(animation, "start_stance = stand")) {
    stances = array_add(stances, "stand");
  } else if(animhasnotetrack(animation, "start_stance = crouch")) {
    stances = array_add(stances, "crouch");
  } else if(animhasnotetrack(animation, "start_stance = prone")) {
    stances = array_add(stances, "prone");
  } else {
    stances = array_add(stances, "none");
  }

  if(animhasnotetrack(animation, "end_stance = stand")) {
    stances = array_add(stances, "stand");
  } else if(animhasnotetrack(animation, "end_stance = crouch")) {
    stances = array_add(stances, "crouch");
  } else if(animhasnotetrack(animation, "end_stance = prone")) {
    stances = array_add(stances, "prone");
  } else {
    stances = array_add(stances, "none");
  }

  return stances;
}

function function_d0fafbacba98a40f(playerpos, animstartpos, blendspeed, blendintotime, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous) {
  var_ec165a067af34f8f = ter_op(isDefined(var_ec165a067af34f8f), var_ec165a067af34f8f, 1);
  var_8831fc7320076829 = ter_op(isDefined(var_8831fc7320076829), var_8831fc7320076829, 0);
  simultaneous = ter_op(isDefined(simultaneous), simultaneous, 0);
  assertex(!(var_ec165a067af34f8f && var_8831fc7320076829), "dropWeaponWithGesture and dropWeaponWithAnim can not both be true.");

  if(istrue(var_ec165a067af34f8f)) {
    weapondroptime = level.player getgestureanimlength("proto_vm_gesture_gun_drop");
  } else if(istrue(var_8831fc7320076829)) {
    weapondroptime = 0.5;
  } else {
    weapondroptime = 0;
  }

  weapondropquick = 0;

  if(istrue(simultaneous)) {
    weapondropquick = 1;
    weapondroptime = 0;
  } else if(level.player getdemeanorviewmodel() == "relaxed") {
    weapondropquick = 1;
    weapondroptime = 0.2;
  }

  blendtimecalc = distance2d(playerpos, animstartpos) / blendspeed;
  idealblendtime = blendintotime + weapondroptime;

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    iprintln("<dev string:x2dd>" + blendtimecalc);
  }

  if(blendintotime > 0) {
    frac = blendtimecalc / idealblendtime;

    if(frac < 1.4 && frac > 0.4) {
      blendtime = idealblendtime;
    } else if(blendtimecalc < blendintotime) {
      blendtime = ter_op(blendintotime < 1, blendintotime + weapondroptime, 1 + weapondroptime);
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
      iprintln("<dev string:x2f4>");
    }

    weapondroptime = blendtime - blendintotime;
  }

  level.blendinfo["weaponDropQuick"] = weapondropquick;
  level.blendinfo["weaponDropTime"] = weapondroptime;
  return blendtime;
}

function function_309bb9de5db13227(playerpos, animstartpos, blendspeed, blendintotime, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous) {
  var_ec165a067af34f8f = ter_op(isDefined(var_ec165a067af34f8f), var_ec165a067af34f8f, 1);
  var_8831fc7320076829 = ter_op(isDefined(var_8831fc7320076829), var_8831fc7320076829, 0);
  simultaneous = ter_op(isDefined(simultaneous), simultaneous, 0);

  if(!var_8831fc7320076829) {
    quickdroptime = 0;
    normaldroptime = 0;
  } else {
    quickdroptime = 0.2;

    if(var_ec165a067af34f8f) {
      normaldroptime = level.player getgestureanimlength("proto_vm_gesture_gun_drop");
    } else {
      normaldroptime = 0.5;
    }
  }

  blendtime = distance2d(playerpos, animstartpos) / blendspeed;

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    iprintln("<dev string:x2dd>" + blendtime);
  }

  idealblendtime = blendintotime + normaldroptime;

  if(idealblendtime > 0) {
    frac = blendtime / idealblendtime;

    if(frac < 1.4 && frac > 0.4) {
      blendtime = idealblendtime;
    } else if(blendtime < blendintotime) {
      blendtime = ter_op(blendintotime <= 1, blendintotime, 1);
    }
  }

  if(istrue(var_ec165a067af34f8f) && istrue(var_8831fc7320076829)) {
    blendtime = ter_op(blendtime < normaldroptime, normaldroptime, blendtime);
  } else if(!istrue(var_8831fc7320076829)) {
    blendtime = ter_op(blendtime < 0.5, 0.5, blendtime);
  } else {
    blendtime = ter_op(blendtime < quickdroptime, quickdroptime, blendtime);
  }

  weapondropquick = 0;
  weapondroptime = normaldroptime;

  if(blendtime < normaldroptime || level.player getdemeanorviewmodel() == "relaxed") {
    weapondropquick = 1;
    weapondroptime = quickdroptime;
  } else if(blendtime > idealblendtime) {
    if(getdvarint(@ "hash_398da46238160a6", 0)) {
      iprintln("<dev string:x2f4>");
    }

    weapondroptime = blendtime - blendintotime;
  }

  if(istrue(simultaneous)) {
    weapondropquick = 1;
    weapondroptime = 0;
  }

  level.blendinfo["weaponDropQuick"] = weapondropquick;
  level.blendinfo["weaponDropTime"] = weapondroptime;
  return blendtime;
}

function function_dba8ec1939d3f1a(anime, animname, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous) {
  if(function_f1e7ee8ddeece062(anime)) {
    animation = function_c099f6fd9c19f5a6(anime, self.origin, self.angles, animname);
  } else {
    animation = level.scr_anim[animname][anime];
  }

  function_1d134c1e220fb6d7(animation, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous);
}

function function_1d134c1e220fb6d7(animation, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous) {
  animpos = getstartorigin(self.origin, self.angles, animation);
  level.blendinfo = [];
  blendintotime = function_2c88f6e05af61090(animation);
  blendouttime = function_f92de130e8613662(animation);
  blendspeed = function_70b77e26541e095(animation);
  blendtime = function_d0fafbacba98a40f(level.player.origin, animpos, blendspeed, blendintotime, var_ec165a067af34f8f, var_8831fc7320076829, simultaneous);
  stances = function_48af09f152896047(animation);
  level.blendinfo["blendIntoTime"] = blendintotime;
  level.blendinfo["blendOutTime"] = blendouttime;
  level.blendinfo["blendSpeed"] = blendspeed;
  level.blendinfo["blendTime"] = blendtime;
  level.blendinfo["stances"] = stances;

  if(getdvarint(@ "hash_398da46238160a6", 0)) {
    iprintln("<dev string:x345>" + blendtime);
    iprintln("<dev string:x351>" + blendintotime);

    if(isDefined(blendouttime)) {
      iprintln("<dev string:x361>" + blendouttime);
    }

    iprintln("<dev string:x370>" + level.blendinfo["<dev string:x381>"]);
    iprintln("<dev string:x390>" + level.blendinfo["<dev string:x39a>"][0] + "<dev string:x3a2>" + level.blendinfo["<dev string:x39a>"][1]);
  }
}

function function_5cffe82f5e70231b(bool) {
  assertex(isDefined(bool), "Must pass a bool!");

  if(istrue(bool)) {
    self.animscripted_collision = 1;
    return;
  }

  self.animscripted_collision = undefined;
}

function function_6bc36c81fc28a22e() {
  if(istrue(self.animscripted_collision)) {
    return true;
  }

  return false;
}

function function_1cb661b457551a3(bool, velocityent, blendtime) {
  assertex(isDefined(bool), "Must pass a bool!");

  if(istrue(bool)) {
    assertex(isDefined(velocityent), "Must pass an ent for velocity!");
    self.var_a986b9d4a1be703b = 1;
    self.var_f1a075b476ca91f1 = velocityent getvelocity();

    if(isDefined(blendtime)) {
      self.var_37b96012304143d7 = blendtime;
    } else {
      self.var_37b96012304143d7 = 0.2;
    }

    return;
  }

  self.var_a986b9d4a1be703b = undefined;
  self.var_f1a075b476ca91f1 = undefined;
  self.var_37b96012304143d7 = undefined;
}

function function_e42b762e098c8f9e() {
  if(istrue(self.var_a986b9d4a1be703b) && isDefined(self.var_f1a075b476ca91f1) && isDefined(self.var_37b96012304143d7)) {
    return true;
  }

  return false;
}

function function_52351c3338da63f4(animcategory, animindex) {
  assertex(isDefined(animcategory) && isDefined(animindex), "<dev string:x3a5>");
  animlength = 0;

  if(isDefined(level.scr_animlength) && isDefined(level.scr_animlength[animcategory]) && isDefined(level.scr_animlength[animcategory][animindex])) {
    animlength = level.scr_animlength[animcategory][animindex];
  } else if(isDefined(level.scr_anim) && isDefined(level.scr_anim[animcategory]) && isDefined(level.scr_anim[animcategory][animindex])) {
    animlength = getanimlength(level.scr_anim[animcategory][animindex]);
  } else {
    assertmsg("<dev string:x3db>");
  }

  return animlength;
}

function function_65e9f4b64110bb5c() {
  while(true) {
    requestflag = getdvarint(@ "hash_300079a74221ae45", 0);

    if(requestflag != 0) {
      origin = (0, 0, 0);
      angles = (0, 0, 0);
      align_target = getDvar(@ "hash_43022f85e8f590a5");
      align_tag = getDvar(@ "hash_9dfd128a6efc97b4");
      aligntarget = getent_or_struct(align_target, "<dev string:x464>");

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

function function_dca1a3a29d2ee467(guys_with_anims, speed_baseline) {
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
  debugstartpos = 0;

  debugstartpos = getDvar(@ "hash_34dab4f8f3a04f4a") == "<dev string:x23c>";

  threads = 0;
  guys = [];

  foreach(guy_anim in guys_with_anims) {
    guy = guy_anim[0];
    animation = guy_anim[1];
    alignment = guy_anim[2];
    var_93e32c180cab35b3 = guy_anim[3];
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

    if(!isDefined(var_93e32c180cab35b3)) {
      var_93e32c180cab35b3 = arrival_type;
    }

    if(isDefined(var_93e32c180cab35b3)) {
      if(isDefined(guy.scriptedarrivalent)) {
        guy.scriptedarrivalent delete();
        guy.scriptedarrivalent = undefined;
      }

      guy.scriptedarrivalent = spawn("script_origin", startorg);
      guy.scriptedarrivalent.angles = startangles;
      guy.scriptedarrivalent.type = var_93e32c180cab35b3;
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
    level notify("<dev string:x46f>" + "<dev string:x471>");
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
  waittill_either("death", "goal");

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

  if((!isDefined(self.scriptedarrivalent) || !isDefined(self.scriptedarrivalent.type)) && distance2dsquared(startorg, self.origin) > 2500) {
    forward = anglesToForward(startangles);
    var_b88bb2e631bcc2b3 = startorg - forward * 50;

    if(navisstraightlinereachable(startorg, var_b88bb2e631bcc2b3, self)) {
      points[points.size] = var_b88bb2e631bcc2b3;
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

function anim_reach_speed_control(guys_with_anims, speed_baseline, var_ad86b98c8c9def3d) {
  waittillframeend();
  speed_baseline = default_to(speed_baseline, 140);
  var_ad86b98c8c9def3d = default_to(var_ad86b98c8c9def3d, 4);

  foreach(index, guy_anim in guys_with_anims) {
    guy = guy_anim[0];
    var_93e32c180cab35b3 = guy_anim[3];
    moving_destination = isDefined(var_93e32c180cab35b3) && var_93e32c180cab35b3 == "Exposed Moving";
    track_speed = moving_destination;

    track_speed = track_speed || getdvarint(@ "scr_debug_reach");

    if(track_speed) {
      guy childthread anim_reach_speed_control_avg(var_ad86b98c8c9def3d, speed_baseline);
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
      var_93e32c180cab35b3 = guy_anim[3];
      moving_destination = isDefined(var_93e32c180cab35b3) && var_93e32c180cab35b3 == "Exposed Moving";

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
          print3d(guy.origin + (0, 0, 36), "<dev string:x480>", (0, 1, 0), 1, 0.3, 1, 1);
        }

        line(guy.origin, guy.goalpos, (1, 1, 1), 1, 0, 1);
        print3d(guy.origin, "<dev string:x1c>" + int(speed_baseline), (0, 1, 0), 1, 0.3, 1, 1);
        print3d(guy.origin + (0, 0, 10), "<dev string:x1c>" + int(desiredspeed), (1, 1, 1), 1, 0.3, 1, 1);

        if(isDefined(guy.reachspeed)) {
          print3d(guy.origin + (0, 0, 20), "<dev string:x1c>" + int(guy.reachspeed.speed_avg), (0, 1, 1), 1, 0.3, 1, 1);
        }

        print3d(guy.origin + (0, 0, 80), "<dev string:x1c>" + speedscale, (0, 0, 1), 1, 0.3, 1, 1);
        print3d(guy.goalpos + (0, 0, 12), "<dev string:x1c>" + int(dist[index]), (0, 0, 1), 1, 1, 1, 1);
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

function anim_reach_speed_control_avg(var_ad86b98c8c9def3d, speed_baseline) {
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
    index = mod(curr, var_ad86b98c8c9def3d);
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

function private reach_with_standard_adjustments_begin(startorg, startangles) {
  assertex(isDefined(anim.callbacks["reach_with_standard_adjustments_begin"]), "You must define anim.callbacks[ reach_with_standard_adjustments_begin ] if you are first frame animating an AI");
  return self[[anim.callbacks["reach_with_standard_adjustments_begin"]]](startorg, startangles);
}

function private reach_with_standard_adjustments_end() {
  assertex(isDefined(anim.callbacks["reach_with_standard_adjustments_end"]), "You must define anim.callbacks[ reach_with_standard_adjustments_end ] if you are first frame animating an AI");
  self[[anim.callbacks["reach_with_standard_adjustments_end"]]]();
}