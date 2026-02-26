/***********************************************
 * Decompiled by Ate47 and Edited by SyndiShanX
 * Script: hashed\script_71603a58e2da0698.csc
***********************************************/

#using script_18910f59cc847b42;
#using script_1b2f6ef7778cf920;
#using script_30c7fb449869910;
#using script_33128b01aae27d52;
#using script_3314b730521b9666;
#using script_38635d174016f682;
#using script_3b893ec1252cdffd;
#using script_42cbbdcd1e160063;
#using script_4adf64e112e9afec;
#using script_64e5d3ad71ce8140;
#using script_67049b48b589d81;
#using script_6b71c9befed901f2;
#using script_71603a58e2da0698;
#using script_75c3996cce8959f7;
#using script_76abb7986de59601;
#using script_77163d5a569e2071;
#using script_771f5bff431d8d57;
#using scripts\core_common\ai\zombie_vortex;
#using scripts\core_common\array_shared;
#using scripts\core_common\blood;
#using scripts\core_common\callbacks_shared;
#using scripts\core_common\clientfield_shared;
#using scripts\core_common\flag_shared;
#using scripts\core_common\hud_message_shared;
#using scripts\core_common\math_shared;
#using scripts\core_common\serverfield_shared;
#using scripts\core_common\spawner_shared;
#using scripts\core_common\spawning_shared;
#using scripts\core_common\struct;
#using scripts\core_common\system_shared;
#using scripts\core_common\util_shared;
#namespace doa_player;

function init() {
  level.var_46a66896 = doa_overworld::register_clientside();
  clientfield::register("allplayers", "bombDrop", 1, 1, "int", &function_c75159ad, 0, 0);
  clientfield::register("toplayer", "cutscene", 1, 2, "int", &function_769d489, 0, 0);
  clientfield::register("toplayer", "controlBinding", 1, 4, "counter", &function_e7a44fda, 0, 0);
  clientfield::register("toplayer", "goFPS", 1, 1, "counter", &function_f32984d0, 0, 0);
  clientfield::register("world", "doafps", 1, 1, "int", &function_8a19ab89, 0, 0);
  clientfield::register("toplayer", "exitFPS", 1, 1, "counter", &function_43ae94e0, 0, 0);
  clientfield::register("toplayer", "changeCamera", 1, 1, "counter", &changecamera, 0, 0);
  clientfield::register("toplayer", "resetCamera", 1, 1, "counter", &resetcamera, 0, 0);
  clientfield::register("toplayer", "hardResetCamera", 1, 1, "counter", &hardresetcamera, 0, 0);
  clientfield::register("toplayer", "lastStand", 1, 2, "int", &laststand, 0, 0);
  clientfield::register("toplayer", "setCameraDown", 1, 5, "int", &setcameradown, 0, 0);
  clientfield::register("toplayer", "setCameraSide", 1, 2, "int", &setcameraside, 0, 0);
  clientfield::register("allplayers", "flipCamera", 1, 2, "int", &flipcamera, 0, 0);
  clientfield::register("toplayer", "showMap", 1, 1, "int", &showmap, 0, 0);
  clientfield::register("toplayer", "toggleflashlight", 1, 1, "int", &function_4fd00e1f, 0, 0);
  serverfield::register("lstick_input_inc", 1, 2, "int");
  serverfield::register("rstick_input_inc", 1, 2, "int");
  callback::on_localclient_connect(&on_player_connect);
  callback::on_spawned(&on_player_spawned);
  function_32d5e898();
  level thread function_c7ab4997();
}

function private function_c7ab4997(localclientnum) {
  self notify("8869c86eaf915ab");
  self endon("8869c86eaf915ab");

  while(true) {
    result = level waittill(#"updategamerprofile", #"hash_ce3d6cba382b09e", #"hash_5f3b1ae5d64be652");
    namespace_1e25ad94::debugmsg("profileWatch just intercepted notify-->" + result._notify);
    local_player = function_5c10bd79(result.localclientnum);

    if(isDefined(local_player)) {
      local_player namespace_7f5aeb59::function_4d692cc4(result.localclientnum, local_player.var_88a2ff29);
    }
  }
}

function on_player_connect(localclientnum) {
  player = function_27673a7(localclientnum);

  if(!isDefined(player)) {
    return;
  }

  player.var_f5602976 = gettime();
  var_818c564f = function_dac0d84(localclientnum);
  rootmodel = function_5f72e972(#"doa_world");
  uimodel = getuimodel(rootmodel, #"hash_a6a99321ab96e8d");
  setuimodelvalue(uimodel, var_818c564f);
}

function function_32d5e898(localclientnum) {
  if(!isDefined(level.doa.var_b73cc08)) {
    level.doa.var_b73cc08 = spawn(0, (0, 0, 0), "script_model");
    level.doa.var_b73cc08 setModel("tag_origin");
  }

  foreach(player in getlocalplayers()) {
    player namespace_7f5aeb59::function_fcc90081(localclientnum);
  }

  level.doa.var_f65cb6ee = array(0, 0, 0, 0);
}

function function_e7a44fda(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  allowactionslotinput(bwastimejump);
  self thread namespace_7f5aeb59::function_4d692cc4(bwastimejump, self.var_88a2ff29);
}

function on_player_spawned(localclientnum) {
  setsoundcontext("doa_1stperson", "inactive");
  assert(!isDefined(self.doa), "<dev string:x38>");
  self thread namespace_7f5aeb59::function_f3143608(localclientnum);
}

function function_c75159ad(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 0) {
    return;
  }

  var_b2b025b1 = getlocalplayers()[0];

  if(isDefined(var_b2b025b1.doa) && var_b2b025b1.doa.cameramode === 6) {
    forward = anglesToForward(self.angles);
    var_7def0a05 = self.origin + forward * 100;
  } else {
    var_7def0a05 = self.origin;
  }

  origin = var_7def0a05 + (20, 0, 2000);
  bomb = namespace_ec06fe4a::spawnmodel(fieldname, origin, "zombietron_nuke", (0, 0, 0), "player bomb");

  if(!isDefined(bomb)) {
    return;
  }

  bomb.angles = (90, 0, 0);
  bomb moveto(var_7def0a05, 0.3, 0, 0);
  playSound(0, "evt_doa_powerup_nuke_activate", self.origin);
  bomb waittill(#"movedone");
  playSound(fieldname, "evt_doa_powerup_nuke_impact", var_7def0a05);
  playFX(fieldname, level._effect[#"bomb"], var_7def0a05);
  earthquake(fieldname, 1, 0.8, var_7def0a05, 1000);
  physicsexplosionsphere(fieldname, var_7def0a05, 1024, 0, 100);
  bomb delete();
  wait 0.2;
  playFX(fieldname, level._effect[#"nuke_dust"], var_7def0a05);
}

function function_43ae94e0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self.var_88a2ff29 = level.default_mapping;
  playSound(bwastimejump, #"hash_51a1d69295a5b7fe", (0, 0, 0));
  setsoundcontext("doa_1stperson", "inactive");

  if(!isDefined(self.doa)) {
    self thread namespace_7f5aeb59::function_4d692cc4(bwastimejump, self.var_88a2ff29);
    namespace_4dae815d::function_b6e8ef46();
    return;
  }

  self.doa.cameramode = 7;
  var_de738228 = self.doa.var_903d75b1;

  if(isDefined(var_de738228)) {
    var_de738228 = self namespace_ac2a80f5::function_f7736714(bwastimejump, var_de738228);
  }

  lastmode = isDefined(var_de738228) ? var_de738228 : 1;
  level.doa.var_b73cc08.origin = self.origin + (0, 0, 72);
  level.doa.var_b73cc08.angles = self.angles;
  waitframe(1);

  if(isDefined(self.var_ca14ee83)) {
    level.doa.var_b73cc08.angles = self.var_ca14ee83;
  }

  spot = (self.origin[0], self.origin[1], self.origin[2] + namespace_ac2a80f5::function_ccf8a968(lastmode));
  level.doa.var_b73cc08 moveto(spot, 0.15);
  level.doa.var_b73cc08 waittilltimeout(0.16, #"movedone");
  self cameraforcedisablescriptcam(0);
  self.doa.cameramode = lastmode;
  assert(self.doa.cameramode != 6);

  if(getlocalplayers().size > 1) {
    self.doa.cameramode = 4;
  }

  self namespace_ac2a80f5::changecamera(self.doa.cameramode);
  self.topdowncamera = 1;
  self.doa.infps = 0;

  if(isDefined(self.var_1489535e)) {
    killfx(bwastimejump, self.var_1489535e);
    self.var_1489535e = undefined;
  }

  self thread namespace_7f5aeb59::function_4d692cc4(bwastimejump, self.var_88a2ff29);
  namespace_4dae815d::function_b6e8ef46();
}

function function_f32984d0(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self notify("12e09c614cecb5c2");
  self endon("12e09c614cecb5c2");

  while(!isDefined(self.doa)) {
    waitframe(1);
  }

  self.var_88a2ff29 = "default";

  if(self.doa.cameramode === 6) {
    self thread namespace_7f5aeb59::function_4d692cc4(localclientnum, self.var_88a2ff29);
    self thread namespace_6e90e490::function_b5afa57f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    return;
  }

  playSound(localclientnum, #"hash_4716558fb561cab2", (0, 0, 0));
  setsoundcontext("doa_1stperson", "active");

  if(is_true(level.doa.var_318aa67a)) {
    self.doa.cameramode = 6;
    self.topdowncamera = 0;
    self.doa.infps = 1;
    return;
  }

  origin = self.origin;

  if(!isDefined(self.var_45c6f27d)) {
    self.var_45c6f27d = self.origin + (0, 0, 1000);
  }

  if(!isDefined(self.var_ca14ee83)) {
    self.var_ca14ee83 = (75, 0, 0);
  }

  if(localclientnum > 0 && level.localplayers.size > 1) {
    self.var_45c6f27d = level.localplayers[0].var_45c6f27d;
    self.var_ca14ee83 = level.localplayers[0].var_ca14ee83;
  }

  self.doa.cameramode = 7;
  level.doa.var_b73cc08.origin = self.var_45c6f27d;
  level.doa.var_b73cc08.angles = self.var_ca14ee83;
  level.doa.var_b73cc08 moveto(origin + (0, 0, 72), 0.3);
  wait 0.2;

  if(isDefined(self)) {
    playFX(localclientnum, level._effect[#"explode_lg"], origin);
    earthquake(localclientnum, 1, 0.8, origin, 1000);
    playrumbleonposition(localclientnum, "damage_heavy", self.origin);
  }

  wait 0.1;

  if(isDefined(self)) {
    self.doa.cameramode = 6;
    self.topdowncamera = 0;
    self.doa.infps = 1;
    self thread namespace_7f5aeb59::function_4d692cc4(localclientnum, self.var_88a2ff29);
    self thread namespace_6e90e490::function_b5afa57f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump);
    self notify(#"infps");
  }

  namespace_4dae815d::function_b6e8ef46();
}

function function_505038df() {
  foreach(player in getlocalplayers()) {
    if(!isDefined(player)) {
      continue;
    }

    if(is_true(player.doa.infps)) {
      return true;
    }
  }

  return false;
}

function function_8a19ab89(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  namespace_1e25ad94::debugmsg("<dev string:x52>" + bwastimejump);

  if(bwastimejump) {
    if(!isDefined(level.doa.var_d1aae7e4) && isDefined(level.doa.var_72b899ad)) {
      level.doa.var_d1aae7e4 = "fxexp_" + level.doa.var_72b899ad.script_noteworthy + "_FPS";

      namespace_1e25ad94::debugmsg("<dev string:x61>" + level.doa.var_d1aae7e4 + "<dev string:x7a>" + fieldname);

      playradiantexploder(fieldname, level.doa.var_d1aae7e4);
    }

    return;
  }

  var_33a7b9c6 = function_505038df();

  if(!is_true(var_33a7b9c6)) {
    if(isDefined(level.doa.var_d1aae7e4)) {
      stopradiantexploder(fieldname, level.doa.var_d1aae7e4);
      level.doa.var_d1aae7e4 = undefined;
    }
  }
}

function changecamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.doa)) {
    return;
  }

  if(self.doa.cameramode === 6) {
    return;
  }

  self.doa.cameramode = namespace_ac2a80f5::function_1d5dc8d2(bwastimejump, self.doa.cameramode);
  self namespace_ac2a80f5::changecamera(self.doa.cameramode);

  if(self.doa.cameramode >= 0 && self.doa.cameramode <= 4) {
    self.doa.var_903d75b1 = self.doa.cameramode;
  }

  switch (self.doa.cameramode) {
    case 1:
      msg = # "hash_447dc787430ef129";
      break;
    case 0:
      msg = # "hash_7d810006d120ca86";
      break;
    case 2:
      msg = # "hash_61823fb81c973c88";
      break;
    case 3:
      msg = # "hash_604d22d46a737a0b";
      break;
    case 4:
      msg = # "hash_6fca4e61bae022cd";
      break;
  }

  if(isDefined(msg)) {
    self thread message(bwastimejump, msg, 2, 0);
  }
}

function private function_5abfd945(localclientnum, text, var_d9d263a1 = 5) {
  self.doa.var_5f165a77 = 1;
  self hud_message::clearlowermessage(localclientnum);
  self hud_message::setlowermessage(localclientnum, text);
  wait var_d9d263a1;

  if(isDefined(self)) {
    self hud_message::clearlowermessage(localclientnum);
    self.doa.var_5f165a77 = 0;
  }
}

function message(localclientnum, text, var_d9d263a1 = 5, hold = 1) {
  var_e0e4a2bb = 0;

  while(hold && is_true(self.doa.var_5f165a77)) {
    var_e0e4a2bb = 1;
    wait 1;
  }

  if(var_e0e4a2bb) {
    wait 1;
  }

  if(isDefined(self)) {
    self thread function_5abfd945(localclientnum, text, var_d9d263a1);
  }
}

function hardresetcamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.doa)) {
    return;
  }

  namespace_1e25ad94::debugmsg("Calling HARDRESETCAMERA on LocalClient:" + bwastimejump + " Entity: " + self.entnum);

  if(isDefined(self.doa.cameramode) && self.doa.cameramode == 7) {
    return;
  }

  self.doa.var_67c3a8db = undefined;
  self.var_2d592f5b = undefined;
  self.var_45c6f27d = undefined;
  self.doa.var_cffb9201 = isDefined(self.doa.var_903d75b1) ? self.doa.var_903d75b1 : self.doa.var_cffb9201;
  self.doa.var_903d75b1 = undefined;
  self.doa.cameramode = is_true(level.doa.var_318aa67a) ? 6 : 1;

  if(level.doa.world_state == 0 && getlocalplayers().size > 1) {
    if(level.doa.r_splitscreenexpandfull == 1) {
      self.doa.cameramode = 4;
    }
  }

  self namespace_ac2a80f5::changecamera(self.doa.cameramode);
}

function resetcamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self.doa)) {
    return;
  }

  self.doa.var_67c3a8db = undefined;
  self.var_2d592f5b = undefined;
  self.var_45c6f27d = undefined;

  if(!isDefined(self.doa.var_903d75b1)) {
    self.doa.var_903d75b1 = self.doa.var_cffb9201;
  }

  if(isDefined(self.doa.var_903d75b1)) {
    self.doa.cameramode = self namespace_ac2a80f5::function_f7736714(bwastimejump, self.doa.var_903d75b1);
  } else {
    self.doa.cameramode = 1;

    if(getlocalplayers().size > 1) {
      self.doa.cameramode = 4;
    }
  }

  self namespace_ac2a80f5::changecamera(self.doa.cameramode);
}

function setcameradown(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }

  if(level.doa.world_state == 0) {
    assert(isDefined(isDefined(level.doa.var_72b899ad)));
    normalangle = level.doa.var_72b899ad.var_13ea8aea;
    var_1d83376c = level.doa.var_72b899ad.var_46f3a17d;

    if(!isDefined(normalangle) || !isDefined(var_1d83376c)) {
      normalangle = (75, 0, 0);
      var_1d83376c = (75, 180, 0);
    }
  } else {
    normalangle = (75, 0, 0);
    var_1d83376c = (75, 180, 0);
  }

  if(bwastimejump) {
    if(getlocalplayers().size > 1 && self.doa.cameramode == 4) {
      return;
    }

    maxval = 32 - 1;
    curval = bwastimejump / maxval;

    if(self.doa.var_71122e79) {
      curangle = var_1d83376c;
    } else {
      curangle = normalangle;
    }

    var_2797b11f = curangle[0];
    maxpitch = 95;
    var_cc5b2628 = lerpfloat(var_2797b11f, maxpitch, curval);
    angle = (var_cc5b2628, curangle[1], curangle[2]);
    self.doa.var_67c3a8db = angle;
    self namespace_ac2a80f5::function_278f20a3(angle, self.doa.var_f793b3d3);
    return;
  }

  self.doa.var_67c3a8db = undefined;

  if(self.doa.var_71122e79) {
    self namespace_ac2a80f5::function_278f20a3(var_1d83376c, self.doa.var_f793b3d3);
    return;
  }

  self namespace_ac2a80f5::function_278f20a3(normalangle, self.doa.var_f793b3d3);
}

function function_9917e07(localclientnum, value) {
  self notify("345cdae26411cd4f");
  self endon("345cdae26411cd4f");

  while(true) {
    if(!isDefined(self)) {
      return;
    }

    if(isDefined(self.doa)) {
      break;
    }

    waitframe(1);
  }

  if(value) {
    angle = (5, 180, 0);
    self.doa.var_67c3a8db = angle;
    self.doa.var_c544c883 = 100;

    if(level.localplayers.size > 1) {
      namespace_4dae815d::function_e1887b0f(0);
      self namespace_ac2a80f5::changecamera(self.doa.cameramode);
    }

    if(value == 2) {
      self.doa.cameramode = 0;
      self namespace_ac2a80f5::changecamera(self.doa.cameramode);
    }

    if(value == 3) {
      self.doa.cameramode = 1;
      self namespace_ac2a80f5::changecamera(self.doa.cameramode);
    }

    self namespace_ac2a80f5::function_278f20a3(angle, self.doa.var_f793b3d3);
    return;
  }

  if(level.localplayers.size > 1) {
    self.doa.cameramode = 4;
    self namespace_ac2a80f5::changecamera(self.doa.cameramode);
    namespace_4dae815d::function_b6e8ef46();
  }

  if(level.doa.world_state == 0) {
    assert(isDefined(isDefined(level.doa.var_72b899ad)));
    normalangle = level.doa.var_72b899ad.var_13ea8aea;
    var_1d83376c = level.doa.var_72b899ad.var_46f3a17d;
  } else {
    normalangle = (75, 0, 0);
    var_1d83376c = (75, 180, 0);
  }

  if(self.doa.cameramode == 0) {
    self.doa.cameramode = 1;
    self namespace_ac2a80f5::changecamera(self.doa.cameramode);
  }

  self.doa.var_c544c883 = undefined;
  self.doa.var_67c3a8db = undefined;

  if(self.doa.var_71122e79) {
    self namespace_ac2a80f5::function_278f20a3(var_1d83376c, self.doa.var_f793b3d3);
    return;
  }

  self namespace_ac2a80f5::function_278f20a3(normalangle, self.doa.var_f793b3d3);
}

function setcameraside(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  self thread function_9917e07(fieldname, bwastimejump);
}

function laststand(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname != 0) {
    return;
  }

  if(getlocalplayers().size > 1) {
    return;
  }

  if(!isDefined(self) || !isDefined(self.doa)) {
    return;
  }

  if(bwastimejump == 3) {
    self thread blood::function_6072ad24(fieldname);
    return;
  }

  if(self.doa.cameramode !== 7) {
    if(bwastimejump) {
      self.doa.cameramode = 0;

      if(bwastimejump == 2) {
        if(self namespace_ac2a80f5::function_f7736714(fieldname, 3)) {
          self.doa.cameramode = 3;
        } else if(self namespace_ac2a80f5::function_f7736714(fieldname, 2)) {
          self.doa.cameramode = 2;
        }
      }

      if(level.doa.var_938e4f08 === 9 || level.doa.var_938e4f08 === 10 || level.doa.var_938e4f08 === 11 || level.doa.var_938e4f08 === 12 || level.doa.var_938e4f08 === 13 || level.doa.var_938e4f08 === 16) {
        self.doa.cameramode = 0;
      }
    } else if(isDefined(self.doa.var_903d75b1)) {
      self.doa.cameramode = self namespace_ac2a80f5::function_f7736714(fieldname, self.doa.var_903d75b1);
    } else {
      self.doa.cameramode = 1;
    }

    self namespace_ac2a80f5::changecamera(self.doa.cameramode);
  }
}

function showmap(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(fieldname != 0) {
    return;
  }

  if(bwastimejump) {
    if(!level.var_46a66896 doa_overworld::is_open(fieldname)) {
      level.var_46a66896 doa_overworld::open(fieldname);
    }

    return;
  }

  if(level.var_46a66896 doa_overworld::is_open(fieldname)) {
    level.var_46a66896 doa_overworld::close(fieldname);
  }
}

function function_4fd00e1f(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  if(bwastimejump == 1) {
    self playSound(fieldname, #"hash_79a78504d4dbaf3f");

    if(self.doa.cameramode === 6) {
      if(!self hasdobj(fieldname)) {
        return;
      }

      if(!isDefined(self.flashlight_fx)) {
        if(viewmodelhastag(fieldname, "tag_flashlight")) {
          self.flashlight_fx = playviewmodelfx(fieldname, #"hash_679d39e5fd4eae19", "tag_flashlight");
        } else if(viewmodelhastag(fieldname, "tag_camera")) {
          self.flashlight_fx = playviewmodelfx(fieldname, #"hash_679d39e5fd4eae19", "tag_camera");
        } else if(viewmodelhastag(fieldname, "tag_flash")) {
          self.flashlight_fx = playviewmodelfx(fieldname, #"hash_679d39e5fd4eae19", "tag_camera");
        }
      }
    } else {
      self.flashlight_fx = util::playFXOnTag(fieldname, #"hash_679d39e5fd4eae19", self, "tag_eye");
    }

    return;
  }

  if(isDefined(self.flashlight_fx)) {
    self playSound(fieldname, #"hash_13715035b161a0c3");
    stopfx(fieldname, self.flashlight_fx);
    self.flashlight_fx = undefined;
  }
}

function function_769d489(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  level.doa.cutscene = bwastimejump;
  self thread function_65329ef6(bwastimejump, fieldname);
}

function function_65329ef6(id, localclientnum) {
  self notify("69c9e90050c26302");
  self endon("69c9e90050c26302");
  self endon(#"disconnect");

  while(!isDefined(self.doa)) {
    waitframe(1);
  }

  switch (id) {
    case 0:
      if(isDefined(self.doa.var_903d75b1)) {
        self.doa.cameramode = self namespace_ac2a80f5::function_f7736714(localclientnum, self.doa.var_903d75b1);
      } else {
        self.doa.cameramode = 1;

        if(getlocalplayers().size > 1) {
          self.doa.cameramode = 4;
        }
      }

      self namespace_ac2a80f5::changecamera(self.doa.cameramode);
      level notify(#"terminatecutscene");
      break;
    case 1:
      self.doa.cameramode = 7;
      loc = struct::get("island_cutscene_camloc", "targetname");
      level.doa.var_b73cc08.origin = loc.origin;
      level.doa.var_b73cc08.angles = loc.angles;
      break;
    case 2:
      self thread namespace_b7d49cfd::function_8d4cb2b(localclientnum);
      break;
  }
}

function function_7df2149d(localclientnum, orientation) {
  self endon(#"hash_79990404aaa9d9df");
  self notify("25b9b5083684eb1b");
  self endon("25b9b5083684eb1b");

  while(!isDefined(self.doa)) {
    waitframe(1);
  }

  height = namespace_ac2a80f5::function_ccf8a968(self.doa.cameramode);

  if(isDefined(level.doa.var_72b899ad.camera_max_height)) {
    if(height > level.doa.var_72b899ad.camera_max_height) {
      height = level.doa.var_72b899ad.camera_max_height;
    }
  }

  if(level.doa.world_state == 0 && isDefined(level.doa.var_72b899ad)) {
    normalangle = level.doa.var_72b899ad.var_13ea8aea;
    var_1d83376c = level.doa.var_72b899ad.var_46f3a17d;
  } else {
    normalangle = (75, 0, 0);
    var_1d83376c = (75, 180, 0);
  }

  switch (orientation) {
    case 0:
    case 2:
      self.doa.var_71122e79 = 0;
      self namespace_ac2a80f5::function_278f20a3(normalangle, height);
      break;
    case 1:
      self.doa.var_71122e79 = 1;
      self namespace_ac2a80f5::function_278f20a3(var_1d83376c, height);
      break;
  }

  level.var_2d592f5b = level.doa.camera_angles;
  namespace_1e25ad94::debugmsg("+++++++++++++++++++++++ Player " + self.entnum + " camera orientation is: " + (self.doa.var_71122e79 ? "flipped" : "normal"));
}

function flipcamera(localclientnum, oldval, newval, bnewent, binitialsnap, fieldname, bwastimejump) {
  localplayers = getlocalplayers();

  if(isinarray(localplayers, self)) {
    self thread function_7df2149d(fieldname, bwastimejump);
  }

  level.doa.var_f65cb6ee[self getentitynumber()] = bwastimejump == 1;
}