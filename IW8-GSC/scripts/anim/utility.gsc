/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\utility.gsc
***********************************************/

#using_animtree("");

function initanimtree(var0) {
  self clearanim(%body, 0.3);
  self setanim($body, 1, 0);

  if(var0 != "pain" && var0 != "death") {
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

function initialize(var0) {
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

function isincombat(var0) {
  if((!isDefined(var0) || var0) && self.alertlevelint > 1) {
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

function notifyaftertime(var0, var1, var2) {
  self endon("death");
  self endon(var1);
  wait var2;
  self notify(var0);
}

function drawstring(var0) {
  self endon("killanimscript");
  self endon("enddrawstring");

  for(;;) {
    wait 0.05;
  }
}

function drawstringtime(var0, var1, var2, var3) {
  var4 = var3 * 20;

  for(var5 = 0; var5 < var4; var5++) {
    wait 0.05;
  }
}

function showlastenemysightpos(var0) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");

  if(!isDefined(self.enemy)) {
    return;
  }

  if(self.enemy.team == "allies") {
    var1 = (0.4, 0.7, 1);
  } else {
    var1 = (1, 0.7, 0.4);
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

function debugposinternal(var0, var1, var2) {
  self endon("death");
  self notify("stop debug " + var0);
  self endon("stop debug " + var0);
  var3 = spawnStruct();
  thread debugtimeout();
  var3 endon("timeout");

  if(self.enemy.team == "allies") {
    var4 = (0.4, 0.7, 1);
  } else {
    var4 = (1, 0.7, 0.4);
  }

  for(;;) {
    wait 0.05;
  }
}

function debugpos(var0, var1) {
  thread debugposinternal(var0, var1, 2.15);
}

function debugpossize(var0, var1, var2) {
  thread debugposinternal(var0, var1, var2);
}

function debugburstprint(var0, var1) {
  var2 = var0 / var1;
  var3 = undefined;

  if(var0 == self.bulletsinclip) {
    var3 = "all rounds";
  } else if(var2 < 0.25) {
    var3 = "small burst";
  } else if(var2 < 0.5) {
    var3 = "med burst";
  } else {
    var3 = "long burst";
  }

  thread debugpossize(self.origin + (0, 0, 42), var3, 1.5);
  thread debugpos(self.origin + (0, 0, 60), "Suppressing");
}

function printshootproc() {
  self endon("death");
  self notify("stop shoot " + self.export);
  self endon("stop shoot " + self.export);
  var0 = 0.25;
  var1 = var0 * 20;
  var2 = 0;

  while(var2 < var1) {
    wait 0.05;
    var2 += 1;
  }
}

function printshoot() {}

function showdebugproc(var0, var1, var2, var3) {
  self endon("death");
  var4 = var3 * 20;
  var5 = 0;

  while(var5 < var4) {
    wait 0.05;
    var5 += 1;
  }
}

function showdebugline(var0, var1, var2, var3) {
  thread showdebugproc(var0, var1 + (0, 0, -5), var2, var3);
}

function shootenemywrapper_normal(var0) {
  self.a.lastshoottime = gettime();
  scripts\common\gameskill::set_accuracy_based_on_situation();
  self notify("shooting");

  if(scripts\anim\utility_common::isasniper() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
    self shoot(1, self._blackboard.shootparams_pos, 1, 0, 1);
    return;
  }

  if(isagent(self)) {
    var0 = 1;
  }

  self shoot(1, undefined, var0);
}

function shootenemywrapper_shootnotify(var0) {
  level notify("an_enemy_shot", self);
  shootenemywrapper_normal(var0);
}

function shootposwrapper(var0, var1) {
  self.a.lastshoottime = gettime();

  if(!isDefined(var1)) {
    var1 = 1;
  }

  self notify("shooting");

  if(scripts\anim\utility_common::isasniper()) {
    self shoot(1, var0, 1, 1, 1);
    return;
  }

  var2 = 0;

  if(isDefined(self.enemy) && istrue(self.enemy.underlowcover)) {
    var2 = 1;
  }

  var3 = bulletspread(self getmuzzlepos(), var0, 4);
  self shoot(1, var3, var1, var2);
}

function throwgun() {
  var0 = spawn("script_model", (0, 0, 0));
  var0 setModel("temp");
  var0.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  var0.angles = self gettagangles("tag_weapon_right");
  var1 = anglestoright(var0.angles);
  var1 *= 15;
  var2 = anglesToForward(var0.angles);
  var2 *= 15;
  var0 movegravity((0, 50, 150), 100);
  var3 = "weapon_" + createheadicon(self.weapon);
  var4 = spawn(var3, var0.origin);
  var4.angles = self gettagangles("tag_weapon_right");
  var4 linkTo(var0);
  var5 = var0.origin;

  while(isDefined(var4) && isDefined(var4.origin)) {
    var6 = var5;
    var7 = var0.origin;
    var8 = vectortoangles(var7 - var6);
    var2 = anglesToForward(var8);
    var2 *= 4;
    var9 = scripts\engine\trace::_bullet_trace(var7, var7 + var2, 1, var4);

    if(isalive(var9["entity"]) && var9["entity"] == self) {
      wait 0.05;
      continue;
    }

    if(var9["fraction"] < 1) {
      break;
    }

    var5 = var0.origin;
    wait 0.05;
  }

  if(isDefined(var4) && isDefined(var4.origin)) {
    var4 unlink();
  }

  var0 delete();
}

function personalcoldbreath() {
  var0 = "TAG_EYE";
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

      playFXOnTag(level._effect["cold_breath"], self, var0);
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

function showlines(var0, var1, var2) {
  for(;;) {
    wait 0.05;
    wait 0.05;
  }
}

function anim_array(var0, var1) {
  var2 = var0.size;
  var3 = randomint(var2);

  if(var2 == 1) {
    return var0[0];
  }

  var4 = 0;
  var5 = 0;

  for(var6 = 0; var6 < var2; var6++) {
    var5 += var1[var6];
  }

  var7 = randomfloat(var5);
  var8 = 0;

  for(var6 = 0; var6 < var2; var6++) {
    var8 += var1[var6];

    if(var7 >= var8) {
      continue;
    }

    var3 = var6;
    break;
  }

  return var0[var3];
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

function random_weight(var0) {
  var1 = randomint(var0.size);

  if(var0.size > 1) {
    var2 = 0;

    for(var3 = 0; var3 < var0.size; var3++) {
      var2 += var0[var3];
    }

    var4 = randomfloat(var2);
    var2 = 0;

    for(var3 = 0; var3 < var0.size; var3++) {
      var2 += var0[var3];

      if(var4 < var2) {
        var1 = var3;
        break;
      }
    }
  }

  return var1;
}

function setfootstepeffect(var0, var1, var2) {
  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  anim.optionalstepeffects[var1] = 1;
  level._effect["step_" + var1][var0] = var2;
}

function setfootstepeffectsmall(var0, var1, var2) {
  if(!isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  anim.optionalstepeffectssmall[var1] = 1;
  level._effect["step_small_" + var1][var0] = var2;
}

function setfootprinteffect(var0, var1, var2) {
  if(!isDefined(anim.optionalfootprinteffects)) {
    anim.optionalfootprinteffects = [];
  }

  if(!isDefined(anim.flirfootprinteffects)) {
    anim.flirfootprinteffects = 0;
  }

  anim.optionalfootprinteffects[var1] = 1;
  level._effect["footprint_" + var1][var0] = var2;
}

function unsetfootstepeffect(var0) {
  if(isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects[var0] = undefined;
  }

  level._effect["step_" + var0] = undefined;
}

function unsetfootstepeffectsmall(var0) {
  if(isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall[var0] = undefined;
  }

  level._effect["step_small_" + var0] = undefined;
}

function unsetfootprinteffect(var0) {
  if(isDefined(anim.optionalfootprinteffects)) {
    anim.optionalfootprinteffects[var0] = undefined;
  }

  level._effect["footprint_" + var0] = undefined;
}

function setnotetrackeffect(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var2)) {
    var2 = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  level._notetrackfx[var0][var2] = spawnStruct();
  level._notetrackfx[var0][var2].tag = var1;
  level._notetrackfx[var0][var2].fx = var3;
  setnotetracksound(var0, var2, var4, var5);
}

function setnotetracksound(var0, var1, var2, var3) {
  if(!isDefined(var1)) {
    var1 = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  if(isDefined(level._notetrackfx[var0][var1])) {
    var4 = level._notetrackfx[var0][var1];
  } else {
    var4 = spawnStruct();
    level._notetrackfx[var1][var2] = var4;
  }

  if(isDefined(var3)) {
    var4.sound_prefix = var3;
  }

  if(isDefined(var4)) {
    var4.sound_suffix = var4;
    return;
  }
}

function enterpronewrapper(var0) {
  thread enterpronewrapperproc(var0);
}

function enterpronewrapperproc(var0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self enterprone(var0, isDefined(self.a.onback));
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

function exitpronewrapper(var0) {
  thread exitpronewrapperproc(var0);
}

function exitpronewrapperproc(var0) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self exitprone(var0);
  self waittill("killanimscript");

  if(self.currentpose == "prone") {
    self.currentpose = "crouch";
    return;
  }
}

function animarray(var0) {
  return self.a.array[var0];
}

function animarrayanyexist(var0) {
  return isDefined(self.a.array[var0]) && self.a.array[var0].size > 0;
}

function animarraypickrandom(var0) {
  var1 = randomint(self.a.array[var0].size);
  return self.a.array[var0][var1];
}

function array(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13) {
  var14 = [];

  if(isDefined(var0)) {
    GscBinSkip0(0x2e, 0, var0);
  }

  return var14;
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

function aihasweapon(var0) {
  var1 = createheadicon(var0);

  if(isDefined(self.weaponinfo[var1])) {
    return true;
  }

  return false;
}

function getanimendpos(var0) {
  var1 = getmovedelta(var0, 0, 1);
  return self localtoworldcoords(var1);
}

function ragdolldeath(var0) {
  self endon("killanimscript");
  var1 = self.origin;
  var2 = (0, 0, 0);

  for(;;) {
    wait 0.05;
    var3 = distance(self.origin, var1);
    var1 = self.origin;

    if(self.health == 1) {
      self.a.nodeath = 1;
      self startragdoll();
      self clearanim(var0, 0.1);
      wait 0.05;
      physicsexplosionsphere(var1, 600, 0, var3 * 0.1);
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

function getrandomintfromseed(var0, var1) {
  var2 = var0 % anim.randominttablesize;
  return anim.randominttable[var2] % var1;
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

function lookupanim(var0, var1) {
  if(isDefined(self.animarchetype)) {
    if(isDefined(anim.archetypes[self.animarchetype][var0]) && isDefined(anim.archetypes[self.animarchetype][var0][var1])) {
      return anim.archetypes[self.animarchetype][var0][var1];
    }
  }

  return anim.archetypes["soldier"][var0][var1];
}

function lookupanimarray(var0) {
  if(isDefined(self.animarchetype)) {
    if(isDefined(anim.archetypes[self.animarchetype][var0])) {
      var1 = anim.archetypes["soldier"][var0];

      foreach(var3 in anim.archetypes[self.animarchetype][var0]) {
        var1 = var3;
      }

      return var1;
    }
  }

  return anim.archetypes["soldier"][var4];
}

function isenergyweapon(var0) {
  return weaponusesenergybullets(var0);
}