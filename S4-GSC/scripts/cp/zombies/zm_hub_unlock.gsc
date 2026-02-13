/*************************************************
 * Decompiled by HiNAtyu and Edited by SyndiShanX
 * Script: scripts\cp\zombies\zm_hub_unlock.gsc
*************************************************/

init() {
  level.prior_hub_walls = [];
  level._effect["wall_dissolve_small"] = loadfx("vfx/s4/zombie/vfx_wicca_barrier_dissolve_96x32x52_01.vfx");
  level._effect["wall_dissolve_large"] = loadfx("vfx/s4/zombie/vfx_wicca_barrier_dissolve_96x32x180_01.vfx");
  level._effect["wall_dissolve_hollow"] = loadfx("vfx/s4/zombie/vfx_wicca_barrier_dissolve_96x32x180_hollow_01.vfx");
  level._effect["wall_idle_small"] = loadfx("vfx/s4/zombie/vfx_wicca_barrier_idle_96x32x52.vfx");
  level._effect["wall_idle_large"] = loadfx("vfx/s4/zombie/vfx_wicca_barrier_idle_96x32x180.vfx");
  level thread initializeeffects();
}

initializeeffects() {
  wait 5.0;
  var_0 = get_hub_wall_ent_array();

  foreach(var_2 in var_0) {
    var_3 = var_2.model;
    var_4 = undefined;

    if(isDefined(var_3)) {
      switch (var_3) {
        case "s4_zm_wicca_barrier_96x32x52_01":
        case "s4_zm_wicca_barrier_96x32x52_01_snow":
          var_4 = "wall_idle_small";
          break;
        case "s4_zm_wicca_barrier_96x32x180_01_snow":
        case "s4_zm_wicca_barrier_96x32x180_01":
          var_4 = "wall_idle_large";
          break;
        case "s4_zm_wicca_barrier_96x32x180_hollow_01":
        case "s4_zm_wicca_barrier_96x32x180_hollow_01_snow":
          var_4 = "wall_idle_large";
          break;
      }
    }

    if(isDefined(var_4)) {
      playFXOnTag(scripts\engine\utility::getfx(var_4), var_2, "tag_origin");
      var_2.idleeffectlabel = var_4;
    }
  }
}

refresh_hub_walls() {
  var_0 = scripts\cp\zombies\zm_hub_portals::get_portal_structs(0, 1, 1);
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\cp\zombies\zm_hub_portals::get_secondary_portal_structs(1));
  unlock_hub_walls(var_0);
}

unlock_hub_walls(var_0) {
  var_1 = get_hub_wall_ent_array();

  foreach(var_3 in var_1) {
    if(get_wall_portals_unlocked(var_3, var_0)) {
      if(scripts\engine\utility::array_contains(level.prior_hub_walls, var_3)) {
        var_3 enter_pending_removal();
      } else if(!istrue(var_3.is_pending_dissolve)) {
        toggle_ent(var_3, 0);
      }

      continue;
    }

    toggle_ent(var_3, 1);
  }

  if(!_id_0987::is_hub_fully_unlocked()) {
    foreach(var_6 in level.players) {
      _id_070F::createareaunlockevent(var_6, scripts\cp\utility::_id_6871() - 1, 0);
    }
  }

  level.prior_hub_walls = [];
}

enter_pending_removal() {
  thread prepare_wall();
  thread wait_for_wall_removal();
}

prepare_wall() {
  toggle_ent(self, 1);
  var_0 = self.model;

  if(isDefined(var_0)) {
    switch (var_0) {
      case "s4_zm_wicca_barrier_96x32x52_01":
      case "s4_zm_wicca_barrier_96x32x52_01_snow":
        self.dissolvefx = "wall_dissolve_small";
        break;
      case "s4_zm_wicca_barrier_96x32x180_01_snow":
      case "s4_zm_wicca_barrier_96x32x180_01":
        self.dissolvefx = "wall_dissolve_large";
        break;
      case "s4_zm_wicca_barrier_96x32x180_hollow_01":
      case "s4_zm_wicca_barrier_96x32x180_hollow_01_snow":
        self.dissolvefx = "wall_dissolve_hollow";
        break;
    }
  }

  self.is_pending_dissolve = 1;
}

wait_for_wall_removal() {
  self endon("death");
  level waittill("players_landed");
  var_0 = level scripts\engine\utility::_id_108A7(2, "walls_removed");

  if(var_0 == "timeout") {
    level notify("walls_removed");
  }

  self _meth_8093();

  if(isDefined(self.dissolvefx)) {
    if(isDefined(self.idleeffectlabel)) {
      stopFXOnTag(scripts\engine\utility::getfx(self.idleeffectlabel), self, "tag_origin");
    }

    self setModel("tag_origin");
    waitframe();
    playFXOnTag(scripts\engine\utility::getfx(self.dissolvefx), self, "tag_origin");
    self playSound("zmb_wicker_dissolve");
    wait 5.0;
  }

  self delete();
}

get_wall_portals_unlocked(var_0, var_1) {
  if(!isDefined(var_0.target)) {
    return 0;
  }

  var_2 = strtok(var_0.target, "%");

  if(isDefined(var_2)) {
    var_3 = 0;

    foreach(var_5 in var_1) {
      foreach(var_7 in var_2) {
        if(istrue(var_5.is_removed) && var_7 == var_5._id_0481) {
          var_3++;
        }
      }
    }

    if(var_3 == var_2.size) {
      return 1;
    }
  }

  return 0;
}

toggle_ent(var_0, var_1) {
  if(var_1) {
    var_0 _meth_80B5();
    var_0 show();
  } else {
    var_0 _meth_8093();
    var_0 hide();
  }
}

unlock_all_walls() {
  level notify("walls_removed");
  var_0 = scripts\cp\zombies\zm_hub_portals::get_portal_structs(0, 1, 1);
  var_0 = scripts\engine\utility::array_combine(var_0, scripts\cp\zombies\zm_hub_portals::get_secondary_portal_structs(1));
  var_1 = get_hub_wall_ent_array();

  foreach(var_3 in var_1) {
    if(!get_wall_portals_unlocked(var_3, var_0)) {
      level.prior_hub_walls[level.prior_hub_walls.size] = var_3;
    }

    if(!istrue(var_3.is_pending_dissolve)) {
      toggle_ent(var_3, 0);
    }
  }
}

queue_wall_unlock(var_0, var_1) {
  if(isDefined(var_0)) {
    var_1 = scripts\cp\utility::_id_459B(var_1, 10);
    level scripts\engine\utility::_id_108A7(var_1, var_0);
  }

  unlock_all_walls();
}

queue_wall_refresh(var_0, var_1) {
  if(isDefined(var_0)) {
    var_1 = scripts\cp\utility::_id_459B(var_1, 10);
    level scripts\engine\utility::_id_108A7(var_1, var_0);
  }

  refresh_hub_walls();
}

get_hub_wall_ent_array() {
  var_0 = getEntArray("hub_wall", "script_noteworthy");

  if(istrue(getdvarint("#x3ed73a37ce046aa3a", 0))) {
    var_1 = getEntArray("hub_wall_s1", "script_noteworthy");
    var_2 = getEntArray("hub_wall_blocker_s1", "script_noteworthy");
    var_3 = scripts\engine\utility::array_combine(var_2, var_1);

    if(_func_0107(var_3)) {
      var_0 = scripts\engine\utility::array_combine(var_0, var_3);
    }
  }

  return var_0;
}