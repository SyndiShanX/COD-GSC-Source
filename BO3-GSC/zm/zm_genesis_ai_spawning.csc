/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_genesis_ai_spawning.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai_shared;
#using scripts\shared\animation_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\exploder_shared;
#using scripts\shared\filter_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#using_animtree("generic");
#namespace zm_genesis_ai_spawning;

function autoexec __init__sytem__() {
  system::register("zm_genesis_ai_spawning", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "chaos_postfx_set", 15000, 1, "int", &chaos_postfx_set, 0, 0);
  clientfield::register("world", "chaos_fog_bank_switch", 15000, 1, "int", &chaos_fog_bank_switch, 0, 0);
  visionset_mgr::register_visionset_info("zm_chaos_organge", 15000, 1, undefined, "zm_chaos_organge");
  ai::add_archetype_spawn_function("keeper", &function_5ea6033e);
  level._effect["chaos_1p_light"] = "zombie/fx_bmode_tent_light_zod_zmb";
  level._effect["keeper_glow"] = "zombie/fx_keeper_ambient_torso_zod_zmb";
  level._effect["keeper_mouth"] = "zombie/fx_keeper_glow_mouth_zod_zmb";
  level._effect["keeper_trail"] = "zombie/fx_keeper_mist_trail_zod_zmb";
  level._effect["keeper_death"] = "zombie/fx_keeper_death_zod_zmb";
  level.var_b7572a82 = 0;
}

function chaos_postfx_set(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.var_d8f5e78d = playfxoncamera(localclientnum, level._effect["chaos_1p_light"]);
    function_3c75e14b(localclientnum, 1);
  } else {
    if(isDefined(self.var_d8f5e78d)) {
      stopfx(localclientnum, self.var_d8f5e78d);
      self.var_d8f5e78d = undefined;
    }
    function_3c75e14b(localclientnum, 0);
    self thread postfx::exitpostfxbundle();
  }
}

function function_3c75e14b(localclientnum, onoff) {
  if(getdvarint("splitscreen_playerCount") == 2) {
    var_b401f607 = getdvarint("scr_num_in_beast");
    if(onoff) {
      var_b401f607++;
      setDvar("cg_focalLength", 21);
    } else {
      var_b401f607--;
      if(var_b401f607 == 0) {
        setDvar("cg_focalLength", 14.64);
      }
    }
    setDvar("scr_num_in_beast", var_b401f607);
  }
}

function chaos_fog_bank_switch(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    level.var_b7572a82 = 1;
    for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      if(level.var_e8af7a2f) {
        setworldfogactivebank(localclientnum, 8);
        continue;
      }
      setworldfogactivebank(localclientnum, 2);
    }
  } else {
    for(localclientnum = 0; localclientnum < level.localplayers.size; localclientnum++) {
      if(level.var_e8af7a2f) {
        setworldfogactivebank(localclientnum, 4);
        continue;
      }
      setworldfogactivebank(localclientnum, 1);
    }
    level.var_b7572a82 = 0;
  }
}

function function_5ea6033e(localclientnum) {
  self.var_341f7209 = playFXOnTag(localclientnum, level._effect["keeper_glow"], self, "j_spineupper");
  self.var_c5e3cf4b = playFXOnTag(localclientnum, level._effect["keeper_mouth"], self, "j_head");
  self.var_2d3cc156 = playFXOnTag(localclientnum, level._effect["keeper_trail"], self, "j_robe_front_03");
  if(!isDefined(self.sndlooper)) {
    self.sndlooper = self playLoopSound("zmb_keeper_looper");
  }
  self callback::on_shutdown(&function_4dc56cc7);
}

function function_4dc56cc7(localclientnum) {
  if(isDefined(self.var_341f7209)) {
    stopfx(localclientnum, self.var_341f7209);
    self.var_341f7209 = undefined;
  }
  if(isDefined(self.var_c5e3cf4b)) {
    stopfx(localclientnum, self.var_c5e3cf4b);
    self.var_c5e3cf4b = undefined;
  }
  if(isDefined(self.var_2d3cc156)) {
    stopfx(localclientnum, self.var_2d3cc156);
    self.var_2d3cc156 = undefined;
  }
  v_origin = self gettagorigin("j_spineupper");
  v_angles = self gettagangles("j_spineupper");
  if(isDefined(v_origin) && isDefined(v_angles)) {
    playFX(localclientnum, level._effect["keeper_death"], v_origin, v_angles);
  }
  self stopallloopsounds();
  self playSound(0, "zmb_keeper_death_explo");
}