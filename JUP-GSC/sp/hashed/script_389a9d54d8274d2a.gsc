/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_389a9d54d8274d2a.gsc
*************************************************/

#using script_151f37cd7136b363;
#using script_2dcc22f11f14cb9;
#using script_3ef1b643f06851a8;
#using script_49511723a3204d35;
#using script_575fda2758b0a36e;
#using scripts\anim\dialogue;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\asm\cap;
#using scripts\asm\civilian\script_funcs;
#using scripts\asm\shared\utility;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\dev_menu;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\sp\objectives;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\ai_armor;
#using scripts\sp\anim;
#using scripts\sp\damagefeedback;
#using scripts\sp\dialogue_wheel;
#using scripts\sp\fakeactor;
#using scripts\sp\loot;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\stealth\manager;
#using scripts\sp\utility;
#using scripts\stealth\enemy;
#using scripts\stealth\event;
#using scripts\stealth\friendly;
#namespace namespace_fc0114e844f0b4c;

function function_d560058766307e41() {}

function function_cab089eaa337c908() {
  flag_set("introscreen_start_wait");
}

function function_748164ff55c9ec50() {
  index = namespace_d6cca25f4b0ab62::getlevelindex(level.script);

  if(!isDefined(index)) {
    return;
  }

  index += 1;
  index += 1;
  setomnvar("ui_chyron_level_index", index);
  setomnvar("ui_chyron_on", 1);
  setomnvar("ui_hide_dpad_hud", 1);
  wait 6;
  setomnvar("ui_hide_dpad_hud", 0);
  setomnvar("ui_chyron_on", 0);
  flag_wait("flg_chunnel_finale_done");
  setomnvar("ui_chyron_surge_chunnel", 0);
}

function function_2a5f16ea78f32af4(gesture_style, timeout, endon_notify) {
  self endon("death");
  gesture_style = default_to(gesture_style, "force");
  timeout = default_to(timeout, 5);
  endon_notify = default_to(endon_notify, "stop_radio_gesture");

  if(!weapon_empty(self.currentweapon) && self playerads() < 0.5 && level.player getstance() != "prone") {
    switch (gesture_style) {
      case #"hash_9e02cd4a0f3ca981":
        thread player_gesture_combat("iw9_vm_ges_radio_shoulder_sp_left");
        break;
      case #"hash_c6076a90d1a76064":
        thread player_gesture_noncombat("iw9_vm_ges_radio_shoulder_sp_left");
        break;
      case #"hash_d355a54be6ee3a64":
      default:
        thread player_gesture_force("iw9_vm_ges_radio_shoulder_sp_left");
        break;
    }
  }

  waitframe();
  self allowprone(0);
  function_a6601713e08e1bb0(timeout, endon_notify);
  waitframe();
  function_600f9ba1d61f24f0();
  self allowprone(1);
}

function function_600f9ba1d61f24f0() {
  self notify("stop_radio_gesture");

  if(!weapon_empty(self.currentweapon) && self isgestureplaying("iw9_vm_ges_radio_shoulder_sp_left")) {
    self stopgestureviewmodel("iw9_vm_ges_radio_shoulder_sp_left", 2);
  }
}

function function_a6601713e08e1bb0(timeout, endon_notify) {
  self endon("death");
  self endon(endon_notify);
  waitframe();

  if(!self isgestureplaying("iw9_vm_ges_radio_shoulder_sp_left")) {
    return;
  }

  end_time = gettime() + function_a5b14435e3229bed(timeout);

  while(true) {
    if(self adsButtonPressed() || self attackButtonPressed() || self meleeButtonPressed() || self weaponswitchbuttonPressed() || self reloadbuttonPressed() || self isswitchingweapon()) {
      break;
    }

    if(gettime() >= end_time) {
      break;
    }

    waitframe();
  }
}

function function_51e465c575adc466() {
  if(getdvarint(@ "hash_51412b605eba83b2", 0) == 1) {
    return;
  }

  trigs = getEntArray("trig_surge_dynamic_oob", "script_noteworthy");
  array_thread(trigs, &function_dbb8a16cccd453c8);
}

function function_dbb8a16cccd453c8() {
  warn_trigger = self;
  assertex(isDefined(warn_trigger.target), "Dynamic OOB trigger at " + self.origin + " needs to target a second trigger_multiple (used as a fail trigger)");
  fail_trigger = getEnt(self.target, "targetname");

  if(warn_trigger.script_parameters == "trig_oob_start_enabled") {
    warn_trigger trigger_on();
    fail_trigger trigger_on();
  } else {
    warn_trigger trigger_off();
    fail_trigger trigger_off();
  }

  assertex(isDefined(warn_trigger.script_flag_wait), "Dynamic OOB trigger at " + self.origin + " needs a 'script_flag_wait' KVP");
  level flag_wait(warn_trigger.script_flag_wait);

  if(warn_trigger.script_parameters == "trig_oob_start_enabled") {
    warn_trigger trigger_off();
    fail_trigger trigger_off();
    return;
  }

  warn_trigger trigger_on();
  fail_trigger trigger_on();
}

function function_8d1ff20eca7dfb0() {
  level endon("flg_chunnel_diffuse_done");
  var_fb0d12d8afc2cc9d = getEnt("tr_player_bomb_fail", "targetname");
  b_touching = 0;

  while(!b_touching) {
    if(level.player istouching(var_fb0d12d8afc2cc9d)) {
      b_touching = 1;
      break;
    }

    wait 0.1;
  }

  flag_set("flag_defusal_fail");
}

function function_8d2c23481bd4016c(b_allow) {
  registered = "park_unarmed";
  val::set(registered, "melee", b_allow);
  val::set(registered, "ads", b_allow);
  val::set(registered, "offhand_primary_weapons", b_allow);
  val::set(registered, "offhand_secondary_weapons", b_allow);
}

function function_605bcda00552e0d6(str_basename, var_a3d8d29d1e96d221, var_6943905c39fae8af, var_5ad84c931cd39930, var_4ad67787b9496e24) {
  if(!isDefined(var_a3d8d29d1e96d221)) {
    var_a3d8d29d1e96d221 = [];
  }

  weapon = make_weapon(str_basename, var_a3d8d29d1e96d221);
  name = getcompleteweaponname(weapon);
  var_6943905c39fae8af = default_to(var_6943905c39fae8af, 0);
  var_33c341bbb4ca0ec0 = default_to(var_33c341bbb4ca0ec0, 1);
  var_4ad67787b9496e24 = default_to(var_4ad67787b9496e24, 0);
  spawnflags = 0;

  if(var_6943905c39fae8af) {
    spawnflags = 1;
  }

  if(var_4ad67787b9496e24) {
    spawnflags = 1 | 16;
  }

  weapon_pos = self.origin;

  if(istrue(var_5ad84c931cd39930)) {
    dist = randomfloatrange(48, 64);
    dir = flatten_vector(randomvector(1));
    v_pos = weapon_pos + dir * dist;
    weapon_pos = getgroundposition(v_pos, 32) + (0, 0, 8);
  }

  weapon_pickup = spawn("weapon_" + name, weapon_pos, spawnflags);
  weapon_pickup.angles = (0, 0, 0);

  if(isDefined(self.angles)) {
    weapon_pickup.angles = self.angles;
  }

  weapon_pickup itemweaponsetammo(weaponclipsize(weapon_pickup), weaponmaxammo(weapon_pickup));
  return weapon_pickup;
}

function function_e8742f4c64a81042() {
  add_global_spawn_function("axis", &function_f6dcbd89f53acc10);
}

function function_f6dcbd89f53acc10() {
  if(isDefined(self.script_stealthgroup)) {
    self function_d493e7fe15e5eaf4("jup_sp_surge");
  }
}

function function_6b1734af5c679095() {
  level endon("game_ended");
  level.player endon("death");
  oow_vol = getEnt("debug_outofworld", "targetname");

  while(isDefined(oow_vol)) {
    oow_vol waittill("trigger", ent);

    if(isPlayer(ent) && (ent isnoclip() || ent isufo())) {
      wait 0.1;
      continue;
    }

    assertmsg("<dev string:x1c>" + ent.origin);
    iprintlnbold("<dev string:x1c>" + ent.origin);

    if(isPlayer(ent) || isai(ent) || ent scripts\common\vehicle::isvehicle()) {
      ent kill();
    }
  }
}

function function_acde8590daa9b6dd() {}

function function_e3a57216f5802c88() {
  level.var_51ce596b2b43d192 = (-968, 288, 0);
  level.var_1b9b94b7c625c090 = (0, 0, 0);
  level.e_price = spawn_script_origin(level.var_51ce596b2b43d192);
  level.e_price.team = "allies";
  level.e_price.name = "Price";
  level.var_30ea3080946719e6 = spawn_script_origin(level.var_51ce596b2b43d192);
  level.var_30ea3080946719e6.team = "allies";
  level.var_30ea3080946719e6.name = "Price (Radio)";
  level.e_gaz = spawn_script_origin(level.var_51ce596b2b43d192);
  level.e_gaz.team = "allies";
  level.e_gaz.name = "Gaz";
  level.var_351f8aca05656919 = spawn_script_origin(level.var_51ce596b2b43d192);
  level.var_351f8aca05656919.team = "allies";
  level.var_351f8aca05656919.name = "Gaz (Radio)";
  level.e_ghost = spawn_script_origin(level.var_51ce596b2b43d192);
  level.e_ghost.team = "allies";
  level.e_ghost.name = "Ghost";
  level.var_292c01a9cd0b2818 = spawn_script_origin(level.var_51ce596b2b43d192);
  level.var_292c01a9cd0b2818.team = "allies";
  level.var_292c01a9cd0b2818.name = "Ghost (Radio)";
  level.e_soap = spawn_script_origin(level.var_51ce596b2b43d192);
  level.e_soap.team = "allies";
  level.e_soap.name = "Soap";
  level.var_1e081d778021da22 = spawn_script_origin(level.var_51ce596b2b43d192);
  level.var_1e081d778021da22.team = "allies";
  level.var_1e081d778021da22.name = "Soap (Radio)";
  level.var_318c75041f10c73f = spawn_script_origin(level.var_51ce596b2b43d192);
  level.var_318c75041f10c73f.team = "allies";
  level.var_318c75041f10c73f.name = "Laswell (Radio)";
  level.var_f119a54aa1b67293 = spawn_script_origin(level.var_51ce596b2b43d192);
  level.var_f119a54aa1b67293.team = "allies";
  level.var_f119a54aa1b67293.name = "SFO 1";
  level.var_f119a64aa1b674c6 = spawn_script_origin(level.var_51ce596b2b43d192);
  level.var_f119a64aa1b674c6.team = "allies";
  level.var_f119a64aa1b674c6.name = "SFO 2";
  level.var_25932e13dae83dd3 = spawn_script_origin(level.var_51ce596b2b43d192);
  level.var_25932e13dae83dd3.team = "allies";
  level.var_25932e13dae83dd3.name = "SFO (Radio)";
  level.e_makarov = spawn_script_origin(level.var_51ce596b2b43d192);
  level.e_makarov.team = "axis";
  level.e_makarov.name = "Makarov";
}

function function_3c4b810d62d1f03f() {
  level.var_d18d63c6d75cd1e = spawn_targetname("sp_hideout_gaz", 1);
  level.ai_soap = spawn_targetname("sp_hideout_soap", 1);
  level.var_679be75090dd2a47 = [level.var_d18d63c6d75cd1e, level.ai_soap];
  level.var_d18d63c6d75cd1e.animname = "gaz";
  level.var_d18d63c6d75cd1e set_name("Gaz");
  level.var_d18d63c6d75cd1e.callsign = "Bravo 6-1";
  level.var_d18d63c6d75cd1e.team = "allies";
  level.ai_soap.animname = "soap";
  level.ai_soap set_name("Soap");
  level.ai_soap.callsign = "Bravo 7-1";
  level.ai_soap.team = "allies";

  foreach(ally in level.var_679be75090dd2a47) {
    ally thread function_ca482daad45d30fc();
  }

  level flag_set("flg_init_allies_spawned");
}

function function_109726d29627f8de() {
  if(!scripts\sp\starts::is_after_start("chunnel_vents")) {
    level.ai_ghost = spawn_targetname("sp_chunnel_ghost", 1);
    waitframe();
    level.var_d18d63c6d75cd1e = spawn_targetname("sp_chunnel_gaz", 1);
    waitframe();
    level.ai_ghost.animname = "ghost";
    level.ai_ghost.script_noteworthy = "ghost";
    level.ai_ghost set_name("Ghost");
    level.ai_ghost.callsign = "Bravo 0-7";
    level.ai_ghost function_c1e075c4168a8bea(0, 0);
    level.var_d18d63c6d75cd1e.animname = "gaz";
    level.var_d18d63c6d75cd1e.script_noteworthy = "gaz";
    level.var_d18d63c6d75cd1e set_name("Gaz");
    level.var_d18d63c6d75cd1e.callsign = "Bravo 6-1";
    level.var_d18d63c6d75cd1e function_c1e075c4168a8bea(0, 0);
  }

  if(!scripts\sp\starts::is_after_start("chunnel_bomb")) {
    level.ai_soap = spawn_targetname("sp_chunnel_soap", 1);
  } else {
    level.ai_soap = spawn_targetname("sp_chunnel_soap", 1);
    level.ai_ghost = spawn_targetname("sp_chunnel_ghost", 1);
    waitframe();
    level.var_d18d63c6d75cd1e = spawn_targetname("sp_chunnel_gaz", 1);
    waitframe();
    level.ai_ghost.animname = "ghost";
    level.ai_ghost.script_noteworthy = "ghost";
    level.ai_ghost set_name("Ghost");
    level.ai_ghost.callsign = "Bravo 0-7";
    level.ai_ghost function_c1e075c4168a8bea(0, 0);
    level.var_d18d63c6d75cd1e.animname = "gaz";
    level.var_d18d63c6d75cd1e.script_noteworthy = "gaz";
    level.var_d18d63c6d75cd1e set_name("Gaz");
    level.var_d18d63c6d75cd1e.callsign = "Bravo 6-1";
    level.var_d18d63c6d75cd1e function_c1e075c4168a8bea(0, 0);
  }

  waitframe();
  level.ai_soap.animname = "soap";
  level.ai_soap.script_noteworthy = "soap";
  level.ai_soap set_name("Soap");
  level.ai_soap.callsign = "Bravo 7-1";
  level.ai_soap function_c1e075c4168a8bea(0, 0);
  level.var_679be75090dd2a47 = [level.ai_soap];
  level.ai_soap thread function_a2d394a1dcdc952c();

  if(!scripts\sp\starts::is_after_start("chunnel_vents")) {
    level.var_679be75090dd2a47 = array_add(level.var_679be75090dd2a47, level.ai_ghost);
    level.var_679be75090dd2a47 = array_add(level.var_679be75090dd2a47, level.var_d18d63c6d75cd1e);
  }

  foreach(ally in level.var_679be75090dd2a47) {
    if(isDefined(ally)) {
      ally thread function_ca482daad45d30fc();
      continue;
    }

    iprintln("<dev string:x93>");
  }

  level flag_set("flg_init_allies_spawned");
}

function function_ca482daad45d30fc() {
  thread scripts\common\ai::magic_bullet_shield();
  function_60e33f7446b138d3(0);
  gun_remove();
  self.allowstrafe = 0;

  switch (self.animname) {
    case #"hash_fb36726c0708cd6d":
      gun = make_weapon("jup_jp04_sm_umike_sp", ["jup_umike_rec", "jup_jp04_sm_umike_bar", "jup_jp04_sm_umike_stock_folding", "jup_jp04_sm_umike_mag_30_45acp", "jup_reflex02_tall", "jup_silencer_sm_05", "jup_jp04_sm_umike_pgrip_tac", "grip_vert01", "lasercyl_ads01"]);
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
    case #"hash_eb334ee53284b5b0":
      gun = make_weapon("iw9_ar_kilo53_sp", ["iw9_minireddot01_tall", "mag_ar_p02"]);
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
    case #"hash_df31f98a0b34e496":
      gun = make_weapon("jup_jp04_sm_umike_sp", ["jup_umike_rec", "jup_jp04_sm_umike_bar", "jup_jp04_sm_umike_stock_folding", "jup_jp04_sm_umike_mag_30_45acp", "jup_reflex02_tall", "jup_silencer_sm_05", "jup_jp04_sm_umike_pgrip_tac", "grip_vert01", "lasercyl_ads01"]);
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
    default:
      gun = make_weapon("iw9_ar_kilo53_sp", ["iw9_minireddot01_tall", "silencer01_ar", "mag_ar_p02"]);
      scripts\anim\shared::forceuseweapon(gun, "primary");
      break;
  }
}

function function_60e33f7446b138d3(var_4be6cf1960d8f368) {
  set_ignoreme(!var_4be6cf1960d8f368);
  set_ignoreall(!var_4be6cf1960d8f368);

  if(var_4be6cf1960d8f368) {
    disable_dontevershoot();
    return;
  }

  enable_dontevershoot();
}

function function_5d63cafa66a6688f() {
  if(ent_flag("flag_ally_cornercheck_init")) {
    return;
  }

  self function_523285babab34e5b("shallow", 1);
  self function_ffa9225d13be97b8("shallow", 1);
  self function_523285babab34e5b("wide_slice", 0);
  self function_523285babab34e5b("cautious", 0);
  self function_523285babab34e5b("stepout", 0);
  self function_523285babab34e5b("aim_only", 0);
  self function_523285babab34e5b("strafe_only", 0);
  ent_flag_set("flag_ally_cornercheck_init");
}

function function_61f8d605d3de4b3c() {
  function_5d63cafa66a6688f();

  if(!self function_5d47d51f75e38a7e("shallow")) {
    self function_4ca9518dc8bef142("shallow", 1);
  }
}

function function_54acf8d0f205db76() {
  function_5d63cafa66a6688f();

  if(self function_5d47d51f75e38a7e("shallow")) {
    self function_4ca9518dc8bef142("shallow", 0);
  }
}

function function_b93f21d1614cf800() {
  if(!isDefined(level.stealth)) {
    scripts\sp\stealth\manager::main();
  }

  self.script_stealthgroup = "surge_allies";

  if(!isDefined(self.stealth)) {
    scripts\stealth\friendly::init_settings();
  }

  self.stealth_groupname = self.script_stealthgroup;
  self function_95d5375059c2a022("mp_stealth");
  utility::ent_flag_set("stealth_enabled");
  scripts\stealth\friendly::state_hidden();
  self.dontevershoot = 0;
  self.var_43ae9f4734246fb0 = 1;
  set_pacifist(1);
  set_ignoreme(1);
}

function function_b2f2f578fc6cf99a() {
  if(isDefined(self.stealth)) {
    if(!utility::ent_flag_exist("stealth_enabled")) {
      utility::ent_flag_init("stealth_enabled");
    }

    utility::ent_flag_clear("stealth_enabled");
    scripts\stealth\friendly::state_spotted();
  }

  self.var_43ae9f4734246fb0 = 0;
  self.dontevershoot = 0;
  set_pacifist(0);
  set_ignoreme(0);
}

function function_7cc0459bf11198d8() {
  if(!isDefined(level.poi_activeai)) {
    level.poi_activeai = [];
  }

  structs = getStructArray("s_poi", "targetname");

  if(structs.size == 0) {
    return;
  }

  foreach(struct in structs) {
    function_3a5a98ac68582e12(struct.origin, undefined);
  }
}

function function_6323c0b324a46589() {
  self.var_a6f71666f642935b = 1;
  self function_f51ff412609193b9(1, "script");
  self.turnrate = 0.1;
  self.allowstrafe = 0;
  self.ignoresuppression = 1;

  if(!ent_flag_exist("flag_ai_poi_enabled")) {
    ent_flag_init("flag_ai_poi_enabled");
  }

  ent_flag_set("flag_ai_poi_enabled");
}

function function_ac29a8f995b25125() {
  self.var_a6f71666f642935b = 0;
  self function_f51ff412609193b9(0, "script");
  self.turnrate = 1;
  self.allowstrafe = 1;
  self.ignoresuppression = 0;

  if(ent_flag_exist("flag_ai_poi_enabled")) {
    ent_flag_clear("flag_ai_poi_enabled");
  }
}

function function_611e1773b954bba8(node) {
  function_ac29a8f995b25125();
  ent_flag_set("flag_ai_poi_was_enabled");
  waitframe();
  struct = node utility::get_linked_struct();

  if(isDefined(struct)) {
    scripts\asm\shared\utility::toggle_poi(1, struct);
  }
}

function function_e9c671809532e182(var_67f91a13ea1c90c0) {
  var_67f91a13ea1c90c0 = default_to(var_67f91a13ea1c90c0, 1);
  scripts\asm\shared\utility::toggle_poi(0);
  waitframe();

  if(istrue(var_67f91a13ea1c90c0)) {
    if(ent_flag_exist("flag_ai_poi_was_enabled") && ent_flag("flag_ai_poi_was_enabled")) {
      function_6323c0b324a46589();
      ent_flag_clear("flag_ai_poi_was_enabled");
    }
  }
}

function function_66f6fc5de98921d8(var_b5f9ca91dfd03874, n_aim_time, var_42c6cb07eae0fdaa) {
  setdvarifuninitialized(@ "hash_500912e607f2c429", 0);

  n_aim_time = utility::default_to(n_aim_time, 0.5);
  var_42c6cb07eae0fdaa = utility::default_to(var_42c6cb07eae0fdaa, 1.5);

  if(isDefined(self.aim_target) && self.aim_target islinked()) {
    self.aim_target unlink();
  }

  aim_tag = "tag_origin";

  if(isai(var_b5f9ca91dfd03874)) {
    aim_tag = "tag_eye";
  }

  if(utility::is_aiming()) {
    utility::move_aim_to_enemy(var_b5f9ca91dfd03874, aim_tag, var_42c6cb07eae0fdaa);
    return;
  }

  if(isai(var_b5f9ca91dfd03874)) {
    utility::aim_at(var_b5f9ca91dfd03874 getEye(), 0, undefined, n_aim_time);
  } else {
    utility::aim_at(var_b5f9ca91dfd03874.origin, 0, undefined, n_aim_time);
  }

  utility::link_aim_to(var_b5f9ca91dfd03874, aim_tag, (0, 0, 0));
}

function function_7169934679bd2f21() {
  utility::stop_aiming();
  ai::reset_gunpose();
}

function function_f19d721de81462d(flg_cleanup) {
  self endon("death");
  self endon("entitydeleted");
  flag_wait(flg_cleanup);

  if(isDefined(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  self delete();
}

function function_678ee05eb44c1fb9(ai_ref, var_ef2ce443bff9166c, str_endon_flag, var_8bd328a111ac43d5) {
  level.player endon("death");
  level endon(var_ef2ce443bff9166c);

  if(isDefined(str_endon_flag)) {
    if(flag(str_endon_flag)) {
      return;
    }

    level endon(str_endon_flag);
  }

  var_8bd328a111ac43d5 = default_to(var_8bd328a111ac43d5, 0);

  if(!isDefined(ai_ref)) {
    return;
  }

  ai_ref endon("death");
  ai_ref endon("entitydeleted");
  var_d795bfe4371a3f23 = trace::create_world_contents();

  while(true) {
    if(within_fov(level.player getEye(), level.player getplayerangles(), ai_ref.origin, cos(30))) {
      hits = physics_raycast(level.player getEye(), ai_ref getEye(), var_d795bfe4371a3f23, undefined, 0, "physicsquery_closest");

      if(isDefined(hits) && hits.size <= var_8bd328a111ac43d5) {
        flag_set(var_ef2ce443bff9166c);
        return;
      }
    }

    waitframe();
  }
}

function function_20e52f38cd19d6dc(obj_ref, var_ef2ce443bff9166c, str_endon_flag) {
  level.player endon("death");
  level endon(var_ef2ce443bff9166c);

  if(isDefined(str_endon_flag)) {
    if(flag(str_endon_flag)) {
      return;
    }

    level endon(str_endon_flag);
  }

  if(!isDefined(obj_ref)) {
    return;
  }

  var_d795bfe4371a3f23 = trace::create_world_contents();

  while(true) {
    if(within_fov(level.player getEye(), level.player.angles, obj_ref.origin, cos(30))) {
      hits = physics_raycast(level.player getEye(), obj_ref.origin, var_d795bfe4371a3f23, undefined, 0, "physicsquery_closest");

      if(isDefined(hits) && hits.size == 0) {
        level flag_set(var_ef2ce443bff9166c);
        return;
      }
    }

    waitframe();
  }
}

function function_75519ed05932e7ac() {
  function_ed0894b662fdb345();
  function_95685dc66b96631f();
  function_e3a57216f5802c88();
}

function function_95685dc66b96631f() {
  level.player function_6078d3c20d55c620();
  var_2f7136cf6c5b1b14 = ["flash", "frag"];
  offhandprecache(var_2f7136cf6c5b1b14);
  level.player give_offhand("flash", 4);
  level.player give_offhand("frag", 4);
  weapon_close = utility::make_weapon("jup_jp04_sm_umike_sp", ["jup_umike_rec", "jup_jp04_sm_umike_bar", "jup_jp04_sm_umike_stock_folding", "jup_jp04_sm_umike_mag_30_45acp", "jup_reflex02_tall", "jup_silencer_sm_05", "jup_jp04_sm_umike_pgrip_tac", "grip_vert01", "lasercyl_ads01"]);
  weapon_long = utility::make_weapon("jup_jp08_ar_qbravo97_sp", ["jup_jp08_ar_qbravo97_bar_hvylong", "jup_jp08_ar_qbravo97_stock_padded", "jup_jp08_ar_qbravo97_mag_30_556n", "hybrid01", "jup_breacher_ar_01", "jup_jp08_ar_qbravo97_pgrip_tac"]);
  level.player give_weapon(weapon_close, 0, 0, 0, 0);
  level.player give_weapon(weapon_long, 0, 0, 0, 1);
  level.player switchtoweapon(weapon_close);
  curr_weapons = level.player getweaponslistprimaries();

  foreach(weapon in curr_weapons) {
    level.player givemaxammo(weapon);
  }

  level.player utility::function_fef4d6151e091533();
}

function function_9fb9e62d704f95df() {}

function function_3025ee051d28ec46(a_ai_enemies, var_ef2ce443bff9166c, num_dead, str_endon_flag) {
  if(isDefined(str_endon_flag)) {
    if(isarray(str_endon_flag)) {
      foreach(str_flag in str_endon_flag) {
        if(flag(str_flag)) {
          return;
        }

        level endon(str_flag);
      }
    } else {
      if(flag(str_endon_flag)) {
        return;
      }

      level endon(str_endon_flag);
    }
  }

  a_ai_enemies = array_removedead_or_dying(a_ai_enemies);

  if(a_ai_enemies.size > 0) {
    num_dead = default_to(num_dead, a_ai_enemies.size);

    if(a_ai_enemies.size >= num_dead) {
      waittill_dead_or_dying(a_ai_enemies, num_dead);
    }
  }

  level flag_set(var_ef2ce443bff9166c);
}

function function_917b92dbdc280a05(event) {
  scripts\stealth\enemy::bt_event_combat(event);
}

function function_c46190387a11636d(var_9d314d675e489cb4) {
  level.player endon("death");
  var_53d38520a274620d = self.origin;
  n_max_dist = squared(536);
  n_dist = distance2dsquared(level.player.origin, var_53d38520a274620d);

  if(n_dist <= n_max_dist && utility::within_fov_of_players(var_53d38520a274620d, cos(30))) {
    var_d795bfe4371a3f23 = trace::create_world_contents();

    switch (var_9d314d675e489cb4) {
      case 1:
        var_e3ebf19f1d3ef0bd = array_combine(level.var_f76b29c280893d5f.var_573c7a1092b362c, [level.player, self]);
        break;
      case 2:
      default:
        var_e3ebf19f1d3ef0bd = array_combine(level.var_f76b2ac280893f92.var_573c7a1092b362c, [level.player, self]);
        break;
    }

    hits = physics_raycast(level.player getEye(), var_53d38520a274620d, var_d795bfe4371a3f23, var_e3ebf19f1d3ef0bd, 0, "physicsquery_closest");

    if(hits.size < 1) {
      utility::flag_set("flg_chunnel_player_sees_enemy_die_on_tracks");
    }
  }
}

function function_2f2c39293536be97() {}

function function_2e73fd94788b095c(shader) {
  self.icon_spot = spawn_tag_origin((0, 0, 0), (0, 0, 0));
  self.icon_spot dontinterpolate();
  self.icon_spot linkTo(self, "j_spine4", default_to(self.var_308709ddd890f321, (0, 12, 0)), self gettagangles("j_spine4") + (90, 90, 90));
  self.icon = createheadicon(self.icon_spot);
  setheadiconimage(self.icon, shader);
  setheadiconmaxdistance(self.icon, 5000);
  setheadiconnaturaldistance(self.icon, 100);
  setheadiconsnaptoedges(self.icon, 1);
  setheadiconzoffset(self.icon, 1);
  setheadicondrawthroughgeo(self.icon, 0);
}

function function_ad1fc1e84ba347ed(b_visible, disabled) {
  if(!isDefined(disabled)) {
    disabled = 1;
  }

  if(disabled) {
    return;
  }

  if(b_visible) {
    function_2e73fd94788b095c("icon_private_match");
    return;
  }

  deleteheadicon(self.icon);
  self.icon = undefined;
}

function function_19d6aac9b1c98db0() {}

function function_c8ab420a24aa86a0(duration, vector) {
  self forceplaygestureviewmodel("ges_frag_block");
  thread function_e6adaacdaa180c6(vector);
  self pushplayervector(vector, 1);
  wait duration;
  self notify("wind_complete");
  self pushplayervector((0, 0, 0), 1);
}

function function_e6adaacdaa180c6(vector) {
  self endon("wind_complete");
  v_x = vector[0];
  v_y = vector[1];
  v_z = vector[2];
  lerp_incr = 2;
  wait 0.5;

  while(true) {
    if(v_x > 0) {
      v_x -= lerp_incr;
    } else {
      v_x = 0;
    }

    if(v_x > 0) {
      v_x -= lerp_incr;
    } else {
      v_x = 0;
    }

    if(v_x > 0) {
      v_x -= lerp_incr;
    } else {
      v_x = 0;
    }

    vector_new = (v_x, v_y, v_z);
    self pushplayervector(vector_new, 1);
    wait lerp_incr;
  }
}

function function_f34c3dfb460abf35() {}

function function_123c15b9c0463d22(var_b55159e3b9d5a0db, var_b5515ae3b9d5a30e, var_b5515be3b9d5a541) {
  level notify("rewind_start");

  if(!isDefined(level.var_a067a16459d9d684)) {
    level.var_a067a16459d9d684 = 0.77;
  }

  if(!isDefined(level.var_feaef936e2681c46)) {
    level.var_feaef936e2681c46 = 0.127;
  }

  if(!isDefined(level.var_d3d2b1c044f0f690) || level.var_d3d2b1c044f0f690 > 1 || level.var_d3d2b1c044f0f690 < 0) {
    level.var_d3d2b1c044f0f690 = 0.4074;
  }

  level.exclude_actors = 1;
  level.var_c3305d9e1394738a = 0;
  level.var_472e51223e29e497 = ["sequential_normal", "sequential_block", "sequential_notify_stopped", "sequential_notify_note", "sequential_incremental_shot", "simultaneous"];
  level.var_db84ce6e46a67e02 = (0, 0, 0);
  level.var_13aaa384c5801cc4 = 0;
  level.var_7d7f0b9f883c729c = 0;
  level.var_aff681d21d7b60b3 = 1;

  if(!isDefined(var_b55159e3b9d5a0db)) {
    var_b55159e3b9d5a0db = "rewind_scene";
  }

  function_e2360e37f48b9a68(var_b55159e3b9d5a0db, var_b5515ae3b9d5a30e, var_b5515be3b9d5a541);

  if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
    thread function_67f9870973a20b3d();
  }

  thread function_cce8d055627bd000();
  function_b0cd10f0657ad98b();

  if(getdvarint(@ "hash_35be7aa97bf9ec4c", 1)) {
    thread function_8752124791e8f26a();
  }

  thread function_6de5a02673de3113();
  thread function_db195be115ef65d1();
}

function function_b0cd10f0657ad98b() {
  level.var_7d7f0b9f883c729c = level.var_d3d2b1c044f0f690;
  var_3fd1ee4ee5b86f02 = (level.var_7d7f0b9f883c729c - level.var_feaef936e2681c46) / (level.var_a067a16459d9d684 - level.var_feaef936e2681c46);
  setomnvar("ui_cctv_scrub_pcnt", var_3fd1ee4ee5b86f02);
  level.var_aff681d21d7b60b3 = 1;
  thread function_45d971942809e316();

  if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
    function_c728c5a4f8d6bc5c(level.var_aff681d21d7b60b3, undefined, 1);
  }

  setomnvar("ui_cctv_camera_state", 3);

  foreach(scene in level.var_855197dadb1d426f) {
    scene scene::set_anim_rate(level.var_e11a50d90bd1330c);

    foreach(shot in scene scene::function_8a37fe423de2b9db()) {
      scene thread scene::play(function_a94018be719172ec(), shot, undefined, level.var_7d7f0b9f883c729c);
    }
  }

  if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
    function_c728c5a4f8d6bc5c(level.var_7d7f0b9f883c729c, 4);
  }

  thread function_3bb6e9ad233dea6b();
}

function function_cce8d055627bd000() {
  level endon("rewind_scenes_stop");
  level waittill_any("rewind_scenes_stop", "death", "endgame", "cctv_end", "rewind_start");
  function_452314cba17d863b();
}

function function_452314cba17d863b() {
  level.player notifyonplayercommandremove("cctv_scene_rewind_press", "+moveleft");
  level.player notifyonplayercommandremove("cctv_stop_rewind", "-moveleft");
  level.player notifyonplayercommandremove("cctv_scene_fastforward_press", "+moveright");
  level.player notifyonplayercommandremove("cctv_stop_fastforward", "-moveright");
  level.player notifyonplayercommandremove("cctv_scene_rewind_press", "+actionslot 3");
  level.player notifyonplayercommandremove("cctv_stop_rewind", "-actionslot 3");
  level.player notifyonplayercommandremove("cctv_scene_fastforward_press", "+actionslot 4");
  level.player notifyonplayercommandremove("cctv_stop_fastforward", "-actionslot 4");
  level.player notifyonplayercommandremove("cctv_scene_pause_play_press", "+gostand");

  if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
    function_136ec1dc4a65b7b5();
  }

  if(isDefined(level.var_c704d62107e63248)) {
    level.var_c704d62107e63248 destroy();
  }

  if(isDefined(level.var_c704d92107e638e1)) {
    level.var_c704d92107e638e1 destroy();
  }

  thread function_fabd7c3611c28045();
  setomnvar("ui_cctv_scrub_pcnt", 1);
  setomnvar("ui_cctv_camera_state", 0);
  flag_clear("CCTV_rewind_active");
  level notify("rewind_scenes_stop");
}

function function_fabd7c3611c28045() {
  foreach(scene_struct in level.var_855197dadb1d426f) {
    sceneroot = scene_struct;
    level.var_e11a50d90bd1330c = 1;
    scene_struct scene::set_anim_rate(level.var_e11a50d90bd1330c);
    sceneroot stop();
    sceneroot thread function_8a84e3af8d37b230();
    ents = scene_struct scene::get_entities();
    sceneroot stop();

    foreach(ent in ents) {
      if(isDefined(ent)) {
        ent stopanimScripted();
        ent delete();
      }
    }
  }
}

function function_136ec1dc4a65b7b5() {
  level notify("stop_all_menus");
  level.menu_sys["current_menu"].title.alive = 0;
  options = level.menu_sys["current_menu"].options;

  for(i = 0; i < options.size; i++) {
    options[i].alive = 0;

    if(!isDefined(level.menu_sys["current_menu"].optionsvalue)) {
      continue;
    }

    if(isDefined(level.menu_sys["current_menu"].optionsvalue[i])) {
      level.menu_sys["current_menu"].optionsvalue[i].alive = 0;
    }
  }

  level.menu_sys["current_menu"].options = [];

  if(isDefined(level.menu_sys["current_menu"].optionsvalue)) {
    level.menu_sys["current_menu"].optionsvalue = [];
  }

  if(isDefined(level.menu_cursor)) {
    level.menu_cursor.alive = 0;
    level.menu_cursor = undefined;
  }

  level notify("stop_menu_input");
}

function function_67f9870973a20b3d() {
  thread init_menus();
  menu = "scene_menu";
  add_menu(menu, "CCTV Rewind Controls:", 0);
  add_menuoptions(menu, "DPAD Right or D Key: Fast Forward", undefined, undefined, "");
  add_menuoptions(menu, "DPAD Left or A Key: Rewind", undefined, undefined, "");
  add_menuoptions(menu, "A or X Button or Space Key: Play or Pause", undefined, undefined, "");
  defaultscenename = "";

  if(level.var_855197dadb1d426f.size > 0) {
    defaultscenename = level.var_855197dadb1d426f[0].script_scenescriptbundle;
  }

  add_menuoptions(menu, "Anim rate:", undefined, undefined, level.var_aff681d21d7b60b3);
  add_menuoptions(menu, "Anim timeline:", undefined, undefined, level.var_7d7f0b9f883c729c);
  add_menuoptions(menu, "Rewind Scene min time:", undefined, undefined, level.var_feaef936e2681c46);
  add_menuoptions(menu, "Rewind Scene max time:", undefined, undefined, level.var_a067a16459d9d684);

  function_c5dcf2ac854f0273();

  function_c5dcf2ac854f0273();

  enable_menu("scene_menu");
}

function function_8752124791e8f26a() {
  level.player endon("death");
  level endon("rewind_scenes_stop");
  level.var_c704d62107e63248 = newhudelem();
  level.var_c704d62107e63248.alignx = "center";
  level.var_c704d62107e63248.aligny = "middle";
  level.var_c704d62107e63248.fontscale = 5;
  level.var_c704d62107e63248.x = 300;
  level.var_c704d62107e63248.y = 40;
  level.var_c704d62107e63248 settext("");
  level.var_c704d92107e638e1 = newhudelem();
  level.var_c704d92107e638e1.alignx = "left";
  level.var_c704d92107e638e1.aligny = "middle";
  level.var_c704d92107e638e1.fontscale = 5;
  level.var_c704d92107e638e1.x = 330;
  level.var_c704d92107e638e1.y = 40;
  level.var_c704d92107e638e1 settext("");
  self.var_4093533ee8113ef = 0;

  while(true) {
    if(level.var_aff681d21d7b60b3 == 1) {
      level.var_c704d62107e63248 settext("");
      level.var_c704d92107e638e1 settext("");
    } else if(self.var_4093533ee8113ef) {
      level.var_c704d62107e63248 settext("");
      level.var_c704d92107e638e1 settext("");
    }

    var_c53b510d02b534e0 = level.player waittill_any_return("cctv_scene_rewind_press", "cctv_scene_fastforward_press", "cctv_scene_pause_play_press", "cam_switch");

    if(isDefined(var_c53b510d02b534e0)) {
      if(!self.var_4093533ee8113ef) {
        self.var_4093533ee8113ef = 1;
      }

      if(var_c53b510d02b534e0 == "cctv_scene_fastforward_press") {
        level.var_c704d62107e63248 settext("");
        level.var_c704d92107e638e1 settext("");
        level.player waittill("cctv_stop_fastforward");
      }

      if(var_c53b510d02b534e0 == "cctv_scene_rewind_press") {
        level.var_c704d62107e63248 settext("");
        level.var_c704d92107e638e1 settext("");
        level.player waittill("cctv_stop_rewind");
      }

      if(var_c53b510d02b534e0 == "cctv_scene_pause_play_press") {
        waitframe();

        if(level.var_aff681d21d7b60b3 == 1) {
          level.var_c704d62107e63248 settext("");
          level.var_c704d92107e638e1 settext("");
        } else {
          level.var_c704d62107e63248 settext("");
          level.var_c704d92107e638e1 settext("");
        }
      }

      if(var_c53b510d02b534e0 == "cam_switch") {
        level.var_c704d62107e63248 settext("");
        level.var_c704d92107e638e1 settext("");
      }
    }
  }
}

function function_e2360e37f48b9a68(var_869ca1b0aca743, var_869da1b0aca976, var_869ea1b0acaba9) {
  level.var_855197dadb1d426f = [];
  var_a0b4eb1703be349a = [];

  if(isDefined(var_869ca1b0aca743)) {
    var_7edc4c3f95f4b61 = getStructArray(var_869ca1b0aca743, "script_noteworthy");

    foreach(scene in var_7edc4c3f95f4b61) {
      var_a0b4eb1703be349a = array_add(var_a0b4eb1703be349a, scene);
    }
  }

  if(isDefined(var_869da1b0aca976)) {
    var_7edc4c3f95f4b61 = getStructArray(var_869da1b0aca976, "script_noteworthy");

    foreach(scene in var_7edc4c3f95f4b61) {
      var_a0b4eb1703be349a = array_add(var_a0b4eb1703be349a, scene);
    }
  }

  if(isDefined(var_869ea1b0acaba9)) {
    var_7edc4c3f95f4b61 = getStructArray(var_869ea1b0acaba9, "script_noteworthy");

    foreach(scene in var_7edc4c3f95f4b61) {
      var_a0b4eb1703be349a = array_add(var_a0b4eb1703be349a, scene);
    }
  }

  level.var_855197dadb1d426f = var_a0b4eb1703be349a;
}

function function_db195be115ef65d1() {
  level endon("rewind_scenes_stop");
  level endon("death");
  level endon("endgame");
  level endon("cctv_end");
  level endon("stop_cctv_rewind_input");
  level.player notifyonplayercommand("cctv_scene_rewind_press", "+moveleft");
  level.player notifyonplayercommand("cctv_scene_rewind_release", "-moveleft");
  level.player notifyonplayercommand("cctv_scene_fastforward_press", "+moveright");
  level.player notifyonplayercommand("cctv_scene_fastforward_release", "-moveright");
  level.player notifyonplayercommand("cctv_scene_rewind_press", "+actionslot 3");
  level.player notifyonplayercommand("cctv_scene_rewind_release", "-actionslot 3");
  level.player notifyonplayercommand("cctv_scene_fastforward_press", "+actionslot 4");
  level.player notifyonplayercommand("cctv_scene_fastforward_release", "-actionslot 4");
  level.player notifyonplayercommand("cctv_scene_pause_play_press", "+gostand");
  level thread namespace_85a51fd192b9a590::function_7af3cb8cecca9321();
  function_a87838f8e012ed0d();
  childthread function_c649ef476238c0b9();
  childthread function_222e47a828e121ea();
  childthread function_79ede6bfa910889();
  childthread function_77940ee405fe9a1a();
}

function function_a87838f8e012ed0d() {
  if(level.var_13aaa384c5801cc4) {
    thread function_277d006e5e610c11();
  } else if(level.var_aff681d21d7b60b3 != 1) {
    level.var_aff681d21d7b60b3 = 0;
    level.var_e11a50d90bd1330c = 0;
    thread function_45d971942809e316();

    if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
      function_c728c5a4f8d6bc5c(level.var_aff681d21d7b60b3, undefined, 1);
    }

    setomnvar("ui_cctv_camera_state", 3);
  }

  flag_clear("CCTV_rewind_active");
}

function function_c649ef476238c0b9() {
  while(true) {
    level.player waittill("cctv_scene_fastforward_press");
    flag_set("CCTV_rewind_active");
    flag_set("CCTV_fastforward_pressed");
    setomnvar("ui_cctv_camera_state", 2);
    function_5001b8136e9137c0();
  }
}

function function_222e47a828e121ea() {
  while(true) {
    level.player waittill("cctv_scene_fastforward_release");
    waittillframeend();
    flag_clear("CCTV_fastforward_pressed");

    if(!flag("CCTV_rewind_pressed") || flag("CCTV_fastforward_footage")) {
      function_a87838f8e012ed0d();
    }
  }
}

function function_79ede6bfa910889() {
  while(true) {
    level.player waittill("cctv_scene_rewind_press");
    flag_set("CCTV_rewind_active");
    flag_set("CCTV_rewind_pressed");
    setomnvar("ui_cctv_camera_state", 1);
    function_7ac33b138da0870c();
  }
}

function function_77940ee405fe9a1a() {
  while(true) {
    level.player waittill("cctv_scene_rewind_release");
    waittillframeend();
    flag_clear("CCTV_rewind_pressed");

    if(!flag("CCTV_fastforward_pressed") || flag("CCTV_rewind_footage")) {
      function_a87838f8e012ed0d();
    }
  }
}

function function_277d006e5e610c11() {
  level.var_aff681d21d7b60b3 = 1;
  thread function_45d971942809e316();

  if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
    function_c728c5a4f8d6bc5c(level.var_aff681d21d7b60b3, undefined, 1);
  }

  foreach(scene in level.var_855197dadb1d426f) {
    scene thread function_7b2805d01b85c82c(0.00075);
  }
}

function function_5001b8136e9137c0() {
  flag_set("CCTV_fastforward_footage");
  flag_clear("CCTV_rewind_footage");
  level.var_aff681d21d7b60b3 = 2;

  if(!flag("flg_player_has_rewinded")) {
    flag_set("flg_player_has_rewinded");
  }

  if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
    function_c728c5a4f8d6bc5c(level.var_aff681d21d7b60b3, undefined, 1);
  }

  thread function_45d971942809e316();

  foreach(scene in level.var_855197dadb1d426f) {
    scene thread function_7b2805d01b85c82c();
  }
}

function function_7b2805d01b85c82c(speed_mod) {
  if(!isDefined(speed_mod)) {
    speed_mod = 0.002;
  }

  level endon("rewind_scenes_stop");
  level endon("cctv_stop_fastforward");
  level endon("cctv_scene_pause_play_press_kbm");
  level endon("cctv_scene_pause_play_pad");
  level endon("stop_cctv_rewind_input");

  if(!level.var_13aaa384c5801cc4) {
    level endon("cam_switch");
  }

  while(level.var_aff681d21d7b60b3 > 0) {
    thread function_7bfa5ddd55d0c21(speed_mod);
    wait 0.1;

    if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
      function_c728c5a4f8d6bc5c(level.var_7d7f0b9f883c729c, 4);
    }

    if(level.var_aff681d21d7b60b3 == 0 || level.var_aff681d21d7b60b3 == -1) {
      break;
    }
  }
}

function function_7bfa5ddd55d0c21(speed_mod) {
  if(!isDefined(speed_mod)) {
    speed_mod = 0.002;
  }

  level endon("rewind_scenes_stop");
  level endon("cctv_stop_fastforward");
  level endon("cctv_scene_pause_play_press_kbm");
  level endon("cctv_scene_pause_play_pad");
  level endon("stop_cctv_rewind_input");

  if(!level.var_13aaa384c5801cc4) {
    level endon("cam_switch");
  }

  if(level.var_a067a16459d9d684 > 1) {
    level.var_a067a16459d9d684 = 1;
  }

  increment_amount = speed_mod * level.var_4d997627bb0a0cd6;
  level.var_7d7f0b9f883c729c = clamp(level.var_7d7f0b9f883c729c + increment_amount, 0, level.var_a067a16459d9d684);
  sceneroot = self;
  level.var_e11a50d90bd1330c = 0;

  if(level.var_7d7f0b9f883c729c == level.var_a067a16459d9d684) {
    return;
  }

  foreach(scene in level.var_855197dadb1d426f) {
    scene scene::set_anim_rate(level.var_e11a50d90bd1330c);
  }

  sceneroot scene::stop();
  sceneroot thread function_8a84e3af8d37b230();
}

function function_7ac33b138da0870c() {
  flag_set("CCTV_rewind_footage");
  flag_clear("CCTV_fastforward_footage");
  level.var_aff681d21d7b60b3 = -2;

  if(!flag("flg_player_has_rewinded")) {
    flag_set("flg_player_has_rewinded");
  }

  if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
    function_c728c5a4f8d6bc5c(level.var_aff681d21d7b60b3);
  }

  thread function_45d971942809e316();

  foreach(scene in level.var_855197dadb1d426f) {
    scene thread function_8dc45655d50f94fc();
  }
}

function function_8dc45655d50f94fc() {
  level endon("rewind_scenes_stop");
  level endon("cctv_stop_rewind");
  level endon("cctv_scene_pause_play_press_kbm");
  level endon("cctv_scene_pause_play_pad");
  level endon("stop_cctv_rewind_input");

  if(!level.var_13aaa384c5801cc4) {
    level endon("cam_switch");
  }

  while(level.var_aff681d21d7b60b3 < 0) {
    thread function_277164bfcb10a1d5();
    wait 0.1;

    if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
      function_c728c5a4f8d6bc5c(level.var_7d7f0b9f883c729c, 4);
    }

    if(level.var_aff681d21d7b60b3 == 0) {
      break;
    }
  }
}

function function_277164bfcb10a1d5(speed_mod) {
  if(!isDefined(speed_mod)) {
    speed_mod = 0.002;
  }

  level endon("rewind_scenes_stop");
  level endon("cctv_stop_fastforward");
  level endon("cctv_scene_pause_play_press_kbm");
  level endon("cctv_scene_pause_play_pad");
  level endon("stop_cctv_rewind_input");

  if(!level.var_13aaa384c5801cc4) {
    level endon("cam_switch");
  }

  if(level.var_feaef936e2681c46 < 0) {
    level.var_feaef936e2681c46 = 0;
  }

  decrement_amount = speed_mod * level.var_4d997627bb0a0cd6;
  level.var_7d7f0b9f883c729c = clamp(level.var_7d7f0b9f883c729c - decrement_amount, level.var_feaef936e2681c46, 1);

  if(level.var_7d7f0b9f883c729c == 0) {
    level notify("cctv_rewind_back_at_start");
  }

  if(level.var_7d7f0b9f883c729c == level.var_feaef936e2681c46) {
    return;
  }

  sceneroot = self;
  level.var_e11a50d90bd1330c = 0;

  foreach(scene in level.var_855197dadb1d426f) {
    scene scene::set_anim_rate(level.var_e11a50d90bd1330c);
  }

  sceneroot scene::stop();
  sceneroot thread function_8a84e3af8d37b230();
}

function function_8ac084fb932bbc23() {
  if(level.var_aff681d21d7b60b3 == 1) {
    level.var_aff681d21d7b60b3 = 0;
    thread function_45d971942809e316();

    if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
      function_c728c5a4f8d6bc5c(level.var_aff681d21d7b60b3, undefined, 1);
    }

    return;
  }

  level.var_aff681d21d7b60b3 = 1;

  if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
    function_c728c5a4f8d6bc5c(level.var_aff681d21d7b60b3, undefined, 1);
  }

  thread function_45d971942809e316();

  foreach(scene in level.var_855197dadb1d426f) {
    scene thread function_7b2805d01b85c82c();
  }
}

function function_3bb6e9ad233dea6b(speed_mod) {
  if(!isDefined(speed_mod)) {
    speed_mod = 0.00082;
  }

  level endon("rewind_scenes_stop");
  level endon("rewind_scene_reverse");
  level endon("rewind_scene_increase");

  if(!level.var_13aaa384c5801cc4) {
    level endon("cam_switch");
  }

  if(level.var_a067a16459d9d684 > 1) {
    level.var_a067a16459d9d684 = 1;
  }

  while(true) {
    increment_amount = speed_mod * level.var_4d997627bb0a0cd6;
    level.var_7d7f0b9f883c729c = clamp(level.var_7d7f0b9f883c729c + increment_amount, 0, level.var_a067a16459d9d684);

    if(getdvarint(@ "hash_5acddbe8e0e3cd3b", 0)) {
      function_c728c5a4f8d6bc5c(level.var_7d7f0b9f883c729c, 4);
    }

    if(level.var_7d7f0b9f883c729c == level.var_a067a16459d9d684) {
      return;
    }

    wait 0.1;
  }
}

function function_45d971942809e316() {
  if(level.var_aff681d21d7b60b3 == -2) {
    level.var_4d997627bb0a0cd6 = 1.1;
    level notify("rewind_scene_reverse");
    return;
  }

  if(level.var_aff681d21d7b60b3 == 0) {
    level.var_4d997627bb0a0cd6 = 1;
    level notify("rewind_scene_paused");
    return;
  }

  if(level.var_aff681d21d7b60b3 == 1) {
    level.var_4d997627bb0a0cd6 = 1;
    level notify("rewind_scene_play");
    return;
  }

  if(level.var_aff681d21d7b60b3 == 2) {
    level.var_4d997627bb0a0cd6 = 1.1;
    level notify("rewind_scene_increase");
  }
}

function function_d0320be57b9d11ed() {
  if(!isDefined(level.scene_current)) {
    level.scene_current = 0;
  }

  sceneroot = level.var_a0b4eb1703be349a[level.scene_current];
  return sceneroot;
}

function function_a94018be719172ec(force) {
  if(!istrue(force) && istrue(level.exclude_actors)) {
    return undefined;
  }

  return level.participants;
}

function function_8a84e3af8d37b230() {
  sceneroot = function_d0320be57b9d11ed();
  thread function_922bb174238aac59(sceneroot);
}

function function_922bb174238aac59(sceneroot) {
  foreach(shot in scene::function_8a37fe423de2b9db()) {
    thread scene::play(function_a94018be719172ec(), shot, undefined, level.var_7d7f0b9f883c729c);
  }

  thread function_67c21d048f7e7122();
}

function function_67c21d048f7e7122() {
  level notify("existing_entities_return");
  level endon("existing_entities_return");
  sceneroot = self;
  sceneroot scene::function_a07af33558d3050f(sceneroot, "return_entities");

  if(level.var_db84ce6e46a67e02 != (0, 0, 0)) {
    ents = sceneroot scene::get_entities();

    foreach(ent in ents) {
      if(isactor(ent)) {
        ent setgoalpos(level.var_db84ce6e46a67e02);
        ent.goalradius = 16;
      }
    }

    return;
  }

  sceneroot waittill("return_entities");
  entities = function_a94018be719172ec(1);

  if(isarray(entities)) {
    foreach(ent in entities) {
      if(isactor(ent) && isDefined(ent.homeorigin)) {
        ent setgoalpos(ent.homeorigin);
        ent.goalradius = 16;
      }
    }
  }
}

function function_6de5a02673de3113() {
  level endon("rewind_scenes_stop");
  level endon("death");
  level endon("endgame");
  level endon("cctv_end");
  level endon("stop_cctv_rewind_input");

  while(true) {
    var_3fd1ee4ee5b86f02 = (level.var_7d7f0b9f883c729c - level.var_feaef936e2681c46) / (level.var_a067a16459d9d684 - level.var_feaef936e2681c46);
    setomnvar("ui_cctv_scrub_pcnt", var_3fd1ee4ee5b86f02);
    waitframe();
  }
}

function function_c5dcf2ac854f0273() {
  current = "<dev string:xa5>";

  if(istrue(getdvarint(@ "scr_debug_scene", 0))) {
    setDvar(@ "scr_debug_scene", 0);
  } else {
    setDvar(@ "scr_debug_scene", 1);
    current = "<dev string:xab>";
  }

  setDvar(@ "hash_34dab4f8f3a04f4a", ter_op(getdvarint(@ "scr_debug_scene", 0), "<dev string:xb0>", "<dev string:xb3>"));
  var_7b5764f312d3ccd7 = 200;
  events = getdvarint(@ "hash_143b0dff4afbd1d3", 0);

  if(getdvarint(@ "scr_debug_scene", 0) && events == 0) {
    setDvar(@ "hash_143b0dff4afbd1d3", var_7b5764f312d3ccd7);
  } else if(getdvarint(@ "scr_debug_scene", 0) == 0 && events == var_7b5764f312d3ccd7) {
    setDvar(@ "hash_143b0dff4afbd1d3", 0);
  }

  if(isDefined(level.menu_sys["<dev string:xb7>"].optionsvalue)) {
    menu_get_selected_optionsvalue().text = current;
  }
}

function function_c728c5a4f8d6bc5c(value, var_2b5250e961d644ab, places) {
  if(!isDefined(var_2b5250e961d644ab)) {
    var_2b5250e961d644ab = 3;
  }

  places = default_to(places, 3);
  hud = menu_get_selected_optionsvalue(var_2b5250e961d644ab);
  rounded = round_float(value, places);
  hud.text = "" + rounded;

  if(rounded == int(rounded)) {
    hud.text += ".";

    for(i = 0; i < places; i++) {
      hud.text += "0";
    }
  }
}

function function_b8d48d05eada6be2() {
  if(flag("flg_player_has_rewinded")) {
    return true;
  }

  return false;
}

function function_7efc0121f7c2b54d() {}

function function_3fe548dad8d17375() {
  if(!isDefined(self.script_noteworthy)) {
    return false;
  }

  if(self.script_noteworthy == "") {
    return false;
  }

  visuals = strtok(self.script_noteworthy, "+");

  if(visuals.size != 2) {
    iprintln("<dev string:xc4>");

    return false;
  }

  str_head = visuals[0];
  str_body = visuals[1];
  self setModel(str_body);

  if(is_fakeactor()) {
    self detachall();
    self setModel(str_body);
    self attach(str_head, "", 1);
  } else {
    if(isDefined(self.headmodel)) {
      self detach(self.headmodel);
    }

    self attach(str_head, "", 1);
  }

  if(issubstr(str_body, "female")) {
    self.vo_type = "female";
  } else {
    self.vo_type = "male";
  }

  return true;
}

function function_e90d7dbd8baea486() {}

function function_44aae8c896d36e41() {
  level endon("flg_street_tunnel_entered");
  level.var_1da14103ff6766fd = [];
  level thread function_54757ed7a40cd744();

  while(true) {
    flag_wait("cctv_enable_camera");
    function_bd24ca862b33a24d(1);
    function_5b0b3054b1c77169(1);
    flag_wait("cctv_end");
    function_bd24ca862b33a24d(0);
    function_5b0b3054b1c77169(0);
    waitframe();
  }
}

function function_bd24ca862b33a24d(b_visible) {
  if(isDefined(level.ai_soap)) {
    var_f8e81b2e1531fb1c = spawn_tag_origin((-832, 371, 75), (0, 0, 0));
    var_f8e81b2e1531fb1c function_492da6070b5aafa6("icon_waypoint_ally_marker", b_visible);
  }

  if(isDefined(level.var_d18d63c6d75cd1e)) {
    level.var_d18d63c6d75cd1e function_492da6070b5aafa6("icon_waypoint_ally_marker", b_visible);
  }

  if(isDefined(level.ai_price)) {
    level.ai_price function_492da6070b5aafa6("icon_waypoint_ally_marker", b_visible);
  }
}

function function_5b0b3054b1c77169(b_visible) {
  if(isDefined(level.ai_hacker) && !flag("flg_streets_alley_done")) {
    level.ai_hacker function_492da6070b5aafa6("icon_waypoint_enemy_marker", b_visible);
  }

  if(isDefined(level.var_9b8b7c9a2fe046dc) && flag("flg_streets_pub_konni_targets_visible") && !flag("flg_streets_alley_done")) {
    level.var_9b8b7c9a2fe046dc function_492da6070b5aafa6("icon_waypoint_enemy_marker", b_visible);
  }

  if(isDefined(level.var_d122bf82b81a4b63) && flag("flg_streets_pub_konni_targets_visible")) {
    level.var_d122bf82b81a4b63 function_492da6070b5aafa6("icon_waypoint_enemy_marker", b_visible);
  }
}

function function_8e632e3b7ab7ac44(b_visible) {
  if(isDefined(level.var_85f6ba0592fc4e0)) {
    level.var_85f6ba0592fc4e0 function_492da6070b5aafa6("icon_waypoint_ally_marker", b_visible);
  }
}

function function_54757ed7a40cd744() {
  level endon("flg_street_tunnel_entered");
  flag_wait("flg_park_cctv_1_start");
  flag_wait("cctv_enable_camera");

  if(isDefined(level.ai_hacker)) {
    level.ai_hacker thread function_f63200bd962f7f6e("Hacker", "flg_park_cctv_1_start");
  }

  if(isDefined(level.var_9b8b7c9a2fe046dc)) {
    level.var_9b8b7c9a2fe046dc thread function_f63200bd962f7f6e("Bodyguard", "flg_streets_pub_konni_targets_visible");
  }

  while(!isDefined(level.var_d122bf82b81a4b63)) {
    waitframe();
  }

  level.var_d122bf82b81a4b63 thread function_f63200bd962f7f6e("Target", "flg_streets_pub_konni_targets_visible");
}

function function_f63200bd962f7f6e(str_name, var_487601e678935b5a) {
  level endon("flg_street_tunnel_entered");
  self endon("death");
  flag_wait(var_487601e678935b5a);
  thread reveal_nameplate(str_name, "axis");
  function_5b0b3054b1c77169(1);
}

function function_492da6070b5aafa6(var_67c7ff000ed37b4, b_visible, var_b69423020f5f460f, offset) {
  if(b_visible) {
    if(!isDefined(self.marker)) {
      self.marker = newhudelem();
    }

    self.marker setshader(var_67c7ff000ed37b4, 640, 640);
    self.marker setwaypoint(1, utility::default_to(var_b69423020f5f460f, 0), 0, 0);
    self.marker linkwaypointtotargetwithoffset(self, utility::default_to(offset, (0, 0, 72)));
    level.var_1da14103ff6766fd = array_add(level.var_1da14103ff6766fd, self.marker);
    return;
  }

  if(isDefined(self.marker)) {
    level.var_1da14103ff6766fd = array_remove(level.var_1da14103ff6766fd, self.marker);
    self.marker destroy();
  }
}

function function_35dd19d7376bcf4() {
  if(!isDefined(level.var_1da14103ff6766fd)) {
    return 0;
  }

  foreach(marker in level.var_1da14103ff6766fd) {
    level.var_1da14103ff6766fd = array_remove(level.var_1da14103ff6766fd, marker);

    if(isDefined(marker)) {
      marker destroy();
    }
  }
}

function function_6278e08f76554bff() {}

function function_ed0894b662fdb345() {
  level.var_21a92f490ae6f824 = [];
  level.var_d4ce3a0b9a2817a5 = [];
  level.var_897cdc3bfd0f6e51 = [];
  level.var_b7a7de2b96c58849 = [];
  level.var_ba9d217d45ecfac = [];
  level.var_1dfec668afe59727 = 0;
  level.var_21a92f490ae6f824 = array_add(level.var_21a92f490ae6f824, "Cdt.");
  level.var_21a92f490ae6f824 = array_add(level.var_21a92f490ae6f824, "2Lt.");
  level.var_21a92f490ae6f824 = array_add(level.var_21a92f490ae6f824, "Lt.");
  level.var_21a92f490ae6f824 = array_add(level.var_21a92f490ae6f824, "Sgt.");
  level.var_21a92f490ae6f824 = array_add(level.var_21a92f490ae6f824, "Capt.");
  level.var_21a92f490ae6f824 = array_add(level.var_21a92f490ae6f824, "Maj.");
  level.var_21a92f490ae6f824 = array_add(level.var_21a92f490ae6f824, "Lt Col.");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Gopaul");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Hancock");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Kar");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Marotta");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "McCorkle");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Ngai");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Norman");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Pasetto");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Rench");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Salgado");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Tieger");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Wang");
  level.var_d4ce3a0b9a2817a5 = array_add(level.var_d4ce3a0b9a2817a5, "Wou");
  level.var_897cdc3bfd0f6e51 = array_add(level.var_897cdc3bfd0f6e51, "Hotel");
  level.var_b7a7de2b96c58849 = array_add(level.var_b7a7de2b96c58849, "0");
  level.var_b7a7de2b96c58849 = array_add(level.var_b7a7de2b96c58849, "1");
  level.var_b7a7de2b96c58849 = array_add(level.var_b7a7de2b96c58849, "2");
  level.var_b7a7de2b96c58849 = array_add(level.var_b7a7de2b96c58849, "3");
  level.var_b7a7de2b96c58849 = array_add(level.var_b7a7de2b96c58849, "4");
  level.var_ba9d217d45ecfac = array_add(level.var_ba9d217d45ecfac, "1");
  level.var_ba9d217d45ecfac = array_add(level.var_ba9d217d45ecfac, "2");
  level.var_ba9d217d45ecfac = array_add(level.var_ba9d217d45ecfac, "3");
  level.var_ba9d217d45ecfac = array_add(level.var_ba9d217d45ecfac, "4");
  level.var_ba9d217d45ecfac = array_add(level.var_ba9d217d45ecfac, "5");
  level.var_ba9d217d45ecfac = array_add(level.var_ba9d217d45ecfac, "6");
  level.var_3b2ef8625da8b29c = 0;
  level.var_f62b2320c0304a8d = 1;
}

function function_a8d01dcc629d8524(var_9c4785594848ecde, b_randomize) {
  if(!isDefined(b_randomize)) {
    b_randomize = 1;
  }

  level.player endon("death");
  level endon("game_ended");

  while(!isDefined(level.var_d4ce3a0b9a2817a5)) {
    wait 0.1;
  }

  if(level.var_1dfec668afe59727 >= level.var_d4ce3a0b9a2817a5.size) {
    level.var_1dfec668afe59727 = 0;
  }

  str_name = random(level.var_21a92f490ae6f824) + " " + level.var_d4ce3a0b9a2817a5[level.var_1dfec668afe59727];
  level.var_1dfec668afe59727++;
  set_name(str_name);

  while(true) {
    var_4c70ceba687c7914 = 0;

    if(b_randomize) {
      if(isDefined(var_9c4785594848ecde)) {
        var_ff53fce72ff606fd = var_9c4785594848ecde + " " + random(level.var_b7a7de2b96c58849) + "-" + random(level.var_ba9d217d45ecfac);
      } else {
        var_ff53fce72ff606fd = level.var_897cdc3bfd0f6e51[0] + " " + random(level.var_b7a7de2b96c58849) + "-" + random(level.var_ba9d217d45ecfac);
      }
    } else {
      if(level.var_f62b2320c0304a8d > 6) {
        level.var_f62b2320c0304a8d = 1;
        level.var_3b2ef8625da8b29c++;
      }

      if(level.var_3b2ef8625da8b29c > 4) {
        level.var_3b2ef8625da8b29c = 0;
      }

      var_ff53fce72ff606fd = level.var_897cdc3bfd0f6e51[0] + " " + string(level.var_3b2ef8625da8b29c) + "-" + string(level.var_f62b2320c0304a8d);
      level.var_f62b2320c0304a8d++;
    }

    allies = getaiarray("allies");

    if(allies.size > 0) {
      foreach(ally in allies) {
        if(isDefined(ally) && isalive(ally) && isDefined(ally.callsign)) {
          if(var_ff53fce72ff606fd == ally.callsign) {
            var_4c70ceba687c7914 = 1;
          }
        }
      }
    }

    if(var_4c70ceba687c7914 == 0 && isDefined(self) && isalive(self)) {
      set_callsign(var_ff53fce72ff606fd);
      break;
    }

    waitframe();
  }
}

function function_a36a86f1e344125d() {
  var_2028491b720b89d1 = getaiarray("allies");

  foreach(sfo in var_2028491b720b89d1) {
    if(!isDefined(sfo.script_noteworthy)) {
      sfo function_16a594417ddabeb1();
      sfo function_a8d01dcc629d8524(undefined, 0);
    }
  }
}

function function_16a594417ddabeb1(b_enable, var_39cf901e476c66c6) {
  if(!isDefined(b_enable)) {
    b_enable = 1;
  }

  if(b_enable) {
    gun_remove();
    i_rand = default_to(var_39cf901e476c66c6, randomint(3));
    gun = make_weapon("iw9_pi_golf17_sp");

    switch (i_rand) {
      case 0:
        gun = make_weapon("iw9_ar_mike4_sp", ["ammo_556n", "bar_ar_short_p01_mike4", "iw9_rec_mike4", "selectsemi_mike4", "laserir_box", "mag_ar_p01", "pgrip_p01", "fourx02", "stock_ar_p01_mike4"]);
        break;
      case 1:
      case 2:
        gun = make_weapon("iw9_ar_mcharlie_sp", ["fourx02", "silencer01_ar", "mag_ar_p08"]);
        break;
      case 3:
        gun = make_weapon("iw9_sh_mbravo_sp", ["bartube_sh_heavy_p13", "stock_sh_heavy_p13", "breacher_sh_01", "grip_angled01"]);
        break;
      case 4:
        gun = make_weapon("iw9_lm_foxtrot_sp");
        break;
      case 5:
        gun = make_weapon("iw9_pi_golf17_sp");
        break;
    }

    scripts\anim\shared::forceuseweapon(gun, "primary");
  }
}

function function_94b3d4076f1146ab() {
  level endon("flg_hideout_cqc_stairwell_enemies_spawn");
  self waittill("damage", amount, attacker, direction, point, means_of_death, model, tag, part_name, damage_flags, weapon_name);

  if(isPlayer(attacker) && weapon_name.basename == "frag") {
    scripts\sp\player_death::set_custom_death_quote(12);
    scripts\sp\utility::missionfailedwrapper();
  }
}

function function_c21fd6fa5bdab1b6() {}

function function_be299b038f549e49() {
  e_train_1 = getEnt("e_train_1", "targetname");
  e_train_2 = getEnt("e_train_2", "targetname");
  e_train_3 = getEnt("e_train_3", "targetname");
  var_fe4346d365ce6386 = [];

  if(scripts\sp\starts::is_after_start("streets_tunnel_shootout")) {
    var_fe4346d365ce6386 = [e_train_1, e_train_2, e_train_3];
  }

  cam = getEnt("e_cctv_section_3b", "targetname");
  var_c66ce455621a60ae = [cam];

  for(i = 1; i < 8; i++) {
    cam = getEnt("e_cctv_section_" + i, "targetname");
    var_c66ce455621a60ae = array_add(var_c66ce455621a60ae, cam);
  }

  a_ents = [var_fe4346d365ce6386, var_c66ce455621a60ae];

  foreach(ent in a_ents) {
    array_delete(ent);
  }
}

function function_242f4899008ebd3b() {
  var_567a1a7b8385d0c1 = getaiarray("allies");

  foreach(good_guy in var_567a1a7b8385d0c1) {
    good_guy visiblenotsolid();
  }

  wait 3;

  foreach(good_guy in var_567a1a7b8385d0c1) {
    if(isDefined(good_guy)) {
      good_guy visiblesolid();
    }
  }
}

function function_c01ae6bb604460df(v_pos, i_radius) {
  if(!isDefined(v_pos)) {
    v_pos = level.player.origin;
  }

  if(!isDefined(i_radius)) {
    i_radius = 9000;
  }

  a_weapons = getweaponarrayinradius(v_pos, i_radius, 1);
  array_delete(a_weapons);
}

function function_eb3db466ac7ddf53() {
  arr = self;

  if(!isarray(arr)) {
    arr = [arr];
  }

  if(arr.size > 0) {
    foreach(ai in arr) {
      if(isDefined(ai) && isalive(ai)) {
        ai kill();
      }
    }
  }
}

function function_c60ef749d2725cc() {}

function function_eec061594d4d72c5(var_3d0f4612572702f7) {
  level.player endon("death");
  level endon("game_ended");
  var_e4c701fb59bd0e91 = var_3d0f4612572702f7["player_branchedDialogueWheelInitial"].var_e4c701fb59bd0e91;
  var_8c791b0ce2679fba = function_945718bb107da39e(var_e4c701fb59bd0e91, var_3d0f4612572702f7["player_branchedDialogueWheelInitial"].var_f372d40ddafca1a9, var_3d0f4612572702f7["player_branchedDialogueWheelInitial"].var_23b2f01a27e71c0c);
  var_3d0f4612572702f7["player_branchedDialogueWheelInitial"].var_8c791b0ce2679fba = var_8c791b0ce2679fba;

  for(var_4ad15863e2d3ce32 = var_e4c701fb59bd0e91[var_8c791b0ce2679fba - 1]; true; var_4ad15863e2d3ce32 = var_ab0ef6b9687d4bb1) {
    if(!isDefined(var_4ad15863e2d3ce32) || !isDefined(var_3d0f4612572702f7[var_4ad15863e2d3ce32])) {
      return false;
    }

    var_903a9a3ede4b6c4f = var_3d0f4612572702f7[var_4ad15863e2d3ce32];
    var_fa1e3c8bdc8d08d1 = var_903a9a3ede4b6c4f.var_fa1e3c8bdc8d08d1;
    var_c6043eb0db669c85 = var_903a9a3ede4b6c4f.var_c6043eb0db669c85;
    var_493aa92a49a14eea = var_903a9a3ede4b6c4f.var_493aa92a49a14eea;

    if(isDefined(var_903a9a3ede4b6c4f.var_26279978c779ac8c)) {
      var_26279978c779ac8c = var_903a9a3ede4b6c4f.var_26279978c779ac8c;
    }

    if(isDefined(var_fa1e3c8bdc8d08d1) && isDefined(var_c6043eb0db669c85) && isDefined(var_493aa92a49a14eea)) {
      for(index = 0; index < var_fa1e3c8bdc8d08d1.size; index++) {
        delay = var_493aa92a49a14eea[index];

        if(isDefined(delay)) {
          wait delay;
        }

        var_c6043eb0db669c85[index] say_team(var_fa1e3c8bdc8d08d1[index]);
        var_4ad15863e2d3ce32 = var_fa1e3c8bdc8d08d1[index];
      }
    }

    if(isDefined(var_26279978c779ac8c)) {
      level flag_set(var_26279978c779ac8c);
    }

    var_903a9a3ede4b6c4f = var_3d0f4612572702f7[var_4ad15863e2d3ce32];

    if(!isDefined(var_903a9a3ede4b6c4f)) {
      return false;
    }

    var_e4c701fb59bd0e91 = var_903a9a3ede4b6c4f.var_e4c701fb59bd0e91;

    if(isDefined(var_e4c701fb59bd0e91)) {
      if(isDefined(var_903a9a3ede4b6c4f.var_b99dc92a08336704)) {
        wait var_903a9a3ede4b6c4f.var_b99dc92a08336704;
      }

      var_8c791b0ce2679fba = function_945718bb107da39e(var_e4c701fb59bd0e91, var_903a9a3ede4b6c4f.var_f372d40ddafca1a9, var_903a9a3ede4b6c4f.var_23b2f01a27e71c0c);
      var_903a9a3ede4b6c4f.var_8c791b0ce2679fba = var_8c791b0ce2679fba;
      var_4ad15863e2d3ce32 = var_e4c701fb59bd0e91[var_8c791b0ce2679fba - 1];

      if(var_8c791b0ce2679fba == 0) {
        return true;
      }

      continue;
    }

    var_ab0ef6b9687d4bb1 = var_fa1e3c8bdc8d08d1[var_fa1e3c8bdc8d08d1.size - 1];

    if(var_4ad15863e2d3ce32 == var_ab0ef6b9687d4bb1) {
      return false;
    }
  }

  return false;
}

function function_945718bb107da39e(playerdialoguelines, var_71522087bc2056d3, timeout, var_120e91c43eab8002, var_7bdecd97f78e0194) {
  if(!isDefined(var_120e91c43eab8002)) {
    var_120e91c43eab8002 = 1;
  }

  if(!array_contains(playerdialoguelines, "silence") && playerdialoguelines.size < 4 && var_120e91c43eab8002) {
    for(index = var_71522087bc2056d3.size; index < 4; index++) {
      var_71522087bc2056d3[index] = "none";
    }

    var_71522087bc2056d3[3] = &"SP_JUP_SURGE/DIALOG_SILENCE";
  }

  if(!isDefined(timeout)) {
    timeout = 0;
  }

  var_8c791b0ce2679fba = scripts\sp\dialogue_wheel::function_d92b8b076e34f82b(var_71522087bc2056d3, int(timeout), [0, 1, 2, 3]);
  dialogueline = playerdialoguelines[var_8c791b0ce2679fba - 1];

  if(isDefined(var_7bdecd97f78e0194)) {
    level notify(var_7bdecd97f78e0194);
  }

  if(isDefined(dialogueline) && !issubstr(dialogueline, "player_dialogueWheelMore")) {
    scripts\anim\dialogue::function_cb329cf8896edeaa(level.player.team);
    level.player scripts\anim\dialogue::say_team(dialogueline, 3);
  }

  return var_8c791b0ce2679fba;
}

function dialogue(string, delay, endonentities, endonmessages, overradio) {
  self endon("death");

  if(isDefined(endonentities) && isDefined(endonmessages)) {
    if(!isarray(endonentities)) {
      endonentities = [endonentities];
    }

    if(!isarray(endonmessages)) {
      endonmessages = [endonmessages];
    }

    foreach(entity in endonentities) {
      foreach(message in endonmessages) {
        entity endon(message);
      }
    }
  }

  if(isDefined(delay) && delay) {
    wait delay;
  }

  thread function_ae5ec13771e284be(string, self);

  if(self == level.player) {
    smart_player_dialogue(string);
    return;
  }

  if(istrue(overradio)) {
    smart_radio_dialogue(string);
    return;
  }

  if(isDefined(self.animname)) {
    smart_dialogue(string);
    return;
  }

  smart_dialogue_generic(string);
}

function function_ae5ec13771e284be(string, entity) {
  if(!isDefined(level.dialogue)) {
    level.dialogue = spawnStruct();
  }

  if(!isDefined(level.dialogue.var_c9513b8c16911150)) {
    level.dialogue.var_c9513b8c16911150 = [];
  }

  level.dialogue.var_c9513b8c16911150 = array_add(level.dialogue.var_c9513b8c16911150, self);
  wait lookupsoundlength(string) * 0.001;
  level.dialogue.var_c9513b8c16911150 = array_remove(level.dialogue.var_c9513b8c16911150, self);
}

function function_d7d7c60ec4ee6439(playerdialoguelines, var_8c791b0ce2679fba) {
  if(!isDefined(playerdialoguelines) || !isDefined(var_8c791b0ce2679fba)) {
    return true;
  }

  return var_8c791b0ce2679fba == 0 || !isDefined(playerdialoguelines[var_8c791b0ce2679fba - 1]) || playerdialoguelines[var_8c791b0ce2679fba - 1] == "silent";
}

function function_c22bb668fa60fb85() {}

function function_49cc648e188e45e3(var_5c59fc44a8dd3434, a_lines) {
  var_61a2500bbaf63219 = [];

  foreach(l in a_lines) {
    hud = newhudelem();
    hud.alignx = "center";
    hud.aligny = "middle";
    hud.fontscale = 2;
    hud.x = 320;
    hud.y = 100 + i * 50;
    hud.alpha = 0;
    hud settext(l);
    hud fadeovertime(var_5c59fc44a8dd3434);
    hud.alpha = 1;
    wait var_5c59fc44a8dd3434;
    var_61a2500bbaf63219[var_61a2500bbaf63219.size] = hud;
  }

  wait var_5c59fc44a8dd3434;

  foreach(hud in var_61a2500bbaf63219) {
    hud fadeovertime(var_5c59fc44a8dd3434);
    hud.alpha = 0;
    hud delaycall(var_5c59fc44a8dd3434, &destroy);
  }
}

function function_c4bed616d3a3036c(team, var_3d670ec40fdf84a8) {
  level.player endon("death");
  level endon("nextmission");
  white = (1, 1, 1);
  yellow = (1, 1, 0);
  green = (0, 1, 0);
  red = (1, 0, 0);
  count_array = [];

  while(true) {
    if(isDefined(team)) {
      if(team != "all") {
        count_array[1] = getaiarray(team).size;
      } else {
        count_array[0] = getaiarray("all").size;
        count_array[1] = getaiarray("axis").size;
        count_array[2] = getaiarray("allies").size;
        count_array[3] = getaiarray("neutral").size;
      }
    } else {
      count_array[0] = getaiarray().size;
    }

    total_count = 0;

    foreach(count in count_array) {
      total_count += count;
    }

    display_color = white;
    xpos = 950;

    foreach(count in count_array) {
      display_string = " AI";

      if(isDefined(team)) {
        if(team == "all") {
          switch (i) {
            case 0:
              display_string = " Total";

              if(count_array[0] == 0) {
                display_color = white;
              } else if(count_array[0] > 0 && count_array[2] < 20) {
                display_color = green;
              } else if(count_array[0] >= 20 && count_array[2] < 40) {
                display_color = yellow;
              } else if(count_array[0] >= 40) {
                display_color = red;
              }

              ypos = 30;
              break;
            case 1:
              display_string = " Enemies";
              ypos = 55;
              break;
            case 2:
              display_string = " Allies";
              ypos = 85;
              break;
            case 3:
              display_string = " Civilians";
              ypos = 115;
              break;
          }
        } else {
          display_string = " " + team;
        }
      }

      printtoscreen2d(xpos, ypos, count + display_string, display_color, 1.5);

      ypos += 20;
    }

    waitframe();
  }
}

function function_4fd20cbaaaac679() {
  level.player endon("death");
  level endon("nextmission");
  white = (1, 1, 1);
  yellow = (1, 1, 0);
  green = (0, 1, 0);
  red = (1, 0, 0);
  count_array = [];

  while(true) {
    var_80b9d98876e438d4 = getaiarray("all");
    var_b3cee4260e22c757 = get_fakeactors("neutral");
    a_ai_all = [];
    a_ai_all = array_combine(a_ai_all, var_80b9d98876e438d4);
    a_ai_all = array_combine(a_ai_all, var_b3cee4260e22c757);
    count_array[0] = var_80b9d98876e438d4.size;
    count_array[1] = var_b3cee4260e22c757.size;
    count_array[2] = a_ai_all.size;
    xpos = 950;

    foreach(count in count_array) {
      display_string = " AI";

      switch (i) {
        case 0:
          display_string = " Actors";
          ypos = 30;

          if(count_array[0] == 0) {
            display_color = white;
          } else if(count_array[0] > 0 && count_array[0] < 20) {
            display_color = green;
          } else if(count_array[0] >= 20 && count_array[0] < 30) {
            display_color = yellow;
          } else if(count_array[0] >= 30) {
            display_color = red;
          }

          break;
        case 1:
          display_string = " Fake Actors";
          ypos = 55;

          if(count_array[1] == 0) {
            display_color = white;
          } else if(count_array[1] > 0 && count_array[1] < 50) {
            display_color = green;
          } else if(count_array[1] >= 50 && count_array[1] < 120) {
            display_color = yellow;
          } else if(count_array[1] >= 120) {
            display_color = red;
          }

          break;
        case 2:
          display_string = " Total";
          ypos = 80;

          if(count_array[2] == 0) {
            display_color = white;
          } else if(count_array[2] > 0 && count_array[2] < 100) {
            display_color = green;
          } else if(count_array[2] >= 100 && count_array[2] < 130) {
            display_color = yellow;
          } else if(count_array[2] >= 130) {
            display_color = red;
          }

          break;
      }

      printtoscreen2d(xpos, ypos, count + display_string, display_color, 2);

      ypos += 20;
    }

    waitframe();
  }
}

function function_e92e2de5964389c2(s_targetname, var_b8f6d6e2d0a21b47) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(s_targetname)) {
    s_struct = getStruct(s_targetname, "targetname");
  } else if(isDefined(self.target)) {
    s_struct = getStruct(self.target, "targetname");
  }

  if(!isDefined(self)) {
    iprintln("<dev string:x10a>");

    return 0;
  }

  if(!isDefined(self.animname)) {
    self.animname = "generic";
  }

  if(isDefined(s_struct)) {
    if(isDefined(s_struct.animation)) {
      if(var_b8f6d6e2d0a21b47 == 1) {
        if(istrue(self.script_fakeactor)) {
          scripts\sp\fakeactor::take_control();

          if(isDefined(s_struct.script_parameters)) {
            var_913f88a5f139e480 = strtok(s_struct.script_parameters, "+");

            if(var_913f88a5f139e480.size > 1) {
              if(var_913f88a5f139e480[0] == "misc_wm_smartphone_civilian_canal") {
                var_913f88a5f139e480[0] = "misc_wm_smartphone_civilian_surge_texting";
              }

              var_1281cef5f432a129 = scripts\common\anim::anim_link_tag_model(var_913f88a5f139e480[0], var_913f88a5f139e480[1]);

              if(var_913f88a5f139e480[0] == "parts_jup_surge_misc_cigarette_lit") {
                playFXOnTag(level._effect["vfx_cigarette_smoke_civ_1"], var_1281cef5f432a129, "tag_fx");
              }

              var_1281cef5f432a129 thread scripts\asm\cap::function_c2c313a844d139b9();
            }
          }

          s_struct thread anim_generic_loop(self, s_struct.animation, "stop_loop");
        } else {
          s_struct thread anim_loop_solo(self, s_struct.animation);
        }

        set_allowdeath(1);
        wait 0.01;
        return;
      }

      if(!istrue(self.script_fakeactor)) {
        s_struct thread anim_single_solo(self, s_struct.animation);
        set_allowdeath(1);
        wait 0.01;
        return;
      }

      iprintlnbold("<dev string:x14b>");
    }
  }
}

function player_anchor(interact_ref, flg_end) {
  if(!isDefined(flg_end)) {
    flg_end = undefined;
  }

  var_f5648c76ae351ca6 = spawn_tag_origin(level.player.origin, interact_ref.angles);
  level.player playerlinkTo(var_f5648c76ae351ca6, "tag_origin", 0, 90, 90, 90, 90, 0);

  if(isDefined(flg_end)) {
    flag_wait(flg_end);
  } else {
    level waittill("unanchor_player");
  }

  level.player playerunlinkblend(1);
  var_f5648c76ae351ca6 delete();
}

function function_ef45d05d1b414c9b(flg_cleanup) {
  self endon("death");
  self endon("entitydeleted");

  if(isDefined(flg_cleanup)) {
    flag_wait(flg_cleanup);

    if(isDefined(self.magic_bullet_shield)) {
      scripts\common\ai::stop_magic_bullet_shield();
    }

    self delete();
  }
}

function function_a930207ed379dcc9(str_name, flg_cleanup, var_2966c6bd72ce3f12, b_path) {
  self endon("death");
  self endon("entitydeleted");

  if(!isDefined(var_2966c6bd72ce3f12)) {
    var_2966c6bd72ce3f12 = 0;
  }

  if(!isDefined(b_path)) {
    b_path = 0;
  }

  self.script_friendname = str_name;
  self.name = self.script_friendname;
  self.team = "allies";
  self.animname = tolower(str_name);
  thread function_e92e2de5964389c2(undefined, 1);
  thread function_ef45d05d1b414c9b(flg_cleanup);
  self.ignoreall = 1;
  self.goalradius = 32;
  scripts\common\ai::gun_remove();

  if(var_2966c6bd72ce3f12 == 1) {
    if(str_name == "Price") {
      self setModel("body_hero_price_undercover");
      self detach(self.headmodel);
      self attach("head_hero_price_nohat_lod", "", 1);
      self.headmodel = "head_hero_price_nohat_lod";
      self.animname = "price";
      self.callsign = "Bravo 0-6";
    } else if(str_name == "Ghost") {
      self setModel("body_hero_ghost_amsterdam");
      self detach(self.headmodel);
      self attach("head_hero_ghost_amsterdam_cine", "", 1);
      self.headmodel = "head_hero_ghost_amsterdam_cine";
      self.animname = "ghost";
      self.callsign = "Bravo 0-7";
    } else if(str_name == "Gaz") {
      self setModel("body_c_jup_sp_hero_gaz_london");
      self detach(self.headmodel);
      self attach("head_sp_hero_kyle_amsterdam_lod", "", 1);
      self.headmodel = "head_sp_hero_kyle_amsterdam_lod";
      self.animname = "gaz";
      self.callsign = "Bravo 6-1";
    } else if(str_name == "Soap") {
      self setModel("body_c_jup_sp_hero_soap_london");
      self detach(self.headmodel);
      self attach("head_hero_soap_lod", "", 1);
      self.headmodel = "head_hero_soap_lod";
      self.animname = "soap";
      self.callsign = "Bravo 7-1";
    }
  }

  if(b_path == 1) {
    function_2198a1a54be3d161(self.target);
    self waittill("goal");
  }
}

function civ_handler(var_d5aa03e48b51875d, flg_cleanup) {
  self endon("death");
  self endon("entitydeleted");
  thread function_3fe548dad8d17375();
  thread function_ef45d05d1b414c9b(flg_cleanup);

  if(var_d5aa03e48b51875d == 1) {
    function_c1e075c4168a8bea(0, 0);

    if(isDefined(self.target)) {
      nd_node = getnode(self.target, "targetname");

      if(isnode(nd_node)) {
        if(isDefined(self.spawner) && isDefined(self.spawner.script_fakeactor)) {
          if(!self.spawner.script_fakeactor == 1) {
            self.animname = "generic";
            self.ignoreme = 1;
            self.ignoreall = 1;
            self.goalradius = 32;
            self function_b661b022700ba72f("script", 1);
            self setcivstate("relaxed");
            function_89007ae298fb4b15();
            self enableavoidance(0, 0);
            thread scripts\sp\spawner::go_to_node(nd_node);
            return;
          }

          self.var_f7e4ad5c054874e1 = 10;
          self.var_e0e17a8b499a050c = 0.05;
          self.run_anim_override = get_animation_from_alias("civilian_react", "relaxed_run_loop", "walk");
        }
      }
    }
  }
}

function function_d523e3dd08f132f1() {
  self endon("death");
  level.player endon("death");
  n_near_dist_sq = squared(128);

  while(true) {
    if(level.player islinked()) {
      wait 1;
      continue;
    }

    n_dist_sq = distance2dsquared(self.origin, level.player.origin);

    if(n_dist_sq < n_near_dist_sq && function_9697d37a69e0b084()) {
      nd_node = self.currentnode;
      waitframe();
      self notify("stop_going_to_node");
      waitframe();
      self setgoalpos(self.origin);
      function_7c7defbf73e8c799(1);

      while(true) {
        n_dist_sq = distance2dsquared(self.origin, level.player.origin);

        if(n_dist_sq > n_near_dist_sq || !function_9697d37a69e0b084()) {
          break;
        }

        wait 1;
      }

      function_7c7defbf73e8c799(0);
      waitframe();
      thread scripts\sp\spawner::go_to_node(nd_node);
    }

    wait 1;
  }
}

function function_7c7defbf73e8c799(b_lookat) {
  if(!isai(self)) {
    return;
  }

  if(b_lookat) {
    self function_f51ff412609193b9(1, "script");
    self function_5621e511b99964a7(level.player);
    return;
  }

  self function_f51ff412609193b9(1, "script");
  self function_504a5e2df31069a4();
}

function function_9697d37a69e0b084() {
  fwd = anglesToForward(self.angles);
  vector = vectorNormalize(level.player.origin - self.origin);
  dot = vectordot(fwd, vector);

  if(dot > 0.5) {
    return 1;
  }

  return 0;
}

function function_2198a1a54be3d161(var_d52cbbde235c7f62) {
  self endon("death");
  self endon("entitydeleted");
  a_nd_path = [];
  nd_path_node = getnode(var_d52cbbde235c7f62, "targetname");

  if(!isDefined(nd_path_node)) {
    return undefined;
  }

  a_nd_path = array_add(a_nd_path, nd_path_node);

  while(true) {
    if(isDefined(nd_path_node.target)) {
      nd_path_node = getnode(nd_path_node.target, "targetname");

      if(isnode(nd_path_node)) {
        a_nd_path = array_add(a_nd_path, nd_path_node);
        var_4b7f477939a6cc56 = nd_path_node;
      } else {
        break;
      }

      continue;
    }

    if(isDefined(var_4b7f477939a6cc56)) {
      break;
    }

    break;
  }

  if(!isDefined(self)) {
    return undefined;
  }

  self setgoalpath(a_nd_path);
}

function reveal_nameplate(str_name, str_team) {
  self.script_friendname = str_name;
  self.name = self.script_friendname;
  self.team = str_team;
}

function function_321743792c34f714(enta, entb) {
  player_angles = level.player getplayerangles();
  player_forward = anglesToForward(player_angles);
  player_eye = level.player getEye();
  vectora = vectorNormalize(enta.origin - player_eye);
  dota = vectordot(player_forward, vectora);
  vectorb = vectorNormalize(entb.origin - player_eye);
  dotb = vectordot(player_forward, vectorb);
  return dota > dotb;
}

function function_c1e075c4168a8bea(b_pushable, var_8f5a59322738598e) {
  var_8f5a59322738598e = default_to(var_8f5a59322738598e, 1);
  self.script_pushable = b_pushable;
  self.pushable = b_pushable;

  if(istrue(var_8f5a59322738598e)) {
    self pushplayer(!b_pushable);
  }
}

function function_80ce055c4cf16f58(deathquotearray, mindamage, playerdistance, ignoresplash) {
  self notify("stop_civilian_fail_wrapper");
  self endon("stop_civilian_fail_wrapper");
  level endon("stop_all_civilian_fail_wrappers");

  if(!isDefined(deathquotearray)) {
    deathquotearray = [9, 30];
  }

  assertex(isarray(deathquotearray), "deathQuoteArray must be an array!");

  if(!isDefined(mindamage)) {
    mindamage = 20;
  }

  if(isDefined(playerdistance)) {
    playerdistance *= playerdistance;
  }

  if(!isDefined(ignoresplash)) {
    ignoresplash = 0;
  }

  distance = undefined;
  splasharray = ["MOD_IMPACT", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_FIRE"];

  while(true) {
    self waittill("damage", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!isDefined(attacker) || !isDefined(damage)) {
      continue;
    } else if(!isPlayer(attacker)) {
      continue;
    } else if(damage < mindamage) {
      continue;
    } else if(isDefined(meansofdeath) && istrue(ignoresplash) && array_contains(splasharray, meansofdeath)) {
      continue;
    } else if(isDefined(objweapon) && objweapon.basename == "flash") {
      continue;
    } else if(isDefined(playerdistance)) {
      distance = distancesquared(level.player.origin, self.origin);

      if(distance > playerdistance) {
        continue;
      }
    }

    break;
  }

  scripts\sp\player_death::set_custom_death_quote(array_randomize(deathquotearray)[0]);
  missionfailedwrapper();
}

function function_85617ef2484fe085() {
  if(!objective_exists("chunnel_obj")) {
    flag_set("flg_intro_done");
    flag_set("flg_park_follow_hacker_obj_start");
    flag_set("flg_park_whiskey_leave_1");
    flag_set("flg_park_obj_listen_to_call_show");
    flag_set("flg_park_cctv_1_start");
    flag_set("flg_rewind_target_first_seen");
    flag_set("flg_streets_cctv_track_done");
    flag_set("flg_hideout_breached");
    flag_set("flg_hideout_clear_obj_start");
    flag_set("flg_hideout_bathroom_start");
    flag_set("flg_hideout_main_path_corridor00");
    flag_set("flg_hideout_servicehall_start");
    flag_set("flg_hideout_final_room_clear");
    flag_set("flg_hideout_final_guy_aware");
    flag_set("flg_hideout_intel_enter");
    flag_set("flg_hideout_office_enemies_dead");
    flag_set("hideout_interact_evidence_complete");
    flag_set("flg_chunnel_obj_start");
  }
}

function function_6b37e3de8785785f() {}

function function_a3f068b710625af7() {}

function function_f3d5fd34802f1c43() {}

function function_9e29132d33b8fd8c() {
  scripts\engine\scriptable::scriptable_addusedcallback(&function_b1b8ae9d6488b9d9);
  level.var_bddff04f24e37e3e = [];
  var_87c8e4f45dca413 = "surge_sentry";
  level.sentrysettings[var_87c8e4f45dca413] = spawnStruct();
  level.sentrysettings[var_87c8e4f45dca413].health = 999999;
  level.sentrysettings[var_87c8e4f45dca413].maxhealth = 10;
  level.sentrysettings[var_87c8e4f45dca413].armor = 750;
  level.sentrysettings[var_87c8e4f45dca413].burstmin = 10;
  level.sentrysettings[var_87c8e4f45dca413].burstmax = 20;
  level.sentrysettings[var_87c8e4f45dca413].burstmaxtime = 2.5;
  level.sentrysettings[var_87c8e4f45dca413].var_6265b628c3ed1103 = 0.5;
  level.sentrysettings[var_87c8e4f45dca413].var_87d927a08cbfdf3f = 0.1;
  level.sentrysettings[var_87c8e4f45dca413].pausemin = 0.15;
  level.sentrysettings[var_87c8e4f45dca413].pausemax = 0.35;
  level.sentrysettings[var_87c8e4f45dca413].lockstrength = 2;
  level.sentrysettings[var_87c8e4f45dca413].sentrymodeon = "sentry";
  level.sentrysettings[var_87c8e4f45dca413].var_7c46d96a6fedd4cd = "manual_ai";
  level.sentrysettings[var_87c8e4f45dca413].sentrymodeoff = "sentry_offline";
  level.sentrysettings[var_87c8e4f45dca413].ammo = 200;
  level.sentrysettings[var_87c8e4f45dca413].timeout = 999999;
  level.sentrysettings[var_87c8e4f45dca413].spinuptime = 0.65;
  level.sentrysettings[var_87c8e4f45dca413].overheattime = 1;
  level.sentrysettings[var_87c8e4f45dca413].rightarc = 80;
  level.sentrysettings[var_87c8e4f45dca413].leftarc = 80;
  level.sentrysettings[var_87c8e4f45dca413].bottomarc = 120;
  level.sentrysettings[var_87c8e4f45dca413].toparc = 60;
  level.sentrysettings[var_87c8e4f45dca413].var_83c1b372bdac7446 = 1280;
  level.sentrysettings[var_87c8e4f45dca413].targetrange = 2560;
  level.sentrysettings[var_87c8e4f45dca413].laserrange = 7562500;
  level.sentrysettings[var_87c8e4f45dca413].cooldowntime = 0.1;
  level.sentrysettings[var_87c8e4f45dca413].fxtime = 0.3;
  level.sentrysettings[var_87c8e4f45dca413].streakname = "sentry_gun";
  level.sentrysettings[var_87c8e4f45dca413].weaponinfo = "sentry_turret_jup_sp_surge";
  level.sentrysettings[var_87c8e4f45dca413].scriptable = "ks_sentry_turret_jup_sp";
  level.sentrysettings[var_87c8e4f45dca413].modelbaseground = "wpn_wm_p45_mg_auto_sentry_v0_jup_sp";
  level.sentrysettings[var_87c8e4f45dca413].modeldestroyedground = "wpn_wm_p45_mg_auto_sentry_v0_jup_sp";
  level.sentrysettings[var_87c8e4f45dca413].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings[var_87c8e4f45dca413].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings[var_87c8e4f45dca413].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings[var_87c8e4f45dca413].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings[var_87c8e4f45dca413].teamsplash = "used_sentry_gun";
  level.sentrysettings[var_87c8e4f45dca413].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings[var_87c8e4f45dca413].shouldsplash = 0;
  level.sentrysettings[var_87c8e4f45dca413].votimeout = "sentry_gun_teamleader_crash";
  level.sentrysettings[var_87c8e4f45dca413].vodestroyed = "sentry_gun_teamleader_crash";
  level.sentrysettings[var_87c8e4f45dca413].scorepopup = "destroyed_sentry";
  level.sentrysettings[var_87c8e4f45dca413].lightfxtag = "tag_fx";
  level.sentrysettings[var_87c8e4f45dca413].var_e35cff9d5d064f5a = 15;
  level.sentrysettings[var_87c8e4f45dca413].var_1ee509c466a8780f = 4;
  level.sentrysettings[var_87c8e4f45dca413].var_ff76df61ae566390 = 2;
}

function setup_enemy_sentry(var_804269875f5062f1, turret_model, var_385e9c9e53753524, team, range_override, var_7c8380e5d9af0d5f, spread_override) {
  sentrytype = default_to(var_385e9c9e53753524, "surge_sentry");
  team = default_to(team, "axis");
  config = level.sentrysettings[sentrytype];
  turret = spawnturret("misc_turret", var_804269875f5062f1.origin, level.sentrysettings[sentrytype].weaponinfo);
  turret.team = team;

  if(!isDefined(var_804269875f5062f1.angles)) {
    var_804269875f5062f1.angles = (0, 0, 0);
  }

  turret.angles = var_804269875f5062f1.angles;
  turret.health = config.health;
  turret.maxhealth = config.maxhealth;
  turret.armor = config.armor;
  turret.hasarmor = 1;
  turret.sentrytype = sentrytype;
  turret.turreton = 1;
  turret.objweapon = makeweapon(level.sentrysettings[sentrytype].weaponinfo);
  turret setaispread(default_to(spread_override, 4));
  turret.canfire = 1;
  turret makeentitysentient(team);
  turret.turrettype = "sentry_turret";
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 2;
  turret.var_e35cff9d5d064f5a = default_to(config.var_e35cff9d5d064f5a, 15);
  turret.var_1ee509c466a8780f = default_to(config.var_1ee509c466a8780f, 4);
  turret.var_ff76df61ae566390 = default_to(config.var_ff76df61ae566390, 1);

  if(isDefined(range_override)) {
    turret function_8bd5f380528bf432(range_override);
    turret.targetrange = range_override;
    turret.var_52edc18a611b938d = squared(range_override);
  } else {
    turret.targetrange = config.targetrange;
    turret.var_52edc18a611b938d = squared(config.targetrange);
  }

  if(isDefined(var_7c8380e5d9af0d5f)) {
    turret.var_83c1b372bdac7446 = var_7c8380e5d9af0d5f;
    turret.var_5af42ba05a97de9a = squared(var_7c8380e5d9af0d5f);
  } else if(isDefined(var_804269875f5062f1.var_7c8380e5d9af0d5f)) {
    turret.var_83c1b372bdac7446 = int(var_804269875f5062f1.var_7c8380e5d9af0d5f);
    turret.var_5af42ba05a97de9a = squared(int(var_804269875f5062f1.var_7c8380e5d9af0d5f));
  } else {
    turret.var_83c1b372bdac7446 = config.var_83c1b372bdac7446;
    turret.var_5af42ba05a97de9a = squared(config.var_83c1b372bdac7446);
  }

  var_804269875f5062f1.turret = turret;

  if(!isDefined(turret_model) && isDefined(config.modelbaseground)) {
    turret_model = config.modelbaseground;
  }

  turret setModel(turret_model);
  turret setturretteam("axis");
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.2);
  turret maketurretinoperable();

  if(isDefined(var_804269875f5062f1.skip_overheat)) {
    turret.skip_overheat = var_804269875f5062f1.skip_overheat;
  }

  leftarc = float(ter_op(isDefined(var_804269875f5062f1.leftarc), var_804269875f5062f1.leftarc, config.leftarc));
  turret setleftarc(leftarc);
  rightarc = float(ter_op(isDefined(var_804269875f5062f1.rightarc), var_804269875f5062f1.rightarc, config.rightarc));
  turret setrightarc(rightarc);
  toparc = float(ter_op(isDefined(var_804269875f5062f1.toparc), var_804269875f5062f1.toparc, config.toparc));
  turret settoparc(toparc);
  bottomarc = float(ter_op(isDefined(var_804269875f5062f1.bottomarc), var_804269875f5062f1.bottomarc, config.bottomarc));
  turret setbottomarc(bottomarc);
  turret.var_da9dbf6cbcc16bb9 = float(ter_op(isDefined(var_804269875f5062f1.script_noteworthy), var_804269875f5062f1.script_noteworthy, leftarc));
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setturretmodechangewait(0);
  turret solid();
  turret.var_d1f953c063dff1eb = 1;
  turret.trace_tag = "tag_laser";

  if(!turret tagexists("tag_laser")) {
    turret.trace_tag = "tag_flash";
  }

  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel linkTo(turret);
  turret.colmodel.var_d1f953c063dff1eb = 1;
  turret.colmodel.turretowner = turret;

  if(isDefined(config.hitbyvehiclefunc)) {
    turret.hitbyvehiclefunc = config.hitbyvehiclefunc;
  }

  turret.navobstacle = createnavobstaclebybounds(turret.origin, (16, 16, 16), (0, 0, 0));

  if(!isDefined(level.killstreak_additional_targets)) {
    level.killstreak_additional_targets = [];
  }

  level.killstreak_additional_targets = array_add(level.killstreak_additional_targets, turret);
  wait 1;
  turret setmode(level.sentrysettings[sentrytype].sentrymodeon);
  turret thread sentry_watchfordeath();
  turret thread function_c89de017c526954();
  turret thread sentry_handledeath();

  if(isDefined(var_804269875f5062f1.var_2108ba0559bdaaff)) {
    var_2108ba0559bdaaff = var_804269875f5062f1.var_2108ba0559bdaaff;
  } else {
    var_2108ba0559bdaaff = &function_1adc5a7001847ae6;
  }

  turret.var_2108ba0559bdaaff = var_2108ba0559bdaaff;
  turret thread[[var_2108ba0559bdaaff]]();
  turret setscriptablepartstate("lights", "daytime", 0);
  turret thread sentry_interact(team);
  return turret;
}

function function_c89de017c526954() {
  self endon("death");
  self endon("kill_turret");
  self endon("preplaced_sentry_pickedup");
  level endon("game_ended");
  self setCanDamage(1);
  self setCanRadiusDamage(1);
  self.fake_health = self.maxhealth;

  while(true) {
    self waittill("damage", idamage, eattacker, vdir, vpoint, damage_mod, smodelname, stagname, spartname, idflags, objweapon, origin, angles, normal, einflictor, eventid);

    if(!isDefined(eattacker)) {
      continue;
    }

    if(isDefined(eattacker.team) && eattacker.team == self.team) {
      continue;
    }

    if(isDefined(damage_mod) && isexplosivedamagemod(damage_mod)) {
      idamage *= 2;
    }

    var_a15c9ef5c436be5e = idamage;

    if(self.armor > 0) {
      self.armor -= idamage;

      if(self.armor > 0) {
        if(isPlayer(eattacker)) {
          eattacker scripts\sp\damagefeedback::updatedamagefeedback("hitarmor");
          thread play_sound_in_space("hit_marker_3d_armor", self.origin);
        }
      } else if(self.hasarmor) {
        var_a15c9ef5c436be5e = -1 * self.armor;
        self.hasarmor = 0;

        if(isPlayer(eattacker)) {
          eattacker scripts\sp\damagefeedback::updatedamagefeedback("hitarmorbreak");
          thread play_sound_in_space("hit_marker_3d_armor_break", self.origin);
        }
      }

      continue;
    }

    self.fake_health -= var_a15c9ef5c436be5e;
    self.health = 999999;

    if(self.fake_health <= self.maxhealth * 0.5 && !istrue(self.damagedstate)) {
      self.damagedstate = 1;
      self setscriptablepartstate("turret_damage", "on", 0);
    }

    if(isPlayer(eattacker)) {
      if(self.fake_health > 0) {
        eattacker scripts\sp\damagefeedback::updatedamagefeedback("standard", 0);
        continue;
      }

      eattacker scripts\sp\damagefeedback::updatedamagefeedback("standard", 1);
    }
  }
}

function sentry_watchfordeath() {
  self endon("death");

  while(true) {
    if(!isDefined(self.fake_health)) {
      waitframe();
      continue;
    }

    if(self.fake_health <= 0) {
      self notify("death");
    }

    wait 0.1;
  }
}

function sentry_interact(team) {
  self notify("sentry_interact");
  self endon("sentry_interact");
  self endon("death");
  team = default_to(team, "axis");
  enemy_team = get_enemy_team(team);
  self makeusable();
  self setscriptablepartstate("hack_usable", "on");
  self waittill("hacked");
  level.player thread function_7c5676ad7096e4d5();
  wait 2;
  sentry_shutdown();
}

function sentry_shutdown() {
  self endon("death");
  self setscriptablepartstate("hack_usable", "off");
  self notify("stop_idle_movement");
  self notify("stop_sentry_complex_think");
  self laserforceoff();
  self turretfiredisable();
  self.canfire = 0;
  self settargetentity(self.targetent);
  function_64109b7cba5261eb(self.var_6b7f5a97c612b748, 1);
  self setmode("sentry_offline");
  self.state = "shutdown";
  self setscriptablepartstate("lights", "off");
  scripts\engine\sp\utility::set_ignoreme(1);
}

function sentry_startup() {
  thread function_5e66cae8a3e9f368();
  self setscriptablepartstate("hack_usable", "on");
  thread sentry_interact();
  wait 2;
  scripts\engine\sp\utility::set_ignoreme(0);
  self.canfire = 1;
}

function function_7c5676ad7096e4d5() {
  deviceweapon = makeweapon("ks_remote_hack_mp");
  currentweapon = level.player getcurrentweapon();
  level.player giveweapon(deviceweapon);
  level.player setweaponammostock(deviceweapon, 1);
  level.player setweaponammoclip(deviceweapon, 0);
  level.player function_682adc5b953ee18a(1);
  level.player switchtoweapon(deviceweapon);
  level.player playlocalsound("jup_tun_ks_tablet_foly_raise_plr");
  level.player setclientomnvar("ui_hack_index", 109);
  self playlocalsound("jup_tun_spotter_perk_tablet_ui");
  wait 2.4;
  self stoplocalsound("jup_tun_spotter_perk_tablet_ui");
  level.player setclientomnvar("ui_hack_index", 0);
  self playlocalsound("jup_tun_ks_tablet_foly_lower_plr");
  level.player switchtoweapon(currentweapon);
  level.player function_22868942d26444a4();
  wait 0.5;
  level.player takeweapon(deviceweapon);
}

function private function_682adc5b953ee18a(isrestricted) {
  if(isrestricted) {
    val::set("disabling_sentry", "allow_movement", 0);
    val::set("disabling_sentry", "allow_jump", 0);
  }

  val::set("disabling_sentry", "weapon_pickup", 0);
  self function_35501b42058d4de9();
}

function private function_22868942d26444a4() {
  val::reset_all("disabling_sentry");
  self function_bb04491d50d9e43e();
}

function sentry_hack(team) {
  self endon("death");
  team = default_to(team, "axis");
  enemy_team = get_enemy_team(team);
  self setscriptablepartstate("hack_usable", "on");
  self waittill("hacked");
  waitframe();
  self.hacked = 1;
  self setscriptablepartstate("hack_usable", "off");
  self setturretteam(enemy_team);
  self setturretowner(self.owner);

  if(isDefined(self.colmodel)) {
    self.colmodel.team = enemy_team;
    self.colmodel.owner = self.owner;
  }

  self.var_7f9d2390614a7d3c = 1;

  if(istrue(self.var_7f9d2390614a7d3c)) {
    self cleartargetentity();
    self turretfireenable();
    self setmode("sentry");
    self setsentryowner(self.owner);
    thread function_1adc5a7001847ae6();
    self function_8bd5f380528bf432(2000);

    if(isDefined(self.targetent)) {
      self.targetent delete();
    }

    self.targetent = undefined;
    self notify("stop_sentry_complex_think");
  } else {
    self.var_6320b0669bc739aa = 1;
    self.state = undefined;
    self setsentryowner(self.owner);
    self notify("stop_sentry_complex_think");
    self thread[[self.var_2108ba0559bdaaff]]();
  }

  self makeentitysentient(enemy_team);
}

function sentryturret_watchpickup(turret) {
  turret endon("kill_turret");
  turret endon("carried");
  turret endon("turret_hacked");
  self endon("disconnect");
  level endon("game_ended");
  turret.streakinfo = level.sentrysettings["sentry_turret"];
  turret.streakinfo.owner = self;
  turret.timeout = level.sentrysettings["sentry_turret"].timeout;

  while(true) {
    turret.useownerobj waittill("trigger");
  }
}

function sentry_targetlocksound() {
  self endon("death");
  self endon("preplaced_sentry_pickedup");
  wait 0.1;
  wait 0.1;
}

function sentry_heatmonitor() {
  if(istrue(self.skip_overheat)) {
    return;
  }

  self endon("death");
  self notify("sentry_heat_monitor_start");
  self endon("sentry_heat_monitor_start");
  self endon("preplaced_sentry_pickedup");
  firetime = weaponfiretime(level.sentrysettings[self.sentrytype].weaponinfo);
  var_c81d1ae9575cd803 = 0;
  var_6d613d4ed09f7ca = 0;
  overheattime = level.sentrysettings[self.sentrytype].overheattime;
  overheatcooldown = level.sentrysettings[self.sentrytype].cooldowntime;

  for(;;) {
    if(self.heatlevel != var_c81d1ae9575cd803) {
      wait firetime;
    } else {
      self.heatlevel = max(0, self.heatlevel - 0.05);
    }

    if(self.heatlevel > overheattime) {
      self.overheated = 1;
      thread function_fa148e3018078581();

      while(self.heatlevel) {
        self.heatlevel = max(0, self.heatlevel - overheatcooldown);
        wait 0.1;
      }

      self.overheated = 0;
      self notify("not_overheated");
    }

    var_c81d1ae9575cd803 = self.heatlevel;
    wait 0.05;
  }
}

function function_fa148e3018078581() {
  self endon("death");
  self endon("not_overheated");
  self endon("preplaced_sentry_pickedup");
  level endon("game_ended");
  self notify("playing_heat_fx");
  self endon("playing_heat_fx");

  while(true) {
    wait level.sentrysettings[self.sentrytype].fxtime;
  }
}

function sentry_handledeath() {
  self notify("death_handler");
  self endon("death_handler");
  self endon("preplaced_sentry_pickedup");
  self waittill("death");
  self notify("stop_idle_movement");

  if(!isDefined(self)) {
    if(isDefined(self.useownerobj)) {
      self.useownerobj delete();
    }

    return;
  }

  self notify("stop_sentry_complex_think");
  self settargetentity(self.targetent);
  self turretfiredisable();
  self laserforceoff();
  self setscriptablepartstate("lights", "off");
  self setscriptablepartstate("hack_usable", "off");
  self setmode("sentry_offline");
  self setscriptablepartstate("explode", "violent");
  scripts\engine\sp\utility::set_ignoreme(1);
}

function sentry_deleteturret(skip_fx) {
  self endon("preplaced_sentry_pickedup");
  self notify("sentry_delete_turret");
  self endon("sentry_delete_turret");
  level.killstreak_additional_targets = array_remove(level.killstreak_additional_targets, self);

  if(isDefined(self.navobstacle)) {
    destroynavobstacle(self.navobstacle);
  }

  if(isDefined(self.useownerobj)) {
    self.useownerobj delete();
  }

  self freeentitysentient();

  if(!istrue(skip_fx)) {
    wait 1.5;
    wait 0.1;
  }

  self notify("deleting");

  if(isDefined(self.targetent)) {
    self.targetent delete();
  }

  if(isDefined(self.colmodel)) {
    self.colmodel delete();
  }

  if(isDefined(self)) {
    self delete();
  }
}

function function_da543a78871cdadf() {}

function function_1adc5a7001847ae6() {
  self endon("death");
  level endon("game_ended");
  self setmode("sentry");
  thread sentry_heatmonitor();

  for(;;) {
    waittill_either("turretstatechange", "cooled");

    if(is_equal(self.state, "engaging") && is_equal(self.team, self.curtarget.team)) {
      self stopfiring();
      self notify("stop_shooting");
      waitframe();
      self setmode("sentry");
      continue;
    }

    if(self isfiringturret()) {
      self laserforceon();
      thread sentry_burstfirestart();
      continue;
    }

    thread sentry_burstfirestop();
  }
}

function sentry_burstfirestart() {
  self endon("death");
  self endon("stop_shooting");
  level endon("game_ended");
  config = level.sentrysettings[self.sentrytype];
  firetime = weaponfiretime(config.weaponinfo);
  minshots = config.burstmin;
  maxshots = config.burstmax;
  minpause = config.pausemin;
  maxpause = config.pausemax;

  for(;;) {
    numshots = randomintrange(minshots, maxshots + 1);

    for(i = 0; i < numshots && !self.overheated; i++) {
      self shootturret();
      self notify("bullet_fired");
      self.heatlevel += firetime;
      wait firetime;
    }

    wait randomfloatrange(minpause, maxpause);
  }
}

function sentry_burstfirestop() {
  self notify("stop_shooting");
}

function function_f90ee10011da2bbe() {}

function function_53277168d12d02f0() {
  self notify("updateTargetEnt");
  self endon("updateTargetEnt");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(isDefined(self.targetent)) {
    currenttarget = self gettargetentity();

    if(isDefined(currenttarget) && currenttarget != self.targetent) {
      offset = self.targetent function_68f5137066dc2323(currenttarget);
      self.targetent moveTo(currenttarget.origin + (0, 0, offset), 0.1);

      sphere(currenttarget.origin + (0, 0, offset), 20, (0.9, 0.7, 0.6), 0, 10);
    }

    wait 0.2;
  }
}

function function_68f5137066dc2323(current_target) {
  offset = 30;

  if(isDefined(current_target)) {
    if(isPlayer(current_target)) {
      tag = current_target getEye();
      offset = tag[2] - current_target.origin[2];
    } else if(current_target tagexists("j_spine4")) {
      tag = current_target gettagorigin("j_spine4");
      offset = tag[2] - current_target.origin[2];
    }
  }

  return offset;
}

function function_e0458e371eb04c70() {
  self notify("targetOffsetUpdate");
  self endon("targetOffsetUpdate");
  self endon("death");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    targetent = self gettargetentity();

    if(isDefined(targetent)) {
      offset = targetent function_68f5137066dc2323();
      self settargetentity(targetent, (0, 0, offset));
    }

    wait 0.1;
  }
}

function function_5e66cae8a3e9f368() {
  self endon("death");
  self endon("stop_sentry_complex_think");
  config = level.sentrysettings[self.sentrytype];

  if(!isDefined(self.var_83c1b372bdac7446) && isDefined(config.var_83c1b372bdac7446)) {
    self.var_83c1b372bdac7446 = config.var_83c1b372bdac7446;
    self.var_5af42ba05a97de9a = squared(self.var_83c1b372bdac7446);
  }

  level.sentrysettings[self.sentrytype].sentrymodeon = "manual_ai";
  level.sentrysettings[self.sentrytype].sentrymodeoff = "manual_ai";
  self setmode("manual");
  targettimeout = 0;
  timeout = 5;
  time_interval = 0.5;
  self.laser_on = 0;
  self.overheated = 0;
  thread function_3dddad03d8b1c284();
  thread sentry_heatmonitor();
  thread function_e0458e371eb04c70();
  thread function_53277168d12d02f0();
  self turretfireenable();

  while(true) {
    if(!istrue(self.turreton) || istrue(self.turretdisabled)) {
      waitframe();
      continue;
    }

    besttarget = sentry_getbesttarget();
    var_1b951c4e47ba5c35 = 1;

    if(isDefined(besttarget)) {
      if(!self.laser_on) {
        self.state = "engaging";
        self notify("engaging_target");
        self notify("stop_idle_movement");
        thread sentry_targetlocksound();
      }

      if(isPlayer(besttarget) && issharedfuncdefined("player", "isReallyAlive")) {
        if(![[getsharedfunc("player", "isReallyAlive")]](besttarget)) {
          var_1b951c4e47ba5c35 = 0;
        }
      } else if(isagent(besttarget)) {
        if(!isalive(besttarget)) {
          var_1b951c4e47ba5c35 = 0;
        }
      }

      if(var_1b951c4e47ba5c35) {
        target_lost = function_2404375517987371(besttarget);

        if(!istrue(target_lost)) {
          wait config.cooldowntime;
        }
      }
    } else if(self.state != "idle") {
      if(self.state != "lost_LOS") {
        function_30b63fb2cbf3dec7();
      }

      wait time_interval;
      targettimeout += time_interval;

      if(targettimeout > timeout) {
        thread function_3dddad03d8b1c284();
      } else {
        continue;
      }
    } else {
      wait 1;
      targettimeout = 0;
      continue;
    }

    waitframe();
  }
}

function function_3dddad03d8b1c284() {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");
  self endon("stop_sentry_complex_think");

  if(isDefined(self.state) && self.state == "idle") {
    return;
  }

  self stopfiring();
  self.state = "idle";
  self notify("enter_idle");
  self notify("stop_shooting");

  if(isDefined(self.idle_func)) {
    self[[self.idle_func]]();
    return;
  }

  tag = self.trace_tag;
  loc = self.origin + anglesToForward(self gettagangles(tag)) * 2000;

  if(!isDefined(self.targetent)) {
    self.targetent = spawn("script_model", loc);
    self.targetent setModel("tag_origin");
  }

  self.targetent.origin = loc;
  self.targetent dontinterpolate();
  offset = self.targetent function_68f5137066dc2323();
  self settargetentity(self.targetent, (0, 0, offset));
  sentry_origin = self.origin;
  sentry_angles = self.angles;
  var_878bae61aca86fc5 = anglesToForward(sentry_angles);
  var_a1b727d30fc62a0f = anglestoup(sentry_angles);
  var_1b77e17a42e2545b = anglestoleft(sentry_angles);
  var_6232855eba31163a = anglestoright(sentry_angles);
  maxangle = self.var_da9dbf6cbcc16bb9;
  drawdist = 300;
  var_b716ed1e1043d49d = rotatepointaroundvector(var_a1b727d30fc62a0f, var_878bae61aca86fc5, maxangle);
  var_37acb3a5ef4e3396 = vectorNormalize(vectorcross(var_b716ed1e1043d49d, var_a1b727d30fc62a0f));
  var_13b2c03f423eb4f1 = vectorcross(var_37acb3a5ef4e3396, var_b716ed1e1043d49d);
  var_5a8f11024e7733a5 = axistoangles(var_b716ed1e1043d49d, var_37acb3a5ef4e3396, var_13b2c03f423eb4f1);
  var_f4feef348ddcce80 = rotatepointaroundvector(var_a1b727d30fc62a0f, var_878bae61aca86fc5, maxangle * -1);
  var_28a104b41542054b = vectorNormalize(vectorcross(var_f4feef348ddcce80, var_a1b727d30fc62a0f));
  var_71068ef94589e94a = vectorcross(var_28a104b41542054b, var_f4feef348ddcce80);
  var_6b5bd2eb86959740 = axistoangles(var_f4feef348ddcce80, var_28a104b41542054b, var_71068ef94589e94a);
  var_d5c157bf3efda129 = vectortoangles(var_a1b727d30fc62a0f);
  var_3c19d396e8243a45 = vectortoangles(var_878bae61aca86fc5);
  self.var_3c19d396e8243a45 = var_3c19d396e8243a45;
  var_a0d15869f98efc85 = vectortoangles(var_1b77e17a42e2545b);
  var_10972f86bc3d391e = vectortoangles(var_6232855eba31163a);
  var_1b15c3a05b795a8e = rotatepointaroundvector(var_6232855eba31163a, var_878bae61aca86fc5, -70);
  var_f30667c02d5b0b71 = vectorNormalize(vectorcross(var_1b15c3a05b795a8e, var_6232855eba31163a));
  var_fb004474b0d5134c = vectorcross(var_f30667c02d5b0b71, var_1b15c3a05b795a8e);
  self.var_6b7f5a97c612b748 = axistoangles(var_1b15c3a05b795a8e, var_f30667c02d5b0b71, var_fb004474b0d5134c);
  sentry_origin = self gettagorigin(tag);
  newdir = anglesToForward(var_3c19d396e8243a45);
  newpos = sentry_origin + newdir * self.targetrange;
  trace = scripts\engine\trace::ray_trace(sentry_origin, newpos, self);
  end = trace["position"];
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  vmidpoint = (sentry_origin + end) / 2;
  waitframe();

  if(!self.laser_on) {
    self laserforceon();
    self.laser_on = 1;
  }

  while(true) {
    function_c2659db9dbffda55(var_5a8f11024e7733a5, 3);
    function_c2659db9dbffda55(var_6b5bd2eb86959740, 3);
  }
}

function function_ae918abfa5c66bd6(var_f095df44cb4d44c3, var_b1912d395068cf48) {
  self endon("death");
  self endon("stop_sentry_complex_think");
  wait 5;

  if(isDefined(var_b1912d395068cf48) && isvector(var_b1912d395068cf48)) {
    self.soundorg = spawn("script_model", var_b1912d395068cf48);
  } else {
    self.soundorg = spawn("script_model", self.origin);
  }

  self.soundorg setModel("tag_origin");
  waitframe();
  self.soundorg linkTo(self, "tag_aim_pivot");
}

function function_ccab4a92dcf417e4(var_f095df44cb4d44c3) {
  self.soundorg delete();
}

function function_64109b7cba5261eb(angles, timehere) {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");
  self endon("stop_sentry_complex_think");
  timehere = default_to(timehere, 4);
  tag = self.trace_tag;
  newdir = anglesToForward(angles);
  sentry_origin = self gettagorigin(tag) + newdir * 2;
  newpos = sentry_origin + newdir * 666;
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  newposfinal = newpos;
  movetime = timehere * 0.7;
  var_93912c82c941f846 = timehere * 0.15;
  var_dbfa2182fe49a2af = timehere * 0.15;
  newup = anglestoup(angles);
  self.targetent moveTo(newposfinal, movetime, var_93912c82c941f846, var_dbfa2182fe49a2af);
  wait timehere;
}

function function_c2659db9dbffda55(angles, timehere, debug_text) {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");
  self endon("stop_sentry_complex_think");
  timehere = default_to(timehere, 4);
  sentry_origin = self gettagorigin("tag_ai_aim_target");
  newdir = anglesToForward(angles);
  newpos = sentry_origin + newdir * 500;
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  rotatetoangles = vectortoangles(newdir);
  self.targetent moveTo(newposfinal, timehere);
  wait timehere - 0.1;
}

function function_2404375517987371(besttarget) {
  config = level.sentrysettings[self.sentrytype];
  self.burstcount = 0;
  besttarget.var_7b4128fcb5718032 = 1;

  while(istrue(self.turreton) && function_b5d0a038b8a18782(besttarget) && besttarget == sentry_getbesttarget()) {
    offset = besttarget function_68f5137066dc2323();
    self settargetentity(besttarget, (0, 0, offset));
    self.curtarget = besttarget;

    if(isPlayer(besttarget)) {
      pauseinterval = config.var_6265b628c3ed1103;
    } else {
      pauseinterval = config.var_87d927a08cbfdf3f;
    }

    function_20817f07e87d580b(config.burstmaxtime, besttarget);
    self.burstcount += 1;

    if(isPlayer(besttarget) && self.burstcount >= self.var_1ee509c466a8780f) {
      besttarget.var_7b4128fcb5718032 = 0;
      besttarget thread function_e31314d328168014(self.var_e35cff9d5d064f5a);
    } else if(isai(besttarget) && self.burstcount >= self.var_ff76df61ae566390) {
      besttarget.var_7b4128fcb5718032 = 0;
      besttarget thread function_e31314d328168014(self.var_e35cff9d5d064f5a);
    }

    if(istrue(self.turreton) && !function_b5d0a038b8a18782(besttarget)) {
      self cleartargetentity();
      return true;
    }

    wait pauseinterval;
  }

  self cleartargetentity();
  return false;
}

function function_4d8945c7b0e327ad(var_82947870c2d321f, sentry, endonstring) {
  self endon("death");
  sentry endon("death");
  sentry endon("kill_turret");
  sentry endon("hacked");

  if(isDefined(endonstring)) {
    level endon(endonstring);
  }

  while(true) {
    self waittill("damage", amount, attacker, direction, point, means_of_death, model, tag, part_name, damage_flags, weapon_name);

    if(attacker == sentry) {
      self dodamage(amount * var_82947870c2d321f, point, attacker, attacker, means_of_death);
    }
  }
}

function function_e31314d328168014(timetowait) {
  self notify("turretTargetCooldown");
  self endon("turretTargetCooldown");
  self endon("death");
  level endon("game_ended");
  wait timetowait;
  self.var_7b4128fcb5718032 = 1;
}

function function_20817f07e87d580b(maxbursttime, potentialtarget) {
  config = level.sentrysettings[self.sentrytype];
  firetime = weaponfiretime(config.weaponinfo);
  minshots = config.burstmin;
  maxshots = config.burstmax;
  minpause = config.pausemin;
  maxpause = config.pausemax;
  lockstrength = config.lockstrength;
  currenttime = 0;
  var_1b951c4e47ba5c35 = 1;
  var_89ca43180ff7115a = undefined;

  while(istrue(self.turreton) && currenttime < maxbursttime && var_1b951c4e47ba5c35) {
    numshots = randomintrange(minshots, maxshots + 1);

    for(i = 0; i < numshots && !self.overheated; i++) {
      if(!istrue(self.turreton)) {
        break;
      }

      target = self getturrettarget(1);

      if(!isDefined(target)) {
        break;
      }

      if(isPlayer(target)) {
        if(!isalive(target) || istrue(target.var_f6f8549c6fd27e85)) {
          break;
        }
      }

      if(!self.canfire) {
        break;
      }

      self shootturret("tag_flash", lockstrength);
      scripts\stealth\event::event_broadcast_generic("gunshot", self.origin, 1500, self);
      self.heatlevel += firetime;
      wait firetime;
      currenttime += firetime;
    }

    if(!istrue(self.turreton)) {
      break;
    }

    randwait = randomfloatrange(minpause, maxpause);
    wait randwait;
    currenttime += randwait;

    if(isPlayer(potentialtarget) && issharedfuncdefined("player", "isReallyAlive")) {
      var_1b951c4e47ba5c35 = [[getsharedfunc("player", "isReallyAlive")]](potentialtarget);
      continue;
    }

    if(isagent(potentialtarget)) {
      var_1b951c4e47ba5c35 = isalive(potentialtarget);
    }
  }
}

function sentry_getbesttarget() {
  potentialtargetlist = [];
  enemy_team = get_enemy_team(self.team);
  ents = getaiarray(enemy_team);
  ents[ents.size] = level.player;

  foreach(targ in ents) {
    if(array_contains(level.var_bddff04f24e37e3e, targ)) {
      continue;
    }

    if(!issentient(targ)) {
      continue;
    }

    potentialtargetlist[potentialtargetlist.size] = targ;
  }

  besttarget = undefined;
  bestrange = undefined;
  start_tag = self.trace_tag;

  foreach(potentialtarget in potentialtargetlist) {
    validtarget = function_1d3253884542b0e6(potentialtarget);

    if(!istrue(validtarget)) {
      continue;
    }

    if(!isDefined(potentialtarget.var_7b4128fcb5718032)) {
      potentialtarget.var_7b4128fcb5718032 = 1;
    }

    if(isDefined(besttarget) && !potentialtarget.var_7b4128fcb5718032 && besttarget.var_7b4128fcb5718032) {
      continue;
    }

    startpoint = self gettagorigin(start_tag);
    endpoint = potentialtarget.origin;
    currentrange = distancesquared(startpoint, endpoint);

    if(currentrange <= self.var_52edc18a611b938d) {
      if(!isDefined(besttarget) && !isDefined(bestrange) || currentrange < bestrange) {
        besttarget = potentialtarget;
        bestrange = currentrange;
      }
    }
  }

  return besttarget;
}

function function_1d3253884542b0e6(potentialtarget) {
  if(istrue(potentialtarget.notarget)) {
    return false;
  }

  if(isPlayer(potentialtarget)) {
    if(issharedfuncdefined("player", "isReallyAlive") && ![[getsharedfunc("player", "isReallyAlive")]](potentialtarget)) {
      return false;
    }

    if(istrue(potentialtarget.var_f6f8549c6fd27e85)) {
      return false;
    }

    if(self.team == "axis" && function_eac0cd99c9c6d8ee() == "hidden") {
      if(isDefined(self.var_5af42ba05a97de9a) && distancesquared(potentialtarget.origin, self.origin) > self.var_5af42ba05a97de9a) {
        return false;
      }
    }
  }

  if(!function_f391d89f9a5bcd21(potentialtarget)) {
    return false;
  }

  if(distance2dsquared(self.origin, potentialtarget.origin) > self.var_52edc18a611b938d) {
    return false;
  }

  if(!sentry_canseetarget(potentialtarget)) {
    return false;
  }

  if(isDefined(self.var_f4e212847c7e4497)) {
    if(![[self.var_f4e212847c7e4497]](potentialtarget)) {
      return false;
    }
  }

  return true;
}

function function_8a65ef9c60082965(turret, callback) {
  turret.var_f4e212847c7e4497 = callback;
}

function function_b5d0a038b8a18782(besttarget) {
  if(!isDefined(besttarget)) {
    return false;
  }

  start_tag = self.trace_tag;

  if(distancesquared(self gettagorigin(start_tag), besttarget.origin) > self.var_52edc18a611b938d) {
    return false;
  }

  if(!function_1d3253884542b0e6(besttarget)) {
    return false;
  }

  if(!besttarget.var_7b4128fcb5718032) {
    return false;
  }

  return true;
}

function function_f391d89f9a5bcd21(potentialtarget) {
  if(within_fov(self.origin, self.angles, potentialtarget.origin, cos(self getleftarc()))) {
    return true;
  }

  return false;
}

function sentry_canseetarget(potentialtarget) {
  if(isPlayer(potentialtarget)) {
    targetpoints = ["J_Spine4", "j_head"];
  } else {
    targetpoints = ["j_head", "j_mainroot", "tag_origin"];
  }

  canseetarget = 0;

  if(!isalive(potentialtarget)) {
    return 0;
  }

  if(!isDefined(potentialtarget.model)) {
    return 0;
  }

  start_tag = self.trace_tag;
  contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);

  if(isPlayer(potentialtarget)) {
    return can_trace_to_player(self gettagorigin(start_tag), undefined, contentsoverride);
  }

  foreach(point in targetpoints) {
    if(!potentialtarget tagexists(point)) {
      continue;
    }

    targettrace = trace::ray_trace(self gettagorigin(start_tag), potentialtarget gettagorigin(point), self);

    if(isDefined(targettrace["entity"]) && targettrace["entity"] == potentialtarget) {
      canseetarget = 1;
      break;
    }
  }

  return canseetarget;
}

function function_30b63fb2cbf3dec7() {
  self.state = "lost_LOS";
  start_tag = self.trace_tag;

  if(!isDefined(self.targetent)) {
    loc = self gettagorigin("tag_laser") + anglesToForward(self gettagangles(self.trace_tag)) * 300;
    self.targetent = spawn("script_model", loc);
    self.targetent setModel("tag_origin");
  }

  loc = self gettagorigin(self.trace_tag) + anglesToForward(self gettagangles(self.trace_tag)) * 3000;
  self.targetent.origin = loc;
  self.targetent dontinterpolate();
  self.curtarget = self.targetent;
  self settargetentity(self.targetent);
}

function sentry_disable() {
  self notify("stop_idle_movement");
  self notify("stop_sentry_complex_think");
  function_c2659db9dbffda55(self.var_3c19d396e8243a45, 0.25, "fwd");
  self cleartargetentity();
  self turretfiredisable();
  self setdefaultdroppitch(30);
  self setmode("sentry_offline");
  self laseroff();
  self setscriptablepartstate("hack_usable", "off");
  self setscriptablepartstate("lights", "off");
  scripts\engine\sp\utility::set_ignoreme(1);
}

function function_b1b8ae9d6488b9d9(instance, part, state, player, bautouse, usestring) {
  if(!isDefined(instance) || instance.type != "ks_sentry_turret_jup_sp") {
    return;
  }

  instance.entity notify("hacked");
}

function function_e8e2437f35d7473a() {}

function function_39fe1a402b4febad(n_tries, n_delay) {
  level.player endon("death");

  if(utility::flag("game_saving")) {
    return true;
  }

  level.player notify("attempt_combat_autosave");
  level.player endon("attempt_combat_autosave");
  n_tries = utility::default_to(n_tries, 5);
  n_delay = utility::default_to(n_delay, 3);

  for(i = 0; i < n_tries; i++) {
    if(!function_b5d4d57174da3118()) {
      autosave_by_name_silent();
    }

    level utility::flag_wait_or_timeout("game_saving", n_delay);

    if(level utility::flag("game_saving")) {
      return true;
    }

    waitframe();
  }

  return false;
}

function function_837bb2142379dbfb(state) {
  if(!isDefined(state)) {
    state = "default";
  }

  switch (state) {
    case #"hash_a25aba0197cd06fa":
      suit = "iw9_creep_montage";
      movespeed = 85;
      break;
    case #"hash_1a53266c17b7d481":
      suit = "iw9_cqb_montage";
      movespeed = 115;
      break;
    case #"hash_7038dec66d8275be":
    default:
      suit = "jup_defaultsuit_sp";
      movespeed = 150;
      break;
  }

  level.player.movementstate = state;
  level.player setsuit(suit);
  player_speed_set(movespeed, 0.5);
}

function function_f17936d9b1dcf462() {}

function function_87a70036926b2c90(notify_progress) {
  level.player_progress_monitor notify(notify_progress);
}

function function_d962f42ac75f265f(var_c3f43fc9f06f8bb9) {
  level.player_progress_monitor.b_active = 0;
  level.player_progress_monitor notify("stop_player_progress_monitor");
  level utility::flag_set(var_c3f43fc9f06f8bb9);
}

function function_91db77148cb4384d(var_71a9862cb77fa423, var_5869eaace1a90f, var_c3f43fc9f06f8bb9, notify_progress, var_a2e2d67a54ba15da) {
  if(!isDefined(var_71a9862cb77fa423)) {
    var_71a9862cb77fa423 = 60;
  }

  if(!isDefined(var_5869eaace1a90f)) {
    var_5869eaace1a90f = 10;
  }

  if(!isDefined(var_a2e2d67a54ba15da)) {
    var_a2e2d67a54ba15da = 1;
  }

  level.player endon("death");

  if(!isDefined(level.player_progress_monitor)) {
    level.player_progress_monitor = spawnStruct();
  }

  level.player_progress_monitor notify("stop_player_progress_monitor");
  level.player_progress_monitor endon("stop_player_progress_monitor");
  level.player_progress_monitor.b_active = 1;
  level utility::flag_clear(var_c3f43fc9f06f8bb9);

  while(istrue(level.player_progress_monitor.b_active)) {
    waitframe();

    if(!istrue(level.player_progress_monitor.b_active)) {
      return;
    }

    if(istrue(var_a2e2d67a54ba15da)) {
      if(function_b5d4d57174da3118()) {
        wait 3;
        continue;
      }
    }

    level.player scripts\engine\sp\objectives::focus_display_hint(var_5869eaace1a90f, var_71a9862cb77fa423, [level.player_progress_monitor], [notify_progress, "stop_player_progress_monitor", "display_hint_end"]);
    level.player_progress_monitor thread function_6cedc4cc37bcadcd(notify_progress);

    if(istrue(var_a2e2d67a54ba15da)) {
      level.player_progress_monitor thread function_817fed19567fbc58(notify_progress);
    }

    level.player_progress_monitor waittill_any(notify_progress, "stop_player_progress_monitor", "display_hint_end");
  }
}

function function_6cedc4cc37bcadcd(notify_progress) {
  level.player endon("death");
  self endon(notify_progress);
  self endon("display_hint_end");
  self endon("stop_player_progress_monitor");
  utility::waittill_any_ents(level.player, "focus_pressed", level, "objectives_updated", level, "player_linked_to_rig");
  self notify("display_hint_end");
}

function function_817fed19567fbc58(notify_progress) {
  level.player endon("death");
  self endon(notify_progress);
  self endon("display_hint_end");
  self endon("stop_player_progress_monitor");

  while(istrue(self.b_active)) {
    if(function_b5d4d57174da3118()) {
      self notify("display_hint_end");
      break;
    }

    wait 1;
  }
}

function function_b5d4d57174da3118(var_c62dac3fc0db5437, var_12cbcf4aa16edc05, var_8b48d789d12a4cad, n_lastknowntime) {
  var_c62dac3fc0db5437 = utility::default_to(var_c62dac3fc0db5437, 1);
  var_12cbcf4aa16edc05 = utility::default_to(var_12cbcf4aa16edc05, 1);

  if(istrue(var_c62dac3fc0db5437) && !level.player scripts\sp\player::hasmaxhealth()) {
    return true;
  }

  if(istrue(var_12cbcf4aa16edc05) && getaiarrayinradius(level.player.origin, 256, "axis").size > 0) {
    return true;
  }

  if(isDefined(var_8b48d789d12a4cad)) {
    a_ai_enemies = getaiarrayinradius(level.player.origin, var_8b48d789d12a4cad, "axis");
  } else {
    a_ai_enemies = getaiarray("axis");
  }

  n_lastknowntime = utility::default_to(n_lastknowntime, 10);
  var_5fad62b5daef4cd9 = utility::function_a5b14435e3229bed(n_lastknowntime);

  foreach(ai in a_ai_enemies) {
    if(isDefined(ai) && isalive(ai)) {
      if(isDefined(ai.enemy) && isPlayer(ai.enemy) && gettime() - ai lastknowntime(level.player) < var_5fad62b5daef4cd9) {
        return true;
      }
    }
  }

  return false;
}

function function_ed427b0f366f0e70() {}

function ammo_refill() {
  structs = getStructArray("ammo_refill", "targetname");

  foreach(struct in structs) {
    thread function_746e6c393034988e(struct);
  }
}

function function_746e6c393034988e(struct) {
  level.player endon("death");
  level endon("game_ended");

  while(true) {
    struct scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 0), &"PRISON/REFILL_AMMO", 360, 700, 80, 0);
    struct waittill("trigger");
    curr_weapons = level.player getweaponslistprimaries();

    if(curr_weapons.size > 0) {
      thread play_sound_in_space("player_refill_all_ammo", struct.origin);
      level.player forceplaygestureviewmodel("iw9_ges_pickup");
    }

    foreach(weapon in curr_weapons) {
      if(isDefined(weapon.basename)) {
        if(weapon.basename != "iw9_la_mike32_sp" && weapon.basename != "iw9_la_rpapa7_sp") {
          level.player givemaxammo(weapon);
        }
      }
    }

    wait 8;
  }
}

function function_dd1e9c5c619bb9fd() {}

function function_7858124c75557961(var_dc2535ce2899b440) {
  if(!isDefined(var_dc2535ce2899b440)) {
    var_dc2535ce2899b440 = 1;
  }

  var_83b145905200e37b = getEnt("chunnel_vents_l_vent_blade", "targetname");
  var_c55fa354e46f3aec = getEnt("chunnel_vents_r_vent_blade", "targetname");

  if(isDefined(var_83b145905200e37b)) {
    if(var_dc2535ce2899b440) {
      var_1b76144be576a4df = [var_83b145905200e37b, var_c55fa354e46f3aec];
      level thread function_fd43fa8fea0de0bb("flg_chunnel_crossover_open_door", var_1b76144be576a4df);
      return;
    }

    var_83b145905200e37b hide();
    var_c55fa354e46f3aec hide();
  }
}

function function_fd43fa8fea0de0bb(flg_cleanup, var_1b76144be576a4df) {
  var_1b76144be576a4df[0] thread function_53f9412a5031cf7a(flg_cleanup);
  var_1b76144be576a4df[1] thread function_53f9412a5031cf7a(flg_cleanup);
}

function function_53f9412a5031cf7a(flg_cleanup) {
  linked_ent = spawn_tag_origin(self.origin, self.angles);
  self linkTo(linked_ent);
  og_angles = self.angles;

  while(!flag(flg_cleanup)) {
    if(flag("flg_ventilation_train_is_active")) {
      self rotatebylinked((0, -15, 0), 0.05);
    } else {
      self rotatebylinked((0, -15, 0), 0.05);
    }

    wait 0.1;
  }

  self unlink();
  linked_ent delete();
  self delete();
}

function function_68b6e53e38036c88(msg, flg_end) {
  if(!isDefined(flg_end)) {
    flg_end = "flg_chunnel_crossover_open_door";
  }

  level endon(flg_end);

  while(true) {
    level waittill("notify_ventilation_train_is_active");
    flag_set("flg_ventilation_train_is_active");
    wait 3;
    flag_clear("flg_ventilation_train_is_active");
  }
}

function function_12b0b3e271bd01af() {}

function function_75518fdf13f7d5c0(flg_end) {
  level endon(flg_end);
  self waittill("damage", attacker);

  if(isPlayer(attacker)) {
    scripts\sp\player_death::set_custom_death_quote(410);
    missionfailedwrapper();
  }
}

function function_4490790f7cba8b2b() {}

function function_67f411b123f0cf9(var_bad0af3247d43c5a, var_67a0cfb4f5430f65) {
  var_4df9c07e255f1a81 = ["", "", "", ""];

  foreach(i_order in var_bad0af3247d43c5a) {
    var_4df9c07e255f1a81[index] = var_67a0cfb4f5430f65[i_order];
  }

  return var_4df9c07e255f1a81;
}

function function_45a191c0ccc354f0(var_b7ecab22e4d26d5c) {
  level endon("flg_bomb_puzzle_search_timeout");
  var_f04850fc36886138 = 0;
  var_d1d1fcfc1fac5c9c = 0.3;
  level.player thread function_b298a3a936309df9();

  while(!flag(var_b7ecab22e4d26d5c)) {
    if(within_fov(level.player getEye(), level.player getplayerangles(), self.origin, 0.965926)) {
      var_f04850fc36886138 += 0.1;

      if(var_f04850fc36886138 >= var_d1d1fcfc1fac5c9c) {
        level.player flag_set("flg_bomb_puzzle_spotted");
        flag_set("flg_snake_cam_second_reminder_done");
        break;
      }
    } else {
      var_f04850fc36886138 = 0;
    }

    wait 0.1;
  }
}

function function_b298a3a936309df9() {
  level endon("flg_bomb_puzzle_spotted");
  i_countdown = 10;

  while(i_countdown > 0) {
    i_countdown--;

    if(i_countdown == 2) {}

    wait 1;
  }

  flag_set("flg_bomb_puzzle_search_timeout");
}

function function_ca3658dc7eec62ae() {
  var_e6de0769c5ab908 = level.player usinggamepad();

  if(var_e6de0769c5ab908) {
    if(level.player getrightstickx() != 0 || level.player getrightsticky() != 0) {
      wait 2;
      return true;
    }
  } else {
    movement = level.player getnormalizedcameramovement();

    if(movement[0] != 0 || movement[1] != 0) {
      wait 2;
      return true;
    }
  }

  return false;
}

function function_22556c65fe565a() {
  self endon("trigger");
  flag_wait("flg_snakecam_first_enter_timeout");
  function_a1c022294a6077d3();
}

function function_8579a9944d0496ed() {}

function function_218ab5174228dd97() {
  self.animname = "camp_garageDoor1";
  setanimtree();
  function_dca9a0b3ede68c2f();
}

function function_dca9a0b3ede68c2f() {
  level thread function_83a4116145944b3e();
  self notsolid();
  anim_single_solo(self, "camp_garageDoorOpen");
}

function function_83a4116145944b3e() {
  clip = getEnt("garage_door_clip", "targetname");
  clip movez(120, 3.8, 2);
  wait 3;
  clip connectpaths();
}

function function_1847045442fe1eb8(s_crossover_garage_door_interact_ref) {
  var_ed1da717d64eafc3 = spawn_tag_origin(s_crossover_garage_door_interact_ref.origin, s_crossover_garage_door_interact_ref.angles);
  var_ed1da717d64eafc3 scripts\sp\player\cursor_hint::create_cursor_hint("tag_origin", (0, 0, 0), &"SP_JUP_SURGE/CROSSOVER_GARAGE_DOOR", undefined, undefined, 48, undefined, undefined, undefined, undefined, undefined, undefined, 1, 30, 45);
  var_ed1da717d64eafc3 waittill("trigger");
  registered = "button_press_gesture";
  level.player val::set(registered, "freezecontrols", 1);
  level.player val::set(registered, "freezecontrols_allowlook", 1);
  level.player setstance("stand", 1, 1);
  var_f5648c76ae351ca6 = level.player spawn_tag_origin();
  var_f5648c76ae351ca6.angles = level.player.angles;
  level.player playerlinkTo(var_f5648c76ae351ca6, "tag_origin", 1, 90, 90, 90, 90, 0);
  wait 0.3;
  var_9d21e381e44ee6ab = s_crossover_garage_door_interact_ref.origin - (-51482.3, 58177.7, 85);
  var_f3a83342964f5988 = vectortoangles(var_9d21e381e44ee6ab);
  var_f5648c76ae351ca6 moveTo((-51482.3, 58177.7, 32), 0.3, 0.2, 0.1);
  var_f5648c76ae351ca6 rotateTo(var_f3a83342964f5988, 0.3);
  wait 0.4;
  var_9d21e381e44ee6ab = s_crossover_garage_door_interact_ref.origin - level.player getEye();
  var_f3a83342964f5988 = vectortoangles(var_9d21e381e44ee6ab);
  level.player setplayerangles(var_f3a83342964f5988);
  level thread namespace_85a51fd192b9a590::function_8f124209027f31a8();
  level.player forceplaygestureviewmodel("jup_ges_button_press_01");
  wait 0.5;
  level thread function_912f2beecd009f47(var_f5648c76ae351ca6, registered);
}

function function_912f2beecd009f47(var_f5648c76ae351ca6, registered) {
  wait 0.5;
  level.player playerunlinkblend(0.5);
  var_f5648c76ae351ca6 delete();
  level.player val::set(registered, "freezecontrols", 0);
  level.player val::set(registered, "freezecontrols_allowlook", 0);
}

function function_df62572392db41eb() {}

function function_f2058bc826a16898(var_2c6a53a7791a89e4) {
  if(!isDefined(var_2c6a53a7791a89e4)) {
    var_2c6a53a7791a89e4 = "vfx_surge_flashlight_1";
  }

  self.flashlightfxoverridetag = "tag_accessory_left";
  self.flashlightfxoverride = var_2c6a53a7791a89e4;
}

function function_b99a3ba375ca6883() {}

function function_94411f1fbd0c4528(offhand_type, v_pos, timeout, flg_cleanup, starting_ammo) {
  if(!isDefined(offhand_type)) {
    offhand_type = "frag";
  }

  if(!isDefined(flg_cleanup)) {
    flg_cleanup = "flg_chunnel_diffuse_done";
  }

  if(!isDefined(starting_ammo)) {
    starting_ammo = 1;
  }

  if(!isDefined(level.var_f2bed7e35cc9cf32)) {
    level.var_f2bed7e35cc9cf32 = ["frag", "semtex"];
  }

  if(!isDefined(level.var_360d52dd8bbf9372)) {
    level.var_360d52dd8bbf9372 = ["flash", "smoke"];
  }

  if(!isDefined(level.var_57e67a8c8f3cb129)) {
    level.var_57e67a8c8f3cb129 = ["smoke": &"JUP_WEAPON/SMOKE_GRENADE", "semtex": &"JUP_WEAPON/SEMTEX", "flash": &"JUP_WEAPON/FLASH_GRENADE", "frag": &"JUP_WEAPON/M2FRAGGRENADE"];
  }

  if(!isDefined(level.var_9a25ff0f171aa146)) {
    level.var_9a25ff0f171aa146 = ["smoke": "offhand_1h_wm_grenade_smoke_v0", "semtex": "offhand_2h_wm_grenade_semtex_v0", "flash": "offhand_1h_wm_grenade_flash_v0", "frag": "offhand_2h_wm_grenade_frag_v0"];
  }

  if(isDefined(self.script_noteworthy)) {
    offhand_type = self.script_noteworthy;
  }

  if(isDefined(v_pos)) {
    pickup_org = getgroundposition(v_pos, 4) + (0, 0, 4);
    pickup_ang = (0, 0, 0);
  } else {
    pickup_org = default_to(self.origin, level.player getEye());
    pickup_ang = default_to(self.angles, (0, 0, 90));
  }

  switch (offhand_type) {
    case #"hash_2ab98cab4066a74e":
      unit_vector = anglesToForward(level.player.angles);
      var_9d343433765c6ad5 = getgroundposition(level.player.origin + unit_vector * 10, 4) + (0, 0, 1.5);
      var_53c4a42149d51f35 = vectortoangles(var_9d343433765c6ad5 - level.player getEye());
      pickup_org = var_9d343433765c6ad5;
      pickup_ang = var_53c4a42149d51f35;
      var_58b2f68cc2160124 = (0, 0, 4);
      break;
    default:
      if(!isDefined(self.origin)) {
        unit_vector = anglesToForward(level.player.angles);
        var_9d343433765c6ad5 = getgroundposition(level.player.origin + unit_vector * 10, 4) + (0, 0, 4);
        pickup_org = var_9d343433765c6ad5;
      }

      var_58b2f68cc2160124 = (0, 0, 0);
      break;
  }

  offhand = spawn("script_model", pickup_org);
  offhand setModel(level.var_9a25ff0f171aa146[offhand_type]);
  offhand.angles = pickup_ang;
  offhand.max_ammo = 4;
  offhand.ammo_count = starting_ammo;

  if(array_contains(level.var_f2bed7e35cc9cf32, offhand_type)) {
    offhand.var_a90d4a2b2dc5e9fe = "primaryoffhand";
  } else if(array_contains(level.var_360d52dd8bbf9372, offhand_type)) {
    offhand.var_a90d4a2b2dc5e9fe = "secondaryoffhand";
  }

  offhand thread function_f49d93bc073d5510(offhand_type, flg_cleanup, var_58b2f68cc2160124);

  if(isDefined(timeout)) {
    offhand thread delete_after_delay(timeout);
    offhand thread function_a1c022294a6077d3(timeout);
  }

  return offhand;
}

function private function_f49d93bc073d5510(offhand_type, flg_cleanup, var_58b2f68cc2160124) {
  self endon("death");
  level endon(flg_cleanup);
  level.player endon("death");

  while(true) {
    scripts\sp\player\cursor_hint::create_cursor_hint(undefined, var_58b2f68cc2160124, level.var_57e67a8c8f3cb129[offhand_type], 360, 128, 64, 0, 0, 0, undefined, "duration_short");
    self waittill("trigger");

    if(function_892459c1a60142b2(level.player.offhandinventory, offhand_type, &function_5dfe985128859da6)) {
      if(offhand_type == "smoke") {
        equiplist = level.player.offhandinventory;

        foreach(weapon in equiplist) {
          if(weapon.basename == offhand_type) {
            current_ammo = level.player getweaponammostock(weapon);
            break;
          }
        }
      } else {
        current_ammo = level.player getoffhandcurrentammo(offhand_type);
      }

      if(current_ammo < self.max_ammo) {
        playsoundatpos(level.player.origin, "weap_pickup");
        pickup_ammo = int(min(self.max_ammo, current_ammo + self.ammo_count));
        level.player give_offhand(offhand_type, pickup_ammo);
        wait 0.5;
        self delete();
        break;
      }

      continue;
    }

    dropped_loot = level.player getcurrentoffhand(self.var_a90d4a2b2dc5e9fe);
    current_ammo = level.player getoffhandcurrentammo(dropped_loot.basename);

    if(current_ammo > 0) {
      level function_94411f1fbd0c4528(dropped_loot.basename, undefined, undefined, flg_cleanup, current_ammo);
    }

    playsoundatpos(level.player.origin, "weap_pickup");
    level.player give_offhand(offhand_type, self.ammo_count);
    wait 0.05;
    self delete();
    break;
  }
}

function function_a1c022294a6077d3(delay_timer) {
  if(isDefined(delay_timer)) {
    wait delay_timer;
  }

  if(isDefined(self)) {
    scripts\sp\player\cursor_hint::remove_cursor_hint();
  }
}

function function_892459c1a60142b2(array, object, compare_function) {
  foreach(element in array) {
    if([[compare_function]](element, object)) {
      return true;
    }
  }

  return false;
}

function function_5dfe985128859da6(offhand_1, offhand_type) {
  return offhand_1.basename == offhand_type;
}

function function_791c2eb990017928() {
  var_68a50c8d798d6948 = spawnStruct();
  var_68a50c8d798d6948.origin = (-49680, 54328, 38.5);
  var_68a50c8d798d6948.angles = (0, 0, 0);
  var_68a50c8d798d6948 function_94411f1fbd0c4528();
  var_68a50c8d798d6948.origin = (-49673, 54329, 38.5);
  var_68a50c8d798d6948 function_94411f1fbd0c4528("semtex");
  var_dbd953db885febbc = utility::getStructArray("s_pickup_flash", "targetname");
  var_7c760871476912f0 = utility::getStructArray("s_pickup_frag", "targetname");
  var_7e4eacd4b564b40c = utility::getStructArray("s_pickup_semtex", "targetname");
  var_73cbc61960108ebd = utility::getStructArray("s_pickup_smoke", "targetname");
  var_fed630f666be11f4 = utility::getStructArray("s_pickup_armor_plate", "targetname");

  foreach(struct in var_dbd953db885febbc) {
    struct function_94411f1fbd0c4528("flash", undefined, undefined);
  }

  foreach(struct in var_7c760871476912f0) {
    struct function_94411f1fbd0c4528("frag", undefined, undefined);
  }

  foreach(struct in var_7e4eacd4b564b40c) {
    struct function_94411f1fbd0c4528("semtex", undefined, undefined);
  }

  foreach(struct in var_73cbc61960108ebd) {
    struct function_94411f1fbd0c4528("smoke", undefined, undefined);
  }

  foreach(struct in var_fed630f666be11f4) {
    scripts\sp\utility::function_eb4400096efae0a7(struct);
  }
}

function function_ee1ff5b3a0fdab0() {
  model = spawn_model("props_armor_pickup_light", self.origin, self.angles);
  var_bf15456a31fe0d35 = &"SHARED_HINTSTRINGS/PICKUP_ARMOR_VEST";
  scripts\sp\player\cursor_hint::create_cursor_hint(undefined, (0, 0, 6), var_bf15456a31fe0d35, 180, 100, 60, undefined, undefined, undefined, undefined, "duration_short", undefined, undefined, 180);
  thread scripts\sp\utility::function_3d10fd7b256e701e(model);
}

function function_d1badcece1bddf45() {}

function function_e5c79efcb45ced30() {
  level.player endon("leave_cam");
  og_angles = self.angles;
  minpitch = -24;
  maxpitch = 24;
  yawdeltamax = 55;
  minyaw = og_angles[1] - yawdeltamax;
  maxyaw = og_angles[1] + yawdeltamax;
  minroll = og_angles[2] - 10;
  maxroll = og_angles[2] + 10;
  ddeadzone = 20;
  dmaxroll = 10;
  var_440ebeeb83bd05a8 = 0.6;
  var_75eb1524afeb7f2b = 0.8;
  dmaxangle = 10;
  dyaw = 4;
  dpitch = 1.2;
  var_d296b0eaf4a6b00f = [0, 0];
  var_d5e6310914396ac3 = 0.2;
  var_848e35f763ce65b0 = 0.2;
  rumble_playing = 0;

  while(true) {
    currentangles = self.angles;
    currentcamangles = level.player.cam_ent.angles;
    input = level.player getnormalizedcameramovement();
    multiplier = 0;
    normalinput = (input[0], input[1], 0);
    normalinput = length(normalinput);
    inputlerprate = math::factor_value(var_848e35f763ce65b0, var_d5e6310914396ac3, normalinput);
    var_d296b0eaf4a6b00f[0] = math::lerp(var_d296b0eaf4a6b00f[0], input[0], inputlerprate);
    var_d296b0eaf4a6b00f[1] = math::lerp(var_d296b0eaf4a6b00f[1], input[1], inputlerprate);

    if(currentangles[0] > 0 && var_d296b0eaf4a6b00f[0] < 0) {
      var_13a3fd6ddfa8548f = 1 - math::normalize_value(maxpitch * var_440ebeeb83bd05a8, maxpitch, currentangles[0]);
    } else if(currentangles[0] < 0 && var_d296b0eaf4a6b00f[0] > 0) {
      var_13a3fd6ddfa8548f = math::normalize_value(minpitch, minpitch * var_440ebeeb83bd05a8, currentangles[0]);
    } else {
      var_13a3fd6ddfa8548f = 1;
    }

    if(currentangles[1] > og_angles[1] && var_d296b0eaf4a6b00f[1] < 0) {
      var_8366082d034c6132 = 1 - math::normalize_value(maxyaw - yawdeltamax * var_75eb1524afeb7f2b, maxyaw, currentangles[1]);
    } else if(currentangles[1] < og_angles[1] && var_d296b0eaf4a6b00f[1] > 0) {
      var_8366082d034c6132 = math::normalize_value(minyaw, minyaw + yawdeltamax * var_75eb1524afeb7f2b, currentangles[1]);
    } else {
      var_8366082d034c6132 = 1;
    }

    inputyaw = var_d296b0eaf4a6b00f[1] * -1;
    nextyaw = currentangles[1] + dyaw * inputyaw * var_8366082d034c6132;

    if(nextyaw > og_angles[1]) {
      multiplier = math::normalized_float_smooth_out(math::normalize_value(og_angles[1], maxyaw, nextyaw)) * -1;
    }

    if(nextyaw < og_angles[1]) {
      multiplier = 1 - math::normalized_float_smooth_in(math::normalize_value(minyaw, og_angles[1], nextyaw));
    }

    inputroll = input[1];
    nextroll = og_angles[2] + dmaxroll * multiplier;
    maxroll *= multiplier;
    nextyaw = clamp(nextyaw, minyaw, maxyaw);
    inputpitch = var_d296b0eaf4a6b00f[0] * -1;
    nextpitch = currentangles[0] + dpitch * inputpitch * var_13a3fd6ddfa8548f;
    minpitchclamp = minpitch;
    maxpitchclamp = maxpitch;
    nextpitch = clamp(nextpitch, minpitchclamp, maxpitchclamp);
    snakeangles = (nextpitch, nextyaw, nextroll);
    movementfactor = length(snakeangles - self.angles);
    movementfactor = math::normalize_value(0, 1.5, movementfactor);
    quake = math::factor_value(0, 0.105, movementfactor);
    rumble = math::factor_value(0, 0.08, movementfactor);
    volume = math::factor_value(0, 0.2, movementfactor);

    if(quake > 0.005) {
      earthquake(quake, 0.07, level.player.origin, 2000);
    }

    if(rumble > 0.0001) {
      if(!rumble_playing) {
        self.rumbleent playrumblelooponentity("steady_rumble");
        rumble_playing = 1;
      }
    } else if(rumble_playing) {
      self.rumbleent stoprumble("steady_rumble");
      rumble_playing = 0;
    }

    height = 1 - rumble;
    height *= 1000;
    self.rumbleent.origin = level.player getEye() + (0, 0, height);
    self.tempmovesoundent scalevolume(volume, 0.05);
    self.angles = snakeangles;
    nudge_spot = self.origin + anglesToForward(self.angles) * 12 + anglestoup(self.angles) * -55 + (0, 0, 3);
    level.player.cam_ent.origin = nudge_spot;
    level.player.cam_ent.angles = (self.angles[0], self.angles[1], self.angles[2]);
    wait 0.05;
  }
}

function function_9b7641928bbab4f7() {
  level endon("flg_bomb_puzzle_spotted");
  var_3c341e4cb44dcc64 = 3;

  while(!flag("flg_bomb_puzzle_spotted")) {
    var_3c341e4cb44dcc64--;

    if(var_3c341e4cb44dcc64 <= 0) {
      display_hint_forced("snake_cam_control_hint_reminder");
      break;
    }

    waitframe();
  }
}

function function_db70d81bd8375b73() {
  return flag("flg_snake_cam_second_reminder_done");
}

function function_4f589c890f9ef1a() {}

function function_1a0bd27fe203af6(var_fd3007cc6805d1dd, var_a078843598f291b8, sound_name, partname, armoramount) {
  if(damagefeedback::isheadshot(partname)) {
    ai_armor::function_758ea9f162c62fdc(sound_name, var_a078843598f291b8, armoramount);
    return;
  }

  ai_armor::function_758ea9f162c62fdc(sound_name, var_fd3007cc6805d1dd, armoramount);
}

function function_1d34bf290c26a5ac(damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon) {
  if(isPlayer(attacker)) {
    if(self.health >= self.maxhealth * 0.5) {
      function_1a0bd27fe203af6("hitveharmor", "hithelmetlight", "hit_marker_3d_lrg_armor", level.var_d43e78e513933216[partname], 3);
      return;
    }

    if(self.health >= self.maxhealth * 0.25) {
      function_1a0bd27fe203af6("hitveharmor", "hithelmetlight", "hit_marker_3d_med_armor", level.var_d43e78e513933216[partname], 2);
      return;
    }

    if(self.health >= self.maxhealth * 0.1) {
      function_1a0bd27fe203af6("hitveharmor", "hithelmetlight", "hit_marker_3d_armor", level.var_d43e78e513933216[partname]);
      return;
    }

    if(istrue(self.armorbreak)) {
      return;
    }

    function_1a0bd27fe203af6("hitveharmorbreak", "hithelmetheavybreak", "hit_marker_3d_armor_break", level.var_d43e78e513933216[partname]);
    self.armorbreak = 1;
  }
}