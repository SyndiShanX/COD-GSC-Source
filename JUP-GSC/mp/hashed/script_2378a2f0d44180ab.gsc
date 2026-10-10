/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2378a2f0d44180ab.gsc
*************************************************/

#using script_39ae84cf3eeebf70;
#using script_3ed005fe9b78b9da;
#using scripts\common\values;
#using scripts\engine\utility;
#using scripts\mp\hud_util;
#using scripts\mp\utility\player;
#namespace namespace_453c1f3aa94ee884;

function function_7a154baa848107ab() {
  cooldowntime = getdvarfloat(@ "hash_8b44cc18eb0e9546", 7);
  addpowerbutton(self, "jump", ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"], &playerzombiejump, 0, undefined, &function_7633afe8652b68b7, undefined, &"MP_ZXP/CHARGED_JUMP", undefined, cooldowntime, "jumpStatus", "jumpProgress");
  addpowerbutton(self, "jumpStop", ["-speed_throw", "-toggleads_throw", "-ads_akimbo_accessible"], &playerzombiejumpstop, 0);
}

function playerzombiejump(powerstruct, powerref) {
  if(!isDefined(self)) {
    return;
  }

  level endon("game_ended");
  self endon("death_or_disconnect");
  self endon("zombie_unset");
  self endon("playerZombieJumpStop");
  var_4ca6e232b3a08ae5 = -1;
  self.var_ee75699e65f68166 = undefined;
  var_e8b1539c9f6ccbc1 = getdvarfloat(@ "hash_2fc6c2dc7f9c722a", 1);
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", 0.25);
  var_6b00aa3867c7f0d9 = getdvarint(@ "hash_69111e35067f9d8f", var_4ca6e232b3a08ae5);
  var_57bd73d0ecaee169 = var_e8b1539c9f6ccbc1 * level.framedurationseconds;
  self.var_17c60a92aea65107 = 0;
  self allowmelee(0);
  self disableoffhandweapons();
  var_715d7709363e068c = undefined;
  progress = 0;

  if(!isDefined(self.var_741cb4edf0f0590c) || gettime() > self.var_741cb4edf0f0590c) {
    self playlocalsound("zxp_charge_jump_start");
    self playlocalsound("ai_radioactive_beast_charge_press");
    self.var_741cb4edf0f0590c = gettime() + 500;
  }

  if(isDefined(powerstruct.powers[powerref].statusupdate)) {
    function_936f0ef6e203a7fc(powerstruct.powers[powerref].statusupdate, 0);
  }

  while(!function_77bab0532bc12f0e()) {
    if(level.var_ec4da42b3bbf344c.hudserver) {
      self.powershud[powerref].barelem updatebar(self.var_17c60a92aea65107, 0);
    } else {
      self.powershud[powerref].frac = self.var_17c60a92aea65107;
    }

    prevfrac = self.var_17c60a92aea65107;
    self.var_17c60a92aea65107 += var_57bd73d0ecaee169;

    if(self.var_17c60a92aea65107 >= 1) {
      self.var_17c60a92aea65107 = 1;

      if(var_6b00aa3867c7f0d9 >= 0) {
        if(!isDefined(var_715d7709363e068c)) {
          var_715d7709363e068c = gettime() + var_6b00aa3867c7f0d9 * 1000;
        }

        if(gettime() >= var_715d7709363e068c) {
          break;
        }
      }
    }

    if(level.var_ec4da42b3bbf344c.hudserver && prevfrac < var_eec1ca5327266614 && self.var_17c60a92aea65107 >= var_eec1ca5327266614) {
      self.powershud[powerref].barelem.bar.color = (0, 1, 0);
    }

    if(prevfrac < 1 && self.var_17c60a92aea65107 >= 1) {
      self playlocalsound("zxp_charge_jump_full");
    }

    if(isDefined(powerstruct.powers[powerref].progressupdate)) {
      progress = max(int(self.var_17c60a92aea65107 * 100), 0);
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, progress);
    }

    waitframe();
  }

  thread function_a1b195bc24dae315(powerstruct, powerref);
}

function function_a1b195bc24dae315(powerstruct, powerref) {
  self notify("playerZombieJumpChargeEnd");
  self notify("playerZombieJumpStop");
  var_eec1ca5327266614 = getdvarfloat(@ "hash_f3adfe2ba0c4e72e", 0.25);
  var_e5482b00771c4909 = getdvarint(@ "hash_2a5201ccbcd3b1a1", 1);
  var_b13a0e71ef0de57c = 1;

  if(self.var_17c60a92aea65107 >= var_eec1ca5327266614 && !function_77bab0532bc12f0e() && function_d4e7d5bfedb0b977() && !self ismantling()) {
    maxjumpvelocity = getdvarfloat(@ "hash_fd6822a1c2607510", 1300);
    player_angles = self getplayerangles();

    if(isDefined(self.var_ae387c36d115328f)) {
      self unlink();
      self.var_ae387c36d115328f delete();
    }

    commands = ["+speed_throw", "+toggleads_throw", "+ads_akimbo_accessible"];

    foreach(command in commands) {
      if(!isbot(self)) {
        self notifyonplayercommand("cancel_dog_charge", command);
      }
    }

    if(getdvarint(@ "hash_448f23d737dbbc82", 0) == 1) {
      ent = spawn_tag_origin();
      ent.origin += (0, 0, 8);
      ent setModel("tag_player");
      ent show();
    } else {
      ent = spawn("script_model", self.origin + (0, 0, 8));
      ent setModel("tag_origin");
      ent.angles = flat_angle(self.angles);
    }

    self.var_286fe84c87d28222 = 1;
    thread function_108f1dde77a667ca(ent);
    self playsoundonmovingent("ai_radioactive_beast_charge_activate");
    self playlocalsound("ai_radioactive_beast_charge_activate_swt");
    self.var_ae387c36d115328f = ent;
    thread function_cf242179be5fca8b(ent);
    self.var_f07121951ba8e9a5 = undefined;
    self.var_741cb4edf0f0590c = undefined;
  } else {
    if(var_e5482b00771c4909) {
      if(level.var_ec4da42b3bbf344c.hudserver) {
        self.powershud[powerref].barelem.bar.frac = 0;
      } else {
        self.powershud[powerref].frac = 0;
      }

      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 0);
      self enableoffhandweapons();
      self allowmelee(1);
      self notify("endSuperJumpFov");
    }

    function_e63114420500fb();
    thread function_f2ddb7c78178c1be(powerstruct, powerref);

    if(istrue(self.var_e11136acf00d18f)) {
      function_936f0ef6e203a7fc(powerstruct.powers[powerref].progressupdate, 100);
      var_b13a0e71ef0de57c = 0;
    }
  }

  function_7633afe8652b68b7(powerstruct, powerref, var_b13a0e71ef0de57c);
}

function function_108f1dde77a667ca(ent) {
  player = self;
  player endon("dogChargeHit");
  player endon("cancel_dog_charge");

  if(getdvarint(@ "hash_448f23d737dbbc82", 0) == 1) {
    player playerlinkTo(ent, "tag_player");
  } else {
    player playerlinktodelta(ent, "tag_origin");
  }

  weapon = makeweapon("iw9_me_fists_mp_zmb_dog_charge");
  player giveweapon(weapon);
  player switchtoweapon(weapon);
}

function playerzombiejumpstop(powerstruct, powerref) {
  level endon("game_ended");
  self endon("death_or_disconnect");
  waittillframeend();

  if(isDefined(self.var_17c60a92aea65107)) {
    function_a1b195bc24dae315(powerstruct, "jump");
    return;
  }

  self notify("playerZombieJumpStop");
}

function function_cf242179be5fca8b(ent) {
  self endon("death_or_disconnect");
  vector = vectorNormalize(anglesToForward(flat_angle(self getplayerangles())));
  time = gettime();
  val::set("hellhound_slide", "freezecontrols_allowlook", 1);
  slidevelocity = 512 * vector;

  if(getdvarint(@ "hash_448f23d737dbbc82", 0) == 1) {
    ent moveslide((0, 0, 8), 8, slidevelocity);
  } else {
    thread moveforward(ent, slidevelocity);
  }

  thread function_78d3415066a09a6d(slidevelocity);
  thread function_cdbd950d4125f7c2();
  var_7a1d99bd229ce3b6 = 4 * self.var_17c60a92aea65107;
  msg = waittill_any_timeout_2(var_7a1d99bd229ce3b6, "dogChargeHit", "cancel_dog_charge");

  if(getdvarint(@ "hash_448f23d737dbbc82", 0) == 0) {
    self setOrigin(getclosestpointonnavmesh(self.origin), 0);
  }

  self.var_286fe84c87d28222 = undefined;

  if(!is_equal(msg, "timeout") && !is_equal(msg, "cancel_dog_charge")) {
    gren = magicgrenademanual("jup_mutant_dog_charge_impact_mp", self getEye() + (0, 0, 9), (0, 0, 0));
    gren detonate(self);
    self stopanimscriptsceneevent();
    self playanimscriptsceneevent("scripted_scene", level.scr_eventanim["dog_charge"]["hellhound_hit_wall"]);
    delaycall(0.2, &stopanimscriptsceneevent);
  } else {
    self stopanimscriptsceneevent();
  }

  weapon = makeweapon("iw9_me_fists_mp_zmb_dog_charge");
  self takeweapon("iw9_me_fists_mp_zmb_dog_charge");
  self switchtoweapon("iw9_me_fists_mp_zmb_dog");
  ent delete();
  val::set("hellhound_slide", "freezecontrols_allowlook", 0);
  self allowmelee(1);
  self unlink();
}

function moveforward(ent, velocity) {
  self endon("dogChargeHit");
  self endon("cancel_dog_charge");
  self endon("timeout");
  ent endon("entitydeleted");
  fwd = vectorNormalize(velocity);
  speed = 512;
  steer_speed = 20;
  step = 0.1;
  speed *= step;
  steer_speed *= step;

  if(isdedicatedserver()) {
    speed *= 1.3;
    steer_speed *= 1.3;
  }

  angle = self.angles;

  while(isDefined(ent)) {
    movementinput = self getnormalizedmovement();
    angle = (angle[0], angle[1] + -1 * steer_speed * movementinput[1], angle[2]);
    fwd = vectorNormalize(anglesToForward(angle));
    nextorigin = ent.origin + speed * fwd;
    z = getclosestpointonnavmesh(nextorigin)[2];
    nextorigin = (nextorigin[0], nextorigin[1], z);

    if(self ishost()) {
      iprintlnbold(angle[1]);
    }

    ent.angles = angle;
    ent moveTo(nextorigin, step);
    wait step;
  }
}

function function_78d3415066a09a6d(slidevelocity) {
  self endon("death");
  self endon("dogChargeHit");
  self endon("cancel_dog_charge");
  self endon("disconnected");
  lastorigin = function_b554cef949602d76();
  starttime = gettime();
  var_134d0390a5b98256 = getdvarint(@ "hash_3e0b76e7c8bbae22");
  lerpduration = getdvarfloat(@ "hash_178470c11f7062cd") * 1000;
  collisioncontents = physics_createcontents(["physicscontents_clipshot", "physicscontents_missileclip", "physicscontents_glass", "physicscontents_vehicle"]);
  raycastend = function_cfb9ea9d9d3f7873();
  starttime = gettime();

  while(isDefined(self.var_ae387c36d115328f)) {
    timepassed = gettime() - starttime;
    lerpfraction = timepassed / lerpduration;

    if(getdvarint(@ "hash_448f23d737dbbc82", 0) == 1) {
      movementinput = self getnormalizedmovement();
      velocity_right = 100 * movementinput[1] * vectorNormalize(anglestoright(self.var_ae387c36d115328f.angles));
      self.var_ae387c36d115328f.slidevelocity = (slidevelocity[0] + movementinput[0], slidevelocity[1], self.var_ae387c36d115328f.slidevelocity[2]);
      self.var_ae387c36d115328f.slidevelocity += velocity_right;
    }

    sphere(self.var_ae387c36d115328f.origin, 16, (1, 1, 1), 0, 1);

    hitents = physics_raycast(lastorigin, raycastend, collisioncontents, self, 0, "physicsquery_all");

    if(hitents.size >= 1) {
      params = spawnStruct();
      params.hitents = hitents;
      break;
    }

    line(lastorigin, function_cfb9ea9d9d3f7873(), (1, 1, 1), 1, 0, 1);

    lastorigin = function_b554cef949602d76();
    raycastend = function_cfb9ea9d9d3f7873();
    waitframe();
  }

  if(gettime() == starttime) {
    waitframe();
    self notify("cancel_dog_charge");
    return;
  }

  self notify("dogChargeHit");
}

function function_b554cef949602d76() {
  return self getEye() + (0, 0, -12);
}

function function_cdbd950d4125f7c2() {
  self endon("death");
  self endon("dogChargeHit");
  self endon("cancel_dog_charge");
  self endon("disconnected");
  self.playertrigger = spawn("trigger_radius", self getEye(), 0, 16, 16);
  self.playertrigger enablelinkTo();
  self.playertrigger linkTo(self);

  while(true) {
    self.playertrigger waittill("trigger", hitent);

    if(is_equal(self, hitent)) {
      continue;
    }

    break;
  }

  self notify("dogChargeHit");
}

function function_cfb9ea9d9d3f7873() {
  raycastdistance = 32;
  direction = vectorNormalize(anglesToForward(self.angles));
  return function_b554cef949602d76() + direction * raycastdistance;
}

function function_7633afe8652b68b7(powerstruct, powerref, docooldown) {
  if(istrue(docooldown)) {
    thread playerpowerstartcooldown(powerstruct, powerref);
  }

  self enableoffhandweapons();
  self.var_e11136acf00d18f = undefined;
  self.var_17c60a92aea65107 = undefined;
  self.var_286fe84c87d28222 = undefined;
}