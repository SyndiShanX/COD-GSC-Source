/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_3d91fbc054526de1.gsc
*************************************************/

#using script_4e6e58ab5d96c2b0;
#using scripts\common\callbacks;
#using scripts\common\devgui;
#using scripts\common\scene;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\utility\audio_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\squad_utility;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\anim;
#using scripts\mp\flags;
#using scripts\mp\gamelogic;
#using scripts\mp\playerlogic;
#using scripts\mp\spawnlogic;
#using scripts\mp\utility\outline;
#using scripts\mp\utility\perk;
#using scripts\mp\utility\player;
#using scripts\mp\utility\stats;
#using scripts\mp\utility\teams;
#namespace namespace_e47f1f0e697a80a;

function function_e85a33353200a325() {
  level thread function_fff3d0f8a5f042ad();

  setomnvar("ui_mp_extended_load_screen", 1);
  mapname = scripts\cp_mp\utility\game_utility::getmapname();

  if(mapname != "mp_jup_bigmap") {
    setDvar(@ "hash_2fe0283b419ff08a", 1);
  }

  level.var_eb7998aaa13bd57 = getdvarint(@ "hash_33dc02542068fcd7", 0);

  if(getdvarint(@ "hash_2fe0283b419ff08a", 0) == 1 || !isinfiltransientloaded("mp_infil_ob_jup_blima_tr")) {
    if(issharedfuncdefined("obInfil", "customInfilSkipFlow")) {
      level thread[[getsharedfunc("obInfil", "customInfilSkipFlow")]]();
      return;
    }

    level.prematchperiodend = level.var_eb7998aaa13bd57;
    level thread function_6abfc74b7f83b7f8();
    return;
  }

  callback::add("player_connect", &on_connect);
  scene::add_scene_func("jup_cin_zm_infil", &function_76e1657e2f2df35c, "callback_play");
  scene::add_scene_func("jup_cin_zm_infil", &function_7db747abca8e8f0e, "callback_done");
  level.var_cd516359c1840501 = getdvarint(@ "hash_5cc93a1ff8e7a881", 1);
  level.var_ee961c9258701907 = getdvarint(@ "hash_d6c6f27e2890ab87", 3);
  level.var_9b36be4fbd603ba7 = getdvarfloat(@ "hash_39ea6191970eb227", 30);
  level.var_40a9c107e8fda0b6 = getdvarint(@ "hash_4a2b6a2a09fd036", 0);
  level.var_598d90c6bc821de7 = getdvarfloat(@ "hash_d0703186b655c867", 5);
  level.var_e2efffa7ec8ffced = getdvarint(@ "hash_81a3a2e9c63e736d", 0);
  level.var_e6e8b7b242097949 = [];
  level.var_4df4777277c281ff = 1;
  level.var_fd915e8bd20b6d09 = &function_93e3fe0e5693889b;

  foreach(team in level.teamnamelist) {
    level.requiredplayercount[team] = 0;
  }

  level.prematchperiod = getdvarint(@ "hash_c653d32c30815d2b", 60);
  infilduration = 15.0333;
  level.matchcountdowntime = infilduration + level.var_eb7998aaa13bd57 + getdvarint(@ "hash_7061556e5a6fcbc7", 1);
  level.prematchperiodend = infilduration + level.var_eb7998aaa13bd57 + getdvarint(@ "hash_7061556e5a6fcbc7", 1);
  thread scripts\mp\gamelogic::matchstarttimer("match_starting_in", level.prematchperiod + level.prematchperiodend);
  snd_transient_load("blima_infil");
  level.var_6bec823e343dacea = 1;
  level thread function_475b703f6d063a37();
}

function function_6abfc74b7f83b7f8() {
  level waittill_any_2("match_start_real_countdown", "match_start_timer_skip");
  level thread function_9f45e0d90ddd909d();

  foreach(teamname, squadarray in level.squaddata) {
    foreach(squad in squadarray) {
      if(squad.players.size > 0) {
        if(isDefined(squad.players[0].var_87a91b2a8231f4f8)) {
          spawnpoint = squad.players[0].var_87a91b2a8231f4f8;
        } else if(isDefined(level.var_796ae5bb031f323d)) {
          spawnpoint = squad.players[0][[level.var_796ae5bb031f323d]]();
        } else {
          spawnpoint = level.teamdata[teamname]["startPoint"];
        }

        level thread function_f8e774228da7fd80(spawnpoint, teamname);

        foreach(player in squad.players) {
          if(!isDefined(player)) {
            continue;
          }

          player val::reset_all("ob_infil");
          player playershow(1);
        }
      }
    }
  }
}

function on_connect(params) {
  if(!level flag("ob_infil_completed")) {
    self endon("disconnect");
    self.var_f4bb3d8522246fdc = 1;
    val::set("ob_infil", "show_hud", 0);
    val::set("ob_infil", "freezecontrols", 1);
    scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 1, 0);
    level flag_wait("ob_infil_completed");
    wait 1;

    if(isDefined(self)) {
      self.var_f4bb3d8522246fdc = undefined;
      val::reset_all("ob_infil");
      self playershow(1);
      scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 0, 0);
      self setclientomnvar("ui_disable_inventory", 0);
    }
  }
}

function function_1433671d0a15b57b(playerwait, playerstring) {
  assert(isDefined(playerwait));
  level endon("prematch_done");
  level endon("prematch_over");

  if(isDefined(playerstring)) {
    self endon(playerstring);
  }

  self waittill(playerwait);
}

function function_93e3fe0e5693889b() {
  if(!isDefined(level.var_970834636e10db54)) {
    level.var_970834636e10db54 = gettime();
  }

  if(!isDefined(level.var_2feb1fee386da049)) {
    level.var_584594cfe5be79ab = gettime();
  } else {
    level.var_6cbb7e30776f280e = gettime();
  }

  streamcomplete = 0;
  lobbysize = function_425d34ddd114f3de();

  if(level.players.size < lobbysize) {
    level.var_970834636e10db54 = gettime();
    return 0;
  }

  var_f32326388fb1991c = level.var_970834636e10db54 + function_a5b14435e3229bed(level.var_9b36be4fbd603ba7);

  if(gettime() > var_f32326388fb1991c) {
    return 1;
  }

  if(gettime() - level.var_970834636e10db54 < function_a5b14435e3229bed(level.var_598d90c6bc821de7)) {
    return 0;
  }

  if(level.players.size > 0) {
    streamcomplete = 1;

    foreach(team in level.teamnamelist) {
      players = getteamdata(team, "players");

      foreach(player in players) {
        if(!istrue(player.pers["streamSyncComplete"]) || player.model == "" || !player ispredictedstreamposready() || !player isadditionalstreamposready()) {
          if(!istrue(player.pers["<dev string:x1c>"])) {
            if(!isDefined(player.var_acb3470fd92a831)) {
              player.var_acb3470fd92a831 = gettime();
            } else {
              player.var_690843a63d7f6150 = gettime();
            }
          }

          if(player.model == "<dev string:x32>") {
            if(!isDefined(player.var_e298a3ca3ed1a049)) {
              player.var_e298a3ca3ed1a049 = gettime();
            } else {
              player.var_f12e6635eb2fe3b8 = gettime();
            }
          }

          streamcomplete = 0;
          break;
        }
      }

      if(!streamcomplete) {
        break;
      }
    }
  }

  return streamcomplete;
}

function function_475b703f6d063a37() {
  scripts\mp\flags::gameflagset("infil_will_run");
  level waittill_any_2("match_start_real_countdown", "match_start_timer_skip");
  level thread function_9f45e0d90ddd909d();

  if(isDefined(level.var_2feb1fee386da049)) {
    println("<dev string:x36>" + level.var_2feb1fee386da049);
  }

  if(isDefined(level.var_6cbb7e30776f280e)) {
    println("<dev string:x66>" + level.var_6cbb7e30776f280e);
  }

  foreach(teamname, squadarray in level.squaddata) {
    foreach(squad in squadarray) {
      if(squad.players.size > 0) {
        level thread function_2796212b16ece5a4(teamname, squad.index);
        waitframe();
      }
    }
  }
}

function function_9f45e0d90ddd909d() {
  setomnvar("ui_mp_extended_load_screen", 0);

  if(getdvarint(@ "hash_2fe0283b419ff08a", 0)) {
    setomnvar("ui_in_infil", -1);
  } else {
    setomnvar("ui_in_infil", 1);
    level flag_wait_or_timeout("ob_infil_igc_start", level.prematchperiod);
    setomnvar("ui_in_infil", 2);
  }

  level notify("obInfil_countdownStart");
  scripts\mp\flags::gameflagwait("prematch_done");
  setomnvar("ui_in_infil", -1);
  level.infilcompleted = 1;
  level flag_set("ob_infil_completed");
  level delaythread(50, &snd_transient_unload, "blima_infil");
  callback::callback("on_ob_infil_complete");
}

#using_animtree("script_model");

function function_a6854cf05a485ced(pos, angles, var_3d69da7e79a7d44c) {
  camid = ter_op(isDefined(var_3d69da7e79a7d44c), var_3d69da7e79a7d44c, 0);
  cameraent = spawn("script_model", pos);

  if(isDefined(angles)) {
    cameraent.angles = angles;
  }

  cameraent setModel("tag_origin");
  cameraent.animname = "ob_infil_cam" + camid;
  cameraent useanimtree(#animtree);
  return cameraent;
}

function function_f8e774228da7fd80(spawnpoint, teamname, radius) {
  if(isvector(spawnpoint.origin)) {
    flag_wait("ai_spawn_director_initialized");
    var_d14e12c472ce3518 = teamname + "_Infil";
    exclusionradius = default_to(radius, 2000);
    function_606642b946a01237(var_d14e12c472ce3518, spawnpoint.origin, exclusionradius, 1);
    function_c7311cb3f768f21e(var_d14e12c472ce3518, 300);
  }
}

function function_2796212b16ece5a4(teamname, squadid, overridespawnpoint, overridewaittime) {
  if(!(isDefined(level.squaddata[teamname]) && isDefined(level.squaddata) && isDefined(squadid) && isDefined(teamname) && isDefined(level.squaddata[teamname][squadid]))) {
    return;
  }

  players = level.squaddata[teamname][squadid].players;

  if(isDefined(overridespawnpoint)) {
    spawnpoint = overridespawnpoint;
  } else if(isDefined(level.var_796ae5bb031f323d)) {
    var_c47fa8157a1a841e = [];

    foreach(player in players) {
      if(isDefined(player.var_87a91b2a8231f4f8)) {
        squad_spawn = player.var_87a91b2a8231f4f8;
      } else {
        squad_spawn = player[[level.var_796ae5bb031f323d]]();
      }

      var_c47fa8157a1a841e[var_c47fa8157a1a841e.size] = squad_spawn;
    }

    var_c4df5904366785de = var_c47fa8157a1a841e[0];

    foreach(squad_spawn in var_c47fa8157a1a841e) {
      if(squad_spawn.origin[2] > var_c4df5904366785de.origin[2]) {
        var_c4df5904366785de = squad_spawn;
      }
    }

    spawnpoint = var_c4df5904366785de;
  } else {
    spawnpoint = level.teamdata[teamname]["startPoint"];
  }

  level thread function_f8e774228da7fd80(spawnpoint, teamname);
  players = array_removeundefined(players);

  foreach(player in players) {
    if(isDefined(player.var_e298a3ca3ed1a049)) {
      println("<dev string:x94>" + player.name + "<dev string:x9f>" + player.var_e298a3ca3ed1a049);
    }

    if(isDefined(player.var_f12e6635eb2fe3b8)) {
      println("<dev string:x94>" + player.name + "<dev string:xbb>" + player.var_f12e6635eb2fe3b8);
    }

    if(isDefined(player.var_acb3470fd92a831)) {
      println("<dev string:x94>" + player.name + "<dev string:xd5>" + player.var_acb3470fd92a831);
    }

    if(isDefined(player.var_690843a63d7f6150)) {
      println("<dev string:x94>" + player.name + "<dev string:xf2>" + player.var_690843a63d7f6150);
    }

    println("<dev string:x94>" + player.name + "<dev string:x10d>" + gettime());
  }

  if(getdvarint(@ "hash_7b68b0ae5369bbe4", 0) == 1) {
    players = array_randomize(players);
  }

  assertex(players.size <= 4, "<dev string:x121>");
  assertex(players.size > 0, "<dev string:x15f>");

  if(!players.size) {
    return;
  }

  waittime = getdvarint(@ "hash_7061556e5a6fcbc7", 1);
  waittime = isDefined(overridewaittime) ? overridewaittime : waittime;
  players = array_removeundefined(players);

  if(getdvarint(@ "hash_ec3eb579499dadef", 1)) {
    foreach(player in players) {
      if(!isalive(player) || player.sessionstate != "playing") {
        player.var_6c0f9f7e906a5ee6 = 1;
        player scripts\mp\playerlogic::spawnclient(0);
      }
    }
  }

  if(getdvarint(@ "hash_20aac00f832266c", 1)) {
    spawnpoint scene::pre_stream(players, undefined, waittime + 2, "jup_cin_zm_infil");
  } else {
    spawnpoint scene::init(players, undefined, "jup_cin_zm_infil");
  }

  sceneentities = spawnpoint scene::get_entities();

  foreach(entity in sceneentities) {
    if(isent(entity) && !isPlayer(entity)) {
      entity hide();
    }
  }

  foreach(player in players) {
    player thread function_892644c616e3636d(waittime);
    player val::set("ob_infil", "show_hud", 0);
    player val::set("ob_infil", "freezecontrols", 1);
    var_70d0a1f75125a63f = level.prematchperiodend - 20;

    if(var_70d0a1f75125a63f < 0) {
      var_70d0a1f75125a63f = 1;
    }

    player delaythread(var_70d0a1f75125a63f, &namespace_b3f32c8cb80b8124::function_aadc1c81b3fd1dd2, [player]);

    foreach(entity in sceneentities) {
      if(isent(entity) && !isPlayer(entity)) {
        entity showtoplayer(player);
      }
    }
  }

  wait waittime;
  level flag_set("ob_infil_igc_start");
  scripts\mp\flags::gameflagset("infil_started");
  players = array_removeundefined(players);
  function_74a7839b271cb87f(players, spawnpoint, "jup_cin_zm_infil");
}

function function_74a7839b271cb87f(players, spawnpoint, scenename) {
  foreach(player in players) {
    player notify("ob_playInfil");
    player cameraunlink();
    player thread ob_infil_monitor_third_person();
    player clearsoundsubmix("jup_ob_prematch", 1);
    player setsoundsubmix("jup_ob_infil");
    player setsoundsubmix("jup_ob_infil_secondary");
    player.var_f4bb3d8522246fdc = undefined;
    player utility::delaythread(1, &val::reset, "ob_infil", "show_hud");
    player lerpfovscalefactor(0, 0);
    println("<dev string:x18e>" + player.name + "<dev string:x1a3>" + gettime());
    logstring("OB INFIL: Player " + player.name + " starting infil! at time " + gettime());
  }

  n_wait = getdvarfloat(@ "hash_45ce1e830caba62a", 0.75);
  wait n_wait;
  players = array_removeundefined(players);

  if(players.size) {
    spawnpoint scene::play(players, undefined, scenename);
  } else {
    println("<dev string:x1c0>" + (isDefined(spawnpoint.script_noteworthy) ? spawnpoint.script_noteworthy : "<dev string:x32>") + "<dev string:x205>" + spawnpoint.origin);
    logstring("OB INFIL No players in squad for infil scene at spawnPoint group " + (isDefined(spawnpoint.script_noteworthy) ? spawnpoint.script_noteworthy : "") + " at location " + spawnpoint.origin);
    wait 15.0333;
  }

  foreach(player in players) {
    if(!isDefined(player)) {
      continue;
    }

    player _freezelookcontrols(0, 1);
    player val::reset_all("ob_infil");
    player playershow(1);
    player lerpfovbypreset("default");
    player cameraunlink();
    player notify("screen_completely_black");
    player lerpfovscalefactor(1, 1);
    logstring("OB INFIL: Player " + player.name + " status of participating in cinematics after infil: [" + player function_3e2c0f85fe7ca957() + "] at time " + gettime());
    assertex(!player function_3e2c0f85fe7ca957(), "<dev string:x216>");
    player thread function_4315c4f1aade4338();
    println("<dev string:x18e>" + player.name + "<dev string:x273>" + gettime());
    logstring("OB INFIL: Player " + player.name + " done with infil at time " + gettime());
  }
}

function function_4315c4f1aade4338() {
  self endon("disconnect");

  if(!self isonground() || self isskydiving()) {
    v_ground = getgroundposition(self.origin, 32, 500, 1000);

    if(isDefined(v_ground)) {
      self setOrigin(v_ground);
      waitframe();

      if(!self isonground() && isDefined(self.var_87a91b2a8231f4f8)) {
        self setOrigin(self.var_87a91b2a8231f4f8.origin);
        return;
      }
    }
  }

  if(!ispointonnavmesh(self.origin)) {
    v_point = getclosestpointonnavmesh(self.origin);

    if(isDefined(v_point)) {
      self setOrigin(v_point);
      return;
    }
  }

  v_start_origin = self.origin;
  var_a0bfbffbdfb1f04c = 15;
  b_moved = 0;

  while(var_a0bfbffbdfb1f04c > 0) {
    if(distance(self.origin, v_start_origin) > 5) {
      b_moved = 1;
      break;
    }

    wait 1;
    var_a0bfbffbdfb1f04c -= 1;
  }

  if(!b_moved) {
    self setOrigin(self.origin + (0, 0, 32));
  }

  val::reset_all("scene_shot");
  val::reset_all("scene_scene");
}

function ob_infil_monitor_third_person() {
  self endon("disconnect");
  self endon("end_ob_infil_monitor_third_person");
  self.var_8789029d90c5e2de = self getplayerdata("common", "mpProgression", "thirdPerson");

  while(true) {
    if(self getcamerathirdperson()) {
      self setcamerathirdperson(0);
    }

    waitframe();
  }
}

function private function_76e1657e2f2df35c() {
  players = [];

  foreach(s_object in self.scenedata.sceneobjectdata) {
    if(isPlayer(s_object.entity)) {
      players[players.size] = s_object.entity;
      thread function_29fc786decbf9a1f(s_object.entity);
      continue;
    }

    if(isDefined(s_object.entity) && s_object.entity scripts\common\vehicle::isvehicle()) {
      s_object.entity notify("infil_heli_scene_complete");
    }
  }

  thread obinfil_playinfilvo(players);
  wait 0.5;
  var_71fcea457c2df618 = [];

  if(players.size == 2) {
    var_71fcea457c2df618 = ["tablet3"];
  } else if(players.size == 1) {
    var_71fcea457c2df618 = ["tablet2", "tablet3"];
  }

  foreach(s_object in self.scenedata.sceneobjectdata) {
    if(isDefined(s_object.entity) && isDefined(s_object.entity.animname) && utility::array_contains(var_71fcea457c2df618, s_object.entity.animname)) {
      s_object.entity delete();
    }
  }

  if(getdvarint(@ "hash_8da4a5e690432cd0", 1) == 1) {
    thread function_7ac2ef359a625bc4(players);
  }
}

function private function_29fc786decbf9a1f(player) {
  player endon("disconnect");
  player.var_7c6c008ca46286b0 endon("death");
  var_36fedcca9fa6b8bb = player getcurrentweapon();

  if(isnullweapon(var_36fedcca9fa6b8bb)) {
    foreach(weapon in player.primaryweapons) {
      if(!isnullweapon(weapon)) {
        var_36fedcca9fa6b8bb = weapon;
        break;
      }
    }
  }

  player takeweapon(var_36fedcca9fa6b8bb);
  msg = player utility::waittill_any_timeout_1(20, "ws_raise");
  player.var_7c6c008ca46286b0 hidefromplayer(player);
  player hidefromplayer(player);
  player setdemeanorviewmodel("normal");
  player val::reset("scene_shot", "weapon");
  player takeweapon(var_36fedcca9fa6b8bb);
  player giveweapon(var_36fedcca9fa6b8bb);
  player switchtoweaponimmediate(var_36fedcca9fa6b8bb);
  player notify("end_ob_infil_monitor_third_person");
  setthirdperson = istrue(player.var_8789029d90c5e2de);
  player setcamerathirdperson(setthirdperson);
  player setclientomnvar("ui_toggle_third_person", setthirdperson);
  player setplayerdata("common", "mpProgression", "thirdPerson", setthirdperson);
  player.var_8789029d90c5e2de = undefined;
}

function private function_7db747abca8e8f0e() {
  players = [];
  helis = [];

  foreach(s_object in self.scenedata.sceneobjectdata) {
    if(isDefined(s_object.entity)) {
      if(isPlayer(s_object.entity)) {
        players[players.size] = s_object.entity;
        continue;
      }

      if(s_object.entity scripts\common\vehicle::isvehicle()) {
        s_object.entity.var_cb77a772d04fc8e4 = &infil_heli_scene_complete;
        helis[helis.size] = s_object.entity;
      }
    }
  }

  level thread function_18913a2266e5579d(helis);
}

function private function_18913a2266e5579d(helis) {
  while(helis.size > 0) {
    helis = function_fdc9d5557c53078e(helis);
    wait 1;
  }

  unloadinfiltransient("mp_infil_ob_jup_blima_tr");
}

function infil_heli_scene_complete() {
  self notify("infil_heli_scene_complete");
  self endon("infil_heli_scene_complete");
  self endon("death");
  println("<dev string:x290>");
  logstring("OB INFIL: Helicopter done with scene!");
  self function_247ad6a91f6a4ffe(1);
  n_speed = 75;
  n_halfdistance = 25000;
  var_85e713504c80c981 = anglesToForward(self.angles * (0, 1, 0));
  v_end = self.origin + (0, 0, 2500) + var_85e713504c80c981 * n_halfdistance;
  self vehicle_setspeed(n_speed, 15);
  self setvehgoalpos(v_end, 0);
  thread function_16db53e1905b43f5();
  self waittill("goal");
  self delete();
}

function private function_16db53e1905b43f5() {
  self endon("death");
  wait 8;

  while(true) {
    b_can_see = 0;

    foreach(player in level.players) {
      if(!isalive(player) || player.sessionstate == "spectator") {
        continue;
      }

      if(!isbot(player) && utility::within_fov(player.origin, player getplayerangles(), self.origin, 0.7)) {
        b_can_see = 1;
      }

      waitframe();
    }

    if(!b_can_see) {
      self delete();
    }

    wait 0.5;
  }
}

function obinfil_playinfilvo(players) {
  self notify("endon_obInfil_playInfilVO");
  self endon("endon_obInfil_playInfilVO");
  var_f1621847a2f09760 = ["fang", "greene", "ravenov", "soap"];
  var_33e9eb2cccf9e200 = getDvar(@ "hash_a9078d5ae739b39a", "");

  if(array_contains(var_f1621847a2f09760, var_33e9eb2cccf9e200)) {
    str_handler = var_33e9eb2cccf9e200;
  } else {
    str_handler = random(var_f1621847a2f09760);
  }

  var_c323591577074b17 = "ob_infil_" + str_handler;
  wait 5;
  players = array_removeundefined(players);
  overlord::playevent(var_c323591577074b17, players, undefined, undefined, 1);
}

function function_7ac2ef359a625bc4(players) {
  wait getdvarint(@ "hash_120410411ba2e0d1", 15);
  players = array_removeundefined(players);

  foreach(player in players) {
    player setclientomnvar("ui_dmz_mission_overlay", 1);
    player _freezecontrols(0, 1);
    player _freezelookcontrols(0, 1);
  }

  wait getdvarint(@ "hash_65aacd5faa9482f2", 4);
  players = array_removeundefined(players);

  foreach(player in players) {
    player setclientomnvar("ui_dmz_mission_overlay", 0);
  }
}

function function_892644c616e3636d(waittime) {
  self endon("disconnect");
  scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 1, 0);
  wait waittime + getdvarfloat(@ "hash_45ce1e830caba62a", 0.75);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 0, 0);
}

function function_ba66440ae6d60988(var_d410db11bd0cb8b5, var_d410d811bd0cb21c) {
  self endon("disconnect");
  scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 1, 0);
  level flag_wait_all(var_d410db11bd0cb8b5, var_d410d811bd0cb21c);
  scripts\cp_mp\utility\game_utility::fadetoblackforplayerkeepui(self, 0, 0);
}

function function_fff3d0f8a5f042ad() {
  while(!isDefined(level.var_7a8e039103b51e0f)) {
    waitframe();
  }

  devgui::function_6e7290c8ee4f558b("<dev string:x2b9>");
  devgui::function_a9a864379a098ad6("<dev string:x2d7>", "<dev string:x2f8>", &function_926714d6eed28ff3, 1);

  foreach(var_44934ca35515c2c6, var_6f2d35eec7db0a3 in level.var_7a8e039103b51e0f) {
    foreach(n_spawn, var_a52af6b9e435b1cf in var_6f2d35eec7db0a3) {
      if(!isDefined(var_a52af6b9e435b1cf.script_noteworthy)) {
        continue;
      }

      var_dce4f9020e3900b2 = var_a52af6b9e435b1cf.script_noteworthy;
      devgui::function_b23a59dfb4ca49a1("<dev string:x30a>" + var_dce4f9020e3900b2 + "<dev string:x325>" + n_spawn + "<dev string:x330>", "<dev string:x345>" + var_44934ca35515c2c6 + "<dev string:x357>" + n_spawn, &function_35ab01589cc4f6c6);
      devgui::function_b23a59dfb4ca49a1("<dev string:x30a>" + var_dce4f9020e3900b2 + "<dev string:x325>" + n_spawn + "<dev string:x35c>", "<dev string:x377>" + var_44934ca35515c2c6 + "<dev string:x357>" + n_spawn, &function_e7f0b651d2ebaf9d);
    }
  }

  if(istrue(level.var_46901be2468e1d90)) {
    var_9091c4080e2751f2 = spawnlogic::getspawnpointarray("<dev string:x38a>");

    foreach(n_spawn, var_4ca1988ce7e52ba1 in var_9091c4080e2751f2) {
      var_dce4f9020e3900b2 = "<dev string:x3a7>";
      var_44934ca35515c2c6 = "<dev string:x3a7>";
      devgui::function_b23a59dfb4ca49a1("<dev string:x30a>" + var_dce4f9020e3900b2 + "<dev string:x325>" + n_spawn + "<dev string:x330>", "<dev string:x345>" + var_44934ca35515c2c6 + "<dev string:x357>" + n_spawn, &function_35ab01589cc4f6c6);
      devgui::function_b23a59dfb4ca49a1("<dev string:x30a>" + var_dce4f9020e3900b2 + "<dev string:x325>" + n_spawn + "<dev string:x35c>", "<dev string:x377>" + var_44934ca35515c2c6 + "<dev string:x357>" + n_spawn, &function_e7f0b651d2ebaf9d);
    }
  }

  devgui::function_fe953f000498048f();
}

function function_926714d6eed28ff3() {
  while(true) {
    foreach(var_6f2d35eec7db0a3 in level.var_7a8e039103b51e0f) {
      foreach(n_spawn, var_a52af6b9e435b1cf in var_6f2d35eec7db0a3) {
        if(!isDefined(var_a52af6b9e435b1cf.script_noteworthy)) {
          continue;
        }

        print3d(var_a52af6b9e435b1cf.origin, "<dev string:x3ba>" + var_a52af6b9e435b1cf.classname, undefined, undefined, 0.25);
        print3d(var_a52af6b9e435b1cf.origin + (0, 0, -5), "<dev string:x3c9>" + var_a52af6b9e435b1cf.script_noteworthy, undefined, undefined, 0.25);
        print3d(var_a52af6b9e435b1cf.origin + (0, 0, -10), "<dev string:x3e5>" + n_spawn, undefined, undefined, 0.25);
        utility::draw_angles(var_a52af6b9e435b1cf.angles, var_a52af6b9e435b1cf.origin);
        utility::draw_capsule(var_a52af6b9e435b1cf.origin, 16, 64, var_a52af6b9e435b1cf.angles);
      }
    }

    waitframe();
  }
}

function function_35ab01589cc4f6c6(params) {
  var_eb5a9091076e21e8 = level.players[0] squad_utility::getsquadmembers(undefined, 1);

  if(params[0] == "<dev string:x3a7>") {
    var_9091c4080e2751f2 = spawnlogic::getspawnpointarray("<dev string:x38a>");
    n_spawn = int(params[1]);

    foreach(player in var_eb5a9091076e21e8) {
      spawnpoint = var_9091c4080e2751f2[n_spawn];
      player setOrigin(spawnpoint.origin);
      player setplayerangles(spawnpoint.angles);
      n_spawn++;

      if(n_spawn >= var_9091c4080e2751f2.size) {
        n_spawn = 0;
      }
    }

    return;
  }

  var_44934ca35515c2c6 = int(params[0]);
  n_spawn = int(params[1]);
  var_eb5a9091076e21e8 = level.players[0] squad_utility::getsquadmembers(undefined, 1);

  foreach(player in var_eb5a9091076e21e8) {
    spawnpoint = level.var_7a8e039103b51e0f[var_44934ca35515c2c6][n_spawn];
    player setOrigin(spawnpoint.origin);
    player setplayerangles(spawnpoint.angles);
    n_spawn++;

    if(n_spawn >= level.var_7a8e039103b51e0f[var_44934ca35515c2c6].size) {
      n_spawn = 0;
    }
  }
}

function function_e7f0b651d2ebaf9d(params) {
  if(params[0] == "<dev string:x3a7>") {
    var_9091c4080e2751f2 = spawnlogic::getspawnpointarray("<dev string:x38a>");
    n_spawn = int(params[1]);
    spawnpoint = var_9091c4080e2751f2[n_spawn];

    foreach(teamname, squadarray in level.squaddata) {
      foreach(squad in squadarray) {
        if(array_contains(squad.players, level.players[0])) {
          level thread function_2796212b16ece5a4(teamname, squad.index, spawnpoint, 2);
          return;
        }
      }
    }

    return;
  }

  var_44934ca35515c2c6 = int(params[0]);
  n_spawn = int(params[1]);
  spawnpoint = level.var_7a8e039103b51e0f[var_44934ca35515c2c6][n_spawn];

  foreach(teamname, squadarray in level.squaddata) {
    foreach(squad in squadarray) {
      if(array_contains(squad.players, level.players[0])) {
        level thread function_2796212b16ece5a4(teamname, squad.index, spawnpoint, 2);
        return;
      }
    }
  }
}

# /