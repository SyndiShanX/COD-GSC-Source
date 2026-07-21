/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hud_util.gsc
***********************************************/

setparent(var_0) {
  if(isDefined(self.parent) && self.parent == var_0) {
    return;
  }
  if(isDefined(self.parent))
    self.parent removechild(self);

  self.parent = var_0;
  self.parent addchild(self);

  if(isDefined(self.point))
    setpoint(self.point, self.relativepoint, self.xoffset, self.yoffset);
  else
    setpoint("_encstr_AF9F08DB601069806D49");
}

getparent() {
  return self.parent;
}

removedestroyedchildren() {
  if(isDefined(self.childchecktime) && self.childchecktime == gettime()) {
    return;
  }
  self.childchecktime = gettime();
  var_0 = [];

  foreach(var_3, var_2 in self.children) {
    if(!isDefined(var_2)) {
      continue;
    }
    var_2.index = var_0.size;
    var_0[var_0.size] = var_2;
  }

  self.children = var_0;
}

addchild(var_0) {
  var_0.index = self.children.size;
  self.children[self.children.size] = var_0;
  removedestroyedchildren();
}

removechild(var_0) {
  var_0.parent = undefined;

  if(self.children[self.children.size - 1] != var_0) {
    self.children[var_0.index] = self.children[self.children.size - 1];
    self.children[var_0.index].index = var_0.index;
  }

  self.children[self.children.size - 1] = undefined;
  var_0.index = undefined;
}

setpoint(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_4))
    var_4 = 0;

  var_5 = getparent();

  if(var_4)
    self moveovertime(var_4);

  if(!isDefined(var_2))
    var_2 = 0;

  self.xoffset = var_2;

  if(!isDefined(var_3))
    var_3 = 0;

  self.yoffset = var_3;
  self.point = var_0;
  self.alignx = "_encstr_A5C407E1658D3339B3";
  self.aligny = "_encstr_8F8D07BB035BDAD5CD";

  if(issubstr(var_0, "_encstr_AC190439DF9A"))
    self.aligny = "_encstr_AC190479FF92";

  if(issubstr(var_0, "_encstr_A146079E6DF9115CFD"))
    self.aligny = "_encstr_A146078E65FB5158DD";

  if(issubstr(var_0, "_encstr_A5AD0568058CE3"))
    self.alignx = "_encstr_A5AD056A019C63";

  if(issubstr(var_0, "_encstr_8253061E6BDF6331"))
    self.alignx = "_encstr_8253060E2B5FE330";

  if(!isDefined(var_1))
    var_1 = var_0;

  self.relativepoint = var_1;
  var_6 = "_encstr_BAC512BEE718EBC723A9C16A94030203300209C7";
  var_7 = "_encstr_8F8D07BB035BDAD5CD";

  if(issubstr(var_1, "_encstr_AC190439DF9A"))
    var_7 = "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8";

  if(issubstr(var_1, "_encstr_A146079E6DF9115CFD"))
    var_7 = "_encstr_BD6B122E4FF3ABF775C13060EA0B87E3FFEAA115";

  if(issubstr(var_1, "_encstr_A5AD0568058CE3"))
    var_6 = "_encstr_AD16101BCA66A37DB0194D579B470B261BB2";

  if(issubstr(var_1, "_encstr_8253061E6BDF6331"))
    var_6 = "_encstr_85B111AA1808586B88E38BBBE346B389C840E7";

  if(var_5 == level.uiparent) {
    self.horzalign = var_6;
    self.vertalign = var_7;
  } else {
    self.horzalign = var_5.horzalign;
    self.vertalign = var_5.vertalign;
  }

  if(scripts\mp\utility\script::strip_suffix(var_6, "_encstr_9A9D0C77C92FEDB3E6BD8A42CB7A") == var_5.alignx) {
    var_8 = 0;
    var_9 = 0;
  } else if(var_6 == "_encstr_A5C407E1658D3339B3" || var_5.alignx == "_encstr_A5C407E1658D3339B3") {
    var_8 = int(var_5.width / 2);

    if(var_6 == "_encstr_AD16101BCA66A37DB0194D579B470B261BB2" || var_5.alignx == "_encstr_8253060E2B5FE330")
      var_9 = -1;
    else
      var_9 = 1;
  } else {
    var_8 = var_5.width;

    if(var_6 == "_encstr_AD16101BCA66A37DB0194D579B470B261BB2")
      var_9 = -1;
    else
      var_9 = 1;
  }

  self.x = var_5.x + var_8 * var_9;

  if(scripts\mp\utility\script::strip_suffix(var_7, "_encstr_9A9D0C77C92FEDB3E6BD8A42CB7A") == var_5.aligny) {
    var_10 = 0;
    var_11 = 0;
  } else if(var_7 == "_encstr_8F8D07BB035BDAD5CD" || var_5.aligny == "_encstr_8F8D07BB035BDAD5CD") {
    var_10 = int(var_5.height / 2);

    if(var_7 == "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8" || var_5.aligny == "_encstr_A146078E65FB5158DD")
      var_11 = -1;
    else
      var_11 = 1;
  } else {
    var_10 = var_5.height;

    if(var_7 == "_encstr_916F0FFC57085917A5D0F39B3B0F43CDC8")
      var_11 = -1;
    else
      var_11 = 1;
  }

  self.y = var_5.y + var_10 * var_11;
  self.x = self.x + self.xoffset;
  self.y = self.y + self.yoffset;

  switch (self.elemtype) {
    case "_encstr_B61904310B39":
      setpointbar(var_0, var_1, var_2, var_3);
      break;
  }

  updatechildren();
}

setpointbar(var_0, var_1, var_2, var_3) {
  self.bar.horzalign = self.horzalign;
  self.bar.vertalign = self.vertalign;
  self.bar.alignx = "_encstr_A5AD056A019C63";
  self.bar.aligny = self.aligny;
  self.bar.y = self.y;

  if(self.alignx == "_encstr_A5AD056A019C63")
    self.bar.x = self.x;
  else if(self.alignx == "_encstr_8253060E2B5FE330")
    self.bar.x = self.x - self.width;
  else
    self.bar.x = self.x - int(self.width / 2);

  if(self.aligny == "_encstr_AC190479FF92")
    self.bar.y = self.y;
  else if(self.aligny == "_encstr_A146078E65FB5158DD")
    self.bar.y = self.y;

  updatebar(self.bar.frac);
}

updatebar(var_0, var_1) {
  if(self.elemtype == "_encstr_B61904310B39")
    updatebarscale(var_0, var_1);
}

updatebarscale(var_0, var_1) {
  var_2 = int(self.width * var_0 + 0.5);

  if(!var_2)
    var_2 = 1;

  self.bar.frac = var_0;
  self.bar setshader(self.bar.shader, var_2, self.height);

  if(isDefined(var_1) && var_2 < self.width) {
    if(var_1 > 0)
      self.bar scaleovertime((1 - var_0) / var_1, self.width, self.height);
    else if(var_1 < 0)
      self.bar scaleovertime(var_0 / (-1 * var_1), 1, self.height);
  }

  self.bar.rateofchange = var_1;
  self.bar.lastupdatetime = gettime();
}

createfontstring(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "_encstr_9779056EEA2583";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

createservertimer(var_0, var_1, var_2) {
  if(isDefined(var_2))
    var_3 = newteamhudelem(var_2);
  else
    var_3 = newhudelem();

  var_3.elemtype = "_encstr_9A6C06E43B201F1A";
  var_3.font = var_0;
  var_3.fontscale = var_1;
  var_3.basefontscale = var_1;
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = 0;
  var_3.height = int(level.fontheight * var_1);
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;
  return var_3;
}

createtimer(var_0, var_1) {
  var_2 = newclienthudelem(self);
  var_2.elemtype = "_encstr_9A6C06E43B201F1A";
  var_2.font = var_0;
  var_2.fontscale = var_1;
  var_2.basefontscale = var_1;
  var_2.x = 0;
  var_2.y = 0;
  var_2.width = 0;
  var_2.height = int(level.fontheight * var_1);
  var_2.xoffset = 0;
  var_2.yoffset = 0;
  var_2.children = [];
  var_2 setparent(level.uiparent);
  var_2.hidden = 0;
  return var_2;
}

createicon(var_0, var_1, var_2) {
  var_3 = newclienthudelem(self);
  var_3.elemtype = "_encstr_A3C505966CBDE6";
  var_3.x = 0;
  var_3.y = 0;
  var_3.width = var_1;
  var_3.height = var_2;
  var_3.basewidth = var_3.width;
  var_3.baseheight = var_3.height;
  var_3.xoffset = 0;
  var_3.yoffset = 0;
  var_3.children = [];
  var_3 setparent(level.uiparent);
  var_3.hidden = 0;

  if(isDefined(var_0)) {
    var_3 setshader(var_0, var_1, var_2);
    var_3.shader = var_0;
  }

  return var_3;
}

createbar(var_0, var_1, var_2, var_3) {
  var_4 = newclienthudelem(self);
  var_4.x = 0;
  var_4.y = 0;
  var_4.frac = 0;
  var_4.color = var_0;
  var_4.sort = -2;
  var_4.shader = "_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120";
  var_4 setshader("_encstr_8F221228DAE792F8C5FB4B0FF5A173A944905120", var_1, var_2);
  var_4.hidden = 0;

  if(isDefined(var_3))
    var_4.flashfrac = var_3;

  var_5 = newclienthudelem(self);
  var_5.elemtype = "_encstr_B61904310B39";
  var_5.width = var_1;
  var_5.height = var_2;
  var_5.xoffset = 0;
  var_5.yoffset = 0;
  var_5.bar = var_4;
  var_5.children = [];
  var_5.sort = -3;
  var_5.color = (0, 0, 0);
  var_5.alpha = 0.5;
  var_5 setparent(level.uiparent);
  var_5 setshader("_encstr_929210CB2BA86FFEB853E3571327CBC1164F", var_1 + 4, var_2 + 4);
  var_5.hidden = 0;
  return var_5;
}

getcurrentfraction() {
  var_0 = self.bar.frac;

  if(isDefined(self.bar.rateofchange)) {
    var_0 = var_0 + (gettime() - self.bar.lastupdatetime) * self.bar.rateofchange;

    if(var_0 > 1)
      var_0 = 1;

    if(var_0 < 0)
      var_0 = 0;
  }

  return var_0;
}

createprimaryprogressbar(var_0, var_1) {
  if(isagent(self))
    return undefined;

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = -25;

  if(self issplitscreenplayer())
    var_1 = var_1 + 20;

  var_2 = createbar((1, 1, 1), level.primaryprogressbarwidth, level.primaryprogressbarheight);
  var_2 setpoint("_encstr_A5C407E57585313DB1", undefined, level.primaryprogressbarx + var_0, level.primaryprogressbary + var_1);
  return var_2;
}

createprimaryprogressbartext(var_0, var_1, var_2, var_3) {
  if(isagent(self))
    return undefined;

  if(!isDefined(var_0))
    var_0 = 0;

  if(!isDefined(var_1))
    var_1 = -25;

  if(self issplitscreenplayer())
    var_1 = var_1 + 20;

  var_4 = level.primaryprogressbarfontsize;
  var_5 = "_encstr_8B1608EC43B8D647A113";

  if(isDefined(var_2))
    var_4 = var_2;

  if(isDefined(var_3))
    var_5 = var_3;

  var_6 = createfontstring(var_5, var_4);
  var_6 setpoint("_encstr_A5C407E57585313DB1", undefined, level.primaryprogressbartextx + var_0, level.primaryprogressbartexty + var_1);
  var_6.sort = -1;
  return var_6;
}

setflashfrac(var_0) {
  self.bar.flashfrac = var_0;
}

hideelem() {
  if(self.hidden) {
    return;
  }
  self.hidden = 1;

  if(self.alpha != 0)
    self.alpha = 0;

  if(self.elemtype == "_encstr_B61904310B39" || self.elemtype == "_encstr_AB280BE2CF3307AAA160220AC0") {
    self.bar.hidden = 1;

    if(self.bar.alpha != 0)
      self.bar.alpha = 0;
  }
}

showelem() {
  if(!self.hidden) {
    return;
  }
  self.hidden = 0;

  if(self.elemtype == "_encstr_B61904310B39" || self.elemtype == "_encstr_AB280BE2CF3307AAA160220AC0") {
    if(self.alpha != 0.5)
      self.alpha = 0.5;

    self.bar.hidden = 0;

    if(self.bar.alpha != 1)
      self.bar.alpha = 1;
  } else if(self.alpha != 1)
    self.alpha = 1;
}

flashthread() {
  self endon("_encstr_AD75063D571AE108");

  if(!self.hidden)
    self.alpha = 1;

  for(;;) {
    if(self.frac >= self.flashfrac) {
      if(!self.hidden) {
        self fadeovertime(0.3);
        self.alpha = 0.2;
        wait 0.35;
        self fadeovertime(0.3);
        self.alpha = 1;
      }

      wait 0.7;
      continue;
    }

    if(!self.hidden && self.alpha != 1)
      self.alpha = 1;

    wait 0.05;
  }
}

destroyelem() {
  var_0 = [];

  for(var_1 = 0; var_1 < self.children.size; var_1++) {
    if(isDefined(self.children[var_1]))
      var_0[var_0.size] = self.children[var_1];
  }

  for(var_1 = 0; var_1 < var_0.size; var_1++)
    var_0[var_1] setparent(getparent());

  if(self.elemtype == "_encstr_B61904310B39" || self.elemtype == "_encstr_AB280BE2CF3307AAA160220AC0")
    self.bar destroy();

  self destroy();
}

seticonshader(var_0) {
  self setshader(var_0, self.width, self.height);
  self.shader = var_0;
}

geticonshader(var_0) {
  return self.shader;
}

seticonsize(var_0, var_1) {
  self setshader(self.shader, var_0, var_1);
}

setwidth(var_0) {
  self.width = var_0;
}

setheight(var_0) {
  self.height = var_0;
}

setsize(var_0, var_1) {
  self.width = var_0;
  self.height = var_1;
}

updatechildren() {
  for(var_0 = 0; var_0 < self.children.size; var_0++) {
    var_1 = self.children[var_0];
    var_1 setpoint(var_1.point, var_1.relativepoint, var_1.xoffset, var_1.yoffset);
  }
}

transitionreset() {
  self.x = self.xoffset;
  self.y = self.yoffset;

  if(self.elemtype == "_encstr_9779056EEA2583") {
    self.fontscale = self.basefontscale;
    self.label = &"_encstr_B40101";
  } else if(self.elemtype == "_encstr_A3C505966CBDE6")
    self setshader(self.shader, self.width, self.height);

  self.alpha = 0;
}

transitionzoomin(var_0) {
  switch (self.elemtype) {
    case "_encstr_9A6C06E43B201F1A":
    case "_encstr_9779056EEA2583":
      self.fontscale = 6.3;
      self changefontscaleovertime(var_0);
      self.fontscale = self.basefontscale;
      break;
    case "_encstr_A3C505966CBDE6":
      self setshader(self.shader, self.width * 6, self.height * 6);
      self scaleovertime(var_0, self.width, self.height);
      break;
  }
}

transitionpulsefxin(var_0, var_1) {
  var_2 = int(var_0) * 1000;
  var_3 = int(var_1) * 1000;

  switch (self.elemtype) {
    case "_encstr_9A6C06E43B201F1A":
    case "_encstr_9779056EEA2583":
      self setpulsefx(var_2 + 250, var_3 + var_2, var_2 + 250);
      break;
    default:
      break;
  }
}

transitionslidein(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_A5AD056A019C63";

  switch (var_1) {
    case "_encstr_A5AD056A019C63":
      self.x = self.x + 1000;
      break;
    case "_encstr_8253060E2B5FE330":
      self.x = self.x - 1000;
      break;
    case "_encstr_87070365F7":
      self.y = self.y - 1000;
      break;
    case "_encstr_9767056D0FBFA8":
      self.y = self.y + 1000;
      break;
  }

  self moveovertime(var_0);
  self.x = self.xoffset;
  self.y = self.yoffset;
}

transitionslideout(var_0, var_1) {
  if(!isDefined(var_1))
    var_1 = "_encstr_A5AD056A019C63";

  var_2 = self.xoffset;
  var_3 = self.yoffset;

  switch (var_1) {
    case "_encstr_A5AD056A019C63":
      var_2 = var_2 + 1000;
      break;
    case "_encstr_8253060E2B5FE330":
      var_2 = var_2 - 1000;
      break;
    case "_encstr_87070365F7":
      var_3 = var_3 - 1000;
      break;
    case "_encstr_9767056D0FBFA8":
      var_3 = var_3 + 1000;
      break;
  }

  self.alpha = 1;
  self moveovertime(var_0);
  self.x = var_2;
  self.y = var_3;
}

transitionzoomout(var_0) {
  switch (self.elemtype) {
    case "_encstr_9A6C06E43B201F1A":
    case "_encstr_9779056EEA2583":
      self changefontscaleovertime(var_0);
      self.fontscale = 6.3;
    case "_encstr_A3C505966CBDE6":
      self scaleovertime(var_0, self.width * 6, self.height * 6);
      break;
  }
}

transitionfadein(var_0) {
  self fadeovertime(var_0);

  if(isDefined(self.maxalpha))
    self.alpha = self.maxalpha;
  else
    self.alpha = 1;
}

transitionfadeout(var_0) {
  self fadeovertime(0.15);
  self.alpha = 0;
}

teamplayercardsplash(var_0, var_1, var_2, var_3, var_4) {
  if(level.hardcoremode) {
    return;
  }
  if(!canshowsplash(var_0)) {
    return;
  }
  if(scripts\cp_mp\utility\game_utility::update_ai_volumes()) {
    var_5 = scripts\mp\utility\teams::getteamdata(var_1.team, "_encstr_9775086022BE1B413B8B");

    if(isDefined(var_5)) {
      foreach(var_7 in var_5) {
        if(!isDefined(var_7) || !scripts\mp\utility\player::isreallyalive(var_7) || var_7 _encstr_958123CD8DE42DE0D1B95EDA075E9DC26B56D1F2E0956E7989C9EBC1AE261B2D1BC576DC36::isplayeringulag()) {
          continue;
        }
        if(!istrue(var_4))
          var_7 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
      }

      return;
    }
  } else {
    foreach(var_7 in level.players) {
      if(var_7 ismlgspectator()) {
        var_10 = var_7 getspectatingplayer();

        if(isDefined(var_10) && isDefined(var_2) && var_10.team != var_2)
          continue;
      } else {
        if(isDefined(var_2) && var_7.team != var_2) {
          continue;
        }
        if(!isPlayer(var_7))
          continue;
      }

      if(!isDefined(var_4))
        var_7 thread scripts\mp\hud_message::showsplash(var_0, var_3, var_1);
    }
  }
}

iskillstreakcalloutsplash(var_0) {
  var_1 = 0;

  if(issubstr(var_0, "_encstr_B47106834B35B9CF")) {
    var_2 = strtok(var_0, "_encstr_BA4C02DF");
    var_3 = undefined;

    foreach(var_5 in var_2) {
      if(var_5 == "_encstr_95E405AEDCCA91") {
        continue;
      }
      if(!isDefined(var_3)) {
        var_3 = var_5;
        continue;
      }

      var_3 = var_3 + "_encstr_BA4C02DF" + var_5;
    }

    if(isDefined(var_3) && isDefined(level.killstreakglobals.streaktable.tabledatabyref[var_3]))
      var_1 = 1;
  }

  return var_1;
}

iseventcalloutsplash(var_0) {
  return issubstr(var_0, "_encstr_A58009AEC7A1BAEF2B28EF");
}

getbaseeventcalloutsplash(var_0) {
  var_1 = undefined;
  var_2 = strtok(var_0, "_encstr_BA4C02DF");

  foreach(var_4 in var_2) {
    if(var_4 == "_encstr_A99B08D609DBE0AF2B3B") {
      continue;
    }
    if(!isDefined(var_1)) {
      var_1 = var_4;
      continue;
    }

    var_1 = var_1 + "_encstr_BA4C02DF" + var_4;
  }

  return var_1;
}

canshowsplash(var_0) {
  var_1 = 1;

  switch (scripts\mp\utility\game::getgametype()) {
    case "_encstr_931D068662634370":
    case "_encstr_B81904B04E6B":
      if(iskillstreakcalloutsplash(var_0))
        var_1 = 0;
      else if(iseventcalloutsplash(var_0)) {
        var_2 = getbaseeventcalloutsplash(var_0);

        switch (var_2) {
          case "_encstr_85E10B66B44E6EA3981BBDDE91":
          case "_encstr_994807BFE8FF7C9390":
          case "_encstr_A3F40762E3CFEB384D":
          case "_encstr_8362073FB3E2E3380C":
          case "_encstr_A58607C7CB93AFFD80":
          case "_encstr_939407BD1077D730D0":
          case "_encstr_8C35071A0FD65A1BC6":
          case "_encstr_99CB07663C6DB4368D":
            var_1 = 0;
            break;
        }
      }

      break;
    case "_encstr_B607038AAB":
      if(iseventcalloutsplash(var_0)) {
        var_2 = getbaseeventcalloutsplash(var_0);

        switch (var_2) {
          case "_encstr_85E10B66B44E6EA3981BBDDE91":
          case "_encstr_994807BFE8FF7C9390":
          case "_encstr_A3F40762E3CFEB384D":
          case "_encstr_8362073FB3E2E3380C":
          case "_encstr_A58607C7CB93AFFD80":
          case "_encstr_939407BD1077D730D0":
          case "_encstr_8C35071A0FD65A1BC6":
          case "_encstr_99CB07663C6DB4368D":
            var_1 = 0;
            break;
        }
      }

      break;
  }

  return var_1;
}