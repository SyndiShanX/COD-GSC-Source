/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_518ae857a3d351c.gsc
************************************************/

#using scripts\common\utility;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\utility\debug_utility;
#using scripts\engine\math;
#using scripts\engine\scriptable;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\flags;
#namespace namespace_6582714a62ad086d;

function init() {
  if(!isDefined(level.var_cbe618f35b332990)) {
    level.var_cbe618f35b332990 = spawn("script_origin", (0, 0, 0));
  }

  load_laser_fx();
  initsentrysettings();
  scripts\engine\scriptable::scriptable_addusedcallbackbypart("trap_defuse_object", &function_836cdac4b1d38941);

  level thread function_6e8b6dce68b1c1ea();
}

function load_laser_fx() {
  level._effect["vfx_laser_smoke"] = loadfx("vfx/iw8_cp/raid/vfx_cp_steampipe_exp.vfx");
  level._effect["vfx_laser_pointer"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp.vfx");
  level._effect["vfx_laser_pointer_thermal"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_thermalonly.vfx");
  level._effect["vfx_laser_pointer_nvg"] = loadfx("vfx/iw9/cp/vfx_red_laser_cp_nvgonly.vfx");
  level._effect["vfx_laser_destroy"] = loadfx("vfx/iw8_cp/vfx_red_laser_cp_destroy.vfx");
  level._effect["vfx_laser_burn"] = loadfx("vfx/iw8_cp/raid/lava/vfx_raid_laser_burn.vfx");
  level._effect["vfx_turret_light"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light.vfx");
  level._effect["vfx_c4_explode"] = loadfx("vfx/iw9/core/equipment/c4/vfx_equip_c4_gen_ch.vfx");
  level._effect["vfx_turret_light_5"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_0_5s.vfx");
  level._effect["vfx_turret_light_175"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_1_75s.vfx");
  level._effect["vfx_turret_light_2"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_2_0s.vfx");
  level._effect["vfx_turret_light_3"] = loadfx("vfx/iw9/cp/vfx_cp_turret_light_3_0s.vfx");
  level._effect["vfx_laser_destroy_nvg"] = loadfx("vfx/iw9/cp/vfx_red_laser_cp_nvgonly_die.vfx");
  level._effect["vfx_laser_destroy_end"] = loadfx("vfx/iw9/core/lasers/vfx_laser_nvg_end_die.vfx");
}

function initsentrysettings() {
  level.sentrysettings["bs_laser"] = spawnStruct();
  level.sentrysettings["bs_laser"].health = 999999;
  level.sentrysettings["bs_laser"].maxhealth = 350;
  level.sentrysettings["bs_laser"].burstmin = 20;
  level.sentrysettings["bs_laser"].burstmax = 120;
  level.sentrysettings["bs_laser"].pausemin = 0.15;
  level.sentrysettings["bs_laser"].pausemax = 0.35;
  level.sentrysettings["bs_laser"].maxrange = 4000000;
  level.sentrysettings["bs_laser"].laserrange = 7562500;
  level.sentrysettings["bs_laser"].lockstrength = 2;
  level.sentrysettings["bs_laser"].sentrymodeon = "manual";
  level.sentrysettings["bs_laser"].sentrymodeoff = "sentry_offline";
  level.sentrysettings["bs_laser"].ammo = 200;
  level.sentrysettings["bs_laser"].timeout = 999999;
  level.sentrysettings["bs_laser"].spinuptime = 0.65;
  level.sentrysettings["bs_laser"].overheattime = 8;
  level.sentrysettings["bs_laser"].cooldowntime = 0.1;
  level.sentrysettings["bs_laser"].fxtime = 0.3;
  level.sentrysettings["bs_laser"].streakname = "sentry_gun";
  level.sentrysettings["bs_laser"].weaponinfo = "laser_trap_nvg";
  level.sentrysettings["bs_laser"].playerweaponinfo = "laser_trap_nvg";
  level.sentrysettings["bs_laser"].scriptable = "ks_sentry_turret_mp";
  level.sentrysettings["bs_laser"].modelbasecover = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modelbaseground = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modeldestroyedcover = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].modeldestroyedground = "electronics_ir_laser_device_assembly_nogeo";
  level.sentrysettings["bs_laser"].placementhintstring = &"KILLSTREAKS_HINTS/SENTRY_GUN_PLACE";
  level.sentrysettings["bs_laser"].ownerusehintstring = &"KILLSTREAKS_HINTS/SENTRY_USE";
  level.sentrysettings["bs_laser"].otherusehintstring = &"KILLSTREAKS_HINTS/SENTRY_OTHER_USE";
  level.sentrysettings["bs_laser"].dismantlehintstring = &"KILLSTREAKS_HINTS/SENTRY_DISMANTLE";
  level.sentrysettings["bs_laser"].headicon = 1;
  level.sentrysettings["bs_laser"].teamsplash = "used_sentry_gun";
  level.sentrysettings["bs_laser"].destroyedsplash = "callout_destroyed_sentry_gun";
  level.sentrysettings["bs_laser"].shouldsplash = 1;
  level.sentrysettings["bs_laser"].votimeout = "sentry_shock_timeout";
  level.sentrysettings["bs_laser"].vodestroyed = "sentry_shock_destroy";
  level.sentrysettings["bs_laser"].scorepopup = "destroyed_sentry";
  level.sentrysettings["bs_laser"].lightfxtag = "tag_fx";
  level.sentrysettings["bs_laser"].iskillstreak = 1;
  level.sentrysettings["bs_laser"].headiconoffset = (0, 0, 75);
  level.sentrysettings["bs_laser"].ignoreownerteam = 0;
  level.sentrysettings["bs_laser"].var_b58e018f63b5d93b = 2;
  level.sentrysettings["bs_laser"].laserexplosion = 1;
  level.sentrysettings["bs_laser"].trapmindamage = 100;
  level.sentrysettings["bs_laser"].trapmaxdamage = 200;
  level.sentrysettings["bs_laser"].var_bd106a486cdfd461 = 384;
  level.sentrysettings["bs_laser"].trapdamageweapon = "frag_grenade_mp";
  level.sentrysettings["bs_laser"].trapmeansofdeath = "MOD_EXPLOSIVE";
}

function function_d1acadc2a0b9e115(config, struct, team, model, weapon) {
  turret = spawnturret("misc_turret", struct.origin, weapon);
  turret.team = team;
  turret setturretteam(team);
  turret.angles = struct.angles;
  turret.health = config.maxhealth;
  turret.maxhealth = config.maxhealth;
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 2;
  turret.maxrange = config.maxrange;
  turret.laserrange = config.laserrange;

  if(isDefined(struct.radius)) {
    maxdistsq = struct.radius * struct.radius;
    turret.maxrange = int(maxdistsq - maxdistsq * 0.1);
    turret.laserrange = int(maxdistsq);
  }

  turret setModel(model);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.2);
  turret maketurretinoperable();
  turret setleftarc(180);
  turret setrightarc(180);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(0.6, "pitch");
  turret setconvergencetime(0.6, "yaw");
  turret setconvergenceheightpercent(0.65);
  turret setdefaultdroppitch(-89);
  turret setturretmodechangewait(1);
  return turret;
}

function setup_sentry(var_804269875f5062f1, team, damage_type, turret_model, parent_struct, weapon_info) {
  sentrytype = "bs_laser";
  config = level.sentrysettings[sentrytype];

  if(!isDefined(weapon_info)) {
    weapon_info = level.sentrysettings[sentrytype].weaponinfo;
  }

  if(!isDefined(team)) {
    team = "axis";
  }

  if(!isDefined(var_804269875f5062f1.angles)) {
    var_804269875f5062f1.angles = (0, 0, 0);
  }

  if(!isDefined(turret_model)) {
    turret_model = "electronics_ir_laser_device_assembly_nogeo";
  }

  turret = function_d1acadc2a0b9e115(config, var_804269875f5062f1, team, turret_model, weapon_info);
  turret.sentrytype = sentrytype;
  turret.turrettype = sentrytype;
  turret.damage_type = damage_type;
  turret scripts\cp_mp\emp_debuff::set_start_emp_callback(&sentryturret_empstarted);
  turret scripts\cp_mp\emp_debuff::set_clear_emp_callback(&sentryturret_empcleared);
  turret scripts\cp_mp\emp_debuff::allow_emp(0);
  var_804269875f5062f1.turret = turret;
  turret.sentry_struct = var_804269875f5062f1;
  turret.parent_struct = parent_struct;

  if(!isDefined(level.killstreak_additional_targets)) {
    level.killstreak_additional_targets = [];
  }

  level.killstreak_additional_targets = array_add(level.killstreak_additional_targets, turret);

  if(!isDefined(level.var_ceef08cfb883a461)) {
    level.var_ceef08cfb883a461 = [];
  }

  level.var_ceef08cfb883a461 = array_add(level.var_ceef08cfb883a461, turret);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeon);
  turret scripts\cp_mp\emp_debuff::allow_emp(1);
  turret sentryturret_empupdate();
  turret laseron();
  turret thread function_42929a0d4354a323();
  turret thread function_a9a8361dace89499();
  turret notify("lasers_started");
  return turret;
}

function sentryturret_empstarted(data) {
  if(isDefined(data.attacker) && isPlayer(data.attacker) && function_f3bb4f4911a1beb2("game", "getGameType") != "wm") {
    if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
      data.attacker thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]](#"hash_7410841fd4c63028");
    }
  }

  sentryturret_empupdate();
}

function sentryturret_empcleared(isdeath) {
  if(isdeath) {
    return;
  }

  sentryturret_empupdate();
}

function sentryturret_empupdate() {
  if(scripts\cp_mp\emp_debuff::is_empd()) {
    self turretfiredisable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeoff);
    self laseroff();
    return;
  }

  if(!istrue(self.killed) && !istrue(self.defused)) {
    self turretfireenable();
    self setmode(level.sentrysettings[self.turrettype].sentrymodeon);
    self laseron();
  }
}

function sentryturret_setinactive(turret) {
  turret setdefaultdroppitch(30);
  turret setmode(level.sentrysettings[turret.turrettype].sentrymodeoff);
}

function function_42929a0d4354a323() {
  self endon("death");
  self endon("exit_idle");
  self endon("stop_idle_movement");

  if(isDefined(self.state) && self.state == "idle") {
    return;
  }

  self stopfiring();
  self.state = "idle";
  self notify("enter_idle");
  self notify("stop_shooting");
  tag = "tag_laser";

  if(!hastag(self.model, tag)) {
    tag = "tag_turret";
  }

  if(isDefined(self.idle_func)) {
    self[[self.idle_func]]();
    return;
  }

  sentry_origin = self.sentry_struct.origin;
  sentry_angles = self.sentry_struct.angles;
  var_878bae61aca86fc5 = anglesToForward(sentry_angles);
  var_a1b727d30fc62a0f = anglestoup(sentry_angles);
  var_1b77e17a42e2545b = anglestoleft(sentry_angles);
  var_6232855eba31163a = anglestoright(sentry_angles);
  maxangle = 15;
  var_b716ed1e1043d49d = rotatepointaroundvector(var_a1b727d30fc62a0f, var_878bae61aca86fc5, maxangle);
  var_37acb3a5ef4e3396 = vectorNormalize(vectorcross(var_b716ed1e1043d49d, var_a1b727d30fc62a0f));
  var_13b2c03f423eb4f1 = vectorcross(var_37acb3a5ef4e3396, var_b716ed1e1043d49d);
  var_5a8f11024e7733a5 = axistoangles(var_b716ed1e1043d49d, var_37acb3a5ef4e3396, var_13b2c03f423eb4f1);
  var_f4feef348ddcce80 = rotatepointaroundvector(var_a1b727d30fc62a0f, var_878bae61aca86fc5, maxangle * -1);
  var_28a104b41542054b = vectorNormalize(vectorcross(var_f4feef348ddcce80, var_a1b727d30fc62a0f));
  var_71068ef94589e94a = vectorcross(var_28a104b41542054b, var_f4feef348ddcce80);
  var_6b5bd2eb86959740 = axistoangles(var_f4feef348ddcce80, var_28a104b41542054b, var_71068ef94589e94a);
  var_d5c157bf3efda129 = vectortoangles(var_a1b727d30fc62a0f);
  var_3c19d396e8243a45 = vectortoangles(var_878bae61aca86fc5);
  var_a0d15869f98efc85 = vectortoangles(var_1b77e17a42e2545b);
  var_10972f86bc3d391e = vectortoangles(var_6232855eba31163a);
  self function_83ea6f9ebc30c9a4(var_878bae61aca86fc5);
  self.aimlocation = self gettagorigin(tag) + anglesToForward(self gettagangles(tag)) * 3000;

  if(getdvarint(@ "hash_388b2c9297bbe819", 0) != 0) {
    debugstar(self gettagorigin(tag), (1, 1, 0), 5000, tag, 0.1);
  }

  var_4a5d9d7667048bf3 = scripts\engine\trace::create_world_contents();

  if(!self.sentry_struct function_a0857113d8c32a2a()) {
    sentry_origin = self gettagorigin(tag);
    newdir = anglesToForward(var_3c19d396e8243a45);
    newpos = sentry_origin + newdir * 2000;
    trace = scripts\engine\trace::ray_trace(sentry_origin, newpos, self, var_4a5d9d7667048bf3);
    end = trace["position"];
    self.aimlocation = (newpos[0], newpos[1], sentry_origin[2]);
    self function_83ea6f9ebc30c9a4(self.aimlocation - sentry_origin);
    vmidpoint = (sentry_origin + end) / 2;
    function_a890d51e917ad74(1, vmidpoint);
    waitframe();

    while(true) {
      function_c2659db9dbffda55(var_5a8f11024e7733a5, 10, "left");
      function_c2659db9dbffda55(var_3c19d396e8243a45, 10, "fwd");
      function_c2659db9dbffda55(var_6b5bd2eb86959740, 10, "right");
      function_c2659db9dbffda55(var_3c19d396e8243a45, 10, "fwd");
    }

    return;
  }

  tag = "tag_laser";

  if(!hastag(self.model, tag)) {
    tag = "tag_turret";
  }

  sentry_origin = self gettagorigin(tag);
  newpos = sentry_origin + var_878bae61aca86fc5 * 2000;
  trace = scripts\engine\trace::ray_trace(sentry_origin, newpos, self, var_4a5d9d7667048bf3);
  end = trace["position"];
  self.aimlocation = (end[0], end[1], sentry_origin[2]);
  vmidpoint = (sentry_origin + end) / 2;
  thread function_a890d51e917ad74(undefined, vmidpoint);
}

function vectortoanglessafe(forward, up) {
  right = vectorcross(forward, up);
  up = vectorcross(right, forward);
  angles = axistoangles(forward, right, up);
  return angles;
}

function function_c2659db9dbffda55(angles, timehere, debug_text) {
  if(!isDefined(timehere)) {
    timehere = 4;
  }

  timemove = timehere * 0.7;
  timestop = timehere - timemove;
  tag = "tag_laser";

  if(!hastag(self.model, tag)) {
    tag = "tag_turret";
  }

  sentry_origin = self gettagorigin(tag);
  newdir = anglesToForward(angles);
  newpos = sentry_origin + newdir * 2000;
  newposfinal = (newpos[0], newpos[1], sentry_origin[2]);
  var_b7a91148551c964d = self.aimlocation;
  timestart = gettime();
  timetotal = timemove * 1000;

  while(true) {
    timepass = gettime() - timestart;

    if(timepass > timetotal) {
      break;
    }

    self.aimlocation = vectorlerp(var_b7a91148551c964d, newposfinal, timepass / timetotal);
    self function_83ea6f9ebc30c9a4(self.aimlocation - sentry_origin);
    waitframe();
  }

  if(getdvarint(@ "hash_69de6d4d9ba136d1", 0)) {
    if(isDefined(debug_text)) {
      announcement(debug_text);
    }

    level thread scripts\cp_mp\utility\debug_utility::drawline(self.origin, newposfinal, timehere, (1, 0, 0));
  }

  wait timestop;
}

function function_2cc59ea2a67bd2f4(struct, turrets, var_54c186a6b8a2ae1, owner) {
  scriptablename = default_to(var_54c186a6b8a2ae1, "dmz_lasertrap");
  struct.defuseobj = spawnscriptable(scriptablename, struct.origin, struct.angles);
  struct.defuseobj.turret_structs = getStructArray(struct.target, "targetname");
  struct.defuseobj.parent_struct = struct;

  if(isDefined(owner)) {
    struct.owner = owner;
  }

  if(!isDefined(level.var_da28469a4f1d6123)) {
    level.var_da28469a4f1d6123 = [];
  }

  level.var_da28469a4f1d6123[level.var_da28469a4f1d6123.size] = struct;

  if(function_ee8a913e5baf0c5d()) {
    if(scripts\common\utility::iscp()) {
      wait 2;
    } else {
      scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
      waitframe();
    }

    foreach(turret in turrets) {
      turret thread function_62171a49e3430e0a(struct);
    }
  }
}

function function_ee8a913e5baf0c5d() {
  if(getdvarint(@ "hash_7693c920bebdb71b", 1) != 0) {
    return true;
  }

  return false;
}

function function_836cdac4b1d38941(instance, part, state, player, var_a5b2c541413aa895, usestring) {
  if(part == "trap_defuse_object") {
    instance setscriptablepartstate("trap_defuse_object", "off");
    defusestruct = instance.parent_struct;
    dropfunc = scripts\engine\utility::function_6a11999c562cf4ab("lasertrap", "createLootDropInfo");

    if(isDefined(dropfunc)) {
      dropinfo = [[dropfunc]](defusestruct.origin, defusestruct.angles, undefined, 0, 0, undefined, 1);
      [[scripts\engine\utility::getsharedfunc("lasertrap", "spawnPickup")]]("brloot_offhand_c4", dropinfo, 1, 1);
    }

    playsoundatpos(defusestruct.origin, "cp_laser_disable");

    foreach(turret in defusestruct.turrets) {
      sentryturret_setinactive(turret);
      playFX(level._effect["vfx_laser_destroy_nvg"], turret.origin);
      start = turret gettagorigin("tag_laser");
      trace = scripts\engine\trace::ray_trace(start, turret.aimlocation);
      end = trace["position"];
      playFX(level._effect["vfx_laser_destroy_end"], start);
      playFX(level._effect["vfx_laser_destroy_end"], end);
      turret setmode("sentry_offline");
      turret laseroff();
      turret.defused = 1;

      if(function_ee8a913e5baf0c5d()) {
        turret thread function_571c0f2116929a45();
      }

      turret notify("stop_idle_movement");

      if(!turret.sentry_struct function_a0857113d8c32a2a()) {
        turret function_d33f98412123374(1);
        continue;
      }

      turret function_d33f98412123374();
    }

    if(isDefined(player)) {
      var_e37a12ded171977e = scripts\engine\utility::function_6a11999c562cf4ab("lasertrap", "customDefuseScoreEventFunc");

      if(isDefined(var_e37a12ded171977e)) {
        [[var_e37a12ded171977e]](player);
        return;
      }

      if(scripts\engine\utility::issharedfuncdefined("player", "doScoreEvent")) {
        player thread[[scripts\engine\utility::getsharedfunc("player", "doScoreEvent")]](#"hash_392cd4486f5ab82e");
      }
    }
  }
}

function function_571c0f2116929a45() {
  if(isDefined(self.parent_struct.script_index)) {
    if(self.parent_struct.script_index == "0.5") {
      stopFXOnTag(level._effect["vfx_turret_light_5"], self, "tag_fx");
    }

    if(self.parent_struct.script_index == "1.75") {
      stopFXOnTag(level._effect["vfx_turret_light_175"], self, "tag_fx");
    }

    if(self.parent_struct.script_index == "2") {
      stopFXOnTag(level._effect["vfx_turret_light_2"], self, "tag_fx");
    }

    if(self.parent_struct.script_index == "3") {
      stopFXOnTag(level._effect["vfx_turret_light_3"], self, "tag_fx");
    }
  }
}

function function_a9a8361dace89499() {
  level endon("game_ended");
  self endon("death");
  self endon("stop_idle_movement");

  if(scripts\common\utility::iscp()) {
    flag_wait("player_spawned_with_loadout");
  } else {
    scripts\mp\flags::function_1240434f4201ac9d("prematch_done");
  }

  var_7644d2741c9ab230 = level.sentrysettings["bs_laser"];
  delayseconds = var_7644d2741c9ab230.var_b58e018f63b5d93b;

  if(delayseconds > 0) {
    wait delayseconds;
  }

  var_4a5d9d7667048bf3 = scripts\engine\trace::create_character_contents();

  while(true) {
    if(scripts\cp_mp\emp_debuff::is_empd()) {
      waitframe();
      continue;
    }

    start = self gettagorigin("tag_laser");
    nearby_players = sortbydistancecullbyradius(level.players, start, 1024);

    if(nearby_players.size == 0) {
      waitframe();
      continue;
    }

    trace = scripts\engine\trace::ray_trace(start, self.aimlocation);
    end = trace["position"];

    if(getdvarint(@ "hash_388b2c9297bbe819", 0) != 0) {
      line(start, end, (1, 0, 0), 1, 0, 1);
    }

    trace = scripts\engine\trace::ray_trace(start, end, [], var_4a5d9d7667048bf3);

    if(isDefined(trace["entity"]) && trace["hittype"] == "hittype_entity") {
      if(isPlayer(trace["entity"])) {
        player = trace["entity"];

        if(istrue(var_7644d2741c9ab230.ignoreownerteam) && is_equal(player.pers["team"], self.team)) {
          waitframe();
          continue;
        }

        defuse_struct = self.parent_struct;

        if(isDefined(player) && isPlayer(player)) {
          player.var_230a3287f9ad2965 = 1;
          player.shouldskipdeathsshield = 1;
        }

        playsoundatpos(defuse_struct.origin, "cp_laser_trigger");
        time = min(2, lookupsoundlength("cp_laser_trigger") * 0.001);
        wait time;

        if(function_f3bb4f4911a1beb2("game", "getGameType") == "wm") {
          var_ca1c9242e75e271 = anglesToForward(defuse_struct.angles);

          if(var_ca1c9242e75e271[0] > 0) {
            var_ca1c9242e75e271 = (1, var_ca1c9242e75e271[1], 0);
          } else {
            var_ca1c9242e75e271 = (-1, var_ca1c9242e75e271[1], 0);
          }

          if(var_ca1c9242e75e271[1] > 0) {
            var_ca1c9242e75e271 = (var_ca1c9242e75e271[0], 1, 0);
          } else {
            var_ca1c9242e75e271 = (var_ca1c9242e75e271[0], -1, 0);
          }

          playsoundatpos(defuse_struct.origin + (var_ca1c9242e75e271[0], var_ca1c9242e75e271[1], 0) * 10, "cp_laser_expl");
        } else {
          playsoundatpos(defuse_struct.origin, "cp_laser_expl");
        }

        mindamage = getdvarint(@ "hash_ea6e58c378d245e5", var_7644d2741c9ab230.trapmindamage);
        maxdamage = getdvarint(@ "hash_d5ff13fe4588f203", var_7644d2741c9ab230.trapmaxdamage);
        traprange = getdvarint(@ "hash_db8f6fd15e9a7db6", var_7644d2741c9ab230.var_bd106a486cdfd461);
        meansofdeath = var_7644d2741c9ab230.trapmeansofdeath;
        damageweapon = var_7644d2741c9ab230.trapdamageweapon;
        attacker = ter_op(isDefined(defuse_struct.owner), defuse_struct.owner, level.var_cbe618f35b332990);

        foreach(turr in defuse_struct.turrets) {
          if(!turr scripts\cp_mp\emp_debuff::is_empd() && istrue(var_7644d2741c9ab230.laserexplosion)) {
            level.var_cbe618f35b332990 radiusdamage(turr.soundorg.origin, traprange, maxdamage, mindamage, attacker, meansofdeath, damageweapon);
          }
        }

        level.var_cbe618f35b332990 radiusdamage(defuse_struct.origin, traprange, maxdamage, mindamage, attacker, meansofdeath, damageweapon);
        playrumbleonposition("grenade_rumble", defuse_struct.origin);
        earthquake(0.45, 0.7, defuse_struct.origin, 800);
        level notify("trigger_reinforcements_if_applicable");
        playFX(level._effect["vfx_laser_destroy_nvg"], start);
        playFX(level._effect["vfx_laser_destroy_end"], start);
        playFX(level._effect["vfx_laser_destroy_nvg"], end);
        playFX(level._effect["vfx_laser_destroy_end"], end);

        foreach(turret in defuse_struct.turrets) {
          if(!turret.sentry_struct function_a0857113d8c32a2a()) {
            turret function_d33f98412123374(1);
          } else {
            turret function_d33f98412123374();
          }

          if(self != turret) {
            thread function_277b35006fab38dd(turret);
          }
        }

        if(isDefined(defuse_struct.defuseobj)) {
          defuse_struct.defuseobj setscriptablepartstate("trap_defuse_object", "off");
          playFX(level._effect["vfx_c4_explode"], defuse_struct.defuseobj.origin);
        }

        thread function_277b35006fab38dd(self);
        return;
      }
    }

    waitframe();
  }
}

function function_277b35006fab38dd(turret) {
  turret playSound("recon_drone_explode");

  if(function_ee8a913e5baf0c5d()) {
    turret thread function_571c0f2116929a45();
  }

  sentryturret_setinactive(turret);
  turret.killed = 1;
  turret laseroff();
  turret notify("stop_idle_movement");
}

function function_a0857113d8c32a2a() {
  if(isDefined(self.script_groupname) && self.script_groupname == "nomove") {
    return true;
  }

  return false;
}

function function_62171a49e3430e0a(struct) {
  self endon("death");
  self endon("stop_idle_movement");

  if(isDefined(struct.script_index)) {
    if(struct.script_index == "0.5") {
      playFXOnTag(level._effect["vfx_turret_light_5"], self, "tag_fx");
      return;
    }

    if(struct.script_index == "1.75") {
      playFXOnTag(level._effect["vfx_turret_light_175"], self, "tag_fx");
      return;
    }

    if(struct.script_index == "2") {
      playFXOnTag(level._effect["vfx_turret_light_2"], self, "tag_fx");
      return;
    }

    if(struct.script_index == "3") {
      playFXOnTag(level._effect["vfx_turret_light_3"], self, "tag_fx");
    }
  }
}

function function_a890d51e917ad74(var_f095df44cb4d44c3, var_b1912d395068cf48) {
  self endon("death");

  if(isDefined(var_b1912d395068cf48) && isvector(var_b1912d395068cf48)) {
    self.soundorg = spawn("script_model", var_b1912d395068cf48);
  } else {
    self.soundorg = spawn("script_model", self.origin);
  }

  self.soundorg setModel("tag_origin");
  waitframe();

  if(!istrue(var_f095df44cb4d44c3)) {
    self.soundorg playLoopSound("cp_laser_idle");
    return;
  }

  self.soundorg linkTo(self, "tag_aim_pivot");
  self.soundorg playLoopSound("cp_laser_mvmt");
}

function function_d33f98412123374(var_f095df44cb4d44c3) {
  if(!istrue(var_f095df44cb4d44c3)) {
    self.soundorg stoploopsound("cp_laser_idle");
  } else {
    self.soundorg stoploopsound("cp_laser_mvmt");
  }

  self.soundorg delete();
}

function function_6e8b6dce68b1c1ea() {
  level endon("<dev string:x1c>");
  setdevdvarifuninitialized(@ "hash_388b2c9297bbe819", 0);

  while(true) {
    if(getdvarint(@ "hash_388b2c9297bbe819", 0) != 0 && isDefined(level.var_da28469a4f1d6123)) {
      for(i = 0; i < level.var_da28469a4f1d6123.size; i++) {
        trap = level.var_da28469a4f1d6123[i];
        sphere(trap.origin, 32, (1, 0, 0), 0, 1);
        text = "<dev string:x2a>";

        if(isDefined(trap.defuseobj)) {
          text = "<dev string:x2e>" + trap.defuseobj getscriptablepartstate("<dev string:x3c>");
          turrets = ter_op(isDefined(trap.turrets), trap.turrets, trap.defuseobj.turret_structs);

          foreach(turret in turrets) {
            if(isDefined(turret)) {
              line(trap.origin, turret.origin, (1, 1, 0), 0.8, 0, 1);
            }
          }
        } else {
          text = "<dev string:x52>";
        }

        print3d(trap.origin, text, (1, 0, 0), 1, 0.7, 1, 0);
      }
    }

    waitframe();
  }
}

# /