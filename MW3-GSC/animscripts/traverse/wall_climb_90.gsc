/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\traverse\wall_climb_90.gsc
**************************************************/

#using_animtree("generic_human");

main() {
  self._id_4006 = 1;
  _id_4007(%traverse40, 90);
}

_id_4007(var_0, var_1) {
  self._id_247C = "crouch";
  animscripts\utility::_id_247B();
  self endon("killanimscript");
  self traversemode("nogravity");
  self traversemode("noclip");
  var_2 = self getnegotiationstartnode();
  self orientmode("face angle", var_2.angles[1]);
  var_3 = var_2._id_1EFA - var_2.origin[2];
  thread animscripts\traverse\shared::_id_3FE7(var_3 - var_1);
  self setflaggedanimknoballrestart("traverse", var_0, %body, 1, 0.15, 1);
  var_4 = gettime();
  thread animscripts\notetracks::_id_239E("traverse", "no clear", ::_id_4008);

  if(!animhasnotetrack(var_0, "gravity on")) {
    var_4 = 1.23;
    var_5 = 0.2;
    wait 5.0;
    self traversemode("gravity");
    wait(var_5);
  } else {
    self waittillmatch("traverse", "gravity on");
    self traversemode("gravity");

    if(!animhasnotetrack(var_0, "blend")) {
      wait 0.2;
    } else {
      self waittillmatch("traverse", "blend");
    }
  }
}

_id_4008(var_0) {
  if(var_0 != "traverse_death") {
    return;
  }
  self endon("killanimscript");

  if(self.health == 1) {
    self.a._id_0D55 = 1;

    if(self._id_4006 > 1) {
      self setflaggedanimknoball("deathanim", %traverse90_end_death, %body, 1, 0.2, 1);
    } else {
      self setflaggedanimknoball("deathanim", %traverse90_start_death, %body, 1, 0.2, 1);
    }
    animscripts\face::_id_0C41("death");
  }

  self._id_4006++;
}