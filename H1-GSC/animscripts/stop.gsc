/********************************
 * Decompiled by Mjkzy
 * Edited by SyndiShanX
 * Script: animscripts\stop.gsc
********************************/

#using_animtree("generic_human");

init_animset_idle() {
  var_0 = [];
  var_0["stand"][0] = [ % casual_stand_idle, % casual_stand_idle_twitch, % casual_stand_idle_twitchb];
  var_0["stand_combat"][0] = [ % cqb_stand_idle, % cqb_stand_twitch];
  var_0["stand_cqb"][0] = [ % cqb_stand_idle, % cqb_stand_twitch];
  var_0["crouch"][0] = [ % casual_crouch_idle];
  var_0["crouch_combat"][0] = [ % exposed_crouch_aim_5];
  var_1 = [];
  var_1["crouch_combat"][0] = % exposed_crouch_idle_alert_v1;
  var_1["crouch_combat"][1] = % exposed_crouch_idle_alert_v2;
  var_1["crouch_combat"][2] = % exposed_crouch_idle_alert_v3;
  anim.archetypes["soldier"]["idle"] = var_0;
  anim.archetypes["soldier"]["idle_add"] = var_1;
  var_0 = [];
  var_0["stand"][0] = [2, 1, 1];
  var_0["stand"][1] = [10, 4, 7, 4];
  var_0["stand_combat"][0] = [2, 1];
  var_0["stand_cqb"][0] = [2, 1];
  var_0["crouch"][0] = [6];
  var_0["crouch_combat"][0] = [6];
  anim.archetypes["soldier"]["idle_weights"] = var_0;
  var_0 = [];
  var_0["stand"] = % casual_stand_idle_trans_in;
  var_0["crouch"] = % casual_crouch_idle_in;
  var_0["stand_smg"] = % smg_casual_stand_idle_trans_in;
  anim.archetypes["soldier"]["idle_transitions"] = var_0;
}

main() {
  if(isdefined(self.no_ai)) {
    return;
  }
  if(isdefined(self.custom_animscript)) {
    if(isdefined(self.custom_animscript["stop"])) {
      [
        [self.custom_animscript["stop"]]
      ]();
      return;
    }
  }

  self notify("stopScript");
  self endon("killanimscript");
  [[self.exception["stop_immediate"]]]();
  thread delayedexception();
  animscripts\utility::initialize("stop");

  if(isdefined(self.specialidleanim))
    specialidleloop();

  animscripts\utility::randomizeidleset();
  thread setlaststoppedtime();
  thread animscripts\reactions::reactionscheckloop();
  var_0 = isdefined(self.customidleanimset);

  if(!var_0) {
    if(self.a.weaponpos["right"] == "none" && self.a.weaponpos["left"] == "none")
      var_0 = 1;
    else if(angleclamp180(self getmuzzleangle()[0]) > 20)
      var_0 = 1;
  }

  if(self.swimmer && !isdefined(self.enemy)) {
    var_1 = animscripts\exit_node::getexitnode();

    if(isdefined(var_1)) {
      self setflaggedanimknoballrestart("idle", self.customidleanimset["stand"], % body, 1, 0.5, self.animplaybackrate);
      turntoangle(var_1.angles[1]);
    } else
      self orientmode("face angle", self.angles[1]);
  }

  for (;;) {
    var_2 = getdesiredidlepose();

    if(var_2 == "prone") {
      var_0 = 1;
      pronestill();
      continue;
    }

    if(self.a.pose != var_2) {
      self clearanim( % animscript_root, 0.3);
      var_0 = 0;
    }

    if(animscripts\setposemovement::setposemovement(var_2, "stop")) {
      continue;
    }
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

  while (angleclamp(var_0 - self.angles[1]) > var_1)
    wait 0.1;
}

setlaststoppedtime() {
  self endon("death");
  self waittill("killanimscript");
  self.laststoppedtime = gettime();
}

specialidleloop() {
  self endon("stop_specialidle");
  self.a.movement = "stop";
  var_0 = self.specialidleanim;
  self animmode("gravity");
  self orientmode("face current");
  self clearanim( % animscript_root, 0.2);

  if(var_0.size == 0) {
    return;
  }
  var_1 = [];
  var_2 = var_0[0];

  for (;;) {
    if(var_1.size == 0)
      var_1 = common_scripts\utility::array_randomize(var_0);

    if(var_1[0] == var_2 && var_1.size > 1)
      var_2 = var_1[1];
    else
      var_2 = var_1[0];

    var_1 = common_scripts\utility::array_remove(var_1, var_2);
    self setflaggedanimrestart("special_idle", var_2, 1, 0.2, self.animplaybackrate);
    childthread animscripts\shared::donotetracks("special_idle");
    self waittillmatch("special_idle", "end");

    if(var_0.size > 1)
      self clearanim(var_2, 0.2);
  }
}

getdesiredidlepose() {
  var_0 = animscripts\utility::getclaimednode();

  if(isdefined(var_0)) {
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
  var_2 = self getisforcedincombat();

  if(isdefined(self.node)) {
    if(self.node doesnodeforcecombat())
      var_2 = 1;

    if(self.node doesnodeforceidle())
      var_2 = 0;
  }

  if(animscripts\utility::iscqbwalking() && self.a.pose == "stand" && (animscripts\utility::isincombat() || var_2))
    var_0 = "stand_cqb";
  else if(animscripts\utility::usingsmg() && self.a.pose == "stand")
    var_0 = "stand_smg";
  else if(self.a.pose == "stand" && var_2)
    var_0 = "stand_combat";
  else if(self.a.pose == "crouch" && var_2)
    var_0 = "crouch_combat";

  var_3 = animscripts\utility::lookupanimarray("idle_transitions");

  if(isdefined(var_3[var_0])) {
    var_4 = var_3[var_0];
    self setflaggedanimknoballrestart("idle_transition", var_4, % body, 1, 0.2, self.animplaybackrate);
    animscripts\shared::donotetracks("idle_transition");
  }
}

playidle(var_0, var_1) {
  var_2 = self getisforcedincombat();

  if(isdefined(self.node)) {
    if(self.node doesnodeforcecombat())
      var_2 = 1;

    if(self.node doesnodeforceidle())
      var_2 = 0;
  }

  if(animscripts\utility::iscqbwalking() && self.a.pose == "stand" && (animscripts\utility::isincombat() || var_2))
    var_0 = "stand_cqb";
  else if(self.a.pose == "stand" && var_2)
    var_0 = "stand_combat";
  else if(self.a.pose == "crouch" && var_2)
    var_0 = "crouch_combat";

  var_3 = undefined;

  if(isdefined(self.customidleanimset) && isdefined(self.customidleanimset[var_0])) {
    if(isarray(self.customidleanimset[var_0]))
      var_4 = animscripts\utility::anim_array(self.customidleanimset[var_0], self.customidleanimweights[var_0]);
    else {
      var_4 = self.customidleanimset[var_0];
      var_5 = var_0 + "_add";

      if(isdefined(self.customidleanimset[var_5]))
        var_3 = self.customidleanimset[var_5];
    }
  } else if(isdefined(anim.readyanimarray) && (var_0 == "stand" || var_0 == "stand_cqb") && isdefined(self.busereadyidle) && self.busereadyidle == 1)
    var_4 = animscripts\utility::anim_array(anim.readyanimarray["stand"][0], anim.readyanimweights["stand"][0]);
  else {
    var_6 = animscripts\utility::lookupanimarray("idle");
    var_7 = animscripts\utility::lookupanimarray("idle_weights");
    var_1 = var_1 % var_6[var_0].size;
    var_4 = animscripts\utility::anim_array(var_6[var_0][var_1], var_7[var_0][var_1]);
    var_8 = animscripts\utility::lookupanimarray("idle_add");

    if(isdefined(var_8[var_0])) {
      var_9 = var_8[var_0].size * 6;
      var_10 = randomint(var_9);

      if(var_10 < var_8[var_0].size)
        var_3 = var_8[var_0][var_10];
    }
  }

  var_11 = 0.2;

  if(gettime() == self.a.scriptstarttime)
    var_11 = 0.5;

  if(isdefined(var_3)) {
    self setanimknoball(var_4, % body, 1, var_11, 1);
    self setanim( % add_idle);
    self setflaggedanimknoballrestart("idle", var_3, % add_idle, 1, var_11, self.animplaybackrate);
  } else
    self setflaggedanimknoballrestart("idle", var_4, % body, 1, var_11, self.animplaybackrate);

  animscripts\shared::donotetracks("idle");
}

pronestill() {
  var_0 = [];
  var_1 = undefined;
  var_2 = undefined;

  if(self.a.pose != "prone") {
    var_0["stand_2_prone"] = % stand_2_prone;
    var_0["crouch_2_prone"] = % crouch_2_prone;
    var_1 = var_0[self.a.pose + "_2_prone"];
  } else if(self.a.movement != "stop") {
    if(self.prevscript == "move" && isdefined(self.movetransitionanimation) && isdefined(self.movetransitionendpose) && self.movetransitionendpose == "prone") {
      var_3 = getanimlength(self.movetransitionanimation) * (1 - self getanimtime(self.movetransitionanimation));

      if(var_3 > 0.05) {
        var_2 = self getanimtime(self.movetransitionanimation);
        var_1 = self.movetransitionanimation;
      }
    } else
      var_1 = % h1_crawl_2_prone;
  }

  if(isdefined(var_1)) {
    self setflaggedanimknoballrestart("trans", var_1, % body, 1, 0.2, 1.0);

    if(isdefined(var_2))
      self setanimtime(var_1, var_2);

    animscripts\shared::donotetracks("trans");
    self.a.movement = "stop";
    self setproneanimnodes(-45, 45, % prone_legs_down, % exposed_modern, % prone_legs_up);
    return;
  }

  thread updatepronethread();

  if(randomint(10) < 3) {
    var_4 = animscripts\utility::lookupanim("cover_prone", "twitch");
    var_5 = var_4[randomint(var_4.size)];
    self setflaggedanimknoball("prone_idle", var_5, % exposed_modern, 1, 0.2);
  } else {
    self setanimknoball(animscripts\utility::lookupanim("cover_prone", "straight_level"), % exposed_modern, 1, 0.2);
    self setflaggedanimknob("prone_idle", animscripts\utility::lookupanim("cover_prone", "exposed_idle")[0], 1, 0.2);
  }

  self waittillmatch("prone_idle", "end");
  self notify("kill UpdateProneThread");
}

updatepronethread() {
  self endon("killanimscript");
  self endon("kill UpdateProneThread");

  for (;;) {
    animscripts\cover_prone::updatepronewrapper(0.1);
    wait 0.1;
  }
}

delayedexception() {
  self endon("killanimscript");
  wait 0.05;
  [[self.exception["stop"]]]();
}