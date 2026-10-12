/********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\cp_mp\killstreaks\chopper_gunner.gsc
********************************************************/



#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\killstreakdeploy;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\damage_utility;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\cp_mp\utility\dialog_utility;
#using scripts\cp_mp\utility\game_utility;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\utility\shellshock_utility;
#using scripts\cp_mp\utility\vehicle_omnvar_utility;
#using scripts\cp_mp\utility\weapon_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\killstreaks\killstreak_shared;
#using scripts\mp\sentientpoolmanager;
#namespace chopper_gunner;

function init() {
  if(issharedfuncdefined("chopper_gunner", "init")) {
    [[getsharedfunc("chopper_gunner", "init")]]();
  }

  setdevdvarifuninitialized(@ "hash_5053673c4770b74", 0);
  setdevdvarifuninitialized(@ "hash_f3fcf3899fa2e1b0", 0);
  setdevdvarifuninitialized(@ "hash_a34a2f5a7d33e3bb", 0);
  setdevdvarifuninitialized(@ "hash_804b68f93e7911ba", 1);
  setdevdvarifuninitialized(@ "hash_6dcbef72bd1fd758", 0);
  setdevdvarifuninitialized(@ "hash_c1fa04efebbe3e6b", -1);

  level function_b380d510fa08cdec();
  level function_402d391c1c0e8ca();
  level function_e4d2385d5eee2c51();
  level function_5d9a912bab9622da();
  level function_5de17c2babe4b71b();
  level function_76bacdfa4c4a7bdc();
}

function function_b380d510fa08cdec() {
  level.choppergunners = [];
  level.heli_pilot_mesh = scripts\cp_mp\utility\game_utility::getlocaleent("heli_pilot_mesh");

  if(isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh hide();
  }

  if(isDefined(level.mapname) && level.mapname == "mp_embassy") {
    level.heli_structs_entrances = array_remove_index(level.heli_structs_entrances, 2);
  }

  level.incomingallchoppergunners = 0;

  foreach(teamname in level.teamnamelist) {
    level.incomingchoppergunners[teamname] = 0;
  }

  registervisibilityomnvarforkillstreak("chopper_gunner", "on", 6);
}

function function_402d391c1c0e8ca() {
  val::group_register("chopperGunnerUse", ["killstreaks", "allow_movement", "fire", "weapon_switch", "melee", "usability", "shellshock", "allow_jump", "offhand_weapons"]);
}

function function_e4d2385d5eee2c51() {
  level choppergunner_pilotanims();
  level choppergunner_vehicleanims();
}

function function_5d9a912bab9622da() {
  game["dialog"]["chopper_gunner" + "_use"] = "killstreak_remote_operator" + "_request_response";
  game["dialog"]["chopper_gunner" + "_leave"] = "killstreak_remote_operator" + "_leave";
  game["dialog"]["chopper_gunner" + "_engage"] = "killstreak_remote_operator" + "_engage";
  game["dialog"]["chopper_gunner" + "_random_radio"] = "killstreak_remote_operator" + "_radio_chatter";
  game["dialog"]["chopper_gunner" + "_attack_single"] = "killstreak_remote_operator" + "_target_attack_single";
  game["dialog"]["chopper_gunner" + "_attack_multi"] = "killstreak_remote_operator" + "_target_attack_multi";
  game["dialog"]["chopper_gunner" + "_flares"] = "killstreak_remote_operator" + "_flare_release";
  game["dialog"]["chopper_gunner" + "_light_damage"] = "killstreak_remote_operator" + "_light_damage";
  game["dialog"]["chopper_gunner" + "_med_damage"] = "killstreak_remote_operator" + "_med_damage";
  game["dialog"]["chopper_gunner" + "_heavy_damage"] = "killstreak_remote_operator" + "_heavy_damage";
  game["dialog"]["chopper_gunner" + "_killconf_single"] = "killstreak_remote_operator" + "_confirm_kill_single";
  game["dialog"]["chopper_gunner" + "_killconf_multi"] = "killstreak_remote_operator" + "_confirm_kill_multi";
  game["dialog"]["chopper_gunner" + "_killconf_missile"] = "killstreak_remote_operator" + "_confirm_kill_missile";
  game["dialog"]["chopper_gunner" + "_lockedon"] = "killstreak_remote_operator" + "_missile_lock_warning";
  game["dialog"]["chopper_gunner" + "_reattack"] = "killstreak_remote_operator" + "_reattack";
  game["dialog"]["chopper_gunner" + "_crash"] = "killstreak_remote_operator" + "_crash";
}

function function_5de17c2babe4b71b() {
  level._effect["chopper_gunner_friendly_strobe"] = loadfx("vfx/iw8_mp/killstreak/vfx_apache_friendly_strobe.vfx");
}

function function_76bacdfa4c4a7bdc() {
  if(isDefined(level.choppervisionset)) {
    function_c0b0a582ff9e4d57(level.choppervisionset);
  }

  pickedvisionset = "chopper_color_mp";

  if(utility::iscp()) {
    pickedvisionset = "chopper_color_cp";
  }

  function_c0b0a582ff9e4d57(pickedvisionset);
}

#using_animtree("script_model");

function choppergunner_pilotanims() {
  level.scr_animtree["ks_chopper_gunner_pilot"] = #animtree;
  level.scr_anim["ks_chopper_gunner_pilot"]["pilot_intro"] = % iw9_mp_ks_ahotel64_intro_player;
  level.scr_anim["ks_chopper_gunner_pilot"]["pilot_missile_crash"] = % iw9_mp_ks_ahotel64_crash_player;
  level.scr_anim["ks_chopper_gunner_pilot"]["pilot_shot_crash"] = % iw9_mp_ks_ahotel64_shot_player;
}

#using_animtree("mp_vehicles_always_loaded");

function choppergunner_vehicleanims() {
  level.scr_animtree["ks_chopper_gunner_vehicle_camera"] = #animtree;
  level.scr_anim["ks_chopper_gunner_vehicle_camera"]["vehicle_intro"] = % iw9_mp_ks_ahotel64_intro_heli;
}

function weapongivenchoppergunner(streakinfo) {
  return true;
}

function tryusechoppergunner() {
  streakinfo = createstreakinfo("chopper_gunner", self);
  return tryusechoppergunnerfromstruct(streakinfo);
}

function tryusechoppergunnerfromstruct(streakinfo) {
  self endon("disconnect");
  level endon("game_ended");
  var_75d0da8e536bc6e1 = function_b96cc2f80fa02ac2(streakinfo);

  if(!istrue(var_75d0da8e536bc6e1)) {
    if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    return false;
  }

  if(istrue(streakinfo.var_1c24ab6a14a60f16)) {
    val::set("chopperGunner", "ads", 0);
  }

  var_f79327d5641a9504 = function_e708b248bc646ecb(streakinfo);
  level.incomingallchoppergunners--;

  if(islargemap() && level.teambased) {
    level.incomingchoppergunners[self.team]--;
  }

  if(!istrue(var_f79327d5641a9504)) {
    val::reset_all("chopperGunner");

    if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();
    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(issharedfuncdefined("game", "disable_backpack_inventory")) {
    self[[getsharedfunc("game", "disable_backpack_inventory")]](1);
  }

  thirdperson = 0;

  thirdperson = getdvarint(@ "hash_5053673c4770b74", 0);

  if(istrue(thirdperson)) {
    streakinfo notify("<dev string:x1c>");
  }

  choppergunner = startchoppergunnerintro(self, streakinfo, thirdperson);
  choppergunner function_af96f7c8819ae854(self, 1000);

  if(issharedfuncdefined("emp", "setEMP_Applied_Callback")) {
    choppergunner[[getsharedfunc("emp", "setEMP_Applied_Callback")]](&function_20b002475b7af53b);
  }

  scripts\cp_mp\vehicles\vehicle_tracking::clearvehiclereservation();

  if(!isDefined(choppergunner)) {
    if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
      [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
    }

    streakinfo notify("killstreak_finished_with_deploy_weapon");
    return false;
  }

  if(issharedfuncdefined("killstreak", "logKillstreakEvent")) {
    self[[getsharedfunc("killstreak", "logKillstreakEvent")]]("chopper_gunner", self.origin);
  }

  if(issharedfuncdefined("hud", "teamPlayerCardSplash")) {
    self thread[[getsharedfunc("hud", "teamPlayerCardSplash")]]("used_chopper_gunner", self);
  }

  choppergunner thread function_fc02c5717861131a(self, thirdperson);

  if(issharedfuncdefined("killstreak", "makeChopperGunnerTargetableByAI")) {
    choppergunner[[getsharedfunc("killstreak", "makeChopperGunnerTargetableByAI")]]();
  }

  choppergunner thread function_98c857a1612a19d();
  return true;
}

function function_98c857a1612a19d() {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  while(true) {
    if(self.origin[2] < self.heightoffset[2] - 20) {
      self.origin = (self.origin[0], self.origin[1], self.heightoffset[2] + 100);
    }

    wait 0.1;
  }
}

function function_b96cc2f80fa02ac2(streakinfo) {
  if(issharedfuncdefined("vehicle", "incrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "incrementFauxVehicleCount")]]();
  }

  if(!scripts\cp_mp\vehicles\vehicle_tracking::reservevehicle()) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
    }

    return false;
  }

  var_4440147083abaf0a = 1;

  if(issharedfuncdefined("killstreak", "currentActiveVehicleCount") && issharedfuncdefined("killstreak", "maxVehiclesAllowed")) {
    if([[getsharedfunc("killstreak", "currentActiveVehicleCount")]]() >= [[getsharedfunc("killstreak", "maxVehiclesAllowed")]]() || level.fauxvehiclecount + var_4440147083abaf0a >= [[getsharedfunc("killstreak", "maxVehiclesAllowed")]]()) {
      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/TOO_MANY_VEHICLES");
      }

      return false;
    }
  }

  level.incomingallchoppergunners++;
  var_9c8d568f8760e50 = 1;

  if(islargemap()) {
    var_9c8d568f8760e50 = 2;
  }

  if(level.choppergunners.size >= var_9c8d568f8760e50 || level.choppergunners.size + level.incomingallchoppergunners > var_9c8d568f8760e50) {
    if(issharedfuncdefined("hud", "showErrorMessage")) {
      [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/AIR_SPACE_TOO_CROWDED");
    }

    level.incomingallchoppergunners--;
    return false;
  }

  if(islargemap() && level.teambased) {
    var_abdb6af6e3ca3893 = 1;
    level.incomingchoppergunners[self.team]++;

    if(getnumactivekillstreakperteam(self.team, level.choppergunners) + level.incomingchoppergunners[self.team] > var_abdb6af6e3ca3893) {
      level.incomingallchoppergunners--;
      level.incomingchoppergunners[self.team]--;

      if(issharedfuncdefined("hud", "showErrorMessage")) {
        [[getsharedfunc("hud", "showErrorMessage")]]("KILLSTREAKS/MAX_FRIENDLY_CHOPPER_GUNNER");
      }

      return false;
    }
  }

  if(level.gameended) {
    return false;
  }

  return true;
}

function function_e708b248bc646ecb(streakinfo) {
  if(isDefined(level.killstreaktriggeredfunc)) {
    if(!level[[level.killstreaktriggeredfunc]](streakinfo)) {
      return false;
    }
  }

  if(!istrue(streakinfo.var_1c24ab6a14a60f16)) {
    deployweaponobj = makeweapon("ks_remote_device_mp");
    deployresult = scripts\cp_mp\killstreaks\killstreakdeploy::streakdeploy_doweapontabletdeploy(streakinfo, &weapongivenchoppergunner);

    if(!istrue(deployresult)) {
      return false;
    }
  }

  if(isDefined(level.killstreakbeginusefunc)) {
    if(!level[[level.killstreakbeginusefunc]](streakinfo)) {
      return false;
    }
  }

  return true;
}

function startchoppergunnerintro(owner, streakinfo, thirdperson) {
  owner disablephysicaldepthoffieldscripting();
  heightent = scripts\cp_mp\utility\killstreak_utility::getkillstreakairstrikeheightent();
  heightoffset = (0, 0, 0);

  if(isDefined(heightent) && !islargemap()) {
    heightoffset = (0, 0, heightent.origin[2] - 1000);

    if(heightoffset[2] > 4000) {
      setglobalsoundcontext("airstrikeheight", "high");
    } else if(heightoffset[2] > 3000) {
      setglobalsoundcontext("airstrikeheight", "medium");
    }
  } else {
    heightoffset = (0, 0, 2000);
  }

  var_ae257a52192fe977 = getdvarint(@ "hash_f3fcf3899fa2e1b0", 0);
  heightoffset += (0, 0, var_ae257a52192fe977);

  pathgoal = (owner.origin + anglesToForward(owner.angles) * 2000) * (1, 1, 0);
  pathgoal += heightoffset;
  angles = owner.angles;

  if(isDefined(level.heli_structs_entrances) && level.heli_structs_entrances.size > 0) {
    var_8013278937ff2600 = randomint(level.heli_structs_entrances.size);

    debugindex = getdvarint(@ "hash_c1fa04efebbe3e6b", -1);

    if(debugindex != -1) {
      var_8013278937ff2600 = debugindex;
    }

    entrancestruct = level.heli_structs_entrances[var_8013278937ff2600];

    if(issharedfuncdefined("chopper_gunner", "findTargetStruct")) {
      goalstruct = [[getsharedfunc("chopper_gunner", "findTargetStruct")]](entrancestruct.script_linkto, level.heli_structs_goals);

      if(isDefined(goalstruct)) {
        heightoffset = function_2b1f56257b43a133((0, 0, goalstruct.origin[2] + 200));

        var_ae257a52192fe977 = getdvarint(@ "hash_f3fcf3899fa2e1b0", 0);
        heightoffset += (0, 0, var_ae257a52192fe977);

        var_a168db747b0d79ac = entrancestruct.origin * (1, 1, 0) + heightoffset;
        var_c32e33b4d51be12f = goalstruct.origin * (1, 1, 0) + heightoffset;
        entranceforward = vectorNormalize(var_c32e33b4d51be12f - var_a168db747b0d79ac);
        pathgoal = var_c32e33b4d51be12f + entranceforward * 500;
        angles = vectortoangles(entranceforward);

        level thread scripts\cp_mp\utility\debug_utility::drawsphere(var_a168db747b0d79ac, 20, 60, (1, 0, 0));
        level thread scripts\cp_mp\utility\debug_utility::drawline(var_a168db747b0d79ac, var_c32e33b4d51be12f, 60, (1, 1, 1));
        level thread scripts\cp_mp\utility\debug_utility::drawsphere(var_c32e33b4d51be12f, 20, 60, (0, 1, 0));
      } else {
        owner iprintlnbold("<dev string:x43>" + entrancestruct.script_linkto + "<dev string:x53>");
      }
    }
  } else if(istrue(owner.infinite_chopper) && level.script == "cp_so_aniyah") {
    if(level.players.size > 1) {
      ground_players = array_remove(level.players, owner);
    } else {
      ground_players = level.players;
    }

    selected_player = random(ground_players);
    var_cc75f1c67d8631d9 = (selected_player.origin[0], selected_player.origin[1], 1750);

    while(level.objective_locations.size == 0) {
      waitframe();
    }

    closest_objective = getclosest(var_cc75f1c67d8631d9, level.objective_locations);
    var_bf56b72e9a5b0cc1 = (closest_objective.origin[0], closest_objective.origin[1], 1750);
    var_bc721267bcee957a = vectorNormalize(var_cc75f1c67d8631d9 - var_bf56b72e9a5b0cc1);
    pathgoal = var_bf56b72e9a5b0cc1 - var_bc721267bcee957a * 1000;
    angles = vectortoangles(var_bc721267bcee957a);
  } else if(isDefined(streakinfo.var_6411fbc3afb86bc0)) {
    entranceinfo = [[streakinfo.var_6411fbc3afb86bc0]](owner);
    pathgoal = entranceinfo.pathgoal;
    angles = entranceinfo.angles;
  } else {
    owner iprintlnbold("Level is missing heli structs, please set them up!");
  }

  var_d166c9b268e88725 = "veh_apache_mp_phys";
  var_1f17b37a437d607c = "veh9_mil_air_heli_ahotel64_mp";

  if(getdvarint(@ "hash_f9d055c32419e2f2", 0) > 0 || istrue(owner.infinite_chopper) && level.script == "cp_so_aniyah") {
    var_d166c9b268e88725 = "veh_apache_cp_so_aniyah";
  }

  choppergunner = undefined;

  if(istrue(thirdperson)) {
    choppergunner = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(undefined, pathgoal, angles, var_d166c9b268e88725, var_1f17b37a437d607c);
  } else {
    choppergunner = scripts\cp_mp\vehicles\vehicle_tracking::_spawnhelicopter(owner, pathgoal, angles, var_d166c9b268e88725, var_1f17b37a437d607c);
  }

  if(!isDefined(choppergunner)) {
    return;
  }

  choppergunner vehphys_forcekeyframedmotion();
  choppergunner function_247ad6a91f6a4ffe(1);
  level thread function_ee93617532d8a679(choppergunner, owner, &choppergunner_explode);
  modifiedlifetime = 45;

  var_2a98d1683cf44153 = getdvarint(@ "hash_2c01d701bac5d9d3", 0);

  if(var_2a98d1683cf44153) {
    modifiedlifetime = 9999;
  }

  choppergunner.speed = 100;
  choppergunner.accel = 50;
  choppergunner.lifetime = modifiedlifetime;
  choppergunner.team = owner.team;
  choppergunner.owner = owner;
  choppergunner.angles = angles;
  choppergunner.streakinfo = streakinfo;
  choppergunner.streakname = streakinfo.streakname;
  choppergunner.flaresreservecount = 1;
  choppergunner.pathgoal = pathgoal;
  choppergunner.missilesleft = getdvarint(@ "hash_52bf6045193decbf", 8);
  choppergunner.animname = "ks_chopper_gunner_vehicle_camera";
  choppergunner.infinite_chopper = istrue(owner.infinite_chopper);
  choppergunner.interiorlighting = owner function_c77d8b1c3a992f19("chopper_interior_probe");
  choppergunner.ispiloted = 1;
  choppergunner.heightoffset = heightoffset;
  choppergunner setvehicleteam(choppergunner.team);

  if(issharedfuncdefined("chopper_gunner", "attachXRays")) {
    choppergunner = [[getsharedfunc("chopper_gunner", "attachXRays")]](choppergunner);
  }

  choppergunner thread choppergunner_watchintrodisown("disconnect", streakinfo);
  choppergunner thread choppergunner_watchintrodisown("joined_team", streakinfo);
  choppergunner thread choppergunner_watchintrodisown("joined_spectator", streakinfo);
  maxhealth = 2000;

  if(istrue(level.istacops)) {
    maxhealth = 1000;
  }

  choppergunner.health = maxhealth;
  choppergunner.maxhealth = maxhealth;
  choppergunner.currenthealth = maxhealth;
  choppergunner scripts\mp\sentientpoolmanager::registersentient("Killstreak_Air", owner);
  choppergunner function_8de91f51bc626d93(streakinfo.streakname);
  level.choppergunners[level.choppergunners.size] = choppergunner;

  if(issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    choppergunner[[getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  }

  choppergunner setmaxpitchroll(15, 15);
  choppergunner vehicle_setspeed(choppergunner.speed, choppergunner.accel);
  choppergunner sethoverparams(50, 5, 2.5);
  choppergunner setturningability(1);
  choppergunner setyawspeed(500, 100, 25, 0.5);
  choppergunner setotherent(owner);
  choppergunner setCanDamage(1);
  choppergunner setneargoalnotifydist(5000);
  choppergunner setscriptablepartstate("blinking_lights", "on", 0);
  choppergunner setscriptablepartstate("interior_light", "off", 0);
  choppergunner setscriptablepartstate("engine", "on", 0);

  choppergunner thread function_dc4cb73de48ec3d6();

  turretmodel = "veh9_mil_air_heli_ahotel64_turret";
  turret_ref = function_2926a76719559d56();
  choppergunner.turret = spawnturret("misc_turret", choppergunner gettagorigin("tag_turret"), turret_ref);
  choppergunner.turret setModel(turretmodel);
  choppergunner.turret.owner = owner;
  choppergunner.turret.team = owner.team;
  choppergunner.turret.angles = choppergunner.angles;
  choppergunner.turret.streakinfo = streakinfo;
  choppergunner.turret linkTo(choppergunner, "tag_turret");
  choppergunner.turret setturretteam(owner.team);
  choppergunner.turret setturretmodechangewait(0);
  choppergunner.turret setmode("manual");
  choppergunner.turret setotherent(owner);
  choppergunner.turret setdefaultdroppitch(45);
  choppergunner.mpod1 = spawn("script_model", choppergunner gettagorigin("tag_gun_l"));
  choppergunner.mpod1 setModel("ks_chopper_gunner_turret_mp");
  choppergunner.mpod1.angles = choppergunner.angles;
  choppergunner.mpod1.owner = choppergunner.owner;
  choppergunner.mpod1.team = choppergunner.team;
  choppergunner.mpod1 linkTo(choppergunner, "tag_gun_l");
  choppergunner.mpod1 setentityowner(owner);
  choppergunner.mpod1 setotherent(owner);
  choppergunner.mpod2 = spawn("script_model", choppergunner gettagorigin("tag_gun_r"));
  choppergunner.mpod2 setModel("ks_chopper_gunner_turret_mp");
  choppergunner.mpod2.angles = choppergunner.angles;
  choppergunner.mpod2.owner = choppergunner.owner;
  choppergunner.mpod2.team = choppergunner.team;
  choppergunner.mpod2 linkTo(choppergunner, "tag_gun_r");
  choppergunner.mpod2 setentityowner(owner);
  choppergunner.mpod2 setotherent(owner);
  var_daa0b77b12720c18 = "fullbody_sp_ally_pilot_western_vm";

  if(getplayersuperfaction(owner) == 1) {
    var_daa0b77b12720c18 = "fullbody_sp_ally_pilot_eastern_vm";
  }

  choppergunner.pilot = spawn("script_model", choppergunner gettagorigin("tag_origin"));
  choppergunner.pilot setModel(var_daa0b77b12720c18);
  choppergunner.pilot.angles = choppergunner.angles;
  choppergunner.pilot linkTo(choppergunner, "tag_origin");
  choppergunner.pilot.animname = "ks_chopper_gunner_pilot";
  choppergunner.pilot scripts\common\anim::setanimtree();
  level notify("matchrecording_chopper", choppergunner);
  self notify("chopper_gunner_used");

  if(!istrue(thirdperson)) {
    _stopshellshock();
    self.restoreangles = self getplayerangles();
    val::group_set("chopperGunnerUse", 0);

    self setcinematicmotionoverride("player_chopper_gunner_ride_mp");
    thread function_d13d2a81214fbfb8("80_instant_noscale", 1);
    self setclientomnvar("ui_apache_screens_state", 1);
    self cameralinkTo(choppergunner.pilot, "tag_camera", 1, 1);
    self painvisionoff();
    killstreak_savenvgstate();
    choppergunner playsoundtoplayer("mp_killstreak_apache_transition_lr", self);
  }

  playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_use", 1, undefined, "pilot");
  var_75ff6c760340b2dc = get_notetrack_time(level.scr_anim["ks_chopper_gunner_pilot"]["pilot_intro"], "camera_zoom");
  var_60c29673cce4f3f4 = getanimlength(level.scr_anim["ks_chopper_gunner_pilot"]["pilot_intro"]);
  var_9fcab10c7e98e5d0 = getanimlength(level.scr_anim["ks_chopper_gunner_vehicle_camera"]["vehicle_intro"]);
  choppergunner.var_8921ca6bcbebd389 = var_9fcab10c7e98e5d0 - var_75ff6c760340b2dc;
  choppergunner thread scripts\common\anim::anim_single_solo(choppergunner, "vehicle_intro");
  choppergunner thread scripts\common\anim::anim_single_solo(choppergunner.pilot, "pilot_intro", "body_animate_jnt");
  choppergunner function_546c923a292bab24(choppergunner.interiorlighting);
  choppergunner choppergunner_startfadetransition(var_75ff6c760340b2dc, thirdperson, 0.1);
  choppergunner function_38101db6ed950f17(choppergunner.interiorlighting);
  choppergunner notify("start_chopper_use");
  return choppergunner;
}

function function_8de91f51bc626d93(streakname) {
  killstreakvehicle = self;
  scorepopup = "destroyed_" + streakname;
  vodestroyed = undefined;
  destroyedsplash = "callout_destroyed_" + streakname;
  var_8dfc256103cce53e = &function_c668cff4b2ddaed0;
  var_191284e2e2837328 = &function_42807e45e47344c;
  premoddamagecallback = &function_623713927a33cb76;
  postmoddamagecallback = &function_ade353d9afc0d191;
  deathcallback = &choppergunner_handledeathdamage;
  killstreak_setupvehicledamagefunctionality(streakname, killstreakvehicle, scorepopup, vodestroyed, destroyedsplash, var_8dfc256103cce53e, var_191284e2e2837328, premoddamagecallback, postmoddamagecallback, deathcallback);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_registerinstance(self, self.owner, self.owner.team);
  function_cfc5e3633ef950fd(1, 1500, &function_30e33dc1b5a3d096);
  function_cfc5e3633ef950fd(2, 1000, &function_9a86620d2c95b213);
  function_cfc5e3633ef950fd(3, 500, &function_5df4204110a49163);
}

function function_c668cff4b2ddaed0(streakname) {
  if(issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](streakname, 12);
  }
}

function function_42807e45e47344c(streakname) {
  weaponname = "thermite_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 30;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "thermite_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 80;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_bolt_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 11;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }

  weaponname = "semtex_xmike109_mp";
  weaponhitsperattack = 1;
  weaponhitstokill = 18;

  if(issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]](weaponname, weaponhitsperattack, weaponhitstokill, streakname);
  }
}

function choppergunner_watchintrodisown(exitaction, streakinfo) {
  chopperowner = self.owner;
  self endon("death");
  self endon("exit_chopper_intro");
  self endon("start_chopper_use");
  level endon("game_ended");
  chopperowner waittill(exitaction);

  if(exitaction == "disconnect") {
    level.incomingallchoppergunners--;

    if(islargemap() && level.teambased) {
      level.incomingchoppergunners[self.team]--;
    }
  }

  if(isDefined(chopperowner)) {
    chopperowner cameraunlink();
    chopperowner disablephysicaldepthoffieldscripting();
    chopperowner val::group_reset("chopperGunnerUse");
    chopperowner val::reset_all("chopperGunner");
    chopperowner _setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
    chopperowner setclientomnvar("ui_apache_screens_state", 0);
    chopperowner painvisionon();
    chopperowner killstreak_restorenvgstate();
    chopperowner killstreak_setmainvision("");
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(chopperowner, 0);
  }

  thread choppergunner_explode();
  self notify("exit_chopper_intro");
}

function choppergunner_waitintroanimtime(time) {
  self endon("death");
  self endon("exit_chopper_intro");
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(time);
  return true;
}

function choppergunner_playdofintroeffects() {
  self endon("death");
  self endon("exit_chopper_intro");
  self.owner endon("disconnect");
  self.owner enablephysicaldepthoffieldscripting();
  self.owner setphysicaldepthoffield(4, 5000, 10, 10);
  wait 2;
  self.owner setphysicaldepthoffield(4, 20, 5, 10);
  wait 1.5;
  self.owner setphysicaldepthoffield(4, 1, 3, 10);
}

function choppergunner_camerashake(choppergunner) {
  choppergunner endon("death");
  choppergunner endon("explode");
  choppergunner endon("leaving");
  choppergunner endon("crashing");
  self endon("disconnect");
  level endon("game_ended");

  while(true) {
    self earthquakeforplayer(0.01, 0.1, choppergunner gettagorigin("tag_origin"), 1000);
    self playRumbleOnEntity("damage_light");
    wait 0.1;
  }
}

function function_fc02c5717861131a(gunner, thirdperson) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");

  if(isDefined(level.var_b67b5f9dfe488c2f)) {
    thread[[level.var_b67b5f9dfe488c2f]](self.streakinfo);
  }

  if(issharedfuncdefined("vehicle", "decrementFauxVehicleCount")) {
    [[getsharedfunc("vehicle", "decrementFauxVehicleCount")]]();
  }

  gunner = self.owner;
  gunner disablephysicaldepthoffieldscripting();

  if(!istrue(thirdperson)) {
    gunner.usingchoppergunner = 1;
    gunner val::set("chopperGunner", "allow_movement", 1);
    gunner val::set("chopperGunner", "fire", 1);
    gunner val::set("chopperGunner", "ads", 1);
    gunner cameraunlink();
    gunner thread function_d13d2a81214fbfb8("default");
    gunner remotecontrolturret(self.turret);
    gunner _shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    choppergunner_updatetargetmarkergroups(1);
  }

  if(isDefined(level.choppervisionset)) {
    self.currentvisionset = level.choppervisionset;
  }

  if(!isDefined(self.playersfx)) {
    self.playersfx = spawn("script_origin", self.origin);
    self.playersfx linkTo(self);
  }

  setlockedoncallback(self, &choppergunner_lockedoncallback);
  setlockedonremovedcallback(self, &choppergunner_lockedonremovedcallback);
  self setCanDamage(1);
  thread choppergunner_handlethermalswitch(thirdperson);
  thread choppergunner_handlemissilefire(thirdperson);
  thread choppergunner_watchturretfire(thirdperson);
  thread choppergunner_watchgameendleave(thirdperson);
  thread function_c7c48aed42b53d29(thirdperson);
  thread choppergunner_watchownerexitaction("disconnect");
  thread choppergunner_watchownerexitaction("joined_team");
  thread choppergunner_watchownerexitaction("joined_spectator");
  thread choppergunner_watchownerexitaction("team_kill_punish");
  thread function_f6a755e207671291();

  if(!istrue(self.infinite_chopper)) {
    thread choppergunner_watchlifetime(thirdperson);
    self.owner setclientomnvar("ui_killstreak_countdown", gettime() + int(self.lifetime * 1000));
  }

  if(istrue(thirdperson)) {
    thread function_f67cf34c214a0189();
    thread function_38b07fa35df09c85();
    thread function_fe8987efca006a06();
  }

  if(issharedfuncdefined("flares", "handleIncomingStinger")) {
    self thread[[getsharedfunc("flares", "handleIncomingStinger")]](&choppergunner_handlemissiledetection);
  }

  if(!istrue(thirdperson)) {
    if(isDefined(level.choppervisionset)) {
      self.currentvisionset = level.choppervisionset;
    }

    gunner killstreak_setmainvision(self.currentvisionset);
    gunner _setvisibiilityomnvarforkillstreak(self.streakinfo.streakname, "on");
    gunner setclientomnvar("ui_apache_screens_state", 0);
    gunner setclientomnvar("ui_apache_controls", 1);
    gunner setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);
    gunner setclientomnvar("ui_killstreak_health", self.health / self.maxhealth);
    gunner setclientomnvar("ui_killstreak_flares", self.flaresreservecount);
    gunner setclientomnvar("ui_killstreak_damage_state", 0);
    self.playersfx playLoopSound("veh_apache_killstreak_amb_lr");
    gunner setclienttriggeraudiozonepartialwithfade("apache_killstreak", 1.5, "mix", "filter");
  }

  delaytime = self.var_8921ca6bcbebd389;

  if(istrue(gunner.ksempd)) {
    choppergunner_handledeathdamage(gunner.var_5c079aa1be2b9bb);
  }

  wait delaytime;

  if(!istrue(thirdperson)) {
    gunner remotecontrolvehicle(self);
  } else {
    self setvehgoalpos(self.origin, 1);
  }

  if(self vehicle_isphysveh()) {
    self vehphys_setdefaultmotion();
  }

  thread choppergunner_watchearlyexit(thirdperson);
  var_7aed0f2a57765c9d = function_dfc7af47240a8c18();
  self vehicle_setspeed(var_7aed0f2a57765c9d.speed, var_7aed0f2a57765c9d.accel);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(3);

  if(isDefined(level.heli_pilot_mesh)) {
    var_ae257a52192fe977 = getdvarint(@ "hash_f3fcf3899fa2e1b0", 0);

    if(var_ae257a52192fe977 != 0) {
      return;
    }

    level.heli_pilot_mesh show();
  }
}

function function_dfc7af47240a8c18() {
  speedsettings = spawnStruct();
  speedsettings.speed = 40;
  speedsettings.accel = 20;

  switch (level.mapname) {
    case #"hash_1373c0a36e3cab54":
    case #"hash_81b84d832a53ee33":
    case #"hash_afcbd31dbcac0848":
    case #"hash_c23b803a5c7be5f3":
    case #"hash_dfa04d97b4cc9b44":
      speedsettings.speed = 25;
      speedsettings.accel = 15;
      break;
    case #"hash_150cb4659bbe6335":
    case #"hash_52f1fb3b7304621d":
    case #"hash_ae56d5b65ad78351":
      speedsettings.speed = 30;
      speedsettings.accel = 20;
      break;
  }

  return speedsettings;
}

function function_2b1f56257b43a133(var_bad97bf0dd8846f4) {
  newheightoffset = var_bad97bf0dd8846f4;

  switch (level.mapname) {
    case #"hash_52f1fb3b7304621d":
    case #"hash_81b84d832a53ee33":
    case #"hash_c23b803a5c7be5f3":
      newheightoffset += (0, 0, 300);
      break;
  }

  return newheightoffset;
}

function choppergunner_lockedoncallback() {
  playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_lockedon", undefined, undefined, "pilot");
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_showwarning("missileLocking", self.owner, "killstreak");
}

function choppergunner_lockedonremovedcallback() {
  scripts\cp_mp\utility\vehicle_omnvar_utility::vehomn_hidewarning("missileLocking", self.owner, "killstreak");
}

function choppergunner_updatetargetmarkergroups(togglestate) {
  if(istrue(togglestate)) {
    if(istrue(self.infinite_chopper)) {
      return;
    }

    if(issharedfuncdefined("chopper_gunner", "assignTargetMarkers")) {
      self[[getsharedfunc("chopper_gunner", "assignTargetMarkers")]]();
    }

    return;
  }

  if(isDefined(self.enemytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.enemytargetmarkergroup);
    self.enemytargetmarkergroup = undefined;
  }

  if(isDefined(self.friendlytargetmarkergroup)) {
    scripts\cp_mp\targetmarkergroups::targetmarkergroup_off(self.friendlytargetmarkergroup);
    self.friendlytargetmarkergroup = undefined;
  }
}

function choppergunner_watchendstrobefx(choppergunner) {
  self endon("death");
  level endon("game_ended");
  choppergunner waittill_any_2("death", "leaving");
  self delete();
}

function choppergunner_startfadetransition(timedelay, thirdperson, var_1e1134ff29f6168c) {
  self endon("death");
  self endon("exit_chopper_intro");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(timedelay);

  if(!istrue(thirdperson)) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 1, var_1e1134ff29f6168c);
  }

  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(var_1e1134ff29f6168c);

  if(!istrue(thirdperson)) {
    level thread scripts\cp_mp\utility\game_utility::fadetoblackforplayer(self.owner, 0, var_1e1134ff29f6168c);
  }
}

function function_f67cf34c214a0189() {
  self endon("<dev string:x62>");
  self endon("<dev string:x68>");
  turret_ref = function_2926a76719559d56();
  self.currentdebugweapon = turret_ref;
  var_a95a67a21665324a = self.owner;
  var_a95a67a21665324a notifyonplayercommand("<dev string:x70>", "<dev string:x8c>");
  missile_ref = ter_op(utility::iscp(), "<dev string:x96>", "<dev string:xad>");

  while(true) {
    var_a95a67a21665324a waittill("<dev string:x70>");

    if(self.currentdebugweapon == turret_ref) {
      self.currentdebugweapon = missile_ref;
    } else {
      self.currentdebugweapon = turret_ref;
    }

    var_a95a67a21665324a iprintlnbold("<dev string:xc4>" + self.currentdebugweapon);
  }
}

function function_38b07fa35df09c85() {
  self endon("<dev string:x62>");
  self endon("<dev string:x68>");
  var_a95a67a21665324a = self.owner;
  var_a95a67a21665324a notifyonplayercommand("<dev string:xdf>", "<dev string:xfc>");
  var_a95a67a21665324a notifyonplayercommand("<dev string:xdf>", "<dev string:x107>");
  self.var_36d522b9b4678ef1 = spawn("<dev string:x111>", self.origin);
  self.var_36d522b9b4678ef1 setModel("<dev string:x11e>");
  self.var_36d522b9b4678ef1 dontinterpolate();

  while(true) {
    var_a95a67a21665324a waittill("<dev string:xdf>");

    if(isDefined(self.testtargetent)) {
      self clearlookatent();
      self.testtargetent delete();
    }

    thread function_c31fd561d72092a5(var_a95a67a21665324a, self.currentdebugweapon);
  }
}

function function_c31fd561d72092a5(var_a95a67a21665324a, weaponname) {
  self endon("<dev string:x62>");
  self endon("<dev string:x68>");
  var_a95a67a21665324a endon("<dev string:x129>");
  var_a95a67a21665324a endon("<dev string:xdf>");
  var_a95a67a21665324a endon("<dev string:x70>");
  var_5f8d47facd99fabf = weaponfiretime(weaponname);
  targettracestart = var_a95a67a21665324a getvieworigin();
  targettraceend = targettracestart + anglesToForward(var_a95a67a21665324a getplayerangles()) * 50000;
  targettrace = scripts\engine\trace::ray_trace(targettracestart, targettraceend, self, scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));
  fireposition = undefined;

  if(targettrace["<dev string:x134>"] != "<dev string:x13c>") {
    fireposition = targettrace["<dev string:x149>"];
  }

  if(!isDefined(fireposition)) {
    return;
  }

  self.var_36d522b9b4678ef1.origin = fireposition;
  turret_ref = function_2926a76719559d56();

  if(weaponname == turret_ref) {
    self.turret snaptotargetentity(self.var_36d522b9b4678ef1);
  }

  self.testtargetent = spawn("<dev string:x111>", fireposition);
  self setlookatent(self.testtargetent);

  while(true) {
    if(weaponname == turret_ref) {
      self.turret shootturret();
    } else {
      var_a95a67a21665324a notify("<dev string:x152>", fireposition);
    }

    sphere(self.var_36d522b9b4678ef1.origin, 50, (1, 1, 0), 0, int(var_5f8d47facd99fabf));
    wait var_5f8d47facd99fabf;
  }
}

function function_fe8987efca006a06() {
  self endon("<dev string:x62>");
  self endon("<dev string:x68>");
  var_a95a67a21665324a = self.owner;
  var_a95a67a21665324a notifyonplayercommand("<dev string:x160>", "<dev string:x17d>");
  var_a95a67a21665324a notifyonplayercommand("<dev string:x160>", "<dev string:x185>");
  self vehicle_setspeed(40, 45);
  self.debugpathing = 0;

  while(true) {
    var_a95a67a21665324a waittill("<dev string:x160>");

    if(!istrue(self.debugpathing)) {
      self.debugpathing = 1;
      var_a95a67a21665324a iprintlnbold("<dev string:x193>");
    } else {
      self.debugpathing = 0;
      var_a95a67a21665324a iprintlnbold("<dev string:x1aa>");
      var_a95a67a21665324a notify("<dev string:x1c1>");
      self setvehgoalpos(self.pathgoal, 1);
      continue;
    }

    thread function_19ead4526ebc7004(var_a95a67a21665324a);
  }
}

function function_19ead4526ebc7004(var_a95a67a21665324a) {
  self endon("<dev string:x62>");
  self endon("<dev string:x68>");
  self endon("<dev string:x1ce>");
  var_a95a67a21665324a endon("<dev string:x1c1>");
  var_b9a46106a6a99ee8 = 0;

  while(true) {
    newgoal = self.origin + anglesToForward((0, var_b9a46106a6a99ee8, 0)) * 2000;
    sphere(newgoal, 50, (1, 1, 1), 0, 40);
    var_b9a46106a6a99ee8 += 20;
    self setvehgoalpos(newgoal, 0);

    if(var_b9a46106a6a99ee8 >= 360) {
      var_b9a46106a6a99ee8 = 0;
    }

    wait 0.5;
  }
}

function choppergunner_handledangerzone(thirdperson) {
  self endon("leaving");
  self endon("crashing");
  self endon("death");
  level endon("game_ended");
  zone = undefined;
  zonepos = self.origin;
  zoneradius = 750;
  zoneheight = 2000;
  zoneteam = self.team;
  zonelifetime = self.lifetime;
  zoneowner = self.owner;
  var_ddf8049486533578 = 1;
  zoneparentent = self;
  var_d3279a50b0437e88 = 1;

  if(issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    zone = [[getsharedfunc("spawn", "addSpawnDangerZone")]](zonepos, zoneradius, zoneheight, zoneteam, zonelifetime, zoneowner, var_ddf8049486533578, zoneparentent, var_d3279a50b0437e88);
  }

  if(isDefined(zone) && issharedfuncdefined("spawn", "getCodeHandleFromScriptHandle")) {
    codeid = [[getsharedfunc("spawn", "getCodeHandleFromScriptHandle")]](zone);

    while(true) {
      surfacetrace = ray_trace(self.origin, self.origin - (0, 0, 20000), self);

      if(surfacetrace["hittype"] != "hittype_none") {
        spawninfluencepointsetposition(codeid, surfacetrace["position"]);
      }

      scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.25);
    }
  }
}

function choppergunner_handlethermalswitch(thirdperson) {
  if(!istrue(thirdperson)) {
    var_a95a67a21665324a = self.owner;
    var_a95a67a21665324a thread watchthermalinputchange();
    choppergunner_handlethermalswitchinternal();

    if(isDefined(var_a95a67a21665324a)) {
      var_a95a67a21665324a stopwatchingthermalinputchange();
    }
  }
}

function choppergunner_handlethermalswitchinternal() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  var_a95a67a21665324a = self.owner;
  thermaltoggle = 0;
  thermalstate = 0;
  thermalvisionset = function_44e0bd95b98288ab();
  var_776eb21ee7baab30 = "chopper_color_mp";

  if(utility::iscp()) {
    var_776eb21ee7baab30 = "chopper_color_cp";
  }

  self.currentvisionset = var_776eb21ee7baab30;

  if(isnightmap()) {
    var_a95a67a21665324a setthermalvision(1, 12, 1000);
    self.currentvisionset = thermalvisionset;
    var_a95a67a21665324a _shellshock("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
    thermaltoggle = 1;
  }

  for(thermalstate = 1; true; thermalstate = 0) {
    var_a95a67a21665324a setclientomnvar("ui_killstreak_thermal_mode", thermalstate);
    var_a95a67a21665324a killstreak_setmainvision(self.currentvisionset);
    var_a95a67a21665324a waittill("switch_thermal_mode");
    var_a95a67a21665324a notify("chopper_gunner_toggled_flir", !thermaltoggle);

    if(!istrue(thermaltoggle)) {
      var_a95a67a21665324a setthermalvision(1, 12, 1000);
      self.currentvisionset = thermalvisionset;
      var_a95a67a21665324a _shellshock("killstreak_veh_camera_flir_mp", "top", self.lifetime, 0);
      thermaltoggle = 1;
      thermalstate = 1;
      continue;
    }

    if(isDefined(level.choppervisionset)) {
      var_a95a67a21665324a killstreak_setmainvision(level.choppervisionset);
      self.currentvisionset = level.choppervisionset;
    } else {
      var_a95a67a21665324a killstreak_setmainvision(var_776eb21ee7baab30);
      self.currentvisionset = var_776eb21ee7baab30;
    }

    var_a95a67a21665324a setthermalvision(0);
    var_a95a67a21665324a _shellshock("killstreak_veh_camera_mp", "top", self.lifetime, 0);
    thermaltoggle = 0;
  }
}

function choppergunner_handlemissilefire(thirdperson) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_a95a67a21665324a = self.owner;
  var_a95a67a21665324a notifyonplayercommand("shoot_missile", "+frag");
  self.missilefireside = undefined;
  missilecounter = 0;
  var_43cb1141ecbed065 = 4;
  var_fa3d844d56938a31 = getdvarint(@ "hash_52bf6045193decbf", 8);

  while(true) {
    var_a95a67a21665324a waittill("shoot_missile", var_2511abb80c1de0c9);

    if(istrue(self.infinite_chopper)) {
      if(utility::iscp() && self.missilesleft <= 1) {
        childthread choppergunner_refillmissiles();
      } else if(!iscp() && self.missilesleft == var_fa3d844d56938a31) {
        childthread choppergunner_refillmissiles();
      }
    }

    missilecounter++;
    self.streakinfo.shots_fired++;

    if(missilecounter > var_43cb1141ecbed065) {
      missilecounter = 1;
    }

    earthquakeorigin = ter_op(isDefined(self.turret), self.turret.origin, self.origin);
    self.owner earthquakeforplayer(0.25, 0.4, earthquakeorigin, 150);
    self.owner playRumbleOnEntity("damage_heavy");
    missilepod = self.mpod1;

    if(!isDefined(self.missilefireside) || self.missilefireside == "right") {
      self.missilefireside = "left";
      self.mpod1 thread choppergunner_firemissilefx(missilecounter);
      missilepod = self.mpod1;
    } else {
      self.missilefireside = "right";
      self.mpod2 thread choppergunner_firemissilefx(missilecounter);
      missilepod = self.mpod2;
    }

    turretviewpos = self.turret gettagorigin("tag_pivot");
    var_a437f2b6d33146eb = anglesToForward(self.turret gettagangles("tag_player"));
    missileorigin = missilepod.origin * (1, 1, 0) + (0, 0, turretviewpos[2]);
    missilestart = missileorigin + var_a437f2b6d33146eb * 100;
    missileend = missileorigin + var_a437f2b6d33146eb * 1000;
    targettracestart = self.owner getvieworigin();
    var_b2ad24aedfc0eb0a = anglesToForward(self.owner getplayerangles());
    targettraceend = targettracestart + var_b2ad24aedfc0eb0a * 50000;
    ignorelist = [self, self.turret, missilepod];
    targettrace = scripts\engine\trace::ray_trace(targettracestart, targettraceend, ignorelist, scripts\engine\trace::create_contents(1, 1, 0, 1, 0, 1, 0, 1, 1));
    fireposition = targettrace["position"];

    if(isDefined(var_2511abb80c1de0c9)) {
      fireposition = var_2511abb80c1de0c9;
    }

    debugmissile = getdvarint(@ "hash_a34a2f5a7d33e3bb", 0);

    if(debugmissile) {
      level thread scripts\cp_mp\utility\debug_utility::drawline(missilestart, missileend, 10, (1, 1, 1));
      level thread scripts\cp_mp\utility\debug_utility::drawsphere(missilestart, 20, 10, (0, 1, 0));
      level thread scripts\cp_mp\utility\debug_utility::drawsphere(missileend, 20, 10, (1, 1, 0));
      level thread scripts\cp_mp\utility\debug_utility::drawsphere(fireposition, 20, 10, (1, 0, 0));
    }

    missile_ref = ter_op(utility::iscp(), "chopper_gunner_proj_cp", "chopper_gunner_proj_mp");
    missile = _magicbullet(makeweapon(missile_ref), missilestart, missileend, var_a95a67a21665324a);
    missile thread choppergunner_watchmissilestate(fireposition);
    missile thread choppergunner_watchexplosioninfluencepoint(self.owner, 2, 300, 300);
    self notify("fired_missile", missile);
    missile.streakinfo = self.streakinfo;
    self.missilesleft--;
    var_a95a67a21665324a setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);

    if(self.missilesleft == 0) {
      if(istrue(thirdperson)) {
        missilecounter = 0;
        self.missilesleft = getdvarint(@ "hash_52bf6045193decbf", 8);
        var_a95a67a21665324a setclientomnvar("<dev string:x1d7>", self.missilesleft);
        continue;
      }

      if(istrue(self.infinite_chopper)) {
        self waittill("missiles_refilled");
        continue;
      }

      break;
    }
  }
}

function choppergunner_refillmissiles() {
  self endon("missiles_refilled");
  reload_duration = getdvarfloat(@ "hash_2f91da9928400cbd", 8);
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(reload_duration);
  self.missilesleft = getdvarint(@ "hash_52bf6045193decbf", 8);
  self.owner setclientomnvar("ui_killstreak_weapon_1_ammo", self.missilesleft);
  self notify("missiles_refilled");
}

function choppergunner_watchturretfire(thirdperson) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  var_d8c1a9b6f71f67d1 = 500;

  if(utility::iscp()) {
    var_d8c1a9b6f71f67d1 = 100;
    self.owner.var_606e132ddfe3ccf9 = var_d8c1a9b6f71f67d1;
    self.owner setclientomnvar("ui_killstreak_weapon_2_ammo", var_d8c1a9b6f71f67d1);
  }

  while(true) {
    self.turret waittill("missile_fire", missile);
    self.owner earthquakeforplayer(0.15, 0.1, self.turret.origin, 150);
    missile.streakinfo = self.streakinfo;
    self.streakinfo.shots_fired++;
    missile thread choppergunner_watchexplosioninfluencepoint(self.owner, 0.5, 256, 200);

    if(utility::iscp()) {
      var_d8c1a9b6f71f67d1--;
      self.owner.var_606e132ddfe3ccf9 = var_d8c1a9b6f71f67d1;

      if(var_d8c1a9b6f71f67d1 < 0) {
        self.turret turretfiredisable();
        wait 3;
        var_d8c1a9b6f71f67d1 = 100;
        self notify("turret_reloaded");
        self.turret turretfireenable();
      }

      self.owner setclientomnvar("ui_killstreak_weapon_2_ammo", var_d8c1a9b6f71f67d1);
    }
  }
}

function choppergunner_firemissilefx(missileindex) {
  self endon("death");
  level endon("game_ended");
  self setscriptablepartstate("fire_missile_" + missileindex, "on", 0);
  wait 1;
  self setscriptablepartstate("fire_missile_" + missileindex, "off", 0);
}

function choppergunner_watchmissilestate(missiletargetpos) {
  level endon("game_ended");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(0.05);

  if(isDefined(self)) {
    self missile_settargetpos(missiletargetpos);
  }
}

function choppergunner_watchlifetime(thirdperson) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  lifetime = self.lifetime;
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(lifetime);
  playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_leave", 1, undefined, "pilot");
  thread choppergunner_leave(thirdperson);
}

function choppergunner_watchgameendleave(thirdperson) {
  self.owner endon("disconnect");
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level waittill_any_2("start_game_ended", "game_ended");
  self.recordedgameendstats = 1;
  self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  thread choppergunner_leave(thirdperson);
}

function function_c7c48aed42b53d29(thirdperson) {
  self endon("death");
  self endon("crashing");
  self endon("leaving");
  self.owner endon("disconnect");
  level endon("game_ended");

  if(istrue(thirdperson)) {
    return;
  }

  chopperbasefov = 65;
  lerptime = 0.25;
  currentfov = chopperbasefov;
  var_d54d564805c29b7b = 30;
  timeheld = 0;
  playedvision = 0;
  self.owner setclientomnvar("ui_killstreak_zoom_fov", currentfov);

  while(true) {
    if(self.owner adsButtonPressed()) {
      timeheld += 0.05;

      if(timeheld >= lerptime) {
        timeheld = lerptime;
      }

      if(!istrue(playedvision)) {
        self.owner function_58707ddfdd9744fa("killstreak_ads_shutter");
        playedvision = 1;
      }
    } else if(timeheld > 0) {
      timeheld -= 0.05;

      if(timeheld <= 0) {
        timeheld = 0;
      }

      if(istrue(playedvision)) {
        playedvision = 0;
      }
    }

    if(timeheld >= 0) {
      timeperc = timeheld / lerptime * 100;
      currentfov = int(timeperc * (var_d54d564805c29b7b - chopperbasefov) / 100 + chopperbasefov);
    }

    self.owner setclientomnvar("ui_killstreak_zoom_fov", currentfov);
    wait 0.05;
  }
}

function choppergunner_watchownerexitaction(exitaction) {
  self endon("death");
  self endon("explode");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner waittill(exitaction);
  thread choppergunner_returnplayer(0, 0);
  thread choppergunner_explode();
}

function choppergunner_watchtargets() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_engage", undefined, undefined, "pilot");
  scripts\cp_mp\hostmigration::hostmigration_waitlongdurationwithpause(5);

  while(true) {
    visibletargets = [];

    foreach(player in level.players) {
      if(self.owner worldpointinreticle_circle(player.origin, 80, 100)) {
        if(level.teambased && player.team == self.team) {
          continue;
        }

        if(player == self.owner) {
          continue;
        }

        ignorelist = [self, self.turret];

        if(!streakcanseetarget(self.turret gettagorigin("tag_flash"), player gettagorigin("j_head"), ignorelist)) {
          continue;
        }

        if(issharedfuncdefined("perk", "hasPerk")) {
          if(player[[getsharedfunc("perk", "hasPerk")]]("specialty_noscopeoutline")) {
            continue;
          }
        }

        visibletargets = choppergunner_getnearbytargets(player);
        break;
      }

      wait 0.05;
    }

    if(visibletargets.size > 0 && visibletargets.size < 2) {
      playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_attack_single", undefined, undefined, "pilot");
    } else if(visibletargets.size >= 2) {
      playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_attack_multi", undefined, undefined, "pilot");
    }

    wait randomintrange(5, 15);
  }
}

function choppergunner_getnearbytargets(maintarget) {
  nearplayers = utility::playersincylinder(maintarget.origin, 300);
  nearbytargets = [];

  foreach(player in nearplayers) {
    if(level.teambased && player.team != maintarget.team) {
      continue;
    }

    if(!level.teambased && player == self.owner) {
      continue;
    }

    nearbytargets[nearbytargets.size] = player;
  }

  return nearbytargets;
}

function function_f6a755e207671291() {
  self endon("death");
  self endon("leaving");
  self endon("crashing");
  level endon("game_ended");
  self.owner endon("disconnect");
  self.var_d743ac65ecce766 = 0;
  self.var_5fb9ddd4aec3a659 = undefined;
  childthread choppergunner_watchkills();
  childthread function_708f19cf8e854691();
  missile_ref = ter_op(utility::iscp(), "chopper_gunner_proj_cp", "chopper_gunner_proj_mp");

  while(true) {
    if(self.var_d743ac65ecce766 != 0) {
      wait 2;

      if(self.var_d743ac65ecce766 >= 1 && self.var_5fb9ddd4aec3a659 == missile_ref) {
        playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_killconf_missile", undefined, undefined, "pilot");
      } else if(self.var_d743ac65ecce766 == 1) {
        playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_killconf_single", undefined, undefined, "pilot");
      } else if(self.var_d743ac65ecce766 >= 2) {
        playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_killconf_multi", undefined, undefined, "pilot");
      }

      self.var_d743ac65ecce766 = 0;
      self.var_5fb9ddd4aec3a659 = undefined;
      wait 1;
    }

    waitframe();
  }
}

function choppergunner_watchkills() {
  while(true) {
    self.owner waittill("update_rapid_kill_buffered", recentkills, weaponname);

    if(isDefined(recentkills)) {
      self.var_d743ac65ecce766++;
      self.var_5fb9ddd4aec3a659 = weaponname;
    }
  }
}

function function_708f19cf8e854691() {
  while(true) {
    self.owner waittill("update_rapid_agent_kill_buffered", recentkills, weaponname);

    if(isDefined(recentkills)) {
      self.var_d743ac65ecce766++;
      self.var_5fb9ddd4aec3a659 = weaponname;
    }
  }
}

function choppergunner_leave(thirdperson) {
  self endon("death");
  self endon("crashing");
  thread choppergunner_returnplayer(0, thirdperson);
  self clearlookatent();
  self setmaxpitchroll(0, 0);
  self notify("leaving");
  self.isleaving = 1;
  var_df6c75d1a1e4ff18 = 3;
  flightheightoffset = (0, 0, 1000);
  var_bb0e78a73b33d580 = self.origin + flightheightoffset;
  leavestart = undefined;
  leavegoal = undefined;
  var_ec0c66c48e6f8304 = undefined;

  while(var_df6c75d1a1e4ff18 > 0) {
    flightpath = function_999fe3838d6b6f8c(var_bb0e78a73b33d580, self.angles, 400, 15000);

    if(isDefined(flightpath.end)) {
      leavestart = flightpath.start;
      leavegoal = flightpath.end;
      var_ec0c66c48e6f8304 = flightpath.angles;
      break;
    }

    var_bb0e78a73b33d580 += (0, 0, 1000);
    var_df6c75d1a1e4ff18--;
    wait 0.05;
  }

  if(!isDefined(leavegoal)) {
    thread choppergunner_explode();
    return;
  }

  turnspeed = 100;
  ascendspeed = 50;
  self setyawspeed(turnspeed, 50, 25, 0);
  self settargetyaw(var_ec0c66c48e6f8304[1]);
  self vehicle_setspeed(ascendspeed, 25);
  pathgoal = leavestart;
  self setvehgoalpos(pathgoal, 1);
  waittill_any_timeout_1(3, "goal");
  failsafetime = 0;

  while(failsafetime < 2) {
    currentyaw = (0, self.angles[1], 0);
    yawdiff = var_ec0c66c48e6f8304 - currentyaw;

    if(abs(yawdiff[1]) < 5) {
      break;
    }

    failsafetime += level.framedurationseconds;
    waitframe();
  }

  self setmaxpitchroll(15, 15);
  self vehicle_setspeed(150, self.accel);
  self setvehgoalpos(leavegoal, 1);
  self setneargoalnotifydist(1000);
  waittill_any_timeout_1(10, "near_goal");
  self notify("gone");
  thread choppergunner_delete(0);
}

function choppergunner_getpathend() {
  pathrandomness = 150;
  halfdistance = 15000;
  yaw = self.angles[1];
  direction = (0, yaw, 0);
  endpoint = self.origin + anglesToForward(direction) * halfdistance;
  return endpoint;
}

function function_623713927a33cb76(data) {
  damage = data.damage;
  attacker = data.attacker;
  return true;
}

function function_ade353d9afc0d191(data) {
  attacker = data.attacker;
  objweapon = data.objweapon;
  type = data.meansofdeath;
  damage = data.damage;
  idflags = data.idflags;

  if(isDefined(self.owner) && self.owner isusingchoppergunner()) {
    var_bb22d61320ffe92d = "light";

    if(isexplosivedamagemod(type)) {
      if(ceil(damage / self.maxhealth) >= 0.33) {
        self.owner earthquakeforplayer(0.25, 0.2, self.turret.origin, 150);
        self.owner playRumbleOnEntity("damage_heavy");
        var_bb22d61320ffe92d = "heavy";
      } else {
        self.owner earthquakeforplayer(0.15, 0.15, self.turret.origin, 150);
        self.owner playRumbleOnEntity("damage_light");
      }
    }

    self.owner function_c144de677d9b9175(self.currentvisionset, var_bb22d61320ffe92d);
  }

  self.currenthealth -= damage;
  killstreak_updatedamagestate(self.currenthealth);
  return true;
}

function function_30e33dc1b5a3d096() {
  self setscriptablepartstate("body_damage_light", "on");
  self.owner playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_light_damage", undefined, undefined, "pilot");
}

function function_9a86620d2c95b213() {
  self setscriptablepartstate("body_damage_medium", "on");
  self.owner playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_med_damage", undefined, undefined, "pilot");
}

function function_5df4204110a49163() {
  self setscriptablepartstate("body_damage_heavy", "on");
  self.owner playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_heavy_damage", undefined, undefined, "pilot");
}

function choppergunner_handledeathdamage(data) {
  self.killedbyweapon = data.objweapon;
  thread function_2b17aa319c193951(data.attacker, data.objweapon);
  return true;
}

function function_2b17aa319c193951(attacker, killedbyweapon) {
  self endon("explode");
  thirdperson = 0;

  thirdperson = getdvarint(@ "hash_5053673c4770b74", 0);

  var_1d4408c68f2118a = isDefined(attacker) && isPlayer(attacker) && istrue(attacker.isjuggernaut);
  shouldcrash = 1;

  if(isDefined(self.owner) && self.owner isusingchoppergunner()) {
    thread choppergunner_returnplayer(shouldcrash, thirdperson);
  }

  if(istrue(shouldcrash)) {
    function_546c923a292bab24(self.interiorlighting);
    choppergunner_crash(150, killedbyweapon);
    function_38101db6ed950f17(self.interiorlighting);
  }

  thread choppergunner_explode();
}

function choppergunner_crash(speed, weaponkilledby, var_c5adb13be635c61a) {
  self endon("explode");
  self.iscrashing = 1;
  self clearlookatent();
  self notify("crashing");
  self setscriptablepartstate("engine_explosion", "on", 0);
  self setmaxpitchroll(10, 50);
  self vehicle_setspeed(speed, 20, 20);
  self setneargoalnotifydist(100);
  glassdamagestate = "missile_damage";

  if(isbulletweapon(weaponkilledby)) {
    glassdamagestate = "bullet_damage";
  }

  self setscriptablepartstate("glass", glassdamagestate, 0);
  var_6847739e80fb4e81 = choppergunner_findcrashposition(1250);

  if(!isDefined(var_6847739e80fb4e81)) {
    return;
  }

  if(istrue(var_c5adb13be635c61a)) {
    sphere(var_6847739e80fb4e81, 100, (0, 1, 0), 0, 500);
    line(self.origin, var_6847739e80fb4e81, (0, 1, 0), 1, 0, 500);
  }

  playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_crash", 1, undefined, "pilot");
  self setvehgoalpos(var_6847739e80fb4e81, 0);
  thread choppergunner_spinout(speed);
  crashanim = "pilot_missile_crash";

  if(isbulletweapon(weaponkilledby)) {
    crashanim = "pilot_shot_crash";
  }

  thread scripts\common\anim::anim_single_solo(self.pilot, crashanim, "body_animate_jnt");
  waittill_any_timeout_2(5, "collision", crashanim);
  function_5a9772411551e56e("chopper_gunner", "pilot");
}

function choppergunner_spinout(speed) {
  self endon("death");
  self setyawspeed(speed, 50, 50, 0.5);

  while(isDefined(self)) {
    self settargetyaw(self.angles[1] + speed * 0.6);
    wait 0.5;
  }
}

function choppergunner_findcrashposition(crashdist) {
  crashstart = self.origin;
  crashoffset = 1000;
  crashpos = undefined;
  jetforward = anglesToForward(self.angles);
  jetright = anglestoright(self.angles);
  crashend = crashstart + jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetforward * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart - jetright * crashdist - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward + jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (jetright - jetforward) - (0, 0, crashoffset);
  crashtrace = ray_trace(crashstart, crashend, self);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  crashend = crashstart + 0.707 * crashdist * (-1 * jetforward - jetright) - (0, 0, crashoffset);

  if(ray_trace_passed(crashstart, crashend, self)) {
    crashpos = crashend;
    return crashpos;
  }

  return crashpos;
}

function choppergunner_explode() {
  if(istrue(self.isexploding)) {
    return;
  }

  self notify("explode");
  self.isexploding = 1;

  if(isDefined(self.owner)) {
    self radiusdamage(self.origin, 1000, 200, 200, self.owner, "MOD_EXPLOSIVE", "chopper_gunner_turret_ballistics_mp");
  }

  self setscriptablepartstate("explode", "on", 0);
  self setscriptablepartstate("explode_smoke", "on", 0);
  wait 0.35;
  thread choppergunner_delete(1);
}

function choppergunner_delete(wasdestroyed) {
  if(istrue(self.var_bf178f6894d17b96)) {
    return;
  }

  self.var_bf178f6894d17b96 = 1;

  if(issharedfuncdefined("player", "printGameAction")) {
    [[getsharedfunc("player", "printGameAction")]]("killstreak ended - chopperGunner", self.owner);
  }

  self.streakinfo.expiredbydeath = istrue(wasdestroyed);

  if(!istrue(self.recordedgameendstats)) {
    self.owner scripts\cp_mp\utility\killstreak_utility::recordkillstreakendstats(self.streakinfo);
  }

  self stoploopsound();

  if(isDefined(self.pilot)) {
    self.pilot delete();
  }

  if(isDefined(self.firetarget)) {
    self.firetarget delete();
  }

  if(isDefined(self.turret)) {
    self.turret setentityowner(undefined);
    self.turret delete();
  }

  if(isDefined(self.mpod1)) {
    self.mpod1 setentityowner(undefined);
    self.mpod1 delete();
  }

  if(isDefined(self.mpod2)) {
    self.mpod2 setentityowner(undefined);
    self.mpod2 delete();
  }

  level.choppergunners = array_remove(level.choppergunners, self);
  scripts\cp_mp\vehicles\vehicle_tracking::vehicle_tracking_deregisterinstance(self);
  scripts\cp_mp\vehicles\vehicle_tracking::_deletevehicle(self);
}

function choppergunner_returnplayer(crashing, thirdperson) {
  choppergunner_updatetargetmarkergroups(0);

  if(isDefined(level.var_f56a88761038798b)) {
    thread[[level.var_f56a88761038798b]](self.streakinfo);
  }

  var_a95a67a21665324a = self.owner;

  if(!isDefined(var_a95a67a21665324a)) {
    return;
  }

  streakinfo = self.streakinfo;
  thread function_70ff764379be5089(var_a95a67a21665324a, crashing, thirdperson, streakinfo);
  var_a95a67a21665324a notify("chopperGunner_returning_player");
  var_a95a67a21665324a endon("disconnect");

  if(issharedfuncdefined("game", "disable_backpack_inventory")) {
    var_a95a67a21665324a[[getsharedfunc("game", "disable_backpack_inventory")]](0);
  }

  if(isDefined(level.heli_pilot_mesh)) {
    level.heli_pilot_mesh hide();
  }

  if(isDefined(self.playersfx)) {
    self.playersfx stoploopsound();
    self.playersfx delete();
  }

  choppergunner_lockedonremovedcallback();
  var_a95a67a21665324a clearclienttriggeraudiozone(0.5);
  level callback::callback("killstreak_finish_use", {
    #streakinfo: streakinfo
  });

  if(isDefined(var_a95a67a21665324a)) {
    if(!istrue(thirdperson)) {
      var_a95a67a21665324a val::set("chopperGunner", "allow_movement", 0);
      var_a95a67a21665324a clearcinematicmotionoverride();
      var_a95a67a21665324a setthermalvision(0);
      var_a95a67a21665324a _setvisibiilityomnvarforkillstreak(streakinfo.streakname, "off");
      var_a95a67a21665324a setclientomnvar("ui_apache_controls", 0);
      var_a95a67a21665324a remotecontrolvehicleoff();
      var_a95a67a21665324a remotecontrolturretoff(self.turret);
      var_a95a67a21665324a killstreak_setmainvision("");
      var_a95a67a21665324a _stopshellshock();

      if(istrue(crashing)) {
        wait 0.05;
        var_a95a67a21665324a setclientomnvar("ui_apache_screens_state", 2);
        var_a95a67a21665324a thread function_d13d2a81214fbfb8("80_instant_noscale");
        var_a95a67a21665324a cameralinkTo(self.pilot, "tag_camera", 1, 1);
        var_a95a67a21665324a playlocalsound("mp_killstreak_apache_death_plr");

        if(!self.isexploding) {
          self waittill("explode");
        }

        var_a95a67a21665324a killstreak_setmainvision("killstreak_static");
        var_a95a67a21665324a cameraunlink();
        wait 1;
        var_a95a67a21665324a killstreak_setmainvision("");
      }

      var_a95a67a21665324a val::group_reset("chopperGunnerUse");
      var_a95a67a21665324a val::reset_all("chopperGunner");
      level thread restorekillstreakplayerangles(var_a95a67a21665324a);
      var_a95a67a21665324a function_8b676f496920e2ab();
      var_a95a67a21665324a setclientomnvar("ui_apache_screens_state", 0);
      var_a95a67a21665324a painvisionon();
      var_a95a67a21665324a killstreak_restorenvgstate();
      var_a95a67a21665324a.usingchoppergunner = undefined;
    }
  }

  var_a95a67a21665324a notify("chopperGunner_finished_crash_anim");
  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

function function_70ff764379be5089(owner, crashing, thirdperson, streakinfo) {
  if(!istrue(crashing)) {
    return;
  }

  self endon("explode");
  owner endon("disconnect");
  streakinfo endon("killstreak_finished_with_deploy_weapon");
  level endon("game_ended");
  self waittill("death");

  iprintln("<dev string:x1f3>");

  if(!istrue(thirdperson)) {
    owner killstreak_setmainvision("killstreak_static");
    owner cameraunlink();
    owner killstreak_setmainvision("");
    level thread restorekillstreakplayerangles(owner);
    owner function_8b676f496920e2ab();
    owner setclientomnvar("ui_apache_screens_state", 0);
    owner painvisionon();
    owner killstreak_restorenvgstate();
    owner.usingchoppergunner = undefined;
  }

  streakinfo notify("killstreak_finished_with_deploy_weapon");
}

function choppergunner_watchearlyexit(thirdperson) {
  self endon("death");
  self endon("leaving");
  self endon("crashing");

  if(issharedfuncdefined("killstreak", "allowRideKillstreakPlayerExit")) {
    self thread[[getsharedfunc("killstreak", "allowRideKillstreakPlayerExit")]]("leaving");
  }

  self waittill("killstreakExit");
  thread choppergunner_leave(thirdperson);
}

function choppergunner_handlemissiledetection(player, missileteam, missiletarget, fxtagoverride) {
  self endon("death");

  while(true) {
    if(!isDefined(missiletarget)) {
      break;
    }

    center = missiletarget getpointinbounds(0, 0, 0);
    curdist = distance(self.origin, center);

    if(curdist < 4000 && missiletarget.flaresreservecount > 0) {
      if(issharedfuncdefined("flares", "reduceReserves")) {
        [[getsharedfunc("flares", "reduceReserves")]](missiletarget);
      }

      if(issharedfuncdefined("flares", "playFx")) {
        missiletarget thread[[getsharedfunc("flares", "playFx")]](undefined, fxtagoverride);
      }

      missiletarget playkillstreakoperatordialog("chopper_gunner", "chopper_gunner" + "_flares", undefined, undefined, "pilot");
      newtarget = undefined;

      if(issharedfuncdefined("flares", "deploy")) {
        newtarget = missiletarget[[getsharedfunc("flares", "deploy")]]();
      }

      if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
        missiletarget[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](player);
      }

      self missile_settargetEnt(newtarget);
      self notify("missile_pairedWithFlare");
      return;
    }

    waitframe();
  }
}

function isusingchoppergunner() {
  return isDefined(self.usingchoppergunner);
}

function choppergunner_watchexplosioninfluencepoint(owner, lifetime, radius, height) {
  owner endon("disconnect");
  level endon("game_ended");
  self waittill("explode", position);
  owner notify("gunner_turret_impact", position);

  if(issharedfuncdefined("spawn", "addSpawnDangerZone")) {
    [[getsharedfunc("spawn", "addSpawnDangerZone")]](position, radius, height, owner.team, lifetime, owner, 1);
  }
}

function function_20b002475b7af53b(data) {
  if(isDefined(self)) {
    choppergunner_handledeathdamage(data);
  }
}

function function_c77d8b1c3a992f19(var_5e0676140eecdf2d) {
  lighting_info = spawnStruct();

  if(isDefined(var_5e0676140eecdf2d) && isent(var_5e0676140eecdf2d)) {
    probe = getEnt(var_5e0676140eecdf2d, "script_noteworthy");
  } else {
    probe = spawnStruct();

    self iprintln("<dev string:x23e>");
  }

  lighting_info.probe = probe;
  var_ad02eaa051593bff = [];
  var_ad02eaa051593bff["pos"] = probe.origin;
  var_ad02eaa051593bff["rot"] = probe.angles;
  lighting_info.var_af2c99167339224 = var_ad02eaa051593bff;
  return lighting_info;
}

function function_546c923a292bab24(lighting_info) {
  if(!isDefined(lighting_info) || !isent(lighting_info)) {
    return;
  }

  self.owner iprintln("<dev string:x2a6>");

  lighting_info.probe linkTo(self, "tag_origin", (109, 0, -62), (0, 0, 0));
}

function function_38101db6ed950f17(lighting_info) {
  if(!isDefined(lighting_info) || !isent(lighting_info)) {
    return;
  }

  self.owner iprintln("<dev string:x2cb>");

  lighting_info.probe unlink();
  lighting_info.probe.origin = lighting_info.var_af2c99167339224["pos"];
  lighting_info.probe.angles = lighting_info.var_af2c99167339224["rot"];
}

function function_2926a76719559d56() {
  turretweapon = "chopper_gunner_turret_ballistics_mp";

  if(utility::iscp()) {
    turretweapon = "chopper_gunner_turret_cp";
  }

  return turretweapon;
}

function function_d33b650337c6008b(data) {
  self endon("death");
  self notify("chopperGunner_mini_emp_hit");
  self endon("chopperGunner_mini_emp_hit");
  self.owner _setvisibiilityomnvarforkillstreak(self.streakname, "off");
  wait 0.1;
  self.owner _setvisibiilityomnvarforkillstreak(self.streakname, "on");
  wait 0.05;
  self.owner _setvisibiilityomnvarforkillstreak(self.streakname, "off");
  wait 0.25;
  self.owner _setvisibiilityomnvarforkillstreak(self.streakname, "on");

  if(!isDefined(self.var_e8d88b601e41fba5) && self.flaresreservecount > 0) {
    self.var_e8d88b601e41fba5 = gettime();

    if(issharedfuncdefined("flares", "reduceReserves")) {
      [[getsharedfunc("flares", "reduceReserves")]](self);
    }

    if(issharedfuncdefined("flares", "playFx")) {
      self thread[[getsharedfunc("flares", "playFx")]](undefined);
    }

    if(issharedfuncdefined("flares", "deploy")) {
      self[[getsharedfunc("flares", "deploy")]]();
    }

    if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
      self[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](data.attacker);
    }

    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("emped_killstreak");
    }

    return;
  }

  if(self.flaresreservecount > 0 && self.var_e8d88b601e41fba5 <= gettime() - 10000) {
    self.var_e8d88b601e41fba5 = gettime();

    if(issharedfuncdefined("flares", "reduceReserves")) {
      [[getsharedfunc("flares", "reduceReserves")]](self);
    }

    if(issharedfuncdefined("flares", "playFx")) {
      self thread[[getsharedfunc("flares", "playFx")]](undefined);
    }

    if(issharedfuncdefined("flares", "deploy")) {
      self[[getsharedfunc("flares", "deploy")]]();
    }

    if(issharedfuncdefined("killstreak", "updateScrapAssistDataForceCredit")) {
      self[[getsharedfunc("killstreak", "updateScrapAssistDataForceCredit")]](data.attacker);
    }

    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]]("emped_killstreak");
    }
  }
}

function function_750ac5d7f30cbbf8(choppergunner) {
  choppergunner endon("<dev string:x62>");
  choppergunner endon("<dev string:x2f2>");

  while(true) {
    vehiclespeed = choppergunner vehicle_getspeed();
    self iprintln("<dev string:x2fc>" + vehiclespeed);
    wait 0.5;
  }
}

function function_dc4cb73de48ec3d6() {
  self endon("<dev string:x62>");
  self.owner endon("<dev string:x129>");
  self.owner notifyonplayercommand("<dev string:x30d>", "<dev string:x320>");
  state = "<dev string:x329>";

  while(true) {
    var_ae20b84817daf1 = getdvarint(@ "hash_6dcbef72bd1fd758", 0);

    if(!istrue(var_ae20b84817daf1)) {
      waitframe();
      continue;
    }

    self.owner waittill("<dev string:x30d>");

    if(state == "<dev string:x329>") {
      state = "<dev string:x32c>";
    } else {
      state = "<dev string:x329>";
    }

    self setscriptablepartstate("<dev string:x330>", state, 0);
  }
}

function function_8ad708731e47d367() {
  self endon("<dev string:x62>");
  wait 10;
  data = scripts\cp_mp\utility\damage_utility::packdamagedata(self.owner, self, 1, self.currentprimaryweapon, "<dev string:x337>", self);
  function_d33b650337c6008b(data);
  wait 10;
  function_d33b650337c6008b(data);
}

# /