/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_skyhook.gsc
***********************************************/

function init() {
  if(!getdvarint("scr_skyhooks_enabled", 0)) {
    return;
  }

  isplatepouch();
  initanimtree();
  tr_vis_radius_override_lod2();
  scripts\cp_mp\utility\script_utility::registersharedfunc("skyhook", "precision_airstrike_damage", &ref_1284A);
  scripts\engine\scriptable::ref_12F5B("skyhook", &ref_13409);
  scripts\engine\scriptable::ref_12F5B("skyhook_interact", &skyhookplacedscriptableused);
  scripts\engine\scriptable::ref_12F5A(&scriptable_skyhook_placed_damaged);
  scripts\mp\utility\sound::besttime("equip_skyhook");
  thread ref_13406();
}

function tr_vis_radius_override_lod2() {
  level.ref_13400 = spawnStruct();
  level.ref_13400.chopper_boss_destroyed_func = getdvarint("scr_skyhooks_enabled", 0);
  level.ref_13400.card_angles = getdvarint("scr_skyhook_ascent_height", 3500);
  level.ref_13400.cardstruct = getdvarint("scr_skyhook_ascent_time", 2.8);
  level.ref_13400.card_origin = getdvarint("scr_skyhook_ascent_speed", 1500);
  level.ref_13400.car_think = getdvarfloat("scr_skyhook_ascent_acceleration", 1);
  level.ref_13400.watch_rpg_use = getdvarfloat("scr_skyhook_launch_forward_scalar", 2000);
  level.ref_13400.watchbombuseinternal = getdvarfloat("scr_skyhook_launch_z_scalar", 1500);
  level.ref_13400.watchbombuse = getdvarfloat("scr_skyhook_launch_time", 1);
  level.ref_13400.playerhumanprestream = getdvarint("scr_skyhook_force_parachute", 1);
  level.ref_13400.bullets_can_damage = getdvarint("scr_skyhook_bullets_damage_balloon", 1);
  level.ref_13400.chopperexfil_sh060_start = getdvarint("scr_skyhook_balloon_health", 2000);
  level.ref_13400.ref_12C2D = getdvarint("scr_skyhook_repair_cost", 5);
  level.ref_13400.open_door_to_next_objective = getdvarfloat("scr_skyhook_balloon_explosives_multiplier", 4);
  level.ref_13400.arenaflag_previewflag = getdvarfloat("scr_skyhook_balloon_aa_turret_multiplier", 6);
  level.ref_13400.ref_12928 = getdvarfloat("scr_skyhook_balloon_spawn_protection_duration", 0);
  level.ref_13400.ref_12929 = getdvarfloat("scr_skyhook_balloon_spawn_protection_scalar", 0.5);
  level.ref_13400.iskillstreakvehicleinflictor = loadfx("vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_explosion");
  level.ref_13400.ref_12C32 = loadfx("vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_repair");
  level.ref_13400.cantakedamage = loadfx("vfx/iw8_br/island/equip/barrage_balloon/vfx_barrage_balloon_scrnfx");
  level.ref_13400.ref_12C33 = loadfx("vfx/iw8_br/gameplay/payload/vfx_br_payload_barrier_construct_base");
  level.ref_13400.ref_12C34 = loadfx("vfx/iw8_br/gameplay/vfx_br_cash_fulton_fillup");
  level.ref_13400.warning_radius = getdvarint("scr_parachute_overhead_warning_radius", 2000);
  level.ref_13400.warning_height = getdvarint("scr_parachute_overhead_warning_height", 3000);
  level.ref_13400.warning_timeout_ms = getdvarint("scr_parachute_overhead_warning_timeout_ms", 45000);
  level.ref_13400.ref_1284A = getdvarint("scr_skyhook_precision_airstrike_damage", 200);
  level.ref_13400.thermite_dps = getdvarint("scr_skyhook_thermite_dps", 100);
  level.ref_13400.aq_ontimerexpired = reader();
  level.ref_13400.areas_remaining = [];
  level.ref_13400.a_scr_skyhooks_placed = getentitylessscriptablearrayinradius("scriptable_scriptable_skyhook_placed", "classname");
  level.ref_13400.i_skyhook_ents_max = getdvarfloat("scr_skyhook_ents_max", -1);
  setdvarifuninitialized("scr_ascender_disable_concurrent_use", 0);
}

function reader() {
  var_0 = [];

  if(isDefined(level.ref_12178)) {
    foreach(var_3, var_2 in level.ref_12178) {
      var_0 = var_2;
    }

    return var_0;
  }

  switch (getDvar("mapname")) {
    case "mp_wz_island":
      break;
    case "mp_hmsisle_test":
      var_0[var_0.size] = [(770, -527, 502), (0, 0, 0)];
      break;
    case "mp_sm_island_1":
      break;
    case "mp_br_hms_ltm":
      var_0[var_0.size] = [(0, -1870, -2), (0, 45, 0)];
      var_0[var_0.size] = [(500, -1870, -2), (0, 45, 0)];
      var_0[var_0.size] = [(1000, -1870, -2), (0, 45, 0)];
      break;
    case "mp_br_mechanics":
      var_0[var_0.size] = [(288, -2209, -2), (0, 0, 0)];
      var_0[var_0.size] = [(288, -2009, -2), (0, 0, 0)];
      break;
    case "mp_escape4_s5":
    case "mp_escape4":
      var_0[var_0.size] = [(-6062.5, -329, 83), (0, 17, 0)];
      var_0[var_0.size] = [(-1279, -10389, 152), (0, 0, 0)];
      var_0[var_0.size] = [(3597, 3099, 192), (0, 196, 0)];
      var_0[var_0.size] = [(-3729.5, 8587.25, 151), (0, 347, 0)];
      break;
  }

  return var_3;
}

function ref_13406() {
  waitframe();
  ref_135D3();

  if(!getdvarint("scr_skyhooks_enabled_placed_disabled", 0)) {
    spawn_skyhooks_placed();
  }

  while(!isDefined(level.matchcountdowntime) && !scripts\mp\flags::gameflag("prematch_fade_done")) {
    wait 1;
  }

  level.ref_13400.choosejuggernautcratemodel = 1;
  scripts\mp\flags::gameflagwait("prematch_fade_done");
  level.ref_13400.choosejuggernautcratemodel = undefined;
  level notify("respawn_skyhooks");

  if(getdvarint("scr_skyhook_balloon_start_destroyed", 0) == 1) {
    ref_12C94();
    respawn_skyhooks_destroyed_placed();
    return;
  }

  ref_12C93();

  if(!getdvarint("scr_skyhooks_enabled_placed_disabled", 0)) {
    respawn_skyhooks_placed();
    return;
  }
}

function ref_135D3() {
  if(!level.ref_13400.aq_ontimerexpired.size) {
    return;
  }

  level.ref_13400.aq_ontimerexpired = scripts\engine\utility::array_randomize(level.ref_13400.aq_ontimerexpired);
  var_0 = 0;

  if(getdvarint("scr_skyhook_randomize_spawns", 0)) {
    var_0 = randomintrange(1, level.ref_13400.aq_ontimerexpired.size + 1);
  } else if(getdvarfloat("scr_skyhook_spawn_percentage", 1)) {
    var_0 = getdvarfloat("scr_skyhook_spawn_percentage", 1) * level.ref_13400.aq_ontimerexpired.size;
  }

  if(var_0 > 0) {
    for(var_1 = level.ref_13400.aq_ontimerexpired.size - 1; var_1 >= var_0; var_1--) {
      level.ref_13400.aq_ontimerexpired = scripts\engine\utility::array_remove_index(level.ref_13400.aq_ontimerexpired, var_1);
    }
  }

  foreach(var_3 in level.ref_13400.aq_ontimerexpired) {
    if(level.ref_13400.i_skyhook_ents_max > -1) {
      if(var_6 >= level.ref_13400.i_skyhook_ents_max) {
        break;
      }
    }

    var_4 = easepower("scriptable_skyhook", var_3[0]);
    var_4 setscriptablepartstate("skyhook", "on");
    var_4 setscriptablepartstate("sfx", "idle");
    var_5 = spawn("script_model", var_3[0]);
    var_5 setModel("lm_military_skyhook_extraction_01_ch3");
    var_5.angles = var_3[1];
    var_4.chopperexfil_sfx_before_sh070 = var_5;
    var_4.chopperexfil_skip_ascend0 = var_5.angles;
    var_5.ref_133FA = var_4;
    ref_13401(var_5);
    var_5.animname = "script_model";
    var_5 scripts\common\anim::setanimtree();
    var_5 thread scripts\common\anim::anim_single_solo(var_5, "redeploy_loop");
    chopperexfil_sitting_wind(var_5);
    thread skyhookrepairwatcher();
    thread modevalidatekillcam();
    level.ref_13400.areas_remaining[level.ref_13400.areas_remaining.size] = var_4;
  }

  if(!isDefined(level.ref_13BEB)) {
    level.ref_13BEB = 0;
  }

  level.ref_13BEB += level.ref_13400.areas_remaining.size;
}

function spawn_skyhooks_placed() {
  if(!level.ref_13400.a_scr_skyhooks_placed.size) {
    return;
  }

  level.ref_13400.a_scr_skyhooks_placed = scripts\engine\utility::array_randomize(level.ref_13400.a_scr_skyhooks_placed);
  var_0 = 0;

  if(getdvarint("scr_skyhook_randomize_spawns", 0)) {
    var_0 = randomintrange(1, level.ref_13400.a_scr_skyhooks_placed.size + 1);
  } else if(getdvarfloat("scr_skyhook_spawn_percentage", 1)) {
    var_0 = getdvarfloat("scr_skyhook_spawn_percentage", 1) * level.ref_13400.a_scr_skyhooks_placed.size;
  }

  if(var_0 > 0) {
    level.ref_13400.a_scr_skyhooks_placed = scripts\engine\utility::array_randomize(level.ref_13400.a_scr_skyhooks_placed);

    for(var_1 = level.ref_13400.a_scr_skyhooks_placed.size - 1; var_1 >= var_0; var_1--) {
      level.ref_13400.a_scr_skyhooks_placed = scripts\engine\utility::array_remove_index(level.ref_13400.a_scr_skyhooks_placed, var_1);
    }
  }

  foreach(var_3 in level.ref_13400.a_scr_skyhooks_placed) {
    set_skyhook_placed_available(var_3);
    health_init(var_3);
    thread skyhook_repair_watcher_placed();
    thread modevalidatekillcam();
  }
}

function set_skyhook_placed_available() {
  self setscriptablepartstate("skyhook", "available");
}

function set_skyhook_placed_broken() {
  self setscriptablepartstate("skyhook", "broken");
}

function ref_12C93() {
  foreach(var_1 in level.ref_13400.areas_remaining) {
    if(isDefined(var_1.chopperexfil_sfx_before_sh070)) {
      var_1.chopperexfil_sfx_before_sh070 delete();
    }
  }

  foreach(var_1 in level.ref_13400.areas_remaining) {
    var_1 setscriptablepartstate("skyhook", "on");
    var_1 setscriptablepartstate("sfx", "idle");
    var_4 = spawn("script_model", var_1.origin);
    var_4 setModel("lm_military_skyhook_extraction_01_ch3");
    var_4.angles = var_1.chopperexfil_skip_ascend0;
    var_4.ref_133FA = var_1;
    var_1.chopperexfil_sfx_before_sh070 = var_4;
    ref_13401(var_1.chopperexfil_sfx_before_sh070);
    var_4.animname = "script_model";
    var_4 scripts\common\anim::setanimtree();
    var_4 thread scripts\common\anim::anim_single_solo(var_4, "redeploy_loop");
    chopperexfil_sitting_wind(var_4);
    thread skyhookrepairwatcher();
    thread modevalidatekillcam();
  }
}

function respawn_skyhooks_placed() {
  foreach(var_1 in level.ref_13400.a_scr_skyhooks_placed) {
    set_skyhook_placed_available(var_1);
    health_init(var_1);
    thread skyhook_repair_watcher_placed();
    thread modevalidatekillcam();
  }
}

function ref_12C94() {
  foreach(var_1 in level.ref_13400.areas_remaining) {
    if(isDefined(var_1.chopperexfil_sfx_before_sh070)) {
      var_1.chopperexfil_sfx_before_sh070 delete();
    }
  }

  foreach(var_1 in level.ref_13400.areas_remaining) {
    var_1 setscriptablepartstate("skyhook", "broken");
    var_4 = spawn("script_model", var_1.origin);
    var_4 setModel("br_skyhook_extraction_base_01_ch3");
    var_4 setscriptablepartstate("objective", "broken");
    var_4.angles = var_1.chopperexfil_skip_ascend0;
    var_4.ref_133FA = var_1;
    var_1.chopperexfil_sfx_before_sh070 = var_4;
    thread skyhookrepairwatcher();
  }
}

function respawn_skyhooks_destroyed_placed() {
  foreach(var_1 in level.ref_13400.a_scr_skyhooks_placed) {
    set_skyhook_placed_broken(var_1);
    thread skyhook_repair_watcher_placed();
  }
}

function chopperexfil_sitting_wind() {
  self setCanDamage(1);
  self.health = level.ref_13400.chopperexfil_sh060_start;
  self.maxhealth = level.ref_13400.chopperexfil_sh060_start;
  thread chopperexfil_sh010_start();
  thread balloon_collision_watcher();
  self physics_registerforcollisioncallback();
  self method_87de(1);

  if(level.ref_13400.ref_12928) {
    thread ref_135B8();
    return;
  }
}

function health_init() {
  self.health = level.ref_13400.chopperexfil_sh060_start;
  self.maxhealth = level.ref_13400.chopperexfil_sh060_start;

  if(level.ref_13400.ref_12928) {
    thread ref_135B8();
    return;
  }
}

function ref_135B8() {
  self notify("start_spawn_protection");
  self endon("start_spawn_protection");
  self.chopper_boss_drone_target_array = 1;
  wait level.ref_13400.ref_12928;
  self.chopper_boss_drone_target_array = undefined;
}

function modevalidatekillcam() {
  level endon("respawn_skyhooks");
  self.capacity = [];
  self waittill("balloon_destroyed");

  foreach(var_1 in self.capacity) {
    var_2 = var_1 getentitynumber();
    ref_133FC(self.a_e_skyhook_ascenders[var_2], var_1);
    self.a_e_skyhook_ascenders[var_2] stoploopsound("br_auto_ascender_device_lp_npc");
    playerstartarenasetcontrols(var_1, var_1 getentitynumber(), self);
  }
}

function ref_13409(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "off") {
    if(var_2 == "broken" && var_3.plundercount >= level.ref_13400.ref_12C2D) {
      var_3 thread scripts\mp\hud_message::showsplash("redeploy_balloon_repaired");
      ref_13401(var_0.chopperexfil_sfx_before_sh070);
      var_0 notify("player_repaired", var_3);
      return;
    }

    if(var_2 != "on" || istrue(var_3.ref_140AF) || !get_any_player_spectating(var_0, var_3)) {
      playsoundatpos(var_0.origin, "skyhook_repair_denied");
      return;
    }

    thread atv_vehicle(level, var_0);
    return;
  }
}

function skyhookplacedscriptableused(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 != "off") {
    if(var_2 == "broken" && var_3.plundercount >= level.ref_13400.ref_12C2D) {
      var_3 thread scripts\mp\hud_message::showsplash("redeploy_balloon_repaired");
      var_0 notify("player_repaired", var_3);
      return;
    }

    if(var_2 != "on" || istrue(var_3.ref_140AF) || !get_any_player_spectating(var_0, var_3)) {
      playsoundatpos(var_0.origin, "skyhook_repair_denied");
      return;
    }

    thread atv_vehicle(level, var_0);
    return;
  }
}

function skyhookrepairwatcher() {
  level endon("game_ended");
  level endon("respawn_skyhooks");
  self waittill("player_repaired", var_0);
  var_0 scripts\mp\gametypes\br_plunder::ref_1261E(level.ref_13400.ref_12C2D);
  playsoundatpos(self.origin, "skyhook_repair");
  playFX(level.ref_13400.ref_12C32, self.origin + (0, 0, 4000));
  playFX(level.ref_13400.ref_12C34, self.origin + (0, 0, 16));
  wait 0.25;
  playFX(level.ref_13400.ref_12C33, self.origin);
  self setscriptablepartstate("skyhook", "on");
  self setscriptablepartstate("sfx", "idle");
  chopperexfil_sitting_wind(self.chopperexfil_sfx_before_sh070);
  self.chopperexfil_sfx_before_sh070.animname = "script_model";
  self.chopperexfil_sfx_before_sh070 scripts\common\anim::setanimtree();
  self.chopperexfil_sfx_before_sh070 thread scripts\common\anim::anim_single_solo(self.chopperexfil_sfx_before_sh070, "redeploy_loop");
  thread skyhookrepairwatcher();
  thread modevalidatekillcam();
}

function skyhook_repair_watcher_placed() {
  level endon("game_ended");
  level endon("respawn_skyhooks");
  self waittill("player_repaired", var_0);
  var_0 scripts\mp\gametypes\br_plunder::ref_1261E(level.ref_13400.ref_12C2D);
  playsoundatpos(self.origin, "skyhook_repair");
  playFX(level.ref_13400.ref_12C32, self.origin + (0, 0, 4000));
  playFX(level.ref_13400.ref_12C34, self.origin + (0, 0, 16));
  wait 0.25;
  playFX(level.ref_13400.ref_12C33, self.origin);
  set_skyhook_placed_available();
  health_init();
  thread skyhook_repair_watcher_placed();
  thread modevalidatekillcam();
}

function atv_vehicle(var_0, var_1) {
  if(!get_any_player_spectating(var_0, var_1)) {
    return;
  }

  if(getdvarint("scr_skyhook_carriable_interaction_enabled", 1)) {
    if(isDefined(var_1.get_search_turret_target_player)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("player", "carriable_useSkyhook")) {
        var_1[[scripts\cp_mp\utility\script_utility::getsharedfunc("player", "carriable_useSkyhook")]](var_0);
        return 0;
      }
    }
  }

  scripts\mp\gametypes\br_analytics::branalytics_skyhookredeploy(var_1);
  level endon("game_ended");
  var_0 endon("balloon_destroyed");
  var_1 endon("death_or_disconnect");
  var_1 endon("last_stand_start");
  var_0.capacity[var_0.capacity.size] = var_1;
  var_1.ref_140AF = 1;
  var_1.shouldskiplaststand = 1;

  if(isDefined(var_1.get_search_turret_target_player)) {
    var_1.get_search_turret_target_player thread scripts\mp\equipment\binoculars::get_subway_train_hit_damage_multiplier(0);
  }

  var_2 = var_1 getentitynumber();
  var_3 = spawn("script_model", var_0.origin);
  var_3 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_3 setModel("tag_origin");

  if(!isDefined(var_0.a_e_skyhook_ascenders)) {
    var_0.a_e_skyhook_ascenders = [];
  }

  var_0.a_e_skyhook_ascenders[var_2] = var_3;
  ref_1246F(var_1);
  thread ref_13405();
  var_1.usingascender = 1;
  level.initpostmain++;
  var_1 scripts\common\utility::allow_usability(0);
  var_4 = var_0.ascendstructend;
  var_5 = var_0.ascendstructout;
  var_3 dontinterpolate();
  var_3.origin = var_0.origin + (0, 0, 28);
  var_3.angles = var_1.angles;
  var_6 = spawn("script_model", var_0.origin);
  var_6 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_6 setModel("misc_vm_ascender_ch3");
  var_6 showonlytoplayer(var_1);
  var_7 = spawn("script_model", var_0.origin);
  var_7 scripts\cp_mp\ent_manager::registerspawncount(1);
  var_7 setModel("misc_vm_ascender_ch3");
  var_7 hide();

  if(!isDefined(var_0.a_e_ascendermodelview)) {
    var_0.a_e_ascendermodelview = [];
  }

  var_0.a_e_ascendermodelview[var_2] = var_6;

  if(!isDefined(var_0.a_e_ascendermodelworld)) {
    var_0.a_e_ascendermodelworld = [];
  }

  var_0.a_e_ascendermodelworld[var_2] = var_7;
  thread ascenddeathlistener(var_1, var_0);
  var_1.chopper_boss_damage_monitor = 0;
  var_8 = ref_133FB(var_3, var_1, var_6, var_7);

  if(!var_8) {
    playerstartarenasetcontrols(var_1, var_2, var_0);
    playsoundatpos(var_0.origin, "skyhook_repair_denied");
    return;
  }

  var_1 childthread ref_133FE();
  var_1 thread ref_12505();
  var_3 thread ref_133FD(var_1, var_6, var_7);
  var_3 playLoopSound("br_auto_ascender_device_lp_npc");
  var_3 moveTo(var_3.origin + (0, 0, level.ref_13400.card_angles), level.ref_13400.cardstruct, level.ref_13400.cardstruct);
  playfxontagforclients(level.ref_13400.cantakedamage, var_3, "tag_origin", var_1);
  wait(level.ref_13400.cardstruct * 0.35);
  var_1.chopper_boss_damage_monitor = 1;
  wait(level.ref_13400.cardstruct * 0.65);
  stopFXOnTag(level.ref_13400.cantakedamage, var_3, "tag_origin");
  var_1 notify("kill_skyhook_ascend_earthquake");
  var_3 thread ref_133FC(var_1, var_6, var_7);
  var_3 stoploopsound("br_auto_ascender_device_lp_npc");
  var_1 playlocalsound("scr_br_infil_jump_stinger", var_1);
  var_1 earthquakeforplayer(0.2, 1.5, var_1.origin, 1000);
  var_9 = "enabled";

  if(isDefined(var_1.operatorcustomization) && isDefined(var_1.operatorcustomization.disabledebugdialogue)) {
    var_9 = var_9 + var_1.operatorcustomization.disabledebugdialogue;
  }

  var_1 setscriptablepartstate("skydiveVfx", var_9, 0);
  var_1 setisinfilskydive(1);
  var_3 movegravity(anglesToForward(var_1 getplayerangles(1)) * level.ref_13400.watch_rpg_use + (0, 0, level.ref_13400.watchbombuseinternal), level.ref_13400.watchbombuse);
  var_1._ref_140BC = anglesToForward(var_1 getplayerangles(1)) * level.ref_13400.watch_rpg_use;
  wait(level.ref_13400.watchbombuse - 0.1);
  var_1 setclientomnvar("ui_br_altimeter_state", 1);
  var_1 thread _ref_13403();
  playerstartarenasetcontrols(var_1, var_2, var_0);
  var_0.capacity = scripts\engine\utility::array_remove(var_0.capacity, var_1);
}

function ref_133FE() {
  self endon("kill_skyhook_ascend_earthquake");

  for(;;) {
    self earthquakeforplayer(0.2, 1.5, self.origin, 1000);
    wait randomfloatrange(0.5, 1);
  }
}

function ref_13405() {
  level endon("game_ended");
  self.inuse = 1;
  wait 1;
  self.inuse = undefined;
}

function ref_12505() {
  self setclientomnvar("ui_br_altimeter_state", 3);

  while(isalive(self)) {
    if(self isonground()) {
      self setclientomnvar("ui_br_altimeter_state", 0);
      return;
    }

    waitframe();
  }

  if(isDefined(self)) {
    self setclientomnvar("ui_br_altimeter_state", 0);
    return;
  }
}

function playerstartarenasetcontrols(var_0, var_1, var_2) {
  if(isDefined(var_0)) {
    var_0 setscriptablepartstate("skydiveVfx", "default", 0);
    var_0 setisinfilskydive(0);
  }

  if(isDefined(var_2.a_e_ascendermodelview[var_1])) {
    var_2.a_e_ascendermodelview[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2.a_e_ascendermodelview[var_1] delete();
  }

  if(isDefined(var_2.a_e_ascendermodelworld[var_1])) {
    var_2.a_e_ascendermodelworld[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    var_2.a_e_ascendermodelworld[var_1] delete();
  }

  thread cleanupascenduse(var_2);
  thread handleownervisibility(var_2, var_0);

  if(isDefined(var_0)) {
    if(!istrue(level.client_activate)) {
      var_0 skydive_setbasejumpingstatus(1);
    }

    var_0.player_rig stopanimScripted();
    var_0.usingascender = 0;
    var_0.ref_140AF = 0;
  }

  level.initpostmain--;

  if(isDefined(var_0)) {
    if(isDefined(var_0.ref_140BC)) {
      var_0 setvelocity(var_0.ref_140BC);
    }

    var_0.ref_140BC = undefined;

    if(istrue(var_0.chopper_boss_damage_monitor) && !istrue(level.client_activate) && !scripts\mp\utility\player::unset_relic_trex(var_0)) {
      var_0 skydive_beginfreefall();
    }

    var_0 notify("skyhook_complete");
    return;
  }
}

function ref_1246F(var_0) {
  if(var_0 getstance() != "stand") {
    var_0 setstance("stand");
  }

  var_0 allowmelee(0);
  var_0 allowads(0);
  var_0 allowfire(0);

  if(istrue(var_0.isjuggernaut)) {
    if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
      var_1 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

      if(istrue(var_1)) {
        var_0 disableweaponswitch();
        return;
      }

      return;
    }

    return;
  }

  var_1 disableoffhandweapons();
  var_1 scripts\common\utility::allow_killstreaks(0);
  var_1 scripts\common\utility::allow_supers(0);
  var_1 disableweaponswitch();
}

function get_any_player_spectating(var_0, var_1) {
  if(istrue(level.ref_13400.choosejuggernautcratemodel)) {
    return false;
  }

  if(istrue(var_0.inuse)) {
    return false;
  }

  if(var_1 isswitchingweapon()) {
    return false;
  }

  if(var_1.currentweapon.basename == "iw8_spotter_scope_mp_ch3") {
    return false;
  }

  if(var_1 scripts\cp_mp\utility\player_utility::isinvehicle()) {
    return false;
  }

  if(istrue(var_1.tracking_max_health)) {
    return false;
  }

  if(istrue(var_1.inlaststand)) {
    return false;
  }

  if(istrue(var_1.isreviving)) {
    return false;
  }

  if(istrue(var_1.isjuggernaut)) {
    return false;
  }

  if(var_1 isskydiving()) {
    return false;
  }

  if(var_1 isparachuting()) {
    return false;
  }

  if(istrue(var_1.iszombie)) {
    return false;
  }

  var_2 = max(level.ref_13BEB, 30);
  var_3 = getdvarint("scr_ascender_override_max_active", var_2);

  if(var_3 != -1) {
    var_2 = var_3;
  }

  if(level.initpostmain >= var_2) {
    return false;
  }

  return true;
}

function cleanupascenduse(var_0) {
  if(isDefined(var_0)) {
    var_0 allowmelee(1);
    var_0 allowads(1);
    var_0 allowfire(1);

    if(istrue(var_0.isjuggernaut)) {
      if(scripts\cp_mp\utility\script_utility::issharedfuncdefined("juggernaut", "canUseWeaponPickups")) {
        var_1 = var_0[[scripts\cp_mp\utility\script_utility::getsharedfunc("juggernaut", "canUseWeaponPickups")]]();

        if(istrue(var_1)) {
          var_0 enableweaponswitch();
        }
      }
    } else if(!istrue(var_0.inlaststand)) {
      var_0 enableoffhandweapons();
      var_0 enableweaponswitch();
      var_0 scripts\common\utility::allow_killstreaks(1);
      var_0 scripts\common\utility::allow_supers(1);
    } else {
      thread watch_for_ashes_achievement();
    }
  }

  waitframe();

  if(isDefined(var_0)) {
    if(!istrue(var_0.skyhooklaststand)) {
      var_0 allowmelee(1);
      var_0 enableweaponswitch();
      var_0 method_87e5();
      var_0 thread scripts\mp\utility\infilexfil::takegunless();
    }

    var_0 notify("remove_rig");
    var_0 scripts\common\utility::allow_usability(1);
    return;
  }
}

function watch_for_ashes_achievement() {
  level endon("game_ended");
  self.skyhooklaststand = 1;
  self allowmelee(0);
  scripts\engine\utility::ref_143A5("death_or_disconnect", "last_stand_finished");
  self allowmelee(1);
  self enableoffhandweapons();
  self enableweaponswitch();
  self method_87e5();
  scripts\common\utility::allow_killstreaks(1);
  scripts\common\utility::allow_supers(1);
  thread scripts\mp\utility\infilexfil::takegunless();
  self.skyhooklaststand = undefined;
}

function ascenddeathlistener(var_0, var_1) {
  self endon("skyhook_complete");
  scripts\engine\utility::waittill_any_ents(self, "death_or_disconnect", self, "last_stand_start", level, "game_ended");

  if(isDefined(self)) {
    self stopanimscriptsceneevent();
  }

  var_0.a_e_skyhook_ascenders[var_1] stoploopsound("br_auto_ascender_device_lp_npc");
  var_0.capacity = scripts\engine\utility::array_remove(var_0.capacity, self);
  playerstartarenasetcontrols(self, var_1, var_0);
}

function handleownervisibility(var_0, var_1) {
  if(isDefined(var_0)) {
    var_0 unlink();

    if(!var_0 scripts\common\utility::can_be_executed()) {
      var_0 scripts\common\utility::allow_execution_victim(1);
    }
  }

  if(isDefined(self.a_e_skyhook_ascenders[var_1])) {
    self.a_e_skyhook_ascenders[var_1] scripts\cp_mp\ent_manager::deregisterspawn();
    self.a_e_skyhook_ascenders[var_1] delete();
    return;
  }
}

function balloon_collision_watcher() {
  level endon("game_ended");
  level endon("respawn_skyhooks");
  self endon("balloon_destroyed");

  for(;;) {
    self waittill("collision", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7);

    if(var_4[2] > self.origin[2] + 2500 && isDefined(var_7) && var_7 scripts\cp_mp\vehicles\vehicle::isvehicle()) {
      thread kill_vehicle_delayed(var_7);
      self dodamage(self.health + 1, var_4, var_7, var_7, "MOD_CRUSH");
    }
  }
}

function kill_vehicle_delayed(var_0) {
  self endon("death");
  wait 0.15;

  if(isalive(self)) {
    self dodamage(99999, var_0);
    return;
  }
}

function chopperexfil_sh010_start() {
  level endon("game_ended");
  level endon("respawn_skyhooks");

  for(;;) {
    self waittill("damage", var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);

    if(isDefined(var_9) && isDefined(var_9.magazine)) {
      switch (var_9.magazine) {
        case "calcust1_xmike109":
          var_0 = 300;
          break;
        case "calcust2_xmike109":
          if(var_3[2] >= self.origin[2] + 2500) {
            thread fake_thermite_damage_duration(3, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
          }

          break;
      }
    }

    if(var_0 < 2) {
      continue;
    }

    if(var_3[2] <= self.origin[2] + 2500) {
      self.health += var_0;
      continue;
    }

    if(istrue(self.ref_133FA.chopper_boss_drone_target_array)) {
      var_0 = int(var_0 * level.ref_13400.ref_12929);
    }

    if(isPlayer(var_1)) {
      var_1 scripts\mp\damagefeedback::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");
    } else if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1.owner scripts\mp\damagefeedback::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");
    }

    if(isDefined(var_1) && isDefined(var_1.currentweapon) && isDefined(var_1.currentweapon.basename) && var_1.currentweapon.basename == "manual_turret_flak_mp") {
      self.health -= int(var_0 * (level.ref_13400.arenaflag_previewflag - 1));
    }

    if(isDefined(var_4) && var_4 == "MOD_PROJECTILE" || var_4 == "MOD_GRENADE" || var_4 == "MOD_EXPLOSIVE" || var_4 == "MOD_EXPLOSIVE_BULLET") {
      self.health -= int(var_0 * (level.ref_13400.open_door_to_next_objective - 1));
    }

    if(isDefined(var_9) && isDefined(var_9.basename) && var_9.basename == "toma_proj_mp") {
      self.health = 0;
    }

    if(self.health <= 0) {
      break;
    }

    if(isDefined(var_9) && isDefined(var_9.magazine)) {
      switch (var_9.magazine) {
        case "boltexplo_crossbow":
          thread fake_explosion_damage_delayed(2.05, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
          break;
        case "boltfire_crossbow":
          thread fake_thermite_damage_duration(4, var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10);
          break;
      }
    }
  }

  if(isDefined(var_1.model) && var_1.model == "veh_s4_mil_air_dalpha_wz_turret_attach" && isDefined(var_1.owner) && isPlayer(var_1.owner)) {
    var_1.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]]("kill", 500);
  }

  if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_1.currentweapon) && isDefined(var_1.currentweapon.basename) && var_1.currentweapon.basename == "tur_gun_bt_mp") {
    var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]]("kill", 500);
  }

  chopperexfil_sh050_start();
}

function scriptable_skyhook_placed_damaged(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10) {
  if(!isDefined(var_2) || !isDefined(var_2.classname) || var_2.classname != "scriptable_scriptable_skyhook_placed") {
    return;
  }

  if(var_3 < 2) {
    return;
  }

  if(var_8[2] <= var_2.origin[2] + 4450 || var_8[2] >= var_2.origin[2] + 4900) {
    return;
  }

  if(istrue(var_2.chopper_boss_drone_target_array)) {
    var_3 = int(var_3 * level.ref_13400.ref_12929);
  }

  if(isPlayer(var_1)) {
    var_1 scripts\mp\damagefeedback::updatehitmarker("standard", var_2.health == 0, 0, 1, "hitequip");
  } else if(isDefined(var_1.owner) && isPlayer(var_1.owner)) {
    var_1.owner scripts\mp\damagefeedback::updatehitmarker("standard", var_2.health == 0, 0, 1, "hitequip");
  }

  if(isDefined(var_1.model) && var_1.model == "veh_s4_mil_air_dalpha_wz" || var_1.model == "veh_s4_mil_air_bomber_wz" || var_1.model == "veh8_mil_air_lbravo_mp_flyable" || var_1.model == "veh8_mil_air_lbravo_mp_flyable_mg") {
    thread vfx_htown_stab_blink_1(level, var_1);
  }

  if(isDefined(var_1) && isDefined(var_1.currentweapon) && isDefined(var_1.currentweapon.basename) && var_1.currentweapon.basename == "manual_turret_flak_mp") {
    var_3 = int(var_3 * level.ref_13400.arenaflag_previewflag);
  }

  if(isDefined(var_5) && var_5 == 3 || var_5 == 4 || var_5 == 5 || var_5 == 6 || var_5 == 7 || var_5 == 16) {
    var_3 = int(var_3 * level.ref_13400.open_door_to_next_objective);
  }

  if(isDefined(var_0) && isDefined(var_0.model) && var_0.model == "ks_airstrike_target_br_ch3") {
    var_3 = level.ref_13400.ref_1284A;
  }

  var_2.health -= var_3;

  if(isDefined(var_6) && isDefined(var_6.basename) && var_6.basename == "toma_proj_mp") {
    var_2.health = 0;
  }

  if(var_2.health <= 0) {
    if(isDefined(var_1.model) && var_1.model == "veh_s4_mil_air_dalpha_wz_turret_attach" && isDefined(var_1.owner) && isPlayer(var_1.owner)) {
      var_1.owner thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]]("kill", 500);
    }

    if(isDefined(var_1) && isPlayer(var_1) && isDefined(var_1.currentweapon) && isDefined(var_1.currentweapon.basename) && var_1.currentweapon.basename == "tur_gun_bt_mp") {
      var_1 thread[[scripts\cp_mp\utility\script_utility::getsharedfunc("rank", "giveRankXP")]]("kill", 500);
    }

    balloon_placed_destroyed(var_2, var_0, var_1);
    return;
  }
}

function fake_explosion_damage_delayed(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("balloon_destroyed");
  wait var_0;
  self dodamage(var_1, var_4, var_2, undefined, undefined, undefined, var_4);
}

function fake_thermite_damage_duration(var_0, var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11) {
  self endon("balloon_destroyed");
  var_12 = 0;

  while(var_12 < var_0) {
    wait 0.25;

    if(scripts\mp\utility\player::isreallyalive(var_2)) {
      var_2 scripts\mp\damagefeedback::updatehitmarker("standard", self.health == 0, 0, 1, "hitequip");
    }

    var_12 += 0.25;
  }

  self dodamage(level.ref_13400.thermite_dps * var_0, var_4, var_2, undefined, undefined, undefined, var_4);
}

function ref_1284A(var_0, var_1, var_2) {
  if(getdvarint("scr_skyhooks_enabled", 0)) {
    if(isDefined(var_0["hittype"]) && var_0["hittype"] == "hittype_entity" && isDefined(var_0["entity"]) && isDefined(var_0["entity"].model) && var_0["entity"].model == "lm_military_skyhook_extraction_01_ch3") {
      wait 0.3;

      if(var_0["position"][2] > var_0["entity"].origin[2] + 2500) {
        if(isDefined(var_2)) {
          var_0["entity"] dodamage(level.ref_13400.ref_1284A, var_0["position"], undefined, var_2);
        } else {
          var_0["entity"] dodamage(level.ref_13400.ref_1284A, var_0["position"]);
        }

        if(var_0["entity"].health <= 0) {
          var_2.brattractions++;
          return;
        }

        return;
      }

      return;
    }

    return;
  }
}

function chopperexfil_sh050_start() {
  self.ref_133FA setscriptablepartstate("skyhook", "broken");
  ref_13402(self.ref_133FA);
  playFX(level.ref_13400.iskillstreakvehicleinflictor, self.ref_133FA.origin + (0, 0, 4500));
  self.ref_133FA setscriptablepartstate("sfx", "expl_sfx");
  self.ref_133FA notify("balloon_destroyed");
  radiusdamage(self.origin + (0, 0, 4500), 512, 100, 100, undefined, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

function balloon_placed_destroyed(var_0, var_1) {
  self setscriptablepartstate("skyhook", "broken");
  playFX(level.ref_13400.iskillstreakvehicleinflictor, self.origin + (0, 0, 4500));
  self notify("balloon_destroyed");

  if(isDefined(var_0) && isDefined(var_0.model) && var_0.model == "ks_airstrike_target_br_ch3") {
    var_1.brattractions++;
  }

  waitframe();
  radiusdamage(self.origin + (0, 0, 4500), 512, 100, 100, undefined, "MOD_EXPLOSIVE", "claymore_radial_mp");
}

function vfx_htown_stab_blink_1(var_0, var_1) {
  wait 0.15;

  if(scripts\mp\utility\player::isreallyalive(var_0)) {
    var_0 dodamage(9999, var_1);
    return;
  }
}

#using_animtree("");

function initanimtree() {
  level.scr_animtree["script_model"] = #animtree;
  level.scr_anim["script_model"]["redeploy_loop"] = $wm_redeploy_balloon_idle;
  level.scr_animname["script_model"]["redeploy_loop"] = "wm_redeploy_balloon_idle";
  level.scr_eventanim["script_model"]["redeploy_loop"] = "redeploy_loop";
  level.scr_animtree["player"] = #animtree;
  level.scr_anim["player"]["redeploy_enter"] = % vm_eq_redeploy_enter_plr;
  level.scr_animname["player"]["redeploy_enter"] = "vm_eq_redeploy_enter_plr";
  level.scr_eventanim["player"]["redeploy_enter"] = "redeploy_enter";
  level.scr_anim["player"]["redeploy_loop"] = % vm_eq_redeploy_loop_plr;
  level.scr_animname["player"]["redeploy_loop"] = "vm_eq_redeploy_loop_plr";
  level.scr_eventanim["player"]["redeploy_loop"] = "redeploy_loop";
  level.scr_anim["player"]["redeploy_exit"] = % vm_eq_redeploy_exit_plr;
  level.scr_animname["player"]["redeploy_exit"] = "vm_eq_redeploy_exit_plr";
  level.scr_eventanim["player"]["redeploy_exit"] = "redeploy_exit";
  level.scr_animtree["device"] = #animtree;
  level.scr_anim["device"]["redeploy_enter"] = % wm_eq_redeploy_enter_ascender;
  level.scr_animname["device"]["redeploy_enter"] = "wm_eq_redeploy_enter_ascender";
  level.scr_eventanim["device"]["redeploy_enter"] = "redeploy_enter";
  level.scr_anim["device"]["redeploy_loop"] = % wm_eq_redeploy_loop_ascender;
  level.scr_animname["device"]["redeploy_loop"] = "wm_eq_redeploy_loop_ascender";
  level.scr_eventanim["device"]["redeploy_loop"] = "redeploy_loop";
  level.scr_anim["device"]["redeploy_exit"] = % wm_eq_redeploy_exit_ascender;
  level.scr_animname["device"]["redeploy_exit"] = "wm_eq_redeploy_exit_ascender";
  level.scr_eventanim["device"]["redeploy_exit"] = "redeploy_exit";
}

function ref_133FB(var_0, var_1, var_2) {
  var_0 endon("death_or_disconnect");
  var_0 endon("ascender_cancel");
  thread ref_13404(var_0, "player", var_0.origin);
  var_1.animname = "device";
  var_1 scripts\common\anim::setanimtree();
  var_2.animname = "device";
  var_2 scripts\common\anim::setanimtree();
  var_2 hide();
  var_3 = "TAG_ACCESSORY_RIGHT";
  var_4 = "redeploy_enter";
  var_5 = var_0.origin - self.origin;
  var_6 = vectorNormalize(var_5) * length((-16.12, 9.073, 0));
  var_7 = rotatevector((-16.12, 9.073, 0), (0, var_0.angles[1] - -35.985, 0));
  var_8 = self.origin + var_7;
  var_0 scripts\common\utility::allow_execution_victim(0);
  self.ref_140BB = self.origin;
  self.origin = var_0.origin;
  self moveTo(self.ref_140BB, 0.4, 0.1, 0.1);
  self.ref_140B3 = self.angles;
  self.angles = var_0 getplayerangles();
  self rotateTo(self.ref_140B3, 0.4, 0.1, 0.1);
  var_0.player_rig moveTo(var_8, 0.4, 0.1, 0.1);
  var_9 = vectortoangles(-1 * (var_6[0], var_6[1], 0));
  var_0.player_rig rotateTo(var_9, 0.4, 0.1, 0.1);
  var_10 = var_0 scripts\mp\utility\infilexfil::givegunless();

  if(!var_10) {
    return false;
  }

  var_0 disableweaponswitch();
  var_0 method_87e4();
  var_0.player_rig linkTo(self, "tag_origin", -1 * var_6, (0, 0, 0));
  var_1 linkTo(var_0.player_rig, var_3, (0, 0, 0), (0, 0, 0));
  var_2 linkTo(self, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.player_rig showonlytoplayer(var_0);
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_4);
  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_4);
  waitframe();
  thread scripts\common\anim::anim_single_solo(var_2, var_4);
  var_11 = 0.1;
  wait var_11;
  var_2 show();

  if(!getdvarint("scr_skyhook_show_thirdperson_ascender", 0)) {
    var_2 hidefromplayer(var_0);
  }

  var_12 = getanimlength(level.scr_anim["player"][var_4]) - var_11;
  wait var_12 * 0.55;
  var_0 earthquakeforplayer(0.1, 0.25, var_0.origin, 1000);
  wait var_12 * 0.45;
  return true;
}

function ref_13404(var_0, var_1, var_2) {
  self.animname = var_0;

  if(!isDefined(var_1)) {
    var_1 = (0, 0, 0);
  }

  if(!isDefined(var_2)) {
    var_2 = (0, 0, 0);
  }

  self predictstreampos(var_1);
  var_3 = spawn("script_arms", var_1, 0, 0, self);
  var_3.angles = var_2;
  var_3.player = self;
  self.player_rig = var_3;
  self.player_rig hide(1);
  self.player_rig.animname = var_0;
  self.player_rig useanimtree(#animtree);
  self.player_rig.updatedversion = 1;
  self.player_rig.weapon_state_func = &scripts\mp\utility\infilexfil::handleweaponstatenotetrack;
  self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = &scripts\mp\utility\infilexfil::handledofnotetrack;
  self playerlinktodelta(self.player_rig, "tag_player", 1, 70, 70, 30, 30, 1);
  self notify("rig_created");
  scripts\engine\utility::ref_143A5("remove_rig", "player_free_spot");

  if(istrue(level.gameended)) {
    return;
  }

  if(isDefined(self)) {
    self unlink();

    if(!istrue(self.skyhooklaststand)) {
      self allowmelee(1);
      self enableweaponswitch();
      self method_87e5();
      thread scripts\mp\utility\infilexfil::takegunless();
    }
  }

  if(isDefined(var_3)) {
    var_3 delete();
    return;
  }
}

function ref_13401() {
  self setModel("lm_military_skyhook_extraction_01_ch3");
  self setscriptablepartstate("objective", "available");
}

function ref_13402() {
  self.chopperexfil_sfx_before_sh070 setModel("br_skyhook_extraction_base_01_ch3");
  self.chopperexfil_sfx_before_sh070 setscriptablepartstate("objective", "broken");
}

function ref_133FD(var_0, var_1, var_2) {
  var_3 = "redeploy_loop";
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_3);
  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_3);
  thread scripts\common\anim::anim_single_solo(var_2, var_3);
}

function ref_133FC(var_0, var_1, var_2) {
  var_3 = "redeploy_exit";
  scripts\common\anim::anim_first_frame_solo(var_0.player_rig, var_3);
  thread scripts\mp\anim::anim_player_solo(var_0, var_0.player_rig, var_3);

  if(isDefined(var_2)) {
    var_2 scripts\cp_mp\ent_manager::deregisterspawn();
    var_2 delete();
    return;
  }
}

function ref_13403() {
  self endon("death_or_disconnect");

  while(!self isonground()) {
    var_0 = scripts\common\utility::playersincylinder(self.origin, level.ref_13400.warning_radius, undefined, level.ref_13400.warning_height);
    var_1 = self.team;

    foreach(var_3 in var_0) {
      if(scripts\mp\utility\game::updatehistoryhud(var_3)) {
        continue;
      }

      var_4 = var_1 == var_3.team;

      if(var_4) {
        continue;
      }

      var_5 = !scripts\mp\utility\player::isreallyalive(var_3) || istrue(var_3.inlaststand);

      if(var_5) {
        continue;
      }

      var_6 = var_3 isparachuting() || var_3 isinfreefall();

      if(var_6) {
        continue;
      }

      var_7 = gettime();
      var_8 = isDefined(var_3.showteamlittlebirds) && var_7 - var_3.showteamlittlebirds < level.ref_13400.warning_timeout_ms;

      if(var_8) {
        continue;
      }

      var_3.showteamlittlebirds = var_7;

      if(var_3 scripts\cp_mp\utility\game_utility::ref_140A8()) {
        var_9 = "bchr";
      } else {
        var_10 = scripts\mp\gametypes\br_public::disableannouncer(var_3);
        var_9 = game["voice"][var_10];
      }

      var_3 queuedialogforplayer(level.audio_railyard_fires[var_9], "respawning_enemy_in_area", 2);
    }

    waitframe();
  }
}

function isplatepouch() {
  scripts\mp\gametypes\br_dev::ref_12B21(&isplacementplayerobstructed);
  thread isplayerbrsquadleader();
}

function isplayerbrsquadleader() {
  level endon("game_ended");

  while(!isDefined(level.player)) {
    waitframe();
  }
}

function isplacementplayerobstructed(var_0, var_1) {
  switch (var_0) {
    case "skyhook_spawn":
      level.ref_13400.aq_ontimerexpired = [[level.players[0].origin, level.players[0].angles]];
      ref_135D3();
      break;
  }
}

function debug_destroy_balloon_delayed(var_0, var_1, var_2) {
  wait var_2;

  if(isDefined(var_0.chopperexfil_sfx_before_sh070)) {
    var_0.chopperexfil_sfx_before_sh070 dodamage(999999, var_1.origin + (0, 0, 4000));
    return;
  }

  balloon_placed_destroyed(var_0);
}