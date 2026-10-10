/*********************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\maps\mp_jup_tower\mp_jup_tower_lighting.gsc
*********************************************************************/

#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_tower_lighting;

function main() {
  thread lighting_setup_dvars();
  function_448f852a8710b8ea();
  thread function_5235b83db5ab55c6();
  thread function_68853a568289b2e9();
  thread function_20af2a22bde1086b();
  thread function_ab2d757f0392fef9();
  thread lgt_entityfight_phase1_death();
  thread lgt_entityfight_phase2_death();
  thread function_5750c22e249264ed();
  thread function_f330971a2d808169();
}

function lighting_setup_dvars() {}

function function_e86c2fa07545c6a() {
  flag_wait("lgt_boss_arena_arrive");
  visionsetnaked("mp_jup_tower_entity_00", 2);
}

function function_5235b83db5ab55c6() {
  level waittill("lgt_entity_phase1_spawn");
  thread function_a4e6bf2bf902f2bb();
  visionsetnaked("mp_jup_tower_entity_01", 5);
  setDvar(@ "hash_dab366f405822e6c", 0.8);
  function_36552610035fd32e(0.1, 0.04, 5);
  wait 2;
  visionsetnaked("mp_jup_tower_entity_02", 5);
  wait 5.1;
  thread function_b64b9624f284a07f();
  thread function_654ec5d2324dd96f();
}

function function_68853a568289b2e9() {
  flag_wait("entity_phase_01_complete");
  visionsetnaked("mp_jup_tower_entity_flash", 0.5);
  visionsetnaked("mp_jup_tower_entity_00", 3);
  wait 2;
  function_36552610035fd32e(0.04, 0.1, 5);
}

function function_20af2a22bde1086b() {
  level waittill("lgt_entity_phase2_spawn");
  visionsetnaked("mp_jup_tower_entity_01", 5);
  thread function_a4e6bf2bf902f2bb();
  function_36552610035fd32e(0.1, 0.04, 5);
  wait 5.1;
  visionsetnaked("mp_jup_tower_entity_01", 5);
  wait 5.1;
  thread function_b64b9624f284a07f();
  thread function_654ec5d2324dd96f();
}

function function_ab2d757f0392fef9() {
  flag_wait("entity_defeated");
  visionsetnaked("", 3);
  function_36552610035fd32e(0.04, 0.1, 5);
}

function lgt_entityfight_phase1_death() {
  level waittill("lgt_entityfight_phase1_death");
  thread function_c8ffe0e0ff8966b2();
}

function lgt_entityfight_phase2_death() {
  level waittill("lgt_entityfight_phase2_death");
  thread function_c8ffe0e0ff8966b2();
}

function function_c8ffe0e0ff8966b2() {
  visionsetnaked("mp_jup_tower_entity_flash", 0.1);
  wait 1;
  visionsetnaked("", 3);
}

function function_5750c22e249264ed() {
  level waittill("lgt_entityfight_phase2_death_exposure_1");
  visionsetnaked("mp_jup_tower_entity_death_exposure_1", 0.5);
  level waittill("lgt_entityfight_phase2_death_teal");
  visionsetnaked("mp_jup_tower_entity_death_teal", 0.5);
  level waittill("lgt_entityfight_phase2_death_orange");
  visionsetnaked("mp_jup_tower_entity_death_orange", 0.5);
  level waittill("lgt_entityfight_phase2_death_start_desaturate");
  level waittill("lgt_entityfight_phase2_death_exposure_2");
  visionsetnaked("mp_jup_tower_entity_death_exposure_2", 0.5);
  level waittill("lgt_entityfight_phase2_death_chromatic");
  visionsetnaked("mp_jup_tower_entity_death_chromatic", 1);
  level waittill("lgt_entityfight_phase2_death_end");
  wait 12;
  visionsetnaked("mp_jup_tower_entity_02", 2);
  wait 2;
  visionsetnaked("", 3);
}

function function_448f852a8710b8ea() {
  level.var_840b0efad7cd12bf = getEntArray("light_crystal_obj", "targetname");

  foreach(var_827c2f92b949936 in level.var_840b0efad7cd12bf) {
    var_827c2f92b949936 function_88cd754a904f2c0a();
  }
}

function function_bfd6485208f4b621(params) {
  if(istrue(level.var_4553a0f3520aab66)) {
    return;
  }

  level.var_4553a0f3520aab66 = 1;
  fade_time = 3;

  foreach(var_827c2f92b949936 in level.var_840b0efad7cd12bf) {
    var_827c2f92b949936 thread function_e05a4e827e4d647a(fade_time, 0);
  }
}

function private function_e05a4e827e4d647a(time, endintensity) {
  if(!isDefined(self)) {
    return;
  }

  function_70a9f70afd49dead(time, endintensity);
}

function function_88cd754a904f2c0a() {
  self.og_intensity = self getlightintensity();
  self.og_color = self getlightcolor();
  self.og_radius = self getlightradius();
  self.og_position = self.origin;
  self.og_rotation = self.angles;
}

function function_36552610035fd32e(var_28f8f8b442df4f9e, var_39d209c4a94dfabb, duration) {
  var_753d68ba27e6eddc = var_28f8f8b442df4f9e;
  var_70f0b7676ad5912d = var_753d68ba27e6eddc;
  range = var_39d209c4a94dfabb - var_753d68ba27e6eddc;
  count = int(duration / 0.05);

  if(count > 0) {
    delta = range / count;

    while(count) {
      var_70f0b7676ad5912d = max(var_70f0b7676ad5912d + delta, 0);
      setsuncolorandintensity(var_70f0b7676ad5912d);
      wait 0.05;
      count--;
    }
  }

  setsuncolorandintensity(var_39d209c4a94dfabb);
}

function function_b64b9624f284a07f() {
  if(!isDefined(level.entity_boss)) {
    return;
  }

  level.entity_boss endon("death");
  level endon("game_ended");

  while(isDefined(level.entity_boss)) {
    wait 5;
    visionsetnaked("mp_jup_tower_entity_03", 3);
    wait 5;
    visionsetnaked("mp_jup_tower_entity_04", 3);
    wait 5;
    visionsetnaked("mp_jup_tower_entity_02", 3);
  }
}

function function_5f9fa5db9197d79b() {
  thread function_558b781842a5f957();
  thread function_558b791842a5fb8a();
  thread function_558b7a1842a5fdbd();
  thread function_558b731842a5ee58();
}

function function_a4e6bf2bf902f2bb() {
  entity_light = getscriptablearray("light_entity_spawn", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_start");
  }
}

function function_654ec5d2324dd96f() {
  entity_light = getscriptablearray("light_entity_spawn", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_off");
  }
}

function function_7b292e2041de06e3() {
  entity_light = getscriptablearray("entity_light_01", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_start");
  }
}

function function_558b781842a5f957() {
  entity_light = getscriptablearray("entity_light_01", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_off");
  }
}

function function_7b292f2041de0916() {
  entity_light = getscriptablearray("entity_light_02", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_start");
  }
}

function function_558b791842a5fb8a() {
  entity_light = getscriptablearray("entity_light_02", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_off");
  }
}

function function_7b29302041de0b49() {
  entity_light = getscriptablearray("entity_light_03", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_start");
  }
}

function function_558b7a1842a5fdbd() {
  entity_light = getscriptablearray("entity_light_03", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_off");
  }
}

function function_7b29312041de0d7c() {
  entity_light = getscriptablearray("entity_light_04", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_start");
  }
}

function function_558b731842a5ee58() {
  entity_light = getscriptablearray("entity_light_04", "script_noteworthy");

  foreach(light in entity_light) {
    light setscriptablepartstate("fire_flicker", "fire_flicker_off");
  }
}

function function_f330971a2d808169() {
  level waittill("lgt_entityfight_phase2_death_start_desaturate");
  function_126edb47d21b4d35(3, 2, 0.1);
  wait 0.2;
  function_126edb47d21b4d35(3, 2, 0.2);
  wait 0.3;
  function_126edb47d21b4d35(3, 2, 0.3);
  wait 0.4;
  function_126edb47d21b4d35(3, 2, 0.4);
  wait 0.4;
  function_126edb47d21b4d35(3, 2, 0.5);
  wait 0.4;
  function_126edb47d21b4d35(3, 2, 0.6);
  wait 0.4;
  function_126edb47d21b4d35(3, 2, 0.7);
  wait 0.4;
  function_126edb47d21b4d35(3, 2, 0.8);
  wait 0.4;
  function_126edb47d21b4d35(3, 2, 0.9);
  visionsetnaked("mp_jup_tower_entity_death_exposure_1", 0.3);
  wait 0.4;
  function_126edb47d21b4d35(3, 2, 1);
  level waittill("lgt_entityfight_phase2_death_desaturate_end");
  function_126edb47d21b4d35(3, 2, 0.8);
  wait 0.1;
  function_126edb47d21b4d35(3, 2, 0.6);
  wait 0.1;
  function_126edb47d21b4d35(3, 2, 0.4);
  wait 0.1;
  function_126edb47d21b4d35(3, 2, 0.2);
  wait 0.1;
  function_126edb47d21b4d35(3, 2, 0);
}