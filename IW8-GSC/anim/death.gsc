/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\death.gsc
***********************************************/

init_animset_death() {}

init_deathfx() {
  scripts\engine\utility::add_fx("deathfx_bloodpool_generic", "vfx/iw8/char/blood/vfx_deathfx_bloodpool_01.vfx");
}

main() {
  self endon("killanimscript");
  self waittill("hellfreezesover");
}

doimmediateragdolldeath() {
  scripts\anim\shared.gsc::dropallaiweapons();
  self.skipdeathanim = 1;
  var_0 = 10;
  var_1 = scripts\common\utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && var_1 == "melee")
    var_0 = 5;

  var_2 = self.damagetaken;

  if(var_1 == "bullet")
    var_2 = max(var_2, 300);

  var_3 = var_0 * var_2;
  var_4 = max(0.3, self.damagedir[2]);
  var_5 = (self.damagedir[0], self.damagedir[1], var_4);

  if(isDefined(self.ragdoll_directionscale))
    var_5 = var_5 * self.ragdoll_directionscale;
  else
    var_5 = var_5 * var_3;

  if(self.forceragdollimmediate)
    var_5 = var_5 + self.prevanimdelta * 20 * 10;

  if(isDefined(self.ragdoll_start_vel))
    var_5 = var_5 + self.ragdoll_start_vel * 10;

  self startragdollfromimpact(self.damagelocation, var_5);
  wait 0.05;
}

cross2d(var_0, var_1) {
  return var_0[0] * var_1[1] - var_1[0] * var_0[1];
}

meleegetattackercardinaldirection(var_0, var_1) {
  var_2 = vectordot(var_1, var_0);
  var_3 = cos(60);

  if(squared(var_2) < squared(var_3)) {
    if(cross2d(var_0, var_1) > 0)
      return 1;
    else
      return 3;
  } else if(var_2 < 0)
    return 0;
  else
    return 2;
}

orientmeleevictim() {
  if(self.damagemod == "MOD_MELEE" && isDefined(self.attacker)) {
    var_0 = self.origin - self.attacker.origin;
    var_1 = anglesToForward(self.angles);
    var_2 = vectorNormalize((var_0[0], var_0[1], 0));
    var_3 = vectorNormalize((var_1[0], var_1[1], 0));
    var_4 = meleegetattackercardinaldirection(var_3, var_2);
    var_5 = var_4 * 90;
    var_6 = (-1 * var_2[0], -1 * var_2[1], 0);
    var_7 = rotatevector(var_6, (0, var_5, 0));
    var_8 = vectortoyaw(var_7);
    self orientmode("face angle", var_8);
  }
}

#using_animtree("generic_human");

playdeathanim(var_0) {
  if(!animhasnotetrack(var_0, "dropgun") && !animhasnotetrack(var_0, "fire_spray"))
    scripts\anim\shared.gsc::dropallaiweapons();

  orientmeleevictim();
  self setflaggedanimknoballrestart("deathanim", var_0, %body, 1, 0.1);
  scripts\anim\face.gsc::playfacialanim(var_0, "death");

  if(isDefined(self.skipdeathanim)) {
    if(!isDefined(self.noragdoll))
      self startragdoll();

    wait 0.05;
    self animmode("gravity");
  } else if(isDefined(self.ragdolltime))
    thread waitforragdoll(self.ragdolltime);
  else if(!animhasnotetrack(var_0, "start_ragdoll")) {
    if(self.damagemod == "MOD_MELEE")
      var_1 = 0.7;
    else
      var_1 = 0.35;

    thread waitforragdoll(getanimlength(var_0) * var_1);
  }

  if(!isDefined(self.skipdeathanim))
    thread playdeathfx();

  scripts\anim\notetracks.gsc::donotetracks("deathanim");
  scripts\anim\shared.gsc::dropallaiweapons();
  self notify("endPlayDeathAnim");
}

waitforragdoll(var_0) {
  wait(var_0);

  if(isDefined(self))
    scripts\anim\shared.gsc::dropallaiweapons();

  if(isDefined(self) && !isDefined(self.noragdoll))
    self startragdoll();
}

playdeathfx() {
  self endon("killanimscript");

  if(self.stairsstate != "none") {
    return;
  }
  wait 2;

  if(isDefined(self.noragdoll))
    play_blood_pool();
}

play_blood_pool(var_0, var_1) {
  if(!isDefined(self)) {
    return;
  }
  if(isDefined(self.skipbloodpool)) {
    return;
  }
  var_2 = self gettagorigin("j_SpineUpper");
  var_3 = self gettagangles("j_SpineUpper");
  var_4 = anglesToForward(var_3);
  var_5 = anglestoup(var_3);
  var_6 = anglestoright(var_3);
  var_2 = var_2 + var_4 * -8.5 + var_5 * 5 + var_6 * 0;
  var_7 = scripts\engine\trace::_bullet_trace(var_2 + (0, 0, 30), var_2 - (0, 0, 100), 0, undefined);

  if(var_7["normal"][2] > 0.9)
    playFX(level._effect["deathfx_bloodpool_generic"], var_2);
}

specialdeath() {
  if(self.a.special == "none")
    return 0;

  if(self.damagemod == "MOD_MELEE")
    return 0;

  switch (self.a.special) {
    case "cover_right":
      if(self.currentpose == "stand") {
        var_0 = scripts\anim\utility.gsc::lookupanim("death", "cover_right_stand");
        dodeathfromarray(var_0);
      } else {
        var_0 = [];

        if(scripts\engine\utility::damagelocationisany("head", "neck"))
          var_0 = scripts\anim\utility.gsc::lookupanim("death", "cover_right_crouch_head");
        else
          var_0 = scripts\anim\utility.gsc::lookupanim("death", "cover_right_crouch_default");

        dodeathfromarray(var_0);
      }

      return 1;
    case "cover_left":
      if(self.currentpose == "stand") {
        var_0 = scripts\anim\utility.gsc::lookupanim("death", "cover_left_stand");
        dodeathfromarray(var_0);
      } else {
        var_0 = scripts\anim\utility.gsc::lookupanim("death", "cover_left_crouch");
        dodeathfromarray(var_0);
      }

      return 1;
    case "cover_stand":
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "cover_stand");
      dodeathfromarray(var_0);
      return 1;
    case "cover_crouch":
      var_0 = [];

      if(scripts\engine\utility::damagelocationisany("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45))
        var_0[var_0.size] = scripts\anim\utility.gsc::lookupanim("death", "cover_crouch_head");

      if(self.damageyaw > -45 && self.damageyaw <= 45)
        var_0[var_0.size] = scripts\anim\utility.gsc::lookupanim("death", "cover_crouch_back");

      var_0[var_0.size] = scripts\anim\utility.gsc::lookupanim("death", "cover_crouch_default");
      dodeathfromarray(var_0);
      return 1;
    case "saw":
      if(self.currentpose == "stand")
        dodeathfromarray(scripts\anim\utility.gsc::lookupanim("death", "saw_stand"));
      else if(self.currentpose == "crouch")
        dodeathfromarray(scripts\anim\utility.gsc::lookupanim("death", "saw_crouch"));
      else
        dodeathfromarray(scripts\anim\utility.gsc::lookupanim("death", "saw_prone"));

      return 1;
    case "dying_crawl":
      if(isDefined(self.a.onback) && self.currentpose == "crouch") {
        var_0 = scripts\anim\utility.gsc::lookupanim("death", "dying_crawl_crouch");
        dodeathfromarray(var_0);
      } else {
        var_0 = scripts\anim\utility.gsc::lookupanim("death", "dying_crawl_prone");
        dodeathfromarray(var_0);
      }

      return 1;
    case "stumbling_pain":
      playdeathanim(self.a.stumblingpainanimseq[self.a.stumblingpainanimseq.size - 1]);
      return 1;
  }

  return 0;
}

dodeathfromarray(var_0) {
  var_1 = var_0[randomint(var_0.size)];
  playdeathanim(var_1);

  if(isDefined(self.deathanimscript))
    self[[self.deathanimscript]]();
}

playdeathsound() {
  scripts\anim\face.gsc::saygenericdialogue("death");
}

print3dfortime(var_0, var_1, var_2) {
  var_3 = var_2 * 20;

  for(var_4 = 0; var_4 < var_3; var_4++)
    wait 0.05;
}

helmetpop() {
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.hatmodel)) {
    return;
  }
  var_0 = getpartname(self.hatmodel, 0);
  var_1 = spawn("script_model", self.origin + (0, 0, 64));
  var_1 setModel(self.hatmodel);
  var_1.origin = self gettagorigin(var_0);
  var_1.angles = self gettagangles(var_0);
  var_1 thread helmetlaunch(self.damagedir);
  var_2 = self.hatmodel;
  self.hatmodel = undefined;
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }
  self detach(var_2, "");
}

helmetlaunch(var_0) {
  var_1 = var_0;
  var_1 = var_1 * randomfloatrange(2000, 4000);
  var_2 = var_1[0];
  var_3 = var_1[1];
  var_4 = randomfloatrange(1500, 3000);
  var_5 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(var_5, (var_2, var_3, var_4));
  wait 60;

  for(;;) {
    if(!isDefined(self)) {
      return;
    }
    if(distancesquared(self.origin, level.player.origin) > 262144) {
      break;
    }

    wait 30;
  }

  self delete();
}

removeselffrom_squadlastseenenemypos(var_0) {
  for(var_1 = 0; var_1 < anim.squadindex.size; var_1++)
    anim.squadindex[var_1] clearsightposnear(var_0);
}

clearsightposnear(var_0) {
  if(!isDefined(self.sightpos)) {
    return;
  }
  if(distance(var_0, self.sightpos) < 80) {
    self.sightpos = undefined;
    self.sighttime = gettime();
  }
}

shoulddorunningforwarddeath() {
  if(self.a.movement != "run")
    return 0;

  if(self getmotionangle() > 60 || self getmotionangle() < -60)
    return 0;

  if(self.damagemod == "MOD_MELEE")
    return 0;

  return 1;
}

shoulddostrongbulletdamage(var_0, var_1, var_2, var_3) {
  if(isDefined(self.a.doinglongdeath))
    return 0;

  if(self.currentpose == "prone" || isDefined(self.a.onback))
    return 0;

  if(nullweapon(var_0))
    return 0;

  if(var_2 > 500)
    return 1;

  if(var_1 == "MOD_MELEE")
    return 0;

  if(self.a.movement == "run" && !isattackerwithindist(var_3, 275)) {
    if(randomint(100) < 65)
      return 0;
  }

  if(scripts\anim\utility_common.gsc::issniperrifle(var_0) && self.maxhealth < var_2)
    return 1;

  if(scripts\anim\utility_common.gsc::isshotgun(var_0) && isattackerwithindist(var_3, 512))
    return 1;

  if(isdeserteagle(var_0) && isattackerwithindist(var_3, 425))
    return 1;

  return 0;
}

isdeserteagle(var_0) {
  if(var_0.basename == "deserteagle")
    return 1;

  return 0;
}

isattackerwithindist(var_0, var_1) {
  if(!isDefined(var_0))
    return 0;

  if(distancesquared(self.origin, var_0.origin) > var_1 * var_1)
    return 0;

  return 1;
}

getdeathanim() {
  if(shoulddostrongbulletdamage(self.damageweapon, self.damagemod, self.damagetaken, self.attacker)) {
    var_0 = getstrongbulletdamagedeathanim();

    if(isDefined(var_0))
      return var_0;
  }

  if(isDefined(self.a.onback)) {
    if(self.currentpose == "crouch")
      return getbackdeathanim();
    else
      scripts\anim\utility.gsc::stoponback();
  }

  if(self.currentpose == "stand") {
    if(shoulddorunningforwarddeath())
      return getrunningforwarddeathanim();
    else
      return getstanddeathanim();
  } else if(self.currentpose == "crouch")
    return getcrouchdeathanim();
  else if(self.currentpose == "prone")
    return getpronedeathanim();
}

getstrongbulletdamagedeathanim() {
  var_0 = abs(self.damageyaw);

  if(var_0 < 45) {
    return;
  }
  if(var_0 > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot"))
      var_1 = scripts\anim\utility.gsc::lookupanim("death", "strong_legs");
    else if(self.damagelocation == "torso_lower")
      var_1 = scripts\anim\utility.gsc::lookupanim("death", "strong_torso_lower");
    else
      var_1 = scripts\anim\utility.gsc::lookupanim("death", "strong_default");
  } else if(self.damageyaw < 0)
    var_1 = scripts\anim\utility.gsc::lookupanim("death", "strong_right");
  else
    var_1 = scripts\anim\utility.gsc::lookupanim("death", "strong_left");

  return var_1[randomint(var_1.size)];
}

getrunningforwarddeathanim() {
  if(abs(self.damageyaw) < 45) {
    var_0 = scripts\anim\utility.gsc::lookupanim("death", "running_forward_f");
    var_1 = getrandomunblockedanim(var_0);

    if(isDefined(var_1))
      return var_1;
  }

  var_0 = scripts\anim\utility.gsc::lookupanim("death", "running_forward");
  var_1 = getrandomunblockedanim(var_0);

  if(isDefined(var_1))
    return var_1;

  return getstanddeathanim();
}

getrandomunblockedanim(var_0) {
  if(!isDefined(var_0))
    return undefined;

  var_1 = undefined;

  for(var_2 = var_0.size; var_2 > 0; var_2--) {
    var_3 = randomint(var_2);
    var_1 = var_0[var_3];

    if(!isanimblocked(var_1))
      return var_1;

    var_0[var_3] = var_0[var_2 - 1];
    var_0[var_2 - 1] = undefined;
  }

  return undefined;
}

removeundefined(var_0) {
  var_1 = [];

  for(var_2 = 0; var_2 < var_0.size; var_2++) {
    if(!isDefined(var_0[var_2])) {
      continue;
    }
    var_1[var_1.size] = var_0[var_2];
  }

  return var_1;
}

isanimblocked(var_0) {
  var_1 = 1;

  if(animhasnotetrack(var_0, "code_move"))
    var_1 = getnotetracktimes(var_0, "code_move")[0];

  var_2 = getmovedelta(var_0, 0, var_1);
  var_3 = self localtoworldcoords(var_2);
  return !self maymovetopoint(var_3, 1, 1);
}

getstandpistoldeathanim() {
  var_0 = [];

  if(abs(self.damageyaw) < 50)
    var_0 = scripts\anim\utility.gsc::lookupanim("death", "stand_pistol_forward");
  else {
    if(abs(self.damageyaw) < 110)
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "stand_pistol_front");

    if(self.damagelocation == "torso_upper")
      var_0 = scripts\engine\utility::array_combine(scripts\anim\utility.gsc::lookupanim("death", "stand_pistol_torso_upper"), var_0);
    else if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower"))
      var_0 = scripts\engine\utility::array_combine(scripts\anim\utility.gsc::lookupanim("death", "stand_pistol_torso_upper"), var_0);

    if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0)
      var_0 = scripts\engine\utility::array_combine(scripts\anim\utility.gsc::lookupanim("death", "stand_pistol_upper_body"), var_0);

    if(var_0.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper"))
      var_0 = scripts\engine\utility::array_combine(scripts\anim\utility.gsc::lookupanim("death", "stand_pistol_default"), var_0);
  }

  return var_0;
}

getstanddeathanim() {
  var_0 = [];
  var_1 = [];

  if(scripts\anim\utility_common.gsc::isusingsidearm())
    var_0 = getstandpistoldeathanim();
  else if(isDefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker)) {
    if(self.damageyaw <= 120 || self.damageyaw > -120)
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "melee_standing_front");
    else if(self.damageyaw <= -60 && self.damageyaw > 60)
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "melee_standing_back");
    else if(self.damageyaw < 0)
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "melee_standing_left");
    else
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "melee_standing_right");
  } else {
    if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "stand_lower_body");
      var_1 = scripts\anim\utility.gsc::lookupanim("death", "stand_lower_body_extended");
    } else if(scripts\engine\utility::damagelocationisany("head", "helmet"))
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "stand_head");
    else if(scripts\engine\utility::damagelocationisany("neck"))
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "stand_neck");
    else if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper"))
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "stand_left_shoulder");

    if(scripts\engine\utility::damagelocationisany("torso_upper")) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "stand_torso_upper"));
      var_1 = scripts\engine\utility::array_combine(var_1, scripts\anim\utility.gsc::lookupanim("death", "stand_torso_upper_extended"));
    }

    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet")) {
        var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "stand_front_torso"));
        var_1 = scripts\engine\utility::array_combine(var_1, scripts\anim\utility.gsc::lookupanim("death", "stand_front_torso_extended"));
      }

      if(scripts\engine\utility::damagelocationisany("torso_upper")) {
        var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "stand_front_torso"));
        var_1 = scripts\engine\utility::array_combine(var_1, scripts\anim\utility.gsc::lookupanim("death", "stand_front_torso_extended"));
      }
    } else if(self.damageyaw > -45 && self.damageyaw <= 45)
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "stand_back"));

    var_2 = var_0.size > 0;

    if(!var_2 || randomint(100) < 15)
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "stand_default"));

    if(randomint(100) < 10 && firingdeathallowed()) {
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "stand_default_firing"));
      var_0 = removeundefined(var_0);
    }
  }

  if(var_0.size == 0)
    var_0[var_0.size] = scripts\anim\utility.gsc::lookupanim("death", "stand_backup_default");

  if(!self.a.disablelongdeath && self.stairsstate == "none" && !isDefined(self.a.painonstairs)) {
    var_3 = randomint(var_0.size + var_1.size);

    if(var_3 < var_0.size)
      return var_0[var_3];
    else
      return var_1[var_3 - var_0.size];
  }

  return var_0[randomint(var_0.size)];
}

getcrouchdeathanim() {
  var_0 = [];

  if(isDefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker)) {
    if(self.damageyaw <= 120 || self.damageyaw > -120)
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "melee_crouching_front");
    else if(self.damageyaw <= -60 && self.damageyaw > 60)
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "melee_crouching_back");
    else if(self.damageyaw < 0)
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "melee_crouching_left");
    else
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "melee_crouching_right");
  } else {
    if(scripts\engine\utility::damagelocationisany("head", "neck"))
      var_0 = scripts\anim\utility.gsc::lookupanim("death", "crouch_head");

    if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck"))
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "crouch_torso"));

    if(var_0.size < 2)
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "crouch_default1"));

    if(var_0.size < 2)
      var_0 = scripts\engine\utility::array_combine(var_0, scripts\anim\utility.gsc::lookupanim("death", "crouch_default2"));
  }

  return var_0[randomint(var_0.size)];
}

getpronedeathanim() {}

getbackdeathanim() {}

firingdeathallowed() {
  if(!isDefined(self.weapon) || !scripts\anim\utility_common.gsc::usingriflelikeweapon() || !weaponisauto(self.weapon) || !weaponisbeam(self.weapon) || self.diequietly)
    return 0;

  if(getqueuedspleveltransients(self.a.weaponpos["right"]))
    return 0;

  return 1;
}

tryadddeathanim(var_0) {
  return var_0;
}

tryaddfiringdeathanim(var_0) {
  return var_0;
}

playexplodedeathanim() {
  if(isDefined(self.juggernaut))
    return 0;

  if(self.damagelocation != "none")
    return 0;
}