/*************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\tunnels\zd30tunnels_mineshaft.gsc
*************************************************************/

function precache_mineshaft() {
  precachemodel("weapon_wm_me_soscar_knife");
}

function mines_setup() {
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::setup_mine_carts();
  level.mines_backtrack_trig = getEnt("mines_backtrack_trig", "targetname");
  level.mines_backtrack_clip = getEnt(level.mines_backtrack_trig.target, "targetname");
  level.mines_backtrack_clip.origin -= (0, 0, 10000);
  level.mines_backtrack_clip connectpaths();
  var0 = getEnt("mineshaft_shared_oilfire_grabber", "targetname");
  level.mineshaft_shared_oil_fire = undefined;
  var1 = getEnt("mineshaft_martyr_oilfire_grabber", "targetname");
  level.mineshaft_martyr_oil_fire = undefined;

  foreach(var3 in level.oil_fires) {
    if(var0 istouching(var3)) {
      level.mineshaft_shared_oil_fire = var3;
    }

    if(var1 istouching(var3)) {
      level.mineshaft_martyr_oil_fire = var3;
    }
  }

  if(isDefined(level.mineshaft_shared_oil_fire)) {
    level.mineshaft_shared_oil_fire scripts\engine\utility::trigger_off();
    thread mineshaft_shared_oil_fire_on();
    return;
  }
}

function mine_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::set_start_location("mine", [level.player]);
  scripts\engine\utility::flag_set("shaft_split_vo_done");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::remove_hadir();
}

function mine_catchup() {
  scripts\engine\utility::flag_set("mine_reached");
  setsaveddvar("MMRNLMPPLT", "0");
  cinematicingameloop("sp_embassy_soccer_tv", 1);
  thread mines_second_collapse();
  thread mines_bridge_collapse();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::remove_hadir();
}

function mine() {
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

function mineshaft_shared_oil_fire_on() {
  level waittill("snake_fire_spread");
  scripts\engine\utility::trigger_on();
}

function mines_enter_vo() {
  scripts\engine\utility::flag_wait("mine_reached");
  scripts\engine\utility::flag_wait("shaft_split_vo_done");
  var0 = level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::time_since_spoke();
  var1 = 2;

  if(isDefined(var0) && var0 < var1) {
    wait var1 - var0;
  }

  level.player scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_alx_tunnels_alone_10");
  level scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_pri_tunnels_intro_11");
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_alx_tunnels_alone_20");
  wait 0.2;
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_alx_tunnels_alone_30");
}

function mines_push_cart_checkpoint() {
  while(!isDefined(level.mine_carts) || !isDefined(level.mine_carts["mine_cart_tutorial"])) {
    wait 0.1;
  }

  level.mine_carts["mine_cart_tutorial"] waittill("free_rolling");
  thread scripts\engine\sp\utility::autosave_now();
  clearallcorpses();
}

function mines_bridge_collapse() {
  var0 = getEnt("mines_bridge_collapse_oil_grabber", "targetname");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::monitor_oilfire(var0);
  var0 waittill("oilfire_detonated");
  scripts\engine\utility::flag_set("mines_bridge_collapsed");
  wait 2.5;
  playmayhem("my_vfx_mayh_mines_bridge_zd30");
}

function mines_second_collapse() {
  var0 = getEnt("mines_second_collapse_oil_grabber", "targetname");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::monitor_oilfire(var0);
  var0 waittill("oilfire_detonated");
  scripts\engine\utility::flag_set("mines_tunnel_collapsed");
  var1 = getEnt("spawn_mine_responders", "targetname");

  if(isDefined(var1)) {
    var1 delete();
  }

  level.mines_backtrack_trig waittill("trigger");
  level.mines_backtrack_clip.origin += (0, 0, 10000);
  level.mines_backtrack_clip disconnectPaths();
}

function mines_player_pistol_upgrade_monitor() {
  for(;;) {
    var0 = level.player getweaponslistall();

    if(var0.size > 0) {
      foreach(var2 in var0) {
        if(var2.basename == "iw8_pi_mike1911") {
          level.player takeweapon(var2);
          var2 = getcompleteweaponname("iw8_pi_mike1911", ["mag_mike1911", "rec_mike1911", "slide_tritium_mike1911"]);
          level.player giveweapon(var2);
          level.player switchtoweapon(var2);
          return;
        }
      }
    }

    wait 0.05;
  }
}

function mines_oilpush_scene() {
  scripts\engine\utility::flag_wait("player_through_cart");
  var0 = scripts\engine\utility::getStruct("shaft_fire_light_level_0", "targetname").origin;
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "shaft", var0);
  var1 = "mine_oilpush";
  var2 = scripts\engine\utility::getStruct(var1, "targetname");
  level.pusher1 = spawn_oil_pusher("pusher1");
  level.pusher2 = spawn_oil_pusher("pusher2");
  thread mines_lantern_think();
  level.mine_push_barrel = scripts\engine\sp\utility::spawn_anim_model("mine_push_barrel", var2.origin, var2.angles);
  level.spewing_barrels[level.spewing_barrels.size] = level.mine_push_barrel;
  var2 thread scripts\common\anim::anim_single_solo(level.mine_push_barrel, var1);
  waitframe();
  level.mine_push_barrel setanimtime(level.mine_push_barrel scripts\engine\utility::getanim(var1), 0.41);
  level.mine_push_barrel setanimrate(level.mine_push_barrel scripts\engine\utility::getanim(var1), 0);
  var3 = getEnt("mine_oilpush_trig", "targetname");
  var4 = scripts\engine\utility::getStruct(var3.target, "targetname");
  var3 waittill("trigger");
  var5 = 0;
  var6 = 360;

  while(!scripts\engine\sp\utility::player_looking_at(var4.origin, 0.8)) {
    if(scripts\engine\utility::flag("mines_tunnel_collapsed")) {
      level.pusher1 kill();
      level.pusher2 kill();
      level.mine_push_barrel delete();
      return;
    }

    if(!isDefined(level.pusher1) || !isalive(level.pusher1)) {
      var5 = 1;
      break;
    }

    if(!isDefined(level.pusher2) || !isalive(level.pusher2)) {
      var5 = 1;
      break;
    }

    if(level.pusher1 hasenemybeenseen(50) || level.pusher2 hasenemybeenseen(50)) {
      break;
    }

    wait 0.05;
  }

  LOC_000001e0:
    if(var5) {
      return;
    }

  thread light_the_fire_vo();
  thread oil_pusher1_anim(level.pusher1, var2);
  thread oil_pusher2_anim(level.pusher2, var2);
  level.mine_push_barrel setanimrate(level.mine_push_barrel scripts\engine\utility::getanim(var1), 1);
  level.mine_push_barrel waittillmatch("single anim", "end");
  var7 = getEnt("mine_oilpush_gulg", "targetname");
  level.oil_gulgs[level.oil_gulgs.size] = var7;
}

function oil_pusher1_anim(var0, var1) {
  self endon("death");
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread oil_pusher1_post_anim_behavior();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_aq1_tunnels_alone_120");
  self setanimrate(scripts\engine\utility::getanim(var1), 1);
  self waittillmatch("single anim", "end");
  level notify("oilpush_done", 1);
}

function oil_pusher1_post_anim_behavior() {
  self endon("death");
  thread oil_pusher_wakeup_think();
  level waittill("oilpush_done", var0);

  if(!istrue(var0)) {
    scripts\engine\sp\utility::anim_stopanimScripted();
  }

  scripts\common\utility::demeanor_override("sprint");
  self setgoalentity(level.player, 50);
  scripts\engine\sp\utility::set_goal_radius(128);
  self.escape_now = 1;
}

function oil_pusher2_anim(var0, var1) {
  self endon("death");
  self.ignoreall = 0;
  self.ignoreme = 0;
  thread oil_pusher2_post_anim_behavior();
  var2 = lookupsoundlength("dx_vom_aq1_tunnels_alone_120") / 1000;
  scripts\engine\utility::delaythread(1 + var2, &scripts\sp\maps\tunnels\zd30tunnels_utility::say, "dx_vom_aq2_tunnels_alone_130");
  self setanimrate(scripts\engine\utility::getanim(var1), 1);
  self waittillmatch("single anim", "end");
  level notify("oilpush_done", 1);
}

function oil_pusher2_post_anim_behavior() {
  self endon("death");
  thread oil_pusher_wakeup_think();
  thread oil_pusher2_martyr();
  thread oil_pusher2_escape();
  level waittill("oilpush_done", var0);

  if(!istrue(var0)) {
    scripts\engine\sp\utility::anim_stopanimScripted();
  }

  scripts\engine\utility::delaythread(0.5, &scripts\engine\sp\utility::smart_dialogue, "dx_vom_aq2_tunnels_ambusher_30");
  var1 = getnode("pusher2_goto", "targetname");
  scripts\engine\sp\utility::set_goal_radius(32);
  scripts\engine\sp\utility::set_goal_node(var1);
  self getenemyinfo(level.player);
  self waittill("goal");
  wait 1;
  self notify("turn_off_lantern");
}

function mines_lantern_think() {
  scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "turn_off_lantern");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "oil_fire_ignited");
  scripts\engine\sp\utility::do_wait_any();
  var0 = scripts\engine\utility::getStruct("mines_lantern", "targetname");
  radiusdamage(var0.origin, 4, 100, 99, level.player, "MOD_PISTOL_BULLET");
}

function oil_pusher2_martyr() {
  level endon("shaft_fire_on");
  self waittill("death");
  var0 = self gettagorigin("tag_accessory_left", 1);

  if(!isDefined(var0)) {
    var0 = self.origin + (0, 0, 20);
  }

  var1 = 1.5;
  var2 = magicgrenademanual("frag", var0, (0, 0, 0), var1);
  wait var1;
  var3 = getgroundposition(var0, 4);

  if(isDefined(var2) && isDefined(var2.origin)) {
    var3 = var2.origin;
  }

  playFX(level.g_effect["molotov_explosion"], var3);
  wait 1.5;

  if(istrue(level.mineshaft_martyr_oil_fire.fire_exploder_on)) {
    return;
  }

  level.mineshaft_martyr_oil_fire thread scripts\sp\maps\tunnels\zd30tunnels_utility::oilfire_run();
  level.mineshaft_martyr_oil_fire.oilfire_enabled = 0;
}

function oil_pusher2_escape() {
  scripts\engine\utility::flag_wait("shaft_fire_on");

  if(!isDefined(self)) {
    return;
  }

  var0 = self gettagorigin("tag_accessory_left", 1);

  if(!isDefined(var0)) {
    var0 = self.origin + (0, 0, 20);
  }

  scripts\common\utility::demeanor_override("sprint");
  thread scripts\engine\sp\utility::set_goal_node_targetname("mines_escape_to");
  scripts\engine\sp\utility::set_goal_radius(32);
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, 800);
  var1 = 3;
  var2 = magicgrenademanual("frag", var0, (0, 0, 0), var1);
  wait var1;
  playFX(level.g_effect["molotov_explosion"], var2.origin);
  wait 1.5;

  if(!istrue(level.mineshaft_martyr_oil_fire.fire_exploder_on)) {
    level.mineshaft_martyr_oil_fire thread scripts\sp\maps\tunnels\zd30tunnels_utility::oilfire_run();
    level.mineshaft_martyr_oil_fire.oilfire_enabled = 0;
    return;
  }
}

function oil_pusher_wakeup_think() {
  self endon("death");
  thread oil_pusher_wakeup_on_prox();

  if(!scripts\engine\utility::flag("mines_bridge_collapsed") && !scripts\engine\utility::flag("mines_tunnel_collapsed")) {
    scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any, "bullethit", "grenade danger", "damage");
    scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any, "bulletwhizby", "wakeup_on_prox");
    level scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "mines_tunnel_collapsed");
    level scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "mines_bridge_collapsed");
    scripts\engine\sp\utility::do_wait_any();
  }

  wait 0.1;
  level notify("oilpush_done");

  if(!isDefined(level.mine_push_barrel)) {
    return;
  }

  var0 = "mine_oilpush";
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  var2 = 0.52;
  var3 = level.mine_push_barrel getanimtime(level.mine_push_barrel scripts\engine\utility::getanim(var0), var0);

  if(var3 < var2) {
    level.mine_push_barrel stopanimScripted();
    return;
  }
}

function oil_pusher_wakeup_on_prox() {
  self endon("death");

  for(;;) {
    var0 = distance2d(level.player.origin, self.origin);

    if(var0 <= 350) {
      break;
    }

    if(var0 <= 500) {
      if(self hasenemybeenseen(50)) {
        var1 = 3;

        while(var1 > 0) {
          if(scripts\engine\utility::distance_2d_squared(level.player.origin, self.origin) <= 115600) {
            break;
          }

          var1 -= 0.05;
          wait 0.05;
        }

        break;
      }
    }

    wait 0.1;
  }

  self notify("wakeup_on_prox");
}

function light_the_fire_vo() {
  scripts\engine\utility::flag_wait("entered_shaft");
  wait 1;
  var0 = "dx_vom_aq1_tunnels_chamber_10";
  var1 = lookupsoundlength(var0) / 1000;
  var2 = scripts\engine\utility::getStructArray("shaft_enemy_chatter", "targetname");
  var3 = scripts\engine\utility::getclosest(level.player.origin, var2).origin;
  scripts\engine\utility::play_sound_in_space(var0, var3);
  wait var1;
}

function spawn_oil_pusher(var0) {
  var1 = scripts\engine\sp\utility::spawn_targetname(var0 + "Spawner", 1);
  var1.animname = var0;
  var1.allowdeath = 1;
  var1.ignoreall = 1;
  var1.ignoreme = 1;
  var1 thread scripts\sp\maps\tunnels\zd30tunnels_ai::battlechatter_off_spawn_func();
  var1 thread scripts\engine\sp\utility::name_hide();
  var1 thread scripts\sp\maps\tunnels\zd30tunnels_ai::shutup_when_hit();
  var1 scripts\engine\sp\utility::disable_long_death();
  thread oil_pusher_drop_pistol();
  var1 thread scripts\sp\nvg\nvg_ai::flashlight_on();
  var2 = "mine_oilpush";
  var3 = scripts\engine\utility::getStruct(var2, "targetname");
  var3 thread scripts\common\anim::anim_single_solo(var1, var2);
  waitframe();
  var1 setanimtime(var1 scripts\engine\utility::getanim(var2), 0.41);
  var1 setanimrate(var1 scripts\engine\utility::getanim(var2), 0);
  return var1;
}

function oil_pusher_drop_pistol() {
  self waittill("death");

  if(!scripts\sp\maps\tunnels\zd30tunnels_utility::player_has_pistol()) {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::enemy_force_pistol();
    return;
  }
}

function hint_push_cart_vo() {
  level endon("player_through_cart");
  level.mine_carts["mine_cart_tutorial"] endon("pushed");
  var0 = getEnt("hint_mine_cart_push", "targetname");

  for(;;) {
    var0 waittill("trigger");
    var1 = 500;
    var2 = scripts\engine\sp\utility::get_closest_ai(level.player.origin, "axis");

    if(isDefined(var2) && distancesquared(var2.origin, level.player.origin) < var1 * var1) {
      wait 0.05;
      continue;
    }

    break;
  }

  var3 = gettime();
  var4 = 0;
  var5 = 9;
  wait var5;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_50");

  for(;;) {
    var6 = var5 - 2;
    var7 = min(60, var5 + 2 + 6 * var4);
    wait randomfloatrange(var6, var7);
    var0 waittill("trigger");

    if((gettime() - var3) / 1000 > 45) {
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_60");
      wait randomfloatrange(1.5, 2.5);
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_70");
    } else if(scripts\engine\utility::cointoss()) {
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_50");
    } else {
      level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_80");
    }

    var4++;
  }
}

function hint_locked_doors_vo(var0, var1) {
  scripts\engine\utility::array_thread(getEntArray(var0, "targetname"), &hint_locked_door_think, var1);
}

function hint_locked_door_think(var0) {
  if(isDefined(var0)) {
    level endon(var0);
  }

  self waittill("trigger");
  wait 1;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_tunnels_alone_40");
}

function shaft_setup() {
  thread shaft_goal_volumes_setup();
  level.wolf_speakers = getEntArray("wolf_speaker", "targetname");
  scripts\engine\utility::array_thread(level.wolf_speakers, &wolf_speaker_destroyed_think);
  thread cut_pa_on_flag("wolf_door_unlocked");
  thread shaft_ab_light_prep();
  thread shaft_propane_kick_setup();
  level.fire_fill_hurt = getEnt("fire_fill_hurt", "targetname");
  level.fire_fill_hurt scripts\engine\utility::trigger_off();
  level.wolf_tunnel_fire_trig = getEnt("wolf_tunnel_exp_fire_trig", "targetname");
  level.wolf_tunnel_fire_trig scripts\engine\utility::trigger_off();
  level.shaft_hero_planks_clip = getEnt("hero_board_break", "targetname");
}

function shaft_goal_volumes_setup() {
  var0 = [];
  GscBinSkip0(0x2e, 0, getEnt("shaft_level_1", "targetname"));
}

function shaft_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::set_start_location("shaft", [level.player]);
  scripts\engine\utility::flag_set("player_through_cart");
  level.player takeallweapons();
  GscBinSkip1(0x45, 0, scripts\sp\utility::make_weapon("iw8_pi_mike1911"));
}

function shaft_catchup() {
  scripts\engine\utility::flag_set("player_through_cart");
  scripts\engine\utility::flag_set("entered_shaft");
  setsaveddvar("NQNQPRLRQM", 1);
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_shaft);
  thread shaft_epic_fire_catchup();
  thread shaft_fire_victim();
}

function shaft() {
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
  scripts\engine\utility::array_thread(getEntArray("shaft_ai_jump_down_block_trig", "targetname"), &shaft_ai_jump_down_think);
  thread hint_boost_vo();
  thread hint_shoot_on_ladder();
  thread shaft_difficulty_think();
  thread shaft_epic_fire();
  thread shaft_fire_victim();
}

function shaft_propane_kick_setup() {
  var0 = scripts\engine\utility::getStruct("propane_kick", "targetname");
  wait 0.25;
  var1 = getscriptablearray("shaft_propane_kick_scriptable", "targetname")[0];
  var1.animname = "shaft_propane_kick";
  var1 scripts\engine\sp\utility::assign_animtree();
  var2 = getstartorigin(var0.origin, var0.angles, var1 scripts\engine\utility::getanim("propane_kick"));
  var3 = getstartangles(var0.origin, var0.angles, var1 scripts\engine\utility::getanim("propane_kick"));
  var1.origin = var2;
  var1.angles = var3;
  var4 = var1.model;

  for(;;) {
    if(var4 != var1.model) {
      break;
    }

    if(!isDefined(var1)) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("shaft_propane_kick_detonated");
}

function shaft_epic_fire() {
  level.player endon("death");
  setup_dummy_flares();
  level.shaft_fire_on_level = -1;
  level.player.shaft_level_timer = [];
  thread shaft_smoke_vision_manager();
  scripts\engine\utility::flag_wait("shaft_fire_on");
  var0 = scripts\engine\utility::getStruct("shaft_final_ladder_obj", "targetname").origin;
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "ladder", var0);
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_ESCAPE");
  thread shaft_smoke_survival_vo();
  thread epic_scripted_fx();
  thread shaft_mayhem_tarps();
  thread shaft_mayhem_corner_collapse();
  thread shaft_mayhem_beam_crack();
  var1 = 80;
  scripts\engine\utility::exploder("shaft_smoke_start");
  visionsetnaked("zd30tunnels_shaft_smoke_20", 5);
  thread shaft_ladder_fall();
  scripts\engine\utility::delaythread(0.5, &shaft_ab_light_set, "mine_shaft_fire_01", 5);
  thread sfx_fire_context_enable();
  var2 = waittill_fire_reached_shaft_level(1, var1);
  var3 = 30 + var2;
  scripts\engine\utility::exploder("fire_phase1");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::checkpoint_loop(25, "reunion_reached");
  thread scripts\engine\utility::flag_set_delayed("fire_phase1_started", 2);
  scripts\engine\utility::delaythread(0.5, &shaft_ab_light_set, "mine_shaft_fire_02", 5);
  scripts\engine\utility::delaythread(5, &shaft_ab_light_set, "mine_shaft_fire_03", 2);
  scripts\engine\utility::delaythread(7, &shaft_ab_light_set, "mine_shaft_fire_04", 2);
  var2 = waittill_fire_reached_shaft_level(2, var3);
  var4 = 30 + var2;
  scripts\engine\utility::exploder("fire_phase2");
  scripts\engine\utility::exploder("fire_phase2_beam");
  scripts\engine\utility::stop_exploder("fire_spread_3");
  var2 = waittill_fire_reached_shaft_level(3, var4);
  var5 = 30 + var2;
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::tunnels_corpse_cleanup();
  level.fire_fill_hurt scripts\engine\utility::delaythread(3, &scripts\engine\utility::trigger_on);
  scripts\engine\utility::exploder("fire_phase3");
  scripts\engine\utility::exploder("fire_phase3_corner");
  scripts\engine\utility::exploder("fire_base_fill");
  scripts\engine\utility::exploder("smoke_phase3");
  scripts\engine\utility::stop_exploder("shaft_fire_start");
  scripts\engine\utility::stop_exploder("shaft_smoke_start");
  scripts\engine\utility::stop_exploder("fire_spread_1");
  var2 = waittill_fire_reached_shaft_level(4, var5);
  var6 = 20 + var2;
  scripts\engine\utility::exploder("fire_phase4");
  scripts\engine\utility::exploder("fire_phase4_final");
  var2 = waittill_fire_reached_shaft_level(5, var6);
  scripts\engine\utility::flag_wait("reunion_pull_up_success");
  scripts\engine\utility::exploder("fire_phase5");
  scripts\engine\utility::stop_exploder("smoke_phase3");
  wait 5;
  playmayhem("vfx_mayh_plank_break_01");
}

function sfx_fire_context_enable() {
  wait 3;
  setglobalsoundcontext("dusty", "");
}

function sfx_fire_context_disable() {
  setglobalsoundcontext("dusty", "yes");
}

function shaft_fire_victim() {
  var0 = scripts\engine\sp\utility::spawn_script_noteworthy("shaft_fire_victim", 1);

  while(!isDefined(var0) || !isalive(var0)) {
    wait 0.05;
  }

  var0 endon("death");
  var0 endon("entitydeleted");
  level.shaft_fire_victim = var0;
  var0 scripts\sp\maps\tunnels\zd30tunnels_utility::set_original_baseaccuracy(0.25);
  var0.ignoreall = 1;
  var0 scripts\engine\sp\utility::disable_surprise();
  var0 scripts\engine\sp\utility::set_ignoresuppression(1);
  var0 scripts\common\utility::demeanor_override("sprint");
  var1 = getnode("fire_victim_node", "targetname");
  var2 = getEnt("shaft_fire_victim_zone", "targetname");
  var0 waittill("goal");
  var3 = var0 scripts\engine\utility::waittill_any_return("bullethit", "shaft_mayhem_beam_crack");

  if(isDefined(var3) && var3 == "shaft_mayhem_beam_crack" && var0 istouching(var2)) {
    var4 = 48;

    if(scripts\engine\utility::distance_2d_squared(var0.origin, var1.origin) > var4 * var4) {
      wait 0.5;
      var0 thread scripts\sp\maps\tunnels\zd30tunnels_ai::enemy_death_by_fire(0);
      return;
    }

    var5 = scripts\engine\utility::getStruct("shaft_fire_victim_struct", "targetname");
    var5.angles += (0, 180, 0);
    var0.animname = "shaft_fire_victim";
    var0.allowdeath = 1;
    var0.noragdoll = 1;
    var0.disabledeathorient = 1;
    var0 thread scripts\sp\maps\tunnels\zd30tunnels_ai::battlechatter_off_spawn_func();
    var0 thread scripts\engine\sp\utility::name_hide();
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::cleanup_corpses_in_radius(var5.origin, 128);
    var0 thread scripts\asm\soldier\death::handleburndeathmodelswap();
    var0 thread scripts\asm\soldier\death::handleburndeathvfx();
    var0 thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_burn_death_scream();
    var0 scripts\engine\sp\utility::set_deathanim("burn_crawl_death");
    var5 scripts\common\anim::anim_single_solo(var0, "burn_crawl");
    var0 kill();
    return;
  }

  var1.ignoreall = 0;
  var2 = getnode("despawn_node", "script_noteworthy");
  var1 scripts\engine\sp\utility::set_goal_node(var2);
}

function shaft_mayhem_tarps() {
  scripts\engine\utility::noself_delaycall(0.25, &playmayhem, "mayhem_shaft_lower_tarp");
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_lower_tarp", (-1899, 1612, -1111));
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_lower2_trig", "mayhem_shaft_lower2_tarp", 1);
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_middle_trig", "mayhem_shaft_middle_tarp", 0.5);
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_middle2_trig", "mayhem_shaft_middle2_tarp", 0.25);
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_middle3_trig", "mayhem_shaft_middle3_tarp", 0.25);
  thread shaft_mayhem_tarp_burn_lookat_failsafe("mayhem_tarp_upper_trig", "mayhem_shaft_upper_tarp", 0.25);
}

function shaft_mayhem_tarp_burn_lookat_failsafe(var0, var1, var2) {
  var3 = getEnt(var0, "targetname");
  var4 = getEnt(var3.target, "targetname");
  var5 = scripts\engine\utility::getStruct(var4.target, "targetname");
  var3 waittill("trigger");
  scripts\sp\maps\tunnels\zd30tunnels_utility::waittill_player_lookat_failsafe(var5.origin, 0.8, undefined, undefined, var2, undefined, var4);
  thread sfx_tarp_mayhem(var1);
  playmayhem(var1);
}

function sfx_tarp_mayhem(var0) {
  if(var0 == "mayhem_shaft_lower2_tarp") {
    thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_lower2_tarp", (-1999, 1349, -959));
    return;
  }

  if(var0 == "mayhem_shaft_middle3_tarp") {
    thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_middle3_tarp", (-2127, 1367, -702));
    return;
  }

  if(var0 == "mayhem_shaft_upper_tarp") {
    thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_upper_tarp", (-2022, 1349, -476));
    return;
  }
}

function shaft_mayhem_corner_collapse() {
  var0 = "mayhem_shaft_corner_collapse";
  var1 = "mayhem_corner_collapse";
  var2 = getEnt(var1, "targetname");
  var2 waittill("trigger");
  var3 = scripts\engine\utility::getStruct(var2.target, "targetname");
  var3 scripts\engine\sp\utility::waittill_player_lookat(0.8, 0.25);
  scripts\engine\utility::stop_exploder("fire_phase3_corner");
  thread sfx_mayhem_corner_collapse();
  playmayhem(var0);
}

function sfx_mayhem_corner_collapse() {
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_corner_collapse_01", (-2177, 1375, -778));
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_corner_collapse_opp_01", (-2018, 1279, -778));
  wait 0.5;
  var0 = spawn("script_origin", (-2190, 1340, -778));
  var0 playLoopSound("scn_zd30_shaft_corner_mayhem_fire_lp");
}

function shaft_mayhem_beam_crack() {
  var0 = "mayhem_shaft_beam_crack";
  var1 = "mayhem_beam_crack";
  var2 = getEnt(var1, "targetname");
  var2 waittill("trigger");
  var3 = scripts\engine\utility::getStruct(var2.target, "targetname");
  var3 scripts\engine\sp\utility::waittill_player_lookat(0.8, 0.25);
  scripts\engine\utility::stop_exploder("fire_phase2_beam");
  thread sfx_mayhem_beam_crack();
  playmayhem(var0);

  if(isDefined(level.shaft_fire_victim) && isalive(level.shaft_fire_victim)) {
    level.shaft_fire_victim notify("shaft_mayhem_beam_crack");
  }

  var4 = getscriptablearray("beam_crack_propane", "targetname")[0];

  if(isDefined(var4) && isDefined(var4.model) && var4.model != "") {
    var4 setscriptablepartstate("base", "fire");
  }

  var5 = scripts\engine\utility::getStruct("beam_crack_dmg_struct", "targetname");
  var6 = var5.radius;
  var7 = var5.origin;
  var8 = 128;
  var9 = spawn("trigger_radius_fire", var7, 0, var6, var8);
  var9.script_multiplier = 5;
  var9.script_radius = var6;
  thread scripts\sp\trigger::trigger_fire(var9);
}

function sfx_mayhem_beam_crack() {
  var0 = spawn("script_origin", (-1986, 1627, -787));
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_beam_crack_01", (-1979, 1565, -803));
  var0 playLoopSound("scn_zd30_shaft_beam_mayhem_fire_lp");
}

function epic_scripted_fx() {
  level.shaft_scriptable_trigs = getEntArray("shaft_scriptable_trig", "targetname");
  scripts\engine\utility::array_thread(level.shaft_scriptable_trigs, &shaft_scriptables_think);
  level.shaft_lvl2_flicker_light = getEnt("shaft_lvl2_flicker_light", "script_noteworthy");
  var0 = scripts\engine\utility::getStructArray("shaft_lvl2_flicker_light_sparks", "targetname");
  scripts\engine\utility::array_thread(var0, &shaft_run_sparks, 1.25, 3.25);
  level.shaft_epic_vfx_trigs = getEntArray("shaft_epic_vfx_trig", "targetname");
  scripts\engine\utility::array_thread(level.shaft_epic_vfx_trigs, &shaft_epic_vfx_think);
}

function shaft_scriptables_think() {
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "ladder") {
    for(;;) {
      if(level.player isonladder() && level.player istouching(self)) {
        break;
      }

      wait 0.2;
    }
  } else {
    self waittill("trigger");
  }

  waitframe();
  var0 = getscriptablearray(self.target, "targetname");

  if(!isDefined(var0) || var0.size == 0) {
    return;
  }

  var1 = scripts\engine\sp\utility::get_average_origin(var0) + (0, 0, 24);
  var2 = var0[0].origin;

  while(!scripts\engine\sp\utility::player_looking_at(var1, 0.92, 1)) {
    wait 0.1;
  }

  if(!level.player istouching(self)) {
    return;
  }

  foreach(var4 in var0) {
    if(!isDefined(var4.classname)) {
      return;
    }

    if(isDefined(self.script_parameters)) {
      var5 = strtok(self.script_parameters, " ");
      var6 = "script_parameter of scriptable at: " + var4.origin + " is missing 'state min_delay max_delay'";
      var7 = var5[0];
      var8 = float(var5[1]);
      var9 = float(var5[2]);
      thread shaft_generic_scriptable_run(var4, var7, var8, var9);
      continue;
    }

    if(issubstr(var4.classname, "propane_tank")) {
      thread shaft_scriptable_propane_tank(var4);
      continue;
    }

    if(issubstr(var4.classname, "plywood_bare")) {
      thread shaft_scriptable_board(var4);
      continue;
    }

    if(issubstr(var4.classname, "plank_bridge")) {
      thread shaft_scriptable_plank(var4);
      continue;
    }

    if(issubstr(var4.classname, "pulley_fall")) {
      thread shaft_scriptable_pulley(var4);
      continue;
    }
  }
}

function shaft_scriptable_pulley(var0) {
  shaft_generic_scriptable_run(var0, "fall", 0.25, 0.5);
}

function shaft_scriptable_propane_tank(var0) {
  shaft_generic_scriptable_run(var0, "fire");
}

function shaft_scriptable_board(var0) {
  shaft_generic_scriptable_run(var0, "charred", 0.25, 0.5);
}

function shaft_scriptable_plank(var0) {
  shaft_generic_scriptable_run(var0, "charred", 0.25, 0.5);
}

function shaft_generic_scriptable_run(var0, var1, var2, var3) {
  if(isDefined(self.script_delay)) {
    wait float(self.script_delay);
  } else if(isDefined(var2) && isDefined(var3)) {
    wait randomfloatrange(var2, var3);
  }

  if(isDefined(var0.script_parameters)) {
    var1 = var0.script_parameters;
  }

  if(isDefined(var0.script_delay)) {
    wait float(var0.script_delay);
  }

  if(isDefined(self.target)) {
    var4 = getEntArray(self.target, "targetname");
    var5 = [];

    foreach(var7 in var4) {
      if(isDefined(var7) && isDefined(var7.classname) && var7.classname == "script_brushmodel") {
        var5 = var7;
      }
    }

    if(isDefined(var5) && var5.size > 0) {
      var5 = sortbydistance(var5, var0.origin);
      var9 = var5[0];

      if(isDefined(var9)) {
        var9 delete();
      }
    }
  }

  var0 setscriptablepartstate("base", var1);
}

function shaft_run_sparks(var0, var1) {
  var2 = self.origin;
  var3 = anglesToForward(self.angles);
  var4 = anglestoup(self.angles);
  var5 = spawnfx(level._effect["vfx_speaker_sparks"], self.origin, var3, var4);

  if(isDefined(self.script_delay)) {
    var0 = float(self.script_delay) * 0.5;
    var1 = float(self.script_delay) * 1.1;
  }

  for(;;) {
    wait randomfloatrange(var0, var1);
    triggerfx(var5);
  }
}

function shaft_epic_vfx_think() {
  self waittill("trigger");
  var0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var1 = [];

  if(isDefined(var0.target)) {
    var1 = scripts\engine\utility::getStructArray(var0.target, "targetname");
  }

  while(!scripts\engine\sp\utility::player_looking_at(var0.origin, 0.95)) {
    wait 0.05;
  }

  if(!level.player istouching(self)) {
    return;
  }

  if(isDefined(var1) && var1.size > 0) {
    foreach(var3 in var1) {
      var4 = "vfx_zd30_falling_debris";

      if(isDefined(var3.script_noteworthy)) {
        var4 = var3.script_noteworthy;
      }

      thread sfx_falling_debris(var3.origin);
      playFX(level._effect[var4], var3.origin);
    }

    return;
  }
}

function sfx_falling_debris(var0) {
  thread scripts\engine\utility::play_sound_in_space("zd30_shaft_debris_woodbreak", var0);
  wait 0.75;
  thread scripts\engine\utility::play_sound_in_space("zd30_shaft_debris_fireball_sm", var0 - (0, 0, 100));
}

function shaft_ab_light_prep() {
  wait 0.25;
  level.shaft_ab_lights = [];
  level.shaft_ab_lights[0] = "mine_shaft_fire_01";
  level.shaft_ab_lights[1] = "mine_shaft_fire_02";
  level.shaft_ab_lights[2] = "mine_shaft_fire_03";
  level.shaft_ab_lights[4] = "mine_shaft_fire_04";

  foreach(var1 in level.shaft_ab_lights) {
    var2 = getEntArray(var1, "targetname");

    foreach(var4 in var2) {
      if(!isDefined(var4)) {
        continue;
      }

      var4.original_intensity = var4 getlightintensity();
      var4 setlightintensity(0);
    }
  }
}

function shaft_ab_light_set(var0, var1) {
  scripts\engine\utility::array_thread(getEntArray(var0, "targetname"), &shaft_ab_light_set_internal, var0, var1);
}

function shaft_ab_light_set_internal(var0, var1) {
  if(!isDefined(self) || !scripts\engine\utility::array_contains(level.shaft_ab_lights, var0)) {
    return;
  }

  var2 = 1;

  if(var2 && isDefined(var1)) {
    var3 = 0.1;
    var4 = int(var1 / 0.1);

    for(var5 = 0; var5 < var4; var5++) {
      var6 = var5 / var4;
      var7 = self.original_intensity * var6;
      self setlightintensity(var7);
      wait var3;
    }
  }

  self setlightintensity(self.original_intensity);
}

function shaft_epic_fire_catchup() {
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_ESCAPE");
  thread scripts\engine\utility::exploder("fire_phase3");
  thread scripts\engine\utility::exploder("fire_phase3_corner");
  thread scripts\engine\utility::exploder("fire_base_fill");
  thread scripts\engine\utility::exploder("smoke_phase3");
  thread scripts\engine\utility::exploder("fire_phase4");
  thread scripts\engine\utility::exploder("fire_phase4_final");
  level.fire_fill_hurt scripts\engine\utility::trigger_on();
  thread epic_scripted_fx();
  scripts\engine\utility::delaythread(1, &shaft_ab_light_set, "mine_shaft_fire_02", 0.25);
  scripts\engine\utility::delaythread(1, &shaft_ab_light_set, "mine_shaft_fire_03", 0.25);
  scripts\engine\utility::delaythread(1, &shaft_ab_light_set, "mine_shaft_fire_04", 0.25);
  thread shaft_mayhem_tarps();
  thread shaft_mayhem_corner_collapse();
  thread shaft_mayhem_beam_crack();
}

function waittill_fire_reached_shaft_level(var0, var1) {
  level.player endon("death");
  var2 = var0 - 1;

  if(!isDefined(level.player.shaft_level_timer[var2])) {
    level.player.shaft_level_timer[var2] = 0;
  }

  if(!isDefined(var1)) {
    var1 = 9999;
  }

  var3 = 0;
  var4 = 0.2;
  var5 = 0;
  var6 = 30;

  while(level.player.max_shaft_level_index < var0) {
    if(var0 == 1 && !var5 && istrue(level.mine_carts["mine_cart"].moved_by_player)) {
      var7 = var1 - var3;

      if(var7 >= var6) {
        var3 = var1 - var6;
        var5 = 1;

        if(getdvarint("zd30_debug") > 1) {
          iprintlnbold("Shaft ground floor timer reduced to: " + var6);
        }
      }
    }

    var3 += var4;

    if(var3 > var1) {
      break;
    }

    level.player.shaft_level_timer[var2] = max(0, var1 - var3);
    wait var4;
  }

  level.shaft_fire_on_level = var0 - 1;
  var8 = 10;
  return min(var8, level.player.shaft_level_timer[var2]);
}

function shaft_fire_light_wobble_think() {
  self.original_angles = self.angles;
  var0 = 5;
  var1 = 12;
  var2 = 0.5;
  var3 = 0.75;

  for(;;) {
    var4 = randomfloatrange(var2, var3);
    var5 = self.original_angles + scripts\engine\utility::randomvectorrange(var0, var1);
    self rotateTo(var5, var4);
    wait var4;
  }
}

function shaft_fire_light_think() {
  self linkTo(level.shaft_fire_light, "tag_origin");
  self.initial_intensity = self getlightintensity();
  var0 = 0.5;
  var1 = 1;
  var2 = 0.2;
  var3 = 0.35;
  thread shaft_fire_light_flicker(var0, var1, var2, var3);
}

function shaft_fire_light_flicker(var0, var1, var2, var3) {
  for(;;) {
    var4 = randomfloatrange(var0, var1) * self.initial_intensity;
    self setlightintensity(var4);
    wait randomfloatrange(var2, var3);
  }
}

function setup_dummy_flares() {
  level.dummy_flares = getEntArray("dummy_flare", "targetname");
  scripts\engine\utility::array_thread(level.dummy_flares, &dummy_flares_snake_go);
}

function dummy_flares_snake_go() {
  self endon("death");
  self.dummy = 1;

  foreach(var1 in level.oil_fires) {
    if(self istouching(var1)) {
      while(!istrue(var1.fire_exploder_on)) {
        wait 0.25;
      }

      break;
    }
  }

  scripts\engine\utility::flag_set("shaft_fire_on");
  thread debug_oil_fire_snake();
  var3 = 30;
  var4 = self;

  while(isDefined(var4.target)) {
    var5 = scripts\engine\utility::getStruct(var4.target, "targetname");
    var6 = distance(self.origin, var5.origin);
    var7 = var6 / var3;
    self moveTo(var5.origin, var7);
    wait var7;
    var8 = getgroundposition(var5.origin, 4);
    self moveTo(var8, 0.05);
    wait 0.5;
    self moveTo(var5.origin, 0.05);
    wait 0.5;
    var4 = var5;
    level notify("snake_fire_spread");
  }

  wait 1;
  self delete();
}

function debug_oil_fire_snake() {
  self endon("death");

  while(getDvar("zd30_debug") == "1") {
    wait 0.1;
  }
}

function shaft_ladder_fall() {
  var0 = getEnt("shaft_ladder", "targetname");
  var1 = getEnt(var0.target, "targetname");
  var0 linkTo(var1, "tag_origin");
  level scripts\engine\utility::waittill_any_timeout(3.5, "oil_fire_barrel_explode");
  wait 0.35;
  thread scripts\engine\utility::play_sound_in_space("mayhem_zd30_shaft_base_ladder_collapse", (-2004, 1547, -1140));
  var2 = -95;
  var3 = 1.5;
  var4 = var3 - 0.05;
  var1 rotateroll(var2, var3, var4, 0.05);
  wait var3;
  var5 = 0.25;
  var6 = 3.25;
  var4 = var5 - 0.05;
  var1 rotateroll(var6, var5, 0.05, var4);
  wait var5;
  var6 *= -1;
  var1 rotateroll(var6, var5, var4, 0.05);
}

function mus_shaft() {
  wait 3;
  setmusicstate("mx_zd30_tunnel_fire_climb");
}

function shaft_difficulty_think() {
  var0 = level.player.gs.playergrenadebasetime;
  scripts\engine\utility::flag_wait("entered_shaft_low");
  level.player.gs.playergrenadebasetime = 12000;
  scripts\engine\utility::flag_wait("entered_shaft_mid");
  level.player.gs.playergrenadebasetime = 9000;
  scripts\engine\utility::flag_wait("entered_shaft_high");
  level.player.gs.playergrenadebasetime = 6000;
  scripts\engine\utility::flag_wait("wolf_killed");
  level.player.gs.playergrenadebasetime = var0;
}

function hint_boost_vo() {
  level.player endon("death");
  level endon("hint_boost_done");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_alx_tunnels_chamber_50");
}

function hint_shoot_on_ladder() {
  level.player scripts\engine\utility::ent_flag_init("shoot_on_ladder");
  var0 = 2;

  while(var0 > 0) {
    var0--;

    while(!level.player isonladder() || !scripts\sp\maps\tunnels\zd30tunnels_utility::player_has_pistol()) {
      wait 0.25;
    }

    thread notify_when_player_shot_on_ladder();
    thread scripts\engine\sp\utility::display_hint_forced("hint_shoot_on_ladder", 8, 0.25, level.player, "hint_shoot_on_ladder_off");

    while(level.player isonladder()) {
      wait 0.25;
    }

    if(!level.player scripts\engine\utility::ent_flag("shoot_on_ladder")) {
      level.player notify("hint_shoot_on_ladder_off");
      continue;
    }

    return;
  }
}

function notify_when_player_shot_on_ladder() {
  level.player endon("death");

  for(;;) {
    level.player waittill("weapon_fired");

    if(level.player isonladder()) {
      level.player scripts\engine\utility::ent_flag_set("shoot_on_ladder");
      level.player notify("hint_shoot_on_ladder_off");
    }
  }
}

function waittill_player_jump_or_timeout(var0) {
  if(isDefined(var0)) {
    var1 = var0;
  } else {
    var1 = 3;
  }

  while(var1 > 0) {
    if(level.player isjumping()) {
      return true;
    }

    waitframe();
    var1 -= 0.05;
  }

  return false;
}

function shaft_ai_jump_down_think() {
  self endon("death");
  self endon("entitydeleted");
  var0 = scripts\engine\utility::getStruct(self.target, "targetname");
  var1 = var0.radius;
  var2 = var0.origin;
  var3 = 256;

  for(;;) {
    jumpiffalse(!isDefined(level.mine_carts) || !isDefined(level.mine_carts["mine_cart"])) LOC_0000005a;
    wait 0.25;
  }

  for(;;) {
    var4 = undefined;

    if(level.mine_carts["mine_cart"] istouching(self)) {
      var4 = createnavobstaclebybounds(var2, (var1, var1, var3), (0, 0, 0));
    }

    while(level.mine_carts["mine_cart"] istouching(self)) {
      wait 0.25;
    }

    if(isDefined(var4)) {
      destroynavobstacle(var4);
    }

    wait 0.05;
  }
}

function shaft_smoke_survival_vo() {
  level endon("shaft_final_ladder_reached");
  level.player endon("death");
  var0 = [];
  GscBinSkip0(0x2e, var0.size, "dx_vom_alx_shaft_firehints_20");
}

function wait_look_up_or_timeout(var0, var1) {
  while(!isDefined(var1) || var1 > 0) {
    if(level.player getplayerangles()[0] < var0 * -1) {
      return true;
    }

    waitframe();

    if(isDefined(var1)) {
      var1 -= 0.05;
    }
  }

  return false;
}

function shaft_smoke_vision_manager() {
  level.player endon("death");
  level.player_smoke_death_time = int(40);
  level.smoke_death_timer = level.player_smoke_death_time;

  while(!scripts\engine\utility::flag("shaft_ladder_scene_execute")) {
    if(level.player.cur_shaft_level_index <= level.shaft_fire_on_level) {
      level notify("hint_boost_done");
      thread gas_playerexposedeffects();

      while(level.player.cur_shaft_level_index <= level.shaft_fire_on_level && !scripts\engine\utility::flag("shaft_ladder_scene_execute")) {
        var0 = int(max(0, level.shaft_fire_on_level - level.player.cur_shaft_level_index));
        level.smoke_death_timer -= 1;

        if(level.smoke_death_timer > 25 && var0 < 1) {
          level.player_is_safe_from_smoke = 1;
        } else {
          level.player_is_safe_from_smoke = 0;
        }

        if(level.smoke_death_timer <= 0 || var0 >= 3) {
          level.player.dead_from_smoke = 1;

          if(!scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
            level endon("smoke_cough_stop");
            shaft_fire_kill_player(3, 1, "shaft_ladder_scene_execute");
          } else {
            iprintlnbold("DEAD FROM SMOKE");
          }
        }

        wait 1;
      }

      level notify("smoke_cough_stop");
      wait 0.05;
      gas_playerrecovereffects();
    }

    level.smoke_death_timer = int(min(level.player_smoke_death_time, level.smoke_death_timer + 3));
    var0 = int(max(0, level.shaft_fire_on_level - level.player.cur_shaft_level_index));

    if(level.smoke_death_timer > 25 && var0 < 1) {
      level.player_is_safe_from_smoke = 1;
    } else {
      level.player_is_safe_from_smoke = 0;
    }

    wait 1;
  }

  level notify("smoke_cough_stop");
  level.player_is_safe_from_smoke = 1;
  wait 0.05;
  gas_playerrecovereffects();
}

function shaft_fire_kill_player(var0, var1, var2) {
  if(isDefined(var2)) {
    level endon(var2);
  }

  var3 = spawn("trigger_radius_fire", level.player.origin, 0, 32, 128);
  var3.script_multiplier = 5;
  var3.script_radius = 32;
  var3 enablelinkTo();
  var3 linkTo(level.player, "tag_origin");
  thread scripts\sp\trigger::trigger_fire(var3);

  if(!isDefined(var0)) {
    var0 = 3;
  }

  wait var0;

  if(istrue(var1)) {
    scripts\sp\player_death::set_custom_death_quote(64);
  }

  waitframe();
  level.player kill();
}

function gas_playerexposedeffects() {
  level.player endon("death");
  level endon("smoke_cough_stop");
  level.player endon("death");
  visionsetnaked("zd30tunnels_shaft_smoke_20", 5);
  level.player_smoke_vision = "zd30tunnels_shaft_smoke_20";
  setsaveddvar("NKTRSSTMRQ", -1);
  var0 = gettime();
  var1 = ["ges_ph_cough_a", "ges_ph_cough_b", "ges_ph_cough_c"];
  var2 = ["gas_player_cough_1", "gas_player_cough_3"];
  var3 = var1[0];
  var4 = var1;
  var5 = var2;
  var6 = 0.05;
  var7 = 0;
  var8 = 0;
  var9 = 500;
  var10 = 0.4;
  var11 = 1400;
  var12 = 2500;
  var13 = 2000;
  var14 = 2400;
  var15 = 0.03;
  var16 = 0.01;
  var17 = var0;
  var18 = 0.2;
  var19 = 0;
  var20 = 0.5;
  var21 = scripts\engine\math::normalize_value(var17, var17 + level.player_smoke_death_time * 1000, gettime());
  var22 = scripts\engine\math::factor_value(var11, var13, var21);
  var23 = scripts\engine\math::factor_value(var12, var14, var21);
  var24 = randomfloatrange(var22, var23);
  var25 = gettime() + var24;

  while(!scripts\engine\utility::flag("shaft_ladder_scene_execute")) {
    var0 = gettime();
    var21 = scripts\engine\math::normalize_value(var17, var17 + level.player_smoke_death_time * 1000, var0);

    if(level.player.cur_shaft_level_index < level.shaft_fire_on_level) {
      var26 = level.shaft_fire_on_level - level.player.cur_shaft_level_index;
      var21 = clamp(var21 * var26, 0, 1);
    }

    level.player_smoke_exposure = var21;

    if(var21 > var10 && !var8 && var0 >= var17 + var9) {
      playFXOnTag(level._effect["vfx_player_smoke_screen"], level.player, "tag_origin");
      var8 = 1;
    }

    if(var21 <= var10) {
      visionsetnaked("zd30tunnels_shaft_smoke_20", 5);
      level.player_smoke_vision = "zd30tunnels_shaft_smoke_20";
    } else if(var21 > var10 && var21 < 0.8) {
      visionsetnaked("zd30tunnels_shaft_smoke_50", 5);
      level.player_smoke_vision = "zd30tunnels_shaft_smoke_50";
      level.player_smoke_death_time = int(35);
    } else {
      visionsetnaked("zd30tunnels_shaft_smoke_70", 5);
      level.player_smoke_vision = "zd30tunnels_shaft_smoke_70";
      level.player_smoke_death_time = int(28);
    }

    if(var0 >= var25) {
      if(!var4.size) {
        var4 = var1;
      }

      if(!var5.size) {
        var5 = var2;
      }

      while(level.player isgestureplaying(var3)) {
        waitframe();
      }

      var27 = scripts\engine\utility::random(var4);
      var28 = scripts\engine\utility::random(var5);
      var3 = var27;

      if(should_play_cough_gesture() && var21 > var10) {
        level.player playgestureviewmodel(var27, undefined, 0, 0.75);
      }

      if(level.player scripts\sp\maps\tunnels\zd30tunnels_utility::is_done_speaking()) {
        level.player playSound(var28);
      }

      var4 = scripts\engine\utility::array_remove(var4, var27);
      var5 = scripts\engine\utility::array_remove(var5, var28);
      var22 = scripts\engine\math::factor_value(var11, var13, var21);
      var23 = scripts\engine\math::factor_value(var12, var14, var21);
      var24 = randomfloatrange(var22, var23);
      thread scripts\sp\maps\tunnels\zd30tunnels_utility::fake_player_damage(undefined, var24 * 0.5);
      var25 = gettime() + var24;
    }

    var29 = var18 * sin(var19);
    var19 = scripts\engine\math::wrap(0, 360, var19 + var20);
    var30 = scripts\engine\math::factor_value(0, var15, var21 + var29);
    var31 = scripts\engine\math::factor_value(0, var16, var21 + var29);
    var7 = scripts\engine\math::factor_value(0, var6, var21 + var18);

    if(var21 < var10) {
      var7 = 0.1;
      var30 = 0;
      var31 = 0;
    }

    waitframe();
  }
}

function should_play_cough_gesture() {
  if(level.player isthrowinggrenade()) {
    return false;
  }

  if(level.player islinked()) {
    return false;
  }

  if(!level.player isweaponsenabled()) {
    return false;
  }

  if(level.player isonladder()) {
    return false;
  }

  if(!level.player scripts\common\utility::is_weapon_allowed()) {
    return false;
  }

  if(level.player scripts\engine\sp\utility::isads() || scripts\engine\utility::flag("shaft_ladder_scene_execute") || istrue(level.player.dead_from_smoke) || istrue(level.player.pushing_mine_cart)) {
    return false;
  }

  if(isDefined(level.player.last_weapon_fire_time)) {
    var0 = 1;

    if((gettime() - level.player.last_weapon_fire_time) / 1000 < var0) {
      return false;
    }
  }

  return true;
}

function gas_playerrecovereffects(var0, var1, var2) {
  if(!isDefined(var0)) {
    var0 = 5;
  }

  if(isDefined(var1)) {
    var3 = var1;
  } else {
    var3 = "zd30tunnels_shaft_smoke_20";
  }

  if(isDefined(var3)) {
    var4 = var3;
  } else {
    var4 = 5;
  }

  visionsetnaked(var4, var4);
  level.player_smoke_vision = var4;
  stopFXOnTag(level._effect["vfx_player_smoke_screen"], level.player, "tag_origin");
  level.player.damage.deathsdooroverlaypulse fadeovertime(0.75);
  level.player.damage.deathsdooroverlaypulse.alpha = 0;
  level.player_smoke_exposure = 0;
}

function shaft_wolf_pa_vo() {
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
  scripts\engine\utility::array_thread(getEntArray("wolf_pa_trig", "targetname"), &wolf_pa_think);
  level.wolf_pa_queue = [];
  level.wolf_pa_cur_index = -1;
  var0 = 3;

  for(var1 = 0; var1 < level.wolf_pa_vo.size; var1++) {
    for(var2 = 0; var2 < level.wolf_pa_vo[var1].size; var2++) {
      var3 = level.wolf_pa_vo[var1][var2];
      var4 = strtok(var3, " ");
      var5 = 3;
      var6 = 3;
      var7 = 3;
      var8 = var4[0];
      var9 = get_closest_speaker();
      var10 = 0;
      var11 = 0;

      if(var4.size > 2) {
        var11 = float(var4[2]);
      } else {
        var10 = int(var4[1]);
      }

      if(var10 && level.wolf_pa_cur_index > var1 + 1) {
        if(getdvarint("zd30_debug") > 2) {
          iprintlnbold("PA: " + var8 + " skipped (cur_idx=" + level.wolf_pa_cur_index + ",play_idx=" + var1);
        }

        continue;
      }

      if(getdvarint("zd30_debug") > 2) {
        var12 = "";
        var13 = strtok(var8, "_");

        for(var14 = 3; var14 < var13.size; var14++) {
          var15 = "_";

          if(var14 == 3) {
            var15 = "";
          }

          var12 += var15 + var13[var14];
        }

        iprintlnbold("PA: " + var12 + " (" + var1 + 1 + ":" + var2 + 1 + "/" + level.wolf_pa_vo[var1].size + ")");
      }

      play_wolf_vo_on_this_speaker(var9, var8, var5, var6, var7);

      if(getdvarint("zd30_debug") > 2) {
        iprintlnbold("post_delay=" + var11 + "sec");
      }

      wait var11;
    }

    if(getdvarint("zd30_debug") > 2) {
      iprintlnbold("set_delay=" + var0 + "sec");
    }

    wait var0;
  }
}

function cut_pa_on_flag(var0) {
  scripts\engine\utility::flag_wait(var0);

  if(isDefined(level.wolf_pa_emitter)) {
    level.wolf_pa_emitter stopsounds();
    level.wolf_pa_emitter delete();
    return;
  }
}

function wolf_speaker_destroyed_think() {
  self setCanDamage(1);
  self.health = 100000;

  for(;;) {
    self waittill("damage", var0, var1);

    if(isDefined(var1) && isPlayer(var1)) {
      break;
    }

    self.health += var0;
  }

  var2 = anglesToForward(self.angles);
  var3 = anglestoup(self.angles);
  var4 = 2;
  var5 = self.origin + vectorNormalize(var2) * var4;
  scripts\engine\utility::delaycall(1, &playsound, "tv_shot_sparks");
  scripts\engine\utility::noself_delaycall(1.25, &playfx, level._effect["vfx_speaker_sparks"], var5, var2, var3);
  scripts\engine\utility::delaycall(3, &playsound, "tv_shot_sparks");
  scripts\engine\utility::noself_delaycall(3.25, &playfx, level._effect["vfx_speaker_sparks"], var5, var2, var3);
  self.destroyed = 1;
  self rotatepitch(20, 0.1);

  if(true) {
    if(isDefined(level.wolf_pa_emitter)) {
      level.wolf_pa_emitter stopsounds();
      waitframe();
      level.wolf_pa_emitter delete();

      if(getdvarint("zd30_debug") > 0) {
        return;
      }

      return;
    }

    return;
  }

  var6 = get_closest_speaker();
  level notify("move_to_next_speaker", var6);

  if(getdvarint("zd30_debug") > 0) {
    thread scripts\engine\utility::draw_line_for_time(self.origin, var6.origin, 1, 0.5, 0.5, 5);
    return;
  }
}

function play_wolf_vo_on_this_speaker(var0, var1, var2, var3) {
  if(isDefined(level.wolf_pa_emitter)) {
    level.wolf_pa_emitter delete();
  }

  level.wolf_pa_emitter = spawn("script_origin", self.origin);
  thread play_wolf_vo_speaker_debug();
  thread wolf_pa_move_to_next_speaker_monitor();
  scripts\sp\maps\tunnels\zd30tunnels_utility::wait_combat_cooldown(0.4, 3);
  level.wolf_pa_emitter scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter(var0, 1, 3);

  if(isDefined(level.wolf_pa_emitter)) {
    level.wolf_pa_emitter delete();
    return;
  }
}

function wolf_pa_move_to_next_speaker_monitor() {
  level.wolf_pa_emitter endon("death");
  level.wolf_pa_emitter endon("entitydeleted");

  for(;;) {
    level waittill("move_to_next_speaker", var0);
    level.wolf_pa_emitter moveTo(var0.origin, 0.25);
  }
}

function play_wolf_vo_speaker_debug() {
  level.wolf_pa_emitter endon("death");
  level.wolf_pa_emitter endon("entitydeleted");

  while(getdvarint("zd30_debug") > 0) {
    wait 1;
  }
}

function get_closest_speaker() {
  var0 = [];

  foreach(var2 in level.wolf_speakers) {
    if(!istrue(var2.destroyed)) {
      var0 = var2;
    }
  }

  if(var0.size == 0) {
    var4 = sortbydistance(level.wolf_speakers, level.player.origin);
    return var4[var4.size - 1];
  }

  var4 = sortbydistance(var1, level.player.origin);
  return var4[0];
}

function wolf_pa_think() {
  self endon("death");
  self waittill("trigger");
  level.wolf_pa_cur_index++;

  if(getdvarint("zd30_debug") > 2) {
    iprintlnbold("PA idx=" + level.wolf_pa_cur_index);
    return;
  }
}

function shaft_fire_debug_print() {
  var0 = 0.1;

  while(getdvarint("zd30_debug") > 1) {
    var1 = 7;
    var2 = 0.5;
    var3 = (0.65, 0.65, 0.75);
    var4 = level.player.max_shaft_level_index;
    var5 = level.player.cur_shaft_level_index;
    var6 = level.shaft_fire_on_level;
    var7 = "Player Reached Floor: " + var4 + 1 + " ( total time: " + int(var0) + " )";
    var7 = "Fire Reached Floor: " + var6 + 1;
    var7 = "Player's Current Floor: " + var5 + 1;

    if(isDefined(level.player.shaft_level_timer[var5])) {
      var8 = level.player.shaft_level_timer[var5];
      var7 += " ( remaining time: " + int(var8) + " )";
    }

    if(isDefined(level.smoke_death_timer) && isDefined(level.player_smoke_death_time)) {
      var7 = "Player's choke time: " + level.smoke_death_timer + "/" + level.player_smoke_death_time;

      if(isDefined(level.player_smoke_exposure)) {
        var7 = var7 + " ( exposure: " + int(level.player_smoke_exposure * 100) / 100 + " )";
      }
    }

    if(istrue(level.player_is_safe_from_smoke)) {
      var7 = "Player safe from smoke: Yes";
    } else {
      var7 = "Player safe from smoke: No";
    }

    if(isDefined(level.player_smoke_vision)) {
      var7 = "Shaft vision: " + level.player_smoke_vision;
    }

    if(isDefined(level.shaft_fire_light)) {
      if(istrue(level.shaft_fire_light.active)) {}
    }

    wait 0.1;
    var0 += 0.1;
  }
}

function reunion_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::set_start_location("reunion", [level.player]);
}

function reunion_setup() {
  wait 1;
  var0 = scripts\engine\utility::getStruct("shaft_ladder_scene", "targetname");
  level.shaft_ladder = scripts\engine\sp\utility::spawn_anim_model("shaft_ladder", var0.origin, var0.angles);
  var0 thread scripts\common\anim::anim_first_frame_solo(level.shaft_ladder, "shaft_ladder_intro");
}

function reunion_catchup() {
  thread wolf_tunnel_deadbodies();
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
}

function reunion() {
  scripts\engine\utility::flag_wait("reunion_reached");
  thread wolf_tunnel_deadbodies();
  waitframe();
  scripts\engine\utility::flag_wait("shaft_final_ladder_reached");
  var0 = scripts\engine\sp\utility::spawn_targetname("ladder_corpse", 1);
  var0.animname = "ladder_corpse";
  var0.ignoreall = 1;
  var0.ignoreme = 1;
  var0.allowdeath = 0;
  var0.noragdoll = 1;
  var0 thread scripts\engine\sp\utility::name_hide();
  var0 scripts\common\ai::magic_bullet_shield();
  var0 thread scripts\sp\maps\tunnels\zd30tunnels_ai::battlechatter_off_spawn_func();
  var0 scripts\common\ai::gun_remove();
  var0 scripts\sp\utility::context_melee_allow(0);
  level.ladder_corpse = var0;
  waitframe();
  var1 = getEnt("shaft_top_level_enemy_grabber", "targetname");
  var2 = getaiarray("axis");

  foreach(var4 in var2) {
    if(isDefined(var4) && isalive(var4) && var4 istouching(var1)) {
      if(var4 == level.ladder_corpse) {
        continue;
      }

      if(abs(var4.origin[2] - level.farah.origin[2]) < 360) {
        thread reunion_magic_shoot_enemy();
        continue;
      }

      var5 = randomfloatrange(1, 3);

      if(istrue(var4.magic_bullet_shield)) {
        var4 scripts\common\ai::stop_magic_bullet_shield();
      }

      var4.allowdeath = 1;
      var4 scripts\engine\utility::delaycall(var5, &kill);
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

function reset_farah_glowstick() {
  stopFXOnTag(level._effect[level.farah.glowstick_vfx], level.farah.glowstick, "tag_fx");
  waitframe();
  playFXOnTag(level._effect[level.farah.glowstick_vfx], level.farah.glowstick, "tag_fx");
}

function remove_mayhem_clip_under_ladder() {
  var0 = getEnt("pre_mayhem_item_clip", "targetname");

  if(isDefined(var0)) {
    var0 delete();
  }

  var1 = getEnt("shaft_ladder_clip", "targetname");

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function wolf_tunnel_deadbodies() {
  thread wolf_tunnel_deadbody("wolf_tunnel_deadbody_1", "deadbody_1");
  thread wolf_tunnel_deadbody("wolf_tunnel_deadbody_2", "deadbody_2");
}

function wolf_tunnel_deadbody(var0, var1) {
  wait 0.25;
  var2 = scripts\engine\utility::getStruct(var0, "targetname");
  var3 = scripts\engine\sp\utility::spawn_targetname(var1 + "_spawner", 1);
  var3.animname = var1;
  var3.allowdeath = 0;
  var3.ignoreme = 1;
  var3.ignoreall = 1;
  var3.noragdoll = 1;
  var3.disabledeathorient = 1;
  var3 endon("death");
  var3 endon("entitydeleted");
  var3 actoraimassistoff();
  var3 thread scripts\engine\sp\utility::name_hide();
  var3 scripts\sp\maps\tunnels\zd30tunnels_utility::die_a_statue_new(var2, "die_a_statue", 0.95);
  wait 0.5;
  var4 = getgroundposition(var3 getEye() + (0, 0, 4), 4);
  scripts\engine\utility::flag_wait("shaft_plank_passed");
  playFX(level._effect["deathfx_bloodpool_generic"], var4);
}

function shaft_reunion_corpse_cleanup() {
  clearallcorpses();
}

function shaft_top_planks_break() {
  if(scripts\engine\utility::flag_exist("shaft_hero_planks_fall")) {
    scripts\engine\utility::flag_wait("shaft_hero_planks_fall");
  }

  var0 = getscriptablearray("shaft_top_plank1", "targetname")[0];
  var1 = getscriptablearray("shaft_top_plank2", "targetname")[0];
  var0 setscriptablepartstate("base", "break");
  wait 0.75;
  var0 setscriptablepartstate("base", "fall");
  wait 0.25;
  var1 setscriptablepartstate("base", "break");
  wait 0.75;
  var1 setscriptablepartstate("base", "fall");
  wait 1.5;
  level.shaft_hero_planks_clip delete();
}

function reunion_magic_shoot_enemy() {
  self endon("death");
  var0 = scripts\engine\utility::getStruct("shaft_magicbullet_struct", "targetname").origin;

  for(var1 = randomintrange(4, 8); var1 > 0; var1--) {
    magicbullet("iw8_ar_akilo47", var0, self getEye() + (0, 0, -16));
    wait randomfloatrange(0.1, 0.15);
  }

  if(istrue(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self kill();
}

function reunion_ladder_scene() {
  scripts\engine\sp\utility::motion_blur_enable(0.1, undefined, 0.5);
  level.player hidelegs();
  level.player hideviewmodel();
  level.scr_model["player_rig"] = "viewhands_alex_fullbody";

  if(isDefined(level.player_rig)) {
    level.player_rig delete();
  }

  var0 = scripts\sp\player_rig::get_player_rig();
  setmusicstate("");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::tunnels_corpse_cleanup();
  var1 = scripts\engine\utility::getStruct("shaft_ladder_scene", "targetname");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.player_rig, "shaft_ladder_intro");
  var1 thread scripts\common\anim::anim_first_frame_solo(level.farah, "shaft_ladder_intro");
  thread reset_farah_glowstick();
  level.groundrefent = scripts\engine\utility::spawn_script_origin();
  level.groundrefent linkTo(level.player_rig, "tag_player", (0, 0, 0), (0, 0, 0));
  level.player freezecontrols(1);
  level.player disableweapons();
  var2 = 10;
  var3 = 0.4;
  level.player playerlinktoblend(level.player_rig, "tag_player", var3, 0.125, 0.125);
  wait var3;
  level.player playerlinktodelta(level.player_rig, "tag_player", 1, 0, 0, 0, 0);
  level.player playersetgroundreferenceent(level.groundrefent);
  level.player lerpviewangleclamp(1, 0, 0, var2, var2, var2, var2);
  level.player springcamenabled(0, 5, 5);
  level.player_rig show();
  level.farah scripts\engine\sp\utility::name_hide();
  thread reunion_mayhem(2.5);
  scripts\engine\utility::delaythread(2, &scripts\engine\utility::exploder, "look_down_wood");
  thread shaft_ladder_scene_fail_vo();
  thread reunion_ladder_scene_dof();
  thread reunion_ladder_rumble();
  var1 thread scripts\common\anim::anim_single_solo(level.shaft_ladder, "shaft_ladder_intro");
  var1 scripts\common\anim::anim_single([level.player_rig, level.farah], "shaft_ladder_intro");
  var1 thread scripts\common\anim::anim_loop([level.player_rig, level.farah], "shaft_ladder_intro_idle", "shaft_ladder_intro_idle_stop");
  var4 = 1.75;
  thread reunion_waittill_player_left_stick_or_jump(var4);
  scripts\engine\utility::flag_wait_any("reunion_pull_up_success", "reunion_pull_up_failed");
  var1 notify("shaft_ladder_intro_idle_stop");
  scripts\engine\sp\utility::motion_blur_enable(1, undefined, 0.5);

  if(scripts\engine\utility::flag("reunion_pull_up_failed")) {
    level.groundrefent delete();
    level.player playSound("zd30t_shaft_ladder_fall_fail_whoosh");
    var5 = spawn("trigger_radius_fire", level.player.origin, 0, 64, 80);
    thread scripts\sp\trigger::trigger_fire(var5);
    var5 enablelinkTo();
    var5 linkTo(level.player, "tag_origin");
    var1 scripts\common\anim::anim_single([level.player_rig, level.farah], "shaft_ladder_intro_fail");
    var1 thread scripts\common\anim::anim_last_frame_solo(level.player_rig, "shaft_ladder_intro_fail");
    var6 = 1.5;
    var7 = 470;
    level.player_rig moveTo(level.player_rig.origin - (0, 0, var7), var6);
    level.player scripts\engine\utility::delaycall(1, &playsound, "zd30t_shaft_ladder_fall_fail_impt");
    wait var6;
    level.player unlink();
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::player_burn_death_overlay(0.35);

    if(isalive(level.player)) {
      scripts\sp\utility::missionfailedwrapper();
    }

    return;
  }

  thread shaft_reunion_corpse_cleanup();
  thread reunion_corpse(var4);
  var4 scripts\common\anim::anim_single([level.player_rig, level.farah], "shaft_ladder_climb");
  thread reunion_ladder_scene_farah_finish();
  thread reunion_ladder_scene_player_finish();
  scripts\engine\utility::flag_wait("shaft_plank_passed");
}

function reunion_ladder_rumble() {
  wait 0.1;
  level.player playRumbleOnEntity("heavy_1s");
  wait 2.25;
  level.player playRumbleOnEntity("heavy_1s");
}

function reunion_ladder_scene_dof() {
  scripts\sp\utility::nvidiaansel_scriptdisable(1);

  if(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    iprintlnbold("dof on ladder");
  }

  level.player enablephysicaldepthoffieldscripting(1);
  level.player setphysicaldepthoffield(2.8, 20, 1, 2);
  wait 1.2;

  if(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    iprintlnbold("dof into fire");
  }

  level.player setphysicaldepthoffield(2.8, 200, 1, 2);
  wait 4.5;
  level.player disablephysicaldepthoffieldscripting();
  wait 0.4;

  if(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    iprintlnbold("dof on farah");
  }

  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 32, undefined, undefined, "tag_eye");
  scripts\engine\utility::flag_wait_any("reunion_pull_up_success", "reunion_pull_up_failed");

  if(scripts\engine\utility::flag("reunion_pull_up_failed")) {
    return;
  }

  wait 2.15;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();

  if(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    iprintlnbold("dof off");
  }

  wait 4.85;

  if(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    iprintlnbold("dof on farah");
  }

  level.farah thread scripts\engine\sp\utility::dof_enable_autofocus(2.8, 3, undefined, undefined, "tag_eye");
  wait 2.75;
  level thread scripts\engine\sp\utility::dof_disable_autofocus();

  if(scripts\sp\maps\tunnels\zd30tunnels_utility::zd30_debug()) {
    iprintlnbold("dof off");
  }

  scripts\sp\utility::nvidiaansel_scriptdisable(0);
}

function reunion_ladder_scene_farah_finish() {
  level.farah waittillmatch("single anim", "end");
  level.farah.script_pushable = 0;
  level.farah pushplayer(1);
  level.farah.baseaccuracy = 0.6;
  level.farah scripts\engine\utility::set_movement_speed(170);
  level.farah scripts\engine\sp\utility::set_goal_radius(32);
  level.farah.ignoreall = 0;
  level.farah.ignoreme = 0;
  level.farah.script_pushable = 1;
  var0 = getnode("wolf_tunnel_node_1", "targetname");
  level.farah scripts\engine\sp\utility::set_goal_node(var0);
  level.farah scripts\engine\utility::waittill_any_timeout(5, "goal");
  level.farah scripts\engine\sp\utility::enable_ai_color();
}

function reunion_mayhem(var0) {
  wait var0;
  scripts\engine\utility::stop_exploder("fire_phase4_final");
  playmayhem("mayhem_reunion_ladder_collapse");
}

function reunion_corpse(var0) {
  var0 scripts\common\anim::anim_single_solo(level.ladder_corpse, "shaft_ladder_climb");
  level.ladder_corpse thread scripts\sp\maps\tunnels\zd30tunnels_utility::die_a_statue();
}

function reunion_ladder_scene_player_finish() {
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

function burn_player_if_goes_back_down_shaft() {
  level endon("wolfdoor_open");
  level.inside_shaft_trig waittill("trigger");
  visionsetnaked("zd30tunnels_shaft_smoke_100", 3);
  shaft_fire_kill_player(0.75, 0);
}

function reunion_waittill_player_left_stick_or_jump(var0) {
  while(isDefined(level.player) && var0 > 0) {
    if(level.player getnormalizedmovement()[0] > 0.3 || level.player jumpbuttonPressed()) {
      level thread scripts\engine\utility::flag_set_delayed("reunion_pull_up_success", 0.1);
      level.farah scripts\engine\utility::delaycall(0.05, &stopsounds);
      return;
    }

    wait 0.05;
    var0 -= 0.05;
  }

  level thread scripts\engine\utility::flag_set_delayed("reunion_pull_up_failed", 0.1);
}

function shaft_ladder_scene_fail_vo() {
  level endon("reunion_pull_up_success");
  wait 2.65;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_reunion_rescue_54");
}