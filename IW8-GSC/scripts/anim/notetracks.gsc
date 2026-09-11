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
    var0 = getarraykeys(level._notetrackfx);

    foreach(var2 in var0) {
      anim.notetracks[var2] = &customnotetrackfx;
    }

    return;
  }
}

function notetrackstopanim(var0, var1) {}

function notetrackcoverposerequest(var0, var1) {
  var2 = strtok(var0, " = ")[1];

  switch (var2) {
    case "cover_left":
    case "cover_stand":
    case "cover_crouch":
    case "exposed_crouch":
    case "cover_right_crouch":
    case "cover_left_crouch":
    case "cover_right":
    case "exposed":
    case "prone":
      self.a.coverpose_request = var2;
      break;
    default:
      break;
  }
}

function notetrackmovementstop(var0, var1) {
  self.a.movement = "stop";
}

function notetrackmovementwalk(var0, var1) {
  self.a.movement = "walk";
}

function notetrackmovementrun(var0, var1) {
  self.a.movement = "run";
}

function notetrackmovementgunposeoverride(var0, var1) {
  self.asm.movementgunposeoverride = "run_gun_down";
}

function notetrackalertnessaiming(var0, var1) {}

function notetrackalertnesscasual(var0, var1) {}

function notetrackalertnessalert(var0, var1) {}

function notetrackloadshell(var0, var1) {}

function notetrackpistolrechamber(var0, var1) {}

function notetrackgravity(var0, var1) {
  if(issubstr(var0, "on")) {
    self animmode("gravity");
    return;
  }

  if(issubstr(var0, "off")) {
    self animmode("nogravity");
    return;
  }
}

function customnotetrackfx(var0, var1) {
  if(isDefined(self.groundtype)) {
    var2 = self.groundtype;
  } else {
    var2 = "dirt";
  }

  var3 = undefined;

  if(isDefined(level._notetrackfx[var1][var2])) {
    var3 = level._notetrackfx[var1][var2];
  } else if(isDefined(level._notetrackfx[var1]["all"])) {
    var3 = level._notetrackfx[var1]["all"];
  }

  if(!isDefined(var3)) {
    return;
  }

  if(isai(self) && isDefined(var3.fx)) {
    playFXOnTag(var3.fx, self, var3.tag);
  }

  if(!isDefined(var3.sound_prefix) && !isDefined(var3.sound_suffix)) {
    return;
  }

  var4 = "" + var3.sound_prefix + var2 + var3.sound_suffix;

  if(soundexists(var4)) {
    self playSound(var4);
    return;
  }
}

function notetrackcodemove(var0, var1) {
  return "code_move";
}

function notetrackfaceenemy(var0, var1) {
  self orientmode("face enemy");
}

function notetrackbodyfall(var0, var1) {
  var2 = "_small";

  if(issubstr(var0, "large")) {
    var2 = "_large";
  }

  if(isDefined(self.groundtype)) {
    var3 = self.groundtype;
  } else {
    var3 = "dirt";
  }

  if(var3 == "_large") {
    self playsurfacesound("bodyfall_torso", var3);
    return;
  }

  self playsurfacesound("bodyfall_limb_small", var3);
}

function donotetracks(var0, var1, var2) {
  for(;;) {
    self waittill(var0, var3);

    if(!isDefined(var3)) {
      var3 = ["undefined"];
    }

    if(!isarray(var3)) {
      var3 = [var3];
    }

    scripts\common\notetrack::validatenotetracks(var0, var3);

    foreach(var5 in var3) {
      var6 = handlenotetrack(var5, var0, var1);

      if(isDefined(var6)) {
        return var6;
      }
    }
  }
}

function handlenotetrack(var0, var1, var2, var3) {
  if(isDefined(self.fnasm_handlenotetrack)) {
    [[self.fnasm_handlenotetrack]](var0, var1, var2, var3);
    return;
  }

  if(isDefined(level._defaultnotetrackhandler)) {
    [[level._defaultnotetrackhandler]](var0, var1, var2, var3);
    return;
  }
}

function hascustomnotetrackhandler(var0) {
  var1 = anim.notetracks[var0];

  if(isDefined(var1)) {
    return true;
  }

  if(isDefined(self.customnotetrackhandler)) {
    return true;
  }

  return false;
}

function handlecustomnotetrackhandler(var0, var1, var2, var3) {
  var4 = anim.notetracks[var0];

  if(isDefined(var4)) {
    return [[var4]](var0, var1);
  }

  if(isDefined(self.customnotetrackhandler)) {
    if(isDefined(var3)) {
      return [[self.customnotetrackhandler]](var0, var1, var2, var3);
    }

    return [[self.customnotetrackhandler]](var0, var1, var2);
  }
}

function handlecommonnotetrack(var0, var1, var2, var3) {
  switch (var0) {
    case "undefined":
    case "finish":
    case "end":
      return var0;
    case "finish early":
      if(isDefined(self.enemy)) {
        return var0;
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

function donotetracksintercept(var0, var1, var2) {
  for(;;) {
    self waittill(var0, var3);

    if(!isDefined(var3)) {
      var3 = ["undefined"];
    }

    if(!isarray(var3)) {
      var3 = [var3];
    }

    scripts\common\notetrack::validatenotetracks(var0, var3);
    var4 = [[var1]](var3);

    if(isDefined(var4) && var4) {
      continue;
    }

    var5 = undefined;

    foreach(var7 in var3) {
      var8 = handlenotetrack(var7, var0);

      if(isDefined(var8)) {
        var5 = var8;
        break;
      }
    }

    if(isDefined(var5)) {
      return var5;
    }
  }
}

function donotetrackspostcallback(var0, var1) {
  for(;;) {
    self waittill(var0, var2);

    if(!isDefined(var2)) {
      var2 = ["undefined"];
    }

    if(!isarray(var2)) {
      var2 = [var2];
    }

    scripts\common\notetrack::validatenotetracks(var0, var2);
    var3 = undefined;

    foreach(var5 in var2) {
      var6 = handlenotetrack(var5, var0);

      if(isDefined(var6)) {
        var3 = var6;
        break;
      }
    }

    [[var1]](var2);

    if(isDefined(var3)) {
      return var3;
    }
  }
}

function donotetracksfortimeout(var0, var1, var2, var3) {
  donotetracks(var0, var2, var3);
}

function donotetracksforever(var0, var1, var2, var3) {
  donotetracksforeverproc(&donotetracks, var0, var1, var2, var3);
}

function donotetracksforeverintercept(var0, var1, var2, var3) {
  donotetracksforeverproc(&donotetracksintercept, var0, var1, var2, var3);
}

function donotetracksforeverproc(var0, var1, var2, var3, var4) {
  if(isDefined(var2)) {
    self endon(var2);
  }

  self endon("killanimscript");
  jumpiftrue(isDefined(var4)) LOC_00000021;
  var4 = "undefined";

  for(;;) {
    var5 = gettime();
    var6 = [[var0]](var1, var3, var4);
    var7 = gettime() - var5;

    if(var7 < 0.05) {
      var5 = gettime();
      var6 = [[var0]](var1, var3, var4);
      var7 = gettime() - var5;

      if(var7 < 0.05) {
        wait 0.05 - var7;
      }
    }
  }
}

function donotetrackswithtimeout(var0, var1, var2, var3) {
  var4 = spawnStruct();
  thread donotetracksfortimeendnotify(var4);
  donotetracksfortimeproc(&donotetracksfortimeout, var0, var2, var3, var4);
}

function donotetracksfortime(var0, var1, var2, var3) {
  var4 = spawnStruct();
  thread donotetracksfortimeendnotify(var4);
  donotetracksfortimeproc(&donotetracksforever, var1, var2, var3, var4);
}

function donotetracksfortimeintercept(var0, var1, var2, var3) {
  var4 = spawnStruct();
  thread donotetracksfortimeendnotify(var4);
  donotetracksfortimeproc(&donotetracksforeverintercept, var1, var2, var3, var4);
}

function donotetracksfortimeproc(var0, var1, var2, var3, var4) {
  var4 endon("stop_notetracks");
  [[var0]](var1, undefined, var2, var3);
}

function donotetracksfortimeendnotify(var0) {
  wait var0;
  self notify("stop_notetracks");
}

function notetrack_prefix_handler(var0) {
  return [[level.fnnotetrackprefixhandler]](var0);
}

function notetrack_prefix_handler_common(var0) {
  return false;
}

function shootnotetrack() {
  waittillframeend();

  if(isDefined(self) && gettime() > self.a.lastshoottime) {
    if(istrue(self._blackboard.shootparams_valid)) {
      var0 = self._blackboard.shootparams_shotsperburst == 1;
    } else {
      var0 = 1;
    }

    scripts\anim\utility_common::shootenemywrapper(var0);
    scripts\asm\shared\utility::decrementbulletsinclip();

    if(weaponclass(self.weapon) == "rocketlauncher") {
      self.rocketammo--;
      return;
    }

    return;
  }
}

function notetrackfire(var0, var1) {
  if(isDefined(self.script) && isDefined(anim.fire_notetrack_functions[self.script])) {
    GscBinSkip1(0x74, anim.fire_notetrack_functions[self.script]);
  }

  thread shootnotetrack();
}

function notetrackfirespray(var0, var1) {
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

  var3 = self getmuzzlepos();
  var4 = anglesToForward(self getmuzzleangle());
  var5 = 10;

  if(isDefined(self.isrambo)) {
    var5 = 20;
  }

  var6 = 0;

  if(isalive(self.enemy) && issentient(self.enemy) && self canshootenemy()) {
    var7 = vectorNormalize(self.enemy getEye() - var3);

    if(vectordot(var4, var7) > cos(var5)) {
      var6 = 1;
    }
  }

  if(var6) {
    scripts\anim\utility_common::shootenemywrapper();
  } else {
    var4 += ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
    var8 = var3 + var4 * 1000;
    self[[anim.shootposwrapper_func]](var8);
  }

  scripts\asm\shared\utility::decrementbulletsinclip();
}

function notetrackrefillclip(var0, var1) {
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

function notetrackguntochest(var0, var1) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "chest");
    return;
  }
}

function notetrackguntoback(var0, var1) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "back");
  }

  self.weapon = getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

function notetrackpistolpickup(var0, var1) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.sidearm, "right");
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

function notetrackpistolputaway(var0, var1) {
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

function notetrackguntoright(var0, var1) {
  if(isDefined(self.fnplaceweaponon)) {
    self[[self.fnplaceweaponon]](self.weapon, "right");
  }

  self.bulletsinclip = weaponclipsize(self.weapon);
}

function notetrackhton0(var0, var1) {
  if(!self isinscriptedstate()) {
    self enablestatelookat(1, 0);
    return;
  }
}

function notetrackhton1(var0, var1) {
  if(!self isinscriptedstate()) {
    self enablestatelookat(1, 1);
    return;
  }
}

function notetrackhtoff(var0, var1) {
  if(!self isinscriptedstate()) {
    self enablestatelookat(0);
    return;
  }
}