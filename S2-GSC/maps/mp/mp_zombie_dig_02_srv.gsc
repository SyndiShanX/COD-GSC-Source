/*********************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\mp_zombie_dig_02_srv.gsc
*********************************************/

func_00F9() {
  maps\mp\mp_zombie_dig_02_srv_precache::func_F9();
  maps\createart\mp_zombie_dig_02_srv_art::func_F9();
  maps\mp\mp_zombie_dig_02_srv_fx::func_F9();
  maps\mp\_load::func_F9();
  maps\mp\mp_zombie_dig_02_lighting::func_F9();
  maps\mp\mp_zombie_dig_02_aud::func_F9();
  maps\mp\_compass::func_8A2F("compass_map_mp_zombie_dig_02_srv");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("2494", "0.12, 0, 0");
  setDvar("4341", "0");
  setDvar("1520", "-1 -1 -1 100");
  level.var_AC2E = 7;
  level.zmcharactervariantid = 1;
  level.var_ABD3 = -1500;
  level.initnewzombietypes = ::init_new_zombie_types;
  level.sg_pack_use_small_radius = 1;
  level.var_AC71 = ::initdigsrvweapons;
  level.var_C11 = 0;
  level.var_783F = 0;
  level.door_data_out_of_date = 0;
  level.disable_jumpscare_playerdata = 0;
  level.var_6BB0 = ::ondigsrvstartgame;
  level.reworkedconsumabledenabled = 1;
  level.loot_pap_camo_ref_override = "zom_amp_02";
  level.pap_camo_ref_override = "zom_madmin_01";
  var_00 = getEntArray("mp_global_intermission", "classname");
  foreach(var_02 in var_00) {
    var_02.var_1D = (0, 90, 0);
    var_02.var_116 = (10, 196, 139.9);
  }

  common_scripts\utility::func_3C87("power_sz2");
  common_scripts\utility::func_3C87("outer_to_arena");
  maps\mp\zombies\zombie_survival_common::func_D5();
  level thread dig_kill_z_listener();
  init_dig_srv_zones();
  thread srv_rune_wall_init();
  thread srv_basalt_init();
  thread srv_kf_ee_init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx::func_D5();
  level.upgrade_machine_upgrade_func = ::maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::collect_souls_to_unlock_pack_a_punch;
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::run_pack_a_punch_log();
}

initdigsrvweapons() {
  level.sworddelivery_uselargeradius = 1;
  level.sworddelivery_checkradius = 256;
  level thread maps\mp\zombies\zombie_survival_common::initsurvivalweapons();
  level thread maps\mp\zombies\weapons\_zombie_tabun_grenade::func_D5();
}

init_dig_srv_zones() {
  lib_055A::func_D5();
  lib_055A::func_530A("zone_under_arena", 0);
  lib_055A::func_530A("zone_under_outer", 1);
  lib_055A::func_993("zone_under_outer", "zone_under_arena", "outer_to_arena");
  lib_055A::func_88A();
  common_scripts\utility::func_3C8F("outer_to_arena");
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_sizzler::func_D5();
  maps\mp\zombies\zombie_survival_common::srv_init_miniboss_rounds();
}

ondigsrvstartgame() {
  level.roundstartfuncgeneric = ::dig_srv_round_start;
  level.roundendfuncgeneric = ::dig_srv_round_end;
  thread maps\mp\mp_zombie_dig_02_trap::dig_trap_init();
  thread dig_srv_blood_founts();
}

dig_srv_round_start() {
  level thread maps\mp\zombies\zombie_survival_common::srvroundstart();
}

dig_srv_round_end() {
  level thread maps\mp\zombies\zombie_survival_common::srvroundend();
}

dig_srv_blood_founts() {
  lib_0547::func_A78B();
  var_00 = getent("blood_fount_NE", "targetname");
  var_00.is_activated = 0;
  var_01 = getent("blood_fount_SE", "targetname");
  var_01.is_activated = 0;
  var_02 = getent("blood_fount_SW", "targetname");
  var_02.is_activated = 0;
  var_03 = getent("blood_fount_NW", "targetname");
  var_03.is_activated = 0;
  thread blood_fount_single_listen(var_00, 213);
  thread blood_fount_single_listen(var_01, 214);
  thread blood_fount_single_listen(var_02, 215);
  thread blood_fount_single_listen(var_03, 216);
}

blood_fount_single_listen(param_00, param_01) {
  playFXOnTag(level.var_611["dlc_zmb_dig02_blood_statue_grit"], param_00, "TAG_ORIGIN");
  lib_0378::func_8D74("aud_turn_on_bloodfalls", param_00);
  level thread common_scripts\_exploder::func_88E(param_01);
}

dig_door_listener_arena() {
  common_scripts\utility::func_3C9F("outer_to_arena");
  foreach(var_01 in level.var_AC1D) {
    if(isDefined(var_01.var_819A) && var_01.var_819A == "outer_to_arena" && !isDefined(var_01.var_6BE1) || !var_01.var_6BE1) {
      var_01 notify("open", undefined);
    }
  }
}

dig_kill_z_listener() {
  var_00 = getent("dig_kill_z", "targetname");
  for(;;) {
    var_00 waittill("trigger", var_01);
    if(isPlayer(var_01)) {
      var_01 suicide();
    }
  }
}

srv_rune_wall_init() {
  var_00 = common_scripts\utility::func_46B5("rune_wall_struct", "targetname");
  if(!isDefined(var_00.var_1A2)) {
    return;
  }

  var_01 = common_scripts\utility::func_44BE(var_00.var_1A2, "targetname");
  var_00.rune_models = [];
  var_00.special_runes = [];
  foreach(var_03 in var_01) {
    var_04 = var_03.var_165;
    if(!isDefined(var_04)) {
      continue;
    }

    switch (var_04) {
      case "rune_wall_rune":
        var_05 = function_036D(var_03.var_106, "zmd_runes_objects_");
        var_06 = int(var_05) - 1;
        var_00.rune_models[var_06] = var_03;
        var_00.rune_models[var_06] setCanDamage(1);
        var_00.rune_models[var_06] setdamagecallbackon(1);
        var_00.rune_models[var_06].my_index = var_06;
        var_00.rune_models[var_06].my_base_model = var_03.var_106;
        var_00.rune_models[var_06].my_highlight_model = var_03.var_106 + "a";
        var_00.rune_models[var_06].var_29B5 = ::rune_damaged;
        break;

      case "rune_wall_special_rune_1":
        var_00.special_runes[1] = var_03;
        break;

      case "rune_wall_special_rune_2":
        var_00.special_runes[2] = var_03;
        break;

      case "rune_wall_special_rune_3":
        var_00.special_runes[3] = var_03;
        break;
    }
  }

  var_00.special_message = [19, 20, 9, 17, 1, 14, 11];
  level.can_damage_runes = 1;
  level.dig_objective_assets["runes"] = var_00;
  var_00 thread srv_rune_wall_listen();
}

srv_rune_wall_listen() {
  var_00 = 0;
  for(;;) {
    var_01 = level common_scripts\utility::func_A717("correct_rune_hit", "incorrect_rune_hit");
    var_02 = var_01[0];
    var_03 = var_01[1];
    if(lib_0547::func_5565(var_02, "incorrect_rune_hit")) {
      level srv_rune_wall_reset();
      var_00 = 0;
      level.can_damage_runes = 0;
      level waittill("zombie_wave_ended");
      level.can_damage_runes = 1;
      continue;
    }

    if(lib_0547::func_5565(var_02, "correct_rune_hit")) {
      var_00++;
      if(var_00 >= 7) {
        break;
      }
    }
  }

  level notify("basalt_reveal");
}

srv_rune_wall_reset() {
  var_00 = level.dig_objective_assets["runes"];
  foreach(var_02 in var_00.rune_models) {
    var_02.var_5594 = 0;
    var_02 setModel(var_02.my_base_model);
    var_02 setCanDamage(1);
    var_02 setdamagecallbackon(1);
    var_02.var_29B5 = ::rune_damaged;
  }
}

rune_damaged(param_00, param_01, param_02, param_03, param_04, param_05, param_06, param_07, param_08, param_09, param_0A, param_0B) {
  var_0C = level.dig_objective_assets["runes"];
  if(common_scripts\utility::func_562E(level.can_damage_runes)) {
    if(isDefined(self.my_index)) {
      if(common_scripts\utility::func_F79(var_0C.special_message, self.my_index) && !common_scripts\utility::func_562E(self.var_5594)) {
        self setModel(self.my_highlight_model);
        self.var_5594 = 1;
        self setCanDamage(0);
        self setdamagecallbackon(0);
        self.var_29B5 = undefined;
        level notify("correct_rune_hit", self.my_index);
      } else {
        level notify("incorrect_rune_hit", self.my_index);
      }
    }
  }

  return 0;
}

srv_basalt_init() {
  var_00 = common_scripts\utility::func_46B5("basalt_reveal", "targetname");
  var_01 = common_scripts\utility::func_44BE(var_00.var_1A2, "targetname");
  var_00.bottom_pieces = [];
  var_00.top_pieces = [];
  foreach(var_03 in var_01) {
    var_04 = var_03.var_165;
    if(!isDefined(var_04)) {
      continue;
    }

    switch (var_04) {
      case "basalt_reveal_top":
        var_03.dest_pos = common_scripts\utility::func_46B5(var_03.var_1A2, "targetname");
        var_00.top_pieces = common_scripts\utility::func_F6F(var_00.top_pieces, var_03);
        break;

      case "basalt_reveal_bottom":
        var_03.dest_pos = common_scripts\utility::func_46B5(var_03.var_1A2, "targetname");
        var_00.bottom_pieces = common_scripts\utility::func_F6F(var_00.bottom_pieces, var_03);
        break;

      case "basalt_reveal_trig":
        var_00.var_6FC5 = var_03;
        var_00.var_6FC5 common_scripts\utility::func_9D9F();
        break;

      case "basalt_reveal_elec":
        var_00.elec_model = var_03;
        var_00.elec_model method_8511();
        break;
    }
  }

  var_06 = getent("srv_pap_fuse_spawn_loc", "targetname");
  if(isDefined(var_06)) {
    var_00.elec_model = var_06;
  }

  var_00.var_6FC5 usetouchtriggerrequirefacingposition(1, var_00.elec_model.var_116);
  level.dig_objective_assets["basalt"] = var_00;
  var_00 thread srv_basalt_event();
}

srv_basalt_event() {
  var_00 = self;
  level waittill("basalt_reveal");
  var_01 = common_scripts\utility::func_F73(var_00.bottom_pieces, var_00.top_pieces);
  foreach(var_03 in var_01) {
    var_03 thread srv_basalt_move_to_dest();
  }

  var_00.bottom_pieces[0] lib_0378::func_8D74("aud_basalt_move");
  var_00.var_6FC5 common_scripts\utility::func_9DA3();
  var_00.var_6FC5 waittill("trigger", var_05);
  var_00.elec_model delete();
  var_00.var_6FC5 common_scripts\utility::func_9D9F();
  level thread maps\mp\zombies\zombie_survival_common::srvshowpapfuse();
}

srv_basalt_move_to_dest() {
  level thread common_scripts\_exploder::func_88E(212);
  var_00 = self;
  var_00 moveto(var_00.dest_pos.var_116, 5, 1, 1);
  wait(5);
}

srv_kf_ee_init() {
  level.srv_kf_ee_count = 0;
  var_00 = common_scripts\utility::func_46B7("ee_dig_srv_plate", "targetname");
  if(!isDefined(var_00) || var_00.size <= 0) {
    return;
  }

  level.srv_kf_ee_expected = var_00.size;
  thread srv_flare_crate_init();
  foreach(var_02 in var_00) {
    var_02.sign_model = spawn("script_model", var_02.var_116);
    var_02.sign_model setModel("zmd_sign_objective_01");
    var_02.sign_model.var_1D = var_02.var_1D;
    if(isDefined(var_02.var_8276)) {
      var_02.sign_model.test_radius = var_02.var_8276;
    } else {
      var_02.sign_model.test_radius = 16;
    }

    var_02.sign_model thread srv_kf_ee_dmg_listen();
  }

  level waittill("kf_ee_complete");
}

srv_kf_ee_dmg_listen() {
  for(;;) {
    level waittill("jack_exploded", var_00);
    if(!isDefined(var_00)) {
      continue;
    }

    if(distance(var_00, self.var_116) <= self.test_radius) {
      break;
    }
  }

  level.srv_kf_ee_count++;
  if(level.srv_kf_ee_count >= level.srv_kf_ee_expected) {
    level notify("kf_ee_complete");
  }

  self delete();
}

srv_flare_crate_init() {
  var_00 = common_scripts\utility::func_46B5("pickaxe_struct", "targetname");
  var_01 = common_scripts\utility::func_44BE(var_00.var_1A2, "targetname");
  foreach(var_03 in var_01) {
    var_04 = var_03.var_165;
    if(!isDefined(var_04)) {
      continue;
    }

    switch (var_04) {
      case "pickaxe_pickup_trig":
        var_00.var_6FC5 = var_03;
        var_00.var_6FC5 common_scripts\utility::func_9D9F();
        var_00.var_6FC5 sethintstring(&"ZOMBIE_DLC3_PICKUP_TABUN");
        break;

      case "flare_crate_model":
        var_00.flare_crate_model = var_03;
        if(isDefined(var_03.var_1A2)) {
          var_05 = common_scripts\utility::func_44BE(var_03.var_1A2, "targetname");
          foreach(var_07 in var_05) {
            var_07 linkto(var_03);
            if(isDefined(var_07.var_165) && var_07.var_165 == "tabun_model") {
              var_00.flare_model = var_07;
            }
          }
        }
        break;

      case "flare_crate_land_dest":
        var_00.flare_crate_land_dest = var_03;
        break;
    }
  }

  if(isDefined(var_00.var_6FC5) && isDefined(var_00.land_dest)) {
    var_00.var_6FC5 usetouchtriggerrequirefacingposition(1, var_00.land_dest.var_116);
  }

  var_00 thread srv_flare_crate_drop_to_ground();
}

debug_srv_force_drop() {
  level notify("kf_ee_complete");
}

srv_flare_crate_drop_to_ground() {
  var_00 = self;
  level waittill("kf_ee_complete");
  level thread srv_dig_earthquake_trigger(1);
  var_00 srv_flare_crate_drop();
}

srv_flare_crate_drop() {
  var_00 = self;
  var_01 = undefined;
  if(isDefined(var_00.flare_crate_land_dest)) {
    var_01 = var_00.flare_crate_land_dest;
  }

  wait(6);
  if(isDefined(var_00.flare_crate_model) && isDefined(var_01)) {
    var_00.flare_crate_model lib_0547::obj_fall_to_ent_location(var_01);
  }

  if(isDefined(var_00.flare_crate_model)) {
    var_00.flare_crate_model lib_0378::func_8D74("aud_flare_crate_drop");
  }

  if(isDefined(var_00.flare_crate_model)) {
    var_00.flare_crate_model method_8495("zom_berlin_flare_box_open", var_00.flare_crate_model.var_116, var_00.flare_crate_model.var_1D);
  }

  var_00 thread srv_flare_crate_pickup_think();
}

srv_flare_crate_pickup_think() {
  level endon("game_over");
  var_00 = self;
  var_00.var_6FC5 common_scripts\utility::func_9DA3();
  for(;;) {
    var_00.var_6FC5 waittill("trigger", var_01);
    var_01 maps\mp\zombies\weapons\_zombie_tabun_grenade::tabun_player_give_tabun();
    var_00.var_6FC5 lib_0378::func_8D74("aud_pickup_flare");
    var_00.flare_model method_805C();
    level waittill("zombie_wave_started");
    level waittill("zombie_wave_started");
    var_00.flare_model method_805B();
  }
}

srv_dig_earthquake_trigger(param_00) {
  if(!isDefined(level.var_6F18)) {
    level.var_6F18 = 0;
  }

  if(level.var_6F18) {
    return;
  }

  level notify("dig_earthquake_begin");
  var_01 = randomfloatrange(3, 5);
  var_02 = randomfloatrange(4, 8);
  lib_0378::func_8D74("aud_dig_earthquake", "rumble3", var_01, param_00);
  wait(var_01);
  lib_0378::func_8D74("aud_dig_earthquake", "earthquake", var_02, param_00);
  if(param_00 == 0) {
    level thread common_scripts\_exploder::func_88E(204);
  }

  if(param_00 == 1) {
    level thread common_scripts\_exploder::func_88E(204);
  }

  if(param_00 == 2) {
    level thread common_scripts\_exploder::func_88E(205);
  }

  foreach(var_04 in level.var_744A) {
    level thread srv_dig_earthquake_do_on_player(var_02, var_04, param_00);
  }

  wait(var_02);
  level notify("dig_earthquake_end");
}

srv_dig_earthquake_do_on_player(param_00, param_01, param_02) {
  var_03 = 0.3;
  if(isDefined(param_02)) {
    var_04 = 1;
    switch (param_02) {
      case 0:
        var_04 = 0.75;
        break;

      case 2:
        var_04 = 1.25;
        break;

      default:
        var_04 = 1;
        break;
    }

    var_03 = var_03 * var_04;
  }

  earthquake(var_03, param_00, param_01.var_116, 850, param_01);
  function_01BC("tank_rumble", param_01.var_116);
  wait(param_00);
  function_01BD();
}