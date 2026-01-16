/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\cover_wall.gsc
**************************************/

#include animscripts\anims;
#include animscripts\combat_utility;
#include animscripts\cover_utility;
#include animscripts\utility;
#include common_scripts\utility;
#include maps\_utility;
#include animscripts\shared;
#include animscripts\cover_behavior;
#include animscripts\debug;
#include maps\_gameskill;
#include maps\_turret;
#include animscripts\shoot_behavior;
#using_animtree("generic_human");

cover_wall_think(covertype) {
  self endon("killanimscript");
  assert(isDefined(self.node));
  self.covernode = self.node;
  self.covertype = covertype;

  if(!isDefined(self.covernode.turret))
    animscripts\cover_utility::turntomatchnodedirection(0);

  if(covertype == "crouch") {
    self setup_cover_crouch();
    self initcovercrouchnode();
  } else
    self setup_cover_stand();

  if(self.a.pose != "stand" && self.a.pose != "crouch") {
    assert(self.a.pose == "prone");
    self exitpronewrapper(1);
    self.a.pose = "crouch";
  }

  self.a.standidlethread = undefined;
  self orientmode("face angle", self.covernode.angles[1]);

  if(isDefined(self.covernode.turret))
    self usestationaryturret();

  self animmode("normal");

  if(covertype == "crouch" && self.a.pose == "stand") {
    transanim = animarray("stand_2_hide");
    time = getanimlength(transanim);
    self setanimknoballrestart(transanim, % body, 1, 0.2);
    self thread animscripts\shared::movetooriginovertime(self.covernode.origin, time);
    wait(time);
    self.a.covermode = "Hide";
  } else if(covertype == "stand" && self.a.pose == "crouch") {
    transanim = animarray("crouch_2_hide");
    time = getanimlength(transanim);
    self thread animscripts\shared::movetooriginovertime(self.covernode.origin, time);
    self setflaggedanimknoballrestart("crouch_2_stand", transanim, % body, 1, 0.2);
    self animscripts\shared::donotetracks("crouch_2_stand");
    self.a.covermode = "Hide";
  } else {
    loophide(0.4);
    self thread animscripts\shared::movetooriginovertime(self.covernode.origin, 0.4);
    wait 0.2;

    if(covertype == "crouch")
      self.a.pose = "crouch";

    wait 0.2;
  }

  self animmode("zonly_physics");

  if(covertype == "crouch") {
    if(self.a.pose == "prone")
      self exitpronewrapper(1);

    self.a.pose = "crouch";
  }

  if(self.covertype == "stand")
    self.a.special = "cover_stand";
  else
    self.a.special = "cover_crouch";

  behaviorcallbacks = spawnstruct();
  behaviorcallbacks.reload = ::coverreload;
  behaviorcallbacks.leavecoverandshoot = ::leavecoverandshoot;
  behaviorcallbacks.look = ::look;
  behaviorcallbacks.fastlook = ::fastlook;
  behaviorcallbacks.idle = ::idle;
  behaviorcallbacks.flinch = ::flinch;
  behaviorcallbacks.grenade = ::trythrowinggrenade;
  behaviorcallbacks.grenadehidden = ::trythrowinggrenadestayhidden;
  behaviorcallbacks.blindfire = animscripts\cover_utility::blindfire;
  behaviorcallbacks.resetweaponanims = ::resetweaponanims;
  behaviorcallbacks.rambo = ::rambo;
  animscripts\cover_behavior::main(behaviorcallbacks);
}

initcovercrouchnode() {
  if(isDefined(self.covernode.crouchingisok)) {
    return;
  }
  crouchheightoffset = vectorscale((0, 0, 1), 42.0);
  forward = anglestoforward(self.angles);
  self.covernode.crouchingisok = sighttracepassed(self.origin + crouchheightoffset, self.origin + crouchheightoffset + vectorscale(forward, 64), 0, undefined);
}

setup_cover_crouch() {
  self.rightaimlimit = 48;
  self.leftaimlimit = -48;
  self.upaimlimit = 45;
  self.downaimlimit = -45;
}

setup_cover_stand() {
  self.rightaimlimit = 45;
  self.leftaimlimit = -45;
  self.upaimlimit = 45;
  self.downaimlimit = -45;
}

coverreload() {
  return reload(2.0, animarraypickrandom("reload"));
}

leavecoverandshoot(theweapontype, mode, suppressspot) {
  self.keepclaimednodeifvalid = 1;

  if(!pop_up()) {
    self animscripts\debug::debugpopstate(undefined, "no room to pop up");

    return false;
  }

  shootastold();
  self notify("kill_idle_thread");

  if(isDefined(self.shootpos)) {
    distsqtoshootpos = lengthsquared(self.origin - self.shootpos);

    if(animscripts\shared::shouldthrowdownweapon()) {
      animscripts\shared::throwdownweapon();
      resetweaponanims();
    }
  }

  go_to_hide();
  self.keepclaimednodeifvalid = 0;
  return true;
}

shootastold() {
  self endon("return_to_cover");
  self endon("need_to_switch_weapons");
  self maps\_gameskill::didsomethingotherthanshooting();

  self animscripts\debug::debugpushstate("shootAsTold");

  while(true) {
    if(self.shouldreturntocover) {
      self animscripts\debug::debugpopstate("shootAsTold", "shouldReturnToCover is true");

      break;
    }

    if(!aimedatshootentorpos()) {
      wait 0.5;
      waittillframeend;

      if(!aimedatshootentorpos()) {
        self lookforbettercover();

        self animscripts\debug::debugpopstate("shootAsTold", "Looking better cover as can't aim at enemy");

        break;
      }
    }

    if(!isDefined(self.shootpos)) {
      assert(!isDefined(self.shootent));
      self waittill("do_slow_things");
      waittillframeend;

      if(isDefined(self.shootpos)) {
        continue;
      }
      self animscripts\debug::debugpopstate("shootAsTold", "shootPos undefined");

      break;
    }

    if(!self.bulletsinclip) {
      break;
    }

    if(self.covertype == "crouch" && needtochangecovermode()) {
      self animscripts\debug::debugpopstate("shootAsTold", "needToChangeCoverMode true");

      break;
    }

    shootuntilshootbehaviorchange_coverwall();

    self animscripts\debug::debugpopstate("shootAsTold");

    self flamethrower_stop_shoot();
    self clearanim( % add_fire, 0.2);
  }
}

shootuntilshootbehaviorchange_coverwall() {
  if(self.covertype == "crouch")
    self thread anglerangethread();

  self thread standidlethread();
  shootuntilshootbehaviorchange();
}

idle() {
  self endon("end_idle");

  while(true) {
    usetwitch = randomint(2) == 0 && animarrayanyexist("hide_idle_twitch");

    if(usetwitch && !self.looking_at_entity)
      idleanim = animarraypickrandom("hide_idle_twitch");
    else
      idleanim = animarray("hide_idle");

    playidleanimation(idleanim, usetwitch);
  }
}

flinch() {
  if(!animarrayanyexist("hide_idle_flinch")) {
    self animscripts\debug::debugpopstate(undefined, "no flinch anim");

    return false;
  }

  forward = anglestoforward(self.angles);
  stepto = self.origin + vectorscale(forward, -16);

  if(!self maymovetopoint(stepto)) {
    self animscripts\debug::debugpopstate(undefined, "no room to flinch");

    return false;
  }

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  flinchanim = animarraypickrandom("hide_idle_flinch");
  playidleanimation(flinchanim, 1);
  self.keepclaimednodeifvalid = 0;
  return true;
}

playidleanimation(idleanim, needsrestart) {
  if(needsrestart)
    self setflaggedanimknoballrestart("idle", idleanim, % body, 1, 0.1, 1);
  else
    self setflaggedanimknoball("idle", idleanim, % body, 1, 0.1, 1);

  self.a.covermode = "Hide";
  self animscripts\shared::donotetracks("idle");
}

look(looktime) {
  if(!animarrayexist("hide_to_look")) {
    self animscripts\debug::debugpopstate(undefined, "no look anim");

    return false;
  }

  if(!peekout())
    return false;

  animscripts\shared::playlookanimation(animarray("look_idle"), looktime);
  lookanim = undefined;

  if(self issuppressedwrapper())
    lookanim = animarray("look_to_hide_fast");
  else
    lookanim = animarray("look_to_hide");

  self setflaggedanimknoballrestart("looking_end", lookanim, % body, 1, 0.1);
  animscripts\shared::donotetracks("looking_end");
  return true;
}

peekout() {
  if(isDefined(self.covernode.script_dontpeek)) {
    self animscripts\debug::debugpopstate(undefined, "cover node has script_dontpeek on");

    return false;
  }

  if(isDefined(self.a.dontpeek)) {
    self animscripts\debug::debugpopstate(undefined, "self.a.dontpeek on");

    return false;
  }

  if(usingpistol()) {
    self animscripts\debug::debugpopstate(undefined, "no pistol anims");

    return false;
  }

  self setflaggedanimknoball("looking_start", animarray("hide_to_look"), % body, 1, 0.2);
  animscripts\shared::donotetracks("looking_start");
  return true;
}

fastlook() {
  self setflaggedanimknoballrestart("look", animarraypickrandom("look"), % body, 1, 0.1);
  self animscripts\shared::donotetracks("look");
  return true;
}

standidlethread() {
  self endon("killanimscript");

  if(!isDefined(self.a.standidlethread)) {
    self.a.standidlethread = 1;
    self setanim( % add_idle, 1, 0.2);
    standidlethreadinternal();
    self clearanim( % add_idle, 0.2);
  }
}

endstandidlethread() {
  self.a.standidlethread = undefined;
  self notify("end_stand_idle_thread");
}

standidlethreadinternal() {
  self endon("killanimscript");
  self endon("end_stand_idle_thread");
  i = 0;

  for(;;) {
    flagname = "idle" + i;
    idleanim = animarraypickrandom("exposed_idle");
    self setflaggedanimknoblimitedrestart(flagname, idleanim, 1, 0.2);
    self waittillmatch(flagname, "end");
    i++;
  }
}

pop_up_and_hide_speed() {
  if(self.a.covermode == "left" || self.a.covermode == "right" || self.a.covermode == "over")
    return 1;

  return randomfasteranimspeed();
}

pop_up() {
  assert(self.a.covermode == "Hide");
  newcovermode = getbestcovermode();

  if(!isDefined(newcovermode))
    return false;

  popupanim = animarray("hide_2_" + newcovermode);

  if(!self maymovetopoint(getanimendpos(popupanim)))
    return false;

  if(self.covertype == "crouch")
    self setup_cover_crouch();
  else
    self setup_cover_stand();

  self.a.special = "none";

  if(self.covertype == "stand")
    self.a.special = "cover_stand_aim";
  else if(newcovermode == "left" || newcovermode == "right")
    self.a.special = "cover_crouch_aim_" + newcovermode;
  else
    self.a.special = "cover_crouch_aim";

  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");
  self animmode("zonly_physics");
  animrate = pop_up_and_hide_speed();
  self setflaggedanimknoballrestart("pop_up", popupanim, % body, 1, 0.1, animrate);
  self thread donotetracksforpopup("pop_up");

  if(animhasnotetrack(popupanim, "start_aim")) {
    self waittillmatch("pop_up", "start_aim");
    timeleft = getanimlength(popupanim) / animrate * (1 - self getanimtime(popupanim));
  } else {
    self waittillmatch("pop_up", "end");
    timeleft = 0.1;
  }

  self clearanim(popupanim, timeleft + 0.05);
  self.a.covermode = newcovermode;
  self.a.prevattack = newcovermode;
  self setup_additive_aim(timeleft);
  self thread animscripts\shared::trackshootentorpos();
  wait(timeleft);
  self.changingcoverpos = 0;
  self.coverposestablishedtime = gettime();
  self notify("stop_popup_donotetracks");
  return true;
}

donotetracksforpopup(animname) {
  self endon("killanimscript");
  self endon("stop_popup_donotetracks");
  self animscripts\shared::donotetracks(animname);
}

setup_additive_aim(transtime) {
  if(self.a.covermode == "left" || self.a.covermode == "right")
    aimcovermode = "crouch";
  else
    aimcovermode = self.a.covermode;

  self setanimknoball(animarray(aimcovermode + "_aim"), % body, 1, transtime);
  prefix = "";

  if(self.a.covermode == "over")
    prefix = "over_";

  self setanimlimited(animarray(prefix + "add_aim_down"), 1, 0);
  self setanimlimited(animarray(prefix + "add_aim_left"), 1, 0);
  self setanimlimited(animarray(prefix + "add_aim_right"), 1, 0);
  self setanimlimited(animarray(prefix + "add_aim_up"), 1, 0);
}

go_to_hide() {
  self notify("return_to_cover");

  self animscripts\debug::debugpopstate("shootAsTold", "needToChangeCoverMode true");

  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");
  self endstandidlethread();
  animrate = pop_up_and_hide_speed();
  self setflaggedanimknoball("go_to_hide", animarray(self.a.covermode + "_2_hide"), % body, 1, 0.2, animrate);
  self clearanim( % exposed_modern, 0.2);
  self animscripts\shared::donotetracks("go_to_hide");
  self animscripts\shared::stoptracking();
  self.a.covermode = "Hide";

  if(self.covertype == "stand")
    self.a.special = "cover_stand";
  else
    self.a.special = "cover_crouch";

  self.changingcoverpos = 0;
}

trythrowinggrenadestayhidden(throwat, forcethrow) {
  return trythrowinggrenade(throwat, 1, forcethrow);
}

trythrowinggrenade(throwat, safe, forcethrow) {
  theanim = undefined;

  if(animarrayexist("grenade_rambo") && isDefined(self.rambochance) && randomfloat(1) < self.rambochance)
    theanim = animarray("grenade_rambo");
  else if(isDefined(safe) && safe)
    theanim = animarraypickrandom("grenade_safe");
  else
    theanim = animarraypickrandom("grenade_exposed");

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  threwgrenade = trygrenade(throwat, theanim, forcethrow);
  self.keepclaimednodeifvalid = 0;
  return threwgrenade;
}

createturret(posent, weaponinfo, weaponmodel) {
  turret = spawnturret("misc_turret", posent.origin, weaponinfo);
  turret.angles = posent.angles;
  turret.aiowner = self;
  turret setmodel(weaponmodel);
  turret maketurretusable();
  turret setdefaultdroppitch(0);

  if(isDefined(posent.leftarc))
    turret.leftarc = posent.leftarc;

  if(isDefined(posent.rightarc))
    turret.rightarc = posent.rightarc;

  if(isDefined(posent.toparc))
    turret.toparc = posent.toparc;

  if(isDefined(posent.bottomarc))
    turret.bottomarc = posent.bottomarc;

  return turret;
}

deleteifnotused(owner) {
  self endon("death");
  self endon("being_used");
  wait 0.1;

  if(isDefined(owner)) {
    assert(!isDefined(owner.a.usingturret) || owner.a.usingturret != self);
    owner notify("turret_use_failed");
  }

  self delete();
}

useselfplacedturret(weaponinfo, weaponmodel) {
  turret = self createturret(self.covernode.turretinfo, weaponinfo, weaponmodel);

  if(self useturret(turret)) {
    turret thread deleteifnotused(self);
    self waittill("turret_use_failed");
  } else
    turret delete();
}

usestationaryturret() {
  assert(isDefined(self.covernode));
  assert(isDefined(self.covernode.turret));
  self.covernode.turret.ai_node_user = self;

  if(self.covernode.turret maps\_turret::is_turret_enabled())
    self thread maps\_turret::use_turret(self.covernode.turret);
}

loophide(transtime) {
  if(!isDefined(transtime))
    transtime = 0.1;

  self setanimknoballrestart(animarray("hide_idle"), % body, 1, transtime);
  self.a.covermode = "Hide";
}

anglerangethread() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("return_to_cover");

  while(true) {
    if(needtochangecovermode()) {
      break;
    }

    wait 0.1;
  }

  self notify("stopShooting");
}

needtochangecovermode() {
  if(self.covertype != "crouch")
    return false;

  pitch = getshootpospitch(self geteye());

  if(self.a.covermode == "lean")
    return pitch < 10;
  else
    return abs(pitch) > 45;
}

getbestcovermode() {
  modes = [];
  assert(isDefined(self.covernode));

  if(self.covertype == "stand") {
    modes = self.covernode getvalidcoverpeekouts();
    allowstepback = 1;

    if(modes.size > 0) {
      pitch = getshootpospitch(self.covernode.origin + getnodeoffset(self.covernode));

      if(pitch > 15)
        allowstepback = 0;
    }

    if(allowstepback)
      modes[modes.size] = "stand";
  } else {
    pitch = getshootpospitch(self.covernode.origin + getnodeoffset(self.covernode));

    if(pitch > 30)
      return "lean";

    if(pitch > 15 || !self.covernode.crouchingisok)
      return "stand";

    modes = self.covernode getvalidcoverpeekouts();
    modes[modes.size] = "crouch";
  }

  if(self.covertype == "stand" && self.a.pose != "stand")
    modes = array_exclude(modes, array("over"));

  if(self.covertype == "crouch")
    modes = array_exclude(modes, array("over"));

  return getrandomcovermode(modes);
}

resetweaponanims() {
  if(self.covertype == "crouch")
    self setup_cover_crouch();
  else
    self setup_cover_stand();
}

rambo() {
  self animscripts\debug::debugpushstate("rambo");

  if(!hasenemysightpos())
    return false;

  shouldrambo = isDefined(self.covernode.script_forcerambo) || isDefined(self.rambochance) && randomfloat(1) < self.rambochance;

  if(shouldrambo && canrambo()) {
    if(rambostepout()) {
      self animscripts\debug::debugpopstate("rambo");

      return true;
    }
  }

  self animscripts\debug::debugpopstate("rambo", "not allowed or can't step out");

  return false;
}

rambostepout() {
  animtype = "rambo";

  if(randomfloat(1) < 0.2 && animarrayanyexist("rambo_jam"))
    animtype = "rambo_jam";

  if(self.covertype == "crouch" && !self.covernode.crouchingisok)
    return false;

  assert(animarrayanyexist(animtype));
  pitch = getshootpospitch(self.covernode.origin + getnodeoffset(self.covernode));

  if(pitch > 15)
    return false;

  forward = anglestoforward(self.angles);
  rambooutpos = self.origin + forward * -16;

  self thread debugrambooutposition(rambooutpos);

  if(!self maymovetopoint(rambooutpos))
    return false;

  ramboanim = animarraypickrandom(animtype);
  resetanimspecial(0);
  self animmode("zonly_physics");
  self.keepclaimednode = 1;
  self.keepclaimednodeifvalid = 1;
  self.isramboing = 1;
  self setflaggedanimknoballrestart("rambo", ramboanim, % body, 1, 0);

  if(canuseblindaiming("rambo") && animtype != "rambo_jam") {
    self thread startblindaiming(ramboanim, "rambo");
    self thread stopblindaiming(ramboanim, "rambo");
  }

  if(isDefined(self.enemy))
    self animscripts\shoot_behavior::setshootent(self.enemy);

  self animscripts\shared::donotetracks("rambo");
  self.keepclaimednode = 1;
  self.keepclaimednodeifvalid = 0;
  self.isramboing = 0;
  self.a.prevattack = "rambo";
  waittillframeend;
  return true;
}

resetanimspecial(delay) {
  self endon("killanimscript");

  if(delay > 0)
    wait(delay);

  self.a.special = "none";
}