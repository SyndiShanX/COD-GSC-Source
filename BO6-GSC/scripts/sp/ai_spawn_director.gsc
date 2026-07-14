/********************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\sp\ai_spawn_director.gsc
********************************************/

#using scripts\common\anim;
#using scripts\common\vehicle_aianim;
#using scripts\engine\utility;
#using scripts\sp\spawner;
#using scripts\sp\vehicle;
#namespace ai_spawn_director;

function autoexec function_10eb86418ea50a57() {
  level.var_f36886349969a6f6 = &function_97d6b905be6a32dc;
  level.var_291ff58abadc3b95 = &function_cc495f79aca5ab32;
  level.var_735f9bb845b0853c = &function_3ca3f77a57e83807;
  level.var_199e355afc7e6b21 = &function_a1f3b54afd7e62b3;
  level.var_b6a7930a78028898 = &function_9a33c067f46abada;
  level.var_873d5aab65777ef6 = &function_83e57b9932609cb0;
  level.var_f15b6a4bedd7efcd = 1;
}

function private function_97d6b905be6a32dc(actor, data, spawn_anim_alias) {
  if(spawn_anim_alias != "\xb5\xe2\xd8\xcd/") {
    animname = level.scr_anim["\xbc\x9d\xbd\x92/\xda\x81}\xdf$\xe6.\xc60\xf7G*"][spawn_anim_alias];

    if(isDefined(animname)) {
      actor animScripted("\x13\xf2\xf7\xd7\\p\xa8j\xed\xb7\xbe\x9b", actor.origin, actor.angles, animname);
      return;
    }

    assertmsg("<dev string:x24>" + spawn_anim_alias + "<dev string:x51>");
  }
}

function private function_3ca3f77a57e83807() {
  if(isDefined(self.targetname)) {
    thread spawner::spawn_think(self.targetname);
    return;
  }

  thread spawner::spawn_think();
}

function private function_cc495f79aca5ab32(var_f7e4f988e625d7bf) {
  if(!var_f7e4f988e625d7bf) {
    requestid = self.directorrequestid;

    if(isDefined(level.var_bbd85d958a110a1f[requestid]) && isDefined(level.var_bbd85d958a110a1f[requestid]["\xc6*Q\x85\"\x02\x89|.Cf\xf2\x01O\xec2"])) {
      callbackstruct = level.var_bbd85d958a110a1f[requestid]["\xc6*Q\x85\"\x02\x89|.Cf\xf2\x01O\xec2"];
      thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata);
    }
  }

  self kill();
}

function private function_a1f3b54afd7e62b3(requestid, team) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  assert(isDefined(team));

  if(isDefined(level.var_f0477d10e8497c86)) {
    elapsed = gettime() - level.var_f0477d10e8497c86;

    if(utility::function_7db7b41478a3232a(elapsed) < 1) {
      wait randomfloatrange(1, 3);
    }
  }

  vehicle = level.var_f93e405ca717ad72[requestid].vehicle;
  vehicle_index = level.var_f93e405ca717ad72[requestid].vehicle_index;
  riders = level.var_f93e405ca717ad72[requestid].riders;
  unload_pos = level.var_f93e405ca717ad72[requestid].unload_pos;
  vehiclenodestart = getvehiclenode(vehicle_index);
  level.var_f93e405ca717ad72[requestid] = undefined;
  templateidx = 0;
  vehicleclassname = undefined;

  foreach(type in level.vehicle.templates.type) {
    if(type == vehicle) {
      vehicleclassname = getarraykey(level.vehicle.templates.type, templateidx);
      break;
    }

    templateidx++;
  }

  vehiclemodelname = level.vehicle.templates.model[vehicleclassname];
  heli = [[level.var_76aeba28d6ac69be]](vehiclenodestart, 0, undefined, 0, team, vehiclemodelname, vehicle);

  if(isDefined(heli)) {
    heli.classname_sp = vehicleclassname;
    vehicle::vehicle_init(heli);
    function_cbdc7e7025cd7640(requestid, heli);
    level.var_f0477d10e8497c86 = gettime();
    callbackstruct = [[level.var_bfd92fe24051ccf8]]("\xed-F\xa2\\-{\x01\x9b+a8!U~\x86", requestid);

    if(isDefined(callbackstruct)) {
      thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata, heli);
    }

    heli vehicle_aianim::handle_attached_guys();

    foreach(rider in riders) {
      rider.finished_spawning = 1;
      heli vehicle_aianim::guy_enter(rider);
      waitframe();
      rider.var_5bc580d92d8e427a = undefined;
    }

    heli thread function_57b336d3c756c43e(requestid, unload_pos, vehiclenodestart);
    heli thread[[level.var_d18c8320030cf07f]](requestid);
    return;
  }

  assertmsg("<dev string:xa6>" + vehicle);
}

function private function_57b336d3c756c43e(requestid, unload_pos, vehiclenodestart) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93]y\xb7\xf2,I");
  self endon("\xcc\x15n\xfb\x98|?\xc5");
  self thread[[level.var_92482472ee6a32cb]](vehiclenodestart, undefined);
  self waittill("1\xf3\xdf\x18\xcbT\x9d:w\r)\xde6\xc6\x98\xc36z\a\x90P\r\xef\xab\xc6\xb7\x19Y@\xf0C9x\xe7\x9e\xc4\xf12\xac");
  unload_pos = self[[level.var_4823431e4270285c]](unload_pos);
  var_6fdd04ce5fca4533 = self[[level.var_9eb557a4e6789d68]](unload_pos);
  function_5e4d6620a6f98148(requestid, vehiclenodestart.origin, var_6fdd04ce5fca4533, unload_pos);
}

function private function_5e4d6620a6f98148(requestid, var_a4534e940a22022d, var_6fdd04ce5fca4533, var_7081eaabf252ae3f) {
  self endon("\x1e\xfd\xd1\xa2\a");
  self endon("\x93]y\xb7\xf2,I");
  self endon("\xcc\x15n\xfb\x98|?\xc5");

  foreach(agent in var_6fdd04ce5fca4533) {
    if(isDefined(agent)) {
      agent thread[[level.var_fc3586f4808e11b9]](requestid, var_7081eaabf252ae3f);
      agent notify("\a-\xf8\xc8 \x9b");
    }
  }

  function_60fd7d4376c1cfe6(requestid);
  self thread[[level.var_6a4270dc9dd1669c]](var_a4534e940a22022d);
  self waittill("\\e\x9c\xbb\xa1,\xf9\xec<\xa2>D\xdb\xf8\x9d\x80\xcd\x131\xa5\xd1\xb0~#\xfc\xec?F\xfa");
  self[[level.var_8fcb09c70b0d0f1]]();
}

function private function_9a33c067f46abada(requestid, team) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");

  if(isDefined(level.var_f0477d10e8497c86)) {
    elapsed = gettime() - level.var_f0477d10e8497c86;

    if(utility::function_7db7b41478a3232a(elapsed) < 1) {
      wait randomfloatrange(1, 3);
    }
  }

  if(isDefined(level.var_f93e405ca717ad72[requestid])) {
    vehicle = level.var_f93e405ca717ad72[requestid].vehicle;
    vehicle_index = level.var_f93e405ca717ad72[requestid].vehicle_index;
    riders = level.var_f93e405ca717ad72[requestid].riders;
    unload_pos = level.var_f93e405ca717ad72[requestid].unload_pos;
    vehiclenodestart = getvehiclenode(vehicle_index);
    vehiclespawndata = spawnStruct();
    vehiclespawndata.origin = vehiclenodestart.origin + (0, 0, 128);
    vehiclespawndata.angles = vehiclenodestart.angles;
    vehiclespawndata.initai = 1;
    templateidx = 0;

    foreach(type in level.vehicle.templates.type) {
      if(type == vehicle) {
        vehicleclassname = getarraykey(level.vehicle.templates.type, templateidx);
        break;
      }

      templateidx++;
    }

    vehiclemodelname = level.vehicle.templates.model[vehicleclassname];
    spawnedvehicle = spawnVehicle(vehiclemodelname, "\xb4\xeb\xfa\xa0\xd0Nv\xf3\xa7x\x86\x99S\x8e", vehicle, vehiclespawndata.origin, vehiclespawndata.angles);

    if(isDefined(spawnedvehicle)) {
      spawnedvehicle vehphys_parkingbrake(1);
      spawnedvehicle.classname_sp = vehicleclassname;
      vehicle::vehicle_init(spawnedvehicle);
      function_cbdc7e7025cd7640(requestid, spawnedvehicle);
      level.var_f0477d10e8497c86 = gettime();
      callbackstruct = [[level.var_bfd92fe24051ccf8]]("\xed-F\xa2\\-{\x01\x9b+a8!U~\x86", requestid);

      if(isDefined(callbackstruct)) {
        thread[[callbackstruct.fncallback]](requestid, callbackstruct.userdata, spawnedvehicle);
      }

      spawnedvehicle.riders = [];
      spawnedvehicle.unloadque = [];
      spawnedvehicle.unload_group = "\xc0\xc6J";
      spawnedvehicle vehicle_aianim::handle_attached_guys();
      spawnedvehicle[[level.var_3f77b0d0d1a5c975]](riders);

      foreach(guy in riders) {
        guy.finished_spawning = 1;
        spawnedvehicle vehicle_aianim::guy_enter(guy);
        waitframe();
        guy.var_5bc580d92d8e427a = undefined;
      }

      spawnedvehicle[[level.var_a13289363545c979]](spawnedvehicle, spawnedvehicle.origin, vehicle_index, vehiclenodestart.speed);
      spawnedvehicle thread[[level.var_45c0327152b99d94]](requestid, unload_pos);
      spawnedvehicle thread[[level.var_d18c8320030cf07f]](requestid);
      spawnedvehicle thread[[level.var_8461a992eaec43c3]](requestid);
      level.var_f93e405ca717ad72[requestid] = undefined;
      return;
    }

    assertmsg("<dev string:xe4>" + vehicle);
  }
}

function private function_83e57b9932609cb0(requestid, data) {
  level endon("\xeb\xefA\xb3\x9f\xbe\x02$\xa0\xa7");
  self endon("\x1e\xfd\xd1\xa2\a");
  self hide();
  utility::delaycall(0.5, &show);
  waitframe();
  level.var_845574670b5617b7 = &function_38cb0cd938349165;
  level.var_c86c001407ea856d = &function_1e4f560a187968f;
  self[[level.var_6f2033beed99efb9]](data.var_e59f8d2fa4f179bf, data.var_6c7069ffde8bead2, undefined, 0, 3);
  self[[level.var_59554315c8f65e96]](requestid);
  self[[level.var_d738957173814f2b]](data);
}

#using_animtree("7l\x9ci\xc1\xa3}\xda\xf6\x19\xca6");

function private function_38cb0cd938349165(animname) {
  self.animname = "\xbc\x9d\xbd\x92/\xda\x81}\xdf$\xe6.\xc60\xf7G*";
  self useanimtree(#animtree);
  thread animation::anim_single_solo(self, animname);
}

function private function_1e4f560a187968f(pos, angles, bsetorigin) {
  self forceteleport(pos, angles);
}