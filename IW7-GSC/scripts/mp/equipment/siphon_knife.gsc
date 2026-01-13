/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\siphon_knife.gsc
*************************************************/

func_10218() {}

func_1181D(var_0, var_1, var_2) {
  if(isDefined(var_2) && isDefined(var_1)) {
    if(isplayer(var_1) && var_1 != var_2) {
      if(!level.teambased || var_2.team != var_1.team) {
        var_2 thread func_10219(var_2);
        scripts\mp\lightarmor::setlightarmorvalue(var_2, var_2.maxhealth, 0);
      }
    }
  }

  var_2 thread func_10217(var_2, var_0);
  var_0 delete();
}

func_10219(var_0) {
  var_0 endon("death");
  var_0 endon("disconnect");
  var_0 thread func_1021A(var_0);
  var_0 notify("adrenaline_used");
  var_0 scripts\mp\utility::giveperk("specialty_adrenaline");
  wait(2);
  var_0 scripts\mp\utility::removeperk("specialty_adrenaline");
  var_0 notify("siphonKnife_regen_end");
}

func_1021A(var_0) {
  self endon("death");
  self endon("disconnect");
  self endon("siphonKnife_regen_end");
  if(!isDefined(var_0)) {
    return;
  }

  self playlocalsound("mp_overcharge_on");
  for(;;) {
    var_1 = playFX(scripts\engine\utility::getfx("siphonKnife_regenWorld"), self.origin + (0, 0, 25), anglesToForward(self.angles), anglestoup(self.angles));
    var_1 hidefromplayer(self);
    wait(0.1);
  }
}

func_10217(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 playlocalsound("bs_shield_explo");
  }

  var_1 playsoundtoteam("bs_shield_explo_npc", "axis", var_0);
  var_1 playsoundtoteam("bs_shield_explo_npc", "allies", var_0);
  playFX(scripts\engine\utility::getfx("siphonKnife_impactWorld"), var_1.origin, anglesToForward(var_1.angles), anglestoup(var_1.angles));
}