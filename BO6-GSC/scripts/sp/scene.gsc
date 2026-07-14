/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\scene.gsc
**************************************/

#using scripts\asm\asm;
#using scripts\asm\asm_bb;
#using scripts\asm\asm_sp;
#using scripts\common\anim;
#using scripts\common\notetrack;
#using scripts\common\scene_debug;
#using scripts\common\scene_internal;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#using scripts\sp\anim;
#using scripts\sp\damagefeedback;
#using scripts\sp\fakeactor;
#using scripts\sp\player_rig;
#using scripts\sp\spawner;
#namespace scene;

function private autoexec function_8c9c1cc35e443e5b() {
  if(getdvarint(@ "hash_e6afce2cf5cf7515")) {
    return;
  }

  function_fcfbe4ff62fa05cb();

  if(isplatformps4() || isplatformxb3()) {
    level.scene.prestreamtime = 2 * 2;
  }

  function_cf9a5dcae1307bac("\x81Q:\b\xa6g\xe0AH\xaa\x7f\xdd", "_\xd7\xae]\x92\xe8LN \xad\x86\xd193\xb7\xd1\x06\xea", &function_13fb334cd2d01102);
  function_cf9a5dcae1307bac("\x81Q:\b\xa6g\xe0AH\xaa\x7f\xdd", "\xb7\xffi\x9fa\x9d\b\x01e\xf8\a\x05P\"4(\xed\xe5", &function_f74488136b58dfd8);
  function_cf9a5dcae1307bac("\x81Q:\b\xa6g\xe0AH\xaa\x7f\xdd", "|\xbb\x1d\x18^\xc7g\xeb5\xfdU\x87h$NQ\x94", &function_eca8aee1788782a3);
  function_cf9a5dcae1307bac("\x81Q:\b\xa6g\xe0AH\xaa\x7f\xdd", "\xac\x91\x83U\x96\xf6\xed\xf0\xee\x11\xf4g\x15\x98\b", &function_7dea1738d1a4f7e3);
  function_cf9a5dcae1307bac("\x81Q:\b\xa6g\xe0AH\xaa\x7f\xdd", "|\xad?\x82-\x02\xdd\xe4\xfe\x01\x03G\xed\xd4&\x93", &function_867a65fd1f9767df);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\xb9\xa9\xde\xd1PA\xa3\xa7\xf3RX", &player_setup);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "`\xc0\x9esX?j\xd6\x06E\x84Mw\xe8\xe1", &function_39b8b9d2e03bd1ee);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\xe7\x91\x1c\xc6\xd1\x03\xd0,qd\xcb5<'\x01\xb14", &player_shot_prepare);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\x9e\xd8\xe8\xad\xb5Z\x90nR?\x9b\x12X\xa5)\xcc_", &function_4514b0dd00c9973b);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "n\n\x9460\xf3\x8e\xc0\xf56\xf4\x12\x81\xf3\x16ix", &function_1434643eaab3627d);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\xc0\\\xf1\x86f\x86\xday\xaf\xdc\xcd\xd3\x99,\x05\x03\xfd\x14\x05", &function_fbb909cf93220dec);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "pe\xaa\x10& 4K4\xd5\xf4\xa8\x06?\xbb\x90\xde~", &function_98c300a3e04220db);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\xdf\xc85d\xcd\xd7\xe4\fKA\x06^\x91i", &player_velocity);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "_\xd7\xae]\x92\xe8LN \xad\x86\xd193\xb7\xd1\x06\xea", &function_325a73a7b22fe90c);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\xb7\xffi\x9fa\x9d\b\x01e\xf8\a\x05P\"4(\xed\xe5", &function_ac7b109fac5f7a2e);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "Xr\xec\xd6\xfb\x18\xc8Re[*v~\x03\xb3\xf5\xcf", &function_f9534e9cb5061b0f);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\x94v\xe3\xed\x90\x13\"aE\x01\x82\x17\xa8", &player_cleanup);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\xbe\xeb\xeb\xf91\xe43y\xd8\x16\xf8a", &player_delete);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", ">r\xae[\xe0\x17_f\x9da\xc7\x80t*8\xbc\xda", &function_54831066c24127cd);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\xc5\xcc\xe4 \xaa8\x84\a\x8f\x14\xf8\xf4`\x1a\xa8\xad\xed", &function_f9c3da499a63da32);
  function_cf9a5dcae1307bac("T^\x83\xca7\xeb\n6a\xcber", "\xe4/c\xee\xba#\xc45\xa5\xa4\xe2\xc3\xcd(\x9f\xc4", &function_7828b08624b08e84);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", ";\xe6=\xd8\xd8\xdf\xcc\x83\x99\x15\xf7", &actor_spawn);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\xb9\xa9\xde\xd1PA\xa3\xa7\xf3RX", &actor_setup);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\xe7\x91\x1c\xc6\xd1\x03\xd0,qd\xcb5<'\x01\xb14", &function_1dd2a3a5cb965926);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "`\xc0\x9esX?j\xd6\x06E\x84Mw\xe8\xe1", &function_5d4919ad2db4b50);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\x13\xbb-j\x9e\xf6\x144Lh|yr\x1c\x96\xf1\xe0\x0e\xfa", &function_e4f47bdc985debf);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "n\n\x9460\xf3\x8e\xc0\xf56\xf4\x12\x81\xf3\x16ix", &function_dffc588c67f5ef3);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "{)\xcd\xce\xabq\xdc\xbf\xbc\xb9\xb9\xd9\x99\xfa", &actor_teleport);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\xe3\x93\xe4-\x92\x86\xbd\x02\x0f\xc5X\r\xeec0X\x1b\xad\xa0\x06", &function_26644d41f4a50e8);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", ">r\xae[\xe0\x17_f\x9da\xc7\x80t*8\xbc\xda", &function_e5e827d040b96c5f);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\xc5\xcc\xe4 \xaa8\x84\a\x8f\x14\xf8\xf4`\x1a\xa8\xad\xed", &actor_set_anim_time);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\xf2\xf80\x87s\xb0:\xde\xd64>&\xbd\xdeD\x18\xb4", &function_1e7f279f3ecb1f64);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\xf0\xffS\x1c\x917aj\xcaw\xc1\x9b{\x11<\xf0\xf4\xd19l", &actor_set_anim_playing);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\xb94\xb7GO\x98\xa9\xac\x8d\xe8\x866\xb2\xb0sW\x83", &function_a2844a0acc2e1001);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\x94v\xe3\xed\x90\x13\"aE\x01\x82\x17\xa8", &actor_cleanup);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\x80\xe7\xd5\xd7U\f\xa2\xab<,", &actor_kill);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\x8e\\\x91w\x02\x91\xe0\x1cc\xed\a\xe6\xbd\xf9\xc5M", &function_ff348230ae014f9c);
  function_cf9a5dcae1307bac("\x80\xea/[;\xa1\x87\x0f\xe3\xb4\xb0", "\xcd\xd0o\x1d\xd3\x89M\xb26GL\xd2\x9bk\x147\x96\xb6", &function_eb840c2d88cae2e9);
  function_cf9a5dcae1307bac("\x15\xbc\x83V\xcd\xd72\x16m\xca\xa0\x1b\x1d\xde\x9c", ";\xe6=\xd8\xd8\xdf\xcc\x83\x99\x15\xf7", &function_abb1b3234b6d1ab);
  function_cf9a5dcae1307bac("\x15\xbc\x83V\xcd\xd72\x16m\xca\xa0\x1b\x1d\xde\x9c", "n\n\x9460\xf3\x8e\xc0\xf56\xf4\x12\x81\xf3\x16ix", &function_662fb6f853c58db7);
  function_cf9a5dcae1307bac("\x15\xbc\x83V\xcd\xd72\x16m\xca\xa0\x1b\x1d\xde\x9c", "\xe7\x91\x1c\xc6\xd1\x03\xd0,qd\xcb5<'\x01\xb14", &function_b5040526359a43fa);
  function_cf9a5dcae1307bac("\x15\xbc\x83V\xcd\xd72\x16m\xca\xa0\x1b\x1d\xde\x9c", "\xb94\xb7GO\x98\xa9\xac\x8d\xe8\x866\xb2\xb0sW\x83", &function_80955378201699b5);
  function_cf9a5dcae1307bac("\x15\xbc\x83V\xcd\xd72\x16m\xca\xa0\x1b\x1d\xde\x9c", "\x94v\xe3\xed\x90\x13\"aE\x01\x82\x17\xa8", &function_81b4a31b15902594);
  function_3136ae044ec1c943();

  if(!(isDefined(level.scr_animtree) && isDefined(level.scr_animtree["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"]))) {
    gamemodebundle = getgamemodescriptbundle();

    if(isDefined(gamemodebundle.var_4517c8d6e298798)) {
      namespace_6341d8b435bf1728::init_player_rig(gamemodebundle.var_4517c8d6e298798, undefined, gamemodebundle.var_dc8cacaa030a56d0);
    } else {
      namespace_6341d8b435bf1728::init_player_rig("X\x14\x04\xf0\x97\x96\x86T\xe36}2Xtue96", undefined, "C6&W\xba\xa4\xb5\x8f\x16\x87\xb9\v\x85BBk\xf7fx\x02\xca\xb9~O%\x13\xe7");
    }
  }

  level thread function_6973d0bff1857f32("\xad\v\xac\x80SP:\x8f\x9c\xa9\xec\xb3\xca");
}

function private function_d192169770fe8528(entity, notifystring, alignmentinfo, animasset, var_497c7300de3d9144, blendtime, blendcurve, lerptime) {
  sceneobjectdata = self;

  if(!isDefined(entity)) {
    return;
  }

  animlengthtime = 0;
  animrate = undefined;
  done = 0;

  if(isDefined(sceneobjectdata.sceneroot.scenestatic)) {
    animrate = sceneobjectdata.sceneroot.scenestatic.animrate;
  }

  if(!isDefined(var_497c7300de3d9144)) {
    var_497c7300de3d9144 = 0;
  }

  if(!isDefined(lerptime)) {
    lerptime = 0;
  }

  if(!isDefined(blendtime)) {
    blendtime = 0.2;
  }

  root = sceneobjectdata function_3ea2dfe86aa3705();

  if(entity.model == "") {
    println("<dev string:x24>" + sceneobjectdata.sceneobject function_17ebf11c9b4e19c0() + "<dev string:x57>");
    return 0;
  }

  if(isDefined(var_497c7300de3d9144) && var_497c7300de3d9144 > 0) {
    blendtime = 0;
    lerptime = 0;
  }

  function_c1a858ce62ddf810(alignmentinfo);

  if(!sceneobjectdata function_734f3d605e18aa6c()) {
    return 0;
  }

  startorigin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
  startangles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);

  if(lerptime <= 0) {
    sceneobjectdata object_teleport(startorigin, startangles);
  }

  if(var_497c7300de3d9144 < 1 && isDefined(notifystring)) {
    sceneobjectdata childthread function_5ff4a0b989226045(notifystring, animasset);
  }

  entity animScripted(notifystring, alignmentinfo.origin, alignmentinfo.angles, animasset, undefined, root, blendtime);

  if(sceneobjectdata.sceneobject function_fbb0c8a694dacde6()) {
    proc_node = function_299a4852289c6102("\xf41\xd8\t\x81\xf0*\xedH", sceneobjectdata.sceneobject function_d526e9fe4d60906e());

    if(isDefined(proc_node)) {
      entity setanim(proc_node, 1, 0);
    }
  }

  var_394c41242b8f4c7 = animasset == sceneobjectdata.var_2231d8d938c71767;
  sceneobjectdata function_6faa87a1a5bbb7eb(animasset);
  sceneobjectdata thread function_a75636543106e118(1);

  if(isDefined(lerptime) && lerptime > 0) {
    sceneobjectdata childthread function_730239b5c564e334(lerptime, sceneobjectdata object_velocity());
  }

  if(isDefined(blendcurve) && blendtime > 0) {
    entity setanimblendcurve(animasset, blendcurve);
  }

  animlength = getanimlength(animasset);

  if(isDefined(var_497c7300de3d9144) && var_497c7300de3d9144 > 0 && var_497c7300de3d9144 <= 1) {
    if(var_497c7300de3d9144 == 1 && animislooping(animasset)) {
      var_497c7300de3d9144 = 0.999;
    }

    sceneobjectdata function_95d6e44589da0868(animasset, var_497c7300de3d9144);
  } else if(istrue(var_394c41242b8f4c7)) {
    sceneobjectdata function_95d6e44589da0868(animasset, 0);
  }

  sceneobjectdata function_9e445b007441e1ef(animrate);

  if(var_497c7300de3d9144 < 1 && isDefined(notifystring)) {
    entity utility::function_c192fa51a056b7e3(notifystring, "8\xdb\x90", "\xc3\xeeI\xa0;?\xac\x81\x8e?|\xe9\xe4");
  }

  animlengthtime += animlength;
  return animlengthtime - var_497c7300de3d9144 * animlengthtime;
}

function private function_13fb334cd2d01102(shotindex, animindex, notifystring, alignmentinfo, animasset, var_497c7300de3d9144, blendtime, blendcurve, lerptime, animationtype) {
  sceneobjectdata = self;
  anim_entity = sceneobjectdata function_a609347bd1d1ba66();
  assert((animationtype ?? "<dev string:x5c>") == "<dev string:x5c>");
  animplaybacktime = sceneobjectdata function_d192169770fe8528(anim_entity, notifystring, alignmentinfo, animasset, var_497c7300de3d9144, blendtime, blendcurve, lerptime);
  return animplaybacktime;
}

function private function_f74488136b58dfd8() {
  sceneobjectdata = self;
  entity = sceneobjectdata function_a609347bd1d1ba66();

  if(isDefined(entity)) {
    entity utility_sp::anim_stopanimScripted();
  }
}

function private function_eca8aee1788782a3() {
  sceneobjectdata = self;
  entity = sceneobjectdata function_a609347bd1d1ba66();
  root = undefined;

  if(isai(entity) || entity fakeactor::is_fakeactor()) {
    root = entity asm::asm_getbodyknob();
  } else if(isDefined(entity.anim_getrootfunc)) {
    root = [[entity.anim_getrootfunc]]();
  }

  if(isDefined(entity.asm) && !isai(entity)) {
    entity asm_sp::asm_animScripted();
  }

  return root;
}

function private function_7dea1738d1a4f7e3(notifystring, animasset) {
  sceneobjectdata = self;
  entity = sceneobjectdata function_a609347bd1d1ba66();

  if(!isDefined(entity)) {
    return;
  }

  sceneobjectdata childthread notetrack::start_notetrack_wait(entity, notifystring, undefined, undefined, animasset);
  sceneobjectdata childthread anim_sp::animscriptdonotetracksthread(entity, notifystring, undefined);
}

function private function_867a65fd1f9767df(killer) {
  sceneobjectdata = self;

  if(killer == level.player && isDefined(sceneobjectdata.entity)) {
    level.player damagefeedback::updatehitmarker("7\xfd\x90\xc0\b\xb3L\xe5", 1, 0, sceneobjectdata.entity);
  }
}

function private player_setup(sceneplay) {
  sceneobjectdata = self;
  sceneobjectdata.playerrigs = sceneobjectdata function_2dad6ea2feaf853e();
  scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();

  if(scenescriptbundle function_3a60a7f072f9113() == "\xfa\xd4\x10\x0f\xd6\asy\x0e\x8f\xd0\xd3\x99l") {
    foreach(rig in sceneobjectdata.playerrigs) {
      rig val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "d\xbc;\x03\x90\xa7\xde\xc6\xef\xb2z\xcb]\xc1\x15\x97\x1f", 1);
    }
  }
}

function private function_39b8b9d2e03bd1ee(shotindex, cameraanimation, shotanimations) {
  sceneobjectdata = self;

  if(isPlayer(sceneobjectdata.entity)) {
    scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
    sceneobjectdata.entity utility::delaycall(0.1, &clearplayerhintlock);
    sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", ";\x9eH\n\xc0Y\xf4iI\x03\x90\xa8l\xd7\xa5\x82`\xfd\x84\xdb\x1eb", 1);
    sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "{.\xcb\x03\x87\xa8\xceU\x16gx\x86y\xf7\x19\xda", scenescriptbundle function_b2b33615b74638cc());
    sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\x8f(]2CB&\x0fl\xf8\x15z\xa9&J\x8c\xd5ju ", scenescriptbundle function_3a60a7f072f9113() == "gihPx\xb7\x95\xfc\x98\x01\f\x86]\f\x92e");
    sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\x8b\x13\xa9\x82!5Q\xc9\xe8L\xfc1 P\x7f\xa6]\x0f\xb3\x11", 0);
    sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "KJs\xdb\x1aFe\x17\xbf\xe1\x84\xa8y\xbe\x8d\x93\x99\x97\xab", 1);
    sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\xc7?\x16|\x01\x84\xca\xbb\xb5\xdf\xc7\xb0\xec\xb0\xb7\xb0\x89:D\x17", 1);
    sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "w\xb2a8\xb7n\xbe\xb6{\xa3i\xedn\xd7Z\xb5", 0);

    if(!sceneobjectdata.sceneroot function_1670fa93d23a782c()) {
      scenescriptbundle = sceneobjectdata.sceneroot scene_scriptbundle();
      letterbox = scenescriptbundle function_7ee880fb36f59305();
      sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "`QW\xf5\xf2\x1b\xd6\xd7\x03\xd6\xce\bf\xd6", 0);
      sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\x8e\x056\xd4\x15\xe4\x12\x8f\xaf\xd2\x1674\xd5\x8bm\xffBgt ", 0);
      sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\xf7~{\xb1\x14", 0);
      sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\xbe\x01\xf7\xe3W\xce\x8a\xa9\xdf", sceneobjectdata.sceneroot function_8c6e23b6a136e356());

      if(sceneobjectdata.sceneobject function_cc9d022a79a776f8(shotindex) != "\x90\xb5\v\xf8") {
        sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
      }

      if(!istrue(letterbox) && !isDefined(cameraanimation) && isDefined(shotanimations) && shotanimations.size > 0) {
        sceneobjectdata.entity val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\rnT\xb9G\xdco\x12\x86\x7fMO6\xc9", [0, 0.25]);
      }
    }

    rigtype = sceneobjectdata function_a08f4cd2348ea57a();

    switch (rigtype) {
      case #"hash_b1ca0af44e0e42b5":
      case #"hash_e715735306dff4b1":
        model = undefined;

        if(!isDefined(sceneobjectdata.prevplayerrigs)) {
          sceneobjectdata.prevplayerrigs = [];
          sceneobjectdata.prevplayerrigs["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = level.scr_model["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"];
          sceneobjectdata.prevplayerrigs["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"] = level.scr_model["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"];
          sceneobjectdata.prevplayerrigs["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"] = level.scr_model["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"];
        }

        if(rigtype == "\xd0\xaa\xc3.\xda\x1e?kP\xff\x12") {
          model = sceneobjectdata.sceneobject function_cee8c56583dafef9();
        } else if(isDefined(level.player_body.model)) {
          assert(rigtype == "<dev string:x6e>");
          model = level.player_body.model;
        }

        if(sceneobjectdata function_42c272013d0f1d7(shotindex)) {
          sceneobjectdata.entity val::set("U\x0fr\x8eS\x06u\xf4\xc4k", "s\xa5\xba-/\xb2a\xd8\x97\x1c\x19\x94", 1);
        }

        if(isDefined(model)) {
          namespace_6341d8b435bf1728::init_player_rig_no_precache(model);
        } else {
          sceneobjectdata.prevplayerrigs = undefined;
        }

        break;
    }

    foreach(rig in sceneobjectdata.playerrigs) {
      if(!isent(rig)) {
        continue;
      }

      if(!isarray(shotanimations) || shotanimations.size == 0) {
        rig hide(1);
        continue;
      }

      if(isDefined(level.player_rig) && rig == level.player_rig) {
        rig val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\xeaq\xdfT5\xac\x04\x1d\x89+R", sceneobjectdata.sceneobject function_848c31203c96d5e0(shotindex));
        continue;
      }

      if(!isDefined(level.player_rig) || rig != level.player_rig) {
        rig val::set("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV", "\xeaq\xdfT5\xac\x04\x1d\x89+R", sceneobjectdata.sceneobject function_33c57f9da680acd9(shotindex));
      }
    }
  }
}

function private player_shot_prepare(sceneplay, shotindex, objectindex) {
  sceneobjectdata = self;

  if(isPlayer(sceneobjectdata.entity) && sceneobjectdata.sceneobject function_2c1b9e7469f5ce2e(shotindex)) {
    beginstance = sceneobjectdata.sceneobject function_b2d42d91f5233512(shotindex);

    if(sceneobjectdata.entity getstance() == "GX\xa9]\x82" && beginstance != "GX\xa9]\x82") {
      delaysec = 0.5;
      sceneobjectdata.entity val::set("\x81\x05\x87\xee\x1enp7j|]\xdc\x8b\x02\xfa\x83\x81\x7f\xed", "GX\xa9]\x82", 0);
      sceneobjectdata.entity utility::delaythread(delaysec + level.framedurationseconds, &val::reset_all, "\x81\x05\x87\xee\x1enp7j|]\xdc\x8b\x02\xfa\x83\x81\x7f\xed");
      wait delaysec;
    }
  }
}

function private function_4514b0dd00c9973b(animname, animtree) {
  sceneobjectdata = self;
}

function private function_54831066c24127cd(animrate) {
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata.playerrigs)) {
    return;
  }

  foreach(rig in sceneobjectdata.playerrigs) {
    if(isDefined(rig) && isDefined(sceneobjectdata.activeanimation)) {
      rig setanimrate(sceneobjectdata.activeanimation, animrate);
    }
  }
}

function private function_f9c3da499a63da32(animasset, timefrac) {
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata.playerrigs)) {
    return;
  }

  foreach(rig in sceneobjectdata.playerrigs) {
    if(isDefined(rig)) {
      rig setanimtime(animasset, timefrac);
      rig dontinterpolate();
    }
  }
}

function private function_1434643eaab3627d(entity) {
  sceneobjectdata = self;
  return isPlayer(entity);
}

function private function_2dad6ea2feaf853e() {
  sceneobjectdata = self;
  result = [];
  animtree = sceneobjectdata.sceneobject function_d526e9fe4d60906e();
  rigs = sceneobjectdata namespace_6341d8b435bf1728::function_fb87031dd45ca4df(0, 1, animtree);
  rigtype = sceneobjectdata function_a08f4cd2348ea57a();

  switch (rigtype) {
    case #"hash_f900f466f5425fa7":
      result["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = rigs["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"];
      result["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"] = rigs["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"];
      break;
    case #"hash_cc1dcc1121d79906":
      result["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = rigs["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"];
      result["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"] = rigs["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"];
      break;
    case #"hash_a947444bcd267ab4":
      result = rigs;
      break;
    case #"hash_8619326cd6780be9":
    default:
      result["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"] = rigs["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"];
      break;
  }

  foreach(animname, rig in rigs) {
    if(result.size == 0) {
      result[animname] = rigs[animname];
    }

    if(!isDefined(result[animname]) && isent(rig)) {
      rig hide(1);
    }
  }

  return result;
}

function private function_a46a4437e9aab716() {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.playerrigs)) {
    if(isDefined(sceneobjectdata.playerrigs["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"])) {
      return sceneobjectdata.playerrigs["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"];
    }

    foreach(rig in sceneobjectdata.playerrigs) {
      return rig;
    }
  }

  return undefined;
}

function private function_fbb909cf93220dec() {
  sceneobjectdata = self;
  return sceneobjectdata function_a46a4437e9aab716();
}

function private function_98c300a3e04220db() {
  sceneobjectdata = self;

  if(istrue(sceneobjectdata.var_fff4175bb9be8dac)) {
    return [];
  }

  return sceneobjectdata.playerrigs;
}

function private player_velocity() {
  sceneobjectdata = self;
  return sceneobjectdata.entity getvelocity();
}

function private function_325a73a7b22fe90c(shotindex, animindex, notifystring, alignmentinfo, animasset, var_497c7300de3d9144, blendtime, blendcurve, lerptime) {
  sceneobjectdata = self;
  player = sceneobjectdata.entity;
  sceneobjectdata endon("\xe6\xb1\xacs\xac\xd7\xcd\xd1\xdb\xc1");
  sceneobjectdata endon("\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela");

  if(istrue(sceneobjectdata.sceneroot.scenedata.excludeplayer) || !isPlayer(player)) {
    sceneobjectdata function_c3a9aefafb866f01(animasset, sceneobjectdata.activeanimationtype, notifystring);
    sceneobjectdata function_4fc851342fdc6d22(sceneobjectdata.activeanimationtype, shotindex, animindex);
    return 0;
  }

  var_14bb76de0aad5461 = sceneobjectdata function_9515ee5a9080d2ae(shotindex);

  if(sceneobjectdata.activeanimationtype == "\x13\x14\xcd5O\xc9Ob\f\xb6\xa7\xb5f\xd4h") {
    sceneobjectdata thread object_play_anim_waittill_end(animasset, [player], "\xcb2\x83m\x94Nq*<JAQ\xf8\xc5\xa1YSB\xb2", "\x13\x14\xcd5O\xc9Ob\f\xb6\xa7\xb5f\xd4h", notifystring);
    sceneobjectdata.xcamplaying = 1;
    player val::set_array("U\x0fr\x8eS\x06u\xf4\xc4k", var_14bb76de0aad5461, 0);
    return sceneobjectdata function_40bf184e9a306f8("U\x0fr\x8eS\x06u\xf4\xc4k", player, animasset, var_497c7300de3d9144, notifystring, alignmentinfo, shotindex);
  }

  animlengthtime = 0;
  rig = sceneobjectdata function_a46a4437e9aab716();

  if(isDefined(level.player_rig) && isDefined(rig) && rig != level.player_rig) {
    iprintlnbold("<dev string:x76>" + level.player_rig + "<dev string:x86>" + rig);
  }

  shotindex = sceneobjectdata.sceneplay.currentshot;
  stance = sceneobjectdata.sceneobject function_b2d42d91f5233512(shotindex);
  blendtime = sceneobjectdata.sceneobject function_feb9cfa41f6f99d5(shotindex);
  arcenabled = sceneobjectdata.sceneobject function_af33329661b9e118(shotindex);
  arcright = sceneobjectdata.sceneobject function_7bc4c15f7ac5b647(shotindex);
  arcleft = sceneobjectdata.sceneobject function_3f0c07973590544c(shotindex);
  arctop = sceneobjectdata.sceneobject function_7c21d252f7d823e6(shotindex);
  arcbottom = sceneobjectdata.sceneobject function_28ea9e98f20bc432(shotindex);
  usetagangles = sceneobjectdata.sceneobject function_59dce5a3f6d595b9(shotindex);
  restrictcamera = 0;
  autocenter = sceneobjectdata.sceneobject function_23a097ec572ebd8f(shotindex);
  viewfraction = sceneobjectdata.sceneobject function_148535ef0077791a(shotindex);

  if(!arcenabled) {
    arcright = 0;
    arcleft = 0;
    arctop = 0;
    arcbottom = 0;
  }

  if(isDefined(sceneobjectdata.scenedata.var_2c14785d1b220bd9)) {
    blendtime = 0;
    lerptime = 0;
  }

  namespace_6341d8b435bf1728::set_player_rig_allows(var_14bb76de0aad5461);

  if(getdvarint(@ "scr_debug_scene_player_rig")) {
    player thread scene_debug::tag_thread("<dev string:xa7>", 20, getdvarint(@ "scr_debug_scene_player_rig"), lerptime);
    rig thread scene_debug::tag_thread("<dev string:xab>", 20, getdvarint(@ "scr_debug_scene_player_rig"));
    rig thread scene_debug::tag_thread("<dev string:xb9>", 20, getdvarint(@ "scr_debug_scene_player_rig"));
  }

  linktoblendtime = 0;

  if(!sceneobjectdata function_85d8d3475119f5fd()) {
    playerblending = lerptime > 0;
    animblending = blendtime > 0;

    if(animblending) {
      level.blendinfo["\xc1\xd1U`:\xf5r\x1d\xb2\x19\xdc\x1a\x81S"] = max(lerptime, blendtime) * 0.7;
    }

    linktag = sceneobjectdata function_68f50e76853f4d7e();
    otherrigs = [];

    foreach(rigother in sceneobjectdata.playerrigs) {
      if(rigother == rig) {
        continue;
      }

      otherrigs[otherrigs.size] = rigother;
    }

    var_3de3e3b26ddf860 = sceneobjectdata.sceneroot function_1670fa93d23a782c();
    sceneobjectdata.sceneroot childthread namespace_6341d8b435bf1728::link_player_to_rig(undefined, stance, playerblending, lerptime, restrictcamera, arcright, arcleft, arctop, arcbottom, usetagangles, undefined, var_3de3e3b26ddf860, undefined, animblending, undefined, undefined, undefined, linktag, otherrigs, arcenabled);
    linktoblendtime = lerptime;
  } else {
    foreach(rigent in sceneobjectdata.playerrigs) {
      rigent show();
    }

    if(!player function_63b1b7751d765b9e()) {
      player lerpviewangleclamp(lerptime, lerptime * 0.5, lerptime * 0.5, arcright, arcleft, arctop, arcbottom, 1, usetagangles);
    }

    player namespace_6341d8b435bf1728::function_e97539bbe302cd26();
  }

  if(lerptime <= 0) {
    if(!sceneobjectdata function_b3b9fb507e21dd33(shotindex)) {
      player dontinterpolate();
    }
  }

  sceneobjectdata.playerrigvalues = 1;

  if(sceneobjectdata function_85d8d3475119f5fd() && !player isufo() && !player isnoclip()) {
    if(autocenter) {
      sceneobjectdata utility::delaythreadendon(linktoblendtime + level.framedurationseconds * 2, "\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela", &function_bc78a7fa62e2a5c7);
    } else {
      sceneobjectdata utility::delaythreadendon(linktoblendtime + level.framedurationseconds * 2, "\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela", &function_829d80aa5f54ffa);
    }

    player playerlinkedviewfraction(viewfraction);
  }

  sceneobjectdata thread function_9314b5a94e4f9b9c();
  riglerptime = 0;

  foreach(rigother in sceneobjectdata.playerrigs) {
    if(rigother != rig) {
      rigother function_2c1fe9e1549cec1b(1);
      sceneobjectdata thread function_d192169770fe8528(rigother, notifystring, alignmentinfo, animasset, var_497c7300de3d9144, blendtime, blendcurve, riglerptime);
    }
  }

  rig function_2c1fe9e1549cec1b(0);
  animlengthtime = sceneobjectdata function_d192169770fe8528(rig, notifystring, alignmentinfo, animasset, var_497c7300de3d9144, blendtime, blendcurve, riglerptime);
  return animlengthtime;
}

function private function_bc78a7fa62e2a5c7() {
  sceneobjectdata = self;
  player = sceneobjectdata.entity;

  if(!isPlayer(player)) {
    return;
  }

  if(sceneobjectdata function_85d8d3475119f5fd() && !player isufo() && !player isnoclip()) {
    player springcamenabled(1, undefined, undefined, 1);
  }
}

function private function_829d80aa5f54ffa() {
  sceneobjectdata = self;
  player = sceneobjectdata.entity;

  if(!isPlayer(player)) {
    return;
  }

  if(sceneobjectdata function_85d8d3475119f5fd() && !player isufo() && !player isnoclip()) {
    player springcamdisabled(0.2, 1);
  }
}

function private function_ac7b109fac5f7a2e() {
  sceneobjectdata = self;
  sceneobjectdata function_22b5e0cc3741e8ba();
  sceneobjectdata function_f74488136b58dfd8();
}

function private function_f9534e9cb5061b0f() {
  sceneobjectdata = self;

  foreach(rig in sceneobjectdata.playerrigs) {
    if(isDefined(rig) && isDefined(sceneobjectdata.var_b24accbec827c0be)) {
      foreach(message in sceneobjectdata.var_b24accbec827c0be) {
        rig notify(message, "8\xdb\x90");
      }
    }
  }

  if(isDefined(sceneobjectdata.entity) && isDefined(sceneobjectdata.var_b24accbec827c0be)) {
    foreach(message in sceneobjectdata.var_b24accbec827c0be) {
      sceneobjectdata.entity notify(message, "8\xdb\x90");
    }
  }
}

function private player_cleanup(newsceneroot) {
  sceneobjectdata = self;
  sceneobjectdata function_22b5e0cc3741e8ba();

  if(sceneobjectdata.playerrigs.size > 0) {
    rig = sceneobjectdata function_a46a4437e9aab716();

    if(!isDefined(newsceneroot)) {
      if(sceneobjectdata function_85d8d3475119f5fd()) {
        stancebegin = sceneobjectdata.sceneobject function_b2d42d91f5233512(sceneobjectdata.sceneplay.currentshot);
        stanceend = sceneobjectdata.sceneobject function_99b0f6e3478fece2(sceneobjectdata.sceneplay.currentshot);
        immediatestance = (rig.linktag ?? "\xf6\xfc\xad\x9di\xb9)\xac/K") == "<\xd7\x93\xbf-\xe8NE\x19\xcd";

        if(stancebegin != stanceend) {
          immediatestance = 1;
        }

        childthread namespace_6341d8b435bf1728::unlink_player_from_rig(0, stanceend, immediatestance, 1);
      }

      if(isPlayer(sceneobjectdata.entity) && istrue(sceneobjectdata.playerrigvalues)) {
        sceneobjectdata.entity val::reset_all("\xe0\x1b\x16^+\x9c\xbe\xc9-\xce");
        sceneobjectdata.playerrigvalues = undefined;
      }
    }

    foreach(rigiter in sceneobjectdata.playerrigs) {
      if(isent(rigiter)) {
        rigiter val::reset_all("\x9b\x8de\x9be\xfa\xdcc\xac\x9bV");
        rigiter hide(1);
      }
    }

    rigtype = sceneobjectdata function_a08f4cd2348ea57a();

    switch (rigtype) {
      case #"hash_b1ca0af44e0e42b5":
      case #"hash_e715735306dff4b1":
        if(isDefined(sceneobjectdata.prevplayerrigs)) {
          namespace_6341d8b435bf1728::init_player_rig_no_precache(sceneobjectdata.prevplayerrigs["\xe0\x1b\x16^+\x9c\xbe\xc9-\xce"], sceneobjectdata.prevplayerrigs["r~2\x17\x1e\x17\xa9\xfe\x10\xb5\x1f"], sceneobjectdata.prevplayerrigs["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"]);
          sceneobjectdata.prevplayerrigs = undefined;
        }

        break;
    }
  }
}

function private player_delete() {}

function private function_a08f4cd2348ea57a() {
  sceneobjectdata = self;
  return sceneobjectdata.sceneobject.variant_object.playerrigtype ?? "\x8a{\xbf";
}

function private function_85d8d3475119f5fd() {
  sceneobjectdata = self;
  rig = sceneobjectdata function_a46a4437e9aab716();
  player = sceneobjectdata.entity;

  if(isDefined(player) && isDefined(rig)) {
    playerparent = player getlinkedparent();

    if(isDefined(playerparent) && playerparent == rig) {
      return true;
    }
  }

  return false;
}

function private function_7828b08624b08e84() {
  sceneobjectdata = self;

  if(!isPlayer(sceneobjectdata.entity)) {
    return;
  }

  weaponsuffix = sceneobjectdata function_4c1c6acfe0e2cfd7();

  if(weaponsuffix != "") {
    sceneobjectdata.animaltname = [];
    sceneobjectdata.animaltname[0] = "\x7f\xc0\x19\xd5" + weaponsuffix;
  }
}

#using_animtree("K_p\x84a\x01");

function function_9314b5a94e4f9b9c() {
  sceneobjectdata = self;

  if(!isDefined(sceneobjectdata.playerrigs)) {
    return;
  }

  body = sceneobjectdata.playerrigs["~*\x1c\xd6\xd1\xc0\xa0f5\x16\x1a"];

  if(isDefined(body)) {
    if(!isDefined(sceneobjectdata.activeanimationplaying)) {
      sceneobjectdata waittill(">\xcb\xf9m]\xa5\xedtDo\xab\xc8`\xc9E\x9b\xeb\x82");
    }

    waittillframeend();

    if(getdvarint(@ "hash_d0761d5c3f9e3bf", 0)) {
      body setanim(%\b\xbc\xe4\xe2 = \x94mD9L\x0fr: #\x99r\x17\xec, 0, 0);
      return;
    }

    body setanim(%\b\xbc\xe4\xe2 = \x94mD9L\x0fr: #\x99r\x17\xec, 1, 0);
  }
}

function private function_c6b13ff96d29a254(shotindex, allowrepulsor) {
  sceneobjectdata = self;

  if(istrue(sceneobjectdata.repulsor)) {
    sceneobjectdata.repulsor = undefined;

    if(isent(sceneobjectdata.entity)) {
      sceneobjectdata.entity fakeactor::function_1123949b442d9bd7();
    }
  }

  if(isDefined(sceneobjectdata.badplace)) {
    destroynavobstacle(sceneobjectdata.badplace);
    sceneobjectdata.badplace = undefined;
  }

  if(isent(sceneobjectdata.entity) && sceneobjectdata function_35be7d3b0eb456c1()) {
    sceneobjectdata.repulsor = istrue(allowrepulsor);

    if(!isent(sceneobjectdata.alignmentinfo.alignent)) {
      animations = sceneobjectdata function_bdca3d3bf269f17b(shotindex);

      if(isDefined(animations) && animations.size > 0) {
        maxmovedist = 0;

        foreach(animasset in animations) {
          animmovedist = sceneobjectdata.entity function_874d5f810020e047(animasset);
          maxmovedist = max(maxmovedist, animmovedist);
        }

        if(maxmovedist < 30) {
          pos = sceneobjectdata.entity animation::function_3cf2092e487b2640(animations[0], "\xec\xbfK|\au\xcd\xc2\x19<", 0, sceneobjectdata.alignmentinfo.origin, sceneobjectdata.alignmentinfo.angles);

          if(isDefined(pos["\xb0$R\x8b\xc9\x17"])) {
            sceneobjectdata.badplace = createnavbadplacebyshape(pos["\xb0$R\x8b\xc9\x17"], (0, 0, 0), 6, maxmovedist + 5, 64, "O\x15\x1b\xad\x9ff", "\xba\xa5\x1f\xc9m\x80i", "?\xb1\xc0\x9a");
            sceneobjectdata.repulsor = undefined;
          }
        }
      }
    }

    if(istrue(sceneobjectdata.repulsor)) {
      sceneobjectdata.entity fakeactor::function_19ff13afbfa564cc();
    }
  }
}

function private function_1c5da92a6419ce2() {
  sceneobjectdata = self;

  if(istrue(sceneobjectdata.repulsor)) {
    sceneobjectdata.repulsor = undefined;

    if(isent(sceneobjectdata.entity)) {
      sceneobjectdata.entity fakeactor::function_1123949b442d9bd7();
    }
  }

  if(isDefined(sceneobjectdata.badplace)) {
    destroynavobstacle(sceneobjectdata.badplace);
    sceneobjectdata.badplace = undefined;
  }
}

function private function_abb1b3234b6d1ab(spawnorigin, spawnangles) {
  sceneobjectdata = self;
  sceneobjectassettype = sceneobjectdata.sceneobject function_79d3a8ba86688a7e();
  sceneobjectassetname = sceneobjectdata.sceneobject function_cee8c56583dafef9();
  level utility::flag_set("\x1f\\vI:\x1e5X\x19Y\x82to\x83\xf51x\xc2\xfb\x89\vX\n\xbc");
  entity = undefined;

  if(sceneobjectassettype == "a\x96\x1d\x97\xc1+") {
    entity = fakeactor::spawndroneaitype("\x8ezH\xa8v\xe7" + sceneobjectassetname, spawnorigin, spawnangles);
  }

  if(!isDefined(entity)) {
    entity = sceneobjectdata function_4ed3e1e86d198215(spawnorigin, spawnangles);

    if(isDefined(entity)) {
      entity.team = "O\x15\x1b\xad\x9ff";
      entity.type = "\x1aW\xb6\xc2\xe6";
      entity.unittype = "\xb9\xdb6d-\xb2\xc9";
      sceneobjectdata.nosentient = 1;
    }
  }

  if(isDefined(entity)) {
    sceneobjectdata function_24bc84eb14f03239(entity);
    entity spawner::function_7137d77eb18cd383();

    if(sceneobjectdata function_f9c8fc6c9e8c2743() == ":\x06\x06\\?3\xf1\x1c" && !istrue(sceneobjectdata.nosentient)) {
      sceneobjectdata function_ace3a41d85ac4d91(entity);
    }

    entity useanimtree(sceneobjectdata.sceneobject function_d526e9fe4d60906e());
  }

  level utility::flag_clear("\x1f\\vI:\x1e5X\x19Y\x82to\x83\xf51x\xc2\xfb\x89\vX\n\xbc");
  return entity;
}

function private function_662fb6f853c58db7(entity) {
  sceneobjectdata = self;
  sceneobjectdata.nosentient = undefined;

  if(sceneobjectdata function_f9c8fc6c9e8c2743() == ":\x06\x06\\?3\xf1\x1c") {
    return istrue(entity.script_fakeactor);
  }

  return entity.classname == "7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6";
}

function private function_b5040526359a43fa(sceneplay, shotindex, objectindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    fakeactor = sceneobjectdata.entity;
    sceneobjectdata function_c6b13ff96d29a254(shotindex, 1);

    if(sceneobjectdata.sceneobject function_56a0ba4de8c3ba27() || sceneobjectdata.sceneobject function_2ff507604d454a48(shotindex)) {
      if(sceneobjectdata function_f9c8fc6c9e8c2743() == ":\x06\x06\\?3\xf1\x1c" && !istrue(sceneobjectdata.nosentient)) {
        sceneobjectdata function_ace3a41d85ac4d91();
        fakeactor fakeactor::set_use_pain(1);
      } else {
        sceneobjectdata thread function_d10a62ec1563c9ee();
      }
    } else {
      fakeactor fakeactor::function_9770699dda5e6226();
    }

    if(istrue(fakeactor.script_fakeactor)) {
      fakeactor fakeactor::take_control();
    }

    if(sceneobjectdata function_42c272013d0f1d7(shotindex)) {
      fakeactor val::set("U\x0fr\x8eS\x06u\xf4\xc4k", "s\xa5\xba-/\xb2a\xd8\x97\x1c\x19\x94", 1);
    }
  }
}

function private function_80955378201699b5(shotindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    fakeactor = sceneobjectdata.entity;

    if(istrue(fakeactor.script_fakeactor)) {
      fakeactor fakeactor::release_control();
    }

    if(sceneobjectdata function_42c272013d0f1d7(shotindex)) {
      fakeactor val::reset("U\x0fr\x8eS\x06u\xf4\xc4k", "s\xa5\xba-/\xb2a\xd8\x97\x1c\x19\x94");
    }
  }
}

function private function_81b4a31b15902594(newsceneroot) {
  sceneobjectdata = self;
  sceneobjectdata function_1c5da92a6419ce2();
}

function private function_ace3a41d85ac4d91(entity) {
  sceneobjectdata = self;

  if(!isDefined(entity)) {
    entity = sceneobjectdata.entity;
  }

  if(isDefined(entity)) {
    fakeactor = entity;

    if(!isDefined(level.fakeactor_spawn_func)) {
      fakeactor::fakeactor_spawner_init();
    }

    if(!istrue(fakeactor.script_fakeactor) && isDefined(level.fakeactor_spawn_func)) {
      fakeactor thread utility_sp::fakeactorspawn_setup();
    }
  }
}

function private function_d10a62ec1563c9ee() {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    fakeactor = sceneobjectdata.entity;

    if(!istrue(fakeactor.script_fakeactor)) {
      fakeactor fakeactor::function_e9d03fd33df0b54a();
    }
  }
}

function private function_f9c8fc6c9e8c2743() {
  sceneobjectdata = self;
  return sceneobjectdata.sceneobject.variant_object.fakeactortype ?? "\x81\x1b\x99\xd5e";
}

function private actor_spawn(spawnorigin, spawnangles) {
  sceneobjectdata = self;
  sceneobjectassettype = sceneobjectdata.sceneobject function_79d3a8ba86688a7e();
  sceneobjectassetname = sceneobjectdata.sceneobject function_cee8c56583dafef9();
  level utility::flag_set("\x1f\\vI:\x1e5X\x19Y\x82to\x83\xf51x\xc2\xfb\x89\vX\n\xbc");
  entity = undefined;

  if(isactorspawner(sceneobjectdata.spawner)) {
    var_beb63ce310f641de = isDefined(sceneobjectdata.spawner.script_stealthgroup) && utility::flag("\xeezq0\x97\x14\xae\x91\xfc\b\xc4W#\xdf\xb3") && !utility::flag("7tV\x16\xb1th_\x9b\x83\xbd\xa3\xd1ed");
    entity = sceneobjectdata.spawner stalingradspawn(var_beb63ce310f641de, 1);

    if(isDefined(entity)) {
      entity teleport(spawnorigin, spawnangles);
    }
  }

  if(!isDefined(entity)) {
    if(sceneobjectassettype == "a\x96\x1d\x97\xc1+") {
      entity = dospawnaitype("\x8ezH\xa8v\xe7" + sceneobjectassetname, spawnorigin, spawnangles, 1, 0, 1, 1);

      if(isDefined(entity)) {
        entity thread spawner::spawn_think();
      }
    } else if(sceneobjectassettype == "\xfa(4\xb7\x94\xc6\x95\xc6\xc3") {
      println("<dev string:xc7>" + sceneobjectdata.sceneobject function_17ebf11c9b4e19c0() + "<dev string:xf4>" + sceneobjectassetname + "<dev string:x57>");
    }
  }

  if(isDefined(entity)) {
    sceneobjectdata function_24bc84eb14f03239(entity);
    entity useanimtree(sceneobjectdata.sceneobject function_d526e9fe4d60906e());

    if(isDefined(level.stealth) && !isDefined(entity.stealth)) {
      stealthreactlevel = sceneobjectdata function_87e333b17bc90d1c();

      if(stealthreactlevel != "\f+x5" && isDefined(level.stealth.var_46abbff822c79e7e)) {
        stealth_group = "i\xc9\xc9\xc9g\xf6\v\f\xc2\xbc\xacs\x16\xd1Nt{(\xbc";

        if(isDefined(level.stealth.groupdata.groups)) {
          foreach(group in level.stealth.groupdata.groups) {
            stealth_group = groupname;
            break;
          }
        }

        if(!isDefined(entity.script_stealthgroup)) {
          entity.script_stealthgroup = stealth_group;
        }

        entity thread[[level.stealth.var_46abbff822c79e7e]]("\x8c\xed\xaf\xe6\x1d\xac\xc2\xc6th");
      }
    }
  }

  level utility::flag_clear("\x1f\\vI:\x1e5X\x19Y\x82to\x83\xf51x\xc2\xfb\x89\vX\n\xbc");
  return entity;
}

function private actor_setup(sceneplay) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    actor = sceneobjectdata.entity;

    if(isDefined(actor.stealth) && isDefined(level.stealth)) {
      if(sceneobjectdata function_320d239560f75112()) {
        sceneobjectdata thread function_4b77470656d3bbb();
      }

      stealthreactlevel = sceneobjectdata function_87e333b17bc90d1c();
      sceneobjectdata thread function_3cc145457f76af9d(stealthreactlevel);
    }
  }
}

function private function_dffc588c67f5ef3(entity) {
  sceneobjectdata = self;
  return isactor(entity) && isalive(entity);
}

function private actor_teleport(origin, angles) {
  sceneobjectdata = self;
  sceneobjectdata.entity forceteleport(origin, angles);
  sceneobjectdata.entity dontinterpolate();
}

function private function_26644d41f4a50e8(alignmentinfo, shotindex) {
  sceneobjectdata = self;

  if(!isDefined(shotindex)) {
    shotindex = sceneobjectdata.sceneplay.shotinit;
  }

  actor = sceneobjectdata.entity;
  deltaanimations = sceneobjectdata function_bdca3d3bf269f17b(shotindex);

  if(deltaanimations.size != 0 && isent(actor)) {
    animasset = deltaanimations[0];
    sceneobjectdata function_f74488136b58dfd8();
    origin = getstartorigin(alignmentinfo.origin, alignmentinfo.angles, animasset);
    angles = getstartangles(alignmentinfo.origin, alignmentinfo.angles, animasset);
    actor thread anim_sp::ai_anim_first_frame(animasset, actor.animname);

    scene_debug::object_event(sceneobjectdata, "<dev string:xfd>" + getxhashsourcename(getanimname(animasset)), origin, angles);

    scene_debug::object_event(sceneobjectdata, "<dev string:x10d>" + getxhashsourcename(getanimname(animasset)), alignmentinfo.origin, alignmentinfo.angles);

    actor utility::delaycallendon(level.framedurationseconds, "\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela", &forceteleport, origin, angles);
    actor utility::delaycallendon(level.framedurationseconds, "\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela", &setanimtime, animasset, 0);
    actor utility::delaycallendon(level.framedurationseconds, "\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela", &setanimrate, animasset, 0);
  }
}

function private function_e5e827d040b96c5f(animrate) {
  sceneobjectdata = self;
  entity = sceneobjectdata function_a609347bd1d1ba66();

  if(isDefined(entity) && isDefined(sceneobjectdata.activeanimation)) {
    sceneobjectdata function_8f9e135b254463bf("\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela", &setanimrate, sceneobjectdata.activeanimation, animrate);
  }
}

function private actor_set_anim_time(animasset, timefrac) {
  sceneobjectdata = self;
  entity = sceneobjectdata function_a609347bd1d1ba66();

  if(isDefined(entity)) {
    entity notify("r-\x99\x1a\x90\x04\xe8\x03)\xe7ohd\xfc\x13>\x83j\xbe");
    entity dontinterpolate();
    sceneobjectdata function_8f9e135b254463bf("\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela", &setanimtime, animasset, timefrac);
  }
}

function private function_1e7f279f3ecb1f64(lerptime, velocity) {
  sceneobjectdata = self;

  if(!isDefined(lerptime)) {
    lerptime = 0;
  }

  var_571b029dda9b6a69 = velocity ?? (0, 0, 0);
  entity = sceneobjectdata function_a609347bd1d1ba66();

  if(isDefined(entity)) {
    sceneobjectdata function_8f9e135b254463bf("\x1bWh\xcf{\xaf\xb3\xea\xe7\xb9\x0fk\x8ela", &function_42b8aa85d6c43c1c, lerptime, velocity, undefined, 1);
  }
}

function private actor_set_anim_playing(animasset) {
  sceneobjectdata = self;
  sceneobjectdata notify("\x8aE\xea\x85T~)\x94G\xcffv\x89c\x9fz\xef\xba\xd5\xc81\xe2");
  sceneobjectdata endon("\x8aE\xea\x85T~)\x94G\xcffv\x89c\x9fz\xef\xba\xd5\xc81\xe2");
  sceneobjectdata endon("\xe6\xb1\xacs\xac\xd7\xcd\xd1\xdb\xc1");
  entity = sceneobjectdata function_a609347bd1d1ba66();

  if(!isDefined(entity)) {
    return;
  }

  codescripted = undefined;

  if(!isDefined(sceneobjectdata.activeanimationplaying)) {
    entity waittill("~w\xab\x8c\xc7\t,\xe2\x92\xf3\x1b\x82\x04", codescripted);
  }

  if(isDefined(codescripted[",U\xdf."]) && codescripted[",U\xdf."] == animasset) {
    sceneobjectdata.activeanimationplaying = animasset;
    sceneobjectdata notify(">\xcb\xf9m]\xa5\xedtDo\xab\xc8`\xc9E\x9b\xeb\x82", animasset);
  }
}

function private function_1dd2a3a5cb965926(sceneplay, shotindex, objectindex) {
  sceneobjectdata = self;
  sceneobjectdata function_2cbc461f76ad095b(sceneplay, shotindex, objectindex);
  sceneobjectdata function_c6b13ff96d29a254(shotindex, 0);
}

function private function_5d4919ad2db4b50(shotindex, cameraanimation, shotanimations) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    if(sceneobjectdata.sceneobject function_56a0ba4de8c3ba27() || sceneobjectdata.sceneobject function_2ff507604d454a48(shotindex)) {
      deathanim = sceneobjectdata.sceneobject function_833c72bb93a9192(shotindex);
      sceneobjectdata.entity.allowdeath = !isDefined(deathanim);
    }
  }

  sceneobjectdata object_lookat_target(shotindex, 1);
}

function private function_e4f47bdc985debf(shotindex) {
  sceneobjectdata = self;
  reachtype = sceneobjectdata.sceneobject function_141932c1cd44be08(shotindex);
  return reachtype == "\xfeX\xcc\xe1\x0f\x10\x97\xf6";
}

function private function_a2844a0acc2e1001(shotindex) {
  sceneobjectdata = self;

  if(isDefined(sceneobjectdata.entity)) {
    actor = sceneobjectdata.entity;
    demeanorend = sceneobjectdata.sceneobject function_47d791feb87e9a9(shotindex);

    if(demeanorend != "\x11\x8a\xc8\n\xaa\x98*") {
      actor val::set("=\xdf\xdc/R_Lz(", "(\x15\xda\x106\xed_\x1a", demeanorend);
    }

    sceneobjectdata object_lookat_target(shotindex, 0);
    stanceend = sceneobjectdata.sceneobject function_99b0f6e3478fece2(shotindex);
    actor asm_bb::bb_requeststance(stanceend);

    if(sceneobjectdata function_f151919ab3a11d74()) {
      actor setgoalpos(actor.origin);
    }

    if(sceneobjectdata function_89985920e62b7262()) {
      actor pausepath(randomfloatrange(2, 3));
    }

    if(sceneobjectdata function_42c272013d0f1d7(shotindex)) {
      actor val::reset("U\x0fr\x8eS\x06u\xf4\xc4k", "s\xa5\xba-/\xb2a\xd8\x97\x1c\x19\x94");
    }
  }
}

function private function_ff348230ae014f9c() {
  sceneobjectdata = self;
  return isalive(sceneobjectdata.entity) && !sceneobjectdata.entity utility::doinglongdeath();
}

function private actor_kill(point, attacker, inflictor, meansofdeath, objweapon) {
  sceneobjectdata = self;

  if(isalive(sceneobjectdata.entity)) {
    sceneobjectdata.entity.allowdeath = 1;
    sceneobjectdata.entity startragdoll();
    sceneobjectdata.entity kill(point, attacker, inflictor, meansofdeath, objweapon);
  }
}

function private actor_cleanup(newsceneroot) {
  sceneobjectdata = self;
  sceneobjectdata function_1c5da92a6419ce2();
}

function private function_320d239560f75112() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.lookatstealth);
}

function private function_89985920e62b7262() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.delaymovementatend);
}

function private function_f151919ab3a11d74() {
  sceneobjectdata = self;
  return istrue(sceneobjectdata.sceneobject.variant_object.var_dcb6d118bdc542ee);
}