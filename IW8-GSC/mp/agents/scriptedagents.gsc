/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\agents\scriptedagents.gsc
***********************************************/

ai_init(var_0, var_1) {
  self.behaviortreeasset = var_0;
  scripts\asm\asm::asm_init_blackboard();
  scripts\aitypes\bt_util::bt_init();
  scripts\asm\asm_mp::asm_init(var_1, self.animationarchetype);

  if(self islegacyagent())
    thread scripts\asm\asm_mp::traversehandler();
}

handleglobalnotetracks(var_0, var_1, var_2) {
  if(isDefined(anim.notetracks[var_0]))
    return [[anim.notetracks[var_0]]](var_0, var_1);

  return undefined;
}

onenterstate(var_0, var_1) {
  if(isDefined(self.onenteranimstate))
    self[[self.onenteranimstate]](var_0, var_1);
}

ondeactivate() {
  self notify("_encstr_85140F22139204D9DDF8E3DF36CDE82275");
  self notify("_encstr_B2F1150BDFFAE03B721F4963CFAA732994F4B3A14654D8");
}

playanimuntilnotetrack(var_0, var_1, var_2, var_3) {
  playanimnuntilnotetrack(var_0, 0, var_1, var_2, var_3);
}

playanimnuntilnotetrack(var_0, var_1, var_2, var_3, var_4) {
  self setanimstate(var_0, var_1);

  if(!isDefined(var_3))
    var_3 = "_encstr_961804BD954A";

  waituntilnotetrack(var_2, var_3, var_0, var_1, var_4);
}

playanimnatrateuntilnotetrack(var_0, var_1, var_2, var_3, var_4, var_5) {
  self setanimstate(var_0, var_1, var_2);

  if(!isDefined(var_4))
    var_4 = "_encstr_961804BD954A";

  waituntilnotetrack(var_3, var_4, var_0, var_1, var_5);
}

waituntillnotetrack_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;

  if(isDefined(var_5))
    var_7 = (gettime() - var_6) * 0.001 / var_5;

  handleglobalnotetracks(var_0, var_2, var_4);

  if(isDefined(var_2) && isDefined(self.asm))
    scripts\asm\asm_mp::asm_handlenotetracks(var_0, var_2, var_3, var_7);

  if(!isDefined(var_5) || var_7 > 0) {
    if(var_0 == var_1 || var_0 == "_encstr_961804BD954A" || var_0 == "_encstr_8110118AE84BCDEF6333EC14C0A9FFD593A8A2" || var_0 == "_encstr_B4BA07CC5ADCB4CDD0")
      return 1;
  }

  if(isDefined(var_4))
    [[var_4]](var_0, var_2, var_3, var_7);

  return 0;
}

waituntilnotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();
  var_6 = undefined;

  if(isDefined(var_2) && isDefined(var_3))
    var_6 = getanimlength(self getanimentry(var_2, var_3));

  var_7 = 0;

  while(!var_7) {
    self waittill(var_0, var_8);

    if(isarray(var_8)) {
      foreach(var_10 in var_8) {
        if(waituntillnotetrack_internal(var_10, var_1, var_2, var_3, var_4, var_6, var_5))
          var_7 = 1;
      }

      continue;
    }

    var_7 = waituntillnotetrack_internal(var_8, var_1, var_2, var_3, var_4, var_6, var_5);
  }
}

playanimfortime(var_0, var_1) {
  playanimnfortime(var_0, 0, var_1);
}

playanimnfortime(var_0, var_1, var_2) {
  self setanimstate(var_0, var_1);
  wait(var_2);
}

playanimnwithnotetracksfortime(var_0, var_1, var_2, var_3, var_4) {
  self setanimstate(var_0, var_1);
  thread playanimnwithnotetracksfortime_helper(var_0, var_1, var_2, var_4);
  wait(var_3);
  self notify(var_0 + var_1);
}

playanimnwithnotetracksfortime_helper(var_0, var_1, var_2, var_3) {
  self notify(var_0 + var_1);
  self endon(var_0 + var_1);
  var_4 = 0;
  var_5 = self getanimentry(var_0, var_1);
  var_6 = getanimlength(var_5);
  var_7 = gettime();

  while(!var_4) {
    self waittill(var_2, var_8);

    if(!isarray(var_8))
      var_8 = [var_8];

    foreach(var_10 in var_8) {
      if(waituntillnotetrack_internal(var_10, "_encstr_961804BD954A", var_0, var_1, var_3, var_6, var_7))
        var_4 = 1;
    }
  }
}

playanimnatratefortime(var_0, var_1, var_2, var_3) {
  self setanimstate(var_0, var_1, var_2);
  wait(var_3);
}

getanimscalefactors(var_0, var_1, var_2) {
  var_3 = length2d(var_0);
  var_4 = var_0[2];
  var_5 = length2d(var_1);
  var_6 = var_1[2];
  var_7 = 1;
  var_8 = 1;

  if(isDefined(var_2) && var_2) {
    var_9 = (var_1[0], var_1[1], 0);
    var_10 = vectorNormalize(var_9);

    if(vectordot(var_10, var_0) < 0)
      var_7 = 0;
    else if(var_5 > 0)
      var_7 = var_3 / var_5;
  } else if(var_5 > 0)
    var_7 = var_3 / var_5;

  if(abs(var_6) > 0.001 && var_6 * var_4 >= 0)
    var_8 = var_4 / var_6;

  var_11 = spawnStruct();
  var_11.xy = var_7;
  var_11.z = var_8;
  return var_11;
}

droppostoground(var_0, var_1) {
  var_2 = 15;
  var_3 = 45;

  if(isDefined(self.radius))
    var_2 = self.radius;

  if(isDefined(self.height))
    var_3 = self.height;

  if(!isDefined(var_1))
    var_1 = 18;

  var_4 = var_0 + (0, 0, var_1);
  var_5 = var_0 + (0, 0, var_1 * -1);
  var_6 = self aiphysicstrace(var_4, var_5, self.radius, self.height, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1)
    return undefined;

  if(abs(var_6[2] - var_5[2]) < 0.1)
    return undefined;

  return var_6;
}

canmovepointtopoint(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2))
    var_2 = 6;

  if(!isDefined(var_3))
    var_3 = self.radius;

  var_4 = (0, 0, 1) * var_2;
  var_5 = var_0 + var_4;
  var_6 = var_1 + var_4;
  return self aiphysicstracepassed(var_5, var_6, var_3, self.height - var_2, 1);
}

getvalidpointtopointmovelocation(var_0, var_1, var_2) {
  if(!isDefined(var_2))
    var_2 = 6;

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return self aiphysicstrace(var_4, var_5, self.radius + 4, self.height - var_2, 1);
}

getsafeanimmovedeltapercentage(var_0) {
  var_1 = getmovedelta(var_0);
  var_2 = self localtoworldcoords(var_1);
  var_3 = getvalidpointtopointmovelocation(self.origin, var_2);
  var_4 = distance(self.origin, var_3);
  var_5 = distance(self.origin, var_2);
  return min(1.0, var_4 / var_5);
}

safelyplayanimuntilnotetrack(var_0, var_1, var_2, var_3) {
  var_4 = getrandomanimentry(var_0);
  safelyplayanimnuntilnotetrack(var_0, var_4, var_1, var_2, var_3);
}

safelyplayanimatrateuntilnotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getrandomanimentry(var_0);
  safelyplayanimnatrateuntilnotetrack(var_0, var_5, var_1, var_2, var_3, var_4);
}

safelyplayanimnatrateuntilnotetrack(var_0, var_1, var_2, var_3, var_4, var_5) {
  self setanimstate(var_0, var_1, var_2);
  safelyplayanimnuntilnotetrack(var_0, var_1, var_3, var_4, var_5);
}

safelyplayanimnuntilnotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self getanimentry(var_0, var_1);
  var_6 = getsafeanimmovedeltapercentage(var_5);

  if(self islegacyagent())
    self scragentsetanimscale(var_6, 1.0);

  playanimnuntilnotetrack(var_0, var_1, var_2, var_3, var_4);

  if(self islegacyagent())
    self scragentsetanimscale(1.0, 1.0);
}

getrandomanimentry(var_0) {
  var_1 = self getanimentrycount(var_0);
  return randomint(var_1);
}

getangleindexfromselfyaw(var_0) {
  var_1 = vectortoangles(var_0);
  var_2 = angleclamp180(var_1[1] - self.angles[1]);
  return getangleindex(var_2);
}

set_anim_state(var_0, var_1, var_2) {
  if(isDefined(var_2))
    self setanimstate(var_0, var_1, var_2);
  else if(isDefined(var_1))
    self setanimstate(var_0, var_1);
  else
    self setanimstate(var_0);
}

isstatelocked() {
  if(!isDefined(self.statelocked))
    return 0;

  return self.statelocked;
}

setstatelocked(var_0, var_1) {
  self.statelocked = var_0;
}

playanimnuntilnotetrack_safe(var_0, var_1, var_2, var_3, var_4) {
  playanimnatrateuntilnotetrack_safe(var_0, var_1, 1.0, var_2, var_3, var_4);
}

waituntilnotetrack_safe(var_0, var_1, var_2) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_2))
    childthread notetrack_timeout(var_0, var_2, var_1);

  waituntilnotetrack(var_0, var_1);
  self notify("_encstr_A34912546A4B253012E947AF2F7310F9D7C28B9B");
}

playanimnatrateuntilnotetrack_safe(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");

  if(isDefined(var_0)) {
    if(isDefined(var_1))
      var_6 = getanimlength(self getanimentry(var_0, var_1));
    else
      var_6 = getanimlength(self getanimentry(var_0, 0));

    childthread notetrack_timeout(var_3, var_6 * (1.0 / var_2), var_4);
  }

  playanimnatrateuntilnotetrack(var_0, var_1, var_2, var_3, var_4, var_5);
  self notify("_encstr_A34912546A4B253012E947AF2F7310F9D7C28B9B");
}

notetrack_timeout(var_0, var_1, var_2) {
  self notify("_encstr_A34912546A4B253012E947AF2F7310F9D7C28B9B");
  self endon("_encstr_A34912546A4B253012E947AF2F7310F9D7C28B9B");
  var_1 = max(0.05, var_1);
  wait(var_1);

  if(isDefined(var_2))
    self notify(var_0, var_2);
  else
    self notify(var_0, "_encstr_961804BD954A");
}

dotraversalwithflexibleheight(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_4 != "_encstr_88AF0EA04787D013E3D368876D3A7D1B")
    playanimnuntilnotetrack(var_0, var_1, var_3, var_4, var_7);

  if(var_6) {
    var_8 = self.endnodepos;
    var_9 = 1;
  } else {
    var_8 = scripts\engine\utility::getStruct(self.endnode.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
    var_8 = var_8.origin;
    var_10 = getnotetracktimes(var_2, "_encstr_88AF0EA04787D013E3D368876D3A7D1B");
    var_9 = var_10[0];
  }

  dotraversalwithflexibleheight_internal(var_0, var_1, var_3, var_2, var_4, var_5, var_8, var_9, var_7);
}

dotraversalwithflexibleheight_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = abs(self.origin[2] - var_6[2]);
  var_10 = getnotetracktimes(var_3, var_4);
  var_11 = var_10[0];
  var_12 = var_11;
  var_13 = getnotetracktimes(var_3, var_5);
  var_14 = var_13[0];
  var_7 = var_14;
  var_15 = "_encstr_A2A6136434CF52DF7C3A38400293270B739FF56880";
  var_16 = getnotetracktimes(var_3, var_15);
  var_17 = "_encstr_BD78159CF0C57980FA7F4331E470AE0C7777E050234033";
  var_18 = getnotetracktimes(var_3, var_17);
  var_19 = "_encstr_972D1833C6B2E1FAD0CA4BB31A8EFA8CBDBBB9EB987B1D47DEB6";
  var_20 = getnotetracktimes(var_3, var_19);

  if(var_4 == "_encstr_AA3315EB441F7939A05A7B57100C5E8BAB5FE693716073" && var_16.size > 0)
    var_7 = var_16[0];

  if(var_4 == "_encstr_8D2A1766633DBB066047A7BF71190833CAC4D31F5E6DE33640") {
    if(var_18.size > 0)
      var_12 = var_16[0];

    if(var_20.size > 0)
      var_7 = var_20[0];
  }

  var_21 = getmovedelta(var_3, var_12, var_7);
  var_22 = abs(var_21[2]);
  var_24 = getmovedelta(var_3, var_11, var_14);
  var_25 = abs(var_24[2]);

  if(var_25 < 1)
    var_26 = 1;
  else {
    var_27 = var_22 - var_25;

    if(var_9 <= var_27)
      var_26 = (var_27 - var_9) / var_25;
    else
      var_26 = (var_9 - var_27) / var_25;
  }

  var_28 = clamp(1 / var_26, 0.33, 3.0);

  if(self islegacyagent())
    self scragentsetanimscale(1.0, var_26);

  playanimnatrateuntilnotetrack(var_0, var_1, var_28, var_2, var_5, var_8);
}