/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_oed.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#namespace oed;

function autoexec __init__sytem__() {
  system::register("oed", &__init__, undefined, undefined);
}

function __init__() {
  clientfield::register("toplayer", "ev_toggle", 1, 1, "int", &ev_player_toggle, 0, 0);
  clientfield::register("toplayer", "sitrep_toggle", 1, 1, "int", &sitrep_player_toggle, 0, 0);
  clientfield::register("toplayer", "tmode_toggle", 1, 3, "int", &tmode_player_toggle, 0, 0);
  clientfield::register("toplayer", "active_dni_fx", 1, 1, "counter", &function_6b87ceb0, 0, 0);
  clientfield::register("toplayer", "hack_dni_fx", 1, 1, "counter", &hack_dni_fx, 0, 0);
  clientfield::register("actor", "thermal_active", 1, 1, "int", &ent_thermal_callback, 0, 0);
  clientfield::register("actor", "sitrep_material", 1, 1, "int", &ent_material_callback, 0, 0);
  clientfield::register("actor", "force_tmode", 1, 1, "int", &tmode_force_toggle, 0, 0);
  clientfield::register("actor", "tagged", 1, 1, "int", &tagged_toggle, 0, 0);
  clientfield::register("vehicle", "thermal_active", 1, 1, "int", &ent_thermal_callback, 0, 0);
  clientfield::register("vehicle", "sitrep_material", 1, 1, "int", &ent_material_callback, 0, 0);
  clientfield::register("scriptmover", "thermal_active", 1, 1, "int", &ent_thermal_callback, 0, 0);
  clientfield::register("scriptmover", "sitrep_material", 1, 1, "int", &ent_material_callback, 0, 0);
  clientfield::register("item", "sitrep_material", 1, 1, "int", &ent_material_callback, 0, 0);
  duplicate_render::set_dr_filter_offscreen("sitrep_keyline", 25, "keyline_active", "keyfill_active", 2, "mc/hud_outline_model_z_white", 0);
  duplicate_render::set_dr_filter_offscreen("sitrep_fill", 25, "keyfill_active", "keyline_active", 2, "mc/hud_outline_model_orange_alpha", 0);
  duplicate_render::set_dr_filter_offscreen("sitrep_keyfill", 30, "keyline_active,keyfill_active", undefined, 2, "mc/hud_outline_model_orange_calpha", 0);
  duplicate_render::set_dr_filter_offscreen("enemy_thermal", 24, "thermal_enemy_active", undefined, 2, "mc/hud_outline_model_z_red", 0);
  duplicate_render::set_dr_filter_offscreen("friendly_thermal", 24, "thermal_friendly_active", undefined, 2, "mc/hud_outline_model_z_green", 0);
  visionset_mgr::register_visionset_info("tac_mode", 1, 15, undefined, "tac_mode_blue");
  callback::on_spawned(&on_player_spawned);
  level flag::init("activate_tmode");
  level flag::init("activate_thermal");
  callback::on_localclient_shutdown(&on_localplayer_shutdown);
}

function on_player_spawned(localclientnum) {
  self.b_ev_active = 0;
  var_7fd179a9 = 10500;
  var_3b6a005d = 3000;
  if(isDefined(level.var_6411bf7a)) {
    var_7fd179a9 = level.var_6411bf7a;
  }
  if(isDefined(level.var_80d69208)) {
    var_3b6a005d = level.var_80d69208;
  }
  evsetranges(localclientnum, var_7fd179a9, var_3b6a005d);
  self oed_sitrepscan_setoutline(1);
  self oed_sitrepscan_setlinewidth(1);
  self oed_sitrepscan_setradius(1800);
  self oed_sitrepscan_setfalloff(0.01);
  self tmode_init_ent_shader_materials();
  function_357cbbf0(localclientnum);
  function_22ee3552(localclientnum);
}

function on_localplayer_shutdown(localclientnum) {
  function_357cbbf0(localclientnum);
  function_22ee3552(localclientnum);
}

function tmode_init_ent_shader_materials() {}

function tmode_remove_all_ents(localclientnum) {
  if(!self islocalplayer()) {
    return;
  }
  a_all_entities = getEntArray(localclientnum);
  foreach(entity in a_all_entities) {
    if(isDefined(entity.tmode_set) && entity.tmode_set) {
      entity.tmode_set = 0;
      entity tmodeclearflag(4);
    }
  }
}

function ev_player_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  if(level flagsys::get("menu_open")) {
    return;
  }
  self player_toggle_ev(localclientnum, newval);
}

function function_e8b1e8b2(localclientnum, newval) {
  if(isDefined(self)) {
    self evenable(newval);
  } else {
    println("");
    gadgetsetinfrared(localclientnum, newval);
  }
}

function function_22ee3552(localclientnum) {
  audio::stoploopat("gdt_oed_loop", (1, 2, 3));
  deactivate_thermal_ents(localclientnum);
  wait(0.016);
  self function_e8b1e8b2(localclientnum, 0);
  level flag::clear("activate_thermal");
}

function function_357cbbf0(localclientnum) {
  self tmodeenable(0);
  self thread tmode_remove_all_ents(localclientnum);
  wait(0.016);
  level flag::clear("activate_tmode");
}

function player_toggle_ev(lcn, newval) {
  self.b_ev_active = newval;
  if(newval) {
    function_357cbbf0(lcn);
    self function_e8b1e8b2(lcn, newval);
    level flag::set("activate_thermal");
    if(isDefined(level.ev_override)) {
      [
        [level.ev_override]
      ]();
    }
    playSound(lcn, "gdt_oed_on", (0, 0, 0));
    audio::playloopat("gdt_oed_loop", (1, 2, 3));
    activate_thermal_ents(lcn);
  } else {
    playSound(lcn, "gdt_oed_off", (0, 0, 0));
    audio::stoploopat("gdt_oed_loop", (1, 2, 3));
    deactivate_thermal_ents(lcn);
    wait(0.016);
    self function_e8b1e8b2(lcn, newval);
    level flag::clear("activate_thermal");
  }
}

function ent_thermal_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  level flagsys::wait_till("duplicaterender_registry_ready");
  assert(isDefined(self), "");
  if(newval == 0) {
    self.b_show_thermal = 0;
    self set_entity_thermal(localclientnum, 0);
  } else {
    self.b_show_thermal = newval;
    player = getlocalplayer(localclientnum);
    if(isDefined(player.b_ev_active) && player.b_ev_active) {
      self set_entity_thermal(localclientnum, 1);
    } else {
      self set_entity_thermal(localclientnum, 0);
    }
  }
}

function set_entity_thermal(localclientnum, b_enabled) {
  if(self.team == "allies") {
    self duplicate_render::set_dr_flag("thermal_friendly_active", b_enabled);
    n_index = 6;
  } else {
    self duplicate_render::set_dr_flag("thermal_enemy_active", b_enabled);
    n_index = 5;
  }
  if(b_enabled) {
    self tmodesetflag(n_index);
  } else {
    self tmodeclearflag(n_index);
  }
}

function activate_thermal_ents(localclientnum) {
  a_e_thermals = getEntArray(localclientnum);
  foreach(entity in a_e_thermals) {
    if(isDefined(entity.b_show_thermal) && entity.b_show_thermal) {
      entity set_entity_thermal(localclientnum, 1);
    }
  }
}

function deactivate_thermal_ents(localclientnum) {
  a_e_thermals = getEntArray(localclientnum);
  foreach(entity in a_e_thermals) {
    if(isDefined(entity.b_show_thermal) && entity.b_show_thermal) {
      entity set_entity_thermal(localclientnum, 0);
    }
  }
}

function structural_weakness_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  level flagsys::wait_till("duplicaterender_registry_ready");
  assert(isDefined(self), "");
  if(newval) {
    self duplicate_render::set_item_enemy_equipment(localclientnum, newval);
  }
}

function tmode_force_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 1) {
    self.b_force_tmode = 1;
    self tmodesetflag(1);
  } else {
    self.b_force_tmode = 0;
    self tmodeclearflag(1);
  }
}

function tagged_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  forcetmodevisible(self, newval);
}

function function_6b87ceb0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread postfx::playpostfxbundle("pstfx_tactical_bootup");
}

function hack_dni_fx(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread postfx::playpostfxbundle("pstfx_hacking_bootup");
  self playSound(0, "uin_hack_mode_activate");
}

function function_3b4d6db0(localclientnum, b_playsound = 1) {
  self tmodeenable(0);
  if(!isDefined(level.var_e46224ba) && !isigcactive(localclientnum) && b_playsound) {
    self thread postfx::playpostfxbundle("pstfx_tactical_bootup");
  }
  self thread tmode_remove_all_ents(localclientnum);
  if(!isigcactive(localclientnum) && b_playsound) {
    self playSound(0, "uin_tac_mode_off");
  }
  level flag::clear("activate_tmode");
}

function function_165838aa(localclientnum, b_playsound = 1) {
  function_22ee3552(localclientnum);
  level flag::set("activate_tmode");
  self tmodeenable(1);
  if(isDefined(level.tmode_override)) {
    [[level.tmode_override]]();
  }
  if(!isDefined(level.var_e46224ba) && b_playsound) {
    self thread postfx::playpostfxbundle("pstfx_tactical_bootup");
  }
  if(b_playsound) {
    self playSound(0, "uin_tac_mode_on");
  }
}

function tmode_player_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self.localclientnum)) {
    return;
  }
  if(self.localclientnum != localclientnum) {
    return;
  }
  if(level flagsys::get("menu_open")) {
    return;
  }
  self notify("tmode_cancel");
  self.var_8b70667f = newval;
  b_playsound = 0;
  if(newval & 2) {
    b_playsound = 1;
  }
  if(newval & 4) {
    self function_165838aa(localclientnum, b_playsound);
  } else {
    self function_3b4d6db0(localclientnum, b_playsound);
  }
}

function sitrep_player_toggle(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self.localclientnum)) {
    return;
  }
  if(self.localclientnum != localclientnum) {
    return;
  }
  self thread player_toggle_sitrep(localclientnum, newval);
}

function player_toggle_sitrep(lcn, newval) {
  self.sitrep_active = newval;
  self oed_sitrepscan_enable(newval);
}

function ent_material_callback(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self endon("entityshutdown");
  assert(isDefined(self), "");
  level flagsys::wait_till("duplicaterender_registry_ready");
  assert(isDefined(self), "");
  if(newval == 0) {
    self notify("hash_1b32b83b");
    self.var_6c4eaf38 = undefined;
    self duplicate_render::change_dr_flags(localclientnum, undefined, "keyline_active,keyfill_active");
    self tmodesetflag(2);
  } else {
    self duplicate_render::change_dr_flags(localclientnum, "keyline_active", "keyfill_active");
    self.var_ac0e7241 = 1;
    self tmodeclearflag(2);
    if(!isDefined(self.var_6c4eaf38)) {
      self.var_6c4eaf38 = 1;
      self thread function_537efcea(localclientnum);
    }
  }
}

function function_537efcea(localclientnum) {
  self endon("death");
  self endon("entityshutdown");
  self endon("hash_1b32b83b");
  player = getlocalplayer(localclientnum);
  player endon("disconnect");
  player endon("entityshutdown");
  var_56f99f06 = 0;
  var_56f99f06 = getdvarfloat("interactivePromptNearToDist", 8.4);
  var_56f99f06 = var_56f99f06 * 39.37;
  while(true) {
    n_dist = distance(self.origin, player.origin);
    var_98b6ad82 = level flag::get("activate_thermal");
    var_d2ca8de = 0;
    if(n_dist <= 90 || n_dist > var_56f99f06 && self.var_ac0e7241 && !var_98b6ad82 && !var_d2ca8de || (var_98b6ad82 || var_d2ca8de && self.var_ac0e7241)) {
      self duplicate_render::change_dr_flags(localclientnum, undefined, "keyline_active,keyfill_active");
      self tmodeclearflag(2);
      self.var_ac0e7241 = 0;
    } else if(n_dist > 90 && n_dist <= var_56f99f06 && !self.var_ac0e7241 && !var_98b6ad82 && !var_d2ca8de) {
      self duplicate_render::change_dr_flags(localclientnum, "keyline_active", "keyfill_active");
      self tmodesetflag(2);
      self.var_ac0e7241 = 1;
    }
    wait(0.016 * randomintrange(1, 10));
  }
}