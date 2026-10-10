/************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: sp\hashed\script_5e60754c97311cd.gsc
************************************************/

#using scripts\engine\utility;
#namespace vfx_zones;

function function_b9e130d444d299c9(exploder_id, zones, exclude_zones, stop_fx) {
  assert(isDefined(exploder_id));
  assert(isDefined(zones));
  function_605874f5b079939e();

  if(!isarray(zones)) {
    zones = [zones];
  }

  foreach(zone in zones) {
    flag_init(zone);
  }

  flag_init("vfx_zone_" + exploder_id + "_active");

  if(isDefined(exclude_zones)) {
    if(!isarray(exclude_zones)) {
      exclude_zones = [exclude_zones];

      foreach(exclude_zone in exclude_zones) {
        if(!flag_exist(exclude_zone)) {
          flag_init(exclude_zone);
        }
      }
    }
  }

  if(!isDefined(stop_fx)) {
    stop_fx = 0;
  }

  waitframe();
  vfx_zone = spawnStruct();
  vfx_zone.playing = 0;
  vfx_zone.stop = stop_fx;

  if(isDefined(exclude_zones)) {
    vfx_zone thread function_6e68ec1667a60118(exploder_id, exclude_zones, zones);
  }

  vfx_zone thread function_840df183a03cf7f6(exploder_id, zones);
}

function private function_605874f5b079939e() {
  if(!isDefined(level._fx)) {
    level._fx = spawnStruct();
  }

  if(!isDefined(level._fx.var_a1986b7fa363399a)) {
    level._fx.var_a1986b7fa363399a = 1;
    init_dvars();
  }
}

function private init_dvars() {
  setdvarifuninitialized(@ "hash_6db7cb3d747e8695", 0);
}

function private function_840df183a03cf7f6(exploder_id, zones) {
  while(true) {
    thread function_dea7cc77ad90ba55(exploder_id, zones);
    level waittill("vfx_zone_" + exploder_id + "_deactivating");
    level waittill("vfx_zone_" + exploder_id + "_activating");
  }
}

function private function_dea7cc77ad90ba55(exploder_id, zones) {
  level endon("vfx_zone_" + exploder_id + "_deactivating");

  for(;;) {
    function_665d474ff040b446(zones);

    if(getdvarint(@ "hash_6db7cb3d747e8695", 0)) {
      iprintln("<dev string:x1c>" + exploder_id + "<dev string:x27>");
    }

    exploder_play(exploder_id);
    flag_waitopen_all_array(zones);

    if(getdvarint(@ "hash_6db7cb3d747e8695", 0)) {
      iprintln("<dev string:x1c>" + exploder_id + "<dev string:x2b>");
    }

    exploder_stop(exploder_id);
  }
}

function private function_6e68ec1667a60118(exploder_id, exclude_zones, zones) {
  for(;;) {
    function_665d474ff040b446(exclude_zones);
    function_62691cef5a23cc3c(exploder_id);
    exploder_stop(exploder_id);
    flag_waitopen_all_array(exclude_zones);
    function_a1b55e334a14c24d(exploder_id);

    foreach(zone in zones) {
      if(flag(zone)) {
        exploder_play(exploder_id);
        break;
      }
    }
  }
}

function private function_a1b55e334a14c24d(exploder_id) {
  level notify("vfx_zone_" + exploder_id + "_activating");
  flag_set("vfx_zone_" + exploder_id + "_active");
}

function private function_62691cef5a23cc3c(exploder_id) {
  level notify("vfx_zone_" + exploder_id + "_deactivating");
  flag_clear("vfx_zone_" + exploder_id + "_active");
}

function private exploder_play(exploder_id) {
  if(self.playing) {
    return;
  }

  self.playing = 1;
  exploder(exploder_id);
}

function private exploder_stop(exploder_id) {
  if(!self.playing) {
    return;
  }

  self.playing = 0;

  if(self.stop) {
    stop_exploder(exploder_id);
    return;
  }

  kill_exploder(exploder_id);
}