/**************************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: killstreaks\ultimate_turret_shared.gsc
**************************************************/

#using scripts\core_common\battlechatter;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\challenges_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\gameobjects_shared;
#using scripts\core_common\influencers_shared;
#using scripts\core_common\placeables;
#using scripts\core_common\player\player_shared;
#using scripts\core_common\player\player_stats;
#using scripts\core_common\popups_shared;
#using scripts\core_common\targetting_delay;
#using scripts\core_common\turret_shared;
#using scripts\core_common\util_shared;
#using scripts\core_common\values_shared;
#using scripts\core_common\vehicle_ai_shared;
#using scripts\core_common\vehicle_shared;
#using scripts\core_common\visionset_mgr_shared;
#using scripts\killstreaks\killstreak_bundles;
#using scripts\killstreaks\killstreak_dialog;
#using scripts\killstreaks\killstreak_hacking;
#using scripts\killstreaks\killstreakrules_shared;
#using scripts\killstreaks\killstreaks_shared;
#using scripts\killstreaks\killstreaks_util;
#using scripts\killstreaks\remote_weapons;
#using scripts\weapons\deployable;
#using scripts\weapons\weaponobjects;
#namespace ultimate_turret;

function init_shared() {
  if(!isDefined(level.ultimate_turret_shared)) {
    level.ultimate_turret_shared = {};
    bundlename = "killstreak_ultimate_turret";

    if(sessionmodeiswarzonegame()) {
      bundlename += "_wz";
    }

    if(sessionmodeiszombiesgame()) {
      bundlename += "_zm";
    }

    killstreaks::register_killstreak(bundlename, &activateturret);
    killstreaks::function_d8c32ca4("ultimate_turret", &function_a385666);
    clientfield::register("vehicle", "ultimate_turret_open", 1, 1, "int");
    clientfield::register("vehicle", "ultimate_turret_init", 1, 1, "int");
    clientfield::register("vehicle", "ultimate_turret_close", 1, 1, "int");
    clientfield::register_clientuimodel("hudItems.ultimateTurretCount", 1, 3, "int");

    if(sessionmodeiswarzonegame()) {
      vehicle_name = "veh_ultimate_turret" + "_wz";
    } else if(sessionmodeiszombiesgame()) {
      vehicle_name = "veh_ultimate_turret" + "_zm";
    } else if(sessionmodeiscampaigngame()) {
      vehicle_name = "veh_ultimate_turret" + "_cp";
    } else {
      vehicle_name = "veh_ultimate_turret";
    }

    vehicle::add_main_callback(vehicle_name, &initturret);
    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    weaponobjects::function_e6400478(#"ultimate_turret", &function_305bbc35, undefined);
    weaponobjects::function_e6400478(#"inventory_ultimate_turret", &function_305bbc35, undefined);
    level.var_43e52789 = 0;
    deployable::register_deployable(getweapon("ultimate_turret"), undefined);
    callback::on_finalize_initialization(&function_1c601b99);
  }
}

function function_a385666(slot) {
  assert(slot != 3);

  if(!isDefined(self.pers[# "hash_55c15f9af76e4e68"][slot])) {
    return false;
  }

  used_time = self.pers[# "hash_55c15f9af76e4e68"][slot];

  if(used_time == 0) {
    return false;
  }

  bundle = killstreaks::get_script_bundle("ultimate_turret");
  return used_time < bundle.ksduration;
}

function function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon("ultimate_turret"), &function_bff5c062);
  }

  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](getweapon("ultimate_turret"), &function_127fb8f3);
  }
}

function function_127fb8f3(turret, attackingplayer) {
  if(isalive(turret)) {
    turret turretsettargetangles(0, (90, 0, 0));
    turret notify(#"fire_stop");

    if(isDefined(level.var_86e3d17a) && turret.classname == "script_vehicle") {
      _station_up_to_detention_center_triggers = [[level.var_86e3d17a]]() * 1000;

      if(_station_up_to_detention_center_triggers > 0) {
        turret notify(#"cancel_timeout");
        turret thread killstreaks::waitfortimeout("ultimate_turret", _station_up_to_detention_center_triggers, &function_be04d904, "delete", "death");
      }

      if(isDefined(level.var_1794f85f)) {
        [[level.var_1794f85f]](attackingplayer, "disrupted_sentry");
      }

      turret clientfield::set("enemyvehicle", 0);
    }
  }
}

function function_4dc2eebb(stunned) {
  if(stunned === 1) {
    self setturretspinning(0);
    self.var_73998811 = undefined;
    self.e_current_target = undefined;
    self.var_c27dadc8 = undefined;
  }
}

function function_bff5c062(turret, attackingplayer) {
  turret function_3a9dddac();

  if(isDefined(turret.turret)) {
    turret.owner weaponobjects::hackerremoveweapon(turret.turret);
  }

  turret.owner = attackingplayer;
  turret.team = attackingplayer.team;
  turret setowner(attackingplayer);
  turret setteam(attackingplayer.team);
  turret.isjammed = 0;

  if(turret.classname == "script_vehicle") {
    if(isDefined(level.var_f1edf93f)) {
      _station_up_to_detention_center_triggers = int([[level.var_f1edf93f]]() * 1000);

      if(isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
        turret notify(#"cancel_timeout");
        turret thread killstreaks::waitfortimeout("ultimate_turret", _station_up_to_detention_center_triggers, &function_be04d904, "delete", "death");
      }
    }

    if(isDefined(level.var_fc1bbaef)) {
      [[level.var_fc1bbaef]](turret);
    }

    turret.spawninfluencers = [];
    turret.spawninfluencers[0] = turret createturretinfluencer("turret");
    turret.spawninfluencers[1] = turret createturretinfluencer("turret_close");
  }

  turret thread turret_watch_owner_events();
}

function on_player_spawned() {
  weapon = getweapon("ultimate_turret");

  if(isDefined(weapon) && !self hasweapon(weapon)) {
    self clientfield::set_player_uimodel("hudItems.ultimateTurretCount", 0);
  }

  self.var_c306ebe3 = undefined;
}

function initturret() {
  turretvehicle = self;
  turretvehicle.dontfreeme = 1;
  turretvehicle.damage_on_death = 0;
  turretvehicle.delete_on_death = undefined;
  turretvehicle.maxhealth = 2000;
  turretvehicle.damagetaken = 0;
  tablehealth = killstreak_bundles::get_max_health("ultimate_turret");

  if(isDefined(tablehealth)) {
    turretvehicle.maxhealth = tablehealth;
  }

  turretvehicle.health = turretvehicle.maxhealth;
  turretvehicle turretsetontargettolerance(0, 15);
  turretvehicle clientfield::set("enemyvehicle", 1);
  turretvehicle.soundmod = "mini_turret";
  turretvehicle.overridevehicledamage = &onturretdamage;
  turretvehicle.overridevehiclekilled = &onturretdeath;
}

function activateturret(killstreaktype) {
  player = self;
  assert(isPlayer(player));

  if(isDefined(player.var_c306ebe3)) {
    return false;
  }

  killstreakid = self killstreakrules::killstreakstart(killstreaktype, player.team, 0, 0);

  if(killstreakid == -1) {
    return false;
  }

  if(level.var_43e52789) {
    return false;
  }

  bundle = killstreaks::get_script_bundle("ultimate_turret");
  var_b6c61913 = 0;

  if(var_b6c61913) {
    turret = player killstreaks::function_8cd96439(killstreaktype, killstreakid, &onplaceturret, &oncancelplacement, undefined, &onshutdown, undefined, undefined, "tag_origin", "tag_origin", "tag_origin", 1, #"killstreak_sentry_turret_pickup", bundle.ksduration, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint);
    turret thread watchturretshutdown(player, killstreakid, player.team, killstreaktype);
    turret thread util::ghost_wait_show_to_player(player);
    turret.othermodel thread util::ghost_wait_show_to_others(player);
    turret clientfield::set("ultimate_turret_init", 1);
    turret.othermodel clientfield::set("ultimate_turret_init", 1);
    event = turret waittill(#"placed", #"cancelled", #"death");

    if(event._notify != "placed") {
      return false;
    }

    return true;
  }

  turret_team = player.team;
  player.var_c306ebe3 = killstreakid;
  player sethintstring("MP/SENTRY_DEPLOY");

  if(false) {
    var_e454da90 = getweapon(#"ultimate_turret_deploy");

    if(var_e454da90 == level.weaponnone) {
      return false;
    }

    player giveweapon(var_e454da90);
    slot = player gadgetgetslot(var_e454da90);
    player gadgetpowerreset(slot);
    player gadgetpowerset(slot, 100);
    waitresult = player waittilltimeout(0.1, #"death");

    if(!isDefined(waitresult._notify) || waitresult._notify == "death") {
      if(isDefined(player)) {
        player.var_c306ebe3 = undefined;
        player.var_9e10e827 = 1;
      }

      killstreakrules::killstreakstop(killstreaktype, turret_team, killstreakid);

      if(isDefined(player)) {
        player sethintstring("");
      }

      return false;
    }

    player switchtoweapon(var_e454da90);
    player setoffhandvisible(1);
    waitresult = player waittill(#"death", #"weapon_change");

    if(!isDefined(waitresult._notify) || waitresult._notify == "death") {
      if(isDefined(player)) {
        player setoffhandvisible(0);
        player.var_c306ebe3 = undefined;
        player.var_9e10e827 = 1;
      }

      killstreakrules::killstreakstop(killstreaktype, turret_team, killstreakid);

      if(isDefined(player)) {
        player sethintstring("");
      }

      return false;
    }
  }

  player.var_5e6eba64 = 1;
  player val::set(#"ultimate_turret", "disable_offhand_weapons");

  if(isDefined(level.var_ed417bb9)) {
    waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_change", #"weapon_fired", #"executionstart");
  }

  waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_change", #"weapon_fired", #"executionstart");

  if(waitresult._notify === "weapon_change" && waitresult.last_weapon === var_e454da90 && waitresult.weapon === level.weaponnone) {
    waitresult = player waittilltimeout(2, #"ultimate_turret_deployed", #"death");
  } else if(waitresult._notify === "weapon_change" && waitresult.weapon === var_e454da90) {
    waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_fired");
  } else if(waitresult._notify === "executionstart") {
    player switchtoweaponimmediate();
  }

  if(isDefined(player) && false) {
    player takeweapon(var_e454da90);
  }

  if(waitresult._notify === "weapon_fired") {
    waitresult = player waittill(#"ultimate_turret_deployed", #"death");
  }

  if(isDefined(player)) {
    player.var_5e6eba64 = undefined;
    player val::reset(#"ultimate_turret", "disable_offhand_weapons");
    player sethintstring("");
  }

  if(!isDefined(waitresult._notify) || waitresult._notify != "ultimate_turret_deployed") {
    if(isDefined(player)) {
      player setoffhandvisible(0);
      player.var_c306ebe3 = undefined;
    }

    self.var_9e10e827 = 1;
    killstreakrules::killstreakstop(killstreaktype, turret_team, killstreakid);
    weapon = killstreaks::get_killstreak_weapon(killstreaktype);
    killstreaks::change_killstreak_quantity(weapon, 1);
    return false;
  }

  if(waitresult._notify == "ultimate_turret_deployed" && isDefined(waitresult.turret)) {
    waitresult.turret thread watchturretshutdown(player, waitresult.turret.killstreakid, player.team, killstreaktype);
  }

  return true;
}

function function_305bbc35(watcher) {
  watcher.onspawn = &function_3be2d17f;
  watcher.ondamage = &function_7fe1590b;
}

function function_3be2d17f(watcher, player) {
  player endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self endon(#"death");
  slot = player gadgetgetslot(self.weapon);
  player gadgetpowerreset(slot);
  player gadgetpowerset(slot, 0);
  self weaponobjects::onspawnuseweaponobject(watcher, player);
  self hide();
  self notsolid();
  self.canthack = 1;
  self.ignoreemp = 1;
  var_83ed455 = 0;

  if(var_83ed455 && isDefined(player)) {
    player val::set(#"ultimate_turret", "freezecontrols");
  }

  self waittill(#"stationary");
  self deployable::function_dd266e08(player);
  self.origin += (0, 0, 2);
  player onplaceturret(self);
  killstreakslot = self.vehicle.killstreakslot;
  self.killstreakslot = killstreakslot;
  usedtime = player.pers[# "hash_55c15f9af76e4e68"][killstreakslot];

  if(!isDefined(usedtime) || usedtime <= 0) {
    player stats::function_e24eec31(getweapon("ultimate_turret"), #"used", 1);
  }

  player.pers[# "hash_55c15f9af76e4e68"][killstreakslot] = 0;
  player stats::function_e24eec31(self.weapon, #"used", 1);
  player notify(#"ultimate_turret_deployed", {
    #turret: self
  });

  if(var_83ed455 && isDefined(player)) {
    player val::reset(#"ultimate_turret", "freezecontrols");
  }

  if(!isDefined(player.var_85988a58)) {
    player.var_85988a58 = [];
  }

  if(!isDefined(player.var_85988a58)) {
    player.var_85988a58 = [];
  } else if(!isarray(player.var_85988a58)) {
    player.var_85988a58 = array(player.var_85988a58);
  }

  player.var_85988a58[player.var_85988a58.size] = self.vehicle;
  player clientfield::set_player_uimodel("hudItems.ultimateTurretCount", player.var_85988a58.size);

  if(isDefined(self.weapon) && isDefined(self.vehicle)) {
    self.vehicle thread weaponobjects::function_d9c08e94(self.weapon.fusetime, &function_21f16a35);
    self thread function_b649601a();
  }

  self ghost();
  self thread function_24910d60();
  self.vehicle thread function_7f9eb7f();
  self.vehicle.var_1f13c7f1 = getweapon(#"ultimate_turret").var_1f13c7f1;
}

function function_b649601a() {
  self.vehicle endon(#"death");
  self.vehicle clientfield::set("ultimate_turret_init", 1);
  wait 0.25;
  self.vehicle clientfield::set("ultimate_turret_open", 1);
}

function function_24910d60() {
  vehicle = self.vehicle;
  waitresult = self waittill(#"death");

  if(waitresult._notify != "death") {
    return;
  }

  if(isDefined(self)) {
    self.var_d02ddb8e = waitresult.weapon;
  }

  if(isDefined(vehicle)) {
    vehicle function_59ce22f9(undefined, undefined);
  }
}

function function_7f9eb7f() {
  owner = self.owner;
  owner endon(#"disconnect");
  waitresult = self waittill(#"death", #"death_started");

  if(!isDefined(self)) {
    arrayremovevalue(owner.var_85988a58, undefined);
  } else if(self.damagetaken > self.health) {
    arrayremovevalue(owner.var_85988a58, self);
    self.owner luinotifyevent(#"hash_126effa63f6e04bd");
  }

  owner clientfield::set_player_uimodel("hudItems.ultimateTurretCount", owner.var_85988a58.size);
}

function private function_9813d292() {
  if(isDefined(self)) {
    badplace_delete("ultimate_turret_badplace" + self getentitynumber());
  }
}

function private function_d2d0a813(var_24e0878b) {
  var_3b0688ef = "ultimate_turret_badplace" + self getentitynumber();
  badplaceorigin = self.origin + self getboundsmidpoint();
  var_e5afa076 = self getboundshalfsize();
  var_921c5821 = max(var_e5afa076[0], var_e5afa076[1]) + 10;
  var_e5afa076 = (var_921c5821, var_921c5821, var_e5afa076[2]);

  if(var_24e0878b === 1) {
    badplace_cylinder(var_3b0688ef, 0, badplaceorigin, var_921c5821, var_e5afa076[2] * 2, "all");
    return;
  }

  badplace_box(var_3b0688ef, 0, badplaceorigin, var_e5afa076, "all");
}

function onplaceturret(turret) {
  player = self;
  assert(isPlayer(player));

  if(isDefined(turret.vehicle)) {
    turret.vehicle.origin = turret.origin;
    turret.vehicle.angles = turret.angles;
    turret.vehicle thread util::ghost_wait_show(0.05);
    turret.vehicle playSound(#"mpl_turret_startup");
  } else {
    if(sessionmodeiswarzonegame()) {
      vehicle_name = "veh_ultimate_turret" + "_wz";
    } else if(sessionmodeiszombiesgame()) {
      vehicle_name = "veh_ultimate_turret" + "_zm";
    } else if(sessionmodeiscampaigngame()) {
      vehicle_name = "veh_ultimate_turret" + "_cp";
    } else {
      vehicle_name = "veh_ultimate_turret";
    }

    turret.vehicle = spawnvehicle(vehicle_name, turret.origin, turret.angles, "dynamic_spawn_ai");
    turret.vehicle.owner = player;
    turret.vehicle setowner(player);
    turret.vehicle.ownerentnum = player.entnum;
    turret.vehicle.parentstruct = turret;
    turret.vehicle.controlled = 0;
    turret.vehicle.treat_owner_damage_as_friendly_fire = 1;
    turret.vehicle.ignore_team_kills = 1;
    turret.vehicle.deal_no_crush_damage = 1;
    turret.vehicle.turret = turret;
    turret.killstreakid = player.var_c306ebe3;
    player.var_c306ebe3 = undefined;
    turret.vehicle.killstreakid = turret.killstreakid;
    turret.killstreakref = "ultimate_turret";
    turret.vehicle.team = player.team;
    turret.vehicle setteam(player.team);
    turret.vehicle turret::set_team(player.team, 0);
    turret.vehicle turret::set_torso_targetting(0);
    turret.vehicle turret::set_target_leading(0);
    turret.vehicle.use_non_teambased_enemy_selection = 1;
    turret.vehicle.waittill_turret_on_target_delay = 0.25;
    turret.vehicle.ignore_vehicle_underneath_splash_scalar = 1;
    turret.vehicle killstreaks::configure_team("ultimate_turret", turret.killstreakid, player, undefined);
    turret.vehicle killstreak_hacking::enable_hacking("ultimate_turret", &hackedcallbackpre, &hackedcallbackpost);

    if(!isDefined(turret.vehicle.killstreakslot)) {
      turret.vehicle.killstreakslot = 3;
    }

    var_42f0dc61 = player.pers[# "hash_38fcd8992f6cb9dc"][turret.vehicle.killstreakslot];

    if(isDefined(var_42f0dc61) && var_42f0dc61 > 0) {
      turret.vehicle dodamage(var_42f0dc61, self.origin);
      player.pers[# "hash_38fcd8992f6cb9dc"][turret.vehicle.killstreakslot] = 0;
    }

    turret.vehicle thread turret_watch_owner_events();
    turret.vehicle thread turret_laser_watch();
    turret.vehicle thread setup_death_watch_for_new_targets();
    turret.vehicle thread function_31477582();
    turret.vehicle.spawninfluencers = [];
    turret.vehicle.spawninfluencers[0] = turret.vehicle createturretinfluencer("turret");
    turret.vehicle.spawninfluencers[1] = turret.vehicle createturretinfluencer("turret_close");
    turret.vehicle thread util::ghost_wait_show(0.05);
    turret.vehicle.var_63d65a8d = "arc";
    turret.vehicle.var_7eb3ebd5 = [];
    turret.vehicle util::make_sentient();
    turret.vehicle function_bc7568f1();
    turret.vehicle.var_aac73d6c = 1;
    player killstreak_dialog::play_killstreak_start_dialog("ultimate_turret", player.pers[# "team"], turret.killstreakid);
    level thread popups::displaykillstreakteammessagetoall("ultimate_turret", player);
    usedtime = isDefined(player.pers[# "hash_55c15f9af76e4e68"][turret.vehicle.killstreakslot]) ? player.pers[# "hash_55c15f9af76e4e68"][turret.vehicle.killstreakslot] : 0;

    if(usedtime <= 0) {
      player stats::function_e24eec31(getweapon("ultimate_turret"), #"used", 1);
    }

    bundle = killstreaks::get_script_bundle("ultimate_turret");
    turret.vehicle.killstreak_duration = bundle.ksduration + 5000;
    starttimeoverride = gettime() - usedtime;
    turret.vehicle.killstreak_end_time = starttimeoverride + turret.vehicle.killstreak_duration;
    turret.vehicle thread killstreaks::function_b86397ae("ultimate_turret", turret.vehicle.killstreak_duration, starttimeoverride, &function_be04d904, "delete", "death");
    turret.vehicle.maxsightdistsqrd = 1;
    callback::callback(#"hash_6d9bdacc6c29cfa5", {
      #turret: turret, #owner: self
    });
  }

  player deployable::function_6ec9ee30(turret.vehicle, getweapon("ultimate_turret"));
  turret.vehicle playLoopSound(#"hash_69240c6db92da5bf", 0.25);

  foreach(player in level.players) {
    turret.vehicle respectnottargetedbysentryperk(player);
  }

  turret.vehicle.turret_enabled = 1;
  target_set(turret.vehicle);
  turret.vehicle unlink();
  turret.vehicle.var_4dc2eebb = &function_4dc2eebb;
  turret.vehicle function_d2d0a813();
  trigger_origin = turret.origin + (0, 0, 15);
  trigger = spawn("trigger_radius_use", trigger_origin, 0, 85, 85);
  trigger.str_hint = # "hash_2c90cbfdfac140bf";
  trigger setteamfortrigger(self.team);
  trigger setinvisibletoall();
  trigger setvisibletoplayer(self);
  trigger usetriggerignoreuseholdtime();
  trigger function_268e4500();
  trigger function_4bf6de9a(0);
  trigger.var_a865c2cd = 0;
  self clientclaimtrigger(trigger);
  gameobject = gameobjects::create_use_object(self.team, trigger, [], (0, 0, 0), undefined, 1);
  gameobject gameobjects::set_use_time(1);
  gameobject gameobjects::set_visible(#"group_all");
  gameobject gameobjects::allow_use(#"group_friendly");
  gameobject gameobjects::set_onbeginuse_event(&onbeginuse);
  gameobject gameobjects::set_onenduse_event(&onenduse);
  gameobject gameobjects::set_onuse_event(&function_ff9ee951);
  gameobject.requireslos = 1;
  gameobject.turret = turret;
  turret.vehicle.gameobject = gameobject;
  bundle = killstreaks::get_script_bundle("ultimate_turret");

  if(!is_true(turret.vehicle.var_4a64e878)) {
    turret.vehicle clientfield::set("scorestreakActive", 1);
  }

  turret.vehicle thread vehicle::watch_freeze_on_flash(isDefined(bundle.var_64a2db03) ? bundle.var_64a2db03 : 3);

  if(isDefined(level.var_a3ec798a)) {
    turret.vehicle thread[[level.var_a3ec798a]]();
  } else {
    turret.vehicle thread turretscanning();
  }

  turret.vehicle thread function_fefefcc4();
  turret.vehicle thread targetting_delay::function_7e1a12ce(bundle.var_2aeadfa0);
  player notify(#"ultimate_turret_deployed", {
    #turret: turret.vehicle
  });
}

function onbeginuse(player) {
  self.trigger sethintstring("");

  if(isPlayer(player)) {
    player.var_fd61a0f4 = 1;
  }
}

function onenduse(team, player, success) {
  self.trigger sethintstring(#"hash_2c90cbfdfac140bf");

  if(isPlayer(success)) {
    success.var_fd61a0f4 = undefined;
  }
}

function function_ff9ee951(player) {
  turret = self.turret;
  vehicle = turret.vehicle;

  if(!isDefined(vehicle)) {
    return;
  }

  slot = vehicle.killstreakslot;

  if(!isDefined(slot)) {
    slot = 3;
    vehicle.killstreakslot = slot;
  }

  elapsedtime = gettime() - vehicle.killstreak_end_time + vehicle.killstreak_duration;
  player killstreaks::function_a831f92c(slot, 0, 0);
  killstreaktype = turret.weapon.name;

  if(slot != 3) {
    player killstreaks::change_killstreak_quantity(turret.weapon, 1);
  } else {
    if(isDefined(level.var_a27256f0)) {
      player[[level.var_a27256f0]](killstreaktype);
    }

    if(is_true(getgametypesetting(#"useitemspawns")) && is_true(getgametypesetting(#"hash_1cc3f98086d6f5dd"))) {
      player killstreaks::give(killstreaktype);
    } else if(!is_true(getgametypesetting(#"useitemspawns"))) {
      player killstreaks::give(killstreaktype);
    }
  }

  player.pers[# "hash_55c15f9af76e4e68"][slot] = elapsedtime;
  player.pers[# "hash_38fcd8992f6cb9dc"][slot] = vehicle.damagetaken;
  vehicle playSound(#"hash_9587de6d97f0f90");
  vehicle stoploopsound(0.5);
  vehicle function_3a9dddac();
  vehicle function_9813d292();
  vehicle delete();

  if(isDefined(turret)) {
    turret notify(#"ultimate_turret_shutdown");
    turret delete();
  }

  if(isDefined(self)) {
    self gameobjects::destroy_object(1, undefined, 1);
  }
}

function respectnottargetedbysentryperk(player) {
  if(!isPlayer(player)) {
    return;
  }

  turretvehicle = self;
  turretvehicle setignoreent(player, player hasperk(#"specialty_nottargetedbysentry"));
}

function hackedcallbackpre(hacker) {
  turretvehicle = self;
  turretvehicle clientfield::set("enemyvehicle", 2);
  turretvehicle.owner clientfield::set_to_player("static_postfx", 0);

  if(turretvehicle.controlled === 1) {
    visionset_mgr::deactivate("visionset", "turret_visionset", turretvehicle.owner);
  }

  turretvehicle.owner remote_weapons::removeandassignnewremotecontroltrigger(turretvehicle.usetrigger);
  turretvehicle remote_weapons::endremotecontrolweaponuse(1);
  turretvehicle.owner unlink();
  turretvehicle clientfield::set("vehicletransition", 0);
}

function hackedcallbackpost(hacker) {
  turretvehicle = self;
  hacker remote_weapons::useremoteweapon(turretvehicle, "ultimate_turret", 0);
  turretvehicle notify(#"watchremotecontroldeactivate_remoteweapons");
  turretvehicle.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(turretvehicle);
}

function play_deploy_anim_after_wait(wait_time) {
  turret = self;
  turret endon(#"death");
  wait wait_time;
  turret play_deploy_anim();
}

function play_deploy_anim() {
  turret = self;
  turret clientfield::set("ultimate_turret_close", 0);
  turret.othermodel clientfield::set("ultimate_turret_close", 0);

  if(isDefined(turret.vehicle)) {
    turret.vehicle clientfield::set("ultimate_turret_open", 1);
  }
}

function oncancelplacement(turret) {
  if(isDefined(turret)) {
    turret notify(#"ultimate_turret_shutdown");
  }
}

function onpickupturret(turret) {
  player = self;
  turret.vehicle ghost();
  turret.vehicle.turret_enabled = 0;
  turret.vehicle linkto(turret);
  target_remove(turret.vehicle);
  turret clientfield::set("ultimate_turret_close", 1);
  turret.othermodel clientfield::set("ultimate_turret_close", 1);

  if(isDefined(turret.vehicle)) {
    turret.vehicle notify(#"end_turret_scanning");
    turret.vehicle turretsettargetangles(0, (0, 0, 0));
    turret.vehicle clientfield::set("ultimate_turret_open", 0);

    if(isDefined(turret.vehicle.usetrigger)) {
      turret.vehicle.usetrigger delete();
      turret.vehicle playSound(#"mpl_turret_down");
    }

    turret.vehicle vehicle::connect_paths();
    turret.vehicle stoploopsound(0.5);
  }
}

function function_7fe1590b(s_watcher) {}

function onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  empdamage = int(shitloc + self.healthdefault * 1 + 0.5);
  var_820fb5ae = self.damagetaken;
  shitloc = self killstreaks::ondamageperweapon("ultimate_turret", vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1);
  self.damagetaken += shitloc;

  if(self.damagetaken > self.maxhealth && !isDefined(self.will_die)) {
    self.will_die = 1;

    if(isDefined(self.owner)) {
      if(isDefined(damagefromunderneath)) {
        self.owner killstreaks::function_4aad9803(self.killstreaktype, self.killstreakid, damagefromunderneath);
      }

      self.owner killstreaks::function_e9873ef7(self.killstreaktype, self.killstreakid, #"streak_destroyed");
    }

    self thread ondeathafterframeend(vpoint, vdir, shitloc, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal);
  } else {
    bundle = killstreaks::get_script_bundle("ultimate_turret");

    if(isDefined(vpoint) && isvehicle(vpoint) && issentient(vpoint)) {
      if(is_valid_target(vpoint)) {
        self.favoriteenemy = vpoint;
        self.var_c8072bcc = gettime();
        self.var_7eb3ebd5[vpoint getentitynumber()] = # "damage";
        self targetting_delay::function_a4d6d6d8(vpoint);
      }
    } else if(isalive(vdir) && issentient(vdir) && !(isPlayer(vdir) && vdir isremotecontrolling()) && is_valid_target(vdir)) {
      self.favoriteenemy = vdir;
      self.var_c8072bcc = gettime();
      self.var_7eb3ebd5[vdir getentitynumber()] = # "damage";
      self targetting_delay::function_a4d6d6d8(vdir);
    }
  }

  return shitloc;
}

function onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

function ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  waittillframeend();

  if(isDefined(self)) {
    self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
}

function ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  turretvehicle = self;
  turretvehicle notify(#"death_started");

  if(turretvehicle.dead === 1) {
    return;
  }

  turretvehicle.dead = 1;
  turretvehicle disabledriverfiring(1);
  turretvehicle.turret_enabled = 0;
  turretvehicle vehicle::connect_paths();

  if(isDefined(turretvehicle.gameobject)) {
    turretvehicle.gameobject gameobjects::destroy_object(1, undefined, 1);
  }

  shitloc = self[[level.figure_out_attacker]](shitloc);

  if(isDefined(turretvehicle.parentstruct)) {
    turretvehicle.parentstruct placeables::forceshutdown();

    if(turretvehicle.parentstruct.killstreaktimedout === 1 && isDefined(turretvehicle.owner)) {
      if(isDefined(level.var_729a0937)) {
        turretvehicle.owner[[level.var_729a0937]](turretvehicle.parentstruct.killstreaktype);
      }
    } else if(isDefined(shitloc) && isDefined(turretvehicle.owner) && shitloc != turretvehicle.owner) {
      turretvehicle.parentstruct killstreak_dialog::play_destroyed_dialog_on_owner(turretvehicle.killstreaktype, turretvehicle.killstreakid);

      if(isPlayer(shitloc) && isDefined(level.var_bbc796bf)) {
        self[[level.var_bbc796bf]](shitloc, psoffsettime);
      }
    }
  }

  if(isPlayer(shitloc) && (!isDefined(self.owner) || self.owner util::isenemyplayer(shitloc))) {
    shitloc challenges::destroyscorestreak(psoffsettime, turretvehicle.controlled, 1, 1);
    shitloc stats::function_dad108fa(#"destroy_turret", 1);
    shitloc stats::function_e24eec31(psoffsettime, #"destroy_turret", 1);
  }

  self battlechatter::function_d2600afc(shitloc, self.owner, self.turretweapon, psoffsettime);
  turretvehicle stoploopsound(0.5);
  turretvehicle playSound("mpl_turret_exp");
  turretvehicle function_3a9dddac();
  turretvehicle function_9813d292();

  if(isDefined(self.owner) && isDefined(level.playequipmentdestroyedonplayer)) {
    self.owner[[level.playequipmentdestroyedonplayer]]();
  }

  var_980fde21 = self.turret;
  wait 0.1;
  turretvehicle ghost();
  turretvehicle notsolid();
  turretvehicle waittilltimeout(2, #"remote_weapon_end");

  if(isDefined(turretvehicle)) {
    while(isDefined(turretvehicle) && (turretvehicle.controlled || !isDefined(turretvehicle.owner))) {
      waitframe(1);
    }

    turretvehicle.dontfreeme = undefined;
    wait 0.5;

    if(isDefined(turretvehicle)) {
      turretvehicle delete();
    }
  }

  if(isDefined(var_980fde21)) {
    var_980fde21 delete();
  }
}

function onshutdown(turret) {
  if(isDefined(turret)) {
    turret notify(#"ultimate_turret_shutdown");
  }
}

function enableturretafterwait(wait_time) {
  self endon(#"death");

  if(isDefined(self.owner)) {
    self.owner endon(#"disconnect", #"joined_team", #"joined_spectators");
  }

  wait wait_time;
  self.turret_enabled = 1;
}

function createturretinfluencer(name) {
  turret = self;
  preset = getinfluencerpreset(name);

  if(!isDefined(preset)) {
    return;
  }

  projected_point = turret.origin + vectorscale(anglesToForward(turret.angles), preset[# "radius"] * 0.7);
  return influencers::create_enemy_influencer(name, turret.origin, turret.team);
}

function function_3a9dddac() {
  if(!isDefined(self.spawninfluencers)) {
    self.spawninfluencers = [];
    return;
  }

  foreach(influencer in self.spawninfluencers) {
    self influencers::remove_influencer(influencer);
  }

  self.spawninfluencers = [];
}

function turret_watch_owner_events() {
  self notify(#"turret_watch_owner_events_singleton");
  self endon(#"turret_watch_owner_events_singleton", #"death");
  self.owner waittill(#"joined_team", #"disconnect", #"joined_spectators");
  self makevehicleusable();
  self.controlled = 0;

  if(isDefined(self.owner)) {
    self.owner unlink();
    self clientfield::set("vehicletransition", 0);
  }

  self makevehicleunusable();

  if(isDefined(self.owner)) {
    self.owner killstreaks::clear_using_remote();
  }

  self.abandoned = 1;
  onshutdown(self);
  self function_21f16a35();
}

function turret_laser_watch() {
  veh = self;
  veh endon(#"death");

  while(true) {
    laser_should_be_on = !veh.controlled && isDefined(veh.enemy) && !is_true(veh.isstunned) && !is_true(veh.isjammed);

    if(laser_should_be_on) {
      if(islaseron(veh) == 0) {
        veh vehicle::enable_laser(1, 0);
      }
    } else if(islaseron(veh)) {
      veh vehicle::enable_laser(0, 0);
    }

    wait 0.25;
  }
}

function setup_death_watch_for_new_targets() {
  turretvehicle = self;
  turretvehicle endon(#"death");

  for(old_target = undefined; true; old_target = waitresult.target) {
    waitresult = turretvehicle waittill(#"has_new_target");

    if(isDefined(old_target)) {
      old_target notify(#"abort_death_watch");
    }

    waitresult.target thread target_death_watch(turretvehicle);
  }
}

function target_death_watch(turretvehicle) {
  target = self;
  target endon(#"abort_death_watch");
  turretvehicle endon(#"death");
  target waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators");
  turretvehicle clearenemy();
}

function function_fefefcc4() {
  veh = self;
  turret_index = 0;
  veh endon(#"death", #"death_started", #"end_turret_scanning");
  wait 0.8;
  bundle = killstreaks::get_script_bundle("ultimate_turret");
  var_beeadda8 = isDefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 300;

  while(true) {
    if(!isDefined(veh.enemy) && !is_true(veh.isstunned) && !is_true(veh.isjammed)) {
      var_beeadda8 = isDefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 300;

      nearby_enemies = getplayers(util::getotherteam(veh.team), veh.origin, var_beeadda8);

      if(nearby_enemies.size > 0) {
        if(veh.var_3413afc5 != # "hash_2d94a5f22d36fc73") {
          veh function_c524c4c8();
        } else {
          foreach(nearby_enemy in nearby_enemies) {
            if(veh cansee(nearby_enemy) == 0) {
              continue;
            }

            if(veh targetting_delay::function_1c169b3a(nearby_enemy) == 0) {
              continue;
            }

            if(veh function_9d86d74c(nearby_enemy)) {
              continue;
            }

            veh.favoriteenemy = nearby_enemy;
            veh.var_c8072bcc = gettime();
            veh.var_7eb3ebd5[nearby_enemy getentitynumber()] = # "hash_47697c94ffb4a5bd";
            break;
          }
        }
      } else if(veh.var_3413afc5 != # "standard_sight") {
        veh function_bc7568f1();
      }
    }

    wait_time = veh.var_3413afc5 == # "standard_sight" ? 0.25 : 0.1;
    wait wait_time;
  }
}

function function_9d86d74c(enemy) {
  fire_origin = self getseatfiringorigin(0);
  fire_angles = self getseatfiringangles(0);
  shoot_at_pos = enemy getshootatpos(self);
  var_6551f24e = anglesToForward(fire_angles);
  target_offset = shoot_at_pos - fire_origin;

  if(lengthsquared(target_offset) < sqr(22) && vectordot(var_6551f24e, target_offset) < 0) {
    return true;
  }

  return false;
}

function function_2034705c(bundle) {
  var_351b3c55 = isDefined(self.enemy) ? max(isDefined(self.enemylastseentime) ? self.enemylastseentime : 0, isDefined(self.var_c8072bcc) ? self.var_c8072bcc : 0) : 0;
  var_c112caa0 = int((isDefined(bundle.var_fa38350a) ? bundle.var_fa38350a : 1) * 1000);

  if(isDefined(self.enemy) && self.var_7eb3ebd5[self.enemy getentitynumber()] === # "damage") {
    var_c112caa0 = int((isDefined(bundle.var_33561c46) ? bundle.var_33561c46 : 3) * 1000);
  }

  return gettime() < var_351b3c55 + var_c112caa0;
}

function function_fc58f46f() {
  veh = self;

  if(isDefined(veh.enemy)) {
    veh.var_c8072bcc = undefined;
    veh.var_7eb3ebd5[veh.enemy getentitynumber()] = undefined;
  }

  veh clearenemy();
  veh.favoriteenemy = undefined;
  veh.turret_target = undefined;
}

function function_bc7568f1() {
  self.sightlatency = 100;
  self.fovcosine = 0.5;
  self.fovcosinebusy = 0.5;
  self.var_3413afc5 = # "standard_sight";
}

function function_c524c4c8() {
  self.sightlatency = 100;
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.var_3413afc5 = # "hash_2d94a5f22d36fc73";
}

function get_target_offset(target) {
  var_8134d046 = -12;
  stance = target getstance();

  if(stance == "prone" || target.laststand === 1) {
    var_8134d046 = -2;
  }

  return (0, 0, var_8134d046);
}

function function_5acbddc8() {
  var_b354a26c = gettime() - (isDefined(self.var_73998811) ? self.var_73998811 : 0);
  var_f4df6b60 = isDefined(self.turretweapon.spinuptime) ? self.turretweapon.spinuptime : 0;
  return var_b354a26c <= var_f4df6b60;
}

function function_b8952a40(e_target) {
  self notify("4de8bd0bc5d0e3ed");
  self endon("4de8bd0bc5d0e3ed");
  veh = self;

  while(isDefined(veh) && isDefined(e_target) && !is_true(veh.isstunned) && !is_true(veh.isjammed)) {
    var_559acfe = e_target getvelocity() * getdvarfloat(#"hash_3a25aaa27558e77b", 0.075);

    if(isPlayer(e_target)) {
      target_offset = get_target_offset(e_target);
      veh turretsettarget(0, e_target, target_offset + var_559acfe);
    } else {
      veh turretsettarget(0, e_target);
    }

    wait 0.1;
  }
}

function function_9ba314a1(e_target) {
  return is_true(e_target.var_2df02a0c);
}

function function_d3bda653(player) {
  if(sessionmodeiszombiesgame()) {
    return (isactor(player) && isalive(player) && !function_9ba314a1(player) && util::function_fbce7263(self.team, player.team) && self cansee(player));
  }

  return isPlayer(player) && isalive(player) && !function_9ba314a1(player) && util::function_fbce7263(self.team, player.team) && !player hasperk(#"hash_37f82f1d672c4870") && self cansee(player) && !player player::is_spawn_protected();
}

function function_8e56c5e3(vehicle) {
  if(sessionmodeiszombiesgame()) {
    return (vehicle !== self && issentient(vehicle) && isalive(vehicle) && !function_9ba314a1(vehicle) && util::function_fbce7263(self.team, vehicle.team) && self cansee(vehicle));
  }

  return vehicle !== self && is_true(vehicle.isplayervehicle) && isalive(vehicle) && !function_9ba314a1(vehicle) && util::function_fbce7263(self.team, vehicle.team) && !isairborne(vehicle) && vehicle getvehoccupants().size > 0 && self cansee(vehicle);
}

function function_4fc16792(var_2d51cbbc) {
  return var_2d51cbbc !== self && isalive(var_2d51cbbc) && is_true(var_2d51cbbc.var_c31213a5) && !function_9ba314a1(var_2d51cbbc) && util::function_fbce7263(self.team, var_2d51cbbc.team) && self cansee(var_2d51cbbc);
}

function is_valid_target(e_target) {
  return function_d3bda653(e_target) || function_8e56c5e3(e_target) || function_4fc16792(e_target);
}

function function_145804c6() {
  var_88fdfe96 = undefined;
  var_1c294f35 = undefined;
  var_ea64b4ce = undefined;

  foreach(entity in getentitiesinradius(self.origin, self.maxsightdistsqrd)) {
    if(function_d3bda653(entity)) {
      var_3c7e6e = spawnStruct();
      var_3c7e6e.entity = entity;
      var_3c7e6e.distancesqrd = distancesquared(entity.origin, self.origin);

      if(!isDefined(var_88fdfe96) || var_3c7e6e.distancesqrd < var_88fdfe96.distancesqrd) {
        var_88fdfe96 = var_3c7e6e;
      }

      continue;
    }

    if(!isDefined(var_88fdfe96) && function_8e56c5e3(entity)) {
      var_6c36b388 = spawnStruct();
      var_6c36b388.entity = entity;
      var_6c36b388.distancesqrd = distancesquared(entity.origin, self.origin);

      if(!isDefined(var_1c294f35) || var_6c36b388.distancesqrd < var_1c294f35.distancesqrd) {
        var_1c294f35 = var_6c36b388;
      }

      continue;
    }

    if(!isDefined(var_88fdfe96) && !isDefined(var_1c294f35) && function_4fc16792(entity)) {
      var_14e2fce2 = spawnStruct();
      var_14e2fce2.entity = entity;
      var_14e2fce2.distancesqrd = distancesquared(entity.origin, self.origin);

      if(!isDefined(var_ea64b4ce) || var_14e2fce2.distancesqrd < var_ea64b4ce.distancesqrd) {
        var_ea64b4ce = var_14e2fce2;
      }
    }
  }

  if(isDefined(var_88fdfe96.entity)) {
    return var_88fdfe96.entity;
  }

  if(isDefined(var_1c294f35.entity)) {
    return var_1c294f35.entity;
  }

  if(isDefined(var_ea64b4ce.entity)) {
    return var_ea64b4ce.entity;
  }

  return undefined;
}

function function_d103a3d0() {
  self.e_current_target = undefined;
  self setturretspinning(0);
  self.var_73998811 = undefined;

  if(isDefined(self.var_c27dadc8)) {
    if(is_valid_target(self.var_c27dadc8)) {
      s_bundle = killstreaks::get_script_bundle("ultimate_turret");
      var_d40890f6 = int((isDefined(s_bundle.var_727c6d73) ? s_bundle.var_727c6d73 : 0.25) * 1000);
      var_19283d8f = int((isDefined(s_bundle.var_498b3f45) ? s_bundle.var_498b3f45 : 0.25) * 1000);
      var_56e8a2aa = isPlayer(self.var_c27dadc8) ? var_d40890f6 : var_19283d8f;

      if(gettime() - self.var_f1c3676 >= var_56e8a2aa) {
        self.e_current_target = self.var_c27dadc8;
        self setturretspinning(1);
        self.var_73998811 = gettime();
        self.var_c27dadc8 = undefined;
        self.var_f1c3676 = undefined;
        return;
      }
    } else {
      self.var_c27dadc8 = undefined;
      self.var_f1c3676 = undefined;
    }

    return;
  }

  self.var_c27dadc8 = function_145804c6();

  if(isDefined(self.var_c27dadc8)) {
    self.var_f1c3676 = gettime();
    self notify(#"ultimate_turret_potential_target_acquired");

    if(!isDefined(self.var_ec2f1ab4) || self.var_ec2f1ab4 + 5000 < gettime()) {
      self playsoundtoteam("mpl_ultimate_turret_lockon", self.team);
      self playsoundtoteam("mpl_ultimate_turret_lockon_enemy", util::getotherteam(self.team));
      self.var_ec2f1ab4 = gettime();
    }
  }
}

function function_16ccb771(e_target) {
  if(!isDefined(e_target)) {
    return;
  }

  if(self function_5acbddc8()) {
    return;
  }

  s_bundle = killstreaks::get_script_bundle("ultimate_turret");
  var_b009f4df = s_bundle.ksburstfiremintime;
  var_b72152c3 = s_bundle.ksburstfiremaxtime;
  var_1d860ae4 = s_bundle.ksburstfiredelaymintime;
  var_f8ba3204 = s_bundle.ksburstfiredelaymaxtime;
  var_108a39a1 = s_bundle.ksburstfireenabled;

  if(var_108a39a1) {
    n_fire_time = var_b009f4df > var_b72152c3 ? var_b009f4df : randomfloatrange(var_b009f4df, var_b72152c3);
    self vehicle_ai::fire_for_time(n_fire_time, 0, e_target);
    var_2da97dc2 = !isDefined(e_target) || !isalive(e_target);

    if(var_1d860ae4 > 0 && !var_2da97dc2) {
      var_91d9f057 = var_1d860ae4 > var_f8ba3204 ? var_1d860ae4 : randomfloatrange(var_1d860ae4, var_f8ba3204);
      waitresult = e_target waittilltimeout(var_91d9f057, #"death", #"disconnect");
      var_2da97dc2 = waitresult._notify === "death";
    }
  } else {
    self vehicle_ai::fire_for_rounds(10, 0, e_target);
    var_2da97dc2 = !isDefined(e_target) || !isalive(e_target);
  }

  if(var_2da97dc2) {
    if(e_target.var_e78602fc === self) {
      self.owner luinotifyevent(#"mini_turret_kill");
      self.owner playsoundtoplayer(#"hash_7ea486136cd776c", self.owner);
    }

    self.turretrotscale = 1;
    wait randomfloatrange(0.05, 0.2);
    self.e_current_target = undefined;
    playFXOnTag(#"hash_226d84a923f14d4d", self, "tag_flash");
    self setturretspinning(0);
    self.var_73998811 = undefined;
  }
}

function aim_at_target(e_target) {
  self childthread function_b8952a40(e_target);
}

function function_9d831b2f() {
  self endon(#"death", #"death_started", #"end_turret_scanning");

  while(true) {
    if(self.isjammed === 1 || self.isstunned === 1) {
      waitframe(1);
      continue;
    }

    if(self.var_942bf052 === "left") {
      self turretsettargetangles(0, (-10, 40, 0));
      self.var_942bf052 = "right";
    } else {
      self turretsettargetangles(0, (-10, -40, 0));
      self.var_942bf052 = "left";
    }

    waitresult = self waittilltimeout(3.5, #"ultimate_turret_potential_target_acquired");

    if(waitresult._notify == "ultimate_turret_potential_target_acquired") {
      while(isDefined(self.var_c27dadc8) || isDefined(self.e_current_target)) {
        wait float(function_60d95f53()) / 1000;
      }
    }
  }
}

function turretscanning() {
  veh = self;
  veh endon(#"death", #"death_started", #"end_turret_scanning");
  wait 0.8;
  veh playSound(#"mpl_turret_startup");
  veh playLoopSound(#"hash_69240c6db92da5bf");
  s_bundle = killstreaks::get_script_bundle("ultimate_turret");
  veh.maxsightdistsqrd = sqr(isDefined(s_bundle.var_2aeadfa0) ? s_bundle.var_2aeadfa0 : 3500);
  veh thread function_9d831b2f();

  while(true) {
    veh.maxsightdistsqrd = sqr(isDefined(s_bundle.var_2aeadfa0) ? s_bundle.var_2aeadfa0 : 3500);

    if(self.isjammed === 1 || self.isstunned === 1) {
      waitframe(1);
      continue;
    }

    if(is_valid_target(veh.e_current_target)) {
      function_16ccb771(veh.e_current_target);
    } else {
      function_d103a3d0();
    }

    aim_at_target(isDefined(veh.var_c27dadc8) ? veh.var_c27dadc8 : veh.e_current_target);
    wait float(function_60d95f53()) / 1000;
  }
}

function turretshutdown(killstreakid, team, killstreaktype) {
  turret = self;

  if(turret.shuttingdown === 1) {
    return;
  }

  if(isDefined(turret)) {
    turret.shuttingdown = 1;
  }

  if(isDefined(self.owner)) {
    slot = self.killstreakslot;
    self.owner function_d5d8e662(slot, 0);
    self.owner killstreaks::function_b3185041(slot, 0);
    var_2fd00bf4 = isDefined(self.owner.pers[# "hash_55c15f9af76e4e68"][slot]) ? self.owner.pers[# "hash_55c15f9af76e4e68"][slot] : 0;

    if(var_2fd00bf4 > 0) {
      self.owner.var_9e10e827 = 1;
      self.var_9e10e827 = 1;
    }
  }

  killstreakrules::killstreakstop(killstreaktype, team, killstreakid);
  deployable::function_81598103(turret);

  if(isDefined(turret.vehicle)) {
    turret.vehicle function_3a9dddac();
  }
}

function watchturretshutdown(player, killstreakid, team, killstreaktype) {
  player endon(#"disconnect", #"joined_team", #"joined_spectators");
  turret = self;
  turret thread function_d6c5b32b(player, killstreakid, team, killstreaktype);
  turret waittill(#"ultimate_turret_shutdown", #"death");
  turretshutdown(killstreakid, team, killstreaktype);
}

function function_d6c5b32b(player, killstreakid, team, killstreaktype) {
  turret = self;
  player waittill(#"disconnect", #"joined_team", #"joined_spectators");

  if(isDefined(turret)) {
    turret turretshutdown(killstreakid, team, killstreaktype);
  }
}

function has_active_enemy(bundle) {
  if(self.var_aac73d6c === 1) {} else if(!isDefined(self.enemylastseentime)) {
    return false;
  }

  if(isDefined(self.favoriteenemy)) {
    if(!isalive(self.favoriteenemy)) {
      return false;
    }

    if(self targetting_delay::function_1c169b3a(self.favoriteenemy) == 0) {
      return false;
    }
  }

  if(isDefined(self.enemy) && self.favoriteenemy !== self.enemy) {
    if(!isalive(self.enemy)) {
      return false;
    }

    if(self targetting_delay::function_1c169b3a(self.enemy) == 0) {
      return false;
    }
  }

  return function_2034705c(bundle);
}

function function_be04d904() {
  onshutdown(self.turret);
  self function_21f16a35();
}

function function_21f16a35() {
  self thread function_59ce22f9(undefined, undefined);
}

function function_59ce22f9(attacker, callback_data) {
  if(!isDefined(self)) {
    return;
  }

  if(self.dead === 1) {
    return;
  }

  bundle = killstreaks::get_script_bundle("ultimate_turret");
  fxpos = isDefined(self gettagorigin("tag_turret")) ? self gettagorigin("tag_turret") : self.origin;

  if(isDefined(bundle.var_8095b472)) {
    playFX(bundle.var_8095b472, fxpos);
  }

  self playSound("mpl_turret_exp");

  if(isDefined(bundle.var_bb6c29b4) && self.var_d02ddb8e === getweapon(#"shock_rifle")) {
    playFX(bundle.var_bb6c29b4, self.origin);
  }

  self stoploopsound(0.5);
  self function_3a9dddac();
  self function_9813d292();
  turret = self.turret;
  var_ac17618b = self.gameobject;
  self delete();
  waittillframeend();

  if(isDefined(turret)) {
    turret delete();
  }

  if(isDefined(var_ac17618b)) {
    var_ac17618b gameobjects::destroy_object(1, undefined, 1);
  }
}

function function_31477582() {
  self endon(#"death");
  waitframe(1);
  var_463c449d = 386.089 * float(function_60d95f53()) / 1000;
  max_delta = 1;

  while(true) {
    if(!isDefined(self.turret)) {
      wait 1;
      continue;
    }

    trace = physicstrace(self.origin + (0, 0, 15), self.origin + (0, 0, -10), (-3, -3, -1), (3, 3, 1), self.turret, 1 | 16);

    if(trace[# "fraction"] > 0) {
      new_origin = trace[# "position"];
      self.origin = (new_origin[0], new_origin[1], self.origin[2] - min(max_delta, self.origin[2] - new_origin[2]));
      max_delta += var_463c449d;
      waitframe(1);
      continue;
    }

    max_delta = 1;
    wait 1;
  }
}

function on_player_killed(params) {
  if(!isDefined(self.var_6ef09a14)) {
    return;
  }

  var_f60ab10f = [];

  foreach(var_69501900 in self.var_6ef09a14) {
    if(!isDefined(var_69501900)) {
      continue;
    }

    if(!isDefined(var_69501900.owner)) {
      continue;
    }

    if(!isDefined(self.var_e78602fc)) {
      continue;
    }

    if(self.var_e78602fc.vehicletype === # "ultimate_turret") {
      continue;
    }

    if(var_69501900.vehicletype === # "ultimate_turret") {
      if(!isDefined(var_f60ab10f)) {
        var_f60ab10f = [];
      } else if(!isarray(var_f60ab10f)) {
        var_f60ab10f = array(var_f60ab10f);
      }

      if(!isinarray(var_f60ab10f, var_69501900.owner)) {
        var_f60ab10f[var_f60ab10f.size] = var_69501900.owner;
      }
    }
  }

  foreach(player in var_f60ab10f) {
    player playsoundtoplayer(#"hash_37ffaa04e3f898fa", player);
  }
}