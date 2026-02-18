/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_122afd04d0de2423.gsc
***********************************************/

#using script_2d443451ce681a;
#using script_30cfffd6b7b2b212;
#using script_3890e6e179f6ed13;
#using script_3dc93ca9902a9cda;
#using script_4937c6974f43bb71;
#using script_52da18c20f45c56a;
#using script_67332a4d085a140a;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\colors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\vehicleriders_shared;
#using scripts\cp_common\debug;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\globallogic_ui;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\objectives;
#using scripts\cp_common\player_decision;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_f464d565;

function function_dbf2a80e(var_d3440450) {
  level.var_aece851d = [];
  level.var_33621ea7 = 1;
  namespace_42da7c51::function_ed760ecb("woods");
  level thread objectives::follow("woods_hit1", level.woods);
  level.var_95a74232 = 1;
  level battlechatter::function_2ab9360b(1);
  level thread function_377fcb1e();
  level thread namespace_61150688::music("combat");
}

function function_b474f6be(var_d3440450, var_50cc0d4f) {
  player = getplayers()[0];
  player thread function_8896f07c();
  level.woods endon(#"death");
  level.var_7c11765c = 0;
  level.last_player_attacker = level;
  level notify(#"hash_adfed45de5ed16d");
  level thread objectives::function_67f87f80("woods_hit1", level.woods, #"hash_7591cd9ae96ac00c");
  callback::on_player_damage(&namespace_42da7c51::function_aa3c5fab);
  level.var_9a3944f4 thread namespace_42da7c51::function_cbe25a41(level.woods, "tag_glass_front_left_lower_d0", 1);
  level.var_9a3944f4 turret::disable(1);
  level.var_9a3944f4 turret::disable(2);
  level thread function_50051760();
  level flag::wait_till("flag_parking_lot_complete");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function function_a81c2225(name, starting, direct, player) {}

function function_50051760() {
  level.woods endon(#"death");
  level.player endon(#"death");
  a_axis = spawner::simple_spawn("axis_hotel_parking_lot");
  a_axis ai::waittill_dead_or_dying(a_axis, int(ceil(a_axis.size * 0.7)));
  level.woods.perfectaim = 1;

  if(a_axis.size) {
    function_1eaaceab(a_axis);
  }

  level thread namespace_42da7c51::function_d6fedf97(a_axis, int(ceil(a_axis.size)), "flag_parking_lot_complete");

  foreach(guy in a_axis) {
    tar = undefined;

    if(math::cointoss()) {
      tar = level.player;
    } else {
      tar = level.woods;
    }

    if(isDefined(guy) && isalive(guy)) {
      guy.goalradius = 256;
      guy thread ai::set_goal_ent(tar);
      guy thread ai::bloody_death(6);
    }
  }
}

function starting(var_d3440450) {
  namespace_42da7c51::function_ed760ecb("woods");
  level thread function_377fcb1e();
  level util::delay(1, undefined, &flag::set, "flag_assault_heli_4");
}

function main(var_d3440450, var_50cc0d4f) {
  level.woods endon(#"death");
  level battlechatter::function_2ab9360b(0);
  level.woods colors::disable();
  level.woods cleargoalvolume();
  level.woods.fixednode = 1;
  node = getnode("woods_hotel_postup_breach", "targetname");
  level.woods ai::set_goal_node(node);
  level.woods val::set(#"hash_fc8c2d0605f3557", "goalradius", 32);
  level.woods val::set(#"hash_fc8c2d0605f3557", "push_player", 1);
  level util::delay_notify(0.5, "heli_focus_door_breach");
  level thread function_7e95e514();
  level thread function_6f9e6949();
  level flag::wait_till_all(["aldrich_dead", "flag_breach_enemies_dead"]);
  level thread function_c182078c();
  level flag::wait_till(#"hash_5601fb6019314f30");
  level.woods val::reset_all(#"hash_fc8c2d0605f3557");
  snd::client_msg("stop_camera_zoom");

  if(isDefined(var_50cc0d4f)) {
    skipto::function_4e3ab877(var_50cc0d4f);
  }
}

function cleanup(name, starting, direct, player) {
  if(player) {
    s_org = struct::get("tag_align_hotel_breach", "targetname");
    mdl_door = getent("hotel_breach_door", "targetname");
    mdl_door.animname = "hotel_breach_door";
    mdl_door useanimtree("generic");
    mdl_chair = getent("hotel_breach_chair", "targetname");
    mdl_chair.animname = "hotel_breach_chair";
    mdl_chair useanimtree("generic");
    mdl_door util::delay(0.05, undefined, &animation::last_frame, "t9_hit1_sm_tkd_player_door_breach", s_org);
    mdl_chair util::delay(0.05, undefined, &animation::last_frame, "t9_hit1_sm_tkd_chair", s_org);
  }
}

function function_377fcb1e() {
  level.var_40b02b72 = vehicle::simple_spawn_and_drive("heli_hotel");
  level.var_9a3944f4 = level.var_40b02b72[0];
  level.var_9a3944f4 thread namespace_42da7c51::function_fbb0d73f();
  thread namespace_42da7c51::heli_light(level.var_9a3944f4, "ally_heli_spot_light_bustout", "tag_fx_running_light_front_side_left_01", (-20, 12, 0), level.var_9a3944f4, 0, 1);
  level.var_9a3944f4 thread namespace_42da7c51::function_3cebcd1b();
  level.var_9a3944f4 util::delay_notify(0.1, "lights_on");
  level.var_9a3944f4 thread namespace_42da7c51::function_4c12f50();
}

function function_7e95e514() {
  level.woods endon(#"death");
  level endon(#"hotel_breach_started");
  dialogue::radio("vox_cp_chao_03100_chp1_theywentuptothe_ed");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_letscrashtheirp_d9");
  dialogue::radio("vox_cp_chao_03100_chp1_rogerthatillsee_3c");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_aldrichisrunnin_9b");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_comeonmason_f9");
  level flag::wait_till("flag_at_hotel_breach");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_thisistheplace_48");
  level.woods dialogue::queue("vox_cp_chao_03100_wood_terminatethismo_de");
  var_3487f398 = [];
  var_3487f398[0] = "vox_cp_chao_03100_wood_onyou_68";
  var_3487f398[1] = "vox_cp_chao_03100_wood_afteryoumason_e7";
  var_3487f398[2] = "vox_cp_chao_03100_wood_thedoor_23";

  if(!flag::get("flag_hotel_breach_started")) {
    level.woods thread namespace_42da7c51::function_436c1448(var_3487f398, "hotel_breach_started");
  }
}

function function_afb86a67() {
  level flag::wait_till("flag_breach_enemies_dead");

  if(!level flag::get("aldrich_dead")) {
    level flag::wait_till("aldrich_dead");
  }

  level.player util::delay(1, undefined, &dialogue::queue, "vox_cp_chao_03100_wood_hesfinished_b3");
  var_53c437ae = 2.5;
  wait var_53c437ae;
  level.woods dialogue::queue("vox_cp_chao_03100_wood_masonletsgetapi_d4");
  wait 1.5;
  level.woods dialogue::queue("vox_cp_chao_03100_wood_forthetraitorse_83");
  var_550ebd7e = [];
  var_550ebd7e[0] = "vox_cp_chao_03100_wood_comeonmanitsaph_cc";
  var_550ebd7e[1] = "vox_cp_chao_03100_wood_takethedamnpict_f2";

  if(!level flag::get("kill_confirmed")) {
    level.woods thread namespace_42da7c51::function_436c1448(var_550ebd7e, "kill_confirmed");
    array::wait_any(level.var_a4592423, "photo_taken");
  }

  level.woods dialogue::function_47b06180();
  wait 1;
  level.player dialogue::queue("vox_cp_chao_03100_masn_gotthephoto_03");
  var_53c437ae = 0.5;
  wait var_53c437ae;
  level.woods thread dialogue::queue("vox_cp_chao_03100_wood_alrightletsgett_b3");
}

function function_6f9e6949() {
  var_8433129 = struct::get("use_org_door_breach", "targetname");
  objectives::remove("woods_hit1", level.woods);
  objectives::function_4eb5c04a("hotel_breach", var_8433129.origin);
  var_8433129 prompts::create(#"use", #"hash_32de942d4691dfd9");
  var_8433129 prompts::set_objective("hotel_breach");
  var_8433129 waittill(#"trigger");
  level thread function_afb86a67();
  level notify(#"hotel_breach_started");
  level flag::set("flag_hotel_breach_started");
  level.woods dialogue::function_47b06180();
  e_player = getplayers()[0];
  e_player endon(#"death");
  level thread namespace_61150688::breach();
  var_841e373 = getspawnerarray("breach_enemies", "script_noteworthy");
  spawner::add_spawn_function_group("aldrich_spawner", "targetname", &function_ced8ff4e);
  level.var_50a8f4ca = spawner::simple_spawn_single("aldrich_spawner");
  level.var_50a8f4ca.health = 9999;
  level.var_50a8f4ca.var_c681e4c1 = 1;
  level.var_50a8f4ca.skipdeath = 1;
  level.var_50a8f4ca.ignoresuppression = 1;
  level.var_50a8f4ca.animname = "Target";

  level.var_50a8f4ca thread debug::drawtagforever("<dev string:x38>");

  level.var_50a8f4ca thread function_f4ad0a04();
  var_89597434 = [];

  foreach(sp in var_841e373) {
    var_89597434[var_89597434.size] = sp spawner::spawn(1);
  }

  foreach(ai in var_89597434) {
    if(ai.targetname === "breach_enemy_02") {
      ai.health = 9999;
      ai.var_c681e4c1 = 1;
      ai setCanDamage(1);
      ai thread function_82ec079c();

      ai thread debug::drawtagforever("<dev string:x38>");
    }

    if(ai.targetname === "breach_enemy_01") {
      ai.health = 1;
      ai.var_c681e4c1 = 1;
      ai setCanDamage(1);
      ai.skipdeath = 1;
      ai thread function_6fbc35f6();
      ai thread anim_finished();
    }
  }

  level thread namespace_42da7c51::function_d6fedf97(var_89597434, var_89597434.size, "flag_breach_enemies_dead");
  s_org = struct::get("tag_align_hotel_breach", "targetname");
  e_player setstance("stand");
  namespace_82bfe441::fade(1, "FadeFast");
  e_player showcrosshair(0);
  var_fe68a829 = e_player getweaponslist();
  e_player val::set(#"hash_29302a13c9b142f3", "allow_melee_victim", 0);
  e_player val::set(#"hash_29302a13c9b142f3", "disable_offhand_special", 1);
  e_player val::set(#"hash_29302a13c9b142f3", "disable_offhand_weapons", 1);
  var_6d32463a = getent("hotel_breach_chair", "targetname");
  e_door = getent("hotel_breach_door", "targetname");
  var_6d32463a.animname = "hotel_breach_chair";
  e_door.animname = "hotel_breach_door";
  var_6d32463a thread function_d9ba53a8(getent("breach_enemy_02", "targetname", 1));
  a_actors = [e_player, level.woods, var_89597434[0], var_89597434[1], level.var_50a8f4ca, e_door, var_6d32463a];
  level notify(#"hash_6b5c0d1e8b95af4c");
  level thread objectives::complete("hotel_breach");
  level thread scene::play("scene_tkd_hit1_hotel_room_breach", "breach", a_actors);
  level waittill(#"hash_30f8c0265810bdb1");

  foreach(w in var_fe68a829) {
    e_player givemaxammo(w);

    if(w.weapclass === "spread") {
      e_player shoulddoinitialweaponraise(w, 0);
      e_player switchtoweaponimmediate(w, 1);
    }
  }

  level waittill(#"hash_7d8e293b60233d56");
  namespace_82bfe441::fade(0, "FadeFast");
  e_player showcrosshair(1);
  var_78b3d4a1 = 0.2;
  var_b89fe77a = 1;
  var_af6c8808 = 1;
  var_970d5e06 = 3;
  e_player setmovespeedscale(var_78b3d4a1);
  setslowmotion(var_b89fe77a, var_78b3d4a1, var_af6c8808);
  level waittilltimeout(var_970d5e06, #"flag_breach_enemies_dead");
  e_player val::reset_all(#"hash_29302a13c9b142f3");
  setslowmotion(var_78b3d4a1, var_b89fe77a, var_af6c8808);
  e_player setmovespeedscale(var_b89fe77a);
}

function function_6fbc35f6() {
  self endon(#"death");
  self waittill(#"hash_4c476dece9132813");
  self.health = 999;
  result = self waittill(#"damage", #"death");
  self.skipdeath = 1;
  self notify(#"hash_53fdcb0020b4588c");
  level.player playhitmarker(#"hash_31e38d8520839566", 5, undefined, 1);
  level thread scene::play("scene_tkd_hit1_hotel_room_breach", "enemy_01_death", [self]);
}

function anim_finished() {
  self endon(#"death");
  self waittill(#"hash_28e484cedefdbd0f");
  self.skipdeath = 0;
}

function function_d9ba53a8(actor) {
  self endon(#"hash_7bf85e8505c830fd", #"death");
  actor waittill(#"damage", #"death");
  var_d56b7da7 = self getanimtime("t9_hit1_sm_tkd_chair");
  s_org = struct::get("tag_align_hotel_breach", "targetname");
  self stopanimscripted();
  self useanimtree("generic");
  self animation::play("t9_hit1_sm_tkd_chair", s_org, undefined, undefined, undefined, undefined, undefined, var_d56b7da7, undefined, undefined, undefined, 1);
}

function function_82ec079c() {
  level.player endon(#"death");
  result = self waittill(#"damage", #"death");
  str_shot = "";

  if(self.targetname === "breach_enemy_01") {
    str_shot = "enemy_01_death";
  } else {
    str_shot = "enemy_02_death";
  }

  self thread ai::gun_remove();
  self.skipdeath = 1;
  self notify(#"hash_53fdcb0020b4588c");
  level.player playhitmarker(#"hash_31e38d8520839566", 5, undefined, 1);
  level thread scene::play("scene_tkd_hit1_hotel_room_breach", str_shot, [self]);
}

function function_f4ad0a04() {
  objectives::kill("obj_kill_aldrich", self);
  self setCanDamage(1);
  self waittill(#"damage");
  self notify(#"hash_53fdcb0020b4588c");
  self thread ai::gun_remove();
  level.player playhitmarker(#"hash_31e38d8520839566", 5, undefined, 1);
  player_decision::function_8c0836dd(0);
  level.var_85b00b2b = undefined;

  if(isDefined(self)) {
    self stopsounds();
    objectives::complete("obj_kill_aldrich");
    level scene::play("scene_tkd_hit1_hotel_room_breach", "target_death", [self]);
    level flag::set("aldrich_dead");
  }
}

function function_c182078c() {
  if(!isDefined(level.player)) {
    return;
  }

  level.player endon(#"death");
  level flag::wait_till("aldrich_dead");
  thread function_cebce779();
  level.player notifyonplayercommand("ability_activated_camera", "+actionslot 4");
  level thread function_73a5b42a();
  level.player spy_camera::function_6de171e9();
  level flag::wait_till("flag_corpse_camera_tags_setup");

  foreach(e_obj in level.var_a4592423) {
    level.player spy_camera::function_f785d9e9(e_obj);
  }

  array::wait_any(level.var_a4592423, "photo_taken");
  level flag::set("aldrich_kill_confirmed");

  foreach(e_obj in level.var_a4592423) {
    level.player spy_camera::function_b28ab5a9(e_obj);
    waitframe(1);
  }

  array::delete_all(level.var_a4592423);
  level flag::set("kill_confirmed");
  level flag::set(#"hash_5601fb6019314f30");
  level.player waittill(#"end_camera_ads");
  level.player spy_camera::function_b83af2a9();
  level flag::set("camera_put_away");
}

function function_73a5b42a() {
  wait 0.5;
  player = getplayers()[0];
  level endon(#"aldrich_kill_confirmed");
  player endon(#"death");

  while(true) {
    level flag::clear("cancel_ability_wheel_select_camera_hint");
    level flag::clear("cancel_camera_up_hint");
    level flag::clear("cancel_hint_camera_use");
    player util::show_hint_text(#"hash_511a12be02cfaa42", undefined, undefined, 8);
    player waittill(#"ability_activated_camera");
    level flag::set("cancel_ability_wheel_select_camera_hint");
    wait 0.5;
    player util::show_hint_text(#"hash_2e082b24b46890d6", undefined, undefined, 8);
    s_waitresult = player waittill(#"hash_59b80e9e535f9788", #"ability_deactivated_camera");
    level flag::set("cancel_camera_up_hint");
    wait 0.5;

    if(s_waitresult._notify == "ability_deactivated_camera") {
      continue;
    }

    player util::show_hint_text(#"hash_414b34beaee0f892", undefined, "aldrich_kill_confirmed", 8);
    s_waitresult = player waittilltimeout(4, #"hash_5512f0799022267", #"ability_deactivated_camera", #"take_picture");
    level flag::set("cancel_hint_camera_use");
    return;
  }
}

function function_b1095197() {
  level flag::wait_till("woods_move_out");
  level flag::set(#"hash_5601fb6019314f30");
}

function function_6bfbb3e8() {
  player = getplayers()[0];
  level flag::wait_till("aldrich_kill_confirmed");
  level spy_camera::function_f91a82ef(1, undefined);
  player waittill(#"end_camera_ads");
  player thread util::show_hint_text(#"hash_12be6ba1327c64b1", undefined, "hide_camera_unequip_hint", -1);
  player waittill(#"ability_deactivated_camera");
  level flag::set("flag_player_end_camera_ads");
}

function function_cebce779() {
  level endon(#"aldrich_kill_confirmed");
  level.player waittill(#"take_picture");
  wait 1;

  if(!level flag::get("aldrich_kill_confirmed")) {
    level.woods dialogue::queue("vox_cp_chao_03100_wood_weneedthecorpse_f8");
  }
}

function function_ced8ff4e() {
  level.vip = self;
  level callback::function_30c3f95d(&function_36578ff1);
  level flag::set("aldrich_spawned");
  level.var_c1ec7c3d = level.vip.model;
  level.vip waittill(#"death");
  level flag::wait_till_all(["aldrich_dead", "flag_vip_became_corpse"]);
  corpse = level.var_b28ef69b;
  wait 1;
  timeout = gettime() + 7000;
  var_ab3730a4 = (0, 0, 0);

  while(timeout > gettime() && lengthsquared(var_ab3730a4 - level.var_b28ef69b getcorpsephysicsorigin() + level.var_b28ef69b function_6c7f19df()) > 4) {
    var_ab3730a4 = level.var_b28ef69b getcorpsephysicsorigin() + level.var_b28ef69b function_6c7f19df();
    waitframe(3);
  }

  corpseorigin = level.var_b28ef69b getcorpsephysicsorigin();
  var_1157b993 = level.var_b28ef69b function_6c7f19df();
  level.var_a4592423 = [];
  level.orgs = [];
  level.orgs[level.orgs.size] = corpseorigin;
  level.orgs[level.orgs.size] = var_1157b993;
  start = corpseorigin + (0, 0, 8);
  end = var_1157b993 + (0, 0, 8);
  toadd = (end - start) / 4;
  level.orgs[level.orgs.size] = end;
  level.orgs[level.orgs.size] = start;

  for(i = 0; i < 4 - 1; i++) {
    level.orgs[level.orgs.size] = level.orgs[level.orgs.size - 1] + toadd;
  }

  foreach(org in level.orgs) {
    if(isDefined(org)) {
      level.var_a4592423[level.var_a4592423.size] = util::spawn_model("tag_origin", org);
    }
  }

  if(false) {
    foreach(tag in level.var_a4592423) {
      sphere(tag.origin, 3, (0, 0, 1), 1, 0, 8, 1400);
    }
  }

  level flag::set("flag_corpse_camera_tags_setup");
}

function private function_36578ff1(parm) {
  corpse = self;

  if(corpse.model == level.var_c1ec7c3d) {
    level.var_b28ef69b = corpse;
    level flag::set("flag_vip_became_corpse");
    corpse callback::function_95ba5345(&function_36578ff1);
  }
}

function function_8896f07c() {
  self endon(#"death");

  while(true) {
    if(level flag::get("flag_touching_pool")) {
      level.player action_utility::function_396e2076();
    } else if(level flag::get("flag_touching_pool_clear")) {}

    waitframe(1);
  }
}