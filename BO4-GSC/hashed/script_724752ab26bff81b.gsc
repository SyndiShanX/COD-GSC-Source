/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\script_724752ab26bff81b.gsc
***********************************************/

#include script_3122530a9381e18b;
#include script_34b02db2817b42f;
#include script_5f9141e04e4e94a2;
#include script_74608ad5d25450b1;
#include scripts\core_common\array_shared;
#include scripts\core_common\callbacks_shared;
#include scripts\core_common\flag_shared;
#include scripts\core_common\flagsys_shared;
#include scripts\core_common\scene_shared;
#include scripts\core_common\struct;
#include scripts\zm\zm_hms_util;
#include scripts\zm\zm_white_computer_system;
#include scripts\zm\zm_white_main_quest;
#include scripts\zm\zm_white_util;
#include scripts\zm_common\zm_customgame;
#include scripts\zm_common\zm_sq;
#include scripts\zm_common\zm_sq_modules;
#include scripts\zm_common\zm_ui_inventory;
#include scripts\zm_common\zm_unitrigger;
#include scripts\zm_common\zm_utility;
#include scripts\zm_common\zm_vo;
#include scripts\zm_common\zm_weapons;

#namespace namespace_a01a2431;

preload() {
  zm_sq_modules::function_d8383812(#"sc_ww_screen1", 20000, "sc_ww_screen1", &is_soul_capture, &soul_captured, 1);
  zm_sq_modules::function_d8383812(#"sc_ww_screen2", 20000, "sc_ww_screen2", &is_soul_capture, &soul_captured, 1);
  zm_sq_modules::function_d8383812(#"sc_ww_screen3", 20000, "sc_ww_screen3", &is_soul_capture, &soul_captured, 1);
  zm_sq_modules::function_d8383812(#"sc_ww_screen4", 20000, "sc_ww_screen4", &is_soul_capture, &soul_captured, 1);
}

init() {
  level.var_cb94d41d = struct::get("ww_interact");
  level.var_cb94d41d.a_s_slots = [];
  level.var_cb94d41d.a_s_slots[0] = {
    #n_state: 1, 
    #var_2153c223: level.a_w_ray_guns[4]
  };
  level.var_cb94d41d.a_s_slots[1] = {
    #n_state: 1, 
    #var_2153c223: level.a_w_ray_guns[6]
  };
  level.var_cb94d41d.a_s_slots[2] = {
    #n_state: 1, 
    #var_2153c223: level.a_w_ray_guns[8]
  };
  level.var_cb94d41d.a_s_slots[3] = {
    #n_state: 1, 
    #var_2153c223: level.a_w_ray_guns[10]
  };
  var_c13ed74d = struct::get_array("ww_pickup");
  level.var_c13ed74d = array::sort_by_script_int(var_c13ed74d, 1);
  level thread function_dd535733();
  level.var_87b50e64 = array(getweapon("ray_gun"), getweapon("ray_gun_mk2v"), getweapon("ray_gun_mk2x"), getweapon("ray_gun_mk2y"), getweapon("ray_gun_mk2z"));
  a_s_screens = struct::get_array("ww_quest_tv");
  array::run_all(a_s_screens, &function_101f9dc0);
  level.var_2fc3a917 = array::sort_by_script_int(a_s_screens, 1);
  var_668332c4 = randomint(level.var_2fc3a917.size - 1);

  for(i = 0; i < var_668332c4; i++) {
    s_temp = array::pop_front(level.var_2fc3a917, 0);

    if(!isDefined(level.var_2fc3a917)) {
      level.var_2fc3a917 = [];
    } else if(!isarray(level.var_2fc3a917)) {
      level.var_2fc3a917 = array(level.var_2fc3a917);
    }

    level.var_2fc3a917[level.var_2fc3a917.size] = s_temp;
  }

  zm_sq::register(#"ww_quest_weapon", #"step_1", #"hash_2af54f403e86105d", &function_da84e99e, &function_6d5a79fe);
  level thread function_661dc825();

  if(!zm_utility::is_standard()) {
    n_code = zm_white_computer_system::function_4696e086(1, &function_256cc56e);
    level.var_276bd207 = zm_white_computer_system::function_da24090c(n_code);
  }

  function_63841688();
}

function_dd535733() {
  level.var_d9d721fd = struct::get("ww_printer_compartment", "targetname");
  level.var_d9d721fd scene::play("init");
  level.var_d9d721fd flagsys::wait_till(#"scene_ents_ready");
  level.var_d9d721fd.entity = level.var_d9d721fd.scene_ents[#"prop 1"];

  for(i = 0; i < 4; i++) {
    level.var_d9d721fd.entity hidepart("tag_gun_full_" + i);
  }
}

function_6a2c67c2() {
  while(true) {
    self scene::play("open");

    for(i = 0; i < 4; i++) {
      wait 1;
      self.entity hidepart("tag_gun_" + i);
    }

    wait 1;
    self scene::play("init");

    for(i = 0; i < 4; i++) {
      self.entity showpart("tag_gun_" + i);
    }

    wait 2;
  }
}

function_661dc825() {
  level endon(#"game_ended");
  level flag::wait_till(#"pap_power_ready");

  if(zm_custom::function_901b751c(#"zmwonderweaponisenabled")) {
    zm_sq::start(#"ww_quest_weapon", !zm_utility::is_standard());
  }
}

function_da84e99e(var_5ea5c94d) {
  level.var_f36ca012 = 0;
  level.var_2fc3a917[level.var_f36ca012] function_46006d68();
  level thread function_cbeb9a33();

  if(!var_5ea5c94d) {
    level flag::init(#"ww_code_acquired");
    level flag::wait_till(#"ww_code_acquired");

    if(!zm_utility::is_ee_enabled()) {
      zm_white_computer_system::init_keypad();
    }
  }
}

function_101f9dc0() {
  a_e_parts = getEntArray(self.target, "targetname");

  foreach(e_part in a_e_parts) {
    if(isDefined(e_part.script_int)) {
      self.var_21f452ad = e_part;
      continue;
    }

    self.var_c5e93537 = e_part;
  }

  if(isDefined(self.var_21f452ad)) {
    self.var_21f452ad function_6392f719();
  }

  self.var_53d39cb3 = 0;
  self.var_7944be4a = 0;
  self.var_b9989e12 = hash(self.script_noteworthy);
}

function_dc4f41f7() {
  if(isDefined(self.var_c5e93537)) {
    self.var_c5e93537 delete();
  }

  if(isDefined(self.var_21f452ad)) {
    self.var_21f452ad stopsounds();
    self.var_21f452ad function_6392f719();
  }

  self.var_53d39cb3 = 0;

  if(isDefined(self.s_unitrigger)) {
    zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
  }

  zm_sq_modules::function_2a94055d(self.var_b9989e12);
}

function_46006d68() {
  switch (self.var_53d39cb3) {
    case 0:
      self.var_21f452ad function_bb7d7e2d();
      self.var_21f452ad playLoopSound(#"hash_7b7b8618ef1150ac");
      self zm_unitrigger::create("", 96);
      self thread function_582a4879();
      self.var_53d39cb3 = 1;
      break;
    case 1:
      self.var_21f452ad function_8ebc8dcf(100);
      self thread function_41464ab6();
      self.var_21f452ad playLoopSound(#"hash_66d823f29bf8f0ce");
      self.var_53d39cb3 = 2;
      zm_sq_modules::function_3f808d3d(self.var_b9989e12);
      break;
    case 2:
      self.var_21f452ad function_8ebc8dcf(level.var_276bd207[level.var_f36ca012]);
      self.var_21f452ad playLoopSound(#"hash_6edda7357adf8cd9");
      self.var_53d39cb3 = 3;
      self thread function_6e0328a9();
      break;
  }
}

function_41464ab6() {
  self endon(#"death");
  n_wait = float(soundgetplaybacktime(#"hash_60b460e7880bd1c0")) / 1000;
  self.var_21f452ad playSound(#"hash_60b460e7880bd1c0");
  wait n_wait;
  self.var_21f452ad.name = level.var_8200dc81.name;
  self.var_21f452ad thread zm_hms_util::function_6a0d675d(#"hash_661a3ece5f5b3f0b", 0, 0);
}

function_6e0328a9() {
  level endon(#"end_game");
  self.var_21f452ad.name = level.var_8200dc81.name;
  self.var_21f452ad zm_vo::vo_stop();
  self.var_21f452ad zm_hms_util::function_6a0d675d(#"hash_6827b81ddbd26677", 0, 0);

  if(level flag::get(#"ww_code_acquired")) {
    wait 1;
    self.var_21f452ad zm_hms_util::function_6a0d675d(#"hash_ce23c02d2c80867", 0, 0);
  }
}

function_582a4879() {
  self endon(#"death");
  self waittill(#"trigger_activated");
  self function_56d2143b();
}

function_56d2143b() {
  self function_46006d68();
  zm_unitrigger::unregister_unitrigger(self.s_unitrigger);
  self.s_unitrigger = undefined;
}

is_soul_capture(var_88206a50, ent) {
  if(isDefined(ent)) {
    b_killed_by_player = isDefined(ent.attacker) && isplayer(ent.attacker) || isDefined(ent.damageinflictor) && isplayer(ent.damageinflictor);
    var_e93788f1 = var_88206a50.var_c5e93537;
    return (b_killed_by_player && ent istouching(var_e93788f1));
  }

  return false;
}

soul_captured(var_f0e6c7a2, ent) {
  n_souls_required = 6;

  if(getplayers().size > 2) {
    n_souls_required = 10;
  } else if(getplayers().size > 1) {
    n_souls_required = 8;
  }

  var_f0e6c7a2.var_7944be4a++;

  if(level flag::get(#"soul_fill")) {
    var_f0e6c7a2.var_7944be4a = n_souls_required;
  }

    if(var_f0e6c7a2.var_7944be4a >= n_souls_required) {
      var_f0e6c7a2 function_a66f0de2();
    }
}

function_a66f0de2() {
  zm_sq_modules::function_2a94055d(self.var_b9989e12);
  v_forward = anglesToForward(self.angles);
  v_up = anglestoup(self.angles);
  self function_46006d68();
  level.var_f36ca012++;

  if(level.var_f36ca012 < level.var_2fc3a917.size) {
    level.var_2fc3a917[level.var_f36ca012] function_46006d68();
    return;
  }

  level flag::set(#"ww_code_acquired");
}

function_6d5a79fe(var_5ea5c94d, ended_early) {
  if(var_5ea5c94d || ended_early) {
    foreach(s_screen in level.var_2fc3a917) {
      if(s_screen.var_53d39cb3 == 1) {
        s_screen function_56d2143b();
      }

      if(s_screen.var_53d39cb3 == 2) {
        s_screen function_a66f0de2();
      }
    }

    iprintlnbold("<dev string:x38>" + level.var_276bd207[0] + level.var_276bd207[1] + level.var_276bd207[2] + level.var_276bd207[3]);

  }
}

function_cbeb9a33() {
  if(zm_utility::is_ee_enabled()) {
    level flag::wait_till("insanity_mode_triggered");
    a_s_screens = struct::get_array("ww_quest_tv");
    array::run_all(a_s_screens, &function_dc4f41f7);
  }
}

function_256cc56e() {
  if(isDefined(level.var_f13364b4.var_12633dc5) && zm_utility::is_classic()) {
    level.var_f13364b4.var_12633dc5 thread zm_white_util::function_491673da(#"hash_ef67a616ce1cb99");
  }

  if(!zm_utility::is_ee_enabled()) {
    level zm_white_computer_system::function_31890499();
    zm_white_computer_system::function_52838f02("both", 0);

    if(isDefined(level.var_f13364b4.s_keypad) && isDefined(level.var_f13364b4.s_keypad.s_unitrigger)) {
      zm_unitrigger::unregister_unitrigger(level.var_f13364b4.s_keypad.s_unitrigger);
    }
  }

  wait 1;
  level.var_d9d721fd scene::play("open");
  playsoundatposition(#"hash_7afd5b8ae2a40c53", level.var_cb94d41d.origin);
  s_unitrigger = level.var_cb94d41d zm_unitrigger::create(&function_c3076788, 64);
  zm_unitrigger::unitrigger_force_per_player_triggers(s_unitrigger);
  zm_unitrigger::function_c9e3607c(s_unitrigger, "HINT_WEAPON", level.a_w_ray_guns[2]);
  level.var_cb94d41d thread function_7d123028();
  namespace_ca03bbb4::start_quest();
  namespace_3b2b9e06::start_quest();
  namespace_825eac6b::start_quest();
  namespace_90b0490e::start_quest();
}

function_c3076788(e_player) {
  if(level.var_7629d4e2 === 1) {
    return false;
  }

  e_player.var_bec34462 = e_player function_117157d7();

  if(isDefined(e_player.var_bec34462.n_slot)) {
    w_give = level.var_cb94d41d.a_s_slots[e_player.var_bec34462.n_slot].var_2153c223;
  }

  w_take = e_player zm_white_util::function_c7274071();

  switch (e_player.var_bec34462.n_id) {
    case 0:
      str_hint = #"hash_3f0cb3a3a888e340";
      var_306b9dd6 = #"hash_351a359dee18e66c";
      break;
    case 1:
      str_hint = #"hash_45e0e71f5c4ad089";
      var_306b9dd6 = #"hash_2c1852a26bee7917";
      break;
    case 2:
      str_hint = #"hash_314a7588b45256eb";
      var_306b9dd6 = #"hash_6831cfd35264e1";
      var_339390e4 = w_give.displayname;
      break;
    case 3:
      str_hint = #"hash_53f9aac41c4fa384";
      var_306b9dd6 = #"hash_3a6067fdb28789e8";
      var_339390e4 = w_take.displayname;
      break;
    case 4:
      str_hint = #"hash_7aea9fef103ab16";
      var_306b9dd6 = #"hash_3e916dea9d22f1b2";
      var_339390e4 = w_take.displayname;
      var_45d63569 = w_give.displayname;
      break;
    case 5:
      str_hint = #"hash_1d175f6387d44262";
      var_306b9dd6 = #"hash_6686ce3bf4639b76";
      var_339390e4 = w_give.displayname;
      break;
    case 6:
      str_hint = #"hash_68ae5772aec47222";
      var_306b9dd6 = #"hash_58bd37425bd02736";
      var_339390e4 = w_take.displayname;
      break;
    case 7:
      str_hint = #"hash_172253c9314825fc";
      var_306b9dd6 = #"hash_71016e43b6fe0570";
      var_339390e4 = w_give.displayname;
      var_45d63569 = w_take.displayname;
      break;
    case 8:
      str_hint = #"hash_28c1446ca1a2440c";
      var_306b9dd6 = #"hash_2df82d83303d3d40";
      var_339390e4 = w_give.displayname;
      var_45d63569 = w_take.displayname;
      break;
    case 9:
      return false;
  }

  if(e_player.currentweapon.isheroweapon === 1 || e_player.currentweapon.name === #"zhield_riot_dw") {
    self sethintstring("");
  } else if(isDefined(var_45d63569)) {
    self sethintstring(zm_utility::function_d6046228(str_hint, var_306b9dd6), var_339390e4, var_45d63569);
  } else if(isDefined(var_339390e4)) {
    self sethintstring(zm_utility::function_d6046228(str_hint, var_306b9dd6), var_339390e4);
  } else {
    self sethintstring(zm_utility::function_d6046228(str_hint, var_306b9dd6));
  }

  return true;
}

function_7d123028() {
  self endon(#"death");

  while(true) {
    s_notify = self waittill(#"trigger_activated");
    e_player = s_notify.e_who;

    if(isplayer(e_player) && e_player.currentweapon.isheroweapon === 0 && e_player.currentweapon.name !== #"zhield_riot_dw") {
      function_75e61716(e_player);
    }
  }
}

function_75e61716(e_player) {
  switch (e_player.var_bec34462.n_id) {
    case 0:
      e_player function_3f52f82();
      break;
    case 1:
      e_player function_a9051a62();
      break;
    case 2:
      e_player function_508273b4();
      break;
    case 3:
      e_player function_bdc61146();
      break;
    case 4:
      e_player function_bdc61146();
      e_player function_508273b4();
      break;
    case 5:
      e_player function_a9051a62();
      e_player function_508273b4();
      break;
    case 6:
      e_player function_bdc61146();
      e_player function_3f52f82();
      break;
    case 7:
      e_player take_ray_gun();
      e_player function_508273b4();
      break;
    case 8:
      e_player take_ray_gun();
      e_player function_a9051a62();
      e_player function_508273b4();
      break;
  }
}

function_3f52f82() {
  self.var_382b64f2 = 1;
  zm_ui_inventory::function_7df6bb60("zm_white_ww_husk_part", 1, self);
  self playSound("evt_rgun_frame_pickup");
  n_slot = self.var_bec34462.n_slot;

  if(isDefined(n_slot) && level.var_cb94d41d.a_s_slots[n_slot].n_state == 1) {
    level.var_d9d721fd.entity hidepart("tag_gun_" + n_slot);
    level.var_cb94d41d.a_s_slots[n_slot].n_state = 0;
  } else {
    function_47181de();
  }

  if(!isDefined(level.var_cb94d41d.var_bfee6dc4)) {
    level.var_cb94d41d.var_bfee6dc4 = [];
  }

  if(!array::contains(level.var_cb94d41d.var_bfee6dc4, self)) {
    if(!array::contains(level.var_cb94d41d.var_5300c2f5, self)) {
      if(!zm_white_main_quest::function_6cebbce1() && zm_utility::is_classic()) {
        zm_vo::vo_say("vox_ww_mod_hint_rush_0", 0, 1, 0, 0, 1);
      }
    }

    if(!isDefined(level.var_cb94d41d.var_bfee6dc4)) {
      level.var_cb94d41d.var_bfee6dc4 = [];
    } else if(!isarray(level.var_cb94d41d.var_bfee6dc4)) {
      level.var_cb94d41d.var_bfee6dc4 = array(level.var_cb94d41d.var_bfee6dc4);
    }

    if(!isinarray(level.var_cb94d41d.var_bfee6dc4, self)) {
      level.var_cb94d41d.var_bfee6dc4[level.var_cb94d41d.var_bfee6dc4.size] = self;
    }
  }
}

function_605e5c25(e_player) {
  if(!isDefined(level.var_cb94d41d.var_5300c2f5)) {
    level.var_cb94d41d.var_5300c2f5 = [];
  }

  if(!array::contains(level.var_cb94d41d.var_5300c2f5, e_player)) {
    if(!isDefined(level.var_cb94d41d.var_5300c2f5)) {
      level.var_cb94d41d.var_5300c2f5 = [];
    } else if(!isarray(level.var_cb94d41d.var_5300c2f5)) {
      level.var_cb94d41d.var_5300c2f5 = array(level.var_cb94d41d.var_5300c2f5);
    }

    if(!isinarray(level.var_cb94d41d.var_5300c2f5, e_player)) {
      level.var_cb94d41d.var_5300c2f5[level.var_cb94d41d.var_5300c2f5.size] = e_player;
    }
  }
}

function_47181de() {
  n_slot = function_5c934f81(1);

  if(isDefined(n_slot)) {
    level.var_cb94d41d.a_s_slots[n_slot].n_state = 0;
    level.var_d9d721fd.entity hidepart("tag_gun_" + n_slot);
  }

  if(!isDefined(n_slot)) {
    iprintln("<dev string:x46>");
  }

}

function_a9051a62() {
  self.var_382b64f2 = undefined;
  zm_ui_inventory::function_7df6bb60("zm_white_ww_husk_part", 0, self);
  level.var_d9d721fd.entity playSound("evt_rgun_frame_putback");
  n_slot = self.var_bec34462.n_slot;

  if(isDefined(n_slot) && level.var_cb94d41d.a_s_slots[n_slot].n_state == 0) {
    level.var_d9d721fd.entity showpart("tag_gun_" + n_slot);
    level.var_cb94d41d.a_s_slots[n_slot].n_state = 1;
    return;
  }

  function_cf5be182();
}

function_508273b4() {
  n_slot = self.var_bec34462.n_slot;
  s_slot = level.var_cb94d41d.a_s_slots[n_slot];
  zm_weapons::weapon_give(s_slot.var_2153c223, 1);

  if(isDefined(s_slot.n_ammo_clip)) {
    self setweaponammoclip(s_slot.var_2153c223, s_slot.n_ammo_clip);
    self setweaponammostock(s_slot.var_2153c223, s_slot.n_ammo_stock);

    if(isDefined(s_slot.var_f702cf26)) {
      self setweaponammoclip(s_slot.var_2153c223.dualwieldweapon, s_slot.var_f702cf26);
    }
  }

  s_slot.n_state = 0;
  level.var_d9d721fd.entity hidepart("tag_gun_full_" + n_slot);
}

function_bdc61146() {
  w_ray_gun = self zm_white_util::function_c7274071();

  if(w_ray_gun.dualwieldweapon != level.weaponnone) {
    var_f702cf26 = self getweaponammoclip(w_ray_gun.dualwieldweapon);
  }

  function_b308d26b(w_ray_gun, self getweaponammoclip(w_ray_gun), self getweaponammostock(w_ray_gun), var_f702cf26);
  zm_weapons::weapon_take(w_ray_gun);
}

function_b308d26b(w_ray_gun, n_ammo_clip, n_ammo_stock, var_f702cf26) {
  n_slot = function_50564ecc(w_ray_gun);
  s_slot = level.var_cb94d41d.a_s_slots[n_slot];
  s_slot.n_ammo_clip = n_ammo_clip;
  s_slot.n_ammo_stock = n_ammo_stock;
  s_slot.var_f702cf26 = var_f702cf26;
  function_83699c26(n_slot);
  s_slot.n_state = 2;
  s_slot.var_2153c223 = w_ray_gun;
  level.var_d9d721fd.entity showpart("tag_gun_full_" + n_slot);
}

function_50564ecc(w_mod) {
  if(isDefined(w_mod)) {
    if(w_mod == level.a_w_ray_guns[4] || w_mod == level.a_w_ray_guns[5]) {
      return 0;
    }

    if(w_mod == level.a_w_ray_guns[6] || w_mod == level.a_w_ray_guns[7]) {
      return 1;
    }

    if(w_mod == level.a_w_ray_guns[8] || w_mod == level.a_w_ray_guns[9]) {
      return 2;
    }

    return 3;
  }
}

function_83699c26(n_slot) {
  s_slot = level.var_cb94d41d.a_s_slots[n_slot];

  if(s_slot.n_state == 1) {
    function_cf5be182();
    s_slot.n_state = 0;
    level.var_d9d721fd.entity hidepart("tag_gun_" + n_slot);
  }
}

function_cf5be182() {
  n_slot = function_5c934f81(0);

  if(isDefined(n_slot)) {
    level.var_cb94d41d.a_s_slots[n_slot].n_state = 1;
    level.var_d9d721fd.entity showpart("tag_gun_" + n_slot);
  }

  if(!isDefined(n_slot)) {
    iprintln("<dev string:x84>");
  }

}

function_5c934f81(n_state) {
  a_s_slots = level.var_cb94d41d.a_s_slots;

  for(i = 0; i < a_s_slots.size; i++) {
    if(a_s_slots[i].n_state == n_state) {
      return i;
    }
  }
}

take_ray_gun() {
  w_ray_gun = self zm_white_util::function_c7274071();
  zm_weapons::weapon_take(w_ray_gun);
}

function_117157d7() {
  var_1c55459 = self.var_382b64f2 === 1;
  var_2c09b688 = self zm_white_util::function_c7274071();
  s_action = spawnStruct();

  foreach(var_d11f69da in level.var_c13ed74d) {
    if(self zm_white_computer_system::function_bcec00bc(var_d11f69da.origin, 15, 0)) {
      n_slot = var_d11f69da.script_int;
      break;
    }
  }

  if(isDefined(n_slot)) {
    s_action.n_slot = n_slot;

    if(level.var_cb94d41d.a_s_slots[n_slot].n_state == 2) {
      if(var_1c55459) {
        if(isDefined(var_2c09b688)) {
          s_action.n_id = 8;
        } else {
          s_action.n_id = 5;
        }
      } else if(isDefined(var_2c09b688)) {
        if(zm_white_util::function_c654e39a(var_2c09b688)) {
          s_action.n_id = 4;
        } else {
          s_action.n_id = 7;
        }
      } else {
        s_action.n_id = 2;
      }
    } else if(level.var_cb94d41d.a_s_slots[n_slot].n_state == 1 && zm_white_util::function_c654e39a(var_2c09b688)) {
      s_action.n_id = 6;
    }
  }

  if(!isDefined(s_action.n_id)) {
    if(var_1c55459) {
      s_action.n_id = 1;
    } else if(zm_white_util::function_c654e39a(var_2c09b688)) {
      s_action.n_id = 3;
    } else if(function_8ff10cdc()) {
      s_action.n_id = 0;
    } else {
      s_action.n_id = 9;
    }
  }

  return s_action;
}

function_8ff10cdc() {
  foreach(s_slot in level.var_cb94d41d.a_s_slots) {
    if(s_slot.n_state == 1) {
      return true;
    }
  }

  return false;
}

private function_63841688() {
  callback::on_disconnect(&on_disconnect);
  level thread pap_timeout_watcher();
  callback::function_33f0ddd3(&function_33f0ddd3);
}

private on_disconnect() {
  if(self.var_382b64f2 === 1) {
    function_cf5be182();

    iprintln("<dev string:xc2>");

      return;
  }

  w_ray_gun = self zm_white_util::function_c7274071();

  if(zm_white_util::function_c654e39a(w_ray_gun)) {
    function_537cf9cc(w_ray_gun, self getweaponammoclip(w_ray_gun), self getweaponammostock(w_ray_gun));
  }
}

private pap_timeout_watcher() {
  level endon(#"end_game");

  while(true) {
    s_notify = level waittill(#"pap_timeout");
    w_upg = s_notify.var_5e879929.unitrigger_stub.upgrade_weapon;

    if(zm_white_util::function_c654e39a(w_upg)) {
      function_537cf9cc(w_upg);
    }
  }
}

private function_33f0ddd3(s_event) {
  if(s_event.event === "take_weapon" && zm_white_util::function_c654e39a(s_event.weapon)) {
    b_rescue = 0;
    w_ray_gun = s_event.weapon;

    if(level flag::get("round_reset") || level flag::get(#"trial_failed")) {
      b_rescue = !isinarray(self.var_c27f1e90, #"specialty_additionalprimaryweapon") && self.var_2a62e678 === w_ray_gun;
    } else {
      e_pap = getent("zm_pack_a_punch", "targetname");
      var_e75ac4c0 = e_pap.unitrigger_stub.current_weapon === w_ray_gun;
      n_slot = function_50564ecc(w_ray_gun);
      var_87103d2d = level.var_cb94d41d.a_s_slots[n_slot].n_state == 2;

      if(!var_e75ac4c0 && !var_87103d2d && !isDefined(self.var_679c4d4e)) {
        b_rescue = 1;
      }
    }

    if(b_rescue) {
      if(w_ray_gun.dualwieldweapon != level.weaponnone) {
        var_f702cf26 = self getweaponammoclip(w_ray_gun.dualwieldweapon);
      }

      function_537cf9cc(w_ray_gun, self getweaponammoclip(w_ray_gun), self getweaponammostock(w_ray_gun), var_f702cf26);
    }
  }
}

private function_537cf9cc(w_ray_gun, n_ammo_clip, n_ammo_stock, var_f702cf26) {
  function_b308d26b(w_ray_gun, n_ammo_clip, n_ammo_stock, var_f702cf26);

  iprintln(getweaponname(w_ray_gun) + "<dev string:xd7>");

}

function_6392f719() {
  self showpart("tag_screen_off");
  self hidepart("tag_screen_static");
  self hidepart("tag_screen_on");
  self hidepart("tag_screen_overlay_0");
  self hidepart("tag_screen_overlay_1");
  self hidepart("tag_screen_overlay_2");
  self hidepart("tag_screen_overlay_3");
  self hidepart("tag_screen_overlay_4");
  self hidepart("tag_screen_overlay_5");
  self hidepart("tag_screen_overlay_6");
  self hidepart("tag_screen_overlay_7");
  self hidepart("tag_screen_overlay_8");
  self hidepart("tag_screen_overlay_9");
  self hidepart("tag_screen_overlay_gun");
}

function_bb7d7e2d() {
  self hidepart("tag_screen_off");
  self showpart("tag_screen_static");
}

function_8ebc8dcf(n_value) {
  self function_4f2e2bb();
  self showpart("tag_screen_on");

  if(n_value >= 0 && n_value <= 9) {
    var_e5f51c1 = "tag_screen_overlay_" + n_value;
  } else {
    var_e5f51c1 = "tag_screen_overlay_gun";
  }

  self showpart(var_e5f51c1);
}

function_4f2e2bb() {
  self hidepart("tag_screen_static");
  self hidepart("tag_screen_off");
  self hidepart("tag_screen_on");
  self hidepart("tag_screen_overlay_0");
  self hidepart("tag_screen_overlay_1");
  self hidepart("tag_screen_overlay_2");
  self hidepart("tag_screen_overlay_3");
  self hidepart("tag_screen_overlay_4");
  self hidepart("tag_screen_overlay_5");
  self hidepart("tag_screen_overlay_6");
  self hidepart("tag_screen_overlay_7");
  self hidepart("tag_screen_overlay_8");
  self hidepart("tag_screen_overlay_9");
  self hidepart("tag_screen_overlay_gun");
}