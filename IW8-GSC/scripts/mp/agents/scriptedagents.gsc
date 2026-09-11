/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\agents\scriptedagents.gsc
************************************************/

function ai_init(var0, var1) {
  self.behaviortreeasset = var0;
  scripts\asm\asm::asm_init_blackboard();
  scripts\aitypes\bt_util::bt_init();
  scripts\asm\asm_mp::asm_init(var1, self.animationarchetype);

  if(self islegacyagent()) {
    thread scripts\asm\asm_mp::traversehandler();
    return;
  }
}

function handleglobalnotetracks(var0, var1, var2) {
  if(isDefined(anim.notetracks[var0])) {
    return [[anim.notetracks[var0]]](var0, var1);
  }

  return undefined;
}

function onenterstate(var0, var1) {
  if(isDefined(self.onenteranimstate)) {
    self[[self.onenteranimstate]](var0, var1);
    return;
  }
}

function ondeactivate() {
  self notify("killanimscript");
  self notify("terminate_ai_threads");
}

function playanimuntilnotetrack(var0, var1, var2, var3) {
  playanimnuntilnotetrack(var0, 0, var1, var2, var3);
}

function playanimnuntilnotetrack(var0, var1, var2, var3, var4) {
  self setanimstate(var0, var1);

  if(!isDefined(var3)) {
    var3 = "end";
  }

  waituntilnotetrack(var2, var3, var0, var1, var4);
}

function playanimnatrateuntilnotetrack(var0, var1, var2, var3, var4, var5) {
  self setanimstate(var0, var1, var2);

  if(!isDefined(var4)) {
    var4 = "end";
  }

  waituntilnotetrack(var3, var4, var0, var1, var5);
}

function waituntillnotetrack_internal(var0, var1, var2, var3, var4, var5, var6) {
  var7 = undefined;

  if(isDefined(var5)) {
    var7 = (gettime() - var6) * 0.001 / var5;
  }

  handleglobalnotetracks(var0, var2, var4);

  if(isDefined(var2) && isDefined(self.asm)) {
    scripts\asm\asm_mp::asm_handlenotetracks(var0, var2, var3, var7);
  }

  if(!isDefined(var5) || var7 > 0) {
    if(var0 == var1 || var0 == "end" || var0 == "anim_will_finish" || var0 == "finish") {
      return true;
    }
  }

  if(isDefined(var4)) {
    [[var4]](var0, var2, var3, var7);
  }

  return false;
}

function waituntilnotetrack(var0, var1, var2, var3, var4) {
  var5 = gettime();
  var6 = undefined;

  if(isDefined(var2) && isDefined(var3)) {
    var6 = getanimlength(self getanimentry(var2, var3));
  }

  for(var7 = 0; !var7; var7 = waituntillnotetrack_internal(var8, var1, var2, var3, var4, var6, var5)) {
    self waittill(var0, var8);

    if(isarray(var8)) {
      foreach(var10 in var8) {
        if(waituntillnotetrack_internal(var10, var1, var2, var3, var4, var6, var5)) {
          var7 = 1;
        }
      }

      continue;
    }
  }
}

function playanimfortime(var0, var1) {
  playanimnfortime(var0, 0, var1);
}

function playanimnfortime(var0, var1, var2) {
  self setanimstate(var0, var1);
  wait var2;
}

function playanimnwithnotetracksfortime(var0, var1, var2, var3, var4) {
  self setanimstate(var0, var1);
  thread playanimnwithnotetracksfortime_helper(var0, var1, var2, var4);
  wait var3;
  self notify(var0 + var1);
}

function playanimnwithnotetracksfortime_helper(var0, var1, var2, var3) {
  self notify(var0 + var1);
  self endon(var0 + var1);
  var4 = 0;
  var5 = self getanimentry(var0, var1);
  var6 = getanimlength(var5);
  var7 = gettime();

  while(!var4) {
    self waittill(var2, var8);

    if(!isarray(var8)) {
      var8 = [var8];
    }

    foreach(var10 in var8) {
      if(waituntillnotetrack_internal(var10, "end", var0, var1, var3, var6, var7)) {
        var4 = 1;
      }
    }
  }
}

function playanimnatratefortime(var0, var1, var2, var3) {
  self setanimstate(var0, var1, var2);
  wait var3;
}

function getanimscalefactors(var0, var1, var2) {
  var3 = length2d(var0);
  var4 = var0[2];
  var5 = length2d(var1);
  var6 = var1[2];
  var7 = 1;
  var8 = 1;

  if(isDefined(var2) && var2) {
    var9 = (var1[0], var1[1], 0);
    var10 = vectorNormalize(var9);

    if(vectordot(var10, var0) < 0) {
      var7 = 0;
    } else if(var5 > 0) {
      var7 = var3 / var5;
    }
  } else if(var5 > 0) {
    var7 = var3 / var5;
  }

  if(abs(var6) > 0.001 && var6 * var4 >= 0) {
    var8 = var4 / var6;
  }

  var11 = spawnStruct();
  var11.xy = var7;
  var11.z = var8;
  return var11;
}

function droppostoground(var0, var1) {
  var2 = 15;
  var3 = 45;

  if(isDefined(self.radius)) {
    var2 = self.radius;
  }

  if(isDefined(self.height)) {
    var3 = self.height;
  }

  if(!isDefined(var1)) {
    var1 = 18;
  }

  var4 = var0 + (0, 0, var1);
  var5 = var0 + (0, 0, var1 * -1);
  var6 = self aiphysicstrace(var4, var5, self.radius, self.height, 1);

  if(abs(var6[2] - var4[2]) < 0.1) {
    return undefined;
  }

  if(abs(var6[2] - var5[2]) < 0.1) {
    return undefined;
  }

  return var6;
}

function canmovepointtopoint(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    var2 = 6;
  }

  if(!isDefined(var3)) {
    var3 = self.radius;
  }

  var4 = (0, 0, 1) * var2;
  var5 = var0 + var4;
  var6 = var1 + var4;
  return self aiphysicstracepassed(var5, var6, var3, self.height - var2, 1);
}

function getvalidpointtopointmovelocation(var0, var1, var2) {
  if(!isDefined(var2)) {
    var2 = 6;
  }

  var3 = (0, 0, 1) * var2;
  var4 = var0 + var3;
  var5 = var1 + var3;
  return self aiphysicstrace(var4, var5, self.radius + 4, self.height - var2, 1);
}

function getsafeanimmovedeltapercentage(var0) {
  var1 = getmovedelta(var0);
  var2 = self localtoworldcoords(var1);
  var3 = getvalidpointtopointmovelocation(self.origin, var2);
  var4 = distance(self.origin, var3);
  var5 = distance(self.origin, var2);
  return min(1, var4 / var5);
}

function safelyplayanimuntilnotetrack(var0, var1, var2, var3) {
  var4 = getrandomanimentry(var0);
  safelyplayanimnuntilnotetrack(var0, var4, var1, var2, var3);
}

function safelyplayanimatrateuntilnotetrack(var0, var1, var2, var3, var4) {
  var5 = getrandomanimentry(var0);
  safelyplayanimnatrateuntilnotetrack(var0, var5, var1, var2, var3, var4);
}

function safelyplayanimnatrateuntilnotetrack(var0, var1, var2, var3, var4, var5) {
  self setanimstate(var0, var1, var2);
  safelyplayanimnuntilnotetrack(var0, var1, var3, var4, var5);
}

function safelyplayanimnuntilnotetrack(var0, var1, var2, var3, var4) {
  var5 = self getanimentry(var0, var1);
  var6 = getsafeanimmovedeltapercentage(var5);

  if(self islegacyagent()) {
    self scragentsetanimscale(var6, 1);
  }

  playanimnuntilnotetrack(var0, var1, var2, var3, var4);

  if(self islegacyagent()) {
    self scragentsetanimscale(1, 1);
    return;
  }
}

function getrandomanimentry(var0) {
  var1 = self getanimentrycount(var0);
  return randomint(var1);
}

function getangleindexfromselfyaw(var0) {
  var1 = vectortoangles(var0);
  var2 = angleclamp180(var1[1] - self.angles[1]);
  return getangleindex(var2);
}

function set_anim_state(var0, var1, var2) {
  if(isDefined(var2)) {
    self setanimstate(var0, var1, var2);
    return;
  }

  if(isDefined(var1)) {
    self setanimstate(var0, var1);
    return;
  }

  self setanimstate(var0);
}

function isstatelocked() {
  if(!isDefined(self.statelocked)) {
    return 0;
  }

  return self.statelocked;
}

function setstatelocked(var0, var1) {
  self.statelocked = var0;
}

function playanimnuntilnotetrack_safe(var0, var1, var2, var3, var4) {
  playanimnatrateuntilnotetrack_safe(var0, var1, 1, var2, var3, var4);
}

function waituntilnotetrack_safe(var0, var1, var2) {
  self endon("death_or_disconnect");

  if(isDefined(var2)) {
    GscBinSkip4(0x35, var0, var2, var1);
  }

  waituntilnotetrack(var0, var1);
  self notify("Notetrack_Timeout");
}

function playanimnatrateuntilnotetrack_safe(var0, var1, var2, var3, var4, var5) {
  self endon("death_or_disconnect");

  if(isDefined(var0)) {
    if(isDefined(var1)) {
      var6 = getanimlength(self getanimentry(var0, var1));
    } else {
      var6 = getanimlength(self getanimentry(var1, 0));
    }

    GscBinSkip4(0x35, var4, var6 * 1 / var3, var5);
  }

  playanimnatrateuntilnotetrack(var2, var3, var4, var5, var6, var6);
  self notify("Notetrack_Timeout");
}

function notetrack_timeout(var0, var1, var2) {
  self notify("Notetrack_Timeout");
  self endon("Notetrack_Timeout");
  var1 = max(0.05, var1);
  wait var1;

  if(isDefined(var2)) {
    self notify(var0, var2);
    return;
  }

  self notify(var0, "end");
}

function dotraversalwithflexibleheight(var0, var1, var2, var3, var4, var5, var6, var7) {
  if(var4 != "highest_point") {
    playanimnuntilnotetrack(var0, var1, var3, var4, var7);
  }

  if(var6) {
    var8 = self.endnodepos;
    var9 = 1;
  } else {
    var8 = scripts\engine\utility::getStruct(self.endnode.target, "targetname");
    var8 = var8.origin;
    var10 = getnotetracktimes(var4, "highest_point");
    var9 = var10[0];
  }

  dotraversalwithflexibleheight_internal(var2, var3, var5, var4, var6, var7, var8, var9, var9);
}

function dotraversalwithflexibleheight_internal(var0, var1, var2, var3, var4, var5, var6, var7, var8) {
  var9 = abs(self.origin[2] - var6[2]);
  var10 = getnotetracktimes(var3, var4);
  var11 = var10[0];
  var12 = var11;
  var13 = getnotetracktimes(var3, var5);
  var14 = var13[0];
  var7 = var14;
  var15 = "flex_height_up_top";
  var16 = getnotetracktimes(var3, var15);
  var17 = "flex_height_down_top";
  var18 = getnotetracktimes(var3, var17);
  var19 = "flex_height_down_bottom";
  var20 = getnotetracktimes(var3, var19);

  if(var4 == "flex_height_up_start" && var16.size > 0) {
    var7 = var16[0];
  }

  if(var4 == "flex_height_down_start") {
    if(var18.size > 0) {
      var12 = var16[0];
    }

    if(var20.size > 0) {
      var7 = var20[0];
    }
  }

  var21 = getmovedelta(var3, var12, var7);
  var22 = abs(var21[2]);
  var24 = getmovedelta(var3, var11, var14);
  var25 = abs(var24[2]);
  jumpiffalse(var25 < 1) LOC_000000dd;
  var26 = 1;
  goto LOC_00000102;
}