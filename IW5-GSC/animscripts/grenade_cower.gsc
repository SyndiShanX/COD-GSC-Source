/*****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\grenade_cower.gsc
*****************************************/

#using_animtree("generic_human");

main() {
  self endon("killanimscript");
  animscripts\utility::_id_0D15("grenadecower");

  if(isDefined(self._id_3ACA)) {
    self[[self._id_3ACA]]();
    return;
  }

  if(self.a._id_0D26 == "prone") {
    animscripts\stop::main();
    return;
  }

  self animmode("zonly_physics");
  self orientmode("face angle", self.angles[1]);
  var_0 = 0;

  if(isDefined(self.grenade)) {
    var_0 = angleclamp180(vectortoangles(self.grenade.origin - self.origin)[1] - self.angles[1]);
  } else {
    var_0 = self.angles[1];
  }
  if(self.a._id_0D26 == "stand") {
    if(isDefined(self.grenade) && _id_3FE0(var_0)) {
      return;
    }
    self setflaggedanimknoballrestart("cowerstart", %exposed_squat_down_grenade_f, %body, 1, 0.2);
    animscripts\shared::_id_0C51("cowerstart");
  }

  self.a._id_0D26 = "crouch";
  self.a._id_0D2B = "stop";
  self setflaggedanimknoballrestart("cower", %exposed_squat_idle_grenade_f, %body, 1, 0.2);
  animscripts\shared::_id_0C51("cower");
  self waittill("never");
}

end_script() {
  self.safetochangescript = 1;
}

_id_3FE0(var_0) {
  if(randomint(2) == 0) {
    return 0;
  }
  if(self.stairsstate != "none") {
    return 0;
  }
  var_1 = undefined;

  if(abs(var_0) > 90) {
    var_1 = % exposed_dive_grenade_b;
  } else {
    var_1 = % exposed_dive_grenade_f;
  }
  var_2 = getmovedelta(var_1, 0, 0.5);
  var_3 = self localtoworldcoords(var_2);

  if(!self maymovetopoint(var_3)) {
    return 0;
  }
  self.safetochangescript = 0;
  self setflaggedanimknoballrestart("cowerstart", var_1, %body, 1, 0.2);
  animscripts\shared::_id_0C51("cowerstart");
  self.safetochangescript = 1;
  return 1;
}