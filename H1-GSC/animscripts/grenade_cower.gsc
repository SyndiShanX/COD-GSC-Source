/*****************************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\grenade_cower.gsc
*****************************************/

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  animscripts\utility::initialize("grenadecower");

  if(isdefined(self.grenadecowerfunction)) {
    self[[self.grenadecowerfunction]]();
    return;
  }

  if(self.a.pose == "prone") {
    animscripts\stop::main();
    return;
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
  var_0 = 0;

  if(isdefined(self.grenade))
    var_0 = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);
  else
    var_0 = self.angles[1];

  if(self.a.pose == "stand") {
    if(isdefined(self.grenade) && trydive(var_0)) {
      return;
    }
    self setflaggedanimknoballrestart("cowerstart", animscripts\utility::lookupanim("grenade", "cower_squat"), % body, 1, 0.2);
    self.custommovetransition = ::squatouttransition;
    animscripts\shared::donotetracks("cowerstart");
  }

  self.a.pose = "crouch";
  self.a.movement = "stop";
  self setflaggedanimknoballrestart("cower", animscripts\utility::lookupanim("grenade", "cower_squat_idle"), % body, 1, 0.2);
  animscripts\shared::donotetracks("cower");
  self waittill("never");
}

squatouttransition() {
  self orientmode("face angle", self.angles[1]);
  self.nododgemove = 1;
  self setflaggedanimknoballrestart("cowerend", animscripts\utility::lookupanim("grenade", "cower_squat_up"), % body, 1, 0.4);
  animscripts\shared::donotetracks("cowerend");
  self.custommovetransition = undefined;
  self.a.movement = "stop";
  self.nododgemove = 0;
  animscripts\exit_node::startmovetransition();
}

end_script() {
  self.safetochangescript = 1;
}

trydive(var_0) {
  if(randomint(2) == 0)
    return 0;

  if(self.stairsstate != "none")
    return 0;

  var_1 = undefined;

  if(abs(var_0) > 90)
    var_1 = animscripts\utility::lookupanim("grenade", "cower_dive_back");
  else
    var_1 = animscripts\utility::lookupanim("grenade", "cower_dive_front");

  var_2 = getmovedelta(var_1, 0, 0.5);
  var_3 = self localtoworldcoords(var_2);

  if(!self maymovetopoint(var_3))
    return 0;

  self.safetochangescript = 0;
  self setflaggedanimknoballrestart("cowerstart", var_1, % body, 1, 0.2);
  animscripts\shared::donotetracks("cowerstart");
  self.safetochangescript = 1;
  return 1;
}