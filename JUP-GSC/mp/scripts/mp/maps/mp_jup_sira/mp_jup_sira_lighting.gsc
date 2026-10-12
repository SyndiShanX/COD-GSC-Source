/****************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_jup_sira\mp_jup_sira_lighting.gsc
****************************************************************/

#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_jup_sira_lighting;

function main() {
  thread lighting_setup_dvars();
  function_448f852a8710b8ea();
}

function lighting_setup_dvars() {}

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