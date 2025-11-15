/**************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\mp\agents\alien\_alien_agents.gsc
**************************************************/

#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\gametypes\_damage;
#include maps\mp\gametypes\_gamelogic;
#include maps\mp\agents\_agent_utility;
#include maps\mp\alien\_utility;

main() {
  if(isDefined(level.createFX_enabled) && level.createFX_enabled) {
    return;
  }
  setup_callbacks();

  level.badplace_cylinder_func = ::badplace_cylinder;
  level.badplace_delete_func = ::badplace_delete;

  level thread maps\mp\agents\_agent_common::init();

  level.spitter_last_cloud_time = 0;
}

setup_callbacks() {
  if(!isDefined(level.agent_funcs))
    level.agent_funcs = [];

  level.agent_funcs["alien"] = [];

  level.agent_funcs["alien"]["spawn"] = ::alienAgentSpawn;

  level.agent_funcs["alien"]["think"] = ::alienAgentThink;
  level.agent_funcs["alien"]["on_killed"] = maps\mp\alien\_death::onAlienAgentKilled;
  level.agent_funcs["alien"]["on_damaged"] = maps\mp\alien\_damage::onAlienAgentDamaged;
  level.agent_funcs["alien"]["on_damaged_finished"] = maps\mp\agents\alien\_alien_think::onDamageFinish;

  level.alien_funcs["goon"]["approach"] = maps\mp\agents\alien\_alien_think::default_approach;
  level.alien_funcs["minion"]["approach"] = maps\mp\agents\alien\_alien_minion::minion_approach;
  level.alien_funcs["spitter"]["approach"] = maps\mp\agents\alien\_alien_think::default_approach;
  level.alien_funcs["elite"]["approach"] = maps\mp\agents\alien\_alien_elite::elite_approach;
  level.alien_funcs["brute"]["approach"] = maps\mp\agents\alien\_alien_think::default_approach;
  level.alien_funcs["locust"]["approach"] = maps\mp\agents\alien\_alien_think::default_approach;
  level.alien_funcs["leper"]["approach"] = maps\mp\agents\alien\_alien_think::default_approach;

  level.alien_funcs["goon"]["combat"] = maps\mp\agents\alien\_alien_think::default_alien_combat;
  level.alien_funcs["minion"]["combat"] = maps\mp\agents\alien\_alien_think::default_alien_combat;
  level.alien_funcs["spitter"]["combat"] = maps\mp\agents\alien\_alien_spitter::spitter_combat;
  level.alien_funcs["elite"]["combat"] = maps\mp\agents\alien\_alien_think::default_alien_combat;
  level.alien_funcs["brute"]["combat"] = maps\mp\agents\alien\_alien_think::default_alien_combat;
  level.alien_funcs["locust"]["combat"] = maps\mp\agents\alien\_alien_think::default_alien_combat;
  level.alien_funcs["leper"]["combat"] = maps\mp\agents\alien\_alien_leper::leper_combat;

  level.alien_funcs["goon"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;
  level.alien_funcs["minion"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;
  level.alien_funcs["spitter"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;
  level.alien_funcs["elite"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;
  level.alien_funcs["brute"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;
  level.alien_funcs["locust"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;
  level.alien_funcs["leper"]["badpath"] = maps\mp\agents\alien\_alien_think::handle_badpath;

  level.used_nodes = [];
  level.used_nodes_list_size = 20;
  level.used_nodes_list_index = 0;

  level.alien_jump_melee_speed = 1.05;
  level.alien_jump_melee_gravity = 900;
}

alienAgentThink() {}

alienAgentspawn(spawnOrigin, spawnAngles, alienType, introVignetteAnim) {
  if(!isDefined(alienType))
    alienType = "wave goon";

  alien_type = remove_spawn_type(alienType);

  if(!isDefined(spawnOrigin) || !isDefined(spawnAngles)) {
    spawnPoint = self[[level.getSpawnPoint]]();
    spawnOrigin = spawnpoint.origin;
    spawnAngles = spawnpoint.angles;
  }

  self set_alien_model(alien_type);

  if(flag_exist("hives_cleared") && flag("hives_cleared") && self.agentteam == "axis") {
    if(!flag_exist("nuke_went_off") || !flag("nuke_went_off")) {
      self.noTriggerHurt = true;
      port_failed = false;

      tokens = strtok(alienType, " ");
      type = tokens[0];
      if(tokens.size > 1)
        type = tokens[1];

      prof_begin("port_to_player_loc");
      if(alien_type == "spitter" && isDefined(level.escape_spitter_target_node)) {
        spawnOrigin = self maps\mp\alien\_spawnlogic::port_to_escape_spitter_location();
      } else {
        port_to_data = self maps\mp\alien\_spawnlogic::port_to_player_loc(type);
        if(!isDefined(port_to_data)) {
          port_failed = true;

          if(GetDvarInt("alien_debug_escape") > 0)
            IPrintLnBold("^1Failed to port alien");

        } else {
          spawnOrigin = port_to_data[0];
          spawnAngles = port_to_data[1];
        }
      }
      prof_end("port_to_player_loc");

      if(!port_failed) {
        spawnOrigin = GetGroundPosition(spawnOrigin, 16);
        spawnOrigin -= (0, 0, 90);

        introVignetteAnim = level.cycle_data.spawn_node_info["queen_test"].vignetteInfo[type];
      }
    }
  }

  self spawn_alien_agent(spawnOrigin, spawnAngles, alien_type);
  level notify("spawned_agent", self);

  self set_alien_attributes(alienType);

  self set_code_fields(alien_type);

  self set_script_fields(spawnOrigin);

  self set_threat_bias_group(alien_type);

  self type_specific_init();

  self setup_watcher();

  self misc_setup();

  if(isDefined(introVignetteAnim))
    self doIntroVignetteAnim(introVignetteAnim);

  if(isDefined(self.noTriggerHurt))
    self.noTriggerHurt = undefined;

  self maps\mp\alien\_ffotd::onSpawnAlien();

  self thread maps\mp\agents\alien\_alien_think::main();
}

set_code_fields(alien_type) {
  self.allowJump = true;
  self.allowladders = 1;
  self.moveMode = self get_default_movemode();
  self.radius = 15;
  self.height = 72;
  self.turnrate = 0.3;
  self.sharpTurnNotifyDist = 48;
  self.traverseSoonNotifyDist = level.alienAnimData.jumpLaunchArrival_maxMoveDelta;
  self.stopSoonNotifyDist = level.alienAnimData.stopSoon_NotifyDist;
  self.jumpCost = level.alien_types[alien_type].attributes["jump_cost"];

  if(flag_exist("hives_cleared") && flag("hives_cleared"))
    self.jumpCost = max(0.85, self.jumpCost * 0.66);

  self.traverseCost = level.alien_types[alien_type].attributes["traverse_cost"];
  self.runCost = level.alien_types[alien_type].attributes["run_cost"];
  if(isDefined(level.alien_types[alien_type].attributes["wall_run_cost"]))
    self ScrAgentSetWallRunCost(level.alien_types[alien_type].attributes["wall_run_cost"]);
}

get_default_movemode() {
  alien_type = self get_alien_type();
  switch (alien_type) {
    case "minion":
      return "walk";
    default:
      return "run";
  }
}

set_threat_bias_group(alien_type) {
  if(!can_attack_drill(alien_type)) {
    self SetThreatBiasGroup("dontattackdrill");
    return;
  }

  self SetThreatBiasGroup("other_aliens");
}

can_attack_drill(alien_type) {
  if(isDefined(level.dlc_alien_can_attack_drill_override_func)) {
    canAttackDrill = [[level.dlc_alien_can_attack_drill_override_func]](alien_type);
    if(isDefined(canAttackDrill))
      return canAttackDrill;
  }

  switch (alien_type) {
    case "elite":
    case "minion":
    case "locust":
    case "gargoyle":
    case "mammoth":
      return false;
    default:
      return true;
  }
}

set_script_fields(spawnOrigin) {
  self.species = "alien";
  self.enableStop = true;
  self activateAgent();
  self.spawnTime = GetTime();
  self.attacking_player = false;
  self.spawnOrigin = spawnOrigin;
  self.recentDamages = [];
  self.damageListIndex = 0;
  self.swipeChance = 0.5;
  self.leapEndPos = undefined;
  self.trajectoryActive = false;
  self.melee_in_move_back = false;
  self.melee_in_posture = false;
}

remove_spawn_type(alienType) {
  spawnTypeConfig = strtok(alienType, " ");
  if(isDefined(spawnTypeConfig) && spawnTypeConfig.size == 2)
    return spawnTypeConfig[1];
  else
    return alienType;
}

set_alien_model(alien_type) {
  if(isDefined(level.get_alien_model_func)) {
    alien_model = [[level.get_alien_model_func]](alien_type);
  } else {
    alien_model = level.alien_types[alien_type].attributes["model"];
  }

  self setModel(alien_model);
  self show();
  self MotionBlurHQEnable();
}

spawn_alien_agent(spawnOrigin, spawnAngles, alien_type) {
  self.OnEnterAnimState = maps\mp\agents\alien\_alien_think::onEnterAnimState;
  anim_class = get_anim_class(alien_type);
  self SpawnAgent(spawnOrigin, spawnAngles, anim_class, 15, 50);
}

get_anim_class(alien_type) {
  return level.alien_types[alien_type].attributes["animclass"];
}

set_alien_attributes(alienType) {
  self maps\mp\alien\_spawnlogic::assign_alien_attributes(alienType);
}

type_specific_init() {
  switch (maps\mp\alien\_utility::get_alien_type()) {
    case "elite":
      maps\mp\agents\alien\_alien_elite::elite_init();
      break;
    case "minion":
      maps\mp\agents\alien\_alien_minion::minion_init();
      break;
    case "spitter":
      maps\mp\agents\alien\_alien_spitter::spitter_init();
      break;
    case "leper":
      maps\mp\agents\alien\_alien_leper::leper_init();
      break;
    default:

      if(isDefined(level.dlc_alien_init_override_func)) {
        [
          [level.dlc_alien_init_override_func]
        ]();
      }
      break;
  }
}

misc_setup() {
  self ScrAgentSetClipMode("agent");
  self TakeAllWeapons();
}

setup_watcher() {
  self thread maps\mp\agents\alien\_alien_think::watch_for_scripted();
  self thread maps\mp\agents\alien\_alien_think::watch_for_badpath();
  self thread maps\mp\agents\alien\_alien_think::watch_for_insolid();
  self thread maps\mp\_flashgrenades::MonitorFlash();
  self thread maps\mp\agents\alien\_alien_think::MonitorFlash();

  /#	
  if(GetDvarInt("scr_aliendebugvelocity") == 1)
    self thread maps\mp\alien\_debug::alienDebugVelocity();
}

doIntroVignetteAnim(vignetteAnimInfo) {
  CONST_ANIM_STATE_INDEX = 0;
  CONST_ANIM_INDEX_ARRAY_INDEX = 1;
  CONST_LABEL_INDEX = 2;
  CONST_END_NOTETRACK_INDEX = 3;
  CONST_FX_INDEX = 4;
  CONST_SCRIPTABLE_TARGETNAME_INDEX = 5;
  CONST_SCRIPTABLE_STATE_INDEX = 6;
  CONST_SPAWN_NODE_ID_INDEX = 7;

  self ScrAgentSetScripted(true);
  self ScrAgentSetPhysicsMode("noclip");
  self ScrAgentSetAnimMode("anim deltas");

  vignetteAnimInfo = StrTok(vignetteAnimInfo, ";");

  self.vignetteAnimInfo = [];
  self.vignetteAnimInfo["FX"] = replaceNoneWithEmptyString(vignetteAnimInfo[CONST_FX_INDEX]);
  self.vignetteAnimInfo["scriptableName"] = StrTok(replaceNoneWithEmptyString(vignetteAnimInfo[CONST_SCRIPTABLE_TARGETNAME_INDEX]), ",");
  self.vignetteAnimInfo["scriptableState"] = StrTok(replaceNoneWithEmptyString(vignetteAnimInfo[CONST_SCRIPTABLE_STATE_INDEX]), ",");
  self.vignetteAnimInfo["spawnNodeID"] = replaceNoneWithEmptyString(vignetteAnimInfo[CONST_SPAWN_NODE_ID_INDEX]);

  animState = replaceNoneWithEmptyString(vignetteAnimInfo[CONST_ANIM_STATE_INDEX]);
  indexArray = StrTok(replaceNoneWithEmptyString(vignetteAnimInfo[CONST_ANIM_INDEX_ARRAY_INDEX]), ",");
  animIndex = int(indexArray[randomInt(indexArray.size)]);
  animLabel = replaceNoneWithEmptyString(vignetteAnimInfo[CONST_LABEL_INDEX]);
  endNotetrack = replaceNoneWithEmptyString(vignetteAnimInfo[CONST_END_NOTETRACK_INDEX]);

  animEntry = self GetAnimEntry(animState, animIndex);

  if(shouldDoGroundLerp(animEntry))
    doLerpToEndOnGround(animState, animIndex);

  if(willPlayScriptables(animEntry))
    resetAllScriptables(self.vignetteAnimInfo["scriptableName"], self.origin);

  result = maps\mp\agents\alien\_alien_traverse::needFlexibleHeightSupport(animEntry);

  if(result.need_support)
    doSpawnVignetteWithFlexibleHeight(animState, animIndex, animLabel, animEntry, result.start_notetrack, result.end_notetrack, ::vignetteNotetrackHandler);
  else
    maps\mp\agents\_scriptedAgents::PlayAnimNUntilNotetrack(animState, animIndex, animLabel, endNotetrack, ::vignetteNotetrackHandler);

  self ScrAgentSetScripted(false);
}

shouldDoGroundLerp(animEntry) {
  return !(AnimHasNotetrack(animEntry, "skip_ground_lerp"));
}

willPlayScriptables(animEntry) {
  return (AnimHasNotetrack(animEntry, "play_scriptable") && can_play_scriptable(self.vignetteAnimInfo["spawnNodeID"], self.vignetteAnimInfo["scriptableName"]));
}

doSpawnVignetteWithFlexibleHeight(animState, animIndex, animLabel, animEntry, startNotetrack, endNotetrack, notetrackHandlerFunc) {
  maps\mp\agents\_scriptedAgents::PlayAnimNUntilNotetrack(animState, animIndex, animLabel, startNotetrack, notetrackHandlerFunc);

  ground_pos = getEndLocOnGround(animEntry);
  maps\mp\agents\alien\_alien_traverse::doTraversalWithFlexibleHeight_internal(animState, animIndex, animLabel, animEntry, startNotetrack, endNotetrack, ground_pos, 1, ::vignetteNotetrackHandler);
}

getEndLocOnGround(animEntry) {
  DROP_TO_GROUND_UP_DIST = 32;
  DROP_TO_GROUND_DOWN_DIST = -300;

  AnimEndLoc = maps\mp\agents\alien\_alien_anim_utils::getPosInSpaceAtAnimTime(animEntry, self.origin, self.angles, GetAnimLength(animEntry));
  return drop_to_ground(AnimEndLoc, DROP_TO_GROUND_UP_DIST, DROP_TO_GROUND_DOWN_DIST);
}

replaceNoneWithEmptyString(string) {
  if(string == "NONE")
    return "";

  return string;
}

vignetteNotetrackHandler(note, animState, animIndex, animTime) {
  switch (note) {
    case "alien_drone_spawn_underground":
    case "play_fx":
      if(!is_empty_string(self.vignetteAnimInfo["FX"]))
        playSpawnVignetteFX(self.vignetteAnimInfo["FX"]);
      break;

    case "play_scriptable":
      if(can_play_scriptable(self.vignetteAnimInfo["spawnNodeID"], self.vignetteAnimInfo["scriptableName"])) {
        playAnimOnAllScriptables(self.vignetteAnimInfo["scriptableName"], self.origin, self.vignetteAnimInfo["scriptableState"]);

        if(is_one_off_scriptable(self.vignetteAnimInfo["spawnNodeID"]))
          inactivate_scriptable_for_node(self.vignetteAnimInfo["spawnNodeID"]);
      }
      break;

    case "play_earthquake":
      Earthquake(0.5, 1.5, self.origin, 800);
      break;

    case "delete_spawn_clip":
      if(isDefined(self.intro_clips))
        delete_items(self.intro_clips);
      break;

    case "frontal_cone_knock_player_back":
      frontal_cone_knock_player_back();
      break;

    case "apply_physics":
      self ScrAgentSetPhysicsMode("gravity");
      break;

    default:
      break;
  }
}

can_play_scriptable(node_id, scriptable_name_list) {
  return ((is_scriptable_status(node_id, "always_on") || is_scriptable_status(node_id, "one_off")) && scriptable_name_list.size > 0);
}

is_scriptable_status(node_id, state) {
  return (level.cycle_data.spawn_node_info[node_id].scriptableStatus == state);
}

is_one_off_scriptable(node_id) {
  return is_scriptable_status(node_id, "one_off");
}

inactivate_scriptable_for_node(node_id) {
  level.cycle_data.spawn_node_info[node_id].scriptableStatus = "inactive";
}

delete_items(item_array) {
  foreach(item in item_array) {
    if(isDefined(item))
      item delete();
  }
}

frontal_cone_knock_player_back() {
  KNOCK_BACK_ACTIVATION_DIST_SQ = 22500;
  KNOCK_BACK_FORCE_MAGNITUDE = 650;
  FRONT_CONE_LIMIT = 0.2588;

  self_forward = anglesToForward(self.angles);

  foreach(player in level.players) {
    self_to_player = vectorNormalize(player.origin - self.origin);

    if(VectorDot(self_to_player, self_forward) > FRONT_CONE_LIMIT && distanceSquared(player.origin, self.origin) <= KNOCK_BACK_ACTIVATION_DIST_SQ) {
      player SetVelocity(VectorNormalize(player.origin - self.origin) * KNOCK_BACK_FORCE_MAGNITUDE);
      player DoDamage((player.health / 10), self.origin);
    }
  }
}

resetAllScriptables(scriptable_name_list, position) {
  for(i = 0; i < scriptable_name_list.size; i++)
    maps\mp\agents\alien\_alien_anim_utils::resetScriptable(scriptable_name_list[i], position);
}

playAnimOnAllScriptables(scriptable_name_list, position, scriptable_state_list) {
  /# AssertEx( scriptable_name_list.size == scriptable_state_list.size, "The scriptable name lists and state lists have mismatch with their size near position ( " + position + " )." );

  for(i = 0; i < scriptable_name_list.size; i++)
    maps\mp\agents\alien\_alien_anim_utils::playAnimOnScriptable(scriptable_name_list[i], position, int(scriptable_state_list[i]));
}

is_empty_string(string) {
  return (string == "");
}

playSpawnVignetteFX(effect_key) {
  effect_id = level._effect[effect_key];
  AssertEx(isDefined(effect_id), "'" + effect_key + "' is not a valid key for the spawn vignette FX.Load the effect in alien type specific script.");
  ground_position = GetGroundPosition(self.origin + (0, 0, 100), 16);
  playFX(effect_id, ground_position, (0, 0, 1));
}

doLerpToEndOnGround(animState, animIndex) {
  VERTICAL_DELTA_BUFFER = 2;

  anime = self GetAnimEntry(animState, animIndex);

  lerp_time = maps\mp\agents\alien\_alien_anim_utils::getLerpTime(anime);
  lerp_target_pos = maps\mp\agents\alien\_alien_anim_utils::getPosInSpaceAtAnimTime(anime, self.origin, self.angles, lerp_time);

  z_delta = getVerticalDeltaToEndGroud(anime);
  lerp_target_pos += (0, 0, z_delta + VERTICAL_DELTA_BUFFER);

  thread maps\mp\agents\alien\_alien_anim_utils::doLerp(lerp_target_pos, lerp_time);
}

getVerticalDeltaToEndGroud(anime) {
  GET_GROUND_DROP_HEIGHT = 100;
  AI_PHYSICS_TRACE_RADIUS = 32;
  AI_PHYSICS_TRACE_HEIGHT = 72;

  anime_delta = GetMoveDelta(anime, 0, 1);
  anime_delta = RotateVector(anime_delta, self.angles);
  anime_height = anime_delta[2];

  anime_end_pos = self.origin + anime_delta;
  trace_start_pos = anime_end_pos + (0, 0, GET_GROUND_DROP_HEIGHT);
  trace_end_pos = anime_end_pos - (0, 0, GET_GROUND_DROP_HEIGHT);
  ground_pos = self AIPhysicsTrace(trace_start_pos, trace_end_pos, AI_PHYSICS_TRACE_RADIUS, AI_PHYSICS_TRACE_HEIGHT);
  self_to_ground_height = (ground_pos - self.origin)[2];

  return (self_to_ground_height - anime_height);
}