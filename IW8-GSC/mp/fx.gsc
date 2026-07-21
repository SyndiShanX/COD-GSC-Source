/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\fx.gsc
***********************************************/

script_print_fx() {
  if(!isDefined(self.script_fxid) || !isDefined(self.script_fxcommand) || !isDefined(self.script_delay)) {
    self delete();
    return;
  }

  if(isDefined(self.target))
    var_0 = getEnt(self.target).origin;
  else
    var_0 = "_encstr_8C500ABA9B23CACC2D37AC8C";

  if(self.script_fxcommand == "_encstr_B6480A90880DD12267293B7B") {}

  if(self.script_fxcommand == "_encstr_BE7F073BF060E0F269") {}

  if(self.script_fxcommand == "_encstr_A7DC0A731F08BBCBC8033D87")
    return;
}

grenadeexplosionfx(var_0) {
  playFX(level._effect["_encstr_B8BE15906AB70338B541E7DB7C0ED0D3231228DB322F48"], var_0);
  earthquake(0.15, 0.5, var_0, 250);
}

soundfx(var_0, var_1, var_2) {
  var_3 = spawn("_encstr_AD050EE61B93A50E8ED7DB39D29D96B9", (0, 0, 0));
  var_3.origin = var_1;
  var_3 playLoopSound(var_0);

  if(isDefined(var_2))
    var_3 thread soundfxdelete(var_2);
}

soundfxdelete(var_0) {
  level waittill(var_0);
  self delete();
}

func_glass_handler() {
  var_0 = [];
  var_1 = [];
  var_2 = getEntArray("_encstr_88EE11CECCE1BEB157B947B7B5AFCED8C2CDCD", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

  foreach(var_4 in var_2) {
    if(isDefined(var_4.script_noteworthy)) {
      var_5 = getglass(var_4.script_noteworthy);

      if(isDefined(var_5)) {
        var_1[var_5] = var_4;
        var_0[var_0.size] = var_5;
      }
    }
  }

  var_7 = var_0.size;
  var_8 = var_0.size;
  var_9 = 5;
  var_10 = 0;

  while(var_7 != 0) {
    var_11 = var_10 + var_9 - 1;

    if(var_11 > var_8)
      var_11 = var_8;

    if(var_10 == var_8)
      var_10 = 0;

    while(var_10 < var_11) {
      var_12 = var_0[var_10];
      var_4 = var_1[var_12];

      if(isDefined(var_4)) {
        if(isglassdestroyed(var_12)) {
          var_4 delete();
          var_7--;
          var_1[var_12] = undefined;
        }
      }

      var_10++;
    }

    wait 0.05;
  }
}

blenddelete(var_0) {
  self waittill("_encstr_AD75063D571AE108");
  var_0 delete();
}