/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\mp_golfcourse.gsc
**************************************/

#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\_events;

main() {
  maps\mp\mp_golfcourse_fx::main();
  precachemodel("collision_geo_64x64x256");
  precachemodel("collision_wall_256x256x10");
  maps\mp\_load::main();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    maps\mp\_compass::setupMiniMap("compass_map_mp_golfcourse_wager");
  } else {
    maps\mp\_compass::setupMiniMap("compass_map_mp_golfcourse");
  }
  maps\mp\mp_golfcourse_amb::main();
  maps\mp\gametypes\_teamset_cubans::level_init();
  setdvar("compassmaxrange", "2100");
  game["strings"]["war_callsign_a"] = & "MPUI_CALLSIGN_MAPNAME_A";
  game["strings"]["war_callsign_b"] = & "MPUI_CALLSIGN_MAPNAME_B";
  game["strings"]["war_callsign_c"] = & "MPUI_CALLSIGN_MAPNAME_C";
  game["strings"]["war_callsign_d"] = & "MPUI_CALLSIGN_MAPNAME_D";
  game["strings"]["war_callsign_e"] = & "MPUI_CALLSIGN_MAPNAME_E";
  game["strings_menu"]["war_callsign_a"] = "@MPUI_CALLSIGN_MAPNAME_A";
  game["strings_menu"]["war_callsign_b"] = "@MPUI_CALLSIGN_MAPNAME_B";
  game["strings_menu"]["war_callsign_c"] = "@MPUI_CALLSIGN_MAPNAME_C";
  game["strings_menu"]["war_callsign_d"] = "@MPUI_CALLSIGN_MAPNAME_D";
  game["strings_menu"]["war_callsign_e"] = "@MPUI_CALLSIGN_MAPNAME_E";
  maps\mp\gametypes\_spawning::level_use_unified_spawning(true);
  level thread sprinklers_init();
  level thread gopher_init();
  if(GetDvarInt(#"xblive_wagermatch") == 1) {
    spawncollision("collision_geo_64x64x256", "collider", (-1075, -797, -105), (0, 340.8, 0));
    spawncollision("collision_geo_64x64x256", "collider", (-551, -965, -105), (0, 340.8, 0));
  }
  spawncollision("collision_wall_256x256x10", "collider", (416, 592, -172), (0, 45, -7));
  scoreboard1 = spawn("script_model", (-2046, 839, -215));
  if(isDefined(scoreboard1)) {
    scoreboard1.angles = (0, 180, 0);
    scoreboard1 setModel("p_gc_signpost_short");
  }
}
sprinklers_init() {
  wait(3);
  exploders = [];
  exploders[exploders.size] = 1001;
  exploders[exploders.size] = 1002;
  exploders[exploders.size] = 1003;
  exploders[exploders.size] = 1004;
  exploders[exploders.size] = 1005;
  exploders[exploders.size] = 1006;
  exploders[exploders.size] = 1007;
  exploders[exploders.size] = 3001;
  exploders[exploders.size] = 3002;
  exploders[exploders.size] = 3003;
  exploders[exploders.size] = 3004;
  exploders[exploders.size] = 3005;
  exploders[exploders.size] = 3006;
  exploders[exploders.size] = 3007;
  exploders[exploders.size] = 3008;
  exploders[exploders.size] = 3009;
  exploders[exploders.size] = 3010;
  exploders[exploders.size] = 3011;
  exploders[exploders.size] = 3012;
  for(i = 0; i < exploders.size; i++) {
    sprinkler_init(exploders[i]);
  }
}
sprinkler_init(exploder_num) {
  create_fx_ent = exploder_find(exploder_num);
  assertex(isDefined(create_fx_ent), "unknown sprinkler exploder: " + exploder_num);
  create_fx_ent.fake_health = 40;
  radius = 10;
  height = 10;
  create_fx_ent.damage_trigger = spawn("trigger_damage", create_fx_ent.v["origin"] - (0, 0, 5), 0, radius, height);
  create_fx_ent.destroyed_exploder = exploder_num + 1000;
  if(exploder_num == 1001 || exploder_num == 1002 || exploder_num == 1003) {
    radius = 125;
    height = 150;
    start = create_fx_ent.v["origin"] + vector_scale(create_fx_ent.v["forward"], 384);
    end = start + (0, 0, -8000);
    trace = bulletTrace(start, end, false, undefined, false, false);
    origin = trace["position"];
    create_fx_ent thread sprinkler_water_think(origin, radius, height);
    create_fx_ent.soundent = spawn("script_origin", create_fx_ent.v["origin"]);
    create_fx_ent.soundent playLoopSound("amb_sprinkler");
  }
  create_fx_ent thread sprinkler_think(exploder_num);
  exploder(exploder_num);
}
sprinkler_think(exploder_num) {
  for(;;) {
    self.damage_trigger waittill("damage", amount, attacker, direction, point, type);
    if(isDefined(type)) {
      if(type == "MOD_MELEE" || type == "MOD_EXPLOSIVE" || type == "MOD_IMPACT") {
        break;
      }
    }
    self.fake_health -= amount;
    if(self.fake_health <= 0) {
      break;
    }
  }
  if(isDefined(self.soundent)) {
    self.soundent stoploopsound();
    clientnotify("so_" + exploder_num);
  }
  playsoundatposition("amb_sprinkler_geyser", self.v["origin"]);
  self.damage_trigger delete();
  exploder(self.destroyed_exploder);
  self exploder_fade();
  if(isDefined(self.water_trigger)) {
    self.water_trigger delete();
  }
  wait(0.25);
  self thread sprinkler_water_think(self.v["origin"], 50, 100);
  wait(1);
  exploder_stop(self.v["exploder"]);
  wait(5);
  self.water_trigger delete();
}
sprinkler_water_think(origin, radius, height) {
  self.water_trigger = spawn("trigger_radius", origin, 0, radius, height);
  for(;;) {
    self.water_trigger waittill("trigger", entity);
    if(!isDefined(entity) || !IsPlayer(entity) || !IsAlive(entity)) {
      continue;
    }
    player = entity;
    if(player.sessionstate != "playing") {
      continue;
    }
    if(!isDefined(player.golfcourse_water_drops)) {
      player.golfcourse_water_drops = false;
    }
    if(player.golfcourse_water_drops) {
      continue;
    }
    player thread sprinkler_water_drops(self.water_trigger);
  }
}
sprinkler_water_drops(trigger) {
  self endon("death");
  self endon("disconnect");
  trigger endon("death");
  self thread water_drop_end_think();
  trigger thread water_drop_death_think(self);
  for(;;) {
    if(!self IsTouching(trigger)) {
      self notify("water_drop_end");
      return;
    }
    if(!self.golfcourse_water_drops) {
      self.golfcourse_water_drops = true;
      self SetWaterDrops(50);
    }
    wait(RandomIntRange(1, 3));
  }
}
water_drop_end_think() {
  self endon("disconnect");
  self waittill_any("death", "water_drop_end");
  self.golfcourse_water_drops = false;
  self SetWaterDrops(0);
}
water_drop_death_think(player) {
  player endon("death");
  player endon("disconnect");
  player endon("water_drop_end");
  self waittill("death");
  player notify("water_drop_end");
}
exploder_find(num) {
  num = int(num);
  for(i = 0; i < level.createFXent.size; i++) {
    ent = level.createFXent[i];
    if(!isDefined(ent))
      continue;
    if(ent.v["type"] != "exploder")
      continue;
    if(!isDefined(ent.v["exploder"]))
      continue;
    if(ent.v["exploder"] != num)
      continue;
    return ent;
  }
  return undefined;
}
exploder_fade() {
  assert(isDefined(self.looper));
  TriggerFx(self.looper, GetTime() + 100);
}
gopher_init() {
  level waittill("prematch_over");
  if(!isDefined(game["gopher_fx"])) {
    game["gopher_fx"] = false;
  }
  if(isRoundBased() && getRoundsPlayed() >= 3 && getRoundsPlayed() % 3 == 0) {
    game["gopher_fx"] = false;
  }
  if(game["gopher_fx"]) {
    return;
  }
  if(cointoss()) {
    return;
  }
  exploders = [];
  exploders[exploders.size] = 5001;
  exploders[exploders.size] = 5002;
  exploders[exploders.size] = 5003;
  exploders[exploders.size] = 5004;
  percent = RandomIntRange(20, 90);
  minutes = (percent * 0.01) * level.timelimit;
  add_timed_event(minutes * 60, "gopher_fx");
  percent = RandomIntRange(20, 90);
  score = (percent * 0.01) * level.scorelimit;
  add_score_event(score, "gopher_fx");
  level waittill("gopher_fx");
  game["gopher_fx"] = true;
  exploder(random(exploders));
}

