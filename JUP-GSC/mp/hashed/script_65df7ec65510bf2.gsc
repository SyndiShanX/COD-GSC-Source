/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_65df7ec65510bf2.gsc
************************************************/

#using script_16ea1b94f0f381b3;
#using script_3b78d23dad7ec5be;
#using script_4a8c20678bd6a83e;
#using script_7edf952f8921aa6b;
#using script_9880b9dc28bc25e;
#using scripts\anim\shared;
#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\cap;
#using scripts\asm\shared\mp\utility;
#using scripts\common\ai;
#using scripts\common\cap;
#using scripts\common\debug;
#using scripts\common\devgui;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\agents\agent_utils;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\ai_behavior;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\player;
#using scripts\stealth\friendly;
#namespace namespace_bc50cc28d0217818;

function function_b21b3b439cfd8877() {
  level.ai_followers = [];
  level.var_71fd23ea9c43067e = [];
  level.var_d1f6a7b06a6a195c = [];
  level._effect["ava_teleport_out"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_teleportation_out.vfx");
  level._effect["ava_teleport_in"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_teleportation_spawn_in.vfx");
  level._effect["ava_cleanse_loop"] = loadfx("vfx/jup/ob/gameplay/riftrun/s5_5/story_mission/vfx_cleanse_ava_light_bomb.vfx");
  setdvarifuninitialized(@ "hash_e20f21c6b6c6bbc0", 1200);
  setdvarifuninitialized(@ "hash_78f245466a6f872a", 300);
  setdvarifuninitialized(@ "hash_16ea79a56a6a8d2b", 200);
  setdvarifuninitialized(@ "hash_f95d36af2068b554", 0);
  setdvarifuninitialized(@ "hash_53a9e906fd90b075", 10);
  setdvarifuninitialized(@ "hash_f83b4bb301618098", 1);

  setdevdvarifuninitialized(@ "hash_4d02ead68eeb1146", 0);
  setdevdvarifuninitialized(@ "hash_d7bebf9f14461660", 0);
  setdevdvarifuninitialized(@ "hash_856e10cf5b2862d1", 0);
  setdevdvarifuninitialized(@ "hash_9ce840e709d39b71", 0);
  level thread function_4e6a1f223393c32e();
}

function ravenov_spawn(var_aaba4f8d5fa7fcb9) {
  if(isDefined(var_aaba4f8d5fa7fcb9)) {
    var_2de6b144694b16ce = var_aaba4f8d5fa7fcb9;
  } else {
    var_2de6b144694b16ce = getStruct("ally_spawn_ravenov", "script_noteworthy");
  }

  if(!isDefined(var_2de6b144694b16ce)) {
    return undefined;
  }

  if(isDefined(level.var_1da22412ed7ad03b) && istrue(level.var_1da22412ed7ad03b.var_8f825bd739498693)) {
    level.var_1da22412ed7ad03b function_9f44d0edaa30d584();
    level.var_1da22412ed7ad03b = undefined;
    waitframe();
  } else {
    level.var_1da22412ed7ad03b = undefined;
  }

  ravenov = undefined;

  while(!isDefined(ravenov)) {
    ravenov = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_ally_ravenov_base", var_2de6b144694b16ce.origin, var_2de6b144694b16ce.angles);
    waitframe();
  }

  ravenov setoverridearchetype("animscript", "agent_mp_jup_ob_ravenov", 1);
  ravenov function_1a735ee97f484ff5("ravenov");
  level.var_1da22412ed7ad03b = ravenov;
  level.var_1da22412ed7ad03b.var_8f825bd739498693 = 1;
  flag_set("flag_ravenov_follower_spawned");
  return ravenov;
}

function ava_spawn(var_aaba4f8d5fa7fcb9) {
  if(isDefined(var_aaba4f8d5fa7fcb9)) {
    s_ava = var_aaba4f8d5fa7fcb9;
  } else {
    s_ava = getStruct("ally_spawn_ava", "script_noteworthy");
  }

  if(!isDefined(s_ava)) {
    return undefined;
  }

  if(isDefined(level.var_2ada333c838a2316) && istrue(level.var_2ada333c838a2316.var_9c7b54b172c87654)) {
    level.var_2ada333c838a2316 function_9f44d0edaa30d584();
    level.var_2ada333c838a2316 = undefined;
    waitframe();
  } else {
    level.var_2ada333c838a2316 = undefined;
  }

  ava = undefined;

  while(!isDefined(ava)) {
    ava = scripts\mp\mp_agent::spawnnewagentaitype("jup_ob_ally_ava_base", s_ava.origin, s_ava.angles);
    waitframe();
  }

  ava setoverridearchetype("animscript", "agent_mp_jup_ob_ava", 1);
  ava function_1a735ee97f484ff5("ava");
  ava val::set("ava_buddy", "ignoreme", 1);

  if(!ava ent_flag_exist("ent_flag_cleanse_cap_started")) {
    ava ent_flag_init("ent_flag_cleanse_cap_started");
  }

  if(!ava ent_flag_exist("ent_flag_cleanse_cap_enter_finished")) {
    ava ent_flag_init("ent_flag_cleanse_cap_enter_finished");
  }

  if(!ava ent_flag_exist("ent_flag_cleanse_cap_loop_done")) {
    ava ent_flag_init("ent_flag_cleanse_cap_loop_done");
  }

  if(!ava ent_flag_exist("ent_flag_cleanse_cap_exit_finished")) {
    ava ent_flag_init("ent_flag_cleanse_cap_exit_finished");
  }

  level.var_2ada333c838a2316 = ava;
  level.var_2ada333c838a2316.var_9c7b54b172c87654 = 1;
  flag_set("flag_ava_follower_spawned");
  return ava;
}

function function_cff9b0608bc49bfc() {
  self endon("death");
  flag_wait_all("ava_intro_complete", "rav_intro_complete");
  self.headicon = createheadicon(self);
  setheadiconimage(self.headicon, "ui_jup_hud_hacking_complete_border");
  setheadicondrawinmap(self.headicon, 1);
  setheadiconzoffset(self.headicon, 20);
  function_51044b10b2b673df(self.headicon, "icon_small");
}

function function_1a735ee97f484ff5(var_90a13a0855079abe) {
  self.rift_run = spawnStruct();
  self.animname = self.animsetname;
  self.var_90a13a0855079abe = var_90a13a0855079abe;
  aispeed = getdvarint(@ "hash_8072b5d9a8b538f8", 200);

  if(!isDefined(self.stealth)) {
    thread scripts\stealth\friendly::main();
    ent_flag_wait("stealth_enabled");
    self.stealth_enabled = 1;
  }

  if(isDefined(self.fnsetstealthstate)) {
    self[[self.fnsetstealthstate]]("combat");
    self aisetdesiredspeed(aispeed);
  }

  self function_e99626add202fe1a(1);
  scripts\common\utility::set_battlechatter(1);
  self.battlechatter.stateoverride = "combat";
  self.var_5323a94889eff1de = 1;
  self.var_3056d8c9bd11f1f2 = 1;
  self.var_cbd87a0bc497b778 = 1;
  self.var_69b049cf4b18c73b = 1;
  self.var_9f009877c3bea958 = 1;
  self.dontgrenademe = 1;
  self.dontmeleeme = 1;
  self.var_d8a098b0872bb2cb = 1;
  self.aggressivemode = 1;
  self.baseaccuracy = 1.75;
  self.var_4268b42fc89d0be9 = 0.001;
  self.gameskillmisstimedistancefactoroverride = 4e-06;
  self.gameskillmisstimefrombehindoverride = 0.02;
  self.var_a32530404b862f7b = 1;
  self.disablereload = 1;
  self.dontsyncmelee = 1;
  self.var_fc8b605280dd80b0 = 1.2;
  self forcenetfieldhighlod(1);

  if(getdvarint(@ "hash_f83b4bb301618098")) {
    thread function_cff9b0608bc49bfc();
  }

  if(!threatbiasgroupexists("allies")) {
    createthreatbiasgroup("allies");
  }

  self setthreatbiasgroup("allies");
  setthreatbias("team_two_hundred", "allies", -2000);
  scripts\common\ai::magic_bullet_shield();
  self.health = 1000;
  self.var_c13146701c692a16 = undefined;
  ent_flag_init("waiting_on_state_change");

  if(isDefined(level.players[0])) {
    self.team = level.players[0].team;
  }

  thread function_4e540622337b5900();

  out_aliasname = "jup_ob_s5_teleport_out";
  in_aliasname = "jup_ob_s5_teleport_in";
  var_a0c021150798d387 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", out_aliasname);
  out_xanim = scripts\asm\asm::asm_getxanim("animscripted", var_a0c021150798d387);
  self.var_a0e0a070ddf27453 = getanimlength(out_xanim);
  var_41581ba4cfc62392 = scripts\asm\asm::asm_lookupanimfromalias("animscripted", in_aliasname);
  in_xanim = scripts\asm\asm::asm_getxanim("animscripted", var_41581ba4cfc62392);
  self.var_9dc2e12ad70fc632 = getanimlength(in_xanim);
  val::set(var_90a13a0855079abe + "_buddy", "ignoresuppression", 1);
  grenadeweaponhash = "jup_blackhole_bomb_ob";

  if(!isDefined(level.var_67b54180a55f70e1[grenadeweaponhash])) {
    level.var_67b54180a55f70e1[grenadeweaponhash] = makeweapon("jup_blackhole_bomb_ob");
  }

  self.grenadeweapon = level.var_67b54180a55f70e1[grenadeweaponhash];
  self.grenadeammo = 0;
  level.ai_followers = function_6d6af8144a5131f1(level.ai_followers, self);
}

function function_9f44d0edaa30d584() {
  self.nocorpse = 1;
  self.var_7e4b076a06c6df27 = 1;
  self.dropweapon = 0;

  if(istrue(self.magic_bullet_shield)) {
    scripts\common\ai::stop_magic_bullet_shield();
  }

  scripts\cp_mp\agents\agent_utils::function_7056963336f2bbec(1);
}

function function_c75b149451e69c1(req_state) {
  self notify("new_behavior_requested", req_state);
  self.var_f9cf5abd786ef489 = req_state;
  var_697da0da3a228bb7 = 0;

  if(isDefined(self.var_c13146701c692a16)) {
    if(self.var_c13146701c692a16 == 0) {} else if(self.var_c13146701c692a16 == 1) {} else if(self.var_c13146701c692a16 == 2 || self.var_c13146701c692a16 == 3) {
      if(ent_flag("waiting_on_state_change")) {
        self notify("cancel_behavior_change");
      }

      ent_flag_set("waiting_on_state_change");
      msg = waittill_any_return_2("cleanse_finished", "cancel_behavior_change");

      if(is_equal(msg, "cancel_behavior_change")) {
        var_697da0da3a228bb7 = 1;
      }

      waittillframeend();
    }
  }

  if(istrue(var_697da0da3a228bb7) || isDefined(req_state) && isDefined(self.var_f9cf5abd786ef489) && self.var_f9cf5abd786ef489 != req_state) {
    return false;
  }

  if(istrue(self.teleporting)) {
    timeout = self.var_9dc2e12ad70fc632 + self.var_a0e0a070ddf27453 + 0.5;
    ent_flag_set("waiting_on_state_change");
    msg = waittill_any_timeout_2(timeout, "follower_teleported", "cancel_behavior_change");

    if(is_equal(msg, "timeout")) {
      if(getdvarint(@ "hash_4d02ead68eeb1146")) {
        assertmsg("<dev string:x1c>");
      }

      scripts\asm\shared\mp\utility::animscripted_clear();
      self notify("spawn_end", "end");
      ent_flag_clear("follower_teleporting");
      self.teleporting = 0;
    } else if(is_equal(msg, "cancel_behavior_change")) {
      var_697da0da3a228bb7 = 1;
    }
  }

  if(istrue(var_697da0da3a228bb7) || isDefined(req_state) && isDefined(self.var_f9cf5abd786ef489) && self.var_f9cf5abd786ef489 != req_state) {
    return false;
  }

  if(ent_flag("waiting_on_state_change")) {
    ent_flag_clear("waiting_on_state_change");
  }

  self notify("new_behavior_set", req_state);
  function_383eed2b2dd31df3();
  val::set("cleanse_ignore", "ignoreall", 0);
  val::set("catchup_ignoreall", "ignoreall", 0);
  val::set(self.var_90a13a0855079abe + "_buddy", "ignoreall", 0);
  self function_9322f3cb1cd4111a();
  self.var_f9cf5abd786ef489 = undefined;
  self.var_c13146701c692a16 = undefined;
  return true;
}

function function_a69c5fbb27c17133(var_edd3b3116f7af2a1) {
  if(!isDefined(var_edd3b3116f7af2a1)) {
    var_edd3b3116f7af2a1 = 0;
  }

  return function_e9658b73a53783aa(var_edd3b3116f7af2a1);
}

function function_d6e4c5c74c55fe0(dest_origin, dest_angles, on_navmesh, var_2950ab8950f6485d) {
  if(!isDefined(on_navmesh)) {
    on_navmesh = 1;
  }

  if(!isDefined(var_2950ab8950f6485d)) {
    var_2950ab8950f6485d = 1;
  }

  level endon("game_ended");
  self endon("death");
  safeorigin = istrue(on_navmesh) ? getclosestpointonnavmesh(dest_origin, self) : dest_origin;
  success = 0;

  if(isDefined(safeorigin)) {
    follower_teleport(safeorigin, dest_angles);
    success = 1;
  }

  if(istrue(var_2950ab8950f6485d) && (!success || distancesquared(self.origin, safeorigin) > squared(768))) {
    self.origin = dest_origin;
  }

  return success;
}

function function_b6b46d9505a84f4(points, dist_override, volume) {
  if(!isarray(points)) {
    points = [points];
  }

  foreach(dest in points) {
    if(isDefined(volume)) {
      dest.vols = isarray(volume) ? volume : [volume];
    } else if(isDefined(dest.target)) {
      vols = getEntArray(dest.target, "targetname");
      var_1e1d1f49fb0632b5 = getnoentvolumearray(dest.target, "targetname");
      dest.vols = array_combine(vols, var_1e1d1f49fb0632b5);
    }

    if(isDefined(dist_override)) {
      dest.dist_override = dist_override;
    } else if(isDefined(dest.radius)) {
      dest.dist_override = dest.radius;
    }

    level.var_71fd23ea9c43067e = array_add(level.var_71fd23ea9c43067e, dest);
  }
}

function function_24d79fd9489d13bc(points) {
  if(!isarray(points)) {
    points = [points];
  }

  level.var_71fd23ea9c43067e = array_remove_array(level.var_71fd23ea9c43067e, points);
}

function function_e85bdef1c036b3a2(volumes) {
  if(!isarray(volumes)) {
    volumes = [volumes];
  }

  if(getdvarint(@ "hash_9ce840e709d39b71", 0)) {
    foreach(volume in volumes) {
      drawtrigger(volume, (1, 0, 0), 1, 999999);
    }
  }

  level.var_d1f6a7b06a6a195c = array_combine_unique(level.var_d1f6a7b06a6a195c, volumes);
}

function function_1d928d544041c1f7(volumes) {
  if(!isarray(volumes)) {
    volumes = [volumes];
  }

  level.var_d1f6a7b06a6a195c = array_remove_array(level.var_d1f6a7b06a6a195c, volumes);
}

function private function_e419e5a4ed9971b5() {}

function function_a4f2de37b22bd9f9(guard_location, strict, var_a2c18caefeb31362, variance, var_fec582974e88db3d) {
  success = function_c75b149451e69c1(1);

  if(!success) {
    return;
  }

  if(!isDefined(strict)) {
    strict = 0;
  }

  if(!isDefined(variance)) {
    variance = 10;
  }

  guard_pos = undefined;

  if(!isDefined(guard_location)) {
    guard_pos = self.origin;
  } else if(isstruct(guard_location)) {
    if(isDefined(guard_location.origin)) {
      guard_pos = guard_location.origin;
    }

    if(isDefined(guard_location.radius) && !isDefined(var_a2c18caefeb31362)) {
      var_a2c18caefeb31362 = guard_location.radius;
    }
  } else if(isvector(guard_location)) {
    guard_pos = guard_location;
  } else if(isDefined(guard_location.origin)) {
    guard_pos = guard_location.origin;
  }

  if(!isDefined(var_a2c18caefeb31362)) {
    var_a2c18caefeb31362 = 25;
  }

  if(istrue(var_fec582974e88db3d) && distancesquared(self.origin, guard_pos) > squared(1200)) {
    success = function_d6e4c5c74c55fe0(guard_pos);
  }

  self notify("guard_start");
  self function_65cdab0fc78aba8f(guard_pos, 3000);
  self.var_c13146701c692a16 = 1;
  thread function_4c35bda0f32cd8a7(guard_pos, strict, var_a2c18caefeb31362, variance);
}

function function_4c35bda0f32cd8a7(guard_pos, strict, var_a2c18caefeb31362, variance) {
  self endon("death");
  self endon("new_behavior_requested");
  self endon("new_behavior_set");
  self setgoalpos(guard_pos, 16);

  if(distance2dsquared(guard_pos, self.origin) > squared(32)) {
    self waittill("goal");
  }

  if(!istrue(strict)) {
    function_e38f21e33b0ba200(guard_pos, var_a2c18caefeb31362, variance);
  }
}

function function_e38f21e33b0ba200(guard_pos, var_a2c18caefeb31362, variance) {
  self endon("death");
  self endon("new_behavior_requested");
  self endon("new_behavior_set");
  self notify("guardWander");
  self endon("guardWander");
  min = var_a2c18caefeb31362 - variance;
  max = var_a2c18caefeb31362 + variance;

  while(true) {
    random_x = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    random_y = randomfloatrange(min, max) * scripts\engine\utility::ter_op(randomint(100) > 50, 1, -1);
    var_52101416fe063026 = (guard_pos[0] + random_x, guard_pos[1] + random_y, guard_pos[2]);

    if(distance2d(self.origin, var_52101416fe063026) > 20) {
      self setgoalpos(var_52101416fe063026, 8);
      thread function_9c5262d8e15697fa();
      waittill_any_2("goal", "refreshGoalPos");
    }

    wait randomfloatrange(7.5, 10.5);
  }

  self setgoalpos(guard_pos, 8);
}

function function_9c5262d8e15697fa(time) {
  self endon("goal");
  self endon("death");
  self endon("new_behavior_set");
  self endon("new_behavior_requested");
  self endon("guardWander");
  waittime = 5;

  if(isDefined(time)) {
    waittime = time;
  }

  wait waittime;
  self notify("refreshGoalPos");
}

function private function_55f6a1c4d4a6b5d1() {}

function function_df24f38b60071783(location_str, tele_dist, var_9cb1161b203daf49, end_flag, teleport_timeout) {
  success = function_c75b149451e69c1(2);

  if(!success) {
    return;
  }

  if(!isDefined(tele_dist)) {
    tele_dist = 256;
  }

  if(!isDefined(teleport_timeout)) {
    teleport_timeout = 5;
  }

  self.var_c13146701c692a16 = 2;
  cleanse_org = undefined;
  cleanse_ang = (0, 0, 0);

  if(!isDefined(location_str)) {
    cleanse_org = self.origin;
  } else if(isvector(location_str)) {
    cleanse_org = location_str;
  } else {
    cleanse_org = location_str.origin;
    cleanse_ang = location_str.angles;
  }

  if(isDefined(end_flag) && flag(end_flag)) {
    return;
  }

  var_9554c076d87d7d17 = anglesToForward(cleanse_ang);

  if(ent_flag("ent_flag_cleanse_cap_started")) {
    ent_flag_clear("ent_flag_cleanse_cap_started");
  }

  if(ent_flag("ent_flag_cleanse_cap_enter_finished")) {
    ent_flag_clear("ent_flag_cleanse_cap_enter_finished");
  }

  if(ent_flag("ent_flag_cleanse_cap_loop_done")) {
    ent_flag_clear("ent_flag_cleanse_cap_loop_done");
  }

  if(ent_flag("ent_flag_cleanse_cap_exit_finished")) {
    ent_flag_clear("ent_flag_cleanse_cap_exit_finished");
  }

  var_3633b6cdc644db83 = cleanse_org;
  look_at_ent = undefined;
  self notify("cleanse_start");
  val::set("cleanse_ignore", "ignoreall", 1);
  dist = distancesquared(cleanse_org, self.origin);
  ai_behavior::function_c6930ac29fe6ff53(8);
  self setgoalpos(cleanse_org, 8);
  var_3633b6cdc644db83 = cleanse_org + var_9554c076d87d7d17 * 64 + (0, 0, 64);
  self.var_b95239f29466ec7d = var_3633b6cdc644db83;
  self.forcenextpathfindimmediate = 1;
  self orientmode("face point", self.var_b95239f29466ec7d);
  abort = 0;
  tele = 0;

  if(tele_dist < 32 || dist >= squared(tele_dist)) {
    tele = 1;
  } else if(dist > 1024) {
    thread function_5c504279f87e227f(cleanse_org, cleanse_ang);
    msg = waittill_any_timeout_4(teleport_timeout, "anim_reach_complete", "anim_reach_aborted", "new_behavior_set", "new_behavior_requested");

    if(function_5b7e9a4c946f3a13(msg, ["timeout", "anim_reach_aborted"])) {
      tele = 1;
    } else if(function_5b7e9a4c946f3a13(msg, ["new_behavior_set", "new_behavior_requested"])) {
      abort = 1;
    }
  }

  if(abort || isDefined(end_flag) && flag(end_flag)) {
    val::set("cleanse_ignore", "ignoreall", 0);
    self setoverridearchetype("animscript", "agent_mp_jup_ob_ava", 1);

    if(self.var_c13146701c692a16 == 2) {
      self.var_c13146701c692a16 = undefined;
    }

    self notify("cleanse_finished");
    return;
  }

  if(tele) {
    teleport_location = cleanse_org + var_9554c076d87d7d17 * -32;
    function_d6e4c5c74c55fe0(teleport_location, cleanse_ang);
    self notify("cleanse_force_teleported");
    waitframe();
    waitframe();
  }

  self notify("cleanse_loc_reached");
  lockent = spawn("script_model", self gettagorigin("j_wrist_le"));
  lockent setModel("tag_origin");
  lockent linkTo(self, "j_wrist_le", (5, 0, -5), (0, 0, 0));
  thread function_78c9a316a9a714f3(lockent);

  if(self isinscriptedstate()) {
    if(getdvarint(@ "hash_4d02ead68eeb1146")) {
      iprintlnbold("<dev string:x83>");
    }

    scripts\asm\shared\mp\utility::animscripted_clear();
    waitframe();
  }

  thread scripts\common\cap::cap_start("jup_ob_relic_cleanse", "caps/outbreak/cap_ava_s5");
  ent_flag_wait("ent_flag_cleanse_cap_enter_finished");
  self notify("cleanse_start_ready");
  waitframe();
  function_2c0fe3e76c30595(var_9cb1161b203daf49, end_flag);
  thread function_2b49eeb75c9e6a4f(lockent);
  self.var_c13146701c692a16 = 3;
  ent_flag_set("ent_flag_cleanse_cap_loop_done");
  ent_flag_wait("ent_flag_cleanse_cap_exit_finished");
  self setoverridearchetype("animscript", "agent_mp_jup_ob_ava", 1);
  val::set("cleanse_ignore", "ignoreall", 0);

  if(self.var_c13146701c692a16 == 3) {
    self.var_c13146701c692a16 = undefined;
  }

  self notify("cleanse_finished");
}

function function_dc51232de9554c90(startorg, startangles) {
  self pushplayer(1);
  self.nododgemove = 1;
  self.doavoidanceblocking = 0;
  self.fixednodewason = self.fixednode;
  self.fixednode = 0;
  self.var_a4700673c6ef6c4 = self.cornercheckenabled;
  self.cornercheckenabled = 0;
  self.oldpathenemyfightdist = self.pathenemyfightdist;
  self.oldpathenemylookahead = self.pathenemylookahead;
  self.pathenemyfightdist = 0;
  self.pathenemylookahead = 128;

  if(!isDefined(self.scriptedarrivalent)) {
    self.old_disablearrivals = self.disablearrivals;
    self.disablearrivals = 1;
  } else {
    self.scriptedarrivalent.angles = startangles;
    self.scriptedarrivalent.origin = startorg;
  }

  self.oldgoalradius = self.goalradius;
  self.reach_goal_pos = undefined;
  self.reach_goal_pos = startorg;
  self.goalradius = 0;
  self.stopanimdistsq = squared(120);
}

function function_fe21cc6e65f85e7f() {
  self pushplayer(0);
  self.nododgemove = 0;
  self.doavoidanceblocking = 1;

  if(isDefined(self.fixednodewason)) {
    self.fixednode = self.fixednodewason;
  }

  if(isDefined(self.var_a4700673c6ef6c4)) {
    self.cornercheckenabled = self.var_a4700673c6ef6c4;
  }

  if(isDefined(self.oldpathenemyfightdist)) {
    self.pathenemyfightdist = self.oldpathenemyfightdist;
  }

  if(isDefined(self.oldpathenemylookahead)) {
    self.pathenemylookahead = self.oldpathenemylookahead;
  }

  if(isDefined(self.old_disablearrivals)) {
    self.disablearrivals = self.old_disablearrivals;
  }

  if(isDefined(self.oldgoalradius)) {
    self.goalradius = self.oldgoalradius;
  }

  if(isDefined(self.scriptedarrivalent)) {
    self.scriptedarrivalent delete();
  }

  self.stopanimdistsq = 0;
  self.fixednodewason = undefined;
  self.var_a4700673c6ef6c4 = undefined;
  self.scriptedarrivalent = undefined;
  self.oldgoalradius = undefined;
  self.old_disablearrivals = undefined;
  self.oldpathenemyfightdist = undefined;
  self.oldpathenemylookahead = undefined;
  self.var_a4700673c6ef6c4 = undefined;
  self.old_disablearrivals = undefined;
}

function function_5c504279f87e227f(startorg, startangles) {
  self endon("death");
  self notify("new_anim_reach");
  self endon("new_anim_reach");
  self endon("cleanse_force_teleported");
  self endon("cleanse_finished");
  function_dc51232de9554c90(startorg, startangles);
  points = [];
  var_d53ac287d9031788 = 50;
  var_76b92aaf2604bd71 = 2500;

  if((!isDefined(self.scriptedarrivalent) || !isDefined(self.scriptedarrivalent.type)) && distance2dsquared(startorg, self.origin) > var_76b92aaf2604bd71) {
    forward = anglesToForward(startangles);
    var_b88bb2e631bcc2b3 = startorg - forward * var_d53ac287d9031788;

    if(navisstraightlinereachable(startorg, var_b88bb2e631bcc2b3, self)) {
      points[points.size] = var_b88bb2e631bcc2b3;
    }
  }

  points[points.size] = startorg;
  self setgoalpos(points[0]);
  self waittill("goal");

  if(isDefined(self.var_b95239f29466ec7d)) {
    self orientmode("face point", self.var_b95239f29466ec7d);
  }

  self setgoalpos(points[points.size - 1]);
  msg = waittill_notify_or_timeout_return("goal", 5);
  function_fe21cc6e65f85e7f();

  if(is_equal(msg, "timeout")) {
    self notify("anim_reach_aborted");
    return;
  }

  self notify("reach_notify");
  self notify("anim_reach_complete");
}

function function_78c9a316a9a714f3(lockent) {
  wait 1;
  cleanse_fx = playFXOnTag(getfx("ava_cleanse_loop"), lockent, "tag_origin");
}

function function_2b49eeb75c9e6a4f(lockent) {
  wait 2;
  stopFXOnTag(getfx("ava_cleanse_loop"), lockent, "tag_origin");
  lockent delete();
}

function function_9edbc512aeed073f(asmname, statename, params) {
  if(isDefined(self.var_b95239f29466ec7d)) {
    self orientmode("face point", self.var_b95239f29466ec7d);
  }

  scripts\asm\cap::cap_init(asmname, statename, params);
  ent_flag_set("ent_flag_cleanse_cap_started");
}

function function_95e4400513ea51cc(asmname, statename, params) {
  ent_flag_set("ent_flag_cleanse_cap_enter_finished");
  scripts\asm\cap::cap_loopanim(asmname, statename, params);
}

function function_69de6a4f3628cd5e(asmname, statename, tostatename, params) {
  if(ent_flag("ent_flag_cleanse_cap_loop_done")) {
    return 1;
  }

  return 0;
}

function function_435b9abadb237961(asmname, statename, params) {
  scripts\asm\cap::cap_exit(asmname, statename, params);
  ent_flag_set("ent_flag_cleanse_cap_exit_finished");
}

function private function_2c0fe3e76c30595(var_9cb1161b203daf49, end_flag) {
  self endon("new_behavior_set");
  self endon("new_behavior_requested");

  if(isDefined(var_9cb1161b203daf49) && isDefined(end_flag)) {
    level endon(var_9cb1161b203daf49);
    flag_wait(end_flag);
    return;
  }

  if(isDefined(var_9cb1161b203daf49)) {
    level waittill(var_9cb1161b203daf49);
    return;
  }

  if(isDefined(end_flag)) {
    flag_wait(end_flag);
  }
}

function private function_a4c995add3b3612d() {}

function function_101b97bce06bef4() {
  success = function_c75b149451e69c1(0);

  if(!success) {
    return;
  }

  self.var_c13146701c692a16 = 0;
  self.var_93c47f074dc58a0b = 1;
  self.teleport_cooldown = getdvarint(@ "hash_53a9e906fd90b075", 10);
  self.var_3cdcc135bfd71914 = 20;
  self.follower_leader = function_d8135cbde5f2da03();
  self.teleport_allowed = 1;
  self.teleporting = 0;
  self setgoalpos(self.origin);
  thread function_9aa3008e7fbe849b();
  thread function_1d0414c10e226e6e();
  thread function_dc6f3ac4406ba3b2();
}

function private function_d8135cbde5f2da03() {
  aliveplayers = [];
  var_5e7be3a99a2fb3e8 = 0;
  squadleader = undefined;

  foreach(player in level.players) {
    if(isPlayer(player) && scripts\mp\utility\player::isreallyalive(player)) {
      aliveplayers[var_5e7be3a99a2fb3e8] = player;
    }

    var_5e7be3a99a2fb3e8++;
  }

  if(istrue(level.usesquadleader)) {
    foreach(player in aliveplayers) {
      if(isDefined(player.sessionsquadid)) {
        squadleader = scripts\cp_mp\utility\squad_utility::getsquadleader(player.team, player.sessionsquadid);

        if(isDefined(squadleader)) {
          break;
        }
      }
    }
  }

  if(isDefined(squadleader)) {
    var_8850d9f771525016 = squadleader;
  } else {
    var_8850d9f771525016 = random(aliveplayers);
  }

  return var_8850d9f771525016;
}

function private function_1d0414c10e226e6e() {
  level endon("game_ended");
  self endon("death");
  self endon("follower_stop_follow");
  self endon("new_behavior_set");
  wait 1;
  wait_time = 1;
  thread function_9ab7fa2dfa6daf0d();
  self function_85e7c2baf116abf8(self.follower_leader);
  self function_741a41cd8e7cacd0(256);
  var_ff72655c03e66a5b = squared(getdvarint(@ "hash_e20f21c6b6c6bbc0", 1200));
  tele_cooldown = getdvarint(@ "hash_53a9e906fd90b075", 10);
  var_66c9ee8c1db06e21 = squared(getdvarint(@ "hash_78f245466a6f872a", 300));
  var_59b05038888543f1 = squared(5000);

  while(isalive(self)) {
    if(!isDefined(self.follower_leader)) {
      self setgoalpos(self.origin, 4);
      wait 2;
      continue;
    }

    if(istrue(self.follower_leader.var_68b9486f4adbcb62)) {
      function_85db367a92c42f23();
      waitframe();
      continue;
    }

    if(self isinscriptedstate()) {
      wait 1;
      continue;
    }

    var_38aa31573fab99b5 = distancesquared(self.follower_leader.origin, self.origin);

    if(istrue(self.teleport_allowed) && !istrue(self.follower_leader.inlaststand) && self.teleport_cooldown >= tele_cooldown && var_38aa31573fab99b5 >= var_ff72655c03e66a5b) {
      if(self.follower_leader isparachuting() || !self.follower_leader isonground()) {
        waitframe();
        continue;
      }

      success = function_e9658b73a53783aa();

      if(success) {
        continue;
      } else {
        wait 1;
        continue;
      }
    }

    if(var_38aa31573fab99b5 > var_66c9ee8c1db06e21) {
      if(var_38aa31573fab99b5 > var_59b05038888543f1) {
        wait 1;
        continue;
      }

      function_f02d595592be2688(self.follower_leader);
    }

    wait 1;
  }
}

function private function_9ab7fa2dfa6daf0d() {
  self notify("stay_near_target");
  self endon("stay_near_target");
  self endon("new_behavior_set");
  self endon("new_behavior_requested");
  self endon("game_ended");
  val::set("catchup_ignoreall", "ignoreall", 0);
  self.var_a0bbdca278732f45 = 0;

  while(true) {
    if(getdvarint(@ "hash_f95d36af2068b554", 0)) {
      if(isDefined(self.follower_leader)) {
        distsq = distancesquared(self.follower_leader.origin, self.origin);

        if(distsq > 360000 && !istrue(self.var_a0bbdca278732f45)) {
          self.dontmelee = 1;
          self.var_a0bbdca278732f45 = 1;
        } else if(istrue(self.var_a0bbdca278732f45) && distsq <= 90000) {
          self.dontmelee = 0;
          self.var_a0bbdca278732f45 = 0;
        }
      } else if(istrue(self.var_a0bbdca278732f45)) {
        self.dontmelee = 0;
        self.var_a0bbdca278732f45 = 0;
      }
    } else if(istrue(self.var_a0bbdca278732f45)) {
      val::set("catchup_ignoreall", "ignoreall", 0);
      self.dontmelee = 0;
      self.var_a0bbdca278732f45 = 0;
    }

    wait 0.3;
  }
}

function private function_f02d595592be2688(player) {
  level endon("game_ended");
  self endon("death");
  self endon("follower_stop_follow");
  self endon("new_behavior_set");

  if(!isPlayer(player)) {
    return false;
  }

  if(istrue(player.var_68b9486f4adbcb62)) {
    return false;
  }

  if(self isinscriptedstate()) {
    return false;
  }

  safeorigin = undefined;
  failcount = 0;
  self clearbtgoal(2);
  var_f9f96ee79aa6f5fe = getdvarint(@ "hash_16ea79a56a6a8d2b", 200);
  var_83c53a630f2c9423 = squared(var_f9f96ee79aa6f5fe);
  var_10f7a09e5689bf68 = squared(getdvarint(@ "hash_e20f21c6b6c6bbc0", 1200));
  tele_cooldown = getdvarint(@ "hash_53a9e906fd90b075", 10);
  ai_behavior::function_c6930ac29fe6ff53(var_f9f96ee79aa6f5fe);
  self.var_f79f774d8b98ab5 = self._blackboard.movetype;
  function_f1e5805da192a1ef("run", "turned", 25);
  safeorigin = function_571bf9f6769577e0(player);

  if(isDefined(safeorigin)) {
    function_7d323596701836e(safeorigin);
    var_95b51daa0fb10c76 = player.origin;
    reached_goal = 0;
    waitframe();

    while(true) {
      if(!isDefined(self)) {
        return false;
      }

      if(istrue(player.var_68b9486f4adbcb62)) {
        function_383eed2b2dd31df3();
        return false;
      }

      if(!isalive(player) || istrue(player.inlaststand)) {
        function_383eed2b2dd31df3();
        return false;
      }

      if(!isDefined(self.goalpos) || self function_1fde453596ea559c() > 2000) {
        function_383eed2b2dd31df3();
        return false;
      }

      var_3486e799824b565f = self isinscriptedstate();

      if(!var_3486e799824b565f && isDefined(self.goalpos) && distancesquared(self.goalpos, safeorigin) > 1024) {
        failcount++;

        if(failcount >= 5) {
          new_safeorigin = function_571bf9f6769577e0(player);

          if(isDefined(new_safeorigin)) {
            safeorigin = new_safeorigin;
          }
        }

        function_7d323596701836e(safeorigin);
        waitframe();
        continue;
      }

      if(distancesquared(player.origin, var_95b51daa0fb10c76) > 2304 && distancesquared(player.origin, self.origin) < var_10f7a09e5689bf68) {
        safeorigin = function_571bf9f6769577e0(player);
        var_95b51daa0fb10c76 = player.origin;

        if(isDefined(safeorigin)) {
          function_7d323596701836e(safeorigin);
        }

        waitframe();
        continue;
      } else if(distancesquared(player.origin, self.origin) >= var_10f7a09e5689bf68 && self.teleport_cooldown >= tele_cooldown && istrue(self.teleport_allowed)) {
        if(player isparachuting() || !player isonground() || var_3486e799824b565f) {
          waitframe();
          continue;
        }

        success = function_e9658b73a53783aa();
        function_383eed2b2dd31df3();

        if(success) {
          break;
        } else {
          wait 1;
          continue;
        }
      }

      if(distancesquared(self.goalpos, self.origin) < var_83c53a630f2c9423) {
        reached_goal = 1;
      }

      if(reached_goal && !var_3486e799824b565f) {
        function_383eed2b2dd31df3();
        break;
      }

      waitframe();
    }
  }

  self notify("follower_player_reached");
  return true;
}

function private function_7d323596701836e(goalpos) {
  self setgoalpos(goalpos, getdvarint(@ "hash_16ea79a56a6a8d2b", 200));
}

function private function_383eed2b2dd31df3() {
  if(isDefined(self.goalpos) && distance2dsquared(self.goalpos, self.origin) >= squared(256)) {
    self setgoalpos(self.origin, 4);
  }
}

function private function_571bf9f6769577e0(player, var_6f7c8a746930e7b) {
  if(!isDefined(var_6f7c8a746930e7b)) {
    var_6f7c8a746930e7b = 0;
  }

  forward = self.origin - player.origin;
  forward = vectorNormalize(forward);
  targetorigin = player.origin + (forward[0], forward[1], 0) * getdvarint(@ "hash_16ea79a56a6a8d2b", 200);

  if(var_6f7c8a746930e7b) {
    safeorigin = getclosestpointonnavmesh(targetorigin, self);
  } else {
    safeorigin = self getclosestreachablepointonnavmesh(targetorigin);
  }

  safeorigin = getgroundposition(safeorigin, 15);

  if(getdvarint(@ "hash_4d02ead68eeb1146")) {
    debug::debug_sphere(safeorigin, 15, (1, 0.75, 0.75), 3);
  }

  return safeorigin;
}

function private function_dc6f3ac4406ba3b2() {
  level endon("game_ended");
  self endon("death");
  self endon("follower_stop_follow");
  self endon("new_behavior_set");
  self endon("new_behavior_requested");
  self.follower_leader endon("death_or_disconnect");
  self function_65cdab0fc78aba8f(self.follower_leader.origin, 700);
  player_last_pos = undefined;

  while(true) {
    if(isDefined(self.follower_leader)) {
      if(!isDefined(player_last_pos)) {
        player_last_pos = self.follower_leader.origin;
      } else if(distancesquared(player_last_pos, self.follower_leader.origin) >= 90000) {
        self function_65cdab0fc78aba8f(self.follower_leader.origin, 700);
        player_last_pos = self.follower_leader.origin;
      }
    }

    wait 1;
  }
}

function function_a98eebbfaba2311e(weapon, position, activeweapon) {
  if(isagent(self)) {
    if(is_equal(position, "none") && !istrue(self.var_c3839981de5e0932)) {
      self.stowed_weapon = self.weapon;
      self.weapon = nullweapon();
      self.var_c3839981de5e0932 = 1;
      return;
    } else if(is_equal(position, "right") && istrue(self.var_c3839981de5e0932)) {
      self.weapon = self.stowed_weapon;
      self.var_c3839981de5e0932 = undefined;
      return;
    }
  }

  scripts\anim\shared::placeweaponon(weapon, position, activeweapon);
}

function private function_85db367a92c42f23() {
  self endon("death");
  self endon("follower_stop_follow");
  self endon("new_behavior_set");
  self endon("new_behavior_requested");
  player = self.follower_leader;

  if(isalive(player)) {
    player endon("endon_enter_walkable_vehicle");
    player endon("death_or_disconnect");
  }

  if(isDefined(player.var_cac91eb6521df629) && isDefined(player.var_cac91eb6521df629.s_exfil)) {
    player.var_cac91eb6521df629.s_exfil waittill("exfil_complete_timeout");
    var_576f57af0204c38c = player.var_cac91eb6521df629;

    if(isDefined(var_576f57af0204c38c)) {
      forward_angles = anglesToForward(var_576f57af0204c38c.angles);
      backward_angles = invertangles(forward_angles);
      teleport_origin = backward_angles * 1200 + var_576f57af0204c38c.origin;
      function_d6e4c5c74c55fe0(teleport_origin);
      function_a55b3d6929d24cf7(self.origin, 2);
      player waittill_notify_or_timeout("exfil_fully_completed", 20);

      if(isalive(self)) {
        function_383eed2b2dd31df3();
        function_9f44d0edaa30d584();
      }
    }
  }
}

function private function_9aa3008e7fbe849b() {
  self endon("death");
  self endon("follower_stop_follow");
  self endon("new_behavior_set");
  self endon("new_behavior_requested");

  while(true) {
    if(isDefined(self.follower_leader) && isPlayer(self.follower_leader)) {
      msg = self.follower_leader waittill_any_return_no_endon_death_4("death", "disconnect", "remove_from_alive_count", "br_pass_squad_leader");
      self.follower_leader = function_d8135cbde5f2da03();

      if(isDefined(self.follower_leader) && isPlayer(self.follower_leader)) {
        self function_85e7c2baf116abf8(self.follower_leader);
      }
    }

    waitframe();
  }
}

function private function_a7e1a4da25f229fb() {}

function private function_e5a3f2c29fdaae31(var_edd3b3116f7af2a1) {
  if(!isDefined(var_edd3b3116f7af2a1)) {
    var_edd3b3116f7af2a1 = 0;
  }

  var_2dddc7551413a2f4 = self.follower_leader.origin;
  potential_dests = [];
  var_50490404815fe72c = undefined;
  var_783962ed4d483dab = [];
  nearby_zombies = [];
  var_28eaecce814122cf = 0;

  if(level.var_71fd23ea9c43067e.size > 0) {
    potential_dests = function_b9c091ea4a8178b8(var_2dddc7551413a2f4);
    var_3623418c36a696c1 = undefined;

    if(potential_dests.size > 0) {
      sorted_dests = sortbydistance(potential_dests, var_2dddc7551413a2f4);
      var_3623418c36a696c1 = random(potential_dests);
      var_50490404815fe72c = var_3623418c36a696c1.origin;
      var_7202e9cb93e139d8 = isDefined(var_3623418c36a696c1.angles) ? var_3623418c36a696c1.angles : self.angles;

      if(getdvarint(@ "hash_d7bebf9f14461660", 0) > 0) {
        debugaxis(var_50490404815fe72c, var_7202e9cb93e139d8, undefined, undefined, undefined, 100);
      }

      return [var_50490404815fe72c, var_7202e9cb93e139d8];
    }
  }

  safeorigin = getclosestpointonnavmesh(var_2dddc7551413a2f4, self);

  if(!isDefined(safeorigin)) {
    return undefined;
  }

  var_50490404815fe72c = safeorigin;

  if(false) {
    if(!isDefined(self.var_3cdcc135bfd71914) || isDefined(self.var_3cdcc135bfd71914) && self.var_3cdcc135bfd71914 >= 20) {
      var_783962ed4d483dab = function_ed30bbb46a90106b();
    }
  }

  if(getdvarint(@ "hash_d7bebf9f14461660", 0) == 2) {
    debug::debug_sphere(safeorigin, undefined, (0, 1, 0), 5);
  }

  if(distancesquared(self.follower_leader.origin, safeorigin) > 16384) {
    test_locs = [safeorigin];
  } else {
    leader_angles = self.follower_leader getplayerangles();
    leader_forward = anglesToForward(leader_angles);
    leader_right = anglestoright(leader_angles);
    leader_left = leader_right * -1;
    leader_back = leader_forward * -1;

    if(istrue(var_edd3b3116f7af2a1)) {
      test_locs = [safeorigin + leader_forward * 196];
    } else if(var_28eaecce814122cf) {
      test_locs = [safeorigin + (0.25 * leader_left + leader_forward) * randomfloatrange(0.75, 1) * 196, safeorigin + (0.25 * leader_left + leader_forward) * randomfloatrange(1.25, 1.75) * 196, safeorigin + leader_forward * randomfloatrange(1.5, 2.5) * 196, safeorigin + (0.25 * leader_right + leader_forward) * randomfloatrange(0.75, 1) * 196, safeorigin + (0.25 * leader_right + leader_forward) * randomfloatrange(1.25, 1.75) * 196];
    } else {
      test_locs = [safeorigin + (0.5 * leader_left + leader_forward) * randomfloatrange(0.75, 1) * 196, safeorigin + (0.5 * leader_left + leader_forward) * randomfloatrange(0.25, 0.75) * 196, safeorigin + leader_forward * randomfloatrange(1.5, 2.5) * 196, safeorigin + (0.5 * leader_right + leader_forward) * randomfloatrange(0.75, 1) * 196, safeorigin + (0.5 * leader_right + leader_forward) * randomfloatrange(0.25, 0.75) * 196, safeorigin + leader_left * randomfloatrange(0.25, 1) * 196, safeorigin + leader_right * randomfloatrange(0.25, 1) * 196, safeorigin + (0.5 * leader_left + leader_back) * randomfloatrange(0.75, 1) * 196, safeorigin + leader_back * randomfloatrange(0.25, 0.5) * 196, safeorigin + (0.5 * leader_right + leader_back) * randomfloatrange(0.75, 1) * 196];
    }
  }

  foreach(loc in test_locs) {
    var_2d0d7fc92ca6c8e9 = getclosestpointonnavmesh(loc, self, undefined, 1);

    if(isDefined(var_2d0d7fc92ca6c8e9)) {
      clear = 1;
      valid = 1;
      trace = undefined;
      var_d1373acd42443e37 = getgroundposition(var_2d0d7fc92ca6c8e9, 18);

      foreach(follower in level.ai_followers) {
        if(follower == self) {
          continue;
        }

        if(isDefined(follower.teleport_dest) && distance2dsquared(follower.teleport_dest, var_2d0d7fc92ca6c8e9) < squared(32)) {
          valid = 0;
          break;
        }
      }

      if(!valid) {
        continue;
      }

      if(isDefined(level.var_a48e67061c191a79)) {
        foreach(pad in level.var_a48e67061c191a79) {
          if(isDefined(pad.origin)) {
            dist = distance2dsquared(pad.origin, var_2d0d7fc92ca6c8e9);
            safe_radius = 128;

            if(isDefined(pad.radius) && pad.radius > safe_radius) {
              safe_radius = pad.radius;
            }

            if(dist < squared(safe_radius)) {
              valid = 0;
              break;
            }

            if(isDefined(pad.struct) && ispointinvolume(var_2d0d7fc92ca6c8e9, pad.trigger)) {
              valid = 0;
              break;
            }
          }
        }
      }

      if(!valid) {
        continue;
      }

      if(level.var_d1f6a7b06a6a195c.size > 0) {
        foreach(vol in level.var_d1f6a7b06a6a195c) {
          if(ispointinvolume(var_2d0d7fc92ca6c8e9, vol)) {
            valid = 0;
            break;
          }
        }
      }

      if(!valid) {
        continue;
      }

      if(getdvarint(@ "hash_d7bebf9f14461660", 0) == 2) {
        trace = scripts\engine\trace::ai_trace(var_d1373acd42443e37, var_2d0d7fc92ca6c8e9 + (0, 0, 32), undefined, [self, self.follower_leader]);
      }

      clear = scripts\engine\trace::ai_trace_passed(var_d1373acd42443e37, var_2d0d7fc92ca6c8e9 + (0, 0, 32), undefined, [self, self.follower_leader]);

      if(istrue(clear)) {
        potential_dests = array_add(potential_dests, var_d1373acd42443e37);
      }

      if(getdvarint(@ "hash_d7bebf9f14461660", 0) == 2) {
        color = istrue(clear) ? (0, 1, 0) : (1, 0, 0);
        debug::debug_sphere(var_d1373acd42443e37, undefined, color, 5);

        if(isDefined(trace)) {
          level thread scripts\engine\trace::draw_trace(trace, color, undefined, 100);
        }
      }

    }
  }

  if(0 && var_783962ed4d483dab.size > 0) {
    var_50490404815fe72c = random(var_783962ed4d483dab);
  } else if(potential_dests.size > 0) {
    var_50490404815fe72c = random(potential_dests);
  } else {
    if(getdvarint(@ "hash_d7bebf9f14461660", 0) > 0) {
      iprintlnbold("<dev string:xd4>");
    }

    return [];
  }

  if(getdvarint(@ "hash_d7bebf9f14461660", 0) > 0 && isDefined(var_50490404815fe72c)) {
    debugaxis(isai(var_50490404815fe72c) ? var_50490404815fe72c.origin : var_50490404815fe72c, self.angles, undefined, undefined, undefined, 100);
  }

  return [var_50490404815fe72c, self.angles];
}

function private function_ed30bbb46a90106b() {
  var_783962ed4d483dab = [];
  nearby_zombies = getaiarrayinradius(self.follower_leader.origin, 196);

  foreach(zombie in nearby_zombies) {
    valid = 1;

    if(isDefined(zombie.team) && zombie.team == self.team) {
      continue;
    }

    if(!isalive(zombie)) {
      continue;
    }

    if(zombie namespace_49a23839f1dcc76a::is_traversing()) {
      continue;
    }

    if(isDefined(zombie.subclass) && zombie.subclass != "zombie_base" && zombie.subclass != "zombie_base_armored_light" && zombie.subclass != "zombie_base_armored_heavy") {
      continue;
    }

    foreach(follower in level.ai_followers) {
      if(follower == self) {
        continue;
      }

      if(isDefined(follower.var_e94fca72a2789b21) && follower.var_e94fca72a2789b21 == zombie) {
        valid = 0;
      }
    }

    if(!valid) {
      continue;
    }

    var_783962ed4d483dab = array_add(var_783962ed4d483dab, zombie);
  }

  return var_783962ed4d483dab;
}

function private function_b9c091ea4a8178b8(var_2dddc7551413a2f4) {
  potential_dests = [];

  foreach(pnt in level.var_71fd23ea9c43067e) {
    valid = 0;

    if(isDefined(pnt.vols)) {
      foreach(vol in pnt.vols) {
        if(ispointinvolume(var_2dddc7551413a2f4 + (0, 0, 10), vol)) {
          valid = 1;
        }
      }
    } else {
      var_e9582e298d5b23c6 = isDefined(pnt.dist_override) ? pnt.dist_override : 512;

      if(distancesquared(var_2dddc7551413a2f4, pnt.origin) <= squared(var_e9582e298d5b23c6)) {
        valid = 1;
      }
    }

    if(getdvarint(@ "hash_d7bebf9f14461660", 0) > 0) {
      color = istrue(valid) ? (0, 1, 0) : (1, 0, 0);
      orientedbox(pnt.origin, (8, 8, 8), (0, 0, 0), color, undefined, 500);
    }

    if(istrue(valid)) {
      potential_dests = function_6d6af8144a5131f1(potential_dests, pnt);
    }
  }

  return potential_dests;
}

function private function_e9658b73a53783aa(var_edd3b3116f7af2a1) {
  level endon("game_ended");
  self endon("death");
  [var_79645149e1c263d0, teleport_ang] = function_e5a3f2c29fdaae31(var_edd3b3116f7af2a1);

  if(isDefined(var_79645149e1c263d0)) {
    follower_teleport(var_79645149e1c263d0, teleport_ang);
    self notify("follower_teleport_finish", 1);
    return 1;
  }

  self notify("follower_teleport_finish", 0);
  return 0;
}

function private follower_teleport(dest, dest_angles) {
  level endon("game_ended");
  self endon("death");
  var_42a5a182b3e44ccb = isai(dest);
  dest_ent = undefined;
  var_6f33443052eec825 = 0;

  if(var_42a5a182b3e44ccb) {
    dest_ent = dest;
    dest = dest_ent.origin;
  }

  while(istrue(self.teleporting)) {
    waitframe();
  }

  if(istrue(self.var_9c7b54b172c87654) && isDefined(self.animsetname) && self.animsetname != "agent_mp_jup_ob_ava") {
    self setoverridearchetype("animscript", "agent_mp_jup_ob_ava", 1);
  }

  self.teleporting = 1;
  self.teleport_dest = dest;
  self.var_e94fca72a2789b21 = dest_ent;
  var_de962f804d5fc980 = 0.3;
  thread function_57fad116d05589fc(self.origin, "jup_ob_s5_teleport_out", 0);
  wait self.var_a0e0a070ddf27453 - var_de962f804d5fc980;
  function_155681a503af0b02();
  wait var_de962f804d5fc980 - 0.1;
  function_5f191ad77b4c61a1(dest);
  wait 0.1;
  waitframe();
  waittillframeend();
  self forceteleport(dest, dest_angles, 9999999, 1);
  thread function_57fad116d05589fc(dest, "jup_ob_s5_teleport_in", 1, dest_angles);
  thread function_b989c788b85f3f90(dest_ent);
  wait self.var_9dc2e12ad70fc632;
  self notify("follower_teleported");
  self.teleport_cooldown = 0;
  thread function_aee7cedae949e77f();

  if(var_42a5a182b3e44ccb) {
    self notify("follower_exchanged");
    self.var_3cdcc135bfd71914 = 0;
    thread function_abd547aa14fc81a5();
  }

  self notify("follower_player_reached");
  self.teleporting = 0;
  self.teleport_dest = undefined;
  self.var_e94fca72a2789b21 = undefined;
}

function private function_57fad116d05589fc(dest, animstr, enable_gravity, dest_angles) {
  self endon("death");
  ent_flag_set("follower_teleporting");
  assertex(isalive(self), "<dev string:x10e>");

  if(!isalive(self)) {
    return;
  }

  statename = "animscripted";

  if(istrue(enable_gravity)) {
    self animmode("gravity");
  } else {
    self animmode("noclip");
  }

  if(isDefined(dest_angles)) {
    self orientmode("face angle", dest_angles[1]);
  } else {
    self orientmode("face angle", self.angles[1]);
  }

  scripts\asm\asm::asm_clearfacialanim();
  scripts\asm\asm_bb::bb_setanimScripted();
  self asmsetstate(self.asmname, statename);
  self scriptedanimstarted();
  animindex = scripts\asm\asm::asm_lookupanimfromalias(statename, animstr);
  xanim = scripts\asm\asm::asm_getxanim(statename, animindex);
  self dontinterpolate();
  self aisetanim(statename, animindex);
  animlength = getanimlength(xanim);
  wait animlength;
  scripts\asm\shared\mp\utility::animscripted_clear();
  self notify("spawn_end", "end");
  ent_flag_clear("follower_teleporting");
}

function private function_b989c788b85f3f90(dest_ent) {
  if(isDefined(dest_ent)) {
    dest_ent.marked_for_death = 1;
    dest_ent.nuked = 1;
    dest_ent.full_gib = 1;
    dest_ent.var_745cd904c1ec804c = 1;
    dest_ent kill();
  }

  nearby_zombies = getaiarrayinradius(self.origin, 128, "team_two_hundred");

  foreach(zombie in nearby_zombies) {
    if(isDefined(zombie.team) && zombie.team == self.team) {
      continue;
    }

    if(!isalive(zombie)) {
      continue;
    }

    if(is_equal(zombie, dest_ent)) {
      continue;
    }

    if(isDefined(zombie.subclass) && zombie.subclass != "zombie_base" && zombie.subclass != "zombie_base_armored_light" && zombie.subclass != "zombie_base_armored_heavy") {
      continue;
    }

    if(distancesquared(self.origin, zombie.origin) < 1024) {
      zombie.marked_for_death = 1;
      zombie.nuked = 1;
      zombie.full_gib = 1;
      zombie.var_745cd904c1ec804c = 1;
      zombie kill();
      continue;
    }

    zombie namespace_db1ce2c035564e2c::knockdown_ai(self.origin);
  }
}

function private function_aee7cedae949e77f() {
  level endon("game_ended");
  self endon("death");
  self endon("follower_teleported");
  self endon("new_behavior_set");
  self endon("new_behavior_requested");

  while(true) {
    if(self.teleport_cooldown >= getdvarint(@ "hash_53a9e906fd90b075", 10)) {
      break;
    }

    self.teleport_cooldown++;
    wait 1;
  }
}

function private function_abd547aa14fc81a5() {
  level endon("game_ended");
  self endon("death");
  self endon("follower_exchanged");
  self endon("new_behavior_set");
  self endon("new_behavior_requested");

  while(true) {
    if(self.var_3cdcc135bfd71914 >= 20) {
      break;
    }

    self.var_3cdcc135bfd71914++;
    wait 1;
  }
}

function function_5f191ad77b4c61a1(destination, no_offset) {
  if(!isDefined(destination)) {
    destination = self.origin + (0, 0, 20);
  } else if(!istrue(no_offset)) {
    destination += (0, 0, 20);
  }

  playFX(getfx("ava_teleport_in"), destination);
  playsoundatpos(destination, "evt_ob_story_jansen_teleport_in");
}

function function_155681a503af0b02(var_60e0cc4534c73607) {
  fwd_ang = anglesToForward(self.angles);
  back_ang = -1 * fwd_ang;
  fx_pos = self.origin + (0, 0, 56) + back_ang * 32;

  if(isDefined(var_60e0cc4534c73607)) {
    fx_pos = var_60e0cc4534c73607;
  }

  playFX(getfx("ava_teleport_out"), fx_pos);
  playsoundatpos(fx_pos, "evt_ob_story_jansen_teleport_out");
}

function private function_5ce519fe3007b95a(living_only, ignore_last_stand) {
  if(!isDefined(living_only)) {
    living_only = 1;
  }

  if(!isDefined(ignore_last_stand)) {
    ignore_last_stand = 1;
  }

  possibleplayers = [];

  foreach(player in level.players) {
    if(living_only && (!isalive(player) || isDefined(player.fauxdead) || istrue(player.delayedspawnedplayernotify))) {
      continue;
    }

    if(ignore_last_stand && istrue(player.inlaststand)) {
      continue;
    }

    possibleplayers[possibleplayers.size] = player;
  }

  testorigin = self.origin;

  if(possibleplayers.size == 0) {
    return undefined;
  }

  if(possibleplayers.size == 1) {
    return possibleplayers[0];
  }

  return sortbydistance(possibleplayers, testorigin)[0];
}

function rift_run_animscripted_oneshot(animstring, org, animangles) {
  level endon("game_ended");
  self notify("rift_run_animscripted_oneshot");
  self endon("rift_run_animscripted_oneshot");
  self endon("death");
  self endon("rift_run_animscripted_loop_end");

  if(isDefined(org)) {
    anim_node = spawnStruct();
    anim_node.origin = org;
    anim_node.angles = animangles;
    animscripted_single_relative(animstring, anim_node);
    return;
  }

  animscripted_single(animstring);
}

function rift_run_animscripted_loop(animstring, org, animangles) {
  level endon("game_ended");
  self notify("rift_run_animscripted_loop");
  self endon("rift_run_animscripted_loop");
  self endon("death");
  self endon("rift_run_animscripted_loop_end");

  if(isDefined(org)) {
    anim_node = spawnStruct();
    anim_node.origin = org;
    anim_node.angles = animangles;
    animscripted_loop_relative(animstring, anim_node);
  } else {
    animscripted_loop(animstring);
  }

  while(true) {
    waitframe();
  }
}

function rift_run_animscripted_loop_end(animstring) {
  level endon("game_ended");
  self endon("death");
  self notify("rift_run_animscripted_loop_end");
  animscripted_clear();
  waitframe();
}

function private function_b1eab7c7fda1fb57() {}

function private function_4e6a1f223393c32e() {
  scripts\common\devgui::function_6e7290c8ee4f558b("<dev string:x14a>");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x16c>", @ "hash_4d02ead68eeb1146");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x17c>", @ "hash_d7bebf9f14461660");
  scripts\common\devgui::function_b2159fbbd7ac094e("<dev string:x18e>", @ "hash_856e10cf5b2862d1");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x1a4>", "<dev string:x1c2>", &function_ac9dd578f628f3bb);
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x1dd>", "<dev string:x210>", &function_245a25d44896a0f3);
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x234>", @ "hash_53a9e906fd90b075");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x249>", @ "hash_16ea79a56a6a8d2b");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x258>", @ "hash_78f245466a6f872a");
  scripts\common\devgui::function_df648211d66cd3dd("<dev string:x26f>", @ "hash_e20f21c6b6c6bbc0");
  scripts\common\devgui::function_a9a864379a098ad6("<dev string:x280>", "<dev string:x28d>", &function_627e72114f122f34);
  scripts\common\devgui::function_fe953f000498048f();
}

function private function_627e72114f122f34() {
  if(isDefined(level.var_2ada333c838a2316)) {
    if(!isDefined(level.var_2ada333c838a2316.ignoreme)) {
      level.var_2ada333c838a2316.ignoreme = 1;
    } else {
      level.var_2ada333c838a2316.ignoreme = !level.var_2ada333c838a2316.ignoreme;
    }
  }

  if(isDefined(level.var_1da22412ed7ad03b)) {
    if(!isDefined(level.var_1da22412ed7ad03b.ignoreme)) {
      level.var_1da22412ed7ad03b.ignoreme = 1;
      return;
    }

    level.var_1da22412ed7ad03b.ignoreme = !level.var_1da22412ed7ad03b.ignoreme;
  }
}

function private function_acff8fd2b816986e() {
  if(!isDefined(self.var_c13146701c692a16)) {
    return "<dev string:x2a2>";
  }

  if(self.var_c13146701c692a16 == 2) {
    return "<dev string:x2af>";
  }

  if(self.var_c13146701c692a16 == 3) {
    return "<dev string:x2bc>";
  }

  if(self.var_c13146701c692a16 == 0) {
    return "<dev string:x2d1>";
  }

  if(self.var_c13146701c692a16 == 1) {
    return "<dev string:x2de>";
  }

  return "<dev string:x2ea>";
}

function private function_4e540622337b5900() {
  self endon("<dev string:x2fb>");
  outline_enabled = 0;
  debug_scale = 0.25;
  tele_cd = getdvarint(@ "hash_53a9e906fd90b075", 10);

  while(true) {
    if(getdvarint(@ "hash_4d02ead68eeb1146")) {
      print3d(self.origin + (0, 0, 96), "<dev string:x304>" + function_acff8fd2b816986e(), undefined, undefined, debug_scale);
      print3d(self.origin + (0, 0, 92), "<dev string:x30f>" + (isDefined(self.teleport_cooldown) ? tele_cd - self.teleport_cooldown : "<dev string:x322>"), undefined, undefined, debug_scale);
      print3d(self.origin + (0, 0, 88), "<dev string:x329>" + (istrue(self.var_a0bbdca278732f45) ? "<dev string:x338>" : "<dev string:x340>"), undefined, undefined, debug_scale);
      print3d(self.origin + (0, 0, 84), "<dev string:x349>" + (istrue(self isinscriptedstate()) ? "<dev string:x338>" : "<dev string:x340>"), undefined, undefined, debug_scale);
      print3d(self.origin + (0, 0, 80), "<dev string:x35d>" + (istrue(self.ignoreall) ? "<dev string:x338>" : "<dev string:x340>"), istrue(self.ignoreall) ? (1, 0, 0) : (0, 1, 0), undefined, debug_scale);
      print3d(self.origin + (0, 0, 76), "<dev string:x36d>" + (istrue(self.ignoreme) ? "<dev string:x338>" : "<dev string:x340>"), istrue(self.ignoreme) ? (1, 0, 0) : (0, 1, 0), undefined, debug_scale);
    }

    if(getdvarint(@ "hash_856e10cf5b2862d1") || getdvarint(@ "hash_4d02ead68eeb1146")) {
      if(!outline_enabled) {
        self hudoutlineenable("<dev string:x37c>");
        outline_enabled = 1;
      }
    } else if(outline_enabled) {
      self hudoutlinedisable();
      outline_enabled = 0;
    }

    waitframe();
  }
}

function private function_ac9dd578f628f3bb() {
  if(isDefined(level.var_2ada333c838a2316) && !istrue(level.var_2ada333c838a2316.teleporting)) {
    level.var_2ada333c838a2316 thread function_a69c5fbb27c17133();
  }

  if(isDefined(level.var_1da22412ed7ad03b) && !istrue(level.var_1da22412ed7ad03b.teleporting)) {
    level.var_1da22412ed7ad03b thread function_a69c5fbb27c17133();
  }
}

function private function_245a25d44896a0f3() {
  if(isDefined(level.var_2ada333c838a2316) && !istrue(level.var_2ada333c838a2316.teleporting)) {
    level.var_2ada333c838a2316 thread function_a69c5fbb27c17133(1);
  }
}

# /