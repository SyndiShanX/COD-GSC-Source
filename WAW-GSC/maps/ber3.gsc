/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\ber3.gsc
**************************************/

#include common_scripts\utility;
#include maps\_utility;
#include maps\_anim;
#include maps\ber3_util;

main() {
  maps\ber3_fx::main();

  maps\_t34::main("vehicle_rus_tracked_t34", "t34");
  maps\_flak88::main("artillery_ger_flak88");
  maps\_katyusha::main("vehicle_rus_wheeled_bm13", "katyusha");
  maps\_artillery::main("artillery_ger_pak43", "pak43");
  maps\_stuka::main("vehicle_stuka_flying");
  maps\_aircraft::main("vehicle_rus_airplane_il2", "il2");

  maps\_vehicle::build_treadfx();

  build_starts();
  init_flags();
  precache_models();

  setup_friendlies();
  setup_drones();

  maps\_load::main();

  maps\ber3_anim::main();
  thread maps\ber3_amb::main();

  maps\ber3_anim::main();
  setup_strings();

  thread build_threatbias_groups();

  thread collectible_corpse_spawn("collectible_struct", character\char_ger_honorguard_mp44::main);

  if(NumRemoteClients()) {
    if(NumRemoteClients() > 1) {
      level.max_drones["allies"] = 6;
    }

    flag_wait("all_players_connected");

    clientNotify("dl");
  }
}

precache_models() {
  precacheshellshock("ber3_intro");
  precacheshellshock("ber3_outro");

  precachevehicle("stuka");
  precachevehicle("t34");

  PrecacheModel("viewmodel_rus_guard_player");
  PrecacheModel("static_berlin_books_diary");
  precachemodel("vehicle_rus_airplane_il2");
  PrecacheModel("anim_berlin_rus_flag_rolled");
  PrecacheModel("anim_berlin_rus_flag_rolled_sm");
  precacheModel("weapon_ger_panzershreck_rocket");
  PrecacheModel("katyusha_rocket");
  precachemodel("weapon_usa_explosive_russian");
  precachemodel("weapon_rus_molotov_grenade");
  precachemodel("weapon_rus_ppsh_smg");
  precachemodel("anim_alley_brick_chunks");
  precachemodel("anim_berlin_nazi_burnt_flag");
  precachemodel("anim_berlin_stag_column");
  precachemodel("mounted_ger_fg42_bipod_lmg");
  precachemodel("char_ger_traitorsign");
  precachemodel("char_rus_guard_grachev_burn");
  precachemodel("static_peleliu_flak88_shell");

  precachestring(&"BER3_HINT_PLANT_CHARGE");

  precacherumble("tank_rumble");
}

setup_drones() {
  character\char_rus_r_ppsh::precache();
  character\char_ger_honorguard_mp44::precache();

  level.drone_spawnFunction["allies"] = character\char_rus_r_ppsh::main;
  level.drone_spawnFunction["axis"] = character\char_ger_honorguard_mp44::main;

  maps\_drones::init();
}

build_starts() {
  add_start("intro", maps\ber3_event_intro::event_intro_start, &"BER3_WARP_INTRO");

  add_start("plaza", maps\ber3_event_plaza::event_plaza_start, &"BER3_WARP_PLAZA");

  add_start("reich", maps\ber3_event_steps::event_reich_start, &"BER3_WARP_REICH");

  add_start("default", level.start_functions["intro"]);
  default_start(level.start_functions["intro"]);

  start = tolower(getDvar("start"));
  if(isDefined(level.start_point) && level.start_point != "default") {
    setDvar("introscreen", "0");
  }
}

build_threatbias_groups() {
  createthreatbiasgroup("panzer_group");
  createthreatbiasgroup("mg42_group");
  createthreatbiasgroup("player_group");

  setignoremegroup("player_group", "panzer_group");
  setthreatbias("player_group", "mg42_group", -1000);

  spawners = getEntArray("mg42_ai", "script_noteworthy");
  array_thread(spawners, ::add_spawn_function, ::mg42_set_threatgroup);
}

mg42_set_threatgroup() {
  self setthreatbiasgroup("mg42_group");
}

init_flags() {
  flag_init("friends_setup");
}

setup_strings() {}

set_objective(num) {}
objectives_skip(numToSkipPast) {
  for(i = 1; i <= numToSkipPast; i++) {
    set_objective(i);
  }
}
objective_follow_ent(objectiveNum, ent) {
  ent endon("death");
  level endon("objective_stop_following_ent");

  while(1) {
    if(isDefined(ent)) {
      objective_position(objectiveNum, ent.origin);
    }

    wait(0.05);
  }
}
warp_players(startValue, startKey) {
  starts = getStructArray(startValue, startKey);
  ASSERT(starts.size == 4);

  players = get_players();

  for(i = 0; i < players.size; i++) {
    players[i] setOrigin(starts[i].origin);

    players[i] setPlayerAngles(starts[i].angles);

    players[i] setthreatbiasgroup("player_group");
  }

  set_breadcrumbs(starts);
}

warp_players_underworld() {
  underworld = GetStruct("struct_player_teleport_underworld", "targetname");
  if(!isDefined(underworld)) {
    ASSERTMSG("warp_players_underworld(): can't find the underworld warp spot! aborting.");
    return;
  }

  players = get_players();

  for(i = 0; i < players.size; i++) {
    players[i] SetOrigin(underworld.origin);
  }
}

warp_player(pos) {
  self endon("death");
  self endon("disconnect");

  if(!isDefined(self.warpblack)) {
    self.warpblack = NewClientHudElem(self);
    self.warpblack.x = 0;
    self.warpblack.y = 0;
    self.warpblack.horzAlign = "fullscreen";
    self.warpblack.vertAlign = "fullscreen";
    self.warpblack.foreground = false;
    self.sort = 50;
    self.warpblack.alpha = 0;
    self.warpblack SetShader("black", 640, 480);
  }
  self.warpblack FadeOverTime(.75);
  self.warpblack.alpha = 1;

  wait(.75);
  self setorigin(pos);
  self.warpblack FadeOverTime(.75);
  self.warpblack.alpha = 0;
}

setup_friendlies() {
  level.friends = grab_starting_friends();

  level.sarge = getent("sarge", "script_noteworthy");
  level.sarge thread magic_bullet_shield();
  level.sarge.animname = "reznov";

  level.chernov = getent("chernov", "script_noteworthy");
  level.chernov thread magic_bullet_shield();
  level.chernov.animname = "reznov";
}
warp_friendlies(startValue, startKey) {
  friendlyStarts = getStructArray(startValue, startKey);
  ASSERTEX(friendlyStarts.size > 0, "warp_friendlies(): didn't find enough friendly start points!");

  for(i = 0; i < level.friends.size; i++) {
    level.friends[i] Teleport(groundpos(friendlyStarts[i].origin), friendlyStarts[i].angles);
  }
}
hangguy() {
  forcex = randomFloatRange(1000, 3000);
  forcey = randomFloatRange(-1000, 3000);
  forcez = randomFloatRange(1000, 3000);

  dir = (forcex, forcey, forcez);
  contactPoint = self.origin + (randomfloatrange(-1, 1), randomfloatrange(-1, 1), randomfloatrange(-1, 1));
  self physicsLaunch(contactPoint, dir);
}
hangguy_with_ragdoll(bonename, length) {
  sign = spawn("script_model", self getTagOrigin("J_SpineUpper"));
  sign.angles = self getTagAngles("J_SpineUpper");
  sign setModel("char_ger_traitorsign");
  sign linkto(self, "J_SpineUpper", (3, 7, 0), (-90, 0, 180));

  start = self.origin + (0, 0, length + 22);
  end = (0, 0, 0);
  ropeId = createrope(start, end, length, self, bonename, 1);
  self startragdoll();
}

move_tank_on_trigger(pathname, trigname) {
  tank_startnode = getvehiclenode(pathname, "targetname");

  getent(trigname, "targetname") waittill("trigger");

  self attachPath(tank_startnode);
  wait(.2);
  self startPath(tank_startnode);
}

spawn_tank(tank_type, start_node, kill_tank) {
  while(!OkTospawn()) {
    wait_network_frame();
  }

  tank = spawnvehicle(tank_type, "tank", "t34", start_node.origin, start_node.angles);
  tank.vehicletype = "t34";
  maps\_vehicle::vehicle_init(tank);

  tank.script_turretmg = 0;

  tank attachPath(start_node);
  tank startPath();

  if(isDefined(kill_tank) && kill_tank) {
    wait(20);
    tank delete();
  } else {
    return tank;
  }
}

spawn_plane(plane_type, start_node) {
  while(!OkTospawn()) {
    wait_network_frame();
  }

  plane = spawnvehicle(plane_type, "plane", "stuka", start_node.origin, start_node.angles);

  plane attachPath(start_node);
  plane startpath();
  plane playSound("fly_by");
  wait(3.5);
  plane playSound("fly_by_shoot");

  plane waittill("reached_end_node");
  plane delete();
}
veh_stop_at_node(node_name, accel, decel) {
  if(!isDefined(accel)) {
    accel = 15;
  }

  if(!isDefined(decel)) {
    decel = 15;
  }

  vnode = getvehiclenode(node_name, "script_noteworthy");
  vnode waittill("trigger");

  self setspeed(0, accel, decel);
}
satchel_setup(charge_trig, target_ent) {
  self thread remove_satchel_on_death(charge_trig);

  self endon("death");
  wait(2);

  charge = getent(charge_trig.target, "targetname");

  ASSERTEX(isDefined(charge), "Charge trigger should be pointing to a sachel charge");
  ASSERTEX(isDefined(charge.script_noteworthy), "Charge should have a swap model specified as script_noteworthy");

  charge_trig waittill("trigger", user);

  charge setModel("weapon_usa_explosive_russian");
  charge playSound("satchel_plant");
  charge playLoopSound("satchel_timer");

  charge_trig delete();

  wait(5);

  charge stoploopsound();
  charge delete();

  maps\_utility::arcademode_assignpoints("arcademode_score_generic250", user);

  level notify("flak destroyed");
  self notify("death");
}
remove_satchel_on_death(charge_trig) {
  self waittill("death");

  if(isDefined(charge_trig)) {
    charge = getent(charge_trig.target, "targetname");

    charge_trig delete();

    if(isDefined(charge)) {
      charge delete();
    }
  }
}
hold_fire() {
  self endon("death");

  self.ignoreall = true;
  self.pacifist = 1;

  self waittill("open_fire");
  self.ignoreall = false;
  self.pacifist = 0;
}

resume_fire() {
  self.pacifist = 0;
  self.ignoreall = 0;
}
simple_floodspawn(spawn_func) {
  self waittill("trigger");

  spawners = getEntArray(self.target, "targetname");

  if(spawners.size == 0) {
    return undefined;
  }

  if(isDefined(spawn_func)) {
    for(i = 0; i < spawners.size; i++) {
      spawners[i] add_spawn_function(spawn_func);
    }
  }

  for(i = 0; i < spawners.size; i++) {
    while(!OkTospawn()) {
      wait_network_frame();
    }

    if(isDefined(spawners[i])) {
      spawners[i] thread maps\_spawner::flood_spawner_think();
    }

    wait_network_frame();
  }
}
simple_spawn(spawn_func) {
  self waittill("trigger");

  spawners = getEntArray(self.target, "targetname");

  if(spawners.size == 0) {
    return undefined;
  }

  if(isDefined(spawn_func)) {
    for(i = 0; i < spawners.size; i++) {
      spawners[i] add_spawn_function(spawn_func);
    }
  }

  ai_array = [];

  for(i = 0; i < spawners.size; i++) {
    while(!OkTospawn()) {
      wait_network_frame();
    }

    if(isDefined(spawners[i].script_forcespawn)) {
      ai = spawners[i] Stalingradspawn();
    } else {
      ai = spawners[i] Dospawn();
    }

    spawn_failed(ai);

    ai_array = add_to_array(ai_array, ai);

    wait_network_frame();
  }

  return ai_array;
}
simple_spawners_level_init() {
  flood_spawner_trigs = getEntArray("ber3_flood_spawner", "targetname");
  spawner_trigs = getEntArray("ber3_spawner", "targetname");

  for(i = 0; i < flood_spawner_trigs.size; i++) {
    flood_spawner_trigs[i] thread simple_floodspawn();
  }

  for(i = 0; i < spawner_trigs.size; i++) {
    spawner_trigs[i] thread simple_spawn();
  }
}
ambient_fakefire(endonString, delayStart, endonTrig) {
  if(delayStart) {
    wait(RandomFloatRange(0.25, 3.5));
  }

  if(isDefined(endonString)) {
    level endon(endonString);
  }

  if(isDefined(endonTrig)) {
    endonTrig endon("trigger");
  }

  team = undefined;
  fireSound = undefined;
  weapType = "rifle";

  if(!isDefined(self.script_noteworthy)) {
    team = "axis_mg";
  } else {
    team = self.script_noteworthy;
  }

  switch (team) {
    case "axis_mg":
      fireSound = "weap_type92_fire";
      weapType = "mg";
      break;

    default:
      ASSERTMSG("ambient_fakefire: team name '" + team + "' is not recognized.");
  }

  muzzleFlash = level._effect["distant_muzzleflash"];
  fake_tracer = level._effect["reich_tracer"];
  soundChance = 45;

  burstMin = 10;
  burstMax = 20;
  betweenShotsMin = 0.048;
  betweenShotsMax = 0.049;
  reloadTimeMin = 0.3;
  reloadTimeMax = 3.0;

  burst_area = (1250, 8250, 1000);

  traceDist = 10000;
  orig_target = self.origin + vector_multiply(anglesToForward(self.angles), traceDist);

  target_org = spawn("script_origin", orig_target);

  println("org" + target_org.origin);
  println("BA" + burst_area);

  while(1) {
    burst = RandomIntRange(burstMin, burstMax);

    targ_point = ((orig_target[0]) - (burst_area[0] / 2) + randomfloat(burst_area[0]), (orig_target[1]) - (burst_area[1] / 2) + randomfloat(burst_area[1]), (orig_target[2]) - (burst_area[2] / 2) + randomfloat(burst_area[2]));

    target_org moveto(targ_point, randomfloatrange(0.5, 6.0));

    for(i = 0; i < burst; i++) {
      target = target_org.origin;

      fx_angles = VectorNormalize(target - self.origin);
      playFX(muzzleFlash, self.origin, fx_angles);

      if(i % 4 == 0) {
        playFX(fake_tracer, self.origin, fx_angles);
      }

      wait(RandomFloatRange(betweenShotsMin, betweenShotsMax));
    }

    wait(RandomFloatRange(reloadTimeMin, reloadTimeMax));
  }
}

rumble_all_players(high_rumble_string, low_rumble_string, rumble_org, high_rumble_range, low_rumble_range) {
  players = get_players();

  for(i = 0; i < players.size; i++) {
    if(isDefined(high_rumble_range) && isDefined(low_rumble_range) && isDefined(rumble_org)) {
      if(distance(players[i].origin, rumble_org) < high_rumble_range) {
        players[i] playrumbleonentity(high_rumble_string);
      } else if(distance(players[i].origin, rumble_org) < low_rumble_range) {
        players[i] playrumbleonentity(low_rumble_string);
      }
    } else {
      players[i] playrumbleonentity(high_rumble_string);
    }
  }
}