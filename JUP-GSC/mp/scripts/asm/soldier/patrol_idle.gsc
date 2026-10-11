/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\asm\soldier\patrol_idle.gsc
**************************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\soldier\death;
#using scripts\asm\soldier\patrol;
#using scripts\common\anim;
#using scripts\common\string;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace patrol_idle;

function patrol_idle_getcellphone() {
  modelname = "offhand_wm_smartphone_on";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_cellphone"])) {
    modelname = level.scr_model["idle_cellphone"];
  }

  return modelname;
}

function patrol_idle_init(asmname, statename, params) {
  self.newenemyreactiondistsq = 0;
  thread patrol_prop_waitfordelete();
}

function patrol_idle_cleanup(asmname, statename, params) {
  self.newenemyreactiondistsq = 262144;
  self function_f7cff9f6dafb297();

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }

  self notify("patrol_idle_complete");
}

function patrol_idle_istype(asmname, statename, tostatename, params) {
  assert(isDefined(params));
  assert(self._blackboard.idlenodeisvalid);
  assert(isDefined(self._blackboard.var_fe458d6a41146a8c));
  return self._blackboard.var_fe458d6a41146a8c == params;
}

function patrol_getcustomfunc(scenename, funcname) {
  if(isDefined(level.idle_funcs) && isDefined(level.idle_funcs[scenename])) {
    return level.idle_funcs[scenename][funcname];
  }

  return undefined;
}

function patrol_idle_getnotehandler(asmname, statename, params) {
  if(isDefined(self._blackboard.customidlenode)) {
    notehandler = patrol_getcustomfunc(self._blackboard.customidlenode, params + "_note");

    if(isDefined(notehandler)) {
      return notehandler;
    }
  }

  return asm_getnotehandler(asmname, statename);
}

function patrol_playanim(asmname, statename, params, notehandler, animrate) {
  self endon(statename + "_finished");
  patrolanim = asm_getanim(asmname, statename);
  patrolxanim = asm_getxanim(statename, patrolanim);

  if(isnumber(patrolanim)) {
    self aisetanim(statename, patrolanim, animrate);
  } else {
    assertex(utility::issp(), "<dev string:x1c>");
    blankindex = asm_lookupanimfromalias(statename, "blank");
    self aisetanim(statename, blankindex, animrate);
    self setflaggedanimrestart(statename, patrolanim, 1, animrate);
  }

  asm_playfacialanim(asmname, statename, patrolxanim);
  asm_donotetracks(asmname, statename, notehandler, statename);
}

function patrol_playidleintro(asmname, statename, params) {
  self animmode("zonly_physics", 0);
  desiredangle = self.angles[1];

  if(self._blackboard.idlenodeisvalid) {
    if(isDefined(self._blackboard.idlenodeangles)) {
      desiredangle = self._blackboard.idlenodeangles[1];
    } else {
      desiredangle = 0;
    }
  }

  self orientmode("face angle", desiredangle);
  notehandler = patrol_idle_getnotehandler(asmname, statename, "intro");
  patrol_playanim(asmname, statename, params, notehandler, 1);
}

function patrol_playidleloop(asmname, statename, params) {
  self endon(statename + "_finished");
  bodyknob = asm_getbodyknob();
  prevanim = bodyknob;
  notehandler = patrol_idle_getnotehandler(asmname, statename, "loop");

  while(true) {
    loopanim = asm_getanim(asmname, statename);

    if(isnumber(loopanim)) {
      self aisetanim(statename, loopanim);
    } else {
      assertex(utility::issp(), "<dev string:x4a>");
      blankindex = asm_lookupanimfromalias(statename, "blank");
      self aisetanim(statename, blankindex);
      self setflaggedanimrestart(statename, loopanim, 1, 0.2, 1);
    }

    loopxanim = asm_getxanim(statename, loopanim);
    asm_playfacialanim(asmname, statename, loopxanim);
    prevanim = loopanim;
    asm_donotetracks(asmname, statename, notehandler, statename);
  }
}

function patrol_chooseidlereact(asmname, statename, params) {
  reactyaw = 0;
  alias = scripts\asm\soldier\patrol::function_a23a26adcf97fdd0();

  if(isint(alias)) {
    alias = scripts\common\string::to_string(alias);
  }

  reactanim = asm_lookupanimfromalias(statename, alias);
  return reactanim;
}

function patrol_playidlereact(asmname, statename, params) {
  self endon(statename + "_finished");
  self function_f7cff9f6dafb297();
  patrolanim = asm_getanim(asmname, statename);
  notehandler = patrol_idle_getnotehandler(asmname, statename, "react");
  patrolxanim = asm_getxanim(statename, patrolanim);
  animrate = 1;

  if(isDefined(self.stealthreactendtime)) {
    animlength = getanimlength(patrolxanim);
    desiredlength = (self.stealthreactendtime - gettime()) / 2000;

    if(desiredlength < animlength) {
      if(desiredlength < 0.3) {
        desiredlength = 0.3;
      }

      animrate = animlength / desiredlength;
    }
  }

  if(isnumber(patrolanim)) {
    self aisetanim(statename, patrolanim, animrate);
  } else {
    assertex(utility::issp(), "<dev string:x78>");
    blankindex = asm_lookupanimfromalias(statename, "blank");
    self aisetanim(statename, blankindex, animrate);
    self setflaggedanimrestart(statename, patrolanim, 1, 0.2, animrate);
  }

  asm_playfacialanim(asmname, statename, patrolxanim);
  self function_df303d9c05757e6b(patrolanim, statename);
  asm_donotetracks(asmname, statename, notehandler, statename);
}

function patrol_playidleend(asmname, statename, params) {
  notehandler = patrol_idle_getnotehandler(asmname, statename, "end");
  self notify("smoking_end");
  patrol_playanim(asmname, statename, params, notehandler, 1);
}

function patrol_notehandler_smoking(note, statename) {
  note = getsubstr(note, 10);

  if(isstartstr(note, "attach")) {
    self.idle_fx = level.g_effect["cigarette_unlit"];
    playFXOnTag(self.idle_fx, self, "tag_accessory_right");
    return;
  }

  if(isstartstr(note, "light")) {
    self.idle_fx = level.g_effect["cigarette_lit"];
    playFXOnTag(self.idle_fx, self, "tag_accessory_right");
    stopFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
    playFX(level.g_effect["lighter_glow"], self gettagorigin("tag_accessory_right"));
    thread patrol_smoking_blowsmoke(statename);
    return;
  }

  if(isstartstr(note, "detach")) {
    stopFXOnTag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
    self.idle_fx = undefined;
    playFX(level.g_effect["cigarette_lit_toss"], self gettagorigin("tag_accessory_right"), anglesToForward(self gettagangles("tag_accessory_right")));
    return;
  }

  if(isstartstr(note, "face_goal")) {
    scripts\asm\soldier\patrol::handlefacegoalnotetrack(statename, note, undefined);
  }
}

function patrol_smoking_blowsmoke(statename) {
  self endon("smoking_end");
  self endon("death");

  while(true) {
    self.smoke_fx_ent = playFXOnTag(level.g_effect["cigarette_smoke"], self, "tag_eye");
    waittime = randomintrange(5, 8);
    wait waittime;

    if(isDefined(self.smoke_fx_ent)) {
      self.smoke_fx_ent delete();
      self.smoke_fx_ent = undefined;
    }
  }
}

function patrol_smoking_cleanup(asmname, statename, params) {
  self notify("smoking_end");

  if(isDefined(self.idle_fx)) {
    stopFXOnTag(self.idle_fx, self, "tag_accessory_right");
    self.idle_fx = undefined;
  }

  if(isDefined(self.smoke_fx_ent)) {
    self.smoke_fx_ent delete();
    self.smoke_fx_ent = undefined;
  }

  patrol_idle_cleanup(asmname, statename, params);
}

function patrol_notehandler_cellphone(note, statename) {
  self endon(statename + "_finished");

  switch (note) {
    case #"hash_2d1403e602f082a4":
      self.idle_prop = scripts\common\anim::anim_link_tag_model(patrol_idle_getcellphone(), "tag_accessory_right");
      wait 2;

      if(isDefined(self.idle_prop)) {
        playFXOnTag(level.g_effect["cellphone_glow"], self.idle_prop, "tag_origin");
      }

      break;
    case #"hash_682ec8b49fe7aa12":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
    case #"hash_2c250facc201a952":
      scripts\asm\soldier\patrol::handlefacegoalnotetrack(statename, note, undefined);
      break;
  }
}

function patrol_prop_cleanup(asmname, statename, params) {
  if(isDefined(self.idle_prop)) {
    if(![[self.fnisinstealthidle]]() || !isalive(self)) {
      launchforce = anglesToForward(self.angles);
      launchforce *= randomfloatrange(30, 45);
      forcex = launchforce[0];
      forcey = launchforce[1];
      forcez = randomfloatrange(80, 90);
      self.idle_prop unlink();
      self.idle_prop physicslaunchserver(self.idle_prop.origin, (forcex, forcey, forcez));
      self.idle_prop thread patrol_prop_delete();
      self.idle_prop = undefined;
      return;
    }

    if([[self.fnstealthisidlecurious]]()) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

function patrol_prop_delete() {
  wait 5;

  while(isalive(level.player) && distance2dsquared(level.player.origin, self.origin) < 160000) {
    wait 1;
  }

  self delete();
}

function patrol_notehandler_drinking(note, statename) {
  switch (note) {
    case #"hash_2d1403e602f082a4":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("p7_bottle_plastic_16oz_water", "tag_accessory_right");
      break;
    case #"hash_682ec8b49fe7aa12":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
    case #"hash_2c250facc201a952":
      scripts\asm\soldier\patrol::handlefacegoalnotetrack(statename, note, undefined);
      break;
  }
}

function patrol_playidlesittingloop(asmname, statename, params) {
  self endon(statename + "_finished");
  self animmode("noclip");
  groundpos = scripts\engine\utility::drop_to_ground(self._blackboard.idlenodeorigin, 8, -128);

  if(isDefined(params)) {
    assert(self._blackboard.idlenodeisvalid);
    assert(isDefined(level.fnanimatedprop_setup));
    [[level.fnanimatedprop_setup]]("idle_chair", params, groundpos, self._blackboard.idlenodeangles);
  }

  var_b95ecd0bf886bb98 = 1;
  bodyknob = asm_getbodyknob();
  prevanim = bodyknob;

  while(true) {
    loopanim = asm_getanim(asmname, statename);
    loopxanim = asm_getxanim(statename, loopanim);
    self aisetanim(statename, loopanim);
    asm_playfacialanim(asmname, statename, loopxanim);
    prevanim = loopanim;

    if(var_b95ecd0bf886bb98) {
      assert(self._blackboard.idlenodeisvalid);
      movedelta = getmovedelta(loopxanim);
      startpos = groundpos - rotatevector(movedelta, self._blackboard.idlenodeangles);
      self startcoverarrival(startpos, self._blackboard.idlenodeangles[1]);
      thread patrol_idlesitting_checkforcoverarrivalcomplete(statename, groundpos);
      var_b95ecd0bf886bb98 = 0;
    }

    asm_donotetracks(asmname, statename, asm_getnotehandler(asmname, statename), statename);
  }
}

function patrol_idlesitting_checkforcoverarrivalcomplete(statename, endpos) {
  self endon(statename + "_finished");

  while(true) {
    if(distance2dsquared(self.origin, endpos) < 4) {
      self finishcoverarrival();
      break;
    }

    waitframe();
  }
}

function patrol_playidlesittingloop_cleanup(asmname, statename, params) {
  self finishcoverarrival();
}

function patrol_playidlesittingloop_prop_cleanup(asmname, statename, params) {
  patrol_prop_cleanup(asmname, statename, params);
  patrol_playidlesittingloop_cleanup(asmname, statename, params);
}

function patrol_playidlesittingloop_sleeping(asmname, statename, params) {
  patrol_playidlesittingloop(asmname, statename, params);
}

function patrol_playidlesittingloop_sleeping_cleanup(asmname, statename, params) {
  patrol_playidlesittingloop_cleanup(asmname, statename, params);
}

function patrol_playidlesittingloop_cellphone(asmname, statename, params) {
  self.idle_prop = scripts\common\anim::anim_link_tag_model(patrol_idle_getcellphone(), "tag_accessory_right");
  playFXOnTag(level.g_effect["cellphone_glow"], self.idle_prop, "tag_origin");
  patrol_playidlesittingloop(asmname, statename, params);
}

function patrol_playidlesittingloop_laptop(asmname, statename, params) {
  patrol_playidlesittingloop(asmname, statename, params);
}

function patrol_playidlesittingloop_pistolclean(asmname, statename, params) {
  self.idle_prop = scripts\common\anim::anim_link_tag_model("weapon_wm_pi_mike1911_phys", "tag_accessory_right");
  patrol_playidlesittingloop(asmname, statename, params);
}

function patrol_playdeathanim_sitting(asmname, statename, params) {
  if(isDefined(self.animated_prop)) {
    assert(isDefined(level.fnanimatedprop_startanim));
    self[[level.fnanimatedprop_startanim]]("idle_chair", params);
  }

  scripts\asm\soldier\death::playdeathanim(asmname, statename);
}

function patrol_playidlesittingreact(asmname, statename, params) {
  self animmode("noclip");

  if(isDefined(params)) {
    self[[level.fnanimatedprop_setanim]]("idle_chair", params);
  }

  asm_playanimstate(asmname, statename);
}

function patrol_hascustomanim(asmname, statename, tostatename, params) {
  if(isDefined(self._blackboard.customidlenode)) {
    scenename = self._blackboard.customidlenode;
  } else {
    scenename = self._blackboard.var_fe458d6a41146a8c;
  }

  assert(isDefined(scenename));
  return isDefined(level.scr_anim["patrol_idle"]) && isDefined(level.scr_anim["patrol_idle"][scenename]) && isDefined(level.scr_anim["patrol_idle"][scenename][params]);
}

function patrol_iscustomanimdefaultvalue(asmname, statename, tostatename, params) {
  if(isDefined(self._blackboard.customidlenode)) {
    scenename = self._blackboard.customidlenode;
  } else {
    scenename = self._blackboard.var_fe458d6a41146a8c;
  }

  assert(isDefined(scenename));
  assert(isDefined(level.scr_anim["<dev string:xaa>"]) && isDefined(level.scr_anim["<dev string:xaa>"][scenename]) && isDefined(level.scr_anim["<dev string:xaa>"][scenename][params]));
  return isnumber(level.scr_anim["patrol_idle"][scenename][params]);
}

function patrol_chooseanim_custom(asmname, statename, params) {
  assert(isDefined(self._blackboard.customidlenode));
  scenename = self._blackboard.customidlenode;
  state = params;
  assert(isDefined(scenename));
  assert(isDefined(level.scr_anim));
  assert(isDefined(level.scr_anim["<dev string:xaa>"]), "<dev string:xb9>" + scenename + "<dev string:xe7>" + "<dev string:xaa>" + "<dev string:xff>");
  assert(isDefined(level.scr_anim["<dev string:xaa>"][scenename]), "<dev string:xb9>" + scenename + "<dev string:xe7>" + "<dev string:xaa>" + "<dev string:xff>");
  assert(isDefined(level.scr_anim["<dev string:xaa>"][scenename][state]), "<dev string:x10c>" + state + "<dev string:xe7>" + "<dev string:xaa>" + "<dev string:x12f>" + scenename + "<dev string:xff>");

  if(isarray(level.scr_anim["patrol_idle"][scenename][state])) {
    numanims = level.scr_anim["patrol_idle"][scenename][state].size;
    assert(numanims > 0);

    if(numanims > 1) {
      if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]()) {
        if(isDefined(self.var_bb3bab49c9a764a4)) {
          if(self.var_f97ff24102472069 == "investigate") {
            return level.scr_anim["patrol_idle"][scenename][state][0];
          }
        }
      }

      return level.scr_anim["patrol_idle"][scenename][state][1];
    } else {
      return level.scr_anim["patrol_idle"][scenename][0];
    }

    return;
  }

  return level.scr_anim["patrol_idle"][scenename][state];
}

function patrol_idle_custom_init(asmname, statename, params) {
  assert(self._blackboard.idlenodeisvalid);
  assert(isDefined(self._blackboard.var_fe458d6a41146a8c));
  self._blackboard.customidlenode = self._blackboard.var_fe458d6a41146a8c;
  patrol_idle_init(asmname, statename, params);
}

function patrol_idle_custom_cleanup(asmname, statename, params) {
  patrol_idle_cleanup(asmname, statename, params);
  patrol_idle_callcustomcallback("cleanup");

  if(isalive(self)) {
    self._blackboard.customidlenode = undefined;
  }
}

function patrol_idle_callcustomcallback(funcname) {
  if(isDefined(level.idle_funcs)) {
    assert(isDefined(self._blackboard.customidlenode));
    scenename = self._blackboard.customidlenode;

    if(isDefined(level.idle_funcs[scenename]) && isDefined(level.idle_funcs[scenename][funcname])) {
      self thread[[level.idle_funcs[scenename][funcname]]]();
    }
  }
}

function patrol_playidleintro_custom(asmname, statename, params) {
  patrol_idle_callcustomcallback("intro_begin");
  patrol_playidleintro(asmname, statename, params);
}

function patrol_playidleloop_custom(asmname, statename, params) {
  patrol_idle_callcustomcallback("loop_begin");
  patrol_playidleloop(asmname, statename, params);
}

function patrol_playidlereact_custom(asmname, statename, params) {
  patrol_idle_callcustomcallback("react_begin");
  patrol_playidlereact(asmname, statename, params);
}

function patrol_playidleend_custom(asmname, statename, params) {
  patrol_idle_callcustomcallback("exit_begin");
  patrol_playidleend(asmname, statename, params);
}

function patrol_playidle_custom_terminate(asmname, statename, params) {
  assert(isDefined(self._blackboard.customidlenode));
  assert(isDefined(params));
  patrol_idle_callcustomcallback(params + "_end");
}

function patrol_prop_waitfordelete() {
  self endon("patrol_idle_complete");
  self waittill("entitydeleted");

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
  }
}