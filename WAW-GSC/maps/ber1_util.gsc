/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber1_util.gsc
*****************************************************/

#include maps\pel2_util;
#include maps\_utility;
#include common_scripts\utility;

ber1_kill_group(group) {
  guys = get_ai_group_ai(group);
  for (i = 0; i < guys.size; i++) {
    if(isDefined(guys[i]) && isAlive(guys[i])) {
      guys[i] dodamage(guys[i].health + 50, guys[i].origin);
    }
    wait randomfloatrange(.400, 1.2);
  }
}

throw_object(target, catenary) {
  start_pos = self.origin;
  target_pos = target.origin;
  gravity = GetDvarInt("g_gravity") * -1;
  dist = Distance(start_pos, target_pos);
  time = dist / catenary;
  delta = target_pos - start_pos;
  drop = 0.5 * gravity * (time * time);
  velocity = ((delta[0] / time), (delta[1] / time), (delta[2] - drop) / time);
  self MoveGravity(velocity, time);
  wait(time);
  self notify("destination");
}

reenable_color_from_goalnode() {
  self waittill("goal");
  self enable_ai_color();
}

kill_mgs(value, key) {
  mg = getEnt(value, key);
  if(isDefined(mg)) {
    mg notify("stop_using_built_in_burst_fire");
    mg notify("stopfiring");
    waittillframeend;
    mg delete();
  }
}

fire_shrecks(spawn_point, target, offset, alias, time) {
  shreck = spawn("script_model", spawn_point.origin);
  shreck.angles = target.angles;
  shreck setmodel("weapon_ger_panzershreck_rocket");
  dest = target.origin;
  if(isDefined(offset)) {
    dest = dest + offset;
  }
  shreck moveTo(dest, time);
  shreck playsound("weap_pnzr_fire");
  playFxOnTag(level._effect["shreck_trail"], shreck, "tag_fx");
  shreck playloopsound("weap_pnzr_fire_rocket");
  wait(time);
  shreck stoploopsound();
  shreck hide();
  playfx(level._effect["shreck_explode"], shreck.origin);
  playSoundAtPosition("rpg_impact_boom", shreck.origin);
  radiusdamage(shreck.origin, 180, 300, 35);
  earthquake(0.5, 1.5, shreck.origin, 512);
  if(isDefined(alias)) {
    playSoundAtPosition(alias, shreck.origin);
  }
  shreck delete();
}

setup_spawn_functions() {
  panzershreck_guys = getEntArray("panzershreck", "script_noteworthy");
  array_thread(panzershreck_guys, ::add_spawn_function, ::setup_panzershreck_guys);
  moab_gunners = getEntArray("moab_gunner", "targetname");
  array_thread(moab_gunners, ::add_spawn_function, ::setup_moab_gunners);
  gunners = getEntArray("ts_right_gunner", "targetname");
  array_thread(gunners, ::add_spawn_function, ::setup_trainyard_gunners);
  wavers = getEntArray("wavers", "targetname");
  array_thread(wavers, ::add_spawn_function, ::setup_trainyard_wavers);
  entrance_guards = getEntArray("entrance_guards", "script_noteworthy");
  array_thread(entrance_guards, ::add_spawn_function, ::radius_setup);
}

rooftop_setup() {
  self.goalradius = 16;
  self.health = 35;
}

radius_setup() {
  self.goalradius = 16;
}

setup_panzershreck_guys() {
  self.goalradius = 16;
  self setThreatBiasGroup("panzershreck_threat");
}

setup_moab_gunners() {
  self setthreatbiasgroup("mg42_guys");
}

setup_trainyard_gunners() {
  self.ignoreme = true;
  self.goalradius = 32;
  self.targetname = "ts_right_gunner";
  self setthreatbiasgroup("mg42_guys");
}

setup_trainyard_wavers() {
  self.animname = "wavers";
  self.targetname = "wavers";
  self.ignoreall = true;
  self.ignoreme = true;
  self.goalradius = 32;
  self.allowdeath = true;
  self thread magic_bullet_shield();
}

drawline(pos1, vtag, vmodel, time, color) {
  if(!isDefined(time)) {
    time = 3;
  }
  if(!isDefined(color)) {
    color = (1, 1, 1);
  }
  timer = gettime() + (time * 1000);
  while (getTime() < timer) {
    pos2 = vmodel getTagOrigin(vtag);
    line(pos1.origin, pos2, color);
    wait(0.05);
  }
}

warp_players_underworld() {
  underworld = GetStruct("underworld_start", "targetname");
  if(!isDefined(underworld)) {
    ASSERTMSG("warp_players_underworld(): can't find the underworld warp spot! aborting.");
    return;
  }
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] SetOrigin(underworld.origin);
  }
}

warp_players(startValue, startKey) {
  starts = GetStructArray(startValue, startKey);
  ASSERT(starts.size == 4);
  players = get_players();
  for (i = 0; i < players.size; i++) {
    players[i] setOrigin(starts[i].origin);
    players[i] setPlayerAngles(starts[i].angles);
  }
}

warp_friendlies(startValue, startKey) {
  friendly_squad = get_ai_group_ai("start_guys");
  friendly_squad = array_combine(friendly_squad, level.heroes);
  friendlyStarts = GetStructArray(startValue, startKey);
  ASSERTEX(friendlyStarts.size >= friendly_squad.size, "warp_friendlies(): not enough friendly start points for friendlies!");
  for (i = 0; i < friendly_squad.size; i++) {
    friendly_squad[i] Teleport(groundpos(friendlyStarts[i].origin), friendlyStarts[i].angles);
  }
}

thin_out_friendlies(guys) {
  for (i = 0; i < guys.size; i++) {
    if(isDefined(guys[i].script_no_respawn) && guys[i].script_no_respawn) {
      guys[i] dodamage(guys[i].health + 1, (0, 0, 0));
    }
  }
}