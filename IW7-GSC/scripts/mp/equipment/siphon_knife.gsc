/*************************************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: scripts\mp\equipment\siphon_knife.gsc
*************************************************/

func_10218() {}

func_1181D(param_00, param_01, param_02) {
  if(isDefined(param_02) && isDefined(param_01)) {
    if(isplayer(param_01) && param_01 != param_02) {
      if(!level.teambased || param_02.team != param_01.team) {
        param_02 thread func_10219(param_02);
        scripts\mp\lightarmor::setlightarmorvalue(param_02, param_02.maxhealth, 0);
      }
    }
  }

  param_02 thread func_10217(param_02, param_00);
  param_00 delete();
}

func_10219(param_00) {
  param_00 endon("death");
  param_00 endon("disconnect");
  param_00 thread func_1021A(param_00);
  param_00 notify("adrenaline_used");
  param_00 scripts\mp\utility::giveperk("specialty_adrenaline");
  wait(2);
  param_00 scripts\mp\utility::removeperk("specialty_adrenaline");
  param_00 notify("siphonKnife_regen_end");
}

func_1021A(param_00) {
  self endon("death");
  self endon("disconnect");
  self endon("siphonKnife_regen_end");
  if(!isDefined(param_00)) {
    return;
  }

  self playlocalsound("mp_overcharge_on");
  for(;;) {
    var_01 = playFX(scripts\engine\utility::getfx("siphonKnife_regenWorld"), self.origin + (0, 0, 25), anglesToForward(self.angles), anglestoup(self.angles));
    var_01 hidefromplayer(self);
    wait(0.1);
  }
}

func_10217(param_00, param_01) {
  if(isDefined(param_00)) {
    param_00 playlocalsound("bs_shield_explo");
  }

  param_01 playsoundtoteam("bs_shield_explo_npc", "axis", param_00);
  param_01 playsoundtoteam("bs_shield_explo_npc", "allies", param_00);
  playFX(scripts\engine\utility::getfx("siphonKnife_impactWorld"), param_01.origin, anglesToForward(param_01.angles), anglestoup(param_01.angles));
}