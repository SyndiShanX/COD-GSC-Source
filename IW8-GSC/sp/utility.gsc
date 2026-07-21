/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\utility.gsc
***********************************************/

delete_live_grenades() {
  var_0 = getEntArray("grenade", "classname");

  foreach(var_2 in var_0) {
    if(!isDefined(var_2.targetname) && var_2.model != "offhand_wm_molotov_sp")
      var_2 delete();
  }

  if(scripts\sp\equipment\offhands::offhandisprecached("molotov"))
    thread scripts\sp\equipment\molotov::delete_all_molotovs();

  if(level.player isthrowinggrenade())
    level.player childthread delete_grenade_when_thrown();
}

delete_grenade_when_thrown() {
  level.player waittill("grenade_fire", var_0, var_1);

  if(isDefined(var_0))
    var_0 delete();
}

assign_animtree_based_on_subclass() {
  var_0 = tolower(self.subclass);

  switch (var_0) {
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

assign_animtree_based_on_unittype() {
  var_0 = tolower(self.unittype);

  switch (var_0) {
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

assign_c6_animtree() {
  self useanimtree(#animtree);
}

#using_animtree("c8");

assign_c8_animtree() {
  self useanimtree(#animtree);
}

#using_animtree("c12");

assign_c12_animtree() {
  self useanimtree(#animtree);
}

#using_animtree("generic_human");

assign_human_animtree() {
  self useanimtree(#animtree);
}

enable_procedural_bones() {
  self setanim(%proc_node, 1, 0);
}

disable_procedural_bones() {
  self setanim(%proc_node, 0, 0);
}

change_player_health_packets(var_0) {
  self.player_health_packets = self.player_health_packets + var_0;
  self notify("update_health_packets");

  if(self.player_health_packets >= 3)
    self.player_health_packets = 3;
}

player_in_zerog() {
  if(isPlayer(self))
    var_0 = self;
  else
    var_0 = level.player;

  return isDefined(var_0.space) && var_0.space.floating;
}

do_damage(var_0, var_1, var_2, var_3, var_4, var_5, var_6) {
  if(self == level.player)
    var_0 = scripts\sp\player::dodamagefilter(var_0, var_4);

  return self dodamage(var_0, var_1, var_2, var_3, var_4, var_5, var_6);
}

set_player_attacker_accuracy(var_0) {
  var_1 = scripts\engine\sp\utility::get_player_from_self();
  var_1.scriptedattackeraccuracy = var_0;
  var_1 scripts\sp\gameskill::update_player_attacker_accuracy();
}

player_has_unlocked_stored_equipment_slots() {
  if(!isDefined(level.player.storedslotsunlocked) || !level.player.storedslotsunlocked)
    return 0;
  else
    return 1;
}

player_seek_enable() {
  self endon("death");
  self endon("stop_player_seek");
  var_0 = 1200;

  if(has_shotgun())
    var_0 = 250;

  var_1 = distance(self.origin, level.player.origin);

  for(;;) {
    wait 2;
    self.goalradius = var_1;
    var_2 = level.player;
    self setgoalentity(var_2);
    var_1 = var_1 - 175;

    if(var_1 < var_0) {
      var_1 = var_0;
      return;
    }
  }
}

player_seek_disable() {
  self notify("stop_player_seek");
}

riotshield_lock_orientation(var_0) {
  self orientmode("face angle", var_0);
  self.lockorientation = 1;
}

riotshield_unlock_orientation() {
  self.lockorientation = 0;
}

cqb_walk(var_0) {
  if(var_0 == "on")
    scripts\common\utility::enable_cqbwalk();
  else
    scripts\common\utility::disable_cqbwalk();
}

enable_flashlight(var_0, var_1) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = 1;

  if(var_0)
    scripts\sp\nvg\nvg_ai::flashlight_on(var_1);
  else
    scripts\sp\nvg\nvg_ai::flashlight_off(var_1);
}

throwgrenadeatplayerasap() {
  scripts\anim\combat_utility.gsc::throwgrenadeatplayerasap_combat_utility();
}

use_turret(var_0, var_1) {
  scripts\asm\asm_bb::bb_requestturret(var_0);
  scripts\asm\asm_bb::bb_requestturretpose(var_1);
  var_3 = var_0 gettagorigin("tag_gunner");
  var_4 = var_0 gettagangles("tag_gunner");

  if(self islinked())
    self unlink();

  self forceteleport(var_3, var_4);
  self linktoblendtotag(var_0, "tag_gunner", 0);
}

waterfx(var_0, var_1) {
  self endon("death");
  var_2 = 0;

  if(isDefined(var_1))
    var_2 = 1;

  if(isDefined(var_0)) {
    scripts\engine\utility::flag_assert(var_0);
    level endon(var_0);
  }

  for(;;) {
    wait(randomfloatrange(0.15, 0.3));
    var_3 = self.origin + (0, 0, 150);
    var_4 = self.origin - (0, 0, 150);
    var_5 = scripts\engine\trace::ray_trace_detail(var_3, var_4, undefined, scripts\engine\trace::create_default_contents(1));

    if(var_5["surfacetype"] != "water") {
      continue;
    }
    var_6 = "water_movement";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5)
        var_6 = "water_stop";
    } else if(isDefined(level._effect["water_" + self.a.movement]))
      var_6 = "water_" + self.a.movement;

    var_7 = scripts\engine\utility::getfx(var_6);
    var_3 = var_5["position"];
    var_8 = (0, self.angles[1], 0);
    var_9 = anglesToForward(var_8);
    var_10 = anglestoup(var_8);
    playFX(var_7, var_3, var_10, var_9);

    if(var_6 != "water_stop" && var_2)
      thread scripts\engine\utility::play_sound_in_space(var_1, var_3);
  }
}

player_is_near_live_offhand() {
  var_0 = getEntArray("grenade", "classname");

  foreach(var_2 in var_0) {
    if(!offhand_is_dangerous(var_2)) {
      continue;
    }
    for(var_3 = 0; var_3 < level.players.size; var_3++) {
      var_4 = level.players[var_3];

      if(distancesquared(var_2.origin, var_4.origin) < 75625) {
        scripts\sp\autosave::autosaveprint("live grenade too close to player", 0);
        return 1;
      }
    }
  }

  return 0;
}

offhand_is_dangerous(var_0) {
  if(!isDefined(var_0.targetname))
    return 1;

  if(var_0.targetname == "offhand_claymore")
    return 0;

  if(var_0.targetname == "offhand_c4_no_detonator")
    return 0;

  if(var_0.targetname == "offhand_noisemaker")
    return 0;

  if(var_0.targetname == "offhand_throwingknife")
    return 0;

  if(var_0.targetname == "offhand_car_grenade")
    return 0;

  if(var_0.targetname == "offhand_ied")
    return 0;

  return 1;
}

has_shotgun() {
  self endon("death");

  if(!isDefined(self.weapon))
    return 0;

  if(weaponclass(self.weapon) == "spread")
    return 1;

  return 0;
}

isprimaryweapon(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return 0;

  if(isstring(var_0) && var_0 == "none")
    return 0;

  if(weaponinventorytype(var_0) != "primary")
    return 0;

  switch (weaponclass(var_0)) {
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

enable_heat_behavior(var_0) {
  self.heat = 1;
  self.disablepistol = 1;
  self.balwayscoverexposed = 1;

  if(!isDefined(var_0) || !var_0) {
    self.dontshootwhilemoving = 1;
    self.maxfaceenemydist = 64;
    self.pathenemylookahead = 2048;
    scripts\engine\sp\utility::disable_surprise();
  }

  self.specialreloadanimfunc = scripts\anim\animset.gsc::heat_reload_anim;
  self.custommoveanimset["run"] = scripts\anim\utility.gsc::lookupanimarray("heat_run");
}

disable_heat_behavior() {
  self.heat = undefined;
  self.disablepistol = 0;
  self.dontshootwhilemoving = 0;
  self.balwayscoverexposed = undefined;
  self.maxfaceenemydist = 512;
  self.specialreloadanimfunc = undefined;
  self.custommoveanimset = undefined;
}

interactivekeypairs() {
  var_0 = [];
  var_0[0] = ["interactive_birds", "targetname"];
  var_0[1] = ["interactive_vulture", "targetname"];
  var_0[2] = ["interactive_fish", "script_noteworthy"];
  return var_0;
}

mask_interactives_in_volumes(var_0) {
  var_1 = interactivekeypairs();
  var_2 = [];

  foreach(var_4 in var_1) {
    var_5 = getEntArray(var_4[0], var_4[1]);
    var_2 = scripts\engine\utility::array_combine(var_2, var_5);
  }

  foreach(var_8 in var_2) {
    if(!isDefined(level._interactive[var_8.interactive_type].savetostructfn)) {
      continue;
    }
    foreach(var_11 in var_0) {
      if(!var_11 istouching(var_8)) {
        continue;
      }
      if(!isDefined(var_11.interactives))
        var_11.interactives = [];

      var_11.interactives[var_11.interactives.size] = var_8[[level._interactive[var_8.interactive_type].savetostructfn]]();
    }
  }
}

activate_interactives_in_volume() {
  if(!isDefined(self.interactives)) {
    return;
  }
  foreach(var_1 in self.interactives)
  var_1[[level._interactive[var_1.interactive_type].loadfromstructfn]]();

  self.interactives = undefined;
}

delete_interactives_in_volumes(var_0) {
  mask_interactives_in_volumes(var_0);

  foreach(var_2 in var_0)
  var_2.interactives = undefined;
}

allow_hands(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("hands", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      self sethandsoccupied(0);
    else
      self sethandsoccupied(1);
  }
}

is_hands_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("hands");
}

allow_weapon_scanning(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("weaponScanning", var_0, var_1);

  if(isDefined(var_2) && var_2)
    scripts\engine\utility::flag_clear("weapon_scanning_off");
  else if(isDefined(var_2) && !var_2)
    scripts\engine\utility::flag_set("weapon_scanning_off");
}

is_weapon_scanning_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("weaponScanning");
}

allow_antigrav_float(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("antigravFloat", var_0, var_1);

  if(isDefined(var_2)) {
    if(var_2)
      level.player scripts\engine\utility::ent_flag_clear("disable_antigrav_float");
    else {
      if(!level.player scripts\engine\utility::ent_flag_exist("disable_antigrav_float"))
        level.player scripts\engine\utility::ent_flag_init("disable_antigrav_float");

      level.player scripts\engine\utility::ent_flag_set("disable_antigrav_float");
    }
  }
}

is_antigrav_float_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("antigravFloat");
}

allow_cg_drawcrosshair(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("cg_drawcrosshair", var_0, var_1);

  if(isDefined(var_2))
    setsaveddvar("LOPKSRNTTS", var_2);
}

is_cg_drawcrosshair_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("cg_drawcrosshair");
}

allow_weapon_first_raise_anims(var_0, var_1) {
  var_2 = scripts\common\input_allow::allow_input_internal("firstRaiseAnims", var_0, var_1);

  if(isDefined(var_2) && var_2)
    setsaveddvar("MRKKPQPTQR", 0);
  else if(isDefined(var_2) && !var_2)
    setsaveddvar("MRKKPQPTQR", 1);
}

is_weapon_first_raise_anims_allowed() {
  return scripts\common\input_allow::is_input_allowed_internal("firstRaiseAnims");
}

is_in_antigrav_grenade() {
  if(self == level.player) {
    if(!isDefined(self.inantigrav) || self.inantigrav == 0)
      return 0;
    else
      return 1;
  } else if(!isDefined(self.antigravgrenstate))
    return 0;
  else
    return 1;
}

hud_intel_message(var_0, var_1, var_2, var_3) {
  var_4 = 20;

  if(!isDefined(var_2))
    var_2 = "default";

  switch (var_2) {
    case "intel_acepilot0":
      var_4 = 0;
      break;
    case "intel_acepilot1":
      var_4 = 1;
      break;
    case "intel_acepilot2":
      var_4 = 2;
      break;
    case "intel_acepilot3":
      var_4 = 3;
      break;
    case "intel_acepilot4":
      var_4 = 4;
      break;
    case "intel_acepilot5":
      var_4 = 5;
      break;
    case "intel_acepilot6":
      var_4 = 6;
      break;
    case "intel_acepilot7":
      var_4 = 7;
      break;
    case "intel_acepilot8":
      var_4 = 8;
      break;
    case "intel_acepilot9":
      var_4 = 9;
      break;
    case "intel_acepilot10":
      var_4 = 10;
      break;
    case "intel_acepilot11":
      var_4 = 11;
      break;
    case "intel_acepilot12":
      var_4 = 12;
      break;
    case "intel_acepilot13":
      var_4 = 13;
      break;
    case "intel_acepilot14":
      var_4 = 14;
      break;
    case "intel_acepilot15":
      var_4 = 15;
      break;
    case "intel_acepilot16":
      var_4 = 16;
      break;
    case "intel_acepilot17":
      var_4 = 17;
      break;
    case "intel_acepilot18":
      var_4 = 18;
      break;
    case "intel_acepilot19":
      var_4 = 19;
      break;
    case "default":
      var_4 = 20;
      break;
    case "capops_intel":
      var_4 = 20;
      break;
    case "tally_intel":
      var_4 = 21;
      break;
    case "jackal_intel":
      var_4 = 22;
      break;
    case "sdf_intel_1":
      var_4 = 23;
      break;
    case "news_intel":
      var_4 = 24;
      break;
    case "eweapon_intel":
      var_4 = 25;
      break;
    case "scan_intel":
      var_4 = 26;
      break;
    case "intel_captain0":
      var_4 = 27;
      break;
    case "intel_captain1":
      var_4 = 28;
      break;
    case "intel_captain2":
      var_4 = 29;
      break;
    case "intel_captain3":
      var_4 = 30;
      break;
    case "intel_captain4":
      var_4 = 31;
      break;
    case "intel_captain5":
      var_4 = 32;
      break;
    case "intel_captain6":
      var_4 = 33;
      break;
    case "intel_captain7":
      var_4 = 34;
      break;
    case "intel_captain8":
      var_4 = 35;
      break;
    case "intel_captain9":
      var_4 = 36;
      break;
    case "intel_scrap":
      var_4 = 37;
      break;
    case "intel_reticle":
      var_4 = 38;
      break;
    case "intel_attachment":
      var_4 = 39;
      break;
  }

  setomnvar("ui_sp_intel_messaging_image_index", var_4);
  setomnvar("ui_sp_intel_messaging_text", var_1);
  setomnvar("ui_sp_intel_messaging_header", var_0);
  setomnvar("ui_sp_intel_messaging", 1);
  level.player thread scripts\engine\sp\utility::_intel_waypoint_button_listener();
  var_5 = var_2 == "tally_intel";

  if(var_5)
    level.player thread scripts\engine\sp\utility::_intel_dismiss_button_listener();

  if(isDefined(var_3))
    setomnvar("ui_sp_intel_messaging_ent", 1);
  else
    setomnvar("ui_sp_intel_messaging_ent", 0);

  var_6 = "close";
  var_7 = gettime() / 1000;
  var_8 = 5.0;

  while(var_5 && !isDefined(level.player.intel_dismiss_request) || !var_5 && gettime() / 1000 - var_7 < var_8) {
    if(isDefined(level.player.intel_waypoint_request)) {
      var_6 = "waypoint";
      break;
    }

    wait 0.05;
  }

  setomnvar("ui_sp_intel_messaging", 0);
  setomnvar("ui_sp_intel_messaging_ent", 0);
  level.player.intel_dismiss_request = undefined;

  if(var_6 == "waypoint" && isDefined(var_3)) {
    var_9 = scripts\engine\utility::spawn_script_origin(var_3, (0, 0, 0));
    var_9.icon = newhudelem();
    var_9.icon setshader("intel_hint_icon", 32, 32);
    var_9.icon.color = (0, 1, 0.976);
    var_9.icon.alpha = 1.0;
    var_9.icon setwaypoint(1, 1, 0);
    var_9.icon settargetEnt(var_9);
    var_10 = distance2dsquared(level.player.origin, var_9.origin);

    for(;;) {
      if(distance2dsquared(level.player.origin, var_9.origin) < squared(75.0) || distance2dsquared(level.player.origin, var_9.origin) > var_10 * 2.5) {
        break;
      }

      wait 0.05;
    }

    var_9.icon destroy();
    var_9 delete();
    level.player.intel_waypoint_request = undefined;
  } else {
    level.player notify("dismiss_skipped");
    level.player.intel_dismiss_request = undefined;
    return;
  }
}

is_demo() {
  if(getdvarint("scr_demo", 0))
    return 1;

  return 0;
}

is_lastlevel() {
  if(level.script == "lab")
    return 1;

  return 0;
}

hudoutline_ar_callout(var_0, var_1, var_2) {
  if(isDefined(level.player.ar_callout_ent))
    hudoutline_ar_disable();

  level.player endon("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  wait 0.05;
  setsaveddvar("NMROQRRONQ", 1);
  level.player.ar_callout_ent = scripts\engine\utility::spawn_tag_origin();
  setomnvar("ui_inworld_ar_ent", level.player.ar_callout_ent);

  if(!isDefined(var_0))
    var_0 = "ar_callouts_default";

  setomnvar("ui_ar_object_text", var_0);
  wait 0.05;

  if(isDefined(var_1) && var_1)
    scripts\engine\sp\utility::hudoutline_enable_new("outlinefill_depth_orange", "default");
  else
    scripts\engine\sp\utility::hudoutline_enable_new("outlinefill_nodepth_orange", "default");

  setomnvar("ui_show_ar_elem", 1);
  thread _ar_callout_tracker(var_2);
}

_ar_callout_tracker(var_0) {
  level.player endon("stop_ar_callout");
  self endon("death");

  for(;;) {
    if(isDefined(var_0))
      var_1 = self.origin + var_0;
    else
      var_1 = self.origin + (0, 0, 30);

    level.player.ar_callout_ent.origin = var_1;
    wait 0.05;
  }
}

hudoutline_ar_disable() {
  scripts\engine\sp\utility::hudoutline_disable("default");
  setomnvar("ui_show_ar_elem", 0);
  wait 0.1;
  level.player notify("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  level.player.ar_callout_ent delete();
  level.player.ar_callout_ent = undefined;
}

in_specialist_mode() {
  if(getdvarint("NPSPRQNQRN"))
    return 1;
  else
    return 0;
}

in_yolo_mode() {
  if(getdvarint("LQMTORORON"))
    return 1;
  else
    return 0;
}

in_zero_gravity() {
  return level.player scripts\engine\utility::ent_flag_exist("zero_gravity") && level.player scripts\engine\utility::ent_flag("zero_gravity");
}

remove_equipment_immediately(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(var_0))
    var_0 = 1;

  if(!isDefined(var_1))
    var_1 = 1;

  if(!isDefined(var_2))
    var_2 = 1;

  if(!isDefined(var_3))
    var_3 = 1;

  if(!isDefined(var_4))
    var_4 = 1;

  if(!isDefined(var_5))
    var_5 = 0;
}

isactorwallrunning() {
  if(isDefined(self.wall_run_direction))
    return 1;

  return 0;
}

init_modern() {
  precachesuit("modern_sp");
  level.player setsuit("modern_sp");
}

setplayerlootenabled(var_0) {
  setDvar("scr_player_loot_enabled", var_0);
}

playerlootenabled() {
  return getdvarint("scr_player_loot_enabled");
}

personalcoldbreathstop() {
  self notify("stop personal effect");
}

personalcoldbreathspawner() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  for(;;) {
    self waittill("spawned", var_0);

    if(scripts\common\ai::spawn_failed(var_0)) {
      continue;
    }
    var_0 thread scripts\anim\utility.gsc::personalcoldbreath();
  }
}

missionfailedwrapper() {
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
    thread[[level.mission_fail_func]]();
    return;
  }

  thread scripts\sp\player_death::set_death_hint();
  missionfailed(in_yolo_mode());
}

giveachievement_wrapper(var_0, var_1) {
  if(is_demo()) {
    return;
  }
  if(!isDefined(var_1))
    var_1 = 0;

  if(!var_1 && is_lastlevel()) {
    return;
  }
  level.player giveachievement(var_0);
}

player_giveachievement_wrapper(var_0) {
  if(is_demo()) {
    return;
  }
  if(is_lastlevel()) {
    return;
  }
  self giveachievement(var_0);
}

play_skippable_cinematic(var_0, var_1, var_2) {
  setsaveddvar("MMRNLMPPLT", "1");
  setsaveddvar("RKMNLRNS", "1");
  cinematicingame(var_0);
  level.player scripts\sp\player::remove_damage_effects_instantly();
  remove_equipment_immediately();
  level.player scripts\common\utility::allow_weapon(0);
  level.player freezecontrols(1);
  level.player enableinvulnerability();
  level.player cleardamageindicators();
  level.player enableplayerbreathsystem(0);
  setomnvar("ui_hide_hud", 1);
  level.player allow_cg_drawcrosshair(0);
  setomnvar("ui_hide_weapon_info", 1);

  while(!iscinematicplaying())
    waitframe();

  thread cinematic_skip_input(var_1);

  if(isDefined(var_2)) {
    cinematic_waittill_skip_or_time(var_2);
    level.player scripts\common\utility::allow_weapon(1);
    level.player disableinvulnerability();
    level.player freezecontrols(0);
    level.player cleardamageindicators();
    level.player enableplayerbreathsystem(1);
    setomnvar("ui_hide_hud", 0);
    level.player allow_cg_drawcrosshair(1);
    setomnvar("ui_hide_weapon_info", 0);
    level notify("skippable_cinematic_done");

    while(iscinematicplaying())
      waitframe();

    setsaveddvar("MMRNLMPPLT", "0");
    setsaveddvar("RKMNLRNS", "0");
    setomnvar("ui_is_bink_skippable", 0);
    stopcinematicingame();
  } else {
    while(iscinematicplaying())
      waitframe();

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
    level.player allow_cg_drawcrosshair(1);
    setomnvar("ui_hide_weapon_info", 0);
    level notify("skippable_cinematic_done");
  }
}

cinematic_skip_input(var_0) {
  level endon("skippable_cinematic_done");

  if(isDefined(var_0))
    self waittill(var_0);

  setomnvar("ui_is_bink_skippable", 1);

  for(;;) {
    level.player waittill("luinotifyserver", var_1, var_2);

    if(var_1 == "skip_bink_input") {
      level notify("cinematic_skipped");
      stopcinematicingame();
      break;
    }
  }
}

cinematic_waittill_skip_or_time(var_0) {
  level endon("cinematic_skipped");
  var_0 = var_0 * 1000;

  for(;;) {
    var_1 = cinematicgettimeinmsec();

    if(var_1 >= var_0) {
      return;
    }
    waitframe();
  }
}

isriotshield(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return 0;

  if(isstring(var_0) && var_0 == "none")
    return 0;

  return weapontype(var_0) == "riotshield";
}

isknifeonly(var_0) {
  var_1 = getweaponbasename(var_0);
  return issubstr(var_1, "knife");
}

isbulletweapon(var_0) {
  if(issameweapon(var_0) && nullweapon(var_0))
    return 0;

  if(isstring(var_0) && var_0 == "none")
    return 0;

  if(isriotshield(var_0) || isknifeonly(var_0))
    return 0;

  switch (weaponclass(var_0)) {
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

context_melee_enable(var_0) {
  if(!var_0)
    level.player thread scripts\sp\player\context_melee::disable_dynamic_takedowns();
  else
    level thread scripts\sp\player\context_melee::main();
}

context_melee_allow(var_0) {
  self.context_melee_allowed = var_0;
}

context_melee_allow_blocked_hint(var_0) {
  level.player.context_melee_blocked_hint_allowed = var_0;
}

context_melee_allow_directions(var_0) {
  self.context_melee_allow_directions = var_0;
}

context_melee_set_silent_kill(var_0) {
  if(var_0)
    setDvar("context_melee_silent", 1);
  else
    setDvar("context_melee_silent", 0);
}

context_melee_set_custom_hint(var_0) {
  level.player.context_melee_hint_custom = var_0;
}

context_melee_clear_custom_hint() {
  level.player.context_melee_hint_custom = undefined;
}

context_melee_set_blocked_custom_hint(var_0) {
  level.player.context_melee_hint_blocked_custom = var_0;
}

context_melee_clear_blocked_custom_hint() {
  level.player.context_melee_hint_blocked_custom = undefined;
}

context_melee_set_hint_directions(var_0) {
  level.player.context_melee_allow_directions = var_0;
}

context_melee_override_anim(var_0, var_1, var_2, var_3, var_4) {
  if(!isDefined(var_1))
    var_1 = "all";

  if(!isDefined(var_0) && isDefined(self.context_melee_anim_name) && isDefined(self.context_melee_anim_name[var_1])) {
    self.context_melee_anim_name[var_1] = undefined;
    return;
  }

  if(isDefined(level.scr_anim["context_melee_player_rig"][var_0]) && isDefined(level.scr_anim["generic"][var_0])) {
    if(!isDefined(self.context_melee_anim_name))
      self.context_melee_anim_name = [];

    self.context_melee_anim_name[var_1] = var_0;
    var_5 = ["cm_death", "cm_ragdoll", "cm_fx", "cm_sfx", "cm_sfx_player"];
    var_6[0] = scripts\sp\player\context_melee::context_melee_death;
    var_6[1] = scripts\sp\player\context_melee::context_melee_ragdoll;
    var_6[2] = scripts\sp\player\context_melee::context_melee_fx;
    var_6[3] = scripts\sp\player\context_melee::context_melee_sfx;
    var_6[4] = scripts\sp\player\context_melee::context_melee_sfx;

    foreach(var_10, var_8 in var_5) {
      if(isDefined(level.scr_notetrack["generic"]) && isDefined(level.scr_notetrack["generic"][var_0]) && isDefined(level.scr_notetrack["generic"][var_0][var_8]) && level.scr_notetrack["generic"][var_0][var_8].size > 0) {
        for(var_9 = 0; var_9 < level.scr_notetrack["generic"][var_0][var_8].size; var_9++) {
          if(isDefined(level.scr_notetrack["generic"][var_0][var_8][var_9]["function"])) {
            if(level.scr_notetrack["generic"][var_0][var_8][var_9]["function"] == var_6[var_10])
              level.scr_notetrack["generic"][var_0][var_8][var_9]["function"] = undefined;
          }
        }
      }
    }

    scripts\common\anim::addnotetrack_customfunction("generic", "cm_death", scripts\sp\player\context_melee::context_melee_death, var_0);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_ragdoll", scripts\sp\player\context_melee::context_melee_ragdoll, var_0);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_fx", scripts\sp\player\context_melee::context_melee_fx, var_0);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_sfx", scripts\sp\player\context_melee::context_melee_sfx, var_0);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_sfx_player", scripts\sp\player\context_melee::context_melee_sfx, var_0);
  }

  if(isDefined(var_2))
    context_melee_set_lastframe_bone(var_2);
  else
    context_melee_set_lastframe_bone(level.context_melee_player_link_bone);

  if(isDefined(var_3))
    context_melee_set_lastframe_type(var_3);
  else
    context_melee_set_lastframe_type("player_capsule");

  if(istrue(var_4))
    level.context_melee_do_launch = 1;
}

context_melee_set_arms(var_0) {
  level.scr_model["context_melee_player_rig"] = var_0;
  level.player.melee_arms delete();
  level.player.melee_arms = scripts\engine\sp\utility::spawn_anim_model("context_melee_player_rig", level.player.origin, level.player.angles);
  level.player.melee_arms notsolid();
  level.player.melee_arms hide();
}

context_melee_set_weapon(var_0) {
  level.player.context_melee_knife = var_0;
}

context_melee_set_lastframe_bone(var_0) {
  level.context_melee_lastframe_bone = var_0;
}

context_melee_set_lastframe_type(var_0) {
  level.context_melee_lastframe_type = var_0;
}

context_melee_sight_disabled(var_0) {
  level.context_melee_sight_disabled = var_0;
}

context_melee_waittill_player_finished() {
  level.player endon("death");
  level.player waittill("context_melee_anim_ended");
  waittillframeend;

  while(istrue(level.player.context_melee_launching))
    waitframe();
}

enable_stayahead(var_0) {
  setdvarifuninitialized("scr_debug_stayahead", 0);
  disable_stayahead(0, 0);
  waittillframeend;
  thread scripts\sp\stayahead::stayahead_thread(var_0);
}

disable_stayahead(var_0, var_1) {
  if(isDefined(self.stayahead) && isDefined(self.stayahead.using_goto_node)) {
    scripts\sp\stayahead::print3d_debug(self.origin + (0, 0, 8), "Stayahead disabled, going back to go_to_node()", (0, 1, 0), 1, 0.3, 500, 1);
    thread scripts\sp\spawner::go_to_node(scripts\sp\stayahead::get_best_goto_node(self.stayahead.goto_patharray, 2));
  }

  if(isDefined(self.stayahead) && isDefined(self.stayahead.bg_2d))
    self.stayahead.bg_2d destroy();

  if(isDefined(self.stayahead) && isDefined(self.stayahead.team)) {
    foreach(var_3 in self.stayahead.team)
    var_3 scripts\engine\sp\utility::disable_dynamic_run_speed(var_0);
  }

  if(!isDefined(var_1) || istrue(var_1))
    self.stayahead = undefined;

  if(!isDefined(var_0))
    var_0 = 165;

  self notify("stop_stayahead");

  if(istrue(var_0))
    scripts\engine\utility::set_movement_speed(var_0);
}

set_stayahead_values(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stayahead))
    self.stayahead = spawnStruct();

  var_4["speed"] = var_1;
  var_4["distance"] = var_2;

  if(isDefined(var_3))
    var_4["variance"] = var_3;

  switch (var_0) {
    case 1:
      self.stayahead.p1 = var_4;
      break;
    case 2:
      self.stayahead.p2 = var_4;
      break;
    case 3:
      self.stayahead.p3 = var_4;
      break;
    case 4:
      self.stayahead.p4 = var_4;
      break;
    case "wait":
      self.stayahead.pw = var_4;
      break;
    default:
  }
}

set_stayahead_wait_values(var_0, var_1, var_2) {
  set_stayahead_values("wait", 0, var_0, 0);
  self.stayahead.pw["buffer"] = var_1;

  if(istrue(var_2))
    self.stayahead.use_goto_wait = 1;
}

stayahead_disable_wait() {
  if(isDefined(self.stayahead)) {
    if(isDefined(self.stayahead.goalnode_pw)) {
      var_0 = scripts\engine\utility::ter_op(isDefined(self.stayahead.goalnode), self.stayahead.goalnode, self.goalnode);
      childthread scripts\sp\stayahead::stayahead_set_goalnode(var_0, 0);
    }

    if(isDefined(self.stayahead.pw))
      self.stayahead.pw = undefined;
  }
}

enable_stayahead_turbo(var_0) {
  if(!isDefined(self.stayahead)) {
    return;
  }
  if(isDefined(var_0)) {}

  self.stayahead.turbo = var_0;
}

set_stayahead_wait_nodes(var_0, var_1) {
  if(!isDefined(self.stayahead))
    self.stayahead = spawnStruct();

  if(isDefined(var_0))
    self.stayahead.wait_nodes = var_0;

  if(istrue(var_1))
    self.stayahead.use_goto_wait = 1;
}

set_stayahead_wait_func(var_0) {
  self.stayahead.wait_func = var_0;
}

stayahead_add_to_team(var_0, var_1, var_2, var_3) {
  if(!isDefined(self.stayahead.team))
    self.stayahead.team = [];

  var_4 = [];

  if(!isarray(var_0))
    var_4[0] = var_0;
  else
    var_4 = var_0;

  foreach(var_6 in var_4) {
    if(!isDefined(var_6.stayahead))
      var_6.stayahead = spawnStruct();

    var_6.stayahead.dynamic_frontdist = var_1;
    var_6.stayahead.dynamic_middist = var_2;
    var_6.stayahead.dynamic_backdist = var_3;
  }

  self.stayahead.team = scripts\engine\utility::array_combine(self.stayahead.team, var_4);
}

stayahead_pause(var_0) {
  if(scripts\engine\utility::ent_flag_exist("stayahead_pause")) {
    if(var_0)
      scripts\engine\utility::ent_flag_set("stayahead_pause");
    else
      scripts\engine\utility::ent_flag_clear("stayahead_pause");
  } else {}
}

stayahead_set_wait_node_radius(var_0) {
  if(!isDefined(self.stayahead))
    self.stayahead = spawnStruct();

  self.stayahead.wait_node_radius = var_0;
}

stayahead_lookat_enabled(var_0) {
  if(!isDefined(self.stayahead))
    self.stayahead = spawnStruct();

  if(istrue(var_0))
    self.stayahead.lookat_allowed = 1;
  else
    self.stayahead.lookat_allowed = undefined;
}

createweapondefaultsarray() {
  if(!isDefined(level._weapons))
    level._weapons = spawnStruct();

  if(!isDefined(level._weapons.tablelookups))
    level._weapons.tablelookups = 0;

  if(!isDefined(level._weapons.defaults)) {
    level._weapons.defaults = [];
    var_0 = tablelookupgetnumrows("sp/statstable.csv");
    level._weapons.tablelookups = level._weapons.tablelookups + 1;

    for(var_1 = 0; var_1 < var_0; var_1++) {
      var_2 = tablelookupbyrow("sp/statstable.csv", var_1, 1);
      level._weapons.tablelookups = level._weapons.tablelookups + 1;

      if(isDefined(var_2) && var_2.size > 0) {
        var_3 = tablelookupbyrow("sp/statstable.csv", var_1, 2);
        level._weapons.tablelookups = level._weapons.tablelookups + 1;

        if(var_3.size > 0)
          level._weapons.defaults[var_2] = strtok(var_3, " ");
      }
    }

    var_4 = [];
    var_5 = 0;

    for(var_6 = "empty"; var_6 != ""; var_5++) {
      var_6 = tablelookupbyrow("sp/attachmentmap.csv", 0, var_5);
      level._weapons.tablelookups = level._weapons.tablelookups + 1;
      var_4 = scripts\engine\utility::array_add(var_4, var_6);
    }

    var_7 = getarraykeys(level._weapons.defaults);

    foreach(var_2 in var_7) {
      for(var_1 = 0; var_1 < level._weapons.defaults[var_2].size; var_1++) {
        if(issubstr(level._weapons.defaults[var_2][var_1], "select")) {
          level._weapons.defaults[var_2] = scripts\engine\utility::array_remove(level._weapons.defaults[var_2], level._weapons.defaults[var_2][var_1]);
          var_1 = var_1 - 1;
          continue;
        }

        var_9 = scripts\engine\utility::array_find(var_4, level._weapons.defaults[var_2][var_1]);

        if(isDefined(var_9)) {
          var_10 = tablelookup("sp/attachmentmap.csv", 0, var_2, var_9);
          level._weapons.tablelookups = level._weapons.tablelookups + 1;

          if(var_10 != "") {
            switch (var_10) {
              case "mag_mike14":
                var_10 = "xmags_mike14";
                break;
            }

            level._weapons.defaults[var_2][var_1] = var_10;
          }
        }
      }
    }
  }
}

getweapondefaults(var_0) {
  if(issameweapon(var_0))
    var_0 = getweaponbasename(var_0);

  level createweapondefaultsarray();
  var_0 = get_weapon_redirect(var_0);
  var_1 = level._weapons.defaults[var_0];

  if(!isDefined(var_1))
    var_1 = [];

  return var_1;
}

removeconflictingattachments(var_0, var_1) {
  var_1 = removeconflictingdefaultattachment(var_0, var_1);
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "bar", "front_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "barlong", "slide_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "barcust", "guard_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "stock", "back_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "cal", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "drums", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "xmags", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "rack", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "mmags", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "xmagslrg", "xmags_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "mag_", "xmags_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "box_", "mag_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "rack", "ammo_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "thermal", "snprscope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "acog", "snprscope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "reflex", "snprscope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "holo", "snprscope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "hybrid", "snprscope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "vzscope", "snprscope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "minireddot", "snprscope");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "thermal", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "acog", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "reflex", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "holo", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "hybrid", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "vzscope", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "minireddot", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "scope", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "snprscope", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "irons", "ironsdefault_");
  var_1 = removeconflictingdefaultattachment(var_0, var_1, "grip", "gripcust_");
  return var_1;
}

removeconflictingdefaultattachment(var_0, var_1, var_2, var_3) {
  if(!isDefined(var_2)) {
    foreach(var_5 in var_0) {
      var_6 = strtok(var_5, "_")[0];

      foreach(var_8 in var_1) {
        if(var_6 == strtok(var_8, "_")[0]) {
          var_1 = scripts\engine\utility::array_remove(var_1, var_8);
          continue;
        }

        if(issubstr(var_5, "scope") && issubstr(var_8, "scope"))
          var_1 = scripts\engine\utility::array_remove(var_1, var_8);
      }
    }

    return var_1;
  }

  foreach(var_5 in var_0) {
    if(isstartstr(var_5, var_2)) {
      for(var_12 = 0; var_12 < var_1.size; var_12++) {
        if(isstartstr(var_1[var_12], var_3)) {
          var_1 = scripts\engine\utility::array_remove_index(var_1, var_12);
          return var_1;
        }
      }
    }
  }

  return var_1;
}

get_weapon_redirect(var_0) {
  switch (var_0) {
    case "iw8_ar_akilo47_goliath":
    case "iw8_ar_akilo47_brightmuzzle":
    case "iw8_ar_akilo47_melee":
    case "iw8_ar_akilo47_tfarah":
      var_0 = "iw8_ar_akilo47";
      break;
    case "iw8_sn_hdromeo_ballistics":
      var_0 = "iw8_sn_hdromeo";
      break;
    case "iw8_sn_hdromeo_ballistics_quickraise":
      var_0 = "iw8_sn_hdromeo";
      break;
    case "iw8_pi_mike1911_first_raise":
      var_0 = "iw8_pi_mike1911";
      break;
    case "iw8_la_mike32_incendiary":
      var_0 = "iw8_la_mike32";
      break;
    case "iw8_sh_dpapa12_incendiary":
      var_0 = "iw8_sh_dpapa12";
      break;
    case "iw8_pi_golf21_tfarah":
      var_0 = "iw8_pi_golf21";
      break;
  }

  return var_0;
}

make_weapon(var_0, var_1, var_2, var_3, var_4, var_5) {
  if(!isDefined(level._weapons))
    level._weapons = spawnStruct();

  if(!isDefined(var_1))
    var_1 = [];

  if(!issameweapon(var_0)) {
    var_6 = strtok(var_0, "+");

    if(var_6.size > 1) {
      var_0 = var_6[0];
      var_1 = scripts\engine\utility::array_combine(var_1, scripts\engine\utility::array_remove(var_6, var_6[0]));
    }
  } else {
    if(nullweapon(var_0))
      return var_0;

    var_0 = getweaponbasename(var_0);
  }

  if(istrue(var_5))
    var_7 = ::makeweaponfromstring;
  else
    var_7 = ::getcompleteweaponname;

  var_8 = getweapondefaults(var_0);
  var_8 = removeconflictingattachments(var_1, var_8);
  var_1 = scripts\engine\utility::array_combine(var_1, var_8);
  var_9 = [];

  foreach(var_11 in var_1) {
    if(issubstr(var_11, "|")) {
      var_1 = scripts\engine\utility::array_remove(var_1, var_11);
      var_1[var_1.size] = strtok(var_11, "|")[0];
      var_9[var_9.size] = var_11;
    }
  }

  if(isDefined(var_4))
    var_13 = call[[var_7]](var_0, var_1, var_2, var_3, var_4);
  else if(isDefined(var_3))
    var_13 = call[[var_7]](var_0, var_1, var_2, var_3);
  else if(isDefined(var_2))
    var_13 = call[[var_7]](var_0, var_1, var_2);
  else if(isDefined(var_1))
    var_13 = call[[var_7]](var_0, var_1);
  else
    var_13 = call[[var_7]](var_0);

  foreach(var_11 in var_9) {
    var_6 = strtok(var_11, "|");
    var_13 = var_13 withattachment(var_6[0], int(var_6[1]));
  }

  return var_13;
}

check_for_blacklisted_attachment() {
  var_0 = self;
  var_1 = [];
  var_1[var_1.size] = "attachment_wm_silencer01";
  var_1[var_1.size] = "attachment_wm_ar_kilo433_stock";
  var_1[var_1.size] = "attachment_wm_ar_mike4_receiver";
  var_1[var_1.size] = "attachment_wm_ar_mike4_stock";
  var_1[var_1.size] = "attachment_wm_ar_mike4_barrel";
  var_1[var_1.size] = "attachment_wm_ar_mike4_mag";
  var_1[var_1.size] = "attachment_wm_ar_scharlie_receiver";
  var_1[var_1.size] = "attachment_wm_ar_scharlie_stock";
  var_1[var_1.size] = "attachment_wm_ar_scharlie_barrel";
  var_1[var_1.size] = "attachment_wm_ar_scharlie_mag";
  var_1[var_1.size] = "attachment_wm_ar_falpha_receiver";
  var_1[var_1.size] = "attachment_wm_ar_falpha_barrel";
  var_1[var_1.size] = "attachment_wm_ar_falpha_mag";
  var_1[var_1.size] = "attachment_wm_ar_falpha_toprail";
  var_1[var_1.size] = "attachment_wm_ar_falpha_triggrip";
  var_1[var_1.size] = "attachment_wm_sm_mpapa5_reciever";
  var_1[var_1.size] = "attachment_wm_sm_mpapa5_stock";
  var_1[var_1.size] = "attachment_wm_sm_mpapa5_barrel";
  var_1[var_1.size] = "attachment_wm_sm_mpapa5_mag";
  var_1[var_1.size] = "attachment_wm_sm_papa90_receiver";
  var_1[var_1.size] = "attachment_wm_sm_papa90_barrel";
  var_1[var_1.size] = "attachment_wm_sm_papa90_mag";
  var_1[var_1.size] = "attachment_wm_sh_dpapa12_receiver";
  var_1[var_1.size] = "attachment_wm_sh_dpapa12_ammo";
  var_1[var_1.size] = "attachment_wm_sh_dpapa12_pump";
  var_1[var_1.size] = "attachment_wm_lm_kilo121_receiver";
  var_1[var_1.size] = "attachment_wm_lm_kilo121_stock";
  var_1[var_1.size] = "attachment_wm_lm_kilo121_barrel";
  var_1[var_1.size] = "attachment_wm_lm_kilo121_mag";
  var_1[var_1.size] = "attachment_wm_sn_mike14_receiver";
  var_1[var_1.size] = "attachment_wm_sn_mike14_stock";
  var_1[var_1.size] = "attachment_wm_sn_mike14_barrel";
  var_1[var_1.size] = "attachment_wm_sn_mike14_mag";
  var_1[var_1.size] = "attachment_wm_sn_mike14_stock";
  var_1[var_1.size] = "attachment_wm_sn_kilo98_receiver";
  var_1[var_1.size] = "attachment_wm_sn_kilo98_barrel";
  var_1[var_1.size] = "attachment_wm_pi_golf21_receiver";
  var_1[var_1.size] = "attachment_wm_pi_golf21_mag";
  var_1[var_1.size] = "attachment_wm_pi_golf21_slide";
  var_1[var_1.size] = "attachment_wm_pi_mike1911_v1_receiver";
  var_1[var_1.size] = "attachment_wm_pi_mike1911_v1_mag";
  var_1[var_1.size] = "attachment_wm_pi_mike1911_v1_slide";
  var_1[var_1.size] = "attachment_wm_pi_decho_receiver";
  var_1[var_1.size] = "attachment_wm_pi_decho_mag";
  var_1[var_1.size] = "attachment_wm_pi_decho_slide";
  var_1[var_1.size] = "attachment_wm_pi_decho_grip";
  var_1[var_1.size] = "weapon_wm_la_mike32";
  var_1[var_1.size] = "weapon_vm_me_soscar_knife";
  var_2 = scripts\engine\utility::array_reverse(getweaponattachments(var_0));
  var_3 = getweaponattachmentworldmodels(var_0);

  foreach(var_6, var_5 in var_3) {
    if(isDefined(scripts\engine\utility::array_find(var_1, var_5)))
      var_0 = self withoutattachment(var_2[var_6]);
  }

  return var_0;
}

give_weapon(var_0, var_1, var_2, var_3, var_4) {
  if(isstring(var_0))
    var_0 = make_weapon(var_0);

  if(isDefined(var_4))
    self giveweapon(var_0, var_1, var_2, var_3, var_4);
  else if(isDefined(var_3))
    self giveweapon(var_0, var_1, var_2, var_3);
  else if(isDefined(var_2))
    self giveweapon(var_0, var_1, var_2);
  else if(isDefined(var_1))
    self giveweapon(var_0, var_1);
  else
    self giveweapon(var_0);
}

take_weapon(var_0) {
  self takeweapon(var_0);
}

make_weapon_special(var_0) {
  switch (var_0) {
    case "farah_ar":
      var_0 = make_weapon("iw8_ar_akilo47", ["rec_akilo47|1", "back_akilo47|1", "front_akilo47|1", "mag_akilo47|1"]);
      break;
    case "alex_sniper":
      var_0 = make_weapon("iw8_sn_mike14", ["vzscope_mike14", "rec_mike14|1", "reargrip_mike14|1", "front_mike14|1", "xmags_mike14|1"]);
      break;
    case "alex_pistol":
      var_0 = make_weapon("iw8_pi_mike1911", ["rec_mike1911|1", "mag_mike1911|1", "slide_mike1911|1"]);
      break;
    case "griggs_pistol":
      var_0 = make_weapon("iw8_pi_mike1911", ["rec_mike1911|1", "mag_mike1911|1", "slide_mike1911"]);
      break;
    case "hadir_smg":
      var_0 = make_weapon("iw8_sm_augolf", ["rec_augolf|1", "front_augolf|1", "mag_augolf|1", "toprail_augolf|1"]);
      break;
    case "hadir_sniper":
      var_0 = make_weapon("iw8_sn_hdromeo_ballistics", ["vzscope_hdromeo_ballistics", "bipod_hdromeo_ballistics", "rec_hdromeo|1", "back_hdromeo|1", "front_hdromeo|1", "mag_hdromeo|1"]);
      break;
    case "sas_ar":
      var_0 = make_weapon("iw8_ar_kilo433", ["holo_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
      break;
    case "price_ar":
      var_0 = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "rec_kilo433|1", "back_kilo433|1", "barsil_kilo433", "mag_kilo433|1"]);
      break;
    case "kyle_ar":
      var_0 = make_weapon("iw8_ar_mcharlie", ["semi_ar", "reflex_west01", "silencer04", "laserir", "rec_mcharlie|1", "back_mcharlie|1", "barshort_mcharlie|1", "mag_mcharlie|1"]);
      break;
    case "papa320_black":
      var_0 = make_weapon("iw8_pi_papa320", ["rec_papa320|1", "mag_papa320|1", "slide_papa320|1"]);
      break;
    case "papa320_black_rain":
      var_0 = make_weapon("iw8_pi_papa320", ["rec_papa320_r", "mag_papa320_r", "slide_papa320_r"]);
      break;
    case "barkov_pistol":
      var_0 = make_weapon("iw8_pi_golf21", ["rec_golf21|1", "mag_golf21|1", "slide_golf21|1"]);
      break;
    case "estate_teaser_price":
      var_0 = make_weapon("iw8_ar_kilo433", ["hybrid_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    case "estate_teaser":
      var_0 = make_weapon("iw8_ar_kilo433", ["reflex_west01", "laserir", "silencer04", "rec_kilo433|1", "mag_kilo433|1", "stockh"]);
      break;
    case "enforcer_ar":
      var_0 = make_weapon("iw8_ar_akilo47", ["drums_akilo47_sp", "gripvert_akilo47", "holostable_east01"]);
      break;
    case "enforcer_pistol":
      var_0 = make_weapon("iw8_pi_decho", ["rec_decho|1", "mag_decho|1", "slide_decho|1", "triggrip_decho|1", "minireddotslow"]);
      break;
    default:
      var_0 = undefined;
  }

  return var_0;
}

fixplacedweapons(var_0) {
  var_1 = [];
  var_2 = getEntArray();

  foreach(var_4 in var_2) {
    if(!isDefined(var_4.classname)) {
      continue;
    }
    if(scripts\engine\utility::string_starts_with(var_4.classname, "weapon_"))
      var_1[var_1.size] = var_4;
  }

  foreach(var_7 in var_1) {
    var_8 = strtok(var_7.classname, "+");
    var_9 = getsubstr(var_8[0], 7, var_8[0].size);
    var_8 = scripts\engine\utility::array_remove_index(var_8, 0);
    var_10 = getweapondefaults(var_9);
    var_10 = removeconflictingattachments(var_8, var_10);
    var_8 = scripts\engine\utility::array_combine(var_10, var_8);
    var_11 = undefined;
    var_12 = "";

    foreach(var_14 in var_8) {
      var_12 = var_12 + "+" + var_14;

      if(var_14 == "ub_golf25_sp" || var_14 == "ub_mike203_sp")
        var_11 = 1;
    }

    var_16 = spawn("weapon_" + var_9 + var_12, var_7.origin, var_7.spawnflags);
    var_16.angles = var_7.angles;

    if(isDefined(var_7.targetname))
      var_16.targetname = var_7.targetname;

    if(isDefined(var_7.script_noteworthy))
      var_16.script_noteworthy = var_7.script_noteworthy;

    if(isDefined(var_7.script_namenumber))
      var_16.script_namenumber = var_7.script_namenumber;

    if(isDefined(var_7.script_parameters))
      var_16.script_parameters = var_7.script_parameters;

    if(isDefined(var_7.script_label))
      var_16.script_label = var_7.script_label;

    if(isDefined(var_7.script_ammo_alt_clip))
      var_16.script_ammo_alt_clip = var_7.script_ammo_alt_clip;

    if(isDefined(var_7.script_ammo_alt_extra))
      var_16.script_ammo_alt_extra = var_7.script_ammo_alt_extra;

    if(isDefined(var_7.script_ammo_clip))
      var_16.script_ammo_clip = var_7.script_ammo_clip;

    if(isDefined(var_7.script_ammo_extra))
      var_16.script_ammo_extra = var_7.script_ammo_extra;

    if(isDefined(var_7.script_ammo_max))
      var_16.script_ammo_max = var_7.script_ammo_max;

    var_16 scripts\anim\shared.gsc::setscriptammo(var_9, var_7, var_11);
    var_7 delete();
  }
}

aim_at(var_0, var_1, var_2, var_3) {
  self notify("stop_aiming");
  self endon("stop_aiming");
  self endon("death");

  if(!isDefined(var_0))
    var_0 = self localtoworldcoords((150, 0, 30));

  if(!isDefined(var_1))
    var_1 = 0;

  if(!isDefined(var_3))
    var_3 = 1.5;

  self.aim_target = scripts\engine\utility::spawn_script_origin();
  self.aim_target.origin = self gettagorigin("tag_flash") + anglesToForward(self gettagangles("tag_flash")) * 50;
  childthread internal_aim_occlusion_override();
  self setentitytarget(self.aim_target);
  self.aim_target moveTo(var_0, var_3, 0.01, 0.01);
  wait(var_3 * 0.5);

  if(var_1 > 0)
    thread aim_at_laser_on(var_1, var_2);

  wait(var_3 * 0.5);
}

internal_aim_occlusion_override() {
  self.suppress_uselastenemysightpos = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;

  for(;;) {
    self.lastenemysightpos = self.aim_target.origin;
    waitframe();
  }
}

internal_aim_at_laser_tracker() {
  for(;;) {
    waittillframeend;
    var_0 = self gettagorigin(self.aim_laser.tag);
    self.aim_laser dontinterpolate();
    self.aim_laser.origin = var_0;
    self.aim_laser.angles = vectortoangles(self.aim_target.origin - var_0);
    waitframe();
  }
}

is_aiming() {
  return isDefined(self.aim_target);
}

aim_at_laser_on(var_0, var_1) {
  self endon("laser_off");
  self endon("death");

  if(var_0 != 0) {
    if(!isDefined(var_1))
      var_1 = "tag_laser";

    self.aim_laser = spawn("script_model", self gettagorigin(var_1));
    self.aim_laser setModel("tag_laser");
    self.aim_laser setmoverlaserweapon(self.weapon);
    self.aim_laser.tag = var_1;

    if(var_0 == 1)
      self.aim_laser laseron();
    else
      self.aim_laser laserforceon();

    self.aim_laser.laser_state = var_0;
    internal_aim_at_laser_tracker();
  }
}

aim_at_laser_off() {
  self notify("laser_off");

  if(isDefined(self.aim_laser)) {
    if(self.aim_laser.laser_state == 1)
      self.aim_laser laseroff();
    else
      self.aim_laser laserforceoff();

    self.aim_laser delete();
    self.aim_laser = undefined;
  }
}

move_aim_to(var_0, var_1, var_2, var_3) {
  self endon("death");
  self endon("stop_aiming");

  if(!isDefined(var_2))
    var_2 = 0.05;

  if(!isDefined(var_3))
    var_3 = 0.05;

  self.aim_target moveTo(var_0, var_1, var_2, var_3);
  wait(var_1);
}

link_aim_to(var_0, var_1, var_2) {
  self endon("stop_aiming");
  self endon("death");

  if(!isDefined(var_1))
    var_1 = "tag_origin";

  if(isDefined(var_2))
    self.aim_target linkTo(var_0, var_1, var_2, (0, 0, 0));
  else
    self.aim_target linkTo(var_0, var_1);
}

move_aim_to_enemy(var_0, var_1, var_2, var_3, var_4, var_5) {
  self endon("stop_aiming");
  self endon("death");
  var_0 endon("death");

  if(!isDefined(var_1))
    var_1 = "tag_origin";

  if(!isDefined(var_2))
    var_2 = 3.0;

  if(!isDefined(var_3))
    var_3 = 50.0;

  if(!isDefined(var_4))
    var_4 = 1;

  var_6 = var_0 gettagorigin(var_1);
  var_7 = var_3;
  var_8 = var_0.origin;
  var_9 = var_3 / var_2;
  var_10 = distance(self.aim_target.origin, var_6) / var_2;

  while(distancesquared(self.aim_target.origin, var_0 gettagorigin(var_1)) > 5.0) {
    var_11 = 0.05;

    if(randomfloat(100) > 50)
      var_12 = var_0 localtoworldcoords((0, 0, var_7));
    else
      var_12 = var_0 localtoworldcoords((0, 0, var_7 * -1.0));

    var_13 = var_12 - var_0.origin + var_0 gettagorigin(var_1);
    var_14 = self.aim_target.origin;
    var_15 = length(var_0.origin - var_8) / var_11;
    var_16 = var_15 + var_10;
    var_17 = vectorNormalize(var_13 - var_14);
    var_18 = var_17 * var_16 * var_11;
    var_7 = var_7 - var_9 * var_11;
    var_7 = clamp(var_7, 0, var_3);
    var_8 = var_0.origin;
    move_aim_to(var_14 + var_18, var_11, 0.001, 0.001);
  }

  if(var_4) {
    self.aim_target.origin = self.aim_target.origin + vectorNormalize(self gettagorigin("tag_flash") - self.aim_target.origin) * 20.0;
    link_aim_to(var_0, var_1);
  }
}

stop_aiming() {
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

move_aim_along_spline(var_0, var_1) {
  self endon("stop_aiming");
  self endon("death");
  var_2 = 0;

  for(var_3 = var_0; isDefined(var_3.target); var_3 = var_3.next) {
    var_3.next = scripts\engine\utility::getStruct(var_3.target, "targetname");
    var_3.dist_to_next = distance(var_3.next.origin, var_3.origin);
    var_2 = var_2 + var_3.dist_to_next;
  }

  for(var_3 = var_0; isDefined(var_3.target); var_3 = var_3.next) {
    var_4 = var_3.dist_to_next / var_2 * var_1;
    move_aim_to(var_3.next.origin, var_4);
  }
}

aim_search_around(var_0, var_1, var_2, var_3) {
  self endon("stop_aiming");
  self endon("stop_searching");
  self endon("death");

  if(!isDefined(var_0))
    var_0 = -15.0;
  else {
    var_0 = var_0 * -1.0;
    var_0 = clamp(var_0, -30, 30);
  }

  if(!isDefined(var_1))
    var_1 = 15.0;
  else {
    var_1 = var_1 * -1.0;
    var_1 = clamp(var_1, -30, 30);
  }

  if(!isDefined(var_2))
    var_2 = 45.0;
  else
    var_2 = clamp(var_2, -90, 90);

  if(!isDefined(var_3))
    var_3 = -45.0;
  else
    var_3 = clamp(var_3, -90, 90);

  for(;;) {
    if(randomfloat(100) > 50)
      var_4 = var_1;
    else
      var_4 = var_0;

    if(randomfloat(100) > 50)
      var_5 = var_3;
    else
      var_5 = var_2;

    var_6 = 0.05;
    var_7 = 0.0;

    for(var_8 = self.aim_target.origin; var_7 < 4.0; var_7 = var_7 + var_6) {
      var_9 = self gettagorigin("tag_flash")[2];

      if(length(self.velocity) > 0)
        var_10 = vectortoangles(self.velocity);
      else
        var_10 = self.angles;

      var_11 = var_10 + (var_4, var_5, 0);
      var_12 = anglesToForward(var_11) * 75;
      var_13 = (self.origin[0], self.origin[1], var_9);
      var_8 = var_13 + var_12;
      var_14 = var_8 - self.aim_target.origin;
      var_15 = length(var_14);
      var_16 = vectorNormalize(var_14);
      var_17 = var_15 / (4.0 - var_7);
      var_18 = var_16 * var_17 + self.velocity;
      move_aim_to(self.aim_target.origin + var_18 * var_6, var_6, 0.00001, 0.00001);
    }

    self.aim_target.origin = var_8;
  }
}

stop_aim_search_around() {
  self notify("stop_searching");
}

userskip_wait() {
  var_0 = "userskipped";
  var_1 = "stop_userskip";
  var_2 = [var_0, var_1];

  foreach(var_4 in var_2) {
    if(!scripts\engine\utility::flag_exist(var_4)) {
      scripts\engine\utility::flag_init(var_4);
      continue;
    }

    if(scripts\engine\utility::flag(var_4))
      scripts\engine\utility::flag_clear(var_4);
  }

  setomnvar("ui_is_bink_skippable", 1);
  thread userskip_input();

  while(!scripts\engine\utility::flag(var_1) && !scripts\engine\utility::flag(var_0))
    waitframe();

  setomnvar("ui_is_bink_skippable", 0);
  level notify("stop_userskip_input_thread");
  return scripts\engine\utility::flag(var_0);
}

userskip_input() {
  level endon("stop_userskip_input_thread");

  for(;;) {
    level.player waittill("luinotifyserver", var_0, var_1);

    if(var_0 == "skip_bink_input") {
      scripts\engine\utility::flag_set("userskipped");
      break;
    }
  }
}

userskip_stop() {
  scripts\engine\utility::flag_set("stop_userskip");
}

get_adjusted_difficulty() {
  return scripts\sp\gameskill::auto_adjust_difficult_get();
}

civilianfailwrapper(var_0, var_1, var_2, var_3) {
  self notify("stop_civilian_fail_wrapper");
  self endon("stop_civilian_fail_wrapper");
  level endon("stop_all_civilian_fail_wrappers");

  if(!isDefined(var_0))
    var_0 = [9, 30];

  if(!isDefined(var_1))
    var_1 = 20;

  if(isDefined(var_2))
    var_2 = var_2 * var_2;

  if(!isDefined(var_3))
    var_3 = 0;

  var_4 = undefined;
  var_5 = ["MOD_IMPACT", "MOD_GRENADE", "MOD_GRENADE_SPLASH", "MOD_PROJECTILE_SPLASH", "MOD_EXPLOSIVE", "MOD_FIRE"];

  for(;;) {
    self waittill("damage", var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14, var_15, var_16, var_17, var_18, var_19);

    if(!isDefined(var_7) || !isDefined(var_6))
      continue;
    else if(!isPlayer(var_7))
      continue;
    else if(var_6 < var_1)
      continue;
    else if(isDefined(var_10) && istrue(var_3) && scripts\engine\utility::array_contains(var_5, var_10))
      continue;
    else if(isDefined(var_15) && var_15.basename == "flash")
      continue;
    else if(isDefined(var_2)) {
      var_4 = distancesquared(level.player.origin, self.origin);

      if(var_4 > var_2)
        continue;
    }

    break;
  }

  level thread scripts\sp\hud_util::fade_out(0);
  scripts\sp\player_death::set_custom_death_quote(scripts\engine\utility::array_randomize(var_0)[0]);
  missionfailedwrapper();
}

get_mount_activation_mode() {
  if(self usinggamepad())
    var_0 = self getlocalplayerprofiledata("mountButtonConfig");
  else
    var_0 = self getlocalplayerprofiledata("mountButtonConfigKBM");

  switch (var_0) {
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

notetrack_mission_failed_vo_enable() {
  level.notetrackmissionfailedvo = 1;
}

notetrack_mission_failed_vo_disable() {
  level.notetrackmissionfailedvo = 0;
}

notetrack_vo_enable() {
  level.notetrackvo = 1;
}

notetrack_vo_disable() {
  level.notetrackvo = 0;
}

door_remove_open_prompts() {
  thread scripts\sp\door::remove_open_prompts();
}

door_ai_allowed(var_0) {
  self.lockedforai = !var_0;

  if(var_0)
    thread scripts\sp\door::clear_navobstacle();
  else
    thread scripts\sp\door::create_navobstacle();
}

door_force_open_fully(var_0, var_1) {
  scripts\game\sp\door::remove_door_snake_cam_ability();
  scripts\sp\door::remove_open_ability();
  scripts\sp\door::door_open_completely(var_0, var_1);
}

nvidiaansel_scriptdisable(var_0) {
  if(computedropbagpositions())
    setsaveddvar("OPRLTQLTT", var_0);
}

nvidiaansel_allowduringcinematic(var_0) {
  if(computedropbagpositions())
    setsaveddvar("NLMKNQLSKL", var_0);
}

nvidiaansel_overridecollisionradius(var_0) {
  if(computedropbagpositions())
    setsaveddvar("NPTSOTOQSQ", var_0);
}

is_trials_level() {
  if(!isDefined(level.istrialslevel))
    level.istrialslevel = scripts\engine\utility::string_starts_with(level.script, "trials_");

  return level.istrialslevel;
}