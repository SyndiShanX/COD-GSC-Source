/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\gametypes\br_gxp_fear.gsc
************************************************/

function init() {
  level.disable_super_in_turret.placementstatsset = 0;

  if(!getdvarint("scr_br_gxp_fear", 0)) {
    return;
  }

  level.disable_super_in_turret.platform_model = [];
  level.disable_super_in_turret.play_3p_anim = 0;
  thread ref_143f9();
  tr_vis_radius_override_lod1();
}

function tr_vis_radius_override_lod1() {
  level.disable_super_in_turret.play_3p_anim_non_animscene = spawnStruct();
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11c1c = getdvarint("scr_fear_min", 0);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e = getdvarint("scr_fear_max", 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr = level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e / 2;
  level.disable_super_in_turret.play_3p_anim_non_animscene.is_wave_gametype = getdvarint("scr_fear_damage_max", 100);
  level.disable_super_in_turret.play_3p_anim_non_animscene.isangleoffset = getdvarfloat("scr_fear_damage_scalar", 2);
  level.disable_super_in_turret.play_3p_anim_non_animscene.calloutmarkerpingvo_playpredictivepinginventoryrequest = getdvarfloat("scr_fear_armor_damage_scalar", 2);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_1423c = getdvarfloat("scr_fear_vehicle_damage_scalar", 2);
  level.disable_super_in_turret.play_3p_anim_non_animscene.circle_speed = int(getdvarfloat("scr_fear_baseline_interval", 1) * 1000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.circle_acceleration = getdvarint("scr_fear_baseline_increment", 2);
  level.disable_super_in_turret.play_3p_anim_non_animscene.circle_back_to_combat = getdvarint("scr_fear_baseline_increment_camping", 2);
  level.disable_super_in_turret.play_3p_anim_non_animscene.circle_defaults = getdvarint("scr_fear_baseline_increment_ghosts", 3);
  level.disable_super_in_turret.play_3p_anim_non_animscene.saw_headicons = getdvarint("scr_fear_ghost_radius", 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.sat_wait_for_controller = int(getdvarfloat("scr_fear_ghost_interval", 5) * 1000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.scn_infil_hackney_heli_npc5 = getdvarint("scr_fear_ghost_spectral_blast", 25);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_1209e = int(getdvarfloat("scr_fear_onteammatekilled", 0.15) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_1204d = int(getdvarfloat("scr_fear_onlaststandenteredself", 0.15) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_1204e = int(getdvarfloat("scr_fear_onlaststandenteredteammate", 0.15) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12049 = int(getdvarfloat("scr_fear_onkillstreakdanger", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12022 = int(getdvarfloat("scr_fear_onenemyequipment", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12068 = int(getdvarfloat("scr_fear_onplayerdied", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12055 = int(getdvarfloat("scr_fear_onlootboxjumpscare", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.onplayerkilled = int(getdvarfloat("scr_fear_onplayerkilled", 0.15) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12039 = int(getdvarfloat("scr_fear_onghostkilled", 0.25) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12050 = int(getdvarfloat("scr_fear_onlaststandrevive", 0.2) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11fff = int(getdvarfloat("scr_fear_onarmorplate", 0.05) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12008 = int(getdvarfloat("scr_fear_oncontractcomplete", 0.1) * 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.gasmask_onpickupcreated = getdvarint("scr_fear_camping_grace_period", 3);
  level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_use = getdvarint("scr_fear_camping_distance_decay", 50);
  level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo = getdvarint("scr_fear_camping_distance", 500);
  level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_spawn = getdvarint("scr_fear_camping_distance_cap", 5000);
  level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think = [];
  level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think[0] = "br_gov_fear_heart_high";
  level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think[1] = "br_gov_fear_heart_high";
  level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think[2] = "br_gov_fear_heart_low";
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_138ae = [];
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_138ae[0] = "br_gov_fear_whsp_high";
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_13b4a = [];
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_13b4a[0] = "br_gov_fear_sting_high";
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_13b4a[1] = "br_gov_fear_sting_med";
  level.disable_super_in_turret.play_3p_anim_non_animscene.ref_13b4a[2] = "br_gov_fear_sting_low";
}

function ref_143f9() {
  waittillframeend();
  scripts\mp\flags::gameflagwait("prematch_fade_done");

  foreach(var_1 in level.br_pickups.br_equipname) {}

  level.disable_super_in_turret.placementstatsset = 1;

  if(istrue(level.br_infils_disabled)) {
    foreach(var_4 in level.players) {
      thread lethal_crate_spawn();
    }
  }

  ref_12b20("onPlayerDamaged", &plant_bomb_cleanup_on_death);
  ref_12b20("onPlayerArmorDamaged", &plant_add_zplanes_override);
  ref_12b20("onLastStandEnter", &plane_landing_fx);
  ref_12b20("onKillstreakDanger", &plane_door_opened);
  ref_12b20("onTeammateKilled", &plane, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_1209e);
  ref_12b20("onPlayerDied", &plane, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12068);
  ref_12b20("onVehicleDamaged", &plate_dest);
  ref_12b20("onPlayerHallucinate", &plant_enemy_claymore);
  ref_12b20("onLastStandRevive", &placing_c4_interaction_use_monitor, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12050);
  ref_12b20("onArmorPlate", &placing_c4_interaction_use_monitor, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11fff);
  ref_12b20("onContractEnd", &plane_collmap, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12008);
  ref_12b20("onOpenLootBox", &planewaittillcandrop);
  ref_12b20("onPlayerKilled", &plant_remove_zplanes_override);
  thread ref_13fee();

  if(!getdvarint("scr_br_gxp_disable_hallucination_player_vfx", 0)) {
    level thread scripts\mp\gametypes\br_gxp_hallucination::ref_11e33();
    return;
  }
}

function start_preserverroom_spawners(var_0) {
  var_1 = remove_flag_trig();
  self.setarenaomnvarhealthtype = clamp(self.setarenaomnvarhealthtype + var_0, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11c1c, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e);
  self setclientomnvar("ui_br_fear_meter", (self.setarenaomnvarhealthtype - level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11c1c) / (level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e - level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11c1c));
  place_bad_place_until_flag(var_1);
}

function juggernaut_damage_thread(var_0) {
  self.setarenaomnvarhealthtype = clamp(self.setarenaomnvarhealthtype - var_0, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11c1c, level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e);
  self setclientomnvar("ui_br_fear_meter", (self.setarenaomnvarhealthtype - level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11c1c) / (level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e - level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11c1c));
}

function get_ai_hearing_bomb_plant_sound() {
  if(istrue(self.setcheckliststateforteam)) {
    return false;
  }

  if(self.setarenaomnvarhealthtype >= level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr) {
    return true;
  }

  return false;
}

function remove_flag_trig() {
  if(self.setarenaomnvarhealthtype < level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr) {
    return 0;
  }

  return (self.setarenaomnvarhealthtype - level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr) / (level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e - level.disable_super_in_turret.play_3p_anim_non_animscene.setsuperweapondisabledbr);
}

function onplayerconnect(var_0) {
  if(!getdvarint("scr_br_gxp_fear", 0)) {
    return;
  }

  headlessinfils(var_0);
}

function onplayerspawned() {
  if(!level.disable_super_in_turret.placementstatsset) {
    return;
  }

  headlessinfils();
  thread lethal_crate_spawn();
}

function placementupdatewait(var_0, var_1, var_2) {
  if(!level.disable_super_in_turret.placementstatsset) {
    return;
  }

  if(!isDefined(level.disable_super_in_turret.platform_model[var_0].function)) {
    scripts\mp\utility\script::laststand_dogtags(var_0 + " is not defined in triggerFear.");
  }

  if(isDefined(level.disable_super_in_turret.platform_model[var_0].function)) {
    if(isDefined(var_2)) {
      return [[level.disable_super_in_turret.platform_model[var_0].function]](level.disable_super_in_turret.platform_model[var_0].value, var_1, var_2);
    }

    if(isDefined(var_1)) {
      return [[level.disable_super_in_turret.platform_model[var_0].function]](level.disable_super_in_turret.platform_model[var_0].value, var_1);
    }

    return [[level.disable_super_in_turret.platform_model[var_0].function]](level.disable_super_in_turret.platform_model[var_0].value);
  }
}

function ref_12b20(var_0, var_1, var_2) {
  if(isDefined(level.disable_super_in_turret.platform_model[var_0])) {
    scripts\mp\utility\script::laststand_dogtags("registerFearCause already has " + var_0 + " defined.");
  }

  if(!isDefined(var_2)) {
    var_2 = 0;
  }

  level.disable_super_in_turret.platform_model[var_0] = spawnStruct();
  level.disable_super_in_turret.platform_model[var_0].function = var_1;
  level.disable_super_in_turret.platform_model[var_0].value = var_2;
}

function headlessinfils() {
  self.setarenaomnvarhealthtype = 0;
  self.setarenaomnvarplayertype = gettime();
  self.setbeingrevivedinternal = 0;
  self.setbrokenoverlaymaterial = gettime();
  self.setbettermissionrewards = 0;
  self.setburningdamage = 0;
  self.setburningpartstate = gettime();
  self.setbrjuggsettings = self.origin + (0, 0, 1) * level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_spawn;
}

function unset_heavy_hitter() {
  return false;
}

function ref_13b0c() {
  var_0 = level.disable_super_in_turret.play_3p_anim_non_animscene.gasmask_onpickupcreated;
  var_1 = 1;

  if(unset_heavy_hitter()) {
    var_1 = 0;
  } else {
    var_2 = vectorNormalize(self.setbrjuggsettings - self.origin);
    var_3 = distance(self.origin, self.setbrjuggsettings);
    var_4 = clamp(var_3 - level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_use * level.disable_super_in_turret.play_3p_anim_non_animscene.circle_speed * 0.001, 0, level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_spawn);
    self.setbrjuggsettings = self.origin + var_2 * var_4;

    if(var_4 < level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo) {
      self.setbettermissionrewards = 1;
    } else {
      self.setbettermissionrewards = 0;
    }

    if(self.setbettermissionrewards == 0) {
      var_1 = 0;
    }
  }

  if(var_1 == 0) {
    self.setbeingrevivedinternal = 0;
    return false;
  } else {
    self.setbeingrevivedinternal++;

    if(self.setbeingrevivedinternal >= var_0) {
      return true;
    }
  }

  return false;
}

function calloutmarkerping_initcommon() {
  if(self.setburningpartstate + level.disable_super_in_turret.play_3p_anim_non_animscene.sat_wait_for_controller < gettime()) {
    self.setburningpartstate = gettime();
    var_0 = scripts\mp\utility\player::getplayersinradius(self.origin, level.disable_super_in_turret.play_3p_anim_non_animscene.saw_headicons);

    foreach(var_2 in var_0) {
      if(var_2.team == self.team && self.squadindex == self.squadindex) {
        continue;
      }

      if(scripts\mp\gametypes\br_public::ref_125ec()) {
        self.setburningdamage = 1;
        break;
      }
    }
  }

  return self.setburningdamage;
}

function trackendangeredobjs() {
  return scripts\mp\gametypes\br_gxp_safe_zones::truckdoorleft(self);
}

function circle_acceleration() {
  if(self.setarenaomnvarplayertype + level.disable_super_in_turret.play_3p_anim_non_animscene.circle_speed < gettime()) {
    var_0 = trackendangeredobjs();
    scripts\mp\gametypes\br_gametype_gxp_ghost::ref_13fdd("inSafeZone", var_0);

    if(var_0) {
      juggernaut_damage_thread(level.disable_super_in_turret.ref_12e6c);
    } else {
      var_1 = level.disable_super_in_turret.play_3p_anim_non_animscene.circle_acceleration;

      if(ref_13b0c()) {
        var_1 += level.disable_super_in_turret.play_3p_anim_non_animscene.circle_back_to_combat;
      }

      if(calloutmarkerping_initcommon()) {
        var_1 += level.disable_super_in_turret.play_3p_anim_non_animscene.circle_defaults;
      }

      start_preserverroom_spawners(var_1);
    }

    self.setarenaomnvarplayertype = gettime();
    return;
  }
}

function ref_13312() {
  if(self.sessionstate != "playing") {
    return false;
  }

  if(scripts\mp\utility\game::updatehistoryhud(self)) {
    return false;
  }

  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    return false;
  }

  if(istrue(self.inlaststand)) {
    return false;
  }

  return true;
}

function ref_132ee() {
  if(self.sessionstate != "playing") {
    return true;
  }

  if(scripts\mp\utility\game::updatehistoryhud(self)) {
    return true;
  }

  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    return true;
  }

  return false;
}

function ref_13fd7() {
  self endon("disconnect");

  if(ref_13312()) {
    circle_acceleration();

    if(get_ai_hearing_bomb_plant_sound()) {
      scripts\mp\gametypes\br_gxp_hallucination::update(remove_flag_trig());
      return;
    }

    scripts\mp\gametypes\br_gxp_hallucination::has_target_player();
    return;
  }

  scripts\mp\gametypes\br_gxp_hallucination::has_target_player();

  if(ref_132ee()) {
    headlessinfils();
    return;
  }
}

function ref_13fee() {
  for(;;) {
    if(isDefined(level.players) && level.players.size) {
      level.disable_super_in_turret.play_3p_anim %= level.players.size;
      var_0 = clamp(10, 1, level.players.size);

      for(var_1 = 0; var_1 < var_0; var_1++) {
        var_2 = level.disable_super_in_turret.play_3p_anim;
        var_3 = level.players[var_2];
        level.disable_super_in_turret.play_3p_anim = (level.disable_super_in_turret.play_3p_anim + 1) % level.players.size;
        thread ref_13fd7();
        thread pkg_lbl_vo();
      }
    }

    wait 0.05;
  }
}

function plane(var_0, var_1) {
  start_preserverroom_spawners(var_0);
}

function plant_bomb_cleanup_on_death(var_0, var_1) {
  var_2 = var_1.objweapon.basename;
  var_3 = scripts\mp\utility\weapon::getequipmenttype(var_2);

  if(isDefined(var_3)) {
    if(var_3 == "equipment_other" || var_3 == "tactical") {
      start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12022);
      return;
    }
  }

  if(var_2 == "emp_drone_player_mp") {
    start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene.scn_infil_hackney_heli_npc5);
    return;
  }

  var_4 = clamp(var_1.damage, 0, level.disable_super_in_turret.play_3p_anim_non_animscene.is_wave_gametype);
  var_5 = var_4 * level.disable_super_in_turret.play_3p_anim_non_animscene.isangleoffset;
  start_preserverroom_spawners(var_5);
}

function plant_add_zplanes_override(var_0, var_1) {
  if(!isDefined(var_1.stack_patch_waittill_stack) || !var_1.stack_patch_waittill_stack) {
    var_2 = clamp(var_1.is_spawner_position_valid, 0, level.disable_super_in_turret.play_3p_anim_non_animscene.is_wave_gametype);
    var_3 = var_2 * level.disable_super_in_turret.play_3p_anim_non_animscene.calloutmarkerpingvo_playpredictivepinginventoryrequest;
    start_preserverroom_spawners(var_3);
    return;
  }
}

function plate_dest(var_0, var_1) {
  var_2 = clamp(var_1.damage, 0, level.disable_super_in_turret.play_3p_anim_non_animscene.is_wave_gametype);
  var_3 = var_2 * level.disable_super_in_turret.play_3p_anim_non_animscene.ref_1423c;
  var_4 = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getalloccupants(self);

  if(isDefined(var_4)) {
    foreach(var_6 in var_4) {
      if(isDefined(var_6) && isalive(var_6)) {
        start_preserverroom_spawners(var_6, var_3);
      }
    }

    return;
  }
}

function plane_landing_fx(var_0, var_1) {
  if(!isDefined(var_1)) {
    return;
  }

  if(self == var_1) {
    start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene.ref_1204d);
    return;
  }

  start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene.ref_1204e);
}

function plane_door_opened(var_0, var_1) {
  if(istrue(var_1.ref_12466) && scripts\mp\utility\killstreak::getkillstreakenemyusedialogue(var_1.ref_11ed2)) {
    var_2 = level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12049;
    start_preserverroom_spawners(var_2);
    return;
  }
}

function placing_c4_interaction_use_monitor(var_0, var_1) {
  juggernaut_damage_thread(var_0);
}

function plant_enemy_claymore(var_0, var_1) {
  scripts\mp\gametypes\br_gametype_gxp_challenges::ref_11ff0(self, var_0);
  var_2 = var_1.pity_timer_end_time * level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e;
  juggernaut_damage_thread(var_2);
}

function plane_collmap(var_0, var_1) {
  if(var_1 == 1) {
    juggernaut_damage_thread(var_0);
    return;
  }
}

function planewaittillcandrop(var_0) {
  if(_getactualcost::ref_13e19()) {
    start_preserverroom_spawners(level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12055);
    return;
  }
}

function plant_remove_zplanes_override(var_0, var_1) {
  var_2 = var_1.victim;
  var_3 = var_1.attacker;

  if(var_2 scripts\mp\gametypes\br_public::ref_125ec()) {
    juggernaut_damage_thread(level.disable_super_in_turret.play_3p_anim_non_animscene.ref_12039);
    return;
  }

  juggernaut_damage_thread(level.disable_super_in_turret.play_3p_anim_non_animscene.onplayerkilled);
}

function pkg_lbl_vo() {
  var_0 = gettime();

  if(isDefined(self.ref_11e76) && var_0 < self.ref_11e76) {
    return;
  }

  var_1 = remove_flag_trig();
  var_2 = 1;
  var_3 = 0.5;
  var_4 = scripts\engine\math::lerp(var_2, var_3, var_1);
  self.ref_11e76 = var_0 + int(1000 * var_4);

  if(var_1 <= 0) {
    return;
  }

  for(var_5 = 0; var_5 < level.disable_super_in_turret.setsuperisinuse.size; var_5++) {
    var_6 = level.disable_super_in_turret.setsuperisinuse[var_5].ref_13db4;

    if(var_1 < var_6) {
      continue;
    }

    var_7 = level.disable_super_in_turret.play_3p_anim_non_animscene.clear_players_from_door_way_think[var_5];

    if(isDefined(var_7)) {
      self playlocalsound(var_7, self);
    }

    var_8 = level.disable_super_in_turret.play_3p_anim_non_animscene.ref_138ae[var_5];

    if(isDefined(var_8)) {
      if(!isDefined(self.ref_11e77) || var_0 >= self.ref_11e77) {
        self playlocalsound(var_8);
        self.ref_11e77 = var_0 + int(1000 * randomfloatrange(3, 5));
      }
    }

    break;
  }
}

function place_bad_place_until_flag(var_0) {
  if(getdvarint("scr_br_gxp_disable_fear_threshold_stinger", 0)) {
    return;
  }

  var_1 = remove_flag_trig();

  if(var_1 <= 0) {
    return;
  }

  var_2 = 0;

  while(var_2 < level.disable_super_in_turret.setsuperisinuse.size) {
    var_3 = level.disable_super_in_turret.setsuperisinuse[var_2].ref_13db4;

    if(var_0 <= var_3 && var_1 >= var_3) {
      var_4 = level.disable_super_in_turret.play_3p_anim_non_animscene.ref_13b4a[var_2];

      if(isDefined(var_4)) {
        self playlocalsound(var_4, self);
      }

      return;
    }

    var_3++;
  }
}

function lethal_crate_spawn() {
  if(!getdvarint("scr_br_fear_enable_dev_draw", 0)) {
    return;
  }

  if(isbot(self) || initmaxspeedforpathlengthtable(self)) {
    return;
  }

  if(isDefined(self.lethaldelayallows)) {
    return;
  }

  if(scripts\mp\gametypes\br_public::ref_125ec()) {
    return;
  }

  var_0 = 200;
  var_1 = 250;
  self.lethaldelayallows = scripts\mp\hud_util::createprimaryprogressbar(var_0, var_1);
  self.letters = scripts\mp\hud_util::createprimaryprogressbartext(var_0 + 75, var_1 + 13);
  self.letters setvalue(0);

  if(getdvarint("scr_br_gxp_fear_camping_debug", 0)) {
    self.lethal_equipmentmaskoffsets = scripts\mp\hud_util::createprimaryprogressbar(200, 235);
  }

  thread level_respawn_func();
}

function level_respawn_func() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = self.setarenaomnvarhealthtype;
  var_1 = distance(self.origin, self.setbrjuggsettings);

  for(;;) {
    var_2 = self.setarenaomnvarhealthtype;

    if(var_0 != var_2) {
      var_3 = var_2 / level.disable_super_in_turret.play_3p_anim_non_animscene.ref_11b5e;

      if(var_3 > 1) {
        var_3 = 1;
      }

      self.lethaldelayallows scripts\mp\hud_util::updatebar(var_3, 0);
      var_0 = var_2;
      self.lethaldelayallows.bar.color = scripts\mp\gametypes\br_gxp_hallucination::level_ammo_crate_spawn();

      if(self.setbeingrevivedinternal >= level.disable_super_in_turret.play_3p_anim_non_animscene.gasmask_onpickupcreated) {
        self.lethaldelayallows.color = (0.7, 0.3, 0.3);
      } else {
        self.lethaldelayallows.color = (0.5, 0.5, 0.5);
      }

      self.letters setvalue(var_2);
    }

    if(getdvarint("scr_br_gxp_fear_camping_debug", 0)) {
      var_4 = distance(self.origin, self.setbrjuggsettings);

      if(var_1 != var_4) {
        if(var_4 < level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo) {
          var_3 = min((level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo - var_4) / level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo, 1);
          self.lethal_equipmentmaskoffsets scripts\mp\hud_util::updatebar(var_3, 0);
          self.lethal_equipmentmaskoffsets.bar.color = (1, 0, 0);
        } else {
          var_3 = min((var_3 - level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo) / (level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_spawn - level.disable_super_in_turret.play_3p_anim_non_animscene.gasgrenade_crate_player_at_max_ammo), 1);
          self.lethal_equipmentmaskoffsets scripts\mp\hud_util::updatebar(var_3, 0);
          self.lethal_equipmentmaskoffsets.bar.color = (1, 1, 1);
        }

        var_2 = var_3;
      }
    }

    waitframe();
  }
}