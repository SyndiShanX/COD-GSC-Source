/***********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\bigdog\bigdog_death.gsc
***********************************************/

#include common_scripts\utility;
#include animscripts\anims;
#include maps\_utility;
#include animscripts\bigdog\bigdog_utility;

main() {
  self endon("killanimscript");

  if(isDefined(self.a.nodeathanim) && self.a.nodeathanim) {
    wait 0.1;
    return;
  } else if(isDefined(self.a.meleedeath) && self.a.meleedeath) {
    self self_destruct();
    return;
  }

  animscripts\bigdog\bigdog_utility::initialize("death");
  handlebigdogdeathfunction();
  death();
}

handlebigdogdeathfunction() {
  if(isDefined(self.deathfunction))
    self[[self.deathfunction]]();
}

death() {
  return normal_death();
}

normal_death() {
  self orientmode("face angle", self.angles[1]);
  self animmode("zonly_physics");
  deathanim = get_death_anim();
  assert(isDefined(deathanim));
  self setflaggedanimrestart("death", deathanim, 1, 0.2, 1);
  self self_destruct();
}

get_death_anim() {
  deathanim = undefined;

  if(self.damageyaw > 135 || self.damageyaw <= -135)
    deathanim = animarray("death_b");
  else if(self.damageyaw > 45 && self.damageyaw < 135)
    deathanim = animarray("death_l");
  else if(self.damageyaw > -135 && self.damageyaw < -45)
    deathanim = animarray("death_r");
  else
    deathanim = animarray("death_f");

  return deathanim;
}

self_destruct() {
  fxorigin = self gettagorigin("tag_body");
  self notify("stop_fire_turret");
  self notify("stop_bigdog_scripted_fx_threads");
  wait 0.05;

  if(isDefined(self.turret))
    self.turret delete();

  badplace_delete(self.a.badplacename + "1");

  if(isDefined(self.bigdogusebiggerbadplace) && self.bigdogusebiggerbadplace)
    badplace_delete(self.a.badplacename + "2");

  radiusdamage(fxorigin, 256, 200, 50, level.player);
  playfx(anim._effect["bigdog_explosion"], fxorigin);
  playsoundatposition("wpn_bigdog_explode", fxorigin);
  self notsolid();
  self hide();
}