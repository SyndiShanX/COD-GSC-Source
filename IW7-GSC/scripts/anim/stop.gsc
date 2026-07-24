/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\anim\stop.gsc
**************************************/

_id_9518() {}

#using_animtree("generic_human");

main() {
  if(isDefined(self._id_BFDC)) {
    return;
  }
  if(isDefined(self._id_4C37)) {
    if(isDefined(self._id_4C37["stop"])) {
      [[self._id_4C37["stop"]]]();
      return;
    }
  }

  self notify("stopScript");
  self endon("killanimscript");
  [[self.exception["stop_immediate"]]]();
  thread _id_50FE();
  scripts\anim\utility::_id_9832("stop");

  if(isDefined(self._id_1095A)) {
    _id_1095B();
  }

  scripts\anim\utility::_id_DCB7();
  thread _id_F77E();
  thread scripts\anim\reactions::_id_DD51();
  var_0 = isDefined(self._id_4C8C);

  if(!var_0) {
    if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none") {
      var_0 = 1;
    } else if(angleclamp180(self getmuzzleangle()[0]) > 20) {
      var_0 = 1;
    }
  }

  for(;;) {
    var_1 = _id_7E6F();

    if(var_1 == "prone") {
      var_0 = 1;
      _id_DA85();
      continue;
    }

    if(self.a.pose != var_1) {
      self clearanim(%root, 0.3);
      var_0 = 0;
    }

    scripts\anim\setposemovement::setposemovement(var_1, "stop");

    if(!var_0) {
      transitiontoidle(var_1, self.a._id_92F9);
      var_0 = 1;
      continue;
    }

    _id_D49C(var_1, self.a._id_92F9);
  }
}

_id_E732(var_0, var_1) {
  self orientmode("face angle", var_0);

  while(angleclamp(var_0 - self.angles[1]) > var_1) {
    wait 0.1;
  }
}

_id_F77E() {
  self endon("death");
  self waittill("killanimscript");
  self._id_AA1F = gettime();
}

_id_1095B() {
  self endon("stop_specialidle");
  var_0 = self._id_1095A;
  self animmode("gravity");
  self orientmode("face current");
  self clearanim(%root, 0.2);

  for(;;) {
    self _meth_82EA("special_idle", var_0[randomint(var_0.size)], 1, 0.2, self.animplaybackrate);
    self waittillmatch("special_idle", "end");
  }
}

_id_7E6F() {
  var_0 = scripts\anim\utility_common::_id_7E28();

  if(isDefined(var_0)) {
    var_1 = var_0.angles[1];
    var_2 = var_0.type;
  } else {
    var_1 = self.desiredangle;
    var_2 = "node was undefined";
  }

  var_3 = scripts\anim\utility::_id_3EF2();

  if(var_2 == "Cover Stand" || var_2 == "Conceal Stand") {
    var_3 = scripts\anim\utility::_id_3EF2("stand");
  } else if(var_2 == "Cover Crouch" || var_2 == "Conceal Crouch") {
    var_3 = scripts\anim\utility::_id_3EF2("crouch");
  } else if(var_2 == "Cover Prone" || var_2 == "Conceal Prone") {
    var_3 = scripts\anim\utility::_id_3EF2("prone");
  }

  return var_3;
}

transitiontoidle(var_0, var_1) {
  if(scripts\anim\utility::_id_9D9B() && self.a.pose == "stand") {
    var_0 = "stand_cqb";
  }

  var_2 = scripts\anim\utility::_id_B028("idle_transitions");

  if(isDefined(var_2[var_0])) {
    var_3 = var_2[var_0];
    self _meth_82E4("idle_transition", var_3, %body, 1, 0.2, self.animplaybackrate);
    scripts\anim\shared::donotetracks("idle_transition");
  }
}

_id_D49C(var_0, var_1) {
  if(scripts\anim\utility::_id_9D9B() && self.a.pose == "stand") {
    var_0 = "stand_cqb";
  }

  var_2 = undefined;

  if(isDefined(self._id_4C8C) && isDefined(self._id_4C8C[var_0])) {
    if(isarray(self._id_4C8C[var_0])) {
      var_3 = scripts\anim\utility::_id_1E9D(self._id_4C8C[var_0], self._id_4C8D[var_0]);
    } else {
      var_3 = self._id_4C8C[var_0];
      var_4 = var_0 + "_add";

      if(isDefined(self._id_4C8C[var_4])) {
        var_2 = self._id_4C8C[var_4];
      }
    }
  } else if(isDefined(anim._id_DD76) && (var_0 == "stand" || var_0 == "stand_cqb") && isDefined(self._id_32D4) && self._id_32D4 == 1)
    var_3 = scripts\anim\utility::_id_1E9D(anim._id_DD76["stand"][0], anim._id_DD77["stand"][0]);
  else {
    var_5 = scripts\anim\utility::_id_B028("idle");
    var_6 = scripts\anim\utility::_id_B028("idle_weights");
    var_1 = var_1 % var_5[var_0].size;
    var_3 = scripts\anim\utility::_id_1E9D(var_5[var_0][var_1], var_6[var_0][var_1]);
  }

  var_7 = 0.2;

  if(gettime() == self.a._id_EF87) {
    var_7 = 0.5;
  }

  if(isDefined(var_2)) {
    self _meth_82A5(var_3, %body, 1, var_7, 1);
    self _meth_82A2(%add_idle);
    self _meth_82E4("idle", var_2, %add_idle, 1, var_7, self.animplaybackrate);
  } else
    self _meth_82E4("idle", var_3, %body, 1, var_7, self.animplaybackrate);

  scripts\anim\shared::donotetracks("idle");
}

_id_DA85() {
  if(self.a.pose != "prone") {
    return;
  }
  thread _id_12EF5();

  if(randomint(10) < 3) {
    var_0 = scripts\anim\utility::_id_B027("cover_prone", "twitch");
    var_1 = var_0[randomint(var_0.size)];
    self _meth_82E3("prone_idle", var_1, %exposed_modern, 1, 0.2);
  } else {
    self _meth_82A5(scripts\anim\utility::_id_B027("cover_prone", "straight_level"), %exposed_modern, 1, 0.2);
    self _meth_82E2("prone_idle", scripts\anim\utility::_id_B027("cover_prone", "exposed_idle")[0], 1, 0.2);
  }

  self waittillmatch("prone_idle", "end");
  self notify("kill UpdateProneThread");
}

_id_12EF5() {
  self endon("killanimscript");
  self endon("kill UpdateProneThread");

  for(;;) {
    scripts\anim\cover_prone::_id_12EF6(0.1);
    wait 0.1;
  }
}

_id_50FE() {
  self endon("killanimscript");
  wait 0.05;
  [[self.exception["stop"]]]();
}