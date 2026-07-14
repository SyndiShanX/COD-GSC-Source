/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\utility.gsc
**************************************/

#using scripts\anim\combat_utility;
#using scripts\anim\shared;
#using scripts\anim\utility;
#using scripts\common\ai;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\game\sp\door;
#using scripts\sp\analytics;
#using scripts\sp\autosave;
#using scripts\sp\door;
#using scripts\sp\endmission;
#using scripts\sp\equipment\offhands;
#using scripts\sp\gameskill;
#using scripts\sp\hud_util;
#using scripts\sp\nvg\nvg_ai;
#using scripts\sp\player;
#using scripts\sp\player\cursor_hint;
#using scripts\sp\player_death;
#using scripts\sp\scripted_weapon_assignment;
#using scripts\sp\spawner;
#using scripts\sp\stayahead;
#namespace utility_sp;

function function_3b15dd94a903733a(var_8b854e679a79aef4) {
  trigs = function_6c85388f1d4ab3f5();

  if(!trigs.size) {
    return undefined;
  }

  temp = [];
  trigflag = undefined;

  foreach(trig in trigs) {
    trigflag = trig get_trigger_flag();

    if(trigflag == var_8b854e679a79aef4) {
      temp[temp.size] = trig;
    }
  }

  assert(temp.size == 1, "<dev string:x24>" + var_8b854e679a79aef4);
  return temp[0];
}

function function_671ca23eedbea0e5(var_8b854e679a79aef4) {
  trigs = function_6c85388f1d4ab3f5();

  if(!trigs.size) {
    return undefined;
  }

  temp = [];
  trigflag = undefined;

  foreach(trig in trigs) {
    trigflag = trig get_trigger_flag();

    if(trigflag == var_8b854e679a79aef4) {
      temp[temp.size] = trig;
    }
  }

  return temp;
}

function private function_6c85388f1d4ab3f5() {
  trigs = getEntArray("t\xe4K\xec;\x95r\xeb\xad\xeac\xd1-\a\xb1+\xbe\x996\x85\xec\xd7\xdcV\x8e", #classname);
  moretrigs = getEntArray("\x1d\xe4i\xd9\xd9V\x93}\xb6uc\xa3\xa5\a\x8d+\xaf\x99l\x16g\xf5\x9b\xca\xd1_\x1d{\xae\xb1\x1aing", #classname);
  trigs = utility::array_combine(trigs, moretrigs);
  moretrigs = getEntArray("\xa3N\x96\xb3\xec+r\xeb\xb6]c\x1d\xa5\x83\xb1\xac\xf53lX\xd9_\xd8\xed\xbdkK\xcdg", #classname);
  trigs = utility::array_combine(trigs, moretrigs);
  moretrigs = getEntArray("\xe6\xf1`,\xfeP\xdf_d\":\xd4#\b\x82_+\x9a-\xa3\xfd\xdd\x16ct\xf39\xa7", #classname);
  trigs = utility::array_combine(trigs, moretrigs);
  return trigs;
}

function delete_live_grenades() {
  self notify("\xc1\x93\xa6\xaf\x8f\xa1iH\x1dG\xa2\xc7\xe6\xd2\xb6\xfa");
  self endon("\xc1\x93\xa6\xaf\x8f\xa1iH\x1dG\xa2\xc7\xe6\xd2\xb6\xfa");
  level.player endon("2ecV\xa3\xb2}\xc6\xd2v\x95}g\xc9\xcan\xb0de\xcd\xaf\x851\xedr:");
  allnades = getEntArray(",\xe1\x93So\x98\r", #classname);

  foreach(nade in allnades) {
    if(!isDefined(nade.targetname) && nade.model != "p\x9c{M\xb2cG\xb4\xc6+\xd7[o\x1boG\xf6v\xaf;\x18") {
      nade delete();
    }
  }

  if(offhands::offhandisprecached("\xb6\xbdc\xf6Gov") && utility::issharedfuncdefined(#"molotov", #"delete_all_molotovs")) {
    utility::callsharedfunc(#"molotov", #"delete_all_molotovs");
  }

  if(level.player isthrowinggrenade()) {
    level.player childthread delete_grenade_when_thrown();
  }
}

function private delete_grenade_when_thrown() {
  level.player waittill("\xe0\x99\xc7\xf1\a3\x81c\xa5\xe17G", grenade, weapon);

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
      assertmsg("<dev string:x69>");
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
      assertmsg("<dev string:xd1>" + unittype + "<dev string:xdc>");
      break;
  }
}

#using_animtree("*xmG4\x1e\x14\xb1\xc2u_!\xf5");

function assign_human_animtree() {
  self useanimtree(#animtree);
}

function enable_procedural_bones() {
  self setanim(%\xf41\xd8\t\x81\xf0 * \xedH, 1, 0);
}

function disable_procedural_bones() {
  self setanim(%\xf41\xd8\t\x81\xf0 * \xedH, 0, 0);
}

function change_player_health_packets(num) {
  assert(isPlayer(self));
  self.player_health_packets += num;
  self notify("u\xc12Xt+}\xd0Y\xb0\x8dG\xd0\xeb\x0ea\xc6\xda\xac\x8e\x9b");

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
    health = player_sp::dodamagefilter(health, mod);
  }

  return self dodamage(health, position, attacker, inflictor, mod, weapon, location);
}

function set_player_attacker_accuracy(val) {
  player = get_player_from_self();
  player.scriptedattackeraccuracy = val;
  player gameskill::update_player_attacker_accuracy();
}

function player_has_unlocked_stored_equipment_slots() {
  if(!isDefined(level.player.storedslotsunlocked) || !level.player.storedslotsunlocked) {
    return 0;
  }

  return 1;
}

function player_seek_enable() {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  level.player endon("X\x83\x1d)&\x13\xb4o[\x953\xee\xf7Gz`");
  level.player endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
  self notify("X\x83\x1d)&\x13\xb4o[\x953\xee\xf7Gz`");
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("X\x83\x1d)&\x13\xb4o[\x953\xee\xf7Gz`");
  self endon("\xd3\xad\x11\xca%\xf7@\xabk_L\xff\x19");
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
  self notify("X\x83\x1d)&\x13\xb4o[\x953\xee\xf7Gz`");
}

function riotshield_lock_orientation(yaw_angle) {
  self orientmode("u\x9fP\x1a\xbe4oa\xd5\xd9", yaw_angle);
  self.lockorientation = 1;
}

function riotshield_unlock_orientation() {
  self.lockorientation = 0;
}

function cqb_walk(var_87ce5ebbac3505ab) {
  if(var_87ce5ebbac3505ab == "\xb8\"") {
    utility::enable_cqbwalk();
    return;
  }

  assert(var_87ce5ebbac3505ab == "<dev string:x144>");
  utility::disable_cqbwalk();
}

function enable_flashlight(enable, safe) {
  if(!isDefined(enable)) {
    enable = 1;
  }

  if(!isDefined(safe)) {
    safe = 1;
  }

  if(enable) {
    nvg_ai::flashlight_on(safe);
    return;
  }

  nvg_ai::flashlight_off(safe);
}

function throwgrenadeatplayerasap() {
  combat_utility::throwgrenadeatplayerasap_combat_utility();
}

function waterfx(endflag, soundalias) {
  self endon("\x1e\xfd\xd1\xa2\a");
  play_sound = 0;

  if(isDefined(soundalias)) {
    play_sound = 1;
  }

  if(isDefined(endflag)) {
    utility::flag_assert(endflag);
    level endon(endflag);
  }

  for(;;) {
    wait randomfloatrange(0.15, 0.3);
    start = self.origin + (0, 0, 150);
    end = self.origin - (0, 0, 150);
    trace = trace::ray_trace_detail(start, end, undefined, trace::create_default_contents(1));

    if(trace["I\xf8\x17\x03\x90\x81\xd3\xf0]e\x11"] != "\x8d:N\x8d\xc1") {
      continue;
    }

    fx = "\xdd\xc2G\xac9\xbemo\x9dYm\xb2nt";

    if(isPlayer(self)) {
      if(distance(self getvelocity(), (0, 0, 0)) < 5) {
        fx = "N\xe8A\xd2\xf6w\x9e\vy\x92";
      }
    } else if(isDefined(level._effect["G\xb0B\x87s\xa9" + self.a.movement])) {
      fx = "G\xb0B\x87s\xa9" + self.a.movement;
    }

    water_fx = utility::getfx(fx);
    start = trace["\xc1\xbd\xdci\xe8i{7"];
    angles = (0, self.angles[1], 0);
    forward = anglesToForward(angles);
    up = anglestoup(angles);
    playFX(water_fx, start, up, forward);

    if(fx != "N\xe8A\xd2\xf6w\x9e\vy\x92" && play_sound) {
      thread utility::play_sound_in_space(soundalias, start);
    }
  }
}

function player_is_near_live_offhand(isautosave) {
  grenades = getEntArray(",\xe1\x93So\x98\r", #classname);

  foreach(grenade in grenades) {
    if(!offhand_is_dangerous(grenade)) {
      continue;
    }

    for(playerindex = 0; playerindex < level.players.size; playerindex++) {
      player = level.players[playerindex];

      if(distancesquared(grenade.origin, player.origin) < 75625) {
        if(istrue(isautosave)) {
          autosave::autosave_print("\xaa\xbc\x18i\xd9\x13b\x15i\xe0\x7fDg\x97ll\x1e\xdd \xc4T\xd6\xc9\xf9w\xec\xf7\xfc\xfbe\x19", 0);
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

  if(grenade.targetname == "\xa0\x12\x86Jp\x85A\xf8 \xeb\x02%\x19\xc5\xd7\xc0") {
    return false;
  }

  if(grenade.targetname == "\xa0\x12\x86Jp\x85A\xf8 n\xe12\x18\x05\xb6\xc0\xb0\x99\xe2\xe8\\\xbaq") {
    return false;
  }

  if(grenade.targetname == "$\xd95%v\xa7\xb7\x91\x15{4\x9e\xedN\x9dd\xb8\xf5") {
    return false;
  }

  if(grenade.targetname == "[\xdf\xf6<v\xd4J\x16\xfa\x87\xdc\x8d\x1b\x8c\xdc\xd3s\x8b\xf37\xfb") {
    return false;
  }

  if(grenade.targetname == "\x7f\x9dRc\x83\xca\xc9\xea$8!d1\x1d\xe0\xf57\xd4\x14") {
    return false;
  }

  if(grenade.targetname == "\x8aV\xb6Dr\x06$\x1f\xb3\x1cV") {
    return false;
  }

  return true;
}

function has_shotgun() {
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(self.weapon)) {
    return false;
  }

  if(weaponclass(self.weapon) == "\n\x1f+\x8dob") {
    return true;
  }

  return false;
}

function isprimaryweapon(weapon) {
  weaponobj = utility::function_3aac010105913843(weapon);

  if(!isDefined(weaponobj) || isnullweapon(weaponobj)) {
    return 0;
  }

  if(weaponinventorytype(weaponobj) != "\xe6\xaa6=\x93`Y") {
    return 0;
  }

  switch (weaponclass(weaponobj)) {
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

function enable_heat_behavior(var_a3b4fc7af95d8d80) {
  assertmsg("<dev string:x14b>");
}

function interactivekeypairs() {
  interactivekeypairs = [];
  interactivekeypairs[0] = ["ZnG+N\vl\x1d\xb4\x9d\x95\xaf\x13\xa5\x93\x19\xb9", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc"];
  interactivekeypairs[1] = ["\xbc8\a\xe7\xd4\x87\xe0\xd9\x9eA\x98\x91\x1b\x1b\x19v\xf7'\x9c", "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc"];
  interactivekeypairs[2] = ["\xca\xc8\xccG4\x9e\x14\x03\xd2E\xdf\xc2u\x0fQ\xca", "\b\xd5\x90\x99\xf5g\xd7\f$\xf1\xf0~\xdfU\x18\x01*"];
  return interactivekeypairs;
}

function mask_interactives_in_volumes(volumes) {
  interactivekeypairs = interactivekeypairs();
  combinedinteractives = [];

  foreach(interactivekeypair in interactivekeypairs) {
    moreinteractives = getEntArray(interactivekeypair[0], interactivekeypair[1]);
    combinedinteractives = utility::array_combine(combinedinteractives, moreinteractives);
  }

  foreach(ent in combinedinteractives) {
    if(isDefined(ent.script_noteworthy)) {
      ent_type = ent.script_noteworthy;
    } else {
      ent_type = ent.targetname;
    }

    assert(isDefined(ent.interactive_type), ent_type + "<dev string:x1a6>");
    assert(isDefined(level._interactive), ent_type + "<dev string:x1dc>");
    assert(isDefined(level._interactive[ent.interactive_type]), ent_type + "<dev string:x216>" + ent.interactive_type + "<dev string:x241>");

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

function hud_intel_message(header_string, body_string, var_8ec7ad7df551fbc6, var_a043d1dd8385683d) {
  intel_value = 20;

  if(!isDefined(var_8ec7ad7df551fbc6)) {
    var_8ec7ad7df551fbc6 = "\x91\xca\xcc\v\xab\xd8:";
  }

  switch (var_8ec7ad7df551fbc6) {
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

  setomnvar("Kr\x9ffX\x01\xb9\x15)\xdd\xb5Y!\x1fK\x03q:\x9f\x10()\x81\v{\xc7\xdf\x91\xfb\x8bRY\xda", intel_value);
  setomnvar("\xadE\xd4\x9d\xa8\xebi\xc8\xaa\xde\x9c`\x19\x7f\xa4y)\x91N\x17%\xbe:8\xd5\xbd", body_string);
  setomnvar("\x19\x0e\xaf\xbf\xdeW\x037z\x9f)y\xbf\xd3\x89]\xe9\xb3-\b\xe8\xd1\xd3\x80\xee!\"p", header_string);
  setomnvar("_]\x8d4\x83\x91!\x17Z<@\xec\xf5m\xfe\xf9\xee\xcboK~", 1);
  level.player thread _intel_waypoint_button_listener();
  var_2303d4f9bc32a0e = var_8ec7ad7df551fbc6 == "\xe6\xbdH'\xe0\x81RLV :";

  if(var_2303d4f9bc32a0e) {
    level.player thread _intel_dismiss_button_listener();
  }

  if(isDefined(var_a043d1dd8385683d)) {
    setomnvar("\x14L\xdd/\xc4\xa6Y(\xfb\x1aj'\xf4\x14\xd7\xcd\xa1un\xfd\xe5\x87\x10\xe5\xec", 1);
  } else {
    setomnvar("\x14L\xdd/\xc4\xa6Y(\xfb\x1aj'\xf4\x14\xd7\xcd\xa1un\xfd\xe5\x87\x10\xe5\xec", 0);
  }

  action = "sh\xbc\ru";
  start_time = gettime() / 1000;
  wait_time = 5;

  while(var_2303d4f9bc32a0e && !isDefined(level.player.intel_dismiss_request) || !var_2303d4f9bc32a0e && gettime() / 1000 - start_time < wait_time) {
    if(isDefined(level.player.intel_waypoint_request)) {
      action = "0Gf(c:A\x06";
      break;
    }

    wait 0.05;
  }

  setomnvar("_]\x8d4\x83\x91!\x17Z<@\xec\xf5m\xfe\xf9\xee\xcboK~", 0);
  setomnvar("\x14L\xdd/\xc4\xa6Y(\xfb\x1aj'\xf4\x14\xd7\xcd\xa1un\xfd\xe5\x87\x10\xe5\xec", 0);
  level.player.intel_dismiss_request = undefined;

  if(action == "0Gf(c:A\x06" && isDefined(var_a043d1dd8385683d)) {
    target_loc = utility::spawn_script_origin(var_a043d1dd8385683d, (0, 0, 0));
    target_loc.icon = newhudelem();
    target_loc.icon setshader("^\x82`R+B\x84\xfa\xdd\xb6r\xab\xf8Z\xf5", 32, 32);
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

  level.player notify("4\avC\x8f|e\x1a6\t\xd6_\x86\xf1\xa3");
  level.player.intel_dismiss_request = undefined;
  return;
}

function is_demo() {
  if(getdvarint(@ "scr_demo", 0)) {
    return true;
  }

  return false;
}

function hudoutline_ar_callout(display_name, large_object, widget_offset) {
  if(isDefined(level.player.ar_callout_ent)) {
    hudoutline_ar_disable();
  }

  level.player endon("3\x8c\xe8\x18\x9d}\xacP\xb9\x96\xd7\x05\x85\xfb\x8d");
  setomnvar("s\xbf!w\xbf\xb3\x94E\xbc(\xb8qn\x11NA\xe0", undefined);
  wait 0.05;
  setsaveddvar(@ "r_hudoutlineenable", 1);
  level.player.ar_callout_ent = utility::spawn_tag_origin();
  setomnvar("s\xbf!w\xbf\xb3\x94E\xbc(\xb8qn\x11NA\xe0", level.player.ar_callout_ent);

  if(!isDefined(display_name)) {
    display_name = "\xc2\xe4}\x1b\xc2\xd8l\xf6\xaetn}F\xca3a]lt";
  }

  setomnvar("\xb1\x86Z\xcd\xa77\n\xbf\x96A\xeb\x0f\xe5\xf1\xea\x80`", display_name);
  wait 0.05;

  if(isDefined(large_object) && large_object) {
    hudoutline_enable_new("\xf2\xaf:\xef\xcec4s\xc3\x1f\xfa\x1d\x031\xe3M\xd5\x99\xce\xdc\xd9P\xef<", "\x91\xca\xcc\v\xab\xd8:");
  } else {
    hudoutline_enable_new("\x10\xdd{ c-\xea\xf0\x80\x12\xc5W8\xbft\xad\x174\xf3\x8e\xa7\x12\xb2\xc8\xe8\xba", "\x91\xca\xcc\v\xab\xd8:");
  }

  setomnvar("\xd7!\x04\xc3\xcd\xc2\xf3<04HO\xdd\xa5\x88", 1);
  thread _ar_callout_tracker(widget_offset);
}

function _ar_callout_tracker(widget_offset) {
  level.player endon("3\x8c\xe8\x18\x9d}\xacP\xb9\x96\xd7\x05\x85\xfb\x8d");
  self endon("\x1e\xfd\xd1\xa2\a");

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
  hudoutline_disable("\x91\xca\xcc\v\xab\xd8:");
  setomnvar("\xd7!\x04\xc3\xcd\xc2\xf3<04HO\xdd\xa5\x88", 0);
  wait 0.1;
  level.player notify("3\x8c\xe8\x18\x9d}\xacP\xb9\x96\xd7\x05\x85\xfb\x8d");
  setomnvar("s\xbf!w\xbf\xb3\x94E\xbc(\xb8qn\x11NA\xe0", undefined);
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
  return level.player utility::ent_flag_exist("\x17\xc4\x16zz%\xbe\xf1\xedeu\xb9") && level.player utility::ent_flag("\x17\xc4\x16zz%\xbe\xf1\xedeu\xb9");
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
  precachesuit("\x0f\xb5H\xc9\xde\xfbc\x8e\xfe");
  level.player setsuit("\x0f\xb5H\xc9\xde\xfbc\x8e\xfe");
}

function setplayerlootenabled(boolean) {
  level.var_efdb5f20c72d3104 = boolean;
}

function playerlootenabled() {
  return istrue(level.var_efdb5f20c72d3104);
}

function personalcoldbreathstop() {
  self notify("u)\xd8kzw\x02])\xf5A\xe9\xf0\xce\x1f\x978F\xa7\xf2");
}

function personalcoldbreathspawner() {
  self endon("\x1e\xfd\xd1\xa2\a");
  self notify("u)\xd8kzw\x02])\xf5A\xe9\xf0\xce\x1f\x978F\xa7\xf2");
  self endon("u)\xd8kzw\x02])\xf5A\xe9\xf0\xce\x1f\x978F\xa7\xf2");

  for(;;) {
    self waittill("\xcb!f\x94\xa0@\xc1", spawn);

    if(ai::spawn_failed(spawn)) {
      continue;
    }

    spawn thread utility::personalcoldbreath();
  }
}

function missionfailedwrapper(failreason, attacker, cause, weaponobject, customdelay) {
  if(level.missionfailed) {
    return;
  }

  if(isDefined(level.nextmission)) {
    return;
  }

  analytics::analytics_obj_failed(failreason);
  level.missionfailed = 1;
  utility::flag_set("\x95\b\x9b\xf5\xc6\xe9\xe2\x10\xbf\xae\xee\xc5>");

  if(getDvar(@ "failure_disabled") == "\x87") {
    return;
  }

  if(isDefined(level.mission_fail_func)) {
    thread[[level.mission_fail_func]]();
    return;
  }

  if(isnumber(customdelay)) {
    wait customdelay;
  }

  weaponname = isDefined(weaponobject) ? getcompleteweaponname(weaponobject) : undefined;
  thread player_death::set_death_hint(attacker, cause, weaponname, attacker, weaponobject);
  missionfailed(in_yolo_mode());
}

function giveachievement_wrapper(achievement, notused) {
  if(is_demo()) {
    return;
  }

  level.player giveachievement(achievement);
  println("<dev string:x256>" + achievement);
}

function player_giveachievement_wrapper(achievement) {
  if(is_demo()) {
    return;
  }

  if(endmission::islastlevel()) {
    return;
  }

  self giveachievement(achievement);
  println("<dev string:x256>" + achievement);
}

function play_skippable_cinematic(cinematic_name, skip_waittill, var_41637d0a87d958ba, var_12c73ed917dde517 = 0, var_f7730d36a636bbaf = 0, var_bb74ac3ede9f1ee1 = 0, var_9264b95632c1a3d4 = 0) {
  setsaveddvar(@ "bg_cinematicfullscreen", "\x87");
  setsaveddvar(@ "hash_b9ff37d084074df3", "\x87");
  level.player cleardamageindicators();
  cinematicingame(cinematic_name);
  level.player player_sp::remove_damage_effects_instantly();
  remove_equipment_immediately();
  registered = "\xcd0\t\x98\xe15-\xb1\x89_\x0f\xb8UT\xa9\xbfW\x19C";
  level.player val::set(registered, "\xe5\x06\xb0\bE\x16", 0);
  level.player val::set(registered, " \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[", 1);
  level.player val::set(registered, "\fU`\xc0y\x95", 0);
  level.player val::set(registered, "\xabw\x97u\x9eF\x9c.\x91\xc0R?\x9f", 0);
  level.player val::set(registered, "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
  level.player val::set(registered, "7\x86\xed\xee\xfa\xee\xacXp{n\xbe\xa1\xae\x91", 0);
  level.player val::set(registered, "\xa8Jl\x84\xb3b\x95o", 0);

  while(!iscinematicplaying()) {
    waitframe();
  }

  var_5990fba2dc6d7621 = spawnStruct();
  thread cinematic_skip_input(skip_waittill, var_f7730d36a636bbaf, var_5990fba2dc6d7621, var_9264b95632c1a3d4);

  if(isDefined(var_41637d0a87d958ba)) {
    was_timeout = cinematic_waittill_skip_or_time(var_41637d0a87d958ba);
    level.player val::reset_all(registered);
    level.player cleardamageindicators();
    level notify("\xeb\r\x14\xed\xee\xd5C\x88\xea\xa6/~\x81^~\xff \x0e\xff\xfcl\"]\x9f");

    while(iscinematicplaying()) {
      waitframe();
    }

    setsaveddvar(@ "bg_cinematicfullscreen", "\xfe");
    setsaveddvar(@ "hash_b9ff37d084074df3", "\xfe");
    setomnvar("\xf4^*\xf4v\xb4\x8a\xe3\xf0?\xf3\x89|\xa2I\xf7\\g\x95\xe2", 0);

    if(!istrue(var_5990fba2dc6d7621.was_skipped)) {
      if(istrue(was_timeout)) {
        stopcinematicingame(var_bb74ac3ede9f1ee1);
      } else {
        stopcinematicingame(var_12c73ed917dde517);
      }
    }

    return;
  }

  totalframes = function_3310ba387a2462ad();

  while(iscinematicplaying()) {
    waitframe();

    if(var_9264b95632c1a3d4) {
      if(totalframes == 0) {
        totalframes = function_3310ba387a2462ad();
      }

      if(cinematicgetframe() + 75 > totalframes && totalframes != 0) {
        hud_util::fade_out(0.1, "\x8a-\v\xa1\xbd");
      }
    }
  }

  setsaveddvar(@ "bg_cinematicfullscreen", "\xfe");
  setsaveddvar(@ "hash_b9ff37d084074df3", "\xfe");
  setomnvar("\xf4^*\xf4v\xb4\x8a\xe3\xf0?\xf3\x89|\xa2I\xf7\\g\x95\xe2", 0);

  if(!istrue(var_5990fba2dc6d7621.was_skipped)) {
    stopcinematicingame(var_12c73ed917dde517);
  }

  level.player val::reset_all(registered);
  level.player cleardamageindicators();
  level notify("\xeb\r\x14\xed\xee\xd5C\x88\xea\xa6/~\x81^~\xff \x0e\xff\xfcl\"]\x9f");
}

function cinematic_skip_input(skip_waittill, var_f7730d36a636bbaf = 0, var_c68d87b1ea081507, var_9264b95632c1a3d4 = 0) {
  level endon("\xeb\r\x14\xed\xee\xd5C\x88\xea\xa6/~\x81^~\xff \x0e\xff\xfcl\"]\x9f");

  if(isDefined(skip_waittill)) {
    self waittill(skip_waittill);
  }

  setomnvar("\xf4^*\xf4v\xb4\x8a\xe3\xf0?\xf3\x89|\xa2I\xf7\\g\x95\xe2", 1);

  while(true) {
    level.player waittill("\xa6\xbd&nnj\xb4\x10\xf1\x12.cW.p", message, value);

    if(message == "\x9e\x94:\xf6\xbfm'\xd1\x10\x8e\xdb\x8e\xcc\xe4\xd7") {
      if(isDefined(var_c68d87b1ea081507)) {
        var_c68d87b1ea081507.was_skipped = 1;
      }

      if(var_9264b95632c1a3d4) {
        hud_util::fade_out(0, "\x8a-\v\xa1\xbd");
        utility::wait_frames(2);
      }

      level notify("A\xa2\x98\xbe\v\xa7\xc0\x8b\x99\xb7\xf7\xe7\xb3u\xb0\xc4a");
      stopcinematicingame(var_f7730d36a636bbaf);
      break;
    }
  }
}

function cinematic_waittill_skip_or_time(wait_time) {
  level endon("A\xa2\x98\xbe\v\xa7\xc0\x8b\x99\xb7\xf7\xe7\xb3u\xb0\xc4a");
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
  weaponobj = utility::function_3aac010105913843(weapon);
  return weapontype(weaponobj) == "k\xad\xb8<9\xcey\xdc\x14\xac";
}

function isknifeonly(weapon) {
  weapname = getweaponbasename(weapon);
  return issubstr(weapname, "\xfb\xcf\xf5\x88\x13");
}

function isbulletweapon(weapon) {
  weaponobj = utility::function_3aac010105913843(weapon);

  if(!isDefined(weaponobj) || isnullweapon(weaponobj)) {
    return 0;
  }

  if(isriotshield(weaponobj) || isknifeonly(weaponobj)) {
    return 0;
  }

  switch (weaponclass(weaponobj)) {
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

function isthrowingknife(weapon) {
  if(!isDefined(weapon)) {
    return false;
  }

  weapname = undefined;

  if(isweapon(weapon)) {
    if(isnullweapon(weapon)) {
      return false;
    }

    weapname = weapon.basename;
  } else {
    if(weapon == "\r+x5") {
      return false;
    }

    weapname = weapon;
  }

  return issubstr(weapname, "VK\n\xdb\xd0(O'T]\x12K\x8e") || issubstr(weapname, "\x1a\xba]\xf0\xc6\xc9t\x13");
}

function enable_stayahead(followent) {
  setdvarifuninitialized(@ "hash_3d6aec1e7192648b", 0);
  disable_stayahead(0, 0);
  waittillframeend();

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    iprintln("<dev string:x267>" + self getentnum());
  }

  thread stayahead::stayahead_thread(followent);
}

function disable_stayahead(speed, reset) {
  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    iprintln("<dev string:x283>" + self getentnum());
  }

  if(isDefined(self.stayahead) && isDefined(self.stayahead.using_goto_node)) {
    stayahead::print3d_debug(self.origin + (0, 0, 8), "\x9bHf\xf9\xbf@M}\x95\x1csY\x1f\xa6=0HM:\xa7#\xc4\x11N\xd0\x1boh\x1b\x80#mz\x05\x8a\x12\x14\xf9\xcd=u'Ts.J", (0, 1, 0), 1, 0.3, 500, 1);
    thread spawner::go_to_node(stayahead::get_best_goto_node(self.stayahead.goto_patharray, 2));
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

  self notify("G\xc0&e\t\x811\xf6E\xa1\x8eGWW");

  if(istrue(speed)) {
    utility::set_movement_speed(speed);
  }
}

function set_stayahead_values(plane, speed, distance, variance) {
  assert(isDefined(plane), "<dev string:x2a0>");
  assert(isDefined(speed), "<dev string:x2c1>");
  assert(isDefined(distance), "<dev string:x2d7>");

  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  planevalues["\xa2\xac\xd9\xd7H"] = speed;
  planevalues["\x06\xfb\xa6\n]\xf5\xc0@"] = distance;

  if(isDefined(variance)) {
    planevalues["\x17!t\x02\xce\xf6)\x15"] = variance;
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
      assertmsg("<dev string:x2f0>" + plane);
      break;
  }
}

function set_stayahead_wait_values(distance, buffer, var_b25dd8cfd4d23d69) {
  set_stayahead_values("/\xc8,\r", 0, distance, 0);
  self.stayahead.pw["\x8d\xd7\xc9p\xb7*"] = buffer;

  if(istrue(var_b25dd8cfd4d23d69)) {
    self.stayahead.use_goto_wait = 1;
  }
}

function stayahead_disable_wait() {
  if(isDefined(self.stayahead)) {
    if(getdvarint(@ "hash_3d6aec1e7192648b")) {
      iprintln("<dev string:x321>" + self getentnum());
    }

    if(isDefined(self.stayahead.goalnode_pw)) {
      goalnode = self.stayahead.goalnode ?? self.goalnode;
      childthread stayahead::stayahead_set_goalnode(goalnode, 0);
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
    assert(speed > 0, "<dev string:x343>");
  }

  if(getdvarint(@ "hash_3d6aec1e7192648b")) {
    print_speed = speed;

    if(!isDefined(print_speed)) {
      print_speed = "<dev string:x363>";
    }

    iprintln("<dev string:x370>" + print_speed);
  }

  self.stayahead.turbo = speed;
}

function set_stayahead_wait_nodes(nodes, var_b25dd8cfd4d23d69) {
  if(!isDefined(self.stayahead)) {
    self.stayahead = spawnStruct();
  }

  if(isDefined(nodes)) {
    assert(isarray(nodes), "<dev string:x38d>");
    assert(nodes.size > 0, "<dev string:x3ab>");
    self.stayahead.wait_nodes = nodes;
  }

  if(istrue(var_b25dd8cfd4d23d69)) {
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

  self.stayahead.team = utility::array_combine(self.stayahead.team, array);
}

function stayahead_pause(bool) {
  if(utility::ent_flag_exist("w(\x8eU\xd6\xeed\xa6\xb1\xdeO\xd6\x97\xa19")) {
    if(bool) {
      utility::ent_flag_set("w(\x8eU\xd6\xeed\xa6\xb1\xdeO\xd6\x97\xa19");
    } else {
      utility::ent_flag_clear("w(\x8eU\xd6\xeed\xa6\xb1\xdeO\xd6\x97\xa19");
    }

    return;
  }

  print("<dev string:x3c3>");
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

function function_7971740029c8f9f3(assethash) {
  return scripted_weapon_assignment::function_2a6fcb0d09b14b12(assethash);
}

function make_weapon(basename, attachments, reticle, camo, lootid, alt_mode, blueprint) {
  if(!isDefined(level._weapons)) {
    level._weapons = spawnStruct();
  }

  if(!isDefined(attachments)) {
    attachments = [];
  }

  if(!isweapon(basename)) {
    tok = strtok(basename, "H");

    if(tok.size > 1) {
      basename = tok[0];
      attachments = utility::array_combine(attachments, arrayremove(tok, tok[0]));
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

  if(getdvarint(@ "hash_4589562a903db3e0") && isstartstr(basename, "<dev string:x403>")) {
    print("<dev string:x40b>" + basename);
  }

  if(istrue(alt_mode)) {
    var_d49bd2f36366d34e = &makealtweapon;
  } else {
    var_d49bd2f36366d34e = &makeweapon;
  }

  defaults = getweapondefaultattachments(basename);
  defaults = utility::removeconflictingattachments(attachments, defaults, basename);
  attachments = utility::array_combine(attachments, defaults);
  attachment_variants = [];

  foreach(attachment in attachments) {
    if(issubstr(attachment, "\x1f")) {
      attachments = arrayremove(attachments, attachment);
      attachments[attachments.size] = strtok(attachment, "\x1f")[0];
      attachment_variants[attachment_variants.size] = attachment;
    }
  }

  attachments = function_63ca1906641b2edd(basename, attachments, var_d49bd2f36366d34e);

  if(isDefined(lootid)) {
    weapon = builtin[[var_d49bd2f36366d34e]](basename, attachments, reticle, camo, lootid);
  } else if(isDefined(camo)) {
    weapon = builtin[[var_d49bd2f36366d34e]](basename, attachments, reticle, camo);
  } else if(isDefined(reticle)) {
    weapon = builtin[[var_d49bd2f36366d34e]](basename, attachments, reticle);
  } else if(isDefined(attachments)) {
    weapon = builtin[[var_d49bd2f36366d34e]](basename, attachments);
  } else {
    weapon = builtin[[var_d49bd2f36366d34e]](basename);
  }

  foreach(attachment in attachment_variants) {
    tok = strtok(attachment, "\x1f");

    function_63ca1906641b2edd(basename, [tok[0]], var_d49bd2f36366d34e);

    weapon = weapon withattachment(tok[0], int(tok[1]));
  }

  if(isDefined(blueprint)) {
    blueprints = function_cbf44a76c1f44c23(basename, blueprint);
  }

  return weapon;
}

function function_63ca1906641b2edd(basename, attachments, var_d49bd2f36366d34e) {
  weapon = builtin[[var_d49bd2f36366d34e]](basename);
  filtered = attachments;

  foreach(attachment in attachments) {
    if(!weapon canuseattachment(attachment)) {
      assertmsg("<dev string:x452>" + basename + "<dev string:x45e>" + attachment + "<dev string:x47b>");
      filtered = arrayremove(filtered, attachment);
    }
  }

  return filtered;
}

function check_for_blacklisted_attachment() {
  weapon = self;
  blacklist = [];
  blacklist[blacklist.size] = "\xc8\x9b\xc7\xf3`xjzs\xc7)\x90\xa8\xf4\xfd\t\x80\xb23\x8dH\xd2\x10C";
  blacklist[blacklist.size] = "\xce\xec2\x87f\x81\x8by\x0e\x8fU\xab\x99\x18\xe4\x0f\x9eh\x04\xdf\xbaPai\x11+.\xb4f\xfb";
  blacklist[blacklist.size] = "\x86\xad\xfb\xd6\xcbm\x06\xc4-5\xb0\xf2oL\x16\xb1=F\xf0\xc4\xe1\xa8p\xa6r=\t\xff\x1d\x86\xfe";
  blacklist[blacklist.size] = "6\xf4\x01\xff\xf4\x0e\x1a\xf0\xb0\t`O\xf9SP.\xc7\xd63\xdaDw\\@`J\xd9C";
  blacklist[blacklist.size] = "\x02m\xe0\xfb\r\xd9@\x99\x02\xc1\x01OyY\aj}\xe1Z{F\xb4Z\x1c\x87\xc7V\x1e}";
  blacklist[blacklist.size] = "bWe\xfap\x97U\x8e\xf7\xd1\xac[\x14!\xf8\xfe%\xea\xe4\x13\xf1\x84GW\x97w";
  blacklist[blacklist.size] = "\xff\xb7\xfae\xa0>\x9d<\xe2W\xe2\x91jSF\x17\xf2$\xbfx5\xbdvF\xde/\\\x1dT7r\r\xa3$";
  blacklist[blacklist.size] = "\xfb\x0eU\n*\xb3\xad\x87\xa2B\xa1\xcd\x1e\xf3\xbfA\x92\x17I-\x19\xca\xa6\x1f\xd9\xa2.W+/U";
  blacklist[blacklist.size] = "[\xec\x8b\x98>+R\xd1\xb8+\x1f\xec \xe9Q\xc5\xafs6\x98w{Z\xa8\xc1\xa1\xb3\xaf\x90z\xadq";
  blacklist[blacklist.size] = "|\xeb\xf1 \xabI\xfb\xbf\xbd\x9b\xe7\x19a\xac}\x95c\a\xd2\t\xa9\xbd\x1b8\xb8\xbf\x83\xbf\x10";
  blacklist[blacklist.size] = "\xb6\xa61\x18\xd9\x03;\x97h\x8d\xeb\x02\x8eD\xe1X\xf6\xf1;\t\x8d\xd1\xdd\x19\xb4\xf8\xc3j`\x8c8]";
  blacklist[blacklist.size] = "FM\x81\xef\x98d.!u\x10\xa3\xc2\x18R\xcc\t\x01WHz\xffC\x99[\xde\xc5\x03F\xe9\x1b";
  blacklist[blacklist.size] = "\x06\xd3\xf89b{\x93\xd7\x83\xd9\x88k}\xf9\xd9z\x01\t\xb8\xcc\x8bC\xa37\x87\xdbL";
  blacklist[blacklist.size] = "\x82Ab\xab\xbd?\xfa\xc0Q{\x9a\xb3\xe4\xafh'\xd0\xdd\xd0\x8e\xf8\xcd\x06\xf2a]\xaf\xa9\x94\xcd\x1d";
  blacklist[blacklist.size] = "7\xacD(7\x88\x7f\xb2\x9e\x1bT'\x9a\x97X\x1b\xcfE\x17\x1c\xba\xd8SX\xf4\x1f\xdc'\b[\x18\x13";
  blacklist[blacklist.size] = "\x8bM\xf0\x10>$<\x8e\x96\xf7\f\xa7\xa8\x9e\\lF\xeejI^\x9f\x94\xfc8}\x01\x13\xa0\xd5M\xe3";
  blacklist[blacklist.size] = "\xb5\xc58f\x9ci\xc2\xbc\xa0\xefs\xbf\xb6k\xd5[\xc6\x17)\x13\x17\x98&\xb7\xd7\x96U\a\x01";
  blacklist[blacklist.size] = "\xd0j<\xb9\t\xc7\xb9&\r;?\x0f\xcb\x92\x9c2{}\xca\xf1\xa1!f\xf9\xc3\xa7J\xd0\xb4\xe5";
  blacklist[blacklist.size] = "\xe9\x97wC\xe9P\xdbMon\xe7h\bS\xa7\xb91\xc5z\x1b\xa9YR\xbba;_";
  blacklist[blacklist.size] = "[\xb4\x1bkO\xa4)~\x8c\xbb?LIY\x7f+\xe7\x94\x01\x1aH@\xb0\xad\xf0\x0fK\x84?1\xbfp";
  blacklist[blacklist.size] = "\x8b\\\xa4\xef\x8a\x1c\x9f\xa6\xac\x10\x1c\xb5p5\v\xabYp\xf5'\x8f\x82\x8d\x82\x15\xc0\xc1\xdc\x8f\xd2";
  blacklist[blacklist.size] = "\x8a\xcc\xe4\x04\xb0\x04G\xf5\xdfm\xb0\xed\xf4\x81X\b\xc7\xe2\xee\x8a\xf8?\xad\xd6\xb41\xff";
  blacklist[blacklist.size] = ":\xc83\v\xe22\xba7si\xfa\xe6\bF7\xb2^\xbbJ2\x01+\xadQ\xa1\x8b\xfa\x12\xee\x065p\xf7";
  blacklist[blacklist.size] = "\x86\x19\xc9G^z\x87\xbdp\x89\x84c\xcf\xf1\x15n\x17\x18OO;@\xd2\x8d\x19\xfaA\xcd\xc3";
  blacklist[blacklist.size] = "\a\xd5\xe7\x99f\xda\xd6\xda\xc1c\xd7\x87\x1f#6\x80&\x16Tm\xec\xea\xce\xdc\\\b\xf3\x91\x16";
  blacklist[blacklist.size] = "r\xc1\x9d\x0e\x17\x82*\xd6\xf2\xd0\xce>\xdbT\xd2\xedP\n1$yB\x06!IH>T\xab\x05\xc2O,";
  blacklist[blacklist.size] = "xukka\xb2\xcd97\x8cq\t*_\xe8~Wr\xf9F?!\xa0\xb1&\xcbF\xd1\xb3\xda";
  blacklist[blacklist.size] = "\r\x7f\x1e;\xd7\x02\x14_lr\xa9\x12\"X\xd9/r\v\xcd\x14j\x0f\x12\re/\xb7v\xa0o*";
  blacklist[blacklist.size] = "\v:\xd1\v\xd8\xd0\xb6Y\xe6G}\xbbm\xfa\x8d\xad\xeb\xd6-\x1bo&F\x89\xd7m\x85\x9d";
  blacklist[blacklist.size] = "\xd7T\xe7B\x7fh\xe2\b\f,\f\xf8\xc0\a\xbfP \xea\xf6\x85\xb3)\xf5\x93c2j\xa6\x13\vVl";
  blacklist[blacklist.size] = "9\x05 {\x9fp@%\xa2m\xc17k\xf3\xbf9\xf6\xe6\x03y\xfb\x8b\x91)\xf8\xb1X}\x93";
  blacklist[blacklist.size] = "Zq\xb0N*1\x15\x16\xfb\\F\xd7=\xeaN\xc0\x91r\x1aX+AW\x97y\b&^\x81n";
  blacklist[blacklist.size] = "\xe7\x18g\xab\xba\x0e/\xc8^EL\xd7\xee\x94:?\x1d\xf4%bN\xd6\xb9\x97J\xbe\x92";
  blacklist[blacklist.size] = "9\x05 {\x9fp@%\xa2m\xc17k\xf3\xbf9\xf6\xe6\x03y\xfb\x8b\x91)\xf8\xb1X}\x93";
  blacklist[blacklist.size] = "\xb0\xb0f\\dx\x15\\\xd9\xd8\xe1\x83\x83\xf3\xd3n\xe3\xc1\xcf\x83\x03\xa7\xf9\xf67\\\xfe7B\xb1e\x92";
  blacklist[blacklist.size] = "\xc6\xac\x17)g\xcc\xbc\x7f\xcb^0|%\xb9\xecv\xe4\xefu\xc4l\xe8\x1d\xd8\a\x03\xa5p\xcdg";
  blacklist[blacklist.size] = "!\xf3G\xd5\xf0\xb4\x81\xd5G\x9ae\xd7\x04&\xc4P\x0e \xdb\xdfJ\x15\x9d\xf8\x03\xb7\xba\x8d\x02G\x9c]";
  blacklist[blacklist.size] = "\xdf'\xdf\xael\xa3\xf1\xfa\x96\xbc\xa0>mE\t\n5\x8e5\xdeT\x95\xf4\xc1\x1a+\x9d";
  blacklist[blacklist.size] = "@mf\xf9\xb27\x96\xaf\xf0X\xf8\x1c\xd1\xa8'\x8eJ\xb2h\xc4\x98[d!\xbb\x1cyJ\xb0";
  blacklist[blacklist.size] = "Ghb\xe3Gi\xb6R:p\xd9\xa7\x95x\xe1(/\xf8\x1e\xc9\xb0W(/\x99\x83(6\f\xacv\r\xedx\xc4O\xd3";
  blacklist[blacklist.size] = "\xb1\x1c9\xfe\x13t\xe8\xc1\xadi\x93^}\x13\x9e\xd4:\xde\xc9Hhu\xe9\x1a\xfalGM\xe3bQV";
  blacklist[blacklist.size] = "X\x82\xb3\xb5}J\xb6\n[\x90\xd2\xa7S\xc4\x8b\xf46\xd3.\xa3\x82\xf7\xdd$\x8db\xea\x98\xd0\x8a\xc1\xe2\f\xa6";
  blacklist[blacklist.size] = "q\xae:\x87L\xa36\xb3#\x9e6\xbd\x11\xbf\xe39\x18*\xe6\xcd]\xd0l\xb7\xe4\xdc\xa7t\x18\v\x14";
  blacklist[blacklist.size] = "\xc5\xcd\x03\xe1\xbev\xfd\x88\x9e5\f2h\x9e\xee\x95\xf9K\x97\xa1\xd7\x94\x1c\x90\x88\xdd";
  blacklist[blacklist.size] = "Y\x0e\x15\x86;\xcdkfl\xac\xf1^\x04\xabGQg\x02S\xe4\xa7\xf0fsoo\xfc[";
  blacklist[blacklist.size] = "\xeb\xdb\xab\xac&\x8e\x16)\a\x88\xd6\xa3\xf4\xc7F\x14\xd6\xc7\xa5*\xa5\x1b\xd5\xdd\xf2\xb1\xb5";
  blacklist[blacklist.size] = "Jz\xaf\x02A\xf5\xfc\b\x14\xb9\xebUc\x84\x1f\xc5\xca\xdb\xe7";
  blacklist[blacklist.size] = "\xffd^\x9a\x93fS\xc3o3L\xd3q\x1e\xe9\xe0\xac\xe1\x8ea\xd0|\x05\x83O";
  attachments = utility::array_reverse(getweaponattachments(weapon));
  attachment_models = getweaponattachmentworldmodels(weapon);

  foreach(model in attachment_models) {
    if(isDefined(utility::array_find(blacklist, model))) {
      assertmsg(model + "<dev string:x492>");
      weapon = self withoutattachment(attachments[i]);
    }
  }

  return weapon;
}

function give_weapon(weapon, model_variant, dual_wield, var_730950cc58a2b588, used_before) {
  if(isstring(weapon)) {
    weapon = make_weapon(weapon);
  }

  if(isDefined(used_before)) {
    self giveweapon(weapon, model_variant, dual_wield, var_730950cc58a2b588, used_before);
    return;
  }

  if(isDefined(var_730950cc58a2b588)) {
    self giveweapon(weapon, model_variant, dual_wield, var_730950cc58a2b588);
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

function function_1b5e805e82a326a5(basename) {
  weaponslist = self getweaponslistall();

  foreach(weapon in weaponslist) {
    if(weapon.basename == basename) {
      take_weapon(weapon);
    }
  }
}

function function_99801d43dac0da33(weapon) {
  if(isweapon(weapon)) {
    take_weapon(weapon);
    return;
  }

  function_1b5e805e82a326a5(weapon);
}

function make_weapon_special(weapon, basename, blueprint) {
  if(isDefined(basename)) {
    weapon = make_weapon(basename, undefined, undefined, undefined, undefined, undefined, blueprint);
  } else {
    assert(isDefined(weapon), "<dev string:x4d4>");

    switch (weapon) {
      case #"hash_a88777756f97cf76":
        weapon = make_weapon("F\xf6\xd0^\x1dJ\x04\x80\x1a\xcd\xce\xef@vP", ["\xdcv\xbfV\xec%\xe8\xce\x17\xb1\xc1\xd0\x02\xe0\x19\xd2L\xfb\x98GZ\xc3\xacX\n6\xcb", "\xb5a\xd9_\v\x9c\xfa\a04\xbe\x16[\x96\xb1\xdb\xf1\x89", "8\xbbG5b\xeb\xbeu\x98\x82V\xa0\rt\x85", "\x8c\xd5\x05yN\x9a't/.\x85", "\x93\xe3:ar\x9d(\xa8\x8e. \x87\xd2X\xbd", "6w~\x825|\xaeN\xfd`Y\xd7\x1avR\xb8JWP\x1c+zZ\x88L\xa0"]);
        break;
      case #"hash_7384f86a3bead6fc":
        weapon = make_weapon("*_\xcb\xf4\xe3\xcf\x9a\x05\xa6\xa1\x7f\xb3g\xb1[\xbf;L", ["(i\xf76\x90u\t\xa1t\xa0X\x818\xa2,\x05\xa5\xe4", "\xf7\x81^\x8e'M\xf9ud\xe0~M\xa9", "\x13\xb6Go\x9c\x84>\x84\x98\xf4\x04c\xba\xaa\xdb\xf7\xda\\", "\xca\x0e@4\xa1`\x8a\xdf\v\x9a", "v\x1c\xcc\xa4]\xaf\v<)_\x85\xe9\xbe\xd7\x16_\x9bL", "\xb5\xc2\xd9_X\xe4_\a`\x0e|\x89", "~K\xd8In\xd4`hqTP\x12X\xab", "?`\xad\x86k\xc5\x9a\xc3\xfa-A\xb2\x91I"]);
        break;
      case #"hash_7384fb6a3beadbb5":
        weapon = make_weapon("*_\xcb\xf4\xe3\xcf\x9a\x05\xa6\xa1\x7f\xb3g\xb1[\xbf;L", ["(i\xf76\x90u\t\xa1t\xa0X\x818\xa2,\x05\xa5\xe4", "\x99\xb8\xd6S^\xe7\xbe6V\xd9G\xf1C", "\x161V\xb2\xda\x99", "v\x1c\xcc\xa4]\xaf\v<)_\x85\xe9\xbe\xd7\x16_\x9bL", "\xb5\xc2\xd9_X\xe4_\a`\x0e|\x89", "~K\xd8In\xd4`hqTP\x12X\xab", "?`\xad\x86k\xc5\x9a\xc3\xfa-A\xb2\x91I"]);
        break;
      case #"hash_82da119871695927":
        weapon = make_weapon(">\xa6\xf9\xba\x9e\x01E\f(r\x83\x8e\xf1\x84O\x95[", ["\x01:\x8dl\xe4\x19$\xbf", "\x8f\x1av\x92h\xd8\xef\xb3\xe7\x05\xcb\xd4/\x13\xfb\xee*(", "\x9d'-\xe0}g\xacNtn\x86\xb7\xc9\xa3\x18f\xc7\x13", "\xf60\x90_\xd6\xd6I8\x18a\n\xddB\x1a", "\x8d\x85\xb9\xca\x9cl\xe5\xc6\xbe\xb0d\xcd01>F", "\x81vhP\x91\xa4'\xe9\x81\xc6\x80pDP\xbe\xab\x89\xb4", "\a\x9d\xe4\x96\xe0\xeb\x85N\x8c}\x83\x18\a", "#\r\xfb\x8f\xbb\xc4\xb7\xa7f\x17<x\x8a", "\x86e\x03\x8d\x1d\x97\x96\xfdUEK\x03\x12=X", "\xbc\x1am\x05r\x06IQ\at\xca\xce\xd7`\x06{\x8c\xcb\x8e\xb7\xa8\xb9\xd0"]);
        break;
      case #"hash_a90e98e5492a71d":
        weapon = make_weapon("\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'", ["\x1ex\x12\xf2A\xf9?j\x7f", "\x1b[+\xb7o\xe7\x90'Up\xff{\xb7(\x1c\"\xccum\xa3j~|\xf0", "\xec\x15\xee\xfd\xafd\xba\x91\x89\x174\xb1\xa9", "\xfb\xeff\xdb\x97\x1a\xed\xdd\xff\xdf\x13|\x06c\xb3", "\xf2\x9d\x8c\x91J\xc3\x93{s\x15\xee\xaaQ\x90\xbd\xf5", "\xf3\xb8_\xa7=]`\xc1=1\xa5\x9d\x8b\a\xa00", "<\x83\xc3\xfdM\xc0\\\x1b\xd8Y\xb0\x85", "\x1cv'i\x0e\xaf\x0e\xc0\xc4\xf8F", "\xb3\xe8\xaaN\xec\x02\xae9\x7f\xe6\x9c,\x8e/T", "\x0eL\xc5\x0f\x83\xd7\xd4.\xee\x1f\xeb\xf2'f%", "pm\x90\x9eW<\x9c-D\xbe\xd1Z\x80\xd0\x17\xb0\xc0\xad\xf25"]);
        break;
      case #"hash_a90e18e54929a85":
        weapon = make_weapon("\x10\\\x87\x9fx\x0e\x87\x16\x9fq\x8bANE'", ["\x1ex\x12\xf2A\xf9?j\x7f", "\xe5\xc6q\xcciJ\xf8\x15w\xdf\xca\xa8\x84|\x93\xc81\xc5c\x99\xec\f\xc6\n", "\xd9r\xb4\x0e_\x85\xdc\xecl\x95F\x06b\xf83", "\xb9i,\xfd|gn\x10 fr\x9a&\xa5a", "N\xc1*}][\x98%\xefc\xdeR\xc9\x92N", "\xf2\x9d\x8c\x91J\xc3\x93{s\x15\xee\xaaQ\x90\xbd\xf5", "\x13\x98\xdd\x9f\x9b\xcdG>\xbe8\xfeP", "\xc2m+\x9b[\xa1\xa1B\xf6p\xa4", "\x9a~\xed\xa5\xe3\xb7(Ws\xf0\xb8\xec\xa2#\x124$", "\x86\xf2\x83\xd6\xa2 \x88\x8c8\xaa\xb66T\xa7,.*Qs\x9f"]);
        break;
      case #"hash_7e14216d4a2f0ab0":
        weapon = make_weapon("HWG\xe6\xa1u\x9f2\x90\xd4'\x0f\x8b\x87\x97J", ["\x85k\xb6\xed\xaf\xdc\x1b#s", "e\xe8F\xe8\xc1\x8b\x8d\x8d\x18x\xe9\xc5\xea*", "\xd8h1J\xd3\x14V\xc4$\xf3\x8b\x90\xc9\x83\x7f!,R\n", "\x17\xd8*e\t\x95\x13\x94\xc31\x8e\xe7\xcf\x17s[\xd3\x9d", "\xe2\xce\xe11\xa8\xde\xd60\xbb\x9b@\x9f\xa0\\\x01\x0e", "}\xa2\x11\xd9\xa1\xb5o\xaa\xb3\x1bpo\xb1S?\xceT\x04", "\x0e\xca\xa5jH\xa5\xacD'(\x12\x80p\x88", "\xbbc\x04.b]<\xe3\x17\x93\xd9]u\xa6O\x8e\a7BT"]);
        break;
      case #"hash_acdc2a1d86f0e9ac":
        weapon = make_weapon("\x84\xd0\x05V\xfcn\xb7\x96\xc3aj}0/hQ\xa7a\x0f", ["\xecn\x91s\x8c3Xu\xf3\xbe", "\x9fa\xb5\xfdV\xb8\xd1P`\xbf\a\xc1\xf7\xcf\xd4\xfcC\xa2\xc9\xa1\bC\xd4\xeaU\xac\x19\xcf", "\xea\xdbL\x05p\x02M\x8a\x9a", "\xa5q\xfc\xb7k\xa7d\xd1\xb3\xb3", "p\x11\xebt\xcb.^\b\x80R+\xb9IX", "D\x92u\x13v\x17n\xd8\x99\x10\x10\xb8\v:\x9c\xdb?/\xb6", "}\xff/\xa8\xc9L|.0h\x7f\x7f\x9c\xf8\x12", "\xed\xd0\xf7\xd3\xff\x0e\xecf\x13\x8e\xb6\xdf\xad\x01p\x1d\x8eN5\xde"]);
        break;
      case #"hash_75807ca5dc84c05e":
        weapon = make_weapon("\xe8\xef?\xb7\xe0\x1a<\x10\x13/\x1c\xa9>\xb4\x92f\xae", ["\xee\xf3\xcea\xe2\x91?\xec\xdb\xa8\x85\x96", "(F[K\xd1t{\x84F\xa7n\x84}\x18\xc3\xae\xfd", "\xfdRj0\xff\xad\xb5+\x99F\xb3\x1d", "\xc6\xd3\xa7\x88\xa0AC\a/\xd4}\x80\x8e", "Y\xa3b\xba\x1e\xd5mD\xe1\xbdQ\xe0N$\x19", "\xe6\xa3\xed\x1b\xb6\xaf\x9b\xe6\xf5X\xcd\x9b\x85\xba\x8dG\xaf\xc1\xc83\x8f&"]);
        break;
      case #"hash_4fcc51ce5cf3bff6":
        weapon = make_weapon("\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0", ["\xb1tH\xd1\xec\xe9Wh\x82U", "\xc5\xd3\xbf\xed!\x82v\x84[N\xc0\x94", "\x05 \xa9\xcf\xc1!\x10\x1bs", "\xa0eWhjN\xa6>+\x05", "q9eEx\x83\x93\x9c\x98\x01\x1f\xa5\aH\xefO0\x10", "\x85^A)\x84\xf3D\xa94\x17=", "\n,\x06\x12\x85\xc6\xd1\xa1D\t\xadp", "j\x03a\xea\xae\xa9\xe0\x1b\x1az\x06\x9c\xd2\xe9\x87", "\xc9\xfd\xb8\x95\xb9yzwQx\xe8(Q\xf8\xffO[\xc1\r\x99", "2+'\xecc\xb6\xc4\x93z\xe1\xdb]P\xb2!\xfa"]);
        break;
      case #"hash_4fcc56ce5cf3c7d5":
        weapon = make_weapon("\x96\xdd\xc9\xafn\xdc\xd7\xadN\xf6k\x95\xed\xeb\xdc\xe0", ["\xc5\xddp\xae^~\x15<T2\xe4\r\x14n?q\x16@\x0e4", "\xfe\xa7\xe1\xc7\xd4\x82\xec\x83\xa7\x1a\xe3D", "\xa5q\xfc\xb7k\xa7d\xf1\xb3\xb0", ":0\xe7\xdb\x8e\xce\xe2\xef\xd8tP\\yb\xb7\x9e\x10cd\xcf\xee\xc7\x86.\"M\xf6", "\xe6\xf5\x1e\x8aa\xeb%f\xb6\x93\xe9\x9e\xa8t?\xb6", "\xd6X\xce}7s\xeb\x0eF\xc4\xc7\x8c", "\x8a\xe4\xe3\xff\x84B\xce2\xad\xc5\xb7", "\x05=\x1c/kQ\xfd\xccT\xed)<", "aWj\xfd\xf1o\x92\xf3\xae\xd2\xf8\x0f\xd1\xa8\x04\r\x80\x92R\xbc\xa8zq\x02\xf3", "x\\lIp\x1edh\xb2\xfc\x10#A\x8f\xc7\x1c\xefv\xd8", "\xdc\xa3\xbdc\xb5\xebn\xe6\xbe\x1cF1\x8fL"]);
        break;
      default:
        println("<dev string:x452>" + weapon + "<dev string:x4f4>");
        weapon = undefined;
        break;
    }
  }

  return weapon;
}

function function_f78cfefb19ec4369(weaponname, oldweaponstring, newweaponstring) {
  oldweapons = getEntArray(oldweaponstring, #code_classname);

  foreach(oldweapon in oldweapons) {
    newweapon = spawn(newweaponstring, oldweapon.origin, oldweapon.spawnflags);
    newweapon.angles = oldweapon.angles;
    newweapon.targetname = oldweapon.targetname;
    newweapon shared::setscriptammo(weaponname, oldweapon, undefined);

    level.placedweapons = arrayremove(level.placedweapons, oldweapon);
    level.placedweapons = utility::array_add(level.placedweapons, newweapon);

    oldweapon delete();
  }
}

function aim_at(origin, laser_state, laser_tag, aim_time) {
  self notify("}x\xe7\xe8\x18\x17dggl\xbc");
  self endon("}x\xe7\xe8\x18\x17dggl\xbc");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(origin)) {
    origin = self localtoworldcoords((150, 0, 30));
  }

  if(!isDefined(laser_state)) {
    laser_state = 0;
  }

  if(!isDefined(aim_time)) {
    aim_time = 1.5;
  }

  self.aim_target = utility::spawn_script_origin();
  self.aim_target.origin = self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84") + anglesToForward(self gettagangles("\xfd\xef\xc3\r\xb4\xad\x84p\x84")) * 50;
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
    var_1ec758cb5704496b = self gettagorigin(self.aim_laser.tag);
    self.aim_laser dontinterpolate();
    self.aim_laser.origin = var_1ec758cb5704496b;
    self.aim_laser.angles = vectortoangles(self.aim_target.origin - var_1ec758cb5704496b);
    waitframe();
  }
}

function createaiment(team, org, ang, expendable) {
  ent = utility::spawn_script_origin(org, ang);
  ent.health = 1;
  ent makeentitysentient(team, expendable);
  return ent;
}

function is_aiming() {
  return isDefined(self.aim_target);
}

function aim_at_laser_on(laser_state, laser_tag) {
  self endon("^\xdey\xad\xa4\xf6\x8e\xef\x10");
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(isDefined(self.aim_target), "<dev string:x507>");

  if(laser_state != 0) {
    if(!isDefined(laser_tag)) {
      laser_tag = "fJn\xc8\x10r\xf3\x94\xf6";
    }

    self.aim_laser = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", self gettagorigin(laser_tag));
    self.aim_laser setModel("fJn\xc8\x10r\xf3\x94\xf6");
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
  self notify("^\xdey\xad\xa4\xf6\x8e\xef\x10");

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
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("}x\xe7\xe8\x18\x17dggl\xbc");

  if(!isDefined(acceleration_time)) {
    acceleration_time = 0.05;
  }

  if(!isDefined(deceleration_time)) {
    deceleration_time = 0.05;
  }

  assert(isDefined(self.aim_target), "<dev string:x543>");
  self.aim_target moveTo(origin, time, acceleration_time, deceleration_time);
  wait time;
}

function link_aim_to(ent, tag, origin_offset) {
  self endon("}x\xe7\xe8\x18\x17dggl\xbc");
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(isDefined(self.aim_target), "<dev string:x579>");

  if(!isDefined(tag)) {
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";
  }

  if(isDefined(origin_offset)) {
    self.aim_target linkTo(ent, tag, origin_offset, (0, 0, 0));
    return;
  }

  self.aim_target linkTo(ent, tag);
}

function move_aim_to_enemy(enemy, tag, acquire_time, var_5075fd607629413d, var_334c0dd7e39d0790, enable_debug) {
  assert(isDefined(self.aim_target), "<dev string:x543>");
  self endon("}x\xe7\xe8\x18\x17dggl\xbc");
  self endon("\x1e\xfd\xd1\xa2\a");
  enemy endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(tag)) {
    tag = "\xec\xbfK|\au\xcd\xc2\x19<";
  }

  if(!isDefined(acquire_time)) {
    acquire_time = 3;
  }

  if(!isDefined(var_5075fd607629413d)) {
    var_5075fd607629413d = 50;
  }

  if(!isDefined(var_334c0dd7e39d0790)) {
    var_334c0dd7e39d0790 = 1;
  }

  if(!isDefined(enable_debug)) {
    enable_debug = 0;
  }

  var_885e90ee59116312 = enemy gettagorigin(tag);
  noise_offset = var_5075fd607629413d;
  var_51fccc4aa871b007 = enemy.origin;
  var_288c4eb117f590ff = var_5075fd607629413d / acquire_time;
  start_speed = distance(self.aim_target.origin, var_885e90ee59116312) / acquire_time;

  while(distancesquared(self.aim_target.origin, enemy gettagorigin(tag)) > 5) {
    delta_time = 0.05;

    if(randomfloat(100) > 50) {
      noise_vec = enemy localtoworldcoords((0, 0, noise_offset));
    } else {
      noise_vec = enemy localtoworldcoords((0, 0, noise_offset * -1));
    }

    final_destination = noise_vec - enemy.origin + enemy gettagorigin(tag);
    var_c7ed94794324bc5e = self.aim_target.origin;
    enemy_speed = length(enemy.origin - var_51fccc4aa871b007) / delta_time;
    speed = enemy_speed + start_speed;
    direction = vectorNormalize(final_destination - var_c7ed94794324bc5e);
    velocity = direction * speed * delta_time;

    if(enable_debug) {
      thread utility::draw_angles((0, 0, 0), final_destination);
      line(var_c7ed94794324bc5e, var_c7ed94794324bc5e + direction, (0, 1, 0));
      line(var_c7ed94794324bc5e + direction, final_destination, (1, 0, 0));
    }

    noise_offset -= var_288c4eb117f590ff * delta_time;
    noise_offset = clamp(noise_offset, 0, var_5075fd607629413d);
    var_51fccc4aa871b007 = enemy.origin;
    move_aim_to(var_c7ed94794324bc5e + velocity, delta_time, 0.001, 0.001);
  }

  if(var_334c0dd7e39d0790) {
    self.aim_target.origin += vectorNormalize(self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84") - self.aim_target.origin) * 20;
    link_aim_to(enemy, tag);
  }
}

function stop_aiming() {
  self notify("}x\xe7\xe8\x18\x17dggl\xbc");
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

function move_aim_along_spline(start_struct, var_f51aeab66e5ab2c) {
  self endon("}x\xe7\xe8\x18\x17dggl\xbc");
  self endon("\x1e\xfd\xd1\xa2\a");
  assert(isDefined(self.aim_target), "<dev string:x543>");
  assert(isDefined(start_struct), "<dev string:x5b0>");
  assert(isDefined(var_f51aeab66e5ab2c), "<dev string:x5f5>");
  spline_dist = 0;

  for(current_struct = start_struct; isDefined(current_struct.target); current_struct = current_struct.next) {
    current_struct.next = utility::getStruct(current_struct.target, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
    current_struct.dist_to_next = distance(current_struct.next.origin, current_struct.origin);
    spline_dist += current_struct.dist_to_next;
  }

  for(current_struct = start_struct; isDefined(current_struct.target); current_struct = current_struct.next) {
    aim_time = current_struct.dist_to_next / spline_dist * var_f51aeab66e5ab2c;
    move_aim_to(current_struct.next.origin, aim_time);
  }
}

function aim_search_around(var_bf1741d84491bb18, var_12fb9e26c79793da, var_159b2ecdac8a0a95, var_8957293adabe587) {
  self endon("}x\xe7\xe8\x18\x17dggl\xbc");
  self endon("\xc4\xa4\xc4vW\xa9F\x7fz3j\xc8D\xfa");
  self endon("\x1e\xfd\xd1\xa2\a");

  if(!isDefined(var_bf1741d84491bb18)) {
    var_bf1741d84491bb18 = -15;
  } else {
    var_bf1741d84491bb18 *= -1;
    var_bf1741d84491bb18 = clamp(var_bf1741d84491bb18, -30, 30);
  }

  if(!isDefined(var_12fb9e26c79793da)) {
    var_12fb9e26c79793da = 15;
  } else {
    var_12fb9e26c79793da *= -1;
    var_12fb9e26c79793da = clamp(var_12fb9e26c79793da, -30, 30);
  }

  if(!isDefined(var_159b2ecdac8a0a95)) {
    var_159b2ecdac8a0a95 = 45;
  } else {
    var_159b2ecdac8a0a95 = clamp(var_159b2ecdac8a0a95, -90, 90);
  }

  if(!isDefined(var_8957293adabe587)) {
    var_8957293adabe587 = -45;
  } else {
    var_8957293adabe587 = clamp(var_8957293adabe587, -90, 90);
  }

  thread debug_aiming();

  while(true) {
    if(randomfloat(100) > 50) {
      vert_angle = var_12fb9e26c79793da;
    } else {
      vert_angle = var_bf1741d84491bb18;
    }

    if(randomfloat(100) > 50) {
      horiz_angle = var_8957293adabe587;
    } else {
      horiz_angle = var_159b2ecdac8a0a95;
    }

    deltatime = 0.05;
    time_elapsed = 0;
    search_target = self.aim_target.origin;

    while(time_elapsed < 4) {
      muzzle_height = self gettagorigin("\xfd\xef\xc3\r\xb4\xad\x84p\x84")[2];

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
        thread utility::draw_angles(search_angles, search_target, (0, 0, 1), 1, 10);
      }

      var_ca0f232e239095ed = search_target - self.aim_target.origin;
      var_d435af7f990fb1dc = length(var_ca0f232e239095ed);
      var_b798919546c23a81 = vectorNormalize(var_ca0f232e239095ed);
      var_2f46273b8b025a9d = var_d435af7f990fb1dc / (4 - time_elapsed);
      var_f17b15aece99354f = var_b798919546c23a81 * var_2f46273b8b025a9d + self.velocity;
      move_aim_to(self.aim_target.origin + var_f17b15aece99354f * deltatime, deltatime, 1e-05, 1e-05);
      time_elapsed += deltatime;
    }

    self.aim_target.origin = search_target;
  }
}

function stop_aim_search_around() {
  self notify("\xc4\xa4\xc4vW\xa9F\x7fz3j\xc8D\xfa");
}

function debug_aiming() {
  self endon("<dev string:x63d>");
  setdvarifuninitialized(@ "hash_500912e607f2c429", 0);

  while(true) {
    if(getdvarint(@ "hash_500912e607f2c429")) {
      self.aim_target childthread utility::draw_ent_axis();
      childthread utility::draw_line_for_time(self gettagorigin("<dev string:x64c>"), self.aim_target.origin, 1, 0, 0, 0.05);

      if(isDefined(self.aim_laser)) {
        dist = distance(self.aim_laser.origin, self.aim_target.origin);
        childthread utility::draw_line_for_time(self.aim_laser.origin, self.aim_laser.origin + anglesToForward(self.aim_laser.angles) * dist, 0, 1, 0, 0.05);
      }
    }

    waitframe();
  }
}

function userskip_wait() {
  skipflag = "\xcc\xf6\xc2\xc1\xe8\xadl\xcfiP_";
  stopflag = "\x1f\x1cqU\xa8\xbe\xd3\x9dN\x94(\xb8Z";
  flags = [skipflag, stopflag];

  while(gettime() < 450) {
    waitframe();
  }

  foreach(flag in flags) {
    utility::flag_clear(flag);
  }

  setomnvar("\xf4^*\xf4v\xb4\x8a\xe3\xf0?\xf3\x89|\xa2I\xf7\\g\x95\xe2", 1);
  thread function_bd6775bd3ed230f0();
  thread userskip_input();

  while(!utility::flag(stopflag) && !utility::flag(skipflag)) {
    waitframe();
  }

  setomnvar("\xf4^*\xf4v\xb4\x8a\xe3\xf0?\xf3\x89|\xa2I\xf7\\g\x95\xe2", 0);
  level notify("\xe5\xa8N\xebO\x976\x0e\x1e \xb2\xa9\x8c\x18\x1c\xa2\x81s\x80Q\x06\x95'\xd8\xafk");
  return utility::flag(skipflag);
}

function function_bd6775bd3ed230f0() {
  self endon("\x1f\x1cqU\xa8\xbe\xd3\x9dN\x94(\xb8Z");
  utility::flag_wait("\xcc\xf6\xc2\xc1\xe8\xadl\xcfiP_");
  clearmusicstate();
  level.player setsoundsubmix("r\xd1a\xed\xf7\x83s##2\xdf\ao'Gck\xd2e", 1);
  utility::flag_wait("\x1f\x1cqU\xa8\xbe\xd3\x9dN\x94(\xb8Z");

  if(iscinematicplaying()) {
    level.player clearsoundsubmix("r\xd1a\xed\xf7\x83s##2\xdf\ao'Gck\xd2e", 1);
    return;
  }

  wait 60;
  level.player clearsoundsubmix("r\xd1a\xed\xf7\x83s##2\xdf\ao'Gck\xd2e", 1);
}

function userskip_input() {
  level endon("\xe5\xa8N\xebO\x976\x0e\x1e \xb2\xa9\x8c\x18\x1c\xa2\x81s\x80Q\x06\x95'\xd8\xafk");

  while(true) {
    level.player waittill("\xa6\xbd&nnj\xb4\x10\xf1\x12.cW.p", message, value);

    if(message == "\x9e\x94:\xf6\xbfm'\xd1\x10\x8e\xdb\x8e\xcc\xe4\xd7") {
      utility::flag_set("\xcc\xf6\xc2\xc1\xe8\xadl\xcfiP_");
      break;
    }
  }
}

function userskip_stop() {
  utility::flag_set("\x1f\x1cqU\xa8\xbe\xd3\x9dN\x94(\xb8Z");
}

function function_6b87c0877799674d() {
  level.player clearclienttriggeraudiozone(0.1);
  level.player stopsoundchannel("]\xd9 A\xa0w\xd2\xe0\xd8\x18\x8aYcO2\xe5");
  level.player stopsoundchannel("\x91v\x16\bV\x1b\xc2'I\x19\xd3\a#\xc5\xceQ|\x16\xb8\x96");
}

function get_adjusted_difficulty() {
  return gameskill::auto_adjust_difficult_get();
}

function civilianfailwrapper(deathquotearray, mindamage, playerdistance, ignoresplash) {
  self notify("j\x14\x87\x1d\xb0j\xb7\xd6)\xf3e({W\xf5nm\xd4\xb7\a\xe5o2_2\x1e");
  self endon("j\x14\x87\x1d\xb0j\xb7\xd6)\xf3e({W\xf5nm\xd4\xb7\a\xe5o2_2\x1e");
  level endon("\b\xda\xebw\xc3\xea{\xd4\a\x95$+\x04\x18\x7f\x90\x04\xfa\xd9Gg\tZ\xc1\xad\xc5\xdah\xc4\xa7\xc9");

  if(!isDefined(deathquotearray)) {
    deathquotearray = [%"hash_749bfa4b5858fd6e", %"hash_5cf74a1a09254e03"];
  }

  assert(isarray(deathquotearray), "<dev string:x659>");

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
  splasharray = ["M\x81\xaf\xee\xc9\xcfD\xef\x91J", "\x9az\x88\xfat)*\xe4\x14\x11\x15", "9\xe6R?Wcx5\xf2F%Q3W\x06z\xfe\a", "j\xa7\x11\xfa\x14J\xe9\x92\xa8\xd0*I\xc4\x8a\xd75\x05\x89\x05S\x90", "\xa2rl\xdaDn\x17b\xd9I\xc9=N", "\b\x89z\xc1\xf1\xd4I\xf3"];

  while(true) {
    self waittill("\fU`\xc0y\x95", damage, attacker, direction_vec, point, meansofdeath, modelname, tagname, partname, idflags, objweapon, origin, angles, normal, inflictor);

    if(!(isDefined(attacker) && isDefined(damage))) {
      continue;
    } else if(!isPlayer(attacker)) {
      continue;
    } else if(damage < mindamage) {
      continue;
    } else if(isDefined(meansofdeath) && istrue(ignoresplash) && arraycontains(splasharray, meansofdeath)) {
      continue;
    } else if(isDefined(objweapon) && objweapon.basename == "\xef\xd8\x94\x8d\xba") {
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
    distance = "<dev string:x67e>";
  } else {
    distance = sqrt(distance);
  }

  if(!isDefined(meansofdeath)) {
    print("<dev string:x68a>" + damage + "<dev string:x6a3>" + distance);
  } else {
    print("<dev string:x68a>" + damage + "<dev string:x6a3>" + distance + "<dev string:x6ad>" + meansofdeath);
  }

  level thread hud_util::fade_out(0);
  player_death::set_custom_death_quote(utility::array_randomize(deathquotearray)[0]);
  missionfailedwrapper();
}

function get_mount_activation_mode() {
  if(self usinggamepad()) {
    var_cc68ba06e3bf5835 = self getlocalplayerprofiledata("\xb1\bv\x98\x19\xaf\x9a\x01\x05H\x0f\xe0\x14\xb6\x98q\xc1");
  } else {
    var_cc68ba06e3bf5835 = self getlocalplayerprofiledata("\xed\xa5\x9de\x1cKvVn\xc3b\xa0\x7ff\xf5l\xee\xa6\xaa\xef");
  }

  switch (var_cc68ba06e3bf5835) {
    case 1:
      return "\xd23\x8e5\x83\xe4\xc5X";
    case 2:
      return "\x1e\x14\xe7\x1d\x98\x13\xe8\xbdW\xb1";
    case 3:
      return "\xa3\x85Wbr\x9c\xcf\x83\x8d";
    case 4:
      return "\xf3\xbc\xbbn\xfa\x0f\xec\x1c\xc0v";
    case 5:
      return "\x10\x89\xc9I\x96$\x8f";
    case 6:
      return "gX(O\xe2\x10$g\x154ed";
    case 7:
      return "\xe4\xf1G";
    case 8:
      return "\xebc\xea\x86z\xacd\x865\\9a\x8f";
    case 9:
      return "\xdf\x92\xf6w\x8d\x86\xe8\x92\xb5_\xa8vF\x8fa\xf1O\xa3";
    case 10:
      return "\xd2\x83$vy\x9a9\x95id(\xbf";
  }

  assertmsg("<dev string:x6b6>" + var_cc68ba06e3bf5835 + "<dev string:x6d0>");
}

function function_c919f542afb265af(player) {
  if(!isDefined(player)) {
    assertmsg("<dev string:x734>");
    return false;
  }

  if(player usinggamepad()) {
    return (player getlocalplayerprofiledata("\xcfv\xf6\xfb\x92\x0f\xa9~\xf8\xb7\x7fvO8\xe3L\x1c\x06N\xc0\a\x06\x18") != 1);
  }

  return player getlocalplayerprofiledata("\xdf\xba\x04\x10h6\xbc\xc9\x9f\xbc\xb6\xd3u\xb4WZ!Ev\x9b\xcdg\xe7r") != 1;
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
  thread door_sp::remove_open_prompts();
}

function door_ai_allowed(bool) {
  assert(isDefined(bool), "<dev string:x767>");
  self.lockedforai = !bool;

  if(bool) {
    thread door_sp::clear_navobstacle();
    return;
  }

  thread door_sp::create_navobstacle();
}

function door_force_open_fully(opener, time) {
  door::remove_door_snake_cam_ability();
  door_sp::remove_open_ability();
  door_sp::door_open_completely(opener, time);
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
    level.istrialslevel = utility::string_starts_with(level.script, "\x8a\x0f`\xae)(1");
  }

  return level.istrialslevel;
}

function weapon_empty(weaponobject) {
  if(!isDefined(weaponobject)) {
    return true;
  }

  if(isnullweapon(weaponobject)) {
    return true;
  }

  return weaponobject.basename == "\r+x5";
}

function function_e870fe627ccc1246() {
  return weapon_empty(level.player.currentweapon);
}

function function_22e2cbf088213a11(weaponbasename) {
  if(function_e870fe627ccc1246()) {
    return false;
  }

  if(level.player.currentweapon.basename == weaponbasename) {
    return true;
  }

  return false;
}

function function_8cc5ff2fc70ef9bc(offhandbasename) {
  offhandtype = offhands::getweaponoffhandtype(offhandbasename);
  return level.player getcurrentoffhand(offhandtype).basename == offhandbasename;
}

function function_be17795b0461bdf1() {
  return level.player isthrowinggrenade() || level.player isthrowingbackgrenade();
}

function function_d077dbd27c970245(string) {
  integer = undefined;

  while(true) {
    level.player waittill("\xa6\xbd&nnj\xb4\x10\xf1\x12.cW.p", notification, integer);

    if(notification == string) {
      break;
    }
  }

  return integer;
}

function function_10cbed9fdc811059() {
  level.player endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    if(function_d5ee08934163cb53()) {
      function_967ef81e68d8869a(1);
      wait 0.3;
      continue;
    }

    function_967ef81e68d8869a(0);
    wait 0.3;
  }
}

function function_d5ee08934163cb53() {
  assert(isDefined(level.foliagecontent), "<dev string:x780>");

  if(level.player getstance() == "\x8b\x90\xb5\xc4W") {
    return false;
  }

  if(!trace::sphere_trace_passed(level.player getEye(), level.player getEye() - (0, 0, 15), 20, undefined, level.foliagecontent)) {
    return true;
  }

  return false;
}

function function_967ef81e68d8869a(shoulddisplay) {
  if(getomnvar("\x06\xf0>\xf2@\xe3\x98\xe0#\xcd\x8b\x1e\xf8\x99\x90\xadU(\x14\xe5\x1f;\x8d4O\xc5L") != shoulddisplay) {
    setomnvar("\x06\xf0>\xf2@\xe3\x98\xe0#\xcd\x8b\x1e\xf8\x99\x90\xadU(\x14\xe5\x1f;\x8d4O\xc5L", shoulddisplay);
  }
}

function function_d177f2e6e10ae4b8(struct, var_405eccb440a4f5bc) {
  armorvestinteract = undefined;

  if(isstring(struct)) {
    armorvestinteract = utility::getStruct(struct, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  } else if(isstruct(struct)) {
    armorvestinteract = struct;
  }

  assert(isDefined(armorvestinteract), "<dev string:x7d8>");
  model = utility::spawn_model("5\xa8V\x0fHE5vC/\x82\x1d+2\x811\x92k\x0e=\xdd\xd4\x1f\xb4", armorvestinteract.origin, armorvestinteract.angles);

  if(!isDefined(var_405eccb440a4f5bc)) {
    var_405eccb440a4f5bc = &"shared_hintstrings/pickup_armor_vest";
  }

  model.armorvestinteract = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", armorvestinteract.origin);
  model.armorvestinteract cursor_hint::make_cursorhint(180, 150);
  model.armorvestinteract cursor_hint::set_presentation(var_405eccb440a4f5bc);
  model.armorvestinteract thread function_f1f11450df6c6159(model);
  return model;
}

function function_f1f11450df6c6159(armormodel) {
  self waittill("\x91`\xb1\xe7T\x97>");
  level.player function_c6662547657b8f0a();
  newarmoramount = level.player player_sp::getarmormaxamount();
  level.player player_sp::function_1ce6325d5bcc22a1(newarmoramount);
  level.player notify("C${\x7f\x7fw\xf8\xd9\x98!:s");

  if(soundexists("\x82~\a2\xa1\x82\xbb\x8f)\x8c\xb5\x16\xee\xe1`E\xbd")) {
    level.player playSound("\x82~\a2\xa1\x82\xbb\x8f)\x8c\xb5\x16\xee\xe1`E\xbd");
  }

  level.player player_gesture_force(" ZC\xc1*)\xcd\xc0\x9e.\xa5eqd");
  armormodel delete();
}

function function_c6662547657b8f0a() {
  setsaveddvar(@ "bg_piggybackarmoronnvg", 1);
  currentplatecount = player_sp::function_46965df0d3a78e7c();
  newplatecount = 1;

  if(currentplatecount >= 1) {
    newplatecount = currentplatecount + 1;
  }

  self.armor.plates = newplatecount;
  self.armor.maxplates = 3;
  player_sp::function_38272a9887d2838(newplatecount);
  player_sp::give_player_max_armor();
}

function function_cec5219f6002e4ae(struct, var_405eccb440a4f5bc) {
  armorplateinteract = undefined;

  if(isstring(struct)) {
    armorplateinteract = utility::getStruct(struct, "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc");
  } else if(isstruct(struct)) {
    armorplateinteract = struct;
  }

  assert(isDefined(armorplateinteract), "<dev string:x7d8>");
  model = utility::spawn_model("\x11\x95\x93\x10>\x81\xc0\xf3\xc3\x12w\xaeo\xeb\xf3\x06\xbc\xc3Q\xe03\x15?{~\xe3s\xe6\x15U\xddoj\xd1f\x1e\x02\rE", armorplateinteract.origin, armorplateinteract.angles);

  if(!isDefined(var_405eccb440a4f5bc)) {
    var_405eccb440a4f5bc = &"shared_hintstrings/armor_plate_pickup";
  }

  model.armorplateinteract = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", self.origin);
  model.armorplateinteract cursor_hint::create_cursor_hint(undefined, (0, 0, 6), var_405eccb440a4f5bc, 180, 160, 110, undefined, undefined, undefined, undefined, "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96", undefined, undefined, 180);
  model.armorplateinteract thread function_cfbd85594084bded(model, var_405eccb440a4f5bc);
  return model;
}

function private function_cfbd85594084bded(armormodel, var_405eccb440a4f5bc) {
  level.player endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x1e\xfd\xd1\xa2\a");

  while(true) {
    self waittill("\x91`\xb1\xe7T\x97>");

    if(!isDefined(armormodel)) {
      return;
    }

    if(!level.player function_9e15b5c22e9ef49a()) {
      display_hint_forced("v\x1e~\"\v\xf8\x1f\x17!_\x90", 2);
      cursor_hint::create_cursor_hint(undefined, (0, 0, 6), var_405eccb440a4f5bc, 180, 160, 110, undefined, undefined, undefined, undefined, "\xccq\x9aS\x05U\x10\x8d\x04\x93\x17\x88\xfa\x96", undefined, undefined, 180);
      continue;
    }

    level.player notify("C${\x7f\x7fw\xf8\xd9\x98!:s");

    if(soundexists("\x82~\a2\xa1\x82\xbb\x8f)\x8c\xb5\x16\xee\xe1`E\xbd")) {
      level.player playSound("\x82~\a2\xa1\x82\xbb\x8f)\x8c\xb5\x16\xee\xe1`E\xbd");
    }

    level.player player_gesture_force(" ZC\xc1*)\xcd\xc0\x9e.\xa5eqd");
    armormodel delete();
  }
}

function function_9e15b5c22e9ef49a() {
  currentplatecount = player_sp::function_46965df0d3a78e7c();

  if(currentplatecount >= 3) {
    return false;
  }

  player_sp::function_38272a9887d2838(currentplatecount + 1);
  return true;
}

function scriptable_door_get_in_radius(position, radius, maxheightdiff) {
  doors = getentitylessscriptablearray(undefined, undefined, position, radius, "\xe2\xc0Qo");
  filtereddoors = [];

  foreach(door in doors) {
    if(!door scriptableisdoor()) {
      continue;
    }

    if(isDefined(maxheightdiff)) {
      heightdiff = door.origin[2] - position[2];

      if(heightdiff <= maxheightdiff) {
        filtereddoors[filtereddoors.size] = door;
      }

      continue;
    }

    filtereddoors[filtereddoors.size] = door;
  }

  return filtereddoors;
}

function function_aadfdae17eafe3b5() {
  println("<dev string:x809>");

  while(!isDefined(level.player)) {
    waitframe();
  }

  var_c0a6a6a62fe85ebe = "jY\x8fk\xd9\xde\xba\xefz\xb6\x9cL\x0e~\xc7%hs\xde\xa3";
  sandboxloadoutdata = "\x7f\x9dX\xa2(\x06\x92\x15V\xa5\f\xf5\xe6\xb4\x06\xfbg\x8d";
  sandboxmissions = ["\xf3\xdb,\x0e\xf0\x80\xb89\xc1\xbc4", "Xw!.\x982g'\x01R\xd6\x9a/\xd0x", ")\xd7\x7f\x81\x1d}7*P_7\xef", "\f\x97_\x14\x9a\xf7\xfb\xbd\xf6}\xd2,L", "\x9f\xfc\\P\\\xee(\xe8\x16\x1c", ",3E,\xef\x123\xa5u\x13"];
  var_db1676919d8c504 = [128, 350, 64, 128, 128, 128];
  level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", "D\xb9\x14\xa0\xe7\x167\xb14\xa3\xbb\x1f\xdf\xb5\v\xc6RN\x0e\xfa2u1\xdflH", 0);
  level.player setprogressiondata("\x1dZ\xc2\xb0\x17\xb7\x9e\xd7\xf8\xcc\x0f\x16\xea\xce\xf3\xef\x0fy\xadTf0\x86\xd6\xc0", "\xb1\xe7\x97\x9d\x1e5^iL\xa8\x1c= \a\a\x9b\xc2\xa7\x03", "");
  level.player setprogressiondata("\x1dZ\xc2\xb0\x17\xb7\x9e\xd7\xf8\xcc\x0f\x16\xea\xce\xf3\xef\x0fy\xadTf0\x86\xd6\xc0", "&\x1b&\xbd\x1f\"\x04\x7f\x9a`t\xf0\x85\xc1G", "");

  for(j = 0; j < sandboxmissions.size; j++) {
    currentmission = sandboxmissions[j];

    for(i = 0; i < 40; i++) {
      level.player setprogressiondata(var_c0a6a6a62fe85ebe, currentmission, "\xe2\xcd\xabt?\\\a\x87Z", i, "b\x94\xb2\\;O~b2\xec\x8a", 0);
      level.player setprogressiondata(var_c0a6a6a62fe85ebe, currentmission, "\xe2\xcd\xabt?\\\a\x87Z", i, "<\xdd{2\xd7\xe7z\xd4\x04\x95d", 0);
    }

    level.player setprogressiondata(sandboxloadoutdata, currentmission, "\x99\x98\xdc\x8b\x9f\xe4\xcb\x95^\xc8pF\x17", 0);
    level.player setprogressiondata(sandboxloadoutdata, currentmission, "\xedWI\xf1\\y\x11\x03T'\xf3\xe8\xb5", 0);
    level.player setprogressiondata(sandboxloadoutdata, currentmission, "'e\xf1\x9e\xa6\xbb\xec\xde'\xcf-=\x19 +", 0);
    level.player setprogressiondata(sandboxloadoutdata, currentmission, "id7ya)\x8e\x12\x85\xa4\x99\xda\xa9\xd6\xec", 0);
    level.player setprogressiondata(sandboxloadoutdata, currentmission, "\x02\xb8<v\xdfrkl\x90`r\x8f\xf75", 0);

    for(i = 0; i < 16; i++) {
      level.player setprogressiondata("\x13\x83\xbcs\x15\x99\x90\xe0\xb9E\x87\xaf%j\x96j\xdb{\xfe)\xe5\xd7\xe3\xb4bx?", currentmission, "\xdeb\xa6V\x8dGZ\xece\xeb" + i, 0);
    }

    level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "?\xdf\x8b\x1c\xe3\xc8u\n\xd8", 0);
    level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "2cy\x04n\xb6\xe8/@\x84\x8a:\x97\xcd\xfd\xdbw\xdb\x8f\xea", 0);
    level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "g\xcf\x11\xa6;\xf9\xecpgm", 0);
    level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "\xaf\x80\xf4_&\x06r`uU\xac\xa8\x1b\xee", 0);
    level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "\xb0#\xdd^", 0);
    level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "\x10f\x10\x81\x81l^\xd1\xe1\xbe\x90A\xf5\xd3", 0);
    level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "\xd8(\xc0'\xc3\xe4\x93\xf18\x06\x85P", 1);

    for(i = 0; i < 16; i++) {
      level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "\xa3\xceP;\x9f\xb4H\xf6w>\xbb\x89", i, 0);
    }

    for(i = 0; i < 4; i++) {
      level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "\xea\xf0\xc10\x9bd\rPY\x8a\x9b", i, 0);
    }

    for(i = 0; i < var_db1676919d8c504[j]; i++) {
      level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "\xdd\x87_w\xf3?\xb8\x194\xb6\xb5\xe7[\xfb", i, 0);
    }

    for(i = 0; i < 25; i++) {
      level.player setprogressiondata("\xdc\xe0\x05N\xb7\xceDa\x1dX", currentmission + "\xc7,^S\x93>^\xae\xa5\xf3o\xd4\x93\xb1/", i, 0);
    }

    for(i = 0; i < 8096; i++) {
      level.player setprogressiondata("/~R\x9cC/u\xf7}gU\x9d", ".\x9d\xef\xf23\xe9.:\x13+L/\x16g\a", currentmission, "b\xa4\xd0\ay\xa57im\xbe\t\xbd\xd6\x93\xd7", i, 0);
    }
  }
}