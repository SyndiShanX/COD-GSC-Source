/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\melee.gsc
**************************************/

#include maps\_utility;
#include animscripts\utility;
#include animscripts\setposemovement;
#include animscripts\combat_utility;
#include animscripts\debug;
#include animscripts\anims;
#include common_scripts\utility;
#include animscripts\face;
#include animscripts\shared;
#include animscripts\run;

melee_tryexecuting() {
  if(!isDefined(self.enemy))
    return false;

  if(is_true(self.dontmelee) || is_true(self.enemy.dontmeleeme))
    return false;

  if(self.enemy isvehicle() || isai(self.enemy) && self.enemy.isbigdog)
    return false;

  if(!melee_acquiremutex(self.enemy))
    return false;

  melee_resetaction();

  if(!melee_chooseaction()) {
    melee_releasemutex(self.enemy);
    return false;
  }

  self animcustom(::melee_mainloop, ::melee_endscript);
}

melee_resetaction() {
  assert(isDefined(self.melee));
  self.melee.target = self.enemy;
  self.melee.initiated = 0;
  self.melee.inprogress = 0;
}

melee_chooseaction() {
  if(!melee_isvalid())
    return false;

  self.melee.initiated = 1;

  if(melee_aivsai_chooseaction()) {
    self.melee.func = ::melee_aivsai_main;
    return true;
  }

  if(melee_standard_chooseaction()) {
    if(isDefined(self.specialmelee_standard))
      self.melee.func = self.specialmelee_standard;
    else
      self.melee.func = ::melee_standard_main;

    return true;
  }

  self.melee.func = undefined;
  self.nextmeleechecktime = gettime() + 150;
  self.nextmeleechecktarget = self.melee.target;
  return false;
}

melee_updateandvalidatestartpos() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.startpos));
  assert(isDefined(self.melee.target));
  ignoreactors = 1;
  distfromtarget2d = distance2d(self.melee.startpos, self.melee.target.origin);

  if(distfromtarget2d < 32) {
    dirtostartpos2d = vectornormalize((self.melee.startpos[0] - self.melee.target.origin[0], self.melee.startpos[1] - self.melee.target.origin[1], 0));

    if(distfromtarget2d <= 31.9)
      return false;

    self.melee.startpos = self.melee.startpos + dirtostartpos2d * (32 - distfromtarget2d);
    assert(distance2d(self.melee.startpos, self.melee.target.origin) >= 31.9, "Invalid distance to target: " + distance2d(self.melee.startpos, self.melee.target.origin) + ", should be more than " + 31.9);
    ignoreactors = 0;
  }

  floorpos = self getdroptofloorposition(self.melee.startpos);

  if(!isDefined(floorpos))
    return false;

  if(abs(self.melee.startpos[2] - floorpos[2]) > 51.2)
    return false;

  if(abs(self.origin[2] - floorpos[2]) > 51.2)
    return false;

  self.melee.startpos = floorpos;
  assert(distance2d(self.melee.startpos, self.melee.target.origin) >= 31.9, "Invalid distance to target: " + distance2d(self.melee.startpos, self.melee.target.origin) + ", should be more than " + 31.9);

  if(!self maymovetopoint(self.melee.startpos, 1))
    return false;

  if(isDefined(self.melee.starttotargetcornerangles)) {
    targettostartpos = self.melee.startpos - self.melee.target.origin;
    cornerdir = anglestoforward(self.melee.starttotargetcornerangles);
    cornerdirlen = vectordot(cornerdir, targettostartpos);
    maymovetargetorigin = self.melee.startpos - cornerdir * cornerdirlen;
    cornertotarget = self.melee.target.origin - maymovetargetorigin;
    cornertotargetlen = distance2d(self.melee.target.origin, maymovetargetorigin);

    if(cornertotargetlen < 32)
      maymovetargetorigin = maymovetargetorigin - cornertotarget * ((32 - cornertotargetlen) / 32);
  } else {
    dirtostartpos2d = vectornormalize((self.melee.startpos[0] - self.melee.target.origin[0], self.melee.startpos[1] - self.melee.target.origin[1], 0));
    maymovetargetorigin = self.melee.target.origin + dirtostartpos2d * 32;
  }

  assert(isDefined(maymovetargetorigin));

  if(!self maymovefrompointtopoint(self.melee.startpos, maymovetargetorigin))
    return false;

  return true;
}

melee_isvalid() {
  if(!isDefined(self.melee.target))
    return false;

  target = self.melee.target;

  if(isDefined(target.dontmelee) && target.dontmelee)
    return false;

  enemydistancesq = distancesquared(self.origin, target.origin);

  if(isDefined(self.meleechargedistsq))
    chargedistsq = self.meleechargedistsq;
  else if(isplayer(target))
    chargedistsq = 40000;
  else
    chargedistsq = 25600;

  if(!self.melee.initiated && enemydistancesq > chargedistsq)
    return false;

  if(!isalive(self))
    return false;

  if(isDefined(self.a.nofirstframemelee) && self.a.scriptstarttime >= gettime() + 50)
    return false;

  if(!isplayer(target)) {
    if(isDefined(self.nextmeleechecktime) && isDefined(self.nextmeleechecktarget) && gettime() < self.nextmeleechecktime && self.nextmeleechecktarget == target)
      return false;
  }

  if(self.a.pose == "back" || self.a.pose == "prone")
    return false;

  if(isDefined(self.grenade))
    return false;

  if(!isalive(target))
    return false;

  if(isDefined(target.dontattackme) || isDefined(target.ignoreme) && target.ignoreme)
    return false;

  if(!isai(target) && !isplayer(target))
    return false;

  if(isai(target)) {
    if(target isinscriptedstate())
      return false;

    if(is_true(target.doinglongdeath) || target.delayeddeath)
      return false;
  }

  if(isplayer(target))
    enemypose = target getstance();
  else
    enemypose = target.a.pose;

  if(enemypose != "stand" && enemypose != "crouch")
    return false;

  if(isDefined(self.magic_bullet_shield) && isDefined(target.magic_bullet_shield))
    return false;

  if(isDefined(target.grenade))
    return false;

  if(self.melee.inprogress)
    yawthreshold = 110;
  else
    yawthreshold = 60;

  yawtoenemy = angleclamp180(self.angles[1] - vectortoangles(target.origin - self.origin)[1]);

  if(abs(yawtoenemy) > yawthreshold)
    return false;

  if(enemydistancesq <= 4096)
    return true;

  if(self.melee.inprogress)
    return false;

  if(!isplayer(target)) {
    if(isDefined(self.nextmeleechargetime) && isDefined(self.nextmeleechargetarget) && gettime() < self.nextmeleechargetime && self.nextmeleechargetarget == target)
      return false;
  }

  return true;
}

melee_startmovement() {
  self.melee.playingmovementanim = 1;
  self.a.movement = "run";
}

#using_animtree("generic_human");

melee_stopmovement() {
  self clearanim( % body, 0.2);
  self.melee.playingmovementanim = undefined;
  self.a.movement = "stop";
  self orientmode("face default");
}

melee_mainloop() {
  self endon("killanimscript");
  self endon("end_melee");
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.func));

  while(true) {
    prevfunc = self.melee.func;
    [
      [self.melee.func]
    ]();

    if(!isDefined(self.melee.func) || prevfunc == self.melee.func) {
      break;
    }
  }
}

melee_standard_delaystandardcharge(target) {
  if(!isDefined(target)) {
    return;
  }
  self.nextmeleestandardchargetime = gettime() + 2500;
  self.nextmeleestandardchargetarget = target;
}

melee_standard_checktimeconstraints() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.target));
  targetdistsq = distancesquared(self.melee.target.origin, self.origin);

  if(targetdistsq > 4096 && isDefined(self.nextmeleestandardchargetime) && isDefined(self.nextmeleestandardchargetarget) && gettime() < self.nextmeleestandardchargetime && self.nextmeleestandardchargetarget == self.melee.target)
    return false;

  return true;
}

melee_standard_chooseaction() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.target));

  if(isDefined(self.melee.target.magic_bullet_shield))
    return 0;

  if(!melee_standard_checktimeconstraints())
    return 0;

  if(isDefined(self.melee.target.specialmeleechooseaction))
    return 0;

  return melee_standard_updateandvalidatetarget();
}

melee_standard_resetgiveuptime() {
  if(isDefined(self.meleechargedistsq))
    chargedistsq = self.meleechargedistsq;
  else if(isplayer(self.melee.target))
    chargedistsq = 40000;
  else
    chargedistsq = 25600;

  if(distancesquared(self.origin, self.melee.target.origin) > chargedistsq)
    self.melee.giveuptime = gettime() + 3000;
  else
    self.melee.giveuptime = gettime() + 1000;
}

melee_standard_main() {
  self animmode("zonly_physics");
  melee_standard_resetgiveuptime();

  while(true) {
    if(!isDefined(self.melee.target)) {
      break;
    }

    melee_notify_wrapper();

    if(self.animtype == "default" && animarrayanyexist("melee_2", "combat") && self weaponanims() == "rifle")
      self.melee.meleeanimvarientindex = randomint(2);
    else
      self.melee.meleeanimvarientindex = 0;

    if(!melee_standard_getinposition()) {
      self.nextmeleechargetime = gettime() + 1500;
      self.nextmeleechargetarget = self.melee.target;
      break;
    }

    assert(self.a.pose == "stand" || self.a.pose == "crouch");
    self orientmode("face point", self.melee.target.origin);
    self setflaggedanimknoballrestart("meleeanim", animarray("melee_" + self.melee.meleeanimvarientindex, "combat"), % body, 1, 0.2, self.moveplaybackrate);
    self.melee.inprogress = 1;

    if(!melee_standard_playattackloop()) {
      melee_standard_delaystandardcharge(self.melee.target);
      break;
    }
  }

  self animmode("none");
}

melee_standard_playattackloop() {
  while(true) {
    self waittill("meleeanim", note);

    if(note == "end")
      return true;

    if(note == "stop") {
      if(!melee_chooseaction())
        return false;

      assert(isDefined(self.melee.func));

      if(self.melee.func != ::melee_standard_main)
        return true;
    }

    if(note == "fire") {
      if(isDefined(self.melee.target)) {
        self animscripts\face::saygenericdialogue("swing");
        oldhealth = self.melee.target.health;
        self melee();

        if(isDefined(self.melee.target) && self.melee.target.health < oldhealth) {
          if(isplayer(self.melee.target))
            self.melee.target playsoundtoplayer("wpn_melee_hit_plr", self.melee.target);

          melee_standard_resetgiveuptime();
        }
      }
    }
  }
}

melee_standard_updateandvalidatetarget() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isDefined(self.melee.target))
    return 0;

  if(!melee_isvalid())
    return 0;

  dirtotarget = vectornormalize(self.melee.target.origin - self.origin);
  self.melee.startpos = self.melee.target.origin - 40.0 * dirtotarget;
  return melee_updateandvalidatestartpos();
}

distance2dsquared(a, b) {
  diff = (a[0] - b[0], a[1] - b[1], 0);
  return lengthsquared(diff);
}

melee_standard_getinposition() {
  if(!melee_standard_updateandvalidatetarget())
    return false;

  enemydistancesq = distance2dsquared(self.origin, self.melee.target.origin);
  self.a.pose = "stand";

  if(enemydistancesq <= 4096) {
    self.a.movement = "stop";
    self setflaggedanimknoball("readyanim", animarray("stand_2_melee_" + self.melee.meleeanimvarientindex, "combat"), % body, 1, 0.3, self.moveplaybackrate);
    self animscripts\shared::donotetracks("readyanim");
    return true;
  }

  self melee_playchargesound();
  prevenemypos = self.melee.target.origin;
  raisegunanimtraveldist = length(getmovedelta(animarray("run_2_melee_" + self.melee.meleeanimvarientindex, "combat"), 0, 1));
  shouldraisegundist = 48.0 + 32 + raisegunanimtraveldist;
  shouldraisegundistsq = shouldraisegundist * shouldraisegundist;
  shouldmeleedist = 64 + 32;
  shouldmeleedistsq = shouldmeleedist * shouldmeleedist;
  raisegunfullduration = getanimlength(animarray("run_2_melee_" + self.melee.meleeanimvarientindex, "combat")) * 1000 / self.moveplaybackrate;
  raisegunfinishduration = raisegunfullduration - 100;
  raisegunpredictduration = raisegunfullduration - 200;
  raisegunstarttime = 0;
  predictedenemydistsqafterraisegun = undefined;
  runanim = animscripts\run::getrunanim();

  if(isplayer(self.melee.target) && isDefined(self.enemy) && self.melee.target == self.enemy)
    self orientmode("face enemy");
  else
    self orientmode("face point", self.melee.target.origin);

  self setflaggedanimknoball("chargeanim", runanim, % body, 1, 0.3, self.moveplaybackrate);
  raisinggun = 0;

  while(true) {
    time = gettime();
    willbewithinrangewhengunisraised = isDefined(predictedenemydistsqafterraisegun) && predictedenemydistsqafterraisegun <= shouldraisegundistsq;

    if(!raisinggun) {
      if(willbewithinrangewhengunisraised) {
        melee_startmovement();
        self setflaggedanimknoballrestart("chargeanim", animarray("run_2_melee_" + self.melee.meleeanimvarientindex, "combat"), % body, 1, 0.2, self.moveplaybackrate);
        raisegunstarttime = time;
        raisinggun = 1;
      }
    } else {
      withinrangenow = enemydistancesq <= shouldraisegundistsq;

      if(time - raisegunstarttime >= raisegunfinishduration || !willbewithinrangewhengunisraised && !withinrangenow) {
        melee_startmovement();
        self setflaggedanimknoball("chargeanim", runanim, % body, 1, 0.3, self.moveplaybackrate);
        raisinggun = 0;
      }
    }

    self animscripts\shared::donotetracksfortime(0.1, "chargeanim");

    if(!melee_standard_updateandvalidatetarget()) {
      melee_stopmovement();
      return false;
    }

    enemydistancesq = distance2dsquared(self.origin, self.melee.target.origin);
    enemyvel = vectorscale(self.melee.target.origin - prevenemypos, 1 / (gettime() - time));
    prevenemypos = self.melee.target.origin;
    predictedenemyposafterraisegun = self.melee.target.origin + vectorscale(enemyvel, raisegunpredictduration);
    predictedenemydistsqafterraisegun = distance2dsquared(self.origin, predictedenemyposafterraisegun);

    if(raisinggun && enemydistancesq <= shouldmeleedistsq && (gettime() - raisegunstarttime >= raisegunfinishduration || !isplayer(self.melee.target))) {
      break;
    }

    if(!raisinggun && gettime() >= self.melee.giveuptime) {
      melee_stopmovement();
      return false;
    }
  }

  melee_stopmovement();
  return true;
}

melee_playchargesound() {
  if(!isDefined(self.a.nextmeleechargesound))
    self.a.nextmeleechargesound = 0;

  if(isDefined(self.enemy) && isplayer(self.enemy) || randomint(2) == 0) {
    if(gettime() > self.a.nextmeleechargesound) {
      self animscripts\face::saygenericdialogue("attack");
      self.a.nextmeleechargesound = gettime() + 4000;
    }
  }
}

melee_deathhandler_regular() {
  self endon("end_melee");
  self animscripts\shared::dropallaiweapons();
  return false;
}

melee_endscript_checkdeath() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isalive(self) && isDefined(self.melee.death)) {
    if(isDefined(self.melee.animateddeath))
      self.deathfunction = ::melee_deathhandler_delayed;
    else
      self.deathfunction = ::melee_deathhandler_regular;
  }
}

melee_endscript_checkpositionandmovement() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isalive(self)) {
    return;
  }
  if(isDefined(self.melee.playingmovementanim))
    melee_stopmovement();

  neworigin = self getdroptofloorposition();

  if(isDefined(neworigin))
    self forceteleport(neworigin, self.angles);
  else {
    println("Warning: Melee animation might have ended up in solid for entity #" + self getentnum());

  }
}

melee_endscript_checkweapon() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(isDefined(self.melee.hasknife))
    self detach("weapon_parabolic_knife", "TAG_INHAND");

  if(isalive(self))
    melee_droppedweaponrestore();
}

melee_endscript_checkstatechanges() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(isalive(self)) {
    if(isDefined(self.melee.wasallowingpain)) {
      if(self.melee.wasallowingpain)
        self enable_pain();
      else
        self disable_pain();
    }

    if(isDefined(self.melee.wasflashbangimmune))
      self setflashbangimmunity(self.melee.wasflashbangimmune);
  }
}

melee_endscript() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  self melee_unlink();
  self melee_endscript_checkdeath();
  self melee_endscript_checkpositionandmovement();
  self melee_endscript_checkweapon();
  self melee_endscript_checkstatechanges();

  if(isDefined(self.melee.partner))
    self.melee.partner notify("partner_end_melee");

  if(isDefined(self.meleeendfunc))
    self thread[[self.meleeendfunc]]();

  self melee_releasemutex(self.melee.target);
}

melee_acquiremutex(target) {
  assert(isDefined(self));
  assert(isDefined(target));

  if(isDefined(self.melee))
    return false;

  if(isDefined(target.melee))
    return false;

  self.melee = spawnstruct();

  if(!isplayer(target))
    target.melee = spawnstruct();

  return true;
}

melee_releasemutex(target) {
  assert(isDefined(self));
  self.melee = undefined;

  if(isDefined(target))
    target.melee = undefined;
}

melee_aivsai_main() {
  if(!melee_aivsai_getinposition()) {
    self.nextmeleechargetime = gettime() + 1500;
    self.nextmeleechargetarget = self.melee.target;
    return;
  }

  target = self.melee.target;
  assert(isalive(self) && isalive(target));
  assert(!isDefined(self.syncedmeleetarget));
  assert(!isDefined(target.syncedmeleetarget));
  assert(isDefined(self.melee.animname));
  assert(animhasnotetrack(self.melee.animname, "sync"));
  self melee_aivsai_schedulenotetracklink(target);

  if(self.melee.winner) {
    self.melee.death = undefined;
    target.melee.death = 1;
  } else {
    target.melee.death = undefined;
    self.melee.death = 1;
  }

  self.melee.partner = target;
  target.melee.partner = self;

  if(self.weapon == self.sidearm) {
    self gun_switchto(self.primaryweapon, "right");
    self.lastweapon = self.primaryweapon;
  }

  if(target.weapon == target.sidearm) {
    target gun_switchto(target.primaryweapon, "right");
    target.lastweapon = target.primaryweapon;
  }

  self.melee.weapon = self.weapon;
  self.melee.weaponslot = self getcurrentweaponslotname();
  target.melee.weapon = target.weapon;
  target.melee.weaponslot = target getcurrentweaponslotname();
  self.melee.inprogress = 1;
  target animcustom(::melee_aivsai_execute, ::melee_endscript);
  target thread melee_aivsai_animcustominterruptionmonitor(self);
  self.melee.target = undefined;
  self melee_aivsai_execute();
}

melee_aivsai_getinposition() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!melee_isvalid())
    return 0;

  melee_startmovement();
  self clearanim( % body, 0.2);
  self setanimknoball(animscripts\run::getrunanim(), % body, 1, 0.2, self.moveplaybackrate);
  self animmode("zonly_physics");
  self.keepclaimednode = 1;
  giveuptime = gettime() + 1500;
  assert(isDefined(self.melee.target));
  assert(isDefined(self.melee.target.origin));
  initialtargetorigin = self.melee.target.origin;

  self notify("MDBG_att_getInPosition", self.melee.target);
  self.melee.target notify("MDBG_def_getInPosition", self);

  while(melee_aivsai_getinposition_updateandvalidatetarget(initialtargetorigin, giveuptime)) {
    if(melee_aivsai_getinposition_issuccessful(initialtargetorigin))
      return melee_aivsai_getinposition_finalize(initialtargetorigin);

    self orientmode("face point", self.melee.startpos);
    wait 0.05;
  }

  melee_stopmovement();
  return 0;
}

melee_aivsai_schedulenotetracklink(target) {
  self.melee.syncnotetrackent = target;
  target.melee.syncnotetrackent = undefined;
}

melee_aivsai_execute() {
  self endon("killanimscript");
  self endon("end_melee");
  self notify("melee_aivsai_execute");
  assert(isDefined(self));

  if(!isDefined(self.melee)) {
    return;
  }
  self animmode("zonly_physics");
  self.a.special = "none";
  self.specialdeathfunc = undefined;
  self thread melee_droppedweaponmonitorthread();
  self thread melee_partnerendedmeleemonitorthread();

  if(isDefined(self.melee.faceyaw))
    self orientmode("face angle", self.melee.faceyaw);
  else
    self orientmode("face current");

  self.a.pose = "stand";
  self clearanim( % body, 0.2);

  if(isDefined(self.melee.death))
    self melee_disableinterruptions();

  self setflaggedanimknoballrestart("meleeAnim", self.melee.animname, % body, 1, 0.2, self.moveplaybackrate);
  endnote = self animscripts\shared::donotetracks("meleeAnim", ::melee_handlenotetracks);

  if(endnote == "melee_death" && isDefined(self.melee.survive)) {
    melee_droppedweaponrestore();
    self setflaggedanimknoballrestart("meleeAnim", self.melee.surviveanimname, % body, 1, 0.2, self.moveplaybackrate);
    endnote = self animscripts\shared::donotetracks("meleeAnim", ::melee_handlenotetracks);
  }

  if(isDefined(self.melee) && isDefined(self.melee.death)) {
    if(isDefined(self.overrideactordamage))
      self.overrideactordamage = undefined;

    self kill();
  }

  self.keepclaimednode = 0;
}

melee_aivsai_animcustominterruptionmonitor(attacker) {
  assert(isDefined(attacker));
  self endon("end_melee");
  self endon("melee_aivsai_execute");
  wait 0.1;

  if(isDefined(attacker))
    attacker notify("end_melee");

  self notify("end_melee");
}

melee_aivsai_getinposition_updateandvalidatetarget(initialtargetorigin, giveuptime) {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(initialtargetorigin));

  if(isDefined(giveuptime) && giveuptime <= gettime())
    return false;

  if(!melee_isvalid())
    return false;

  target = self.melee.target;
  positiondelta = distancesquared(target.origin, initialtargetorigin);
  assert(isDefined(self.melee.precisepositioning));

  if(self.melee.precisepositioning)
    positionthreshold = 256;
  else
    positionthreshold = 1296;

  if(positiondelta > positionthreshold)
    return false;

  self.melee.startpos = target.origin + self.melee.startposoffset;

  if(!melee_updateandvalidatestartpos())
    return false;

  return true;
}

melee_aivsai_getinposition_issuccessful(initialtargetorigin) {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.startpos));
  assert(isDefined(self.melee.target));
  assert(isDefined(initialtargetorigin));
  dist2dtostartpos = distancesquared((self.origin[0], self.origin[1], 0), (self.melee.startpos[0], self.melee.startpos[1], 0));

  if(dist2dtostartpos < 64 && abs(self.melee.startpos[2] - self.origin[2]) < 64)
    return true;

  dist2dfromstartpostotargetsq = distancesquared((initialtargetorigin[0], initialtargetorigin[1], 0), (self.melee.startpos[0], self.melee.startpos[1], 0));
  dist2dtotargetsq = distancesquared((self.origin[0], self.origin[1], 0), (self.melee.target.origin[0], self.melee.target.origin[1], 0));

  if(dist2dfromstartpostotargetsq > dist2dtotargetsq && abs(self.melee.target.origin[2] - self.origin[2]) < 64)
    return true;

  return false;
}

melee_aivsai_getinposition_finalize(initialtargetorigin) {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.precisepositioning));
  assert(isDefined(initialtargetorigin));
  melee_stopmovement();

  if(self.melee.precisepositioning) {
    assert(isDefined(self.melee.startpos));
    assert(isDefined(self.melee.startangles));
    self forceteleport(self.melee.startpos, self.melee.startangles);
    wait 0.05;
  } else {
    self orientmode("face angle", self.melee.startangles[1]);
    wait 0.05;
  }

  return melee_aivsai_getinposition_updateandvalidatetarget(initialtargetorigin);
}

melee_disableinterruptions() {
  self.melee.wasallowingpain = self.allowpain;
  self.melee.wasflashbangimmune = self.flashbangimmunity;
  self disable_pain();
  self setflashbangimmunity(1);
}

melee_needsweaponswap() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  return isDefined(self.melee.weapon) && self.melee.weapon != "none" && self.weapon != self.melee.weapon;
}

melee_droppedweaponrestore() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(self.weapon != "none" && self.lastweapon != "none") {
    return;
  }
  if(!isDefined(self.melee.weapon) || self.melee.weapon == "none") {
    return;
  }
  if(is_true(self.a.meleedontrestoreweapon)) {
    return;
  }
  self gun_switchto(self.melee.weapon, "right");

  if(isDefined(self.melee.droppedweaponent)) {
    self.melee.droppedweaponent delete();
    self.melee.droppedweaponent = undefined;
  }
}

melee_droppedweaponmonitorthread() {
  self endon("killanimscript");
  self endon("end_melee");
  assert(isDefined(self.melee));
  self waittill("weapon_dropped", droppedweapon);

  if(isDefined(droppedweapon)) {
    assert(isDefined(self.melee));
    self.melee.droppedweaponent = droppedweapon;
  }
}

melee_partnerendedmeleemonitorthread_shouldanimsurvive() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isDefined(self.melee.surviveanimname))
    return false;

  if(!isDefined(self.melee.surviveanimallowed))
    return false;

  return true;
}

melee_partnerendedmeleemonitorthread() {
  self endon("killanimscript");
  self endon("end_melee");
  assert(isDefined(self.melee));
  self waittill("partner_end_melee");

  if(isDefined(self.melee.death)) {
    if(isDefined(self.melee.animateddeath) || isDefined(self.melee.interruptdeath)) {
      if(isDefined(self.overrideactordamage))
        self.overrideactordamage = undefined;

      self kill();
    } else {
      self.melee.death = undefined;

      if(melee_partnerendedmeleemonitorthread_shouldanimsurvive())
        self.melee.survive = 1;
      else
        self notify("end_melee");
    }
  } else if(!isDefined(self.melee.unsynchappened))
    self notify("end_melee");
}

melee_unlink() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(!isDefined(self.melee.linked)) {
    return;
  }
  if(isDefined(self.syncedmeleetarget))
    self.syncedmeleetarget melee_unlinkinternal();

  self melee_unlinkinternal();
}

melee_unlinkinternal() {
  assert(isDefined(self));
  self unlink();
  self.syncedmeleetarget = undefined;

  if(!isalive(self)) {
    return;
  }
  assert(isDefined(self.melee.linked));
  self.melee.linked = undefined;
  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
}

melee_handlenotetracks_shoulddieafterunsync() {
  assert(isDefined(self));
  assert(isDefined(self.melee));

  if(animhasnotetrack(self.melee.animname, "melee_death")) {
    if(isDefined(self.melee.surviveanimname))
      return 0;
  }

  return isDefined(self.melee.death);
}

melee_handlenotetracks_unsync() {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  self melee_unlink();
  self.melee.unsynchappened = 1;

  if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee))
    self.melee.partner.melee.unsynchappened = 1;
}

melee_handlenotetracks_death(interruptanimation) {
  assert(isDefined(self));
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.death));

  if(isDefined(interruptanimation) && interruptanimation)
    self.melee.interruptdeath = 1;
  else
    self.melee.animateddeath = 1;
}

melee_handlenotetracks(note) {
  if(issubstr(note, "ps_")) {
    alias = getsubstr(note, 3);
    self playsound(alias);
    return;
  }

  if(note == "sync") {
    if(isDefined(self.melee.syncnotetrackent)) {
      self melee_aivsai_targetlink(self.melee.syncnotetrackent);
      self.melee.syncnotetrackent = undefined;
    }
  } else if(note == "unsync") {
    self melee_handlenotetracks_unsync();

    if(melee_handlenotetracks_shoulddieafterunsync())
      melee_handlenotetracks_death();
  } else if(note == "melee_interact")
    self.melee.surviveanimallowed = 1;
  else if(note == "melee_death") {
    if(isDefined(self.melee.survive)) {
      assert(!isDefined(self.melee.death));
      assert(isDefined(self.melee.surviveanimname));
      return note;
    }

    assert(isDefined(self.melee.death));
    melee_handlenotetracks_death();

    if(isDefined(self.melee.animateddeath))
      return note;
  } else if(note == "attach_knife") {
    self attach("weapon_parabolic_knife", "TAG_INHAND", 1);
    self.melee.hasknife = 1;
  } else if(note == "detach_knife") {
    self detach("weapon_parabolic_knife", "TAG_INHAND");
    self.melee.hasknife = undefined;
  } else if(note == "stab") {
    assert(isDefined(self.melee.hasknife) || isDefined(self.hasknifelikeweapon));
    self playsound("melee_knife_hit_body");

    if(isDefined(self.special_knife_attack_fx_name)) {
      if(isDefined(self.melee_weapon_ent))
        playfxontag(level._effect[self.special_knife_attack_fx_name], self.melee_weapon_ent, self.special_knife_attack_fx_tag);
      else
        playfxontag(level._effect[self.special_knife_attack_fx_name], self, self.special_knife_attack_fx_tag);
    } else
      playfxontag(level._effect["flesh_hit_knife"], self, "tag_origin");

    if(isDefined(self.melee.partner) && isDefined(self.melee.partner.melee))
      self.melee.partner melee_handlenotetracks_death(1);
  } else if(isDefined(self.meleenotetrackhandler))
    [[self.meleenotetrackhandler]](note);
}

melee_deathhandler_delayed() {
  self endon("end_melee");
  self animscripts\shared::donotetracksfortime(10.0, "meleeAnim");
  self animscripts\shared::dropallaiweapons();
  self startragdoll();
  return true;
}

melee_aivsai_chooseaction() {
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.target));
  target = self.melee.target;

  if(!isai(target) || target.type != "human")
    return false;

  if(isDefined(self.meleealwayswin) && isDefined(target.meleealwayswin))
    return false;

  if(is_true(self.disableaivsaimelee))
    return false;

  assert(!isDefined(self.magic_bullet_shield) || !isDefined(self.melee.target.magic_bullet_shield));

  if(isDefined(self.magic_bullet_shield) && isDefined(target.magic_bullet_shield))
    return false;

  if(isDefined(self.meleealwayswin) && isDefined(target.magic_bullet_shield) || isDefined(target.meleealwayswin) && isDefined(self.magic_bullet_shield))
    return false;

  if(isDefined(self.specialmeleechooseaction)) {
    if(![
        [self.specialmeleechooseaction]
      ]())
      return false;

    self.melee.precisepositioning = 1;
  } else if(isDefined(target.specialmeleechooseaction))
    return false;
  else if(melee_aivsai_specialcover_canexecute() && melee_aivsai_specialcover_chooseanimationandposition())
    self.melee.precisepositioning = 1;
  else {
    if(!melee_aivsai_exposed_chooseanimationandposition())
      return false;

    self.melee.precisepositioning = 0;
  }

  if(!isDefined(target.melee.faceyaw))
    target.melee.faceyaw = target.angles[1];

  self.melee.startposoffset = self.melee.startpos - target.origin;
  return true;
}

melee_aivsai_targetlink(target) {
  assert(isDefined(self));
  assert(isDefined(target));

  if(!isDefined(target.melee)) {
    assert(isDefined(self.melee.survive));
    return;
  }

  self melee_playchargesound();

  if(!isalive(target)) {
    return;
  }
  self.syncedmeleetarget = target;
  target.syncedmeleetarget = self;
  self.melee.linked = 1;
  target.melee.linked = 1;
  self linktoblendtotag(target, "tag_sync", 1, 1);
}

melee_aivsai_exposed_chooseanimationandposition_flip(anglediff) {
  flipanglethreshold = 90;

  if(self.melee.inprogress)
    flipanglethreshold = flipanglethreshold + 50;

  if(abs(anglediff) < flipanglethreshold)
    return false;

  target = self.melee.target;
  melee_decide_winner();

  if(self.melee.winner) {
    self.melee.animname = % ai_melee_f_awin_attack;
    target.melee.animname = % ai_melee_f_awin_defend;
    target.melee.surviveanimname = % ai_melee_f_awin_defend_survive;
  } else {
    self.melee.animname = % ai_melee_f_dwin_attack;
    target.melee.animname = % ai_melee_f_dwin_defend;
  }

  return true;
}

melee_aivsai_exposed_chooseanimationandposition_wrestle(anglediff) {
  wrestleanglethreshold = 100;

  if(self.melee.inprogress)
    wrestleanglethreshold = wrestleanglethreshold + 50;

  if(abs(anglediff) < wrestleanglethreshold)
    return false;

  target = self.melee.target;

  if(isDefined(target.magic_bullet_shield))
    return false;

  if(isDefined(target.meleealwayswin)) {
    assert(!isDefined(self.magic_bullet_shield));
    return false;
  }

  self.melee.winner = 1;
  self.melee.animname = % ai_melee_r_attack;
  target.melee.animname = % ai_melee_r_defend;
  target.melee.surviveanimname = % ai_melee_r_backdeath2;
  return true;
}

melee_aivsai_exposed_chooseanimationandposition_behind(anglediff) {
  if(-90 > anglediff || anglediff > 0)
    return false;

  target = self.melee.target;

  if(isDefined(target.magic_bullet_shield))
    return false;

  if(isDefined(target.meleealwayswin)) {
    assert(!isDefined(self.magic_bullet_shield));
    return false;
  }

  self.melee.winner = 1;
  self.melee.animname = % ai_melee_sync_attack;
  target.melee.animname = % ai_melee_sync_defend;
  return true;
}

melee_aivsai_exposed_chooseanimationandposition_buildexposedlist() {
  if(isDefined(self.meleesequenceoverride) && [
      [self.canexecutemeleesequenceoverride]
    ]())
    exposedmelees[0] = self.meleesequenceoverride;
  else if(isDefined(self.meleeforcedexposedflip)) {
    assert(!isDefined(self.meleeforcedexposedwrestle));
    exposedmelees[0] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
  } else if(isDefined(self.meleeforcedexposedwrestle))
    exposedmelees[0] = ::melee_aivsai_exposed_chooseanimationandposition_wrestle;
  else if(isDefined(self.meleeforcedexposedbehind))
    exposedmelees[0] = ::melee_aivsai_exposed_chooseanimationandposition_behind;
  else {
    flipindex = randomint(2);
    wrestleindex = 1 - flipindex;
    exposedmelees[flipindex] = ::melee_aivsai_exposed_chooseanimationandposition_flip;
    exposedmelees[wrestleindex] = ::melee_aivsai_exposed_chooseanimationandposition_wrestle;
    exposedmelees[2] = ::melee_aivsai_exposed_chooseanimationandposition_behind;
  }

  return exposedmelees;
}

melee_aivsai_exposed_chooseanimationandposition() {
  assert(isDefined(self));
  assert(isDefined(self.melee.target));
  target = self.melee.target;
  angletoenemy = vectortoangles(target.origin - self.origin);
  anglediff = angleclamp180(target.angles[1] - angletoenemy[1]);
  exposedmelees = melee_aivsai_exposed_chooseanimationandposition_buildexposedlist();

  for(i = 0; i < exposedmelees.size; i++) {
    if([
        [exposedmelees[i]]
      ](anglediff)) {
      assert(isDefined(self.melee.animname));
      assert(isDefined(target.melee.animname));
      self.melee.startangles = (0, angletoenemy[1], 0);
      self.melee.startpos = getstartorigin(target.origin, target.angles, self.melee.animname);

      self thread draweventpointanddir(self.melee.startpos);

      if(melee_updateandvalidatestartpos())
        return true;
    }
  }

  return false;
}

melee_decide_winner() {
  assert(isDefined(self.melee));
  assert(isDefined(self.melee.target));
  target = self.melee.target;

  if(isDefined(self.meleealwayswin)) {
    assert(!isDefined(target.magic_bullet_shield));
    self.melee.winner = 1;
    return;
  } else if(isDefined(target.meleealwayswin)) {
    assert(!isDefined(self.magic_bullet_shield));
    self.melee.winner = 0;
    return;
  }

  if(isDefined(self.magic_bullet_shield)) {
    assert(!isDefined(target.magic_bullet_shield));
    self.melee.winner = 1;
  } else if(isDefined(target.magic_bullet_shield))
    self.melee.winner = 0;
  else
    self.melee.winner = cointoss();
}

melee_aivsai_specialcover_chooseanimationandposition() {
  assert(isDefined(self));
  assert(isDefined(self.melee.target));
  assert(isDefined(self.melee.target.covernode));
  target = self.melee.target;
  melee_decide_winner();

  if(target.covernode.type == "Cover Left") {
    if(self.melee.winner) {
      self.melee.animname = % ai_cornerstand_left_melee_wina_attacker;
      target.melee.animname = % ai_cornerstand_left_melee_wina_defender;
      target.melee.surviveanimname = % ai_cornerstand_left_melee_wina_defender_survive;
    } else {
      self.melee.animname = % ai_cornerstand_left_melee_wind_attacker;
      self.melee.surviveanimname = % ai_cornerstand_left_melee_wind_attacker_survive;
      target.melee.animname = % ai_cornerstand_left_melee_wind_defender;
    }
  } else {
    assert(target.covernode.type == "Cover Right");

    if(self.melee.winner) {
      self.melee.animname = % ai_cornerstand_right_melee_wina_attacker;
      target.melee.animname = % ai_cornerstand_right_melee_wina_defender;
    } else {
      self.melee.animname = % ai_cornerstand_right_melee_wind_attacker;
      target.melee.animname = % ai_cornerstand_right_melee_wind_defender;
    }
  }

  self.melee.startpos = getstartorigin(target.covernode.origin, target.covernode.angles, self.melee.animname);
  self.melee.startangles = (target.covernode.angles[0], angleclamp180(target.covernode.angles[1] + 180), target.covernode.angles[2]);
  target.melee.faceyaw = getnodeforwardyaw(target.covernode);
  self.melee.starttotargetcornerangles = target.covernode.angles;

  if(!melee_updateandvalidatestartpos()) {
    self.melee.starttotargetcornerangles = undefined;
    return false;
  }

  return true;
}

melee_aivsai_specialcover_canexecute() {
  assert(isDefined(self));
  assert(isDefined(self.melee.target));
  cover = self.melee.target.covernode;

  if(!isDefined(cover))
    return false;

  if(distancesquared(cover.origin, self.melee.target.origin) > 16 && isDefined(self.melee.target.a.covermode) && (self.melee.target.a.covermode != "hide" && self.melee.target.a.covermode != "lean"))
    return false;

  covertoselfangles = vectortoangles(self.origin - cover.origin);
  anglediff = angleclamp180(cover.angles[1] - covertoselfangles[1]);

  if(cover.type == "Cover Left") {
    if(anglediff >= -50 && anglediff <= 0)
      return true;
  } else if(cover.type == "Cover Right") {
    if(anglediff >= 0 && anglediff <= 50)
      return true;
  }

  return false;
}

getcurrentweaponslotname() {
  assert(isDefined(self));

  if(self.weapon == self.secondaryweapon)
    return "secondary";

  if(self.weapon == self.sidearm)
    return "sidearm";

  return "primary";
}

draweventpointanddir(position) {
  self endon("death");
  current_time = gettime();

  if(!getdvarint(#"_id_C6C2EDBB")) {
    return;
  }
  while(true) {
    drawdebugcross(position, 1, (1, 0, 0), 0.05);

    if(gettime() - current_time > 2000) {
      break;
    }

    wait 0.05;
  }

}

debugline(frompoint, topoint, color, durationframes) {
  self endon("death");

  for(i = 0; i < durationframes * 20; i++) {
    line(frompoint, topoint, color);
    recordline(frompoint, topoint, color, "Animscript", self);
    wait 0.05;
  }

}

drawdebugcross(atpoint, radius, color, durationframes) {
  self endon("death");
  atpoint_high = atpoint + (0, 0, radius);
  atpoint_low = atpoint + (0, 0, -1 * radius);
  atpoint_left = atpoint + (0, radius, 0);
  atpoint_right = atpoint + (0, -1 * radius, 0);
  atpoint_forward = atpoint + (radius, 0, 0);
  atpoint_back = atpoint + (-1 * radius, 0, 0);
  thread debugline(atpoint_high, atpoint_low, color, durationframes);
  thread debugline(atpoint_left, atpoint_right, color, durationframes);
  thread debugline(atpoint_forward, atpoint_back, color, durationframes);
}