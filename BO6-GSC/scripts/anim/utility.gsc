/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\utility.gsc
**************************************/

#using scripts\anim\utility_common;
#using scripts\common\gameskill;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace utility;

function initialize(type) {}

#using_animtree("generic_human");

function updateanimpose() {
  assert(self.a.movement == "<dev string:x24>" || self.a.movement == "<dev string:x2c>" || self.a.movement == "<dev string:x34>", "<dev string:x3b>" + self.currentpose + "<dev string:x4e>" + self.a.movement);

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

function checkgrenadeinhand(animscript) {
  self endon("<dev string:x53>");

  if(animscript == "<dev string:x65>" || animscript == "<dev string:x6d>") {
    wait 0.05;
    waittillframeend();
  }

  attachsize = self getattachsize();

  for(i = 0; i < attachsize; i++) {
    model = tolower(self getattachmodelname(i));
    assert(model != "<dev string:x76>", "<dev string:x8c>" + self.origin);
    assert(model != "<dev string:xe6>", "<dev string:x8c>" + self.origin);
    assert(model != "<dev string:x106>", "<dev string:x8c>" + self.origin);
  }
}

function printdisplaceinfo() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");

  for(;;) {
    print3d(self.origin + (0, 0, 60), "<dev string:x121>", (0, 0.4, 0.7), 0.85, 0.5);

    wait 0.05;
  }
}

function isdebugon() {
  return getdvarint(@ "animdebug") == 1 || anim.debugent == self;
}

function drawdebuglineinternal(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes; i++) {
    line(frompoint, topoint, color);
    wait 0.05;
  }
}

function drawdebugline(frompoint, topoint, color, durationframes) {
  if(isdebugon()) {
    thread drawdebuglineinternal(frompoint, topoint, color, durationframes);
  }
}

function debugline(frompoint, topoint, color, durationframes) {
  for(i = 0; i < durationframes * 20; i++) {
    line(frompoint, topoint, color);
    wait 0.05;
  }
}

function notifyaftertime(notifystring, killmestring, time) {
  self endon("death");
  self endon(killmestring);
  wait time;
  self notify(notifystring);
}

function drawstringtime(msg, org, color, timer) {
  maxtime = timer * 20;

  for(i = 0; i < maxtime; i++) {
    print3d(org, msg, color, 1, 1);

    wait 0.05;
  }
}

function showlastenemysightpos(string) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");

  if(!isDefined(self.enemy)) {
    return;
  }

  if(self.enemy.team == "allies") {
    color = (0.4, 0.7, 1);
  } else {
    color = (1, 0.7, 0.4);
  }

  while(true) {
    wait 0.05;

    if(!isDefined(self.lastenemysightpos)) {
      continue;
    }

    print3d(self.lastenemysightpos, string, color, 1, 2.15);
  }
}

function function_2d157e8584292eb(string, org, printtime, color) {
  level notify("<dev string:x12e>" + org);
  level endon("<dev string:x12e>" + org);

  if(!isDefined(color)) {
    color = (0.3, 0.9, 0.6);
  }

  timer = printtime * 20;
  i = 0;

  while(i < timer) {
    wait 0.05;
    print3d(org, string, color, 1, 1);
    i += 1;
  }
}

function printdebugtext(string, org, printtime, color) {
  if(getDvar(@ "anim_debug", "<dev string:x143>") != "<dev string:x143>") {
    level thread function_2d157e8584292eb(string, org, printtime, color);
  }
}

function hasenemysightpos() {
  if(isDefined(self.node)) {
    return (utility_common::canseeenemyfromexposed() || self cansuppressenemyfromexposed());
  }

  return utility_common::canseeenemy() || utility_common::cansuppressenemy();
}

function getenemysightpos() {
  return self.goodshootpos;
}

function debugtimeout() {
  wait 5;
  self notify("timeout");
}

function debugposinternal(org, string, size) {
  self endon("death");
  self notify("stop debug " + org);
  self endon("stop debug " + org);
  ent = spawnStruct();
  ent thread debugtimeout();
  ent endon("timeout");

  if(self.enemy.team == "allies") {
    color = (0.4, 0.7, 1);
  } else {
    color = (1, 0.7, 0.4);
  }

  while(true) {
    wait 0.05;
    print3d(org, string, color, 1, size);
  }
}

function debugpos(org, string) {
  thread debugposinternal(org, string, 2.15);
}

function debugpossize(org, string, size) {
  thread debugposinternal(org, string, size);
}

function debugburstprint(numshots, maxshots) {
  burstsize = numshots / maxshots;
  burstsizestr = undefined;

  if(numshots == self.bulletsinclip) {
    burstsizestr = "all rounds";
  } else if(burstsize < 0.25) {
    burstsizestr = "small burst";
  } else if(burstsize < 0.5) {
    burstsizestr = "med burst";
  } else {
    burstsizestr = "long burst";
  }

  thread debugpossize(self.origin + (0, 0, 42), burstsizestr, 1.5);
  thread debugpos(self.origin + (0, 0, 60), "Suppressing");
}

function printshootproc() {
  self endon("<dev string:x6d>");
  self notify("<dev string:x147>" + self.export);
  self endon("<dev string:x147>" + self.export);
  printtime = 0.25;
  timer = printtime * 20;
  i = 0;

  while(i < timer) {
    wait 0.05;
    print3d(self.origin + (0, 0, 70), "<dev string:x156>", (1, 0, 0), 1, 1);
    i += 1;
  }
}

function printshoot() {
  if(getdvarint(@ "anim_debug") == 3) {
    thread printshootproc();
  }
}

function showdebugproc(frompoint, topoint, color, printtime) {
  self endon("<dev string:x6d>");
  timer = printtime * 20;
  i = 0;

  while(i < timer) {
    wait 0.05;
    line(frompoint, topoint, color);
    i += 1;
  }
}

function showdebugline(frompoint, topoint, color, printtime) {
  thread showdebugproc(frompoint, topoint + (0, 0, -5), color, printtime);
}

function shootenemywrapper_normal(var_3194eba7c1afe666) {
  self._blackboard.shootparams_lastshoottime = gettime();
  gameskill::set_accuracy_based_on_situation();
  self notify("shooting");

  if(self aiissniper() && self._blackboard.shootparams_valid && isDefined(self._blackboard.shootparams_pos)) {
    if(isDefined(self.var_819a7890692fc6d5) && self.var_1fbbbbeed4c2dd18 > gettime() - 250) {
      self shoot(1, self.var_819a7890692fc6d5, 1, 0, 1);
    } else {
      self shoot(1, self._blackboard.shootparams_pos, 1, 0, 1);
    }

    return;
  }

  if(isagent(self)) {
    var_3194eba7c1afe666 = 1;
  }

  self shoot(1, undefined, var_3194eba7c1afe666);
}

function shootenemywrapper_shootnotify(var_3194eba7c1afe666) {
  level notify("an_enemy_shot", self);
  shootenemywrapper_normal(var_3194eba7c1afe666);
}

function shootposwrapper(shootpos, var_3194eba7c1afe666) {
  self._blackboard.shootparams_lastshoottime = gettime();

  if(!isDefined(var_3194eba7c1afe666)) {
    var_3194eba7c1afe666 = 1;
  }

  self notify("shooting");

  if(self aiissniper()) {
    self shoot(1, shootpos, 1, 1, 1);
    return;
  }

  bignoreenemy = 0;

  if(isDefined(self.enemy) && self.enemy.underlowcover) {
    bignoreenemy = 1;
  }

  endpos = bulletspread(self getmuzzlepos(), shootpos, 4);
  self shoot(1, endpos, var_3194eba7c1afe666, bignoreenemy);
}

function throwgun() {
  org = spawn("script_model", (0, 0, 0));
  org setModel("temp");
  org.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  org.angles = self gettagangles("tag_weapon_right");
  right = anglestoright(org.angles);
  right *= 15;
  forward = anglesToForward(org.angles);
  forward *= 15;
  org movegravity((0, 50, 150), 100);
  weaponclass = "weapon_" + getcompleteweaponname(self.weapon);
  weapon = spawn(weaponclass, org.origin);
  weapon.angles = self gettagangles("tag_weapon_right");
  weapon linkTo(org);
  lastorigin = org.origin;

  while(isDefined(weapon) && isDefined(weapon.origin)) {
    start = lastorigin;
    end = org.origin;
    angles = vectortoangles(end - start);
    forward = anglesToForward(angles);
    forward *= 4;
    trace = trace::_bullet_trace(end, end + forward, 1, weapon);

    if(isalive(trace["entity"]) && trace["entity"] == self) {
      wait 0.05;
      continue;
    }

    if(trace["fraction"] < 1) {
      break;
    }

    lastorigin = org.origin;
    wait 0.05;
  }

  if(isDefined(weapon) && isDefined(weapon.origin)) {
    weapon unlink();
  }

  org delete();
}

function personalcoldbreath() {
  tag = "TAG_EYE";
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

      playFXOnTag(level._effect["cold_breath"], self, tag);
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

function showlines(start, end, end2) {
  for(;;) {
    line(start, end, (1, 0, 0), 1);
    wait 0.05;
    line(start, end2, (0, 0, 1), 1);
    wait 0.05;
  }
}

function usingboltactionweapon() {
  return weaponisboltaction(self.weapon);
}

function setfootstepeffect(type, name, fx) {
  assert(isDefined(name), "<dev string:x15f>");
  assert(isDefined(fx), "<dev string:x18c>");
  assert(isDefined(type), "<dev string:x1b3>");

  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }

  anim.optionalstepeffects[name] = 1;
  level._effect["step_" + name][type] = fx;
}

function setfootstepeffectsmall(type, name, fx) {
  assert(isDefined(name), "<dev string:x15f>");
  assert(isDefined(fx), "<dev string:x18c>");
  assert(isDefined(type), "<dev string:x1b3>");

  if(!isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall = [];
  }

  anim.optionalstepeffectssmall[name] = 1;
  level._effect["step_small_" + name][type] = fx;
}

function setfootprinteffect(type, name, fx) {
  assert(isDefined(name), "<dev string:x15f>");
  assert(isDefined(fx), "<dev string:x18c>");
  assert(isDefined(type), "<dev string:x1b3>");

  if(!isDefined(anim.optionalfootprinteffects)) {
    anim.optionalfootprinteffects = [];
  }

  if(!isDefined(anim.flirfootprinteffects)) {
    anim.flirfootprinteffects = 0;
  }

  anim.optionalfootprinteffects[name] = 1;
  level._effect["footprint_" + name][type] = fx;
}

function unsetfootstepeffect(name) {
  assert(isDefined(name), "<dev string:x1dc>");

  if(isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects[name] = undefined;
  }

  level._effect["step_" + name] = undefined;
}

function unsetfootstepeffectsmall(name) {
  assert(isDefined(name), "<dev string:x1dc>");

  if(isDefined(anim.optionalstepeffectssmall)) {
    anim.optionalstepeffectssmall[name] = undefined;
  }

  level._effect["step_small_" + name] = undefined;
}

function unsetfootprinteffect(name) {
  assert(isDefined(name), "<dev string:x1dc>");

  if(isDefined(anim.optionalfootprinteffects)) {
    anim.optionalfootprinteffects[name] = undefined;
  }

  level._effect["footprint_" + name] = undefined;
}

function setnotetrackeffect(notetrack, tag, surfacename, fx, sound_prefix, sound_suffix) {
  assert(isDefined(notetrack));
  assert(isDefined(tag));
  assert(isDefined(fx));
  assert(isstring(notetrack), "<dev string:x212>");

  if(!isDefined(surfacename)) {
    surfacename = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  level._notetrackfx[notetrack][surfacename] = spawnStruct();
  level._notetrackfx[notetrack][surfacename].tag = tag;
  level._notetrackfx[notetrack][surfacename].fx = fx;
  setnotetracksound(notetrack, surfacename, sound_prefix, sound_suffix);
}

function setnotetracksound(notetrack, surfacename, sound_prefix, sound_suffix) {
  if(!isDefined(surfacename)) {
    surfacename = "all";
  }

  if(!isDefined(level._notetrackfx)) {
    level._notetrackfx = [];
  }

  if(isDefined(level._notetrackfx[notetrack][surfacename])) {
    struct = level._notetrackfx[notetrack][surfacename];
  } else {
    struct = spawnStruct();
    level._notetrackfx[notetrack][surfacename] = struct;
  }

  if(isDefined(sound_prefix)) {
    struct.sound_prefix = sound_prefix;
  }

  if(isDefined(sound_suffix)) {
    struct.sound_suffix = sound_suffix;
  }
}

function enterpronewrapper(timer) {
  thread enterpronewrapperproc(timer);
}

function enterpronewrapperproc(timer) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self enterprone(timer, isDefined(self.a.onback));
  self waittill("killanimscript");

  if(self.currentpose != "prone" && !isDefined(self.a.onback)) {
    self.currentpose = "prone";
  }
}

function stoponback() {
  exitpronewrapper(1);
  self.a.onback = undefined;
}

function exitpronewrapper(timer) {
  thread exitpronewrapperproc(timer);
}

function exitpronewrapperproc(timer) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self exitprone(timer);
  self waittill("killanimscript");

  if(self.currentpose == "prone") {
    self.currentpose = "crouch";
  }
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

  assertmsg("<dev string:x235>");
}

function aihasweapon(objweapon) {
  assert(isweapon(objweapon));
  weaponname = getcompleteweaponname(objweapon);

  if(isDefined(self.weaponinfo[weaponname])) {
    return true;
  }

  return false;
}

function getanimendpos(theanim) {
  movedelta = getmovedelta(theanim, 0, 1);
  return self localtoworldcoords(movedelta);
}

function ragdolldeath(moveanim) {
  self endon("killanimscript");
  lastorg = self.origin;
  movevec = (0, 0, 0);

  for(;;) {
    wait 0.05;
    force = distance(self.origin, lastorg);
    lastorg = self.origin;

    if(self.health == 1) {
      self.a.nodeath = 1;
      self startragdoll();
      self clearanim(moveanim, 0.1);
      wait 0.05;
      physicsexplosionsphere(lastorg, 600, 0, force * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

function iscqbwalkingorfacingenemy() {
  return !self.facemotion;
}

function randomizeidleset() {
  self.a.idleset = randomint(2);
}

function getrandomintfromseed(intseed, intmax) {
  assert(intmax > 0);
  index = intseed % anim.randominttablesize;
  return anim.randominttable[index] % intmax;
}

function getcurrentweaponslotname() {
  assert(isDefined(self));

  if(utility_common::isusingsecondary()) {
    return "secondary";
  }

  if(utility_common::isusingsidearm()) {
    return "sidearm";
  }

  return "primary";
}

function lookupanim(animset_name, anim_index) {
  assert(isai(self));

  if(isDefined(self.animarchetype)) {
    assert(isDefined(anim.archetypes[self.animarchetype]), "<dev string:x262>" + self.animarchetype);

    if(isDefined(anim.archetypes[self.animarchetype][animset_name]) && isDefined(anim.archetypes[self.animarchetype][animset_name][anim_index])) {
      return anim.archetypes[self.animarchetype][animset_name][anim_index];
    }
  }

  assert(isDefined(anim.archetypes["<dev string:x27e>"][animset_name][anim_index]), "<dev string:x289>" + animset_name + "<dev string:x2b2>" + anim_index + "<dev string:x2b8>");
  return anim.archetypes["soldier"][animset_name][anim_index];
}

function lookupanimarray(animset_name) {
  assert(isai(self));

  if(isDefined(self.animarchetype)) {
    assert(isDefined(anim.archetypes[self.animarchetype]), "<dev string:x262>" + self.animarchetype);

    if(isDefined(anim.archetypes[self.animarchetype][animset_name])) {
      animset = anim.archetypes["soldier"][animset_name];

      foreach(key, value in anim.archetypes[self.animarchetype][animset_name]) {
        animset[key] = value;
      }

      return animset;
    }
  }

  assert(isDefined(anim.archetypes["<dev string:x27e>"][animset_name]), "<dev string:x2bd>" + animset_name + "<dev string:x2b8>");
  return anim.archetypes["soldier"][animset_name];
}

function isenergyweapon(weapon) {
  return weaponusesenergybullets(weapon);
}

function function_72b6372d2d8c997(str_gestureweapon, disallow_reload, b_forcestream = 0) {
  assert(isDefined(str_gestureweapon), "<dev string:x2ec>");

  if(!isDefined(disallow_reload)) {
    disallow_reload = 0;
  }

  if(disallow_reload) {
    self cancelreload();
  }

  gestureweapon = makeweapon(str_gestureweapon);

  if(gestureweapon === level.weaponnone) {
    return;
  }

  if(b_forcestream) {
    wmodel = getweaponmodel(gestureweapon);
    self prestreamasset("model", getxhashasset(wmodel), 1000);
  }

  self giveandfireoffhand(gestureweapon);

  if(!self hasweapon(gestureweapon)) {
    if(b_forcestream) {
      self prestreamclear("model");
    }

    return;
  }

  if(disallow_reload) {
    thread function_efe2fa9330798198(gestureweapon);
    self allowreload(0);
    waittill_any("offhand_fired", "weapon_gesture_failed");
    self allowreload(1);
  }

  if(b_forcestream) {
    self prestreamclear("model");
  }

  return gestureweapon;
}

function function_efe2fa9330798198(gestureweapon) {
  self endon("offhand_fired");
  self endon("death_or_disconnect");

  while(self hasweapon(gestureweapon)) {
    waitframe();
  }

  self notify("weapon_gesture_failed");
}