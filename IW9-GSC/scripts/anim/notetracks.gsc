/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\notetracks.gsc
***********************************************/

registernotetracks() {
  anim.notetracks["anim_movement = \"stop\""] = ::notetrackmovementstop;
  anim.notetracks["anim_movement = \"walk\""] = ::notetrackmovementwalk;
  anim.notetracks["anim_movement = \"run\""] = ::notetrackmovementrun;
  anim.notetracks["anim_movement = stop"] = ::notetrackmovementstop;
  anim.notetracks["anim_movement = walk"] = ::notetrackmovementwalk;
  anim.notetracks["anim_movement = run"] = ::notetrackmovementrun;
  anim.notetracks["anim_movement_gun_pose_override = run_gun_down"] = ::notetrackmovementgunposeoverride;
  anim.notetracks["anim_coverpose = cover_left"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_right"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_crouch"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_stand"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_left_crouch"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = cover_right_crouch"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = exposed"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = exposed_crouch"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_coverpose = prone"] = ::notetrackcoverposerequest;
  anim.notetracks["anim_aiming = 1"] = ::notetrackalertnessaiming;
  anim.notetracks["anim_aiming = 0"] = ::notetrackalertnessalert;
  anim.notetracks["anim_alertness = causal"] = ::notetrackalertnesscasual;
  anim.notetracks["anim_alertness = alert"] = ::notetrackalertnessalert;
  anim.notetracks["anim_alertness = aiming"] = ::notetrackalertnessaiming;
  anim.notetracks["gravity on"] = ::notetrackgravity;
  anim.notetracks["gravity off"] = ::notetrackgravity;
  anim.notetracks["bodyfall large"] = ::notetrackbodyfall;
  anim.notetracks["bodyfall small"] = ::notetrackbodyfall;
  anim.notetracks["code_move"] = ::notetrackcodemove;
  anim.notetracks["face_enemy"] = ::notetrackfaceenemy;
  anim.notetracks["pistol_rechamber"] = ::notetrackpistolrechamber;
  anim.notetracks["load_shell"] = ::notetrackloadshell;
  anim.notetracks["fire_if_loaded"] = ::_id_DF92AADF78BFCF42;
  anim.notetracks["fire"] = ::notetrackfire;
  anim.notetracks["fire_spray"] = ::notetrackfirespray;
  anim.notetracks["gun_2_chest"] = ::notetrackguntochest;
  anim.notetracks["gun_2_back"] = ::notetrackguntoback;
  anim.notetracks["gun_2_right"] = ::notetrackguntoright;
  anim.notetracks["gun_2_hand"] = ::_id_12E1635911FD2716;
  anim.notetracks["pistol_pickup"] = ::notetrackpistolpickup;
  anim.notetracks["pistol_putaway"] = ::notetrackpistolputaway;
  anim.notetracks["refill clip"] = ::notetrackrefillclip;
  anim.notetracks["reload done"] = ::notetrackrefillclip;
  anim.notetracks["ht_on"] = ::notetrackhton0;
  anim.notetracks["ht_on_0"] = ::notetrackhton0;
  anim.notetracks["ht_on_1"] = ::notetrackhton1;
  anim.notetracks["ht_off"] = ::notetrackhtoff;
  anim.notetracks["hp_on"] = ::_id_5A8F2C4BA78D7BFF;
  anim.notetracks["hp_on_pos"] = ::_id_AB37DA002EDDAF9F;
  anim.notetracks["hp_off"] = ::_id_B67DF3617C4F2903;
  anim.notetracks["notify"] = ::_id_C7C1DD20323389C9;
  anim.notetracks["unlinkmodel"] = ::_id_A73998EF3B3ABDD4;
  anim.notetracks["charge_abort"] = ::_id_28B89C4EC5292326;
  anim.notetracks["melee_swipe"] = ::_id_1777A8463E80F52E;

  if(isDefined(level._notetrackfx)) {
    keys = getarraykeys(level._notetrackfx);

    foreach(key in keys)
    anim.notetracks[key] = ::customnotetrackfx;
  }
}

notetrackstopanim(_id_A234A65C378F3289, flagname) {}

notetrackcoverposerequest(_id_A234A65C378F3289, flagname) {
  _id_6B92E7E9D48F74A9 = strtok(_id_A234A65C378F3289, " = ")[1];

  switch (_id_6B92E7E9D48F74A9) {
    case "exposed_crouch":
    case "cover_left":
    case "cover_right_crouch":
    case "cover_right":
    case "cover_crouch":
    case "cover_left_crouch":
    case "cover_stand":
    case "exposed":
    case "prone":
      self._id_B74CB68648B5306E = _id_6B92E7E9D48F74A9;
      break;
    default:
  }
}

notetrackmovementstop(_id_A234A65C378F3289, flagname) {
  self.a.movement = "stop";
}

notetrackmovementwalk(_id_A234A65C378F3289, flagname) {
  self.a.movement = "walk";
}

notetrackmovementrun(_id_A234A65C378F3289, flagname) {
  self.a.movement = "run";
}

notetrackmovementgunposeoverride(_id_A234A65C378F3289, flagname) {
  self.asm.movementgunposeoverride = "run_gun_down";
}

notetrackalertnessaiming(_id_A234A65C378F3289, flagname) {}

notetrackalertnesscasual(_id_A234A65C378F3289, flagname) {}

notetrackalertnessalert(_id_A234A65C378F3289, flagname) {}

notetrackloadshell(_id_A234A65C378F3289, flagname) {}

notetrackpistolrechamber(_id_A234A65C378F3289, flagname) {}

notetrackgravity(_id_A234A65C378F3289, flagname) {
  if(issubstr(_id_A234A65C378F3289, "on"))
    self animmode("gravity");
  else if(issubstr(_id_A234A65C378F3289, "off"))
    self animmode("nogravity");
}

customnotetrackfx(_id_A234A65C378F3289, flagname) {
  if(isDefined(self.groundtype))
    groundtype = self.groundtype;
  else
    groundtype = "dirt";

  struct = undefined;

  if(isDefined(level._notetrackfx[_id_A234A65C378F3289][groundtype]))
    struct = level._notetrackfx[_id_A234A65C378F3289][groundtype];
  else if(isDefined(level._notetrackfx[_id_A234A65C378F3289]["all"]))
    struct = level._notetrackfx[_id_A234A65C378F3289]["all"];

  if(!isDefined(struct)) {
    return;
  }
  if(isai(self) && isDefined(struct.fx))
    playFXOnTag(struct.fx, self, struct.tag);

  if(!isDefined(struct.sound_prefix) && !isDefined(struct.sound_suffix)) {
    return;
  }
  alias = "" + struct.sound_prefix + groundtype + struct.sound_suffix;

  if(soundexists(alias))
    self playSound(alias);
}

notetrackcodemove(_id_A234A65C378F3289, flagname) {
  return "code_move";
}

notetrackfaceenemy(_id_A234A65C378F3289, flagname) {
  self orientmode("face enemy");
}

notetrackbodyfall(_id_A234A65C378F3289, flagname) {
  _id_0E4731409BD255E0 = "_small";

  if(issubstr(_id_A234A65C378F3289, "large"))
    _id_0E4731409BD255E0 = "_large";

  if(isDefined(self.groundtype))
    groundtype = self.groundtype;
  else
    groundtype = "dirt";

  if(_id_0E4731409BD255E0 == "_large")
    self playsurfacesound("bodyfall_torso", groundtype);
  else
    self playsurfacesound("bodyfall_limb_small", groundtype);
}

donotetracks(flagname, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F) {
  for(;;) {
    self waittill(flagname, notes);

    if(!isDefined(notes))
      notes = ["undefined"];

    if(!isarray(notes))
      notes = [notes];

    scripts\common\notetrack::validatenotetracks(flagname, notes);

    foreach(_id_A234A65C378F3289 in notes) {
      val = handlenotetrack(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E);

      if(isDefined(val))
        return val;
    }
  }
}

handlenotetrack(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  if(isDefined(self.fnasm_handlenotetrack))
    return [[self.fnasm_handlenotetrack]](_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);
  else if(isDefined(level._defaultnotetrackhandler))
    return [[level._defaultnotetrackhandler]](_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);
  else {}
}

hascustomnotetrackhandler(_id_A234A65C378F3289) {
  _id_C08639C41DC7EEB6 = anim.notetracks[_id_A234A65C378F3289];

  if(isDefined(_id_C08639C41DC7EEB6))
    return 1;

  if(isDefined(self.customnotetrackhandler))
    return 1;

  return 0;
}

handlecustomnotetrackhandler(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  _id_C08639C41DC7EEB6 = anim.notetracks[_id_A234A65C378F3289];

  if(isDefined(_id_C08639C41DC7EEB6))
    return [[_id_C08639C41DC7EEB6]](_id_A234A65C378F3289, flagname);
  else if(isDefined(self.customnotetrackhandler)) {
    if(isDefined(_id_35CE7799B701C978))
      return [[self.customnotetrackhandler]](_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978);
    else
      return [[self.customnotetrackhandler]](_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E);
  }
}

handlecommonnotetrack(_id_A234A65C378F3289, flagname, _id_ED9FB5D37A4C823E, _id_35CE7799B701C978) {
  switch (_id_A234A65C378F3289) {
    case "loop_end":
    case "finish":
    case "undefined":
    case "end":
      return _id_A234A65C378F3289;
    case "finish early":
      if(isDefined(self.enemy))
        return _id_A234A65C378F3289;

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
      if(!self.fixednode)
        self animmode("physics_drift");

      break;
    default:
      return "__unhandled";
  }
}

donotetracksintercept(flagname, _id_7666CC37A119DF55, _id_57DF9F251FEE314F) {
  for(;;) {
    self waittill(flagname, notes);

    if(!isDefined(notes))
      notes = ["undefined"];

    if(!isarray(notes))
      notes = [notes];

    scripts\common\notetrack::validatenotetracks(flagname, notes);
    _id_B9F20576BF9231C8 = [[_id_7666CC37A119DF55]](notes);

    if(isDefined(_id_B9F20576BF9231C8) && _id_B9F20576BF9231C8) {
      continue;
    }
    _id_FC9A12FE1F57542A = undefined;

    foreach(_id_A234A65C378F3289 in notes) {
      val = handlenotetrack(_id_A234A65C378F3289, flagname);

      if(isDefined(val)) {
        _id_FC9A12FE1F57542A = val;
        break;
      }
    }

    if(isDefined(_id_FC9A12FE1F57542A))
      return _id_FC9A12FE1F57542A;
  }
}

donotetrackspostcallback(flagname, _id_31FA99BBEB07EA83) {
  for(;;) {
    self waittill(flagname, notes);

    if(!isDefined(notes))
      notes = ["undefined"];

    if(!isarray(notes))
      notes = [notes];

    scripts\common\notetrack::validatenotetracks(flagname, notes);
    _id_FC9A12FE1F57542A = undefined;

    foreach(_id_A234A65C378F3289 in notes) {
      val = handlenotetrack(_id_A234A65C378F3289, flagname);

      if(isDefined(val)) {
        _id_FC9A12FE1F57542A = val;
        break;
      }
    }

    [[_id_31FA99BBEB07EA83]](notes);

    if(isDefined(_id_FC9A12FE1F57542A))
      return _id_FC9A12FE1F57542A;
  }
}

donotetracksfortimeout(flagname, _id_302D6E3467981A98, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F) {
  donotetracks(flagname, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F);
}

donotetracksforever(flagname, _id_302D6E3467981A98, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F) {
  donotetracksforeverproc(::donotetracks, flagname, _id_302D6E3467981A98, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F);
}

donotetracksforeverintercept(flagname, _id_302D6E3467981A98, _id_7666CC37A119DF55, _id_57DF9F251FEE314F) {
  donotetracksforeverproc(::donotetracksintercept, flagname, _id_302D6E3467981A98, _id_7666CC37A119DF55, _id_57DF9F251FEE314F);
}

donotetracksforeverproc(_id_EABB09C6D4780C53, flagname, _id_302D6E3467981A98, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F) {
  if(isDefined(_id_302D6E3467981A98))
    self endon(_id_302D6E3467981A98);

  self endon("killanimscript");

  if(!isDefined(_id_57DF9F251FEE314F))
    _id_57DF9F251FEE314F = "undefined";

  for(;;) {
    time = gettime();
    _id_CF4DAC4C7B1592B6 = [[_id_EABB09C6D4780C53]](flagname, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F);
    _id_2A52054F316A1FDF = gettime() - time;

    if(_id_2A52054F316A1FDF < 0.05) {
      time = gettime();
      _id_CF4DAC4C7B1592B6 = [[_id_EABB09C6D4780C53]](flagname, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F);
      _id_2A52054F316A1FDF = gettime() - time;

      if(_id_2A52054F316A1FDF < 0.05)
        wait(0.05 - _id_2A52054F316A1FDF);
    }
  }
}

donotetrackswithtimeout(flagname, time, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(::donotetracksfortimeout, flagname, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F, ent);
}

donotetracksfortime(time, flagname, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(::donotetracksforever, flagname, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F, ent);
}

donotetracksfortimeintercept(time, flagname, _id_7666CC37A119DF55, _id_57DF9F251FEE314F) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(::donotetracksforeverintercept, flagname, _id_7666CC37A119DF55, _id_57DF9F251FEE314F, ent);
}

donotetracksfortimeproc(_id_DDFB08FD22CD0FAD, flagname, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F, ent) {
  ent endon("stop_notetracks");
  [[_id_DDFB08FD22CD0FAD]](flagname, undefined, _id_ED9FB5D37A4C823E, _id_57DF9F251FEE314F);
}

donotetracksfortimeendnotify(time) {
  wait(time);
  self notify("stop_notetracks");
}

notetrack_prefix_handler(notetrack) {
  return [[level.fnnotetrackprefixhandler]](notetrack);
}

notetrack_prefix_handler_common(notetrack, _id_7CDB504E7250F362) {
  if(!isDefined(_id_7CDB504E7250F362))
    _id_7CDB504E7250F362 = getsubstr(notetrack, 0, 3);

  switch (_id_7CDB504E7250F362) {
    case "at_":
      _id_FDB7EA91BDA694DC(getsubstr(notetrack, 3));
      return 1;
    case "dt_":
      _id_A06953A984B6A42A(getsubstr(notetrack, 3));
      return 1;
  }

  return 0;
}

_id_FDB7EA91BDA694DC(_id_DB5548BB3BC60B0C) {
  info = strtok(_id_DB5548BB3BC60B0C, ",");
  model = info[0];
  tag = info[1];

  if(isDefined(level.fnnotetrackmodeltranslate))
    model = [[level.fnnotetrackmodeltranslate]](model);

  model = tolower(model);
  tag = tolower(tag);

  if(isDefined(self._id_E2991D2D4B030C75) && isDefined(self._id_E2991D2D4B030C75[tag])) {
    self detach(self._id_E2991D2D4B030C75[tag], tag);
    self._id_E2991D2D4B030C75[tag] = undefined;
  }

  if(model != "none" && model != "") {
    self attach(model, tag, 1);
    self._id_E2991D2D4B030C75[tag] = model;
  }
}

_id_A06953A984B6A42A(_id_DB5548BB3BC60B0C) {
  info = strtok(_id_DB5548BB3BC60B0C, ",");
  model = info[0];
  tag = info[1];

  if(isDefined(self._id_E2991D2D4B030C75) && isDefined(self._id_E2991D2D4B030C75[tag])) {
    self detach(self._id_E2991D2D4B030C75[tag], tag);
    self._id_E2991D2D4B030C75[tag] = undefined;
  } else
    self detach(model, tag);
}

shootnotetrack() {
  waittillframeend;

  if(isDefined(self) && isalive(self) && gettime() > self._blackboard._id_060DCAA3D3BE97AB) {
    if(istrue(self._blackboard.shootparams_valid))
      _id_9BC9D0EE2A8A46F5 = self._blackboard.shootparams_shotsperburst == 1;
    else
      _id_9BC9D0EE2A8A46F5 = 1;

    _id_2B79931B08683E0A::shootenemywrapper(_id_9BC9D0EE2A8A46F5);
    scripts\asm\shared\utility::decrementbulletsinclip();

    if(weaponclass(self.weapon) == "rocketlauncher")
      self.rocketammo--;
  }
}

_id_DF92AADF78BFCF42(_id_A234A65C378F3289, flagname) {
  if(self.bulletsinclip)
    notetrackfire(_id_A234A65C378F3289, flagname);
}

notetrackfire(_id_A234A65C378F3289, flagname) {
  if(isDefined(self.script) && isDefined(anim.fire_notetrack_functions[self.script]))
    thread[[anim.fire_notetrack_functions[self.script]]]();
  else
    thread shootnotetrack();
}

notetrackfirespray(_id_A234A65C378F3289, flagname) {
  if(!isalive(self) && self isbadguy()) {
    if(isDefined(self.changed_team)) {
      return;
    }
    self.changed_team = 1;
    teams["axis"] = "team3";
    teams["team3"] = "axis";
    self.team = teams[self.team];
  }

  if(!issentient(self)) {
    self notify("fire");
    return;
  }

  if(isundefinedweapon(self.a.weaponpos["right"])) {
    return;
  }
  _id_36E9BB1631D024F5 = self getmuzzlepos();
  dir = anglesToForward(self getmuzzleangle());
  _id_8BC14603A27FA3E7 = 10;

  if(isDefined(self.isrambo))
    _id_8BC14603A27FA3E7 = 20;

  _id_9C3A83531A8A275A = 0;

  if(isalive(self.enemy) && issentient(self.enemy) && self canshootenemy()) {
    _id_B3BCA3E7F11A1CCE = vectorNormalize(self.enemy getEye() - _id_36E9BB1631D024F5);

    if(vectordot(dir, _id_B3BCA3E7F11A1CCE) > cos(_id_8BC14603A27FA3E7))
      _id_9C3A83531A8A275A = 1;
  }

  if(_id_9C3A83531A8A275A)
    _id_2B79931B08683E0A::shootenemywrapper();
  else {
    dir = dir + ((randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1, (randomfloat(2) - 1) * 0.1);
    pos = _id_36E9BB1631D024F5 + dir * 1000;
    self[[anim.shootposwrapper_func]](pos);
  }

  scripts\asm\shared\utility::decrementbulletsinclip();
}

notetrackrefillclip(_id_A234A65C378F3289, flagname) {
  _id_76FF4BA096A6F8AA::refillclip();
}

_id_C7C1DD20323389C9(_id_A234A65C378F3289, flagname, _id_35CE7799B701C978) {
  player = level.players[_id_35CE7799B701C978[0]];

  if(_id_35CE7799B701C978.size == 3 && isDefined(player))
    player notify(_id_35CE7799B701C978[2]);
}

_id_A73998EF3B3ABDD4(_id_A234A65C378F3289, flagname, _id_35CE7799B701C978) {
  if(_id_35CE7799B701C978.size == 3) {
    params = strtok(_id_35CE7799B701C978[2], ",");

    if(params.size >= 1) {
      _id_F8A3B6E282B87E24 = params[0];
      _id_F67659AB5E885A58 = getEnt(_id_F8A3B6E282B87E24, "targetname");

      if(isDefined(_id_F67659AB5E885A58))
        _id_F67659AB5E885A58 delete();
    }
  }
}

getpreferredweapon() {
  if(isDefined(self.wantshotgun) && self.wantshotgun) {
    if(_id_2B79931B08683E0A::isshotgun(self.primaryweapon))
      return self.primaryweapon;
    else if(_id_2B79931B08683E0A::isshotgun(self.secondaryweapon))
      return self.secondaryweapon;
  }

  return self.primaryweapon;
}

notetrackguntochest(_id_A234A65C378F3289, flagname) {
  if(isDefined(self.fnplaceweaponon))
    self[[self.fnplaceweaponon]](self.weapon, "chest");
}

notetrackguntoback(_id_A234A65C378F3289, flagname) {
  if(isDefined(self.fnplaceweaponon))
    self[[self.fnplaceweaponon]](self.weapon, "back");

  self.weapon = getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

notetrackpistolpickup(_id_A234A65C378F3289, flagname) {
  _id_3701B823D5A1DD65 = "right";

  if(!isDefined(self.sidearm) || isnullweapon(self.sidearm) || self.weapon == self.sidearm && isDefined(self.a.weaponpos[_id_3701B823D5A1DD65]) && self.a.weaponpos[_id_3701B823D5A1DD65] == self.weapon) {
    return;
  }
  if(isDefined(self.fnplaceweaponon))
    self[[self.fnplaceweaponon]](self.sidearm, _id_3701B823D5A1DD65);

  self.bulletsinclip = weaponclipsize(self.weapon);
  self notify("weapon_switch_done");
}

notetrackpistolputaway(_id_A234A65C378F3289, flagname) {
  if(isDefined(self.fnplaceweaponon)) {
    if(isDefined(self.stowsidearmposition))
      self[[self.fnplaceweaponon]](self.sidearm, self.stowsidearmposition);
    else
      self[[self.fnplaceweaponon]](self.sidearm, "none");
  }

  self.weapon = getpreferredweapon();
  self.bulletsinclip = weaponclipsize(self.weapon);
}

notetrackguntoright(_id_A234A65C378F3289, flagname) {
  if(isDefined(self.fnplaceweaponon))
    self[[self.fnplaceweaponon]](self.weapon, "right");

  self.bulletsinclip = weaponclipsize(self.weapon);
}

_id_12E1635911FD2716(_id_A234A65C378F3289, flagname) {
  if(isDefined(self.fnplaceweaponon))
    self[[self.fnplaceweaponon]](self.weapon, "inhand");

  self.bulletsinclip = weaponclipsize(self.weapon);
}

notetrackhton0(_id_A234A65C378F3289, flagname) {
  if(!self isinscriptedstate())
    self enablestatelookat(1, 0);
}

notetrackhton1(_id_A234A65C378F3289, flagname) {
  if(!self isinscriptedstate())
    self enablestatelookat(1, 1);
}

notetrackhtoff(_id_A234A65C378F3289, flagname) {
  if(!self isinscriptedstate())
    self enablestatelookat(0);
}

_id_5A8F2C4BA78D7BFF(_id_A234A65C378F3289, flagname) {
  if(isai(self)) {
    self _meth_F51FF412609193B9(1, "script");
    self _meth_E99626ADD202FE1A(0, "script");

    if(scripts\common\utility::issp())
      self _meth_5621E511B99964A7(level.player);
  }
}

_id_AB37DA002EDDAF9F(_id_A234A65C378F3289, flagname) {
  if(isai(self)) {
    self _meth_F51FF412609193B9(1, "script");
    self _meth_E99626ADD202FE1A(0, "script");
    self _meth_504A5E2DF31069A4();
  }
}

_id_B67DF3617C4F2903(_id_A234A65C378F3289, flagname) {
  if(isai(self)) {
    self _meth_F51FF412609193B9(0, "script");
    self _meth_E99626ADD202FE1A(1, "script");
  }
}

_id_28B89C4EC5292326(_id_A234A65C378F3289, flagname) {
  if(isai(self))
    self asmfireevent(self.asmname, _id_A234A65C378F3289);
}

_id_1777A8463E80F52E(_id_A234A65C378F3289, flagname) {
  if(isDefined(self._id_9087E842F157D27C))
    return [[self._id_9087E842F157D27C]](_id_A234A65C378F3289, flagname);
}