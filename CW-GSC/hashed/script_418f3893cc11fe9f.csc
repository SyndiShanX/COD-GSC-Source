/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_418f3893cc11fe9f.csc
***********************************************/

#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\footsteps_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\postfx_shared;
#using scripts\core_common\util_shared;
#namespace namespace_a204c0f4;

function init() {
  function_cae618b4("spawner_zombietron_margwa");
  clientfield::register("actor", "margwa_head_left", 1, 2, "int", &function_7f774ede, 0, 0);
  clientfield::register("actor", "margwa_head_mid", 1, 2, "int", &function_a99ba434, 0, 0);
  clientfield::register("actor", "margwa_head_right", 1, 2, "int", &function_e579d5d9, 0, 0);
  clientfield::register("actor", "margwa_fx_in", 1, 1, "counter", &function_39ef8b74, 0, 0);
  clientfield::register("actor", "margwa_fx_out", 1, 1, "counter", &function_9604ce8a, 0, 0);
  clientfield::register("actor", "margwa_fx_spawn", 1, 1, "counter", &function_3037d1ec, 0, 0);
  clientfield::register("actor", "margwa_smash", 1, 1, "counter", &function_a3a09c93, 0, 0);
  clientfield::register("actor", "margwa_head_left_hit", 1, 1, "counter", &function_d1df36a2, 0, 0);
  clientfield::register("actor", "margwa_head_mid_hit", 1, 1, "counter", &function_751de3f8, 0, 0);
  clientfield::register("actor", "margwa_head_right_hit", 1, 1, "counter", &function_1d106112, 0, 0);
  clientfield::register("actor", "margwa_head_killed", 1, 2, "int", &function_5a1be0a8, 0, 0);
  clientfield::register("actor", "margwa_jaw", 1, 6, "int", &function_8cba01dd, 0, 0);
  clientfield::register("toplayer", "margwa_head_explosion", 1, 1, "counter", &function_c8b15a9b, 0, 0);
  clientfield::register("scriptmover", "margwa_fx_travel", 1, 1, "int", &function_1b421769, 0, 0);
  clientfield::register("scriptmover", "margwa_fx_travel_tell", 1, 1, "int", &function_4a696f55, 0, 0);
  clientfield::register("actor", "supermargwa", 1, 1, "int", undefined, 0, 0);
  ai::add_archetype_spawn_function(#"margwa", &function_9874b8cd);
  level.var_c54efd75 = [];
  level.var_c54efd75[1] = "idle_1";
  level.var_c54efd75[3] = "idle_pain_head_l_explode";
  level.var_c54efd75[4] = "idle_pain_head_m_explode";
  level.var_c54efd75[5] = "idle_pain_head_r_explode";
  level.var_c54efd75[6] = "react_stun";
  level.var_c54efd75[8] = "react_idgun";
  level.var_c54efd75[9] = "react_idgun_pack";
  level.var_c54efd75[7] = "run_charge_f";
  level.var_c54efd75[13] = "run_f";
  level.var_c54efd75[14] = "smash_attack_1";
  level.var_c54efd75[15] = "swipe";
  level.var_c54efd75[16] = "swipe_player";
  level.var_c54efd75[17] = "teleport_in";
  level.var_c54efd75[18] = "teleport_out";
  level.var_c54efd75[19] = "trv_jump_across_256";
  level.var_c54efd75[20] = "trv_jump_down_128";
  level.var_c54efd75[21] = "trv_jump_down_36";
  level.var_c54efd75[22] = "trv_jump_down_96";
  level.var_c54efd75[23] = "trv_jump_up_128";
  level.var_c54efd75[24] = "trv_jump_up_36";
  level.var_c54efd75[25] = "trv_jump_up_96";
  level._effect[#"fx_margwa_teleport_zod_zmb"] = "zombie/fx_margwa_teleport_zod_zmb";
  level._effect[#"fx_margwa_teleport_travel_zod_zmb"] = "zombie/fx_margwa_teleport_travel_zod_zmb";
  level._effect[#"fx_margwa_teleport_tell_zod_zmb"] = "zombie/fx_margwa_teleport_tell_zod_zmb";
  level._effect[#"fx_margwa_teleport_intro_zod_zmb"] = "zombie/fx_margwa_teleport_intro_zod_zmb";
  level._effect[#"fx_margwa_head_shot_zod_zmb"] = "zombie/fx_margwa_head_shot_zod_zmb";
  level._effect[#"fx_margwa_roar_zod_zmb"] = "zombie/fx_margwa_roar_zod_zmb";
  level._effect[#"fx_margwa_roar_purple_zod_zmb"] = "zombie/fx_margwa_roar_purple_zod_zmb";
  footsteps::registeraitypefootstepcb(#"margwa", &function_d96c49e7);
}

function private function_9874b8cd(localclientnum) {
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  self setanim(#"ai_margwa_head_l_closed_add", 1, 0.2, 1);
  self setanim(#"ai_margwa_head_m_closed_add", 1, 0.2, 1);
  self setanim(#"ai_margwa_head_r_closed_add", 1, 0.2, 1);

  for(i = 1; i <= 7; i++) {
    var_25dd550a = # "hash_3aa340cf7e8075f0" + i;
    var_43aa83b8 = # "hash_79ffdacfeb1dcc9e" + i;
    self setanim(var_25dd550a, 1, 0.2, 1);
    self setanim(var_43aa83b8, 1, 0.2, 1);
  }

  self.heads = [];
  self.heads[1] = spawnStruct();
  self.heads[1].index = 1;
  self.heads[1].var_90d98881 = # "ai_margwa_head_l_closed_add";
  self.heads[1].var_64883f29 = "ai_margwa_jaw_l_";
  self.heads[2] = spawnStruct();
  self.heads[2].index = 2;
  self.heads[2].var_90d98881 = # "ai_margwa_head_m_closed_add";
  self.heads[2].var_64883f29 = "ai_margwa_jaw_m_";
  self.heads[3] = spawnStruct();
  self.heads[3].index = 3;
  self.heads[3].var_90d98881 = # "ai_margwa_head_r_closed_add";
  self.heads[3].var_64883f29 = "ai_margwa_jaw_r_";
}

function private function_7f774ede(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.var_fd694760)) {
    stopfx(fieldname, self.var_fd694760);
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self) || !isDefined(self.heads)) {
    return;
  }

  switch (wasdemojump) {
    case 1:
      self.heads[1].var_90d98881 = # "ai_margwa_head_l_open_add";
      self setanim(#"ai_margwa_head_l_open_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_l_closed_add", 0.1);
      var_60a180bc = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.var_f61e3379)) {
        var_60a180bc = self.var_f61e3379;
      }

      if(self clientfield::get("supermargwa")) {
        self.var_fd694760 = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_left");
      } else {
        self.var_fd694760 = util::playFXOnTag(fieldname, var_60a180bc, self, "tag_head_left");
      }

      break;
    case 2:
      self.heads[1].var_90d98881 = # "ai_margwa_head_l_closed_add";
      self setanim(#"ai_margwa_head_l_closed_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_l_open_add", 0.1);
      self clearanim(#"ai_margwa_head_l_smash_attack_1", 0.1);
      break;
    case 3:
      self.heads[1].var_90d98881 = # "ai_margwa_head_l_smash_attack_1";
      self clearanim(#"ai_margwa_head_l_open_add", 0.1);
      self clearanim(#"ai_margwa_head_l_closed_add", 0.1);
      self setanimrestart(#"ai_margwa_head_l_smash_attack_1", 1, 0.1, 1);
      var_60a180bc = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.var_f61e3379)) {
        var_60a180bc = self.var_f61e3379;
      }

      if(self clientfield::get("supermargwa")) {
        self.var_fd694760 = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_left");
      } else {
        self.var_fd694760 = util::playFXOnTag(fieldname, var_60a180bc, self, "tag_head_left");
      }

      self thread function_bb0ffabc(fieldname);
      break;
  }
}

function private function_a99ba434(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.var_694b6f)) {
    stopfx(fieldname, self.var_694b6f);
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  switch (wasdemojump) {
    case 1:
      self setanim(#"ai_margwa_head_m_open_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_m_closed_add", 0.1);
      var_60a180bc = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.var_f61e3379)) {
        var_60a180bc = self.var_f61e3379;
      }

      if(self clientfield::get("supermargwa")) {
        self.var_694b6f = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_mid");
      } else {
        self.var_694b6f = util::playFXOnTag(fieldname, var_60a180bc, self, "tag_head_mid");
      }

      break;
    case 2:
      self setanim(#"ai_margwa_head_m_closed_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_m_open_add", 0.1);
      self clearanim(#"ai_margwa_head_m_smash_attack_1", 0.1);
      break;
    case 3:
      self clearanim(#"ai_margwa_head_m_open_add", 0.1);
      self clearanim(#"ai_margwa_head_m_closed_add", 0.1);
      self setanimrestart(#"ai_margwa_head_m_smash_attack_1", 1, 0.1, 1);
      var_60a180bc = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.var_f61e3379)) {
        var_60a180bc = self.var_f61e3379;
      }

      if(self clientfield::get("supermargwa")) {
        self.var_694b6f = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_mid");
      } else {
        self.var_694b6f = util::playFXOnTag(fieldname, var_60a180bc, self, "tag_head_mid");
      }

      self thread function_bb0ffabc(fieldname);
      break;
  }
}

function private function_e579d5d9(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.var_f254784b)) {
    stopfx(fieldname, self.var_f254784b);
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  switch (wasdemojump) {
    case 1:
      self setanim(#"ai_margwa_head_r_open_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_r_closed_add", 0.1);
      var_60a180bc = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.var_f61e3379)) {
        var_60a180bc = self.var_f61e3379;
      }

      if(self clientfield::get("supermargwa")) {
        self.var_f254784b = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_right");
      } else {
        self.var_f254784b = util::playFXOnTag(fieldname, var_60a180bc, self, "tag_head_right");
      }

      break;
    case 2:
      self setanim(#"ai_margwa_head_r_closed_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_r_open_add", 0.1);
      self clearanim(#"ai_margwa_head_r_smash_attack_1", 0.1);
      break;
    case 3:
      self clearanim(#"ai_margwa_head_r_open_add", 0.1);
      self clearanim(#"ai_margwa_head_r_closed_add", 0.1);
      self setanimrestart(#"ai_margwa_head_r_smash_attack_1", 1, 0.1, 1);
      var_60a180bc = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.var_f61e3379)) {
        var_60a180bc = self.var_f61e3379;
      }

      if(self clientfield::get("supermargwa")) {
        self.var_f254784b = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_right");
      } else {
        self.var_f254784b = util::playFXOnTag(fieldname, var_60a180bc, self, "tag_head_right");
      }

      self thread function_bb0ffabc(fieldname);
      break;
  }
}

function private function_bb0ffabc(localclientnum) {
  self endon(#"death");
  wait 0.6;

  if(isDefined(self.var_fd694760)) {
    stopfx(localclientnum, self.var_fd694760);
  }

  if(isDefined(self.var_694b6f)) {
    stopfx(localclientnum, self.var_694b6f);
  }

  if(isDefined(self.var_f254784b)) {
    stopfx(localclientnum, self.var_f254784b);
  }
}

function private function_39ef8b74(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    self.var_f2f751dd = playFX(fieldname, level._effect[#"fx_margwa_teleport_zod_zmb"], self gettagorigin("j_spine_1"));
  }
}

function private function_9604ce8a(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    tagpos = self gettagorigin("j_spine_1");
    self.var_e6a4bc80 = playFX(fieldname, level._effect[#"fx_margwa_teleport_zod_zmb"], tagpos);
  }
}

function private function_1b421769(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (wasdemojump) {
    case 0:
      deletefx(fieldname, self.var_3e71124a);
      break;
    case 1:
      self.var_3e71124a = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_teleport_travel_zod_zmb"], self, "tag_origin");
      break;
  }
}

function private function_4a696f55(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (wasdemojump) {
    case 0:
      deletefx(fieldname, self.var_598f22c4);
      self notify(#"hash_3ad013815bda7968");
      break;
    case 1:
      self.var_598f22c4 = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_teleport_tell_zod_zmb"], self, "tag_origin");
      self thread function_bc09ffc1(fieldname);
      break;
  }
}

function function_bc09ffc1(localclientnum) {
  self notify(#"hash_3ad013815bda7968");
  self endon(#"hash_3ad013815bda7968");
  self endon(#"death");
  player = function_5c10bd79(localclientnum);

  while(true) {
    if(isDefined(player)) {
      dist_sq = distancesquared(player.origin, self.origin);

      if(dist_sq < 1000000) {
        player playrumbleonentity(localclientnum, "tank_rumble");
      }
    }

    waitframe(1);
  }
}

function private function_3037d1ec(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    spawnfx = level._effect[#"fx_margwa_teleport_intro_zod_zmb"];

    if(isDefined(self.var_c525a905)) {
      spawnfx = self.var_c525a905;
    }

    self.spawnfx = playFX(fieldname, spawnfx, self gettagorigin("j_spine_1"));
    playSound(0, #"hash_376c0791744acc6a", self gettagorigin("j_spine_1"));
  }
}

function private function_c8b15a9b(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    self postfx::playpostfxbundle(#"hash_1a330df4b4188375");
  }
}

function function_d96c49e7(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(notetrack);
  n_dist = distancesquared(bone, e_player.origin);
  var_d55585a1 = getdvarint(#"hash_b2a0736c2b88fda", 1000) * getdvarint(#"hash_b2a0736c2b88fda", 1000);

  if(var_d55585a1 > 0) {
    n_scale = (var_d55585a1 - n_dist) / var_d55585a1;
  } else {
    return;
  }

  if(n_scale > 1 || n_scale < 0) {
    return;
  }

  n_scale *= 0.25;

  if(n_scale <= 0.01) {
    return;
  }

  earthquake(notetrack, n_scale, 0.1, bone, n_dist);

  if(n_scale <= 0.25 && n_scale > 0.2) {
    function_36e4ebd4(notetrack, "shotgun_fire");
    return;
  }

  if(n_scale <= 0.2 && n_scale > 0.1) {
    function_36e4ebd4(notetrack, "damage_heavy");
    return;
  }

  function_36e4ebd4(notetrack, "reload_small");
}

function private function_a3a09c93(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    e_player = function_5c10bd79(fieldname);
    var_9f06b4e9 = self.origin + vectorscale(anglesToForward(self.angles), 60);
    distsq = distancesquared(var_9f06b4e9, e_player.origin);

    if(distsq < 20736) {
      earthquake(fieldname, 0.7, 0.25, e_player.origin, 3000);
      function_36e4ebd4(fieldname, "shotgun_fire");
      return;
    }

    if(distsq < 36864) {
      earthquake(fieldname, 0.7, 0.25, e_player.origin, 1500);
      function_36e4ebd4(fieldname, "damage_heavy");
    }
  }
}

function private function_d1df36a2(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    effect = level._effect[#"fx_margwa_head_shot_zod_zmb"];

    if(isDefined(self.var_7526e3c3)) {
      effect = self.var_7526e3c3;
    }

    self.var_7f006628 = util::playFXOnTag(fieldname, effect, self, "tag_head_left");
  }
}

function private function_751de3f8(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    effect = level._effect[#"fx_margwa_head_shot_zod_zmb"];

    if(isDefined(self.var_7526e3c3)) {
      effect = self.var_7526e3c3;
    }

    self.var_a0288d14 = util::playFXOnTag(fieldname, effect, self, "tag_head_mid");
  }
}

function private function_1d106112(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    effect = level._effect[#"fx_margwa_head_shot_zod_zmb"];

    if(isDefined(self.var_7526e3c3)) {
      effect = self.var_7526e3c3;
    }

    self.var_752b722d = util::playFXOnTag(fieldname, effect, self, "tag_head_right");
  }
}

function private function_5a1be0a8(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump && isDefined(self.heads) && isDefined(self.heads[wasdemojump])) {
    self.heads[wasdemojump].killed = 1;
  }
}

function private function_8cba01dd(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    foreach(head in self.heads) {
      if(is_true(head.killed)) {
        if(isDefined(head.var_3cdae679)) {
          self clearanim(head.var_3cdae679, 0.2);
        }

        if(isDefined(head.var_90d98881)) {
          self clearanim(head.var_90d98881, 0.1);
        }

        var_cd3a4460 = head.var_64883f29 + level.var_c54efd75[wasdemojump];
        head.var_3cdae679 = var_cd3a4460;
        self setanim(var_cd3a4460, 1, 0.2, 1);
      }
    }
  }
}