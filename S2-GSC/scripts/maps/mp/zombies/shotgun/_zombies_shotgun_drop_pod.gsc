/*************************************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: scripts\maps\mp\zombies\shotgun\_zombies_shotgun_drop_pod.gsc
*************************************************************************/

init() {
  common_scripts\utility::_id_2CB4(5, ::drop_pod_init_drop_points);
  aud_blimp_attack_init();
  level._effect["zmb_zep_battery_fire_trail"] = loadfx("vfx/map/mp_zombie_nest/zmb_zep_battery_fire_trail");
  level._effect["zmb_zep_battery_land_explosion"] = loadfx("vfx/explosion/zmb_zep_battery_land_explosion");
}

drop_pod_init_drop_points() {
  var_0 = common_scripts\utility::_id_46B7("drop_pod_position", "targetname");

  foreach(var_2 in var_0) {
    var_3 = common_scripts\utility::_id_44BE(var_2.target, "targetname");

    foreach(var_5 in var_3) {
      switch (var_5._id_0165) {
        case "drop_pod_model":
          var_2.pod_model = var_5;
          break;
        case "drop_pod_shell_collide":
          var_2.clip_shell = var_5;
          var_2.clip_shell _meth_82C2();
          var_2.clip_shell _meth_8060();
          break;
        case "drop_pod_door_collide":
          var_2.clip_door = var_5;
          var_2.clip_door _meth_82C2();
          break;
        case "drop_pod_floor_collide":
          var_2.clip_floor = var_5;
          var_2.clip_floor _meth_82C2();
          var_2.clip_floor _meth_8060();
          break;
        case "drop_pod_fall_collide":
          var_2.clip_fall = var_5;
          var_2.clip_fall _meth_82C2();
          break;
        case "drop_pod_contents_spawn":
          var_2.contents_pos = var_5;
          break;
        case "drop_pod_debris_model":
          if(!isDefined(var_2.debris_models))
            var_2.debris_models = [];

          var_2.debris_models[var_2.debris_models.size] = var_5;
          break;
      }
    }
  }

  level.drop_pods = var_0;
}

drop_pod_spawn_drop() {
  var_0 = common_scripts\utility::random(level.drop_pods);
  var_1 = var_0.pod_model.origin + (0, 0, 8000);
  var_2 = var_0.pod_model.angles;
  var_3 = spawn("script_model", var_1);
  var_3 setModel("zbr_drop_pod_01");
  var_0.spawned_model = var_3;
  var_0.clip_fall linktosynchronizedparent(var_3, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_0.clip_fall _meth_82C1();
  _func_147(level._effect["zmb_zep_battery_fire_trail"], var_3, "tag_origin");
  var_3 _id_0378::_id_8D74("aud_droppod_launch");
  var_4 = (0, 0, -800);
  var_5 = 1;
  var_6 = var_1 - var_0.pod_model.origin;
  var_5 = _func_0D9(_func_0AE(var_6[2] * 2 / 800));
  var_7 = 1 / var_5;
  var_8 = var_6 * (var_7, var_7, 0);
  var_3 _meth_82B5(var_8, var_5);

  if(isDefined(var_2))
    var_3 _meth_82B8(var_2, var_5);

  wait(var_5);
  var_3.origin = var_0.pod_model.origin;
  playFX(level._effect["zmb_wm_droppod_dirt_impact"], var_0.pod_model.origin + (0, 0, -20));
  _func_17F(0.3, 2, var_0.pod_model.origin, 850);
  _id_0378::_id_8D74("aud_droppod_landed", var_0.pod_model.origin);
  var_0 drop_pod_set_drop_point_active();
  var_0.clip_fall _meth_82C2();
  var_0.clip_fall delete();
  wait 1;
  var_0 drop_pod_open_pod_doors();
  return var_3;
}

drop_pod_open_pod_doors() {
  var_0 = _id_054D::_id_90BA("zombie_heavy", self.contents_pos, "pod guy", 0, 1, 0);
  var_0 _id_0547::_id_84CB();
  self.spawned_model _meth_8276("s2_zom_drop_pod_open");
  self.spawned_model _id_0378::_id_8D74("aud_open_droppod_door");
}

drop_pod_set_drop_point_active() {
  if(isDefined(self.clip_shell)) {
    self.clip_shell _meth_82C1();
    self.clip_shell _meth_805F();
  }

  waitframe();

  if(isDefined(self.clip_floor)) {
    self.clip_floor _meth_82C1();
    self.clip_floor _meth_8060();
  }

  waitframe();

  if(isDefined(self.clip_door))
    self.clip_door _meth_82C1();

  self.spawned_debris = [];

  foreach(var_1 in self.debris_models) {
    var_2 = spawn("script_model", var_1.origin);
    var_2 setModel(var_1._id_8260);

    if(isDefined(var_1.angles))
      var_2.angles = var_1.angles;

    self.spawned_debris[self.spawned_debris.size] = var_2;
  }

  var_4 = common_scripts\utility::_id_0F73(level.players, _id_0547::_id_408F());

  foreach(var_6 in var_4) {
    if(var_6 istouching(self.clip_shell)) {
      if(isPlayer(var_6)) {
        var_7 = self.spawned_model.origin;

        if(_func_15E(var_7))
          var_6 setOrigin(var_7);
        else {
          var_8 = _func_2E1(var_7);

          if(_func_15E(var_8))
            var_6 setOrigin(var_8);
          else
            _id_0488::_id_A047(var_6, 0);
        }

        var_6 _meth_8059(var_6.health + 666, self.spawned_model.origin, undefined, undefined, "MOD_CRUSH");
        continue;
      }

      var_6 _meth_8059(var_6.health + 666, self.spawned_model.origin, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }

  self._id_57F7 = 1;
  thread drop_pod_clip_exploit_listener();
}

drop_pod_set_drop_point_inactive() {
  self.clip_shell _meth_82C2();
  self.clip_shell _meth_8060();
  self.clip_shell _meth_8511();
  self.clip_door _meth_82C2();
  self.clip_door _meth_8060();
  self.clip_door _meth_8511();
  self.clip_floor _meth_82C2();
  self.clip_floor _meth_8060();
  self.clip_floor _meth_8511();
  self.spawned_model delete();

  foreach(var_1 in self.spawned_debris)
  var_1 delete();

  self.spawned_debris = [];
  self._id_57F7 = 0;
  self notify("stop_exploit_listener");
}

drop_pod_clip_exploit_listener() {
  self endon("stop_exploit_listener");

  if(!isDefined(self.clip_shell)) {
    return;
  }
  for(;;) {
    foreach(var_1 in level.players) {
      var_2 = var_1 _meth_8551();

      if(isDefined(var_2) && var_2 == self.clip_shell) {
        var_3 = self.spawned_model.origin;

        if(_func_15E(var_3))
          var_1 setOrigin(var_3);
        else {
          var_4 = _func_2E1(var_3);

          if(_func_15E(var_4))
            var_1 setOrigin(var_4);
          else
            _id_0488::_id_A047(var_1, 0);
        }

        var_1 _meth_8059(var_1.health + 666, self.spawned_model.origin, undefined, undefined, "MOD_CRUSH");
      }
    }

    wait 0.5;
  }
}

aud_blimp_attack_init() {
  _id_0378::_id_8DC7("aud_blimp_turret_explode", ::aud_blimp_turret_explode);
  _id_0378::_id_8DC7("aud_blimp_battery_land", ::aud_blimp_battery_land);
}

aud_blimp_turret_explode() {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_explo", self.origin);
  wait 1.2;

  if(isDefined(self))
    _id_046C::_id_8DA2("zmb_blimp_elec_turret_fall", self);
}

aud_blimp_battery_land(var_0) {
  _id_046C::_id_8DA0("zmb_blimp_elec_turret_land", var_0.origin);
}