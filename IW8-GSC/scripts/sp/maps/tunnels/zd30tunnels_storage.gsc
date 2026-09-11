/***********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\tunnels\zd30tunnels_storage.gsc
***********************************************************/

function precache_storage() {}

function storage_setup() {
  thread storage_runner_cleared_detector();
}

function storage_runner_cleared_detector() {
  var0 = getEnt("storage_runner_passed", "targetname");
  var1 = 4;

  for(;;) {
    var0 waittill("trigger", var2);

    if(isDefined(var2) && isalive(var2) && istrue(var2.storage_runner) && !istrue(var2.cleared_storage)) {
      var1++;
      var2.cleared_storage = 1;
    }
  }
}

function storage_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::set_start_location("storage", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_utility::farah_teleport_and_reset("storage_farah");
}

function storage_catchup() {
  setomnvar("ai_fulllight", 1e-07);
  scripts\engine\utility::flag_set("storage_reached");
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
  thread storage_3rd_room_propane_tripwire();
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_storage);
}

function storage() {
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_storage);
  thread storage_enemy_hold_fire();
  thread storage_flank_weapon_watch();
  thread storage_surprise();
  thread storage_lmg_room_propane_detonation_think();
  thread storage_ambush_kickoff();
  thread storage_3rd_room_propane_tripwire();
  thread storage_tripwire_chain_defuse();
  scripts\engine\utility::flag_wait("storage_reached");
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
  level.farah scripts\common\utility::demeanor_override("combat");
  thread storage_room_2_lmg_buddy();
  scripts\engine\utility::flag_wait("storage_teapot_passed");
  thread scripts\sp\analytics::analytics_kleenex_update("Basement to Crates");
  thread scripts\engine\sp\utility::autosave_now();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::checkpoint_loop(25, "storage_final_room_reached");
  setomnvar("ai_fulllight", 1e-07);
  thread storage_first_room_enemy_whisper();
  thread storage_farah_combat_behavior();
  scripts\engine\utility::flag_wait("storage_ambush");
  thread scripts\engine\sp\utility::battlechatter_on("axis");
  wait 3;
}

function storage_lmg_room_propane_detonation_think() {
  var0 = getEnt("storage_lmg_propane_detonator", "targetname");

  for(;;) {
    var0 waittill("trigger", var1);

    if(isDefined(var1) && isPlayer(var1)) {
      break;
    }
  }

  thread scripts\sp\maps\tunnels\zd30tunnels_ai::set_off_storage_propane_tanks();
}

function storage_flank_weapon_watch() {
  var0 = getEnt("storage_flank_weapon_watch", "targetname");
  var0 waittill("trigger");
  scripts\engine\utility::flag_set("storage_player_flanking");

  for(;;) {
    level.player waittill("weapon_fired");

    if(level.player istouching(var0)) {
      wait 0.5;
      scripts\engine\utility::flag_set("storage_flank_weapon_fired");
      var1 = scripts\engine\utility::getStruct("storage_room_2_enemy_vo_struct", "targetname").origin;
      playworldsound("dx_vom_aq2_tunnels_search_145", var1);
      return;
    }
  }
}

function storage_ambush_kickoff() {
  var0 = getEnt("storage_ambush_runner_trig", "targetname");
  var1 = getEnt("storage_ambush_runner_trig2", "targetname");
  var2 = getEnt(var0.target, "targetname");
  var0 waittill("trigger");

  if(isDefined(level.storage_ambush_runner) && isalive(level.storage_ambush_runner)) {
    level.storage_ambush_runner thread scripts\sp\maps\tunnels\zd30tunnels_utility::ai_playSound("dx_vom_aq1_tunnels_hunt_66");
  }

  var2 scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_player_lookat, 0.9, 0.25);
  var1 scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "trigger");
  scripts\engine\sp\utility::do_wait_any();
  level.storage_ambush_runner notify("run_now");
}

function storage_enemy_hold_fire() {
  var0 = scripts\sp\maps\tunnels\zd30tunnels_ai::get_alive_enemies();

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::enable_dontevershoot();
  }

  scripts\engine\utility::flag_wait("storage_ambush");
  var0 = scripts\sp\maps\tunnels\zd30tunnels_ai::get_alive_enemies();

  foreach(var2 in var0) {
    var2 scripts\engine\sp\utility::disable_dontevershoot();
  }
}

function storage_propane_toss_scene() {
  storage_propane_toss();
}

function storage_propane_toss() {
  var0 = getEnt("storage_lmg_propane_trig", "targetname");
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = scripts\engine\utility::getStruct(var1.target, "targetname");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_ambush");
  scripts\engine\sp\utility::do_wait_any();
  var3 = getscriptablearray("storage_toss_propane", "targetname")[0];
  var4 = spawn("script_model", var1.origin);
  var4.angles = var1.angles;
  var5 = 7500;
  var6 = vectorNormalize(anglesToForward(var4.angles)) * var5;
  var4 setModel("decor_propane_tank_01_en_d1");
  waitframe();
  var7 = var4.origin + 10 * anglestoup(var4.angles) - 10 * anglesToForward(var4.angles);
  var4 physicslaunchserver(var7, var6);
  wait 1.25;
  var3 setscriptablepartstate("base", "fire");
  var3.origin = var4.origin;
  var3.angles = var4.angles;
  var4 delete();
  level notify("storage_propane_tossed");
}

function storage_surprise() {
  thread storage_surprise_vo();
  thread storage_surprise_propane_exploder();
  var0 = getEnt("storage_surprise_trig", "targetname");
  var1 = scripts\engine\sp\utility::spawn_targetname("storage_surprise_spawner", 1);
  var1.allowdeath = 1;
  var1.health = 50;
  var1.forcelongdeath = 4;
  var1.ignoreall = 1;
  var1.ignoreme = 1;
  var1.animname = "storage_surprise_guy";
  var2 = 1.25;
  thread skip_ambush_if_ambusher_died(var1);
  var1 scripts\common\ai::disable_exits();
  var1 scripts\common\ai::disable_turnanims();
  scripts\engine\sp\utility::set_grenadeammo(0);
  var1 endon("death");
  var1 endon("entitydeleted");
  var1 thread scripts\sp\maps\tunnels\zd30tunnels_ai::battlechatter_off_spawn_func();
  level.storage_surprise_guy = var1;
  var3 = "storage_surprise";
  var4 = scripts\engine\utility::getStruct(var3, "targetname");
  var4 scripts\common\anim::anim_first_frame_solo(var1, var3);
  storage_surprise_wait(var1, var0);
  var4 thread scripts\common\anim::anim_single_solo(var1, var3);
  waitframe();
  var1 setanimrate(var1 scripts\engine\utility::getanim(var3), var2);
  thread storage_surprise_shoot_on_notetrack(var1);
  wait 1.6 / var2;
  var1 stopanimScripted();
  var1 scripts\engine\sp\utility::set_maxfaceenemydist(8);
  var5 = getnode("storage_room_2_goto_delete_node", "targetname");
  var1 scripts\engine\sp\utility::set_goal_radius(32);
  var1 scripts\engine\sp\utility::set_goal_pos(var5.origin);
  var1.ignoreall = 0;
  var1.ignoreme = 0;
  GscBinSkip4(0x6e, var1, "chased", var2);
}

function skip_ambush_if_ambusher_died(var0) {
  level endon("storage_ambush");
  var0 waittill("death");
  scripts\engine\utility::flag_set("storage_ambush");
}

function respond_if_player_chases(var0) {
  var1 = 160;

  for(;;) {
    if(scripts\engine\utility::distance_2d_squared(level.player.origin, self.origin) < var1 * var1) {
      break;
    }

    wait 0.1;
  }

  self notify(var0);
  waitframe();
  scripts\sp\maps\tunnels\zd30tunnels_ai::zdt_rush_guy();
}

function storage_surprise_vo() {
  level endon("spawned_storage_3rd_room");
  level waittill("storage_surprise_happened");

  if(isDefined(level.farah)) {
    wait 1.3;
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_far_storage_hub_100", 1);
    return;
  }
}

function storage_surprise_shoot_on_notetrack(var0) {
  level notify("storage_surprise_started");
  var1 = getscriptablearray("storage_1st_room_propane", "targetname");
  var2 = 0.5;
  wait var2 / var0;
  level notify("storage_surprise_happened");
  var3 = (0, 0, 32);
  var4 = 5;

  for(var5 = 0; var5 <= var4; var5++) {
    if(isDefined(self) && isalive(self)) {
      self shoot();
    }

    if(!isDefined(var1[var5])) {
      break;
    }

    if(!isDefined(var1[var5].model) || var1[var5].model == "") {
      var5++;
      continue;
    }

    var6 = "smoke";
    var1[var5] setscriptablepartstate("base", var6);
    wait randomfloatrange(0.15, 0.25);
  }

  scripts\engine\utility::flag_set("storage_ambush");
  var1 = getscriptablearray("storage_1st_room_propane_group2", "targetname");

  foreach(var8 in var1) {
    var8 setscriptablepartstate("base", "smoke");
    wait randomfloatrange(0.25, 0.5);
  }
}

function waittill_propanes_exploded(var0) {
  wait 3.5;
}

function storage_surprise_propane_exploder() {
  wait 0.25;
  var0 = getscriptablearray("storage_1st_room_propane", "targetname");
  var1 = getscriptablearray("storage_1st_room_propane_group2", "targetname");
  var2 = scripts\engine\utility::array_combine(var0, var1);

  for(;;) {
    var3 = 0;

    foreach(var5 in var2) {
      if(isDefined(var5) && isDefined(var5.model) && var5.model == "") {
        var3 = 1;
        thread do_additional_damage();
        break;
      }

      wait 0.05;
    }

    wait 0.05;
  }

  LOC_000000a0:
    thread scripts\engine\utility::exploder("propane_bois");
}

function do_additional_damage() {
  self radiusdamage(self.origin + (0, 0, 4), 100, 150, 20);
}

function storage_surprise_wait(var0) {
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var2 = getEnt(var1.target, "targetname");
  var0 waittill("trigger");
  var3 = 0;
  var4 = 5;
  var5 = 0.05;

  for(;;) {
    if(level.player istouching(var0)) {
      var3 += var5;

      if(scripts\engine\sp\utility::player_looking_at(var1.origin, 0.9)) {
        break;
      }

      if(var3 >= var4) {
        break;
      }
    }

    if(level.player istouching(var2)) {
      break;
    }

    wait var5;
  }

  if(isDefined(level.storage_ambush_runner) && isalive(level.storage_ambush_runner)) {
    var6 = 70;

    while(isDefined(self) && isalive(self) && scripts\engine\utility::distance_2d_squared(level.storage_ambush_runner.origin, self.origin) < var6 * var6) {
      wait 0.05;
    }

    return;
  }
}

function storage_room_2_lmg_buddy() {
  scripts\engine\utility::flag_wait("storage_room_2_entered");
  var0 = scripts\engine\utility::getStruct("storage_lmg_buddy_look_at", "targetname").origin;

  while(!scripts\engine\sp\utility::player_looking_at(var0)) {
    wait 0.05;
  }

  var1 = getEnt("storage_lmg_buddy", "targetname");

  if(!isDefined(var1)) {
    return;
  }

  var1 notify("trigger");
}

function storage_tripwire_chain_defuse() {
  wait 1;
  scripts\engine\utility::array_thread(getEntArray("storage_tripwire_detector", "targetname"), &storage_tripwire_chain_defuse_think);
}

function storage_tripwire_chain_defuse_think() {
  var0 = [];

  foreach(var2 in level.tripwires.traps) {
    if(isDefined(var2) && var2 istouching(self)) {
      var0 = var2;
      thread storage_tripwire_chain_defuse_single(var2);
    }
  }

  self waittill("storage_tripwire_defused", var4);

  foreach(var2 in var0) {
    if(isDefined(var2) && isDefined(var2.defusehintstruct)) {
      if(isDefined(var4) && var2 == var4) {
        continue;
      }

      var6 = level.player;

      if(isDefined(level.farah)) {
        var6 = level.farah;
      }

      var2.defusehintstruct notify("trigger", level.farah);
      var2.defusehintstruct scripts\sp\player\cursor_hint::remove_cursor_hint();
      wait 0.2;
    }
  }
}

function storage_tripwire_chain_defuse_single(var0) {
  var0 endon("trigger");
  level endon("storage_tripwire_defused");

  if(!isDefined(var0.defusehintstruct)) {
    return;
  }

  var0.defusehintstruct waittill("trigger");
  self notify("storage_tripwire_defused", var0);
}

function storage_3rd_room_propane_tripwire() {
  wait 2;
  level.storage_3rd_room_propanes = getscriptablearray("storage_3rd_room_propane", "targetname");
  scripts\engine\utility::array_thread(level.storage_3rd_room_propanes, &storage_3rd_room_propane_set_exploder);
  scripts\engine\utility::array_thread(level.storage_3rd_room_propanes, &storage_3rd_room_propane_tripwire_think);
}

function storage_3rd_room_propane_set_exploder() {
  level endon("storage_3rd_room_propane_set_exploder");

  while(isDefined(self) && isDefined(self.model) && self.model != "") {
    wait 0.1;
  }

  thread scripts\engine\utility::exploder("propane_bois_2");
  level notify("storage_3rd_room_propane_set_exploder");
}

function storage_3rd_room_propane_tripwire_think() {
  while(isDefined(self) && isDefined(self.model) && self.model != "") {
    wait 0.1;
  }

  storage_3rd_room_setoff_tripwires();
}

function storage_farah_combat_behavior() {
  level.farah endon("death");
  scripts\engine\utility::flag_wait("farah_battlechatter_on");
  level.farah scripts\engine\utility::delaythread(2, &scripts\common\utility::demeanor_override, "combat");
}

function storage_first_room_enemy_whisper() {
  level.player endon("death");
  level endon("storage_surprise_started");
  var0 = getEnt("storage_vo_whisper", "targetname");
  var1 = getEnt(var0.target, "targetname");
  var0 waittill("trigger");
  var1 scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_aq1_tunnels_hunt_02");
  var1 scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_aq2_tunnels_hunt_04");
  wait 0.5;

  if(isDefined(level.farah) && isalive(level.farah)) {
    wait 1;
    return;
  }
}

function storage_oil_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::set_start_location("storage_oil", [level.player]);
  level.storage_do_not_spawn_runner = 1;
  scripts\sp\maps\tunnels\zd30tunnels_utility::farah_teleport_and_reset("storage_oil_farah");
}

function storage_oil_catchup() {
  scripts\engine\utility::flag_set("storage_final_room_entered");
}

function storage_oil() {
  scripts\engine\utility::flag_init("storage_oilfire_puzzle_fire_on");
  thread storage_oil_final_room_nags();
  scripts\engine\utility::flag_wait("storage_final_room_reached");
  thread storage_retreat_on_look_at();
  level.farah scripts\common\utility::demeanor_override("combat");
  thread storage_death_hint_think();
  level.storage_mg_shoot_zone = getEnt("mg_shoot_zone", "targetname");
  level.storage_mg_no_shoot_zone = getEnt("mg_no_shoot_zone", "targetname");
  level.storage_mg_shoot_wall_zone = getEnt("mg_shoot_wall_zone", "targetname");
  level.storage_mg_slow_reaction_zone = getEnt("mg_slow_reaction_zone", "targetname");
  var0 = getEnt("storage_room_1", "targetname");
  var1 = getEnt("storage_room_2a", "targetname");
  var2 = getEnt("storage_room_2b", "targetname");
  var3 = getEnt("storage_room_2c", "targetname");
  var4 = getEnt("storage_room_3", "targetname");
  thread monitor_player_deaths("storage_MG", var3, var4);
  thread magic_flash_enemy_vo(var4);
  var5 = scripts\sp\maps\tunnels\zd30tunnels_ai::get_alive_enemies();
  var6 = [];
  var7 = 0;

  foreach(var9 in var5) {
    if(issubstr(var9.classname, "_lmg") || isDefined(level.storage_lmg) && var9 == level.storage_lmg) {
      var7 = 1;
      continue;
    }

    if(isDefined(var9.script_noteworthy) && var9.script_noteworthy == "storage_ambusher") {
      continue;
    }

    if(isDefined(var9.script_noteworthy) && var9.script_noteworthy == "storage_ambusher_blind_fire") {
      continue;
    }

    if(var9 istouching(var1) || var9 istouching(var2)) {
      var6 = var9;
    }
  }

  if(!istrue(level.storage_do_not_spawn_runner)) {
    var6 = scripts\engine\sp\utility::spawn_targetname("storage_retreater", 1);
    var6 = scripts\engine\sp\utility::spawn_targetname("storage_retreater_2", 1);
  }

  wait 0.1;

  foreach(var9 in var6) {
    if(var12 == 0) {}

    if(isalive(var9)) {
      thread storage_redirect_enemies(var9, var3, var4);
    }
  }

  thread start_mg_nags();
  thread storage_3rd_room_spawn(var4);
  thread storage_oil_player_clear_vo();
  thread storage_mg_farah_behavior();
  thread storage_oilfire_puzzle();
  thread storage_mg_guy();
  thread storage_mg_coward();
  thread storage_mg_hint_objective();
  thread storage_mg_oilfire_scriptable_detonation();
  thread storage_mg_oilfire_setoff_other_propane_tanks();
}

function start_mg_nags() {
  level endon("spawned_storage_3rd_room");

  while(getaiarray("axis").size > 1) {
    level waittill("ai_killed");
  }

  wait 20;
  var0 = ["dx_vom_far_storage_hub_140", "dx_vom_far_storage_hub_150", "dx_vom_far_storage_hub_160"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  var0 = ["dx_vom_far_storage_hub_210", "dx_vom_far_storage_hub_220", "dx_vom_far_storage_hub_230"];
  var2 = scripts\engine\sp\utility::create_deck(var0, 0);
  var2.autoshuffle = 1;
  var3 = 15;
  var4 = 5;
  var5 = 1.2;
  var6 = 1.2;
  var7 = 45;
  var8 = 10;
  var9 = getEnt("storage_farah_nag_trig", "targetname");

  for(;;) {
    if(level.farah istouching(var9)) {
      var10 = var2 scripts\engine\sp\utility::deck_draw();
    } else {
      var10 = var1 scripts\engine\sp\utility::deck_draw();
    }

    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter(var10);
    wait randomfloatrange(var3 - var4, var3 + var4);
    var3 = min(var3 * var5, var7);
    var4 = min(var4 * var6, var8);
  }
}

function storage_oil_final_room_nags() {
  if(scripts\engine\utility::flag("storage_final_room_reached")) {
    return;
  }

  level endon("storage_final_room_reached");
  wait 15;
  var0 = ["dx_vom_far_storage_hub_140", "dx_vom_far_storage_hub_150", "dx_vom_far_storage_hub_160"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var2 = 15;
  var3 = 5;
  var4 = 1.2;
  var5 = 1.2;
  var6 = 45;
  var7 = 10;
  var8 = getEnt("storage_room_2a", "targetname");

  for(;;) {
    var9 = getaiarray("axis");
    var10 = 0;

    foreach(var12 in var9) {
      if(var12 istouching(var8)) {
        var10 = 1;
        break;
      }
    }

    if(var10) {
      wait 0.1;
      continue;
    }

    wait 0.8;
    scripts\sp\maps\tunnels\zd30tunnels_utility::wait_combat_cooldown(0.8);
    level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter(var1 scripts\engine\sp\utility::deck_draw());

    if(var1 scripts\engine\sp\utility::deck_is_empty()) {
      break;
    }

    wait randomfloatrange(var2 - var3, var2 + var3);
    var2 = min(var2 * var4, var6);
    var3 = min(var3 * var5, var7);
  }
}

function storage_oil_player_clear_vo() {
  level endon("storage_split_player_jumped");
  scripts\engine\utility::flag_wait("in_storage_mg_nest");

  while(getaiarray("axis").size > 0) {
    level waittill("ai_killed");
  }

  wait 0.4;
  scripts\sp\maps\tunnels\zd30tunnels_utility::wait_combat_cooldown(0.4, 1);
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_alx_storage_oil_mgnest_310");
}

function storage_retreat_on_look_at() {
  var0 = scripts\engine\utility::getStruct("storage_lmg_room_look_at", "targetname").origin;

  for(;;) {
    if(scripts\engine\sp\utility::player_looking_at(var0, 0.88)) {
      break;
    }

    if(scripts\engine\utility::flag("storage_final_room_reached_failsafe")) {
      break;
    }

    wait 0.05;
  }

  scripts\engine\utility::flag_set("storage_retreat_now");
}

function storage_mg_oilfire_scriptable_detonation() {
  wait 0.25;
  level.storage_mg_room_propanes = getscriptablearray("storage_MG_room_propane", "targetname");
  scripts\engine\utility::array_thread(level.storage_mg_room_propanes, &storage_mg_oilfire_scriptable_detonation_think);
}

function storage_mg_oilfire_scriptable_detonation_think() {
  level endon("storage_MG_room_oilfire_detonated");
  self endon("entitydeleted");

  while(isDefined(self) && isDefined(self.model) && self.model != "") {
    wait 0.1;
  }

  if(isDefined(level.storage_oil_fire) && !istrue(level.storage_oil_fire.fire_exploder_on)) {
    level.storage_oil_fire thread scripts\sp\maps\tunnels\zd30tunnels_utility::oilfire_run(0.05);
    level notify("storage_MG_room_oilfire_detonated");
    return;
  }
}

function storage_mg_oilfire_setoff_other_propane_tanks() {
  wait 0.25;

  for(;;) {
    if(istrue(level.storage_oil_fire.fire_exploder_on)) {
      break;
    }

    wait 0.05;
  }

  wait 0.5;

  foreach(var1 in level.storage_mg_room_propanes) {
    if(!isDefined(var1)) {
      continue;
    }

    radiusdamage(var1.origin, 50, 100, 90);
  }
}

function monitor_player_deaths(var0, var1, var2, var3) {
  level.player waittill("death");
  var4 = 0;

  if(level.player istouching(var1)) {
    var4 = 1;
  }

  if(isDefined(var2) && level.player istouching(var2)) {
    var4 = 1;
  }

  if(isDefined(var3) && level.player istouching(var3)) {
    var4 = 1;
  }

  if(var4) {
    scripts\sp\maps\tunnels\zd30tunnels_utility::register_player_deaths(var0);
    return;
  }
}

function storage_mg_hint_objective() {
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  wait 0.5;

  if(!isDefined(level.storage_mg_guy) || !isalive(level.storage_mg_guy)) {
    return;
  }

  var0 = getEnt("mg_shield", "targetname");
  var1 = var0.origin + (0, -24, 42);
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_FLANKMG");
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "mg_nest", var1);
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait_any, "storage_mg_passed", "in_storage_mg_nest");
  level.storage_mg_guy scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "death");
  scripts\engine\sp\utility::do_wait_any();
  wait 1;
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
  var2 = getnode("storage_mg_farah_idle_node", "targetname");
  var1 = var2.origin;
  scripts\engine\sp\objectives::objective_add_location_position("tunnels_search", "mines", var1);
  scripts\engine\sp\objectives::objective_update("tunnels_search", "current", undefined, &"ZD30/OBJ_TUNNELS_SEARCH");
}

function storage_death_hint_think() {
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  var0 = getEnt("storage_room_3", "targetname");

  while(!level.player istouching(var0)) {
    wait 0.05;
  }

  var1 = scripts\sp\maps\tunnels\zd30tunnels_utility::get_player_deaths("storage_MG");
  var2 = 71;

  if(var1 == 0) {
    return;
  } else if(var1 <= 1) {
    var2 = 71;
  } else if(var1 == 2) {
    var2 = 69;
  } else if(var1 == 3) {
    var2 = 67;
  } else if(var1 == 4) {
    var2 = 63;
  } else {
    var2 = scripts\engine\utility::random([63, 67, 69, 71]);
  }

  if(var2 == 69 && !level.player hasweapon("flash")) {
    var2 = scripts\engine\utility::random([63, 67, 71]);
  }

  scripts\sp\player_death::set_custom_death_quote(var2);
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "player_already_at_split");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "oil_fire_ignited");
  scripts\engine\sp\utility::do_wait_any();
  scripts\sp\player_death::clear_custom_death_quote();
}

function magic_flash_enemy_vo(var0) {
  scripts\engine\utility::flag_wait("enemy_magic_flash_vo");
  var1 = scripts\sp\maps\tunnels\zd30tunnels_ai::get_alive_enemies();

  if(!isDefined(var1) || var1.size == 0) {
    return;
  }

  var2 = sortbydistance(var1, level.player.origin);
  var3 = undefined;

  for(var4 = 0; var4 < var2.size; var4++) {
    var5 = var2[var4];

    if(var5 istouching(var0)) {
      var3 = var5;
    }
  }

  if(isDefined(var3)) {
    return;
  }
}

function storage_mg_farah_behavior() {
  level.farah endon("death");
  scripts\engine\utility::flag_wait("storage_final_room_entered");
  level.farah scripts\engine\utility::set_movement_speed(150);
  thread nag_storage_mg_nest_vo();
  wait 5;
  thread storage_mg_farah_suppression();
  var0 = getnode("storage_mg_farah_prep_node", "targetname");
  level.farah scripts\common\utility::demeanor_override("sprint");
  scripts\engine\utility::flag_wait("in_storage_mg_nest");

  if(!scripts\engine\sp\utility::player_looking_at(level.farah getEye(), 0.7) && !scripts\engine\sp\utility::player_looking_at(var0.origin, 0.7)) {
    level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_far_storage_oil_mgnest_320");
    level.farah teleport(var0.origin, var0.angles);
    level.farah scripts\engine\sp\utility::set_goalRadius(32);
    level.farah setgoalnode(var0);
    thread storage_mg_putout_fire(1);
    return;
  }

  storage_mg_putout_fire();
  level.farah scripts\engine\sp\utility::set_goalRadius(32);
  level.farah setgoalnode(var0);
}

function nag_while_near(var0, var1) {}

function storage_mg_putout_fire(var0) {
  if(isDefined(level.storage_oil_fire) && istrue(level.storage_oil_fire.fire_exploder_on)) {
    level.storage_oil_fire.kill_oilfire = 1;
    level.storage_oil_fire.fire_hp = 0;

    if(!istrue(var0)) {
      level.storage_oil_fire waittill("oil_fire_out");
    }

    if(isDefined(level.storage_oil_fire.puzzle_clip)) {
      level.storage_oil_fire.puzzle_clip waittill("puzzle_clip_off");
      return;
    }

    return;
  }
}

function storage_mg_farah_suppression() {
  level.farah thread scripts\engine\sp\utility::set_force_cover(1);
  level.storage_mg_guy scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittill_any, "death", "entitydeleted");
  level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "player_already_at_split");
  scripts\engine\sp\utility::do_wait_any();
  level.farah thread scripts\engine\sp\utility::set_force_cover(0);
}

function nag_storage_mg_nest_vo() {
  level.player endon("death");
  level endon("storage_mg_crawl_discover");
  level endon("in_storage_mg_nest");

  if(scripts\engine\utility::flag("storage_mg_crawl_discover") || scripts\engine\utility::flag("in_storage_mg_nest")) {
    return;
  }

  if(!isDefined(level.storage_mg_guy) || !isalive(level.storage_mg_guy)) {
    return;
  }

  level endon("storage_mg_crawl_discover");
  level endon("in_storage_mg_nest");
  level.storage_mg_guy endon("death");
  level.player endon("death");
  level.storage_mg_guy waittill("weapon_fired");
  wait 0.7;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_storage_oil_mgnest_10");
  wait 0.1;
  level.player scripts\engine\sp\utility::smart_player_dialogue("dx_vom_alx_storage_oil_mgnest_20");
  level waittill("break_in_turret_fire");
  level waittill("break_in_turret_fire");
  wait 0.8;
  level.farah scripts\engine\sp\utility::smart_dialogue("dx_vom_far_storage_oil_mgnest_60");
  var0 = ["dx_vom_far_storage_oil_mgnest_80", "dx_vom_far_storage_oil_mgnest_90"];
  var1 = scripts\engine\sp\utility::create_deck(var0, 0);
  var1.autoshuffle = 1;
  var0 = ["dx_vom_far_storage_oil_mgnest_100", "dx_vom_far_storage_oil_mgnest_110", "dx_vom_far_storage_oil_mgnest_120"];
  var2 = scripts\engine\sp\utility::create_deck(var0);
  var0 = ["dx_vom_far_storage_oil_mgnest_140", "dx_vom_far_storage_oil_mgnest_160", "dx_vom_far_storage_oil_mgnest_180"];
  var3 = scripts\engine\sp\utility::create_deck(var0);
  var0 = [];
  var0 = "dx_vom_far_storage_oil_mgnest_130";
  var0 = "dx_vom_far_storage_oil_mgnest_150";
  var0 = "dx_vom_far_storage_oil_mgnest_190";
  var0 = "dx_vom_far_storage_oil_mgnest_200";
  var0 = "dx_vom_far_storage_oil_mgnest_210";
  var4 = scripts\engine\sp\utility::create_deck(var0);
  var0 = ["dx_vom_far_storage_oil_mgnest_220", "dx_vom_far_storage_oil_mgnest_230"];
  var5 = scripts\engine\sp\utility::create_deck(var0);
  var6 = scripts\engine\sp\utility::create_deck(["use_flash", "use_molotov", "flank"], 0);

  for(;;) {
    level waittill("break_in_turret_fire");
    level waittill("break_in_turret_fire");
    level waittill("break_in_turret_fire");
    wait 0.8;

    if(istrue(level.storage_mg_guy.zd30_is_flashed)) {
      level.farah scripts\engine\sp\utility::smart_dialogue(var5 scripts\engine\sp\utility::deck_draw());
    } else {
      var7 = var6 scripts\engine\sp\utility::deck_draw();

      switch (var7) {
        case "flank":
          level.farah scripts\engine\sp\utility::smart_dialogue(var1 scripts\engine\sp\utility::deck_draw());
          break;
        case "use_flash":
          if(say_offhand_nag(var2, "flash")) {
            break;
          }

          var6 scripts\engine\sp\utility::deck_draw_specific("use_molotov");
        case "use_molotov":
          if(say_offhand_nag(var4, "molotov")) {
            break;
          }
        case "get_molotov":
          level.farah scripts\engine\sp\utility::smart_dialogue(var3 scripts\engine\sp\utility::deck_draw());
          break;
        default:
          break;
      }
    }

    wait 2;
  }
}

function say_offhand_nag(var0, var1) {
  var2 = level.player getammocount(var1) > 0;

  if(var2) {
    level.farah scripts\engine\sp\utility::smart_dialogue(var0 scripts\engine\sp\utility::deck_draw());
  }

  return var2;
}

function storage_redirect_enemies(var0, var1, var2) {
  self endon("death");
  storage_enemy_waittill_seen_or_hurt(2, 0.05);
  thread storage_enemy_temp_ignore(2.5);
  scripts\common\utility::demeanor_override("sprint");
  self.dontshootwhilemoving = 1;
  scripts\engine\sp\utility::set_maxfaceenemydist(8);
  self cleargoalvolume();
  self clearentitytarget();
  waitframe();
  self setgoalvolumeauto(var0);
  self waittill("goal");
  storage_enemy_waittill_seen_or_hurt(5, 0.05);
  thread storage_enemy_temp_ignore(1.5);
  self cleargoalvolume();
  self clearentitytarget();
  waitframe();
  self setgoalvolumeauto(var1);

  if(istrue(var2)) {
    thread scripts\sp\maps\tunnels\zd30tunnels_utility::delete_when_dist_away(level.player, 400);
    return;
  }

  self waittill("goal");
  self.dontshootwhilemoving = 0;
  scripts\engine\sp\utility::set_maxfaceenemydist(512);
  scripts\common\utility::clear_demeanor_override();
  thread scripts\sp\maps\tunnels\zd30tunnels_ai::storage_advancer_mg_aware();
}

function storage_enemy_waittill_seen_or_hurt(var0, var1) {
  self endon("death");
  level endon("storage_retreat_now");

  if(scripts\engine\utility::flag("storage_retreat_now")) {
    wait randomfloatrange(0.05, 1);
    return;
  }

  var0 = randomfloatrange(0.75, 1.25) * var0;
  var2 = self.health;
  var1 = int(var1 * 1000);

  while(!self hasenemybeenseen(var1)) {
    var0 -= 0.05;

    if(var0 <= 0) {
      break;
    }

    if(var2 != self.health) {
      break;
    }

    wait 0.05;
  }
}

function storage_enemy_temp_ignore(var0) {
  self endon("death");
  self endon("beenshot");
  level.player endon("death");
  GscBinSkip4(0x35);
}

function storage_enemy_temp_ignore_shot() {
  self endon("death");

  for(;;) {
    self waittill("damage", var0, var1);

    if(isDefined(var1) && var1 == level.player) {
      break;
    }
  }

  self notify("beenshot");
  self.ignoreall = 0;
}

function storage_3rd_room_spawn(var0) {
  var1 = 4;
  var2 = getEnt("storage_3rd_room_spawn_trig", "targetname");
  var2 waittill("trigger");
  level notify("spawned_storage_3rd_room");
  var3 = scripts\sp\maps\tunnels\zd30tunnels_ai::get_alive_enemies();
  var4 = 0;

  foreach(var6 in var3) {
    if(var6 istouching(var0)) {
      if(!isDefined(var6.targetname) || var6.targetname != "storage_mg_guy" && var6.targetname != "storage_mg_coward") {
        var4++;
      }
    }
  }

  if(var4 < var1) {
    var8 = getEnt(var2.target, "targetname");
    var8 notify("trigger", level.player);
    return;
  }
}

function storage_oilfire_puzzle() {
  var0 = getEnt("storage_oilfire_puzzle", "targetname");
  var1 = getEnt(var0.target, "targetname");
  var1.original_origin = var1.origin;
  var1 connectpaths();
  var1.origin -= (0, 0, 10000);
  level.storage_oil_fire = undefined;

  foreach(var3 in level.oil_fires) {
    if(var0 istouching(var3)) {
      level.storage_oil_fire = var3;

      while(!istrue(var3.fire_exploder_on)) {
        wait 0.05;
      }

      break;
    }
  }

  if(!isDefined(level.storage_oil_fire)) {
    return;
  }

  scripts\engine\utility::exploder("mg_nest_fire_stay");
  var5 = scripts\engine\utility::getStruct("storage_MG_linger_fire_dmg_struct", "targetname");
  var6 = var5.radius;
  var7 = var5.origin;
  var8 = 128;
  var9 = spawn("trigger_radius_fire", var7, 0, var6, var8);
  var9.script_multiplier = 5;
  var9.script_radius = var6;
  thread scripts\sp\trigger::trigger_fire(var9);
  level.storage_oil_fire.puzzle_clip = var1;

  while(isDefined(level.storage_oil_fire)) {
    var1 notify("puzzle_clip_on");
    scripts\engine\utility::flag_set("storage_oilfire_puzzle_fire_on");
    var1.origin = var1.original_origin;

    while(isDefined(level.storage_oil_fire) && istrue(level.storage_oil_fire.fire_exploder_on)) {
      wait 0.05;
    }

    var1.origin -= (0, 0, 10000);
    waitframe();
    var1 notify("puzzle_clip_off");
    scripts\engine\utility::flag_clear("storage_oilfire_puzzle_fire_on");

    while(!isDefined(level.storage_oil_fire) || !istrue(level.storage_oil_fire.fire_exploder_on)) {
      wait 0.05;
    }
  }
}

function storage_mg_guy() {
  var0 = scripts\engine\sp\utility::spawn_targetname("storage_mg_guy", 1);
  level.storage_mg_guy = var0;
  var0 endon("death");
  GscBinSkip4(0x6e, var0);
}

function storage_mg_guy_molotov_death() {
  thread storage_mg_guy_molotov_crawl("mg_crawl_1", 1);
  thread storage_mg_guy_molotov_crawl("mg_crawl_2", 1);
  level endon("player_entered_molotov_crawl_trigs");
  level endon("storage_mg_crawl");

  for(;;) {
    if(isDefined(self)) {
      if(istrue(self.burningtodeath) || scripts\engine\utility::flag("storage_oilfire_puzzle_fire_on")) {
        scripts\engine\utility::flag_set("mg_gunner_died_from_fire");
        self.nocorpse = 1;
        self delete();
        return;
      }
    } else {
      return;
    }

    wait 0.05;
  }
}

function storage_mg_guy_molotov_crawl(var0, var1) {
  level endon("player_entered_molotov_crawl_trigs");
  var2 = scripts\engine\utility::getStruct(var0, "targetname");
  var3 = getEnt(var2.target, "targetname");
  var2.angles += (0, 180, 0);
  var3 waittill("trigger");
  scripts\sp\maps\tunnels\zd30tunnels_utility::cleanup_corpses_in_radius(var2.origin, 128);

  if(!scripts\engine\utility::flag("mg_gunner_died_from_fire")) {
    return;
  }

  thread storage_mg_guy_molotov_crawl_anim(var2, var1);
  level notify("player_entered_molotov_crawl_trigs");
}

function storage_mg_guy_molotov_crawl_anim(var0, var1) {
  var2 = "storage_mg_guy";
  var3 = scripts\engine\sp\utility::spawn_targetname(var2 + "_burn", 1);
  var3.animname = var2;
  var3.allowdeath = 1;
  var3.noragdoll = 1;
  var3.ignoreme = 1;
  var3.ignoreall = 1;
  var3.disabledeathorient = 1;
  var3 thread scripts\sp\maps\tunnels\zd30tunnels_ai::battlechatter_off_spawn_func();
  var3 thread scripts\engine\sp\utility::name_hide();
  var3 thread scripts\asm\soldier\death::handleburndeathmodelswap();
  var3 thread scripts\asm\soldier\death::handleburndeathvfx();
  var3 scripts\engine\sp\utility::set_deathanim("burn_crawl_death");
  var0 scripts\common\anim::anim_single_solo(var3, "burn_crawl");
  var3 kill();
}

function storage_mg_guy_health_management() {
  self endon("death");
  self.health = 300;
  scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_mg_guy_health_reset");
  scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "off_of_MG");
  scripts\engine\sp\utility::do_wait_any();
  self.health = 50;
}

function storage_mg_guy_monitor_shot_by_player_near_mg_nest() {
  self endon("death");
  self endon("off_of_MG");
  scripts\engine\utility::ent_flag_init("shot_near_mg_nest");

  for(;;) {
    self waittill("damage", var0, var1);

    if(isDefined(var1) && isPlayer(var1) && level.player istouching(level.storage_mg_no_shoot_zone)) {
      scripts\engine\utility::ent_flag_set("shot_near_mg_nest");
      return;
    }
  }
}

function storage_mg_coward() {
  var0 = scripts\engine\utility::flag_wait_any_return("storage_mg_passed", "storage_mg_crawl");
  var1 = scripts\engine\sp\utility::spawn_targetname("storage_mg_coward", 1);
  var1 endon("death");
  var1 scripts\engine\sp\utility::set_grenadeammo(0);

  if(var0 == "storage_mg_crawl") {
    var1 scripts\common\utility::demeanor_override("sprint");
    var1 scripts\engine\utility::delaythread(0.75, &scripts\sp\maps\tunnels\zd30tunnels_utility::ai_playsound, "dx_vom_aq2_tunnels_ambusher_10");
    thread storage_mg_coward_monitor_death();
    var1 scripts\engine\sp\utility::set_goal_radius(32);
    var1 waittill("goal");
    var1 scripts\common\utility::clear_demeanor_override();
    wait 3;
    var1 scripts\engine\sp\utility::set_goal_radius(1024);
    var1 setgoalentity(level.player, 500);
    return;
  }

  var1 thread scripts\sp\maps\tunnels\zd30tunnels_ai::zdt_rush_guy();
}

function storage_mg_coward_monitor_death() {
  if(!isDefined(self) || !isalive(self) || !isDefined(level.storage_mg_guy) || !isalive(level.storage_mg_guy)) {
    return;
  }

  level.storage_mg_guy endon("off_of_MG");
  level.storage_mg_guy endon("death");

  for(;;) {
    self waittill("death", var0);

    if(isDefined(var0) && isPlayer(var0) && level.player istouching(level.storage_mg_no_shoot_zone)) {
      wait 1;
      level notify("coward_killed_near_mg_nest");
      return;
    }
  }
}

function turret_operator() {
  self endon("death");
  var0 = undefined;

  while(!isDefined(var0)) {
    var0 = self getturret();
    waitframe();
  }

  self notify("stop_using_built_in_burst_fire");
  var0 setturretteam("axis");
  var0 setrightarc(120);
  var0 setleftarc(120);
  var0 setbottomarc(45);
  var0 settoparc(30);
  var0 setconvergencetime(0.05, "yaw");
  var0 setconvergencetime(0.05, "pitch");
  var0.accuracy = 0.9;
  var0.maxrange = 50000;
  var0.aispread = 0;
  var0 setmode("manual_ai");
  var0.health = 99999;
  var0 makeunusable();
  var1 = scripts\sp\utility::make_weapon("iw8_lm_pkilo");
  var2 = spawn("weapon_" + createheadicon(var1), var0.origin + (-1, -15, 9));
  var2.angles = var0.angles;
  var2 linkTo(var0, "tag_flash");
  thread unlink_on_use();
  var0.turret_weapon = var2;
  var3 = getEnt("mg_shield", "targetname");
  var3 linkTo(var0, "tag_flash");
  GscBinSkip4(0x6e, var0, self, var2);
}

function unlink_on_use() {
  self waittill("trigger_progress");
  self unlink();
}

function turret_logic(var0) {
  var0 endon("death");
  level endon("in_storage_mg_nest");
  setup_overheat_sound_orgs();
  level.idle_target_trigs = getEntArray("mg_idle_target_trig", "targetname");

  foreach(var2 in level.idle_target_trigs) {
    var2.targets = getEntArray(var2.target, "targetname");

    foreach(var4 in var2.targets) {
      var4.use_count = 0;
    }
  }

  scripts\engine\utility::flag_wait("storage_final_room_entered");

  if(isDefined(level.farah)) {
    thread farah_monitor_mg_shot();
  }

  var7 = 3;
  var8 = 25;
  var9 = 35;
  var10 = 2.5;
  var11 = 1;
  var12 = 2;
  var13 = 0.25;
  var14 = 0.15;

  switch (scripts\common\utility::getdifficulty()) {
    case "easy":
      var8 = 25;
      var9 = 35;
      var10 = 2.5;
      var11 = 1;
      var12 = 2;
      var13 = 0.25;
      break;
    case "hard":
      var8 = 25;
      var9 = 35;
      var10 = 2.5;
      var11 = 1;
      var12 = 2;
      var13 = 0.25;
      break;
    case "fu":
      var8 = 25;
      var9 = 35;
      var10 = 2;
      var11 = 1;
      var12 = 2;
      var13 = 0.25;
      break;
    default:
      break;
  }

  thread storage_mg_player_lag(var13);

  for(;;) {
    var15 = randomintrange(var8, var9);
    playFXOnTag(scripts\engine\utility::getfx("vfx_storage_mg_tracer"), self.turret_weapon, "tag_flash");
    self.isshooting = 1;

    for(var16 = 0; var16 < var15; var16++) {
      var17 = get_storage_mg_target(var0);

      if(!isDefined(var17)) {
        wait 0.05;
        break;
      }

      self settargetentity(var17);

      if(isPlayer(var17) || isai(var17)) {
        var18 = (0, 0, 20);
      } else {
        var18 = (0, 0, 0);
      }

      if(isPlayer(var17) && isDefined(level.player.lagged_position)) {
        var19 = level.player.lagged_position - level.player.origin;
        var19 = (var19[0], var19[1], 0);
        var18 += var19;
      }

      var20 = self gettagorigin("tag_flash");
      var21 = self gettagangles("tag_flash");
      var22 = anglesToForward(var21);
      var23 = distance(level.player.origin, var20);
      var24 = var18 + var20 + var22 * var23 + scripts\engine\utility::randomvectorrange(var11, var12);
      var25 = (0, 0, -24);

      if(isPlayer(var17) || isai(var17)) {
        var24 += var25;
      }

      magicbullet("iw8_ar_akilo47_tunnels_mg", var20, var24, var0);
      playFXOnTag(scripts\engine\utility::getfx("vfx_muzzle_flash_ar_no_cull"), self.turret_weapon, "tag_flash");
      wait var14;
    }

    LOC_0000030b:
      stopFXOnTag(scripts\engine\utility::getfx("vfx_storage_mg_tracer"), self.turret_weapon, "tag_flash");
    self.isshooting = 0;
    var26 = self.turret_weapon gettagorigin("tag_flash");
    var27 = anglesToForward(self.turret_weapon gettagangles("tag_flash"));
    var28 = anglestoup(self.turret_weapon gettagangles("tag_flash"));
    playFX(level._effect["vfx_mg_overheat"], var26, var27, var28);
    thread scripts\engine\utility::play_sound_in_space("turret_overheat", get_overheat_org());
    level notify("break_in_turret_fire");

    if(istrue(var0.zd30_is_flashed)) {
      wait var7;
      continue;
    }

    wait var10;
  }
}

function get_overheat_org() {
  return level.turret_overheat_org;
}

function setup_overheat_sound_orgs() {
  var0 = getEntArray("turret_overheat_trig", "targetname");
  level.turret_overheat_org = scripts\engine\utility::getStruct(var0[0].target, "targetname").origin;
  scripts\engine\utility::array_thread(var0, &setup_overheat_sound_org);
}

function setup_overheat_sound_org() {
  level endon("in_storage_mg_nest");

  for(;;) {
    self waittill("trigger");
    level.turret_overheat_org = scripts\engine\utility::getStruct(self.target, "targetname").origin;
    wait 0.05;
  }
}

function storage_mg_tracer_remove_on_death(var0) {
  self waittill("death");

  if(!isDefined(var0)) {
    return;
  }

  if(!istrue(var0.isshooting)) {
    return;
  }

  stopFXOnTag(scripts\engine\utility::getfx("vfx_storage_mg_tracer"), var0, "tag_flash");
}

function storage_mg_player_lag(var0) {
  level.player endon("death");

  for(;;) {
    if(level.player istouching(level.storage_mg_shoot_zone)) {
      wait 0.1;
    } else {
      wait var0;
    }

    level.player.lagged_position = level.player.origin;
  }
}

function storage_mg_guy_flashbang_detector() {
  self endon("death");
  self endon("off_of_MG");
  scripts\common\utility::setflashbangimmunity(1);
  var0 = 3;
  var1 = getEnt("flashbang_detector", "targetname");

  for(;;) {
    var1 waittill("damage", var2, var3, var4, var5, var6, var7, var8, var9, var10, var11);

    if(scripts\engine\utility::isflashed() || isDefined(var11) && (var11.basename == "flash" || var11.basename == "flash_grenade")) {
      var12 = "Flashed !";

      if(int(getDvar("zd30_debug")) > 0) {
        var13 = int(var0 * 20);
      }

      self.zd30_is_flashed = 1;
      wait var0;
      self.zd30_is_flashed = 0;
    }
  }
}

function turret_owner_damage_func(var0, var1, var2, var3, var4, var5, var6, var7, var8, var9) {
  if(isDefined(var1) && var1 == level.player) {
    if(isDefined(self.magic_bullet_shield)) {
      scripts\common\ai::stop_magic_bullet_shield();
      return;
    }

    return;
  }
}

function farah_monitor_mg_shot() {
  level.farah endon("death");
  level.farah.last_shot_by_mg = gettime();

  for(;;) {
    level.farah waittill("damage", var0, var1);

    if(isDefined(var1) && isai(var1) && isDefined(level.storage_mg_guy) && level.storage_mg_guy == var1) {
      level.farah.last_shot_by_mg = gettime();
    }

    wait 0.1;
  }
}

function get_storage_mg_target(var0) {
  var1 = undefined;
  var2 = 3;

  if(isDefined(level.farah) && isalive(level.farah) && isDefined(level.farah.last_shot_by_mg)) {
    if(level.player istouching(level.storage_mg_no_shoot_zone) || gettime() - level.farah.last_shot_by_mg > var2 * 1000) {
      var1 = level.farah;
    }
  }

  if(shouldshootplayer(var0) && should_shoot_if_player_mounted()) {
    var1 = level.player;
  } else {
    var3 = undefined;

    foreach(var5 in level.idle_target_trigs) {
      if(level.player istouching(var5)) {
        var3 = var5;
      }
    }

    if(!isDefined(var3) && isDefined(level.farah) && isalive(level.farah)) {
      foreach(var5 in level.idle_target_trigs) {
        if(level.farah istouching(var5)) {
          var3 = var5;
        }
      }
    }

    if(!isDefined(var3)) {
      var3 = sortbydistance(level.idle_target_trigs, level.player.origin)[0];
    }

    var9 = "MG idle target trig and targets setup incorrectly";
    var1 = scripts\engine\utility::random(var3.targets);

    foreach(var11 in var3.targets) {
      if(var1.use_count > var11.use_count) {
        var1 = var11;
      }
    }

    var1.use_count++;
  }

  if(int(getDvar("zd30_debug")) >= 1 && isDefined(var0) && isai(var0)) {
    if(!isDefined(var1)) {
      var9 = "Target: NONE";
    } else if(var2 == level.farah) {
      var9 = "Target: Farah";
    } else if(var9 == level.player) {
      var9 = "Target: Player";
    } else {
      var9 = "Target: Idle";
    }

    var13 = 0.5;

    if(!isDefined(level.zd30_debug_mg_last_target_print_time) || gettime() - level.zd30_debug_mg_last_target_print_time > var13 * 1000) {
      level.zd30_debug_mg_last_target_print_time = gettime();
      var14 = int(var13 * 20);
    }
  }

  return var9;
}

function shouldshootplayer(var0) {
  if(level.player istouching(level.storage_mg_no_shoot_zone)) {
    return false;
  }

  if(var0 cansee(level.player)) {
    return true;
  }

  if(isDefined(level.storage_oil_fire) && istrue(level.storage_oil_fire.fire_exploder_on)) {
    return false;
  } else if(level.player istouching(level.storage_mg_shoot_zone)) {
    return true;
  }

  return false;
}

function should_shoot_if_player_mounted() {
  var0 = scripts\engine\utility::getStruct("mg_hole", "targetname").origin;

  if(level.player playermount() > 0.5) {
    if(!scripts\engine\sp\utility::player_looking_at(var0, 0.993, 1)) {
      return false;
    }
  }

  return true;
}

function storage_split_start() {
  level.player clearclienttriggeraudiozone(1);
  scripts\engine\sp\utility::set_start_location("storage_split", [level.player]);
  scripts\sp\maps\tunnels\zd30tunnels_utility::farah_teleport("storage_split_farah");
}

function storage_split_catchup() {
  level.player modifybasefov(level.fov_mine, 0.05);
  level.player scripts\sp\player::set_player_max_health(level.zd30_player_max_health_tunnels);
  level.scr_model["player_rig"] = "viewhands_alex_fullbody";
  scripts\sp\maps\tunnels\tunnels::farah();
  store_farah();
}

function storage_split() {
  thread analytics_storage();
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::remove_hadir();
  var0 = "storage_split_scene";
  var1 = scripts\engine\utility::getStruct(var0, "targetname");
  var1.trig = getEnt(var1.target, "targetname");
  var1.trig waittill("trigger");
  level.farah scripts\common\utility::clear_demeanor_override();
  waitframe();
  level.farah scripts\common\utility::demeanor_override("sprint");
  scripts\sp\maps\tunnels\zd30tunnels_utility::waittill_player_lookat_failsafe(level.farah getEye(), 0.8, undefined, level.farah, 0.05, undefined, undefined, 250, "player_already_at_split");
  var2 = 0;

  if(!level.farah istouching(var1.trig)) {
    var2 = 1;
  }

  scripts\engine\utility::flag_set("farah_storage_split_scene_start");
  thread storage_split_scene_farah(var1, var0, var2);
  thread storage_split_scene_player(var1, var0);

  while(isDefined(level.storage_mg_guy) && isalive(level.storage_mg_guy)) {
    if(scripts\engine\utility::flag("player_already_at_split") && isDefined(level.storage_mg_guy.magic_bullet_shield)) {
      level.storage_mg_guy scripts\common\ai::stop_magic_bullet_shield();
      break;
    }

    wait 0.25;
  }
}

function storage_split_scene_farah(var0, var1, var2) {
  if(var2 || scripts\engine\utility::flag("storage_split_player_jumped")) {
    var3 = getnode("storage_mg_farah_prep_node", "targetname");
    level.farah scripts\engine\sp\utility::set_goal_node(var3);
    wait 1;
    level.farah scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "goal");
    level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_split_player_jumped");
    scripts\engine\sp\utility::do_wait_any();

    if(!scripts\engine\utility::flag("player_already_at_split")) {
      thread storage_split_scene_farah(var0, var1, 0);
      waitframe();
      return;
    }

    var0 = scripts\engine\utility::getStruct("storage_split_scene_branch", "targetname");
  } else {
    var3 = getnode("storage_mg_farah_final_node", "targetname");
    var1 scripts\sp\anim::anim_reach_solo(level.farah, var2 + "_enter");
    level.farah thread scripts\sp\maps\tunnels\zd30tunnels_utility::say_as_chatter("dx_vom_far_storage_split_fall_50");
    var1 scripts\common\anim::anim_single_solo(level.farah, var2 + "_enter");
    level.farah setanimrate(level.farah scripts\engine\utility::getanim(var2 + "_enter"), 1.5);
    var1 thread scripts\common\anim::anim_loop_solo(level.farah, var2 + "_enter_idle");
    scripts\sp\maps\tunnels\zd30tunnels_utility::waittill_player_lookat_failsafe(level.farah getEye(), 0.8, undefined, level.farah, 0.05, undefined, undefined, 170, "storage_split_player_jumped");
    level.farah scripts\engine\sp\utility::anim_stopanimScripted();
    var1 notify("stop_loop");
    level.farah notify("stop_nag");
    level.farah scripts\engine\sp\utility::name_hide();
    level.farah.script_pushable = 0;

    if(scripts\engine\utility::flag("storage_split_player_legs_hide")) {
      thread storage_split_scene_farah(var1, var2, 1);
      waitframe();
      return;
    }

    var1 thread scripts\common\anim::anim_single_solo(level.farah, var2 + "_intro");
    var4 = "storage_split_skip_to_jump_monitor_kill";
    thread storage_split_skip_to_jump_monitor(var4);
    level scripts\engine\sp\utility::add_wait(&scripts\engine\utility::flag_wait, "storage_split_player_jumped");
    level.farah scripts\engine\sp\utility::add_wait(&scripts\engine\sp\utility::waittill_msg, "storage_split_skip_to_jump");
    level.farah scripts\engine\sp\utility::add_wait(&scripts\engine\utility::waittillmatch_any_return, "single anim", "end");
    scripts\engine\sp\utility::do_wait_any();
    level notify(var4);
    thread storage_split_scene_farah_vo(var1, var2);
  }

  scripts\engine\utility::flag_wait("storage_split_player_jumped");
  level.farah notify("stop_nag");
  thread storage_split_scene_farah_jump(var1, var2, var3);
}

function storage_split_scene_farah_vo(var0, var1) {
  var2 = ["dx_vom_far_storage_split_fall_20", "dx_vom_far_storage_split_fall_30", "dx_vom_far_storage_split_fall_40"];
  nag_interval(level.farah, var0, var1 + "_intro", 2, 3, var2, undefined, 25);

  if(!scripts\engine\utility::flag("storage_split_player_jumped")) {
    var0 thread scripts\common\anim::anim_loop_solo(level.farah, var1 + "_intro_idle");
    return;
  }
}

function nag_interval(var0, var1, var2, var3, var4, var5, var6) {
  self endon("death");
  self endon("entitydeleted");
  self endon("stop_nag");
  var7 = var1 + "_idleonce";
  var8 = var1 + "_idle";
  var9 = var1 + "_nag";

  if(isDefined(var5)) {
    var0 endon(var5);
    level endon(var5);
    self endon(var5);
  }

  if(isarray(var4)) {
    var4 = scripts\engine\sp\utility::create_deck(var4);
  }

  if(!isDefined(var6)) {
    var6 = 100000;
  }

  var10 = randomintrange(var2, var3);
  var11 = 0;
  var12 = 0;

  while(var12 < var6) {
    var0 scripts\common\anim::anim_single_solo(self, var7);
    var11++;

    if(var11 == var10) {
      var12++;

      if(isDefined(var4)) {
        scripts\engine\utility::delaythread(1, &scripts\engine\sp\utility::smart_dialogue, var4 scripts\engine\sp\utility::deck_draw());
      }

      var0 scripts\common\anim::anim_single_solo(self, var9);
      var10 = randomintrange(var2, var3);
      var11 = 0;
    }
  }
}

function storage_split_skip_to_jump_monitor(var0) {
  level endon(var0);
  var1 = 0;

  while(!var1) {
    if(scripts\engine\utility::flag("storage_split_player_jumped")) {
      var1 = 1;
    }

    if(var1) {
      level.farah notify("storage_split_skip_to_jump");
    }

    wait 0.05;
  }
}

function storage_split_scene_farah_jump(var0, var1, var2) {
  level.farah scripts\engine\sp\utility::anim_stopanimScripted();
  var0 notify("stop_loop");
  waitframe();
  var0 scripts\common\anim::anim_single_solo(level.farah, var1 + "_jump");
  var0 thread scripts\common\anim::anim_loop_solo(level.farah, var1 + "_jump_idle");
  wait 5;
  var0 notify("stop_loop");
  var0 scripts\common\anim::anim_single_solo(level.farah, var1 + "_jump_exit");
  level.farah scripts\engine\sp\utility::set_goal_node(var2);
  level.farah scripts\engine\sp\utility::set_goal_radius(28);
  level.farah scripts\engine\utility::waittill_any_timeout(5, "goal");
  store_farah();
}

function storage_split_scene_player(var0, var1) {
  scripts\engine\utility::flag_wait("storage_split_player_legs_hide");
  level.player hidelegs();
  scripts\engine\utility::flag_wait("storage_split_player_jumped");
  level.player playSound("ZD30T_basement_split_jump_land_plr_lr");
  scripts\sp\maps\tunnels\zd30tunnels_utility::pitch_up_set(88);

  if(isDefined(level.player_rig)) {
    level.player_rig delete();
  }

  level.scr_model["player_rig"] = "viewhands_alex_fullbody";
  var2 = level.player getplayerangles();
  var3 = scripts\engine\utility::getStruct("storage_split_player_orient", "targetname");
  var4 = anglesToForward(var2);
  var5 = vectorNormalize(scripts\engine\utility::flatten_vector(var3.origin - level.player.origin));
  var6 = vectordot(var4, var5);

  if(var6 > 0) {
    var7 = var1 + "_jump";
    var8 = 1.85;
    var9 = 0.05;
    var10 = 3.15;
    var11 = 4.9;
  } else {
    var7 = var6 + "_jump_back";
    var8 = 0.5;
    var9 = 0;
    var10 = 1.7;
    var11 = 2.7;
  }

  level.player lerpfovscalefactor(0, 0.8);
  var12 = 20;
  var5 scripts\sp\player_rig::link_player_to_rig(var7, "crouch", undefined, undefined, undefined, var12, var12, var12, var12, 1);
  waitframe();
  level.player setworldupreferenceangles((274.096, 98.4461, -99.8986));
  scripts\engine\utility::delaythread(var8, &scripts\engine\utility::exploder, "jump_collapse");
  thread scripts\sp\maps\tunnels\zd30tunnels_utility::fake_player_damage(var10, 2);
  level.player scripts\engine\utility::delaycall(var10, &playsound, "plr_breath_pain_init");
  level.player scripts\engine\utility::delaycall(var11, &playsound, "breathing_better");
  level.player scripts\engine\utility::delaycall(var9, &playrumbleonentity, "heavy_1s");
  level.player scripts\engine\utility::delaycall(var10, &playrumbleonentity, "heavy_1s");
  playmayhem("mayh_zd30_jump_down");
  thread storage_split_fall_vo();
  var5 scripts\common\anim::anim_single_solo(level.player_rig, var7);
  var5 thread scripts\common\anim::anim_loop_solo(level.player_rig, var6 + "_jump_idle", "time_to_getup");
  thread hint_to_move();
  var13 = 18;
  var14 = 0;

  for(;;) {
    if(level.player getnormalizedmovement()[0] > 0.1) {
      break;
    }

    if(level.player getnormalizedmovement()[1] > 0.1) {
      break;
    }

    if(scripts\sp\maps\tunnels\zd30tunnels_utility::any_input()) {
      break;
    }

    if(var14 > var13 && !scripts\engine\utility::flag("storage_split_hint")) {
      scripts\engine\utility::flag_set("storage_split_hint");
    }

    var14 += 0.05;
    wait 0.05;
  }

  level notify("storage_split_hint_cancel");
  level.player setworldupreferenceangles((0, 0, 0));
  level.player_rig scripts\engine\sp\utility::anim_stopanimScripted();
  var5 notify("time_to_getup");
  var5 scripts\common\anim::anim_single_solo(level.player_rig, var6 + "_getup");
  level.player_rig hide();
  scripts\sp\player_rig::unlink_player_from_rig(0, "crouch", 1);
  level.player showlegs();
  scripts\engine\sp\objectives::objective_remove_all_locations("tunnels_search");
}

function hint_to_move() {
  level endon("storage_split_hint_cancel");
  scripts\engine\utility::flag_wait("storage_split_hint");
  scripts\engine\sp\utility::display_hint("storage_split_hint", undefined, undefined, level, "storage_split_hint_cancel");
}

function storage_split_fall_vo() {
  wait 0.35;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_far_storage_split_fall_60");
  wait 4;
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_alx_storage_split_fall_70");
  wait 0.3;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_far_storage_split_fall_80");
  wait 0.25;
  level.player scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_alx_storage_split_fall_90");
  wait 0.2;
  level.farah scripts\sp\maps\tunnels\zd30tunnels_utility::say("dx_vom_far_storage_split_fall_100");
  scripts\engine\utility::flag_set("shaft_split_vo_done");
}

function storage_3rd_room_setoff_tripwires() {
  var0 = getEnt("storage_3rd_room_tripwire_setoff_trig", "script_noteworthy");

  if(isDefined(var0)) {
    var0 notify("trigger", level.player);
  }

  var1 = getEnt("storage_lmg_buddy", "targetname");

  if(isDefined(var1)) {
    var1 delete();
    return;
  }
}

function analytics_storage() {
  scripts\engine\utility::flag_wait("player_already_at_split");
  thread scripts\sp\analytics::analytics_kleenex_update("Crates to Ladder Drop");
}

function store_farah() {
  var0 = scripts\engine\utility::getStruct("storage_split_farah", "targetname");
  level.farah forceteleport(var0.origin, var0.angles);
  level.farah setgoalpos(level.farah.origin);
  level.farah scripts\common\ai::gun_recall();
  level.farah.ignoreme = 1;
  level.farah.ignoreall = 1;
}