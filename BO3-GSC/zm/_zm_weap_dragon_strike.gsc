/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: zm\_zm_weap_dragon_strike.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\shared\animation_shared;
#using scripts\shared\array_shared;
#using scripts\shared\callbacks_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\fx_shared;
#using scripts\shared\system_shared;
#using scripts\shared\util_shared;
#using scripts\zm\_util;
#using scripts\zm\_zm;
#using scripts\zm\_zm_audio;
#using scripts\zm\_zm_equipment;
#using scripts\zm\_zm_placeable_mine;
#using scripts\zm\_zm_spawner;
#using scripts\zm\_zm_stats;
#using scripts\zm\_zm_utility;
#using scripts\zm\_zm_weapons;
#namespace dragon_strike;

function autoexec __init__sytem__() {
  system::register("zm_weap_dragon_strike", &__init__, &__main__, undefined);
}

function __init__() {
  clientfield::register("scriptmover", "dragon_strike_spawn_fx", 12000, 1, "int");
  clientfield::register("scriptmover", "dragon_strike_marker_on", 12000, 1, "int");
  clientfield::register("scriptmover", "dragon_strike_marker_fx", 12000, 1, "counter");
  clientfield::register("scriptmover", "dragon_strike_marker_upgraded_fx", 12000, 1, "counter");
  clientfield::register("scriptmover", "dragon_strike_marker_invalid_fx", 12000, 1, "counter");
  clientfield::register("scriptmover", "dragon_strike_marker_upgraded_invalid_fx", 12000, 1, "counter");
  clientfield::register("scriptmover", "dragon_strike_flare_fx", 12000, 1, "int");
  clientfield::register("scriptmover", "dragon_strike_marker_fx_fadeout", 12000, 1, "counter");
  clientfield::register("scriptmover", "dragon_strike_marker_upgraded_fx_fadeout", 12000, 1, "counter");
  clientfield::register("actor", "dragon_strike_zombie_fire", 12000, 2, "int");
  clientfield::register("vehicle", "dragon_strike_zombie_fire", 12000, 2, "int");
  clientfield::register("clientuimodel", "dragon_strike_invalid_use", 12000, 1, "counter");
  clientfield::register("clientuimodel", "hudItems.showDpadRight_DragonStrike", 12000, 1, "int");
  callback::on_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  level.func_custom_placeable_mine_round_replenish = &function_ff07e778;
  zm::register_player_damage_callback(&function_43b5419a);
}

function __main__() {
  zm_placeable_mine::add_mine_type("launcher_dragon_strike");
  zm_placeable_mine::add_mine_type("launcher_dragon_strike_upgraded");
  if(isDefined(level.retrievehints["launcher_dragon_strike"])) {
    arrayremoveindex(level.retrievehints, "launcher_dragon_strike", 1);
  }
  if(isDefined(level.retrievehints["launcher_dragon_strike_upgraded"])) {
    arrayremoveindex(level.retrievehints, "launcher_dragon_strike_upgraded", 1);
  }
  zm_spawner::register_zombie_death_event_callback(&function_22664e38);
}

function on_player_connect() {
  self thread function_2d8749cd();
  self thread on_player_disconnect();
  self thread function_1939853d();
}

function on_player_spawned() {
  if(!self flag::exists("show_dragon_strike_reticule")) {
    self flag::init("show_dragon_strike_reticule");
  }
  if(!self flag::exists("dragon_strike_active")) {
    self flag::init("dragon_strike_active");
  }
  self thread function_d5acc054();
  self thread function_3e8c94e3();
}

function function_1939853d() {
  self endon("disconnect");
  self notify("hash_1939853d");
  self endon("hash_1939853d");
  for(;;) {
    self waittill("zmb_max_ammo");
    wait(0.05);
    self function_ab4fad2f();
  }
}

function function_ab4fad2f() {
  var_5a0c399b = self zm_utility::get_player_placeable_mine();
  if(var_5a0c399b == getweapon("launcher_dragon_strike")) {
    n_max_ammo = 1;
  } else {
    if(var_5a0c399b == getweapon("launcher_dragon_strike_upgraded")) {
      n_max_ammo = 2;
    } else {
      return;
    }
  }
  if(self getammocount(var_5a0c399b) < n_max_ammo) {
    if(array::contains(level.var_163a43e4, self)) {
      self waittill("hash_2e47bc4a");
    }
    self setweaponammoclip(var_5a0c399b, n_max_ammo);
  }
}

function function_ff07e778() {
  a_players = getplayers();
  for(i = 0; i < a_players.size; i++) {
    foreach(var_3ef7692 in level.placeable_mines) {
      if(a_players[i] zm_utility::is_player_placeable_mine(var_3ef7692)) {
        if(var_3ef7692 == getweapon("launcher_dragon_strike") || var_3ef7692 == getweapon("launcher_dragon_strike_upgraded")) {
          a_players[i] function_ab4fad2f();
          continue;
          continue;
        }
        a_players[i] giveweapon(var_3ef7692);
        a_players[i] zm_utility::set_player_placeable_mine(var_3ef7692);
        a_players[i] setactionslot(4, "weapon", var_3ef7692);
        a_players[i] setweaponammoclip(var_3ef7692, 2);
        break;
      }
    }
  }
}

function on_player_disconnect() {
  self waittill("disconnect");
  if(isDefined(self.mdl_target) && !self flag::get("dragon_strike_active")) {
    mdl_target = self.mdl_target;
    mdl_target clientfield::set("dragon_strike_marker_on", 0);
    wait(0.3);
    mdl_target delete();
  }
}

function function_43b5419a(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime, boneindex) {
  if(isDefined(einflictor) && isDefined(einflictor.item) && (einflictor.item == getweapon("launcher_dragon_fire") || einflictor.item == getweapon("launcher_dragon_fire_upgraded"))) {
    return 0;
  }
  return -1;
}

function function_2d8749cd() {
  self endon("disconnect");
  while(isDefined(self)) {
    self waittill("weapon_change", weapon);
    if(weapon == getweapon("launcher_dragon_strike")) {
      break;
    }
  }
  zm_equipment::show_hint_text(&"ZM_STALINGRAD_DRAGON_STRIKE_USE");
}

function function_d5acc054() {
  self endon("disconnect");
  while(true) {
    self waittill("weapon_change", weapon, previous_weapon);
    if(function_9e0c324b(weapon)) {
      if(self.var_8660deae === 0) {
        self playsoundtoplayer("fly_dragon_strike_ui_error", self);
        self thread zm_equipment::show_hint_text(&"ZM_STALINGRAD_DRAGON_STRIKE_UNAVAILABLE");
        self function_6c8dfca2(previous_weapon);
        continue;
      } else {
        self thread function_8ad253d8(previous_weapon);
      }
    } else {
      self notify("hash_85e0a572");
      self flag::clear("show_dragon_strike_reticule");
    }
  }
}

function function_3e8c94e3() {
  self endon("disconnect");
  while(true) {
    self waittill("specify_weapon_request", weapon);
    if(function_9e0c324b(weapon) && (self getammocount(weapon) == 0 || self.var_8660deae === 0)) {
      self clientfield::increment_uimodel("dragon_strike_invalid_use");
    }
  }
}

function function_9e0c324b(var_382bb75) {
  if(var_382bb75 == getweapon("launcher_dragon_strike") || var_382bb75 == getweapon("launcher_dragon_strike_upgraded")) {
    return true;
  }
  return false;
}

function function_8ad253d8(previous_weapon) {
  self endon("hash_85e0a572");
  self endon("disconnect");
  self flag::set("show_dragon_strike_reticule");
  self thread function_7fcb14a8();
  self waittill("weapon_fired");
  if(self flag::get("dragon_strike_active")) {
    self playsoundtoplayer("fly_dragon_strike_ui_error", self);
    self thread zm_equipment::show_hint_text(&"ZM_STALINGRAD_DRAGON_STRIKE_BUSY");
    self function_6c8dfca2(previous_weapon);
    return;
  }
  if(self function_f80cd2c9()) {
    self flag::set("dragon_strike_active");
    self playsoundtoplayer("fly_dragon_strike_ui_activate", self);
    self zm_audio::create_and_play_dialog("dragon_strike", "call_in");
    self util::delay(0.5, "death", &function_6c8dfca2, previous_weapon);
    self thread function_a3b69ec0(self.var_5d020ece);
    self thread function_2864e2c1();
    return;
  }
  self playsoundtoplayer("fly_dragon_strike_ui_error", self);
  self thread zm_equipment::show_hint_text(&"ZM_STALINGRAD_DRAGON_STRIKE_INVALID");
  self thread function_8ad253d8(previous_weapon);
}

function function_f80cd2c9() {
  if(isDefined(self.var_be00572f)) {
    return true;
  }
  return false;
}

function function_2864e2c1() {
  self endon("disconnect");
  self.var_8660deae = 0;
  self flag::wait_till_clear("dragon_strike_active");
  self.var_8660deae = 1;
  if(isDefined(level.var_d4286019) && level.var_d4286019) {
    var_5a0c399b = self zm_utility::get_player_placeable_mine();
    self function_ab4fad2f();
  }
}

function function_42ab5fbb(var_5d020ece) {
  self clientfield::set("dragon_strike_spawn_fx", 1);
  self thread animation::play("ai_zm_dlc3_dragon_strike_1", self);
}

function function_a3b69ec0(var_5d020ece) {
  self endon("disconnect");
  var_5a0c399b = self zm_utility::get_player_placeable_mine();
  if(var_5a0c399b == getweapon("launcher_dragon_strike_upgraded")) {
    b_upgraded = 1;
    var_35ab0c48 = 400;
    var_825b87b9 = 800;
    var_6646a04b = getweapon("launcher_dragon_fire_upgraded");
  } else {
    b_upgraded = 0;
    var_35ab0c48 = 300;
    var_825b87b9 = 600;
    var_6646a04b = getweapon("launcher_dragon_fire");
  }
  self setweaponammoclip(var_5a0c399b, self getammocount(var_5a0c399b) - 1);
  self flag::clear("show_dragon_strike_reticule");
  self.mdl_target thread function_6efadb82(var_825b87b9, var_5a0c399b);
  level thread function_9af893e8(self, var_5d020ece, b_upgraded, var_35ab0c48, var_6646a04b);
  level waittill("hash_d3a01285");
  self notify("hash_ddb84fad", self.var_8e17738c);
  self flag::clear("dragon_strike_active");
}

function function_9af893e8(e_player, var_5d020ece, b_upgraded, var_35ab0c48, var_6646a04b) {
  var_2fcea154 = util::spawn_anim_model("c_zom_dlc3_dragon_body_airstrike", var_5d020ece.var_53d81d57, var_5d020ece.angles + vectorscale((1, 0, 0), 25));
  var_2fcea154 function_42ab5fbb(var_5d020ece);
  if(isDefined(e_player)) {
    var_2fcea154.player = e_player;
    e_player.var_8e17738c = 0;
  }
  for(i = 0; i < 4; i++) {
    var_2fcea154 waittill("fireball");
    var_2fcea154.var_201fdf35 = var_2fcea154 gettagorigin("tag_throat_fx");
    var_c606eb7 = 6;
    do {
      var_2410d5ad = var_5d020ece.v_loc + function_adac83c4();
      var_c606eb7--;
    }
    while(bullettracepassed(var_2fcea154.var_201fdf35, var_2410d5ad, 0, var_2fcea154) && var_c606eb7 > 0);
    var_aa911866 = magicbullet(var_6646a04b, var_2fcea154.var_201fdf35, var_2410d5ad, var_2fcea154);
    level thread function_a6d19957(b_upgraded, var_aa911866, var_5d020ece.v_loc, var_35ab0c48);
  }
  var_2fcea154 thread function_604af93b();
  while(isDefined(var_aa911866)) {
    wait(0.05);
  }
  level notify("hash_d67e330d");
}

function function_a6d19957(b_upgraded, var_aa911866, v_hitloc, n_range) {
  while(isDefined(var_aa911866)) {
    wait(0.05);
  }
  a_ai_zombies = array::get_all_closest(v_hitloc, getaiarchetypearray("zombie"), undefined, undefined, n_range);
  if(b_upgraded) {
    n_clientfield = 2;
  } else {
    n_clientfield = 1;
  }
  foreach(ai_zombie in a_ai_zombies) {
    if(isDefined(ai_zombie) && (!(isDefined(ai_zombie.var_4cfc625d) && ai_zombie.var_4cfc625d))) {
      ai_zombie clientfield::set("dragon_strike_zombie_fire", n_clientfield);
      wait(randomfloat(0.1));
    }
  }
}

function function_adac83c4() {
  var_8eae13b3 = randomintrange(-50, 50);
  var_68ab994a = randomintrange(-50, 50);
  var_8d74b778 = (var_8eae13b3, var_68ab994a, 0);
  return var_8d74b778;
}

function function_6efadb82(var_825b87b9, var_5a0c399b) {
  self clientfield::set("dragon_strike_flare_fx", 1);
  var_dc5fde65 = getclosestpointonnavmesh(self.origin, 128);
  var_1e43571f = util::spawn_model("tag_origin", var_dc5fde65);
  var_1e43571f zm_utility::create_zombie_point_of_interest(var_825b87b9, 64, 10000);
  level waittill("hash_d67e330d");
  if(isDefined(self)) {
    self clientfield::set("dragon_strike_flare_fx", 0);
    if(var_5a0c399b == getweapon("launcher_dragon_strike_upgraded")) {
      self clientfield::increment("dragon_strike_marker_upgraded_fx_fadeout");
    } else {
      self clientfield::increment("dragon_strike_marker_fx_fadeout");
    }
  }
  var_1e43571f delete();
  wait(3.5);
  if(isDefined(self)) {
    self clientfield::set("dragon_strike_marker_on", 0);
  }
  wait(0.3);
  if(isDefined(self)) {
    self delete();
  }
}

function function_22664e38(e_attacker) {
  if(isDefined(self) && (self.damageweapon === getweapon("launcher_dragon_fire") || self.damageweapon === getweapon("launcher_dragon_fire_upgraded"))) {
    if(isDefined(e_attacker) && isDefined(e_attacker.player)) {
      e_attacker.player.var_8e17738c++;
    }
  }
}

function function_604af93b() {
  self waittill("scriptedanim");
  level notify("hash_d3a01285");
  self delete();
}

function function_7fcb14a8() {
  self notify("hash_26b100ad");
  self endon("hash_26b100ad");
  self endon("disconnect");
  var_b912cdaf = vectorscale((0, 0, 1), 8);
  if(!isDefined(self.mdl_target)) {
    self.mdl_target = util::spawn_model("tag_origin", self.origin);
  }
  util::wait_network_frame();
  self.mdl_target clientfield::set("dragon_strike_marker_on", 1);
  var_5a0c399b = self zm_utility::get_player_placeable_mine();
  if(var_5a0c399b == getweapon("launcher_dragon_strike_upgraded")) {
    var_78f8828b = "dragon_strike_marker_upgraded_fx";
    var_854898eb = "dragon_strike_marker_upgraded_invalid_fx";
  } else {
    var_78f8828b = "dragon_strike_marker_fx";
    var_854898eb = "dragon_strike_marker_invalid_fx";
  }
  while(self flag::get("show_dragon_strike_reticule")) {
    v_start = self getEye();
    v_forward = self getweaponforwarddir();
    v_end = v_start + (v_forward * 2500);
    a_trace = bulletTrace(v_start, v_end, 0, self.mdl_target, 1, 0, self.var_1e43571f);
    self.var_be00572f = a_trace["position"];
    if(isDefined(self.var_5d020ece)) {
      self.var_5d020ece struct::delete();
    }
    self.var_5d020ece = self function_c7832a90(self.var_be00572f);
    if(!isDefined(self.var_5d020ece)) {
      self function_5a9be7d8(var_854898eb);
      wait(0.1);
      continue;
    }
    self.mdl_target clientfield::increment(var_78f8828b);
    self.mdl_target moveto(self.var_be00572f + var_b912cdaf, 0.05);
    wait(0.1);
  }
  if(self flag::get("dragon_strike_active")) {
    return;
  }
  self.mdl_target clientfield::set("dragon_strike_marker_on", 0);
  wait(0.3);
  self.mdl_target delete();
}

function function_c7832a90(v_loc) {
  var_feed8b5b = 0;
  v_forward = v_loc - self.origin;
  v_angles = vectortoangles(v_forward);
  v_angles = (v_angles[0], v_angles[1], 0);
  var_1ccc854e = anglesToForward(v_angles);
  var_53d81d57 = (v_loc[0] + (var_1ccc854e[0] * 1000), v_loc[1] + (var_1ccc854e[1] * 1000), v_loc[2] + 2000);
  while(var_feed8b5b < 360) {
    if(bullettracepassed(var_53d81d57, v_loc + (0, 0, 96), 0, self.mdl_target)) {
      var_1914c03e = spawnStruct();
      var_1914c03e.origin = (v_loc[0] + (var_1ccc854e[0] * 20000), v_loc[1] + (var_1ccc854e[1] * 20000), v_loc[2] + 8000);
      var_1914c03e.angles = anglestoup(vectortoangles(v_loc - var_1914c03e.origin));
      var_1914c03e.v_loc = v_loc;
      var_1914c03e.var_53d81d57 = var_53d81d57;
      return var_1914c03e;
    }
    var_feed8b5b = var_feed8b5b + 90;
    var_d9f4bdfd = (v_angles[0], v_angles[1] + 90, 0);
    v_angles = var_d9f4bdfd;
    var_1ccc854e = anglesToForward(var_d9f4bdfd);
    var_53d81d57 = (v_loc[0] + (var_1ccc854e[0] * 1000), v_loc[1] + (var_1ccc854e[1] * 1000), v_loc[2] + 2000);
  }
  return undefined;
}

function function_5a9be7d8(var_854898eb) {
  self.mdl_target clientfield::increment(var_854898eb);
  self.mdl_target moveto(self.var_be00572f, 0.05);
  self.var_be00572f = undefined;
}

function function_6c8dfca2(w_weapon) {
  if(!isDefined(w_weapon) || zm_utility::is_hero_weapon(w_weapon)) {
    if(isDefined(self.prev_weapon_before_equipment_change)) {
      w_weapon = self.prev_weapon_before_equipment_change;
    } else {
      if(isDefined(self.weapon_stowed)) {
        w_weapon = self.weapon_stowed;
      } else {
        var_e30cfc3e = self getweaponslistprimaries();
        if(var_e30cfc3e.size > 0) {
          w_weapon = var_e30cfc3e[0];
        } else {
          return;
        }
      }
    }
  }
  self switchtoweapon(w_weapon);
}