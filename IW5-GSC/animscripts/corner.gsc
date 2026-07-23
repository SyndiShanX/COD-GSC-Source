/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\corner.gsc
**************************************/

corner_think(var_0, var_1) {
  self endon("killanimscript");
  self.animarrayfuncs["exposed"]["stand"] = ::set_standing_animarray_aiming;
  self.animarrayfuncs["exposed"]["crouch"] = ::set_crouching_animarray_aiming;
  self.covernode = self.node;
  self.cornerdirection = var_0;
  self.a.cornermode = "unknown";
  self.a.aimidlethread = undefined;
  animscripts\cover_behavior::turntomatchnodedirection(var_1);
  set_corner_anim_array();
  self.isshooting = 0;
  self.tracking = 0;
  self.corneraiming = 0;
  animscripts\track::setanimaimweight(0);
  self.havegonetocover = 0;
  var_2 = spawnStruct();

  if(!self.fixednode) {
    var_2.movetonearbycover = animscripts\cover_behavior::movetonearbycover;
  }
  var_2.mainloopstart = ::mainloopstart;
  var_2.reload = ::cornerreload;
  var_2.leavecoverandshoot = ::stepoutandshootenemy;
  var_2.look = ::lookforenemy;
  var_2.fastlook = ::fastlook;
  var_2.idle = ::idle;
  var_2.grenade = ::trythrowinggrenade;
  var_2.grenadehidden = ::trythrowinggrenadestayhidden;
  var_2.blindfire = ::blindfire;
  animscripts\cover_behavior::main(var_2);
}

end_script_corner() {
  self.stepoutyaw = undefined;
  self.a.leanaim = undefined;
}

set_corner_anim_array() {
  if(self.a.pose == "crouch") {
    set_anim_array("crouch");
  } else if(self.a.pose == "stand") {
    set_anim_array("stand");
  } else {
    animscripts\utility::exitpronewrapper(1);
    self.a.pose = "crouch";
    set_anim_array("crouch");
  }
}

shouldchangestanceforfun() {
  if(!isDefined(self.enemy)) {
    return 0;
  }
  if(!isDefined(self.changestanceforfuntime)) {
    self.changestanceforfuntime = gettime() + randomintrange(5000, 20000);
  }
  if(gettime() > self.changestanceforfuntime) {
    self.changestanceforfuntime = gettime() + randomintrange(5000, 20000);

    if(isDefined(self.rambochance) && self.a.pose == "stand") {
      return 0;
    }
    self.a.prevattack = undefined;
    return 1;
  }

  return 0;
}

mainloopstart() {
  var_0 = "stand";

  if(self.a.pose == "crouch") {
    var_0 = "crouch";

    if(self.covernode doesnodeallowstance("stand")) {
      if(!self.covernode doesnodeallowstance("crouch") || shouldchangestanceforfun()) {
        var_0 = "stand";
      }
    }
  } else if(self.covernode doesnodeallowstance("crouch")) {
    if(!self.covernode doesnodeallowstance("stand") || shouldchangestanceforfun()) {
      var_0 = "crouch";
    }
  }

  if(self.havegonetocover) {
    transitiontostance(var_0);
  } else {
    if(self.a.pose == var_0) {
      gotocover(animscripts\utility::animarray("alert_idle"), 0.3, 0.4);
    } else {
      var_1 = animscripts\utility::animarray("stance_change");
      gotocover(var_1, 0.3, getanimlength(var_1));
      set_anim_array(var_0);
    }

    self.havegonetocover = 1;
  }
}

printyaws() {
  wait 2;

  for(;;) {
    printyawtoenemy();
    wait 0.05;
  }
}

canseepointfromexposedatcorner(var_0, var_1) {
  var_2 = var_1 animscripts\utility::getyawtoorigin(var_0);

  if(var_2 > 60 || var_2 < -60) {
    return 0;
  }
  if(var_1.type == "Cover Left" && var_2 > 14) {
    return 0;
  }
  if(var_1.type == "Cover Right" && var_2 < -12) {
    return 0;
  }
  return 1;
}

shootposoutsidelegalyawrange() {
  if(!isDefined(self.shootpos)) {
    return 0;
  }
  var_0 = self.covernode animscripts\utility::getyawtoorigin(self.shootpos);

  if(self.a.cornermode == "over") {
    return var_0 < self.leftaimlimit || self.rightaimlimit < var_0;
  }
  if(self.cornerdirection == "left") {
    if(self.a.cornermode == "B") {
      return var_0 < 0 - self.abanglecutoff || var_0 > 14;
    } else if(self.a.cornermode == "A") {
      return var_0 > 0 - self.abanglecutoff;
    } else {
      return var_0 < -50 || var_0 > 8;
    }
  } else if(self.a.cornermode == "B") {
    return var_0 > self.abanglecutoff || var_0 < -12;
  } else if(self.a.cornermode == "A") {
    return var_0 < self.abanglecutoff;
  } else {
    return var_0 > 50 || var_0 < -8;
  }
}

getcornermode(var_0, var_1) {
  var_2 = 0;
  var_3 = 0;

  if(isDefined(var_1)) {
    var_3 = var_0 animscripts\utility::getyawtoorigin(var_1);
  }
  var_4 = [];

  if(isDefined(var_0) && self.a.pose == "crouch" && (var_3 > self.leftaimlimit && self.rightaimlimit > var_3)) {
    var_4 = var_0 getvalidcoverpeekouts();
  }
  if(self.cornerdirection == "left") {
    if(canlean(var_3, -40, 0)) {
      var_2 = shouldlean();
      var_4[var_4.size] = "lean";
    }

    if(!var_2 && var_3 < 14) {
      if(var_3 < 0 - self.abanglecutoff) {
        var_4[var_4.size] = "A";
      } else {
        var_4[var_4.size] = "B";
      }
    }
  } else {
    if(canlean(var_3, 0, 40)) {
      var_2 = shouldlean();
      var_4[var_4.size] = "lean";
    }

    if(!var_2 && var_3 > -12) {
      if(var_3 > self.abanglecutoff) {
        var_4[var_4.size] = "A";
      } else {
        var_4[var_4.size] = "B";
      }
    }
  }

  return animscripts\combat_utility::getrandomcovermode(var_4);
}

getbeststepoutpos() {
  var_0 = 0;

  if(animscripts\utility::cansuppressenemy()) {
    var_0 = self.covernode animscripts\utility::getyawtoorigin(animscripts\utility::getenemysightpos());
  } else if(self.doingambush && isDefined(self.shootpos)) {
    var_0 = self.covernode animscripts\utility::getyawtoorigin(self.shootpos);
  }
  if(self.a.cornermode == "lean") {
    return "lean";
  }
  if(self.a.cornermode == "over") {
    return "over";
  } else if(self.a.cornermode == "B") {
    if(self.cornerdirection == "left") {
      if(var_0 < 0 - self.abanglecutoff) {
        return "A";
      }
    } else if(self.cornerdirection == "right") {
      if(var_0 > self.abanglecutoff) {
        return "A";
      }
    }

    return "B";
  } else if(self.a.cornermode == "A") {
    var_2 = "B";

    if(self.cornerdirection == "left") {
      if(var_0 > 0 - self.abanglecutoff) {
        return "B";
      }
    } else if(self.cornerdirection == "right") {
      if(var_0 < self.abanglecutoff) {
        return "B";
      }
    }

    return "A";
  }
}

changestepoutpos() {
  self endon("killanimscript");
  var_0 = getbeststepoutpos();

  if(var_0 == self.a.cornermode) {
    return 0;
  }
  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");
  var_1 = self.a.cornermode + "_to_" + var_0;
  var_2 = animscripts\utility::animarraypickrandom(var_1);
  var_3 = getpredictedpathmidpoint();

  if(!self maymovetopoint(var_3)) {
    return 0;
  }
  if(!self maymovefrompointtopoint(var_3, animscripts\utility::getanimendpos(var_2))) {
    return 0;
  }
  animscripts\combat_utility::endaimidlethread();
  stopaiming(0.3);
  var_4 = self.a.pose;
  self setanimlimited(animscripts\utility::animarray("straight_level"), 0, 0.2);
  self setflaggedanimknob("changeStepOutPos", var_2, 1, 0.2, 1.2);
  thread donotetrackswithendon("changeStepOutPos");

  if(animhasnotetrack(var_2, "start_aim")) {
    self waittillmatch("changeStepOutPos", "start_aim");
  } else {
    self waittillmatch("changeStepOutPos", "end");
  }
  thread startaiming(undefined, 0, 0.3);
  self waittillmatch("changeStepOutPos", "end");
  self clearanim(var_2, 0.1);
  self.a.cornermode = var_0;
  self.changingcoverpos = 0;
  self.coverposestablishedtime = gettime();

  if(self.a.pose != var_4) {
    set_anim_array(self.a.pose);
  }
  thread changeaiming(undefined, 1, 0.3);
  return 1;
}

canlean(var_0, var_1, var_2) {
  if(self.a.neverlean) {
    return 0;
  }
  return var_1 <= var_0 && var_0 <= var_2;
}

shouldlean() {
  if(self.team == "allies") {
    return 1;
  }
  if(animscripts\utility::ispartiallysuppressedwrapper()) {
    return 1;
  }
  return 0;
}

donotetrackswithendon(var_0) {
  self endon("killanimscript");
  animscripts\shared::donotetracks(var_0);
}

startaiming(var_0, var_1, var_2) {
  self.corneraiming = 1;

  if(self.a.cornermode == "lean") {
    self.a.leanaim = 1;
  } else {
    self.a.leanaim = undefined;
  }
  setaimingparams(var_0, var_1, var_2);
}

changeaiming(var_0, var_1, var_2) {
  if(self.a.cornermode == "lean") {
    self.a.leanaim = 1;
  } else {
    self.a.leanaim = undefined;
  }
  setaimingparams(var_0, var_1, var_2);
}

#using_animtree("generic_human");

stopaiming(var_0) {
  self.corneraiming = 0;
  self clearanim(%add_fire, var_0);
  animscripts\track::setanimaimweight(0, var_0);
}

setaimingparams(var_0, var_1, var_2) {
  self.spot = var_0;
  self setanimlimited(%exposed_modern, 1, var_2);
  self setanimlimited(%exposed_aiming, 1, var_2);
  self setanimlimited(%add_idle, 1, var_2);
  animscripts\track::setanimaimweight(1, var_2);
  var_3 = undefined;

  if(isDefined(self.a.array["lean_aim_straight"])) {
    var_3 = self.a.array["lean_aim_straight"];
  }
  thread animscripts\combat_utility::aimidlethread();

  if(isDefined(self.a.leanaim)) {
    self setanimlimited(var_3, 1, var_2);
    self setanimlimited(animscripts\utility::animarray("straight_level"), 0, 0);
    self setanimknoblimited(animscripts\utility::animarray("lean_aim_left"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("lean_aim_right"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("lean_aim_up"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("lean_aim_down"), 1, var_2);
  } else if(var_1) {
    self setanimlimited(animscripts\utility::animarray("straight_level"), 1, var_2);

    if(isDefined(var_3)) {
      self setanimlimited(var_3, 0, 0);
    }
    self setanimknoblimited(animscripts\utility::animarray("add_aim_up"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("add_aim_down"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("add_aim_left"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("add_aim_right"), 1, var_2);
  } else {
    self setanimlimited(animscripts\utility::animarray("straight_level"), 0, var_2);

    if(isDefined(var_3)) {
      self setanimlimited(var_3, 0, 0);
    }
    self setanimknoblimited(animscripts\utility::animarray("add_turn_aim_up"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("add_turn_aim_down"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("add_turn_aim_left"), 1, var_2);
    self setanimknoblimited(animscripts\utility::animarray("add_turn_aim_right"), 1, var_2);
  }
}

stepoutandhidespeed() {
  if(self.a.cornermode == "over") {
    return 1;
  }
  return animscripts\combat_utility::randomfasteranimspeed();
}

stepout() {
  self.a.cornermode = "alert";

  if(self.goalradius < 64) {
    self.goalradius = 64;
  }
  self animmode("zonly_physics");

  if(self.a.pose == "stand") {
    self.abanglecutoff = 38;
  } else {
    self.abanglecutoff = 31;
  }
  var_0 = self.a.pose;
  set_anim_array(var_0);
  self setdefaultaimlimits();
  var_1 = "none";

  if(animscripts\utility::hasenemysightpos()) {
    var_1 = getcornermode(self.covernode, animscripts\utility::getenemysightpos());
  } else {
    var_1 = getcornermode(self.covernode);
  }
  if(!isDefined(var_1)) {
    return 0;
  }
  var_2 = "alert_to_" + var_1;
  var_3 = animscripts\utility::animarraypickrandom(var_2);

  if(var_1 == "lean" && !ispeekoutposclear()) {
    return 0;
  }
  if(var_1 != "over" && !ispathclear(var_3, var_1 != "lean")) {
    return 0;
  }
  self.a.cornermode = var_1;
  self.a.prevattack = var_1;

  if(self.a.cornermode == "lean") {
    self setdefaultaimlimits(self.covernode);
  }
  if(var_1 == "A" || var_1 == "B") {
    self.a.special = "cover_" + self.cornerdirection + "_" + self.a.pose + "_" + var_1;
  } else if(var_1 == "over") {
    self.a.special = "cover_crouch_aim";
  } else {
    self.a.special = "none";
  }
  self.keepclaimednodeifvalid = 1;
  var_4 = 0;
  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");
  var_5 = stepoutandhidespeed();
  self.pushable = 0;
  self setflaggedanimknoballrestart("stepout", var_3, %root, 1, 0.2, var_5);
  thread donotetrackswithendon("stepout");
  var_4 = animhasnotetrack(var_3, "start_aim");

  if(var_4) {
    self.stepoutyaw = self.angles[1] + getangledelta(var_3, 0, 1);
    self waittillmatch("stepout", "start_aim");
  } else {
    self waittillmatch("stepout", "end");
  }
  if(var_1 == "B" && common_scripts\utility::cointoss() && self.cornerdirection == "right") {
    self.a.special = "corner_right_martyrdom";
  }
  set_anim_array_aiming(var_0);
  var_6 = var_1 == "over";
  startaiming(undefined, var_6, 0.3);
  thread animscripts\track::trackshootentorpos();

  if(var_4) {
    self waittillmatch("stepout", "end");
    self.stepoutyaw = undefined;
  }

  changeaiming(undefined, 1, 0.2);
  self clearanim(%cover, 0.1);
  self clearanim(%corner, 0.1);
  self.changingcoverpos = 0;
  self.coverposestablishedtime = gettime();
  self.pushable = 1;
  return 1;
}

stepoutandshootenemy() {
  self.keepclaimednodeifvalid = 1;

  if(isDefined(self.rambochance) && randomfloat(1) < self.rambochance) {
    if(rambo()) {
      return 1;
    }
  }

  if(!stepout()) {
    return 0;
  }
  shootastold();

  if(isDefined(self.shootpos)) {
    var_0 = lengthsquared(self.origin - self.shootpos);

    if(animscripts\utility::usingrocketlauncher() && (var_0 < squared(512) || self.a.rockets < 1)) {
      if(self.a.pose == "stand") {
        animscripts\shared::throwdownweapon(%rpg_stand_throw);
      } else {
        animscripts\shared::throwdownweapon(%rpg_crouch_throw);
      }
      thread runcombat();
      return;
    }
  }

  returntocover();
  self.keepclaimednodeifvalid = 0;
  return 1;
}

haventramboedwithintime(var_0) {
  if(!isDefined(self.lastrambotime)) {
    return 1;
  }
  return gettime() - self.lastrambotime > var_0 * 1000;
}

rambo() {
  if(!animscripts\utility::hasenemysightpos()) {
    return 0;
  }
  var_0 = 0;
  var_1 = 90;
  var_2 = self.covernode animscripts\utility::getyawtoorigin(animscripts\utility::getenemysightpos());

  if(self.cornerdirection == "left") {
    var_2 = 0 - var_2;
  }
  if(var_2 > 30) {
    var_1 = 45;

    if(self.cornerdirection == "left") {
      var_0 = 45;
    } else {
      var_0 = -45;
    }
  }

  var_3 = "rambo" + var_1;

  if(!animscripts\utility::animarrayanyexist(var_3)) {
    return 0;
  }
  var_4 = animscripts\utility::animarraypickrandom(var_3);
  var_5 = getpredictedpathmidpoint(48);

  if(!self maymovetopoint(var_5)) {
    return 0;
  }
  self.coverposestablishedtime = gettime();
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  self.isrambo = 1;
  self.a.prevattack = "rambo";
  self.changingcoverpos = 1;
  thread animscripts\shared::ramboaim(var_0);
  self setflaggedanimknoballrestart("rambo", var_4, %body, 1, 0, 1);
  animscripts\shared::donotetracks("rambo");
  self notify("rambo_aim_end");
  self.changingcoverpos = 0;
  self.keepclaimednodeifvalid = 0;
  self.lastrambotime = gettime();
  self.changingcoverpos = 0;
  self.isrambo = undefined;
  return 1;
}

shootastold() {
  maps\_gameskill::didsomethingotherthanshooting();

  for(;;) {
    for(;;) {
      if(isDefined(self.shouldreturntocover)) {
        break;
      }

      if(!isDefined(self.shootpos)) {
        self waittill("do_slow_things");
        waittillframeend;

        if(isDefined(self.shootpos)) {
          continue;
        }
        break;
      }

      if(!self.bulletsinclip) {
        break;
      }

      if(shootposoutsidelegalyawrange()) {
        if(!changestepoutpos()) {
          if(getbeststepoutpos() == self.a.cornermode) {
            break;
          }

          shootuntilshootbehaviorchangefortime(0.2);
          continue;
        }

        if(shootposoutsidelegalyawrange()) {
          break;
        }
      } else {
        shootuntilshootbehaviorchange_corner(1);
        self clearanim(%add_fire, 0.2);
      }
    }

    if(canreturntocover(self.a.cornermode != "lean")) {
      break;
    }

    if(shootposoutsidelegalyawrange() && changestepoutpos()) {
      continue;
    }
    shootuntilshootbehaviorchangefortime(0.2);
  }
}

shootuntilshootbehaviorchangefortime(var_0) {
  thread notifystopshootingaftertime(var_0);
  var_1 = gettime();
  shootuntilshootbehaviorchange_corner(0);
  self notify("stopNotifyStopShootingAfterTime");
  var_2 = (gettime() - var_1) / 1000;

  if(var_2 < var_0) {
    wait(var_0 - var_2);
  }
}

notifystopshootingaftertime(var_0) {
  self endon("killanimscript");
  self endon("stopNotifyStopShootingAfterTime");
  wait(var_0);
  self notify("stopShooting");
}

shootuntilshootbehaviorchange_corner(var_0) {
  self endon("return_to_cover");

  if(var_0) {
    thread anglerangethread();
  }
  thread animscripts\combat_utility::aimidlethread();
  animscripts\combat_utility::shootuntilshootbehaviorchange();
}

anglerangethread() {
  self endon("killanimscript");
  self notify("newAngleRangeCheck");
  self endon("newAngleRangeCheck");
  self endon("take_cover_at_corner");

  for(;;) {
    if(shootposoutsidelegalyawrange()) {
      break;
    }

    wait 0.1;
  }

  self notify("stopShooting");
}

showstate() {
  self.enemy endon("death");
  self endon("enemy");
  self endon("stopshowstate");

  for(;;) {
    wait 0.05;
  }
}

canreturntocover(var_0) {
  if(var_0) {
    var_1 = getpredictedpathmidpoint();

    if(!self maymovetopoint(var_1)) {
      return 0;
    }
    return self maymovefrompointtopoint(var_1, self.covernode.origin);
  } else {
    return self maymovetopoint(self.covernode.origin);
  }
}

returntocover() {
  animscripts\combat_utility::endfireandanimidlethread();
  var_0 = animscripts\utility::issuppressedwrapper();
  self notify("take_cover_at_corner");
  self.changingcoverpos = 1;
  self notify("done_changing_cover_pos");
  var_1 = self.a.cornermode + "_to_alert";
  var_2 = animscripts\utility::animarraypickrandom(var_1);
  stopaiming(0.3);
  var_3 = 0;

  if(self.a.cornermode != "lean" && var_0 && animscripts\utility::animarrayanyexist(var_1 + "_reload") && randomfloat(100) < 75) {
    var_2 = animscripts\utility::animarraypickrandom(var_1 + "_reload");
    var_3 = 1;
  }

  var_4 = stepoutandhidespeed();
  self clearanim(%body, 0.1);
  self setflaggedanimrestart("hide", var_2, 1, 0.1, var_4);
  animscripts\shared::donotetracks("hide");

  if(var_3) {
    animscripts\weaponlist::refillclip();
  }
  self.changingcoverpos = 0;

  if(self.cornerdirection == "left") {
    self.a.special = "cover_left";
  } else {
    self.a.special = "cover_right";
  }
  self.keepclaimednodeifvalid = 0;
  self clearanim(var_2, 0.2);
}

blindfire() {
  if(!animscripts\utility::animarrayanyexist("blind_fire")) {
    return 0;
  }
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  self setflaggedanimknoballrestart("blindfire", animscripts\utility::animarraypickrandom("blind_fire"), %body, 1, 0, 1);
  animscripts\shared::donotetracks("blindfire");
  self.keepclaimednodeifvalid = 0;
  return 1;
}

linethread(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = (1, 1, 1);
  }
  for(var_3 = 0; var_3 < 100; var_3++) {
    wait 0.05;
  }
}

trythrowinggrenadestayhidden(var_0) {
  return trythrowinggrenade(var_0, 1);
}

trythrowinggrenade(var_0, var_1) {
  if(!self maymovetopoint(getpredictedpathmidpoint())) {
    return 0;
  }
  if(isDefined(self.dontevershoot) || isDefined(var_0.dontattackme)) {
    return 0;
  }
  var_2 = undefined;

  if(isDefined(self.rambochance) && randomfloat(1) < self.rambochance) {
    if(isDefined(self.a.array["grenade_rambo"])) {
      var_2 = animscripts\utility::animarray("grenade_rambo");
    }
  }

  if(!isDefined(var_2)) {
    if(isDefined(var_1) && var_1) {
      if(!isDefined(self.a.array["grenade_safe"])) {
        return 0;
      }
      var_2 = animscripts\utility::animarray("grenade_safe");
    } else {
      if(!isDefined(self.a.array["grenade_exposed"])) {
        return 0;
      }
      var_2 = animscripts\utility::animarray("grenade_exposed");
    }
  }

  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;
  var_3 = animscripts\combat_utility::trygrenade(var_0, var_2);
  self.keepclaimednodeifvalid = 0;
  return var_3;
}

printyawtoenemy() {}

lookforenemy(var_0) {
  if(!isDefined(self.a.array["alert_to_look"])) {
    return 0;
  }
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 1;

  if(!peekout()) {
    return 0;
  }
  animscripts\shared::playlookanimation(animscripts\utility::animarray("look_idle"), var_0, ::canstoppeeking);
  var_1 = undefined;

  if(animscripts\utility::issuppressedwrapper()) {
    var_1 = animscripts\utility::animarray("look_to_alert_fast");
  } else {
    var_1 = animscripts\utility::animarray("look_to_alert");
  }
  self setflaggedanimknoballrestart("looking_end", var_1, %body, 1, 0.1, 1.0);
  animscripts\shared::donotetracks("looking_end");
  self animmode("zonly_physics");
  self.keepclaimednodeifvalid = 0;
  return 1;
}

ispeekoutposclear() {
  var_0 = self getEye();
  var_1 = anglestoright(self.covernode.angles);

  if(self.cornerdirection == "right") {
    var_0 = var_0 + var_1 * 30;
  } else {
    var_0 = var_0 - var_1 * 30;
  }
  var_2 = var_0 + anglesToForward(self.covernode.angles) * 30;
  return sighttracepassed(var_0, var_2, 1, self);
}

peekout() {
  if(isDefined(self.covernode.script_dontpeek)) {
    return 0;
  }
  if(isDefined(self.nextpeekoutattempttime) && gettime() < self.nextpeekoutattempttime) {
    return 0;
  }
  if(!ispeekoutposclear()) {
    self.nextpeekoutattempttime = gettime() + 3000;
    return 0;
  }

  var_0 = animscripts\utility::animarray("alert_to_look");
  self setflaggedanimknoball("looking_start", var_0, %body, 1, 0.2, 1);
  animscripts\shared::donotetracks("looking_start");
  return 1;
}

canstoppeeking() {
  return self maymovetopoint(self.covernode.origin);
}

fastlook() {
  return 0;
}

cornerreload() {
  var_0 = animscripts\utility::animarraypickrandom("reload");
  self setflaggedanimknobrestart("cornerReload", var_0, 1, 0.2);
  animscripts\shared::donotetracks("cornerReload");
  animscripts\weaponlist::refillclip();
  self setanimrestart(animscripts\utility::animarray("alert_idle"), 1, 0.2);
  self clearanim(var_0, 0.2);
  return 1;
}

ispathclear(var_0, var_1) {
  if(var_1) {
    var_2 = getpredictedpathmidpoint();

    if(!self maymovetopoint(var_2)) {
      return 0;
    }
    return self maymovefrompointtopoint(var_2, animscripts\utility::getanimendpos(var_0));
  } else {
    return self maymovetopoint(animscripts\utility::getanimendpos(var_0));
  }
}

getpredictedpathmidpoint(var_0) {
  var_1 = self.covernode.angles;
  var_2 = anglestoright(var_1);

  if(!isDefined(var_0)) {
    var_0 = 36;
  }
  switch (self.script) {
    case "cover_left":
      var_2 = var_2 * (0 - var_0);
      break;
    case "cover_right":
      var_2 = var_2 * var_0;
      break;
    default:
  }

  return self.covernode.origin + (var_2[0], var_2[1], 0);
}

idle() {
  self endon("end_idle");

  for(;;) {
    var_0 = randomint(2) == 0 && animscripts\utility::animarrayanyexist("alert_idle_twitch");

    if(var_0) {
      var_1 = animscripts\utility::animarraypickrandom("alert_idle_twitch");
    } else {
      var_1 = animscripts\utility::animarray("alert_idle");
    }
    playidleanimation(var_1, var_0);
  }
}

flinch() {
  if(!animscripts\utility::animarrayanyexist("alert_idle_flinch")) {
    return 0;
  }
  playidleanimation(animscripts\utility::animarraypickrandom("alert_idle_flinch"), 1);
  return 1;
}

playidleanimation(var_0, var_1) {
  if(var_1) {
    self setflaggedanimknoballrestart("idle", var_0, %body, 1, 0.1, 1);
  } else {
    self setflaggedanimknoball("idle", var_0, %body, 1, 0.1, 1);
  }
  animscripts\shared::donotetracks("idle");
}

set_anim_array(var_0) {
  [[self.animarrayfuncs["hiding"][var_0]]]();
  [[self.animarrayfuncs["exposed"][var_0]]]();
}

set_anim_array_aiming(var_0) {
  [[self.animarrayfuncs["exposed"][var_0]]]();
}

transitiontostance(var_0) {
  if(self.a.pose == var_0) {
    set_anim_array(var_0);
    return;
  }

  self setflaggedanimknoballrestart("changeStance", animscripts\utility::animarray("stance_change"), %body);
  set_anim_array(var_0);
  animscripts\shared::donotetracks("changeStance");
  wait 0.2;
}

gotocover(var_0, var_1, var_2) {
  var_3 = animscripts\utility::getnodedirection();
  var_4 = animscripts\utility::getnodeorigin();
  var_5 = var_3 + self.hideyawoffset;
  self orientmode("face angle", var_5);
  self animmode("normal");
  thread animscripts\shared::movetooriginovertime(var_4, var_1);
  self setflaggedanimknoballrestart("coveranim", var_0, %body, 1, var_1);
  animscripts\notetracks::donotetracksfortime(var_2, "coveranim");

  while(animscripts\utility::absangleclamp180(self.angles[1] - var_5) > 1) {
    animscripts\notetracks::donotetracksfortime(0.1, "coveranim");
  }
  self animmode("zonly_physics");

  if(self.cornerdirection == "left") {
    self.a.special = "cover_left";
  } else {
    self.a.special = "cover_right";
  }
}

drawoffset() {
  self endon("killanimscript");

  for(;;) {
    wait 0.05;
  }
}

set_standing_animarray_aiming() {
  if(!isDefined(self.a.array)) {}

  self.a.array["add_aim_up"] = % exposed_aim_8;
  self.a.array["add_aim_down"] = % exposed_aim_2;
  self.a.array["add_aim_left"] = % exposed_aim_4;
  self.a.array["add_aim_right"] = % exposed_aim_6;
  self.a.array["add_turn_aim_up"] = % exposed_turn_aim_8;
  self.a.array["add_turn_aim_down"] = % exposed_turn_aim_2;
  self.a.array["add_turn_aim_left"] = % exposed_turn_aim_4;
  self.a.array["add_turn_aim_right"] = % exposed_turn_aim_6;
  self.a.array["straight_level"] = % exposed_aim_5;

  if(self.a.cornermode == "lean") {
    var_0 = self.a.array["lean_fire"];
    var_1 = self.a.array["lean_single"];
    self.a.array["fire"] = var_0;
    self.a.array["single"] = animscripts\utility::array(var_1);
    self.a.array["semi2"] = var_1;
    self.a.array["semi3"] = var_1;
    self.a.array["semi4"] = var_1;
    self.a.array["semi5"] = var_1;
    self.a.array["burst2"] = var_0;
    self.a.array["burst3"] = var_0;
    self.a.array["burst4"] = var_0;
    self.a.array["burst5"] = var_0;
    self.a.array["burst6"] = var_0;
  } else {
    self.a.array["fire"] = % exposed_shoot_auto_v2;
    self.a.array["semi2"] = % exposed_shoot_semi2;
    self.a.array["semi3"] = % exposed_shoot_semi3;
    self.a.array["semi4"] = % exposed_shoot_semi4;
    self.a.array["semi5"] = % exposed_shoot_semi5;

    if(animscripts\utility::weapon_pump_action_shotgun()) {
      self.a.array["single"] = animscripts\utility::array(%shotgun_stand_fire_1a);
    } else {
      self.a.array["single"] = animscripts\utility::array(%exposed_shoot_semi1);
    }
    self.a.array["burst2"] = % exposed_shoot_burst3;
    self.a.array["burst3"] = % exposed_shoot_burst3;
    self.a.array["burst4"] = % exposed_shoot_burst4;
    self.a.array["burst5"] = % exposed_shoot_burst5;
    self.a.array["burst6"] = % exposed_shoot_burst6;
  }

  self.a.array["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
}

set_crouching_animarray_aiming() {
  if(!isDefined(self.a.array)) {}

  if(self.a.cornermode == "over") {
    self.a.array["add_aim_up"] = % covercrouch_aim8_add;
    self.a.array["add_aim_down"] = % covercrouch_aim2_add;
    self.a.array["add_aim_left"] = % covercrouch_aim4_add;
    self.a.array["add_aim_right"] = % covercrouch_aim6_add;
    self.a.array["straight_level"] = % covercrouch_aim5;
    var_0["fire"] = % exposed_shoot_auto_v2;
    var_0["semi2"] = % exposed_shoot_semi2;
    var_0["semi3"] = % exposed_shoot_semi3;
    var_0["semi4"] = % exposed_shoot_semi4;
    var_0["semi5"] = % exposed_shoot_semi5;
    var_0["burst2"] = % exposed_shoot_burst3;
    var_0["burst3"] = % exposed_shoot_burst3;
    var_0["burst4"] = % exposed_shoot_burst4;
    var_0["burst5"] = % exposed_shoot_burst5;
    var_0["burst6"] = % exposed_shoot_burst6;

    if(animscripts\utility::weapon_pump_action_shotgun()) {
      var_0["single"] = animscripts\utility::array(%shotgun_crouch_fire);
    } else {
      var_0["single"] = animscripts\utility::array(%exposed_shoot_semi1);
    }
    self.a.array["exposed_idle"] = animscripts\utility::array(%exposed_idle_alert_v1, %exposed_idle_alert_v2, %exposed_idle_alert_v3);
    return;
  }

  if(self.a.cornermode == "lean") {
    var_1 = self.a.array["lean_fire"];
    var_2 = self.a.array["lean_single"];
    self.a.array["fire"] = var_1;
    self.a.array["single"] = animscripts\utility::array(var_2);
    self.a.array["semi2"] = var_2;
    self.a.array["semi3"] = var_2;
    self.a.array["semi4"] = var_2;
    self.a.array["semi5"] = var_2;
    self.a.array["burst2"] = var_1;
    self.a.array["burst3"] = var_1;
    self.a.array["burst4"] = var_1;
    self.a.array["burst5"] = var_1;
    self.a.array["burst6"] = var_1;
  } else {
    self.a.array["fire"] = % exposed_crouch_shoot_auto_v2;
    self.a.array["semi2"] = % exposed_crouch_shoot_semi2;
    self.a.array["semi3"] = % exposed_crouch_shoot_semi3;
    self.a.array["semi4"] = % exposed_crouch_shoot_semi4;
    self.a.array["semi5"] = % exposed_crouch_shoot_semi5;

    if(animscripts\utility::weapon_pump_action_shotgun()) {
      self.a.array["single"] = animscripts\utility::array(%shotgun_crouch_fire);
    } else {
      self.a.array["single"] = animscripts\utility::array(%exposed_crouch_shoot_semi1);
    }
    self.a.array["burst2"] = % exposed_crouch_shoot_burst3;
    self.a.array["burst3"] = % exposed_crouch_shoot_burst3;
    self.a.array["burst4"] = % exposed_crouch_shoot_burst4;
    self.a.array["burst5"] = % exposed_crouch_shoot_burst5;
    self.a.array["burst6"] = % exposed_crouch_shoot_burst6;
  }

  self.a.array["add_aim_up"] = % exposed_crouch_aim_8;
  self.a.array["add_aim_down"] = % exposed_crouch_aim_2;
  self.a.array["add_aim_left"] = % exposed_crouch_aim_4;
  self.a.array["add_aim_right"] = % exposed_crouch_aim_6;
  self.a.array["add_turn_aim_up"] = % exposed_crouch_turn_aim_8;
  self.a.array["add_turn_aim_down"] = % exposed_crouch_turn_aim_2;
  self.a.array["add_turn_aim_left"] = % exposed_crouch_turn_aim_4;
  self.a.array["add_turn_aim_right"] = % exposed_crouch_turn_aim_6;
  self.a.array["straight_level"] = % exposed_crouch_aim_5;
  self.a.array["exposed_idle"] = animscripts\utility::array(%exposed_crouch_idle_alert_v1, %exposed_crouch_idle_alert_v2, %exposed_crouch_idle_alert_v3);
}

runcombat() {
  self notify("killanimscript");
  thread animscripts\combat::main();
}