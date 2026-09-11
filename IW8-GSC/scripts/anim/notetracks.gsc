/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\notetracks.gsc
***********************************************/

function registernotetracks() {
  anim.notetracks["anim_movement = \"stop\""] = &notetrackmovementstop;
  anim.notetracks["anim_movement = \"walk\""] = &notetrackmovementwalk;
  anim.notetracks["anim_movement = \"run\""] = &notetrackmovementrun;
  anim.notetracks["anim_movement = stop"] = &notetrackmovementstop;
  anim.notetracks["anim_movement = walk"] = &notetrackmovementwalk;
  anim.notetracks["anim_movement = run"] = &notetrackmovementrun;
  anim.notetracks["anim_movement_gun_pose_override = run_gun_down"] = &notetrackmovementgunposeoverride;
  anim.notetracks["anim_coverpose = cover_left"] = &notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_right"] = &notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_crouch"] = &notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_stand"] = &notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_left_crouch"] = &notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_right_crouch"] = &notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = exposed"] = &notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = exposed_crouch"] = &notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = prone"] = &notetrackcoverposerequest;
  anim.notetracks["anim_aiming = 1"] = &notetrackalertnessaiming;
  anim.notetracks["anim_aiming = 0"] = &notetrackalertnessalert;
  anim.notetracks["anim_alertness = causal"] = &notetrackalertnesscasual;
  anim.notetracks["anim_alertness = alert"] = &notetrackalertnessalert;
  anim.notetracks["anim_alertness = aiming"] = &notetrackalertnessaiming;
  anim.notetracks["gravity on"] = &notetrackgravity;
  anim.notetracks["gravity off"] = &notetrackgravity;
  anim.notetracks["bodyfall large"] = &notetrackbodyfall;
  anim.notetracks["bodyfall small"] = &notetrackbodyfall;
  anim.notetracks["code_move"] = &notetrackcodemove;
  anim.notetracks["face_enemy"] = &notetrackfaceenemy;
  anim.notetracks["pistol_rechamber"] = &notetrackpistolrechamber;
  anim.notetracks["load_shell"] = &notetrackloadshell;
  anim.notetracks["fire"] = &notetrackfire;
  anim.notetracks["fire_spray"] = &notetrackfirespray;
  anim.notetracks["gun_2_chest"] = &notetrackguntochest;
  anim.notetracks["gun_2_back"] = &notetrackguntoback;
  anim.notetracks["gun_2_right"] = &notetrackguntoright;
  anim.notetracks["pistol_pickup"] = &notetrackpistolpickup;
  anim.notetracks["pistol_putaway"] = &notetrackpistolputaway;
  anim.notetracks["refill clip"] = &notetrackrefillclip;
  anim.notetracks["reload done"] = &notetrackrefillclip;
  anim.notetracks["ht_on"] = &notetrackhton0;
  anim.notetracks["ht_on_0"] = &notetrackhton0;
  anim.notetracks["ht_on_1"] = &notetrackhton1;
  anim.notetracks["ht_off"] = &notetrackhtoff;

  if(isDefined(level._notetrackfx)) {
    var_0 = getarraykeys(level._notetrackfx);

    foreach(var_2 in var_0) {
      anim.notetracks[var_2] = &customnotetrackfx;
    }

    return;
  }
}

function notetrackstopanim(var_0, var_1) {}

function notetrackcoverposerequest(var_0, var_1) {
  var_2 = strtok(var_0, " = ")[1];

  switch (var_2) {
    case "cover_left":
    case "cover_stand":
    case "cover_crouch":
    case "exposed_crouch":
    case "cover_right_crouch":
    case "cover_left_crouch":
    case "cover_right":
    case "exposed":
    case "prone":
      self.a.coverpose_request = var_2;
      break;
    default:
      break;
  }
}

function notetrackmovementstop(var_0, var_1) {
  self.a.movement = "stop";
}

function notetrackmovementwalk(var_0, var_1) {
  self.a.movement = "walk";
}

function notetrackmovementrun(var_0, var_1) {
  self.a.movement = "run";
}

function notetrackmovementgunposeoverride(var_0, var_1) {
  self.asm.movementgunposeoverride = "run_gun_down";
}

function notetrackalertnessaiming(var_0, var_1) {}

function notetrackalertnesscasual(var_0, var_1) {}

function notetrackalertnessalert(var_0, var_1) {}

function notetrackloadshell(var_0, var_1) {}

function notetrackpistolrechamber(var_0, var_1) {}

function notetrackgravity(var_0, var_1) {
  if(issubstr(var_0, "on")) {
    self animmode("gravity");
    return;
  }

  if(issubstr(var_0, "off")) {
    self animmode("nogravity");
    return;
  }
}

function customnotetrackfx(var_0, var_1) {
  if(isDefined(self.groundtype)) {
    var_2 = self.groundtype;
  } else {
    var_2 = "dirt";
  }

  var_3 = undefined;

  if(isDefined(level._notetrackfx[var_1][var_2])) {
    var_3 = level._notetrackfx[var_1][var_2];
  } else if(isDefined(level._notetrackfx[var_1]["all"])) {
    var_3 = level._notetrackfx[var_1]["all"];
  }

  if(!isDefined(var_3)) {
    return;
  }

  if(isai(self) && isDefined(var_3.fx)) {
    playFXOnTag(var_3.fx, self, var_3.tag);
  }

  if(!isDefined(var_3.sound_prefix) && !isDefined(var_3.sound_suffix)) {
    return;
  }

  var_4 = "" + var_3.sound_prefix + var_2 + var_3.sound_suffix;

  if(soundexists(var_4)) {
    self playSound(var_4);
    return;
  }
}

function notetrackcodemove(var_0, var_1) {
  return "code_move";
}

function notetrackfaceenemy(var_0, var_1) {
  self orientmode("face enemy");
}

function notetrackbodyfall(var_0, var_1) {
  var_2 = "_small";

  if(issubstr(var_0, "large")) {
    var_2 = "_large";
  }

  if(isDefined(self.groundtype)) {
    var_3 = self.groundtype;
  } else {
    var_3 = "dirt";
  }

  if(var_3 == "_large") {
    self playsurfacesound("bodyfall_torso", var_3);
    return;
  }

  self playsurfacesound("bodyfall_limb_small", var_3);
}

function donotetracks(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_0, var_3);

    if(!isDefined(var_3)) {
      var_3 = ["undefined"];
    }

    if(!isarray(var_3)) {
      var_3 = [var_3];
    }

    scripts\common\notetrack::validatenotetracks(var_0, var_3);

    foreach(var_5 in var_3) {
      var_6 = handlenotetrack(var_5, var_0, var_1);

      if(isDefined(var_6)) {
        return var_6;
      }
    }
  }
}

function handlenotetrack(var_0, var_1, var_2, var_3) {
  if(isDefined(self.fnasm_handlenotetrack)) {
    [[self.fnasm_handlenotetrack]](var_0, var_1, var_2, var_3);
    return;
  }

  if(isDefined(level._defaultnotetrackhandler)) {
    [[level._defaultnotetrackhandler]](var_0, var_1, var_2, var_3);
    return;
  }
}

function hascustomnotetrackhandler(var_0) {
  var_1 = anim.notetracks[var_0];

  if(isDefined(var_1)) {
    return true;
  }

  if(isDefined(self.customnotetrackhandler)) {
    return true;
  }

  return false;
}

function handlecustomnotetrackhandler(var_0, var_1, var_2, var_3) {
  var_4 = anim.notetracks[var_0];

  if(isDefined(var_4)) {
    return [[var_4]](var_0, var_1);
  }

  if(isDefined(self.customnotetrackhandler)) {
    if(isDefined(var_3)) {
      return [[self.customnotetrackhandler]](var_0, var_1, var_2, var_3);
    }

    return [[self.customnotetrackhandler]](var_0, var_1, var_2);
  }
}

function handlecommonnotetrack(var_0, var_1, var_2, var_3) {
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
      thread scripts\engine\utility::play_sound_in_space("melee_swing_small", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case "swish large":
      thread scripts\engine\utility::play_sound_in_space("melee_swing_large", self gettagorigin("TAG_WEAPON_RIGHT"));
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
    case "break glass":
      level notify("glass_break", self);
      break;
    case "break_glass":
      level notify("glass_break", self);
      break;
    case "start_drift":
      if(!self.fixednode) {
        self animmode("physics_drift");
      }

      break;
    default:
      return "__unhandled";
  }
}

function donotetracksintercept(var_0, var_1, var_2) {
  for(;;) {
    self waittill(var_0, var_3);

    if(!isDefined(var_3)) {
      var_3 = ["undefined"];
    }

    if(!isarray(var_3)) {
      var_3 = [var_3];
    }

    scripts\common\notetrack::validatenotetracks(var_0, var_3);
    var_4 = [[var_1]](var_3);

    if(isDefined(var_4) && var_4) {
      continue;
    }

    var_5 = undefined;

    foreach(var_7 in var_3) {
      var_8 = handlenotetrack(var_7, var_0);

      if(isDefined(var_8)) {
        var_5 = var_8;
        break;
      }
    }

    if(isDefined(var_5)) {
      return var_5;
    }
  }
}

function donotetrackspostcallback(var_0, var_1) {
  for(;;) {
    self waittill(var_0, var_2);

    if(!isDefined(var_2)) {
      var_2 = ["undefined"];
    }

    if(!isarray(var_2)) {
      var_2 = [var_2];
    }

    scripts\common\notetrack::validatenotetracks(var_0, var_2);
    var_3 = undefined;

    foreach(var_5 in var_2) {
      var_6 = handlenotetrack(var_5, var_0);

      if(isDefined(var_6)) {
        var_3 = var_6;
        break;
      }
    }

    [[var_1]](var_2);

    if(isDefined(var_3)) {
      return var_3;
    }
  }
}

function donotetracksfortimeout(var_0, var_1, var_2, var_3) {
  donotetracks(var_0, var_2, var_3);
}

function donotetracksforever(var_0, var_1, var_2, var_3) {
  donotetracksforeverproc(&donotetracks, var_0, var_1, var_2, var_3);
}

function donotetracksforeverintercept(var_0, var_1, var_2, var_3) {
  donotetracksforeverproc(&donotetracksintercept, var_0, var_1, var_2, var_3);
}

function donotetracksforeverproc(var_0, var_1, var_2, var_3, var_4) {
  if(isDefined(var_2)) {
    self endon(var_2);
  }

  self endon("killanimscript");
  jumpiftrue(isDefined(var_4)) LOC_00000021;
  var_4 = "undefined";

  for(;;) {
    var_5 = gettime();
    var_6 = [[var_0]](var_1, var_3, var_4);
    var_7 = gettime() - var_5;

    if(var_7 < 0.05) {
      var_5 = gettime();
      var_6 = [[var_0]](var_1, var_3, var_4);
      var_7 = gettime() - var_5;

      if(var_7 < 0.05) {
        wait 0.05 - var_7;
      }
    }
  }
}

function donotetrackswithtimeout(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread donotetracksfortimeendnotify(var_4);
  donotetracksfortimeproc(&donotetracksfortimeout, var_0, var_2, var_3, var_4);
}

function donotetracksfortime(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread donotetracksfortimeendnotify(var_4);
  donotetracksfortimeproc(&donotetracksforever, var_1, var_2, var_3, var_4);
}

function donotetracksfortimeintercept(var_0, var_1, var_2, var_3) {
  var_4 = spawnStruct();
  thread donotetracksfortimeendnotify(var_4);
  donotetracksfortimeproc(&donotetracksforeverintercept, var_1, var_2, var_3, var_4);
}

function donotetracksfortimeproc(var_0, var_1, var_2, var_3, var_4) {
  var_4 endon("stop_notetracks");
  [[var_0]](var_1, undefined, var_2, var_3);
}

function donotetracksfortimeendnotify(var_0) {
  wait var_0;
  self notify("stop_notetracks");
}

function notetrack_prefix_handler(var_0) {
  return [[level.fnnotetrackprefixhandler]](var_0);
}

function notetrack_prefix_handler_common(var_0) {
  return false;
}

function shootnotetrack() {
  waittillframeend();

  if(isDefined(self) && gettime() > self.a.lastshoottime) {
    if(istrue(self._blackboard.shootparams_valid)) {
      var_0 = self._blackboard.shootparams_shotsperburst == 1;
    } else {
      var_0 = 1;
    }

    scripts\anim\utility_common::shootenemywrapper(var_0);
    scripts\asm\shared\utility::decrementbulletsinclip();

    if(weaponclass(self.weapon) == "rocketlauncher") {
      self.rocketammo--;
      return;
    }

    return;
  }
}

function notetrackfire(var_0, var_1) {
  if(isDefined(self.script) && isDefined(anim.fire_notetrack_functions[self.script])) {
    GscBinSkip1(0x74, anim.fire_notetrack_functions[self.script]);
  }

  thread shootnotetrack();
}

function notetrackfirespray(var_0, var_1) {
  if(!isalive(self) && self isbadguy()) {
    if(isDefined(self.changed_team)) {
      return;
    }

    self.changed_team = 1;
    GscBinSkip1(0x45, "axis", "team3");
  }

  if(!issentient(self)) {
    self notify("fire");
    return;
  }

  if(getqueuedspleveltransients(self.a.weaponpos["right"])) {
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
    scripts\anim\utility_common::shootenemywrapper();
  } else {
    var_4 += ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
    var_8 = var_3 + var_4 * 1000;
    self[[anim.shootposwrapper_func]](var_8);
  }

  scripts\asm\shared\utility::decrementbulletsinclip();
}

function notetrackrefillclip(var_0, var_1) {
  scripts\anim\weaponlist::refillclip();
  self.a.needstorechamber = 0;
}

function getpreferredweapon() {
  if(isDefined(self.wantshotgun) && self.wantshotgun) {
    if(scripts\anim\utility_common::isshotgun(self.primaryweapon)) {
      return self.primaryweapon;
    } else if(scripts\anim\utility_common::isshotgun(self.secondaryweapon)) {
      return self.secondaryweapon;
    }
  }

  return self.primaryweapon;
}

function notetrackguntochest(var_0, var_1) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "chest");
    return;
  }
}

function notetrackguntoback(var_0, var_1) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "back");
  }

  self.weapon = getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

function notetrackpistolpickup(var_0, var_1) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.sidearm, "right");
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

function notetrackpistolputaway(var_0, var_1) {
  if(isDefined(self.fnplaceweaponon)) {
    if(isDefined(self.stowsidearmposition)) {
      self[[self.fnplaceweaponon]](self.weapon, self.stowsidearmposition);
    } else {
      self[[self.fnplaceweaponon]](self.weapon, "none");
    }
  }

  self.weapon = getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

function notetrackguntoright(var_0, var_1) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "right");
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
}

function notetrackhton0(var_0, var_1) {
  if(!self isinscriptedstate()) {
    self enablestatelookat(1, 0);
    return;
  }
}

function notetrackhton1(var_0, var_1) {
  if(!self isinscriptedstate()) {
    self enablestatelookat(1, 1);
    return;
  }
}

function notetrackhtoff(var_0, var_1) {
  if(!self isinscriptedstate()) {
    self enablestatelookat(0);
    return;
  }
}