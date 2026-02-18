/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_5093e69067abcf4d.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_25b0725f0d26dbf5;
#using script_3dc93ca9902a9cda;
#using script_4a5e7e929ab4ac21;
#using script_7a8ad4f66d2967a6;
#using scripts\core_common\ai_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp\cp_nam_armada_fx;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\skipto;
#using scripts\cp_common\util;
#namespace namespace_73b34832;

function function_56b84660() {}

function function_a2c4f153(var_d3440450, var_50cc0d4f) {
  setDvar(#"setsunshadowsplitdistance", "1500");
  level.var_3741fc24 = 1;
  level.ally_spawner = getent("bamboo_ally_adler", "targetname");
  namespace_b7cfe907::function_882e6973(0, level.ally_spawner);
  level.vip.ignoreall = 1;
  level.vip.goalradius = 8;
  level.var_7466d419.ignoreme = 1;

  if(isDefined(level.gunner)) {
    level.gunner.ignoreme = 1;
  }

  var_ca4b942e = getvehiclenode("orbit_approach_start_node_bamboo", "targetname");
  level function_b8119b75();
  namespace_b7cfe907::function_37fc8bb();
  namespace_b7cfe907::function_d777fe61(2);
  level.var_7466d419 makevehicleusable();
  var_d2c4ed4b = level.var_7466d419 getoccupantseat(level.players[0]);
  level.var_7466d419 usevehicle(level.players[0], var_d2c4ed4b);

  if(level flag::get("flag_player_chopper_screenshake_active")) {
    level flag::clear("flag_player_chopper_screenshake_active");
  }

  level.var_7466d419 makevehicleunusable();
  level thread function_61ae79dd();
  level.player val::set(#"script_godmode", "takedamage", 0);
  level flag::wait_till("flag_bamboo_player_on_ground");
  var_3374176b = level.var_b3464ee0;
  level skipto::function_4e3ab877("armada_bamboo_orbit", 0);
  level skipto::function_51726ac8(["armada_bamboo_start_1"], 0, level.player);
}

function function_d921e776() {
  level.var_7466d419 endon(#"death");
  level.player endon(#"death");
  var_309bea08 = 1;
  level.var_7466d419 cleargoalyaw();
  level.var_7466d419 cleartargetyaw();
  level.var_7466d419 setvehvelocity((0, 0, 0));
  level.var_7466d419 setphysacceleration((0, 0, 0));
  level.var_7466d419 setangularvelocity((0, 0, 0));
  level.var_7466d419 sethoverparams(0);
  landing_zone = struct::get("armada_bamboo_lz", "targetname");
  level.var_7466d419.orbit_lz = landing_zone;
  level.var_b3464ee0 = landing_zone;
  var_da00db64 = undefined;

  if(isDefined(level.var_7466d419.orbit_lz)) {
    var_5c10784b = (landing_zone.origin[0], landing_zone.origin[1], landing_zone.origin[2] + 600);
    var_da00db64 = var_5c10784b;
    level.var_7466d419 setspeed(100, 50, 75);
    level.var_7466d419 function_a57c34b7(var_5c10784b, 1);
    level.var_7466d419 sethoverparams(0);
    level.var_7466d419 settargetyaw((0, landing_zone.angles[1], 0)[1]);
    level.var_7466d419 setgoalyaw((0, landing_zone.angles[1], 0)[1]);
    level.var_7466d419.var_cb55c804 = 512;
    level.var_7466d419 setneargoalnotifydist(level.var_7466d419.var_cb55c804);
    level.var_7466d419 waittill(#"near_goal");
    level.var_7466d419 waittill(#"goal");
  }

  waitframe(1);

  if(is_true(var_309bea08)) {
    level.var_7466d419 orbit::function_adf2ea57();
  } else {
    level.var_7466d419 orbit::function_4db7a747();
  }

  level flag::set("flag_bamboo_player_on_ground");

  if(!is_true(var_309bea08) && isDefined(var_da00db64)) {
    level.var_7466d419 cleargoalyaw();
    level.var_7466d419 function_d4c687c9();
    level.var_7466d419.var_cb55c804 = 128;
    level.var_7466d419 setneargoalnotifydist(level.var_7466d419.var_cb55c804);
    level.var_7466d419 function_a57c34b7(var_da00db64, 1);
    level.var_7466d419 flag::set("flag_orbit_chopper_ascending");
    waitresult = level.var_7466d419 waittill(#"goal", #"near_goal");
    level.var_7466d419 flag::clear("flag_orbit_chopper_ascending");
  }
}

function function_61ae79dd() {
  landing_zone = struct::get("armada_bamboo_lz", "targetname");
  var_da00db64 = undefined;
  var_5c10784b = (landing_zone.origin[0], landing_zone.origin[1], landing_zone.origin[2] + 600);
  var_da00db64 = var_5c10784b;
  level flag::set("flag_bamboo_player_on_ground");
  level.var_7466d419 cleargoalyaw();
  level.var_7466d419 function_d4c687c9();
  level.var_7466d419.var_cb55c804 = 128;
  level.var_7466d419 setneargoalnotifydist(level.var_7466d419.var_cb55c804);
  level.var_7466d419 function_a57c34b7(var_da00db64, 1);
  level.var_7466d419 flag::set("flag_orbit_chopper_ascending");
  waitresult = level.var_7466d419 waittill(#"goal", #"near_goal");
  level.var_7466d419 flag::clear("flag_orbit_chopper_ascending");
}

function function_25b14af6() {}

function function_8461e1fe() {
  var_1abcec75 = getent("obj_bamboo_adler", "targetname");
  var_a3d82ec9 = getEntArray("bamboo_tripwire", "targetname");
  var_700c90fe = struct::get("obj_bamboo_search");
  var_bddc99bf = struct::get("obj_bamboo_defend");
  var_a64a9990 = struct::get("obj_bamboo_huey");
  var_e4ffaaab = struct::get("obj_bamboo_pickup_adler");
  level.var_88a1eb21 = struct::get_array("obj_bamboo_landingzone");
  level.var_b1fc9b46 = 0;
  level flag::wait_till("flag_bamboo_begin_search");
  setDvar(#"setsunshadowsplitdistance", "1500");

  if(level.var_3741fc24) {
    var_a3d82ec9[0] util::create_cursor_hint(undefined, (0, 0, 0), #"hash_568389f29ccfd09", 100);
    var_a3d82ec9[0] thread function_ff41dacf();
    objectives::complete("armada_obj_bamboo_pickup_adler", var_a3d82ec9[0]);
    var_a3d82ec9[1] util::create_cursor_hint(undefined, (0, 0, 0), #"hash_568389f29ccfd09", 100);
    var_a3d82ec9[1] thread function_ff41dacf();
    objectives::complete("armada_obj_bamboo_pickup_adler", var_a3d82ec9[1]);
    var_a3d82ec9[2] util::create_cursor_hint(undefined, (0, 0, 0), #"hash_568389f29ccfd09", 100);
    var_a3d82ec9[2] thread function_ff41dacf();
    objectives::complete("armada_obj_bamboo_pickup_adler", var_a3d82ec9[2]);
  }

  level thread objectives::follow("armada_obj_bamboo_search", level.buddy, #"hash_5520a0b3e4ae539c");
  level flag::wait_till("flag_bamboo_sims_rescue");
  level thread objectives::goto("armada_obj_bamboo_pickup_adler", var_e4ffaaab, #"hash_5d478b29d713b409");
  waitframe(1);
  var_1abcec75 util::create_cursor_hint(undefined, (0, 0, 0), #"hash_752eaf34cc172517", 200);
  var_1abcec75 thread function_7a970706();
  objectives::complete("armada_obj_bamboo_search", level.buddy);
  level flag::wait_till("flag_bamboo_adler_escort");
  objectives::complete("armada_obj_bamboo_pickup_adler", var_e4ffaaab);
  level thread objectives::goto("armada_obj_bamboo_landingzone", level.var_88a1eb21[level.var_b1fc9b46], #"hash_605a3c5729de1df3");
  level flag::wait_till("flag_bamboo_can_place_sims");
  level thread objectives::goto("armada_obj_bamboo_huey", var_a64a9990, #"hash_476bb1700839376f");
  level waittill(#"lift_off");
  var_a64a9990 thread function_1f16ea44();
}

function function_aebe91ed() {
  level.var_30e75fdd = getent("obj_bamboo_place_adler", "targetname");
  level flag::wait_till("flag_bamboo_can_place_sims");
  objectives::complete("armada_obj_bamboo_landingzone", level.var_88a1eb21);
  level.var_30e75fdd util::create_cursor_hint(undefined, (0, 0, 0), #"hash_3e7cef75b9a01994", 100);
  level.var_30e75fdd thread function_28657862();
}

function function_ff41dacf() {
  self waittill(#"trigger");
  level.wires = getEntArray(self.target, "targetname");
  level.var_37ebce9f = 1;

  foreach(wire in level.wires) {
    wire delete();
  }

  level.var_37ebce9f = 0;
  self util::remove_cursor_hint();
  level flag::set("flag_bamboo_tripwire_defused");
  wait 1;
  level flag::clear("flag_bamboo_tripwire_defused");
}

function function_6847b56f() {
  level.var_420dfb63 = getent("bamboo_tripwire_trigger_1", "targetname");
  level.var_2853c7ef = getent("bamboo_tripwire_trigger_2", "targetname");
  level.var_1a99ac7b = getent("bamboo_tripwire_trigger_3", "targetname");

  if(level.var_3741fc24) {
    level.var_420dfb63 thread function_7eff82e5();
    level.var_2853c7ef thread function_7eff82e5();
    level.var_1a99ac7b thread function_7eff82e5();
  }
}

function function_7eff82e5() {
  self waittill(#"trigger");
  tripwires = getEntArray(self.target, "targetname");

  foreach(tripwire in tripwires) {
    tripwire delete();
  }

  if(level.var_37ebce9f) {
    level.player dodamage(200, level.player.origin);
    iprintlnbold("WIRE DETONATED");
    thread exploder::exploder("bamboo_tripwire_explosion");
  }

  level.var_37ebce9f = 1;
}

function function_ed2c9bc5() {
  trigs = getEntArray("bamboo_slide_trig", "targetname");

  foreach(trig in trigs) {
    trig thread function_16d1451f();
  }
}

function function_16d1451f() {
  self waittill(#"trigger");

  if(level.player isonground()) {
    iprintlnbold("Mantle slide animation.");
  } else {
    iprintlnbold("Jump slide animation.");
    level thread function_14172d3a();
  }

  end = struct::get(self.target);
  var_5022064 = distance(level.player.origin, end.origin) / 300;
  accel_time = 2;
  org = util::spawn_model("tag_origin", level.player.origin, level.player.angles);
  level.player playerlinkto(org, "tag_origin", 180, 180, 180, 180, 180, 0);
  org moveto(end.origin, var_5022064, 0, 0);
  pitch = 0.15;
  yaw = 0.15;
  roll = 0.15;
  freq = 12.5;
  screenshake(level.player.origin, pitch, yaw, roll, var_5022064, 0, 0, 0, freq, freq, freq);
  wait var_5022064;
  level.player unlink();
  org delete();
}

function function_4f94f6b3() {
  slide_trig = getent("bamboo_buddy_slide_trig", "targetname");
  slide_trig waittill(#"trigger");
  start_pos = getent("bamboo_start_pos", "targetname");
  end_pos = getent("bamboo_end_pos", "targetname");

  if(!isDefined(start_pos) || !isDefined(end_pos)) {
    iprintlnbold("One of the start points aren't defined.");
    return 0;
  }

  level.buddy forceteleport(start_pos.origin, start_pos.angles);
}

function function_7adc18d4() {
  landing_trig = getent("landing_trig", "targetname");
  landing_trig waittill(#"trigger");
  var_bdfdd61e = getent("bamboo_tele_pos", "targetname");
  end_pos = getent(var_bdfdd61e.target, "targetname");
  wait 1;
  level.player val::set(#"script_godmode", "takedamage", 1);
}

function function_6f286eb1() {
  objectives::complete("armada_obj_bamboo_search", self);
}

function function_255d55b6() {
  objectives::complete("armada_obj_bamboo_defend", self);
}

function function_29a58355() {
  objectives::complete("armada_obj_bamboo_pickup_adler", self);
}

function function_1f16ea44() {
  objectives::complete("armada_obj_bamboo_huey", self);
  objectives::complete("armada_obj_bamboo_search", self);
  objectives::complete("armada_obj_bamboo_pickup_adler", self);
}

function function_7d2b8848() {
  level flag::set("flag_bamboo_dead_body_found");
  level thread bamboo_dead_body_found();
  level thread bamboo_dead_body_cleared();
  level thread function_5a800c65();
  function_42782299();
  level thread function_d3fa648e();
  level thread function_6847b56f();
  level thread function_58f90134();
  level thread function_e1d02130();
  level thread function_19f372aa();
  wait 1;
}

function bamboo_dead_body_found() {
  trigger = getent("bamboo_dead_body_found", "targetname");
  trigger waittill(#"trigger");
  level flag::wait_till("flag_bamboo_dead_body_found");
  level flag::set("flag_vo_bamboo_dead_body_found");
}

function bamboo_dead_body_cleared() {
  trigger = getent("bamboo_dead_body_cleared", "targetname");
  trigger waittill(#"trigger");
  level flag::clear("flag_bamboo_dead_body_found");
}

function function_42782299() {
  level.bamboo_exfil_blockade_clip = getEntArray("bamboo_exfil_blockade_clip", "targetname");

  foreach(clip in level.bamboo_exfil_blockade_clip) {
    clip notsolid();
  }

  start_node = getnode("bamboo_sims_start_node", "targetname");
  trigger = getent("bamboo_start_trig", "targetname");
  setDvar(#"setsunshadowsplitdistance", "1500");
  trigger thread function_df7badb7();
  level flag::set("flag_bamboo_begin_search");
  level.var_37ebce9f = 1;

  if(!isDefined(level.ally_spawner)) {
    var_c7994e66 = getent("bamboo_ally_adler", "targetname");
    namespace_b7cfe907::function_882e6973(0, var_c7994e66);
    level.vip.goalradius = 8;
  }

  level.var_e76e155b = getent("bamboo_ally_sims", "targetname");
  namespace_b7cfe907::function_3af72756(level.var_7466d419, level.buddy, "crew");
  namespace_b7cfe907::function_ed68628c(0, level.var_e76e155b);
  level.buddy namespace_b7cfe907::swap_hat_model();
  level.buddy colors::set_force_color("b");
  level.buddy.ignoreall = 1;
  level.buddy.goalradius = 8;
  level.buddy.grenadeammo = 0;
  level.buddy ai::set_behavior_attribute("demeanor", "cqb");
  level.buddy namespace_979752dc::set_movement_speed(75);
  level.buddy setgoal(start_node);
  level thread function_97582a1d();
  level thread function_d0320edf();
  level thread function_cf6ab51b();
  level thread function_8461e1fe();
  level thread function_4f94f6b3();
  level thread function_ed2c9bc5();
  level thread function_7adc18d4();
}

function function_d0320edf() {
  var_392915d9 = getent("bamboo_adler_callout_trig", "targetname");
  var_4aa08ad4 = getent("bamboo_adler_located", "targetname");
  var_392915d9 waittill(#"trigger");
  level.buddy namespace_979752dc::set_movement_speed(125);
  var_4aa08ad4 waittill(#"trigger");
  level.buddy ai::set_behavior_attribute("demeanor", "combat");
  level.buddy namespace_979752dc::set_movement_speed(200);
}

function function_5818c90e() {
  var_e76e155b = getent("bamboo_teleport_buddy", "targetname");
  level.buddy forceteleport(var_e76e155b.origin);
  level.vip.goalradius = 8;
  level.vip.ignoreall = 1;
  level.buddy.goalradius = 8;
  level.buddy.ignoreall = 1;
}

function function_311a3bb9() {
  var_cac4e07c = snd::function_9ae4fc6f("tmp_music_combat_against_the_clock_lp", level.player);
  level flag::wait_till("flag_bamboo_liftoff");
  snd::stop(var_cac4e07c, 2);
}

function function_e78bf27b(target) {
  var_85b65b25 = snd::function_9ae4fc6f("tmp_quad_wind_ext_foliage_lp", target);
}

function function_df7badb7() {
  level.var_3741fc24 = 1;
  tripwires_group_1 = getEntArray("tripwires_group_1", "targetname");
  tripwires_group_2 = getEntArray("tripwires_group_2", "targetname");
  tripwires_group_3 = getEntArray("tripwires_group_3", "targetname");
  var_bf83667f = arraycombine(tripwires_group_1, tripwires_group_2);
  var_546f9443 = arraycombine(var_bf83667f, tripwires_group_3);

  if(!level flag::get("armada_mortar_start")) {
    level.var_3741fc24 = 0;

    foreach(tripwire in var_546f9443) {
      tripwire delete();
    }

    level flag::set("flag_bamboo_tripwire_defused");
  }

  if(level.var_3741fc24) {
    level flag::set("flag_tripwire_in_bamboo");
  }
}

function function_5a800c65() {
  var_f2db850c = getent("bamboo_adler_ambush", "targetname");
  var_87b6eb69 = getent("bamboo_enemy_smoke_retreat_vol", "targetname");
  var_c95d32b8 = getent("bamboo_enemy_smoke_retreat_vol_1", "targetname");
  var_d9f3194 = getent("bamboo_enemy_smoke_attack_vol", "targetname");
  var_25fcd2e1 = spawner::simple_spawn("bamboo_ally_bait");

  foreach(ally in var_25fcd2e1) {
    ally dodamage(200, ally.origin);
  }

  var_e14ec0eb = spawner::simple_spawn("bamboo_enemy_ambush_start");

  foreach(enemy in var_e14ec0eb) {
    enemy.ignoreall = 1;
    enemy.grenadeammo = 0;
  }

  var_f2db850c waittill(#"trigger");
  level.buddy ai::set_behavior_attribute("demeanor", "combat");
  level flag::set("flag_bamboo_sims_rescue");
  level flag::wait_till("flag_bamboo_adler_pickup");
  wait 4;
  thread function_311a3bb9();

  foreach(enemy in var_e14ec0eb) {
    enemy.ignoreall = 0;
    enemy namespace_979752dc::set_movement_speed(150);
    enemy setgoal(var_d9f3194);
  }

  spawner::waittill_ai_group_amount_killed("bamboo_aigroup_ambush", 1, 5);
  spawner::waittill_ai_group_amount_killed("bamboo_aigroup_ambush", 3);
  level flag::set("flag_vo_sims_ambush_start_completed");
  iprintlnbold("Killed.");
  function_1eaaceab(var_e14ec0eb);

  foreach(enemy in var_e14ec0eb) {
    if(isDefined(enemy)) {
      enemy.ignoreall = 1;
      enemy.ignoreme = 1;
      enemy setgoal(var_87b6eb69);
    }
  }

  level flag::set("flag_bamboo_adler_escort");
  level flag::set("flag_vo_bamboo_adler_greet_start");
  wait 30;
  function_1eaaceab(var_e14ec0eb);

  foreach(enemy in var_e14ec0eb) {
    if(isDefined(enemy)) {
      enemy delete();
    }
  }
}

function function_e1d02130() {
  level thread function_5220591a();
  level thread function_d7dd315e();
  level thread function_48f64d06();
}

function function_d3fa648e() {
  trigs = getEntArray("bamboo_obj_landingzone_trig", "targetname");

  foreach(trig in trigs) {
    trig thread function_46b2bc79();
  }
}

function function_46b2bc79() {
  level flag::wait_till("flag_bamboo_adler_escort");
  self waittill(#"trigger");
  objectives::complete("armada_obj_bamboo_landingzone", level.var_88a1eb21[level.var_b1fc9b46]);
  level.var_b1fc9b46++;
  level thread objectives::goto("armada_obj_bamboo_landingzone", level.var_88a1eb21[level.var_b1fc9b46], #"hash_605a3c5729de1df3");
}

function function_4f0b177() {
  level flag::wait_till("flag_bamboo_adler_escort");
  objectives::complete("armada_obj_bamboo_landingzone", level.var_88a1eb21[level.var_b1fc9b46]);
  level.var_b1fc9b46++;
  level thread objectives::goto("armada_obj_bamboo_landingzone", level.var_88a1eb21[level.var_b1fc9b46], #"hash_605a3c5729de1df3");
}

function function_58f90134() {
  var_8f189bb7 = getent("bamboo_spook_trig_1", "targetname");
  var_44642ed0 = getent("bamboo_enemy_spook_1", "targetname");
  var_9952b02b = getent("bamboo_spook_trig_2", "targetname");
  var_3633126e = getent("bamboo_enemy_spook_2", "targetname");
  var_423181de = getent("bamboo_spook_trig_3", "targetname");
  var_a8f777f5 = getent("bamboo_enemy_spook_3", "targetname");
  var_8f189bb7 waittill(#"trigger");
  savegame::function_7790f03();

  for(i = 0; i < var_44642ed0.count; i++) {
    enemy = var_44642ed0 spawner::spawn(1, "bamboo_enemy_spook_1", var_44642ed0.origin, var_44642ed0.angles);
    enemy.ignoreall = 1;
    enemy.ignoreme = 1;
    thread function_e78bf27b(enemy);
    wait 5;

    if(isDefined(enemy)) {
      enemy delete();
    }
  }

  var_9952b02b waittill(#"trigger");
  level.var_37ebce9f = 1;
  savegame::function_7790f03();

  for(i = 0; i < var_3633126e.count; i++) {
    enemy = var_3633126e spawner::spawn(1, "bamboo_enemy_spook_2", var_3633126e.origin, var_3633126e.angles);
    enemy.ignoreall = 1;
    enemy.ignoreme = 1;
    wait 2.5;

    if(isDefined(enemy)) {
      enemy delete();
    }
  }

  var_423181de waittill(#"trigger");
  savegame::function_7790f03();

  for(i = 0; i < var_a8f777f5.count; i++) {
    enemy = var_a8f777f5 spawner::spawn(1, "bamboo_enemy_spook_3", var_a8f777f5.origin, var_a8f777f5.angles);
    enemy.ignoreall = 1;
    enemy.ignoreme = 1;
    wait 5;

    if(isDefined(enemy)) {
      enemy delete();
    }
  }
}

function function_5220591a() {
  var_8f189bb7 = getent("bamboo_ambush_trig_1", "targetname");
  var_9952b02b = getent("bamboo_ambush_trig_2", "targetname");
  var_405b960b = getent("bamboo_enemy_ambush_4", "targetname");
  var_b37c106 = getent("bamboo_enemy_vol_1", "targetname");
  var_bcf5a483 = getent("bamboo_enemy_vol_2", "targetname");
  var_95177ffd = getent("bamboo_enemy_start_vol_fallback", "targetname");
  var_74e6288e = getent("bamboo_enemy_start_vol_retreat", "targetname");
  var_285e25c7 = getent("bamboo_enemy_start_vol_retreat_frontline", "targetname");
  var_8793cde9 = getent("bamboo_enemy_vol_1_retreat", "targetname");
  var_8bb7c0ff = getEntArray("bamboo_negotiation_node_1", "targetname");
  level flag::wait_till("flag_bamboo_adler_escort");
  var_8f189bb7 waittill(#"trigger");
  wait 1;
  var_e14ec0eb = spawner::simple_spawn("bamboo_enemy_ambush_1");
  var_995bff56 = spawner::simple_spawn("bamboo_enemy_ambush_1_frontline");

  foreach(enemy in var_e14ec0eb) {
    enemy.grenadeammo = 0;
  }

  spawner::waittill_ai_group_amount_killed("bamboo_aigroup_1", 3);
  iprintlnbold("AI group 1 retreating.");
  function_4f0b177();
  function_1eaaceab(var_e14ec0eb);

  foreach(enemy in var_e14ec0eb) {
    enemy.ignoreall = 1;
    enemy setgoal(var_74e6288e);
  }

  spawner::waittill_ai_group_amount_killed("bamboo_aigroup_1_front", 2);
  iprintlnbold("AI group 1 frontline retreating.");

  foreach(enemy in var_995bff56) {
    if(isDefined(enemy)) {
      enemy.ignoreall = 1;
      enemy setgoal(var_285e25c7);
    }
  }

  foreach(node in var_8bb7c0ff) {
    node.target delete();
    node delete();
  }

  level flag::set("flag_bamboo_advance_1");
  wait 2;
  var_bc5af704 = spawner::simple_spawn("bamboo_enemy_ambush_2");

  foreach(enemy in var_bc5af704) {
    enemy.grenadeammo = 0;
  }

  spawner::waittill_ai_group_amount_killed("bamboo_aigroup_2", 3);
  iprintlnbold("AI group 2 retreating.");
  level flag::set("flag_bamboo_advance_2");
  function_1eaaceab(var_bc5af704);

  foreach(enemy in var_bc5af704) {
    enemy.ignoreall = 1;
    enemy setgoal(var_8793cde9);
  }

  var_c6a10b90 = spawner::simple_spawn("bamboo_enemy_ambush_3");
  spawner::waittill_ai_group_amount_killed("bamboo_aigroup_2", 5);
  level flag::set("flag_bamboo_advance_3");
  iprintlnbold("AI group 3 retreating.");
  function_1eaaceab(var_c6a10b90);

  foreach(enemy in var_c6a10b90) {
    enemy.ignoreall = 1;
    enemy setgoal(var_8793cde9);
  }

  wait 10;
  function_1eaaceab(var_e14ec0eb);

  foreach(enemy in var_e14ec0eb) {
    enemy delete();
  }

  function_1eaaceab(var_bc5af704);

  foreach(enemy in var_bc5af704) {
    enemy delete();
  }
}

function function_beb9b824() {
  clips = getEntArray("bamboo_blockade_clip", "targetname");
  logs = getEntArray("bamboo_blockade_log", "targetname");
  var_6d98bf7 = getent("bamboo_exfil_blockade_position_1", "targetname");
  var_fb2c8c87 = getent("bamboo_log_exfil_1", "targetname");
  var_a23fc2c5 = getent("bamboo_exfil_blockade_position_2", "targetname");
  var_7ba40d7c = getent("bamboo_log_exfil_2", "targetname");

  foreach(clip in level.bamboo_exfil_blockade_clip) {
    clip solid();
  }

  var_fb2c8c87.origin = var_6d98bf7.origin;
  var_7ba40d7c.origin = var_a23fc2c5.origin;

  foreach(clip in clips) {
    clip delete();
  }

  foreach(log in logs) {
    log delete();
  }

  level flag::wait_till("flag_bamboo_first_turret_active");

  while(true) {
    iprintlnbold("enemy 1 still alive");

    if(!isDefined(level.var_687b982b)) {
      level flag::set("flag_bamboo_advance_4");
      level flag::set("flag_bamboo_first_turret_destroyed");
      break;
    }

    waitframe(1);
  }

  level flag::wait_till("flag_vo_sims_callout_minigun_2");

  while(true) {
    iprintlnbold("enemy 2 still alive");

    if(!isDefined(level.var_8c229d8e)) {
      level flag::set("flag_bamboo_advance_6");
      level flag::set("flag_bamboo_second_turret_destroyed");
      break;
    }

    waitframe(1);
  }
}

function function_f4b3ddba(turret, gunner) {
  trigger = self;
  turret setteam(#"axis");
  turret turret::get_in(gunner);
  turret turretsetontargettolerance(0, 2);
  gunner.ignoreme = 1;
}

function function_d7dd315e() {
  var_423181de = getent("bamboo_ambush_trig_minigun", "targetname");
  var_57ecad54 = getent("bamboo_ambush_trig_3", "targetname");
  var_255ac831 = getent("bamboo_ambush_trig_4", "targetname");
  var_b1a93b1 = getent("bamboo_second_minigun_spawner_trig", "targetname");
  var_8b071388 = getent("bamboo_ambush_trig_4_backup", "targetname");
  var_910adda9 = getent("bamboo_enemy_minigun_retreat_vol_1", "targetname");
  var_f7059ee = getent("bamboo_enemy_minigun_retreat_vol_2", "targetname");
  var_f826723e = getent("bamboo_enemy_minigun_1", "targetname");
  var_21484481 = getent("bamboo_enemy_minigun_2", "targetname");
  level.var_640a075d = getent(var_f826723e.target, "targetname");
  level.var_a4b2ba72 = getent(var_21484481.target, "targetname");
  var_1cd2abf0 = getent("bamboo_turret_exposed_pos", "targetname");
  var_1af664c8 = getent("bamboo_turret_exposed_pos_2", "targetname");
  var_99356002 = getent("bamboo_turret_hidden_pos", "targetname");
  var_86cd1176 = getent("bamboo_turret_hidden_pos_2", "targetname");
  level flag::wait_till("flag_bamboo_sims_rescue");
  level flag::wait_till("flag_bamboo_adler_escort");
  level.var_640a075d.origin = var_1cd2abf0.origin;
  level.var_a4b2ba72.origin = var_1af664c8.origin;
  level flag::wait_till("flag_bamboo_enemy_single_spawn_blockade");
  var_ab7f13d3 = spawner::simple_spawn("bamboo_enemy_blockade_single");
  var_423181de waittill(#"trigger");

  for(i = 0; i < var_f826723e.count; i++) {
    level.var_687b982b = var_f826723e spawner::spawn(1, "bamboo_enemy_minigun_1", var_f826723e.origin, var_f826723e.angles);
    level.var_687b982b.ignoreme = 1;
    level.var_687b982b.grenadeammo = 0;
    level.var_687b982b.goalradius = 0;
    self thread function_f4b3ddba(level.var_640a075d, level.var_687b982b);
    wait 0.25;
  }

  level.var_82eaeb3d = spawner::simple_spawn("bamboo_enemy_minigun_support_1");

  foreach(enemy in level.var_82eaeb3d) {
    enemy.grenadeammo = 0;
    enemy.goalradius = 8;
  }

  level flag::set("flag_bamboo_first_turret_active");
  level flag::set("flag_vo_sims_callout_minigun_1");
  var_5ed8ecf1 = getEntArray("bamboo_tutorial_trig", "targetname");
  level flag::wait_till("flag_bamboo_first_turret_destroyed");
  function_1eaaceab(level.var_82eaeb3d);

  foreach(enemy in level.var_82eaeb3d) {
    enemy.ignoreall = 1;
    enemy setgoal(var_910adda9);
  }

  var_57ecad54 waittill(#"trigger");
  level flag::set("flag_vo_sims_callout_enemy_2");
  level.var_6d9dc0a3 = spawner::simple_spawn("bamboo_enemy_minigun_support_2");

  foreach(enemy in level.var_6d9dc0a3) {
    enemy.grenadeammo = 0;
  }

  spawner::waittill_ai_group_amount_killed("bamboo_aigroup_cliff_1", 1);
  level flag::set("flag_bamboo_advance_5");
  function_1eaaceab(level.var_82eaeb3d);

  foreach(enemy in level.var_82eaeb3d) {
    if(isDefined(enemy)) {
      enemy delete();
    }
  }

  var_255ac831 waittill(#"trigger");
  level flag::set("flag_vo_sims_callout_enemy_1");
  level.var_1f8aa476 = spawner::simple_spawn("bamboo_enemy_minigun_support_3");

  foreach(enemy in level.var_1f8aa476) {
    enemy.grenadeammo = 0;
  }

  var_b1a93b1 waittill(#"trigger");

  for(i = 0; i < var_21484481.count; i++) {
    level.var_8c229d8e = var_21484481 spawner::spawn(1, "bamboo_enemy_minigun_1", var_21484481.origin, var_21484481.angles);
    level.var_8c229d8e.ignoreme = 1;
    level.var_8c229d8e.grenadeammo = 0;
    level.var_8c229d8e.goalradius = 0;
    self thread function_f4b3ddba(level.var_a4b2ba72, level.var_8c229d8e);
    wait 0.25;
  }

  level flag::set("flag_vo_sims_callout_minigun_2");
  var_8b071388 waittill(#"trigger");
  var_f1bede52 = spawner::simple_spawn("bamboo_enemy_minigun_support_3_1");

  foreach(enemy in var_f1bede52) {
    enemy.grenadeammo = 0;
  }
}

function function_48f64d06() {
  var_b1a93b1 = getent("bamboo_ambush_trig_5", "targetname");
  level flag::wait_till("flag_bamboo_sims_rescue");
  var_b1a93b1 waittill(#"trigger");
  iprintlnbold("These guys just don't let up!");
  var_aa3752bd = spawner::simple_spawn("bamboo_enemy_ambush_5");

  foreach(enemy in var_aa3752bd) {
    enemy.grenadeammo = 0;
  }
}

function function_cee1a3e8() {
  var_b9864a0f = getent("bamboo_enemy_vol_liftoff", "targetname");
  level flag::wait_till("flag_bamboo_liftoff");
  level.player val::set(#"script_godmode", "takedamage", 0);
  vehicle::get_in(level.buddy, level.var_7466d419, "crew");
  level.buddy namespace_b7cfe907::swap_hat_model(1);
}

function function_79ff25ba() {
  a_ents = [];
  a_ents[# "player 1"] = level.player;
  a_ents[# "sims"] = level.buddy;
  a_ents[# "hash_6c5af6df35669df2"] = level.gunner;
  a_ents[# "adler"] = level.vip;
  a_ents[# "hash_4972abe0166bbc73"] = level.var_7466d419;
  level scene::play(#"hash_4a77e90ad29593d9", a_ents);
}

function function_b8119b75() {
  a_ents = [];
  a_ents[# "player 1"] = level.player;
  a_ents[# "hash_4972abe0166bbc73"] = level.var_7466d419;
  namespace_b7cfe907::function_d777fe61(2);
  level scene::play(#"armada_bamboo_orbit", a_ents);
  level scene::play(#"hash_3e5db93dfa662175", a_ents);
}

function function_14172d3a() {
  a_ents = [];
  a_ents[# "sims"] = level.buddy;
  level scene::play(#"hash_748497a378473ed7", a_ents);
}

function function_97582a1d() {
  level thread scene::play(#"hash_779f6b010bce3573");
  level thread scene::play(#"hash_779f6c010bce3726");
}

function function_cf6ab51b() {
  var_27f35498 = getent("bamboo_downed_chopper", "targetname");
  a_ents = [];
  a_ents[# "adler"] = level.vip;
  a_ents[# "hash_3962ecd59dbbfa07"] = var_27f35498;
  level thread scene::play(#"hash_16e1a05741d2f80b", a_ents);
  level flag::wait_till("flag_bamboo_adler_pickup");
  level thread scene::play(#"hash_b4e6fa87dbf2550", a_ents);
}

function private function_998e600a() {
  self notify("565e63ba47d8b6f9");
  self endon("565e63ba47d8b6f9");
  self.perfectaim = 1;
  self.sightlatency = 0;
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self turret::_init_turret(1);

  foreach(turret in self.a_turrets) {
    turret.b_needs_user = 0;
  }

  n_fire_min = 3;
  n_fire_max = 8;
  n_wait_min = 0.25;
  n_wait_max = 0.5;
  self turret::set_burst_parameters(n_fire_min, n_fire_max, n_wait_min, n_wait_max, 1);
  self turret::set_torso_targetting(1, -12);
  self turret::set_target_leading(1, 0.1);
  self thread turret::_turret_think(1);
}

function function_444403c() {
  level.var_fb14fd3b turret::_get_turret_data(1).is_enabled = 0;
  level.var_fb14fd3b turret::stop(1, 1);
}

function function_19f372aa() {
  level flag::wait_till("flag_bamboo_sims_rescue");
  trigger = getent("bamboo_end_trig", "targetname");
  trigger waittill(#"trigger");
  level flag::set("flag_bamboo_main_end");
}

function function_7a970706() {
  var_efb94641 = getent("bamboo_adler_pickup_teleport", "targetname");
  self waittill(#"trigger");
  self util::remove_cursor_hint();
  level flag::set("flag_bamboo_adler_pickup");
  level thread function_beb9b824();
  level thread namespace_9a981837::forest_pbg_switch();
  wait 3;
  level.vip.ignoreall = 0;
  level.vip namespace_979752dc::set_movement_speed(200);
  level.buddy.ignoreall = 0;
  level.buddy namespace_979752dc::set_movement_speed(200);
  level.vip colors::set_force_color("b");
  level.buddy colors::set_force_color("b");
  level.buddy util::magic_bullet_shield();
  var_1ea5d70e = getent("bamboo_teleport_buddy", "targetname");
}

function function_28657862() {
  self waittill(#"trigger");
  level function_79ff25ba();
  iprintlnbold("[ Player has placed Adler on the Helicopter. ]");
  level thread namespace_9a981837::function_3f0940c0();
  level.player setmovespeedscale(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  function_43c14dd6();
}

function function_936bbed4() {
  wait 5;
  level.var_42fad021 = 40;
  level.var_7466d419 setspeed(level.var_42fad021, 20, 20);
  wait 3;
  level.var_7466d419 setspeed(level.var_42fad021 * 2, 20, 20);
}

function function_43c14dd6() {
  level.var_7466d419.ignoreme = 0;
  iprintlnbold("Ally has been put onto the chopper.");
  level flag::set("flag_bamboo_liftoff");
  level.var_7466d419 setseatoccupied(2, 0);
  namespace_b7cfe907::function_d777fe61(2);
  namespace_b7cfe907::function_3af72756(level.var_7466d419, level.buddy, "crew");
  namespace_b7cfe907::function_3af72756(level.var_7466d419, level.vip, "crew");
  vehicle::get_in(level.buddy, level.var_7466d419, "crew");
  level.buddy namespace_b7cfe907::swap_hat_model(1);
  vehicle::get_in(level.vip, level.var_7466d419, "crew");

  if(!isDefined(level.buddy)) {
    namespace_b7cfe907::function_ed68628c(0, level.var_e76e155b);
  }

  level.buddy.grenadeammo = 2;
  wait 1;
  level notify(#"lift_off");
  setDvar(#"setsunshadowsplitdistance", "5000");
  level.var_42fad021 = 7.5;
  level.var_7466d419 setspeed(level.var_42fad021, 10, 10);
  dest = level.var_7466d419.origin + (0, 0, 256);
  level.var_7466d419.var_cb55c804 = 10;
  level.var_7466d419 setneargoalnotifydist(level.var_7466d419.var_cb55c804);
  level.var_7466d419 function_a57c34b7(dest, 1);
  level.var_7466d419 waittill(#"goal", #"near_goal");
  level.var_7466d419 function_d4c687c9();
  var_5829bff7 = getvehiclenode("bamboo_heli_exit_start", "targetname");
  var_ecde2a75 = getvehiclenode("bamboo_heli_exit_to_mortar", "targetname");

  if(level flag::get_any(["armada_mortar_start_1_completed", "armada_mortar_start_2_completed", "armada_mortar_start_3_completed", "armada_mortar_start"])) {
    level.var_7466d419 function_a57c34b7(var_ecde2a75.origin, 1);
  } else {
    level.var_7466d419 function_a57c34b7(var_ecde2a75.origin, 1);
  }

  level.var_7466d419 waittill(#"goal", #"near_goal");

  if(level flag::get_any(["armada_mortar_start_1_completed", "armada_mortar_start_2_completed", "armada_mortar_start_3_completed", "armada_mortar_start"])) {
    level.var_7466d419 vehicle::get_on_path(var_ecde2a75);
  } else {
    level.var_7466d419 vehicle::get_on_path(var_ecde2a75);
  }

  level thread function_936bbed4();
  level.var_7466d419.drivepath = 1;
  level.var_7466d419 vehicle::go_path();
  level.var_7466d419.drivepath = 0;
  level flag::set("flag_bamboo_end_end");
}

function function_85ddf842() {
  player = level.player;
  var_591da512 = getent("bamboo_buddy_end_spawn", "targetname");
  var_2ad99779 = getent("bamboo_vip_end_spawn", "targetname");
  function_c6968b8f("bamboo_vc_attack_nodes", "script_noteworthy", 0);
  level.var_622b1622 = spawner::simple_spawn("bamboo_enemy_prone_ambush_final");

  foreach(var_7840772c in level.var_622b1622) {
    var_7840772c.ignoreall = 1;
    var_7840772c.grenadeammo = 0;
  }

  level flag::wait_till("flag_bamboo_final_ambush");
  level.var_7937e76b = spawner::simple_spawn("bamboo_enemy_ambush_final");

  foreach(enemy in level.var_7937e76b) {
    enemy.ignoreall = 1;
    enemy.grenadeammo = 0;
    enemy setgoal(player);
  }

  player namespace_486c0593::function_28edaba7();

  if(!isDefined(level.vip) && !isDefined(level.buddy)) {
    namespace_b7cfe907::function_882e6973(0, var_591da512);
    namespace_b7cfe907::function_ed68628c(0, var_2ad99779);
  }

  level.vip colors::set_force_color("b");
  level.buddy colors::set_force_color("b");
  level.vip.ignoreall = 1;
  level.buddy.ignoreall = 1;
  iprintlnbold("Throw smoke grenade for chopper support and landing.");
  player namespace_486c0593::function_def737fb();
  player callback::on_grenade_fired(&function_dfdba661);
  function_c6968b8f("bamboo_vc_attack_nodes", "script_noteworthy", 1);
  function_c6968b8f("bamboo_vc_prone_nodes", "script_noteworthy", 0);
  level thread function_7810ad29();
  level.var_5220d63f = 0;

  while(true) {
    function_1eaaceab(level.var_f9d42668);
    iprintlnbold("Down to " + level.var_f9d42668.size + " enemies");
    wait 1;

    if(level.var_5220d63f === 0) {
      if(level.var_f9d42668.size <= 1) {
        level.var_7937e76b = spawner::simple_spawn("bamboo_enemy_ambush_final");

        foreach(enemy in level.var_7937e76b) {
          enemy setgoal(player);

          if(!isDefined(level.var_f9d42668)) {
            level.var_f9d42668 = [];
          } else if(!isarray(level.var_f9d42668)) {
            level.var_f9d42668 = array(level.var_f9d42668);
          }

          level.var_f9d42668[level.var_f9d42668.size] = enemy;
        }
      }
    }

    if(level.var_5220d63f === 1) {
      iprintlnbold("No more respawning.");
      break;
    }

    wait 1;
  }

  level flag::wait_till("flag_bamboo_liftoff");
  function_1eaaceab(level.var_f9d42668);

  foreach(enemy in level.var_7937e76b) {
    if(isDefined(enemy)) {
      enemy delete();
    }
  }

  function_1eaaceab(level.var_622b1622);

  foreach(var_7840772c in level.var_622b1622) {
    if(isDefined(var_7840772c)) {
      var_7840772c delete();
    }
  }
}

function function_7810ad29() {
  var_72394006 = getent("bamboo_enemy_vol_final", "targetname");
  level.var_f9d42668 = [];
  wait 7;

  foreach(enemy in level.var_7937e76b) {
    enemy.ignoreall = 0;

    if(!isDefined(level.var_f9d42668)) {
      level.var_f9d42668 = [];
    } else if(!isarray(level.var_f9d42668)) {
      level.var_f9d42668 = array(level.var_f9d42668);
    }

    level.var_f9d42668[level.var_f9d42668.size] = enemy;
  }

  wait 2;

  foreach(var_7840772c in level.var_622b1622) {
    if(isDefined(var_7840772c)) {
      var_7840772c.ignoreall = 0;
      var_7840772c.fixednode = 0;
      var_7840772c setgoal(var_72394006);
    }
  }
}

function function_dfdba661(params) {
  if(self != level.player) {
    return;
  }

  if(!(isDefined(params.weapon) && isDefined(params) && isDefined(params.weapon.name))) {
    return;
  }

  if(params.weapon.name != # "hash_6d516e633b87af84") {
    return;
  }

  self callback::remove_on_grenade_fired(&function_dfdba661);
  self notify(#"heli_killstreak_grenade_out");
  chopper = level.var_7466d419;
  enemies = level.bamboo_enemy_ambush_final;
  var_2ed66429 = getvehiclenode("orbit_exfil_attack_bamboo", "targetname");
  var_f8991185 = getvehiclenode("orbit_exfil_hover_bamboo", "targetname");
  var_42f80936 = getvehiclenode("orbit_exfil_land_bamboo", "targetname");
  iprintlnbold("Chopper gunner coming in.");
  level.var_5220d63f = 1;
  chopper thread function_998e600a();
  chopper setspeed(18, 20, 20);
  chopper vehicle::get_on_and_go_path(var_2ed66429);
  iprintlnbold("Chopper gunner in position.");
  chopper setspeed(8, 30, 30);
  chopper vehicle::get_on_and_go_path(var_f8991185);
  iprintlnbold("Chopper gunner attack complete coming in for landing.");
  chopper setspeed(10, 15, 15);
  chopper vehicle::get_on_and_go_path(var_42f80936);
  level flag::set("flag_bamboo_can_place_sims");
  iprintlnbold("Chopper gunner ready for boarding.");
  level.var_7466d419 turret::_get_turret_data(1).is_enabled = 0;
  level.var_7466d419 turret::stop(1, 1);
  level.var_7466d419 turret::_get_turret_data(2).is_enabled = 0;
  level.var_7466d419 turret::stop(2, 1);
  level.var_7466d419 notify(#"hash_315b918ba6181743");
  level.var_7466d419 notify(#"hash_315b928ba61818f6");
}

function function_c6968b8f(nodename, nodekey, benabled) {
  nodes = getnodearray(nodename, nodekey);

  if(isDefined(nodes)) {
    foreach(node in nodes) {
      setenablenode(node, benabled);
    }
  }
}

function function_4eccc114(var_d3440450, var_50cc0d4f) {
  level flag::clear("flag_player_flying_ambience_start");
  level flag::set("flag_player_flying_ambience_kill");

  if(!isDefined(level.var_b3464ee0)) {
    level.var_b3464ee0 = struct::get(var_50cc0d4f);
  }

  level.var_3851f0df = 1400;
  level.var_aaa4273e = 950;
  level.player thread namespace_b7cfe907::function_4fa636c5();
  waitframe(2);
  level thread function_7d2b8848();
  level flag::wait_till("flag_bamboo_main_end");
  level skipto::function_4e3ab877(var_50cc0d4f, 0);
  level skipto::function_51726ac8(["armada_bamboo_end"], 0, level.player);
}

function function_a15d0e63(var_d3440450, var_50cc0d4f) {
  level.var_3741fc24 = 1;
  level flag::clear("flag_player_flying_ambience_start");
  level flag::set("flag_player_flying_ambience_kill");
  level flag::set("flag_bamboo_begin_search");
  level flag::set("flag_bamboo_sims_rescue");
  var_9c824c52 = getvehiclenode("bamboo_loop", "script_noteworthy");
  level.var_3851f0df = 1400;
  level.var_aaa4273e = 950;
  level.player thread namespace_b7cfe907::function_4fa636c5();
  function_7d2b8848();
  function_5818c90e();
  level flag::wait_till("flag_bamboo_main_end");
  level skipto::function_4e3ab877(var_50cc0d4f, 0);
  level skipto::function_51726ac8(["armada_bamboo_end"], 0, level.player);
}

function function_ddac4979(var_d3440450, var_50cc0d4f) {
  if(var_50cc0d4f) {
    waitframe(1);
  }

  level flag::set("flag_bamboo_sims_rescue");
  level.var_3741fc24 = 1;
  level thread function_85ddf842();
  level thread function_aebe91ed();
  level flag::wait_till("flag_bamboo_end_end");
  transient = savegame::function_6440b06b(#"transient");
  transient.var_8ffe00b6 = 1;
  namespace_b7cfe907::function_d777fe61(0);
  level skipto::function_4e3ab877(var_d3440450, 0);
  next_obj = "armada_fly_bamboo_to_mortar";

  if(is_true(transient.var_32839ab6)) {
    next_obj = "armada_fly_bamboo_to_firebase";
  }

  level skipto::function_51726ac8([next_obj], 0, level.player);
}