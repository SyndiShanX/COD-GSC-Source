/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: hashed\script\script_53f4e6352b0b2425.gsc
*****************************************************/

#using script_162c770c1453a845;
#using script_19163c4e4e504a5e;
#using script_6bf6c8e2e1fdccaa;
#using scripts\common\utility;
#using scripts\engine\utility;
#namespace snd;

function init() {
  if(!isDefined(level.snd)) {
    level.snd = spawnStruct();
    level.snd.var_aa82b3c5f09326cc = 1;
    level.snd.callbacks = [];
    level.snd.objects = [];
    level.snd.unlinkedobjects = [];
    level.snd.var_eb8a31d84bf35094 = "@:w\xc4\xdeL\xd5";
    level.snd.var_464acc2f92e0f4f2 = 0;
    level.snd.callbacks["\t6\\^s\xe5\xb5\xc9r\xaf"] = &function_214e94179a51980f;
    level.snd.callbacks["\x1c\x9cF7\xb2H\x1e\x88\"\xf2\x1a$\xb5"] = &function_d771fb439e8fe2d5;
    level.snd.callbacks["6\a\xea\xbf\x8f\x92\v\t\xc2-"] = &function_64c78109b4b654e2;
  }

  curve_init();

  level thread snd_debug::function_59d450dbd3c62236();

  utility::registersharedfunc(#"snd", #"play", &play);
}

function init_obj(obj) {
  assert(obj == level || isstruct(obj) || isent(obj));

  if(!isstruct(obj.snd)) {
    obj.snd = spawnStruct();
  }

  assert(isstruct(obj.snd), "<dev string:x24>");
}

function function_8c199b86b490e257() {
  now = gettime();
  var_8c199b86b490e257 = did_init() == 0 || now <= 300;
  return var_8c199b86b490e257;
}

function did_init() {
  if(isstruct(level.snd)) {
    return true;
  }

  return false;
}

function wait_init() {
  while(did_init() == 0) {
    waitframe();
  }
}

function play(soundalias, targets) {
  soundtype = level.snd.var_eb8a31d84bf35094;
  soundobject = function_1342e0ddf8b14f84(soundtype, soundalias, targets);
  return soundobject;
}

function stop(soundobject, fadeoutseconds) {
  foreach(soundobj in makearray(soundobject)) {
    level thread function_8b405a0079e6ff82(soundobj, fadeoutseconds);
  }
}

function stop_alias(soundalias, targets, fadeoutseconds) {
  if(condition_alert(!isDefined(soundalias), "x\x83\a\x02\x13\x135w\xb9\v-}\xb8\x8d8\xdfs\x0f&\x8a\xe6\x11)q\xa3a';\xa4\x06\x1dxD\xb1\x93\xb6$5?k\x9f")) {
    return 0;
  }

  soundalias = tolower(soundalias);
  soundobjects = function_3112c2fb5e8c355(targets);
  var_70b451cf7e4062dd = 0;

  foreach(soundobj in soundobjects) {
    if(!isDefined(soundobj.soundalias)) {
      continue;
    }

    if(issubstr(tolower(soundobj.soundalias), soundalias)) {
      stop(soundobj, fadeoutseconds);
      var_70b451cf7e4062dd = int(var_70b451cf7e4062dd + 1);
    }
  }

  return var_70b451cf7e4062dd;
}

function function_393e33ca166388ae(soundobject, notifyentity, notifystring, fadeoutseconds) {
  if(condition_alert(!function_79dd793aa6ffba4c(soundobject), "\x7f7\xf7\x1d,\b$\x0f\b\x1d\xe1\x95\xd9+\xc7\f\x1a*\x18\xb61@\x9d\x18\xe2\xe7@\xee\xcfc\xa3\x1a\x8a\xc8\x94\x16\x87\x01\xc7m\xde8I\x98\x8a\xcd\x8c\xc9\xccx\xbdj\xbb\xf0\x8b")) {
    return;
  }

  if(condition_alert(!isent(notifyentity), "m6\xbc\x14\x90\x92\xd9\xa4t\xc1Y^l\x1a\xf7\xc9\x87z\x12\xf7NiPk\x10\xd9\x8b\xab\x14\x98\x92)X\xc5c\x93\x8c(\xe1\xcb#R\xc0\x96\xef\x93\xcc#K\xa9\xc7\xd3\x17")) {
    return;
  }

  if(condition_alert(!isstring(notifystring), "\xd8\x89\xb2\xac\xa1\xe3`\x1f\b?\x0f\x86\xfbt\xe0\xb8I\x80!\xe1>\x02\x1d!\xddt R\xdc\xee\xe9\x18\x1aQ$Ws\xc2\xf7\x02n\xde\x87\x0e\xde\x9e\xf1\xfe\x97`\x1e\x8f")) {
    return;
  }

  foreach(soundobj in makearray(soundobject)) {
    notifyentity thread function_42d03fe4d1ceef64(soundobj, notifyentity, notifystring, fadeoutseconds);
  }
}

function stop_on_ent_death(soundobject, deathentity, fadeoutseconds) {
  if(condition_alert(!function_79dd793aa6ffba4c(soundobject), "`\r\x88$\xe0w3<~\xc1\x98\x1e\xf8\xfd\b\xda\fW\x1a\xab\x17\xd0^\"fJ\b\xaf*\x05\xb0{\x13\xdeG{\x02\xec&\xe3\xc2\x10\xe5y\xf8Qw\x0fC")) {
    return;
  }

  if(condition_alert(!isent(deathentity), "#sq\x92\xec{\x11\x1a \x1d\x91\xad\xc7\xf1\xb7,020\xd3\x0e\x91\v\x01,s\xd2\x1e\x06!\xa7S`\xfb\xf3\xce[\xd0\x1bd'\x1b\xb1\x0e\xc2t")) {
    return;
  }

  foreach(soundobj in makearray(soundobject)) {
    deathentity thread function_42d03fe4d1ceef64(soundobj, deathentity, "\x1e\xfd\xd1\xa2\a", fadeoutseconds);
  }
}

function stop_on_level_notify(soundobject, levelnotifystring, fadeoutseconds) {
  if(condition_alert(!function_79dd793aa6ffba4c(soundobject), "7\x8e\xdbp}{\xb9\xbe\xc6Y\xec\xb2\xc6_s\xbdGK\x99^\x04\xe6\xbd\xab7\xc8\x9e\x98\xa6\xca\x1b\xe8\x01\xd2\xb9\x04\xcd\xb7\xa3 \xc2 7n\x91\x10\xb7L\xd4e\x8d\x1d")) {
    return;
  }

  if(condition_alert(!isstring(levelnotifystring), ":\xa5+R\x18T\b\xb0Cl\xd3\xbe\xfcb\xd4\x9a\xf8\xe5t\xda\x9e\xb0\xab\x81\x12\xc0:\xda\xb9)\xd4\xd9\x9d\x95i8\x9b\x11\xed\xf3\x83\xaa\xf7\x9f\x13\x92\x16X\x99\x95!\x13_>\xe9\xc3\x93\xab\xf3\xa3")) {
    return;
  }

  foreach(soundobj in makearray(soundobject)) {
    level thread function_f29a0b72917fcbe5(soundobj, levelnotifystring, fadeoutseconds);
  }
}

function await (soundobject) {
  if(condition_alert(!isDefined(soundobject), "7\xe6F\x8e\xe8\xb0\xdda-\xd1\x80\xdd-t\xd0\b\xae\xcd\x91\xb2\xccZ\xdc+\x91@\xcd\xbd]\xb9\x91\xf4\x13\xa6Vc\xd1")) {
    return 0;
  }

  starttime = gettime();
  waittime = 0;

  while(true) {
    var_c1480f5c2e2c015a = 0;
    soundobjects = makearray(soundobject);
    soundobjects = utility::array_removeundefined(soundobjects);

    foreach(soundobj in soundobjects) {
      if(function_79dd793aa6ffba4c(soundobj)) {
        var_c1480f5c2e2c015a = 1;
        break;
      }
    }

    if(var_c1480f5c2e2c015a == 0) {
      break;
    }

    waitframe();
  }

  endtime = gettime();
  waittime = endtime - starttime;
  waittime /= 1000;
  return waittime;
}

function function_79dd793aa6ffba4c(soundobject) {
  if(isDefined(soundobject) && isDefined(soundobject.soundtype)) {
    return true;
  }

  return false;
}

function function_3112c2fb5e8c355(targets) {
  sndobjs = [];

  foreach(target in makearray(targets)) {
    if(!isDefined(target)) {
      sndobjs = utility::array_combine(sndobjs, level.snd.objects);
      continue;
    }

    if(condition_alert(isnumber(target), "\x7f\xf6\x8fB\x9f\x17\xd2\xf3\x9e[\xdf\xed8'o\xff\xd5j\xb7\xc0\xfd\x7f\x9e\xa8\xa03\xbf)H\xff\xe8AK\x1a\x9f\b\xc5Z\xc3\xa1\v>\x97\xf7\xc8\xd3\r\xf5\xcb\xa2")) {
      if(function_b38f1279fae1d2cf()) {
        DevOp(0x2);
      }

      continue;
    }

    if(target == level) {
      sndobjs = utility::array_combine(sndobjs, level.snd.unlinkedobjects);
      continue;
    }

    if(isDefined(target.snd.objects)) {
      sndobjs = utility::array_combine(sndobjs, target.snd.objects);
    }
  }

  return sndobjs;
}

function function_9b66a8f958d6eb5e(soundalias, targets) {
  if(condition_alert(!isDefined(soundalias), "\xdcs#G\x8e\x9dV\x8e\xf5\xb0lZan\xfao\x13\xa6\xb2\xb1\xa3\x9b@\xdd\x96t\xd0\x10\xd5\xdcFY\xccZ7Y\x8c\x10\xdc\xdb\xean\x8ca6K\xc2s")) {
    return 0;
  }

  soundaliases = [];

  if(isarray(soundalias)) {
    foreach(alias in soundalias) {
      soundaliases[soundaliases.size] = tolower(alias);
    }
  } else if(isstring(soundalias)) {
    soundaliases = [tolower(soundalias)];
  }

  assert(isarray(soundaliases), "<dev string:x4d>");
  soundobjects = function_3112c2fb5e8c355(targets);
  aliasobjects = [];

  foreach(soundobj in soundobjects) {
    if(!isDefined(soundobj.soundalias)) {
      continue;
    }

    foreach(alias in soundaliases) {
      if(issubstr(tolower(soundobj.soundalias), alias)) {
        aliasobjects[aliasobjects.size] = soundobj;
      }
    }
  }

  return aliasobjects;
}

function function_e52ba9e9b6015b34(var_62002b7244c0136f = 1) {
  if(!isDefined(level.snd.fnplaysoundonentity)) {
    level.snd.fnplaysoundonentity = level.fnplaysoundonentity;
    level.snd.fnplaysoundontag = level.fnplaysoundontag;
    level.snd.fnnotetrackprefixhandler = level.fnnotetrackprefixhandler;
    level.snd.var_9d2a7fae864baf17 = anim.callbacks["\xef\xd8A\xd8\xcf\x9f\xd5\bPoA\xcfs\xa9\xe7\xb3\xed\x92j\x84\xa5"];
    level.snd.var_ceb72752a7785a5b = level.var_6d0c2d172e9d53b8;
    level.snd.var_5090fac159d6da05 = level.var_32967d1c9bb79138;
  }

  if(var_62002b7244c0136f) {
    level.fnplaysoundonentity = &function_27f5208847ded233;
    level.fnplaysoundontag = &function_7a6e5bed6c68b1aa;
    level.fnnotetrackprefixhandler = &function_965c52240ae28b5c;
    anim.callbacks["\xef\xd8A\xd8\xcf\x9f\xd5\bPoA\xcfs\xa9\xe7\xb3\xed\x92j\x84\xa5"] = &function_b922a2b9702afdeb;
    level.var_6d0c2d172e9d53b8 = &function_7df1e8394b0c7f2d;
    level.var_32967d1c9bb79138 = &function_cca0beaf30378757;
    return;
  }

  level.fnplaysoundonentity = level.snd.fnplaysoundonentity;
  level.fnplaysoundontag = level.snd.fnplaysoundontag;
  level.fnnotetrackprefixhandler = level.snd.fnnotetrackprefixhandler;
  anim.callbacks["\xef\xd8A\xd8\xcf\x9f\xd5\bPoA\xcfs\xa9\xe7\xb3\xed\x92j\x84\xa5"] = level.snd.var_9d2a7fae864baf17;
  level.var_6d0c2d172e9d53b8 = level.snd.var_ceb72752a7785a5b;
  level.var_32967d1c9bb79138 = level.snd.var_5090fac159d6da05;
}

function get_volume(soundobject) {
  if(isDefined(level.snd.callbacks["\xce\xbdl]\xb5\xb2\xf5\xec\xb2\x8e"])) {
    return [[level.snd.callbacks["\xce\xbdl]\xb5\xb2\xf5\xec\xb2\x8e"]]](soundobject);
  }

  return 1;
}

function set_volume(soundobject, volume, timeinseconds, curve, callbackfunc) {
  if(isDefined(level.snd.callbacks["\f\x9a?\xa3&\xd7\xd7\x03\x9b\xd4"])) {
    [[level.snd.callbacks["\f\x9a?\xa3&\xd7\xd7\x03\x9b\xd4"]]](soundobject, volume, timeinseconds, curve, callbackfunc);
  }
}

function get_pitch(soundobject) {
  if(isDefined(level.snd.callbacks["\x87N3\x99,?IL("])) {
    return [[level.snd.callbacks["\x87N3\x99,?IL("]]](soundobject);
  }

  return 1;
}

function set_pitch(soundobject, pitch, timeinseconds, curve, callbackfunc) {
  if(isDefined(level.snd.callbacks["{\x02\x1f\xafM\"T\x92\xba"])) {
    [[level.snd.callbacks["{\x02\x1f\xafM\"T\x92\xba"]]](soundobject, pitch, timeinseconds, curve, callbackfunc);
  }
}

function function_d503d212c3b8205e() {
  if(istrue(level.snd.var_47d98b44f58f4910)) {
    return "pK\xe4^8\xb6\xe5";
  }

  return "@:w\xc4\xdeL\xd5";
}

function function_ed619a79c1b63919() {
  return level.snd.var_eb8a31d84bf35094;
}

function function_2a47f7e5ff818905(type = function_d503d212c3b8205e()) {
  level.snd.var_eb8a31d84bf35094 = type_string(type);
}

function get_type(soundobject) {
  if(isDefined(soundobject.soundtype)) {
    return soundobject.soundtype;
  }

  return "";
}

function type_string(soundtype) {
  snd_type = undefined;

  switch (soundtype) {
    case #"hash_59f13b3cf23ba655":
      snd_type = "@:w\xc4\xdeL\xd5";
      break;
    case #"hash_9ffcd1094df9c111":
      snd_type = "pK\xe4^8\xb6\xe5";
      break;
    case #"hash_cb36e64f12ba9ad":
      snd_type = "\x01h\x86\xa3P\x84\x81";
      break;
    default:
      snd_type = undefined;
      break;
  }

  assert(isDefined(snd_type), "<dev string:x85>" + soundtype);
  return snd_type;
}

function private function_2ee5bbeb04e7fe3d(snd_type, snd_key, item) {
  assert(isstruct(level.snd), "<dev string:xa6>");
  assert(isDefined(level.snd.objects), "<dev string:xa6>");

  switch (snd_type) {
    default:
      assert(0, "<dev string:xc1>");
      break;
    case #"hash_59f13b3cf23ba655":
    case #"hash_9ffcd1094df9c111":
      level.snd.objects[snd_key] = item;
      break;
  }
}

function private function_285c980fdbcd850a(snd_type, snd_key, item) {
  assert(isstruct(level.snd), "<dev string:xa6>");
  assert(isDefined(level.snd.objects), "<dev string:xa6>");

  switch (snd_type) {
    default:
      assert(0, "<dev string:xc1>");
      break;
    case #"hash_59f13b3cf23ba655":
    case #"hash_9ffcd1094df9c111":
      assert(arraycontains(level.snd.objects, item), "<dev string:xd5>");
      level.snd.objects[snd_key] = undefined;
      break;
  }
}

function private function_cc44f8e09ee82adf() {
  snd_type = self.soundtype;
  snd_key = self.soundkey;
  self waittill("\x1e\xfd\xd1\xa2\a");
  function_285c980fdbcd850a(snd_type, snd_key, self);
}

function private function_db50b4e9bed70194(ent, var_ccba5562a939fb85, linkedentity, linkedbonetag) {
  assert(isDefined(ent), "<dev string:xfb>");
  assert(isDefined(ent.soundkey), "<dev string:x115>");

  if(isDefined(linkedentity)) {
    linkedbonetag = linkedentity gettagsafe(linkedbonetag);
    linkedoffset = (0, 0, 0);
    linkedangles = (0, 0, 0);

    if(isDefined(var_ccba5562a939fb85)) {
      linkedoffset = var_ccba5562a939fb85;
    }

    assert(isDefined(linkedbonetag), "<dev string:x130>");
    ent linkTo(linkedentity, linkedbonetag, linkedoffset, linkedangles);
    init_obj(linkedentity);

    if(!isarray(linkedentity.snd.objects)) {
      linkedentity.snd.objects = [];
    }

    linkedentity.snd.objects[ent.soundkey] = ent;
    return;
  }

  level.snd.unlinkedobjects[ent.soundkey] = ent;
}

function private function_d5146aff406b5027(soundalias, var_ccba5562a939fb85, linkedentity, linkedbonetag) {
  ent = undefined;
  spawnorigin = undefined;

  if(isDefined(linkedbonetag) && isDefined(linkedentity) && isDefined(var_ccba5562a939fb85)) {
    assert(linkedentity tagexists(linkedbonetag), "<dev string:x150>" + linkedbonetag);
    tag_origin = linkedentity gettagorigin(linkedbonetag);
    tag_angles = linkedentity gettagangles(linkedbonetag);
    tag_forward = var_ccba5562a939fb85[0] * anglesToForward(tag_angles);
    tag_right = var_ccba5562a939fb85[1] * anglestoright(tag_angles) * -1;
    tag_up = var_ccba5562a939fb85[2] * anglestoup(tag_angles);
    spawnorigin = tag_origin + tag_right + tag_forward + tag_up;
  } else if(isDefined(linkedentity) && isDefined(linkedbonetag)) {
    spawnorigin = linkedentity gettagorigin(linkedbonetag);
  } else if(isDefined(linkedentity)) {
    spawnorigin = linkedentity.origin;
  } else if(!isDefined(linkedentity) && !isDefined(var_ccba5562a939fb85)) {
    var_b6086890531fd821 = (0, 0, -32768);
    spawnorigin = var_b6086890531fd821;
  } else {
    spawnorigin = var_ccba5562a939fb85;
  }

  assert(isDefined(spawnorigin));
  ent = undefined;

  if(isDefined(linkedentity)) {
    ent = spawn("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6", spawnorigin);

    if(isent(ent)) {
      ent setModel("\xec\xbfK|\au\xcd\xc2\x19<");
    }
  } else {
    ent = spawn("\xdcc9-p\xd1\xbe\xedr\xa5v-\xdc", spawnorigin);
  }

  assert(isDefined(ent), "<dev string:x183>");

  if(isent(ent)) {
    ent.soundlinkedentity = linkedentity;
    ent.soundtype = "@:w\xc4\xdeL\xd5";
    ent.soundkey = ent getentitynumber();
    ent.targetname = "\xcc\x15j\xcc" + soundalias;
  }

  return ent;
}

function private function_42ebdec6cb8123aa(ent) {
  if(condition_alert(!isDefined(ent) || function_cd79b44ba8163808(ent), "\xfb\x80\xdf\xb0=\xef\x01\x1a\x1a ~\xf5\x13\xcdH\x1a\xaa)\xd1W\x11\xde\xc0\v\xd2e\x1f%")) {
    if(function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }

    return;
  }

  if(isDefined(ent.soundlinkedentity) && isarray(ent.soundlinkedentity.snd.objects)) {
    linkedentity = ent.soundlinkedentity;
    var_b40ca17709cc54d4 = isDefined(linkedentity.snd.objects[ent.soundkey]);

    if(var_b40ca17709cc54d4 == 1) {
      linkedentity.snd.objects[ent.soundkey] = undefined;
    } else {
      if(function_b38f1279fae1d2cf()) {
        DevOp(0x2);
      }
    }
  } else {
    level.snd.unlinkedobjects[ent.soundkey] = undefined;
  }

  waittillframeend();
  ent delete();
}

function private function_338bc70913a4063a(soundobject, soundalias, initialvolume, delaytime) {
  ent = soundobject;
  currentvolume = undefined;
  ent endon("\x1e\xfd\xd1\xa2\a");
  assert(isDefined(ent));
  assert(isstring(soundalias));
  currentvolume = get_volume(ent);

  if(!isDefined(initialvolume) && isDefined(currentvolume)) {
    initialvolume = currentvolume;
  }

  if(function_8c199b86b490e257()) {
    var_398a863a8ebd7a22 = !isDefined(delaytime) || isnumber(delaytime) && delaytime == 0;

    if(condition_alert(var_398a863a8ebd7a22, "\xa3\xf0\x18\x83\xf1@\\\x87\x84\xed\xf11\"\xc4w\xf5\x9d\xde\x05O\xefB\x05\x16\x12\xa7\x81\xc0\xb5\x14\xe2G")) {
      delaytime = 0.05;
    }
  }

  if(isnumber(delaytime) && delaytime > 0) {
    wait delaytime;
  }

  waittillframeend();
  assert(soundexists(soundalias), "<dev string:x1ab>" + soundalias);

  if(soundislooping(soundalias)) {
    ent playLoopSound(soundalias);
  } else {
    donenotifystr = "\xdc\xf6\xba\xdcFF\xdb\xe6e";

    if(utility::issp()) {
      ent playSound(soundalias, donenotifystr);
      var_261394f77c32f8cc = 0;

      if(var_261394f77c32f8cc) {
        ent thread function_452063a0bf7f6ea9(soundalias, donenotifystr);
      } else {
        ent thread function_5039d5327a67db3a(donenotifystr);
      }
    } else {
      if(isDefined(ent.soundlinkedentity) && isDefined(level.snd.fnplaysoundonmovingent)) {
        waitframe();
        ent[[level.snd.fnplaysoundonmovingent]](soundalias);
      } else {
        ent playSound(soundalias);
      }

      ent thread function_452063a0bf7f6ea9(soundalias, donenotifystr);
    }
  }

  ent.soundalias = soundalias;
}

function private function_2d3a231911e84088(soundobject, fadeoutseconds) {
  soundobject endon("\x1e\xfd\xd1\xa2\a");
  ent = soundobject;

  if(condition_alert(!isDefined(ent) || function_cd79b44ba8163808(ent), "&\xc9\x86\x8d\x9a\xd8\xaa\xb3\x80\x8e\x87\xfe\xc8\x8d5\xa3c:\x89)\xbc&\xb6\xfe\xec9\x06\x8b")) {
    if(function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }

    return;
  }

  soundalias = ent.soundalias;

  if(!isDefined(fadeoutseconds)) {
    fadeoutseconds = 0;
  }

  if(isstring(soundalias)) {
    if(istrue(soundislooping(soundalias))) {
      ent stoploopsound();
    } else {
      ent stopsounds();
    }

    waitframe();
    ent.soundalias = undefined;
  }

  ent.soundtype = undefined;
  function_42ebdec6cb8123aa(ent);
}

function private function_452063a0bf7f6ea9(soundalias, done) {
  ent = self;
  ent endon("\x1e\xfd\xd1\xa2\a");
  waittime = lookupsoundlength(soundalias);
  waittime *= 1.25;
  waittime /= 1000;
  pitchmin = function_9e4e272272a7638(soundalias, "\x80\x88\xf3_+7{li");

  if(isDefined(pitchmin)) {
    waittime *= 1 / pitchmin;
  }

  wait waittime;
  ent notify(done, ent.soundalias);
  function_42ebdec6cb8123aa(ent);
}

function private function_5039d5327a67db3a(done) {
  ent = self;
  ent endon("\x1e\xfd\xd1\xa2\a");
  ent waittill(done);
  ent notify(done, ent.soundalias);
  function_42ebdec6cb8123aa(ent);
}

function private function_50fcbd784771d4f8(ent, var_ccba5562a939fb85, linkedentity, linkedbonetag) {
  assert(0, "<dev string:x1c9>");
}

function private function_66883fd648d207cb(soundalias, var_ccba5562a939fb85, linkedentity, linkedbonetag) {
  assert(0, "<dev string:x1c9>");
  return undefined;
}

function private function_278086183316ca56(ent) {
  assert(0, "<dev string:x1c9>");
}

function private function_c82c4888dfa6ac6(soundobject, soundalias, initialvolume, delaytime) {
  assert(0, "<dev string:x1c9>");
}

function private function_f8e018ace8a0a67c(soundobject, fadeoutseconds) {
  assert(0, "<dev string:x1c9>");
}

function private function_214e94179a51980f() {
  player = self;
  vieworigin = player getEye();
  return vieworigin;
}

function private function_d771fb439e8fe2d5() {
  player = self;
  viewangles = player getplayerangles();
  return viewangles;
}

function private function_64c78109b4b654e2() {
  player = self;
  fov = getdvarfloat(@ "cg_fov", 65);
  return fov;
}

function private function_85c2bbea3deba348(soundarg) {
  delaytime = 0;
  soundalias = undefined;
  fadeinseconds = undefined;

  if(isarray(soundarg)) {
    keys = soundarg;
    soundalias = undefined;
    aliasindex = keys.size + 1;

    foreach(i, key in keys) {
      if(isstring(key)) {
        soundalias = key;
        aliasindex = i;
      }

      if(isnumber(key) && i < aliasindex) {
        delaytime = key;
      }

      if(isnumber(key) && i > aliasindex) {
        fadeinseconds = key;
      }
    }
  } else if(isstring(soundarg)) {
    soundalias = soundarg;
  }

  sndparam = [delaytime, soundalias, fadeinseconds];
  return sndparam;
}

function private function_a67a61bcf75db28d(targ) {
  targets = [];

  if(!isDefined(targ)) {
    foreach(player in getplayerssafe()) {
      tagname = player gettagsafe("\xa6\xeb\x1ae\x85#");

      if(player.model != "" && tagname != "") {
        targets[targets.size] = [player, tagname];
        continue;
      }

      targets[targets.size] = player;
    }
  } else if(isarray(targ)) {
    if(condition_alert(targ.size == 0, "N\x19~l\xde\xb0\x83\x9f\xfeL\x1a\x95e\xa0Bo\xc3U\x9c \xdd3^\x86\x80\xb1P\xf0\t\x10\x19\f\xdf\xde\xff")) {
      return undefined;
    } else if(targ.size == 2) {
      if(isent(targ[0]) && isstring(targ[1])) {
        targets = [targ];
      } else if(isent(targ[0]) && isvector(targ[1])) {
        targets = [targ];
      } else if(isent(targ[0]) && !isDefined(targ[1])) {
        targets = [targ[0]];
      } else if(isstring(targ[0]) && isstring(targ[1])) {
        firsttargets = gettargetnames(targ[0]);
        secondtargets = gettargetnames(targ[1]);
        targets = utility::array_combine(firsttargets, secondtargets);
      } else {
        targets = targ;
      }
    } else {
      targets = [];

      foreach(key in targ) {
        if(isent(key) || isstruct(key) && isDefined(key.origin) || isvector(key) || isarray(key)) {
          targets[targets.size] = key;
          continue;
        }

        if(isstring(key)) {
          tnames = gettargetnames(key);

          foreach(t in tnames) {
            targets[targets.size] = t;
          }
        }
      }
    }
  } else if(isstring(targ)) {
    targets = gettargetnames(targ);
  } else {
    targets = [targ];
  }

  return targets;
}

function private function_1342e0ddf8b14f84(soundtype, soundalias, var_e563e524099845a1, var_bb439247daf81ce2) {
  if(condition_alert(!did_init(), "\x13\xcd\x9d\xd3\x93\xf8v\xdf\x82\xb8`}\xcaLN\x19'L\xdf\xba1\xc0\x9d\xdd")) {
    if(function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }

    return undefined;
  }

  if(condition_alert(!isDefined(soundalias), "\xebL\xb5\xc8\xa4\xc4\x82\xbc\n\xc35\xf8\x80\xde\x1e\xafq\x0f\x87qx\x1a\x94\x1f\x8d\xdd\x1bb\xcd)\x13H")) {
    return undefined;
  }

  level.snd.callbacks["\x04M\xed\xab"] = &stop;
  assert(isDefined(level.snd.var_eb8a31d84bf35094), "<dev string:xa6>");

  if(!isDefined(soundtype)) {
    soundtype = level.snd.var_eb8a31d84bf35094;
  }

  soundobjects = [];
  targets = [];
  soundparam = function_85c2bbea3deba348(soundalias);
  assert(isarray(soundparam) && soundparam.size >= 2, "<dev string:x1ec>");
  delaytime = soundparam[0];
  soundalias = soundparam[1];
  fadeinseconds = soundparam[2];
  initialvolume = undefined;

  if(condition_alert(isstring(soundalias) && soundalias == "", "\xdc\xe62t\xa3\a\x1b\x16yG\b+m\x0e\x1d/\x02s\xedu7\x8c\x10XlZX\x9b\x02\"D")) {
    return undefined;
  }

  assert(isstring(soundalias), "<dev string:x209>");
  islooping = soundislooping(soundalias);
  sndexists = soundexists(soundalias);

  if(condition_alert(!sndexists, "\x01\xb9\xbb~g\xbd\xb0\f\xf2\xf2?\xd5\x1b\xc21E!\\" + soundalias + "\xd7'\xf7\xb7\xc7\b\x86\r\xf9D\bW\xfe'\xda\fd")) {
    if(function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }

    return undefined;
  }

  if(!isDefined(fadeinseconds)) {
    if(islooping) {
      fadeinseconds = level.snd.var_464acc2f92e0f4f2;
    } else {
      fadeinseconds = 0;
    }
  }

  if(isDefined(fadeinseconds) && fadeinseconds > 0) {
    initialvolume = 0;
  }

  assert(isDefined(fadeinseconds));
  targets = function_a67a61bcf75db28d(var_e563e524099845a1);

  if(condition_alert(!isDefined(targets), "\x88\xdb\x90\xdd<c\xa9\x91\x97\xb6\x03\x19V\x95\x93\x80\b\x18\x90V\x94\a")) {
    return undefined;
  }

  foreach(t in targets) {
    linkedentity = undefined;
    linkedbonetag = undefined;
    var_ccba5562a939fb85 = undefined;
    soundobject = undefined;
    ise = isent(t);
    isr = function_cd79b44ba8163808(t);
    iss = isstruct(t);
    isv = isvector(t);
    isn = isstring(t);
    isa = isarray(t);

    if(ise) {
      linkedentity = t;
      var_ccba5562a939fb85 = (0, 0, 0);
    } else if(condition_alert(isr, "\xe9\xf1\xf0\xdd}~u\bH\x83no\x88\xf7\xa3\xc9N\xf2\xb8;.}\xb2\xcb\x14\xfd}\xea\n\xfe\xe2\xac\xee\xf4\xb1n+")) {
      continue;
    } else if(iss) {
      if(condition_alert(!isDefined(t.origin), "\x01\xb9\xbb~g\xbd\xb0\f\xf2\xf2?\xd5\x1b\xc21E!\\" + soundalias + "\x93\x81g\x95@\x89\xfe\xf3\x02\x84Y\xb0Jv\xc6\x929\xb8t'\xdd\xf5\xe2\x01Y\xdc\xb6s\xc6\x1f\x04\xbb'\xbc")) {
        continue;
      } else {
        var_ccba5562a939fb85 = t.origin;
      }
    } else if(isv) {
      var_ccba5562a939fb85 = t;
    } else if(isn) {} else if(isarray(t)) {
      if(!isDefined(t[0]) || function_cd79b44ba8163808(t[0])) {
        continue;
      } else if(isent(t[0]) && isstring(t[1])) {
        linkedentity = t[0];
        linkedbonetag = t[1];
        var_ccba5562a939fb85 = (0, 0, 0);

        if(condition_alert(!linkedentity tagexists(linkedbonetag), "5A#y<{\x874\xd4\x05\xd8m0=\x01\x88\x9f\x06v\xeb\x19\xbc,\xb4\xdbxL\xf3\xd1\xf1\x94\x02" + linkedbonetag)) {
          linkedbonetag = "\xec\xbfK|\au\xcd\xc2\x19<";
        }

        if(isvector(t[2])) {
          var_ccba5562a939fb85 = t[2];
        }
      } else if(isent(t[0]) && isvector(t[1])) {
        linkedentity = t[0];
        var_ccba5562a939fb85 = t[1];
      } else if(condition_alert(1, ";\xf5\xd2\x810\xc5\x8f\x9c\xe10\xff:tq\xd8\xac\xfe\xf7a\xd6\x99\xea+lH*\xd0\xeb\x99:{\xa8\xed\xa77Gy[\xd2J")) {}
    }

    switch (soundtype) {
      default:
        assert(0, "<dev string:x226>");
        break;
      case #"hash_59f13b3cf23ba655":
        soundobject = function_d5146aff406b5027(soundalias, var_ccba5562a939fb85, linkedentity, linkedbonetag);

        if(isent(soundobject)) {
          function_db50b4e9bed70194(soundobject, var_ccba5562a939fb85, linkedentity, linkedbonetag);
          function_2ee5bbeb04e7fe3d("@:w\xc4\xdeL\xd5", soundobject.soundkey, soundobject);
          soundobject thread function_cc44f8e09ee82adf();
        }

        break;
      case #"hash_9ffcd1094df9c111":
        soundobject = function_66883fd648d207cb(soundalias, var_ccba5562a939fb85, linkedentity, linkedbonetag);

        if(isent(soundobject)) {
          function_50fcbd784771d4f8(soundobject, var_ccba5562a939fb85, linkedentity, linkedbonetag);
          function_2ee5bbeb04e7fe3d("pK\xe4^8\xb6\xe5", soundobject.soundkey, soundobject);
          soundobject thread function_cc44f8e09ee82adf();
        }

        break;
    }

    if(isDefined(soundobject) && function_79dd793aa6ffba4c(soundobject)) {
      switch (soundtype) {
        case #"hash_59f13b3cf23ba655":
        default:
          soundobject thread function_338bc70913a4063a(soundobject, soundalias, initialvolume, delaytime);
          break;
        case #"hash_9ffcd1094df9c111":
          soundobject thread function_c82c4888dfa6ac6(soundobject, soundalias, initialvolume, delaytime);
          break;
      }

      if(fadeinseconds > 0) {
        if(soundtype == "@:w\xc4\xdeL\xd5" && isDefined(linkedentity)) {
          delaytime += 0.05;
        }

        soundobject thread function_1deb9d23a3eda92c(soundobject, fadeinseconds, delaytime);
      }

      soundobjects[soundobjects.size] = soundobject;
    }
  }

  if(condition_alert(soundobjects.size == 0, "m'(\xd1\xd9\x8b:\xb2@\xbd0V\x06\xd9\xe1=@\xa1\xd9Ir\x12@\xf0\xf9\xb3\xef<\xae\xf3")) {
    return undefined;
  }

  return function_6e154eec09203976(soundobjects);
}

function private function_8b405a0079e6ff82(soundobject, fadeoutseconds) {
  if(condition_alert(!isstruct(level.snd) || !isDefined(level.snd.var_eb8a31d84bf35094), "G\xf6\xa4g\xe5H\xfd\xa4?\xef\xff\xc6\xbc\\\x8e\x98\xbf\xa2\xb3\xc8\xa0\n\xab")) {
    return;
  }

  if(condition_alert(!isDefined(soundobject) || function_cd79b44ba8163808(soundobject), "\xb9n#\xe8G\xdcG\xf6p\x10\xeeZ\xe8\x1a\x10u\xdcF\x953\xd2\xe6Yd\x02\xe6\xf6\xea\x9b2\xd3&\xd4+\xc6\x8e")) {
    return;
  }

  if(condition_alert(!isDefined(soundobject.soundtype), "\x03\x15\x9d\xc3k\xf8v\xa0\x9cS\xdfp\xc8{Y\xf1\x8e\xe7\xd3i\x10\xab\xe9a\xc2\xa3$")) {
    return;
  }

  assert(isDefined(level.snd.var_eb8a31d84bf35094), "<dev string:xa6>");
  assert(isDefined(soundobject), "<dev string:x240>");
  assert(isDefined(soundobject.soundtype), "<dev string:x26a>");

  if(soundobject.soundtype == "\x01h\x86\xa3P\x84\x81") {
    soundobject notify("\x86V\xbb\x88 Q\x8b\xe7\x87\x955\x11\xcc\f\xc8\xdd");
    soundobject.soundtype = undefined;
    soundobject.soundalias = undefined;
    soundobject.soundlinkedentity = undefined;
    soundobject.origin = undefined;
    soundobject.angles = undefined;
    return;
  }

  soundobject endon("\x1e\xfd\xd1\xa2\a");
  soundtype = soundobject.soundtype;
  soundalias = soundobject.soundalias;
  islooping = undefined;

  if(isstring(soundalias)) {
    islooping = soundislooping(soundalias);
  }

  if(istrue(islooping) && !isDefined(fadeoutseconds)) {
    fadeoutseconds = float(level.snd.var_464acc2f92e0f4f2);
  } else if(isnumber(fadeoutseconds)) {
    fadeoutseconds = float(fadeoutseconds);
  }

  if(isDefined(soundalias) && isfloat(fadeoutseconds)) {
    set_volume(soundobject, 0, fadeoutseconds);
    wait fadeoutseconds;
    waitframe();

    if(function_cd79b44ba8163808(soundobject)) {
      return;
    }
  }

  switch (soundtype) {
    case #"hash_59f13b3cf23ba655":
    default:
      function_2d3a231911e84088(soundobject, fadeoutseconds);
      break;
    case #"hash_9ffcd1094df9c111":
      function_f8e018ace8a0a67c(soundobject, fadeoutseconds);
      break;
  }
}

function private function_42d03fe4d1ceef64(soundobject, notifyentity, notifystring, fadeoutseconds) {
  soundobject endon("\x1e\xfd\xd1\xa2\a");
  notifyentity utility::waittill_any("\x1e\xfd\xd1\xa2\a", notifystring);
  function_8b405a0079e6ff82(soundobject, fadeoutseconds);
}

function private function_f29a0b72917fcbe5(soundobject, levelnotifystring, fadeoutseconds) {
  soundobject endon("\x1e\xfd\xd1\xa2\a");
  level waittill(levelnotifystring);
  function_8b405a0079e6ff82(soundobject, fadeoutseconds);
}

function private function_1deb9d23a3eda92c(soundobject, fadeinseconds, delaytime) {
  if(condition_alert(!isDefined(soundobject) || function_cd79b44ba8163808(soundobject), "6!\x03\x15v\x04\n\x89d\x02\x9d\x9e\xac\x8dT\x10\xe3_ *\x1a\xb7\x05\x88\xaf\xca6\xceZo\xd1J")) {
    return;
  }

  assert(isDefined(soundobject));
  soundobject endon("\x1e\xfd\xd1\xa2\a");
  soundobject endon("\xf1s \xbc\t0\x01{");

  if(!isDefined(delaytime)) {
    delaytime = 0;
  }

  set_volume(soundobject, 0, 0);

  if(delaytime > 0) {
    wait delaytime;
  }

  set_volume(soundobject, 1, fadeinseconds);
}

function function_abdb7485bb0c82d5(target) {
  position = undefined;

  if(isvector(target)) {
    position = target;
  } else if(isplayersafe(target)) {
    position = target getplayervieworigin();
  } else if(!function_cd79b44ba8163808(target) && isDefined(target.origin)) {
    position = target.origin;
  }

  return position;
}

function private function_84237c3263de3ef(rotationrange) {
  var_e67d84fbedc2b48e = randomfloatrange(-180, 180);
  rotation = 0;

  if(isarray(rotationrange)) {
    if(rotationrange.size == 1) {
      rotationrange = rotationrange[0];
    } else if(rotationrange.size == 2) {
      rotation = rangehelper(rotationrange);
    } else if(rotationrange.size == 3) {
      var_e67d84fbedc2b48e = rotationrange[0];
      rotation = rangehelper(rotationrange);
      adjustedrotationrange = [rotationrange[1], rotationrange[2]];
      rotation = rangehelper(adjustedrotationrange);
    } else if(rotationrange.size >= 4) {
      var_654bd89e4acf0865 = [rotationrange[0], rotationrange[1]];
      var_e67d84fbedc2b48e = rangehelper(var_654bd89e4acf0865);
      adjustedrotationrange = [rotationrange[2], rotationrange[3]];
      rotation = rangehelper(adjustedrotationrange);
    }
  }

  if(isnumber(rotationrange) && rotationrange != 0) {
    absrotation = abs(rotationrange);
    min = -1 * absrotation;
    max = absrotation;
    rotation = randomfloatrange(min, max);
  }

  return [var_e67d84fbedc2b48e, rotation];
}

function private function_f011185cc6b3e33(target, dist, var_e67d84fbedc2b48e, elevation, rotation) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\xdc\xf6\xba\xdcFF\xdb\xe6e");

  if(isDefined(rotation) == 0 || rotation == 0) {
    return;
  }

  assert(isent(target) || isstruct(target) && isDefined(target.origin) || isvector(target), "<dev string:x283>");
  assert(isnumber(dist), "<dev string:x283>");
  assert(isnumber(var_e67d84fbedc2b48e), "<dev string:x283>");
  assert(isnumber(rotation), "<dev string:x283>");

  if(function_8c35a6f99f836040() > 2) {
    randred = randomfloat(1);
    randgreen = randomfloat(1);
    randblue = randomfloat(1);
    randomcolor = (randred, randgreen, randblue);
    randomcolor = vectorNormalize(randomcolor);
    drawpath(self, randomcolor);
  }

  movetime = function_7c0b49ad82cf43cd() * 2;
  rotationstep = rotation * movetime;

  while(true) {
    centerorigin = function_abdb7485bb0c82d5(target);

    if(!isvector(centerorigin)) {
      break;
    }

    position = orbitalposition(centerorigin, dist, var_e67d84fbedc2b48e, elevation);
    self moveTo(position, movetime, 0, 0);
    var_e67d84fbedc2b48e += rotationstep;
    wait movetime;

    if(function_8c35a6f99f836040() <= 2) {
      self notify("<dev string:x287>");
    }
  }
}

function private _emitter_stop(emitter) {
  iss = isstruct(emitter);
  hast = isDefined(emitter.soundtype);
  ist = emitter.soundtype == "\x01h\x86\xa3P\x84\x81";
  is_emitter = iss && hast && ist;

  if(condition_alert(is_emitter == 0, "|\xecE|\x01\x8e\xe3r\xe1o\x10r\xcca\xda\x80\x87\xbf\xdd\xa7\x88\xbe\xd4\xe40\xea\xc5}R\xf4\r")) {
    return;
  }

  assert(isDefined(emitter.soundkey), "<dev string:x29c>");
  assert(isDefined(level.snd.emitterkey), "<dev string:x2bd>");
  assert(isDefined(level.snd.emitters), "<dev string:x2dd>");
  level.snd.emitters[emitter.soundkey] = undefined;
  emitter notify("\x86V\xbb\x88 Q\x8b\xe7\x87\x955\x11\xcc\f\xc8\xdd");
  emitter.soundtype = undefined;
  emitter.soundalias = undefined;
  emitter.soundlinkedentity = undefined;
  emitter.origin = undefined;
  emitter.angles = undefined;
  emitter = undefined;
}

function private _emitter(target) {
  self endon("\x86V\xbb\x88 Q\x8b\xe7\x87\x955\x11\xcc\f\xc8\xdd");
  level endon("\x86V\xbb\x88 Q\x8b\xe7\x87\x955\x11\xcc\f\xc8\xdd");
  assert(isDefined(target) && isarray(target) == 0, "<dev string:x30c>");

  if(isvector(target)) {
    target = self;
  }

  while(true) {
    wait rangehelper(self.spawntime, 0.05);

    if(!function_74533c23f03e096(target)) {
      break;
    }
  }
}

function private function_74533c23f03e096(target) {
  if(!isDefined(target)) {
    return false;
  }

  dist = rangehelper(self.distancerange ?? 0);
  var_2e18b3fe5e8a2444 = function_84237c3263de3ef(self.rotationrange);
  assert(isarray(var_2e18b3fe5e8a2444) && var_2e18b3fe5e8a2444.size != 0);
  var_e67d84fbedc2b48e = var_2e18b3fe5e8a2444[0];
  rotation = var_2e18b3fe5e8a2444[1];
  elevation = rangehelper(self.elevationrange ?? 0);
  targetposition = function_abdb7485bb0c82d5(target);
  position = orbitalposition(targetposition, dist, var_e67d84fbedc2b48e, elevation);
  sndobj = play(self.soundalias, position);

  if(isDefined(sndobj) && isDefined(dist) && dist > 0 && isDefined(rotation) && rotation != 0) {
    sndobj thread function_f011185cc6b3e33(target, dist, var_e67d84fbedc2b48e, elevation, rotation);
  }

  if(isarray(self.spawntime) && self.spawntime.size >= 4) {
    assert(self.spawntime.size == 4, "<dev string:x33c>");
    self.spawntime = [self.spawntime[2], self.spawntime[3]];
  }

  return true;
}

function emitter(soundalias, target, spawntime, distancerange, rotation, elevation) {
  emitters = [];
  targets = target;
  islooping = soundislooping(soundalias);
  isexists = isDefined(islooping);

  if(condition_alert(!isexists, "]\xc3\b\xf3\xcav\x13\x8c\xf8\x15\xa4\x05\xca\x17em\xa8\x906b\xae\x9fo\xbfj\xb5\xcf\xb7C\xf1O\x94w\x9bT\x18i\xa3:j" + soundalias)) {
    return undefined;
  }

  if(condition_alert(islooping, "\xf7M\xb0c\xea\x12\x86\x91iF\x1c\x88\xb3\xb3u\x9c\x9f\x850\xaf0R\xb6y\xcb\x86@\x8058MWm5\xd0\xf5p\xac4\xcb" + soundalias)) {
    return undefined;
  }

  if(!isDefined(level.snd.emitterkey)) {
    level.snd.emitterkey = 2432;
    level.snd.emitters = [];
  }

  assert(isDefined(level.snd.emitterkey), "<dev string:x2bd>");
  assert(soundexists(soundalias), "<dev string:x381>" + soundalias);
  assert(isDefined(target), "<dev string:x3ad>");
  assert(isDefined(spawntime), "<dev string:x3d1>");

  if(isarray(targets) == 0) {
    targets = [target];
  }

  foreach(t in targets) {
    ise = isent(t);
    isv = isvector(t);

    if(ise || isv) {
      emitter = spawnStruct();
      emitter.soundtype = "\x01h\x86\xa3P\x84\x81";
      emitter.soundalias = soundalias;
      emitter.spawntime = spawntime;
      emitter.distancerange = distancerange;
      emitter.rotationrange = rotation;
      emitter.elevationrange = elevation;
      level.snd.emitterkey = int(level.snd.emitterkey + 1);
      emitter.soundkey = "" + level.snd.emitterkey;
      level.snd.emitters[emitter.soundkey] = emitter;

      if(ise) {
        emitter.soundlinkedentity = t;
      }

      if(isv) {
        emitter.origin = t;
        emitter.angles = (0, 0, 0);
      }

      emitter thread _emitter(t);
      emitters[emitters.size] = emitter;
      continue;
    }

    condition_alert(ise == 0 && isv == 0, "\xce\xd2\xb4\x10\f\x176\xc3N\x06\x1f\x8d\xdc5,^\xb4$5\xdc\xa4" + t + "\x88\xaf5R\xd7\xbb\x11\xa2\x80\xba\x91P\xcfu~\xe9\x9a\xf8\xa0\xc8(\x1d+r\x80\x81u\x97u\xd5");
  }

  condition_alert(emitters.size == 0, "\x0f\xcfc\xcb-h!:\xc4\x14l\x8cy\xd6P\x14s7f\xea\x8fC\\\xdb\x94s\\!\xc7pa\xb3\xcf\x1a\x1e/f\xef\x06f$\x15\xfe\xc2\x10");
  return function_6e154eec09203976(emitters);
}

function private function_6b85990ffa2041b(ai_actor, snd) {
  if(isent(ai_actor) && ai_actor utility::ent_flag("\xa82L*I\xa1\xfc\xe0*H\xf8\n\x86\x98\xc7{\x9c\xf1\xe9Z")) {
    function_393e33ca166388ae(snd, ai_actor, "\x8f\x92c\b\xc9\x01D\xd8\xc8T\x15\b\xf5\xa8\x9a\xb7\x87\x8aY|\xf9\xa1~ \xc8$\x11");
  }
}

function private function_7a6e5bed6c68b1aa(alias, tag, ends_on_death, var_e0d135c5a1146a1f, radio_dialog) {
  if(utility::is_dead_sentient()) {
    return;
  }

  target = [self, tag];
  snd = function_1342e0ddf8b14f84(level.snd.var_eb8a31d84bf35094, alias, target);

  if(isDefined(level.player_radio_emitter) && self == level.player_radio_emitter) {
    println("<dev string:x3f8>" + alias);
  }

  if(isDefined(ends_on_death)) {
    assert(ends_on_death, "<dev string:x41a>");
    stop_on_ent_death(snd, self);
  }

  function_6b85990ffa2041b(self, snd);
  await (snd);

  if(isDefined(var_e0d135c5a1146a1f)) {
    self notify(var_e0d135c5a1146a1f);
  }
}

function private function_27f5208847ded233(alias, var_e0d135c5a1146a1f) {
  assert(!isspawner(self), "<dev string:x445>");
  function_7a6e5bed6c68b1aa(alias, undefined, undefined, var_e0d135c5a1146a1f);
}

function private function_b922a2b9702afdeb(soundalias, notifystring, var_5fbf44e11d40082e = 0) {
  if(!soundexists(soundalias)) {
    iprintln("<dev string:x466>" + soundalias);

    if(isstring(notifystring)) {
      waitframe();

      if(!isDefined(self)) {
        return;
      }

      self notify(notifystring);
      self notify("\xcam$[\x8b\xc4 \x1b\x9dm\x8e\x8e \x89\x86");
    }

    return;
  }

  target = [self, "\xa6\xeb\x1ae\x85#"];
  snd = function_1342e0ddf8b14f84(level.snd.var_eb8a31d84bf35094, soundalias, target);

  if(istrue(var_5fbf44e11d40082e)) {
    stop_on_ent_death(snd, self);
  }

  function_6b85990ffa2041b(self, snd);
  thread function_b3eb52a543e3adff(snd, notifystring);
}

function private function_b3eb52a543e3adff(snd, notifystring) {
  if(isDefined(notifystring)) {
    self.scripteddialoguenotify = gettime();
  } else {
    self.scripteddialoguenonotify = gettime();
  }

  await (snd);

  if(!isDefined(self)) {
    return;
  }

  if(isstring(notifystring)) {
    self notify(notifystring);
  }

  self.scripteddialoguenotify = undefined;
  self.scripteddialoguenonotify = undefined;
}

function private function_7df1e8394b0c7f2d(player, sound_emitter, alias) {
  assert(isPlayer(player));
  assert(isstruct(sound_emitter) || isent(sound_emitter));
  assert(isstring(alias) || isxhash(alias));
  context = "";

  if(istrue(self.isradioemitter)) {
    context = "\x94J\xd7\xf6\x9f\xee\x9a\nK\xb8\x8d";
  } else {
    if(isDefined(level.var_ae6466efd97ba73b) && isDefined(level.var_ae6466efd97ba73b[alias])) {
      radio_dist = level.var_ae6466efd97ba73b[alias];
    } else {
      radio_dist = function_5eb9f109964cd0fb(alias) * 0.25;
    }

    player_distsq = distancesquared(player getEye(), sound_emitter.origin);
    context = player_distsq < squared(radio_dist) ? "\xce6V\x80\xbb\x7f\x92d\x95\x9c\x9d" : "2x\xfa\xc9,\x19\x96\xf6_\x19\x8c";
  }

  return context;
}

function private function_cca0beaf30378757(sound_emitter, alias, contexttype, contextvalue, notification_string, var_f0e999956b095703) {
  sndobj = play(alias, sound_emitter);

  if(isent(sndobj)) {
    sndobj setentitysoundcontext(contexttype, contextvalue, 0);
    function_393e33ca166388ae(sndobj, self, "p]\xd4\x92\x97\xe9y\xb2\xfb\xcc\x94g\x86", 0.05);
  }
}

function private function_3b6ded823045a5ff() {
  canplayvo = !(istrue(level.missionfailed) && !istrue(level.notetrackmissionfailedvo) || !istrue(level.notetrackvo));
  return canplayvo;
}

function private function_965c52240ae28b5c(notetrack) {
  prefix = getsubstr(notetrack, 0, 3);

  if(prefix == "w\xa7\x04") {
    alias = getsubstr(notetrack, 3);
    params = strtok(alias, "\x16");

    if(params.size < 2) {
      thread function_7a6e5bed6c68b1aa(alias, undefined, 1);
    } else {
      thread function_7a6e5bed6c68b1aa(params[0], params[1], 1);
    }

    return 1;
  }

  if(prefix == "\xca!\xcf") {
    if(function_3b6ded823045a5ff()) {
      alias = getsubstr(notetrack, 3);

      if(isDefined(self.anim_playsound_func)) {
        self thread[[self.anim_playsound_func]](alias, "\xa6\xeb\x1ae\x85#", 1);
      } else if(isDefined(self.anim_playvo_func)) {
        self thread[[self.anim_playvo_func]](alias, "\xa6\xeb\x1ae\x85#", 1);
      } else {
        thread function_7a6e5bed6c68b1aa(alias, "\xa6\xeb\x1ae\x85#", 1, alias);
      }

      return 1;
    }
  }

  if(isDefined(level.snd.fnnotetrackprefixhandler)) {
    return self[[level.snd.fnnotetrackprefixhandler]](notetrack);
  }

  return 0;
}

function function_c6b6eb43d4704a68(curve, size) {
  lut = [];
  step = 1 / (size - 1);

  for(i = 0; i < size; i++) {
    x = i * step;
    y = 0;

    switch (curve) {
      default:
        assert(0);
        break;
      case #"hash_28724bf44fcad5a":
      case #"hash_a07b7ad0ae57b120":
        lut[0] = 0;
        lut[1] = 1;
        return lut;
      case #"hash_d14c288a042b2358":
        y = 0.5 + cos(x * 180) * -0.5;
        break;
      case #"hash_e5b5c9bbaf55cda4":
        y = 1 - cos(x * 90);
        break;
      case #"hash_c61d0274ec76f271":
        y = sin(x * 90);
        break;
      case #"hash_6975a515a3376748":
        y = 3 * pow(x, 2) - 2 * pow(x, 3);
        break;
      case #"hash_2e3e9521be134e7f":
        y = 1 - sqrt(1 - x * x);
        break;
      case #"hash_9e33f1e4dcc4f04":
        y = sqrt(1 - (1 - x) * (1 - x));
        break;
      case #"hash_e004d61d10ac743f":
        lut[0] = 0;
        lut[1] = 0.0158489;
        lut[2] = 0.0251189;
        lut[3] = 0.0398107;
        lut[4] = 0.0630957;
        lut[5] = 0.1;
        lut[6] = 0.158489;
        lut[7] = 0.251189;
        lut[8] = 0.398107;
        lut[9] = 0.630957;
        lut[10] = 1;
        return lut;
      case #"hash_3906f2285eb98bad":
        lut[0] = 0;
        lut[1] = 1.97531e-05;
        lut[2] = 0.000316049;
        lut[3] = 0.0016;
        lut[4] = 0.00505679;
        lut[5] = 0.0123457;
        lut[6] = 0.0256;
        lut[7] = 0.0474272;
        lut[8] = 0.0809086;
        lut[9] = 0.1296;
        lut[10] = 0.197531;
        lut[11] = 0.289205;
        lut[12] = 0.4096;
        lut[13] = 0.564168;
        lut[14] = 0.758835;
        lut[15] = 1;
        return lut;
    }

    lut[lut.size] = y;
  }

  return lut;
}

function curve_init(size = 11) {
  assert(isstruct(level.snd), "<dev string:x486>");
  level.snd.curves = [];
  level.snd.curves["s\xd9!`\x94\x9d"] = function_c6b6eb43d4704a68("s\xd9!`\x94\x9d", size);
  level.snd.curves[" u\x05\xe0"] = function_c6b6eb43d4704a68(" u\x05\xe0", size);
  level.snd.curves["\x0f\xaa\x01\xdb\x18\xbe"] = function_c6b6eb43d4704a68("\x0f\xaa\x01\xdb\x18\xbe", size);
  level.snd.curves["m\xa29\xe3A\xe8D"] = function_c6b6eb43d4704a68("m\xa29\xe3A\xe8D", size);
  level.snd.curves["\x19\xe4\xf8\xed\r\x1a\xf9\xf2%"] = function_c6b6eb43d4704a68("\x19\xe4\xf8\xed\r\x1a\xf9\xf2%", size);
  level.snd.curves["CZ\xb5\xd5Z\v&\x10\xf6\x89"] = function_c6b6eb43d4704a68("CZ\xb5\xd5Z\v&\x10\xf6\x89", size);
  level.snd.curves["\xb8W\xd8=[\xe4\x8f\v\xa8M\xf5"] = function_c6b6eb43d4704a68("\xb8W\xd8=[\xe4\x8f\v\xa8M\xf5", size);
  level.snd.curves["?\xc6=:\xb0\xd8\xf8w\x8c\xbf\xa0\x92a\xbe\xc85"] = function_c6b6eb43d4704a68("?\xc6=:\xb0\xd8\xf8w\x8c\xbf\xa0\x92a\xbe\xc85", size);
  level.snd.curves[")P4\xb9\n\xfe\xfc\xee'\xc8\x92+\xdb\x12W\x14"] = function_c6b6eb43d4704a68(")P4\xb9\n\xfe\xfc\xee'\xc8\x92+\xdb\x12W\x14", size);
  level.snd.curves["\xc5\x99\x17\xf8\xa9\x85\x05\x8d\x18\xfb\xa4Ki\xfb:"] = function_c6b6eb43d4704a68("\xc5\x99\x17\xf8\xa9\x85\x05\x8d\x18\xfb\xa4Ki\xfb:", size);
}

function private function_ef8a6abaa093df27(alias) {
  if(!isDefined(alias)) {
    return "m\xa29\xe3A\xe8D";
  }

  switch (alias) {
    case #"hash_e72a3996c47e1ac9":
      return "m\xa29\xe3A\xe8D";
  }

  return alias;
}

function curve_size(curve) {
  lut = level.snd.curves[function_ef8a6abaa093df27(curve)];

  if(isDefined(lut)) {
    return lut.size;
  }

  return 0;
}

function curve_exists(curve) {
  lut = level.snd.curves[curve];

  if(isDefined(lut)) {
    return true;
  }

  return false;
}

function curve_value(inval, curve) {
  curve = function_ef8a6abaa093df27(curve);
  lut = level.snd.curves[curve];
  assert(isDefined(lut), "<dev string:x4a2>" + curve);
  inval = clamp(inval, 0, 1);
  outval = 0;
  step = 1 / (lut.size - 1);

  if(inval == 0) {
    return 0;
  }

  if(inval == 1) {
    return 1;
  }

  for(i = 0; i < lut.size; i++) {
    stepx = i * step;
    stepn = (i + 1) * step;

    if(inval >= stepx && inval <= stepn) {
      diffx = inval - stepx;
      diffn = stepn - stepx;
      diff = diffx / diffn;
      valx = lut[i];
      valn = lut[i + 1];
      valdiff = valn - valx;
      outval = valx + valdiff * diff;
      break;
    }
  }

  return outval;
}

function private function_bc905322ab99ef52(name) {
  if(isDefined(self.snd.params) == 0) {
    return;
  }

  if(isDefined(name)) {
    if(isDefined(self.snd.params[name])) {
      if(isDefined(self.snd.params[name].stopcallback)) {
        self[[self.snd.params[name].stopcallback]](self.snd.params[name].userdata);
      }

      self.snd.params[name] = undefined;
    }
  } else {
    foreach(p in self.snd.params) {
      if(isDefined(p.stopcallback)) {
        self[[p.stopcallback]](p.userdata);
      }

      self.snd.params = undefined;
    }
  }

  if(isDefined(self.snd.params) == 0 || self.snd.params.size == 0) {
    level.snd.param_ents = arrayremove(level.snd.param_ents, self);
    level.snd.param_ents = utility::array_removeundefined(level.snd.param_ents);
    self.snd.params = undefined;
    self.snd.paramthread = undefined;
    self notify("{\xbe\x8d2E\x83ah\x81\x9c");
  }
}

function private function_6e196ffe30fdde4e() {
  self endon("{\xbe\x8d2E\x83ah\x81\x9c");
  utility::waittill_any("\x1e\xfd\xd1\xa2\a", "\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  function_bc905322ab99ef52();
}

function private function_458e2e9ff5de53f4() {
  if(isDefined(self.snd.paramthread)) {
    return;
  }

  self.snd.paramthread = getthread();
  thread function_6e196ffe30fdde4e();
  self endon("\xf4\x9c \x0f\xaa\x9d\xbf,a\x16");
  self endon("{\xbe\x8d2E\x83ah\x81\x9c");

  while(function_cd79b44ba8163808(self) == 0 && isDefined(self.snd.params) && self.snd.params.size > 0) {
    now = gettime();

    foreach(p in self.snd.params) {
      p.isprocessing = 1;

      if(isDefined(p.inputcallback)) {
        assert(isent(self), "<dev string:x4d4>");
        p.inputvalue = self[[p.inputcallback]](p.userdata);
        assert(gettime() == now, "<dev string:x51b>");
      }

      if(isDefined(p.outputcallbacks)) {
        if(p.userdata.size > 0) {
          assert(p.outputcallbacks.size == p.userdata.size, "<dev string:x555>");
        }

        foreach(outputcallback in p.outputcallbacks) {
          if(isent(self)) {
            userdata = undefined;

            if(p.userdata.size > 0) {
              userdata = p.userdata[index];
            }

            self thread[[outputcallback]](p.inputvalue, userdata);
          }
        }
      }

      p.isprocessing = undefined;
    }

    waitframe();
  }

  if(function_cd79b44ba8163808(self)) {
    function_bc905322ab99ef52();
  }
}

function private function_ed1206b4dd1809d3(name) {
  if(isDefined(level.snd.param_ents) == 0) {
    level.snd.param_ents = [];
  }

  assert(isarray(level.snd.param_ents), "<dev string:x587>");
  init_obj(self);

  if(isDefined(self.snd.params) == 0) {
    self.snd.params = [];
  }

  assert(isarray(self.snd.params), "<dev string:x5ae>");

  if(isDefined(self.snd.params[name]) == 0) {
    self.snd.params[name] = spawnStruct();
  }

  if(arraycontains(level.snd.param_ents, self) == 0) {
    level.snd.param_ents[level.snd.param_ents.size] = self;
  }
}

function param_input(name, inputcallback) {
  function_ed1206b4dd1809d3(name);
  self.snd.params[name].inputcallback = inputcallback;
  self.snd.params[name].inputvalue = undefined;
  thread function_458e2e9ff5de53f4();
}

function param_output(name, outputcallback, userdata) {
  function_ed1206b4dd1809d3(name);

  if(isDefined(self.snd.params[name].outputcallbacks) == 0) {
    self.snd.params[name].outputcallbacks = [];
  }

  assert(isDefined(self.snd.params[name]), "<dev string:x5d6>" + name + "<dev string:x5ec>");
  assert(isDefined(self.snd.params[name].outputcallbacks), "<dev string:x5ae>");
  assert(isarray(self.snd.params[name].outputcallbacks), "<dev string:x5ae>");
  outputcallbackindex = self.snd.params[name].outputcallbacks.size;
  self.snd.params[name].outputcallbacks[outputcallbackindex] = outputcallback;

  if(isDefined(self.snd.params[name].userdata) == 0) {
    self.snd.params[name].userdata = [];
  }

  if(arraycontains(self.snd.params[name].userdata, userdata) == 0) {
    userdataindex = self.snd.params[name].userdata.size;
    self.snd.params[name].userdata[userdataindex] = userdata;
  } else {
    if(function_1bf6b0f15d5c7e6()) {
      DevOp(0x2);
    }
  }

  thread function_458e2e9ff5de53f4();
}

function private function_7f86dc2a784957d9(name, startcallback, stopcallback) {
  function_ed1206b4dd1809d3(name);
  self.snd.params[name].startcallback = startcallback;
  self.snd.params[name].stopcallback = stopcallback;

  if(isDefined(self.snd.params[name].startcallback)) {
    self[[self.snd.params[name].startcallback]]();
  }
}

function param_stop(name) {
  function_bc905322ab99ef52(name);
}

function param(name, startcallback, inputcallback, outputcallback, stopcallback, userdata) {
  function_7f86dc2a784957d9(name, startcallback, stopcallback);
  param_input(name, inputcallback);
  param_output(name, outputcallback, userdata);
}

function function_267d3edabd7d8cd9(name) {
  if(isDefined(self.snd.params[name]) && isDefined(self.snd.params) && isDefined(self.snd.params[name].inputcallback)) {
    p = self.snd.params[name];

    if(isDefined(p.inputvalue)) {
      return p.inputvalue;
    } else {
      return self[[p.inputcallback]](p.userdata);
    }
  }

  return undefined;
}

function param_exists(name) {
  if(isDefined(self.snd.params) && isarray(self.snd.params) && isDefined(self.snd.params[name])) {
    return true;
  }

  return false;
}

function function_d05b2cabbd8098f9(inputcallback) {
  if(isDefined(self.snd.params) && isarray(self.snd.params)) {
    foreach(p in self.snd.params) {
      if(p.inputcallback == inputcallback) {
        return true;
      }
    }
  }

  return false;
}

function private function_df4246cd5d00d4f9(userdata) {
  assert(isDefined(self.origin));
  now = gettime();

  if(isDefined(self.origin_velocity_time) && self.origin_velocity_time == now) {
    assert(isDefined(self.origin_velocity));
    return self.origin_velocity;
  }

  if(isDefined(self.origin_last) == 0) {
    self.origin_last = self.origin;
  }

  delta = self.origin - self.origin_last;
  self.origin_velocity = delta;
  self.origin_velocity_time = now;
  self.origin_last = self.origin;
  return self.origin_velocity;
}

function private function_8477c3968a5492b(userdata) {
  assert(isDefined(self.origin));
  assert(isDefined(self.snd));
  assert(isDefined(self.snd.origin_speed));
  velocity = function_df4246cd5d00d4f9();
  speed = length(velocity);
  self.snd.origin_speed = smoothvalue(speed, self.snd.origin_speed, 0.05);

  if(function_8c35a6f99f836040() >= 2) {
    debugspeed = self.snd.origin_speed;

    if(debugspeed < 0.001) {
      debugspeed = 0;
    }

    debugspeedtext = printdecimalcount(debugspeed * function_c06479d09e00277a() * 0.0568182, 1) + "<dev string:x60b>" + printdecimalcount(debugspeed, 1) + "<dev string:x616>";
    debugcolor = level.snd.debug.color_3d;
    debugalpha = 0.9;
    debugalphasq = debugalpha * debugalpha;
    debugscale = level.snd.debug.scale_3d;
    colorscale = level.snd.debug.color_scale;
    debugcolor = function_91e4e5dcd3f773b0(debugcolor, colorscale * 10);
    debugframes = 1;
    debugoffset = (0, 0, 4 * debugscale * 16);
    print3dplus(debugspeedtext, self.origin + debugoffset, -1 * debugscale, "<dev string:x61e>", debugcolor, debugalpha, (0, 0, 0), debugalphasq, (1, 1, 1), debugalphasq, debugframes);
  }

  return self.snd.origin_speed;
}

function private function_3b2aa69dbd11085e(userdata) {
  assert(isDefined(self.angles));
  now = gettime();

  if(isDefined(self.angle_time) && self.angle_time == now) {
    assert(isDefined(self.snd.angles));
    return self.snd.angles;
  }

  angles = self.angles;

  if(isplayersafe(self)) {
    angles = getplayerviewangles();
  } else if(isDefined(self.model)) {
    hastag = 0;

    if(hastag == 0) {
      angles = self gettagangles("\xec\xbfK|\au\xcd\xc2\x19<");
    }
  }

  angles = function_fa7ff1b5469aded6(angles);

  if(isDefined(self.snd.angles) == 0) {
    self.snd.angles = angles;
  }

  if(isDefined(self.snd.angles_last) == 0) {
    self.snd.angles_last = angles;
  }

  self.snd.angles_last = self.snd.angles;
  self.snd.angles = angles;
  return self.snd.angles;
}

function private function_7e9705510eb41af5(userdata) {
  angles = function_3b2aa69dbd11085e(userdata);
  self.snd.angle_velocity = angles - self.snd.angles_last;
  return self.snd.angle_velocity;
}

function private function_e71dcc71d939f289(speedlayer, initialvolume, initialpitch) {
  speedlayer.snd = play(speedlayer.soundalias, speedlayer.target);
  set_volume(speedlayer.snd, initialvolume, 0);
  set_pitch(speedlayer.snd, initialpitch, 0);
}

function private function_1f7da93a18ba1a7d(speedlayer, fadetime, fadecurve) {
  if(isDefined(speedlayer) && isDefined(speedlayer.snd)) {
    if(!isDefined(fadetime)) {
      fadetime = 0;
    }

    if(!isDefined(fadecurve)) {
      fadecurve = "\x19\xe4\xf8\xed\r\x1a\xf9\xf2%";
    }

    if(isDefined(fadetime) && fadetime > 0) {
      set_volume(speedlayer.snd, 0, fadetime, fadecurve);
      wait fadetime;
    }

    stop(speedlayer.snd);
    speedlayer.snd = undefined;
  }
}

function private function_c23eab2ebe6465f8(inputvalue, userdata) {
  speed = inputvalue;
  v = userdata;

  if(speed < 0.01) {
    speed = 0;
  }

  volumespeedmin = v.volumedict["\xa2\xac\xd9\xd7H"][0];
  volumespeedmax = v.volumedict["\xa2\xac\xd9\xd7H"][1];
  volumescalemin = v.volumedict["\x93\"X\xef&"][0];
  volumescalemax = v.volumedict["\x93\"X\xef&"][1];
  volumecurve = v.volumedict["\xf2\xce\xe9\x05\xb6"][0];
  pitchspeedmin = v.pitchdict["\xa2\xac\xd9\xd7H"][0];
  pitchspeedmax = v.pitchdict["\xa2\xac\xd9\xd7H"][1];
  pitchscalemin = v.pitchdict["\x93\"X\xef&"][0];
  pitchscalemax = v.pitchdict["\x93\"X\xef&"][1];
  pitchcurve = v.pitchdict["\xf2\xce\xe9\x05\xb6"][0];
  volume = scalerp(speed, volumespeedmin, volumespeedmax, volumescalemin, volumescalemax);
  pitch = scalerp(speed, pitchspeedmin, pitchspeedmax, pitchscalemin, pitchscalemax);

  if(isDefined(self.snd.doppler) && isDefined(self.snd.doppler.value)) {
    pitch *= self.snd.doppler.value;
  }

  if(isDefined(v.snd) && volume <= 0.001) {
    thread function_1f7da93a18ba1a7d(v);
    return;
  } else if(isDefined(v.snd) == 0 && volume > 0.001) {
    function_e71dcc71d939f289(v, volume, pitch);
    v.speed_last = speed;
    return;
  }

  if(isDefined(v.snd) && isDefined(v.speed_last)) {
    speed_delta = abs(speed - v.speed_last);

    if(speed_delta > 0.01) {
      set_volume(v.snd, volume, 0.05, volumecurve);
      set_pitch(v.snd, pitch, 0.05, pitchcurve);
      v.speed_last = speed;
    }
  }
}

function private function_c3c26f15e7fb5b39(userdata) {
  fadeout = self.snd.speedsfadeout;
  fadeoutcurve = self.snd.speedsfadeoutcurve;

  if(isDefined(userdata)) {
    foreach(v in userdata) {
      thread function_1f7da93a18ba1a7d(v, fadeout, fadeoutcurve);
    }
  }

  self.snd.var_c069610c55d12a1c = undefined;
  self.snd.speedsfadeout = undefined;
  self.snd.speedsfadeoutcurve = undefined;
  self.snd.speeds = undefined;
}

function private function_e8f1184a5c40bef6(target, soundalias, pitchdict, volumedict) {
  ent = undefined;
  islooping = soundislooping(soundalias);

  if(!isarray(target)) {
    ent = target;
  } else if(target.size > 0) {
    ent = target[0];
  }

  if(condition_alert(!isent(ent), "\x85\xbb\x849\xbd;\x1c<|#3\xd1\x80a\x1e\x9d\xd9\xadZm\xed\xa8=\x02>;\xb6\xba\xa0'%\x81@\xd3W\xb9")) {
    return;
  }

  if(condition_alert(!isDefined(islooping), "\x17I\x1b\x0eu\xd7\xc0\x90\x92S\x19u\x87\x18\xd9\"\xcf\xe8\xa9" + soundalias + "\xd7'\xf7\xb7\xc7\b\x86\r\xf9D\bW\xfe'\xda\fd")) {
    return;
  }

  if(condition_alert(!istrue(islooping), "\x17I\x1b\x0eu\xd7\xc0\x90\x92S\x19u\x87\x18\xd9\"\xcf\xe8\xa9" + soundalias + "\x88{\t\x9b\xe4\xd4\xfd0+l?xZ\xd5\xaf\xb3\xfd")) {
    return;
  }

  if(condition_alert(!isarray(pitchdict), "|\xdcLt\xafh\xa2\x8c\xa7\xea11\xd5\xae\xda\xbe\xbc\xae\xb4\xcd\x14\x82\x11\xb6\x92\xfb\xdf\x0eOX\xa5\x15\xe7\xb9\xa9N\xc1\x0e")) {
    return;
  }

  if(condition_alert(!isarray(volumedict), "\xe3\x1f\x98V\x92\xda8,m\x1e2\xeb\x9c*P\xfdM\xca\x0eR\x83N[}\xbf\x88dOM\xed\xbb\xafS\xd1\xf1w\xba\x01P")) {
    return;
  }

  init_obj(ent);
  assert(isstruct(ent.snd), "<dev string:x628>");
  speedlayer = spawnStruct();
  speedlayer.soundalias = soundalias;
  speedlayer.target = target;
  speedlayer.pitchdict = pitchdict;
  speedlayer.volumedict = volumedict;

  if(!isDefined(speedlayer.pitchdict["\xf2\xce\xe9\x05\xb6"])) {
    speedlayer.pitchdict["\xf2\xce\xe9\x05\xb6"] = ["s\xd9!`\x94\x9d"];
  }

  if(!isDefined(speedlayer.volumedict["\xf2\xce\xe9\x05\xb6"])) {
    speedlayer.volumedict["\xf2\xce\xe9\x05\xb6"] = ["&\x94D9T"];
  }

  if(!isDefined(ent.snd.speeds)) {
    ent.snd.speeds = [];
  }

  ent.snd.speeds[ent.snd.speeds.size] = speedlayer;
  ent.snd.origin_speed = 0;
  ent param("\xa2\xac\xd9\xd7H", undefined, &function_8477c3968a5492b, &function_c23eab2ebe6465f8, &function_c3c26f15e7fb5b39, speedlayer);
}

function speed_stop(target, fadeout = 0.05, fadeoutcurve = "\x19\xe4\xf8\xed\r\x1a\xf9\xf2%") {
  ent = undefined;

  if(!isarray(target)) {
    ent = target;
  } else if(target.size > 0) {
    ent = target[0];
  }

  if(condition_alert(!isent(ent), "\x85\xbb\x849\xbd;\x1c<|#3\xd1\x80a\x1e\x9d\xd9\xadZm\xed\xa8=\x02>;\xb6\xba\xa0'%\x81@\xd3W\xb9")) {
    return;
  }

  ent.snd.var_c069610c55d12a1c = 1;
  ent.snd.speedsfadeout = fadeout;
  ent.snd.speedsfadeoutcurve = fadeoutcurve;
  ent param_stop("\xa2\xac\xd9\xd7H");
}

function speed(target, alias, pitchdict, volumedict) {
  level thread function_e8f1184a5c40bef6(target, alias, pitchdict, volumedict);
}

function doppler_scale(src_origin, src_velocity, src_scale, dst_origin, dst_velocity, dst_scale, var_70a311aaf8b10353) {
  assert(isvector(src_origin));
  assert(isvector(src_velocity));
  assert(isvector(dst_origin));
  assert(isvector(dst_velocity));

  if(!isDefined(src_scale)) {
    src_scale = 1;
  }

  if(!isDefined(dst_scale)) {
    dst_scale = 1;
  }

  if(!isDefined(var_70a311aaf8b10353)) {
    var_70a311aaf8b10353 = 343.3;
  }

  if(src_scale == 0 && dst_scale == 0 || var_70a311aaf8b10353 == 0) {
    return [0, 0, 0];
  }

  var_af413d37c3447285 = 39.3701 * var_70a311aaf8b10353;
  assert(isnumber(src_scale));
  assert(isnumber(dst_scale));
  assert(isnumber(var_af413d37c3447285));
  delta_origin = src_origin - dst_origin;
  len = length(delta_origin);
  var_921db569985f8c5f = 0;
  var_d9c733db386ca1e6 = 0;

  if(src_scale > 0 && src_velocity != (0, 0, 0)) {
    var_921db569985f8c5f = vectordot(src_velocity, delta_origin) / len;
    var_921db569985f8c5f *= src_scale;
  }

  if(dst_scale > 0 && dst_velocity != (0, 0, 0)) {
    var_d9c733db386ca1e6 = vectordot(dst_velocity, delta_origin) / len;
    var_d9c733db386ca1e6 *= dst_scale;
  }

  dopplerscale = (var_af413d37c3447285 - var_921db569985f8c5f) / (var_af413d37c3447285 - var_d9c733db386ca1e6);
  return [dopplerscale, var_921db569985f8c5f, var_d9c733db386ca1e6];
}

function private function_35706d75cc58041e() {}

function private function_b162e6ab5cd253ca(userdata) {
  var_efdade3ef0f9e3f1 = arraycopy(level.snd.param_ents);
  dopplercount = 0;
  dopplerplayers = [];
  var_efdade3ef0f9e3f1 = arrayremove(var_efdade3ef0f9e3f1, self);

  foreach(var_42092f8ad997e9ca in var_efdade3ef0f9e3f1) {
    if(var_42092f8ad997e9ca param_exists("\x04\xcc\xf6\xe0\xbbff")) {
      dopplercount += 1;

      if(isplayersafe(var_42092f8ad997e9ca)) {
        dopplerplayers[dopplerplayers.size] = var_42092f8ad997e9ca;
      }
    }
  }

  if(dopplercount == dopplerplayers.size) {
    foreach(player in dopplerplayers) {
      player param_stop("\x04\xcc\xf6\xe0\xbbff");
    }
  }
}

function private function_d7f50f8d0c2ea603(inputvalue, userdata) {
  player = userdata;

  if(!isplayersafe(player)) {
    return;
  }

  assert(isDefined(player));
  assert(isDefined(self));
  assert(isDefined(self.snd));
  assert(isDefined(self.snd.doppler));
  assert(isDefined(self.snd.doppler.scale));
  assert(isDefined(self.snd.doppler.playerscale));
  src_origin = self.origin;
  src_velocity = inputvalue;
  src_scale = self.snd.doppler.scale;
  dst_origin = player getplayervieworigin();
  dst_velocity = player function_267d3edabd7d8cd9("\x04\xcc\xf6\xe0\xbbff");
  dst_scale = self.snd.doppler.playerscale;

  if(isDefined(dst_velocity) == 0 || self.snd.doppler.playerscale == 0) {
    dst_velocity = (0, 0, 0);
  }

  assert(isvector(src_origin));
  assert(isvector(src_velocity));
  assert(isnumber(src_scale));
  assert(isvector(dst_origin));
  assert(isvector(dst_velocity));
  assert(isnumber(dst_scale));
  dopplervalues = doppler_scale(src_origin, src_velocity, src_scale, dst_origin, dst_velocity, dst_scale);
  dopplerscale = dopplervalues[0];

  if(isDefined(self.snd.doppler.pitchscale)) {
    dopplerscale *= self.snd.doppler.pitchscale;
  }

  dopplerscale = clamp(dopplerscale, 0.01, 2);
  self.snd.doppler.value = dopplerscale;

  if(function_79dd793aa6ffba4c(self)) {
    set_pitch(self, dopplerscale, function_7c0b49ad82cf43cd());
  }

  if(function_8c35a6f99f836040() > 1) {
    debugscale = level.snd.debug.scale_3d;
    audiocolor = level.snd.debug.color_3d;
    colorscale = level.snd.debug.color_scale;
    selectioncolor = function_91e4e5dcd3f773b0(audiocolor, colorscale * 10);
    var_c753bc6b913cb165 = dopplervalues[1];
    dist = distance(src_origin, dst_origin);
    fixeddistscalar = dist * 0.002;
    scale = debugscale * 0.666 * fixeddistscalar;
    alpha = 1;
    alphasq = alpha * alpha;
    var_175558608eee52cc = "<dev string:x64c>";
    var_b60134d905ceb885 = dopplerscale + "<dev string:x659>" + var_c753bc6b913cb165;
    print3dplus(var_175558608eee52cc, src_origin + (0, 0, -1 * scale * 16), scale, "<dev string:x660>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
    print3dplus(var_b60134d905ceb885, src_origin + (0, 0, -1 * scale * 16), scale, "<dev string:x669>", selectioncolor, alpha, (0, 0, 0), alphasq, (1, 1, 1), alphasq, 1);
  }
}

function private _doppler_main(player, dopplerscale, pitchscale, playervelocityscale) {
  assert(isplayersafe(player));

  if(!isDefined(dopplerscale)) {
    dopplerscale = 1;
  }

  if(!isDefined(pitchscale)) {
    pitchscale = 1;
  }

  if(!isDefined(playervelocityscale)) {
    playervelocityscale = 1;
  }

  assert(isDefined(player));

  if(playervelocityscale > 0) {
    player param("\x04\xcc\xf6\xe0\xbbff", undefined, &function_df4246cd5d00d4f9);
  }

  if(function_cd79b44ba8163808(self)) {
    return;
  }

  init_obj(self);
  self.snd.doppler = spawnStruct();
  self.snd.doppler.scale = dopplerscale;
  self.snd.doppler.pitchscale = pitchscale;
  self.snd.doppler.playerscale = playervelocityscale;
  param("\x04\xcc\xf6\xe0\xbbff", undefined, &function_df4246cd5d00d4f9, &function_d7f50f8d0c2ea603, &function_b162e6ab5cd253ca, player);
}

function doppler(soundobject, player, dopplerscale, pitchscale, playervelocityscale) {
  if(condition_alert(isDefined(soundobject) == 0, "[\xec\xb6\xfd*\xba\xa8Cc\xaf\xaa\xbb[:s\xd9^q\xfe\xc8!\xb2Rjkt\xca\xa4!\x9c\xf6\x1an\xa5\x97\x89\x02+\xe3")) {
    return;
  }

  foreach(soundobj in makearray(soundobject)) {
    soundobj thread _doppler_main(player, dopplerscale, pitchscale, playervelocityscale);
  }
}

function doppler_stop(soundobject) {
  if(condition_alert(isDefined(soundobject) == 0, "\xd5\x03\xab\x9c.\xb7\x1dP\xb5(\xf0N\xa47\x16n\x7f\x98<\x82h\xb0\x8e\x1fAn\xb2\x94\xe0\xa8[\xf4\x8f\xd2\x05\xba\xadK\xb9N\xd1\xfb)8")) {
    return;
  }

  foreach(soundobj in makearray(soundobject)) {
    soundobj function_b162e6ab5cd253ca();
  }
}

function private function_68c757552761f57f(callback, allowretrigger) {
  level notify("\x88\xf5H\xd4\xda\xf6SN\x87/B\x8b\xf0\xe9");
  level endon("\x88\xf5H\xd4\xda\xf6SN\x87/B\x8b\xf0\xe9");

  if(!isDefined(allowretrigger)) {
    allowretrigger = 1;
  }

  assert(isstruct(level.snd), "<dev string:x486>");
  assert(isscriptfunction(callback));
  assert(isDefined(allowretrigger));
  utility::flag_wait("v8\xdf\xed\x16\x1e~\xb5\xb7\xef\xd0M");
  start_points = [];
  start_point = function_d6cdcc1bd5241be5();

  while(true) {
    level waittill("\x0e])\xd8\xaeH!i>l\xff", start_point);
    level.snd.start_point = start_point;
    waittillframeend();

    if(!isstring(start_point) || start_point == "") {
      continue;
    }

    if(allowretrigger || !allowretrigger && !isDefined(start_points[start_point])) {
      level thread[[callback]](start_point);
      start_points[start_point] = 1;
    }
  }
}

function start_init(callback, allowretrigger) {
  level thread function_68c757552761f57f(callback, allowretrigger);
}

function private function_ea2faa9e444fac5e(trigger, player) {
  if(!isplayersafe(player)) {
    return;
  }

  is_touching = 0;

  if(isent(trigger)) {
    is_touching = player istouching(trigger);
  } else if(trigger == level) {
    if(!isDefined(player.snd.trigger) || isDefined(player.snd.trigger) && player.snd.trigger == level) {
      is_touching = 1;
    }
  }

  return is_touching;
}

function private function_2b3a778b7c693303() {
  waitforplayers();
  waitframe();
  waittillframeend();

  foreach(player in getplayerssafe()) {
    level notify("\x91`\xb1\xe7T\x97>", player);
  }
}

function private function_6f955d79fc24836f(callback) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  triggers_default = [level];
  trigger = self;
  assert(isDefined(trigger));

  while(true) {
    player = undefined;
    trigger waittill("\x91`\xb1\xe7T\x97>", player);
    is_touching = function_ea2faa9e444fac5e(trigger, player);
    init_obj(player);
    assert(isstruct(player.snd), "<dev string:x672>");

    if(is_touching) {
      if(!isDefined(player.snd.triggers)) {
        player.snd.triggers = triggers_default;
      }

      assert(isarray(player.snd.triggers) && isDefined(player.snd.triggers[0]) && player.snd.triggers[0] == level);

      if(trigger != level) {
        player.snd.triggers[player.snd.triggers.size] = trigger;
      }

      haspriority = isDefined(player.snd.trigger.script_ambientpriority) && isDefined(trigger.script_ambientpriority);
      hashigherpriority = haspriority && int(player.snd.trigger.script_ambientpriority) <= int(trigger.script_ambientpriority);

      if(!isDefined(player.snd.trigger) || haspriority && hashigherpriority || !haspriority) {
        player.snd.trigger = trigger;
        trigger thread[[callback]](player, trigger, 1);
      }

      while(is_touching) {
        is_touching = function_ea2faa9e444fac5e(trigger, player);
        waitframe();
      }

      if(!isDefined(player)) {
        continue;
      }

      if(trigger != level) {
        player.snd.triggers = arrayremove(player.snd.triggers, trigger);
      }

      if(player.snd.trigger == trigger) {
        next_trigger = undefined;

        if(haspriority) {
          next_trigger = level;
          var_e8747f8cb8b3e521 = -1;

          for(i = player.snd.triggers.size - 1; i > 0; i--) {
            other_trigger = player.snd.triggers[i];

            if(isDefined(other_trigger.script_ambientpriority)) {
              var_5bfc8e59784c441e = int(other_trigger.script_ambientpriority);

              if(var_5bfc8e59784c441e > var_e8747f8cb8b3e521) {
                next_trigger = other_trigger;
                var_e8747f8cb8b3e521 = var_5bfc8e59784c441e;
              }
            }
          }
        } else {
          assert(player.snd.triggers.size > 0);
          index = player.snd.triggers.size - 1;
          assert(index >= 0);
          next_trigger = player.snd.triggers[index];
        }

        if(isDefined(next_trigger)) {
          player.snd.trigger = next_trigger;
          next_trigger thread[[callback]](player, next_trigger, 0);
          continue;
        }

        player.snd.trigger = undefined;
        level notify("\x91`\xb1\xe7T\x97>", player);
      }
    }
  }
}

function trigger_init(callback, name = "\xbd\xf7\x17\x18\xfb,\x98\xd1V1\x93\x0e\xc5\x12\xc1", key = "\"\xe4\xaapX\x9d\xbd\xe9\xab\xcc") {
  triggers = [level];
  found_triggers = undefined;

  if(istrue(level.snd.var_aa82b3c5f09326cc)) {
    found_triggers = getEntArray(name, key);
  } else if(istrue(level.snd.var_47d98b44f58f4910)) {
    found_triggers = getEntArray(0, name, key);
  }

  if(isarray(found_triggers)) {
    triggers = utility::array_combine(triggers, found_triggers);
  }

  foreach(trigger in makearray(triggers)) {
    trigger thread function_6f955d79fc24836f(callback);
  }

  level thread function_2b3a778b7c693303();
}

function element_init(name, elements) {
  assert(did_init());
  isnamestring = isstring(name);
  var_3eb174c592bdebd4 = isarray(elements) && elements.size > 0 && isarray(elements[0]);
  issingleelement = isarray(elements) && elements.size >= 3 && isstring(elements[0]);
  iselementstring = isstring(elements);
  var_205063daef6908ce = isnamestring && (var_3eb174c592bdebd4 || issingleelement || iselementstring);

  if(condition_alert(!var_205063daef6908ce, "\x82\x01i^\xfc\rb\xe4+\xb5\xbd\xa5Va\xcf\x15y:\x95(B\xcb\x9c\xc6L")) {
    if(function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }
  }

  if(iselementstring && !isDefined(level.snd.elements[elements])) {
    if(function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }
  }

  if(issingleelement) {
    elements = [elements];
  }

  level.snd.elements[name] = elements;
}

function private function_20059ac9dcea907d(element) {
  assert(isstruct(level.snd), "<dev string:x486>");

  if(isarray(level.snd.elements) && isstring(element)) {
    levelelements = level.snd.elements[element];
    var_effdb4aeca9f3814 = isarray(levelelements);
    var_5b8244edee5bc6ac = isstring(levelelements);

    if(var_effdb4aeca9f3814) {
      return element;
    } else if(var_5b8244edee5bc6ac && isarray(level.snd.elements[levelelements])) {
      return levelelements;
    }
  }

  return undefined;
}

function private function_3be7435c50ee723b(element) {
  assert(isstruct(level.snd), "<dev string:x486>");

  if(isarray(element)) {
    return element;
  } else if(isarray(level.snd.elements) && isstring(element)) {
    element = function_20059ac9dcea907d(element);
    levelelements = level.snd.elements[element];
    var_4a4ec348a450fe7d = isarray(levelelements);

    if(var_4a4ec348a450fe7d) {
      return levelelements;
    }
  }

  return undefined;
}

function set_element(player, element) {
  isplayervalid = isplayersafe(player);

  if(condition_alert(!isplayervalid, "\xd0\xb7 &\xa8\xf8\xcc\xba\tS\x11\t\x16\xb1%e{\x9c\xa8\x19X=\x9a\xa7\xe6\x8c\x1bv\x15\xa2\xb3")) {
    return;
  }

  init_obj(player);
  var_4a4ec348a450fe7d = isarray(element);
  iselementstring = isstring(element);
  var_62c55e53710a92a7 = !isDefined(element);
  var_205063daef6908ce = var_4a4ec348a450fe7d || iselementstring || var_62c55e53710a92a7;

  if(condition_alert(!var_205063daef6908ce, "\x1e\xf8M\xed\\\xb4\xc2\x19\x7fz\xa3AjLF\x19F\xe6\xf6\xcf\xa0\xde\xb7\xf8\x8e\xa5X\xff>Q\xe2F")) {
    return;
  }

  if(var_4a4ec348a450fe7d) {
    player.snd.element = "_8R:\xe2El\x1d\xa6EK\x83,\xd2\xf9\xdf";
  } else if(iselementstring) {
    current = function_20059ac9dcea907d(player.snd.element);
    remapped = function_20059ac9dcea907d(element);
    isequal = isstring(current) && isstring(remapped) && current == remapped;
    player.snd.element = element;

    if(isequal) {
      return;
    }
  }

  if(isplayervalid && isarray(player.snd.emitters)) {
    stop(player.snd.emitters);
    player.snd.emitters = undefined;
  }

  if(var_62c55e53710a92a7) {
    player.snd.element = undefined;
    return;
  }

  elements = function_3be7435c50ee723b(element);
  var_3eb174c592bdebd4 = isarray(elements);

  if(condition_alert(!var_3eb174c592bdebd4, "I\xee\xc82\xc2a8\nB\xaa\x9f!\x17\xfa\x94\x94\xac\xf4" + player.snd.element + "\xc9@W\xcd2\xcafi\x9bYd")) {
    if(function_b38f1279fae1d2cf()) {
      DevOp(0x2);
    }

    return;
  }

  assert(isplayervalid);
  assert(var_3eb174c592bdebd4);
  player.snd.emitters = [];

  foreach(e in elements) {
    alias = e[0];
    target = e[1] ?? player;
    spawntime = e[2];
    distancerange = e[3];
    rotation = e[4];
    elevation = e[5];
    emt = emitter(alias, target, spawntime, distancerange, rotation, elevation);

    if(isDefined(emt)) {
      player.snd.emitters[player.snd.emitters.size] = emt;
    }
  }
}

function private function_f8a04915f0df9075(soundobject, player, org_start, org_end) {
  assert(function_79dd793aa6ffba4c(soundobject));
  assert(isplayersafe(player));
  assert(isvector(org_start));
  assert(isvector(org_end));
  soundobject endon("\x1e\xfd\xd1\xa2\a");
  soundobject notify("\xe6\xcd\x19\xfa\x1bK\xdce}F\xac\xa3\v\x1b4");
  soundobject endon("\xe6\xcd\x19\xfa\x1bK\xdce}F\xac\xa3\v\x1b4");

  while(isplayersafe(player) && function_79dd793aa6ffba4c(soundobject)) {
    org_player = player getplayervieworigin();
    org = pointonsegmentnearesttopoint(org_start, org_end, org_player);
    soundobject.origin = org;

    if(function_8c35a6f99f836040() > 1) {
      line_size = 24;
      depth_test = 0;
      color_line = (0.97254, 0.72974, 0.72974);
      color_rt = (0.72974, 0.97254, 0.72974);
      color_up = (0.72974, 0.72974, 0.97254);
      line(org_start, org_end, color_line, 1, depth_test, 1);
      line_angles = vectortoangles(org_end - org_start);
      line_rt = anglestoright(line_angles);
      line_up = anglestoup(line_angles);
      line(org_start - line_rt * line_size, org_start + line_rt * line_size, color_rt, 1, depth_test, 1);
      line(org_start - line_up * line_size, org_start + line_up * line_size, color_up, 1, depth_test, 1);
      line(org_end - line_rt * line_size, org_end + line_rt * line_size, color_rt, 1, depth_test, 1);
      line(org_end - line_up * line_size, org_end + line_up * line_size, color_up, 1, depth_test, 1);
    }

    waitframe();
  }
}

function line_attach(soundobject, player, org_start, org_end) {
  if(condition_alert(!function_79dd793aa6ffba4c(soundobject), "\xfb\xd5IP\x95\x89\x8f\x83\xccO\x92x+\xe9\xef\xac\xce\xdd\xa2\xafP\x8d*\xd1~\x83\x0e\f\xca\xd8\xf2\xefy\xdfD\x02\xc5W_\x17\x97")) {
    return;
  }

  if(condition_alert(!isplayersafe(player), "|4\x88a\x1a\xf6\xcb\x17\x1e\x89\xafV=\x0fy];\x17\x16\xfcpf[\xc5\bR\xed\xf9I\x1dH\xc0n\x1e\x86C")) {
    return;
  }

  if(condition_alert(!isvector(org_start), "\x0e\xf0\xc2J\x06(\xb1\xeb\xed\xd7\xc1_=\xfd\xe2U\xf1G\xf5\xe8\xc9M\xb1S\xa5\xd9\xc1\x1do\xdd\xfa\x1f\xb4u\x9eU\x94@\xfbS\xc9< \xf7")) {
    return;
  }

  if(condition_alert(!isvector(org_end), "l\x9d\xa8m\x1a\xdcel4\xd4\xa2\xf8\x14\x81\xbd\xb0\xf2]\xc0\x168\xa8el\xac!\xc8\x80\x9f\x8b\x95\x9c\xdc\xdf\t\xc7P\xe0\x89TfY")) {
    return;
  }

  soundobject thread function_f8a04915f0df9075(soundobject, player, org_start, org_end);
}

function line_detach(soundobject) {
  if(condition_alert(!isDefined(soundobject), "\x9bs\x19\xd1\x8ec\xd2s\x95\xeb\x19V\xa3X6C\b\xdd\x96G\r\x80\xabsF\xcaf-7Y\x8c\x01\xdc\xbd\xeas\x91z\x89\x9a\xca6:")) {
    return;
  }

  soundobject notify("\xe6\xcd\x19\xfa\x1bK\xdce}F\xac\xa3\v\x1b4");
}

function private function_939caf4a60b6da0a() {
  wait_init();

  if(!isarray(level.snd.transient_banks)) {
    level.snd.transient_banks = [];
  }

  if(!isent(level.snd.var_29be6644eab159c7)) {
    level.snd.var_29be6644eab159c7 = spawn("\xa6\"\"\x97\xa1Q\x9e\"m\xfd\xfbC\xe5\x98B\x93UM\xda\x86\xb9\xe5\x06\xd4\x99-", (0, 0, 0));
  }
}

function function_c0c403159f9dd267(name) {
  if(isstruct(level.snd) && isDefined(level.snd.transient_banks) && isDefined(level.snd.transient_banks[name])) {
    return true;
  }

  return false;
}

function transient_load(name) {
  function_939caf4a60b6da0a();
  assert(did_init());
  assert(isent(level.snd.var_29be6644eab159c7));
  assert(isarray(level.snd.transient_banks));
  assert(isstring(name), "<dev string:x69b>");
  isloaded = function_c0c403159f9dd267(name);

  if(condition_alert(isloaded, "\xc2\x88\xbf\xedT\xc0\xaa\xdb\x1a8\xf5S\xb9\x81g\xc2\x18%\xee\x83\f\xe24^\xea\xc6*v" + name + "'")) {
    return;
  }

  level.snd.var_29be6644eab159c7 settransientsoundbank(name + "^\xecm\r", 1);
  level.snd.transient_banks[name] = level.snd.transient_banks.size;
}

function transient_unload(name) {
  function_939caf4a60b6da0a();
  assert(did_init());
  assert(isent(level.snd.var_29be6644eab159c7));
  assert(isarray(level.snd.transient_banks));
  assert(isstring(name), "<dev string:x6cb>");
  isloaded = function_c0c403159f9dd267(name);

  if(condition_alert(!isloaded, "\\z{\x94\xabRm\x80\x1f\x1d\x9e\xfb\x84\xf5\x7f\xd5g\x1e\xe1h\xba\xe1~" + name + "\xd7\xcahq\xfe\xbb\f\x1d\x124&\xb1")) {
    return;
  }

  level.snd.var_29be6644eab159c7 settransientsoundbank(name + "^\xecm\r", 0);
  level.snd.transient_banks[name] = undefined;
}