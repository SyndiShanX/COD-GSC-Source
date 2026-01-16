/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_stalingrad_dragon.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm_utility;
#namespace dragon;

function autoexec __init__sytem__() {
  system::register("stalingrad_dragon", & __init__, undefined, undefined);
}

function __init__() {
  level.var_ef6a691 = 0;
  level.var_a4d6e1f1 = 1;
  level.var_61699bd7[1] = array("j_overshoulder_ri_anim_wound", "j_shoulder_ri_anim_wound");
  level.var_61699bd7[2] = array("j_spine_2_anim_wound", "j_spine_3_anim_wound");
  level.var_61699bd7[3] = array("j_neck_7_anim_wound", "j_neck_6_anim_wound");
  level.var_9d63af9a = [];
}

function init_clientfields() {
  clientfield::register("scriptmover", "dragon_body_glow", 12000, 1, "int", & function_d28f5c87, 0, 0);
  clientfield::register("scriptmover", "dragon_notify_bullet_impact", 12000, 1, "int", & function_d6856592, 0, 0);
  clientfield::register("scriptmover", "dragon_wound_glow_on", 12000, 2, "int", & function_cb9fb04a, 0, 0);
  clientfield::register("scriptmover", "dragon_wound_glow_off", 12000, 2, "int", & function_bb6d58d0, 0, 0);
  clientfield::register("scriptmover", "dragon_mouth_fx", 12000, 1, "int", & dragon_mouth_fx, 0, 0);
  n_bits = getminbitcountfornum(10);
  clientfield::register("scriptmover", "dragon_notetracks", 12000, n_bits, "counter", & function_47d133a9, 0, 0);
  clientfield::register("toplayer", "dragon_fire_burn_tell", 12000, 3, "int", & function_2d57594b, 0, 0);
  clientfield::register("world", "dragon_hazard_fx_anim_init", 12000, 1, "int", & function_b4311e07, 0, 0);
  clientfield::register("world", "dragon_hazard_fountain", 12000, 1, "int", & function_50d62870, 0, 0);
  clientfield::register("world", "dragon_hazard_library", 12000, 1, "counter", & function_6865d0d5, 0, 0);
  clientfield::register("toplayer", "dragon_transportation_exploders", 12000, 1, "int", & dragon_transportation_exploders, 0, 0);
  clientfield::register("allplayers", "dragon_transport_eject", 12000, 1, "int", & function_9f54e892, 0, 0);
  clientfield::register("world", "dragon_boss_guts", 12000, 2, "int", & dragon_boss_guts, 0, 0);
}

function function_d28f5c87(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("dragon_body_glow");
  self endon("dragon_body_glow");
  self endon("entityshutdown");
  self thread function_9b0f57cf(localclientnum, newval);
  if(newval) {
    i = 0;
    while (i <= 1) {
      if(!isdefined(self)) {
        return;
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, i, 0, 0);
      wait(0.016);
      i = i + 0.005;
    }
  } else {
    i = 1;
    while (i > 0) {
      if(!isdefined(self)) {
        return;
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, i, 0, 0);
      wait(0.016);
      i = i - 0.005;
    }
  }
}

function function_9b0f57cf(localclientnum, newval) {
  self notify("hash_9b0f57cf");
  self endon("hash_9b0f57cf");
  if(newval) {
    i = 0.25;
    while (i <= 1) {
      if(!isdefined(self)) {
        return;
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector6", 0, i, 0, 0);
      wait(0.016);
      i = i + 0.005;
    }
  } else {
    i = 1;
    while (i > 0.25) {
      if(!isdefined(self)) {
        return;
      }
      self mapshaderconstant(localclientnum, 0, "scriptVector6", 0, i, 0, 0);
      wait(0.016);
      i = i - 0.005;
    }
  }
}

function dragon_mouth_fx(n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump) {
  if(n_new) {
    playfxontag(n_local_client, level._effect["dragon_tongue"], self, "tag_mouth_floor_fx");
    playfxontag(n_local_client, level._effect["dragon_mouth"], self, "tag_throat_fx");
    playfxontag(n_local_client, level._effect["dragon_eye_l"], self, "tag_eye_left_fx");
    playfxontag(n_local_client, level._effect["dragon_eye_r"], self, "tag_eye_right_fx");
    self.var_6f4c2683 = [];
    self.var_6f4c2683[1] = 0;
    self.var_6f4c2683[2] = 0;
    self.var_6f4c2683[3] = 0;
  }
}

function function_d6856592(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval == 0 && newval == 1) {
    self.notifyonbulletimpact = 1;
    self thread function_2ce58010(localclientnum);
  } else if(oldval == 1 && newval == 0) {
    self.notifyonbulletimpact = 0;
    level notify("hash_a35dee4e");
  }
}

function function_2ce58010(n_local_client) {
  self endon("entityshutdown");
  level endon("hash_a35dee4e");
  while (true) {
    self waittill("damage", e_attacker, v_impact_pos, var_778fe70f, var_77cbbb1b);
    if(level.var_ef6a691 > 0) {
      foreach(var_61c194b7 in level.var_61699bd7[level.var_ef6a691]) {
        if(var_61c194b7 == var_77cbbb1b) {
          switch (level.var_ef6a691) {
            case 1: {
              str_tag = "j_shoulder_ri_wound_fx";
              break;
            }
            case 2: {
              str_tag = "j_spine_3_anim_wound_fx";
              break;
            }
            case 3: {
              str_tag = "j_neck_6_anim_wound_fx";
              break;
            }
          }
          playfxontag(n_local_client, level._effect["dragon_wound_hit"], self, str_tag);
        }
      }
    }
  }
}

function function_cb9fb04a(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval != newval) {
    if(newval > 0) {
      level.var_ef6a691 = newval;
      self thread function_bd038ea4(localclientnum, level.var_ef6a691, 1);
    }
  }
}

function function_bb6d58d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval != newval) {
    if(newval > 0) {
      self thread function_bd038ea4(localclientnum, newval, 0);
    }
  }
}

function function_bd038ea4(n_local_client, var_2c17cb9d, var_116b515b) {
  self notify("hash_bd038ea4");
  self endon("hash_bd038ea4");
  self endon("entityshutdown");
  var_4361a688 = undefined;
  switch (var_2c17cb9d) {
    case 1: {
      var_4361a688 = "scriptVector5";
      break;
    }
    case 2: {
      var_4361a688 = "scriptVector4";
      break;
    }
    case 3: {
      var_4361a688 = "scriptVector3";
      break;
    }
    default: {
      var_4361a688 = undefined;
      break;
    }
  }
  if(var_116b515b) {
    while (true) {
      i = self.var_6f4c2683[var_2c17cb9d];
      while (i < 1) {
        if(!isdefined(self)) {
          return;
        }
        self mapshaderconstant(n_local_client, 0, var_4361a688, 0, i, 0, 0);
        self.var_6f4c2683[var_2c17cb9d] = i;
        wait(0.01);
        i = i + 0.05;
      }
      i = self.var_6f4c2683[var_2c17cb9d];
      while (i > 0.1) {
        if(!isdefined(self)) {
          return;
        }
        self mapshaderconstant(n_local_client, 0, var_4361a688, 0, i, 0, 0);
        self.var_6f4c2683[var_2c17cb9d] = i;
        wait(0.01);
        i = i - 0.05;
      }
    }
  } else {
    i = self.var_6f4c2683[var_2c17cb9d];
    while (i > 0.1) {
      if(!isdefined(self)) {
        return;
      }
      self mapshaderconstant(n_local_client, 0, var_4361a688, 0, i, 0, 0);
      self.var_6f4c2683[var_2c17cb9d] = i;
      wait(0.01);
      i = i - 0.01;
    }
    i = 1;
    while (i > 0.1) {
      if(!isdefined(self)) {
        return;
      }
      self mapshaderconstant(n_local_client, 0, var_4361a688, 0, i, 1, 0);
      self.var_6f4c2683[var_2c17cb9d] = i;
      wait(0.01);
      i = i - 0.01;
    }
    self mapshaderconstant(n_local_client, 0, var_4361a688, 0, 0.1, 1, 0);
  }
}

function function_47d133a9(n_local_client, n_old, n_new, b_new_ent, b_initial_snap, str_field, b_was_time_jump) {
  if(n_new) {
    switch (n_new) {
      case 1: {
        v_tag_origin = self gettagorigin("tag_body_anim");
        playrumbleonposition(n_local_client, "zm_stalingrad_dragon_transport_arrival", v_tag_origin);
        playsound(n_local_client, "zmb_dragon_land_far", v_tag_origin);
        break;
      }
      case 2: {
        v_tag_origin = self gettagorigin("j_wrist_le_anim");
        playrumbleonposition(n_local_client, "zm_stalingrad_dragon_steps", v_tag_origin);
        playsound(n_local_client, "zmb_dragon_trans_step_arm", v_tag_origin);
        break;
      }
      case 3: {
        v_tag_origin = self gettagorigin("j_wrist_ri_anim");
        playrumbleonposition(n_local_client, "zm_stalingrad_dragon_steps", v_tag_origin);
        playsound(n_local_client, "zmb_dragon_trans_step_arm", v_tag_origin);
        break;
      }
      case 4: {
        v_tag_origin = self gettagorigin("j_ankle_1_le_anim");
        playrumbleonposition(n_local_client, "zm_stalingrad_dragon_steps", v_tag_origin);
        playsound(n_local_client, "zmb_dragon_trans_step_foot", v_tag_origin);
        break;
      }
      case 5: {
        v_tag_origin = self gettagorigin("j_ankle_1_ri_anim");
        playrumbleonposition(n_local_client, "zm_stalingrad_dragon_steps", v_tag_origin);
        playsound(n_local_client, "zmb_dragon_trans_step_foot", v_tag_origin);
        break;
      }
      case 6:
      case 9: {
        v_tag_origin = self gettagorigin("tag_body_anim");
        playrumbleonposition(n_local_client, "zm_stalingrad_dragon_big_wingflap", v_tag_origin);
        playsound(n_local_client, "zmb_dragon_wing_flap_far", v_tag_origin);
        break;
      }
      case 7:
      case 8: {
        v_tag_origin = self gettagorigin("tag_body_anim");
        playrumbleonposition(n_local_client, "zm_stalingrad_dragon_sml_wingflap", v_tag_origin);
        playsound(n_local_client, "zmb_dragon_wing_flap_far_qt", v_tag_origin);
        break;
      }
      case 10: {
        v_tag_origin = self gettagorigin("j_jaw_anim");
        playrumbleonposition(n_local_client, "artillery_rumble", v_tag_origin);
        playsound(n_local_client, "evt_dragon_pain_dragon_ride", v_tag_origin);
        break;
      }
    }
  }
}

function function_2d57594b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isdefined(level.var_9d63af9a[localclientnum])) {
      deletefx(localclientnum, level.var_9d63af9a[localclientnum], 1);
    }
    level.var_9d63af9a[localclientnum] = playfxontag(localclientnum, level._effect["dragon_fire_burn_tell"], self, "tag_origin");
    self thread postfx::playpostfxbundle("pstfx_arrow_rune");
  } else {
    if(isdefined(level.var_9d63af9a[localclientnum])) {
      stopfx(localclientnum, level.var_9d63af9a[localclientnum]);
    }
    self thread postfx::exitpostfxbundle();
  }
}

function function_b4311e07(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    var_c2e32e84 = getent(localclientnum, "dh_fountain_banner_01", "targetname");
    var_34ea9dbf = getent(localclientnum, "dh_fountain_banner_02", "targetname");
    level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_01_idle_bundle", var_c2e32e84);
    level thread scene::init("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_02_idle_bundle", var_34ea9dbf);
  }
}

function function_50d62870(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    level thread function_fa043827(localclientnum);
    level thread function_87fcc8ec(localclientnum);
  }
}

function function_fa043827(localclientnum) {
  var_c2e32e84 = getent(localclientnum, "dh_fountain_banner_01", "targetname");
  level scene::stop("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_01_idle_bundle");
  level thread scene::play("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_01_gusty_bundle", var_c2e32e84);
  wait(13.63);
  level scene::stop("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_01_gusty_bundle");
  level scene::init("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_01_idle_bundle", var_c2e32e84);
}

function function_87fcc8ec(localclientnum) {
  var_34ea9dbf = getent(localclientnum, "dh_fountain_banner_02", "targetname");
  level scene::stop("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_02_idle_bundle");
  level thread scene::play("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_02_gusty_bundle", var_34ea9dbf);
  wait(13.63);
  level scene::stop("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_02_gusty_bundle");
  level scene::init("p7_fxanim_zm_stal_dragon_hazard_fountain_banner_02_idle_bundle", var_34ea9dbf);
}

function function_6865d0d5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    if(isdefined(level.var_a4d6e1f1) && level.var_a4d6e1f1) {
      level.var_a4d6e1f1 = undefined;
      level scene::add_scene_func("p7_fxanim_zm_stal_dragon_hazard_library_banner_01_bundle", & function_ae0e995e, "play");
    }
    var_f8efe776 = getentarray(localclientnum, "library_banner_01", "targetname");
    foreach(var_f558224f in var_f8efe776) {
      var_f558224f thread scene::play("p7_fxanim_zm_stal_dragon_hazard_library_banner_01_bundle", var_f558224f);
    }
  }
}

function function_ae0e995e(a_ents) {
  wait(8);
  a_ents["library_banner_01"] scene::init("p7_fxanim_zm_stal_dragon_hazard_library_banner_01_bundle", a_ents);
}

function dragon_transportation_exploders(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playradiantexploder(localclientnum, "dragon_transportation");
    stopradiantexploder(localclientnum, "dragon_flight");
  } else {
    stopradiantexploder(localclientnum, "dragon_transportation");
    playradiantexploder(localclientnum, "dragon_flight");
  }
}

function function_9f54e892(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    playfx(localclientnum, level._effect["transport_eject"], self.origin);
    player = getlocalplayer(localclientnum);
    if(self == player) {
      enablespeedblur(localclientnum, 0.15, 0.3, 1, 0, 1, 1);
      self playrumblelooponentity(localclientnum, "zm_stalingrad_dragon_eject_wind");
    }
  } else {
    player = getlocalplayer(localclientnum);
    if(self == player) {
      disablespeedblur(localclientnum);
      self stoprumble(localclientnum, "zm_stalingrad_dragon_eject_wind");
    }
  }
}

function dragon_boss_guts(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 1: {
      forcestreamxmodel("p7_fxanim_zm_stal_dragon_chunks_mod");
      forcestreamxmodel("p7_fxanim_zm_stal_dragon_chunks_guts_smod");
      forcestreamxmodel("p7_fxanim_zm_stal_dragon_chunks_head_smod");
      forcestreamxmodel("p7_fxanim_zm_stal_dragon_chunks_wing_l_upper_smod");
      forcestreamxmodel("p7_fxanim_zm_stal_dragon_chunks_wing_r_upper_smod");
      forcestreamxmodel("p7_fxanim_zm_stal_dragon_chunks_wing_r_lower_smod");
      break;
    }
    case 2: {
      level thread scene::play("p7_fxanim_zm_stal_dragon_chunks_guts_bundle");
      break;
    }
  }
}