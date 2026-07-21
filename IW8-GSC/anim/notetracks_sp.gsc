/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\notetracks_sp.gsc
***********************************************/

registernotetracksifnot() {
  if(isDefined(anim.notetracks)) {
    return;
  }
  anim.notetracks = [];
  registernotetracks();
}

registernotetracks() {
  level._defaultnotetrackhandler = ::handlenotetrack;
  level.fnnotetrackprefixhandler = ::notetrack_prefix_handler_sp;
  level.fnnotetrackmodeltranslate = ::notetrack_model_translate;
  scripts\anim\notetracks.gsc::registernotetracks();
  anim.notetracks["fingers_out_start_left_hand"] = ::notetrackfingerposeoffleft;
  anim.notetracks["fingers_out_start_right_hand"] = ::notetrackfingerposeoffright;
  anim.notetracks["fingers_in_start_left_hand"] = ::notetrackfingerposeonleft;
  anim.notetracks["fingers_in_start_right_hand"] = ::notetrackfingerposeonright;
  anim.notetracks["anim_facial = idle"] = ::notetrackfacialidle;
  anim.notetracks["anim_facial = run"] = ::notetrackfacialrun;
  anim.notetracks["anim_facial = pain"] = ::notetrackfacialpain;
  anim.notetracks["anim_facial = death"] = ::notetrackfacialdeath;
  anim.notetracks["anim_facial = talk"] = ::notetrackfacialtalk;
  anim.notetracks["anim_facial = cheer"] = ::notetrackfacialcheer;
  anim.notetracks["anim_facial = happy"] = ::notetrackfacialhappy;
  anim.notetracks["anim_facial = angry"] = ::notetrackfacialangry;
  anim.notetracks["anim_facial = scared"] = ::notetrackfacialscared;
  anim.notetracks["anim_facial = gas_death"] = ::notetrackfacialgasdeath;
  anim.notetracks["visor_raise"] = ::notetrackvisorraise;
  anim.notetracks["visor_lower"] = ::notetrackvisorlower;
  anim.notetracks["visor_lower_instant"] = ::notetrackvisorlower_instant;
  anim.notetracks["visor_raise_instant"] = ::notetrackvisorraise_instant;
  anim.notetracks["visor_lower_price_instant"] = ::notetrackvisorpricelower_instant;
  anim.notetracks["visor_raise_price_instant"] = ::notetrackvisorpriceraise_instant;
  anim.notetracks["visor_clearanim"] = ::notetrackvisorraise_clear;
  anim.notetracks["bloodpool"] = scripts\anim\death.gsc::play_blood_pool;
  anim.notetracks["footstep_right_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_small"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_small"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_large_vfxonly"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_small_vfxonly"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_large_vfxonly"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_small_vfxonly"] = ::notetrackfootstep;
  anim.notetracks["mvmt_step_pre"] = ::notetrackmovement;
  anim.notetracks["mvmt_step_post"] = ::notetrackmovement;
  anim.notetracks["footscrape"] = ::notetrackfootscrape;
  anim.notetracks["land"] = ::notetrackland;
  anim.notetracks["handstep_left"] = ::notetrackhandstep;
  anim.notetracks["handstep_right"] = ::notetrackhandstep;
  anim.notetracks["laser_on"] = ::notetracklaser;
  anim.notetracks["laser_off"] = ::notetracklaser;
  anim.notetracks["start_ragdoll"] = ::notetrackstartragdoll;
  anim.notetracks["ragdollblendinit"] = ::notetrackragdollblendinit;
  anim.notetracks["ragdollblendstart"] = ::notetrackragdollblendstart;
  anim.notetracks["ragdollblendend"] = ::notetrackragdollblendend;
  anim.notetracks["ragdollblendrootanim"] = ::notetrackragdollblendrootanim;
  anim.notetracks["ragdollblendrootragdoll"] = ::notetrackragdollblendrootragdoll;
  anim.notetracks["drop clip"] = ::notetrackdropclip;
  anim.notetracks["helmet_pop"] = ::notetrackhelmetpop;
  anim.notetracks["gun drop"] = ::notetrackgundrop;
  anim.notetracks["dropgun"] = ::notetrackgundrop;
  anim.notetracks["gunhand = (gunhand)_left"] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = left"] = ::notetrackgunhand;
  anim.notetracks["gunhand = (gunhand)_right"] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = right"] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = none"] = ::notetrackgunhand;
  anim.notetracks["anim_pose = \"stand\""] = ::notetrackposestand;
  anim.notetracks["anim_pose = \"crouch\""] = ::notetrackposecrouch;
  anim.notetracks["anim_pose = \"prone\""] = ::notetrackposeprone;
  anim.notetracks["anim_pose = \"crawl\""] = ::notetrackposecrawl;
  anim.notetracks["anim_pose = \"back\""] = ::notetrackposeback;
  anim.notetracks["anim_gunhand = \"left\""] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = \"right\""] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = \"none\""] = ::notetrackgunhand;
  anim.notetracks["anim_pose = stand"] = ::notetrackposestand;
  anim.notetracks["anim_pose = crouch"] = ::notetrackposecrouch;
  anim.notetracks["anim_pose = prone"] = ::notetrackposeprone;
  anim.notetracks["anim_pose = crawl"] = ::notetrackposecrawl;
  anim.notetracks["anim_pose = back"] = ::notetrackposeback;
  anim.notetracks["eyes_on"] = ::eyeonnotehandler;
  anim.notetracks["eyes_off"] = ::eyeoffnotehandler;
}

handlenotetrack(var_0, var_1, var_2, var_3) {
  if(scripts\anim\notetracks.gsc::hascustomnotetrackhandler(var_0))
    return scripts\anim\notetracks.gsc::handlecustomnotetrackhandler(var_0, var_1, var_2, var_3);

  var_4 = scripts\anim\notetracks.gsc::handlecommonnotetrack(var_0, var_1, var_2, var_3);

  if(isDefined(var_4) && var_4 == "__unhandled") {
    var_4 = undefined;

    switch (var_0) {
      case "stop anim":
        scripts\engine\sp\utility::anim_stopanimScripted();
        return var_0;
      case "rechamber":
        if(scripts\anim\utility_common.gsc::weapon_pump_action_shotgun())
          self playSound("weap_reload_shotgun_pump_npc");

        self.a.needstorechamber = 0;
        break;
      case "attach_clip_left":
        if(scripts\anim\utility_common.gsc::usingrocketlauncher())
          notetrackrocketlauncherammoattach();

        break;
      default:
        if(isDefined(var_2)) {
          if(isDefined(var_3))
            return [[var_2]](var_0, var_3);
          else
            return [[var_2]](var_0);
        }

        break;
    }
  }

  return var_4;
}

notetrackvisorraise(var_0, var_1) {
  if(!isai(self)) {
    return;
  }
  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise();
}

notetrackvisorlower(var_0, var_1) {
  if(!isai(self)) {
    return;
  }
  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise();
}

notetrackvisorlower_instant(var_0, var_1) {
  if(!isai(self)) {
    return;
  }
  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise("_instant");
}

notetrackvisorraise_instant(var_0, var_1) {
  if(!isai(self)) {
    return;
  }
  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise("_instant");
}

notetrackvisorpricelower_instant(var_0, var_1) {
  if(!isai(self)) {
    return;
  }
  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise("_price_instant");
}

notetrackvisorpriceraise_instant(var_0, var_1) {
  if(!isai(self)) {
    return;
  }
  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise("_price_instant");
}

notetrackvisorraise_clear(var_0, var_1) {
  if(!isai(self)) {
    return;
  }
  self.visor_down = 0;
  scripts\asm\asm_sp::asm_clearvisoranim();
}

notetrackfingerposeoffleft(var_0, var_1) {
  scripts\asm\asm_sp::asm_clearikfingeranim("left");
}

notetrackfingerposeonleft(var_0, var_1) {
  scripts\asm\asm_sp::asm_ikfingeranim("left");
}

notetrackfingerposeoffright(var_0, var_1) {
  scripts\asm\asm_sp::asm_clearikfingeranim("left");
}

notetrackfingerposeonright(var_0, var_1) {
  scripts\asm\asm_sp::asm_ikfingeranim("right");
}

notetrackfacialidle(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("idle");
}

notetrackfacialrun(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("run");
}

notetrackfacialpain(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("pain");
}

notetrackfacialdeath(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("death");
}

notetrackfacialtalk(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("talk");
}

notetrackfacialcheer(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("cheer");
}

notetrackfacialhappy(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("happy");
}

notetrackfacialscared(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("scared");
}

notetrackfacialangry(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("angry");
}

notetrackfacialgasdeath(var_0, var_1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("gas_death");
}

notetrackmovement(var_0, var_1) {
  var_2 = 1;

  if(issubstr(var_0, "post"))
    var_2 = 2;

  var_3 = get_notetrack_movement();

  if(isDefined(self.classname) && self.classname != "script_model")
    self playclothmovesound(var_3, var_2);
}

notetrackfootstep(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  var_4 = issubstr(var_0, "vfxonly");
  var_5 = "right";

  if(var_2)
    var_5 = "left";

  if(isai(self)) {
    self.asm.footsteps.foot = var_5;
    self.asm.footsteps.time = gettime();
  }

  if(scripts\asm\asm_bb::ispartdismembered("left_leg") || scripts\asm\asm_bb::ispartdismembered("right_leg")) {
    return;
  }
  playfootstep(var_2, var_3, var_4);

  if(isDefined(self.classname) && self.classname != "script_model" && isDefined(self.weapon) && !var_4) {
    var_6 = get_notetrack_movement();
    var_7 = self playequipmovesound(var_6, self.weapon);
  }
}

notetrackfootscrape(var_0, var_1) {
  if(isDefined(self.groundtype))
    var_2 = self.groundtype;
  else
    var_2 = "dirt";
}

notetrackland(var_0, var_1) {
  if(isDefined(self.groundtype))
    var_2 = self.groundtype;
  else
    var_2 = "dirt";

  self playsurfacesound("step_default_npc_land", var_2);
  self playclothmovesound("land", 2);
  self playequipmovesound("land", self.weapon);
}

playfootstep(var_0, var_1, var_2) {
  if(!isai(self)) {
    if(!var_2)
      self playsurfacesound("step_default_npc_run", "dirt");

    return;
  }

  var_3 = undefined;
  var_4 = "step_";
  var_5 = self.stairsstate;

  if(var_5 == "up")
    var_4 = "stepstairup_";
  else if(var_5 == "down")
    var_4 = "stepstairdown_";

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      if(!var_2)
        self playsurfacesound(var_4 + "default_npc_run", "dirt");

      return;
    }

    var_3 = self.lastgroundtype;
  } else {
    var_3 = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }

  var_6 = "J_Ball_RI";

  if(var_0)
    var_6 = "J_Ball_LE";

  var_7 = get_notetrack_movement();

  if(self.unittype == "soldier" || self.unittype == "civilian" || self.unittype == "juggernaut" || self.unittype == "suicidebomber")
    var_8 = "";
  else
    var_8 = tolower(self.unittype + "_");

  var_9 = undefined;

  if(isDefined(level.fngetfootstepsound))
    var_9 = self[[level.fngetfootstepsound]](var_7, var_3, var_6);

  if(!isDefined(var_9))
    var_9 = var_8 + var_4 + "default_npc_" + var_7;

  if(soundexists(var_9) && var_9 != "none" && !var_2)
    thread scripts\engine\sp\utility::play_footstep_sound(var_9, var_3);

  if(self isscriptable()) {
    return;
  }
  if(var_1) {
    if(![[anim.fnfootstepeffect]](var_6, var_3))
      playfootstepeffectsmall(var_6, var_3);
  } else if(![[anim.fnfootstepeffectsmall]](var_6, var_3))
    playfootstepeffect(var_6, var_3);

  if(![[anim.fnfootprinteffect]](var_6, var_3))
    playfootprinteffect(var_6, var_3);
}

playhandstep(var_0, var_1) {
  if(!isai(self)) {
    self playsurfacesound("c6_handstep", "default");
    return;
  }

  if(var_0) {
    var_2 = "J_MID_LE_1";

    if(scripts\aitypes\dismember::get_scriptablepartinfo("left_arm") == "dismember")
      return;
  } else {
    var_2 = "J_MID_RI_1";

    if(scripts\aitypes\dismember::get_scriptablepartinfo("right_arm") == "dismember")
      return;
  }

  var_3 = undefined;

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      self playsurfacesound("c6_handstep", "default");
      return;
    }

    var_3 = self.lastgroundtype;
  } else {
    var_3 = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }

  var_4 = get_notetrack_movement();
  var_5 = "c6_handstep";

  if(soundexists(var_5))
    self playsurfacesound(var_5, var_3);

  if(![[anim.optionalstepeffectsmallfunction]](var_2, var_3))
    playfootstepeffect(var_2, var_3);

  if(![[anim.optionalfootprinteffectfunction]](var_2, var_3))
    playfootprinteffect(var_2, var_3);
}

notetrackhandstep(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  var_4 = "right";

  if(var_2)
    var_4 = "left";

  if(isai(self)) {
    self.asm.footsteps.foot = var_4;
    self.asm.footsteps.time = gettime();
  }

  playhandstep(var_2, var_3);
}

playfootprinteffect(var_0, var_1) {
  if(!isDefined(anim.optionalfootprinteffects[var_1]))
    return 0;

  var_2 = self gettagorigin(var_0);
  var_3 = self gettagangles(var_0);
  var_4 = anglestoright(var_3) * -1;
  var_5 = anglesToForward(var_3);
  var_6 = var_2 + var_4 * -5;
  var_7 = var_2 + var_4 * 20;
  var_8 = scripts\engine\trace::_bullet_trace(var_6, var_7, 0, self, 0, 0, 0, 0);

  if(var_8["fraction"] == 1)
    return 1;

  if(!isDefined(level._effect["footprint_" + var_1][self.unittype]))
    level._effect["footprint_" + var_1][self.unittype] = level._effect["footprint_" + var_1]["soldier"];

  if(!anim.flirfootprinteffects)
    playFX(level._effect["footprint_" + var_1][self.unittype], var_8["position"], var_8["normal"], var_5);
  else
    thread track_flir_footstep(level._effect["footprint_" + var_1][self.unittype], var_8["position"], var_8["normal"], var_5);

  return 1;
}

track_flir_footstep(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4.effectid = var_0;
  var_4.org = var_1;
  var_4.forwardv = var_2;
  var_4.upv = var_3;
  var_4.spawntime = gettime();
  var_4.active = 0;
  anim.flirfootprints = scripts\engine\utility::array_add(anim.flirfootprints, var_4);

  if(level.player isnightvisionon() && level.player scripts\engine\sp\utility::is_flir_vision_on())
    var_4 thread play_flir_footstep_fx();

  wait 10;
  anim.flirfootprints = scripts\engine\utility::array_remove(anim.flirfootprints, var_4);
}

play_flir_footstep_fx() {
  if(self.active) {
    return;
  }
  self.active = 1;
  self.fx = spawnfx(self.effectid, self.org, self.forwardv, self.upv);
  triggerfx(self.fx, self.spawntime / 1000);
}

kill_flir_footstep_fx() {
  if(!self.active) {
    return;
  }
  self.active = 0;
  self.fx delete();
}

playfootstepeffect(var_0, var_1) {
  if(!isDefined(anim.optionalstepeffects[var_1]))
    return 0;

  var_2 = self gettagorigin(var_0);
  var_3 = self.angles;
  var_4 = anglesToForward(var_3);
  var_5 = anglestoup(var_3);

  if(!isDefined(level._effect["step_" + var_1][self.unittype]))
    level._effect["step_" + var_1][self.unittype] = level._effect["step_" + var_1]["soldier"];

  playFX(level._effect["step_" + var_1][self.unittype], var_2, var_4, var_5);
  return 1;
}

playfootstepeffectsmall(var_0, var_1) {
  if(!isDefined(anim.optionalstepeffectssmall[var_1]))
    return 0;

  var_2 = self gettagorigin(var_0);
  var_3 = self.angles;
  var_4 = anglesToForward(var_3);
  var_5 = anglestoup(var_3);

  if(!isDefined(level._effect["step_small_" + var_1][self.unittype]))
    level._effect["step_small_" + var_1][self.unittype] = level._effect["step_small_" + var_1]["soldier"];

  playFX(level._effect["step_small_" + var_1][self.unittype], var_2, var_4, var_5);
  return 1;
}

get_notetrack_movement() {
  var_0 = "run";
  var_1 = undefined;

  if(isDefined(self.asm))
    var_1 = scripts\asm\shared\utility::getbasearchetype();

  if(isDefined(var_1) && hasanimspeedthresholdstring(var_1) && getanimspeedthreshold(var_1, "sprint") && isDefined(self.velocity)) {
    var_2 = getcoveranglelimits(var_1, "run", "sprint", 0.8);

    if(length2d(self.velocity) > var_2)
      var_0 = "sprint";
  }

  if(isDefined(self._blackboard)) {
    if(self._blackboard.movetype == "walk" || self._blackboard.movetype == "casual_gun" || self._blackboard.movetype == "patrol" || self._blackboard.movetype == "casual")
      var_0 = "walk";

    if(scripts\asm\asm_bb::bb_getrequestedstance() == "prone")
      var_0 = "prone";
  } else if(isDefined(self.a)) {
    if(isDefined(self.a.movement)) {
      if(self.a.movement == "walk")
        var_0 = "walk";
    }

    if(isDefined(self.currentpose)) {
      if(self.currentpose == "prone")
        var_0 = "prone";
    }
  }

  return var_0;
}

notetracklaser(var_0, var_1) {
  if(var_0 == "laser_on")
    self.a.laseron = 1;
  else
    self.a.laseron = 0;

  scripts\anim\shared.gsc::updatelaserstatus();
}

notetrackgunhand(var_0, var_1) {
  if(issubstr(var_0, "left")) {
    scripts\anim\shared.gsc::placeweaponon(self.weapon, "left");
    self notify("weapon_switch_done");
  } else if(issubstr(var_0, "right")) {
    scripts\anim\shared.gsc::placeweaponon(self.weapon, "right");
    self notify("weapon_switch_done");
  } else if(issubstr(var_0, "none"))
    scripts\anim\shared.gsc::placeweaponon(self.weapon, "none");
}

notetrackposestand(var_0, var_1) {
  if(self.currentpose == "prone")
    scripts\anim\utility.gsc::exitpronewrapper(1.0);

  setpose("stand");
}

notetrackposecrouch(var_0, var_1) {
  if(self.currentpose == "prone")
    scripts\anim\utility.gsc::exitpronewrapper(1.0);

  setpose("crouch");
}

#using_animtree("generic_human");

notetrackposeprone(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  self setproneanimnodes(-45, 45, %prone_legs_down, %prone_dummy, %prone_legs_up);
  scripts\anim\utility.gsc::enterpronewrapper(0.5);
  setpose("prone");

  if(isDefined(self.a.goingtoproneaim))
    self.a.proneaiming = 1;
  else
    self.a.proneaiming = undefined;
}

notetrackposecrawl(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  self setproneanimnodes(-45, 45, %prone_legs_down, %prone_dummy, %prone_legs_up);
  scripts\anim\utility.gsc::enterpronewrapper(1.0);
  setpose("prone");
  self.a.proneaiming = undefined;
}

notetrackposeback(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  setpose("crouch");
  self.a.onback = 1;
  self.a.movement = "stop";
  self setproneanimnodes(-90, 90, %prone_legs_down, %prone_dummy, %prone_legs_up);
  scripts\anim\utility.gsc::enterpronewrapper(1.0);
}

notetrackrocketlauncherammoattach() {
  if(!isalive(self)) {
    return;
  }
  if(!scripts\anim\utility_common.gsc::usingrocketlauncher()) {
    return;
  }
  if(self tagexists("tag_accessory_left"))
    self showpart("tag_rocket");
}

notetrackdropclip(var_0, var_1) {
  thread scripts\anim\shared.gsc::handledropclip(var_1);
}

notetrackhelmetpop(var_0, var_1) {
  if(isDefined(self.fnhelmetpop)) {
    self[[self.fnhelmetpop]]();
    self.dontbreakhelmet = 1;
  }
}

notetrackstartragdoll(var_0, var_1) {
  if(isDefined(self.noragdoll)) {
    return;
  }
  if(isDefined(self.ragdolltime)) {
    return;
  }
  if(!isDefined(self.dont_unlink_ragdoll))
    thread unlinknextframe();

  if(isDefined(self._blackboard)) {
    if(isDefined(self._blackboard.awaitingdropgunnotetrack) && self._blackboard.awaitingdropgunnotetrack == 1) {
      scripts\anim\shared.gsc::dropaiweapon();
      self.lastweapon = self.weapon;
    }
  }

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  if(isDefined(self))
    self startragdoll();
}

notetrackragdollblendinit(var_0, var_1) {
  if(isDefined(self.noragdoll)) {
    return;
  }
  if(isDefined(self.ragdolltime)) {
    return;
  }
  if(!isDefined(self.dont_unlink_ragdoll))
    thread unlinknextframe();

  if(isDefined(self._blackboard)) {
    if(isDefined(self._blackboard.awaitingdropgunnotetrack) && self._blackboard.awaitingdropgunnotetrack == 1) {
      scripts\anim\shared.gsc::dropaiweapon();
      self.lastweapon = self.weapon;
    }
  }

  if(isDefined(self.fnpreragdoll))
    self[[self.fnpreragdoll]]();

  self ragdollblendinit();
}

notetrackragdollblendstart(var_0, var_1) {}

notetrackragdollblendend(var_0, var_1) {}

notetrackragdollblendrootanim(var_0, var_1) {}

notetrackragdollblendrootragdoll(var_0, var_1) {}

notetrackgundrop(var_0, var_1) {
  scripts\anim\shared.gsc::dropaiweapon();
  self._blackboard.awaitingdropgunnotetrack = 0;
  self.lastweapon = self.weapon;
}

setpose(var_0) {
  self.currentpose = var_0;

  if(isDefined(self.a.onback))
    scripts\anim\utility.gsc::stoponback();

  scripts\asm\asm_bb::bb_requeststance(var_0);
  self notify("entered_pose" + var_0);
}

unlinknextframe() {
  wait 0.1;

  if(isDefined(self))
    self unlink();
}

notetrack_model_attach(var_0) {
  var_1 = strtok(var_0, " ,");
  var_2 = var_1[0];
  var_3 = var_1[1];

  if(isDefined(level.fnnotetrackmodeltranslate))
    var_2 = [[level.fnnotetrackmodeltranslate]](var_2);

  var_2 = tolower(var_2);
  var_3 = tolower(var_3);

  if(isDefined(self.note_attach) && isDefined(self.note_attach[var_3])) {
    self detach(self.note_attach[var_3], var_3);
    self.note_attach[var_3] = undefined;
  }

  if(var_2 != "none" && var_2 != "") {
    self attach(var_2, var_3, 1);
    self.note_attach[var_3] = var_2;
  }
}

notetrack_model_clear() {
  if(isDefined(self.note_attach)) {
    foreach(var_2, var_1 in self.note_attach)
    self detach(var_1, var_2);
  }

  self.note_attach = undefined;
}

notetrack_model_translate(var_0) {
  var_1 = var_0;

  switch (var_0) {
    case "primary":
    case "offhand":
    case "pistol":
      if(isDefined(self.weaponinfo)) {
        foreach(var_6, var_3 in self.weaponinfo) {
          var_4 = strtok(var_6, "+")[0];
          var_5 = isundefinedweapon();

          if(isDefined(var_4) && var_4 != "none" && var_4 != "")
            var_5 = scripts\sp\utility::make_weapon(var_4);

          if(var_0 == "pistol" && var_5.classname == "pistol") {
            var_1 = getweaponmodel(var_5);
            continue;
          }

          if(var_0 != "pistol" && var_5.inventorytype == var_0 && var_1 == var_0)
            var_1 = getweaponmodel(var_5);
        }
      }

      if(var_1 == var_0)
        var_1 = "none";

      break;
  }

  return var_1;
}

notetrack_vo(var_0) {
  if(isDefined(self.anim_playsound_func))
    self thread[[self.anim_playsound_func]](var_0, "j_head", 1);
  else if(isDefined(self.anim_playvo_func))
    self thread[[self.anim_playvo_func]](var_0, "j_head", 1);
  else if(!issentient(self))
    thread scripts\engine\utility::playsoundontag(var_0, "j_head", 1, var_0);
  else
    scripts\sp\anim::play_sound_at_viewheight(var_0, "sounddone", 1);
}

notetrack_prefix_handler_sp(var_0) {
  var_1 = getsubstr(var_0, 0, 3);

  if(var_1 == "ps_") {
    var_2 = getsubstr(var_0, 3);

    if(isDefined(self.anim_playsound_func))
      self thread[[self.anim_playsound_func]](var_2, "j_head", 1);
    else {
      var_3 = strtok(var_2, ",");

      if(var_3.size < 2)
        thread scripts\engine\utility::playsoundontag(var_2, undefined, 1);
      else
        thread scripts\engine\utility::playsoundontag(var_3[0], var_3[1], 1);
    }

    return 1;
  }

  if(var_1 == "vo_") {
    if(canplaynotetrackvo()) {
      var_2 = getsubstr(var_0, 3);
      notetrack_vo(var_2);
      return 1;
    }
  }

  if(var_1 == "bc_") {
    if(canplaynotetrackvo()) {
      var_4 = getsubstr(var_0, 3);
      var_1 = scripts\anim\battlechatter.gsc::bc_prefix("custom");
      var_2 = var_1 + var_4;

      if(soundexists(var_2))
        notetrack_vo(var_2);

      return 1;
    }
  }

  if(var_1 == "sd_") {
    if(canplaynotetrackvo()) {
      var_2 = getsubstr(var_0, 3);

      if(isDefined(self.anim_smartdialog_func))
        self thread[[self.anim_smartdialog_func]](var_2);
      else
        thread scripts\engine\sp\utility::smart_dialogue(var_2);

      return 1;
    }
  }

  if(var_1 == "sr_") {
    if(canplaynotetrackvo()) {
      var_2 = getsubstr(var_0, 3);
      level thread scripts\engine\sp\utility::smart_radio_dialogue(var_2);
      return 1;
    }
  }

  if(var_1 == "rm_") {
    var_5 = getsubstr(var_0, 3);
    level.player playRumbleOnEntity(var_5);
    return 1;
  }

  if(var_1 == "fx_") {
    var_6 = strtok(tolower(var_0), "[]");
    var_7 = strtok(getsubstr(var_6[0], 3), ",() ");
    var_8 = [];

    if(var_6.size > 1) {
      for(var_9 = 1; var_9 < var_6.size; var_9++) {
        var_10 = strtok(var_6[var_9], ",");

        if(var_10.size > 1) {
          var_7 = scripts\engine\utility::array_add(var_7, (float(var_10[0]), float(var_10[1]), float(var_10[2])));
          continue;
        }

        var_7 = scripts\engine\utility::array_add(var_7, var_10[0]);
      }
    }

    if(var_7.size == 2) {
      if(var_7[0] == "exploder") {
        scripts\engine\utility::exploder(var_7[1]);
        return 1;
      } else if(var_7[0] == "stop_exploder") {
        scripts\engine\utility::stop_exploder(var_7[1]);
        return 1;
      } else {
        playFXOnTag(level._effect[var_7[0]], self, var_7[1]);
        return 1;
      }
    } else if(var_7.size == 3) {
      if(var_7[0] == "playfxontag") {
        playFXOnTag(level._effect[var_7[1]], self, var_7[2]);
        return 1;
      } else if(var_7[0] == "stopfxontag") {
        stopFXOnTag(level._effect[var_7[1]], self, var_7[2]);
        return 1;
      } else if(var_7[0] == "killfxontag") {
        killfxontag(level._effect[var_7[1]], self, var_7[2]);
        return 1;
      }
    } else if(var_7.size == 6) {
      if(var_7[0] == "debris") {
        playFXOnTag(level._effect[var_7[1]], self, var_7[2]);
        self hidepart(var_7[2], var_7[3]);
        return 1;
      }
    } else if(var_7.size == 11) {
      var_11 = (float(var_7[2]), float(var_7[3]), float(var_7[4]));
      var_12 = (float(var_7[5]), float(var_7[6]), float(var_7[7]));
      var_13 = (float(var_7[8]), float(var_7[9]), float(var_7[10]));
      playFX(level._effect[var_7[1]], var_11, var_12, var_13);
    }
  }

  if(var_1 == "ht_") {
    var_14 = getsubstr(var_0, 3, var_0.size);

    if(var_14 == "on" || var_14 == "on_0") {
      if(!isDefined(self.ht_on)) {
        self.ht_on = 1;
        self setuplookatfornotetrack();
      }

      scripts\common\utility::lookatentity(level.player, 0);
    } else if(var_14 == "on_1") {
      if(!isDefined(self.ht_on)) {
        self.ht_on = 1;
        self setuplookatfornotetrack();
      }

      scripts\common\utility::lookatentity(level.player, 1);
    } else
      scripts\asm\shared\utility::cleanupanimscriptedheadlook();

    return 1;
  }

  if(var_1 == "ms_") {
    var_15 = getsubstr(var_0, 3, var_0.size);
    var_16 = scripts\asm\shared\utility::getbasearchetype();
    var_17 = getnearestspeedthresholdname(var_16, var_15);
    self aisetdesiredspeed(var_17);
    self aisettargetspeed(var_17);
    return 1;
  }

  if(var_1 == "at_") {
    notetrack_model_attach(getsubstr(var_0, 3));
    return 1;
  }

  var_1 = getsubstr(var_0, 0, 4);

  if(var_1 == "psr_") {
    if(canplaynotetrackvo()) {
      var_2 = getsubstr(var_0, 4);
      scripts\engine\sp\utility::radio_dialogue(var_2);
      return 1;
    }
  }

  if(var_1 == "pip_") {
    if(canplaynotetrackvo()) {
      var_2 = getsubstr(var_0, 4);

      if(isDefined(self.anim_playsound_func))
        self thread[[self.anim_playsound_func]](var_2, "j_head", 1);
      else
        thread scripts\sp\pip_util::pip_dialogue(var_2);

      return 1;
    }
  }

  if(var_1 == "pvo_") {
    if(canplaynotetrackvo()) {
      var_2 = getsubstr(var_0, 4);
      thread scripts\engine\sp\utility::smart_player_dialogue(var_2);
      return 1;
    }
  }

  if(var_1 == "fov_") {
    var_18 = strtok(var_0, "_");
    var_19 = var_18[1];
    var_20 = 65.0;
    var_21 = undefined;

    if(var_19 == "start") {
      var_20 = float(var_18[2]);
      var_21 = float(var_18[3]);
      level.player modifybasefov(var_20, var_21);
    } else {
      var_21 = float(var_18[2]);
      level.player modifybasefov(var_20, var_21);
    }

    return 1;
  }

  var_1 = getsubstr(var_0, 0, 4);

  if(var_1 == "hts_") {
    var_22 = getsubstr(var_0, 4);

    if(var_22 == "off")
      scripts\common\utility::lookatstateoverride();
    else
      scripts\common\utility::lookatstateoverride(var_22);

    return 1;
  }

  return scripts\anim\notetracks.gsc::notetrack_prefix_handler_common(var_0);
}

canplaynotetrackvo() {
  if(level.missionfailed && !level.notetrackmissionfailedvo)
    return 0;

  if(!level.notetrackvo)
    return 0;

  return 1;
}

eyeonnotehandler(var_0, var_1) {
  self setanim(%lookatplayer_node, 1.0, 0.2, 1.0);
}

eyeoffnotehandler(var_0, var_1) {
  self clearanim(%lookatplayer_node, 0.2);
}