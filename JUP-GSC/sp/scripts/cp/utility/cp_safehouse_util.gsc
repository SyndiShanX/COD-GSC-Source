/****************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp\utility\cp_safehouse_util.gsc
****************************************************/



#using scripts\common\utility;
#using scripts\cp\cp_dialogue;
#using scripts\cp\cp_kidnapper;
#using scripts\cp\cp_objectives;
#using scripts\cp\cp_player_battlechatter;
#using scripts\cp\laststand;
#using scripts\cp\spawning;
#using scripts\cp\utility;
#using scripts\cp\utility\cp_safehouse_util;
#using scripts\cp\vo;
#using scripts\cp_mp\killstreaks\chopper_gunner;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_occupancy;
#using scripts\engine\utility;
#namespace cp_safehouse_util;

function slamcamoverlay(var_ad4dd16f29e24b77, holdduration, var_dfab0807d83a77fe) {
  overlay = newclienthudelem(self);
  overlay.x = 0;
  overlay.y = 0;
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.sort = 1;
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.foreground = 1;

  if(isDefined(var_ad4dd16f29e24b77) && var_ad4dd16f29e24b77 > 0) {
    overlay.alpha = 0;
  } else {
    overlay.alpha = 1;
  }

  overlay setshader("black", 640, 480);

  if(isDefined(var_ad4dd16f29e24b77) && var_ad4dd16f29e24b77 > 0) {
    self notify("fadeDown_start");
    overlay fadeovertime(var_ad4dd16f29e24b77);
    overlay.alpha = 1;
    wait var_ad4dd16f29e24b77;
    self notify("fadeDown_complete");
  }

  if(isDefined(holdduration) && holdduration > 0) {
    wait holdduration;
  }

  self notify("fadeUp_start");

  if(!isDefined(var_dfab0807d83a77fe)) {
    var_dfab0807d83a77fe = 0.5;
  }

  if(var_dfab0807d83a77fe > 0) {
    overlay fadeovertime(var_dfab0807d83a77fe);
    overlay.alpha = 0;
    wait var_dfab0807d83a77fe;
  }

  self notify("fadeUp_complete");

  if(isDefined(overlay)) {
    overlay destroy();
  }
}

function kill_all_enemies() {
  scripts\cp\spawning::stop_all_groups();
  level.ambient_spawning_paused = 1;

  foreach(spawned_enemy in level.agentarray) {
    if(!istrue(spawned_enemy.isactive)) {
      continue;
    }

    spawned_enemy.nocorpse = 1;
    spawned_enemy dodamage(spawned_enemy.health + 1000, spawned_enemy.origin, undefined, undefined, "MOD_EXPLOSIVE", "iw8_la_rpapa7_mp_friendly");
  }

  level.ambient_spawning_paused = 0;
}

function regroup_blackscreen(player, var_ad170c2b0c7a7fb2, obj_ref, var_ad170b2b0c7a7d7f) {
  if(!isDefined(player)) {
    player = self;
  }

  player endon("disconnect");
  player disableweapons();
  player freezecontrolswrapper(1);
  player setclientomnvar("ui_hide_hud", 1);
  fullscreen_overlay = newclienthudelem(player);
  fullscreen_overlay.x = 0;
  fullscreen_overlay.y = 0;
  fullscreen_overlay setshader("black", 640, 480);
  fullscreen_overlay.alignx = "left";
  fullscreen_overlay.aligny = "top";
  fullscreen_overlay.sort = 1;
  fullscreen_overlay.horzalign = "fullscreen";
  fullscreen_overlay.vertalign = "fullscreen";
  fullscreen_overlay.alpha = 1;
  fullscreen_overlay.foreground = 1;
  level waittill(var_ad170c2b0c7a7fb2);
  player thread show_regroup_text(obj_ref);
  level waittill(var_ad170b2b0c7a7d7f);
  player setclientomnvar("ui_chyron_on", 0);
  player setclientomnvar("ui_hide_hud", 0);
  player freezecontrolswrapper(0);
  player enableweapons();
  fullscreen_overlay fadeovertime(2);
  fullscreen_overlay.alpha = 0.5;
  wait 2;
  fullscreen_overlay destroy();
}

function toggle_safehouse_settings(toggle) {
  if(istrue(toggle)) {
    level.disable_hotjoin_via_ac130 = 1;
    level.dogtag_revive = 1;
    level.disable_munitions = 1;
    level.spawninsafehouse = 1;
  } else {
    if(!istrue(level.relic_dogtags)) {
      level.disable_hotjoin_via_ac130 = 0;
      level.dogtag_revive = 0;
    }

    level.disable_munitions = 0;
    level.spawninsafehouse = 0;
  }

  level notify("toggle_safehouse_settings", toggle);

  if(toggle) {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(0);
    level.post_loadout_spawn_func = &post_loadout_spawn_func;
  } else {
    level thread scripts\cp\cp_kidnapper::togglekidnappers(1);
    level.post_loadout_spawn_func = undefined;
  }

  foreach(player in level.players) {
    player toggle_player_settings(toggle);
  }
}

function toggle_player_settings(toggle) {
  player = self;

  if(toggle) {
    player setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    player thread viewmodel_demeanor();
    player disableweaponswitch();
    player disableoffhandweapons();
    player allowmelee(0);
    player allowsupersprint(0);
    player allowsprint(0);
    player allowads(0);
    player allowcrouch(0);
    player allowprone(0);
    player allowmantle(0);
    player allowjump(0);
    player setclientomnvar("ui_briefing", 1);
    player.allowednormaldemeanor = 0;
    player.ignoreme = 1;
    return;
  }

  player notify("normal_demeanor");
  player setdemeanorviewmodel("normal");
  player enableweaponswitch();
  player enableoffhandweapons();
  player allowmelee(1);
  player allowsupersprint(1);
  player allowsprint(1);
  player allowads(1);
  player allowcrouch(1);
  player allowprone(1);
  player allowmantle(1);
  player allowjump(1);
  player setclientomnvar("ui_briefing", 0);
  player.allowednormaldemeanor = 1;
  player.ignoreme = 0;
}

function viewmodel_demeanor() {
  self endon("normal_demeanor");
  self notify("viewmodel_demeanor");
  self endon("viewmodel_demeanor");

  while(true) {
    self waittill("loadout_given");
    wait 2;

    if(istrue(self.allowednormaldemeanor)) {
      self setdemeanorviewmodel("normal");
      continue;
    }

    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
  }
}

function edit_loadout_think(struct) {
  level endon("game_ended");
  model = spawn("script_model", struct.origin);
  model setModel("tag_origin");
  model sethintobject(undefined, "HINT_BUTTON", undefined, &"CP_DWN_TWN_OBJECTIVES/DWN_TWN_LOADOUT", 25, "duration_short", "hide", 256, 65, 64, 65);
  model.headicon = createheadicon(model);
  setheadiconimage(model.headicon, "hud_icon_survival_weapon");
  setheadiconsnaptoedges(model.headicon, 0);
  setheadiconmaxdistance(model.headicon, 1024);
  setheadiconnaturaldistance(model.headicon, 30);
  setheadiconzoffset(model.headicon, 10);

  while(true) {
    model waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    if(scripts\cp\laststand::player_in_laststand(player)) {
      continue;
    }

    player thread edit_loadout(model);
  }
}

function edit_loadout(interaction) {
  self endon("disconnect");
  self endon("last_stand");
  level endon("game_ended");
  level thread function_54dac17e1c475546(self, interaction);
  interaction disableplayeruse(self);
  self setclientomnvar("cp_open_cac", -1);
  self setclientomnvar("ui_options_menu", 2);
  waittill_any_2("loadout_given", "loadout_menu_closed");
  wait 1;
  self setclientomnvar("cp_open_cac", -2);
  interaction enableplayeruse(self);
}

function function_54dac17e1c475546(player, interaction) {
  level endon("game_ended");
  player endon("death_or_disconnect");
  player endon("loadout_menu_closed");
  player waittill("last_stand_start");
  level thread function_61f53ed6cfde56b4(player, interaction);
  player setclientomnvar("cp_open_cac", -2);
  player clearsoundsubmix("cp_store_duck", 1);
}

function function_61f53ed6cfde56b4(player, interaction) {
  level endon("game_ended");
  player endon("disconnect");
  player endon("revive");
  player waittill("respawn_player");

  if(isDefined(interaction) && isPlayer(player)) {
    interaction enableplayeruse(player);
  }
}

function mission_select_think(mission) {
  while(true) {
    self waittill("trigger", player);

    if(!player is_valid_player()) {
      continue;
    }

    self makeunusable();
    scripts\cp\cp_dialogue::stop_current_dialogue();
    thread run_mission(mission);
    level notify("mission_selected", mission);
    self.used = 1;
    return;
  }
}

function run_mission(mission) {
  delaythread(2, &scripts\cp\cp_objectives::run_objective, mission, "primary");
}

function safehouse_revive_and_move_players(safehouse_structs) {
  foreach(player in level.players) {
    inlaststand = 0;

    if(scripts\cp\laststand::player_in_laststand(player)) {
      inlaststand = 1;
    }

    player thread player_move(safehouse_structs, index, inlaststand);
  }
}

function player_move(safehouse_structs, index, inlaststand) {
  self endon("disconnect");
  safehouse_structs[index].angles = ter_op(isDefined(safehouse_structs[index].angles), safehouse_structs[index].angles, (0, 0, 0));
  self.respawn_forcespawnorigin = safehouse_structs[index].origin;
  self.respawn_forcespawnangles = safehouse_structs[index].angles;

  if(istrue(inlaststand)) {
    scripts\cp\laststand::instant_revive(self);
  }

  if(isDefined(self.currentturret)) {
    self.currentturret notify("kill_turret", 0, 0);
  }

  if(isDefined(level.choppergunners)) {
    foreach(gunner in level.choppergunners) {
      gunner scripts\cp_mp\killstreaks\chopper_gunner::choppergunner_returnplayer(0, 0);
    }
  }

  if(isDefined(self.helperdrone)) {
    self.helperdrone scripts\cp_mp\killstreaks\helper_drone::function_6edfda4764129e3(0);
  }

  if(istrue(self isonladder())) {
    self setOrigin(getgroundposition(self.origin + anglesToForward(self.angles) * -50, 16));
    wait 0.1;
  }

  player_vehicle = scripts\cp_mp\utility\player_utility::getvehicle();

  if(isDefined(player_vehicle)) {
    seatid = scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_getoccupantseat(player_vehicle, self);
    scripts\cp_mp\vehicles\vehicle_occupancy::vehicle_occupancy_exit(player_vehicle, seatid, self, undefined, 1);
  }

  self setOrigin(safehouse_structs[index].origin);
  self setplayerangles(safehouse_structs[index].angles);
}

function num_players_in_safehouse(volume) {
  var_a25a40bdd7bf4112 = 0;

  if(isDefined(volume)) {
    foreach(player in level.players) {
      if(player istouching(volume)) {
        var_a25a40bdd7bf4112++;
      }
    }
  }

  return var_a25a40bdd7bf4112;
}

function safehouse_regroup(safehouse_vol, flagname) {
  index = 0;
  objective_active = 0;

  while(index < 31) {
    num_players = scripts\cp\utility\cp_safehouse_util::num_players_in_safehouse(safehouse_vol);
    respawning_players = get_respawning_players();

    if(num_players && respawning_players.size == 0) {
      level notify("player_entered_safehouse_vol");

      if(num_players == level.players.size) {
        if(!objective_active) {
          thread objective_update("safehouse_return_timer", 6, undefined, undefined, 1, undefined, 1, 1);
          objective_active = 1;
          index = int(max(index, 25));
        }
      } else if(!objective_active) {
        thread objective_update("safehouse_return_timer", 30, 20, 10, 1, undefined, 1, 1);
        objective_active = 1;
      }

      index++;
    } else {
      if(objective_active) {
        scripts\cp\cp_objectives::lua_objective_complete("safehouse_return_timer");
        thread objective_update("safehouse_return");
        objective_active = 0;
      }

      index = 0;
    }

    wait 1;
  }

  if(isDefined(flagname) && flag_exist(flagname)) {
    flag_set(flagname);
  }
}

function get_respawning_players() {
  guys = [];

  foreach(player in level.players) {
    if(istrue(player.queued_up_to_respawn) || istrue(player isparachuting()) || istrue(player isskydiving()) || istrue(self.isreviving) || istrue(self.beingrevived)) {
      guys[guys.size] = player;
    }
  }

  return guys;
}

function safehouse_create_loot(loot_boxes) {
  foreach(loot_box in loot_boxes) {
    loot_box thread create_fake_loot();
  }
}

function toggle_safehouse_doors(frozen, pos, radius, name, key) {
  var_786fd7c325a6d910 = getentitylessscriptablearray("scriptable_" + name, key, pos, radius);

  foreach(escriptable in var_786fd7c325a6d910) {
    if(escriptable scriptableisdoor()) {
      if(frozen) {
        timeout = 0;
        escriptable scriptabledoorclose();

        while(!escriptable scriptabledoorisclosed() && timeout < 10) {
          wait 0.1;
          timeout++;
        }

        escriptable scriptabledoorfreeze(1);
        continue;
      }

      escriptable scriptabledoorfreeze(0);
    }
  }
}

function wait_for_door_open(pos, radius, name, key) {
  var_786fd7c325a6d910 = getentitylessscriptablearray("scriptable_" + name, key, pos, radius);

  foreach(escriptable in var_786fd7c325a6d910) {
    if(escriptable scriptableisdoor()) {
      escriptable thread wait_for_open();
    }
  }
}

function wait_for_open() {
  while(self scriptabledoorisclosed()) {
    wait 1;
  }

  level notify("safehouse_door_opened");
}

function play_overlord_howcopy_vo(var_b2bc8b6fd1d16561) {
  var_356974bdf96a636e = [];
  var_356973bdf96a613b = [];
  var_356974bdf96a636e[var_356974bdf96a636e.size] = "dx_cps_kama_convo_start_10";
  var_356974bdf96a636e[var_356974bdf96a636e.size] = "dx_cps_kama_convo_start_20";
  var_356974bdf96a636e[var_356974bdf96a636e.size] = "dx_cps_kama_convo_start_30";
  var_356973bdf96a613b[var_356973bdf96a613b.size] = "dx_cps_lass_convo_start_10";
  var_356973bdf96a613b[var_356973bdf96a613b.size] = "dx_cps_lass_convo_start_20";
  var_356973bdf96a613b[var_356973bdf96a613b.size] = "dx_cps_lass_convo_start_30";
  var_9ff666d3b44e5bad = undefined;

  if(isDefined(var_b2bc8b6fd1d16561)) {
    if(var_b2bc8b6fd1d16561 == "kama") {
      var_9ff666d3b44e5bad = random(var_356974bdf96a636e);
    } else if(var_b2bc8b6fd1d16561 == "lass") {
      var_9ff666d3b44e5bad = random(var_356973bdf96a613b);
    }
  } else if(cointoss()) {
    var_9ff666d3b44e5bad = random(var_356974bdf96a636e);
  } else {
    var_9ff666d3b44e5bad = random(var_356973bdf96a613b);
  }

  level scripts\cp\vo::try_to_play_vo_on_team(var_9ff666d3b44e5bad, "allies");
  play_operator_reply_vo(undefined, "conv_generic_reply");
}

function play_operator_reply_vo(player_override, input_vo) {
  all_players = getplayersinteam("allies");
  good_players = [];

  foreach(player in all_players) {
    if(player scripts\cp_mp\utility\player_utility::_isalive()) {
      good_players[good_players.size] = player;
    }
  }

  var_8850d9f771525016 = random(good_players);

  if(isDefined(player_override)) {
    var_8850d9f771525016 = player_override;
  }

  waittime = level scripts\cp\cp_player_battlechatter::trysaylocalsound(var_8850d9f771525016, input_vo);

  if(isfloat(waittime)) {
    wait waittime;
  }

  wait 0.4 + randomfloat(0.4);
}

function safehouse_hotjoin_func() {
  level endon("game_ended");

  while(true) {
    level waittill("player_spawned", player);

    if(istrue(level.spawninsafehouse)) {
      player thread safehouse_spawn();
    }
  }
}

function safehouse_spawn() {
  self endon("disconnect");
  player = self;
  player_spawned = 0;

  while(true) {
    if(isDefined(level.current_safehouse_spawn_structs)) {
      foreach(struct in level.current_safehouse_spawn_structs) {
        if(!any_player_nearby(struct.origin, 64)) {
          if(!isDefined(struct.angles)) {
            struct.angles = (0, 0, 0);
          }

          player.respawn_forcespawnorigin = struct.origin;
          player.respawn_forcespawnangles = struct.angles;
          player setOrigin(struct.origin);
          player setplayerangles(struct.angles);
          player dontinterpolate();
          player toggle_player_settings(1);
          player_spawned = 1;
        }
      }
    }

    if(player_spawned) {
      return;
    }

    wait 0.05;
  }
}

function post_loadout_spawn_func() {
  self endon("disconnect");
  level endon("game_ended");

  while(isnullweapon(self getcurrentprimaryweapon())) {
    wait 0.05;
  }

  weaponobj = self getcurrentprimaryweapon();
  self setspawnweapon(weaponobj, 1);

  if(istrue(level.spawninsafehouse)) {
    self setdemeanorviewmodel("safe", "iw8_ges_demeanor_safe");
    toggle_player_settings(1);
    self.player_latespawn_safehouse = 1;
  }
}

function show_regroup_text(obj_ref) {
  map_name = getDvar(@ "ui_mapname");
  objective_table = "cp/" + map_name + "_objectives.csv";
  objective_index = int(tablelookup(objective_table, 1, obj_ref, 0));
  self setclientomnvar("ui_hide_hud", 0);
  self setclientomnvar("ui_chyron_mission_index", objective_index);
  self setclientomnvar("ui_chyron_on", 1);
  wait 5;
  level notify("regroup_text_done");
}