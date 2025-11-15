/*************************************************
 * Decompiled by Serious and Edited by SyndiShanX
 * Script: cp\_load.gsc
*************************************************/

#using scripts\codescripts\struct;
#using scripts\cp\_ammo_cache;
#using scripts\cp\_art;
#using scripts\cp\_ballistic_knife;
#using scripts\cp\_bouncingbetty;
#using scripts\cp\_cache;
#using scripts\cp\_challenges;
#using scripts\cp\_debug;
#using scripts\cp\_decoy;
#using scripts\cp\_destructible;
#using scripts\cp\_devgui;
#using scripts\cp\_explosive_bolt;
#using scripts\cp\_flashgrenades;
#using scripts\cp\_hacker_tool;
#using scripts\cp\_heatseekingmissile;
#using scripts\cp\_incendiary;
#using scripts\cp\_laststand;
#using scripts\cp\_load;
#using scripts\cp\_mobile_armory;
#using scripts\cp\_oed;
#using scripts\cp\_proximity_grenade;
#using scripts\cp\_riotshield;
#using scripts\cp\_satchel_charge;
#using scripts\cp\_sensor_grenade;
#using scripts\cp\_skipto;
#using scripts\cp\_smokegrenade;
#using scripts\cp\_spawn_manager;
#using scripts\cp\_tabun;
#using scripts\cp\_tacticalinsertion;
#using scripts\cp\_trophy_system;
#using scripts\cp\_util;
#using scripts\cp\bonuszm\_bonuszm;
#using scripts\cp\bots\_bot;
#using scripts\cp\gametypes\_battlechatter;
#using scripts\cp\gametypes\_spawning;
#using scripts\cp\gametypes\_weaponobjects;
#using scripts\shared\_oob;
#using scripts\shared\abilities\_ability_player;
#using scripts\shared\archetype_shared\archetype_shared;
#using scripts\shared\array_shared;
#using scripts\shared\audio_shared;
#using scripts\shared\clientfield_shared;
#using scripts\shared\clientids_shared;
#using scripts\shared\containers_shared;
#using scripts\shared\demo_shared;
#using scripts\shared\flag_shared;
#using scripts\shared\flagsys_shared;
#using scripts\shared\gameobjects_shared;
#using scripts\shared\gameskill_shared;
#using scripts\shared\laststand_shared;
#using scripts\shared\load_shared;
#using scripts\shared\lui_shared;
#using scripts\shared\math_shared;
#using scripts\shared\medals_shared;
#using scripts\shared\music_shared;
#using scripts\shared\rank_shared;
#using scripts\shared\scene_shared;
#using scripts\shared\serverfaceanim_shared;
#using scripts\shared\string_shared;
#using scripts\shared\system_shared;
#using scripts\shared\turret_shared;
#using scripts\shared\tweakables_shared;
#using scripts\shared\util_shared;
#using scripts\shared\vehicle_shared;
#using scripts\shared\weapons\antipersonnelguidance;
#using scripts\shared\weapons\multilockapguidance;
#namespace load;

function main() {
  /
  #
  assert(isDefined(level.first_frame), "");
  if(isDefined(level._loadstarted) && level._loadstarted) {
    return;
  }
  function_13c5b077();
  level thread function_f063419c();
  level flag::init("bsp_swap_ready");
  level flag::init("initial_streamer_ready");
  level._loadstarted = 1;
  setdvar("playerEnenergy_enabled", 0);
  setdvar("r_waterFogTest", 0);
  setdvar("tu6_player_shallowWaterHeight", "0.0");
  setgametypesetting("trm_maxHeight", 144);
  level.aitriggerspawnflags = getaitriggerflags();
  level.vehicletriggerspawnflags = getvehicletriggerflags();
  level flag::init("wait_and_revive");
  level flag::init("instant_revive");
  util::registerclientsys("lsm");
  level thread register_clientfields();
  setup_traversals();
  level thread onallplayersready();
  footsteps();
  gameskill::setskill(undefined, level.skill_override);
  system::wait_till("all");
  art_review();
  level flagsys::set("load_main_complete");
  level.var_732e9c7d = & function_13aa782f;
  if(isDefined(level.skipto_point) && isDefined(level.default_skipto)) {
    if(level.skipto_point == level.default_skipto) {
      world.var_bf966ebd = undefined;
    }
  }
  level thread function_4dd1a4b();
}

function function_13c5b077() {
  setdvar("ui_allowDisplayContinue", 0);
}

function function_73adcefc() {
  util::set_level_start_flag("level_is_go");
}

function function_c32ba481(var_87423d00 = 0.5, v_color = (0, 0, 0)) {
  level util::streamer_wait(undefined, undefined, undefined, 0);
  setdvar("ui_allowDisplayContinue", 1);
  if(isloadingcinematicplaying()) {
    do {
      wait(0.05);
    }
    while(isloadingcinematicplaying());
  } else {
    wait(1);
  }
  foreach(player in level.players) {
    player thread function_84454eb5();
  }
  level flag::wait_till("all_players_spawned");
  level util::streamer_wait(undefined, 0, 10);
  level notify("level_is_go");
  level thread function_dbd0026c(var_87423d00, v_color);
}

function function_a2995f22(var_87423d00 = 0.5, v_color = (0, 0, 0)) {
  level clientfield::set("gameplay_started", 1);
  function_c32ba481(var_87423d00, v_color);
}

function function_84454eb5() {
  if(sessionmodeiscampaignzombiesgame()) {
    return;
  }
  self endon("disconnect");
  if(self flag::exists("loadout_given") && self flag::get("loadout_given")) {
    self openmenu("SpinnerFullscreenBlack");
    level flag::wait_till("all_players_spawned");
    self closemenu("SpinnerFullscreenBlack");
  }
}

function function_dbd0026c(var_87423d00, v_color) {
  level lui::screen_fade_out(0, "black", "go_fade");
  waittillframeend();
  if(level flagsys::get("chyron_active")) {
    level flagsys::wait_till_clear("chyron_active");
  } else {
    wait(1);
  }
  if(isDefined(level.var_75ba074a)) {
    wait(level.var_75ba074a);
  }
  level util::delay(0.3, undefined, & flag::set, level.str_level_start_flag);
  level util::delay(0.3, undefined, & lui::screen_fade_in, var_87423d00, v_color, "go_fade");
}

function function_f063419c() {
  if(isloadingcinematicplaying()) {
    while(isloadingcinematicplaying()) {
      wait(0.05);
    }
    level notify("loading_movie_done");
  }
}

function function_4dd1a4b() {
  checkpointcreate();
  checkpointcommit();
  flag::wait_till("all_players_spawned");
  wait(0.5);
  checkpointcreate();
  checkpointcommit();
}

function function_13aa782f(player, target, weapon) {
  return !player oob::isoutofbounds();
}

function player_damage_override(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime) {
  finaldamage = idamage;
  if(isDefined(self.player_damage_override)) {
    self thread[[self.player_damage_override]](einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, psoffsettime);
  }
  if(self laststand::player_is_in_laststand()) {
    return 0;
  }
  if(level.teambased && isplayer(eattacker) && self != eattacker && self.team == eattacker.team) {
    if(level.friendlyfire == 0) {
      return 0;
    }
  }
  if(idamage < self.health) {
    return finaldamage;
  }
  players = getplayers();
  count = 0;
  for(i = 0; i < players.size; i++) {
    if(players[i] == self || players[i] laststand::player_is_in_laststand() || players[i].sessionstate == "spectator") {
      count++;
    }
  }
  solo_death = players.size == 1 && self.lives == 0;
  non_solo_death = players.size > 1 && count == players.size;
  if(solo_death || non_solo_death) {
    level notify("stop_suicide_trigger");
    self thread laststand::playerlaststand(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
    if(!isDefined(vdir)) {
      vdir = (1, 0, 0);
    }
    level notify("last_player_died");
    self fakedamagefrom(vdir);
    self thread player_fake_death();
  }
  if(count == players.size) {
    if(players.size == 1) {
      if(self.lives == 0) {
        self.lives = 0;
        level notify("pre_end_game");
        util::wait_network_frame();
        level notify("end_game");
      } else {
        return finaldamage;
      }
    } else {
      level notify("pre_end_game");
      util::wait_network_frame();
      level notify("end_game");
    }
    return 0;
  }
  return finaldamage;
}

function player_fake_death() {
  level notify("fake_death");
  self notify("fake_death");
  self takeallweapons();
  self allowstand(0);
  self allowcrouch(0);
  self allowprone(1);
  self.ignoreme = 1;
  self enableinvulnerability();
  wait(1);
  self freezecontrols(1);
}

function setfootstepeffect(name, fx) {
  assert(isDefined(name), "");
  assert(isDefined(fx), "");
  if(!isDefined(anim.optionalstepeffects)) {
    anim.optionalstepeffects = [];
  }
  anim.optionalstepeffects[anim.optionalstepeffects.size] = name;
  level._effect["step_" + name] = fx;
}

function footsteps() {
  setfootstepeffect("asphalt", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("brick", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("carpet", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("cloth", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("concrete", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("dirt", "_t6/bio/player/fx_footstep_sand");
  setfootstepeffect("foliage", "_t6/bio/player/fx_footstep_sand");
  setfootstepeffect("gravel", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("grass", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("metal", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("mud", "_t6/bio/player/fx_footstep_mud");
  setfootstepeffect("paper", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("plaster", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("rock", "_t6/bio/player/fx_footstep_dust");
  setfootstepeffect("sand", "_t6/bio/player/fx_footstep_sand");
  setfootstepeffect("water", "_t6/bio/player/fx_footstep_water");
  setfootstepeffect("wood", "_t6/bio/player/fx_footstep_dust");
}

function init_traverse() {
  point = getent(self.target, "targetname");
  if(isDefined(point)) {
    self.traverse_height = point.origin[2];
    point delete();
  } else {
    point = struct::get(self.target, "targetname");
    if(isDefined(point)) {
      self.traverse_height = point.origin[2];
    }
  }
}

function setup_traversals() {
  potential_traverse_nodes = getallnodes();
  for(i = 0; i < potential_traverse_nodes.size; i++) {
    node = potential_traverse_nodes[i];
    if(node.type == "Begin") {
      node init_traverse();
    }
  }
}

function preload_next_mission() {
  assert(0, "");
}

function load_next_mission() {
  level flag::wait_till("bsp_swap_ready");
  switchmap_switch();
}

function end_game() {
  level waittill("end_game");
  check_end_game_intermission_delay();
  println("");
  util::clientnotify("zesn");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    util::setclientsysstate("lsm", "0", players[i]);
  }
  for(i = 0; i < players.size; i++) {
    if(isDefined(players[i].revivetexthud)) {
      players[i].revivetexthud destroy();
    }
  }
  stopallrumbles();
  level.intermission = 1;
  wait(0.1);
  game_over = [];
  survived = [];
  players = getplayers();
  setmatchflag("disableIngameMenu", 1);
  foreach(player in players) {
    player closeingamemenu();
  }
  if(!isDefined(level.gameenduicallback)) {
    for(i = 0; i < players.size; i++) {
      game_over[i] = newclienthudelem(players[i]);
      game_over[i].alignx = "center";
      game_over[i].aligny = "middle";
      game_over[i].horzalign = "center";
      game_over[i].vertalign = "middle";
      game_over[i].y = game_over[i].y - 130;
      game_over[i].foreground = 1;
      game_over[i].fontscale = 3;
      game_over[i].alpha = 0;
      game_over[i].color = (1, 1, 1);
      game_over[i].hidewheninmenu = 1;
      game_over[i] settext(&"COOP_GAME_OVER");
      game_over[i] fadeovertime(1);
      game_over[i].alpha = 1;
      if(players[i] issplitscreen()) {
        game_over[i].fontscale = 2;
        game_over[i].y = game_over[i].y + 40;
      }
    }
  } else {
    level thread[[level.gameenduicallback]]("");
  }
  for(i = 0; i < players.size; i++) {
    players[i] setclientuivisibilityflag("weapon_hud_visible", 0);
    players[i] setclientminiscoreboardhide(1);
  }
  uploadstats();
  wait(1);
  wait(3.95);
  foreach(icon in survived) {
    icon destroy();
  }
  foreach(icon in game_over) {
    icon destroy();
  }
  level notify("round_end_done");
  if(isDefined(level.intermission_override_func)) {
    [[level.intermission_override_func]]();
    level.intermission_override_func = undefined;
  } else {
    intermission();
    wait(15);
    level notify("stop_intermission");
  }
  array::thread_all(getplayers(), & player_exit_level);
  wait(1.5);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    players[i] cameraactivate(0);
  }
  exitlevel(0);
  wait(666);
}

function intermission() {
  level.intermission = 1;
  level notify("intermission");
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    util::setclientsysstate("levelNotify", "zi", players[i]);
    players[i] setclientthirdperson(0);
    players[i] resetfov();
    players[i].health = 100;
    players[i] thread player_intermission();
    players[i] stopsounds();
  }
  wait(0.25);
  players = getplayers();
  for(i = 0; i < players.size; i++) {
    util::setclientsysstate("lsm", "0", players[i]);
  }
}

function player_intermission() {
  self closeingamemenu();
  level endon("stop_intermission");
  self endon("disconnect");
  self endon("death");
  self notify("_zombie_game_over");
  self.sessionstate = "intermission";
  self.spectatorclient = -1;
  self.archivetime = 0;
  self.psoffsettime = 0;
  self.friendlydamage = undefined;
  points = struct::get_array("intermission", "targetname");
  if(!isDefined(points) || points.size == 0) {
    points = getEntArray("info_intermission", "classname");
    if(points.size < 1) {
      println("");
      return;
    }
  }
  self.game_over_bg = newclienthudelem(self);
  self.game_over_bg.horzalign = "fullscreen";
  self.game_over_bg.vertalign = "fullscreen";
  self.game_over_bg setshader("black", 640, 480);
  self.game_over_bg.alpha = 1;
  org = undefined;
  while(true) {
    points = array::randomize(points);
    for(i = 0; i < points.size; i++) {
      point = points[i];
      if(!isDefined(org)) {
        self spawn(point.origin, point.angles);
      }
      if(isDefined(points[i].target)) {
        if(!isDefined(org)) {
          org = spawn("script_model", self.origin + (vectorscale((0, 0, -1), 60)));
          org setModel("tag_origin");
        }
        org.origin = points[i].origin;
        org.angles = points[i].angles;
        for(j = 0; j < getplayers().size; j++) {
          player = getplayers()[j];
          player camerasetposition(org);
          player camerasetlookat();
          player cameraactivate(1);
        }
        speed = 20;
        if(isDefined(points[i].speed)) {
          speed = points[i].speed;
        }
        target_point = struct::get(points[i].target, "targetname");
        dist = distance(points[i].origin, target_point.origin);
        time = dist / speed;
        q_time = time * 0.25;
        if(q_time > 1) {
          q_time = 1;
        }
        self.game_over_bg fadeovertime(q_time);
        self.game_over_bg.alpha = 0;
        org moveto(target_point.origin, time, q_time, q_time);
        org rotateto(target_point.angles, time, q_time, q_time);
        wait(time - q_time);
        self.game_over_bg fadeovertime(q_time);
        self.game_over_bg.alpha = 1;
        wait(q_time);
        continue;
      }
      self.game_over_bg fadeovertime(1);
      self.game_over_bg.alpha = 0;
      wait(5);
      self.game_over_bg thread fade_up_over_time(1);
    }
  }
}

function fade_up_over_time(t) {
  self fadeovertime(t);
  self.alpha = 1;
}

function player_exit_level() {
  self allowstand(1);
  self allowcrouch(0);
  self allowprone(0);
  if(isDefined(self.game_over_bg)) {
    self.game_over_bg.foreground = 1;
    self.game_over_bg.sort = 100;
    self.game_over_bg fadeovertime(1);
    self.game_over_bg.alpha = 1;
  }
}

function disable_end_game_intermission(delay) {
  level.disable_intermission = 1;
  wait(delay);
  level.disable_intermission = undefined;
}

function check_end_game_intermission_delay() {
  if(isDefined(level.disable_intermission)) {
    while(true) {
      if(!isDefined(level.disable_intermission)) {
        break;
      }
      wait(0.01);
    }
  }
}

function onallplayersready() {
  level flag::init("start_coop_logic");
  level thread end_game();
  println("" + getnumexpectedplayers());
  do {
    wait(0.05);
    var_f862b7b1 = getnumconnectedplayers(0);
    var_91f98264 = getnumexpectedplayers();
    player_count_actual = 0;
    for(i = 0; i < level.players.size; i++) {
      if(level.players[i].sessionstate == "playing" || level.players[i].sessionstate == "spectator") {
        player_count_actual++;
      }
    }
    println((("" + getnumconnectedplayers()) + "") + getnumexpectedplayers());
  }
  while(var_f862b7b1 < var_91f98264 || player_count_actual < var_91f98264);
  setinitialplayersconnected();
  setdvar("all_players_are_connected", "1");
  printtoprightln("", (1, 1, 1));
  disablegrenadesuicide();
  level flag::set("all_players_connected");
  level flag::set("initial_streamer_ready");
  level flag::set("start_coop_logic");
}

function register_clientfields() {
  clientfield::register("toplayer", "sndHealth", 1, 2, "int");
}