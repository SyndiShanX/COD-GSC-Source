/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\utility.gsc
***********************************************/

#using_animtree("");

function initanimtree(var_0) {
  self clearanim(%body, 0.3);
  self setanim($body, 1, 0);

  if(var_0 != "pain" && var_0 != "death") {
    self.a.special = "none";
  }

  self.a.aimweight = 1;
  self.a.aimweight_start = 1;
  self.a.aimweight_end = 1;
  self.a.aimweight_transframes = 0;
  self.a.aimweight_t = 0;
  updateisincombattimer();
}

function updateanimpose() {
  if(isDefined(self.desired_anim_pose) && self.desired_anim_pose != self.currentpose) {
    if(self.currentpose == "prone") {
      exitpronewrapper(0.5);
    }

    if(self.desired_anim_pose == "prone") {
      self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
      enterpronewrapper(0.5);
      self setanimknoball(lookupanim("default_prone", "straight_level"), %body, 1, 0.1, 1);
    }
  }

  self.desired_anim_pose = undefined;
}

function initialize(var_0) {
  self endon("killanimscript");
  self waittill("Hellfreezesover");
}

function printdisplaceinfo() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");

  for(;;) {
    wait 0.05;
  }
}

function isincombat(var_0) {
  if((!isDefined(var_0) || var_0) && self.alertlevelint > 1) {
    return true;
  }

  if(isDefined(self.enemy)) {
    return true;
  }

  return self.a.combatendtime > gettime();
}

function updateisincombattimer() {
  if(isDefined(self.enemy)) {
    self.a.combatendtime = gettime() + anim.combatmemorytimeconst + randomint(anim.combatmemorytimerand);
    return;
  }
}

function notifyaftertime(var_0, var_1, var_2) {
  self endon("death");
  self endon(var_1);
  wait var_2;
  self notify(var_0);
}

function drawstring(var_0) {
  self endon("killanimscript");
  self endon("enddrawstring");

  for(;;) {
    wait 0.05;
  }
}

function drawstringtime(var_0, var_1, var_2, var_3) {
  var_4 = var_3 * 20;

  for(var_5 = 0; var_5 < var_4; var_5++) {
    wait 0.05;
  }
}

function showlastenemysightpos(var_0) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");

  if(!isDefined(self.enemy)) {
    return;
  }

  if(self.enemy.team == "allies") {
    var_1 = (0.4, 0.7, 1);
  } else {
    var_1 = (1, 0.7, 0.4);
  }

  for(;;) {
    wait 0.05;

    if(!isDefined(self.lastenemysightpos)) {}
  }
}

function hasenemysightpos() {
  if(isDefined(self.node)) {
    return (scripts\anim\utility_common::canseeenemyfromexposed() || scripts\anim\utility_common::cansuppressenemyfromexposed());
  }

  return scripts\anim\utility_common::canseeenemy() || scripts\anim\utility_common::cansuppressenemy();
}

function getenemysightpos() {
  return self.goodshootpos;
}

function debugtimeout() {
  wait 5;
  self notify("timeout");
}

function debugposinternal(var_0, var_1, var_2) {
  self endon("death");
  self notify("stop debug " + var_0);
  self endon("stop debug " + var_0);
  var_3 = spawnStruct();
  thread debugtimeout();
  var_3 endon("timeout");

  if(self.enemy.team == "allies") {
    var_4 = (0.4, 0.7, 1);
  } else {
    var_4 = (1, 0.7, 0.4);
  }

  for(;;) {
    wait 0.05;
  }
}

function debugpos(var_0, var_1) {
  thread debugposinternal(var_0, var_1, 2.15);
}

function debugpossize(var_0, var_1, var_2) {
  thread debugposinternal(var_0, var_1, var_2);
}

function debugburstprint(var_0, var_1) {
  var_2 = var_0 / var_1;
  var_3 = undefined;

  if(var_0 == self.bulletsinclip) {
    var_3 = "all rounds";
  } else if(var_2 < 0.25) {
    var_3 = "small burst";
  } else if(var_2 < 0.5) {
    var_3 = "med burst";
  } else {
    var_3 = "long burst";
  }

  thread debugpossize(self.origin + (0, 0, 42), var_3, 1.5);
  thread debugpos(self.origin + (0, 0, 60), "Suppressing");
}

function printshootproc() {
  self endon("death");
  self notify("stop shoot " + self.export);
  self endon("stop shoot " + self.export);
  var_0 = 0.25;
  var_1 = var_0 * 20;
  var_2 = 0;

  while(var_2 < var_1) {
    wait 0.05;
    var_2 += 1;
  }
}

function printshoot() {}

function showdebugproc(var_0, var_1, var_2, var_3) {
  self endon("death");
  var_4 = var_3 * 20;
  var_5 = 0;

  while(var_5 < var_4) {
    wait 0.05;
    var_5 += 1;
  }
}

function showdebugline(var_0, var_1, var_2, var_3) {
  thread showdebugproc(var_0, var_1 + (0, 0, -5), var_2, var_3);
}

function shootenemywrapper_normal(var_0) {
  self.a.lastshoottime = gettime();
  scripts\common\gameskill::set_accuracy_based_on_situation();
  self notify("shooting");

  if(scripts\anim\utility_common::isasniper() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
    self shoot(1, self._blackboard.shootparams_pos, 1, 0, 1);
    return;
  }

  if(isagent(self)) {
    var_0 = 1;
  }

  self shoot(1, undefined, var_0);
}

function shootenemywrapper_shootnotify(var_0) {
  level notify("an_enemy_shot", self);
  shootenemywrapper_normal(var_0);
}

function shootposwrapper(var_0, var_1) {
  self.a.lastshoottime = gettime();

  if(!isDefined(var_1)) {
    var_1 = 1;
  }

  self notify("shooting");

  if(scripts\anim\utility_common::isasniper()) {
    self shoot(1, var_0, 1, 1, 1);
    return;
  }

  var_2 = 0;

  if(isDefined(self.enemy) && istrue(self.enemy.underlowcover)) {
    var_2 = 1;
  }

  var_3 = bulletspread(self getmuzzlepos(), var_0, 4);
  self shoot(1, var_3, var_1, var_2);
}

function throwgun() {
  var_0 = spawn("script_model", (0, 0, 0));
  var_0 setModel("temp");
  var_0.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  var_0.angles = self gettagangles("tag_weapon_right");
  var_1 = anglestoright(var_0.angles);
  var_1 *= 15;
  var_2 = anglesToForward(var_0.angles);
  var_2 *= 15;
  var_0 movegravity((0, 50, 150), 100);
  var_3 = "weapon_" + createheadicon(self.weapon);
  var_4 = spawn(var_3, var_0.origin);
  var_4.angles = self gettagangles("tag_weapon_right");
  var_4 linkTo(var_0);
  var_5 = var_0.origin;

  while(isDefined(var_4) && isDefined(var_4.origin)) {
    var_6 = var_5;
    var_7 = var_0.origin;
    var_8 = vectortoangles(var_7 - var_6);
    var_2 = anglesToForward(var_8);
    var_2 *= 4;
    var_9 = scripts\engine\trace::_bullet_trace(var_7, var_7 + var_2, 1, var_4);

    if(isalive(var_9["entity"]) && var_9["entity"] == self) {
      wait 0.05;
      continue;
    }

    if(var_9["fraction"] < 1) {
      break;
    }

    var_5 = var_0.origin;
    wait 0.05;
  }

  if(isDefined(var_4) && isDefined(var_4.origin)) {
    var_4 unlink();
  }

  var_0 delete();
}

function personalcoldbreath() {
  var_0 = "TAG_EYE";
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  while(isDefined(self)) {
    wait 0.05;

    if(!isDefined(self)) {
      break;
    }

    if(isDefined(self.a.movement) && self.a.movement == "stop") {
      if(isDefined(self.isindoor) && self.isindoor == 1) {
        continue;
      }

      playFXOnTag(level._effect["cold_breath"], self, var_0);
      wait 2.5 + randomfloat(3);
      continue;
    }

    wait 0.5;
  }
}

function ispartiallysuppressedwrapper() {
  if(self.suppressionmeter <= self.suppressionthreshold * 0.25) {
    return 0;
  }

  return self issuppressed();
}

function showlines(var_0, var_1, var_2) {
  for(;;) {
    wait 0.05;
    wait 0.05;
  }
}

function anim_array(var_0, var_1) {
  var_2 = var_0.size;
  var_3 = randomint(var_2);

  if(var_2 == 1) {
    return var_0[0];
  }

  var_4 = 0;
  var_5 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_5 += var_1[var_6];
  }

  var_7 = randomfloat(var_5);
  var_8 = 0;

  for(var_6 = 0; var_6 < var_2; var_6++) {
    var_8 += var_1[var_6];

    if(var_7 >= var_8) {
      continue;
    }

    var_3 = var_6;
    break;
  }

  return var_0[var_3];
}

function canthrowgrenade() {
  if(!self.grenadeammo) {
    return 0;
  }

  if(self.script_forcegrenade) {
    return 1;
  }

  return isPlayer(self.enemy);
}

function usingboltactionweapon() {
  return weaponisboltaction(self.weapon);
}

function random_weight(var_0) {
  var_1 = randomint(var_0.size);

  if(var_0.size > 1) {
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 += var_0[var_3];
    }

    var_4 = randomfloat(var_2);
    var_2 = 0;

    for(var_3 = 0; var_3 < var_0.size; var_3++) {
      var_2 += var_0[var_3];

      if(var_4 < var_2) {
        var_1 = var_3;
        break;
      }
    }
  }

  return var_1;
}

function setfootstepeffect(var_0, var_1, var_2) {
  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  anim.optionalstepeffects[var_1] = 1;
  level._effect["step_" + var_1][var_0] = var_2;
}

function setfootstepeffectsmall(var_0, var_1, var_2) {
  if(!isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  anim.optionalstepeffectssmall[var_1] = 1;
  level._effect["step_small_" + var_1][var_0] = var_2;
}

function setfootprinteffect(var_0, var_1, var_2) {
  if(!isDefined(anim.optionalfootprinteffects)) {
    anim.optionalfootprinteffects = [];
  }

  if(!isDefined(anim.flirfootprinteffects)) {
    anim.flirfootprinteffects = 0;
  }

  anim.optionalfootprinteffects[var_1] = 1;
  level._effect["footprint_" + var_1][var_0] = var_2;
}

function unsetfootstepeffect(var_0) {
  if(isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects[var_0] = undefined;
  }

  level._effect["step_" + var_0] = undefined;
}

function unsetfootstepeffectsmall(var_0) {
  if(isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall[var_0] = undefined;
  }

  level._effect["step_small_" + var_0] = undefined;
}

function unsetfootprinteffect(var_0) {
  if(isDefined(anim.optionalfootprinteffects)) {
    anim.optionalfootprinteffects[var_0] = undefined;
  }

  level._effect["footprint_" + var_0] = undefined;
}

function setnotetrackeffect(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_2)) {
    var_2 = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  level._notetrackfx[var_0][var_2] = spawnStruct();
  level._notetrackfx[var_0][var_2].tag = var_1;
  level._notetrackfx[var_0][var_2].fx = var_3;
  setnotetracksound(var_0, var_2, var_4, var_5);
}

function setnotetracksound(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_1)) {
    var_1 = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  if(isDefined(level._notetrackfx[var_0][var_1])) {
    var_4 = level._notetrackfx[var_0][var_1];
  } else {
    var_4 = spawnStruct();
    level._notetrackfx[var_1][var_2] = var_4;
  }

  if(isDefined(var_3)) {
    var_4.sound_prefix = var_3;
  }

  if(isDefined(var_4)) {
    var_4.sound_suffix = var_4;
    return;
  }
}

function enterpronewrapper(var_0) {
  thread enterpronewrapperproc(var_0);
}

function enterpronewrapperproc(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self enterprone(var_0, isDefined(self.a.onback));
  self waittill("killanimscript");

  if(self.currentpose != "prone" && !isDefined(self.a.onback)) {
    self.currentpose = "prone";
    return;
  }
}

function stoponback() {
  exitpronewrapper(1);
  self.a.onback = undefined;
}

function exitpronewrapper(var_0) {
  thread exitpronewrapperproc(var_0);
}

function exitpronewrapperproc(var_0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self exitprone(var_0);
  self waittill("killanimscript");

  if(self.currentpose == "prone") {
    self.currentpose = "crouch";
    return;
  }
}

function animarray(var_0) {
  return self.a.array[var_0];
}

function animarrayanyexist(var_0) {
  return isDefined(self.a.array[var_0]) && self.a.array[var_0].size > 0;
}

function animarraypickrandom(var_0) {
  var_1 = randomint(self.a.array[var_0].size);
  return self.a.array[var_0][var_1];
}

function array(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13) {
  var_14 = [];

  if(isDefined(var_0)) {
    GscBinSkip0(0x2e, 0, var_0);
  }

  return var_14;
}

function getaiprimaryweapon() {
  return self.primaryweapon;
}

function getaisecondaryweapon() {
  return self.secondaryweapon;
}

function getaisidearmweapon() {
  return self.sidearm;
}

function getaicurrentweapon() {
  return self.weapon;
}

function getaicurrentweaponslot() {
  if(self.weapon == self.primaryweapon) {
    return "primary";
  }

  if(self.weapon == self.secondaryweapon) {
    return "secondary";
  }

  if(self.weapon == self.sidearm) {
    return "sidearm";
  }
}

function aihasweapon(var_0) {
  var_1 = createheadicon(var_0);

  if(isDefined(self.weaponinfo[var_1])) {
    return true;
  }

  return false;
}

function getanimendpos(var_0) {
  var_1 = getmovedelta(var_0, 0, 1);
  return self localtoworldcoords(var_1);
}

function ragdolldeath(var_0) {
  self endon("killanimscript");
  var_1 = self.origin;
  var_2 = (0, 0, 0);

  for(;;) {
    wait 0.05;
    var_3 = distance(self.origin, var_1);
    var_1 = self.origin;

    if(self.health == 1) {
      self.a.nodeath = 1;
      self startragdoll();
      self clearanim(var_0, 0.1);
      wait 0.05;
      physicsexplosionsphere(var_1, 600, 0, var_3 * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

function shouldcqb() {
  return iscqbwalking() && !isDefined(self.grenade);
}

function iscqbwalking() {
  return isDefined(self.demeanoroverride) && self.demeanoroverride == "cqb";
}

function iscqbwalkingorfacingenemy() {
  return !self.facemotion || iscqbwalking();
}

function randomizeidleset() {
  self.a.idleset = randomint(2);
}

function getrandomintfromseed(var_0, var_1) {
  var_2 = var_0 % anim.randominttablesize;
  return anim.randominttable[var_2] % var_1;
}

function getcurrentweaponslotname() {
  if(scripts\anim\utility_common::isusingsecondary()) {
    return "secondary";
  }

  if(scripts\anim\utility_common::isusingsidearm()) {
    return "sidearm";
  }

  return "primary";
}

function lookupanim(var_0, var_1) {
  if(isDefined(self.animarchetype)) {
    if(isDefined(anim.archetypes[self.animarchetype][var_0]) && isDefined(anim.archetypes[self.animarchetype][var_0][var_1])) {
      return anim.archetypes[self.animarchetype][var_0][var_1];
    }
  }

  return anim.archetypes["soldier"][var_0][var_1];
}

function lookupanimarray(var_0) {
  if(isDefined(self.animarchetype)) {
    if(isDefined(anim.archetypes[self.animarchetype][var_0])) {
      var_1 = anim.archetypes["soldier"][var_0];

      foreach(var_3 in anim.archetypes[self.animarchetype][var_0]) {
        var_1 = var_3;
      }

      return var_1;
    }
  }

  return anim.archetypes["soldier"][var_4];
}

function isenergyweapon(var_0) {
  return weaponusesenergybullets(var_0);
}