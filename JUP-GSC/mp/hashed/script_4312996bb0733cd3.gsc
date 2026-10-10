/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_4312996bb0733cd3.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_71a1834c8aff34e9;
#using script_7feaed3f883fe324;
#using scripts\common\callbacks;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\powerups;
#using scripts\common\utility;
#using scripts\cp_mp\interaction;
#using scripts\engine\scriptable;
#using scripts\engine\utility;
#using scripts\mp\gametypes\br_map_quest;
#using scripts\mp\gametypes\br_pickups;
#using scripts\mp\objidpoolmanager;
#namespace quest_race;

function init() {
  quest = {
    #on_infil: &on_infil, #on_prematch_end: &on_prematch_end, #on_start: &on_start, #on_precache: &on_precache, #on_init: &on_init, #name: "race"};
  br_map_quest::register(quest);
}

function on_init() {
  set_dvars();
  function_c96c5ad4623f9cbb();
  setup_callbacks();

  debug_init();
}

function on_precache() {}

function on_start() {}

function on_prematch_end() {}

function on_infil() {
  thread function_2794cef7c1c29111();
}

function set_dvars() {
  br_map_quest::add_setting("checkpoint_timer_duration", 6);
  br_map_quest::add_setting("race_reset_duration", 20);
}

function private setup_callbacks() {
  level scriptable::scriptable_addusedcallbackbypart("jup_sidequest_parkour_partname", &function_2e04081059796fa1);
}

function private function_c96c5ad4623f9cbb() {
  self.races = [];
  function_b29b20490a004ae9();

  foreach(name in self.race_names) {
    new_race = function_653d21334d98fae6(name);
    self.races[name] = new_race;
  }
}

function private function_b29b20490a004ae9() {
  self.race_names = [];
  checkpoint_structs = utility::getStructArray("quest_race_checkpoint", "targetname");
  assertex(isDefined(checkpoint_structs), "<dev string:x1c>" + "<dev string:x44>");

  foreach(checkpoint in checkpoint_structs) {
    race_name = checkpoint.script_label;

    if(!isDefined(self.races[race_name])) {
      self.races[race_name] = [];
      self.race_names = array_add(self.race_names, race_name);
    }

    self.races[race_name] = array_add(self.races[race_name], checkpoint);
  }
}

function private function_653d21334d98fae6(race_name) {
  race = spawnStruct();
  race.quest = self;
  race.checkpoint_structs = function_cf9f182ffa289851(self.races[race_name]);
  race.var_af01c02ad99e75fe = 0;
  race.start_index = 0;
  race.finish_index = race.checkpoint_structs.size - 1;
  race.reward_origin = race.checkpoint_structs[race.finish_index].origin;
  race.checkpoint_duration = br_map_quest::get_setting("checkpoint_timer_duration");
  race.rewards = ["brloot_offhand_battlerage", "brloot_health_adrenaline", "brloot_killstreak_uav", "brloot_super_armorbox", "brloot_self_revive"];
  race.already_completed = 0;
  race.just_completed = 0;
  return race;
}

function private function_cf9f182ffa289851(var_5107e554f7af7ec3) {
  var_dd87ceb27f7b439a = [];

  foreach(checkpoint in var_5107e554f7af7ec3) {
    checkpoint_index = int(checkpoint.script_noteworthy);
    var_dd87ceb27f7b439a[checkpoint_index] = checkpoint;
  }

  return var_dd87ceb27f7b439a;
}

function private function_2794cef7c1c29111() {
  level endon("game_ended");

  foreach(race in self.races) {
    function_4534506ee8107463(race);
  }
}

function private function_4534506ee8107463(race) {
  start_flag = spawnscriptable("jup_sidequest_parkour_race_start", race.checkpoint_structs[race.start_index].origin, race.checkpoint_structs[race.start_index].angles);
  start_flag setscriptablepartstate("jup_sidequest_parkour_partname", "usable");
  start_flag.race = race;
  race.var_8f1477b6812b12a0 = [start_flag];
  race.current_checkpoint = start_flag;
}

function private function_44a6333bd124cb10(race) {
  for(i = 0; i < race.checkpoint_structs.size; i++) {
    checkpoint_struct = race.checkpoint_structs[i];

    if(i != race.start_index) {
      payload = [#"teamselect", race.player getentitynumber()];
      scr_type = "jup_sidequest_parkour_race_checkpoint";

      if(i == race.finish_index) {
        scr_type = "jup_sidequest_parkour_race_finishline";
      }

      spawned_checkpoint = spawnscriptable(scr_type, checkpoint_struct.origin, checkpoint_struct.angles, undefined, payload);
      spawned_checkpoint.trigger = spawn("noent_volume_trigger_radius", spawned_checkpoint.origin, 0, 25, 25);
      spawned_checkpoint.race = race;
      spawned_checkpoint setscriptablepartstate("jup_sidequest_parkour_partname", "hidden");
      race.var_8f1477b6812b12a0 = array_add(race.var_8f1477b6812b12a0, spawned_checkpoint);
    }
  }
}

function private race_start(race, player) {
  race notify("sidequest_race_start");
  race endon("sidequest_race_start");
  race endon("sidequest_race_end");
  level endon("game_ended");
  player endon("disconnect");
  race.player = player;
  function_44a6333bd124cb10(race);
  thread checkpoint_increment(race);
  player playlocalsound("wz_parkour_race_start");

  while(player namespace_53fc9ddbb516e6e1::function_87072b42853a9c58("specialty_zombie_legs")) {
    if(race.checkpoint_duration <= 3 && race.checkpoint_duration != 0) {
      player playlocalsound("wz_parkour_race_time_ticking_0" + race.checkpoint_duration);
    }

    wait 1;
    race.checkpoint_duration--;
  }

  if(!istrue(race.just_completed)) {
    race_reset(race);
  }

  race notify("sidequest_race_end");
}

function private race_reset(race) {
  if(!istrue(race.just_completed)) {
    function_1fad11b66c44c8e2(race);
    race.player playlocalsound("wz_parkour_race_failure");
  }

  race.var_af01c02ad99e75fe = 0;
  race.just_completed = 0;
  function_4534506ee8107463(race);
}

function private function_656e822afce77428() {
  foreach(race in self.races) {
    race_reset(race);
  }
}

function private race_completed(race) {
  level endon("game_ended");
  race.player playlocalsound("wz_parkour_race_success");
  function_cd537c18037efbe(race);
  function_1fad11b66c44c8e2(race);
  race.already_completed = 1;
  race.just_completed = 1;
  thread quest_complete(race.player);
  thread function_eebe6c65450f4c0e(race);
  race notify("sidequest_race_end");
}

function private function_cd537c18037efbe(race, var_5552fd240a86b1ae) {
  level endon("game_ended");
  race.rewards = array_randomize(race.rewards);

  if(!isDefined(var_5552fd240a86b1ae)) {
    var_5552fd240a86b1ae = race.reward_origin;
  }

  reward_size = race.rewards.size;

  if(istrue(race.already_completed)) {
    reward_size = 3;
  }

  radius = 80;
  angle_frac = 360 / reward_size;

  for(i = 0; i < reward_size; i++) {
    angle = angle_frac * i;
    xadd = cos(angle) * radius;
    yadd = sin(angle) * radius;
    x = var_5552fd240a86b1ae[0] + xadd;
    y = var_5552fd240a86b1ae[1] + yadd;
    z = var_5552fd240a86b1ae[2];
    spawn_location = (x, y, z + 20);

    if(utility::string_starts_with(race.rewards[i], "brloot")) {
      dropinfo = br_pickups::getitemdroporiginandangles(br_pickups::function_7b9f3966a7a42003(), spawn_location, (0, 0, 0), undefined, undefined, undefined, undefined, undefined, spawn_location);
      thread br_pickups::spawnpickup(race.rewards[i], dropinfo, 1, 0, undefined, 0);
    } else {
      thread br_powerups::function_9097cec00b0a918a(race.rewards[i], spawn_location, 90);
    }

    wait 0.15;
  }
}

function private function_eebe6c65450f4c0e(race) {
  level endon("game_ended");
  wait br_map_quest::get_setting("race_reset_duration");
  race_reset(race);
}

function private quest_complete(player) {
  params = {
    #completed_by: [player], #is_successful: 1
  };
  br_map_quest::on_completed(params);
}

function private checkpoint_increment(race) {
  race endon("sidequest_race_end");
  level endon("game_ended");
  current_checkpoint = race.current_checkpoint;

  if(race.var_af01c02ad99e75fe == race.finish_index) {
    if(isDefined(race.finish_objid)) {
      objidpoolmanager::returnobjectiveid(race.finish_objid);
      race.finish_objid = undefined;
    }

    current_checkpoint setscriptablepartstate("jup_sidequest_parkour_fx_partname", "on");
    wait 0.25;
    current_checkpoint setscriptablepartstate("jup_sidequest_parkour_partname", "hidden");
    function_19d4d8b59f6fbfcd(race);
    return;
  }

  if(race.var_af01c02ad99e75fe != race.start_index) {
    current_checkpoint setscriptablepartstate("jup_sidequest_parkour_fx_partname", "on");
    wait 0.25;
  } else {
    function_83909272c7fe2e78(race, race.player);
  }

  current_checkpoint setscriptablepartstate("jup_sidequest_parkour_partname", "hidden");
  current_checkpoint notify("checkpoint_removed");
  race.var_af01c02ad99e75fe++;
  next_checkpoint = race.var_8f1477b6812b12a0[race.var_af01c02ad99e75fe];
  next_checkpoint setscriptablepartstate("jup_sidequest_parkour_partname", "visible");
  race.current_checkpoint = next_checkpoint;

  if(race.var_af01c02ad99e75fe == race.finish_index) {
    if(isDefined(race.checkpoint_objid)) {
      objidpoolmanager::returnobjectiveid(race.checkpoint_objid);
      race.checkpoint_objid = undefined;
    }

    function_8c441f0c99924b47(race, race.player);
    objidpoolmanager::update_objective_position(race.finish_objid, next_checkpoint.origin);
  } else {
    objidpoolmanager::update_objective_position(race.checkpoint_objid, next_checkpoint.origin);
  }

  thread function_e10c44c9089e645(next_checkpoint);
  race.player thread namespace_6aa38109e829c5b::powerup_apply_zombie_legs(br_map_quest::get_setting("checkpoint_timer_duration"));
  race.checkpoint_duration = br_map_quest::get_setting("checkpoint_timer_duration");
}

function private function_e10c44c9089e645(checkpoint) {
  race = checkpoint.race;
  player = race.player;
  level endon("game_ended");
  race endon("sidequest_race_end");
  checkpoint endon("checkpoint_removed");

  while(true) {
    checkpoint.trigger waittill("trigger", player);

    if(isPlayer(player) && race.player == player) {
      break;
    }

    waitframe();
  }

  thread function_b10b7aaa69d4882e(checkpoint);
}

function private function_1fad11b66c44c8e2(race) {
  if(isDefined(race.checkpoint_objid)) {
    objidpoolmanager::returnobjectiveid(race.checkpoint_objid);
    race.checkpoint_objid = undefined;
  } else if(isDefined(race.finish_objid)) {
    objidpoolmanager::returnobjectiveid(race.finish_objid);
    race.finish_objid = undefined;
  }

  foreach(checkpoint in race.var_8f1477b6812b12a0) {
    if(isDefined(checkpoint.trigger)) {
      checkpoint.trigger delete();
    }

    checkpoint freescriptable();
  }
}

function private function_83909272c7fe2e78(race, player) {
  objid = objidpoolmanager::requestobjectiveid(99);
  race.checkpoint_objid = objid;
  objidpoolmanager::objective_add_objective(objid, "current", race.current_checkpoint.origin, "hud_icon_ctf_flag", "icon_small");
  objidpoolmanager::objective_set_play_intro(objid, 0);
  objidpoolmanager::update_objective_setzoffset(objid, 75);
  objidpoolmanager::update_objective_setbackground(objid, 1);
  function_9766d0b79eada249(objid, 1);
  objective_disableping(objid, 1);
  objidpoolmanager::objective_playermask_addshowplayer(objid, player);
}

function private function_8c441f0c99924b47(race, player) {
  objid = objidpoolmanager::requestobjectiveid(100);
  race.finish_objid = objid;
  objidpoolmanager::objective_add_objective(objid, "current", race.current_checkpoint.origin, "jup_hud_icon_checkered_flag", "icon_small");
  objidpoolmanager::objective_set_play_intro(objid, 0);
  objidpoolmanager::update_objective_setzoffset(objid, 75);
  objidpoolmanager::update_objective_setbackground(objid, 1);
  function_9766d0b79eada249(objid, 1);
  objective_disableping(objid, 1);
  objidpoolmanager::objective_playermask_addshowplayer(objid, player);
}

function private function_2e04081059796fa1(scriptable, part, state, player, var_a5b2c541413aa895, usestring) {
  quest = br_map_quest::get_quest("race");
  race = scriptable.race;
  quest thread race_start(race, player);
}

function private function_b10b7aaa69d4882e(checkpoint) {
  race = checkpoint.race;
  player = race.player;
  player playlocalsound("wz_parkour_race_checkpoint");
  thread checkpoint_increment(race);
}

function private function_19d4d8b59f6fbfcd(race) {
  thread race_completed(race);
}

function private debug_init() {
  devgui_init();
}

function private devgui_init() {
  devgui::function_6e7290c8ee4f558b("<dev string:x97>");
  devgui::function_b23a59dfb4ca49a1("<dev string:xbd>", "<dev string:xd5>", &function_674a82e21ee1a22a);
  devgui::function_b23a59dfb4ca49a1("<dev string:xed>", "<dev string:x100>", &function_674a82e21ee1a22a);
  devgui::function_b23a59dfb4ca49a1("<dev string:x118>", "<dev string:x129>", &function_674a82e21ee1a22a);
  devgui::function_fe953f000498048f();
}

function private function_674a82e21ee1a22a(params) {
  level thread function_edb97f584e954807(params);
}

function function_edb97f584e954807(params) {
  quest = br_map_quest::get_quest("<dev string:x141>");

  switch (int(params[0])) {
    case 0:
      foreach(race in quest.races) {
        foreach(idx, str_checkpoint in race.checkpoint_structs) {
          str_color = "<dev string:x149>";

          if(idx == 0) {
            str_color = "<dev string:x151>";
          } else if(idx == race.checkpoint_structs.size - 1) {
            str_color = "<dev string:x15a>";
          }

          debug::debug_sphere(str_checkpoint, 25, str_color, 30, "<dev string:x161>", "<dev string:x161>");
        }
      }

      break;
    case 1:
      function_656e822afce77428();
      break;
    case 2:
      function_cd537c18037efbe(quest.races["<dev string:x177>"], level.player.origin);
      break;
  }
}

# /