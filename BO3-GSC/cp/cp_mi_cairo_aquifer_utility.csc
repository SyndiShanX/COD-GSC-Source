/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\cp_mi_cairo_aquifer_utility.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_load;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\duplicaterender_mgr;
#using scripts\shared\enemy_highlight;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\postfx_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using_animtree("generic");
#namespace aquifer_util;

function autoexec __init__sytem__() {
  system::register("aquifer_util", &__init__, undefined, undefined);
}

function __init__() {
  vehicle::add_vehicletype_callback("veh_bo3_mil_vtol_fighter_player_agile", &vtol_spawned);
  vehicle::add_vehicletype_callback("veh_bo3_mil_vtol_fighter_dogfight_enemy", &function_d996daca);
  callback::on_spawned(&on_player_spawned);
  init_clientfields();
  duplicate_render::set_dr_filter_offscreen("weakpoint_keyline", 100, "weakpoint_keyline_show_z", "weakpoint_keyline_hide_z", 2, "mc/hud_outline_model_z_orange", 1);
  thread function_3e82b262();
  thread function_8f62f317();
}

function init_clientfields() {
  clientfield::register("toplayer", "play_body_loop", 1, 1, "int", &function_d00289ef, 0, 0);
  clientfield::register("toplayer", "player_snow_fx", 1, 1, "int", &callback_player_snow_fx_logic, 0, 0);
  clientfield::register("toplayer", "player_bubbles_fx", 1, 1, "int", &function_a0fd353d, 0, 0);
  clientfield::register("toplayer", "player_dust_fx", 1, 1, "int", &function_779fd2e3, 0, 0);
  clientfield::register("toplayer", "water_motes", 1, 1, "int", &function_5c9a971, 0, 0);
  clientfield::register("toplayer", "frost_post_fx", 1, 1, "int", &function_d823aea7, 0, 0);
  clientfield::register("toplayer", "splash_post_fx", 1, 1, "int", &function_90020e42, 0, 0);
  clientfield::register("toplayer", "highlight_ai", 1, 1, "int", &callback_vtol_highlight_ai, 0, 0);
  clientfield::register("actor", "robot_bubbles_fx", 1, 1, "int", &function_a57705db, 0, 0);
  clientfield::register("actor", "kane_bubbles_fx", 1, 1, "int", &function_a57705db, 0, 0);
  clientfield::register("actor", "toggle_enemy_highlight", 1, 1, "int", &function_af7432f, 0, 0);
  clientfield::register("vehicle", "vtol_dogfighting", 1, 1, "int", &function_1f92134d, 0, 0);
  clientfield::register("vehicle", "vtol_show_damage_stages", 1, 1, "int", &function_ae9fc4ae, 0, 0);
  clientfield::register("vehicle", "vtol_canopy_state", 1, 1, "int", &function_4aa99a51, 0, 0);
  clientfield::register("vehicle", "vtol_engines_state", 1, 1, "int", &function_c289f3ee, 0, 0);
  clientfield::register("vehicle", "vtol_enable_wash_fx", 1, 1, "int", &function_efde18b9, 0, 0);
  clientfield::register("vehicle", "vtol_damage_state", 1, 2, "int", &function_31d10546, 0, 0);
  clientfield::register("vehicle", "vtol_set_active_landing_zone_num", 1, 4, "int", &function_791c5d3e, 0, 0);
  clientfield::register("vehicle", "vtol_set_missile_lock_percent", 1, 8, "float", &function_58e7b684, 0, 0);
  clientfield::register("vehicle", "vtol_show_missile_lock", 1, 1, "int", &function_ec8280b9, 0, 0);
  clientfield::register("vehicle", "vtol_screen_shake", 1, 1, "int", &function_51990240, 0, 0);
  clientfield::register("world", "toggle_fog_banks", 1, 1, "int", &function_34474782, 0, 0);
  clientfield::register("world", "toggle_pbg_banks", 1, 1, "int", &function_5240a6bb, 0, 0);
}

function on_player_spawned(localclientnum) {
  self endon("disconnect");
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  self thread watch_player_death();
  while(isDefined(self) && isalive(self)) {
    veh = getplayervehicle(self);
    if(!isDefined(veh)) {
      level thread function_256950b0(localclientnum);
      self waittill("enter_vehicle", veh);
      if(!isDefined(veh)) {
        continue;
      }
    }
    self.vehicle = veh;
    self thread function_1a818d12(localclientnum);
    self thread function_63bf76ee(localclientnum);
    umbra_setdistancescale(localclientnum, 6);
    umbra_setminimumcontributionthreshold(localclientnum, 8);
    setsoundcontext("aquifer_cockpit", "active");
    self waittill("exit_vehicle");
    self.vehicle = undefined;
    level thread function_256950b0(localclientnum);
    setsoundcontext("aquifer_cockpit", "");
    if(isDefined(self.var_ae2d4705)) {
      self stoploopsound(self.var_ae2d4705);
      self.var_ae2d4705 = undefined;
    }
  }
}

function function_256950b0(localclientnum) {
  umbra_setdistancescale(localclientnum, 1);
  umbra_setminimumcontributionthreshold(localclientnum, 0);
}

function function_8f62f317() {
  while(true) {
    level waittill("save_restore");
    while(getlocalplayers().size == 0) {
      wait(0.016);
    }
    foreach(player in getlocalplayers()) {
      veh = getplayervehicle(player);
      if(isDefined(veh)) {
        localclientnum = player getlocalclientnumber();
        player.vehicle = veh;
      }
    }
  }
}

function watch_player_death() {
  self notify("watch_player_death");
  self endon("watch_player_death");
  self endon("disconnect");
  self waittill("death");
  if(isDefined(self) && isDefined(self.var_ae2d4705)) {
    self stoploopsound(self.var_ae2d4705);
    self.var_ae2d4705 = undefined;
  }
}

function function_b69b9863(localclientnum, oldval, newval, bnewent, binitialsnap) {
  if(!self islocalplayer()) {
    return false;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return false;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return false;
  }
  return true;
}

function function_d00289ef(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(binitialsnap) {
    return;
  }
  struct = getent(localclientnum, "igc_kane_khalil_1", "targetname");
  struct thread scene::play("cin_aqu_03_20_water_room_body_loop");
}

function callback_vtol_highlight_ai(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval == newval && !binitialsnap) {
    return;
  }
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  switch (newval) {
    case 0: {
      self thread namespace_68dfcbbe::enemy_highlight_display_stop(localclientnum);
      break;
    }
    case 1: {
      self thread namespace_68dfcbbe::enemy_highlight_display(localclientnum, "compassping_enemysatellite_diamond", 64, 1, 2, 1, "compassping_friendly");
      break;
    }
  }
}

function function_5c9a971(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  if(newval != 0) {
    self.var_8e8c7340 = playfxoncamera(localclientnum, "water/fx_underwater_debris_player_loop", (0, 0, 0), (1, 0, 0), (0, 0, 1));
  } else if(isDefined(self.var_8e8c7340)) {
    deletefx(localclientnum, self.var_8e8c7340, 1);
  }
}

function function_779fd2e3(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  if(newval == 1) {
    if(isDefined(self.var_766e336e)) {
      deletefx(localclientnum, self.var_766e336e, 1);
    }
    self.var_766e336e = playfxoncamera(localclientnum, "dirt/fx_dust_sand_aquifer_player_loop", (0, 0, 0), (1, 0, 0), (0, 0, 1));
  } else {
    self notify("hash_1f63111d");
    if(isDefined(self.var_766e336e)) {
      deletefx(localclientnum, self.var_766e336e, 1);
      self.var_766e336e = undefined;
    }
  }
}

function function_d823aea7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread postfx::playpostfxbundle("pstfx_frost_loop");
  } else {
    self thread postfx::exitpostfxbundle();
  }
}

function function_90020e42(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self thread postfx::playpostfxbundle("pstfx_water_t_out");
  } else {
    self thread postfx::exitpostfxbundle();
  }
}

function callback_player_snow_fx_logic(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  if(newval == 1) {
    if(isDefined(self.snow_fx_id)) {
      deletefx(localclientnum, self.snow_fx_id, 1);
    }
    setpbgactivebank(localclientnum, 2);
    self.snow_fx_id = playFXOnTag(localclientnum, "snow/fx_snow_player_aqu_loop", self, "tag_origin");
  } else {
    setpbgactivebank(localclientnum, 1);
    self notify("snow_fx_stop");
    if(isDefined(self.snow_fx_id)) {
      deletefx(localclientnum, self.snow_fx_id, 1);
      self.snow_fx_id = undefined;
    }
  }
}

function function_a0fd353d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  if(newval == 1) {
    if(isDefined(self.var_8f4881d8)) {
      deletefx(localclientnum, self.var_8f4881d8, 1);
    }
    self.var_8f4881d8 = playfxoncamera(localclientnum, "player/fx_plyr_swim_bubbles_body", (0, 0, 0), (1, 0, 0), (0, 0, 1));
  } else {
    self notify("hash_6b998eb7");
    if(isDefined(self.var_8f4881d8)) {
      deletefx(localclientnum, self.var_8f4881d8, 1);
      self.var_8f4881d8 = undefined;
    }
  }
}

function function_a57705db(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  if(newval == 1) {
    if(isDefined(self.var_8f4881d8)) {
      stopfx(localclientnum, self.var_8f4881d8);
    }
    self.n_fx_id = playFXOnTag(localclientnum, "player/fx_plyr_swim_bubbles_body", self, "tag_aim");
  } else {
    self notify("hash_fcaf4326");
    if(isDefined(self.var_8f4881d8)) {
      stopfx(localclientnum, self.var_8f4881d8);
    }
  }
}

function function_48637c84(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  switch (newval) {
    case 0: {
      setsaveddvar("r_dof_aperture_override", 1);
      break;
    }
    case 1: {
      setsaveddvar("r_dof_aperture_override", 50);
      break;
    }
  }
}

function function_1122caac(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  switch (newval) {
    case 0: {
      setsaveddvar("", 40);
      setsaveddvar("", 50);
      setsaveddvar("", 6000);
      setsaveddvar("", 10000);
      break;
    }
    case 1: {
      setsaveddvar("", 50);
      setsaveddvar("", 150);
      break;
    }
  }
}

function function_31d10546(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("hash_31d10546");
  self endon("hash_31d10546");
  local_player = getlocalplayer(localclientnum);
  player_vehicle = getplayervehicle(local_player);
  while(!isDefined(player_vehicle) && isDefined(local_player) && isalive(local_player)) {
    wait(0.05);
    if(isDefined(local_player)) {
      player_vehicle = getplayervehicle(local_player);
    }
  }
  if(!isDefined(player_vehicle) || !isDefined(local_player) || self != player_vehicle) {
    return;
  }
  local_player.var_d7bfa708 = newval;
  local_player notify("hash_751c841");
}

function function_1f92134d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  player_vehicle = getplayervehicle(getlocalplayer(localclientnum));
  if(!bnewent && !binitialsnap && oldval == newval) {
    return;
  }
  switch (newval) {
    case 0: {
      self.dogfighting = 0;
      if(isDefined(player_vehicle) && player_vehicle == self) {
        playSound(localclientnum, "veh_bullshark_dogfight_exit");
        if(isDefined(self.var_163163d4)) {
          self stoploopsound(self.var_163163d4);
          self.var_163163d4 = undefined;
        }
        if(isDefined(self.var_144b2dd7)) {
          self stoploopsound(self.var_144b2dd7);
          self.var_144b2dd7 = undefined;
        }
        self notify("hash_71c3f064");
      } else {
        self.var_58f8ead2 = 0;
      }
      break;
    }
    case 1: {
      self.dogfighting = 1;
      if(isDefined(player_vehicle) && player_vehicle == self) {
        playSound(localclientnum, "veh_bullshark_dogfight_enter");
        self.var_163163d4 = self playLoopSound("veh_bullshark_dogfight_maneuvers");
        self.var_144b2dd7 = self playLoopSound("veh_bullshark_dogfight_turbulence");
        self setloopstate("veh_bullshark_dogfight_maneuvers", 0.5, 1);
        self setloopstate("veh_bullshark_dogfight_turbulence", 0, 1);
      } else {
        self thread function_5e259b76(localclientnum);
      }
      break;
    }
  }
}

function function_ae9fc4ae(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  switch (newval) {
    case 0: {
      self flagsys::clear("show_damage_stages");
      break;
    }
    case 1: {
      self flagsys::set("show_damage_stages");
      self thread function_38f84ce8(localclientnum);
      break;
    }
  }
}

function function_4aa99a51(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval == newval && (!(binitialsnap || bnewent))) {
    return;
  }
  self useanimtree($generic);
  anims = [];
  anims[0] = % generic::v_aqu_vtol_cockpit_close;
  anims[1] = % generic::v_aqu_vtol_cockpit_open;
  assert(newval >= 0 && newval <= 1);
  self setanim(anims[newval], 1, 0, 1);
  self setanim(anims[!newval], 0, 0, 1);
}

function function_c289f3ee(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(oldval == newval && (!(binitialsnap || bnewent))) {
    return;
  }
  self useanimtree($generic);
  anims = [];
  anims[0] = % generic::v_aqu_vtol_engine_hover;
  anims[1] = % generic::v_aqu_vtol_engine_fly;
  assert(newval >= 0 && newval <= 1);
  self setanim(anims[newval], 1, 0, 1);
  self setanim(anims[!newval], 0, 0, 1);
  if(newval == 0) {
    self setanim(%generic::v_aqu_vtol_engine_idle, 1, 0, 1);
  } else {
    self setanim(%generic::v_aqu_vtol_engine_idle, 0, 0, 1);
  }
}

function function_7c706c83(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isDefined(self getlocalclientnumber())) {
    return;
  }
  if(self getlocalclientnumber() != localclientnum) {
    return;
  }
  self.var_443f7e14 = newval;
}

function function_791c5d3e(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("hash_791c5d3e");
  self endon("hash_791c5d3e");
  local_player = getlocalplayer(localclientnum);
  player_vehicle = getplayervehicle(local_player);
  while(!isDefined(player_vehicle) && isDefined(local_player) && isalive(local_player)) {
    wait(0.05);
    if(isDefined(local_player)) {
      player_vehicle = getplayervehicle(local_player);
    }
  }
  if(!isDefined(player_vehicle) || !isDefined(local_player) || self != player_vehicle) {
    return;
  }
  if(!isDefined(local_player.var_4c67c5eb)) {
    local_player.var_4c67c5eb = [];
  }
  foreach(landing_zone in local_player.var_4c67c5eb) {
    landing_zone fx_delete_type(localclientnum, "vtol_landing_zone");
  }
  local_player.var_4c67c5eb = [];
  indices = [];
  for(i = 3; i >= 0; i--) {
    var_8e34c2ec = pow(2, i);
    if(newval >= var_8e34c2ec) {
      indices[indices.size] = i + 1;
      newval = newval - var_8e34c2ec;
    }
  }
  var_dda84f1a = getEntArray(localclientnum, "landing_zone", "targetname");
  foreach(landing_zone in var_dda84f1a) {
    foreach(index in indices) {
      if(isDefined(landing_zone.script_noteworthy) && int(landing_zone.script_noteworthy) == index) {
        array::add(local_player.var_4c67c5eb, landing_zone, 0);
        landing_zone fx_play(localclientnum, "vtol_landing_zone", "light/fx_beam_vtol_landing_zone", landing_zone.origin, anglesToForward(landing_zone.angles), (0, 0, 1));
        break;
      }
    }
  }
}

function function_58e7b684(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("hash_58e7b684");
  self endon("hash_58e7b684");
  local_player = getlocalplayer(localclientnum);
  player_vehicle = getplayervehicle(local_player);
  while(!isDefined(player_vehicle) && isDefined(local_player) && isalive(local_player)) {
    wait(0.05);
    if(isDefined(local_player)) {
      player_vehicle = getplayervehicle(local_player);
    }
  }
  if(!isDefined(player_vehicle) || !isDefined(local_player) || self != player_vehicle) {
    return;
  }
  if(!isDefined(local_player.var_14351725)) {
    local_player.var_14351725 = newval;
    local_player thread function_4c53e7bf(localclientnum);
  }
  if(newval < 1 && local_player.var_14351725 >= 1) {
    if(isDefined(local_player.var_ae2d4705)) {
      local_player stoploopsound(local_player.var_ae2d4705);
      local_player.var_ae2d4705 = undefined;
    }
  } else if(newval >= 1 && local_player.var_14351725 < 1) {
    local_player.var_ae2d4705 = local_player playLoopSound("veh_bullshark_missile_locked");
  }
  local_player.var_14351725 = newval;
}

function function_ec8280b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("hash_ec8280b9");
  self endon("hash_ec8280b9");
  local_player = getlocalplayer(localclientnum);
  player_vehicle = getplayervehicle(local_player);
  while(!isDefined(player_vehicle) && isDefined(local_player) && isalive(local_player)) {
    wait(0.05);
    if(isDefined(local_player)) {
      player_vehicle = getplayervehicle(local_player);
    }
  }
  if(!isDefined(player_vehicle) || !isDefined(local_player) || self != player_vehicle) {
    return;
  }
  local_player.var_b83262c7 = newval;
}

function function_51990240(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("hash_51990240");
  self endon("hash_51990240");
  local_player = getlocalplayer(localclientnum);
  player_vehicle = getplayervehicle(local_player);
  while(!isDefined(player_vehicle) && isDefined(local_player) && isalive(local_player)) {
    wait(0.05);
    if(isDefined(local_player)) {
      player_vehicle = getplayervehicle(local_player);
    }
  }
  if(!isDefined(player_vehicle) || !isDefined(local_player) || self != player_vehicle) {
    return;
  }
  scale = 0.1;
  if(newval) {
    while(isDefined(self) && isDefined(local_player) && (!(isDefined(self.dogfighting) && self.dogfighting))) {
      local_player earthquake(scale, 0.05, local_player.origin, 1000);
      wait(0.05);
    }
  } else {
    while(isDefined(self) && scale >= 0.01 && isDefined(local_player) && (!(isDefined(self.dogfighting) && self.dogfighting))) {
      local_player earthquake(scale, 0.05, local_player.origin, 1000);
      wait(0.05);
      scale = scale * 0.99;
    }
  }
}

function function_efde18b9(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval == 0) {
    self notify("hash_72fd2c6a");
    if(isDefined(self.var_594d1ec6)) {
      self.var_594d1ec6 fx_delete_type(localclientnum, "wash", 0);
      self.var_594d1ec6 delete();
      self.var_594d1ec6 = undefined;
    }
  } else {
    self thread function_7946d98(localclientnum);
  }
}

function function_7946d98(localclientnum) {
  self endon("death");
  self endon("hash_72fd2c6a");
  self notify("hash_7946d98");
  self endon("hash_7946d98");
  if(!isDefined(self.var_594d1ec6)) {
    self.var_594d1ec6 = util::spawn_model(localclientnum, "tag_origin", self.origin);
  }
  while(isDefined(self)) {
    start = self gettagorigin("tag_driver");
    trace = bulletTrace(start, start - vectorscale((0, 0, 1), 300), 0, self);
    if(trace["fraction"] == 1 && isDefined(self.var_594d1ec6)) {
      self.var_594d1ec6 fx_delete_type(localclientnum, "wash", 0);
    } else if(trace["fraction"] < 1) {
      self.var_594d1ec6.origin = trace["position"];
      var_7788a7d = vectortoangles(trace["normal"]);
      self.var_594d1ec6.angles = (0, var_7788a7d[0], 0);
      if(!self.var_594d1ec6 function_766878c8(localclientnum, "wash")) {
        self.var_594d1ec6 fx_play_on_tag(localclientnum, "wash", "dirt/fx_dust_rotorwash_vtol_loop", "tag_origin");
      }
    }
    wait(0.016);
  }
}

function function_3b907fc(localclientnum) {
  menuname = "VehicleHUD_VTOL_Target";
  var_535afdd7 = getluimenu(localclientnum, menuname);
  if(!isDefined(var_535afdd7)) {
    self.var_58eaeac1 = createluimenu(localclientnum, menuname);
    setluimenudata(localclientnum, self.var_58eaeac1, "newTarget", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "targetWidth", 1280);
    setluimenudata(localclientnum, self.var_58eaeac1, "targetHeight", 720);
    setluimenudata(localclientnum, self.var_58eaeac1, "targetX", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "targetY", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRotZ", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetWidth", 192);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetHeight", 192);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetX", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetY", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetLerpTime", 50);
    setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 1);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 1);
    setluimenudata(localclientnum, self.var_58eaeac1, "close_current_menu", 0);
    openluimenu(localclientnum, self.var_58eaeac1);
  } else {
    self.var_58eaeac1 = var_535afdd7;
  }
}

function function_1a818d12(localclientnum) {
  self notify("hash_1a818d12");
  self endon("hash_1a818d12");
  self endon("death");
  self function_3b907fc(localclientnum);
  self thread function_d2243c73(localclientnum);
  self thread function_21e63f39(localclientnum);
  self thread function_11381ece(localclientnum);
  str_return = self util::waittill_any_return("exit_vehicle");
  if(isDefined(self)) {
    self function_3b907fc(localclientnum);
    setluimenudata(localclientnum, self.var_58eaeac1, "close_current_menu", 1);
    wait(0.75);
    self function_3b907fc(localclientnum);
    closeluimenu(localclientnum, self.var_58eaeac1);
  }
}

function function_11381ece(localclientnum) {
  self notify("hash_11381ece");
  self endon("hash_11381ece");
  self endon("exit_vehicle");
  self endon("death");
  while(isDefined(self) && isalive(self)) {
    var_d87d3f09 = self gettargetlockentityarray();
    if(var_d87d3f09.size > 0 && (!isDefined(self.missile_target) || var_d87d3f09[0] != self.missile_target)) {
      self.missile_target = var_d87d3f09[0];
      self notify("hash_6c567715");
    } else if(var_d87d3f09.size == 0 && isDefined(self.missile_target)) {
      self.missile_target = undefined;
      self notify("hash_6c567715");
    }
    wait(0.016);
  }
}

function function_d2243c73(localclientnum) {
  self notify("hash_d2243c73");
  self endon("hash_d2243c73");
  self endon("exit_vehicle");
  self endon("death");
  while(isDefined(self) && isalive(self)) {
    self waittill("hash_6c567715");
    if(!isDefined(self)) {
      return;
    }
    if(isDefined(self.missile_target)) {
      entpos = self.missile_target gettagorigin("tag_body");
      if(!isDefined(entpos)) {
        entpos = self.missile_target.origin;
      }
      self.missile_target.screenproj = project3dto2d(localclientnum, entpos);
    }
    while(isDefined(self) && isDefined(self.missile_target) && isalive(self.missile_target) && (self.missile_target.screenproj[0] < 128 || self.missile_target.screenproj[0] > 1152 || self.missile_target.screenproj[1] < 72 || self.missile_target.screenproj[2] > 648)) {
      entpos = self.missile_target gettagorigin("tag_body");
      if(!isDefined(entpos)) {
        entpos = self.missile_target.origin;
      }
      self.missile_target.screenproj = project3dto2d(localclientnum, entpos);
      wait(0.016);
    }
    if(!isDefined(self)) {
      return;
    }
    self function_3b907fc(localclientnum);
    setluimenudata(localclientnum, self.var_58eaeac1, "newTarget", 1);
    while(isDefined(self) && isDefined(self.missile_target) && isDefined(self.missile_target.screenproj) && isalive(self.missile_target) && !self.missile_target ishidden()) {
      entpos = self.missile_target gettagorigin("tag_body");
      if(!isDefined(entpos)) {
        entpos = self.missile_target.origin;
      }
      self.missile_target.screenproj = project3dto2d(localclientnum, entpos);
      self function_3b907fc(localclientnum);
      setluimenudata(localclientnum, self.var_58eaeac1, "targetX", self.missile_target.screenproj[0]);
      setluimenudata(localclientnum, self.var_58eaeac1, "targetY", self.missile_target.screenproj[1]);
      wait(0.016);
    }
    if(!isDefined(self)) {
      return;
    }
    self function_3b907fc(localclientnum);
    setluimenudata(localclientnum, self.var_58eaeac1, "newTarget", 0);
  }
  self function_3b907fc(localclientnum);
  setluimenudata(localclientnum, self.var_58eaeac1, "newTarget", 0);
}

function function_21e63f39(localclientnum) {
  self notify("hash_29a67729");
  self endon("hash_29a67729");
  self endon("exit_vehicle");
  self endon("death");
  max_radius = 162.5;
  locked = 0;
  var_beb0eb1e = 0.6;
  var_e64062c8 = 0.3;
  var_bcd414e9 = 540;
  var_428be7c0 = 192;
  aspect = viewaspect(localclientnum);
  height = 360;
  width = height * aspect;
  while(isDefined(self) && isalive(self)) {
    self waittill("hash_6c567715");
    while(isDefined(self) && (!(isDefined(self.var_b83262c7) && self.var_b83262c7))) {
      wait(0.016);
    }
    while(isDefined(self) && isDefined(self.missile_target) && isalive(self.missile_target) && !self.missile_target ishidden()) {
      self function_3b907fc(localclientnum);
      if(isDefined(self.var_14351725)) {
        entpos = self.missile_target gettagorigin("tag_body");
        if(!isDefined(entpos)) {
          entpos = self.missile_target.origin;
        }
        self.missile_target.screenproj = project3dto2d(localclientnum, entpos);
        scale = var_e64062c8 + (var_beb0eb1e - var_e64062c8) * (1 - self.var_14351725);
        offset = (self.missile_target.screenproj[0] - width, self.missile_target.screenproj[1] - height, 0);
        dist = length(offset);
        if(dist > (max_radius - ((var_428be7c0 * 0.5) * scale))) {
          dir = vectornormalize(offset);
          offset = dir * (max_radius - ((var_428be7c0 * 0.5) * scale));
        }
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetLerpTime", 50);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetX", width + offset[0]);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetY", height + offset[1]);
        if(self.var_14351725 >= 1) {
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRotZ", ((self getclienttime() % 1000) / 1000) * var_bcd414e9);
          setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 1);
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", var_e64062c8);
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 0);
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 0);
        } else {
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRotZ", self.var_14351725 * var_bcd414e9);
          setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 0.33);
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", scale);
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 1);
          setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 1);
        }
      } else {
        setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 0.33);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", var_beb0eb1e);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetLerpTime", 250);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetX", width);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetY", height);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 1);
        setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 1);
      }
      wait(0.016);
    }
    if(!isDefined(self)) {
      return;
    }
    self function_3b907fc(localclientnum);
    setluimenudata(localclientnum, self.var_58eaeac1, "material", "uie_t7_cp_hud_vehicle_vtol_lockoncircle");
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetAlpha", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetScale", var_beb0eb1e);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRotZ", 0);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetLerpTime", 250);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetX", width);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetY", height);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetRed", 1);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetGreen", 1);
    setluimenudata(localclientnum, self.var_58eaeac1, "missileLockTargetBlue", 1);
  }
}

function function_458ed430() {
  var_50e4abf2 = [];
  var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_1";
  var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_2";
  var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_3";
  var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_4";
  var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_5";
  var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_6";
  var_50e4abf2[var_50e4abf2.size] = "tag_fx_cockpit_7";
  return array::randomize(var_50e4abf2);
}

function function_63bf76ee(localclientnum) {
  self notify("hash_63bf76ee");
  self endon("hash_63bf76ee");
  self endon("disconnect");
  num_damage_states = 2;
  self.var_d7bfa708 = 0;
  var_614619a5 = [];
  for(i = 0; i < num_damage_states; i++) {
    var_614619a5[i] = [];
  }
  var_50e4abf2 = function_458ed430();
  var_59fc256 = [];
  var_59fc256[var_59fc256.size] = 3;
  var_59fc256[var_59fc256.size] = 3;
  while(isDefined(self) && isDefined(self.vehicle)) {
    self waittill("hash_751c841");
    if(!isDefined(self) || !isDefined(self.vehicle) || !isDefined(self.var_d7bfa708)) {
      break;
    }
    if(self.var_d7bfa708 == 0) {
      foreach(damage_state in var_614619a5) {
        foreach(damage_fx in damage_state) {
          killfx(localclientnum, damage_fx);
        }
        damage_state = [];
      }
      var_50e4abf2 = function_458ed430();
    } else {
      index = self.var_d7bfa708 - 1;
      damage_fx = "electric/fx_elec_vtol_dmg_runner";
      if(self.var_d7bfa708 > 1) {
        damage_fx = "electric/fx_elec_vtol_dmg_runner";
      }
      for(i = 0; i < var_59fc256[index]; i++) {
        var_614619a5[index][var_614619a5[index].size] = playFXOnTag(localclientnum, damage_fx, self.vehicle, array::pop(var_50e4abf2));
      }
    }
  }
  foreach(damage_state in var_614619a5) {
    foreach(damage_fx in damage_state) {
      killfx(localclientnum, damage_fx);
    }
    damage_state = [];
  }
}

function function_38f84ce8(localclientnum) {
  if(isDefined(self.var_38f84ce8) && self.var_38f84ce8) {
    return;
  }
  self.var_38f84ce8 = 1;
  damage_fx = [];
  var_b1e0b5bc = -1;
  ent = self;
  while(isDefined(self) && isalive(self) && flagsys::get("show_damage_stages")) {
    if(isDefined(var_b1e0b5bc) && var_b1e0b5bc != self gethelidamagestate()) {
      var_b1e0b5bc = self gethelidamagestate();
      switch (var_b1e0b5bc) {
        case 1: {
          damage_fx[damage_fx.size] = playFXOnTag(localclientnum, "vehicle/fx_vtol_dmg_trail_01", self, "tag_body");
          break;
        }
        case 2: {
          damage_fx[damage_fx.size] = playFXOnTag(localclientnum, "vehicle/fx_vtol_dmg_trail_02", self, "tag_body");
          break;
        }
        case 3: {
          playFX(localclientnum, "vehicle/fx_vtol_dmg_trail_03", self gettagorigin("tag_body"), anglesToForward(self gettagangles("tag_body")));
          break;
        }
      }
      if(var_b1e0b5bc == 3) {
        break;
      }
    }
    level waittill("hash_fb60a9dc");
  }
  foreach(fx in damage_fx) {
    killfx(localclientnum, fx);
  }
  if(isDefined(self)) {
    self.var_38f84ce8 = undefined;
  }
}

function function_4c53e7bf(localclientnum) {
  self endon("disconnect");
  while(isDefined(self) && isDefined(self.var_14351725) && isalive(self)) {
    if(self.var_14351725 > 0 && self.var_14351725 < 1) {
      self playSound(localclientnum, "veh_bullshark_missile_locking");
      wait((1 - self.var_14351725) * 0.5);
    } else {
      wait(0.016);
    }
  }
}

function vtol_spawned(localclientnum) {
  self.dogfighting = 0;
  self.no_highlight = 1;
  self thread function_c0623e13(localclientnum);
  self useanimtree($generic);
  self setanim(%generic::v_aqu_vtol_engine_hover, 1, 0, 1);
  self setanim(%generic::v_aqu_vtol_engine_idle, 1, 0, 1);
}

function function_d996daca(localclientnum) {
  self.no_highlight = 1;
}

function function_c0623e13(localclientnum) {
  self endon("death");
  var_a2c58ba3 = "off";
  var_14386bda = "off";
  var_80cad4ec = "off";
  var_2cdec570 = "off";
  var_bd5365a3 = "off";
  var_20282599 = "off";
  var_594f1b7d = self.angles;
  var_48ca4678 = self getvelocity() / 17.6;
  self fx_play_on_tag(localclientnum, "running_lights", "vehicle/fx_vtol_formation_lights", "tag_body_animate", 0, 0);
  self fx_play_on_tag(localclientnum, "running_lights", "vehicle/fx_vtol_taileron_lights_l", "tag_taileron_l_animate", 0, 0);
  self fx_play_on_tag(localclientnum, "running_lights", "vehicle/fx_vtol_taileron_lights_r", "tag_taileron_r_animate", 0, 0);
  while(isDefined(self) && isalive(self) && self hasdobj(localclientnum)) {
    velocity = self getvelocity() / 17.6;
    var_27f6615e = velocity - var_48ca4678;
    accel = var_27f6615e / 0.016;
    angle_diff = self.angles - var_594f1b7d;
    angle_diff = (angleclamp180(angle_diff[0]), angleclamp180(angle_diff[1]), angleclamp180(angle_diff[2]));
    rot_vel = angle_diff / 0.016;
    if(self.dogfighting) {
      if(var_2cdec570 != "off") {
        self fx_delete_type(localclientnum, "vtol_hover_thrust");
        var_2cdec570 = "off";
      }
      if(var_bd5365a3 != "off") {
        self fx_delete_type(localclientnum, "vtol_roll_thrust");
        var_bd5365a3 = "off";
      }
      if(var_20282599 != "off") {
        self fx_delete_type(localclientnum, "vtol_brake_thrust");
        var_20282599 = "off";
      }
      if(abs(angle_diff[0]) <= 5 && var_a2c58ba3 != "off") {
        self fx_delete_type(localclientnum, "vtol_pitch_fx");
        var_a2c58ba3 = "off";
      } else {
        if(abs(angle_diff[0]) > 5 && abs(angle_diff[0]) <= 10 && var_a2c58ba3 != "low") {
          self fx_delete_type(localclientnum, "vtol_pitch_fx");
          self fx_play_on_tag(localclientnum, "vtol_pitch_fx", "vehicle/fx_vtol_vapor_light", "tag_body_animate");
          var_a2c58ba3 = "low";
        } else if(abs(angle_diff[0]) > 10 && var_a2c58ba3 != "high") {
          self fx_delete_type(localclientnum, "vtol_pitch_fx");
          self fx_play_on_tag(localclientnum, "vtol_pitch_fx", "vehicle/fx_vtol_vapor_extreme", "tag_body_animate");
          var_a2c58ba3 = "high";
        }
      }
      if(absangleclamp180(self.angles[2]) < 30 && var_14386bda != "off") {
        self fx_delete_type(localclientnum, "vtol_roll_fx");
        var_14386bda = "off";
      } else if(absangleclamp180(self.angles[2]) >= 30 && var_14386bda != "on") {
        self fx_play_on_tag(localclientnum, "vtol_roll_fx", "vehicle/fx_vtol_contrail", "tag_body_animate");
        var_14386bda = "on";
      }
      var_6c17606c = var_80cad4ec;
      if(self getspeed() <= 400 && var_80cad4ec != "off") {
        self fx_delete_type(localclientnum, "vtol_afterburn_fx");
        var_80cad4ec = "off";
      } else if(self getspeed() > 400 && var_80cad4ec != "on") {
        self fx_play_on_tag(localclientnum, "vtol_afterburn_fx", "vehicle/fx_vtol_thruster_afterburn", "tag_fx_engine_left", 0, 0);
        self fx_play_on_tag(localclientnum, "vtol_afterburn_fx", "vehicle/fx_vtol_thruster_afterburn", "tag_fx_engine_right", 0, 0);
        var_80cad4ec = "on";
      }
      player_vehicle = getplayervehicle(getlocalplayer(localclientnum));
      if(isDefined(player_vehicle) && player_vehicle == self) {
        self setloopstate("veh_bullshark_dogfight_turbulence", abs(self.angles[2]) / 90, 1);
        self setloopstate("veh_bullshark_dogfight_maneuvers", 1 - (abs(self.angles[2]) / 90), 1);
        if(var_6c17606c != var_80cad4ec) {
          if(var_80cad4ec == "on") {
            self playSound(localclientnum, "veh_bullshark_boost");
            self.var_cb5468ff = self playLoopSound("veh_bullshark_sprint_lp");
          } else {
            self playSound(localclientnum, "veh_bullshark_sprint_exit");
            if(isDefined(self.var_cb5468ff)) {
              self stoploopsound(self.var_cb5468ff);
              self.var_cb5468ff = undefined;
            }
          }
        }
      }
    } else {
      if(var_a2c58ba3 != "off") {
        self fx_delete_type(localclientnum, "vtol_pitch_fx");
        var_a2c58ba3 = "off";
      }
      if(var_14386bda != "off") {
        self fx_delete_type(localclientnum, "vtol_roll_fx");
        var_14386bda = "off";
      }
      if(var_2cdec570 == "off") {
        self fx_play_on_tag(localclientnum, "vtol_hover_thrust", "vehicle/fx_vtol_thruster_wing_aquifer", "tag_fx_roll_nozzle_l_2", 0, 0);
        self fx_play_on_tag(localclientnum, "vtol_hover_thrust", "vehicle/fx_vtol_thruster_wing_aquifer", "tag_fx_roll_nozzle_r_2", 0, 0);
        var_2cdec570 = "on";
      }
      if(var_80cad4ec != "off") {
        self fx_delete_type(localclientnum, "vtol_afterburn_fx");
        var_80cad4ec = "off";
        player_vehicle = getplayervehicle(getlocalplayer(localclientnum));
        if(isDefined(player_vehicle) && player_vehicle == self) {
          self playSound(localclientnum, "veh_bullshark_sprint_exit");
          if(isDefined(self.var_cb5468ff)) {
            self stoploopsound(self.var_cb5468ff);
            self.var_cb5468ff = undefined;
          }
        }
      }
      if(abs(rot_vel[2]) <= 5 && absangleclamp180(self.angles[2] <= 5) && var_bd5365a3 != "off") {
        self fx_delete_type(localclientnum, "vtol_roll_thrust");
        var_bd5365a3 = "off";
      } else {
        if(rot_vel[2] > 5 && var_bd5365a3 != "left") {
          self fx_play_on_tag(localclientnum, "vtol_roll_thrust", "vehicle/fx_vtol_thruster_wing_aquifer_brake", "tag_fx_roll_nozzle_l_2");
          var_bd5365a3 = "left";
        } else if(rot_vel[2] < -5 && var_bd5365a3 != "right") {
          self fx_play_on_tag(localclientnum, "vtol_roll_thrust", "vehicle/fx_vtol_thruster_wing_aquifer_brake", "tag_fx_roll_nozzle_r_2");
          var_bd5365a3 = "right";
        }
      }
      if(accel[2] <= 50 && velocity[2] <= 25 && var_20282599 != "off") {
        self fx_delete_type(localclientnum, "vtol_brake_thrust");
        var_20282599 = "off";
      } else if(accel[2] > 50 || velocity[2] > 25 && var_20282599 != "on") {
        self fx_play_on_tag(localclientnum, "vtol_brake_thrust", "vehicle/fx_vtol_thruster_wing_aquifer_brake", "tag_fx_roll_nozzle_l_2", 0, 0);
        self fx_play_on_tag(localclientnum, "vtol_brake_thrust", "vehicle/fx_vtol_thruster_wing_aquifer_brake", "tag_fx_roll_nozzle_r_2", 0, 0);
        var_20282599 = "on";
      }
    }
    var_594f1b7d = self.angles;
    var_48ca4678 = velocity;
    wait(0.016);
  }
  if(isDefined(self)) {
    if(var_2cdec570 != "off") {
      self fx_delete_type(localclientnum, "vtol_hover_thrust");
      var_2cdec570 = "off";
    }
    if(var_bd5365a3 != "off") {
      self fx_delete_type(localclientnum, "vtol_roll_thrust");
      var_bd5365a3 = "off";
    }
    if(var_20282599 != "off") {
      self fx_delete_type(localclientnum, "vtol_brake_thrust");
      var_20282599 = "off";
    }
    if(var_a2c58ba3 != "off") {
      self fx_delete_type(localclientnum, "vtol_pitch_fx");
      var_a2c58ba3 = "off";
    }
    if(var_14386bda != "off") {
      self fx_delete_type(localclientnum, "vtol_roll_fx");
      var_14386bda = "off";
    }
    if(var_80cad4ec != "off") {
      self fx_delete_type(localclientnum, "vtol_afterburn_fx");
      var_80cad4ec = "off";
    }
    if(isDefined(self.var_cb5468ff)) {
      self stoploopsound(self.var_cb5468ff);
      self.var_cb5468ff = undefined;
    }
    self fx_delete_type(localclientnum, "running_lights");
  }
}

function function_5e259b76(localclientnum) {
  self endon("death");
  if(isDefined(self.var_58f8ead2) && self.var_58f8ead2) {
    return;
  }
  var_a2c58ba3 = "off";
  var_14386bda = "off";
  var_80cad4ec = "off";
  self fx_play_on_tag(localclientnum, "running_lights", "vehicle/fx_vtol_formation_lights", "tag_body_animate", 0, 0);
  self fx_play_on_tag(localclientnum, "running_lights", "vehicle/fx_vtol_taileron_lights_l", "tag_taileron_l_animate", 0, 0);
  self fx_play_on_tag(localclientnum, "running_lights", "vehicle/fx_vtol_taileron_lights_r", "tag_taileron_r_animate", 0, 0);
  self.var_58f8ead2 = 1;
  anim_angles = self gettagangles("tag_body_animate");
  var_80d8531 = anim_angles;
  while(isDefined(self) && isalive(self) && (isDefined(self.var_58f8ead2) && self.var_58f8ead2)) {
    anim_angles = self gettagangles("tag_body_animate");
    self.var_786fcc03 = (anim_angles - var_80d8531) / 0.016;
    if(abs(self.var_786fcc03[0]) <= 5 && var_a2c58ba3 != "off") {
      self fx_delete_type(localclientnum, "vtol_pitch_fx");
      var_a2c58ba3 = "off";
    } else {
      if(abs(self.var_786fcc03[0]) > 5 && abs(self.var_786fcc03[0]) <= 10 && var_a2c58ba3 != "low") {
        self fx_delete_type(localclientnum, "vtol_pitch_fx");
        self fx_play_on_tag(localclientnum, "vtol_pitch_fx", "vehicle/fx_vtol_vapor_light", "tag_body_animate");
        var_a2c58ba3 = "low";
      } else if(abs(self.var_786fcc03[0]) > 10 && var_a2c58ba3 != "high") {
        self fx_delete_type(localclientnum, "vtol_pitch_fx");
        self fx_play_on_tag(localclientnum, "vtol_pitch_fx", "vehicle/fx_vtol_vapor_extreme", "tag_body_animate");
        var_a2c58ba3 = "high";
      }
    }
    if(absangleclamp180(anim_angles[2]) < 30 && var_14386bda != "off") {
      self fx_delete_type(localclientnum, "vtol_roll_fx");
      var_14386bda = "off";
    } else if(absangleclamp180(anim_angles[2]) >= 30 && var_14386bda != "on") {
      self fx_play_on_tag(localclientnum, "vtol_roll_fx", "vehicle/fx_vtol_contrail", "tag_body_animate");
      var_14386bda = "on";
    }
    var_6c17606c = var_80cad4ec;
    if(self getspeed() <= (self getmaxspeed() * 0.75) && var_80cad4ec != "off") {
      self fx_delete_type(localclientnum, "vtol_afterburn_fx");
      var_80cad4ec = "off";
    } else if(self getspeed() > (self getmaxspeed() * 0.75) && var_80cad4ec != "on") {
      self fx_play_on_tag(localclientnum, "vtol_afterburn_fx", "vehicle/fx_vtol_thruster_afterburn", "tag_fx_engine_left", 0, 0);
      self fx_play_on_tag(localclientnum, "vtol_afterburn_fx", "vehicle/fx_vtol_thruster_afterburn", "tag_fx_engine_right", 0, 0);
      var_80cad4ec = "on";
    }
    var_80d8531 = anim_angles;
    wait(0.016);
  }
  if(isDefined(self)) {
    if(var_a2c58ba3 != "off") {
      self fx_delete_type(localclientnum, "vtol_pitch_fx");
      var_a2c58ba3 = "off";
    }
    if(var_14386bda != "off") {
      self fx_delete_type(localclientnum, "vtol_roll_fx");
      var_14386bda = "off";
    }
    if(var_80cad4ec != "off") {
      self fx_delete_type(localclientnum, "vtol_afterburn_fx");
      var_80cad4ec = "off";
    }
    self fx_delete_type(localclientnum, "running_lights");
  }
}

function velocity_to_mph(vel) {
  return length(vel) / 17.6;
}

function function_766878c8(localclientnum, str_type) {
  if(isDefined(self.a_fx) && isDefined(self.a_fx[localclientnum]) && isDefined(self.a_fx[localclientnum][str_type]) && isarray(self.a_fx[localclientnum][str_type]) && self.a_fx[localclientnum][str_type].size > 0) {
    return true;
  }
  return false;
}

function function_835cb7d(localclientnum, str_type, str_fx, clear = 1) {
  if(!isDefined(self.a_fx)) {
    self.a_fx = [];
  }
  if(!isDefined(self.a_fx[localclientnum])) {
    self.a_fx[localclientnum] = [];
  }
  if(!isDefined(self.a_fx[localclientnum][str_type])) {
    self.a_fx[localclientnum][str_type] = [];
  }
  if(isDefined(str_fx)) {
    if(isDefined(self.a_fx[localclientnum][str_type][str_fx]) && clear) {
      foreach(n_fx_id in self.a_fx[localclientnum][str_type][str_fx]) {
        deletefx(localclientnum, n_fx_id, 0);
      }
      self.a_fx[localclientnum][str_type][str_fx] = [];
    } else if(!isDefined(self.a_fx[localclientnum][str_type][str_fx])) {
      self.a_fx[localclientnum][str_type][str_fx] = [];
    }
  }
}

function fx_delete_type(localclientnum, str_type, b_stop_immediately = 1) {
  if(isDefined(self.a_fx) && isDefined(self.a_fx[localclientnum]) && isDefined(self.a_fx[localclientnum][str_type])) {
    a_keys = getarraykeys(self.a_fx[localclientnum][str_type]);
    for(i = 0; i < a_keys.size; i++) {
      foreach(n_fx_id in self.a_fx[localclientnum][str_type][a_keys[i]]) {
        deletefx(localclientnum, n_fx_id, b_stop_immediately);
      }
      self.a_fx[localclientnum][str_type][a_keys[i]] = [];
    }
  }
}

function fx_play_on_tag(localclientnum, str_type, str_fx, str_tag = "tag_origin", b_kill_fx_with_same_type = 1, var_de656156 = 1) {
  self function_835cb7d(localclientnum, str_type, str_fx, var_de656156);
  if(b_kill_fx_with_same_type) {
    self fx_delete_type(localclientnum, str_type, 0);
  }
  n_fx_id = playFXOnTag(localclientnum, str_fx, self, str_tag);
  array_size = self.a_fx[localclientnum][str_type][str_fx].size;
  self.a_fx[localclientnum][str_type][str_fx][array_size] = n_fx_id;
}

function fx_play(localclientnum, str_type, str_fx, v_pos, v_forward, v_up, b_kill_fx_with_same_type = 1, var_de656156 = 1) {
  self function_835cb7d(localclientnum, str_type, str_fx, var_de656156);
  if(b_kill_fx_with_same_type) {
    self fx_delete_type(localclientnum, str_type, 0);
  }
  if(isDefined(v_forward) && isDefined(v_up)) {
    n_fx_id = playFX(localclientnum, str_fx, v_pos, v_forward, v_up);
  } else {
    if(isDefined(v_forward)) {
      n_fx_id = playFX(localclientnum, str_fx, v_pos, v_forward);
    } else {
      n_fx_id = playFX(localclientnum, str_fx, v_pos);
    }
  }
  array_size = self.a_fx[localclientnum][str_type][str_fx].size;
  self.a_fx[localclientnum][str_type][str_fx][array_size] = n_fx_id;
}

function function_3e82b262() {
  self endon("disconnect");
  smodelanimcmd("boss_tree", "pause", "unloop", "goto_start");
  smodelanimcmd("boss_hallucinate_glass", "pause", "unloop", "goto_start");
  smodelanimcmd("boss_room_glass", "pause", "unloop", "goto_start");
  level waittill("hash_4fd5d268");
  smodelanimcmd("boss_tree", "unpause");
  smodelanimcmd("boss_hallucinate_glass", "unpause");
  level waittill("hash_e830ddcf");
  smodelanimcmd("boss_room_glass", "unpause");
}

function function_af7432f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(newval) {
    self.no_highlight = 1;
  } else {
    self.no_highlight = undefined;
  }
}

function function_34474782(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  n_bank = 1;
  if(newval == 1) {
    n_bank = 2;
  }
  setworldfogactivebank(localclientnum, n_bank);
}

function function_5240a6bb(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  n_bank = 1;
  if(newval == 1) {
    n_bank = 2;
  }
  setpbgactivebank(localclientnum, n_bank);
}