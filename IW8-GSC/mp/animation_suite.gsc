/***********************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\animation_suite.gsc
***********************************************/

animationsuite() {
  while(!istrue(game["_encstr_A9310C0449DDA97F583FADB0FD01"]))
    waitframe();

  var_0 = getEntArray("_encstr_8111088AE84BCDAFC1B2", "_encstr_B2CE0BA1D0FB19FDC54613D9BF");
  var_1 = gathergroups(var_0);
  setupvfxobjs(var_0);
  setupsfxobjs(var_0);

  foreach(var_3 in var_0) {
    if(scripts\cp_mp\utility\game_utility::islargemap())
      var_3 unmarkkeyframedmover(1);

    if(isDefined(var_3.script_animation_type)) {
      switch (var_3.script_animation_type) {
        case "_encstr_91FC1456B52BABEB09E720B1CF57E0C9829D4D508BF3":
        case "_encstr_920E12220829D2BCE0A8639F68D86E7AF990AD9F":
          var_3 thread animsuite_rotation(var_3.script_animation_type);
          break;
        case "_encstr_9133111D4E0B37DCC658E8D2BDDCFAED9B1BAC":
        case "_encstr_A11E15290BD2F050BC8E53C83596F9378A93F7A9E78ACC":
          var_3 thread animsuite_translation(var_3.script_animation_type);
          break;
      }
    }
  }
}

setupvfxobjs(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && scripts\engine\utility::string_starts_with(var_2.script_noteworthy, "_encstr_8D01059D99E1FA")) {
      var_3 = var_2 scripts\engine\utility::spawn_tag_origin();
      var_3 show();
      var_3 linkTo(var_2);
      waitframe();

      if(!van_stop_vo("_encstr_97A114E291984D3304A54327D532CBD8AA92CE6DE9C0", var_2)) {
        continue;
      }
      if(!van_stop_vo("_encstr_9B1316E28DA9133887613B5F7838F30ECBBABE9D6021AA7C", var_3)) {
        continue;
      }
      thread delayfxcall(scripts\engine\utility::getfx(var_2.script_noteworthy), var_3, "_encstr_A2B40B8E2C3B7DDB274B9D4B37");
    }
  }
}

delayfxcall(var_0, var_1, var_2) {
  wait 5;

  if(!van_stop_vo("_encstr_AA980E32561B0BCB32613416D88D4152", var_1)) {
    return;
  }
  playFXOnTag(var_0, var_1, var_2);
}

setupsfxobjs(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_noteworthy) && scripts\engine\utility::string_starts_with(var_2.script_noteworthy, "_encstr_911805433253E9")) {
      var_2 setModel("_encstr_A2B40B8E2C3B7DDB274B9D4B37");
      var_2 thread scripts\engine\utility::play_loop_sound_on_entity("_encstr_9671180F3856B1930BF64A8048298A5779B0B7FB788E147A7F8F");
    }
  }
}

debug_temp_sphere() {
  for(;;) {
    scripts\mp\utility\debug::drawsphere(self.origin, 32, 0.1, (0, 0, 255));
    wait 0.1;
  }
}

gathergroups(var_0) {
  var_1 = [];
  var_2 = [];

  foreach(var_4 in var_0) {
    if(isDefined(var_4.script_noteworthy) && issubstr(var_4.script_noteworthy, "_encstr_852906B39CBD5D38"))
      var_1 = scripts\engine\utility::array_add(var_1, var_4);
  }

  foreach(var_7 in var_1) {
    if(!isDefined(var_2[var_7.script_noteworthy])) {
      var_2[var_7.script_noteworthy] = [var_7];
      continue;
    }

    var_2[var_7.script_noteworthy] = scripts\engine\utility::array_add(var_2[var_7.script_noteworthy], var_7);
  }

  foreach(var_10 in var_2) {
    var_11 = animsuite_getparentobject(var_10);
    animsuite_linkchildrentoparentobject(var_11, var_10);
  }

  return var_2;
}

animsuite_getparentobject(var_0) {
  foreach(var_2 in var_0) {
    if(isDefined(var_2.script_linkname))
      return var_2;
  }
}

animsuite_linkchildrentoparentobject(var_0, var_1) {
  if(isDefined(var_0) && isDefined(var_1)) {
    foreach(var_3 in var_1) {
      if(var_3 == var_0) {
        continue;
      }
      var_3 linkTo(var_0);
    }
  }
}

animsuite_translation(var_0) {
  if(issubstr(var_0, "_encstr_939A09022BAAEF099820F8"))
    thread animsuite_translation_pingpong();

  if(issubstr(var_0, "_encstr_84B405DE73C6CA"))
    thread animsuite_translation_once();
}

animsuite_translation_pingpong() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (0, 90, 0);
  var_1 = 5;
  var_2 = 0.5;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.script_translation_amount))
    var_0 = self.script_translation_amount;

  if(isDefined(self.script_translation_time))
    var_1 = self.script_translation_time;

  if(isDefined(self.script_audio_parameters)) {
    if(issubstr(self.script_audio_parameters, "_encstr_99AD06D3A5B1538B"))
      var_3 = "_encstr_AFB319D683EB2EEAC2E493BCFAB19DBEB1272C9BB2D7B9D1C2C947";

    if(issubstr(self.script_audio_parameters, "_encstr_B419059BD17BE0"))
      var_4 = "_encstr_82C418F05B27EFF8163AA5CB6F3D20A08FD3C91892CF2628AD10";

    if(issubstr(self.script_audio_parameters, "_encstr_BDAD05B9557A69"))
      var_5 = "_encstr_9671180F3856B1930BF64A8048298A5779B0B7FB788E147A7F8F";
  }

  for(;;) {
    var_6 = self.origin;
    self moveTo(self.origin + var_0, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4))
      thread animsuite_playthreadedsound(var_1[0], var_4);

    wait(var_1[0] + var_2);

    if(!van_stop_vo("_encstr_837921813DA8BDA755D8BB52E63DEB7648AF340991C0450B68D762EAC917E7EDA8E1F9", self)) {
      return;
    }
    if(isDefined(var_3))
      playsoundatpos(self.origin, var_3);

    self moveTo(var_6, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4))
      thread animsuite_playthreadedsound(var_1[0], var_4);

    wait(var_1[0] + var_2);

    if(!van_stop_vo("_encstr_837921813DA8BDA755D8BB52E63DEB7648AF340991C0450B68D762EAC917E7EDA8E1F9", self)) {
      return;
    }
    if(isDefined(var_3))
      playsoundatpos(self.origin, var_3);
  }
}

animsuite_playthreadedsound(var_0, var_1) {
  wait(var_0);

  if(!van_stop_vo("_encstr_A7C11E7B98B3D0DFA32AA868B9AF55E9A0319CD252B960626041AD4BBE2172CE", self)) {
    return;
  }
  playsoundatpos(self.origin, var_1);
}

animsuite_translation_once() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (0, 90, 0);
  var_1 = 5;

  if(isDefined(self.script_translation_amount))
    var_0 = self.script_translation_amount;

  if(isDefined(self.script_translation_time))
    var_1 = length(self.script_translation_time);

  for(;;) {
    self rotateby(var_0, var_1, 0, 0);
    wait(var_1);

    if(!van_stop_vo("_encstr_AB371D167883820BF328BBE7810FE28A750EDD8EDD2BFA4EDE31DBF7B8A8E1", self))
      return;
  }
}

animsuite_rotation(var_0) {
  if(issubstr(var_0, "_encstr_939A09022BAAEF099820F8"))
    thread animsuite_rotation_pingpong();

  if(issubstr(var_0, "_encstr_95BD0B36ED73E896CDD5F6AE6E"))
    thread animsuite_rotation_continuous();
}

animsuite_rotation_pingpong() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (0, 90, 0);
  var_1 = (5, 0, 0);
  var_2 = 0;
  var_3 = undefined;
  var_4 = undefined;
  var_5 = undefined;

  if(isDefined(self.script_rotation_amount))
    var_0 = self.script_rotation_amount;

  if(isDefined(self.script_rotation_speed))
    var_1 = self.script_rotation_speed;

  for(;;) {
    self rotateby(var_0, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4))
      thread animsuite_playthreadedsound(var_1[0] * 0.9, var_4);

    wait(var_1[0] + var_2);

    if(!van_stop_vo("_encstr_83611E93EBC2E1C1153CE3D9A9DAE8A5BA6B1B075309276856976F900DD78A73", self)) {
      return;
    }
    if(isDefined(var_3))
      playsoundatpos(self.origin, var_3);

    self rotateby(var_0 * -1, var_1[0], var_1[1], var_1[2]);

    if(isDefined(var_4))
      thread animsuite_playthreadedsound(var_1[0] * 0.9, var_4);

    wait(var_1[0] + var_2);

    if(!van_stop_vo("_encstr_83611E93EBC2E1C1153CE3D9A9DAE8A5BA6B1B075309276856976F900DD78A73", self)) {
      return;
    }
    if(isDefined(var_3))
      playsoundatpos(self.origin, var_3);
  }
}

animsuite_rotation_continuous() {
  level endon("_encstr_9B1D0BC7932875276230426AA1");
  var_0 = (0, 90, 0);
  var_1 = (5, 0, 0);
  var_2 = 0.5;

  if(isDefined(self.script_rotation_amount))
    var_0 = self.script_rotation_amount;

  if(isDefined(self.script_rotation_speed))
    var_1 = self.script_rotation_speed;

  if(isDefined(self.target)) {
    var_3 = getEnt(self.target, "_encstr_B2CE0BA1D0FB19FDC54613D9BF");

    if(isDefined(var_3) && var_3.classname == "_encstr_AFF5126B8E3BE4E07B3EE0130BC6E841C8C1910C")
      var_3 linkTo(self);
  }

  for(;;) {
    self rotateby(var_0, var_1[0], var_1[1], var_1[2]);
    wait(var_1[0]);

    if(!van_stop_vo("_encstr_8438208E1898BDF97D136B2717B662FC70E30495F0D15BF2D83167137BC00B336220", self))
      return;
  }
}

van_stop_vo(var_0, var_1) {
  if(!isDefined(var_1))
    return 0;

  return 1;
}