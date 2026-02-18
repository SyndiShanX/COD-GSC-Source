/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\recon_plane.gsc
***********************************************/

#using scripts\core_common\array_shared;
#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\contracts_shared;
#using scripts\core_common\globallogic\globallogic_score;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\scoreevents_shared;
#using scripts\core_common\system_shared;
#using scripts\core_common\tweakables_shared;
#using scripts\core_common\util_shared;
#using scripts\killstreaks\airsupport;
#using scripts\killstreaks\helicopter_shared;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\mp_common\teams\teams;
#using scripts\mp_common\util;
#using scripts\weapons\heatseekingmissile;
#namespace recon_plane;

function private autoexec __init__system__() {
  system::register(#"recon_plane", &preinit, undefined, undefined, #"killstreaks");
}

function private preinit() {
  if(level.teambased) {
    foreach(team, _ in level.teams) {
      level.var_eb10c6a7[team] = 0;
    }
  } else {
    level.var_eb10c6a7 = [];
  }

  level.var_42ce45d5 = [];
  level.var_efb43e1 = &function_4dc67281;
  level.var_5604e453 = &function_5604e453;
  bundlename = "killstreak_recon_plane";

  if(sessionmodeiswarzonegame()) {
    bundlename += "_wz";
  }

  if(tweakables::gettweakablevalue("killstreak", "allowradardirection")) {
    killstreaks::register_killstreak(bundlename, &function_732dcb56);
  }

  callback::on_connect(&onplayerconnect);
  callback::on_spawned(&onplayerspawned);
  var_251f8a28 = getweapon("recon_plane");
  globallogic_score::function_c1e9b86b(var_251f8a28, &function_c131324d);
  globallogic_score::register_kill_callback(var_251f8a28, &function_ed29480b);
  callback::add_callback(#"hash_7c6da2f2c9ef947a", &fx_flesh_hit_neck_fatal);
  clientfield::register("scriptmover", "recon_plane", 1, 1, "int");
  clientfield::register("scriptmover", "recon_plane_reveal", 1, 1, "int");
  clientfield::register("scriptmover", "recon_plane_damage_fx", 1, 2, "int");
  level thread function_bde85071();
}

function onplayerconnect() {
  self.entnum = self getentitynumber();

  if(!level.teambased) {
    level.var_eb10c6a7[self.entnum] = 0;
  }

  level.var_42ce45d5[self.entnum] = 0;
}

function onplayerspawned(local_client_num) {
  if(!level.teambased) {
    function_65f48f1a(self);
  }
}

function function_769ed4e8(ent) {
  if(!(isDefined(ent.origin) && isDefined(self.var_23cd2a2f.origin))) {
    return false;
  }

  bundle = killstreaks::get_script_bundle("recon_plane");
  var_b2231ba3 = sqr((isDefined(bundle.var_e77ca4a1) ? bundle.var_e77ca4a1 : 0) / 2);
  return distance2dsquared(ent.origin, self.var_23cd2a2f.origin) <= var_b2231ba3;
}

function function_e7ed088a() {
  return isDefined(level.var_42ce45d5[self.entnum]) && level.var_42ce45d5[self.entnum] > 0;
}

function function_5604e453(enemy) {
  if(self function_e7ed088a()) {
    if(!getDvar(#"hash_5e7fdbdeddbdf32", 0)) {
      return true;
    }

    arrayremovevalue(level.var_d952ba86, undefined);

    foreach(recon_plane in level.var_d952ba86) {
      if(self === recon_plane.owner && recon_plane function_769ed4e8(enemy)) {
        return true;
      }
    }
  }

  return false;
}

function function_ed29480b(attacker, victim, weapon, attackerweapon, meansofdeath) {
  if(attackerweapon util::isenemyplayer(meansofdeath) && (!isDefined(level.var_3d960463) || isDefined(level.var_3d960463) && !attackerweapon[[level.var_3d960463]]())) {
    if(attackerweapon function_5604e453(meansofdeath)) {
      return true;
    }
  }

  return false;
}

function function_4dc67281() {
  if(!isDefined(self.team)) {
    return false;
  }

  friendlyteam = self.team;

  foreach(team in level.teams) {
    if(team == friendlyteam) {
      continue;
    }

    if(isDefined(level.var_eb10c6a7[team]) && level.var_eb10c6a7[team] > 0) {
      return true;
    }
  }

  return false;
}

function function_c131324d(params) {
  challenges::function_7f86a7b8(params.attacker, params.attackerweapon, params.meansofdeath);
}

function fx_flesh_hit_neck_fatal(params) {
  if(!isDefined(level.var_3d960463) || isDefined(level.var_3d960463) && !params.attacker[[level.var_3d960463]]()) {
    foreach(player in params.players) {
      if(player function_5604e453()) {
        scoregiven = scoreevents::processscoreevent(#"hash_2bca2bdbbd783d4e", player, undefined, undefined);

        if(isDefined(scoregiven)) {
          player stats::function_8fb23f94("recon_plane", #"assists", 1);
          player stats::function_b04e7184("recon_plane", #"best_assists");

          if(isDefined(level.var_b7bc3c75.var_e2298731)) {
            player[[level.var_b7bc3c75.var_e2298731]]();
          }
        }
      }
    }
  }
}

function function_732dcb56(killstreaktype) {
  if(self killstreakrules::iskillstreakallowed("recon_plane", self.team) == 0) {
    return false;
  }

  killstreak_id = self killstreakrules::killstreakstart("recon_plane", self.team);

  if(killstreak_id == -1) {
    return false;
  }

  bundle = killstreaks::get_script_bundle("recon_plane");
  adjustedpath = function_98e60435(self.origin, bundle);
  startposition = adjustedpath[# "startposition"];
  endposition = adjustedpath[# "endposition"];
  angles = adjustedpath[# "angles"];
  recon_plane = spawn("script_model", startposition);

  if(!isDefined(level.var_d952ba86)) {
    level.var_d952ba86 = [];
  } else if(!isarray(level.var_d952ba86)) {
    level.var_d952ba86 = array(level.var_d952ba86);
  }

  level.var_d952ba86[level.var_d952ba86.size] = recon_plane;
  var_e4467d10 = spawn("script_model", self.origin);
  var_e4467d10 setModel(#"tag_origin");
  var_e4467d10 setteam(self.team);
  var_e4467d10 clientfield::set("recon_plane_reveal", 1);
  recon_plane.var_23cd2a2f = var_e4467d10;
  weapon = getweapon("recon_plane");
  recon_plane setModel(bundle.ksmodel);
  recon_plane setenemymodel(bundle.var_aa0b97e1);
  recon_plane function_619a5c20();
  recon_plane setweapon(weapon);
  recon_plane setforcenocull();
  recon_plane.killstreak_id = killstreak_id;
  recon_plane.owner = self;
  recon_plane.ownerentnum = self getentitynumber();
  recon_plane.team = self.team;
  recon_plane setteam(self.team);
  recon_plane setowner(self);
  recon_plane killstreaks::configure_team(killstreaktype, killstreak_id, self, undefined, undefined, &configureteampost);
  recon_plane killstreak_hacking::enable_hacking("recon_plane", &hackedprefunction, undefined);
  recon_plane.targetname = "recon_plane";
  recon_plane.leaving = 0;
  recon_plane util::make_sentient();
  recon_plane.var_c31213a5 = 1;
  recon_plane thread killstreaks::function_2b6aa9e8("recon_plane", &function_e55922df, &onlowhealth);
  recon_plane thread function_f724cfe4(100000);
  recon_plane thread killstreaks::waittillemp(&function_b16d07ad);
  recon_plane.killstreakdamagemodifier = &killstreakdamagemodifier;

  if(isDefined(bundle.var_6dfc61a2) && bundle.var_6dfc61a2 > 0) {
    recon_plane.extra_low_health = bundle.var_6dfc61a2;
    recon_plane.extra_low_health_callback = &onextralowhealth;
  }

  recon_plane.numflares = 1;
  recon_plane helicopter::create_flare_ent((0, 0, -25));
  recon_plane.rocketdamage = recon_plane.maxhealth / 3 + 1;
  recon_plane moveto(endposition, 40000 * 0.002);
  recon_plane.angles = angles;
  target_set(recon_plane);
  recon_plane clientfield::set("enemyvehicle", 1);
  recon_plane clientfield::set("recon_plane", 1);
  recon_plane killstreaks::function_a781e8d2();
  recon_plane thread killstreaks::waitfortimeout("recon_plane", 40000, &ontimeout, "death", "crashing");
  recon_plane thread killstreaks::waitfortimecheck(40000 / 2, &ontimecheck, "death", "crashing");
  recon_plane thread heatseekingmissile::missiletarget_proximitydetonateincomingmissile(bundle, "death", undefined, 1);
  self killstreak_dialog::play_killstreak_start_dialog("recon_plane", self.team, killstreak_id);
  recon_plane killstreak_dialog::play_pilot_dialog_on_owner("arrive", "recon_plane", killstreak_id);
  recon_plane thread killstreaks::player_killstreak_threat_tracking("recon_plane", 0.984808);
  self stats::function_e24eec31(getweapon("recon_plane"), #"used", 1);
  recon_plane thread killstreaks::function_5a7ecb6b();
  return true;
}

function function_98e60435(var_d44b8c3e, bundle) {
  travelangle = randomfloatrange(isDefined(level.var_84f1b20f) ? level.var_84f1b20f : 90, isDefined(level.var_26837e34) ? level.var_26837e34 : 180);
  startangles = (0, travelangle, 0);
  startforward = anglesToForward(startangles);

  if(sessionmodeiswarzonegame()) {
    travelradius = 25000;
    zoffset = var_d44b8c3e[2] + 9500;
  } else {
    travelradius = airsupport::getmaxmapwidth() * 1.5;
    zoffset = killstreaks::function_43f4782d() + 9500;
  }

  if(sessionmodeiswarzonegame()) {
    var_51cabd75 = 180 / 30;
    var_ddd8ddab = travelradius * 2 / (3 - 1);
    var_c8e01926 = undefined;
    bestpath = [];
    var_51c6fb78 = 0;
    forward = startforward;
    angles = startangles;

    while(var_51c6fb78 < var_51cabd75) {
      var_59a518e1 = [];

      for(i = 0; i < 3; i++) {
        position = var_d44b8c3e + vectorscale(forward, -1 * travelradius + var_ddd8ddab * i);

        if(i == 0) {
          var_90aa61b = position;
        }

        var_b0490eb9 = getheliheightlockheight(position);

        if(var_b0490eb9 != position[2]) {
          var_59a518e1[var_59a518e1.size] = var_b0490eb9;
        }
      }

      if(var_59a518e1.size) {
        var_59a518e1 = array::sort_by_value(var_59a518e1, 1);
        maxheight = var_59a518e1[var_59a518e1.size - 1];
        var_35637e22 = maxheight - var_59a518e1[0];
        trace = groundtrace((var_d44b8c3e[0], var_d44b8c3e[1], maxheight), var_d44b8c3e - (0, 0, 5000), 0, undefined);
        groundheight = trace[# "position"][2];
        var_6b1fb8d9 = groundheight + (maxheight - groundheight) * bundle.var_ff73e08c;
        endposition = var_90aa61b + vectorscale(forward, travelradius * 2);

        if(var_35637e22 < 2000) {
          adjustedpath[# "startposition"] = (var_90aa61b[0], var_90aa61b[1], var_6b1fb8d9);
          adjustedpath[# "endposition"] = (endposition[0], endposition[1], var_6b1fb8d9);
          adjustedpath[# "angles"] = angles;
          return adjustedpath;
        }

        if(!isDefined(var_c8e01926) || var_35637e22 < var_c8e01926) {
          var_c8e01926 = var_35637e22;
          var_af2fe365[# "startposition"] = (var_90aa61b[0], var_90aa61b[1], var_6b1fb8d9);
          var_af2fe365[# "endposition"] = (endposition[0], endposition[1], var_6b1fb8d9);
          var_af2fe365[# "angles"] = angles;
        }
      }

      angles += (0, 30, 0);
      forward = anglesToForward(angles);
      var_51c6fb78++;
      waitframe(1);
    }

    if(isDefined(var_af2fe365)) {
      return var_af2fe365;
    }
  }

  adjustedpath[# "startposition"] = var_d44b8c3e + vectorscale(startforward, -1 * travelradius) + (0, 0, zoffset);
  adjustedpath[# "endposition"] = var_d44b8c3e + vectorscale(startforward, travelradius) + (0, 0, zoffset);
  adjustedpath[# "angles"] = startangles;
  return adjustedpath;
}

function function_f724cfe4(health) {
  waitframe(1);
  self.health = health;
}

function hackedprefunction(hacker) {
  recon_plane = self;
  recon_plane function_cf33d294();
}

function configureteampost(owner, ishacked) {
  recon_plane = self;
  recon_plane thread teams::waituntilteamchangesingleton(ishacked, "ReconPlane_watch_team_change_" + recon_plane getentitynumber(), &onteamchange, self.entnum, "delete", "death", "leaving");
  recon_plane setvisibletoall();
  recon_plane function_e6689aef();
}

function onlowhealth(attacker, weapon) {
  bundle = killstreaks::get_script_bundle("recon_plane");

  if(isDefined(bundle.fxlowhealth)) {
    self clientfield::set("recon_plane_damage_fx", 1);
  }
}

function onextralowhealth(attacker, weapon) {
  bundle = killstreaks::get_script_bundle("recon_plane");

  if(isDefined(bundle.var_277154f7)) {
    self clientfield::set("recon_plane_damage_fx", 2);
  }
}

function onteamchange(entnum, event) {
  function_e55922df();
}

function ontimeout() {
  self killstreak_dialog::function_d2219b7d("recon_plane");
  self.leaving = 1;
  self function_171f5ed8();
  self clientfield::set("recon_plane", 0);
  airsupport::leave(10);
  assert(10 > 3);
  self util::delay(10 - 3, undefined, &killstreaks::outro_scaling);
  wait 10 - 1;
  self killstreaks::function_90e951f2();
  waitframe(1);

  if(isDefined(self)) {
    profilestart();

    if(isDefined(self.var_23cd2a2f)) {
      self.var_23cd2a2f clientfield::set("recon_plane_reveal", 0);
      self.var_23cd2a2f delete();
    }

    profilestop();
    wait 1;

    if(isDefined(self)) {
      arrayremovevalue(level.var_d952ba86, self);
      self delete();
    }
  }
}

function ontimecheck() {
  self killstreak_dialog::play_pilot_dialog_on_owner("timecheck", "recon_plane", self.killstreak_id);
}

function function_b16d07ad(attacker, arg) {
  function_e55922df(arg, getweapon(#"emp"));
}

function function_e55922df(attacker, weapon) {
  attacker = self[[level.figure_out_attacker]](attacker);

  if(isDefined(attacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(attacker))) {
    attacker battlechatter::function_eebf94f6("recon_plane");
    challenges::destroyedaircraft(attacker, weapon, 0, self);
    self killstreaks::function_73566ec7(attacker, weapon, self.owner);
    attacker challenges::addflyswatterstat(weapon, self);
    luinotifyevent(#"player_callout", 2, #"hash_18fd62979f21a7de", attacker.entnum);
  }

  if(self.leaving !== 1) {
    self killstreak_dialog::play_destroyed_dialog_on_owner("recon_plane", self.killstreak_id);

    if(isDefined(attacker)) {
      attacker notify(#"destroyedaircraft");
    }
  }

  self notify(#"crashing");
  params = killstreaks::get_script_bundle("recon_plane");

  if(isDefined(params.ksexplosionfx)) {
    playFXOnTag(params.ksexplosionfx, self, "tag_origin");
  }

  self killstreaks::function_7d265bd3();
  self killstreaks::function_90e951f2();

  if(target_istarget(self)) {
    target_remove(self);
  }

  profilestart();

  if(!self.leaving) {
    self function_171f5ed8();
  }

  self clientfield::set("recon_plane", 0);

  if(isDefined(self.var_23cd2a2f)) {
    self.var_23cd2a2f clientfield::set("recon_plane_reveal", 0);
    self.var_23cd2a2f delete();
  }

  arrayremovevalue(level.var_d952ba86, self);
  self deletedelay();
  profilestop();
}

function function_e6689aef() {
  if(level.teambased) {
    level.var_eb10c6a7[self.team]++;
  } else {
    level.var_eb10c6a7[self.ownerentnum]++;
  }

  level.var_42ce45d5[self.ownerentnum]++;
  level notify(#"hash_25b529a667fde073");
}

function function_171f5ed8() {
  self function_cf33d294();
  killstreakrules::killstreakstop(self.killstreaktype, self.originalteam, self.killstreak_id);
}

function function_cf33d294() {
  if(level.teambased) {
    level.var_eb10c6a7[self.team]--;
    assert(level.var_eb10c6a7[self.team] >= 0);

    if(level.var_eb10c6a7[self.team] < 0) {
      level.var_eb10c6a7[self.team] = 0;
    }
  } else if(isDefined(self.ownerentnum)) {
    level.var_eb10c6a7[self.ownerentnum]--;
    assert(level.var_eb10c6a7[self.ownerentnum] >= 0);

    if(level.var_eb10c6a7[self.ownerentnum] < 0) {
      level.var_eb10c6a7[self.ownerentnum] = 0;
    }
  }

  assert(isDefined(self.ownerentnum));
  level.var_42ce45d5[self.ownerentnum]--;
  assert(level.var_42ce45d5[self.ownerentnum] >= 0);
  level notify(#"hash_25b529a667fde073");
}

function function_bde85071() {
  level endon(#"game_ended");

  while(true) {
    level waittill(#"hash_25b529a667fde073");

    if(level.teambased) {
      foreach(team, _ in level.teams) {
        var_eb10c6a7 = level.var_eb10c6a7[team];
        var_a06a125 = var_eb10c6a7 + (isDefined(level.activeuavs) && isDefined(level.activeuavs[team]) ? level.activeuavs[team] : 0);
        function_e72ac8f4(team, var_eb10c6a7 > 0);
        util::set_team_radar(team, var_a06a125 > 0);
      }

      continue;
    }

    for(i = 0; i < level.players.size; i++) {
      function_65f48f1a(level.players[i]);
    }
  }
}

function function_65f48f1a(player) {
  if(!isDefined(player.entnum)) {
    player.entnum = player getentitynumber();
  }

  var_eb10c6a7 = level.var_eb10c6a7[player.entnum];
  var_a06a125 = var_eb10c6a7 + (isDefined(level.activeuavs) && isDefined(level.activeuavs[player.team]) ? level.activeuavs[player.team] : 0);
  player setclientuivisibilityflag("radar_client", var_a06a125 > 0);
  player.var_83266838 = var_eb10c6a7 > 0;
}

function killstreakdamagemodifier(damage, attacker, direction, point, smeansofdeath, tagname, modelname, partname, weapon, flags, inflictor, chargelevel) {
  if(chargelevel == "MOD_PROJECTILE_SPLASH") {
    return 0;
  }

  return inflictor;
}