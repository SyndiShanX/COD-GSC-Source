/*****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\maps\tunnels\zd30tunnels_mineshaft.gsc
*****************************************************/

precache_mineshaft() {
  precachemodel("weapon_wm_me_soscar_knife");
}

mines_setup() {
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::setup_mine_carts();
  level.mines_backtrack_trig = getEnt("mines_backtrack_trig", "targetname");
  level.mines_backtrack_clip = getEnt(level.mines_backtrack_trig.target, "targetname");
  level.mines_backtrack_clip.origin = level.mines_backtrack_clip.origin - (0, 0, 10000);
  level.mines_backtrack_clip connectpaths();
  var_0 = getEnt("mineshaft_shared_oilfire_grabber", "targetname");
  level.mineshaft_shared_oil_fire = undefined;
  var_1 = getEnt("mineshaft_martyr_oilfire_grabber", "targetname");
  level.mineshaft_martyr_oil_fire = undefined;

  foreach(var_3 in level.oil_fires) {
    if(var_0 istouching(var_3))
      level.mineshaft_shared_oil_fire = var_3;

    if(var_1 istouching(var_3))
      level.mineshaft_martyr_oil_fire = var_3;
  }

  if(isDefined(level.mineshaft_shared_oil_fire)) {
    level.mineshaft_shared_oil_fire scripts\engine\utility::trigger_off();
    level.mineshaft_shared_oil_fire thread mineshaft_shared_oil_fire_on();
  }
}

mine_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("mine", [level.player]);
  scripts\engine\utility::flag_set("shaft_split_vo_done");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::remove_hadir();
}

mine_catchup() {
  scripts\engine\utility::flag_set("mine_reached");
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_embassy_soccer_tv", 1);
  thread mines_second_collapse();
  thread mines_bridge_collapse();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::remove_hadir();
}

mine() {
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_embassy_soccer_tv", 1);
  level.player modifybasefov(level.fov_mine, 0.05);
  thread mines_push_cart_checkpoint();
  thread mines_bridge_collapse();
  thread mines_second_collapse();
  wait 2;
  hidemayhem("my_vfx_mayh_mines_bridge_zd30");
  waitframe();
  showmayhem("my_vfx_mayh_mines_bridge_zd30");
  thread hint_locked_doors_vo("hint_locked_door");
  thread hint_push_cart_vo();
  thread mines_oilpush_scene();
  thread mines_enter_vo();
}

mineshaft_shared_oil_fire_on() {
  level waittill("snake_fire_spread");
  scripts\engine\utility::trigger_on();
}

mines_enter_vo() {
  scripts\engine\utility::flag_wait("mine_reached");
  scripts\engine\utility::flag_wait("shaft_split_vo_done");
  var_0 = level.farah scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::time_since_spoke();
  var_1 = 2;

  if(isDefined(var_0) && var_0 < var_1)
    wait(var_1 - var_0);

  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_alx_tunnels_alone_10");
  level scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_pri_tunnels_intro_11");
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_alx_tunnels_alone_20");
  wait 0.2;
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_alx_tunnels_alone_30");
}

mines_push_cart_checkpoint() {
  while(!isDefined(level.mine_carts) || !isDefined(level.mine_carts["mine_cart_tutorial"]))
    wait 0.1;

  level.mine_carts["mine_cart_tutorial"] waittill("free_rolling");
  thread scripts\engine\sp\utility::autosave_now();
  clearallcorpses();
}

mines_bridge_collapse() {
  var_0 = getEnt("mines_bridge_collapse_oil_grabber", "targetname");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::monitor_oilfire(var_0);
  var_0 waittill("oilfire_detonated");
  scripts\engine\utility::flag_set("mines_bridge_collapsed");
  wait 2.5;
  playmayhem("my_vfx_mayh_mines_bridge_zd30");
}

mines_second_collapse() {
  var_0 = getEnt("mines_second_collapse_oil_grabber", "targetname");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::monitor_oilfire(var_0);
  var_0 waittill("oilfire_detonated");
  scripts\engine\utility::flag_set("mines_tunnel_collapsed");
  var_1 = getEnt("spawn_mine_responders", "targetname");

  if(isDefined(var_1))
    var_1 delete();

  level.mines_backtrack_trig waittill("trigger");
  level.mines_backtrack_clip.origin = level.mines_backtrack_clip.origin + (0, 0, 10000);
  level.mines_backtrack_clip disconnectPaths();
}

mines_player_pistol_upgrade_monitor() {
  for(;;) {
    var_0 = level.player getweaponslistall();

    if(var_0.size > 0) {
      foreach(var_2 in var_0) {
        if(var_2.basename == "iw8_pi_mike1911") {
          level.player takeweapon(var_2);
          var_2 = getcompleteweaponname("iw8_pi_mike1911", ["mag_mike1911", "rec_mike1911", "slide_tritium_mike1911"]);
          level.player giveweapon(var_2);
          level.player switchtoweapon(var_2);
          return;
        }
      }
    }

    wait 0.05;
  }
}

mines_oilpush_scene() {
  scripts\engine\utility::flag_wait("player_through_cart");
  var_0 = scripts\engine\utility::getStruct("shaft_fire_light_level_0", "targetname").origin;
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "shaft", var_0);
  var_1 = "mine_oilpush";
  var_2 = scripts\engine\utility::getStruct(var_1, "targetname");
  level.pusher1 = spawn_oil_pusher("pusher1");
  level.pusher2 = spawn_oil_pusher("pusher2");
  level.pusher2 thread mines_lantern_think();
  level.mine_push_barrel = scripts\engine\sp\utility::spawn_anim_model("mine_push_barrel", var_2.origin, var_2.angles);
  level.spewing_barrels[level.spewing_barrels.size] = level.mine_push_barrel;
  var_2 thread scripts\common\anim::anim_single_solo(level.mine_push_barrel, var_1);
  waitframe();
  level.mine_push_barrel setanimtime(level.mine_push_barrel scripts\engine\utility::getanim(var_1), 0.41);
  level.mine_push_barrel setanimrate(level.mine_push_barrel scripts\engine\utility::getanim(var_1), 0);
  var_3 = getEnt("mine_oilpush_trig", "targetname");
  var_4 = scripts\engine\utility::getStruct(var_3.target, "targetname");
  var_3 waittill("trigger");
  var_5 = 0;
  var_6 = 360;

  while(!scripts\engine\sp\utility::player_looking_at(var_4.origin, 0.8)) {
    if(scripts\engine\utility::flag("mines_tunnel_collapsed")) {
      level.pusher1 kill();
      level.pusher2 kill();
      level.mine_push_barrel delete();
      return;
    }

    if(scripts\engine\utility::distance_2d_squared(level.player.origin, var_4.origin) < var_6 * var_6) {
      break;
    }

    if(!isDefined(level.pusher1) || !isalive(level.pusher1)) {
      var_5 = 1;
      break;
    }

    if(!isDefined(level.pusher2) || !isalive(level.pusher2)) {
      var_5 = 1;
      break;
    }

    if(level.pusher1 hasenemybeenseen(50) || level.pusher2 hasenemybeenseen(50)) {
      break;
    }

    wait 0.05;
  }

  if(var_5) {
    return;
  }
  thread light_the_fire_vo();
  level.pusher1 thread oil_pusher1_anim(var_2, var_1);
  level.pusher2 thread oil_pusher2_anim(var_2, var_1);
  level.mine_push_barrel setanimrate(level.mine_push_barrel scripts\engine\utility::getanim(var_1), 1);
  level.mine_push_barrel waittillmatch("single anim", "end");
  var_7 = getEnt("mine_oilpush_gulg", "targetname");
  level.oil_gulgs[level.oil_gulgs.size] = var_7;
}

oil_pusher1_anim(var_0, var_1) {
  self endon("death");
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread oil_pusher1_post_anim_behavior();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say("dx_vom_aq1_tunnels_alone_120");
  self setanimrate(scripts\engine\utility::getanim(var_1), 1);
  self waittillmatch("single anim", "end");
  level notify("oilpush_done", 1);
}

oil_pusher1_post_anim_behavior() {
  self endon("death");
  thread oil_pusher_wakeup_think();
  level waittill("oilpush_done", var_0);

  if(!istrue(var_0))
    scripts\engine\sp\utility::anim_stopanimScripted();

  scripts\common\utility::demeanor_override("sprint");
  self setgoalentity(level.player, 50);
  scripts\engine\sp\utility::set_goal_radius(128);
  self.escape_now = 1;
}

oil_pusher2_anim(var_0, var_1) {
  self endon("death");
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread oil_pusher2_post_anim_behavior();
  var_2 = lookupsoundlength("dx_vom_aq1_tunnels_alone_120") / 1000;
  scripts\engine\utility::delaythread(1 + var_2, scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say, "dx_vom_aq2_tunnels_alone_130");
  self setanimrate(scripts\engine\utility::getanim(var_1), 1);
  self waittillmatch("single anim", "end");
  level notify("oilpush_done", 1);
}

oil_pusher2_post_anim_behavior() {
  self endon("death");
  thread oil_pusher_wakeup_think();
  thread oil_pusher2_martyr();
  thread oil_pusher2_escape();
  level waittill("oilpush_done", var_0);

  if(!istrue(var_0))
    scripts\engine\sp\utility::anim_stopanimScripted();

  scripts\engine\utility::delaythread(0.5, scripts\engine\sp\utility::smart_dialogue, "dx_vom_aq2_tunnels_ambusher_30");
  var_1 = getnode("pusher2_goto", "targetname");
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\sp\utility::set_goal_node(var_1);
  self getenemyinfo(level.player);
  self waittill("goal");
  wait 1;
  self notify("turn_off_lantern");
}

mines_lantern_think() {
  scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "turn_off_lantern");
  level scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "oil_fire_ignited");
  scripts\engine\sp\utility::do_wait_any();
  var_0 = scripts\engine\utility::getStruct("mines_lantern", "targetname");
  radiusdamage(var_0.origin, 4, 100, 99, level.player, "MOD_PISTOL_BULLET");
}

oil_pusher2_martyr() {
  level endon("shaft_fire_on");
  self waittill("death");
  var_0 = self gettagorigin("tag_accessory_left", 1);

  if(!isDefined(var_0))
    var_0 = self.origin + (0, 0, 20);

  var_1 = 1.5;
  var_2 = magicgrenademanual("frag", var_0, (0, 0, 0), var_1);
  wait(var_1);
  var_3 = getgroundposition(var_0, 4);

  if(isDefined(var_2) && isDefined(var_2.origin))
    var_3 = var_2.origin;

  playFX(level.g_effect["molotov_explosion"], var_3);
  wait 1.5;

  if(istrue(level.mineshaft_martyr_oil_fire.fire_exploder_on)) {
    return;
  }
  level.mineshaft_martyr_oil_fire thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::oilfire_run();
  level.mineshaft_martyr_oil_fire.oilfire_enabled = 0;
}

oil_pusher2_escape() {
  scripts\engine\utility::flag_wait("shaft_fire_on");

  if(!isDefined(self)) {
    return;
  }
  var_0 = self gettagorigin("tag_accessory_left", 1);

  if(!isDefined(var_0))
    var_0 = self.origin + (0, 0, 20);

  scripts\common\utility::demeanor_override("sprint");
  thread scripts\engine\sp\utility::set_goal_node_targetname("mines_escape_to");
  scripts\engine\sp\utility::set_goal_radius(32);
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::delete_when_dist_away(level.player, 800);
  var_1 = 3;
  var_2 = magicgrenademanual("frag", var_0, (0, 0, 0), var_1);
  wait(var_1);
  playFX(level.g_effect["molotov_explosion"], var_2.origin);
  wait 1.5;

  if(!istrue(level.mineshaft_martyr_oil_fire.fire_exploder_on)) {
    level.mineshaft_martyr_oil_fire thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::oilfire_run();
    level.mineshaft_martyr_oil_fire.oilfire_enabled = 0;
  }
}

oil_pusher_wakeup_think() {
  self endon("death");
  thread oil_pusher_wakeup_on_prox();

  if(!scripts\engine\utility::flag("mines_bridge_collapsed") && !scripts\engine\utility::flag("mines_tunnel_collapsed")) {
    scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittill_any, "bullethit", "grenade danger", "damage");
    scripts\engine\sp\utility::add_wait(scripts\engine\utility::waittill_any, "bulletwhizby", "wakeup_on_prox");
    level scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "mines_tunnel_collapsed");
    level scripts\engine\sp\utility::add_wait(scripts\engine\sp\utility::waittill_msg, "mines_bridge_collapsed");
    scripts\engine\sp\utility::do_wait_any();
  }

  wait 0.1;
  level notify("oilpush_done");

  if(!isDefined(level.mine_push_barrel)) {
    return;
  }
  var_0 = "mine_oilpush";
  var_1 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_2 = 0.52;
  var_3 = level.mine_push_barrel getanimtime(level.mine_push_barrel scripts\engine\utility::getanim(var_0), var_0);

  if(var_3 < var_2)
    level.mine_push_barrel stopanimScripted();
}

oil_pusher_wakeup_on_prox() {
  self endon("death");

  for(;;) {
    var_0 = distance2d(level.player.origin, self.origin);

    if(var_0 <= 350) {
      break;
    }

    if(var_0 <= 500) {
      if(self hasenemybeenseen(50)) {
        var_1 = 3;

        while(var_1 > 0) {
          if(scripts\engine\utility::distance_2d_squared(level.player.origin, self.origin) <= 115600) {
            break;
          }

          var_1 = var_1 - 0.05;
          wait 0.05;
        }

        break;
      }
    }

    wait 0.1;
  }

  self notify("wakeup_on_prox");
}

light_the_fire_vo() {
  scripts\engine\utility::flag_wait("entered_shaft");
  wait 1;
  var_0 = "dx_vom_aq1_tunnels_chamber_10";
  var_1 = lookupsoundlength(var_0) / 1000;
  var_2 = scripts\engine\utility::getStructArray("shaft_enemy_chatter", "targetname");
  var_3 = scripts\engine\utility::getclosest(level.player.origin, var_2).origin;
  scripts\engine\utility::play_sound_in_space(var_0, var_3);
  wait(var_1);
}

spawn_oil_pusher(var_0) {
  var_1 = scripts\engine\sp\utility::spawn_targetname(var_0 + "Spawner", 1);
  var_1.animname = var_0;
  var_1.allowdeath = 1;
  var_1.ignoreall = 1;
  var_1.ignoreme = 1;
  var_1 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
  var_1 thread scripts\engine\sp\utility::name_hide();
  var_1 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::shutup_when_hit();
  var_1 scripts\engine\sp\utility::disable_long_death();
  var_1 thread oil_pusher_drop_pistol();
  var_1 thread scripts\sp\nvg\nvg_ai::flashlight_on();
  var_2 = "mine_oilpush";
  var_3 = scripts\engine\utility::getStruct(var_2, "targetname");
  var_3 thread scripts\common\anim::anim_single_solo(var_1, var_2);
  waitframe();
  var_1 setanimtime(var_1 scripts\engine\utility::getanim(var_2), 0.41);
  var_1 setanimrate(var_1 scripts\engine\utility::getanim(var_2), 0);
  return var_1;
}

oil_pusher_drop_pistol() {
  self waittill("death");

  if(!scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_has_pistol())
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::enemy_force_pistol();
}

hint_push_cart_vo() {
  level endon("player_through_cart");
  level.mine_carts["mine_cart_tutorial"] endon("pushed");
  var_0 = getEnt("hint_mine_cart_push", "targetname");

  for(;;) {
    var_0 waittill("trigger");
    var_1 = 500;
    var_2 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "axis");

    if(isDefined(var_2) && distancesquared(var_2.origin, level.player.origin) < var_1 * var_1) {
      wait 0.05;
      continue;
    } else
      break;
  }

  var_3 = gettime();
  var_4 = 0;
  var_5 = 9;
  wait(var_5);
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_50");

  for(;;) {
    var_6 = var_5 - 2.0;
    var_7 = min(60, var_5 + 2.0 + 6.0 * var_4);
    wait(randomfloatrange(var_6, var_7));
    var_0 waittill("trigger");

    if((gettime() - var_3) / 1000 > 45) {
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_60");
      wait(randomfloatrange(1.5, 2.5));
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_70");
    } else if(scripts\engine\utility::cointoss())
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_50");
    else
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_80");

    var_4++;
  }
}

hint_locked_doors_vo(var_0, var_1) {
  scripts\engine\utility::array_thread(getEntArray(var_0, "targetname"), ::hint_locked_door_think, var_1);
}

hint_locked_door_think(var_0) {
  if(isDefined(var_0))
    level endon(var_0);

  self waittill("trigger");
  wait 1;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_40");
}

shaft_setup() {
  thread shaft_goal_volumes_setup();
  level.wolf_speakers = getEntArray("wolf_speaker", "targetname");
  scripts\engine\utility::array_thread(level.wolf_speakers, ::wolf_speaker_destroyed_think);
  thread cut_pa_on_flag("wolf_door_unlocked");
  thread shaft_ab_light_prep();
  thread shaft_propane_kick_setup();
  level.fire_fill_hurt = getEnt("fire_fill_hurt", "targetname");
  level.fire_fill_hurt scripts\engine\utility::trigger_off();
  level.wolf_tunnel_fire_trig = getEnt("wolf_tunnel_exp_fire_trig", "targetname");
  level.wolf_tunnel_fire_trig scripts\engine\utility::trigger_off();
  level.shaft_hero_planks_clip = getEnt("hero_board_break", "targetname");
}

shaft_goal_volumes_setup() {
  var_0 = [];
  var_0[0] = getEnt("shaft_level_1", "targetname");
  var_0[1] = getEnt("shaft_level_2", "targetname");
  var_0[2] = getEnt("shaft_level_3", "targetname");
  var_0[3] = getEnt("shaft_level_4", "targetname");
  var_0[4] = getEnt("shaft_level_5", "targetname");
  var_0[5] = getEnt("shaft_level_6", "targetname");

  foreach(var_2 in var_0)
  var_2.center_origin = scripts\engine\utility::getStruct(var_2.target, "targetname").origin;

  level.shaft_vols = var_0;
  level.player.cur_shaft_level_index = 0;
  level.player.max_shaft_level_index = 0;

  for(;;) {
    foreach(var_6, var_5 in level.shaft_vols) {
      if(level.player istouching(var_5) && level.player.cur_shaft_level_index != var_6) {
        if(level.player.max_shaft_level_index < var_6)
          level.player.max_shaft_level_index = var_6;

        level.player.cur_shaft_level_index = var_6;
      }
    }

    wait 1;
  }
}

shaft_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("shaft", [level.player]);
  scripts\engine\utility::flag_set("player_through_cart");
  level.player takeallweapons();
  var_0[0] = scripts\sp\utility::make_weapon("iw8_pi_mike1911");
  level.player giveweapon(var_0[0]);
  level.player switchtoweapon(var_0[0]);
}

shaft_catchup() {
  scripts\engine\utility::flag_set("player_through_cart");
  scripts\engine\utility::flag_set("entered_shaft");
  setsaveddvar("NQNQPRLRQM", 1);
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_shaft);
  thread shaft_epic_fire_catchup();
  thread shaft_fire_victim();
}

shaft() {
  scripts\engine\utility::flag_wait("entered_shaft");
  thread shaft_wolf_pa_vo();
  thread scripts\engine\sp\utility::lerp_saveddvar("NQNQPRLRQM", 1, 2);
  scripts\engine\sp\utility::autosave_by_name("shaft");
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_shaft);
  waitframe();
  level.farah.ignoreme = 1;
  thread scripts\sp\analytics::analytics_kleenex_update("Ladder Drop to Shaft");
  thread mus_shaft();
  thread sfx_fire_context_disable();
  wait 3;
  scripts\engine\utility::array_thread(getEntArray("shaft_ai_jump_down_block_trig", "targetname"), ::shaft_ai_jump_down_think);
  thread hint_boost_vo();
  thread hint_shoot_on_ladder();
  thread shaft_difficulty_think();
  thread shaft_epic_fire();
  thread shaft_fire_victim();
}

shaft_propane_kick_setup() {
  var_0 = scripts\engine\utility::getStruct("propane_kick", "targetname");
  wait 0.25;
  var_1 = getscriptablearray("shaft_propane_kick_scriptable", "targetname")[0];
  var_1.animname = "shaft_propane_kick";
  var_1 scripts\engine\sp\utility::assign_animtree();
  var_2 = getstartorigin(var_0.origin, var_0.angles, var_1 scripts\engine\utility::getanim("propane_kick"));
  var_3 = getstartangles(var_0.origin, var_0.angles, var_1 scripts\engine\utility::getanim("propane_kick"));
  var_1.origin = var_2;
  var_1.angles = var_3;
  var_4 = var_1.model;

  for(;;) {
    if(var_4 != var_1.model) {
      break;
    }

    if(!isDefined(var_1)) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("shaft_propane_kick_detonated");
}

shaft_epic_fire() {
  level.player endon("death");
  setup_dummy_flares();
  level.shaft_fire_on_level = -1;
  level.player.shaft_level_timer = [];
  thread shaft_smoke_vision_manager();
  scripts\engine\utility::flag_wait("shaft_fire_on");
  var_0 = scripts\engine\utility::getStruct("shaft_final_ladder_obj", "targetname").origin;
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "ladder", var_0);
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_ESCAPE");
  thread shaft_smoke_survival_vo();
  thread epic_scripted_fx();
  thread shaft_mayhem_tarps();
  thread shaft_mayhem_corner_collapse();
  thread shaft_mayhem_beam_crack();
  var_1 = 80;
  scripts\engine\utility::exploder("shaft_smoke_start");
  visionsetnaked("zd30tunnels_shaft_smoke_20", 5);
  thread shaft_ladder_fall();
  scripts\engine\utility::delaythread(0.5, ::shaft_ab_light_set, "mine_shaft_fire_01", 5);
  thread sfx_fire_context_enable();
  var_2 = waittill_fire_reached_shaft_level(1, var_1);
  var_3 = 30 + var_2;
  scripts\engine\utility::exploder("fire_phase1");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::checkpoint_loop(25, "reunion_reached");
  thread scripts\engine\utility::flag_set_delayed("fire_phase1_started", 2);
  scripts\engine\utility::delaythread(0.5, ::shaft_ab_light_set, "mine_shaft_fire_02", 5);
  scripts\engine\utility::delaythread(5, ::shaft_ab_light_set, "mine_shaft_fire_03", 2);
  scripts\engine\utility::delaythread(7, ::shaft_ab_light_set, "mine_shaft_fire_04", 2);
  var_2 = waittill_fire_reached_shaft_level(2, var_3);
  var_4 = 30 + var_2;
  scripts\engine\utility::exploder("fire_phase2");
  scripts\engine\utility::exploder("fire_phase2_beam");
  scripts\engine\utility::stop_exploder("fire_spread_3");
  var_2 = waittill_fire_reached_shaft_level(3, var_4);
  var_5 = 30 + var_2;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::tunnels_corpse_cleanup();
  level.fire_fill_hurt scripts\engine\utility::delaythread(3, scripts\engine\utility::trigger_on);
  scripts\engine\utility::exploder("fire_phase3");
  scripts\engine\utility::exploder("fire_phase3_corner");
  scripts\engine\utility::exploder("fire_base_fill");
  scripts\engine\utility::exploder("smoke_phase3");
  scripts\engine\utility::stop_exploder("shaft_fire_start");
  scripts\engine\utility::stop_exploder("shaft_smoke_start");
  scripts\engine\utility::stop_exploder("fire_spread_1");
  var_2 = waittill_fire_reached_shaft_level(4, var_5);
  var_6 = 20 + var_2;
  scripts\engine\utility::exploder("fire_phase4");
  scripts\engine\utility::exploder("fire_phase4_final");
  var_2 = waittill_fire_reached_shaft_level(5, var_6);
  scripts\engine\utility::flag_wait("reunion_pull_up_success");
  scripts\engine\utility::exploder("fire_phase5");
  scripts\engine\utility::stop_exploder("smoke_phase3");
  wait 5;
  playmayhem("vfx_mayh_plank_break_01");
}

sfx_fire_context_enable() {
  wait 3;
  setglobalsoundcontext("dusty", "");
}

sfx_fire_context_disable() {
  setglobalsoundcontext("dusty", "yes");
}

shaft_fire_victim() {
  var_0 = scripts\engine\sp\utility::spawn_script_noteworthy("shaft_fire_victim", 1);

  while(!isDefined(var_0) || !isalive(var_0))
    wait 0.05;

  var_0 endon("death");
  var_0 endon("entitydeleted");
  level.shaft_fire_victim = var_0;
  var_0 scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::set_original_baseaccuracy(0.25);
  var_0.ignoreall = 1;
  var_0 scripts\engine\sp\utility::disable_surprise();
  var_0 scripts\engine\sp\utility::set_ignoresuppression(1);
  var_0 scripts\common\utility::demeanor_override("sprint");
  var_1 = getnode("fire_victim_node", "targetname");
  var_2 = getEnt("shaft_fire_victim_zone", "targetname");
  var_0 waittill("goal");
  var_3 = var_0 scripts\engine\utility::waittill_any_return("bullethit", "shaft_mayhem_beam_crack");

  if(isDefined(var_3) && var_3 == "shaft_mayhem_beam_crack" && var_0 istouching(var_2)) {
    var_4 = 48;

    if(scripts\engine\utility::distance_2d_squared(var_0.origin, var_1.origin) > var_4 * var_4) {
      wait 0.5;
      var_0 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::enemy_death_by_fire(0);
      return;
    }

    var_5 = scripts\engine\utility::getStruct("shaft_fire_victim_struct", "targetname");
    var_5.angles = var_5.angles + (0, 180, 0);
    var_0.animname = "shaft_fire_victim";
    var_0.allowdeath = 1;
    var_0.noragdoll = 1;
    var_0.disabledeathorient = 1;
    var_0 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
    var_0 thread scripts\engine\sp\utility::name_hide();
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::cleanup_corpses_in_radius(var_5.origin, 128);
    var_0 thread scripts\asm\soldier\death::handleburndeathmodelswap();
    var_0 thread scripts\asm\soldier\death::handleburndeathvfx();
    var_0 thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::ai_burn_death_scream();
    var_0 scripts\engine\sp\utility::set_deathanim("burn_crawl_death");
    var_5 scripts\common\anim::anim_single_solo(var_0, "burn_crawl");
    var_0 kill();
    return;
  } else {
    var_0.ignoreall = 0;
    var_1 = getnode("despawn_node", "script_noteworthy");
    var_0 scripts\engine\sp\utility::set_goal_node(var_1);
  }
}

shaft_mayhem_tarps() {
  scripts\engine\utility::noself_delaycall(0.25, ::playmayhem, "mayhem_shaft_lower_tarp");
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_lower_tarp", (-1899, 1612, -1111));
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_lower2_trig", "mayhem_shaft_lower2_tarp", 1);
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_middle_trig", "mayhem_shaft_middle_tarp", 0.5);
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_middle2_trig", "mayhem_shaft_middle2_tarp", 0.25);
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_middle3_trig", "mayhem_shaft_middle3_tarp", 0.25);
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_upper_trig", "mayhem_shaft_upper_tarp", 0.25);
}

shaft_mayhem_tarp_burn_lookat_failsafe(var_0, var_1, var_2) {
  var_3 = getEnt(var_0, "targetname");
  var_4 = getEnt(var_3.target, "targetname");
  var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");
  var_3 waittill("trigger");
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::waittill_player_lookat_failsafe(var_5.origin, 0.8, undefined, undefined, var_2, undefined, var_4);
  thread sfx_tarp_mayhem(var_1);
  playmayhem(var_1);
}

sfx_tarp_mayhem(var_0) {
  if(var_0 == "mayhem_shaft_lower2_tarp")
    thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_lower2_tarp", (-1999, 1349, -959));
  else if(var_0 == "mayhem_shaft_middle3_tarp")
    thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_middle3_tarp", (-2127, 1367, -702));
  else if(var_0 == "mayhem_shaft_upper_tarp")
    thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_upper_tarp", (-2022, 1349, -476));
}

shaft_mayhem_corner_collapse() {
  var_0 = "mayhem_shaft_corner_collapse";
  var_1 = "mayhem_corner_collapse";
  var_2 = getEnt(var_1, "targetname");
  var_2 waittill("trigger");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_3 scripts\engine\sp\utility::waittill_player_lookat(0.8, 0.25);
  scripts\engine\utility::stop_exploder("fire_phase3_corner");
  thread sfx_mayhem_corner_collapse();
  playmayhem(var_0);
}

sfx_mayhem_corner_collapse() {
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_corner_collapse_01", (-2177, 1375, -778));
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_corner_collapse_opp_01", (-2018, 1279, -778));
  wait 0.5;
  var_0 = spawn("script_origin", (-2190, 1340, -778));
  var_0 playLoopSound("scn_zd30_shaft_corner_mayhem_fire_lp");
}

shaft_mayhem_beam_crack() {
  var_0 = "mayhem_shaft_beam_crack";
  var_1 = "mayhem_beam_crack";
  var_2 = getEnt(var_1, "targetname");
  var_2 waittill("trigger");
  var_3 = scripts\engine\utility::getStruct(var_2.target, "targetname");
  var_3 scripts\engine\sp\utility::waittill_player_lookat(0.8, 0.25);
  scripts\engine\utility::stop_exploder("fire_phase2_beam");
  thread sfx_mayhem_beam_crack();
  playmayhem(var_0);

  if(isDefined(level.shaft_fire_victim) && isalive(level.shaft_fire_victim))
    level.shaft_fire_victim notify("shaft_mayhem_beam_crack");

  var_4 = getscriptablearray("beam_crack_propane", "targetname")[0];

  if(isDefined(var_4) && isDefined(var_4.model) && var_4.model != "")
    var_4 setscriptablepartstate("base", "fire");

  var_5 = scripts\engine\utility::getStruct("beam_crack_dmg_struct", "targetname");
  var_6 = var_5.radius;
  var_7 = var_5.origin;
  var_8 = 128;
  var_9 = spawn("trigger_radius_fire", var_7, 0, var_6, var_8);
  var_9.script_multiplier = 5;
  var_9.script_radius = var_6;
  thread scripts\sp\trigger::trigger_fire(var_9);
}

sfx_mayhem_beam_crack() {
  var_0 = spawn("script_origin", (-1986, 1627, -787));
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_beam_crack_01", (-1979, 1565, -803));
  var_0 playLoopSound("scn_zd30_shaft_beam_mayhem_fire_lp");
}

epic_scripted_fx() {
  level.shaft_scriptable_trigs = getEntArray("shaft_scriptable_trig", "targetname");
  scripts\engine\utility::array_thread(level.shaft_scriptable_trigs, ::shaft_scriptables_think);
  level.shaft_lvl2_flicker_light = getEnt("shaft_lvl2_flicker_light", "script_noteworthy");
  var_0 = scripts\engine\utility::getStructArray("shaft_lvl2_flicker_light_sparks", "targetname");
  scripts\engine\utility::array_thread(var_0, ::shaft_run_sparks, 1.25, 3.25);
  level.shaft_epic_vfx_trigs = getEntArray("shaft_epic_vfx_trig", "targetname");
  scripts\engine\utility::array_thread(level.shaft_epic_vfx_trigs, ::shaft_epic_vfx_think);
}

shaft_scriptables_think() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ladder") {
    for(;;) {
      if(level.player isonladder() && level.player istouching(self)) {
        break;
      }

      wait 0.2;
    }
  } else
    self waittill("trigger");

  waitframe();
  var_0 = getscriptablearray(self.target, "targetname");

  if(!isDefined(var_0) || var_0.size == 0) {
    return;
  }
  var_1 = scripts\engine\sp\utility::get_average_origin(var_0) + (0, 0, 24);
  var_2 = var_0[0].origin;

  while(!scripts\engine\sp\utility::player_looking_at(var_1, 0.92, 1))
    wait 0.1;

  if(!level.player istouching(self)) {
    return;
  }
  foreach(var_4 in var_0) {
    if(!isDefined(var_4.classname)) {
      return;
    }
    if(isDefined(self.script_parameters)) {
      var_5 = strtok(self.script_parameters, " ");
      var_6 = "script_parameter of scriptable at: " + var_4.origin + " is missing 'state min_delay max_delay'";
      var_7 = var_5[0];
      var_8 = float(var_5[1]);
      var_9 = float(var_5[2]);
      thread shaft_generic_scriptable_run(var_4, var_7, var_8, var_9);
      continue;
    }

    if(issubstr(var_4.classname, "propane_tank")) {
      thread shaft_scriptable_propane_tank(var_4);
      continue;
    }

    if(issubstr(var_4.classname, "plywood_bare")) {
      thread shaft_scriptable_board(var_4);
      continue;
    }

    if(issubstr(var_4.classname, "plank_bridge")) {
      thread shaft_scriptable_plank(var_4);
      continue;
    }

    if(issubstr(var_4.classname, "pulley_fall")) {
      thread shaft_scriptable_pulley(var_4);
      continue;
    }

    continue;
  }
}

shaft_scriptable_pulley(var_0) {
  shaft_generic_scriptable_run(var_0, "fall", 0.25, 0.5);
}

shaft_scriptable_propane_tank(var_0) {
  shaft_generic_scriptable_run(var_0, "fire");
}

shaft_scriptable_board(var_0) {
  shaft_generic_scriptable_run(var_0, "charred", 0.25, 0.5);
}

shaft_scriptable_plank(var_0) {
  shaft_generic_scriptable_run(var_0, "charred", 0.25, 0.5);
}

shaft_generic_scriptable_run(var_0, var_1, var_2, var_3) {
  if(isDefined(self.script_delay))
    wait(float(self.script_delay));
  else if(isDefined(var_2) && isDefined(var_3))
    wait(randomfloatrange(var_2, var_3));

  if(isDefined(var_0.script_parameters))
    var_1 = var_0.script_parameters;

  if(isDefined(var_0.script_delay))
    wait(float(var_0.script_delay));

  if(isDefined(self.target)) {
    var_4 = getEntArray(self.target, "targetname");
    var_5 = [];

    foreach(var_7 in var_4) {
      if(isDefined(var_7) && isDefined(var_7.classname) && var_7.classname == "script_brushmodel")
        var_5[var_5.size] = var_7;
    }

    if(isDefined(var_5) && var_5.size > 0) {
      var_5 = sortbydistance(var_5, var_0.origin);
      var_9 = var_5[0];

      if(isDefined(var_9))
        var_9 delete();
    }
  }

  var_0 setscriptablepartstate("base", var_1);
}

shaft_run_sparks(var_0, var_1) {
  var_2 = self.origin;
  var_3 = anglesToForward(self.angles);
  var_4 = anglestoup(self.angles);
  var_5 = spawnfx(level._effect["vfx_speaker_sparks"], self.origin, var_3, var_4);

  if(isDefined(self.script_delay)) {
    var_0 = float(self.script_delay) * 0.5;
    var_1 = float(self.script_delay) * 1.1;
  }

  for(;;) {
    wait(randomfloatrange(var_0, var_1));
    triggerfx(var_5);
  }
}

shaft_epic_vfx_think() {
  self waittill("trigger");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_1 = [];

  if(isDefined(var_0.target))
    var_1 = scripts\engine\utility::getStructArray(var_0.target, "targetname");

  while(!scripts\engine\sp\utility::player_looking_at(var_0.origin, 0.95))
    wait 0.05;

  if(!level.player istouching(self)) {
    return;
  }
  if(isDefined(var_1) && var_1.size > 0) {
    foreach(var_3 in var_1) {
      var_4 = "vfx_zd30_falling_debris";

      if(isDefined(var_3.script_noteworthy))
        var_4 = var_3.script_noteworthy;

      thread sfx_falling_debris(var_3.origin);
      playFX(level._effect[var_4], var_3.origin);
    }
  }
}

sfx_falling_debris(var_0) {
  thread scripts\engine\utility::play_sound_in_space("zd30_shaft_debris_woodbreak", var_0);
  wait 0.75;
  thread scripts\engine\utility::play_sound_in_space("zd30_shaft_debris_fireball_sm", var_0 - (0, 0, 100));
}

shaft_ab_light_prep() {
  wait 0.25;
  level.shaft_ab_lights = [];
  level.shaft_ab_lights[0] = "mine_shaft_fire_01";
  level.shaft_ab_lights[1] = "mine_shaft_fire_02";
  level.shaft_ab_lights[2] = "mine_shaft_fire_03";
  level.shaft_ab_lights[4] = "mine_shaft_fire_04";

  foreach(var_1 in level.shaft_ab_lights) {
    var_2 = getEntArray(var_1, "targetname");

    foreach(var_4 in var_2) {
      if(!isDefined(var_4)) {
        continue;
      }
      var_4.original_intensity = var_4 getlightintensity();
      var_4 setlightintensity(0);
    }
  }
}

shaft_ab_light_set(var_0, var_1) {
  scripts\engine\utility::array_thread(getEntArray(var_0, "targetname"), ::shaft_ab_light_set_internal, var_0, var_1);
}

shaft_ab_light_set_internal(var_0, var_1) {
  if(!isDefined(self) || !scripts\engine\utility::array_contains(level.shaft_ab_lights, var_0)) {
    return;
  }
  var_2 = 1;

  if(var_2 && isDefined(var_1)) {
    var_3 = 0.1;
    var_4 = int(var_1 / 0.1);

    for(var_5 = 0; var_5 < var_4; var_5++) {
      var_6 = var_5 / var_4;
      var_7 = self.original_intensity * var_6;
      self setlightintensity(var_7);
      wait(var_3);
    }
  }

  self setlightintensity(self.original_intensity);
}

shaft_epic_fire_catchup() {
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_ESCAPE");
  thread scripts\engine\utility::exploder("fire_phase3");
  thread scripts\engine\utility::exploder("fire_phase3_corner");
  thread scripts\engine\utility::exploder("fire_base_fill");
  thread scripts\engine\utility::exploder("smoke_phase3");
  thread scripts\engine\utility::exploder("fire_phase4");
  thread scripts\engine\utility::exploder("fire_phase4_final");
  level.fire_fill_hurt scripts\engine\utility::trigger_on();
  thread epic_scripted_fx();
  scripts\engine\utility::delaythread(1, ::shaft_ab_light_set, "mine_shaft_fire_02", 0.25);
  scripts\engine\utility::delaythread(1, ::shaft_ab_light_set, "mine_shaft_fire_03", 0.25);
  scripts\engine\utility::delaythread(1, ::shaft_ab_light_set, "mine_shaft_fire_04", 0.25);
  thread shaft_mayhem_tarps();
  thread shaft_mayhem_corner_collapse();
  thread shaft_mayhem_beam_crack();
}

waittill_fire_reached_shaft_level(var_0, var_1) {
  level.player endon("death");
  var_2 = var_0 - 1;

  if(!isDefined(level.player.shaft_level_timer[var_2]))
    level.player.shaft_level_timer[var_2] = 0;

  if(!isDefined(var_1))
    var_1 = 9999;

  var_3 = 0;
  var_4 = 0.2;
  var_5 = 0;
  var_6 = 30;

  while(level.player.max_shaft_level_index < var_0) {
    if(var_0 == 1 && !var_5 && istrue(level.mine_carts["mine_cart"].moved_by_player)) {
      var_7 = var_1 - var_3;

      if(var_7 >= var_6) {
        var_3 = var_1 - var_6;
        var_5 = 1;

        if(getdvarint("zd30_debug") > 1)
          iprintlnbold("Shaft ground floor timer reduced to: " + var_6);
      }
    }

    var_3 = var_3 + var_4;

    if(var_3 > var_1) {
      break;
    }

    level.player.shaft_level_timer[var_2] = max(0, var_1 - var_3);
    wait(var_4);
  }

  level.shaft_fire_on_level = var_0 - 1;
  var_8 = 10;
  return min(var_8, level.player.shaft_level_timer[var_2]);
}

shaft_fire_light_wobble_think() {
  self.original_angles = self.angles;
  var_0 = 5;
  var_1 = 12;
  var_2 = 0.5;
  var_3 = 0.75;

  for(;;) {
    var_4 = randomfloatrange(var_2, var_3);
    var_5 = self.original_angles + scripts\engine\utility::randomvectorrange(var_0, var_1);
    self rotateTo(var_5, var_4);
    wait(var_4);
  }
}

shaft_fire_light_think() {
  self linkTo(level.shaft_fire_light, "tag_origin");
  self.initial_intensity = self getlightintensity();
  var_0 = 0.5;
  var_1 = 1;
  var_2 = 0.2;
  var_3 = 0.35;
  thread shaft_fire_light_flicker(var_0, var_1, var_2, var_3);
}

shaft_fire_light_flicker(var_0, var_1, var_2, var_3) {
  for(;;) {
    var_4 = randomfloatrange(var_0, var_1) * self.initial_intensity;
    self setlightintensity(var_4);
    wait(randomfloatrange(var_2, var_3));
  }
}

setup_dummy_flares() {
  level.dummy_flares = getEntArray("dummy_flare", "targetname");
  scripts\engine\utility::array_thread(level.dummy_flares, ::dummy_flares_snake_go);
}

dummy_flares_snake_go() {
  self endon("death");
  self.dummy = 1;

  foreach(var_1 in level.oil_fires) {
    if(self istouching(var_1)) {
      while(!istrue(var_1.fire_exploder_on))
        wait 0.25;

      break;
    }
  }

  scripts\engine\utility::flag_set("shaft_fire_on");
  thread debug_oil_fire_snake();
  var_3 = 30;
  var_4 = self;

  while(isDefined(var_4.target)) {
    var_5 = scripts\engine\utility::getStruct(var_4.target, "targetname");
    var_6 = distance(self.origin, var_5.origin);
    var_7 = var_6 / var_3;
    self moveTo(var_5.origin, var_7);
    wait(var_7);
    var_8 = getgroundposition(var_5.origin, 4);
    self moveTo(var_8, 0.05);
    wait 0.5;
    self moveTo(var_5.origin, 0.05);
    wait 0.5;
    var_4 = var_5;
    level notify("snake_fire_spread");
  }

  wait 1;
  self delete();
}

debug_oil_fire_snake() {
  self endon("death");

  while(getDvar("zd30_debug") == "1")
    wait 0.1;
}

shaft_ladder_fall() {
  var_0 = getEnt("shaft_ladder", "targetname");
  var_1 = getEnt(var_0.target, "targetname");
  var_0 linkTo(var_1, "tag_origin");
  level scripts\engine\utility::waittill_any_timeout(3.5, "oil_fire_barrel_explode");
  wait 0.35;
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_base_ladder_collapse", (-2004, 1547, -1140));
  var_2 = -95;
  var_3 = 1.5;
  var_4 = var_3 - 0.05;
  var_1 rotateroll(var_2, var_3, var_4, 0.05);
  wait(var_3);
  var_5 = 0.25;
  var_6 = 3.25;
  var_4 = var_5 - 0.05;
  var_1 rotateroll(var_6, var_5, 0.05, var_4);
  wait(var_5);
  var_6 = var_6 * -1;
  var_1 rotateroll(var_6, var_5, var_4, 0.05);
}

mus_shaft() {
  wait 3;
  setmusicstate("mx_zd30_tunnel_fire_climb");
}

shaft_difficulty_think() {
  var_0 = level.player.gs.playergrenadebasetime;
  scripts\engine\utility::flag_wait("entered_shaft_low");
  level.player.gs.playergrenadebasetime = 12000;
  scripts\engine\utility::flag_wait("entered_shaft_mid");
  level.player.gs.playergrenadebasetime = 9000;
  scripts\engine\utility::flag_wait("entered_shaft_high");
  level.player.gs.playergrenadebasetime = 6000;
  scripts\engine\utility::flag_wait("wolf_killed");
  level.player.gs.playergrenadebasetime = var_0;
}

hint_boost_vo() {
  level.player endon("death");
  level endon("hint_boost_done");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_alx_tunnels_chamber_50";
  var_0[var_0.size] = "dx_vom_alx_tunnels_chamber_40";
  var_0[var_0.size] = "dx_vom_alx_tunnels_chamber_30";
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_80";
  var_1 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_1.autoshuffle = 1;
  var_2 = getEnt("hint_boost", "targetname");

  for(;;) {
    while(!level.player istouching(var_2))
      level.player waittill("jump_pressed");

    var_3 = distance2d(level.player.origin, level.mine_carts["mine_cart"].origin);
    var_4 = var_3 < 64;

    if(level.mine_carts["mine_cart"] istouching(var_2) || level.player isonladder() || var_4) {
      waitframe();
      continue;
    }

    while(!level.player isonground())
      waitframe();

    if(istrue(level.player.isspeaking))
      level.player waittill("finished_speaking");

    level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw(), 1);
    wait 2;
  }
}

hint_shoot_on_ladder() {
  level.player scripts\engine\utility::ent_flag_init("shoot_on_ladder");
  var_0 = 2;

  while(var_0 > 0) {
    var_0--;

    while(!level.player isonladder() || !scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_has_pistol())
      wait 0.25;

    thread notify_when_player_shot_on_ladder();
    thread scripts\engine\sp\utility::display_hint_forced("hint_shoot_on_ladder", 8, 0.25, level.player, "hint_shoot_on_ladder_off");

    while(level.player isonladder())
      wait 0.25;

    if(!level.player scripts\engine\utility::ent_flag("shoot_on_ladder")) {
      level.player notify("hint_shoot_on_ladder_off");
      continue;
    }

    return;
  }
}

notify_when_player_shot_on_ladder() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired");

    if(level.player isonladder()) {
      level.player scripts\engine\utility::ent_flag_set("shoot_on_ladder");
      level.player notify("hint_shoot_on_ladder_off");
    }
  }
}

waittill_player_jump_or_timeout(var_0) {
  if(isDefined(var_0))
    var_1 = var_0;
  else
    var_1 = 3;

  while(var_1 > 0) {
    if(level.player isjumping())
      return 1;

    waitframe();
    var_1 = var_1 - 0.05;
  }

  return 0;
}

shaft_ai_jump_down_think() {
  self endon("death");
  self endon("entitydeleted");
  var_0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var_1 = var_0.radius;
  var_2 = var_0.origin;
  var_3 = 256;

  while(!isDefined(level.mine_carts) || !isDefined(level.mine_carts["mine_cart"]))
    wait 0.25;

  for(;;) {
    var_4 = undefined;

    if(level.mine_carts["mine_cart"] istouching(self))
      var_4 = createnavobstaclebybounds(var_2, (var_1, var_1, var_3), (0, 0, 0));

    while(level.mine_carts["mine_cart"] istouching(self))
      wait 0.25;

    if(isDefined(var_4))
      destroynavobstacle(var_4);

    wait 0.05;
  }
}

shaft_smoke_survival_vo() {
  level endon("shaft_final_ladder_reached");
  level.player endon("death");
  var_0 = [];
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_20";
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_30";
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_40";
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_90";
  var_0[var_0.size] = "dx_vom_alx_tunnels_chamber_60";
  var_1 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_10";
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_100";
  var_0[var_0.size] = "dx_vom_alx_tunnels_chamber_70";
  var_2 = scripts\engine\sp\utility::create_deck(var_0);
  var_0 = [];
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_50";
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_60";
  var_0[var_0.size] = "dx_vom_alx_shaft_firehints_70";
  var_3 = scripts\engine\sp\utility::create_deck(var_0, 0);
  var_3.autoshuffle = 1;
  wait 5;
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(1.2, 8);
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_1 scripts\engine\sp\utility::deck_draw_specific("dx_vom_alx_shaft_firehints_20"), 0, 3);
  wait(randomfloatrange(5, 8));

  for(;;) {
    if(level.player_is_safe_from_smoke) {
      scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(3, 8);

      if(var_1 scripts\engine\sp\utility::deck_is_empty())
        var_2 scripts\engine\sp\utility::deck_shuffle();

      var_4 = wait_look_up_or_timeout(20, 4);

      if(var_4 && !var_2 scripts\engine\sp\utility::deck_is_empty())
        var_5 = var_2 scripts\engine\sp\utility::deck_draw();
      else
        var_5 = var_1 scripts\engine\sp\utility::deck_draw();

      wait 0.4;
      scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(0.6, 1.2);

      if(level.player isonladder()) {
        continue;
      }
      level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_5, 0, 3);
      wait(randomfloatrange(11, 15));
      continue;
    }

    scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(1, 3);
    level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_3 scripts\engine\sp\utility::deck_draw(), 0, 3);
    wait(randomfloatrange(3, 5));
  }
}

wait_look_up_or_timeout(var_0, var_1) {
  while(!isDefined(var_1) || var_1 > 0) {
    if(level.player getplayerangles()[0] < var_0 * -1)
      return 1;

    waitframe();

    if(isDefined(var_1))
      var_1 = var_1 - 0.05;
  }

  return 0;
}

shaft_smoke_vision_manager() {
  level.player endon("death");
  level.player_smoke_death_time = int(40.0);
  level.smoke_death_timer = level.player_smoke_death_time;

  while(!scripts\engine\utility::flag("shaft_ladder_scene_execute")) {
    if(level.player.cur_shaft_level_index <= level.shaft_fire_on_level) {
      level notify("hint_boost_done");
      thread gas_playerexposedeffects();

      while(level.player.cur_shaft_level_index <= level.shaft_fire_on_level && !scripts\engine\utility::flag("shaft_ladder_scene_execute")) {
        var_0 = int(max(0, level.shaft_fire_on_level - level.player.cur_shaft_level_index));
        level.smoke_death_timer = level.smoke_death_timer - 1;

        if(level.smoke_death_timer > 25 && var_0 < 1)
          level.player_is_safe_from_smoke = 1;
        else
          level.player_is_safe_from_smoke = 0;

        if(level.smoke_death_timer <= 0 || var_0 >= 3) {
          level.player.dead_from_smoke = 1;

          if(!scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug()) {
            level endon("smoke_cough_stop");
            shaft_fire_kill_player(3, 1, "shaft_ladder_scene_execute");
          } else
            iprintlnbold("DEAD FROM SMOKE");
        }

        wait 1;
      }

      level notify("smoke_cough_stop");
      wait 0.05;
      gas_playerrecovereffects();
    }

    level.smoke_death_timer = int(min(level.player_smoke_death_time, level.smoke_death_timer + 3));
    var_0 = int(max(0, level.shaft_fire_on_level - level.player.cur_shaft_level_index));

    if(level.smoke_death_timer > 25 && var_0 < 1)
      level.player_is_safe_from_smoke = 1;
    else
      level.player_is_safe_from_smoke = 0;

    wait 1;
  }

  level notify("smoke_cough_stop");
  level.player_is_safe_from_smoke = 1;
  wait 0.05;
  gas_playerrecovereffects();
}

shaft_fire_kill_player(var_0, var_1, var_2) {
  if(isDefined(var_2))
    level endon(var_2);

  var_3 = spawn("trigger_radius_fire", level.player.origin, 0, 32, 128);
  var_3.script_multiplier = 5;
  var_3.script_radius = 32;
  var_3 enablelinkTo();
  var_3 linkTo(level.player, "tag_origin");
  thread scripts\sp\trigger::trigger_fire(var_3);

  if(!isDefined(var_0))
    var_0 = 3;

  wait(var_0);

  if(istrue(var_1))
    scripts\sp\player_death::set_custom_death_quote(64);

  waitframe();
  level.player kill();
}

gas_playerexposedeffects() {
  level.player endon("death");
  level endon("smoke_cough_stop");
  level.player endon("death");
  visionsetnaked("zd30tunnels_shaft_smoke_20", 5);
  level.player_smoke_vision = "zd30tunnels_shaft_smoke_20";
  setsaveddvar("NKTRSSTMRQ", -1);
  var_0 = gettime();
  var_1 = ["ges_ph_cough_a", "ges_ph_cough_b", "ges_ph_cough_c"];
  var_2 = ["gas_player_cough_1", "gas_player_cough_3"];
  var_3 = var_1[0];
  var_4 = var_1;
  var_5 = var_2;
  var_6 = 0.05;
  var_7 = 0.0;
  var_8 = 0;
  var_9 = 500;
  var_10 = 0.4;
  var_11 = 1400;
  var_12 = 2500;
  var_13 = 2000;
  var_14 = 2400;
  var_15 = 0.03;
  var_16 = 0.01;
  var_17 = var_0;
  var_18 = 0.2;
  var_19 = 0;
  var_20 = 0.5;
  var_21 = scripts\engine\math::normalize_value(var_17, var_17 + level.player_smoke_death_time * 1000, gettime());
  var_22 = scripts\engine\math::factor_value(var_11, var_13, var_21);
  var_23 = scripts\engine\math::factor_value(var_12, var_14, var_21);
  var_24 = randomfloatrange(var_22, var_23);
  var_25 = gettime() + var_24;

  while(!scripts\engine\utility::flag("shaft_ladder_scene_execute")) {
    var_0 = gettime();
    var_21 = scripts\engine\math::normalize_value(var_17, var_17 + level.player_smoke_death_time * 1000, var_0);

    if(level.player.cur_shaft_level_index < level.shaft_fire_on_level) {
      var_26 = level.shaft_fire_on_level - level.player.cur_shaft_level_index;
      var_21 = clamp(var_21 * var_26, 0, 1.0);
    }

    level.player_smoke_exposure = var_21;

    if(var_21 > var_10 && !var_8 && var_0 >= var_17 + var_9) {
      playFXOnTag(level._effect["vfx_player_smoke_screen"], level.player, "tag_origin");
      var_8 = 1;
    }

    if(var_21 <= var_10) {
      visionsetnaked("zd30tunnels_shaft_smoke_20", 5);
      level.player_smoke_vision = "zd30tunnels_shaft_smoke_20";
    } else if(var_21 > var_10 && var_21 < 0.8) {
      visionsetnaked("zd30tunnels_shaft_smoke_50", 5);
      level.player_smoke_vision = "zd30tunnels_shaft_smoke_50";
      level.player_smoke_death_time = int(35.0);
    } else {
      visionsetnaked("zd30tunnels_shaft_smoke_70", 5);
      level.player_smoke_vision = "zd30tunnels_shaft_smoke_70";
      level.player_smoke_death_time = int(28.0);
    }

    if(var_0 >= var_25) {
      if(!var_4.size)
        var_4 = var_1;

      if(!var_5.size)
        var_5 = var_2;

      while(level.player isgestureplaying(var_3))
        waitframe();

      var_27 = scripts\engine\utility::random(var_4);
      var_28 = scripts\engine\utility::random(var_5);
      var_3 = var_27;

      if(should_play_cough_gesture() && var_21 > var_10)
        level.player playgestureviewmodel(var_27, undefined, 0, 0.75);

      if(level.player scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::is_done_speaking())
        level.player playSound(var_28);

      var_4 = scripts\engine\utility::array_remove(var_4, var_27);
      var_5 = scripts\engine\utility::array_remove(var_5, var_28);
      var_22 = scripts\engine\math::factor_value(var_11, var_13, var_21);
      var_23 = scripts\engine\math::factor_value(var_12, var_14, var_21);
      var_24 = randomfloatrange(var_22, var_23);
      thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::fake_player_damage(undefined, var_24 * 0.5);
      var_25 = gettime() + var_24;
    }

    var_29 = var_18 * sin(var_19);
    var_19 = scripts\engine\math::wrap(0, 360, var_19 + var_20);
    var_30 = scripts\engine\math::factor_value(0, var_15, var_21 + var_29);
    var_31 = scripts\engine\math::factor_value(0, var_16, var_21 + var_29);
    var_7 = scripts\engine\math::factor_value(0, var_6, var_21 + var_18);

    if(var_21 < var_10) {
      var_7 = 0.1;
      var_30 = 0;
      var_31 = 0;
    }

    waitframe();
  }
}

should_play_cough_gesture() {
  if(level.player isthrowinggrenade())
    return 0;

  if(level.player islinked())
    return 0;

  if(!level.player isweaponsenabled())
    return 0;

  if(level.player isonladder())
    return 0;

  if(!level.player scripts\common\utility::is_weapon_allowed())
    return 0;

  if(level.player scripts\engine\sp\utility::isads() || scripts\engine\utility::flag("shaft_ladder_scene_execute") || istrue(level.player.dead_from_smoke) || istrue(level.player.pushing_mine_cart))
    return 0;

  if(isDefined(level.player.last_weapon_fire_time)) {
    var_0 = 1;

    if((gettime() - level.player.last_weapon_fire_time) / 1000 < var_0)
      return 0;
  }

  return 1;
}

gas_playerrecovereffects(var_0, var_1, var_2) {
  if(!isDefined(var_0))
    var_0 = 5.0;

  if(isDefined(var_1))
    var_3 = var_1;
  else
    var_3 = "zd30tunnels_shaft_smoke_20";

  if(isDefined(var_2))
    var_4 = var_2;
  else
    var_4 = 5;

  visionsetnaked(var_3, var_4);
  level.player_smoke_vision = var_3;
  stopFXOnTag(level._effect["vfx_player_smoke_screen"], level.player, "tag_origin");
  level.player.damage.deathsdooroverlaypulse fadeovertime(0.75);
  level.player.damage.deathsdooroverlaypulse.alpha = 0;
  level.player_smoke_exposure = 0;
}

shaft_wolf_pa_vo() {
  level endon("wolf_door_unlocked");
  level endon("shaft_ladder_scene_execute");
  level.wolf_pa_vo = [];
  level.wolf_pa_vo[0] = [];
  level.wolf_pa_vo[0][0] = "dx_vom_wolf_wolf_monologue_100 0 1";
  level.wolf_pa_vo[0][1] = "dx_vom_wolf_wolf_monologue_110 0 1";
  level.wolf_pa_vo[0][2] = "dx_vom_wolf_wolf_monologue_120 0";
  level.wolf_pa_vo[0][3] = "dx_vom_wolf_wolf_monologue_130 0";
  level.wolf_pa_vo[1] = [];
  level.wolf_pa_vo[1][0] = "dx_vom_wolf_wolf_monologue_80 0";
  level.wolf_pa_vo[2] = [];
  level.wolf_pa_vo[2][0] = "dx_vom_wolf_wolf_monologue_90 0";
  level.wolf_pa_vo[3] = [];
  level.wolf_pa_vo[3][0] = "dx_vom_wolf_wolf_monologue_30 1";
  level.wolf_pa_vo[4] = [];
  level.wolf_pa_vo[4][0] = "dx_vom_wolf_wolf_monologue_140 0 1";
  level.wolf_pa_vo[4][1] = "dx_vom_wolf_wolf_monologue_150 0";
  level.wolf_pa_vo[4][2] = "dx_vom_wolf_wolf_monologue_160 0";
  level.wolf_pa_vo[5] = [];
  level.wolf_pa_vo[5][0] = "dx_vom_wolf_wolf_monologue_170 0";
  scripts\engine\utility::array_thread(getEntArray("wolf_pa_trig", "targetname"), ::wolf_pa_think);
  level.wolf_pa_queue = [];
  level.wolf_pa_cur_index = -1;
  var_0 = 3;

  for(var_1 = 0; var_1 < level.wolf_pa_vo.size; var_1++) {
    for(var_2 = 0; var_2 < level.wolf_pa_vo[var_1].size; var_2++) {
      var_3 = level.wolf_pa_vo[var_1][var_2];
      var_4 = strtok(var_3, " ");
      var_5 = 3;
      var_6 = 3;
      var_7 = 3;
      var_8 = var_4[0];
      var_9 = get_closest_speaker();
      var_10 = 0;
      var_11 = 0;

      if(var_4.size > 2)
        var_11 = float(var_4[2]);
      else
        var_10 = int(var_4[1]);

      if(var_10 && level.wolf_pa_cur_index > var_1 + 1) {
        if(getdvarint("zd30_debug") > 2)
          iprintlnbold("PA: " + var_8 + " skipped (cur_idx=" + level.wolf_pa_cur_index + ",play_idx=" + var_1);

        continue;
      }

      if(getdvarint("zd30_debug") > 2) {
        var_12 = "";
        var_13 = strtok(var_8, "_");

        for(var_14 = 3; var_14 < var_13.size; var_14++) {
          var_15 = "_";

          if(var_14 == 3)
            var_15 = "";

          var_12 = var_12 + (var_15 + var_13[var_14]);
        }

        iprintlnbold("PA: " + var_12 + " (" + (var_1 + 1) + ":" + (var_2 + 1) + "/" + level.wolf_pa_vo[var_1].size + ")");
      }

      var_9 play_wolf_vo_on_this_speaker(var_8, var_5, var_6, var_7);

      if(getdvarint("zd30_debug") > 2)
        iprintlnbold("post_delay=" + var_11 + "sec");

      wait(var_11);
    }

    if(getdvarint("zd30_debug") > 2)
      iprintlnbold("set_delay=" + var_0 + "sec");

    wait(var_0);
  }
}

cut_pa_on_flag(var_0) {
  scripts\engine\utility::flag_wait(var_0);

  if(isDefined(level.wolf_pa_emitter)) {
    level.wolf_pa_emitter stopsounds();
    level.wolf_pa_emitter delete();
  }
}

wolf_speaker_destroyed_think() {
  self setCanDamage(1);
  self.health = 100000;

  for(;;) {
    self waittill("damage", var_0, var_1);

    if(isDefined(var_1) && isPlayer(var_1)) {
      break;
    }

    self.health = self.health + var_0;
  }

  var_2 = anglesToForward(self.angles);
  var_3 = anglestoup(self.angles);
  var_4 = 2;
  var_5 = self.origin + vectorNormalize(var_2) * var_4;
  scripts\engine\utility::delaycall(1, ::playsound, "tv_shot_sparks");
  scripts\engine\utility::noself_delaycall(1.25, ::playfx, level._effect["vfx_speaker_sparks"], var_5, var_2, var_3);
  scripts\engine\utility::delaycall(3, ::playsound, "tv_shot_sparks");
  scripts\engine\utility::noself_delaycall(3.25, ::playfx, level._effect["vfx_speaker_sparks"], var_5, var_2, var_3);
  self.destroyed = 1;
  self rotatepitch(20, 0.1);

  if(1) {
    if(isDefined(level.wolf_pa_emitter)) {
      level.wolf_pa_emitter stopsounds();
      waitframe();
      level.wolf_pa_emitter delete();

      if(getdvarint("zd30_debug") > 0)
        return;
    }
  } else {
    var_6 = get_closest_speaker();
    level notify("move_to_next_speaker", var_6);

    if(getdvarint("zd30_debug") > 0)
      thread scripts\engine\utility::draw_line_for_time(self.origin, var_6.origin, 1, 0.5, 0.5, 5);
  }
}

play_wolf_vo_on_this_speaker(var_0, var_1, var_2, var_3) {
  if(isDefined(level.wolf_pa_emitter))
    level.wolf_pa_emitter delete();

  level.wolf_pa_emitter = spawn("script_origin", self.origin);
  thread play_wolf_vo_speaker_debug();
  thread wolf_pa_move_to_next_speaker_monitor();
  scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::wait_combat_cooldown(0.4, 3);
  level.wolf_pa_emitter scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::say_as_chatter(var_0, 1, 3);

  if(isDefined(level.wolf_pa_emitter))
    level.wolf_pa_emitter delete();
}

wolf_pa_move_to_next_speaker_monitor() {
  level.wolf_pa_emitter endon("death");
  level.wolf_pa_emitter endon("entitydeleted");

  for(;;) {
    level waittill("move_to_next_speaker", var_0);
    level.wolf_pa_emitter moveTo(var_0.origin, 0.25);
  }
}

play_wolf_vo_speaker_debug() {
  level.wolf_pa_emitter endon("death");
  level.wolf_pa_emitter endon("entitydeleted");

  while(getdvarint("zd30_debug") > 0)
    wait 1;
}

get_closest_speaker() {
  var_0 = [];

  foreach(var_2 in level.wolf_speakers) {
    if(!istrue(var_2.destroyed))
      var_0[var_0.size] = var_2;
  }

  if(var_0.size == 0) {
    var_4 = sortbydistance(level.wolf_speakers, level.player.origin);
    return var_4[var_4.size - 1];
  }

  var_4 = sortbydistance(var_0, level.player.origin);
  return var_4[0];
}

wolf_pa_think() {
  self endon("death");
  self waittill("trigger");
  level.wolf_pa_cur_index++;

  if(getdvarint("zd30_debug") > 2)
    iprintlnbold("PA idx=" + level.wolf_pa_cur_index);
}

shaft_fire_debug_print() {
  for(var_0 = 0.1; getdvarint("zd30_debug") > 1; var_0 = var_0 + 0.1) {
    var_1 = 7;
    var_2 = 0.5;
    var_3 = (0.65, 0.65, 0.75);
    var_4 = level.player.max_shaft_level_index;
    var_5 = level.player.cur_shaft_level_index;
    var_6 = level.shaft_fire_on_level;
    var_7 = "Player Reached Floor: " + (var_4 + 1) + " ( total time: " + int(var_0) + " )";
    var_7 = "Fire Reached Floor: " + (var_6 + 1);
    var_7 = "Player's Current Floor: " + (var_5 + 1);

    if(isDefined(level.player.shaft_level_timer[var_5])) {
      var_8 = level.player.shaft_level_timer[var_5];
      var_7 = var_7 + (" ( remaining time: " + int(var_8) + " )");
    }

    if(isDefined(level.smoke_death_timer) && isDefined(level.player_smoke_death_time)) {
      var_7 = "Player's choke time: " + level.smoke_death_timer + "/" + level.player_smoke_death_time;

      if(isDefined(level.player_smoke_exposure))
        var_7 = var_7 + " ( exposure: " + int(level.player_smoke_exposure * 100) / 100 + " )";
    }

    if(istrue(level.player_is_safe_from_smoke))
      var_7 = "Player safe from smoke: Yes";
    else
      var_7 = "Player safe from smoke: No";

    if(isDefined(level.player_smoke_vision))
      var_7 = "Shaft vision: " + level.player_smoke_vision;

    if(isDefined(level.shaft_fire_light)) {
      if(istrue(level.shaft_fire_light.active)) {} else {}
    }

    wait 0.1;
  }
}

reunion_start() {
  level.player clearclienttriggeraudiozone(1.0);
  scripts\engine\sp\utility::set_start_location("reunion", [level.player]);
}

reunion_setup() {
  wait 1;
  var_0 = scripts\engine\utility::getStruct("shaft_ladder_scene", "targetname");
  level.shaft_ladder = scripts\engine\sp\utility::spawn_anim_model("shaft_ladder", var_0.origin, var_0.angles);
  var_0 thread scripts\common\anim::anim_first_frame_solo(level.shaft_ladder, "shaft_ladder_intro");
}

reunion_catchup() {
  thread wolf_tunnel_deadbodies();
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
}

reunion() {
  scripts\engine\utility::flag_wait("reunion_reached");
  thread wolf_tunnel_deadbodies();
  waitframe();
  scripts\engine\utility::flag_wait("shaft_final_ladder_reached");
  var_0 = scripts\engine\sp\utility::spawn_targetname("ladder_corpse", 1);
  var_0.animname = "ladder_corpse";
  var_0.ignoreall = 1;
  var_0.ignoreme = 1;
  var_0.allowdeath = 0;
  var_0.noragdoll = 1;
  var_0 thread scripts\engine\sp\utility::name_hide();
  var_0 scripts\common\ai::magic_bullet_shield();
  var_0 thread scripts\sp\maps\tunnels\zd30tunnels_ai.gsc::battlechatter_off_spawn_func();
  var_0 scripts\common\ai::gun_remove();
  var_0 scripts\sp\utility::context_melee_allow(0);
  level.ladder_corpse = var_0;
  waitframe();
  var_1 = getEnt("shaft_top_level_enemy_grabber", "targetname");
  var_2 = getaiarray("axis");

  foreach(var_4 in var_2) {
    if(isDefined(var_4) && isalive(var_4) && var_4 istouching(var_1)) {
      if(var_4 == level.ladder_corpse) {
        continue;
      }
      if(abs(var_4.origin[2] - level.farah.origin[2]) < 360) {
        var_4 thread reunion_magic_shoot_enemy();
        continue;
      }

      var_5 = randomfloatrange(1, 3);

      if(istrue(var_4.magic_bullet_shield))
        var_4 scripts\common\ai::stop_magic_bullet_shield();

      var_4.allowdeath = 1;
      var_4 scripts\engine\utility::delaycall(var_5, ::kill);
    }
  }

  scripts\engine\utility::flag_wait("shaft_ladder_scene_execute");
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  thread remove_mayhem_clip_under_ladder();
  thread gas_playerrecovereffects(1.5, "zd30tunnels_shaft", 1.5);
  reunion_ladder_scene();
  visionsetnaked("zd30tunnels_shaft", 1);
  thread shaft_top_planks_break();
}

reset_farah_glowstick() {
  stopFXOnTag(level._effect[level.farah.glowstick_vfx], level.farah.glowstick, "tag_fx");
  waitframe();
  playFXOnTag(level._effect[level.farah.glowstick_vfx], level.farah.glowstick, "tag_fx");
}

remove_mayhem_clip_under_ladder() {
  var_0 = getEnt("pre_mayhem_item_clip", "targetname");

  if(isDefined(var_0))
    var_0 delete();

  var_1 = getEnt("shaft_ladder_clip", "targetname");

  if(isDefined(var_1))
    var_1 delete();
}

wolf_tunnel_deadbodies() {
  thread wolf_tunnel_deadbody("wolf_tunnel_deadbody_1", "deadbody_1");
  thread wolf_tunnel_deadbody("wolf_tunnel_deadbody_2", "deadbody_2");
}

wolf_tunnel_deadbody(var_0, var_1) {
  wait 0.25;
  var_2 = scripts\engine\utility::getStruct(var_0, "targetname");
  var_3 = scripts\engine\sp\utility::spawn_targetname(var_1 + "_spawner", 1);
  var_3.animname = var_1;
  var_3.allowdeath = 0;
  var_3.ignoreme = 1;
  var_3.ignoreall = 1;
  var_3.noragdoll = 1;
  var_3.disabledeathorient = 1;
  var_3 endon("death");
  var_3 endon("entitydeleted");
  var_3 actoraimassistoff();
  var_3 thread scripts\engine\sp\utility::name_hide();
  var_3 scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::die_a_statue_new(var_2, "die_a_statue", 0.95);
  wait 0.5;
  var_4 = getgroundposition(var_3 getEye() + (0, 0, 4), 4);
  scripts\engine\utility::flag_wait("shaft_plank_passed");
  playFX(level._effect["deathfx_bloodpool_generic"], var_4);
}

shaft_reunion_corpse_cleanup() {
  clearallcorpses();
}

shaft_top_planks_break() {
  if(scripts\engine\utility::flag_exist("shaft_hero_planks_fall"))
    scripts\engine\utility::flag_wait("shaft_hero_planks_fall");

  var_0 = getscriptablearray("shaft_top_plank1", "targetname")[0];
  var_1 = getscriptablearray("shaft_top_plank2", "targetname")[0];
  var_0 setscriptablepartstate("base", "break");
  wait 0.75;
  var_0 setscriptablepartstate("base", "fall");
  wait 0.25;
  var_1 setscriptablepartstate("base", "break");
  wait 0.75;
  var_1 setscriptablepartstate("base", "fall");
  wait 1.5;
  level.shaft_hero_planks_clip delete();
}

reunion_magic_shoot_enemy() {
  self endon("death");
  var_0 = scripts\engine\utility::getStruct("shaft_magicbullet_struct", "targetname").origin;

  for(var_1 = randomintrange(4, 8); var_1 > 0; var_1--) {
    magicbullet("iw8_ar_akilo47", var_0, self getEye() + (0, 0, -16));
    wait(randomfloatrange(0.1, 0.15));
  }

  if(istrue(self.magic_bullet_shield))
    scripts\common\ai::stop_magic_bullet_shield();

  self kill();
}

reunion_ladder_scene() {
  scripts\engine\sp\utility::motion_blur_enable(0.1, undefined, 0.5);
  level.player hidelegs();
  level.player hideviewmodel();
  level.scr_model["player_rig"] = "viewhands_alex_fullbody";

  if(isDefined(level.player_rig))
    level.player_rig delete();

  var_0 = scripts\sp\player_rig::get_player_rig();
  setmusicstate("");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::tunnels_corpse_cleanup();
  var_1 = scripts\engine\utility::getStruct("shaft_ladder_scene", "targetname");
  var_1 thread scripts\common\anim::anim_first_frame_solo(level.player_rig, "shaft_ladder_intro");
  var_1 thread scripts\common\anim::anim_first_frame_solo(level.farah, "shaft_ladder_intro");
  thread reset_farah_glowstick();
  level.groundrefent = scripts\engine\utility::spawn_script_origin();
  level.groundrefent linkTo(level.player_rig, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player freezecontrols(1);
  level.player disableweapons();
  var_2 = 10;
  var_3 = 0.4;
  level.player playerlinktoblend(level.player_rig, "tag_player", var_3, 0.125, 0.125);
  wait(var_3);
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0);
  level.player playersetgroundreferenceent(level.groundrefent);
  level.player lerpviewangleclamp(1, 0, 0, var_2, var_2, var_2, var_2);
  level.player springcamenabled(0, 5, 5);
  level.player_rig show();
  level.farah scripts\engine\sp\utility::name_hide();
  thread reunion_mayhem(2.5);
  scripts\engine\utility::delaythread(2, scripts\engine\utility::exploder, "look_down_wood");
  thread shaft_ladder_scene_fail_vo();
  thread reunion_ladder_scene_dof();
  thread reunion_ladder_rumble();
  var_1 thread scripts\common\anim::anim_single_solo(level.shaft_ladder, "shaft_ladder_intro");
  var_1 scripts\common\anim::anim_single([level.player_rig, level.farah], "shaft_ladder_intro");
  var_1 thread scripts\common\anim::anim_loop([level.player_rig, level.farah], "shaft_ladder_intro_idle", "shaft_ladder_intro_idle_stop");
  var_4 = 1.75;
  thread reunion_waittill_player_left_stick_or_jump(var_4);
  scripts\engine\utility::flag_wait_any("reunion_pull_up_success", "reunion_pull_up_failed");
  var_1 notify("shaft_ladder_intro_idle_stop");
  scripts\engine\sp\utility::motion_blur_enable(1, undefined, 0.5);

  if(scripts\engine\utility::flag("reunion_pull_up_failed")) {
    level.groundrefent delete();
    level.player playSound("zd30t_shaft_ladder_fall_fail_whoosh");
    var_5 = spawn("trigger_radius_fire", level.player.origin, 0, 64, 80);
    thread scripts\sp\trigger::trigger_fire(var_5);
    var_5 enablelinkTo();
    var_5 linkTo(level.player, "tag_origin");
    var_1 scripts\common\anim::anim_single([level.player_rig, level.farah], "shaft_ladder_intro_fail");
    var_1 thread scripts\common\anim::anim_last_frame_solo(level.player_rig, "shaft_ladder_intro_fail");
    var_6 = 1.5;
    var_7 = 470;
    level.player_rig moveTo(level.player_rig.origin - (0, 0, var_7), var_6);
    level.player scripts\engine\utility::delaycall(1, ::playsound, "zd30t_shaft_ladder_fall_fail_impt");
    wait(var_6);
    level.player unlink();
    thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::player_burn_death_overlay(0.35);

    if(isalive(level.player))
      scripts\sp\utility::missionfailedwrapper();

    return;
  }

  thread shaft_reunion_corpse_cleanup();
  thread reunion_corpse(var_1);
  var_1 scripts\common\anim::anim_single([level.player_rig, level.farah], "shaft_ladder_climb");
  thread reunion_ladder_scene_farah_finish();
  thread reunion_ladder_scene_player_finish();
  scripts\engine\utility::flag_wait("shaft_plank_passed");
}

reunion_ladder_rumble() {
  wait 0.1;
  level.player playRumbleOnEntity("heavy_1s");
  wait 2.25;
  level.player playRumbleOnEntity("heavy_1s");
}

reunion_ladder_scene_dof() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);

  if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug())
    iprintlnbold("dof on ladder");

  level.player enablephysicaldepthoffieldscripting(1);
  level.player setphysicaldepthoffield(2.8, 20, 1, 2);
  wait 1.2;

  if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug())
    iprintlnbold("dof into fire");

  level.player setphysicaldepthoffield(2.8, 200, 1, 2);
  wait 4.5;
  level.player disablephysicaldepthoffieldscripting();
  wait 0.4;

  if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug())
    iprintlnbold("dof on farah");

  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 32, undefined, undefined, "tag_eye");
  scripts\engine\utility::flag_wait_any("reunion_pull_up_success", "reunion_pull_up_failed");

  if(scripts\engine\utility::flag("reunion_pull_up_failed")) {
    return;
  }
  wait 2.15;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();

  if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug())
    iprintlnbold("dof off");

  wait 4.85;

  if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug())
    iprintlnbold("dof on farah");

  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 3, undefined, undefined, "tag_eye");
  wait 2.75;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();

  if(scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::zd30_debug())
    iprintlnbold("dof off");

  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

reunion_ladder_scene_farah_finish() {
  level.farah waittillmatch("single anim", "end");
  level.farah.script_pushable = 0;
  level.farah pushplayer(1);
  level.farah.baseaccuracy = 0.6;
  level.farah scripts\engine\utility::set_movement_speed(170);
  level.farah scripts\engine\sp\utility::set_goal_radius(32);
  level.farah.ignoreall = 0;
  level.farah.ignoreme = 0;
  level.farah.script_pushable = 1;
  var_0 = getnode("wolf_tunnel_node_1", "targetname");
  level.farah scripts\engine\sp\utility::set_goal_node(var_0);
  level.farah scripts\engine\utility::waittill_any_timeout(5, "goal");
  level.farah scripts\engine\sp\utility::enable_ai_color();
}

reunion_mayhem(var_0) {
  wait(var_0);
  scripts\engine\utility::stop_exploder("fire_phase4_final");
  playmayhem("mayhem_reunion_ladder_collapse");
}

reunion_corpse(var_0) {
  var_0 scripts\common\anim::anim_single_solo(level.ladder_corpse, "shaft_ladder_climb");
  level.ladder_corpse thread scripts\sp\maps\tunnels\zd30tunnels_utility.gsc::die_a_statue();
}

reunion_ladder_scene_player_finish() {
  level.player_rig hide();
  level.player freezecontrols(0);
  level.player enableweapons();
  level.player springcamdisabled(1);
  level.player playersetgroundreferenceent(undefined);
  level.player unlink();
  level.player showlegs();
  level.player showviewmodel();
  level.groundrefent delete();
  level.farah scripts\engine\sp\utility::name_show();
  thread burn_player_if_goes_back_down_shaft();
}

burn_player_if_goes_back_down_shaft() {
  level endon("wolfdoor_open");
  level.inside_shaft_trig waittill("trigger");
  visionsetnaked("zd30tunnels_shaft_smoke_100", 3);
  shaft_fire_kill_player(0.75, 0);
}

reunion_waittill_player_left_stick_or_jump(var_0) {
  while(isDefined(level.player) && var_0 > 0) {
    if(level.player getnormalizedmovement()[0] > 0.3 || level.player jumpbuttonPressed()) {
      level thread scripts\engine\utility::flag_set_delayed("reunion_pull_up_success", 0.1);
      level.farah scripts\engine\utility::delaycall(0.05, ::stopsounds);
      return;
    }

    wait 0.05;
    var_0 = var_0 - 0.05;
  }

  level thread scripts\engine\utility::flag_set_delayed("reunion_pull_up_failed", 0.1);
}

shaft_ladder_scene_fail_vo() {
  level endon("reunion_pull_up_success");
  wait 2.65;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_reunion_rescue_54");
}