/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\mp\script_funcs.gsc
***************************************************/

function forwardpushevent(var_0, var_1, var_2, var_3) {
  var_4 = scripts\asm\asm::asm_geteventdata(var_0, "player_pushed");
  scripts\asm\asm::asm_fireephemeralevent("player_pushed", "player_pushed", var_4);
}

function shouldplaypushedanim(var_0, var_1, var_2, var_3) {
  if(scripts\asm\asm::asm_eventfired(var_0, "player_pushed")) {
    var_4 = scripts\asm\asm::asm_geteventdata(var_0, "player_pushed");
    var_5 = vectorNormalize(var_4);
    var_6 = navtrace(self.origin, self.origin + 4 * var_4, self, 1);

    if(var_6["fraction"] >= 0.99 || vectordot(var_5, var_6["normal"]) >= -0.866) {
      return true;
    }
  }

  return false;
}

function playanim_pushed(var_0, var_1, var_2) {
  var_3 = scripts\asm\asm::asm_getanim(var_0, var_1);
  var_4 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");

  if(isDefined(var_4)) {
    var_5 = vectortoyaw(-1 * var_4);
    self orientmode("face angle", var_5);
  }

  scripts\asm\shared\utility::playanim(var_0, var_1, var_2);
}

function playmovestrafeloop(var_0, var_1, var_2) {
  initmovestrafeloop(var_0, var_1, var_2);
  movestrafeloop(var_0, var_1);
}

function initmovestrafeloop(var_0, var_1, var_2) {}

function movestrafeloop(var_0, var_1) {
  self endon(var_1 + "_finished");
  var_2 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "f");
  var_3 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "l");
  var_4 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "r");
  var_5 = scripts\asm\asm::asm_lookupanimfromalias(var_1, "b");
  var_6 = -1;
  var_7 = -1;

  for(;;) {
    var_8 = scripts\anim\utility_common::quadrantanimweights(self getmotionangle());

    if(var_8["back"] == 1) {
      var_7 = var_5;
    } else if(var_8["left"] == 1) {
      var_7 = var_3;
    } else if(var_8["right"] == 1) {
      var_7 = var_4;
    } else {
      var_7 = var_2;
    }

    if(var_7 != var_6) {
      self aisetanim(var_1, var_7);
    }

    var_6 = var_7;
    wait 0.25;
  }
}

function playmeleeanim_seekerattack_victim(var_0, var_1, var_2) {}

function playmeleeanim_c6freed(var_0, var_1, var_2) {}