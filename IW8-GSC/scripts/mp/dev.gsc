/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\dev.gsc
***********************************************/

function init() {}

function reflectionprobe_hide_hp() {}

function reflectionprobe_hide_front() {}

function gotonextspawn() {}

function gotoprevspawn() {}

function devaliengiveplayersmoney() {}

function spam_points_popup() {
  var0 = ["headshot", "avenger", "longshot", "posthumous", "double", "triple", "multi"];

  for(var1 = 0; var1 < var0.size; var1++) {
    thread scripts\mp\rank::scorepointspopup(100);
    thread scripts\mp\rank::scoreeventpopup(var0[var1]);
    wait 2;
  }
}

function devlistinventory() {
  var0 = getDvar("scr_list_inventory", "");

  if(var0 != "") {
    var1 = devfindhost();

    if(!isDefined(var1)) {
      return;
    }

    var2 = undefined;
    var3 = undefined;
    var4 = 0;

    if(var0 == "all") {
      var3 = "all weapons";
      var2 = var1 getweaponslistall();
    } else if(var0 == "primaryCurrent") {
      var3 = "current weapon";
      var4 = 1;
      var2 = [var1 getcurrentweapon()];
    } else {
      var3 = var0 + " inventory";
      var2 = var1 getweaponslist(var0);
    }

    devprintweaponlist(var1, var2, var3, var4);
    return;
  }
}

function devprintweaponlist(var0, var1, var2) {
  if(isDefined(var0) && var0.size > 0) {
    foreach(var4 in var0) {
      var5 = self getweaponammoclip(var4);
      var6 = self getweaponammostock(var4);
      var7 = "" + createheadicon(var4) + " " + var5 + "/" + var6;

      if(var2) {
        iprintlnbold(var7);
      }
    }
  }
}

function devgivesuperthink() {
  for(;;) {
    var0 = getDvar("scr_givesuper", "");

    if(var0 != "") {
      foreach(var2 in level.players) {
        var2 scripts\mp\supers::givesuper(var0, 0, 1);
      }
    }

    if(getdvarint("scr_super_short_cooldown", 0) != 0) {
      foreach(var2 in level.players) {
        if(isbot(var2)) {
          continue;
        }

        if(!isDefined(var2 scripts\mp\supers::getcurrentsuper())) {
          continue;
        }

        if(var2 scripts\mp\supers::issupercharging()) {
          var2 scripts\mp\supers::givesuperpoints(var2 scripts\mp\supers::getsuperpointsneeded() * 0.25);
        }
      }
    }

    wait 0.25;
  }
}

function devgivefieldupgradethink() {
  for(;;) {
    var0 = getDvar("scr_givefieldUpgrade", "");

    if(var0 != "") {
      foreach(var2 in level.players) {
        var2 scripts\mp\perks\perkpackage::perkpackage_givedebug(var0);
      }
    }

    wait 0.25;
  }
}

function devfindhost() {
  var0 = undefined;

  foreach(var2 in level.players) {
    if(var2 ishost()) {
      var0 = var2;
      break;
    }
  }

  return var0;
}

function watchlethaldelaycancel() {
  for(;;) {
    if(getdvarint("scr_lethalDelayCancel", 0)) {
      scripts\mp\equipment::cancellethaldelay();
      return;
    }

    wait 1;
  }
}

function watchsuperdelaycancel() {
  for(;;) {
    if(getdvarint("scr_superDelayCancel", 0)) {
      scripts\mp\supers::cancelsuperdelay();
      return;
    }

    wait 1;
  }
}

function watchslowmo() {
  for(;;) {
    if(getDvar("scr_slowmo") != "") {
      break;
    }

    wait 1;
  }

  var0 = getdvarfloat("scr_slowmo");
  setslowmotion(var0, var0, 0);
  thread watchslowmo();
}

function rangefinder() {
  thread scripts\mp\rangefinder::runmprangefinder();
}