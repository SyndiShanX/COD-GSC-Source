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
  clientfield::register("actor", "margwa_head_left", 1, 2, "int", &margwaheadleftcallback, 0, 0);
  clientfield::register("actor", "margwa_head_mid", 1, 2, "int", &margwaheadmidcallback, 0, 0);
  clientfield::register("actor", "margwa_head_right", 1, 2, "int", &margwaheadrightcallback, 0, 0);
  clientfield::register("actor", "margwa_fx_in", 1, 1, "counter", &margwafxincallback, 0, 0);
  clientfield::register("actor", "margwa_fx_out", 1, 1, "counter", &margwafxoutcallback, 0, 0);
  clientfield::register("actor", "margwa_fx_spawn", 1, 1, "counter", &margwafxspawncallback, 0, 0);
  clientfield::register("actor", "margwa_smash", 1, 1, "counter", &margwasmashcallback, 0, 0);
  clientfield::register("actor", "margwa_head_left_hit", 1, 1, "counter", &margwalefthitcallback, 0, 0);
  clientfield::register("actor", "margwa_head_mid_hit", 1, 1, "counter", &margwamidhitcallback, 0, 0);
  clientfield::register("actor", "margwa_head_right_hit", 1, 1, "counter", &margwarighthitcallback, 0, 0);
  clientfield::register("actor", "margwa_head_killed", 1, 2, "int", &margwaheadkilledcallback, 0, 0);
  clientfield::register("actor", "margwa_jaw", 1, 6, "int", &margwajawcallback, 0, 0);
  clientfield::register("toplayer", "margwa_head_explosion", 1, 1, "counter", &margwaheadexplosion, 0, 0);
  clientfield::register("scriptmover", "margwa_fx_travel", 1, 1, "int", &margwafxtravelcallback, 0, 0);
  clientfield::register("scriptmover", "margwa_fx_travel_tell", 1, 1, "int", &margwafxtraveltellcallback, 0, 0);
  clientfield::register("actor", "supermargwa", 1, 1, "int", undefined, 0, 0);
  ai::add_archetype_spawn_function(#"margwa", &margwaspawn);
  level._jaw = [];
  level._jaw[1] = "idle_1";
  level._jaw[3] = "idle_pain_head_l_explode";
  level._jaw[4] = "idle_pain_head_m_explode";
  level._jaw[5] = "idle_pain_head_r_explode";
  level._jaw[6] = "react_stun";
  level._jaw[8] = "react_idgun";
  level._jaw[9] = "react_idgun_pack";
  level._jaw[7] = "run_charge_f";
  level._jaw[13] = "run_f";
  level._jaw[14] = "smash_attack_1";
  level._jaw[15] = "swipe";
  level._jaw[16] = "swipe_player";
  level._jaw[17] = "teleport_in";
  level._jaw[18] = "teleport_out";
  level._jaw[19] = "trv_jump_across_256";
  level._jaw[20] = "trv_jump_down_128";
  level._jaw[21] = "trv_jump_down_36";
  level._jaw[22] = "trv_jump_down_96";
  level._jaw[23] = "trv_jump_up_128";
  level._jaw[24] = "trv_jump_up_36";
  level._jaw[25] = "trv_jump_up_96";
  level._effect[#"fx_margwa_teleport_zod_zmb"] = "zombie/fx_margwa_teleport_zod_zmb";
  level._effect[#"fx_margwa_teleport_travel_zod_zmb"] = "zombie/fx_margwa_teleport_travel_zod_zmb";
  level._effect[#"fx_margwa_teleport_tell_zod_zmb"] = "zombie/fx_margwa_teleport_tell_zod_zmb";
  level._effect[#"fx_margwa_teleport_intro_zod_zmb"] = "zombie/fx_margwa_teleport_intro_zod_zmb";
  level._effect[#"fx_margwa_head_shot_zod_zmb"] = "zombie/fx_margwa_head_shot_zod_zmb";
  level._effect[#"fx_margwa_roar_zod_zmb"] = "zombie/fx_margwa_roar_zod_zmb";
  level._effect[#"fx_margwa_roar_purple_zod_zmb"] = "zombie/fx_margwa_roar_purple_zod_zmb";
  footsteps::registeraitypefootstepcb(#"margwa", &margwaprocessfootstep);
}

function private margwaspawn(localclientnum) {
  self util::waittill_dobj(localclientnum);

  if(!isDefined(self)) {
    return;
  }

  self setanim(#"ai_margwa_head_l_closed_add", 1, 0.2, 1);
  self setanim(#"ai_margwa_head_m_closed_add", 1, 0.2, 1);
  self setanim(#"ai_margwa_head_r_closed_add", 1, 0.2, 1);

  for(i = 1; i <= 7; i++) {
    lefttentacle = #"ai_margwa_tentacle_l_0" + i;
    righttentacle = #"ai_margwa_tentacle_r_0" + i;
    self setanim(lefttentacle, 1, 0.2, 1);
    self setanim(righttentacle, 1, 0.2, 1);
  }

  self.heads = [];
  self.heads[1] = spawnStruct();
  self.heads[1].index = 1;
  self.heads[1].prevheadanim = #"ai_margwa_head_l_closed_add";
  self.heads[1].jawbase = "ai_margwa_jaw_l_";
  self.heads[2] = spawnStruct();
  self.heads[2].index = 2;
  self.heads[2].prevheadanim = #"ai_margwa_head_m_closed_add";
  self.heads[2].jawbase = "ai_margwa_jaw_m_";
  self.heads[3] = spawnStruct();
  self.heads[3].index = 3;
  self.heads[3].prevheadanim = #"ai_margwa_head_r_closed_add";
  self.heads[3].jawbase = "ai_margwa_jaw_r_";
}

function private margwaheadleftcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.leftglowfx)) {
    stopfx(fieldname, self.leftglowfx);
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self) || !isDefined(self.heads)) {
    return;
  }

  switch (wasdemojump) {
    case 1:
      self.heads[1].prevheadanim = #"ai_margwa_head_l_open_add";
      self setanim(#"ai_margwa_head_l_open_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_l_closed_add", 0.1);
      roar_effect = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }

      if(self clientfield::get("supermargwa")) {
        self.leftglowfx = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_left");
      } else {
        self.leftglowfx = util::playFXOnTag(fieldname, roar_effect, self, "tag_head_left");
      }

      break;
    case 2:
      self.heads[1].prevheadanim = #"ai_margwa_head_l_closed_add";
      self setanim(#"ai_margwa_head_l_closed_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_l_open_add", 0.1);
      self clearanim(#"ai_margwa_head_l_smash_attack_1", 0.1);
      break;
    case 3:
      self.heads[1].prevheadanim = #"ai_margwa_head_l_smash_attack_1";
      self clearanim(#"ai_margwa_head_l_open_add", 0.1);
      self clearanim(#"ai_margwa_head_l_closed_add", 0.1);
      self setanimrestart(#"ai_margwa_head_l_smash_attack_1", 1, 0.1, 1);
      roar_effect = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }

      if(self clientfield::get("supermargwa")) {
        self.leftglowfx = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_left");
      } else {
        self.leftglowfx = util::playFXOnTag(fieldname, roar_effect, self, "tag_head_left");
      }

      self thread margwastopsmashfx(fieldname);
      break;
  }
}

function private margwaheadmidcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.midglowfx)) {
    stopfx(fieldname, self.midglowfx);
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  switch (wasdemojump) {
    case 1:
      self setanim(#"ai_margwa_head_m_open_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_m_closed_add", 0.1);
      roar_effect = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }

      if(self clientfield::get("supermargwa")) {
        self.midglowfx = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_mid");
      } else {
        self.midglowfx = util::playFXOnTag(fieldname, roar_effect, self, "tag_head_mid");
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
      roar_effect = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }

      if(self clientfield::get("supermargwa")) {
        self.midglowfx = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_mid");
      } else {
        self.midglowfx = util::playFXOnTag(fieldname, roar_effect, self, "tag_head_mid");
      }

      self thread margwastopsmashfx(fieldname);
      break;
  }
}

function private margwaheadrightcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.rightglowfx)) {
    stopfx(fieldname, self.rightglowfx);
  }

  self util::waittill_dobj(fieldname);

  if(!isDefined(self)) {
    return;
  }

  switch (wasdemojump) {
    case 1:
      self setanim(#"ai_margwa_head_r_open_add", 1, 0.1, 1);
      self clearanim(#"ai_margwa_head_r_closed_add", 0.1);
      roar_effect = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }

      if(self clientfield::get("supermargwa")) {
        self.rightglowfx = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_right");
      } else {
        self.rightglowfx = util::playFXOnTag(fieldname, roar_effect, self, "tag_head_right");
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
      roar_effect = level._effect[#"fx_margwa_roar_zod_zmb"];

      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }

      if(self clientfield::get("supermargwa")) {
        self.rightglowfx = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_roar_purple_zod_zmb"], self, "tag_head_right");
      } else {
        self.rightglowfx = util::playFXOnTag(fieldname, roar_effect, self, "tag_head_right");
      }

      self thread margwastopsmashfx(fieldname);
      break;
  }
}

function private margwastopsmashfx(localclientnum) {
  self endon(#"death");
  wait 0.6;

  if(isDefined(self.leftglowfx)) {
    stopfx(localclientnum, self.leftglowfx);
  }

  if(isDefined(self.midglowfx)) {
    stopfx(localclientnum, self.midglowfx);
  }

  if(isDefined(self.rightglowfx)) {
    stopfx(localclientnum, self.rightglowfx);
  }
}

function private margwafxincallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    self.teleportfxin = playFX(fieldname, level._effect[#"fx_margwa_teleport_zod_zmb"], self gettagorigin("j_spine_1"));
  }
}

function private margwafxoutcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    tagpos = self gettagorigin("j_spine_1");
    self.teleportfxout = playFX(fieldname, level._effect[#"fx_margwa_teleport_zod_zmb"], tagpos);
  }
}

function private margwafxtravelcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (wasdemojump) {
    case 0:
      deletefx(fieldname, self.travelerfx);
      break;
    case 1:
      self.travelerfx = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_teleport_travel_zod_zmb"], self, "tag_origin");
      break;
  }
}

function private margwafxtraveltellcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (wasdemojump) {
    case 0:
      deletefx(fieldname, self.travelertellfx);
      self notify(#"stop_margwatraveltell");
      break;
    case 1:
      self.travelertellfx = util::playFXOnTag(fieldname, level._effect[#"fx_margwa_teleport_tell_zod_zmb"], self, "tag_origin");
      self thread margwatraveltellupdate(fieldname);
      break;
  }
}

function margwatraveltellupdate(localclientnum) {
  self notify(#"stop_margwatraveltell");
  self endon(#"stop_margwatraveltell");
  self endon(#"death");
  player = function_5c10bd79(localclientnum);

  while(true) {
    if(isDefined(player)) {
      dist_sq = distancesquared(player.origin, self.origin);

      if(dist_sq < 1000000) {
        player playRumbleOnEntity(localclientnum, "tank_rumble");
      }
    }

    waitframe(1);
  }
}

function private margwafxspawncallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    spawnfx = level._effect[#"fx_margwa_teleport_intro_zod_zmb"];

    if(isDefined(self.margwa_spawn_effect)) {
      spawnfx = self.margwa_spawn_effect;
    }

    self.spawnfx = playFX(fieldname, spawnfx, self gettagorigin("j_spine_1"));
    playSound(0, #"zmb_margwa_spawn", self gettagorigin("j_spine_1"));
  }
}

function private margwaheadexplosion(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    self postfx::playpostfxbundle(#"pstfx_parasite_dmg");
  }
}

function margwaprocessfootstep(localclientnum, pos, surface, notetrack, bone) {
  e_player = function_5c10bd79(notetrack);
  n_dist = distancesquared(bone, e_player.origin);
  n_margwa_dist = getdvarint(#"scr_margwa_footstep_eq_radius", 1000) * getdvarint(#"scr_margwa_footstep_eq_radius", 1000);

  if(n_margwa_dist > 0) {
    n_scale = (n_margwa_dist - n_dist) / n_margwa_dist;
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

function private margwasmashcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    e_player = function_5c10bd79(fieldname);
    smashpos = self.origin + vectorscale(anglesToForward(self.angles), 60);
    distsq = distancesquared(smashpos, e_player.origin);

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

function private margwalefthitcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    effect = level._effect[#"fx_margwa_head_shot_zod_zmb"];

    if(isDefined(self.margwa_head_hit_fx)) {
      effect = self.margwa_head_hit_fx;
    }

    self.lefthitfx = util::playFXOnTag(fieldname, effect, self, "tag_head_left");
  }
}

function private margwamidhitcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    effect = level._effect[#"fx_margwa_head_shot_zod_zmb"];

    if(isDefined(self.margwa_head_hit_fx)) {
      effect = self.margwa_head_hit_fx;
    }

    self.midhitfx = util::playFXOnTag(fieldname, effect, self, "tag_head_mid");
  }
}

function private margwarighthitcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    effect = level._effect[#"fx_margwa_head_shot_zod_zmb"];

    if(isDefined(self.margwa_head_hit_fx)) {
      effect = self.margwa_head_hit_fx;
    }

    self.righthitfx = util::playFXOnTag(fieldname, effect, self, "tag_head_right");
  }
}

function private margwaheadkilledcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump && isDefined(self.heads) && isDefined(self.heads[wasdemojump])) {
    self.heads[wasdemojump].killed = 1;
  }
}

function private margwajawcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(wasdemojump) {
    foreach(head in self.heads) {
      if(is_true(head.killed)) {
        if(isDefined(head.prevjawanim)) {
          self clearanim(head.prevjawanim, 0.2);
        }

        if(isDefined(head.prevheadanim)) {
          self clearanim(head.prevheadanim, 0.1);
        }

        jawanim = head.jawbase + level._jaw[wasdemojump];
        head.prevjawanim = jawanim;
        self setanim(jawanim, 1, 0.2, 1);
      }
    }
  }
}