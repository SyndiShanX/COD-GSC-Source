/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: zm\zm_tungsten_hind_trap.gsc
***********************************************/

#using script_4ce5d94e8c797350;
#using script_7b1cd3908a825fdd;
#using scripts\core_common\ai\zombie_utility;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\load_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\zm\zm_tungsten_gamemodes;
#using scripts\zm\zm_tungsten_pap_quest;
#using scripts\zm\zm_tungsten_zones;
#using scripts\zm_common\gametypes\globallogic;
#using scripts\zm_common\zm;
#using scripts\zm_common\zm_audio;
#using scripts\zm_common\zm_devgui;
#using scripts\zm_common\zm_equipment;
#using scripts\zm_common\zm_fasttravel;
#using scripts\zm_common\zm_loadout;
#using scripts\zm_common\zm_perks;
#using scripts\zm_common\zm_power;
#using scripts\zm_common\zm_score;
#using scripts\zm_common\zm_spawner;
#using scripts\zm_common\zm_stats;
#using scripts\zm_common\zm_ui_inventory;
#using scripts\zm_common\zm_unitrigger;
#using scripts\zm_common\zm_utility;
#using scripts\zm_common\zm_vo;
#using scripts\zm_common\zm_wallbuy;
#using scripts\zm_common\zm_weapons;
#using scripts\zm_common\zm_zonemgr;
#namespace zm_tungsten_hind_trap;

function init() {
  level thread function_cd7a3de4();

  level.var_e0c7b4b2 = getent("hind_trap_base_01", "targetname");
  level.var_e0c7b4b2.var_df4d758d = getent("hind_trap_base_02", "targetname");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 = getent("hind_trap_base_03", "targetname");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper = getent("hind_trap_chopper", "targetname");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.rotor = getent("hind_trap_rotor", "targetname");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.tail_rotor = getent("hind_trap_tail_rotor", "targetname");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8 = getent("hind_trap_chopper_turret_base", "targetname");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 = getent("hind_trap_chopper_turret_barrel", "targetname");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper linkto(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2);
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.rotor linkto(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper);
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.tail_rotor linkto(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper);
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8 linkto(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper);
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 linkto(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8);
  level.var_e0c7b4b2.move_speed = 100;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_e0159e34 = 10;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_e0159e34 = 10;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_e0159e34 = 60;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.var_e0159e34 = 60;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.rotor.rotate_speed = 0;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.rotor.var_e558e669 = 0.03;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.rotor.var_2b247bb5 = 0.07;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.rotor.var_c7395e63 = 20;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.tail_rotor.rotate_speed = 0;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.tail_rotor.var_e558e669 = 0.03;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.tail_rotor.var_2b247bb5 = 0.07;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.tail_rotor.var_c7395e63 = 60;
  level flag::wait_till(#"start_zombie_round_logic");
  level.var_94185ac9 = ["zone_anytown_usa_west", "zone_anytown_usa_east", "zone_tv_repair", "zone_anytown_usa_east_2", "zone_drinks_bar", "zone_drinks_bar_roof", "zone_burger_town_roof", "zone_burger_town", "zone_concessions", "zone_cinema", "zone_anytown_usa_west_2", "zone_video_store", "zone_video_store_roof", "zone_anytown_usa_rooftops", "zone_anytown_usa_backlot"];
  level.var_6bfd8427 = struct::get_array("ht_trigger", "targetname");
  level.var_6bfd8427 array::thread_all(level.var_6bfd8427, &function_3c3b85e6);
  level.var_81aa2a00 = getEntArray("hind_trap_switch", "targetname");
  level.var_842b7e4b = getEntArray("hind_trap_switch_light", "targetname");

  for(i = 0; i < level.var_81aa2a00.size; i++) {
    level.var_81aa2a00[i] clientfield::set("set_compass_icon", 1);
    level.var_81aa2a00[i].var_d6b3b6e0 = level.var_842b7e4b[i];
  }

  level.var_81aa2a00 array::thread_all(level.var_81aa2a00, &function_f13155cb);
  zm::register_actor_damage_callback(&function_2db7dc3);
  level.var_217aad9f = 0;
}

function function_f13155cb() {
  self.var_fdec2822 = util::spawn_model(#"p8_zm_off_trap_switch_handle", self gettagorigin("tag_up"), self.angles);
  self function_7265ebeb(undefined);
  level flag::wait_till("power_on");
  self function_7265ebeb(1);
  self.var_d6b3b6e0 clientfield::set("" + # "hash_16e5e4d2ea0716b7", 2);
}

function function_3c3b85e6() {
  var_9779f8c5 = self zm_unitrigger::create(&function_5db5b22e, 32, &function_477e5e68);
  var_9779f8c5.var_4326facc = self;
}

function function_7265ebeb(b_on) {
  if(isDefined(b_on)) {
    if(b_on) {
      self.var_d6b3b6e0 setModel(#"p8_zm_off_trap_switch_light_green_on");
    } else {
      self.var_d6b3b6e0 setModel(#"p8_zm_off_trap_switch_light_red_on");
    }

    return;
  }

  self.var_d6b3b6e0 setModel(#"p8_zm_off_trap_switch_light");
}

function function_5db5b22e(e_player) {
  if(isPlayer(e_player) && e_player istouching(self)) {
    if(!level flag::get("power_on")) {
      self sethintstring(#"zombie/need_power");
      return true;
    } else if(level flag::get(#"hash_6ca7775f1a984c68")) {
      self sethintstring(#"hash_3f04de589d21e4fa");
      return true;
    } else if(level flag::get(#"hash_3b32dd943e760a34")) {
      self sethintstring(#"hash_35fd3b64405b6eca");
      return true;
    } else {
      self sethintstring(#"hash_2629a4ab98a94d73", 2000);

      if(!e_player zm_score::can_player_purchase(2000)) {
        e_player globallogic::function_d1924f29(#"hash_6e3ae7967dc5d414");
        e_player.var_e62ad24a = self;
      }

      return true;
    }
  }

  if(e_player.var_e62ad24a === self) {
    e_player globallogic::function_d96c031e();
    e_player.var_e62ad24a = undefined;
  }

  return false;
}

function function_477e5e68() {
  level endon(#"end_game");

  while(true) {
    result = self waittill(#"trigger");

    if(!level flag::get("power_on") || level flag::get(#"hash_3b32dd943e760a34") || level flag::get(#"hash_6ca7775f1a984c68")) {
      continue;
    }

    if(result.activator zm_score::can_player_purchase(2000)) {
      result.activator thread zm_score::minus_to_player_score(2000);
      level.var_81aa2a00 array::thread_all(level.var_81aa2a00, &function_4eaecff9);
      level function_795e2881(result.activator);
    }
  }
}

function function_4eaecff9() {
  self playSound(#"hash_7ef6b2ee20c71968");
  self.var_fdec2822 rotateto(self.angles + (179, 0, 0), 0.3);
  self playSound(#"hash_137dbe10929df4eb");
  self.var_fdec2822 waittill(#"rotatedone");
  self function_7265ebeb(0);
  self.var_fdec2822 clientfield::increment("" + # "hash_575d68a64ff032b2", 1);
  self.var_d6b3b6e0 clientfield::set("" + # "hash_16e5e4d2ea0716b7", 1);
}

function function_b53f905a() {
  self.var_fdec2822 rotateto(self.angles + (90, 0, 0), 0.3);
  self playSound(#"hash_5c08d7c4ad20f4b8");
  wait 0.3;
  self playSound(#"hash_7744ef898bf5b90e");
  self function_7265ebeb(0);
  self.var_d6b3b6e0 clientfield::set("" + # "hash_16e5e4d2ea0716b7", 1);
}

function private function_795e2881(e_owner) {
  level.var_6f8aa603 = e_owner;
  level.var_dc7ff908 = function_c7e1db4();
  level thread function_e0beead2();
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper playSound(#"hash_5364b119bbfae35e");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper playLoopSound(#"hash_40631d599798f4d4");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper thread zm_vo::function_d6f8bbd9(#"hash_1a2c45fc8a9c904f");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8 playSound(#"hash_4f6cc741c5b656bd");
  level.var_e0c7b4b2 thread function_a688a771();
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.rotor thread function_44456e3f("top_rotor");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.tail_rotor thread function_44456e3f("tail_rotor");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 thread function_d4782b16();
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 laseron();
  callback::on_ai_killed(&function_8004c21d);
  level thread function_8ff4b970();
}

function private function_55484248() {
  level.var_6f8aa603 = undefined;
  level.var_dc7ff908 = undefined;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.my_target = undefined;
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper thread zm_vo::function_d6f8bbd9(#"hash_787bffbad79a5c18");

  if(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 flag::get(#"hash_6783a838342e2900")) {
    level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 flag::clear(#"hash_6783a838342e2900");
  }

  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.rotor thread function_c60c6664("top_rotor");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.tail_rotor thread function_c60c6664("tail_rotor");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 laseroff();
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper playSound(#"hash_190dcd3c162ebde6");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper stoploopsound();
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 stoploopsound();
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_4d30df70 = 0;
  level notify(#"hash_d85bf2288b3c1c3");
  callback::remove_on_ai_killed(&function_8004c21d);
  level thread function_d7e75506();
}

function private function_9f433625() {
  self.var_fdec2822 rotateto(self.angles, 0.3);
  self playSound(#"hash_59680d123025c6f0");
  wait 0.3;
  self function_7265ebeb(1);
  self.var_d6b3b6e0 clientfield::set("" + # "hash_16e5e4d2ea0716b7", 2);
}

function private function_8ff4b970() {
  level endon(#"end_game");
  level flag::set(#"hash_6ca7775f1a984c68");
  wait 50;
  level flag::clear(#"hash_6ca7775f1a984c68");
  level.var_81aa2a00 array::thread_all(level.var_81aa2a00, &function_b53f905a);
  level function_55484248();
}

function private function_d7e75506() {
  level endon(#"end_game", #"hash_579f5585446dafb2");
  level flag::set(#"hash_3b32dd943e760a34");
  wait 60;
  level flag::clear(#"hash_3b32dd943e760a34");
  level.var_81aa2a00 array::thread_all(level.var_81aa2a00, &function_9f433625);
}

function private function_a688a771() {
  level endon(#"end_game", #"hash_3b32dd943e760a34");

  if(!isDefined(level.var_e0c7b4b2.var_4d30df70)) {
    level.var_e0c7b4b2.var_4d30df70 = 0;
  }

  self childthread function_46d03b27();

  while(true) {
    if(level.var_e0c7b4b2 function_fa889b40()) {
      if(level.var_e0c7b4b2.origin[0] > level.var_dc7ff908.origin[0]) {
        var_b3b98b6b = level.var_dc7ff908.origin[0] + 800;
      } else {
        var_b3b98b6b = level.var_dc7ff908.origin[0] - 800;
      }

      if(level.var_e0c7b4b2.var_df4d758d.origin[1] > level.var_dc7ff908.origin[1]) {
        var_c5ef2fd6 = level.var_dc7ff908.origin[1] + 400;
      } else {
        var_c5ef2fd6 = level.var_dc7ff908.origin[1] - 400;
      }

      var_b3b98b6b = math::clamp(var_b3b98b6b, 2400, 5600);
      var_c5ef2fd6 = math::clamp(var_c5ef2fd6, 1850, 3000);
      var_e613ab2e = (var_b3b98b6b, self.origin[1], self.origin[2]);
      var_2aa484b2 = (var_b3b98b6b, var_c5ef2fd6, self.var_df4d758d.origin[2]);
      var_7ac59e29 = (var_b3b98b6b, var_c5ef2fd6, self.var_df4d758d.var_3b09f1e2.origin[2]);
      move_time = distance2d(self.origin, var_e613ab2e) / self.move_speed;

      if(move_time > 0) {
        if(!level.var_e0c7b4b2.var_4d30df70) {
          level.var_e0c7b4b2.var_4d30df70 = 1;
          level.var_e0c7b4b2 thread function_8ada6fcd();
        }

        self moveto(var_e613ab2e, move_time);
        self.var_df4d758d moveto(var_2aa484b2, move_time);
        self.var_df4d758d.var_3b09f1e2 moveto(var_7ac59e29, move_time);
      }
    }

    wait 0.1;
  }
}

function function_46d03b27() {
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 rotateto(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.angles, 0.1);
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8 rotateto(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.angles, 0.1);

  while(true) {
    if(level function_375ded2c()) {
      target_angle = vectortoangles(level.var_dc7ff908.origin - level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.origin);

      if(absangleclamp180(target_angle[1] - level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.angles[1]) > 5) {
        if(!isalive(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.my_target)) {
          var_649dd690 = level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_e0159e34;
          level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 childthread function_96e00567(target_angle, var_649dd690);
          level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8 childthread function_96e00567(target_angle, var_649dd690);
        }

        level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 childthread function_96e00567(target_angle);
      }

      if(isalive(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.my_target)) {
        target_angle = vectortoangles(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.my_target.origin - level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.origin);
        level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 childthread function_96e00567(target_angle, level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_e0159e34);
        level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8 function_96e00567(target_angle);
        level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 function_883dd655(target_angle);
      }
    }

    wait 0.5;
  }
}

function function_96e00567(target_angles, speed = self.var_e0159e34) {
  self notify("10642f543d04676d");
  self endon("10642f543d04676d");

  if(!isDefined(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_4d30df70)) {
    level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_4d30df70 = 0;
  }

  target_angles = (self.angles[0], target_angles[1], self.angles[2]);
  rotate_time = function_78344094(self.angles[1], target_angles[1], speed);

  if(rotate_time > 0.1) {
    self rotateto(target_angles, rotate_time);

    if(!level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_4d30df70) {
      level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_4d30df70 = 1;
      level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 function_d2fe0c64(#"hash_8a4faf034e8b780");
    }

    wait rotate_time;
    return;
  }

  self rotateto(target_angles, 0.1);

  if(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_4d30df70) {
    level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.var_4d30df70 = 0;
    level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 function_d1c78d29(#"hash_8a4faf034e8b780");
  }

  wait 0.1;
}

function function_883dd655(target_angle) {
  rotate_time = function_78344094(self.angles[0], target_angle[0], self.var_e0159e34);
  rotate_time = max(rotate_time, 0.1);
  self rotateto(target_angle, rotate_time);
  wait rotate_time;
}

function function_78344094(var_7b783ebb, target_angle, speed) {
  var_7b783ebb = var_7b783ebb < 0 ? var_7b783ebb + 360 : var_7b783ebb;
  target_angle = target_angle < 0 ? target_angle + 360 : target_angle;
  base_time = abs(var_7b783ebb - target_angle);
  base_time = (base_time < 180 ? base_time : 360 - base_time) / speed;
  return base_time;
}

function private function_fa889b40() {
  if(!isDefined(level.var_dc7ff908)) {
    return false;
  }

  var_f8b761ad = self.origin[0] - level.var_dc7ff908.origin[0];

  if(var_f8b761ad < 1000 && var_f8b761ad > 500 || var_f8b761ad > -1000 && var_f8b761ad < -500) {
    return false;
  }

  return true;
}

function private function_375ded2c() {
  if(!isDefined(level.var_dc7ff908)) {
    return false;
  }

  return true;
}

function function_8ada6fcd() {
  self notify("4a6abb721ca765be");
  self endon("4a6abb721ca765be");
  level.var_e0c7b4b2 playSound(#"hash_23689876c990a770");
  level.var_e0c7b4b2 playLoopSound(#"hash_2cf241f5f4aba942");
  self waittill(#"movedone");
  level.var_e0c7b4b2 playSound(#"hash_9f5dcea7f83f634");
  level.var_e0c7b4b2 stoploopsound();
  level.var_e0c7b4b2.var_4d30df70 = 0;
}

function function_d2fe0c64(str_prefix) {
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 playSound(str_prefix + "start");
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 playLoopSound(str_prefix + "loop");
}

function function_d1c78d29(str_prefix) {
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 stoploopsound();
  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2 playSound(str_prefix + "stop");
}

function private function_44456e3f(var_e83c664a) {
  self endon(#"death", #"stop_rotating");
  level endon(#"end_game");
  self notify(#"start_rotating");

  while(true) {
    switch (var_e83c664a) {
      case # "top_rotor":
        self rotateyaw(self.rotate_speed, float(function_60d95f53()) / 1000);
        break;
      case # "tail_rotor":
        target_yaw = level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.angles[1];

        if(absangleclamp180(self.angles[1] - target_yaw) < 3) {
          target_yaw = self.angles[1];
        }

        self rotateto((self.angles[0] + self.rotate_speed, target_yaw, 0), float(function_60d95f53()) / 1000);
        break;
      default:
        self rotateyaw(self.rotate_speed, float(function_60d95f53()) / 1000);
        break;
    }

    if(self.rotate_speed < self.var_c7395e63) {
      self.rotate_speed += self.var_e558e669;

      if(self.rotate_speed > self.var_c7395e63) {
        self.rotate_speed = self.var_c7395e63;
      }
    }

    waitframe(1);
  }
}

function private function_c60c6664(var_e83c664a) {
  self endon(#"death");
  level endon(#"end_game");
  self notify(#"stop_rotating");

  while(self.rotate_speed > 0) {
    switch (var_e83c664a) {
      case # "top_rotor":
        self rotateyaw(self.rotate_speed, float(function_60d95f53()) / 1000);
        break;
      case # "tail_rotor":
        target_yaw = level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.angles[1];

        if(absangleclamp180(self.angles[1] - target_yaw) < 3) {
          target_yaw = self.angles[1];
        }

        self rotateto((self.angles[0] + self.rotate_speed, target_yaw, 0), float(function_60d95f53()) / 1000);
        break;
      default:
        self rotateyaw(self.rotate_speed, float(function_60d95f53()) / 1000);
        break;
    }

    self.rotate_speed -= self.var_2b247bb5;
    waitframe(1);
  }

  self.rotate_speed = 0;
}

function private function_d4782b16() {
  if(!isDefined(self.var_b74bb962)) {
    self.var_b74bb962 = util::spawn_model("tag_origin", self gettagorigin("tag_gunner_flash1"), self gettagangles("tag_gunner_flash1"));
    self.var_b74bb962 linkto(self, "tag_gunner_flash1");
  }

  switch (level.var_217aad9f) {
    case 0:
      level.var_9e7b0d9 = getweapon(#"hash_2eaef6ae3b6fee65");
      break;
    default:
      level.var_9e7b0d9 = getweapon(#"hash_2eaef6ae3b6fee65");
      break;
  }

  level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 setweapon(level.var_9e7b0d9);
  self thread function_2678d78c();
  self thread function_24ce3a7();
}

function private function_2678d78c() {
  self endon(#"death");
  level endon(#"end_game", #"hash_3b32dd943e760a34");

  while(true) {
    if(isalive(self.my_target) && function_c8c79a28(self.var_b74bb962.origin, self.my_target.origin + (0, 0, 30))) {
      wait 0.5;
      continue;
    }

    self notify(#"change_target");
    a_zombies = getaiteamarray(level.zombie_team);
    self.my_target = undefined;
    self flag::clear(#"hash_6783a838342e2900");

    if(isDefined(level.var_dc7ff908)) {
      self.my_target = function_3da631cc(level.var_dc7ff908, self, a_zombies);
    }

    wait 1;
  }
}

function private function_3da631cc(entity, turret, a_zombies) {
  var_8a0a0ad0 = 99999;

  foreach(zombie in a_zombies) {
    var_3300333c = distance(turret.origin, zombie.origin);

    if(var_3300333c < var_8a0a0ad0) {
      if(function_c8c79a28(self.var_b74bb962.origin, zombie.origin + (0, 0, 30))) {
        target = zombie;
        var_8a0a0ad0 = var_3300333c;
        continue;
      }
    }
  }

  return target;
}

function private function_24ce3a7() {
  level endon(#"hash_3b32dd943e760a34");

  while(true) {
    var_e117104d = function_c46f0aa(self.var_b74bb962.origin, self.my_target, anglesToForward(self.var_b74bb962.angles), 0.95);

    if(isalive(self.my_target) && !self flag::get(#"hash_6783a838342e2900") && var_e117104d) {
      self thread function_f35a7c49(self.my_target);
    }

    wait 0.5;
  }
}

function function_f35a7c49(target) {
  level endon(#"end_game", #"hash_3b32dd943e760a34");
  self endon(#"change_target");
  self flag::set(#"hash_6783a838342e2900");
  var_72f571c9 = 0;
  var_9920b31d = 0;
  var_4a5383d9 = 0;
  var_8d2dfb7b = 1;

  while(isalive(target)) {
    playsoundatposition(#"hash_28fd24537d849f13", self.var_b74bb962.origin);

    if(target.zm_ai_category === # "normal") {
      if(var_8d2dfb7b) {
        v_offset = (randomfloatrange(-50, 50), randomfloatrange(-50, 50), 0);
        var_4a5383d9++;
      } else {
        v_offset = (0, 0, randomfloatrange(0, 40));

        if(var_72f571c9 > 2) {
          if(math::cointoss(60)) {
            target zombie_utility::setup_zombie_knockdown(target.origin);
          }

          var_72f571c9 = 0;
        }

        if(var_9920b31d > 25) {
          if(isPlayer(level.var_6f8aa603)) {
            level.var_6f8aa603 zm_stats::function_7ec42fbf(#"hash_1b510c3803746a43");
          }

          target dodamage(target.health + 999, target.origin, self);
          var_9920b31d = 0;
        }

        var_8d2dfb7b = 1;
      }

      self clientfield::increment("" + # "hash_27556b053ce9a6a2", 1);
      var_72f571c9++;
      var_9920b31d++;
    } else {
      if(var_8d2dfb7b) {
        v_offset = (randomfloatrange(-50, 50), randomfloatrange(-50, 50), 0);
        var_4a5383d9++;
      } else {
        v_offset = (0, 0, randomfloatrange(0, 40));
      }

      self clientfield::increment("" + # "hash_27556b053ce9a6a2", 1);
    }

    var_cbe2a4ad = self.var_b74bb962.origin + anglesToForward(self.var_b74bb962.angles) * 2000;
    magicbullet(level.var_9e7b0d9, self.var_b74bb962.origin, var_cbe2a4ad + v_offset, self);
    a_zombies = self getenemiesinradius(target.origin, 70);

    foreach(zombie in a_zombies) {
      if(isalive(zombie) && zombie.zm_ai_category === # "normal") {
        if(math::cointoss(50)) {
          zombie zombie_utility::setup_zombie_knockdown(zombie.origin);
        }
      }
    }

    if(var_4a5383d9 > 3) {
      var_8d2dfb7b = 0;
      var_4a5383d9 = 0;
    }

    wait 0.08;
  }

  self.my_target = undefined;
  self flag::clear(#"hash_6783a838342e2900");
}

function function_2db7dc3(inflictor, attacker, damage, flags, meansofdeath, weapon, var_fd90b0bb, vpoint, vdir, shitloc, psoffsettime, boneindex, surfacetype) {
  if(surfacetype === level.var_9e7b0d9) {
    boneindex = zm_equipment::function_379f6b5d(boneindex, surfacetype, self.zm_ai_category, self.maxhealth);
    boneindex = min(boneindex, 999999);
  }

  return boneindex;
}

function function_c46f0aa(var_edfffb43, target_entity, var_3e383915, var_456379df, var_a11fa31c) {
  if(!isDefined(var_3e383915)) {
    return false;
  }

  target_forward = vectornormalize(var_3e383915.origin + (0, 0, 2) - target_entity);

  if(vectordot(target_forward, var_456379df) > var_a11fa31c) {
    return true;
  }

  return false;
}

function function_8004c21d(s_params) {
  attacker = s_params.eattacker;

  if(attacker === level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1 && isDefined(level.var_6f8aa603)) {
    level scoreevents::doscoreeventcallback("scoreEventZM", {
      #attacker: level.var_6f8aa603, #scoreevent: # "hash_748d4479ffd0521e", #enemy: self
    });
  }
}

function private function_c8c79a28(var_7bb5f94b, var_41d5aa6f) {
  return bullettracepassed(var_7bb5f94b, var_41d5aa6f, 0, undefined);
}

function private function_c7e1db4() {
  if(isDefined(level.var_6f8aa603.cached_zone_name) && isinarray(level.var_94185ac9, level.var_6f8aa603.cached_zone_name)) {
    return level.var_6f8aa603;
  }

  a_players = function_a1ef346b();

  foreach(player in a_players) {
    if(isDefined(player.cached_zone_name) && isinarray(level.var_94185ac9, player.cached_zone_name)) {
      return player;
    }
  }

  return undefined;
}

function private function_e0beead2() {
  level endon(#"end_game", #"hash_d85bf2288b3c1c3");

  while(true) {
    if(!isDefined(level.var_dc7ff908.cached_zone_name) || !isinarray(level.var_94185ac9, level.var_dc7ff908.cached_zone_name)) {
      level.var_dc7ff908 = function_c7e1db4();
    }

    if(isDefined(level.var_6f8aa603.cached_zone_name) && isinarray(level.var_94185ac9, level.var_6f8aa603.cached_zone_name)) {
      level.var_dc7ff908 = function_c7e1db4();
    }

    waitframe(1);
  }
}

function function_cd7a3de4() {
  util::add_debug_command("<dev string:x38>");
  util::add_debug_command("<dev string:xa4>");
  zm_devgui::add_custom_devgui_callback(&cmd);
}

function cmd(cmd) {
  switch (cmd) {
    case # "hash_1f54a283b6613f19":
      if(!level flag::get(#"hash_3b32dd943e760a34")) {
        level.var_81aa2a00 array::thread_all(level.var_81aa2a00, &function_4eaecff9);
        level function_795e2881(function_a1ef346b()[0]);
      }

      break;
    case # "hash_2ca5e689627176a0":
      if(level flag::get(#"hash_3b32dd943e760a34")) {
        level notify(#"hash_579f5585446dafb2");
        level flag::clear(#"hash_3b32dd943e760a34");
        level.var_81aa2a00 array::thread_all(level.var_81aa2a00, &function_9f433625);
      }

      break;
  }
}

function function_9cdc9afa() {
  level endon(#"end_game", #"hash_3b32dd943e760a34");

  while(true) {
    if(isDefined(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8)) {
      circle(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.origin, 50, (1, 1, 0));
      print3d(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.origin, "<dev string:x100>", (1, 1, 0));
    }

    if(isDefined(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1)) {
      circle(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.origin, 50, (0, 1, 0));
      print3d(level.var_e0c7b4b2.var_df4d758d.var_3b09f1e2.chopper.var_15ba53f8.var_f49a9bc1.origin, "<dev string:x10f>", (0, 1, 0));
    }

    waitframe(1);
  }
}