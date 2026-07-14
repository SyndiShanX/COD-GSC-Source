/******************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\game\sp\bullet_cam.gsc
******************************************/

#using script_31613e9096b20af3;
#using scripts\asm\asm;
#using scripts\engine\utility;
#namespace bullet_cam;

function autoexec init() {
  precachemodel("\xf8H\xc4G\x05\x9f\xfePKv\xd7\x1f\xa4d\xc9a\x7f\xc4x%\x10C\xffP.~\x9c\x89");
  level._effect["}r\xeex\x9a9_IP+\\\x92\xb8\xd7z{\xe3L\xde\x99\xb6[\x19"] = loadfxasset("\x12F\x87\xb3\xdf\xe7\xa7\xe0\x16\xeaV\xba\x86\xa7\xde\x93~\xeb7\x9d\xf4q\xaca\x01R6\xfe\xcbwvn\xf9\x99G?W\xb8%\x85\x80\x13\xcf\x89\x9b_\xd0\n \xc6\x17");
  precachemodel("\xbd\x99\x99CX7F\xf5\x8c\x1a\xd7wk\xaf\x1d\xa1'{\xdd\xa5n;\xeb[\xe6Z3V\xbe;\x06");
  level._effect["}r\xeex\x9a9_IP+\\\x92\xb8\xd7z{\xe3L\xde\x99\xb6[\x19"] = loadfxasset("\x12F\x87\xb3\xdf\xe7\xa7\xe0\x16\xeaV\xba\x86\xa7\xde\x93~\xeb7\x9d\xf4q\xaca\x01R6\xfe\xcbwvn\xf9\x99G?W\xb8%\x85\x80\x13\xcf\x89\x9b_\xd0\n \xc6\x17");
  initbulletcam();
}

function private initbulletcam() {
  level.bulletcam = spawnStruct();
  level.bulletcam.presetsettingsfuncs = [];
  function_4a225d73bc88a7dd("\xc7\x1bSd\xd4qA\xceE'r\xd4\\", &function_9d83c5c1e43c3984);
  function_4a225d73bc88a7dd("\xe0UZ,P\xa2sfpC\xa2\xd9\x9cX}o\xe8\vy\xc4Q\xe1", &function_411934b82a7eebfa);
  function_4a225d73bc88a7dd("!\xa0\x91\x1d\xfe\xab\x0f\xdd\x05\x86\x05\xff:$\x0fp\x18\xa5\x06\x1c\x93", &function_2bbaf5d187f43c8d);
}

function function_4b889ab270172d5c(presetname) {
  createsettingsfunc = level.bulletcam.presetsettingsfuncs[presetname];

  if(isDefined(createsettingsfunc)) {
    return [[createsettingsfunc]]();
  }

  return undefined;
}

function function_4a225d73bc88a7dd(presetname, var_80b428e8e11f2356) {
  assert(isfunction(var_80b428e8e11f2356), "<dev string:x24>");
  level.bulletcam.presetsettingsfuncs[presetname] = var_80b428e8e11f2356;
}

function enablebulletcam(var_c0fc2d39074d123a = ["\x0e_\xfe\x8c\xf4\x06\x9c_\xf4#\xcf~Z\xab\xb4\xd8\xff\x03C\xc5'\x880\x8f", "9\xdf\"\x1f!\x04%\x1c\x13\xdb\xe0\xa1\x1d\x05B7\x98\x15\x87q~\x99\x98\xe4\xeb"], bulletmodeloverrides, var_3a7308ff2deb5a5e, var_4415ba6ea03bb3d3, modifydamagedatafunc, scriptedimpact = 0) {
  if(!isarray(var_c0fc2d39074d123a)) {
    var_c0fc2d39074d123a = [var_c0fc2d39074d123a];
  }

  victim = self;
  assert(isactor(victim));
  function_e20d41b82743db00(victim, var_c0fc2d39074d123a, var_4415ba6ea03bb3d3, bulletmodeloverrides, var_3a7308ff2deb5a5e, modifydamagedatafunc);
  function_5d78525097a7e91b(victim, scriptedimpact);
  victim function_31d1e5fcf29613a7(&bulletcamdamagecallback);
}

function runbulletcam(player, sourcepoint, impactpoint, bulletcamsettings, bulletmodeloverride) {
  assert(isPlayer(player));
  assert(isvector(sourcepoint));
  assert(isvector(impactpoint));
  bulletcamsettings = isDefined(bulletcamsettings) ? bulletcamsettings : function_ecf512de17d0b009();

  if(isDefined(bulletmodeloverride)) {
    namespace_a6b6c9ee485cdfa6::function_9ce2a9da8dbdc8fd(bulletcamsettings, bulletmodeloverride);
  }

  bulletcaminstance = namespace_a6b6c9ee485cdfa6::function_969456915756883e(player, bulletcamsettings, sourcepoint, impactpoint);
  namespace_a6b6c9ee485cdfa6::function_102b4429964314d7(bulletcaminstance);
}

function private function_9d83c5c1e43c3984() {
  bulletcamsettings = function_ecf512de17d0b009();
  function_ef66eed9d7f3e69a(bulletcamsettings, "}r\xeex\x9a9_IP+\\\x92\xb8\xd7z{\xe3L\xde\x99\xb6[\x19", 640000);
  return bulletcamsettings;
}

function function_ecf512de17d0b009(var_c65addeb6c03c91b, var_a05172b90d2dce22, var_489e34de0fa5b29, var_eaca4549ca927385, var_fadee27b8d7cfdea, var_c5c51e7d32ad2329, var_3437dd6b892d12ee) {
  settings = namespace_a6b6c9ee485cdfa6::function_fdb9691f0fc848c8();
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x85J\xf8\x94\xd4\x1b\x8a}r\x83\xda", undefined, undefined, undefined);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V", undefined, undefined, 0.2);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS", 0.5, 0.1, undefined);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32", 0.5, 0, 1);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "nG\vg\xca\xf5i\xad\x1cXl\xa3", 1, 0.5, 0.15);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x17\xad\v|\x1ax$\x87\x9eY\xcc\xbc\xff\xff", 0.2, 0.5, 0.5);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\t\xe6,\xd3\xbc:\x9f=Z\x0f\x9f\xc4\x89", undefined, 0.1, undefined);
  namespace_a6b6c9ee485cdfa6::function_9d130294613a86ff(settings, var_a05172b90d2dce22, var_489e34de0fa5b29, var_eaca4549ca927385, var_fadee27b8d7cfdea, var_c5c51e7d32ad2329, var_3437dd6b892d12ee);
  namespace_a6b6c9ee485cdfa6::setstagefunctions(settings, &function_b5272e1188bc0255, &function_f8622818f1b8e814, &function_2c753da713fa82ab, &function_d4862f73bc3ac2b7, &function_2ebd25a2eae212b0, &function_9883d03142157ef, &function_ff14e746fc6e13dc);
  return settings;
}

function function_b5272e1188bc0255(bulletcaminstance) {}

function function_f8622818f1b8e814(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  bulletdestination = namespace_a6b6c9ee485cdfa6::function_228f6dd5def652eb(bulletcaminstance);
  bullettraveltime = namespace_a6b6c9ee485cdfa6::function_dcac3d77fefa9d11(bulletcaminstance);
  namespace_a6b6c9ee485cdfa6::function_22edfc337a9b4cb1(bulletcaminstance, bulletdestination, bullettraveltime);
  bulletrotationvelocity = namespace_a6b6c9ee485cdfa6::function_51d921ad64667303(bulletcamsettings);
  namespace_a6b6c9ee485cdfa6::rotatefakebullet(bulletcaminstance, bulletrotationvelocity, 9999);
}

function function_2c753da713fa82ab(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  var_17e0a5712be67f41 = namespace_a6b6c9ee485cdfa6::function_dcac3d77fefa9d11(bulletcaminstance);
  timeelapsed = namespace_a6b6c9ee485cdfa6::function_8ab62bc84e4c81b6(bulletcamsettings, "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V");
  traveltimeremaining = var_17e0a5712be67f41 - timeelapsed;
  namespace_a6b6c9ee485cdfa6::function_707aaccda66df52a(bulletcamsettings, "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS", traveltimeremaining);
}

function function_d4862f73bc3ac2b7(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  bulletdestination = namespace_a6b6c9ee485cdfa6::function_6ddd5f71d9cccc8(bulletcaminstance);
  bullettraveltime = namespace_a6b6c9ee485cdfa6::function_8ab62bc84e4c81b6(bulletcamsettings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32");
  bullettraveltime += level.framedurationseconds;
  var_807baefe7397e4ee = bullettraveltime;
  namespace_a6b6c9ee485cdfa6::function_22edfc337a9b4cb1(bulletcaminstance, bulletdestination, bullettraveltime, 0, var_807baefe7397e4ee);
  bulletrotationvelocity = namespace_a6b6c9ee485cdfa6::function_43c5bac9b5e060d6(bulletcamsettings);
  namespace_a6b6c9ee485cdfa6::rotatefakebullet(bulletcaminstance, bulletrotationvelocity, 9999);
  waitframe();
}

function function_2ebd25a2eae212b0(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  namespace_a6b6c9ee485cdfa6::function_dac59261ea3ac250(bulletcaminstance, 1);
  var_f9ffe53e9894c019 = namespace_a6b6c9ee485cdfa6::function_86b7e09ed5024be0(bulletcaminstance);
  var_c46824a12b54c584 = namespace_a6b6c9ee485cdfa6::function_8ab62bc84e4c81b6(bulletcamsettings, "nG\vg\xca\xf5i\xad\x1cXl\xa3");
  namespace_a6b6c9ee485cdfa6::function_1bdb689076d3fe5d(bulletcaminstance, var_f9ffe53e9894c019, var_c46824a12b54c584);
}

function function_9883d03142157ef(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  var_f9ffe53e9894c019 = namespace_a6b6c9ee485cdfa6::function_79af0731522aa95e(bulletcaminstance);
  var_c46824a12b54c584 = namespace_a6b6c9ee485cdfa6::function_8ab62bc84e4c81b6(bulletcamsettings, "\x17\xad\v|\x1ax$\x87\x9eY\xcc\xbc\xff\xff");
  namespace_a6b6c9ee485cdfa6::function_1bdb689076d3fe5d(bulletcaminstance, var_f9ffe53e9894c019, var_c46824a12b54c584);
}

function function_ff14e746fc6e13dc(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  namespace_a6b6c9ee485cdfa6::function_837976902b3dd375(bulletcamsettings, "\t\xe6,\xd3\xbc:\x9f=Z\x0f\x9f\xc4\x89", 1);
}

function private function_2bbaf5d187f43c8d() {
  bulletcamsettings = function_b4d9c8c79818e475();
  function_ef66eed9d7f3e69a(bulletcamsettings, "}r\xeex\x9a9_IP+\\\x92\xb8\xd7z{\xe3L\xde\x99\xb6[\x19", 640000);
  return bulletcamsettings;
}

function private function_b4d9c8c79818e475(var_e5d2eec8434b584d = 0) {
  settings = namespace_a6b6c9ee485cdfa6::function_fdb9691f0fc848c8();
  settings.startpointdistance = 30;
  settings.bulletrotationvelocity = (360, 0, 0);
  settings.var_500a9b65098e00c0 = (120, 0, 0);
  namespace_a6b6c9ee485cdfa6::function_c7dfbaaecc949142(settings, (-5, 5, 0));
  namespace_a6b6c9ee485cdfa6::function_b3acbce7f757e97d(settings, (0, -20, 0));
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x85J\xf8\x94\xd4\x1b\x8a}r\x83\xda", undefined, undefined, undefined);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V", undefined, undefined, 0.2);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS", 0.5, 0.1, undefined);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32", 0.5, 0, 1);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "nG\vg\xca\xf5i\xad\x1cXl\xa3", 1, 0.5, 0.15);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x17\xad\v|\x1ax$\x87\x9eY\xcc\xbc\xff\xff", 0.2, 0.5, 0.5);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\t\xe6,\xd3\xbc:\x9f=Z\x0f\x9f\xc4\x89", undefined, 0.1, undefined);
  namespace_a6b6c9ee485cdfa6::setstagefunctions(settings, &function_b5272e1188bc0255, &function_f8622818f1b8e814, &function_2c753da713fa82ab, &function_d4862f73bc3ac2b7, &function_2ebd25a2eae212b0, &function_9883d03142157ef, &function_ff14e746fc6e13dc);
  namespace_a6b6c9ee485cdfa6::registerstagecallbackfunction(settings, "\x85J\xf8\x94\xd4\x1b\x8a}r\x83\xda", &function_a955a3cbb3841c5d);

  if(var_e5d2eec8434b584d) {
    namespace_a6b6c9ee485cdfa6::setstagefunction(settings, "\x85J\xf8\x94\xd4\x1b\x8a}r\x83\xda", &function_b97b34f318613393);
    namespace_a6b6c9ee485cdfa6::setstagefunction(settings, "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V", &function_caf0a665e89699da);
    namespace_a6b6c9ee485cdfa6::setstagefunction(settings, "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS", &function_eefc472017d9d931);
    namespace_a6b6c9ee485cdfa6::setstagefunction(settings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32", &function_7b037f91a600630d);
    function_78b170cc1604d173(settings, 40, 15, 200);
  }

  return settings;
}

function function_78b170cc1604d173(bulletcamsettings, var_be49bbf3fc319741, var_b88e6c73379a5641, maxtraveldistance) {
  bulletcamsettings.var_c2b8bc04ba90bff3 = var_be49bbf3fc319741;
  bulletcamsettings.var_d9aeb6eff27cddbb = var_b88e6c73379a5641;
  bulletcamsettings.throwingknife_maxtraveldistance = maxtraveldistance;
}

function function_702d9212d16cfce1(bulletcaminstance, var_bbe3ec31b9e5d43a) {
  bulletcaminstance.var_11019a710913b628 = var_bbe3ec31b9e5d43a;
}

function function_a955a3cbb3841c5d(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  fakemodel = namespace_a6b6c9ee485cdfa6::function_a190f68884ced31d(bulletcaminstance);
  slowmorotationvelocity = namespace_a6b6c9ee485cdfa6::function_51d921ad64667303(bulletcamsettings);
  slowmoduration = namespace_a6b6c9ee485cdfa6::function_dcac3d77fefa9d11(bulletcaminstance);
  var_8e27268a8a42ddc8 = namespace_a6b6c9ee485cdfa6::function_43c5bac9b5e060d6(bulletcamsettings);
  var_95a185e5c57ea721 = namespace_a6b6c9ee485cdfa6::function_8ab62bc84e4c81b6(bulletcamsettings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32") + level.framedurationseconds;
  pitchdelta = slowmorotationvelocity[0] * slowmoduration + var_8e27268a8a42ddc8[0] * var_95a185e5c57ea721;
  pitchdelta = angleclamp(pitchdelta);
  desiredstartpitch = angleclamp(90 - pitchdelta);
  fakemodel.angles = (desiredstartpitch, fakemodel.angles[1], fakemodel.angles[2]);
}

function function_b97b34f318613393(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  startpos = namespace_a6b6c9ee485cdfa6::instance_getstartpos(bulletcaminstance);
  impactpos = namespace_a6b6c9ee485cdfa6::function_641cfc0959206632(bulletcaminstance);
  traveldistance = length(impactpos - startpos);
  maxtraveldistance = bulletcamsettings.throwingknife_maxtraveldistance;

  if(traveldistance > maxtraveldistance) {
    sourcepos = namespace_a6b6c9ee485cdfa6::function_73b5e06b709251a7(bulletcaminstance);
    totaltraveldistance = length(impactpos - sourcepos);
    namespace_a6b6c9ee485cdfa6::function_8faf59abdb3c376b(bulletcamsettings, totaltraveldistance - maxtraveldistance);
    namespace_a6b6c9ee485cdfa6::function_ec9b012a6597699e(bulletcaminstance);
    startpos = namespace_a6b6c9ee485cdfa6::instance_getstartpos(bulletcaminstance);
    namespace_a6b6c9ee485cdfa6::function_6114e91459046d30(bulletcaminstance, startpos);
  }

  traveldirection = namespace_a6b6c9ee485cdfa6::function_2173789a4f0a7aab(bulletcaminstance);
  traveldirectionignoreheight = (traveldirection[0], traveldirection[1], 0);
  var_be49bbf3fc319741 = bulletcamsettings.var_c2b8bc04ba90bff3;
  var_b88e6c73379a5641 = bulletcamsettings.var_d9aeb6eff27cddbb;
  var_4630e19441633928 = traveldirectionignoreheight * var_be49bbf3fc319741;
  var_4630e19441633928 += (0, 0, var_b88e6c73379a5641);
  var_bbe3ec31b9e5d43a = startpos + var_4630e19441633928;
  function_702d9212d16cfce1(bulletcaminstance, var_bbe3ec31b9e5d43a);
}

function function_caf0a665e89699da(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  var_dd8064852e25c7f6 = namespace_a6b6c9ee485cdfa6::function_b94938c064d20ad0(bulletcaminstance);
  impacttriggerpos = namespace_a6b6c9ee485cdfa6::function_6ddd5f71d9cccc8(bulletcaminstance);
  controlpoint = bulletcaminstance.var_11019a710913b628;
  namespace_a6b6c9ee485cdfa6::function_51758c766640861f(bulletcaminstance, impacttriggerpos, controlpoint, var_dd8064852e25c7f6);
  rotationvelocity = namespace_a6b6c9ee485cdfa6::function_51d921ad64667303(bulletcamsettings);
  namespace_a6b6c9ee485cdfa6::rotatefakebullet(bulletcaminstance, rotationvelocity, 9999);
}

function function_eefc472017d9d931(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  var_1afc6f22928dfe65 = namespace_a6b6c9ee485cdfa6::function_dcac3d77fefa9d11(bulletcaminstance);
  var_3afc5a1a731f645f = namespace_a6b6c9ee485cdfa6::function_8ab62bc84e4c81b6(bulletcamsettings, "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V");
  slowmoduration = var_1afc6f22928dfe65 - var_3afc5a1a731f645f;
  namespace_a6b6c9ee485cdfa6::function_707aaccda66df52a(bulletcamsettings, "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS", slowmoduration);
}

function function_7b037f91a600630d(bulletcaminstance) {
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  bulletrotationvelocity = namespace_a6b6c9ee485cdfa6::function_43c5bac9b5e060d6(bulletcamsettings);
  namespace_a6b6c9ee485cdfa6::rotatefakebullet(bulletcaminstance, bulletrotationvelocity, 9999);
  var_95a185e5c57ea721 = namespace_a6b6c9ee485cdfa6::function_b1f3db1d76c3a819(bulletcaminstance);
  namespace_a6b6c9ee485cdfa6::function_707aaccda66df52a(bulletcamsettings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32", var_95a185e5c57ea721);
}

function function_1bb5c7933457df2b(player, victim, damage, mod, sourcepoint, impactpoint, objweapon, hitloc) {
  cacheddamagedata = spawnStruct();
  cacheddamagedata.player = player;
  cacheddamagedata.victim = victim;
  cacheddamagedata.damage = damage;
  cacheddamagedata.mod = mod;
  cacheddamagedata.sourcepoint = sourcepoint;
  cacheddamagedata.impactpoint = impactpoint;
  cacheddamagedata.objweapon = objweapon;
  cacheddamagedata.hitloc = hitloc;
  return cacheddamagedata;
}

function private function_64dc55da844b3af7(bulletcaminstance) {
  if(isstruct(bulletcaminstance)) {
    cacheddamagedata = bulletcaminstance.var_43f5bcf766e41f2;

    if(isstruct(cacheddamagedata)) {
      return cacheddamagedata;
    }
  }

  assertmsg("<dev string:x8c>");
  return spawnStruct();
}

function function_b389b493292b8fc4(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x14c>");
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  bulletcamsettings.var_dd16060dbd774e02 = undefined;
}

function function_899bebccbffbbee0(bulletcaminstance) {
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);
  return cacheddamagedata.player;
}

function function_c414133d4c023245(bulletcaminstance) {
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);
  return cacheddamagedata.victim;
}

function function_41d57e97df0a4314(bulletcaminstance) {
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);
  return cacheddamagedata.damage;
}

function function_7d31ab7025aa68fe(bulletcaminstance) {
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);
  return cacheddamagedata.mod;
}

function function_28ffea110787ae19(bulletcaminstance) {
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);
  return cacheddamagedata.impactpoint;
}

function function_137435e45cfb65ed(bulletcaminstance) {
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);
  return cacheddamagedata.objweapon;
}

function function_386819db03437d43(bulletcaminstance) {
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);
  return cacheddamagedata.hitloc;
}

function private bulletcamdamagecallback(einflictor, eattacker, idamage, idflags, smeansofdeath, objweapon, vpoint, vdir, shitloc, timeoffset, modelindex, partname) {
  victim = self;
  bulletcamdamagetype = function_5b2596db249dd09f(smeansofdeath, objweapon);
  var_b39c4e41f7bdd514 = function_258a8074d053609(victim, bulletcamdamagetype);
  bulletcamsettings = var_b39c4e41f7bdd514 ?? function_711023ef5571ffa(bulletcamdamagetype);

  if(!isDefined(bulletcamsettings)) {
    return idamage;
  }

  var_708b2d51394b6554 = function_709f7501627545fa(victim, bulletcamdamagetype);

  if(isDefined(var_708b2d51394b6554)) {
    bulletcamsettings.var_a36404f2feec5955 = var_708b2d51394b6554;
  }

  bulletmodeloverride = function_e2b6a50159ffc6cb(victim, bulletcamdamagetype);

  if(isDefined(bulletmodeloverride)) {
    namespace_a6b6c9ee485cdfa6::function_9ce2a9da8dbdc8fd(bulletcamsettings, bulletmodeloverride);
  } else if(bulletcamdamagetype == "\x8c+\x80\xb6oE\x16C\x9b\x1b\xadW+C\xb5\x0f\aS\xe0\x7f\xc7z(jr\x81") {
    throwingknifemodel = getweaponmodel(objweapon);
    namespace_a6b6c9ee485cdfa6::function_9ce2a9da8dbdc8fd(bulletcamsettings, throwingknifemodel);
  }

  var_c0fc2d39074d123a = function_4590058509a134b6(victim);
  shouldtrigger = victim function_746ed0eb64ab8679(bulletcamsettings, bulletcamdamagetype, var_c0fc2d39074d123a, eattacker, victim, idamage);

  if(!shouldtrigger) {
    return idamage;
  }

  cacheddamagedata = function_1bb5c7933457df2b(eattacker, victim, idamage, smeansofdeath, eattacker getEye(), vpoint, objweapon, shitloc);
  modifydamagedatafunc = function_26fd2788f5d340cf(victim);

  if(isfunction(modifydamagedatafunc)) {
    [[modifydamagedatafunc]](cacheddamagedata);
  }

  assert(isDefined(cacheddamagedata.impactpoint));
  eattacker thread function_bbdc5a04f5f7b0c2(bulletcamsettings, cacheddamagedata);
  return 0;
}

function private function_746ed0eb64ab8679(bulletcamsettings, bulletcamdamagetype, var_c0fc2d39074d123a, attacker, victim, damageamount) {
  victim = self;
  var_b45f8bebfef9526f = function_4590058509a134b6(victim);
  var_1b0b11293913b9a0 = isPlayer(attacker) && damageamount >= victim.health;

  if(!var_1b0b11293913b9a0) {
    return false;
  }

  var_6a26c8e9c9d8b1d5 = function_9258b4e8a2804c6b(var_b45f8bebfef9526f, bulletcamdamagetype);

  if(!var_6a26c8e9c9d8b1d5) {
    return false;
  }

  var_d2bc4d1515e6a940 = function_3bd9827ec5ba9c4c(bulletcamsettings, attacker, victim);

  if(var_d2bc4d1515e6a940) {
    return false;
  }

  var_8e7c06ed689f8085 = function_8e7c06ed689f8085(bulletcamsettings, attacker, victim);

  if(var_8e7c06ed689f8085) {
    return false;
  }

  return true;
}

function private function_bbdc5a04f5f7b0c2(bulletcamsettings, cacheddamagedata) {
  player = self;
  player endon("\x1e\xfd\xd1\xa2\a");
  namespace_a6b6c9ee485cdfa6::function_9d130294613a86ff(bulletcamsettings, &function_4acd4f5562d2557b, undefined, undefined, undefined, &function_aa98927fb7c739ca, undefined, &function_ec86c1e62483af4e);
  bulletcaminstance = namespace_a6b6c9ee485cdfa6::function_969456915756883e(player, bulletcamsettings, cacheddamagedata.sourcepoint, cacheddamagedata.impactpoint);
  bulletcaminstance.var_43f5bcf766e41f2 = cacheddamagedata;
  namespace_a6b6c9ee485cdfa6::function_102b4429964314d7(bulletcaminstance);
}

function private function_bd31636d4d2ea64c(bulletcaminstance) {
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);

  if(!isstruct(cacheddamagedata)) {
    return undefined;
  }

  return function_5b2596db249dd09f(cacheddamagedata.mod, cacheddamagedata.objweapon);
}

function private function_5b2596db249dd09f(smeansofdeath, objweapon) {
  switch (objweapon.classname) {
    case #"hash_690c0d6a821b42e":
    case #"hash_23209741b93850b5":
      return "yJ\x9a\xae\x97@\x8f$\xbe\xf4to\xc8X%7\x16\xeb\x87";
  }

  if(smeansofdeath == "\xd5_\xc1\xe1U\xf4\x06m\x0e\t\xc6e\xf4\x91\xdc\xd4\xf7") {
    return "9\xdf\"\x1f!\x04%\x1c\x13\xdb\xe0\xa1\x1d\x05B7\x98\x15\x87q~\x99\x98\xe4\xeb";
  } else if(smeansofdeath == "\xac6\xc1;\x9c|\xd5]5\x80\xcb~\xb5\xe7\xb4\xa1") {
    return "\x0e_\xfe\x8c\xf4\x06\x9c_\xf4#\xcf~Z\xab\xb4\xd8\xff\x03C\xc5'\x880\x8f";
  } else if(smeansofdeath == "M\x81\xaf\xee\xc9\xcfD\xef\x91J" && objweapon.classname == "VK\n\xdb\xd0(O'T]\x12K\x8e") {
    return "\x8c+\x80\xb6oE\x16C\x9b\x1b\xadW+C\xb5\x0f\aS\xe0\x7f\xc7z(jr\x81";
  }

  return "\xc9\xa9\xb0%\xe7F\xbcVf\x06\xc5w\n\xb4\xb5\xddh\x89\x8c";
}

function private function_711023ef5571ffa(damagetype) {
  if(damagetype == "9\xdf\"\x1f!\x04%\x1c\x13\xdb\xe0\xa1\x1d\x05B7\x98\x15\x87q~\x99\x98\xe4\xeb" || damagetype == "\x0e_\xfe\x8c\xf4\x06\x9c_\xf4#\xcf~Z\xab\xb4\xd8\xff\x03C\xc5'\x880\x8f") {
    return function_4b889ab270172d5c("\xc7\x1bSd\xd4qA\xceE'r\xd4\\");
  }

  if(damagetype == "yJ\x9a\xae\x97@\x8f$\xbe\xf4to\xc8X%7\x16\xeb\x87") {
    return function_4b889ab270172d5c("\xe0UZ,P\xa2sfpC\xa2\xd9\x9cX}o\xe8\vy\xc4Q\xe1");
  }

  if(damagetype == "\x8c+\x80\xb6oE\x16C\x9b\x1b\xadW+C\xb5\x0f\aS\xe0\x7f\xc7z(jr\x81") {
    return function_4b889ab270172d5c("!\xa0\x91\x1d\xfe\xab\x0f\xdd\x05\x86\x05\xff:$\x0fp\x18\xa5\x06\x1c\x93");
  }

  return undefined;
}

function private function_9258b4e8a2804c6b(var_6fc617c16dfd6d3c, damagetype) {
  if(damagetype == "\xc9\xa9\xb0%\xe7F\xbcVf\x06\xc5w\n\xb4\xb5\xddh\x89\x8c") {
    return 0;
  }

  if(arraycontains(var_6fc617c16dfd6d3c, "\xf4\xdan\x01\xbdo7@\xf5\xc5oR\r\xac\x1b")) {
    return 1;
  }

  return arraycontains(var_6fc617c16dfd6d3c, damagetype);
}

function function_5d78525097a7e91b(victim, isenabled) {
  if(isactor(victim)) {
    victim.bulletcamscriptedimpact = isenabled;
  }
}

function function_f3ddaf26aaa9c6c8(bulletcaminstance) {
  victim = function_c414133d4c023245(bulletcaminstance);

  if(!isactor(victim) || !isalive(victim)) {
    return;
  }

  victim aisetanimrate(victim asm::asm_getroot(), 1);
  victim setCanDamage(1);
  function_2a47bd7b66d8193e(bulletcaminstance);
}

function private function_5f10464bb6d55c8f(victim) {
  scriptedimpact = isactor(victim) ? victim.bulletcamscriptedimpact : undefined;
  return istrue(scriptedimpact);
}

function private function_3bd9827ec5ba9c4c(bulletcamsettings, eattacker, victim) {
  var_d3e7c3ccfe6e7921 = distancesquared(eattacker getorigin(), victim getorigin());
  return var_d3e7c3ccfe6e7921 < bulletcamsettings.var_a36404f2feec5955;
}

function private function_8e7c06ed689f8085(bulletcamsettings, attacker, victim) {
  flag_allowed = function_7e07f5c0c78b8066(victim);

  if(isDefined(flag_allowed) && utility::flag(flag_allowed)) {
    return false;
  }

  return true;
}

function private function_4acd4f5562d2557b(bulletcaminstance) {
  cacheddamagedata = bulletcaminstance.var_43f5bcf766e41f2;
  victim = cacheddamagedata.victim;
  victim aisetanimrate(victim asm::asm_getroot(), 0);
  fixupimpactpoint(cacheddamagedata);
  victim setCanDamage(0);
  victim function_31d1e5fcf29613a7(undefined);
  victim utility::ent_flag_set("XB\x9cq\xd3k\x06]\r\x80\x8cr'\x85\x81X(");
  isthrowingknifecam = function_bd31636d4d2ea64c(bulletcaminstance) == "\x8c+\x80\xb6oE\x16C\x9b\x1b\xadW+C\xb5\x0f\aS\xe0\x7f\xc7z(jr\x81";

  if(isthrowingknifecam) {
    thread function_2bbd58aa13640607(bulletcaminstance);
  }
}

function private function_aa98927fb7c739ca(bulletcaminstance) {
  victim = function_c414133d4c023245(bulletcaminstance);

  if(!isactor(victim) || !isalive(victim)) {
    return;
  }

  if(function_5f10464bb6d55c8f(victim)) {
    return;
  }

  function_f3ddaf26aaa9c6c8(bulletcaminstance);
  cacheddamagedata = function_64dc55da844b3af7(bulletcaminstance);
  player = namespace_a6b6c9ee485cdfa6::instance_getplayer(bulletcaminstance);
  victim dodamage(victim.maxhealth * 2, cacheddamagedata.impactpoint, player, undefined, cacheddamagedata.mod, cacheddamagedata.objweapon, cacheddamagedata.hitloc);
  bulletcamsettings = namespace_a6b6c9ee485cdfa6::function_710c9c4f545907fd(bulletcaminstance);
  impactfxkey = bulletcamsettings.var_dd16060dbd774e02;

  if(isDefined(impactfxkey)) {
    traveldir = namespace_a6b6c9ee485cdfa6::function_2173789a4f0a7aab(bulletcaminstance);
    playFX(utility::getfx(impactfxkey), cacheddamagedata.impactpoint, traveldir * -1);
  }
}

function private function_ec86c1e62483af4e(bulletcaminstance) {
  function_f3ddaf26aaa9c6c8(bulletcaminstance);
  victim = function_c414133d4c023245(bulletcaminstance);

  if(isent(victim)) {
    victim utility::ent_flag_clear("XB\x9cq\xd3k\x06]\r\x80\x8cr'\x85\x81X(");
  }
}

function private function_2bbd58aa13640607(bulletcaminstance) {
  waitframe();
  victim = function_c414133d4c023245(bulletcaminstance);

  if(!isactor(victim) || !isalive(victim)) {
    return;
  }

  stuckthrowingknives = [];
  var_2ec5fd5f20cf3cc6 = victim getlinkedchildren();

  foreach(obj in var_2ec5fd5f20cf3cc6) {
    if(obj.name == "VK\n\xdb\xd0(O'T]\x12K\x8e") {
      stuckthrowingknives[stuckthrowingknives.size] = obj;
    }
  }

  if(stuckthrowingknives.size == 0) {
    return;
  }

  impactpoint = namespace_a6b6c9ee485cdfa6::function_641cfc0959206632(bulletcaminstance);
  stuckthrowingknives = sortbydistance(stuckthrowingknives, impactpoint);
  closestthrowingknife = stuckthrowingknives[0];
  closestthrowingknife hide();
  bulletcaminstance.hiddenthrowingknife = closestthrowingknife;
}

function private function_2a47bd7b66d8193e(bulletcaminstance) {
  if(isent(bulletcaminstance.hiddenthrowingknife)) {
    bulletcaminstance.hiddenthrowingknife show();
    bulletcaminstance.hiddenthrowingknife = undefined;
  }
}

function private fixupimpactpoint(cacheddamagedata) {}

function private function_ef66eed9d7f3e69a(bulletcamsettings, impactfxkey, var_88637a63c080d666) {
  bulletcamsettings.var_dd16060dbd774e02 = impactfxkey;
  bulletcamsettings.var_a36404f2feec5955 = var_88637a63c080d666;
}

function private function_e20d41b82743db00(victim, var_c0fc2d39074d123a, var_4415ba6ea03bb3d3, bulletmodeloverrides, var_3a7308ff2deb5a5e, modifydamagedatafunc) {
  victim.var_c0fc2d39074d123a = var_c0fc2d39074d123a;
  victim.var_4415ba6ea03bb3d3 = var_4415ba6ea03bb3d3;
  victim.bulletmodeloverrides = bulletmodeloverrides;

  if(isDefined(modifydamagedatafunc)) {
    assert(isfunction(modifydamagedatafunc));
    victim.var_51d88e53592280a8 = modifydamagedatafunc;
  }

  if(isDefined(var_3a7308ff2deb5a5e)) {
    if(isarray(var_3a7308ff2deb5a5e)) {
      victim.var_77cf1cc51453cefc = [];

      foreach(key in getarraykeys(var_3a7308ff2deb5a5e)) {
        victim.var_77cf1cc51453cefc[key] = pow(var_3a7308ff2deb5a5e[key], 2);
      }

      return;
    }

    victim.var_77cf1cc51453cefc = var_3a7308ff2deb5a5e * var_3a7308ff2deb5a5e;
  }
}

function private function_568210ecffb75f47(var_7b109018caf53b15, key) {
  if(isarray(var_7b109018caf53b15)) {
    return var_7b109018caf53b15[key];
  }

  return var_7b109018caf53b15;
}

function private function_4590058509a134b6(victim) {
  return victim.var_c0fc2d39074d123a;
}

function private function_258a8074d053609(victim, damagetype) {
  return function_568210ecffb75f47(victim.var_4415ba6ea03bb3d3, damagetype);
}

function private function_e2b6a50159ffc6cb(victim, damagetype) {
  return function_568210ecffb75f47(victim.bulletmodeloverrides, damagetype);
}

function private function_709f7501627545fa(victim, damagetype) {
  return function_568210ecffb75f47(victim.var_77cf1cc51453cefc, damagetype);
}

function private function_26fd2788f5d340cf(victim) {
  return victim.var_51d88e53592280a8;
}

function private function_7e07f5c0c78b8066(victim) {
  return function_568210ecffb75f47(victim.var_4415ba6ea03bb3d3, "s\x1f\xb6#\ax\xa0\x7fD\xaa\r\xff]\xff@\xcdi\x03vx\xed;y\xbc^\xf3\v\x93\xdd\xc18u^\x81\xb6\xfb\xe1\xb1H\x9fH\xc8");
}

function private function_411934b82a7eebfa() {
  bulletcamsettings = function_4a28176164b09700();
  function_ef66eed9d7f3e69a(bulletcamsettings, "}r\xeex\x9a9_IP+\\\x92\xb8\xd7z{\xe3L\xde\x99\xb6[\x19", 640000);
  return bulletcamsettings;
}

function function_4a28176164b09700(var_c65addeb6c03c91b, var_a05172b90d2dce22, var_489e34de0fa5b29, var_eaca4549ca927385, var_fadee27b8d7cfdea, var_c5c51e7d32ad2329, var_3437dd6b892d12ee) {
  settings = namespace_a6b6c9ee485cdfa6::function_fdb9691f0fc848c8();
  settings.bulletrotationvelocity = (0, 0, -1);
  settings.var_500a9b65098e00c0 = (0, 0, 1);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x85J\xf8\x94\xd4\x1b\x8a}r\x83\xda", undefined, undefined, undefined);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V", undefined, undefined, 0.2);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS", 0.5, 0.1, undefined);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32", 0.5, 0, 1);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "nG\vg\xca\xf5i\xad\x1cXl\xa3", 1, 0.5, 0.15);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\x17\xad\v|\x1ax$\x87\x9eY\xcc\xbc\xff\xff", 0.2, 0.5, 0.5);
  namespace_a6b6c9ee485cdfa6::function_967d3f080130f4e4(settings, "\t\xe6,\xd3\xbc:\x9f=Z\x0f\x9f\xc4\x89", undefined, 0.1, undefined);
  namespace_a6b6c9ee485cdfa6::function_9d130294613a86ff(settings, var_a05172b90d2dce22, var_489e34de0fa5b29, var_eaca4549ca927385, var_fadee27b8d7cfdea, var_c5c51e7d32ad2329, var_3437dd6b892d12ee);
  namespace_a6b6c9ee485cdfa6::setstagefunctions(settings, &function_b5272e1188bc0255, &function_f8622818f1b8e814, &function_2c753da713fa82ab, &function_d4862f73bc3ac2b7, &function_2ebd25a2eae212b0, &function_9883d03142157ef, &function_ff14e746fc6e13dc);
  return settings;
}