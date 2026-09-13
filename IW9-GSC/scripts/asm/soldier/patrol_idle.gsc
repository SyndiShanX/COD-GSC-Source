/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\patrol_idle.gsc
***********************************************/

patrol_idle_getcellphone() {
  modelname = "offhand_wm_smartphone_on";

  if(isDefined(level.scr_model) && isDefined(level.scr_model["idle_cellphone"]))
    modelname = level.scr_model["idle_cellphone"];

  return modelname;
}

patrol_idle_init(asmname, statename, params) {
  self.newenemyreactiondistsq = 0;
  thread patrol_prop_waitfordelete();
}

patrol_idle_cleanup(asmname, statename, params) {
  self.newenemyreactiondistsq = 262144;
  self _meth_0F7CFF9F6DAFB297();

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }

  self notify("patrol_idle_complete");
}

patrol_idle_istype(asmname, statename, _id_F2B19B25D457C2A6, params) {
  return self._blackboard._id_FE458D6A41146A8C == params;
}

patrol_getcustomfunc(_id_0E25D1D189177A7C, _id_EA847593E957F2B0) {
  if(isDefined(level.idle_funcs) && isDefined(level.idle_funcs[_id_0E25D1D189177A7C]))
    return level.idle_funcs[_id_0E25D1D189177A7C][_id_EA847593E957F2B0];

  return undefined;
}

patrol_idle_getnotehandler(asmname, statename, params) {
  if(isDefined(self._blackboard.customidlenode)) {
    _id_3931FF7E891D898F = patrol_getcustomfunc(self._blackboard.customidlenode, params + "_note");

    if(isDefined(_id_3931FF7E891D898F))
      return _id_3931FF7E891D898F;
  }

  return scripts\asm\asm::asm_getnotehandler(asmname, statename);
}

patrol_playanim(asmname, statename, params, _id_3931FF7E891D898F, _id_07B60BC0EAB3FD1E) {
  self endon(statename + "_finished");
  _id_B3795E278E36BA46 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_065F172F2B76BD30 = scripts\asm\asm::asm_getxanim(statename, _id_B3795E278E36BA46);

  if(isnumber(_id_B3795E278E36BA46))
    self aisetanim(statename, _id_B3795E278E36BA46, _id_07B60BC0EAB3FD1E);
  else {
    _id_0C8AAF5BC74C22BB = scripts\asm\asm::asm_lookupanimfromalias(statename, "blank");
    self aisetanim(statename, _id_0C8AAF5BC74C22BB, _id_07B60BC0EAB3FD1E);
    self setflaggedanimrestart(statename, _id_B3795E278E36BA46, 1, _id_07B60BC0EAB3FD1E);
  }

  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_065F172F2B76BD30);
  scripts\asm\asm::asm_donotetracks(asmname, statename, _id_3931FF7E891D898F, statename);
}

patrol_playidleintro(asmname, statename, params) {
  self animmode("zonly_physics", 0);
  desiredangle = self.angles[1];

  if(self._blackboard._id_06FF150891BB0C47) {
    if(isDefined(self._blackboard._id_0227CC162483AA47))
      desiredangle = self._blackboard._id_0227CC162483AA47[1];
    else
      desiredangle = 0;
  }

  self orientmode("face angle", desiredangle);
  _id_3931FF7E891D898F = patrol_idle_getnotehandler(asmname, statename, "intro");
  patrol_playanim(asmname, statename, params, _id_3931FF7E891D898F, 1);
}

patrol_playidleloop(asmname, statename, params) {
  self endon(statename + "_finished");
  _id_D5C987658103BFFD = scripts\asm\asm::asm_getbodyknob();
  _id_F3716786BF084DD1 = _id_D5C987658103BFFD;
  _id_3931FF7E891D898F = patrol_idle_getnotehandler(asmname, statename, "loop");

  for(;;) {
    loopanim = scripts\asm\asm::asm_getanim(asmname, statename);

    if(isnumber(loopanim))
      self aisetanim(statename, loopanim);
    else {
      _id_0C8AAF5BC74C22BB = scripts\asm\asm::asm_lookupanimfromalias(statename, "blank");
      self aisetanim(statename, _id_0C8AAF5BC74C22BB);
      self setflaggedanimrestart(statename, loopanim, 1, 0.2, 1);
    }

    _id_76C92379ED351610 = scripts\asm\asm::asm_getxanim(statename, loopanim);
    scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_76C92379ED351610);
    _id_F3716786BF084DD1 = loopanim;
    scripts\asm\asm::asm_donotetracks(asmname, statename, _id_3931FF7E891D898F, statename);
  }
}

patrol_chooseidlereact(asmname, statename, params) {
  _id_C5E576CF2978534B = 0;
  alias = scripts\asm\soldier\patrol::_id_A23A26ADCF97FDD0();
  _id_93A2C35BC9547955 = scripts\asm\asm::asm_lookupanimfromalias(statename, alias);
  return _id_93A2C35BC9547955;
}

patrol_playidlereact(asmname, statename, params) {
  self endon(statename + "_finished");
  self _meth_0F7CFF9F6DAFB297();
  _id_B3795E278E36BA46 = scripts\asm\asm::asm_getanim(asmname, statename);
  _id_3931FF7E891D898F = patrol_idle_getnotehandler(asmname, statename, "react");
  _id_065F172F2B76BD30 = scripts\asm\asm::asm_getxanim(statename, _id_B3795E278E36BA46);
  _id_07B60BC0EAB3FD1E = 1;

  if(isDefined(self._id_AEBF462EC3F3362D)) {
    animlength = getanimlength(_id_065F172F2B76BD30);
    _id_E01C6C89A1EB3D21 = (self._id_AEBF462EC3F3362D - gettime()) / 2000;

    if(_id_E01C6C89A1EB3D21 < animlength) {
      if(_id_E01C6C89A1EB3D21 < 0.3)
        _id_E01C6C89A1EB3D21 = 0.3;

      _id_07B60BC0EAB3FD1E = animlength / _id_E01C6C89A1EB3D21;
    }
  }

  if(isnumber(_id_B3795E278E36BA46))
    self aisetanim(statename, _id_B3795E278E36BA46, _id_07B60BC0EAB3FD1E);
  else {
    _id_0C8AAF5BC74C22BB = scripts\asm\asm::asm_lookupanimfromalias(statename, "blank");
    self aisetanim(statename, _id_0C8AAF5BC74C22BB, _id_07B60BC0EAB3FD1E);
    self setflaggedanimrestart(statename, _id_B3795E278E36BA46, 1, 0.2, _id_07B60BC0EAB3FD1E);
  }

  scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_065F172F2B76BD30);
  self _meth_DF303D9C05757E6B(_id_B3795E278E36BA46, statename);
  scripts\asm\asm::asm_donotetracks(asmname, statename, _id_3931FF7E891D898F, statename);
}

patrol_playidleend(asmname, statename, params) {
  _id_3931FF7E891D898F = patrol_idle_getnotehandler(asmname, statename, "end");
  self notify("smoking_end");
  patrol_playanim(asmname, statename, params, _id_3931FF7E891D898F, 1);
}

patrol_notehandler_smoking(_id_A234A65C378F3289, statename) {
  _id_A234A65C378F3289 = getsubstr(_id_A234A65C378F3289, 10);

  if(isstartstr(_id_A234A65C378F3289, "attach")) {
    self.idle_fx = level.g_effect["cigarette_unlit"];
    playFXOnTag(self.idle_fx, self, "tag_accessory_right");
  } else if(isstartstr(_id_A234A65C378F3289, "light")) {
    self.idle_fx = level.g_effect["cigarette_lit"];
    playFXOnTag(self.idle_fx, self, "tag_accessory_right");
    stopFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
    playFX(level.g_effect["lighter_glow"], self gettagorigin("tag_accessory_right"));
    thread patrol_smoking_blowsmoke(statename);
  } else if(isstartstr(_id_A234A65C378F3289, "detach")) {
    stopFXOnTag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
    self.idle_fx = undefined;
    playFX(level.g_effect["cigarette_lit_toss"], self gettagorigin("tag_accessory_right"), anglesToForward(self gettagangles("tag_accessory_right")));
  } else if(isstartstr(_id_A234A65C378F3289, "face_goal"))
    scripts\asm\soldier\patrol::handlefacegoalnotetrack(statename, _id_A234A65C378F3289, undefined);
}

patrol_smoking_blowsmoke(statename) {
  self endon("smoking_end");
  self endon("death");

  for(;;) {
    self.smoke_fx_ent = playFXOnTag(level.g_effect["cigarette_smoke"], self, "tag_eye");
    waittime = randomintrange(5, 8);
    wait(waittime);

    if(isDefined(self.smoke_fx_ent)) {
      self.smoke_fx_ent delete();
      self.smoke_fx_ent = undefined;
    }
  }
}

patrol_smoking_cleanup(asmname, statename, params) {
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

patrol_notehandler_cellphone(_id_A234A65C378F3289, statename) {
  self endon(statename + "_finished");

  switch (_id_A234A65C378F3289) {
    case "attach":
      self.idle_prop = scripts\common\anim::anim_link_tag_model(patrol_idle_getcellphone(), "tag_accessory_right");
      wait 2;

      if(isDefined(self.idle_prop))
        playFXOnTag(level.g_effect["cellphone_glow"], self.idle_prop, "tag_origin");

      break;
    case "detach":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
    case "face_goal":
      scripts\asm\soldier\patrol::handlefacegoalnotetrack(statename, _id_A234A65C378F3289, undefined);
      break;
  }
}

patrol_prop_cleanup(asmname, statename, params) {
  if(isDefined(self.idle_prop)) {
    if(![[self.fnisinstealthidle]]() || !isalive(self)) {
      _id_363CD698CE6C69C1 = anglesToForward(self.angles);
      _id_363CD698CE6C69C1 = _id_363CD698CE6C69C1 * randomfloatrange(30, 45);
      _id_D43803BE5B18DDD8 = _id_363CD698CE6C69C1[0];
      _id_D43804BE5B18E00B = _id_363CD698CE6C69C1[1];
      _id_D43805BE5B18E23E = randomfloatrange(80, 90);
      self.idle_prop unlink();
      self.idle_prop physicslaunchserver(self.idle_prop.origin, (_id_D43803BE5B18DDD8, _id_D43804BE5B18E00B, _id_D43805BE5B18E23E));
      self.idle_prop thread patrol_prop_delete();
      self.idle_prop = undefined;
    } else if([[self.fnstealthisidlecurious]]()) {
      self.idle_prop delete();
      self.idle_prop = undefined;
    }
  }
}

patrol_prop_delete() {
  wait 5;

  while(isalive(level.player) && distance2dsquared(level.player.origin, self.origin) < 160000)
    wait 1;

  self delete();
}

patrol_notehandler_drinking(_id_A234A65C378F3289, statename) {
  switch (_id_A234A65C378F3289) {
    case "attach":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("p7_bottle_plastic_16oz_water", "tag_accessory_right");
      break;
    case "detach":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
    case "face_goal":
      scripts\asm\soldier\patrol::handlefacegoalnotetrack(statename, _id_A234A65C378F3289, undefined);
      break;
  }
}

patrol_playidlesittingloop(asmname, statename, params) {
  self endon(statename + "_finished");
  self animmode("noclip");
  groundpos = scripts\engine\utility::drop_to_ground(self._blackboard._id_8FE741F6905ABCB9, 8, -128);

  if(isDefined(params))
    [[level.fnanimatedprop_setup]]("idle_chair", params, groundpos, self._blackboard._id_0227CC162483AA47);

  _id_B95ECD0BF886BB98 = 1;
  _id_D5C987658103BFFD = scripts\asm\asm::asm_getbodyknob();
  _id_F3716786BF084DD1 = _id_D5C987658103BFFD;

  for(;;) {
    loopanim = scripts\asm\asm::asm_getanim(asmname, statename);
    _id_76C92379ED351610 = scripts\asm\asm::asm_getxanim(statename, loopanim);
    self aisetanim(statename, loopanim);
    scripts\asm\asm::asm_playfacialanim(asmname, statename, _id_76C92379ED351610);
    _id_F3716786BF084DD1 = loopanim;

    if(_id_B95ECD0BF886BB98) {
      movedelta = getmovedelta(_id_76C92379ED351610);
      startpos = groundpos - rotatevector(movedelta, self._blackboard._id_0227CC162483AA47);
      self startcoverarrival(startpos, self._blackboard._id_0227CC162483AA47[1]);
      thread patrol_idlesitting_checkforcoverarrivalcomplete(statename, groundpos);
      _id_B95ECD0BF886BB98 = 0;
    }

    scripts\asm\asm::asm_donotetracks(asmname, statename, scripts\asm\asm::asm_getnotehandler(asmname, statename), statename);
  }
}

patrol_idlesitting_checkforcoverarrivalcomplete(statename, endpos) {
  self endon(statename + "_finished");

  for(;;) {
    if(distance2dsquared(self.origin, endpos) < 4) {
      self finishcoverarrival();
      break;
    }

    waitframe();
  }
}

patrol_playidlesittingloop_cleanup(asmname, statename, params) {
  self finishcoverarrival();
}

patrol_playidlesittingloop_prop_cleanup(asmname, statename, params) {
  patrol_prop_cleanup(asmname, statename, params);
  patrol_playidlesittingloop_cleanup(asmname, statename, params);
}

patrol_playidlesittingloop_sleeping(asmname, statename, params) {
  patrol_playidlesittingloop(asmname, statename, params);
}

patrol_playidlesittingloop_sleeping_cleanup(asmname, statename, params) {
  patrol_playidlesittingloop_cleanup(asmname, statename, params);
}

patrol_playidlesittingloop_cellphone(asmname, statename, params) {
  self.idle_prop = scripts\common\anim::anim_link_tag_model(patrol_idle_getcellphone(), "tag_accessory_right");
  playFXOnTag(level.g_effect["cellphone_glow"], self.idle_prop, "tag_origin");
  patrol_playidlesittingloop(asmname, statename, params);
}

patrol_playidlesittingloop_laptop(asmname, statename, params) {
  patrol_playidlesittingloop(asmname, statename, params);
}

patrol_playidlesittingloop_pistolclean(asmname, statename, params) {
  self.idle_prop = scripts\common\anim::anim_link_tag_model("weapon_wm_pi_mike1911_phys", "tag_accessory_right");
  patrol_playidlesittingloop(asmname, statename, params);
}

patrol_playdeathanim_sitting(asmname, statename, params) {
  if(isDefined(self.animated_prop))
    self[[level.fnanimatedprop_startanim]]("idle_chair", params);

  scripts\asm\soldier\death::playdeathanim(asmname, statename);
}

patrol_playidlesittingreact(asmname, statename, params) {
  self animmode("noclip");

  if(isDefined(params))
    self[[level.fnanimatedprop_setanim]]("idle_chair", params);

  scripts\asm\asm::asm_playanimstate(asmname, statename);
}

patrol_hascustomanim(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self._blackboard.customidlenode))
    _id_0E25D1D189177A7C = self._blackboard.customidlenode;
  else
    _id_0E25D1D189177A7C = self._blackboard._id_FE458D6A41146A8C;

  return isDefined(level.scr_anim["patrol_idle"]) && isDefined(level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C]) && isDefined(level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C][params]);
}

patrol_iscustomanimdefaultvalue(asmname, statename, _id_F2B19B25D457C2A6, params) {
  if(isDefined(self._blackboard.customidlenode))
    _id_0E25D1D189177A7C = self._blackboard.customidlenode;
  else
    _id_0E25D1D189177A7C = self._blackboard._id_FE458D6A41146A8C;

  return isnumber(level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C][params]);
}

patrol_chooseanim_custom(asmname, statename, params) {
  _id_0E25D1D189177A7C = self._blackboard.customidlenode;
  state = params;

  if(isarray(level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C][state])) {
    _id_AB337A614AC67FEF = level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C][state].size;

    if(_id_AB337A614AC67FEF > 1) {
      if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]()) {
        if(isDefined(self._id_BB3BAB49C9A764A4)) {
          if(self._id_F97FF24102472069 == "investigate")
            return level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C][state][0];
        }
      }

      return level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C][state][1];
      return;
    }

    return level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C][0];
    return;
  } else
    return level.scr_anim["patrol_idle"][_id_0E25D1D189177A7C][state];
}

patrol_idle_custom_init(asmname, statename, params) {
  self._blackboard.customidlenode = self._blackboard._id_FE458D6A41146A8C;
  patrol_idle_init(asmname, statename, params);
}

patrol_idle_custom_cleanup(asmname, statename, params) {
  patrol_idle_cleanup(asmname, statename, params);
  patrol_idle_callcustomcallback("cleanup");

  if(isalive(self))
    self._blackboard.customidlenode = undefined;
}

patrol_idle_callcustomcallback(_id_EA847593E957F2B0) {
  if(isDefined(level.idle_funcs)) {
    _id_0E25D1D189177A7C = self._blackboard.customidlenode;

    if(isDefined(level.idle_funcs[_id_0E25D1D189177A7C]) && isDefined(level.idle_funcs[_id_0E25D1D189177A7C][_id_EA847593E957F2B0]))
      self thread[[level.idle_funcs[_id_0E25D1D189177A7C][_id_EA847593E957F2B0]]]();
  }
}

patrol_playidleintro_custom(asmname, statename, params) {
  patrol_idle_callcustomcallback("intro_begin");
  patrol_playidleintro(asmname, statename, params);
}

patrol_playidleloop_custom(asmname, statename, params) {
  patrol_idle_callcustomcallback("loop_begin");
  patrol_playidleloop(asmname, statename, params);
}

patrol_playidlereact_custom(asmname, statename, params) {
  patrol_idle_callcustomcallback("react_begin");
  patrol_playidlereact(asmname, statename, params);
}

patrol_playidleend_custom(asmname, statename, params) {
  patrol_idle_callcustomcallback("exit_begin");
  patrol_playidleend(asmname, statename, params);
}

patrol_playidle_custom_terminate(asmname, statename, params) {
  patrol_idle_callcustomcallback(params + "_end");
}

patrol_prop_waitfordelete() {
  self endon("patrol_idle_complete");
  self waittill("entitydeleted");

  if(isDefined(self.idle_prop))
    self.idle_prop delete();
}