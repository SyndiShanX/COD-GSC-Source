/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_60145ee124b1cbd1.gsc
*************************************************/

#using scripts\anim\dialogue;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\art;
#using scripts\sp\hud_util;
#using scripts\sp\player;
#using scripts\sp\player_death;
#using scripts\sp\utility;
#namespace namespace_fd9c6daa1372e62b;

function function_7368a9e3c4ab6a56() {
  setdvarifuninitialized(@ "hash_18e8b5375bc3a359", 0);
  setdvarifuninitialized(@ "hash_f213fc40b2f63070", 0);
  setDvar(@ "hash_7a03222b5456284d", 1);
  setdvarifuninitialized(@ "hash_ef7a4f0ffc468e7b", 1);
  setdvarifuninitialized(@ "hash_6e0c4af8a30676b6", 1);
  setdvarifuninitialized(@ "hash_679a4527014d4498", 0);
  setdvarifuninitialized(@ "hash_9c267ccc7e1e2388", randomint(360));
  setdvarifuninitialized(@ "hash_277f4c8bbc3d8083", 6000);
  setdvarifuninitialized(@ "hash_86db6dd1d3fd9982", 2000);
  setdvarifuninitialized(@ "hash_c16983c2b0821bd4", 0);
  setdvarifuninitialized(@ "hash_3c74a0a5b381bbb3", 0);
  setdvarifuninitialized(@ "hash_c9238ac4cc17e116", 1);
  init_gunship_intro_anims();

  setdvarifuninitialized(@ "hash_8f3a1c1ab47f5c04", 0);
  setdevdvarifuninitialized(@ "hash_fa402c92e4148a39", 45);
  setdevdvarifuninitialized(@ "hash_f49f4fd233809e37", 0);
  setdevdvarifuninitialized(@ "hash_a59a7da9fa17c00", 0);
  setdevdvarifuninitialized(@ "hash_302d41b2b6f9d002", 0);
  setdevdvarifuninitialized(@ "hash_9a9f1499825922aa", 0);
  setdevdvarifuninitialized(@ "hash_73471de3f4780421", 0);
  setdevdvarifuninitialized(@ "hash_f2f36ad676e3835b", 0);
  setdvarifuninitialized(@ "hash_64bdd497427343e9", 0);

  setdvarifuninitialized(@ "hash_80478c6f0f12492a", 0);
  setdvarifuninitialized(@ "hash_cca85e49b724df8b", 1);
  setdvarifuninitialized(@ "hash_9adf55d0d617dfdd", 0);
  setdvarifuninitialized(@ "hash_84df9019aa255434", 1);
  precachemodel("tag_player");
  precachemodel("veh9_mil_air_gunship_sp");
  precachemodel("ks_gunship_mp_mesh");
  precachemodel("ks_gunship_mp");
  precachemodel("veh9_mil_air_gunship_sp");
  precachemodel("veh9_mil_air_gunship_gun_big");
  precachemodel("veh9_mil_air_gunship_gun_small");
  level.var_6abb43def697b42a = 800;
  level.var_6ade4ddef6be11e0 = 5000;
  level.gunship_speed["move"] = 10;
  level.gunship_speed["rotate"] = 120;

  if(!isDefined(level.var_c944986665da028e)) {
    level.var_c944986665da028e = 0;
  }

  if(!isDefined(level.var_67f5d508f1c46e99)) {
    level.var_67f5d508f1c46e99 = 1;
  }

  level.var_5a1b956578d01d46 = 2000;
  level.var_5a3ea76578f68c94 = 30000;
  level.var_6fd6cb49e3a44538 = 2000;
  level.var_1250917a0280ae9 = [];
  level.stinger_missiles = [];
  level.var_388aee5d184a98d1 = 0;

  if(!flag_exist("allow_context_sensative_dialog")) {
    flag_init("allow_context_sensative_dialog");
  }

  if(!flag("allow_context_sensative_dialog")) {
    flag_set("allow_context_sensative_dialog");
  }

  if(!flag_exist("pause_rotatePlane_thread")) {
    flag_init("pause_rotatePlane_thread");
  }

  if(!flag_exist("thermal_mode")) {
    flag_init("thermal_mode");
  }

  if(!flag_exist("should_max_ads")) {
    flag_init("should_max_ads");
  }

  flag_init("missile_pairedWithFlare");
  flag_init("missile_pairedWithBadFlare");
  flag_init("missile_FlareToSoon");
  flag_init("flare_system_busy");
  flag_init("hellfire_system_busy");
  flag_init("hellfire_missile_alive");
  flag_init("flares_enabled");
  level.gunshipqueue = [];
  function_fabfbc51d4f4143e();
  flag_init("gunship_ads_pressed");
  utility::add_hint_string("weapon_swap", &"GUNSHIP/GUNSHIP_WEAPON_SWAP", &function_f7d0edc8744d2075);
  utility::add_hint_string("weapon_ads", &"GUNSHIP/GUNSHIP_ZOOM_WEAPON", &function_f8eebce9cd61abc7);
  utility::add_hint_string("weapon_ads_hold", &"GUNSHIP/GUNSHIP_ZOOM_WEAPON_HOLD", &function_f8eebce9cd61abc7);
  utility::add_hint_string("vision_thermal", &"GUNSHIP/CHANGE_VISION_MODE", &function_fbb07165762913c);
  utility::add_hint_string("vision_color", &"GUNSHIP/CHANGE_VISION_MODE", &function_524a98c87390fffc);
  utility::add_hint_string("use_flares", &"GUNSHIP/USE_FLARES", &function_1ac07c6943264343);
  utility::add_hint_string("vehicle_ammo", &"GUNSHIP/VEHICLE_AMMO_HINT_1");
  utility::add_hint_string("player_missile_hint_1", &"SP_JUP_GUNSHIP/PLAYER_MISSILE_HINT_1");
  utility::add_hint_string("player_missile_hint_2", &"SP_JUP_GUNSHIP/PLAYER_MISSILE_HINT_2");
  utility::add_hint_string("player_missile_hint_moving", &"SP_JUP_GUNSHIP/PLAYER_MISSILE_HINT_MOVING");
  utility::add_hint_string("player_missile_hint_boost", &"SP_JUP_GUNSHIP/PLAYER_MISSILE_HINT_BOOST");
  level.var_2cb45ce35a881047 = 0;
  gunship_vfx();
}

function function_f8eebce9cd61abc7() {
  if(flag("igc_start")) {
    return 1;
  }

  if(getdvarint(@ "hash_f213fc40b2f63070") != 0) {
    return flag("gunship_ads_pressed");
  }

  return level.player isads();
}

function function_fbb07165762913c() {
  if(flag("igc_start")) {
    return 1;
  }

  return flag("thermal_mode");
}

function function_524a98c87390fffc() {
  if(flag("igc_start")) {
    return true;
  }

  return !flag("thermal_mode");
}

function function_f7d0edc8744d2075() {
  return function_f0d33fba32bd4dc2() || isDefined(level.var_d6d3568761e946c5);
}

function function_f0d33fba32bd4dc2() {
  current_weapon_name = function_878e144349832994(level.player);

  if(getdvarint(@ "hash_80478c6f0f12492a")) {
    weapon_name = level.gunship.var_d6604e5e3d0ba3b7;
  } else {
    weapon_name = level.gunship.var_d6604f5e3d0ba5ea;
  }

  if(is_equal(current_weapon_name, weapon_name)) {
    return true;
  }

  return false;
}

function function_58e9065779e30185() {
  if(level.player isads() && level.player sprintbuttonPressed()) {
    flag_set("should_max_ads");
  }

  return false;
}

function function_1ac07c6943264343() {
  if(utility::flag("igc_start")) {
    return 1;
  }

  if(utility::flag("skip_flare_hint") && !function_f0d33fba32bd4dc2()) {
    return 1;
  }

  return flag("missile_pairedWithFlare");
}

function gunship_hellfire_used() {
  if(utility::flag("igc_start")) {
    return true;
  }

  return utility::flag("gunship_hellfire_used");
}

function gunship_vfx() {
  level._effect["clouds"] = loadfx("vfx/iw9/level/gunship/vfx_gs_ac130_view_clouds.vfx");
  level._effect["gunship_flares"] = loadfx("vfx/iw9/level/gunship/vfx_gs_ac130_flares_01_v.vfx");
  level._effect["camera_spotlight"] = loadfx("vfx/iw8_mp/killstreak/vfx_ac130_ir_spotlight.vfx");
  level._effect["vfx_thermal_beacon_ai"] = loadfx("vfx/iw9/level/gunship/vfx_thermal_beacon_ai.vfx");
  level._effect["vfx_thermal_beacon_vehicle"] = loadfx("vfx/iw9/level/gunship/vfx_thermal_beacon_vehicle.vfx");
}

function function_6be6c5dc66f4a52c() {
  flag_wait("scriptables_ready");

  if(isDefined(level.gunship)) {
    assertmsg("<dev string:x1c>");
    return;
  }

  if(!isDefined(level.var_c9432be18d145ed5) && isDefined(self.radius)) {
    level.var_c9432be18d145ed5 = self.radius;
  }

  if(!isDefined(level.var_c9432be18d145ed5)) {
    level.var_c9432be18d145ed5 = 26000;
  }

  origin = self.origin;
  angles = self.angles;

  if(isDefined(level.var_b54d8a552ae8cf8a) && isvector(level.var_b54d8a552ae8cf8a)) {
    origin = level.var_b54d8a552ae8cf8a;
  }

  if(isDefined(level.var_b9c6c415d92919c8) && isvector(level.var_b9c6c415d92919c8)) {
    angles = level.var_b9c6c415d92919c8;
  }

  level.gunship = spawn("script_model", origin);
  level.gunship setModel("tag_origin");
  link = function_c39defa1b1c06412();

  if(isDefined(link) && !isarray(link)) {
    level.gunship.link = link;
  }

  level.gunship.var_10a90f7f2ccc7f03 = "gunship_scope_jup_sp";
  level.gunship.var_d6604e5e3d0ba3b7 = "gunship_105mm_sp";
  level.gunship.var_d6604d5e3d0ba184 = "gunship_40mm_jup_sp";
  level.gunship.var_d660505e3d0ba81d = "gunship_25mm_jup_sp";

  if(getdvarint(@ "hash_cca85e49b724df8b")) {
    level.gunship.var_d6604f5e3d0ba5ea = "gunship_hellfire_jup_sp";
  } else {
    level.gunship.var_d6604f5e3d0ba5ea = "gunship_hellfire_jup_sp";
  }

  if(isDefined(level.var_10a90f7f2ccc7f03)) {
    level.gunship.var_10a90f7f2ccc7f03 = level.var_10a90f7f2ccc7f03;
  }

  if(isDefined(level.var_d6604e5e3d0ba3b7)) {
    level.gunship.var_d6604e5e3d0ba3b7 = level.var_d6604e5e3d0ba3b7;
  }

  if(isDefined(level.var_d6604d5e3d0ba184)) {
    level.gunship.var_d6604d5e3d0ba184 = level.var_d6604d5e3d0ba184;
  }

  if(isDefined(level.var_d660505e3d0ba81d)) {
    level.gunship.var_d660505e3d0ba81d = level.var_d660505e3d0ba81d;
  }

  if(isDefined(level.var_d6604f5e3d0ba5ea)) {
    level.gunship.var_d6604f5e3d0ba5ea = level.var_d6604f5e3d0ba5ea;
  }

  level.physicssphereradius[level.gunship.var_d660505e3d0ba81d] = 60;
  level.physicssphereradius[level.gunship.var_d6604d5e3d0ba184] = 600;
  level.physicssphereradius[level.gunship.var_d6604e5e3d0ba3b7] = 1000;
  level.weaponreloadtime[level.gunship.var_d660505e3d0ba81d] = 2;
  level.weaponreloadtime[level.gunship.var_d6604d5e3d0ba184] = 4;
  level.weaponreloadtime[level.gunship.var_d6604e5e3d0ba3b7] = 6;
  level.weaponreloadtime[level.gunship.var_d6604f5e3d0ba5ea] = 15;
  level.weaponreloadtime["gunship_25mm_jup_sp_gunless"] = 2;
  level.gunship.var_f81a604f04ca7c67 = 30;
  level.gunship.var_3878f8cac277eba = 50;
  level.gunship.var_fe8115e13e88cccd = 100;
  level.gunship.speed = self.speed;
  level.gunship.target = self.target;
  level.gunship.script_flag_wait = self.script_flag_wait;
  level.gunship.team = self.team;
  level.gunship.targetname = self.targetname;

  if(isDefined(level.player) && isDefined(level.player.team)) {
    level.gunship.team = level.player.team;
  }

  level.gunship.name = "AC-130";

  if(isDefined(angles)) {
    level.gunship.angles = angles;
  } else {
    level.gunship.angles = (0, 115, 0);
  }

  level.gunship.owner = undefined;
  level.gunship.thermal_vision = default_to(level.var_5e05d3c963b2a5c4, "gunship_thermal_jup_sp");
  level.gunship.color_vision = default_to(level.var_7906ef78eb97fbd4, "gunship_color_jup_sp");
  level.gunship.var_b16fecb954d8b304 = [];

  if(!isDefined(level.var_f1acd9be11d8efe5)) {
    level.var_f1acd9be11d8efe5 = 1;
  }

  level.gunship.targetname = "ac130rig_script_model";
  level.gunship hide();
  level.gunshipinuse = 0;

  if(!isDefined(level.var_fb13600ef005ed60)) {
    level.var_fb13600ef005ed60 = 20;
  }

  if(!isDefined(level.var_285ce926ff345ee3)) {
    level.var_285ce926ff345ee3 = 3;
  }

  if(!isDefined(level.var_10a026b50d5be68f)) {
    level.var_10a026b50d5be68f = 3;
  }

  if(!isDefined(level.var_abebd3ab98699051) && isDefined(level.gunship_speed["rotate"])) {
    level.var_abebd3ab98699051 = level.gunship_speed["rotate"] * 2;
  } else if(!isDefined(level.var_abebd3ab98699051) && !isDefined(level.gunship_speed["rotate"])) {
    level.var_abebd3ab98699051 = 400;
  }

  if(!isDefined(level.var_ac0ee5ab988fff9f) && isDefined(level.gunship_speed["rotate"])) {
    level.var_ac0ee5ab988fff9f = level.gunship_speed["rotate"];
  } else if(!isDefined(level.var_ac0ee5ab988fff9f) && !isDefined(level.gunship_speed["rotate"])) {
    level.var_ac0ee5ab988fff9f = 200;
  }

  level.gunship.deployweaponobj = makeweapon("ks_remote_gunship_mp");
  streakinfo = spawnStruct();
  streakinfo.streakname = "gunship";
  streakinfo.owner = level.player;
  streakinfo.id = 1;
  streakinfo.lifeid = 0;
  streakinfo.score = 0;
  streakinfo.shots_fired = 0;
  streakinfo.hits = 0;
  streakinfo.damage = 0;
  streakinfo.kills = 0;

  if(isent(self)) {
    self hide();
  }

  level.player tryusegunship(streakinfo);
  level.gunship_ents = getentarrayinradius(undefined, undefined, level.player.origin, 1000);
}

function weapongivengunship(streakinfo) {
  return true;
}

#using_animtree("script_model");

function init_gunship_intro_anims() {
  level.scr_animtree["gunship"] = #animtree;
  level.scr_anim["gunship"]["gunship_intro"] = % mp_acharlie130_intro;
  level.scr_animtree["gunship"] = #animtree;
  level.scr_anim["gunship"]["gshp_acharlie130_intro_gl"] = % gshp_acharlie130_intro_gl;
  scripts\common\anim::addnotetrack_customfunction("gunship", "transition_audio", &function_b3ab43977eb50a88, "gshp_acharlie130_intro_gl");
  level.scr_anim["gunship"]["gunship_intro_alt"] = % mp_acharlie130_intro_alt;
  level.scr_anim["gunship"]["gunship_intro_long"] = % mp_acharlie130_intro_old;
  level.scr_anim["gunship"]["gunship_death"] = % mp_acharlie130_death;
  level.gunship_crashanimlength = getanimlength(level.scr_anim["gunship"]["gunship_death"]);
}

function rotateplane(toggle) {
  level notify("stop_rotatePlane_thread");
  level endon("stop_rotatePlane_thread");

  if(toggle == "on") {
    for(;;) {
      level.gunship rotateYaw(360, level.gunship_speed["rotate"]);
      level.gunship waittill("rotatedone");
      flag_waitopen("pause_rotatePlane_thread");
    }

    return;
  }

  if(toggle == "off") {
    var_208b39878dfef221 = level.gunship_speed["move"];
    rotatetime = level.gunship_speed["rotate"] / 360 * var_208b39878dfef221;
    level.gunship rotateYaw(level.gunship.angles[2] + var_208b39878dfef221, rotatetime, 0, rotatetime);
    return;
  }

  if(toggle == "off_instant") {
    var_208b39878dfef221 = 0.001;
    rotatetime = level.gunship_speed["rotate"] / 360 * var_208b39878dfef221;
    level.gunship rotateYaw(level.gunship.angles[2] + var_208b39878dfef221, rotatetime, 0, rotatetime);
    return;
  }

  if(toggle == "crash") {
    var_25bb708a7d591131 = 50;
    rotatetime = level.gunship_speed["rotate"] / 360 * var_25bb708a7d591131;
    level.gunship rotateYaw(level.gunship.angles[2] + var_25bb708a7d591131, rotatetime, rotatetime, 0);
  }
}

function function_170b254a68763ffe() {
  level.gunship endon("death");

  if(getdvarint(@ "hash_8f3a1c1ab47f5c04", 0) == 1) {
    thread function_702095380cde1053();
  }

  if(!isDefined(level.var_1ced22cd06ca90ed)) {
    level.var_1ced22cd06ca90ed = level.gunship_speed["rotate"];
  }

  for(;;) {
    if(!is_equal(level.var_1ced22cd06ca90ed, level.gunship_speed["rotate"])) {
      rotateplane("off_instant");
      level.gunship_speed["rotate"] = level.var_1ced22cd06ca90ed;
      childthread rotateplane("on");
    }

    wait 0.1;
  }
}

function moveplane(endingpos, movetime, accel, decel, var_cddbb6f644306be6) {
  level notify("stop_movePlane_thread");
  level endon("stop_movePlane_thread");
  level.gunship moveTo(endingpos, movetime, accel, decel);
  level.gunship waittill("movedone");
}

function function_9bb3d37f271d5d15(move_time, delay, ender) {
  self endon("death");

  if(isDefined(ender)) {
    self endon(ender);
  }

  while(isDefined(self)) {
    if(isint(delay)) {
      wait delay;
    }

    if(isstring(delay)) {
      level waittill(delay);
    }

    childthread moveplane((self.origin[0], self.origin[1], level.gunship.origin[2]), move_time, move_time / 3, move_time / 3, 0);
    waitframe();
  }
}

function gunship_updateoverlaycoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");
  wait 0.05;
  thread gunship_updateplanemodelcoords(plane);
  thread gunship_updateplayerpositioncoords(plane);
  thread gunship_updateaimingcoords(plane);
}

function gunship_updateplanemodelcoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");

  while(true) {
    self setclientomnvar("ui_gunship_coord1_posx", int(plane.origin[0]));
    self setclientomnvar("ui_gunship_coord1_posy", int(plane.origin[1]));
    self setclientomnvar("ui_gunship_coord1_posz", int(plane.origin[2]));
    wait 0.5;
  }
}

function gunship_updateplayerpositioncoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");
  waitframe();
  self setclientomnvar("ui_gunship_coord2_posx", int(self.origin[0]));
  self setclientomnvar("ui_gunship_coord2_posy", int(self.origin[1]));
  self setclientomnvar("ui_gunship_coord2_posz", int(self.origin[2]));
}

function gunship_updateaimingcoords(plane) {
  plane endon("death");
  plane endon("crashing");
  plane endon("leaving");
  self endon("disconnect");

  while(true) {
    starttrace = self getvieworigin();
    endtrace = starttrace + anglesToForward(self getplayerangles()) * 15000;
    endpos = physicstrace(starttrace, endtrace);
    self setclientomnvar("ui_gunship_coord3_posx", int(endpos[0]));
    self setclientomnvar("ui_gunship_coord3_posy", int(endpos[1]));
    self setclientomnvar("ui_gunship_coord3_posz", int(endpos[2]));
    wait 0.1;
  }
}

function tryusegunship(streakinfo) {
  return tryusegunshipfromstruct(streakinfo);
}

function tryusegunshipfromstruct(streakinfo) {
  self endon("disconnect");
  level endon("stop_gunship");

  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return 0;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      streakinfo notify("killstreak_finished_with_deploy_weapon");
      return 0;
    }
  }

  if(istrue(level.gunshipinuse)) {
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return 0;
  }

  result = gunship_startuse(self, streakinfo);

  if(!istrue(result)) {
    return 0;
  }

  return result;
}

function gunship_startuse(player, streakinfo) {
  level endon("missionfailed");
  function_cb0b6f2e8c19e1d3();

  if(isDefined(level.var_8349b3cc90ef4fa5)) {
    setDvar(@ "hash_9c267ccc7e1e2388", level.var_8349b3cc90ef4fa5);
  }

  level.gunshipinuse = 1;
  var_8945c22a67231e20 = 260;
  var_78ac3c5ef5263d4f = function_f411816d02e792ca(var_8945c22a67231e20, 1, 1);
  var_be20a4f36808f54c = undefined;

  if(!istrue(level.gunship_only) && !istrue(level.var_259a7e2e6fa2cbe6)) {
    setsaveddvar(@ "cg_drawcrosshair", 0);
    var_be20a4f36808f54c = gunship_playintro(player, streakinfo, var_8945c22a67231e20, var_78ac3c5ef5263d4f);

    if(!flag("userskipped") && (!isDefined(var_be20a4f36808f54c) || !var_be20a4f36808f54c)) {
      player val::reset_all("gunship");
      level.gunshipinuse = 0;

      iprintlnbold("<dev string:x47>");

      player setclientomnvar("ui_hide_hud", 0);
      setsaveddvar(@ "cg_drawcrosshair", 1);
      level.player scripts\sp\player::focusenable();
      return false;
    }
  }

  var_8945c22a67231e20 = getdvarint(@ "hash_9c267ccc7e1e2388", 90);
  var_78ac3c5ef5263d4f = function_f411816d02e792ca(var_8945c22a67231e20, 1, 0);

  if(flag("userskipped") || istrue(var_be20a4f36808f54c)) {
    player val::reset_all("gunship");
  }

  gunship = function_a26f1c542c8d41c1(player, streakinfo);

  if(!isDefined(gunship)) {
    level.gunshipinuse = 0;

    iprintlnbold("<dev string:x5d>");

    player setclientomnvar("ui_hide_hud", 0);
    player modifybasefov(65, 0.05);
    player lerpfovscalefactor(1, 0);
    setsaveddvar(@ "cg_drawcrosshair", 1);
    level.player scripts\sp\player::focusenable();
    return false;
  }

  gunship childthread function_a8317762afcda0d();

  gunship endon("stop_gunship");

  if(!istrue(level.gunship_only)) {
    gunship childthread gunship_attachgunner(player);
    gunship childthread gunship_watchthermaltoggle(player);
    gunship childthread function_8d0818a7fc70736a(player);
    gunship childthread function_2ce36c0585d34622(player);
  }

  gunship function_43d2fdf9d42cdafb(player, streakinfo, var_8945c22a67231e20, var_78ac3c5ef5263d4f);
  return true;
}

function function_2ce36c0585d34622(player) {
  var_5d4fc67421fdd83e = 0;
  var_44a957ab0b727747 = undefined;

  while(true) {
    level.stinger_missiles = array_removeundefined(level.stinger_missiles);

    if(level.stinger_missiles.size > 0) {
      danger_dist = level.var_5a3ea76578f68c94 / 1.5;

      if(isDefined(level.var_e2dedfef1129cd21)) {
        danger_dist = level.var_e2dedfef1129cd21;
      }

      foreach(missile in level.stinger_missiles) {
        if(distance(missile.origin, self.origin) < danger_dist) {
          var_5d4fc67421fdd83e = 1;
          var_44a957ab0b727747 = missile;
          break;
        }

        if(distance(missile.origin, self.origin) < level.var_5a3ea76578f68c94) {
          var_44a957ab0b727747 = missile;
          break;
        }
      }

      if(isDefined(var_44a957ab0b727747)) {
        function_aa7a73e00c80e767(var_44a957ab0b727747, var_5d4fc67421fdd83e, danger_dist, player);
      }

      var_44a957ab0b727747 = undefined;
      var_5d4fc67421fdd83e = 0;
    } else {
      function_ebd96e53d0f157ec();

      if(getomnvar("ui_veh_warning") != 0) {
        player setclientomnvarbit("ui_veh_warning", 2, 0);
      }
    }

    waitframe();
  }
}

function function_aa7a73e00c80e767(missile, var_5d4fc67421fdd83e, danger_dist, player) {
  function_ebd96e53d0f157ec();
  missile endon("death");
  missile endon("detonate");
  missile endon("entitydeleted");

  if(!missile ent_flag("missile_pairedWithFlare") && isDefined(missile)) {
    if(var_5d4fc67421fdd83e) {
      function_ebd96e53d0f157ec();
      self playLoopSound("maaws_incoming_lp");
    } else {
      childthread function_146db8f437f79c50(self, missile, danger_dist);
    }

    if(getomnvar("ui_veh_warning") == 0) {
      player setclientomnvarbit("ui_veh_warning", 2, 1);
    }

    missile ent_flag_wait("missile_pairedWithFlare");
    missile waittill("missile_is_detonating");

    if(getomnvar("ui_veh_warning") != 0) {
      player setclientomnvarbit("ui_veh_warning", 2, 0);
    }
  }
}

function function_ebd96e53d0f157ec() {
  self stoploopsound("maaws_incoming_lp");
  self stoploopsound("incoming_alarm");
}

function function_146db8f437f79c50(target, missile, danger_dist) {
  target playLoopSound("maaws_incoming_lp");
  start = gettime();

  while(isDefined(missile) && !utility::time_has_passed(start, 15)) {
    if(distance(missile.origin, target.origin) < danger_dist) {
      break;
    }

    waitframe();
  }

  target stoploopsound("maaws_incoming_lp");

  if(!missile ent_flag("missile_pairedWithFlare")) {
    sound = "incoming_alarm";
    target playLoopSound(sound);
    target childthread function_ad1aabb09778c266(sound, target, missile, danger_dist);
  }
}

function function_ad1aabb09778c266(sound, target, missile, danger_dist) {
  start = gettime();

  while(isDefined(missile) && !utility::time_has_passed(start, 10)) {
    if(distance(missile.origin, target.origin) > danger_dist) {
      break;
    }

    waitframe();
  }

  if(isDefined(target)) {
    target stoploopsound(sound);
  }

  if(getomnvar("ui_veh_warning") != 0) {
    level.player setclientomnvarbit("ui_veh_warning", 2, 0);
  }
}

function function_8d0818a7fc70736a(player) {
  while(!isDefined(self.camera)) {
    waitframe();
  }

  enable_flares(flag("flares_enabled"));
  self.flaresreservecount = 1;
  player notifyonplayercommand("flare_pressed", "+actionslot 2");
  player notifyonplayercommand("flare_pressed", "+smoke");

  while(true) {
    flag_wait("flares_enabled");
    player waittill("flare_pressed");

    if(istrue(level.debug.debug_start)) {
      continue;
    }

    if(!flag("flares_enabled")) {
      continue;
    }

    if(!flag("flare_system_busy")) {
      flag_set("flare_system_busy");
      setomnvar("ui_gunship_flares_indicators_disponibility", 0);
      self playSound("ks_ac130_flares");
      self playSound("scn_gshp_flares_lr");
      playFXOnTag(getfx("gunship_flares"), self, "tag_origin");
      wait 0.4;
      level.stinger_missiles = array_removeundefined(level.stinger_missiles);

      if(isDefined(level.stinger_missiles) && level.stinger_missiles.size > 0) {
        level.stinger_missiles childthread function_b0e2b0d4b4fa2b17(self);
      }

      scripts\engine\sp\utility::delaychildthread(5, &function_625f6b35419df61b);
      continue;
    }

    player playlocalsound("use_denial");
    wait 0.1;
  }
}

function enable_flares(enable) {
  if(istrue(enable)) {
    setomnvar("ui_gunship_flares_indicators_enable", 1);
    flag_set("flares_enabled");
    return;
  }

  setomnvar("ui_gunship_flares_indicators_enable", 0);
  flag_clear("flares_enabled");
}

function function_625f6b35419df61b() {
  flag_clear("missile_pairedWithFlare");
  flag_clear("missile_pairedWithBadFlare");
  flag_clear("missile_FlareToSoon");
  flag_clear("flare_system_busy");
  setomnvar("ui_gunship_flares_indicators_disponibility", 1);
}

function function_4f3060d359eafff3() {
  setomnvar("ui_gunship_show_flares_indicators", 1);
  setomnvar("ui_gunship_flares_indicators_disponibility", 1);
}

function function_b0e2b0d4b4fa2b17(missiletarget) {
  missiletarget.flareslive = [];
  newtarget = missiletarget flares_deploy();
  newtarget endon("death");

  foreach(missile in self) {
    missile childthread function_5b7b8790f98037fe(missiletarget, newtarget);
  }
}

function function_5b7b8790f98037fe(missiletarget, newtarget) {
  self endon("death");
  buffer = 200;

  while(true) {
    if(!isDefined(missiletarget) || missiletarget.flaresreservecount < 1) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < level.var_5a1b956578d01d46) {
      missiletarget thread gunship_playfakebodyexplosion();

      if(isDefined(self.owner) && isDefined(self.weapon_name)) {
        missiledamage = weapongetdamagemax(self.weapon_name);
        missiletarget dodamage(missiledamage, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
      }

      flag_set("missile_pairedWithBadFlare");
      ent_flag_set("missile_pairedWithBadFlare");
      return;
    } else if(curdist <= level.var_5a3ea76578f68c94 + buffer) {
      var_5252c7e4b69528e6 = 0.8;
      self missile_settargetEnt(newtarget);
      thread function_697e013714c47e57(var_5252c7e4b69528e6, newtarget);
      flag_set("missile_pairedWithFlare");
      ent_flag_set("missile_pairedWithFlare");
      return;
    } else {
      flag_set("missile_FlareToSoon");
      ent_flag_set("missile_FlareToSoon");
      wait 0.2;
    }

    waitframe();
  }
}

function function_697e013714c47e57(time, newtarget) {
  wait time;

  if(isDefined(self) && isDefined(newtarget)) {
    explosiondist = undefined;

    while(isDefined(self) && isDefined(self.origin) && isDefined(newtarget)) {
      var_282c4d28cfadaf78 = distance(self.origin, newtarget.origin);

      if(var_282c4d28cfadaf78 <= level.var_6fd6cb49e3a44538) {
        break;
      }

      waitframe();
    }

    level.stinger_missiles = array_remove(level.stinger_missiles, self);

    if(isDefined(self) && isvalidmissile(self)) {
      explosiondist = distance(self.origin, level.player.origin);
      self notify("missile_is_detonating");
      thread play_sound_in_space("sp_stinger_missile_explode", self.origin);

      if(isvalidmissile(self)) {
        self detonate();
      }

      flak_delay = explosiondist / 7000 + 0.2;
      level.player delaycall(flak_delay, &playsound, "gunship_success_flare_debris_flak");
    }

    wait 0.4;
  }

  level.gunship.model_ent function_ebd96e53d0f157ec();
}

function flares_deploy() {
  flare_life = 1.5;
  flare = spawn("script_origin", self.origin + (0, 0, -256));
  flare.angles = self.angles;
  flare movegravity((0, -1, -1), flare_life);
  self.flareslive[self.flareslive.size] = flare;
  flare thread flares_deleteaftertime(flare_life, flare_life / 2, self);

  if(self == level.gunship.model_ent) {
    level.player playSound("ks_ac130_flares");
  }

  return flare;
}

function flares_deleteaftertime(delaydelete, var_66f0721fc5bc2eb5, vehicle) {
  assertex(!isDefined(var_66f0721fc5bc2eb5) || var_66f0721fc5bc2eb5 < delaydelete, "flares_deleteAfterTime() delayDelete should never be greater than delayStopTracking.");

  if(isDefined(var_66f0721fc5bc2eb5) && isDefined(vehicle)) {
    delaydelete -= var_66f0721fc5bc2eb5;
    wait var_66f0721fc5bc2eb5;

    if(isDefined(vehicle)) {
      vehicle.flareslive = array_remove(vehicle.flareslive, self);
    }
  }

  wait delaydelete;
  self delete();
}

function function_43d2fdf9d42cdafb(owner, streakinfo, angle, anglevector) {
  gunship = self;

  if(isDefined(level.var_ad9a00890a627c58)) {
    if(isvector(level.var_ad9a00890a627c58)) {
      level.gunship.origin = level.var_ad9a00890a627c58;
    } else {
      origin = level.gunship.origin;
      level.gunship.origin = (origin[0], origin[1], level.var_ad9a00890a627c58);
    }
  }

  vector = (anglevector[0], anglevector[1], 0);
  height = level.gunship.origin[2];
  var_4bdaaa51f67cb776 = (height + level.var_c9432be18d145ed5) / 2000;
  tilt = 2 - clamp(var_4bdaaa51f67cb776, 2, 12);
  tilt_angle = (0, angle + 90, default_to(level.gunship_tilt, tilt));
  gunship linkTo(level.gunship, "tag_origin", vector, tilt_angle);
  level notify("matchrecording_plane", gunship);
  childthread rotateplane("on");
  childthread function_170b254a68763ffe();

  gunship childthread function_1481e54cdacc113c();

  gunship childthread gunship_playpilotfx(owner);

  if(istrue(level.gunship_only)) {
    if(!istrue(level.gunship_nolights)) {
      gunship childthread gunship_linklightfxent();
    }

    gunship childthread gunship_linkwingfxents();
  }

  gunship childthread gunship_trackvelocity(owner);
  gunship childthread gunship_watchdamage(owner);
}

function function_1481e54cdacc113c() {
  while(true) {
    if(getdvarint(@ "hash_18e8b5375bc3a359") == 1) {
      visionsetnaked("", 0.1);
      visionsetthermal("", 0.1);
      visionsetfadetoblack("", 0.1);
      level.player thermalvisionoff();
    }

    waitframe();
  }
}

function function_a8317762afcda0d() {
  oldvalue = getdvarint(@ "hash_9c267ccc7e1e2388");

  while(true) {
    waitframe();

    if(getdvarint(@ "hash_c16983c2b0821bd4", 90) == 0) {
      continue;
    }

    newvalue = getdvarint(@ "hash_9c267ccc7e1e2388");

    if(newvalue != oldvalue) {
      oldvalue = getdvarint(@ "hash_9c267ccc7e1e2388");
      childthread rotateplane("off_instant");
      var_78ac3c5ef5263d4f = function_f411816d02e792ca(newvalue, 1);
      vector = (var_78ac3c5ef5263d4f[0], var_78ac3c5ef5263d4f[1], 0);
      height = level.gunship.origin[2];
      var_4bdaaa51f67cb776 = (height + level.var_c9432be18d145ed5) / 2000;
      tilt = 2 - clamp(var_4bdaaa51f67cb776, 8, 28);
      tilt_angle = (0, newvalue + 90, default_to(level.gunship_tilt, tilt));
      level.gunship.model_ent linkTo(level.gunship, "tag_origin", vector, tilt_angle);
      childthread rotateplane("on");
    }
  }
}

function function_f411816d02e792ca(var_8945c22a67231e20, useradius, isintro) {
  if(istrue(isintro)) {
    radiusoffset = 10000;
  } else {
    radiusoffset = level.var_c9432be18d145ed5;
  }

  radius = radiusoffset * 5;
  xoffset = cos(var_8945c22a67231e20) * radius;
  yoffset = sin(var_8945c22a67231e20) * radius;

  if(isDefined(level.gunship_zoffset)) {
    zoffset = level.gunship_zoffset;
  } else {
    zoffset = radiusoffset;
  }

  var_78ac3c5ef5263d4f = vectorNormalize((xoffset, yoffset, zoffset));
  var_78ac3c5ef5263d4f *= zoffset;

  if(!istrue(useradius)) {
    var_78ac3c5ef5263d4f = (var_78ac3c5ef5263d4f[0], var_78ac3c5ef5263d4f[1], level.gunship.origin[2]);
  }

  if(istrue(isintro)) {
    var_78ac3c5ef5263d4f = (var_78ac3c5ef5263d4f[0], var_78ac3c5ef5263d4f[1], 12000);
  }

  return var_78ac3c5ef5263d4f;
}

function function_335c2c8510dbe11f() {
  if(!isDefined(level.sniper_overlay)) {
    overlay = newhudelem();
    overlay.x = 0;
    overlay.y = 0;
    overlay setshader("iw9_proto_drone", 640, 400);
    overlay.alignx = "center";
    overlay.aligny = "middle";
    overlay.sort = 1;
    overlay.horzalign = "center";
    overlay.vertalign = "middle";
    overlay.foreground = 1;
    overlay.lowresbackground = 0;
    overlay fadeovertime(0.01);
    overlay.alpha = 1;
    return overlay;
  }
}

function gunship_lockedoncallback() {}

function gunship_lockedonremovedcallback() {}

function gunship_playintro(player, streakinfo, angle, anglevector) {
  player endon("disconnect");
  level endon("userskipped_sky");
  thirdpersoncam = 0;

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    streakinfo notify("<dev string:x73>");
  }

  var_e4739db3b860ef4 = "gshp_acharlie130_intro_gl";

  animtype = getdvarint(@ "hash_a59a7da9fa17c00", 0);

  if(isDefined(animtype)) {
    if(animtype == 1) {
      var_e4739db3b860ef4 = "<dev string:x9a>";
    } else if(animtype == 2) {
      var_e4739db3b860ef4 = "<dev string:xac>";
    }
  }

  animname = level.scr_anim[streakinfo.streakname][var_e4739db3b860ef4];
  var_258b660f7db9aba6 = getanimlength(animname);
  intromodel = "veh9_mil_air_gunship_sp";
  level.gunship_intromodel = spawn("script_model", anglevector);
  level.gunship_intromodel setModel(intromodel);
  level.gunship_intromodel dontinterpolate();
  level.gunship_intromodel.angles = level.gunship.angles;
  level.gunship_intromodel setotherent(player);
  level.gunship_intromodel.animname = streakinfo.streakname;
  level.gunship_intromodel.owner = player;

  if(!thirdpersoncam) {
    foreach(var_6c3d15091efa3c48 in level.players) {
      if(var_6c3d15091efa3c48 != player) {
        level.gunship_intromodel hide();
      }
    }
  }

  level.gunship.origin = (level.gunship.origin[0], level.gunship.origin[1], anglevector[2]);
  level.gunship_intromodel linkTo(level.gunship, "tag_origin", (anglevector[0], anglevector[1], 0), (0, angle + 125, 0));

  if(!isDefined(level.gunship_intromodel)) {
    return false;
  }

  waitframe();
  level.gunship_intromodel scripts\common\anim::setanimtree();
  level.gunship_intromodel.scenenode = spawn("script_model", level.gunship_intromodel.origin);
  level.gunship_intromodel.scenenode dontinterpolate();
  level.gunship_intromodel.scenenode.angles = level.gunship_intromodel.angles;
  level.gunship_intromodel.scenenode setModel("tag_origin");
  level.gunship_intromodel.scenenode linkTo(level.gunship_intromodel);
  flag_waitopen("pause_gunship_intro");
  player thread function_6d92cdefdf500a8b(thirdpersoncam);
  player function_b88c89bb7cd1ab8e(level.gunship_intromodel.origin);
  player lerpfovscalefactor(0, 0);
  player modifybasefov(49, 3);
  player val::set_array("gunship", level.gunship.allows, 0);
  setomnvar("ui_hide_hud", 0);
  player::disable_player_weapon_info();
  player disablephysicaldepthoffieldscripting();
  player gunship_allowstances(0);
  player scripts\sp\player::focusdisable();

  if(!thirdpersoncam) {
    player gunship_stopshellshock();
    player cameralinkTo(level.gunship_intromodel, "tag_player", 0, 1);
    player playerlinktoabsolute(level.gunship_intromodel, "tag_player");
    player painvisionoff();
    level.gunship_intromodel setscriptablepartstate("bodyFX_intro", "on", 0);
    level.gunship_intromodel childthread gunship_queuecamerazoom(var_258b660f7db9aba6, player);

    if(scripts\engine\utility::issharedfuncdefined("gunship_sp", "introDofStart")) {
      level.gunship_intromodel thread scripts\engine\utility::function_f3bb4f4911a1beb2("gunship_sp", "introDofStart");
    } else {
      level.gunship_intromodel childthread gunship_playdofintroeffects();
    }
  }

  if(scripts\engine\utility::issharedfuncdefined("gunship_sp", "introStartLighting")) {
    level.gunship_intromodel thread scripts\engine\utility::function_f3bb4f4911a1beb2("gunship_sp", "introStartLighting");
  }

  level.gunship_intromodel.scenenode scripts\common\anim::anim_single_solo(level.gunship_intromodel, var_e4739db3b860ef4);

  if(!thirdpersoncam) {
    player disablephysicaldepthoffieldscripting();
    gunship_stopshellshock();
  }

  if(scripts\engine\utility::issharedfuncdefined("gunship_sp", "introDofEnd")) {
    level.gunship_intromodel thread scripts\engine\utility::function_f3bb4f4911a1beb2("gunship_sp", "introDofEnd");
  }

  if(!isDefined(level.gunship_intromodel)) {
    return false;
  }

  level.gunship_intromodel notify("gunship_end_intro");

  if(!thirdpersoncam) {
    player unlink();
    player cameraunlink();
  }

  level.gunship_intromodel delete();

  if(isDefined(level.var_fb13600ef005ed60)) {
    if(level.var_fb13600ef005ed60 < getdvarint(@ "hash_345d2095c9589e91")) {
      setsaveddvar(@ "hash_345d2095c9589e91", level.var_fb13600ef005ed60);
    }

    player lerpfovscalefactor(0, 0);
    player modifybasefov(level.var_fb13600ef005ed60, 0);
    player lerpfov(level.var_fb13600ef005ed60, 0);
  } else {
    if(getdvarint(@ "hash_345d2095c9589e91") < 30) {
      setsaveddvar(@ "hash_345d2095c9589e91", 30);
    }

    player lerpfovscalefactor(1, 0);
    player modifybasefov(65, 0);
    player lerpfov(65, 0);
  }

  if(scripts\engine\utility::issharedfuncdefined("gunship_sp", "introEndLighting")) {
    thread scripts\engine\utility::function_f3bb4f4911a1beb2("gunship_sp", "introEndLighting");
  }

  return true;
}

function function_6d92cdefdf500a8b(thirdpersoncam) {
  level endon("stop_userskip");
  flag_wait("userskipped");
  level notify("userskipped_sky");
  level.gunship_intromodel notify("gunship_end_intro");

  if(!thirdpersoncam) {
    self disablephysicaldepthoffieldscripting();
    gunship_stopshellshock();
    self unlink();
    self cameraunlink();
  }

  if(scripts\engine\utility::issharedfuncdefined("gunship_sp", "introDofEnd")) {
    level.gunship_intromodel thread scripts\engine\utility::function_f3bb4f4911a1beb2("gunship_sp", "introDofEnd");
  }

  if(scripts\engine\utility::issharedfuncdefined("gunship_sp", "introEndLighting")) {
    thread scripts\engine\utility::function_f3bb4f4911a1beb2("gunship_sp", "introEndLighting");
  }

  self lerpfovscalefactor(0, 0);

  if(isDefined(level.var_fb13600ef005ed60)) {
    if(level.var_fb13600ef005ed60 < getdvarint(@ "hash_345d2095c9589e91")) {
      setsaveddvar(@ "hash_345d2095c9589e91", level.var_fb13600ef005ed60);
    }

    self modifybasefov(level.var_fb13600ef005ed60, 0);
    self lerpfov(level.var_fb13600ef005ed60, 0);
  } else {
    if(getdvarint(@ "hash_345d2095c9589e91") < 30) {
      setsaveddvar(@ "hash_345d2095c9589e91", 30);
    }

    self modifybasefov(65, 0);
    self lerpfov(65, 0);
  }

  scripts\sp\utility::function_d4697f18fc3ff634();
  scripts\sp\hud_util::fade_out(0);
  thread intro_fade_in();
  thread scripts\sp\anim::letterbox_enable(0, 0);
  level notify("gunship_intro_over");
  level.player scripts\sp\player::focusenable();
  setomnvar("ui_hide_hud", 0);
  level.player utility::dof_disable_autofocus();
  level.player utility::dof_disable();
  level.player freezecontrols(0);
}

function function_1b320b4d404d17e9(alias) {
  self playSound(alias);
}

function gunship_hideintromodelonplayerconnect() {
  self endon("death");
  self.owner endon("disconnect");

  while(true) {
    level waittill("connected", player);
    self hide();
  }
}

function gunship_watchintrodisown(action, streakinfo) {
  self endon("death");
  self endon("gunship_end_intro");
  gunshipowner = level.gunship_intromodel.owner;
  gunshipowner waittill(action);

  if(action == "disconnect") {
    level.gunshipinuse = 0;
  }

  gunship_detachplayerfromintro(gunshipowner, streakinfo);
}

function gunship_detachplayerfromintro(gunshipowner, streakinfo) {
  thirdpersoncam = 0;

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(isDefined(gunshipowner) && !thirdpersoncam) {
    gunshipowner cameraunlink();
    gunshipowner gunship_stopshellshock();
    gunshipowner disablephysicaldepthoffieldscripting();
    gunshipowner painvisionon();
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
  self setscriptablepartstate("clouds_intro", "off", 0);
  self setscriptablepartstate("bodyFX_intro", "off", 0);
  self delete();
}

function gunship_startintroshake(var_e4739db3b860ef4, animlength, owner) {
  self endon("death");
  animtime = animlength;
  eqscale = 0.45;
  shaketime = 0.05;

  while(animtime > 0) {
    earthquake(eqscale, shaketime, self.origin, 5000);
    eqscale -= 0.01;

    if(eqscale <= 0.12) {
      eqscale = 0.12;
    }

    animtime -= shaketime;
    wait shaketime;
  }
}

function gunship_queuecamerazoom(animlength, player) {
  self endon("death");
  player endon("disconnect");
  level.var_e76baaf9a076d84 = getdvarfloat(@ "hash_fc7ccbeacbe663d6");
  setsaveddvar(@ "hash_fc7ccbeacbe663d6", 2.35);
  showcinematicletterboxing(0, 0);
  visionsetnaked("gunship_intro_jup_sp", 0);
  setsaveddvar(@ "sm_sunsamplesizenear", 0.85);
  setsaveddvar(@ "hash_63b517de4ccc57cd", 1);
  setsaveddvar(@ "hash_4c14e16355aa5cb0", 3);
  level.lighting = spawnStruct();
  level.lighting.var_18f0b319c1713acb = getmapsunangles();
  setsundirection(anglesToForward((-30, -140, 0)));
  wait animlength - 0.3;
  scripts\sp\utility::userskip_stop();
  scripts\sp\hud_util::fade_out(0.1);
  thread intro_fade_in();
}

function intro_fade_in() {
  wait 0.1;
  level.player painvisionoff();
  visionsetfadetoblack("");
  visionsetthermal("");
  wait 0.2;

  if(isDefined(level.lighting) && isDefined(level.lighting.var_18f0b319c1713acb)) {
    setsundirection(anglesToForward(level.lighting.var_18f0b319c1713acb));
  }

  if(isDefined(level.var_e76baaf9a076d84)) {
    setsaveddvar(@ "hash_fc7ccbeacbe663d6", level.var_e76baaf9a076d84);
  }

  hidecinematicletterboxing(0, 0);
  thread scripts\sp\hud_util::fade_in(0.1);
}

function gunship_playdofintroeffects() {
  self endon("death");
  self.owner endon("disconnect");

  while(!isDefined(level.gunship_intromodel)) {
    waitframe();
  }

  level.player utility::dof_enable_autofocus(0.75, level.gunship_intromodel, 100, undefined, undefined, "tag_origin", undefined, 1);
}

function function_a26f1c542c8d41c1(owner, streakinfo) {
  var_bc737640dd23dd18 = "veh9_mil_air_gunship_sp";
  gunship = spawn("script_model", level.gunship.origin);
  gunship.health = 9999;
  level.gunship.model_ent = gunship;
  gunship dontinterpolate();
  gunship setModel(var_bc737640dd23dd18);

  if(is_equal(var_bc737640dd23dd18, "veh9_mil_air_gunship_sp")) {
    gunship function_2f0abf268b260f94();
  }

  gunship notsolid();
  gunship.currenthealth = 1000;
  gunship.maxhealth = gunship.currenthealth;
  gunship.health = 99999;
  gunship.owner = owner;
  gunship.team = owner.team;
  gunship.timeout = 45;
  gunship.currentdamagestate = 0;
  gunship dontcastshadows();
  gunship dontcastdistantshadows();

  timeoutoverride = getdvarint(@ "hash_fa402c92e4148a39", 45);
  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    timeoutoverride = 9999;
  }

  gunship.timeout = timeoutoverride;

  gunship.flaresreservecount = 1;
  gunship.streakinfo = streakinfo;
  return gunship;
}

function function_2f0abf268b260f94() {
  weapon_big = spawn("script_model", self gettagorigin("tag_gun_big"));
  weapon_big.angles = self gettagangles("tag_gun_big");
  weapon_big setModel("veh9_mil_air_gunship_gun_big");
  thread delete_on_death(weapon_big);
  weapon_big.target_ent = spawn_script_origin();
  weapon_big.target_ent dontinterpolate();
  weapon_big notsolid();
  weapon_big dontcastshadows();
  weapon_big dontcastdistantshadows();
  thread delete_on_death(weapon_big.target_ent);
  weapon_big linkTo(self, "tag_gun_big", (4, 0, 0), (0, 0, 0));
  offset = weapon_big.origin + anglesToForward(weapon_big.angles) * 150;
  weapon_big.var_55ba759bc54f065 = spawn_tag_origin(offset, weapon_big.angles);
  weapon_big.var_55ba759bc54f065 linkTo(weapon_big, "tag_origin");
  self.weapon_big = weapon_big;
  weapon_small = spawn("script_model", self gettagorigin("tag_gun_small"));
  weapon_small.angles = self gettagangles("tag_gun_small");
  weapon_small setModel("veh9_mil_air_gunship_gun_small");
  weapon_small.target_ent = spawn_script_origin();
  weapon_small.target_ent dontinterpolate();
  weapon_small dontcastshadows();
  weapon_small dontcastdistantshadows();
  thread delete_on_death(weapon_small);
  thread delete_on_death(weapon_small.target_ent);
  weapon_small notsolid();
  weapon_small linkTo(self, "tag_gun_small", (0, -60, 0), (0, 0, 0));
  offset = weapon_small.origin + anglesToForward(weapon_small.angles) * 70;
  weapon_small.var_55ba759bc54f065 = spawn_tag_origin(offset, weapon_small.angles);
  weapon_small.var_55ba759bc54f065 linkTo(weapon_small, "tag_origin");
  thread delete_on_death(weapon_small.var_55ba759bc54f065);
  self.weapon_small = weapon_small;
  childthread function_c161dfa5d7b807ee(level.player);
}

function function_702095380cde1053(vertical_offset) {
  level notify("scr_gunship_flight_path");
  level endon("scr_gunship_flight_path");

  if(!isDefined(vertical_offset)) {
    vertical_offset = 0;
  }

  offset_base = vertical_offset;
  iterations = 20;
  time = 1;

  while(true) {
    childthread draw_line_for_time(level.gunship.origin, level.gunship.origin - (0, 0, 10000), 1, 1, 1, time);
    childthread draw_line_for_time(level.player.origin, level.gunship.origin - (0, 0, 10000), 1, 1, 1, time);

    for(i = 0; i < iterations; i++) {
      draw_circle(level.gunship.origin + (0, 0, vertical_offset), level.var_c9432be18d145ed5, (1, 1, 1), 1 - i / iterations, 1, time * 1000);
      vertical_offset += 0.5 * level.var_c9432be18d145ed5 / 80;
    }

    wait time;
    vertical_offset = offset_base;
  }
}

function gunship_attachgunner(gunner) {
  self endon("death");
  self endon("crashing");
  gunner lerpfovscalefactor(0, 0);
  level.player scripts\sp\player::focusenable();

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    gunner cameraunlink();

    if(isDefined(level.gunship_intromodel)) {
      if(isDefined(level.gunship_intromodel.scenenode)) {
        level.gunship_intromodel.scenenode delete();
      }

      level.gunship_intromodel setscriptablepartstate("<dev string:xbf>", "<dev string:xcc>", 0);
      level.gunship_intromodel setscriptablepartstate("<dev string:xd0>", "<dev string:xcc>", 0);
      level.gunship_intromodel delete();
    }

    self.streakinfo notify("<dev string:x73>");
    return;
  }

  self.currentvisionset = level.gunship.color_vision;
  waitframe();

  if(!istrue(level.var_259a7e2e6fa2cbe6)) {
    gunner cameraunlink();
  }

  if(isDefined(level.gunship_intromodel)) {
    if(isDefined(level.gunship_intromodel.scenenode)) {
      level.gunship_intromodel.scenenode delete();
    }

    level.gunship_intromodel setscriptablepartstate("clouds_intro", "off", 0);
    level.gunship_intromodel setscriptablepartstate("bodyFX_intro", "off", 0);
    level.gunship_intromodel delete();
  }

  self.contentsoverride = create_contents(0, 1, 1, 1, 1, 1, 1, 1, 1);
  function_e1ad6b2ed15830a1();

  if(isbot(gunner) || isai(gunner)) {
    gunner cameralinkTo(self.camera, "tag_player");
    return;
  }

  self hideallparts();
  self.weapon_big hideallparts();
  self.weapon_small hideallparts();
  gunner setclientomnvar("ui_killstreak_zoom_fov", level.var_fb13600ef005ed60);
  setsaveddvar(@ "cg_drawcrosshair", 0);

  if(getdvarint(@ "hash_94c408c5514d7615", 0) == 0) {
    setomnvar("ui_hide_hud", 1);
  }

  player::disable_player_weapon_info();
  level.gunship.deployweaponobj = gunner getcurrentweapon();
  gunner takeallweapons();
  weapons = [];

  if(getdvarint(@ "hash_f213fc40b2f63070") == 1) {
    weapons[weapons.size] = scripts\sp\utility::make_weapon(level.gunship.var_d660505e3d0ba81d);
    weapons[weapons.size] = scripts\sp\utility::make_weapon(level.gunship.var_d6604d5e3d0ba184);

    if(getdvarint(@ "hash_80478c6f0f12492a")) {
      weapons[weapons.size] = scripts\sp\utility::make_weapon(level.gunship.var_d6604e5e3d0ba3b7);
    } else {
      weapons[weapons.size] = scripts\sp\utility::make_weapon(level.gunship.var_d6604f5e3d0ba5ea);
    }

    self.weapon_objects = weapons;
  } else if(getdvarint(@ "hash_ef7a4f0ffc468e7b") == 1) {
    weapons[weapons.size] = gunner function_37c13ed7196514c4(level.gunship.var_d660505e3d0ba81d, 0, [level.gunship.var_10a90f7f2ccc7f03], 0, level.var_fb13600ef005ed60);
  } else {
    weapons[weapons.size] = gunner function_37c13ed7196514c4("gunship_gunless_sp", 0, [level.gunship.var_10a90f7f2ccc7f03], 0, level.var_fb13600ef005ed60);
  }

  foreach(weapon in weapons) {
    gunner scripts\sp\utility::give_weapon(weapon, 0, 0, 0, 1);

    if(getdvarint(@ "hash_f213fc40b2f63070") == 1) {
      gunner givemaxammo(weapon);
    }
  }

  gunner gunship_switchtoweaponimmediate(weapons[0]);
  function_35b96115a717f40a(gunner);

  if(getdvarint(@ "hash_f213fc40b2f63070") == 1) {
    function_b6934bb42d84da8a(gunner);
  } else {
    function_adf23ae3a7125652(gunner);
  }

  gunner childthread function_203be5da1a428ee4();
  gunner setviewangleresistance(30, 30, 15, 15);
  level notify("gunship_intro_over");
  gunner setclientomnvar("ui_killstreak_controls", 9);
  setomnvar("ui_gunship_show_bindings", 0);
  gunner setclientomnvar("ui_gunship_show_bindings", 0);
  setomnvar("ui_gunship_show_tutorial", 0);
  gunner setclientomnvar("ui_gunship_show_tutorial", 0);
  childthread function_9c33573bb832a824(gunner);
}

function function_203be5da1a428ee4() {
  level endon("stop_gunship");

  for(;;) {
    if(self isvehicleactive()) {
      self disableslowaim();
    } else if(self getlocalplayerprofiledata("gpadEnabled")) {
      var_1b76d5208a3eb6d0 = self getlocalplayerprofiledata("ViewHorzSensitivity");
      var_1b76d3208a3eb26a = self getlocalplayerprofiledata("ViewVertSensitivity");
      var_1b76d5208a3eb6d0 = math::remap(var_1b76d5208a3eb6d0, 0.6, 4, 0.6, 0.2);
      var_1b76d3208a3eb26a = math::remap(var_1b76d3208a3eb26a, 0.6, 4, 0.6, 0.2);
      self enableslowaim(var_1b76d3208a3eb26a, var_1b76d5208a3eb6d0);
    } else {
      sensitivity = self getlocalplayerprofiledata("ViewMouseHorzSensitivity");

      if(sensitivity > 5) {
        sensitivity = math::remap(sensitivity, 0.01, 99, 0.5, 0.05);
        self enableslowaim(sensitivity, sensitivity);
      } else {
        self enableslowaim(1, 1);
      }
    }

    waitframe();
  }
}

function function_37c13ed7196514c4(weapon_string, switch_to, attachments, var_1e5e00df2122415d, basefov) {
  if(istrue(var_1e5e00df2122415d)) {
    self takeallweapons();
  }

  weapon = scripts\sp\utility::make_weapon(weapon_string, attachments);

  if(isDefined(basefov)) {
    self lerpfovscalefactor(0, 0);
    self modifybasefov(basefov, 0.01);
  }

  if(istrue(switch_to)) {
    scripts\sp\utility::give_weapon(weapon, 0, 0, 0, 1);
    gunship_switchtoweaponimmediate(weapon);
  }

  return weapon;
}

function function_35b96115a717f40a(gunner) {
  gunner val::set_array("gunship", level.gunship.allows, 0);
  setsaveddvar(@ "cg_drawcrosshair", 0);
  gunner.ignoreme = 1;
  gunner enableinvulnerability();
  gunner playerdisabletriggers();
  gunner setclienttriggeraudiozone("gunship_plr_constant_low");
  gunner setsoundsubmix("iw9_sp_ac130_no_npc_weap");
  thread function_8f6f6e7db4c8a53e();
  gunner hideviewmodel();
  gunner hidelegsandshadow();
  thread scripts\sp\art::setdoftracerange(40000);
  gunner setcinematicmotionoverride("disabled");
  gunner.usinggunship = 1;
  view_clamp = [90, 90, 50, 90];

  if(isDefined(level.var_18a73555b2329261)) {
    view_clamp = level.var_18a73555b2329261;
  }

  self.camera.view_clamp = view_clamp;
  waitframe();
  gunner dontinterpolate();
  gunner.origin = self.camera.origin;
  self.camera.angles = vectortoangles(level.gunship.origin - self.camera.origin);

  if(isDefined(level.var_fb13600ef005ed60)) {
    if(level.var_fb13600ef005ed60 < getdvarint(@ "hash_345d2095c9589e91")) {
      setsaveddvar(@ "hash_345d2095c9589e91", level.var_fb13600ef005ed60);
    }

    gunner lerpfovscalefactor(0, 0);
    gunner modifybasefov(level.var_fb13600ef005ed60, 0);
    gunner lerpfov(level.var_fb13600ef005ed60, 0);
  } else {
    if(getdvarint(@ "hash_345d2095c9589e91") != 30) {
      setsaveddvar(@ "hash_345d2095c9589e91", 30);
    }

    gunner lerpfovscalefactor(1, 0);
    gunner modifybasefov(65, 0.01);
    gunner lerpfov(65, 0);
  }

  gunner childthread function_cff39111d0f3d337();
}

function function_cff39111d0f3d337() {
  for(i = 0; isalive(self); i++) {
    utility::flag_waitopen("pauseCameraFocus");
    function_b3ac309ed8d8e063();

    if(i == 5) {
      wait 1.5 + randomintrange(0, 3);
      i = 0;
      continue;
    }

    wait 1.5;
  }
}

function function_b3ac309ed8d8e063() {
  if(getdvarint(@ "hash_c9238ac4cc17e116") == 0) {
    return;
  }

  if(scripts\engine\sp\utility::isads()) {
    sway_pitch = 0.03;
    sway_roll = 0.05;
  } else {
    sway_pitch = 0.05;
    sway_roll = 0.07;
  }

  sway_pitch = randomfloatrange(0.01, sway_pitch * 5);
  sway_roll = randomfloatrange(0.01, sway_roll * 2);
  self screenshakeonentity(sway_pitch, 0, sway_roll, 2, 1, 1, 2000, randomfloatrange(0.5, 1.2));
}

function function_cb0b6f2e8c19e1d3(allows) {
  assert(isDefined(level.gunship));

  if(!isDefined(allows)) {
    if(isDefined(level.var_9c416c88d4621a0f)) {
      allows = level.var_9c416c88d4621a0f;
    } else {
      allows = ["crouch", "mantle", "melee", "prone", "offhand_weapons", "sprint", "allow_jump", "slide", "usability"];
    }
  }

  level.gunship.allows = allows;
}

function function_e1ad6b2ed15830a1() {
  focus_origin = function_abe98e26c5b29af1();

  if(self tagexists("tag_player_camera")) {
    self.camera = spawn("script_model", self gettagorigin("tag_player_camera"));
    self.camera.angles = self gettagangles("tag_player_camera");
  } else {
    self.camera = spawn("script_model", self gettagorigin("tag_player"));
    self.camera.angles = self.angles;
  }

  self.camera setModel("tag_player");
  self.camera notsolid();
  self.camera dontinterpolate();

  if(self tagexists("tag_player_camera")) {
    self.camera linkTo(self, "tag_player_camera", (0, 20, -75), (0, 0, 0));
  } else {
    self.camera linkTo(self, "tag_player", (160, 35, -25), (50, 90, 0));
  }

  self.camera.focus_ent = self.camera spawn_script_origin(focus_origin);
  self.camera.focus_ent dontinterpolate();
  self.camera.angles = vectortoangles(level.gunship.origin - self.camera.origin);
}

function function_abe98e26c5b29af1() {
  focus_origin = level.gunship.origin;

  if(isDefined(level.var_dc44706239201a43)) {
    focus_origin = level.var_dc44706239201a43;
  } else if(isDefined(level.gunship.link)) {
    focus_origin = level.gunship.link.origin;
  }

  return focus_origin;
}

function function_6b7ff0cd994a7fe(player, contentsoverride, max_dist) {
  if(isDefined(self.turret)) {
    ignorearray = [player, self, self.turret];
  } else {
    ignorearray = [player, self];
  }

  forward = anglesToForward(player getplayerangles());
  start = player getvieworigin();

  if(isDefined(max_dist)) {
    end = start + forward * max_dist;
  } else {
    end = start + forward * 100000;
  }

  trace = scripts\engine\trace::ray_trace_detail(start, end, ignorearray, contentsoverride);

  if(getdvarint(@ "hash_3509a98e15960501") == 1) {
    childthread draw_line_for_time(start, trace["<dev string:xdd>"], 1, 0, 1, 10);
  }

  return trace;
}

function function_b05d7be29251f29f(var_52192ee62bb1f1d1, ignorearray, contentsoverride, max_dist) {
  forward = anglesToForward(var_52192ee62bb1f1d1.angles);
  start = var_52192ee62bb1f1d1.origin;

  if(isDefined(max_dist)) {
    end = start + forward * max_dist;
  } else {
    end = start + forward * 100000;
  }

  trace = scripts\engine\trace::ray_trace_detail(start, end, ignorearray, contentsoverride);
  return trace;
}

function function_b6934bb42d84da8a(gunner) {
  view_clamp = self.camera.view_clamp;
  gunner playerlinkweaponviewtodelta(self.camera, "tag_player", 0, view_clamp[0], view_clamp[1], view_clamp[2], view_clamp[3], 0, 1, 1);
  gunner playerlinkedsetviewznear(0);
  childthread function_c477de5775b6f437(gunner);
}

function function_c39defa1b1c06412() {
  focus_object = scripts\engine\sp\utility::get_linked_struct();

  if(!isDefined(focus_object) && isDefined(self.script_linkto)) {
    focus_object = get_linked_ent();
  }

  return focus_object;
}

function function_adf23ae3a7125652(gunner) {
  view_clamp = self.camera.view_clamp;
  gunner playerlinktodelta(self.camera, "tag_player", 0, view_clamp[0], view_clamp[1], view_clamp[2], view_clamp[3], 0);
  childthread function_c477de5775b6f437(gunner);
}

function function_f3487eda44847314(viewmodel, legmodel, shadowmodel) {
  if(isDefined(viewmodel)) {
    self setviewmodel(viewmodel);
  }

  if(isDefined(legmodel)) {
    self setlegsmodel(legmodel);
  }

  self hideviewmodel();
}

function function_c477de5775b6f437(gunner) {
  waittillframeend();
  var_34743d0c04f178ef = vectortoangles(self.camera.focus_ent.origin - gunner getvieworigin());
  gunner setplayerangles(var_34743d0c04f178ef);
  self.oldangles = var_34743d0c04f178ef;

  while(isalive(gunner)) {
    newangles = vectortoangles(self.camera.focus_ent.origin - gunner getvieworigin());
    var_b5b3431a0126e171 = (self.oldangles[0] - newangles[0], self.oldangles[1] - newangles[1], 0);
    var_47eb6724c1e4e7a4 = gunner getplayerangles() - var_b5b3431a0126e171;
    gunner setplayerangles(var_47eb6724c1e4e7a4);
    self.camera.focus_ent.origin = function_6b7ff0cd994a7fe(gunner)["position"];
    self.oldangles = vectortoangles(self.camera.focus_ent.origin - gunner getvieworigin());
    utility::flag_waitopen("pauseCameraFocus");
    waitframe();
  }
}

function function_681115bb729346de(gunner) {
  origin = gunner gettagorigin("tag_eye");
  angles = gunner gettagangles("tag_eye");
  forward = origin + anglesToForward(angles) * 100;
  thread draw_line_for_time(origin, forward, 1, 1, 1, 1);
}

function function_ecfdc120a7cf6fe8() {
  focus_origin = function_abe98e26c5b29af1();
  ent = spawn_tag_origin(focus_origin, (0, 0, 0));
  ent dontinterpolate();
  return ent;
}

function function_ff5b3dbacd9c0cdd(player, view_clamp) {
  if(isDefined(self.camera)) {
    if(!isDefined(view_clamp)) {
      view_clamp = [90, 90, 50, 90];

      if(isDefined(level.var_18a73555b2329261)) {
        view_clamp = level.var_18a73555b2329261;
      }
    }

    while(!player islinked()) {
      waitframe();
    }

    while(player function_68d997f850b153c7()) {
      waitframe();
    }

    player lerpviewangleclamp(0, 0, 0, 0, 0, 0, 0);
    player lerpviewangleclamp(0, 0, 0, view_clamp[0], view_clamp[1], view_clamp[2], view_clamp[3]);
    player setviewangleresistance(30, 30, 15, 15);
  }
}

function function_3b0be67066481f21(nearstart, nearend, farstart, farend, nearblur, farblur) {
  if(!isDefined(self)) {
    return;
  }

  nearstart = max(nearstart, 0);
  nearend = clamp(nearend, 1, 9994);
  farstart = clamp(farstart, 2, 9998);
  farend = clamp(farend, 3, 9999);

  if(farstart > 9994) {
    farblur = 0;
  }

  self setdepthoffield(nearstart, nearend, farstart, farend, nearblur, farblur);
}

function gunship_ads(player) {
  self endon("death");
  player lerpfov(level.var_fb13600ef005ed60, 0.01);
  level.var_a6bbc14d819f5470 = level.var_fb13600ef005ed60;
  player childthread function_2b6b6e8da0f4510c();
  lerp_time = 0.2;

  while(true) {
    should_ads = player adsButtonPressed(1);
    changed = 0;

    if(should_ads) {
      flag_set("gunship_ads_pressed");

      if(flag("should_max_ads")) {
        player lerpfov(level.var_10a026b50d5be68f, lerp_time);
        level.var_a6bbc14d819f5470 = level.var_10a026b50d5be68f;
      } else {
        player lerpfov(level.var_285ce926ff345ee3, lerp_time);
        level.var_a6bbc14d819f5470 = level.var_285ce926ff345ee3;
      }

      if(level.var_ac0ee5ab988fff9f != level.var_abebd3ab98699051) {
        childthread function_85106c8b0af97990(level.var_abebd3ab98699051);
      }

      changed = 1;
    } else {
      flag_clear("gunship_ads_pressed");
      flag_clear("should_max_ads");
      player lerpfov(level.var_fb13600ef005ed60, lerp_time);
      level.var_a6bbc14d819f5470 = level.var_fb13600ef005ed60;

      if(level.var_ac0ee5ab988fff9f != level.var_abebd3ab98699051) {
        childthread function_85106c8b0af97990(level.var_ac0ee5ab988fff9f);
      }
    }

    waitframe();
  }
}

function function_2b6b6e8da0f4510c() {
  while(true) {
    utility::waittill_any_2("sprint_pressed", "melee_pressed");
    is_ads = self adsButtonPressed();

    if(is_ads) {
      if(!flag("should_max_ads")) {
        flag_set("should_max_ads");
        continue;
      }

      flag_clear("should_max_ads");
    }
  }
}

function function_85106c8b0af97990(speed) {
  level.gunship_speed["rotate"] = speed;
  rotateplane("off_instant");
  rotateplane("on");
}

function gunship_giveweapon(weapon, variant, dualwieldoverride, usedbefore) {
  if(!isDefined(variant)) {
    variant = -1;
  }

  if(!isDefined(usedbefore)) {
    usedbefore = 0;
  }

  self giveweapon(weapon, variant, istrue(dualwieldoverride), -1, usedbefore);
}

function gunship_switchtoweaponimmediate(weapon) {
  self switchtoweaponimmediate(weapon);
}

function function_9c33573bb832a824(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level endon("missionfailed");
  level endon("stop_gunship");

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    return;
  }

  gunner val::set("gunship", "weapon_switch", 0);

  if(!istrue(level.var_f1acd9be11d8efe5)) {
    gunner setclientomnvar("ui_killstreak_weapon", 0);
    gunner setclientomnvar("ui_killstreak_weapon_3_ammo", 0);
  }

  self.currentweaponindex = 1;
  gunner allowfire(0);

  while(!istrue(level.var_f1acd9be11d8efe5)) {
    waitframe();
  }

  gunner setclientomnvar("ui_killstreak_weapon", 1);
  gunner setclientomnvar("ui_killstreak_weapon_3_ammo", 30);
  childthread gunship_watchweaponfired(gunner);

  if(getdvarint(@ "hash_80478c6f0f12492a")) {
    childthread function_26067d6d8c85dc(gunner);
  }

  if(getdvarint(@ "hash_cca85e49b724df8b") == 0) {
    gunner function_a8d38309fd6157f9();
  }

  if(getdvarint(@ "hash_f213fc40b2f63070") == 0) {
    function_eea48efa8d43b682(gunner);
    return;
  }

  thread function_f897b18f3dfd04bd(gunner);
  function_fb457a2ad44e0ca5(gunner);
}

function function_f897b18f3dfd04bd(gunner) {
  gunner.var_f4c84d68c257f5c5 = 1;
  gunner setadsphysicaldepthoffield(1, 30000);

  while(true) {
    gunner utility::waittill_any_2("ads_pressed", "ads_released");

    if(gunner adsButtonPressed()) {
      if(istrue(gunner.var_f4c84d68c257f5c5) && gunner sprintbuttonPressed()) {
        gunner lerpfov(level.var_285ce926ff345ee3, 0.2);
        gunner.var_f4c84d68c257f5c5 = 0;
      } else if(!istrue(gunner.var_f4c84d68c257f5c5) && gunner sprintbuttonPressed()) {
        gunner lerpfov(level.var_10a026b50d5be68f, 0.2);
        gunner.var_f4c84d68c257f5c5 = 1;
      }

      continue;
    }

    gunner lerpfov(65, 0.2);
    gunner.var_f4c84d68c257f5c5 = 0;
  }
}

function function_eea48efa8d43b682(gunner) {
  fire_rate[1] = 4;
  fire_rate[2] = 15;
  fire_rate[3] = 255;
  childthread function_c35c79990dcb7020(gunner);
  level.gunship.var_6cbd80d5c55ff987 = function_a79b46a6d3d7def();
  gunner notifyonplayercommand("weapon_switch_next", "-weapnext");
  gunner notifyonplayercommand("weapon_switch_next", "selectweapon2");
  gunner notifyonplayercommand("weapon_switch_previous", "+weapprev");
  gunner notifyonplayercommand("weapon_switch_previous", "selectweapon1");

  for(;;) {
    playerusinggamepad = gunner usinggamepad();
    cmd = "";

    if(istrue(playerusinggamepad)) {
      gunner waittill("weapon_switch_pressed");
    } else {
      cmd = gunner waittill_any_return_2("weapon_switch_next", "weapon_switch_previous");
    }

    if(flag("pauseWeaponSwap")) {} else {
      if(isDefined(cmd) && gunner isweaponsenabled()) {
        current_weapon_name = level.gunship.var_6cbd80d5c55ff987[self.currentweaponindex];
        var_593560394b8bddf6 = function_f45ebfa891515d9b(current_weapon_name);

        if(current_weapon_name == level.gunship.var_d660505e3d0ba81d) {
          if(!istrue(gunner.weapon_reloading)) {
            weapon = gunner getcurrentweapon();
            currentammo = gunner getweaponammoclip(weapon);

            if(currentammo < 15) {
              gunner thread function_6c7ef99bf5ba717f(weapon, self);
            }
          }
        } else if(var_593560394b8bddf6.currentammo < var_593560394b8bddf6.lowammo) {
          function_dc20e70ce4d6b547(var_593560394b8bddf6, gunner);
        }

        gunner playlocalsound("iw8_ks_ac130_weaponswitch");

        if(cmd == "weapon_switch_next") {
          self.currentweaponindex--;
        } else {
          self.currentweaponindex++;
        }

        if(self.currentweaponindex > 3) {
          self.currentweaponindex = 1;
        } else if(self.currentweaponindex < 1) {
          self.currentweaponindex = 3;
        }

        gunner setclientomnvar("ui_killstreak_weapon", self.currentweaponindex);
        current_weapon_name = level.gunship.var_6cbd80d5c55ff987[self.currentweaponindex];
        var_5753fff364d480fa = function_f45ebfa891515d9b(current_weapon_name);
        childthread function_749e3c5f99d50954("gunship_weapon_shutter_crt", 0.025, 0.08, 0.15);
        earthquake(0.07, 1.5, gunner.origin, 100);
        gunner playRumbleOnEntity("ui_haptic");
      }

      waitframe();
    }

    waitframe();
  }
}

function function_a79b46a6d3d7def() {
  var_6cbd80d5c55ff987[1] = level.gunship.var_d660505e3d0ba81d;
  var_6cbd80d5c55ff987[2] = level.gunship.var_d6604d5e3d0ba184;

  if(getdvarint(@ "hash_80478c6f0f12492a")) {
    var_6cbd80d5c55ff987[3] = level.gunship.var_d6604e5e3d0ba3b7;
  } else {
    var_6cbd80d5c55ff987[3] = level.gunship.var_d6604f5e3d0ba5ea;
  }

  return var_6cbd80d5c55ff987;
}

function function_c35c79990dcb7020(gunner) {
  level endon("stop_gunship");

  while(true) {
    gunner waittill("reload_pressed");
    weapon_name = function_878e144349832994(gunner);

    if(weapon_name == level.gunship.var_d660505e3d0ba81d) {
      if(!istrue(gunner.weapon_reloading)) {
        weapon = gunner getcurrentweapon();
        currentammo = gunner getweaponammoclip(weapon);

        if(currentammo < 30) {
          gunner childthread function_6c7ef99bf5ba717f(weapon, self);
        }
      }
    } else {
      var_872e9fd8a2a204b0 = function_f45ebfa891515d9b(weapon_name);
      function_dc20e70ce4d6b547(var_872e9fd8a2a204b0, gunner);
    }

    waitframe();
  }
}

function function_dc20e70ce4d6b547(var_872e9fd8a2a204b0, gunner, force, reloadtime) {
  if(istrue(force) || !istrue(var_872e9fd8a2a204b0.is_reloading) && var_872e9fd8a2a204b0.currentammo < var_872e9fd8a2a204b0.weapon_object.maxammo) {
    var_872e9fd8a2a204b0.currentammo = 0;
    gunner setclientomnvar(var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b, var_872e9fd8a2a204b0.currentammo);
    gunner thread gunship_weaponreload(var_872e9fd8a2a204b0, self, reloadtime);
  }
}

function function_fb457a2ad44e0ca5(gunner) {
  if(getdvarint(@ "hash_80478c6f0f12492a")) {
    weaponlistorder = [level.gunship.var_d660505e3d0ba81d, level.gunship.var_d6604d5e3d0ba184, level.gunship.var_d6604e5e3d0ba3b7];
  } else {
    weaponlistorder = [level.gunship.var_d660505e3d0ba81d, level.gunship.var_d6604d5e3d0ba184, level.gunship.var_d6604f5e3d0ba5ea];
  }

  var_d42e569e7a0ffc49[weaponlistorder[0]] = self.weapon_objects[0];
  var_d42e569e7a0ffc49[weaponlistorder[1]] = self.weapon_objects[1];
  var_d42e569e7a0ffc49[weaponlistorder[2]] = self.weapon_objects[2];
  self.var_fff9e9244cd692a3 = function_8d01239b5d6b7cae(level.gunship.var_d660505e3d0ba81d, self.weapon_objects[0]);
  self.var_fff100244ccca68a = function_8d01239b5d6b7cae(level.gunship.var_d6604d5e3d0ba184, self.weapon_objects[1]);

  if(getdvarint(@ "hash_80478c6f0f12492a")) {
    self.var_f4364bd51b414686 = function_8d01239b5d6b7cae(level.gunship.var_d6604e5e3d0ba3b7, self.weapon_objects[2]);
  } else {
    self.var_e90a9a2f31633c19 = function_8d01239b5d6b7cae(level.gunship.var_d6604f5e3d0ba5ea, self.weapon_objects[2]);
  }

  currentweaponindex = 1;

  while(true) {
    gunner waittill("weapon_switch_pressed");

    if(gunner isweaponsenabled()) {
      gunner playlocalsound("iw8_ks_ac130_weaponswitch");
      currentweapon = gunner getcurrentweapon();
      newweapon = currentweapon;

      foreach(weapon in weaponlistorder) {
        if(currentweapon.basename == weapon) {
          newweaponindex = index + 1;

          if(newweaponindex > weaponlistorder.size - 1) {
            newweaponindex = 0;
          }

          newweapon = weaponlistorder[newweaponindex];
          break;
        }
      }

      gunner gunship_switchtoweaponimmediate(var_d42e569e7a0ffc49[newweapon]);
      currentweaponindex++;

      if(currentweaponindex > 3) {
        currentweaponindex = 1;
      }

      gunner setclientomnvar("ui_killstreak_weapon", currentweaponindex);
    }
  }
}

function function_c0d2b532e679f3aa() {
  i = 0;
  wait 5;
  self takeallweapons();
  weapons = [];
  weapons[weapons.size] = scripts\sp\utility::make_weapon("gunship_25mm_sp_ompound", [level.gunship.var_10a90f7f2ccc7f03]);
  weapons[weapons.size] = scripts\sp\utility::make_weapon("gunship_40mm_sp", [level.gunship.var_10a90f7f2ccc7f03]);
  weapons[weapons.size] = scripts\sp\utility::make_weapon("gunship_hellfire_sp");

  foreach(weapon in weapons) {
    scripts\sp\utility::give_weapon(weapon, 0, 0, 0, 1);
  }

  while(true) {
    iprintlnbold("<dev string:xe6>");

    i++;

    if(i > 2) {
      i = 0;
    }

    gunship_switchtoweaponimmediate(weapons[i]);
    wait 5;
  }
}

function input_menu(lines) {
  huds = [];
  background = create_menu(600, 325, 0);
  background setshader("black", 100, 40);
  background.alpha = 0.3;
  huds[huds.size] = background;
  huds_b = background add_lines(lines);
  huds = array_combine(huds, huds_b);
  return huds;
}

function create_menu(x, y, var_214764106ae21d43) {
  if(!isDefined(var_214764106ae21d43)) {
    var_214764106ae21d43 = 1;
  }

  hud = newhudelem();
  hud.x = x;
  hud.y = y;
  hud.horzalign = "left";
  hud.fontscale = 1;
  hud.hidewheninmenu = 1;
  hud.sort = var_214764106ae21d43;
  return hud;
}

function add_lines(lines, x) {
  if(istrue(x)) {
    var_bb2684c4f4c3f570 = 62;
    starting = self.x + 5;
    var_1ce8af601ec4d316 = 1;
  } else {
    var_bb2684c4f4c3f570 = 15;
    starting = self.y + 5;
    var_1ce8af601ec4d316 = 0;
  }

  huds = [];

  foreach(index, item in lines) {
    if(var_1ce8af601ec4d316) {
      hud = create_menu(starting + var_bb2684c4f4c3f570 * index, self.y + 10);
    } else {
      hud = create_menu(self.x + 10, starting + var_bb2684c4f4c3f570 * index);
    }

    hud settext(item);
    huds[huds.size] = hud;
  }

  return huds;
}

function gunship_getdofinfobyweapon(weaponbasename) {
  dofinfo = spawnStruct();

  if(weaponbasename == level.gunship.var_d6604e5e3d0ba3b7) {
    dofinfo.fstop = 8;
    dofinfo.focusdistance = 600;
  } else if(weaponbasename == level.gunship.var_d6604d5e3d0ba184) {
    dofinfo.fstop = 8;
    dofinfo.focusdistance = 600;
  } else if(weaponbasename == level.gunship.var_d660505e3d0ba81d) {
    dofinfo.fstop = 8;
    dofinfo.focusdistance = 3500;
  }

  return dofinfo;
}

function function_26067d6d8c85dc(player) {
  weapon_name = self.var_e90a9a2f31633c19.weapon_name;
  var_fc48fcfbaa9c1c9a = self.var_e90a9a2f31633c19;
  level.gunship.hellfire_weapon = var_fc48fcfbaa9c1c9a.weapon_object;
  var_b91008c239cf5cd4 = getdvarint(@ "hash_cca85e49b724df8b");

  if(var_b91008c239cf5cd4) {
    self.var_48ca513b655d8d82 = spawn_script_origin();
    self.var_48ca513b655d8d82 dontinterpolate();
    self.laser_ent = spawn("script_model", player.origin);
    self.laser_ent.angles = player.angles;
    self.laser_ent setModel("tag_laser");
    self.laser_ent setmoverlaserweapon("iw8_laser_painter_ac130_hellfire");
    self.laser_ent linkTo(player);

    if(isDefined(self.laser_ent)) {
      childthread function_762f335fd954ac86(player);
    }
  }

  while(true) {
    player waittill("frag_pressed");

    if(flag("hellfire_system_busy")) {
      player playlocalsound("use_denial");
      wait 0.1;
    } else {
      full_trace = function_6b7ff0cd994a7fe(player);
      projectile_start = player.origin;
      impact_pos = full_trace["position"];

      if(var_b91008c239cf5cd4) {
        missile = function_52ef54bd52ac31ce(self.var_48ca513b655d8d82, var_fc48fcfbaa9c1c9a, projectile_start, impact_pos, player);
        thread utility::display_hint("vision_thermal", 5, undefined, missile);
        level notify("hellfire_missile_launched", missile, self.var_48ca513b655d8d82);
      } else {
        while(player fragButtonPressed()) {
          result = player missilelauncherusage(impact_pos);

          if(istrue(result)) {
            missile = function_52ef54bd52ac31ce(player.missilelaunchertarget, var_fc48fcfbaa9c1c9a, projectile_start, impact_pos, player);
            level notify("hellfire_missile_launched", missile, self.var_48ca513b655d8d82);
            break;
          } else if(isDefined(player.var_aa1d1fe26ddb3042)) {
            hideheadiconfromplayersinmask(player.var_aa1d1fe26ddb3042);
          }

          waitframe();
        }

        player function_3e954d9a9a42058a();
        player function_f7e6f0d8bd63409d();
      }
    }

    waitframe();
  }
}

function function_762f335fd954ac86(player) {
  self.laser_ent.laser_on = 0;

  while(true) {
    full_trace = function_6b7ff0cd994a7fe(player);
    impact_pos = full_trace["position"];
    self.var_48ca513b655d8d82.origin = impact_pos;
    function_c5d11d32f3af1ac8(impact_pos, player);

    if(flag("hellfire_missile_alive") && !self.laser_ent.laser_on) {
      if(getdvarint(@ "hash_d8d71cbe1098260e", 1) == 0) {
        self.laser_ent laserforceon();
      }

      self.laser_ent.laser_on = !self.laser_ent.laser_on;
      continue;
    }

    if(!flag("hellfire_missile_alive") && self.laser_ent.laser_on) {
      if(getdvarint(@ "hash_d8d71cbe1098260e", 1) == 0) {
        self.laser_ent laserforceoff();
      }

      self.laser_ent.laser_on = !self.laser_ent.laser_on;
    }
  }
}

function function_c5d11d32f3af1ac8(targetpos, player) {
  targetangles = vectortoangles(targetpos - player.origin);
  invangles = invertangles(player.angles);
  angles = combineangles(invangles, targetangles);
  self.laser_ent rotatetolinked(angles, 0.05);
  self.laser_ent waittill("rotatedone");
}

function function_c161dfa5d7b807ee(player) {
  while(!isDefined(self.camera)) {
    waitframe();
  }

  while(true) {
    full_trace = function_6b7ff0cd994a7fe(player);
    impact_pos = full_trace["position"];
    childthread function_708a140c9cdedb29(impact_pos, player, self.weapon_big);
    function_708a140c9cdedb29(impact_pos, player, self.weapon_small);
  }
}

function function_708a140c9cdedb29(targetpos, player, weapon_ent) {
  targetangles = vectortoangles(targetpos - self gettagorigin("tag_gun_big"));
  invangles = invertangles(self gettagangles("tag_gun_big"));
  angles = combineangles(invangles, targetangles);
  weapon_ent rotatetolinked(angles, 0.05);
  weapon_ent waittill("rotatedone");
}

function function_74ea1e4753949cee(projectile_start, impact_pos, var_fc48fcfbaa9c1c9a) {
  flag_set("hellfire_system_busy");
  level.var_f4d4b089abe644c1++;
  flag_set("hellfire_missile_alive");
  missile = runcruisepredator(0, projectile_start, impact_pos);
  missile.var_872e9fd8a2a204b0 = var_fc48fcfbaa9c1c9a;
  thread function_e646a7a0af99030e(missile);
  scripts\engine\sp\utility::delaychildthread(60, &function_3195e1aab4f57134);
  return missile;
}

function function_52ef54bd52ac31ce(target, var_fc48fcfbaa9c1c9a, projectile_start, impact_pos, player) {
  flag_set("hellfire_system_busy");
  level.var_f4d4b089abe644c1++;
  flag_set("hellfire_missile_alive");
  missile = magicbullet(var_fc48fcfbaa9c1c9a.weapon_object, projectile_start, impact_pos, player);
  missile.var_872e9fd8a2a204b0 = var_fc48fcfbaa9c1c9a;
  missile missile_settargetEnt(target);
  missile missileoutline();
  missile missilethermal();
  missile childthread function_bb85097ab78a5b4f(player);
  player childthread function_e646a7a0af99030e(missile);

  if(soundexists("gunship_105mm_sp_reload")) {
    player playlocalsound("gunship_105mm_sp_reload");
  } else {
    player playlocalsound("ac130_105mm_mp_reload");
  }

  scripts\engine\sp\utility::delaychildthread(60, &function_3195e1aab4f57134);
  return missile;
}

function function_bb85097ab78a5b4f(player) {
  waittill_any_8("death", "collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked", "missile_lock_ended");
  flag_clear("hellfire_missile_alive");

  if(isDefined(player.var_aa1d1fe26ddb3042)) {
    hideheadiconfromplayersinmask(player.var_aa1d1fe26ddb3042);
  }
}

function function_3195e1aab4f57134() {
  utility::flag_clear("hellfire_system_busy");
}

function function_e646a7a0af99030e(projectile, position, var_d0cfeb022e718777) {
  level endon("missionfailed");

  if(isDefined(projectile)) {
    if(isDefined(level.var_2825cd44d4091ad3)) {
      projectile childthread[[level.var_2825cd44d4091ad3]](projectile.var_872e9fd8a2a204b0.weapon_object);
    }

    projectile waittill("explode", position);
    level.var_1250917a0280ae9 = array_removeundefined(level.var_1250917a0280ae9);
    function_7603c1bf75f42d23(projectile, position);
  }

  var_d0cfeb022e718777 = utility::default_to(var_d0cfeb022e718777, 1000);

  if(getdvarint(@ "hash_64bdd497427343e9", 0) == 1) {
    utility::draw_circle(position, 2000, (0, 0, 1), 1, 0, 150);
    utility::draw_circle(position, 1000, (1, 0, 0), 1, 0, 150);
  }

  ai_array = getaiarrayinradius(position, var_d0cfeb022e718777, "axis", "neutral");
  ai_array = array_removedead_or_dying(ai_array);

  if(isDefined(level.var_e8e0eac736110e84) && ai_array.size > 0) {
    if(getdvarint(@ "hash_5da9c798d17a834", 0) == 1) {
      if(isDefined(projectile)) {
        childthread draw_circle(projectile.origin, var_d0cfeb022e718777, (1, 1, 1), 1, 1, 5);
      }
    }

    foreach(ai in ai_array) {
      ai thread[[level.var_e8e0eac736110e84]]();
    }
  }

  if(isDefined(level.var_26eff2bcd81ab5ef) && isDefined(projectile)) {
    self childthread[[level.var_26eff2bcd81ab5ef]](projectile);
  }

  ally_guys = getaiarray("allies");

  if(ally_guys.size > 0) {
    var_79df09a6d3e7f50c = getclosest(position, ally_guys);
    thread function_4385b2a9645a3367(position, var_79df09a6d3e7f50c.origin, "gunship_105mm_expl_radio");
  }

  thread function_4a15f1a5c38d4f0a(position);

  if(isDefined(projectile)) {
    level notify("gunship_weapon_impact", position, projectile.var_872e9fd8a2a204b0.weapon_object.basename);
  } else {
    level notify("gunship_weapon_impact", position, level.gunship.var_d6604f5e3d0ba5ea);
  }

  if(getdvarint(@ "hash_cca85e49b724df8b") == 1) {
    guys = getaiarrayinradius(position, 1200, "axis");
    guys = array_removedead_or_dying(guys);

    foreach(guy in guys) {
      if(istrue(guy.magic_bullet_shield)) {
        guy scripts\common\ai::stop_magic_bullet_shield();
      }

      guy kill(position, self, self, "MOD_PROJECTILE_SPLASH");
    }

    radiusdamagestepped(position, 1200, 900, 1600, 700, 2000, 400, level.player, undefined, level.gunship.var_d6604f5e3d0ba5ea, 0, 0);
  }
}

function function_4a15f1a5c38d4f0a(position) {
  explo_distance = distance(self.origin, position) / 12;
  var_9bdbf1831334e1b5 = 0 + explo_distance / 600;
  wait var_9bdbf1831334e1b5;
  thread play_sound_in_space("gunship_hellfire_shockwave_explo", position);
  wait 0.2;
  earthquake(0.11, 4, self.origin, 350);
}

function function_9d412becd6680b79(impact_pos, player) {
  target = undefined;
  vehicles = scripts\engine\sp\utility::getvehiclearray_in_radius(impact_pos, 2000, "axis");
  vehicles = array_removedead_or_dying(vehicles);

  if(isDefined(vehicles) && vehicles.size > 0) {
    vehicles = sortbydistance(vehicles, impact_pos);
    target = vehicles[0];
  } else {
    guys = getaiarrayinradius(impact_pos, 2000, "axis");
    guys = array_removedead_or_dying(guys);

    if(isDefined(guys) && guys.size > 0) {
      guys = sortbydistance(guys, impact_pos);
      target = guys[0];
    }
  }

  if(isDefined(target)) {
    var_b7c51f037012048d = player worldpointtoscreenpos(target.origin, 3);

    if(isDefined(var_b7c51f037012048d)) {
      return target;
    }
  }
}

function function_3e5ea3db86d046fe(impact_pos, player) {
  targets = undefined;
  vehicles = scripts\engine\sp\utility::getvehiclearray_in_radius(impact_pos, 2000, "axis");
  vehicles = array_removedead_or_dying(vehicles);

  if(isDefined(vehicles) && vehicles.size > 0) {
    foreach(vehicle in vehicles) {
      if(!isDefined(vehicle.riders) || vehicle.riders.size <= 0) {
        vehicles = array_remove(vehicles, vehicle);
      }
    }

    targets = vehicles;
  }

  if(!isDefined(vehicles) || vehicles.size <= 0) {
    guys = getaiarrayinradius(impact_pos, 2000, "axis");
    guys = array_removedead_or_dying(guys);

    if(isDefined(guys) && guys.size > 0) {
      targets = guys;
    }
  }

  if(isDefined(targets) && targets.size > 0) {
    targets = sortbydistance(targets, impact_pos);
  }

  return targets;
}

function function_a8d38309fd6157f9() {
  function_f7e6f0d8bd63409d();
  self.var_ecdb884ad1740a40 = spawn("script_model", self.origin);
  self.var_ecdb884ad1740a40 dontinterpolate();
  self.var_ecdb884ad1740a40 setModel("tag_origin");
  self.var_aa1d1fe26ddb3042 = createheadicon(self.var_ecdb884ad1740a40);
  setheadiconimage(self.var_aa1d1fe26ddb3042, "hud_icon_target_player");
  addclienttoheadiconmask(self.var_aa1d1fe26ddb3042, self);
  function_6ddec503234ca6ff(self.var_aa1d1fe26ddb3042, "hud_icon_target_player");
  setheadiconowner(self.var_aa1d1fe26ddb3042, self);
  setheadicondrawthroughgeo(self.var_aa1d1fe26ddb3042, 1);
  setheadiconmaxdistance(self.var_aa1d1fe26ddb3042, 32000);
  setheadiconnaturaldistance(self.var_aa1d1fe26ddb3042, 1000);
  setheadiconsnaptoedges(self.var_aa1d1fe26ddb3042, 0);
  setheadiconzoffset(self.var_aa1d1fe26ddb3042, 15);
  hideheadiconfromplayersinmask(self.var_aa1d1fe26ddb3042);
  self.var_4226c12910d867d4 = createtargetmarkergroup("lockontarget");
}

function function_6ddec503234ca6ff(icon_index, icon_name) {
  setheadiconimage(icon_index, icon_name);
  setheadiconenemyimage(icon_index, icon_name);
  setheadiconfriendlyimage(icon_index, icon_name);
  setheadiconneutralimage(icon_index, icon_name);
}

function function_3e954d9a9a42058a() {
  if(!isDefined(self.missilelauncheruseentered)) {
    return;
  }

  self.missilelauncheruseentered = undefined;
  self notify("stop_javelin_locking_feedback");
  self notify("stop_javelin_locked_feedback");
  self notify("missileLauncher_lock_lost");
  self weaponlockfree();
  self stoplocalsound("maaws_reticle_tracking");
  self stoplocalsound("maaws_reticle_locked");

  if(isDefined(self.missilelaunchertarget)) {
    function_53199b21e1cf656b(self.missilelaunchertarget, self);
  }

  function_f7e6f0d8bd63409d();
}

function function_f7e6f0d8bd63409d() {
  self.missilelauncherstage = undefined;
  self.missilelaunchertarget = undefined;
  self.missilelauncherlockstarttime = undefined;
  self.missilelauncherlostsightlinetime = undefined;
  self.var_eb8c81f358764661 = 0;
}

function function_53199b21e1cf656b(entity, attacker) {
  if(!isDefined(entity.islockedon)) {
    return;
  }

  assert(function_6027b6de10011eee(entity), "removeLockedOn called on an entity that is not locked onto.");

  if(entity.islockedon == 1) {
    if(isDefined(entity.lockedonremovedcallback)) {
      entity thread[[entity.lockedonremovedcallback]]();
    }
  }

  if(isDefined(attacker)) {
    if(isDefined(attacker.entlockedonto) && attacker.entlockedonto == entity) {
      attacker.entlockedonto = undefined;
    }

    entity.attackerslockedon[attacker getentitynumber()] = undefined;
  }

  entity.islockedon--;
}

function function_6027b6de10011eee(entity) {
  return isDefined(entity.islockedon) && entity.islockedon > 0;
}

function missilelauncherusage(impact_pos) {
  var_db87e220986304f4 = 625000000;
  var_e688b198aa9a4b3f = 0;
  self.missilelauncheruseentered = 1;

  if(!isDefined(self.missilelauncherstage)) {
    self.missilelauncherstage = 0;
  }

  if(self.missilelauncherstage == 0) {
    targets = function_3e5ea3db86d046fe(impact_pos, self);

    if(!isDefined(targets) || targets.size <= 0) {
      if(!self.var_eb8c81f358764661) {
        self playlocalsound("use_denial");
        self.var_eb8c81f358764661 = 1;
      }

      return;
    }

    stingtargstruct = undefined;
    var_c7f50dd357b9cdcf = 0;

    foreach(target in targets) {
      if(!isDefined(target)) {
        continue;
      }

      stingtargstruct = stingtargstruct_create(self, target);
      stingtargstruct stingtargstruct_getoffsets();
      stingtargstruct stingtargstruct_getorigins();
      stingtargstruct stingtargstruct_getinreticle();

      if(stingtargstruct stingtargstruct_isinreticle()) {
        if(distancesquared(target.origin, self.origin) > var_db87e220986304f4) {
          break;
        }

        var_c7f50dd357b9cdcf = 1;
        break;
      }
    }

    if(!var_c7f50dd357b9cdcf) {
      return;
    }

    stingtargstruct stingtargstruct_getinlos();

    if(!stingtargstruct stingtargstruct_isinlos()) {
      return;
    }

    self.missilelaunchertarget = stingtargstruct.target;
    self.missilelauncherlockstarttime = gettime();
    self.missilelauncherstage = 1;
    self.missilelauncherlostsightlinetime = 0;

    if(isDefined(self.missilelaunchertarget)) {
      function_9bc63c81c00e88ec(self.missilelaunchertarget, self);
      team = "axis";

      if(isDefined(self.missilelaunchertarget.team)) {
        team = self.missilelaunchertarget.team;
      }

      addteamtotargetmarkergroupmask(self.var_4226c12910d867d4, team);
      targetmarkergroupaddentity(self.var_4226c12910d867d4, self.missilelaunchertarget);
      showtargetmarkergrouptoplayersinmask(self.var_4226c12910d867d4);
      function_6ddec503234ca6ff(self.var_aa1d1fe26ddb3042, "hud_icon_target_player");
    }

    thread loopmissilelauncherlockingfeedback();
  }

  if(self.missilelauncherstage == 1) {
    if(!isDefined(self.missilelaunchertarget)) {
      function_3e954d9a9a42058a();
      return;
    }

    if(!var_e688b198aa9a4b3f && is_equal(self.missilelaunchertarget.team, self.team)) {
      function_3e954d9a9a42058a();
      return;
    }

    stingtargstruct = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct stingtargstruct_getoffsets();
    stingtargstruct stingtargstruct_getorigins();
    stingtargstruct stingtargstruct_getinreticle();

    if(!stingtargstruct stingtargstruct_isinreticle()) {
      function_3e954d9a9a42058a();
      return;
    }

    stingtargstruct stingtargstruct_getinlos();

    if(!gunship_softsighttest(stingtargstruct)) {
      return;
    }

    timepassed = gettime() - self.missilelauncherlockstarttime;

    if(timepassed < 1500) {
      return;
    }

    self notify("stop_javelin_locking_feedback");
    thread loopmissilelauncherlockedfeedback();
    offset = undefined;
    missilelauncher_finalizelock(stingtargstruct);
    self.missilelauncherstage = 2;
  }

  if(self.missilelauncherstage == 2) {
    if(!isDefined(self.missilelaunchertarget)) {
      function_3e954d9a9a42058a();
      return;
    }

    if(!var_e688b198aa9a4b3f && is_equal(self.missilelaunchertarget.team, self.team)) {
      function_3e954d9a9a42058a();
      return;
    }

    stingtargstruct = stingtargstruct_create(self, self.missilelaunchertarget);
    stingtargstruct stingtargstruct_getoffsets();
    stingtargstruct stingtargstruct_getorigins();
    stingtargstruct stingtargstruct_getinreticle();
    stingtargstruct stingtargstruct_getinlos();

    if(!gunship_softsighttest(stingtargstruct)) {
      return;
    } else {
      missilelauncher_finalizelock(stingtargstruct);
      function_6ddec503234ca6ff(self.var_aa1d1fe26ddb3042, "cp_drone_reticle_square_glow");
      showheadicontoplayersinmask(self.var_aa1d1fe26ddb3042);
      return 1;
    }

    if(!stingtargstruct stingtargstruct_isinreticle()) {
      function_3e954d9a9a42058a();
      return;
    }
  }
}

function stingtargstruct_create(player, target) {
  struct = spawnStruct();
  struct.player = player;
  struct.target = target;
  struct.offsets = [];
  struct.origins = [];
  struct.inreticledistssqr = [];
  struct.inreticlesortedids = [];
  struct.inlosid = undefined;
  struct.useoldlosverification = 1;
  return struct;
}

function stingtargstruct_getoffsets() {
  self.offsets = [];

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "light_tank") {
    self.offsets[self.offsets.size] = (0, 0, 72);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "apc_russian") {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "cargo_truck" || self.target.vehiclename == "cargo_truck_mg")) {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "large_transport") {
    self.offsets[self.offsets.size] = (0, 0, 65);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "medium_transport") {
    self.offsets[self.offsets.size] = (0, 0, 60);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "pickup_truck" || self.target.vehiclename == "technical")) {
    self.offsets[self.offsets.size] = (0, 0, 55);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "atv") {
    self.offsets[self.offsets.size] = (0, 0, 30);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && (self.target.vehiclename == "jeep" || self.target.vehiclename == "tac_rover")) {
    self.offsets[self.offsets.size] = (0, 0, 50);
    self.useoldlosverification = 0;
    return;
  }

  if(isDefined(self.target.vehiclename) && self.target.vehiclename == "loot_chopper") {
    self.offsets[self.offsets.size] = (0, 0, -100);
    self.useoldlosverification = 0;
    return;
  }

  self.offsets[self.offsets.size] = (0, 0, 0);
}

function stingtargstruct_getorigins() {
  origin = self.target.origin;
  angles = self.target.angles;
  forward = anglesToForward(angles);
  right = anglestoright(angles);
  up = anglestoup(angles);

  for(i = 0; i < self.offsets.size; i++) {
    offset = self.offsets[i];
    self.origins[i] = origin + right * offset[0] + forward * offset[1] + up * offset[2];
  }
}

function stingtargstruct_getinreticle() {
  foreach(origin in self.origins) {
    for(i = 0; i < self.origins.size; i++) {
      screenpos = self.player worldpointtoscreenpos(self.origins[i], 65);

      if(isDefined(screenpos)) {
        distsqr = length2dsquared(screenpos);

        if(distsqr <= 900) {
          self.inreticlesortedids[self.inreticlesortedids.size] = i;
          self.inreticledistssqr[i] = distsqr;
        }
      }
    }
  }

  if(self.inreticlesortedids.size > 1) {
    for(i = 0; i < self.inreticlesortedids.size; i++) {
      for(j = i + 1; j < self.inreticlesortedids.size; j++) {
        i_id = self.inreticlesortedids[i];
        j_id = self.inreticlesortedids[j];
        var_8eba9ec305d4a611 = self.inreticledistssqr[i_id];
        var_cf5f902786383f74 = self.inreticledistssqr[j_id];

        if(var_cf5f902786383f74 < var_8eba9ec305d4a611) {
          tempid = i_id;
          self.inreticlesortedids[i] = j_id;
          self.inreticlesortedids[j] = tempid;
        }
      }
    }
  }
}

function stingtargstruct_isinreticle() {
  return self.inreticlesortedids.size > 0;
}

function stingtargstruct_getinlos() {
  caststart = self.player getvieworigin();
  contents = physics_createcontents(["physicscontents_solid", "physicscontents_glass", "physicscontents_water", "physicscontents_vehicle", "physicscontents_item", "physicscontents_playernosight"]);
  ignorearr = [self.player, self.target];
  var_d4a24e02d124ac38 = self.target getlinkedchildren();

  if(isDefined(var_d4a24e02d124ac38) && var_d4a24e02d124ac38.size > 0) {
    ignorearr = array_combine(ignorearr, var_d4a24e02d124ac38);
  }

  if(!self.useoldlosverification) {
    for(i = 0; i < self.inreticlesortedids.size; i++) {
      id = self.inreticlesortedids[i];
      castend = self.origins[id];
      castresults = physics_raycast(caststart, castend, contents, ignorearr, 0, "physicsquery_closest", 1);

      if(!isDefined(castresults) || castresults.size == 0) {
        self.inlosid = id;
        return;
      }
    }

    return;
  }

  top = self.target getpointinbounds(0, 0, 1);
  trace = ray_trace(caststart, top, ignorearr, contents, 0);

  if(getDvar(@ "missiledebugdraw") == "<dev string:xf2>") {
    playerangles = self.player getplayerangles();
    forward = anglesToForward(playerangles);
    left = anglestoleft(playerangles);
    hitpos = trace["<dev string:xdd>"];
    sphere(hitpos, 10, (1, 0, 0), 0, 1);
    sphere(hitpos, 10, (0, 1, 0), 1, 1);
    var_29f55613421c5159 = distance(caststart, hitpos);
    print3d(hitpos + left * -20, "<dev string:xf4>" + var_29f55613421c5159, (1, 1, 1), 1, 1, 1);
    var_ad791987651b3ba3 = self.player.origin;
    var_633eaa5f21008b6f = var_ad791987651b3ba3 + left * 50;
    line(var_633eaa5f21008b6f, hitpos, (0, 1, 0), 1, 1, 1);
    var_3eacd3938ccd4b6c = var_ad791987651b3ba3 + left * -50;
    line(var_3eacd3938ccd4b6c, hitpos, (0, 1, 0), 1, 1, 1);
    var_633eaa5f21008b6f += (0, 0, 100);
    line(var_633eaa5f21008b6f, hitpos, (0, 1, 0), 1, 1, 1);
    var_3eacd3938ccd4b6c += (0, 0, 100);
    line(var_3eacd3938ccd4b6c, hitpos, (0, 1, 0), 1, 1, 1);
  }

  if(trace["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  front = self.target getpointinbounds(1, 0, 0);
  trace = ray_trace(caststart, front, ignorearr, contents, 0);

  if(trace["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }

  back = self.target getpointinbounds(-1, 0, 0);
  trace = ray_trace(caststart, back, ignorearr, contents, 0);

  if(trace["fraction"] == 1) {
    self.inlosid = 0;
    return;
  }
}

function stingtargstruct_isinlos() {
  return isDefined(self.inlosid);
}

function function_9bc63c81c00e88ec(entity, attacker) {
  if(!isDefined(entity.islockedon)) {
    entity.islockedon = 0;
    entity.attackerslockedon = [];
  }

  if(entity.islockedon == 0) {
    if(isDefined(entity.lockedoncallback)) {
      entity thread[[entity.lockedoncallback]]();
    }
  }

  if(isDefined(attacker)) {
    assertex(!isDefined(attacker.entlockedonto), "addLockedOn called on an attacker that is already locked on to another entity.");
    attacker.entlockedonto = entity;
    assertex(!isDefined(entity.attackerslockedon[attacker getentitynumber()]), "addLockedOn called on an attacker that is already locked on to THIS entity.");
    entity.attackerslockedon[attacker getentitynumber()] = attacker;
  }

  entity.islockedon++;
}

function loopmissilelauncherlockingfeedback() {
  self endon("death_or_disconnect");
  self endon("stop_javelin_locking_feedback");
  self.var_ecdb884ad1740a40.origin = self.missilelaunchertarget.origin;
  self.var_ecdb884ad1740a40 linkTo(self.missilelaunchertarget);
  childthread function_bea49fb639a2f08c();

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner) {
      level.gunshipplayer playSound("maaws_incoming_lp");
    }

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel) {
      level.gunshipplayer playSound("maaws_incoming_lp");
    }

    self playlocalsound("maaws_reticle_tracking");
    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.6;
  }
}

function function_bea49fb639a2f08c() {
  while(true) {
    showheadicontoplayersinmask(self.var_aa1d1fe26ddb3042);
    wait 0.5;
    hideheadiconfromplayersinmask(self.var_aa1d1fe26ddb3042);
    wait 0.1;
  }
}

function gunship_softsighttest(stingtargstruct) {
  lost_sight_limit = 500;

  if(stingtargstruct stingtargstruct_isinlos()) {
    self.missilelauncherlostsightlinetime = 0;
    return true;
  }

  if(self.missilelauncherlostsightlinetime == 0) {
    self.missilelauncherlostsightlinetime = gettime();
  }

  timepassed = gettime() - self.missilelauncherlostsightlinetime;

  if(timepassed >= lost_sight_limit) {
    function_3e954d9a9a42058a();
    return false;
  }

  return true;
}

function loopmissilelauncherlockedfeedback() {
  self endon("death_or_disconnect");
  self endon("stop_javelin_locked_feedback");
  self playlocalsound("maaws_reticle_locked");

  for(;;) {
    if(isDefined(level.chopper) && isDefined(level.chopper.gunner) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.chopper.gunner) {
      level.gunshipplayer playlocalsound("maaws_incoming_lp");
    }

    if(isDefined(level.gunshipplayer) && isDefined(self.missilelaunchertarget) && self.missilelaunchertarget == level.gunship.planemodel) {
      level.gunshipplayer playlocalsound("maaws_incoming_lp");
    }

    self playRumbleOnEntity("ac130_25mm_fire");
    wait 0.25;
  }
}

function missilelauncher_finalizelock(stingtargstruct) {
  offset = undefined;

  if(isDefined(stingtargstruct.target) && isDefined(stingtargstruct.target.vehiclename) && stingtargstruct.target.vehiclename == "light_tank") {
    offset = (0, 0, 75);
  } else if(isDefined(stingtargstruct.inlosid)) {
    offset = stingtargstruct.offsets[stingtargstruct.inlosid];
    offset = (offset[1], -1 * offset[0], offset[2]);
  } else {
    offset = (0, 0, 0);
  }

  self weaponlockfinalize(self.missilelaunchertarget, offset);
}

function gunship_watchweaponfired(gunner) {
  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    return;
  }

  gunner setclientomnvar("ui_killstreak_weapon_3_ammo", 30);
  gunner setclientomnvar("ui_killstreak_weapon_2_ammo", 10);
  gunner setclientomnvar("ui_killstreak_weapon_1_ammo", 1);
  level.var_f4d4b089abe644c1 = 0;

  if(getdvarint(@ "hash_f213fc40b2f63070") == 0) {
    function_8a3de080d0a85357(gunner);
    return;
  }

  function_e77db3847fe7a928(gunner);
}

function function_8a3de080d0a85357(gunner) {
  level.gunship.last_fired = 0;
  function_8e74c11aa6d09415();
  self.var_9acfd96babd08e79 = -6000;
  self.var_eb994a929b4e42db = -400;
  self.var_eba1d1929b57576e = -60;
  self.var_c56c107cfa9ba64 = -15000;

  if(getdvarint(@ "hash_cca85e49b724df8b")) {
    self.var_48ca513b655d8d82 = spawn_script_origin();
    self.var_48ca513b655d8d82 dontinterpolate();
    self.laser_ent = spawn("script_model", gunner.origin);
    self.laser_ent.angles = gunner.angles;
    self.laser_ent setModel("tag_laser");
    self.laser_ent setmoverlaserweapon("iw8_laser_painter_ac130_hellfire");
    self.laser_ent linkTo(gunner);

    if(isDefined(self.laser_ent)) {
      childthread function_762f335fd954ac86(gunner);
    }
  }

  gunner.weapon_reloading = 0;
  self.var_8e3a3e9ee646b4fd[level.gunship.var_d6604e5e3d0ba3b7] = level.weaponreloadtime[level.gunship.var_d6604e5e3d0ba3b7];
  self.var_8e3a3e9ee646b4fd[level.gunship.var_d6604d5e3d0ba184] = level.weaponreloadtime[level.gunship.var_d6604d5e3d0ba184];
  self.var_8e3a3e9ee646b4fd[level.gunship.var_d660505e3d0ba81d] = level.weaponreloadtime[level.gunship.var_d660505e3d0ba81d];
  self.var_8e3a3e9ee646b4fd[level.gunship.var_d6604f5e3d0ba5ea] = level.weaponreloadtime[level.gunship.var_d6604f5e3d0ba5ea];
  self.var_5dd2bd1c457222e4[level.gunship.var_d6604e5e3d0ba3b7] = -10000;
  self.var_5dd2bd1c457222e4[level.gunship.var_d6604d5e3d0ba184] = -10000;
  self.var_5dd2bd1c457222e4[level.gunship.var_d660505e3d0ba81d] = -10000;
  self.var_5dd2bd1c457222e4[level.gunship.var_d6604f5e3d0ba5ea] = -10000;
  childthread function_9725db675db06c76(gunner);
  childthread function_107efa77e29c6982(gunner);
}

function function_107efa77e29c6982(gunner) {
  for(;;) {
    gunner function_6479fdbe7cc682a2();

    if(flag("pauseCameraFocus")) {} else {
      waitframe();
      weapon_array = function_a79b46a6d3d7def();
      current_weapon_name = weapon_array[self.currentweaponindex];

      if(current_weapon_name == level.gunship.var_d660505e3d0ba81d) {} else if(!function_68083c19f479777f(current_weapon_name) && !function_c212a027758ef4cb(current_weapon_name)) {
        projectile = function_62b4daf15be3076a(gunner, current_weapon_name);

        if(isDefined(projectile)) {
          level.gunship.var_5dd2bd1c457222e4[current_weapon_name] = -10000;
          level.gunship.last_fired = gettime();
          function_e532fa04b8270904(current_weapon_name, gunner, projectile.var_872e9fd8a2a204b0);
          gunner notify("missile_fire", projectile, projectile.var_872e9fd8a2a204b0.weapon_object);
          gunner notify("gunship_fired", current_weapon_name);

          if(projectile.var_872e9fd8a2a204b0.currentammo <= 0) {
            gunner thread gunship_weaponreload(projectile.var_872e9fd8a2a204b0, self);
          }

          if(current_weapon_name != level.gunship.var_d6604f5e3d0ba5ea) {
            gunner childthread gunship_watchweaponimpact(projectile);
          }
        }
      }
    }

    waitframe();
  }
}

function function_9725db675db06c76(gunner) {
  childthread function_fe1296fe813dc527(gunner);

  for(;;) {
    gunner allowfire(0);
    gunner function_6479fdbe7cc682a2();

    if(flag("pauseCameraFocus")) {} else {
      weapon_array = function_a79b46a6d3d7def();
      current_weapon_name = weapon_array[self.currentweaponindex];

      if(getdvarint(@ "hash_ef7a4f0ffc468e7b") == 1) {
        if(current_weapon_name == level.gunship.var_d660505e3d0ba81d) {
          weapon = gunner getcurrentweapon();
          currentammo = gunner getweaponammoclip(weapon);

          if(currentammo <= 1) {
            if(!istrue(gunner.weapon_reloading)) {
              gunner thread function_6c7ef99bf5ba717f(weapon, self);
            }

            goto LOC_000000e9;
          } else {
            self.var_5dd2bd1c457222e4[current_weapon_name] = -10000;
            gunner allowfire(1);
            LOC_000000e9:
          }
          LOC_000000e9:
        }
        LOC_000000e9:
      }
      LOC_000000e9:
    }

    LOC_000000e9:
      waitframe();
  }
}

function function_6479fdbe7cc682a2() {
  while(!self attackButtonPressed() && !self function_b2fe5041369d64ff()) {
    waitframe();
  }
}

function function_fe1296fe813dc527(gunner) {
  while(true) {
    gunner waittill("missile_fire", projectile, weapon);

    if(weapon.basename != level.gunship.var_d660505e3d0ba81d || !isDefined(projectile) || istrue(projectile.gsc_spawned)) {
      continue;
    }

    rockets = getentarrayinradius("rocket", "code_classname", projectile.origin, 10);

    foreach(rocket in rockets) {
      if(isDefined(rocket)) {
        if(istrue(rocket.gsc_spawned)) {
          continue;
        }

        rocket delete();
      }
    }

    thread function_ed197229b9526e7c(gunner);
  }
}

function function_4741592aabb99bde(gunner) {
  gunner endon("end_firing");
  gunner endon("attack_released");
  gunner endon("attack_pressed");
  gunner endon("weapon_switch_pressed");
  level endon("gunshipWeaponReloading");

  while(true) {
    gunner waittill_any_3("begin_firing", "missile_fire", "weapon_fired");
    thread function_ed197229b9526e7c(gunner);
  }
}

function function_ed197229b9526e7c(gunner) {
  projectile = function_62b4daf15be3076a(gunner, level.gunship.var_d660505e3d0ba81d);
  gunner notify("gunship_fired", self.var_fff9e9244cd692a3.weapon_object.basename);
  gunner thread gunship_watchweaponimpact(projectile);
  projectile.var_872e9fd8a2a204b0 = self.var_fff9e9244cd692a3;
  projectile.weapon_obj = self.var_fff9e9244cd692a3.weapon_object;
  current_weapon = gunner getcurrentweapon();
  currentammo = gunner getweaponammoclip(current_weapon);
  gunner setclientomnvar("ui_killstreak_weapon_3_ammo", currentammo);
  level.gunship.last_fired = gettime();
  self.var_eba1d1929b57576e = gettime();

  if(getdvarint(@ "hash_6e0c4af8a30676b6", 1) == 1) {
    function_9c3a0606da40389d(self.var_fff9e9244cd692a3, gunner);
  }
}

function function_8e74c11aa6d09415() {
  weapon = makeweapon(level.gunship.var_d660505e3d0ba81d);
  self.var_fff9e9244cd692a3 = function_8d01239b5d6b7cae(level.gunship.var_d660505e3d0ba81d, weapon);
  weapon = makeweapon(level.gunship.var_d6604d5e3d0ba184);
  self.var_fff100244ccca68a = function_8d01239b5d6b7cae(level.gunship.var_d6604d5e3d0ba184, weapon);

  if(getdvarint(@ "hash_80478c6f0f12492a")) {
    weapon = makeweapon(level.gunship.var_d6604e5e3d0ba3b7);
    self.var_f4364bd51b414686 = function_8d01239b5d6b7cae(level.gunship.var_d6604e5e3d0ba3b7, weapon);
    return;
  }

  weapon = makeweapon(level.gunship.var_d6604f5e3d0ba5ea);
  self.var_e90a9a2f31633c19 = function_8d01239b5d6b7cae(level.gunship.var_d6604e5e3d0ba3b7, weapon);
}

function function_878e144349832994(gunner) {
  if(flag("igc_start")) {
    return gunner getcurrentweapon().basename;
  }

  if(getdvarint(@ "hash_f213fc40b2f63070") == 0) {
    weapon_array[1] = level.gunship.var_d660505e3d0ba81d;
    weapon_array[2] = level.gunship.var_d6604d5e3d0ba184;

    if(getdvarint(@ "hash_80478c6f0f12492a")) {
      weapon_array[3] = level.gunship.var_d6604e5e3d0ba3b7;
    } else {
      weapon_array[3] = level.gunship.var_d6604f5e3d0ba5ea;
    }

    return weapon_array[level.gunship.model_ent.currentweaponindex];
  }

  return gunner getcurrentweapon().basename;
}

function function_8d01239b5d6b7cae(weapon_name, weapon_object) {
  var_872e9fd8a2a204b0 = spawnStruct();
  var_872e9fd8a2a204b0.weapon_object = weapon_object;
  var_872e9fd8a2a204b0.weapon_name = weapon_name;
  var_872e9fd8a2a204b0.is_reloading = 0;

  if(getdvarint(@ "hash_f213fc40b2f63070") == 0) {
    if(weapon_name == level.gunship.var_d6604e5e3d0ba3b7) {
      var_872e9fd8a2a204b0.fire_sound = "weap_gunship_hellfire_fire_plr";
      var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_1_ammo";
      var_872e9fd8a2a204b0.currentammo = 1;
      var_872e9fd8a2a204b0.lowammo = 0.5;
      var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.4;
      var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 2;
      var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.4;
      var_872e9fd8a2a204b0.var_594669e3db1a123b = 2;
      var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.4;
      var_872e9fd8a2a204b0.var_59466ae3db1a146e = 2;
      var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
    } else if(weapon_name == level.gunship.var_d6604d5e3d0ba184) {
      var_872e9fd8a2a204b0.fire_sound = "weap_gunship_40mm_fire_plr";
      var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_2_ammo";
      var_872e9fd8a2a204b0.currentammo = 10;
      var_872e9fd8a2a204b0.lowammo = 5;
      var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.2;
      var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 1;
      var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.17;
      var_872e9fd8a2a204b0.var_594669e3db1a123b = 0.9;
      var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.12;
      var_872e9fd8a2a204b0.var_59466ae3db1a146e = 0.7;
      var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
    } else if(weapon_name == level.gunship.var_d660505e3d0ba81d) {
      var_872e9fd8a2a204b0.fire_sound = "weap_gunship_25mm_fire_plr";
      var_872e9fd8a2a204b0.var_9d9213e85cfe091f = "weap_gunship_25mm_atmo_plr";
      var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_3_ammo";
      var_872e9fd8a2a204b0.currentammo = 30;
      var_872e9fd8a2a204b0.lowammo = 15;
      var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.1;
      var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 0.9;
      var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.09;
      var_872e9fd8a2a204b0.var_594669e3db1a123b = 0.8;
      var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.07;
      var_872e9fd8a2a204b0.var_59466ae3db1a146e = 0.7;
      var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
    } else if(weapon_name == level.gunship.var_d6604f5e3d0ba5ea) {
      var_872e9fd8a2a204b0.fire_sound = "weap_gunship_hellfire_fire_plr";
      var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_1_ammo";
      var_872e9fd8a2a204b0.currentammo = 1;
      var_872e9fd8a2a204b0.lowammo = 0.5;
      var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.4;
      var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 2;
      var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.4;
      var_872e9fd8a2a204b0.var_594669e3db1a123b = 2;
      var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.4;
      var_872e9fd8a2a204b0.var_59466ae3db1a146e = 2;
      var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
      var_872e9fd8a2a204b0.var_55ba759bc54f065 = self.weapon_big.var_55ba759bc54f065;
    }
  } else if(weapon_name == level.gunship.var_d6604e5e3d0ba3b7) {
    var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_1_ammo";
    var_872e9fd8a2a204b0.currentammo = 1;
    var_872e9fd8a2a204b0.lowammo = 0.5;
    var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.4;
    var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 2;
    var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.4;
    var_872e9fd8a2a204b0.var_594669e3db1a123b = 2;
    var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.4;
    var_872e9fd8a2a204b0.var_59466ae3db1a146e = 2;
    var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
    var_872e9fd8a2a204b0.var_c93051491f15e796 = 1;
  } else if(weapon_name == level.gunship.var_d6604d5e3d0ba184) {
    var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_2_ammo";
    var_872e9fd8a2a204b0.currentammo = 10;
    var_872e9fd8a2a204b0.lowammo = 5;
    var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.2;
    var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 1;
    var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.17;
    var_872e9fd8a2a204b0.var_594669e3db1a123b = 0.9;
    var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.12;
    var_872e9fd8a2a204b0.var_59466ae3db1a146e = 0.7;
    var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
  } else if(weapon_name == level.gunship.var_d660505e3d0ba81d) {
    var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_3_ammo";
    var_872e9fd8a2a204b0.currentammo = 30;
    var_872e9fd8a2a204b0.lowammo = 15;
    var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.1;
    var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 0.9;
    var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.09;
    var_872e9fd8a2a204b0.var_594669e3db1a123b = 0.8;
    var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.07;
    var_872e9fd8a2a204b0.var_59466ae3db1a146e = 0.7;
    var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
  } else if(weapon_name == level.gunship.var_d6604f5e3d0ba5ea) {
    var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b = "ui_killstreak_weapon_1_ammo";
    var_872e9fd8a2a204b0.currentammo = 1;
    var_872e9fd8a2a204b0.lowammo = 0.5;
    var_872e9fd8a2a204b0.var_cba46164d7e3d10d = 0.4;
    var_872e9fd8a2a204b0.var_1634bb5b038f0036 = 2;
    var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa = 0.4;
    var_872e9fd8a2a204b0.var_594669e3db1a123b = 2;
    var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7 = 0.4;
    var_872e9fd8a2a204b0.var_59466ae3db1a146e = 2;
    var_872e9fd8a2a204b0.var_ff92ac57cc8a2795 = 100;
    var_872e9fd8a2a204b0.var_55ba759bc54f065 = self.weapon_big.var_55ba759bc54f065;
  }

  return var_872e9fd8a2a204b0;
}

function function_e592b315177a68ac(weapon_name) {
  weapon_object = undefined;

  if(weapon_name == level.gunship.var_d6604e5e3d0ba3b7) {
    weapon_object = self.var_f4364bd51b414686.weapon_object;
  } else if(weapon_name == level.gunship.var_d6604d5e3d0ba184) {
    weapon_object = self.var_fff100244ccca68a.weapon_object;
  } else if(weapon_name == level.gunship.var_d660505e3d0ba81d) {
    weapon_object = self.var_fff9e9244cd692a3.weapon_object;
  } else if(weapon_name == level.gunship.var_d6604f5e3d0ba5ea) {
    weapon_object = self.var_e90a9a2f31633c19.weapon_object;
  }

  return weapon_object;
}

function function_f45ebfa891515d9b(weapon_name) {
  var_872e9fd8a2a204b0 = undefined;

  if(weapon_name == level.gunship.var_d6604e5e3d0ba3b7) {
    var_872e9fd8a2a204b0 = self.var_f4364bd51b414686;
  } else if(weapon_name == level.gunship.var_d6604d5e3d0ba184) {
    var_872e9fd8a2a204b0 = self.var_fff100244ccca68a;
  } else if(weapon_name == level.gunship.var_d660505e3d0ba81d) {
    var_872e9fd8a2a204b0 = self.var_fff9e9244cd692a3;
  } else if(weapon_name == level.gunship.var_d6604f5e3d0ba5ea) {
    var_872e9fd8a2a204b0 = self.var_e90a9a2f31633c19;
  }

  return var_872e9fd8a2a204b0;
}

function function_68083c19f479777f(weapon_name) {
  var_872e9fd8a2a204b0 = function_f45ebfa891515d9b(weapon_name);

  if(var_872e9fd8a2a204b0.currentammo <= 0) {
    return true;
  }

  return false;
}

function function_c212a027758ef4cb(weapon_name) {
  if(getdvarint(@ "player_sustainammo") == 1 && weapon_name == level.gunship.var_d6604f5e3d0ba5ea) {
    return false;
  }

  time_table[level.gunship.var_d6604e5e3d0ba3b7] = self.var_9acfd96babd08e79 + 6000;
  time_table[level.gunship.var_d6604d5e3d0ba184] = self.var_eb994a929b4e42db + 400;
  time_table[level.gunship.var_d660505e3d0ba81d] = self.var_eba1d1929b57576e + 60;
  time_table[level.gunship.var_d6604f5e3d0ba5ea] = self.var_c56c107cfa9ba64 + 15000;

  if(gettime() < time_table[weapon_name]) {
    return true;
  }

  return false;
}

function function_e532fa04b8270904(weapon_name, gunner, var_872e9fd8a2a204b0) {
  gunner playRumbleOnEntity("heavygun_fire");

  if(weapon_name == level.gunship.var_d6604e5e3d0ba3b7) {
    self.var_9acfd96babd08e79 = gettime();
  } else if(weapon_name == level.gunship.var_d6604d5e3d0ba184) {
    self.var_eb994a929b4e42db = gettime();
  } else if(weapon_name == level.gunship.var_d660505e3d0ba81d) {
    self.var_eba1d1929b57576e = gettime();
  } else if(weapon_name == level.gunship.var_d6604f5e3d0ba5ea) {
    self.var_c56c107cfa9ba64 = gettime();
  }

  if(var_872e9fd8a2a204b0.currentammo >= 0) {
    ammo = var_872e9fd8a2a204b0.currentammo;
  } else {
    ammo = 0;
  }

  gunner setclientomnvar(var_872e9fd8a2a204b0.var_2e068c0bf5f74f6b, ammo);

  if(getdvarint(@ "hash_f213fc40b2f63070") == 0) {
    gunner playlocalsound(var_872e9fd8a2a204b0.fire_sound);
  }

  if(isDefined(var_872e9fd8a2a204b0.var_9d9213e85cfe091f) && getdvarint(@ "hash_f213fc40b2f63070") == 0) {
    gunner playlocalsound(var_872e9fd8a2a204b0.var_9d9213e85cfe091f);
  }

  if(getdvarint(@ "hash_6e0c4af8a30676b6", 1) == 1) {
    function_9c3a0606da40389d(var_872e9fd8a2a204b0, gunner);
  }
}

function function_9c3a0606da40389d(var_872e9fd8a2a204b0, gunner) {
  if(gunner scripts\engine\sp\utility::isads()) {
    quick_scale = var_872e9fd8a2a204b0.var_c9669a0bc1b9bdc7;
    var_c93051491f15e796 = var_872e9fd8a2a204b0.var_59466ae3db1a146e;
  } else {
    quick_scale = var_872e9fd8a2a204b0.var_c9669b0bc1b9bffa;
    var_c93051491f15e796 = var_872e9fd8a2a204b0.var_594669e3db1a123b;
  }

  earthquake(quick_scale, var_c93051491f15e796, gunner.origin, var_872e9fd8a2a204b0.var_ff92ac57cc8a2795);
}

function function_62b4daf15be3076a(gunner, weapon_name) {
  var_872e9fd8a2a204b0 = function_f45ebfa891515d9b(weapon_name);
  full_trace = function_6b7ff0cd994a7fe(gunner);
  projectile_start = gunner.origin;
  impact_pos = full_trace["position"];

  if(weapon_name != level.gunship.var_d6604f5e3d0ba5ea) {
    gunship_dist = distance(projectile_start, impact_pos);

    if(getdvarint(@ "hash_7a03222b5456284d") == 1) {
      if(gunship_dist > getdvarint(@ "hash_277f4c8bbc3d8083")) {
        original_start = projectile_start;
        max_range = getdvarint(@ "hash_277f4c8bbc3d8083");
        extra_dist = gunship_dist - max_range;
        offset_range = clamp(extra_dist, 0, getdvarint(@ "hash_86db6dd1d3fd9982"));
        dist = max_range + offset_range;
        var_799f9baa8717f283 = impact_pos - projectile_start;
        direction = vectorNormalize(var_799f9baa8717f283);
        projectile_start = impact_pos - direction * dist;

        if(getdvarint(@ "hash_3c74a0a5b381bbb3") == 1) {
          childthread draw_line_for_time(projectile_start, impact_pos, 1, 0, 1, 1);
          childthread draw_line_for_time(original_start, impact_pos, 1, 1, 1, 1);
        }
      }
    }

    if(weapon_name == level.gunship.var_d6604e5e3d0ba3b7) {
      impact_pos += randomvector(level.gunship.var_f81a604f04ca7c67);
      childthread function_749e3c5f99d50954("gunship_hellfire_crt", 0.1, 0.2, 0.5);
    } else if(weapon_name == level.gunship.var_d6604d5e3d0ba184) {
      impact_pos += randomvector(level.gunship.var_3878f8cac277eba);
      childthread function_749e3c5f99d50954("gunship_40mm_crt", 0.1, 0.1, 0.3);
    } else if(weapon_name == level.gunship.var_d660505e3d0ba81d) {
      impact_pos += randomvector(level.gunship.var_fe8115e13e88cccd);
      childthread function_749e3c5f99d50954("gunship_25mm_crt", 0.1, 0.1, 0.2);
    }

    projectile = magicbullet(weapon_name, projectile_start, impact_pos, gunner);
    projectile.gsc_spawned = 1;
  } else {
    childthread function_749e3c5f99d50954("gunship_hellfire_crt", 0.1, 0.2, 0.5);
    projectile = function_1e214468bc811f40(projectile_start, impact_pos, gunner);
  }

  if(!isDefined(projectile)) {
    return;
  }

  level.var_1250917a0280ae9 = array_add(level.var_1250917a0280ae9, projectile);
  projectile.var_872e9fd8a2a204b0 = var_872e9fd8a2a204b0;
  level notify("gunship_weapon_fired", projectile, weapon_name, impact_pos);

  if(projectile.var_872e9fd8a2a204b0.currentammo > 0) {
    if(getdvarint(@ "player_sustainammo") == 0) {
      projectile.var_872e9fd8a2a204b0.currentammo--;
    }
  }

  thread function_3c14d5bc5161b85b(projectile, impact_pos, weapon_name);
  return projectile;
}

function function_749e3c5f99d50954(vision, fade_in, delay, fade_out) {
  if(flag("igc_start")) {
    return;
  }

  level notify("kill_crt_vision");
  level endon("kill_crt_vision");
  level endon("igc_start");
  visionsetfadetoblack(vision, fade_in);
  noself_delaycall(delay, &visionsetfadetoblack, "", fade_out);
}

function function_1e214468bc811f40(projectile_start, impact_pos, player) {
  missile = undefined;

  if(!flag("hellfire_system_busy") || getdvarint(@ "player_sustainammo") == 1) {
    if(getdvarint(@ "hash_cca85e49b724df8b") == 2) {
      missile = function_52ef54bd52ac31ce(self.var_48ca513b655d8d82, self.var_e90a9a2f31633c19, projectile_start, impact_pos, player);
      level notify("hellfire_missile_launched", missile, self.var_48ca513b655d8d82);

      if(utility::getdifficulty() != "hard" && utility::getdifficulty() != "fu") {
        if(getdvarint(@ "hash_d8d71cbe1098260e", 1) == 0) {
          thread utility::display_hint("vision_thermal", 5, undefined, missile);
        }
      }

      reloadtime = level.weaponreloadtime[missile.var_872e9fd8a2a204b0.weapon_object.basename];

      if(!isDefined(reloadtime) || reloadtime <= 0.1) {
        reloadtime = 0.1;
      }

      scripts\engine\sp\utility::delaychildthread(reloadtime, &function_3195e1aab4f57134);
    } else if(getdvarint(@ "hash_cca85e49b724df8b") == 1) {
      if(getdvarint(@ "hash_9adf55d0d617dfdd", 0)) {
        missile = function_52ef54bd52ac31ce(self.var_48ca513b655d8d82, self.var_e90a9a2f31633c19, projectile_start, impact_pos, player);
        level notify("hellfire_missile_launched", missile, self.var_48ca513b655d8d82);
        player thread function_81c81c8a63f53006(missile);
        reloadtime = level.weaponreloadtime[missile.var_872e9fd8a2a204b0.weapon_object.basename];

        if(!isDefined(reloadtime) || reloadtime <= 0.1) {
          reloadtime = 0.1;
        }

        scripts\engine\sp\utility::delaychildthread(reloadtime, &function_3195e1aab4f57134);
      } else {
        missile = player function_74ea1e4753949cee(projectile_start, impact_pos, self.var_e90a9a2f31633c19);
        player playlocalsound("gunship_105mm_sp_reload");
        reloadtime = level.weaponreloadtime[missile.var_872e9fd8a2a204b0.weapon_object.basename];

        if(!isDefined(reloadtime) || reloadtime <= 0.1) {
          reloadtime = 0.1;
        }

        scripts\engine\sp\utility::delaychildthread(reloadtime, &function_3195e1aab4f57134);
      }
    } else {
      while(player attackButtonPressed()) {
        result = player missilelauncherusage(impact_pos);

        if(istrue(result)) {
          missile = function_52ef54bd52ac31ce(player.missilelaunchertarget, self.var_e90a9a2f31633c19, projectile_start, impact_pos, player);
          level notify("hellfire_missile_launched", missile, self.var_48ca513b655d8d82);
          reloadtime = level.weaponreloadtime[missile.var_872e9fd8a2a204b0.weapon_object.basename];
          scripts\engine\sp\utility::delaychildthread(reloadtime, &function_3195e1aab4f57134);
          break;
        } else if(isDefined(player.var_aa1d1fe26ddb3042)) {
          hideheadiconfromplayersinmask(player.var_aa1d1fe26ddb3042);
        }

        waitframe();
      }

      player function_3e954d9a9a42058a();
      player function_f7e6f0d8bd63409d();
    }
  }

  return missile;
}

function function_81c81c8a63f53006(missile) {
  self freezelookcontrols(1);
  missile.type = "remote";
  missile setotherent(self);
  missile setentityowner(self);
  missile dontinterpolate();
  self cameralinkTo(missile, "tag_origin");
  self controlslinkTo(missile);
  self cameraset("killcam_car");
  self springcamdisabled(0);
  missile waittill("death");
  self cameraunlink();
  self controlsunlink();
  self freezelookcontrols(0);
}

function function_7ed3af1650bf961f(gunner, name) {
  current_fov = gunner playergetzoomfov();

  if(name == level.gunship.var_d6604e5e3d0ba3b7) {
    if(gunner adsButtonPressed()) {
      if(current_fov == level.var_285ce926ff345ee3) {
        earthquake(0.3, 1, gunner.origin, 100);
      } else if(current_fov == level.var_10a026b50d5be68f) {
        earthquake(0.4, 1, gunner.origin, 100);
      }
    } else {
      earthquake(0.2, 1, gunner.origin, 1000);
    }

    return;
  }

  if(name == level.gunship.var_d6604d5e3d0ba184) {
    if(gunner adsButtonPressed()) {
      if(current_fov == level.var_285ce926ff345ee3) {
        earthquake(0.2, 0.35, gunner.origin, 100);
      } else if(current_fov == level.var_10a026b50d5be68f) {
        earthquake(0.3, 0.35, gunner.origin, 100);
      }
    } else {
      earthquake(0.1, 0.35, gunner.origin, 1000);
    }

    return;
  }

  if(gunner adsButtonPressed()) {
    if(current_fov == level.var_285ce926ff345ee3) {
      earthquake(0.1, 0.1, gunner.origin, 100);
    } else if(current_fov == level.var_10a026b50d5be68f) {
      earthquake(0.1, 0.1, gunner.origin, 100);
    }

    return;
  }

  earthquake(0.1, 0.1, gunner.origin, 100);
}

function function_e77db3847fe7a928(gunner) {
  streakinfo = self.streakinfo;
  self.var_9acfd96babd08e79 = -6000;
  self.var_eb994a929b4e42db = -350;
  self.var_eba1d1929b57576e = -100;
  self.var_c56c107cfa9ba64 = -6000;

  if(getdvarint(@ "hash_cca85e49b724df8b")) {
    self.var_48ca513b655d8d82 = spawn_script_origin();
    self.var_48ca513b655d8d82 dontinterpolate();
    self.laser_ent = spawn("script_model", gunner.origin);
    self.laser_ent.angles = gunner.angles;
    self.laser_ent setModel("tag_laser");
    self.laser_ent setmoverlaserweapon("iw8_laser_painter_ac130_hellfire");
    self.laser_ent linkTo(gunner);

    if(isDefined(self.laser_ent)) {
      childthread function_762f335fd954ac86(gunner);
    }
  }

  while(true) {
    gunner waittill("missile_fire", projectile, weapon);
    projectile.var_872e9fd8a2a204b0 = weapon;
    function_e532fa04b8270904(weapon.basename, gunner, projectile.var_872e9fd8a2a204b0);
    gunner childthread gunship_watchweaponimpact(projectile);

    if(istrue(projectile.is_fake)) {
      continue;
    }

    projectile.streakinfo = streakinfo;
    streakinfo.shots_fired++;
    weapon = gunner getcurrentweapon();
    currentammo = gunner getweaponammoclip(weapon);
    gunner setclientomnvar("ui_killstreak_weapon_3_ammo", currentammo);

    if(weapon.basename == level.gunship.var_d6604e5e3d0ba3b7) {
      earthquake(0.2, 1, self.origin, 1000);
      gunner setclientomnvar("ui_killstreak_weapon_1_ammo", currentammo);
    } else if(weapon.basename == level.gunship.var_d6604d5e3d0ba184) {
      earthquake(0.1, 0.5, self.origin, 1000);
      gunner setclientomnvar("ui_killstreak_weapon_2_ammo", currentammo);
    } else if(weapon.basename == level.gunship.var_d660505e3d0ba81d) {
      earthquake(0.01, 0.1, self.origin, 1000);
      gunner setclientomnvar("ui_killstreak_weapon_3_ammo", currentammo);
    }

    if(currentammo == 0) {
      gunner thread function_6c7ef99bf5ba717f(weapon, self);
    }
  }
}

function gunship_watchweaponimpact(projectile) {
  level endon("missionfailed");
  weapon_name = projectile.var_872e9fd8a2a204b0.weapon_object.basename;

  if(isDefined(level.var_2825cd44d4091ad3)) {
    projectile childthread[[level.var_2825cd44d4091ad3]](projectile.var_872e9fd8a2a204b0.weapon_object);
  }

  projectile waittill("explode", position);
  level.var_1250917a0280ae9 = array_removeundefined(level.var_1250917a0280ae9);

  if(isDefined(projectile)) {
    function_7603c1bf75f42d23(projectile, position);
  }

  if(isDefined(level.var_26eff2bcd81ab5ef)) {
    self childthread[[level.var_26eff2bcd81ab5ef]](projectile);
  }

  if(weapon_name == level.gunship.var_d6604e5e3d0ba3b7) {
    impact_radius = 1200;
    var_84f1f2eb003fcb49 = "gunship_105mm_expl_radio";
  } else if(weapon_name == level.gunship.var_d6604d5e3d0ba184) {
    impact_radius = 1000;
    var_84f1f2eb003fcb49 = "gunship_40mm_expl_radio";
  } else {
    impact_radius = 600;
    var_84f1f2eb003fcb49 = "gunship_25mm_expl_radio";
  }

  ai_array = getaiarrayinradius(position, impact_radius, "axis", "neutral");
  ai_array = array_removedead_or_dying(ai_array);

  if(isDefined(level.var_e8e0eac736110e84) && ai_array.size > 0) {
    if(getdvarint(@ "hash_5da9c798d17a834", 0) == 1) {
      childthread draw_circle(position, impact_radius, (1, 1, 1), 1, 1, 5);
    }

    foreach(ai in ai_array) {
      ai childthread[[level.var_e8e0eac736110e84]]();
    }
  }

  ally_guys = getaiarray("allies");

  if(ally_guys.size > 0) {
    var_79df09a6d3e7f50c = getclosest(position, ally_guys, 10000);

    if(isDefined(var_79df09a6d3e7f50c) && isDefined(var_79df09a6d3e7f50c.origin) && isDefined(var_84f1f2eb003fcb49)) {
      thread function_4385b2a9645a3367(position, var_79df09a6d3e7f50c.origin, var_84f1f2eb003fcb49);
    }
  }

  level notify("gunship_weapon_impact", position, weapon_name);
}

function function_7603c1bf75f42d23(projectile, position) {
  thread function_88486e4d549c70fd();
  function_951c157530869992();

  if(isDefined(level.gunship.var_e8435f0da7909b0c)) {
    struct = level[[level.gunship.var_e8435f0da7909b0c]](projectile, position);
  } else {
    struct = spawnStruct();
    struct.origin = ter_op(isDefined(projectile), projectile.origin, position);
    struct.time = gettime();
    struct.endtime = gettime() + 3000;
    name = projectile.var_872e9fd8a2a204b0.weapon_object.basename;

    if(name == "gunship_40mm_jup_sp") {
      struct.var_ceffcb0d6eeac4e6 = 1000;
      struct.var_cedcbd0d6ec45e64 = 600;
      struct.radius = 100;
    } else if(name == "gunship_25mm_jup_sp") {
      struct.var_ceffcb0d6eeac4e6 = 600;
      struct.var_cedcbd0d6ec45e64 = 300;
      struct.radius = 32;
    } else {
      struct.var_ceffcb0d6eeac4e6 = 1300;
      struct.var_cedcbd0d6ec45e64 = 900;
      struct.radius = 200;
    }
  }

  struct function_c2e0f7f0c4bb85d1(projectile.var_872e9fd8a2a204b0.weapon_object.basename);
  struct.var_c5f1b9c2e07616f4 = squared(struct.var_ceffcb0d6eeac4e6);
  function_4c00902b6e16e596(struct);
  level.gunship.var_b16fecb954d8b304[level.gunship.var_b16fecb954d8b304.size] = struct;
  level.gunship.var_c8122d8b582aef7f = struct;
}

function function_c2e0f7f0c4bb85d1(weaponname) {
  if(!isDefined(level.var_38cc5d7e5cd33606)) {
    return;
  }

  volumes = sortbydistancecullbyradius(level.var_38cc5d7e5cd33606, self.origin, 2000);

  if(!isDefined(volumes) || volumes.size < 1) {
    return;
  }

  foreach(volume in volumes) {
    if(ispointinvolume(self.origin, volume)) {
      scripts\sp\player_death::clear_custom_death_quote();

      if(isDefined(volume.script_noteworthy)) {
        should_fail = volume function_d875862b1eb9b973(self.origin);

        if(!should_fail) {
          return;
        }
      } else {
        level.player thread scripts\anim\dialogue::say_global(level.var_5ed1147d2ab9e8c7 deck_draw(), 1, 3, 1);
        index = [205, 206, 207];
        scripts\sp\player_death::set_custom_death_quote(array_randomize(index)[0]);
      }

      thread scripts\sp\utility::missionfailedwrapper();
      break;
    }
  }
}

function function_d875862b1eb9b973(point) {
  should_fail = 1;

  switch (self.script_noteworthy) {
    case #"hash_31ccf4980e7b0f42":
      fail_volume = getEnt(self.target, "targetname");

      if(ispointinvolume(point, fail_volume)) {
        if(time_has_passed(level.var_ad5a633b8c435221, 2)) {
          level.player thread scripts\anim\dialogue::say_global(level.var_d3fa99d1d6eebdce deck_draw(), 1, 3, 1);
        }

        scripts\sp\player_death::set_custom_death_quote(244);
      } else {
        if(time_has_passed(level.var_ad5a633b8c435221, 5)) {
          level.player thread scripts\anim\dialogue::say_global(level.var_f6651053df0e9bd8 deck_draw(), 1, 3);
        }

        level.var_ad5a633b8c435221 = gettime();
        should_fail = 0;
      }

      break;
    case #"hash_6d3a25e948c612e":
      level.player thread scripts\anim\dialogue::say_global(level.var_5ed1147d2ab9e8c7 deck_draw(), 1, 3, 1);
      scripts\sp\player_death::set_custom_death_quote(245);
    default:
      level.player thread scripts\anim\dialogue::say_global(level.var_5ed1147d2ab9e8c7 deck_draw(), 1, 3, 1);
      index = [205, 206, 207];
      scripts\sp\player_death::set_custom_death_quote(array_randomize(index)[0]);
      break;
  }

  return should_fail;
}

function function_4c00902b6e16e596(newstruct) {
  level.gunship.var_b16fecb954d8b304 = utility::array_removeundefined(level.gunship.var_b16fecb954d8b304);

  if(!isDefined(newstruct) || !isDefined(newstruct.origin)) {
    return;
  }

  newarray = [];
  radiussqrd = squared(newstruct.radius);

  if(!isDefined(radiussqrd)) {
    return;
  }

  foreach(struct in level.gunship.var_b16fecb954d8b304) {
    if(!isDefined(newstruct) || !isDefined(struct) || !isDefined(struct.origin) || distance2dsquared(newstruct.origin, struct.origin) < radiussqrd) {
      continue;
    }

    newarray[newarray.size] = struct;
  }

  newarray = utility::array_removeundefined(newarray);
  level.gunship.var_b16fecb954d8b304 = newarray;
}

function function_951c157530869992() {
  newarray = [];

  foreach(struct in level.gunship.var_b16fecb954d8b304) {
    if(gettime() > struct.endtime) {
      continue;
    }

    newarray[newarray.size] = struct;
  }

  level.gunship.var_b16fecb954d8b304 = newarray;
}

function function_88486e4d549c70fd() {
  if(istrue(level.var_88486e4d549c70fd)) {
    return;
  }

  if(!getdvarint(@ "hash_f2f36ad676e3835b") > 0) {
    return;
  }

  level.var_88486e4d549c70fd = 1;

  while(true) {
    foreach(struct in level.gunship.var_b16fecb954d8b304) {
      print3d(struct.origin, index);
      draw_circle(struct.origin, struct.radius, (1, 1, 1), 1, 1, 1);
    }

    waitframe();
  }
}

function function_3c14d5bc5161b85b(projectile, impact_pos, weapon_name) {
  ally_guys = getaiarray("allies");
  ally_guys = array_removeundefined(ally_guys);
  var_37fe41e9dc3c8f22 = 0;
  var_932ed5ee822e94d1 = 0;
  var_1060354d0d90695 = "null";

  if(isDefined(projectile) && ally_guys.size > 0) {
    var_1bcac4fa3002540a = getclosest(impact_pos, ally_guys, 10000);

    if(!isDefined(var_1bcac4fa3002540a)) {
      return;
    }

    var_2bddcec8c3aac97f = distancesquared(var_1bcac4fa3002540a.origin, impact_pos);
    var_256b40591aa1085c = distancesquared(projectile.origin, impact_pos);
    var_7965f3906b55049a = 0;
    var_1060354d0d90695 = "null";

    if(weapon_name == level.gunship.var_d6604e5e3d0ba3b7 || weapon_name == level.gunship.var_d6604f5e3d0ba5ea) {
      var_932ed5ee822e94d1 = 1;
      var_1060354d0d90695 = "gunship_105mm_incoming_radio";
      var_7c2c2a9ae1434824 = 4840000;
      close_dist = 25000000;
      far_dist = 144000000;

      if(getDvar(@ "g_mapname") == "gunship_compound") {
        var_7965f3906b55049a = 81000000;
      } else {
        var_7965f3906b55049a = 125000000;
      }
    } else if(weapon_name == level.gunship.var_d6604d5e3d0ba184) {
      var_1060354d0d90695 = "gunship_40mm_incoming_radio";
      var_7c2c2a9ae1434824 = 1000000;
      close_dist = 12250000;
      far_dist = 49000000;

      if(getDvar(@ "g_mapname") == "gunship_compound") {
        var_7965f3906b55049a = 121000000;
      } else {
        var_7965f3906b55049a = 43000000;
      }
    } else {
      var_37fe41e9dc3c8f22 = 1;
      var_1060354d0d90695 = "gunship_25mm_incoming_radio";
      var_7c2c2a9ae1434824 = 360000;
      close_dist = 3240000;
      far_dist = 10240000;

      if(getDvar(@ "g_mapname") == "gunship_compound") {
        var_7965f3906b55049a = 121000000;
      } else {
        var_7965f3906b55049a = 43000000;
      }
    }

    if(isDefined(close_dist) && isDefined(far_dist) && isDefined(var_1060354d0d90695)) {
      if(var_2bddcec8c3aac97f <= var_7c2c2a9ae1434824) {
        var_1060354d0d90695 += "_super_close";
      } else if(var_7c2c2a9ae1434824 < var_2bddcec8c3aac97f && var_2bddcec8c3aac97f < far_dist) {
        if(var_37fe41e9dc3c8f22) {
          return;
        }
      } else if(var_2bddcec8c3aac97f >= far_dist) {
        if(!var_932ed5ee822e94d1) {
          return;
        }

        var_1060354d0d90695 += "_dist";
      }

      projectile.projectile_sfx = spawn("script_origin", projectile.origin);
      projectile.projectile_sfx linkTo(projectile);

      if(var_7965f3906b55049a > 0) {
        while(isDefined(projectile) && isDefined(var_1bcac4fa3002540a) && var_256b40591aa1085c > var_7965f3906b55049a) {
          var_256b40591aa1085c = distancesquared(projectile.origin, var_1bcac4fa3002540a.origin);
          wait 0.1;
        }
      }

      if(isDefined(projectile.projectile_sfx)) {
        projectile.projectile_sfx playSound(var_1060354d0d90695);
        projectile waittill("explode", position);

        if(isDefined(projectile.projectile_sfx)) {
          projectile.projectile_sfx stopsounds();
        }

        waitframe();

        if(isDefined(projectile.projectile_sfx)) {
          projectile.projectile_sfx delete();
        }
      }
    }
  }
}

function function_4385b2a9645a3367(fxent_pos, speaker_origin, var_84f1f2eb003fcb49) {
  var_f42faa1f833d3355 = distancesquared(fxent_pos, speaker_origin);

  switch (var_84f1f2eb003fcb49) {
    case #"hash_805b5a79f644cfce":
      sound = "exp_gunship_hellfire_dist";
      var_7c2c2a9ae1434824 = 4840000;
      close_dist = 25000000;
      far_dist = 144000000;
      break;
    case #"hash_a24437cb194e01fe":
      sound = "exp_gunship_40mm_dist";
      var_7c2c2a9ae1434824 = 1000000;
      close_dist = 12250000;
      far_dist = 49000000;
      break;
    case #"hash_3413b6c430da1aed":
      sound = "prj_bullet_large_plr_far";
      var_7c2c2a9ae1434824 = 360000;
      close_dist = 3240000;
      far_dist = 10240000;
      break;
    default:
      sound = undefined;
      var_7c2c2a9ae1434824 = undefined;
      close_dist = undefined;
      far_dist = undefined;
      break;
  }

  level.player playSound(sound);

  if(isDefined(close_dist) && isDefined(far_dist)) {
    if(var_f42faa1f833d3355 < var_7c2c2a9ae1434824) {
      level.player playSound(var_84f1f2eb003fcb49 + "_dist");
      return;
    }

    if(var_f42faa1f833d3355 < close_dist) {
      level.player playSound(var_84f1f2eb003fcb49);
      return;
    }

    if(var_f42faa1f833d3355 < far_dist) {
      level.player playSound(var_84f1f2eb003fcb49 + "_dist");
    }
  }
}

function function_6c7ef99bf5ba717f(weapon, gunship) {
  gunship endon("death");
  gunship endon("crashing");
  gunship endon("leaving");
  self endon("disconnect");
  level endon("game_ended");
  level notify("gunshipWeaponReloading");
  self.weapon_reloading = 1;
  self setweaponammoclip(weapon, 0);

  if(weapon.basename == level.gunship.var_d6604f5e3d0ba5ea) {
    weaponrootname = "gunship_hellfire";
  } else {
    weaponrootname = getgunshipweaponrootname(weapon);
  }

  if(!isDefined(weaponrootname)) {
    return;
  }

  if(weaponrootname != "gunship_hellfire") {
    if(issubstr(weaponrootname, "40mm")) {
      self playlocalsound("gunship__40mm_sp_reload");
    } else if(issubstr(weaponrootname, "25mm")) {
      self playlocalsound("gunship_25mm_sp_reload");
    } else if(issubstr(weaponrootname, "105mm")) {
      if(soundexists("gunship_105mm_sp_reload")) {
        self playlocalsound("gunship_105mm_sp_reload");
      } else {
        self playlocalsound("ac130_105mm_mp_reload");
      }
    }
  }

  thread function_31eca0d2996fb0fe();
  var_f3fc82c371854578 = undefined;

  switch (weaponrootname) {
    case #"hash_a595cc01d9fdb1c3":
      var_f3fc82c371854578 = "ui_killstreak_weapon_1_ammo";
      break;
    case #"hash_f7dc9df20da28f2":
      var_f3fc82c371854578 = "ui_killstreak_weapon_2_ammo";
      break;
    case #"hash_9e7bbed3c5c35ca3":
      var_f3fc82c371854578 = "ui_killstreak_weapon_3_ammo";
      break;
  }

  self setclientomnvar(var_f3fc82c371854578, 0);
  gunship_waitforweaponreloadtime(weapon, weaponrootname);
  level notify("gunshipWeaponReloaded");
  thread function_3ce5a109653aad93();
  maxammo = weaponmaxammo(weapon);
  self setweaponammoclip(weapon, maxammo);
  self givemaxammo(weapon);
  self setclientomnvar(var_f3fc82c371854578, maxammo);
  self.weapon_reloading = 0;
}

function getmissileexplscale(weaponname) {
  scale = 1;

  if(weaponname == level.gunship.var_d6604e5e3d0ba3b7) {
    scale = 0.75;
  } else if(weaponname == level.gunship.var_d6604d5e3d0ba184) {
    scale = 0.5;
  } else if(weaponname == level.gunship.var_d660505e3d0ba81d) {
    scale = 0.15;
  }

  return scale;
}

function getmissileexplradius(weaponname) {
  radius = 1;

  if(weaponname == level.gunship.var_d6604e5e3d0ba3b7) {
    radius = 2000;
  } else if(weaponname == level.gunship.var_d6604d5e3d0ba184) {
    radius = 1300;
  } else if(weaponname == level.gunship.var_d660505e3d0ba81d) {
    radius = 700;
  }

  return radius;
}

function deleteaftertime(delay) {
  self endon("death");
  self delete();
}

function gunship_watch105mmexplosion(gunship, gunner) {
  gunship endon("death");
  gunship endon("leaving");
  gunship endon("crashing");
  self waittill("death");
  earthquake(0.125, 0.5, gunship.origin, 1000);
}

function gunship_getvisionsetformat(currentvisionset) {
  return ter_op(issubstr(currentvisionset, "flir"), "flir", "color");
}

function gunship_getvisionset(format, strength) {
  visionset = undefined;

  if(isDefined(strength)) {
    if(format == "flir") {
      visionset = level.gunship.thermal_vision;
    } else {
      visionset = level.gunship.color_vision;
    }
  } else {
    visionset = "generic_glitch";
  }

  return visionset;
}

function gunship_weaponreload(var_872e9fd8a2a204b0, gunship, reloadtime) {
  gunship endon("death");
  gunship endon("crashing");
  gunship endon("leaving");
  level endon("missionfailed");
  level notify("gunshipWeaponReloading");
  weapon = var_872e9fd8a2a204b0.weapon_object;

  if(weapon.basename == level.gunship.var_d6604f5e3d0ba5ea) {
    weaponrootname = "gunship_hellfire";
  } else {
    weaponrootname = getgunshipweaponrootname(weapon);
  }

  if(weaponrootname != "gunship_hellfire") {
    reloadsound = weaponrootname + "_sp_reload";
    var_dd020944ee631ba8 = strtok(weaponrootname, "_");

    if(var_dd020944ee631ba8[0] == "gunship") {
      reloadsound = "gunship";

      for(i = 1; i < var_dd020944ee631ba8.size; i++) {
        appendstring = var_dd020944ee631ba8[i];

        if(appendstring == "hellfire") {
          appendstring = "105mm";
        }

        reloadsound = reloadsound + "_" + appendstring;
      }

      reloadsound += "_sp_reload";
    }

    self playlocalsound(reloadsound);
  }

  var_872e9fd8a2a204b0.is_reloading = 1;

  if(weaponrootname != "gunship_hellfire") {
    thread function_31eca0d2996fb0fe(weapon.basename);
  }

  gunship_waitforweaponreloadtime(weapon, weaponrootname, reloadtime);
  thread function_3ce5a109653aad93(weapon.basename);
  var_872e9fd8a2a204b0.is_reloading = 0;
  function_7bf095a48de1e9b6(var_872e9fd8a2a204b0, weaponrootname);
}

function function_31eca0d2996fb0fe(var_24a61f7d6e58bc2) {
  if(!isDefined(level.var_b1c38a076b2f9945)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_offthetrigger";
    aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_reloading";
    aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_blackonammostandby";
    aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_loadingrounds";
    level.var_b1c38a076b2f9945 = create_deck(aliases, 1, 1);
  }

  if(percent_chance(50) || istrue(level.var_9683ea2462b2baa)) {
    return;
  }

  if(isDefined(level.var_1830fb97f0092f1b) && !time_has_passed(level.var_1830fb97f0092f1b, 20)) {
    return;
  }

  waitframe();
  var_af8c37639cd4f153 = function_878e144349832994(level.player);

  if(!is_equal(var_af8c37639cd4f153, var_24a61f7d6e58bc2)) {
    return;
  }

  alias = level.var_b1c38a076b2f9945 deck_draw();
  said_line = level.player scripts\anim\dialogue::say_global(alias, 0, 0);

  if(isDefined(said_line) && !said_line) {
    level.var_b1c38a076b2f9945.index--;
    return;
  }

  level.var_1830fb97f0092f1b = gettime();
}

function function_3ce5a109653aad93(var_24a61f7d6e58bc2) {
  if(!isDefined(level.var_dc428e4d058c984e)) {
    aliases = [];
    aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_backonthetrigger";
    aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_onthetrigger_01";
    aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_imgreen";
    aliases[aliases.size] = "dx_sp_jsgs_psh1_sgun_gunsready";
    level.var_dc428e4d058c984e = create_deck(aliases, 1, 1);
    aliases = [];
    aliases[aliases.size] = "dx_sp_gscp_gnht_grav_copy";
    aliases[aliases.size] = "dx_sp_gscp_gnht_grav_youreclearedhot";
    aliases[aliases.size] = "dx_sp_gscp_gnht_grav_cleartoengage";
    level.var_9c66f49550bcc614 = create_deck(aliases, 1, 1);
  }

  if(percent_chance(35) || istrue(level.var_9683ea2462b2baa)) {
    return;
  }

  if(isDefined(level.var_1830fb97f0092f1b) && !time_has_passed(level.var_1830fb97f0092f1b, 8)) {
    return;
  }

  if(isDefined(level.var_790be18164c912ac) && !time_has_passed(level.var_790be18164c912ac, 16)) {
    return;
  }

  var_af8c37639cd4f153 = function_878e144349832994(level.player);

  if(!is_equal(var_af8c37639cd4f153, var_24a61f7d6e58bc2)) {
    return;
  }

  alias = level.var_dc428e4d058c984e deck_draw();
  said_line = level.player scripts\anim\dialogue::say_global(alias, 0, 0);

  if(isDefined(said_line) && !said_line) {
    level.var_dc428e4d058c984e.index--;
    return;
  }

  level.var_790be18164c912ac = gettime();
}

function function_7bf095a48de1e9b6(var_872e9fd8a2a204b0, weaponrootname) {
  var_f3fc82c371854578 = undefined;
  weapon = var_872e9fd8a2a204b0.weapon_object;

  switch (weaponrootname) {
    case #"hash_1aa0b38da9c6a002":
      var_f3fc82c371854578 = "ui_killstreak_weapon_1_ammo";
      var_872e9fd8a2a204b0.currentammo = 1;
      break;
    case #"hash_f7dc9df20da28f2":
      var_f3fc82c371854578 = "ui_killstreak_weapon_2_ammo";
      var_872e9fd8a2a204b0.currentammo = 10;
      break;
    case #"hash_9e7bbed3c5c35ca3":
      var_f3fc82c371854578 = "ui_killstreak_weapon_3_ammo";
      var_872e9fd8a2a204b0.currentammo = 30;
      break;
    case #"hash_a595cc01d9fdb1c3":
      var_f3fc82c371854578 = "ui_killstreak_weapon_1_ammo";
      var_872e9fd8a2a204b0.currentammo = 1;
      break;
  }

  if(getdvarint(@ "hash_f213fc40b2f63070") == 0) {
    self setclientomnvar(var_f3fc82c371854578, var_872e9fd8a2a204b0.currentammo);
    return;
  }

  maxammo = weaponmaxammo(weapon);
  self setweaponammoclip(weapon, maxammo);
  self setclientomnvar(var_f3fc82c371854578, maxammo);
}

function getgunshipweaponrootname(weapon) {
  index = 0;
  weaponname = weapon.basename;
  tokens = strtok(weaponname, "_");

  if(isDefined(tokens[index]) && isDefined(tokens[index + 1])) {
    return (tokens[index] + "_" + tokens[index + 1]);
  }
}

function gunship_waitforweaponreloadtime(weapon, weaponrootname, reloadtime) {
  reloadtime = utility::default_to(reloadtime, level.weaponreloadtime[weapon.basename]);
  var_d7dac94935945aab = undefined;

  switch (weaponrootname) {
    case #"hash_1aa0b38da9c6a002":
      self playRumbleOnEntity("grenade_rumble");
      var_d7dac94935945aab = "ui_killstreak_weapon_1_reloadtime";
      break;
    case #"hash_f7dc9df20da28f2":
      self playRumbleOnEntity("damage_heavy");
      var_d7dac94935945aab = "ui_killstreak_weapon_2_reloadtime";
      break;
    case #"hash_9e7bbed3c5c35ca3":
      self playRumbleOnEntity("damage_light");
      var_d7dac94935945aab = "ui_killstreak_weapon_3_reloadtime";
      break;
    case #"hash_a595cc01d9fdb1c3":
      self playRumbleOnEntity("grenade_rumble");
      var_d7dac94935945aab = "ui_killstreak_weapon_1_reloadtime";
      break;
    default:
      self playRumbleOnEntity("damage_light");
      var_d7dac94935945aab = "ui_killstreak_weapon_3_reloadtime";
      break;
  }

  self setclientomnvar(var_d7dac94935945aab, gettime() + int(reloadtime * 1000));
  start = gettime();

  while(!time_has_passed(start, reloadtime)) {
    waitframe();
  }
}

function gunship_watchthermaltoggle(gunner) {
  level endon("stop_gunship");

  if(!isai(gunner)) {
    gunner thread watchthermalinputchange();
  }

  gunship_watchthermaltoggleinternal(gunner);

  if(isDefined(gunner) && !isai(gunner)) {
    gunner stopwatchingthermalinputchange();
  }
}

function watchthermalinputchange() {
  self notify("watch_thermal_input_change");
  self endon("watch_thermal_input_change");

  while(true) {
    self notifyonplayercommand("switch_thermal_mode", "+stance");
    self notifyonplayercommand("switch_thermal_mode", "nightvision");
    returnednotif = waittill_any_return_no_endon_death("input_type_changed", "thermal_handling_ended");
    self notifyonplayercommandremove("switch_thermal_mode", "+stance");
    self notifyonplayercommandremove("switch_thermal_mode", "nightvision");

    if(isDefined(returnednotif) && returnednotif == "thermal_handling_ended") {
      break;
    }
  }
}

function gunship_watchthermaltoggleinternal(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  togglethermal = 0;
  childthread function_7f4e781be563fb35(gunner);
  visionsetthermal(function_9f3eab80e442080c(), 0);
  visionsetnaked(level.gunship.color_vision, 0);

  if(istrue(level.var_5a3f504f0ddbd74f) || istrue(level.var_c944986665da028e)) {
    togglethermal = function_6e2aea1ddbc2e01c(1, gunner);

    if(istrue(level.var_c944986665da028e)) {
      return;
    }
  } else {
    togglethermal = function_6e2aea1ddbc2e01c(togglethermal, gunner);
  }

  for(;;) {
    gunner waittill("switch_thermal_mode");

    if(!istrue(level.var_67f5d508f1c46e99)) {} else {
      togglethermal = function_6e2aea1ddbc2e01c(togglethermal, gunner);
    }

    wait 0.1;
  }
}

function function_fe27c1e81c4cc974(gunner) {
  while(true) {
    button = gunner waittill_any_return_2("ads_pressed");
    zoomfov = gunner playergetzoomfov();

    if(gunner playerads() > 0.1) {
      if(zoomfov > level.var_10a026b50d5be68f) {
        if(button == "sprint_pressed") {
          self playSound("ui_gunship_max_zoom_out");
        }

        continue;
      }

      if(button == "sprint_pressed") {
        self playSound("ui_gunship_max_zoom_in");
      }

      childthread function_749e3c5f99d50954("gunship_ads_shutter_crt", 0.025, 0.08, 0.15);
    }

    waitframe();
  }
}

function function_6e2aea1ddbc2e01c(togglethermal, gunner) {
  if(istrue(togglethermal)) {
    thermal_on(gunner);
    return 0;
  }

  color_on(gunner);
  return 1;
}

function function_7f4e781be563fb35(gunner) {
  childthread function_72426610ef19f267(gunner);

  while(true) {
    zoomfov = gunner playergetzoomfov();

    if(isDefined(level.var_d1743a1b355dadc9)) {
      self childthread[[level.var_d1743a1b355dadc9]](zoomfov, self.currentvisionset, level.var_10a026b50d5be68f);
    }

    waitframe();
  }
}

function function_72426610ef19f267(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  gunner endon("disconnect");
  level endon("game_ended");
  lerptime = 0.15;
  currentfov = level.var_fb13600ef005ed60;
  var_d54d564805c29b7b = undefined;
  var_19b401437b24b05 = 0;

  while(true) {
    if(gunner adsButtonPressed()) {
      var_19b401437b24b05 += 0.05;

      if(var_19b401437b24b05 >= lerptime) {
        var_19b401437b24b05 = lerptime;
      }
    } else if(var_19b401437b24b05 > 0) {
      var_19b401437b24b05 -= 0.05;

      if(var_19b401437b24b05 <= 0) {
        var_19b401437b24b05 = 0;
      }
    }

    if(var_19b401437b24b05 >= 0) {
      var_d54d564805c29b7b = gunner playergetzoomfov();
      timeperc = var_19b401437b24b05 / lerptime * 100;
      currentfov = int(timeperc * (var_d54d564805c29b7b - level.var_fb13600ef005ed60) / 100 + level.var_fb13600ef005ed60);
    }

    gunner setclientomnvar("ui_killstreak_zoom_fov", currentfov);
    wait 0.05;
  }
}

function thermal_on(gunner) {
  gunner setclientomnvar("ui_apache_thermal_mode", 1);
  self.currentvisionset = function_9f3eab80e442080c();
  gunner function_e851921f869b27e9(1);
}

function function_9f3eab80e442080c() {
  return level.gunship.thermal_vision;
}

function color_on(gunner) {
  gunner setclientomnvar("ui_apache_thermal_mode", 3);
  self.currentvisionset = level.gunship.color_vision;
  gunner function_e851921f869b27e9(0, 1);
}

function function_e851921f869b27e9(bool, color_mode) {
  if(istrue(bool)) {
    flag_set("thermal_mode");
    visionsetthermal(level.gunship.model_ent.currentvisionset, 0);
    self thermalvisionon();
    return;
  }

  if(istrue(color_mode)) {
    flag_clear("thermal_mode");
    visionsetnaked(level.gunship.model_ent.currentvisionset, 0);
    self thermalvisionoff();
    return;
  }

  flag_clear("thermal_mode");
  visionsetnaked("");
  visionsetthermal("");
  visionsetfadetoblack("");
  visionsetalternate(0, 0);
  level.player thermalvisionoff();
}

function function_1779af5d454604ba() {
  level notify("kill_vision_dof");
  level endon("kill_vision_dof");

  if(scripts\engine\sp\utility::isads()) {
    zoomfov = self playergetzoomfov();
    thread scripts\sp\art::setdoftracerange(500);
  } else {
    thread scripts\sp\art::setdoftracerange(1000);
  }

  wait 0.1;
  thread scripts\sp\art::setdoftracerange(40000);
}

function function_859b892271f1a9f8(toggle) {
  guys = getaiarray();

  foreach(guy in guys) {
    guy function_33cce421690a0805(toggle);
  }
}

function function_33cce421690a0805(toggle) {
  if(!isDefined(toggle)) {
    toggle = flag("thermal_mode");
  }

  if(istrue(toggle)) {}
}

function function_c6a86e1307589615() {
  if(istrue(level.var_f1acd9be11d8efe5)) {
    self disablephysicaldepthoffieldscripting();
  }
}

function function_98e24029626f03b5(fstop, focusdistance) {
  if(istrue(level.var_f1acd9be11d8efe5)) {
    self enablephysicaldepthoffieldscripting();
    self setphysicaldepthoffield(12, 1000, 20, 20);
  }
}

function stopwatchingthermalinputchange() {
  self notify("thermal_handling_ended");
}

function gunship_watchdamage(gunner) {
  self endon("death");
  self endon("crashing");
  level endon("missionfailed");
  self.damagetaken = 0;
  self.attractor = missile_createattractorent(self, 1000, 4096);

  while(true) {
    self waittill("damage", damage, attacker, nill, nill, smeansofdeath, nill, nill, nill, nill, objweapon);

    if(is_equal(attacker, gunner)) {
      continue;
    }

    iprintlnbold("<dev string:xf5>");

    thirdpersoncam = undefined;

    thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

    if(isDefined(level.teambased) && isPlayer(attacker) && attacker.team == self.team && (!isDefined(thirdpersoncam) || !thirdpersoncam)) {
      continue;
    }

    if(smeansofdeath == "MOD_RIFLE_BULLET" || smeansofdeath == "MOD_PISTOL_BULLET" || smeansofdeath == "MOD_EXPLOSIVE_BULLET") {
      continue;
    }

    if(isDefined(self.owner) && self.owner isusinggunship()) {
      var_2acab75717ed1290 = "light";

      if(isexplosivedamagemod(smeansofdeath)) {
        if(ceil(damage / self.maxhealth) >= 0.33) {
          self.owner earthquakeforplayer(0.25, 0.2, self.camera.origin, 150);
          self.owner playRumbleOnEntity("damage_heavy");
          var_2acab75717ed1290 = "heavy";
        } else {
          self.owner earthquakeforplayer(0.15, 0.15, self.camera.origin, 150);
          self.owner playRumbleOnEntity("damage_light");
        }
      }

      thread gunship_screeninterference(0.2, var_2acab75717ed1290);
    }

    self.wasdamaged = 1;
    modifieddamage = undefined;
    self.damagetaken += modifieddamage;
    self.currenthealth = self.maxhealth - self.damagetaken;

    if(isDefined(self.owner) && self.owner isusinggunship()) {}

    if(self.currenthealth <= 500 && self.currentdamagestate == 0) {
      self.currentdamagestate = 1;
      self setscriptablepartstate("body_damage_light", "on");
    } else if(self.currenthealth <= 250 && self.currentdamagestate == 1) {
      self.currentdamagestate = 2;
      self setscriptablepartstate("body_damage_light", "off");
      self setscriptablepartstate("body_damage_medium", "on");

      if(isDefined(self.owner) && self.owner isusinggunship()) {
        self.owner playlocalsound("ks_ac130_damage_warning");
      }
    } else if(self.currenthealth <= 0 && self.currentdamagestate == 2) {
      self.currentdamagestate = 3;
      self setscriptablepartstate("body_damage_medium", "off");
      self setscriptablepartstate("contrails", "off");
      thread gunship_startengineblowoutfx();
    }

    if(self.damagetaken >= self.maxhealth) {
      streakname = self.streakinfo.streakname;
      damagetype = undefined;
      scorepopupname = "destroyed_" + streakname;
      leaderdialog = undefined;
      cardsplash = "callout_destroyed_" + streakname;
      skipdeathnotify = 1;
      thread gunship_crash(8, gunner);
    }
  }
}

function isusinggunship() {
  return isDefined(self.usinggunship);
}

function gunship_screeninterference(var_33cd555bf93321ad, var_5d9f02c7508f6b6c) {
  var_a95a67a21665324a = self.owner;
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(isDefined(var_a95a67a21665324a)) {
    var_676990f4bd19f5aa = gunship_getvisionsetformat(self.currentvisionset);
    visionset = gunship_getvisionset(var_676990f4bd19f5aa, var_5d9f02c7508f6b6c);

    if(var_676990f4bd19f5aa == "flir") {
      visionsetthermal(visionset, 0.1);
      var_a95a67a21665324a thermalvisionon();
    } else {
      visionsetnaked(visionset, 0.05);
    }

    if(isDefined(var_33cd555bf93321ad) && isDefined(self.currentvisionset)) {
      if(var_676990f4bd19f5aa == "flir") {
        visionsetthermal(self.currentvisionset, 0.1);
        var_a95a67a21665324a thermalvisionon();
        return;
      }

      visionsetnaked(self.currentvisionset, 0.05);
    }
  }
}

function gunship_startengineblowoutfx() {
  level endon("missionfailed");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "on");
  randomwait = randomfloatrange(0.5, 1);
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "on");
}

function gunship_crash(var_6fcc6072244f528d, gunner) {
  self notify("crashing");
  self.crashed = 1;

  if(!istrue(level.gunship_only)) {
    self show();

    if(!istrue(level.gunship_nolights)) {
      gunship_linklightfxent();
    }

    gunship_linkwingfxents();
  }

  thread gunship_movetocrashpos(var_6fcc6072244f528d);
}

function gunship_returnplayer(player) {
  level callback::callback("killstreak_finish_use", {
    #streakinfo: self.streakinfo
  });

  if(isDefined(player)) {
    thirdpersoncam = 0;

    thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

    if(!thirdpersoncam) {
      player gunship_stopshellshock();
      player gunship_allowstances(1);
    }

    level notify("stop_gunship");
    player setclientomnvar("ui_killstreak_weapon", 0);
    player setclientomnvar("ui_killstreak_thermal_mode", 0);
    player setclientomnvar("ui_killstreak_controls", 0);
    player lerpfovscalefactor(1, 0);
    player modifybasefov(65, 0.05);
    player setclientomnvar("ui_hide_hud", 0);
    player disableslowaim();
    player function_e851921f869b27e9(0);
    player stoploopsound();
    player clearclienttriggeraudiozone(0.5);
    player clearsoundsubmix("iw9_sp_ac130_no_npc_weap");
    player gunship_stopshellshock();
    thread scripts\sp\art::setdoftracerange(4096);
    player val::reset_all("gunship");
    player clearcinematicmotionoverride();
    player.usinggunship = undefined;

    if(getdvarint(@ "camera_thirdperson")) {}

    if(thirdpersoncam) {
      self.streakinfo notify("<dev string:x73>");
    }

    player unlink();

    if(isDefined(player.gunship_cloudsfx)) {
      player.gunship_cloudsfx delete();
    }
  }

  if(isDefined(level.gunship_intromodel)) {
    level.gunship_intromodel delete();
  }

  level.gunshipinuse = 0;
}

function gunship_allowstances(boolean) {
  if(!istrue(boolean)) {
    self.gunship_disabledstances = [];
    currentstance = self getstance();

    switch (currentstance) {
      case #"hash_c6775c88e38f7803":
        self.gunship_disabledstances = ["crouch", "prone"];
        break;
      case #"hash_3fed0cbd303639eb":
        self.gunship_disabledstances = ["stand", "prone"];
        break;
      case #"hash_d91940431ed7c605":
        self.gunship_disabledstances = ["stand", "crouch"];
        break;
    }
  }
}

function gunship_movetocrashpos(var_6fcc6072244f528d) {
  self stoploopsound();
  self.leftwingfxent setscriptablepartstate("engine_blowout", "off");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "off");
  self.leftwingfxent setscriptablepartstate("engine_blowout", "on");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "on");
  self unlink();
  self.scenenode = spawn("script_model", self.origin);
  self.scenenode setModel("tag_origin");
  self.scenenode.angles = vectortoangles(anglesToForward(self.angles));
  self.leftwingfxent setscriptablepartstate("engine_blowout", "off");
  self.rightwingfxent setscriptablepartstate("engine_blowout", "off");
  self.leftwingfxent setscriptablepartstate("body_damage_heavy", "off");
  self.rightwingfxent setscriptablepartstate("body_damage_heavy", "off");
  crashmodel = spawn("script_model", self.origin);
  crashmodel setModel("ks_gunship_mp_mesh");
  crashmodel.angles = self.angles;
  crashmodel.animname = self.streakinfo.streakname;
  crashmodel scripts\common\anim::setanimtree();
  explosionfxent = spawn("script_model", self.origin);
  explosionfxent setModel("ks_gunship_mp");
  explosionfxent.angles = self.angles;
  explosionfxent linkTo(crashmodel, "tag_body", (0, 0, -10), (0, 0, 0));

  crashpart = "crash_air";
  explosionfxent setscriptablepartstate(crashpart, "on", 0);
  crashmodel thread gunship_crash_audio();
  thread gunship_crashexplosionscreenshake(level.gunship_crashanimlength);
  thread gunship_crashexplosionradiostatic(level.gunship_crashanimlength);
  self linkTo(crashmodel, "tag_body");
  blendtime = 2;
  level.player playRumbleOnEntity("grenade_rumble");
  level.player playerlinktoblend(self.camera, "tag_player", blendtime, 0.5 * blendtime, 0.5 * blendtime);
  level.player.rumble_ent = get_rumble_ent();
  level.player.rumble_ent.intensity = 0;
  level.player.rumble_ent thread rumble_ramp_to(0.4, 5);
  wait 0.4;
  self.scenenode scripts\common\anim::anim_single_solo(crashmodel, "gunship_death", undefined);
  self.scenenode delete();
  gunship_removeplane(1);
}

function gunship_restoreplayerweapon(streakinfo) {
  self endon("disconnect");
  streakinfo notify("killstreak_finished_with_deploy_weapon");

  if(isalive(self)) {
    val::set("gunship", "fire", 0);
    self takeallweapons();
    wait 0.05;

    if(isDefined(self.lastdroppableweaponobj)) {
      self giveweapon(self.lastdroppableweaponobj);
      self switchtoweapon(self.lastdroppableweaponobj);
    }

    wait 0.767;
    self takeweapon(level.gunship.deployweaponobj);
    val::reset_all("gunship");
  }
}

function gunship_crash_audio() {
  waitframe();

  if(isent(self)) {
    self playSound("iw8_ks_ac130_explo_main");
    self playSound("iw8_ks_ac130_explo_low_02");
    self playSound("iw8_ks_ac130_shake_explo");
    self playSound("iw8_ks_ac130_whine");
  }
}

function gunship_delayhide() {
  wait 0.05;
  self hide();
}

function gunship_crashexplosionscreenshake(delaytime) {
  var_14b1d0692795af2f = delaytime - 2;

  foreach(player in level.players) {
    if(isalive(player)) {
      player earthquakeforplayer(0.25, 2, self.origin, 30000);
    }
  }
}

function gunship_crashexplosionradiostatic(delaytime) {
  var_849b0d6d79487d19 = delaytime - 3;
}

function gunship_removeplane(wasdestroyed) {
  if(isDefined(self.camera)) {
    self.camera delete();
  }

  if(isDefined(self.leftwingfxent)) {
    self.leftwingfxent delete();
  }

  if(isDefined(self.rightwingfxent)) {
    self.rightwingfxent delete();
  }

  if(isDefined(self.lightfxent)) {
    self.lightfxent delete();
  }

  if(isDefined(self.minimapid)) {
    self.minimapid = undefined;
  }

  if(isDefined(self.streakinfo)) {
    self.streakinfo.expiredbydeath = istrue(wasdestroyed);
  }

  self delete();
}

function gunship_watchtimeout(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  thread gunship_leave(gunner);
}

function gunship_watchgameend(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level waittill("game_ended");
  thread gunship_leave(gunner);
}

function gunship_leave(gunner) {
  self endon("death");
  self endon("crashing");
  self notify("leaving");
  self unlink();
  self rotateroll(30, 3);
  currentangles = self.angles;
  currentdir = anglesToForward(currentangles);
  gunship_returnplayer(gunner);
  self moveTo(self.origin + currentdir * 50000, 10, 5);
  gunship_waittilldestination(self.origin + currentdir * 50000);
  gunship_removeplane(0);
}

function gunship_waittilldestination(destination) {
  while(isDefined(self) && self.origin != destination) {
    waitframe();
  }
}

function gunship_watchownerexitaction(gunner, exitaction) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  gunner waittill(exitaction);
  thread gunship_crash(8, gunner);
}

function gunship_watchendgame(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  level waittill("game_ended");
}

function gunship_playpilotfx(pilot) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  thirdpersoncam = getdvarint(@ "hash_f49f4fd233809e37", 0);

  if(thirdpersoncam) {
    return;
  }

  pilot.gunship_cloudsfx = spawn("script_model", pilot getvieworigin());
  pilot.gunship_cloudsfx setModel("tag_origin");
  pilot.gunship_cloudsfx linkTo(pilot);
  waitframe();
  playfxontagforclients(getfx("clouds"), pilot.gunship_cloudsfx, "tag_origin", pilot);
}

function gunship_linklightfxent() {
  self endon("death");
  wait 0.05;
  self setscriptablepartstate("lights2", "on");
}

function gunship_linkwingfxents() {
  self endon("death");
  wait 0.05;
  var_633eaa5f21008b6f = self gettagorigin("tag_left_outer_prop");
  self.leftwingfxent = spawn("script_model", var_633eaa5f21008b6f);
  self.leftwingfxent setModel("ks_gunship_mp");
  self.leftwingfxent.angles = self.angles;
  self.leftwingfxent setotherent(self.owner);
  self.leftwingfxent linkTo(self, "tag_left_outer_prop", (0, 0, 0), (0, 0, 0));
  self.leftwingfxent dontcastshadows();
  self.leftwingfxent dontcastdistantshadows();
  self.leftwingfxent hide();
  var_3eacd3938ccd4b6c = self gettagorigin("tag_right_outer_prop");
  self.rightwingfxent = spawn("script_model", var_3eacd3938ccd4b6c);
  self.rightwingfxent setModel("ks_gunship_mp");
  self.rightwingfxent.angles = self.angles;
  self.rightwingfxent setotherent(self.owner);
  self.rightwingfxent linkTo(self, "tag_right_outer_prop", (0, 0, 0), (0, 0, 0));
  self.rightwingfxent dontcastshadows();
  self.rightwingfxent dontcastdistantshadows();
  self.rightwingfxent hide();
  self setscriptablepartstate("contrails", "on");
}

function function_9a76988758d4b96d(wingfxent) {
  self endon("<dev string:xfc>");

  while(true) {
    sphere(wingfxent.origin, 100, (1, 0, 0), 0, 1);
    wait 0.05;
  }
}

function gunship_monitormanualplayerexit(owner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  owner endon("disconnect");
  self waittill("killstreakExit");
  thread gunship_leave(owner);
}

function gunship_trackvelocity(gunner) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.velocity = (0, 0, 0);

  while(true) {
    self.lastorigin = self.origin;
    wait level.framedurationseconds;
    self.velocity = (self.origin - self.lastorigin) / level.framedurationseconds;
  }
}

function gunship_watchtargets(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  while(true) {
    visibletargets = [];

    foreach(player in level.players) {
      if(!isDefined(player) || !isalive(player)) {
        continue;
      }

      if(self.owner worldpointinreticle_circle(player.origin, 80, 100)) {
        if(level.teambased && player.team == self.team) {
          continue;
        }

        if(player == self.owner) {
          continue;
        }

        visibletargets = gunship_getnearbytargets(player);
        break;
      }

      wait 0.05;
    }

    wait randomintrange(5, 15);
  }
}

function gunship_getnearbytargets(maintarget) {
  var_69338ca0bf9d8d91 = utility::playersinsphere(maintarget.origin, 300);
  nearbytargets = [];

  foreach(player in var_69338ca0bf9d8d91) {
    if(level.teambased && player.team != maintarget.team) {
      continue;
    }

    if(!level.teambased && player == self.owner) {
      continue;
    }

    nearbytargets[nearbytargets.size] = player;
  }

  return nearbytargets;
}

function gunship_watchkills(gunner) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  while(true) {
    self.owner waittill("update_rapid_kill_buffered", recentkills, weaponname);

    if(isDefined(self.owner.recentkillcount)) {
      if(self.owner.recentkillcount >= 1 && gunship_iskillstreakweapon(weaponname)) {}
    }
  }
}

function gunship_iskillstreakweapon(weaponname) {
  return ter_op(isDefined(weaponname) && (weaponname == level.gunship.var_d6604e5e3d0ba3b7 || weaponname == level.gunship.var_d6604d5e3d0ba184 || weaponname == level.gunship.var_d660505e3d0ba81d), 1, 0);
}

function gunship_handlemissiledetection(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      missiletarget thread gunship_playflaresfx(fxtagoverride);
      newtarget = undefined;
      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    } else if(curdist < 300 && missiletarget.flaresreservecount <= 0) {
      missiletarget thread gunship_playfakebodyexplosion();
      missiledamage = weapongetdamagemax(self.weapon_name);

      if(isDefined(self.owner)) {
        missiletarget dodamage(missiledamage, self.owner.origin, self.owner, self, "MOD_EXPLOSIVE", self.weapon_name);
      }

      self delete();
    }

    waitframe();
  }
}

function gunship_playflaresfx(fxtagoverride) {
  flarestag = "tag_origin";

  if(isDefined(fxtagoverride)) {
    flarestag = fxtagoverride;
  }

  self playSound("ks_ac130_flares");
  playFXOnTag(getfx("gunship_flares"), self, flarestag);
  flaresgroup = self.flaresreservecount + 1;
  self setscriptablepartstate("fake_flares_" + flaresgroup, "on", 0);
}

function gunship_playfakebodyexplosion() {
  if(!isDefined(self.missileexplcounter)) {
    self.missileexplcounter = 0;
  }

  self.missileexplcounter++;

  if(self.missileexplcounter > 4) {
    self.missileexplcounter = 0;
  }

  self setscriptablepartstate("fake_missile_expl_" + self.missileexplcounter, "on", 0);
  self playSound("iw8_ks_ac130_dist_rkt_explo");
  wait 2;
  self setscriptablepartstate("fake_missile_expl_" + self.missileexplcounter, "off", 0);
}

function gunship_watchplanedistance() {
  self endon("<dev string:xfc>");
  self.owner endon("<dev string:x102>");
  self.owner endon("<dev string:x11e>");

  while(true) {
    trace = scripts\engine\trace::ray_trace(self.origin, self.origin - (0, 0, 40000), self);
    line(self.origin, trace["<dev string:xdd>"], (1, 1, 1), 1, 0, 1);
    sphere(level.gunship.origin, 200, (1, 1, 1), 0, 1);
    iprintlnbold("<dev string:x13b>" + distance(self.origin, trace["<dev string:xdd>"]));
    waitframe();
  }
}

function watchdebuglocation(tagname, var_22c53c353885fe59) {
  self endon("<dev string:xfc>");

  while(true) {
    debuglocation = self.origin;

    if(isDefined(tagname)) {
      debuglocation = self gettagorigin(tagname);
    }

    sphere(debuglocation, 100, (1, 1, 1), 0, 1);

    if(istrue(var_22c53c353885fe59)) {
      testforward = anglesToForward(self.angles);
      testright = anglestoright(self.angles);
      testup = anglestoup(self.angles);
      line(debuglocation, debuglocation + testforward * 1000, (1, 0, 0), 1, 0, 1);
      line(debuglocation, debuglocation + testright * 1000, (0, 1, 0), 1, 0, 1);
      line(debuglocation, debuglocation + testup * 1000, (0, 0, 1), 1, 0, 1);
    }

    wait 0.05;
  }
}

function function_45ad456c933cbb32() {
  self endon("<dev string:xfc>");
  self endon("<dev string:x146>");
  self endon("<dev string:x14e>");
  self.owner notifyonplayercommand("<dev string:x102>", "<dev string:x157>");
  self.owner notifyonplayercommand("<dev string:x11e>", "<dev string:x161>");

  if(getdvarint(@ "hash_80478c6f0f12492a")) {
    weaponstocycle = [level.gunship.var_d660505e3d0ba81d, level.gunship.var_d6604d5e3d0ba184, level.gunship.var_d6604e5e3d0ba3b7];
  } else {
    weaponstocycle = [level.gunship.var_d660505e3d0ba81d, level.gunship.var_d6604d5e3d0ba184, level.gunship.var_d6604f5e3d0ba5ea];
  }

  currentdebugweaponindex = 0;
  currentdebugweapon = weaponstocycle[0];

  while(true) {
    result = self.owner waittill_any_return("<dev string:x102>", "<dev string:x11e>");

    if(!isDefined(result)) {
      waitframe();
      continue;
    }

    if(result == "<dev string:x102>") {
      currentdebugweaponindex++;

      if(currentdebugweaponindex > 2) {
        currentdebugweaponindex = 0;
      }

      currentdebugweapon = weaponstocycle[currentdebugweaponindex];
      iprintlnbold("<dev string:x16c>" + currentdebugweapon);
      continue;
    }

    shotgoal = gunship_getshotgoal(self.owner);
    thread function_4f101b253c661e40(shotgoal, currentdebugweapon);
  }
}

function gunship_getfiretime(weapon) {
  return weaponfiretime(weapon);
}

function gunship_getshotgoal(owner) {
  content = ["<dev string:x187>", "<dev string:x1a0>", "<dev string:x1bc>", "<dev string:x1d2>"];
  contentoverride = physics_createcontents(content);
  starttrace = owner getvieworigin();
  endtrace = starttrace + anglesToForward(owner getplayerangles()) * 50000;
  trace = scripts\engine\trace::ray_trace(starttrace, endtrace, level.characters, contentoverride);
  endpos = trace["<dev string:xdd>"];
  return endpos;
}

function function_4f101b253c661e40(shotgoal, currentdebugweapon) {
  self endon("<dev string:xfc>");
  self endon("<dev string:x146>");
  self endon("<dev string:x14e>");
  self.owner endon("<dev string:x102>");
  self.owner endon("<dev string:x11e>");

  while(true) {
    sphere(shotgoal, 10, (1, 1, 0), 0, 60);
    iprintlnbold("<dev string:x1ea>" + currentdebugweapon + "<dev string:x1f2>" + shotgoal);
    ammoleft = weaponmaxammo(currentdebugweapon);

    while(ammoleft > 0) {
      var_e84b952249e4abe = undefined;
      projectile = magicbullet(makeweapon(currentdebugweapon), self.origin, var_e84b952249e4abe, self.owner);
      self.owner thread gunship_watchweaponimpact(projectile);
      ammoleft--;

      if(ammoleft == 0) {
        wait 1;
        reloadtimer = level.weaponreloadtime[currentdebugweapon];

        while(reloadtimer > 0) {
          iprintlnbold("<dev string:x1f7>" + currentdebugweapon);
          reloadtimer--;
          wait 1;
        }
      }

      wait gunship_getfiretime(currentdebugweapon);
    }
  }
}

function gunship_shellshock(name, category, duration, animationresponse, interruptdelayms) {
  assertex(isDefined(level.shockpriorities), "_shellShock called before shellshock_utility::init()");
  assertex(array_contains(getarraykeys(level.shockpriorities), category), "_shellShock called with an invalid category.Valid categories are top, flash, stun, gas, explosion, damage, and bottom.");

  if(!isDefined(interruptdelayms)) {
    assertex(isDefined(level.shockinterruptdelayfuncs[category]), "could not find an interrupt delay func for cagetory: " + category + ".");
    interruptdelayms = [[level.shockinterruptdelayfuncs[category]]](name, duration);
    assertex(isDefined(interruptdelayms), "Interrupt delay func for name: " + name + " and cagetory: " + category + " returned undefined.");
  }

  var_e1b45ec24abdbe91 = gettime() + interruptdelayms;

  if(category != "top") {
    if(!val::get("shellshock")) {
      return 0;
    }
  }

  if(isDefined(self.shockcategory)) {
    curpriority = level.shockpriorities[self.shockcategory];
    newpriority = level.shockpriorities[category];

    if(newpriority > curpriority) {
      if(gettime() < self.shockinterrupttime) {
        return 0;
      }
    } else if(newpriority == curpriority) {
      if(var_e1b45ec24abdbe91 < self.shockinterrupttime) {
        return 0;
      }
    }
  }

  self.shockname = name;
  self.shockcategory = category;
  self.shockinterrupttime = var_e1b45ec24abdbe91;

  if(isDefined(animationresponse)) {
    self shellshock(name, duration, animationresponse);
  } else {
    self shellshock(name, duration);
  }

  thread function_636b6dd267b3568f(duration);
}

function function_636b6dd267b3568f(duration) {
  self endon("disconnect");
  self endon("_stopShellShock");
  wait duration;
  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function gunship_stopshellshock(fromdeath) {
  self notify("_stopShellShock");

  if(!istrue(fromdeath)) {
    self stopshellshock();
  }

  self.shockname = undefined;
  self.shockcategory = undefined;
  self.shockinterrupttime = undefined;
}

function function_fabfbc51d4f4143e() {
  level.enableshellshockfunc = &function_b7f910fcce2c5395;
  level.disableshellshockfunc = &function_e873be4b11f159fe;
  level.shockpriorities = [];
  level.shockpriorities["top"] = 0;
  level.shockpriorities["flash"] = 1;
  level.shockpriorities["stun"] = 2;
  level.shockpriorities["gas"] = 3;
  level.shockpriorities["explosion"] = 4;
  level.shockpriorities["damage"] = 4;
  level.shockpriorities["bottom"] = 5;
  level.shockinterruptdelayfuncs["top"] = &function_dc1573f5b7297fd9;
  level.shockinterruptdelayfuncs["flash"] = &function_c3186a5aad41bb6d;
  level.shockinterruptdelayfuncs["stun"] = &function_7888d883b6281595;
  level.shockinterruptdelayfuncs["gas"] = &function_e1ac663c7226f51a;
  level.shockinterruptdelayfuncs["explosion"] = &function_dc1573f5b7297fd9;
  level.shockinterruptdelayfuncs["damage"] = &function_6119c3083fab37c0;
  level.shockinterruptdelayfuncs["bottom"] = &function_f4357f0124375502;
}

function function_b7f910fcce2c5395() {}

function function_e873be4b11f159fe() {
  gunship_stopshellshock(isalive(self));
}

function function_dc1573f5b7297fd9(name, duration) {
  return 250;
}

function function_c3186a5aad41bb6d(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case #"hash_d072a0adddda0068":
      break;
    default:
      assertmsg("shellshock_flashInterruptDelayFunc called with an invalid name.");
      break;
  }

  return interruptdelay;
}

function function_7888d883b6281595(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case #"hash_34e7a4cd11aed6bc":
      break;
    default:
      assertmsg("shellshock_stunInterruptDelayFunc called with an invalid name.");
      break;
  }

  return interruptdelay;
}

function function_e1ac663c7226f51a(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case #"hash_7cd59e9057f449d":
    case #"hash_7ef263b8ce60aa24":
      break;
    default:
      interruptdelay = function_dc1573f5b7297fd9(duration);
      break;
  }

  return interruptdelay;
}

function function_6119c3083fab37c0(name, duration) {
  interruptdelay = undefined;

  switch (name) {
    case #"hash_6f7dfab682794a56":
      break;
    default:
      interruptdelay = function_dc1573f5b7297fd9(duration);
      break;
  }

  return interruptdelay;
}

function function_f4357f0124375502(name, duration) {
  return false;
}

function function_d8d75147028f4b37() {
  if(level.gunship.var_c5165ac34c605427.shots_fired == 0) {
    return false;
  }

  return true;
}

function function_8f6f6e7db4c8a53e() {}

function function_4faa16948b77f38() {
  while(true) {
    waittime = 0.2 + randomfloat(1);
    wait waittime;
    level.player playSound("elm_gunship_constant_rattle_soft");
  }
}

function function_a84ea59fe4b6c2bc() {
  while(true) {
    waittime = 2.5 + randomfloat(1.5);
    wait waittime;
    level.player playSound("elm_gunship_constant_rattle_med");
  }
}

function function_b3ab43977eb50a88(guy) {
  level.player playSound("gunship_transition_into_view_beep");
}

function runcruisepredator(thirdperson, var_6f69fef7bf3f4efb, missile_target) {
  flag_wait("scriptables_ready");

  if(getdvarint(@ "hash_64bdd497427343e9", 0)) {
    thread utility::draw_line_for_time(missile_target, var_6f69fef7bf3f4efb, 0, 1, 1, 5);
  }

  missile = function_6a4f3074d5a178ab(var_6f69fef7bf3f4efb, vectortoangles(missile_target - var_6f69fef7bf3f4efb));
  level.cruise_missile = missile;
  level.remotemissileinprogress = 1;
  thread cruisepredator_takecontrol(thirdperson, var_6f69fef7bf3f4efb, missile_target, missile);
  return missile;
}

function private function_6a4f3074d5a178ab(origin, angles) {
  origin = default_to(origin, (0, 1000, 1000));
  angles = default_to(angles, (0, 0, 0));
  playerusinggamepad = self usinggamepad();
  vehicletype = ter_op(playerusinggamepad, "veh_cruise_predator_sp_jup", "veh_cruise_predator_sp_jup");
  new_missile = spawnVehicle("wmd_vm_missile_cruise_warhead_sp_jup", "cruisePredator", vehicletype, origin, angles);
  return new_missile;
}

function private cruisepredator_takecontrol(thirdperson, var_6f69fef7bf3f4efb, missile_target, missile) {
  self endon("disconnect");
  level endon("game_ended");
  level endon("kill_cruise_missile_scripts");
  missile endon("death");
  missile.cannotbesuspended = 1;
  missile setCanDamage(0);
  missile setotherent(self);
  missile setentityowner(self);
  missile.team = self.team;
  missile.owner = self;
  missile.lifetime = 10;
  missile setvehicleteam(missile.team);
  fxent = spawn("script_model", missile gettagorigin("tag_fx"));
  fxent hide();
  fxent.angles = missile gettagangles("tag_fx");
  fxent.team = missile.team;
  fxent.owner = missile.owner;
  fxent linkTo(missile, "tag_fx");
  fxent setotherent(self);
  fxent dontinterpolate();
  fxent thread cruisepredator_watchmissileexplosion(missile, self, thirdperson);

  if(!istrue(thirdperson)) {
    missile childthread function_742906810293c8be(self);
    missile thread function_fb8ee9efead0e4af(self);
    missile utility::ent_flag_set("player_posessed_missile");
    missile hideallparts();
    missile makeentitysentient("allies");
    missile utility::set_attackeraccuracy(0.1);
    missile utility::set_maxvisibledist(20000);
    threats = getaiarray("axis");
    threats = sortbydistance(threats, missile_target);

    foreach(threat in threats) {
      if(i < 5) {
        threat set_favoriteenemy(missile);
      }

      threat getenemyinfo(missile);
    }

    function_c97038cc19e3b30e(missile);
    self usevehicle(missile, 0);
    thread function_1fbff0cdadb07d52(missile);
    thread function_1611ffc25cbdfcbf(missile);
    level.player playSound("scn_strike_missile_flight_start_01_lr");
    level.missile_soundent = spawn("script_origin", missile.origin);
    level.missile_soundent delaythread(0.2, &sound_fade_in, "scn_strike_missile_flight_lp_01_lr", 1, 0.6, 1);
    level.var_ae17e9e7a0a8e9a = spawn("script_origin", missile.origin);
    level.var_ae17e9e7a0a8e9a playLoopSound("scn_strike_missile_flight_lp_banking_01_lr");
    level thread function_bb25d3deb1dda179();
  }

  missile vehphys_enablecollisioncallback(1);
  missile thread cruisepredator_watchtimer(self);
}

function function_1fbff0cdadb07d52(missile) {
  missile endon("death");
  level endon("kill_cruise_missile_scripts");
  var_3e5265936058aaec = level.gameskill > 1;
  wait 0.2;

  if(!utility::flag("sam_site_dead")) {
    utility::display_hint("player_missile_hint_1", 30, 2, [level, self, missile], ["sam_site_dead", "weapon_switch_pressed", "death"]);
  } else if(!utility::flag("player_boosted") && level.var_2cb45ce35a881047 < 2) {
    level.var_2cb45ce35a881047++;
    utility::display_hint("player_missile_hint_boost", 30, 0.5, [level, self, missile], ["player_boosted", "weapon_switch_pressed", "death"]);
  }

  var_4f9fe362e8f6e147 = utility::ter_op(var_3e5265936058aaec, 2, 3);

  if(level.var_388aee5d184a98d1 < var_4f9fe362e8f6e147) {
    if(!utility::flag("jet_1_dead") && isDefined(level.jet) && istrue(self.var_e632849f70a9992a)) {
      utility::display_hint("player_missile_hint_1", 10, 1, [level, self, missile], ["jet_1_dead", "weapon_switch_pressed", "death"]);
      level.var_388aee5d184a98d1++;
    } else if(!utility::flag("vehicle_a_end")) {
      vehicles = utility::getteamvehiclearray(["axis"]);
      vehicles = array_remove(vehicles, missile);

      if(vehicles.size > 0) {
        utility::display_hint("player_missile_hint_1", 10, 1, [level, self, missile], ["vehicle_a_end", "weapon_switch_pressed", "death"]);
        level.var_388aee5d184a98d1++;
      }
    }
  }

  utility::waittill_any_3("weapon_switch_pressed", "reload_pressed", "use_pressed");
  missile notify("stop_missileBoundarySystem");

  if(self isvehicleactive()) {
    self leavevehicle(0, 0);
  }

  thread cruisepredator_returnplayer();
  start = missile.origin;
  end = start + anglesToForward(missile.angles) * 50000;
  end = trace::ray_trace_detail(start, end, [self, missile], level.var_7355e8d4cd2e6b00)["position"];
  new_missile = magicbullet("gunship_hellfire_jup_sp", start, end, level.player);
  new_missile thread function_bb9b0bc5ab2cc8ff();
  new_missile.var_872e9fd8a2a204b0 = missile.var_872e9fd8a2a204b0;
  fov = utility::ter_op(var_3e5265936058aaec, 0.999848, 0.999391);
  range = utility::ter_op(var_3e5265936058aaec, 600, 700);
  vehicles = utility::getvehiclearray_in_radius(end, range, "axis");

  if(getdvarint(@ "hash_64bdd497427343e9", 0) && isDefined(level.gunship)) {
    thread function_3bacb9c6bfe2fc50(end, range, 10);
  }

  if(isDefined(vehicles) && vehicles.size > 0) {
    vehicles = sortbydistance(vehicles, end);

    foreach(vehicle in vehicles) {
      if(utility::within_fov(new_missile.origin, new_missile.angles, vehicle.origin, fov)) {
        new_missile missile_settargetEnt(vehicles[0]);
      }
    }
  }

  if(isDefined(level.jet)) {
    var_3e5265936058aaec = level.gameskill > 1;
    fov = utility::ter_op(var_3e5265936058aaec, 0.999848, 0.999391);
    range = utility::ter_op(var_3e5265936058aaec, 1000, 1200);
    dist = distance(end, level.jet.origin);

    if(dist < range && utility::within_fov(new_missile.origin, new_missile.angles, level.jet.origin, fov)) {
      new_missile missile_settargetEnt(level.jet);
    }
  }

  if(!utility::flag("sam_site_dead")) {
    origin = level.sam_site.origin + (0, 0, 10);

    if(utility::within_fov(new_missile.origin, new_missile.angles, origin, 0.999391)) {
      new_missile missile_settargetpos(origin);
    }
  }

  level.var_1250917a0280ae9 = utility::array_removeundefined(level.var_1250917a0280ae9);
  level.var_1250917a0280ae9 = utility::array_add(level.var_1250917a0280ae9, new_missile);
  thread function_e646a7a0af99030e(new_missile);
  missile thread function_dd9dedb2a8fcfb6f();
  missile vehphys_enablecollisioncallback(0);
  level.var_1250917a0280ae9 = utility::array_remove(level.var_1250917a0280ae9, missile);
  missile delete();
  level.cruise_missile = new_missile;
}

function function_3bacb9c6bfe2fc50(origin, radius, time) {
  time = default_to(time, 7);
  time = gettime() + time * 1000;

  while(gettime() < time) {
    sphere(origin, radius, (1, 0, 0));
    wait 0.05;
  }
}

function function_bb9b0bc5ab2cc8ff() {
  self waittill("explode", position);
  function_77cd90cfd24a21e7(position);
}

function function_77cd90cfd24a21e7(start) {
  end = start - (0, 0, 700);
  endpos = trace::ray_trace_detail(start, end, [self], level.var_2470353b1ec44c3b)["position"];
  dist = distance(start, endpos);

  if(getdvarint(@ "hash_64bdd497427343e9", 0)) {
    thread draw_line_for_time(start, endpos, 1, 0, 0, 10);
  }

  if(dist >= 700) {
    playFX(utility::getfx("vfx_player_missile_air"), start);
    return;
  }

  playFX(utility::getfx("vfx_player_missile"), start);
}

function function_742906810293c8be(player) {
  self endon("stop_missileBoundarySystem");
  player endon("stop_missileBoundarySystem");
  trigger = getEnt("missile_bounds", "targetname");

  if(!isDefined(trigger)) {
    return;
  }

  function_4a44f48694127c66(trigger);
  setomnvar("ui_out_of_bounds_countdown", 0);
}

function function_4a44f48694127c66(trigger) {
  trigger endon("death");
  self endon("death");
  ent_flag_init("out_of_bounds");

  while(true) {
    while(trigger istouching(self)) {
      waitframe();
    }

    setomnvar("ui_out_of_bounds_countdown", 1);
    start_time = gettime();
    ent_flag_set("out_of_bounds");

    while(!trigger istouching(self)) {
      if(time_has_passed(start_time, 4)) {
        setomnvar("ui_out_of_bounds_countdown", 0);
        scripts\sp\player_death::set_custom_death_quote(29);
        scripts\sp\utility::missionfailedwrapper();
        return;
      }

      waitframe();
    }

    ent_flag_clear("out_of_bounds");
    setomnvar("ui_out_of_bounds_countdown", 0);
  }
}

function private function_fb8ee9efead0e4af(player) {
  player endon("weapon_switch_pressed");
  player endon("reload_pressed");
  player endon("use_pressed");
  player endon("death");
  player endon("cruise_missile_finished");
  level endon("kill_cruise_missile_scripts");

  while(true) {
    player playRumbleOnEntity("viewmodel_xsmall");
    wait 0.15;
  }
}

function function_c97038cc19e3b30e(missile) {
  thread fade_out(0);
  setsaveddvar(@ "cg_drawcrosshair", 1);
  setomnvar("ui_hide_hud", 0);
  self freezelookcontrols(1);
  val::set("cruise_missile", "ads", 0);
  val::set("cruise_missile", "sprint", 0);
  utility::flag_set("pauseCameraFocus");
  utility::flag_set("pauseWeaponSwap");
  self modifybasefov(30, 0);
  self lerpfov(30, 0);
  self setclientomnvar("ui_killstreak_controls", 0);
  waitframe();

  if(getdvarint(@ "hash_64bdd497427343e9", 0) && isDefined(level.gunship)) {
    thread utility::draw_line_from_ent_for_time(level.gunship.model_ent.camera.focus_ent, level.gunship.origin, 1, 0, 0, 30);
  }

  self setclientomnvar("ui_predator_missile", 2);
  self playRumbleOnEntity("damage_heavy");
  self thermalvisionoff();
  visionsetpain("gunship_missile_jup_sp", 1);
  self painvisionon();
  self stoprumble("viewmodel_xsmall");
  self stoprumble("viewmodel_large");
  thread fade_in(0.3);
}

function private cruisepredator_returnplayer() {
  level endon("kill_cruise_missile_scripts");
  self notify("stop_missileBoundarySystem");
  setomnvar("ui_out_of_bounds_countdown", 0);
  setsaveddvar(@ "cg_drawcrosshair", 0);

  if(getdvarint(@ "hash_94c408c5514d7615", 0) == 0) {
    setomnvar("ui_hide_hud", 1);
  }

  hud_util::fade_out(0);
  self setclientomnvar("ui_predator_missile", 0);
  utility::flag_clear("pauseCameraFocus");
  val::reset_all("cruise_missile");

  if(isDefined(level.gunship.model_ent.camera)) {
    self setclientomnvar("ui_killstreak_controls", 9);
    self modifybasefov(level.var_fb13600ef005ed60, 0);
    self lerpfov(level.var_fb13600ef005ed60, 0);
    level.gunship.model_ent function_ff5b3dbacd9c0cdd(level.player, level.var_18a73555b2329261);
  }

  visionsetpain("damage_dead");
  self thermalvisionon();
  self painvisionoff();
  visionsetfadetoblack("", 0);
  visionsetnaked(level.gunship.color_vision, 0);
  wait 0.2;
  self freezelookcontrols(0);
  hud_util::fade_in(0.2);
  utility::flag_clear("pauseWeaponSwap");
  self stoprumble("viewmodel_xsmall");
  self stoprumble("viewmodel_large");
}

function function_1611ffc25cbdfcbf(cruise_missile) {
  level endon("cruise_missile_explode");
  level endon("kill_cruise_missile_scripts");
  cruise_missile endon("death");
  self endon("weapon_switch_pressed");
  self endon("reload_pressed");
  self endon("use_pressed");
  wait 0.5;

  while(function_69631676da7727d9(1)) {
    waitframe();
  }

  utility::waittill_any("sprint_pressed", "attack_pressed", "jump_pressed");
  utility::flag_set("player_boosted");
  cruise_missile rcplane_setminspeed(1000);
  cruise_missile rcplane_settopspeed(1000);
  screenshake(cruise_missile.origin, 0.5, 0.6, 0.2, 1, 0.2, 0.5, 0, 15, 17, 2);
  self stoprumble("viewmodel_xsmall");
  self playRumbleOnEntity("viewmodel_large");
  visionsetnaked("gunship_missile_jup_sp", 0);
  self painvisionoff();
  visionsetfadetoblack("gunship_missile_boost_jup_sp", 1);
}

function function_69631676da7727d9(timeout) {
  if(isDefined(timeout)) {
    self endon("boost_delay_timeout");
    childthread notify_delay("boost_delay_timeout", 1);
  }

  return self attackButtonPressed() || self function_b2fe5041369d64ff() || self jumpbuttonPressed() || self sprintbuttonPressed();
}

function private cruisepredator_watchmissileexplosion(missile, rider, thirdperson) {
  level endon("kill_cruise_missile_scripts");
  missile thread function_5523cac72ce288bd();

  if(getdvarint(@ "hash_64bdd497427343e9", 0) && isDefined(level.gunship)) {
    thread utility::draw_line_from_ent_for_time(missile, level.gunship.model_ent.camera.focus_ent.origin, 0, 0, 1, 20);
    startingpos = missile.origin;
    starttime = gettime();
  }

  for(;;) {
    explodeinfo = missile cruisepredator_waittillexplode("collision", "explode", "death", "disowned", "emp_defused", "trophy_blocked");

    if(getdvarint(@ "hash_b1fa07a51b801b6b", 0)) {
      if(explodeinfo.msg == "<dev string:x202>") {
        surface = physics_getsurfacetypefromflags(explodeinfo.param4);
        surfacetype = getsubstr(surface["<dev string:x20c>"], 9);
        iprintln("<dev string:x211>" + surfacetype);
        goto LOC_00000196;
      }
    }

    break;
  }

  missile notify("stop_trace_thread");
  missile notify("stop_missileBoundarySystem");
  setomnvar("ui_out_of_bounds_countdown", 0);

  if(getdvarint(@ "hash_64bdd497427343e9", 0) && isDefined(level.gunship) && isDefined(explodeinfo.param5)) {
    thread utility::draw_line_for_time(explodeinfo.param5, explodeinfo.param5 + (0, 0, 1000), 0, 1, 1, 10);

    if(isDefined(startingpos) && isDefined(starttime)) {
      dist = distance(startingpos, missile.origin);
      currenttime = gettime();
      var_76f99e513a1a6eb4 = (currenttime - starttime) / 1000;
      ips = dist / var_76f99e513a1a6eb4;
      mph = ips_to_mph(ips);
      iprintlnbold("<dev string:x23c>" + dist);
      iprintlnbold("<dev string:x24e>" + var_76f99e513a1a6eb4);
      iprintlnbold("<dev string:x25c>" + mph);
    }
  }

  self unlink();
  missile linkTo(self);
  level.remotemissileinprogress = 0;
  flag_clear("hellfire_missile_alive");

  if(isDefined(missile.lasttracepos)) {
    var_4c6e175d87ad5b00 = self.origin;
    explodepos = missile.lasttracepos;

    if(getdvarint(@ "hash_64bdd497427343e9", 0)) {
      thread utility::draw_line_for_time(explodepos, var_4c6e175d87ad5b00, 1, 1, 0, 10);
    }
  } else {
    explodepos = self.origin;
  }

  if(getdvarint(@ "hash_64bdd497427343e9", 0) == 1) {
    utility::draw_circle(explodepos, 2000, (0, 0, 1), 1, 0, 150);
    utility::draw_circle(explodepos, 1000, (1, 0, 0), 1, 0, 150);

    if(isDefined(level.gunship)) {
      thread utility::draw_line_for_time(explodepos, explodepos + (0, 0, 1000), 1, 1, 0, 10);
    }
  }

  missile thread cruisepredator_handlevfxstates(explodeinfo);
  missile function_77cd90cfd24a21e7(explodepos);
  missile notify("cruise_missile_explode", explodepos, explodeinfo);
  level notify("cruise_missile_explode", explodepos, explodeinfo);
  missile notify("explode", explodepos, explodeinfo);

  if(isDefined(rider) && rider isvehicleactive()) {
    rider leavevehicle(0, 0);
    rider thread cruisepredator_returnplayer();

    if(getdvarint(@ "hash_64bdd497427343e9", 0) && isDefined(level.gunship)) {
      thread utility::draw_line_for_time(explodepos, level.gunship.model_ent.camera.focus_ent.origin, 1, 0, 0, 10);
    }

    if(!istrue(thirdperson)) {
      rider earthquakeforplayer(0.3, 3, rider.origin, 100);
      rider playrumbleonpositionforclient("artillery_rumble", rider.origin);
    }

    rider notify("cruise_missile_finished");
  }

  missile thread function_dd9dedb2a8fcfb6f();
  missile vehphys_enablecollisioncallback(0);
  missile delete();
}

function function_5523cac72ce288bd() {
  self endon("death");
  self endon("stop_trace_thread");
  level endon("kill_cruise_missile_scripts");

  for(;;) {
    forward = anglesToForward(self gettagangles("tag_player"));
    start = self gettagorigin("tag_player");
    end = start + forward * 100000;
    pos = scripts\engine\trace::ray_trace_detail(start, end, [self], level.var_7355e8d4cd2e6b00)["position"];
    self.lasttracepos = pos;
    dist = distance(pos, self.origin);

    if(dist < 500) {
      self notify("explode", self.lasttracepos, undefined, undefined, undefined, self.lasttracepos);
    }

    if(getdvarint(@ "hash_64bdd497427343e9", 0)) {
      thread utility::draw_line_for_time(pos, self.origin, 1, 0, 0, 10);
    }

    waitframe();
  }
}

function private cruisepredator_handlevfxstates(explodeinfo) {
  self endon("death");
  level endon("kill_cruise_missile_scripts");
  self unlink();

  if(!isDefined(explodeinfo) || explodeinfo.msg == "explode" || explodeinfo.msg == "disowned" || explodeinfo.msg == "emp_defused" || explodeinfo.msg == "trophy_blocked") {
    wait 0.2;
    self delete();
  }

  surfacenormal = explodeinfo.param6;
  self.angles = vectortoangles(surfacenormal);
  wait 1;
  self delete();
}

function function_dd9dedb2a8fcfb6f() {
  if(isDefined(level.missile_soundent)) {
    level.missile_soundent thread sound_fade_and_delete(0.05, 1);
  }

  if(isDefined(level.var_c35906d57c41ed60)) {
    level.var_c35906d57c41ed60 stopsounds();
  }

  if(isDefined(self)) {
    self stopsounds();
  }

  if(isDefined(level.var_ae17e9e7a0a8e9a)) {
    level.var_ae17e9e7a0a8e9a stoploopsound("scn_strike_missile_flight_lp_banking_01_lr");
    level.var_ae17e9e7a0a8e9a delaycall(0.1, &delete);
  }

  if(isDefined(level.var_acdee83aae8eb6ea)) {
    level.var_acdee83aae8eb6ea stoploopsound("vel_strike_flight_earth_01");
  }

  if(isDefined(level.var_acdee73aae8eb4b7)) {
    level.var_acdee73aae8eb4b7 stoploopsound("vel_strike_flight_earth_02");
  }

  if(isDefined(level.var_acdee63aae8eb284)) {
    level.var_acdee63aae8eb284 stoploopsound("vel_strike_flight_earth_01");
  }

  if(isDefined(level.var_acdee53aae8eb051)) {
    level.var_acdee53aae8eb051 stoploopsound("vel_strike_flight_earth_02");
  }

  if(isDefined(level.var_acdee43aae8eae1e)) {
    level.var_acdee43aae8eae1e stoploopsound("vel_strike_flight_earth_01");
  }

  if(isDefined(level.var_acdee33aae8eabeb)) {
    level.var_acdee33aae8eabeb stoploopsound("vel_strike_flight_earth_02");
  }

  if(isDefined(level.var_acdee23aae8ea9b8)) {
    level.var_acdee23aae8ea9b8 stoploopsound("vel_strike_flight_earth_01");
  }

  wait 0.1;

  if(isDefined(level.var_c35906d57c41ed60)) {
    level.var_c35906d57c41ed60 delete();
  }

  if(isDefined(level.missile_soundent)) {
    level.missile_soundent delete();
  }

  if(isDefined(level.var_acdee83aae8eb6ea)) {
    level.var_acdee83aae8eb6ea delete();
  }

  if(isDefined(level.var_acdee73aae8eb4b7)) {
    level.var_acdee73aae8eb4b7 delete();
  }

  if(isDefined(level.var_acdee63aae8eb284)) {
    level.var_acdee63aae8eb284 delete();
  }

  if(isDefined(level.var_acdee53aae8eb051)) {
    level.var_acdee53aae8eb051 delete();
  }

  if(isDefined(level.var_acdee43aae8eae1e)) {
    level.var_acdee43aae8eae1e delete();
  }

  if(isDefined(level.var_acdee33aae8eabeb)) {
    level.var_acdee33aae8eabeb delete();
  }

  if(isDefined(level.var_acdee23aae8ea9b8)) {
    level.var_acdee23aae8ea9b8 delete();
  }
}

function private function_bb25d3deb1dda179() {
  level endon("cruise_missile_explode");
  level endon("kill_cruise_missile_scripts");
  var_97e6ef5ab12263e3 = 0;

  while(true) {
    var_374abb46e0e87498 = level.player getplayerangles();
    var_97e6ef5ab12263e3 = (abs(var_374abb46e0e87498[2]) / 27 + var_97e6ef5ab12263e3 + var_97e6ef5ab12263e3) / 3;

    if(var_97e6ef5ab12263e3 > 1) {
      var_97e6ef5ab12263e3 = 1;
    }

    if(var_97e6ef5ab12263e3 < 0.02) {
      var_97e6ef5ab12263e3 = 0.02;
    }

    if(isDefined(level.var_ae17e9e7a0a8e9a)) {
      level.var_ae17e9e7a0a8e9a scalevolume(var_97e6ef5ab12263e3, 0.05);
    }

    waitframe();
  }
}

function private cruisepredator_delaymissilecollision() {
  self endon("death");
  self endon("cruise_missile_explode");
  wait 0.75;
  self vehphys_enablecollisioncallback(1);
  wait 1.25;
}

function private cruisepredator_watchtimer(rider) {
  self endon("death");
  level endon("kill_cruise_missile_scripts");
  wait 10;
  self notify("explode", self.origin);
}

function private cruisepredator_waittillexplode(var_e127af0eab592c1a, var_e127ae0eab5929e7, var_e127ad0eab5927b4, var_e127ac0eab592581, var_e127ab0eab59234e, var_e127aa0eab59211b) {
  ent = spawnStruct();

  if(isDefined(var_e127af0eab592c1a)) {
    thread waittill_explodestring(var_e127af0eab592c1a, ent);
  }

  if(isDefined(var_e127ae0eab5929e7)) {
    thread waittill_explodestring(var_e127ae0eab5929e7, ent);
  }

  if(isDefined(var_e127ad0eab5927b4)) {
    thread waittill_explodestring(var_e127ad0eab5927b4, ent);
  }

  if(isDefined(var_e127ac0eab592581)) {
    thread waittill_explodestring(var_e127ac0eab592581, ent);
  }

  if(isDefined(var_e127ab0eab59234e)) {
    thread waittill_explodestring(var_e127ab0eab59234e, ent);
  }

  if(isDefined(var_e127aa0eab59211b)) {
    thread waittill_explodestring(var_e127aa0eab59211b, ent);
  }

  ent waittill("returned", msg, param1, param2, param3, param4, param5, param6, param7, param8);
  ent notify("die");
  explodeinfo = spawnStruct();
  explodeinfo.msg = msg;
  explodeinfo.param1 = param1;
  explodeinfo.param2 = param2;
  explodeinfo.param3 = param3;
  explodeinfo.param4 = param4;
  explodeinfo.param5 = param5;
  explodeinfo.param6 = param6;
  explodeinfo.param7 = param7;
  explodeinfo.param8 = param8;
  return explodeinfo;
}

function private waittill_explodestring(msg, ent) {
  self endon("death");
  ent endon("die");
  self waittill(msg, param1, param2, param3, param4, param5, param6);
  ent notify("returned", msg, param1, param2, param3, param4, param5, param6);
}