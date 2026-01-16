/**************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: killstreaks\ultimate_turret_shared.gsc
**************************************************/

#include scripts\core_common\callbacks_shared;
#include scripts\core_common\challenges_shared;
#include scripts\core_common\clientfield_shared;
#include scripts\core_common\influencers_shared;
#include scripts\core_common\placeables;
#include scripts\core_common\player\player_stats;
#include scripts\core_common\popups_shared;
#include scripts\core_common\targetting_delay;
#include scripts\core_common\turret_shared;
#include scripts\core_common\util_shared;
#include scripts\core_common\values_shared;
#include scripts\core_common\vehicle_ai_shared;
#include scripts\core_common\vehicle_shared;
#include scripts\core_common\visionset_mgr_shared;
#include scripts\killstreaks\killstreak_bundles;
#include scripts\killstreaks\killstreak_hacking;
#include scripts\killstreaks\killstreakrules_shared;
#include scripts\killstreaks\killstreaks_shared;
#include scripts\killstreaks\remote_weapons;
#include scripts\weapons\deployable;
#include scripts\weapons\weaponobjects;

#namespace ultimate_turret;

init_shared() {
  if(!isDefined(level.ultimate_turret_shared)) {
    level.ultimate_turret_shared = {};
    killstreaks::register_killstreak("killstreak_ultimate_turret", &activateturret);
    killstreaks::register_alt_weapon("ultimate_turret", getweapon("ultimate_turret_deploy"));
    killstreaks::function_b013c2d3("ultimate_turret", getweapon("ultimate_turret_deploy"));
    killstreaks::register_alt_weapon("ultimate_turret", getweapon(#"gun_ultimate_turret"));
    killstreaks::allow_assists("ultimate_turret", 1);
    level.killstreaks[#"ultimate_turret"].threatonkill = 1;
    clientfield::register("vehicle", "ultimate_turret_open", 1, 1, "int");
    clientfield::register("vehicle", "ultimate_turret_init", 1, 1, "int");
    clientfield::register("vehicle", "ultimate_turret_close", 1, 1, "int");
    clientfield::register("clientuimodel", "hudItems.ultimateTurretCount", 1, 3, "int");

    if(sessionmodeiscampaigngame()) {
      vehicle::add_main_callback("veh_ultimate_turret" + "_cp", &initturret);
    } else {
      vehicle::add_main_callback("veh_ultimate_turret", &initturret);
    }

    callback::on_spawned(&on_player_spawned);
    callback::on_player_killed(&on_player_killed);
    weaponobjects::function_e6400478(#"ultimate_turret", &function_305bbc35, undefined);
    weaponobjects::function_e6400478(#"inventory_ultimate_turret", &function_305bbc35, undefined);
    level.var_43e52789 = 0;
    deployable::register_deployable(getweapon("ultimate_turret"), undefined);
    callback::on_finalize_initialization(&function_1c601b99);
  }
}

function_1c601b99() {
  if(isDefined(level.var_1b900c1d)) {
    [[level.var_1b900c1d]](getweapon("ultimate_turret"), &function_bff5c062);
  }

  if(isDefined(level.var_a5dacbea)) {
    [[level.var_a5dacbea]](getweapon("ultimate_turret"), &function_127fb8f3);
  }
}

function_127fb8f3(turret, attackingplayer) {
  turret.isjammed = 1;

  if(isDefined(level.var_86e3d17a) && turret.classname == "script_vehicle") {
    _station_up_to_detention_center_triggers = [[level.var_86e3d17a]]() * 1000;

    if(_station_up_to_detention_center_triggers > 0) {
      turret notify(#"cancel_timeout");
      turret thread killstreaks::waitfortimeout("ultimate_turret", _station_up_to_detention_center_triggers, &function_be04d904, "delete", "death");
    }

    if(isDefined(level.var_1794f85f)) {
      [
        [level.var_1794f85f]
      ](attackingplayer, "disrupted_sentry");
    }

    turret clientfield::set("enemyvehicle", 0);
  }
}

function_bff5c062(turret, attackingplayer) {
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
      _station_up_to_detention_center_triggers = int([
        [level.var_f1edf93f]
      ]() * 1000);

      if(isDefined(_station_up_to_detention_center_triggers) ? _station_up_to_detention_center_triggers : 0) {
        turret notify(#"cancel_timeout");
        turret thread killstreaks::waitfortimeout("ultimate_turret", _station_up_to_detention_center_triggers, &function_be04d904, "delete", "death");
      }
    }

    if(isDefined(level.var_fc1bbaef)) {
      [
        [level.var_fc1bbaef]
      ](turret);
    }

    turret.spawninfluencers = [];
    turret.spawninfluencers[0] = turret createturretinfluencer("turret");
    turret.spawninfluencers[1] = turret createturretinfluencer("turret_close");
  }

  turret thread turret_watch_owner_events();
}

on_player_spawned() {
  weapon = getweapon("ultimate_turret");

  if(isDefined(weapon) && !self hasweapon(weapon)) {
    self clientfield::set_player_uimodel("hudItems.ultimateTurretCount", 0);
  }

  self.var_c306ebe3 = undefined;
}

initturret() {
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

activateturret() {
  player = self;
  assert(isplayer(player));

  if(isDefined(player.var_c306ebe3)) {
    return false;
  }

  killstreakid = self killstreakrules::killstreakstart("ultimate_turret", player.team, 0, 0);

  if(killstreakid == -1) {
    return false;
  }

  if(level.var_43e52789) {
    return false;
  }

  bundle = level.killstreakbundle[#"ultimate_turret"];
  var_b6c61913 = 0;

  if(var_b6c61913) {
    turret = player killstreaks::function_8cd96439("ultimate_turret", killstreakid, &onplaceturret, &oncancelplacement, undefined, &onshutdown, undefined, undefined, "tag_origin", "tag_origin", "tag_origin", 1, #"killstreak_sentry_turret_pickup", bundle.ksduration, undefined, 0, bundle.ksplaceablehint, bundle.ksplaceableinvalidlocationhint);
    turret thread watchturretshutdown(player, killstreakid, player.team);
    turret thread util::ghost_wait_show_to_player(player);
    turret.othermodel thread util::ghost_wait_show_to_others(player);
    event = turret waittill(#"placed", #"cancelled", #"death");

    if(event._notify != "placed") {
      return false;
    }

    return true;
  }

  turret_team = player.team;
  player.var_c306ebe3 = killstreakid;
  self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 4);

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
      }

      killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
      self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
      return false;
    }

    player switchtoweapon(var_e454da90);
    player setoffhandvisible(1);
    waitresult = player waittill(#"death", #"weapon_change");

    if(!isDefined(waitresult._notify) || waitresult._notify == "death") {
      if(isDefined(player)) {
        player setoffhandvisible(0);
        player.var_c306ebe3 = undefined;
      }

      killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
      self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
      return false;
    }
  }

  if(isDefined(level.var_ed417bb9)) {
    waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_change", #"weapon_fired");
  }

  waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_change", #"weapon_fired");

  if(waitresult._notify === "weapon_change" && waitresult.last_weapon === var_e454da90 && waitresult.weapon === level.weaponnone) {
    waitresult = player waittilltimeout(2, #"ultimate_turret_deployed", #"death");
  } else if(waitresult._notify === "weapon_change" && waitresult.weapon === var_e454da90) {
    waitresult = player waittill(#"ultimate_turret_deployed", #"death", #"weapon_fired");
  }

  if(isDefined(player) && false) {
    player takeweapon(var_e454da90);
  }

  if(waitresult._notify === "weapon_fired") {
    waitresult = player waittill(#"ultimate_turret_deployed", #"death");
  }

  if(isDefined(player)) {
    self clientfield::set_player_uimodel("hudItems.abilityHintIndex", 0);
  }

  if(!isDefined(waitresult._notify) || waitresult._notify != "ultimate_turret_deployed") {
    if(isDefined(player)) {
      player setoffhandvisible(0);
      player.var_c306ebe3 = undefined;
    }

    killstreakrules::killstreakstop("ultimate_turret", turret_team, killstreakid);
    return false;
  }

  if(waitresult._notify == "ultimate_turret_deployed" && isDefined(waitresult.turret)) {
    waitresult.turret thread watchturretshutdown(player, waitresult.turret.killstreakid, player.team);
  }

  player.var_c306ebe3 = undefined;
  return true;
}

function_305bbc35(watcher) {
  watcher.onspawn = &function_3be2d17f;
  watcher.deleteonplayerspawn = 0;
}

function_3be2d17f(watcher, player) {
  player endon(#"death", #"disconnect");
  level endon(#"game_ended");
  self endon(#"death");
  slot = player gadgetgetslot(self.weapon);
  player gadgetpowerreset(slot);
  player gadgetpowerset(slot, 0);
  self weaponobjects::onspawnuseweaponobject(watcher, player);
  self hide();
  self.canthack = 1;
  self.ignoreemp = 1;
  var_83ed455 = 0;

  if(var_83ed455 && isDefined(player)) {
    player val::set(#"ultimate_turret", "freezecontrols");
  }

  self waittill(#"stationary");
  player stats::function_e24eec31(self.weapon, #"used", 1);
  player notify(#"ultimate_turret_deployed", {
    #turret: self
  });
  self deployable::function_dd266e08(player);
  self.origin += (0, 0, 2);
  player onplaceturret(self);

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

function_b649601a() {
  self.vehicle endon(#"death");
  self.vehicle clientfield::set("ultimate_turret_init", 1);
  wait 0.25;
  self.vehicle clientfield::set("ultimate_turret_open", 1);
}

function_24910d60() {
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

function_7f9eb7f() {
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

onplaceturret(turret) {
  player = self;
  assert(isplayer(player));

  if(isDefined(turret.vehicle)) {
    turret.vehicle.origin = turret.origin;
    turret.vehicle.angles = turret.angles;
    turret.vehicle thread util::ghost_wait_show(0.05);
    turret.vehicle playSound(#"mpl_turret_startup");
  } else {
    if(sessionmodeiscampaigngame()) {
      turret.vehicle = spawnvehicle("veh_ultimate_turret" + "_cp", turret.origin, turret.angles, "dynamic_spawn_ai");
    } else {
      turret.vehicle = spawnvehicle("veh_ultimate_turret", turret.origin, turret.angles, "dynamic_spawn_ai");
    }

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
    player killstreaks::play_killstreak_start_dialog("ultimate_turret", player.pers[#"team"], turret.killstreakid);
    level thread popups::displaykillstreakteammessagetoall("ultimate_turret", player);
    player stats::function_e24eec31(getweapon("ultimate_turret"), #"used", 1);
    turret.vehicle.killstreak_duration = level.killstreakbundle[#"ultimate_turret"].ksduration + 5000;
    turret.vehicle.killstreak_end_time = gettime() + turret.vehicle.killstreak_duration;
    bundle = get_killstreak_bundle();
    turret.vehicle thread killstreaks::waitfortimeout("ultimate_turret", turret.vehicle.killstreak_duration, &function_be04d904, "delete", "death");
    turret.vehicle.maxsightdistsqrd = 1;
  }

  player deployable::function_6ec9ee30(turret.vehicle, getweapon("ultimate_turret"));
  turret.vehicle playLoopSound(#"hash_69240c6db92da5bf", 0.25);

  foreach(player in level.players) {
    turret.vehicle respectnottargetedbysentryperk(player);
  }

  turret.vehicle.turret_enabled = 1;
  target_set(turret.vehicle);
  turret.vehicle unlink();
  turret.vehicle vehicle::disconnect_paths(0, 0);
  bundle = get_killstreak_bundle();
  turret.vehicle thread vehicle::watch_freeze_on_flash(3);
  turret.vehicle thread turretscanning();
  turret.vehicle thread function_fefefcc4();
  turret.vehicle thread targetting_delay::function_7e1a12ce(bundle.var_2aeadfa0);
  player notify(#"ultimate_turret_deployed", {
    #turret: turret.vehicle
  });
}

respectnottargetedbysentryperk(player) {
  if(!isplayer(player)) {
    return;
  }

  turretvehicle = self;
  turretvehicle setignoreent(player, player hasperk(#"specialty_nottargetedbysentry"));
}

hackedcallbackpre(hacker) {
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

hackedcallbackpost(hacker) {
  turretvehicle = self;
  hacker remote_weapons::useremoteweapon(turretvehicle, "ultimate_turret", 0);
  turretvehicle notify(#"watchremotecontroldeactivate_remoteweapons");
  turretvehicle.killstreak_end_time = hacker killstreak_hacking::set_vehicle_drivable_time_starting_now(turretvehicle);
}

play_deploy_anim_after_wait(wait_time) {
  turret = self;
  turret endon(#"death");
  wait wait_time;
  turret play_deploy_anim();
}

play_deploy_anim() {
  turret = self;
  turret clientfield::set("auto_turret_close", 0);
  turret.othermodel clientfield::set("auto_turret_close", 0);

  if(isDefined(turret.vehicle)) {
    turret.vehicle clientfield::set("auto_turret_open", 1);
  }
}

oncancelplacement(turret) {
  if(isDefined(turret)) {
    turret notify(#"ultimate_turret_shutdown");
  }
}

onpickupturret(turret) {
  player = self;
  turret.vehicle ghost();
  turret.vheicle.turret_enabled = 0;
  turret.vehicle linkto(turret);
  target_remove(turret.vehicle);
  turret clientfield::set("auto_turret_close", 1);
  turret.othermodel clientfield::set("auto_turret_close", 1);

  if(isDefined(turret.vehicle)) {
    turret.vehicle notify(#"end_turret_scanning");
    turret.vehicle turretsettargetangles(0, (0, 0, 0));
    turret.vehicle clientfield::set("auto_turret_open", 0);

    if(isDefined(turret.vehicle.usetrigger)) {
      turret.vehicle.usetrigger delete();
      turret.vehicle playSound(#"mpl_turret_down");
    }

    turret.vehicle vehicle::connect_paths();
    turret.vehicle stoploopsound(0.5);
  }
}

onturretdamage(einflictor, eattacker, idamage, idflags, smeansofdeath, weapon, vpoint, vdir, shitloc, vdamageorigin, psoffsettime, damagefromunderneath, modelindex, partname, vsurfacenormal) {
  empdamage = int(idamage + self.healthdefault * 1 + 0.5);
  var_820fb5ae = self.damagetaken;
  idamage = self killstreaks::ondamageperweapon("ultimate_turret", eattacker, idamage, idflags, smeansofdeath, weapon, self.maxhealth, undefined, self.maxhealth * 0.4, undefined, empdamage, undefined, 1, 1);
  self.damagetaken += idamage;

  if(self.controlled) {
    self.owner vehicle::update_damage_as_occupant(self.damagetaken, self.maxhealth);
  }

  if(self.damagetaken > self.maxhealth && !isDefined(self.will_die)) {
    self.will_die = 1;
    self thread ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  } else {
    bundle = get_killstreak_bundle();

    if(isDefined(einflictor) && isvehicle(einflictor) && issentient(einflictor)) {
      if(is_valid_target(einflictor, self.team)) {
        self.favoriteenemy = einflictor;
        self.var_c8072bcc = gettime();
        self.var_7eb3ebd5[einflictor getentitynumber()] = #"damage";
        self targetting_delay::function_a4d6d6d8(einflictor);
      }
    } else if(isalive(eattacker) && issentient(eattacker) && !(isplayer(eattacker) && eattacker isremotecontrolling()) && is_valid_target(eattacker, self.team)) {
      self.favoriteenemy = eattacker;
      self.var_c8072bcc = gettime();
      self.var_7eb3ebd5[eattacker getentitynumber()] = #"damage";
      self targetting_delay::function_a4d6d6d8(eattacker);
    }
  }

  return idamage;
}

onturretdeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
}

ondeathafterframeend(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  waittillframeend();

  if(isDefined(self)) {
    self ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime);
  }
}

ondeath(einflictor, eattacker, idamage, smeansofdeath, weapon, vdir, shitloc, psoffsettime) {
  turretvehicle = self;
  turretvehicle notify(#"death_started");

  if(turretvehicle.dead === 1) {
    return;
  }

  turretvehicle.dead = 1;
  turretvehicle disabledriverfiring(1);
  turretvehicle.turret_enabled = 0;
  turretvehicle vehicle::connect_paths();
  eattacker = self[[level.figure_out_attacker]](eattacker);

  if(isDefined(turretvehicle.parentstruct)) {
    turretvehicle.parentstruct placeables::forceshutdown();

    if(turretvehicle.parentstruct.killstreaktimedout === 1 && isDefined(turretvehicle.owner)) {
      if(isDefined(level.var_729a0937)) {
        turretvehicle.owner[[level.var_729a0937]](turretvehicle.parentstruct.killstreaktype);
      }
    } else if(isDefined(eattacker) && isDefined(turretvehicle.owner) && eattacker != turretvehicle.owner) {
      turretvehicle.parentstruct killstreaks::play_destroyed_dialog_on_owner(turretvehicle.killstreaktype, turretvehicle.killstreakid);

      if(isplayer(eattacker) && isDefined(level.var_bbc796bf)) {
        self[[level.var_bbc796bf]](eattacker, weapon);
      }
    }
  }

  if(isDefined(eattacker) && isplayer(eattacker) && (!isDefined(self.owner) || self.owner util::isenemyplayer(eattacker))) {
    eattacker challenges::destroyscorestreak(weapon, turretvehicle.controlled, 1, 0);
    eattacker stats::function_dad108fa(#"destroy_turret", 1);
    eattacker stats::function_e24eec31(weapon, #"destroy_turret", 1);
  }

  if(isDefined(level.var_d2600afc)) {
    self[[level.var_d2600afc]](eattacker, self.owner, self.turretweapon, weapon);
  }

  turretvehicle stoploopsound(0.5);
  turretvehicle playSound("mpl_turret_exp");
  turretvehicle function_3a9dddac();

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

onshutdown(turret) {
  if(isDefined(turret)) {
    turret notify(#"ultimate_turret_shutdown");
  }
}

enableturretafterwait(wait_time) {
  self endon(#"death");

  if(isDefined(self.owner)) {
    self.owner endon(#"disconnect", #"joined_team", #"joined_spectators");
  }

  wait wait_time;
  self.turret_enabled = 1;
}

createturretinfluencer(name) {
  turret = self;
  preset = getinfluencerpreset(name);

  if(!isDefined(preset)) {
    return;
  }

  projected_point = turret.origin + vectorscale(anglesToForward(turret.angles), preset[#"radius"] * 0.7);
  return influencers::create_enemy_influencer(name, turret.origin, turret.team);
}

function_3a9dddac() {
  if(!isDefined(self.spawninfluencers)) {
    self.spawninfluencers = [];
    return;
  }

  foreach(influencer in self.spawninfluencers) {
    self influencers::remove_influencer(influencer);
  }

  self.spawninfluencers = [];
}

turret_watch_owner_events() {
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

turret_laser_watch() {
  veh = self;
  veh endon(#"death");

  while(true) {
    laser_should_be_on = !veh.controlled && isDefined(veh.enemy) && !(isDefined(veh.isstunned) && veh.isstunned) && !(isDefined(veh.isjammed) && veh.isjammed);

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

setup_death_watch_for_new_targets() {
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

target_death_watch(turretvehicle) {
  target = self;
  target endon(#"abort_death_watch");
  turretvehicle endon(#"death");
  target waittill(#"death", #"disconnect", #"joined_team", #"joined_spectators");
  turretvehicle clearenemy();
}

get_killstreak_bundle() {
  return level.killstreakbundle[#"ultimate_turret"];
}

is_valid_target(potential_target, friendly_team) {
  if(isDefined(potential_target)) {
    if(issentient(potential_target) && potential_target.var_d600e174 === 1) {
      return false;
    }

    if(!isDefined(potential_target.team) || potential_target.team == friendly_team) {
      return false;
    }

    return true;
  }

  return false;
}

function_fefefcc4() {
  veh = self;
  turret_index = 0;
  veh endon(#"death", #"death_started", #"end_turret_scanning");
  wait 0.8;
  bundle = get_killstreak_bundle();
  var_beeadda8 = isDefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 300;

  while(true) {
    if(!isDefined(veh.enemy) && !(isDefined(veh.isstunned) && veh.isstunned) && !(isDefined(veh.isjammed) && veh.isjammed)) {

      var_beeadda8 = isDefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 300;

        nearby_enemies = getplayers(util::getotherteam(veh.team), veh.origin, var_beeadda8);

      if(nearby_enemies.size > 0) {
        if(veh.var_3413afc5 != #"hash_2d94a5f22d36fc73") {
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
            veh.var_7eb3ebd5[nearby_enemy getentitynumber()] = #"hash_47697c94ffb4a5bd";
            break;
          }
        }
      } else if(veh.var_3413afc5 != #"standard_sight") {
        veh function_bc7568f1();
      }
    }

    wait_time = veh.var_3413afc5 == #"standard_sight" ? 0.25 : 0.1;
    wait wait_time;
  }
}

function_9d86d74c(enemy) {
  fire_origin = self getseatfiringorigin(0);
  fire_angles = self getseatfiringangles(0);
  shoot_at_pos = enemy getshootatpos(self);
  var_6551f24e = anglesToForward(fire_angles);
  target_offset = shoot_at_pos - fire_origin;

  if(lengthsquared(target_offset) < 22 * 22 && vectordot(var_6551f24e, target_offset) < 0) {
    return true;
  }

  return false;
}

function_2034705c(bundle) {
  var_351b3c55 = isDefined(self.enemy) ? max(isDefined(self.enemylastseentime) ? self.enemylastseentime : 0, isDefined(self.var_c8072bcc) ? self.var_c8072bcc : 0) : 0;
  var_c112caa0 = int((isDefined(bundle.var_fa38350a) ? bundle.var_fa38350a : 1) * 1000);

  if(isDefined(self.enemy) && self.var_7eb3ebd5[self.enemy getentitynumber()] === #"damage") {
    var_c112caa0 = int((isDefined(bundle.var_33561c46) ? bundle.var_33561c46 : 3) * 1000);
  }

  return gettime() < var_351b3c55 + var_c112caa0;
}

function_fc58f46f() {
  veh = self;

  if(isDefined(veh.enemy)) {
    veh.var_c8072bcc = undefined;
    veh.var_7eb3ebd5[veh.enemy getentitynumber()] = undefined;
  }

  veh clearenemy();
  veh.favoriteenemy = undefined;
  veh.turret_target = undefined;
}

function_bc7568f1() {
  self.sightlatency = 100;
  self.fovcosine = 0.5;
  self.fovcosinebusy = 0.5;
  self.var_3413afc5 = #"standard_sight";
}

function_c524c4c8() {
  self.sightlatency = 100;
  self.fovcosine = 0;
  self.fovcosinebusy = 0;
  self.var_3413afc5 = #"hash_2d94a5f22d36fc73";
}

get_target_offset(target) {
  var_8134d046 = -12;
  stance = target getstance();

  if(stance == "prone") {
    var_8134d046 = -2;
  }

  return (0, 0, var_8134d046);
}

function_b8952a40(turret_index) {
  self notify("a8b5c714cb1e6d1");
  self endon("a8b5c714cb1e6d1");
  veh = self;

  while(isDefined(veh.enemy) && !(isDefined(veh.isstunned) && veh.isstunned) && !(isDefined(veh.isjammed) && veh.isjammed)) {
    var_559acfe = veh.enemy getvelocity() * getdvarfloat(#"hash_3a25aaa27558e77b", 0.075);

    if(isplayer(veh.enemy)) {
      target_offset = get_target_offset(veh.enemy);
      veh turretsettarget(turret_index, veh.enemy, target_offset + var_559acfe);
    } else {
      veh turretsettarget(turret_index, veh.enemy, var_559acfe);
    }

    wait 0.1;
  }
}

turretscanning() {
  veh = self;
  veh endon(#"death", #"death_started", #"end_turret_scanning");
  veh.turret_target = undefined;
  veh.do_not_clear_targets_during_think = 1;
  wait 0.8;
  veh playSound(#"mpl_turret_startup");
  veh playLoopSound(#"hash_69240c6db92da5bf");
  bundle = get_killstreak_bundle();
  min_burst_time = bundle.ksburstfiremintime;
  max_burst_time = bundle.ksburstfiremaxtime;
  min_pause_time = bundle.ksburstfiredelaymintime;
  max_pause_time = bundle.ksburstfiredelaymaxtime;
  burst_fire_enabled = bundle.ksburstfireenabled;
  veh.maxsightdistsqrd = (isDefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500) * (isDefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500);
  veh.var_e812cbe7 = (isDefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500) * (isDefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500);
  veh.var_38e6355c = (isDefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500) * (isDefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500);

  while(true) {

    veh.maxsightdistsqrd = (isDefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500) * (isDefined(bundle.var_2aeadfa0) ? bundle.var_2aeadfa0 : 3500);
    veh.var_e812cbe7 = (isDefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500) * (isDefined(bundle.var_f6853f02) ? bundle.var_f6853f02 : 2500);
    veh.var_38e6355c = (isDefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500) * (isDefined(bundle.var_5fa88c50) ? bundle.var_5fa88c50 : 500);

      if(isDefined(veh.isstunned) && veh.isstunned || isDefined(veh.isjammed) && veh.isjammed) {
        veh function_fc58f46f();
        wait 0.5;
        continue;
      }

    if(veh.controlled || !veh.turret_enabled) {
      wait 0.5;
      continue;
    }

    if(isDefined(veh.enemy)) {
      if(!is_valid_target(veh.enemy, veh.team)) {
        veh setignoreent(veh.enemy, 1);
        veh function_fc58f46f();
        wait 0.1;
        continue;
      }

      var_2aa33bf1 = 0;

      if(distancesquared(veh.enemy.origin, veh.origin) > veh.var_38e6355c && veh.var_7eb3ebd5[veh.enemy getentitynumber()] === #"forwardscan") {
        var_2aa33bf1 = 1;
      } else if(veh function_9d86d74c(veh.enemy)) {
        var_2aa33bf1 = 1;
      }

      if(var_2aa33bf1) {
        veh setpersonalignore(veh.enemy, 1);
        veh function_fc58f46f();
        wait 0.1;
        continue;
      }

      if(!isDefined(veh.var_7eb3ebd5[veh.enemy getentitynumber()]) && veh targetting_delay::function_1c169b3a(veh.enemy)) {
        veh.var_c8072bcc = gettime();
        veh.var_7eb3ebd5[veh.enemy getentitynumber()] = #"forwardscan";
      }
    }

    if(veh has_active_enemy(bundle) && isDefined(veh.enemy) && isalive(veh.enemy)) {
      veh.turretrotscale = getdvarfloat(#"hash_7a767607be3081e9", 3);

      if(!isDefined(veh.turret_target) || veh.turret_target != veh.enemy) {
        veh.turret_target = veh.enemy;

        if(!isDefined(veh.var_2b8e6720) || veh.var_2b8e6720 + 5000 < gettime()) {
          veh playsoundtoteam("mpl_ultimate_turret_lockon", veh.team);
          veh playsoundtoteam("mpl_ultimate_turret_lockon_enemy", util::getotherteam(veh.team));
          veh.var_2b8e6720 = gettime();
        }

        veh childthread function_b8952a40(0);
      }

      if(veh.turretontarget && veh function_2034705c(bundle) && veh cansee(veh.enemy)) {
        if(burst_fire_enabled) {
          fire_time = min_burst_time > max_burst_time ? min_burst_time : randomfloatrange(min_burst_time, max_burst_time);
          var_fc9f290e = veh.enemy;
          veh vehicle_ai::fire_for_time(fire_time, 0, veh.enemy);
          var_afae28e0 = !isDefined(var_fc9f290e) || !isalive(var_fc9f290e);

          if(min_pause_time > 0 && !var_afae28e0) {
            pause_time = min_pause_time > max_pause_time ? min_pause_time : randomfloatrange(min_pause_time, max_pause_time);
            waitresult = veh.turret_target waittilltimeout(pause_time, #"death", #"disconnect");
            var_afae28e0 = waitresult._notify === "death";
          }
        } else {
          var_fc9f290e = veh.enemy;
          veh vehicle_ai::fire_for_rounds(10, 0, veh.enemy);
          var_afae28e0 = !isDefined(var_fc9f290e) || !isalive(var_fc9f290e);
        }

        if(var_afae28e0 && isDefined(veh.turret_target) && isDefined(veh.turret_target.var_e78602fc) && veh.turret_target.var_e78602fc == veh) {
          if(isDefined(veh.owner)) {
            veh.owner luinotifyevent(#"mini_turret_kill");
            veh.owner playsoundtoplayer(#"hash_7ea486136cd776c", veh.owner);
          }

          veh.turretrotscale = 1;
          wait randomfloatrange(0.05, 0.2);
        }
      } else {
        wait 0.25;
      }

      continue;
    }

    var_4ec572ee = isDefined(veh.turret_target);
    var_bb861d93 = 0;

    if(var_4ec572ee && issentient(veh.turret_target)) {
      var_bb861d93 = isalive(veh.turret_target);
      veh setpersonalignore(veh.turret_target, 1.5);
    }

    veh function_fc58f46f();
    veh.turretrotscale = 1;

    if(var_4ec572ee && var_bb861d93) {
      veh playsoundtoteam("mpl_turret_lost", veh.team);
      veh playsoundtoteam("mpl_turret_lost_enemy", util::getotherteam(veh.team));
    }

    if(veh.var_63d65a8d == "arc") {
      if(veh.scanpos === "left") {
        veh turretsettargetangles(0, (-10, 40, 0));
        veh.scanpos = "right";
      } else {
        veh turretsettargetangles(0, (-10, -40, 0));
        veh.scanpos = "left";
      }
    } else if(veh.scanpos === "left") {
      veh turretsettargetangles(0, (-10, 180, 0));
      veh.scanpos = "left2";
    } else if(veh.scanpos === "left2") {
      veh turretsettargetangles(0, (-10, 360, 0));
      veh.scanpos = "right";
    } else if(veh.scanpos === "right") {
      veh turretsettargetangles(0, (-10, -180, 0));
      veh.scanpos = "right2";
    } else {
      veh turretsettargetangles(0, (-10, -360, 0));
      veh.scanpos = "left";
    }

    waitresult = veh waittilltimeout(3.5, #"enemy");

    if(waitresult._notify == #"enemy" && isDefined(veh.enemy)) {
      if(veh.var_aac73d6c && !isDefined(veh.enemylastseentime)) {
        attempts = 0;
        max_tries = 10;

        while(attempts < max_tries && !isDefined(veh.enemylastseentime) && isDefined(veh.enemy)) {
          veh getperfectinfo(self.enemy, 0);
          attempts++;
          wait 0.1;
        }
      }
    }
  }
}

turretshutdown(killstreakid, team) {
  turret = self;

  if(turret.shuttingdown === 1) {
    return;
  }

  if(isDefined(turret)) {
    turret.shuttingdown = 1;
  }

  killstreakrules::killstreakstop("ultimate_turret", team, killstreakid);
  deployable::function_81598103(turret);

  if(isDefined(turret.vehicle)) {
    turret.vehicle function_3a9dddac();
  }
}

watchturretshutdown(player, killstreakid, team) {
  player endon(#"disconnect", #"joined_team", #"joined_spectators");
  player thread function_d6c5b32b(player, killstreakid, team);
  turret = self;
  self waittill(#"ultimate_turret_shutdown", #"death");
  turretshutdown(killstreakid, team);
}

function_d6c5b32b(player, killstreakid, team) {
  turret = self;
  player waittill(#"disconnect", #"joined_team", #"joined_spectators");

  if(isDefined(turret)) {
    turret turretshutdown(killstreakid, team);
  }
}

has_active_enemy(bundle) {
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

function_be04d904() {
  onshutdown(self.turret);
  self function_21f16a35();
}

function_21f16a35() {
  self thread function_59ce22f9(undefined, undefined);
}

function_59ce22f9(attacker, callback_data) {
  if(!isDefined(self)) {
    return;
  }

  if(self.dead === 1) {
    return;
  }

  fxpos = isDefined(self gettagorigin("tag_turret")) ? self gettagorigin("tag_turret") : self.origin;
  playFX(level._equipment_explode_fx_lg, fxpos);
  self playSound("mpl_turret_exp");
  bundle = level.killstreakbundle[#"ultimate_turret"];

  if(isDefined(bundle.var_bb6c29b4) && isDefined(self.var_d02ddb8e) && self.var_d02ddb8e == getweapon(#"shock_rifle")) {
    playFX(bundle.var_bb6c29b4, self.origin);
  }

  self stoploopsound(0.5);
  self function_3a9dddac();
  turret = self.turret;
  self delete();
  waittillframeend();

  if(isDefined(turret)) {
    turret delete();
  }
}

function_31477582() {
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

    if(trace[#"fraction"] > 0) {
      new_origin = trace[#"position"];
      self.origin = (new_origin[0], new_origin[1], self.origin[2] - min(max_delta, self.origin[2] - new_origin[2]));
      max_delta += var_463c449d;
      waitframe(1);
      continue;
    }

    max_delta = 1;
    wait 1;
  }
}

on_player_killed() {
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

    if(self.var_e78602fc.vehicletype === #"ultimate_turret") {
      continue;
    }

    if(var_69501900.vehicletype === #"ultimate_turret") {
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