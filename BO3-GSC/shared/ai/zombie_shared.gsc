/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\zombie_shared.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\math_shared;
#using scripts\shared\sound_shared;
#namespace zombie_shared;

function deleteatlimit() {
  wait(30);
  self delete();
}

function lookatentity(looktargetentity, lookduration, lookspeed, eyesonly, interruptothers) {}

function lookatposition(looktargetpos, lookduration, lookspeed, eyesonly, interruptothers) {
  assert(isai(self), "");
  assert(self.a.targetlookinitilized == 1, "");
  assert(lookspeed == "" || lookspeed == "", "");
  if(!isDefined(interruptothers) || interruptothers == "interrupt others" || gettime() > self.a.lookendtime) {
    self.a.looktargetpos = looktargetpos;
    self.a.lookendtime = gettime() + (lookduration * 1000);
    if(lookspeed == "casual") {
      self.a.looktargetspeed = 800;
    } else {
      self.a.looktargetspeed = 1600;
    }
    if(isDefined(eyesonly) && eyesonly == "eyes only") {
      self notify("hash_c1896d90");
    } else {
      self notify("hash_9a1a418c");
    }
  }
}

function lookatanimations(leftanim, rightanim) {
  self.a.lookanimationleft = leftanim;
  self.a.lookanimationright = rightanim;
}

function handledogsoundnotetracks(note) {
  if(note == "sound_dogstep_run_default" || note == "dogstep_rf" || note == "dogstep_lf") {
    self playSound("fly_dog_step_run_default");
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

function growling() {
  return isDefined(self.script_growl);
}

function registernotetracks() {
  anim.notetracks["anim_pose = \"stand\""] = &notetrackposestand;
  anim.notetracks["anim_pose = \"crouch\""] = &notetrackposecrouch;
  anim.notetracks["anim_movement = \"stop\""] = &notetrackmovementstop;
  anim.notetracks["anim_movement = \"walk\""] = &notetrackmovementwalk;
  anim.notetracks["anim_movement = \"run\""] = &notetrackmovementrun;
  anim.notetracks["anim_alertness = causal"] = &notetrackalertnesscasual;
  anim.notetracks["anim_alertness = alert"] = &notetrackalertnessalert;
  anim.notetracks["gravity on"] = &notetrackgravity;
  anim.notetracks["gravity off"] = &notetrackgravity;
  anim.notetracks["gravity code"] = &notetrackgravity;
  anim.notetracks["bodyfall large"] = &notetrackbodyfall;
  anim.notetracks["bodyfall small"] = &notetrackbodyfall;
  anim.notetracks["footstep"] = &notetrackfootstep;
  anim.notetracks["step"] = &notetrackfootstep;
  anim.notetracks["footstep_right_large"] = &notetrackfootstep;
  anim.notetracks["footstep_right_small"] = &notetrackfootstep;
  anim.notetracks["footstep_left_large"] = &notetrackfootstep;
  anim.notetracks["footstep_left_small"] = &notetrackfootstep;
  anim.notetracks["footscrape"] = &notetrackfootscrape;
  anim.notetracks["land"] = &notetrackland;
  anim.notetracks["start_ragdoll"] = &notetrackstartragdoll;
}

function notetrackstopanim(note, flagname) {}

function notetrackstartragdoll(note, flagname) {
  if(isDefined(self.noragdoll)) {
    return;
  }
  self unlink();
  self startragdoll();
}

function notetrackmovementstop(note, flagname) {
  if(issentient(self)) {
    self.a.movement = "stop";
  }
}

function notetrackmovementwalk(note, flagname) {
  if(issentient(self)) {
    self.a.movement = "walk";
  }
}

function notetrackmovementrun(note, flagname) {
  if(issentient(self)) {
    self.a.movement = "run";
  }
}

function notetrackalertnesscasual(note, flagname) {
  if(issentient(self)) {
    self.a.alertness = "casual";
  }
}

function notetrackalertnessalert(note, flagname) {
  if(issentient(self)) {
    self.a.alertness = "alert";
  }
}

function notetrackposestand(note, flagname) {
  self.a.pose = "stand";
  self notify("entered_pose" + "stand");
}

function notetrackposecrouch(note, flagname) {
  self.a.pose = "crouch";
  self notify("entered_pose" + "crouch");
  if(self.a.crouchpain) {
    self.a.crouchpain = 0;
    self.health = 150;
  }
}

function notetrackgravity(note, flagname) {
  if(issubstr(note, "on")) {
    self animmode("gravity");
  } else {
    if(issubstr(note, "off")) {
      self animmode("nogravity");
      self.nogravity = 1;
    } else if(issubstr(note, "code")) {
      self animmode("none");
      self.nogravity = undefined;
    }
  }
}

function notetrackbodyfall(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "dirt";
  }
  if(issubstr(note, "large")) {
    self playSound("fly_bodyfall_large_" + groundtype);
  } else if(issubstr(note, "small")) {
    self playSound("fly_bodyfall_small_" + groundtype);
  }
}

function notetrackfootstep(note, flagname) {
  if(issubstr(note, "left")) {
    playfootstep("J_Ball_LE");
  } else {
    playfootstep("J_BALL_RI");
  }
  if(!level.clientscripts) {
    self playSound("fly_gear_run");
  }
}

function notetrackfootscrape(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "dirt";
  }
  self playSound("fly_step_scrape_" + groundtype);
}

function notetrackland(note, flagname) {
  if(isDefined(self.groundtype)) {
    groundtype = self.groundtype;
  } else {
    groundtype = "dirt";
  }
  self playSound("fly_land_npc_" + groundtype);
}

function handlenotetrack(note, flagname, customfunction, var1) {
  if(isai(self) && isDefined(anim.notetracks)) {
    notetrackfunc = anim.notetracks[note];
    if(isDefined(notetrackfunc)) {
      return [[notetrackfunc]](note, flagname);
    }
  }
  switch (note) {
    case "end":
    case "finish":
    case "undefined": {
      return note;
    }
    case "swish small": {
      self thread sound::play_in_space("fly_gear_enemy", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    }
    case "swish large": {
      self thread sound::play_in_space("fly_gear_enemy_large", self gettagorigin("TAG_WEAPON_RIGHT"));
      break;
    }
    case "no death": {
      self.a.nodeath = 1;
      break;
    }
    case "no pain": {
      self.allowpain = 0;
      break;
    }
    case "allow pain": {
      self.allowpain = 1;
      break;
    }
    case "anim_melee = \"right\"":
    case "anim_melee = right": {
      self.a.meleestate = "right";
      break;
    }
    case "anim_melee = \"left\"":
    case "anim_melee = left": {
      self.a.meleestate = "left";
      break;
    }
    case "swap taghelmet to tagleft": {
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
    }
    default: {
      if(isDefined(customfunction)) {
        if(!isDefined(var1)) {
          return [[customfunction]](note);
        } else {
          return [[customfunction]](note, var1);
        }
      }
      break;
    }
  }
}

function donotetracks(flagname, customfunction, var1) {
  for(;;) {
    self waittill(flagname, note);
    if(!isDefined(note)) {
      note = "undefined";
    }
    val = self handlenotetrack(note, flagname, customfunction, var1);
    if(isDefined(val)) {
      return val;
    }
  }
}

function donotetracksforeverproc(notetracksfunc, flagname, killstring, customfunction, var1) {
  if(isDefined(killstring)) {
    self endon(killstring);
  }
  self endon("killanimscript");
  for(;;) {
    time = gettime();
    returnednote = [[notetracksfunc]](flagname, customfunction, var1);
    timetaken = gettime() - time;
    if(timetaken < 0.05) {
      time = gettime();
      returnednote = [[notetracksfunc]](flagname, customfunction, var1);
      timetaken = gettime() - time;
      if(timetaken < 0.05) {
        println(((((gettime() + "") + flagname) + "") + returnednote) + "");
        wait(0.05 - timetaken);
      }
    }
  }
}

function donotetracksforever(flagname, killstring, customfunction, var1) {
  donotetracksforeverproc(&donotetracks, flagname, killstring, customfunction, var1);
}

function donotetracksfortimeproc(donotetracksforeverfunc, time, flagname, customfunction, ent, var1) {
  ent endon("stop_notetracks");
  [[donotetracksforeverfunc]](flagname, undefined, customfunction, var1);
}

function donotetracksfortime(time, flagname, customfunction, var1) {
  ent = spawnStruct();
  ent thread donotetracksfortimeendnotify(time);
  donotetracksfortimeproc(&donotetracksforever, time, flagname, customfunction, ent, var1);
}

function donotetracksfortimeendnotify(time) {
  wait(time);
  self notify("stop_notetracks");
}

function playfootstep(foot) {
  if(!level.clientscripts) {
    if(!isai(self)) {
      self playSound("fly_step_run_dirt");
      return;
    }
  }
  groundtype = undefined;
  if(!isDefined(self.groundtype)) {
    if(!isDefined(self.lastgroundtype)) {
      if(!level.clientscripts) {
        self playSound("fly_step_run_dirt");
      }
      return;
    }
    groundtype = self.lastgroundtype;
  } else {
    groundtype = self.groundtype;
    self.lastgroundtype = self.groundtype;
  }
  if(!level.clientscripts) {
    self playSound("fly_step_run_" + groundtype);
  }
  [[anim.optionalstepeffectfunction]](foot, groundtype);
}

function playfootstepeffect(foot, groundtype) {
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
    playFX(level._effect["step_" + anim.optionalstepeffects[i]], org, org + vectorscale((0, 0, 1), 100));
    return;
  }
}

function movetooriginovertime(origin, time) {
  self endon("killanimscript");
  if(distancesquared(self.origin, origin) > 256 && !self maymovetopoint(origin)) {
    println(("" + origin) + "");
    return;
  }
  self.keepclaimednodeingoal = 1;
  offset = self.origin - origin;
  frames = int(time * 20);
  offsetreduction = vectorscale(offset, 1 / frames);
  for(i = 0; i < frames; i++) {
    offset = offset - offsetreduction;
    self teleport(origin + offset);
    wait(0.05);
  }
  self.keepclaimednodeingoal = 0;
}

function returntrue() {
  return true;
}

function trackloop() {
  players = getplayers();
  deltachangeperframe = 5;
  aimblendtime = 0.05;
  prevyawdelta = 0;
  prevpitchdelta = 0;
  maxyawdeltachange = 5;
  maxpitchdeltachange = 5;
  pitchadd = 0;
  yawadd = 0;
  if(self.type == "dog" || self.type == "zombie" || self.type == "zombie_dog") {
    domaxanglecheck = 0;
    self.shootent = self.enemy;
  } else {
    domaxanglecheck = 1;
    if(self.a.script == "cover_crouch" && isDefined(self.a.covermode) && self.a.covermode == "lean") {
      pitchadd = -1 * anim.covercrouchleanpitch;
    }
    if(self.a.script == "cover_left" || self.a.script == "cover_right" && isDefined(self.a.cornermode) && self.a.cornermode == "lean") {
      yawadd = self.covernode.angles[1] - self.angles[1];
    }
  }
  yawdelta = 0;
  pitchdelta = 0;
  firstframe = 1;
  for(;;) {
    incranimaimweight();
    selfshootatpos = (self.origin[0], self.origin[1], self getEye()[2]);
    shootpos = undefined;
    if(isDefined(self.enemy)) {
      shootpos = self.enemy getshootatpos();
    }
    if(!isDefined(shootpos)) {
      yawdelta = 0;
      pitchdelta = 0;
    } else {
      vectortoshootpos = shootpos - selfshootatpos;
      anglestoshootpos = vectortoangles(vectortoshootpos);
      pitchdelta = 360 - anglestoshootpos[0];
      pitchdelta = angleclamp180(pitchdelta + pitchadd);
      yawdelta = self.angles[1] - anglestoshootpos[1];
      yawdelta = angleclamp180(yawdelta + yawadd);
    }
    if(domaxanglecheck && (abs(yawdelta) > 60 || abs(pitchdelta) > 60)) {
      yawdelta = 0;
      pitchdelta = 0;
    } else {
      if(yawdelta > self.rightaimlimit) {
        yawdelta = self.rightaimlimit;
      } else if(yawdelta < self.leftaimlimit) {
        yawdelta = self.leftaimlimit;
      }
      if(pitchdelta > self.upaimlimit) {
        pitchdelta = self.upaimlimit;
      } else if(pitchdelta < self.downaimlimit) {
        pitchdelta = self.downaimlimit;
      }
    }
    if(firstframe) {
      firstframe = 0;
    } else {
      yawdeltachange = yawdelta - prevyawdelta;
      if(abs(yawdeltachange) > maxyawdeltachange) {
        yawdelta = prevyawdelta + (maxyawdeltachange * math::sign(yawdeltachange));
      }
      pitchdeltachange = pitchdelta - prevpitchdelta;
      if(abs(pitchdeltachange) > maxpitchdeltachange) {
        pitchdelta = prevpitchdelta + (maxpitchdeltachange * math::sign(pitchdeltachange));
      }
    }
    prevyawdelta = yawdelta;
    prevpitchdelta = pitchdelta;
    updown = 0;
    leftright = 0;
    if(yawdelta > 0) {
      assert(yawdelta <= self.rightaimlimit);
      weight = (yawdelta / self.rightaimlimit) * self.a.aimweight;
      leftright = weight;
    } else if(yawdelta < 0) {
      assert(yawdelta >= self.leftaimlimit);
      weight = (yawdelta / self.leftaimlimit) * self.a.aimweight;
      leftright = -1 * weight;
    }
    if(pitchdelta > 0) {
      assert(pitchdelta <= self.upaimlimit);
      weight = (pitchdelta / self.upaimlimit) * self.a.aimweight;
      updown = weight;
    } else if(pitchdelta < 0) {
      assert(pitchdelta >= self.downaimlimit);
      weight = (pitchdelta / self.downaimlimit) * self.a.aimweight;
      updown = -1 * weight;
    }
    wait(0.05);
  }
}

function setanimaimweight(goalweight, goaltime) {
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

function incranimaimweight() {
  if(self.a.aimweight_t < self.a.aimweight_transframes) {
    self.a.aimweight_t++;
    t = (1 * self.a.aimweight_t) / self.a.aimweight_transframes;
    self.a.aimweight = (self.a.aimweight_start * (1 - t)) + (self.a.aimweight_end * t);
  }
}