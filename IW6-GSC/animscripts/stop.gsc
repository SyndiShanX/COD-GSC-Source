/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\stop.gsc
*****************************************************/

#using_animtree("generic_human");

init_animset_idle() {
  var_0 = [];
  var_0["stand"][0] = [ % casual_stand_idle, %casual_stand_idle_twitch, %casual_stand_idle_twitchb];
  var_0["stand"][1] = [ % casual_stand_v2_idle, %casual_stand_v2_twitch_radio, %casual_stand_v2_twitch_shift, %casual_stand_v2_twitch_talk];
  var_0["stand_cqb"][0] = [ % cqb_stand_idle, %cqb_stand_twitch];
  var_0["crouch"][0] = [ % casual_crouch_idle];
  anim.archetypes["soldier"]["idle"] = var_0;
  var_0 = [];
  var_0["stand"][0] = [2, 1, 1];
  var_0["stand"][1] = [10, 4, 7, 4];
  var_0["stand_cqb"][0] = [2, 1];
  var_0["crouch"][0] = [6];
  anim.archetypes["soldier"]["idle_weights"] = var_0;
  var_0 = [];
  var_0["stand"] = % casual_stand_idle_trans_in;
  var_0["crouch"] = % casual_crouch_idle_in;
  anim.archetypes["soldier"]["idle_transitions"] = var_0;
}

main() {
  if(isDefined(self.no_ai)) {
    return;
  }
  if(isDefined(self.custom_animscript)) {
    if(isDefined(self.custom_animscript["stop"])) {
      [[self.custom_animscript["stop"]]]();
      return;
    }
  }

  self notify("stopScript");
  self endon("killanimscript");
  [[self.exception["stop_immediate"]]]();
  thread delayedexception();
  animscripts\utility::initialize("stop");

  if(isDefined(self.specialidleanim))
    specialidleloop();

  animscripts\utility::randomizeidleset();
  thread setlaststoppedtime();
  thread animscripts\reactions::reactionscheckloop();
  var_0 = isDefined(self.customidleanimset);

  if(!var_0) {
    if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none")
      var_0 = 1;
    else if(angleclamp180(self getmuzzleangle()[0]) > 20)
      var_0 = 1;
  }

  if(self.swimmer && !isDefined(self.enemy)) {
    var_1 = animscripts\exit_node::getexitnode();

    if(isDefined(var_1)) {
      self setflaggedanimknoballrestart("idle", self.customidleanimset["stand"], %body, 1, 0.5, self.animplaybackrate);
      turntoangle(var_1.angles[1]);
    } else
      self orientmode("face angle", self.angles[1]);
  }

  for(;;) {
    var_2 = getdesiredidlepose();

    if(var_2 == "prone") {
      var_0 = 1;
      pronestill();
      continue;
    }

    if(self.a.pose != var_2) {
      self clearanim(%root, 0.3);
      var_0 = 0;
    }

    animscripts\setposemovement::setposemovement(var_2, "stop");

    if(!var_0) {
      transitiontoidle(var_2, self.a.idleset);
      var_0 = 1;
      continue;
    }

    playidle(var_2, self.a.idleset);
  }
}

turntoangle(var_0) {
  var_1 = self.angles[1];
  var_2 = angleclamp180(var_0 - var_1);

  if(-20 < var_2 && var_2 < 20) {
    rotatetoangle(var_0, 2);
    return;
  }

  var_3 = animscripts\swim::getswimanim("idle_turn");

  if(var_2 < -80)
    var_4 = var_3[2];
  else if(var_2 < -20)
    var_4 = var_3[3];
  else if(var_2 < 80)
    var_4 = var_3[5];
  else
    var_4 = var_3[6];

  var_5 = getanimlength(var_4);
  var_6 = abs(var_2) / self.turnrate;
  var_6 = var_6 / 1000;
  var_7 = var_5 / var_6;
  self orientmode("face angle", var_0);
  self setflaggedanimrestart("swim_turn", var_4, 1, 0.2, var_7 * self.moveplaybackrate);
  animscripts\shared::donotetracks("swim_turn");
  self clearanim(var_4, 0.2);
}

rotatetoangle(var_0, var_1) {
  self orientmode("face angle", var_0);

  while(angleclamp(var_0 - self.angles[1]) > var_1)
    wait 0.1;
}

setlaststoppedtime() {
  self endon("death");
  self waittill("killanimscript");
  self.laststoppedtime = gettime();
}

specialidleloop() {
  self endon("stop_specialidle");
  var_0 = self.specialidleanim;
  self animmode("gravity");
  self orientmode("face current");
  self clearanim(%root, 0.2);

  for(;;) {
    self setflaggedanimrestart("special_idle", var_0[randomint(var_0.size)], 1, 0.2, self.animplaybackrate);
    self waittillmatch("special_idle", "end");
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

  if(var_2 == "Cover Stand" || var_2 == "Conceal Stand")
    var_3 = animscripts\utility::choosepose("stand");
  else if(var_2 == "Cover Crouch" || var_2 == "Conceal Crouch")
    var_3 = animscripts\utility::choosepose("crouch");
  else if(var_2 == "Cover Prone" || var_2 == "Conceal Prone")
    var_3 = animscripts\utility::choosepose("prone");

  return var_3;
}

transitiontoidle(var_0, var_1) {
  if(animscripts\utility::iscqbwalking() && self.a.pose == "stand")
    var_0 = "stand_cqb";

  var_2 = animscripts\utility::lookupanimarray("idle_transitions");

  if(isDefined(var_2[var_0])) {
    var_3 = var_2[var_0];
    self setflaggedanimknoballrestart("idle_transition", var_3, %body, 1, 0.2, self.animplaybackrate);
    animscripts\shared::donotetracks("idle_transition");
  }
}

playidle(var_0, var_1) {
  if(animscripts\utility::iscqbwalking() && self.a.pose == "stand")
    var_0 = "stand_cqb";

  var_2 = undefined;

  if(isDefined(self.customidleanimset) && isDefined(self.customidleanimset[var_0])) {
    if(isarray(self.customidleanimset[var_0]))
      var_3 = animscripts\utility::anim_array(self.customidleanimset[var_0], self.customidleanimweights[var_0]);
    else {
      var_3 = self.customidleanimset[var_0];
      var_4 = var_0 + "_add";

      if(isDefined(self.customidleanimset[var_4]))
        var_2 = self.customidleanimset[var_4];
    }
  } else if(isDefined(anim.readyanimarray) && (var_0 == "stand" || var_0 == "stand_cqb") && isDefined(self.busereadyidle) && self.busereadyidle == 1)
    var_3 = animscripts\utility::anim_array(anim.readyanimarray["stand"][0], anim.readyanimweights["stand"][0]);
  else {
    var_5 = animscripts\utility::lookupanimarray("idle");
    var_6 = animscripts\utility::lookupanimarray("idle_weights");
    var_1 = var_1 % var_5[var_0].size;
    var_3 = animscripts\utility::anim_array(var_5[var_0][var_1], var_6[var_0][var_1]);
  }

  var_7 = 0.2;

  if(gettime() == self.a.scriptstarttime)
    var_7 = 0.5;

  if(isDefined(var_2)) {
    self setanimknoball(var_3, %body, 1, var_7, 1);
    self setanim(%add_idle);
    self setflaggedanimknoballrestart("idle", var_2, %add_idle, 1, var_7, self.animplaybackrate);
  } else
    self setflaggedanimknoballrestart("idle", var_3, %body, 1, var_7, self.animplaybackrate);

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
    var_2 = animscripts\utility::lookupanim("cover_prone", "twitch");
    var_3 = var_2[randomint(var_2.size)];
    self setflaggedanimknoball("prone_idle", var_3, %exposed_modern, 1, 0.2);
  } else {
    self setanimknoball(animscripts\utility::lookupanim("cover_prone", "straight_level"), %exposed_modern, 1, 0.2);
    self setflaggedanimknob("prone_idle", animscripts\utility::lookupanim("cover_prone", "exposed_idle")[0], 1, 0.2);
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
  [[self.exception["stop"]]]();
}