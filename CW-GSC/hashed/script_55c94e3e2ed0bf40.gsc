/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_55c94e3e2ed0bf40.gsc
***********************************************/

#using script_155b17ff7c8b315c;
#using script_57d05cf093ffba5c;
#using script_6cd35fe7afb1f231;
#using script_97b74052c477c23;
#using scripts\core_common\ai\archetype_utility;
#using scripts\core_common\ai\systems\shared;
#using scripts\core_common\ai_shared;
#using scripts\core_common\animation_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\doors_shared;
#using scripts\core_common\exploder_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\lockpick;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scene_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\status_effects\status_effect_util;
#using scripts\core_common\stealth\utility;
#using scripts\core_common\struct;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\dialogue;
#using scripts\cp_common\gametypes\battlechatter;
#using scripts\cp_common\gametypes\save;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\objectives;
#using scripts\cp_common\objectives_ui;
#using scripts\cp_common\skipto;
#using scripts\cp_common\snd;
#using scripts\cp_common\ui\prompts;
#using scripts\cp_common\util;
#using scripts\weapons\cp\spy_camera;
#namespace namespace_96add23c;

function function_a5ad7a90(str_objective) {
  level function_b9596ad1();
  level flag::set("flg_woods_radio");
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_perimeter", 1, 0);
}

function function_709fd94e(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(var_50cc0d4f);

  level flag::set(#"flg_lockpick_start");
  clientfield::set("cull_allinterior", 1);
  level thread function_39e166dc();
  level thread namespace_fc3e8cb::function_6fe40e14("side_door_gun_rack1", "side_door_gun_rack2", "side_door_gun_rack3");
  level thread function_bb9839d8();
  level thread namespace_979752dc::function_740dbf99();
  level flag::wait_till(#"hash_6ddc7c0cf621eef8");
  skipto::function_4e3ab877(var_50cc0d4f);
}

function function_70073b6b(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  level flag::clear("flg_woods_radio");

  if(player) {
    level flag::set(#"hash_4939af0c2a6ea11d");
    var_4c5366ee = doors::get_doors("e_lockpick_door", "targetname")[0];
    a_scene_ents[#"door"] = var_4c5366ee.c_door.m_e_door;
    level thread scene::play(#"hash_24e544fc76d24b96", "doors_loop", a_scene_ents);
  }

  a_doors = doors::get_doors("e_lockpick_door");

  foreach(door in a_doors) {
    if(isDefined(door.c_door)) {
      door.c_door doors::function_656c898c();
      door doors::function_f35467ac();
    }
  }

  level thread namespace_fc3e8cb::function_a23603cf(0);
  clientfield::set("cull_allinterior", 1);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_exterior", 1);
}

function private function_39e166dc() {
  s_obj_side_door_lockpick = struct::get("s_obj_side_door_lockpick", "targetname");

  if(!isDefined(objectives::function_285e460("obj_side_door_find_entrance"))) {
    objectives::goto("obj_side_door_find_entrance", s_obj_side_door_lockpick.origin, #"hash_783161cb2beea0a0", 0);
    level thread function_a0b22623();
    level flag::wait_till("flg_side_door_scene_start");
    objectives::complete("obj_side_door_find_entrance");
  }
}

function function_a0b22623() {
  level endon(#"flg_side_door_scene_start");
  wait 20;
  objectives::convert("obj_side_door_find_entrance", #"hash_6d05b1cec06f98c");
  s_obj_side_door_lockpick = struct::get("s_obj_side_door_lockpick", "targetname");
  objectives::update_position("obj_side_door_find_entrance", s_obj_side_door_lockpick.origin);
  id = objectives::function_285e460(#"obj_side_door_find_entrance");
  thread objectives_ui::function_f3ac479c(id);
  level.player thread objectives_ui::show_objectives();
}

function function_b9596ad1() {
  var_d1a24548 = spawner::simple_spawn_single("lockpick_scene_enemy_door", &function_87f353f6, #"c_t9_shg_npc_c_lutz");
  w_pistol = getweapon(#"pistol_burst_t9");
  var_d1a24548 aiutility::setcurrentweapon(w_pistol);
  var_d1a24548 aiutility::setprimaryweapon(w_pistol);
  var_d1a24548 shared::placeweaponon(w_pistol, "right");
  w_pistol = getweapon(#"pistol_semiauto_t9");
  var_d1a24548 aiutility::setcurrentweapon(w_pistol);
  var_d1a24548 aiutility::setprimaryweapon(w_pistol);
  var_d1a24548 shared::placeweaponon(w_pistol, "right");
  var_d1a24548 setModel(#"c_t9_cp_rus_kgb_guard_body_officer_a");
  var_d1a24548 val::set(#"hash_70f48a440e25a27c", "magic_bullet_shield", 1);
  var_12baf921 = spawner::simple_spawn_single("lockpick_scene_enemy_desk", &function_87f353f6, #"c_t9_shg_npc_e_reshetnikov");
  level.var_eea5b22[#"hash_65d78c2acf2a7732"] = var_d1a24548;
  level.var_eea5b22[#"hash_3c251f2afff5ae77"] = var_12baf921;
  var_4c5366ee = doors::get_doors("e_lockpick_door", "targetname")[0];
  level.var_eea5b22[#"door"] = var_4c5366ee.c_door.m_e_door;
  level function_4f4f437b();
  animation::add_notetrack_func("amerika_tunnels::lockpick_takedown_player_handler", &function_6fac81f3);
  animation::add_notetrack_func("amerika_tunnels:lockpick_takedown_player_shellshock", &function_8ad67270);
  animation::add_notetrack_func("amerika_tunnels:lockpick_takedown_player_slowmo", &function_29962dd8);
  level scene::init(#"hash_24e544fc76d24b96", level.var_eea5b22);
  level.player.var_4d448bdb setcontents(0);
  var_12baf921 val::set(#"hash_70f48a440e25a27c", "magic_bullet_shield", 1);
  var_12baf921 val::set(#"hash_70f48a440e25a27c", "takedamage", 1);
  level thread function_761c8a8d(var_d1a24548, var_12baf921);
}

function private function_761c8a8d(var_d1a24548, var_12baf921) {
  level endon(#"flg_side_door_scene_start");
  level util::waittill_any_ents_two(var_d1a24548, "bulletwhizby", var_12baf921, "bulletwhizby");
  level flag::set(#"hash_2e804f8eb659e833");
}

function function_4f4f437b() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player.var_4d448bdb = util::spawn_player_clone(level.player);
  mdl_head = level.player startquantity();

  if(isDefined(mdl_head) && level.player.var_4d448bdb isattached(mdl_head)) {
    level.player.var_4d448bdb detach(mdl_head);
  }

  var_60298582 = level.player function_92ea4100();

  if(isDefined(var_60298582) && level.player.var_4d448bdb isattached(var_60298582)) {
    level.player.var_4d448bdb detach(var_60298582);
  }

  level.player.var_4d448bdb function_1fac41e4(level.player function_19124308());
  level.player.var_4d448bdb.anim_debug_name = level.player.name + " clone";
  level.player.var_4d448bdb hide();
  level.var_eea5b22[#"player_clone"] = level.player.var_4d448bdb;
}

function private function_87f353f6(mdl_head) {
  self.name = "Guard";
  self.avoid_cover = 1;
  self val::set(#"hash_70f48a440e25a27c", "ignoreme", 1);
  self val::set(#"hash_70f48a440e25a27c", "ignoreall", 1);

  if(isDefined(self.head) && isDefined(mdl_head)) {
    self detach(self.head);
    self.head = mdl_head;
    self attach(self.head);
  }
}

function private function_bb9839d8() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level.player flag::wait_till(#"lockpicking");
  level thread function_2ea0a58();
  level function_db6f14d2();
  level function_e5368a6a();
  level.player val::set(#"hash_70f48a440e25a27c", "disable_weapons", 2);
  level.player thread function_7eb32768();
  level.player.var_97c1c267.var_8f001ddb = 1;
  level.player lockpick::cancel();
  doors::function_f35467ac("e_lockpick_door");
  util::nvidiaansel_scriptdisable(1);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_exterior", 1);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_tunnel_sdr", 1);
  setDvar(#"r_lightingsunshadowdisabledynamicdraw", 1);
  clientfield::set("SetPBGExposureBank", 2);
  level flag::set(#"flg_side_door_scene_start");
  namespace_b61bbd82::music("3.0_caught");
  var_2a16bfbe = level.var_eea5b22[#"hash_65d78c2acf2a7732"];
  var_2a16bfbe notsolid();
  level.player thread function_ed97bf94();
  level scene::play(#"hash_24e544fc76d24b96", "open_door_start", level.var_eea5b22);
  level flag::set(#"hash_525a26a0b7957925");
  level scene::play(#"hash_24e544fc76d24b96", "weapon_aim", level.var_eea5b22);
  level flag::set(#"hash_3dac34734cfb07f4");

  if(flag::get(#"hash_eff650e7e8aecc2")) {
    level scene::play(#"hash_24e544fc76d24b96", "fail_woods_shoot", level.var_eea5b22);
  }

  arrayremoveindex(level.var_eea5b22, #"hash_3c251f2afff5ae77", 1);
  level scene::play(#"hash_24e544fc76d24b96", "takedown_player_end", level.var_eea5b22);
  level flag::set(#"hash_4939af0c2a6ea11d");
}

function private function_ed97bf94() {
  self endon(#"death");
  level waittill(#"hash_31401122f25f2d2a");
  self playrumbleonentity("glass_break");
  level waittill(#"hash_31401122f25f2d2a");
  self playrumbleonentity("damage_heavy");
  level waittill(#"hash_31401122f25f2d2a");
  self playrumbleonentity("damage_heavy");
  level waittill(#"hash_31401122f25f2d2a");
  self playrumbleonentity("damage_light");
  level waittill(#"hash_31401122f25f2d2a");
  self playrumbleonentity("reload_clipout");
  level waittill(#"hash_31401122f25f2d2a");
  self playrumbleonentity("reload_clipin");
}

function private function_db6f14d2() {
  var_60beb454 = 0;

  while(true) {
    wait 0.25;

    if(level.player flag::get(#"lockpicking")) {
      var_60beb454 += 0.25;

      if(var_60beb454 >= 7) {
        break;
      }

      if(flag::get(#"hash_2e804f8eb659e833") && var_60beb454 >= 2) {
        wait 0.5;
        break;
      }
    }
  }
}

function private function_e5368a6a() {
  var_b2e05f73 = level.player.currentweapon;
  var_9a528114 = spawn("script_model", level.player.origin);

  if(var_b2e05f73 != getweapon(#"none")) {
    var_9a528114 useweaponmodel(var_b2e05f73);
  }

  if(var_9a528114.model != # "") {
    level.var_eea5b22[#"weapon"] = var_9a528114;
    return;
  }

  var_9a528114 delete();
}

function private function_2ea0a58() {
  level.woods hms_util::function_cdc39aec();
  waitframe(1);
  level namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_perimeter", 1, 0);
  level.var_eea5b22[#"woods"] = level.woods;
}

function private function_6fac81f3(params) {
  w_pistol = getweapon(#"pistol_semiauto_t9");
  level.player function_77569ccb(w_pistol);
  level.player.var_4d448bdb util::delay(0.5, undefined, &show);
  level.player hideviewmodel();
  var_2586eb45 = getweapon(#"eq_flash_grenade");
  assert(var_2586eb45 != level.weaponnone);
  var_c3a1484c = 0;

  if(level.player hasweapon(var_2586eb45)) {
    var_c3a1484c = level.player getweaponammoclip(var_2586eb45);
    level.player takeweapon(var_2586eb45);
    var_4f0f327c = 1;
  }

  level waittill(#"hash_30b0b368a6b10931");
  level.player.var_4d448bdb hide();
  level.player val::reset(#"hash_70f48a440e25a27c", "disable_weapons");
  level.player showviewmodel();
  level flag::wait_till(#"hash_3dac34734cfb07f4");
  level.player util::function_749362d7(1, #"hash_79d8239db87989b0");
  level waittill(#"hash_50d0ee914946a0ae");
  level.player hideviewmodel();
  level.player val::set(#"hash_70f48a440e25a27c", "disable_weapons", 2);
  level.player.var_4d448bdb show();
  level waittill(#"hash_30b0b368a6b10931");
  level.player function_9f0dc392(w_pistol);
  level.player util::function_749362d7(0);
  level.player.var_4d448bdb hide();
  level.player val::reset(#"hash_70f48a440e25a27c", "disable_weapons");
  level.player showviewmodel();
  level waittill(#"hash_3fdce2a6c2be9794");

  if(is_true(var_4f0f327c)) {
    level.player giveweapon(var_2586eb45);
    level.player setweaponammoclip(var_2586eb45, var_c3a1484c);
  }

  level.player function_7437ab12();
}

function private function_7eb32768() {
  self val::set(#"hash_70f48a440e25a27c", "freezecontrols", 1);
  self val::set(#"hash_70f48a440e25a27c", "allow_crouch", 0);
  self val::set(#"hash_70f48a440e25a27c", "allow_prone", 0);
  self val::set(#"hash_70f48a440e25a27c", "show_weapon_hud", 0);
  self sethighdetail(1);
  self playerlinktoblend(level.player.var_4d448bdb, "tag_player", 0.25, 0.25 * 0.5, 0, 0.25, 0.25 * 0.5, 0);
  wait 0.25;
  self playerlinktodelta(level.player.var_4d448bdb, "tag_player", 1, 5, 5, 5, 5, 1, 0, 1);
  self val::reset(#"hash_70f48a440e25a27c", "freezecontrols");
  level flag::wait_till(#"hash_525a26a0b7957925");
  self playerlinktodelta(level.player.var_4d448bdb, "tag_player", 1, 20, 15, 10, 10, 1, 0, 1);
}

function private function_7437ab12() {
  self val::reset_all(#"hash_70f48a440e25a27c");
  self unlink();
  self sethighdetail(0);

  if(isDefined(level.player.var_4d448bdb)) {
    level.player.var_4d448bdb delete();
  }

  util::nvidiaansel_scriptdisable(0);
}

function private function_77569ccb(var_bcf157b) {
  self.var_909cc2e4 = self getweaponslistprimaries();
  self.var_813a1fb8 = self.currentweapon;

  foreach(w_primary in self.var_909cc2e4) {
    self takeweapon(w_primary);
  }

  if(self.var_813a1fb8 === level.var_e3f5eafc) {
    spy_camera::function_b83af2a9();
  }

  self giveweapon(var_bcf157b);
  self seteverhadweaponall(1);
}

function private function_9f0dc392(var_bcf157b) {
  self takeweapon(var_bcf157b);

  foreach(w_primary in self.var_909cc2e4) {
    self giveweapon(w_primary);
  }

  if(self.var_813a1fb8 === level.var_e3f5eafc) {
    spy_camera::function_6de171e9();
  }

  self switchtoweapon(self.var_813a1fb8);
}

function private function_8ad67270(params) {
  var_2a16bfbe = level.var_eea5b22[#"hash_65d78c2acf2a7732"];
  effect = getstatuseffect(#"blurred");
  var_711343eb = level.player getnormalhealth() * 0.4;
  level.player setnormalhealth(var_711343eb);
  level.player status_effect::status_effect_apply(effect, level.player.currentweapon, var_2a16bfbe, undefined, 1500);
}

function private function_29962dd8(params) {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");

  switch (level.gameskill) {
    case 4:
      var_691d0722 = 0.85;
      break;
    case 3:
      var_691d0722 = 0.75;
      break;
    case 2:
      var_691d0722 = 0.5;
      break;
    case 0:
      var_691d0722 = 0.2;
      break;
    case 1:
    default:
      var_691d0722 = 0.3;
      break;
  }

  var_86514cc = level.var_eea5b22[#"hash_3c251f2afff5ae77"];
  var_86514cc val::reset(#"hash_70f48a440e25a27c", "magic_bullet_shield");
  var_86514cc val::reset(#"hash_70f48a440e25a27c", "takedamage");
  level.player clientfield::set_to_player("slowmo_postfx", 1);
  setslowmotion(1, var_691d0722, 0.5);
  s_result = var_86514cc waittilltimeout(2, #"death");

  if(s_result._notify === # "death") {
    level flag::set(#"hash_2254d709726e6725");
  } else {
    var_86514cc.health = 9999;
    level flag::set(#"hash_eff650e7e8aecc2");
    wait 2.2 - 2;
  }

  setslowmotion(var_691d0722, 1, 0.2);
  level.player clientfield::set_to_player("slowmo_postfx", 0);
}

function function_debfe625(str_objective) {
  setDvar(#"r_lightingsunshadowdisabledynamicdraw", 1);
  clientfield::set("SetPBGExposureBank", 2);
  namespace_fc3e8cb::function_2987fd4c("s_teleport_woods_tunnels", 1, 0);
  level thread namespace_fc3e8cb::function_6fe40e14("side_door_gun_rack1", "side_door_gun_rack2", "side_door_gun_rack3");
}

function tunnels_main(str_objective, var_50cc0d4f) {
  namespace_fc3e8cb::function_44a6fc04(str_objective);

  transient = savegame::function_6440b06b(#"transient");

  if(is_true(transient.var_4886f850)) {
    level.player stats::function_dad108fa(#"hash_5846fb59bec18f77", 1);
  }

  if(!var_50cc0d4f) {
    savegame::function_7790f03();
  }

  level thread function_52dbef3a();
  namespace_b61bbd82::music("4.0_inside");
  level.is_dark = 0;
  clientfield::set("cull_helipad", 2);
  level thread function_ff20ab50();
  level thread function_e174a8d1();
  level thread function_663b296d();
  flag::wait_till("goto_arcade");
  skipto::function_4e3ab877(str_objective);
}

function tunnels_cleanup(str_objective, var_50cc0d4f, var_aa1a6455, player) {
  clientfield::set("cull_mainstreet", 1);
  clientfield::set("cull_helipad", 2);
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_townsquare_keys", 1, "flg_terminal_end");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_perf_elevator", 1);
}

function function_52dbef3a() {
  objectives::follow("obj_tunnels_follow_woods", level.woods, #"hash_dd9c86df796a85b", 0);
  flag::wait_till("goto_arcade");
  objectives::complete("obj_tunnels_follow_woods", level.woods);
}

function function_ff20ab50() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level.woods endon(#"death");
  level thread namespace_4bd68414::function_ef47326();
  level.woods.grenadeammo = 0;
  level.player util::blend_movespeedscale(0.9, 1);
  level flag::wait_till(#"hash_4939af0c2a6ea11d");
  level scene::play(#"hash_4f86426b62cd5b2a", "approach");
  level thread scene::play(#"hash_4f86426b62cd5b2a", "loop");
  level flag::wait_till_any(["flg_tunnels_at_overlook", "flg_tunnels_at_lower_level"]);
  level flag::set("flg_tunnels_at_lower_level");

  if(level flag::get("flg_lockpick_alarm_button_player_interact") == 1) {
    level thread namespace_4bd68414::function_a9537895();
  } else {
    level thread namespace_4bd68414::function_47262ea1();
  }

  level scene::play(#"hash_4f86426b62cd5b2a", "exit");
  level scene::play(#"hash_10e85718db026016", "stairs");
  level flag::set("flg_tunnels_woods_at_lower_level");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_tunnels_woods_at_lower_level");
  level.woods ai::set_behavior_attribute("disablepeek", 1);
  level.woods ai::set_behavior_attribute("disablelean", 1);
  level flag::wait_till_any(["flg_tunnels_enemies_one_dead", "flg_tunnels_rush_guards", "flg_tunnels_enemies_alerted"]);
  level.woods ai::set_behavior_attribute("disablepeek", 0);
  level.woods ai::set_behavior_attribute("disablelean", 0);
  level.woods namespace_fc3e8cb::function_d74bffa7(0, 0);
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_tunnels_woods_rush_guards");
  level flag::wait_till_any(["flg_tunnels_enemies_dead", "flg_tunnels_midpoint"]);

  if(level flag::get("flg_tunnels_midpoint") == 1) {
    level thread namespace_fc3e8cb::function_5c5b6ea7("nd_tunnels_woods_midpoint");
  }

  level flag::wait_till("flg_tunnels_enemies_dead");
  level thread namespace_4bd68414::function_2e47decc();
  level.player util::blend_movespeedscale(0.85, 1);

  if(level flag::get("flg_tunnels_rush_guards") == 0) {
    wait 1;
  }

  var_928274e8 = getnode("nd_tunnels_woods_at_exit_door", "targetname");
  level.woods thread hms_util::function_2f50100e("stay_ahead", var_928274e8.origin, "end_woods_tunnels_follow2");
  level thread namespace_fc3e8cb::function_5c5b6ea7("nd_tunnels_woods_at_exit_door", 0, 1);
  level.woods ai::set_behavior_attribute("vignette_mode", "fast");
  level.woods ai::set_behavior_attribute("disablepeek", 1);
  level.woods ai::set_behavior_attribute("disablelean", 1);
  level.woods battlechatter::function_2ab9360b(0);
  level namespace_fc3e8cb::function_92dea087("flg_tunnels_end", "flg_tunnels_midpoint");
  level.woods notify(#"end_woods_tunnels_follow2");
  level.woods.grenadeammo = 99;
  level flag::set("flg_tunnels_end");
  level flag::set("goto_arcade");
}

function function_e174a8d1() {
  level flag::wait_till("flg_tunnels_enter_stairwell");

  if(level flag::get("flg_lockpick_alarm_button_player_interact") == 1) {
    level thread function_17a30454();
    return;
  }

  level thread function_3aa9edcc();
}

function function_3aa9edcc() {
  println("<dev string:x38>");
  var_d6376730 = spawner::simple_spawn("ai_enemy_stealth_tunnels", &namespace_fc3e8cb::function_e57eea9a, 1);
  var_ac125bf4 = spawner::simple_spawn("ai_enemy_tunnels_trio_scene", &namespace_fc3e8cb::function_e57eea9a, 1);

  foreach(ai in var_ac125bf4) {
    if(isalive(ai)) {
      ai thread namespace_fc3e8cb::function_7e9a1809("flg_tunnels_trio_scene_stealth_breakout", "flg_tunnels_enemies_alerted");
    }
  }

  var_d6376730 = arraycombine(var_d6376730, var_ac125bf4);
  level thread namespace_fc3e8cb::function_85939627(var_d6376730, "flg_tunnels_enemies_one_dead", 1);
  level thread namespace_fc3e8cb::function_85939627(var_d6376730, "flg_tunnels_enemies_dead");
  level thread namespace_fc3e8cb::function_535e9168(var_d6376730, "flg_tunnels_enemies_alerted", 1);
  level thread namespace_fc3e8cb::function_18e5080e("flg_arcade_at_vista", var_d6376730);
  level thread namespace_fc3e8cb::function_55a81eeb("flg_lockpick_alarm_button_player_interact", var_d6376730);
  level flag::wait_till_any(["flg_tunnels_at_overlook", "flg_tunnels_at_lower_level"]);
  level thread namespace_4bd68414::function_26861bc8(var_ac125bf4);
  level thread namespace_fc3e8cb::function_55a81eeb("flg_tunnels_talking_trio_end", var_d6376730);
}

function function_17a30454() {
  println("<dev string:x59>");
  var_c68ae67f = spawner::simple_spawn("ai_enemy_combat_tunnels_1", &function_345d7cd3);
  level flag::wait_till("flg_tunnels_at_overlook");
  var_55aaa5e2 = spawner::simple_spawn("ai_enemy_combat_tunnels_2", &function_345d7cd3);
  function_1eaaceab(var_c68ae67f);
  var_c68ae67f = arraycombine(var_c68ae67f, var_55aaa5e2);
  level thread namespace_fc3e8cb::function_85939627(var_c68ae67f, "flg_tunnels_enemies_one_dead", 1);
  level flag::wait_till_any(["flg_tunnels_rush_guards", "flg_tunnels_enemies_one_dead"]);
  var_a2d5c037 = spawner::simple_spawn("ai_enemy_combat_tunnels_3", &function_345d7cd3);
  function_1eaaceab(var_c68ae67f);
  var_c68ae67f = arraycombine(var_c68ae67f, var_a2d5c037);
  level thread namespace_fc3e8cb::function_85939627(var_c68ae67f, "flg_tunnels_enemies_dead");
  level thread namespace_fc3e8cb::function_18e5080e("goto_arcade", var_c68ae67f);
}

function function_345d7cd3() {
  self.grenadeammo = 0;
}

function function_663b296d() {
  level flag::wait_till("flg_amk_player_spawned");
  level.player endon(#"death");
  level endon(#"goto_arcade");
  s_obj_tunnels_button_interact = struct::get("s_obj_tunnels_button_interact", "targetname");
  s_obj_tunnels_button_interact util::create_cursor_hint(undefined, undefined, #"hash_9afd0f1723f6f72", 40, 1, undefined, #"use", 40);
  s_obj_tunnels_button_interact prompts::function_5698d1c9(#"use", 45);
  level thread function_7c757661(s_obj_tunnels_button_interact);
  s_obj_tunnels_button_interact waittill(#"trigger");
  level.player val::set(#"hash_75aefe15308514b7", "disable_weapons", 1);
  level.player val::set(#"hash_75aefe15308514b7", "freezecontrols_allowlook", 1);
  wait 0.5;
  s_scene = struct::get("s_scene_lockpick_player_button_press", "targetname");
  level.player playrumbleonentity("anim_light");
  s_scene scene::play("scene_amk_6090_stg_garage");
  level.player val::reset_all(#"hash_75aefe15308514b7");
  level thread namespace_f6d09d1a::function_7b9feaa3("lgtexp_tunnel_alarm", 1);
  snd::client_msg("audio_tunnels_alarm");
  level flag::set("flg_lockpick_alarm_button_player_interact");
  s_obj_tunnels_button_interact util::delay(0.2, undefined, &util::remove_cursor_hint);
  level namespace_4bd68414::function_8d96d73c();
  level.woods namespace_fc3e8cb::function_d74bffa7(0, 0);
}

function function_7c757661(s_obj_tunnels_button_interact) {
  level flag::wait_till("goto_arcade");
  s_obj_tunnels_button_interact util::remove_cursor_hint();
}