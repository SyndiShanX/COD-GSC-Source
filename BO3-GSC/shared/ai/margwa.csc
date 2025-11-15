/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: shared\ai\margwa.csc
*************************************************/

#using scripts\shared\ai_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\util_shared;
#using_animtree("generic");
#namespace margwa;

function autoexec main() {
  clientfield::register("actor", "margwa_head_left", 1, 2, "int", & margwaclientutils::margwaheadleftcallback, 0, 0);
  clientfield::register("actor", "margwa_head_mid", 1, 2, "int", & margwaclientutils::margwaheadmidcallback, 0, 0);
  clientfield::register("actor", "margwa_head_right", 1, 2, "int", & margwaclientutils::margwaheadrightcallback, 0, 0);
  clientfield::register("actor", "margwa_fx_in", 1, 1, "counter", & margwaclientutils::margwafxincallback, 0, 0);
  clientfield::register("actor", "margwa_fx_out", 1, 1, "counter", & margwaclientutils::margwafxoutcallback, 0, 0);
  clientfield::register("actor", "margwa_fx_spawn", 1, 1, "counter", & margwaclientutils::margwafxspawncallback, 0, 0);
  clientfield::register("actor", "margwa_smash", 1, 1, "counter", & margwaclientutils::margwasmashcallback, 0, 0);
  clientfield::register("actor", "margwa_head_left_hit", 1, 1, "counter", & margwaclientutils::margwalefthitcallback, 0, 0);
  clientfield::register("actor", "margwa_head_mid_hit", 1, 1, "counter", & margwaclientutils::margwamidhitcallback, 0, 0);
  clientfield::register("actor", "margwa_head_right_hit", 1, 1, "counter", & margwaclientutils::margwarighthitcallback, 0, 0);
  clientfield::register("actor", "margwa_head_killed", 1, 2, "int", & margwaclientutils::margwaheadkilledcallback, 0, 0);
  clientfield::register("actor", "margwa_jaw", 1, 6, "int", & margwaclientutils::margwajawcallback, 0, 0);
  clientfield::register("toplayer", "margwa_head_explosion", 1, 1, "counter", & margwaclientutils::margwaheadexplosion, 0, 0);
  clientfield::register("scriptmover", "margwa_fx_travel", 1, 1, "int", & margwaclientutils::margwafxtravelcallback, 0, 0);
  clientfield::register("scriptmover", "margwa_fx_travel_tell", 1, 1, "int", & margwaclientutils::margwafxtraveltellcallback, 0, 0);
  clientfield::register("actor", "supermargwa", 1, 1, "int", undefined, 0, 0);
  ai::add_archetype_spawn_function("margwa", & margwaclientutils::margwaspawn);
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
}

function autoexec precache() {
  level._effect["fx_margwa_teleport_zod_zmb"] = "zombie/fx_margwa_teleport_zod_zmb";
  level._effect["fx_margwa_teleport_travel_zod_zmb"] = "zombie/fx_margwa_teleport_travel_zod_zmb";
  level._effect["fx_margwa_teleport_tell_zod_zmb"] = "zombie/fx_margwa_teleport_tell_zod_zmb";
  level._effect["fx_margwa_teleport_intro_zod_zmb"] = "zombie/fx_margwa_teleport_intro_zod_zmb";
  level._effect["fx_margwa_head_shot_zod_zmb"] = "zombie/fx_margwa_head_shot_zod_zmb";
  level._effect["fx_margwa_roar_zod_zmb"] = "zombie/fx_margwa_roar_zod_zmb";
  level._effect["fx_margwa_roar_purple_zod_zmb"] = "zombie/fx_margwa_roar_purple_zod_zmb";
}

#namespace margwaclientutils;

function private margwaspawn(localclientnum) {
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  self setanim("ai_margwa_head_l_closed_add", 1, 0.2, 1);
  self setanim("ai_margwa_head_m_closed_add", 1, 0.2, 1);
  self setanim("ai_margwa_head_r_closed_add", 1, 0.2, 1);
  for(i = 1; i <= 7; i++) {
    lefttentacle = "ai_margwa_tentacle_l_0" + i;
    righttentacle = "ai_margwa_tentacle_r_0" + i;
    self setanim(lefttentacle, 1, 0.2, 1);
    self setanim(righttentacle, 1, 0.2, 1);
  }
  level._footstepcbfuncs[self.archetype] = & margwaprocessfootstep;
  self.heads = [];
  self.heads[1] = spawnStruct();
  self.heads[1].index = 1;
  self.heads[1].prevheadanim = "ai_margwa_head_l_closed_add";
  self.heads[1].jawbase = "ai_margwa_jaw_l_";
  self.heads[2] = spawnStruct();
  self.heads[2].index = 2;
  self.heads[2].prevheadanim = "ai_margwa_head_m_closed_add";
  self.heads[2].jawbase = "ai_margwa_jaw_m_";
  self.heads[3] = spawnStruct();
  self.heads[3].index = 3;
  self.heads[3].prevheadanim = "ai_margwa_head_r_closed_add";
  self.heads[3].jawbase = "ai_margwa_jaw_r_";
}

function private margwaheadleftcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.leftglowfx)) {
    stopfx(localclientnum, self.leftglowfx);
  }
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  switch (newvalue) {
    case 1: {
      self.heads[1].prevheadanim = "ai_margwa_head_l_open_add";
      self setanim("ai_margwa_head_l_open_add", 1, 0.1, 1);
      self clearanim("ai_margwa_head_l_closed_add", 0.1);
      roar_effect = level._effect["fx_margwa_roar_zod_zmb"];
      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }
      if(self clientfield::get("supermargwa")) {
        self.leftglowfx = playFXOnTag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_left");
      } else {
        self.leftglowfx = playFXOnTag(localclientnum, roar_effect, self, "tag_head_left");
      }
      break;
    }
    case 2: {
      self.heads[1].prevheadanim = "ai_margwa_head_l_closed_add";
      self setanim("ai_margwa_head_l_closed_add", 1, 0.1, 1);
      self clearanim("ai_margwa_head_l_open_add", 0.1);
      self clearanim("ai_margwa_head_l_smash_attack_1", 0.1);
      break;
    }
    case 3: {
      self.heads[1].prevheadanim = "ai_margwa_head_l_smash_attack_1";
      self clearanim("ai_margwa_head_l_open_add", 0.1);
      self clearanim("ai_margwa_head_l_closed_add", 0.1);
      self setanimrestart("ai_margwa_head_l_smash_attack_1", 1, 0.1, 1);
      roar_effect = level._effect["fx_margwa_roar_zod_zmb"];
      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }
      if(self clientfield::get("supermargwa")) {
        self.leftglowfx = playFXOnTag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_left");
      } else {
        self.leftglowfx = playFXOnTag(localclientnum, roar_effect, self, "tag_head_left");
      }
      self thread margwastopsmashfx(localclientnum);
      break;
    }
  }
}

function private margwaheadmidcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.midglowfx)) {
    stopfx(localclientnum, self.midglowfx);
  }
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  switch (newvalue) {
    case 1: {
      self setanim("ai_margwa_head_m_open_add", 1, 0.1, 1);
      self clearanim("ai_margwa_head_m_closed_add", 0.1);
      roar_effect = level._effect["fx_margwa_roar_zod_zmb"];
      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }
      if(self clientfield::get("supermargwa")) {
        self.midglowfx = playFXOnTag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_mid");
      } else {
        self.midglowfx = playFXOnTag(localclientnum, roar_effect, self, "tag_head_mid");
      }
      break;
    }
    case 2: {
      self setanim("ai_margwa_head_m_closed_add", 1, 0.1, 1);
      self clearanim("ai_margwa_head_m_open_add", 0.1);
      self clearanim("ai_margwa_head_m_smash_attack_1", 0.1);
      break;
    }
    case 3: {
      self clearanim("ai_margwa_head_m_open_add", 0.1);
      self clearanim("ai_margwa_head_m_closed_add", 0.1);
      self setanimrestart("ai_margwa_head_m_smash_attack_1", 1, 0.1, 1);
      roar_effect = level._effect["fx_margwa_roar_zod_zmb"];
      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }
      if(self clientfield::get("supermargwa")) {
        self.midglowfx = playFXOnTag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_mid");
      } else {
        self.midglowfx = playFXOnTag(localclientnum, roar_effect, self, "tag_head_mid");
      }
      self thread margwastopsmashfx(localclientnum);
      break;
    }
  }
}

function private margwaheadrightcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(isDefined(self.rightglowfx)) {
    stopfx(localclientnum, self.rightglowfx);
  }
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  switch (newvalue) {
    case 1: {
      self setanim("ai_margwa_head_r_open_add", 1, 0.1, 1);
      self clearanim("ai_margwa_head_r_closed_add", 0.1);
      roar_effect = level._effect["fx_margwa_roar_zod_zmb"];
      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }
      if(self clientfield::get("supermargwa")) {
        self.rightglowfx = playFXOnTag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_right");
      } else {
        self.rightglowfx = playFXOnTag(localclientnum, roar_effect, self, "tag_head_right");
      }
      break;
    }
    case 2: {
      self setanim("ai_margwa_head_r_closed_add", 1, 0.1, 1);
      self clearanim("ai_margwa_head_r_open_add", 0.1);
      self clearanim("ai_margwa_head_r_smash_attack_1", 0.1);
      break;
    }
    case 3: {
      self clearanim("ai_margwa_head_r_open_add", 0.1);
      self clearanim("ai_margwa_head_r_closed_add", 0.1);
      self setanimrestart("ai_margwa_head_r_smash_attack_1", 1, 0.1, 1);
      roar_effect = level._effect["fx_margwa_roar_zod_zmb"];
      if(isDefined(self.margwa_roar_effect)) {
        roar_effect = self.margwa_roar_effect;
      }
      if(self clientfield::get("supermargwa")) {
        self.rightglowfx = playFXOnTag(localclientnum, level._effect["fx_margwa_roar_purple_zod_zmb"], self, "tag_head_right");
      } else {
        self.rightglowfx = playFXOnTag(localclientnum, roar_effect, self, "tag_head_right");
      }
      self thread margwastopsmashfx(localclientnum);
      break;
    }
  }
}

function private margwastopsmashfx(localclientnum) {
  self endon("entityshutdown");
  wait(0.6);
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
  if(newvalue) {
    self.teleportfxin = playFX(localclientnum, level._effect["fx_margwa_teleport_zod_zmb"], self gettagorigin("j_spine_1"));
  }
}

function private margwafxoutcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    tagpos = self gettagorigin("j_spine_1");
    self.teleportfxout = playFX(localclientnum, level._effect["fx_margwa_teleport_zod_zmb"], tagpos);
  }
}

function private margwafxtravelcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (newvalue) {
    case 0: {
      deletefx(localclientnum, self.travelerfx);
      break;
    }
    case 1: {
      self.travelerfx = playFXOnTag(localclientnum, level._effect["fx_margwa_teleport_travel_zod_zmb"], self, "tag_origin");
      break;
    }
  }
}

function private margwafxtraveltellcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  switch (newvalue) {
    case 0: {
      deletefx(localclientnum, self.travelertellfx);
      self notify("stop_margwatraveltell");
      break;
    }
    case 1: {
      self.travelertellfx = playFXOnTag(localclientnum, level._effect["fx_margwa_teleport_tell_zod_zmb"], self, "tag_origin");
      self thread margwatraveltellupdate(localclientnum);
      break;
    }
  }
}

function private margwatraveltellupdate(localclientnum) {
  self notify("stop_margwatraveltell");
  self endon("stop_margwatraveltell");
  self endon("entityshutdown");
  player = getlocalplayer(localclientnum);
  while(true) {
    if(isDefined(player)) {
      dist_sq = distancesquared(player.origin, self.origin);
      if(dist_sq < 1000000) {
        player playrumbleonentity(localclientnum, "tank_rumble");
      }
    }
    wait(0.05);
  }
}

function private margwafxspawncallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    spawnfx = level._effect["fx_margwa_teleport_intro_zod_zmb"];
    if(isDefined(self.margwa_spawn_effect)) {
      spawnfx = self.margwa_spawn_effect;
    }
    if(isDefined(self.margwa_play_spawn_effect)) {
      self thread[[self.margwa_play_spawn_effect]](localclientnum);
    } else {
      self.spawnfx = playFX(localclientnum, spawnfx, self gettagorigin("j_spine_1"));
    }
    playSound(0, "zmb_margwa_spawn", self gettagorigin("j_spine_1"));
  }
}

function private margwaheadexplosion(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self postfx::playpostfxbundle("pstfx_parasite_dmg");
  }
}

function margwaprocessfootstep(localclientnum, pos, surface, notetrack, bone) {
  e_player = getlocalplayer(localclientnum);
  n_dist = distancesquared(pos, e_player.origin);
  n_margwa_dist = getdvarint("scr_margwa_footstep_eq_radius", 1000) * getdvarint("scr_margwa_footstep_eq_radius", 1000);
  if(n_margwa_dist > 0) {
    n_scale = (n_margwa_dist - n_dist) / n_margwa_dist;
  } else {
    return;
  }
  if(n_scale > 1 || n_scale < 0) {
    return;
  }
  n_scale = n_scale * 0.25;
  if(n_scale <= 0.01) {
    return;
  }
  e_player earthquake(n_scale, 0.1, pos, n_dist);
  if(n_scale <= 0.25 && n_scale > 0.2) {
    e_player playrumbleonentity(localclientnum, "shotgun_fire");
  } else {
    if(n_scale <= 0.2 && n_scale > 0.1) {
      e_player playrumbleonentity(localclientnum, "damage_heavy");
    } else {
      e_player playrumbleonentity(localclientnum, "reload_small");
    }
  }
}

function private margwasmashcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    e_player = getlocalplayer(localclientnum);
    smashpos = self.origin + vectorscale(anglesToForward(self.angles), 60);
    distsq = distancesquared(smashpos, e_player.origin);
    if(distsq < 20736) {
      e_player earthquake(0.7, 0.25, e_player.origin, 3000);
      e_player playrumbleonentity(localclientnum, "shotgun_fire");
    } else if(distsq < 36864) {
      e_player earthquake(0.7, 0.25, e_player.origin, 1500);
      e_player playrumbleonentity(localclientnum, "damage_heavy");
    }
  }
}

function private margwalefthitcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    effect = level._effect["fx_margwa_head_shot_zod_zmb"];
    if(isDefined(self.margwa_head_hit_fx)) {
      effect = self.margwa_head_hit_fx;
    }
    self.lefthitfx = playFXOnTag(localclientnum, effect, self, "tag_head_left");
  }
}

function private margwamidhitcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    effect = level._effect["fx_margwa_head_shot_zod_zmb"];
    if(isDefined(self.margwa_head_hit_fx)) {
      effect = self.margwa_head_hit_fx;
    }
    self.midhitfx = playFXOnTag(localclientnum, effect, self, "tag_head_mid");
  }
}

function private margwarighthitcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    effect = level._effect["fx_margwa_head_shot_zod_zmb"];
    if(isDefined(self.margwa_head_hit_fx)) {
      effect = self.margwa_head_hit_fx;
    }
    self.righthitfx = playFXOnTag(localclientnum, effect, self, "tag_head_right");
  }
}

function private margwaheadkilledcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    self.heads[newvalue].killed = 1;
  }
}

function private margwajawcallback(localclientnum, oldvalue, newvalue, bnewent, binitialsnap, fieldname, wasdemojump) {
  if(newvalue) {
    foreach(head in self.heads) {
      if(isDefined(head.killed) && head.killed) {
        if(isDefined(head.prevjawanim)) {
          self clearanim(head.prevjawanim, 0.2);
        }
        if(isDefined(head.prevheadanim)) {
          self clearanim(head.prevheadanim, 0.1);
        }
        jawanim = head.jawbase + level._jaw[newvalue];
        head.prevjawanim = jawanim;
        self setanim(jawanim, 1, 0.2, 1);
      }
    }
  }
}