/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3351.gsc
************************/

init() {
  level._effect["repulsor_view"] = loadfx("vfx\iw7\_requests\coop\zmb_repulsor_wave_view.vfx");
}

userepulsor() {
  var_00 = self getplayerangles();
  var_01 = anglestoup(var_00);
  var_02 = anglesToForward(var_00);
  var_03 = spawnfx(level._effect["repulsor_view"], self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles));
  triggerfx(var_03);
  var_03 thread scripts\cp\utility::delayentdelete(1);
  playrumbleonposition("slide_collision", self.origin);
  self earthquakeforplayer(0.5, 0.5, self.origin, 150);
  self playsoundonmovingent("equip_repulsor_wave");
  killenemiesinfov();
}

killenemiesinfov() {
  var_00 = cos(75);
  var_01 = 2000;
  var_02 = 300;
  var_03 = var_02 / 2;
  var_04 = vectornormalize(anglesToForward(self.angles));
  var_05 = var_04 * var_03;
  var_06 = self.origin + var_05;
  physicsexplosionsphere(var_06, var_03, 1, 2.5);
  var_07 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_08 = scripts\engine\utility::get_array_of_closest(self.origin, var_07, undefined, var_02);
  foreach(var_0A in var_08) {
    if(func_9C0D(var_0A)) {
      continue;
    }

    var_0B = 0;
    var_0C = var_0A.origin;
    var_0D = scripts\engine\utility::within_fov(self getEye(), self.angles, var_0C + (0, 0, 30), var_00);
    if(var_0D) {
      var_0E = distance2d(self.origin, var_0C);
      if(var_0E < var_02) {
        var_0B = 1;
      }
    }

    if(var_0B) {
      var_01 = var_0A.maxhealth;
      var_04 = anglesToForward(self.angles);
      var_0F = vectornormalize(var_04) * -100;
      var_0A setvelocity(vectornormalize(var_0A.origin - self.origin + var_0F) * 800 + (0, 0, 300));
      var_0A killrepulsorvictim(self, var_01, var_0C, self.origin);
    }
  }
}

func_9C0D(param_00) {
  if(scripts\engine\utility::istrue(param_00.var_9342)) {
    return 1;
  }

  return 0;
}

killrepulsorvictim(param_00, param_01, param_02, param_03) {
  self.do_immediate_ragdoll = 1;
  if(param_01 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(param_01, param_02, param_00, param_00, "MOD_IMPACT", "zom_repulsor_mp");
}