/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: mp_common\gametypes\clean.gsc
***********************************************/

#using script_335d0650ed05d36d;
#using script_44b0b8420eabacad;
#using scripts\abilities\mp\gadgets\gadget_concertina_wire;
#using scripts\abilities\mp\gadgets\gadget_smart_cover;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\globallogic\globallogic_audio;
#using scripts\core_common\hud_util_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\lui_shared;
#using scripts\core_common\oob;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\gametypes\globallogic;
#using scripts\mp_common\gametypes\globallogic_score;
#using scripts\mp_common\gametypes\match;
#using scripts\mp_common\gametypes\spawning;
#using scripts\mp_common\gametypes\spawnlogic;
#using scripts\mp_common\player\player_utils;
#using scripts\mp_common\util;
#namespace clean;

function private autoexec __init__system__() {
  system::register(#"clean", &preinit, undefined, undefined, undefined);
}

function private preinit() {
  clientfield::register_clientuimodel("hudItems.cleanCarryCount", 14000, 4, "int");
  clientfield::register_clientuimodel("hudItems.cleanCarryFull", 14000, 1, "int");
  clientfield::register("scriptmover", "taco_flag", 14000, 2, "int");
  clientfield::register("allplayers", "taco_carry", 14000, 1, "int");
  clientfield::register("scriptmover", "taco_waypoint", 14000, 1, "int");
}

function event_handler[gametype_init] main(eventstruct) {
  setDvar(#"hash_2e65ea88ce1029dc", int(min(50, 127)));
  globallogic::init();
  level.tacos = [];
  level.teamscorepercleandeposit = getgametypesetting(#"teamscorepercleandeposit");
  level.var_2576eaeb = 0;
  level.cleandepositonlinetime = getgametypesetting(#"cleandepositonlinetime");
  level.cleandepositrotation = getgametypesetting(#"cleandepositrotation");
  level.shownextzoneobjective = getgametypesetting(#"shownextzoneobjective");
  level.var_c5e28dc5 = getgametypesetting(#"hash_5cc4c3042b7d4935");
  level.teambased = 1;
  level.onstartgametype = &onstartgametype;
  level.onspawnplayer = &onspawnplayer;
  player::function_cf3aa03d(&onplayerkilled);
  spawning::addsupportedspawnpointtype("tdm");
  level.cleandropweapon = getweapon(#"dogtag_drop");
  level.goalfx = "ui/fx8_fracture_deposit_point";
  level.var_6c5ba305 = "ui/fx8_fracture_deposit_point_end";
  level.var_dfce3f1c = # "clean_deposit";
  level.var_7e9929c6 = # "hash_76315cb50906f6a9";
  level.var_f3ac1626 = # "hash_7fcd27b1d6d34d4";
  level.var_ce802423 = 1;

  if(is_true(level.var_c5e28dc5)) {
    level.goalfx = "ui/fx8_fracture_deposit_point_ire";
    level.var_6c5ba305 = "ui/fx8_fracture_deposit_point_end_ire";
    level.var_dfce3f1c = # "hash_6c8a4a73bc07da57";
    level.var_7e9929c6 = # "hash_44649de0c0654449";
    level.var_f3ac1626 = # "hash_334f9a386d27edb4";
  }

  callback::on_connect(&onplayerconnect);
}

function onstartgametype() {
  if(is_true(level.var_c5e28dc5)) {
    foreach(team in level.teams) {
      util::function_db4846b(team, 1);
    }
  }

  globallogic_score::resetteamscores();

  if(is_true(level.var_c5e28dc5)) {
    level.var_1940f14e = spawn("script_model", (0, 0, 0));
    level.var_1940f14e setModel("p9_pot_of_gold_pristine");
    level.var_1940f14e sethighdetail(1);
    level.var_1940f14e hide();
  }

  level function_c1780fc7();
  level thread function_fd08eb25();
  level thread function_aafe4c74();
  level thread function_c857e45f();

  level.activedrops = 0;
  level.var_8b5ef67d = 0;
  level.var_bb42ed2 = 0;
  level.var_9d4a9561 = 0;
  level.var_b8c2e6df = 0;

  waitframe(1);

  for(i = 0; i < 50; i++) {
    level.tacos[i] = function_f82f0bb5();
  }
}

function onplayerconnect() {
  self.pers[#"cleandeposits"] = 0;
  self.pers[#"cleandenies"] = 0;
}

function function_aafe4c74() {
  level waittill(#"game_ended");

  foreach(taco in level.tacos) {
    if(taco clientfield::get("taco_flag") > 0) {
      taco clientfield::set("taco_flag", 0);
    }
  }

  foreach(deposithub in level.cleandeposithubs) {
    deposithub stoploopsound();

    if(isDefined(deposithub.baseeffect)) {
      deposithub.baseeffect delete();
    }

    if(isDefined(deposithub.var_a9079d5e)) {
      deposithub.var_a9079d5e delete();
    }
  }

  foreach(player in level.players) {
    player clientfield::set("taco_carry", 0);
  }

  if(isDefined(level.var_96226f2e)) {
    objective_setstate(level.var_96226f2e, "invisible");
  }
}

function debug_print() {
  while(true) {
    iprintln("<dev string:x38>" + level.activedrops);
    iprintln("<dev string:x44>" + level.var_8b5ef67d);
    iprintln("<dev string:x55>" + level.var_bb42ed2);
    iprintln("<dev string:x64>" + level.var_9d4a9561);
    iprintln("<dev string:x73>" + level.var_b8c2e6df);
    wait 5;
  }
}

function onspawnplayer(predictedspawn) {
  if(spawning::usestartspawns() && !level.ingraceperiod) {
    spawning::function_7a87efaa();
  }

  self.var_916cc864 = 0;
  self.var_91be2350 = 0;
  self.var_129c990c = 0;
  self.carriedtacos = 0;
  self.var_3e52c359 = 0;
  self clientfield::set_player_uimodel("hudItems.cleanCarryCount", 0);
  spawning::onspawnplayer(predictedspawn);
}

function onplayerkilled(einflictor, attacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime, deathanimduration) {
  if(isPlayer(psoffsettime) && psoffsettime.team != self.team) {
    if(!isDefined(killstreaks::get_killstreak_for_weapon(deathanimduration)) || is_true(level.killstreaksgivegamescore)) {
      psoffsettime globallogic_score::giveteamscoreforobjective(psoffsettime.team, level.teamscoreperkill);
    }

    if(self.carriedtacos >= 5) {
      scoreevents::processscoreevent(#"clean_kill_enemy_carrying_tacos", psoffsettime, self, deathanimduration);
    }
  }

  if(isDefined(psoffsettime) && isPlayer(psoffsettime) && psoffsettime.team != self.team) {
    taco = function_b25ab1e7();

    if(isDefined(taco)) {
      yawangle = randomint(360);
      taco function_903c4eff(self, psoffsettime, undefined, yawangle);
    }

    self thread function_bbcf6af(psoffsettime, yawangle);
  }

  self function_aea246ff();
}

function function_8695993b() {
  self endon(#"death");
  level endon(#"game_ended");

  while(true) {
    self flag::wait_till("camo_suit_on");
    self clientfield::set("taco_carry", 0);
    self flag::wait_till_clear("camo_suit_on");
  }
}

function function_fccce038() {
  if(self.carriedtacos > 0) {
    self clientfield::set("taco_carry", 1);
    return;
  }

  self clientfield::set("taco_carry", 0);
}

function function_b25ab1e7() {
  var_ba985a3c = undefined;

  foreach(taco in level.tacos) {
    if(taco.interactteam == # "group_none") {
      return taco;
    }

    if(isDefined(taco.var_2581d0d)) {
      continue;
    }

    if(!isDefined(var_ba985a3c) || taco.droptime < var_ba985a3c.droptime) {
      var_ba985a3c = taco;
    }
  }

  if(isDefined(var_ba985a3c) && var_ba985a3c.droptime != gettime()) {
    level.var_9d4a9561++;

    var_ba985a3c registermp_multi_kill_medals_interface();
    return var_ba985a3c;
  }

  level.var_b8c2e6df++;

  return undefined;
}

function function_f82f0bb5() {
  visuals = [];
  trigger = spawn("trigger_radius", (0, 0, 0), 0, 40, 32);
  trigger.var_a865c2cd = 0;
  taco = gameobjects::create_use_object(#"any", trigger, visuals);
  taco notsolid();
  taco ghost();
  taco setModel(#"tag_origin");
  taco gameobjects::set_use_time(0);
  taco.onuse = &function_95cbd646;
  taco clientfield::set("taco_waypoint", 0);
  return taco;
}

function function_903c4eff(victim, attacker, pos, yawangle) {
  level.activedrops++;
  level.var_8b5ef67d = max(level.var_8b5ef67d, level.activedrops);

  if(!isDefined(yawangle)) {
    yawangle = randomint(360);
  }

  if(!isDefined(pos)) {
    pos = victim.origin + (0, 0, 40);
  }

  self.droptime = gettime();
  self.team = victim.team;
  self.victim = victim;
  self.victimteam = victim.team;
  self.attacker = attacker;
  self.attackerteam = attacker.team;
  self.origin = pos;
  self.trigger.origin = pos;
  self show();
  self clientfield::set("taco_flag", 1);
  self clientfield::set("taco_waypoint", 1);
  self playLoopSound("mpl_fracture_core_loop");
  self dontinterpolate();
  self gameobjects::allow_use(#"group_all");

  if(isDefined(self.var_2581d0d)) {
    self.var_2581d0d delete();
  }

  dropangles = (-70, yawangle, 0);
  force = anglesToForward(dropangles) * randomfloatrange(getdvarfloat(#"dropmin", 220), getdvarfloat(#"dropmax", 300));
  self.var_2581d0d = victim magicmissile(level.cleandropweapon, pos, force);
  self.var_2581d0d hide();
  self.var_2581d0d notsolid();
  self thread function_8cb72ba4();
  self thread function_9415d18b();
  self thread timeout_wait();
}

function function_8cb72ba4() {
  level endon(#"game_ended");
  self endon(#"reset");
  self.var_2581d0d endon(#"death", #"stationary");

  while(true) {
    if(!isDefined(self.var_2581d0d)) {
      break;
    }

    if(self.var_2581d0d oob::istouchinganyoobtrigger() || self.var_2581d0d gameobjects::is_touching_any_trigger_key_value("trigger_hurt", "classname", self.trigger.origin[2], self.trigger.origin[2] + 32)) {
      self thread registermp_multi_kill_medals_interface();
      return;
    }

    self.trigger.origin = self.var_2581d0d.origin;
    waitframe(1);
  }
}

function function_9415d18b() {
  level endon(#"game_ended");
  self endon(#"reset");
  self.var_2581d0d endon(#"death");

  if(!isDefined(self.var_2581d0d)) {
    return;
  }

  self.var_2581d0d waittill(#"stationary");
  self.trigger.origin = self.var_2581d0d.origin;
  self playSound("mpl_fracture_core_drop");
  self clientfield::set("taco_flag", 2);
  self.var_2581d0d deletedelay();
  self.var_2581d0d = undefined;
}

function timeout_wait() {
  level endon(#"game_ended");
  self endon(#"reset");
  wait 60;

  level.var_bb42ed2++;

  self thread registermp_multi_kill_medals_interface();
}

function registermp_multi_kill_medals_interface() {
  level.activedrops--;

  self notify(#"reset");
  self clientfield::set("taco_flag", 0);
  self clientfield::set("taco_waypoint", 0);
  self stoploopsound();
  self.trigger.origin = (0, 0, 1000);
  self gameobjects::allow_use(#"group_none");
  waittillframeend();

  if(isDefined(self.var_2581d0d)) {
    self.var_2581d0d delete();
    self.var_2581d0d = undefined;
  }

  self ghost();
}

function function_c1780fc7() {
  globallogic::function_bf2901cf();
  function_b4a9e792("clean_objective_base_trig");
  function_b4a9e792("clean_objective_center_trig");
  function_b4a9e792("clean_objective_scatter_trig");
  function_998dec78();
  function_8be56c1(#"clean_deposit");

  if(isDefined(level.shownextzoneobjective) && level.shownextzoneobjective > 0) {
    level.var_96226f2e = gameobjects::get_next_obj_id();
    objective_add(level.var_96226f2e, "invisible", undefined, level.var_7e9929c6);
    function_18fbab10(level.var_96226f2e, level.var_f3ac1626);
  }
}

function private function_8be56c1(targetname) {
  level.cleandeposithubs = [];
  structs = struct::get_array(targetname);

  foreach(struct in structs) {
    assert(isDefined(struct.script_index), function_9e72a96(targetname) + "<dev string:x7f>");
    assert(!isDefined(level.cleandeposithubs[struct.script_index]), function_9e72a96(targetname) + "<dev string:x9d>");

    level.cleandeposithubs[struct.script_index] = function_bad2b0d4(struct.origin);
  }

  for(i = 0; i < level.cleandeposithubs.size; i++) {
    assert(isDefined(level.cleandeposithubs[i]), "<dev string:xc3>" + function_9e72a96(targetname) + "<dev string:xcf>" + i);
  }
}

function private function_8c1a5f77() {
  if(!isDefined(level.cleandepositpoints)) {
    util::error("<dev string:xed>");

    return;
  }

  level.cleandeposithubs = [];

  foreach(point in level.cleandepositpoints) {
    deposithub = function_bad2b0d4(point);
    level.cleandeposithubs[level.cleandeposithubs.size] = deposithub;
  }
}

function function_b4a9e792(targetname) {
  ents = getEntArray(targetname, "targetname");

  foreach(ent in ents) {
    ent delete();
  }
}

function function_998dec78() {
  scriptmodels = getEntArray("script_model", "className");

  foreach(scriptmodel in scriptmodels) {
    if(scriptmodel.model === "p7_mp_flag_base") {
      scriptmodel delete();
    }
  }
}

function function_bad2b0d4(origin) {
  trigger = spawn("trigger_radius", origin, 0, 60, 108);
  visuals[0] = spawn("script_model", trigger.origin);
  deposithub = gameobjects::create_use_object(#"neutral", trigger, visuals, undefined, level.var_dfce3f1c);
  deposithub gameobjects::allow_use(#"group_all");
  deposithub gameobjects::set_visible(#"group_all");
  deposithub gameobjects::set_use_time(0);
  deposithub gameobjects::disable_object();
  deposithub.onuse = &function_83e87bd5;
  deposithub.canuseobject = &function_1237ad98;
  deposithub.effectorigin = trigger.origin + (0, 0, 4);
  deposithub.influencer = influencers::create_influencer("clean_deposit_hub", deposithub.origin, 0);
  enableinfluencer(deposithub.influencer, 0);
  return deposithub;
}

function function_b8a3dde4() {
  level endon(#"game_ended");
  self.baseeffect = spawnfx(level.goalfx, self.effectorigin);
  self.baseeffect.team = # "none";
  triggerfx(self.baseeffect, 0.001);

  if(is_true(level.var_c5e28dc5)) {
    var_a58771cf = anglesToForward(self.angles);
    var_352b1189 = anglestoup(self.angles);
    self.var_a9079d5e = spawnfx(#"hash_4e307a6141c3c7c4", self.origin, var_a58771cf, var_352b1189);
    triggerfx(self.var_a9079d5e, 0.001);
  }

  wait_time = level.cleandepositonlinetime;

  if(wait_time < 0) {
    wait_time = level.cleandepositonlinetime * 0.05;
  }

  wait wait_time;

  if(isDefined(self.var_a9079d5e)) {
    self.var_a9079d5e delete();
  }

  if(!isDefined(self.baseeffect)) {
    return;
  }

  self.baseeffect delete();
  self.baseeffect = spawnfx(level.var_6c5ba305, self.effectorigin);
  self.baseeffect.team = # "none";
  triggerfx(self.baseeffect, 0.001);
  self.baseeffect = spawnfx(level.var_6c5ba305, self.effectorigin);
}

function function_fd08eb25() {
  level endon(#"game_ended");

  while(level.inprematchperiod) {
    waitframe(1);
  }

  setbombtimer("A", 0);
  setmatchflag("bomb_timer_a", 0);
  var_696c0ca5 = -1;
  var_79efdaa0 = undefined;

  while(true) {
    if(level.var_2576eaeb > 0) {
      foreach(team, _ in level.teams) {
        setmatchflag("bomb_timer_a", 1);
        setbombtimer("A", gettime() + 1000 + int(level.var_2576eaeb * 1000));

        if(var_696c0ca5 >= 0) {
          globallogic_audio::leader_dialog("hubOffline", team);
          globallogic_audio::play_2d_on_team("mpl_hardpoint_move", team);
        }
      }

      wait level.var_2576eaeb;
    }

    if(isDefined(level.var_96226f2e)) {
      objective_setstate(level.var_96226f2e, "invisible");
    }

    var_e0b73154 = isDefined(var_79efdaa0) ? var_79efdaa0 : function_e3e1cf54(var_696c0ca5);
    deposithub = level.cleandeposithubs[var_e0b73154];
    var_79efdaa0 = function_e3e1cf54(var_e0b73154);
    deposithub gameobjects::enable_object();
    deposithub gameobjects::allow_use(#"group_all");
    smart_cover::addprotectedzone(deposithub.trigger);
    concertina_wire::addprotectedzone(deposithub.trigger);
    deposithub thread function_b8a3dde4();
    enableinfluencer(deposithub.influencer, 1);

    if(isDefined(level.var_1940f14e)) {
      level.var_1940f14e.origin = deposithub.origin;
      level.var_1940f14e show();
    }

    setmatchflag("bomb_timer_a", 1);
    setbombtimer("A", gettime() + 1000 + int(level.cleandepositonlinetime * 1000));

    foreach(team, _ in level.teams) {
      if(level.var_2576eaeb > 0) {
        globallogic_audio::leader_dialog("hubOnline", team);
      } else if(var_696c0ca5 >= 0) {
        globallogic_audio::leader_dialog("hubMoved", team);
      }

      if(var_696c0ca5 >= 0) {
        globallogic_audio::play_2d_on_team("mpl_hq_cap_us", team);
      }
    }

    var_696c0ca5 = var_e0b73154;

    if(isDefined(level.shownextzoneobjective) && level.shownextzoneobjective > 0 && isDefined(level.var_96226f2e)) {
      var_4f1e9d48 = max(0, level.cleandepositonlinetime - level.shownextzoneobjective);
      wait var_4f1e9d48;
      var_f6595e31 = level.cleandeposithubs[var_79efdaa0];

      if(isDefined(var_f6595e31.origin)) {
        objective_setposition(level.var_96226f2e, var_f6595e31.origin);
        objective_setstate(level.var_96226f2e, "active");
      }

      var_b2667d52 = level.cleandepositonlinetime - var_4f1e9d48;
      wait var_b2667d52;
    } else {
      wait level.cleandepositonlinetime;
    }

    smart_cover::removeprotectedzone(deposithub.trigger);
    concertina_wire::removeprotectedzone(deposithub.trigger);
    deposithub gameobjects::disable_object();
    deposithub gameobjects::allow_use(#"group_none");
    deposithub gameobjects::set_visible(#"group_none");
    enableinfluencer(deposithub.influencer, 0);
    deposithub stoploopsound();

    if(isDefined(level.var_1940f14e)) {
      level.var_1940f14e hide();
    }

    deposithub.baseeffect delete();
  }
}

function function_e3e1cf54(var_696c0ca5 = -1) {
  switch (level.cleandepositrotation) {
    case 0:
      return ((var_696c0ca5 + 1) % level.cleandeposithubs.size);
    case 1:
      return function_579aa766(var_696c0ca5, &registerexert_immolation_control);
  }

  return registerexert_immolation_control(var_696c0ca5);
}

function function_579aa766(var_696c0ca5, var_c1e8a2b7) {
  if(var_696c0ca5 < 0) {
    return 0;
  }

  return [[var_c1e8a2b7]](var_696c0ca5);
}

function registerexert_immolation_control(var_696c0ca5) {
  if(!isDefined(level.var_49aeba07)) {
    level.var_49aeba07 = [];
  }

  if(level.var_49aeba07.size == 0) {
    for(i = 0; i < level.cleandeposithubs.size; i++) {
      if(i != var_696c0ca5) {
        level.var_49aeba07[level.var_49aeba07.size] = i;
      }
    }

    if(level.cleandeposithubs.size < 2) {
      return 0;
    }
  }

  var_8ae22528 = randomint(level.var_49aeba07.size);
  nextindex = level.var_49aeba07[var_8ae22528];
  arrayremoveindex(level.var_49aeba07, var_8ae22528);
  return nextindex;
}

function function_60c1a907(var_696c0ca5) {
  if(var_696c0ca5 < 0) {
    return randomint(level.cleandeposithubs.size);
  }

  nextindex = randomint(level.cleandeposithubs.size - 1);

  if(nextindex >= var_696c0ca5) {
    nextindex++;
  }

  return nextindex;
}

function hidetimerdisplayongameend() {
  level waittill(#"game_ended");
  setmatchflag("bomb_timer_a", 0);
}

function function_c857e45f() {
  level endon(#"game_ended");

  while(true) {
    time = gettime();

    foreach(player in level.players) {
      if(isDefined(player.var_916cc864) && isDefined(player.var_91be2350) && player.var_91be2350 && time - player.var_916cc864 > int((float(function_60d95f53()) / 1000 + 0.25 + 0.1) * 1000)) {
        enemyteam = util::getotherteam(player.team);

        if(player.var_91be2350 >= 10) {
          scoreevents::processscoreevent(#"clean_multi_deposit_big", player);
        } else if(player.var_91be2350 >= 5) {
          scoreevents::processscoreevent(#"clean_multi_deposit_normal", player);
        }

        player.var_91be2350 = 0;
      }

      if(isDefined(player.var_66521d81) && player.var_66521d81 < gettime() - 1500) {
        if(player.var_3e52c359 >= 5) {
          scoreevents::processscoreevent(#"clean_multi_deny_tacos", player);
        }

        player.var_3e52c359 = 0;
        player.var_66521d81 = undefined;
      }
    }

    waitframe(1);
  }
}

function function_83e87bd5(player) {
  time = gettime();
  player.var_916cc864 = time;

  if(isDefined(player.pers[#"cleandeposits"])) {
    player.pers[#"cleandeposits"] += 1;
    player.cleandeposits = player.pers[#"cleandeposits"];
    [[level.var_37d62931]](player, 1);
  }

  player stats::function_bb7eedf0(#"cleandeposits", 1);

  if(level.teamscorepercleandeposit > 0) {
    var_e5474cba = level.teamscorepercleandeposit;
    player globallogic_score::giveteamscoreforobjective(player.team, var_e5474cba);
  }

  switch (player.var_91be2350) {
    case 0:
      player playSound("mpl_stockpile_deposit_1");
      break;
    case 1:
      player playSound("mpl_stockpile_deposit_2");
      break;
    case 2:
      player playSound("mpl_stockpile_deposit_3");
      break;
    case 3:
      player playSound("mpl_stockpile_deposit_4");
      break;
    default:
      player playSound("mpl_stockpile_deposit_5");
      break;
  }

  player.var_91be2350++;

  if(is_true(level.var_c5e28dc5)) {
    scoreevents::processscoreevent("shamrock_enemy_deposit", player);
  } else {
    scoreevents::processscoreevent("clean_enemy_deposit", player);
  }

  player.carriedtacos--;
  player clientfield::set_player_uimodel("hudItems.cleanCarryCount", player.carriedtacos);

  if(player.carriedtacos < 8) {
    player function_aea246ff();
  }

  player function_fccce038();
}

function function_1237ad98(player) {
  if(player.carriedtacos <= 0) {
    objective_clearplayerusing(self.objectiveid, player);
    return false;
  }

  if(!player.var_916cc864) {
    return true;
  }

  return player.var_916cc864 + int(0.25 * 1000) < gettime();
}

function function_95cbd646(player) {
  if(self.victimteam == player.team) {
    player playSound("mpl_killconfirm_tags_pickup");

    if(isDefined(player.pers[#"cleandenies"])) {
      player.pers[#"cleandenies"] += 1;
      player.cleandenies = player.pers[#"cleandenies"];
      [[level.var_37d62931]](player, 1);
    }

    player stats::function_bb7eedf0(#"cleandenies", 1);

    if(is_true(level.var_c5e28dc5)) {
      if(self.victim === player) {
        scoreevents::processscoreevent("shamrock_own_collect", player);
      } else {
        scoreevents::processscoreevent("shamrock_friendly_collect", player);
      }
    } else if(self.victim === player) {
      scoreevents::processscoreevent("clean_own_collect", player);
    } else {
      scoreevents::processscoreevent("clean_friendly_collect", player);
    }

    player.var_66521d81 = gettime();
    player.var_3e52c359++;
  } else if(player.carriedtacos >= 10) {
    time = gettime();

    if(time - player.var_129c990c > 500) {
      player playlocalsound("mpl_fracture_enemy_pickup_nope");

      if(!isDefined(player.var_49f1d9cc)) {
        player.var_49f1d9cc = 0;
      }

      player clientfield::set_player_uimodel("hudItems.cleanCarryFull", player.var_49f1d9cc);
      player.var_49f1d9cc = player.var_49f1d9cc ? 0 : 1;
    }

    player.var_129c990c = time;
    return;
  } else {
    player.carriedtacos++;
    player clientfield::set_player_uimodel("hudItems.cleanCarryCount", player.carriedtacos);
    player function_fccce038();

    if(player.carriedtacos < 4) {
      player playSound("mpl_killconfirm_tags_pickup");
    } else if(player.carriedtacos < 7) {
      player playSound("mpl_killconfirm_tags_pickup");
    } else {
      player playSound("mpl_killconfirm_tags_pickup");
    }

    if(player.carriedtacos >= 8) {
      player function_3fdaa652();
    }

    if(is_true(level.var_c5e28dc5)) {
      scoreevents::processscoreevent("shamrock_enemy_collect", player);
    } else {
      scoreevents::processscoreevent("clean_enemy_collect", player);
    }

    if(self.attackerteam == player.team && isDefined(self.attacker) && self.attacker != player) {
      if(is_true(level.var_c5e28dc5)) {
        scoreevents::processscoreevent("shamrock_assist_collect", self.attacker);
      } else {
        scoreevents::processscoreevent("clean_assist_collect", self.attacker);
      }
    }
  }

  self registermp_multi_kill_medals_interface();
}

function function_bbcf6af(attacker, yawangle) {
  dropcount = self.carriedtacos;
  self.carriedtacos = 0;
  self clientfield::set_player_uimodel("hudItems.cleanCarryCount", self.carriedtacos);
  self function_fccce038();

  dropcount += getdvarint(#"extratacos", 0);

  var_8a33c2ea = 360 / (dropcount + 1);

  for(i = 0; i < dropcount; i++) {
    taco = function_b25ab1e7();

    if(!isDefined(taco)) {
      return;
    }

    yawangle += var_8a33c2ea;
    randomyaw = 0.8 * var_8a33c2ea;
    randomyaw = randomfloatrange(randomyaw * -1, randomyaw);
    taco function_903c4eff(self, attacker, undefined, yawangle + randomyaw);
  }
}

function function_3fdaa652() {
  if(!isDefined(self.var_227573ea)) {
    self.var_227573ea = 0;
  }

  if(is_true(level.var_2179a6bf)) {
    return;
  }

  if(!is_true(self.var_227573ea)) {
    self thread globallogic_audio::function_c246758e("taco_music");
    self.var_227573ea = 1;
  }
}

function function_aea246ff() {
  if(!isDefined(self.var_227573ea)) {
    self.var_227573ea = 0;
  }

  if(is_true(level.var_2179a6bf)) {
    return;
  }

  if(is_true(self.var_227573ea)) {
    self thread globallogic_audio::function_c246758e("none");
    self.var_227573ea = 0;
  }
}