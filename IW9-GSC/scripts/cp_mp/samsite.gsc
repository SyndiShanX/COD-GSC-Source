/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\samsite.gsc
***********************************************/

_id_4390CFB8004A4E9C(turret) {
  turret endon("death");
  turret.target_entity = spawn("script_model", turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 750);
  _id_1A8097F1A065C786 = anglestoleft(turret.angles) * 500;
  _id_1A2A7C570678A79D = anglestoright(turret.angles) * 500;
  turret settargetentity(turret.target_entity);
  turret.target_entity moveTo(turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 750 + _id_1A2A7C570678A79D, 5);
  turret setscriptablepartstate("audio", "rotate_start");
  wait 5;
  turret setscriptablepartstate("audio", "rotate_stop");
  pos = "right";

  for(;;) {
    wait 1;
    turret thread _id_44E4433EBAC52609();
    wait 10;
    turret thread _id_44E4433EBAC52609();
    wait 10;
    turret thread _id_44E4433EBAC52609();
    wait 5;
    _id_F7C5FC38FDC4DF8C(turret);
    wait 1;

    if(pos == "right") {
      turret.target_entity moveTo(turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 1000 + _id_1A8097F1A065C786, 5);
      pos = "left";
    } else if(pos == "left") {
      turret.target_entity moveTo(turret.origin + (0, 0, 750) + anglesToForward(turret.angles) * 1000 + _id_1A2A7C570678A79D, 5);
      pos = "right";
    }

    turret setscriptablepartstate("audio", "rotate_start");
    wait 5;
    turret setscriptablepartstate("audio", "rotate_stop");
  }
}

_id_FEFA23BED4E70FB2(struct) {
  turret = spawnturret("misc_turret", struct.origin, "iw9_tur_samsite_cp");

  if(!isDefined(struct.angles))
    struct.angles = (0, 0, 0);

  turret.angles = struct.angles;
  turret.team = "axis";
  turret setModel("military_samsite_01_rig_skeleton");
  turret settoparc(75);
  turret setbottomarc(0);
  turret setleftarc(360);
  turret setrightarc(360);
  turret makeunusable();
  turret setscriptablepartstate("rocket1", "hidden");
  turret setscriptablepartstate("rocket2", "hidden");
  turret setscriptablepartstate("rocket3", "hidden");

  if(scripts\common\utility::iscp()) {
    turret setscriptablepartstate("usable_left", "usable");
    turret setscriptablepartstate("usable_right", "usable");
    turret setscriptablepartstate("usable_front", "usable");
  } else {
    _id_DBCE45A33308630D = spawn("script_model", turret.origin + (0, 0, 40));
    _id_DBCE45A33308630D setModel("tag_origin");
    _id_DBCE45A33308630D thread _id_D8CA43A821BDFE1A();
    turret._id_DBCE45A33308630D = _id_DBCE45A33308630D;
  }

  return turret;
}

_id_F7C5FC38FDC4DF8C(turret) {
  if(!isDefined(turret)) {
    return;
  }
  turret._id_692FC766D262881A = turret _id_5970DDC4FD448E37(1);
  turret._id_692FC666D26285E7 = turret _id_5970DDC4FD448E37(2);
  turret._id_692FC566D26283B4 = turret _id_5970DDC4FD448E37(3);
}

_id_5970DDC4FD448E37(num) {
  missile = spawn("script_model", self gettagorigin("mg0" + num));
  missile setModel("military_missile_rig_skeleton");
  missile.angles = self gettagangles("mg0" + num);
  missile linkTo(self, "mg0" + num);
  missile thread _id_0E6142ECC1A9CE89(self);
  return missile;
}

_id_44E4433EBAC52609(_id_ABFE04EB6DA78EB9) {
  self endon("death");
  missile = undefined;

  if(isDefined(self._id_692FC766D262881A)) {
    missile = self._id_692FC766D262881A;
    self._id_692FC766D262881A notify("launched");
    self._id_692FC766D262881A = undefined;

    if(!self isnearanyplayer(5000) || istrue(_id_ABFE04EB6DA78EB9))
      self._id_692FC766D262881A = _id_5970DDC4FD448E37(1);
  } else if(isDefined(self._id_692FC666D26285E7)) {
    missile = self._id_692FC666D26285E7;
    self._id_692FC666D26285E7 notify("launched");
    self._id_692FC666D26285E7 = undefined;

    if(!self isnearanyplayer(5000) || istrue(_id_ABFE04EB6DA78EB9))
      self._id_692FC666D26285E7 = _id_5970DDC4FD448E37(2);
  } else if(isDefined(self._id_692FC566D26283B4)) {
    missile = self._id_692FC566D26283B4;
    self._id_692FC566D26283B4 notify("launched");
    self._id_692FC566D26283B4 = undefined;

    if(!self isnearanyplayer(5000) || istrue(_id_ABFE04EB6DA78EB9))
      self._id_692FC566D26283B4 = _id_5970DDC4FD448E37(3);
    else
      scripts\engine\utility::delaythread(5, ::_id_AD922931D55B782B);
  }

  self setscriptablepartstate("launch", "on");

  if(!isDefined(missile)) {
    return;
  }
  missile._id_DA169210CED21C6B = 1;
  _id_3865E73449A5A438 = makeweapon("iw9_la_samsite_cp");
  magicbullet(_id_3865E73449A5A438, missile.origin, missile.origin);
  playsoundatpos(missile.origin + (0, 30, 0), "weap_samsite_fire_npc");
  missile setscriptablepartstate("military_samsite_missile", "on");
  missile unlink();
  wait 0.5;
  earthquake(0.4, 1, missile.origin, 1200);
  missile moveTo(missile.origin + anglesToForward(missile.angles) * 40000, 15);
  wait 15;

  if(isDefined(missile))
    missile delete();
}

_id_9933B3B407347038(struct) {
  turret = _id_FEFA23BED4E70FB2(struct);
  _id_F7C5FC38FDC4DF8C(turret);
  turret.target_entity = spawn("script_model", turret.origin + (0, 0, 900) + anglesToForward(turret.angles) * 1000);
  _id_1A8097F1A065C786 = anglestoleft(turret.angles) * 1000;
  _id_1A2A7C570678A79D = anglestoright(turret.angles) * 1000;
  turret settargetentity(turret.target_entity);
  turret thread _id_FC364B4FCC0D2051();
  return turret;
}

_id_C3D7373FDA980A33() {
  self endon("launching");
  self endon("death");
  _id_9273788590CCD377 = _id_37CC51487B6E95DC(self.origin + (0, 0, 800), 12, 512);
  _id_2C1824E345806E61 = scripts\engine\utility::getclosest(self.target_entity.origin, _id_9273788590CCD377);
  _id_741F5A182DD662C0 = 0;
  thread _id_2ADD68D4C86E555B();

  for(;;) {
    foreach(point in _id_9273788590CCD377) {
      if(_id_2C1824E345806E61 != point && !_id_741F5A182DD662C0)
        continue;
      else if(!_id_741F5A182DD662C0) {
        _id_741F5A182DD662C0 = 1;
        continue;
      }

      self.target_entity moveTo(point.origin, 5);
      wait 5;
    }

    waitframe();
  }
}

_id_71CF043AF949590C() {
  _id_9273788590CCD377 = _id_37CC51487B6E95DC(self.origin + (0, 0, 800), 12, 512);
  _id_2C1824E345806E61 = scripts\engine\utility::getclosest(self.target_entity.origin, _id_9273788590CCD377);
  _id_741F5A182DD662C0 = 0;
  thread _id_2ADD68D4C86E555B();
  count = 0;

  foreach(point in _id_9273788590CCD377) {
    if(_id_2C1824E345806E61 != point && !_id_741F5A182DD662C0) {
      continue;
    }
    self.target_entity moveTo(point.origin, 1.5);
    wait 1.5;
    count++;

    if(count > 2) {
      break;
    }
  }

  self notify("launching");
  wait 1.5;
}

_id_2ADD68D4C86E555B() {
  self endon("death");
  self setscriptablepartstate("audio", "rotate_start");
  self waittill("launching");
  self setscriptablepartstate("audio", "rotate_stop");
}

_id_37CC51487B6E95DC(point, _id_037D6F0C041A42D0, _id_9973F603063C1FED) {
  _id_6F5F9433C7E91215 = 360 / _id_037D6F0C041A42D0;
  _id_E4B7E99A96C8829F = [];
  fwd = (1, 0, 0);

  for(_id_AC0E594AC96AA3A8 = 0; _id_AC0E594AC96AA3A8 < 360; _id_AC0E594AC96AA3A8 = _id_AC0E594AC96AA3A8 + _id_6F5F9433C7E91215) {
    _id_EACD072FEDC3FFAD = fwd * _id_9973F603063C1FED;
    _id_59C8F7E2D87D3710 = (cos(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[0] - sin(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[1], sin(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[0] + cos(_id_AC0E594AC96AA3A8) * _id_EACD072FEDC3FFAD[1], _id_EACD072FEDC3FFAD[2]);
    pos = point + _id_59C8F7E2D87D3710;
    position = spawnStruct();
    position.origin = pos;
    _id_E4B7E99A96C8829F[_id_E4B7E99A96C8829F.size] = position;
  }

  return _id_E4B7E99A96C8829F;
}

_id_0E6142ECC1A9CE89(_id_FAC1DD2A5472BECE) {
  self endon("death");
  self.health = 999999;
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self._id_880A990D25B43AAA = 0;
  self._id_59A09303493E759D = 750;
  self._id_689D46E1E37CC5AD = ::_id_A00BAA7C74F5F04D;
  attacker = undefined;

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(!isPlayer(attacker) || !isexplosivedamagemod(meansofdeath) && meansofdeath != "MOD_IMPACT") {
      if(isPlayer(attacker) && scripts\engine\utility::isbulletdamage(meansofdeath)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          _id_F56FB412974C87C8 = scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback");
          attacker thread[[_id_F56FB412974C87C8]]("hitnobulletdamage");
        }
      }

      self.health = self.health + amount;
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      self.health = self.health + amount;
      continue;
    }

    if(isDefined(objweapon) && objweapon.basename == "c4_mp")
      amount = 350;

    self._id_880A990D25B43AAA = self._id_880A990D25B43AAA + amount;

    if(self._id_880A990D25B43AAA > self._id_59A09303493E759D) {
      break;
    }
  }

  self.health = 0;
  playFX(level._effect["c4_explosion_convoy"], self.origin);
  earthquake(0.35, 1, self.origin, 1024);
  org = self.origin;

  if(isDefined(self))
    self delete();

  radiusdamage(org, 350, 300, 300, attacker, "MOD_EXPLOSIVE");
}

_id_FC364B4FCC0D2051(_id_FAC1DD2A5472BECE) {
  self endon("stop_dmgmonitor");
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self._id_880A990D25B43AAA = 0;
  self._id_59A09303493E759D = 750;
  self._id_689D46E1E37CC5AD = ::_id_A00BAA7C74F5F04D;
  attacker = undefined;
  self.health = 9999999;

  for(;;) {
    self waittill("damage", amount, attacker, direction_vec, damagelocation, meansofdeath, modelname, tagname, partname, _id_44E290FB31B85206, objweapon);

    if(isDefined(objweapon) && (objweapon.basename == "c4_mp" || objweapon.basename == "c4_cp_noproj"))
      amount = 1000;
    else if(!isPlayer(attacker) || !isexplosivedamagemod(meansofdeath) && meansofdeath != "MOD_IMPACT") {
      if(isPlayer(attacker) && scripts\engine\utility::isbulletdamage(meansofdeath)) {
        if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("damage", "updateDamageFeedback")) {
          _id_F56FB412974C87C8 = scripts\cp_mp\utility\script_utility::getsharedfunc("damage", "updateDamageFeedback");
          attacker thread[[_id_F56FB412974C87C8]]("hitnobulletdamage");
        }
      }

      self.health = self.health + amount;
      continue;
    }

    if(!isexplosivedamagemod(meansofdeath)) {
      self.health = self.health + amount;
      continue;
    }

    if(isDefined(objweapon)) {
      _id_49E6EF3EDADD524E = _func_F581838CE4328F7A(objweapon);

      switch (_id_49E6EF3EDADD524E) {
        case "c4":
          amount = 755;
          break;
        case "iw8_la_mike32":
        case "frag_grenade":
        case "iw9_la_mike32":
        case "semtex":
        case "molotov":
          amount = int(225.0);
          break;
        case "iw8_la_gromeo":
        case "iw9_la_gromeo":
          amount = 380;
          break;
      }
    }

    self.health = self.health + amount;

    if(scripts\engine\utility::isbulletdamage(meansofdeath))
      amount = min(10, amount);

    self._id_880A990D25B43AAA = self._id_880A990D25B43AAA + amount;

    if(self._id_880A990D25B43AAA > self._id_59A09303493E759D) {
      break;
    }
  }

  if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("challenges", "destroySamSiteNoPlant"))
    [[scripts\cp_mp\utility\script_utility::getsharedfunc("challenges", "destroySamSiteNoPlant")]](level.script, objweapon, attacker);

  _id_6C86D07047FAE506(attacker);
}

_id_6C86D07047FAE506(attacker) {
  self.health = 0;
  self setscriptablepartstate("base", "destroyed");
  thread scripts\engine\utility::play_loopsound_in_space("dst_sam_site_fire_lp", self.origin);
  radiusdamage(self.origin, 350, 300, 85);

  if(isDefined(self._id_692FC766D262881A) && !istrue(self._id_692FC766D262881A._id_DA169210CED21C6B)) {
    if(isDefined(level._effect["c4_explosion_convoy"]))
      playFX(level._effect["c4_explosion_convoy"], self._id_692FC766D262881A.origin);

    self._id_692FC766D262881A hide();
  }

  if(isDefined(self._id_692FC666D26285E7) && !istrue(self._id_692FC666D26285E7._id_DA169210CED21C6B)) {
    if(isDefined(level._effect["c4_explosion_convoy"]))
      playFX(level._effect["c4_explosion_convoy"], self._id_692FC666D26285E7.origin);

    self._id_692FC666D26285E7 hide();
  }

  if(isDefined(self._id_692FC566D26283B4) && !istrue(self._id_692FC566D26283B4._id_DA169210CED21C6B)) {
    if(isDefined(level._effect["c4_explosion_convoy"]))
      playFX(level._effect["c4_explosion_convoy"], self._id_692FC566D26283B4.origin);

    self._id_692FC566D26283B4 hide();
  }

  if(isDefined(self.soundent))
    self.soundent delete();

  if(isDefined(self._id_DBCE45A33308630D))
    self._id_DBCE45A33308630D delete();

  _id_0B50986773A4D932 = spawn("script_model", self.origin);
  _id_0B50986773A4D932.angles = self.angles;
  _id_0B50986773A4D932 setModel("military_samsite_01_damaged_rig_skeleton");
  _id_0B50986773A4D932 setscriptablepartstate("base", "destroyed");

  if(istrue(level._id_082E220E37DEE38E)) {
    _id_0B50986773A4D932._id_2E1259FB590696E9 = spawn("trigger_radius", self.origin, 0, 96, 512);
    _id_0B50986773A4D932._id_2E1259FB590696E9.targetname = "sam_dmg";
    _id_0B50986773A4D932._id_2E1259FB590696E9 thread _id_0BC293EC7591C985();
  }

  if(!isDefined(level._id_F7F6CF2225966394))
    level._id_F7F6CF2225966394 = [];

  level._id_F7F6CF2225966394[level._id_F7F6CF2225966394.size] = _id_0B50986773A4D932;
  level notify("samsite_destroyed", attacker);
  self notify("samsite_dead", attacker);
  wait 10;

  if(isDefined(self))
    self delete();
}

_id_0BC293EC7591C985() {
  self endon("death");
  level endon("game_ended");

  for(;;) {
    self waittill("trigger", ent);

    if(isPlayer(ent))
      thread _id_411B78CFC85001B1(ent);
  }
}

_id_411B78CFC85001B1(player) {
  player endon("disconnect");

  if(!istrue(player.onfire)) {
    player.onfire = 1;
    player dodamage(45, player.origin, undefined, undefined, "MOD_TRIGGER_HURT");
    wait 0.5;
    player.onfire = 0;
  }
}

_id_E864DB8A259B11D0() {
  if(istrue(self._id_2551D467A1F595B3)) {
    return;
  }
  self._id_2551D467A1F595B3 = 1;
  self thread[[level.showerrormessagefunc]]("MP/EXPLOSVE_DAMAGE_ONLY");
  wait 3;
  self._id_2551D467A1F595B3 = undefined;
}

_id_A00BAA7C74F5F04D(idamage) {
  if(idamage + self._id_880A990D25B43AAA > self._id_59A09303493E759D)
    return 1;

  return 0;
}

_id_AD922931D55B782B() {
  self endon("death");

  while(self isnearanyplayer(5000))
    wait 1;

  _id_F7C5FC38FDC4DF8C(self);
}

_id_D8CA43A821BDFE1A() {
  self makeusable();
  self endon("death");
  _id_3E95EDBF2A19F0A1();
  player = undefined;

  for(;;) {
    self waittill("trigger", player);

    if(!player isvalidplayer()) {
      continue;
    }
    break;
  }

  player giveandfireoffhand("c4_mp");
  self makeunusable();
  wait 5;

  if(isDefined(self))
    self delete();
}

_id_7647015EE3137876() {
  if(!isDefined(level.scr_animtree["samsite"])) {
    if(scripts\common\utility::iscp())
      _id_14C8EB2E0B67D409();
    else
      _id_3C11327E37345BB2();
  }

  self.animname = "samsite";
  self useanimtree(level.scr_animtree["samsite"]);
  scripts\common\anim::anim_single([self], "fire");
}

#using_animtree("script_model");

_id_3C11327E37345BB2() {
  level.scr_animtree["samsite"] = #animtree;
  level.scr_anim["samsite"]["fire"] = level._id_1A209BD995A7FA83["iw9_mp_prop_samsite_launch"];
}

_id_14C8EB2E0B67D409() {
  level.scr_animtree["samsite"] = #animtree;
  level.scr_anim["samsite"]["fire"] = % iw9_mp_prop_samsite_launch;
}

isvalidplayer() {
  if(!isPlayer(self))
    return 0;

  if(!isDefined(self))
    return 0;

  if(!isalive(self))
    return 0;

  if(self.sessionstate == "spectator")
    return 0;

  return 1;
}

_id_3E95EDBF2A19F0A1() {
  self setHintString(&"CP_MISSION_ESC/PLANT_CHARGE");
  self sethinticon("hud_icon_c4_plant");
  self sethintdisplayrange(512);
  self setuserange(150);
  self setCursorHint("HINT_BUTTON");
  self sethintdisplayfov(65);
  self sethintonobstruction("show");
  self sethintrequiresholding(1);
  self setuseholdduration("duration_short");
}