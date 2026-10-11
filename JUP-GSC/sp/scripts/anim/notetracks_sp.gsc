/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\anim\notetracks_sp.gsc
***********************************************/

#using scripts\aitypes\dismember;
#using scripts\anim\battlechatter;
#using scripts\anim\combat_utility;
#using scripts\anim\death;
#using scripts\anim\notetracks;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;
#using scripts\asm\shared\utility;
#using scripts\common\debug;
#using scripts\common\notetrack;
#using scripts\common\utility;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\pip_util;
#using scripts\sp\utility;
#namespace notetracks_sp;

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
  anim.notetracks["anim_facial = talk"] = &function_b07adb5f9d4bb4ee;
  anim.notetracks["anim_facial = talk_lg"] = &function_b090d15f9d63d223;
  anim.notetracks["anim_facial = talk_md"] = &function_b094c05f9d67a297;
  anim.notetracks["anim_facial = talk_sm"] = &function_b07adb5f9d4bb4ee;
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
  anim.notetracks["mvmt_step_pre"] = &notetrackmovement;
  anim.notetracks["mvmt_step_post"] = &notetrackmovement;
  anim.notetracks["bodyfall_limb_small"] = &notetrackbodyfall;
  anim.notetracks["bodyfall_limb_large"] = &notetrackbodyfall;
  anim.notetracks["bodyfall_head"] = &notetrackbodyfall;
  anim.notetracks["bodyfall_torso"] = &notetrackbodyfall;
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
  anim.notetracks["killai"] = &notetrackkillai;
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
  anim.notetracks["enable_weapons"] = &notetrackenableweapons;
  anim.notetracks["disable_weapons"] = &notetrackdisableweapons;
  anim.notetracks["viewlinkmodel"] = &function_127bf3d03ce7da3a;
}

function handlenotetrack(note, flagname, customfunction, customparams) {
  if(scripts\anim\notetracks::hascustomnotetrackhandler(note)) {
    return scripts\anim\notetracks::handlecustomnotetrackhandler(note, flagname, customfunction, customparams);
  }

  retval = scripts\anim\notetracks::handlecommonnotetrack(note, flagname, customfunction, customparams);

  if(isDefined(retval) && retval == "__unhandled") {
    retval = undefined;

    switch (note) {
      case #"hash_96500ba43eb6e086":
        anim_stopanimScripted();
        return note;
      case #"hash_d9f86e4c127286b2":
        if(weapon_pump_action_shotgun()) {
          self playSound("weap_reload_shotgun_pump_npc");
        }

        break;
      case #"hash_88cce8d6571fe7e1":
        if(usingrocketlauncher()) {
          notetrackrocketlauncherammoattach();
        }

        break;
      default:
        if(isDefined(customfunction)) {
          if(isDefined(customparams)) {
            return [[customfunction]](note, customparams);
          } else {
            return [[customfunction]](note);
          }
        }

        break;
    }

    if(string_starts_with(note, "pla_")) {
      if(!isai(self)) {
        assertmsg("'" + note + "' must be called on an AI.");
        return 1;
      }

      data = strtok(tolower(note), ",");
      data[0] = getsubstr(data[0], 4);
      function_4c5f855c0e23d2ec(data);
    }
  }

  return retval;
}

function notetrackvisorraise(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise();
}

function notetrackvisorlower(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise();
}

function notetrackvisorlower_instant(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise("_instant");
}

function notetrackvisorraise_instant(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise("_instant");
}

function notetrackvisorpricelower_instant(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 1;
  scripts\asm\asm_sp::asm_playvisorraise("_price_instant");
}

function notetrackvisorpriceraise_instant(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_playvisorraise("_price_instant");
}

function notetrackvisorraise_clear(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self.visor_down = 0;
  scripts\asm\asm_sp::asm_clearvisoranim();
}

function notetrackfingerposeoffleft(note, flagname) {
  scripts\asm\asm_sp::asm_clearikfingeranim("left");
}

function notetrackfingerposeonleft(note, flagname) {
  scripts\asm\asm_sp::asm_ikfingeranim("left");
}

function notetrackfingerposeoffright(note, flagname) {
  scripts\asm\asm_sp::asm_clearikfingeranim("left");
}

function notetrackfingerposeonright(note, flagname) {
  scripts\asm\asm_sp::asm_ikfingeranim("right");
}

function notetrackfacialidle(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("idle");
}

function notetrackfacialrun(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("run");
}

function notetrackfacialpain(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("pain");
}

function notetrackfacialdeath(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("death");
}

function function_b090d15f9d63d223(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("talk_lg");
}

function function_b094c05f9d67a297(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("talk_md");
}

function function_b07adb5f9d4bb4ee(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("talk_sm");
}

function notetrackfacialcheer(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("cheer");
}

function notetrackfacialhappy(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("happy");
}

function notetrackfacialscared(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("scared");
}

function notetrackfacialangry(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("angry");
}

function notetrackfacialgasdeath(note, flagname) {
  scripts\asm\asm_sp::asm_playfacialanimfromnotetrack("gas_death");
}

function notetrackmovement(note, flagname) {
  if(isDefined(self.classname) && self.classname != "script_model") {
    lead_type = 1;

    if(issubstr(note, "post")) {
      lead_type = 2;
    }

    run_type = get_notetrack_movement();
    self playclothmovesound(run_type, lead_type);
  }
}

function notetrackbodyfall(note, flagname) {
  switch (note) {
    case #"hash_2ef23a13196222ab":
      soundalias = "anim_bodyfall_head";
      break;
    case #"hash_2e9368be03b7a895":
      soundalias = "anim_bodyfall_limb_large";
      break;
    case #"hash_53bc96d0ea50bbf9":
      soundalias = "anim_bodyfall_limb_small";
      break;
    case #"hash_cabf23769ef0902c":
      soundalias = "anim_bodyfall_torso";
      break;
    default:
      soundalias = "anim_bodyfall_limb_large";
      break;
  }

  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "concrete_dry";
  }

  self playsurfacesound(soundalias, groundtype);
}

function notetrackfootscrape(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
    return;
  }

  groundtype = "dirt";
}

function notetrackland(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "dirt";
  }

  self playsurfacesound("step_default_npc_land", groundtype);
  self playclothmovesound("land", 2);
  self playequipmovesound("land", self.weapon);
}

function playfootstep(is_left, is_large, is_vfxonly) {
  if(!isai(self)) {
    if(isDefined(self.fnplayfootstep)) {
      [[self.fnplayfootstep]](is_left, is_large, is_vfxonly);
      return;
    }

    if(!is_vfxonly) {
      function_4f6cdffaa41ad3d1("dirt", "step", "run");
    }

    return;
  }

  groundtype = undefined;
  actiontype = "step";
  stairsstate = self.stairsstate;

  if(stairsstate == "up") {
    actiontype = "stepstairup";
  } else if(stairsstate == "down") {
    actiontype = "stepstairdown";
  }

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      if(!is_vfxonly) {
        function_4f6cdffaa41ad3d1("dirt", actiontype, "run");
      }

      return;
    }

    groundtype = self.lastgroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }

  foot = "J_Ball_RI";

  if(is_left) {
    foot = "J_Ball_LE";
  }

  run_type = get_notetrack_movement();

  if(!is_vfxonly) {
    function_4f6cdffaa41ad3d1(groundtype, actiontype, run_type);
  }

  if(is_large) {
    if(![[anim.fnfootstepeffect]](foot, groundtype)) {
      playfootstepeffectsmall(foot, groundtype);
    }
  } else if(![[anim.fnfootstepeffectsmall]](foot, groundtype)) {
    playfootstepeffect(foot, groundtype);
  }

  if(![[anim.fnfootprinteffect]](foot, groundtype)) {
    playfootprinteffect(foot, groundtype);
  }
}

function playhandstep(is_left, is_large) {
  if(!isai(self)) {
    return;
  }

  if(is_left) {
    tag = "J_MID_LE_1";

    if(scripts\aitypes\dismember::get_scriptablepartinfo("left_arm") == "dismember") {
      return;
    }
  } else {
    tag = "J_MID_RI_1";

    if(scripts\aitypes\dismember::get_scriptablepartinfo("right_arm") == "dismember") {
      return;
    }
  }

  groundtype = undefined;

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      return;
    }

    groundtype = self.lastgroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }

  if(![[anim.optionalstepeffectsmallfunction]](tag, groundtype)) {
    playfootstepeffect(tag, groundtype);
  }

  if(![[anim.optionalfootprinteffectfunction]](tag, groundtype)) {
    playfootprinteffect(tag, groundtype);
  }
}

function notetrackhandstep(note, flagname) {
  is_left = issubstr(note, "left");
  is_large = issubstr(note, "large");
  foot = "right";

  if(is_left) {
    foot = "left";
  }

  if(isai(self)) {
    self.asm.footsteps.foot = foot;
    self.asm.footsteps.time = gettime();
  }

  playhandstep(is_left, is_large);
}

function playfootprinteffect(foot, groundtype) {
  if(!isDefined(anim.optionalfootprinteffects[groundtype])) {
    return false;
  }

  footorg = self gettagorigin(foot);
  footangles = self gettagangles(foot);
  footup = anglestoright(footangles) * -1;
  footforward = anglesToForward(footangles);
  tracestart = footorg + footup * -5;
  traceend = footorg + footup * 20;
  trace = scripts\engine\trace::_bullet_trace(tracestart, traceend, 0, self, 0, 0, 0, 0);

  if(trace["fraction"] == 1) {
    return true;
  }

  if(!isDefined(level._effect["footprint_" + groundtype][self.unittype])) {
    println("<dev string:x1c>" + self.unittype + "<dev string:x2f>" + "<dev string:x4a>" + groundtype);
    level._effect["footprint_" + groundtype][self.unittype] = level._effect["footprint_" + groundtype]["soldier"];
  }

  if(!anim.flirfootprinteffects) {
    playFX(level._effect["footprint_" + groundtype][self.unittype], trace["position"], trace["normal"], footforward);
  } else {
    thread track_flir_footstep(level._effect["footprint_" + groundtype][self.unittype], trace["position"], trace["normal"], footforward);
  }

  return true;
}

function track_flir_footstep(effectid, org, forwardv, upv) {
  footstep = spawnStruct();
  footstep.effectid = effectid;
  footstep.org = org;
  footstep.forwardv = forwardv;
  footstep.upv = upv;
  footstep.spawntime = gettime();
  footstep.active = 0;
  anim.flirfootprints = array_add(anim.flirfootprints, footstep);

  if(level.player isnightvisionon() && level.player is_flir_vision_on()) {
    footstep thread play_flir_footstep_fx();
  }

  wait 10;
  anim.flirfootprints = array_remove(anim.flirfootprints, footstep);
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

function playfootstepeffect(foot, groundtype) {
  if(!isDefined(anim.optionalstepeffects[groundtype])) {
    return false;
  }

  org = self gettagorigin(foot);
  angles = self.angles;
  forward = anglesToForward(angles);
  up = anglestoup(angles);

  if(!isDefined(level._effect["step_" + groundtype][self.unittype])) {
    println("<dev string:x55>" + self.unittype + "<dev string:x66>" + "<dev string:x85>" + groundtype);
    level._effect["step_" + groundtype][self.unittype] = level._effect["step_" + groundtype]["soldier"];
  }

  playFX(level._effect["step_" + groundtype][self.unittype], org, forward, up);
  return true;
}

function playfootstepeffectsmall(foot, groundtype) {
  if(!isDefined(anim.optionalstepeffectssmall[groundtype])) {
    return false;
  }

  org = self gettagorigin(foot);
  angles = self.angles;
  forward = anglesToForward(angles);
  up = anglestoup(angles);

  if(!isDefined(level._effect["step_small_" + groundtype][self.unittype])) {
    println("<dev string:x8b>" + self.unittype + "<dev string:x2f>" + "<dev string:xa2>" + groundtype);
    level._effect["step_small_" + groundtype][self.unittype] = level._effect["step_small_" + groundtype]["soldier"];
  }

  playFX(level._effect["step_small_" + groundtype][self.unittype], org, forward, up);
  return true;
}

function get_notetrack_movement() {
  if(isai(self) && !isbot(self)) {
    return self function_cbe5ad2464f5abe();
  }

  run_type = "run";
  animsetname = undefined;

  if(isDefined(self.asm)) {
    animsetname = self getbasearchetype();
  }

  if(isDefined(animsetname) && animspeedthresholdsexist(animsetname) && hasanimspeedthresholdstring(animsetname, "sprint") && isDefined(self.velocity)) {
    sprintspeed = getanimspeedbetweenthresholds(animsetname, "run", "sprint", 0.8);

    if(length2d(self.velocity) > sprintspeed) {
      run_type = "sprint";
    }
  }

  if(isDefined(self._blackboard)) {
    if(self._blackboard.movetype == "walk" || self._blackboard.movetype == "casual_gun" || self._blackboard.movetype == "patrol" || self._blackboard.movetype == "casual") {
      run_type = "walk";
    }

    if(scripts\asm\asm_bb::bb_getrequestedstance() == "prone") {
      run_type = "prone";
    }
  } else if(isDefined(self.a)) {
    if(isDefined(self.a.movement)) {
      if(self.a.movement == "walk") {
        run_type = "walk";
      }
    }

    if(isDefined(self.currentpose)) {
      if(self.currentpose == "prone") {
        run_type = "prone";
      }
    }
  }

  return run_type;
}

function notetracklaser(note, flagname) {
  if(note == "laser_on") {
    self.laserenabled = 1;
  } else {
    self.laserenabled = 0;
  }

  self updatelaserstatus();
}

function notetrackgunhand(note, flagname) {
  if(issubstr(note, "left")) {
    scripts\anim\shared::placeweaponon(self.weapon, "left");
    self notify("weapon_switch_done");
    return;
  }

  if(issubstr(note, "right")) {
    scripts\anim\shared::placeweaponon(self.weapon, "right");
    self notify("weapon_switch_done");
    return;
  }

  if(issubstr(note, "none")) {
    scripts\anim\shared::placeweaponon(self.weapon, "none");
  }
}

function notetrackposestand(note, flagname) {
  if(!isai(self)) {
    return;
  }

  if(self.currentpose == "prone") {
    exitpronewrapper(1);
  }

  setpose("stand");
}

function notetrackposecrouch(note, flagname) {
  if(!isai(self)) {
    return;
  }

  if(self.currentpose == "prone") {
    exitpronewrapper(1);
  }

  setpose("crouch");
}

#using_animtree("generic_human");

function notetrackposeprone(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self setproneanimnodes(-45, 45, %prone_legs_down, %prone_dummy, %prone_legs_up);
  enterpronewrapper(0.5);
  setpose("prone");

  if(isDefined(self.a.goingtoproneaim)) {
    self.a.proneaiming = 1;
    return;
  }

  self.a.proneaiming = undefined;
}

function notetrackposecrawl(note, flagname) {
  if(!isai(self)) {
    return;
  }

  self setproneanimnodes(-45, 45, %prone_legs_down, %prone_dummy, %prone_legs_up);
  enterpronewrapper(1);
  setpose("prone");
  self.a.proneaiming = undefined;
}

function notetrackposeback(note, flagname) {
  if(!isai(self)) {
    return;
  }

  if(!issentient(self)) {
    return;
  }

  setpose("crouch");
  self.a.onback = 1;
  self.a.movement = "stop";
  self setproneanimnodes(-90, 90, %prone_legs_down, %prone_dummy, %prone_legs_up);
  enterpronewrapper(1);
}

function notetrackrocketlauncherammoattach() {
  assert(isDefined(self));

  if(!isalive(self)) {
    return;
  }

  if(!usingrocketlauncher()) {
    return;
  }

  if(self tagexists("tag_accessory_left") && self tagexists("tag_rocket")) {
    self showpart("tag_rocket");
  }
}

function notetrackdropclip(note, flagname) {
  thread handledropclip(flagname);
}

function notetrackhelmetpop(note, flagname) {
  if(isDefined(self.fnhelmetpop)) {
    self[[self.fnhelmetpop]]();
    self.dontbreakhelmet = 1;
  }
}

function notetrackstartragdoll(note, flagname) {
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
      dropaiweapon();
      self.lastweapon = self.weapon;
    }
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  if(isDefined(self)) {
    self startragdoll();
  }

  if(isalive(self)) {
    println("<dev string:xae>");
  }
}

function notetrackragdollblendinit(note, flagname) {
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
      dropaiweapon();
      self.lastweapon = self.weapon;
    }
  }

  if(isDefined(self.fnpreragdoll)) {
    self[[self.fnpreragdoll]]();
  }

  self ragdollblendinit();
}

function notetrackragdollblendstart(note, flagname) {}

function notetrackragdollblendend(note, flagname) {}

function notetrackragdollblendrootanim(note, flagname) {}

function notetrackragdollblendrootragdoll(note, flagname) {}

function notetrackkillai(note, flagname) {
  if(!isai(self)) {
    return;
  }

  if(isalive(self)) {
    self startragdoll();
    wait 1;
    self kill();
  }
}

function notetrackgundrop(note, flagname) {
  if(!isai(self)) {
    println("<dev string:xd2>" + function_a2eaafb222316a2(self) + "<dev string:xe4>" + note + "<dev string:xf7>");
    return;
  }

  dropaiweapon();

  if(isDefined(self._blackboard)) {
    self._blackboard.awaitingdropgunnotetrack = 0;
  }

  self.lastweapon = self.weapon;
}

function setpose(pose) {
  self.currentpose = pose;

  if(isDefined(self.a.onback)) {
    stoponback();
  }

  scripts\asm\asm_bb::bb_requeststance(pose);
  self notify("entered_pose" + pose);
}

function unlinknextframe() {
  wait 0.1;

  if(isDefined(self)) {
    self unlink();
  }
}

function notetrack_model_translate(model) {
  result = model;

  switch (model) {
    case #"hash_325cb2e66f67d5b9":
    case #"hash_719417cb1de832b6":
    case #"hash_f731f17ca0fe624f":
      if(isDefined(self.weaponinfo)) {
        foreach(info in self.weaponinfo) {
          weaponname = strtok(key, "+")[0];
          weap = nullweapon();

          if(isDefined(weaponname) && weaponname != "none" && weaponname != "") {
            weap = make_weapon(weaponname);
          }

          if(model == "pistol" && weap.classname == "pistol") {
            result = getweaponmodel(weap);
            continue;
          }

          if(model != "pistol" && weap.inventorytype == model && result == model) {
            result = getweaponmodel(weap);
          }
        }
      }

      if(result == model) {
        result = "none";
      }

      break;
  }

  return result;
}

function notetrack_vo(alias) {
  if(isDefined(self.anim_playsound_func)) {
    self thread[[self.anim_playsound_func]](alias, "j_head", 1);
    return;
  }

  if(isDefined(self.anim_playvo_func)) {
    self thread[[self.anim_playvo_func]](alias, "j_head", 1);
    return;
  }

  if(!issentient(self)) {
    thread playsoundontag(alias, "j_head", 1, alias);
    return;
  }

  scripts\sp\anim::play_sound_at_viewheight(alias, "sounddone", 1);
}

function notetrack_prefix_handler_sp(notetrack) {
  prefix3 = getsubstr(notetrack, 0, 3);

  switch (prefix3) {
    case #"hash_8966586c51e34031":
      alias = getsubstr(notetrack, 3);

      if(isDefined(self.anim_playsound_func)) {
        self thread[[self.anim_playsound_func]](alias, "j_head", 1);
      } else {
        params = strtok(alias, ",");

        if(params.size < 2) {
          thread playsoundontag(alias, undefined, 1);
        } else {
          thread playsoundontag(params[0], params[1], 1);
        }
      }

      return 1;
    case #"hash_7b1f866c4a8d9d17":
      if(canplaynotetrackvo()) {
        alias = getsubstr(notetrack, 3);
        notetrack_vo(alias);
        return 1;
      }

      break;
    case #"hash_212b5a6c1b27bb77":
      if(canplaynotetrackvo()) {
        custom_bc = getsubstr(notetrack, 3);
        prefix = scripts\anim\battlechatter::executeevent(custom_bc);
        return 1;
      }

      break;
    case #"hash_8fefc16c551511d7":
      if(canplaynotetrackvo()) {
        alias = getsubstr(notetrack, 3);

        if(isDefined(self.anim_smartdialog_func)) {
          self thread[[self.anim_smartdialog_func]](alias);
        } else {
          thread smart_dialogue(alias);
        }

        return 1;
      }

      break;
    case #"hash_900fc16c552ea9bd":
      if(canplaynotetrackvo()) {
        alias = getsubstr(notetrack, 3);
        level thread smart_radio_dialogue(alias);
        return 1;
      }

      break;
    case #"hash_256b66c0ab12624":
      vector_str = strtok(tolower(notetrack), "[]");
      str = strtok(getsubstr(vector_str[0], 3), ",() ");
      vectors = [];

      if(vector_str.size > 1) {
        for(i = 1; i < vector_str.size; i++) {
          vector = strtok(vector_str[i], ",");

          if(vector.size > 1) {
            assertex(vector.size == 3, "anim.gsc: vector size not equal to 3 (" + vector.size);
            str = array_add(str, (float(vector[0]), float(vector[1]), float(vector[2])));
            continue;
          }

          str = array_add(str, vector[0]);
        }
      }

      if(str.size == 2) {
        if(str[0] == "exploder") {
          exploder(str[1]);
          return 1;
        } else if(str[0] == "stop_exploder") {
          stop_exploder(str[1]);
          return 1;
        } else {
          playFXOnTag(level._effect[str[0]], self, str[1]);
          return 1;
        }
      } else if(str.size == 3) {
        if(str[0] == "playfxontag") {
          playFXOnTag(level._effect[str[1]], self, str[2]);
          return 1;
        } else if(str[0] == "stopfxontag") {
          stopFXOnTag(level._effect[str[1]], self, str[2]);
          return 1;
        } else if(str[0] == "killfxontag") {
          killfxontag(level._effect[str[1]], self, str[2]);
          return 1;
        }
      } else if(str.size == 6) {
        if(str[0] == "debris") {
          playFXOnTag(level._effect[str[1]], self, str[2]);
          self hidepart(str[2], str[3]);
          return 1;
        }
      } else if(str.size == 11) {
        p = (float(str[2]), float(str[3]), float(str[4]));
        f = (float(str[5]), float(str[6]), float(str[7]));
        u = (float(str[8]), float(str[9]), float(str[10]));
        playFX(level._effect[str[1]], p, f, u);
      }

      break;
    case #"hash_4e4e106c32fa68d2":
      if(!isai(self)) {
        return 1;
      }

      suffix = getsubstr(notetrack, 3, notetrack.size);

      if(suffix == "on" || suffix == "on_0") {
        if(!isDefined(self.ht_on)) {
          self.ht_on = 1;
          self setuplookatfornotetrack();
        }

        utility::lookatentity(level.player, 0);
      } else if(suffix == "on_1") {
        if(!isDefined(self.ht_on)) {
          self.ht_on = 1;
          self setuplookatfornotetrack();
        }

        utility::lookatentity(level.player, 1);
      } else {
        cleanupanimscriptedheadlook();
      }

      return 1;
    case #"hash_286f036c1eec89aa":
      var_5bf1e96d631b62fe = getsubstr(notetrack, 3, notetrack.size);
      archetype = self getbasearchetype();
      assert(isDefined(archetype));
      desiredspeed = getanimspeedthreshold(archetype, var_5bf1e96d631b62fe);
      self aisetdesiredspeed(desiredspeed);
      self aisettargetspeed(desiredspeed);
      return 1;
    case #"hash_4e5ad06c3304916e":
      parms = getsubstr(notetrack, 3);

      switch (parms) {
        case #"hash_fa2ad6f6bd651030":
          if(isai(self)) {
            self setlookatstate("request");
            self function_5621e511b99964a7(level.player);
          }

          return 1;
        case #"hash_23a4247209319a1":
          if(isai(self)) {
            self setlookatstate("request");
            self function_504a5e2df31069a4();
          }

          return 1;
        case #"hash_3699ac6c262c25ea":
          if(isai(self)) {
            self setlookatstate("prohibit");
          }

          return 1;
      }

      break;
    case #"hash_901bbd6c55379dcd":
      parmlist = strtok(notetrack, "_, ");
      right = ter_op(isDefined(parmlist[1]), float(parmlist[1]), 0);
      left = ter_op(isDefined(parmlist[2]), float(parmlist[2]), 0);
      top = ter_op(isDefined(parmlist[3]), float(parmlist[3]), 0);
      bottom = ter_op(isDefined(parmlist[4]), float(parmlist[4]), 0);
      blend = ter_op(isDefined(parmlist[5]), float(parmlist[5]), 0);
      level.player lerpviewangleclamp(blend, blend * 0.5, blend * 0.5, right, left, top, bottom, 1);
      return 1;
    case #"hash_7b3b466c4aa2fea6":
      if(level.player islinked()) {
        viewfraction = getsubstr(notetrack, 3, notetrack.size);
        viewfraction = float(viewfraction);

        if(isDefined(level.player getlinkedparent())) {
          level.player playerlinkedviewfraction(viewfraction);
        }
      }

      return 1;
    case #"hash_8927586c51b1a365":
      gesture = getsubstr(notetrack, 3, notetrack.size);
      level.player forceplaygestureviewmodel(gesture);
      return 1;
    case #"hash_ed53bb6c000173b4":
      parmlist = strtok(notetrack, "_, ");
      scale = ter_op(isDefined(parmlist[1]), float(parmlist[1]), 1);
      duration = ter_op(isDefined(parmlist[2]), float(parmlist[2]), 1);
      level.player earthquakeforplayer(scale, duration, level.player.origin, 1000);
      return 1;
    case #"hash_f493246c03c20b90":
      if(isDefined(level.dyndof)) {
        utility::dyndofexp_stop();
      }

      fstop = undefined;
      focusspeed = undefined;
      aperturespeed = undefined;
      angles = undefined;
      focalbone = undefined;
      ignoreplayer = undefined;
      ignorecollision = undefined;
      parms = getsubstr(notetrack, 3, notetrack.size);
      parmlist = strtok(parms, ", ");

      switch (parmlist.size) {
        case 8:
          ignorecollision = function_66eb0c2166aeef3d(parmlist[7]);
        case 7:
          ignoreplayer = function_66eb0c2166aeef3d(parmlist[6]);
        case 6:
          focalbone = parmlist[5];

          if(focalbone == "-1") {
            focalbone = undefined;
          }
        case 5:
          angles = float(parmlist[4]);

          if(angles < 0) {
            angles = undefined;
          }
        case 4:
          aperturespeed = float(parmlist[3]);

          if(aperturespeed < 0) {
            aperturespeed = undefined;
          }
        case 3:
          focusspeed = float(parmlist[2]);

          if(focusspeed < 0) {
            focusspeed = undefined;
          }
        case 2:
          fstop = float(parmlist[1]);

          if(fstop < 0) {
            fstop = undefined;
          }
        case 1:
          break;
      }

      ignorelist = [];

      if(istrue(ignoreplayer)) {
        ignorelist = [level.player];

        if(isDefined(level.player_rig)) {
          ignorelist[ignorelist.size] = level.player_rig;
        }
      }

      level.player thread utility::dof_enable_autofocus(fstop, self, focusspeed, aperturespeed, angles, focalbone, ignorelist, ignorecollision);
      return 1;
    case #"hash_8937186c51be0a98":
      parmlist = strtok(notetrack, "_, ");
      enabled = ter_op(isDefined(parmlist[1]), int(parmlist[1]), 1);

      if(enabled) {
        enable_procedural_bones();
      } else {
        disable_procedural_bones();
      }

      return 1;
    case #"hash_6d3c746c4385b41d":
      parmlist = strtok(notetrack, "_, ");
      from = ter_op(isDefined(parmlist[1]), float(parmlist[1]), 1);
      to = ter_op(isDefined(parmlist[2]), float(parmlist[2]), 1);
      duration = ter_op(isDefined(parmlist[3]), float(parmlist[3]), 1);
      setslowmotion(from, to, duration);
      return 1;
  }

  prefix4 = getsubstr(notetrack, 0, 4);

  switch (prefix4) {
    case #"hash_2ee8a084e861ef57":
      if(canplaynotetrackvo()) {
        alias = getsubstr(notetrack, 4);
        radio_dialogue(alias);
        return 1;
      }

      break;
    case #"hash_8c1d5a8493291b9b":
      if(canplaynotetrackvo()) {
        alias = getsubstr(notetrack, 4);

        if(isDefined(self.anim_playsound_func)) {
          self thread[[self.anim_playsound_func]](alias, "j_head", 1);
        } else {
          thread scripts\sp\pip_util::pip_dialogue(alias);
        }

        return 1;
      }

      break;
    case #"hash_1a446584ddfd0cd9":
      if(canplaynotetrackvo()) {
        alias = getsubstr(notetrack, 4);

        if(isDefined(level.var_bb89bf6ff5d2b0e6)) {
          self thread[[level.var_bb89bf6ff5d2b0e6]](alias);
        } else {
          thread smart_player_dialogue(alias);
        }

        return 1;
      }

      break;
    case #"hash_3ef4a7543fedd633":
      state = getsubstr(notetrack, 4);

      if(state == "off") {
        utility::lookatstateoverride();
      } else {
        utility::lookatstateoverride(state);
      }

      return 1;
    case #"hash_77915f8488d69295":
      if(!isai(self)) {
        assertmsg("'" + notetrack + "' must be called on an AI.");
        return 1;
      }

      data = strtok(tolower(notetrack), ",");
      data[0] = getsubstr(data[0], 4);
      function_4c5f855c0e23d2ec(data);
      return 1;
    case #"hash_a22f1814f7af01f5":
      var_985c64fc7f3f4b6 = strtok(notetrack, "_");
      var_80698c7167df0cb7 = float(var_985c64fc7f3f4b6[1]);
      var_19fd165b9d684b3d = float(var_985c64fc7f3f4b6[2]);
      level.player lerpfovscalefactor(var_80698c7167df0cb7, var_19fd165b9d684b3d);
      return 1;
    case #"hash_f94a040a056fe52b":
      dof_values = strtok(notetrack, "_");
      dof_values_count = dof_values.size;
      dof_fstop = float(dof_values[1]);
      dof_focusdistance = float(dof_values[2]);
      var_8592a3d4811dc109 = undefined;
      dof_aperturespeed = undefined;

      if(dof_values_count > 3) {
        var_8592a3d4811dc109 = float(dof_values[3]);
      }

      if(dof_values_count > 4) {
        dof_aperturespeed = float(dof_values[4]);
      }

      level.player thread utility::dof_enable(dof_fstop, dof_focusdistance, undefined, var_8592a3d4811dc109, dof_aperturespeed);
      return 1;
  }

  return scripts\anim\notetracks::notetrack_prefix_handler_common(notetrack);
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

function eyeonnotehandler(note, flagname) {
  self setanim(%lookat_eye_node, 1, 0.2, 1);
}

function eyeoffnotehandler(note, flagname) {
  self clearanim(%lookat_eye_node, 0.2);
}

function notetrackenableweapons(note, flagname) {
  if(isai(self)) {
    return;
  }

  level.player enableoffhandweapons();
  level.player enableweapons();
}

function notetrackdisableweapons(note, flagname) {
  if(isai(self)) {
    return;
  }

  level.player disableoffhandweapons();
  level.player disableweapons();
}

function function_4c5f855c0e23d2ec(parameters) {
  mode = parameters[0];

  switch (mode) {
    case #"hash_628ffe6f4a417560":
      function_22238dd24555b428(parameters);
      break;
    case #"hash_f6706428c38f0019":
      function_3d33d0c14b96b661(parameters);
      break;
    case #"hash_94ad480ead264ed8":
      function_d61145721b9f2990(parameters);
      break;
    case #"hash_87d1443ef2805760":
      function_8d6dc47bf25b58(parameters);
      break;
    case #"hash_cdd656b8cc7b709c":
      function_bf398d3bbc1f1d84(parameters);
      break;
    case #"hash_148c417c2690352d":
      function_fa7a1453b16a7545(parameters);
      break;
    case #"hash_6aeeafe63b5fd92f":
      function_aeadf8545de91b27(parameters);
      break;
    case #"hash_fa2ad6f6bd651030":
      self function_f51ff412609193b9(1, "anim");
      break;
    case #"hash_3699ac6c262c25ea":
      self function_f51ff412609193b9(0, "anim");
      break;
    case #"hash_76d9f4ac5d921342":
      self function_e99626add202fe1a(1, "anim");
      break;
    case #"hash_f54ad023c463669f":
      self function_e99626add202fe1a(0, "anim");
      break;
    default:
      assertmsg("Unknown procedural look-at notetrack 'pla_" + mode + "'");
      break;
  }
}

function function_22238dd24555b428(parameters) {
  if(parameters.size != 2) {
    assertmsg("Notetrack pla_speed requires exactly 1 parameter - speed [0-4].");
    return;
  }

  if(self function_e9e893b7f1032d7f() == 0) {
    return;
  }

  speed = int(parameters[1]);
  self function_106bce0aeee91d2c(speed);
}

function function_3d33d0c14b96b661(parameters) {
  if(parameters.size != 4) {
    assertmsg("Notetrack pla_bone_weights requires exactly 3 parameters - spine, neck, head.");
    return;
  }

  if(self function_e9e893b7f1032d7f() == 0) {
    return;
  }

  spine = float(parameters[1]);
  neck = float(parameters[2]);
  head = float(parameters[3]);
  self function_1c46ba98e23c02c1(spine, neck, head);
}

function function_d61145721b9f2990(parameters) {
  if(parameters.size != 4) {
    assertmsg("Notetrack pla_bone_speeds requires exactly 3 parameters - spine, neck, head.");
    return;
  }

  if(self function_e9e893b7f1032d7f() == 0) {
    return;
  }

  spine = float(parameters[1]);
  neck = float(parameters[2]);
  head = float(parameters[3]);
}

function function_8d6dc47bf25b58(parameters) {
  if(parameters.size != 2) {
    assertmsg("Notetrack pla_player requires exactly 1 parameter, on/off.");
    return;
  }

  if(self function_e9e893b7f1032d7f() == 0) {
    return;
  }

  switch (tolower(parameters[1])) {
    case #"hash_31100fbc01bd387c":
    case #"hash_fa2ad6f6bd651030":
      self function_5621e511b99964a7(level.player);
      break;
    case #"hash_311010bc01bd3a0f":
    case #"hash_3699ac6c262c25ea":
      self function_504a5e2df31069a4();
      break;
    default:
      assertmsg("Incorrect parameter for pla_player: '" + parameters[1] + "'. Should be on/off.");
      break;
  }
}

function function_bf398d3bbc1f1d84(parameters) {
  if(parameters.size != 3) {
    assertmsg("Notetrack pla_clamp requires exactly 2 parameters - horizontal, vertical.");
    return;
  }

  if(self function_e9e893b7f1032d7f() == 0) {
    return;
  }

  horizontal = float(parameters[1]);
  vertical = float(parameters[2]);
  self function_5b21b24798da64b5(horizontal, vertical);
}

function function_fa7a1453b16a7545(parameters) {
  if(parameters.size != 5) {
    assertmsg("Notetrack pla_clamp_lopsided requires exactly 4 parameters - left, right, up, down.");
    return;
  }

  if(self function_e9e893b7f1032d7f() == 0) {
    return;
  }

  left = float(parameters[1]);
  right = float(parameters[2]);
  up = float(parameters[3]);
  down = float(parameters[4]);
}

function function_aeadf8545de91b27(parameters) {
  if(parameters.size != 2) {
    assertmsg("Notetrack pla_head_offset requires exactly 1 parameter - amount.");
    return;
  }

  if(self function_e9e893b7f1032d7f() == 0) {
    return;
  }

  self function_81e6e6fa91aff70b(float(parameters[1]));
}

function function_127bf3d03ce7da3a(note, flagname, customparams) {
  if(customparams.size == 3) {
    params = strtok(customparams[2], ",");

    if(params.size >= 3) {
      modelname = params[0];
      tagname = params[1];
      entitytargetname = params[2];
      positionoffset = [0, 0, 0];
      angleoffset = [0, 0, 0];
      var_65dbaba260bc5c52 = 3;
      var_ead6bb7b07e2fb30 = 6;

      for(paramindex = var_65dbaba260bc5c52; paramindex < params.size && paramindex < var_ead6bb7b07e2fb30; paramindex++) {
        positionoffset[paramindex - var_65dbaba260bc5c52] = float(params[paramindex]);
      }

      for(paramindex = var_ead6bb7b07e2fb30; paramindex < params.size; paramindex++) {
        angleoffset[paramindex - var_ead6bb7b07e2fb30] = float(params[paramindex]);
      }

      spawnedentity = spawn("script_model", level.player.origin);
      spawnedentity setModel(modelname);
      spawnedentity linktoplayerviewignoreparentrot(level.player, tagname, (positionoffset[0], positionoffset[1], positionoffset[2]), (angleoffset[0], angleoffset[1], angleoffset[2]), 0, 0, 0, 0);
      spawnedentity.targetname = entitytargetname;
    }
  }
}

function function_66eb0c2166aeef3d(str) {
  if(tolower(str) == "true") {
    return true;
  }

  return int(str) && true;
}