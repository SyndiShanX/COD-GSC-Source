/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\stop.gsc
**************************************/

#using_animtree("generic_human");

main() {
  if(isDefined(self._id_10EF)) {
    return;
  }
  if(isDefined(self._id_0CB3)) {
    animscripts\snowmobile::main();
    return;
  }

  if(isDefined(self._id_10A5)) {
    if(isDefined(self._id_10A5["stop"])) {
      [[self._id_10A5["stop"]]]();
      return;
    }
  }

  self notify("stopScript");
  self endon("killanimscript");
  [[self.defaultexception["stop_immediate"]]]();
  thread _id_1104();
  animscripts\utility::_id_0D15("stop");
  _id_10F5();
  animscripts\utility::_id_10F0();
  thread _id_10F3();
  thread animscripts\reactions::_id_0F20();
  var_0 = isDefined(self._id_0C89);

  if(!var_0) {
    if(self.a._id_0EE4["right"] == "none" && self.a._id_0EE4["left"] == "none") {
      var_0 = 1;
    } else if(angleclamp180(self getmuzzleangle()[0]) > 20) {
      var_0 = 1;
    }
  }

  for(;;) {
    var_1 = _id_10F8();

    if(var_1 == "prone") {
      var_0 = 1;
      _id_1102();
      continue;
    }

    if(self.a._id_0D26 != var_1) {
      self clearanim(%root, 0.3);
      var_0 = 0;
    }

    animscripts\setposemovement::_id_10F1(var_1, "stop");

    if(!var_0) {
      _id_10F9(var_1, self.a._id_10F2);
      var_0 = 1;
      continue;
    }

    _id_10FB(var_1, self.a._id_10F2);
  }
}

_id_10F3() {
  self endon("death");
  self waittill("killanimscript");
  self._id_10F4 = gettime();
}

_id_10F5() {
  self endon("stop_specialidle");

  if(isDefined(self._id_10F6)) {
    var_0 = self._id_10F6;
    self._id_10F6 = undefined;
    self notify("clearing_specialIdleAnim");
    self animmode("gravity");
    self orientmode("face current");
    self clearanim(%root, 0.2);

    for(;;) {
      self setflaggedanimrestart("special_idle", var_0[randomint(var_0.size)], 1, 0.2, self._id_10F7);
      self waittillmatch("special_idle", "end");
    }
  }
}

_id_10F8() {
  var_0 = animscripts\utility::_id_0BEE();

  if(isDefined(var_0)) {
    var_1 = var_0.angles[1];
    var_2 = var_0.type;
  } else {
    var_1 = self.desiredangle;
    var_2 = "node was undefined";
  }

  animscripts\face::_id_0C45(anim._id_0C3D);
  var_3 = animscripts\utility::_id_10AF();

  if(var_2 == "Cover Stand" || var_2 == "Conceal Stand") {
    var_3 = animscripts\utility::_id_10AF("stand");
  } else if(var_2 == "Cover Crouch" || var_2 == "Conceal Crouch") {
    var_3 = animscripts\utility::_id_10AF("crouch");
  } else if(var_2 == "Cover Prone" || var_2 == "Conceal Prone") {
    var_3 = animscripts\utility::_id_10AF("prone");
  }
  return var_3;
}

_id_10F9(var_0, var_1) {
  if(animscripts\utility::_id_0C98() && self.a._id_0D26 == "stand") {
    var_0 = "stand_cqb";
  }
  if(isDefined(anim._id_10FA[var_0])) {
    var_2 = anim._id_10FA[var_0]["in"];
    self setflaggedanimknoballrestart("idle_transition", var_2, %body, 1, 0.2, self._id_10F7);
    animscripts\shared::_id_0C51("idle_transition");
  }
}

_id_10FB(var_0, var_1) {
  if(animscripts\utility::_id_0C98() && self.a._id_0D26 == "stand") {
    var_0 = "stand_cqb";
  }
  var_2 = undefined;

  if(isDefined(self._id_0C89) && isDefined(self._id_0C89[var_0])) {
    var_3 = self._id_0C89[var_0];
    var_4 = var_0 + "_add";

    if(isDefined(self._id_0C89[var_4])) {
      var_2 = self._id_0C89[var_4];
    }
  } else if(isDefined(anim._id_10FC) && (var_0 == "stand" || var_0 == "stand_cqb") && isDefined(self._id_10FD) && self._id_10FD == 1) {
    var_3 = animscripts\utility::_id_10FF(anim._id_10FC["stand"][0], anim._id_10FE["stand"][0]);
  } else {
    var_1 = var_1 % anim._id_1100[var_0].size;
    var_3 = animscripts\utility::_id_10FF(anim._id_1100[var_0][var_1], anim._id_1101[var_0][var_1]);
  }

  var_5 = 0.2;

  if(gettime() == self.a._id_1019) {
    var_5 = 0.5;
  }
  if(isDefined(var_2)) {
    self setanimknoball(var_3, %body, 1, var_5, 1);
    self setanim(%add_idle);
    self setflaggedanimknoballrestart("idle", var_2, %add_idle, 1, var_5, self._id_10F7);
  } else {
    self setflaggedanimknoballrestart("idle", var_3, %body, 1, var_5, self._id_10F7);
  }
  animscripts\shared::_id_0C51("idle");
}

_id_1102() {
  if(self.a._id_0D26 != "prone") {
    var_0["stand_2_prone"] = % stand_2_prone;
    var_0["crouch_2_prone"] = % crouch_2_prone;
    var_1 = var_0[self.a._id_0D26 + "_2_prone"];
    self setflaggedanimknoballrestart("trans", var_1, %body, 1, 0.2, 1.0);
    animscripts\shared::_id_0C51("trans");
    self.a._id_0D2B = "stop";
    self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_modern, %prone_legs_up);
    return;
  }

  thread _id_1103();

  if(randomint(10) < 3) {
    var_2 = [];
    var_2[0] = % prone_twitch_ammocheck;
    var_2[1] = % prone_twitch_look;
    var_2[2] = % prone_twitch_scan;
    var_2[3] = % prone_twitch_lookfast;
    var_2[4] = % prone_twitch_lookup;
    var_3 = var_2[randomint(var_2.size)];
    self setflaggedanimknoball("prone_idle", var_3, %exposed_modern, 1, 0.2);
  } else {
    self setanimknoball(%prone_aim_5, %exposed_modern, 1, 0.2);
    self setflaggedanimknob("prone_idle", %prone_idle, 1, 0.2);
  }

  self waittillmatch("prone_idle", "end");
  self notify("kill UpdateProneThread");
}

_id_1103() {
  self endon("killanimscript");
  self endon("kill UpdateProneThread");

  for(;;) {
    animscripts\cover_prone::_id_10E2(0.1);
    wait 0.1;
  }
}

_id_1104() {
  self endon("killanimscript");
  wait 0.05;
  [[self.defaultexception["stop"]]]();
}