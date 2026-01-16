/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\prone.gsc
**************************************/

#include maps\_utility;
#include animscripts\combat_utility;
#include animscripts\utility;
#include animscripts\setposemovement;
#include animscripts\combat;
#include animscripts\shared;
#include animscripts\face;
#include animscripts\weaponlist;

pronerangecombat(changereason) {
  self trackscriptstate("ProneRangeCombat", changereason);
  self endon("killanimscript");
  assert(isDefined(changereason), "Script state called without reason.");
  self thread proneturningthread(::pronecombatthread, "kill ProneRangeCombat");
  timer = gettime();
  self waittill("kill ProneRangeCombat");

  if(gettime() == timer)
    wait 0.05;

  self thread animscripts\combat::main();
}

set3flaggedanimknobs(animflag, animarray, weight, blendtime, rate) {
  self setanimknob(animarray["left"], weight, blendtime, rate);
  self setflaggedanimknob(animflag, animarray["middle"], weight, blendtime, rate);
  self setanimknob(animarray["right"], weight, blendtime, rate);
}

#using_animtree("generic_human");

proneturningthread(threadtospawn, killmestring) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmestring);
  self.a.usingproneleftandright = 0;

  if(isDefined(threadtospawn))
    self thread[[threadtospawn]]("kill ProneTurningThread children");

  for(;;) {
    if(self.a.pose != "prone")
      self orientmode("face default");
    else {
      self orientmode("face enemy");
      attackyaw = self.angles[1];

      if(hasenemysightpos()) {
        pos = getenemysightpos();
        attackyaw = vectortoangles(pos - self.origin)[1];
      }

      yawdelta = self.angles[1] - attackyaw;
      yawdelta = int(yawdelta + 360) % 360;

      if(yawdelta > 180)
        yawdelta = yawdelta - 360;

      if(yawdelta > 0) {
        if(self.a.usingproneleftandright) {
          amount = yawdelta / 45.0;

          if(amount < 0.01)
            amount = 0.01;
          else if(amount > 0.99)
            amount = 0.99;

          self setanimknob( % prone_straight, 1.0 - amount, 0.1, 1);
          self setanim( % prone_right45, amount, 0.1, 1);
          self setanim( % prone_left45, 0.01, 0.1, 1);
        }

        if(yawdelta > 45) {
          self notify("kill ProneTurningThread children");
          self setflaggedanimknobrestart("turn anim", % prone_turn_right, 1, 0.1, 1);
          self animscripts\shared::donotetracks("turn anim");
          self updateprone( % prone_shootfeet_straight45up, % prone_shootfeet_straight45down, 1, 0.1, 1);

          if(isDefined(threadtospawn))
            self thread[[threadtospawn]]("kill ProneTurningThread children");
        }
      } else {
        if(self.a.usingproneleftandright) {
          amount = yawdelta / -45;

          if(amount < 0.01)
            amount = 0.01;
          else if(amount > 0.99)
            amount = 0.99;

          self setanimknob( % prone_straight, 1.0 - amount, 0.1, 1);
          self setanim( % prone_left45, amount, 0.1, 1);
          self setanim( % prone_right45, 0.01, 0.1, 1);
        }

        if(yawdelta < -45) {
          self notify("kill ProneTurningThread children");
          self setflaggedanimknobrestart("turn anim", % prone_turn_left, 1, 0.1, 1);
          self animscripts\shared::donotetracks("turn anim");
          self updateprone( % prone_shootfeet_straight45up, % prone_shootfeet_straight45down, 1, 0.1, 1);

          if(isDefined(threadtospawn))
            self thread[[threadtospawn]]("kill ProneTurningThread children");
        }
      }
    }

    self thread waitfornotify("Update prone aim", "Prone aim done waiting", "Prone aim done waiting");
    self thread waitfortime(0.3, "Prone aim done waiting", "Prone aim done waiting");
    waittillframeend;
    self waittill("Prone aim done waiting");
    lookforbettercover();
  }
}

pronecombatthread(killmestring) {
  self endon("killanimscript");
  self endon(killmestring);
  wait 0;

  for(;;) {
    if(!self isstanceallowedwrapper("prone")) {
      self notify("kill ProneRangeCombat");
      break;
    }

    isprone = self.a.pose == "prone";
    canshootfromprone = animscripts\utility::canshootenemyfrompose("prone", undefined, !isprone);
    cangoprone = cangopronehere(self.origin, self.angles[1]);

    if(!cangoprone) {
      self notify("kill ProneRangeCombat");
      break;
    }

    if(canshootfromprone) {
      proneshootvolley();
      reload(0);
    } else {
      reload(0.999);
      wait 0.05;
    }

    self.enemydistancesq = self getclosestenemysqdist();

    if(animscripts\utility::getnodetype() != "Cover Prone" && self.enemydistancesq < anim.pronerangesq) {
      self notify("kill ProneRangeCombat");
      break;
    }
  }

  scriptchange();
}

waitfornotify(waitforstring, notifystring, killmestring) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmestring);
  self waittill(waitforstring);
  self notify(notifystring);
}

waitfortime(time, notifystring, killmestring) {
  self endon("killanimscript");
  self endon("death");
  self endon(killmestring);
  wait(time);
  self notify(notifystring);
}

candopronecombat(origin, yaw) {
  if(!self isstanceallowedwrapper("prone"))
    return 0;

  if(weaponanims() == "pistol")
    return 0;

  if(mygetenemysqdist() < anim.pronerangesq)
    return 0;

  canshootprone = animscripts\utility::canshootenemyfrompose("prone");

  if(!canshootprone)
    return 0;

  return cangopronehere(origin, yaw);
}

cangopronehere(origin, yaw) {
  alreadyprone = self.a.pose == "prone";
  canfitprone = self checkprone(origin, yaw, alreadyprone);
  return canfitprone;
}

proneshootvolley() {
  self setposemovement("prone", "stop");
  shootanims["middle"] = % prone_shoot_straight;
  shootanims["left"] = % prone_shoot_left;
  shootanims["right"] = % prone_shoot_right;
  autoshootanims["middle"] = % prone_shoot_auto_straight;
  autoshootanims["left"] = % prone_shoot_auto_left;
  autoshootanims["right"] = % prone_shoot_auto_right;
  self animscripts\face::setidleface(anim.aimface);
  self.a.usingproneleftandright = 1;
  self notify("Update prone aim");
  self setanimknob( % prone, 1, 0.15, 1);
  rand = randomfloat(1);
  self set3flaggedanimknobs("shootanim", shootanims, 1, 0.15, 0);
  wait(rand);
  self updateplayersightaccuracy();

  if(animscripts\weaponlist::usingautomaticweapon()) {
    self animscripts\face::setidleface(anim.autofireface);
    self set3flaggedanimknobs("shootanim", autoshootanims, 1, 0.15, 0);
    wait 0.2;
    animrate = animscripts\weaponlist::autoshootanimrate();
    self set3flaggedanimknobs("shootanim", autoshootanims, 1, 0.05, animrate);
    rand = randomint(8) + 6;

    for(i = 0; i < rand; i++) {
      self waittillmatch("shootanim", "fire");
      self shootenemywrapper();
      self decrementbulletsinclip();
    }
  } else if(animscripts\weaponlist::usingsemiautoweapon()) {
    self set3flaggedanimknobs("shootanim", shootanims, 1, 0.2, 0);
    wait 0.2;
    rand = randomint(3) + 2;

    for(i = 0; i < rand; i++) {
      self set3flaggedanimknobs("shootanim", shootanims, 1, 0, 1);
      self shootenemywrapper();
      self decrementbulletsinclip();
      shoottime = animscripts\weaponlist::shootanimtime();
      quicktime = animscripts\weaponlist::waitaftershot();
      wait(quicktime);

      if(i < rand - 1 && shoottime > quicktime)
        wait(shoottime - quicktime);
    }
  }

  self.a.usingproneleftandright = 0;
}