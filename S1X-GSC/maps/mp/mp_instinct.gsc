/***************************************************
 * Decompiled by Alterware and Edited by SyndiShanX
 * Script: maps\mp\mp_instinct.gsc
***************************************************/

#include maps\mp\_utility;
#include maps\mp\gametypes\_hud_util;
#include common_scripts\utility;
#include maps\mp\agents\_agent_utility;
#include maps\mp\gametypes\_damage;
#include maps\mp\agents\_scriptedAgents;
#include maps\mp\_dynamic_events;
#include maps\mp\_audio;

CONST_PYRAMID_RAMP_ANIM_TIME = 16.666;

main() {
  maps\mp\mp_instinct_precache::main();
  maps\createart\mp_instinct_art::main();
  maps\mp\mp_instinct_fx::main();

  maps\mp\_load::main();
  maps\mp\mp_instinct_lighting::main();
  maps\mp\mp_instinct_aud::main();

  level.ospvisionset = "mp_instinct_osp";
  level.ospLightSet = "mp_instinct_osp";

  level.warbirdVisionSet = "mp_instinct_osp";

  maps\mp\_compass::setupMiniMap("compass_map_mp_instinct");

  game["attackers"] = "allies";
  game["defenders"] = "axis";

  level.aerial_pathnode_offset = 350;

  level.orbitalSupportOverrideFunc = ::instinctCustomOSPFunc;

  PreCacheModel("ins_crane_drilling_mechanism");
  PreCacheModel("ins_cave_drill");
  PreCacheModel("ins_generator_engine_01_fan");

  level.river_drills = getEntArray("river_drill", "targetname");
  level.cave_drills = getEntArray("cave_drill", "targetname");
  level.cave_drills_inside = getEntArray("cave_drill_inside", "targetname");
  level thread drilling_animation();
  level thread generator_fans();

  level.goliath_bad_landing_volumes = getEntArray("goliath_bad_landing_volume", "targetname");

  setDvar("r_reactivemotionfrequencyscale", .5);
  setDvar("r_reactivemotionamplitudescale", .5);
}

instinctCustomOSPFunc() {
  level.orbitalsupportoverrides.spawnHeight = 9615;
  level.orbitalsupportoverrides.topArc = -35;
  level.orbitalsupportoverrides.rightArc = 18;
  level.orbitalsupportoverrides.leftArc = 18;
}

set_lighting_values() {
  if(IsUsingHDR()) {
    while(true) {
      level waittill("connected", player);
      player SetClientDvars(
        "r_tonemap", "2", "r_tonemapLockAutoExposureAdjust", "0", "r_tonemapAutoExposureAdjust", "0");
    }
  }
}

river_drilling_animation() {
  level endon("game_ended");

  river_drill_fx = spawn_tag_origin();
  river_drill_exhaust_fx = spawn_tag_origin();
  river_drill_earthquake_fx = spawn_tag_origin();
  river_drill_dust_fx = spawn_tag_origin();

  wait(.05);
  river_drill_fx show();
  river_drill_exhaust_fx show();
  river_drill_earthquake_fx show();
  river_drill_dust_fx show();

  wait(0.4);

  river_drill_fx LinkTo(self, "poundee", (75, 0, 400), (0, 0, 0));
  river_drill_exhaust_fx LinkTo(self, "poundee", (75, 0, 400), (90, 0, 90));
  river_drill_earthquake_fx LinkTo(self, "tag_origin", (0, 0, 100), (0, 0, 0));
  river_drill_dust_fx LinkTo(self, "tag_origin", (0, 0, -100), (270, 180, 90));

  noself_delayCall(1, ::PlayFXOnTag, getfx("diesel_drill_smk_loop"), river_drill_fx, "tag_origin");
  wait(0.1);

  while(true) {
    Earthquake(.15, 1, river_drill_earthquake_fx.origin, 500);

    noself_delayCall(.4, ::PlayFXOnTag, getfx("drill_impact_dust"), river_drill_dust_fx, "tag_origin");
    wait(2);
    noself_delayCall(.4, ::PlayFXOnTag, getfx("diesel_drill_smk_ring"), river_drill_exhaust_fx, "tag_origin");
  }
}

drilling_animation() {
  level endon("end_drill_anims");

  wait(1);
  animate_drills();
}

animate_drills() {
  if(isDefined(level.river_drills)) {
    array_thread(level.river_drills, ::update_river_drill_anim);
  }

  if(isDefined(level.cave_drills)) {
    array_thread(level.cave_drills, ::update_cave_drill_anim);
  }

  if(isDefined(level.cave_drills_inside)) {
    array_thread(level.cave_drills_inside, ::update_cave_drill_anim_inside);
  }
}

update_river_drill_anim() {
  level endon("end_drill_anims");
  time_offset = RandomFloat(2);

  wait(.05);

  wait(time_offset);
  ScriptModelPlayAnimWithNotify(self, "ins_drilling_machine", "ps_ins_piledriver_hit", "ins_piledriver_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event");
  self thread river_drilling_animation();
}

update_cave_drill_anim() {
  time_offset = RandomFloat(2);

  wait(.05);

  wait(time_offset);
  ScriptModelPlayAnimWithNotify(self, "ins_cave_drill_idle", "ins_piledriver_cave_hit", "ins_piledriver_cave_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event");
  if(isDefined(self.script_noteworthy) && self.script_noteworthy == "impact_fx") {
    wait(0.5);
    thread maps\mp\mp_instinct_fx::cave_drill_rock_impact_fx();
  }
}

update_cave_drill_anim_inside() {
  level endon("end_drill_anims");

  time_offset = RandomFloat(2);

  wait(time_offset);
  ScriptModelPlayAnimWithNotify(self, "ins_cave_drill_idle", "ins_piledriver_cave_hit", "ins_piledriver_cave_hit", "end_drill_anims", "stop_sequencing_notetracks", "lagos_dyn_event");
}

generator_fans() {
  fans = getEntArray("generator_fans", "targetname");

  foreach(fan in fans) {
    fan ScriptModelPlayAnim("ins_generator_fan");
  }
}