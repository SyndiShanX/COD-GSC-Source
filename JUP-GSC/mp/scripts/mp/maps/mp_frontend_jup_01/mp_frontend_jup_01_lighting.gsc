/******************************************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontend_jup_01\mp_frontend_jup_01_lighting.gsc
******************************************************************************/

#using scripts\common\lighting;
#using scripts\common\utility;
#using scripts\engine\math;
#using scripts\engine\trace;
#using scripts\engine\utility;
#namespace mp_frontend_jup_01_lighting;

function main() {}

function function_3d536453ebbe96e0() {
  ceilinglights = getEntArray("gunsmith_ceiling_square_01", "targetname");

  foreach(light in ceilinglights) {
    light.original_intensity = light getlightintensity();
  }

  foreach(light in ceilinglights) {
    light setlightintensity(0);
  }
}

function function_4e390c2c37cff5e() {
  ceilinglights = getEntArray("gunsmith_ceiling_square_01", "targetname");

  foreach(light in ceilinglights) {
    if(isDefined(light.original_intensity)) {
      light setlightintensity(light.original_intensity);
    }
  }
}

function function_d99194cd0b2f101c() {
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  setDvar(@ "hash_f9190cd77b0b2463", 4);
  setDvar(@ "hash_dacffbfd52c2fdc5", 16);
  setDvar(@ "hash_ea4c44a08cd23d5d", 3);
}

function function_53438926fbd080b5() {
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  setDvar(@ "hash_eca4b727b01fd254", 8);
  setDvar(@ "hash_f9190cd77b0b2463", 0);
  setDvar(@ "hash_dacffbfd52c2fdc5", 16);
}

function function_7f5fee0f9a43c6aa() {
  setDvar(@ "hash_5d66c2ef5a9612e0", 0);
  setDvar(@ "hash_eca4b727b01fd254", 8);
  setDvar(@ "hash_f9190cd77b0b2463", 0);
  setDvar(@ "hash_dacffbfd52c2fdc5", 32);
  setDvar(@ "hash_ea4c44a08cd23d5d", 1);
  setDvar(@ "hash_e918bd4613339eeb", 2);
}

function function_b81b35afd5c271cf() {
  ceilinglights = getEntArray("operator_ceiling_light", "targetname");

  foreach(light in ceilinglights) {
    light.original_intensity = light getlightintensity();
  }

  foreach(light in ceilinglights) {
    light setlightintensity(0);
  }
}

function function_92097d6de58d5f2b() {
  ceilinglights = getEntArray("operator_ceiling_light", "targetname");

  foreach(light in ceilinglights) {
    if(isDefined(light.original_intensity)) {
      light setlightintensity(light.original_intensity);
    }
  }
}

function function_5ba05843b262c3d7() {
  setDvar(@ "hash_e918bd4613339eeb", 0);
}

function function_7f5fef0f9a43c8dd() {
  setDvar(@ "hash_e918bd4613339eeb", 2);
}

function function_acf8b8703896231b() {
  setDvar(@ "hash_1dde331a8e0153d8", 16);
}

function function_886baf008b3c1850() {
  setDvar(@ "hash_dab366f405822e6c", 0);
}

function function_41ede176398a67ae() {
  setDvar(@ "hash_dab366f405822e6c", 0.3);
}