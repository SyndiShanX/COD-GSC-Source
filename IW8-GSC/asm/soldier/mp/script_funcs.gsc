/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: asm\soldier\mp\script_funcs.gsc
***********************************************/

forwardpushevent(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_geteventdata(var_0, "_encstr_93410E6B08AB38F713F8203D8638BF07");
  scripts\asm\asm::asm_fireephemeralevent("_encstr_93410E6B08AB38F713F8203D8638BF07", "_encstr_93410E6B08AB38F713F8203D8638BF07", var_4);
}

shouldplaypushedanim(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::asm_eventfired(var_0, "_encstr_93410E6B08AB38F713F8203D8638BF07")) {
    var_4 = scripts\asm\asm::asm_geteventdata(var_0, "_encstr_93410E6B08AB38F713F8203D8638BF07");
    var_5 = vectorNormalize(var_4);
    var_6 = navtrace(self.origin, self.origin + 4 * var_4, self, 1);

    if(var_6["_encstr_A53009A25003666B9818C6"] >= 0.99 || vectordot(var_5, var_6["_encstr_820E07FAE8780B3A4C"]) >= -0.866)
      return 1;
  }

  return 0;
}

playanim_pushed(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getephemeraleventdata("_encstr_93410E6B08AB38F713F8203D8638BF07", "_encstr_93410E6B08AB38F713F8203D8638BF07");

  if(isDefined(var_4)) {
    var_5 = vectortoyaw(-1 * var_4);
    self orientmode("_encstr_A34A0B518A172592D6E64FA115", var_5);
  }

  scripts\asm\shared\utility::playanim(var_0, var_1, var_2);
}

playmovestrafeloop(var_0, var_1, var_2) {
  initmovestrafeloop(var_0, var_1, var_2);
  movestrafeloop(var_0, var_1);
}

initmovestrafeloop(var_0, var_1, var_2) {}

movestrafeloop(var_0, var_1) {
  self endon(var_1 + "_encstr_A3DB0AF5332DDCD237D0AC8C");
  var_2 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_AB4C022B");
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_A54C0259");
  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_844C029C");
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "_encstr_8B4C024C");
  var_6 = -1;
  var_7 = -1;

  for(;;) {
    var_8 = _encstr_96322092C72534F043F78E4F98BFBD5F5398875269C3CB893292B5F278682D370F83::quadrantanimweights(self getmotionangle());

    if(var_8["_encstr_B69B0589C236B6"] == 1.0)
      var_7 = var_5;
    else if(var_8["_encstr_A5AD056A019C63"] == 1.0)
      var_7 = var_3;
    else if(var_8["_encstr_8253060E2B5FE330"] == 1.0)
      var_7 = var_4;
    else
      var_7 = var_2;

    if(var_7 != var_6)
      self aisetanim(var_1, var_7);

    var_6 = var_7;
    wait 0.25;
  }
}

playmeleeanim_seekerattack_victim(var_0, var_1, var_2) {}

playmeleeanim_c6freed(var_0, var_1, var_2) {}