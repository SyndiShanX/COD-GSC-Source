/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\bonuszm\_bonuszm.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\cybercom\_cybercom;
#using scripts\shared\_oob;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\filter_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\load_shared;
#using scripts\shared\music_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons\_bouncingbetty;
#using scripts\shared\weapons\_proximity_grenade;
#using scripts\shared\weapons\_riotshield;
#using scripts\shared\weapons\_satchel_charge;
#using scripts\shared\weapons\_tacticalinsertion;
#using scripts\shared\weapons\_trophy_system;
#using scripts\shared\weapons\antipersonnelguidance;
#using scripts\shared\weapons\multilockapguidance;
#namespace bonuszm;

function autoexec __init__sytem__() {
  system::register("bonuszm", &__init__, undefined, undefined);
}

function __init__() {
  setupstaticmodelsforthemode();
  function_e6a554ef();
  if(!sessionmodeiscampaignzombiesgame()) {
    return;
  }
  register_clientfields();
  init_fx();
  setdvar("bg_friendlyFireMode", 0);
  level.setgibfxtoignorepause = 1;
  callback::on_spawned(&on_player_spawned);
  function_aea4686a();
  vehicle::add_vehicletype_callback("raps", &function_938d1a68);
}

function function_938d1a68(localclientnum) {
  self setanim("ai_zombie_zod_insanity_elemental_idle", 1);
}

function autoexec function_4d5aa4f3() {}

function private on_player_spawned(localclientnum) {
  self tmodeenable(0);
  setdvar("r_bloomUseLutALT", 1);
  function_8cf4b0ee(localclientnum);
}

function setupstaticmodelsforthemode() {
  a_misc_models = findstaticmodelindexarray("zombie_misc_model");
  if(!sessionmodeiscampaignzombiesgame() || !util::is_mature()) {
    foreach(a_misc_model in a_misc_models) {
      hidestaticmodel(a_misc_model);
    }
  }
}

function function_e6a554ef() {
  var_9302fbfc = findvolumedecalindexarray("zombie_volume_decal");
  if(!sessionmodeiscampaignzombiesgame() || !util::is_mature()) {
    foreach(var_da4e043d in var_9302fbfc) {
      hidevolumedecal(var_da4e043d);
    }
  }
}

function function_9f75e681() {
  mapname = getdvarstring("mapname");
  if(mapname != "cp_mi_sing_sgen" || mapname != "cp_mi_cairo_lotus2") {
    audio::playloopat("mus_bonuszm_underscore", (0, 0, 0));
  }
}

function register_clientfields() {
  clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 0, 1);
  clientfield::register("actor", "bonus_zombie_eye_color", 1, 3, "int", &zombie_eyes_clientfield_cb2, 0, 1);
  clientfield::register("actor", "zombie_has_eyes", 1, 1, "int", &zombie_eyes_clientfield_cb, 0, 1);
  clientfield::register("actor", "zombie_gut_explosion", 1, 1, "int", &zombie_gut_explosion_cb, 0, 1);
  clientfield::register("actor", "bonuszm_zombie_on_fire_fx", 1, getminbitcountfornum(3), "int", &function_f83377d6, 0, 1);
  clientfield::register("actor", "bonuszm_zombie_spark_fx", 1, getminbitcountfornum(2), "int", &function_4b335db, 0, 1);
  clientfield::register("actor", "bonuszm_zombie_deimos_fx", 1, getminbitcountfornum(1), "int", &function_225fae17, 0, 1);
  clientfield::register("vehicle", "bonuszm_meatball_death", 1, 1, "int", &function_1f4cd60d, 0, 1);
  clientfield::register("actor", "zombie_riser_fx", 1, 1, "int", &handle_zombie_risers, 0, 1);
  clientfield::register("actor", "bonuszm_zombie_death_fx", 1, getminbitcountfornum(5), "int", &function_e4d833e, 0, 1);
  clientfield::register("actor", "zombie_appear_vanish_fx", 1, getminbitcountfornum(3), "int", &function_7fc0e06, 0, 1);
  clientfield::register("scriptmover", "powerup_on_fx", 1, getminbitcountfornum(3), "int", &callback_powerup_on_fx, 0, 0);
  clientfield::register("scriptmover", "powerup_grabbed_fx", 1, 1, "int", &function_50779600, 0, 0);
  clientfield::register("scriptmover", "weapon_disappear_fx", 1, 1, "int", &function_42f6f16e, 0, 0);
  clientfield::register("scriptmover", "sparky_trail_fx", 1, 1, "int", &function_ab68bae5, 0, 0);
  clientfield::register("scriptmover", "sparky_attack_fx", 1, 1, "counter", &function_14312cfd, 0, 0);
  clientfield::register("actor", "sparky_damaged_fx", 1, 1, "counter", &function_97590d4, 0, 0);
  clientfield::register("actor", "fire_damaged_fx", 1, 1, "counter", &function_780c0a4, 0, 0);
  clientfield::register("zbarrier", "magicbox_open_glow", 1, 1, "int", &magicbox_open_glow_callback, 0, 0);
  clientfield::register("zbarrier", "magicbox_closed_glow", 1, 1, "int", &magicbox_closed_glow_callback, 0, 0);
  clientfield::register("toplayer", "bonuszm_player_instakill_active_fx", 1, 1, "int", &function_bba3723b, 0, 0);
  clientfield::register("world", "cpzm_song_suppression", 1, 1, "int", &function_2122d6fd, 0, 0);
}

function init_fx() {
  level._effect["eye_glow_o"] = "zombie/fx_glow_eye_orange";
  level._effect["eye_glow_b"] = "zombie/fx_glow_eye_blue";
  level._effect["eye_glow_g"] = "zombie/fx_glow_eye_green";
  level._effect["eye_glow_r"] = "zombie/fx_glow_eye_red";
  level._effect["rise_burst"] = "zombie/fx_spawn_dirt_hand_burst_zmb";
  level._effect["rise_billow"] = "zombie/fx_spawn_dirt_body_billowing_zmb";
  level._effect["rise_dust"] = "zombie/fx_spawn_dirt_body_dustfalling_zmb";
  level._effect["powerup_on"] = "zombie/fx_powerup_on_solo_zmb";
  level._effect["powerup_on_upgraded"] = "zombie/fx_powerup_on_green_zmb";
  level._effect["powerup_on_upgraded_all"] = "zombie/fx_powerup_on_caution_zmb";
  level._effect["chest_light"] = "zombie/fx_weapon_box_open_glow_zmb";
  level._effect["chest_light_closed"] = "zombie/fx_weapon_box_closed_glow_zmb";
  level._effect["zombie_spawn"] = "zombie/fx_spawn_body_cp_zmb";
  level._effect["zombie_sparky"] = "electric/fx_ability_elec_surge_short_robot";
  level._effect["zombie_sparky_death"] = "explosions/fx_ability_exp_ravage_core";
  level._effect["zombie_sparky_trail"] = "electric/fx_ability_elec_strike_trail";
  level._effect["zombie_sparky_impact"] = "electric/fx_ability_elec_strike_impact";
  level._effect["zombie_sparky_attack_death"] = "electric/fx_ability_elec_strike_short_human";
  level._effect["zombie_sparky_left_hand"] = "weapon/fx_hero_lightning_gun_death_hands_lft";
  level._effect["zombie_sparky_right_hand"] = "weapon/fx_hero_lightning_gun_death_hands";
  level._effect["zombie_fire_damage"] = "fire/fx_embers_burst";
  level._effect["zombie_on_fire_suicide"] = "explosions/fx_exp_dest_barrel_concussion_sm";
  level._effect["zombie_fire_light"] = "light/fx_light_fire_chest_zombie";
  level._effect["zombie_spark_light"] = "light/fx_light_spark_chest_zombie";
  level._effect["electric_spark"] = "electric/fx_elec_sparks_burst_blue";
  level._effect["deimos_zombie"] = "player/fx_ai_corvus_torso_loop";
  level._effect["deimos_zombie_le"] = "player/fx_ai_raven_teleport_out_arm_le";
  level._effect["deimos_zombie_ri"] = "player/fx_ai_raven_teleport_out_arm_ri";
  level._effect["deimos_zombie_death"] = "player/fx_ai_raven_dissolve_torso";
}

function handle_zombie_risers(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level endon("demo_jump");
  self endon("entityshutdown");
  if(newval) {
    sound = "zmb_zombie_spawn";
    burst_fx = level._effect["rise_burst"];
    billow_fx = level._effect["rise_billow"];
    type = "dirt";
    if(isDefined(level.riser_type) && level.riser_type == "snow") {
      sound = "zmb_zombie_spawn";
      burst_fx = level._effect["rise_burst_snow"];
      billow_fx = level._effect["rise_billow_snow"];
      type = "snow";
    }
    playSound(0, sound, self.origin);
    self thread rise_dust_fx(localclientnum, type, billow_fx, burst_fx);
  }
}

function rise_dust_fx(localclientnum, type, billow_fx, burst_fx) {
  dust_tag = "J_SpineUpper";
  self endon("entityshutdown");
  level endon("demo_jump");
  if(isDefined(burst_fx)) {
    fx = playFX(localclientnum, burst_fx, self.origin + (0, 0, randomintrange(5, 10)));
    setfxignorepause(localclientnum, fx, 1);
  }
  wait(0.25);
  if(isDefined(billow_fx)) {
    fx = playFX(localclientnum, billow_fx, self.origin + (randomintrange(-10, 10), randomintrange(-10, 10), randomintrange(5, 10)));
    setfxignorepause(localclientnum, fx, 1);
  }
  wait(2);
  dust_time = 5.5;
  dust_interval = 0.3;
  player = level.localplayers[localclientnum];
  effect = level._effect["rise_dust"];
  if(type == "snow") {
    effect = level._effect["rise_dust_snow"];
  } else if(type == "none") {
    return;
  }
  self util::waittill_dobj(localclientnum);
  t = 0;
  while(t < dust_time) {
    fx = playFXOnTag(localclientnum, effect, self, dust_tag);
    setfxignorepause(localclientnum, fx, 1);
    wait(dust_interval);
    t = t + dust_interval;
  }
}

function zombie_eyes_clientfield_cb2(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  self.eyecol = newval;
}

function zombie_eyes_clientfield_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    self createzombieeyesinternal(localclientnum);
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_on_luminance(), self get_eyeball_color());
  } else {
    self deletezombieeyes(localclientnum);
    self mapshaderconstant(localclientnum, 0, "scriptVector2", 0, get_eyeball_off_luminance(), self get_eyeball_color());
  }
  if(isDefined(level.zombie_eyes_clientfield_cb_additional)) {
    self[[level.zombie_eyes_clientfield_cb_additional]](localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
  }
}

function createzombieeyesinternal(localclientnum) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self._eyearray)) {
    self._eyearray = [];
  }
  if(!isDefined(self._eyearray[localclientnum])) {
    linktag = "j_eyeball_le";
    if(!isDefined(self.eyecol)) {
      return;
    }
    if(self.eyecol == 0) {
      effect = level._effect["eye_glow_o"];
    } else {
      if(self.eyecol == 1) {
        effect = level._effect["eye_glow_b"];
      } else {
        if(self.eyecol == 2) {
          effect = level._effect["eye_glow_g"];
        } else {
          if(self.eyecol == 3) {
            effect = level._effect["eye_glow_r"];
          } else {
            return;
          }
        }
      }
    }
    if(isDefined(level._override_eye_fx)) {
      effect = level._override_eye_fx;
    }
    if(isDefined(self._eyeglow_fx_override)) {
      effect = self._eyeglow_fx_override;
    }
    if(isDefined(self._eyeglow_tag_override)) {
      linktag = self._eyeglow_tag_override;
    }
    self._eyearray[localclientnum] = playFXOnTag(localclientnum, effect, self, linktag);
  }
}

function get_eyeball_on_luminance() {
  if(isDefined(level.eyeball_on_luminance_override)) {
    return level.eyeball_on_luminance_override;
  }
  return 1;
}

function get_eyeball_off_luminance() {
  if(isDefined(level.eyeball_off_luminance_override)) {
    return level.eyeball_off_luminance_override;
  }
  return 0;
}

function get_eyeball_color() {
  val = 0;
  if(isDefined(level.zombie_eyeball_color_override)) {
    val = level.zombie_eyeball_color_override;
  }
  if(isDefined(self.zombie_eyeball_color_override)) {
    val = self.zombie_eyeball_color_override;
  }
  return val;
}

function deletezombieeyes(localclientnum) {
  if(isDefined(self._eyearray)) {
    if(isDefined(self._eyearray[localclientnum])) {
      deletefx(localclientnum, self._eyearray[localclientnum], 1);
      self._eyearray[localclientnum] = undefined;
    }
  }
}

function callback_powerup_on_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(newval == 3) {
      self.pwr_fx = playFXOnTag(localclientnum, level._effect["powerup_on_upgraded_all"], self, "tag_origin");
    } else {
      if(newval == 2) {
        self.pwr_fx = playFXOnTag(localclientnum, level._effect["powerup_on_upgraded"], self, "tag_origin");
      } else {
        self.pwr_fx = playFXOnTag(localclientnum, level._effect["powerup_on"], self, "tag_origin");
      }
    }
    setfxignorepause(localclientnum, self.pwr_fx, 1);
    if(self.model === "p7_zm_teddybear_sitting") {} else {
      playSound(localclientnum, "zmb_spawn_powerup", self.origin);
      self playLoopSound("zmb_spawn_powerup_loop", 0.5);
    }
  } else if(isDefined(self.pwr_fx)) {
    self stopallloopsounds();
    deletefx(localclientnum, self.pwr_fx, 1);
    self.pwr_fx = undefined;
    fx = playFXOnTag(localclientnum, level._effect["electric_spark"], self, "tag_origin");
    setfxignorepause(localclientnum, fx, 1);
    playSound(localclientnum, "zmb_box_timeout_poof", self.origin);
    playrumbleonposition(localclientnum, "damage_light", self.origin);
  }
}

function function_50779600(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  if(newval) {
    playSound(localclientnum, "zmb_powerup_grabbed", self.origin);
  }
}

function function_f83377d6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval == 1 || newval == 2) {
    if(!isDefined(self.var_6044d98e)) {
      self.var_6044d98e = self playLoopSound("zmb_fire_burn_loop", 0.2);
    }
    if(newval == 2) {
      fx = playFXOnTag(localclientnum, level._effect["zombie_fire_light"], self, "J_SpineUpper");
      setfxignorepause(localclientnum, fx, 1);
      self function_d8c8d819(localclientnum, "fire");
    }
  } else if(newval == 3) {
    playSound(localclientnum, "zmb_fire_charge_up", self.origin);
  }
}

function function_780c0a4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["zombie_fire_damage"])) {
      playSound(localclientnum, "gdt_electro_bounce", self.origin);
      locs = array("j_wrist_le", "j_wrist_ri");
      fx = playFXOnTag(localclientnum, level._effect["zombie_fire_damage"], self, array::random(locs));
      setfxignorepause(localclientnum, fx, 1);
    }
  }
}

function function_4b335db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval >= 1) {
    if(!isDefined(self.var_6044d98e)) {
      self.var_6044d98e = self playLoopSound("zmb_electrozomb_lp", 0.2);
    }
    fx = playFXOnTag(localclientnum, level._effect["zombie_sparky"], self, "J_SpineUpper");
    setfxignorepause(localclientnum, fx, 1);
    if(newval == 2) {
      fx = playFXOnTag(localclientnum, level._effect["zombie_spark_light"], self, "J_SpineUpper");
      setfxignorepause(localclientnum, fx, 1);
      self function_d8c8d819(localclientnum, "sparky");
    }
  }
}

function function_225fae17(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(!isDefined(self.var_6044d98e)) {
      self.var_6044d98e = self playLoopSound("zmb_deimoszomb_lp", 0.2);
    }
    fx = playFXOnTag(localclientnum, level._effect["deimos_zombie"], self, "J_SpineUpper");
    setfxignorepause(localclientnum, fx, 1);
    fx = playFXOnTag(localclientnum, level._effect["deimos_zombie_le"], self, "j_wrist_le");
    setfxignorepause(localclientnum, fx, 1);
    fx = playFXOnTag(localclientnum, level._effect["deimos_zombie_ri"], self, "j_wrist_ri");
    setfxignorepause(localclientnum, fx, 1);
  }
}

function function_1f4cd60d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval == 1) {
    fx = playFXOnTag(localclientnum, level._effect["zombie_on_fire_suicide"], self, "tag_origin");
    setfxignorepause(localclientnum, fx, 1);
    playSound(localclientnum, "zmb_fire_explode", self.origin);
  }
}

function function_bba3723b(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.var_dedf9511 = self playLoopSound("zmb_insta_kill_loop", 2);
    self thread function_69f683e7(localclientnum, 1);
  } else {
    self notify("hash_eb366021");
    playSound(localclientnum, "zmb_insta_kill_loop_off", (0, 0, 0));
    self stoploopsound(self.var_dedf9511);
    self thread function_69f683e7(localclientnum, 0);
  }
}

function function_4778b020(lo, hi) {
  color = (randomfloatrange(lo[0], hi[0]), randomfloatrange(lo[1], hi[1]), randomfloatrange(lo[2], hi[2]));
  return color;
}

function function_4b2bbece(var_3ae5c24, var_1bfa7cb7, frac) {
  frac0 = 1 - frac;
  color = ((frac0 * var_3ae5c24[0]) + (frac * var_1bfa7cb7[0]), (frac0 * var_3ae5c24[1]) + (frac * var_1bfa7cb7[1]), (frac0 * var_3ae5c24[2]) + (frac * var_1bfa7cb7[2]));
  return color;
}

function function_69f683e7(localclientnum, onoff) {
  self notify("hash_bc7b7772");
  self endon("hash_bc7b7772");
  if(!onoff) {
    self setcontrollerlightbarcolor(localclientnum);
    return;
  }
  var_781fc232 = (63, 103, 4) / 255;
  var_27745be8 = (105, 148, 24) / 255;
  var_d7805253 = 2;
  var_ec055171 = 0.25;
  cycle_time = var_d7805253;
  old_color = function_4778b020(var_781fc232, var_27745be8);
  new_color = old_color;
  while(isDefined(self)) {
    if(cycle_time >= var_d7805253) {
      old_color = new_color;
      new_color = function_4778b020(var_781fc232, var_27745be8);
      cycle_time = 0;
    }
    color = function_4b2bbece(old_color, new_color, cycle_time / var_d7805253);
    self setcontrollerlightbarcolor(localclientnum, color);
    cycle_time = cycle_time + var_ec055171;
    wait(var_ec055171);
  }
}

function function_d8c8d819(localclientnum, var_d6ae4487) {
  self endon("entityshutdown");
  self.var_13f5905e = 1;
  self duplicate_render::set_dr_flag("armor_on", 1);
  self duplicate_render::update_dr_filters(localclientnum);
  var_aa5d763a = "scriptVector3";
  var_fc81e73c = 0.1;
  colortintvaluey = 0.56;
  colortintvaluez = 0.92;
  colortintvaluew = 1;
  var_93429fd9 = 0.2;
  if(var_d6ae4487 == "sparky") {
    var_754d7044 = 0.15;
    var_e754df7f = 0.5;
    var_595c4eba = 0.4;
    var_93429fd9 = 0.2;
  }
  if(var_d6ae4487 == "fire") {
    var_754d7044 = 0.6;
    var_e754df7f = 0.45;
    var_595c4eba = 0;
    var_93429fd9 = 0.2;
  }
  var_6c5c3132 = "scriptVector4";
  self mapshaderconstant(localclientnum, 0, var_aa5d763a, var_fc81e73c, var_754d7044, var_e754df7f, var_595c4eba);
  self mapshaderconstant(localclientnum, 0, var_6c5c3132, var_93429fd9, 0, 0, 0);
  self tmodesetflag(10);
}

function function_e4d833e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(newval)) {
    return;
  }
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval == 5) {
    if(getdvarstring("mapname") != "cp_mi_zurich_coalescence") {
      self stopallloopsounds(1);
      fx = playFX(localclientnum, level._effect["deimos_zombie_death"], self.origin + vectorscale((0, 0, 1), 35));
      setfxignorepause(localclientnum, fx, 1);
      fx = playFX(localclientnum, level._effect["zombie_sparky_death"], self.origin + vectorscale((0, 0, 1), 35));
      setfxignorepause(localclientnum, fx, 1);
      playSound(localclientnum, "zmb_deimoszomb_explo", self.origin);
      playrumbleonposition(localclientnum, "damage_light", self.origin);
    }
  }
  if(newval == 4) {
    self stopallloopsounds(1);
    fx = playFX(localclientnum, level._effect["zombie_sparky_attack_death"], self.origin + vectorscale((0, 0, 1), 35));
    setfxignorepause(localclientnum, fx, 1);
    playSound(localclientnum, "zmb_electrozomb_explo_small", self.origin);
    playrumbleonposition(localclientnum, "damage_light", self.origin);
  }
  if(newval == 3) {
    self stopallloopsounds(1);
    fx = playFX(localclientnum, level._effect["zombie_sparky_death"], self.origin + vectorscale((0, 0, 1), 35));
    setfxignorepause(localclientnum, fx, 1);
    playSound(localclientnum, "zmb_electrozomb_explo_large", self.origin);
    playrumbleonposition(localclientnum, "damage_light", self.origin);
  }
  if(newval == 2) {
    self stopallloopsounds(1);
    fx = playFX(localclientnum, level._effect["zombie_on_fire_suicide"], self.origin + vectorscale((0, 0, 1), 35));
    setfxignorepause(localclientnum, fx, 1);
    playSound(localclientnum, "zmb_fire_explode", self.origin);
    playrumbleonposition(localclientnum, "damage_light", self.origin);
  }
  if(newval > 0) {
    fxobj = util::spawn_model(localclientnum, "tag_origin", self.origin, self.angles);
    fxobj thread function_10dcbf51(localclientnum, fxobj);
  }
}

function private function_10dcbf51(localclientnum, fxobj) {
  fxobj playSound(localclientnum, "evt_ai_insta_explode");
  wait(1);
  fxobj delete();
}

function zombie_gut_explosion_cb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["zombie_guts_explosion"])) {
      org = self gettagorigin("J_SpineLower");
      if(isDefined(org)) {
        fx = playFX(localclientnum, level._effect["zombie_guts_explosion"], org);
        setfxignorepause(localclientnum, fx, 1);
      }
    }
  }
}

function function_ab68bae5(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["zombie_sparky_trail"])) {
      self playLoopSound("zmb_fire_burn_loop", 0.1);
      fx = playFXOnTag(localclientnum, level._effect["zombie_sparky_trail"], self, "tag_origin");
      setfxignorepause(localclientnum, fx, 1);
    }
  }
}

function function_14312cfd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["zombie_sparky_impact"])) {
      fx = playFX(localclientnum, level._effect["zombie_sparky_impact"], self.origin);
      setfxignorepause(localclientnum, fx, 1);
    }
  }
}

function function_97590d4(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["zombie_sparky_left_hand"])) {
      playSound(localclientnum, "gdt_electro_bounce", self.origin);
      fx = playFXOnTag(localclientnum, level._effect["zombie_sparky_left_hand"], self, "j_wrist_le");
      setfxignorepause(localclientnum, fx, 1);
      fx = playFXOnTag(localclientnum, level._effect["zombie_sparky_right_hand"], self, "j_wrist_ri");
      setfxignorepause(localclientnum, fx, 1);
    }
  }
}

function function_42f6f16e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval) {
    if(isDefined(level._effect["zombie_spawn"])) {
      playSound(localclientnum, "zmb_box_timeout_poof", self.origin);
      fx = playFX(localclientnum, level._effect["electric_spark"], self.origin);
      setfxignorepause(localclientnum, fx, 1);
    }
  }
}

function magicbox_open_glow_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.open_glow_obj_array)) {
    self.open_glow_obj_array = [];
  }
  if(newval && !isDefined(self.open_glow_obj_array[localclientnum])) {
    fx_obj = spawn(localclientnum, self.origin, "script_model");
    fx_obj setModel("tag_origin");
    fx_obj.angles = self.angles;
    fx = playFXOnTag(localclientnum, level._effect["chest_light"], fx_obj, "tag_origin");
    setfxignorepause(localclientnum, fx, 1);
    playSound(localclientnum, "zmb_lid_open", self.origin);
    playSound(localclientnum, "zmb_music_box", self.origin);
    self.open_glow_obj_array[localclientnum] = fx_obj;
    self open_glow_obj_demo_jump_listener(localclientnum);
  } else if(!newval && isDefined(self.open_glow_obj_array[localclientnum])) {
    self open_glow_obj_cleanup(localclientnum);
  }
}

function open_glow_obj_demo_jump_listener(localclientnum) {
  self endon("end_demo_jump_listener");
  level waittill("demo_jump");
  self open_glow_obj_cleanup(localclientnum);
}

function open_glow_obj_cleanup(localclientnum) {
  self.open_glow_obj_array[localclientnum] delete();
  self.open_glow_obj_array[localclientnum] = undefined;
  self notify("end_demo_jump_listener");
}

function magicbox_closed_glow_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(!isDefined(self.closed_glow_obj_array)) {
    self.closed_glow_obj_array = [];
  }
  if(newval && !isDefined(self.closed_glow_obj_array[localclientnum])) {
    fx_obj = spawn(localclientnum, self.origin, "script_model");
    fx_obj setModel("tag_origin");
    fx_obj.angles = self.angles;
    fx = playFXOnTag(localclientnum, level._effect["chest_light_closed"], fx_obj, "tag_origin");
    setfxignorepause(localclientnum, fx, 1);
    playSound(localclientnum, "zmb_lid_close", self.origin);
    self.closed_glow_obj_array[localclientnum] = fx_obj;
    self closed_glow_obj_demo_jump_listener(localclientnum);
  } else if(!newval && isDefined(self.closed_glow_obj_array[localclientnum])) {
    self closed_glow_obj_cleanup(localclientnum);
  }
}

function closed_glow_obj_demo_jump_listener(localclientnum) {
  self endon("end_demo_jump_listener");
  level waittill("demo_jump");
  self closed_glow_obj_cleanup(localclientnum);
}

function closed_glow_obj_cleanup(localclientnum) {
  self.closed_glow_obj_array[localclientnum] delete();
  self.closed_glow_obj_array[localclientnum] = undefined;
  self notify("end_demo_jump_listener");
}

function function_aea4686a() {
  var_6a173bd1 = ("gamedata/tables/cpzm/") + "cpzm_weapons_sgen.csv";
  var_adeb478a = tablelookuprowcount(var_6a173bd1);
  var_709de245 = [];
  for(i = 0; i < var_adeb478a; i++) {
    weaponname = tablelookupcolumnforrow(var_6a173bd1, i, 0);
    array::add(var_709de245, weaponname);
  }
  var_709de245 = array::randomize(var_709de245);
  for(i = 0; i < var_709de245.size; i++) {
    if(i >= 30) {
      break;
    }
    weapon = getweapon(var_709de245[i]);
    if(!isDefined(weapon)) {
      continue;
    }
    if(isDefined(weapon.worldmodel)) {
      addzombieboxweapon(weapon, weapon.worldmodel, 0);
    }
  }
}

function function_8cf4b0ee(localclientnum) {
  filter::map_material_helper(self, "generic_zombie_bblend_vignette");
  setfilterpassmaterial(self.localclientnum, 7, 0, filter::mapped_material_id("generic_zombie_bblend_vignette"));
  setfilterpassenabled(self.localclientnum, 7, 0, 1);
  setfilterpassconstant(self.localclientnum, 7, 0, 0, 1);
  setfilterpassconstant(self.localclientnum, 7, 0, 1, 0);
}

function function_7fc0e06(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  if(!isDefined(self)) {
    return;
  }
  if(newval == 1) {
    playSound(localclientnum, "zmb_flashback_disappear_npc", self.origin);
    playFX(localclientnum, level._effect["zombie_spawn"], self.origin + vectorscale((0, 0, 1), 35));
  } else {
    if(newval == 2) {
      playSound(localclientnum, "zmb_flashback_reappear_npc", self.origin);
      playFX(localclientnum, level._effect["zombie_spawn"], self.origin + vectorscale((0, 0, 1), 35));
    } else if(newval == 3) {
      playSound(localclientnum, "zmb_flashback_reappear_npc", self.origin);
      playFX(localclientnum, level._effect["zombie_spawn"], self.origin + vectorscale((0, 0, 1), 35));
    }
  }
}

function function_2122d6fd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(level.var_673a9a22)) {
    level.var_673a9a22 = spawn(0, (0, 0, 0), "script_origin");
  }
  if(newval) {
    level.var_ed1ec8bc = level.var_673a9a22 playLoopSound("zmb_cp_song_suppress");
  } else if(isDefined(level.var_ed1ec8bc)) {
    level.var_673a9a22 stoploopsound(level.var_ed1ec8bc);
  }
}