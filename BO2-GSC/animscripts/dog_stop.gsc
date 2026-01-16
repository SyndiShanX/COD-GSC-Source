/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog_stop.gsc
**************************************/

#include animscripts\shared;
#using_animtree("dog");

main() {
  self endon("killanimscript");
  self clearanim( % root, 0.2);
  self clearanim( % german_shepherd_idle, 0.2);
  self clearanim( % german_shepherd_attackidle_knob, 0.2);
  self thread lookattarget("attackIdle");

  while(true) {
    if(shouldattackidle()) {
      self clearanim( % german_shepherd_idle, 0.2);
      self randomattackidle();
    } else {
      self orientmode("face current");
      self clearanim( % german_shepherd_attackidle_knob, 0.2);
      self setflaggedanimrestart("dog_idle", % german_shepherd_idle, 1, 0.2, self.animplaybackrate);
    }

    animscripts\shared::donotetracks("dog_idle");
  }
}

isfacingenemy(tolerancecosangle) {
  assert(isDefined(self.enemy));
  vectoenemy = self.enemy.origin - self.origin;
  disttoenemy = length(vectoenemy);

  if(disttoenemy < 1)
    return true;

  forward = anglestoforward(self.angles);
  return (forward[0] * vectoenemy[0] + forward[1] * vectoenemy[1]) / disttoenemy > tolerancecosangle;
}

randomattackidle() {
  if(isfacingenemy(-0.5))
    self orientmode("face current");
  else
    self orientmode("face enemy");

  self clearanim( % german_shepherd_attackidle_knob, 0.1);

  if(should_growl()) {
    self setflaggedanimrestart("dog_idle", % german_shepherd_attackidle_growl, 1, 0.2, 1);
    return;
  }

  idlechance = 33;
  barkchance = 66;

  if(isDefined(self.mode)) {
    if(self.mode == "growl") {
      idlechance = 15;
      barkchance = 30;
    } else if(self.mode == "bark") {
      idlechance = 15;
      barkchance = 85;
    }
  }

  rand = randomint(100);

  if(rand < idlechance)
    self setflaggedanimrestart("dog_idle", % german_shepherd_attackidle, 1, 0.2, self.animplaybackrate);
  else if(rand < barkchance)
    self setflaggedanimrestart("dog_idle", % german_shepherd_attackidle_bark, 1, 0.2, self.animplaybackrate);
  else
    self setflaggedanimrestart("dog_idle", % german_shepherd_attackidle_growl, 1, 0.2, self.animplaybackrate);
}

shouldattackidle() {
  return isDefined(self.enemy) && isalive(self.enemy) && distancesquared(self.origin, self.enemy.origin) < 1000000;
}

should_growl() {
  if(isDefined(self.script_growl))
    return 1;

  if(!isalive(self.enemy))
    return 1;

  return !self cansee(self.enemy);
}

lookattarget(lookposeset) {
  self endon("killanimscript");
  self endon("stop tracking");
  self clearanim( % german_shepherd_look_2, 0);
  self clearanim( % german_shepherd_look_4, 0);
  self clearanim( % german_shepherd_look_6, 0);
  self clearanim( % german_shepherd_look_8, 0);
  self.rightaimlimit = 90;
  self.leftaimlimit = -90;
  self.upaimlimit = 45;
  self.downaimlimit = -45;
  self setanimlimited(anim.doglookpose[lookposeset][2], 1, 0);
  self setanimlimited(anim.doglookpose[lookposeset][4], 1, 0);
  self setanimlimited(anim.doglookpose[lookposeset][6], 1, 0);
  self setanimlimited(anim.doglookpose[lookposeset][8], 1, 0);
  self animscripts\shared::setanimaimweight(1, 0.2);
  self animscripts\shared::setaiminganims( % german_shepherd_look_2, % german_shepherd_look_4, % german_shepherd_look_6, % german_shepherd_look_8);
  self animscripts\shared::trackloopstart();

  if(isDefined(self.enemy))
    self.shootent = self.enemy;
}