/*************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: mp\hashed\script_6ced65faef83c9ce.gsc
*************************************************/

#using scripts\common\notetrack;
#using scripts\cp_mp\utility\player_utility;
#using scripts\engine\utility;
#using scripts\mp\gamelogic;
#namespace namespace_ba19537f431c9855;

function create_animpack(anime) {
  pack = spawnStruct();
  pack.ents = [];
  pack.staticents = [];
  pack.anime = anime;
  pack.packs = [];
  return pack;
}

function function_2d4c340dd3908b2d(fov) {
  self.fov = fov;
}

function function_b8f86028bcc64f84(fstop, focusdist, focusspeed, aperturespeed, focalpoint) {
  self.fstop = fstop;
  self.focusdist = focusdist;
  self.focusspeed = focusspeed;
  self.aperturespeed = aperturespeed;
  self.focalpoint = focalpoint;
}

function add_pack_modelanim(ent, animation) {
  level.scr_anim[ent.animname][self.anime] = animation;
  self.ents[self.ents.size] = ent;
}

function function_a44bdab6357b7210(ent) {
  self.staticents[self.staticents.size] = ent;
}

function add_pack_startfunc(paramarray, func) {
  self.startfunc = func;
  self.paramarray = paramarray;
}

function function_decf1e23d78d0944(paramarray, func) {
  self.endfunc = func;
  self.var_315361abd838fad4 = paramarray;
}

function add_pack_fx(fxid, origin, angles) {
  self.fx = fxid;
  self.fxorigin = origin;
  self.fxangles = angles;
}

function function_d4561ab1ba4f5de9(ent, tag, animation, xcamasset) {
  assert(!isDefined(self.camerainfo));
  self.camerainfo = spawnStruct();
  self.camerainfo.ent = ent;
  self.camerainfo.tag = tag;

  if(isDefined(xcamasset)) {
    self.camerainfo.xcamasset = xcamasset;
    xcamlength = getxcamlength(xcamasset);
    xcamlength -= 0.033;
    xcamlength -= mod(xcamlength, 0.05);
    self.camerainfo.xcamlength = xcamlength;
    return;
  }

  self.camerainfo.animlength = getanimlength(animation);
}

function private function_19ea8f6d547dc8bc(player) {
  assert(isDefined(self.camerainfo));
  cameraent = self.camerainfo.ent;
  cameratag = self.camerainfo.tag;
  return [cameraent, cameratag];
}

function private uses_xcam() {
  assert(isDefined(self.camerainfo));
  return isDefined(self.camerainfo.xcamasset);
}

function private function_bda88f27a0337eaa(animstruct, player, var_e45f1cd8436c9aa9) {
  [cameraent, cameratag] = function_19ea8f6d547dc8bc(player);

  if(uses_xcam()) {
    if(!istrue(var_e45f1cd8436c9aa9)) {
      player cameraunlink();
      player playxcam(self.camerainfo.xcamasset, 0, animstruct.structorigin, animstruct.var_f7c301a9de8d90f4);
    }

    return;
  }

  player stopxcam();
  player cameralinkTo(cameraent, cameratag, 1, 1);
}

function private function_78dfe475a5d4f843(player) {
  [cameraent, cameratag] = function_19ea8f6d547dc8bc(player);
  cameraorigin = cameraent gettagorigin(cameratag);
  cameraangles = cameraent gettagangles(cameratag);
  return [cameraorigin, cameraangles];
}

function private function_347d56feb29d7f74() {
  assert(isDefined(self.camerainfo));

  if(uses_xcam()) {
    return self.camerainfo.xcamlength;
  }

  return self.camerainfo.animlength;
}

function spawn_script_model(modelname, animname, extramodels) {
  model = spawn("script_model", self.structorigin);
  model setModel(modelname);

  if(!isDefined(animname)) {
    animname = modelname;
  }

  model.animname = animname;

  if(isDefined(extramodels)) {
    model.linkedents = [];

    foreach(modeltag in extramodels) {
      extra = spawn("script_model", self.structorigin);
      extra setModel(modeltag[0]);
      extra linkTo(model, modeltag[1], (0, 0, 0), (0, 0, 0));
      model.linkedents[model.linkedents.size] = extra;
    }
  }

  return model;
}

function allplayers_setphysicaldof(fstop, focusdist, focusspeed, aperturespeed, focalpoint) {
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

    if(isDefined(focalpoint)) {
      player setphysicaldepthoffield(fstop, focusdist, focusspeed, aperturespeed, focalpoint);
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

function function_2289677bd4ea8866(buildfunc) {
  wait 1;

  while(true) {
    host = scripts\mp\gamelogic::gethostplayer();

    if(isDefined(host)) {
      function_b2a63c397eb5ccdf(host, buildfunc);
    }

    wait 0.25;
  }
}

function function_b2a63c397eb5ccdf(player, buildfunc) {
  assert(isDefined(buildfunc));
  animstruct = spawnStruct();
  animstruct[[buildfunc]]();

  foreach(pack in animstruct.packs) {
    foreach(ent in pack.ents) {
      ent hide();
    }
  }

  while(true) {
    function_9384c9ed097bf7b9(player, "<dev string:x1c>", "<dev string:x2a>");
    startorigin = player.origin;
    startangles = player getplayerangles();
    level.var_ca629cf434263639 = 0;
    thread function_e00bf2a7852cbc6(player, animstruct);
    thread function_710d2b779609907d(player, animstruct);
    thread function_b51365f787d44355(player, animstruct);
    function_9384c9ed097bf7b9(player, "<dev string:x2f>", "<dev string:x3c>");
    endanimsequence(player, animstruct);
    player setOrigin(startorigin);
    player setplayerangles(startangles);
    wait 0.5;
  }
}

function function_9384c9ed097bf7b9(player, buttonstring, keystring) {
  while(player buttonPressed(buttonstring) || player buttonPressed(keystring)) {
    waitframe();
  }

  while(!player buttonPressed(buttonstring) && !player buttonPressed(keystring)) {
    waitframe();
  }
}

function function_710d2b779609907d(player, animstruct) {
  animstruct endon("<dev string:x41>");

  while(true) {
    level.var_ca629cf434263639 = 0;

    while(player buttonPressed("<dev string:x1c>")) {
      waitframe();
    }

    while(!player buttonPressed("<dev string:x1c>")) {
      waitframe();
    }

    if(isDefined(animstruct.activepack)) {
      foreach(ent in animstruct.activepack.ents) {
        ent scriptmodelpauseanim(1);
      }

      if(animstruct.activepack uses_xcam()) {
        player pausexcam(1);
      }
    }

    level.var_ca629cf434263639 = 1;

    while(player buttonPressed("<dev string:x1c>")) {
      waitframe();
    }

    while(!player buttonPressed("<dev string:x1c>")) {
      waitframe();
    }

    if(isDefined(animstruct.activepack)) {
      foreach(ent in animstruct.activepack.ents) {
        ent scriptmodelpauseanim(0);
      }

      if(animstruct.activepack uses_xcam()) {
        player pausexcam(0);
      }
    }
  }
}

function function_b51365f787d44355(player, animstruct) {
  animstruct endon("<dev string:x41>");
  startorigin = player getorigin();
  startangles = player getplayerangles();

  while(true) {
    while(!player buttonPressed("<dev string:x4e>")) {
      waitframe();
    }

    player playershow();
    player function_985b0973f29da4f8("<dev string:x59>");
    player cameraunlink();
    player disablephysicaldepthoffieldscripting();

    if(isDefined(animstruct.activepack)) {
      [cameraorigin, cameraangles] = animstruct.activepack function_78dfe475a5d4f843(player);
      newplayerorg = cameraorigin + (0, 0, -60);
      var_a6fd7eae18e63f8 = cameraangles;
      player setOrigin(newplayerorg);
      player setplayerangles(var_a6fd7eae18e63f8);
    }

    if(!player isufo()) {
      player ufo();
    }

    setDvar(@ "hash_f94addedc8e87b69", 2);

    while(player buttonPressed("<dev string:x4e>")) {
      waitframe();
    }

    while(!player buttonPressed("<dev string:x4e>")) {
      waitframe();
    }

    if(player isufo()) {
      player ufo();
    }

    setDvar(@ "hash_f94addedc8e87b69", 0);

    if(isDefined(animstruct.activepack)) {
      animstruct.activepack function_bda88f27a0337eaa(animstruct, player, 1);
    }

    player playerhide();
    player scripts\cp_mp\utility\player_utility::function_379bb555405c16bb("<dev string:x59>");
    player enablephysicaldepthoffieldscripting();

    while(player buttonPressed("<dev string:x4e>")) {
      waitframe();
    }
  }
}

function waitandpause(timesec) {
  while(timesec > 0) {
    waitframe();

    while(istrue(level.var_ca629cf434263639)) {
      waitframe();
    }

    timesec -= level.framedurationseconds;
  }
}

function function_e00bf2a7852cbc6(player, animstruct) {
  animstruct endon("<dev string:x41>");

  foreach(pack in animstruct.packs) {
    animstruct.activepack = pack;

    if(isDefined(pack.startfunc)) {
      animstruct[[pack.startfunc]](pack.paramarray);
    }

    if(isDefined(pack.fov)) {
      allplayers_setfov(pack.fov);
    } else {
      function_cf47ab3f9defe35b();
    }

    if(isDefined(pack.fstop) && isDefined(pack.focusdist)) {
      allplayers_setphysicaldof(pack.fstop, pack.focusdist, pack.focusspeed, pack.aperturespeed, pack.focalpoint);
    }

    if(isDefined(pack.fx)) {
      playFX(getfx(pack.fx), pack.fxorigin, anglesToForward(pack.fxangles), anglestoup(pack.fxangles));
    }

    foreach(ent in pack.ents) {
      ent show();
      ent dontinterpolate();
      ent scriptmodelplayanimdeltamotionfrompos(level.scr_anim[ent.animname][pack.anime], animstruct.structorigin, animstruct.var_f7c301a9de8d90f4, ent.animname);
      ent thread scripts\common\notetrack::start_notetrack_wait(ent, ent.animname, pack.anime, ent.animname, level.scr_anim[ent.animname][pack.anime]);
    }

    foreach(ent in pack.staticents) {
      ent show();
    }

    if(isDefined(player)) {
      if(isDefined(pack.playerfunc)) {
        [[pack.playerfunc]](player, pack.var_5ab13b55d7ceff80);
      }

      player cameraunlink();
      player stopxcam();
      pack function_bda88f27a0337eaa(animstruct, player);
    }

    animlength = pack function_347d56feb29d7f74();
    waitandpause(animlength);
    waitframe();

    if(isDefined(pack.endfunc)) {
      animstruct[[pack.endfunc]](pack.var_315361abd838fad4);
    }
  }
}

function endanimsequence(player, animstruct) {
  animstruct notify("<dev string:x41>");

  if(isDefined(animstruct.activepack) && isDefined(animstruct.activepack.endfunc)) {
    animstruct[[animstruct.activepack.endfunc]](animstruct.activepack.var_315361abd838fad4);
  }

  foreach(pack in animstruct.packs) {
    foreach(ent in pack.ents) {
      ent scriptmodelclearanim();
      ent hide();
    }

    foreach(ent in pack.staticents) {
      ent hide();
    }
  }

  player cameraunlink();
  player stopxcam();
  function_cf47ab3f9defe35b();
  allplayers_clearphysicaldof();
}

# /