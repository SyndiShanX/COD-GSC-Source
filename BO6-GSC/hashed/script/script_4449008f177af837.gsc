/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_4449008f177af837.gsc
*****************************************************/

#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\asm\asm;
#using scripts\common\anim;
#using scripts\common\values;
#using scripts\engine\utility;
#namespace namespace_f038569e80304b79;

function evaluatesyncedmeleebyxanim(meleexanim, var_f1c4df162f33bbcd) {
  target = self.meleetarget;
  targetangles = target.angles;
  metotarget = target.origin - self.origin;
  metotargetyaw = vectortoyaw(metotarget);
  var_ce24b609046a0141 = 30;
  yawdelta = angleclamp180(metotargetyaw - self.angles[1]);

  if(abs(yawdelta) > var_ce24b609046a0141) {
    return false;
  }

  if(var_f1c4df162f33bbcd) {
    targetangles = target.angles - (0, yawdelta * 0.5, 0);
    startpos = getstartorigin(target.origin, targetangles, meleexanim);
  } else {
    targetangles = target.angles - (0, yawdelta, 0);
    startpos = getstartorigin(target.origin, targetangles, meleexanim);
  }

  startpostome = self.origin - startpos;
  var_9350d9555849efc9 = vectorNormalize(target.origin - startpos);
  dot = vectordot(var_9350d9555849efc9, startpostome);

  if(dot > 12 || dot < -12) {
    return false;
  }

  if(var_f1c4df162f33bbcd) {
    self.var_ca7d2f6087c466f5 = self.angles[1] + yawdelta * 0.5;
    target.var_ca7d2f6087c466f5 = targetangles[1];
  } else {
    self.var_ca7d2f6087c466f5 = getstartangles(target.origin, targetangles, meleexanim)[1];
    target.var_ca7d2f6087c466f5 = targetangles[1];
  }

  target.var_9ce8527991f3aa67 = 1;
  return true;
}

function function_ce8c28ad77b46134(meleexanim, zombiemeleexanim) {
  soldieranimlength = getanimlength(meleexanim);
  zombieanimlength = getanimlength(zombiemeleexanim);
  zombiesynctime = getnotetracktimes(zombiemeleexanim, "\xbbZ\x01P");
  fracsynctime = zombiesynctime[0] * zombieanimlength / soldieranimlength;
  soldiermovedelta = getmovedelta(meleexanim);
  soldieranimendpos = self localtoworldcoords(soldiermovedelta);
  zombieanimstartposang = animation::function_3cf2092e487b2640(meleexanim, "\x81\xe4\xef\xf50^av", 0, self.origin, self.angles);
  var_8df4dd3e54cae0c2 = animation::function_3cf2092e487b2640(meleexanim, "\x81\xe4\xef\xf50^av", fracsynctime, self.origin, self.angles);
  zombiemovedelta = getmovedelta(zombiemeleexanim);
  endpos = coordtransform(soldiermovedelta, zombieanimstartposang["\xb0$R\x8b\xc9\x17"], zombieanimstartposang["\xc5\x94\x82H\x9a`"]);
  target = self.meleetarget;
  dist = distance(target.origin, var_8df4dd3e54cae0c2["\xb0$R\x8b\xc9\x17"]);

  if(dist > 40) {
    return false;
  }

  if(!ispointonnavmesh(soldieranimendpos) || !ispointonnavmesh(var_8df4dd3e54cae0c2["\xb0$R\x8b\xc9\x17"])) {
    return false;
  }

  navtraceresult = navtrace(zombieanimstartposang["\xb0$R\x8b\xc9\x17"], self.origin, target, 0);

  if(navtraceresult) {
    return false;
  }

  navtraceresult = navtrace(self.origin, soldieranimendpos, self, 0);

  if(navtraceresult) {
    return false;
  }

  target.var_9ce8527991f3aa67 = 1;
  return true;
}

function evaluatesyncedmelee(asmname, statename, tostatename, params) {
  if(isDefined(level.var_f6dfc486328d1100)) {
    return [[level.var_f6dfc486328d1100]](self, asmname, statename, tostatename, params);
  }

  assert(self.in_melee);
  assert(isDefined(self.meleetarget));
  target = self.meleetarget;

  if(isPlayer(target)) {
    return 0;
  }

  if(istrue(self.dontsyncmelee) || istrue(target.dontsyncmelee)) {
    return 0;
  }

  if(!isDefined(target.weapon)) {
    return 0;
  }

  if(!target asmhasstate(target.asmname, tostatename + "C\x01\xc6\x96\xd4\x83\x17")) {
    return 0;
  }

  if(target.type != "\x9b\x11\"\xd6\xfb;") {
    if(weaponclass(self.weapon) == "\x8e\xfcc\xbe\xdf\xa6" || weaponclass(target.weapon) == "\x8e\xfcc\xbe\xdf\xa6") {
      return 0;
    }
  }

  if(getdvarint(@ "hash_4fa81bfc988a90e6", 0) == 1) {
    if(target.type == "\x9b\x11\"\xd6\xfb;") {
      target.meleealwayswin = 1;
    }
  }

  if(!(isDefined(self.var_6943b73195d42c91) && isDefined(target.var_6943b73195d42c91))) {
    melee_decide_winner();
  }

  bwinner = params[0];

  if(self.var_6943b73195d42c91 != bwinner) {
    return 0;
  }

  var_f1c4df162f33bbcd = params[1];
  syncdir = melee_calcsyncdirection();
  variations = ["$"];

  if(target.type == "\x9b\x11\"\xd6\xfb;" || syncdir == "\f") {
    variations = ["$", "\xde", "\xcc"];
    numvars = 3;
    var_c837ae58cb9d94b9 = randomint(numvars);
    var_81323ac8fb1fbe40 = randomint(numvars);
    temp = variations[var_c837ae58cb9d94b9];
    variations[var_c837ae58cb9d94b9] = variations[var_81323ac8fb1fbe40];
    variations[var_81323ac8fb1fbe40] = temp;
  }

  numvars = variations.size;

  for(ivar = 0; ivar < numvars; ivar++) {
    aliasname = syncdir + variations[ivar];
    meleeanim = asm::asm_lookupanimfromalias(tostatename, aliasname);
    meleexanim = asm::asm_getxanim(tostatename, meleeanim);

    if(target.type == "\x9b\x11\"\xd6\xfb;") {
      zombietostatename = tostatename + "C\x01\xc6\x96\xd4\x83\x17";
      zombiemeleeanim = target asm::asm_lookupanimfromalias(zombietostatename, aliasname);
      zombiemeleexanim = target asm::asm_getxanim(zombietostatename, zombiemeleeanim);

      if(function_ce8c28ad77b46134(meleexanim, zombiemeleexanim)) {
        self.meleeanimalias = aliasname;
        target.meleeanimalias = aliasname;
        target.syncedmeleepartner = self;
        return 1;
      }

      continue;
    }

    if(evaluatesyncedmeleebyxanim(meleexanim, var_f1c4df162f33bbcd)) {
      self.meleeanimalias = aliasname;
      target.meleeanimalias = aliasname;
      target.syncedmeleepartner = self;
      return 1;
    }
  }

  return 0;
}

function melee_setmeleetimer(unittype, factor) {
  if(!isDefined(anim)) {
    return;
  }

  if(!isDefined(anim.meleechargeintervals)) {
    return;
  }

  if(!isDefined(unittype)) {
    return;
  }

  if(!isDefined(factor)) {
    factor = 1;
  }

  if(isPlayer(self.meleetarget) && isDefined(anim.meleechargeplayerintervals[self.unittype])) {
    anim.meleechargeplayertimers[self.unittype] = gettime() + anim.meleechargeplayerintervals[self.unittype] * factor;
    return;
  }

  if(isDefined(anim.meleechargeintervals[self.unittype])) {
    anim.meleechargetimers[self.unittype] = gettime() + anim.meleechargeintervals[self.unittype] * factor;
  }
}

function melee_calcsyncdirection() {
  assert(self.in_melee);
  target = self.meleetarget;
  assert(isDefined(target));
  targettome = self.origin - target.origin;
  var_792b9485351dcf17 = vectortoyaw(targettome);
  anglediff = angleclamp180(var_792b9485351dcf17 - target.angles[1]);

  if(-45 < anglediff && anglediff < 45) {
    return "\f";
  } else if(anglediff > 135 || anglediff < -135) {
    return "\x19";
  } else if(anglediff > 45) {
    return "P";
  }

  return "\xbb";
}

function melee_waitfordroppedweapon(statename) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  self waittill("\xcfdJW\x7f#y\xdc\x84I\xc2\x98\x12Z", droppedweapon);

  if(isDefined(droppedweapon)) {
    assert(self.in_melee);
    self.var_e5b811e1f9104051 = droppedweapon;
  }
}

function melee_synced_setup(statename, battacker) {
  self.meleestatename = statename;
  self.bmeleeinprogress = 1;
  self.meleeweapon = self.weapon;
  self.meleeweaponslot = utility::getcurrentweaponslotname();
  self.var_60c1e971ac2080e7 = 1;

  if(battacker) {
    melee_setmeleetimer(self.unittype);
    self.syncedmeleetarget = self.meleetarget;
  } else {
    self.syncedmeleetarget = self.meleepartner;
  }

  if(self.unittype == "\xdf~") {
    self.hackable = 0;
    self.ignoreme = 1;
  }
}

function melee_unlink() {
  self unlink();

  if(isDefined(self.meleepartner) && isalive(self.meleepartner)) {
    self.meleepartner animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa");
    self.meleepartner orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.meleepartner.angles[1]);
  }

  self animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa");
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.angles[1]);
}

function chooseanim_syncmelee(asmname, statename, params) {
  assert(isDefined(self.meleeanimalias));
  return asm::asm_lookupanimfromalias(statename, self.meleeanimalias);
}

function melee_decide_winner() {
  assert(self.in_melee);
  assert(isDefined(self.meleetarget));
  target = self.meleetarget;
  assert(target.in_melee);

  if(istrue(self.meleealwayswin)) {
    assert(!isDefined(target.magic_bullet_shield));
    self.var_6943b73195d42c91 = 1;
    target.var_6943b73195d42c91 = 0;
    return;
  } else if(istrue(target.meleealwayswin)) {
    assert(!isDefined(self.magic_bullet_shield));
    self.var_6943b73195d42c91 = 0;
    target.var_6943b73195d42c91 = 1;
    return;
  }

  if(isDefined(self.magic_bullet_shield)) {
    assert(!isDefined(target.magic_bullet_shield));
    self.var_6943b73195d42c91 = 1;
    target.var_6943b73195d42c91 = 0;
    return;
  }

  if(isDefined(target.magic_bullet_shield)) {
    self.var_6943b73195d42c91 = 0;
    target.var_6943b73195d42c91 = 1;
    return;
  }

  self.var_6943b73195d42c91 = utility::cointoss();
  target.var_6943b73195d42c91 = !self.var_6943b73195d42c91;
}

function melee_instantkill(asmname, statename, params) {
  self kill(self.origin + anglesToForward(self.angles));
}

function playmeleeanim_synced(asmname, statename, params) {
  assert(self.in_melee);
  assert(isDefined(self.meleetarget));
  self.bmeleestarted = 1;
  target = self.meleetarget;
  meleeanim = asm::asm_getanim(asmname, statename);
  meleexanim = asm::asm_getxanim(statename, meleeanim);
  asm::asm_fireephemeralevent("\xc3\xd8\x90\x94.;\xa3YY\xa3B2", "\x98\xcav-7");
  melee_synced_setup(statename, 1);
  stoptimes = getnotetracktimes(meleexanim, "\xb6ec\x95\xac\xd77Go8");

  if(stoptimes.size > 0) {
    self.var_876e10ea898f9830 = 1;
  }

  interacttimes = getnotetracktimes(meleexanim, "\xd6e\xc6V\x95_in\xa3+\xc9\v\x8dt");

  if(interacttimes.size > 0) {
    self.var_fc2bd75e948c0e22 = 1;
  }

  if(self.type != "\x9b\x11\"\xd6\xfb;") {
    thread melee_waitfordroppedweapon(statename);
  }

  if(isDefined(target getinteractionid())) {
    target leaveinteraction();
  }

  target asm::asm_setstate(statename + "C\x01\xc6\x96\xd4\x83\x17");

  if(target.type == "\x9b\x11\"\xd6\xfb;") {
    self.var_41d5b62d1558c566 = 1;
  }

  self animmode("\xee\xedc\xfb\xfa}f\x11y\xb9>\x9f\xaa");

  if(isDefined(self.var_ca7d2f6087c466f5)) {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.var_ca7d2f6087c466f5);
  }

  if(!self.var_6943b73195d42c91 && !self.var_2debd41d8e7e5bfe) {
    val::set("(\xd1)\xf3\x99n\x94\xd0\x99\x84\x90\x87", "Kg7{N\xac[e", 1);
    val::set("(\xd1)\xf3\x99n\x94\xd0\x99\x84\x90\x87", "/Z\xf4]&\x16\xc1\x9b7\x9d\x1a\xdb\xd9\x10\x81\x84", 0);
  }

  self aisetanim(statename, meleeanim);
  asm::asm_playfacialanim(asmname, statename, meleexanim);
  thread playmeleeanim_synced_waitforpartnerexit(asmname, statename);
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  lastnotetrack = asm::asm_donotetracks(asmname, statename, &melee_handlenotetracks);

  if((lastnotetrack == "\x13\xc8\x03\xe5\xcfr\b\xb6n\x90\xa8" || !istrue(self.var_6943b73195d42c91)) && !istrue(self.var_2debd41d8e7e5bfe)) {
    self.a.nodeath = 0;

    if(isDefined(self.meleetarget) && self.meleetarget.in_melee) {
      self.meleetarget.var_34d820d3eeba38b3 = 1;
    }

    if(isDefined(self.magic_bullet_shield)) {
      if(!isDefined(lastnotetrack)) {
        lastnotetrack = "\xed\x1d\va\x1e\xf6\xe5\x88\x8a";
      }

      if(isDefined(target)) {
        msg1 = "\xf4m\x18\x90Yk\x87\x93\xb0\xa8K\xa0\xb3NeJ\xd8d\xea\xda08" + self getentitynumber() + "C\xb3" + self.classname + "\xc0\xbf\xcc:cwb\xa2\xd5\xfe\x03\xd3\x80\xee\x06\x98\xf6z\xf7R\x9c\xb5\xff\x8d\xe5\x90\xb6\xaa";
        msg2 = "\x01R\xe9\xa8\x90\xd6\x10G\x13T\xb0\x85AU\xfc\x90" + lastnotetrack + " Z\xd8\xd4\x9em\n\x86\xfe\x18:\xa2\xf8\xa7N\xf5\x8b\xc0\xe0\xbb)\xfa\x15}\xce" + target getentitynumber() + "C\xb3" + target.classname + "\x8a\xc6";
        msg3 = "KJu\xf6\xef\xe5cfn\xe8\x19\\Do\xc0]J\x132\xd0" + self.var_6943b73195d42c91 + "|(\xb2\xd8X\x8bI\xad$\x1d\x14{\xed@\xf5\xa2'|\x94\x91\x94\x90" + self.var_2debd41d8e7e5bfe + "\xda";
        msg4 = "&TSB\xe2\xe45\x15\x8fT\xbe\a\xfb|\x8aG\x1b)\xec\xe7\x88}" + target.var_6943b73195d42c91 + "p\x93\xe6\xc9\xc4\xd0\xc1\x85$j\xab\xa8\xcf\xcc\x8d3\x1b\x9e\x94\xd6\xa2^\x84-" + target.var_2debd41d8e7e5bfe + "\xda";
        assertmsg(msg1 + msg2 + msg3 + msg4);
      } else {
        msg1 = "\xf4m\x18\x90Yk\x87\x93\xb0\xa8K\xa0\xb3NeJ\xd8d\xea\xda08" + self getentitynumber() + "C\xb3" + self.classname + "\xc0\xbf\xcc:cwb\xa2\xd5\xfe\x03\xd3\x80\xee\x06\x98\xf6z\xf7R\x9c\xb5\xff\x8d\xe5\x90\xb6\xaa";
        msg2 = "\x01R\xe9\xa8\x90\xd6\x10G\x13T\xb0\x85AU\xfc\x90" + lastnotetrack + "\x94@\xdfy\x85\xe4-1\x94'-\xee\xf8\x93|f\x1e\x90\xb7\xd7'\xadPc\xec6";
        msg3 = "KJu\xf6\xef\xe5cfn\xe8\x19\\Do\xc0]J\x132\xd0" + self.var_6943b73195d42c91 + "|(\xb2\xd8X\x8bI\xad$\x1d\x14{\xed@\xf5\xa2'|\x94\x91\x94\x90" + self.var_2debd41d8e7e5bfe + "\xda";
        assertmsg(msg1 + msg2 + msg3);
      }
    }

    if(target.type == "\x9b\x11\"\xd6\xfb;") {
      self kill(self.origin + anglesToForward(self.angles));
      return;
    }

    self kill();
  }
}

function playmeleeanim_synced_survive(asmname, statename, params) {
  assert(!self.in_melee);
  surviveanim = asm::asm_getanim(asmname, statename);
  survivexanim = asm::asm_getxanim(statename, surviveanim);
  self aisetanim(statename, surviveanim);
  asm::asm_playfacialanim(asmname, statename, survivexanim);
  self.meleeanimalias = undefined;
  asm::asm_donotetracks(asmname, statename, &melee_handlenotetracks);
}

function playmeleeanim_synced_cleanup(asmname, statename, params) {
  if(self.in_melee) {
    if(isDefined(self.syncedmeleepartner)) {
      self.syncedmeleepartner notify("w\xf6=\x0e\xe1\xbf\xbc\x87\xd5\x98");
      self.syncedmeleepartner = undefined;
    } else if(isDefined(self.meleepartner)) {
      self.meleepartner notify("w\xf6=\x0e\xe1\xbf\xbc\x87\xd5\x98");
    }
  }

  self.var_41d5b62d1558c566 = 0;

  if(isalive(self) && istrue(self.in_melee) && self.type != "\x9b\x11\"\xd6\xfb;") {
    melee_droppedweaponrestore();
  }

  if(isalive(self)) {
    val::reset_all("(\xd1)\xf3\x99n\x94\xd0\x99\x84\x90\x87");
  }

  self unlink();

  if(self.unittype == "\xdf~") {
    self.hackable = 1;
    self.ignoreme = 0;
  }

  self function_98a26c86661482ad(0);
}

function playmeleeanim_synced_victim(asmname, statename, params) {
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");
  assert(self.in_melee);
  self.bmeleestarted = 1;
  self animmode("\r\x9e^\xe3\x88\xf7,\x1f\x15");

  if(isDefined(self.var_ca7d2f6087c466f5)) {
    self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", self.var_ca7d2f6087c466f5);
  } else {
    self orientmode("\x99\xc2l\xb2\x806\xbaNN\x95\xb9\xa3");
  }

  if(!self.var_6943b73195d42c91 && !self.var_2debd41d8e7e5bfe) {
    val::set("(\xd1)\xf3\x99n\x94\xd0\x99\x84\x90\x87", "Kg7{N\xac[e", 1);
    val::set("(\xd1)\xf3\x99n\x94\xd0\x99\x84\x90\x87", "/Z\xf4]&\x16\xc1\x9b7\x9d\x1a\xdb\xd9\x10\x81\x84", 0);
  }

  melee_synced_setup(statename, 0);

  if(self.type != "\x9b\x11\"\xd6\xfb;") {
    thread melee_waitfordroppedweapon(statename);
  }

  victimanim = asm::asm_getanim(asmname, statename);
  victimxanim = asm::asm_getxanim(statename, victimanim);
  self aisetanim(statename, victimanim);
  asm::asm_playfacialanim(asmname, statename, victimxanim);
  stoptimes = getnotetracktimes(victimxanim, "\xb6ec\x95\xac\xd77Go8");

  if(stoptimes.size > 0) {
    self.var_876e10ea898f9830 = 1;
  }

  interacttimes = getnotetracktimes(victimxanim, "\xd6e\xc6V\x95_in\xa3+\xc9\v\x8dt");

  if(interacttimes.size > 0) {
    self.var_fc2bd75e948c0e22 = 1;
  }

  interactendtimes = getnotetracktimes(victimxanim, "\x8e\f\xe4I");

  if(interactendtimes.size > 0) {
    self.var_69e3d8c453f8f96b = 1;
  }

  thread playmeleeanim_synced_waitforpartnerexit(asmname, statename);
  lastnotetrack = asm::asm_donotetracks(asmname, statename, &melee_handlenotetracks);

  if((lastnotetrack == "\x13\xc8\x03\xe5\xcfr\b\xb6n\x90\xa8" || isDefined(self.var_6943b73195d42c91) && !self.var_6943b73195d42c91) && !self.var_2debd41d8e7e5bfe) {
    self.a.nodeath = 0;

    if(isDefined(self.meleepartner) && self.meleepartner.in_melee) {
      self.meleepartner.var_34d820d3eeba38b3 = 1;
    }

    self kill();
  }
}

function waitforpartnerdelete(statename, partner) {
  if(!isDefined(partner)) {
    return;
  }

  partner waittill("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self notify("w\xf6=\x0e\xe1\xbf\xbc\x87\xd5\x98");
}

function playmeleeanim_synced_waitforpartnerexit(asmname, statename) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon(statename + "\x1b\xe0K\x01;P\xfdf\x98");

  if(isDefined(self.syncedmeleepartner)) {
    childthread waitforpartnerdelete(statename, self.syncedmeleepartner);
  } else {
    childthread waitforpartnerdelete(statename, self.meleepartner);
  }

  self waittill("w\xf6=\x0e\xe1\xbf\xbc\x87\xd5\x98");
  self unlink();
  var_62f64379863748c0 = asm::asm_eventfired(asmname, "\xd6e\xc6V\x95_in\xa3+\xc9\v\x8dt");

  if(self.var_fc2bd75e948c0e22 && !var_62f64379863748c0) {
    self.var_2debd41d8e7e5bfe = 1;
  } else if(var_62f64379863748c0 && !asm::asm_eventfired(asmname, "\x13\xc8\x03\xe5\xcfr\b\xb6n\x90\xa8")) {
    if(self.var_69e3d8c453f8f96b) {
      self.var_2debd41d8e7e5bfe = !asm::asm_eventfired(asmname, "\x8e\f\xe4I");
    } else {
      self.var_2debd41d8e7e5bfe = 0;
    }
  }

  if(isDefined(self.var_6943b73195d42c91) && !self.var_6943b73195d42c91) {
    if(istrue(self.var_2debd41d8e7e5bfe)) {
      if(asm::asm_eventfired(asmname, ":\x8ej\x99o\x87v$\r\xfe\x90\x02\xdf$\x9f~\x06G}dn")) {
        melee_instantkill();
      } else {
        self.var_a10ebedcfbd0300a = 1;
        self.var_eca6f629351cc18f = 0;
      }
    } else if(asm::asm_eventfired(asmname, "fQL\xf0\xad=\x88\xcf\x9f\xcb\x9a\xf8\xcb\xeb\x06\x19W")) {
      self.var_ff8c32e0ac862766 = 1;
    } else if(asm::asm_eventfired(asmname, "\xb6ec\x95\xac\xd77Go8")) {
      self kill();
    } else if(istrue(self.var_876e10ea898f9830)) {
      self.var_a10ebedcfbd0300a = 1;
    } else {
      self.var_ff8c32e0ac862766 = 1;
    }

    return;
  }

  if(asm::asm_eventfired(asmname, "\xcciN\xca")) {
    self.var_ff8c32e0ac862766 = 1;
    return;
  }

  if(!istrue(self.var_34d820d3eeba38b3)) {
    self.var_a10ebedcfbd0300a = 1;
  }
}

function function_8f8a5bda7694d077(final_alias, append_code) {
  append = "";

  switch (append_code) {
    case #"hash_a13dd2b8b51545eb":
      append = "7AF\xce\xc9\x06";

      if(istrue(self.armored)) {
        append = "\x02\xeaD\x80~";
      }

      break;
    case #"hash_4f7f2f56f62275dc":
      append = "\xdd\x96\xa6\x06\xde";
      my_surface = self.lastgroundtype;

      if(isDefined(my_surface)) {
        switch (my_surface) {
          case #"hash_cacc49f5cefe9c2":
          case #"hash_fb5a4fd62140d3d":
          case #"hash_1b9205edae40e596":
          case #"hash_1d3c8b96a9c71b54":
          case #"hash_3931479c445fb9b9":
          case #"hash_4d63389017f81514":
          case #"hash_4f863c6e34468e29":
          case #"hash_51929a2eb8e4f743":
          case #"hash_519950fd846289c6":
          case #"hash_57b9e7028fd773ba":
          case #"hash_590687995d01030e":
          case #"hash_5dab8ddea3468324":
          case #"hash_67e845c97d1f9eda":
          case #"hash_7fe735e403d9fe08":
          case #"hash_84a41da455643bc9":
          case #"hash_886109ae17c9aa73":
          case #"hash_8c9d4c67dcde81f2":
          case #"hash_8dede5336d28890d":
          case #"hash_8f53c9965f23a6cd":
          case #"hash_91afe7576024a903":
          case #"hash_d70d4c17673f4162":
          case #"hash_df0e712b7aee0b97":
          case #"hash_f4d3c7f04f8ef31d":
          case #"hash_f5afef0d74babaca":
          case #"hash_f9100fc94321f813":
            append = "3\xe3\x02\xcb\x92";
            break;
        }
      }

      break;
  }

  final_alias += append;

  if(soundexists(final_alias)) {
    self playSound(final_alias);
  }
}

function melee_handlenotetracks(note) {
  prefix = getsubstr(note, 0, 3);
  used_prefix = 0;

  switch (prefix) {
    case #"hash_8966586c51e34031":
      used_prefix = 1;
      alias = getsubstr(note, 3);
      self playSound(alias);
      break;
    case #"hash_6d20b46c4370528e":
      used_prefix = 1;
      truncatednotetrack = getsubstr(note, 3);
      params = strtok(truncatednotetrack, "\x16");

      if(params.size >= 2) {
        function_8f8a5bda7694d077(params[0], params[1]);
      }

      break;
  }

  if(used_prefix) {
    return;
  }

  switch (note) {
    case #"hash_49d2de8a43d395fa":
      if(!self.var_a10ebedcfbd0300a) {
        if(isDefined(self.meleetarget)) {
          if(isalive(self.meleetarget)) {
            self linktoblendtotag(self.meleetarget, "\x81\xe4\xef\xf50^av", 1, 1);
          }
        } else if(self.var_9ce8527991f3aa67 && isDefined(self.syncedmeleepartner)) {
          if(isalive(self.syncedmeleepartner)) {
            self linktoblendtotag(self.syncedmeleepartner, "\x81\xe4\xef\xf50^av", 1, 1);
          }
        }
      }

      break;
    case #"hash_a74d3b6faa5ac811":
      if(self.var_60c1e971ac2080e7) {
        melee_unlink();
      } else {
        self unlink();
      }

      break;
    case #"hash_9b60ee8bd4984ddf":
      shared::dropallaiweapons();

      if(isDefined(level.var_38a0c3fb60e0f25d) && isDefined(level.var_2a8a63b50223553b) && isDefined(level.var_7071dca1156074d3)) {
        self.alreadydroppedweapon = 1;
        itembundle = self[[level.var_2a8a63b50223553b]]();
        spawnoptions = [[level.var_38a0c3fb60e0f25d]](self.origin);
        [[level.var_7071dca1156074d3]](itembundle, spawnoptions);
      }

      if(!istrue(self.alreadydroppedweapon) && isDefined(level.var_2dca45e7f54475ef) && isDefined(level.var_b51f20a69b83acc2)) {
        self.alreadydroppedweapon = 1;
        weapon = self[[level.var_2dca45e7f54475ef]]();
        [[level.var_b51f20a69b83acc2]](weapon, self.origin);
      }

      break;
    case #"hash_36a959dce6e4f5bc":
      self.var_7b66db725844012a = 1;
      break;
    case #"hash_b11f0ef79e138572":
      self.var_7b66db725844012a = 1;
      break;
    case #"hash_9a4dd9ac49e5d8ae":
      return note;
    case #"hash_fd45bbe21f535106":
      self attach("\xffd^\x9a\x93fS\xc3o3L\xd3q\x1e\xe9\xe0\xac\xe1\x8ea\xd0|\x05\x83O", "TP:\xeb\xa4N\x84\xa0\xe4\"", 1);
      break;
    case #"hash_78af604e22ccf1d4":
      self detach("\xffd^\x9a\x93fS\xc3o3L\xd3q\x1e\xe9\xe0\xac\xe1\x8ea\xd0|\x05\x83O", "TP:\xeb\xa4N\x84\xa0\xe4\"", 1);
      break;
    case #"hash_23b3ca8a2f927c01":
      self playSound("\xa4\xd3%cP:]\xbeW\x9eV\xbd,W\t@/:\xbdy");
      playFXOnTag(level._effect["\x8f\xddY\xa34f\x817P&\b\xf6d\x8e"], self, "\xe4\x8e\xee\xae\x83m\xbd\x8f\rMg\xfb");
      break;
    case #"hash_9ccf1d54a8f2ba84":
      break;
  }
}

function melee_droppedweaponrestore() {
  assert(isDefined(self));
  assert(self.in_melee);

  if(!isnullweapon(self.weapon) && !isnullweapon(self.lastweapon)) {
    return;
  }

  if(isundefinedweapon(self.meleeweapon)) {
    return;
  }

  shared::forceuseweapon(self.meleeweapon, self.meleeweaponslot);

  if(isDefined(self.var_e5b811e1f9104051)) {
    self.var_e5b811e1f9104051 delete();
    self.var_e5b811e1f9104051 = undefined;
  }
}