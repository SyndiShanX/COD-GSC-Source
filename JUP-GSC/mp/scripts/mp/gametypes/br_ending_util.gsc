/******************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\scripts\mp\gametypes\br_ending_util.gsc
******************************************************/

#using scripts\cp_mp\operator;
#using scripts\cp_mp\weapon;
#using scripts\engine\utility;
#using scripts\mp\teams;
#using scripts\mp\utility\infilexfil;
#namespace br_ending_util;

function create_animpack(anime) {
  pack = spawnStruct();
  pack.ents = [];
  pack.players = [];
  pack.cam = undefined;
  pack.lightingrigs = [];
  pack.anime = anime;
  pack.packs = [];
  return pack;
}

function function_5c32248dfffac064() {
  if(!getdvarint(@ "hash_88262f900b40e276", 0)) {
    return;
  }

  self.var_52738e0a99ed242b = 1;
}

function function_2d4c340dd3908b2d(fov) {
  self.fov = fov;
}

function function_b8f86028bcc64f84(fstop, focusdist, focusspeed, aperturespeed, var_c06551440b16249c) {
  self.fstop = fstop;
  self.focusdist = focusdist;
  self.focusspeed = focusspeed;
  self.aperturespeed = aperturespeed;
  self.var_c06551440b16249c = var_c06551440b16249c;
}

function add_pack_modelanim(ent, animation) {
  level.scr_anim[ent.animname][self.anime] = animation;
  self.ents[self.ents.size] = ent;
}

function add_pack_startfunc(paramarray, func) {
  self.startfunc = func;
  self.paramarray = paramarray;
}

function function_decf1e23d78d0944(paramarray, func) {
  self.endfunc = func;
  self.var_315361abd838fad4 = paramarray;
}

function function_e718ba63d511fcde(paramarray, func) {
  self.playerfunc = func;
  self.var_5ab13b55d7ceff80 = paramarray;
}

function function_6098f3014cd4c598(fadeinlength) {
  self.fadeinlength = fadeinlength;
}

function function_6372afdc0e9ee2dd(fadeoutlength) {
  self.fadeoutlength = fadeoutlength;
}

function add_pack_playeranim(player, var_f8896cb359eab159, var_b1e61449da6ba188) {
  if(!isDefined(player)) {
    return;
  }

  animname = undefined;

  if(!isDefined(player.brexfilanimname)) {
    animname = "player" + player getentitynumber();
    player.animname = animname;
    player.brexfilanimname = animname;
  } else {
    animname = player.brexfilanimname;
  }

  self.players[self.players.size] = player;
  animation = var_f8896cb359eab159;

  if(isDefined(var_b1e61449da6ba188)) {
    if(isDefined(player.operatorcustomization) && isDefined(player.operatorcustomization.gender) && player.operatorcustomization.gender == "female") {
      animation = var_b1e61449da6ba188;
    }
  }

  level.scr_anim[animname][self.anime] = animation;
  level.scr_eventanim[animname][self.anime] = getanimname(animation);
}

function add_pack_camanim(animation, xcamasset) {
  self.cam = 1;
  level.scr_anim["endingCam"][self.anime] = animation;
  self.xcamasset = xcamasset;
}

function add_pack_fx(fxid, origin, angles) {
  self.fx = fxid;
  self.fxorigin = origin;
  self.fxangles = angles;
}

function function_707983b9fdb53c55(rig) {
  self.lightingrigs[self.lightingrigs.size] = rig;
}

#using_animtree("script_model");

function spawn_script_model(modelname, animname, extramodels) {
  model = spawn("script_model", self.origin);
  model setModel(modelname);
  model forcenetfieldhighlod(1);

  if(!isDefined(animname)) {
    animname = modelname;
  }

  model.animname = animname;
  model useanimtree(#animtree);

  if(isDefined(extramodels)) {
    model.linkedents = [];

    foreach(modeltag in extramodels) {
      extra = spawn("script_model", self.origin);
      extra setModel(modeltag[0]);
      extra forcenetfieldhighlod(1);
      extra linkTo(model, modeltag[1], (0, 0, 0), (0, 0, 0));
      model.linkedents[model.linkedents.size] = extra;
    }
  }

  return model;
}

function function_38c7f6bc1deef269(modelname, animname, vehicletype) {
  if(!isDefined(animname)) {
    animname = modelname;
  }

  vehicle = spawnVehicle(modelname, animname, vehicletype, self.origin, self.angles);
  vehicle.animname = animname;
  vehicle.endingvehicle = 1;
  vehicle.vehiclename = vehicletype;
  vehicle setCanDamage(0);

  if(vehicle vehicle_isphysveh()) {
    vehicle function_247ad6a91f6a4ffe(1);
    vehicle vehphys_forcekeyframedmotion();
  } else {
    vehicle notsolid();
  }

  vehicle vehicle_turnengineoff();
  vehicle function_97e11a84480635bc(1);
  return vehicle;
}

function function_c880edba9face762(scenename) {
  origin_name = "exfil_" + scenename + "_light_origin";
  orgstruct = getStruct(origin_name, "targetname");

  if(!isDefined(level.lighting_rigs)) {
    level.lighting_rigs = [];
  }

  level.lighting_rigs[origin_name] = orgstruct;
}

function function_fce988291dbc4649(scenename) {
  if(!isDefined(level.lighting_rigs)) {
    return undefined;
  }

  origin_name = "exfil_" + scenename + "_light_origin";
  return level.lighting_rigs[origin_name];
}

function function_8c2d124dbef4fa60(scenename, linkent, var_f08f74fd62b74b9a) {
  rig = spawnStruct();
  var_5e0676140eecdf2d = "exfil_" + scenename + "_probe";
  light_name = "exfil_" + scenename + "_light";
  probes = getEntArray(var_5e0676140eecdf2d, "script_noteworthy");
  lights = getEntArray(light_name, "targetname");
  orgstruct = undefined;

  if(isDefined(var_f08f74fd62b74b9a)) {
    orgstruct = function_fce988291dbc4649(var_f08f74fd62b74b9a);
  } else {
    orgstruct = function_fce988291dbc4649(scenename);
  }

  if(!isDefined(probes) || !probes.size) {
    return undefined;
  }

  foreach(p in probes) {
    if(!isDefined(p)) {
      return undefined;
    }
  }

  if(!isDefined(lights) || !lights.size) {
    return undefined;
  }

  foreach(l in lights) {
    if(!isDefined(l)) {
      return undefined;
    }
  }

  orgorigin = orgstruct.origin;
  var_3694a4e650566a39 = orgstruct.angles;

  if(!isDefined(var_3694a4e650566a39)) {
    var_3694a4e650566a39 = (0, 0, 0);
  }

  foreach(probe in probes) {
    if(!isDefined(probe.origin_offset) && !isDefined(probe.angles_offset)) {
      var_542e3e93b710380f = probe.origin;
      var_7434c0613f2501b1 = probe.angles;

      if(!isDefined(var_7434c0613f2501b1)) {
        var_7434c0613f2501b1 = (0, 0, 0);
      }

      probe.origin_offset = var_542e3e93b710380f - orgorigin;
      probe.angles_offset = var_7434c0613f2501b1 - var_3694a4e650566a39;
    }
  }

  foreach(light in lights) {
    if(!isDefined(light.origin_offset) && !isDefined(light.angles_offset)) {
      lightorigin = light.origin;
      lightangles = light.angles;

      if(!isDefined(light.angles)) {
        lightangles = (0, 0, 0);
      }

      light.origin_offset = lightorigin - orgorigin;
      light.angles_offset = lightangles - var_3694a4e650566a39;
    }
  }

  rig.probes = probes;
  rig.lights = lights;
  rig.linkent = linkent;
  function_89a2405953b84136(rig, 1);
  return rig;
}

function private function_89a2405953b84136(rig, override_og) {
  if(!isDefined(rig)) {
    return;
  }

  foreach(probe in rig.probes) {
    probe hide();
  }

  foreach(light in rig.lights) {
    if(override_og && !isDefined(light.original_intensity)) {
      light.original_intensity = light getlightintensity();
    }

    light setlightintensity(0);
  }
}

function add_pack_characteranim(modelname, extramodels, animation, animstr, animnameoverride) {
  model = spawn("script_model", self.origin);
  model setModel(modelname);
  model forcenetfieldhighlod(1);
  model useanimtree(#animtree);

  if(isDefined(animnameoverride)) {
    animname = animnameoverride;
  } else {
    animname = modelname;
  }

  model.animname = animname;
  level.scr_anim[model.animname]["br_ending"] = animation;

  if(isDefined(animstr)) {
    if(isDefined(extramodels)) {
      model.linkedents = [];

      foreach(modeltag in extramodels) {
        extra = spawn("script_model", self.origin);
        extra setModel(modeltag[0]);
        extra forcenetfieldhighlod(1);
        extra linkTo(model, modeltag[1], (0, 0, 0), (0, 0, 0));
        model.linkedents[model.linkedents.size] = extra;
      }
    }
  }

  self.pack.models[self.pack.models.size] = model;
  return model;
}

function allplayers_setphysicaldof(fstop, focusdist, focusspeed, aperturespeed, var_c06551440b16249c) {
  if(!isDefined(focusspeed)) {
    focusspeed = 100;
  }

  if(!isDefined(aperturespeed)) {
    aperturespeed = 100;
  }

  foreach(player in level.players) {
    if(!isDefined(player.scriptedphysicaldofenabled)) {
      player.scriptedphysicaldofenabled = 1;
      player enablephysicaldepthoffieldscripting();
    }

    if(isDefined(var_c06551440b16249c)) {
      player setphysicaldepthoffield(fstop, focusdist, focusspeed, aperturespeed, var_c06551440b16249c);
      continue;
    }

    if(isDefined(aperturespeed)) {
      player setphysicaldepthoffield(fstop, focusdist, focusspeed, aperturespeed);
      continue;
    }

    if(isDefined(focusspeed)) {
      player setphysicaldepthoffield(fstop, focusdist, focusspeed);
      continue;
    }

    player setphysicaldepthoffield(fstop, focusdist);
  }
}

function allplayers_setfov(fov) {
  foreach(player in level.players) {
    player setclientdvar(@ "cg_fov", fov);
    player setclientdvar(@ "hash_71c6c0b8428e44a7", 1);
  }
}

function function_cf47ab3f9defe35b() {
  foreach(player in level.players) {
    player setclientdvar(@ "cg_fov", 65);
    player setclientdvar(@ "hash_86bf34d5f48fa435", 65);
    player setclientdvar(@ "hash_71c6c0b8428e44a7", 0);
  }
}

function allplayers_clearphysicaldof() {
  foreach(player in level.players) {
    if(isDefined(player.scriptedphysicaldofenabled)) {
      player.scriptedphysicaldofenabled = undefined;
      player disablephysicaldepthoffieldscripting();
    }
  }
}

function chopperexfil_set_brcircle() {
  if(!isDefined(level.br_circle)) {
    return;
  }

  if(!isDefined(level.br_circle.dangercircleent)) {
    return;
  }

  level.br_circle.dangercircleent brcirclemoveTo(self.origin[0], self.origin[1], 9000, 0.05);
}

function create_disconnectplayer(animstruct) {
  tempplayer = spawn("script_model", self.origin);
  tempplayer setModel("tag_origin");
  tempplayer forcenetfieldhighlod(1);
  tempplayer.isdisconnectplayer = 1;
  tempplayer.brexfilanimname = "player0";
  tempplayer.origin = animstruct.origin;
  tempplayer.angles = animstruct.angles;
  tempplayer create_player_rig(tempplayer.brexfilanimname, "viewhands_base_iw8", animstruct);

  if(getdvarint(@ "hash_bc95d8892007ebfd", 1)) {
    tempplayer function_50962e9f971266e(tempplayer.brexfilanimname, animstruct.origin);
  }

  tempplayer linkTo(tempplayer.player_rig, "tag_player", (0, 0, 0), (0, 0, 0));
  level thread ending_player_disconnect_thread(tempplayer, 1);
  animstruct.winners[0] = tempplayer;
}

function ending_player_disconnect_thread(player, skipwaittill) {
  rig = player.player_rig;
  wasplayer = isPlayer(player);

  if(!isDefined(skipwaittill)) {
    player waittill("disconnect");
  } else {
    wait 0.1;
  }

  if(!isDefined(rig)) {
    return;
  }

  if(getdvarint(@ "hash_bc95d8892007ebfd", 1) && isDefined(rig.avatar)) {
    rig.avatar.playerexists = undefined;
    rig notify("update_avatar_visibility");
    return;
  }

  playFXOnTag(getfx("player_disconnect"), rig, "tag_player");
}

function create_cam() {
  model = spawn("script_model", self.origin);
  model setModel("tag_origin");
  model forcenetfieldhighlod(1);
  model useanimtree(#animtree);
  model.animname = "endingCam";
  return model;
}

function create_player_rig(animname, rig_model, animstruct, var_40a4287d8d2e7ef9) {
  self.animname = animname;
  origin = animstruct.origin;

  if(!isDefined(origin)) {
    origin = (0, 0, 0);
  }

  player_rig = spawn("script_model", origin);
  player_rig.player = self;
  self.player_rig = player_rig;
  self.player_rig setModel(rig_model);
  self.player_rig hide();
  self.player_rig.animname = animname;
  self.player_rig useanimtree(#animtree);
  self.player_rig.winindex = self.winindex;
  self.player_rig forcenetfieldhighlod(1);
  self.player_rig.cinematic_motion_override = &scripts\mp\utility\infilexfil::handlecinematicmotionnotetrack;
  self.player_rig.dof_func = &scripts\mp\utility\infilexfil::handledofnotetrack;

  if(!isDefined(animstruct.player_rigs)) {
    animstruct.player_rigs = [];
  }

  if(isPlayer(self)) {
    self playerlinktodelta(self.player_rig, "tag_player", 1, 0, 0, 0, 0, 1);
    println("<dev string:x1c>" + self.name + "<dev string:x49>" + animname + "<dev string:x59>" + isDefined(self.player_rig));
    animstruct.player_rigs[animstruct.player_rigs.size] = self.player_rig;
    self.player_rig.playernum = self getentitynumber();
  } else {
    println("<dev string:x64>" + animname + "<dev string:x59>" + isDefined(self.player_rig));
    self.player_rig.winindex = 0;
    self.player_rig.playernum = 0;
  }

  self notify("rig_created");
}

function function_50962e9f971266e(animname, origin) {
  assert(isDefined(self.player_rig));
  bodymodelname = "";
  headmodelname = "";
  gender = "";

  if(isPlayer(self) && isDefined(self.operatorcustomization)) {
    bodymodelname = self.operatorcustomization.body;
    headmodelname = self.operatorcustomization.head;
    gender = self.operatorcustomization.gender;
  } else {
    operatorskins = ["milsim_western_a", "milsim_western_b", "milsim_western_c", "milsim_western_d", "milsim_eastern_a", "milsim_eastern_b", "milsim_eastern_c", "milsim_eastern_d"];
    operatorskin = array_random(operatorskins);
    bodymodelname = scripts\cp_mp\operator::function_8eba78e65f4be793(operatorskin);
    headmodelname = scripts\cp_mp\operator::function_223061772e2a61b9(operatorskin);
    gender = scripts\mp\teams::getoperatorgender(operatorskin);
  }

  avatar = spawn("script_model", origin);
  avatar setModel("fullbody_usmc_ar_br_infil");
  avatar function_dd6d30b9ec87c1b3(bodymodelname, headmodelname, "iw9_avatar_scriptable_mp");
  avatar.operatorcustomization = spawnStruct();
  avatar.operatorcustomization.gender = gender;
  avatar hide();
  avatar.animname = animname;
  avatar.winindex = self.winindex;
  avatar forcenetfieldhighlod(1);
  weaponobj = scripts\cp_mp\weapon::buildweapon("iw9_ar_mike4", [], "none", "none");
  weaponent = spawn("script_weapon", origin, 0, 0, weaponobj);
  weaponent hide();
  weaponent forcenetfieldhighlod(1);
  weaponent linkTo(avatar, "j_gun", (0, 0, 0), (0, 0, 0));
  avatar.weaponent = weaponent;
  avatar.playerexists = 1;
  avatar.forcehide = 0;
  self.player_rig.avatar = avatar;
  self.player_rig thread function_2839481298d2e5f4();
}

function function_2839481298d2e5f4() {
  avatar = self.avatar;
  player = self.player;

  if(isPlayer(player)) {
    avatar.playerexists = 1;
  }

  avatar.forcehide = 0;
  self endon("death");

  while(true) {
    self waittill("update_avatar_visibility");

    if(!isDefined(avatar)) {
      return;
    }

    shouldshow = !istrue(avatar.playerexists) && !istrue(avatar.forcehide);

    if(shouldshow) {
      avatar show();

      if(isDefined(avatar.weaponent) && !istrue(avatar.forcehideweapons)) {
        avatar.weaponent show();
      }

      continue;
    }

    avatar hide();

    if(isDefined(avatar.weaponent)) {
      avatar.weaponent hide();
    }
  }
}

function function_e874fd3a9c016379(shouldforcehide, var_cbaf46af6f07196) {
  if(isDefined(self.avatar)) {
    self.avatar.forcehide = shouldforcehide;
    self.avatar.forcehideweapons = var_cbaf46af6f07196;
    self notify("update_avatar_visibility");
  }
}

function remove_player_rig() {
  if(isDefined(self)) {
    println("<dev string:xa7>" + self.name + "<dev string:x49>" + self.animname + "<dev string:x59>" + isDefined(self.player_rig));
    self unlink();
  }

  if(isDefined(self.player_rig)) {
    if(isDefined(self.player_rig.avatar)) {
      if(isDefined(self.player_rig.avatar.weaponent)) {
        self.player_rig.avatar.weaponent delete();
      }

      self.player_rig.avatar delete();
    }

    self.player_rig delete();
  }
}

function get_center_of_array(array) {
  center = (0, 0, 0);

  for(i = 0; i < array.size; i++) {
    center = (center[0] + array[i].origin[0], center[1] + array[i].origin[1], center[2] + array[i].origin[2]);
  }

  if(array.size != 0) {
    return (center[0] / array.size, center[1] / array.size, center[2] / array.size);
  }

  return undefined;
}

function function_3f005b301ec7f15b(testarray, animref, animpct, originoffset, radius, height, var_d4364a524e8a2bcd) {
  newstruct = spawnStruct();
  newstruct.animref = animref;
  newstruct.animpct = animpct;
  newstruct.originoffset = originoffset;
  newstruct.cylinderradius = radius;
  newstruct.cylinderheight = height;
  newstruct.var_d4364a524e8a2bcd = var_d4364a524e8a2bcd;
  testarray[testarray.size] = newstruct;
  return testarray;
}

function function_f317a6f0ae25e3d4(testarray, modelname, animref, animpct, originoffset, radius, var_d4364a524e8a2bcd) {
  newstruct = spawnStruct();
  newstruct.modelname = modelname;
  newstruct.animref = animref;
  newstruct.animpct = animpct;
  newstruct.originoffset = originoffset;
  newstruct.sphereradius = radius;
  newstruct.var_d4364a524e8a2bcd = var_d4364a524e8a2bcd;
  testarray[testarray.size] = newstruct;
  return testarray;
}

function function_19ae50e23fe0625a(testarray, modelname, animref, originoffset, radius, numsegments, var_d4364a524e8a2bcd) {
  newstruct = spawnStruct();
  newstruct.modelname = modelname;
  newstruct.animref = animref;
  newstruct.originoffset = originoffset;
  newstruct.sphereradius = radius;
  newstruct.numsegments = numsegments;
  newstruct.var_d4364a524e8a2bcd = var_d4364a524e8a2bcd;
  testarray[testarray.size] = newstruct;
  return testarray;
}

function function_c300d34e34164b6d(fadedowntime, var_95a318d022e623a7, var_1bb7594c18d17443) {
  overlay = newhudelem();
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.sort = -1;
  overlay setshowinrealism(1);

  if(isDefined(fadedowntime) && fadedowntime > 0) {
    overlay.alpha = 0;
    overlay fadeovertime(fadedowntime);
    overlay.alpha = 1;
    wait fadedowntime;
  } else {
    overlay.alpha = 1;
  }

  if(isDefined(var_95a318d022e623a7) && var_95a318d022e623a7 > 0) {
    wait var_95a318d022e623a7;
  }

  if(isDefined(var_1bb7594c18d17443) && var_1bb7594c18d17443 > 0) {
    overlay.alpha = 1;
    overlay fadeovertime(var_1bb7594c18d17443);
    overlay.alpha = 0;
    wait var_1bb7594c18d17443;
  } else {
    overlay.alpha = 0;
  }

  overlay destroy();
}

function function_3681a4700f5bb7c1(fadedowntime, var_1bb7594c18d17443, holdnotify) {
  overlay = newhudelem();
  overlay.x = 0;
  overlay.y = 0;
  overlay setshader("black", 640, 480);
  overlay.alignx = "left";
  overlay.aligny = "top";
  overlay.horzalign = "fullscreen";
  overlay.vertalign = "fullscreen";
  overlay.sort = -1;
  overlay setshowinrealism(1);

  if(isDefined(fadedowntime) && fadedowntime > 0) {
    overlay.alpha = 0;
    overlay fadeovertime(fadedowntime);
    overlay.alpha = 1;
    wait fadedowntime;
  } else {
    overlay.alpha = 1;
  }

  if(isDefined(holdnotify)) {
    level waittill(holdnotify);
  }

  if(isDefined(var_1bb7594c18d17443) && var_1bb7594c18d17443 > 0) {
    overlay.alpha = 1;
    overlay fadeovertime(var_1bb7594c18d17443);
    overlay.alpha = 0;
    wait var_1bb7594c18d17443;
  } else {
    overlay.alpha = 0;
  }

  overlay destroy();
}