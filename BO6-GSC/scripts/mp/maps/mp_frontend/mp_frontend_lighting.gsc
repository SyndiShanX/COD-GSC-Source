/****************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\mp\maps\mp_frontend\mp_frontend_lighting.gsc
****************************************************************/

#namespace mp_frontend_lighting;

function main() {}

function gunsmith_turn_off() {
  ceilinglights = getEntArray("gunsmith_ceiling_square_01", #targetname);

  foreach(light in ceilinglights) {
    light.original_intensity = light getlightintensity();
  }

  foreach(light in ceilinglights) {
    light setlightintensity(0);
  }
}

function gunsmith_turn_on() {
  ceilinglights = getEntArray("gunsmith_ceiling_square_01", #targetname);

  foreach(light in ceilinglights) {
    if(isDefined(light.original_intensity)) {
      light setlightintensity(light.original_intensity);
    }
  }
}

function function_2dc1ae88b7014cc9() {
  setDvar(@ "hash_5d66c2ef5a9612e0", 1);
  setDvar(@ "hash_f9190cd77b0b2463", 4);
  setDvar(@ "hash_dacffbfd52c2fdc5", 16);
  setDvar(@ "r_mbvelocityscale", 3);
}

function default_sss() {
  setDvar(@ "hash_5d66c2ef5a9612e0", 0);
  setDvar(@ "hash_eca4b727b01fd254", 8);
  setDvar(@ "hash_f9190cd77b0b2463", 1);
  setDvar(@ "hash_dacffbfd52c2fdc5", 32);
  setDvar(@ "r_mbvelocityscale", 1);
  setDvar(@ "r_ssrfadeinstrength", 2);
}

function function_f1bc4aed1032ba22() {
  ceilinglights = getEntArray("operator_ceiling_light", #targetname);

  foreach(light in ceilinglights) {
    light.original_intensity = light getlightintensity();
  }

  foreach(light in ceilinglights) {
    light setlightintensity(0);
  }
}

function function_a8d269be08ab20c8() {
  ceilinglights = getEntArray("operator_ceiling_light", #targetname);

  foreach(light in ceilinglights) {
    if(isDefined(light.original_intensity)) {
      light setlightintensity(light.original_intensity);
    }
  }
}

function gunsmith_ssr() {
  setDvar(@ "r_ssrfadeinstrength", 0);
}

function default_ssr() {
  setDvar(@ "r_ssrfadeinstrength", 2);
}