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
    level waittill("connected", var0);
    thread flagender();
  }
}

function ref_1313f(var0, var1) {
  switch (var1) {
    case 1:
      var2 = getEnt("Num1", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    case 2:
      var2 = getEnt("Num2", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    case 3:
      var2 = getEnt("Num3", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    case 4:
      var2 = getEnt("Num4", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    case 5:
      var2 = getEnt("Num5", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    case 6:
      var2 = getEnt("Num6", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    case 7:
      var2 = getEnt("Num7", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    case 8:
      var2 = getEnt("Num8", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    case 9:
      var2 = getEnt("Num9", "targetname");
      var2.origin = var0.origin;
      var2.angles = var0.angles;
      break;
    default:
      break;
  }
}

function ref_13d1d() {
  wait 5;
  var0 = getEnt("BunkerPathBlocker", "targetname");
  var0 hide();
  var0 connectpaths();
  ref_12121(level.door);
  level.monitor_player_pinging = getEntArray("elevatorDoor", "targetname");

  foreach(var2 in level.monitor_player_pinging) {
    thread ref_1323d(var2);
  }

  var4 = scripts\engine\utility::getStruct("phoneHint", "targetname");
  level.ref_12324 = easepower("maphint_phone_mp_m_trench", var4.origin);
  waitframe();
  scripts\engine\scriptable::ref_12f5b("maphint_phone", &ref_11ae3);

  for(;;) {
    level.ref_12329 = 1;
    thread ref_1232b(var4);
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
  var0 = getEnt("bunkerCounterUAV", "targetname");
  self.tracking_obit = 0;

  if(isDefined(var0)) {
    for(;;) {
      if(self istouching(var0)) {
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

function ref_11ae3(var0, var1, var2, var3, var4) {
  thread allowassassinationdamage(level, var0, var1, var2, var3);
}

function allowassassinationdamage(var0, var1, var2, var3, var4) {
  if(var2 == "on") {
    var0 setscriptablepartstate("maphint_phone", "off");
    level notify("PhoneAnswered");
    level.ref_12329 = 0;
    return;
  }
}

function vehicles_spawned() {
  wait 2;
  level.vehicleoccupants = getEntArray("KeyPad", "targetname");

  foreach(var1 in level.vehicleoccupants) {
    thread vehiclespawn_armoredtruck(var1);
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
  var3 = getEnt("CodePad", "targetname");
  thread player_near_obit(var3);
  var4 = getEnt("BunkerPathBlocker", "targetname");
  var4 disconnectPaths();

  while(level.max_respawn) {
    if(level.insertingarmorplate < 5) {
      level.audio_player_delete_mud_loop = level.helihint_gotopad[level.insertingarmorplate];
      level waittill("CodeKeyPressed");
      continue;
    }

    killfxontag(scripts\engine\utility::getfx("TrenchEnterCode"), var3, "tag_origin");
    level.max_respawn = 0;
    var4 hide();
    waitframe();
    var4 connectpaths();
    playsoundatpos(var3.origin, "br_keypad_confirm");
    killfxontag(scripts\engine\utility::getfx("TrenchEnterCode"), var3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
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

  foreach(var6 in level.monitor_player_pinging) {
    thread ref_1323d(var6);
  }

  while(level.ref_12328) {
    if(level.insertingarmorplate < 5) {
      level.audio_player_delete_mud_loop = level.helihint_gotopad[level.insertingarmorplate];
      level waittill("CodeKeyPressed");
      continue;
    }

    level.ref_12328 = 0;
    level.ref_12329 = 1;
    playsoundatpos(var3.origin, "br_keypad_confirm");
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    killfxontag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
    wait 0.25;
    playFXOnTag(scripts\engine\utility::getfx("TrenchCorrectCode"), var3, "tag_origin");
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

function ref_1232b(var0) {
  level.ref_1232c = spawn("script_origin", var0.origin);
  wait 0.05;
  level.ref_1232c playLoopSound("trench_phone_ring");
}

function vehicle_isneutraltoteam() {
  level.monitor_player_pinging[0] playLoopSound("trench_alarm_lp");
  scripts\engine\utility::exploder("teddynaught");
  wait 3;
  level.monitor_player_pinging[1] playSound("trench_door_start");

  foreach(var1 in level.monitor_player_pinging) {
    thread ref_12124(var1);
  }

  level.monitor_player_pinging[1] playLoopSound("trench_door_lp");
  wait 2;
  level.monitor_player_pinging[1] playSound("trench_door_stop");
  level.monitor_player_pinging[1] stoploopsound("trench_door_lp");
  var3 = scripts\engine\utility::getStructArray("bearGun", "targetname");
  var4 = spawn("script_origin", var3[0].origin);
  var4 playSound("weap_dblmg_spinup_npc");
  wait 1;
  scripts\engine\utility::exploder("minigun");
  var4 playLoopSound("weap_dblmg_spinloop_npc");
  level.clear_my_munition_slot = 0;
  thread spawner_recently_used();
  wait 10;
  level.monitor_player_pinging[0] stoploopsound("trench_alarm_lp");
  level.clear_my_munition_slot = 1;
  scripts\engine\utility::stop_exploder("minigun");
  var4 playSound("weap_dblmg_spindown_npc");
  var4 stoploopsound("weap_dblmg_spinloop_npc");
  wait 1;
  scripts\engine\utility::stop_exploder("teddynaught");
  scripts\engine\utility::exploder("teddy_dead");
  playsoundatpos((2604.05, -0.801273, -153), "bunker_exp_trans");
  var4 stopsounds();
  var4 delete();
  wait 0.5;

  foreach(var1 in level.monitor_player_pinging) {
    thread heli_killed(var1);
  }

  level.monitor_player_pinging[0] playSound("trench_door_start");
  level.monitor_player_pinging[1] playSound("trench_door_stop");
}

function spawner_recently_used() {
  var0 = scripts\engine\utility::getStructArray("bearGun", "targetname");
  var1 = getEnt("bunkerHurtTrigger", "targetname");

  while(!level.clear_my_munition_slot) {
    magicbullet("iw8_lm_dblmg_mp", var0[0].origin, (0, randomintrange(-1000, 1000), randomintrange(-300, 100)));
    wait 0.1;
    magicbullet("iw8_lm_dblmg_mp", var0[1].origin, (0, randomintrange(-1000, 1000), randomintrange(-300, 100)));
    wait 0.1;

    if(randomint(2)) {
      foreach(var3 in level.players) {
        if(var3 istouching(var1)) {
          var3 dodamage(4, var0[0].origin, var3, var3, "MOD_RIFLE_BULLET", undefined, "torso_upper");
        }
      }
    }
  }
}

function player_near_obit(var0) {
  wait 10;

  while(level.max_respawn) {
    playFXOnTag(scripts\engine\utility::getfx("TrenchEnterCode"), var0, "tag_origin");
    wait 0.5;
    killfxontag(scripts\engine\utility::getfx("TrenchEnterCode"), var0, "tag_origin");
    waitframe();
    killfxontag(scripts\engine\utility::getfx("TrenchEnterCode"), var0, "tag_origin");
    wait 0.5;
  }
}

function vehiclespawn_armoredtruck(var0) {
  var0 setCanDamage(1);

  while(level.max_respawn || level.ref_12328) {
    var0 waittill("damage", var1, var2, var3, var4, var5, var6, var7, var8, var9, var10, var11, var12, var13, var14);

    if(level.audio_player_delete_mud_loop == int(var0.script_noteworthy)) {
      level.insertingarmorplate++;
      level notify("CodeKeyPressed");
      continue;
    }

    if(level.helihint_gotopad[0] == int(var0.script_noteworthy)) {
      level.insertingarmorplate = 1;
      level notify("CodeKeyPressed");
      continue;
    }

    level.insertingarmorplate = 0;
    level notify("CodeKeyPressed");
  }
}

function ref_1323d(var0) {
  var0.originalpos = var0.origin;
  var1 = scripts\engine\utility::getStruct(var0.target, "targetname");
  var0.ref_1212b = var1.origin;
}

function ref_12124(var0) {
  var0 moveTo(var0.ref_1212b, 2, 1.5, 0);
}

function heli_killed(var0) {
  var0 moveTo(var0.originalpos, 0.5, 0.25, 0);
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
  var0 = getEntArray(level.door.target, "targetname");

  foreach(var2 in var0) {
    if(var2.script_noteworthy == "right_door_clip") {
      level.door.heli_anim = var2;
      continue;
    }

    if(var2.script_noteworthy == "left_door_clip") {
      level.door.heli_approach_instruct = var2;
    }
  }

  level.door.animname = "bunker_door";
  level.door scripts\common\anim::setanimtree();
}

function ref_12121(var0) {
  var1 = "door_open";
  var0 thread scripts\common\anim::anim_single_solo(var0, var1);
  var0 playSound("br_bunker_door_open_01");
  var2 = getanimlength(level.scr_anim["bunker_door"][var1]);
  wait 8;
  var0.heli_anim rotateTo(var0.heli_anim.angles - (0, 90, 0), 5, 0.2, 0.8);
  var0.heli_approach_instruct rotateTo(var0.heli_approach_instruct.angles + (0, 90, 0), 5, 0.2, 0.8);
  var0 playSound("br_bunker_door_open_02");
  wait var2 - 8;
  var0.heli_anim connectpaths();
  var0.heli_approach_instruct connectpaths();
}

function ref_129f4() {
  wait 3;
  level.onupdatefunc = scripts\engine\utility::getStructArray("exploPoint", "targetname");
  var0 = 0;

  foreach(var2 in level.onupdatefunc) {
    level.open_doors[var0] = scripts\engine\utility::spawn_tag_origin();
    level.open_doors[var0].origin = var2.origin;
    level.open_doors[var0] show();
    var0++;
  }

  for(;;) {
    wait randomintrange(5, 17);

    if(var0 > 0) {
      var4 = randomintrange(0, var0);
      level.open_doors[var4] playSound("trench_mortar_expl_trans");
      playFXOnTag(scripts\engine\utility::getfx("TrenchExplosionFX"), level.open_doors[var4], "tag_origin");
    }
  }
}

function ref_13241() {
  var0 = getEntArray("fan", "targetname");

  foreach(var2 in var0) {
    thread pelletdmgpassed(var2, randomfloatrange(0.75, 1.25));
  }
}

function pelletdmgpassed(var0, var1) {
  for(;;) {
    var0 rotateroll(360, var1, 0, 0);
    wait var1;
  }
}