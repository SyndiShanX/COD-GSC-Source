/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\notetracks_sp.gsc
***********************************************/

function registernotetracksifnot() {
  if(isDefined(anim.notetracks)) {
    return;
  }

  anim.notetracks = [];
  registernotetracks();
}

function registernotetracks() {
  level._defaultnotetrackhandler = &handlenotetrack;
  level.fnnotetrackprefixhandler = &notetrack_prefix_handler_sp;
  level.fnnotetrackmodeltranslate = &notetrack_model_translate;
  scripts\anim\notetracks::registernotetracks();
  anim.notetracks["fingers_out_start_left_hand"] = &notetrackfingerposeoffleft;
  anim.notetracks["fingers_out_start_right_hand"] = &notetrackfingerposeoffright;
  anim.notetracks["fingers_in_start_left_hand"] = &notetrackfingerposeonleft;
  anim.notetracks["fingers_in_start_right_hand"] = &notetrackfingerposeonright;
  anim.notetracks["anim_facial = idle"] = &notetrackfacialidle;
  anim.notetracks["anim_facial = run"] = &notetrackfacialrun;
  anim.notetracks["anim_facial = pain"] = &notetrackfacialpain;
  anim.notetracks["anim_facial = death"] = &notetrackfacialdeath;
  anim.notetracks["anim_facial = talk"] = &notetrackfacialtalk;
  anim.notetracks["anim_facial = cheer"] = &notetrackfacialcheer;
  anim.notetracks["anim_facial = happy"] = &notetrackfacialhappy;
  anim.notetracks["anim_facial = angry"] = &notetrackfacialangry;
  anim.notetracks["anim_facial = scared"] = &notetrackfacialscared;
  anim.notetracks["anim_facial = gas_death"] = &notetrackfacialgasdeath;
  anim.notetracks["visor_raise"] = &notetrackvisorraise;
  anim.notetracks["visor_lower"] = &notetrackvisorlower;
  anim.notetracks["visor_lower_instant"] = &notetrackvisorlower_instant;
  anim.notetracks["visor_raise_instant"] = &notetrackvisorraise_instant;
  anim.notetracks["visor_lower_price_instant"] = &notetrackvisorpricelower_instant;
  anim.notetracks["visor_raise_price_instant"] = &notetrackvisorpriceraise_instant;
  anim.notetracks["visor_clearanim"] = &notetrackvisorraise_clear;
  anim.notetracks["bloodpool"] = &scripts\anim\death::play_blood_pool;
  anim.notetracks["footstep_right_large"] = &notetrackfootstep;
  anim.notetracks["footstep_right_small"] = &notetrackfootstep;
  anim.notetracks["footstep_left_large"] = &notetrackfootstep;
  anim.notetracks["footstep_left_small"] = &notetrackfootstep;
  anim.notetracks["footstep_right_large_vfxonly"] = &notetrackfootstep;
  anim.notetracks["footstep_right_small_vfxonly"] = &notetrackfootstep;
  anim.notetracks["footstep_left_large_vfxonly"] = &notetrackfootstep;
  anim.notetracks["footstep_left_small_vfxonly"] = &notetrackfootstep;
  anim.notetracks["mvmt_step_pre"] = &notetrackmovement;
  anim.notetracks["mvmt_step_post"] = &notetrackmovement;
  anim.notetracks["footscrape"] = &notetrackfootscrape;
  anim.notetracks["land"] = &notetrackland;
  anim.notetracks["handstep_left"] = &notetrackhandstep;
  anim.notetracks["handstep_right"] = &notetrackhandstep;
  anim.notetracks["laser_on"] = &notetracklaser;
  anim.notetracks["laser_off"] = &notetracklaser;
  anim.notetracks["start_ragdoll"] = &notetrackstartragdoll;
  anim.notetracks["ragdollblendinit"] = &notetrackragdollblendinit;
  anim.notetracks["ragdollblendstart"] = &notetrackragdollblendstart;
  anim.notetracks["ragdollblendend"] = &notetrackragdollblendend;
  anim.notetracks["ragdollblendrootanim"] = &notetrackragdollblendrootanim;
  anim.notetracks["ragdollblendrootragdoll"] = &notetrackragdollblendrootragdoll;
  anim.notetracks["drop clip"] = &notetrackdropclip;
  anim.notetracks["helmet_pop"] = &notetrackhelmetpop;
  anim.notetracks["gun drop"] = &notetrackgundrop;
  anim.notetracks["dropgun"] = &notetrackgundrop;
  anim.notetracks["gunhand = (gunhand)_left"] = &notetrackgunhand;
  anim.notetracks["anim_gunhand = left"] = &notetrackgunhand;
  anim.notetracks["gunhand = (gunhand)_right"] = &notetrackgunhand;
  anim.notetracks["anim_gunhand = right"] = &notetrackgunhand;
  anim.notetracks["anim_gunhand = none"] = &notetrackgunhand;
  anim.notetracks["anim_pose = \"stand\""] = &notetrackposestand;
  anim.notetracks["anim_pose = \"crouch\""] = &notetrackposecrouch;
  anim.notetracks["anim_pose = \"prone\""] = &notetrackposeprone;
  anim.notetracks["anim_pose = \"crawl\""] = &notetrackposecrawl;
  anim.notetracks["anim_pose = \"back\""] = &notetrackposeback;
  anim.notetracks["anim_gunhand = \"left\""] = &notetrackgunhand;
  anim.notetracks["anim_gunhand = \"right\""] = &notetrackgunhand;
  anim.notetracks["anim_gunhand = \"none\""] = &notetrackgunhand;
  anim.notetracks["anim_pose = stand"] = &notetrackposestand;
  anim.notetracks["anim_pose = crouch"] = &notetrackposecrouch;
  anim.notetracks["anim_pose = prone"] = &notetrackposeprone;
  anim.notetracks["anim_pose = crawl"] = &notetrackposecrawl;
  anim.notetracks["anim_pose = back"] = &notetrackposeback;
  anim.notetracks["eyes_on"] = &eyeonnotehandler;
  anim.notetracks["eyes_off"] = &eyeoffnotehandler;
}

function handlenotetrack(var0, var1, var2, var3) {
  if(scripts\anim\notetracks::hascustomnotetrackhandler(var0)) {
    return scripts\anim\notetracks::handlecustomnotetrackhandler(var0, var1, var2, var3);
  }

  var4 = scripts\anim\notetracks::handlecommonnotetrack(var0, var1, var2, var3);

  if(isDefined(var4) && var4 == "__unhandled") {
    var4 = undefined;

    switch (var0) {
      case "stop anim":
        scripts\engine\sp\utility::anim_stopanimScripted();
        return var0;
      case "rechamber":
        if(scripts\anim\utility_common::weapon_pump_action_shotgun()) {
          self playSound("weap_reload_shotgun_pump_npc");
        }

        self.a.needstorechamber = 0;
        break;
      case "attach_clip_left":
        if(scripts\anim\utility_common::usingrocketlauncher()) {
          notetrackrocketlauncherammoattach();
        }

        break;
      default:
        if(isDefined(var2)) {
          if(isDefined(var3)) {
            return [[var2]](var0, var3);
          } else {
            return [[var2]](var0);
          }
        }

        break;
    }
  }

  return var4;
}

function notetrackvisorraise(var0, var1) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise();
}

function notetrackvisorlower(var0, var1) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise();
}

function notetrackvisorlower_instant(var0, var1) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise("_instant");
}

function notetrackvisorraise_instant(var0, var1) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise("_instant");
}

function notetrackvisorpricelower_instant(var0, var1) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise("_price_instant");
}

function notetrackvisorpriceraise_instant(var0, var1) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise("_price_instant");
}

function notetrackvisorraise_clear(var0, var1) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_clearvisoranim();
}

function notetrackfingerposeoffleft(var0, var1) {
  scripts\asm\asm_sp::asm_clearikfingeranim("left");
}

function notetrackfingerposeonleft(var0, var1) {
  scripts\asm\asm_sp::asm_ikfingeranim("left");
}

function notetrackfingerposeoffright(var0, var1) {
  scripts\asm\asm_sp::asm_clearikfingeranim("left");
}

function notetrackfingerposeonright(var0, var1) {
  scripts\asm\asm_sp::asm_ikfingeranim("right");
}

function notetrackfacialidle(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("idle");
}

function notetrackfacialrun(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("run");
}

function notetrackfacialpain(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("pain");
}

function notetrackfacialdeath(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("death");
}

function notetrackfacialtalk(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("talk");
}

function notetrackfacialcheer(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("cheer");
}

function notetrackfacialhappy(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("happy");
}

function notetrackfacialscared(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("scared");
}

function notetrackfacialangry(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("angry");
}

function notetrackfacialgasdeath(var0, var1) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("gas_death");
}

function notetrackmovement(var0, var1) {
  var2 = 1;

  if(issubstr(var0, "post")) {
    var2 = 2;
  }

  var3 = get_notetrack_movement();

  if(isDefined(self.classname) && self.classname != "script_model") {
    self playclothmovesound(var3, var2);
    return;
  }
}

function notetrackfootstep(var0, var1) {
  var2 = issubstr(var0, "left");
  var3 = issubstr(var0, "large");
  var4 = issubstr(var0, "vfxonly");
  var5 = "right";

  if(var2) {
    var5 = "left";
  }

  if(isai(self)) {
    self.asm.footsteps.foot = var5;
    self.asm.footsteps.time = gettime();
  }

  if(scripts\asm\asm_bb::ispartdismembered("left_leg") || scripts\asm\asm_bb::ispartdismembered("right_leg")) {
    return;
  }

  playfootstep(var2, var3, var4);

  if(isDefined(self.classname) && self.classname != "script_model" && isDefined(self.weapon) && !var4) {
    var6 = get_notetrack_movement();
    var7 = self playequipmovesound(var6, self.weapon);
    return;
  }
}

function notetrackfootscrape(var0, var1) {
  if(isDefined(self.groundtype)) {
    var2 = self.groundtype;
    return;
  }

  var2 = "dirt";
}

function notetrackland(var0, var1) {
  if(isDefined(self.groundtype)) {
    var2 = self.groundtype;
  } else {
    var2 = "dirt";
  }

  self playsurfacesound("step_default_npc_land", var2);
  self playclothmovesound("land", 2);
  self playequipmovesound("land", self.weapon);
}

function playfootstep(var0, var1, var2) {
  if(!isai(self)) {
    if(!var2) {
      self playsurfacesound("step_default_npc_run", "dirt");
    }

    return;
  }

  var3 = undefined;
  var4 = "step_";
  var5 = self.stairsstate;

  if(var5 == "up") {
    var4 = "stepstairup_";
  } else if(var5 == "down") {
    var4 = "stepstairdown_";
  }

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      if(!var2) {
        self playsurfacesound(var4 + "default_npc_run", "dirt");
      }

      return;
    }

    var3 = self.lastgroundtype;
  } else {
    var3 = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }

  var6 = "J_Ball_RI";

  if(var0) {
    var6 = "J_Ball_LE";
  }

  var7 = get_notetrack_movement();

  if(self.unittype == "soldier" || self.unittype == "civilian" || self.unittype == "juggernaut" || self.unittype == "suicidebomber") {
    var8 = "";
  } else {
    var8 = tolower(self.unittype + "_");
  }

  var9 = undefined;

  if(isDefined(level.fngetfootstepsound)) {
    var9 = self[[level.fngetfootstepsound]](var8, var4, var7);
  }

  if(!isDefined(var9)) {
    var9 = var8 + var5 + "default_npc_" + var8;
  }

  if(soundexists(var9) && var9 != "none" && !var3) {
    thread scripts\engine\sp\utility::play_footstep_sound(var9, var4);
  }

  if(self isscriptable()) {
    return;
  }

  if(var2) {
    if(![[anim.fnfootstepeffect]](var7, var4)) {
      playfootstepeffectsmall(var7, var4);
    }
  } else if(![[anim.fnfootstepeffectsmall]](var7, var4)) {
    playfootstepeffect(var7, var4);
  }

  if(![[anim.fnfootprinteffect]](var7, var4)) {
    playfootprinteffect(var7, var4);
    return;
  }
}

function playhandstep(var0, var1) {
  if(!isai(self)) {
    self playsurfacesound("c6_handstep", "default");
    return;
  }

  if(var0) {
    var2 = "J_MID_LE_1";

    if(scripts\aitypes\dismember::get_scriptablepartinfo("left_arm") == "dismember") {
      return;
    }
  } else {
    var2 = "J_MID_RI_1";

    if(scripts\aitypes\dismember::get_scriptablepartinfo("right_arm") == "dismember") {
      return;
    }
  }

  var3 = undefined;

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      self playsurfacesound("c6_handstep", "default");
      return;
    }

    var3 = self.lastgroundtype;
  } else {
    var3 = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }

  var4 = get_notetrack_movement();
  var5 = "c6_handstep";

  if(soundexists(var5)) {
    self playsurfacesound(var5, var3);
  }

  if(![[anim.optionalstepeffectsmallfunction]](var2, var3)) {
    playfootstepeffect(var2, var3);
  }

  if(![[anim.optionalfootprinteffectfunction]](var2, var3)) {
    playfootprinteffect(var2, var3);
    return;
  }
}

function notetrackhandstep(var0, var1) {
  var2 = issubstr(var0, "left");
  var3 = issubstr(var0, "large");
  var4 = "right";

  if(var2) {
    var4 = "left";
  }

  if(isai(self)) {
    self.asm.footsteps.foot = var4;
    self.asm.footsteps.time = gettime();
  }

  playhandstep(var2, var3);
}

function playfootprinteffect(var0, var1) {
  if(!isDefined(anim.optionalfootprinteffects[var1])) {
    return false;
  }

  var2 = self gettagorigin(var0);
  var3 = self gettagangles(var0);
  var4 = anglestoright(var3) * -1;
  var5 = anglesToForward(var3);
  var6 = var2 + var4 * -5;
  var7 = var2 + var4 * 20;
  var8 = scripts\engine\trace::_bullet_trace(var6, var7, 0, self, 0, 0, 0, 0);

  if(var8["fraction"] == 1) {
    return true;
  }

  if(!isDefined(level._effect["footprint_" + var1][self.unittype])) {
    level._effect["footprint_" + var1][self.unittype] = level._effect["footprint_" + var1]["soldier"];
  }

  if(!anim.flirfootprinteffects) {
    playFX(level._effect["footprint_" + var1][self.unittype], var8["position"], var8["normal"], var5);
  } else {
    thread track_flir_footstep(level._effect["footprint_" + var1][self.unittype], var8["position"], var8["normal"], var5);
  }

  return true;
}

function track_flir_footstep(var0, var1, var2, var3) {
  var4 = spawnStruct();
  var4.effectid = var0;
  var4.org = var1;
  var4.forwardv = var2;
  var4.upv = var3;
  var4.spawntime = gettime();
  var4.active = 0;
  anim.flirfootprints = scripts\engine\utility::array_add(anim.flirfootprints, var4);

  if(level.player isnightvisionon() && level.player scripts\engine\sp\utility::is_flir_vision_on()) {
    thread play_flir_footstep_fx();
  }

  wait 10;
  anim.flirfootprints = scripts\engine\utility::array_remove(anim.flirfootprints, var4);
}

function play_flir_footstep_fx() {
  if(self.active) {
    return;
  }

  self.active = 1;
  self.fx = spawnfx(self.effectid, self.org, self.forwardv, self.upv);
  triggerfx(self.fx, self.spawntime / 1000);
}

function kill_flir_footstep_fx() {
  if(!self.active) {
    return;
  }

  self.active = 0;
  self.fx delete();
}

function playfootstepeffect(var0, var1) {
  if(!isDefined(anim.optionalstepeffects[var1])) {
    return false;
  }

  var2 = self gettagorigin(var0);
  var3 = self.angles;
  var4 = anglesToForward(var3);
  var5 = anglestoup(var3);

  if(!isDefined(level._effect["step_" + var1][self.unittype])) {
    level._effect["step_" + var1][self.unittype] = level._effect["step_" + var1]["soldier"];
  }

  playFX(level._effect["step_" + var1][self.unittype], var2, var4, var5);
  return true;
}

function playfootstepeffectsmall(var0, var1) {
  if(!isDefined(anim.optionalstepeffectssmall[var1])) {
    return false;
  }

  var2 = self gettagorigin(var0);
  var3 = self.angles;
  var4 = anglesToForward(var3);
  var5 = anglestoup(var3);

  if(!isDefined(level._effect["step_small_" + var1][self.unittype])) {
    level._effect["step_small_" + var1][self.unittype] = level._effect["step_small_" + var1]["soldier"];
  }

  playFX(level._effect["step_small_" + var1][self.unittype], var2, var4, var5);
  return true;
}

function get_notetrack_movement() {
  var0 = "run";
  var1 = undefined;

  if(isDefined(self.asm)) {
    var1 = scripts\asm\shared\utility::getbasearchetype();
  }

  if(isDefined(var1) && hasanimspeedthresholdstring(var1) && getanimspeedthreshold(var1, "sprint") && isDefined(self.velocity)) {
    var2 = getcoveranglelimits(var1, "run", "sprint", 0.8);

    if(length2d(self.velocity) > var2) {
      var0 = "sprint";
    }
  }

  if(isDefined(self._blackboard)) {
    if(self._blackboard.movetype == "walk" || self._blackboard.movetype == "casual_gun" || self._blackboard.movetype == "patrol" || self._blackboard.movetype == "casual") {
      var0 = "walk";
    }

    if(scripts\asm\asm_bb::bb_getrequestedstance() == "prone") {
      var0 = "prone";
    }
  } else if(isDefined(self.a)) {
    if(isDefined(self.a.movement)) {
      if(self.a.movement == "walk") {
        var0 = "walk";
      }
    }

    if(isDefined(self.currentpose)) {
      if(self.currentpose == "prone") {
        var0 = "prone";
      }
    }
  }

  return var0;
}

function notetracklaser(var0, var1) {
  if(var0 == "laser_on") {
    self.a.laseron = 1;
  } else {
    self.a.laseron = 0;
  }

  scripts\anim\shared::updatelaserstatus();
}

function notetrackgunhand(var0, var1) {
  if(issubstr(var0, "left")) {
    scripts\anim\shared::placeweaponon(self.weapon, "left");
    self notify("weapon_switch_done");
    return;
  }

  if(issubstr(var0, "right")) {
    scripts\anim\shared::placeweaponon(self.weapon, "right");
    self notify("weapon_switch_done");
    return;
  }

  if(issubstr(var0, "none")) {
    scripts\anim\shared::placeweaponon(self.weapon, "none");
    return;
  }
}

function notetrackposestand(var0, var1) {
  if(self.currentpose == "prone") {
    scripts\anim\utility::exitpronewrapper(1);
  }

  setpose("stand");
}

function notetrackposecrouch(var0, var1) {
  if(self.currentpose == "prone") {
    scripts\anim\utility::exitpronewrapper(1);
  }

  setpose("crouch");
}

#using_animtree("");

function notetrackposeprone(var0, var1) {
  if(!issentient(self)) {
    return;
  }

  self setproneanimnodes(-45, 45, %prone_legs_down, $prone_dummy, %prone_legs_up);
  scripts\anim\utility::enterpronewrapper(0.5);
  setpose("prone");

  if(isDefined(self.a.goingtoproneaim)) {
    self.a.proneaiming = 1;
    return;
  }

  self.a.proneaiming = undefined;
}

function notetrackposecrawl(var0, var1) {
  if(!issentient(self)) {
    return;
  }

  self setproneanimnodes(-45, 45, %prone_legs_down, %prone_dummy, %prone_legs_up);
  scripts\anim\utility::enterpronewrapper(1);
  setpose("prone");
  self.a.proneaiming = undefined;
}

function notetrackposeback(var0, var1) {
  if(!issentient(self)) {
    return;
  }

  setpose("crouch");
  self.a.onback = 1;
  self.a.movement = "stop";
  self setproneanimnodes(-90, 90, %prone_legs_down, %prone_dummy, %prone_legs_up);
  scripts\anim\utility::enterpronewrapper(1);
}

function notetrackrocketlauncherammoattach() {
  if(!isalive(self)) {
    return;
  }

  if(!scripts\anim\utility_common::usingrocketlauncher()) {
    return;
  }

  if(self tagexists("tag_accessory_left")) {
    self showpart("tag_rocket");
    return;
  }
}

function notetrackdropclip(var0, var1) {
  thread scripts\anim\shared::handledropclip(var1);
}

function notetrackhelmetpop(var0, var1) {
  if(isDefined(self.fnhelmetpop)) {
    self[[self.fnhelmetpop]]();
    self.dontbreakhelmet = 1;
    return;
  }
}

function notetrackstartragdoll(var0, var1) {
  if(isDefined(self.noragdoll)) {
    return;
  }

  if(isDefined(self.ragdolltime)) {
    return;
  }

  if(!isDefined(self.dont_unlink_ragdoll)) {
    thread unlinknextframe();
  }

  if(isDefined(self._blackboard)) {
    if(isDefined(self._blackboard.awaitingdropgunnotetrack) && self._blackboard.awaitingdropgunnotetrack == 1) {
      scripts\anim\shared::dropaiweapon();
      self.lastweapon = self.weapon;
    }
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(isDefined(self)) {
    self startragdoll();
    return;
  }
}

function notetrackragdollblendinit(var0, var1) {
  if(isDefined(self.noragdoll)) {
    return;
  }

  if(isDefined(self.ragdolltime)) {
    return;
  }

  if(!isDefined(self.dont_unlink_ragdoll)) {
    thread unlinknextframe();
  }

  if(isDefined(self._blackboard)) {
    if(isDefined(self._blackboard.awaitingdropgunnotetrack) && self._blackboard.awaitingdropgunnotetrack == 1) {
      scripts\anim\shared::dropaiweapon();
      self.lastweapon = self.weapon;
    }
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  self ragdollblendinit();
}

function notetrackragdollblendstart(var0, var1) {}

function notetrackragdollblendend(var0, var1) {}

function notetrackragdollblendrootanim(var0, var1) {}

function notetrackragdollblendrootragdoll(var0, var1) {}

function notetrackgundrop(var0, var1) {
  scripts\anim\shared::dropaiweapon();
  self._blackboard.awaitingdropgunnotetrack = 0;
  self.lastweapon = self.weapon;
}

function setpose(var0) {
  self.currentpose = var0;

  if(isDefined(self.a.onback)) {
    scripts\anim\utility::stoponback();
  }

  scripts\asm\asm_bb::bb_requeststance(var0);
  self notify("entered_pose" + var0);
}

function unlinknextframe() {
  wait 0.1;

  if(isDefined(self)) {
    self unlink();
    return;
  }
}

function notetrack_model_attach(var0) {
  [var2] = strtok(var0, " ,");
  var3 = var1[1];

  if(isDefined(level.fnnotetrackmodeltranslate)) {
    var2 = [[level.fnnotetrackmodeltranslate]](var2);
  }

  var2 = tolower(var2);
  var3 = tolower(var3);

  if(isDefined(self.note_attach) && isDefined(self.note_attach[var3])) {
    self detach(self.note_attach[var3], var3);
    self.note_attach[var3] = undefined;
  }

  if(var2 != "none" && var2 != "") {
    self attach(var2, var3, 1);
    self.note_attach[var3] = var2;
    return;
  }
}

function notetrack_model_clear() {
  if(isDefined(self.note_attach)) {
    foreach(var1 in self.note_attach) {
      self detach(var1, var2);
    }
  }

  self.note_attach = undefined;
}

function notetrack_model_translate(var0) {
  var1 = var0;

  switch (var0) {
    case "primary":
    case "offhand":
    case "pistol":
      if(isDefined(self.weaponinfo)) {
        foreach(var3 in self.weaponinfo) {
          var4 = strtok(var6, "+")[0];
          var5 = isundefinedweapon();

          if(isDefined(var4) && var4 != "none" && var4 != "") {
            var5 = scripts\sp\utility::make_weapon(var4);
          }

          if(var0 == "pistol" && var5.classname == "pistol") {
            var1 = getweaponmodel(var5);
            continue;
          }

          if(var0 != "pistol" && var5.inventorytype == var0 && var1 == var0) {
            var1 = getweaponmodel(var5);
          }
        }
      }

      if(var1 == var0) {
        var1 = "none";
      }

      break;
  }

  return var1;
}

function notetrack_vo(var0) {
  if(isDefined(self.anim_playsound_func)) {
    self thread[[self.anim_playsound_func]](var0, "j_head", 1);
    return;
  }

  if(isDefined(self.anim_playvo_func)) {
    self thread[[self.anim_playvo_func]](var0, "j_head", 1);
    return;
  }

  if(!issentient(self)) {
    thread scripts\engine\utility::playsoundontag(var0, "j_head", 1, var0);
    return;
  }

  scripts\sp\anim::play_sound_at_viewheight(var0, "sounddone", 1);
}

function notetrack_prefix_handler_sp(var0) {
  var1 = getsubstr(var0, 0, 3);

  if(var1 == "ps_") {
    var2 = getsubstr(var0, 3);

    if(isDefined(self.anim_playsound_func)) {
      self thread[[self.anim_playsound_func]](var2, "j_head", 1);
    } else {
      var3 = strtok(var2, ",");

      if(var3.size < 2) {
        thread scripts\engine\utility::playsoundontag(var2, undefined, 1);
      } else {
        thread scripts\engine\utility::playsoundontag(var3[0], var3[1], 1);
      }
    }

    return 1;
  }

  if(var2 == "vo_") {
    if(canplaynotetrackvo()) {
      var2 = getsubstr(var1, 3);
      notetrack_vo(var2);
      return 1;
    }
  }

  if(var2 == "bc_") {
    if(canplaynotetrackvo()) {
      var4 = getsubstr(var2, 3);
      var2 = scripts\anim\battlechatter::bc_prefix("custom");
      var2 += var4;

      if(soundexists(var2)) {
        notetrack_vo(var2);
      }

      return 1;
    }
  }

  if(var2 == "sd_") {
    if(canplaynotetrackvo()) {
      var2 = getsubstr(var4, 3);

      if(isDefined(self.anim_smartdialog_func)) {
        self thread[[self.anim_smartdialog_func]](var2);
      } else {
        thread scripts\engine\sp\utility::smart_dialogue(var2);
      }

      return 1;
    }
  }

  if(var2 == "sr_") {
    if(canplaynotetrackvo()) {
      var2 = getsubstr(var2, 3);
      level thread scripts\engine\sp\utility::smart_radio_dialogue(var2);
      return 1;
    }
  }

  if(var2 == "rm_") {
    var5 = getsubstr(var2, 3);
    level.player playRumbleOnEntity(var5);
    return 1;
  }

  if(var5 == "fx_") {
    var6 = strtok(tolower(var2), "[]");
    var7 = strtok(getsubstr(var6[0], 3), ",() ");
    var8 = [];

    if(var6.size > 1) {
      for(var9 = 1; var9 < var6.size; var9++) {
        var10 = strtok(var6[var9], ",");

        if(var10.size > 1) {
          var7 = scripts\engine\utility::array_add(var7, (float(var10[0]), float(var10[1]), float(var10[2])));
          continue;
        }

        var7 = scripts\engine\utility::array_add(var7, var10[0]);
      }
    }

    if(var7.size == 2) {
      if(var7[0] == "exploder") {
        scripts\engine\utility::exploder(var7[1]);
        return 1;
      } else if(var7[0] == "stop_exploder") {
        scripts\engine\utility::stop_exploder(var7[1]);
        return 1;
      } else {
        playFXOnTag(level._effect[var7[0]], self, var7[1]);
        return 1;
      }
    } else if(var7.size == 3) {
      if(var7[0] == "playfxontag") {
        playFXOnTag(level._effect[var7[1]], self, var7[2]);
        return 1;
      } else if(var7[0] == "stopfxontag") {
        stopFXOnTag(level._effect[var7[1]], self, var7[2]);
        return 1;
      } else if(var7[0] == "killfxontag") {
        killfxontag(level._effect[var7[1]], self, var7[2]);
        return 1;
      }
    } else if(var7.size == 6) {
      if(var7[0] == "debris") {
        playFXOnTag(level._effect[var7[1]], self, var7[2]);
        self hidepart(var7[2], var7[3]);
        return 1;
      }
    } else if(var7.size == 11) {
      var11 = (float(var7[2]), float(var7[3]), float(var7[4]));
      var12 = (float(var7[5]), float(var7[6]), float(var7[7]));
      var13 = (float(var7[8]), float(var7[9]), float(var7[10]));
      playFX(level._effect[var7[1]], var11, var12, var13);
    }
  }

  if(var5 == "ht_") {
    var14 = getsubstr(var2, 3, var2.size);

    if(var14 == "on" || var14 == "on_0") {
      if(!isDefined(self.ht_on)) {
        self.ht_on = 1;
        self setuplookatfornotetrack();
      }

      scripts\common\utility::lookatentity(level.player, 0);
    } else if(var14 == "on_1") {
      if(!isDefined(self.ht_on)) {
        self.ht_on = 1;
        self setuplookatfornotetrack();
      }

      scripts\common\utility::lookatentity(level.player, 1);
    } else {
      scripts\asm\shared\utility::cleanupanimscriptedheadlook();
    }

    return 1;
  }

  if(var14 == "ms_") {
    var15 = getsubstr(var5, 3, var5.size);
    var16 = scripts\asm\shared\utility::getbasearchetype();
    var17 = getnearestspeedthresholdname(var16, var15);
    self aisetdesiredspeed(var17);
    self aisettargetspeed(var17);
    return 1;
  }

  if(var17 == "at_") {
    notetrack_model_attach(getsubstr(var16, 3));
    return 1;
  }

  var17 = getsubstr(var16, 0, 4);

  if(var17 == "psr_") {
    if(canplaynotetrackvo()) {
      var2 = getsubstr(var16, 4);
      scripts\engine\sp\utility::radio_dialogue(var2);
      return 1;
    }
  }

  if(var2 == "pip_") {
    if(canplaynotetrackvo()) {
      var2 = getsubstr(var17, 4);

      if(isDefined(self.anim_playsound_func)) {
        self thread[[self.anim_playsound_func]](var2, "j_head", 1);
      } else {
        thread scripts\sp\pip_util::pip_dialogue(var2);
      }

      return 1;
    }
  }

  if(var2 == "pvo_") {
    if(canplaynotetrackvo()) {
      var2 = getsubstr(var2, 4);
      thread scripts\engine\sp\utility::smart_player_dialogue(var2);
      return 1;
    }
  }

  if(var2 == "fov_") {
    var18 = strtok(var2, "_");
    var19 = var18[1];
    var20 = 65;
    var21 = undefined;

    if(var19 == "start") {
      var20 = float(var18[2]);
      var21 = float(var18[3]);
      level.player modifybasefov(var20, var21);
    } else {
      var21 = float(var18[2]);
      level.player modifybasefov(var20, var21);
    }

    return 1;
  }

  var21 = getsubstr(var20, 0, 4);

  if(var21 == "hts_") {
    var22 = getsubstr(var20, 4);

    if(var22 == "off") {
      scripts\common\utility::lookatstateoverride();
    } else {
      scripts\common\utility::lookatstateoverride(var22);
    }

    return 1;
  }

  return scripts\anim\notetracks::notetrack_prefix_handler_common(var21);
}

function canplaynotetrackvo() {
  if(level.missionfailed && !level.notetrackmissionfailedvo) {
    return false;
  }

  if(!level.notetrackvo) {
    return false;
  }

  return true;
}

function eyeonnotehandler(var0, var1) {
  self setanim(%lookatplayer_node, 1, 0.2, 1);
}

function eyeoffnotehandler(var0, var1) {
  self clearanim(%lookatplayer_node, 0.2);
}