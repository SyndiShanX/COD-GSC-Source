/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\anim\utility.gsc
***********************************************/

initialize(type) {}

#using_animtree("generic_human");

updateanimpose() {
  if(isDefined(self.desired_anim_pose) && self.desired_anim_pose != self.currentpose) {
    if(self.currentpose == "prone")
      exitpronewrapper(0.5);

    if(self.desired_anim_pose == "prone") {
      self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_aiming, %prone_legs_up);
      enterpronewrapper(0.5);
      self setanimknoball(lookupanim("default_prone", "straight_level"), %body, 1, 0.1, 1);
    }
  }

  self.desired_anim_pose = undefined;
}

printdisplaceinfo() {
  self endon("death");
  self notify("displaceprint");
  self endon("displaceprint");

  for(;;)
    wait 0.05;
}

notifyaftertime(notifystring, _id_EC80663A57D56272, time) {
  self endon("death");
  self endon(_id_EC80663A57D56272);
  wait(time);
  self notify(notifystring);
}

drawstringtime(msg, org, color, timer) {
  maxtime = timer * 20;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < maxtime; _id_AC0E594AC96AA3A8++)
    wait 0.05;
}

showlastenemysightpos(string) {
  self notify("got known enemy2");
  self endon("got known enemy2");
  self endon("death");

  if(!isDefined(self.enemy)) {
    return;
  }
  if(self.enemy.team == "allies")
    color = (0.4, 0.7, 1);
  else
    color = (1, 0.7, 0.4);

  for(;;) {
    wait 0.05;

    if(!isDefined(self.lastenemysightpos))
      continue;
  }
}

hasenemysightpos() {
  if(isDefined(self.node))
    return _id_2B79931B08683E0A::canseeenemyfromexposed() || self cansuppressenemyfromexposed();
  else
    return _id_2B79931B08683E0A::canseeenemy() || _id_2B79931B08683E0A::cansuppressenemy();
}

getenemysightpos() {
  return self.goodshootpos;
}

debugtimeout() {
  wait 5;
  self notify("timeout");
}

debugposinternal(org, string, _id_A61C75B156FC1EE0) {
  self endon("death");
  self notify("stop debug " + org);
  self endon("stop debug " + org);
  ent = spawnStruct();
  ent thread debugtimeout();
  ent endon("timeout");

  if(self.enemy.team == "allies")
    color = (0.4, 0.7, 1);
  else
    color = (1, 0.7, 0.4);

  for(;;)
    wait 0.05;
}

debugpos(org, string) {
  thread debugposinternal(org, string, 2.15);
}

debugpossize(org, string, _id_A61C75B156FC1EE0) {
  thread debugposinternal(org, string, _id_A61C75B156FC1EE0);
}

debugburstprint(_id_89F949A75D92E1A4, _id_3E92CD336A99CE02) {
  _id_F7A22274947D27DC = _id_89F949A75D92E1A4 / _id_3E92CD336A99CE02;
  _id_67C3F18015D8D33B = undefined;

  if(_id_89F949A75D92E1A4 == self.bulletsinclip)
    _id_67C3F18015D8D33B = "all rounds";
  else if(_id_F7A22274947D27DC < 0.25)
    _id_67C3F18015D8D33B = "small burst";
  else if(_id_F7A22274947D27DC < 0.5)
    _id_67C3F18015D8D33B = "med burst";
  else
    _id_67C3F18015D8D33B = "long burst";

  thread debugpossize(self.origin + (0, 0, 42), _id_67C3F18015D8D33B, 1.5);
  thread debugpos(self.origin + (0, 0, 60), "Suppressing");
}

printshootproc() {
  self endon("death");
  self notify("stop shoot " + self.export);
  self endon("stop shoot " + self.export);
  _id_DB38B8157989533D = 0.25;
  timer = _id_DB38B8157989533D * 20;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < timer; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 1)
    wait 0.05;
}

printshoot() {}

showdebugproc(_id_8F78581CD3208C45, _id_EA13048AE45874C6, color, _id_DB38B8157989533D) {
  self endon("death");
  timer = _id_DB38B8157989533D * 20;

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < timer; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + 1)
    wait 0.05;
}

showdebugline(_id_8F78581CD3208C45, _id_EA13048AE45874C6, color, _id_DB38B8157989533D) {
  thread showdebugproc(_id_8F78581CD3208C45, _id_EA13048AE45874C6 + (0, 0, -5), color, _id_DB38B8157989533D);
}

shootenemywrapper_normal(_id_9BC9D0EE2A8A46F5) {
  self._blackboard._id_060DCAA3D3BE97AB = gettime();
  scripts\common\gameskill::set_accuracy_based_on_situation();
  self notify("shooting");

  if(self _meth_E8CA4080D02A0BB4() && istrue(self._blackboard.shootparams_valid) && isDefined(self._blackboard.shootparams_pos)) {
    if(isDefined(self._id_3568703B0BAB6334) && self._id_145C08825430F207 > gettime() - 250)
      self shoot(1, self._id_3568703B0BAB6334, 1, 0, 1);
    else
      self shoot(1, self._blackboard.shootparams_pos, 1, 0, 1);
  } else {
    if(isagent(self))
      _id_9BC9D0EE2A8A46F5 = 1;

    self shoot(1, undefined, _id_9BC9D0EE2A8A46F5);
  }
}

shootenemywrapper_shootnotify(_id_9BC9D0EE2A8A46F5) {
  level notify("an_enemy_shot", self);
  shootenemywrapper_normal(_id_9BC9D0EE2A8A46F5);
}

shootposwrapper(shootpos, _id_9BC9D0EE2A8A46F5) {
  self._blackboard._id_060DCAA3D3BE97AB = gettime();

  if(!isDefined(_id_9BC9D0EE2A8A46F5))
    _id_9BC9D0EE2A8A46F5 = 1;

  self notify("shooting");

  if(self _meth_E8CA4080D02A0BB4())
    self shoot(1, shootpos, 1, 1, 1);
  else {
    _id_6DA568DF7FCED105 = 0;

    if(isDefined(self.enemy) && istrue(self.enemy.underlowcover))
      _id_6DA568DF7FCED105 = 1;

    endpos = bulletspread(self getmuzzlepos(), shootpos, 4);
    self shoot(1, endpos, _id_9BC9D0EE2A8A46F5, _id_6DA568DF7FCED105);
  }
}

throwgun() {
  org = spawn("script_model", (0, 0, 0));
  org setModel("temp");
  org.origin = self gettagorigin("tag_weapon_right") + (50, 50, 0);
  org.angles = self gettagangles("tag_weapon_right");
  right = anglestoright(org.angles);
  right = right * 15;
  forward = anglesToForward(org.angles);
  forward = forward * 15;
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
    forward = forward * 4;
    trace = scripts\engine\trace::_bullet_trace(end, end + forward, 1, weapon);

    if(isalive(trace["entity"]) && trace["entity"] == self) {
      wait 0.05;
      continue;
    }

    if(trace["fraction"] < 1.0) {
      break;
    }

    lastorigin = org.origin;
    wait 0.05;
  }

  if(isDefined(weapon) && isDefined(weapon.origin))
    weapon unlink();

  org delete();
}

personalcoldbreath() {
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
      wait(2.5 + randomfloat(3));
      continue;
    }

    wait 0.5;
  }
}

ispartiallysuppressedwrapper() {
  if(self.suppressionmeter <= self.suppressionthreshold * 0.25)
    return 0;

  return self issuppressed();
}

showlines(start, end, end2) {
  for(;;) {
    wait 0.05;
    wait 0.05;
  }
}

usingboltactionweapon() {
  return weaponisboltaction(self.weapon);
}

setfootstepeffect(type, name, fx) {
  if(!isDefined(anim.optionalstepeffects))
    anim.optionalstepeffects = [];

  anim.optionalstepeffects[name] = 1;
  level._effect["step_" + name][type] = fx;
}

setfootstepeffectsmall(type, name, fx) {
  if(!isDefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall = [];

  anim.optionalstepeffectssmall[name] = 1;
  level._effect["step_small_" + name][type] = fx;
}

setfootprinteffect(type, name, fx) {
  if(!isDefined(anim.optionalfootprinteffects))
    anim.optionalfootprinteffects = [];

  if(!isDefined(anim.flirfootprinteffects))
    anim.flirfootprinteffects = 0;

  anim.optionalfootprinteffects[name] = 1;
  level._effect["footprint_" + name][type] = fx;
}

unsetfootstepeffect(name) {
  if(isDefined(anim.optionalstepeffects))
    anim.optionalstepeffects[name] = undefined;

  level._effect["step_" + name] = undefined;
}

unsetfootstepeffectsmall(name) {
  if(isDefined(anim.optionalstepeffectssmall))
    anim.optionalstepeffectssmall[name] = undefined;

  level._effect["step_small_" + name] = undefined;
}

unsetfootprinteffect(name) {
  if(isDefined(anim.optionalfootprinteffects))
    anim.optionalfootprinteffects[name] = undefined;

  level._effect["footprint_" + name] = undefined;
}

setnotetrackeffect(notetrack, tag, _id_2E697115FA7CF3CB, fx, sound_prefix, sound_suffix) {
  if(!isDefined(_id_2E697115FA7CF3CB))
    _id_2E697115FA7CF3CB = "all";

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  level._notetrackfx[notetrack][_id_2E697115FA7CF3CB] = spawnStruct();
  level._notetrackfx[notetrack][_id_2E697115FA7CF3CB].tag = tag;
  level._notetrackfx[notetrack][_id_2E697115FA7CF3CB].fx = fx;
  setnotetracksound(notetrack, _id_2E697115FA7CF3CB, sound_prefix, sound_suffix);
}

setnotetracksound(notetrack, _id_2E697115FA7CF3CB, sound_prefix, sound_suffix) {
  if(!isDefined(_id_2E697115FA7CF3CB))
    _id_2E697115FA7CF3CB = "all";

  if(!isDefined(level._notetrackfx))
    level._notetrackfx = [];

  if(isDefined(level._notetrackfx[notetrack][_id_2E697115FA7CF3CB]))
    struct = level._notetrackfx[notetrack][_id_2E697115FA7CF3CB];
  else {
    struct = spawnStruct();
    level._notetrackfx[notetrack][_id_2E697115FA7CF3CB] = struct;
  }

  if(isDefined(sound_prefix))
    struct.sound_prefix = sound_prefix;

  if(isDefined(sound_suffix))
    struct.sound_suffix = sound_suffix;
}

enterpronewrapper(timer) {
  thread enterpronewrapperproc(timer);
}

enterpronewrapperproc(timer) {
  self endon("death");
  self notify("anim_prone_change");
  self endon("anim_prone_change");
  self enterprone(timer, isDefined(self.a.onback));
  self waittill("killanimscript");

  if(self.currentpose != "prone" && !isDefined(self.a.onback))
    self.currentpose = "prone";
}

stoponback() {
  exitpronewrapper(1.0);
  self.a.onback = undefined;
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

  if(self.currentpose == "prone")
    self.currentpose = "crouch";
}

getaiprimaryweapon() {
  return self.primaryweapon;
}

getaisecondaryweapon() {
  return self.secondaryweapon;
}

getaisidearmweapon() {
  return self.sidearm;
}

getaicurrentweapon() {
  return self.weapon;
}

getaicurrentweaponslot() {
  if(self.weapon == self.primaryweapon)
    return "primary";
  else if(self.weapon == self.secondaryweapon)
    return "secondary";
  else if(self.weapon == self.sidearm)
    return "sidearm";
  else {}
}

aihasweapon(objweapon) {
  weaponname = getcompleteweaponname(objweapon);

  if(isDefined(self.weaponinfo[weaponname]))
    return 1;

  return 0;
}

getanimendpos(_id_64885102A4A4C1F5) {
  movedelta = getmovedelta(_id_64885102A4A4C1F5, 0, 1);
  return self localtoworldcoords(movedelta);
}

ragdolldeath(_id_0D02EEA0F6367895) {
  self endon("killanimscript");
  _id_864A89E91220ABD9 = self.origin;
  _id_2B8EA5F7A739BEA2 = (0, 0, 0);

  for(;;) {
    wait 0.05;
    _id_F8048727716242B0 = distance(self.origin, _id_864A89E91220ABD9);
    _id_864A89E91220ABD9 = self.origin;

    if(self.health == 1) {
      self.a.nodeath = 1;
      self startragdoll();
      self clearanim(_id_0D02EEA0F6367895, 0.1);
      wait 0.05;
      physicsexplosionsphere(_id_864A89E91220ABD9, 600, 0, _id_F8048727716242B0 * 0.1);
      self notify("killanimscript");
      return;
    }
  }
}

iscqbwalkingorfacingenemy() {
  return !self.facemotion;
}

randomizeidleset() {
  self.a.idleset = randomint(2);
}

getrandomintfromseed(_id_965F49612D80FFB3, _id_5020B6FB0D8AEB14) {
  index = _id_965F49612D80FFB3 % anim.randominttablesize;
  return anim.randominttable[index] % _id_5020B6FB0D8AEB14;
}

getcurrentweaponslotname() {
  if(_id_2B79931B08683E0A::isusingsecondary())
    return "secondary";

  if(_id_2B79931B08683E0A::isusingsidearm())
    return "sidearm";

  return "primary";
}

lookupanim(_id_4CABF1B2B096A23A, _id_B94D3FF91445983F) {
  if(isDefined(self.animarchetype)) {
    if(isDefined(anim.archetypes[self.animarchetype][_id_4CABF1B2B096A23A]) && isDefined(anim.archetypes[self.animarchetype][_id_4CABF1B2B096A23A][_id_B94D3FF91445983F]))
      return anim.archetypes[self.animarchetype][_id_4CABF1B2B096A23A][_id_B94D3FF91445983F];
  }

  return anim.archetypes["soldier"][_id_4CABF1B2B096A23A][_id_B94D3FF91445983F];
}

lookupanimarray(_id_4CABF1B2B096A23A) {
  if(isDefined(self.animarchetype)) {
    if(isDefined(anim.archetypes[self.animarchetype][_id_4CABF1B2B096A23A])) {
      animset = anim.archetypes["soldier"][_id_4CABF1B2B096A23A];

      foreach(key, value in anim.archetypes[self.animarchetype][_id_4CABF1B2B096A23A])
      animset[key] = value;

      return animset;
    }
  }

  return anim.archetypes["soldier"][_id_4CABF1B2B096A23A];
}

isenergyweapon(weapon) {
  return weaponusesenergybullets(weapon);
}

_id_B5216A6D7BD17210(_id_125494B52C06759C, _id_D160DD91A3AE5BB8) {
  _id_D160DD91A3AE5BB8 = scripts\engine\utility::_id_53C4C53197386572(_id_D160DD91A3AE5BB8, 0);

  if(_id_D160DD91A3AE5BB8)
    self cancelreload();

  gestureweapon = makeweapon(_id_125494B52C06759C);
  self giveandfireoffhand(gestureweapon);

  if(!self hasweapon(gestureweapon)) {
    return;
  }
  if(_id_D160DD91A3AE5BB8) {
    thread _id_422595121745C8A1(gestureweapon);
    self allowreload(0);
    scripts\engine\utility::waittill_any_2("offhand_fired", "weapon_gesture_failed");
    self allowreload(1);
  }
}

_id_422595121745C8A1(gestureweapon) {
  self endon("offhand_fired");
  self endon("death_or_disconnect");

  while(self hasweapon(gestureweapon))
    waitframe();

  self notify("weapon_gesture_failed");
}