/****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_dig_02_srv.gsc
****************************************************/

main() {
  maps\mp\mp_zombie_dig_02_srv_precache::main();
  maps\createart\mp_zombie_dig_02_srv_art::main();
  maps\mp\mp_zombie_dig_02_srv_fx::main();
  _id_0483::main();
  maps\mp\mp_zombie_dig_02_lighting::main();
  maps\mp\mp_zombie_dig_02_aud::main();
  _id_0472::_id_8A2F("compass_map_mp_zombie_dig_02_srv");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  setDvar("2494", "0.12, 0, 0");
  setDvar("4341", "0");
  setDvar("1520", "-1 -1 -1 100");
  level._id_AC2E = 7;
  level.zmcharactervariantid = 1;
  level._id_ABD3 = -1500;
  level.initnewzombietypes = ::init_new_zombie_types;
  level.sg_pack_use_small_radius = 1;
  level._id_AC71 = ::initdigsrvweapons;
  level._id_0C11 = 0;
  level._id_783F = 0;
  level.door_data_out_of_date = 0;
  level.disable_jumpscare_playerdata = 0;
  level._id_6BB0 = ::ondigsrvstartgame;
  level.reworkedconsumabledenabled = 1;
  level.loot_pap_camo_ref_override = "zom_amp_02";
  level.pap_camo_ref_override = "zom_madmin_01";
  var_0 = getEntArray("mp_global_intermission", "classname");

  foreach(var_2 in var_0) {
    var_2.angles = (0, 90, 0);
    var_2.origin = (10, 196, 139.9);
  }

  common_scripts\utility::flag_init("power_sz2");
  common_scripts\utility::flag_init("outer_to_arena");
  maps\mp\zombies\zombie_survival_common::init();
  level thread dig_kill_z_listener();
  init_dig_srv_zones();
  thread srv_rune_wall_init();
  thread srv_basalt_init();
  thread srv_kf_ee_init();
  maps\mp\zombies\shotgun\_zombies_shotgun_gamemode_fx::init();
  level.upgrade_machine_upgrade_func = maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::collect_souls_to_unlock_pack_a_punch;
  level thread maps\mp\zombies\shotgun\_zombies_shotgun_gamemode::run_pack_a_punch_log();
}

initdigsrvweapons() {
  level.sworddelivery_uselargeradius = 1;
  level.sworddelivery_checkradius = 256;
  level thread maps\mp\zombies\zombie_survival_common::initsurvivalweapons();
  level thread maps\mp\zombies\weapons\_zombie_tabun_grenade::init();
}

init_dig_srv_zones() {
  _id_055A::init();
  _id_055A::_id_530A("zone_under_arena", 0);
  _id_055A::_id_530A("zone_under_outer", 1);
  _id_055A::_id_0993("zone_under_outer", "zone_under_arena", "outer_to_arena");
  _id_055A::_id_088A();
  common_scripts\utility::flag_set("outer_to_arena");
}

init_new_zombie_types() {
  maps\mp\zombies\zombie_sizzler::init();
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
  _id_0547::_id_A78B();
  var_0 = _getEnt("blood_fount_NE", "targetname");
  var_0.is_activated = 0;
  var_1 = _getEnt("blood_fount_SE", "targetname");
  var_1.is_activated = 0;
  var_2 = _getEnt("blood_fount_SW", "targetname");
  var_2.is_activated = 0;
  var_3 = _getEnt("blood_fount_NW", "targetname");
  var_3.is_activated = 0;
  thread blood_fount_single_listen(var_0, 213);
  thread blood_fount_single_listen(var_1, 214);
  thread blood_fount_single_listen(var_2, 215);
  thread blood_fount_single_listen(var_3, 216);
}

blood_fount_single_listen(var_0, var_1) {
  _playFXOnTag(level._effect["dlc_zmb_dig02_blood_statue_grit"], var_0, "TAG_ORIGIN");
  _id_0378::_id_8D74("aud_turn_on_bloodfalls", var_0);
  level thread common_scripts\_exploder::_id_088E(var_1);
}

dig_door_listener_arena() {
  common_scripts\utility::_id_3C9F("outer_to_arena");

  foreach(var_1 in level._id_AC1D) {
    if(isDefined(var_1.getnegotiationnextnode) && var_1.getnegotiationnextnode == "outer_to_arena" && (!isDefined(var_1._id_6BE1) || !var_1._id_6BE1)) {
      var_1 notify("open", undefined);
    }
  }
}

dig_kill_z_listener() {
  var_0 = _getEnt("dig_kill_z", "targetname");

  for(;;) {
    var_0 waittill("trigger", var_1);

    if(isPlayer(var_1)) {
      var_1 suicide();
    }
  }
}

srv_rune_wall_init() {
  var_0 = common_scripts\utility::_id_46B5("rune_wall_struct", "targetname");

  if(!isDefined(var_0.target)) {
    return;
  }
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");
  var_0.rune_models = [];
  var_0.special_runes = [];

  foreach(var_3 in var_1) {
    var_4 = var_3._id_0165;

    if(!isDefined(var_4)) {
      continue;
    }
    switch (var_4) {
      case "rune_wall_rune":
        var_5 = _func_36D(var_3.model, "zmd_runes_objects_");
        var_6 = int(var_5) - 1;
        var_0.rune_models[var_6] = var_3;
        var_0.rune_models[var_6] setCanDamage(1);
        var_0.rune_models[var_6] setdamagecallbackon(1);
        var_0.rune_models[var_6].my_index = var_6;
        var_0.rune_models[var_6].my_base_model = var_3.model;
        var_0.rune_models[var_6].my_highlight_model = var_3.model + "a";
        var_0.rune_models[var_6].damagecallback = ::rune_damaged;
        break;
      case "rune_wall_special_rune_1":
        var_0.special_runes[1] = var_3;
        break;
      case "rune_wall_special_rune_2":
        var_0.special_runes[2] = var_3;
        break;
      case "rune_wall_special_rune_3":
        var_0.special_runes[3] = var_3;
        break;
    }
  }

  var_0.special_message = [19, 20, 9, 17, 1, 14, 11];
  level.can_damage_runes = 1;
  level.dig_objective_assets["runes"] = var_0;
  var_0 thread srv_rune_wall_listen();
}

srv_rune_wall_listen() {
  var_0 = 0;

  for(;;) {
    [var_2, var_3] = level common_scripts\utility::_id_A717("correct_rune_hit", "incorrect_rune_hit");

    if(_id_0547::_id_5565(var_2, "incorrect_rune_hit")) {
      level srv_rune_wall_reset();
      var_0 = 0;
      level.can_damage_runes = 0;
      level waittill("zombie_wave_ended");
      level.can_damage_runes = 1;
      continue;
    }

    if(_id_0547::_id_5565(var_2, "correct_rune_hit")) {
      var_0++;

      if(var_0 >= 7) {
        break;
      }
    }
  }

  level notify("basalt_reveal");
}

srv_rune_wall_reset() {
  var_0 = level.dig_objective_assets["runes"];

  foreach(var_2 in var_0.rune_models) {
    var_2._id_5594 = 0;
    var_2 setModel(var_2.my_base_model);
    var_2 setCanDamage(1);
    var_2 setdamagecallbackon(1);
    var_2.damagecallback = ::rune_damaged;
  }
}

rune_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  var_12 = level.dig_objective_assets["runes"];

  if(common_scripts\utility::_id_562E(level.can_damage_runes)) {
    if(isDefined(self.my_index)) {
      if(common_scripts\utility::_id_0F79(var_12.special_message, self.my_index) && !common_scripts\utility::_id_562E(self._id_5594)) {
        self setModel(self.my_highlight_model);
        self._id_5594 = 1;
        self setCanDamage(0);
        self setdamagecallbackon(0);
        self.damagecallback = undefined;
        level notify("correct_rune_hit", self.my_index);
      } else
        level notify("incorrect_rune_hit", self.my_index);
    }
  }

  return 0;
}

srv_basalt_init() {
  var_0 = common_scripts\utility::_id_46B5("basalt_reveal", "targetname");
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");
  var_0.bottom_pieces = [];
  var_0.top_pieces = [];

  foreach(var_3 in var_1) {
    var_4 = var_3._id_0165;

    if(!isDefined(var_4)) {
      continue;
    }
    switch (var_4) {
      case "basalt_reveal_top":
        var_3.dest_pos = common_scripts\utility::_id_46B5(var_3.target, "targetname");
        var_0.top_pieces = common_scripts\utility::_id_0F6F(var_0.top_pieces, var_3);
        break;
      case "basalt_reveal_bottom":
        var_3.dest_pos = common_scripts\utility::_id_46B5(var_3.target, "targetname");
        var_0.bottom_pieces = common_scripts\utility::_id_0F6F(var_0.bottom_pieces, var_3);
        break;
      case "basalt_reveal_trig":
        var_0._id_6FC5 = var_3;
        var_0._id_6FC5 common_scripts\utility::_id_9D9F();
        break;
      case "basalt_reveal_elec":
        var_0.elec_model = var_3;
        var_0.elec_model ghost();
        break;
    }
  }

  var_6 = _getEnt("srv_pap_fuse_spawn_loc", "targetname");

  if(isDefined(var_6)) {
    var_0.elec_model = var_6;
  }

  var_0._id_6FC5 _meth_8660(1, var_0.elec_model.origin);
  level.dig_objective_assets["basalt"] = var_0;
  var_0 thread srv_basalt_event();
}

srv_basalt_event() {
  var_0 = self;
  level waittill("basalt_reveal");
  var_1 = common_scripts\utility::_id_0F73(var_0.bottom_pieces, var_0.top_pieces);

  foreach(var_3 in var_1) {
    var_3 thread srv_basalt_move_to_dest();
  }

  var_0.bottom_pieces[0] _id_0378::_id_8D74("aud_basalt_move");
  var_0._id_6FC5 common_scripts\utility::_id_9DA3();
  var_0._id_6FC5 waittill("trigger", var_5);
  var_0.elec_model delete();
  var_0._id_6FC5 common_scripts\utility::_id_9D9F();
  level thread maps\mp\zombies\zombie_survival_common::srvshowpapfuse();
}

srv_basalt_move_to_dest() {
  level thread common_scripts\_exploder::_id_088E(212);
  var_0 = self;
  var_0 moveTo(var_0.dest_pos.origin, 5, 1, 1);
  wait 5;
}

srv_kf_ee_init() {
  level.srv_kf_ee_count = 0;
  var_0 = common_scripts\utility::_id_46B7("ee_dig_srv_plate", "targetname");

  if(!isDefined(var_0) || var_0.size <= 0) {
    return;
  }
  level.srv_kf_ee_expected = var_0.size;
  thread srv_flare_crate_init();

  foreach(var_2 in var_0) {
    var_2.sign_model = spawn("script_model", var_2.origin);
    var_2.sign_model setModel("zmd_sign_objective_01");
    var_2.sign_model.angles = var_2.angles;

    if(isDefined(var_2.scriptmodelplayanim)) {
      var_2.sign_model.test_radius = var_2.scriptmodelplayanim;
    } else {
      var_2.sign_model.test_radius = 16;
    }

    var_2.sign_model thread srv_kf_ee_dmg_listen();
  }

  level waittill("kf_ee_complete");
}

srv_kf_ee_dmg_listen() {
  for(;;) {
    level waittill("jack_exploded", var_0);

    if(!isDefined(var_0)) {
      continue;
    }
    if(distance(var_0, self.origin) <= self.test_radius) {
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
  var_0 = common_scripts\utility::_id_46B5("pickaxe_struct", "targetname");
  var_1 = common_scripts\utility::_id_44BE(var_0.target, "targetname");

  foreach(var_3 in var_1) {
    var_4 = var_3._id_0165;

    if(!isDefined(var_4)) {
      continue;
    }
    switch (var_4) {
      case "pickaxe_pickup_trig":
        var_0._id_6FC5 = var_3;
        var_0._id_6FC5 common_scripts\utility::_id_9D9F();
        var_0._id_6FC5 setHintString(&"ZOMBIE_DLC3_PICKUP_TABUN");
        break;
      case "flare_crate_model":
        var_0.flare_crate_model = var_3;

        if(isDefined(var_3.target)) {
          var_5 = common_scripts\utility::_id_44BE(var_3.target, "targetname");

          foreach(var_7 in var_5) {
            var_7 linkTo(var_3);

            if(isDefined(var_7._id_0165) && var_7._id_0165 == "tabun_model") {
              var_0.flare_model = var_7;
            }
          }
        }

        break;
      case "flare_crate_land_dest":
        var_0.flare_crate_land_dest = var_3;
        break;
    }
  }

  if(isDefined(var_0._id_6FC5) && isDefined(var_0.land_dest)) {
    var_0._id_6FC5 _meth_8660(1, var_0.land_dest.origin);
  }

  var_0 thread srv_flare_crate_drop_to_ground();
}

debug_srv_force_drop() {
  level notify("kf_ee_complete");
}

srv_flare_crate_drop_to_ground() {
  var_0 = self;
  level waittill("kf_ee_complete");
  level thread srv_dig_earthquake_trigger(1);
  var_0 srv_flare_crate_drop();
}

srv_flare_crate_drop() {
  var_0 = self;
  var_1 = undefined;

  if(isDefined(var_0.flare_crate_land_dest)) {
    var_1 = var_0.flare_crate_land_dest;
  }

  wait 6;

  if(isDefined(var_0.flare_crate_model) && isDefined(var_1)) {
    var_0.flare_crate_model _id_0547::obj_fall_to_ent_location(var_1);
  }

  if(isDefined(var_0.flare_crate_model)) {
    var_0.flare_crate_model _id_0378::_id_8D74("aud_flare_crate_drop");
  }

  if(isDefined(var_0.flare_crate_model)) {
    var_0.flare_crate_model scriptmodelplayanimdeltamotionfrompos("zom_berlin_flare_box_open", var_0.flare_crate_model.origin, var_0.flare_crate_model.angles);
  }

  var_0 thread srv_flare_crate_pickup_think();
}

srv_flare_crate_pickup_think() {
  level endon("game_over");
  var_0 = self;
  var_0._id_6FC5 common_scripts\utility::_id_9DA3();

  for(;;) {
    var_0._id_6FC5 waittill("trigger", var_1);
    var_1 maps\mp\zombies\weapons\_zombie_tabun_grenade::tabun_player_give_tabun();
    var_0._id_6FC5 _id_0378::_id_8D74("aud_pickup_flare");
    var_0.flare_model hide();
    level waittill("zombie_wave_started");
    level waittill("zombie_wave_started");
    var_0.flare_model show();
  }
}

srv_dig_earthquake_trigger(var_0) {
  if(!isDefined(level._id_6F18)) {
    level._id_6F18 = 0;
  }

  if(level._id_6F18) {
    return;
  }
  level notify("dig_earthquake_begin");
  var_1 = _randomfloatrange(3, 5);
  var_2 = _randomfloatrange(4, 8);
  _id_0378::_id_8D74("aud_dig_earthquake", "rumble3", var_1, var_0);
  wait(var_1);
  _id_0378::_id_8D74("aud_dig_earthquake", "earthquake", var_2, var_0);

  if(var_0 == 0) {
    level thread common_scripts\_exploder::_id_088E(204);
  }

  if(var_0 == 1) {
    level thread common_scripts\_exploder::_id_088E(204);
  }

  if(var_0 == 2) {
    level thread common_scripts\_exploder::_id_088E(205);
  }

  foreach(var_4 in level.players) {
    level thread srv_dig_earthquake_do_on_player(var_2, var_4, var_0);
  }

  wait(var_2);
  level notify("dig_earthquake_end");
}

srv_dig_earthquake_do_on_player(var_0, var_1, var_2) {
  var_3 = 0.3;

  if(isDefined(var_2)) {
    var_4 = 1;

    switch (var_2) {
      case 0:
        var_4 = 0.75;
        break;
      case 2:
        var_4 = 1.25;
        break;
      default:
        var_4 = 1;
        break;
    }

    var_3 = var_3 * var_4;
  }

  _earthquake(var_3, var_0, var_1.origin, 850, var_1);
  _playrumblelooponposition("tank_rumble", var_1.origin);
  wait(var_0);
  _stopallrumbles();
}