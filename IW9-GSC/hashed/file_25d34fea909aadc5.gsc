/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: hashed\file_25d34fea909aadc5.gsc
***********************************************/

_id_F21AE5A240979E87(_id_A20B2D1A3A8C2F31) {
  self.target = _id_A20B2D1A3A8C2F31;
  _id_6AE3C9A98F0C688A::_id_E4D9CF45F9CB9AE1(::_id_88CD811B63FF5A7B);
  thread _id_6AE3C9A98F0C688A::_id_BE9B253BA2567A0E();
}

_id_88CD811B63FF5A7B(_id_41D8BF229CF29051) {
  _id_DBF8876F4C9B62FC = getscriptablearray("cp_industrial_light_01", "script_noteworthy");
  _id_DBF88A6F4C9B6995 = getscriptablearray("cp_ceiling_fluorescent_light_01", "script_noteworthy");

  if(istrue(_id_41D8BF229CF29051)) {
    foreach(light in _id_DBF8876F4C9B62FC) {
      light setscriptablepartstate("light", "light_on");
      level thread scripts\cp\utility::playsoundatpos_safe(light.origin, "cp_raid_generator_area_lights_on");
    }

    foreach(light in _id_DBF88A6F4C9B6995) {
      light setscriptablepartstate("base", "scripted_on");
      level thread scripts\cp\utility::playsoundatpos_safe(light.origin, "cp_raid_generator_area_lights_on");
    }
  } else {
    foreach(light in _id_DBF8876F4C9B62FC) {
      light setscriptablepartstate("light", "light_off");
      level thread scripts\cp\utility::playsoundatpos_safe(light.origin, "cp_raid_generator_area_lights_off");
    }

    foreach(light in _id_DBF88A6F4C9B6995) {
      light setscriptablepartstate("base", "scripted_off");
      level thread scripts\cp\utility::playsoundatpos_safe(light.origin, "cp_raid_generator_area_lights_off");
    }
  }
}