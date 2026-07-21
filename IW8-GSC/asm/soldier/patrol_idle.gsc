/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\patrol_idle.gsc
***********************************************/

patrol_idle_init(var_0, var_1, var_2) {
  self.newenemyreactiondistsq = 0;
  thread patrol_prop_waitfordelete();
}

patrol_idle_cleanup(var_0, var_1, var_2) {
  self.newenemyreactiondistsq = 262144;
  self._blackboard.idlenode = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }

  self notify("patrol_idle_complete");
}

patrol_idle_shouldabort(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stealth))
    return 1;

  if(!isDefined(self._blackboard.idlenode))
    return 1;

  return 0;
}

patrol_idle_shouldsittingabort(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stealth))
    return 1;

  return 0;
}

patrol_idle_shouldreact(var_0, var_1, var_2, var_3) {
  return ![[self.fnisinstealthidle]]();
}

patrol_shouldidleanim(var_0, var_1, var_2, var_3) {
  return isDefined(self._blackboard.idlenode) && isDefined(self._blackboard.idlenode.script_idle);
}

patrol_idle_istype(var_0, var_1, var_2, var_3) {
  return self._blackboard.idlenode.script_idle == var_3;
}

patrol_getcustomfunc(var_0, var_1) {
  if(isDefined(level.idle_funcs) && isDefined(level.idle_funcs[var_0]))
    return level.idle_funcs[var_0][var_1];

  return undefined;
}

patrol_idle_getnotehandler(var_0, var_1, var_2) {
  if(isDefined(self._blackboard.customidlenode)) {
    var_3 = patrol_getcustomfunc(self._blackboard.customidlenode, var_2 + "_note");

    if(isDefined(var_3))
      return var_3;
  }

  return scripts\asm\asm::asm_getnotehandler(var_0, var_1);
}

patrol_playanim(var_0, var_1, var_2, var_3, var_4) {
  self endon(var_1 + "_finished");
  var_5 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_6 = scripts\asm\asm::asm_getxanim(var_1, var_5);

  if(isnumber(var_5))
    self aisetanim(var_1, var_5, var_4);
  else {
    var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
    self aisetanim(var_1, var_7, var_4);
    self setflaggedanimrestart(var_1, var_5, 1, var_4);
  }

  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_6);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, var_3, var_1);
}

patrol_playidleintro(var_0, var_1, var_2) {
  self animmode("zonly_physics", 0);
  var_3 = self.angles[1];

  if(isDefined(self._blackboard.idlenode))
    var_3 = self._blackboard.idlenode.angles[1];

  self orientmode("face angle", var_3);
  var_4 = patrol_idle_getnotehandler(var_0, var_1, "intro");
  patrol_playanim(var_0, var_1, var_2, var_4, 1);
}

patrol_playidleloop(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  var_3 = scripts\asm\asm::asm_getbodyknob();
  var_4 = var_3;
  var_5 = patrol_idle_getnotehandler(var_0, var_1, "loop");

  for(;;) {
    var_6 = scripts\asm\asm::asm_getanim(var_0, var_1);

    if(isnumber(var_6))
      self aisetanim(var_1, var_6);
    else {
      var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
      self aisetanim(var_1, var_7);
      self setflaggedanimrestart(var_1, var_6, 1, 0.2, 1);
    }

    var_8 = scripts\asm\asm::asm_getxanim(var_1, var_6);
    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_8);
    var_4 = var_6;
    scripts\asm\asm::asm_donotetracks(var_0, var_1, var_5, var_1);
  }
}

patrol_chooseidlereact(var_0, var_1, var_2) {
  var_3 = 0;

  if(isDefined(self.stealth) && isDefined(self.stealth.patrol_react_pos)) {
    var_4 = self.stealth.patrol_react_pos - self.origin;
    var_5 = vectortoyaw(var_4);
    var_3 = angleclamp180(self.angles[1] - var_5);
  }

  if(var_3 < -135)
    var_6 = "2l";
  else if(var_3 > 135)
    var_6 = "2r";
  else if(var_3 < -45)
    var_6 = "4";
  else if(var_3 > 45)
    var_6 = "6";
  else
    var_6 = "8";

  var_7 = scripts\asm\asm::asm_lookupanimfromalias(var_1, var_6);
  return var_7;
}

patrol_playidlereact(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self._blackboard.idlenode = undefined;
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = patrol_idle_getnotehandler(var_0, var_1, "react");
  var_5 = 1;

  if(isDefined(self.stealth) && isDefined(self.stealth.reactendtime)) {
    var_6 = getanimlength(var_3);
    var_7 = (self.stealth.reactendtime - gettime()) / 2000;

    if(var_7 < var_6) {
      if(var_7 < 0.3)
        var_7 = 0.3;

      var_5 = var_6 / var_7;
    }
  }

  if(isnumber(var_3))
    self aisetanim(var_1, var_3, var_5);
  else {
    var_8 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "blank");
    self aisetanim(var_1, var_8, var_5);
    self setflaggedanimrestart(var_1, var_3, 1, 0.2, var_5);
  }

  var_9 = scripts\asm\asm::asm_getxanim(var_1, var_3);
  scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_9);
  scripts\asm\asm::asm_donotetracks(var_0, var_1, var_4, var_1);
}

patrol_playidleend(var_0, var_1, var_2) {
  var_3 = patrol_idle_getnotehandler(var_0, var_1, "end");
  self notify("smoking_end");
  patrol_playanim(var_0, var_1, var_2, var_3, 1);
}

patrol_notehandler_smoking(var_0, var_1) {
  switch (var_0) {
    case "attach":
      self.idle_fx = level.g_effect["cigarette_unlit"];
      playFXOnTag(self.idle_fx, self, "tag_accessory_right");
      break;
    case "light":
      self.idle_fx = level.g_effect["cigarette_lit"];
      playFXOnTag(self.idle_fx, self, "tag_accessory_right");
      stopFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
      playFX(level.g_effect["lighter_glow"], self gettagorigin("tag_accessory_right"));
      thread patrol_smoking_blowsmoke(var_1);
      break;
    case "detach":
      stopFXOnTag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
      self.idle_fx = undefined;
      playFX(level.g_effect["cigarette_lit_toss"], self gettagorigin("tag_accessory_right"), anglesToForward(self gettagangles("tag_accessory_right")));
      break;
  }
}

patrol_smoking_blowsmoke(var_0) {
  self endon("smoking_end");
  self endon("death");

  for(;;) {
    self.smoke_fx_ent = spawnfx(level.g_effect["cigarette_smoke"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("tag_eye")));
    triggerfx(self.smoke_fx_ent);
    var_1 = randomintrange(5, 8);
    wait(var_1);

    if(isDefined(self.smoke_fx_ent)) {
      self.smoke_fx_ent delete();
      self.smoke_fx_ent = undefined;
    }
  }
}

patrol_smoking_cleanup(var_0, var_1, var_2) {
  self notify("smoking_end");

  if(isDefined(self.idle_fx)) {
    stopFXOnTag(self.idle_fx, self, "tag_accessory_right");
    self.idle_fx = undefined;
  }

  if(isDefined(self.smoke_fx_ent)) {
    self.smoke_fx_ent delete();
    self.smoke_fx_ent = undefined;
  }

  patrol_idle_cleanup(var_0, var_1, var_2);
}

patrol_notehandler_cellphone(var_0, var_1) {
  self endon(var_1 + "_finished");

  switch (var_0) {
    case "attach":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("offhand_wm_smartphone_on", "tag_accessory_right");
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
  }
}

patrol_prop_cleanup(var_0, var_1, var_2) {
  if(isDefined(self.idle_prop)) {
    if(![[self.fnisinstealthidle]]() || !isalive(self)) {
      var_3 = anglesToForward(self.angles);
      var_3 = var_3 * randomfloatrange(30, 45);
      var_4 = var_3[0];
      var_5 = var_3[1];
      var_6 = randomfloatrange(80, 90);
      self.idle_prop unlink();
      self.idle_prop physicslaunchserver(self.idle_prop.origin, (var_4, var_5, var_6));
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

patrol_notehandler_drinking(var_0, var_1) {
  switch (var_0) {
    case "attach":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("p7_bottle_plastic_16oz_water", "tag_accessory_right");
      break;
    case "detach":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
  }
}

patrol_playidlesittingloop(var_0, var_1, var_2) {
  self endon(var_1 + "_finished");
  self animmode("noclip");
  var_3 = scripts\engine\utility::drop_to_ground(self._blackboard.idlenode.origin, 8, -128);

  if(isDefined(var_2)) {
    self.animated_prop = scripts\engine\sp\utility::spawn_anim_model("idle_chair", var_3, self._blackboard.idlenode.angles);
    var_4 = level.scr_anim["idle_chair"][var_2];
    self.animated_prop setanimrestart(var_4, 1, 0, 0);
  }

  var_5 = 1;
  var_6 = scripts\asm\asm::asm_getbodyknob();
  var_7 = var_6;

  for(;;) {
    var_8 = scripts\asm\asm::asm_getanim(var_0, var_1);
    var_9 = scripts\asm\asm::asm_getxanim(var_1, var_8);
    self aisetanim(var_1, var_8);
    scripts\asm\asm::asm_playfacialanim(var_0, var_1, var_9);
    var_7 = var_8;

    if(var_5) {
      var_10 = getmovedelta(var_9);
      var_11 = var_3 - rotatevector(var_10, self._blackboard.idlenode.angles);
      self startcoverarrival(var_11, self._blackboard.idlenode.angles[1]);
      thread patrol_idlesitting_checkforcoverarrivalcomplete(var_1, var_3);
      var_5 = 0;
    }

    scripts\asm\asm::asm_donotetracks(var_0, var_1, scripts\asm\asm::asm_getnotehandler(var_0, var_1), var_1);
  }
}

patrol_idlesitting_checkforcoverarrivalcomplete(var_0, var_1) {
  self endon(var_0 + "_finished");

  for(;;) {
    if(distance2dsquared(self.origin, var_1) < 4) {
      self finishcoverarrival();
      break;
    }

    waitframe();
  }
}

patrol_playidlesittingloop_cleanup(var_0, var_1, var_2) {
  self finishcoverarrival();
}

patrol_playidlesittingloop_prop_cleanup(var_0, var_1, var_2) {
  patrol_prop_cleanup(var_0, var_1, var_2);
  patrol_playidlesittingloop_cleanup(var_0, var_1, var_2);
}

patrol_playidlesittingloop_sleeping(var_0, var_1, var_2) {
  self playLoopSound("stealth_idle_snoring_loop");
  patrol_playidlesittingloop(var_0, var_1, var_2);
}

patrol_playidlesittingloop_sleeping_cleanup(var_0, var_1, var_2) {
  self stoploopsound("stealth_idle_snoring_loop");
  patrol_playidlesittingloop_cleanup(var_0, var_1, var_2);
}

patrol_playidlesittingloop_cellphone(var_0, var_1, var_2) {
  self.idle_prop = scripts\common\anim::anim_link_tag_model("offhand_wm_smartphone_on", "tag_accessory_right");
  playFXOnTag(level.g_effect["cellphone_glow"], self.idle_prop, "tag_origin");
  patrol_playidlesittingloop(var_0, var_1, var_2);
}

patrol_playidlesittingloop_laptop(var_0, var_1, var_2) {
  patrol_playidlesittingloop(var_0, var_1, var_2);
}

patrol_playidlesittingloop_pistolclean(var_0, var_1, var_2) {
  self.idle_prop = scripts\common\anim::anim_link_tag_model("weapon_g18_rare_wm", "tag_accessory_right");
  patrol_playidlesittingloop(var_0, var_1, var_2);
}

patrol_playdeathanim_sitting(var_0, var_1, var_2) {
  if(isDefined(self.animated_prop)) {
    var_3 = level.scr_anim["idle_chair"][var_2];
    self.animated_prop setanimrate(var_3, 1);
  }

  scripts\asm\soldier\death::playdeathanim(var_0, var_1);
}

patrol_playidlesittingreact(var_0, var_1, var_2) {
  self animmode("noclip");

  if(isDefined(var_2)) {
    var_3 = level.scr_anim["idle_chair"][var_2];
    self.animated_prop setanimknob(var_3, 1, 0.2, 1);
  }

  scripts\asm\asm::asm_playanimstate(var_0, var_1);
}

patrol_hascustomanim(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.customidlenode))
    var_4 = self._blackboard.customidlenode;
  else
    var_4 = self._blackboard.idlenode.script_idle;

  return isDefined(level.scr_anim["patrol_idle"]) && isDefined(level.scr_anim["patrol_idle"][var_4]) && isDefined(level.scr_anim["patrol_idle"][var_4][var_3]);
}

patrol_iscustomanimdefaultvalue(var_0, var_1, var_2, var_3) {
  if(isDefined(self._blackboard.customidlenode))
    var_4 = self._blackboard.customidlenode;
  else
    var_4 = self._blackboard.idlenode.script_idle;

  return isnumber(level.scr_anim["patrol_idle"][var_4][var_3]);
}

patrol_chooseanim_custom(var_0, var_1, var_2) {
  var_3 = self._blackboard.customidlenode;
  var_4 = var_2;

  if(isarray(level.scr_anim["patrol_idle"][var_3][var_4])) {
    var_5 = level.scr_anim["patrol_idle"][var_3][var_4].size;

    if(var_5 > 1) {
      if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]()) {
        if(isDefined(self.stealth.investigateevent)) {
          if(self.stealth.investigateevent.type == "investigate")
            return level.scr_anim["patrol_idle"][var_3][var_4][0];
        }
      }

      return level.scr_anim["patrol_idle"][var_3][var_4][1];
      return;
    }

    return level.scr_anim["patrol_idle"][var_3][0];
    return;
  } else
    return level.scr_anim["patrol_idle"][var_3][var_4];
}

patrol_idle_custom_init(var_0, var_1, var_2) {
  self._blackboard.customidlenode = self._blackboard.idlenode.script_idle;
  patrol_idle_init(var_0, var_1, var_2);
}

patrol_idle_custom_cleanup(var_0, var_1, var_2) {
  patrol_idle_cleanup(var_0, var_1, var_2);
  patrol_idle_callcustomcallback("cleanup");

  if(isalive(self))
    self._blackboard.customidlenode = undefined;
}

patrol_idle_callcustomcallback(var_0) {
  if(isDefined(level.idle_funcs)) {
    var_1 = self._blackboard.customidlenode;

    if(isDefined(level.idle_funcs[var_1]) && isDefined(level.idle_funcs[var_1][var_0]))
      self thread[[level.idle_funcs[var_1][var_0]]]();
  }
}

patrol_playidleintro_custom(var_0, var_1, var_2) {
  patrol_idle_callcustomcallback("intro_begin");
  patrol_playidleintro(var_0, var_1, var_2);
}

patrol_playidleloop_custom(var_0, var_1, var_2) {
  patrol_idle_callcustomcallback("loop_begin");
  patrol_playidleloop(var_0, var_1, var_2);
}

patrol_playidlereact_custom(var_0, var_1, var_2) {
  patrol_idle_callcustomcallback("react_begin");
  patrol_playidlereact(var_0, var_1, var_2);
}

patrol_playidleend_custom(var_0, var_1, var_2) {
  patrol_idle_callcustomcallback("exit_begin");
  patrol_playidleend(var_0, var_1, var_2);
}

patrol_playidle_custom_terminate(var_0, var_1, var_2) {
  patrol_idle_callcustomcallback(var_2 + "_end");
}

patrol_prop_waitfordelete() {
  self endon("patrol_idle_complete");
  self waittill("entitydeleted");

  if(isDefined(self.idle_prop))
    self.idle_prop delete();
}