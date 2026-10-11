/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_231b61569cad7b2.gsc
************************************************/

#using script_214930d31a3a8321;
#using script_24e4405cf93f20ed;
#using script_41387eecc35b88bf;
#using script_4bac13d511590220;
#using script_711611a499b96971;
#using script_711820027508efbb;
#using scripts\common\callbacks;
#using scripts\common\utility;
#using scripts\common\vehicle;
#using scripts\common\vehicle_paths;
#using scripts\cp_mp\agents\ai_spawn_director;
#using scripts\cp_mp\overlord;
#using scripts\cp_mp\vehicles\vehicle;
#using scripts\cp_mp\vehicles\vehicle_interact;
#using scripts\cp_mp\vehicles\vehicle_spawn;
#using scripts\engine\utility;
#using scripts\mp\flags;
#using scripts\mp\objidpoolmanager;
#using scripts\mp\utility\debug;
#using scripts\mp\vehicles\damage;
#namespace namespace_3bba63e428117813;

function function_e9a6ff6b9621b866(testorigin) {
  return distance2d(testorigin, self.origin);
}

function deathwatcher() {
  self waittill("death");
}

function function_ab13526d8a324001() {
  escortdata = spawnStruct();
  escortdata.state = "Initial_Phase";
  level.escortdata = escortdata;
  flag_wait("create_script_initialized");
  spawndata = getStruct("acv_spawn", "script_noteworthy");
  spawndata.initai = 0;
  spawndata.preventrespawn = 1;
  spawndata.var_699ac4a9c9e9f0ec = 1;
  spawndata.var_24993ee24f7c7c0 = 1;
  level callback::add("on_zombie_ai_damaged", &function_c78cc3de6029da95);
  flag_wait("vehicle_init_done");
  var_59a5ab1b4256bb79 = scripts\cp_mp\vehicles\vehicle::vehicle_spawn("veh_jup_ob_tank_escort", spawndata);

  if(getdvarint(@ "hash_8d0847719c2a3d4", 0) > 0) {
    var_59a5ab1b4256bb79.health = getdvarint(@ "hash_8d0847719c2a3d4", 0);
    var_59a5ab1b4256bb79.maxhealth = var_59a5ab1b4256bb79.health;
  }

  level.var_59a5ab1b4256bb79 = var_59a5ab1b4256bb79;
  level.var_59a5ab1b4256bb79 vehicleshowonminimap(0);
  level.var_59a5ab1b4256bb79.vo_ent = spawn("script_model", level.var_59a5ab1b4256bb79.origin);
  level.var_59a5ab1b4256bb79.vo_ent linkTo(level.var_59a5ab1b4256bb79, "tag_origin", (0, 0, 78), (0, 0, 0));

  if(getdvarint(@ "hash_7621c0910be68869")) {
    level.var_59a5ab1b4256bb79.isimmune = 1;
  }

  level.var_cf764198c395106f = getdvarint(@ "hash_6e000bcf2441dd95", 1);
  var_59a5ab1b4256bb79.playersnear = 0;
  var_59a5ab1b4256bb79.damagecallback = &function_d4e87a535903fb80;
  var_59a5ab1b4256bb79.isimmune = 1;
  scripts\cp_mp\vehicles\vehicle_interact::vehicle_interact_makeunusable(var_59a5ab1b4256bb79);
  function_7769ede06d2efd50();
  spawn_orb();

  level thread function_b6204aec63918c11();
  level thread function_74d84bc498a40435();
  level thread function_61dfd878a37d4397();
  level thread function_bf7aea1857fe7029();
  level thread function_abbf11c262d080bf();

  flag_wait("toc_rescued");

  if(isDefined(level.var_c921cb81dd47af55)) {
    level.var_c921cb81dd47af55 thread namespace_87ebdf00d835c96b::function_973c94b4840e3cdb();
  }

  var_59a5ab1b4256bb79 thread function_55c81c12fbae171();
  var_59a5ab1b4256bb79 thread function_2e24c0e75afea368();
}

function function_d4e87a535903fb80(inflictor, attacker, damage, dflags, meansofdeath, objweapon, point, dir, hitloc, timeoffset, modelindex, attachtagname, partname, eventid) {}

function function_dfd20fa6ae9ecbb1() {
  self notify("acv_repair");
  self endon("acv_repair");
  self.isimmune = 1;
  self.repairing = 1;

  if(istrue(self.var_d6132fcd1f1b1da2)) {
    self vehphys_parkingbrake(1);
    self vehicle_setspeedimmediate(0);
    self.var_2d245c20ed997af6 = 1;
  }

  while(self.health < self.maxhealth) {
    self.health += getdvarint(@ "hash_e9aa68869bcc1e67", 8);
    var_94f4219fffa649f0 = self.health / self.maxhealth;

    foreach(player in level.players) {
      player setclientomnvar("ui_br_objective_param", int(var_94f4219fffa649f0 * 100));
      player setclientomnvar("ui_br_objective_progress_bar", int(var_94f4219fffa649f0 * 100));
    }

    waitframe();
  }

  if(self.health > self.maxhealth) {
    self.health = self.maxhealth;
  }

  var_94f4219fffa649f0 = self.health / self.maxhealth;

  if(level.var_fe5c2634af4ea573 == "QUEST_0_RIFT_S2_ESCORT_PRE_EMP" || level.var_fe5c2634af4ea573 == "QUEST_0_RIFT_S2_ESCORT_EMP_ENEMY") {
    foreach(player in level.players) {
      player setclientomnvar("ui_br_objective_param", int(var_94f4219fffa649f0 * 100));
      player setclientomnvar("ui_br_objective_progress_bar", int(var_94f4219fffa649f0 * 100));
    }
  }

  if(istrue(self.var_d6132fcd1f1b1da2)) {
    if(self.playersnear >= level.var_cf764198c395106f && istrue(self.var_2d245c20ed997af6)) {
      self vehicle_setspeedimmediate(6);
      self.var_2d245c20ed997af6 = 0;
    }

    self vehphys_parkingbrake(0);
  }

  self.repairing = 0;
  self.isimmune = 0;
}

function spawn_orb() {
  orbspawn = getStruct("orb_spawn", "script_noteworthy");

  if(!isDefined(orbspawn)) {
    assert(0, "<dev string:x1c>");
    return;
  }

  var_c831131ad79495ea = spawn("script_model", orbspawn.origin);

  if(!isDefined(var_c831131ad79495ea)) {
    assert(0, "<dev string:x6e>");
    return;
  }

  var_c831131ad79495ea setModel("jup_zm_act_3_neutralizer_orb");
  level.var_c831131ad79495ea = var_c831131ad79495ea;
}

function private function_c78cc3de6029da95(params) {
  if(params.objweapon.basename == "ob_tank_escort_mp" && params.idamage >= self.health && params.smeansofdeath == "MOD_CRUSH") {
    vehspeed = params.eattacker vehicle_getspeed();

    if(vehspeed >= 3) {
      self.forceannihilate = 1;
    }
  }
}

function function_2e24c0e75afea368() {
  while(self.playersnear < level.var_cf764198c395106f) {
    waitframe();
  }

  function_c7311cb3f768f21e("ambient_blocker_to_rescue", 0);
  returnreservedobjectiveid(level.objids["regroup_acv_icon"]);
  level.var_59a5ab1b4256bb79.markerattach = spawn("script_model", level.var_59a5ab1b4256bb79.origin);
  level.var_59a5ab1b4256bb79.team = "neutral";
  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_ESCORT_PRE_EMP";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);
  vehiclenode = getvehiclenode("acv_spline_full_map", "targetname");

  if(!isDefined(vehiclenode)) {
    assert(0, "<dev string:x8e>");
    return;
  }

  while(istrue(self.repairing)) {
    waitframe();
  }

  scripts\common\vehicle::attach_vehicle(vehiclenode);
  scripts\common\vehicle_paths::gopath(self);
  var_e5971246bca6222 = getStruct("escort_pre_carnival_encounter_location", "targetname");
  var_53a1ee9711299e43 = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_ob_ambient_s2_5_rift_small", var_e5971246bca6222.origin, 700, 1, 1, 0);
  self.isimmune = 0;
  self.var_d6132fcd1f1b1da2 = 1;
  self vehphys_parkingbrake(0);
  self vehicle_setspeedimmediate(6);
  self vehicle_turnengineon();
  thread function_486469bd0c74b8ed();
  self.var_2d245c20ed997af6 = 0;

  while(istrue(self.var_d6132fcd1f1b1da2)) {
    if(self.playersnear < level.var_cf764198c395106f && !istrue(self.var_2d245c20ed997af6)) {
      self vehicle_setspeedimmediate(0);
      self.var_2d245c20ed997af6 = 1;
    } else if(self.playersnear >= level.var_cf764198c395106f && istrue(self.var_2d245c20ed997af6) && !istrue(self.repairing)) {
      self vehicle_setspeedimmediate(6);
      self.var_2d245c20ed997af6 = 0;
    }

    waitframe();
  }

  self vehphys_parkingbrake(1);
  self vehicle_setspeedimmediate(0);
  thread function_970ca31546ea9a1d();
}

function function_c8217e4d6033ce87() {
  while(self.playersnear < level.var_cf764198c395106f) {
    waitframe();
  }

  while(istrue(self.repairing)) {
    waitframe();
  }

  function_9b8829ab4092a7d7("use_miniboss_buckets", 1);
  function_606642b946a01237("ambient_blocker_orb_pickup", level.var_59a5ab1b4256bb79.origin, 8000, 0);
  self.var_d6132fcd1f1b1da2 = 1;
  self vehphys_parkingbrake(0);
  self vehicle_setspeedimmediate(6);
  self vehicle_turnengineon();
  thread function_486469bd0c74b8ed();
  self.var_2d245c20ed997af6 = 0;

  while(istrue(self.var_d6132fcd1f1b1da2)) {
    if(self.playersnear < level.var_cf764198c395106f && !istrue(self.var_2d245c20ed997af6)) {
      self vehicle_setspeedimmediate(0);
      self.var_2d245c20ed997af6 = 1;
    } else if(self.playersnear >= level.var_cf764198c395106f && istrue(self.var_2d245c20ed997af6) && !istrue(self.repairing)) {
      self vehicle_setspeedimmediate(6);
      self.var_2d245c20ed997af6 = 0;
    }

    waitframe();
  }

  self vehphys_parkingbrake(1);
  self vehicle_setspeedimmediate(0);
  thread function_3706bfdc9306bb23();
  scripts\cp_mp\overlord::playconversation("s2_orb_pickup", level.players);
}

function function_21794c4da288d340() {
  while(self.playersnear < level.var_cf764198c395106f) {
    waitframe();
  }

  while(istrue(self.repairing)) {
    waitframe();
  }

  function_c7311cb3f768f21e("ambient_blocker_orb_pickup", 0);
  var_ec61016e980b1556 = getStruct("escort_post_orb_encounter_location", "targetname");
  var_ab15e30ebee70e4f = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_ob_ambient_s2_5_rift_medium", var_ec61016e980b1556.origin, 700, 1, 1, 0);
  self.var_d6132fcd1f1b1da2 = 1;
  self vehphys_parkingbrake(0);
  self vehicle_setspeedimmediate(6);
  self vehicle_turnengineon();
  thread function_486469bd0c74b8ed();
  self.var_2d245c20ed997af6 = 0;

  while(istrue(self.var_d6132fcd1f1b1da2)) {
    if(self.playersnear < level.var_cf764198c395106f && !istrue(self.var_2d245c20ed997af6)) {
      self vehicle_setspeedimmediate(0);
      self.var_2d245c20ed997af6 = 1;
    } else if(self.playersnear >= level.var_cf764198c395106f && istrue(self.var_2d245c20ed997af6) && !istrue(self.repairing)) {
      self vehicle_setspeedimmediate(6);
      self.var_2d245c20ed997af6 = 0;
    }

    waitframe();
  }

  self vehphys_parkingbrake(1);
  self vehicle_setspeedimmediate(0);
  level.var_767f0511c6ecd9c3 = 1;
  var_44d600dd175b86fa = getStruct("ambient_blocker_stronghold_in_progress", "targetname");
  function_606642b946a01237("ambient_blocker_stronghold_in_progress", var_44d600dd175b86fa.origin, 5000, 0);
  scripts\cp_mp\overlord::playevent("s2_acv_mall_arrival_fletcher", level.players);
  wait 1.5;
  scripts\cp_mp\overlord::playevent("s2_acv_mall_arrival_ravenov", level.players);
  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_ENTERSTRONGHOLD";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);
  objectivename = "mall_entry_icon";
  level.objids[objectivename] = requestobjectiveid();
  objective_add_objective(level.objids[objectivename], "current", (-28257, -20944, 410) + (0, 0, 40), "jup_ui_map_icon_obj_toc");
  update_objective_setbackground(level.objids[objectivename], 1);
  objective_addalltomask(level.objids[objectivename]);
  objective_playermask_showtoall(level.objids[objectivename]);
  thread stronghold_triggers();
  flag_wait("fletcher_mall_rescued");
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(level.objids["fletcher_meeting_icon"]);
  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_REGROUP_POST_MALL";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);

  while(self.playersnear < level.var_cf764198c395106f) {
    waitframe();
  }

  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_WAIT_FLETCHER";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);
  flag_wait("fletcher_mall_at_acv");
  thread function_e79033ed2ec481f1();
}

function stronghold_triggers() {
  numtriggers = 4;
  level.var_b638221ce9565e9c = [];
  var_3be6f15b5b74f3a9 = [(-28257, -20944, 410), (-24904, -18691, 490), (-24509, -21011, 490), (-26125, -22329, 446)];
  radi = 400;
  height = 400;

  for(i = 0; i < numtriggers; i++) {
    level thread scripts\mp\utility\debug::drawsphere(var_3be6f15b5b74f3a9[i], radi, 99900, (0, 1, 0));

    var_14e808311a8f5717 = spawn("trigger_radius", var_3be6f15b5b74f3a9[i], 1, radi, height);

    if(issharedfuncdefined("game", "makeEnterExitTrigger")) {
      [[getsharedfunc("game", "makeEnterExitTrigger")]](var_14e808311a8f5717, &function_c9d8c391758a9b50, undefined);
    }

    level.var_b638221ce9565e9c[level.var_b638221ce9565e9c.size] = var_14e808311a8f5717;
  }
}

function function_c9d8c391758a9b50(player, trigger) {
  if(!isPlayer(player)) {
    return;
  }

  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_CLEAR_STRONGHOLD";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);
  scripts\mp\objidpoolmanager::returnreservedobjectiveid(level.objids["mall_entry_icon"]);

  foreach(trig in level.var_b638221ce9565e9c) {
    trig delete();
  }
}

function function_e79033ed2ec481f1() {
  while(self.playersnear < level.var_cf764198c395106f) {
    waitframe();
  }

  returnreservedobjectiveid(level.objids["regroup_acv_icon"]);
  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_ESCORT_POST_MALL";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);

  while(istrue(self.repairing)) {
    waitframe();
  }

  var_743aca92aa95283d = getStruct("escort_post_mall_encounter_location", "targetname");
  var_4c317df294c23716 = scripts\cp_mp\agents\ai_spawn_director::spawn_request("ai_encounter:enc_ob_ambient_s2_5_rift_large", var_743aca92aa95283d.origin, 700, 1, 1, 0);
  self.var_d6132fcd1f1b1da2 = 1;
  self vehphys_parkingbrake(0);
  self vehicle_setspeedimmediate(6);
  self vehicle_turnengineon();
  thread function_486469bd0c74b8ed();
  thread function_886b7cb65dda580f();
  self.var_2d245c20ed997af6 = 0;

  while(istrue(self.var_d6132fcd1f1b1da2)) {
    if(self.playersnear < level.var_cf764198c395106f && !istrue(self.var_2d245c20ed997af6)) {
      self vehicle_setspeedimmediate(0);
      self.var_2d245c20ed997af6 = 1;
    } else if(self.playersnear >= level.var_cf764198c395106f && istrue(self.var_2d245c20ed997af6) && !istrue(self.repairing)) {
      self vehicle_setspeedimmediate(6);
      self.var_2d245c20ed997af6 = 0;
    }

    waitframe();
  }

  self vehphys_parkingbrake(1);
  self vehicle_setspeedimmediate(0);
}

function function_486469bd0c74b8ed() {
  level endon("game_ended");
  self endon("entitydeleted");
  self waittill("engineoff");
  self.var_d6132fcd1f1b1da2 = 0;
}

function function_970ca31546ea9a1d() {
  level endon("game_ended");
  self notify("acv_emped");
  playsoundatpos(self.origin, "iw9_emp_hud_scramble");
  level.var_b1d34148f101054d = 1;
  flag_set("acv_emped");
  level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_ESCORT_EMP";
  namespace_68270f885c7fd3ef::function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);

  if(flag("travel_boss_defeated")) {
    level.var_fe5c2634af4ea573 = "QUEST_0_RIFT_S2_ESCORT_PRE_EMP";
    function_9306d91e52ec93e1(level.var_fe5c2634af4ea573);
  } else {
    flag_wait("travel_boss_defeated");
  }

  level.var_e66b99df0b195fd9 = 1;
  thread function_c8217e4d6033ce87();
}

function private function_55c81c12fbae171() {
  level endon("game_ended");
  self endon("death");
  self endon("entitydeleted");

  while(true) {
    self.playersnear = 0;

    foreach(player in level.players) {
      if(function_e9a6ff6b9621b866(player.origin) < 300) {
        self.playersnear++;
      }
    }

    wait 1;
  }
}

function function_3706bfdc9306bb23() {
  level endon("game_ended");
  wait 25;
  self setscriptablepartstate("maw", "maw_open");
  level.var_c831131ad79495ea notsolid();
  level.var_c831131ad79495ea setscriptablepartstate("body", "orb_pickup");
  playFXOnTag(getfx("acv_orb_activated_ground_up"), level.var_c831131ad79495ea, "tag_origin");
  wait 2;
  var_7554036a589e750b = 0;
  totalduration = 1000;
  prevtime = gettime();
  startpos = level.var_c831131ad79495ea.origin;
  endpos = self.origin + (0, 0, 31) + anglesToForward(self.angles) * 47;
  startangles = level.var_c831131ad79495ea.angles;
  endangles = function_45db14db9e1d13bd(startangles, self.angles + (78, 0, 0));

  while(var_7554036a589e750b < totalduration) {
    currtime = gettime();
    deltatime = currtime - prevtime;
    var_7554036a589e750b += deltatime;
    level.var_c831131ad79495ea.origin = vectorlerp(startpos, endpos, squared(var_7554036a589e750b / totalduration));
    level.var_c831131ad79495ea.angles = vectorlerp(startangles, endangles, squared(var_7554036a589e750b / totalduration));
    prevtime = currtime;
    waitframe();
  }

  level.var_c831131ad79495ea.origin = endpos;
  level.var_c831131ad79495ea.angles = endangles;
  level.var_c831131ad79495ea linkTo(self);
  playFXOnTag(getfx("acv_orb_activated_ground_connected"), level.var_c831131ad79495ea, "tag_origin");
  wait 2;
  thread function_21794c4da288d340();
}

function function_45db14db9e1d13bd(startangles, endangles) {
  startx = startangles[0];
  endx = endangles[0];
  starty = startangles[1];
  endy = endangles[1];
  startz = startangles[2];
  endz = endangles[2];

  while(abs(endx - startx) > 180) {
    if(endx > startx) {
      endx -= 360;
      continue;
    }

    endx += 360;
  }

  while(abs(endy - starty) > 180) {
    if(endy > starty) {
      endy -= 360;
      continue;
    }

    endy += 360;
  }

  while(abs(endz - startz) > 180) {
    if(endz > startz) {
      endz -= 360;
      continue;
    }

    endz += 360;
  }

  return (endx, endy, endz);
}

function function_7769ede06d2efd50() {
  level flag_wait("ai_spawn_director_initialized");
  scripts\mp\flags::gameflagwait("prematch_done");
  level.var_2f10c6e61988cbca = scripts\cp_mp\agents\ai_spawn_director::function_930897c0d1a7eb24("enc_convoy_breakdown");

  if(!isDefined(level.var_2f10c6e61988cbca)) {
    assert(0, "<dev string:xdd>");
    return;
  }

  function_bc5315dc37ae4cf(level.var_2f10c6e61988cbca, &function_934e97ee7a1219b5);
  function_73147cdf5c28d10c(level.var_2f10c6e61988cbca, &function_4f4c063fe3a67768);
  function_fc38783a3da0bc71(level.var_2f10c6e61988cbca, 1);
}

function function_934e97ee7a1219b5(requestid, userdata) {
  return istrue(level.var_df81407f06a59c19);
}

function function_4f4c063fe3a67768(requestid, userdata) {
  return istrue(level.var_e66b99df0b195fd9);
}

function function_886b7cb65dda580f() {
  level endon("game_ended");
  self endon("death");
  self endon("entitydeleted");
  activityinstance = function_ebcfa8f0cbb5cbf1("OUTLAST_S2_5_MISSION_STADIUM");
  level.var_8f8084aa1811db12 = activityinstance;

  if(!isDefined(level.var_8f8084aa1811db12)) {
    assert(0, "<dev string:x120>");
    return;
  }

  while(true) {
    distsq = distancesquared(level.var_8f8084aa1811db12.var_35ee2a06aa1f8973, self.origin);

    if(distancesquared(level.var_8f8084aa1811db12.var_35ee2a06aa1f8973, self.origin) < 36000000 && !istrue(level.var_e974c147cb9b71f5)) {
      scripts\cp_mp\overlord::playconversation("s2_stadium_notice", level.players);
      level.var_e974c147cb9b71f5 = 1;
    }

    if(distancesquared(level.var_8f8084aa1811db12.var_35ee2a06aa1f8973, self.origin) < 1000000 && !istrue(level.var_57814a1aa5995767)) {
      scripts\cp_mp\overlord::playconversation("s2_precharge_orb", level.players);
      level.var_57814a1aa5995767 = 1;
      level.var_c921cb81dd47af55 namespace_87ebdf00d835c96b::function_f246b3550eda8b6f();
      namespace_aef5acbeff8c8d31::function_651b9e0cef8d1607();
      level thread namespace_aef5acbeff8c8d31::function_cf50cdab18d075b0();
      return;
    }

    waitframe();
  }
}

function function_b6204aec63918c11() {
  while(true) {
    if(getdvarint(@ "hash_d418d3549a789e3a", 0) == 1) {
      flag_set("<dev string:x16d>");
      setDvar(@ "hash_d418d3549a789e3a", 0);
    }

    waitframe();
  }
}

function function_74d84bc498a40435() {
  while(true) {
    if(getdvarint(@ "hash_965bcfab0f090516", 0) == 1) {
      flag_set("<dev string:x17c>");
      setDvar(@ "hash_965bcfab0f090516", 0);
    }

    waitframe();
  }
}

function function_61dfd878a37d4397() {
  while(true) {
    if(getdvarint(@ "hash_f79559be4cf80b45", 0) == 1) {
      flag_set("<dev string:x194>");
      setDvar(@ "hash_f79559be4cf80b45", 0);
    }

    waitframe();
  }
}

function function_bf7aea1857fe7029() {
  while(true) {
    if(getdvarint(@ "hash_11995c0ff3b385c6", 0) == 1) {
      level.var_59a5ab1b4256bb79.health = 1;

      foreach(player in level.players) {
        player setclientomnvar("<dev string:x1ad>", 0);
        player setclientomnvar("<dev string:x1c6>", 0);
      }

      level.var_59a5ab1b4256bb79 thread function_dfd20fa6ae9ecbb1();
      setDvar(@ "hash_11995c0ff3b385c6", 0);
    }

    waitframe();
  }
}

function function_abbf11c262d080bf() {
  while(true) {
    if(getdvarint(@ "hash_d203a3ec97163a49", 0) == 1) {
      if(isDefined(level.var_59a5ab1b4256bb79)) {
        level.var_59a5ab1b4256bb79.origin = (-31232, -23522, 250);
        level.var_59a5ab1b4256bb79.angles = (10, 327, 0);
        level.var_59a5ab1b4256bb79 vehphys_parkingbrake(1);
        level.var_59a5ab1b4256bb79 vehicle_setspeedimmediate(0);
        level.var_59a5ab1b4256bb79 thread function_3706bfdc9306bb23();
      }

      setDvar(@ "hash_d203a3ec97163a49", 0);
    }

    waitframe();
  }
}

# /