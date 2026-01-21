/****************************************
 * Decompiled and Edited by SyndiShanX
 * Script: animscripts\dog\dog_stop.gsc
****************************************/

#using_animtree("dog");

main() {
  if(isDefined(level.shark_functions)) {
    if(issubstr(self.model, "shark")) {
      self[[level.shark_functions["stop"]]]();
      return;
    }
  }

  self endon("killanimscript");
  self clearanim(%body, 0.2);
  self setanim(%dog_idle_knob);
  thread waitforstatechange();
  self.dognextidletwitchtime = getdognexttwitchtime();
  self.moveanimtype = "walk";
  self.idleanimtype = undefined;

  for(;;) {
    if(self isdogbeingdriven()) {
      dodrivenidle();
      continue;
    }

    if(isDefined(self.specialidleanim)) {
      dospecialidle();
      continue;
    }

    var_0 = dogstop_getnode();

    if(!self isdogbeingdriven() && (!isDefined(self.bidlelooking) || !self.bidlelooking)) {
      var_1 = 262144;
      var_2 = self.doghandler;

      if(isDefined(var_2)) {
        if(isDefined(var_2.node) && isDefined(var_0)) {
          var_3 = var_2.origin - self.origin;
          turntoangle(vectortoyaw(var_3));
        } else {
          var_4 = 65536;
          var_5 = 6400;
          var_6 = distancesquared(self.origin, var_2.origin);

          if(var_6 < var_5)
            turntoangle(var_2.angles[1]);
          else if(var_6 < var_4) {
            var_3 = var_2.origin - self.origin;
            var_7 = vectortoyaw(var_3);
            turntoangle(var_7);
          }
        }
      } else if((!isDefined(var_0) || !issubstr(var_0.type, "Cover") || isDefined(self.favoriteenemy)) && isDefined(self.enemy) && isalive(self.enemy) && (self seerecently(self.enemy, 5) || distancesquared(self.origin, self.enemy.origin) < var_1)) {
        var_8 = self.enemy.origin - self.origin;
        turntoangle(vectortoyaw(var_8));
      } else if(isDefined(var_0) && shouldfacenodedir(var_0))
        turntoangle(var_0.angles[1]);

      self orientmode("face angle", self.angles[1]);
    }

    if(isDefined(self.customidleanimset)) {
      stoplookatidle();
      docustomidle();
      continue;
    }

    var_9 = getdefaultidlestate();

    if(var_9 == "casualidle") {
      if(isDefined(self.idlelookattargets))
        dolookatidle();
      else {
        stoplookatidle();
        playidleanim("casualidle", getdogstopanim("casualidle"), 0, 0.5, 2);
      }
    } else if(var_9 == "attackidle") {
      if(isDefined(self.idlelookattargets) && isDefined(self.aggresivelookat))
        dolookatidle();
      else {
        stopidlesound();
        stoplookatidle();
        var_10 = !isDefined(self.enemy) || distance2dsquared(self.origin, self.enemy.origin) > 589824;

        if(var_10 && gettime() > self.dognextidletwitchtime) {
          var_11 = chooseattackidle();
          playidleanim("attackidle", getdogstopanim(var_11), 0, 0.2, -1);
          self.dognextidletwitchtime = getdognexttwitchtime();
        } else
          playidleanim("attackidle", getdogstopanim("attackidle"), 0, 0.5, 0.5);
      }
    } else {
      stopidlesound();
      stoplookatidle();
      playidleanim(var_9, getdogstopanim(var_9), 0, 0.5, 2);
    }
  }
}

end_script() {
  if(isDefined(self.prevturnrate)) {
    self.turnrate = self.prevturnrate;
    self.prevturnrate = undefined;
  }

  self.dogturnadjust = undefined;
  self.dogturnrate = undefined;
  self.dognextidletwitchtime = undefined;
  self.currenttrackingyawspeed = undefined;
  self.currenttrackingyaw = undefined;
  stopidlesound();
  stoplookatidle();
}

playidleanim(var_0, var_1, var_2, var_3, var_4) {
  self endon("killIdleAnim");

  if(isDefined(self.idleanimtype) && self.idleanimtype != var_0) {
    var_5 = getdogstoptransitionanim(self.idleanimtype, var_0);

    if(isDefined(var_5)) {
      self setflaggedanimknobrestart("dog_idle_transition", var_5, 1, 0.2, self.animplaybackrate);
      animscripts\shared::donotetracks("dog_idle_transition");
      var_3 = 0.2;
    }
  }

  self.idleanimtype = var_0;

  if(var_2)
    self setflaggedanimknobrestart("dog_idle", var_1, 1, var_3, self.animplaybackrate);
  else
    self setflaggedanimknob("dog_idle", var_1, 1, var_3, self.animplaybackrate);

  if(var_4 > 0)
    animscripts\notetracks::donotetracksfortime(var_4, "dog_idle");
  else
    animscripts\shared::donotetracks("dog_idle");
}

waitforstatechange() {
  self endon("killanimscript");
  var_0 = self isdogbeingdriven();
  var_1 = self.defaultidlestateoverride;

  for(;;) {
    var_2 = self isdogbeingdriven();

    if(var_2 != var_0) {
      killidleanim();
      var_0 = var_2;
      self orientmode("face angle", self.angles[1]);
    } else if(animscripts\dog\dog_move::aredifferent(self.defaultidlestateoverride, var_1)) {
      killidleanim();
      var_1 = self.defaultidlestateoverride;
    }

    wait 0.1;
  }
}

killidleanim() {
  self notify("killIdleAnim");
  stoplookatidle();
}

shouldfacenodedir(var_0) {
  return var_0.type == "Guard" || var_0.type == "Exposed" || issubstr(var_0.type, "Cover ");
}

getturnanim(var_0) {
  var_1 = getdefaultidlestate();

  if(var_1 == "casualidle" || var_1 == "sniffidle") {
    if(var_0 < -135 || var_0 > 135)
      return getdogstopanim("casual_turn_180");
    else if(var_0 < 0)
      return getdogstopanim("casual_turn_right");
    else
      return getdogstopanim("casual_turn_left");
  } else if(var_0 < -135 || var_0 > 135)
    return getdogstopanim("attack_turn_180");
  else if(var_0 < 0)
    return getdogstopanim("attack_turn_right");
  else
    return getdogstopanim("attack_turn_left");
}

handledogturnnotetracks(var_0) {
  if(var_0 == "turn_begin") {
    var_1 = angleclamp180(self.angles[1] + self.dogturnadjust);
    self.dogturnadjust = undefined;
    self.prevturnrate = self.turnrate;
    self.turnrate = self.dogturnrate;
    self.dogturnrate = undefined;
    self orientmode("face angle", var_1);
  } else if(var_0 == "turn_end") {
    self.turnrate = self.prevturnrate;
    self.prevturnrate = undefined;
  }
}

turntoangle(var_0, var_1) {
  self endon("killIdleAnim");
  var_2 = self.angles[1];
  var_3 = angleclamp180(var_0 - var_2);

  if(-0.5 < var_3 && var_3 < 0.5) {
    return;
  }
  if(-15 < var_3 && var_3 < 15) {
    rotatetoangle(var_0, 2);
    return;
  }

  stopidlesound();
  var_4 = getturnanim(var_3);
  var_5 = getanimlength(var_4);
  var_6 = getangledelta(var_4);
  var_7 = 0.2;

  if(var_5 < 0.7)
    var_7 = 0.05;

  if(isDefined(var_1) && var_1)
    self animmode("zonly_physics");
  else
    self animmode("angle deltas");

  self setanim(%dog_idle_knob, 1, var_7);
  self setflaggedanimknobrestart("dog_turn", var_4, 1, var_7);

  if(animhasnotetrack(var_4, "turn_begin") && animhasnotetrack(var_4, "turn_end")) {
    var_8 = getnotetracktimes(var_4, "turn_begin");
    var_9 = getnotetracktimes(var_4, "turn_end");
    var_10 = (var_9[0] - var_8[0]) * var_5;
    self.dogturnadjust = angleclamp180(var_3 - var_6);
    self.dogturnrate = max(abs(self.dogturnadjust) / var_10 / 1000, 0.01);
    self orientmode("face angle", self.angles[1]);
    animscripts\shared::donotetracks("dog_turn", ::handledogturnnotetracks);
  } else {
    self.prevturnrate = self.turnrate;
    self.turnrate = max(abs(angleclamp180(var_3 - var_6)) / var_5 / 1000, 0.01);
    self orientmode("face angle", angleclamp180(var_0 - var_6));
    animscripts\shared::donotetracks("dog_turn");
    self.turnrate = self.prevturnrate;
    self.prevturnrate = undefined;
  }

  self clearanim(var_4, 0.2);
  self animmode("none");
}

rotatetoangle(var_0, var_1) {
  self orientmode("face angle", var_0);

  while(abs(angleclamp180(var_0 - self.angles[1])) > var_1)
    wait 0.1;
}

shouldcoveridle() {
  var_0 = dogstop_getnode();

  if(isDefined(var_0) && issubstr(var_0.type, "Cover"))
    return 1;

  return 0;
}

chooseattackidle() {
  var_0 = ["attackidle_twitch_1", "attackidle_twitch_2"];
  var_1 = [1, 1];

  if(!isDefined(self.script_nobark) || !self.script_nobark) {
    var_2 = var_0.size;
    var_0[var_2] = "attackidle_bark";
    var_1[var_2] = 4;
  }

  var_3 = 0;

  for(var_2 = 0; var_2 < var_1.size; var_2++)
    var_3 = var_3 + var_1[var_2];

  var_4 = randomint(var_3);
  var_5 = 0;

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    var_5 = var_5 + var_1[var_2];

    if(var_4 < var_5)
      return var_0[var_2];
  }
}

dodrivenidle() {
  playidlesound(self.customidlesound);
  playidleanim("sneakstandidle", getdogstopanim("sneakstandidle"), 0, 0.5, -1);
}

dospecialidle() {
  if(isarray(self.specialidleanim))
    var_0 = self.specialidleanim[randomint(self.specialidleanim.size)];
  else
    var_0 = self.specialidleanim;

  playidlesound(self.customidlesound);
  playidleanim("specialidle", var_0, 0, 0.5, -1);
}

docustomidle() {
  if(isarray(self.customidleanimset)) {
    if(isDefined(self.customidleanimweights))
      var_0 = animscripts\utility::anim_array(self.customidleanimset, self.customidleanimweights);
    else
      var_0 = self.customidleanimset[randomint(self.customidleanimset.size)];
  } else
    var_0 = self.customidleanimset;

  playidlesound(self.customidlesound);
  playidleanim("customidle", var_0, 0, 0.5, -1);
}

dolookatidle() {
  if(!isDefined(self.bidlelooking) || !self.bidlelooking) {
    self.bidlelooking = 1;
    thread lookatidleupdate();
  }

  wait 0.5;
}

stoplookatidle() {
  if(!isDefined(self.bidlelooking) || !self.bidlelooking) {
    return;
  }
  self.bidlelooking = undefined;
  self.idletrackloop = undefined;
  self notify("endIdleLookAt");
  self clearanim(%look_2, 1);
  self clearanim(%look_4, 1);
  self clearanim(%look_6, 1);
  self clearanim(%look_8, 1);
}

lookatidleupdate() {
  self endon("killanimscript");
  self endon("endIdleLookAt");

  while(isDefined(self.idlelookattargets) && isarray(self.idlelookattargets) && self.idlelookattargets.size > 0) {
    var_0 = getlookattarget(self.lookattarget);
    self.lookattarget = var_0;

    if(!isDefined(self.idletrackloop))
      thread idletrackloop();

    var_1 = 3 + randomfloat(3);
    wait(var_1);
  }

  stoplookatidle();
}

getlookattarget(var_0) {
  if(isDefined(self.alwayslookatfirsttarget) && self.alwayslookatfirsttarget && self.idlelookattargets.size > 0)
    return self.idlelookattargets[0];

  var_1 = isDefined(var_0);

  if(self.idlelookattargets.size == 1) {
    if(var_1)
      return undefined;
    else
      return self.idlelookattargets[0];
  }

  if(var_1) {
    var_2 = randomint(100);

    if(var_2 < 33)
      return undefined;
  }

  var_3 = self.idlelookattargets;
  var_4 = [];
  var_5 = 0;
  var_6 = !var_1;

  for(var_7 = 0; var_7 < var_3.size; var_7++) {
    if(!var_6 && var_3[var_7] == var_0) {
      var_8 = var_3.size - 1;

      if(var_7 != var_8)
        var_3[var_7] = var_3[var_8];

      var_3[var_8] = undefined;
      var_6 = 1;

      if(var_7 == var_8) {
        break;
      }
    }

    var_9 = distance2dsquared(self.origin, var_3[var_7].origin);
    var_4[var_7] = 1 / var_9;
    var_5 = var_5 + var_4[var_7];
  }

  var_10 = randomfloat(var_5);
  var_11 = 0;

  for(var_7 = 0; var_7 < var_3.size; var_7++) {
    var_11 = var_11 + var_4[var_7];

    if(var_10 < var_11)
      return var_3[var_7];
  }
}

idletrackloop() {
  self endon("killanimscript");
  self endon("endIdleLookAt");
  self.idletrackloop = 1;
  self clearanim(%dog_idle_knob, 0.2);
  self setanimknob(getdogstopanimbase(), 1, 0.5);
  self setanimknoblimited(getdogstopanimlook("2"), 1, 0);
  self setanimknoblimited(getdogstopanimlook("4"), 1, 0);
  self setanimknoblimited(getdogstopanimlook("6"), 1, 0);
  self setanimknoblimited(getdogstopanimlook("8"), 1, 0);
  var_0 = 90;
  var_1 = -100;
  var_2 = -25;
  var_3 = 25;
  self.currenttrackingyaw = 0;
  self.currenttrackingyawspeed = 0;

  for(;;) {
    var_4 = self getEye();

    if(isDefined(self.lookattarget)) {
      var_5 = self.lookattarget getEye();
      var_6 = var_5 - var_4;
      var_7 = vectortoangles(var_6);
    } else
      var_7 = self.angles;

    var_8 = angleclamp180(var_7[1] - self.angles[1]);
    var_9 = angleclamp180(var_7[0] - self.angles[0]);

    if(var_8 > var_0 || var_8 < var_1) {
      self.currenttrackingyaw = 0;
      self.currenttrackingyawspeed = 0;
      turntoangle(self.angles[1] + var_8 * 0.75);
      self setanimknob(getdogstopanimbase(), 1, 0.1);
      continue;
    }

    var_10 = calctrackingyaw(var_8, self.currenttrackingyaw, self.currenttrackingyawspeed);
    self.currenttrackingyaw = var_10;
    var_11 = 0;
    var_12 = 0;
    var_13 = 0;
    var_14 = 0;

    if(var_10 > 0)
      var_11 = clamp(var_10 / var_0, 0, 1);
    else
      var_12 = clamp(var_10 / var_1, 0, 1);

    if(var_9 < 0)
      var_13 = clamp(var_9 / var_2, 0, 1);
    else
      var_14 = clamp(var_9 / var_3, 0, 1);

    self setanimlimited(%look_2, var_14, 1);
    self setanimlimited(%look_4, var_11, 0.1);
    self setanimlimited(%look_6, var_12, 0.1);
    self setanimlimited(%look_8, var_13, 1);
    wait 0.05;
  }
}

calctrackingyaw(var_0, var_1, var_2) {
  var_3 = 90;
  var_4 = -100;
  var_5 = 1;
  var_6 = 0.5;
  var_7 = 6;
  var_8 = clamp(var_0, var_4, var_3);
  var_9 = angleclamp180(var_8 - var_1);

  if(var_8 > var_1) {
    if(var_2 >= 0 && !needtodecelforarrival(var_9, var_2, var_6))
      var_10 = var_2 + var_5;
    else if(var_2 >= 0)
      var_10 = var_2 - var_6;
    else
      var_10 = var_2 + var_6;
  } else if(var_2 <= 0 && !needtodecelforarrival(var_9, var_2, var_6))
    var_10 = var_2 - var_5;
  else if(var_2 <= 0)
    var_10 = var_2 + var_6;
  else
    var_10 = var_2 - var_6;

  var_10 = clamp(var_10, -1 * var_7, var_7);

  if(var_8 >= var_1 && var_1 + var_10 > var_8)
    var_10 = var_8 - var_1;
  else if(var_8 <= var_1 && var_1 + var_10 < var_8)
    var_10 = var_8 - var_1;

  var_11 = var_1 + var_10;
  self.currenttrackingyawspeed = var_10;
  return var_11;
}

needtodecelforarrival(var_0, var_1, var_2) {
  if(var_1 == 0)
    return 0;

  var_3 = abs(var_0);
  var_4 = abs(var_1);
  var_2 = abs(var_2);

  while(var_3 > 0) {
    var_3 = var_3 - var_4;
    var_4 = var_4 - var_2;

    if(var_4 < 0)
      return 0;
  }

  return 1;
}

dogstop_getnode() {
  if(isDefined(self.node))
    return self.node;

  return self.prevnode;
}

getdefaultidlestate(var_0) {
  if(isDefined(self.defaultidlestateoverride))
    return self.defaultidlestateoverride;

  var_1 = isDefined(self.enemy) && isalive(self.enemy);
  var_2 = var_1 && distancesquared(self.origin, self.enemy.origin) < 1000000 && (isDefined(self.favoriteenemy) || self seerecently(self.enemy, 5));
  var_3 = dogstop_getnode();

  if(isDefined(self.aggresivelookat))
    return "attackidle";

  if(!isDefined(var_0))
    var_0 = 1;

  if(isDefined(var_3) && (!var_0 || distance(self.origin, var_3.origin) <= 32)) {
    if(var_3.type == "Guard") {
      if(var_2)
        return "attackidle";
      else
        return "alertidle";
    } else if(issubstr(var_3.type, "Cover"))
      return "sneakidle";
    else if(var_1) {
      if(var_2)
        return "attackidle";
      else
        return "alertidle";
    }
  }

  if(var_2)
    return "attackidle";

  if(animscripts\dog\dog_move::shouldsniff())
    return "sniffidle";

  return "casualidle";
}

should_growl() {
  if(isDefined(self.script_growl))
    return 1;

  if(!isDefined(self.enemy))
    return 0;

  if(!isalive(self.enemy))
    return 1;

  return !self cansee(self.enemy);
}

lookattarget(var_0) {
  self endon("killanimscript");
  self endon("stop tracking");
  self clearanim(%german_shepherd_look_2, 0);
  self clearanim(%german_shepherd_look_4, 0);
  self clearanim(%german_shepherd_look_6, 0);
  self clearanim(%german_shepherd_look_8, 0);
  self setdefaultaimlimits();
  self.rightaimlimit = 90;
  self.leftaimlimit = -90;
  self setanimlimited(anim.doglookpose[var_0][2], 1, 0);
  self setanimlimited(anim.doglookpose[var_0][4], 1, 0);
  self setanimlimited(anim.doglookpose[var_0][6], 1, 0);
  self setanimlimited(anim.doglookpose[var_0][8], 1, 0);
  animscripts\track::setanimaimweight(1, 0.2);
  animscripts\track::trackloop(%german_shepherd_look_2, %german_shepherd_look_4, %german_shepherd_look_6, %german_shepherd_look_8);
}

playidlesound(var_0) {
  if(!animscripts\dog\dog_move::aredifferent(self.idlesound, var_0)) {
    return;
  }
  stopidlesound();

  if(isDefined(var_0))
    thread loopidlesound(var_0);
}

loopidlesound(var_0) {
  self endon("killanimscript");
  var_1 = spawn("script_origin", self.origin);
  var_1.angles = self.angles;
  var_1 linkto(self);
  self.idlesoundorigin = var_1;
  self.idlesound = var_0;

  for(;;) {
    var_1 playSound(var_0, "dog_idle_sound");
    var_2 = idlesound_waitfordoneordeath(var_1, "dog_idle_sound");

    if(!isDefined(var_2)) {
      break;
    }
  }
}

idlesound_waitfordoneordeath(var_0, var_1) {
  self endon("death");
  var_0 endon("death");
  var_0 waittill(var_1);
  return 1;
}

stopidlesound() {
  if(isDefined(self.idlesoundorigin)) {
    if(self.idlesoundorigin iswaitingonsound()) {
      self.idlesoundorigin stopsounds();
      wait 0.05;
    }

    self.idlesoundorigin delete();
    self.idlesoundorigin = undefined;
    self.idlesound = undefined;
  }
}

getdognexttwitchtime() {
  if(isDefined(self.script_nobark) && self.script_nobark)
    return gettime() + 4000 + randomint(3000);

  return gettime() + 1000 + randomint(1000);
}

getdogstopanimbase() {
  if(isDefined(self.aggresivelookat))
    return getdogstopanim("attackidle_base");
  else
    return getdogstopanim("casualidle_base");
}

getdogstopanimlook(var_0) {
  if(isDefined(self.aggresivelookat))
    return getdogstopanim("attackidle_look_" + var_0);
  else
    return getdogstopanim("casualidle_look_" + var_0);
}

getdogstopanim(var_0) {
  var_1 = animscripts\utility::lookupdoganim("stop", var_0);
  return var_1;
}

getdogstoptransitionanim(var_0, var_1) {
  var_2 = animscripts\utility::lookupdoganim("stop", "transition");

  if(isDefined(var_2[var_0]) && isDefined(var_2[var_0][var_1]))
    return var_2[var_0][var_1];

  return undefined;
}

initdogarchetype_stop() {
  var_0 = [];
  var_0["attackidle"] = % iw6_dog_attackidle;
  var_0["attack_turn_left"] = % iw6_dog_attackidle_turn_4;
  var_0["attack_turn_right"] = % iw6_dog_attackidle_turn_6;
  var_0["attack_turn_180"] = % iw6_dog_attackidle_turn_2;
  var_0["attackidle_base"] = % iw6_dog_attackidle_base;
  var_0["attackidle_look_2"] = % iw6_dog_attackidle_2;
  var_0["attackidle_look_4"] = % iw6_dog_attackidle_4;
  var_0["attackidle_look_6"] = % iw6_dog_attackidle_6;
  var_0["attackidle_look_8"] = % iw6_dog_attackidle_8;
  var_0["alertidle"] = % iw6_dog_alertidle;
  var_0["attackidle_bark"] = % iw6_dog_attackidle_bark;
  var_0["attackidle_twitch_1"] = % iw6_dog_attackidle_twitch_1;
  var_0["attackidle_twitch_2"] = % iw6_dog_attackidle_twitch_2;
  var_0["casualidle"] = % iw6_dog_casualidle;
  var_0["casual_turn_left"] = % iw6_dog_casualidle_turn_4;
  var_0["casual_turn_right"] = % iw6_dog_casualidle_turn_6;
  var_0["casual_turn_180"] = % iw6_dog_casualidle_turn_2;
  var_0["casualidle_base"] = % iw6_dog_casualidle_base;
  var_0["casualidle_look_2"] = % iw6_dog_casualidle_2;
  var_0["casualidle_look_4"] = % iw6_dog_casualidle_4;
  var_0["casualidle_look_6"] = % iw6_dog_casualidle_6;
  var_0["casualidle_look_8"] = % iw6_dog_casualidle_8;
  var_0["sneakstandidle"] = % iw6_dog_sneak_stand_idle;
  var_0["sneakidle"] = % iw6_dog_sneakidle;
  var_0["sniffidle"] = % iw6_dog_sniff_idle;
  var_0["transition"] = [];
  var_0["transition"]["casualidle"] = [];
  var_0["transition"]["casualidle"]["sneakidle"] = % iw6_dog_idle_2_sneak_idle;
  var_0["transition"]["casualidle"]["alertidle"] = % iw6_dog_idle_2_alert_idle;
  var_0["transition"]["casualidle"]["attackidle"] = % iw6_dog_idle_2_alert_idle;
  var_0["transition"]["alertidle"] = [];
  var_0["transition"]["alertidle"]["casualidle"] = % iw6_dog_alert_2_casual_idle;
  var_0["transition"]["alertidle"]["sneakidle"] = % iw6_dog_idle_2_sneak_idle;
  var_0["transition"]["attackidle"] = [];
  var_0["transition"]["attackidle"]["casualidle"] = % iw6_dog_alert_2_casual_idle;
  var_0["transition"]["attackidle"]["sneakidle"] = % iw6_dog_idle_2_sneak_idle;
  var_0["transition"]["sneakidle"] = [];
  var_0["transition"]["sneakidle"]["casualidle"] = % iw6_dog_sneak_2_casual_idle;
  var_0["transition"]["sneakidle"]["alertidle"] = % iw6_dog_sneak_2_casual_idle;
  var_0["transition"]["sneakidle"]["attackidle"] = % iw6_dog_sneak_2_casual_idle;
  anim.archetypes["dog"]["stop"] = var_0;
}