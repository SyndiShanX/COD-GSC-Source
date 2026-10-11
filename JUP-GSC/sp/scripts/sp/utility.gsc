/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\sp\utility.gsc
***********************************************/

#using scripts\anim\combat_utility;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\anim\utility_common;
#using scripts\asm\asm;
#using scripts\asm\asm_sp;
#using scripts\common\ai;
#using scripts\common\anim;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\math;
#using scripts\engine\sp\utility;
#using scripts\engine\sp\utility_code;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\game\sp\door;
#using scripts\sp\analytics;
#using scripts\sp\autosave;
#using scripts\sp\door;
#using scripts\sp\endmission;
#using scripts\sp\equipment\molotov;
#using scripts\sp\equipment\offhands;
#using scripts\sp\gameskill;
#using scripts\sp\hud_util;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\player;
#using scripts\sp\player\context_melee;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\spawner;
#using scripts\sp\starts;
#using scripts\sp\stayahead;
#namespace utility;

function function_308aea4aa4bff28b(var_2bed055d535b7521) {
  trigs = function_89b1ee87a65f27c0();

  if(!trigs.size) {
    return undefined;
  }

  temp = [];
  trigflag = undefined;

  foreach(trig in trigs) {
    trigflag = trig get_trigger_flag();

    if(trigflag == var_2bed055d535b7521) {
      temp[temp.size] = trig;
    }
  }

  assertex(temp.size == 1, "getFlagTrig() called with zero or more than 1 flag triggers with " + var_2bed055d535b7521);
  return temp[0];
}

function function_aa23d38c721355c0(var_2bed055d535b7521) {
  trigs = function_89b1ee87a65f27c0();

  if(!trigs.size) {
    return undefined;
  }

  temp = [];
  trigflag = undefined;

  foreach(trig in trigs) {
    trigflag = trig get_trigger_flag();

    if(trigflag == var_2bed055d535b7521) {
      temp[temp.size] = trig;
    }
  }

  return temp;
}

function private function_89b1ee87a65f27c0() {
  trigs = getEntArray("trigger_multiple_flag_set", "classname");
  moretrigs = getEntArray("trigger_multiple_flag_set_touching", "classname");
  trigs = array_combine(trigs, moretrigs);
  moretrigs = getEntArray("trigger_multiple_flag_looking", "classname");
  trigs = array_combine(trigs, moretrigs);
  moretrigs = getEntArray("trigger_multiple_flag_lookat", "classname");
  trigs = array_combine(trigs, moretrigs);
  return trigs;
}

function delete_live_grenades() {
  allnades = getEntArray("grenade", "classname");

  foreach(nade in allnades) {
    if(!isDefined(nade.targetname) && nade.model != "projectile_molotov_v0") {
      nade delete();
    }
  }

  if(scripts\sp\equipment\offhands::offhandisprecached("molotov")) {
    thread scripts\sp\equipment\molotov::delete_all_molotovs();
  }

  if(level.player isthrowinggrenade()) {
    level.player childthread delete_grenade_when_thrown();
  }
}

function delete_grenade_when_thrown() {
  level.player waittill("grenade_fire", grenade, weapon);

  if(isDefined(grenade)) {
    grenade delete();
  }
}

function assign_animtree_based_on_subclass() {
  subclass = tolower(self.subclass);

  switch (subclass) {
    case #"hash_7b0e2f2ed84f34":
    case #"hash_133f47294b5584d8":
    case #"hash_284b2545dbaa82f7":
    case #"hash_321a9678047d0a4e":
    case #"hash_4ad475e6e15635bd":
    case #"hash_c5b8ccb3f51ff8f2":
      assign_human_animtree();
      break;
    default:
      assertmsg("ERROR: Unsupported subclass! Add this unittype to assign_animtree_based_on_subclass() in utility.gsc");
      break;
  }
}

function assign_animtree_based_on_unittype() {
  unittype = tolower(self.unittype);

  switch (unittype) {
    case #"hash_44aaeb0edd152195":
    case #"hash_e87767df2e5c3a68":
      assign_human_animtree();
      break;
    default:
      assertmsg("ERROR: " + unittype + " is an unsupported unittype! Add this unittype to assign_animtree_based_on_unittype() in utility.gsc");
      break;
  }
}

#using_animtree("generic_human");

function assign_human_animtree() {
  self useanimtree(#animtree);
}

function enable_procedural_bones() {
  self setanim(%proc_node, 1, 0);
}

function disable_procedural_bones() {
  self setanim(%proc_node, 0, 0);
}

function change_player_health_packets(num) {
  assert(isPlayer(self));
  self.player_health_packets += num;
  self notify("update_health_packets");

  if(self.player_health_packets >= 3) {
    self.player_health_packets = 3;
  }
}

function player_in_zerog() {
  if(isPlayer(self)) {
    player = self;
  } else {
    player = level.player;
  }

  return isDefined(player.space) && player.space.floating;
}

function do_damage(health, position, attacker, inflictor, mod, weapon, location) {
  if(self == level.player) {
    health = scripts\sp\player::dodamagefilter(health, mod);
  }

  return self dodamage(health, position, attacker, inflictor, mod, weapon, location);
}

function set_player_attacker_accuracy(val) {
  player = get_player_from_self();
  player.scriptedattackeraccuracy = val;
  player scripts\sp\gameskill::update_player_attacker_accuracy();
}

function player_has_unlocked_stored_equipment_slots() {
  if(!isDefined(level.player.storedslotsunlocked) || !level.player.storedslotsunlocked) {
    return 0;
  }

  return 1;
}

function player_seek_enable() {
  level.player endon("death");
  level.player endon("stop_player_seek");
  level.player endon("entitydeleted");
  self notify("stop_player_seek");
  self endon("death");
  self endon("stop_player_seek");
  self endon("entitydeleted");
  g_radius = 1200;

  if(has_shotgun()) {
    g_radius = 250;
  }

  newgoalradius = distance(self.origin, level.player.origin);

  for(;;) {
    wait 2;
    self.goalradius = newgoalradius;
    self setgoalentity(level.player);
    newgoalradius -= 175;

    if(newgoalradius < g_radius) {
      newgoalradius = g_radius;
      return;
    }
  }
}

function player_seek_disable() {
  self notify("stop_player_seek");
}

function riotshield_lock_orientation(yaw_angle) {
  self orientmode("face angle", yaw_angle);
  self.lockorientation = 1;
}

function riotshield_unlock_orientation() {
  self.lockorientation = 0;
}

function cqb_walk(on_or_off) {
  if(on_or_off == "on") {
    enable_cqbwalk();
    return;
  }

  assert(on_or_off == "off");
  disable_cqbwalk();
}

function enable_flashlight(enable, safe) {
  if(!isDefined(enable)) {
    enable = 1;
  }

  if(!isDefined(safe)) {
    safe = 1;
  }

  if(enable) {
    scripts\sp\nvg\nvg_ai::flashlight_on(safe);
    return;
  }

  scripts\sp\nvg\nvg_ai::flashlight_off(safe);
}

function throwgrenadeatplayerasap() {
  scripts\anim\combat_utility::throwgrenadeatplayerasap_combat_utility();
}

function waterfx(endflag, soundalias) {
  self endon("death");
  play_sound = 0;

  if(isDefined(soundalias)) {
    play_sound = 1;
  }

  if(isDefined(endflag)) {
    flag_assert(endflag);
    level endon(endflag);
  }

  for(;;) {
    wait randomfloatrange(0.15, 0.3);
    start = self.origin + (0, 0, 150);
    end = self.origin - (0, 0, 150);
    trace = ray_trace_detail(start, end, undefined, create_default_contents(1));

    if(trace["surfacetype"] != "water") {
      continue;
    }

    fx = "water_movement";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        fx = "water_stop";
      }
    } else if(isDefined(level._effect["water_" + self.a.movement])) {
      fx = "water_" + self.a.movement;
    }

    water_fx = getfx(fx);
    start = trace["position"];
    angles = (0, self.angles[1], 0);
    forward = anglesToForward(angles);
    up = anglestoup(angles);
    playFX(water_fx, start, up, forward);

    if(fx != "water_stop" && play_sound) {
      thread play_sound_in_space(soundalias, start);
    }
  }
}

function player_is_near_live_offhand(isautosave) {
  grenades = getEntArray("grenade", "classname");

  foreach(grenade in grenades) {
    if(!offhand_is_dangerous(grenade)) {
      continue;
    }

    for(playerindex = 0; playerindex < level.players.size; playerindex++) {
      player = level.players[playerindex];

      if(distancesquared(grenade.origin, player.origin) < 75625) {
        if(istrue(isautosave)) {
          scripts\sp\autosave::autosaveprint("live grenade is near the player", 0);
        }

        return true;
      }
    }
  }

  return false;
}

function offhand_is_dangerous(grenade) {
  if(!isDefined(grenade.targetname)) {
    return true;
  }

  if(grenade.targetname == "offhand_claymore") {
    return false;
  }

  if(grenade.targetname == "offhand_c4_no_detonator") {
    return false;
  }

  if(grenade.targetname == "offhand_noisemaker") {
    return false;
  }

  if(grenade.targetname == "offhand_throwingknife") {
    return false;
  }

  if(grenade.targetname == "offhand_car_grenade") {
    return false;
  }

  if(grenade.targetname == "offhand_ied") {
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

function isprimaryweapon(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon)) {
    return 0;
  }

  if(isstring(weapon) && weapon == "none") {
    return 0;
  }

  if(weaponinventorytype(weapon) != "primary") {
    return 0;
  }

  switch (weaponclass(weapon)) {
    case #"hash_690c0d6a821b42e":
    case #"hash_6191aaef9f922f96":
    case #"hash_61e969dacaaf9881":
    case #"hash_719417cb1de832b6":
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_900cb96c552c5e8e":
    case #"hash_fa24dff6bd60a12d":
      return 1;
    default:
      return 0;
  }
}

function enable_heat_behavior(shoot_while_moving) {
  assertmsg("heat is no longer supported.talk to AI if there's something about heat that you need.");
}

function interactivekeypairs() {
  interactivekeypairs = [];
  interactivekeypairs[0] = ["interactive_birds", "targetname"];
  interactivekeypairs[1] = ["interactive_vulture", "targetname"];
  interactivekeypairs[2] = ["interactive_fish", "script_noteworthy"];
  return interactivekeypairs;
}

function mask_interactives_in_volumes(volumes) {
  interactivekeypairs = interactivekeypairs();
  combinedinteractives = [];

  foreach(interactivekeypair in interactivekeypairs) {
    moreinteractives = getEntArray(interactivekeypair[0], interactivekeypair[1]);
    combinedinteractives = array_combine(combinedinteractives, moreinteractives);
  }

  foreach(ent in combinedinteractives) {
    if(isDefined(ent.script_noteworthy)) {
      ent_type = ent.script_noteworthy;
    } else {
      ent_type = ent.targetname;
    }

    assertex(isDefined(ent.interactive_type), ent_type + "<dev string:x1c>");
    assertex(isDefined(level._interactive), ent_type + "<dev string:x4f>");
    assertex(isDefined(level._interactive[ent.interactive_type]), ent_type + "<dev string:x86>" + ent.interactive_type + "<dev string:xae>");

    if(!isDefined(level._interactive[ent.interactive_type].savetostructfn)) {
      continue;
    }

    foreach(volume in volumes) {
      if(!volume istouching(ent)) {
        continue;
      }

      if(!isDefined(volume.interactives)) {
        volume.interactives = [];
      }

      volume.interactives[volume.interactives.size] = ent[[level._interactive[ent.interactive_type].savetostructfn]]();
    }
  }
}

function activate_interactives_in_volume() {
  if(!isDefined(self.interactives)) {
    return;
  }

  foreach(stored_int in self.interactives) {
    stored_int[[level._interactive[stored_int.interactive_type].loadfromstructfn]]();
  }

  self.interactives = undefined;
}

function delete_interactives_in_volumes(volumes) {
  mask_interactives_in_volumes(volumes);

  foreach(volume in volumes) {
    volume.interactives = undefined;
  }
}

function is_in_antigrav_grenade() {
  if(self == level.player) {
    if(!isDefined(self.inantigrav) || self.inantigrav == 0) {
      return 0;
    } else {
      return 1;
    }

    return;
  }

  if(!isDefined(self.antigravgrenstate)) {
    return 0;
  }

  return 1;
}

function hud_intel_message(header_string, body_string, var_5baa186d177b643, var_2be6a7f58da8f2d4) {
  intel_value = 20;

  if(!isDefined(var_5baa186d177b643)) {
    var_5baa186d177b643 = "default";
  }

  switch (var_5baa186d177b643) {
    case #"hash_16c9edc2631cebf9":
      intel_value = 0;
      break;
    case #"hash_16c9ecc2631cea66":
      intel_value = 1;
      break;
    case #"hash_16c9ebc2631ce8d3":
      intel_value = 2;
      break;
    case #"hash_16c9eac2631ce740":
      intel_value = 3;
      break;
    case #"hash_16c9f1c2631cf245":
      intel_value = 4;
      break;
    case #"hash_16c9f0c2631cf0b2":
      intel_value = 5;
      break;
    case #"hash_16c9efc2631cef1f":
      intel_value = 6;
      break;
    case #"hash_16c9eec2631ced8c":
      intel_value = 7;
      break;
    case #"hash_16c9f5c2631cf891":
      intel_value = 8;
      break;
    case #"hash_16c9f4c2631cf6fe":
      intel_value = 9;
      break;
    case #"hash_fcca0c020684e562":
      intel_value = 10;
      break;
    case #"hash_fcca0d020684e6f5":
      intel_value = 11;
      break;
    case #"hash_fcca0a020684e23c":
      intel_value = 12;
      break;
    case #"hash_fcca0b020684e3cf":
      intel_value = 13;
      break;
    case #"hash_fcca08020684df16":
      intel_value = 14;
      break;
    case #"hash_fcca09020684e0a9":
      intel_value = 15;
      break;
    case #"hash_fcca06020684dbf0":
      intel_value = 16;
      break;
    case #"hash_fcca07020684dd83":
      intel_value = 17;
      break;
    case #"hash_fcca14020684f1fa":
      intel_value = 18;
      break;
    case #"hash_fcca15020684f38d":
      intel_value = 19;
      break;
    case #"hash_7038dec66d8275be":
      intel_value = 20;
      break;
    case #"hash_cc2f9c6895f781d6":
      intel_value = 20;
      break;
    case #"hash_d8f1f065b9610dde":
      intel_value = 21;
      break;
    case #"hash_3fee7f4438bd3468":
      intel_value = 22;
      break;
    case #"hash_cc9bd548714d725f":
      intel_value = 23;
      break;
    case #"hash_4a8e0d18adc8bc5d":
      intel_value = 24;
      break;
    case #"hash_840c353cb832f8db":
      intel_value = 25;
      break;
    case #"hash_d884fa199c3e6167":
      intel_value = 26;
      break;
    case #"hash_618f3064f8fb4964":
      intel_value = 27;
      break;
    case #"hash_618f3164f8fb4af7":
      intel_value = 28;
      break;
    case #"hash_618f3264f8fb4c8a":
      intel_value = 29;
      break;
    case #"hash_618f3364f8fb4e1d":
      intel_value = 30;
      break;
    case #"hash_618f2c64f8fb4318":
      intel_value = 31;
      break;
    case #"hash_618f2d64f8fb44ab":
      intel_value = 32;
      break;
    case #"hash_618f2e64f8fb463e":
      intel_value = 33;
      break;
    case #"hash_618f2f64f8fb47d1":
      intel_value = 34;
      break;
    case #"hash_618f2864f8fb3ccc":
      intel_value = 35;
      break;
    case #"hash_618f2964f8fb3e5f":
      intel_value = 36;
      break;
    case #"hash_35dd41db085fb045":
      intel_value = 37;
      break;
    case #"hash_9a1ab51f3a54ac68":
      intel_value = 38;
      break;
    case #"hash_60889fe00c561285":
      intel_value = 39;
      break;
  }

  setomnvar("ui_sp_intel_messaging_image_index", intel_value);
  setomnvar("ui_sp_intel_messaging_text", body_string);
  setomnvar("ui_sp_intel_messaging_header", header_string);
  setomnvar("ui_sp_intel_messaging", 1);
  level.player thread _intel_waypoint_button_listener();
  var_31761df376c7c7c3 = var_5baa186d177b643 == "tally_intel";

  if(var_31761df376c7c7c3) {
    level.player thread _intel_dismiss_button_listener();
  }

  if(isDefined(var_2be6a7f58da8f2d4)) {
    setomnvar("ui_sp_intel_messaging_ent", 1);
  } else {
    setomnvar("ui_sp_intel_messaging_ent", 0);
  }

  action = "close";
  start_time = gettime() / 1000;
  wait_time = 5;

  while(var_31761df376c7c7c3 && !isDefined(level.player.intel_dismiss_request) || !var_31761df376c7c7c3 && gettime() / 1000 - start_time < wait_time) {
    if(isDefined(level.player.intel_waypoint_request)) {
      action = "waypoint";
      break;
    }

    wait 0.05;
  }

  setomnvar("ui_sp_intel_messaging", 0);
  setomnvar("ui_sp_intel_messaging_ent", 0);
  level.player.intel_dismiss_request = undefined;

  if(action == "waypoint" && isDefined(var_2be6a7f58da8f2d4)) {
    target_loc = spawn_script_origin(var_2be6a7f58da8f2d4, (0, 0, 0));
    target_loc.icon = newhudelem();
    target_loc.icon setshader("intel_hint_icon", 32, 32);
    target_loc.icon.color = (0, 1, 0.976);
    target_loc.icon.alpha = 1;
    target_loc.icon setwaypoint(1, 1, 0);
    target_loc.icon settargetEnt(target_loc);
    current_dist = distance2dsquared(level.player.origin, target_loc.origin);

    while(true) {
      if(distance2dsquared(level.player.origin, target_loc.origin) < squared(75) || distance2dsquared(level.player.origin, target_loc.origin) > current_dist * 2.5) {
        break;
      }

      wait 0.05;
    }

    target_loc.icon destroy();
    target_loc delete();
    level.player.intel_waypoint_request = undefined;
    return;
  }

  level.player notify("dismiss_skipped");
  level.player.intel_dismiss_request = undefined;
  return;
}

function is_demo() {
  if(getdvarint(@ "scr_demo", 0)) {
    return true;
  }

  return false;
}

function is_lastlevel() {
  if(level.script == scripts\sp\endmission::function_823f915153b5fcd8()) {
    return true;
  }

  return false;
}

function hudoutline_ar_callout(display_name, large_object, widget_offset) {
  if(isDefined(level.player.ar_callout_ent)) {
    hudoutline_ar_disable();
  }

  level.player endon("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  wait 0.05;
  setsaveddvar(@ "r_hudoutlineenable", 1);
  level.player.ar_callout_ent = spawn_tag_origin();
  setomnvar("ui_inworld_ar_ent", level.player.ar_callout_ent);

  if(!isDefined(display_name)) {
    display_name = "ar_callouts_default";
  }

  setomnvar("ui_ar_object_text", display_name);
  wait 0.05;

  if(isDefined(large_object) && large_object) {
    hudoutline_enable_new("outlinefill_depth_orange", "default");
  } else {
    hudoutline_enable_new("outlinefill_nodepth_orange", "default");
  }

  setomnvar("ui_show_ar_elem", 1);
  thread _ar_callout_tracker(widget_offset);
}

function _ar_callout_tracker(widget_offset) {
  level.player endon("stop_ar_callout");
  self endon("death");

  while(true) {
    if(isDefined(widget_offset)) {
      offset = self.origin + widget_offset;
    } else {
      offset = self.origin + (0, 0, 30);
    }

    level.player.ar_callout_ent.origin = offset;
    wait 0.05;
  }
}

function hudoutline_ar_disable() {
  hudoutline_disable("default");
  setomnvar("ui_show_ar_elem", 0);
  wait 0.1;
  level.player notify("stop_ar_callout");
  setomnvar("ui_inworld_ar_ent", undefined);
  level.player.ar_callout_ent delete();
  level.player.ar_callout_ent = undefined;
}

function in_specialist_mode() {
  if(getdvarint(@ "hash_fd8c5b01485d9d7e")) {
    return 1;
  }

  return 0;
}

function in_yolo_mode() {
  if(getdvarint(@ "hash_e352b7180a71c62a")) {
    return 1;
  }

  return 0;
}

function in_zero_gravity() {
  return level.player ent_flag_exist("zero_gravity") && level.player ent_flag("zero_gravity");
}

function remove_equipment_immediately(seekers, emps, antigravs, frags, drones_delete, drones_explode) {
  if(!isDefined(seekers)) {
    seekers = 1;
  }

  if(!isDefined(emps)) {
    emps = 1;
  }

  if(!isDefined(antigravs)) {
    antigravs = 1;
  }

  if(!isDefined(frags)) {
    frags = 1;
  }

  if(!isDefined(drones_delete)) {
    drones_delete = 1;
  }

  if(!isDefined(drones_explode)) {
    drones_explode = 0;
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

function setplayerlootenabled(boolean) {
  setDvar(@ "hash_614d0737da55cb97", boolean);
}

function playerlootenabled() {
  return getdvarint(@ "hash_614d0737da55cb97");
}

function personalcoldbreathstop() {
  self notify("stop personal effect");
}

function personalcoldbreathspawner() {
  self endon("death");
  self notify("stop personal effect");
  self endon("stop personal effect");

  for(;;) {
    self waittill("spawned", spawn);

    if(scripts\common\ai::spawn_failed(spawn)) {
      continue;
    }

    spawn thread scripts\anim\utility::personalcoldbreath();
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
  flag_set("missionfailed");

  if(getDvar(@ "failure_disabled") == "1") {
    return;
  }

  if(isDefined(level.mission_fail_func)) {
    thread[[level.mission_fail_func]]();
    return;
  }

  thread scripts\sp\player_death::set_death_hint();
  missionfailed(in_yolo_mode());
}

function giveachievement_wrapper(achievement, notused) {
  if(is_demo()) {
    return;
  }

  level.player giveachievement(achievement);
  println("<dev string:xc0>" + achievement);
}

function player_giveachievement_wrapper(achievement) {
  if(is_demo()) {
    return;
  }

  if(is_lastlevel()) {
    return;
  }

  self giveachievement(achievement);
  println("<dev string:xc0>" + achievement);
}

function play_skippable_cinematic(cinematic_name, skip_waittill, var_f7bf02ab54fdcd73, var_2eda2be8546dadd6, var_ea1e6a586be81a36, var_80abb89d9bfbd9c4) {
  if(!isDefined(var_2eda2be8546dadd6)) {
    var_2eda2be8546dadd6 = 0;
  }

  if(!isDefined(var_ea1e6a586be81a36)) {
    var_ea1e6a586be81a36 = 0;
  }

  if(!isDefined(var_80abb89d9bfbd9c4)) {
    var_80abb89d9bfbd9c4 = 0;
  }

  setsaveddvar(@ "hash_d3ee5a6578fe61de", "1");
  setsaveddvar(@ "hash_b9ff37d084074df3", "1");
  level.player cleardamageindicators();
  cinematicingame(cinematic_name);
  level.player scripts\sp\player::remove_damage_effects_instantly();
  remove_equipment_immediately();
  registered = "skippable_cinematic";
  level.player val::set(registered, "weapon", 0);
  level.player val::set(registered, "freezecontrols", 1);
  level.player val::set(registered, "damage", 0);
  level.player val::set(registered, "breath_system", 0);
  level.player val::set(registered, "cg_drawcrosshair", 0);
  level.player val::set(registered, "show_weapon_hud", 0);
  level.player val::set(registered, "show_hud", 0);

  while(!iscinematicplaying()) {
    waitframe();
  }

  var_44e364ac7d2904 = spawnStruct();
  thread cinematic_skip_input(skip_waittill, var_ea1e6a586be81a36, var_44e364ac7d2904);

  if(isDefined(var_f7bf02ab54fdcd73)) {
    was_timeout = cinematic_waittill_skip_or_time(var_f7bf02ab54fdcd73);
    level.player val::reset_all(registered);
    level.player cleardamageindicators();
    level notify("skippable_cinematic_done");

    while(iscinematicplaying()) {
      waitframe();
    }

    setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
    setsaveddvar(@ "hash_b9ff37d084074df3", "0");
    setomnvar("ui_is_bink_skippable", 0);

    if(!istrue(var_44e364ac7d2904.was_skipped)) {
      if(istrue(was_timeout)) {
        stopcinematicingame(var_80abb89d9bfbd9c4);
      } else {
        stopcinematicingame(var_2eda2be8546dadd6);
      }
    }

    return;
  }

  while(iscinematicplaying()) {
    waitframe();
  }

  setsaveddvar(@ "hash_d3ee5a6578fe61de", "0");
  setsaveddvar(@ "hash_b9ff37d084074df3", "0");
  setomnvar("ui_is_bink_skippable", 0);

  if(!istrue(var_44e364ac7d2904.was_skipped)) {
    stopcinematicingame(var_2eda2be8546dadd6);
  }

  level.player val::reset_all(registered);
  level.player cleardamageindicators();
  level notify("skippable_cinematic_done");
}

function cinematic_skip_input(skip_waittill, var_ea1e6a586be81a36, var_171db63c4573af26) {
  if(!isDefined(var_ea1e6a586be81a36)) {
    var_ea1e6a586be81a36 = 0;
  }

  level endon("skippable_cinematic_done");

  if(isDefined(skip_waittill)) {
    self waittill(skip_waittill);
  }

  setomnvar("ui_is_bink_skippable", 1);

  while(true) {
    level.player waittill("luinotifyserver", message, value);

    if(message == "skip_bink_input") {
      if(isDefined(var_171db63c4573af26)) {
        var_171db63c4573af26.was_skipped = 1;
      }

      level notify("cinematic_skipped");
      stopcinematicingame(var_ea1e6a586be81a36);
      break;
    }
  }
}

function cinematic_waittill_skip_or_time(wait_time) {
  level endon("cinematic_skipped");
  wait_time *= 1000;

  while(true) {
    cinematic_time = cinematicgettimeinmsec();

    if(cinematic_time >= wait_time) {
      return 1;
    }

    waitframe();
  }
}

function isriotshield(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon)) {
    return false;
  }

  if(isstring(weapon) && weapon == "none") {
    return false;
  }

  return weapontype(weapon) == "riotshield";
}

function isknifeonly(weapon) {
  weapname = getweaponbasename(weapon);
  return issubstr(weapname, "knife");
}

function isbulletweapon(weapon) {
  if(isweapon(weapon) && isnullweapon(weapon)) {
    return 0;
  }

  if(isstring(weapon) && weapon == "none") {
    return 0;
  }

  if(isriotshield(weapon) || isknifeonly(weapon)) {
    return 0;
  }

  switch (weaponclass(weapon)) {
    case #"hash_690c0d6a821b42e":
    case #"hash_6191aaef9f922f96":
    case #"hash_719417cb1de832b6":
    case #"hash_8cdaf2e4ecfe5b51":
    case #"hash_900cb96c552c5e8e":
    case #"hash_fa24dff6bd60a12d":
      return 1;
    default:
      return 0;
  }
}

function function_1a12913e4f208e36(func) {
  if(getdvarint(@ "hash_e9e247c60cd8800a")) {
    if(!isDefined(func)) {
      func = "";
    }

    if(!isDefined(level.var_9392ea6ef7f37909)) {
      level.var_9392ea6ef7f37909 = [];
    }

    if(!array_contains(level.var_9392ea6ef7f37909, func)) {
      iprintlnbold("^1" + func + "(), Time to switch to the scripted_melee version of this func!");
      level.var_9392ea6ef7f37909 = array_add(level.var_9392ea6ef7f37909, func);
    }
  }
}

function context_melee_enable(bool) {
  function_1a12913e4f208e36("context_melee_enable");
  assertex(isDefined(bool));

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    level.player function_b6a59f7759a30482(bool);
    return;
  }

  if(!bool) {
    level.player thread scripts\sp\player\context_melee::disable_dynamic_takedowns();
    return;
  }

  level thread scripts\sp\player\context_melee::main();
}

function context_melee_allow(bool) {
  function_1a12913e4f208e36("context_melee_allow");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    function_1a479cad9c3adbb1(bool);
    return;
  }

  self.context_melee_allowed = bool;
}

function context_melee_allow_hint(bool) {
  function_1a12913e4f208e36("context_melee_allow_hint");
  level.var_f27ceead977abab6 = ter_op(!isDefined(bool) || bool, undefined, 1);
}

function context_melee_allow_blocked_hint(bool) {
  function_1a12913e4f208e36("context_melee_allow_blocked_hint");
  level.player.context_melee_blocked_hint_allowed = bool;
}

function context_melee_allow_directions(directions) {
  function_1a12913e4f208e36("context_melee_allow_directions");
  assertex(isDefined(directions));
  assertex(isarray(directions), "Directions need to be an array!");
  self.context_melee_allow_directions = directions;
}

function context_melee_set_silent_kill(bool) {
  function_1a12913e4f208e36("context_melee_set_silent_kill");
  assertex(isDefined(bool));

  if(bool) {
    setDvar(@ "context_melee_silent", 1);
    return;
  }

  setDvar(@ "context_melee_silent", 0);
}

function context_melee_set_custom_hint(hint_string) {
  function_1a12913e4f208e36("context_melee_set_custom_hint");
  assertex(isDefined(hint_string));
  level.player.context_melee_hint_custom = hint_string;
}

function context_melee_clear_custom_hint() {
  function_1a12913e4f208e36("context_melee_clear_custom_hint");
  level.player.context_melee_hint_custom = undefined;
}

function context_melee_set_blocked_custom_hint(hint_string) {
  function_1a12913e4f208e36("context_melee_set_blocked_custom_hint");
  assertex(isDefined(hint_string));
  level.player.context_melee_hint_blocked_custom = hint_string;
}

function context_melee_clear_blocked_custom_hint() {
  function_1a12913e4f208e36("context_melee_clear_blocked_custom_hint");
  level.player.context_melee_hint_blocked_custom = undefined;
}

function context_melee_set_hint_directions(directions) {
  function_1a12913e4f208e36("context_melee_set_hint_directions");
  assertex(isDefined(directions));
  assertex(isarray(directions), "Directions need to be an array!");
  level.player.context_melee_allow_directions = directions;
}

function context_melee_override_anim(animscene, direction, lastframe_bone, lastframe_type, launch, rules, victimlives) {
  function_1a12913e4f208e36("context_melee_override_anim");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    function_299b43ee3353dacc(animscene, direction, rules, victimlives, undefined, launch);
    return;
  }

  if(!isDefined(direction)) {
    direction = "all";
  }

  if(!isDefined(animscene) && isDefined(self.context_melee_anim_name) && isDefined(self.context_melee_anim_name[direction])) {
    context_melee_removeoverridedirection(direction, 1);
    return;
  }

  assertex(isDefined(animscene));

  if(!isDefined(level.scr_anim["<dev string:xce>"][animscene]) && !istrue(launch)) {
    iprintlnbold("<dev string:xd6>" + animscene + "<dev string:xe0>");
  }

  if(!isDefined(level.scr_anim[context_melee_getplayerriganimname()][animscene])) {
    iprintlnbold("<dev string:xd6>" + animscene + "<dev string:x102>");
  }

  self.context_melee_victim_lives = victimlives;

  if(isDefined(level.scr_anim[context_melee_getplayerriganimname()][animscene]) && isDefined(level.scr_anim["generic"][animscene])) {
    if(!isDefined(self.context_melee_anim_name)) {
      self.context_melee_anim_name = [];
    }

    self.context_melee_anim_name[direction] = animscene;
    notetracks = ["cm_death", "cm_ragdoll", "cm_fx", "cm_sfx", "cm_sfx_player"];
    functions[0] = &scripts\sp\player\context_melee::context_melee_death;
    functions[1] = &scripts\sp\player\context_melee::context_melee_ragdoll;
    functions[2] = &scripts\sp\player\context_melee::context_melee_fx;
    functions[3] = &scripts\sp\player\context_melee::context_melee_sfx;
    functions[4] = &scripts\sp\player\context_melee::context_melee_sfx;

    foreach(notetrack in notetracks) {
      if(isDefined(level.scr_notetrack["generic"]) && isDefined(level.scr_notetrack["generic"][animscene]) && isDefined(level.scr_notetrack["generic"][animscene][notetrack]) && level.scr_notetrack["generic"][animscene][notetrack].size > 0) {
        for(i = 0; i < level.scr_notetrack["generic"][animscene][notetrack].size; i++) {
          if(isDefined(level.scr_notetrack["generic"][animscene][notetrack][i]["function"])) {
            if(level.scr_notetrack["generic"][animscene][notetrack][i]["function"] == functions[n]) {
              println("<dev string:x11d>" + animscene + "<dev string:x136>" + notetrack + "<dev string:x138>");
              level.scr_notetrack["generic"][animscene][notetrack][i]["function"] = undefined;
            }
          }
        }
      }
    }

    scripts\common\anim::addnotetrack_customfunction("generic", "cm_death", &scripts\sp\player\context_melee::context_melee_death, animscene);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_ragdoll", &scripts\sp\player\context_melee::context_melee_ragdoll, animscene);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_fx", &scripts\sp\player\context_melee::context_melee_fx, animscene);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_sfx", &scripts\sp\player\context_melee::context_melee_sfx, animscene);
    scripts\common\anim::addnotetrack_customfunction("generic", "cm_sfx_player", &scripts\sp\player\context_melee::context_melee_sfx, animscene);
  }

  if(isDefined(lastframe_bone)) {
    context_melee_set_lastframe_bone(lastframe_bone);
  } else {
    context_melee_set_lastframe_bone(level.context_melee_player_link_bone);
  }

  if(isDefined(lastframe_type)) {
    context_melee_set_lastframe_type(lastframe_type);
  } else {
    context_melee_set_lastframe_type("player_capsule");
  }

  if(istrue(launch)) {
    level.context_melee_do_launch = 1;
  }
}

function context_melee_removeoverridedirection(direction, global) {
  function_1a12913e4f208e36("context_melee_removeOverrideDirection");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    function_a072535b3f7182fe(direction, global);
    return;
  }

  self.context_melee_anim_name[direction] = undefined;
}

function context_melee_set_arms(arms) {
  function_1a12913e4f208e36("context_melee_set_arms");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    level.player function_c4ec7d985422ce24(arms);
    return;
  }

  level.scr_model[context_melee_getplayerriganimname()] = arms;
  level.player.melee_arms delete();
  level.player.melee_arms = spawn_anim_model(context_melee_getplayerriganimname(), level.player.origin, level.player.angles);
  level.player.melee_arms notsolid();
  level.player.melee_arms hide();
}

function context_melee_set_weapon(weapon) {
  function_1a12913e4f208e36("context_melee_set_weapon");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    function_aa54d0684bb8d0cf(weapon);
    return;
  }

  level.player.context_melee_knife = weapon;
}

function context_melee_set_lastframe_bone(bone) {
  function_1a12913e4f208e36("context_melee_set_lastframe_bone");
  assertex(isDefined(bone));
  level.context_melee_lastframe_bone = bone;
}

function context_melee_set_lastframe_type(type) {
  function_1a12913e4f208e36("context_melee_set_lastframe_type");
  assertex(isDefined(type));
  level.context_melee_lastframe_type = type;
}

function context_melee_sight_disabled(bool) {
  function_1a12913e4f208e36("context_melee_sight_disabled");
  assertex(isDefined(bool));
  level.context_melee_sight_disabled = bool;
}

function context_melee_waittill_player_finished() {
  function_1a12913e4f208e36("context_melee_waittill_player_finished");
  level.player endon("death");
  level.player waittill("context_melee_anim_ended");
  waittillframeend();

  while(istrue(level.player.context_melee_launching)) {
    waitframe();
  }
}

function context_melee_getstartnotifystring() {
  function_1a12913e4f208e36("context_melee_getStartNotifyString");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    return function_a1260c3b5f229f69();
  }

  return "start_context_melee";
}

function context_melee_getanimstartednotifystring() {
  function_1a12913e4f208e36("context_melee_getAnimStartedNotifyString");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    return function_ae9fb94402a02d07();
  }

  return "context_melee_anim_started";
}

function context_melee_getanimendednotifystring() {
  function_1a12913e4f208e36("context_melee_getAnimEndedNotifyString");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    return function_a73c26a3feb8ef0e();
  }

  return "context_melee_anim_ended";
}

function context_melee_getanimlongestendednotifystring() {
  function_1a12913e4f208e36("context_melee_getAnimLongestEndedNotifyString");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    return function_835e274f31e87cf4();
  }

  return "context_melee_longest_anim_ended";
}

function context_melee_getvictim() {
  function_1a12913e4f208e36("context_melee_getVictim");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    return function_7e105b48ce221583();
  }

  return self.context_melee_victim;
}

function context_melee_getplayerriganimname() {
  function_1a12913e4f208e36("context_melee_getPlayerRigAnimname");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    return function_ea3248e9abe4700a();
  }

  return "context_melee_player_rig";
}

function context_melee_isenabled() {
  function_1a12913e4f208e36("context_melee_isEnabled");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    return function_75b55c43bf528532();
  }

  return level.context_melee_enabled;
}

function function_906673d270412b82() {
  function_1a12913e4f208e36("context_melee_getScriptedNode");

  if(getdvarint(@ "hash_fa7c16b886c722ed")) {
    return function_d561019e2a68d6cf();
  }

  return level.var_9665e8b8736ff0b7;
}

function enable_stayahead(followent) {
  setdvarifuninitialized(@ "hash_3d6aec1e7192648b", 0);
  disable_stayahead(0, 0);
  waittillframeend();

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    iprintln("<dev string:x143>" + self getentnum());
  }

  thread scripts\sp\stayahead::stayahead_thread(followent);
}

function disable_stayahead(speed, reset) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    iprintln("<dev string:x15c>" + self getentnum());
  }

  if(isDefined(self.stayahead) && isDefined(self.stayahead.using_goto_node)) {
    scripts\sp\stayahead::print3d_debug(self.origin + (0, 0, 8), "Stayahead disabled, going back to go_to_node()", (0, 1, 0), 1, 0.3, 500, 1);
    thread scripts\sp\spawner::go_to_node(scripts\sp\stayahead::get_best_goto_node(self.stayahead.goto_patharray, 2));
  }

  if(isDefined(self.stayahead) && isDefined(self.stayahead.bg_2d)) {
    self.stayahead.bg_2d destroy();
  }

  if(isDefined(self.stayahead) && isDefined(self.stayahead.team)) {
    foreach(guy in self.stayahead.team) {
      guy disable_dynamic_run_speed(speed);
    }
  }

  if(!isDefined(reset) || istrue(reset)) {
    self.stayahead = undefined;
  }

  if(!isDefined(speed)) {
    speed = 165;
  }

  self notify("stop_stayahead");

  if(istrue(speed)) {
    set_movement_speed(speed);
  }
}

function set_stayahead_values(plane, speed, distance, variance) {
  assert(isDefined(plane), "must pass a plane number, 1-5");
  assert(isDefined(speed), "must pass a speed.");
  assert(isDefined(distance), "must pass a distance.");

  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  planevalues["speed"] = speed;
  planevalues["distance"] = distance;

  if(isDefined(variance)) {
    planevalues["variance"] = variance;
  }

  switch (plane) {
    case 1:
      self.stayahead.p1 = planevalues;
      break;
    case 2:
      self.stayahead.p2 = planevalues;
      break;
    case 3:
      self.stayahead.p3 = planevalues;
      break;
    case 4:
      self.stayahead.p4 = planevalues;
      break;
    case #"hash_bdf347744138cb00":
      self.stayahead.pw = planevalues;
      break;
    default:
      assertmsg("Plane value must be number between 1-5, was: " + plane);
      break;
  }
}

function set_stayahead_wait_values(distance, buffer, var_242e84d91f155ae8) {
  set_stayahead_values("wait", 0, distance, 0);
  self.stayahead.pw["buffer"] = buffer;

  if(istrue(var_242e84d91f155ae8)) {
    self.stayahead.use_goto_wait = 1;
  }
}

function stayahead_disable_wait() {
  if(isDefined(self.stayahead)) {
    if(getdvarint(@ "hash_3d6aec1e7192648b")) {
      iprintln("<dev string:x176>" + self getentnum());
    }

    if(isDefined(self.stayahead.goalnode_pw)) {
      goalnode = ter_op(isDefined(self.stayahead.goalnode), self.stayahead.goalnode, self.goalnode);
      childthread scripts\sp\stayahead::stayahead_set_goalnode(goalnode, 0);
    }

    if(isDefined(self.stayahead.pw)) {
      self.stayahead.pw = undefined;
    }
  }
}

function enable_stayahead_turbo(speed) {
  if(!isDefined(self.stayahead)) {
    return;
  }

  if(isDefined(speed)) {
    assertex(speed > 0, "speed must be greater than 0");
  }

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    print_speed = speed;

    if(!isDefined(print_speed)) {
      print_speed = "<dev string:x195>";
    }

    iprintln("<dev string:x19f>" + print_speed);
  }

  self.stayahead.turbo = speed;
}

function set_stayahead_wait_nodes(nodes, var_242e84d91f155ae8) {
  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  if(isDefined(nodes)) {
    assertex(isarray(nodes), "nodes need to be an array!");
    assertex(nodes.size > 0, "nodes array is empty");
    self.stayahead.wait_nodes = nodes;
  }

  if(istrue(var_242e84d91f155ae8)) {
    self.stayahead.use_goto_wait = 1;
  }
}

function set_stayahead_wait_func(func) {
  self.stayahead.wait_func = func;
}

function stayahead_add_to_team(team, frontdist, middist, backdist) {
  if(!isDefined(self.stayahead.team)) {
    self.stayahead.team = [];
  }

  array = [];

  if(!isarray(team)) {
    array[0] = team;
  } else {
    array = team;
  }

  foreach(guy in array) {
    if(!isDefined(guy.stayahead)) {
      guy.stayahead = spawnStruct();
    }

    guy.stayahead.dynamic_frontdist = frontdist;
    guy.stayahead.dynamic_middist = middist;
    guy.stayahead.dynamic_backdist = backdist;
  }

  self.stayahead.team = array_combine(self.stayahead.team, array);
}

function stayahead_pause(bool) {
  if(ent_flag_exist("stayahead_pause")) {
    if(bool) {
      ent_flag_set("stayahead_pause");
    } else {
      ent_flag_clear("stayahead_pause");
    }

    return;
  }

  print("<dev string:x1b9>");
}

function stayahead_set_wait_node_radius(radius) {
  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  self.stayahead.wait_node_radius = radius;
}

function stayahead_lookat_enabled(bool) {
  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  if(istrue(bool)) {
    self.stayahead.lookat_allowed = 1;
    return;
  }

  self.stayahead.lookat_allowed = undefined;
}

function make_weapon(basename, attachments, reticle, camo, lootid, alt_mode, blueprint) {
  if(!isDefined(level._weapons)) {
    level._weapons = spawnStruct();
  }

  if(!isDefined(attachments)) {
    attachments = [];
  }

  if(!isweapon(basename)) {
    tok = strtok(basename, "+");

    if(tok.size > 1) {
      basename = tok[0];
      attachments = array_combine(attachments, array_remove(tok, tok[0]));
    }
  } else {
    if(isnullweapon(basename)) {
      return basename;
    }

    if(isDefined(basename.attachments) && attachments.size == 0 && basename.attachments.size > 0) {
      attachments = basename.attachments;
    }

    basename = getweaponbasename(basename);
  }

  if(getdvarint(@ "hash_4589562a903db3e0") && isstartstr(basename, "<dev string:x1f6>")) {
    print("<dev string:x1fb>" + basename);
  }

  if(istrue(alt_mode)) {
    var_8b5443598fc587bf = &makealtweapon;
  } else {
    var_8b5443598fc587bf = &makeweapon;
  }

  defaults = getweapondefaultattachments(basename);
  defaults = removeconflictingattachments(attachments, defaults, basename);
  attachments = array_combine(attachments, defaults);
  attachment_variants = [];

  foreach(attachment in attachments) {
    if(issubstr(attachment, "|")) {
      attachments = array_remove(attachments, attachment);
      attachments[attachments.size] = strtok(attachment, "|")[0];
      attachment_variants[attachment_variants.size] = attachment;
    }
  }

  attachments = function_cb12b7d7e358890c(basename, attachments, var_8b5443598fc587bf);

  if(isDefined(lootid)) {
    weapon = builtin[[var_8b5443598fc587bf]](basename, attachments, reticle, camo, lootid);
  } else if(isDefined(camo)) {
    weapon = builtin[[var_8b5443598fc587bf]](basename, attachments, reticle, camo);
  } else if(isDefined(reticle)) {
    weapon = builtin[[var_8b5443598fc587bf]](basename, attachments, reticle);
  } else if(isDefined(attachments)) {
    weapon = builtin[[var_8b5443598fc587bf]](basename, attachments);
  } else {
    weapon = builtin[[var_8b5443598fc587bf]](basename);
  }

  foreach(attachment in attachment_variants) {
    tok = strtok(attachment, "|");

    function_cb12b7d7e358890c(basename, [tok[0]], var_8b5443598fc587bf);

    weapon = weapon withattachment(tok[0], int(tok[1]));
  }

  if(isDefined(blueprint)) {
    blueprints = function_3211981142ec5aee(basename, blueprint);
  }

  return weapon;
}

function function_cb12b7d7e358890c(basename, attachments, var_8b5443598fc587bf) {
  weapon = builtin[[var_8b5443598fc587bf]](basename);
  filtered = attachments;

  foreach(attachment in attachments) {
    if(!weapon canuseattachment(attachment)) {
      assertmsg("Weapon: " + basename + " can not use attachment: " + attachment + ". Removing for now!");
      filtered = array_remove(filtered, attachment);
    }
  }

  return filtered;
}

function check_for_blacklisted_attachment() {
  weapon = self;
  blacklist = [];
  blacklist[blacklist.size] = "attachment_wm_silencer01";
  blacklist[blacklist.size] = "attachment_wm_ar_kilo433_stock";
  blacklist[blacklist.size] = "attachment_wm_ar_mike4_receiver";
  blacklist[blacklist.size] = "attachment_wm_ar_mike4_stock";
  blacklist[blacklist.size] = "attachment_wm_ar_mike4_barrel";
  blacklist[blacklist.size] = "attachment_wm_ar_mike4_mag";
  blacklist[blacklist.size] = "attachment_wm_ar_scharlie_receiver";
  blacklist[blacklist.size] = "attachment_wm_ar_scharlie_stock";
  blacklist[blacklist.size] = "attachment_wm_ar_scharlie_barrel";
  blacklist[blacklist.size] = "attachment_wm_ar_scharlie_mag";
  blacklist[blacklist.size] = "attachment_wm_ar_falpha_receiver";
  blacklist[blacklist.size] = "attachment_wm_ar_falpha_barrel";
  blacklist[blacklist.size] = "attachment_wm_ar_falpha_mag";
  blacklist[blacklist.size] = "attachment_wm_ar_falpha_toprail";
  blacklist[blacklist.size] = "attachment_wm_ar_falpha_triggrip";
  blacklist[blacklist.size] = "attachment_wm_sm_mpapa5_reciever";
  blacklist[blacklist.size] = "attachment_wm_sm_mpapa5_stock";
  blacklist[blacklist.size] = "attachment_wm_sm_mpapa5_barrel";
  blacklist[blacklist.size] = "attachment_wm_sm_mpapa5_mag";
  blacklist[blacklist.size] = "attachment_wm_sm_papa90_receiver";
  blacklist[blacklist.size] = "attachment_wm_sm_papa90_barrel";
  blacklist[blacklist.size] = "attachment_wm_sm_papa90_mag";
  blacklist[blacklist.size] = "attachment_wm_sh_dpapa12_receiver";
  blacklist[blacklist.size] = "attachment_wm_sh_dpapa12_ammo";
  blacklist[blacklist.size] = "attachment_wm_sh_dpapa12_pump";
  blacklist[blacklist.size] = "attachment_wm_lm_kilo121_receiver";
  blacklist[blacklist.size] = "attachment_wm_lm_kilo121_stock";
  blacklist[blacklist.size] = "attachment_wm_lm_kilo121_barrel";
  blacklist[blacklist.size] = "attachment_wm_lm_kilo121_mag";
  blacklist[blacklist.size] = "attachment_wm_sn_mike14_receiver";
  blacklist[blacklist.size] = "attachment_wm_sn_mike14_stock";
  blacklist[blacklist.size] = "attachment_wm_sn_mike14_barrel";
  blacklist[blacklist.size] = "attachment_wm_sn_mike14_mag";
  blacklist[blacklist.size] = "attachment_wm_sn_mike14_stock";
  blacklist[blacklist.size] = "attachment_wm_sn_kilo98_receiver";
  blacklist[blacklist.size] = "attachment_wm_sn_kilo98_barrel";
  blacklist[blacklist.size] = "attachment_wm_pi_golf21_receiver";
  blacklist[blacklist.size] = "attachment_wm_pi_golf21_mag";
  blacklist[blacklist.size] = "attachment_wm_pi_golf21_slide";
  blacklist[blacklist.size] = "attachment_wm_pi_mike1911_v1_receiver";
  blacklist[blacklist.size] = "attachment_wm_pi_mike1911_v1_mag";
  blacklist[blacklist.size] = "attachment_wm_pi_mike1911_v1_slide";
  blacklist[blacklist.size] = "attachment_wm_pi_decho_receiver";
  blacklist[blacklist.size] = "attachment_wm_pi_decho_mag";
  blacklist[blacklist.size] = "attachment_wm_pi_decho_slide";
  blacklist[blacklist.size] = "attachment_wm_pi_decho_grip";
  blacklist[blacklist.size] = "weapon_wm_la_mike32";
  blacklist[blacklist.size] = "weapon_vm_me_soscar_knife";
  attachments = array_reverse(getweaponattachments(weapon));
  attachment_models = getweaponattachmentworldmodels(weapon);

  foreach(model in attachment_models) {
    if(isDefined(array_find(blacklist, model))) {
      assertmsg(model + " is not marketing approved.REMOVING, Find another attachment");
      weapon = self withoutattachment(attachments[i]);
    }
  }

  return weapon;
}

function give_weapon(weapon, model_variant, dual_wield, var_7c28c5d814dcfd9, used_before) {
  if(isstring(weapon)) {
    weapon = make_weapon(weapon);
  }

  if(isDefined(used_before)) {
    self giveweapon(weapon, model_variant, dual_wield, var_7c28c5d814dcfd9, used_before);
    return;
  }

  if(isDefined(var_7c28c5d814dcfd9)) {
    self giveweapon(weapon, model_variant, dual_wield, var_7c28c5d814dcfd9);
    return;
  }

  if(isDefined(dual_wield)) {
    self giveweapon(weapon, model_variant, dual_wield);
    return;
  }

  if(isDefined(model_variant)) {
    self giveweapon(weapon, model_variant);
    return;
  }

  self giveweapon(weapon);
}

function take_weapon(weapon) {
  self takeweapon(weapon);
}

function function_df81045786886808(basename) {
  weaponslist = self getweaponslistall();

  foreach(weapon in weaponslist) {
    if(weapon.basename == basename) {
      take_weapon(weapon);
    }
  }
}

function function_7b79994f52c60a82(weapon) {
  if(isweapon(weapon)) {
    take_weapon(weapon);
    return;
  }

  function_df81045786886808(weapon);
}

function make_weapon_special(weapon, basename, blueprint) {
  if(isDefined(basename)) {
    weapon = make_weapon(basename, undefined, undefined, undefined, undefined, undefined, blueprint);
  } else {
    assertex(isDefined(weapon), "Must specify a string/weapon");

    switch (weapon) {
      case #"hash_a88777756f97cf76":
        weapon = make_weapon("iw9_ar_akilo_sp", ["bar_ar_hvyshort_p04_akilo|1", "mag_ar_p04_akilo|1", "pgrip_aim_p04|1", "rec_akilo|1", "reflex03_tall|1", "stock_ar_light_p04_akilo|1"]);
        break;
      case #"hash_7384f86a3bead6fc":
        weapon = make_weapon("iw9_ar_mcharlie_sp", ["bar_ar_short_p08|1", "flash_ar_01|1", "grip_vertshort06|1", "hybrid02|1", "iw9_rec_mcharlie|1", "mag_ar_p08|1", "pgrip_ar_p08|1", "stock_sm_p08|1"]);
        break;
      case #"hash_7384fb6a3beadbb5":
        weapon = make_weapon("iw9_ar_mcharlie_sp", ["bar_ar_short_p08|1", "grip_angled01", "holo01", "iw9_rec_mcharlie|1", "mag_ar_p08|1", "pgrip_ar_p08|1", "stock_sm_p08|1"]);
        break;
      case #"hash_82da119871695927":
        weapon = make_weapon("iw9_ar_mcbravo_sp", ["ammo_blk", "bar_ar_light_p08|1", "grip_vertshort03|1", "iw9_selectsemi", "lasercyl_ads01|2", "mag_ar_heavy_p08|1", "pgrip_ar2_p08", "rec_mcbravo|1", "reflex07_tall|1", "stock_ar_tactical_p08|2"]);
        break;
      case #"hash_a90e98e5492a71d":
        weapon = make_weapon("iw9_ar_mike4_sp", ["ammo_556n", "bar_ar_short_p01_mike4|2", "grip_vert02|1", "iw9_rec_mike4|1", "selectsemi_mike4", "laserbox_ads01|1", "mag_ar_p01|1", "pgrip_p01|2", "reflex02_tall|2", "silencer07_ar|1", "stock_ar_p01_mike4|4"]);
        break;
      case #"hash_a90e18e54929a85":
        weapon = make_weapon("iw9_ar_mike4_sp", ["ammo_556n", "bar_ar_short_p01_mike4|3", "grip_angled01|3", "hybridtherm01|1", "iw9_rec_mike4|3", "selectsemi_mike4", "mag_ar_p01|3", "pgrip_p01|3", "silencer03_ar_p01|2", "stock_ar_p01_mike4|5"]);
        break;
      case #"hash_7e14216d4a2f0ab0":
        weapon = make_weapon("iw9_dm_mike14_sp", ["ammo_762n", "arscope_vz02|1", "bar_dm_p18_mike14|1", "grip_vertshort03|2", "iw9_rec_mike14|1", "mag_sn_large_p18|1", "pgrip_dm_p18|1", "stock_dm_light_p18|1"]);
        break;
      case #"hash_acdc2a1d86f0e9ac":
        weapon = make_weapon("iw9_dm_xmike2010_sp", ["ammo_300wm", "bar_sn_light_p20_xmike2010|1", "bipod01|3", "bolt_p20|1", "mike24_scope|1", "pgrip_p20_xmike2010", "rec_xmike2010|1", "stock_sn_heavy_p20|1"]);
        break;
      case #"hash_75807ca5dc84c05e":
        weapon = make_weapon("iw9_sn_alpha50_sp", ["bar_sn_p23|1", "dmscope_therm01|1", "mag_sn_p23|1", "rec_alpha50|1", "silencer04_sn|1", "stock_sn_assault_p23|1"]);
        break;
      case #"hash_4fcc51ce5cf3bff6":
        weapon = make_weapon("iw9_sn_mromeo_sp", ["ammo_300nm", "bar_sn_p21|1", "bipod01|1", "bolt_p21|1", "mag_sn_large_p21|1", "pgrip_p21|1", "rec_mromeo|1", "silencer03_dm|1", "stock_sn_heavy_p21|1", "vzscope_mromeo|1"]);
        break;
      case #"hash_4fcc56ce5cf3c7d5":
        weapon = make_weapon("iw9_sn_mromeo_sp", ["ammo_300nm_intercept", "bar_sn_p21|2", "bolt_p21|2", "dmscope_therm01_intercept|2", "laserbox_ads01|2", "mag_sn_p21|2", "pgrip_p21|2", "rec_mromeo|4", "silencer01_dm_intercept|1", "sp_intercept_sniper", "stock_sn_p21|1"]);
        break;
      default:
        println("<dev string:x23f>" + weapon + "<dev string:x248>");
        weapon = undefined;
        break;
    }
  }

  return weapon;
}

function function_e59f7849726ad730(weaponname, oldweaponstring, newweaponstring) {
  oldweapons = getEntArray(oldweaponstring, "code_classname");

  foreach(oldweapon in oldweapons) {
    newweapon = spawn(newweaponstring, oldweapon.origin, oldweapon.spawnflags);
    newweapon.angles = oldweapon.angles;
    newweapon.targetname = oldweapon.targetname;
    newweapon scripts\anim\shared::setscriptammo(weaponname, oldweapon, undefined);

    level.placedweapons = array_remove(level.placedweapons, oldweapon);
    level.placedweapons = array_add(level.placedweapons, newweapon);

    oldweapon delete();
  }
}

function aim_at(origin, laser_state, laser_tag, aim_time) {
  self notify("stop_aiming");
  self endon("stop_aiming");
  self endon("death");

  if(!isDefined(origin)) {
    origin = self localtoworldcoords((150, 0, 30));
  }

  if(!isDefined(laser_state)) {
    laser_state = 0;
  }

  if(!isDefined(aim_time)) {
    aim_time = 1.5;
  }

  self.aim_target = spawn_script_origin();
  self.aim_target.origin = self gettagorigin("tag_flash") + anglesToForward(self gettagangles("tag_flash")) * 50;
  childthread internal_aim_occlusion_override();
  self setentitytarget(self.aim_target);
  self.aim_target moveTo(origin, aim_time, 0.01, 0.01);

  thread debug_aiming();

  wait aim_time * 0.5;

  if(laser_state > 0) {
    thread aim_at_laser_on(laser_state, laser_tag);
  }

  wait aim_time * 0.5;
}

function internal_aim_occlusion_override() {
  self.suppress_uselastenemysightpos = 1;
  self.dontgiveuponsuppression = 1;
  self.forcesuppressai = 1;

  while(true) {
    self.lastenemysightpos = self.aim_target.origin;
    waitframe();
  }
}

function internal_aim_at_laser_tracker() {
  while(true) {
    waittillframeend();
    var_a04ea954c347f6d6 = self gettagorigin(self.aim_laser.tag);
    self.aim_laser dontinterpolate();
    self.aim_laser.origin = var_a04ea954c347f6d6;
    self.aim_laser.angles = vectortoangles(self.aim_target.origin - var_a04ea954c347f6d6);
    waitframe();
  }
}

function createaiment(team, org, ang, expendable) {
  ent = spawn_script_origin(org, ang);
  ent.health = 1;
  ent makeentitysentient(team, expendable);
  return ent;
}

function is_aiming() {
  return isDefined(self.aim_target);
}

function aim_at_laser_on(laser_state, laser_tag) {
  self endon("laser_off");
  self endon("death");
  assertex(isDefined(self.aim_target), "Must call entity aim_at() before using aim_at_laser_on()");

  if(laser_state != 0) {
    if(!isDefined(laser_tag)) {
      laser_tag = "tag_laser";
    }

    self.aim_laser = spawn("script_model", self gettagorigin(laser_tag));
    self.aim_laser setModel("tag_laser");
    self.aim_laser setmoverlaserweapon(self.weapon);
    self.aim_laser.tag = laser_tag;

    if(laser_state == 1) {
      self.aim_laser laseron();
    } else {
      self.aim_laser laserforceon();
    }

    self.aim_laser.laser_state = laser_state;
    internal_aim_at_laser_tracker();
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
  }
}

function move_aim_to(origin, time, acceleration_time, deceleration_time) {
  self endon("death");
  self endon("stop_aiming");

  if(!isDefined(acceleration_time)) {
    acceleration_time = 0.05;
  }

  if(!isDefined(deceleration_time)) {
    deceleration_time = 0.05;
  }

  assertex(isDefined(self.aim_target), "Must enable aiming with aim_at() before moving aim");
  self.aim_target moveTo(origin, time, acceleration_time, deceleration_time);
  wait time;
}

function link_aim_to(ent, tag, origin_offset) {
  self endon("stop_aiming");
  self endon("death");
  assertex(isDefined(self.aim_target), "Must enable aiming with aim_at() before linking aim");

  if(!isDefined(tag)) {
    tag = "tag_origin";
  }

  if(isDefined(origin_offset)) {
    self.aim_target linkTo(ent, tag, origin_offset, (0, 0, 0));
    return;
  }

  self.aim_target linkTo(ent, tag);
}

function move_aim_to_enemy(enemy, tag, acquire_time, var_dc102d0a3fa40d6c, var_3c6327d2dc93eeb9, enable_debug) {
  assertex(isDefined(self.aim_target), "Must enable aiming with aim_at() before moving aim");
  self endon("stop_aiming");
  self endon("death");
  enemy endon("death");

  if(!isDefined(tag)) {
    tag = "tag_origin";
  }

  if(!isDefined(acquire_time)) {
    acquire_time = 3;
  }

  if(!isDefined(var_dc102d0a3fa40d6c)) {
    var_dc102d0a3fa40d6c = 50;
  }

  if(!isDefined(var_3c6327d2dc93eeb9)) {
    var_3c6327d2dc93eeb9 = 1;
  }

  if(!isDefined(enable_debug)) {
    enable_debug = 0;
  }

  var_12ad39f0f512b167 = enemy gettagorigin(tag);
  noise_offset = var_dc102d0a3fa40d6c;
  var_f9803f210f99196a = enemy.origin;
  var_2c0637398aff5042 = var_dc102d0a3fa40d6c / acquire_time;
  start_speed = distance(self.aim_target.origin, var_12ad39f0f512b167) / acquire_time;

  while(distancesquared(self.aim_target.origin, enemy gettagorigin(tag)) > 5) {
    delta_time = 0.05;

    if(randomfloat(100) > 50) {
      noise_vec = enemy localtoworldcoords((0, 0, noise_offset));
    } else {
      noise_vec = enemy localtoworldcoords((0, 0, noise_offset * -1));
    }

    final_destination = noise_vec - enemy.origin + enemy gettagorigin(tag);
    var_f6101d58d76925eb = self.aim_target.origin;
    enemy_speed = length(enemy.origin - var_f9803f210f99196a) / delta_time;
    speed = enemy_speed + start_speed;
    direction = vectorNormalize(final_destination - var_f6101d58d76925eb);
    velocity = direction * speed * delta_time;

    if(enable_debug) {
      thread draw_angles((0, 0, 0), final_destination);
      line(var_f6101d58d76925eb, var_f6101d58d76925eb + direction, (0, 1, 0));
      line(var_f6101d58d76925eb + direction, final_destination, (1, 0, 0));
    }

    noise_offset -= var_2c0637398aff5042 * delta_time;
    noise_offset = clamp(noise_offset, 0, var_dc102d0a3fa40d6c);
    var_f9803f210f99196a = enemy.origin;
    move_aim_to(var_f6101d58d76925eb + velocity, delta_time, 0.001, 0.001);
  }

  if(var_3c6327d2dc93eeb9) {
    self.aim_target.origin += vectorNormalize(self gettagorigin("tag_flash") - self.aim_target.origin) * 20;
    link_aim_to(enemy, tag);
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

  self.suppress_uselastenemysightpos = 0;
  self.dontgiveuponsuppression = undefined;
  self.forcesuppressai = 0;
  self.lastenemysightpos = undefined;
}

function move_aim_along_spline(start_struct, var_fc410ce8bf19dac9) {
  self endon("stop_aiming");
  self endon("death");
  assertex(isDefined(self.aim_target), "Must enable aiming with aim_at() before moving aim");
  assertex(isDefined(start_struct), "Must pass in starting struct in spline to move_aim_along_spline()");
  assertex(isDefined(var_fc410ce8bf19dac9), "Must pass in how long to aim along spline to move_aim_along_spline()");
  spline_dist = 0;

  for(current_struct = start_struct; isDefined(current_struct.target); current_struct = current_struct.next) {
    current_struct.next = getStruct(current_struct.target, "targetname");
    current_struct.dist_to_next = distance(current_struct.next.origin, current_struct.origin);
    spline_dist += current_struct.dist_to_next;
  }

  for(current_struct = start_struct; isDefined(current_struct.target); current_struct = current_struct.next) {
    aim_time = current_struct.dist_to_next / spline_dist * var_fc410ce8bf19dac9;
    move_aim_to(current_struct.next.origin, aim_time);
  }
}

function aim_search_around(var_eb0c52046ed75b79, var_3dce490e575954cb, var_c1c6436496d9b6e8, var_4af84bd7b4e025ca) {
  self endon("stop_aiming");
  self endon("stop_searching");
  self endon("death");

  if(!isDefined(var_eb0c52046ed75b79)) {
    var_eb0c52046ed75b79 = -15;
  } else {
    var_eb0c52046ed75b79 *= -1;
    var_eb0c52046ed75b79 = clamp(var_eb0c52046ed75b79, -30, 30);
  }

  if(!isDefined(var_3dce490e575954cb)) {
    var_3dce490e575954cb = 15;
  } else {
    var_3dce490e575954cb *= -1;
    var_3dce490e575954cb = clamp(var_3dce490e575954cb, -30, 30);
  }

  if(!isDefined(var_c1c6436496d9b6e8)) {
    var_c1c6436496d9b6e8 = 45;
  } else {
    var_c1c6436496d9b6e8 = clamp(var_c1c6436496d9b6e8, -90, 90);
  }

  if(!isDefined(var_4af84bd7b4e025ca)) {
    var_4af84bd7b4e025ca = -45;
  } else {
    var_4af84bd7b4e025ca = clamp(var_4af84bd7b4e025ca, -90, 90);
  }

  thread debug_aiming();

  while(true) {
    if(randomfloat(100) > 50) {
      vert_angle = var_3dce490e575954cb;
    } else {
      vert_angle = var_eb0c52046ed75b79;
    }

    if(randomfloat(100) > 50) {
      horiz_angle = var_4af84bd7b4e025ca;
    } else {
      horiz_angle = var_c1c6436496d9b6e8;
    }

    deltatime = 0.05;
    time_elapsed = 0;
    search_target = self.aim_target.origin;

    while(time_elapsed < 4) {
      muzzle_height = self gettagorigin("tag_flash")[2];

      if(length(self.velocity) > 0) {
        check_angles = vectortoangles(self.velocity);
      } else {
        check_angles = self.angles;
      }

      search_angles = check_angles + (vert_angle, horiz_angle, 0);
      search_vector = anglesToForward(search_angles) * 75;
      search_start = (self.origin[0], self.origin[1], muzzle_height);
      search_target = search_start + search_vector;

      if(getdvarint(@ "hash_500912e607f2c429")) {
        thread draw_angles(search_angles, search_target, (0, 0, 1), 1, 10);
      }

      var_bd6328b6f6b2add8 = search_target - self.aim_target.origin;
      var_1db13f6a6eb165a9 = length(var_bd6328b6f6b2add8);
      var_a2b39965224cb294 = vectorNormalize(var_bd6328b6f6b2add8);
      var_f8e3f290a434df80 = var_1db13f6a6eb165a9 / (4 - time_elapsed);
      var_3d4f8d9283542d92 = var_a2b39965224cb294 * var_f8e3f290a434df80 + self.velocity;
      move_aim_to(self.aim_target.origin + var_3d4f8d9283542d92 * deltatime, deltatime, 1e-05, 1e-05);
      time_elapsed += deltatime;
    }

    self.aim_target.origin = search_target;
  }
}

function stop_aim_search_around() {
  self notify("stop_searching");
}

function debug_aiming() {
  self endon("<dev string:x258>");
  setdvarifuninitialized(@ "hash_500912e607f2c429", 0);

  while(true) {
    if(getdvarint(@ "hash_500912e607f2c429")) {
      self.aim_target childthread draw_ent_axis();
      childthread draw_line_for_time(self gettagorigin("<dev string:x264>"), self.aim_target.origin, 1, 0, 0, 0.05);

      if(isDefined(self.aim_laser)) {
        dist = distance(self.aim_laser.origin, self.aim_target.origin);
        childthread draw_line_for_time(self.aim_laser.origin, self.aim_laser.origin + anglesToForward(self.aim_laser.angles) * dist, 0, 1, 0, 0.05);
      }
    }

    waitframe();
  }
}

function userskip_wait() {
  skipflag = "userskipped";
  stopflag = "stop_userskip";
  flags = [skipflag, stopflag];

  while(gettime() < 450) {
    waitframe();
  }

  foreach(flag in flags) {
    flag_clear(flag);
  }

  setomnvar("ui_is_bink_skippable", 1);
  thread function_89b8c82bc3bfa83d();
  thread userskip_input();

  while(!flag(stopflag) && !flag(skipflag)) {
    waitframe();
  }

  setomnvar("ui_is_bink_skippable", 0);
  level notify("stop_userskip_input_thread");
  return flag(skipflag);
}

function function_89b8c82bc3bfa83d() {
  self endon("stop_userskip");
  flag_wait("userskipped");
  clearmusicstate();
  level.player setsoundsubmix("jup_global_igc_skip", 1);
  function_adfd4002c83fe6b2("voiceover", 0, 2);
  flag_wait("stop_userskip");

  if(iscinematicplaying()) {
    level.player clearsoundsubmix("jup_global_igc_skip", 1);
    return;
  }

  wait 60;
  level.player clearsoundsubmix("jup_global_igc_skip", 1);
}

function userskip_input() {
  level endon("stop_userskip_input_thread");

  while(true) {
    level.player waittill("luinotifyserver", message, value);

    if(message == "skip_bink_input") {
      flag_set("userskipped");
      break;
    }
  }
}

function userskip_stop() {
  flag_set("stop_userskip");
}

function function_d4697f18fc3ff634() {
  level.player clearclienttriggeraudiozone(0.1);
  level.player stopsoundchannel("scn_igc_unres_2d");
  level.player stopsoundchannel("scn_igc_lfe_unres_2d");
}

function get_adjusted_difficulty() {
  return scripts\sp\gameskill::auto_adjust_difficult_get();
}

function civilianfailwrapper(deathquotearray, mindamage, playerdistance, ignoresplash) {
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

  if(!isDefined(distance)) {
    distance = "<dev string:x26e>";
  } else {
    distance = sqrt(distance);
  }

  if(!isDefined(meansofdeath)) {
    print("<dev string:x277>" + damage + "<dev string:x28d>" + distance);
  } else {
    print("<dev string:x277>" + damage + "<dev string:x28d>" + distance + "<dev string:x294>" + meansofdeath);
  }

  level thread scripts\sp\hud_util::fade_out(0);
  scripts\sp\player_death::set_custom_death_quote(array_randomize(deathquotearray)[0]);
  missionfailedwrapper();
}

function get_mount_activation_mode() {
  if(self usinggamepad()) {
    var_53cf7906631431b8 = self getlocalplayerprofiledata("mountButtonConfig");
  } else {
    var_53cf7906631431b8 = self getlocalplayerprofiledata("mountButtonConfigKBM");
  }

  switch (var_53cf7906631431b8) {
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

  assertmsg("Mount activation mode " + var_53cf7906631431b8 + " is not supported by get_mount_activation_mode(). Please update the function or remove the enum.");
}

function function_2624fca3e73f715e(player) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x29a>");
    return false;
  }

  if(player usinggamepad()) {
    return (player getlocalplayerprofiledata("toggleADSEnabledGamepad") != 1);
  }

  return player getlocalplayerprofiledata("toggleADSEnabledKeyboard") != 1;
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

function door_ai_allowed(bool) {
  assertex(isDefined(bool), "Must pass true/false.");
  self.lockedforai = !bool;

  if(bool) {
    thread scripts\sp\door::clear_navobstacle();
    return;
  }

  thread scripts\sp\door::create_navobstacle();
}

function door_force_open_fully(opener, time) {
  scripts\game\sp\door::remove_door_snake_cam_ability();
  scripts\sp\door::remove_open_ability();
  scripts\sp\door::door_open_completely(opener, time);
}

function nvidiaansel_scriptdisable(val) {
  if(nvidiaanselisenabled()) {
    setsaveddvar(@ "hash_941ecb757e3d818e", val);
  }
}

function nvidiaansel_allowduringcinematic(val) {
  if(nvidiaanselisenabled()) {
    setsaveddvar(@ "hash_61b4cc96f32bdef8", val);
  }
}

function nvidiaansel_overridecollisionradius(val) {
  if(nvidiaanselisenabled()) {
    setsaveddvar(@ "hash_3e148a07c591f341", val);
  }
}

function is_trials_level() {
  if(!isDefined(level.istrialslevel)) {
    level.istrialslevel = string_starts_with(level.script, "trials_");
  }

  return level.istrialslevel;
}

function weapon_empty(weaponobject) {
  if(!isDefined(weaponobject)) {
    return 1;
  }

  if(isnullweapon(weaponobject)) {
    return 1;
  }

  return is_equal(weaponobject.basename, "none");
}

function function_1ca6c8af36b17b0f() {
  return weapon_empty(level.player.currentweapon);
}

function function_9e18f54b324ae950(weaponbasename) {
  if(function_1ca6c8af36b17b0f()) {
    return false;
  }

  if(level.player.currentweapon.basename == weaponbasename) {
    return true;
  }

  return false;
}

function function_986696f61c278b49(offhandbasename) {
  offhandtype = scripts\sp\equipment\offhands::getweaponoffhandtype(offhandbasename);
  return is_equal(level.player getcurrentoffhand(offhandtype).basename, offhandbasename);
}

function function_b877cff8b7533624() {
  return level.player isthrowinggrenade() || level.player isthrowingbackgrenade();
}

function function_6063fcf0386f0c4(string) {
  integer = undefined;

  while(true) {
    level.player waittill("luinotifyserver", notification, integer);

    if(notification == string) {
      break;
    }
  }

  return integer;
}

function function_353f16f0014a5e30() {
  level.player endon("death");

  while(true) {
    if(function_ebf6c163be94738a()) {
      function_d5ab926594e0b3f3(1);
      wait 0.3;
      continue;
    }

    function_d5ab926594e0b3f3(0);
    wait 0.3;
  }
}

function function_ebf6c163be94738a() {
  assertex(isDefined(level.foliagecontent), "Script expects there to be a predefined value of level.foliageContent in this level.");

  if(level.player getstance() == "stand") {
    return false;
  }

  if(!trace::sphere_trace_passed(level.player getEye(), level.player getEye() - (0, 0, 15), 20, undefined, level.foliagecontent)) {
    return true;
  }

  return false;
}

function function_d5ab926594e0b3f3(shoulddisplay) {
  if(getomnvar("ui_display_foliage_vignette") != shoulddisplay) {
    setomnvar("ui_display_foliage_vignette", shoulddisplay);
  }
}

function function_1a9f269761ab7db1(struct, var_bf15456a31fe0d35) {
  armorvestinteract = undefined;

  if(isstring(struct)) {
    armorvestinteract = getStruct(struct, "targetname");
  } else if(isstruct(struct)) {
    armorvestinteract = struct;
  }

  assertex(isDefined(armorvestinteract), "Must pass in an existing struct or targetname");
  model = spawn_model("props_armor_pickup_light", armorvestinteract.origin, armorvestinteract.angles);

  if(!isDefined(var_bf15456a31fe0d35)) {
    var_bf15456a31fe0d35 = &"SHARED_HINTSTRINGS/PICKUP_ARMOR_VEST";
  }

  armorvestinteract cursor_hint::create_cursor_hint(undefined, (0, 0, 6), var_bf15456a31fe0d35, 180, 150, 90, undefined, undefined, undefined, undefined, "duration_short", undefined, undefined, 180);
  armorvestinteract thread function_3d10fd7b256e701e(model);
}

function private function_3d10fd7b256e701e(armormodel) {
  self waittill("trigger");
  level.player function_fef4d6151e091533();
  level.player notify("armor_pickup");

  if(soundexists("loot_pickup_armor")) {
    level.player playSound("loot_pickup_armor");
  }

  level.player player_gesture_force("iw9_ges_pickup");
  armormodel delete();
}

function function_fef4d6151e091533() {
  setsaveddvar(@ "bg_piggybackarmoronnvg", 1);
  currentplatecount = player::function_e636201766496e1();
  newplatecount = 1;

  if(currentplatecount >= 1) {
    newplatecount = currentplatecount + 1;
  }

  self.armor.plates = newplatecount;
  self.armor.maxplates = 3;
  player::function_e9e42cffedaa98d5(newplatecount);
  player::give_player_max_armor();
}

function function_eb4400096efae0a7(struct, var_bf15456a31fe0d35) {
  armorplateinteract = undefined;

  if(isstring(struct)) {
    armorplateinteract = getStruct(struct, "targetname");
  } else if(isstruct(struct)) {
    armorplateinteract = struct;
  }

  assertex(isDefined(armorplateinteract), "Must pass in an existing struct or targetname");
  model = spawn_model("lm_loot_wm_armor_plate_iw9_carbon_fiber", armorplateinteract.origin, armorplateinteract.angles);

  if(!isDefined(var_bf15456a31fe0d35)) {
    var_bf15456a31fe0d35 = &"SHARED_HINTSTRINGS/ARMOR_PLATE_PICKUP";
  }

  armorplateinteract cursor_hint::create_cursor_hint(undefined, (0, 0, 6), var_bf15456a31fe0d35, 180, 160, 110, undefined, undefined, undefined, undefined, "duration_short", undefined, undefined, 180);
  armorplateinteract thread function_8583464c18c2f63a(model, var_bf15456a31fe0d35);
}

function private function_8583464c18c2f63a(armormodel, var_bf15456a31fe0d35) {
  level.player endon("death");
  self endon("death");

  while(true) {
    self waittill("trigger");

    if(!level.player function_7315d3ac734d11f()) {
      display_hint_forced("full_plates", 2);
      cursor_hint::create_cursor_hint(undefined, (0, 0, 6), var_bf15456a31fe0d35, 180, 160, 110, undefined, undefined, undefined, undefined, "duration_short", undefined, undefined, 180);
      continue;
    }

    level.player notify("armor_pickup");

    if(soundexists("loot_pickup_armor")) {
      level.player playSound("loot_pickup_armor");
    }

    level.player player_gesture_force("iw9_ges_pickup");
    armormodel delete();
  }
}

function function_7315d3ac734d11f() {
  currentplatecount = player::function_e636201766496e1();

  if(currentplatecount >= 3) {
    return false;
  }

  player::function_e9e42cffedaa98d5(currentplatecount + 1);
  return true;
}

function function_e151438c44c81414() {
  println("<dev string:x2ca>");

  while(!isDefined(level.player)) {
    waitframe();
  }

  var_f20970ea949bc843 = "sandboxInventoryData";
  sandboxloadoutdata = "sandboxLoadoutData";
  sandboxmissions = ["cp_jup_port", "cp_jup_chemical", "cp_jup_ranch", "cp_jup_resort", "cp_jup_apt", "cp_jup_dam"];
  var_4b3db997f0b29c9 = [128, 350, 64, 128, 128, 128];
  level.player setprogressiondata("spProgData", "cp_jup_parachute_activated", 0);
  level.player setprogressiondata("sandboxLastCheckpointData", "last_checkpoint_map", "");
  level.player setprogressiondata("sandboxLastCheckpointData", "last_checkpoint", "");

  for(j = 0; j < sandboxmissions.size; j++) {
    currentmission = sandboxmissions[j];

    for(i = 0; i < 40; i++) {
      level.player setprogressiondata(var_f20970ea949bc843, currentmission, "SboxItems", i, "unlockState", 0);
      level.player setprogressiondata(var_f20970ea949bc843, currentmission, "SboxItems", i, "isNewUnlock", 0);
    }

    level.player setprogressiondata(sandboxloadoutdata, currentmission, "lethalGrenade", 0);
    level.player setprogressiondata(sandboxloadoutdata, currentmission, "primaryWeapon", 0);
    level.player setprogressiondata(sandboxloadoutdata, currentmission, "secondaryWeapon", 0);
    level.player setprogressiondata(sandboxloadoutdata, currentmission, "tacticalGrenade", 0);
    level.player setprogressiondata(sandboxloadoutdata, currentmission, "fieldEquipment", 0);

    for(i = 0; i < 16; i++) {
      level.player setprogressiondata("sandboxMissionObjectiveData", currentmission, "objective_" + i, 0);
    }

    level.player setprogressiondata("spProgData", currentmission + "_attempts", 0);
    level.player setprogressiondata("spProgData", currentmission + "_should_show_loadout", 0);
    level.player setprogressiondata("spProgData", currentmission + "_successes", 0);
    level.player setprogressiondata("spProgData", currentmission + "_ascender_tool", 0);
    level.player setprogressiondata("spProgData", currentmission + "_nvg", 0);
    level.player setprogressiondata("spProgData", currentmission + "_checkpoint_id", 0);
    level.player setprogressiondata("spProgData", currentmission + "_plate_level", 1);

    for(i = 0; i < 16; i++) {
      level.player setprogressiondata("spProgData", currentmission + "_map_unlocks", i, 0);
    }

    for(i = 0; i < 4; i++) {
      level.player setprogressiondata("spProgData", currentmission + "_ks_unlocks", i, 0);
    }

    for(i = 0; i < var_4b3db997f0b29c9[j]; i++) {
      level.player setprogressiondata("spProgData", currentmission + "_discoverables", i, 0);
    }

    for(i = 0; i < 25; i++) {
      level.player setprogressiondata("spProgData", currentmission + "_plate_carriers", i, 0);
    }

    for(i = 0; i < 8096; i++) {
      level.player setprogressiondata("fogOfWarData", "fogOfWarMapData", currentmission, "tilesDiscovered", i, 0);
    }
  }
}