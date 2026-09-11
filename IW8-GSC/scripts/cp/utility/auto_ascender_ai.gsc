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

  for(var_0 = gettime();; var_0 = dowhizby(var_1, var_0)) {
    self waittill("bulletwhizby", var_1, var_2);
  }
}

function dowhizby(var_0, var_1) {
  if(gettime() - var_1 > 190 && !scripts\cp\utility::isusingremote() && getDvar("scr_whizby_off") == "") {
    thread whizbyblurshoweffect(var_0);
    var_1 = gettime();
  }

  var_2 = var_0 getcurrentweapon();

  if(weaponclass(var_2) == "sniper") {
    scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "flavor_surprise", undefined, 0.2);
  }

  thread scripts\cp\cp_player_battlechatter::addrecentattacker(var_0);
  return var_1;
}

function dowhizbycleanup() {
  foreach(var_1 in self._whizbyfxent) {
    if(isalive(var_1)) {
      var_1 delete();
    }
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_whizby_event", 0);
    return;
  }
}

function whizbyblurshoweffect(var_0) {
  if(getdvarint("scr_suppression", 1) == 1) {
    var_1 = var_0 getcurrentweapon();
    var_2 = weaponclass(var_1);

    if((var_1 hasattachment("linearbrake", 1) || var_2 == "mg") && !scripts\cp\utility::iskillstreakweapon(var_1) && !scripts\cp\utility::_hasperk("specialty_blastshield")) {
      if(!isDefined(self.suppressionmagnitude)) {
        self.suppressionmagnitude = 0;
      }

      self notify("whizbyBlur_reset");
      var_3 = self.suppressionmagnitude;
      self.suppressionmagnitude = clamp(self.suppressionmagnitude + getsuppressionstrength(var_2, self, var_0), 0, 100);
      thread whizbyblurrampup(var_3, self.suppressionmagnitude);
      return;
    }

    return;
  }
}

function whizbyblurrampup(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("whizbyBlur_reset");
  var_2 = 0.3;

  while(var_0 < var_1) {
    var_0 += 20;
    self earthquakeforplayer(var_2, 1.1, self.origin, 100);
    var_2 += 0.1;
    wait 0.05;
  }
}

function whizbyblurrampdown(var_0, var_1) {
  self endon("death_or_disconnect");
  self endon("whizbyBlur_reset");

  while(self.suppressionmagnitude > 0) {
    self.suppressionmagnitude -= 2.5;

    if(self.suppressionmagnitude < 0) {
      self.suppressionmagnitude = 0;
    }

    var_2 = clamp(self.suppressionmagnitude, 0, 100);
    wait 0.2;
  }

  self.suppressionmagnitude = 0;
}

function getsuppressionstrength(var_0, var_1, var_2) {
  var_3 = distance2d(var_1.origin, var_2.origin);

  if(var_3 < 1024) {
    var_3 *= 0.25;
  }

  switch (var_0) {
    case "mg":
      return (10 * var_3 / 1024);
    case "sniper":
      return (5 * var_3 / 1024);
    default:
      return 0;
  }
}