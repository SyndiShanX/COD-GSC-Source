/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_load_common.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_hud_util;
#using_animtree("generic_human");
level_notify_listener() {
  while(1) {
    val = getDvar(#"level_notify");
    if(val != "") {
      level notify(val);
      SetDvar("level_notify", "");
    }
    wait(0.2);
  }
}

client_notify_listener() {
  while(1) {
    val = getDvar(#"client_notify");
    if(val != "") {
      ClientNotify(val);
      SetDvar("client_notify", "");
    }
    wait(0.2);
  }
}

save_game_on_notify() {
  while(1) {
    level waittill("save");
    SaveGame("debug_save");
  }
}

onFirstPlayerReady() {
  level waittill("first_player_ready", player);
  println("**First player connected to game.");
}

set_early_level() {
  level.early_level = [];
  level.early_level["cuba"] = true;
  level.early_level["vorkuta"] = true;
}

setup_simple_primary_lights() {
  flickering_lights = getEntArray("generic_flickering", "targetname");
  pulsing_lights = getEntArray("generic_pulsing", "targetname");
  double_strobe = getEntArray("generic_double_strobe", "targetname");
  fire_flickers = getEntArray("fire_flicker", "targetname");
  array_thread(flickering_lights, maps\_lights::generic_flickering);
  array_thread(pulsing_lights, maps\_lights::generic_pulsing);
  array_thread(double_strobe, maps\_lights::generic_double_strobe);
  array_thread(fire_flickers, maps\_lights::fire_flicker);
}

weapon_ammo() {
  ents = getEntArray();
  for(i = 0; i < ents.size; i++) {
    if((isDefined(ents[i].classname)) && (GetSubStr(ents[i].classname, 0, 7) == "weapon_")) {
      weap = ents[i];
      change_ammo = false;
      clip = undefined;
      extra = undefined;
      if(isDefined(weap.script_ammo_clip)) {
        clip = weap.script_ammo_clip;
        change_ammo = true;
      }
      if(isDefined(weap.script_ammo_extra)) {
        extra = weap.script_ammo_extra;
        change_ammo = true;
      }
      if(change_ammo) {
        if(!isDefined(clip)) {
          assertmsg("weapon: " + weap.classname + " " + weap.origin + " sets script_ammo_extra but not script_ammo_clip");
        }
        if(!isDefined(extra)) {
          assertmsg("weapon: " + weap.classname + " " + weap.origin + " sets script_ammo_clip but not script_ammo_extra");
        }
        weap ItemWeaponSetAmmo(clip, extra);
        weap ItemWeaponSetAmmo(clip, extra, 1);
      }
    }
  }
}

trigger_group() {
  self thread trigger_group_remove();
  level endon("trigger_group_" + self.script_trigger_group);
  self waittill("trigger");
  level notify("trigger_group_" + self.script_trigger_group, self);
}

trigger_group_remove() {
  level waittill("trigger_group_" + self.script_trigger_group, trigger);
  if(self != trigger) {
    self Delete();
  }
}

exploder_load(trigger) {
  level endon("killexplodertridgers" + trigger.script_exploder);
  trigger waittill("trigger");
  if(isDefined(trigger.script_chance) && RandomFloat(1) > trigger.script_chance) {
    if(isDefined(trigger.script_delay)) {
      wait(trigger.script_delay);
    } else {
      wait(4);
    }
    level thread exploder_load(trigger);
    return;
  }
  exploder(trigger.script_exploder);
  level notify("killexplodertridgers" + trigger.script_exploder);
}

setup_traversals() {
  potential_traverse_nodes = GetAllNodes();
  for(i = 0; i < potential_traverse_nodes.size; i++) {
    node = potential_traverse_nodes[i];
    if(node.type == "Begin") {
      node call_overloaded_func("animscripts\traverse\shared", "init_traverse");
    }
  }
}

badplace_think(badplace) {
  if(!isDefined(level.badPlaces)) {
    level.badPlaces = 0;
  }
  level.badPlaces++;
  Badplace_Cylinder("badplace" + level.badPlaces, -1, badplace.origin, badplace.radius, 1024);
}

setupExploders() {
  level.exploders = [];
  ents = getEntArray("script_brushmodel", "classname");
  smodels = getEntArray("script_model", "classname");
  for(i = 0; i < smodels.size; i++) {
    ents[ents.size] = smodels[i];
  }
  for(i = 0; i < ents.size; i++) {
    if(isDefined(ents[i].script_prefab_exploder)) {
      ents[i].script_exploder = ents[i].script_prefab_exploder;
    }
    if(isDefined(ents[i].script_exploder)) {
      if(ents[i].script_exploder < 10000) {
        level.exploders[ents[i].script_exploder] = true;
      }
      if((ents[i].model == "fx") && ((!isDefined(ents[i].targetname)) || (ents[i].targetname != "exploderchunk"))) {
        ents[i] hide();
      } else if((isDefined(ents[i].targetname)) && (ents[i].targetname == "exploder")) {
        ents[i] hide();
        ents[i] NotSolid();
        if(isDefined(ents[i].script_disconnectpaths))
          ents[i] ConnectPaths();
      } else if((isDefined(ents[i].targetname)) && (ents[i].targetname == "exploderchunk")) {
        ents[i] hide();
        ents[i] NotSolid();
        if(ents[i] has_spawnflag(level.SPAWNFLAG_MODEL_DYNAMIC_PATH)) {
          ents[i] ConnectPaths();
        }
      }
    }
  }
  script_exploders = [];
  potentialExploders = getEntArray("script_brushmodel", "classname");
  for(i = 0; i < potentialExploders.size; i++) {
    if(isDefined(potentialExploders[i].script_prefab_exploder)) {
      potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
    }
    if(isDefined(potentialExploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialExploders[i];
    }
  }
  println("Server : Potential exploders from brushmodels " + potentialExploders.size);
  potentialExploders = getEntArray("script_model", "classname");
  for(i = 0; i < potentialExploders.size; i++) {
    if(isDefined(potentialExploders[i].script_prefab_exploder)) {
      potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
    }
    if(isDefined(potentialExploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialExploders[i];
    }
  }
  println("Server : Potential exploders from script_model " + potentialExploders.size);
  potentialExploders = getEntArray("item_health", "classname");
  for(i = 0; i < potentialExploders.size; i++) {
    if(isDefined(potentialExploders[i].script_prefab_exploder)) {
      potentialExploders[i].script_exploder = potentialExploders[i].script_prefab_exploder;
    }
    if(isDefined(potentialExploders[i].script_exploder)) {
      script_exploders[script_exploders.size] = potentialExploders[i];
    }
  }
  println("Server : Potential exploders from item_health " + potentialExploders.size);
  if(!isDefined(level.createFXent)) {
    level.createFXent = [];
  }
  acceptableTargetnames = [];
  acceptableTargetnames["exploderchunk visible"] = true;
  acceptableTargetnames["exploderchunk"] = true;
  acceptableTargetnames["exploder"] = true;
  exploderId = 1;
  for(i = 0; i < script_exploders.size; i++) {
    exploder = script_exploders[i];
    ent = createExploder(exploder.script_fxid);
    ent.v = [];
    ent.v["origin"] = exploder.origin;
    ent.v["angles"] = exploder.angles;
    ent.v["delay"] = exploder.script_delay;
    ent.v["firefx"] = exploder.script_firefx;
    ent.v["firefxdelay"] = exploder.script_firefxdelay;
    ent.v["firefxsound"] = exploder.script_firefxsound;
    ent.v["firefxtimeout"] = exploder.script_firefxtimeout;
    ent.v["trailfx"] = exploder.script_trailfx;
    ent.v["trailfxtag"] = exploder.script_trailfxtag;
    ent.v["trailfxdelay"] = exploder.script_trailfxdelay;
    ent.v["trailfxsound"] = exploder.script_trailfxsound;
    ent.v["trailfxtimeout"] = exploder.script_firefxtimeout;
    ent.v["earthquake"] = exploder.script_earthquake;
    ent.v["rumble"] = exploder.script_rumble;
    ent.v["damage"] = exploder.script_damage;
    ent.v["damage_radius"] = exploder.script_radius;
    ent.v["repeat"] = exploder.script_repeat;
    ent.v["delay_min"] = exploder.script_delay_min;
    ent.v["delay_max"] = exploder.script_delay_max;
    ent.v["target"] = exploder.target;
    ent.v["ender"] = exploder.script_ender;
    ent.v["physics"] = exploder.script_physics;
    ent.v["type"] = "exploder";
    ent.v["exploder_server"] = exploder.script_exploder_server;
    if(!isDefined(exploder.script_fxid)) {
      ent.v["fxid"] = "No FX";
    } else {
      ent.v["fxid"] = exploder.script_fxid;
    }
    ent.v["exploder"] = exploder.script_exploder;
    assertex(isDefined(exploder.script_exploder), "Exploder at origin " + exploder.origin + " has no script_exploder");
    if(!isDefined(ent.v["delay"])) {
      ent.v["delay"] = 0;
    }
    if(isDefined(exploder.script_sound)) {
      ent.v["soundalias"] = exploder.script_sound;
    } else if(ent.v["fxid"] != "No FX") {
      if(isDefined(level.scr_sound) && isDefined(level.scr_sound[ent.v["fxid"]])) {
        ent.v["soundalias"] = level.scr_sound[ent.v["fxid"]];
      }
    }
    exploder_id_set = false;
    if(isDefined(exploder.target)) {
      temp_ent = getEnt(ent.v["target"], "targetname");
      if(isDefined(temp_ent)) {
        exploder_id_set = true;
        temp_ent setexploderid(exploderId);
        exploderId++;
        org = temp_ent.origin;
        temp_ent transmittargetname();
      } else {
        temp_ent = GetStruct(ent.v["target"], "targetname");
        org = temp_ent.origin;
        exploderId++;
      }
      ent.v["angles"] = VectorToAngles(org - ent.v["origin"]);
    }
    if(exploder.classname == "script_brushmodel" || isDefined(exploder.model)) {
      if(exploder_id_set == false) {
        exploder setexploderid(exploderId);
        exploderId++;
        exploder_id_set = true;
      }
      ent.model = exploder;
      ent.model.disconnect_paths = exploder.script_disconnectpaths;
    }
    if(isDefined(exploder.targetname) && isDefined(acceptableTargetnames[exploder.targetname])) {
      ent.v["exploder_type"] = exploder.targetname;
    } else {
      ent.v["exploder_type"] = "normal";
    }
    ent maps\_createfx::post_entity_creation_function();
  }
  for(i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(ent.v["type"] != "exploder")
      continue;
    ent.v["exploder_id"] = getExploderId(ent);
  }
  reportExploderIds();
}

playerDamageRumble() {
  while(true) {
    self waittill("damage", amount);
    if(isDefined(self.specialDamage)) {
      continue;
    }
    self playRumbleOnEntity("damage_heavy");
  }
}

map_is_early_in_the_game() {
  return level.early_level[level.script];
}

player_throwgrenade_timer() {
  self endon("death");
  self endon("disconnect");
  self.lastgrenadetime = 0;
  while(1) {
    while(!self IsThroWingGrenade()) {
      wait(.05);
    }
    self.lastgrenadetime = GetTime();
    while(self IsThroWingGrenade()) {
      wait(.05);
    }
  }
}

player_special_death_hint() {
  self endon("disconnect");
  self thread player_throwgrenade_timer();
  if(isSplitScreen() || coopGame()) {
    return;
  }
  self waittill("death", attacker, cause, weaponName, inflicter);
  if(cause != "MOD_GRENADE" && cause != "MOD_GRENADE_SPLASH" && cause != "MOD_SUICIDE" && cause != "MOD_EXPLOSIVE" && cause != "MOD_PROJECTILE" && cause != "MOD_PROJECTILE_SPLASH") {
    return;
  }
  if(level.gameskill >= 2) {
    if(!map_is_early_in_the_game())
      return;
  }
  if(cause == "MOD_SUICIDE") {
    TimeSinceThrown = GetTime() - self.lastgrenadetime;
    if((TimeSinceThrown) < 3.5 * 1000 || (TimeSinceThrown) > 4.5 * 1000)
      return;
    level notify("new_quote_string");
    SetDvar("ui_deadquote", "");
    self thread grenade_death_text_hudelement(&"SCRIPT_GRENADE_SUICIDE_LINE1", & "SCRIPT_GRENADE_SUICIDE_LINE2");
    return;
  }
  if(cause == "MOD_EXPLOSIVE") {
    if(isDefined(attacker) && (attacker.classname == "script_vehicle" || isDefined(attacker.create_fake_vehicle_damage))) {
      level notify("new_quote_string");
      SetDvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
      thread special_death_indicator_hudelement("hud_burningcaricon", 96, 96);
      return;
    }
    if(isDefined(inflicter) && isDefined(inflicter.destructibledef)) {
      if(IsSubStr(inflicter.destructibledef, "barrel_explosive")) {
        level notify("new_quote_string");
        SetDvar("ui_deadquote", "@SCRIPT_EXPLODING_BARREL_DEATH");
        thread special_death_indicator_hudelement("hud_burningbarrelicon", 64, 64);
        return;
      }
      if(isDefined(inflicter.destructiblecar) && inflicter.destructiblecar) {
        level notify("new_quote_string");
        SetDvar("ui_deadquote", "@SCRIPT_EXPLODING_VEHICLE_DEATH");
        thread special_death_indicator_hudelement("hud_burningcaricon", 96, 96);
        return;
      }
    }
  }
  if(cause == "MOD_GRENADE" || cause == "MOD_GRENADE_SPLASH") {
    if(isDefined(weaponName) && (!IsWeaponDetonationTimed(weaponName) || WeaponType(weaponName) != "grenade")) {
      return;
    }
    level notify("new_quote_string");
    if(isDefined(weaponName) && (weaponName == "explosive_bolt_sp")) {
      SetDvar("ui_deadquote", "@SCRIPT_EXPLOSIVE_BOLT_DEATH");
      thread explosive_arrow_death_indicator_hudelement();
    } else {
      SetDvar("ui_deadquote", "@SCRIPT_GRENADE_DEATH");
      thread grenade_death_indicator_hudelement();
    }
    return;
  }
}

grenade_death_text_hudelement(textLine1, textLine2) {
  self.failingMission = true;
  SetDvar("ui_deadquote", "");
  wait(.5);
  fontElem = NewHudElem();
  fontElem.elemType = "font";
  fontElem.font = "default";
  fontElem.fontscale = 1.5;
  fontElem.x = 0;
  fontElem.y = -60;
  if(isDefined(level.zombiemode) && level.zombiemode) {
    fontElem.y = -65;
  }
  fontElem.alignX = "center";
  fontElem.alignY = "middle";
  fontElem.horzAlign = "center";
  fontElem.vertAlign = "middle";
  fontElem SetText(textLine1);
  fontElem.foreground = true;
  fontElem.alpha = 0;
  fontElem FadeOverTime(1);
  fontElem.alpha = 1;
  fontElem.hidewheninmenu = true;
  if(isDefined(textLine2)) {
    fontElem = NewHudElem();
    fontElem.elemType = "font";
    fontElem.font = "default";
    fontElem.fontscale = 1.5;
    fontElem.x = 0;
    fontElem.y = -60 + level.fontHeight * fontElem.fontscale;
    if(isDefined(level.zombiemode) && level.zombiemode) {
      fontElem.y = -60 + level.fontHeight * fontElem.fontscale;
    }
    fontElem.alignX = "center";
    fontElem.alignY = "middle";
    fontElem.horzAlign = "center";
    fontElem.vertAlign = "middle";
    fontElem SetText(textLine2);
    fontElem.foreground = true;
    fontElem.alpha = 0;
    fontElem FadeOverTime(1);
    fontElem.alpha = 1;
    fontElem.hidewheninmenu = true;
  }
}

grenade_death_indicator_hudelement() {
  self endon("disconnect");
  wait(.5);
  overlayIcon = NewClientHudElem(self);
  overlayIcon.x = 0;
  overlayIcon.y = 68;
  overlayIcon SetShader("hud_grenadeicon", 50, 50);
  overlayIcon.alignX = "center";
  overlayIcon.alignY = "middle";
  overlayIcon.horzAlign = "center";
  overlayIcon.vertAlign = "middle";
  overlayIcon.foreground = true;
  overlayIcon.alpha = 0;
  overlayIcon FadeOverTime(1);
  overlayIcon.alpha = 1;
  overlayIcon.hidewheninmenu = true;
  overlayPointer = NewClientHudElem(self);
  overlayPointer.x = 0;
  overlayPointer.y = 25;
  overlayPointer SetShader("hud_grenadepointer", 50, 25);
  overlayPointer.alignX = "center";
  overlayPointer.alignY = "middle";
  overlayPointer.horzAlign = "center";
  overlayPointer.vertAlign = "middle";
  overlayPointer.foreground = true;
  overlayPointer.alpha = 0;
  overlayPointer FadeOverTime(1);
  overlayPointer.alpha = 1;
  overlayPointer.hidewheninmenu = true;
  self thread grenade_death_indicator_hudelement_cleanup(overlayIcon, overlayPointer);
}

explosive_arrow_death_indicator_hudelement() {
  self endon("disconnect");
  wait(.5);
  overlayIcon = NewClientHudElem(self);
  overlayIcon.x = 0;
  overlayIcon.y = 68;
  overlayIcon SetShader("hud_explosive_arrow_icon", 50, 50);
  overlayIcon.alignX = "center";
  overlayIcon.alignY = "middle";
  overlayIcon.horzAlign = "center";
  overlayIcon.vertAlign = "middle";
  overlayIcon.foreground = true;
  overlayIcon.alpha = 0;
  overlayIcon FadeOverTime(1);
  overlayIcon.alpha = 1;
  overlayIcon.hidewheninmenu = true;
  overlayPointer = NewClientHudElem(self);
  overlayPointer.x = 0;
  overlayPointer.y = 25;
  overlayPointer SetShader("hud_grenadepointer", 50, 25);
  overlayPointer.alignX = "center";
  overlayPointer.alignY = "middle";
  overlayPointer.horzAlign = "center";
  overlayPointer.vertAlign = "middle";
  overlayPointer.foreground = true;
  overlayPointer.alpha = 0;
  overlayPointer FadeOverTime(1);
  overlayPointer.alpha = 1;
  overlayPointer.hidewheninmenu = true;
  self thread grenade_death_indicator_hudelement_cleanup(overlayIcon, overlayPointer);
}

grenade_death_indicator_hudelement_cleanup(hudElemIcon, hudElemPointer) {
  self endon("disconnect");
  self waittill("spawned");
  hudElemIcon Destroy();
  hudElemPointer Destroy();
}

special_death_indicator_hudelement(shader, iWidth, iHeight, fDelay, x, y) {
  if(!isDefined(fDelay)) {
    fDelay = 0.5;
  }
  wait(fDelay);
  overlay = NewClientHudElem(self);
  if(isDefined(x))
    overlay.x = x;
  else
    overlay.x = 0;
  if(isDefined(y))
    overlay.y = y;
  else
    overlay.y = 40;
  overlay SetShader(shader, iWidth, iHeight);
  overlay.alignX = "center";
  overlay.alignY = "middle";
  overlay.horzAlign = "center";
  overlay.vertAlign = "middle";
  overlay.foreground = true;
  overlay.alpha = 0;
  overlay FadeOverTime(1);
  overlay.alpha = 1;
  overlay.hidewheninmenu = true;
  self thread special_death_death_indicator_hudelement_cleanup(overlay);
}

special_death_death_indicator_hudelement_cleanup(overlay) {
  self endon("disconnect");
  self waittill("spawned");
  overlay Destroy();
}

bcTrigger(trigger) {
  realTrigger = undefined;
  if(isDefined(trigger.target)) {
    targetEnts = getEntArray(trigger.target, "targetname");
    if(IsSubStr(targetEnts[0].classname, "trigger")) {
      realTrigger = targetEnts[0];
    }
  }
  if(isDefined(realTrigger)) {
    realTrigger waittill("trigger", other);
  } else {
    trigger waittill("trigger", other);
  }
  soldier = undefined;
  if(isDefined(realTrigger)) {
    player_touching = get_player_touching(trigger);
    if(other.team == "axis" && isDefined(player_touching)) {
      soldier = get_closest_ai(player_touching GetOrigin(), "allies");
      if(Distance(soldier.origin, player_touching GetOrigin()) > 512) {
        return;
      }
    } else if(other.team == "allies") {
      soldiers = GetAiArray("axis");
      for(index = 0; index < soldiers.size; index++) {
        if(soldiers[index] IsTouching(trigger)) {
          soldier = soldiers[index];
        }
      }
    }
  } else if(IsPlayer(other)) {
    soldier = get_closest_ai(other GetOrigin(), "allies");
    if(Distance(soldier.origin, other GetOrigin()) > 512) {
      return;
    }
  } else {
    soldier = other;
  }
  if(!isDefined(soldier)) {
    return;
  }
  soldier custom_battlechatter(trigger.script_bctrigger);
}

waterThink() {
  assert(isDefined(self.target));
  targeted = getEnt(self.target, "targetname");
  assert(isDefined(targeted));
  waterHeight = targeted.origin[2];
  targeted = undefined;
  level.depth_allow_prone = 8;
  level.depth_allow_crouch = 33;
  level.depth_allow_stand = 50;
  for(;;) {
    wait(0.05);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      if(players[i].inWater) {
        players[i] AllowProne(true);
        players[i] AllowCrouch(true);
        players[i] AllowStand(true);
        thread waterThink_rampSpeed(level.default_run_speed);
      }
    }
    self waittill("trigger", other);
    if(!IsPlayer(other)) {
      continue;
    }
    while(1) {
      players = get_players();
      players_in_water_count = 0;
      for(i = 0; i < players.size; i++) {
        if(players[i] IsTouching(self)) {
          players_in_water_count++;
          players[i].inWater = true;
          playerOrg = players[i] GetOrigin();
          d = (playerOrg[2] - waterHeight);
          if(d > 0) {
            continue;
          }
          newSpeed = Int(level.default_run_speed - abs(d * 5));
          if(newSpeed < 50) {
            newSpeed = 50;
          }
          assert(newSpeed <= 190);
          thread waterThink_rampSpeed(newSpeed);
          if(abs(d) > level.depth_allow_crouch) {
            players[i] AllowCrouch(false);
          } else {
            players[i] AllowCrouch(true);
          }
          if(abs(d) > level.depth_allow_prone) {
            players[i] AllowProne(false);
          } else {
            players[i] AllowProne(true);
          }
        } else {
          if(players[i].inWater) {
            players[i].inWater = false;
          }
        }
      }
      if(players_in_water_count == 0) {
        break;
      }
      wait(0.5);
    }
    wait(0.05);
  }
  prof_end("water_stance_controller");
}

waterThink_rampSpeed(newSpeed) {
  level notify("ramping_water_movement_speed");
  level endon("ramping_water_movement_speed");
}

massNodeInitFunctions() {
  nodes = GetAllNodes();
  thread maps\_mgturret::auto_mgTurretLink(nodes);
  thread maps\_mgturret::saw_mgTurretLink(nodes);
  thread maps\_colors::init_color_grouping(nodes);
}

trigger_unlock(trigger) {
  noteworthy = "not_set";
  if(isDefined(trigger.script_noteworthy)) {
    noteworthy = trigger.script_noteworthy;
  }
  target_triggers = getEntArray(trigger.target, "targetname");
  trigger thread trigger_unlock_death(trigger.target);
  for(;;) {
    array_thread(target_triggers, ::trigger_off);
    trigger waittill("trigger");
    array_thread(target_triggers, ::trigger_on);
    wait_for_an_unlocked_trigger(target_triggers, noteworthy);
    array_notify(target_triggers, "relock");
  }
}

trigger_unlock_death(target) {
  self waittill("death");
  target_triggers = getEntArray(target, "targetname");
  array_thread(target_triggers, ::trigger_off);
}

wait_for_an_unlocked_trigger(triggers, noteworthy) {
  level endon("unlocked_trigger_hit" + noteworthy);
  ent = spawnStruct();
  for(i = 0; i < triggers.size; i++) {
    triggers[i] thread report_trigger(ent, noteworthy);
  }
  ent waittill("trigger");
  level notify("unlocked_trigger_hit" + noteworthy);
}

report_trigger(ent, noteworthy) {
  self endon("relock");
  level endon("unlocked_trigger_hit" + noteworthy);
  self waittill("trigger");
  ent notify("trigger");
}

get_trigger_targs() {
  triggers = [];
  target_origin = undefined;
  if(isDefined(self.target)) {
    targets = getEntArray(self.target, "targetname");
    orgs = [];
    for(i = 0; i < targets.size; i++) {
      if(targets[i].classname == "script_origin") {
        orgs[orgs.size] = targets[i];
      }
      if(IsSubStr(targets[i].classname, "trigger")) {
        triggers[triggers.size] = targets[i];
      }
    }
    assertex(orgs.size < 2, "Trigger at " + self.origin + " targets multiple script origins");
    if(orgs.size == 1) {
      target_origin = orgs[0].origin;
      orgs[0] Delete();
    }
  }
  assertex(isDefined(target_origin), self.targetname + " at " + self.origin + " has no target origin.");
  array = [];
  array["triggers"] = triggers;
  array["target_origin"] = target_origin;
  return array;
}

trigger_lookat(trigger) {
  trigger_lookat_think(trigger, true);
}

trigger_looking(trigger) {
  trigger_lookat_think(trigger, false);
}

trigger_lookat_think(trigger, endOnFlag) {
  dot = 0.78;
  if(isDefined(trigger.script_dot)) {
    dot = trigger.script_dot;
  }
  array = trigger get_trigger_targs();
  triggers = array["triggers"];
  target_origin = array["target_origin"];
  has_flag = isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy);
  flagName = undefined;
  if(has_flag) {
    flagName = trigger get_trigger_flag();
    if(!isDefined(level.flag[flagName])) {
      flag_init(flagName);
    }
  } else {
    if(!triggers.size) {
      assertex(isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy), "Trigger_lookat at " + trigger.origin + " has no script_flag! The script_flag is used as a flag that gets set when the trigger is activated.");
    }
  }
  if(endOnFlag && has_flag) {
    level endon(flagName);
  }
  trigger endon("death");
  for(;;) {
    if(has_flag) {
      flag_clear(flagName);
    }
    trigger waittill("trigger", other);
    assertex(IsPlayer(other), "trigger_lookat currently only supports looking from the player");
    if(!IsPlayer(other)) {
      continue;
    }
    while(other IsTouching(trigger)) {
      if(!SightTracePassed(other getEye(), target_origin, false, undefined)) {
        if(has_flag) {
          flag_clear(flagName);
        }
        wait(0.5);
        continue;
      }
      normal = VectorNormalize(target_origin - other.origin);
      player_angles = other GetPlayerAngles();
      player_forward = anglesToForward(player_angles);
      dot = VectorDot(player_forward, normal);
      if(dot >= 0.78) {
        if(has_flag) {
          flag_set(flagName);
        }
        array_thread(triggers, ::send_notify, "trigger");
        if(endOnFlag) {
          return;
        }
        wait(2);
      } else {
        if(has_flag) {
          flag_clear(flagName);
        }
      }
      wait(0.5);
    }
  }
}

trigger_CanSee(trigger) {
  triggers = [];
  target_origin = undefined;
  array = trigger get_trigger_targs();
  triggers = array["triggers"];
  target_origin = array["target_origin"];
  has_flag = isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy);
  flagName = undefined;
  if(has_flag) {
    flagName = trigger get_trigger_flag();
    if(!isDefined(level.flag[flagName])) {
      flag_init(flagName);
    }
  } else {
    if(!triggers.size) {
      assertex(isDefined(trigger.script_flag) || isDefined(trigger.script_noteworthy), "Trigger_cansee at " + trigger.origin + " has no script_flag! The script_flag is used as a flag that gets set when the trigger is activated.");
    }
  }
  trigger endon("death");
  range = 12;
  offsets = [];
  offsets[offsets.size] = (0, 0, 0);
  offsets[offsets.size] = (range, 0, 0);
  offsets[offsets.size] = (range * -1, 0, 0);
  offsets[offsets.size] = (0, range, 0);
  offsets[offsets.size] = (0, range * -1, 0);
  offsets[offsets.size] = (0, 0, range);
  for(;;) {
    if(has_flag) {
      flag_clear(flagName);
    }
    trigger waittill("trigger", other);
    assertex(IsPlayer(other), "trigger_cansee currently only supports looking from the player");
    while(other IsTouching(trigger)) {
      if(!(other cantraceto(target_origin, offsets))) {
        if(has_flag) {
          flag_clear(flagName);
        }
        wait(0.1);
        continue;
      }
      if(has_flag) {
        flag_set(flagName);
      }
      array_thread(triggers, ::send_notify, "trigger");
      wait(0.5);
    }
  }
}

cantraceto(target_origin, offsets) {
  for(i = 0; i < offsets.size; i++) {
    if(SightTracePassed(self getEye(), target_origin + offsets[i], true, self)) {
      return true;
    }
  }
  return false;
}

indicate_start(start) {
  hudelem = NewHudElem();
  hudelem.alignX = "left";
  hudelem.alignY = "middle";
  hudelem.x = 70;
  hudelem.y = 400;
  hudelem.label = start;
  hudelem.alpha = 0;
  hudelem.fontScale = 3;
  wait(1);
  hudelem FadeOverTime(1);
  hudelem.alpha = 1;
  wait(5);
  hudelem FadeOverTime(1);
  hudelem.alpha = 0;
  wait(1);
  hudelem Destroy();
}

trigger_notify(trigger, msg) {
  trigger endon("death");
  trigger waittill("trigger", other);
  if(isDefined(trigger.target)) {
    notify_ent = getEnt(trigger.target, "targetname");
    if(isDefined(notify_ent)) {
      notify_ent notify(msg, other);
    }
  }
  level notify(msg, other);
}

flag_set_player_trigger(trigger) {
  flag = trigger get_trigger_flag();
  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }
  for(;;) {
    trigger waittill("trigger", other);
    if(!IsPlayer(other)) {
      continue;
    }
    self script_delay();
    flag_set(flag);
  }
}

flag_set_trigger(trigger, flag_name) {
  trigger endon("death");
  flag = trigger get_trigger_flag(flag_name);
  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }
  for(;;) {
    trigger waittill("trigger");
    if(isDefined(trigger.targetname) && (trigger.targetname == "flag_set")) {
      self script_delay();
    }
    flag_set(flag);
  }
}

flag_clear_trigger(trigger, flag_name) {
  trigger endon("death");
  flag = trigger get_trigger_flag(flag_name);
  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }
  for(;;) {
    trigger waittill("trigger");
    if(isDefined(trigger.targetname) && (trigger.targetname == "flag_clear")) {
      self script_delay();
    }
    flag_clear(flag);
  }
}

add_tokens_to_trigger_flags(tokens) {
  for(i = 0; i < tokens.size; i++) {
    flag = tokens[i];
    if(!isDefined(level.trigger_flags[flag])) {
      level.trigger_flags[flag] = [];
    }
    level.trigger_flags[flag][level.trigger_flags[flag].size] = self;
  }
}

script_flag_false_trigger(trigger) {
  tokens = create_flags_and_return_tokens(trigger.script_flag_false);
  trigger add_tokens_to_trigger_flags(tokens);
  trigger update_trigger_based_on_flags();
}

script_flag_true_trigger(trigger) {
  tokens = create_flags_and_return_tokens(trigger.script_flag_true);
  trigger add_tokens_to_trigger_flags(tokens);
  trigger update_trigger_based_on_flags();
}

wait_for_flag(tokens) {
  for(i = 0; i < tokens.size; i++) {
    level endon(tokens[i]);
  }
  level waittill("foreverrr");
}

friendly_respawn_trigger(trigger) {
  spawners = getEntArray(trigger.target, "targetname");
  assertex(spawners.size == 1, "friendly_respawn_trigger targets multiple spawner with targetname " + trigger.target + ". Should target just 1 spawner.");
  spawner = spawners[0];
  assertex(!isDefined(spawner.script_forcecolor), "targeted spawner at " + spawner.origin + " should not have script_forcecolor set!");
  spawners = undefined;
  spawner endon("death");
  for(;;) {
    trigger waittill("trigger");
    if(isDefined(trigger.script_forcecolor)) {
      level.respawn_spawners_specific[trigger.script_forcecolor] = spawner;
    } else {
      level.respawn_spawner = spawner;
    }
    flag_set("respawn_friendlies");
    wait(0.5);
  }
}

friendly_respawn_clear(trigger) {
  for(;;) {
    trigger waittill("trigger");
    flag_clear("respawn_friendlies");
    wait(0.5);
  }
}

trigger_ignore(trigger) {
  thread trigger_runs_function_on_touch(trigger, ::set_ignoreme, ::get_ignoreme);
}

trigger_pacifist(trigger) {
  thread trigger_runs_function_on_touch(trigger, ::set_pacifist, ::get_pacifist);
}

trigger_runs_function_on_touch(trigger, set_func, get_func) {
  for(;;) {
    trigger waittill("trigger", other);
    if(!IsAlive(other)) {
      continue;
    }
    if(other[[get_func]]()) {
      continue;
    }
    other thread touched_trigger_runs_func(trigger, set_func);
  }
}

touched_trigger_runs_func(trigger, set_func) {
  self endon("death");
  self.ignoreme = true;
  [[set_func]](true);
  self.ignoretriggers = true;
  wait(1);
  self.ignoretriggers = false;
  while(self IsTouching(trigger)) {
    wait(1);
  }
  [[set_func]](false);
}

trigger_turns_off(trigger) {
  trigger waittill("trigger");
  trigger trigger_off();
  if(!isDefined(trigger.script_linkTo)) {
    return;
  }
  tokens = Strtok(trigger.script_linkto, " ");
  for(i = 0; i < tokens.size; i++) {
    array_thread(getEntArray(tokens[i], "script_linkname"), ::trigger_off);
  }
}

script_gen_dump_checksaved() {
  signatures = GetArrayKeys(level.script_gen_dump);
  for(i = 0; i < signatures.size; i++) {
    if(!isDefined(level.script_gen_dump2[signatures[i]])) {
      level.script_gen_dump[signatures[i]] = undefined;
      level.script_gen_dump_reasons[level.script_gen_dump_reasons.size] = "Signature unmatched( removed feature ): " + signatures[i];
    }
  }
}

script_gen_dump() {
  assertex(!level.bScriptgened, "SCRIPTGEN generated: follow instructions listed above this error in the console");
  if(level.bScriptgened) {
    assertmsg("SCRIPTGEN updated: Rebuild fast file and run map again");
  }
  flag_set("scriptgen_done");
}

script_gen_csvdumpprintln(file, signature) {
  prefix = undefined;
  writtenprefix = undefined;
  path = "";
  extension = "";
  if(IsSubStr(signature, "ignore")) {
    prefix = "ignore";
  } else if(IsSubStr(signature, "col_map_sp")) {
    prefix = "col_map_sp";
  } else if(IsSubStr(signature, "gfx_map")) {
    prefix = "gfx_map";
  } else if(IsSubStr(signature, "rawfile")) {
    prefix = "rawfile";
  } else if(IsSubStr(signature, "sound")) {
    prefix = "sound";
  } else if(IsSubStr(signature, "xmodel")) {
    prefix = "xmodel";
  } else if(IsSubStr(signature, "xanim")) {
    prefix = "xanim";
  } else if(IsSubStr(signature, "item")) {
    prefix = "item";
    writtenprefix = "weapon";
    path = "sp/";
  } else if(IsSubStr(signature, "fx")) {
    prefix = "fx";
  } else if(IsSubStr(signature, "menu")) {
    prefix = "menu";
    writtenprefix = "menufile";
    path = "ui/scriptmenus/";
    extension = ".menu";
  } else if(IsSubStr(signature, "rumble")) {
    prefix = "rumble";
    writtenprefix = "rawfile";
    path = "rumble/";
  } else if(IsSubStr(signature, "shader")) {
    prefix = "shader";
    writtenprefix = "material";
  } else if(IsSubStr(signature, "shock")) {
    prefix = "shock";
    writtenprefix = "rawfile";
    extension = ".shock";
    path = "shock/";
  } else if(IsSubStr(signature, "string")) {
    prefix = "string";
    assertmsg("string not yet supported by scriptgen");
  } else if(IsSubStr(signature, "turret")) {
    prefix = "turret";
    writtenprefix = "weapon";
    path = "sp/";
  } else if(IsSubStr(signature, "vehicle")) {
    prefix = "vehicle";
    writtenprefix = "rawfile";
    path = "vehicles/";
  }
  if(!isDefined(prefix)) {
    return;
  }
  if(!isDefined(writtenprefix)) {
    string = prefix + ", " + GetSubStr(signature, prefix.size + 1, signature.size);
  } else {
    string = writtenprefix + ", " + path + GetSubStr(signature, prefix.size + 1, signature.size) + extension;
  }
  if(file == -1 || !level.bCSVgened) {
    println(string);
  } else {
    FPrintLn(file, string);
  }
}

script_gen_dumpprintln(file, string) {
  if(file == -1 || !level.bScriptgened) {
    println(string);
  } else {
    FPrintLn(file, string);
  }
}

trigger_hInt(trigger) {
  assertex(isDefined(trigger.script_hint), "Trigger_hint at " + trigger.origin + " has no .script_hint");
  trigger endon("death");
  if(!isDefined(level.displayed_hints)) {
    level.displayed_hints = [];
  }
  waittillframeend;
  hint = trigger.script_hint;
  assertex(isDefined(level.trigger_hint_string[hint]), "Trigger_hint with hint " + hint + " had no hint string assigned to it. Define hint strings with add_hint_string()");
  trigger waittill("trigger", other);
  assertex(IsPlayer(other), "Tried to do a trigger_hint on a non player entity");
  if(isDefined(level.displayed_hints[hint])) {
    return;
  }
  level.displayed_hints[hint] = true;
  display_hInt(hint);
}

throw_grenade_at_player_trigger(trigger) {
  trigger endon("death");
  trigger waittill("trigger");
  ThrowGrenadeAtPlayerASAP();
}

flag_on_cleared(trigger) {
  flag = trigger get_trigger_flag();
  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }
  for(;;) {
    trigger waittill("trigger");
    wait(1);
    if(trigger found_toucher()) {
      continue;
    }
    break;
  }
  flag_set(flag);
}

found_toucher() {
  ai = GetAiArray("axis");
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(!IsAlive(guy)) {
      continue;
    }
    if(guy IsTouching(self)) {
      return true;
    }
    wait(0.1);
  }
  ai = GetAiArray("axis");
  for(i = 0; i < ai.size; i++) {
    guy = ai[i];
    if(guy IsTouching(self)) {
      return true;
    }
  }
  return false;
}

trigger_delete_on_touch(trigger) {
  for(;;) {
    trigger waittill("trigger", other);
    if(isDefined(other)) {
      other Delete();
    }
  }
}

flag_set_touching(trigger) {
  flag = trigger get_trigger_flag();
  if(!isDefined(level.flag[flag])) {
    flag_init(flag);
  }
  for(;;) {
    trigger waittill("trigger", other);
    flag_set(flag);
    while(IsAlive(other) && other IsTouching(trigger) && isDefined(trigger)) {
      wait(0.25);
    }
    flag_clear(flag);
  }
}

add_nodes_mins_maxs(nodes) {
  for(index = 0; index < nodes.size; index++) {
    origin = nodes[index].origin;
    level.nodesMins = expandMins(level.nodesMins, origin);
    level.nodesMaxs = expandMaxs(level.nodesMaxs, origin);
  }
}

calculate_map_center() {
  if(!isDefined(level.mapCenter)) {
    level.nodesMins = (0, 0, 0);
    level.nodesMaxs = (0, 0, 0);
    nodes = GetAllNodes();
    if(isDefined(nodes[0])) {
      level.nodesMins = nodes[0].origin;
      level.nodesMaxs = nodes[0].origin;
    }
    add_nodes_mins_maxs(nodes);
    level.mapCenter = findBoxCenter(level.nodesMins, level.nodesMaxs);
    SetMapCenter(level.mapCenter);
  }
}

SetObjectiveTextColors() {
  MY_TEXTBRIGHTNESS_DEFAULT = "1.0 1.0 1.0";
  MY_TEXTBRIGHTNESS_90 = "0.9 0.9 0.9";
  MY_TEXTBRIGHTNESS_85 = "0.85 0.85 0.85";
  if(level.script == "armada") {
    SetSavedDvar("con_typewriterColorBase", MY_TEXTBRIGHTNESS_90);
    return;
  }
  SetSavedDvar("con_typewriterColorBase", MY_TEXTBRIGHTNESS_DEFAULT);
}

get_script_linkto_targets() {
  targets = [];
  if(!isDefined(self.script_linkto)) {
    return targets;
  }
  tokens = Strtok(self.script_linkto, " ");
  for(i = 0; i < tokens.size; i++) {
    token = tokens[i];
    target = getEnt(token, "script_linkname");
    if(isDefined(target)) {
      targets[targets.size] = target;
    }
  }
  return targets;
}

delete_link_chain(trigger) {
  trigger waittill("trigger");
  targets = trigger get_script_linkto_targets();
  array_thread(targets, ::delete_links_then_self);
}

delete_links_then_self() {
  targets = get_script_linkto_targets();
  array_thread(targets, ::delete_links_then_self);
  self Delete();
}

defer_vision_set_naked(vision, time) {
  if(NumRemoteClients()) {
    wait_network_frame();
  }
  self visionSetNaked(vision, time);
}

trigger_fog(trigger) {
  trigger endon("death");
  dofog = true;
  if(!isDefined(trigger.script_start_dist)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_halfway_dist)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_halfway_height)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_base_height)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_color)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_color_scale)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_transition_time)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_sun_color)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_sun_direction)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_sun_start_ang)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_sun_stop_ang)) {
    dofog = false;
  }
  if(!isDefined(trigger.script_max_fog_opacity)) {
    dofog = false;
  }
  do_sunsamplesize = false;
  sunsamplesize_time = undefined;
  if(isDefined(trigger.script_sunsample)) {
    do_sunsamplesize = false;
    trigger.lerping_dvar["sm_sunSampleSizeNear"] = false;
    sunsamplesize_time = 1;
    if(isDefined(trigger.script_transition_time)) {
      sunsamplesize_time = trigger.script_sunsample_time;
    }
    if(isDefined(trigger.script_sunsample_time)) {
      sunsamplesize_time = trigger.script_sunsample_time;
    }
  }
  for(;;) {
    trigger waittill("trigger", other);
    assertex(IsPlayer(other), "Non-player entity touched a trigger_fog.");
    wait(0.05);
    players = get_players();
    for(i = 0; i < players.size; i++) {
      player = players[i];
      if(player istouching(trigger)) {
        if(!IsSplitscreen()) {
          if(dofog && (!isDefined(player.fog_trigger_current) || player.fog_trigger_current != trigger)) {
            player SetVolFog(trigger.script_start_dist,
              trigger.script_halfway_dist,
              trigger.script_halfway_height,
              trigger.script_base_height,
              trigger.script_color[0],
              trigger.script_color[1],
              trigger.script_color[2],
              trigger.script_color_scale,
              trigger.script_sun_color[0],
              trigger.script_sun_color[1],
              trigger.script_sun_color[2],
              trigger.script_sun_direction[0],
              trigger.script_sun_direction[1],
              trigger.script_sun_direction[2],
              trigger.script_sun_start_ang,
              trigger.script_sun_stop_ang,
              trigger.script_transition_time,
              trigger.script_max_fog_opacity);
          }
        }
        if((isDefined(trigger.script_vision) && isDefined(trigger.script_vision_time)) && (!isDefined(player.fog_trigger_current) || player.fog_trigger_current != trigger)) {
          player thread defer_vision_set_naked(trigger.script_vision, trigger.script_vision_time);
        }
        player.fog_trigger_current = trigger;
      }
    }
    players = get_players();
    if(players.size > 1) {
      if(do_sunsamplesize) {
        dvar = "sm_sunSampleSizeNear";
        if(!trigger.lerping_dvar[dvar] && getDvar(dvar) != trigger.script_sunsample) {
          level thread lerp_trigger_dvar_value(trigger, dvar, trigger.script_sunsample, sunsamplesize_time);
        }
      }
    }
  }
}

lerp_trigger_dvar_value(trigger, dvar, value, time) {
  trigger.lerping_dvar[dvar] = true;
  steps = time * 20;
  curr_value = GetDvarFloat(dvar);
  diff = (curr_value - value) / steps;
  for(i = 0; i < steps; i++) {
    curr_value = curr_value - diff;
    SetSavedDvar(dvar, curr_value);
    wait(0.05);
  }
  SetSavedDvar(dvar, value);
  trigger.lerping_dvar[dvar] = false;
}

set_fog_progress(progress) {
  anti_progress = 1 - progress;
  startdist = self.script_start_dist * anti_progress + self.script_start_dist * progress;
  halfwayDist = self.script_halfway_dist * anti_progress + self.script_halfway_dist * progress;
  color = self.script_color * anti_progress + self.script_color * progress;
  SetVolFog(startdist, halfwaydist, self.script_halfway_height, self.script_base_height, color[0], color[1], color[2], 0.4);
}

remove_level_first_frame() {
  wait(0.05);
  level.first_frame = undefined;
}

no_crouch_or_prone_think(trigger) {
  for(;;) {
    trigger waittill("trigger", other);
    if(!IsPlayer(other)) {
      continue;
    }
    while(other IsTouching(trigger)) {
      other AllowProne(false);
      other AllowCrouch(false);
      wait(0.05);
    }
    other AllowProne(true);
    other AllowCrouch(true);
  }
}

no_prone_think(trigger) {
  for(;;) {
    trigger waittill("trigger", other);
    if(!IsPlayer(other)) {
      continue;
    }
    while(other IsTouching(trigger)) {
      other AllowProne(false);
      wait(0.05);
    }
    other AllowProne(true);
  }
}

check_flag_for_stat_tracking(msg) {
  if(!issuffix(msg, "aa_")) {
    return;
  }
  [[level.sp_stat_tracking_func]](msg);
}

precache_script_models() {
  if(!isDefined(level.scr_model)) {
    return;
  }
  models = GetArrayKeys(level.scr_model);
  for(i = 0; i < models.size; i++) {
    PrecacheModel(level.scr_model[models[i]]);
  }
}

arcademode_save() {}
player_death_detection() {
  SetDvar("player_died_recently", "0");
  thread player_died_recently_degrades();
  level add_wait(::flag_wait, "missionfailed");
  self add_wait(::waittill_msg, "death");
  do_wait_any();
  recently_skill = [];
  recently_skill[0] = 70;
  recently_skill[1] = 30;
  recently_skill[2] = 0;
  recently_skill[3] = 0;
  SetDvar("player_died_recently", recently_skill[level.gameskill]);
}

player_died_recently_degrades() {
  for(;;) {
    recent_death_time = GetDvarInt(#"player_died_recently");
    if(recent_death_time > 0) {
      recent_death_time -= 5;
      SetDvar("player_died_recently", recent_death_time);
    }
    wait(5);
  }
}

all_players_connected() {
  while(1) {
    num_con = getnumconnectedplayers();
    num_exp = getnumexpectedplayers();
    println("all_players_connected(): getnumconnectedplayers=", num_con, "getnumexpectedplayers=", num_exp);
    if(num_con == num_exp && (num_exp != 0)) {
      flag_set("all_players_connected");
      SetDvar("all_players_are_connected", "1");
      return;
    }
    wait(0.05);
  }
}

all_players_spawned() {
  flag_wait("all_players_connected");
  waittillframeend;
  while(1) {
    players = get_players();
    count = 0;
    for(i = 0; i < players.size; i++) {
      if(players[i].sessionstate == "playing") {
        count++;
      }
    }
    if(count == players.size) {
      break;
    }
    wait(0.05);
  }
  flag_set("all_players_spawned");
}

adjust_placed_weapons() {
  weapons = getEntArray("placed_weapon", "targetname");
  flag_wait("all_players_connected");
  players = get_players();
  player_count = players.size;
  for(i = 0; i < weapons.size; i++) {
    if(isDefined(weapons[i].script_player_min) && player_count < weapons[i].script_player_min) {
      weapons[i] Delete();
    }
  }
}

explodable_volume() {
  self thread explodable_volume_think();
  exploder = getEnt(self.target, "targetname");
  if(isDefined(exploder) && isDefined(exploder.script_exploder)) {
    level waittill("exploder" + exploder.script_exploder);
  } else {
    exploder waittill("exploding");
  }
  self Delete();
}

explodable_volume_think() {
  assertex(isDefined(self.target), "Explodable Volume must be targeting an exploder or an explodable object.");
  target = getEnt(self.target, "targetname");
  assertex(isDefined(target), "Explodable Volume has an invalid target.");
  if(isDefined(target.remove)) {
    target = target.remove;
  }
  self._explodable_target = target;
  while(true) {
    self waittill("trigger", ent);
    ent thread explodable_volume_ent_think(self, target);
    wait .5;
  }
}

explodable_volume_ent_think(volume, target) {
  if(!isDefined(self._explodable_volumes)) {
    self._explodable_volumes = [];
  }
  if(is_in_array(self._explodable_volumes, volume)) {
    return;
  }
  if(!isDefined(self._explodable_targets)) {
    self._explodable_targets = [];
  }
  self._explodable_volumes = array_add(self._explodable_volumes, volume);
  self._explodable_targets = array_add(self._explodable_targets, target);
  while(IsAlive(self) && isDefined(volume) && self IsTouching(volume)) {
    wait .5;
  }
  if(isDefined(self)) {
    self._explodable_volumes = array_remove(self._explodable_volumes, volume);
    self._explodable_targets = array_remove(self._explodable_targets, target);
  }
}

update_script_forcespawn_based_on_flags() {
  spawners = GetSpawnerArray();
  for(i = 0; i < spawners.size; i++) {
    if(spawners[i] has_spawnflag(level.SPAWNFLAG_ACTOR_SCRIPTFORCESPAWN)) {
      spawners[i].script_forcespawn = 1;
    }
  }
}

trigger_once(trig) {
  trig waittill("trigger");
  waittillframeend;
  if(isDefined(trig)) {
    trig Delete();
  }
}