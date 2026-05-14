/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: zm\zm_orange_water.gsc
***********************************************/

#include scripts\abilities\ability_util;
#include scripts\core_common\ai\zombie_utility;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\laststand_shared;
#include scripts\core_common\math_shared;
#include scripts\core_common\player\player_shared;
#include scripts\core_common\struct;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\zm\zm_orange_ee_freeze_mode;
#include scripts\zm\zm_orange_trials;
#include scripts\zm_common\zm_audio;
#include scripts\zm_common\zm_bgb;
#include scripts\zm_common\zm_bgb_pack;
#include scripts\zm_common\zm_equipment;
#include scripts\zm_common\zm_loadout;
#include scripts\zm_common\zm_player;
#include scripts\zm_common\zm_trial;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_zonemgr;
#namespace zm_orange_water;

init() {
  init_clientfields();
  zm_player::register_slowdown(#"hash_2f87c75c463e66c3", 0.7, 0.1);
}

init_clientfields() {
  clientfield::register("allplayers", "" + #"water_player_freeze_fx", 24000, 1, "int");
  clientfield::register("toplayer", "" + #"water_player_freeze_sfx", 24000, 1, "int");
  clientfield::register("toplayer", "" + #"hash_13f1aaee7ebf9986", 24000, 2, "int");
  clientfield::register("toplayer", "" + #"hash_603fc9d210bdbc4d", 24000, 1, "int");
  clientfield::register("toplayer", "" + #"hash_67340426cd141891", 24000, 2, "int");
}

main() {
  level.a_e_water = getEntArray("e_water", "targetname");
  level.a_s_float_path = struct::get_array("s_float_path", "script_noteworthy");
  level flag::init(#"hash_69a9d00e65ee6c40");
  level flag::init(#"hash_17b882aed4431728");
  level.var_b0a3611a = 0.5;
  level thread zombie_coast_adjust_percent();
  level.zombie_init_done = &zombie_check_riser;
  callback::on_spawned(&function_99ca73e1);
}

zombie_coast_adjust_percent() {
  level endon(#"end_game");

  while(true) {
    level waittill(#"between_round_over");
    level waittill(#"between_round_over");

    if(level.var_b0a3611a > 0.1) {
      level.var_b0a3611a -= 0.05;

      if(level.var_b0a3611a <= 0.1) {
        level.var_b0a3611a = 0.1;
        break;
      }
    }
  }
}

zombie_check_riser() {
  self endon(#"death");

  if(self.in_the_ground === 1) {
    self waittill(#"risen");
  }

  if(!level flag::get(#"hash_17b882aed4431728")) {
    self thread zombie_water_out();
  }
}

zombie_water_out() {
  self endon(#"death");

  while(true) {
    foreach(e_water in level.a_e_water) {
      if(self istouching(e_water)) {
        self zombie_entered_water();
        return;
      }
    }

    waitframe(1);
  }
}

zombie_entered_water() {
  self endon(#"death");
  self.b_in_water = 1;
  self zombie_water_move_slow();
  self thread zombie_water_in();
}

zombie_water_move_slow() {
  switch (self.zombie_move_speed) {
    case #"walk":
      break;
    case #"run":
      self thread zombie_utility::set_zombie_run_cycle("walk");
      break;
    case #"sprint":
      self thread zombie_utility::set_zombie_run_cycle("run");
      break;
    case #"super_sprint":
      self thread zombie_utility::set_zombie_run_cycle("sprint");
      break;
  }
}

zombie_water_in() {
  self endon(#"death");

  while(true) {
    self.b_in_water = 0;

    foreach(e_water in level.a_e_water) {
      if(self istouching(e_water)) {
        self.b_in_water = 1;

        if(!isDefined(self.var_3f789444)) {
          self thread function_4c6f90cd();
        }
      }

      if(!self.b_in_water) {
        self zombie_exited_water();
        return;
      }
    }

    waitframe(1);
  }
}

function_4c6f90cd() {
  self endon(#"death");

  if(isDefined(self.ignore_water_damage) && self.ignore_water_damage) {
    return;
  }

  self.var_3f789444 = 1;
  wait 2;

  if(self.var_3f789444 === 1) {
    var_baafc291 = level.zombie_health * level.var_b0a3611a;

    if(self.health <= var_baafc291) {
      self.water_damage = 1;
      self dodamage(var_baafc291, self.origin);
    }

    self.var_3f789444 = undefined;
  }
}

zombie_exited_water() {
  self endon(#"death");
  self.b_in_water = 0;
  self.var_3f789444 = undefined;
  self zombie_water_move_normal();
  self thread zombie_water_out();
}

zombie_water_move_normal() {
  switch (self.zombie_move_speed) {
    case #"walk":
      self thread zombie_utility::set_zombie_run_cycle("run");
      break;
    case #"run":
      self thread zombie_utility::set_zombie_run_cycle("sprint");
      break;
    case #"sprint":
      self thread zombie_utility::set_zombie_run_cycle("super_sprint");
      break;
    case #"super_sprint":
      break;
  }
}

function_99ca73e1() {
  if(getdvarint(#"hash_60464f7ad910bd1a", 0)) {
    return;
  }

  self thread function_ea0c7ed8();
}

function_ea0c7ed8() {
  self notify("4c2bcc084cb1ca9b");
  self endon("4c2bcc084cb1ca9b");
  level endon(#"end_game", #"freeze_mode");
  self endon(#"death", #"player_frozen");

  while(true) {
    foreach(e_water in level.a_e_water) {
      if(self istouching(e_water) && !self laststand::player_is_in_laststand()) {
        self player_entered_water();
        return;
      }
    }

    wait 0.1;
  }
}

player_entered_water() {
  level endon(#"end_game");
  self endon(#"death", #"player_frozen");
  self.b_in_water = 1;
  self notify(#"player_entered_water");

  if(!level flag::get(#"hash_69a9d00e65ee6c40")) {
    self thread function_26a271e6();
    self thread function_6577cacc();

    if(self.var_2e6aa97d === 1) {
      self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 2);

      if(isDefined(self.var_cdce7ec) && self.var_cdce7ec) {
        self allowsprint(0);
      }
    } else {
      self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 1);
      self allowsprint(0);

      if(self issliding()) {
        self setstance("crouch");
      }

      self allowslide(0);
    }
  } else {
    self thread function_121f8a53();
  }

  self thread function_4ab00cab();
}

function_26a271e6() {
  self endon(#"death", #"player_exited_water");
  wait 5;
  self thread zm_audio::create_and_play_dialog(#"freeze", #"exert");
}

function_4ab00cab() {
  level endon(#"end_game");
  self endon(#"death", #"player_frozen");

  while(true) {
    wait 0.1;

    foreach(e_water in level.a_e_water) {
      if(!self istouching(e_water) || self laststand::player_is_in_laststand()) {
        self thread player_exited_water();
        return;
      }
    }
  }
}

player_exited_water() {
  level endon(#"end_game");
  self endon(#"death", #"player_frozen");
  self.b_in_water = 0;
  self notify(#"player_exited_water");

  if(!level flag::get(#"hell_on_earth") && !level flag::get(#"trials_hell_on_earth")) {
    self allowsprint(1);
    self allowslide(1);
    self thread function_d2dd1f2b();
    self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
  }

  self thread function_ea0c7ed8();
}

function_6577cacc() {
  level endon(#"end_game");
  self endon(#"death", #"player_exited_water");

  if(!isDefined(self.var_36a93d1)) {
    self.var_36a93d1 = 0;
  }

  while(true) {
    wait 1;
    self.var_36a93d1++;

    if(self.var_2e6aa97d === 1) {
      var_24e0e73d = 30;
    } else {
      var_24e0e73d = 15;
    }

    if(self.var_36a93d1 >= int(var_24e0e73d * 0.5)) {
      self thread zm_audio::create_and_play_dialog(#"freeze", #"start");
    }

    if(self.var_36a93d1 >= var_24e0e73d) {
      waitframe(1);

      if(self zm_zonemgr::get_player_zone() === "underwater_tunnel") {
        self thread function_34e1762b();
      } else {
        self thread water_player_freeze();
        self thread zm_audio::create_and_play_dialog(#"freeze", #"frozen");
      }

      self.var_36a93d1 = 0;
      return;
    }
  }
}

function_121f8a53() {
  level endon(#"end_game");
  self endon(#"death", #"player_exited_water");

  while(true) {
    self dodamage(20, self.origin);
    wait 1;
  }
}

function_d2dd1f2b() {
  level endon(#"end_game");
  self endon(#"death", #"player_entered_water");

  if(!isDefined(self.var_36a93d1) || self.var_36a93d1 == 0) {
    return;
  }

  while(true) {
    wait 1;
    self.var_36a93d1--;

    if(self.var_36a93d1 <= 0) {
      self.var_36a93d1 = 0;
      return;
    }
  }
}

water_player_freeze() {
  self endoncallback(&function_c64292f, #"death");
  self.var_7dc2d507 = 1;
  self notify(#"player_frozen");
  self zm_orange_ee_freeze_mode::function_3931c78();
  self function_bad6907c();
  self clientfield::set("" + #"water_player_freeze_fx", 1);
  self clientfield::set_to_player("" + #"water_player_freeze_sfx", 1);
  t_ice = spawn("trigger_damage", self.origin, 0, 15, 72);
  t_ice enablelinkto();
  t_ice linkto(self);
  self.t_ice = t_ice;
  self thread function_872ec0b2(t_ice);

  if(isbot(self)) {
    self thread function_8eb7b0f7();
  } else {
    self thread function_6cadbaff();
  }

  if(self.var_d844486 !== 1) {
    self thread zm_equipment::show_hint_text(#"hash_4b6950ec49c7e04c", 3);
    self.var_d844486 = 1;
  }

  self waittill(#"water_player_freeze_broken");
  self playSound(#"hash_2f8c9575cb36a298");
  self.var_7dc2d507 = 0;
  self function_46c3bbf7();
  self clientfield::set("" + #"water_player_freeze_fx", 0);
  self clientfield::set_to_player("" + #"water_player_freeze_sfx", 0);
  self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
  waitframe(2);
  self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);

  if(isDefined(t_ice)) {
    t_ice delete();
    self.t_ice = undefined;
  }

  self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
  waitframe(2);
  self thread function_ea0c7ed8();
}

function_c64292f(str_notify) {
  if(isDefined(self) && isDefined(self.t_ice)) {
    self.t_ice delete();
    self.t_ice = undefined;
  }

  if(isDefined(self) && isDefined(self.e_tag)) {
    self.e_tag delete();
  }
}

function_bad6907c() {
  self endoncallback(&function_26234f4c, #"disconnect");

  if(self isusingoffhand()) {
    self forceoffhandend();
  }

  self disableoffhandspecial();
  self disableoffhandweapons();
  self allowmelee(0);
  w_current = self getcurrentweapon();

  if(zm_loadout::is_placeable_mine(w_current) || zm_equipment::is_equipment(w_current) || ability_util::is_weapon_gadget(w_current) || ability_util::is_hero_weapon(w_current)) {
    a_w_primary_weapons = self getweaponslistprimaries();

    if(isDefined(a_w_primary_weapons) && a_w_primary_weapons.size > 0) {
      self switchtoweapon(a_w_primary_weapons[0], 1);

      for(var_5a7831c4 = 0; !var_5a7831c4; var_5a7831c4 = 1) {
        waitframe(1);
        w_current = self getcurrentweapon();

        if(w_current == a_w_primary_weapons[0]) {}
      }
    }
  }

  foreach(weapon in self getweaponslist(1)) {
    self lockweapon(weapon, 1, 0);

    if(weapon.dualwieldweapon != level.weaponnone) {
      self lockweapon(weapon.dualwieldweapon, 1, 0);
    }
  }

  self.e_tag = util::spawn_model("tag_origin", self.origin, self.angles);
  self playerlinktoabsolute(self.e_tag, "tag_origin");
  self allowjump(0);
  self allowsprint(0);
  self player::allow_stance_change(0);
  self allowads(0);
  self thread function_67981637();
  self bgb::suspend_weapon_cycling();
  self disableweaponcycling();
  self bgb_pack::function_ac9cb612(1);
  self.bgb_disabled = 1;

  if(isDefined(level.var_526d919)) {
    w_current = self getcurrentweapon();

    if(isDefined(level.var_526d919[w_current.name])) {
      self allowmelee(1);
    } else {
      self allowmelee(0);
    }

    return;
  }

  self allowmelee(1);
}

function_67981637() {
  self endon(#"death");

  while(self.var_7dc2d507) {
    self shellshock(#"slowview", 1.1);
    wait 1;
  }
}

function_46c3bbf7() {
  self endoncallback(&function_26234f4c, #"disconnect");

  if(zm_utility::is_trials()) {
    self zm_orange_trials::function_b4bd25ef();
  } else {
    self enableoffhandspecial();
    self enableoffhandweapons();

    foreach(weapon in self getweaponslist(1)) {
      self unlockweapon(weapon);

      if(weapon.dualwieldweapon != level.weaponnone) {
        self unlockweapon(weapon.dualwieldweapon);
      }
    }
  }

  self bgb_pack::function_ac9cb612(0);
  self.bgb_disabled = 0;
  self bgb::resume_weapon_cycling();
  self enableweaponcycling();
  self stopshellshock();
  self allowjump(1);
  self allowsprint(1);
  self player::allow_stance_change(1);
  self allowads(1);
  self unlink();

  if(isDefined(self.e_tag)) {
    self.e_tag delete();
  }
}

function_26234f4c(str_notify) {
  if(isDefined(self) && isDefined(self.e_tag)) {
    self.e_tag delete();
  }
}

function_872ec0b2(t_ice) {
  self endon(#"death", #"water_player_freeze_broken");

  while(true) {
    s_notify = t_ice waittill(#"damage");

    if(s_notify.attacker === self) {
      continue;
    }

    self notify(#"water_player_freeze_broken");
  }
}

function_6cadbaff() {
  self endon(#"death", #"water_player_freeze_broken");

  if(level flag::get(#"break_freeze_faster")) {
    self waittill(#"weapon_melee", #"weapon_melee_power");
    self playrumbleonentity("damage_heavy");
    self clientfield::set_to_player("" + #"hash_67340426cd141891", 0);
    self notify(#"water_player_freeze_broken");
    return;
  }

  self waittill(#"weapon_melee", #"weapon_melee_power");
  self playrumbleonentity("damage_light");
  self clientfield::set_to_player("" + #"hash_67340426cd141891", 2);
  self playSound(#"hash_1a3cd046cb0b437f");
  self waittill(#"weapon_melee", #"weapon_melee_power");
  self playrumbleonentity("damage_light");
  self clientfield::set_to_player("" + #"hash_67340426cd141891", 1);
  self playSound(#"hash_1a3cd146cb0b4532");
  self waittill(#"weapon_melee", #"weapon_melee_power");
  self playrumbleonentity("damage_heavy");
  self clientfield::set_to_player("" + #"hash_67340426cd141891", 0);
  self notify(#"water_player_freeze_broken");
}

function_8eb7b0f7() {
  self endon(#"death", #"water_player_freeze_broken");

  if(level flag::get(#"break_freeze_faster")) {
    wait 3;
    self clientfield::set_to_player("" + #"hash_67340426cd141891", 0);
    self notify(#"water_player_freeze_broken");
    return;
  }

  wait 5;
  self clientfield::set_to_player("" + #"hash_67340426cd141891", 0);
  self notify(#"water_player_freeze_broken");
}

function_142c254b() {
  self.var_1ed2984a = 1;
  self dodamage(50, self.origin, undefined, undefined, undefined, "MOD_BURNED");
  self thread function_e8485ac0();
}

function_e8485ac0() {
  self endon(#"death");
  n_counter = 0;

  while(true) {
    wait 0.1;
    n_counter += 0.1;

    if(n_counter >= 1) {
      self.var_1ed2984a = 0;
      return;
    }
  }
}

function_34e1762b() {
  self endoncallback(&function_f0339fd, #"death");
  self.var_7dc2d507 = 1;
  self notify(#"player_frozen");
  self function_e22d95bc();
  self clientfield::set("" + #"water_player_freeze_fx", 1);
  self clientfield::set_to_player("" + #"water_player_freeze_sfx", 1);
  self function_615d3be0();
  self function_d793c8ff();
  self function_bad6907c();
  t_ice = spawn("trigger_damage", self.origin, 0, 15, 72);
  t_ice enablelinkto();
  t_ice linkto(self);
  self.t_ice = t_ice;
  self thread function_872ec0b2(t_ice);
  self thread function_6cadbaff();
  self waittill(#"water_player_freeze_broken");
  self.var_7dc2d507 = 0;
  self function_46c3bbf7();
  self clientfield::set("" + #"water_player_freeze_fx", 0);
  self clientfield::set_to_player("" + #"water_player_freeze_sfx", 0);
  self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 1);
  waitframe(2);
  self clientfield::set_to_player("" + #"hash_603fc9d210bdbc4d", 0);

  if(isDefined(t_ice)) {
    t_ice delete();
    self.t_ice = undefined;
  }

  self clientfield::set_to_player("" + #"hash_13f1aaee7ebf9986", 0);
  waitframe(2);
  self thread function_ea0c7ed8();
}

function_f0339fd(str_notify) {
  if(isDefined(self) && isDefined(self.t_ice)) {
    self.t_ice delete();
    self.t_ice = undefined;
  }

  if(isDefined(self) && isDefined(self.e_tag)) {
    self.e_tag delete();
  }
}

function_e22d95bc() {
  self endoncallback(&function_26234f4c, #"disconnect");
  self val::set(#"fasttravel", "freezecontrols", 1);
  self val::set(#"fasttravel", "ignoreme", 1);

  if(!self laststand::player_is_in_laststand()) {
    str_stance = self getstance();

    switch (str_stance) {
      case #"crouch":
        self setstance("stand");
        wait 0.2;
        break;
      case #"prone":
        self setstance("stand");
        wait 1;
        break;
    }
  }

  self.e_tag = util::spawn_model("tag_origin", self.origin, self.angles);
  self playerlinktoabsolute(self.e_tag, "tag_origin");
}

function_d793c8ff() {
  self endoncallback(&function_d92c3acf, #"disconnect");
  self val::set(#"fasttravel", "freezecontrols", 0);
  self val::set(#"fasttravel", "takedamage", 1);
  self val::set(#"fasttravel", "ignoreme", 0);
  self unlink();

  if(isDefined(self.e_tag)) {
    self.e_tag delete();
  }
}

function_d92c3acf(str_notify) {
  if(isDefined(self) && isDefined(self.e_tag)) {
    self.e_tag delete();
  }
}

function_615d3be0() {
  level endon(#"end_game");
  a_s_float_path = array::get_all_closest(self.origin, level.a_s_float_path);
  var_98698d94 = a_s_float_path[0];

  while(true) {
    var_7c1bf084 = self function_e2d41c8d(var_98698d94);
    self.e_tag moveto(var_98698d94.origin, var_7c1bf084);
    self.e_tag waittill(#"movedone");

    if(isDefined(var_98698d94.target)) {
      var_98698d94 = struct::get(var_98698d94.target, "targetname");
      continue;
    }

    return;
  }
}

function_e2d41c8d(s_start) {
  var_96e16c65 = distance(self.origin, s_start.origin);
  var_7ddd94c0 = var_96e16c65 / 100;
  return 0.5 * var_7ddd94c0;
}

water_debug_hud_elem_thread(player) {
  player endon(#"death");
  self thread update_hud_elem(player);

  while(true) {
    if(isDefined(player.b_in_water)) {
      self setvalue(player.b_in_water);
      println("<dev string:x38>" + player getentitynumber() + "<dev string:x42>");
    }

    player waittill(#"update_frost_state");
  }
}

update_hud_elem(player) {
  player endon(#"death");

  while(true) {
    wait 0.1;
    player notify(#"update_frost_state");
  }
}