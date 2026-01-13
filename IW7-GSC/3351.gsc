/************************
 * Decompiled by Bog
 * Edited by SyndiShanX
 * Script: 3351.gsc
************************/

init() {
  level._effect["repulsor_view"] = loadfx("vfx\iw7\_requests\coop\zmb_repulsor_wave_view.vfx");
}

userepulsor() {
  var_0 = self getplayerangles();
  var_1 = anglestoup(var_0);
  var_2 = anglesToForward(var_0);
  var_3 = spawnfx(level._effect["repulsor_view"], self gettagorigin("tag_eye"), anglesToForward(self.angles), anglestoup(self.angles));
  triggerfx(var_3);
  var_3 thread scripts\cp\utility::delayentdelete(1);
  playrumbleonposition("slide_collision", self.origin);
  self earthquakeforplayer(0.5, 0.5, self.origin, 150);
  self playsoundonmovingent("equip_repulsor_wave");
  killenemiesinfov();
}

killenemiesinfov() {
  var_0 = cos(75);
  var_1 = 2000;
  var_2 = 300;
  var_3 = var_2 / 2;
  var_4 = vectornormalize(anglesToForward(self.angles));
  var_5 = var_4 * var_3;
  var_6 = self.origin + var_5;
  physicsexplosionsphere(var_6, var_3, 1, 2.5);
  var_7 = scripts\cp\cp_agent_utils::getaliveagentsofteam("axis");
  var_8 = scripts\engine\utility::get_array_of_closest(self.origin, var_7, undefined, var_2);
  foreach(var_0A in var_8) {
    if(func_9C0D(var_0A)) {
      continue;
    }

    var_0B = 0;
    var_0C = var_0A.origin;
    var_0D = scripts\engine\utility::within_fov(self getEye(), self.angles, var_0C + (0, 0, 30), var_0);
    if(var_0D) {
      var_0E = distance2d(self.origin, var_0C);
      if(var_0E < var_2) {
        var_0B = 1;
      }
    }

    if(var_0B) {
      var_1 = var_0A.maxhealth;
      var_4 = anglesToForward(self.angles);
      var_0F = vectornormalize(var_4) * -100;
      var_0A setvelocity(vectornormalize(var_0A.origin - self.origin + var_0F) * 800 + (0, 0, 300));
      var_0A killrepulsorvictim(self, var_1, var_0C, self.origin);
    }
  }
}

func_9C0D(var_0) {
  if(scripts\engine\utility::istrue(var_0.var_9342)) {
    return 1;
  }

  return 0;
}

killrepulsorvictim(var_0, var_1, var_2, var_3) {
  self.do_immediate_ragdoll = 1;
  if(var_1 >= self.health) {
    self.customdeath = 1;
  }

  self dodamage(var_1, var_2, var_0, var_0, "MOD_IMPACT", "zom_repulsor_mp");
}