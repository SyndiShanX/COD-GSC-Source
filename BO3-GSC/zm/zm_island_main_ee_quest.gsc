/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\zm_island_main_ee_quest.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\ai\zombie_utility;
#using scripts\shared\ai_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\exploder_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\scoreevents_shared;
#using scripts\shared\spawner_shared;
#using scripts\shared\system_shared;
#using scripts\shared\trigger_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_ai_shared;
#using scripts\shared\vehicle_shared;
#using scripts\zm\_zm;
#using scripts\zm\_zm_ai_spiders;
#using scripts\zm\_zm_devgui;
#using scripts\zm\_zm_laststand;
#using scripts\zm\_zm_pack_a_punch;
#using scripts\zm\_zm_pack_a_punch_util;
#using scripts\zm\_zm_perks;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_unitrigger;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weap_keeper_skull;
#using scripts\zm\_zm_zonemgr;
#using scripts\zm\bgbs\_zm_bgb_anywhere_but_here;
#using scripts\zm\bgbs\_zm_bgb_pop_shocks;
#using scripts\zm\zm_island_bgb;
#using scripts\zm\zm_island_perks;
#using scripts\zm\zm_island_util;
#using scripts\zm\zm_island_vo;
#namespace main_quest;

function main() {
  var_e66037d6 = getent("main_ee_elevator_wall_metal", "targetname");
  var_ed315f0 = getent("main_ee_elevator_wall_decal", "targetname");
  var_e66037d6 clientfield::set("do_fade_material", 1);
  var_ed315f0 clientfield::set("do_fade_material", 0.5);
  level thread function_6e38e085();
  level thread function_8221532d();
  level thread function_9f26e724();
  level thread function_dcc18c22();
  level thread function_7910f0c2();
}

function function_30d4f164() {
  register_clientfields();
  level flag::init("player_has_aa_gun_ammo");
  level flag::init("aa_gun_ammo_loaded");
  level flag::init("aa_gun_ee_complete");
  level flag::init("flag_play_outro_cutscene");
  level flag::init("elevator_part_gear1_found");
  level flag::init("elevator_part_gear2_found");
  level flag::init("elevator_part_gear3_found");
  level flag::init("elevator_part_gear1_placed");
  level flag::init("elevator_part_gear2_placed");
  level flag::init("elevator_part_gear3_placed");
  level flag::init("elevator_in_use");
  level flag::init("elevator_at_bottom");
  level flag::init("elevator_cooldown");
  level flag::init("flag_hide_outro_water");
  level flag::init("flag_show_outro_water");
  level flag::init("elevator_door_closed");
  level flag::set("elevator_door_closed");
  level flag::init("prison_vines_cleared");
  if(getdvarint("splitscreen_playerCount") < 3) {
    callback::on_spawned( & function_85773a07);
  }
  callback::on_spawned( & function_aeef1178);
  callback::on_spawned( & function_df4d1d4);
  level thread function_75e5527f();
  function_8099bad0();
  function_5d0980ef();
  function_62dfc4c7();
  function_af46160f();
  level thread function_f818f5b5();
  level thread aa_gun_think();
  level thread function_19cfd507();
  level thread function_e509082();
  if(getdvarint("") > 0) {
    function_12d043ed();
  }
}

function register_clientfields() {
  clientfield::register("scriptmover", "zipline_lightning_fx", 9000, 1, "int");
  clientfield::register("vehicle", "plane_hit_by_aa_gun", 9000, 1, "int");
  clientfield::register("allplayers", "lightning_shield_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "smoke_trail_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "smoke_smolder_fx", 9000, 1, "int");
  clientfield::register("scriptmover", "perk_lightning_fx", 9000, getminbitcountfornum(6), "int");
  clientfield::register("zbarrier", "bgb_lightning_fx", 9000, 1, "int");
  clientfield::register("world", "umbra_tome_outro_igc", 9000, 1, "int");
}

function function_85773a07() {
  self endon("death");
  var_af4d7f99 = getent("mdl_main_ee_map", "targetname");
  self zm_island_util::function_7448e472(var_af4d7f99);
  level thread function_85b23415();
}

function function_85b23415() {
  var_af4d7f99 = getent("mdl_main_ee_map", "targetname");
  var_af4d7f99 clientfield::set("do_fade_material", 1);
  level flag::set("trilogy_released");
  exploder::exploder("lgt_elevator");
}

function function_7910f0c2() {
  level flag::wait_till("trilogy_released");
  level.var_6f17d9e9 = 0;
  for(i = 1; i < 4; i++) {
    var_f34dc519 = getent("takeo_arm_gate" + i, "targetname");
    var_f34dc519 thread function_d9de7eb6(i);
    level.var_6f17d9e9++;
  }
}

function function_d9de7eb6(var_a3612ddd) {
  e_clip = getent(self.target, "targetname");
  e_clip setCanDamage(1);
  e_clip.health = 10000;
  var_75f5a225 = getent("clip_player_" + var_a3612ddd, "targetname");
  self thread scene::play(("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd) + "_bundle", self);
  var_2b128827 = 1;
  var_b538c87 = 0;
  while(isDefined(var_2b128827) && var_2b128827) {
    e_clip waittill("damage", n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, str_part_name, w_weapon);
    if(w_weapon === level.var_5e75629a) {
      self playrumbleonentity("tank_damage_heavy_mp");
      self scene::play(("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd) + "_close_bundle", self);
      self thread scene::play(("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd) + "_bundle", self);
      if(var_a3612ddd == 1 && !var_b538c87) {
        var_b538c87 = 1;
        str_vo = ("vox_plr_" + e_attacker.characterindex) + "_mq_ee_3_1_0";
        e_attacker thread zm_island_vo::function_7b697614(str_vo, 0, 1);
      }
    } else if(w_weapon === level.var_a4052592) {
      self playrumbleonentity("zm_island_rumble_takeo_hall_vine_hit");
      earthquake(0.35, 0.5, self.origin, 325);
      self playSound("zmb_takeo_vox_roar_amrgate");
      self hidepart("eye1_side_jnt");
      wait(1.5);
      self scene::play(("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd) + "_retract_bundle", self);
      e_clip delete();
      var_75f5a225 delete();
      level.var_6f17d9e9--;
      if(level.var_6f17d9e9 == 0) {
        level notify("hash_add73e69");
        level util::delay(2, undefined, & flag::set, "prison_vines_cleared");
        level.var_6f17d9e9 = undefined;
      }
      wait(5);
      struct::delete_script_bundle("scene", ("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd) + "_bundle");
      struct::delete_script_bundle("scene", ("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd) + "_close_bundle");
      struct::delete_script_bundle("scene", ("p7_fxanim_zm_island_takeo_arm_gate" + var_a3612ddd) + "_retract_bundle");
      var_2b128827 = 0;
    }
  }
}

function function_df4d1d4() {
  self endon("death");
  level endon("flag_play_outro_cutscene");
  level flag::wait_till("trilogy_released");
  var_af8f5b69 = getent("trigger_gas_hurt", "targetname");
  while(true) {
    trigger::wait_till("trigger_gas_hurt", "targetname", self);
    if(!self.var_df4182b1 && zm_utility::is_player_valid(self)) {
      self dodamage(5, self.origin);
    }
    wait(0.5);
  }
}

function function_75e5527f() {
  level endon("hash_5790f552");
  var_af8f5b69 = getent("trigger_gas_chamber", "targetname");
  while(true) {
    var_af8f5b69 waittill("trigger");
    a_talkers = [];
    foreach(player in level.players) {
      if(player istouching(var_af8f5b69) && !player.var_df4182b1 && zm_utility::is_player_valid(player)) {
        array::add(a_talkers, player);
      }
    }
    e_talker = array::random(a_talkers);
    if(isDefined(e_talker)) {
      str_vo = ("vox_plr_" + e_talker.characterindex) + "_mq_ee_3_0_0";
      e_talker thread zm_island_vo::function_7b697614(str_vo, 0, 1);
      level notify("hash_5790f552");
    }
  }
}

function function_19cfd507() {
  level flag::wait_till("trilogy_released");
  level thread function_d6bb2a6c();
  level.var_2c12d9a6 = & function_2fae2796;
  level flag::wait_till("elevator_part_gear1_found");
  level.var_2c12d9a6 = & zm_island_bgb::function_fa778ca4;
}

function function_d6bb2a6c() {
  s_part = struct::get("elevator_part_gear1");
  mdl_part = util::spawn_model("p7_zm_bgb_gear_01", s_part.origin, s_part.angles);
  mdl_part.trigger = zm_island_util::spawn_trigger_radius(mdl_part.origin, 50, 1, & function_9bd3096f);
  mdl_part thread function_d81e5824("elevator_part_gear1_found");
}

function function_2fae2796() {
  var_664f35bb = struct::get_array("ee_gear_teleport_spot", "targetname");
  while(true) {
    foreach(s_spot in var_664f35bb) {
      if(!positionwouldtelefrag(s_spot.origin)) {
        return s_spot;
      }
    }
    wait(0.05);
  }
}

function function_8099bad0() {
  array::thread_all(getEntArray("clip_zipline_zap", "targetname"), & function_5b0b2b3d);
  level thread function_53246bea();
}

function function_5b0b2b3d() {
  level flag::wait_till("all_challenges_completed");
  self setCanDamage(1);
  self.health = 100000;
  var_fae0d733 = struct::get_array("transport_zip_line", "targetname");
  while(true) {
    self waittill("damage", n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, str_part_name, w_weapon);
    if(w_weapon.name === "island_riotshield" && (isDefined(e_attacker.var_36c3d64a) && e_attacker.var_36c3d64a)) {
      level flag::set("zipline_lightning_charge");
      e_attacker notify("riotshield_lost_lightning");
      self playSound("zmb_lightning_shield_activate");
      foreach(s_loc in var_fae0d733) {
        s_loc.var_1cdf0f7a clientfield::set("zipline_lightning_fx", 1);
      }
      exploder::exploder("fxexp_504");
      level util::delay(5, undefined, & exploder::exploder_stop, "fxexp_504");
      if(level flag::get("flag_zipline_in_use")) {
        foreach(player in level.players) {
          if(isDefined(player.is_ziplining) && player.is_ziplining) {
            player.var_53539670 notify("reached_end_node");
            break;
          }
        }
      } else if(level.players.size == 1) {
        level.players[0] thread function_426caba9();
      }
      foreach(s_loc in var_fae0d733) {
        s_loc.var_1cdf0f7a util::delay(5, undefined, & clientfield::set, "zipline_lightning_fx", 0);
      }
      wait(5);
      level flag::clear("zipline_lightning_charge");
    }
  }
}

function function_62dfc4c7() {
  array::thread_all(getEntArray("clip_sewer_panel_zap", "targetname"), & function_e9ec0fdf);
}

function function_e9ec0fdf() {
  self endon("death");
  level flag::wait_till("all_challenges_completed");
  self setCanDamage(1);
  self.health = 100000;
  s_loc = struct::get("transport_sewer_" + self.script_noteworthy);
  while(true) {
    self waittill("damage", n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, str_part_name, w_weapon);
    if(isDefined(w_weapon.isriotshield) && w_weapon.isriotshield && (isDefined(e_attacker.var_36c3d64a) && e_attacker.var_36c3d64a)) {
      level flag::set("sewer_lightning_charge_" + self.script_noteworthy);
      e_attacker notify("riotshield_lost_lightning");
      self playSound("zmb_lightning_shield_activate");
      s_loc.var_1cdf0f7a clientfield::set("zipline_lightning_fx", 1);
      wait(5);
      s_loc.var_1cdf0f7a clientfield::set("zipline_lightning_fx", 0);
      level flag::clear("sewer_lightning_charge_" + self.script_noteworthy);
    }
  }
}

function function_af46160f() {
  var_f7d59b95 = getent("clip_cage_control", "targetname");
  var_a398a1e1 = struct::get(var_f7d59b95.target, "targetname");
  var_f7d59b95 thread function_4d23baa6(var_a398a1e1.origin, var_a398a1e1.angles);
}

function function_4d23baa6(v_origin, v_angles, n_cooldown = 5, var_5588387b) {
  self endon("death");
  self setCanDamage(1);
  self.health = 100000;
  while(true) {
    self waittill("damage", n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, str_part_name, w_weapon);
    if(isDefined(w_weapon.isriotshield) && w_weapon.isriotshield && (isDefined(e_attacker.var_36c3d64a) && e_attacker.var_36c3d64a)) {
      self notify("charged");
      e_attacker notify("riotshield_lost_lightning");
      self playSound("zmb_lightning_shield_activate");
      var_752908f7 = util::spawn_model("tag_origin", v_origin, v_angles);
      var_752908f7 clientfield::set("zipline_lightning_fx", 1);
      if(isDefined(var_5588387b)) {
        var_752908f7 thread[[var_5588387b]]();
      }
      wait(n_cooldown);
      var_752908f7 notify("hash_48ec464");
      var_752908f7 clientfield::set("zipline_lightning_fx", 0);
      util::wait_network_frame();
      var_752908f7 delete();
    }
  }
}

function function_426caba9() {
  self endon("disconnect");
  if(isDefined(5)) {
    __s = spawnStruct();
    __s endon("timeout");
    __s util::delay_notify(5, "timeout");
  }
  level flag::wait_till("flag_zipline_in_use");
  self waittill("zipline_start");
  while(!self meleebuttonpressed()) {
    wait(0.05);
  }
  if(isDefined(self.var_53539670)) {
    self.var_53539670 notify("reached_end_node");
  }
}

function function_6e38e085() {
  var_d93f9cb8 = getent("boat_death", "targetname");
  while(true) {
    var_d93f9cb8 waittill("trigger", e_who);
    if(isplayer(e_who) && (!(isDefined(e_who.var_a98632dd) && e_who.var_a98632dd))) {
      e_who.var_a98632dd = 1;
      e_who thread function_1bbe32e1();
      if(!level flag::get("solo_game")) {
        e_who.no_revive_trigger = 1;
      }
      e_who dodamage(e_who.health + 1000, e_who.origin);
    }
  }
}

function function_1bbe32e1() {
  self endon("disconnect");
  if(self hasperk("specialty_quickrevive") && level flag::get("solo_game")) {
    self setorigin(self.var_5eb06498);
  }
  self util::waittill_any("player_revived", "spawned");
  self.no_revive_trigger = undefined;
  self.var_a98632dd = undefined;
}

function function_53246bea() {
  level flag::wait_till("trilogy_released");
  s_part = struct::get("elevator_part_gear2");
  mdl_part = util::spawn_model("p7_zm_bgb_gear_01", s_part.origin, s_part.angles);
  mdl_part.trigger = zm_island_util::spawn_trigger_radius(mdl_part.origin, 50, 1, & function_9bd3096f);
  mdl_part thread function_d81e5824("elevator_part_gear2_found");
}

function function_1f4e6abd() {
  var_ff4420b1 = util::spawn_model("p7_zm_ctl_ammo_flak_bullet_01", self.origin + vectorscale((0, 0, 1), 36), self.angles);
  var_ff4420b1 setscale(5);
  var_4f2d91b3 = spawnStruct();
  var_4f2d91b3.origin = var_ff4420b1.origin;
  var_4f2d91b3.angles = var_ff4420b1.angles;
  var_4f2d91b3.e_parent = var_ff4420b1;
  var_4f2d91b3.script_unitrigger_type = "unitrigger_box_use";
  var_4f2d91b3.cursor_hint = "HINT_NOICON";
  var_4f2d91b3.require_look_at = 1;
  var_4f2d91b3.script_width = 128;
  var_4f2d91b3.script_length = 130;
  var_4f2d91b3.script_height = 100;
  var_4f2d91b3.prompt_and_visibility_func = & function_ca475941;
  zm_unitrigger::register_static_unitrigger(var_4f2d91b3, & function_545006a5);
  var_ff4420b1 waittill("hash_639abf38");
  var_ff4420b1 delete();
  zm_unitrigger::unregister_unitrigger(var_4f2d91b3);
}

function function_ca475941(player) {
  self sethintstring("");
  return true;
}

function function_545006a5() {
  if(1) {
    for(;;) {
      self waittill("trigger", e_who);
    }
    for(;;) {}
    for(;;) {}
    if(e_who zm_utility::in_revive_trigger()) {}
    if(e_who.is_drinking > 0) {}
    if(!zm_utility::is_player_valid(e_who)) {}
    self.stub.e_parent notify("hash_639abf38");
    level flag::set("player_has_aa_gun_ammo");
    return;
  }
}

function aa_gun_think() {
  level flag::wait_till("trilogy_released");
  level thread function_35340bf6();
  level flag::wait_till("player_has_aa_gun_ammo");
  var_16bdbe0a = struct::get("aa_gun_trigger", "targetname");
  var_16bdbe0a.script_unitrigger_type = "unitrigger_box_use";
  var_16bdbe0a.radius = 64;
  var_16bdbe0a.cursor_hint = "HINT_NOICON";
  var_16bdbe0a.require_look_at = 1;
  while(!level flag::get("aa_gun_ee_complete")) {
    var_16bdbe0a.prompt_and_visibility_func = & function_9c02ad1;
    zm_unitrigger::register_static_unitrigger(var_16bdbe0a, & function_408069b5);
    level waittill("aa_gun_ammo_loaded");
    zm_unitrigger::unregister_unitrigger(var_16bdbe0a);
    wait(1);
    var_16bdbe0a.prompt_and_visibility_func = & function_97bdb2f5;
    zm_unitrigger::register_static_unitrigger(var_16bdbe0a, & function_c0946f91);
    level waittill("hash_248f6385");
    zm_unitrigger::unregister_unitrigger(var_16bdbe0a);
    wait(1);
  }
}

function function_9c02ad1(player) {
  if(!player zm_utility::is_player_looking_at(self.origin, 0.5, 0) || !level flag::get("player_has_aa_gun_ammo")) {
    self sethintstring("");
    return false;
  }
  self sethintstring("");
  return true;
}

function function_408069b5() {
  while(!level flag::get("aa_gun_ammo_loaded")) {
    self waittill("trigger", e_who);
    if(e_who zm_utility::in_revive_trigger()) {
      continue;
    }
    if(e_who.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(e_who)) {
      continue;
    }
    if(level flag::get("player_has_aa_gun_ammo")) {
      level flag::set("aa_gun_ammo_loaded");
      level flag::clear("player_has_aa_gun_ammo");
      playsoundatposition("zmb_aa_gun_load", self.origin);
      break;
    }
  }
}

function function_c0946f91() {
  while(level flag::get("aa_gun_ammo_loaded")) {
    self waittill("trigger", e_who);
    if(e_who zm_utility::in_revive_trigger()) {
      continue;
    }
    if(e_who.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(e_who)) {
      continue;
    }
    level thread function_248f6385();
    playsoundatposition("wpn_aa_fire", self.origin);
    break;
  }
}

function function_97bdb2f5(player) {
  if(!player zm_utility::is_player_looking_at(self.origin, 0.5, 0)) {
    self sethintstring("");
    return false;
  }
  self sethintstring("");
  return true;
}

function function_248f6385() {
  level notify("hash_248f6385");
  level flag::clear("aa_gun_ammo_loaded");
  var_8cad0c4d = getent("aa_gun", "targetname");
  var_8cad0c4d thread scene::play("p7_fxanim_zm_island_flak_88_bundle", var_8cad0c4d);
  exploder::exploder("fxexp_810");
  var_16bdbe0a = struct::get("aa_gun_trigger", "targetname");
  playrumbleonposition("zm_island_aa_gun_fired", var_16bdbe0a.origin);
  if(level flag::get("ee_gun_plane_in_range")) {
    level flag::set("aa_gun_ee_complete");
  }
}

function function_35340bf6() {
  while(!flag::get("aa_gun_ee_complete")) {
    e_vehicle = vehicle::simple_spawn_single("main_ee_aa_gun_plane");
    e_vehicle setforcenocull();
    e_vehicle thread function_45e9f465();
    e_vehicle thread zm_island_perks::function_235019b6("main_ee_aa_gun_plane_path");
    e_vehicle waittill("reached_end_node");
    e_vehicle clientfield::set("plane_hit_by_aa_gun", 0);
    wait(randomintrange(60, 120));
  }
}

function function_45e9f465() {
  self endon("reached_end_node");
  level flag::wait_till("aa_gun_ee_complete");
  wait(0.3);
  self clientfield::set("plane_hit_by_aa_gun", 1);
  self playSound("evt_b17_explode");
  var_f7fded02 = struct::get_array("aa_gun_elevator_part_landing", "targetname");
  s_end = array::random(var_f7fded02);
  s_explosion = spawnStruct();
  s_explosion.origin = self.origin;
  s_explosion.angles = self.angles;
  s_explosion thread scene::play("p7_fxanim_zm_island_b17_explode_bundle");
  self.delete_on_death = 1;
  self notify("death");
  if(!isalive(self)) {
    self delete();
  }
  wait(0.05);
  if(s_end.script_noteworthy == "gear_meteor") {
    nd_path_start = getvehiclenode("meteor_start", "targetname");
  } else {
    if(s_end.script_noteworthy == "gear_bunker") {
      nd_path_start = getvehiclenode("bunker_start", "targetname");
    } else {
      nd_path_start = getvehiclenode("lab_start", "targetname");
    }
  }
  var_6549ae27 = spawner::simple_spawn_single("gear_vehicle");
  mdl_part = util::spawn_model("p7_zm_bgb_gear_01", var_6549ae27.origin, s_end.angles);
  mdl_part linkto(var_6549ae27);
  mdl_part playLoopSound("evt_b17_piece_lp");
  util::wait_network_frame();
  mdl_part clientfield::set("smoke_trail_fx", 1);
  var_6549ae27 vehicle::get_on_and_go_path(nd_path_start);
  var_6549ae27 waittill("reached_end_node");
  var_6549ae27.delete_on_death = 1;
  var_6549ae27 notify("death");
  if(!isalive(var_6549ae27)) {
    var_6549ae27 delete();
  }
  mdl_part moveto(s_end.origin, 0.1);
  mdl_part waittill("movedone");
  mdl_part clientfield::set("smoke_trail_fx", 0);
  mdl_part clientfield::set("smoke_smolder_fx", 1);
  mdl_part playSound("evt_b17_piece_impact");
  mdl_part stoploopsound(0.25);
  mdl_part.trigger = zm_island_util::spawn_trigger_radius(mdl_part.origin, 50, 1, & function_9bd3096f);
  mdl_part thread function_d81e5824("elevator_part_gear3_found");
  s_explosion = undefined;
}

function function_4280e890() {
  level flag::wait_till("ee_gun_plane_in_range");
  wait(0.1);
  level flag::wait_till_clear("ee_gun_plane_in_range");
  wait(0.1);
}

function function_d81e5824(str_flag) {
  while(true) {
    self.trigger waittill("trigger", player);
    if(zm_utility::is_player_valid(player)) {
      zm_unitrigger::unregister_unitrigger(self.trigger);
      level flag::set(str_flag);
      self.trigger = undefined;
      player playSound("zmb_item_pickup");
      self delete();
      break;
    }
  }
}

function private function_9bd3096f(player) {
  return "";
}

function function_5d0980ef() {
  var_66bf6df = getent("elevator_gears", "targetname");
  var_66bf6df hidepart("wheel_01_jnt");
  var_66bf6df hidepart("wheel_02_jnt");
  var_66bf6df hidepart("wheel_03_jnt");
  level thread function_a06630fc();
}

function function_aeef1178() {
  self endon("disconnect");
  self endon("hash_51d9edd8");
  level endon("hash_b165a75b");
  level flag::wait_till("trilogy_released");
  var_e66037d6 = getent("main_ee_elevator_wall_metal", "targetname");
  var_ed315f0 = getent("main_ee_elevator_wall_decal", "targetname");
  self zm_island_util::function_7448e472(var_e66037d6);
  callback::remove_on_spawned( & function_aeef1178);
  foreach(player in level.players) {
    if(player !== self) {
      player notify("hash_51d9edd8");
    }
  }
  exploder::exploder("fxexp_509");
  level thread zm_island_util::function_925aa63a(array(var_e66037d6, var_ed315f0), 0.25, 0, 1);
  level thread function_6cc2e374();
  level notify("hash_b165a75b");
}

function function_a06630fc() {
  trigger::wait_till("trigger_see_gears");
  array::thread_all(level.players, & function_77f4b1ca);
}

function function_77f4b1ca() {
  self endon("disconnect");
  self endon("hash_87b9e813");
  var_66bf6df = getent("elevator_gears", "targetname");
  self util::waittill_player_looking_at(var_66bf6df.origin);
  foreach(player in level.players) {
    if(player != self) {
      player notify("hash_87b9e813");
    }
  }
  if(zm_utility::is_player_valid(self)) {
    self thread zm_island_vo::function_d258c672("2");
  }
}

function function_6cc2e374() {
  var_f022cb65 = getent("trigger_elevator_gears", "targetname");
  var_f022cb65 setcursorhint("HINT_NOICON");
  var_f022cb65 sethintstring("");
  var_66bf6df = getent("elevator_gears", "targetname");
  var_66bf6df thread elevator_gears();
  while(true) {
    var_f022cb65 waittill("trigger", e_who);
    if(level flag::get("elevator_part_gear1_found") && !level flag::get("elevator_part_gear1_placed")) {
      level flag::set("elevator_part_gear1_placed");
      var_f022cb65 playSound("zmb_item_pickup");
      var_66bf6df.var_df281e84 = util::spawn_model("p7_zm_isl_elevator_gears_wheel", var_66bf6df gettagorigin("wheel_01_jnt") + (1, 2, 0), var_66bf6df gettagangles("wheel_01_jnt"));
    }
    if(level flag::get("elevator_part_gear2_found") && !level flag::get("elevator_part_gear2_placed")) {
      level flag::set("elevator_part_gear2_placed");
      var_f022cb65 playSound("zmb_item_pickup");
      var_66bf6df.var_e882d83c = util::spawn_model("p7_zm_isl_elevator_gears_wheel_small", var_66bf6df gettagorigin("wheel_02_jnt") + (0.525, 2, -0.075), var_66bf6df gettagangles("wheel_02_jnt"));
    }
    if(level flag::get("elevator_part_gear3_found") && !level flag::get("elevator_part_gear3_placed")) {
      level flag::set("elevator_part_gear3_placed");
      var_f022cb65 playSound("zmb_item_pickup");
      var_66bf6df.var_aab7a6d1 = util::spawn_model("p7_zm_isl_elevator_gears_wheel_small", var_66bf6df gettagorigin("wheel_03_jnt") + vectorscale((0, 1, 0), 2), var_66bf6df gettagangles("wheel_03_jnt"));
    }
    if(level flag::get("elevator_part_gear1_found") && level flag::get("elevator_part_gear2_found") && level flag::get("elevator_part_gear3_found")) {
      var_f022cb65 playSound("zmb_elevator_fix");
      level thread zm_island_vo::function_3bf2d62a("elevator", 0, 1, 0);
      if(zm_utility::is_player_valid(e_who)) {
        e_who thread zm_island_vo::function_d258c672("elevator");
      }
      level thread elevator_init();
      break;
    }
  }
}

function elevator_gears() {
  var_17b2dca3 = getEntArray("easter_egg_elevator_cage", "targetname");
  while(true) {
    level flag::wait_till("elevator_in_use");
    wait(0.1);
    while(!isDefined(var_17b2dca3[0].is_moving)) {
      wait(0.05);
    }
    while(var_17b2dca3[0].is_moving) {
      if(level flag::get("elevator_at_bottom")) {
        n_rot = -90;
      } else {
        n_rot = 90;
      }
      self.var_df281e84 rotateroll(n_rot, 1);
      self.var_e882d83c rotateroll(n_rot, 1);
      self.var_aab7a6d1 rotateroll(n_rot * -1, 1);
      wait(0.9);
    }
    self.var_df281e84 rotateroll(n_rot * 0.01, 0.1);
    self.var_e882d83c rotateroll(n_rot * 0.01, 0.1);
    self.var_aab7a6d1 rotateroll((n_rot * -1) * 0.01, 0.1);
  }
}

function elevator_init() {
  n_width = 64;
  n_height = 128;
  n_length = 64;
  var_37f7b157 = struct::get_array("s_elevator_trigger", "targetname");
  foreach(s_org in var_37f7b157) {
    s_org.script_unitrigger_type = "unitrigger_box_use";
    s_org.cursor_hint = "HINT_NOICON";
    s_org.script_width = n_width;
    s_org.script_height = n_height;
    s_org.script_length = n_length;
    s_org.require_look_at = 1;
    s_org.prompt_and_visibility_func = & function_d93c8e95;
    zm_unitrigger::register_static_unitrigger(s_org, & function_8f599d4f);
  }
  var_37f7b157 = struct::get_array("s_elevator_call_trigger", "targetname");
  foreach(s_org in var_37f7b157) {
    s_org.script_unitrigger_type = "unitrigger_box_use";
    s_org.cursor_hint = "HINT_NOICON";
    s_org.script_width = n_width;
    s_org.script_height = n_height;
    s_org.script_length = n_length;
    s_org.require_look_at = 1;
    if(s_org.script_noteworthy == "bottom") {
      s_org.var_db67c127 = 1;
    } else {
      s_org.var_db67c127 = 0;
    }
    s_org.prompt_and_visibility_func = & function_ee748266;
    zm_unitrigger::register_static_unitrigger(s_org, & function_66070c12);
  }
  e_elevator = getent("easter_egg_elevator_cage", "targetname");
  e_elevator setmovingplatformenabled(1);
  var_dd1bd705 = getEntArray("elevator_panel_lights", "script_noteworthy");
  foreach(e_light in var_dd1bd705) {
    e_light linkto(e_elevator);
  }
  exploder::exploder("ex_elevator_panel_green");
  exploder::exploder("ex_elevator_switch_top_red");
  exploder::exploder("ex_elevator_switch_bottom_green");
  exploder::exploder("ex_elevator_overlight");
  exploder::exploder("ex_elevator_repaired");
  elevator_door();
}

function function_d93c8e95(player) {
  if(level flag::get("elevator_in_use")) {
    self sethintstring("");
    return false;
  }
  if(level flag::get("elevator_cooldown")) {
    self sethintstring(&"ZM_ISLAND_ELEVATOR_RECHARGING");
    return true;
  }
  self sethintstring(&"ZM_ISLAND_USE_ELEVATOR");
  return true;
}

function function_8f599d4f() {
  while(true) {
    self waittill("trigger", player);
    if(player zm_utility::in_revive_trigger()) {
      continue;
    }
    if(player.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(player)) {
      continue;
    }
    if(level flag::get("elevator_in_use") || level flag::get("elevator_cooldown")) {
      continue;
    }
    level thread function_46201613(self, player);
  }
}

function function_ee748266(player) {
  if(level flag::get("elevator_in_use")) {
    self sethintstring(&"ZM_ISLAND_ELEVATOR_IN_USE");
    return false;
  }
  if(level flag::get("elevator_cooldown")) {
    self sethintstring(&"ZM_ISLAND_ELEVATOR_RECHARGING");
    return true;
  }
  if(self.stub.var_db67c127 != level flag::get("elevator_at_bottom")) {
    self sethintstring(&"ZM_ISLAND_CALL_ELEVATOR");
    return true;
  }
  self sethintstring("");
  return false;
}

function function_66070c12() {
  while(true) {
    self waittill("trigger", player);
    if(player zm_utility::in_revive_trigger()) {
      continue;
    }
    if(player.is_drinking > 0) {
      continue;
    }
    if(!zm_utility::is_player_valid(player)) {
      continue;
    }
    if(level flag::get("elevator_in_use") || level flag::get("elevator_cooldown")) {
      continue;
    }
    if(self.stub.var_db67c127 != level flag::get("elevator_at_bottom")) {
      level thread function_46201613(self, player);
    }
  }
}

function function_46201613(trig_stub, player) {
  level flag::set("elevator_in_use");
  exploder::exploder_stop("ex_elevator_panel_green");
  exploder::exploder_stop("ex_elevator_switch_top_green");
  exploder::exploder_stop("ex_elevator_switch_bottom_green");
  exploder::exploder("ex_elevator_panel_red");
  exploder::exploder("ex_elevator_switch_top_red");
  exploder::exploder("ex_elevator_switch_bottom_red");
  elevator_door(0);
  elevator_move();
  elevator_door();
  level flag::clear("elevator_in_use");
  level flag::set("elevator_cooldown");
  wait(5);
  level flag::clear("elevator_cooldown");
  exploder::exploder_stop("ex_elevator_panel_red");
  exploder::exploder("ex_elevator_panel_green");
  if(level flag::get("elevator_at_bottom")) {
    exploder::exploder_stop("ex_elevator_switch_top_red");
    exploder::exploder("ex_elevator_switch_top_green");
  } else {
    exploder::exploder_stop("ex_elevator_switch_bottom_red");
    exploder::exploder("ex_elevator_switch_bottom_green");
  }
}

function elevator_door(b_open = 1) {
  if(level flag::get("elevator_at_bottom")) {
    e_door_left = getent("easter_egg_elevator_door_bottom_left", "targetname");
    e_door_right = getent("easter_egg_elevator_door_bottom_right", "targetname");
    var_28bca224 = getent("easter_egg_elevator_door_inner_bottom_left", "targetname");
    var_70426c1b = getent("easter_egg_elevator_door_inner_bottom_right", "targetname");
    var_2e25ac99 = getnodearray("elevator_bottom_begin_node", "targetname");
  } else {
    e_door_left = getent("easter_egg_elevator_door_top_left", "targetname");
    e_door_right = getent("easter_egg_elevator_door_top_right", "targetname");
    var_28bca224 = getent("easter_egg_elevator_door_inner_top_left", "targetname");
    var_70426c1b = getent("easter_egg_elevator_door_inner_top_right", "targetname");
    var_2e25ac99 = getnodearray("elevator_top_begin_node", "targetname");
  }
  if(isDefined(b_open) && b_open) {
    e_door_left notsolid();
    e_door_right notsolid();
    var_28bca224 notsolid();
    var_70426c1b notsolid();
    e_door_left connectpaths();
    e_door_right connectpaths();
    var_28bca224 connectpaths();
    var_70426c1b connectpaths();
    foreach(var_49686839 in var_2e25ac99) {
      linktraversal(var_49686839);
    }
    e_door_left movey(-40, 1);
    e_door_right movey(40, 1);
    var_28bca224 movey(-40, 1);
    var_70426c1b movey(40, 1);
    var_28bca224 playSound("zmb_elevator_door_open");
    level flag::clear("elevator_door_closed");
  } else {
    foreach(var_49686839 in var_2e25ac99) {
      unlinktraversal(var_49686839);
    }
    e_door_left solid();
    e_door_right solid();
    var_28bca224 solid();
    var_70426c1b solid();
    e_door_left disconnectpaths();
    e_door_right disconnectpaths();
    var_28bca224 disconnectpaths();
    var_70426c1b disconnectpaths();
    e_door_left movey(40, 1);
    e_door_right movey(-40, 1);
    var_28bca224 movey(40, 1);
    var_70426c1b movey(-40, 1);
    var_28bca224 playSound("zmb_elevator_door_close");
    level flag::set("elevator_door_closed");
  }
  e_door_left waittill("movedone");
}

function elevator_move() {
  var_17b2dca3 = getEntArray("easter_egg_elevator_cage", "targetname");
  var_1fac16fe = getent("easter_egg_elevator_door_inner_top_left", "targetname");
  var_1fac16fe linkto(var_17b2dca3[0]);
  var_adbea363 = getent("easter_egg_elevator_door_inner_top_right", "targetname");
  var_adbea363 linkto(var_17b2dca3[0]);
  var_46ebdf14 = getent("easter_egg_elevator_door_inner_bottom_left", "targetname");
  var_46ebdf14 linkto(var_17b2dca3[0]);
  var_ddc6ba27 = getent("easter_egg_elevator_door_inner_bottom_right", "targetname");
  var_ddc6ba27 linkto(var_17b2dca3[0]);
  if(level flag::get("elevator_at_bottom")) {
    foreach(e_elevator in var_17b2dca3) {
      e_elevator movez(1280, 20);
    }
  } else {
    foreach(e_elevator in var_17b2dca3) {
      e_elevator movez(-1280, 20);
    }
  }
  var_17b2dca3[0].is_moving = 1;
  var_17b2dca3[0] playSound("zmb_elevator_start");
  var_17b2dca3[0] playLoopSound("zmb_elevator_loop");
  var_17b2dca3[0] thread function_7b8e6e93();
  var_17b2dca3[0] waittill("movedone");
  var_17b2dca3[0] thread function_e35db912();
  var_17b2dca3[0].is_moving = 0;
  var_17b2dca3[0] playSound("zmb_elevator_stop");
  var_17b2dca3[0] stoploopsound(0.5);
  var_1fac16fe = getent("easter_egg_elevator_door_inner_top_left", "targetname");
  var_1fac16fe unlink();
  var_adbea363 = getent("easter_egg_elevator_door_inner_top_right", "targetname");
  var_adbea363 unlink();
  var_46ebdf14 = getent("easter_egg_elevator_door_inner_bottom_left", "targetname");
  var_46ebdf14 unlink();
  var_ddc6ba27 = getent("easter_egg_elevator_door_inner_bottom_right", "targetname");
  var_ddc6ba27 unlink();
  if(level flag::get("elevator_at_bottom")) {
    level flag::clear("elevator_at_bottom");
  } else {
    level flag::set("elevator_at_bottom");
  }
}

function function_7b8e6e93() {
  self endon("movedone");
  while(true) {
    foreach(player in level.players) {
      if(player istouching(self)) {
        player.in_elevator = 1;
      }
    }
    wait(0.05);
    foreach(player in level.players) {
      if(player.in_elevator === 1 && (player.origin[2] > (self.origin[2] + 60) || player.origin[2] < (self.origin[2] - 20))) {
        player setorigin(self.origin + vectorscale((0, 0, 1), 20));
      }
    }
  }
}

function function_e35db912() {
  wait(0.1);
  foreach(player in level.players) {
    player.in_elevator = 0;
  }
}

function function_f818f5b5() {
  level flag::wait_till("all_challenges_completed");
  zm::register_actor_damage_callback( & function_16155679);
  zm::register_vehicle_damage_callback( & function_a7a11020);
  var_8d943e64 = getent("ruins_lightning_trigger", "targetname");
  while(true) {
    wait(randomfloatrange(60, 90));
    exploder::exploder("fxexp_510");
    exploder::exploder("fxexp_511");
    exploder::exploder("fxexp_512");
    exploder::exploder("fxexp_513");
    exploder::exploder("fxexp_514");
    exploder::exploder("fxexp_820");
    exploder::exploder("fxexp_821");
    exploder::exploder("fxexp_822");
    exploder::exploder("fxexp_823");
    level thread function_51f6829f(var_8d943e64);
    wait(5);
    level notify("hash_6d764fa3");
    exploder::exploder_stop("fxexp_510");
    exploder::exploder_stop("fxexp_511");
    exploder::exploder_stop("fxexp_512");
    exploder::exploder_stop("fxexp_513");
    exploder::exploder_stop("fxexp_514");
    exploder::exploder_stop("fxexp_820");
    exploder::exploder_stop("fxexp_821");
    exploder::exploder_stop("fxexp_822");
    exploder::exploder_stop("fxexp_823");
  }
}

function function_51f6829f(var_8d943e64) {
  level endon("hash_6d764fa3");
  wait(1);
  while(true) {
    foreach(player in level.players) {
      if(player istouching(var_8d943e64)) {
        w_current = player getcurrentweapon();
        if(w_current.isriotshield === 1 && (!(isDefined(player zm_laststand::is_reviving_any()) && player zm_laststand::is_reviving_any())) && (isDefined(zm_utility::is_player_valid(player)) && zm_utility::is_player_valid(player))) {
          if(!(isDefined(player.var_36c3d64a) && player.var_36c3d64a)) {
            player thread function_8f34e78f();
            player notify("player_got_lightning_shield");
          }
          continue;
        }
        if(!(isDefined(player.var_bd2718b6) && player.var_bd2718b6)) {
          player dodamage(player.maxhealth * 0.5, player.origin);
          player thread function_69b5fce9();
        }
      }
    }
    wait(0.1);
  }
}

function function_69b5fce9() {
  self endon("disconnect");
  self.var_bd2718b6 = 1;
  wait(3);
  self.var_bd2718b6 = 0;
}

function function_8f34e78f() {
  self.var_36c3d64a = 1;
  self.riotshield_damage_absorb_callback = & function_d68f2492;
  self thread function_e7cf715();
  self clientfield::set("lightning_shield_fx", 1);
}

function function_e7cf715() {
  self endon("disconnect");
  self util::waittill_any("destroy_riotshield", "riotshield_lost_lightning", "bled_out");
  self.var_36c3d64a = 0;
  self.riotshield_damage_absorb_callback = undefined;
  self clientfield::set("lightning_shield_fx", 0);
}

function function_9f26e724() {
  foreach(var_c9340b8 in level.var_961b3545) {
    if(var_c9340b8.script_string != "revive_perk" || (level.activeplayers.size > 1 && var_c9340b8.script_string == "revive_perk")) {
      var_c9340b8 thread function_f295a467();
    }
  }
}

function function_f295a467() {
  self endon("death");
  self.var_bf47c5ef = 0;
  self.machine setCanDamage(1);
  while(true) {
    self.machine waittill("damage", n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, str_part_name, w_weapon);
    n_damage = 0;
    if(isDefined(w_weapon.isriotshield) && w_weapon.isriotshield && (isDefined(e_attacker.var_36c3d64a) && e_attacker.var_36c3d64a) && !self.var_bf47c5ef) {
      e_attacker notify("riotshield_lost_lightning");
      self.var_bf47c5ef = 1;
      self.var_a62a0fde = self.cost;
      self playSound("zmb_lightning_shield_activate");
      str_perk = self.script_noteworthy;
      if(isDefined(level._custom_perks) && isDefined(level._custom_perks[str_perk])) {
        self.cost = int(self.cost * 0.5);
        level._custom_perks[str_perk].cost = self.cost;
        self.machine thread function_b83e4b61(str_perk, 1);
        self zm_perks::reset_vending_hint_string();
        wait(30);
        self.machine thread function_b83e4b61(str_perk, 0);
        self.var_bf47c5ef = 0;
        self.cost = self.var_a62a0fde;
        level._custom_perks[str_perk].cost = self.cost;
        self zm_perks::reset_vending_hint_string();
      }
    }
  }
}

function function_b83e4b61(str_perk, b_on) {
  if(b_on) {
    switch (str_perk) {
      case "specialty_doubletap2": {
        self clientfield::set("perk_lightning_fx", 1);
        break;
      }
      case "specialty_armorvest": {
        self clientfield::set("perk_lightning_fx", 2);
        break;
      }
      case "specialty_quickrevive": {
        self clientfield::set("perk_lightning_fx", 3);
        break;
      }
      case "specialty_fastreload": {
        self clientfield::set("perk_lightning_fx", 4);
        break;
      }
      case "specialty_staminup": {
        self clientfield::set("perk_lightning_fx", 5);
        break;
      }
      case "specialty_additionalprimaryweapon": {
        self clientfield::set("perk_lightning_fx", 6);
        break;
      }
      default: {
        self clientfield::set("perk_lightning_fx", 1);
        break;
      }
    }
  } else {
    self clientfield::set("perk_lightning_fx", 0);
  }
}

function function_8221532d() {
  var_d3ed310f = getEntArray("bgb_damage_clip", "script_noteworthy");
  foreach(var_a27ff52f in var_d3ed310f) {
    foreach(e_bgb_machine in level.bgb_machines) {
      if(e_bgb_machine istouching(var_a27ff52f)) {
        e_bgb_machine.var_9e209773 = var_a27ff52f;
        e_bgb_machine thread function_e20ecfa4();
        break;
      }
    }
  }
}

function function_e20ecfa4() {
  self endon("death");
  self.var_bf47c5ef = 0;
  self.var_9e209773 setCanDamage(1);
  self.var_9e209773.health = 99999;
  while(true) {
    self.var_9e209773 waittill("damage", n_damage, e_attacker, v_direction, v_point, str_mod, str_tag_name, str_model_name, str_part_name, w_weapon);
    n_damage = 0;
    if(isDefined(w_weapon.isriotshield) && w_weapon.isriotshield && (isDefined(e_attacker.var_36c3d64a) && e_attacker.var_36c3d64a) && !self.var_bf47c5ef) {
      if(isDefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"]) {
        continue;
      }
      self.var_9e209773 playSound("zmb_lightning_shield_activate");
      e_attacker notify("riotshield_lost_lightning");
      self.var_bf47c5ef = 1;
      self.var_a62a0fde = self.base_cost;
      self.base_cost = int(self.base_cost * 0.5);
      self clientfield::set("bgb_lightning_fx", 1);
      wait(30);
      if(isDefined(level.zombie_vars["zombie_powerup_fire_sale_on"]) && level.zombie_vars["zombie_powerup_fire_sale_on"]) {
        level waittill("fire_sale_off");
        wait(0.5);
      }
      self clientfield::set("bgb_lightning_fx", 0);
      self.var_bf47c5ef = 0;
      self.base_cost = self.var_a62a0fde;
    }
  }
}

function function_16155679(inflictor, attacker, damage, flags, meansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(isDefined(weapon.isriotshield) && weapon.isriotshield && (isDefined(attacker.var_36c3d64a) && attacker.var_36c3d64a) && !isplayer(self)) {
    attacker zm_bgb_pop_shocks::electrocute_actor(self);
    attacker notify("hash_aacf862e");
    attacker zm_island_vo::function_1881817("kill", "shield_electric");
  }
  return -1;
}

function function_a7a11020(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  if(isDefined(weapon.isriotshield) && weapon.isriotshield && (isDefined(eattacker.var_36c3d64a) && eattacker.var_36c3d64a) && !isplayer(self)) {
    if(level.var_335f95e4 === self && level flag::get("spider_from_mars_trapped_in_raised_cage")) {
      return 0;
    }
    eattacker zm_bgb_pop_shocks::electrocute_actor(self);
    eattacker zm_island_vo::function_1881817("kill", "shield_electric");
  }
  return idamage;
}

function function_d68f2492(eattacker, idamage, shitloc, smeansofdeath) {
  if(isDefined(self.var_36c3d64a) && self.var_36c3d64a && !isplayer(eattacker)) {
    self zm_bgb_pop_shocks::electrocute_actor(eattacker);
  }
}

function function_e509082() {
  level flag::wait_till("flag_play_outro_cutscene");
  foreach(player in level.activeplayers) {
    player thread zm_island_vo::function_cf763858();
  }
  level lui::screen_fade_out(0, "black");
  level util::player_lock_control();
  scene::add_scene_func("cin_isl_outro_3rd_sh140", & function_c93cd104, "play");
  scene::add_scene_func("cin_isl_outro_3rd_sh240", & function_c5001569, "play");
  scene::add_scene_func("cin_isl_outro_3rd_sh240", & function_dad4e4f3, "done");
  scene::add_scene_func("cin_isl_outro_3rd_sh250", & function_1f3b8e3c, "play");
  scene::add_scene_func("cin_isl_outro_3rd_sh250", & function_da7a6f36, "done");
  wait(0.25);
  getent("mdl_alttakeo", "targetname") hide();
  level thread function_dcf88974();
  level flag::set("flag_show_outro_water");
  wait(0.25);
  level lui::screen_fade_in(0, "black");
  level scene::play("cin_isl_outro_3rd_sh010");
  array::thread_all(level.activeplayers, & zm_utility::give_player_all_perks);
  array::thread_all(level.players, & function_d875b253);
  array::thread_all(level.players, & function_d2e1a913);
  level flag::set("flag_outro_cutscene_done");
}

function function_d2e1a913() {
  level scoreevents::processscoreevent("main_EE_quest_island", self);
  self zm_stats::increment_global_stat("DARKOPS_ISLAND_EE");
  self zm_stats::increment_global_stat("DARKOPS_ISLAND_SUPER_EE");
}

function function_d875b253() {
  if(isalive(self) && self.characterindex != 2) {
    self setcharacterbodystyle(1);
  }
}

function function_c93cd104(a_ents) {
  var_722023b5 = a_ents["old_takeo"];
  var_722023b5 waittill("hash_a00e5555");
  if(level.var_7ccadaab === 11) {
    var_722023b5 playsoundontag("vox_tak1_outro_igc_japalt_13", "J_Head");
  } else {
    var_722023b5 playsoundontag("vox_tak1_outro_igc_13", "J_Head");
  }
}

function function_c5001569(a_ents) {
  level waittill("hash_83582d4d");
  level lui::screen_fade_out(0, "black");
}

function function_dad4e4f3(a_ents) {
  level lui::screen_fade_in(0, "black");
}

function function_1f3b8e3c(a_ents = undefined) {
  var_f852acf0 = a_ents["summoning_key"];
  s_org = struct::get("tag_align_end_cinematic");
  e_org = spawn("script_model", s_org.origin);
  if(isDefined(a_ents)) {
    level waittill("hash_f2d5d1f");
  }
  level lui::screen_fade_out(0, "white");
  level waittill("hash_71fdf829");
  e_org playsoundwithnotify("vox_plr_0_outro_igc_28");
  var_f852acf0 hide();
  level waittill("hash_4bfb7dc0");
  e_org playsoundwithnotify("vox_plr_2_outro_igc_29");
  level waittill("portal_effect");
  array::thread_all(level.players, & function_449f0778);
  level lui::screen_fade_in(0.5, "white");
  e_org delete();
}

function function_da7a6f36(a_ents) {
  level thread function_f714fcfa();
  level thread scene::play("cin_isl_outro_1st_old_takeo_corpse");
  level flag::set("flag_hide_outro_water");
}

function function_f714fcfa() {
  wait(5);
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh010");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh020");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh030");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh040");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh060");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh070");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh080");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh090");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh100");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh120");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh130");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh140");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh150");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh160");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh170");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh175");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh180");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh190");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh190");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh195");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh196");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh200");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh210");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh220");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh230");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh240");
  struct::delete_script_bundle("scene", "cin_isl_outro_3rd_sh250");
}

function function_dcf88974() {
  foreach(player in level.players) {
    n_player_index = player.characterindex;
    s_org = struct::get("ending_igc_exit_" + n_player_index);
    player setorigin(s_org.origin);
    player setplayerangles(s_org.angles);
    player freezecontrolsallowlook(1);
    player allowsprint(0);
    player allowjump(0);
    player enableinvulnerability();
    player setclientuivisibilityflag("hud_visible", 0);
    player setclientuivisibilityflag("weapon_hud_visible", 0);
    player disableweapons();
    player.var_d07c64b6 = 0;
    player notify("hash_dd8e5266");
    player clientfield::set("spore_trail_player_fx", 0);
    player clientfield::set_to_player("spore_camera_fx", 0);
  }
}

function function_449f0778() {
  self endon("disconnect");
  self clientfield::set_to_player("player_stargate_fx", 1);
  n_player_index = self.characterindex;
  level clientfield::set("portal_state_ending_" + n_player_index, 1);
  s_org = struct::get("ending_igc_exit_" + n_player_index);
  self playSound("zmb_outro_teleport");
  wait(3);
  self clientfield::set_to_player("player_stargate_fx", 0);
  wait(1.5);
  level util::player_unlock_control();
  self enableweapons();
  self freezecontrolsallowlook(0);
  self allowsprint(1);
  self allowjump(1);
  self disableinvulnerability();
  self setclientuivisibilityflag("hud_visible", 1);
  self setclientuivisibilityflag("weapon_hud_visible", 1);
  level clientfield::set("portal_state_ending_" + n_player_index, 0);
  level thread zm_island_vo::function_b83e53a5();
  level flag::set("spawn_zombies");
  level.disable_nuke_delay_spawning = 0;
}

function function_dcc18c22() {
  e_water = getent("main_ee_outro_water", "targetname");
  e_water hide();
  level flag::wait_till("flag_show_outro_water");
  e_water show();
  level flag::wait_till("flag_hide_outro_water");
  e_water hide();
}

function function_12d043ed() {
  level flag::set("");
  zm_devgui::add_custom_devgui_callback( & function_efbc0e1);
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
  adddebugcommand("");
}

function function_efbc0e1(cmd) {
  switch (cmd) {
    case "": {
      level flag::set("");
      return true;
    }
    case "": {
      level thread function_85b23415();
      level flag::set("");
      level flag::set("");
      level flag::set("");
      level flag::set("");
      return true;
    }
    case "": {
      foreach(player in level.players) {
        w_current = player getcurrentweapon();
        if(w_current.isriotshield === 1) {
          player thread function_8f34e78f();
        }
      }
      return true;
    }
    case "": {
      elevator_init();
      return true;
    }
    case "": {
      level flag::set("");
      level flag::set("");
      level flag::set("");
      return true;
    }
    case "": {
      clientfield::set("", 1);
      level scene::init("");
      while(!level scene::is_ready("")) {
        wait(0.05);
      }
      wait(5);
      level flag::set("");
      return true;
    }
    case "": {
      level thread function_1f3b8e3c();
      return true;
    }
  }
  return false;
}