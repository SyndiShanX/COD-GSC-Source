/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\utility.gsc
**************************************/

#include animscripts\setposemovement;
#include animscripts\combat_utility;
#include animscripts\debug;
#include animscripts\anims;
#include common_scripts\utility;
#include maps\_utility;
#include animscripts\combat;
#include animscripts\shared;
#include maps\_gameskill;
#include animscripts\shoot_behavior;
#include animscripts\utility;
#using_animtree("generic_human");

initanimtree(animscript) {
  self clearanim( % body, 0.3);
  self setanim( % body, 1, 0);

  if(animscript != "pain" && animscript != "death" && animscript != "react")
    self.a.special = "none";

  self.missedsightchecks = 0;
  self.a.aimweight = 1.0;
  self.a.aimweight_start = 1.0;
  self.a.aimweight_end = 1.0;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  self.a.isaiming = 0;
  self setanim( % shoot, 0, 0.2, 1);
  isincombat();
  assert(isDefined(animscript), "Animscript not specified in initAnimTree");
  self.a.prevscript = self.a.script;
  self.a.script = animscript;
  self.a.script_suffix = undefined;
  self animscripts\anims::clearanimcache();
  [[self.a.stopcowering]]();
}

updateanimpose() {
  assert(self.a.movement == "stop" || self.a.movement == "walk" || self.a.movement == "run", "UpdateAnimPose " + self.a.pose + " " + self.a.movement);

  if(isDefined(self.desired_anim_pose) && self.desired_anim_pose != self.a.pose) {
    if(self.a.pose == "prone")
      self exitpronewrapper(0.5);

    if(self.desired_anim_pose == "prone") {
      self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_aiming, % prone_legs_up);
      self enterpronewrapper(0.5);
      self setanimknoball(animarray("straight_level", "combat"), % body, 1, 0.1, 1);
    }
  }

  self.desired_anim_pose = undefined;
}

initialize(animscript) {
  if(isDefined(self.doinglongdeath)) {
    if(animscript != "pain" && animscript != "death")
      self dodamage(self.health + 100, self.origin);

    if(animscript != "pain") {
      self.longdeathstarting = undefined;
      self notify("kill_long_death");
    }
  }

  if(isDefined(self.a.mayonlydie) && animscript != "death")
    self dodamage(self.health + 100, self.origin);

  if(isDefined(self.a.postscriptfunc)) {
    scriptfunc = self.a.postscriptfunc;
    self.a.postscriptfunc = undefined;
    [
      [scriptfunc]
    ](animscript);
  }

  if((animscript == "move" || animscript == "combat") && self.weapon == self.sidearm && (!isDefined(self.forcesidearm) || !self.forcesidearm))
    self animscripts\combat::switchtolastweapon(1);

  if(!aihasonlypistol() && self.weapon == self.sidearm && self.a.script == "combat" && (animscript != "move" && animscript != "pain") && !(isDefined(self.a.dontswitchtoprimarybeforemoving) && self.a.dontswitchtoprimarybeforemoving))
    animscripts\shared::placeweaponon(self.primaryweapon, "right");

  if(animscript != "combat" && animscript != "move" && animscript != "pain")
    self.a.magicreloadwhenreachenemy = 0;

  if(isDefined(self.isholdinggrenade) && (animscript == "pain" || animscript == "death" || animscript == "flashed"))
    self dropgrenade();

  self.isholdinggrenade = undefined;

  if(isDefined(self.a.script) && !self animscripts\debug::debugshouldclearstate())
    self animscripts\debug::debugpopstate(self.a.script);
  else
    self animscripts\debug::debugclearstate();

  self animscripts\debug::debugpushstate(animscript);

  self.covernode = undefined;
  self.suppressed = 0;
  self.isreloading = 0;
  self.waschangingcoverpos = self.changingcoverpos;
  self.changingcoverpos = 0;
  self.a.scriptstarttime = gettime();
  self.a.atconcealmentnode = 0;
  self.a.atpillarnode = 0;

  if(isDefined(self.node)) {
    if(self.node.type == "Conceal Prone" || self.node.type == "Conceal Crouch" || self.node.type == "Conceal Stand")
      self.a.atconcealmentnode = 1;
    else if(self.node.type == "Cover Pillar")
      self.a.atpillarnode = 1;
  }

  initanimtree(animscript);
  updateanimpose();
}

setcurrentweapon(weapon) {
  self.weapon = weapon;
  self.weaponclass = weaponclass(weapon);
  self.weaponmodel = getweaponmodel(weapon);
}

setprimaryweapon(weapon) {
  self.primaryweapon = weapon;
  self.primaryweaponclass = weaponclass(weapon);
}

setsecondaryweapon(weapon) {
  self.secondaryweapon = weapon;
  self.secondaryweaponclass = weaponclass(weapon);
}

isincombat() {
  if(isvalidenemy(self.enemy)) {
    self.a.combatendtime = gettime() + anim.combatmemorytimeconst + randomint(anim.combatmemorytimerand);
    return true;
  }

  return self.a.combatendtime > gettime();
}

holdingweapon() {
  if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none")
    return 0;

  if(!isDefined(self.holdingweapon))
    return 1;

  return self.holdingweapon;
}

getenemyeyepos() {
  if(isvalidenemy(self.enemy)) {
    self.a.lastenemypos = self.enemy getshootatpos();
    self.a.lastenemytime = gettime();
    return self.a.lastenemypos;
  } else if(isDefined(self.a.lastenemytime) && isDefined(self.a.lastenemypos) && self.a.lastenemytime + 3000 < gettime())
    return self.a.lastenemypos;
  else {
    targetpos = self getshootatpos();
    targetpos = targetpos + (196 * self.lookforward[0], 196 * self.lookforward[1], 196 * self.lookforward[2]);
    return targetpos;
  }
}

getnodeforwardyaw(node) {
  type = node.type;

  if(type == "Cover Left")
    return node.angles[1] + 90;
  else if(type == "Cover Right")
    return node.angles[1] - 90;
  else if(type == "Cover Pillar") {
    if(usingpistol()) {
      if(self.a.script == "cover_left")
        return node.angles[1] + 90;
      else
        return node.angles[1] - 90;
    } else
      return node.angles[1] - 180;
  }

  return node.angles[1];
}

getnodeyawtoenemy() {
  pos = undefined;

  if(isvalidenemy(self.enemy))
    pos = self.enemy.origin;
  else {
    if(isDefined(self.node))
      forward = anglestoforward(self.node.angles);
    else
      forward = anglestoforward(self.angles);

    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }

  if(isDefined(self.node))
    yaw = self.node.angles[1] - vectortoangles(pos - self.origin)[1];
  else
    yaw = self.angles[1] - vectortoangles(pos - self.origin)[1];

  yaw = angleclamp180(yaw);
  return yaw;
}

getyawtospot(spot) {
  pos = spot;
  yaw = self.angles[1] - vectortoangles(pos - self.origin)[1];
  yaw = angleclamp180(yaw);
  return yaw;
}

getyawtoenemy() {
  pos = undefined;

  if(isvalidenemy(self.enemy))
    pos = self.enemy.origin;
  else {
    forward = anglestoforward(self.angles);
    forward = vectorscale(forward, 150);
    pos = self.origin + forward;
  }

  yaw = self.angles[1] - vectortoangles(pos - self.origin)[1];
  yaw = angleclamp180(yaw);
  return yaw;
}

getyawtoorigin(org) {
  yaw = self.angles[1] - vectortoangles(org - self.origin)[1];
  yaw = angleclamp180(yaw);
  return yaw;
}

isstanceallowedwrapper(stance) {
  if(isDefined(self.covernode))
    return self.covernode doesnodeallowstance(stance);

  return self isstanceallowed(stance);
}

choosepose(preferredpose) {
  if(!isDefined(preferredpose))
    preferredpose = self.a.pose;

  if(enemieswithinstandingrange())
    preferredpose = "stand";

  switch (preferredpose) {
    case "stand":
      if(self isstanceallowedwrapper("stand"))
        resultpose = "stand";
      else if(self isstanceallowedwrapper("crouch"))
        resultpose = "crouch";
      else if(self isstanceallowedwrapper("prone"))
        resultpose = "prone";
      else {
        println("No stance allowed!Remaining standing.");

        resultpose = "stand";
      }

      break;
    case "crouch":
      if(self isstanceallowedwrapper("crouch"))
        resultpose = "crouch";
      else if(self isstanceallowedwrapper("stand"))
        resultpose = "stand";
      else if(self isstanceallowedwrapper("prone"))
        resultpose = "prone";
      else {
        println("No stance allowed!Remaining crouched.");

        resultpose = "crouch";
      }

      break;
    case "prone":
      if(self isstanceallowedwrapper("prone"))
        resultpose = "prone";
      else if(self isstanceallowedwrapper("crouch"))
        resultpose = "crouch";
      else if(self isstanceallowedwrapper("stand"))
        resultpose = "stand";
      else {
        println("No stance allowed!Remaining prone.");

        resultpose = "prone";
      }

      break;
    default:

      println("utility::choosePose, called in " + self.a.script + " script: Unhandled anim_pose " + self.a.pose + " - using stand.");

      resultpose = "stand";
      break;
  }

  return resultpose;
}

weaponanims() {
  if(isDefined(self.holdingweapon) && !self.holdingweapon || self.weaponmodel == "")
    return "none";

  if(self.weapon == "none")
    assert(self.weaponclass == "none");

  switch (self.weaponclass) {
    case "gas":
    case "grenade":
    case "pistol":
    case "rifle":
    case "rocketlauncher":
    case "spread":
      return self.weaponclass;
    case "smg":
      if(isDefined(self.a.userifleanimsforsmg) && self.a.userifleanimsforsmg)
        return "rifle";

      if(isDefined(self.a.fakepistolweaponanims) && self.a.fakepistolweaponanims && self holdingweapon()) {
        switch (self.weapon) {
          case "mp5k_sp":
          case "vector_sp":
            if(isDefined(self.a.fakepistolweaponanims) && self.a.fakepistolweaponanims)
              return "pistol";
        }
      }

      return "smg";
    case "mg":
      if(isDefined(level.supportsmganimations) && level.supportsmganimations)
        return "mg";

      return "rifle";
    default:
      return "rifle";
  }
}

getclaimednode() {
  mynode = self.node;

  if(isDefined(mynode) && (self nearnode(mynode) || isDefined(self.covernode) && mynode == self.covernode))
    return mynode;

  return undefined;
}

angleclamp(angle) {
  anglefrac = angle / 360.0;
  angle = (anglefrac - floor(anglefrac)) * 360.0;
  return angle;
}

quadrantanimweights(yaw) {
  forwardweight = (90 - abs(yaw)) / 90;
  leftweight = (90 - absangleclamp180(abs(yaw - 90))) / 90;
  result["front"] = 0;
  result["right"] = 0;
  result["back"] = 0;
  result["left"] = 0;

  if(isDefined(self.alwaysrunforward)) {
    assert(self.alwaysrunforward);
    result["front"] = 1;
    return result;
  }

  if(forwardweight > 0) {
    if(leftweight > forwardweight)
      result["left"] = 1;
    else if(leftweight < -1 * forwardweight)
      result["right"] = 1;
    else
      result["front"] = 1;
  } else {
    backweight = -1 * forwardweight;

    if(leftweight > backweight)
      result["left"] = 1;
    else if(leftweight < forwardweight)
      result["right"] = 1;
    else
      result["back"] = 1;
  }

  quadrantanimweightsdebuginfo(result);

  return result;
}

getquadrant(angle) {
  angle = angleclamp(angle);

  if(angle < 45 || angle > 315)
    quadrant = "front";
  else if(angle < 135)
    quadrant = "left";
  else if(angle < 225)
    quadrant = "back";
  else
    quadrant = "right";

  return quadrant;
}

getenemysightpos() {
  assert(self.goodshootposvalid);
  return self.goodshootpos;
}

shootenemywrapper() {
  self shoot_notify_wrapper();

  if(weaponisgasweapon(self.weapon))
    [[anim.shootflamethrowerwrapper_func]]();
  else
    [
      [anim.shootenemywrapper_func]
    ]();
}

getnodedirection() {
  mynode = getclaimednode();

  if(isDefined(mynode))
    return mynode.angles[1];

  return self.desiredangle;
}

getnodeorigin() {
  mynode = getclaimednode();

  if(isDefined(mynode))
    return mynode.origin;

  return self.origin;
}

hasenemysightpos() {
  if(isDefined(self.node))
    return canseeenemyfromexposed() || cansuppressenemyfromexposed();
  else
    return canseeenemy() || cansuppressenemy();
}

shootenemywrapper_normal() {
  self.a.lastshoottime = gettime();
  maps\_gameskill::set_accuracy_based_on_situation();
  animscripts\shoot_behavior::showsniperglint();
  self shoot(self.script_accuracy);
}

shootflamethrowerwrapper_normal() {
  self.a.lastshoottime = gettime();
  maps\_gameskill::set_accuracy_based_on_situation();

  if(!self.a.flamethrowershootswitch && self.a.lastshoottime > self.a.flamethrowershootswitchtimer) {
    self.a.flamethrowershootswitch = 1;
    self.a.flamethrowershootswitchtimer = self.a.lastshoottime + randomintrange(self.a.flamethrowershoottime_min, self.a.flamethrowershoottime_max);
    self shoot(self.script_accuracy);
  } else if(self.a.flamethrowershootswitch && self.a.lastshoottime > self.a.flamethrowershootswitchtimer) {
    self.a.flamethrowershootswitch = 0;
    flamethrower_stop_shoot();
    self.a.flamethrowershootswitchtimer = self.a.lastshoottime + randomintrange(self.a.flamethrowershootdelay_min, self.a.flamethrowershootdelay_max);
  }
}

flamethrower_stop_shoot(set_switch_timer) {
  if(weaponisgasweapon(self.weapon)) {
    if(isDefined(set_switch_timer)) {
      self.a.flamethrowershootswitchtimer = gettime() + set_switch_timer;
      self.a.flamethrowershootswitch = 0;
    }

    self notify("flame stop shoot");
    self stopshoot();
  }
}

shootposwrapper(shootpos) {
  self shoot_notify_wrapper();
  endpos = bulletspread(self gettagorigin("tag_flash"), shootpos, 4);
  self.a.lastshoottime = gettime();
  self shoot(1, endpos);
}

setenv(env) {
  if(env == "cold") {
    array_thread(getaiarray(), ::personalcoldbreath);
    array_thread(getspawnerarray(), ::personalcoldbreathspawner);
  }
}

personalcoldbreath() {
  tag = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  for(;;) {
    if(self.a.movement != "run") {
      playfxontag(level._effect["cold_breath"], self, tag);
      wait(2.5 + randomfloat(3));
      continue;
    }

    wait 0.5;
  }
}

personalcoldbreathspawner() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  for(;;) {
    self waittill("spawned", spawn);

    if(maps\_utility::spawn_failed(spawn)) {
      continue;
    }
    spawn thread personalcoldbreath();
  }
}

issuppressedwrapper() {
  if(!isDefined(self.a))
    return 0;

  if(shouldforcebehavior("cover_suppressed"))
    return 1;

  if(isDefined(self.covernode) && isDefined(self.playeraimsuppression) && self.playeraimsuppression) {
    recordenttext("Is Aim Suppressed", self, level.color_debug["white"], "Suppression");

    return 1;
  }

  if(isDefined(self.a.favor_suppressedbehavior) && self.a.favor_suppressedbehavior) {
    if(self.suppressionmeter > self.suppressionthreshold * 0.25)
      return 1;
  }

  if(isDefined(self.suppressionthreshold) && self.suppressionmeter <= self.suppressionthreshold)
    return 0;

  return self issuppressed();
}

ispartiallysuppressedwrapper() {
  if(shouldforcebehavior("cover_suppressed"))
    return 1;

  if(isDefined(self.covernode) && isDefined(self.playeraimsuppression) && self.playeraimsuppression) {
    recordenttext("Is Aim Suppressed", self, level.color_debug["white"], "Suppression");

    return 1;
  }

  if(isDefined(self.suppressionthreshold) && self.suppressionmeter <= self.suppressionthreshold * 0.25)
    return 0;

  return self issuppressed();
}

recentlysawenemy() {
  return isDefined(self.enemy) && self seerecently(self.enemy, 5);
}

canseeenemy() {
  if(!isvalidenemy(self.enemy))
    return false;

  if(self cansee(self.enemy) && checkpitchvisibility(self geteye(), self.enemy getshootatpos()) || isDefined(self.cansee_override) && self.cansee_override) {
    self.goodshootposvalid = 1;
    self.goodshootpos = getenemyeyepos();
    dontgiveuponsuppressionyet();
    return true;
  } else {
    self.goodshootposvalid = 0;
    return false;
  }
}

canseeenemyfromexposed() {
  if(!isvalidenemy(self.enemy)) {
    self.goodshootposvalid = 0;
    return 0;
  }

  enemyeye = getenemyeyepos();

  if(!isDefined(self.node))
    result = self cansee(self.enemy);
  else
    result = canseepointfromexposedatnode(enemyeye, self.node);

  if(result) {
    self.goodshootposvalid = 1;
    self.goodshootpos = enemyeye;
    dontgiveuponsuppressionyet();
  }

  return result;
}

getnodeoffset(node) {
  cover_left_crouch_offset = (-26, 0.4, 36);
  cover_left_stand_offset = (-32, 7, 63);
  cover_right_crouch_offset = (43.5, 11, 36);
  cover_right_stand_offset = (36, 8.3, 63);
  cover_crouch_offset = (3.5, -12.5, 45);
  cover_stand_offset = (-3.7, -22, 63);
  nodeoffset = (0, 0, 0);
  right = anglestoright(node.angles);
  forward = anglestoforward(node.angles);

  switch (node.type) {
    case "Cover Left":
      if(node gethighestnodestance() == "crouch" || self.a.pose == "crouch")
        nodeoffset = calculatenodeoffset(right, forward, cover_left_crouch_offset);
      else
        nodeoffset = calculatenodeoffset(right, forward, cover_left_stand_offset);

      break;
    case "Cover Right":
      if(node gethighestnodestance() == "crouch" || self.a.pose == "crouch")
        nodeoffset = calculatenodeoffset(right, forward, cover_right_crouch_offset);
      else
        nodeoffset = calculatenodeoffset(right, forward, cover_right_stand_offset);

      break;
    case "Cover Pillar":
      nodeoffsets = [];

      if(node gethighestnodestance() == "crouch" || self.a.pose == "crouch") {
        assert(!node has_spawnflag(1024) || !node has_spawnflag(2048));

        if(!node has_spawnflag(1024))
          nodeoffsets[nodeoffsets.size] = (-28, -10, 30);

        if(!node has_spawnflag(2048))
          nodeoffsets[nodeoffsets.size] = (32, -10, 30);
      } else {
        assert(!node has_spawnflag(1024) || !node has_spawnflag(2048));

        if(!node has_spawnflag(1024))
          nodeoffsets[nodeoffsets.size] = (-32, 3.7, 60);

        if(!node has_spawnflag(2048))
          nodeoffsets[nodeoffsets.size] = (34, 0.2, 60);
      }

      if(nodeoffsets.size > 1 && isDefined(self.cornerdirection) && self.cornerdirection == "left")
        nodeoffset = calculatenodeoffset(right, forward, nodeoffsets[1]);
      else
        nodeoffset = calculatenodeoffset(right, forward, nodeoffsets[0]);

      break;
    case "Conceal Stand":
    case "Cover Stand":
    case "Turret":
      nodeoffset = calculatenodeoffset(right, forward, cover_stand_offset);
      break;
    case "Conceal Crouch":
    case "Cover Crouch":
    case "Cover Crouch Window":
      nodeoffset = calculatenodeoffset(right, forward, cover_crouch_offset);
      break;
  }

  node.offset = nodeoffset;
  return node.offset;
}

calculatenodeoffset(right, forward, baseoffset) {
  return vectorscale(right, baseoffset[0]) + vectorscale(forward, baseoffset[1]) + (0, 0, baseoffset[2]);
}

canseepointfromexposedatnode(point, node) {
  if(node.type == "Cover Left" || node.type == "Cover Right") {
    if(!self canseepointfromexposedatcorner(point, node))
      return false;
  }

  nodeoffset = getnodeoffset(node);
  lookfrompoint = node.origin + nodeoffset;

  if(getdvarint(#"_id_DB939FA2") == 1) {
    record3dtext(self.team, lookfrompoint, level.color_debug["red"], "Animscript");
    recordline(lookfrompoint, point, level.color_debug["red"], "Animscript", self);
  }

  if(!canseepointfromexposedatnodewithoffset(point, node, lookfrompoint))
    return false;

  return true;
}

canseepointfromexposedatcorner(point, node) {
  yaw = node getyawtoorigin(point);

  if(yaw > 60 || yaw < -60)
    return false;

  if(node.type == "Cover Left" && yaw > 14)
    return false;

  if(node.type == "Cover Right" && yaw < -12)
    return false;

  return true;
}

canseepointfromexposedatnodewithoffset(point, node, lookfrompoint) {
  if(!checkpitchvisibility(lookfrompoint, point, node))
    return 0;

  if(!sighttracepassed(lookfrompoint, point, 0, undefined)) {
    if(node.type == "Cover Crouch" || node.type == "Conceal Crouch") {
      lookfrompoint = vectorscale((0, 0, 1), 64.0) + node.origin;
      return sighttracepassed(lookfrompoint, point, 0, undefined);
    }

    return 0;
  }

  return 1;
}

checkpitchvisibility(frompoint, topoint, atnode) {
  pitch = angleclamp180(vectortoangles(topoint - frompoint)[0]);

  if(abs(pitch) > 45) {
    if(isDefined(atnode) && atnode.type != "Cover Crouch" && atnode.type != "Conceal Crouch")
      return false;

    if(pitch > 45 || pitch < anim.covercrouchleanpitch - 45) {
      dist = distancesquared(frompoint, topoint);

      if(pitch < 75 && dist < 4096)
        return true;

      return false;
    }
  }

  return true;
}

dontgiveuponsuppressionyet() {
  self.a.shouldresetgiveuponsuppressiontimer = 1;
}

updategiveuponsuppressiontimer() {
  if(!isDefined(self.a.shouldresetgiveuponsuppressiontimer))
    self.a.shouldresetgiveuponsuppressiontimer = 1;

  if(self.a.shouldresetgiveuponsuppressiontimer) {
    self.a.giveuponsuppressiontime = gettime() + randomintrange(15000, 30000);
    self.a.shouldresetgiveuponsuppressiontimer = 0;
  }
}

aisuppressai() {
  if(self.weapon == "none")
    return false;

  if(!self holdingweapon())
    return false;

  if(!self canattackenemynode())
    return false;

  shootpos = undefined;

  if(isDefined(self.enemy.node)) {
    nodeoffset = getnodeoffset(self.enemy.node);
    shootpos = self.enemy.node.origin + nodeoffset;
  } else
    shootpos = self.enemy getshootatpos();

  if(!self canshoot(shootpos))
    return false;

  if(self.a.script == "combat") {
    if(!sighttracepassed(self geteye(), self gettagorigin("tag_flash"), 0, undefined))
      return false;
  }

  self.goodshootposvalid = 1;
  self.goodshootpos = shootpos;
  return true;
}

cansuppressenemyfromexposed() {
  if(!hassuppressableenemy()) {
    self.goodshootposvalid = 0;
    return 0;
  }

  if(!isplayer(self.enemy))
    return aisuppressai();

  if(isDefined(self.node)) {
    if(self.node.type == "Cover Left" || self.node.type == "Cover Right") {
      if(!self canseepointfromexposedatcorner(self getenemyeyepos(), self.node))
        return 0;
    }

    nodeoffset = getnodeoffset(self.node);
    startoffset = self.node.origin + nodeoffset;
  } else if(holdingweapon())
    startoffset = self gettagorigin("tag_flash");
  else
    return 0;

  if(!checkpitchvisibility(startoffset, self.lastenemysightpos))
    return 0;

  return findgoodsuppressspot(startoffset);
}

cansuppressenemy() {
  if(!hassuppressableenemy()) {
    self.goodshootposvalid = 0;
    return 0;
  }

  startoffset = self gettagorigin("tag_flash");

  if(!isDefined(startoffset))
    return 0;

  if(!isplayer(self.enemy))
    return aisuppressai();

  if(!checkpitchvisibility(startoffset, self.lastenemysightpos))
    return 0;

  return findgoodsuppressspot(startoffset);
}

hassuppressableenemy() {
  if(!isvalidenemy(self.enemy))
    return 0;

  if(!isDefined(self.lastenemysightpos))
    return 0;

  updategiveuponsuppressiontimer();

  if(gettime() > self.a.giveuponsuppressiontime)
    return 0;

  if(!needrecalculatesuppressspot())
    return self.goodshootposvalid;

  return 1;
}

canseeandshootpoint(point) {
  if(!sighttracepassed(self getshootatpos(), point, 0, undefined))
    return 0;

  if(self.a.weaponpos["right"] == "none")
    return 0;

  gunpoint = self gettagorigin("tag_flash");
  return sighttracepassed(gunpoint, point, 0, undefined);
}

needrecalculatesuppressspot() {
  if(self.goodshootposvalid && !self canseeandshootpoint(self.goodshootpos))
    return true;

  return !isDefined(self.lastenemysightposold) || self.lastenemysightposold != self.lastenemysightpos || distancesquared(self.lastenemysightposselforigin, self.origin) > 1024;
}

findgoodsuppressspot(startoffset) {
  if(!needrecalculatesuppressspot())
    return self.goodshootposvalid;

  if(!sighttracepassed(self getshootatpos(), startoffset, 0, undefined)) {
    self.goodshootposvalid = 0;
    return 0;
  }

  self.lastenemysightposselforigin = self.origin;
  self.lastenemysightposold = self.lastenemysightpos;
  currentenemypos = getenemyeyepos();
  trace = bullettrace(self.lastenemysightpos, currentenemypos, 0, undefined);
  starttracesat = trace["position"];
  percievedmovementvector = self.lastenemysightpos - starttracesat;
  lookvector = vectornormalize(self.lastenemysightpos - startoffset);
  percievedmovementvector = percievedmovementvector - vectorscale(lookvector, vectordot(percievedmovementvector, lookvector));
  numtraces = int(length(percievedmovementvector) / 20.0 + 0.5);

  if(numtraces < 1)
    numtraces = 1;

  if(numtraces > 20)
    numtraces = 20;

  vectordif = self.lastenemysightpos - starttracesat;
  vectordif = (vectordif[0] / numtraces, vectordif[1] / numtraces, vectordif[2] / numtraces);
  numtraces++;
  traceto = starttracesat;

  if(getdebugdvarint("debug_dotshow") == self getentnum()) {
    thread print3dtime(15, self.lastenemysightpos, "lastpos", (1, 0.2, 0.2), 1, 0.75);
    thread print3dtime(15, starttracesat, "currentpos", (1, 0.2, 0.2), 1, 0.75);
  }

  self.goodshootposvalid = 0;
  goodtraces = 0;

  for(i = 0; i < numtraces + 2; i++) {
    tracepassed = sighttracepassed(startoffset, traceto, 0, undefined);
    thistraceto = traceto;

    if(getdebugdvarint("debug_dotshow") == self getentnum()) {
      if(tracepassed)
        color = (0.2, 0.2, 1);
      else
        color = vectorscale((1, 1, 1), 0.2);

      thread print3dtime(15, traceto, ".", color, 1, 0.75);
    }

    if(i == numtraces - 1)
      vectordif = vectordif - vectorscale(lookvector, vectordot(vectordif, lookvector));

    traceto = traceto + vectordif;

    if(tracepassed) {
      goodtraces++;
      self.goodshootposvalid = 1;
      self.goodshootpos = thistraceto;

      if(i > 0 && goodtraces < 2 && i < numtraces + 2 - 1) {
        continue;
      }
      return 1;
    } else
      goodtraces = 0;
  }

  return self.goodshootposvalid;
}

print3dtime(timer, org, msg, color, alpha, scale) {
  newtime = timer / 0.05;

  for(i = 0; i < newtime; i++) {
    print3d(org, msg, color, alpha, scale);
    wait 0.05;
  }

}

enterpronewrapper(timer) {
  thread enterpronewrapperproc(timer);
}

enterpronewrapperproc(timer) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self enterprone(timer);
  self waittill("killanimscript");

  if(self.a.pose != "prone")
    self.a.pose = "prone";
}

exitpronewrapper(timer) {
  thread exitpronewrapperproc(timer);
}

exitpronewrapperproc(timer) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self exitprone(timer);
  self waittill("killanimscript");

  if(self.a.pose == "prone")
    self.a.pose = "crouch";
}

gethighestnodestance() {
  if(self has_spawnflag(4)) {
    if(self has_spawnflag(8)) {
      if(self has_spawnflag(16)) {
        assertmsg("Node at" + self.origin + "supports no stance.");

      } else
        return "prone";
    } else
      return "crouch";
  } else
    return "stand";
}

doesnodeallowstance(stance) {
  if(stance == "stand")
    return !self has_spawnflag(4);
  else if(stance == "crouch")
    return !self has_spawnflag(8);
  else {
    assert(stance == "prone");
    return !self has_spawnflag(16);
  }
}

aihasweapon(weapon) {
  if(isDefined(weapon) && weapon != "" && isDefined(self.weaponinfo[weapon]))
    return true;

  return false;
}

aihasonlypistol() {
  holdingsmg = self.weaponclass == "smg";
  return self.primaryweapon == self.weapon && usingpistol() && !holdingsmg;
}

aihasonlypistolorsmg() {
  class = self.weaponclass;
  return self.primaryweapon == self.weapon && usingpistol();
}

getanimendpos(theanim) {
  movedelta = getmovedelta(theanim, 0, 1);
  return self localtoworldcoords(movedelta);
}

isvalidenemy(enemy) {
  if(!isDefined(enemy))
    return false;

  return true;
}

damagelocationisany(a, b, c, d, e, f, g, h, i, j, k, ovr) {
  if(!isDefined(self.damagelocation))
    return false;

  if(!isDefined(a))
    return false;

  if(self.damagelocation == a)
    return true;

  if(!isDefined(b))
    return false;

  if(self.damagelocation == b)
    return true;

  if(!isDefined(c))
    return false;

  if(self.damagelocation == c)
    return true;

  if(!isDefined(d))
    return false;

  if(self.damagelocation == d)
    return true;

  if(!isDefined(e))
    return false;

  if(self.damagelocation == e)
    return true;

  if(!isDefined(f))
    return false;

  if(self.damagelocation == f)
    return true;

  if(!isDefined(g))
    return false;

  if(self.damagelocation == g)
    return true;

  if(!isDefined(h))
    return false;

  if(self.damagelocation == h)
    return true;

  if(!isDefined(i))
    return false;

  if(self.damagelocation == i)
    return true;

  if(!isDefined(j))
    return false;

  if(self.damagelocation == j)
    return true;

  if(!isDefined(k))
    return false;

  if(self.damagelocation == k)
    return true;

  assert(!isDefined(ovr), "Too many parameters");
  return false;
}

usingrifle() {
  return self.weaponclass == "rifle";
}

usingshotgun() {
  return self.weaponclass == "spread";
}

usingrocketlauncher() {
  return self.weaponclass == "rocketlauncher";
}

usinggrenadelauncher() {
  return self.weaponclass == "grenade";
}

usingpistol() {
  return self weaponanims() == "pistol";
}

randomizeidleset() {
  idleanimarray = animarray("idle", "stop");
  self.a.idleset = randomint(idleanimarray.size);
}

weapon_spread() {
  return weaponclass(self.weapon) == "spread";
}

is_rusher() {
  return isDefined(self.rusher) && self.rusher;
}

is_heavy_machine_gun() {
  return isDefined(self.heavy_machine_gunner) && self.heavy_machine_gunner;
}

isbalconynode(node) {
  return isDefined(anim.balcony_node_types[node.type]) && (node has_spawnflag(1024) || node has_spawnflag(2048));
}

isbalconynodenorailing(node) {
  return isbalconynode(node) && node has_spawnflag(2048);
}

do_ragdoll_death() {
  assert(!(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield), "Cannot ragdoll death on guy with magic bullet shield.");
  self unlink();
  self startragdoll();

  if(isDefined(self.overrideactordamage))
    self.overrideactordamage = undefined;

  if(isai(self))
    self.a.doingragdolldeath = 1;

  wait 0.1;

  if(isalive(self)) {
    if(isai(self)) {
      self.a.nodeath = 1;
      self.a.doingragdolldeath = 1;
      self animscripts\shared::dropallaiweapons();
    }

    self.allowdeath = 1;
    self setcandamage(1);
    self dodamage(self.health + 100, self.origin, self.attacker);
  }
}

become_corpse() {
  assert(!(isDefined(self.magic_bullet_shield) && self.magic_bullet_shield), "Guy with magic bullet shield cannot become corpse.");

  if(isai(self)) {
    self.a.nodeath = 1;
    self.allowdeath = 1;
    self.a.doingragdolldeath = 1;
    self animmode("nophysics");
    self thread setanimmode("nophysics", 0.05);
    self animscripts\shared::dropallaiweapons();
  }

  self setcandamage(1);
  self.do_ragdoll_death = 0;
  self dodamage(self.health + 100, self.origin);
}

setlookatentity(ent) {
  self lookatentity(ent);
  self.looking_at_entity = 1;
}

stoplookingatentity() {
  if(!(isDefined(self.lookat_set_in_anim) && self.lookat_set_in_anim))
    self lookatentity();

  self.looking_at_entity = 0;
}

idlelookatbehaviortidyup() {
  self waittill_either("killanimscript", "newLookAtBehavior");

  self animscripts\debug::debugpopstate("idleLookatBehavior");

  if(isDefined(self))
    self stoplookingatentity();
}

isoktolookatentity() {
  if(isDefined(level._dont_look_at_player) && level._dont_look_at_player)
    return false;

  if(isDefined(self.lookat_set_in_anim) && self.lookat_set_in_anim)
    return false;

  if(isDefined(self.covernode) && isDefined(self.covernode.script_dont_look))
    return false;

  if(isDefined(self.covernode) && isDefined(self.a.script) && (self.a.script == "cover_right" || self.a.script == "cover_left") && self.a.pose == "crouch")
    return false;

  return true;
}

entityinfront(origin) {
  forward = anglestoforward(self.angles);
  dot = vectordot(forward, vectornormalize(origin - self.origin));
  return dot > 0.3;
}

idlelookatbehavior(dist_thresh, dot_check) {
  self notify("newLookAtBehavior");
  self endon("newLookAtBehavior");

  if(!(isDefined(level.idlelookatfeatureenabled) && level.idlelookatfeatureenabled)) {
    return;
  }
  if(self.team != "allies") {
    return;
  }
  self animscripts\debug::debugpushstate("idleLookatBehavior");

  self endon("killanimscript");
  self thread idlelookatbehaviortidyup();
  dist_thresh = dist_thresh * dist_thresh;
  looking = 0;
  flag_wait("all_players_connected");
  wait(randomfloatrange(0.05, 0.1));

  while(true) {
    if(self animscripts\utility::isincombat() || !isoktolookatentity())
      self stoplookingatentity();

    dot_check_passed = 1;
    player = get_players()[0];

    if(isDefined(dot_check) && dot_check && !self entityinfront(player.origin))
      dot_check_passed = 0;

    player_dist = distancesquared(self.origin, player.origin);

    if((player_dist > dist_thresh || !dot_check_passed) && looking) {
      self stoplookingatentity();
      looking = 0;
    } else if(player_dist < dist_thresh && !looking && dot_check_passed) {
      self setlookatentity(player);
      looking = 1;
    }

    wait 1.0;

    self animscripts\debug::debugpopstate();

  }
}

getanimdirection(damageyaw) {
  if(damageyaw > 135 || damageyaw <= -135)
    return "front";
  else if(damageyaw > 45 && damageyaw <= 135)
    return "right";
  else if(damageyaw > -45 && damageyaw <= 45)
    return "back";
  else
    return "left";

  return "front";
}

shouldforcebehavior(behavior) {
  switch (behavior) {
    case "cover_suppressed":
      return getdvarint(#"_id_1063EFAA");
    case "force_stand":
      return getdvarint(#"_id_4151075A") == 2;
    case "force_crouch":
      return getdvarint(#"_id_4151075A") == 3;
    case "force_corner_mode":
      forcedcornermode = getdvarint(#"_id_4A3A380B");

      switch (forcedcornermode) {
        case 2:
          return "A";
        case 3:
          return "B";
        case 4:
          return "lean";
        case 5:
          return "over";
        default:
          return "unsuported";
      }
    case "force_corner_direction":
      forcedcornerdirection = getdvarint(#"_id_140B3667");

      switch (forcedcornerdirection) {
        case 2:
          return "left";
        case 3:
          return "right";
        default:
          return "unsuported";
      }
    case "force_cheat_ammo":
      forcedcornerdirection = getdvarint(#"_id_028FFFAC");

      if(forcedcornerdirection > 1)
        return 1;
      else
        return 0;

      break;
    default:
      return getdvar(#"_id_DE8EB56D") == behavior;
  }

  return 0;
}

quadrantanimweightsdebuginfo(result) {
  if(getdvarint(#"_id_94D73B5A") > 0)
    recordenttext("Forward :" + result["front"] + "Left :" + result["left"] + "Right :" + result["right"] + "Back :" + result["back"], self, level.color_debug["green"], "Animscript");
}

checkgrenadeinhand(animscript) {
  self endon("killanimscript");

  if(animscript == "pain" || animscript == "death") {
    wait 0.05;
    waittillframeend;
  }

  attachsize = self getattachsize();

  for(i = 0; i < attachsize; i++) {
    model = tolower(self getattachmodelname(i));
    assert(model != "weapon_m67_grenade", "AI has a grenade in hand after animscript finished. Please call over an animscripter! " + self.origin);
    assert(model != "weapon_m84_flashbang_grenade", "AI has a grenade in hand after animscript finished. Please call over an animscripter! " + self.origin);
    assert(model != "weapon_us_smoke_grenade", "AI has a grenade in hand after animscript finished. Please call over an animscripter! " + self.origin);
  }

}

badplacer(time, org, radius) {
  for(i = 0; i < time * 20; i++) {
    for(p = 0; p < 10; p++) {
      angles = (0, randomint(360), 0);
      forward = anglestoforward(angles);
      scale = vectorscale(forward, radius);
      line(org, org + scale, (1, 0.3, 0.3));
    }

    wait 0.05;
  }

}

drawstring(stringtodraw) {
  self endon("killanimscript");
  self endon("enddrawstring");

  for(;;) {
    wait 0.05;
    print3d(self getdebugeye() + vectorscale((0, 0, 1), 8.0), stringtodraw, (1, 1, 1), 1, 0.2);
  }

}

drawstringtime(msg, org, color, timer) {
  maxtime = timer * 20;

  for(i = 0; i < maxtime; i++) {
    print3d(org, msg, color, 1, 1);
    wait 0.05;
  }

}

debugtimeout() {
  wait 5;
  self notify("timeout");
}

debugposinternal(org, string, size) {
  self endon("death");
  self notify("stop debug " + org);
  self endon("stop debug " + org);
  ent = spawnstruct();
  ent thread debugtimeout();
  ent endon("timeout");

  if(self.enemy.team == "allies")
    color = (0.4, 0.7, 1);
  else
    color = (1, 0.7, 0.4);

  while(true) {
    wait 0.05;
    print3d(org, string, color, 1, size);
  }

}

debugpos(org, string) {
  thread debugposinternal(org, string, 2.15);
}

debugpossize(org, string, size) {
  thread debugposinternal(org, string, size);
}

printshootproc() {
  self endon("death");
  self notify("stop shoot " + self.export);
  self endon("stop shoot " + self.export);

  for(i = 0; i < 0.25 * 20; i = i + 1) {
    wait 0.05;
    print3d(self.origin + vectorscale((0, 0, 1), 70.0), "Shoot", (1, 0, 0), 1, 1);
  }

}

showdebugproc(frompoint, topoint, color, printtime) {
  self endon("death");
  timer = printtime * 20;

  for(i = 0; i < timer; i = i + 1) {
    wait 0.05;
    line(frompoint, topoint, color);
  }

}

showdebugline(frompoint, topoint, color, printtime) {
  self thread showdebugproc(frompoint, topoint + vectorscale((0, 0, -1), 5.0), color, printtime);
}