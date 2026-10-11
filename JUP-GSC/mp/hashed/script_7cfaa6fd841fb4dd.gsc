/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_7cfaa6fd841fb4dd.gsc
*************************************************/

#using script_16ea1b94f0f381b3;
#using script_220d0eb95a8fab7d;
#using script_2304453c69e996e2;
#using scripts\common\anim;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\values;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\emp_debuff;
#using scripts\cp_mp\entityheadicons;
#using scripts\cp_mp\equipment\haywire;
#using scripts\cp_mp\hostmigration;
#using scripts\cp_mp\killstreaks\airstrike;
#using scripts\cp_mp\killstreaks\helper_drone;
#using scripts\cp_mp\targetmarkergroups;
#using scripts\cp_mp\utility\killstreak_utility;
#using scripts\cp_mp\utility\player_utility;
#using scripts\cp_mp\vehicles\vehicle_tracking;
#using scripts\engine\scriptable;
#using scripts\engine\throttle;
#using scripts\engine\trace;
#using scripts\engine\utility;
#using scripts\mp\agents\agent_utility;
#using scripts\mp\ai_sentry_turret;
#using scripts\mp\damage;
#using scripts\mp\equipment\at_mine;
#using scripts\mp\equipment\claymore;
#using scripts\mp\equipment_interact;
#using scripts\mp\mp_agent;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\sentientpoolmanager;
#using scripts\mp\utility\debug;
#using scripts\mp\weapons;
#using scripts\stealth\enemy;
#namespace namespace_17b45e55cf344cda;

function function_946f326db0ef7292() {}

function function_5881a353a471bd02(aitype, position, angles, team, tier, groupname) {
  if(aitype == "civ") {
    var_2d0885860b423236 = "jup_ob_civ_base";
    team = "civilian";
  } else {
    if(isDefined(team) == 0) {
      team = "team_hundred_ninety";
    }

    if(!isDefined(aitype)) {
      aitype = "grunt";
    }

    if(!isDefined(tier)) {
      tier = 1;
    }

    if(aitype == "zombie") {
      var_2d0885860b423236 = "jup_spawner_" + aitype + "_base";
    } else if(aitype == "armored_zombie") {
      var_2d0885860b423236 = "jup_spawner_" + "zombie_base_armored_heavy";
    } else if(team == "allies") {
      var_2d0885860b423236 = "jup_ob_ally_" + aitype + "_base";
    } else {
      var_2d0885860b423236 = "jup_ob_enemy_" + aitype;
    }
  }

  agent = mp_agent::spawnnewagentaitype(var_2d0885860b423236, position, angles, team);

  if(isDefined(agent)) {
    if(isDefined(groupname) && aitype != "civ" && aitype != "zombie") {
      function_233776aa4bd0a7d9(agent, groupname);
    }

    if(isDefined(agent)) {
      agent.aitype = aitype;
    }

    if(!threatbiasgroupexists(team)) {
      createthreatbiasgroup(team);
    }

    agent setthreatbiasgroup(team);
  }

  return agent;
}

function function_233776aa4bd0a7d9(agent, groupname) {
  if(isDefined(agent) && isDefined(groupname)) {
    agent.script_stealthgroup = groupname;
    agent.var_ba67494935b9726b = 1;
    agent thread enemy::main();
  }
}

function function_1682cde991b9dbf4() {}

function function_3bd4148272ae66ee(sparams) {
  var_667f977810dca6b9 = undefined;

  if(isDefined(sparams.eattacker) && isPlayer(sparams.eattacker)) {
    var_667f977810dca6b9 = sparams.eattacker;
  } else {
    var_667f977810dca6b9 = function_a818575675b1f1c0(sparams);
  }

  return var_667f977810dca6b9;
}

function function_a818575675b1f1c0(sparams) {
  var_667f977810dca6b9 = undefined;

  if(isDefined(sparams.eattacker) && isDefined(sparams.eattacker.var_941802a0997e0c42) && isPlayer(sparams.eattacker.var_941802a0997e0c42)) {
    var_667f977810dca6b9 = sparams.eattacker.var_941802a0997e0c42;
  } else if(isDefined(self) && isDefined(self.var_941802a0997e0c42) && isPlayer(self.var_941802a0997e0c42)) {
    var_667f977810dca6b9 = self.var_941802a0997e0c42;
  } else if(isDefined(self) && isDefined(self.var_13fbc1870bc29ba) && isPlayer(self.var_13fbc1870bc29ba)) {
    var_667f977810dca6b9 = self.var_13fbc1870bc29ba;
  } else if(isDefined(sparams.eattacker) && isDefined(sparams.eattacker.var_66c1831357048c02)) {
    var_667f977810dca6b9 = sparams.eattacker.var_66c1831357048c02;
  }

  return var_667f977810dca6b9;
}

function function_d45ce3fa8102856f() {}

function function_daee52aa53ad6314(center, radius) {
  var_5a48fe65d507ab4e = getaiarrayinradius(center, radius);
  var_a36d07aa1a1297cd = [];

  foreach(ai in var_5a48fe65d507ab4e) {
    if(!function_39e79a17581dee4f(ai, var_a36d07aa1a1297cd, 256)) {
      marker = spawnscriptable("ob_zombie_cleanup_marker", ai.origin);
      marker setscriptablepartstate("target", "on");
      scriptable::scriptable_addnotifycallback("detonate", &function_aff11e45f0c38fd3);
      var_a36d07aa1a1297cd[var_a36d07aa1a1297cd.size] = ai.origin;
      wait randomfloatrange(0.15, 0.25);
    }
  }

  wait 1;
}

function function_aff11e45f0c38fd3(instance, note, param, instigator) {
  radiusdamage(instance.origin, 356, 1000, 800, undefined, "MOD_EXPLOSIVE");
}

function function_39e79a17581dee4f(ai, var_a36d07aa1a1297cd, radius) {
  foreach(ai_pos in var_a36d07aa1a1297cd) {
    if(utility::ispointinsidecircle(ai.origin, ai_pos, radius)) {
      return true;
    }
  }

  return false;
}

function function_81acda909e814ff9() {}

function function_908ec13fb4d6cede(pos, badplace_id, owner, var_c88c81279416b9c3, angles, entityless) {
  if(istrue(entityless)) {
    return function_44bbc99cebecdc82(pos, badplace_id, owner, var_c88c81279416b9c3, angles);
  }

  return function_2388b5efd8f6d998(pos, badplace_id, owner, var_c88c81279416b9c3);
}

function function_2388b5efd8f6d998(pos, badplace_id, owner, var_c88c81279416b9c3) {
  mine = magicgrenademanual("at_mine_mp", pos + (0, 0, 15), (0, 0, 1));
  mine waittill("missile_stuck", stuckto, hitent, surfacetype, velocity, position, normal);

  if(isDefined(badplace_id)) {
    mine thread function_fb4d0220951a9b41(badplace_id);
  }

  if(isDefined(owner)) {
    mine.owner = owner;
  }

  mine.team = "team_hundred_ninety";
  mine.player_trigger_radius = default_to(var_c88c81279416b9c3, 150);
  mine setscriptablepartstate("visibility", "show", 0);
  mine setscriptablepartstate("floats", "hide", 0);
  mine thread at_mine::at_mine_watch_game_end();

  if(isDefined(stuckto)) {
    mine linkTo(stuckto);
  }

  level thread function_fe3c4d4dd27683a0(mine, surfacetype);
  return mine;
}

function function_44bbc99cebecdc82(pos, badplace_id, owner, var_c88c81279416b9c3, angles) {
  if(!isDefined(angles)) {
    angles = (0, 0, 1);
  }

  mine = spawnscriptable("equip_claymore_ob", pos + (0, 0, 4), angles);
  mine.bundle = getscriptbundle(%"hash_6cc09ff20508d547");

  if(isDefined(badplace_id)) {
    mine thread function_fb4d0220951a9b41(badplace_id);
  }

  if(isDefined(owner)) {
    mine.owner = owner;
  }

  mine.team = "team_hundred_ninety";
  mine.player_trigger_radius = default_to(var_c88c81279416b9c3, 150);
  mine setscriptablepartstate("visibility", "show", 0);
  mine thread claymore::function_773e48f8d031510e();
  level thread function_fe3c4d4dd27683a0(mine);
  return mine;
}

function function_fe3c4d4dd27683a0(grenade, surfacetype) {
  grenade endon("mine_destroyed");
  grenade endon("death");
  grenade setscriptablepartstate("plant", "active", 0);

  if(isent(grenade)) {
    grenade missilethermal();
    grenade missileoutline();
    grenade setnodeploy(1);
    grenade enableplayermarks("equipment");
    grenade.equipmentref = "equip_at_mine";
    grenade.deletefunc = &at_mine::at_mine_delete;
    level.mines[grenade getentitynumber()] = grenade;
  } else {
    grenade.equipmentref = "equip_claymore_mp";
    grenade.deletefunc = &claymore::claymore_delete;
    grenade.weapon_name = "claymore_mp";
    level.var_8106ad57bb892525[grenade.index] = grenade;
  }

  grenade.planted = 1;
  grenade notify("mine_planted");

  if(isent(grenade)) {
    grenade sentientpoolmanager::registersentient("Lethal_Static", "team_hundred_ninety", 1);
    grenade thread weapons::minedamagemonitor();
    grenade thread at_mine::at_mine_watch_detonate();
    grenade emp_debuff::set_apply_emp_callback(&at_mine::at_mine_empapplied);
    grenade haywire::function_172d848d58051fdf(&at_mine::function_83d4163604fc28e3);
    wait 0.75;

    if(istrue(grenade.touchedmovingplatform)) {
      grenade thread at_mine::at_mine_movingplatform_update();
    }

    wait 0.75;
    grenade thread equipment_interact::remoteinteractsetup(&at_mine::at_mine_explode_from_player_trigger, 1, 1);
  } else {
    grenade emp_debuff::set_apply_emp_callback(&claymore::claymore_empapplied);
    grenade haywire::function_172d848d58051fdf(&claymore::function_4373872960a2d51a);
  }

  grenade setscriptablepartstate("arm", "active", 0);
  grenade thread function_ceabda5bfd6f58e5();

  if(isent(grenade)) {
    grenade thread at_mine::at_mine_watch_trigger();
    grenade.weapon_name = "at_mine_mp";
    grenade thread weapons::makeexplosiveusabletag("tag_use", 1);
    iconoffset = 2;
    grenade.headiconid = grenade entityheadicons::setheadicon_factionimage(0, iconoffset, undefined, undefined, undefined, 0.1, 1);
    return;
  }

  grenade thread claymore::claymore_watchfortrigger();
  grenade thread claymore::claymore_explodeonnotify();
  grenade.weapon_name = "claymore_mp";
}

function function_ceabda5bfd6f58e5() {
  self endon("mine_triggered");
  self endon("mine_destroyed");
  self endon("death");

  while(true) {
    players = sortbydistancecullbyradius(level.players, self.origin, self.player_trigger_radius);
    zombies = getaiarrayinradius(self.origin, 100, "team_two_hundred");
    vehicles = vehicle_getarrayinradius(self.origin, 300);

    if(vehicles.size > 0) {
      foreach(vehicle in vehicles) {
        if(isDefined(vehicle.team) && (vehicle.team == "team_hundred_ninety" || vehicle.team == "neutral")) {
          vehicles = utility::array_remove(vehicles, vehicle);
        }
      }
    }

    ents = utility::array_combine(players, vehicles, zombies);

    if(ents.size > 0) {
      self notify("trigger_grenade", ents);
    }

    waitframe();
  }
}

function function_fb4d0220951a9b41(badplace_id) {
  badplace_cylinder(badplace_id, 0, self.origin, 100, 100, "team_hundred_ninety");
  self waittill("death");
  badplace_delete(badplace_id);
}

function function_cd2b3e5bab3edee3(einflictor, eattacker, instance, idamage, idflags, smeansofdeath, objweapon, vdir, shitloc, modelindex, partname) {
  if(eattacker.classname != "worldspawn") {
    instance notify("detonateExplosive", eattacker);
  }
}

function function_b98fc11e18f21812() {}

function function_586d4d82f07e0d09(struct) {
  if(!isDefined(level.aisentryturrets)) {
    ai_sentry_turret::init();
  }

  sentry = function_9c8190123c567b0a(struct);
  sentry setturretteam("team_hundred_ninety");
  level.aisentryturrets.spawnedturrets = array_add(level.aisentryturrets.spawnedturrets, sentry);
  return sentry;
}

function function_64d1082e50f1eed() {
  if(getdvarint(@ "hash_72b30f1696eedd3f", 1) == 1 && isDefined(level.sentrysettings["ai_sentry_turret"])) {
    level.sentrysettings["ai_sentry_turret"].health = getdvarint(@ "hash_85190757115145bb", 99999);
    level.sentrysettings["ai_sentry_turret"].maxhealth = getdvarint(@ "hash_36397d237d9e8cc4", 650);
    level.sentrysettings["ai_sentry_turret"].burstmin = getdvarint(@ "hash_a46feb5e2592f0f2", 20);
    level.sentrysettings["ai_sentry_turret"].burstmax = getdvarint(@ "hash_a44cf55e256cbf38", 60);
    level.sentrysettings["ai_sentry_turret"].pausemin = getdvarfloat(@ "hash_e20bff747c64b106", 0.15);
    level.sentrysettings["ai_sentry_turret"].pausemax = getdvarfloat(@ "hash_e22f11747c8b2054", 0.35);
    level.sentrysettings["ai_sentry_turret"].lockstrength = getdvarint(@ "hash_ceced053aef1994e", 2);
    level.sentrysettings["ai_sentry_turret"].spinuptime = getdvarfloat(@ "hash_b61a77e4372e219c", 1.3);
    level.sentrysettings["ai_sentry_turret"].overheattime = getdvarfloat(@ "hash_dcf790014985321b", 8);
    level.sentrysettings["ai_sentry_turret"].cooldowntime = getdvarfloat(@ "hash_fc469fa788fee5e8", 0.3);
    level.sentrysettings["ai_sentry_turret"].burstmaxtime = getdvarint(@ "hash_820588da04a51de4", 4);
    level.sentrysettings["ai_sentry_turret"].var_87d927a08cbfdf3f = getdvarint(@ "hash_72f2a62608ca10c1", 1.5);
    level.sentrysettings["ai_sentry_turret"].leftarc = getdvarint(@ "hash_a3e7f06749d721bf", 95);
    level.sentrysettings["ai_sentry_turret"].rightarc = getdvarint(@ "hash_736ea137340a907e", 95);
    level.sentrysettings["ai_sentry_turret"].laserrange = getdvarint(@ "hash_65eca82be2c24432", 7562500);
    level.sentrysettings["ai_sentry_turret"].fxtime = getdvarfloat(@ "hash_531ad70a9ffe2109", 0.3);
    level.sentrysettings["ai_sentry_turret"].targetrange = getdvarint(@ "hash_8f07c50eccf99ef6", 1024);
    level.sentrysettings["ai_sentry_turret"].weaponinfo = getDvar(@ "hash_179a9b0ce9e8095", "jup_sentry_turret_ob_merc");
    level.sentrysettings["ai_sentry_turret"].fov = 0.7;
    level.sentrysettings["ai_sentry_turret"].var_5ab58e3971c817b5 = 1;
    level.sentrysettings["ai_sentry_turret"].contentsoverride = scripts\engine\trace::create_contents(0, 1, 0, 1, 0, 1, 0, 1, 1);
  }
}

function function_9c8190123c567b0a(turretstruct) {
  if(getdvarint(@ "hash_70d8cba45c5014ec", 1) == 0) {
    return;
  }

  config = level.sentrysettings["ai_sentry_turret"];
  turret = spawnturret("misc_turret", turretstruct.origin, config.weaponinfo);
  turret.angles = turretstruct.angles;
  turret.health = 9999;
  turret.maxhealth = config.maxhealth;
  turret.ammocount = config.ammo;
  turret.timeout = config.timeout;
  turret.momentum = 0;
  turret.heatlevel = 0;
  turret.overheated = 0;
  turret.cooldownwaittime = 0.1;
  turret.sentrytype = "ai_sentry_turret";
  turret.owningteam = "team_hundred_ninety";
  turret.team = "team_hundred_ninety";
  turret.tozombiedamagemult = 10;
  turret setModel(config.modelbaseground);
  turret setturretteam(turret.owningteam);
  turret setCanDamage(1);
  turret makeunusable();
  turret setnodeploy(1);
  turret setdefaultdroppitch(0);
  turret setautorotationdelay(0.5);
  turret maketurretinoperable();
  leftarc = float(utility::ter_op(isDefined(turretstruct.leftarc), turretstruct.leftarc, config.leftarc));
  turret.leftarc = leftarc;
  turret setleftarc(leftarc);
  rightarc = float(utility::ter_op(isDefined(turretstruct.rightarc), turretstruct.rightarc, config.rightarc));
  turret.rightarc = rightarc;
  turret setrightarc(rightarc);
  turret setbottomarc(50);
  turret settoparc(60);
  turret setconvergencetime(1, "pitch");
  turret setconvergencetime(1, "yaw");
  turret setconvergenceheightpercent(0.9);
  turret setdefaultdroppitch(-89);
  turret setturretmodechangewait(1);
  turret emp_debuff::allow_emp(0);
  turret laseron();
  turret.colmodel = spawn("script_model", turret.origin);
  turret.colmodel.team = turret.team;
  turret.colmodel.owner = turret.owner;
  turret.colmodel setModel("weapon_vm_mg_sentry_turret_invis_base");
  turret.colmodel dontinterpolate();
  turret.colmodel hide();
  turret thread damage::monitordamage(turret.maxhealth, "hitequip", &ai_sentry_turret::turret_handledeathdamage, &function_b8cef191ff4b199, 1);
  turret thread function_56363d515ef943c1();
  turret thread function_c0a261d161b4dd1c();
  turret thread ai_sentry_turret::function_9e099b94cb9fc336();
  turret thread ai_sentry_turret::function_352e4c58083275a4();
  turret.turreton = 1;
  turret setmode(config.sentrymodeon);
  turret.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_sentryturret_healthbar");
  turret.subclass_scriptbundle = getscriptbundle(%"hash_7e85af1641d03e8e");
  turret.subclass = turret.subclass_scriptbundle.name;
  turret val::set("turret", "show_healthbar", 1);
  turret.var_1e0eb63ecb3f1e2 = 1;
  turret.max_fake_health = turret.maxhealth;
  turret thread function_af7beda981d9cee9();
  turret.var_4919d15787f01154 = 1;
  return turret;
}

function function_af7beda981d9cee9() {
  self endon("death");
  self endon("kill_turret");

  while(true) {
    currenthealth = self.maxhealth - self.damagetaken;

    if(currenthealth < 0) {
      currenthealth = 0;
    }

    self.fake_health = currenthealth;
    waitframe();
  }
}

function function_56363d515ef943c1() {
  self waittill("kill_turret", skipshutdown, wasdestroyed);
  ai_sentry_turret::turret_setturretmodel("destroyed");
  self setturretowner(undefined);

  if(!istrue(skipshutdown)) {
    self playSound("sentry_explode_smoke");
    self setscriptablepartstate("shutdown", "on");
    hostmigration::hostmigration_waitlongdurationwithpause(2);
    self setscriptablepartstate("explode", "regular");
  } else {
    self setscriptablepartstate("explode", "violent");
  }

  self playSound("mp_equip_destroyed");

  if(isDefined(self.colmodel)) {
    self.colmodel delete();
  }

  if(isDefined(self.minimapid)) {
    if(utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[utility::getsharedfunc("game", "returnObjectiveID")]](self.minimapid);
    }

    self.minimapid = undefined;
  }

  wait 0.2;

  if(isDefined(level.aisentryturrets.spawnedturrets) && isDefined(level.aisentryturrets.spawnedturrets) && array_contains(level.aisentryturrets.spawnedturrets, self)) {
    level.aisentryturrets.spawnedturrets = array_remove(level.aisentryturrets.spawnedturrets, self);
  }

  self delete();
}

function function_c0a261d161b4dd1c() {
  self endon("death");
  config = level.sentrysettings[self.sentrytype];

  while(true) {
    if(!istrue(self.turreton) || istrue(self.turretdisabled)) {
      waitframe();
      continue;
    }

    self.besttarget = function_4b64d4acff121845();
    var_1b951c4e47ba5c35 = 1;

    if(isDefined(self.besttarget)) {
      function_8caa40a2fd7e6a50();
    }

    hostmigration::hostmigration_waitlongdurationwithpause(config.cooldowntime);
  }
}

function function_b8cef191ff4b199(data) {
  function_ea7dea54e7660950(data);
  return ai_sentry_turret::turret_modifydamage(data);
}

function function_8caa40a2fd7e6a50() {
  config = level.sentrysettings[self.sentrytype];

  while(istrue(self.turreton) && !istrue(self.stopfiring) && function_f55fc6874dd01aab(self.besttarget)) {
    self settargetentity(self.besttarget);

    if(isPlayer(self.besttarget)) {
      pauseinterval = config.var_6265b628c3ed1103;
    } else {
      pauseinterval = config.var_87d927a08cbfdf3f;
    }

    ai_sentry_turret::function_ba7df6eeacb835f6(config.burstmaxtime, self.besttarget);
    hostmigration::hostmigration_waitlongdurationwithpause(pauseinterval);
    self cleartargetentity();
  }
}

function function_4b64d4acff121845() {
  config = level.sentrysettings[self.sentrytype];
  targetrange = config.targetrange;
  var_52edc18a611b938d = targetrange * targetrange;
  startpoint = self gettagorigin(config.bullettag);
  startangles = self gettagangles(config.bullettag);
  potentialplayertargets = getentitiesinradiusfrompartitiongrid(startpoint, targetrange, createentitytypemask(["etype_player"]), [self]);
  var_e6679a25bc803627 = getentitiesinradiusfrompartitiongrid(startpoint, targetrange, createentitytypemask(["etype_ai"]), [self], "team_two_hundred");
  potentialtargetlist = utility::array_combine(potentialplayertargets, var_e6679a25bc803627);
  potentialtargetlist = sortbydistance(potentialtargetlist, startpoint);
  besttarget = undefined;
  maxtargets = int(min(potentialtargetlist.size, 10));

  for(i = 0; i < maxtargets; i++) {
    validtarget = function_3b490bffc9fa2a31(potentialtargetlist[i], startpoint, startangles);

    if(!istrue(validtarget)) {
      continue;
    }

    besttarget = potentialtargetlist[i];
    break;
  }

  return besttarget;
}

function function_415f497bef802ee0(potentialtarget, shotorigin) {
  config = level.sentrysettings[self.sentrytype];
  targetpoints = ["tag_origin", "j_mainroot", "j_head"];
  targetdata = spawnStruct();
  targetdata.canseetarget = 0;

  if(!isDefined(shotorigin)) {
    shotorigin = self gettagorigin(config.bullettag);
  }

  foreach(point in targetpoints) {
    tagpoint = potentialtarget.origin;

    if(point != "tag_origin") {
      tagpoint = potentialtarget gettagorigin(point);
    }

    targetdata.canseetarget = scripts\engine\trace::ray_trace_passed(shotorigin, tagpoint, self, config.contentsoverride);

    if(istrue(targetdata.canseetarget)) {
      if(isDefined(config) && istrue(config.var_5ab58e3971c817b5)) {
        targetdata.var_29a1beecc195bb8b = point;

        if(targetdata.var_29a1beecc195bb8b != "tag_origin") {
          self function_77f987d8e20e9bfd(1);
        } else {
          self function_77f987d8e20e9bfd(0);
        }
      }

      break;
    }
  }

  return targetdata;
}

function function_820f16ab7cad7ea7(potentialtarget, shotorigin, var_b24c8788a162225d, targettag, fov) {
  config = level.sentrysettings[self.sentrytype];

  if(!isDefined(shotorigin)) {
    shotorigin = self gettagorigin(config.bullettag);
  }

  if(!isDefined(var_b24c8788a162225d)) {
    var_b24c8788a162225d = self gettagangles(config.bullettag);
  }

  potentialtargetpoint = potentialtarget.origin;

  if(isDefined(targettag)) {
    potentialtargetpoint = potentialtarget gettagorigin(targettag);
  }

  metotarget = vectorNormalize(potentialtargetpoint - shotorigin);
  dotproduct = vectordot(anglesToForward(var_b24c8788a162225d), metotarget);

  if(!isDefined(fov)) {
    fov = default_to(config.fov, 0.5);
  }

  return dotproduct > fov;
}

function function_3b490bffc9fa2a31(potentialtarget, bulletstartpoint, bulletstartangles, var_6b908fc596bfe005) {
  if(!isDefined(potentialtarget) || !isalive(potentialtarget)) {
    return false;
  }

  if(istrue(potentialtarget.notarget)) {
    return false;
  }

  if(istrue(potentialtarget.inlaststand)) {
    return false;
  }

  if(isPlayer(potentialtarget)) {
    var_9f7bcc20d78cddde = potentialtarget getthreatbiasgroup();

    if(var_9f7bcc20d78cddde == "ignored_by_mercs") {
      return false;
    }
  }

  if(istrue(var_6b908fc596bfe005)) {
    config = level.sentrysettings[self.sentrytype];
    maxrangesq = config.targetrange * config.targetrange;

    if(distancesquared(bulletstartpoint, potentialtarget.origin) > maxrangesq) {
      return false;
    }
  }

  if(!function_820f16ab7cad7ea7(potentialtarget, bulletstartpoint, bulletstartangles, undefined, 0)) {
    return false;
  }

  targetdata = function_415f497bef802ee0(potentialtarget, bulletstartpoint);

  if(!istrue(targetdata.canseetarget)) {
    return false;
  }

  if(isDefined(targetdata.var_29a1beecc195bb8b) && targetdata.var_29a1beecc195bb8b != "tag_origin" && !function_820f16ab7cad7ea7(potentialtarget, bulletstartpoint, bulletstartangles, targetdata.var_29a1beecc195bb8b)) {
    return false;
  }

  if(isPlayer(potentialtarget) && self.team == potentialtarget.team) {
    return false;
  }

  return true;
}

function function_f55fc6874dd01aab(besttarget) {
  config = level.sentrysettings[self.sentrytype];
  startpoint = self gettagorigin(config.bullettag);
  startangles = self gettagangles(config.bullettag);

  if(!function_3b490bffc9fa2a31(besttarget, startpoint, startangles, 1)) {
    return false;
  }

  return true;
}

function function_2580ac9dba62467a() {}

function function_e13d4385ead80da4(start_node, owner) {
  drone = function_4646999c098f761d(start_node, owner);

  if(isDefined(drone)) {
    drone namespace_c908de38bcdbd93d::function_c96e4b15db766b84();
  }

  return drone;
}

function function_4646999c098f761d(start_node, owner) {
  spawndata = spawnStruct();
  spawndata.origin = start_node.origin;
  spawndata.angles = start_node.angles;
  spawndata.targetname = start_node.targetname;
  spawndata.vehicletype = "veh_jup_ai_recon_drone_mp";
  spawndata.modelname = "veh9_mil_air_cuniform_mp";
  spawndata.owner = owner;
  drone = vehicle_tracking::_spawnhelicopter(undefined, spawndata.origin, spawndata.angles, spawndata.vehicletype, spawndata.modelname);

  if(isDefined(drone)) {
    if(!isDefined(level.supportdrones)) {
      level.supportdrones = [];
    }

    level.supportdrones = utility::array_add(level.supportdrones, drone);
    function_dfaadf89ced637c4(drone, owner, self);
  }

  return drone;
}

function function_dfaadf89ced637c4(drone, owner, activityinstance) {
  drone.health = 150;
  drone.maxhealth = 150;
  drone.currenthealth = 150;
  drone.hitstokill = 3;
  drone.damagetaken = 0;
  drone.speed = 45;
  drone.accel = 20;
  drone.decel = 20;
  drone.team = "team_hundred_ninety";
  drone setvehicleteam(drone.team);
  drone.helperdronetype = "scrambler_drone_guard";
  drone.stunned = 0;
  drone.inactive = 0;
  drone.ispiloted = 0;

  if(isDefined(owner)) {
    drone.owner = owner;
    drone setotherent(owner);
  }

  drone enableaimassist();
  drone setnodeploy(1);
  drone.vehiclename = "jup_ai_recon_drone";
  drone.streakname = "jup_ai_recon_drone";
  drone.attract_strength = 10000;
  drone.attract_range = 150;
  drone.attractor = missile_createattractorent(drone, drone.attract_strength, drone.attract_range);
  drone vehicle_invoketriggers(1);
  drone vehicle_breakglass(1);
  drone vehicle_setspeed(drone.speed, drone.accel, drone.decel);
  drone setyawspeedbyname("faster");
  drone setneargoalnotifydist(64);
  drone setmaxpitchroll(25, 50);
  drone sethoverparams(130, 10, 5);
  drone setturningability(1);
  drone setdroneturnparams(50, 1.3, 30, 20);
  drone.aitypeid = function_2336488258354fbc(#"aitype", %"jup_ob_recondrone_healthbar");
  drone.subclass_scriptbundle = getscriptbundle(%"hash_64bc95f99bee27d3");
  drone.subclass = drone.subclass_scriptbundle.name;
  drone sentientpoolmanager::registersentient("Lethal_Moving", self);
  drone setCanDamage(1);

  if(utility::issharedfuncdefined("vehicle_damage", "setVehicleHitDamageData")) {
    [[utility::getsharedfunc("vehicle_damage", "setVehicleHitDamageData")]](drone.streakname, 1);
  }

  if(utility::issharedfuncdefined("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")) {
    [[utility::getsharedfunc("vehicle_damage", "vehicle_setupHitDamageOverrideForWeapon")]]("emp_grenade_mp", 1, 1, drone.streakname);
  }

  if(utility::issharedfuncdefined("killstreak", "killstreakSetPostModDamageCallback")) {
    drone[[utility::getsharedfunc("killstreak", "killstreakSetPostModDamageCallback")]](drone.streakname, &function_9f45d5d738457b2b);
  }

  level.vehicles.damagecallbacks.deathcallbacks[drone.streakname] = &function_b15f4b2947295667;

  if(!isDefined(drone.damagestates)) {
    drone.damagestates = [];
    drone.currentdamagestate = 0;
  }

  drone.damagestates[1] = spawnStruct();
  drone.damagestates[1].damageamount = drone.maxhealth * 0.75;
  drone.damagestates[1].damagestatefunc = &helper_drone::function_f6914d06b20aee20;
  drone.damagestates[2] = spawnStruct();
  drone.damagestates[2].damageamount = drone.maxhealth * 0.5;
  drone.damagestates[2].damagestatefunc = &helper_drone::function_3ad98c4f7524b525;
  drone.damagestates[3] = spawnStruct();
  drone.damagestates[3].damageamount = drone.maxhealth * 0.25;
  drone.damagestates[3].damagestatefunc = &helper_drone::function_e68a206899cafbe5;
  helper_drone::init_helper_drone_anim();
  scripts\mp\weapons::function_e00b77a9cb4d8322(drone);
  drone thread function_f6b8c4b836026e10();
  drone thread function_38dff9ddaf2e7bd2(activityinstance);
  drone thread function_9760fe79ece4d639();
  drone setscriptablepartstate("lights", "on", 0);
  drone setscriptablepartstate("glint", "on", 0);
  drone setscriptablepartstate("engine", "on", 0);
}

function function_f6b8c4b836026e10() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  level waittill_any_2("bro_shot_start", "game_ended");
  function_b15f4b2947295667();
}

function function_9f45d5d738457b2b(data) {
  function_ea7dea54e7660950(data);
  return helper_drone::function_caf721cb23374e2b(data);
}

function function_b15f4b2947295667(data) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }

  if(isDefined(data)) {
    thread function_655249500e8f380f(data);
  } else {
    thread function_cb78493f84fd68e3(1);
  }

  params = spawnStruct();
  params.player = data.attacker;
  callback::callback("on_merc_camp_recon_destroyed", params);
  return 0;
}

function function_655249500e8f380f(data) {
  if(!isDefined(self) || istrue(self.isdestroyed)) {
    return;
  }

  self.isdestroyed = 1;
  self.var_d31453e33d3e34ca = 1;

  if(istrue(self.repeatuse)) {
    self.repeatuse = 0;
  }

  var_ecb39c9eecbd70ad = 3000;
  contents = trace::create_contents(0, 1, 1, 0, 0, 1, 0, 0, 0);
  castend = self.origin + anglestoup(self.angles) * var_ecb39c9eecbd70ad * -1 + (randomintrange(-500, 500), 0, randomintrange(-500, 500));
  trace = trace::ray_trace(self.origin, castend, [self]);
  target_origin = trace["position"] + trace["normal"] * 5;
  maxvelocity = getdvarfloat(@ "hash_44e62153228221f", 30.2);
  acceleration = getdvarfloat(@ "hash_cdb03278c6d17e78", 13.8);
  deceleration = getdvarfloat(@ "hash_ed85baf3072c3fff", 17.2);
  var_f9ca3f557a387549 = getdvarfloat(@ "hash_3f6d20d42a18063b", 2500);
  distance = distance(target_origin, self.origin);
  falltime = sqrt(2 * distance / acceleration);
  falltime = min(falltime, 2) - 0.2;
  self vehicle_setspeed(maxvelocity, acceleration, deceleration);
  self setvehgoalpos(target_origin, 0);
  thread helper_drone::function_9bfdff1ee5a47652();
  time = 0;

  while(true) {
    if(distancesquared(self.origin, target_origin) <= var_f9ca3f557a387549 || time >= falltime) {
      function_91af2a9f0b3f524a(data);
      break;
    }

    time += level.framedurationseconds;
    waitframe();
  }
}

function function_91af2a9f0b3f524a(data) {
  if(isDefined(data.inflictor) && isDefined(data.inflictor.stuckto)) {
    data.inflictor notify("forceDeath");
  }

  if(isDefined(self.var_75bb433488d96804)) {
    self.owner cameraunlink();
    self.var_75bb433488d96804 delete();
    self.var_75bb433488d96804 = undefined;
  }

  thread function_cb78493f84fd68e3(1);
}

function function_cb78493f84fd68e3(wasdestroyed, wasexited, wastimedout, wasdetonated) {
  self.isdestroyed = 1;
  scripts\mp\weapons::function_1a33bd42949ccbda(self);

  if(isDefined(self.targetmarkergroup)) {
    targetmarkergroups::targetmarkergroup_off(self.targetmarkergroup);
    self.targetmarkergroup = undefined;
  }

  if(isDefined(self.minimapid)) {
    objidpoolmanager::returnobjectiveid(self.minimapid);
    self.minimapid = undefined;
  }

  helper_drone::helperdrone_endscramblereffect();

  if(utility::issharedfuncdefined("game", "clearOOB")) {
    [[utility::getsharedfunc("game", "clearOOB")]](self, 1);
  }

  if(isent(self)) {
    explodestate = "on";

    if(istrue(self.inwater)) {
      if(self getscriptableparthasstate("explode", "water")) {
        explodestate = "water";
      }
    }

    self setscriptablepartstate("explode", explodestate, 0);
  }

  self playSound("radar_drone_explode");
  emp_debuff::clear_emp(1);
  helper_drone::function_24085a0230958938();
  emp_debuff::allow_emp(0);
  self notify("explode");
  wait 0.2;
  function_2a63be2c71898d9a(self.helperdronetype, wasdestroyed);
}

function function_2a63be2c71898d9a(dronetype, wasdestroyed, dronevel, dronehealth) {
  if(isDefined(self.radar)) {
    self.radar delete();
  }

  self.ispiloted = undefined;
  self.repeatuse = undefined;

  if(isDefined(self.useobj)) {
    self.useobj delete();
  }

  if(isDefined(self.playersfx)) {
    self.playersfx delete();
  }

  if(isDefined(self.scrambler)) {
    self.scrambler delete();
  }

  if(isDefined(self.enemyobjid)) {
    objidpoolmanager::returnobjectiveid(self.enemyobjid);
  }

  if(isDefined(self.pulsedarts) && self.pulsedarts.size > 0) {
    foreach(pulsedart in self.pulsedarts) {
      pulsedart notify("death");
    }
  }

  level.supportdrones = utility::array_remove(level.supportdrones, self);
  vehicle_tracking::_deletevehicle(self);
}

function function_38dff9ddaf2e7bd2(activityinstance) {
  if(isDefined(activityinstance)) {
    activityinstance endon("activity_ended");
  }

  if(isDefined(self.vehicle_spawner) && isDefined(self.vehicle_spawner.target)) {
    first_node = utility::getStruct(self.vehicle_spawner.target, "targetname");
    vehicle_paths::vehicle_paths_helicopter(first_node);
  }
}

function function_c168464cf44d71bd(drone) {
  self endon("disconnect");
  var_2512a36a90854dbc = 2547216;

  while(true) {
    stopeffect = 0;

    if(!isDefined(drone) || !player_utility::_isalive()) {
      stopeffect = 1;
    } else if(istrue(drone.isdestroyed)) {
      stopeffect = 1;
    } else {
      distancechecksq = distancesquared(drone.origin, self.origin);

      if(distancechecksq > var_2512a36a90854dbc) {
        stopeffect = 1;
      }

      if(getdvarint(@ "hash_f4f53baf41c812ab", 0)) {
        level thread scripts\mp\utility\debug::drawsphere(drone.origin, 1596, 0.5, (1, 0, 0));
      }
    }

    if(stopeffect) {
      scripts\cp_mp\emp_debuff::stop_scramble(5, 0);
      return;
    }

    wait 0.5;
  }
}

function function_9760fe79ece4d639() {
  self endon("death");
  self endon("leaving");
  self endon("explode");
  self endon("drop");
  self endon("scramble_super_finished");
  skipteamcheck = 1;
  self.var_32efb854df6d5296 = 1536;
  self.var_88f72d2c0421f8b1 = [];

  while(true) {
    if(getdvarint(@ "hash_f4f53baf41c812ab", 0)) {
      level thread scripts\mp\utility\debug::drawsphere(self.origin, 1536, 0.5, (0, 1, 0));
    }

    var_3548b8680990ee75 = utility::playersinsphere(self.origin, 1536);

    foreach(scrambledplayer in var_3548b8680990ee75) {
      isimmune = 0;

      if(utility::issharedfuncdefined("perk", "hasPerk")) {
        isimmune = scrambledplayer[[utility::getsharedfunc("perk", "hasPerk")]]("specialty_scrambler_resist");
      }

      if(isDefined(scrambledplayer)) {
        if(scrambledplayer player_utility::_isalive() && !isimmune) {
          if(scrambledplayer utility::isusingremote()) {
            continue;
          }

          if(istrue(self.isdestroyed)) {
            continue;
          }

          if(scrambledplayer scripts\cp_mp\emp_debuff::function_396e8b70241f9f10(5, 0)) {
            continue;
          }

          scrambledplayer scripts\cp_mp\emp_debuff::play_scramble(5, 0);
          scrambledplayer thread function_c168464cf44d71bd(self);
          continue;
        }

        if(isDefined(scrambledplayer.scrambledby) && scrambledplayer.scrambledby.size > 0 && array_contains(scrambledplayer.scrambledby, self)) {
          scrambledplayer notify("scramble_off" + self getentitynumber());
        }
      }
    }

    wait 0.5;
  }
}

function private function_ea7dea54e7660950(data) {
  if(isDefined(data) && isDefined(data.attacker)) {
    attacker = undefined;

    if(isPlayer(data.attacker)) {
      attacker = data.attacker;
    } else if(isDefined(data.attacker.owner) && isPlayer(data.attacker.owner)) {
      attacker = data.attacker.owner;
    }

    if(isDefined(attacker)) {
      attacker notify("disguise_state_change", "end_disguise");
    }
  }
}

function function_608f03a0f2daa24f() {}

function function_9ba09e46a2d4da1a(bomb_center, bomb_radius, bomb_number, var_38ea163268665f20) {
  level endon("game_ended");
  self endon("activity_ended");
  bomb_radius = utility::default_to(bomb_radius, 384);
  bomb_number = utility::default_to(bomb_number, 3);
  var_38ea163268665f20 = utility::default_to(var_38ea163268665f20, 96);
  var_240aac519c686e9a = function_cdd9002a084e6c1e(bomb_center);
  var_983e69b99e987ea9 = function_70cd8263e1bec0a2(bomb_radius, bomb_number, var_38ea163268665f20, "inner", var_240aac519c686e9a, bomb_center);

  if(var_983e69b99e987ea9.size > 0) {
    foreach(var_6a3f4ad90373bd65 in var_983e69b99e987ea9) {
      level thread function_a23d210f99139c27(var_240aac519c686e9a, bomb_center + var_6a3f4ad90373bd65);
      wait randomfloatrange(0.5, 1.5);
    }

    return;
  }

  iprintln("CLUSTER BOMB cancelled - could not find good offset points");
}

function function_cdd9002a084e6c1e(bomb_center) {
  angley = 0;
  var_240aac519c686e9a = undefined;
  heightent = namespace_2b1145f62aa835b8::getkillstreakairstrikeheightentsharedfunc();
  heightoffset = 10000;

  if(isDefined(heightent)) {
    heightoffset = heightent.origin[2] + 4000;
  }

  missileoffset = bomb_center + (0, 0, heightoffset);

  while(angley < 360) {
    forwardvector = anglesToForward((0, angley, 0));
    var_240aac519c686e9a = missileoffset - forwardvector * 3000;
    trace = trace::ray_trace(var_240aac519c686e9a, bomb_center);

    if(trace["fraction"] > 0.9) {
      break;
    }

    angley += 45;
    wait 0.1;
  }

  return var_240aac519c686e9a;
}

function function_a23d210f99139c27(var_240aac519c686e9a, var_c1525227d6dba863) {
  clusterbomb = namespace_2b1145f62aa835b8::magicbulletsharedfunc(makeweapon("hellstorm_cluster_bomb_proj_mp"), var_240aac519c686e9a, var_c1525227d6dba863);
  clusterbomb waittill("death");
  namespace_2b1145f62aa835b8::function_7a0d2d9d94d820ae(var_c1525227d6dba863, 1);
  playsoundatpos(var_c1525227d6dba863, "iw9_cruise_missile_exp");
}

function function_70cd8263e1bec0a2(n_radius, n_positions, var_665830328a562bb0, str_cluster, var_22ca4a7ff2116e86, v_center) {
  level endon("game_ended");
  self endon("activity_ended");
  a_v_offset = [];
  str_cluster = utility::default_to(str_cluster, "random");
  var_22ca4a7ff2116e86 = utility::default_to(var_22ca4a7ff2116e86, 0);
  var_43828ce9347dba61 = undefined;

  if(isDefined(var_665830328a562bb0)) {
    var_43828ce9347dba61 = var_665830328a562bb0 * var_665830328a562bb0;
  }

  maxtime = n_positions * 0.5;
  starttime = gettime();
  var_9e8fc8654556c662 = undefined;
  var_9e8fc9654556c895 = undefined;

  while(a_v_offset.size < n_positions) {
    elapsedtime = gettime() - starttime;

    if(utility::function_c89ed1840c8d0f0f(elapsedtime) > maxtime) {
      break;
    }

    offset_x = function_c2211ba6e4c34e44(n_radius, str_cluster, var_9e8fc8654556c662);
    offset_y = function_c2211ba6e4c34e44(n_radius, str_cluster, var_9e8fc9654556c895);

    if(istrue(var_9e8fc8654556c662) && istrue(var_9e8fc9654556c895)) {
      var_9e8fc8654556c662 = undefined;
      var_9e8fc9654556c895 = undefined;
    } else if(utility::cointoss()) {
      var_9e8fc8654556c662 = 1;
    } else {
      var_9e8fc9654556c895 = 1;
    }

    var_f797ad5fe71035ea = (offset_x, offset_y, 0);
    var_e9a0f10796b5bdee = 1;

    if(isDefined(var_43828ce9347dba61) && a_v_offset.size > 0) {
      var_e9a0f10796b5bdee = function_92baead0f0cab344(var_f797ad5fe71035ea, a_v_offset, var_43828ce9347dba61);
    }

    if(isvector(var_22ca4a7ff2116e86)) {
      v_sky_pos = var_22ca4a7ff2116e86;
      var_e9a0f10796b5bdee = function_3f5cad871311cee1(var_f797ad5fe71035ea + v_center, v_sky_pos);
      waitframe();
    } else if(istrue(var_22ca4a7ff2116e86)) {
      var_e9a0f10796b5bdee = function_3f5cad871311cee1(var_f797ad5fe71035ea + v_center);
      waitframe();
    }

    if(istrue(var_e9a0f10796b5bdee)) {
      a_v_offset[a_v_offset.size] = var_f797ad5fe71035ea;
    }

    waitframe();
  }

  return a_v_offset;
}

function function_c2211ba6e4c34e44(n_radius, str_cluster, var_862e1b1897ab0185) {
  if(str_cluster == "inner") {
    rand = randomfloatrange(0, 1);
    dist = squared(rand) * n_radius;
  } else if(str_cluster == "outer") {
    rand = randomfloatrange(0, 1);
    edge_dist = squared(rand) * n_radius;
    dist = n_radius - edge_dist;
  } else {
    dist = randomfloatrange(0, n_radius);
  }

  if(istrue(var_862e1b1897ab0185)) {
    dist *= -1;
  } else {
    dist = utility::ter_op(utility::cointoss(), dist * -1, dist);
  }

  return dist;
}

function function_92baead0f0cab344(var_f797ad5fe71035ea, a_v_offset, var_43828ce9347dba61) {
  foreach(v_offset in a_v_offset) {
    if(utility::distance_2d_squared(v_offset, var_f797ad5fe71035ea) > var_43828ce9347dba61) {
      return false;
    }
  }

  return true;
}

function function_3f5cad871311cee1(var_f797ad5fe71035ea, v_sky_pos) {
  if(!isDefined(v_sky_pos)) {
    v_sky_pos = var_f797ad5fe71035ea + (0, 0, 6000);
  }

  trace = trace::ray_trace(v_sky_pos, var_f797ad5fe71035ea);

  if(trace["fraction"] > 0.9) {
    return true;
  }

  return false;
}

function function_b5a086a266d3796e() {}

function ob_airstrike(strike_location, strike_type, num_planes, var_299355110e3b3670, yaw) {
  level endon("game_ended");
  self endon("activity_ended");
  strike_type = utility::default_to(strike_type, "precision_airstrike");
  var_299355110e3b3670 = utility::default_to(var_299355110e3b3670, 1);

  if(strike_type == "quest_airstrike") {
    strike_type = "fuel_airstrike";
  } else if(strike_type != "multi_airstrike" || !isDefined(num_planes)) {
    num_planes = 2;
  }

  streakinfo = spawnStruct();
  streakinfo.streakname = strike_type;

  if(!isDefined(streakinfo.shots_fired)) {
    streakinfo.shots_fired = 0;
  }

  level.airstrikesettings[streakinfo.streakname].modelbase = "veh8_mil_air_alfa10_east";
  streakinfo.owner = level.players[0];
  animname = level.scr_anim[streakinfo.streakname]["airstrike_flyby"];

  if(utility::issharedfuncdefined("killstreak", "dangerNotifyPlayersInRange")) {
    streakinfo.owner[[utility::getsharedfunc("killstreak", "dangerNotifyPlayersInRange")]](strike_location, 1000, streakinfo.streakname);
  }

  iprintlnbold("<dev string:x1c>");

  for(i = 0; i < num_planes; i++) {
    level thread function_dcd01bce8a255040(streakinfo.owner, strike_location, yaw, undefined, streakinfo, animname, undefined, var_299355110e3b3670);
    wait randomfloatrange(2, 4);
  }
}

function function_dcd01bce8a255040(owner, coord, yaw, targetmarker, streakinfo, animname, airstrikeid, var_299355110e3b3670) {
  planebombexplodedistance = 0;
  heightent = killstreak_utility::getkillstreakairstrikeheightent();
  planehalfdistance = 24000;
  planeflyspeed = 6500;
  planeflyheight = 2500;
  planebombexplodedistance = 1500;

  if(isDefined(heightent)) {
    planeflyheight = heightent.origin[2];
  }

  var_5ceb15b939485b52 = getdvarint(@ "hash_698613e6c8c52243", 0);
  planeflyheight += var_5ceb15b939485b52;

  planebombexplodedistance = airstrike::getexplodedistance(planeflyheight);
  direction = undefined;
  var_505331ad630bbc6b = undefined;

  if(isDefined(yaw)) {
    direction = (0, yaw, 0);
  } else {
    direction = airstrike::callstrike_findoptimaldirection(owner, coord, planeflyheight, planehalfdistance);
    var_505331ad630bbc6b = 1;
  }

  flightpath = airstrike::getflightpath(coord, direction, planehalfdistance, heightent, planeflyheight, planeflyspeed, planebombexplodedistance, streakinfo.streakname, var_505331ad630bbc6b);

  if(streakinfo.streakname == "precision_airstrike") {
    for(i = 0; i < 2; i++) {
      planeflyheight += randomintrange(200, 300);
      level thread function_9c4eb1316ad8cdd9(coord, flightpath["startPoint"], flightpath["endPoint"], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid, var_299355110e3b3670);
      wait 3;
    }

    return;
  }

  if(streakinfo.streakname == "multi_airstrike") {
    planeflyheight += randomintrange(200, 300);
  }

  level thread function_9c4eb1316ad8cdd9(coord, flightpath["startPoint"], flightpath["endPoint"], planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid, var_299355110e3b3670);
}

function function_9c4eb1316ad8cdd9(targetsite, var_6d29e82378e59e76, var_98255165b50d8173, planeflyheight, targetmarker, streakinfo, animname, owner, airstrikeid, var_299355110e3b3670) {
  if(!isDefined(owner)) {
    return;
  }

  owner endon("disconnect");
  level endon("game_ended");
  config = level.airstrikesettings[streakinfo.streakname];
  strikeanimlength = getanimlength(animname);
  var_7b00721e9d1ef2a0 = utility::get_notetrack_time(animname, "attack");
  planestartpos = targetsite + (0, 0, planeflyheight);
  var_7789cda8c1e3128e = vectortoangles(var_98255165b50d8173 - var_6d29e82378e59e76);
  planemodel = config.modelbase;

  if(player_utility::getplayersuperfaction(owner) && isDefined(config.modelbasealt)) {
    planemodel = config.modelbasealt;
  }

  plane = spawn("script_model", planestartpos);
  plane setModel(planemodel);
  plane.angles = var_7789cda8c1e3128e;
  plane.flightdir = anglesToForward(var_7789cda8c1e3128e);
  plane.flightheight = planeflyheight;
  plane.owner = owner;
  var_94ef028c9129ecf9 = istrue(level.isx1ops) && isDefined(level.x1ops) && level.x1ops == 6;
  plane.team = "team_hundred_ninety";
  plane.lifeid = streakinfo.lifeid;
  plane.streakinfo = streakinfo;
  plane.airstrikeid = airstrikeid;
  plane setotherent(owner);
  plane scriptmoveroutline();
  plane scriptmoverthermal();
  plane scriptmoverplane();

  if(utility::issharedfuncdefined("killstreak", "addToActiveKillstreakList")) {
    plane[[utility::getsharedfunc("killstreak", "addToActiveKillstreakList")]](streakinfo.streakname, "Killstreak_Air", owner, 0, 1, 100);
  }

  if(utility::issharedfuncdefined("br", "challengeEvaluator")) {
    paramstruct = spawnStruct();
    paramstruct.plane = plane;
    paramstruct.targetsite = targetsite;
    owner[[utility::getsharedfunc("br", "challengeEvaluator")]]("br_mastery_pointBlank_airstrike", paramstruct);
  }

  planeicon = "icon_minimap_airstrike";

  if(streakinfo.streakname == "fuel_airstrike") {
    planeicon = "icon_minimap_fuelairstrike";
  }

  if(utility::issharedfuncdefined("game", "createObjective")) {
    plane.minimapid = plane[[utility::getsharedfunc("game", "createObjective")]](planeicon, plane.team, undefined, 1, 1);
  }

  var_fafbda0eba9c0aab = var_7b00721e9d1ef2a0 - 0.75;
  var_3a20f9101e50025f = 0.05;
  var_3a020e101e2ddead = var_fafbda0eba9c0aab;
  var_7c39d972e849c204 = 8.596;

  if(streakinfo.streakname == "fuel_airstrike") {
    var_fafbda0eba9c0aab = var_7b00721e9d1ef2a0 + 1;
  }

  var_e4d26f59db05025a = config.var_c80e3ea2a37a7182;

  if(!isDefined(var_e4d26f59db05025a)) {
    var_e4d26f59db05025a = "ks_airstrike_mp";
  }

  plane thread airstrike::airstrike_delayplayscriptable(0.05);
  level thread airstrike::airstrike_playplaneattackfx(plane, var_fafbda0eba9c0aab, streakinfo);
  level thread airstrike::airstrike_playflyfx(plane, var_e4d26f59db05025a, var_6d29e82378e59e76, anglesToForward(var_7789cda8c1e3128e), var_3a20f9101e50025f, var_3a020e101e2ddead, var_7c39d972e849c204, strikeanimlength, streakinfo);
  plane.bulletpoint = spawn("script_model", plane.origin);
  planeweapon = "ks_airstrike_target_mp";

  if(istrue(var_299355110e3b3670)) {
    planeweapon = "ks_airstrike_target_ob_ai";
  }

  plane.bulletpoint setModel(planeweapon);
  plane.bulletpoint setentityowner(owner);
  plane.bulletpoint.weapon_name = "artillery_mp";
  plane.bulletpoint.streakinfo = streakinfo;
  plane.bulletpoint.angles = plane.angles;
  plane.bulletpoint dontinterpolate();
  plane.animname = streakinfo.streakname;
  plane animation::setanimtree();
  plane.scenenode = spawn("script_model", planestartpos);
  plane.scenenode.angles = plane.angles;
  plane.scenenode setModel("tag_origin");

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    plane thread airstrike::function_fc41f67ef33c00b0(var_6d29e82378e59e76, var_98255165b50d8173, (1, 1, 1), 20);
    plane thread airstrike::function_aca0ec4cab6e6319(planeflyheight, targetsite);
  }

  if(streakinfo.streakname == "precision_airstrike" || streakinfo.streakname == "multi_airstrike") {
    level thread airstrike::callstrike_precisionbulleteffect(plane, var_fafbda0eba9c0aab, strikeanimlength, targetsite, owner);
  } else if(streakinfo.streakname == "fuel_airstrike") {
    level thread function_7a04fd48da58db97(plane, var_fafbda0eba9c0aab, strikeanimlength, targetsite, owner);
  }

  plane.scenenode animation::anim_single_solo(plane, "airstrike_flyby");

  if(isDefined(plane.minimapid)) {
    if(utility::issharedfuncdefined("game", "returnObjectiveID")) {
      [[utility::getsharedfunc("game", "returnObjectiveID")]](plane.minimapid);
    }
  }

  plane notify("delete");

  if(isDefined(plane.turrettarget)) {
    plane.turrettarget delete();
  }

  if(isDefined(plane.bulletpoint)) {
    plane.bulletpoint delete();

    if(isDefined(plane.bulletpoint.killcament)) {
      plane.bulletpoint.killcament delete();
    }
  }

  if(isDefined(plane.scenenode)) {
    plane.scenenode delete();
  }

  if(isDefined(plane)) {
    plane delete();
  }
}

function function_7a04fd48da58db97(plane, launchtime, strikelength, damagepos, owner) {
  plane endon("death");
  planedir = plane.flightdir;
  camdamagepos = damagepos + (0, 0, plane.flightheight + 750);
  killcamstartpos = camdamagepos - planedir * 15000;
  killcamendpos = camdamagepos - planedir * 1000;
  var_315162f2d4f72593 = camdamagepos - planedir * 500;
  var_f6f6dedd96f2c531 = istrue(level.isx1ops) && isDefined(level.x1ops) && level.x1ops == 6;
  killcament = undefined;

  if(!var_f6f6dedd96f2c531) {
    killcament = spawn("script_model", killcamstartpos);
    killcament thread airstrike::airstrike_killcammove(launchtime - 3, killcamendpos, var_315162f2d4f72593);
  }

  hostmigration::hostmigration_waitlongdurationwithpause(launchtime);

  if(!isDefined(owner)) {
    return;
  }

  if(utility::issharedfuncdefined("airstrike", "addSpawnDangerZone")) {
    [[utility::getsharedfunc("airstrike", "addSpawnDangerZone")]](damagepos, 650, 650, owner.team, strikelength, owner, 1);
  }

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    sphere(damagepos, 100, (1, 1, 1), 0, 500);
  }

  bombtracestart = damagepos + (0, 0, 2500);
  bombtraceend = damagepos - (0, 0, 10000);
  bombtrace = trace::ray_trace(bombtracestart, bombtraceend, undefined, trace::create_contents(0, 1, 0, 1, 0, 1, 0));
  var_604b31efa39e3f47 = bombtrace["position"];
  bombtracenormal = bombtrace["normal"];
  bombhitpos = var_604b31efa39e3f47 + bombtracenormal * 10;

  airstrikedebugon = getdvarint(@ "hash_920f0586653a26d4", 0);

  if(isDefined(airstrikedebugon) && airstrikedebugon) {
    line(bombtracestart, bombhitpos, (1, 0, 0), 1, 0, 1000);
    line(bombhitpos, bombhitpos + bombtracenormal * 50, (0, 1, 0), 1, 0, 500);
    sphere(bombhitpos, 50, (1, 0, 0), 0, 500);
  }

  var_c6188da3ad302049 = bombhitpos + (0, 0, 800);
  var_6033a7638fe1342f = spawn("script_model", var_c6188da3ad302049);
  var_6033a7638fe1342f.angles = plane.angles;
  var_6033a7638fe1342f.streakinfo = plane.streakinfo;
  var_6033a7638fe1342f setModel("ks_fuelstrike_mp");
  var_6033a7638fe1342f setentityowner(owner);

  if(!var_f6f6dedd96f2c531) {
    var_6033a7638fe1342f.killcament = killcament;
  }

  var_f9f79f4923d00e6e = spawn("script_model", bombhitpos);
  var_f9f79f4923d00e6e.angles = plane.angles;
  var_f9f79f4923d00e6e.streakinfo = plane.streakinfo;
  var_f9f79f4923d00e6e setModel("ks_fuelstrike_mp");
  var_f9f79f4923d00e6e setentityowner(owner);

  if(!var_f6f6dedd96f2c531) {
    var_f9f79f4923d00e6e.killcament = killcament;
  }

  var_f9f79f4923d00e6e setscriptablepartstate("releaseVFX", "on", 0);
  var_6033a7638fe1342f setscriptablepartstate("releaseSFX", "on", 0);
  wait 1.3;
  var_f9f79f4923d00e6e setscriptablepartstate("explode", "on", 0);
  var_b9d5783a4f34efbc = [var_6033a7638fe1342f, var_f9f79f4923d00e6e];
  var_33f031d062a32623 = trace::create_contents(0, 1, 1, 1, 0, 1, 1, 1, 0);
  var_3bd841437dfaa8d7 = airstrike::function_15d7e8b275b8b57b(bombhitpos, 750, owner, var_c6188da3ad302049, var_b9d5783a4f34efbc, var_33f031d062a32623);
  bombweapon = makeweapon("fuelstrike_proj_mp");
  bombexplodedelay = 0.8;
  plane thread airstrike::function_e5a6aaaa22532637(var_6033a7638fe1342f, var_f9f79f4923d00e6e, bombexplodedelay);
  level notify("airstrike_explode");

  owner thread airstrike::function_9018ff93eb75a769(bombexplodedelay, var_f9f79f4923d00e6e);

  foreach(enemy in var_3bd841437dfaa8d7) {
    enemy thread airstrike::function_3c8dfe97ac9ad7c7(owner, bombexplodedelay, var_6033a7638fe1342f, var_f9f79f4923d00e6e, bombweapon);
    enemy thread function_ddb0e63aad9c9a77(90, var_f9f79f4923d00e6e.origin, owner, var_f9f79f4923d00e6e, "MOD_EXPLOSIVE", bombweapon, bombexplodedelay);
  }

  wait bombexplodedelay + level.framedurationseconds * var_3bd841437dfaa8d7.size;
  level thread airstrike::delaydeletefxents(var_6033a7638fe1342f, var_f9f79f4923d00e6e);
}

function function_ddb0e63aad9c9a77(damageamount, damageorigin, attacker, inflictor, meansofdeath, weapon, bombexplodedelay) {
  self endon("death_or_disconnect");

  if(isDefined(bombexplodedelay) && bombexplodedelay > 0) {
    wait bombexplodedelay;
  }

  if(isDefined(level.quest_airstrike)) {
    if(isDefined(self)) {
      scripts\engine\throttle::function_f632348cbb773537(level.var_70ec6a3c1cc881e1, self);
    }

    if(isDefined(self)) {
      self dodamage(damageamount, damageorigin, self, inflictor, meansofdeath, weapon);
    }

    return;
  }

  self dodamage(damageamount, damageorigin, attacker, inflictor, meansofdeath, weapon);
}

function function_57871434ec204550() {}

function function_e9158c9e8c391f25(cover_targetname, num_cover) {
  cover_structs = utility::getStructArray(cover_targetname, "targetname");

  if(cover_structs.size == 0) {
    return cover_structs;
  }

  return function_cf24aec050c0e5f8(cover_structs, num_cover);
}

function function_cf24aec050c0e5f8(cover_structs, num_cover) {
  if(isDefined(num_cover)) {
    num_cover = int(min(num_cover, cover_structs.size));

    if(num_cover < cover_structs.size) {
      cover_structs = utility::array_randomize(cover_structs);
      cover_structs = utility::array_slice(cover_structs, 0, num_cover);
    }
  }

  var_4a21f2ea02343335 = 5;

  for(index = 0; index < cover_structs.size; index++) {
    if(index % var_4a21f2ea02343335 == 0) {
      waitframe();
    }

    cover = cover_structs[index];

    if(isDefined(cover.target)) {
      scriptable = getentitylessscriptablearray(cover.target, "targetname");

      if(isDefined(scriptable[0])) {
        cover.scriptable = scriptable[0];
        cover.scriptable setscriptablepartstate("state", "visible");
      }

      var_5a289139fcc24145 = 1;

      if(isDefined(cover.script_parameters) && cover.script_parameters == "no_nodes") {
        var_5a289139fcc24145 = 0;
      }

      if(var_5a289139fcc24145) {
        cover.a_nodes = getnodearray(cover.target, "targetname");
        waitframe();

        if(isarray(cover.a_nodes) && cover.a_nodes.size > 0) {
          cover thread function_15dfa2c4da409db();
          continue;
        }

        cover thread function_3c71b9114c8f5840();
      }
    }
  }

  return cover_structs;
}

function private function_15dfa2c4da409db() {
  waitframe();

  foreach(cover_node in self.a_nodes) {
    cover_node connectnode();
  }
}

function private function_3c71b9114c8f5840() {
  waitframe();
  self.a_nodes = [];
  var_b1b5e6b1e4e92cb6 = [];

  if(isDefined(self.script_label)) {
    var_b1b5e6b1e4e92cb6 = function_d686fcec0db715b(self.script_label);
  } else if(isDefined(self.scriptable)) {
    var_b1b5e6b1e4e92cb6 = function_d686fcec0db715b(self.scriptable.model);
  }

  foreach(data in var_b1b5e6b1e4e92cb6) {
    self.angles = utility::default_to(self.angles, (0, 0, 0));
    nd_pos = coordtransform(data[0], self.origin, self.angles);
    nd_angles = self.angles + data[1];
    nd = spawncovernode(nd_pos, nd_angles, data[2]);

    if(isDefined(nd)) {
      nd connectnode();
      self.a_nodes = utility::function_6d6af8144a5131f1(self.a_nodes, nd);
    }
  }
}

function function_486b0f579d5b6dae(cover) {
  a_cover = [];

  if(isstring(cover)) {
    a_cover = utility::getStructArray(cover, "targetname");
  }

  if(isarray(cover)) {
    a_cover = cover;
  } else {
    return;
  }

  foreach(struct in a_cover) {
    if(isDefined(struct.scriptable)) {
      struct.scriptable setscriptablepartstate("state", "hidden");
    }

    if(isDefined(struct.a_nodes)) {
      foreach(nd in struct.a_nodes) {
        nd disconnectnode();

        if(nd function_4e6288d290958f94()) {
          despawncovernode(nd);
        }
      }
    }
  }
}

function private function_d686fcec0db715b(str_model) {
  var_b1b5e6b1e4e92cb6 = [];

  switch (str_model) {
    case #"hash_c7e0aaf6e7799aea":
      var_b1b5e6b1e4e92cb6[0] = [(-20, 28, 16), (0, 270, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[1] = [(20, 28, 16), (0, 270, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[2] = [(20, -28, 16), (0, 90, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[3] = [(-20, -28, 16), (0, 90, 0), "Cover Crouch"];
      break;
    case #"hash_3e533e8173a68e96":
      var_b1b5e6b1e4e92cb6[0] = [(-34, 0, 16), (0, 0, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[1] = [(0, 34, 16), (0, 270, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[2] = [(34, 0, 16), (0, 180, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[3] = [(0, -34, 16), (0, 90, 0), "Cover Crouch"];
      break;
    case #"hash_9e5db913883995d":
      var_b1b5e6b1e4e92cb6[0] = [(16, 46, 16), (0, 270, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[1] = [(46, 16, 16), (0, 180, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[2] = [(-46, 16, 16), (0, 360, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[3] = [(46, -16, 16), (0, 180, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[4] = [(-16, 46, 16), (0, 360, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[5] = [(-46, -16, 16), (0, 360, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[6] = [(16, -46, 16), (0, 90, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[7] = [(-16, -46, 16), (0, 90, 0), "Cover Left"];
      break;
    case #"hash_2051917927d8a8fe":
      var_b1b5e6b1e4e92cb6[0] = [(-40, 0, 16), (0, 360, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[1] = [(40, 0, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[2] = [(0, 42, 16), (0, 270, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[3] = [(0, -44, 16), (0, 90, 0), "Cover Stand"];
      break;
    case #"hash_9f8ac821a3fbb851":
      var_b1b5e6b1e4e92cb6[0] = [(16, 48, 16), (0, 270, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[1] = [(48, 16, 16), (0, 180, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[2] = [(-48, 16, 16), (0, 360, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[3] = [(48, -16, 16), (0, 180, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[4] = [(-16, 48, 16), (0, 270, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[5] = [(-48, -16, 16), (0, 360, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[6] = [(16, -48, 16), (0, 90, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[7] = [(-16, -48, 16), (0, 90, 0), "Cover Left"];
      break;
    case #"hash_385896730ddac9b":
      var_b1b5e6b1e4e92cb6[0] = [(-20, 82, 16), (0, 270, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[1] = [(52, 48, 16), (0, 180, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[2] = [(-52, 8, 16), (0, 0, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[3] = [(20, -86, 16), (0, 90, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[4] = [(18, 82, 16), (0, 270, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[5] = [(-52, -52, 16), (0, 0, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[6] = [(52, -52, 16), (0, 180, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[7] = [(-18, -86, 16), (0, 90, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[8] = [(52, -8, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[9] = [(-52, 48, 16), (0, 0, 0), "Cover Left"];
      break;
    case #"hash_671b50e68da4e3dc":
      var_b1b5e6b1e4e92cb6[0] = [(46, -54, 16), (0, 90, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[1] = [(-2, -52, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[2] = [(-46, -54, 16), (0, 90, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[3] = [(-78, -20, 16), (0, 360, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[4] = [(-78, 20, 16), (0, 360, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[5] = [(-46, 54, 16), (0, 270, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[6] = [(-2, 52, 16), (0, 270, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[7] = [(46, 54, 16), (0, 270, 0), "Cover Left"];
      break;
    case #"hash_35b74b199651346c":
      var_b1b5e6b1e4e92cb6[0] = [(-50, 58, 16), (0, 0, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[1] = [(-50, -58, 16), (0, 0, 0), "Cover Right"];
      break;
    case #"hash_44f7243fb4c2f7d6":
      var_b1b5e6b1e4e92cb6[0] = [(0, -22, 16), (0, 90, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[1] = [(0, 22, 16), (0, 270, 0), "Cover Crouch"];
      break;
    case #"hash_7d2b4f6c6cb085ac":
      var_b1b5e6b1e4e92cb6[0] = [(50, 0, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[1] = [(0, -44, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[2] = [(-50, 0, 16), (0, 0, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[3] = [(0, 46, 16), (0, 270, 0), "Cover Stand"];
      break;
    case #"hash_df78bf717608a1dd":
      var_b1b5e6b1e4e92cb6[0] = [(44, -36, 16), (0, 180, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[1] = [(44, 28, 16), (0, 180, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[2] = [(14, 60, 16), (0, 270, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[3] = [(-10, 60, 16), (0, 270, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[4] = [(-40, 28, 16), (0, 0, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[5] = [(-40, -36, 16), (0, 0, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[6] = [(-10, -68, 16), (0, 90, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[7] = [(14, -68, 16), (0, 90, 0), "Cover Right"];
      break;
    case #"hash_d7c559d4de79bc25":
      var_b1b5e6b1e4e92cb6[0] = [(-34, 16, 16), (0, 0, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[1] = [(-34, -18, 16), (0, 0, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[2] = [(0, -50, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[3] = [(34, -18, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[4] = [(34, 16, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[5] = [(0, 48, 16), (0, 270, 0), "Cover Stand"];
      break;
    case #"hash_2dbfafe10b0dc6fb":
      var_b1b5e6b1e4e92cb6[0] = [(-86, 18, 16), (0, 0, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[1] = [(-86, -16, 16), (0, 0, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[2] = [(-54, -48, 16), (0, 90, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[3] = [(10, -32, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[4] = [(42, -46, 16), (0, 90, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[5] = [(74, -14, 16), (0, 180, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[6] = [(72, 14, 16), (0, 180, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[7] = [(42, 46, 16), (0, 270, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[8] = [(10, 34, 16), (0, 270, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[9] = [(-54, 50, 16), (0, 270, 0), "Cover Right"];
      break;
    case #"hash_72a2a68ca2987825":
      var_b1b5e6b1e4e92cb6[0] = [(-42, 36, 16), (0, 38, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[1] = [(-26, 2, 16), (0, 0, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[2] = [(-40, -36, 16), (0, 308, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[3] = [(-2, -66, 16), (0, 136, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[4] = [(24, 2, 16), (0, 180, 0), "Cover Crouch"];
      var_b1b5e6b1e4e92cb6[5] = [(6, 62, 16), (0, 215, 0), "Cover Crouch"];
      break;
    case #"hash_8db5a88b741a577e":
      var_b1b5e6b1e4e92cb6[0] = [(-44, 0, 16), (0, 0, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[1] = [(-16, -40, 16), (0, 90, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[2] = [(16, -40, 16), (0, 90, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[3] = [(44, 0, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[4] = [(16, 40, 16), (0, 270, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[5] = [(-16, 40, 16), (0, 270, 0), "Cover Right"];
      break;
    case #"hash_abd3702bcd5c566d":
      var_b1b5e6b1e4e92cb6[0] = [(-32, 0, 16), (0, 0, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[1] = [(0, -32, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[2] = [(32, 0, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[3] = [(0, 32, 16), (0, 270, 0), "Cover Stand"];
      break;
    case #"hash_1b9f4f0b9db8b629":
      var_b1b5e6b1e4e92cb6[0] = [(-98, 16, 16), (0, 0, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[1] = [(-98, -16, 16), (0, 0, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[2] = [(-60, -50, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[3] = [(52, -46, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[4] = [(92, -16, 16), (0, 180, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[5] = [(92, 16, 16), (0, 180, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[6] = [(50, 52, 16), (0, 270, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[7] = [(-62, 48, 16), (0, 270, 0), "Cover Stand"];
      break;
    case #"hash_9788f6a3e338ad4e":
      var_b1b5e6b1e4e92cb6[0] = [(-136, 30, 16), (0, 0, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[1] = [(-136, -24, 16), (0, 0, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[2] = [(-102, -60, 16), (0, 90, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[3] = [(-52, -60, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[4] = [(96, -60, 16), (0, 90, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[5] = [(134, -24, 16), (0, 180, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[6] = [(136, 28, 16), (0, 180, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[7] = [(100, 64, 16), (0, 270, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[8] = [(-52, 64, 16), (0, 270, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[9] = [(-102, 64, 16), (0, 270, 0), "Cover Right"];
      break;
    case #"hash_7be737f2812cfd50":
      var_b1b5e6b1e4e92cb6[0] = [(-36, 10, 16), (0, 0, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[1] = [(-36, -10, 16), (0, 0, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[2] = [(0, -40, 16), (0, 90, 0), "Cover Multi"];
      var_b1b5e6b1e4e92cb6[3] = [(34, -10, 16), (0, 180, 0), "Cover Left"];
      var_b1b5e6b1e4e92cb6[4] = [(34, 10, 16), (0, 180, 0), "Cover Right"];
      var_b1b5e6b1e4e92cb6[5] = [(0, 40, 16), (0, 270, 0), "Cover Multi"];
      break;
    case #"hash_9fc5b4fdb662e731":
      var_b1b5e6b1e4e92cb6[0] = [(-36, 20, 16), (0, 0, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[1] = [(-36, -20, 16), (0, 0, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[2] = [(0, -52, 16), (0, 90, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[3] = [(34, -20, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[4] = [(34, 20, 16), (0, 180, 0), "Cover Stand"];
      var_b1b5e6b1e4e92cb6[5] = [(0, 54, 16), (0, 270, 0), "Cover Stand"];
      break;
    case #"hash_d44cb989edc40ab3":
      var_b1b5e6b1e4e92cb6[0] = [(0, 0, 16), (0, 0, 0), "Exposed"];
    default:
      break;
  }

  return var_b1b5e6b1e4e92cb6;
}