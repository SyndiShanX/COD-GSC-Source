/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\scriptedagents.gsc
************************************************/

function ai_init(var_0, var_1) {
  self.behaviortreeasset = var_0;
  scripts\asm\asm::asm_init_blackboard();
  scripts\aitypes\bt_util::bt_init();
  scripts\asm\asm_mp::asm_init(var_1, self.animationarchetype);

  if(self islegacyagent()) {
    thread scripts\asm\asm_mp::traversehandler();
    return;
  }
}

function handleglobalnotetracks(var_0, var_1, var_2) {
  if(isDefined(anim.notetracks[var_0])) {
    return [[anim.notetracks[var_0]]](var_0, var_1);
  }

  return undefined;
}

function onenterstate(var_0, var_1) {
  if(isDefined(self.onenteranimstate)) {
    self[[self.onenteranimstate]](var_0, var_1);
    return;
  }
}

function ondeactivate() {
  self notify("killanimscript");
  self notify("terminate_ai_threads");
}

function playanimuntilnotetrack(var_0, var_1, var_2, var_3) {
  playanimnuntilnotetrack(var_0, 0, var_1, var_2, var_3);
}

function playanimnuntilnotetrack(var_0, var_1, var_2, var_3, var_4) {
  self setanimstate(var_0, var_1);

  if(!isDefined(var_3)) {
    var_3 = "end";
  }

  waituntilnotetrack(var_2, var_3, var_0, var_1, var_4);
}

function playanimnatrateuntilnotetrack(var_0, var_1, var_2, var_3, var_4, var_5) {
  self setanimstate(var_0, var_1, var_2);

  if(!isDefined(var_4)) {
    var_4 = "end";
  }

  waituntilnotetrack(var_3, var_4, var_0, var_1, var_5);
}

function waituntillnotetrack_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  var_7 = undefined;

  if(isDefined(var_5)) {
    var_7 = (gettime() - var_6) * 0.001 / var_5;
  }

  handleglobalnotetracks(var_0, var_2, var_4);

  if(isDefined(var_2) && isDefined(self.asm)) {
    scripts\asm\asm_mp::asm_handlenotetracks(var_0, var_2, var_3, var_7);
  }

  if(!isDefined(var_5) || var_7 > 0) {
    if(var_0 == var_1 || var_0 == "end" || var_0 == "anim_will_finish" || var_0 == "finish") {
      return true;
    }
  }

  if(isDefined(var_4)) {
    [[var_4]](var_0, var_2, var_3, var_7);
  }

  return false;
}

function waituntilnotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = gettime();
  var_6 = undefined;

  if(isDefined(var_2) && isDefined(var_3)) {
    var_6 = getanimlength(self getanimentry(var_2, var_3));
  }

  for(var_7 = 0; !var_7; var_7 = waituntillnotetrack_internal(var_8, var_1, var_2, var_3, var_4, var_6, var_5)) {
    self waittill(var_0, var_8);

    if(isarray(var_8)) {
      foreach(var_10 in var_8) {
        if(waituntillnotetrack_internal(var_10, var_1, var_2, var_3, var_4, var_6, var_5)) {
          var_7 = 1;
        }
      }

      continue;
    }
  }
}

function playanimfortime(var_0, var_1) {
  playanimnfortime(var_0, 0, var_1);
}

function playanimnfortime(var_0, var_1, var_2) {
  self setanimstate(var_0, var_1);
  wait var_2;
}

function playanimnwithnotetracksfortime(var_0, var_1, var_2, var_3, var_4) {
  self setanimstate(var_0, var_1);
  thread playanimnwithnotetracksfortime_helper(var_0, var_1, var_2, var_4);
  wait var_3;
  self notify(var_0 + var_1);
}

function playanimnwithnotetracksfortime_helper(var_0, var_1, var_2, var_3) {
  self notify(var_0 + var_1);
  self endon(var_0 + var_1);
  var_4 = 0;
  var_5 = self getanimentry(var_0, var_1);
  var_6 = getanimlength(var_5);
  var_7 = gettime();

  while(!var_4) {
    self waittill(var_2, var_8);

    if(!isarray(var_8)) {
      var_8 = [var_8];
    }

    foreach(var_10 in var_8) {
      if(waituntillnotetrack_internal(var_10, "end", var_0, var_1, var_3, var_6, var_7)) {
        var_4 = 1;
      }
    }
  }
}

function playanimnatratefortime(var_0, var_1, var_2, var_3) {
  self setanimstate(var_0, var_1, var_2);
  wait var_3;
}

function getanimscalefactors(var_0, var_1, var_2) {
  var_3 = length2d(var_0);
  var_4 = var_0[2];
  var_5 = length2d(var_1);
  var_6 = var_1[2];
  var_7 = 1;
  var_8 = 1;

  if(isDefined(var_2) && var_2) {
    var_9 = (var_1[0], var_1[1], 0);
    var_10 = vectorNormalize(var_9);

    if(vectordot(var_10, var_0) < 0) {
      var_7 = 0;
    } else if(var_5 > 0) {
      var_7 = var_3 / var_5;
    }
  } else if(var_5 > 0) {
    var_7 = var_3 / var_5;
  }

  if(abs(var_6) > 0.001 && var_6 * var_4 >= 0) {
    var_8 = var_4 / var_6;
  }

  var_11 = spawnStruct();
  var_11.xy = var_7;
  var_11.z = var_8;
  return var_11;
}

function droppostoground(var_0, var_1) {
  var_2 = 15;
  var_3 = 45;

  if(isDefined(self.radius)) {
    var_2 = self.radius;
  }

  if(isDefined(self.height)) {
    var_3 = self.height;
  }

  if(!isDefined(var_1)) {
    var_1 = 18;
  }

  var_4 = var_0 + (0, 0, var_1);
  var_5 = var_0 + (0, 0, var_1 * -1);
  var_6 = self aiphysicstrace(var_4, var_5, self.radius, self.height, 1);

  if(abs(var_6[2] - var_4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var_6[2] - var_5[2]) < 0.1) {
    return undefined;
  }

  return var_6;
}

function canmovepointtopoint(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  if(!isDefined(var_3)) {
    var_3 = self.radius;
  }

  var_4 = (0, 0, 1) * var_2;
  var_5 = var_0 + var_4;
  var_6 = var_1 + var_4;
  return self aiphysicstracepassed(var_5, var_6, var_3, self.height - var_2, 1);
}

function getvalidpointtopointmovelocation(var_0, var_1, var_2) {
  if(!isDefined(var_2)) {
    var_2 = 6;
  }

  var_3 = (0, 0, 1) * var_2;
  var_4 = var_0 + var_3;
  var_5 = var_1 + var_3;
  return self aiphysicstrace(var_4, var_5, self.radius + 4, self.height - var_2, 1);
}

function getsafeanimmovedeltapercentage(var_0) {
  var_1 = getmovedelta(var_0);
  var_2 = self localtoworldcoords(var_1);
  var_3 = getvalidpointtopointmovelocation(self.origin, var_2);
  var_4 = distance(self.origin, var_3);
  var_5 = distance(self.origin, var_2);
  return min(1, var_4 / var_5);
}

function safelyplayanimuntilnotetrack(var_0, var_1, var_2, var_3) {
  var_4 = getrandomanimentry(var_0);
  safelyplayanimnuntilnotetrack(var_0, var_4, var_1, var_2, var_3);
}

function safelyplayanimatrateuntilnotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = getrandomanimentry(var_0);
  safelyplayanimnatrateuntilnotetrack(var_0, var_5, var_1, var_2, var_3, var_4);
}

function safelyplayanimnatrateuntilnotetrack(var_0, var_1, var_2, var_3, var_4, var_5) {
  self setanimstate(var_0, var_1, var_2);
  safelyplayanimnuntilnotetrack(var_0, var_1, var_3, var_4, var_5);
}

function safelyplayanimnuntilnotetrack(var_0, var_1, var_2, var_3, var_4) {
  var_5 = self getanimentry(var_0, var_1);
  var_6 = getsafeanimmovedeltapercentage(var_5);

  if(self islegacyagent()) {
    self scragentsetanimscale(var_6, 1);
  }

  playanimnuntilnotetrack(var_0, var_1, var_2, var_3, var_4);

  if(self islegacyagent()) {
    self scragentsetanimscale(1, 1);
    return;
  }
}

function getrandomanimentry(var_0) {
  var_1 = self getanimentrycount(var_0);
  return randomint(var_1);
}

function getangleindexfromselfyaw(var_0) {
  var_1 = vectortoangles(var_0);
  var_2 = angleclamp180(var_1[1] - self.angles[1]);
  return getangleindex(var_2);
}

function set_anim_state(var_0, var_1, var_2) {
  if(isDefined(var_2)) {
    self setanimstate(var_0, var_1, var_2);
    return;
  }

  if(isDefined(var_1)) {
    self setanimstate(var_0, var_1);
    return;
  }

  self setanimstate(var_0);
}

function isstatelocked() {
  if(!isDefined(self.statelocked)) {
    return 0;
  }

  return self.statelocked;
}

function setstatelocked(var_0, var_1) {
  self.statelocked = var_0;
}

function playanimnuntilnotetrack_safe(var_0, var_1, var_2, var_3, var_4) {
  playanimnatrateuntilnotetrack_safe(var_0, var_1, 1, var_2, var_3, var_4);
}

function waituntilnotetrack_safe(var_0, var_1, var_2) {
  self endon("death_or_disconnect");

  if(isDefined(var_2)) {
    GscBinSkip4(0x35, var_0, var_2, var_1);
  }

  waituntilnotetrack(var_0, var_1);
  self notify("Notetrack_Timeout");
}

function playanimnatrateuntilnotetrack_safe(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("death_or_disconnect");

  if(isDefined(var_0)) {
    if(isDefined(var_1)) {
      var_6 = getanimlength(self getanimentry(var_0, var_1));
    } else {
      var_6 = getanimlength(self getanimentry(var_1, 0));
    }

    GscBinSkip4(0x35, var_4, var_6 * 1 / var_3, var_5);
  }

  playanimnatrateuntilnotetrack(var_2, var_3, var_4, var_5, var_6, var_6);
  self notify("Notetrack_Timeout");
}

function notetrack_timeout(var_0, var_1, var_2) {
  self notify("Notetrack_Timeout");
  self endon("Notetrack_Timeout");
  var_1 = max(0.05, var_1);
  wait var_1;

  if(isDefined(var_2)) {
    self notify(var_0, var_2);
    return;
  }

  self notify(var_0, "end");
}

function dotraversalwithflexibleheight(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7) {
  if(var_4 != "highest_point") {
    playanimnuntilnotetrack(var_0, var_1, var_3, var_4, var_7);
  }

  if(var_6) {
    var_8 = self.endnodepos;
    var_9 = 1;
  } else {
    var_8 = scripts\engine\utility::getStruct(self.endnode.target, "targetname");
    var_8 = var_8.origin;
    var_10 = getnotetracktimes(var_4, "highest_point");
    var_9 = var_10[0];
  }

  dotraversalwithflexibleheight_internal(var_2, var_3, var_5, var_4, var_6, var_7, var_8, var_9, var_9);
}

function dotraversalwithflexibleheight_internal(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8) {
  var_9 = abs(self.origin[2] - var_6[2]);
  var_10 = getnotetracktimes(var_3, var_4);
  var_11 = var_10[0];
  var_12 = var_11;
  var_13 = getnotetracktimes(var_3, var_5);
  var_14 = var_13[0];
  var_7 = var_14;
  var_15 = "flex_height_up_top";
  var_16 = getnotetracktimes(var_3, var_15);
  var_17 = "flex_height_down_top";
  var_18 = getnotetracktimes(var_3, var_17);
  var_19 = "flex_height_down_bottom";
  var_20 = getnotetracktimes(var_3, var_19);

  if(var_4 == "flex_height_up_start" && var_16.size > 0) {
    var_7 = var_16[0];
  }

  if(var_4 == "flex_height_down_start") {
    if(var_18.size > 0) {
      var_12 = var_16[0];
    }

    if(var_20.size > 0) {
      var_7 = var_20[0];
    }
  }

  var_21 = getmovedelta(var_3, var_12, var_7);
  var_22 = abs(var_21[2]);
  var_24 = getmovedelta(var_3, var_11, var_14);
  var_25 = abs(var_24[2]);
  jumpiffalse(var_25 < 1) LOC_000000dd;
  var_26 = 1;
  goto LOC_00000102;
}