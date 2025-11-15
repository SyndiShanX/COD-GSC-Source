/***************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_ca_red_river.gsc
***************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\gametypes\_hud_util;

main() {
  maps\mp\mp_ca_red_river_precache::main();
  maps\createart\mp_ca_red_river_art::main();
  maps\mp\mp_ca_red_river_fx::main();
  maps\mp\_breach::main();

  level thread maps\mp\_movers::main();
  level thread maps\mp\_movable_cover::init();

  PrintLn(GetTime() + " -- setting up custom funcs");
  level.mapCustomCrateFunc = ::redriverCustomCrateFunc;
  level.mapCustomKillstreakFunc = ::redriverCustomKillstreakFunc;
  level.mapCustomBotKillstreakFunc = ::redriverCustomBotKillstreakFunc;

  maps\mp\_load::main();

  maps\mp\_compass::setupMiniMap("compass_map_mp_ca_red_river");

  setdvar("r_lightGridEnableTweaks", 1);
  setdvar("r_lightGridIntensity", 1.33);
  setdvar("r_reactiveMotionWindAmplitudeScale", 3);
  setdvar("r_reactiveMotionWindFrequencyScale", .33);

  setdvar_cg_ng("r_specularColorScale", 2.5, 9);
  setdvar_cg_ng("r_diffuseColorScale", 1.25, 1.5);

  if(level.ps3) {
    SetDvar("sm_sunShadowScale", "0.4");
  } else if(level.xenon) {
    SetDvar("sm_sunShadowScale", "0.4");
  } else {
    SetDvar("sm_sunShadowScale", "0.9");
  }

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "desert";

  PrecacheMpAnim("rr_gate_open_out");
  PrecacheMpAnim("rr_gate_open_in");
  PrecacheMpAnim("mp_frag_metal_door_chain");

  flag_init("chain_broken");

  thread setup_pinatas();
  thread maps\mp\mp_ca_red_river_bridge_event::bridge_main();
  thread chain_gate();
  thread redriver_breach_init();

  thread maps\mp\_dlcalienegg::setupEggForMap("alienEasterEgg");
}

redriver_breach_init() {
  wait 0.5;

  breaches = getstructarray("breach", "targetname");
  proxy = getstructarray("breach_proxy", "targetname");

  foreach(breach in breaches) {
    pathnodes = GetNodeArray(breach.target, "targetname");
    foreach(p in pathnodes)
    p DisconnectNode();
  }

  foreach(p in proxy) {
    if(!isDefined(p.target))
      continue;
    breach = getstruct(p.target, "targetname");
    if(!isDefined(breach))
      continue;
    breaches[breaches.size] = breach;
  }
  array_thread(breaches, ::redriver_breach_update);
}

redriver_breach_update() {
  self waittill("breach_activated");

  eq_scale = 0.5;
  eq_duration = .5;
  eq_radius = 600;

  if(isDefined(self.script_dot))
    eq_scale = self.script_dot;
  if(isDefined(self.script_wait))
    eq_duration = self.script_wait;
  if(isDefined(self.radius))
    eq_radius = self.radius;

  Earthquake(eq_scale, eq_duration, self.origin, eq_radius);

  pathnodes = GetNodeArray(self.target, "targetname");
  foreach(p in pathnodes)
  p ConnectNode();
}

redriverCustomCrateFunc() {
  level thread maps\mp\mp_ca_red_river_bridge_device::redriverCustomCrateFunc();
}

redriverCustomKillstreakFunc() {
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/Care Package/RedRiver Bomb\" \"set scr_devgivecarepackage warhawk_mortars; set scr_devgivecarepackagetype airdrop_assault\"\n");
  AddDebugCommand("devgui_cmd \"MP/Killstreak/Level Event:5/River Bomb\" \"set scr_givekillstreak warhawk_mortars\"\n");

  level.killStreakFuncs["warhawk_mortars"] = ::tryUseRedRiverNuke;
  level.killstreakWeildWeapons["warhawk_mortar_mp"] = "warhawk_mortars";
}

redriverCustomBotKillstreakFunc() {
  AddDebugCommand("devgui_cmd\"MP/Bots(Killstreak)/Level Events:5/RedRiver Bomb\" \"set scr_testclients_givekillstreak warhawk_mortars\"\n");
  maps\mp\bots\_bots_ks::bot_register_killstreak_func("warhawk_mortars", maps\mp\bots\_bots_ks::bot_killstreak_simple_use);
}

tryUseRedRiverNuke(lifeId, streakName) {
  level notify("bridge_device_activate", self);
  return true;
}

setup_pinatas() {
  pinatas = getEntArray("pinata", "targetname");
  if(pinatas.size > 0) {
    foreach(pinata in pinatas)
    pinata thread update_pinata(level._effect["mp_ca_red_river_pinata_boom"]);
  }
  largePinatas = getEntArray("pinata_large", "targetname");
  if(largePinatas.size > 0) {
    foreach(pinata in largePinatas)
    pinata thread update_pinata(level._effect["mp_ca_red_river_pinata_boom_lg"]);
  }
}

update_pinata(death_effect) {
  self Show();
  self setCanDamage(true);
  explosionDirection = undefined;

  hitCounter = RandomIntRange(2, 4);
  while(hitCounter > 0) {
    self waittill("damage", amount, attacker, direction_vec, hit_point, damage_type);

    hitCounter--;
    explosionDirection = direction_vec;
    thread play_pinata_hit(level._effect["mp_ca_red_river_pinata"], hit_point, direction_vec);

    if(IsSubStr(damage_type, "MELEE") || IsSubStr(damage_type, "GRENADE")) {
      hitCounter = 0;
    } else if(IsSubStr(damage_type, "BULLET")) {
      if(amount > 60.0) {
        hitCounter = 0;
      } else {
        if(isDefined(attacker) && isDefined(attacker GetCurrentWeapon()) && (WeaponClass(attacker GetCurrentWeapon()) == "sniper")) {
          hitCounter = 0;
        }
      }
    }
  }

  if(!isDefined(explosionDirection))
    self waittill("damage", amount, attacker, direction_vec, hit_point, damage_type);
  else
    direction_vec = explosionDirection;

  self Hide();
  self setCanDamage(false);

  thread play_pinata_hit(death_effect, self GetOrigin(), direction_vec);
}

play_pinata_hit(effect_id, spawn_point, spawn_dir) {
  vfx_ent = SpawnFx(effect_id, spawn_point, anglesToForward(spawn_dir), AnglesToUp(spawn_dir));
  TriggerFX(vfx_ent);
  wait 5.0;
  vfx_ent Delete();
}

#using_animtree("animated_props");

chain_gate_trigger_wait_damage(gate_trigger) {
  level endon("chain_gate_trigger_damage");
  gate_trigger waittill("damage", amount, attacker, direction_vec, point, type);

  level notify("chain_gate_trigger_damage", amount, attacker, direction_vec, point, type);
}

chain_gate() {
  left_gate = GetEnt("left_gate", "targetname");

  lock = GetEnt("lock", "targetname");
  gate_clip = GetEnt("gate_clip", "targetname");
  gate_triggers = getEntArray("gate_trigger", "targetname");

  gate_anim_node = spawn("script_model", left_gate.origin);
  gate_anim_node setModel("generic_prop_raven");
  gate_anim_node.angles = left_gate.angles;
  waitframe();
  gate_clip DisconnectPaths();
  waitframe();

  waitframe();
  centerpoint = (0, 0, 0);
  num_trigs = 0;
  foreach(gate_trigger in gate_triggers) {
    add_to_bot_damage_targets(gate_trigger);
    centerpoint += gate_trigger.origin;
    num_trigs++;
  }
  centerpoint = centerpoint / num_trigs;

  level thread bot_outside_gate_watch();
  lock ScriptModelPlayAnim("mp_frag_metal_door_chain");

  left_gate setCanDamage(false);
  left_gate setCanRadiusDamage(false);

  lock setCanDamage(false);
  lock setCanRadiusDamage(false);

  foreach(gate_trigger in gate_triggers) {
    thread chain_gate_trigger_wait_damage(gate_trigger);
  }

  self waittill("chain_gate_trigger_damage", amount, attacker, direction_vec, point, type);

  lock playSound("scn_breach_gate_lock");

  if(IsExplosiveDamageMOD(type)) {
    direction_vec = centerpoint - point;
  }

  open_in = (direction_vec[1] < 0);

  lock Delete();
  foreach(gate_trigger in gate_triggers) {
    remove_from_bot_damage_targets(gate_trigger);
    gate_trigger Delete();
  }
  flag_set("chain_broken");

  if(open_in) {
    left_gate ScriptModelPlayAnim("rr_gate_open_in");
    gate_clip RotateYaw(130.00, .66);
  } else {
    left_gate ScriptModelPlayAnim("rr_gate_open_out");
    gate_clip RotateYaw(-130.00, .66);
  }

  left_gate playSound("scn_breach_gate_open_left");

  wait(0.5);

  gate_clip ConnectPaths();
  waitframe();
  gate_clip Delete();
}

bot_outside_gate_watch() {
  level endon("chain_broken");

  gate_triggers = getEntArray("gate_trigger", "targetname");
  near_gate_volume = GetEnt("near_gate_volume", "targetname");

  while(1) {
    if(isDefined(level.participants)) {
      foreach(participant in level.participants) {
        if(IsAI(participant) && participant IsTouching(near_gate_volume)) {
          gate_triggers[0] set_high_priority_target_for_bot(participant);
        }
      }
    }
    wait(1.0);
  }
}