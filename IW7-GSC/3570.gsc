/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3570.gsc
************************/

init() {
  level.var_C7E4 = loadfx("vfx\core\mp\ability\vfx_aslt_overcharge_scrn");
  level.var_C7E5 = loadfx("vfx\core\mp\ability\vfx_aslt_overcharge_world_view");
}

func_F7AB() {
  self.powers["power_multiVisor"].var_1348E = 0;
  self.powers["power_multiVisor"].var_1348F[0] = "default";
  self.powers["power_multiVisor"].var_1348F[1] = "thermal";
  self.powers["power_multiVisor"].var_1348F[2] = "sitrep";
  self.powers["power_multiVisor"].var_1348F[3] = "phase";
  self.var_8BD7 = 0;
}

func_E13F() {
  self notify("removeMultiVisor");
  func_E12D();
}

func_130A7() {
  self endon("death");
  self endon("disconnect");
  self endon("removeMultiVisor");
  level endon("game_ended");
  thread func_E27E();
  var_0 = self.powers["power_multiVisor"];
  var_1 = self.powers["power_multiVisor"].var_1348E;
  var_2 = 4;
  func_E27F(var_1, var_2);
  scripts\engine\utility::waitframe();
  self.powers["power_multiVisor"].var_1348E = var_2;
  func_20D0();
  self notify("power_multi_visor_update", 0);
  self playlocalsound("mp_overcharge_on");
  thread func_BDCD();
  return 1;
}

func_BDCD() {
  self endon("death");
  self endon("disconnect");
  self endon("removemultivisor");
  var_0 = gettime() + 10000;
  while(var_0 > gettime()) {
    wait(0.05);
  }

  func_E27F(0, 4);
}

func_C5A5(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("removeMultiVisor");
  level endon("game_ended");
  switch (var_0) {
    case 0:
      self iprintlnbold("DEFAULT");
      break;

    case 1:
      self iprintlnbold("THERMAL");
      break;

    case 2:
      self iprintlnbold("SITREP");
      break;

    case 3:
      self iprintlnbold("PHASE");
      break;

    case 4:
      break;

    default:
      self iprintlnbold("DEFAULT");
      break;
  }
}

func_20C1(var_0) {
  self endon("multivisor_reset");
  self endon("death");
  self endon("disconnect");
  self endon("removeMultiVisor");
  thread func_E12D();
  self.var_8BD7 = 0;
}

func_20D0() {
  self endon("multivisor_reset");
  self endon("death");
  self endon("disconnect");
  self endon("removeMultiVisor");
  self thermalvisionon();
  thread func_20CE();
  if(!self.var_8BD7) {
    scripts\mp\utility::giveperk("specialty_detectexplosive");
  }

  self.var_8BD7 = 1;
  thread func_E88F();
}

func_20E1(var_0) {
  self endon("multivisor_reset");
  self endon("death");
  self endon("disconnect");
  self endon("removeMultiVisor");
  self thermalvisionon();
  thread func_20CE();
  self.var_8BD7 = 0;
}

func_20DB(var_0) {
  self endon("multivisor_reset");
  self endon("death");
  self endon("disconnect");
  self endon("removeMultiVisor");
  if(!self.var_8BD7) {
    scripts\mp\utility::giveperk("specialty_detectexplosive");
  }

  self.var_8BD7 = 1;
}

func_20D7(var_0) {
  self endon("multivisor_reset");
  self endon("death");
  self endon("disconnect");
  self endon("removeMultiVisor");
  self visionsetnakedforplayer("phase_shift_mp", 0);
  thread func_E88F();
  self.var_8BD7 = 0;
}

func_E88F() {
  self endon("death");
  self endon("disconnect");
  if(!isDefined(self.powers["power_multiVisor"])) {
    return;
  }

  while(self.powers["power_multiVisor"].var_1348E == 4) {
    foreach(var_1 in level.players) {
      if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_1)) {
        var_1 showtoplayer(self);
      }
    }

    wait(0.05);
  }

  foreach(var_1 in level.players) {
    if(scripts\mp\equipment\phase_shift::isentityphaseshifted(var_1)) {
      var_1 hidefromplayer(self);
    }
  }
}

func_E27F(var_0, var_1) {
  if(var_0 != var_1) {
    self thermalvisionoff();
    self visionsetnakedforplayer("", 0);
    if(self.var_8BD7) {
      scripts\mp\utility::removeperk("specialty_detectexplosive");
      self.var_8BD7 = 0;
    }

    func_E12D();
  }
}

func_E27E() {
  self endon("power_multi_visor_update");
  self waittill("death");
  self notify("multivisor_reset");
}

func_20CE() {
  self setclientomnvar("ui_multiVisorOverlay", 1);
}

func_E12D() {
  self setclientomnvar("ui_multiVisorOverlay", 0);
}