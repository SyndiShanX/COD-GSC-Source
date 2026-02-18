/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_77f51076c7c89596.gsc
***********************************************/

#using script_1b9f100b85b7e21d;
#using script_35ae72be7b4fec10;
#using script_3b2905ec05ed796;
#using script_3dc93ca9902a9cda;
#using scripts\core_common\ai_shared;
#using scripts\core_common\array_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gestures;
#using scripts\core_common\player\player_loadout;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\struct;
#using scripts\core_common\trigger_shared;
#using scripts\core_common\values_shared;
#using scripts\cp_common\hms_util;
#using scripts\cp_common\snd;
#using scripts\cp_common\util;
#namespace namespace_534279a;

function spawn_allies(var_1ace1e2) {
  if(!isDefined(level.adler)) {
    hms_util::function_ee1d1df6("adler", "Adler");

    if(isDefined(var_1ace1e2)) {
      function_980c6cc6(level.adler, var_1ace1e2 + "_adler");
    }
  }

  var_5ca6956f = getweapon(#"smg_standard_t9");
  level.adler hms_util::function_65d14a19(var_5ca6956f);

  if(!isDefined(level.mason)) {
    hms_util::function_ee1d1df6("mason", "Mason");

    if(isDefined(var_1ace1e2)) {
      function_980c6cc6(level.mason, var_1ace1e2 + "_mason");
    }
  }

  var_f0935a68 = getweapon(#"ar_accurate_t9");
  level.mason hms_util::function_65d14a19(var_f0935a68);

  if(!isDefined(level.woods)) {
    hms_util::function_ee1d1df6("woods", "Woods");

    if(isDefined(var_1ace1e2)) {
      function_980c6cc6(level.woods, var_1ace1e2 + "_woods");
    }
  }

  var_f0935a68 = getweapon(#"ar_accurate_t9");
  level.woods hms_util::function_65d14a19(var_f0935a68);
  level.sims = getent("e_sims_proxy", "targetname");
  level.sims.name = "Sims";
  level.sims.team = "allies";
  level.park = getent("e_park_proxy", "targetname");
  level.park.name = "Park";
  level.park.team = "allies";
  level.pilot = getent("e_park_proxy", "targetname");
  level.pilot.name = "Pilot";
  level.pilot.team = "allies";
}

function function_980c6cc6(ai_ally, var_1ace1e2) {
  assert(isDefined(ai_ally), "<dev string:x38>");
  var_50a51fcb = struct::get(var_1ace1e2);

  if(isDefined(var_50a51fcb)) {
    ai_ally forceteleport(var_50a51fcb.origin, var_50a51fcb.angles);
  }
}

function function_6e9256df() {
  if(!isDefined(level.player)) {
    level.player = self;
  }

  level flag::delay_set(0.1, "flg_siege_player_spawned");
  level.player setcharacterbodytype(1);
  level.player setcharacteroutfit(1);
  level.player util::function_a5318821();
  var_4f2ba130 = level.player getweaponslist();

  foreach(e_w in var_4f2ba130) {
    level.player takeweapon(e_w);
  }

  w_primary = getweapon(#"ar_standard_t9", "extclip", "acog", "steadyaim", "grip");
  w_secondary = getweapon(#"shotgun_pump_t9", "barrel", "elo", "extclip2");
  var_dc8a1ef2 = getweapon(#"hash_154127ac67af815e", "steadyaim", "fastreload");
  w_lethal = getweapon(#"frag_grenade");
  var_2586eb45 = getweapon(#"willy_pete");
  var_dc8a1ef2.var_4d97c40b = 1;
  var_dc8a1ef2.var_a2e7031d = 1;
  level.player giveweapon(w_primary);
  level.player giveweapon(w_secondary);
  level.player giveweapon(var_dc8a1ef2);
  level.player giveweapon(w_lethal);
  level.player giveweapon(var_2586eb45);
  level.player givemaxammo(w_primary);
  level.player givemaxammo(w_secondary);
  level.player givemaxammo(w_lethal);
  level.player givemaxammo(var_2586eb45);
  level.player switchtoweapon(w_primary);
}

function function_26a3516b() {
  var_dc8a1ef2 = getweapon(#"hash_154127ac67af815e", "steadyaim", "fastreload");
  var_e38f7ceb = level.player getweaponammoclip(var_dc8a1ef2);

  if(var_e38f7ceb > 0) {
    level.player setweaponammoclip(var_dc8a1ef2, 0);
  }

  level.player setactionslot(4, "weapon", var_dc8a1ef2);
  level.player switchtoweapon(var_dc8a1ef2);
}

function function_a3c3a2b0() {
  var_dc8a1ef2 = getweapon(#"hash_154127ac67af815e", "steadyaim", "fastreload");
  level.player takeweapon(var_dc8a1ef2);
  level.player setactionslot(4, "");
}

function function_7149a8() {
  var_dc8a1ef2 = getweapon(#"hash_154127ac67af815e", "steadyaim", "fastreload");
  level.player setweaponammoclip(var_dc8a1ef2, 36);
}

function function_b5e4f3bc(var_8be63fee, var_30fe31f7, var_b2d7eb20 = "targetname", b_shoot = 1, b_should_sprint = 0) {
  assert(isDefined(var_8be63fee), "<dev string:x54>");
  assert(isDefined(var_30fe31f7), "<dev string:x74>");
  var_cf2dc0e8 = getent(var_30fe31f7, var_b2d7eb20);
  assert(isDefined(var_cf2dc0e8), var_30fe31f7 + "<dev string:x97>");
  var_63bea14 = spawner::get_ai_group_ai(var_8be63fee);

  if(isDefined(var_63bea14)) {
    array::thread_all(var_63bea14, &ai::force_goal, var_cf2dc0e8, b_shoot, undefined, undefined, b_should_sprint);
  }
}

function function_da412d49(var_1e598384) {
  assert(isarray(var_1e598384), "<dev string:xa9>");
  a_ai = [];

  foreach(var_8be63fee in var_1e598384) {
    assert(isstring(var_8be63fee), "<dev string:xcb>");
    a_ai = arraycombine(a_ai, spawner::get_ai_group_ai(var_8be63fee));
  }

  return a_ai;
}

function function_4f981a25(str_aigroup, var_c04a9877, var_90b5d9c0) {
  level endon(var_90b5d9c0);
  spawner::waittill_ai_group_amount_killed(str_aigroup, var_c04a9877);
}

function function_bd1a75b(str_aigroup, n_count, var_90b5d9c0) {
  level endon(var_90b5d9c0);

  if(isstring(str_aigroup)) {
    spawner::waittill_ai_group_ai_count(str_aigroup, n_count);
    return;
  }

  if(isarray(str_aigroup)) {
    while(true) {
      n_ai_count = 0;

      foreach(str in str_aigroup) {
        n_ai_count += spawner::get_ai_group_sentient_count(str);
      }

      if(n_ai_count <= n_count) {
        break;
      }

      wait 0.1;
    }
  }
}

function function_ce0f72f4() {
  if(true) {
    return;
  }

  var_fd4c649f = getent("aa_courtyard", "targetname");
  var_80d256bf = getent("aa_parapet", "targetname");
  wait 3;
  var_fd4c649f thread function_c5063901("aa_courtyard");
  wait 1;
  var_80d256bf thread function_c5063901("aa_parapet");
}

function function_c5063901(var_91eb2583) {
  level endon("end_" + var_91eb2583);
  self.var_a2d4664b = spawn("script_origin", self.origin + (0, 0, 100));

  while(true) {
    v_from = (self.var_a2d4664b.origin[0] + randomintrange(-1 * int(cos(10) * 100), int(cos(10) * 100)), self.var_a2d4664b.origin[1] + randomintrange(int(cos(10) * 100) * -1, int(cos(10) * 100)), self.var_a2d4664b.origin[2] + 100);
    v_to = (self.var_a2d4664b.origin[0] + randomintrange(-1 * int(cos(10) * 100), int(cos(10) * 100)), self.var_a2d4664b.origin[1] + randomintrange(int(cos(10) * 100) * -1, int(cos(10) * 100)), self.var_a2d4664b.origin[2] + 100);
    n_shots = randomintrange(7, 21);
    self function_beb5d779(v_from, v_to, n_shots, var_91eb2583);
    var_30aa35ed = randomfloatrange(1, 5);
    wait var_30aa35ed;
  }
}

function function_beb5d779(v_from, v_to, n_shots, var_91eb2583) {
  level endon("end_" + var_91eb2583);

  for(i = 0; i < n_shots; i++) {
    v_target = v_from + i / n_shots * (v_to - v_from);
    self.var_a2d4664b.angles = vectortoangles(v_target - self.var_a2d4664b.origin);
    playFX(#"hash_3bf1cff80bba48d", self.var_a2d4664b.origin, anglesToForward(self.var_a2d4664b.angles));
    wait 0.1;
  }
}

function function_c77b8a08() {
  var_8daefb96 = self gettagorigin("tag_fx");
  v_target = (var_8daefb96[0] + randomintrange(-1 * int(cos(10) * 100), int(cos(10) * 100)), var_8daefb96[1] + randomintrange(int(cos(10) * 100) * -1, int(cos(10) * 100)), var_8daefb96[2] + 100);
  playFX(#"hash_3bf1cff80bba48d", var_8daefb96, v_target - var_8daefb96);
  snd::play("wpn_aa_fire_fake", self);
}

function function_2a8ee50f(s_location) {
  level flag::clear("flg_aa_gun_c4_planted");
  var_6dc21951 = undefined;

  if(s_location == "courtyard") {
    var_6dc21951 = struct::get("c4_pos_" + s_location, "targetname");
    var_6dc21951 util::create_cursor_hint(undefined, undefined, #"hash_122f7ece2bba6255", undefined, undefined, undefined, undefined, 900, 30, 0, 0, undefined, &function_c0a3515);
    var_b2b39566 = struct::spawn(var_6dc21951.origin, var_6dc21951.angles);
    var_b2b39566 util::create_cursor_hint(undefined, undefined, #"hash_122f7ece2bba6255", 1, undefined, undefined, undefined, 900, 30, 0, 0, undefined, &function_f5b3ba02);
  }

  if(s_location == "parapet") {
    var_6dc21951 = struct::get("c4_pos_" + s_location, "targetname");
    var_6dc21951 util::create_cursor_hint(undefined, undefined, #"hash_122f7ece2bba6255", 55, undefined, undefined, undefined, 900, 30, 0, 0);
  }

  if(s_location == "parapet") {
    var_6dc21951 thread function_bc3f8f44();
  }

  var_353319da = getent("c4_light", "targetname");
  var_e9e1284f = struct::get("c4_light_pos", "targetname");
  var_353319da.origin = var_e9e1284f.origin;
  var_353319da.angles = var_e9e1284f.angles;
  var_353319da setscale(0.01);
  var_353319da notsolid();
  var_353319da hide();
  var_6dc21951 waittill(#"trigger");
  level.player freezecontrols(1);

  if(s_location == "courtyard") {
    var_b2b39566 util::remove_cursor_hint();
  }

  level flag::set("flg_aa_gun_c4_planted");

  if(self.targetname == "aa_parapet") {
    return;
  }

  var_3e88828c = getEntArray("courtyard_assault_advance_2", "targetname");
  array::run_all(var_3e88828c, &trigger::use);
  level.player playgestureviewmodel(#"ges_drophand");
  wait 2;
  level.player playrumbleonentity("damage_light");
  wait 1;
  level.player playrumbleonentity("damage_light");
  level.player freezecontrols(0);
  badplace_cylinder("c4", 1000, self.origin - (0, 0, 100), 200, 200, "allies", "axis");
  var_353319da thread function_9f9e880e();
  var_353319da function_f547cd72();
  wait 1;

  if(var_353319da function_f6c31b03()) {
    var_353319da function_f547cd72();
    wait 0.9;
  }

  if(var_353319da function_f6c31b03()) {
    var_353319da function_f547cd72();
    wait 0.8;
  }

  if(var_353319da function_f6c31b03()) {
    var_353319da function_f547cd72();
    wait 0.7;
  }

  if(var_353319da function_f6c31b03()) {
    var_353319da function_f547cd72();
    wait 0.6;
  }

  var_353319da function_f547cd72();
  wait 0.5;
  level notify(#"hud_icon_c4_red");
  var_353319da function_f547cd72();
  wait 0.25;
  var_353319da function_f547cd72();
  wait 0.25;
  var_353319da function_f547cd72();
  wait 0.25;
  var_353319da function_f547cd72();
  wait 0.25;
  var_353319da function_f547cd72(1);
  playFX(#"hash_6fbb2b4f5ecf0aaa", self.origin + (0, 0, 70));
  radiusdamage(var_353319da.origin, 390, 325, 20);
  earthquake(1, 1, self.origin, 1000);
  self thread function_87cb9c09();
  level notify(#"hash_4135b76d6e69e9ef");

  if(var_353319da function_f6c31b03()) {
    level.player thread play_concussion_sound();
  }

  level notify(#"hash_523968c9e8e5864");
  var_353319da hide();
  self function_86201bb7();
}

function function_c0a3515() {
  e_c4_hint_validation = getent("e_c4_hint_validation", "targetname");

  if(istouching(level.player.origin, e_c4_hint_validation)) {
    return true;
  }

  return false;
}

function function_f5b3ba02() {
  e_c4_hint_validation = getent("e_c4_hint_validation", "targetname");

  if(istouching(level.player.origin, e_c4_hint_validation)) {
    return false;
  }

  return true;
}

function function_f6c31b03() {
  if(distance2dsquared(level.player.origin, self.origin) < sqr(375)) {
    return true;
  }

  return false;
}

function function_86201bb7() {
  self setModel("p9_rus_amk_anti_aircraft_flak_88_dmg_01");
}

function function_87cb9c09() {
  snd::play("evt_aa_gun_destroyed_explo", self);
  snd::play([1, "evt_aa_gun_destroyed_fire", 0], self);
}

function function_f547cd72(var_959e2242) {
  self show();
  playFXOnTag(#"maps/cp_kgb/fx9_kgb_c4_light_red", self, "tag_origin");
  self playSound(#"hash_1a64259d42447b53");
  wait 0.1;

  if(is_true(var_959e2242)) {
    return;
  }

  self hide();
}

function function_9f9e880e() {
  wait 0.5;
  uid = level namespace_61e6d095::create_waypoint("c4", self, #"hud_icon_c4", undefined, (0, 0, 10), undefined, 0);
  namespace_61e6d095::function_fdb73881(uid, 0, 750);
  namespace_61e6d095::set_state(uid, 1);
  level waittill(#"hud_icon_c4_red");
  namespace_61e6d095::function_309bf7c2(uid, #"hud_icon_c4_red");
  level waittill(#"hash_4135b76d6e69e9ef");
  namespace_61e6d095::remove(uid);
}

function play_concussion_sound() {
  self endon(#"death", #"disconnect");
  wait 0.25;
  var_7864ab8 = spawn("script_origin", (0, 0, 1));
  var_7864ab8.origin = self.origin;
  var_7864ab8 linkto(self);
  var_7864ab8 thread delete_ent_on_owner_death();
  var_7864ab8 playSound(#"hash_7e7a829722bc317f");
  var_7864ab8 playLoopSound(#"hash_27fc5cc3a6159138");
  wait 3.5;
  var_7864ab8 playSound(#"hash_232c0a525c4f016a");
  var_7864ab8 stoploopsound(0.5);
  wait 0.5;
  var_7864ab8 notify(#"delete");
  var_7864ab8 delete();
}

function function_bc3f8f44() {
  level waittill(#"hash_56a61cb4fe8b8e79");
  self util::remove_cursor_hint();
}

function delete_ent_on_owner_death() {
  self endon(#"delete");
  level.player waittill(#"death");
  self delete();
}

function function_7bd54d9c(v_center, v_angle) {
  v_from = v_center - anglesToForward(v_angle) * 70000 / 2;
  v_to = v_center + anglesToForward(v_angle) * 70000 / 2;
  leader = spawn("script_model", (v_from[0], v_from[1], v_from[2]));
  leader.angles = vectortoangles(v_to - v_from);
  leader setModel("veh_t8_mil_air_jet_fighter_mp_light");
  leader clientfield::set("planemortar_contrail", 1);
  leader playSound(#"mpl_lightning_flyover_boom");
  right = anglestoright(leader.angles);
  forward = anglesToForward(leader.angles);
  var_391cdbb7 = spawn("script_model", leader.origin + right * -777 + forward * -777);
  var_391cdbb7.angles = leader.angles;
  var_391cdbb7 setModel("veh_t8_mil_air_jet_fighter_mp_light");
  var_391cdbb7 clientfield::set("planemortar_contrail", 1);
  var_94e09305 = spawn("script_model", leader.origin + right * 2 * -777 + forward * 2 * -777);
  var_94e09305.angles = leader.angles;
  var_94e09305 setModel("veh_t8_mil_air_jet_fighter_mp_light");
  var_94e09305 clientfield::set("planemortar_contrail", 1);
  var_283227ae = spawn("script_model", leader.origin + right * -1 * -777 + forward * -777);
  var_283227ae.angles = leader.angles;
  var_283227ae setModel("veh_t8_mil_air_jet_fighter_mp_light");
  var_283227ae clientfield::set("planemortar_contrail", 1);
  var_a838a7c1 = spawn("script_model", leader.origin + right * -2 * -777 + forward * 2 * -777);
  var_a838a7c1.angles = leader.angles;
  var_a838a7c1 setModel("veh_t8_mil_air_jet_fighter_mp_light");
  var_a838a7c1 clientfield::set("planemortar_contrail", 1);
  leader moveto(leader.origin + forward * 70000, 10, 0, 0);
  var_391cdbb7 moveto(var_391cdbb7.origin + anglesToForward(var_391cdbb7.angles) * 70000, 10, 0, 0);
  var_94e09305 moveto(var_94e09305.origin + anglesToForward(var_94e09305.angles) * 70000, 10, 0, 0);
  var_283227ae moveto(var_283227ae.origin + anglesToForward(var_283227ae.angles) * 70000, 10, 0, 0);
  var_a838a7c1 moveto(var_a838a7c1.origin + anglesToForward(var_a838a7c1.angles) * 70000, 10, 0, 0);
}

function function_d8bbc9ee(str_targetname, var_1f74a2ae) {
  var_79ad0302 = getent(str_targetname, "targetname");
  var_79ad0302 hide();

  if(isDefined(var_1f74a2ae)) {
    level flag::wait_till(var_1f74a2ae);
  }

  var_79ad0302 show();
  var_79ad0302 util::create_cursor_hint(undefined, 0 * anglestoright(var_79ad0302.angles) + 0 * anglesToForward(var_79ad0302.angles) + 10 * anglestoup(var_79ad0302.angles), #"hash_7f71a2eef1f4de80");
  var_79ad0302 waittill(#"trigger");
  w_minigun = getweapon(#"hash_6fb61bc95fdf307c");
  w_minigun.var_4d97c40b = 1;
  w_minigun.var_a2e7031d = 1;
  level.player giveweapon(w_minigun);
  level.player setweaponammoclip(w_minigun, 900);
  level.player switchtoweapon(w_minigun);
  var_79ad0302 hide();
}