/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\utility.gsc
***********************************************/

function delete_live_grenades() {
  var0 = getEntArray("grenade", "classname");

  foreach(var2 in var0) {
    if(!isDefined(var2.targetname) && var2.model != "offhand_wm_molotov_sp") {
      var2 delete();
    }
  }

  if(scripts\sp\equipment\offhands::offhandisprecached("molotov")) {
    thread scripts\sp\equipment\molotov::delete_all_molotovs();
  }

  if(level.player isthrowinggrenade()) {
    GscBinSkip4(0x6e, level.player);
  }
}

function delete_grenade_when_thrown() {
  level.player waittill("grenade_fire", var0, var1);

  if(isDefined(var0)) {
    var0 delete();
    return;
  }
}

function assign_animtree_based_on_subclass() {
  var0 = tolower(self.subclass);

  switch (var0) {
    case "c6":
      assign_c6_animtree();
      break;
    case "c8":
      assign_c8_animtree();
      break;
    case "c12":
      assign_c12_animtree();
      break;
    case "no_boost":
    case "crew":
    case "regular":
    case "elite":
    case "riotshield":
    case "juggernaut":
      assign_human_animtree();
      break;
    default:
      break;
  }
}

function assign_animtree_based_on_unittype() {
  var0 = tolower(self.unittype);

  switch (var0) {
    case "c6":
      assign_c6_animtree();
      break;
    case "c8":
      assign_c8_animtree();
      break;
    case "c12":
      assign_c12_animtree();
      break;
    case "c6i":
    case "civilian":
    case "soldier":
      assign_human_animtree();
      break;
    default:
      break;
  }
}

#using_animtree("c6");

function assign_c6_animtree() {
  self useanimtree(#animtree);
}

#using_animtree("c8");

function assign_c8_animtree() {
  self useanimtree(#animtree);
}

#using_animtree("c12");

function assign_c12_animtree() {
  self useanimtree(#animtree);
}

#using_animtree("generic_human");

function assign_human_animtree() {
  self useanimtree(#animtree);
}

#using_animtree("");

function enable_procedural_bones() {
  self setanim(%proc_node, 1, 0);
}

function disable_procedural_bones() {
  self setanim(%proc_node, 0, 0);
}

function change_player_health_packets(var0) {
  self.player_health_packets += var0;
  self notify("update_health_packets");

  if(self.player_health_packets >= 3) {
    self.player_health_packets = 3;
    return;
  }
}

function player_in_zerog() {
  if(isPlayer(self)) {
    var0 = self;
  } else {
    var0 = level.player;
  }

  return isDefined(var0.space) && var0.space.floating;
}

function do_damage(var0, var1, var2, var3, var4, var5, var6) {
  if(self == level.player) {
    var0 = scripts\sp\player::dodamagefilter(var0, var4);
  }

  return self dodamage(var0, var1, var2, var3, var4, var5, var6);
}

function set_player_attacker_accuracy(var0) {
  var1 = scripts\engine\sp\utility::get_player_from_self();
  var1.scriptedattackeraccuracy = var0;
  var1 scripts\sp\gameskill::update_player_attacker_accuracy();
}

function player_has_unlocked_stored_equipment_slots() {
  if(!isDefined(level.player.storedslotsunlocked) || !level.player.storedslotsunlocked) {
    return 0;
  }

  return 1;
}

function player_seek_enable() {
  self endon("death");
  self endon("stop_player_seek");
  var0 = 1200;

  if(has_shotgun()) {
    var0 = 250;
  }

  var1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait 2;
    self.goalradius = var1;
    var2 = level.player;
    self setgoalentity(var2);
    var1 -= 175;

    if(var1 < var0) {
      var1 = var0;
      return;
    }
  }
}

function player_seek_disable() {
  self notify("stop_player_seek");
}

function riotshield_lock_orientation(var0) {
  self orientmode("face angle", var0);
  self.lockorientation = 1;
}

function riotshield_unlock_orientation() {
  self.lockorientation = 0;
}

function cqb_walk(var0) {
  if(var0 == "on") {
    scripts\common\utility::enable_cqbwalk();
    return;
  }

  scripts\common\utility::disable_cqbwalk();
}

function enable_flashlight(var0, var1) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(var0) {
    scripts\sp\nvg\nvg_ai::flashlight_on(var1);
    return;
  }

  scripts\sp\nvg\nvg_ai::flashlight_off(var1);
}

function throwgrenadeatplayerasap() {
  scripts\anim\combat_utility::throwgrenadeatplayerasap_combat_utility();
}

function use_turret(var0, var1) {
  scripts\asm\asm_bb::bb_requestturret(var0);
  scripts\asm\asm_bb::bb_requestturretpose(var1);
  var3 = var0 gettagorigin("tag_gunner");
  var4 = var0 gettagangles("tag_gunner");

  if(self islinked()) {
    self unlink();
  }

  self forceteleport(var3, var4);
  self linktoblendtotag(var0, "tag_gunner", 0);
}

function waterfx(var0, var1) {
  self endon("death");
  var2 = 0;

  if(isDefined(var1)) {
    var2 = 1;
  }

  jumpiffalse(isDefined(var0)) LOC_00000025;
  scripts\engine\utility::flag_assert(var0);
  level endon(var0);

  for(;;) {
    wait randomfloatrange(0.15, 0.3);
    var3 = self.origin + (0, 0, 150);
    var4 = self.origin - (0, 0, 150);
    var5 = scripts\engine\trace::ray_trace_detail(var3, var4, undefined, scripts\engine\trace::create_default_contents(1));

    if(var5["surfacetype"] != "water") {
      continue;
    }

    var6 = "water_movement";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        var6 = "water_stop";
      }
    } else if(isDefined(level._effect["water_" + self.a.movement])) {
      var6 = "water_" + self.a.movement;
    }

    var7 = scripts\engine\utility::getfx(var6);
    var3 = var5["position"];
    var8 = (0, self.angles[1], 0);
    var9 = anglesToForward(var8);
    var10 = anglestoup(var8);
    playFX(var7, var3, var10, var9);

    if(var6 != "water_stop" && var2) {
      thread scripts\engine\utility::play_sound_in_space(var1, var3);
    }
  }
}

function player_is_near_live_offhand() {
  var0 = getEntArray("grenade", "classname");

  foreach(var2 in var0) {
    if(!offhand_is_dangerous(var2)) {
      continue;
    }

    for(var3 = 0; var3 < level.players.size; var3++) {
      var4 = level.players[var3];

      if(distancesquared(var2.origin, var4.origin) < 75625) {
        scripts\sp\autosave::autosaveprint("live grenade too close to player", 0);
        return true;
      }
    }
  }

  return false;
}

function offhand_is_dangerous(var0) {
  if(!isDefined(var0.targetname)) {
    return true;
  }

  if(var0.targetname == "offhand_claymore") {
    return false;
  }

  if(var0.targetname == "offhand_c4_no_detonator") {
    return false;
  }

  if(var0.targetname == "offhand_noisemaker") {
    return false;
  }

  if(var0.targetname == "offhand_throwingknife") {
    return false;
  }

  if(var0.targetname == "offhand_car_grenade") {
    return false;
  }

  if(var0.targetname == "offhand_ied") {
    return false;
  }

  return true;
}

function has_shotgun() {
  self endon("death");

  if(!isDefined(self.weapon)) {
    return false;
  }

  if(weaponclass(self.weapon) == "spread") {
    return true;
  }

  return false;
}

function isprimaryweapon(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return 0;
  }

  if(isstring(var0) && var0 == "none") {
    return 0;
  }

  if(weaponinventorytype(var0) != "primary") {
    return 0;
  }

  switch (weaponclass(var0)) {
    case "smg":
    case "pistol":
    case "sniper":
    case "spread":
    case "mg":
    case "rifle":
    case "rocketlauncher":
      return 1;
    default:
      return 0;
  }
}

function enable_heat_behavior(var0) {
  self.heat = 1;
  self.disablepistol = 1;
  self.balwayscoverexposed = 1;

  if(!isDefined(var0) || !var0) {
    self.dontshootwhilemoving = 1;
    self.maxfaceenemydist = 64;
    self.pathenemylookahead = 2048;
    scripts\engine\sp\utility::disable_surprise();
  }

  self.specialreloadanimfunc = &scripts\anim\animset::heat_reload_anim;
  self.custommoveanimset["run"] = scripts\anim\utility::lookupanimarray("heat_run");
}

function disable_heat_behavior() {
  self.heat = undefined;
  self.disablepistol = 0;
  self.dontshootwhilemoving = 0;
  self.balwayscoverexposed = undefined;
  self.maxfaceenemydist = 512;
  self.specialreloadanimfunc = undefined;
  self.custommoveanimset = undefined;
}

function interactivekeypairs() {
  var0 = [];
  GscBinSkip0(0x2e, 0, ["interactive_birds", "targetname"]);
}

function mask_interactives_in_volumes(var0) {
  var1 = interactivekeypairs();
  var2 = [];

  foreach(var4 in var1) {
    var5 = getEntArray(var4[0], var4[1]);
    var2 = scripts\engine\utility::array_combine(var2, var5);
  }

  foreach(var8 in var2) {
    if(!isDefined(level._interactive[var8.interactive_type].savetostructfn)) {
      continue;
    }

    foreach(var11 in var0) {
      if(!var11 istouching(var8)) {
        continue;
      }

      if(!isDefined(var11.interactives)) {
        var11.interactives = [];
      }

      var11.interactives[var11.interactives.size] = var8[[level._interactive[var8.interactive_type].savetostructfn]]();
    }
  }
}

function activate_interactives_in_volume() {
  if(!isDefined(self.interactives)) {
    return;
  }

  foreach(var1 in self.interactives) {
    var1[[level._interactive[var1.interactive_type].loadfromstructfn]]();
  }

  self.interactives = undefined;
}

function delete_interactives_in_volumes(var0) {
  mask_interactives_in_volumes(var0);

  foreach(var2 in var0) {
    var2.interactives = undefined;
  }
}

function allow_hands(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("hands", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
      self sethandsoccupied(0);
      return;
    }

    self sethandsoccupied(1);
    return;
  }
}

function is_hands_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("hands");
}

function allow_weapon_scanning(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("weaponScanning", var0, var1);

  if(isDefined(var2) && var2) {
    scripts\engine\utility::flag_clear("weapon_scanning_off");
    return;
  }

  if(isDefined(var2) && !var2) {
    scripts\engine\utility::flag_set("weapon_scanning_off");
    return;
  }
}

function is_weapon_scanning_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weaponScanning");
}

function allow_antigrav_float(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("antigravFloat", var0, var1);

  if(isDefined(var2)) {
    if(var2) {
      level.player scripts\engine\utility::ent_flag_clear("disable_antigrav_float");
      return;
    }

    if(!level.player scripts\engine\utility::ent_flag_exist("disable_antigrav_float")) {
      level.player scripts\engine\utility::ent_flag_init("disable_antigrav_float");
    }

    level.player scripts\engine\utility::ent_flag_set("disable_antigrav_float");
    return;
  }
}

function is_antigrav_float_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("antigravFloat");
}

function allow_cg_drawcrosshair(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("cg_drawcrosshair", var0, var1);

  if(isDefined(var2)) {
    setsaveddvar("LOPKSRNTTS", var2);
    return;
  }
}

function is_cg_drawcrosshair_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("cg_drawcrosshair");
}

function allow_weapon_first_raise_anims(var0, var1) {
  var2 = scripts\common\input_allow::allow_input_internal("firstRaiseAnims", var0, var1);

  if(isDefined(var2) && var2) {
    setsaveddvar("MRKKPQPTQR", 0);
    return;
  }

  if(isDefined(var2) && !var2) {
    setsaveddvar("MRKKPQPTQR", 1);
    return;
  }
}

function is_weapon_first_raise_anims_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("firstRaiseAnims");
}

function is_in_antigrav_grenade() {
  if(self == level.player) {
    if(!isDefined(self.inantigrav) || self.inantigrav == 0) {
      return 0;
    }

    return 1;
  }

  if(!isDefined(self.antigravgrenstate)) {
    return 0;
  }

  return 1;
}

function hud_intel_message(var0, var1, var2, var3) {
  var4 = 20;

  if(!isDefined(var2)) {
    var2 = "default";
  }

  switch (var2) {
    case "intel_acepilot0":
      var4 = 0;
      break;
    case "intel_acepilot1":
      var4 = 1;
      break;
    case "intel_acepilot2":
      var4 = 2;
      break;
    case "intel_acepilot3":
      var4 = 3;
      break;
    case "intel_acepilot4":
      var4 = 4;
      break;
    case "intel_acepilot5":
      var4 = 5;
      break;
    case "intel_acepilot6":
      var4 = 6;
      break;
    case "intel_acepilot7":
      var4 = 7;
      break;
    case "intel_acepilot8":
      var4 = 8;
      break;
    case "intel_acepilot9":
      var4 = 9;
      break;
    case "intel_acepilot10":
      var4 = 10;
      break;
    case "intel_acepilot11":
      var4 = 11;
      break;
    case "intel_acepilot12":
      var4 = 12;
      break;
    case "intel_acepilot13":
      var4 = 13;
      break;
    case "intel_acepilot14":
      var4 = 14;
      break;
    case "intel_acepilot15":
      var4 = 15;
      break;
    case "intel_acepilot16":
      var4 = 16;
      break;
    case "intel_acepilot17":
      var4 = 17;
      break;
    case "intel_acepilot18":
      var4 = 18;
      break;
    case "intel_acepilot19":
      var4 = 19;
      break;
    case "default":
      var4 = 20;
      break;
    case "capops_intel":
      var4 = 20;
      break;
    case "tally_intel":
      var4 = 21;
      break;
    case "jackal_intel":
      var4 = 22;
      break;
    case "sdf_intel_1":
      var4 = 23;
      break;
    case "news_intel":
      var4 = 24;
      break;
    case "eweapon_intel":
      var4 = 25;
      break;
    case "scan_intel":
      var4 = 26;
      break;
    case "intel_captain0":
      var4 = 27;
      break;
    case "intel_captain1":
      var4 = 28;
      break;
    case "intel_captain2":
      var4 = 29;
      break;
    case "intel_captain3":
      var4 = 30;
      break;
    case "intel_captain4":
      var4 = 31;
      break;
    case "intel_captain5":
      var4 = 32;
      break;
    case "intel_captain6":
      var4 = 33;
      break;
    case "intel_captain7":
      var4 = 34;
      break;
    case "intel_captain8":
      var4 = 35;
      break;
    case "intel_captain9":
      var4 = 36;
      break;
    case "intel_scrap":
      var4 = 37;
      break;
    case "intel_reticle":
      var4 = 38;
      break;
    case "intel_attachment":
      var4 = 39;
      break;
  }

  setomnvar("ui_sp_intel_messaging_image_index", var4);
  setomnvar("ui_sp_intel_messaging_text", var1);
  setomnvar("ui_sp_intel_messaging_header", var0);
  setomnvar("ui_sp_intel_messaging", 1);
  level.player thread scripts\engine\sp\utility::_intel_waypoint_button_listener();
  var5 = var2 == "tally_intel";

  if(var5) {
    level.player thread scripts\engine\sp\utility::_intel_dismiss_button_listener();
  }

  if(isDefined(var3)) {
    setomnvar("ui_sp_intel_messaging_ent", 1);
  } else {
    setomnvar("ui_sp_intel_messaging_ent", 0);
  }

  var6 = "close";
  var7 = gettime() / 1000;
  var8 = 5;

  while(var5 && !isDefined(level.player.intel_dismiss_request) || !var5 && gettime() / 1000 - var7 < var8) {
    if(isDefined(level.player.intel_waypoint_request)) {
      var6 = "waypoint";
      break;
    }

    wait 0.05;
  }

  setomnvar("ui_sp_intel_messaging", 0);
  setomnvar("ui_sp_intel_messaging_ent", 0);
  level.player.intel_dismiss_request = undefined;

  if(var6 == "waypoint" && isDefined(var3)) {
    var9 = scripts\engine\utility::spawn_script_origin(var3, (0, 0, 0));
    var9.icon = newhudelem();
    var9.icon setshader("intel_hint_icon", 32, 32);
    var9.icon.color = (0, 1, 0.976);
    var9.icon.alpha = 1;
    var9.icon setwaypoint(1, 1, 0);
    var9.icon settargetEnt(var9);
    var10 = distance2dsquared(level.player.origin, var9.origin);

    for(;;) {
      if(distance2dsquared(level.player.origin, var9.origin) < squared(75) || distance2dsquared(level.player.origin, var9.origin) > var10 * 2.5) {
        break;
      }

      wait 0.05;
    }

    var9.icon destroy();
    var9 delete();
    level.player.intel_waypoint_request = undefined;
    return;
  }

  level.player notify("dismiss_skipped");
  level.player.intel_dismiss_request = undefined;
}

function is_demo() {
  if(getdvarint("scr_demo", 0)) {
    return true;
  }

  return false;
}

function is_lastlevel() {
  if(level.script == "lab") {
    return true;
  }

  return false;
}

function hudoutline_ar_callout(var0, var1, var2) {
  if(isDefined(level.player.ar_callout_ent)) {
    hudoutline_ar_disable();
  }

  level.player endon("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  wait 0.05;
  setsaveddvar("NMROQRRONQ", 1);
  level.player.ar_callout_ent = scripts\engine\utility::spawn_tag_origin();
  setomnvar("ui_inworld_ar_ent", level.player.ar_callout_ent);

  if(!isDefined(var0)) {
    var0 = "ar_callouts_default";
  }

  setomnvar("ui_ar_object_text", var0);
  wait 0.05;

  if(isDefined(var1) && var1) {
    scripts\engine\sp\utility::hudoutline_enable_new("outlinefill_depth_orange", "default");
  } else {
    scripts\engine\sp\utility::hudoutline_enable_new("outlinefill_nodepth_orange", "default");
  }

  setomnvar("ui_show_ar_elem", 1);
  thread _ar_callout_tracker(var2);
}

function _ar_callout_tracker(var0) {
  level.player endon("stop_ar_callout");
  self endon("death");

  for(;;) {
    if(isDefined(var0)) {
      var1 = self.origin + var0;
    } else {
      var1 = self.origin + (0, 0, 30);
    }

    level.player.ar_callout_ent.origin = var1;
    wait 0.05;
  }
}

function hudoutline_ar_disable() {
  scripts\engine\sp\utility::hudoutline_disable("default");
  setomnvar("ui_show_ar_elem", 0);
  wait 0.1;
  level.player notify("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  level.player.ar_callout_ent delete();
  level.player.ar_callout_ent = undefined;
}

function in_specialist_mode() {
  if(getdvarint("NPSPRQNQRN")) {
    return 1;
  }

  return 0;
}

function in_yolo_mode() {
  if(getdvarint("LQMTORORON")) {
    return 1;
  }

  return 0;
}

function in_zero_gravity() {
  return level.player scripts\engine\utility::ent_flag_exist("zero_gravity") && level.player scripts\engine\utility::ent_flag("zero_gravity");
}

function remove_equipment_immediately(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(var0)) {
    var0 = 1;
  }

  if(!isDefined(var1)) {
    var1 = 1;
  }

  if(!isDefined(var2)) {
    var2 = 1;
  }

  if(!isDefined(var3)) {
    var3 = 1;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  if(!isDefined(var5)) {
    var5 = 0;
    return;
  }
}

function isactorwallrunning() {
  if(isDefined(self.wall_run_direction)) {
    return true;
  }

  return false;
}

function init_modern() {
  precachesuit("modern_sp");
  level.player setsuit("modern_sp");
}

function setplayerlootenabled(var0) {
  setDvar("scr_player_loot_enabled", var0);
}

function playerlootenabled() {
  return getdvarint("scr_player_loot_enabled");
}

function personalcoldbreathstop() {
  self notify("stop personal effect");
}

function personalcoldbreathspawner() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  for(;;) {
    self waittill("spawned", var0);

    if(scripts\common\ai::spawn_failed(var0)) {
      continue;
    }

    var0 thread scripts\anim\utility::personalcoldbreath();
  }
}

function missionfailedwrapper() {
  if(level.missionfailed) {
    return;
  }

  if(isDefined(level.nextmission)) {
    return;
  }

  scripts\sp\analytics::analytics_obj_failed();
  level.missionfailed = 1;
  scripts\engine\utility::flag_set("missionfailed");

  if(getDvar("failure_disabled") == "1") {
    return;
  }

  if(isDefined(level.mission_fail_func)) {
    GscBinSkip1(0x74, level.mission_fail_func);
  }

  thread scripts\sp\player_death::set_death_hint();
  missionfailed(in_yolo_mode());
}

function giveachievement_wrapper(var0, var1) {
  if(is_demo()) {
    return;
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!var1 && is_lastlevel()) {
    return;
  }

  level.player giveachievement(var0);
}

function player_giveachievement_wrapper(var0) {
  if(is_demo()) {
    return;
  }

  if(is_lastlevel()) {
    return;
  }

  self giveachievement(var0);
}

function play_skippable_cinematic(var0, var1, var2) {
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame(var0);
  level.player scripts\sp\player::remove_damage_effects_instantly();
  remove_equipment_immediately();
  level.player scripts\common\utility::allow_weapon(0);
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  level.player cleardamageindicators();
  level.player enableplayerbreathsystem(0);
  setomnvar("ui_hide_hud", 1);
  allow_cg_drawcrosshair(level.player, 0);
  setomnvar("ui_hide_weapon_info", 1);

  while(!iscinematicplaying()) {
    waitframe();
  }

  thread cinematic_skip_input(var1);

  if(isDefined(var2)) {
    cinematic_waittill_skip_or_time(var2);
    level.player scripts\common\utility::allow_weapon(1);
    level.player disableinvulnerability();
    level.player freezecontrols(0);
    level.player cleardamageindicators();
    level.player enableplayerbreathsystem(1);
    setomnvar("ui_hide_hud", 0);
    allow_cg_drawcrosshair(level.player, 1);
    setomnvar("ui_hide_weapon_info", 0);
    level notify("skippable_cinematic_done");

    while(iscinematicplaying()) {
      waitframe();
    }

    setsaveddvar("MMRNLMPPLT", "0");
    setsaveddvar("RKMNLRNS", "0");
    setomnvar("ui_is_bink_skippable", 0);
    stopcinematicingame();
    return;
  }

  while(iscinematicplaying()) {
    waitframe();
  }

  setsaveddvar("MMRNLMPPLT", "0");
  setsaveddvar("RKMNLRNS", "0");
  setomnvar("ui_is_bink_skippable", 0);
  stopcinematicingame();
  level.player scripts\common\utility::allow_weapon(1);
  level.player disableinvulnerability();
  level.player freezecontrols(0);
  level.player cleardamageindicators();
  level.player enableplayerbreathsystem(1);
  setomnvar("ui_hide_hud", 0);
  allow_cg_drawcrosshair(level.player, 1);
  setomnvar("ui_hide_weapon_info", 0);
  level notify("skippable_cinematic_done");
}

function cinematic_skip_input(var0) {
  level endon("skippable_cinematic_done");

  if(isDefined(var0)) {
    self waittill(var0);
  }

  setomnvar("ui_is_bink_skippable", 1);

  for(;;) {
    level.player waittill("luinotifyserver", var1, var2);

    if(var1 == "skip_bink_input") {
      level notify("cinematic_skipped");
      stopcinematicingame();
      break;
    }
  }
}

function cinematic_waittill_skip_or_time(var0) {
  level endon("cinematic_skipped");
  var0 *= 1000;

  for(;;) {
    var1 = cinematicgettimeinmsec();

    if(var1 >= var0) {
      return;
    }

    waitframe();
  }
}

function isriotshield(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return false;
  }

  if(isstring(var0) && var0 == "none") {
    return false;
  }

  return weapontype(var0) == "riotshield";
}

function isknifeonly(var0) {
  var1 = getweaponbasename(var0);
  return issubstr(var1, "knife");
}

function isbulletweapon(var0) {
  if(issameweapon(var0) && nullweapon(var0)) {
    return 0;
  }

  if(isstring(var0) && var0 == "none") {
    return 0;
  }

  if(isriotshield(var0) || isknifeonly(var0)) {
    return 0;
  }

  switch (weaponclass(var0)) {
    case "smg":
    case "pistol":
    case "sniper":
    case "spread":
    case "mg":
    case "rifle":
      return 1;
    default:
      return 0;
  }
}

function context_melee_enable(var0) {
  if(!var0) {
    level.player thread scripts\sp\player\context_melee::disable_dynamic_takedowns();
    return;
  }

  level thread scripts\sp\player\context_melee::main();
}

function context_melee_allow(var0) {
  self.context_melee_allowed = var0;
}

function context_melee_allow_blocked_hint(var0) {
  level.player.context_melee_blocked_hint_allowed = var0;
}

function context_melee_allow_directions(var0) {
  self.context_melee_allow_directions = var0;
}

function context_melee_set_silent_kill(var0) {
  if(var0) {
    setDvar("context_melee_silent", 1);
    return;
  }

  setDvar("context_melee_silent", 0);
}

function context_melee_set_custom_hint(var0) {
  level.player.context_melee_hint_custom = var0;
}

function context_melee_clear_custom_hint() {
  level.player.context_melee_hint_custom = undefined;
}

function context_melee_set_blocked_custom_hint(var0) {
  level.player.context_melee_hint_blocked_custom = var0;
}

function context_melee_clear_blocked_custom_hint() {
  level.player.context_melee_hint_blocked_custom = undefined;
}

function context_melee_set_hint_directions(var0) {
  level.player.context_melee_allow_directions = var0;
}

function context_melee_override_anim(var0, var1, var2, var3, var4) {
  if(!isDefined(var1)) {
    var1 = "all";
  }

  if(!isDefined(var0) && isDefined(self.context_melee_anim_name) && isDefined(self.context_melee_anim_name[var1])) {
    self.context_melee_anim_name[var1] = undefined;
    return;
  }

  if(isDefined(level.scr_anim["context_melee_player_rig"][var0]) && isDefined(level.scr_anim["generic"][var0])) {
    if(!isDefined(self.context_melee_anim_name)) {
      self.context_melee_anim_name = [];
    }

    self.context_melee_anim_name[var1] = var0;
    var5 = ["cm_death", "cm_ragdoll", "cm_fx", "cm_sfx", "cm_sfx_player"];
    GscBinSkip1(0x45, 0, &scripts\sp\player\context_melee::context_melee_death);
  }

  if(isDefined(var3)) {
    context_melee_set_lastframe_bone(var3);
  } else {
    context_melee_set_lastframe_bone(level.context_melee_player_link_bone);
  }

  if(isDefined(var4)) {
    context_melee_set_lastframe_type(var4);
  } else {
    context_melee_set_lastframe_type("player_capsule");
  }

  if(istrue(var5)) {
    level.context_melee_do_launch = 1;
    return;
  }
}

function context_melee_set_arms(var0) {
  level.scr_model["context_melee_player_rig"] = var0;
  level.player.melee_arms delete();
  level.player.melee_arms = scripts\engine\sp\utility::spawn_anim_model("context_melee_player_rig", level.player.origin, level.player.angles);
  level.player.melee_arms notsolid();
  level.player.melee_arms hide();
}

function context_melee_set_weapon(var0) {
  level.player.context_melee_knife = var0;
}

function context_melee_set_lastframe_bone(var0) {
  level.context_melee_lastframe_bone = var0;
}

function context_melee_set_lastframe_type(var0) {
  level.context_melee_lastframe_type = var0;
}

function context_melee_sight_disabled(var0) {
  level.context_melee_sight_disabled = var0;
}

function context_melee_waittill_player_finished() {
  level.player endon("death");
  level.player waittill("context_melee_anim_ended");
  waittillframeend();

  while(istrue(level.player.context_melee_launching)) {
    waitframe();
  }
}

function enable_stayahead(var0) {
  setdvarifuninitialized("scr_debug_stayahead", 0);
  disable_stayahead(0, 0);
  waittillframeend();
  thread scripts\sp\stayahead::stayahead_thread(var0);
}

function disable_stayahead(var0, var1) {
  if(isDefined(self.stayahead) && isDefined(self.stayahead.using_goto_node)) {
    scripts\sp\stayahead::print3d_debug(self.origin + (0, 0, 8), "Stayahead disabled, going back to go_to_node()", (0, 1, 0), 1, 0.3, 500, 1);
    thread scripts\sp\spawner::go_to_node(scripts\sp\stayahead::get_best_goto_node(self.stayahead.goto_patharray, 2));
  }

  if(isDefined(self.stayahead) && isDefined(self.stayahead.bg_2d)) {
    self.stayahead.bg_2d destroy();
  }

  if(isDefined(self.stayahead) && isDefined(self.stayahead.team)) {
    foreach(var3 in self.stayahead.team) {
      var3 scripts\engine\sp\utility::disable_dynamic_run_speed(var0);
    }
  }

  if(!isDefined(var1) || istrue(var1)) {
    self.stayahead = undefined;
  }

  if(!isDefined(var0)) {
    var0 = 165;
  }

  self notify("stop_stayahead");

  if(istrue(var0)) {
    scripts\engine\utility::set_movement_speed(var0);
    return;
  }
}

function set_stayahead_values(var0, var1, var2, var3) {
  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  GscBinSkip1(0x45, "speed", var1);
}

function set_stayahead_wait_values(var0, var1, var2) {
  set_stayahead_values("wait", 0, var0, 0);
  self.stayahead.pw["buffer"] = var1;

  if(istrue(var2)) {
    self.stayahead.use_goto_wait = 1;
    return;
  }
}

function stayahead_disable_wait() {
  if(isDefined(self.stayahead)) {
    if(isDefined(self.stayahead.goalnode_pw)) {
      var0 = scripts\engine\utility::ter_op(isDefined(self.stayahead.goalnode), self.stayahead.goalnode, self.goalnode);
      childthread scripts\sp\stayahead::stayahead_set_goalnode(var0, 0);
    }

    if(isDefined(self.stayahead.pw)) {
      self.stayahead.pw = undefined;
      return;
    }

    return;
  }
}

function enable_stayahead_turbo(var0) {
  if(!isDefined(self.stayahead)) {
    return;
  }

  if(isDefined(var0)) {}

  self.stayahead.turbo = var0;
}

function set_stayahead_wait_nodes(var0, var1) {
  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  if(isDefined(var0)) {
    self.stayahead.wait_nodes = var0;
  }

  if(istrue(var1)) {
    self.stayahead.use_goto_wait = 1;
    return;
  }
}

function set_stayahead_wait_func(var0) {
  self.stayahead.wait_func = var0;
}

function stayahead_add_to_team(var0, var1, var2, var3) {
  if(!isDefined(self.stayahead.team)) {
    self.stayahead.team = [];
  }

  var4 = [];

  if(!isarray(var0)) {
    GscBinSkip0(0x2e, 0, var0);
  }

  var4 = var0;

  foreach(var6 in var4) {
    if(!isDefined(var6.stayahead)) {
      var6.stayahead = spawnStruct();
    }

    var6.stayahead.dynamic_frontdist = var1;
    var6.stayahead.dynamic_middist = var2;
    var6.stayahead.dynamic_backdist = var3;
  }

  self.stayahead.team = scripts\engine\utility::array_combine(self.stayahead.team, var4);
}

function stayahead_pause(var0) {
  if(scripts\engine\utility::ent_flag_exist("stayahead_pause")) {
    if(var0) {
      scripts\engine\utility::ent_flag_set("stayahead_pause");
      return;
    }

    scripts\engine\utility::ent_flag_clear("stayahead_pause");
    return;
  }
}

function stayahead_set_wait_node_radius(var0) {
  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  self.stayahead.wait_node_radius = var0;
}

function stayahead_lookat_enabled(var0) {
  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  if(istrue(var0)) {
    self.stayahead.lookat_allowed = 1;
    return;
  }

  self.stayahead.lookat_allowed = undefined;
}

function createweapondefaultsarray() {
  if(!isDefined(level._weapons)) {
    level._weapons = spawnStruct();
  }

  if(!isDefined(level._weapons.tablelookups)) {
    level._weapons.tablelookups = 0;
  }

  if(!isDefined(level._weapons.defaults)) {
    level._weapons.defaults = [];
    var0 = tablelookupgetnumrows("sp/statstable.csv");
    level._weapons.tablelookups += 1;

    for(var1 = 0; var1 < var0; var1++) {
      var2 = tablelookupbyrow("sp/statstable.csv", var1, 1);
      level._weapons.tablelookups += 1;

      if(isDefined(var2) && var2.size > 0) {
        var3 = tablelookupbyrow("sp/statstable.csv", var1, 2);
        level._weapons.tablelookups += 1;

        if(var3.size > 0) {
          level._weapons.defaults[var2] = strtok(var3, " ");
        }
      }
    }

    var4 = [];
    var5 = 0;
    var6 = "empty";

    while(var6 != "") {
      var6 = tablelookupbyrow("sp/attachmentmap.csv", 0, var5);
      level._weapons.tablelookups += 1;
      var4 = scripts\engine\utility::array_add(var4, var6);
      var5++;
    }

    var7 = getarraykeys(level._weapons.defaults);

    foreach(var2 in var7) {
      for(var1 = 0; var1 < level._weapons.defaults[var2].size; var1++) {
        if(issubstr(level._weapons.defaults[var2][var1], "select")) {
          level._weapons.defaults[var2] = scripts\engine\utility::array_remove(level._weapons.defaults[var2], level._weapons.defaults[var2][var1]);
          var1 -= 1;
          continue;
        }

        var9 = scripts\engine\utility::array_find(var4, level._weapons.defaults[var2][var1]);

        if(isDefined(var9)) {
          var10 = tablelookup("sp/attachmentmap.csv", 0, var2, var9);
          level._weapons.tablelookups += 1;

          if(var10 != "") {
            switch (var10) {
              case "mag_mike14":
                var10 = "xmags_mike14";
                break;
            }

            level._weapons.defaults[var2][var1] = var10;
          }
        }
      }
    }

    return;
  }
}

function getweapondefaults(var0) {
  if(issameweapon(var0)) {
    var0 = getweaponbasename(var0);
  }

  createweapondefaultsarray(level);
  var0 = get_weapon_redirect(var0);
  var1 = level._weapons.defaults[var0];

  if(!isDefined(var1)) {
    var1 = [];
  }

  return var1;
}

function removeconflictingattachments(var0, var1) {
  var1 = removeconflictingdefaultattachment(var0, var1);
  var1 = removeconflictingdefaultattachment(var0, var1, "bar", "front_");
  var1 = removeconflictingdefaultattachment(var0, var1, "barlong", "slide_");
  var1 = removeconflictingdefaultattachment(var0, var1, "barcust", "guard_");
  var1 = removeconflictingdefaultattachment(var0, var1, "stock", "back_");
  var1 = removeconflictingdefaultattachment(var0, var1, "cal", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "drums", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "xmags", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "rack", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "mmags", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "xmagslrg", "xmags_");
  var1 = removeconflictingdefaultattachment(var0, var1, "mag_", "xmags_");
  var1 = removeconflictingdefaultattachment(var0, var1, "box_", "mag_");
  var1 = removeconflictingdefaultattachment(var0, var1, "rack", "ammo_");
  var1 = removeconflictingdefaultattachment(var0, var1, "thermal", "snprscope");
  var1 = removeconflictingdefaultattachment(var0, var1, "acog", "snprscope");
  var1 = removeconflictingdefaultattachment(var0, var1, "reflex", "snprscope");
  var1 = removeconflictingdefaultattachment(var0, var1, "holo", "snprscope");
  var1 = removeconflictingdefaultattachment(var0, var1, "hybrid", "snprscope");
  var1 = removeconflictingdefaultattachment(var0, var1, "vzscope", "snprscope");
  var1 = removeconflictingdefaultattachment(var0, var1, "minireddot", "snprscope");
  var1 = removeconflictingdefaultattachment(var0, var1, "thermal", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "acog", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "reflex", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "holo", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "hybrid", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "vzscope", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "minireddot", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "scope", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "snprscope", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "irons", "ironsdefault_");
  var1 = removeconflictingdefaultattachment(var0, var1, "grip", "gripcust_");
  return var1;
}

function removeconflictingdefaultattachment(var0, var1, var2, var3) {
  if(!isDefined(var2)) {
    foreach(var5 in var0) {
      var6 = strtok(var5, "_")[0];

      foreach(var9, var8 in var1) {
        if(var6 == strtok(var8, "_")[0]) {
          var1 = scripts\engine\utility::array_remove(var1, var8);
          continue;
        }

        if(issubstr(var5, "scope") && issubstr(var8, "scope")) {
          var1 = scripts\engine\utility::array_remove(var1, var8);
        }
      }
    }

    return var1;
  }

  foreach(var5 in var7) {
    if(isstartstr(var5, var9)) {
      for(var12 = 0; var12 < var8.size; var12++) {
        if(isstartstr(var8[var12], var10)) {
          var8 = scripts\engine\utility::array_remove_index(var8, var12);
          return var8;
        }
      }
    }
  }

  return var8;
}

function get_weapon_redirect(var0) {
  switch (var0) {
    case "iw8_ar_akilo47_goliath":
    case "iw8_ar_akilo47_brightmuzzle":
    case "iw8_ar_akilo47_melee":
    case "iw8_ar_akilo47_tfarah":
      var0 = "iw8_ar_akilo47";
      break;
    case "iw8_sn_hdromeo_ballistics":
      var0 = "iw8_sn_hdromeo";
      break;
    case "iw8_sn_hdromeo_ballistics_quickraise":
      var0 = "iw8_sn_hdromeo";
      break;
    case "iw8_pi_mike1911_first_raise":
      var0 = "iw8_pi_mike1911";
      break;
    case "iw8_la_mike32_incendiary":
      var0 = "iw8_la_mike32";
      break;
    case "iw8_sh_dpapa12_incendiary":
      var0 = "iw8_sh_dpapa12";
      break;
    case "iw8_pi_golf21_tfarah":
      var0 = "iw8_pi_golf21";
      break;
  }

  return var0;
}

function make_weapon(var0, var1, var2, var3, var4, var5) {
  if(!isDefined(level._weapons)) {
    level._weapons = spawnStruct();
  }

  if(!isDefined(var1)) {
    var1 = [];
  }

  if(!issameweapon(var0)) {
    var6 = strtok(var0, "+");

    if(var6.size > 1) {
      var0 = var6[0];
      var1 = scripts\engine\utility::array_combine(var1, scripts\engine\utility::array_remove(var6, var6[0]));
    }
  } else {
    if(nullweapon(var0)) {
      return var0;
    }

    var0 = getweaponbasename(var0);
  }

  if(istrue(var5)) {
    var7 = &makeweaponfromstring;
  } else {
    var7 = &getcompleteweaponname;
  }

  var8 = getweapondefaults(var1);
  var8 = removeconflictingattachments(var2, var8);
  var2 = scripts\engine\utility::array_combine(var2, var8);
  var9 = [];

  foreach(var11 in var2) {
    if(issubstr(var11, "|")) {
      var2 = scripts\engine\utility::array_remove(var2, var11);
      var2 = strtok(var11, "|")[0];
      var9 = var11;
    }
  }

  if(isDefined(var5)) {
    var13 = builtin[[var7]](var1, var2, var3, var4, var5);
  } else if(isDefined(var5)) {
    var13 = builtin[[var8]](var2, var3, var4, var5);
  } else if(isDefined(var5)) {
    var13 = builtin[[var9]](var3, var4, var5);
  } else if(isDefined(var5)) {
    var13 = builtin[[var10]](var4, var5);
  } else {
    var13 = builtin[[var11]](var5);
  }

  foreach(var13 in var13) {
    var6 = strtok(var13, "|");
    var13 = var13 withattachment(var6[0], int(var6[1]));
  }

  return var13;
}

function check_for_blacklisted_attachment() {
  var0 = self;
  var1 = [];
  GscBinSkip0(0x2e, var1.size, "attachment_wm_silencer01");
}

function give_weapon(var0, var1, var2, var3, var4) {
  if(isstring(var0)) {
    var0 = make_weapon(var0);
  }

  if(isDefined(var4)) {
    self giveweapon(var0, var1, var2, var3, var4);
    return;
  }

  if(isDefined(var3)) {
    self giveweapon(var0, var1, var2, var3);
    return;
  }

  if(isDefined(var2)) {
    self giveweapon(var0, var1, var2);
    return;
  }

  if(isDefined(var1)) {
    self giveweapon(var0, var1);
    return;
  }

  self giveweapon(var0);
}

function take_weapon(var0) {
  self takeweapon(var0);
}

function make_weapon_special(var0) {
  switch (var0) {
    case "farah_ar":
      var0 = make_weapon("iw8_ar_akilo47", ["rec_akilo47|1", "back_akilo47|1", "front_akilo47|1", "mag_akilo47|1"]);
      break;
    case "alex_sniper":
      var0 = make_weapon("iw8_sn_mike14", ["vzscope_mike14", "rec_mike14|1", "reargrip_mike14|1", "front_mike14|1", "xmags_mike14|1"]);
      break;
    case "alex_pistol":
      var0 = make_weapon("iw8_pi_mike1911", ["rec_mike1911|1", "mag_mike1911|1", "slide_mike1911|1"]);
      break;
    case "griggs_pistol":
      var0 = make_weapon("iw8_pi_mike1911", ["rec_mike1911|1", "mag_mike1911|1", "slide_mike1911"]);
      break;
    case "hadir_smg":
      var0 = make_weapon("iw8_sm_augolf", ["rec_augolf|1", "front_augolf|1", "mag_augolf|1", "toprail_augolf|1"]);
      break;
    case "hadir_sniper":
      var0 = make_weapon("iw8_sn_hdromeo_ballistics", ["vzscope_hdromeo_ballistics", "bipod_hdromeo_ballistics", "rec_hdromeo|1", "back_hdromeo|1", "front_hdromeo|1", "mag_hdromeo|1"]);
      break;
    case "sas_ar":
      var0 = make_weapon("iw8_ar_kilo433", ["holo_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
      break;
    case "price_ar":
      var0 = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
      break;
    case "kyle_ar":
      var0 = make_weapon("iw8_ar_mcharlie", ["semi_ar", "reflex_west01", "silencer04", "laserir", "rec_mcharlie|1", "back_mcharlie|1", "barshort_mcharlie|1", "mag_mcharlie|1"]);
      break;
    case "papa320_black":
      var0 = make_weapon("iw8_pi_papa320", ["rec_papa320|1", "mag_papa320|1", "slide_papa320|1"]);
      break;
    case "papa320_black_rain":
      var0 = make_weapon("iw8_pi_papa320", ["rec_papa320_r", "mag_papa320_r", "slide_papa320_r"]);
      break;
    case "barkov_pistol":
      var0 = make_weapon("iw8_pi_golf21", ["rec_golf21|1", "mag_golf21|1", "slide_golf21|1"]);
      break;
    case "estate_teaser_price":
      var0 = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    case "estate_teaser":
      var0 = make_weapon("iw8_ar_kilo433", ["reflex_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    case "enforcer_ar":
      var0 = make_weapon("iw8_ar_akilo47", ["drums_akilo47_sp", "gripvert_akilo47", "holostable_east01"]);
      break;
    case "enforcer_pistol":
      var0 = make_weapon("iw8_pi_decho", ["rec_decho|1", "mag_decho|1", "slide_decho|1", "triggrip_decho|1", "minireddotslow"]);
      break;
    default:
      var0 = undefined;
      break;
  }

  return var0;
}

function fixplacedweapons(var0) {
  var1 = [];
  var2 = getEntArray();

  foreach(var4 in var2) {
    if(!isDefined(var4.classname)) {
      continue;
    }

    if(scripts\engine\utility::string_starts_with(var4.classname, "weapon_")) {
      var1 = var4;
    }
  }

  foreach(var7 in var1) {
    var8 = strtok(var7.classname, "+");
    var9 = getsubstr(var8[0], 7, var8[0].size);
    var8 = scripts\engine\utility::array_remove_index(var8, 0);
    var10 = getweapondefaults(var9);
    var10 = removeconflictingattachments(var8, var10);
    var8 = scripts\engine\utility::array_combine(var10, var8);
    var11 = undefined;
    var12 = "";

    foreach(var14 in var8) {
      var12 = var12 + "+" + var14;

      if(var14 == "ub_golf25_sp" || var14 == "ub_mike203_sp") {
        var11 = 1;
      }
    }

    var16 = spawn("weapon_" + var9 + var12, var7.origin, var7.spawnflags);
    var16.angles = var7.angles;

    if(isDefined(var7.targetname)) {
      var16.targetname = var7.targetname;
    }

    if(isDefined(var7.script_noteworthy)) {
      var16.script_noteworthy = var7.script_noteworthy;
    }

    if(isDefined(var7.script_namenumber)) {
      var16.script_namenumber = var7.script_namenumber;
    }

    if(isDefined(var7.script_parameters)) {
      var16.script_parameters = var7.script_parameters;
    }

    if(isDefined(var7.script_label)) {
      var16.script_label = var7.script_label;
    }

    if(isDefined(var7.script_ammo_alt_clip)) {
      var16.script_ammo_alt_clip = var7.script_ammo_alt_clip;
    }

    if(isDefined(var7.script_ammo_alt_extra)) {
      var16.script_ammo_alt_extra = var7.script_ammo_alt_extra;
    }

    if(isDefined(var7.script_ammo_clip)) {
      var16.script_ammo_clip = var7.script_ammo_clip;
    }

    if(isDefined(var7.script_ammo_extra)) {
      var16.script_ammo_extra = var7.script_ammo_extra;
    }

    if(isDefined(var7.script_ammo_max)) {
      var16.script_ammo_max = var7.script_ammo_max;
    }

    var16 scripts\anim\shared::setscriptammo(var9, var7, var11);
    var7 delete();
  }
}

function aim_at(var0, var1, var2, var3) {
  self notify("stop_aiming");
  self endon("stop_aiming");
  self endon("death");

  if(!isDefined(var0)) {
    var0 = self localtoworldcoords((150, 0, 30));
  }

  if(!isDefined(var1)) {
    var1 = 0;
  }

  if(!isDefined(var3)) {
    var3 = 1.5;
  }

  self.aim_target = scripts\engine\utility::spawn_script_origin();
  self.aim_target.origin = self gettagorigin("tag_flash") + anglesToForward(self gettagangles("tag_flash")) * 50;
  GscBinSkip4(0x35);
}

function internal_aim_occlusion_override() {
  self.suppress_uselastenemysightpos = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;

  for(;;) {
    self.lastenemysightpos = self.aim_target.origin;
    waitframe();
  }
}

function internal_aim_at_laser_tracker() {
  for(;;) {
    waittillframeend();
    var0 = self gettagorigin(self.aim_laser.tag);
    self.aim_laser dontinterpolate();
    self.aim_laser.origin = var0;
    self.aim_laser.angles = vectortoangles(self.aim_target.origin - var0);
    waitframe();
  }
}

function is_aiming() {
  return isDefined(self.aim_target);
}

function aim_at_laser_on(var0, var1) {
  self endon("laser_off");
  self endon("death");

  if(var0 != 0) {
    if(!isDefined(var1)) {
      var1 = "tag_laser";
    }

    self.aim_laser = spawn("script_model", self gettagorigin(var1));
    self.aim_laser setModel("tag_laser");
    self.aim_laser setmoverlaserweapon(self.weapon);
    self.aim_laser.tag = var1;

    if(var0 == 1) {
      self.aim_laser laseron();
    } else {
      self.aim_laser laserforceon();
    }

    self.aim_laser.laser_state = var0;
    internal_aim_at_laser_tracker();
    return;
  }
}

function aim_at_laser_off() {
  self notify("laser_off");

  if(isDefined(self.aim_laser)) {
    if(self.aim_laser.laser_state == 1) {
      self.aim_laser laseroff();
    } else {
      self.aim_laser laserforceoff();
    }

    self.aim_laser delete();
    self.aim_laser = undefined;
    return;
  }
}

function move_aim_to(var0, var1, var2, var3) {
  self endon("death");
  self endon("stop_aiming");

  if(!isDefined(var2)) {
    var2 = 0.05;
  }

  if(!isDefined(var3)) {
    var3 = 0.05;
  }

  self.aim_target moveTo(var0, var1, var2, var3);
  wait var1;
}

function link_aim_to(var0, var1, var2) {
  self endon("stop_aiming");
  self endon("death");

  if(!isDefined(var1)) {
    var1 = "tag_origin";
  }

  if(isDefined(var2)) {
    self.aim_target linkTo(var0, var1, var2, (0, 0, 0));
    return;
  }

  self.aim_target linkTo(var0, var1);
}

function move_aim_to_enemy(var0, var1, var2, var3, var4, var5) {
  self endon("stop_aiming");
  self endon("death");
  var0 endon("death");

  if(!isDefined(var1)) {
    var1 = "tag_origin";
  }

  if(!isDefined(var2)) {
    var2 = 3;
  }

  if(!isDefined(var3)) {
    var3 = 50;
  }

  if(!isDefined(var4)) {
    var4 = 1;
  }

  var6 = var0 gettagorigin(var1);
  var7 = var3;
  var8 = var0.origin;
  var9 = var3 / var2;
  var10 = distance(self.aim_target.origin, var6) / var2;

  while(distancesquared(self.aim_target.origin, var0 gettagorigin(var1)) > 5) {
    var11 = 0.05;

    if(randomfloat(100) > 50) {
      var12 = var0 localtoworldcoords((0, 0, var7));
    } else {
      var12 = var0 localtoworldcoords((0, 0, var7 * -1));
    }

    var13 = var12 - var0.origin + var0 gettagorigin(var1);
    var14 = self.aim_target.origin;
    var15 = length(var0.origin - var8) / var11;
    var16 = var15 + var10;
    var17 = vectorNormalize(var13 - var14);
    var18 = var17 * var16 * var11;
    var7 -= var9 * var11;
    var7 = clamp(var7, 0, var3);
    var8 = var0.origin;
    move_aim_to(var14 + var18, var11, 0.001, 0.001);
  }

  if(var4) {
    self.aim_target.origin += vectorNormalize(self gettagorigin("tag_flash") - self.aim_target.origin) * 20;
    link_aim_to(var0, var1);
    return;
  }
}

function stop_aiming() {
  self notify("stop_aiming");
  aim_at_laser_off();

  if(isDefined(self.aim_target)) {
    self clearentitytarget();
    self.aim_target delete();
    self.aim_target = undefined;
  }

  self.suppress_uselastenemysightpos = undefined;
  self.dontgiveuponsuppression = undefined;
  self.forcesuppressai = undefined;
  self.lastenemysightpos = undefined;
}

function move_aim_along_spline(var0, var1) {
  self endon("stop_aiming");
  self endon("death");
  var2 = 0;

  for(var3 = var0; isDefined(var3.target); var3 = var3.next) {
    var3.next = scripts\engine\utility::getStruct(var3.target, "targetname");
    var3.dist_to_next = distance(var3.next.origin, var3.origin);
    var2 += var3.dist_to_next;
  }

  for(var3 = var0; isDefined(var3.target); var3 = var3.next) {
    var4 = var3.dist_to_next / var2 * var1;
    move_aim_to(var3.next.origin, var4);
  }
}

function aim_search_around(var0, var1, var2, var3) {
  self endon("stop_aiming");
  self endon("stop_searching");
  self endon("death");

  if(!isDefined(var0)) {
    var0 = -15;
  } else {
    var0 *= -1;
    var0 = clamp(var0, -30, 30);
  }

  if(!isDefined(var1)) {
    var1 = 15;
  } else {
    var1 *= -1;
    var1 = clamp(var1, -30, 30);
  }

  if(!isDefined(var2)) {
    var2 = 45;
  } else {
    var2 = clamp(var2, -90, 90);
  }

  if(!isDefined(var3)) {
    var3 = -45;
    goto LOC_00000097;
  }

  var3 = clamp(var3, -90, 90);

  for(;;) {
    if(randomfloat(100) > 50) {
      var4 = var1;
    } else {
      var4 = var0;
    }

    if(randomfloat(100) > 50) {
      var5 = var3;
    } else {
      var5 = var2;
    }

    var6 = 0.05;
    var7 = 0;
    var8 = self.aim_target.origin;

    while(var7 < 4) {
      var9 = self gettagorigin("tag_flash")[2];

      if(length(self.velocity) > 0) {
        var10 = vectortoangles(self.velocity);
      } else {
        var10 = self.angles;
      }

      var11 = var10 + (var4, var5, 0);
      var12 = anglesToForward(var11) * 75;
      var13 = (self.origin[0], self.origin[1], var9);
      var8 = var13 + var12;
      var14 = var8 - self.aim_target.origin;
      var15 = length(var14);
      var16 = vectorNormalize(var14);
      var17 = var15 / (4 - var7);
      var18 = var16 * var17 + self.velocity;
      move_aim_to(self.aim_target.origin + var18 * var6, var6, 1e-05, 1e-05);
      var7 += var6;
    }

    self.aim_target.origin = var8;
  }
}

function stop_aim_search_around() {
  self notify("stop_searching");
}

function userskip_wait() {
  var0 = "userskipped";
  var1 = "stop_userskip";
  var2 = [var0, var1];

  foreach(var4 in var2) {
    if(!scripts\engine\utility::flag_exist(var4)) {
      scripts\engine\utility::flag_init(var4);
      continue;
    }

    if(scripts\engine\utility::flag(var4)) {
      scripts\engine\utility::flag_clear(var4);
    }
  }

  setomnvar("ui_is_bink_skippable", 1);
  thread userskip_input();

  while(!scripts\engine\utility::flag(var1) && !scripts\engine\utility::flag(var0)) {
    waitframe();
  }

  setomnvar("ui_is_bink_skippable", 0);
  level notify("stop_userskip_input_thread");
  return scripts\engine\utility::flag(var0);
}

function userskip_input() {
  level endon("stop_userskip_input_thread");

  for(;;) {
    level.player waittill("luinotifyserver", var0, var1);

    if(var0 == "skip_bink_input") {
      scripts\engine\utility::flag_set("userskipped");
      break;
    }
  }
}

function userskip_stop() {
  scripts\engine\utility::flag_set("stop_userskip");
}

function get_adjusted_difficulty() {
  return scripts\sp\gameskill::auto_adjust_difficult_get();
}

function civilianfailwrapper(var0, var1, var2, var3) {
  self notify("stop_civilian_fail_wrapper");
  self endon("stop_civilian_fail_wrapper");
  level endon("stop_all_civilian_fail_wrappers");

  if(!isDefined(var0)) {
    var0 = [9, 30];
  }

  if(!isDefined(var1)) {
    var1 = 20;
  }

  if(isDefined(var2)) {
    var2 *= var2;
  }

  if(!isDefined(var3)) {
    var3 = 0;
  }

  var4 = undefined;
  var5 = ["MOD_IMPACT", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_FIRE"];

  for(;;) {
    self waittill("damage", var6, var7, var8, var9, var10, var11, var12, var13, var14, var15, var16, var17, var18, var19);

    if(!isDefined(var7) || !isDefined(var6)) {
      continue;
    } else if(!isPlayer(var7)) {
      continue;
    } else if(var6 < var1) {
      continue;
    } else if(isDefined(var10) && istrue(var3) && scripts\engine\utility::array_contains(var5, var10)) {
      continue;
    } else if(isDefined(var15) && var15.basename == "flash") {
      continue;
    } else if(isDefined(var2)) {
      var4 = distancesquared(level.player.origin, self.origin);

      if(var4 > var2) {
        continue;
      }
    }

    break;
  }

  level thread scripts\sp\hud_util::fade_out(0);
  scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::array_randomize(var0)[0]);
  missionfailedwrapper();
}

function get_mount_activation_mode() {
  if(self usinggamepad()) {
    var0 = self getlocalplayerprofiledata("mountButtonConfig");
  } else {
    var0 = self getlocalplayerprofiledata("mountButtonConfigKBM");
  }

  switch (var0) {
    case 1:
      return "disabled";
    case 2:
      return "double_ads";
    case 3:
      return "ads_melee";
    case 4:
      return "ads_sprint";
    case 5:
      return "offhand";
    case 6:
      return "offhand_hold";
    case 7:
      return "ads";
    case 8:
      return "mount_binding";
    case 9:
      return "mount_binding_hold";
    case 10:
      return "ads_activate";
  }
}

function notetrack_mission_failed_vo_enable() {
  level.notetrackmissionfailedvo = 1;
}

function notetrack_mission_failed_vo_disable() {
  level.notetrackmissionfailedvo = 0;
}

function notetrack_vo_enable() {
  level.notetrackvo = 1;
}

function notetrack_vo_disable() {
  level.notetrackvo = 0;
}

function door_remove_open_prompts() {
  thread scripts\sp\door::remove_open_prompts();
}

function door_ai_allowed(var0) {
  self.lockedforai = !var0;

  if(var0) {
    thread scripts\sp\door::clear_navobstacle();
    return;
  }

  thread scripts\sp\door::create_navobstacle();
}

function door_force_open_fully(var0, var1) {
  scripts\game\sp\door::remove_door_snake_cam_ability();
  scripts\sp\door::remove_open_ability();
  scripts\sp\door::door_open_completely(var0, var1);
}

function nvidiaansel_scriptdisable(var0) {
  if(computedropbagpositions()) {
    setsaveddvar("OPRLTQLTT", var0);
    return;
  }
}

function nvidiaansel_allowduringcinematic(var0) {
  if(computedropbagpositions()) {
    setsaveddvar("NLMKNQLSKL", var0);
    return;
  }
}

function nvidiaansel_overridecollisionradius(var0) {
  if(computedropbagpositions()) {
    setsaveddvar("NPTSOTOQSQ", var0);
    return;
  }
}

function is_trials_level() {
  if(!isDefined(level.istrialslevel)) {
    level.istrialslevel = scripts\engine\utility::string_starts_with(level.script, "trials_");
  }

  return level.istrialslevel;
}