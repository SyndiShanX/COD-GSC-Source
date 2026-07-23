/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\notetracks.gsc
**************************************/

handledogsoundnotetracks(var_0) {
  if(var_0 == "sound_dogstep_run_default") {
    self playSound("dogstep_run_default");
    return 1;
  }

  var_1 = getsubstr(var_0, 0, 5);

  if(var_1 != "sound") {
    return 0;
  }
  var_2 = "anml" + getsubstr(var_0, 5);

  if(isalive(self)) {
    thread maps\_utility::play_sound_on_tag_endon_death(var_2, "tag_eye");
  } else {
    thread common_scripts\utility::play_sound_in_space(var_2, self getEye());
  }
  return 1;
}

growling() {
  return isDefined(self.script_growl);
}

registernotetracks() {
  anim.notetracks["anim_pose = \"stand\""] = ::notetrackposestand;
  anim.notetracks["anim_pose = \"crouch\""] = ::notetrackposecrouch;
  anim.notetracks["anim_pose = \"prone\""] = ::notetrackposeprone;
  anim.notetracks["anim_pose = \"crawl\""] = ::notetrackposecrawl;
  anim.notetracks["anim_pose = \"back\""] = ::notetrackposeback;
  anim.notetracks["anim_movement = \"stop\""] = ::notetrackmovementstop;
  anim.notetracks["anim_movement = \"walk\""] = ::notetrackmovementwalk;
  anim.notetracks["anim_movement = \"run\""] = ::notetrackmovementrun;
  anim.notetracks["anim_aiming = 1"] = ::notetrackalertnessaiming;
  anim.notetracks["anim_aiming = 0"] = ::notetrackalertnessalert;
  anim.notetracks["anim_alertness = causal"] = ::notetrackalertnesscasual;
  anim.notetracks["anim_alertness = alert"] = ::notetrackalertnessalert;
  anim.notetracks["anim_alertness = aiming"] = ::notetrackalertnessaiming;
  anim.notetracks["gunhand = (gunhand)_left"] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = \"left\""] = ::notetrackgunhand;
  anim.notetracks["gunhand = (gunhand)_right"] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = \"right\""] = ::notetrackgunhand;
  anim.notetracks["anim_gunhand = \"none\""] = ::notetrackgunhand;
  anim.notetracks["gun drop"] = ::notetrackgundrop;
  anim.notetracks["dropgun"] = ::notetrackgundrop;
  anim.notetracks["gun_2_chest"] = ::notetrackguntochest;
  anim.notetracks["gun_2_back"] = ::notetrackguntoback;
  anim.notetracks["pistol_pickup"] = ::notetrackpistolpickup;
  anim.notetracks["pistol_putaway"] = ::notetrackpistolputaway;
  anim.notetracks["drop clip"] = ::notetrackdropclip;
  anim.notetracks["refill clip"] = ::notetrackrefillclip;
  anim.notetracks["reload done"] = ::notetrackrefillclip;
  anim.notetracks["load_shell"] = ::notetrackloadshell;
  anim.notetracks["pistol_rechamber"] = ::notetrackpistolrechamber;
  anim.notetracks["gravity on"] = ::notetrackgravity;
  anim.notetracks["gravity off"] = ::notetrackgravity;
  anim.notetracks["footstep_right_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_right_small"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_large"] = ::notetrackfootstep;
  anim.notetracks["footstep_left_small"] = ::notetrackfootstep;
  anim.notetracks["footscrape"] = ::notetrackfootscrape;
  anim.notetracks["land"] = ::notetrackland;
  anim.notetracks["bodyfall large"] = ::notetrackbodyfall;
  anim.notetracks["bodyfall small"] = ::notetrackbodyfall;
  anim.notetracks["code_move"] = ::notetrackcodemove;
  anim.notetracks["face_enemy"] = ::notetrackfaceenemy;
  anim.notetracks["laser_on"] = ::notetracklaser;
  anim.notetracks["laser_off"] = ::notetracklaser;
  anim.notetracks["start_ragdoll"] = ::notetrackstartragdoll;
  anim.notetracks["fire"] = ::notetrackfire;
  anim.notetracks["fire_spray"] = ::notetrackfirespray;
  anim.notetracks["bloodpool"] = animscripts\death::play_blood_pool;

  if(isDefined(level._notetrackfx)) {
    var_0 = getarraykeys(level._notetrackfx);

    foreach(var_2 in var_0) {}
    anim.notetracks[var_2] = ::customnotetrackfx;
  }
}

notetrackfire(var_0, var_1) {
  if(isDefined(anim.fire_notetrack_functions[self.script])) {
    thread[[anim.fire_notetrack_functions[self.script]]]();
  } else {
    thread[[::shootnotetrack]]();
  }
}

notetracklaser(var_0, var_1) {
  if(issubstr(var_0, "on")) {
    self.a.laseron = 1;
  } else {
    self.a.laseron = 0;
  }
  animscripts\shared::updatelaserstatus();
}

notetrackstopanim(var_0, var_1) {}

unlinknextframe() {
  wait 0.1;

  if(isDefined(self)) {
    self unlink();
  }
}

notetrackstartragdoll(var_0, var_1) {
  if(isDefined(self.noragdoll)) {
    return;
  }
  if(isDefined(self.ragdolltime)) {
    return;
  }
  if(!isDefined(self.dont_unlink_ragdoll)) {
    thread unlinknextframe();
  }
  self startragdoll();
}

notetrackmovementstop(var_0, var_1) {
  self.a.movement = "stop";
}

notetrackmovementwalk(var_0, var_1) {
  self.a.movement = "walk";
}

notetrackmovementrun(var_0, var_1) {
  self.a.movement = "run";
}

notetrackalertnessaiming(var_0, var_1) {}

notetrackalertnesscasual(var_0, var_1) {}

notetrackalertnessalert(var_0, var_1) {}

stoponback() {
  animscripts\utility::exitpronewrapper(1.0);
  self.a.onback = undefined;
}

setpose(var_0) {
  self.a.pose = var_0;

  if(isDefined(self.a.onback)) {
    stoponback();
  }
  self notify("entered_pose" + var_0);
}

notetrackposestand(var_0, var_1) {
  if(self.a.pose == "prone") {
    self orientmode("face default");
    animscripts\utility::exitpronewrapper(1.0);
  }

  setpose("stand");
}

notetrackposecrouch(var_0, var_1) {
  if(self.a.pose == "prone") {
    self orientmode("face default");
    animscripts\utility::exitpronewrapper(1.0);
  }

  setpose("crouch");
}

#using_animtree("generic_human");

notetrackposeprone(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  animscripts\utility::enterpronewrapper(1.0);
  setpose("prone");

  if(isDefined(self.a.goingtoproneaim)) {
    self.a.proneaiming = 1;
  } else {
    self.a.proneaiming = undefined;
  }
}

notetrackposecrawl(var_0, var_1) {
  if(!issentient(self)) {
    return;
  }
  self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  animscripts\utility::enterpronewrapper(1.0);
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
  self setproneanimnodes(-90, 90, %prone_legs_down, %exposed_aiming, %prone_legs_up);
  animscripts\utility::enterpronewrapper(1.0);
}

notetrackgunhand(var_0, var_1) {
  if(issubstr(var_0, "left")) {
    animscripts\shared::placeweaponon(self.weapon, "left");
    self notify("weapon_switch_done");
  } else if(issubstr(var_0, "right")) {
    animscripts\shared::placeweaponon(self.weapon, "right");
    self notify("weapon_switch_done");
  } else if(issubstr(var_0, "none")) {
    animscripts\shared::placeweaponon(self.weapon, "none");
  }
}

notetrackgundrop(var_0, var_1) {
  animscripts\shared::dropaiweapon();
  self.lastweapon = self.weapon;
}

notetrackguntochest(var_0, var_1) {
  animscripts\shared::placeweaponon(self.weapon, "chest");
}

notetrackguntoback(var_0, var_1) {
  animscripts\shared::placeweaponon(self.weapon, "back");
  self.weapon = animscripts\utility::getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

notetrackpistolpickup(var_0, var_1) {
  animscripts\shared::placeweaponon(self.sidearm, "right");
  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

notetrackpistolputaway(var_0, var_1) {
  animscripts\shared::placeweaponon(self.weapon, "none");
  self.weapon = animscripts\utility::getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

notetrackdropclip(var_0, var_1) {
  thread animscripts\shared::handledropclip(var_1);
}

notetrackrefillclip(var_0, var_1) {
  if(weaponclass(self.weapon) == "rocketlauncher") {
    animscripts\combat_utility::showrocket();
  }
  animscripts\weaponlist::refillclip();
  self.a.needstorechamber = 0;
}

notetrackloadshell(var_0, var_1) {
  self playSound("weap_reload_shotgun_loop_npc");
}

notetrackpistolrechamber(var_0, var_1) {
  self playSound("weap_reload_pistol_chamber_npc");
}

notetrackgravity(var_0, var_1) {
  if(issubstr(var_0, "on")) {
    self animmode("gravity");
  } else if(issubstr(var_0, "off")) {
    self animmode("nogravity");
  }
}

notetrackfootstep(var_0, var_1) {
  var_2 = issubstr(var_0, "left");
  var_3 = issubstr(var_0, "large");
  playfootstep(var_2, var_3);
  var_4 = get_notetrack_movement();
  self playSound("gear_rattle_" + var_4);
}

get_notetrack_movement() {
  var_0 = "run";

  if(isDefined(self.sprint)) {
    var_0 = "sprint";
  }
  if(isDefined(self.a)) {
    if(isDefined(self.a.movement)) {
      if(self.a.movement == "walk") {
        var_0 = "walk";
      }
    }

    if(isDefined(self.a.pose)) {
      if(self.a.pose == "prone") {
        var_0 = "prone";
      }
    }
  }

  return var_0;
}

customnotetrackfx(var_0, var_1) {
  if(isDefined(self.groundtype)) {
    var_2 = self.groundtype;
  } else {
    var_2 = "dirt";
  }
  var_3 = undefined;

  if(isDefined(level._notetrackfx[var_0][var_2])) {
    var_3 = level._notetrackfx[var_0][var_2];
  } else if(isDefined(level._notetrackfx[var_0]["all"])) {
    var_3 = level._notetrackfx[var_0]["all"];
  }
  if(!isDefined(var_3)) {
    return;
  }
  if(isai(self)) {
    playFXOnTag(var_3.fx, self, var_3.tag);
  }
  if(!isDefined(var_3.sound_prefix) && !isDefined(var_3.sound_suffix)) {
    return;
  }
  var_4 = "" + var_3.sound_prefix + var_2 + var_3.sound_suffix;
  self playSound(var_4);
}

notetrackfootscrape(var_0, var_1) {
  if(isDefined(self.groundtype)) {
    var_2 = self.groundtype;
  } else {
    var_2 = "dirt";
  }
  self playSound("step_scrape_" + var_2);
}

notetrackland(var_0, var_1) {
  if(isDefined(self.groundtype)) {
    var_2 = self.groundtype;
  } else {
    var_2 = "dirt";
  }
  self playSound("land_" + var_2);
}

notetrackcodemove(var_0, var_1) {
  return "code_move";
}

notetrackfaceenemy(var_0, var_1) {
  if(self.script != "reactions") {
    self orientmode("face enemy");
  } else if(isDefined(self.enemy) && distancesquared(self.enemy.origin, self.reactiontargetpos) < 4096) {
    self orientmode("face enemy");
  } else {
    self orientmode("face point", self.reactiontargetpos);
  }
}

notetrackbodyfall(var_0, var_1) {
  var_2 = "_small";

  if(issubstr(var_0, "large")) {
    var_2 = "_large";
  }
  if(isDefined(self.groundtype)) {
    var_3 = self.groundtype;
  } else {
    var_3 = "dirt";
  }
  self playSound("bodyfall_" + var_3 + var_2);
}

handlenotetrack(var_0, var_1, var_2) {
  if(isai(self) && self.type == "dog") {
    if(handledogsoundnotetracks(var_0)) {
      return;
    }
  }

  var_3 = anim.notetracks[var_0];

  if(isDefined(var_3)) {
    return [[var_3]](var_0, var_1);
  }
  switch (var_0) {
    case "undefined":
    case "finish":
    case "end":
      return var_0;
    case "finish early":
      if(isDefined(self.enemy)) {
        return var_0;
      }
      break;
    case "swish small":
      thread common_scripts\utility::play_sound_in_space("melee_swing_small", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "swish large":
      thread common_scripts\utility::play_sound_in_space("melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "rechamber":
      if(animscripts\utility::weapon_pump_action_shotgun()) {
        self playSound("weap_reload_shotgun_pump_npc");
      }
      self.a.needstorechamber = 0;
      break;
    case "no death":
      self.a.nodeath = 1;
      break;
    case "no pain":
      self.allowpain = 0;
      break;
    case "allow pain":
      self.allowpain = 1;
      break;
    case "anim_melee = \"right\"":
    case "anim_melee = right":
      self.a.meleestate = "right";
      break;
    case "anim_melee = \"left\"":
    case "anim_melee = left":
      self.a.meleestate = "left";
      break;
    case "swap taghelmet to tagleft":
      if(isDefined(self.hatmodel)) {
        if(isDefined(self.helmetsidemodel)) {
          self detach(self.helmetsidemodel, "TAG_HELMETSIDE");
          self.helmetsidemodel = undefined;
        }

        self detach(self.hatmodel, "");
        self attach(self.hatmodel, "TAG_WEAPON_LEFT");
        self.hatmodel = undefined;
      }

      break;
    case "stop anim":
      maps\_utility::anim_stopanimscripted();
      return var_0;
    case "break glass":
      level notify("glass_break", self);
      break;
    case "break_glass":
      level notify("glass_break", self);
      break;
    default:
      if(isDefined(var_2)) {
        return [[var_2]](var_0);
      }
      break;
  }
}

donotetracksintercept(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_0, var_3);

    if(!isDefined(var_3)) {
      var_3 = "undefined";
    }
    var_4 = [[var_1]](var_3);

    if(isDefined(var_4) && var_4) {
      continue;
    }
    var_5 = handlenotetrack(var_3, var_0);

    if(isDefined(var_5)) {
      return var_5;
    }
  }
}

donotetrackspostcallback(var_0, var_1) {
  for(;;) {
    self waittill(var_0, var_2);

    if(!isDefined(var_2)) {
      var_2 = "undefined";
    }
    var_3 = handlenotetrack(var_2, var_0);
    [[var_1]](var_2);

    if(isDefined(var_3)) {
      return var_3;
    }
  }
}

donotetracksfortimeout(var_0, var_1, var_2, var_3) {
  animscripts\shared::donotetracks(var_0, var_2, var_3);
}

donotetracksforever(var_0, var_1, var_2, var_3) {
  donotetracksforeverproc(animscripts\shared::donotetracks, var_0, var_1, var_2, var_3);
}

donotetracksforeverintercept(var_0, var_1, var_2, var_3) {
  donotetracksforeverproc(::donotetracksintercept, var_0, var_1, var_2, var_3);
}

donotetracksforeverproc(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }
  self endon("killanimscript");

  if(!isDefined(var_4)) {
    var_4 = "undefined";
  }
  for(;;) {
    var_5 = gettime();
    var_6 = [[var_0]](var_1, var_3, var_4);
    var_7 = gettime() - var_5;

    if(var_7 < 0.05) {
      var_5 = gettime();
      var_6 = [[var_0]](var_1, var_3, var_4);
      var_7 = gettime() - var_5;

      if(var_7 < 0.05) {
        wait(0.05 - var_7);
      }
    }
  }
}

donotetrackswithtimeout(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread donotetracksfortimeendnotify(var_1);
  donotetracksfortimeproc(::donotetracksfortimeout, var_0, var_2, var_3, var_4);
}

donotetracksfortime(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread donotetracksfortimeendnotify(var_0);
  donotetracksfortimeproc(::donotetracksforever, var_1, var_2, var_3, var_4);
}

donotetracksfortimeintercept(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  var_4 thread donotetracksfortimeendnotify(var_0);
  donotetracksfortimeproc(::donotetracksforeverintercept, var_1, var_2, var_3, var_4);
}

donotetracksfortimeproc(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon("stop_notetracks");
  [[var_0]](var_1, undefined, var_2, var_3);
}

donotetracksfortimeendnotify(var_0) {
  wait(var_0);
  self notify("stop_notetracks");
}

playfootstep(var_0, var_1) {
  if(!isai(self)) {
    self playSound("step_run_dirt");
  } else {
    var_2 = undefined;

    if(!isDefined(self.groundtype)) {
      if(!isDefined(self.lastgroundtype)) {
        self playSound("step_run_dirt");
        return;
      }

      var_2 = self.lastgroundtype;
    } else {
      var_2 = self.groundtype;
      self.lastgroundtype = self.groundtype;
    }

    var_3 = "J_Ball_RI";

    if(var_0) {
      var_3 = "J_Ball_LE";
    }
    var_4 = get_notetrack_movement();
    self playSound("step_" + var_4 + "_" + var_2);

    if(var_1) {
      if(![[anim.optionalstepeffectfunction]](var_3, var_2)) {
        playfootstepeffectsmall(var_3, var_2);
        return;
      }

      return;
    }

    if(![[anim.optionalstepeffectsmallfunction]](var_3, var_2)) {
      playfootstepeffect(var_3, var_2);
    }
  }
}

playfootstepeffect(var_0, var_1) {
  for(var_2 = 0; var_2 < anim.optionalstepeffects.size; var_2++) {
    if(var_1 != anim.optionalstepeffects[var_2]) {
      continue;
    }
    var_3 = self gettagorigin(var_0);
    var_4 = self.angles;
    var_5 = anglesToForward(var_4);
    var_6 = var_5 * -1;
    var_7 = anglestoup(var_4);
    playFX(level._effect["step_" + anim.optionalstepeffects[var_2]], var_3, var_7, var_6);
    return 1;
  }

  return 0;
}

playfootstepeffectsmall(var_0, var_1) {
  for(var_2 = 0; var_2 < anim.optionalstepeffectssmall.size; var_2++) {
    if(var_1 != anim.optionalstepeffectssmall[var_2]) {
      continue;
    }
    var_3 = self gettagorigin(var_0);
    var_4 = self.angles;
    var_5 = anglesToForward(var_4);
    var_6 = var_5 * -1;
    var_7 = anglestoup(var_4);
    playFX(level._effect["step_small_" + anim.optionalstepeffectssmall[var_2]], var_3, var_7, var_6);
    return 1;
  }

  return 0;
}

shootnotetrack() {
  waittillframeend;

  if(isDefined(self) && gettime() > self.a.lastshoottime) {
    animscripts\utility::shootenemywrapper();
    animscripts\combat_utility::decrementbulletsinclip();

    if(weaponclass(self.weapon) == "rocketlauncher") {
      self.a.rockets--;
    }
  }
}

fire_straight() {
  if(self.a.weaponpos["right"] == "none") {
    return;
  }
  if(isDefined(self.dontshootstraight)) {
    shootnotetrack();
    return;
  }

  var_0 = self gettagorigin("tag_weapon");
  var_1 = anglesToForward(self getmuzzleangle());
  var_2 = var_0 + var_1 * 1000;
  self shoot(1, var_2);
  animscripts\combat_utility::decrementbulletsinclip();
}

notetrackfirespray(var_0, var_1) {
  if(!isalive(self) && self isbadguy()) {
    if(isDefined(self.changed_team)) {
      return;
    }
    self.changed_team = 1;
    var_2["axis"] = "team3";
    var_2["team3"] = "axis";
    self.team = var_2[self.team];
  }

  if(!issentient(self)) {
    self notify("fire");
    return;
  }

  if(self.a.weaponpos["right"] == "none") {
    return;
  }
  var_3 = self getmuzzlepos();
  var_4 = anglesToForward(self getmuzzleangle());
  var_5 = 10;

  if(isDefined(self.isrambo)) {
    var_5 = 20;
  }
  var_6 = 0;

  if(isalive(self.enemy) && issentient(self.enemy) && self canshootenemy()) {
    var_7 = vectorNormalize(self.enemy getEye() - var_3);

    if(vectordot(var_4, var_7) > cos(var_5)) {
      var_6 = 1;
    }
  }

  if(var_6) {
    animscripts\utility::shootenemywrapper();
  } else {
    var_4 = var_4 + ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
    var_8 = var_3 + var_4 * 1000;
    animscripts\utility::shootposwrapper(var_8);
  }

  animscripts\combat_utility::decrementbulletsinclip();
}