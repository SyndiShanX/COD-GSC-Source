/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_moon.csc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\util_shared;
#using scripts\shared\visionset_mgr_shared;
#using scripts\zm\_load;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_dogs;
#using scripts\zm\_zm_ai_quad;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_audio_zhd;
#using scripts\zm\_zm_bgb;
#using scripts\zm\_zm_equip_gasmask;
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_perk_additionalprimaryweapon;
#using scripts\zm\_zm_perk_deadshot;
#using scripts\zm\_zm_perk_doubletap2;
#using scripts\zm\_zm_perk_juggernaut;
#using scripts\zm\_zm_perk_quick_revive;
#using scripts\zm\_zm_perk_sleight_of_hand;
#using scripts\zm\_zm_perk_staminup;
#using scripts\zm\_zm_perk_widows_wine;
#using scripts\zm\_zm_powerup_carpenter;
#using scripts\zm\_zm_powerup_double_points;
#using scripts\zm\_zm_powerup_fire_sale;
#using scripts\zm\_zm_powerup_free_perk;
#using scripts\zm\_zm_powerup_full_ammo;
#using scripts\zm\_zm_powerup_insta_kill;
#using scripts\zm\_zm_powerup_nuke;
#using scripts\zm\_zm_powerup_weapon_minigun;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_black_hole_bomb;
#using scripts\zm\_zm_weap_bouncingbetty;
#using scripts\zm\_zm_weap_microwavegun;
#using scripts\zm\_zm_weap_quantum_bomb;
#using scripts\zm\_zm_weapons;
#using scripts\zm\zm_moon;
#using scripts\zm\zm_moon_amb;
#using scripts\zm\zm_moon_digger;
#using scripts\zm\zm_moon_ffotd;
#using scripts\zm\zm_moon_fx;
#using scripts\zm\zm_moon_gravity;
#using scripts\zm\zm_moon_sq;
#using_animtree("generic");
#namespace zm_moon;

function autoexec opt_in() {
  level.aat_in_use = 1;
  level.bgb_in_use = 1;
}

function main() {
  level thread zm_moon_ffotd::main_start();
  level.default_game_mode = "zclassic";
  level.default_start_location = "default";
  level._no_water_risers = 1;
  level.riser_fx_on_client = 1;
  level.risers_use_low_gravity_fx = 1;
  level.use_clientside_board_fx = 1;
  level.use_low_gravity_risers = 1;
  start_zombie_stuff();
  function_20c21740();
  zm_moon_fx::main();
  level.override_board_repair_sound = "evt_vent_slat_repair";
  level.override_board_teardown_sound = "evt_vent_slat_remove";
  level.wallbuy_callback_hack_override = & function_36f98292;
  level thread zm_moon_amb::main();
  register_clientfields();
  zm_moon_sq::init_clientfields();
  level._visionset_black_hole_bomb = "zombie_moon_black_hole";
  level.setupcustomcharacterexerts = & setup_personality_character_exerts;
  callback::on_localclient_connect( & jump_pad_activate);
  load::main();
  util::waitforclient(0);
  level thread zm_moon_digger::main();
  zm_moon_gravity::init();
  level thread radar_dish_init();
  level thread zm_moon_sq::rocket_test();
  level thread hide_destroyed_earth();
  level thread receiving_bay_doors_init();
  level thread function_d87a7dcc();
  level thread function_6ac83719();
  level thread function_73cc64f1(0);
  setdvar("dlc5_get_client_weapon_from_entitystate", 1);
  level thread zm_moon_ffotd::main_end();
}

function function_73cc64f1(localclientnum) {
  level.var_98cd8f08 = [];
  level.var_98cd8f08[1] = "c_t7_zm_dlchd_moon_pressuresuit_dempsey_mpc";
  level.var_98cd8f08[2] = "c_t7_zm_dlchd_moon_pressuresuit_nikolai_mpc";
  level.var_98cd8f08[3] = "c_t7_zm_dlchd_moon_pressuresuit_richtofen_mpc";
  level.var_98cd8f08[4] = "c_t7_zm_dlchd_moon_pressuresuit_takeo_mpc";
  lock_model("c_t7_zm_dlchd_moon_pressuresuit_body_mpc");
  foreach(player in getplayers(localclientnum)) {
    player thread function_c06d0a4e(localclientnum);
  }
  callback::on_spawned( & function_c06d0a4e);
}

function function_c06d0a4e(localclientnum) {
  self endon("entityshutdown");
  self util::waittill_dobj(localclientnum);
  while (isdefined(self) && !isdefined(self.player_exert_id)) {
    wait(1);
  }
  if(isdefined(self) && isdefined(self.player_exert_id)) {
    lock_model(level.var_98cd8f08[self.player_exert_id]);
  }
}

function lock_model(model) {
  if(isdefined(model)) {
    if(!isdefined(level.model_locks)) {
      level.model_locks = [];
    }
    if(!isdefined(level.model_locks[model])) {
      level.model_locks[model] = 0;
    }
    if(level.model_locks[model] < 1) {
      forcestreamxmodel(model);
    }
    level.model_locks[model]++;
  }
}

function unlock_model(model) {
  if(isdefined(model)) {
    if(!isdefined(level.model_locks)) {
      level.model_locks = [];
    }
    if(!isdefined(level.model_locks[model])) {
      level.model_locks[model] = 0;
    }
    level.model_locks[model]--;
    if(level.model_locks[model] < 1) {
      stopforcestreamingxmodel(model);
    }
  }
}

function start_zombie_stuff() {
  include_weapons();
}

function include_weapons() {
  zm_weapons::load_weapon_spec_from_table("gamedata/weapons/zm/zm_moon_weapons.csv", 1);
}

function register_clientfields() {
  clientfield::register("scriptmover", "digger_moving", 21000, 1, "int", & zm_moon_digger::digger_moving_earthquake_rumble, 0, 0);
  clientfield::register("scriptmover", "digger_digging", 21000, 1, "int", & zm_moon_digger::digger_digging_earthquake_rumble, 0, 0);
  clientfield::register("scriptmover", "digger_arm_fx", 21000, 1, "int", & zm_moon_digger::digger_arm_fx, 0, 0);
  clientfield::register("scriptmover", "dome_malfunction_pad", 21000, 1, "int", & dome_malfunction_pad, 0, 0);
  clientfield::register("toplayer", "player_sky_transition", 21000, 1, "int", & moon_nml_transition, 0, 0);
  clientfield::register("toplayer", "soul_swap", 21000, 1, "int", & zm_moon_sq::soul_swap, 0, 0);
  clientfield::register("toplayer", "gasp_rumble", 21000, 1, "int", & player_gasp_rumble, 0, 0);
  clientfield::register("toplayer", "biodome_exploder", 21000, 1, "int", & function_947f06dd, 0, 0);
  clientfield::register("toplayer", "snd_lowgravity", 21000, 1, "int", & zm_moon_gravity::function_20286238, 0, 0);
  clientfield::register("actor", "low_gravity", 21000, 1, "int", & zm_moon_gravity::zombie_low_gravity, 0, 0);
  clientfield::register("actor", "ctt", 21000, 1, "int", & zm_moon_sq::zombie_release_soul, 0, 0);
  clientfield::register("actor", "sd", 21000, 1, "int", & zm_moon_sq::function_38a2773c, 0, 0);
  clientfield::register("world", "jump_pad_pulse", 21000, 3, "counter", & function_1cd5e7c6, 0, 0);
  clientfield::register("toplayer", "gas_mask_buy", 21000, 1, "counter", & function_7c00de2d, 0, 0);
  clientfield::register("toplayer", "gas_mask_on", 21000, 1, "counter", & function_29c0676c, 0, 0);
  clientfield::register("world", "show_earth", 21000, 1, "counter", & show_earth, 0, 0);
  clientfield::register("world", "show_destroyed_earth", 21000, 1, "counter", & show_destroyed_earth, 0, 0);
  clientfield::register("world", "hide_earth", 21000, 1, "counter", & hide_earth, 0, 0);
  var_6225e4bb = tablelookuprowcount("gamedata/tables/zm/zm_astro_names.csv");
  if(isdefined(var_6225e4bb) && var_6225e4bb > 0) {
    clientfield::register("actor", "astro_name_index", 21000, getminbitcountfornum(var_6225e4bb + 1), "int", & function_ff7d3b7, 0, 0);
  }
  clientfield::register("scriptmover", "zombie_has_eyes", 21000, 1, "int", & zm::zombie_eyes_clientfield_cb, 0, 0);
  clientfield::register("clientuimodel", "hudItems.showDpadDown_HackTool", 21000, 1, "int", undefined, 0, 0);
  for (i = 0; i < 4; i++) {
    registerclientfield("world", ("player" + i) + "wearableItem", 21000, 1, "int", & zm_utility::setsharedinventoryuimodels, 0);
  }
}

function function_20c21740() {
  clientfield::register("world", "BIO", 21000, 1, "int", & zm_moon_digger::function_a0cf54a0, 0, 0);
  clientfield::register("world", "DH", 21000, 1, "int", & zm_moon_digger::function_245b13ce, 0, 0);
  clientfield::register("world", "TCA", 21000, 1, "int", & zm_moon_digger::function_774edb15, 0, 0);
  clientfield::register("world", "HCA", 21000, 1, "int", & zm_moon_digger::function_774edb15, 0, 0);
  clientfield::register("world", "BCA", 21000, 1, "int", & zm_moon_digger::function_774edb15, 0, 0);
  clientfield::register("world", "Az1", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
  clientfield::register("world", "Az2a", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
  clientfield::register("world", "Az2b", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
  clientfield::register("world", "Az3a", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
  clientfield::register("world", "Az3b", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
  clientfield::register("world", "Az3c", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
  clientfield::register("world", "Az4a", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
  clientfield::register("world", "Az4b", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
  clientfield::register("world", "Az5", 21000, 1, "counter", & zm_moon_amb::function_6ce4d731, 0, 0);
}

function disable_deadshot(i_local_client_num) {
  while (!self hasdobj(i_local_client_num)) {
    wait(0.05);
  }
  players = getlocalplayers();
  for (i = 0; i < players.size; i++) {
    if(self == players[i]) {
      self clearalternateaimparams();
    }
  }
}

function radar_dish_init() {
  radar_dish = getentarray(0, "zombie_cosmodrome_radar_dish", "targetname");
  if(isdefined(radar_dish)) {
    for (i = 0; i < radar_dish.size; i++) {
      radar_dish[i] thread radar_dish_rotate();
    }
  }
}

function radar_dish_rotate() {
  wait(0.1);
  while (true) {
    self rotateyaw(360, randomfloatrange(60, 120));
    self waittill("rotatedone");
  }
}

function receiving_bay_doors_init() {
  util::waitforallclients();
  players = getlocalplayers();
  for (i = 0; i < players.size; i++) {
    players[i] thread receiving_bay_doors(i);
    players[i] thread computer_screens_power(i);
  }
}

function receiving_bay_doors(localclientnum) {
  level waittill("power_on");
  doors = getentarray(localclientnum, "receiving_bay_doors", "targetname");
  for (i = 0; i < doors.size; i++) {
    if(isdefined(doors[i].script_vector)) {
      doors[i] playsound(0, "evt_loading_door_start");
      doors[i] playloopsound("evt_loading_door_loop", 0.5);
      doors[i] moveto(doors[i].origin + doors[i].script_vector, 3);
      doors[i] thread stop_loop_play_end();
    }
  }
}

function stop_loop_play_end() {
  wait(2.6);
  self stoploopsound(0.5);
  self playsound(0, "evt_loading_door_end");
}

function computer_screens_power(localclientnum) {
  screens = getentarray(localclientnum, "moon_comp_screens", "targetname");
  for (i = 0; i < screens.size; i++) {
    screens[i] hide();
  }
  level waittill("power_on");
  for (i = 0; i < screens.size; i++) {
    screens[i] show();
  }
}

function jump_pad_activate(clientnum) {
  level function_c00b8efb(clientnum);
  wait(0.016);
  if(!level clientfield::get("zombie_power_on")) {
    level util::waittill_any("power_on", "pwr", "ZPO");
  }
  jump_pad_start_fx(clientnum);
}

function function_c00b8efb(clientnum) {
  player = getlocalplayers()[clientnum];
  if(!isdefined(player)) {
    return;
  }
  var_e3a2cc12 = getentarray(clientnum, "jump_pads", "targetname");
  foreach(var_f5f4e9cc in var_e3a2cc12) {
    if(isdefined(var_f5f4e9cc.script_noteworthy)) {
      var_f5f4e9cc util::waittill_dobj(clientnum);
      var_f5f4e9cc useanimtree($generic);
      var_f5f4e9cc animscripted("jump_pad", var_f5f4e9cc.origin, var_f5f4e9cc.angles, "p7_fxanim_zmhd_moon_jump_pad_lrg_anim");
    }
  }
}

function function_1cd5e7c6(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_e3a2cc12 = getentarray(localclientnum, "jump_pads", "targetname");
  foreach(var_f5f4e9cc in var_e3a2cc12) {
    if(var_f5f4e9cc.script_int == newval) {
      var_f5f4e9cc util::waittill_dobj(localclientnum);
      playfxontag(localclientnum, level._effect["jump_pad_jump"], var_f5f4e9cc, "tag_origin");
    }
  }
}

function function_7c00de2d(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  playsound(localclientnum, "evt_gasmask_suit_on", self.origin);
}

function function_29c0676c(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  playsound(localclientnum, "evt_gasmask_on_v2", self.origin);
}

function jump_pad_start_fx(int_local_player_num) {
  player = getlocalplayers()[int_local_player_num];
  if(!isdefined(player)) {
    return;
  }
  moon_jump_pads = getentarray(int_local_player_num, "jump_pads", "targetname");
  if(isdefined(moon_jump_pads) && moon_jump_pads.size > 0) {
    for (i = 0; i < moon_jump_pads.size; i++) {
      moon_jump_pads[i]._glow = playfxontag(int_local_player_num, level._effect["jump_pad_active"], moon_jump_pads[i], "tag_origin");
    }
  }
}

function dome_malfunction_pad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(localclientnum != 0) {
    return;
  }
  if(newval) {
    player = getlocalplayers()[localclientnum];
    if(!isdefined(player)) {
      return;
    }
    for (x = 0; x < level.localplayers.size; x++) {
      mal_pad = undefined;
      closest = 999999;
      jump_pads = getentarray(x, "jump_pads", "targetname");
      for (i = 0; i < jump_pads.size; i++) {
        pad = jump_pads[i];
        dist = distance2d(self.origin, pad.origin);
        if(dist < closest) {
          mal_pad = pad;
          closest = dist;
        }
      }
      if(isdefined(mal_pad._glow)) {
        rand = randomintrange(4, 7);
        for (i = 0; i < rand; i++) {
          stopfx(x, mal_pad._glow);
          wait(randomfloatrange(0.05, 0.15));
          mal_pad playsound(0, "evt_electrical_surge");
          mal_pad._glow = playfxontag(x, level._effect["jump_pad_active"], mal_pad, "tag_origin");
          wait(randomfloatrange(0.05, 0.15));
        }
        stopfx(x, mal_pad._glow);
      }
    }
  } else {
    player = getlocalplayers()[localclientnum];
    if(!isdefined(player)) {
      return;
    }
    for (x = 0; x < level.localplayers.size; x++) {
      mal_pad = undefined;
      closest = 999999;
      jump_pads = getentarray(x, "jump_pads", "targetname");
      for (i = 0; i < jump_pads.size; i++) {
        pad = jump_pads[i];
        dist = distance2d(self.origin, pad.origin);
        if(dist < closest) {
          mal_pad = pad;
          closest = dist;
        }
      }
      if(isdefined(mal_pad._glow)) {
        rand = randomintrange(4, 7);
        for (i = 0; i < rand; i++) {
          mal_pad playsound(0, "evt_electrical_surge");
          mal_pad._glow = playfxontag(x, level._effect["jump_pad_active"], mal_pad, "tag_origin");
          wait(randomfloatrange(0.05, 0.15));
          stopfx(x, mal_pad._glow);
          wait(randomfloatrange(0.05, 0.15));
        }
        mal_pad._glow = playfxontag(x, level._effect["jump_pad_active"], mal_pad, "tag_origin");
      }
    }
  }
}

function player_gasp_rumble(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isdefined(self getlocalclientnumber())) {
    return;
  }
  if(newval) {
    if(randomint(100) > 70) {
      self playrumbleonentity(localclientnum, "damage_light");
    } else {
      self playrumbleonentity(localclientnum, "damage_heavy");
    }
  }
}

function show_earth(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  for (i = 0; i < level.localplayers.size; i++) {
    player = getlocalplayers()[i];
    if(!isdefined(player)) {
      continue;
    }
    if(!isdefined(player._earth)) {
      player._earth = spawn(i, (-22060.8, -121800, 34463.4), "script_model", 1);
      player._earth.angles = (18, 78, 22);
      player._earth setmodel("p7_zm_moo_earth");
    }
    player._earth show();
  }
}

function hide_earth(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  for (i = 0; i < level.localplayers.size; i++) {
    player = getlocalplayers()[i];
    if(!isdefined(player)) {
      continue;
    }
    if(isdefined(player._earth)) {
      player._earth hide();
    }
  }
}

function show_destroyed_earth(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  for (i = 0; i < level.localplayers.size; i++) {
    player = getlocalplayers()[i];
    if(!isdefined(player)) {
      continue;
    }
    if(isdefined(player._earth)) {
      player._earth setmodel("p7_zm_moo_earth_dest");
    }
  }
}

function hide_destroyed_earth() {
  while (true) {
    level waittill("hde");
    level thread do_hide_destroyed_earth();
  }
}

function do_hide_destroyed_earth() {
  for (i = 0; i < level.localplayers.size; i++) {
    player = getlocalplayers()[i];
    if(!isdefined(player)) {
      continue;
    }
    if(isdefined(player._earth)) {
      player._earth delete();
    }
  }
}

function function_d87a7dcc() {
  var_bd7ba30 = 0;
  while (true) {
    if(!level clientfield::get("zombie_power_on")) {
      if(var_bd7ba30) {
        level notify("power_controlled_light");
      }
      level util::waittill_any("power_on", "pwr", "ZPO");
    }
    level notify("power_controlled_light");
    level util::waittill_any("pwo", "ZPOff");
    var_bd7ba30 = 1;
  }
}

function function_947f06dd(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(newval) {
    exploder::exploder("lgt_dome_int");
  } else {
    exploder::stop_exploder("lgt_dome_int");
  }
}

function moon_nml_transition(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  if(!self islocalplayer()) {
    return;
  }
  if(!isdefined(self getlocalclientnumber())) {
    return;
  }
  if(newval) {
    if(isdefined(level._dte_done)) {
      visionset_mgr::fog_vol_to_visionset_set_suffix("_on");
      level thread function_fbf77a74(localclientnum);
    } else {
      visionset_mgr::fog_vol_to_visionset_set_suffix("_off");
    }
  } else {
    visionset_mgr::fog_vol_to_visionset_set_suffix("");
    level notify("hash_d2b77ba2");
    setukkoscriptindex(localclientnum, 1, 1);
  }
}

function function_fbf77a74(localclientnum) {
  self endon("hash_d2b77ba2");
  while (true) {
    var_f4570d42 = randomint(5);
    switch (var_f4570d42) {
      case 0: {
        setukkoscriptindex(localclientnum, 2, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 3, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 4, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 5, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 4, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 3, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 4, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 3, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 4, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 6, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 4, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 5, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 6, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 7, 1);
        wait(0.05);
        break;
      }
      case 1: {
        setukkoscriptindex(localclientnum, 8, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 9, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 10, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 11, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 10, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 11, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 12, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 13, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 14, 1);
        wait(0.1);
        break;
      }
      case 2: {
        setukkoscriptindex(localclientnum, 15, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 16, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 17, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 18, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 19, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 20, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 21, 1);
        wait(0.1);
        break;
      }
      case 3: {
        setukkoscriptindex(localclientnum, 22, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 23, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 24, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 25, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 26, 1);
        wait(0.1);
        break;
      }
      case 4: {
        setukkoscriptindex(localclientnum, 29, 1);
        wait(0.15);
        setukkoscriptindex(localclientnum, 30, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 29, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 31, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 30, 1);
        wait(0.15);
        setukkoscriptindex(localclientnum, 29, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 30, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 29, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 31, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 27, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 28, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 29, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 30, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 29, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 31, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 30, 1);
        wait(0.15);
        setukkoscriptindex(localclientnum, 29, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 30, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 29, 1);
        wait(0.1);
        setukkoscriptindex(localclientnum, 31, 1);
        wait(0.05);
        setukkoscriptindex(localclientnum, 32, 1);
        wait(0.05);
        break;
      }
      default: {
        break;
      }
    }
    setukkoscriptindex(localclientnum, 1, 1);
    n_wait_time = randomintrange(2, 4);
    wait(n_wait_time);
  }
}

function function_36f98292() {
  self rotateroll(180, 0.5);
}

function function_ff7d3b7(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwasdemojump) {
  var_28a1ce70 = tablelookup("gamedata/tables/zm/zm_astro_names.csv", 0, newval - 1, 1);
  self setdrawname(var_28a1ce70);
}

function function_6ac83719() {
  visionset_mgr::init_fog_vol_to_visionset_monitor("zombie_moonHanger18", 2);
  visionset_mgr::fog_vol_to_visionset_set_suffix("_off");
  visionset_mgr::fog_vol_to_visionset_set_info(1, "zombie_moonHanger18");
  visionset_mgr::fog_vol_to_visionset_set_info(2, "zombie_moonExterior");
  visionset_mgr::fog_vol_to_visionset_set_info(3, "zombie_moonTunnels");
  visionset_mgr::fog_vol_to_visionset_set_info(4, "zombie_moonInterior");
  visionset_mgr::fog_vol_to_visionset_set_info(5, "zombie_moonBioDome");
}

function setup_personality_character_exerts() {
  level.exert_sounds[1]["playerbreathinsound"][0] = "vox_plr_0_exert_inhale_0";
  level.exert_sounds[1]["playerbreathinsound"][1] = "vox_plr_0_exert_inhale_1";
  level.exert_sounds[1]["playerbreathinsound"][2] = "vox_plr_0_exert_inhale_2";
  level.exert_sounds[2]["playerbreathinsound"][0] = "vox_plr_1_exert_inhale_0";
  level.exert_sounds[2]["playerbreathinsound"][1] = "vox_plr_1_exert_inhale_1";
  level.exert_sounds[2]["playerbreathinsound"][2] = "vox_plr_1_exert_inhale_2";
  level.exert_sounds[3]["playerbreathinsound"][0] = "vox_plr_2_exert_inhale_0";
  level.exert_sounds[3]["playerbreathinsound"][1] = "vox_plr_2_exert_inhale_1";
  level.exert_sounds[3]["playerbreathinsound"][2] = "vox_plr_2_exert_inhale_2";
  level.exert_sounds[4]["playerbreathinsound"][0] = "vox_plr_3_exert_inhale_0";
  level.exert_sounds[4]["playerbreathinsound"][1] = "vox_plr_3_exert_inhale_1";
  level.exert_sounds[4]["playerbreathinsound"][2] = "vox_plr_3_exert_inhale_2";
  level.exert_sounds[1]["playerbreathoutsound"][0] = "vox_plr_0_exert_exhale_0";
  level.exert_sounds[1]["playerbreathoutsound"][1] = "vox_plr_0_exert_exhale_1";
  level.exert_sounds[1]["playerbreathoutsound"][2] = "vox_plr_0_exert_exhale_2";
  level.exert_sounds[2]["playerbreathoutsound"][0] = "vox_plr_1_exert_exhale_0";
  level.exert_sounds[2]["playerbreathoutsound"][1] = "vox_plr_1_exert_exhale_1";
  level.exert_sounds[2]["playerbreathoutsound"][2] = "vox_plr_1_exert_exhale_2";
  level.exert_sounds[3]["playerbreathoutsound"][0] = "vox_plr_2_exert_exhale_0";
  level.exert_sounds[3]["playerbreathoutsound"][1] = "vox_plr_2_exert_exhale_1";
  level.exert_sounds[3]["playerbreathoutsound"][2] = "vox_plr_2_exert_exhale_2";
  level.exert_sounds[4]["playerbreathoutsound"][0] = "vox_plr_3_exert_exhale_0";
  level.exert_sounds[4]["playerbreathoutsound"][1] = "vox_plr_3_exert_exhale_1";
  level.exert_sounds[4]["playerbreathoutsound"][2] = "vox_plr_3_exert_exhale_2";
  level.exert_sounds[1]["playerbreathgaspsound"][0] = "vox_plr_0_exert_exhale_0";
  level.exert_sounds[1]["playerbreathgaspsound"][1] = "vox_plr_0_exert_exhale_1";
  level.exert_sounds[1]["playerbreathgaspsound"][2] = "vox_plr_0_exert_exhale_2";
  level.exert_sounds[2]["playerbreathgaspsound"][0] = "vox_plr_1_exert_exhale_0";
  level.exert_sounds[2]["playerbreathgaspsound"][1] = "vox_plr_1_exert_exhale_1";
  level.exert_sounds[2]["playerbreathgaspsound"][2] = "vox_plr_1_exert_exhale_2";
  level.exert_sounds[3]["playerbreathgaspsound"][0] = "vox_plr_2_exert_exhale_0";
  level.exert_sounds[3]["playerbreathgaspsound"][1] = "vox_plr_2_exert_exhale_1";
  level.exert_sounds[3]["playerbreathgaspsound"][2] = "vox_plr_2_exert_exhale_2";
  level.exert_sounds[4]["playerbreathgaspsound"][0] = "vox_plr_3_exert_exhale_0";
  level.exert_sounds[4]["playerbreathgaspsound"][1] = "vox_plr_3_exert_exhale_1";
  level.exert_sounds[4]["playerbreathgaspsound"][2] = "vox_plr_3_exert_exhale_2";
  level.exert_sounds[1]["falldamage"][0] = "vox_plr_0_exert_pain_low_0";
  level.exert_sounds[1]["falldamage"][1] = "vox_plr_0_exert_pain_low_1";
  level.exert_sounds[1]["falldamage"][2] = "vox_plr_0_exert_pain_low_2";
  level.exert_sounds[1]["falldamage"][3] = "vox_plr_0_exert_pain_low_3";
  level.exert_sounds[1]["falldamage"][4] = "vox_plr_0_exert_pain_low_4";
  level.exert_sounds[1]["falldamage"][5] = "vox_plr_0_exert_pain_low_5";
  level.exert_sounds[1]["falldamage"][6] = "vox_plr_0_exert_pain_low_6";
  level.exert_sounds[1]["falldamage"][7] = "vox_plr_0_exert_pain_low_7";
  level.exert_sounds[2]["falldamage"][0] = "vox_plr_1_exert_pain_low_0";
  level.exert_sounds[2]["falldamage"][1] = "vox_plr_1_exert_pain_low_1";
  level.exert_sounds[2]["falldamage"][2] = "vox_plr_1_exert_pain_low_2";
  level.exert_sounds[2]["falldamage"][3] = "vox_plr_1_exert_pain_low_3";
  level.exert_sounds[2]["falldamage"][4] = "vox_plr_1_exert_pain_low_4";
  level.exert_sounds[2]["falldamage"][5] = "vox_plr_1_exert_pain_low_5";
  level.exert_sounds[2]["falldamage"][6] = "vox_plr_1_exert_pain_low_6";
  level.exert_sounds[2]["falldamage"][7] = "vox_plr_1_exert_pain_low_7";
  level.exert_sounds[3]["falldamage"][0] = "vox_plr_2_exert_pain_low_0";
  level.exert_sounds[3]["falldamage"][1] = "vox_plr_2_exert_pain_low_1";
  level.exert_sounds[3]["falldamage"][2] = "vox_plr_2_exert_pain_low_2";
  level.exert_sounds[3]["falldamage"][3] = "vox_plr_2_exert_pain_low_3";
  level.exert_sounds[3]["falldamage"][4] = "vox_plr_2_exert_pain_low_4";
  level.exert_sounds[3]["falldamage"][5] = "vox_plr_2_exert_pain_low_5";
  level.exert_sounds[3]["falldamage"][6] = "vox_plr_2_exert_pain_low_6";
  level.exert_sounds[3]["falldamage"][7] = "vox_plr_2_exert_pain_low_7";
  level.exert_sounds[4]["falldamage"][0] = "vox_plr_3_exert_pain_low_0";
  level.exert_sounds[4]["falldamage"][1] = "vox_plr_3_exert_pain_low_1";
  level.exert_sounds[4]["falldamage"][2] = "vox_plr_3_exert_pain_low_2";
  level.exert_sounds[4]["falldamage"][3] = "vox_plr_3_exert_pain_low_3";
  level.exert_sounds[4]["falldamage"][4] = "vox_plr_3_exert_pain_low_4";
  level.exert_sounds[4]["falldamage"][5] = "vox_plr_3_exert_pain_low_5";
  level.exert_sounds[4]["falldamage"][6] = "vox_plr_3_exert_pain_low_6";
  level.exert_sounds[4]["falldamage"][7] = "vox_plr_3_exert_pain_low_7";
  level.exert_sounds[1]["mantlesoundplayer"][0] = "vox_plr_0_exert_grunt_0";
  level.exert_sounds[1]["mantlesoundplayer"][1] = "vox_plr_0_exert_grunt_1";
  level.exert_sounds[1]["mantlesoundplayer"][2] = "vox_plr_0_exert_grunt_2";
  level.exert_sounds[1]["mantlesoundplayer"][3] = "vox_plr_0_exert_grunt_3";
  level.exert_sounds[1]["mantlesoundplayer"][4] = "vox_plr_0_exert_grunt_4";
  level.exert_sounds[1]["mantlesoundplayer"][5] = "vox_plr_0_exert_grunt_5";
  level.exert_sounds[1]["mantlesoundplayer"][6] = "vox_plr_0_exert_grunt_6";
  level.exert_sounds[2]["mantlesoundplayer"][0] = "vox_plr_1_exert_grunt_0";
  level.exert_sounds[2]["mantlesoundplayer"][1] = "vox_plr_1_exert_grunt_1";
  level.exert_sounds[2]["mantlesoundplayer"][2] = "vox_plr_1_exert_grunt_2";
  level.exert_sounds[2]["mantlesoundplayer"][3] = "vox_plr_1_exert_grunt_3";
  level.exert_sounds[2]["mantlesoundplayer"][4] = "vox_plr_1_exert_grunt_4";
  level.exert_sounds[2]["mantlesoundplayer"][5] = "vox_plr_1_exert_grunt_5";
  level.exert_sounds[3]["mantlesoundplayer"][0] = "vox_plr_2_exert_grunt_0";
  level.exert_sounds[3]["mantlesoundplayer"][1] = "vox_plr_2_exert_grunt_1";
  level.exert_sounds[3]["mantlesoundplayer"][2] = "vox_plr_2_exert_grunt_2";
  level.exert_sounds[3]["mantlesoundplayer"][3] = "vox_plr_2_exert_grunt_3";
  level.exert_sounds[3]["mantlesoundplayer"][4] = "vox_plr_2_exert_grunt_4";
  level.exert_sounds[3]["mantlesoundplayer"][5] = "vox_plr_2_exert_grunt_5";
  level.exert_sounds[3]["mantlesoundplayer"][6] = "vox_plr_2_exert_grunt_6";
  level.exert_sounds[4]["mantlesoundplayer"][0] = "vox_plr_3_exert_grunt_0";
  level.exert_sounds[4]["mantlesoundplayer"][1] = "vox_plr_3_exert_grunt_1";
  level.exert_sounds[4]["mantlesoundplayer"][2] = "vox_plr_3_exert_grunt_2";
  level.exert_sounds[4]["mantlesoundplayer"][3] = "vox_plr_3_exert_grunt_4";
  level.exert_sounds[4]["mantlesoundplayer"][4] = "vox_plr_3_exert_grunt_5";
  level.exert_sounds[4]["mantlesoundplayer"][5] = "vox_plr_3_exert_grunt_6";
  level.exert_sounds[1]["meleeswipesoundplayer"][0] = "vox_plr_0_exert_knife_swipe_0";
  level.exert_sounds[1]["meleeswipesoundplayer"][1] = "vox_plr_0_exert_knife_swipe_1";
  level.exert_sounds[1]["meleeswipesoundplayer"][2] = "vox_plr_0_exert_knife_swipe_2";
  level.exert_sounds[1]["meleeswipesoundplayer"][3] = "vox_plr_0_exert_knife_swipe_3";
  level.exert_sounds[1]["meleeswipesoundplayer"][4] = "vox_plr_0_exert_knife_swipe_4";
  level.exert_sounds[1]["meleeswipesoundplayer"][5] = "vox_plr_0_exert_knife_swipe_5";
  level.exert_sounds[2]["meleeswipesoundplayer"][0] = "vox_plr_1_exert_knife_swipe_0";
  level.exert_sounds[2]["meleeswipesoundplayer"][1] = "vox_plr_1_exert_knife_swipe_1";
  level.exert_sounds[2]["meleeswipesoundplayer"][2] = "vox_plr_1_exert_knife_swipe_2";
  level.exert_sounds[2]["meleeswipesoundplayer"][3] = "vox_plr_1_exert_knife_swipe_3";
  level.exert_sounds[2]["meleeswipesoundplayer"][4] = "vox_plr_1_exert_knife_swipe_4";
  level.exert_sounds[2]["meleeswipesoundplayer"][5] = "vox_plr_1_exert_knife_swipe_5";
  level.exert_sounds[3]["meleeswipesoundplayer"][0] = "vox_plr_2_exert_knife_swipe_0";
  level.exert_sounds[3]["meleeswipesoundplayer"][1] = "vox_plr_2_exert_knife_swipe_1";
  level.exert_sounds[3]["meleeswipesoundplayer"][2] = "vox_plr_2_exert_knife_swipe_2";
  level.exert_sounds[3]["meleeswipesoundplayer"][3] = "vox_plr_2_exert_knife_swipe_3";
  level.exert_sounds[3]["meleeswipesoundplayer"][4] = "vox_plr_2_exert_knife_swipe_4";
  level.exert_sounds[3]["meleeswipesoundplayer"][5] = "vox_plr_2_exert_knife_swipe_5";
  level.exert_sounds[4]["meleeswipesoundplayer"][0] = "vox_plr_3_exert_knife_swipe_0";
  level.exert_sounds[4]["meleeswipesoundplayer"][1] = "vox_plr_3_exert_knife_swipe_1";
  level.exert_sounds[4]["meleeswipesoundplayer"][2] = "vox_plr_3_exert_knife_swipe_2";
  level.exert_sounds[4]["meleeswipesoundplayer"][3] = "vox_plr_3_exert_knife_swipe_3";
  level.exert_sounds[4]["meleeswipesoundplayer"][4] = "vox_plr_3_exert_knife_swipe_4";
  level.exert_sounds[4]["meleeswipesoundplayer"][5] = "vox_plr_3_exert_knife_swipe_5";
  level.exert_sounds[1]["dtplandsoundplayer"][0] = "vox_plr_0_exert_pain_medium_0";
  level.exert_sounds[1]["dtplandsoundplayer"][1] = "vox_plr_0_exert_pain_medium_1";
  level.exert_sounds[1]["dtplandsoundplayer"][2] = "vox_plr_0_exert_pain_medium_2";
  level.exert_sounds[1]["dtplandsoundplayer"][3] = "vox_plr_0_exert_pain_medium_3";
  level.exert_sounds[2]["dtplandsoundplayer"][0] = "vox_plr_1_exert_pain_medium_0";
  level.exert_sounds[2]["dtplandsoundplayer"][1] = "vox_plr_1_exert_pain_medium_1";
  level.exert_sounds[2]["dtplandsoundplayer"][2] = "vox_plr_1_exert_pain_medium_2";
  level.exert_sounds[2]["dtplandsoundplayer"][3] = "vox_plr_1_exert_pain_medium_3";
  level.exert_sounds[3]["dtplandsoundplayer"][0] = "vox_plr_2_exert_pain_medium_0";
  level.exert_sounds[3]["dtplandsoundplayer"][1] = "vox_plr_2_exert_pain_medium_1";
  level.exert_sounds[3]["dtplandsoundplayer"][2] = "vox_plr_2_exert_pain_medium_2";
  level.exert_sounds[3]["dtplandsoundplayer"][3] = "vox_plr_2_exert_pain_medium_3";
  level.exert_sounds[4]["dtplandsoundplayer"][0] = "vox_plr_3_exert_pain_medium_0";
  level.exert_sounds[4]["dtplandsoundplayer"][1] = "vox_plr_3_exert_pain_medium_1";
  level.exert_sounds[4]["dtplandsoundplayer"][2] = "vox_plr_3_exert_pain_medium_2";
  level.exert_sounds[4]["dtplandsoundplayer"][3] = "vox_plr_3_exert_pain_medium_3";
}