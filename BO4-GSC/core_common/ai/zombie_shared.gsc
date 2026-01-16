/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: core_common\ai\zombie_shared.gsc
***********************************************/

#include scripts\core_common\sound_shared;

#namespace zombie_shared;

deleteatlimit() {
  wait 30;
  self delete();
}

lookatposition(looktargetpos, lookduration, lookspeed, eyesonly, interruptothers) {
  assert(isai(self), "<dev string:x38>");
  assert(self.a.targetlookinitilized == 1, "<dev string:x69>");
  assert(lookspeed == "<dev string:xa9>" || lookspeed == "<dev string:xb2>", "<dev string:xba>");

  if(!isDefined(interruptothers) || interruptothers == "interrupt others" || gettime() > self.a.lookendtime) {
    self.a.looktargetpos = looktargetpos;
    self.a.lookendtime = gettime() + lookduration * 1000;

    if(lookspeed == "casual") {
      self.a.looktargetspeed = 800;
    } else {
      self.a.looktargetspeed = 1600;
    }

    if(isDefined(eyesonly) && eyesonly == "eyes only") {
      self notify(#"eyes look now");
      return;
    }

    self notify(#"look now");
  }
}

lookatanimations(leftanim, rightanim) {
  self.a.lookanimationleft = leftanim;
  self.a.lookanimationright = rightanim;
}

handledogsoundnotetracks(note) {
  if(note == "sound_dogstep_run_default" || note == "dogstep_rf" || note == "dogstep_lf") {
    self playSound(#"fly_dog_step_run_default");
    return true;
  }

  prefix = getsubstr(note, 0, 5);

  if(prefix != "sound") {
    return false;
  }

  alias = "aml" + getsubstr(note, 5);

  if(isalive(self)) {
    self thread sound::play_on_tag(alias, "tag_eye");
  } else {
    self thread sound::play_in_space(alias, self gettagorigin("tag_eye"));
  }

  return true;
}

growling() {
  return isDefined(self.script_growl);
}

registernotetracks() {
  anim.notetracks[#"anim_pose = "
    stand ""] = &notetrackposestand;
  anim.notetracks[#"anim_pose = "
    crouch ""] = &notetrackposecrouch;
  anim.notetracks[#"anim_movement = "
    stop ""] = &notetrackmovementstop;
  anim.notetracks[#"anim_movement = "
    walk ""] = &notetrackmovementwalk;
  anim.notetracks[#"anim_movement = "
    run ""] = &notetrackmovementrun;
  anim.notetracks[#"anim_alertness = causal"] = &notetrackalertnesscasual;
  anim.notetracks[#"anim_alertness = alert"] = &notetrackalertnessalert;
  anim.notetracks[#"gravity on"] = &notetrackgravity;
  anim.notetracks[#"gravity off"] = &notetrackgravity;
  anim.notetracks[#"hash_3a65333187809d2e"] = &notetrackgravity;
  anim.notetracks[#"bodyfall large"] = &notetrackbodyfall;
  anim.notetracks[#"bodyfall small"] = &notetrackbodyfall;
  anim.notetracks[#"footstep"] = &notetrackfootstep;
  anim.notetracks[#"step"] = &notetrackfootstep;
  anim.notetracks[#"footstep_right_large"] = &notetrackfootstep;
  anim.notetracks[#"footstep_right_small"] = &notetrackfootstep;
  anim.notetracks[#"footstep_left_large"] = &notetrackfootstep;
  anim.notetracks[#"footstep_left_small"] = &notetrackfootstep;
  anim.notetracks[#"footscrape"] = &notetrackfootscrape;
  anim.notetracks[#"land"] = &notetrackland;
  anim.notetracks[#"start_ragdoll"] = &notetrackstartragdoll;
}

notetrackstopanim(note, flagname) {}

notetrackstartragdoll(note, flagname) {
  if(isDefined(self.noragdoll)) {
    return;
  }

  self unlink();
  self startragdoll();
}

notetrackmovementstop(note, flagname) {
  if(issentient(self)) {
    self.a.movement = "stop";
  }
}

notetrackmovementwalk(note, flagname) {
  if(issentient(self)) {
    self.a.movement = "walk";
  }
}

notetrackmovementrun(note, flagname) {
  if(issentient(self)) {
    self.a.movement = "run";
  }
}

notetrackalertnesscasual(note, flagname) {
  if(issentient(self)) {
    self.a.alertness = "casual";
  }
}

notetrackalertnessalert(note, flagname) {
  if(issentient(self)) {
    self.a.alertness = "alert";
  }
}

notetrackposestand(note, flagname) {
  self.a.pose = "stand";
  self notify("entered_pose" + "stand");
}

notetrackposecrouch(note, flagname) {
  self.a.pose = "crouch";
  self notify("entered_pose" + "crouch");

  if(self.a.crouchpain) {
    self.a.crouchpain = 0;
    self.health = 150;
  }
}

notetrackgravity(note, flagname) {
  if(issubstr(note, "on")) {
    self animmode("gravity");
    return;
  }

  if(issubstr(note, "off")) {
    self animmode("nogravity");
    self.nogravity = 1;
    return;
  }

  if(issubstr(note, "code")) {
    self animmode("none");
    self.nogravity = undefined;
  }
}

notetrackbodyfall(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "dirt";
  }

  if(issubstr(note, "large")) {
    self playSound(#"fly_bodyfall_large_" + groundtype);
    return;
  }

  if(issubstr(note, "small")) {
    self playSound(#"fly_bodyfall_small_" + groundtype);
  }
}

notetrackfootstep(note, flagname) {
  if(issubstr(note, "left")) {
    playfootstep("J_Ball_LE");
  } else {
    playfootstep("J_BALL_RI");
  }

  if(!level.clientscripts) {
    self playSound(#"fly_gear_run");
  }
}

notetrackfootscrape(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "dirt";
  }

  self playSound(#"fly_step_scrape_" + groundtype);
}

notetrackland(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "dirt";
  }

  self playSound(#"fly_land_npc_" + groundtype);
}

handlenotetrack(note, flagname, customfunction, var1) {
  if(isai(self) && isDefined(anim.notetracks)) {
    notetrackfunc = anim.notetracks[note];

    if(isDefined(notetrackfunc)) {
      return [
        [notetrackfunc]
      ](note, flagname);
    }
  }

  switch (note) {
    case #"undefined":
    case #"end":
    case #"finish":
      return note;
    case #"hash_701bc5c059dfaa52":
      self thread sound::play_in_space("fly_gear_enemy", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case #"hash_5f5e275b9f3b93ee":
      self thread sound::play_in_space("fly_gear_enemy_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    case #"no death":
      self.a.nodeath = 1;
      break;
    case #"no pain":
      self.allowpain = 0;
      break;
    case #"hash_50c6c08f5de3ec2a":
      self.allowpain = 1;
      break;
    case #"anim_melee = right":
    case #"hash_39ec7b0969bab796":
      self.a.meleestate = "right";
      break;
    case #"anim_melee = left":
    case #"hash_6b554a9080ec8b07":
      self.a.meleestate = "left";
      break;
    case #"swap taghelmet to tagleft":
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
    default:
      if(isDefined(customfunction)) {
        if(!isDefined(var1)) {
          return [
            [customfunction]
          ](note);
        } else {
          return [
            [customfunction]
          ](note, var1);
        }
      }

      break;
  }
}

donotetracks(flagname, customfunction, var1) {
  for(;;) {
    waitresult = self waittill(flagname);
    note = waitresult.notetrack;

    if(!isDefined(note)) {
      note = "undefined";
    }

    val = self handlenotetrack(note, flagname, customfunction, var1);

    if(isDefined(val)) {
      return val;
    }
  }
}

donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, var1) {
  if(isDefined(killstring)) {
    self endon(killstring, #"killanimscript");
  }

  for(;;) {
    time = gettime();
    returnednote = [[notetracksfunc]](flagname, customfunction, var1);
    timetaken = gettime() - time;

    if(timetaken < 0.05) {
      time = gettime();
      returnednote = [
        [notetracksfunc]
      ](flagname, customfunction, var1);
      timetaken = gettime() - time;

      if(timetaken < 0.05) {
        println(gettime() + "<dev string:xde>" + flagname + "<dev string:x12d>" + returnednote + "<dev string:x13b>");
        wait 0.05 - timetaken;
      }
    }
  }
}

donotetracksforever(flagname, killstring, customfunction, var1) {
  donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, var1);
}

donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, ent, var1) {
  ent endon(#"stop_notetracks");
  [[donotetracksforeverfunc]](flagname, undefined, customfunction, var1);
}

donotetracksfortime(time, flagname, customfunction, var1) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, ent, var1);
}

donotetracksfortimeendnotify(time) {
  wait time;
  self notify(#"stop_notetracks");
}

playfootstep(foot) {
  if(!level.clientscripts) {
    if(!isai(self)) {
      self playSound(#"fly_step_run_dirt");
      return;
    }
  }

  groundtype = undefined;

  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      if(!level.clientscripts) {
        self playSound(#"fly_step_run_dirt");
      }

      return;
    }

    groundtype = self.lastgroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }

  if(!level.clientscripts) {
    self playSound(#"fly_step_run_" + groundtype);
  }

  [[anim.optionalstepeffectfunction]](foot, groundtype);
}

playfootstepeffect(foot, groundtype) {
  if(level.clientscripts) {
    return;
  }

  for(i = 0; i < anim.optionalstepeffects.size; i++) {
    if(isDefined(self.fire_footsteps) && self.fire_footsteps) {
      groundtype = "fire";
    }

    if(groundtype != anim.optionalstepeffects[i]) {
      continue;
    }

    org = self gettagorigin(foot);
    playFX(level._effect["step_" + anim.optionalstepeffects[i]], org, org + (0, 0, 100));
    return;
  }
}

movetooriginovertime(origin, time) {
  self endon(#"killanimscript");

  if(distancesquared(self.origin, origin) > 256 && !self maymovetopoint(origin)) {
    println("<dev string:x13f>" + origin + "<dev string:x16e>");
    return;
  }

  self.keepclaimednodeingoal = 1;
  offset = self.origin - origin;
  frames = int(time * 20);
  offsetreduction = vectorscale(offset, 1 / frames);

  for(i = 0; i < frames; i++) {
    offset -= offsetreduction;
    self teleport(origin + offset);
    waitframe(1);
  }

  self.keepclaimednodeingoal = 0;
}

returntrue() {
  return true;
}

setanimaimweight(goalweight, goaltime) {
  if(!isDefined(goaltime) || goaltime <= 0) {
    self.a.aimweight = goalweight;
    self.a.aimweight_start = goalweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = 0;
  } else {
    self.a.aimweight = goalweight;
    self.a.aimweight_start = self.a.aimweight;
    self.a.aimweight_end = goalweight;
    self.a.aimweight_transframes = int(goaltime * 20);
  }

  self.a.aimweight_t = 0;
}

incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    t = 1 * self.a.aimweight_t / self.a.aimweight_transframes;
    self.a.aimweight = self.a.aimweight_start * (1 - t) + self.a.aimweight_end * t;
  }
}