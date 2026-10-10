/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_2afbecd35eb577a4.gsc
*************************************************/

#using script_2117aae6deaad1a6;
#using script_220d0eb95a8fab7d;
#using script_2707474774db34b;
#using script_2d400da2610fe542;
#using script_39d11000e476a42a;
#using script_3dd5eff7593960ab;
#using script_3eebdadae1029540;
#using script_3fe26dc5c76ef6fd;
#using script_42fadda36015f142;
#using script_46c7c73b1a7e4773;
#using script_482376d10f69832c;
#using script_4c543f01345a2c04;
#using script_4e6e58ab5d96c2b0;
#using script_61afae50a53c3917;
#using script_7c0779b0e4778e4;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\damagefeedback;
#using scripts\cp_mp\interaction;
#using scripts\cp_mp\loot\common_cache;
#using scripts\cp_mp\loot\common_inventory;
#using scripts\cp_mp\loot\common_item;
#using scripts\cp_mp\utility\loot;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\mp_agent;
#using scripts\mp\mp_agent_damage;
#using scripts\mp\utility\player;
#namespace namespace_532a38821901fd4a;

function function_d173c46fc772d2cb() {
  namespace_80f13d3402b78c5d::main();
  namespace_966712bc5b6ec1aa::main();
  function_85698930b45b8e74();
  thread function_8c01b83c3500a2ea();
  thread function_845220b0418d3bbd();
  function_ebac917822c850d7();
  level.var_668566d171e33358 = &function_c5401fe9642e7274;
  level.var_5a712c9d76830012 = &function_37c77650df94d0cb;

  thread function_f6a767139db74ac6();
  thread function_fef1d8d06861537a();

  thread namespace_7380e30e250d5b2f::function_9a38b0d80b42e271();
  level.ee_screen = getStruct("ee_screen_cover_whale", "targetname");

  if(isDefined(level.ee_screen)) {
    level.ee_screen.spawned_model = spawn_model("jup_urz_electronics_tv_screen_ultra_sized_01", level.ee_screen.origin, level.ee_screen.angles);
  }

  level._effect["ee_loot_fx"] = loadfx("vfx/jup/ob/gameplay/zm/vfx_outbreak_tear_outro.vfx");
  level.var_6d298bb3b2c8bf0 = 0;
  level.boss_phase = 0;
  level.var_a4cba23c9788f32b = [];
  level.var_ad5d9c2f5d7df9b9 = spawnStruct();
  level.var_f2d34ed1ef9932b2 = 0;
  level.var_62e6cd77567f71b9 = 0;
  level.var_31cfa03a7e864f49 = 0;
  level.var_98c031b802e80cdd = [20, 25, 30, 45];
  level.var_b028bd46a017b632 = [];
  level.var_b028bc46a017b3ff = [];
  level.var_b028bb46a017b1cc = [];
  level.var_b028ba46a017af99 = [];
  level.var_ef41211931de2983 = 0;
  level.cratedropdata.heliheight = 2000;
}

function function_85698930b45b8e74() {
  level flag_init("egg_spawned");
  level flag_init("egg_destroyed");
  level flag_init("path_init");
  level flag_init("path_completed");
  level flag_init("skull_offered");
  level flag_init("drive_inserted");
  level flag_init("keyholder_killed");
  level flag_init("ee_boss_tear_used");
  level flag_init("ee_boss spawned");
  level flag_init("ee_boss_defeated");
}

function function_845220b0418d3bbd() {
  level.ee_step = undefined;

  foreach(player in level.players) {
    thread namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:x1c>");
  }

  thread function_97284cbc5061ce5();
  level.ee_step = "egg_destroyed";
  level flag_wait("egg_destroyed");

  foreach(player in level.players) {
    thread namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:x33>");
  }

  thread function_1d9c2eac50fbd87f();
  thread function_a2830c773787e6bc();
  level.ee_step = "path_completed";
  level flag_wait("path_completed");

  foreach(player in level.players) {
    thread namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:x4b>");
  }

  thread function_60a3fe190a2cfda5();
  level.ee_step = "skull_offered";
  level flag_wait("skull_offered");

  foreach(player in level.players) {
    thread namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:x64>");
  }

  thread function_88702b151fe7a891();
  level.ee_step = "drive_inserted";
  level flag_wait("drive_inserted");

  foreach(player in level.players) {
    thread namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:x7a>");
  }

  thread function_529d449595b079b9();
  level.ee_step = "keyholder_killed";
  level flag_wait("keyholder_killed");

  foreach(player in level.players) {
    thread namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:x97>");
  }

  thread function_924dba06be40ba94();
  level.ee_step = "ee_boss_tear_used";
  level flag_wait("ee_boss_tear_used");

  foreach(player in level.players) {
    thread namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:xaf>");
  }

  thread function_7ad4f4f444333373();
  thread function_85ffc61929f1e59();
  level.ee_step = "ee_boss_defeated";
  level flag_wait("ee_boss_defeated");

  foreach(player in level.players) {
    thread namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:xc7>");
  }

  thread function_e3a2f0a67b82b3a6();
}

function function_3ad63c5092770154(spawnpos, item) {
  bundle_str = "itemspawnentry:" + item;
  itembundle = getscriptbundle(bundle_str);
  ground = groundpos(spawnpos.origin);

  if(!isDefined(itembundle)) {
    return;
  }

  function_2bdc4c8cab89cef2(spawnpos.origin);
  wait 0.5;
  playFX(level._effect["ee_loot_fx"], ground);

  if(isDefined(item) && item == "ob_jup_item_thermal_phone") {
    newspawnpos = spawnpos.origin + (0, 0, 3);
    scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, newspawnpos, spawnpos.angles, 1, 1);
    return;
  }

  scripts\cp_mp\loot\common_item::function_c465d27f3f6066b4(itembundle, spawnpos.origin, spawnpos.angles, 1, 1);
}

function function_2bdc4c8cab89cef2(pos) {
  playsoundatpos(pos, "evt_ob_mrpeeks_stinger_speedway");
}

function function_9e562983fdc9d91d(player, itemref) {
  itemlootid = loot::getlootidfromref(itemref);

  if(isDefined(itemlootid) && itemlootid > 0) {
    return player common_inventory::function_4776284a348ebb6a(itemlootid);
  }

  return undefined;
}

function function_ebac917822c850d7() {
  self.var_4b54936fe6c83c7b = getStructArray("s5_rift_run_ee_mrpeeks_spawn", "targetname");

  foreach(mrpeeks_spawn in self.var_4b54936fe6c83c7b) {
    spawn_model("ob_mrp", mrpeeks_spawn.origin, mrpeeks_spawn.angles);
  }
}

function function_97284cbc5061ce5() {
  spawn_struct = getStruct("ee_spore", "targetname");

  if(isDefined(spawn_struct)) {
    var_dcf9e92f1c7034ad = spawnStruct();
    navmesh_pos = spawn_struct.origin;
    ground_pos = getgroundposition(navmesh_pos, 1);
    rayinfo = trace::ray_trace(ground_pos + (0, 0, 12), ground_pos - (0, 0, 999));
    raynormal = rayinfo["normal"];
    ee_egg = spawnscriptable("jup_ob_zombie_control_spore", ground_pos - (0, 0, 1), raynormal);
    ee_egg.shield = utility::spawn_model("jup_zm_spores_shell", ground_pos - (0, 0, 1), raynormal);
    ee_egg.shield solid();
    ee_egg.shield.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_spore_healthbar");
    ee_egg.shield.var_534e788bc498be9f = getscriptbundle(%"hash_6bab55d6fc0d95fc");
    ee_egg.shield.subclass = ee_egg.shield.var_534e788bc498be9f.name;
    ee_egg.shield setCanDamage(1);
    ee_egg.shield.health = 2000000;
    ee_egg.shield.navobstacleid = createnavobstaclebyent(ee_egg.shield);
    ee_egg thread function_6b91707dbe2e9b68(ee_egg.shield);
    ee_egg.spore_base = spawnscriptable("jup_ob_zombie_control_spore_base", ground_pos, spawn_struct.angles);
    waitframe();
    ee_egg.shield.identifier = "jup_ob_zombie_control_spore";
    ee_egg.shield.control_point = ee_egg;
    ee_egg callback::add("shield_damaged", &function_585e998258e307bf);
    ee_egg.spawn_struct = spawn_struct;
    ee_egg.var_b9cf34b729d1596e = 300;
    ee_egg.var_25c4c85795f9db01 = spawn_struct;
    ee_egg.var_f49149402765ecae = [];
    ee_egg.var_9f7b53f50c23948e = [];
    waitframe();
    ee_egg setscriptablepartstate("health", "damage_detect");
    ee_egg function_bc7b3642bad61f14();
    level flag_set("spore_spawned");
  }
}

function function_6b91707dbe2e9b68(e_shield) {
  self endon("death");
  level endon("egg_destroyed");

  while(isalive(e_shield)) {
    e_shield waittill("damage", damage, attacker, direction_vec, point, smeansofdeath, modelname, tagname, partname, idflags, weapon, sorigin, angles, normal, einflictor, eventid);
    e_shield.health = 2000000;
    thread function_4c21a3b64bc9bddf(attacker, attacker, self, damage, idflags, smeansofdeath, weapon, normal, point);
  }
}

function function_585e998258e307bf(params) {
  if(isDefined(params.instance.shield_health) && params.instance.shield_health > 0) {
    if(!isPlayer(params.eattacker)) {
      return;
    }

    params.instance.shield_health -= params.idamage;
    params.instance.var_f49149402765ecae = utility::function_6d6af8144a5131f1(params.instance.var_f49149402765ecae, params.eattacker);

    if(mp_agent_damage::function_87c3b43d00319847()) {
      mp_agent_damage::function_c54b2cc2e762c201(params.eattacker, params.instance.shield, "none", "MOD_BULLET", params.einflictor.weapon_object, int(params.idamage), undefined, 0, undefined, 0, 1);
    }

    params.eattacker damagefeedback::updatehitmarker("standard", params.instance.var_b9cf34b729d1596e <= 0, 0, 0, undefined);
    params.instance.shield setscriptablepartstate("shell_damage", "impact");

    if(params.instance.shield_health > 375 && params.instance.shield_health < 500) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_1");
    } else if(params.instance.shield_health > 250 && params.instance.shield_health < 375) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_2");
    }

    if(params.instance.shield_health > 125 && params.instance.shield_health < 250) {
      params.instance.shield setscriptablepartstate("damage_states", "damage_state_3");
    }

    if(params.instance.shield_health <= 0) {
      params.instance function_7bc2153ad42f723();
    }
  }
}

function function_bc7b3642bad61f14() {
  self endon("death");
  level endon("egg_destroyed");
  function_bf08d28dd8482004();
  self.shield.health = 2000000;
  thread function_28cbf8c510681236();
  thread function_2d68cfa44d6b9ea9();
}

function function_28cbf8c510681236() {
  self endon("death");
  level endon("egg_destroyed");
  self setscriptablepartstate("ground_vfx", "active");
  self setscriptablepartstate("pulse", "active");

  while(true) {
    if(is_equal(self.shielded_state, "inactive")) {
      playFX(level._effect["spore_pulse_red"], self.origin);
    } else {
      playFX(level._effect["spore_pulse"], self.origin);
    }

    self setscriptablepartstate("pulse_audio", "pulse");
    players = player::getplayersinradius(self.origin, 200);

    foreach(player in players) {
      var_bc8818c262ac2b04 = 10;

      if(player.health - 10 < 1) {
        var_bc8818c262ac2b04 = 10 + player.health - 10 - 1;
      }

      player dodamage(var_bc8818c262ac2b04, self.origin, player, player, "MOD_TRIGGER_HURT");
    }

    wait 10;
  }
}

function function_4c21a3b64bc9bddf(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  instance endon("death");
  level endon("egg_destroyed");

  if(!utility::is_equal(instance.type, "jup_ob_zombie_control_spore") || istrue(instance.destroyed)) {
    return;
  }

  if(eattacker scripts\common\vehicle::isvehicle()) {
    if(isPlayer(eattacker.owner)) {
      if(isDefined(self.var_56b0ebbb2acef6a6) && gettime() - self.var_56b0ebbb2acef6a6 < 2000) {
        return;
      }

      self.var_56b0ebbb2acef6a6 = gettime();
      eattacker = eattacker.owner;
    }
  }

  if(!isPlayer(eattacker) && isPlayer(eattacker.owner)) {
    eattacker = eattacker.owner;
  }

  if(isDefined(instance.shield_health) && instance.shield_health > 0) {
    playFX(level._effect["shield_impact"], shitloc, vdir);
    instance setscriptablepartstate("spore_damage", "impact_nodamage");

    if(isPlayer(eattacker)) {
      if(mp_agent_damage::function_73075c88c97d2d50() && mp_agent_damage::function_87c3b43d00319847()) {
        mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.shield, "none", smeansofdeath, objweapon, int(0), undefined, 1, undefined, 0, 0);
        eattacker damagefeedback::updatehitmarker("standard", instance.var_b9cf34b729d1596e <= 0, 0, 0, undefined);
      } else {
        eattacker damagefeedback::updatedamagefeedback("hitimmune", instance.var_b9cf34b729d1596e <= 0, 0);
      }
    }

    idamage = 0;
    instance.shield.fake_health = instance.var_b9cf34b729d1596e;
    return;
  }

  if(isDefined(instance.var_b9cf34b729d1596e)) {
    instance.var_b9cf34b729d1596e -= idamage;
    instance.shield.fake_health = instance.var_b9cf34b729d1596e;
    instance setscriptablepartstate("spore_damage", "impact");

    if(isPlayer(eattacker)) {
      instance.var_f49149402765ecae = utility::function_6d6af8144a5131f1(instance.var_f49149402765ecae, eattacker);

      if(mp_agent_damage::function_87c3b43d00319847()) {
        mp_agent_damage::function_c54b2cc2e762c201(eattacker, instance.shield, "none", smeansofdeath, objweapon, int(idamage), undefined, 0, undefined, 0, 0);
      }

      eattacker damagefeedback::updatehitmarker("standard", instance.var_b9cf34b729d1596e <= 0, 0, 0, undefined);
    }

    playFX(level._effect["spore_impact"], shitloc, vdir);

    if(instance.var_b9cf34b729d1596e <= 0) {
      instance.shield.var_1e0eb63ecb3f1e2 = 0;
      instance.destroyed = 1;

      if(isDefined(instance.shield)) {
        if(isDefined(instance.shield.navobstacleid)) {
          destroynavobstacle(instance.shield.navobstacleid);
          instance.shield.navobstacleid = undefined;
        }

        instance.shield delete();
      }

      instance setscriptablepartstate("body", "destroyed");
      instance setscriptablepartstate("ground_vfx", "disabled");

      foreach(player in level.players) {
        player setscriptablepartstate("ob_spore_fx", "spore_fx_stop");
      }

      thread function_3ad63c5092770154(instance, "ob_jup_item_thermal_phone");
      level flag_set("egg_destroyed");
      instance freescriptable();
      instance notify("death");
    }
  }
}

function function_7bc2153ad42f723() {
  self endon("death");
  level endon("egg_destroyed");
  self notify("unshielded");
  self.shield solid();
  self.shield setscriptablepartstate("damage_states", "damage_state_4");
  self.shielded_state = "inactive";
  self.shield setscriptablepartstate("shield", "destroyed");
  self setscriptablepartstate("shield", "unshielded");
  thread function_2dfdaa67105007fc();
  self.shield.var_1e0eb63ecb3f1e2 = 1;
  self.shield.var_4919d15787f01154 = 1;
  self.shield.fake_health = 300;
  self.shield.health = self.shield.fake_health;
  self.shield.max_fake_health = 300;
}

function function_bf08d28dd8482004() {
  self endon("death");
  self.shield endon("death");
  level endon("egg_destroyed");

  if(!isDefined(self.shield)) {
    return;
  }

  self notify("shielded");

  if(is_equal(self.shielded_state, "inactive")) {
    self.shield setscriptablepartstate("damage_states", "regenerate");
  }

  self.shield solid();
  self.shielded_state = "active";
  self.shield_health = 500;
  self.shield setscriptablepartstate("shield", "shielded");
  self setscriptablepartstate("shield", "shielded");
  self.shield.var_4919d15787f01154 = 0;
  self.shield.var_1e0eb63ecb3f1e2 = 0;
  self.shield.fake_health = 300;
  self.shield.max_fake_health = 300;
}

function function_2d68cfa44d6b9ea9() {
  self endon("death");
  level endon("egg_destroyed");
  self.players_nearby = player::getplayersinradius(self.origin, 200);

  while(true) {
    players = player::getplayersinradius(self.origin, 200);

    foreach(player in players) {
      if(isDefined(player)) {
        if(!utility::array_contains(self.players_nearby, player) && !is_equal(player getscriptablepartstate("ob_spore_fx"), "spore_fx_on")) {
          player setscriptablepartstate("ob_spore_fx", "spore_fx_on");
          player.nearby_spore = self;
          self.players_nearby = utility::function_6d6af8144a5131f1(self.players_nearby, player);

          if(!istrue(player.var_e23ddb97da39365)) {
            player thread function_f132cc93bd8529d3(self);
          }
        }
      }
    }

    foreach(player in self.players_nearby) {
      if(isDefined(player)) {
        if(!utility::array_contains(players, player) && !is_equal(player getscriptablepartstate("ob_spore_fx"), "spore_fx_stop")) {
          player setscriptablepartstate("ob_spore_fx", "spore_fx_stop");
          player.nearby_spore = undefined;
          self.players_nearby = utility::array_remove(self.players_nearby, player);
        }
      }
    }

    wait 0.25;
  }
}

function function_2dfdaa67105007fc() {
  self endon("death");
  level endon("egg_destroyed");
  var_9f9ce3d7aa616f07 = gettime();
  var_deedc2a699d2b4a0 = 0;

  while(true) {
    if(isarray(self.var_9f7b53f50c23948e) && is_equal(self.var_9f7b53f50c23948e.size, 0)) {
      if(istrue(var_deedc2a699d2b4a0)) {
        var_9f9ce3d7aa616f07 = gettime();
      }

      var_deedc2a699d2b4a0 = 0;
    } else {
      var_deedc2a699d2b4a0 = 1;
    }

    if(!var_deedc2a699d2b4a0 && gettime() - var_9f9ce3d7aa616f07 > 5000) {
      function_bf08d28dd8482004();
      return;
    }

    wait 1;
  }
}

function function_f132cc93bd8529d3(instance) {
  self endon("disconnect");
  instance endon("death");
  level endon("egg_destroyed");
  self.var_e23ddb97da39365 = 1;

  while(true) {
    if(!isDefined(self.nearby_spore) && is_equal(self getscriptablepartstate("ob_spore_fx"), "spore_fx_on")) {
      self setscriptablepartstate("ob_spore_fx", "spore_fx_stop");
    }

    wait 0.5;
  }
}

function function_1d9c2eac50fbd87f() {
  level endon("game_ended");
  level endon("path_completed");
  level.var_7036a0e42b79efac = function_f159c10d5cf8f0b4("ee_path_trigger", "script_noteworthy");

  foreach(player in level.players) {
    player thread function_bb9c095e9cc62727(level.var_7036a0e42b79efac);
  }

  level flag_set("path_init");
}

function function_bb9c095e9cc62727(var_7036a0e42b79efac) {
  self endon("death");
  level endon("game_ended");
  level endon("path_completed");
  var_bed2df00e9629d43 = getStruct("loot_gold_skull", "targetname");

  while(true) {
    touching = self getistouchingentities(var_7036a0e42b79efac);

    if(isDefined(touching) && touching.size > 0) {
      ent = touching[0];

      if(isDefined(self.var_4ef5dc8e136d4949)) {
        if(ent.targetname == self.var_4ef5dc8e136d4949) {
          if(ent.targetname == "ee_path_trigger_end") {
            iprintln("<dev string:xd6>");

            thread function_3ad63c5092770154(var_bed2df00e9629d43, "ob_jup_item_rr_s5_gold_skull");
            level flag_set("path_completed");
            level notify("path_completed");
          } else {
            iprintln("<dev string:xe7>");

            self.var_4ef5dc8e136d4949 = function_eaf8590c531c7eaa(ent);
            function_cd1152f887e06c8f(ent);
          }
        }
      } else if(ent.targetname == "ee_path_trigger_start") {
        iprintln("<dev string:x101>");

        self.var_4ef5dc8e136d4949 = function_eaf8590c531c7eaa(ent);
        function_cd1152f887e06c8f(ent);
      }
    }

    wait 0.1;
  }
}

function function_eaf8590c531c7eaa(touching) {
  if(isDefined(touching)) {
    foreach(vol in level.var_7036a0e42b79efac) {
      if(vol.targetname == touching.target) {
        return vol.targetname;
      }
    }
  }
}

function function_cd1152f887e06c8f(touching) {
  foreach(arrow in level.var_aa416bbe41548f1) {
    if(isDefined(arrow.target) && arrow.target == touching.targetname) {
      arrow.ee_active = 1;
    }

    if(isDefined(self.var_ba545986b929dbce) && self.var_ba545986b929dbce) {
      arrow showtoplayer(self);
    }
  }
}

function function_a2830c773787e6bc() {
  level endon("game_ended");
  level endon("path_completed");

  while(!isDefined(level.players) || !isDefined(level.players[0])) {
    waitframe();
  }

  level.var_aa416bbe41548f1 = [];
  var_bf40240e76bafb50 = getStructArray("ee_thermal_arrow", "targetname");

  foreach(var_e6be399ce64ae703 in var_bf40240e76bafb50) {
    arrow = spawn("script_model", var_e6be399ce64ae703.origin);
    arrow.angles = var_e6be399ce64ae703.angles;
    arrow setModel("sign_thermal_phone_arrow_02");
    arrow.target = var_e6be399ce64ae703.target;

    if(isDefined(var_e6be399ce64ae703.ee_active) && var_e6be399ce64ae703.ee_active == "1") {
      arrow.ee_active = 1;
    }

    level.var_aa416bbe41548f1[level.var_aa416bbe41548f1.size] = arrow;
  }
}

function function_c5401fe9642e7274(player) {
  player.var_ba545986b929dbce = 1;

  if(isDefined(level.var_aa416bbe41548f1)) {
    foreach(arrow in level.var_aa416bbe41548f1) {
      if(istrue(arrow.ee_active)) {
        arrow showtoplayer(player);
      }
    }
  }
}

function function_37c77650df94d0cb(player) {
  player.var_ba545986b929dbce = 0;

  if(isDefined(level.var_aa416bbe41548f1)) {
    foreach(arrow in level.var_aa416bbe41548f1) {
      arrow hidefromplayer(player);
    }
  }
}

function function_60a3fe190a2cfda5() {
  level.offering_ent = getStruct("whale_interact", "targetname");
  level.offering_ent.interact = scripts\cp_mp\interaction::register_interact(level.offering_ent.origin, level.offering_ent.radius, &skull_offered);
  level.offering_ent.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_3965ca3b28abb19b);
}

function function_3965ca3b28abb19b(interact, player) {
  var_39f4df36544015f2 = function_9e562983fdc9d91d(player, "jup_rr_s5_gold_skull");

  if(isDefined(var_39f4df36544015f2) && var_39f4df36544015f2 != -1) {
    return {
      #string: &"JUP_OB_S5/RIFT_MAKE_OFFERING", #type: "HINT_BUTTON"};
  }

  return {
    #string: &"", #type: "HINT_NOICON"};
}

function skull_offered(player) {
  var_39f4df36544015f2 = function_9e562983fdc9d91d(player, "jup_rr_s5_gold_skull");

  if(isDefined(var_39f4df36544015f2) && var_39f4df36544015f2 != -1) {
    var_bed2df00e9629d43 = getStruct("loot_usb_key", "targetname");
    level.ee_screen.spawned_model delete();
    player common_inventory::function_ca3bbb1070436540(var_39f4df36544015f2, 0, 0);
    thread function_3ad63c5092770154(var_bed2df00e9629d43, "ob_jup_item_rr_s5_thumb_drive");
    waitframe();
    level flag_set("skull_offered");
    level notify("skull_offered");
  }

  wait 0.5;
}

function function_88702b151fe7a891() {
  level.pc_screen = getStruct("ee_screen_cover_pc", "targetname");

  if(isDefined(level.pc_screen)) {
    level.pc_screen.spawned_model = spawn_model("jup_urz_electronics_com_pc_monitor_a", level.pc_screen.origin, level.pc_screen.angles);
  }

  level.pc_ent = getStruct("pc_interact", "targetname");
  level.pc_ent.interact = scripts\cp_mp\interaction::register_interact(level.pc_ent.origin, level.pc_ent.radius, &pc_interact);
  level.pc_ent.interact scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_cf81d4d8bf2d1e2d);
}

function function_cf81d4d8bf2d1e2d(interact, player) {
  var_3b5ddea9b264bdc9 = function_9e562983fdc9d91d(player, "jup_rr_s5_thumb_drive");

  if(isDefined(var_3b5ddea9b264bdc9) && var_3b5ddea9b264bdc9 != -1) {
    return {
      #string: &"JUP_OB_S5/RIFT_INSERT_USB", #type: "HINT_BUTTON"};
  }

  return {
    #string: &"", #type: "HINT_NOICON"};
}

function pc_interact(player) {
  var_3b5ddea9b264bdc9 = function_9e562983fdc9d91d(player, "jup_rr_s5_thumb_drive");

  if(isDefined(var_3b5ddea9b264bdc9) && var_3b5ddea9b264bdc9 != -1) {
    player common_inventory::function_ca3bbb1070436540(var_3b5ddea9b264bdc9, 0, 0);
    level.pc_screen.spawned_model delete();
    playsoundatpos(level.pc_ent.origin, "evt_ob_mrpeeks_stinger_speedway");
    waitframe();
    level flag_set("drive_inserted");
    level notify("drive_inserted");
  }
}

function function_529d449595b079b9() {
  level.keyholder_spawn = getStruct("keyholder_spawn", "targetname");
  level.keyholder_spawn.requestid = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:" + "s5_rift_run_ee_keyholder", level.keyholder_spawn.origin, level.keyholder_spawn.radius, 1, 1, 0);
  function_e4a67fe4ddca7ed5(level.keyholder_spawn.requestid, &function_6ecf0f4bc126e840, self);
}

function function_6ecf0f4bc126e840(requestid, instance, agent, ai_data) {
  agent function_65cdab0fc78aba8f(agent.origin, 1024);

  if(agent.subclass == "zombie_mangler_hvt") {
    if(!istrue(level.var_ef41211931de2983)) {
      agent.objid = namespace_c8baf39126f1ef99::function_fbd6a74053f1cb9a(%"hash_2ce5beec096323e1");
      thread namespace_c8baf39126f1ef99::function_a90a4361890d7c1d(agent, level.players, agent.objid, 108);
      level.var_ef41211931de2983 = 1;
    }

    agent scripts\common\callbacks::add("on_zombie_ai_killed", &function_bc4d10856fed7e7c);
  }
}

function function_bc4d10856fed7e7c(data) {
  namespace_c8baf39126f1ef99::function_fa14863bc660a9b5(self.objid);
  thread function_3ad63c5092770154(self, "ob_jup_item_key_tower_roof");
  level flag_set("keyholder_killed");
  level notify("keyholder_killed");
}

function function_924dba06be40ba94() {
  scripts\common\callbacks::add("ob_locked_space_unlocked", &function_803bc7e4e6635113);
}

function function_803bc7e4e6635113(params) {
  doors = getStructArray(params.scriptable.node.targetname, "targetname");

  if(isDefined(doors) && doors.size > 0) {
    foreach(door in doors) {
      if(door.script_noteworthy == "lockMe") {
        var_67c2ef0a05674606 = namespace_f6368c72597c6d90::function_c8805ad506766965(door.origin, 75, 75);
        namespace_f6368c72597c6d90::function_b092780f9ec4496e(var_67c2ef0a05674606[0]);
      }
    }
  }

  level flag_set("room_unlocked");
  level notify("room_unlocked");
}

function function_7ad4f4f444333373() {
  focusedactivity = namespace_cde84ab88f41f1a5::function_deb5a4d2a7bda5e9(level.players[0]);

  if(isDefined(focusedactivity)) {
    namespace_d886885225a713a7::function_cfc0a56c1b2b3bd8(focusedactivity, level.players[0]);
  }

  beams = getscriptablearray("contractbeam", "targetname");

  foreach(beam in beams) {
    beam setscriptablepartstate("beam", "off");
  }
}

function function_a9aa7aa769a3f546() {
  function_ee2610f7b788365();
  function_47c10ac7b6912dde();
  function_b78d24ef50998b70(0);
  reach = getStruct("ee_boss_reach", "targetname");
  structs = getStructArray("objectiveloc", "targetname");

  foreach(objective in structs) {
    objname = objective.script_noteworthy;

    if(string_starts_with(objname, "obj_lightbomb")) {
      var_11d1110a1c76035a = objective.script_noteworthy;
      level.var_a4cba23c9788f32b[var_11d1110a1c76035a] = objective;
    }
  }

  thread namespace_7cfbe143d5bda274::function_a5b76e0f5024cc9a(reach, "ee_boss_reached", reach.radius, undefined, undefined, undefined, 0);
  function_f18f39783c8cedc4(0, 0, 0);
  function_b78d24ef50998b70(0);
  thread function_6e2c1e252f16c83();
  thread function_251d71144d613d9d();
  thread namespace_7380e30e250d5b2f::function_818349e75a7a365c();

  if(getdvarint(@ "hash_a5cee77cba002dc1", 1)) {
    level.cratedropdata.heliheight = 16000;
  }

  flag_wait("ee_boss_reached");
}

function function_85ffc61929f1e59() {
  function_fe9f67aed00a33a();
  function_a9aa7aa769a3f546();
  function_1ed5091b83546ef1();
  level.var_e1ee0c91c12c017b = getdvarint(@ "hash_1fcc4adede15f666", 1);

  if(istrue(level.var_e1ee0c91c12c017b)) {
    if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
      level.boss_phase = 1;
      spawn_boss(1);
    } else {
      spawn_boss(0);
    }
  } else {
    spawn_boss(0);
  }

  function_f14e2b18d9628796();
  flag_wait("entity_spawned");

  if(istrue(level.var_e1ee0c91c12c017b)) {
    if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
      level.entity_boss ent_flag_wait("entity_spawnanim_finished");
      thread function_f81d9514815ccfcc();
    }
  }

  if(!istrue(level.var_e1ee0c91c12c017b)) {
    flag_wait("entity_phase_01_complete");
    function_820ae10ff17d59f0();
    flag_wait("entity_fakeout_complete");
    thread function_a30893b2683cb868();
    flag_wait("entity_spawned");
  }

  flag_wait("entity_defeated");
  visionsetnaked("", 3);
}

function function_251d71144d613d9d() {
  level.var_76514dbab939b739 = getEnt("boss_arena_clip", "targetname");

  if(isDefined(level.var_76514dbab939b739)) {
    level.var_76514dbab939b739 delete();
  }
}

function spawn_boss(phase) {
  level.boss_struct = getStruct("obj_destroy_entity", "script_noteworthy");

  if(phase == 0) {
    spawnloc = level.boss_struct;
    var_cdfb7f2e6c78fbb7 = "ob_contract_action_loop";
  } else if(phase == 1) {
    spawnloc = getStruct("beat_04_entityloc_phase_02_04", "targetname");

    if(!isDefined(spawnloc)) {
      spawnloc = level.boss_struct;
    }

    var_cdfb7f2e6c78fbb7 = "ob_rr_bossbattle";
  }

  if(istrue(level.var_e1ee0c91c12c017b)) {
    var_cdfb7f2e6c78fbb7 = "ob_rr_bossbattle";
  }

  level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, var_cdfb7f2e6c78fbb7);
  agent = scripts\mp\mp_agent::spawnnewagentaitype("jup_spawner_zombie_entity_rr", spawnloc.origin, spawnloc.angles, "team_two_hundred");

  if(isDefined(agent)) {
    level.entity_boss = agent;
    agent.entitydata.spawnlocation = 3;
    function_e40f7d0537ba1619(agent);
    agent ent_flag_set("entity_activate");

    if(phase == 1) {
      agent function_e1c9888a10e1798f(1);
    }
  }
}

function function_e40f7d0537ba1619(agent) {
  if(getdvarint(@ "hash_b5024b31d9ec2722", 0)) {
    iprintlnbold("<dev string:x125>");
  }

  if(istrue(level.var_e1ee0c91c12c017b)) {
    agent setoverridearchetype("default", "zombie_entity_alt");
  }

  agent function_a1005e06a26908ab();
  agent scripts\common\callbacks::add("on_zombie_ai_killed", &function_4d7d39a9cbb5a518);
  thread function_2850fff68d1d6a1(agent);
  agent thread[[level.var_f057eaa585cd99c5]]();
  agent function_e06c1d2f2d469475();
  agent function_62875d682dbc5c41();
  agent function_b7d9a5de8b7cbdcd();
  flag_set("entity_spawned");
}

function function_a30893b2683cb868() {
  level endon("game_ended");
  wait 3;
  level.boss_phase = 1;
  spawn_boss(1);
  level.entity_boss ent_flag_wait("entity_spawnanim_finished");
  thread function_f81d9514815ccfcc();
  level.entity_boss thread function_ceb14c5631503518();
}

function private function_ceb14c5631503518() {
  level endon("game_ended");
  self endon("death");

  while(!level flag("entity_defeated")) {
    ent_flag_wait("entity_not_vulnerable");
    ent_flag_wait("entity_ready_for_lightbomb");
    level function_ba1032e495c9c1ca();
    var_3eaa15f9a7737fc3 = level.var_ad5d9c2f5d7df9b9.origin;
    function_606642b946a01237("phase_02_lightbomb_pos", var_3eaa15f9a7737fc3, 64, 1);
    level.var_ad5d9c2f5d7df9b9 function_4ce64c508cf1094b();
    flag_wait("entity_phase_02_lightbomb_charged");
    function_c7311cb3f768f21e("phase_02_lightbomb_pos", 5);
    flag_set("throw_lightbomb");
    ent_flag_wait("entity_vulnerable");
  }
}

function private function_b7d9a5de8b7cbdcd() {
  for(var_771164f849f397a0 = 0; var_771164f849f397a0 < 8; var_771164f849f397a0++) {
    var_49231a100a994ca9 = undefined;

    switch (var_771164f849f397a0) {
      case 0:
        var_49231a100a994ca9 = "beat_04_lightning_main";
        break;
      case 1:
        var_49231a100a994ca9 = "beat_04_lightning_sml_01";
        break;
      case 2:
        var_49231a100a994ca9 = "beat_04_lightning_sml_02";
        break;
      case 3:
        var_49231a100a994ca9 = "beat_04_lightning_sml_03";
        break;
      case 4:
        var_49231a100a994ca9 = "beat_04_lightning_sml_04";
        break;
      case 5:
        var_49231a100a994ca9 = "beat_04_lightning_med_01";
        break;
      case 6:
        var_49231a100a994ca9 = "beat_04_lightning_med_02";
        break;
      case 7:
        var_49231a100a994ca9 = "beat_04_lightning_med_03";
        break;
    }

    scripts\engine\utility::function_f3bb4f4911a1beb2("zombie_entity", "AddIslandLocationsFromStructString", var_49231a100a994ca9);
  }
}

function private function_e06c1d2f2d469475() {
  for(var_65c64854f86704de = 1; var_65c64854f86704de <= 4; var_65c64854f86704de++) {
    scripts\engine\utility::function_f3bb4f4911a1beb2("zombie_entity", "AddTeleportLocationsFromStructString", 0, "beat_04_entityloc_phase_01_0" + var_65c64854f86704de);
  }

  spawnloc = level.boss_struct;

  if(isDefined(spawnloc)) {
    scripts\engine\utility::function_f3bb4f4911a1beb2("zombie_entity", "AddTeleportLocationsFromStruct", 0, spawnloc);
  }

  for(var_65c64854f86704de = 1; var_65c64854f86704de <= 4; var_65c64854f86704de++) {
    scripts\engine\utility::function_f3bb4f4911a1beb2("zombie_entity", "AddTeleportLocationsFromStructString", 1, "beat_04_entityloc_phase_02_0" + var_65c64854f86704de);
  }
}

function function_4d7d39a9cbb5a518(data) {
  flag_set("entity_defeated");
  flag_set("ee_boss_defeated");
  level notify("ee_boss_defeated");
}

function private function_2850fff68d1d6a1(agent) {
  level endon("game_ended");
  agent endon("death");
  agent waittill("fake_death");
  thread function_1b0c9b733beed84e(agent);
}

function private function_1b0c9b733beed84e(agent) {
  level endon("game_ended");
  agent function_59467b7569ee98ab();
  function_9b8829ab4092a7d7("ob_rift_story_s5_boss", 0);

  if(!istrue(level.var_e1ee0c91c12c017b) && isDefined(level.boss_phase) && level.boss_phase == 0) {
    level.boss_phase = 99;
    level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_contract_win");
  } else {
    function_629b56ecce32d438();
    function_1ef7a5d5735e50c();
    function_9b8829ab4092a7d7("ob_rift_story_s5_boss_elites", 0);
    level thread namespace_b3f32c8cb80b8124::function_115bd456be8e071d(level.players, "ob_rr_bossbattle_complete");
  }

  wait 3;
  level scripts\engine\utility::function_f3bb4f4911a1beb2("zombie_entity", "KillAllZombies", agent);
  function_f18f39783c8cedc4(0, 0, 0);

  if(!istrue(level.var_e1ee0c91c12c017b) && isDefined(level.boss_phase) && level.boss_phase == 99) {
    flag_set("entity_phase_01_complete");
    flag_clear("entity_spawned");
    level.boss_phase = 99;
    return;
  }

  function_3b61dc2fc60b81d7();
}

function function_820ae10ff17d59f0() {
  function_f18f39783c8cedc4(0, 0, 0);
  reward_struct = getStruct("obj_fake_rift_reward", "script_noteworthy");
  level.fake_reward_rift = spawnscriptable("jup_zm_rift_fake_reward_rift", reward_struct.origin, reward_struct.angles);
  level.fake_reward_rift setscriptablepartstate("body", "rewardcache_active");
  level.fake_reward_rift setscriptablepartstate("interact", "on");
  scripts\cp_mp\interaction::function_32645103f7520635(level.fake_reward_rift, &function_e354f5ef1f82840, undefined);
  level.fake_reward_rift scripts\cp_mp\interaction::function_e6c63f16f2258b80(&function_75d4c0944710e819);
}

function function_e354f5ef1f82840(player) {
  flag_set("entity_fakeout_complete");
  level.fake_reward_rift setscriptablepartstate("body", "rewardcache_despawn");
  level.fake_reward_rift setscriptablepartstate("interact", "off");
}

function function_75d4c0944710e819(interact, player) {
  return {
    #string: &"JUP_OB_OBJECTIVES/OBJECTIVE_REWARD_CACHE_TITLE", #type: "HINT_BUTTON"};
}

function function_e3a2f0a67b82b3a6() {
  rewardstruct = getStruct("obj_fake_rift_reward", "script_noteworthy");

  if(!isDefined(rewardstruct)) {
    rewardstruct = getStruct("beat_04_reward_rift", "targetname");
  }

  if(isDefined(rewardstruct)) {
    reward_placement = namespace_71ca15b739deab72::function_3ae7f99339b96499(rewardstruct.origin);
    a_players = level.players[0] scripts\cp_mp\utility\squad_utility::getsquadmembers();
    var_3c99a2a84c4b850f = spawnStruct();
    reward_groups = [];

    foreach(player in a_players) {
      reward_groups[reward_groups.size] = [player];

      if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
        player namespace_838b439602b3acc7::function_9db4c37d4f1415f("rift_run_hard_contract_completed", 5);
      }
    }

    namespace_e8853d3344e33cf6::function_863be9e39e19fe2f(reward_groups, reward_placement, &function_d4f845633324cb61, undefined, var_3c99a2a84c4b850f);
    var_3c99a2a84c4b850f waittill("managed_reward_cache_spawn_done", var_e10194ca6271ac0a);
    var_e10194ca6271ac0a waittill("managed_reward_cache_despawned");
  }
}

function function_d4f845633324cb61(var_f7f66a8bcca0ac73) {
  cache = spawnStruct();
  rewardlist = getdvarint(@ "hash_73cfb77eb49c943", 0) ? "ob_jup_items_contracts_riftrun_boss_hard_s5" : "ob_jup_items_contracts_riftrun_boss_normal_s5";
  var_154a4ae14524d4d6 = getdvarint(@ "hash_73cfb77eb49c943", 0) ? 5 : 4;
  items = function_bc2f4857c90f5344(rewardlist, var_154a4ae14524d4d6);
  common_cache::function_fd95ef820bb2b980(items, cache);

  if(getdvarint(@ "hash_73cfb77eb49c943", 0)) {
    common_cache::function_ff5a53c1d3232e2f(cache, 1, "ob_jup_item_weapon_ar_stango44_v5932");
  }

  return cache.contents;
}

function function_8c01b83c3500a2ea() {
  flag_wait("scriptables_ready");
  level.fog = getentitylessscriptablearray("scriptable_fog", "targetname")[0];

  if(isDefined(level.fog)) {
    level.fog setscriptablepartstate("part_raise_height", "state_scripted_default");
  }
}

function function_6e2c1e252f16c83() {
  if(isDefined(level.fog)) {
    level.fog setscriptablepartstate("part_raise_height", "state_scripted_raise");
  }

  setDvar(@ "hash_dab366f405822e6c", 0.4);
}

function function_f6a767139db74ac6() {
  level endon("<dev string:x141>");
  level utility::flag_wait("<dev string:x14f>");
  function_524af0990cc277ed("<dev string:x165>");
  setdvarifuninitialized(@ "hash_d3c20f541a5d68fb", 0);

  while(true) {
    if(getdvarint(@ "hash_a8afa937ce138b51", 0)) {
      if(isDefined(level.var_7036a0e42b79efac) && level.var_7036a0e42b79efac.size > 0 && !flag("<dev string:x187>")) {
        foreach(vol in level.var_7036a0e42b79efac) {
          if(isDefined(vol.target)) {
            next = function_f159c10d5cf8f0b4(vol.target, "<dev string:x199>");
          }

          if(isDefined(next) && next.size > 0) {
            thread draw_line_for_time(vol.origin, next[0].origin, 0, 1, 1, 0.5, "<dev string:x187>");
          }
        }
      }

      if(flag("<dev string:x187>") && !flag("<dev string:x1a7>") && isDefined(level.offering_ent)) {
        thread draw_circle(level.offering_ent.origin, level.offering_ent.radius, (0, 1, 1), 1, 0, 30);
      }

      if(flag("<dev string:x1a7>") && !flag("<dev string:x1b8>") && isDefined(level.pc_ent)) {
        thread draw_circle(level.pc_ent.origin, level.pc_ent.radius, (0, 1, 1), 1, 0, 30);
      }
    }

    if(getdvarint(@ "hash_d3c20f541a5d68fb", 0)) {
      thread function_e3a2f0a67b82b3a6();
      setDvar(@ "hash_d3c20f541a5d68fb", 0);
    }

    wait 0.5;
  }
}

function function_fef1d8d06861537a() {
  level endon("<dev string:x141>");
  level utility::flag_wait("<dev string:x14f>");
  setdvarifuninitialized(@ "hash_f402e565e17d041f", 0);

  foreach(player in level.players) {
    namespace_7cfbe143d5bda274::function_b4a6f74ffa88e0b2(player, "<dev string:x1c8>");
  }

  while(true) {
    dvar = getdvarint(@ "hash_f402e565e17d041f", 0);

    if(dvar) {
      setDvar(@ "hash_f402e565e17d041f", 0);

      if(isDefined(level.ee_step)) {
        switch (level.ee_step) {
          case #"hash_83e36919f562b022":
            function_524af0990cc277ed("<dev string:x1f1>");
            break;
          case #"hash_cc66dcb133f7e9d4":
            function_524af0990cc277ed("<dev string:x20e>");
            break;
          case #"hash_df8363a1bfcfda8a":
            level.ee_screen.spawned_model delete();
            level.offering_ent.interact makeunusable();
            function_524af0990cc277ed("<dev string:x22e>");
            break;
          case #"hash_eb11bc53b8aad464":
            level.pc_screen.spawned_model delete();
            level.pc_ent.interact makeunusable();
            break;
          case #"hash_3fe7218bb65d05be":
            function_524af0990cc277ed("<dev string:x275>");
            break;
          case #"hash_a741b1055af7da2e":
            dest = getStructArray("<dev string:x2a8>", "<dev string:x2c6>");

            for(i = 0; i < level.players.size; i++) {
              level namespace_daf861dc59373546::function_c4ab3b08781de0ed(level.players[i], undefined, dest[i]);
            }

            break;
          case #"hash_e536c48f9f278a0":
            break;
          default:
            break;
        }

        level notify(level.ee_step);
        level flag_set(level.ee_step);
      }
    }

    wait 0.5;
  }
}

function function_524af0990cc277ed(item) {
  player = level.players[0];
  forward = anglesToForward(player getplayerangles());
  drop_pos = spawnStruct();
  drop_pos.origin = player.origin + forward * 100;
  drop_pos.origin = utility::drop_to_ground(drop_pos.origin, 100) + (0, 0, 8);
  drop_pos.angles = (0, 0, 0);
  function_3ad63c5092770154(drop_pos, item);
}

# /