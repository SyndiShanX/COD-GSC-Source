/*************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\mp_zombie_descent.gsc
*************************************************/

main() {
  level.use_zombie_unresolved_collision = 1;
  level.pack_a_punc_pre_func = maps\mp\mp_zombie_descent_ee_main::raise_machine_to_unlock_pack_a_punch;
  level._id_8B96 = ::descent_player_ignore_extra;
  level.zmb_player_safe_teleport_on_perk_buy = 1;
  maps\mp\mp_zombie_descent_precache::main();
  maps\createart\mp_zombie_descent_art::main();
  maps\mp\mp_zombie_descent_fx::main();
  _id_0483::main();
  maps\mp\mp_zombie_descent_lighting::main();
  maps\mp\mp_zombie_descent_aud::main();
  common_scripts\utility::flag_init("flag_closet_to_basement_1");
  hack_swap_basement_cloest_door_flag();
  _id_0472::_id_8A2F("compass_map_mp_zombie_descent");
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  level.zmcharactervariantid = 1;
  level._id_6BB0 = ::on_game_start_descent;
  level.pairedmeleeclipwarningonce = 0;
  level._id_902A = maps\mp\mp_zombie_descent_utils::_id_902A;
  level.pap_camo_ref_override = "camo_pap_04";
  level._id_AC71 = ::initdescentweapons;
  level.means_of_skipping_rounds_func = maps\mp\mp_zombie_nest_ee_wave_manipulation::skiproundwait2;
  level.door_data_out_of_date = 0;
  level._id_73BD = ::no_points_for_thule;
  level.usenavmeshforuber = 1;
  level._id_783F = 0;
  level.zombiespawnfxcount = 0;
  level thread maps\mp\zquests\zmb_secret_challenges_util::init_challenges_utility();
  level._id_AC2E = 8;
  level thread maps\mp\_utility::_id_6F74(::mute_audio_on_intro);
  init_blood_plates();
  init_ice_blocks();
  initprecache();
  _id_5375();
  _id_5339();
  initflags();
  level thread door_death_fix();
  level._id_ABD3 = -3500;
  level thread maps\mp\zombies\_zombies_audio_dlc2::initdlc2audio();
  _id_0544::init();
  level thread maps\mp\zombies\_zombies_harmonic_kinetic_accelerator::init();
  level thread maps\mp\zombies\_zombies_orbital_gravity_entangler::init();
  level thread maps\mp\zombies\_zombies_blood_tubes::init();
  level thread soundscripts\_snd_common_zmb_dlc4::snd_zmb_init_dlc4();
  level thread maps\mp\zquests\dlc4_secrets_mp_zombie_descent::init_dlc4_secrets_mp_zombie_descent();
  level thread maps\mp\zquests\dlc4_trophies_mp_zombie_descent::init();
  maps\mp\mp_zombie_nest_ee_wave_manipulation::main();
  level thread maps\mp\mp_zombie_descent_utils::vo_intro();
  level thread spawn_ice_breakers_on_door_open();
  level thread handle_door_orb_blockers();
  level thread maps\mp\zombies\zombie_corpse_eater::periodically_spawn_corpse_eaters();
  level thread handle_boss_battle_playtest();
  level thread setup_text_log_reveals();
  level thread handle_conditional_spawners();
  level thread maps\mp\_utility::_id_6F74(::spawnfadein);
  level thread maps\mp\_utility::_id_6F74(::player_clear_stuff_on_death);
}

no_points_for_thule(var_0, var_1) {
  if(common_scripts\utility::_id_562E(var_1.iszombieking))
    return 0;

  return 1;
}

spawnfadein() {
  self._id_6772 = _newclienthudelem(self);
  self._id_6772 setshader("black", 640, 480);
  self._id_6772.sort = 999;
  self._id_6772._id_00C6 = "fullscreen";
  self._id_6772._id_01CA = "fullscreen";
  self._id_6772.foreground = 0;

  while(!level.gamehasstarted)
    waitframe();

  thread animscripts\notetracks_common::do_fade_from_black(1.15);
}

player_clear_stuff_on_death() {
  self endon("disconnect");
  level endon("game_ended");

  for(;;) {
    self waittill("death");
    waitframe();

    if(isDefined(self.isintrial))
      self.isintrial = undefined;

    if(isDefined(self.inasneakyplace))
      self.inasneakyplace = 0;

    if(isDefined(self.hitchingaride))
      self.hitchingaride = 0;

    if(isDefined(self.isbloodtubemoonorbblocked))
      self.isbloodtubemoonorbblocked = undefined;

    if(isDefined(self.forcedblooddest))
      self.forcedblooddest = 0;

    if(isDefined(self.tryingtoleavepap))
      self.tryingtoleavepap = 0;

    if(isDefined(self.isonpushcooldown))
      self.isonpushcooldown = 0;

    if(isDefined(self._id_480F))
      self._id_480F = 0;
  }
}

handle_conditional_spawners() {
  foreach(var_1 in common_scripts\utility::_id_46B7("zombie_spawner", "script_noteworthy")) {
    if(isDefined(var_1.target)) {
      var_1.player_exclusion_zones = common_scripts\utility::_id_46B7(var_1.target, "targetname");
      var_1 thread toggle_active();
    }
  }
}

toggle_active() {
  var_0 = self;

  while(!isDefined(level.players) || level.players.size == 0)
    waitframe();

  for(;;) {
    var_0.is_zombies_spawner_script_disabled = 0;

    foreach(var_2 in var_0.player_exclusion_zones) {
      if(isDefined(var_2.weaponlocktargettooclose)) {
        return;
      }
      foreach(var_4 in level.players) {
        if(_distance2d(var_4.origin, var_2.origin) < var_2.radius && _abs(var_4.origin[2] - var_2.origin[2]) < var_2._id_00BD) {
          var_0.is_zombies_spawner_script_disabled = 1;
          break;
        }
      }
    }

    _id_0547::_id_A6F6();
  }
}

descent_player_ignore_extra(var_0) {
  if(common_scripts\utility::_id_562E(var_0.is_in_side_ee_mini_game))
    return 1;

  return 0;
}

mute_audio_on_intro() {
  self clientaddsoundsubmix("intro_movie");

  while(!level.gamehasstarted) {
    self freezecontrols(1);
    self allowfire(0);
    self disableoffhandweapons();
    self disableoffhandsecondaryweapons();
    waitframe();
  }

  self freezecontrols(0);
  self allowfire(1);
  self enableoffhandweapons();
  self enableoffhandsecondaryweapons();
  self clientclearsoundsubmix("intro_movie");
}

handle_boss_battle_playtest() {
  if(!getdvarint("spv_dlc4_activate_boss_battle_on_start", 0)) {
    return;
  }
  while(!isDefined(level._id_A980))
    waitframe();

  level._id_A980 = 18;
  level thread maps\mp\_utility::_id_6F74(::give_all_boss_battle_perks);
  wait 1;
  var_0 = common_scripts\utility::random(level.players);
  var_0 _id_057D::_id_4766();
  wait 5;
  maps\mp\mp_zombie_descent_ee_main::_id_784C();
}

give_all_boss_battle_perks() {
  var_0 = self;
  var_0 endon("disconnect");
  wait 1;

  while(!isalive(var_0) || !var_0 _meth_8648())
    wait 1;

  var_1 = var_0 getweaponlistprimaries();

  for(var_2 = 0; var_2 < var_1.size; var_2++) {
    if(_weapontype(var_1[var_2]) != "melee")
      var_0 _id_0586::_id_0790(var_1[var_2]);
  }

  foreach(var_4 in ["m1911_pap_zm", "svt40_pap_zm"]) {
    if(_id_0569::_id_55D4(var_4)) {
      _id_0548::_id_A7D6(var_0, var_0 _id_0586::_id_078B(_func_337(var_4, "pap_")));
      continue;
    }

    _id_0548::_id_A7D6(var_0, var_4);
  }

  var_0 _id_0586::_id_078E("m1911_pap_zm");
  var_0 _id_056A::_id_47B5();
  var_0 _id_056A::_id_4784();
  var_0 _id_056A::_id_4775();
  var_0 _id_056A::_id_47B1();
  var_0 _id_056A::_id_47B8();
}

init_blood_plates() {
  var_0 = common_scripts\utility::_id_46B7("blood_plate_struct", "targetname");
  var_1 = getEntArray("blood_pool", "targetname");
  level.blood_plates = [];

  foreach(var_3 in var_0) {
    if(isDefined(var_3.setlookatent) && var_3.setlookatent == "plate_frontdoor")
      level.blood_plates["first_door"] = var_3;

    if(isDefined(var_3.setlookatent) && var_3.setlookatent == "plate_trial_room") {
      level.blood_plates["trial"] = var_3;
      var_4 = var_1;
      var_4 = _sortbydistance(var_4, var_3.origin, 150);

      if(isDefined(var_4[0])) {
        var_3.blood_pool = var_4[0];
        var_3.blood_pool.min_pos = var_3.blood_pool.origin;
        var_3.blood_pool.max_pos = var_3.blood_pool.origin + (0, 0, 28);
      }
    }

    if(isDefined(var_3.setlookatent) && var_3.setlookatent == "plate_boss_room") {
      level.blood_plates[level.blood_plates.size] = var_3;
      var_4 = var_1;
      var_4 = _sortbydistance(var_4, var_3.origin, 150);

      if(isDefined(var_4[0])) {
        var_3.blood_pool = var_4[0];
        var_3.blood_pool.min_pos = var_3.blood_pool.origin;
        var_3.blood_pool.max_pos = var_3.blood_pool.origin + (0, 0, 28);
      }
    }

    if(isDefined(var_3.setlookatent) && var_3.setlookatent == "plate_bonus_room") {
      level.blood_plates["bonus"] = var_3;
      var_4 = var_1;
      var_4 = _sortbydistance(var_4, var_3.origin, 150);

      if(isDefined(var_4[0])) {
        var_3.blood_pool = var_4[0];
        var_3.blood_pool.min_pos = var_3.blood_pool.origin;
        var_3.blood_pool.max_pos = var_3.blood_pool.origin + (0, 0, 28);
      }
    }

    if(isDefined(var_3.setlookatent) && var_3.setlookatent == "plate_shelf") {
      level.blood_plates["shelf"] = var_3;
      var_4 = var_1;
      var_4 = _sortbydistance(var_4, var_3.origin, 150);

      if(isDefined(var_4[0])) {
        var_3.blood_pool = var_4[0];
        var_3.blood_pool.min_pos = var_3.blood_pool.origin;
        var_3.blood_pool.max_pos = var_3.blood_pool.origin + (0, 0, 28);
      }
    }
  }

  foreach(var_8, var_7 in level.blood_plates)
  var_7 setup_blood_plates(var_8);

  level thread maps\mp\_utility::_id_6F74(::pressure_plate_player_listen, level.blood_plates);
}

setup_blood_plates(var_0) {
  var_1 = self;

  if(isDefined(self.blood_pool))
    var_1.blood_pool moveto(var_1.blood_pool.origin + (0, 0, 30), 0.05);

  var_2 = "flag_plate_filled_" + var_0;
  var_3 = "flag_plate_pressed_" + var_0;
  common_scripts\utility::flag_init(var_2);
  common_scripts\utility::flag_init(var_3);
  var_1.blood_health = 0;
  var_1.blood_health_max = 100;
  var_1._id_00D4 = var_0;
  var_1.death_ping = "dig_blood_plate_ping" + var_0;
  var_1.filled_flagname = var_2;
  var_1.pressed_flagname = var_3;
  var_1.plate_name = var_1.setlookatent;
  var_1.kill_count = 0;
  var_1.plate_failsafe_nodes = [];
  var_1.souls_max = 30;

  if(var_1 == level.blood_plates["first_door"] || var_1 == level.blood_plates["trial"])
    var_1.souls_max = 5;

  if(var_1 == level.blood_plates["shelf"])
    var_1.souls_max = 6;

  var_4 = common_scripts\utility::_id_44BE(var_1.target, "targetname");

  foreach(var_6 in var_4) {
    var_7 = var_6._id_0165;

    if(!isDefined(var_7)) {
      continue;
    }
    switch (var_7) {
      case "plate_clip":
        var_1.plate_clip = var_6;
        var_1.plate_clip._id_A045 = ::blood_plate_unresolved_collide;
        var_1.plate_clip.my_plate_struct = var_1;
        break;
      case "plate_failsafe_node":
        var_1.plate_failsafe_nodes = common_scripts\utility::_id_0F6F(var_1.plate_failsafe_nodes, var_6);
        break;
      case "plate_model":
        var_1.plate_model = var_6;
        var_1.model_start_origin = var_6.origin;
        break;
      case "plate_trig":
        var_1.plate_trig = var_6;
        var_1.plate_trig.associated_struct = var_1;
        break;
      case "plate_damage_trig":
        var_1.plate_damage_trig = var_6;
        break;
      case "plate_hit_clip":
        var_6 notsolid();
        var_1.plate_hit_clip = var_6;
        break;
      case "plate_center_trig":
        var_1.plate_center_trig = var_6;
        break;
    }
  }

  var_1.plate_model.disable_end_sound = 1;
  var_1.plate_model.disable_auto_deregister = 1;
  var_1.isbloodempty = 1;
  var_1.isbloodfull = 0;
  var_1.souls_current = 0;
  var_1 common_scripts\utility::_id_3799("plate_reserved");
  var_1 thread blood_fill_think();
}

blood_fill_think() {
  var_0 = self;
  var_0 thread blood_state_think();

  for(;;) {
    var_0 waittill("blood_status_updated");

    if(_id_0547::_id_5565(var_0.isbloodfull, 0))
      var_0 plate_enable_blood_collect();

    if(_id_0547::_id_5565(var_0.isbloodfull, 1)) {
      while(var_0.isbloodfull == 1)
        waitframe();

      if(var_0 common_scripts\utility::_id_3794("plate_reserved"))
        var_0 common_scripts\utility::_id_37A1("plate_reserved");
    }
  }
}

blood_state_think() {
  var_0 = self;

  while(isDefined(var_0)) {
    var_1 = var_0 get_blood_fill_frac();

    if(var_1 >= 1) {
      var_0.isbloodfull = 1;
      var_0.isbloodempty = 0;
      var_0 thread play_fx_blood_full();
    } else if(1 < var_1 > 0) {
      var_0.isbloodfull = 0;
      var_0.isbloodempty = 0;
      var_0 thread delete_fx_blood_full();
    } else {
      var_0.isbloodfull = 0;
      var_0.isbloodempty = 1;
      var_0 thread delete_fx_blood_full();
    }

    if(isDefined(self.blood_pool))
      thread blood_move_gutters(var_1);

    var_0 notify("blood_status_updated");
    waitframe();
  }
}

get_blood_fill_frac() {
  var_0 = self;

  if(!isDefined(var_0.souls_current))
    var_1 = 0;
  else
    var_1 = var_0.souls_current / var_0.souls_max;

  if(var_1 >= 1)
    var_1 = 1;

  return var_1;
}

blood_move_gutters(var_0) {
  if(_id_0547::_id_5565(self.blood_pool.old_frac, var_0)) {
    return;
  }
  self.blood_pool moveto(self.blood_pool.min_pos + (0, 0, 28 * var_0), 0.05);
  self.blood_pool.old_frac = var_0;
}

plate_enable_blood_collect() {
  plate_blood_collect_think();

  if(isDefined(self.collector)) {
    self.collector._id_AC2C = 0;
    self.collector._id_AC2D = self.collector._id_AC2C;
    level notify(self.collector._id_695B);
  }
}

play_fx_blood_full() {
  if(isDefined(self.blood_full_fx)) {
    return;
  }
  self.blood_full_fx = _spawnlinkedfx(common_scripts\utility::_id_44F5("dlc_zmb_dec_blood_plates_full"), self.plate_model, "TAG_ORIGIN");
  _triggerfx(self.blood_full_fx);
  self.blood_full_fx _id_0378::_id_8D74("aud_blood_plate_full_lp");
}

delete_fx_blood_full() {
  if(!isDefined(self.blood_full_fx)) {
    return;
  }
  self.blood_full_fx delete();
}

plate_blood_collect_think() {
  var_0 = self;
  var_0 endon("blood_drain");
  var_0 endon("blood_empty");
  var_0.onzombiesacrificedfunc = ::on_zombie_soul_collected_func;
  var_0.optionaldisablearclightning = 1;
  var_0 thread maps\mp\mp_zombies_soul_collection::beginazombiesoulcollectionobjectiveonstruct(var_0.souls_max, 300, 60, "plate_blood_collect_" + var_0._id_00D4, undefined, "TAG_ORIGIN", undefined, "TAG_ORIGIN", undefined, var_0.plate_model, (0, 0, 16), undefined, 1);

  while(var_0.isbloodfull != 1)
    waitframe();

  var_0 notify("blood_plate_full");
}

get_full_boss_blood_plates() {
  var_0 = [];

  foreach(var_2 in level.blood_plates) {
    if(common_scripts\utility::_id_562E(var_2.isbloodfull) && _id_0547::_id_5565(var_2.setlookatent, "plate_boss_room"))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

get_not_full_boss_blood_plates() {
  var_0 = [];

  foreach(var_2 in level.blood_plates) {
    if(!common_scripts\utility::_id_562E(var_2.isbloodfull) && _id_0547::_id_5565(var_2.setlookatent, "plate_boss_room"))
      var_0[var_0.size] = var_2;
  }

  return var_0;
}

_id_A752(var_0, var_1) {
  self endon(var_0);
  wait(var_1);
}

blood_plate_boss_reserve(var_0) {
  var_1 = self;
  var_1 common_scripts\utility::_id_379A("plate_reserved");

  if(isDefined(var_0))
    var_1 thread blood_plate_reserved_fx(var_0);

  var_1 _id_A752("release_plate", 25);
  var_1 blood_plate_boss_release();
}

blood_plate_boss_release() {
  var_0 = self;
  var_0 common_scripts\utility::_id_3796("plate_reserved");
}

blood_plate_reserved_fx(var_0) {
  var_1 = self;
  var_2 = _func_382("zmb_geistkraft_blood_beam_med", var_1.plate_model, "TAG_ORIGIN", var_0, "TAG_WEAPON_RIGHT");
  var_3 = _func_382("zmb_geistkraft_blood_beam_med", var_1.plate_model, "TAG_ORIGIN", var_0, "j_elbow_le");
  var_4 = _func_382("zmb_geistkraft_blood_beam_med", var_1.plate_model, "TAG_ORIGIN", var_0, "j_elbow_ri");
  var_5 = undefined;

  if(_id_0547::_id_5565(level.zombie_king, var_0)) {
    var_5 = _spawnlinkedfx(common_scripts\utility::_id_44F5("dlc_zmb_dec_blood_plates_fullb"), self.plate_model, "TAG_ORIGIN");
    _triggerfx(var_5);
  }

  while(var_1 common_scripts\utility::_id_3794("plate_reserved"))
    waitframe();

  var_2 delete();
  var_3 delete();
  var_4 delete();

  if(isDefined(var_5))
    var_5 delete();
}

blood_plate_subtract() {
  self notify("blood_drain");
  self.souls_current = self.souls_current - 1;

  if(self.souls_current < 0)
    self.souls_current = 0;
}

blood_plate_empty() {
  self notify("blood_empty");
  self.souls_current = 0;
}

blood_plate_empty_first_door() {
  self.souls_max = 30;
  self notify("blood_empty");
  self.souls_current = 0;
}

blood_plate_unresolved_collide(var_0) {
  self._id_A048 = blood_plate_get_unresolved_collision_locs(self.my_plate_struct, var_0);
  _id_0488::_id_A047(var_0, 0);
}

blood_plate_get_unresolved_collision_locs(var_0, var_1) {
  var_2 = [];

  if(isDefined(var_0))
    var_2[var_2.size] = var_0;

  if(isDefined(var_0.plate_failsafe_nodes) && _isarray(var_0.plate_failsafe_nodes))
    var_2 = common_scripts\utility::_id_0F73(var_2, var_0.plate_failsafe_nodes);

  if(isDefined(level._id_9068._id_9090) && _isarray(level._id_9068._id_9090))
    var_2 = common_scripts\utility::_id_0F73(var_2, level._id_9068._id_9090);

  return var_2;
}

on_zombie_soul_collected_func(var_0) {
  if(!isDefined(level.blood_plate_zombie_souls_on_field))
    level.blood_plate_zombie_souls_on_field = 0;

  plate_souls_incriment(var_0.origin);

  if(level.blood_plate_zombie_souls_on_field < level.zmb_max_soul_collection_beams)
    thread blood_plate_soul_fx(var_0);

  maps\mp\mp_zombies_soul_collection::try_play_scripted_soul_suck_anim("scripted_blood_plate");
}

plate_souls_incriment(var_0) {
  var_1 = common_scripts\utility::_id_4461(var_0, level.blood_plates, 325);

  if(!isDefined(var_1)) {
    return;
  }
  if(!_id_0547::_id_5565(var_1.isbloodfull, 1))
    var_1.souls_current = var_1.souls_current + 1;
}

blood_plate_soul_fx(var_0) {
  _id_0378::_id_8D74("aud_blood_plate_absorb", var_0);

  if(!isDefined(level.blood_plate_zombie_souls_on_field))
    level.blood_plate_zombie_souls_on_field = 0;

  self waittill("body_spawned", var_1);

  if(!isDefined(var_1)) {
    return;
  }
  if(!isDefined(var_0)) {
    return;
  }
  var_2 = var_0;
  var_3 = var_0._id_2E37;
  var_4 = var_0._id_2DA5;
  var_5 = var_0._id_2DA6;
  level.blood_plate_zombie_souls_on_field++;
  var_6 = _func_382("zmb_geistkraft_blood_beam_med", var_2, var_3, var_1, "j_neck");

  if(isDefined(var_4)) {
    var_7 = var_3;

    if(isDefined(var_5))
      var_7 = var_5;

    _playfxontag(level._effect[var_4], var_0, var_7);
  }

  wait 1;

  if(isDefined(var_6))
    var_6 delete();

  level.blood_plate_zombie_souls_on_field--;
}

pressure_plate_player_listen(var_0) {
  var_1 = self;
  var_1 endon("disconnect");
  level endon("disable_plate_movement");
  var_2 = [];

  foreach(var_4 in var_0)
  var_2 = common_scripts\utility::_id_0F6F(var_2, var_4.plate_trig);

  for(;;) {
    var_6 = undefined;
    var_4 = undefined;

    foreach(var_8 in var_2) {
      if(var_1 istouching(var_8))
        var_6 = var_8;
    }

    if(isDefined(var_6)) {
      var_4 = var_6.associated_struct;
      var_10 = 1;

      if(common_scripts\utility::_id_3C77(var_4.pressed_flagname))
        var_10 = 0;

      if(isDefined(var_4.pressing_player))
        var_10 = 0;

      if(common_scripts\utility::_id_562E(var_10)) {
        if(!_id_0547::_id_5565(var_1.pressed_plate, var_4))
          var_1.pressed_plate = var_4;

        var_4 thread pressure_plate_press(var_1);
      }
    } else {
      var_1.pressed_plate = undefined;

      foreach(var_8 in var_2) {
        var_4 = var_8.associated_struct;

        if(_id_0547::_id_5565(var_4.pressing_player, var_1))
          var_4 thread pressure_plate_release();
      }
    }

    waitframe();
  }
}

pressure_plate_press(var_0) {
  var_1 = self;

  if(isDefined(var_0))
    var_1.pressing_player = var_0;

  common_scripts\utility::flag_set(var_1.pressed_flagname);
  level notify("plate_pressed", var_1.plate_name);
  _id_0378::_id_8D74("aud_blood_plate_press", var_1.plate_model);
  var_1.plate_model moveto(var_1.model_start_origin + (0, 0, -5), 1, 0.25, 0.25);
  wait 1;
}

pressure_plate_release() {
  var_0 = self;
  var_0.pressing_player = undefined;
  common_scripts\utility::_id_3C7B(var_0.pressed_flagname);
  level notify("plate_unpressed", var_0.plate_name);
  _id_0378::_id_8D74("aud_blood_plate_release", var_0.plate_model);
  var_0.plate_model moveto(var_0.model_start_origin, 1, 0.25, 0.25);
  wait 1;
}

init_ice_blocks() {
  level.ice_blocks = getEntArray("org_ice_block", "targetname");

  foreach(var_1 in level.ice_blocks) {
    var_1.is_ice_block = 1;
    var_1.ice_health = 100;
    var_1.drop_distance = 112;
    var_2 = getEntArray(var_1.target, "targetname");

    foreach(var_4 in var_2) {
      switch (var_4._id_0165) {
        case "mdl_ice_block":
          var_1.mdl = var_4;
          break;
        case "mdl_ice_block_broken":
          var_1.mdl_broke = var_4;
          var_4 hide();
          break;
        case "clip_ice_block":
          var_1._id_241F = var_4;
          break;
        case "clip_ice_block_broke":
          var_4 notsolid();
          var_1.clip_broke = var_4;
          break;
        case "trig_damage_check":
          var_1.damage_trig = var_4;
          var_5 = var_4 getpointinbounds(0, 0, -1);
          var_6 = var_4 getpointinbounds(1, 1, 1);
          var_1._id_8302 = var_6[2] - var_5[2];
          var_1._id_8303 = _distance2d(var_5, var_6);
        default:
          break;
      }
    }
  }
}

setup_text_log_reveals() {
  var_0 = getEntArray("lore_primary", "script_noteworthy");
  common_scripts\utility::flag_init("flag_force_log_reveal");

  foreach(var_2 in var_0) {
    var_3 = getEntArray(var_2.target, "targetname");
    var_2.trigs = var_3;
    var_4 = _func_337(var_2.setlookatent, "lore");
    common_scripts\utility::flag_init("flag_log_reveal_" + var_4);
    var_2 thread text_log_reveal_think("flag_log_reveal_" + var_4);
  }
}

text_log_reveal_think(var_0) {
  if(_id_0547::_id_5565(self.setlookatent, "lore31")) {
    return;
  }
  level thread maps\mp\_utility::_id_6F74(::text_log_disable, self);

  if(_id_0547::_id_5565(self.setlookatent, "lore32")) {
    common_scripts\utility::_id_3CA2("flag_boss_complete", "flag_force_log_reveal");
    level thread maps\mp\_utility::_id_6F74(::text_log_enable, self);
    return;
  } else {
    common_scripts\utility::_id_3CA2(var_0, "flag_force_log_reveal", "flag_boss_complete");
    thread text_log_enable_when_unseen();
  }
}

text_log_enable_when_unseen() {
  for(;;) {
    var_0 = 0;

    foreach(var_2 in level.players) {
      if(text_log_player_near_or_looking(var_2, self))
        var_0 = 1;
    }

    if(!var_0) {
      break;
    } else
      wait 5;
  }

  var_4 = self.trigs[0]._id_5F13;
  var_5 = var_4._id_24D2;
  level thread maps\mp\_utility::_id_6F74(::text_log_enable, self);
}

text_log_player_near_or_looking(var_0, var_1) {
  var_2 = distancesquared(var_0.origin, var_1.origin);

  if(var_2 < 16384)
    return 1;

  if(var_2 > 250000)
    return 0;

  if(!_sighttracepassed(var_0.origin, var_1.origin, 0, var_1, var_0))
    return 0;

  var_3 = var_0 getEye();
  var_4 = var_0 _meth_8566();
  var_5 = anglesToForward(var_4);
  var_6 = vectorNormalize(var_1.origin - var_3);

  if(vectordot(var_5, var_6) > 0.766)
    return 1;
  else
    return 0;
}

text_log_enable(var_0) {
  var_0.trigs[0] common_scripts\utility::_id_9DA3();
  _id_054F::_id_5F11(var_0.trigs[0]);
}

text_log_disable(var_0) {
  var_0.trigs[0] common_scripts\utility::_id_9D9F();
  var_0 hide();
}

handle_door_orb_blockers() {
  while(!isDefined(level._id_AC1D))
    waitframe();

  var_0 = getEntArray("door_orb_blocker", "targetname");

  foreach(var_2 in var_0)
  var_2 thread door_orb_blocker_wait_for_door_open(var_2._id_0165);
}

door_orb_blocker_wait_for_door_open(var_0) {
  if(!isDefined(var_0))
    self delete();

  common_scripts\utility::_id_3C9F(var_0);
  self delete();
}

spawn_ice_breakers_on_door_open() {
  _id_0547::_id_A6F6();
  var_0 = _id_053F::_id_44A6("flag_limbo_to_cave_1");
  var_0 waittill("scriptable_door_open");
  level.ice_breaker_sacrifices = [];
  var_1 = common_scripts\utility::_id_46B7("zone_cave_spawners_ce_reveal", "targetname");

  foreach(var_3 in var_1) {
    var_4 = _id_054D::_id_90BA("zombie_generic", var_3, "zombie ce spawn", 1, 1, 1);
    var_4 _id_0547::disableoffhandsecondaryweapons();
    level.ice_breaker_sacrifices = common_scripts\utility::_id_0F6F(level.ice_breaker_sacrifices, var_4);
  }

  var_6 = common_scripts\utility::_id_4461(var_1[0].origin, level.players);

  if(isPlayer(var_6))
    var_6 maps\mp\_utility::_id_2CED(4, maps\mp\mp_zombie_descent_utils::vo_see_corpse_eater);

  wait 0.5;
  spawn_ice_breakers();
}

player_trial_vision_test() {
  foreach(var_1 in level.players) {
    var_1 thread maps\mp\mp_zombie_descent_ee_main::run_weapon_trial_vision();
    var_1.istrialvisiontest = 1;
    var_1 thread disable_trial_vision_test();
  }
}

disable_trial_vision_test() {
  wait 10;
  self.istrialvisiontest = undefined;
}

spawn_ice_breakers(var_0) {
  var_1 = getEntArray("org_ice_block_scripted", "targetname");

  foreach(var_3 in var_1) {
    var_4 = getEntArray(var_3.target, "targetname");

    foreach(var_6 in var_4) {
      switch (var_6._id_0165) {
        case "mdl_ice_block":
          var_3.mdl = var_6;
          break;
        case "mdl_ice_block_broken":
          var_3.mdl_broke = var_6;
          var_6 hide();
          break;
        case "clip_ice_block":
          var_3._id_241F = var_6;
          break;
        case "clip_ice_block_broke":
          var_6 notsolid();
          var_3.clip_broke = var_6;
          break;
        default:
          break;
      }
    }
  }

  var_9 = common_scripts\utility::_id_46B5("spawn_cave_ice_breaker_main", "targetname");
  var_10 = _id_054D::_id_90BA("zombie_dlc4", var_9, "corpse_eater", 0, 1, 0);
  maps\mp\_utility::_id_2CED(0.5, ::spawn_ice_breaker_ice, var_10);
  var_10.startcorpseeater = 1;
  var_10.cenerfedexplosion = 1;
  wait 0.5;
  playFX(level._effect["zmb_desc_ice_falling"], var_9.origin);

  if(level.players.size >= 3 || common_scripts\utility::_id_562E(var_0)) {
    var_11 = common_scripts\utility::_id_46B5("spawn_cave_ice_breaker_main_2", "targetname");
    var_12 = _id_054D::_id_90BA("zombie_dlc4", var_11, "corpse_eater", 0, 1, 0);
    maps\mp\_utility::_id_2CED(0.15, ::spawn_ice_breaker_ice, var_12);
    var_12.startcorpseeater = 1;
  }

  wait 0.25;

  if(level.players.size >= 4 || common_scripts\utility::_id_562E(var_0)) {
    var_13 = common_scripts\utility::_id_46B5("spawn_cave_ice_breaker_main_3", "targetname");
    var_14 = _id_054D::_id_90BA("zombie_dlc4", var_13, "corpse_eater", 0, 1, 0);
    thread spawn_ice_breaker_ice(var_14);
    var_14.startcorpseeater = 1;

    foreach(var_3 in var_1)
    var_3 maps\mp\mp_zombie_descent_ee_main::ice_block_break();
  }
}

spawn_ice_breaker_ice(var_0) {
  playFX(common_scripts\utility::_id_44F5("ice_destruct_chunk"), var_0.origin, anglesToForward(var_0.angles), anglestoup(var_0.angles));
}

on_game_start_descent() {
  maps\mp\zombies\zombie_sizzler::init();
  maps\mp\zombies\zombie_corpse_eater::init();
  maps\mp\zombies\zombie_king::init();
  thread maps\mp\mp_zombie_descent_utils::initwavestories();
  thread traps_init();
  level.roundstartfuncgeneric = ::descent_round_start;
  level.roundendfuncgeneric = ::descent_round_end;
  _id_0548::_id_7CEA("stg44_zm");
  _id_0548::_id_7CEA("svt40_zm");
  _id_0548::_id_7CEA("greasegun_zm");
  _id_0548::_id_7CEA("svt40_zm");
  _id_0548::_id_7CEA("mp40_zm");
  _id_0548::_id_7CEA("mp28_zm");
  _id_0548::_id_7CEA("fg42_zm");
  _id_0548::_id_7CEA("ppsh41_zm");
}

descent_round_start() {}

descent_round_end() {
  thread descent_attempt_wave_story();

  if(level._id_A980 >= 3)
    common_scripts\utility::flag_set("flag_log_reveal_24");

  if(level._id_A980 >= 5)
    common_scripts\utility::flag_set("flag_log_reveal_25");

  if(level._id_A980 >= 7)
    common_scripts\utility::flag_set("flag_log_reveal_26");

  if(level._id_A980 >= 9)
    common_scripts\utility::flag_set("flag_log_reveal_27");

  if(level._id_A980 >= 11)
    common_scripts\utility::flag_set("flag_log_reveal_28");

  if(level._id_A980 >= 13)
    common_scripts\utility::flag_set("flag_log_reveal_29");

  if(level._id_A980 >= 15)
    common_scripts\utility::flag_set("flag_log_reveal_30");
}

descent_attempt_wave_story() {
  wait(_randomintrange(1, 3));

  if(level._id_A980 >= 3 && !common_scripts\utility::_id_562E(level.has_played_radio_convo_1) && common_scripts\utility::_id_562E(maps\mp\mp_zombie_descent_utils::vo_can_play_radio_convo()))
    level thread maps\mp\mp_zombie_descent_utils::vo_radio_convo_map_start();
  else if(common_scripts\utility::_id_24A6()) {
    if(!common_scripts\utility::_id_562E(level.bossceremonyactive))
      level thread maps\mp\zombies\_zombies_audio_dlc2::playnextwavestory();
  }
}

initprecache() {
  _precacherumble("damage_heavy");
}

initdescentweapons() {
  thread _id_057D::_id_5162();
  level thread _id_0580::init();
  maps\mp\zombies\weapons\_zombie_dlc4_melee::init();
  maps\mp\mp_zombie_descent_utils::vo_init_weapon_whispers();
}

_id_5375() {
  _id_055A::init();
  _id_055A::_id_530A("zone_crash", 1);
  _id_055A::_id_530A("zone_cave");
  _id_055A::_id_530A("zone_archives");
  _id_055A::_id_530A("zone_archives_closet");
  _id_055A::_id_530A("zone_archives_basement");
  _id_055A::_id_530A("zone_bridge");
  _id_055A::_id_530A("zone_storage");
  _id_055A::_id_530A("zone_gallery");
  _id_055A::_id_530A("zone_alter");
  _id_055A::_id_530A("zone_citadel");
  _id_055A::_id_530A("zone_lost", 1, 0);
  _id_055A::_id_530A("zone_trials_d", 1, 0);
  _id_055A::_id_530A("zone_trials_b", 1, 0);
  _id_055A::_id_530A("zone_trials_s", 1, 0);
  _id_055A::_id_530A("zone_trials_m", 1, 0);
  _id_055A::_id_530A("zone_sewers", 1, 0);
  _id_055A::_id_0993("zone_crash", "zone_cave", "flag_limbo_to_cave_1");
  _id_055A::_id_0993("zone_cave", "zone_archives", "flag_cave_to_archives_1");
  _id_055A::_id_0993("zone_cave", "zone_storage", "flag_cave_to_storage_1");
  _id_055A::_id_0993("zone_archives", "zone_archives_closet", "flag_archives_to_closet_1");
  _id_055A::_id_0993("zone_archives", "zone_archives_basement", "flag_archives_to_basement_1");
  _id_055A::_id_0993("zone_archives_closet", "zone_archives_basement", "flag_closet_to_basement_1");
  _id_055A::_id_0993("zone_archives", "zone_bridge", "flag_archives_to_bridge_1");
  _id_055A::_id_0993("zone_storage", "zone_bridge", "flag_storage_to_bridge_1");
  _id_055A::_id_0993("zone_gallery", "zone_storage", "flag_gallery_to_storage_1");
  _id_055A::_id_0993("zone_gallery", "zone_alter", "flag_gallery_to_alter_1");
  _id_055A::_id_0993("zone_gallery", "zone_bridge", "flag_gallery_to_bridge_1");
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_CRASH", "flag_limbo_to_cave_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_CAVES", "flag_limbo_to_cave_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_CAVES", "flag_cave_to_archives_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_cave_to_archives_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_CAVES", "flag_cave_to_storage_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_STORAGE", "flag_cave_to_storage_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_CLOSET", "flag_archives_to_closet_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_archives_to_closet_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_archives_to_basement_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_BASEMENT", "flag_archives_to_basement_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_BASEMENT", "flag_closet_to_basement_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_CLOSET", "flag_closet_to_basement_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_archives_to_basement_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_BASEMENT", "flag_archives_to_basement_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_ARCHIVES", "flag_archives_to_bridge_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_BRIDGE", "flag_archives_to_bridge_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_STORAGE", "flag_gallery_to_storage_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_GALLERY", "flag_gallery_to_storage_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_GALLERY", "flag_gallery_to_alter_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_ALTER", "flag_gallery_to_alter_1", 1);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_BRIDGE", "flag_gallery_to_bridge_1", 0);
  _id_053F::_id_7BE6(&"ZOMBIE_DLC4_AREA_GALLERY", "flag_gallery_to_bridge_1", 1);
  _id_055A::_id_088A();
}

hack_swap_basement_cloest_door_flag() {
  var_0 = undefined;
  var_1 = [];
  var_2 = [];
  var_3 = "flag_archives_to_basement_1";
  var_4 = (820, -116, 1388);
  var_5 = undefined;
  var_1 = common_scripts\utility::_id_46B7("door", "targetname");
  var_6 = [];

  foreach(var_8 in var_1) {
    if(_id_0547::_id_5565(var_8.getnegotiationnextnode, var_3))
      var_2[var_2.size] = var_8;
  }

  foreach(var_8 in var_2) {
    if(distance(var_4, var_8.origin) < 150) {
      var_5 = var_8;
      var_6 = getEntArray(var_8.target, "targetname");
    }
  }

  if(isDefined(var_5)) {
    var_5.getnegotiationnextnode = "flag_closet_to_basement_1";

    foreach(var_13 in var_6)
    var_13.getnegotiationnextnode = "flag_closet_to_basement_1";
  }
}

_id_5339() {
  _id_0557::_id_786C();
  maps\mp\mp_zombie_descent_ee_main::init();
  maps\mp\mp_zombie_descent_ee_side::init();
  maps\mp\mp_zombie_descent_ee_boss_fight::init();
  thread initquestnotebook();
}

initflags() {
  common_scripts\utility::flag_init("flag_boss_complete");
  common_scripts\utility::flag_init("flag_radio_picked_up");
  common_scripts\utility::flag_init("flag_blood_pool_0");
  common_scripts\utility::flag_init("flag_blood_pool_1");
  common_scripts\utility::flag_init("flag_blood_pool_2");
}

initquestnotebook() {
  var_0 = [_id_0557::_id_7838("quest_firstdoor", "quest_firstdoor_bloodpool"), _id_0557::_id_7838("quest_pap", "quest_pap_1"), _id_0557::_id_7838("quest_deathraven", "quest_deathraven_activate_rush"), _id_0557::_id_7838("quest_deathraven", "quest_deathraven_pickup_weap"), "deathraven_spine_collected", "deathraven_metal_collected", _id_0557::_id_7838("quest_deathraven", "quest_deathraven_assemble_weap"), _id_0557::_id_7838("quest_deathraven", "quest_deathraven_fuse_weap"), _id_0557::_id_7838("quest_deathraven", "quest_deathraven_enter_trial"), "flag_blood_pool_0", "flag_blood_pool_1", "stopper_collected", "flag_blood_pool_2", _id_0557::_id_7838("quest_bloodraven", "quest_bloodraven_acquire_sheild"), "flag_radio_picked_up", _id_0557::_id_7838("quest_bloodraven", "quest_bloodraven_complete_trial"), "flag_stormraven_stopper_1_collected", "flag_stormraven_stopper_2_collected", "flag_stormraven_stopper_3_collected", "flag_stormraven_stopper_4_collected", "flag_stormraven_stoppers_placed", "flag_stormraven_runes_charged", "flag_stormraven_hammer_picked_up", "flag_stormraven_charge_puzzle_activated", "flag_stormraven_charge_puzzle_stage_three_complete", _id_0557::_id_7838("quest_stormraven", "step_stormraven_trial"), "moonraven_key_collected_01", "moonraven_key_collected_02", _id_0557::_id_7838("quest_moonraven", "quest_moonraven_reveal_chart"), "flag_gears_collected_1", "flag_gears_collected_2", "flag_gears_collected_3", "moonraven_gears_all_placed", _id_0557::_id_7838("quest_moonraven", "quest_moonraven_power_orrery"), _id_0557::_id_7838("quest_moonraven", "quest_moonraven_acquire_scepter"), "moon_constellation_1_complete", "moon_constellation_2_complete", "moon_constellation_3_complete", _id_0557::_id_7838("quest_moonraven", "quest_moonraven_unlock_trial"), _id_0557::_id_7838("quest_moonraven", "quest_moonraven_enter_trial"), "flag_plinth_all_weapons_placed", _id_0557::_id_7838("quest_bossfight", "quest_bossfight_start")];

  for(var_1 = 0; !all_flags_exist(var_0); var_1++)
    waitframe();

  foreach(var_3 in var_0)
  _id_0557::_id_AB8C(var_3);
}

all_flags_exist(var_0) {
  foreach(var_2 in var_0) {
    if(!common_scripts\utility::_id_3C83(var_2))
      return 0;
  }

  return 1;
}

__________________traps__________________() {}

traps_init() {
  thread trap_archives_spikes();
}

trap_archives_spikes() {
  level._id_9CFB = 1;
  level._id_62B5 = 1;
  level._effect["trap_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_small");
  level._effect["trap_not_ready"] = loadfx("vfx/zombie/zmb_trap_light_orange_blink_small");
  level._id_9CD1["ready_to_active"] = undefined;
  level._id_9CD1["active_to_cooldown"] = undefined;
  level._id_9CD1["cooldown_to_active"] = undefined;
  var_0 = common_scripts\utility::_id_46B5("trap_archives_spikes", "script_noteworthy");
  thread _id_0546::_id_9CC6("trap_archives_spikes", "active", ::trap_archives_spikes_run);
}

trap_archives_spikes_run(var_0) {
  level.traparchivespikes = var_0 common_scripts\utility::_id_8FFC();
  level.traparchivespikes._id_9CBB = "trap_archives_spikes";
  level.traparchivespikes._id_9C92 = var_0;
  var_0 trap_archives_spikes_handle_damage();
  var_0._id_565F = 0;
}

trap_archives_spikes_handle_damage() {
  self._id_565F = 1;
  thread trap_archives_spikes_check_for_end();
  var_0 = common_scripts\utility::_id_46B7("archives_spike_trap_fx_point", "script_noteworthy");
  var_1 = [];

  foreach(var_3 in var_0) {
    var_4 = _id_0547::_id_9470(var_3.setlookatent);
    var_1[var_4] = var_3;
  }

  while(self._id_565F) {
    for(var_6 = 0; var_6 < var_1.size; var_6++) {
      var_7 = _spawnfx(common_scripts\utility::_id_44F5("spikeTrap"), var_1[var_6].origin, anglesToForward(var_1[var_6].angles));
      _triggerfx(var_7);
      thread trap_archives_spikes_damage_zombies(var_1[var_6]);
      thread trap_archives_spikes_damage_players(var_1[var_6]);
      _id_0378::_id_8D74("aud_trap_spikes", var_1[var_6]);
      wait 0.5;
      var_7 delete();
    }

    for(var_6 = var_1.size - 1; var_6 >= 0; var_6--) {
      var_7 = _spawnfx(common_scripts\utility::_id_44F5("spikeTrap"), var_1[var_6].origin, anglesToForward(var_1[var_6].angles));
      _triggerfx(var_7);
      thread trap_archives_spikes_damage_zombies(var_1[var_6]);
      thread trap_archives_spikes_damage_players(var_1[var_6]);
      _id_0378::_id_8D74("aud_trap_spikes", var_1[var_6]);
      wait 0.5;
      var_7 delete();
    }

    waitframe();
  }
}

trap_archives_spikes_check_for_end() {
  common_scripts\utility::_id_A70A("cooldown", "no_power", "ready", "deactivate");
  self._id_565F = 0;
}

trap_archives_spikes_damage_zombies(var_0) {
  var_1 = _id_0547::_id_408F();

  foreach(var_3 in var_1) {
    var_4 = _distance2d(var_3.origin, var_0.origin);

    if(var_4 < 100 && var_3.origin[2] < self.origin[2]) {
      if(isalive(var_3) && var_3._id_0BA4 != "traverse") {
        if(var_3 _id_0547::_id_580A()) {
          var_3 dodamage(var_3.health * 0.1, self.origin, level.traparchivespikes, level.traparchivespikes, "MOD_EXPLOSIVE", "trap_zm_mp");
          continue;
        }

        var_3 dodamage(var_3.health + 666, self.origin, level.traparchivespikes, level.traparchivespikes, "MOD_EXPLOSIVE", "trap_zm_mp");

        if(!isDefined(var_3.hitbytrap)) {
          foreach(var_6 in level.players) {
            var_6 maps\mp\gametypes\zombies::_id_47C7("kill_trap");
            var_3.hitbytrap = 1;
          }
        }
      }
    }
  }
}

trap_archives_spikes_damage_players(var_0) {
  var_1 = level.players;

  foreach(var_3 in var_1) {
    if(!isalive(var_3)) {
      continue;
    }
    if(_id_0547::_id_577E(var_3)) {
      continue;
    }
    var_4 = _distance2d(var_3.origin, var_0.origin);

    if(var_4 < 100 && var_3.origin[2] < self.origin[2]) {
      if(isalive(var_3) && !_id_0547::_id_577E(var_3))
        var_3 dodamage(5, self.origin, undefined, undefined, "MOD_CRUSH");
    }
  }
}

door_death_fix() {
  while(!isDefined(level._id_AC1D))
    waitframe();

  add_zombie_door_collision_handling("flag_gallery_to_bridge_1", 1, 1);
}

add_zombie_door_collision_handling(var_0, var_1, var_2) {
  var_3 = get_zombie_door(var_0);

  foreach(var_5 in var_3._id_64C5)
  var_3 thread assign_collision_handling(var_5, var_1, var_2);
}

get_zombie_door(var_0) {
  foreach(var_2 in level._id_AC1D) {
    if(_id_0547::_id_5565(var_2.getnegotiationnextnode, var_0))
      return var_2;
  }
}

assign_collision_handling(var_0, var_1, var_2) {
  var_0._id_A048 = [];
  var_3 = 2;

  foreach(var_5 in self.setclientdvars) {
    if(common_scripts\utility::_id_562E(var_1))
      var_0 assign_door_collision_node(var_5, 1);

    if(common_scripts\utility::_id_562E(var_2))
      var_0 assign_door_collision_node(var_5, 0);
  }

  var_0._id_A045 = ::zmd_door_collision_handler;
}

assign_door_collision_node(var_0, var_1) {
  var_2 = spawnStruct();
  var_2.origin = _func_2E1(var_0.origin + _pow(-1, !common_scripts\utility::_id_562E(var_1)) * 32 * vectorNormalize(anglestoright(var_0.angles)));
  self._id_A048 = common_scripts\utility::_id_0F6F(self._id_A048, var_2);
}

zmd_door_collision_handler(var_0) {
  _id_0488::_id_A047(var_0, 0);
}