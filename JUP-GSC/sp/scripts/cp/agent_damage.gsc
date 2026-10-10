/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\scripts\cp\agent_damage.gsc
***********************************************/

#using script_17ca3af80f14ce7e;
#using script_24fbedba9a7a1ef4;
#using scripts\common\utility;
#using scripts\cp\agent_drops;
#using scripts\cp\challenges_cp;
#using scripts\cp\cp_agent_utils;
#using scripts\cp\cp_analytics;
#using scripts\cp\cp_challenge;
#using scripts\cp\cp_gamescore;
#using scripts\cp\cp_merits;
#using scripts\cp\cp_weaponrank;
#using scripts\cp\damagefeedback;
#using scripts\cp\events;
#using scripts\cp\laststand;
#using scripts\cp\persistence;
#using scripts\cp\pickups;
#using scripts\cp\points;
#using scripts\cp\spawning;
#using scripts\cp\super;
#using scripts\cp\utility;
#using scripts\cp\utility\player;
#using scripts\cp\weapon;
#using scripts\cp_mp\agents\agent_juggernaut;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\challenges;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#namespace agent_damage;

function register_ai_damage_callbacks() {
  level.agent_funcs["soldier_agent"]["on_damaged"] = &namespace_daa149ca485fd50a::function_dffac413ed66bcd0;
  level.agent_funcs["soldier_agent"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["soldier_agent"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["soldier"]["on_damaged"] = &namespace_daa149ca485fd50a::function_dffac413ed66bcd0;
  level.agent_funcs["soldier"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["soldier"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["civilian"]["on_damaged"] = &namespace_daa149ca485fd50a::function_dffac413ed66bcd0;
  level.agent_funcs["civilian"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["civilian"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["juggernaut_agent"]["on_damaged"] = &scripts\cp_mp\agents\agent_juggernaut::function_1ab798a528080db2;
  level.agent_funcs["juggernaut_agent"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["juggernaut_agent"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["juggernaut"]["on_damaged"] = &scripts\cp_mp\agents\agent_juggernaut::function_1ab798a528080db2;
  level.agent_funcs["juggernaut"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["juggernaut"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["suicidebomber"]["on_damaged"] = &namespace_daa149ca485fd50a::function_dffac413ed66bcd0;
  level.agent_funcs["suicidebomber"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["suicidebomber"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;
  level.agent_funcs["dog"]["on_damaged"] = &namespace_daa149ca485fd50a::function_dffac413ed66bcd0;
  level.agent_funcs["dog"]["gametype_on_damage_finished"] = &callbacksoldieragentgametypedamagefinished;
  level.agent_funcs["dog"]["gametype_on_killed"] = &callbacksoldieragentgametypekilled;

  level thread check_for_damage_scalar_change();

  scripts\engine\utility::registersharedfunc("ai_mp_controller", "handleDamageFeedback", &scripts\cp\damagefeedback::function_4e514dcd8e549d1);
  scripts\engine\utility::registersharedfunc("ai_mp_controller", "agentPers_getAgentPersData", &scripts\cp_mp\agents\agent_utils::agentpers_getagentpersdata);
  scripts\engine\utility::registersharedfunc("ai_mp_controller", "agentPers_setAgentPersData", &scripts\cp_mp\agents\agent_utils::agentpers_setagentpersdata);
}

function function_8245dce28f1f395c(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  s = "<dev string:x1c>" + self getentitynumber();

  if(isDefined(einflictor)) {
    s += "<dev string:x2a>" + einflictor getentitynumber();
  }

  if(isDefined(eattacker)) {
    s += "<dev string:x33>" + eattacker getentitynumber();
  }

  s += "<dev string:x3c>" + idamage;
  s += "<dev string:x43>" + smeansofdeath;
  s += "<dev string:x4a>" + shitloc;
  println(s);
}

function function_f06b8ebf23e5f9f(shitloc) {
  if(shitloc == "shield") {
    return false;
  }

  return true;
}

function process_events_and_challenges_on_death(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname, objweapon) {
  evictim = self;
  evictim endon("death");

  if(!isPlayer(eattacker)) {
    if(isDefined(eattacker) && isDefined(eattacker.owner) && isPlayer(eattacker.owner)) {
      eattacker = eattacker.owner;
    } else {
      return;
    }
  }

  if(!function_f06b8ebf23e5f9f(shitloc)) {
    return;
  }

  if(idamage >= evictim.health) {
    if(isDefined(eattacker.longdeathtracker) && eattacker.longdeathtracker.size > 0) {
      if(istrue(eattacker.longdeathtracker[evictim getentitynumber()])) {
        return;
      }
    }

    eattacker thread scripts\cp\events::killedenemy(undefined, evictim, objweapon, smeansofdeath, einflictor, 0, shitloc);
    evictim thread scripts\cp\cp_challenge::onplayerkilled(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, shitloc, eattacker.modifiers);

    if(function_ccf98e6391dd38b9()) {
      if(isDefined(einflictor) && is_equal(einflictor.turrettype, "sentry_turret") && isDefined(einflictor getlinkedparent())) {
        var_908fffc5b0e6ba33 = einflictor getlinkedparent();

        if(var_908fffc5b0e6ba33.classname == "script_vehicle") {
          var_67c29faac82ca806 = eattacker getprogressiondata("spData", "achievementEngineeringDegree");
          var_67c29faac82ca806++;
          eattacker function_6a369480dbaf1090("jup_sp_engineeringdegree", var_67c29faac82ca806);
          eattacker setprogressiondata("spData", "achievementEngineeringDegree", var_67c29faac82ca806);
        }
      }

      if(isPlayer(eattacker) && eattacker isonzipline()) {
        var_3ebd5cbbe9a06a23 = eattacker getprogressiondata("spData", "achievementDriveBy");
        var_3ebd5cbbe9a06a23++;
        eattacker function_6a369480dbaf1090("jup_sp_driveby", var_3ebd5cbbe9a06a23);
        eattacker setprogressiondata("spData", "achievementDriveBy", var_3ebd5cbbe9a06a23);
      }
    }
  }
}

function adjust_damage_based_on_weaponclass(idamage, sweapon, weaponclass, type, attacker) {
  modifieddamage = idamage;

  switch (weaponclass) {
    case #"hash_8cdaf2e4ecfe5b51":
      modifieddamage = min(idamage, 84);
      break;
    case #"hash_900cb96c552c5e8e":
      modifieddamage = min(idamage, 110);
      break;
    case #"hash_fa24dff6bd60a12d":
      modifieddamage = min(idamage, 105);
      break;
    case #"hash_690c0d6a821b42e":
      modifieddamage = min(idamage, 84);
      break;
    case #"hash_719417cb1de832b6":
      modifieddamage = min(idamage, 75);
      break;
    case #"hash_6191aaef9f922f96":
      modifieddamage = min(idamage, 130);
      break;
    default:
      modifieddamage = idamage;
      break;
  }

  return idamage;
}

function is_exploder() {
  return istrue(isDefined(self.unittype) && self.unittype == "suicidebomber");
}

function check_for_damage_scalar_change() {
  level endon("game_ended");
  level.bullet_damage_scalar = 1;

  while(true) {
    scalar = getdvarfloat(@ "hash_2fb4f33570e8ab26", 1);

    if(level.bullet_damage_scalar != scalar) {
      level.bullet_damage_scalar = scalar;
    }

    wait 1;
  }
}

function register_ai_drop_funcs() {
  register_drop_func("weapon", &drop_weapon_func, &should_drop_weapon, 0);
}

function register_drop_func(name_string, func, chance_func, delay_time) {
  if(!isDefined(level.ai_drop_info)) {
    level.ai_drop_info = [];
  }

  struct = spawnStruct();
  struct.name = name_string;
  struct.chance_func = chance_func;
  struct.func = func;
  struct.score = 0;
  struct.delay = delay_time;
  struct.next_chance = 0;
  level.ai_drop_info[level.ai_drop_info.size] = struct;
}

function ai_drop_func(var_4d8d96d547df2e9f) {
  if(!isDefined(level.ai_drop_info)) {
    return;
  }

  if(isDefined(level.updatedroprelicsfunc)) {
    [[level.updatedroprelicsfunc]](self.origin, var_4d8d96d547df2e9f);
  }

  if(isDefined(self.force_drop)) {
    func = get_func_by_name(self.force_drop);
    self thread[[func]](var_4d8d96d547df2e9f);
    return;
  }

  dropped = check_for_drop(var_4d8d96d547df2e9f);
}

function get_func_by_name(name_string) {
  for(i = 0; i < level.ai_drop_info.size; i++) {
    if(level.ai_drop_info[i].name == name_string) {
      return level.ai_drop_info[i].func;
    }
  }
}

function drop_ready_item(drop_struct, var_4d8d96d547df2e9f) {
  cur_time = gettime();
  self thread[[drop_struct.func]](var_4d8d96d547df2e9f);
  drop_struct.score = 0;
  drop_struct.next_chance = cur_time + drop_struct.delay * 1000;
}

function check_for_drop(var_4d8d96d547df2e9f) {
  cur_time = gettime();
  dropped = 0;
  randomized_list = array_randomize(level.ai_drop_info);

  for(i = 0; i < randomized_list.size; i++) {
    drop_struct = randomized_list[i];

    if(!dropped) {
      if(cur_time > drop_struct.next_chance) {
        if(drop_struct.score > 99) {
          drop_ready_item(drop_struct, var_4d8d96d547df2e9f);
          dropped = 1;
          continue;
        }

        if([[drop_struct.chance_func]](var_4d8d96d547df2e9f)) {
          drop_ready_item(drop_struct, var_4d8d96d547df2e9f);
          dropped = 1;
        }
      }
    }
  }

  return dropped;
}

function drop_weapon_func(var_4d8d96d547df2e9f) {
  if(!istrue(var_4d8d96d547df2e9f.eattacker.no_enemy_weapon_drops)) {
    self.dropweapon = 1;
  }

  if(istrue(level.var_624ba233506a543e)) {
    self.dropweapon = 0;
  }

  if(istrue(self.var_ced8415aaad3ff6d)) {
    self.dropweapon = 1;
  }

  if(!isPlayer(var_4d8d96d547df2e9f.eattacker)) {
    return;
  }

  if(getdvarint(@ "hash_386d724e52893ac9")) {
    self.dropweapon = 0;
  }

  if(isDefined(var_4d8d96d547df2e9f.eattacker.class) && var_4d8d96d547df2e9f.eattacker.class == "crusader" || isDefined(level.ai_dropgren_override_hide)) {
    if(should_drop_grenade_pickup(var_4d8d96d547df2e9f.eattacker)) {
      drop_grenade(var_4d8d96d547df2e9f);
    }
  }

  if(var_4d8d96d547df2e9f.eattacker _hasperk("specialty_scavenger")) {
    if(should_drop_scavenger_bag(var_4d8d96d547df2e9f.eattacker)) {
      org = self.origin - (10, 10, 0);
      drop_scavenger_bag(var_4d8d96d547df2e9f, org);
    }
  }
}

function should_drop_scavenger_bag(player) {
  if(isDefined(self.chute)) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(isDefined(self.ridingvehicle)) {
    return false;
  }

  if(!isDefined(player.last_bag_drop_time)) {
    player.last_bag_drop_time = gettime();
    return true;
  }

  time_needed = 10000;
  var_ffa1faa3c8a198aa = gettime() - player.last_bag_drop_time;

  if(var_ffa1faa3c8a198aa > time_needed) {
    player.last_bag_drop_time = gettime();
    return true;
  }

  return false;
}

function drop_scavenger_bag(var_4d8d96d547df2e9f, loc_override) {
  loc = self.origin;

  if(isDefined(loc_override)) {
    loc = loc_override;
  }

  bag_obj = spawn("script_model", loc);
  bag_obj thread activate_scavenger_bag(var_4d8d96d547df2e9f.eattacker);
}

function activate_scavenger_bag(var_9401eb9dd9e3163b) {
  self endon("death");

  foreach(plr in level.players) {
    if(plr != var_9401eb9dd9e3163b) {
      self hidefromplayer(plr);
    }
  }

  self setModel("equipment_scavenger_bag");
  self.trigger = spawn("trigger_radius", self.origin, 0, 30, 10);
  thread delayentdelete(20);
  self.trigger thread delayentdelete(20);

  while(true) {
    self.trigger waittill("trigger", player);

    if(player == var_9401eb9dd9e3163b) {
      player playlocalsound("weap_ammo_pickup");
      player give_ammo_to_stock();
      player thread hudicontype("scavenger");
      self.trigger delete();
      self delete();
    }
  }
}

function give_clip_of_ammo() {
  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(!is_valid_player()) {
      continue;
    }

    if(weapontype(weapon) == "riotshield") {
      continue;
    }

    if(scripts\cp\weapon::is_incompatible_weapon(weapon)) {
      continue;
    }

    if(scripts\cp\weapon::is_launcher(weapon)) {
      continue;
    }

    if(cangive_ammo()) {
      cur_clip = self getweaponammoclip(weapon);
      cur_stock = self getweaponammostock(weapon);
      max_clip_ammo = weaponclipsize(weapon);
      total_ammo = cur_clip + cur_stock + max_clip_ammo;

      if(total_ammo == max_clip_ammo) {
        self setweaponammoclip(weapon, total_ammo);
        continue;
      }

      self setweaponammoclip(weapon, max_clip_ammo);
      stock_amt = total_ammo - max_clip_ammo;
      self setweaponammostock(weapon, stock_amt);
    }
  }
}

function give_ammo_to_stock() {
  var_6e98d61fbad956e0 = 30;
  bad_weapon = 0;
  weapon = self getcurrentprimaryweapon();

  if(!is_valid_player()) {
    bad_weapon = 1;
  }

  if(weapontype(weapon) == "riotshield") {
    bad_weapon = 1;
  }

  if(scripts\cp\weapon::is_incompatible_weapon(weapon)) {
    bad_weapon = 1;
  }

  if(scripts\cp\weapon::is_launcher(weapon)) {
    bad_weapon = 1;
  }

  if(!bad_weapon) {
    if(cangive_ammo()) {
      var_6e98d61fbad956e0 = getammooverride(weapon);
      cur_stock = self getweaponammostock(weapon);
      max_stock = scripts\cp\utility::function_ed18a118c6fa5c4f(weapon);
      added_stock = cur_stock + var_6e98d61fbad956e0;
      stock_amt = int(min(max_stock, added_stock));
      self setweaponammostock(weapon, stock_amt);
      return true;
    }
  }

  primary_weapons = self getweaponslistprimaries();

  foreach(weapon in primary_weapons) {
    if(!is_valid_player()) {
      continue;
    }

    if(weapontype(weapon) == "riotshield") {
      continue;
    }

    if(scripts\cp\weapon::is_incompatible_weapon(weapon)) {
      continue;
    }

    if(scripts\cp\weapon::is_launcher(weapon)) {
      continue;
    }

    if(cangive_ammo()) {
      var_6e98d61fbad956e0 = getammooverride(weapon);
      cur_stock = self getweaponammostock(weapon);
      max_stock = scripts\cp\utility::function_ed18a118c6fa5c4f(weapon);
      added_stock = cur_stock + var_6e98d61fbad956e0;
      stock_amt = int(min(max_stock, added_stock));
      self setweaponammostock(weapon, stock_amt);
      return true;
    }
  }

  return false;
}

function getammooverride(weaponobj) {
  baseweapon = weaponobj getbaseweapon();
  clipsize = weaponclipsize(baseweapon);
  rootname = getweaponrootname(weaponobj);
  var_ea03e2062e30ff1a = 30;
  ammooverride = var_ea03e2062e30ff1a;

  if(weaponobj.isalternate) {} else {
    switch (weaponobj.classname) {
      case #"hash_690c0d6a821b42e":
        switch (rootname) {
          case #"hash_30551216cbfc3a26":
            ammooverride = 6;
            break;
          case #"hash_68a11d587d71608f":
            ammooverride = 8;
            break;
          default:
            ammooverride = int(min(clipsize, var_ea03e2062e30ff1a));
            break;
        }

        break;
      case #"hash_6191aaef9f922f96":
        switch (rootname) {
          case #"hash_8d9ae5e5dd390b4b":
            ammooverride = 3;
            break;
          default:
            ammooverride = int(min(clipsize, var_ea03e2062e30ff1a));
            break;
        }

        break;
      default:
        ammooverride = int(min(clipsize, var_ea03e2062e30ff1a));
        break;
    }
  }

  return ammooverride;
}

function cangive_ammo() {
  currentweapon = getvalidtakeweapon();
  current_ammo = self getweaponammoclip(currentweapon);
  max_clip = weaponclipsize(currentweapon);
  max_stock = scripts\cp\utility::function_ed18a118c6fa5c4f(currentweapon);
  player_stock = self getweaponammostock(currentweapon);

  if(player_stock < max_stock || current_ammo < max_clip) {
    return 1;
  }

  return 0;
}

function should_drop_grenade_pickup(player) {
  if(isDefined(self.chute)) {
    return false;
  }

  if(!self isonground()) {
    return false;
  }

  if(isDefined(self.ridingvehicle)) {
    return false;
  }

  if(!isDefined(player.last_gren_drop_time)) {
    player.last_gren_drop_time = gettime();
    return true;
  }

  time_needed = 10000;
  var_ffa1faa3c8a198aa = gettime() - player.last_gren_drop_time;

  if(var_ffa1faa3c8a198aa > time_needed) {
    player.last_gren_drop_time = gettime();
    return true;
  }

  return false;
}

function drop_grenade(var_4d8d96d547df2e9f) {
  org = self.origin + (10, 10, 0);
  drop_grenade_internal(var_4d8d96d547df2e9f, org);
}

function drop_grenade_internal(var_4d8d96d547df2e9f, loc_override, player_show) {
  loc = self.origin;

  if(isDefined(loc_override)) {
    loc = loc_override;
  }

  grenade_obj = createhintobject(loc, "HINT_BUTTON", "cp_crate_icon_lethalrefill", &"COOP_GAME_PLAY/PICK_GRENADE", 5, "duration_short", "show", 200, undefined, 100, 360);
  grenade_obj setModel("offhand_wm_grenade_mike67");
  grenade_obj thread activate_grenade_object();
  grenade_obj thread delayentdelete(30);

  if(isDefined(player_show)) {
    foreach(plr in level.players) {
      if(plr != player_show) {
        grenade_obj hidefromplayer(plr);
      }
    }
  }
}

function activate_grenade_object() {
  self endon("death");

  while(true) {
    self waittill("trigger", player);
    player forceplaygestureviewmodel("iw9_ges_pickup");
    player playlocalsound("weap_ammo_pickup");

    foreach(power_struct in player.powers) {
      if(power_struct.slot == "primary") {
        player notify("pickup_equipment", power_struct.weaponuse);
        waitframe();
      }
    }

    self delete();
  }
}

function is_wearing_armor() {
  if(self.unittype == "juggernaut") {
    return 1;
  }

  if(scripts\cp\spawning::is_armored()) {
    return 1;
  }

  return 0;
}

function function_476c576900bfb449() {
  if(self.unittype == "juggernaut") {
    return 1;
  }

  if(istrue(self.wearing_helmet)) {
    return 1;
  }

  return 0;
}

function should_do_damage_checks(eattacker, idamage, smeansofdeath, sweapon, shitloc, victim, partname, damageloc) {
  if(!isDefined(sweapon)) {
    return 0;
  } else if(isDefined(level.should_do_damage_check_func) && ![[level.should_do_damage_check_func]](eattacker, idamage, smeansofdeath, sweapon, shitloc, victim)) {
    return 0;
  } else if(isDefined(self.var_71c1911e983f326d)) {
    return [[self.var_71c1911e983f326d]](idamage, smeansofdeath, sweapon, partname, damageloc);
  }

  if(isDefined(level.should_do_damage_check_func_relics)) {
    if(isarray(level.should_do_damage_check_func_relics) && level.should_do_damage_check_func_relics.size > 0) {
      foreach(func in level.should_do_damage_check_func_relics) {
        if(![[func]](eattacker, idamage, smeansofdeath, sweapon, shitloc, victim)) {
          return 0;
        }
      }
    }
  }

  return 1;
}

function ishighdamageweapon(objweapon) {
  return objweapon.classname == "sniper" || objweapon.classname == "dmr";
}

function should_drop_weapon(var_4d8d96d547df2e9f) {
  drop_test = getdvarint(@ "hash_6ae5d6c07e3e8c81");

  if(drop_test) {
    return true;
  }

  if(!isDefined(level.weapon_drop_cooldown)) {
    return false;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return false;
  }

  if(!isDefined(var_4d8d96d547df2e9f.eattacker)) {
    return false;
  }

  cooldown = 5;
  cur_time = gettime();
  player_num = var_4d8d96d547df2e9f.eattacker getentitynumber();

  if(!isDefined(level.weapon_drop_cooldown[player_num])) {
    level.weapon_drop_cooldown[player_num] = cur_time + cooldown * 1000;
    return true;
  }

  if(cur_time > level.weapon_drop_cooldown[player_num]) {
    level.weapon_drop_cooldown[player_num] = cur_time + cooldown * 1000;
    return true;
  }

  return false;
}

function is_flashbang(weaponname, objweapon, inflictor) {
  return weaponname == "flash_grenade_mp";
}

function is_gas(weaponname) {
  return weaponname == "gas_mp";
}

function callbacksoldieragentgametypedamagefinished(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vpoint, vdir, shitloc, timeoffset, stun_fraction, modelindex, partname) {
  if(smeansofdeath == "MOD_SUICIDE") {
    return;
  }

  idflags = 0;

  if(!isDefined(self.painsound)) {
    return;
  }

  if(gettime() > self.next_dmg_sound) {
    if(soundexists(self.painsound)) {
      self playSound(self.painsound);
    }

    self.next_dmg_sound = gettime() + 500;
  }
}

function function_7d9bbf6bbc649bbf(eattacker, agent, smeansofdeath, sweapon) {
  if(isPlayer(eattacker)) {
    scripts\cp\challenges_cp::function_a4f684e73d9ec4c6(eattacker);

    if(sweapon.basename == "bunkerbuster_mp" && isDefined(agent.aitype) && agent.aitype == "juggernaut") {
      scripts\cp\challenges_cp::function_472e90d2e14c4b53(eattacker);
    }
  }

  if(!isPlayer(eattacker.owner)) {
    return;
  }

  if(!isDefined(eattacker.team)) {
    return;
  }

  if(eattacker.team != "allies") {
    return;
  }

  if(isDefined(eattacker.defender_name)) {
    scripts\cp\challenges_cp::function_38154b1c06023442(eattacker.owner);
  }
}

function callbacksoldieragentgametypekilled(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration) {
  scripts\cp\cp_agent_utils::deactivateagent();
  thread function_7d9bbf6bbc649bbf(eattacker, self, smeansofdeath, sweapon);

  if(isDefined(level.updateonkillrelicsfunc)) {
    level thread[[level.updateonkillrelicsfunc]](sweapon, eattacker, self, smeansofdeath, shitloc);
  }

  if(scripts\cp_mp\utility\game_utility::function_b2c4b42f9236924()) {
    thread scripts\cp\pickups::spawnhealthpickup();
  }

  if(isDefined(level.spawnloopupdatefunc)) {
    [[level.spawnloopupdatefunc]](eattacker, sweapon);
  }

  if(isheadshot(sweapon, shitloc, smeansofdeath, eattacker)) {
    if(istrue(self.var_ad799295a6692b29)) {}
  }

  namespace_1fdb557af4bcd29e::function_3b55a5779a740df1();

  if(!istrue(self.var_ad799295a6692b29) && !istrue(level.var_ad799295a6692b29)) {
    thread scripts\cp\agent_drops::function_c568b761a7f0b678(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
  }

  if(is_exploder()) {
    if(!istrue(self.died_poorly)) {
      level notify("grenade_exploded_during_stealth", self.origin, "suicide_vest", get_stealth_breaking_guilty_player_name(einflictor, eattacker, self.origin));
    }
  }

  if(smeansofdeath == "MOD_SUICIDE") {
    return;
  }

  if(istrue(self.marked_for_death)) {
    self.marked_for_death = undefined;
  }

  if(isDefined(self.death_info_func)) {
    var_4d8d96d547df2e9f = spawnStruct();
    var_4d8d96d547df2e9f.einflictor = einflictor;
    var_4d8d96d547df2e9f.eattacker = eattacker;
    var_4d8d96d547df2e9f.idamage = idamage;
    var_4d8d96d547df2e9f.smeansofdeath = smeansofdeath;
    var_4d8d96d547df2e9f.sweapon = sweapon;
    var_4d8d96d547df2e9f.vdir = vdir;
    var_4d8d96d547df2e9f.shitloc = shitloc;
    var_4d8d96d547df2e9f.timeoffset = timeoffset;
    var_4d8d96d547df2e9f.deathanimduration = deathanimduration;
    thread[[self.death_info_func]](var_4d8d96d547df2e9f);
  }

  if(isDefined(eattacker.owner) && isPlayer(eattacker.owner)) {
    eattacker = eattacker.owner;
  }

  if(isPlayer(eattacker)) {
    level notify("enemy_killed", eattacker, self);
    level thread handle_death_sounds(eattacker, einflictor, self, smeansofdeath);
    self.died_poorly = undefined;
    kill_count = 1;
    scripts\cp\cp_analytics::logevent_kill(eattacker, self, sweapon);

    if(!function_240f7f4e57340e8f()) {
      var_bafbdb422ea9eaae = function_137b512700167b00(eattacker, self);
      level thread scripts\cp_mp\challenges::function_5a0ae8bc2b80c0c0(einflictor, eattacker, idamage, smeansofdeath, sweapon, shitloc, eattacker.modifiers, self.team, var_bafbdb422ea9eaae);
    }

    if(isDefined(eattacker.perk_data) && eattacker _hasperk("specialty_chain_killstreaks")) {
      var_199c16fdbeb2c72b = 10;
      amount = var_199c16fdbeb2c72b * eattacker.perk_data["super_fill_scalar"];
      eattacker scripts\cp\super::increase_super_progress(amount);
    }
  }

  if(isDefined(level.removefromtargetmarkeronkillfunc)) {
    level thread[[level.removefromtargetmarkeronkillfunc]](self);
  }

  if(isDefined(self.attackers)) {
    foreach(player in self.attackers) {
      if(!isDefined(_validateattacker(player))) {
        continue;
      }

      if(player == eattacker) {
        continue;
      }

      if(self == player) {
        continue;
      }

      if(isDefined(level.assists_disabled)) {
        continue;
      }

      assistweapon = undefined;

      if(isDefined(self.attackerdata)) {
        attackerdata = self.attackerdata[player.guid];

        if(isDefined(attackerdata)) {
          assistweapon = attackerdata.objweapon;
        }
      }

      bonusmagnitude = 0;

      if(self.attackerdata[player.guid].damage >= 35) {
        bonusmagnitude = 1;
      }

      if(self.attackerdata[player.guid].damage >= 70) {
        bonusmagnitude = 2;
      }

      player thread scripts\cp\cp_gamescore::processassist(self, assistweapon, bonusmagnitude);
    }
  }

  if(!function_240f7f4e57340e8f()) {
    give_attacker_kill_rewards(einflictor, eattacker, shitloc, smeansofdeath, sweapon);
  }

  idflags = 0;
  scripts\cp\damagefeedback::process_damage_feedback(einflictor, eattacker, idamage, idflags, smeansofdeath, sweapon, vdir, vdir, shitloc, timeoffset, self);
  scripts\cp\cp_merits::process_agent_on_killed_merits(einflictor, eattacker, idamage, smeansofdeath, sweapon, vdir, shitloc, timeoffset, deathanimduration);
  level thread add_to_notify_queue("ai_killed", self.origin, sweapon, smeansofdeath, eattacker, self, self.team);
}

function track_consecutive_kills() {
  self endon("death_or_disconnect");
  self notify("stop_tracking_consec_kills");
  self endon("stop_tracking_consec_kills");

  while(true) {
    level waittill("ai_killed", vpos, sweapon, smeansofdeath, eattacker, evictim, team);

    if(!isDefined(self.consecutive_kills)) {
      self.consecutive_kills = 1;
    } else {
      self.consecutive_kills += 1;
    }

    thread timeout_consec_kills();
  }
}

function timeout_consec_kills() {
  self endon("death_or_disconnect");
  self notify("stop_timeout_consec_kills");
  self endon("stop_timeout_consec_kills");
  wait get_consecutive_def();
  self.consecutive_kills = undefined;
}

function get_consecutive_def() {
  time = 3;

  if(_hasperk("specialty_killstreak_to_scorestreak")) {
    time += 3;
  }

  return time;
}

function handle_death_sounds(attacker, inflictor, victim, smeansofdeath) {
  if(!isbulletdamage(smeansofdeath)) {
    return;
  }

  if(isDefined(victim.deathsound) && soundexists(victim.deathsound)) {
    playsoundatpos(victim.origin, victim.deathsound);
  }

  if(!function_240f7f4e57340e8f() || isPlayer(inflictor)) {
    ent = victim;

    if(smeansofdeath == "MOD_HEAD_SHOT") {
      ent playsoundtoplayer("bullet_impact_headshot", attacker);
      ent playsoundtoteam("bullet_impact_headshot_npc", attacker.team, attacker);
      return;
    }

    ent playsoundtoplayer("mp_kill_alert", attacker);
    ent playsoundtoteam("mp_hit_alert_final_npc", attacker.team, attacker);
  }
}

function give_attacker_kill_rewards(einflictor, attacker, shitloc, smeansofdeath, sweapon) {
  if(!isDefined(attacker)) {
    return;
  }

  if(isDefined(self.team) && isDefined(attacker.team) && self.team == attacker.team) {
    return;
  }

  if(!isDefined(self.agent_type)) {
    return;
  }

  isjuggernaut = isDefined(self.unittype) && self.unittype == "juggernaut";
  agent_type = self.agent_type;
  agent_type = getsubstr(agent_type, 6, agent_type.size);
  reward_point = undefined;
  xp_reward = 0;

  if(isDefined(level.agent_definition[agent_type])) {
    if(isDefined(level.agent_definition[agent_type]["reward"])) {
      reward_point = level.agent_definition[agent_type]["reward"];
    }

    if(isDefined(level.agent_definition[agent_type]["xp"])) {
      xp_reward = level.agent_definition[agent_type]["xp"];
    }
  }

  if(!isDefined(reward_point)) {
    reward_point = 10;
  }

  if(isjuggernaut) {
    reward_point = getdvarint(@ "hash_702794f158de82b3", reward_point);
  } else {
    reward_point = getdvarint(@ "hash_697b2deb810da53b", reward_point);
  }

  var_33242ca76a448f6b = 0;
  isexploder = is_exploder();
  amount = undefined;

  if(isDefined(attacker.classname) && attacker.classname == "trigger_radius") {
    if(isDefined(level.consumable_cash_scalar)) {
      amount = reward_point * (1 + level.consumable_cash_scalar);
    } else {
      amount = reward_point;
    }

    foreach(player in level.players) {
      if(!player is_valid_player()) {
        continue;
      }

      if(isDefined(level.zombie_xp)) {
        player scripts\cp\persistence::give_player_xp(int(xp_reward));
      }

      if(istrue(level.special_event)) {
        continue;
      }

      size = "large";
      shitloc = "none";
      player scripts\cp\persistence::give_player_currency(amount, size, shitloc, 1, "crafted");
    }

    return;
  }

  if(!isPlayer(attacker) && (!isDefined(attacker.owner) || !isPlayer(attacker.owner))) {
    return;
  }

  if(isDefined(attacker.owner)) {
    attacker = attacker.owner;
    var_33242ca76a448f6b = 1;
  }

  if(!isjuggernaut) {
    if(isheadshot(sweapon, shitloc, smeansofdeath, attacker) && !var_33242ca76a448f6b && isbulletdamage(smeansofdeath) && !isexploder) {
      reward_point = 75;
    } else if(smeansofdeath == "MOD_MELEE") {
      reward_point = 75;
    }
  }

  if(isPlayer(attacker)) {
    if(!istrue(attacker.pers["ignoreWeaponMatchBonus"]) && (scripts\cp\weapon::iscacprimaryweapon(sweapon) || scripts\cp\weapon::iscacsecondaryweapon(sweapon))) {
      if(!isDefined(attacker.pers["weaponMatchBonusKills"])) {
        attacker.pers["weaponMatchBonusKills"] = 1;
      } else {
        attacker.pers["weaponMatchBonusKills"]++;
      }

      if(attacker.pers["weaponMatchBonusKills"] > scripts\cp\cp_weaponrank::getgametypekillspermatchmaximum()) {
        attacker.pers["ignoreWeaponMatchBonus"] = 1;
        attacker.pers["weaponMatchBonusKills"] = undefined;
        attacker.pers["killsPerWeapon"] = undefined;
      } else {
        if(!isDefined(attacker.pers["killsPerWeapon"])) {
          attacker.pers["killsPerWeapon"] = [];
        }

        rootname = getweaponrootname(sweapon);
        weaponfound = 0;

        foreach(data in attacker.pers["killsPerWeapon"]) {
          if(weaponkey == rootname) {
            data.killcount++;
            weaponfound = 1;
            break;
          }
        }

        if(!weaponfound) {
          data = spawnStruct();
          data.killcount = 1;
          data.basename = sweapon.basename;
          data.orderindex = attacker.pers["killsPerWeapon"].size;
          attacker.pers["killsPerWeapon"][rootname] = data;
        }
      }
    }
  }

  if(isDefined(level.kill_reward_func)) {
    reward_point = [[level.kill_reward_func]](einflictor, attacker, shitloc, smeansofdeath, sweapon, agent_type, reward_point);
  }

  if(isDefined(reward_point)) {
    givekillreward(einflictor, attacker, reward_point, xp_reward, "large", shitloc, sweapon, smeansofdeath);
  }
}

function givekillreward(einflictor, eattacker, amount, xp_reward, size, shitloc, sweapon, smeansofdeath) {
  if(isDefined(level.consumable_cash_scalar)) {
    amount *= 1 + level.consumable_cash_scalar;
  } else {
    amount = amount;
  }

  eattacker thread giveplayerbonuscash(einflictor, eattacker, amount, xp_reward, size, shitloc, sweapon, smeansofdeath);
  eattacker scripts\cp\persistence::record_player_kills(sweapon, shitloc, smeansofdeath, eattacker);

  if(isDefined(einflictor.owner) && istrue(einflictor.var_10f81a6bf4f5ce9a)) {
    eattacker thread scripts\cp\events::killeventtextpopup("assist", 1);
  }

  if(isDefined(self.shared_damage_points)) {
    foreach(player in level.players) {
      if(!player is_valid_player()) {
        continue;
      }

      if(istrue(level.special_event)) {
        continue;
      }

      player scripts\cp\persistence::give_player_currency(amount, size, shitloc, 1, "crafted");
    }
  } else if(should_get_currency_from_kill(einflictor, eattacker, sweapon)) {
    eattacker scripts\cp\persistence::give_player_currency(amount, size, shitloc, 1);
  }

  if(!is_specops_gametype()) {
    eattacker thread scripts\cp\points::doscoreevent(#"kill", sweapon, undefined, xp_reward, self);
  }
}

function giveplayerbonuscash(einflictor, eattacker, amount, xp_reward, size, shitloc, sweapon, smeansofdeath) {
  if(should_get_currency_from_kill(einflictor, eattacker, sweapon)) {
    if(eattacker is_consumable_active("extra_sniping_points") && isbulletdamage(smeansofdeath) && sweapon.classname == "weapon_sniper" && checkaltmodestatus(sweapon)) {
      bonusamount = 300;

      if(sweapon == "iw7_shared_fate_weapon") {
        eattacker notify_used_consumable("extra_sniping_points");
      } else {
        eattacker notify_used_consumable("extra_sniping_points");
        eattacker thread delaygivecurrency(bonusamount, size, shitloc, "bonus", 0.15);
      }
    }

    if(isPlayer(eattacker) && isDefined(eattacker.cash_scalar)) {
      if(isDefined(eattacker.cash_scalar_weapon) && eattacker.cash_scalar_weapon == getrawbaseweaponname(sweapon)) {
        var_74b7503d62e925ea = int(amount * eattacker.cash_scalar - amount);
        eattacker thread delaygivecurrency(var_74b7503d62e925ea, size, shitloc, "bonus", 0.25);
      }

      if(isDefined(eattacker.cash_scalar_alt_weapon) && eattacker.cash_scalar_alt_weapon == getrawbaseweaponname(sweapon) && istrue(sweapon.isalternate) && istrue(eattacker.alt_mode_passive)) {
        var_74b7503d62e925ea = int(amount * eattacker.cash_scalar - amount);
        eattacker thread delaygivecurrency(var_74b7503d62e925ea, size, shitloc, "bonus", 0.25);
      }
    }
  }
}

function delaygivecurrency(bonusamount, size, shitloc, var_800a3fd1e25bfd08, delaytime) {
  self endon("disconnect");
  wait delaytime;
  scripts\cp\persistence::give_player_currency(bonusamount, size, shitloc, 1, var_800a3fd1e25bfd08);
}

function should_get_currency_from_kill(einflictor, eattacker, sweapon) {
  if(isPlayer(eattacker) && scripts\cp\laststand::player_in_laststand(eattacker)) {
    return false;
  }

  if(is_trap(einflictor, sweapon)) {
    return false;
  }

  if(istrue(level.special_event)) {
    return false;
  }

  return true;
}

function checkaltmodestatus(sweapon) {
  if(!isDefined(sweapon) || sweapon == "none") {
    return 0;
  }

  baseweapon = getbaseweaponname(sweapon);

  switch (baseweapon) {
    case #"hash_8ecbf58c1c0044aa":
      if(isaltmodeweapon(sweapon)) {
        return 0;
      } else {
        return 1;
      }
    default:
      return 1;
  }
}

function addattacker(victim, eattacker, einflictor, objweapon, idamage, vpoint, vdir, shitloc, psoffsettime, smeansofdeath) {
  if(!isDefined(victim.attackerdata)) {
    victim.attackerdata = [];
  }

  if(!isDefined(eattacker.guid) && (isagent(eattacker) || isPlayer(eattacker))) {
    eattacker.guid = eattacker scripts\cp\utility\player::getuniqueid();
  }

  if(!isDefined(eattacker.guid)) {
    return;
  }

  if(!isDefined(victim.attackerdata[eattacker.guid])) {
    victim.attackers[eattacker.guid] = eattacker;
    victim.attackerdata[eattacker.guid] = spawnStruct();
    victim.attackerdata[eattacker.guid].damage = 0;
    victim.attackerdata[eattacker.guid].attackerent = eattacker;
    victim.attackerdata[eattacker.guid].firsttimedamaged = gettime();
    victim.attackerdata[eattacker.guid].hitcount = 1;
  } else {
    victim.attackerdata[eattacker.guid].hitcount++;
  }

  if(scripts\cp\weapon::iscacprimaryweapon(objweapon) && !scripts\cp\weapon::iscacsecondaryweapon(objweapon)) {
    victim.attackerdata[eattacker.guid].diddamagewithprimary = 1;
  }

  if(isDefined(smeansofdeath) && smeansofdeath != "MOD_MELEE") {
    victim.attackerdata[eattacker.guid].didnonmeleedamage = 1;
  }

  if(isDefined(objweapon)) {
    equipmenttype = getequipmenttype(objweapon.basename);
  }

  if(isDefined(equipmenttype)) {
    if(equipmenttype == "lethal") {
      victim.attackerdata[eattacker.guid].diddamagewithlethalequipment = 1;
    }

    if(equipmenttype == "tactical") {
      victim.attackerdata[eattacker.guid].diddamagewithtacticalequipment = 1;
    }
  }

  victim.attackerdata[eattacker.guid].damage += idamage;
  victim.attackerdata[eattacker.guid].weapon = isDefined(objweapon) ? getcompleteweaponname(objweapon) : "";
  victim.attackerdata[eattacker.guid].objweapon = objweapon;
  victim.attackerdata[eattacker.guid].vpoint = vpoint;
  victim.attackerdata[eattacker.guid].vdir = vdir;
  victim.attackerdata[eattacker.guid].shitloc = shitloc;
  victim.attackerdata[eattacker.guid].psoffsettime = psoffsettime;
  victim.attackerdata[eattacker.guid].smeansofdeath = smeansofdeath;
  victim.attackerdata[eattacker.guid].attackerent = eattacker;
  victim.attackerdata[eattacker.guid].lasttimedamaged = gettime();

  if(isDefined(einflictor) && !isPlayer(einflictor) && isDefined(einflictor.primaryweapon)) {
    victim.attackerdata[eattacker.guid].sprimaryweapon = einflictor.primaryweapon;
    return;
  }

  if(isDefined(eattacker) && isPlayer(eattacker) && !isnullweapon(eattacker getcurrentprimaryweapon())) {
    victim.attackerdata[eattacker.guid].sprimaryweapon = getcompleteweaponname(eattacker getcurrentprimaryweapon());
    return;
  }

  victim.attackerdata[eattacker.guid].sprimaryweapon = undefined;
}

function get_stealth_breaking_guilty_player_name(einflictor, eattacker, loc) {
  if(isPlayer(eattacker)) {
    return eattacker.name;
  }

  if(isPlayer(einflictor)) {
    return einflictor.name;
  }

  if(isDefined(einflictor.owner) && isPlayer(einflictor.owner)) {
    return einflictor.owner.name;
  }

  closest_player = getclosest(loc, level.players);
  return closest_player.name;
}

function _validateattacker(eattacker) {
  if(isagent(eattacker) && (!isDefined(eattacker.isactive) || !eattacker.isactive)) {
    return undefined;
  }

  if(isagent(eattacker) && !isDefined(eattacker.classname)) {
    return undefined;
  }

  return eattacker;
}

function function_20b668ea2dcba3c(var_4d8d96d547df2e9f) {
  drop_test = getdvarint(@ "hash_898730d6375934bc");

  if(drop_test) {
    return true;
  }

  if(isDefined(self.unittype) && self.unittype == "suicidebomber") {
    return false;
  }

  if(!istrue(level.var_8fde5731bb1ba3bb)) {
    return false;
  }

  return true;
}

function function_9ced4705330673a7(drop_org) {
  amount = 100;

  if(istrue(level.var_6ed343c3ff7515)) {
    return;
  }

  cash = spawn("script_model", drop_org + (0, 0, 40));
  cash.angles = (-180, 0, 0);
  cash setModel("cp_cash_drop");
  cash thread drop_cash(amount);
}

function drop_cash(amount) {
  self endon("death");
  self endon("auto_pickedup");
  self makeusable();
  amount = 100;
  self setHintString(&"CP_WEAPON_BUY/PICKUP_CASH");
  self sethintstringparams(amount);
  self setCursorHint("HINT_BUTTON");
  self sethinticon("hud_icon_br_plunder");
  self setuserange(92);
  self sethintdisplayrange(192);
  thread cash_timeout();
  thread auto_pickup(amount);
  self hudoutlineenable("outlinefill_depth_cyan");
  self moveTo(self.origin + (0, 0, -35), 0.25);

  while(true) {
    self waittill("trigger", player);
    self notify("pickedup");
    player scripts\cp\persistence::give_player_currency(amount, undefined, undefined, undefined, "cash_pickup");
    player playlocalsound("weap_pickup");
    self delete();
  }
}

function cash_timeout() {
  self endon("pickedup");
  self endon("auto_pickedup");
  wait 30;
  self notify("timeout");
  self delete();
}

function auto_pickup(amount) {
  self endon("pickedup");
  self endon("death");

  while(true) {
    foreach(player in level.players) {
      if(distancesquared(player.origin, self.origin) < squared(16)) {
        self notify("auto_pickedup");
        player scripts\cp\persistence::give_player_currency(amount, undefined, undefined, undefined, "cash_pickup");
        player playlocalsound("weap_pickup");
        self delete();
      }
    }

    wait 0.05;
  }
}