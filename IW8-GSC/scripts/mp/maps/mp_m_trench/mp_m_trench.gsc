/*******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_m_trench\mp_m_trench.gsc
*******************************************************/

function main() {
  _start_rooftop_raid_exfil::keypad_check_levelinput();
  scripts\mp\maps\mp_m_trench\mp_m_trench_precache::main();
  scripts\mp\maps\mp_m_trench\gen\mp_m_trench_art::main();
  scripts\mp\maps\mp_m_trench\mp_m_trench_fx::main();
  scripts\mp\maps\mp_m_trench\mp_m_trench_lighting::main();
  scripts\mp\load::main();
  level.outofboundstriggers = getEntArray("OutOfBounds", "targetname");
  scripts\mp\compass::setupminimap("compass_map_mp_m_trench", "codcaster_compass_map_mp_m_trench");
  scripts\cp_mp\utility\game_utility::registerarenamap();
  level.requiresminstartspawns = 0;
  level.chopper_gunner_assignedtargetmarkers_onnewai = getnodesinradius((1952, 0, -192), 800, 0, 400);
  setDvar("PKKMTTRQO", 8);
  game["attackers"] = "allies";
  game["defenders"] = "axis";
  game["allies_outfit"] = "urban";
  game["axis_outfit"] = "woodland";
  thread onplayerconnect();
  thread ref_129f4();
  thread teamrefundplunder();
  level.max_respawn = 1;
  level.ref_12328 = 1;
  thread vehicles_spawned();
  thread ref_13241();
}

function onplayerconnect() {
  for(;;) {
    level waittill("connected", var_0);
    thread flagender();
  }
}

function ref_1313f(var_0, var_1) {
  switch (var_1) {
    case 1:
      var_2 = getEnt("Num1", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 2:
      var_2 = getEnt("Num2", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 3:
      var_2 = getEnt("Num3", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 4:
      var_2 = getEnt("Num4", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 5:
      var_2 = getEnt("Num5", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 6:
      var_2 = getEnt("Num6", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 7:
      var_2 = getEnt("Num7", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 8:
      var_2 = getEnt("Num8", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    case 9:
      var_2 = getEnt("Num9", "targetname");
      var_2.origin = var_0.origin;
      var_2.angles = var_0.angles;
      break;
    default:
      break;
  }
}

function ref_13d1d() {
  wait 5;
  var_0 = getEnt("BunkerPathBlocker", "targetname");
  var_0 hide();
  var_0 connectpaths();
  ref_12121(level.door);
  level.monitor_player_pinging = getEntArray("elevatorDoor", "targetname");

  foreach(var_2 in level.monitor_player_pinging) {
    thread ref_1323d(var_2);
  }

  var_4 = scripts\engine\utility::getStruct("phoneHint", "targetname");
  level.ref_12324 = easepower("maphint_phone_mp_m_trench", var_4.origin);
  waitframe();
  scripts\engine\scriptable::ref_12f5b("maphint_phone", &ref_11ae3);

  for(;;) {
    level.ref_12329 = 1;
    thread ref_1232b(var_4);
    level waittill("PhoneAnswered");
    level.ref_1232c stoploopsound("trench_phone_ring");
    level.ref_1232c delete();
    playsoundatpos(level.ref_12324.origin, "trench_phone_pickup");
    wait 0.5;
    playsoundatpos(level.ref_12324.origin, "dx_bra_rubc_bunker_trench_phone_interact_20");
    wait 4.9;
    playsoundatpos(level.ref_12324.origin, "trench_phone_hangup");
    wait 0.5;
    vehicle_isneutraltoteam();
    wait 5;
    level.ref_12324 setscriptablepartstate("maphint_phone", "on");
  }
}

function flagender() {
  self endon("disconnect");
  level endon("game_ended");
  var_0 = getEnt("bunkerCounterUAV", "targetname");
  self.tracking_obit = 0;

  if(isDefined(var_0)) {
    for(;;) {
      if(self istouching(var_0)) {
        if(!istrue(self.tracking_obit)) {
          self.tracking_obit = 1;
          self.radarstrength = level.ref_13ede;
          self.isradarblocked = 1;
          self.hasradar = 0;
          self.radarshowenemydirection = 0;
          self.radarmode = "normal_radar";
        }
      } else if(istrue(self.tracking_obit)) {
        self.tracking_obit = undefined;
        level notify("uav_update");
      }

      waitframe();
    }

    return;
  }
}

function ref_11ae3(var_0, var_1, var_2, var_3, var_4) {
  thread allowassassinationdamage(level, var_0, var_1, var_2, var_3);
}

function allowassassinationdamage(var_0, var_1, var_2, var_3, var_4) {
  if(var_2 == "on") {
    var_0 setscriptablepartstate("maphint_phone", "off");
    level notify("PhoneAnswered");
    level.ref_12329 = 0;
    return;
  }
}

function vehicles_spawned() {
  wait 2;
  level.vehicleoccupants = getEntArray("KeyPad", "targetname");

  foreach(var_1 in level.vehicleoccupants) {
    thread vehiclespawn_armoredtruck(var_1);
  }

  level.helihint_gotopad[0] = randomintrange(1, 10);
  level.helihint_deposit[0] = scripts\engine\utility::getStruct("Code1", "targetname");
  ref_1313f(level.helihint_deposit[0], level.helihint_gotopad[0]);
  level.helihint_gotopad[1] = level.helihint_gotopad[0];

  while(level.helihint_gotopad[1] == level.helihint_gotopad[0]) {
    level.helihint_gotopad[1] = randomintrange(1, 10);
  }

  level.helihint_deposit[1] = scripts\engine\utility::getStruct("Code2", "targetname");
  ref_1313f(level.helihint_deposit[1], level.helihint_gotopad[1]);
  level.helihint_gotopad[2] = level.helihint_gotopad[0];

  while(level.helihint_gotopad[2] == level.helihint_gotopad[0] || level.helihint_gotopad[2] == level.helihint_gotopad[1]) {
    level.helihint_gotopad[2] = randomintrange(1, 10);
  }

  level.helihint_deposit[2] = scripts\engine\utility::getStruct("Code3", "targetname");
  ref_1313f(level.helihint_deposit[2], level.helihint_gotopad[2]);
  level.helihint_gotopad[3] = level.helihint_gotopad[0];

  while(level.helihint_gotopad[3] == level.helihint_gotopad[0] || level.helihint_gotopad[3] == level.helihint_gotopad[1] || level.helihint_gotopad[3] == level.helihint_gotopad[2]) {
    level.helihint_gotopad[3] = randomintrange(1, 10);
  }

  level.helihint_deposit[3] = scripts\engine\utility::getStruct("Code4", "targetname");
  ref_1313f(level.helihint_deposit[3], level.helihint_gotopad[3]);
  level.helihint_gotopad[4] = level.helihint_gotopad[0];

  while(level.helihint_gotopad[4] == level.helihint_gotopad[0] || level.helihint_gotopad[4] == level.helihint_gotopad[1] || level.helihint_gotopad[4] == level.helihint_gotopad[2] || level.helihint_gotopad[4] == level.helihint_gotopad[3]) {
    level.helihint_gotopad[4] = randomintrange(1, 10);
  }

  level.helihint_deposit[4] = scripts\engine\utility::getStruct("Code5", "targetname");
  ref_1313f(level.helihint_deposit[4], level.helihint_gotopad[4]);
  level.insertingarmorplate = 0;
  var_3 = getEnt("CodePad", "targetname");
  thread player_near_obit(var_3);
  var_4 = getEnt("BunkerPathBlocker", "targetname");
  var_4 disconnectPaths();

  while(level.max_respawn) {
    if(level.insertingarmorplate < 5) {
      level.audio_player_delete_mud_loop = level.helihint_gotopad[level.insertingarmorplate];
      level waittill("CodeKeyPressed");
      continue;
    }

    killfxontag(scripts\engine\utility::getfx("TrenchEnterCode"), var_3, "tag_origin");
    level.max_respawn = 0;
    var_4 hide();
    waitframe();
    var_4 connectpaths();
    playsoundatpos(var_3.origin, "br_keypad_confirm");
    killfxontag(scripts\engine\utility::getfx("TrenchEnterCode"), var_3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 2;
    thread ref_12121(level.door);
  }

  wait 1;
  level.helihint_gotopad[0] = 5;
  level.helihint_gotopad[1] = 3;
  level.helihint_gotopad[2] = 1;
  level.helihint_gotopad[3] = 2;
  level.helihint_gotopad[4] = 5;
  level.insertingarmorplate = 0;
  level.monitor_player_pinging = getEntArray("elevatorDoor", "targetname");

  foreach(var_6 in level.monitor_player_pinging) {
    thread ref_1323d(var_6);
  }

  while(level.ref_12328) {
    if(level.insertingarmorplate < 5) {
      level.audio_player_delete_mud_loop = level.helihint_gotopad[level.insertingarmorplate];
      level waittill("CodeKeyPressed");
      continue;
    }

    level.ref_12328 = 0;
    level.ref_12329 = 1;
    playsoundatpos(var_3.origin, "br_keypad_confirm");
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var_3, "tag_origin");
    level.ref_12327 = scripts\engine\utility::getStruct("phoneHint", "targetname");
    level.ref_12324 = easepower("maphint_phone_mp_m_trench", level.ref_12327.origin);
    waitframe();
    scripts\engine\scriptable::ref_12f5b("maphint_phone", &ref_11ae3);
    thread ref_1232b(level.ref_12327);
    level waittill("PhoneAnswered");
    level.ref_1232c stoploopsound("trench_phone_ring");
    level.ref_1232c delete();
    playsoundatpos(level.ref_12327.origin, "trench_phone_pickup");
    wait 0.5;
    playsoundatpos(level.ref_12327.origin, "dx_bra_rubc_bunker_trench_phone_interact_20");
    wait 4.9;
    playsoundatpos(level.ref_12327.origin, "trench_phone_hangup");
    wait 0.5;
    vehicle_isneutraltoteam();
  }
}

function ref_1232b(var_0) {
  level.ref_1232c = spawn("script_origin", var_0.origin);
  wait 0.05;
  level.ref_1232c playLoopSound("trench_phone_ring");
}

function vehicle_isneutraltoteam() {
  level.monitor_player_pinging[0] playLoopSound("trench_alarm_lp");
  scripts\engine\utility::exploder("teddynaught");
  wait 3;
  level.monitor_player_pinging[1] playSound("trench_door_start");

  foreach(var_1 in level.monitor_player_pinging) {
    thread ref_12124(var_1);
  }

  level.monitor_player_pinging[1] playLoopSound("trench_door_lp");
  wait 2;
  level.monitor_player_pinging[1] playSound("trench_door_stop");
  level.monitor_player_pinging[1] stoploopsound("trench_door_lp");
  var_3 = scripts\engine\utility::getStructArray("bearGun", "targetname");
  var_4 = spawn("script_origin", var_3[0].origin);
  var_4 playSound("weap_dblmg_spinup_npc");
  wait 1;
  scripts\engine\utility::exploder("minigun");
  var_4 playLoopSound("weap_dblmg_spinloop_npc");
  level.clear_my_munition_slot = 0;
  thread spawner_recently_used();
  wait 10;
  level.monitor_player_pinging[0] stoploopsound("trench_alarm_lp");
  level.clear_my_munition_slot = 1;
  scripts\engine\utility::stop_exploder("minigun");
  var_4 playSound("weap_dblmg_spindown_npc");
  var_4 stoploopsound("weap_dblmg_spinloop_npc");
  wait 1;
  scripts\engine\utility::stop_exploder("teddynaught");
  scripts\engine\utility::exploder("teddy_dead");
  playsoundatpos((2604.05, -0.801273, -153), "bunker_exp_trans");
  var_4 stopsounds();
  var_4 delete();
  wait 0.5;

  foreach(var_1 in level.monitor_player_pinging) {
    thread heli_killed(var_1);
  }

  level.monitor_player_pinging[0] playSound("trench_door_start");
  level.monitor_player_pinging[1] playSound("trench_door_stop");
}

function spawner_recently_used() {
  var_0 = scripts\engine\utility::getStructArray("bearGun", "targetname");
  var_1 = getEnt("bunkerHurtTrigger", "targetname");

  while(!level.clear_my_munition_slot) {
    magicbullet("iw8_lm_dblmg_mp", var_0[0].origin, (0, randomintrange(-1000, 1000), randomintrange(-300, 100)));
    wait 0.1;
    magicbullet("iw8_lm_dblmg_mp", var_0[1].origin, (0, randomintrange(-1000, 1000), randomintrange(-300, 100)));
    wait 0.1;

    if(randomint(2)) {
      foreach(var_3 in level.players) {
        if(var_3 istouching(var_1)) {
          var_3 dodamage(4, var_0[0].origin, var_3, var_3, "MOD_RIFLE_BULLET", undefined, "torso_upper");
        }
      }
    }
  }
}

function player_near_obit(var_0) {
  wait 10;

  while(level.max_respawn) {
    playFXOnTag(scripts\engine\utility::getfx("TrenchEnterCode"), var_0, "tag_origin");
    wait 0.5;
    killfxontag(scripts\engine\utility::getfx("TrenchEnterCode"), var_0, "tag_origin");
    waitframe();
    killfxontag(scripts\engine\utility::getfx("TrenchEnterCode"), var_0, "tag_origin");
    wait 0.5;
  }
}

function vehiclespawn_armoredtruck(var_0) {
  var_0 setCanDamage(1);

  while(level.max_respawn || level.ref_12328) {
    var_0 waittill("damage", var_1, var_2, var_3, var_4, var_5, var_6, var_7, var_8, var_9, var_10, var_11, var_12, var_13, var_14);

    if(level.audio_player_delete_mud_loop == int(var_0.script_noteworthy)) {
      level.insertingarmorplate++;
      level notify("CodeKeyPressed");
      continue;
    }

    if(level.helihint_gotopad[0] == int(var_0.script_noteworthy)) {
      level.insertingarmorplate = 1;
      level notify("CodeKeyPressed");
      continue;
    }

    level.insertingarmorplate = 0;
    level notify("CodeKeyPressed");
  }
}

function ref_1323d(var_0) {
  var_0.originalpos = var_0.origin;
  var_1 = scripts\engine\utility::getStruct(var_0.target, "targetname");
  var_0.ref_1212b = var_1.origin;
}

function ref_12124(var_0) {
  var_0 moveTo(var_0.ref_1212b, 2, 1.5, 0);
}

function heli_killed(var_0) {
  var_0 moveTo(var_0.originalpos, 0.5, 0.25, 0);
}

function teamrefundplunder() {
  thread teamrevivefiresalediscount();
  thread teamsassigned();
}

#using_animtree("");

function teamrevivefiresalediscount() {
  level.scr_animtree["bunker_door"] = #animtree;
  level.scr_anim["bunker_door"]["door_open"] = $mp_verdansk_bunkerdoor_open;
  level.scr_animname["bunker_door"]["door_open"] = "mp_verdansk_bunkerdoor_open";
  level.scr_anim["bunker_door"]["door_open_puzzle"] = % mp_verdansk_bunkerdoor_open_puzzle;
  level.scr_animname["bunker_door"]["door_open_puzzle"] = "mp_verdansk_bunkerdoor_open_puzzle";
}

function teamsassigned() {
  level.door = getEnt("bunker_door", "targetname");
  var_0 = getEntArray(level.door.target, "targetname");

  foreach(var_2 in var_0) {
    if(var_2.script_noteworthy == "right_door_clip") {
      level.door.heli_anim = var_2;
      continue;
    }

    if(var_2.script_noteworthy == "left_door_clip") {
      level.door.heli_approach_instruct = var_2;
    }
  }

  level.door.animname = "bunker_door";
  level.door scripts\common\anim::setanimtree();
}

function ref_12121(var_0) {
  var_1 = "door_open";
  var_0 thread scripts\common\anim::anim_single_solo(var_0, var_1);
  var_0 playSound("br_bunker_door_open_01");
  var_2 = getanimlength(level.scr_anim["bunker_door"][var_1]);
  wait 8;
  var_0.heli_anim rotateTo(var_0.heli_anim.angles - (0, 90, 0), 5, 0.2, 0.8);
  var_0.heli_approach_instruct rotateTo(var_0.heli_approach_instruct.angles + (0, 90, 0), 5, 0.2, 0.8);
  var_0 playSound("br_bunker_door_open_02");
  wait var_2 - 8;
  var_0.heli_anim connectpaths();
  var_0.heli_approach_instruct connectpaths();
}

function ref_129f4() {
  wait 3;
  level.onupdatefunc = scripts\engine\utility::getStructArray("exploPoint", "targetname");
  var_0 = 0;

  foreach(var_2 in level.onupdatefunc) {
    level.open_doors[var_0] = scripts\engine\utility::spawn_tag_origin();
    level.open_doors[var_0].origin = var_2.origin;
    level.open_doors[var_0] show();
    var_0++;
  }

  for(;;) {
    wait randomintrange(5, 17);

    if(var_0 > 0) {
      var_4 = randomintrange(0, var_0);
      level.open_doors[var_4] playSound("trench_mortar_expl_trans");
      playFXOnTag(scripts\engine\utility::getfx("TrenchExplosionFX"), level.open_doors[var_4], "tag_origin");
    }
  }
}

function ref_13241() {
  var_0 = getEntArray("fan", "targetname");

  foreach(var_2 in var_0) {
    thread pelletdmgpassed(var_2, randomfloatrange(0.75, 1.25));
  }
}

function pelletdmgpassed(var_0, var_1) {
  for(;;) {
    var_0 rotateroll(360, var_1, 0, 0);
    wait var_1;
  }
}