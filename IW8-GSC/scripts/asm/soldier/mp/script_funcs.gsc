/***************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\asm\soldier\mp\script_funcs.gsc
***************************************************/

function forwardpushevent(var0, var1, var2, var3) {
  var4 = scripts\asm\asm::asm_geteventdata(var0, "player_pushed");
  scripts\asm\asm::asm_fireephemeralevent("player_pushed", "player_pushed", var4);
}

function shouldplaypushedanim(var0, var1, var2, var3) {
  if(scripts\asm\asm::asm_eventfired(var0, "player_pushed")) {
    var4 = scripts\asm\asm::asm_geteventdata(var0, "player_pushed");
    var5 = vectorNormalize(var4);
    var6 = navtrace(self.origin, self.origin + 4 * var4, self, 1);

    if(var6["fraction"] >= 0.99 || vectordot(var5, var6["normal"]) >= -0.866) {
      return true;
    }
  }

  return false;
}

function playanim_pushed(var0, var1, var2) {
  var3 = scripts\asm\asm::asm_getanim(var0, var1);
  var4 = scripts\asm\asm::asm_getephemeraleventdata("player_pushed", "player_pushed");

  if(isDefined(var4)) {
    var5 = vectortoyaw(-1 * var4);
    self orientmode("face angle", var5);
  }

  scripts\asm\shared\utility::playanim(var0, var1, var2);
}

function playmovestrafeloop(var0, var1, var2) {
  initmovestrafeloop(var0, var1, var2);
  movestrafeloop(var0, var1);
}

function initmovestrafeloop(var0, var1, var2) {}

function movestrafeloop(var0, var1) {
  self endon(var1 + "_finished");
  var2 = scripts\asm\asm::asm_lookupanimfromalias(var1, "f");
  var3 = scripts\asm\asm::asm_lookupanimfromalias(var1, "l");
  var4 = scripts\asm\asm::asm_lookupanimfromalias(var1, "r");
  var5 = scripts\asm\asm::asm_lookupanimfromalias(var1, "b");
  var6 = -1;
  var7 = -1;

  for(;;) {
    var8 = scripts\anim\utility_common::quadrantanimweights(self getmotionangle());

    if(var8["back"] == 1) {
      var7 = var5;
    } else if(var8["left"] == 1) {
      var7 = var3;
    } else if(var8["right"] == 1) {
      var7 = var4;
    } else {
      var7 = var2;
    }

    if(var7 != var6) {
      self aisetanim(var1, var7);
    }

    var6 = var7;
    wait 0.25;
  }
}

function playmeleeanim_seekerattack_victim(var0, var1, var2) {}

function playmeleeanim_c6freed(var0, var1, var2) {}