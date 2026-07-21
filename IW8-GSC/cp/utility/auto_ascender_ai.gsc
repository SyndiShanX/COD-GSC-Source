/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: cp\utility\auto_ascender_ai.gsc
***********************************************/

init() {
  setsaveddvar("_encstr_8C1710C7CF3EF17350FBF27A7148BB2A187D", 1);
}

_id_145BD() {
  self._whizbyfxent = [];
  thread whizbythink();
}

whizbythink() {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = gettime();

  for(;;) {
    self waittill("_encstr_A5490D5E05C3F8B363F3C8D83B3E43", var_1, var_2);
    var_0 = dowhizby(var_1, var_0);
  }
}

dowhizby(var_0, var_1) {
  if(gettime() - var_1 > 190 && !scripts\cp\utility::isusingremote() && getDvar("_encstr_AF870F78FFBBA717C1C8738690B9F8BDC0") == "_encstr_B40101") {
    thread whizbyblurshoweffect(var_0);
    var_1 = gettime();
  }

  var_2 = var_0 getcurrentweapon();

  if(weaponclass(var_2) == "_encstr_850707F7E5833355B8")
    scripts\cp\cp_player_battlechatter::trysaylocalsound(self, "_encstr_8FF010F221D7301FBECF0F558B4B9EACE351", undefined, 0.2);

  thread scripts\cp\cp_player_battlechatter::addrecentattacker(var_0);
  return var_1;
}

dowhizbycleanup() {
  foreach(var_1 in self._whizbyfxent) {
    if(isalive(var_1))
      var_1 delete();
  }

  if(isDefined(self))
    self setclientomnvar("_encstr_998010D52B76478C4358A2EB89A3C3C7880D", 0);
}

whizbyblurshoweffect(var_0) {
  if(getdvarint("_encstr_8C1710C7CF3EF17350FBF27A7148BB2A187D", 1) == 1) {
    var_1 = var_0 getcurrentweapon();
    var_2 = weaponclass(var_1);

    if((var_1 hasattachment("_encstr_972E0C369637950BE4C493B0DAAC", 1) || var_2 == "_encstr_BE0703A54C") && !scripts\cp\utility::iskillstreakweapon(var_1) && !scripts\cp\utility::_hasperk("_encstr_8CCF166E38CAB15A588D1D97FA1363C2DC1DCD1AA5568D19")) {
      if(!isDefined(self.suppressionmagnitude))
        self.suppressionmagnitude = 0;

      self notify("_encstr_8FDC11E88892286A7FA610CBEB0843A54773CD");
      var_3 = self.suppressionmagnitude;
      self.suppressionmagnitude = clamp(self.suppressionmagnitude + getsuppressionstrength(var_2, self, var_0), 0, 100);
      thread whizbyblurrampup(var_3, self.suppressionmagnitude);
    }
  }
}

whizbyblurrampup(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8FDC11E88892286A7FA610CBEB0843A54773CD");
  var_2 = 0.3;

  while(var_0 < var_1) {
    var_0 = var_0 + 20;
    self earthquakeforplayer(var_2, 1.1, self.origin, 100);
    var_2 = var_2 + 0.1;
    wait 0.05;
  }
}

whizbyblurrampdown(var_0, var_1) {
  self endon("_encstr_AADC14E3520A5B881935437E4138429108A5F8C020C5");
  self endon("_encstr_8FDC11E88892286A7FA610CBEB0843A54773CD");

  while(self.suppressionmagnitude > 0) {
    self.suppressionmagnitude = self.suppressionmagnitude - 2.5;

    if(self.suppressionmagnitude < 0)
      self.suppressionmagnitude = 0;

    var_2 = clamp(self.suppressionmagnitude, 0, 100);
    wait 0.2;
  }

  self.suppressionmagnitude = 0;
}

getsuppressionstrength(var_0, var_1, var_2) {
  var_3 = distance2d(var_1.origin, var_2.origin);

  if(var_3 < 1024)
    var_3 = var_3 * 0.25;

  switch (var_0) {
    case "_encstr_BE0703A54C":
      return 10.0 * (var_3 / 1024);
    case "_encstr_850707F7E5833355B8":
      return 5.0 * (var_3 / 1024);
    default:
      return 0;
  }
}