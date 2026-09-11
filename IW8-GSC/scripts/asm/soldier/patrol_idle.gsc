/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\patrol_idle.gsc
***********************************************/

function patrol_idle_init(var0, var1, var2) {
  self.newenemyreactiondistsq = 0;
  thread patrol_prop_waitfordelete();
}

function patrol_idle_cleanup(var0, var1, var2) {
  self.newenemyreactiondistsq = 262144;
  self._blackboard.idlenode = undefined;

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    self.idle_prop = undefined;
  }

  self notify("patrol_idle_complete");
}

function patrol_idle_shouldabort(var0, var1, var2, var3) {
  if(!isDefined(self.stealth)) {
    return true;
  }

  if(!isDefined(self._blackboard.idlenode)) {
    return true;
  }

  return false;
}

function patrol_idle_shouldsittingabort(var0, var1, var2, var3) {
  if(!isDefined(self.stealth)) {
    return true;
  }

  return false;
}

function patrol_idle_shouldreact(var0, var1, var2, var3) {
  return ![[self.fnisinstealthidle]]();
}

function patrol_shouldidleanim(var0, var1, var2, var3) {
  return isDefined(self._blackboard.idlenode) && isDefined(self._blackboard.idlenode.script_idle);
}

function patrol_idle_istype(var0, var1, var2, var3) {
  return self._blackboard.idlenode.script_idle == var3;
}

function patrol_getcustomfunc(var0, var1) {
  if(isDefined(level.idle_funcs) && isDefined(level.idle_funcs[var0])) {
    return level.idle_funcs[var0][var1];
  }

  return undefined;
}

function patrol_idle_getnotehandler(var0, var1, var2) {
  if(isDefined(self._blackboard.customidlenode)) {
    var3 = patrol_getcustomfunc(self._blackboard.customidlenode, var2 + "_note");

    if(isDefined(var3)) {
      return var3;
    }
  }

  return scripts\asm\asm::asm_getnotehandler(var0, var1);
}

function patrol_playanim(var0, var1, var2, var3, var4) {
  self endon(var1 + "_finished");
  var5 = scripts\asm\asm::asm_getanim(var0, var1);
  var6 = scripts\asm\asm::asm_getxanim(var1, var5);

  if(isnumber(var5)) {
    self aisetanim(var1, var5, var4);
  } else {
    var7 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
    self aisetanim(var1, var7, var4);
    self setflaggedanimrestart(var1, var5, 1, var4);
  }

  scripts\asm\asm::asm_playfacialanim(var0, var1, var6);
  scripts\asm\asm::asm_donotetracks(var0, var1, var3, var1);
}

function patrol_playidleintro(var0, var1, var2) {
  self animmode("zonly_physics", 0);
  var3 = self.angles[1];

  if(isDefined(self._blackboard.idlenode)) {
    var3 = self._blackboard.idlenode.angles[1];
  }

  self orientmode("face angle", var3);
  var4 = patrol_idle_getnotehandler(var0, var1, "intro");
  patrol_playanim(var0, var1, var2, var4, 1);
}

function patrol_playidleloop(var0, var1, var2) {
  self endon(var1 + "_finished");
  var3 = scripts\asm\asm::asm_getbodyknob();
  var4 = var3;
  var5 = patrol_idle_getnotehandler(var0, var1, "loop");

  for(;;) {
    var6 = scripts\asm\asm::asm_getanim(var0, var1);

    if(isnumber(var6)) {
      self aisetanim(var1, var6);
    } else {
      var7 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
      self aisetanim(var1, var7);
      self setflaggedanimrestart(var1, var6, 1, 0.2, 1);
    }

    var8 = scripts\asm\asm::asm_getxanim(var1, var6);
    scripts\asm\asm::asm_playfacialanim(var0, var1, var8);
    var4 = var6;
    scripts\asm\asm::asm_donotetracks(var0, var1, var5, var1);
  }
}

function patrol_chooseidlereact(var0, var1, var2) {
  var3 = 0;

  if(isDefined(self.stealth) && isDefined(self.stealth.patrol_react_pos)) {
    var4 = self.stealth.patrol_react_pos - self.origin;
    var5 = vectortoyaw(var4);
    var3 = angleclamp180(self.angles[1] - var5);
  }

  if(var3 < -135) {
    var6 = "2l";
  } else if(var6 > 135) {
    var6 = "2r";
  } else if(var6 < -45) {
    var6 = "4";
  } else if(var6 > 45) {
    var6 = "6";
  } else {
    var6 = "8";
  }

  var7 = scripts\asm\asm::asm_lookupanimfromalias(var6, var6);
  return var7;
}

function patrol_playidlereact(var0, var1, var2) {
  self endon(var1 + "_finished");
  self._blackboard.idlenode = undefined;
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = patrol_idle_getnotehandler(var0, var1, "react");
  var5 = 1;

  if(isDefined(self.stealth) && isDefined(self.stealth.reactendtime)) {
    var6 = getanimlength(var3);
    var7 = (self.stealth.reactendtime - gettime()) / 2000;

    if(var7 < var6) {
      if(var7 < 0.3) {
        var7 = 0.3;
      }

      var5 = var6 / var7;
    }
  }

  if(isnumber(var3)) {
    self aisetanim(var1, var3, var5);
  } else {
    var8 = scripts\asm\asm::asm_lookupanimfromalias(var1, "blank");
    self aisetanim(var1, var8, var5);
    self setflaggedanimrestart(var1, var3, 1, 0.2, var5);
  }

  var9 = scripts\asm\asm::asm_getxanim(var1, var3);
  scripts\asm\asm::asm_playfacialanim(var0, var1, var9);
  scripts\asm\asm::asm_donotetracks(var0, var1, var4, var1);
}

function patrol_playidleend(var0, var1, var2) {
  var3 = patrol_idle_getnotehandler(var0, var1, "end");
  self notify("smoking_end");
  patrol_playanim(var0, var1, var2, var3, 1);
}

function patrol_notehandler_smoking(var0, var1) {
  switch (var0) {
    case "attach":
      self.idle_fx = level.g_effect["cigarette_unlit"];
      playFXOnTag(self.idle_fx, self, "tag_accessory_right");
      break;
    case "light":
      self.idle_fx = level.g_effect["cigarette_lit"];
      playFXOnTag(self.idle_fx, self, "tag_accessory_right");
      stopFXOnTag(level.g_effect["cigarette_unlit"], self, "tag_accessory_right");
      playFX(level.g_effect["lighter_glow"], self gettagorigin("tag_accessory_right"));
      thread patrol_smoking_blowsmoke(var1);
      break;
    case "detach":
      stopFXOnTag(level.g_effect["cigarette_lit"], self, "tag_accessory_right");
      self.idle_fx = undefined;
      playFX(level.g_effect["cigarette_lit_toss"], self gettagorigin("tag_accessory_right"), anglesToForward(self gettagangles("tag_accessory_right")));
      break;
  }
}

function patrol_smoking_blowsmoke(var0) {
  self endon("smoking_end");
  self endon("death");

  for(;;) {
    self.smoke_fx_ent = spawnfx(level.g_effect["cigarette_smoke"], self getEye() - (0, 0, 2), anglesToForward(self gettagangles("tag_eye")));
    triggerfx(self.smoke_fx_ent);
    var1 = randomintrange(5, 8);
    wait var1;

    if(isDefined(self.smoke_fx_ent)) {
      self.smoke_fx_ent delete();
      self.smoke_fx_ent = undefined;
    }
  }
}

function patrol_smoking_cleanup(var0, var1, var2) {
  self notify("smoking_end");

  if(isDefined(self.idle_fx)) {
    stopFXOnTag(self.idle_fx, self, "tag_accessory_right");
    self.idle_fx = undefined;
  }

  if(isDefined(self.smoke_fx_ent)) {
    self.smoke_fx_ent delete();
    self.smoke_fx_ent = undefined;
  }

  patrol_idle_cleanup(var0, var1, var2);
}

function patrol_notehandler_cellphone(var0, var1) {
  self endon(var1 + "_finished");

  switch (var0) {
    case "attach":
      self.idle_prop = scripts\common\anim::anim_link_tag_model("offhand_wm_smartphone_on", "tag_accessory_right");
      wait 2;

      if(isDefined(self.idle_prop)) {
        playFXOnTag(level.g_effect["cellphone_glow"], self.idle_prop, "tag_origin");
      }

      break;
    case "detach":
      if(isDefined(self.idle_prop)) {
        self.idle_prop delete();
        self.idle_prop = undefined;
      }

      break;
  }
}

function patrol_prop_cleanup(var0, var1, var2) {
  if(isDefined(self.idle_prop)) {
    if(![[self.fnisinstealthidle]]() || !isalive(self)) {
      var3 = anglesToForward(self.angles);
      var3 *= randomfloatrange(30, 45);
      var4 = var3[0];
      var5 = var3[1];
      var6 = randomfloatrange(80, 90);
      self.idle_prop unlink();
      self.idle_prop physicslaunchserver(self.idle_prop.origin, (var4, var5, var6));
      thread patrol_prop_delete();
      self.idle_prop = undefined;
      return;
    }

    if([[self.fnstealthisidlecurious]]()) {
      self.idle_prop delete();
      self.idle_prop = undefined;
      return;
    }

    return;
  }
}

function patrol_prop_delete() {
  wait 5;

  while(isalive(level.player) && distance2dsquared(level.player.origin, self.origin) < 160000) {
    wait 1;
  }

  self delete();
}

function patrol_notehandler_drinking(var0, var1) {
  switch (var0) {
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

function patrol_playidlesittingloop(var0, var1, var2) {
  self endon(var1 + "_finished");
  self animmode("noclip");
  var3 = scripts\engine\utility::drop_to_ground(self._blackboard.idlenode.origin, 8, -128);

  if(isDefined(var2)) {
    self.animated_prop = scripts\engine\sp\utility::spawn_anim_model("idle_chair", var3, self._blackboard.idlenode.angles);
    var4 = level.scr_anim["idle_chair"][var2];
    self.animated_prop setanimrestart(var4, 1, 0, 0);
  }

  var5 = 1;
  var6 = scripts\asm\asm::asm_getbodyknob();
  var7 = var6;

  for(;;) {
    var8 = scripts\asm\asm::asm_getanim(var0, var1);
    var9 = scripts\asm\asm::asm_getxanim(var1, var8);
    self aisetanim(var1, var8);
    scripts\asm\asm::asm_playfacialanim(var0, var1, var9);
    var7 = var8;

    if(var5) {
      var10 = getmovedelta(var9);
      var11 = var3 - rotatevector(var10, self._blackboard.idlenode.angles);
      self startcoverarrival(var11, self._blackboard.idlenode.angles[1]);
      thread patrol_idlesitting_checkforcoverarrivalcomplete(var1, var3);
      var5 = 0;
    }

    scripts\asm\asm::asm_donotetracks(var0, var1, scripts\asm\asm::asm_getnotehandler(var0, var1), var1);
  }
}

function patrol_idlesitting_checkforcoverarrivalcomplete(var0, var1) {
  self endon(var0 + "_finished");

  for(;;) {
    if(distance2dsquared(self.origin, var1) < 4) {
      self finishcoverarrival();
      break;
    }

    waitframe();
  }
}

function patrol_playidlesittingloop_cleanup(var0, var1, var2) {
  self finishcoverarrival();
}

function patrol_playidlesittingloop_prop_cleanup(var0, var1, var2) {
  patrol_prop_cleanup(var0, var1, var2);
  patrol_playidlesittingloop_cleanup(var0, var1, var2);
}

function patrol_playidlesittingloop_sleeping(var0, var1, var2) {
  self playLoopSound("stealth_idle_snoring_loop");
  patrol_playidlesittingloop(var0, var1, var2);
}

function patrol_playidlesittingloop_sleeping_cleanup(var0, var1, var2) {
  self stoploopsound("stealth_idle_snoring_loop");
  patrol_playidlesittingloop_cleanup(var0, var1, var2);
}

function patrol_playidlesittingloop_cellphone(var0, var1, var2) {
  self.idle_prop = scripts\common\anim::anim_link_tag_model("offhand_wm_smartphone_on", "tag_accessory_right");
  playFXOnTag(level.g_effect["cellphone_glow"], self.idle_prop, "tag_origin");
  patrol_playidlesittingloop(var0, var1, var2);
}

function patrol_playidlesittingloop_laptop(var0, var1, var2) {
  patrol_playidlesittingloop(var0, var1, var2);
}

function patrol_playidlesittingloop_pistolclean(var0, var1, var2) {
  self.idle_prop = scripts\common\anim::anim_link_tag_model("weapon_g18_rare_wm", "tag_accessory_right");
  patrol_playidlesittingloop(var0, var1, var2);
}

function patrol_playdeathanim_sitting(var0, var1, var2) {
  if(isDefined(self.animated_prop)) {
    var3 = level.scr_anim["idle_chair"][var2];
    self.animated_prop setanimrate(var3, 1);
  }

  scripts\asm\soldier\death::playdeathanim(var0, var1);
}

function patrol_playidlesittingreact(var0, var1, var2) {
  self animmode("noclip");

  if(isDefined(var2)) {
    var3 = level.scr_anim["idle_chair"][var2];
    self.animated_prop setanimknob(var3, 1, 0.2, 1);
  }

  scripts\asm\asm::asm_playanimstate(var0, var1);
}

function patrol_hascustomanim(var0, var1, var2, var3) {
  if(isDefined(self._blackboard.customidlenode)) {
    var4 = self._blackboard.customidlenode;
  } else {
    var4 = self._blackboard.idlenode.script_idle;
  }

  return isDefined(level.scr_anim["patrol_idle"]) && isDefined(level.scr_anim["patrol_idle"][var4]) && isDefined(level.scr_anim["patrol_idle"][var4][var4]);
}

function patrol_iscustomanimdefaultvalue(var0, var1, var2, var3) {
  if(isDefined(self._blackboard.customidlenode)) {
    var4 = self._blackboard.customidlenode;
  } else {
    var4 = self._blackboard.idlenode.script_idle;
  }

  return isnumber(level.scr_anim["patrol_idle"][var4][var4]);
}

function patrol_chooseanim_custom(var0, var1, var2) {
  var3 = self._blackboard.customidlenode;
  var4 = var2;

  if(isarray(level.scr_anim["patrol_idle"][var3][var4])) {
    var5 = level.scr_anim["patrol_idle"][var3][var4].size;

    if(var5 > 1) {
      if(isDefined(self.fnisinstealthinvestigate) && [[self.fnisinstealthinvestigate]]()) {
        if(isDefined(self.stealth.investigateevent)) {
          if(self.stealth.investigateevent.type == "investigate") {
            return level.scr_anim["patrol_idle"][var3][var4][0];
          }
        }
      }

      return level.scr_anim["patrol_idle"][var3][var4][1];
    }

    return level.scr_anim["patrol_idle"][var3][0];
  }

  return level.scr_anim["patrol_idle"][var3][var4];
}

function patrol_idle_custom_init(var0, var1, var2) {
  self._blackboard.customidlenode = self._blackboard.idlenode.script_idle;
  patrol_idle_init(var0, var1, var2);
}

function patrol_idle_custom_cleanup(var0, var1, var2) {
  patrol_idle_cleanup(var0, var1, var2);
  patrol_idle_callcustomcallback("cleanup");

  if(isalive(self)) {
    self._blackboard.customidlenode = undefined;
    return;
  }
}

function patrol_idle_callcustomcallback(var0) {
  if(isDefined(level.idle_funcs)) {
    var1 = self._blackboard.customidlenode;

    if(isDefined(level.idle_funcs[var1]) && isDefined(level.idle_funcs[var1][var0])) {
      self thread[[level.idle_funcs[var1][var0]]]();
      return;
    }

    return;
  }
}

function patrol_playidleintro_custom(var0, var1, var2) {
  patrol_idle_callcustomcallback("intro_begin");
  patrol_playidleintro(var0, var1, var2);
}

function patrol_playidleloop_custom(var0, var1, var2) {
  patrol_idle_callcustomcallback("loop_begin");
  patrol_playidleloop(var0, var1, var2);
}

function patrol_playidlereact_custom(var0, var1, var2) {
  patrol_idle_callcustomcallback("react_begin");
  patrol_playidlereact(var0, var1, var2);
}

function patrol_playidleend_custom(var0, var1, var2) {
  patrol_idle_callcustomcallback("exit_begin");
  patrol_playidleend(var0, var1, var2);
}

function patrol_playidle_custom_terminate(var0, var1, var2) {
  patrol_idle_callcustomcallback(var2 + "_end");
}

function patrol_prop_waitfordelete() {
  self endon("patrol_idle_complete");
  self waittill("entitydeleted");

  if(isDefined(self.idle_prop)) {
    self.idle_prop delete();
    return;
  }
}