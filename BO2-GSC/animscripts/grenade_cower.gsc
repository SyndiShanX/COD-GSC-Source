/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\grenade_cower.gsc
*****************************************/

#include animscripts\utility;
#include animscripts\anims;
#include maps\_dds;
#include animscripts\stop;
#include animscripts\shared;
#using_animtree("generic_human");

main() {
  self trackscriptstate("GrenadeCower Main", "code");
  self endon("killanimscript");
  animscripts\utility::initialize("grenadecower");
  self maps\_dds::dds_notify("react_grenade", self.team == "allies");

  if(self.a.pose == "prone") {
    animscripts\stop::main();
    return;
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
  grenadeangle = 0;
  assert(isDefined(self.grenade));

  if(isDefined(self.grenade))
    grenadeangle = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);
  else
    grenadeangle = self.angles[1];

  if(self.a.pose == "stand") {
    if(isDefined(self.grenade) && trydive(grenadeangle)) {
      return;
    }
    self setflaggedanimknoballrestart("cowerstart", animarray("cower_start"), % body, 1, 0.2);
    self animscripts\shared::donotetracks("cowerstart");
  }

  self.a.pose = "crouch";
  self.a.movement = "stop";
  self setflaggedanimknoballrestart("cower", animarray("cower_idle"), % body, 1, 0.2);
  self animscripts\shared::donotetracks("cower");
  self waittill("never");
}

trydive(grenadeangle) {
  diveanim = undefined;

  if(abs(grenadeangle) > 90)
    diveanim = animarray("dive_forward");
  else
    diveanim = animarray("dive_backward");

  moveby = getmovedelta(diveanim, 0, 0.5);
  divetopos = self localtoworldcoords(moveby);

  if(!self maymovetopoint(divetopos))
    return false;

  self setflaggedanimknoballrestart("cowerstart", diveanim, % body, 1, 0.2);
  self animscripts\shared::donotetracks("cowerstart");
  return true;
}