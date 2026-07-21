/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: anim\grenade_cower.gsc
***********************************************/

#using_animtree("generic_human");

main() {
  if(getdvarint("LPNQTQRRP", 0) == 1) {
    self endon("killanimscript");
    self endon("death");
    self waittill("killanimscript");
  }

  self endon("killanimscript");
  scripts\anim\utility.gsc::initialize("grenadecower");

  if(isDefined(self.grenadecowerfunction)) {
    self[[self.grenadecowerfunction]]();
    return;
  }

  if(self.currentpose == "prone") {
    return;
  }
  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
  var_0 = 0;

  if(isDefined(self.grenade))
    var_0 = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);
  else
    var_0 = self.angles[1];

  if(self.currentpose == "stand") {
    if(isDefined(self.grenade) && trydive(var_0)) {
      return;
    }
    self setflaggedanimknoballrestart("cowerstart", scripts\anim\utility.gsc::lookupanim("grenade", "cower_squat"), %body, 1, 0.2);
    scripts\anim\notetracks.gsc::donotetracks("cowerstart");
  }

  self.currentpose = "crouch";
  self.a.movement = "stop";
  self setflaggedanimknoballrestart("cower", scripts\anim\utility.gsc::lookupanim("grenade", "cower_squat_idle"), %body, 1, 0.2);
  scripts\anim\notetracks.gsc::donotetracks("cower");
  self waittill("never");
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
    var_1 = scripts\anim\utility.gsc::lookupanim("grenade", "cower_dive_back");
  else
    var_1 = scripts\anim\utility.gsc::lookupanim("grenade", "cower_dive_front");

  var_2 = getmovedelta(var_1, 0, 0.5);
  var_3 = self localtoworldcoords(var_2);

  if(!self maymovetopoint(var_3))
    return 0;

  self.safetochangescript = 0;
  self setflaggedanimknoballrestart("cowerstart", var_1, %body, 1, 0.2);
  scripts\anim\notetracks.gsc::donotetracks("cowerstart");
  self.safetochangescript = 1;
  return 1;
}