/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_31613e9096b20af3.gsc
*****************************************************/

#using scripts\common\utility;
#using scripts\common\values;
#using scripts\engine\sp\utility;
#using scripts\engine\utility;
#namespace namespace_a6b6c9ee485cdfa6;

function function_22edfc337a9b4cb1(bulletcaminstance, point, time, accelerationtime = 0, decelerationtime = 0) {
  bulletsled = function_fb2f7ac764e8f76a(bulletcaminstance);
  fakebullet = function_a190f68884ced31d(bulletcaminstance);
  bulletsled moveTo(point, time, accelerationtime, decelerationtime);
  fakebullet moveTo(point, time, accelerationtime, decelerationtime);
}

function function_51758c766640861f(bulletcaminstance, endpos, controlpos, duration) {
  var_bc7b5376e2fcfb0e = function_fb2f7ac764e8f76a(bulletcaminstance);
  fakebullet = function_a190f68884ced31d(bulletcaminstance);
  var_bc7b5376e2fcfb0e thread utility::function_905a5c0db28ac1c3(bulletcaminstance.bulletsled.origin, endpos, controlpos, duration);
  fakebullet thread utility::function_905a5c0db28ac1c3(bulletcaminstance.fakebullet.origin, endpos, controlpos, duration);
}

function function_6114e91459046d30(bulletcaminstance, position) {
  var_bc7b5376e2fcfb0e = function_fb2f7ac764e8f76a(bulletcaminstance);
  fakebullet = function_a190f68884ced31d(bulletcaminstance);
  var_bc7b5376e2fcfb0e.origin = position;
  fakebullet.origin = position;
}

function function_4198e3a7565ff263(bulletcaminstance, startpos, endpos) {
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  bulletspeed = function_54b845ccc0af58b(bulletcamsettings);
  return length(endpos - startpos) / bulletspeed;
}

function rotatefakebullet(bulletcaminstance, rotationvelocity, duration) {
  thread function_f347e9b288293590(bulletcaminstance, rotationvelocity, duration);
}

function private function_f347e9b288293590(bulletcaminstance, rotationvelocity, duration) {
  bulletcaminstance endon("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  bulletcaminstance notify("\xd2\x8b\xa9lA\xb7\xed\x92\xce\xe5\x13r\xf7\xcc");
  bulletcaminstance endon("\xd2\x8b\xa9lA\xb7\xed\x92\xce\xe5\x13r\xf7\xcc");
  fakebullet = function_a190f68884ced31d(bulletcaminstance);
  timeelapsed = 0;

  while(timeelapsed < duration) {
    if(!isent(fakebullet)) {
      return;
    }

    rotateamount = rotationvelocity * level.framedurationseconds;
    fakebullet rotateTo(fakebullet.angles + rotateamount, level.framedurationseconds);
    timeelapsed += level.framedurationseconds;
    wait level.framedurationseconds;
  }
}

function function_1bdb689076d3fe5d(bulletcaminstance, point, time) {
  cameranode = function_910559b442cb057b(bulletcaminstance);
  cameranode moveTo(point, time);
}

function function_dac59261ea3ac250(bulletcaminstance, deletefakebullet) {
  cameranode = function_910559b442cb057b(bulletcaminstance);
  bulletsled = function_fb2f7ac764e8f76a(bulletcaminstance);
  fakebullet = function_a190f68884ced31d(bulletcaminstance);
  cameranode unlink();
  bulletsled hide();

  if(deletefakebullet) {
    fakebullet hide();
  }

  var_c46ba88f47f1b7c1 = function_acbca6ff0592a805(bulletcaminstance);
  var_d27b7a4dc393ac13 = function_f12f05a73b1bff(bulletcaminstance);
  cameranode dontinterpolate();
  cameranode.origin = var_c46ba88f47f1b7c1;
  cameranode.angles = vectortoangles(-1 * var_d27b7a4dc393ac13);
  function_86d3b22dd64e4ac1(bulletcaminstance, 1);
}

function function_fdb9691f0fc848c8() {
  settings = spawnStruct();
  settings.var_2eefdf5d9a608e00 = 1;
  settings.activeinstances = [];
  settings.bulletspeed = 1500;
  settings.bulletrotationvelocity = (0, 0, -4000);
  settings.var_500a9b65098e00c0 = (0, 0, 500);
  settings.bulletmodel = "\xf8H\xc4G\x05\x9f\xfePKv\xd7\x1f\xa4d\xc9a\x7f\xc4x%\x10C\xffP.~\x9c\x89";
  settings.startpointdistance = 5;
  settings.var_88539a4265e45d52 = 60;
  settings.var_36b62f22ce8aeecf = 20;
  settings.var_4900efa2d1866b7c = (-5, 0, 1);
  settings.var_ddc09e64c0d718fb = (0, 0, 0);
  settings.var_96be05d08e7d53c8 = 150;
  settings.impactcamangles = (0, 90, 0);
  settings.var_106c187c74acaf75 = -60;
  settings.var_875189a65971b63a = 0;
  settings.var_f49be3034c3590c = 20;
  settings.var_4468afdd6a4f35b2 = [];
  settings.stagefunctions = [];
  settings.stagecallbackfunctions = [];
  return settings;
}

function private function_510670a63518ca86(bulletcamsettings, bulletcaminstance) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.activeinstances[bulletcamsettings.activeinstances.size] = bulletcaminstance;
}

function private function_99eb4e486679b69a(bulletcamsettings, bulletcaminstance) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.activeinstances = arrayremove(bulletcamsettings.activeinstances, bulletcaminstance);
}

function private function_b51ba735c3209136(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.activeinstances;
}

function function_967d3f080130f4e4(bulletcamsettings, stage, timescale, lerpintime, duration) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_4468afdd6a4f35b2[stage] = spawnStruct();
  function_837976902b3dd375(bulletcamsettings, stage, timescale);
  function_583616b8b70d985d(bulletcamsettings, stage, lerpintime);
  function_707aaccda66df52a(bulletcamsettings, stage, duration);
}

function function_707aaccda66df52a(bulletcamsettings, stage, duration) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_4468afdd6a4f35b2[stage].duration = duration;
}

function function_8ab62bc84e4c81b6(bulletcamsettings, stage) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_4468afdd6a4f35b2[stage].duration;
}

function function_837976902b3dd375(bulletcamsettings, stage, timescale) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_4468afdd6a4f35b2[stage].timescale = timescale;
}

function function_12779cb1bdd64e89(bulletcamsettings, stage) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_4468afdd6a4f35b2[stage].timescale;
}

function function_583616b8b70d985d(bulletcamsettings, stage, lerpintime) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_4468afdd6a4f35b2[stage].lerpintime = lerpintime;
}

function function_20c94b6d1320011(bulletcamsettings, stage) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_4468afdd6a4f35b2[stage].lerpintime;
}

function registerstagecallbackfunction(bulletcamsettings, stage, setupfunction) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");

  if(!isDefined(bulletcamsettings.stagecallbackfunctions[stage])) {
    bulletcamsettings.stagecallbackfunctions[stage] = [];
  }

  bulletcamsettings.stagecallbackfunctions[stage][bulletcamsettings.stagecallbackfunctions[stage].size] = setupfunction;
}

function function_6fccc3744c0bcfb0(bulletcamsettings, stage) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.stagecallbackfunctions[stage];
}

function setstagefunction(bulletcamsettings, stage, runfunction) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.stagefunctions[stage] = runfunction;
}

function getstagefunction(bulletcamsettings, stage) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.stagefunctions[stage];
}

function function_9d130294613a86ff(bulletcamsettings, var_c65addeb6c03c91b, var_a05172b90d2dce22, var_489e34de0fa5b29, var_eaca4549ca927385, var_fadee27b8d7cfdea, var_c5c51e7d32ad2329, var_3437dd6b892d12ee) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  registerstagecallbackfunction(bulletcamsettings, "\x85J\xf8\x94\xd4\x1b\x8a}r\x83\xda", var_c65addeb6c03c91b);
  registerstagecallbackfunction(bulletcamsettings, "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V", var_a05172b90d2dce22);
  registerstagecallbackfunction(bulletcamsettings, "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS", var_489e34de0fa5b29);
  registerstagecallbackfunction(bulletcamsettings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32", var_eaca4549ca927385);
  registerstagecallbackfunction(bulletcamsettings, "nG\vg\xca\xf5i\xad\x1cXl\xa3", var_fadee27b8d7cfdea);
  registerstagecallbackfunction(bulletcamsettings, "\x17\xad\v|\x1ax$\x87\x9eY\xcc\xbc\xff\xff", var_c5c51e7d32ad2329);
  registerstagecallbackfunction(bulletcamsettings, "\t\xe6,\xd3\xbc:\x9f=Z\x0f\x9f\xc4\x89", var_3437dd6b892d12ee);
}

function setstagefunctions(bulletcamsettings, var_3429d37c626bef98, var_6dda50e508f05fad, var_c1b8404e4705be78, var_5c28ad40caba24da, var_7cd6b60ab0075533, var_458f9505e7bf6b58, var_4a37b92b0b7c7d49) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  setstagefunction(bulletcamsettings, "\x85J\xf8\x94\xd4\x1b\x8a}r\x83\xda", var_3429d37c626bef98);
  setstagefunction(bulletcamsettings, "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V", var_6dda50e508f05fad);
  setstagefunction(bulletcamsettings, "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS", var_c1b8404e4705be78);
  setstagefunction(bulletcamsettings, "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32", var_5c28ad40caba24da);
  setstagefunction(bulletcamsettings, "nG\vg\xca\xf5i\xad\x1cXl\xa3", var_7cd6b60ab0075533);
  setstagefunction(bulletcamsettings, "\x17\xad\v|\x1ax$\x87\x9eY\xcc\xbc\xff\xff", var_458f9505e7bf6b58);
  setstagefunction(bulletcamsettings, "\t\xe6,\xd3\xbc:\x9f=Z\x0f\x9f\xc4\x89", var_4a37b92b0b7c7d49);
}

function function_969456915756883e(player, bulletcamsettings, sourceposition, impactposition) {
  if(utility::flag("XB\x9cq\xd3k\x06]\r\x80\x8cr'\x85\x81X(")) {
    assertmsg("<dev string:xad>");
    return undefined;
  }

  bulletcaminstance = function_9794989807f6064a(player, bulletcamsettings, sourceposition, impactposition);
  function_510670a63518ca86(bulletcamsettings, bulletcaminstance);
  function_72ef35d801799f72(bulletcaminstance);
  function_b6c74fb48cca63d2(bulletcaminstance);
  function_799d69ae955ec4fc(bulletcaminstance);
  utility::flag_set("XB\x9cq\xd3k\x06]\r\x80\x8cr'\x85\x81X(");
  return bulletcaminstance;
}

function private function_adc3886d2115b966(bulletcaminstance) {
  bulletcaminstance notify("Z\xae\a\xc9K\xbc\xaa~\xc0\xbf\xb1N-tG\x03\xfa\xc4");
  player = instance_getplayer(bulletcaminstance);
  function_36f65abfa6964582(bulletcaminstance);
  function_4e66dbb16095e7a9(player);
  utility::flag_clear("XB\x9cq\xd3k\x06]\r\x80\x8cr'\x85\x81X(");
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  function_99eb4e486679b69a(bulletcamsettings, bulletcaminstance);
}

function function_102b4429964314d7(bulletcaminstance, orderedstages = undefined) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");

  if(!isDefined(orderedstages)) {
    orderedstages = [];
    orderedstages[0] = "\x85J\xf8\x94\xd4\x1b\x8a}r\x83\xda";
    orderedstages[1] = "\x96\x04\x19\x1e\xd7\xa5\x1b!(\xf9gA\xdet\x91V";
    orderedstages[2] = "\xbe,\x1cQ\xd1\x8b\xab\xe55\xd2\x1fS";
    orderedstages[3] = "Yu?my\xdc\xdd\xb7t\xecO\x03\x169\xf0=32";
    orderedstages[4] = "nG\vg\xca\xf5i\xad\x1cXl\xa3";
    orderedstages[5] = "\x17\xad\v|\x1ax$\x87\x9eY\xcc\xbc\xff\xff";
    orderedstages[6] = "\t\xe6,\xd3\xbc:\x9f=Z\x0f\x9f\xc4\x89";
  }

  if(getdvarint(@ "hash_9051c2c88ed1f14e", 0)) {
    function_77fac583ec4d86eb(bulletcaminstance);
  }

  for(i = 0; i < orderedstages.size; i++) {
    stage = orderedstages[i];
    function_e0b923163ad9c734(bulletcaminstance, stage);
  }

  function_adc3886d2115b966(bulletcaminstance);
}

function function_ec9b012a6597699e(bulletcaminstance) {
  if(istrue(bulletcaminstance.isdirty)) {
    function_72ef35d801799f72(bulletcaminstance);
    bulletcaminstance.isdirty = 0;
  }
}

function private function_9794989807f6064a(player, bulletcamsettings, sourceposition, impactposition) {
  instance = spawnStruct();
  instance.var_9dab4c432f425f72 = 1;
  instance.isdirty = 0;
  instance.player = player;
  instance.settings = bulletcamsettings;
  instance.bulletsled = undefined;
  instance.cameranode = undefined;
  instance.fakebullet = undefined;
  instance.sourcepos = sourceposition;
  instance.startpos = undefined;
  instance.var_2f4d52b770d308b7 = undefined;
  instance.impacttriggerpos = undefined;
  instance.impactpos = impactposition;
  instance.traveldirection = undefined;
  instance.var_1afc6f22928dfe65 = undefined;
  instance.var_27f97e7cbe0e4afd = undefined;
  instance.var_1cf9f27e0ddd88fc = undefined;
  instance.var_d27b7a4dc393ac13 = undefined;
  instance.var_c46ba88f47f1b7c1 = undefined;
  instance.var_4ff9eba1fa788ec = undefined;
  instance.var_58a016a71e62a302 = undefined;
  instance.var_bac90a89aa7057b1 = 0;
  return instance;
}

function private function_b6c74fb48cca63d2(bulletcaminstance) {
  assert(isDefined(instance_getstartpos(bulletcaminstance)), "<dev string:x187>");
  function_1e5bf8c40e748a51(bulletcaminstance);
  function_ad282be27774985b(bulletcaminstance);
}

function private function_1e5bf8c40e748a51(bulletcaminstance) {
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  origin = instance_getstartpos(bulletcaminstance);
  angles = vectortoangles(function_2173789a4f0a7aab(bulletcaminstance));
  model = function_ae4b0d543e80b199(bulletcamsettings);
  fakebullet = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", origin);
  fakebullet.angles = angles;
  fakebullet setModel(model);
  function_e1d127ddd101d5c9(bulletcaminstance, fakebullet);
}

function private function_ad282be27774985b(bulletcaminstance) {
  player = instance_getplayer(bulletcaminstance);
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  origin = instance_getstartpos(bulletcaminstance);
  angles = vectortoangles(function_2173789a4f0a7aab(bulletcaminstance));
  linkoffset = function_c2fce32e3f3b1836(bulletcamsettings);
  linkangles = function_7d95d1e6228774a9(bulletcamsettings);
  bulletsled = utility::spawn_tag_origin(origin, angles);
  cameranode = utility::function_94c66bbed3da2a18(origin, angles);
  cameranode linkTo(bulletsled, "\xec\xbfK|\au\xcd\xc2\x19<", linkoffset, linkangles);
  thread function_f38905d535ffe9c2(player, cameranode);
  function_5426718ee7c09aee(bulletcaminstance, bulletsled);
  function_5b64726da7f9be8f(bulletcaminstance, cameranode);
}

function private function_f38905d535ffe9c2(player, cameranode) {
  waitframe();
  player cameralinkTo(cameranode, "\xec\xbfK|\au\xcd\xc2\x19<", 1, 1);
}

function private function_36f65abfa6964582(bulletcaminstance) {
  player = instance_getplayer(bulletcaminstance);
  player cameraunlink();
  player setstance(player getstance(), 0, 1, 1);
  fakebullet = function_a190f68884ced31d(bulletcaminstance);
  cameranode = function_910559b442cb057b(bulletcaminstance);
  bulletsled = function_fb2f7ac764e8f76a(bulletcaminstance);

  if(isDefined(fakebullet)) {
    fakebullet delete();
  }

  if(isDefined(cameranode)) {
    cameranode delete();
  }

  if(isDefined(bulletsled)) {
    bulletsled delete();
  }
}

function private function_72ef35d801799f72(bulletcaminstance) {
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  sourcepos = function_73b5e06b709251a7(bulletcaminstance);
  impactpos = function_641cfc0959206632(bulletcaminstance);
  traveldirection = vectorNormalize(impactpos - sourcepos);
  startpos = sourcepos + traveldirection * function_77cde7ae4a6520a7(bulletcamsettings);
  var_2f4d52b770d308b7 = impactpos - traveldirection * function_b78fefe4f5fed230(bulletcamsettings);
  impacttriggerpos = impactpos - traveldirection * function_30e6ebf6061ac871(bulletcamsettings);
  function_994f283c1a52497f(bulletcaminstance, traveldirection);
  function_2e71bfa7a610e0a6(bulletcaminstance, startpos);
  function_a3db192d3ebf827(bulletcaminstance, var_2f4d52b770d308b7);
  function_5ae0ef5a7ff1bc44(bulletcaminstance, impacttriggerpos);
  var_1afc6f22928dfe65 = function_4198e3a7565ff263(bulletcaminstance, startpos, var_2f4d52b770d308b7);
  var_27f97e7cbe0e4afd = function_4198e3a7565ff263(bulletcaminstance, var_2f4d52b770d308b7, impacttriggerpos);
  var_1cf9f27e0ddd88fc = var_1afc6f22928dfe65 + var_27f97e7cbe0e4afd;
  function_c1642960331f1ff5(bulletcaminstance, var_1afc6f22928dfe65);
  function_11cb69bd339909ad(bulletcaminstance, var_27f97e7cbe0e4afd);
  function_31bc734a10a28cc(bulletcaminstance, var_1cf9f27e0ddd88fc);
  var_9b1ee650ed847f84 = rotatevector(traveldirection, function_304bbf5c89bc4345(bulletcamsettings));
  var_1ffae07a10059666 = impactpos + var_9b1ee650ed847f84 * function_9cdc6ba123cc0a5e(bulletcamsettings);
  var_d27b7a4dc393ac13 = var_9b1ee650ed847f84;
  var_c46ba88f47f1b7c1 = var_1ffae07a10059666 + traveldirection * function_b15b6a01795cf8b7(bulletcamsettings);
  var_4ff9eba1fa788ec = var_1ffae07a10059666 + traveldirection * function_7bb5ba001c369ba0(bulletcamsettings);
  var_58a016a71e62a302 = var_1ffae07a10059666 + traveldirection * function_29e952387186fa72(bulletcamsettings);
  function_debbee75ceb4d5c3(bulletcaminstance, var_d27b7a4dc393ac13);
  function_6eabc4822b9d17b1(bulletcaminstance, var_c46ba88f47f1b7c1);
  function_8b164a5804c47f5c(bulletcaminstance, var_4ff9eba1fa788ec);
  function_31195bc472a5aa72(bulletcaminstance, var_58a016a71e62a302);
}

function private function_799d69ae955ec4fc(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  player = instance_getplayer(bulletcaminstance);
  player val::set("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9", "\xa8Jl\x84\xb3b\x95o", 0);
  player val::set("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9", "\x11\xf3q.(A|\xa6\x94\xf3h\xa2<\xef\x82\xd5", 0);
  player val::set("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9", "\xcciN\xca", 0);
  player val::set("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9", "\xc9\xca\x1boX\x8c", 0);
  player function_b6895420ef6bc39c(1);
  thread function_4eb3df4996658ab1(player);
}

function private function_4eb3df4996658ab1(player) {
  wait 0.25;
  player val::set("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9", "\fU`\xc0y\x95", 0);
  player val::set("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9", " \x8e\\\x7f\xf9\x9cH\x86\b\xc2Wkz[", 1);
}

function private function_4e66dbb16095e7a9(player) {
  player function_b6895420ef6bc39c(0);
  player val::reset_all("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9");
}

function private function_e0b923163ad9c734(bulletcaminstance, stage) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  assert(isDefined(bulletcaminstance));
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  assert(isDefined(bulletcamsettings));

  if(istrue(bulletcaminstance.isdirty)) {
    function_72ef35d801799f72(bulletcaminstance);
    bulletcaminstance.isdirty = 0;
  }

  function_203b7857f67273b1(bulletcaminstance, stage);

  if(istrue(bulletcaminstance.isdirty)) {
    function_72ef35d801799f72(bulletcaminstance);
    bulletcaminstance.isdirty = 0;
  }

  runstagefunction(bulletcaminstance, stage);

  if(istrue(bulletcaminstance.isdirty)) {
    function_72ef35d801799f72(bulletcaminstance);
    bulletcaminstance.isdirty = 0;
  }

  function_fccd865c8727bbaf(bulletcaminstance, stage);
  waitstageduration(bulletcaminstance, stage);
}

function private function_203b7857f67273b1(bulletcaminstance, stage) {
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  stagecallbackfunctions = function_6fccc3744c0bcfb0(bulletcamsettings, stage);

  if(isarray(stagecallbackfunctions)) {
    foreach(stagecallbackfunction in stagecallbackfunctions) {
      assert(isfunction(stagecallbackfunction));
      [[stagecallbackfunction]](bulletcaminstance);
    }
  }
}

function private runstagefunction(bulletcaminstance, stage) {
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  stagefunction = getstagefunction(bulletcamsettings, stage);

  if(isDefined(stagefunction)) {
    assert(isfunction(stagefunction));
    [[stagefunction]](bulletcaminstance);
  }
}

function private function_fccd865c8727bbaf(bulletcaminstance, stage) {
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  stagetimescale = function_12779cb1bdd64e89(bulletcamsettings, stage);

  if(isDefined(stagetimescale)) {
    lerpintime = function_20c94b6d1320011(bulletcamsettings, stage);
    assert(isDefined(lerpintime), "<dev string:x204>" + stage);

    if(stage == "\t\xe6,\xd3\xbc:\x9f=Z\x0f\x9f\xc4\x89") {
      assert(stagetimescale == 1);
      utility_sp::function_2853d8d2bf2b2f5("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9", lerpintime);
      return;
    }

    utility_sp::function_712369ee845f814c("\x02\x98\xc3\x03/\x1b|\xbe\x9d\xf9", stagetimescale, lerpintime);
  }
}

function private waitstageduration(bulletcaminstance, stage) {
  bulletcamsettings = function_710c9c4f545907fd(bulletcaminstance);
  duration = function_8ab62bc84e4c81b6(bulletcamsettings, stage);

  if(isDefined(duration) && duration > 0) {
    wait duration;
  }
}

function function_54b845ccc0af58b(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.bulletspeed;
}

function function_fd1a4533eb81770f(bulletcamsettings, bulletspeed) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.bulletspeed = bulletspeed;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function function_51d921ad64667303(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.bulletrotationvelocity;
}

function function_8153d05078629797(bulletcamsettings, bulletrotationvelocity) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.bulletrotationvelocity = bulletrotationvelocity;
}

function function_43c5bac9b5e060d6(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_500a9b65098e00c0;
}

function function_70f6a7f6642aeb5a(bulletcamsettings, var_500a9b65098e00c0) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_500a9b65098e00c0 = var_500a9b65098e00c0;
}

function function_ae4b0d543e80b199(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.bulletmodel;
}

function function_9ce2a9da8dbdc8fd(bulletcamsettings, bulletmodel) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.bulletmodel = bulletmodel;
}

function function_77cde7ae4a6520a7(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.startpointdistance;
}

function function_8faf59abdb3c376b(bulletcamsettings, startpointdistance) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.startpointdistance = startpointdistance;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function function_b78fefe4f5fed230(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_88539a4265e45d52;
}

function function_382776fb78556574(bulletcamsettings, var_88539a4265e45d52) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_88539a4265e45d52 = var_88539a4265e45d52;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function function_30e6ebf6061ac871(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_36b62f22ce8aeecf;
}

function function_69f02d08364d14e5(bulletcamsettings, var_36b62f22ce8aeecf) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_36b62f22ce8aeecf = var_36b62f22ce8aeecf;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function function_c2fce32e3f3b1836(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_4900efa2d1866b7c;
}

function function_c7dfbaaecc949142(bulletcamsettings, var_4900efa2d1866b7c) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_4900efa2d1866b7c = var_4900efa2d1866b7c;
}

function function_7d95d1e6228774a9(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_ddc09e64c0d718fb;
}

function function_b3acbce7f757e97d(bulletcamsettings, var_ddc09e64c0d718fb) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_ddc09e64c0d718fb = var_ddc09e64c0d718fb;
}

function function_9cdc6ba123cc0a5e(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_96be05d08e7d53c8;
}

function function_40c6fd4e7555c60a(bulletcamsettings, var_96be05d08e7d53c8) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_96be05d08e7d53c8 = var_96be05d08e7d53c8;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function function_304bbf5c89bc4345(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.impactcamangles;
}

function function_c756e6dda924bb11(bulletcamsettings, impactcamangles) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.impactcamangles = impactcamangles;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function function_b15b6a01795cf8b7(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_106c187c74acaf75;
}

function function_bd5ffadb127391cb(bulletcamsettings, var_106c187c74acaf75) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_106c187c74acaf75 = var_106c187c74acaf75;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function function_7bb5ba001c369ba0(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_875189a65971b63a;
}

function function_739298a13bda8334(bulletcamsettings, var_875189a65971b63a) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_875189a65971b63a = var_875189a65971b63a;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function function_29e952387186fa72(bulletcamsettings) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  return bulletcamsettings.var_f49be3034c3590c;
}

function function_5d60418fe8f0d45e(bulletcamsettings, var_f49be3034c3590c) {
  assert(bulletcamsettings.var_2eefdf5d9a608e00, "<dev string:x24>");
  bulletcamsettings.var_f49be3034c3590c = var_f49be3034c3590c;

  if(istrue(bulletcamsettings.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcamsettings)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcamsettings.var_9dab4c432f425f72)) {
    bulletcamsettings.isdirty = 1;
  }
}

function instance_getplayer(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.player;
}

function private function_607c954601eb2de5(bulletcaminstance, player) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.player = player;
}

function function_710c9c4f545907fd(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.settings;
}

function private function_476cf81014135f79(bulletcaminstance, settings) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.settings = settings;
}

function function_fb2f7ac764e8f76a(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.bulletsled;
}

function private function_5426718ee7c09aee(bulletcaminstance, bulletsled) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.bulletsled = bulletsled;
}

function function_910559b442cb057b(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.cameranode;
}

function private function_5b64726da7f9be8f(bulletcaminstance, cameranode) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.cameranode = cameranode;
}

function function_a190f68884ced31d(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.fakebullet;
}

function private function_e1d127ddd101d5c9(bulletcaminstance, fakebullet) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.fakebullet = fakebullet;
}

function function_73b5e06b709251a7(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.sourcepos;
}

function function_633028b93e1759f3(bulletcaminstance, sourcepos) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.sourcepos = sourcepos;

  if(istrue(bulletcaminstance.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcaminstance)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcaminstance.var_9dab4c432f425f72)) {
    bulletcaminstance.isdirty = 1;
  }
}

function instance_getstartpos(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.startpos;
}

function private function_2e71bfa7a610e0a6(bulletcaminstance, startpos) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.startpos = startpos;
}

function function_228f6dd5def652eb(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_2f4d52b770d308b7;
}

function private function_a3db192d3ebf827(bulletcaminstance, var_2f4d52b770d308b7) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_2f4d52b770d308b7 = var_2f4d52b770d308b7;
}

function function_6ddd5f71d9cccc8(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.impacttriggerpos;
}

function private function_5ae0ef5a7ff1bc44(bulletcaminstance, impacttriggerpos) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.impacttriggerpos = impacttriggerpos;
}

function function_641cfc0959206632(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.impactpos;
}

function function_1a00ec4e229e9226(bulletcaminstance, impactpos) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.impactpos = impactpos;

  if(istrue(bulletcaminstance.var_2eefdf5d9a608e00)) {
    foreach(instance in function_b51ba735c3209136(bulletcaminstance)) {
      instance.isdirty = 1;
    }

    return;
  }

  if(istrue(bulletcaminstance.var_9dab4c432f425f72)) {
    bulletcaminstance.isdirty = 1;
  }
}

function function_2173789a4f0a7aab(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.traveldirection;
}

function private function_994f283c1a52497f(bulletcaminstance, traveldirection) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.traveldirection = traveldirection;
}

function function_dcac3d77fefa9d11(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_1afc6f22928dfe65;
}

function private function_c1642960331f1ff5(bulletcaminstance, var_1afc6f22928dfe65) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_1afc6f22928dfe65 = var_1afc6f22928dfe65;
}

function function_b1f3db1d76c3a819(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_27f97e7cbe0e4afd;
}

function private function_11cb69bd339909ad(bulletcaminstance, var_27f97e7cbe0e4afd) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_27f97e7cbe0e4afd = var_27f97e7cbe0e4afd;
}

function function_b94938c064d20ad0(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_1cf9f27e0ddd88fc;
}

function private function_31bc734a10a28cc(bulletcaminstance, var_1cf9f27e0ddd88fc) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_1cf9f27e0ddd88fc = var_1cf9f27e0ddd88fc;
}

function function_f12f05a73b1bff(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_d27b7a4dc393ac13;
}

function private function_debbee75ceb4d5c3(bulletcaminstance, var_d27b7a4dc393ac13) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_d27b7a4dc393ac13 = var_d27b7a4dc393ac13;
}

function function_acbca6ff0592a805(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_c46ba88f47f1b7c1;
}

function private function_6eabc4822b9d17b1(bulletcaminstance, var_c46ba88f47f1b7c1) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_c46ba88f47f1b7c1 = var_c46ba88f47f1b7c1;
}

function function_86b7e09ed5024be0(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_4ff9eba1fa788ec;
}

function private function_8b164a5804c47f5c(bulletcaminstance, var_4ff9eba1fa788ec) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_4ff9eba1fa788ec = var_4ff9eba1fa788ec;
}

function function_79af0731522aa95e(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_58a016a71e62a302;
}

function private function_31195bc472a5aa72(bulletcaminstance, var_58a016a71e62a302) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_58a016a71e62a302 = var_58a016a71e62a302;
}

function function_4372183e7f646bb5(bulletcaminstance) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  return bulletcaminstance.var_bac90a89aa7057b1;
}

function private function_86d3b22dd64e4ac1(bulletcaminstance, var_bac90a89aa7057b1) {
  assert(bulletcaminstance.var_9dab4c432f425f72, "<dev string:x100>");
  bulletcaminstance.var_bac90a89aa7057b1 = var_bac90a89aa7057b1;
}

function function_77fac583ec4d86eb(bulletcaminstance) {
  settings = function_710c9c4f545907fd(bulletcaminstance);
  stages = ["<dev string:x269>", "<dev string:x278>", "<dev string:x28c>", "<dev string:x29c>", "<dev string:x2b2>", "<dev string:x2c2>", "<dev string:x2d4>"];

  foreach(stage in stages) {
    function_967d3f080130f4e4(settings, stage, undefined, undefined, undefined);
    setstagefunction(settings, stage, undefined);
  }

  setstagefunction(settings, "<dev string:x28c>", &function_5641e060fb57d5eb);
}

function function_5641e060fb57d5eb(instance) {
  settings = function_710c9c4f545907fd(instance);
  startpos = instance_getstartpos(instance);
  impactpos = function_641cfc0959206632(instance);

  while(getdvarint(@ "hash_9051c2c88ed1f14e", 0)) {
    resetat = getdvarint(@ "hash_edb8813414e7aa6b", 8);
    iterations = getdvarint(@ "hash_c82410fff189ffb7", 10);
    baseduration = getdvarfloat(@ "hash_dbb18d8f18dc62be", 2);
    slowmo1 = getdvarfloat(@ "hash_f82ae9f4138d8b51", 0.5);
    slowmo2 = getdvarfloat(@ "hash_f82ae6f4138d84b8", 0.1);
    lerp1 = getdvarfloat(@ "hash_2883700079747d85", 0.1);
    lerp2 = getdvarfloat(@ "hash_28836d00797476ec", 0.5);
    totaltravelduration = 0;

    for(i = resetat + 1; i <= iterations; i++) {
      oddstep = i % 2 > 0;
      slowmo = oddstep ? slowmo1 : slowmo2;
      duration = baseduration * slowmo;
      totaltravelduration += duration;
    }

    step = 1 / iterations;
    frac = step * resetat;
    resetpos = vectorlerp(startpos, impactpos, frac);
    function_6114e91459046d30(instance, resetpos);
    waitframe();
    function_22edfc337a9b4cb1(instance, impactpos, totaltravelduration);
    waitframe();

    for(i = resetat + 1; i <= iterations; i++) {
      oddstep = i % 2 > 0;
      slowmo = oddstep ? slowmo1 : slowmo2;
      lerp = oddstep ? lerp1 : lerp2;
      duration = baseduration * slowmo;
      utility_sp::function_712369ee845f814c("<dev string:x2e5>", slowmo, lerp);
      wait duration;
    }

    waitframe();
  }
}

# /