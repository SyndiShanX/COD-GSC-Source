/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\stop.gsc
**************************************/

#using_animtree("generic_human");

main() {
  if(isDefined(self.no_ai)) {
    return;
  }
  if(isDefined(self.onsnowmobile)) {
    animscripts\snowmobile::main();
    return;
  }

  if(isDefined(self.custom_animscript_table)) {
    if(isDefined(self.custom_animscript_table["stop"])) {
      [[self.custom_animscript_table["stop"]]]();
      return;
    }
  }

  self notify("stopScript");
  self endon("killanimscript");
  [[self.defaultexception["stop_immediate"]]]();
  thread delayedexception();
  animscripts\utility::initialize("stop");
  specialidleloop();
  animscripts\utility::randomizeidleset();
  thread setlaststoppedtime();
  thread animscripts\reactions::reactionscheckloop();
  var_0 = isDefined(self.customidleanimset);

  if(!var_0) {
    if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none") {
      var_0 = 1;
    } else if(angleclamp180(self getmuzzleangle()[0]) > 20) {
      var_0 = 1;
    }
  }

  for(;;) {
    var_1 = getdesiredidlepose();

    if(var_1 == "prone") {
      var_0 = 1;
      pronestill();
      continue;
    }

    if(self.a.pose != var_1) {
      self clearanim(%root, 0.3);
      var_0 = 0;
    }

    animscripts\setposemovement::setposemovement(var_1, "stop");

    if(!var_0) {
      transitiontoidle(var_1, self.a.idleset);
      var_0 = 1;
      continue;
    }

    playidle(var_1, self.a.idleset);
  }
}

setlaststoppedtime() {
  self endon("death");
  self waittill("killanimscript");
  self.laststoppedtime = gettime();
}

specialidleloop() {
  self endon("stop_specialidle");

  if(isDefined(self.specialidleanim)) {
    var_0 = self.specialidleanim;
    self.specialidleanim = undefined;
    self notify("clearing_specialIdleAnim");
    self animmode("gravity");
    self orientmode("face current");
    self clearanim(%root, 0.2);

    for(;;) {
      self setflaggedanimrestart("special_idle", var_0[randomint(var_0.size)], 1, 0.2, self.animplaybackrate);
      self waittillmatch("special_idle", "end");
    }
  }
}

getdesiredidlepose() {
  var_0 = animscripts\utility::getclaimednode();

  if(isDefined(var_0)) {
    var_1 = var_0.angles[1];
    var_2 = var_0.type;
  } else {
    var_1 = self.desiredangle;
    var_2 = "node was undefined";
  }

  animscripts\face::setidleface(anim.alertface);
  var_3 = animscripts\utility::choosepose();

  if(var_2 == "Cover Stand" || var_2 == "Conceal Stand") {
    var_3 = animscripts\utility::choosepose("stand");
  } else if(var_2 == "Cover Crouch" || var_2 == "Conceal Crouch") {
    var_3 = animscripts\utility::choosepose("crouch");
  } else if(var_2 == "Cover Prone" || var_2 == "Conceal Prone") {
    var_3 = animscripts\utility::choosepose("prone");
  }
  return var_3;
}

transitiontoidle(var_0, var_1) {
  if(animscripts\utility::iscqbwalking() && self.a.pose == "stand") {
    var_0 = "stand_cqb";
  }
  if(isDefined(anim.idleanimtransition[var_0])) {
    var_2 = anim.idleanimtransition[var_0]["in"];
    self setflaggedanimknoballrestart("idle_transition", var_2, %body, 1, 0.2, self.animplaybackrate);
    animscripts\shared::donotetracks("idle_transition");
  }
}

playidle(var_0, var_1) {
  if(animscripts\utility::iscqbwalking() && self.a.pose == "stand") {
    var_0 = "stand_cqb";
  }
  var_2 = undefined;

  if(isDefined(self.customidleanimset) && isDefined(self.customidleanimset[var_0])) {
    var_3 = self.customidleanimset[var_0];
    var_4 = var_0 + "_add";

    if(isDefined(self.customidleanimset[var_4])) {
      var_2 = self.customidleanimset[var_4];
    }
  } else if(isDefined(anim.readyanimarray) && (var_0 == "stand" || var_0 == "stand_cqb") && isDefined(self.busereadyidle) && self.busereadyidle == 1) {
    var_3 = animscripts\utility::anim_array(anim.readyanimarray["stand"][0], anim.readyanimweights["stand"][0]);
  } else {
    var_1 = var_1 % anim.idleanimarray[var_0].size;
    var_3 = animscripts\utility::anim_array(anim.idleanimarray[var_0][var_1], anim.idleanimweights[var_0][var_1]);
  }

  var_5 = 0.2;

  if(gettime() == self.a.scriptstarttime) {
    var_5 = 0.5;
  }
  if(isDefined(var_2)) {
    self setanimknoball(var_3, %body, 1, var_5, 1);
    self setanim(%add_idle);
    self setflaggedanimknoballrestart("idle", var_2, %add_idle, 1, var_5, self.animplaybackrate);
  } else {
    self setflaggedanimknoballrestart("idle", var_3, %body, 1, var_5, self.animplaybackrate);
  }
  animscripts\shared::donotetracks("idle");
}

pronestill() {
  if(self.a.pose != "prone") {
    var_0["stand_2_prone"] = % stand_2_prone;
    var_0["crouch_2_prone"] = % crouch_2_prone;
    var_1 = var_0[self.a.pose + "_2_prone"];
    self setflaggedanimknoballrestart("trans", var_1, %body, 1, 0.2, 1.0);
    animscripts\shared::donotetracks("trans");
    self.a.movement = "stop";
    self setproneanimnodes(-45, 45, %prone_legs_down, %exposed_modern, %prone_legs_up);
    return;
  }

  thread updatepronethread();

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

updatepronethread() {
  self endon("killanimscript");
  self endon("kill UpdateProneThread");

  for(;;) {
    animscripts\cover_prone::updatepronewrapper(0.1);
    wait 0.1;
  }
}

delayedexception() {
  self endon("killanimscript");
  wait 0.05;
  [[self.defaultexception["stop"]]]();
}