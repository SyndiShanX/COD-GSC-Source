/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\auto_ascender_ai.gsc
***************************************************/

function init() {
  setsaveddvar("scr_suppression", 1);
}

function ref_145bd() {
  self._whizbyfxent = [];
  thread whizbythink();
}

function whizbythink() {
  self endon("death_or_disconnect");
  level endon("game_ended");

  for(var0 = gettime();; var0 = dowhizby(var1, var0)) {
    self waittill("bulletwhizby", var1, var2);
  }
}

function dowhizby(var0, var1) {
  if(gettime() - var1 > 190 && !scripts\cp\utility::isusingremote() && getDvar("scr_whizby_off") == "") {
    thread whizbyblurshoweffect(var0);
    var1 = gettime();
  }

  var2 = var0 getcurrentweapon();

  if(weaponclass(var2) == "sniper") {
    scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "flavor_surprise", undefined, 0.2);
  }

  thread scripts\cp\cp_player_battlechatter::addrecentattacker(var0);
  return var1;
}

function dowhizbycleanup() {
  foreach(var1 in self._whizbyfxent) {
    if(isalive(var1)) {
      var1 delete();
    }
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_whizby_event", 0);
    return;
  }
}

function whizbyblurshoweffect(var0) {
  if(getdvarint("scr_suppression", 1) == 1) {
    var1 = var0 getcurrentweapon();
    var2 = weaponclass(var1);

    if((var1 hasattachment("linearbrake", 1) || var2 == "mg") && !scripts\cp\utility::iskillstreakweapon(var1) && !scripts\cp\utility::_hasperk("specialty_blastshield")) {
      if(!isDefined(self.suppressionmagnitude)) {
        self.suppressionmagnitude = 0;
      }

      self notify("whizbyBlur_reset");
      var3 = self.suppressionmagnitude;
      self.suppressionmagnitude = clamp(self.suppressionmagnitude + getsuppressionstrength(var2, self, var0), 0, 100);
      thread whizbyblurrampup(var3, self.suppressionmagnitude);
      return;
    }

    return;
  }
}

function whizbyblurrampup(var0, var1) {
  self endon("death_or_disconnect");
  self endon("whizbyBlur_reset");
  var2 = 0.3;

  while(var0 < var1) {
    var0 += 20;
    self earthquakeforplayer(var2, 1.1, self.origin, 100);
    var2 += 0.1;
    wait 0.05;
  }
}

function whizbyblurrampdown(var0, var1) {
  self endon("death_or_disconnect");
  self endon("whizbyBlur_reset");

  while(self.suppressionmagnitude > 0) {
    self.suppressionmagnitude -= 2.5;

    if(self.suppressionmagnitude < 0) {
      self.suppressionmagnitude = 0;
    }

    var2 = clamp(self.suppressionmagnitude, 0, 100);
    wait 0.2;
  }

  self.suppressionmagnitude = 0;
}

function getsuppressionstrength(var0, var1, var2) {
  var3 = distance2d(var1.origin, var2.origin);

  if(var3 < 1024) {
    var3 *= 0.25;
  }

  switch (var0) {
    case "mg":
      return (10 * var3 / 1024);
    case "sniper":
      return (5 * var3 / 1024);
    default:
      return 0;
  }
}