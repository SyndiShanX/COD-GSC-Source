/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\death.gsc
***********************************************/

function init_animset_death() {}

function init_deathfx() {
  scripts\engine\utility::add_fx("deathfx_bloodpool_generic", "vfx/iw8/char/blood/vfx_deathfx_bloodpool_01.vfx");
}

function main() {
  self endon("killanimscript");
  self waittill("hellfreezesover");
}

function doimmediateragdolldeath() {
  scripts\anim\shared::dropallaiweapons();
  self.skipdeathanim = 1;
  var0 = 10;
  var1 = scripts\common\utility::getdamagetype(self.damagemod);

  if(isDefined(self.attacker) && self.attacker == level.player && var1 == "melee") {
    var0 = 5;
  }

  var2 = self.damagetaken;

  if(var1 == "bullet") {
    var2 = max(var2, 300);
  }

  var3 = var0 * var2;
  var4 = max(0.3, self.damagedir[2]);
  var5 = (self.damagedir[0], self.damagedir[1], var4);

  if(isDefined(self.ragdoll_directionscale)) {
    var5 *= self.ragdoll_directionscale;
  } else {
    var5 *= var3;
  }

  if(self.forceragdollimmediate) {
    var5 += self.prevanimdelta * 20 * 10;
  }

  if(isDefined(self.ragdoll_start_vel)) {
    var5 += self.ragdoll_start_vel * 10;
  }

  self startragdollfromimpact(self.damagelocation, var5);
  wait 0.05;
}

function cross2d(var0, var1) {
  return var0[0] * var1[1] - var1[0] * var0[1];
}

function meleegetattackercardinaldirection(var0, var1) {
  var2 = vectordot(var1, var0);
  var3 = cos(60);

  if(squared(var2) < squared(var3)) {
    if(cross2d(var0, var1) > 0) {
      return 1;
    }

    return 3;
  }

  if(var2 < 0) {
    return 0;
  }

  return 2;
}

function orientmeleevictim() {
  if(self.damagemod == "MOD_MELEE" && isDefined(self.attacker)) {
    var0 = self.origin - self.attacker.origin;
    var1 = anglesToForward(self.angles);
    var2 = vectorNormalize((var0[0], var0[1], 0));
    var3 = vectorNormalize((var1[0], var1[1], 0));
    var4 = meleegetattackercardinaldirection(var3, var2);
    var5 = var4 * 90;
    var6 = (-1 * var2[0], -1 * var2[1], 0);
    var7 = rotatevector(var6, (0, var5, 0));
    var8 = vectortoyaw(var7);
    self orientmode("face angle", var8);
    return;
  }
}

#using_animtree("generic_human");

function playdeathanim(var0) {
  if(!animhasnotetrack(var0, "dropgun") && !animhasnotetrack(var0, "fire_spray")) {
    scripts\anim\shared::dropallaiweapons();
  }

  orientmeleevictim();
  self setflaggedanimknoballrestart("deathanim", var0, %body, 1, 0.1);
  scripts\anim\face::playfacialanim(var0, "death");

  if(isDefined(self.skipdeathanim)) {
    if(!isDefined(self.noragdoll)) {
      self startragdoll();
    }

    wait 0.05;
    self animmode("gravity");
  } else if(isDefined(self.ragdolltime)) {
    thread waitforragdoll(self.ragdolltime);
  } else if(!animhasnotetrack(var0, "start_ragdoll")) {
    if(self.damagemod == "MOD_MELEE") {
      var1 = 0.7;
    } else {
      var1 = 0.35;
    }

    thread waitforragdoll(getanimlength(var1) * var1);
  }

  if(!isDefined(self.skipdeathanim)) {
    thread playdeathfx();
  }

  scripts\anim\notetracks::donotetracks("deathanim");
  scripts\anim\shared::dropallaiweapons();
  self notify("endPlayDeathAnim");
}

function waitforragdoll(var0) {
  wait var0;

  if(isDefined(self)) {
    scripts\anim\shared::dropallaiweapons();
  }

  if(isDefined(self) && !isDefined(self.noragdoll)) {
    self startragdoll();
    return;
  }
}

function playdeathfx() {
  self endon("killanimscript");

  if(self.stairsstate != "none") {
    return;
  }

  wait 2;

  if(isDefined(self.noragdoll)) {
    play_blood_pool();
    return;
  }
}

function play_blood_pool(var0, var1) {
  if(!isDefined(self)) {
    return;
  }

  if(isDefined(self.skipbloodpool)) {
    return;
  }

  var2 = self gettagorigin("j_SpineUpper");
  var3 = self gettagangles("j_SpineUpper");
  var4 = anglesToForward(var3);
  var5 = anglestoup(var3);
  var6 = anglestoright(var3);
  var2 = var2 + var4 * -8.5 + var5 * 5 + var6 * 0;
  var7 = scripts\engine\trace::_bullet_trace(var2 + (0, 0, 30), var2 - (0, 0, 100), 0, undefined);

  if(var7["normal"][2] > 0.9) {
    playFX(level._effect["deathfx_bloodpool_generic"], var2);
    return;
  }
}

function specialdeath() {
  if(self.a.special == "none") {
    return false;
  }

  if(self.damagemod == "MOD_MELEE") {
    return false;
  }

  switch (self.a.special) {
    case "cover_right":
      if(self.currentpose == "stand") {
        var0 = scripts\anim\utility::lookupanim("death", "cover_right_stand");
        dodeathfromarray(var0);
      } else {
        var0 = [];

        if(scripts\engine\utility::damagelocationisany("head", "neck")) {
          var0 = scripts\anim\utility::lookupanim("death", "cover_right_crouch_head");
        } else {
          var0 = scripts\anim\utility::lookupanim("death", "cover_right_crouch_default");
        }

        dodeathfromarray(var0);
      }

      return true;
    case "cover_left":
      if(self.currentpose == "stand") {
        var0 = scripts\anim\utility::lookupanim("death", "cover_left_stand");
        dodeathfromarray(var0);
      } else {
        var0 = scripts\anim\utility::lookupanim("death", "cover_left_crouch");
        dodeathfromarray(var0);
      }

      return true;
    case "cover_stand":
      var0 = scripts\anim\utility::lookupanim("death", "cover_stand");
      dodeathfromarray(var0);
      return true;
    case "cover_crouch":
      var0 = [];

      if(scripts\engine\utility::damagelocationisany("head", "neck") && (self.damageyaw > 135 || self.damageyaw <= -45)) {
        GscBinSkip0(0x2e, var0.size, scripts\anim\utility::lookupanim("death", "cover_crouch_head"));
      }

      if(self.damageyaw > -45 && self.damageyaw <= 45) {
        GscBinSkip0(0x2e, var0.size, scripts\anim\utility::lookupanim("death", "cover_crouch_back"));
      }

      GscBinSkip0(0x2e, var0.size, scripts\anim\utility::lookupanim("death", "cover_crouch_default"));

    case "saw":
      if(self.currentpose == "stand") {
        dodeathfromarray(scripts\anim\utility::lookupanim("death", "saw_stand"));
      } else if(self.currentpose == "crouch") {
        dodeathfromarray(scripts\anim\utility::lookupanim("death", "saw_crouch"));
      } else {
        dodeathfromarray(scripts\anim\utility::lookupanim("death", "saw_prone"));
      }

      return true;
    case "dying_crawl":
      if(isDefined(self.a.onback) && self.currentpose == "crouch") {
        var0 = scripts\anim\utility::lookupanim("death", "dying_crawl_crouch");
        dodeathfromarray(var0);
      } else {
        var0 = scripts\anim\utility::lookupanim("death", "dying_crawl_prone");
        dodeathfromarray(var0);
      }

      return true;
    case "stumbling_pain":
      playdeathanim(self.a.stumblingpainanimseq[self.a.stumblingpainanimseq.size - 1]);
      return true;
  }

  return false;
}

function dodeathfromarray(var0) {
  var1 = var0[randomint(var0.size)];
  playdeathanim(var1);

  if(isDefined(self.deathanimscript)) {
    self[[self.deathanimscript]]();
    return;
  }
}

function playdeathsound() {
  scripts\anim\face::saygenericdialogue("death");
}

function print3dfortime(var0, var1, var2) {
  var3 = var2 * 20;

  for(var4 = 0; var4 < var3; var4++) {
    wait 0.05;
  }
}

function helmetpop() {
  if(!isDefined(self)) {
    return;
  }

  if(!isDefined(self.hatmodel)) {
    return;
  }

  var0 = getpartname(self.hatmodel, 0);
  var1 = spawn("script_model", self.origin + (0, 0, 64));
  var1 setModel(self.hatmodel);
  var1.origin = self gettagorigin(var0);
  var1.angles = self gettagangles(var0);
  thread helmetlaunch(var1);
  var2 = self.hatmodel;
  self.hatmodel = undefined;
  wait 0.05;

  if(!isDefined(self)) {
    return;
  }

  self detach(var2, "");
}

function helmetlaunch(var0) {
  var1 = var0;
  var1 *= randomfloatrange(2000, 4000);
  var2 = var1[0];
  var3 = var1[1];
  var4 = randomfloatrange(1500, 3000);
  var5 = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1)) * 5;
  self physicslaunchclient(var5, (var2, var3, var4));
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

function removeselffrom_squadlastseenenemypos(var0) {
  for(var1 = 0; var1 < anim.squadindex.size; var1++) {
    clearsightposnear(anim.squadindex[var1], var0);
  }
}

function clearsightposnear(var0) {
  if(!isDefined(self.sightpos)) {
    return;
  }

  if(distance(var0, self.sightpos) < 80) {
    self.sightpos = undefined;
    self.sighttime = gettime();
    return;
  }
}

function shoulddorunningforwarddeath() {
  if(self.a.movement != "run") {
    return false;
  }

  if(self getmotionangle() > 60 || self getmotionangle() < -60) {
    return false;
  }

  if(self.damagemod == "MOD_MELEE") {
    return false;
  }

  return true;
}

function shoulddostrongbulletdamage(var0, var1, var2, var3) {
  if(isDefined(self.a.doinglongdeath)) {
    return false;
  }

  if(self.currentpose == "prone" || isDefined(self.a.onback)) {
    return false;
  }

  if(nullweapon(var0)) {
    return false;
  }

  if(var2 > 500) {
    return true;
  }

  if(var1 == "MOD_MELEE") {
    return false;
  }

  if(self.a.movement == "run" && !isattackerwithindist(var3, 275)) {
    if(randomint(100) < 65) {
      return false;
    }
  }

  if(scripts\anim\utility_common::issniperrifle(var0) && self.maxhealth < var2) {
    return true;
  }

  if(scripts\anim\utility_common::isshotgun(var0) && isattackerwithindist(var3, 512)) {
    return true;
  }

  if(isdeserteagle(var0) && isattackerwithindist(var3, 425)) {
    return true;
  }

  return false;
}

function isdeserteagle(var0) {
  if(var0.basename == "deserteagle") {
    return true;
  }

  return false;
}

function isattackerwithindist(var0, var1) {
  if(!isDefined(var0)) {
    return false;
  }

  if(distancesquared(self.origin, var0.origin) > var1 * var1) {
    return false;
  }

  return true;
}

function getdeathanim() {
  if(shoulddostrongbulletdamage(self.damageweapon, self.damagemod, self.damagetaken, self.attacker)) {
    var0 = getstrongbulletdamagedeathanim();

    if(isDefined(var0)) {
      return var0;
    }
  }

  if(isDefined(self.a.onback)) {
    if(self.currentpose == "crouch") {
      return getbackdeathanim();
    } else {
      scripts\anim\utility::stoponback();
    }
  }

  if(self.currentpose == "stand") {
    if(shoulddorunningforwarddeath()) {
      return getrunningforwarddeathanim();
    }

    return getstanddeathanim();
  }

  if(self.currentpose == "crouch") {
    return getcrouchdeathanim();
  }

  if(self.currentpose == "prone") {
    return getpronedeathanim();
  }
}

function getstrongbulletdamagedeathanim() {
  var0 = abs(self.damageyaw);

  if(var0 < 45) {
    return;
  }

  if(var0 > 150) {
    if(scripts\engine\utility::damagelocationisany("left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower", "left_foot", "right_foot")) {
      var1 = scripts\anim\utility::lookupanim("death", "strong_legs");
    } else if(self.damagelocation == "torso_lower") {
      var1 = scripts\anim\utility::lookupanim("death", "strong_torso_lower");
    } else {
      var1 = scripts\anim\utility::lookupanim("death", "strong_default");
    }
  } else if(self.damageyaw < 0) {
    var1 = scripts\anim\utility::lookupanim("death", "strong_right");
  } else {
    var1 = scripts\anim\utility::lookupanim("death", "strong_left");
  }

  return var1[randomint(var1.size)];
}

function getrunningforwarddeathanim() {
  if(abs(self.damageyaw) < 45) {
    var0 = scripts\anim\utility::lookupanim("death", "running_forward_f");
    var1 = getrandomunblockedanim(var0);

    if(isDefined(var1)) {
      return var1;
    }
  }

  var0 = scripts\anim\utility::lookupanim("death", "running_forward");
  var1 = getrandomunblockedanim(var0);

  if(isDefined(var1)) {
    return var1;
  }

  return getstanddeathanim();
}

function getrandomunblockedanim(var0) {
  if(!isDefined(var0)) {
    return undefined;
  }

  var1 = undefined;

  for(var2 = var0.size; var2 > 0; var2--) {
    var3 = randomint(var2);
    var1 = var0[var3];

    if(!isanimblocked(var1)) {
      return var1;
    }

    var0 = var0[var2 - 1];
    var0[var2 - 1] = undefined;
  }

  return undefined;
}

function removeundefined(var0) {
  var1 = [];

  for(var2 = 0; var2 < var0.size; var2++) {
    if(!isDefined(var0[var2])) {
      continue;
    }

    var1 = var0[var2];
  }

  return var1;
}

function isanimblocked(var0) {
  var1 = 1;

  if(animhasnotetrack(var0, "code_move")) {
    var1 = getnotetracktimes(var0, "code_move")[0];
  }

  var2 = getmovedelta(var0, 0, var1);
  var3 = self localtoworldcoords(var2);
  return !self maymovetopoint(var3, 1, 1);
}

function getstandpistoldeathanim() {
  var0 = [];

  if(abs(self.damageyaw) < 50) {
    var0 = scripts\anim\utility::lookupanim("death", "stand_pistol_forward");
  } else {
    if(abs(self.damageyaw) < 110) {
      var0 = scripts\anim\utility::lookupanim("death", "stand_pistol_front");
    }

    if(self.damagelocation == "torso_upper") {
      var0 = scripts\engine\utility::array_combine(scripts\anim\utility::lookupanim("death", "stand_pistol_torso_upper"), var0);
    } else if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_upper", "right_leg_lower")) {
      var0 = scripts\engine\utility::array_combine(scripts\anim\utility::lookupanim("death", "stand_pistol_torso_upper"), var0);
    }

    if(!scripts\engine\utility::damagelocationisany("head", "neck", "helmet", "left_foot", "right_foot", "left_hand", "right_hand", "gun") && randomint(2) == 0) {
      var0 = scripts\engine\utility::array_combine(scripts\anim\utility::lookupanim("death", "stand_pistol_upper_body"), var0);
    }

    if(var0.size == 0 || scripts\engine\utility::damagelocationisany("torso_lower", "torso_upper", "neck", "head", "helmet", "right_arm_upper", "left_arm_upper")) {
      var0 = scripts\engine\utility::array_combine(scripts\anim\utility::lookupanim("death", "stand_pistol_default"), var0);
    }
  }

  return var0;
}

function getstanddeathanim() {
  var0 = [];
  var1 = [];

  if(scripts\anim\utility_common::isusingsidearm()) {
    var0 = getstandpistoldeathanim();
  } else if(isDefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker)) {
    if(self.damageyaw <= 120 || self.damageyaw > -120) {
      var0 = scripts\anim\utility::lookupanim("death", "melee_standing_front");
    } else if(self.damageyaw <= -60 && self.damageyaw > 60) {
      var0 = scripts\anim\utility::lookupanim("death", "melee_standing_back");
    } else if(self.damageyaw < 0) {
      var0 = scripts\anim\utility::lookupanim("death", "melee_standing_left");
    } else {
      var0 = scripts\anim\utility::lookupanim("death", "melee_standing_right");
    }
  } else {
    if(scripts\engine\utility::damagelocationisany("torso_lower", "left_leg_upper", "left_leg_lower", "right_leg_lower", "right_leg_lower")) {
      var0 = scripts\anim\utility::lookupanim("death", "stand_lower_body");
      var1 = scripts\anim\utility::lookupanim("death", "stand_lower_body_extended");
    } else if(scripts\engine\utility::damagelocationisany("head", "helmet")) {
      var0 = scripts\anim\utility::lookupanim("death", "stand_head");
    } else if(scripts\engine\utility::damagelocationisany("neck")) {
      var0 = scripts\anim\utility::lookupanim("death", "stand_neck");
    } else if(scripts\engine\utility::damagelocationisany("torso_upper", "left_arm_upper")) {
      var0 = scripts\anim\utility::lookupanim("death", "stand_left_shoulder");
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper")) {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "stand_torso_upper"));
      var1 = scripts\engine\utility::array_combine(var1, scripts\anim\utility::lookupanim("death", "stand_torso_upper_extended"));
    }

    if(self.damageyaw > 135 || self.damageyaw <= -135) {
      if(scripts\engine\utility::damagelocationisany("neck", "head", "helmet")) {
        var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "stand_front_torso"));
        var1 = scripts\engine\utility::array_combine(var1, scripts\anim\utility::lookupanim("death", "stand_front_torso_extended"));
      }

      if(scripts\engine\utility::damagelocationisany("torso_upper")) {
        var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "stand_front_torso"));
        var1 = scripts\engine\utility::array_combine(var1, scripts\anim\utility::lookupanim("death", "stand_front_torso_extended"));
      }
    } else if(self.damageyaw > -45 && self.damageyaw <= 45) {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "stand_back"));
    }

    var2 = var0.size > 0;

    if(!var2 || randomint(100) < 15) {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "stand_default"));
    }

    if(randomint(100) < 10 && firingdeathallowed()) {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "stand_default_firing"));
      var0 = removeundefined(var0);
    }
  }

  if(var0.size == 0) {
    var0 = scripts\anim\utility::lookupanim("death", "stand_backup_default");
  }

  if(!self.a.disablelongdeath && self.stairsstate == "none" && !isDefined(self.a.painonstairs)) {
    var3 = randomint(var0.size + var1.size);

    if(var3 < var0.size) {
      return var0[var3];
    } else {
      return var1[var3 - var0.size];
    }
  }

  return var0[randomint(var0.size)];
}

function getcrouchdeathanim() {
  var0 = [];

  if(isDefined(self.attacker) && self shouldplaymeleedeathanim(self.attacker)) {
    if(self.damageyaw <= 120 || self.damageyaw > -120) {
      var0 = scripts\anim\utility::lookupanim("death", "melee_crouching_front");
    } else if(self.damageyaw <= -60 && self.damageyaw > 60) {
      var0 = scripts\anim\utility::lookupanim("death", "melee_crouching_back");
    } else if(self.damageyaw < 0) {
      var0 = scripts\anim\utility::lookupanim("death", "melee_crouching_left");
    } else {
      var0 = scripts\anim\utility::lookupanim("death", "melee_crouching_right");
    }
  } else {
    if(scripts\engine\utility::damagelocationisany("head", "neck")) {
      var0 = scripts\anim\utility::lookupanim("death", "crouch_head");
    }

    if(scripts\engine\utility::damagelocationisany("torso_upper", "torso_lower", "left_arm_upper", "right_arm_upper", "neck")) {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "crouch_torso"));
    }

    if(var0.size < 2) {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "crouch_default1"));
    }

    if(var0.size < 2) {
      var0 = scripts\engine\utility::array_combine(var0, scripts\anim\utility::lookupanim("death", "crouch_default2"));
    }
  }

  return var0[randomint(var0.size)];
}

function getpronedeathanim() {}

function getbackdeathanim() {}

function firingdeathallowed() {
  if(!isDefined(self.weapon) || !scripts\anim\utility_common::usingriflelikeweapon() || !weaponisauto(self.weapon) || !weaponisbeam(self.weapon) || self.diequietly) {
    return false;
  }

  if(getqueuedspleveltransients(self.a.weaponpos["right"])) {
    return false;
  }

  return true;
}

function tryadddeathanim(var0) {
  return var0;
}

function tryaddfiringdeathanim(var0) {
  return var0;
}

function playexplodedeathanim() {
  if(isDefined(self.juggernaut)) {
    return 0;
  }

  if(self.damagelocation != "none") {
    return 0;
  }
}