/*****************************************************************
 * Decompiled by Bog and Edited by SyndiShanX
 * Script: maps\mp\zombies\shotgun\_zombies_shotgun_drop_pod.gsc
*****************************************************************/

func_00D5() {
  common_scripts\utility::func_2CB4(5, ::drop_pod_init_drop_points);
  aud_blimp_attack_init();
  level.var_611["zmb_zep_battery_fire_trail"] = loadfx("vfx/map/mp_zombie_nest/zmb_zep_battery_fire_trail");
  level.var_611["zmb_zep_battery_land_explosion"] = loadfx("vfx/explosion/zmb_zep_battery_land_explosion");
}

drop_pod_init_drop_points() {
  var_00 = common_scripts\utility::func_46B7("drop_pod_position", "targetname");
  foreach(var_02 in var_00) {
    var_03 = common_scripts\utility::func_44BE(var_02.var_1A2, "targetname");
    foreach(var_05 in var_03) {
      switch (var_05.var_165) {
        case "drop_pod_model":
          var_02.pod_model = var_05;
          break;

        case "drop_pod_shell_collide":
          var_02.clip_shell = var_05;
          var_02.clip_shell notsolid();
          var_02.clip_shell method_8060();
          break;

        case "drop_pod_door_collide":
          var_02.clip_door = var_05;
          var_02.clip_door notsolid();
          break;

        case "drop_pod_floor_collide":
          var_02.clip_floor = var_05;
          var_02.clip_floor notsolid();
          var_02.clip_floor method_8060();
          break;

        case "drop_pod_fall_collide":
          var_02.clip_fall = var_05;
          var_02.clip_fall notsolid();
          break;

        case "drop_pod_contents_spawn":
          var_02.contents_pos = var_05;
          break;

        case "drop_pod_debris_model":
          if(!isDefined(var_02.debris_models)) {
            var_02.debris_models = [];
          }

          var_02.debris_models[var_02.debris_models.size] = var_05;
          break;
      }
    }
  }

  level.drop_pods = var_00;
}

drop_pod_spawn_drop() {
  var_00 = common_scripts\utility::func_7A33(level.drop_pods);
  var_01 = var_00.pod_model.var_116 + (0, 0, 8000);
  var_02 = var_00.pod_model.var_1D;
  var_03 = spawn("script_model", var_01);
  var_03 setModel("zbr_drop_pod_01");
  var_00.spawned_model = var_03;
  var_00.clip_fall method_8449(var_03, "tag_origin", (0, 0, 0), (0, 0, 0));
  var_00.clip_fall solid();
  playFXOnTag(level.var_611["zmb_zep_battery_fire_trail"], var_03, "tag_origin");
  var_03 lib_0378::func_8D74("aud_droppod_launch");
  var_04 = (0, 0, -800);
  var_05 = 1;
  var_06 = var_01 - var_00.pod_model.var_116;
  var_05 = sqrt(abs(var_06[2] * 2 / 800));
  var_07 = 1 / var_05;
  var_08 = var_06 * (var_07, var_07, 0);
  var_03 gravitymove(var_08, var_05);
  if(isDefined(var_02)) {
    var_03 rotateto(var_02, var_05);
  }

  wait(var_05);
  var_03.var_116 = var_00.pod_model.var_116;
  playFX(level.var_611["zmb_wm_droppod_dirt_impact"], var_00.pod_model.var_116 + (0, 0, -20));
  earthquake(0.3, 2, var_00.pod_model.var_116, 850);
  lib_0378::func_8D74("aud_droppod_landed", var_00.pod_model.var_116);
  var_00 drop_pod_set_drop_point_active();
  var_00.clip_fall notsolid();
  var_00.clip_fall delete();
  wait(1);
  var_00 drop_pod_open_pod_doors();
  return var_03;
}

drop_pod_open_pod_doors() {
  var_00 = lib_054D::func_90BA("zombie_heavy", self.contents_pos, "pod guy", 0, 1, 0);
  var_00 lib_0547::func_84CB();
  self.spawned_model scriptmodelplayanim("s2_zom_drop_pod_open");
  self.spawned_model lib_0378::func_8D74("aud_open_droppod_door");
}

drop_pod_set_drop_point_active() {
  if(isDefined(self.clip_shell)) {
    self.clip_shell solid();
    self.clip_shell method_805F();
  }

  wait 0.05;
  if(isDefined(self.clip_floor)) {
    self.clip_floor solid();
    self.clip_floor method_8060();
  }

  wait 0.05;
  if(isDefined(self.clip_door)) {
    self.clip_door solid();
  }

  self.spawned_debris = [];
  foreach(var_01 in self.debris_models) {
    var_02 = spawn("script_model", var_01.var_116);
    var_02 setModel(var_01.var_8260);
    if(isDefined(var_01.var_1D)) {
      var_02.var_1D = var_01.var_1D;
    }

    self.spawned_debris[self.spawned_debris.size] = var_02;
  }

  var_04 = common_scripts\utility::func_F73(level.var_744A, lib_0547::func_408F());
  foreach(var_06 in var_04) {
    if(var_06 istouching(self.clip_shell)) {
      if(isPlayer(var_06)) {
        var_07 = self.spawned_model.var_116;
        if(canspawn(var_07)) {
          var_06 setorigin(var_07);
        } else {
          var_08 = getclosestpointonnavmesh(var_07);
          if(canspawn(var_08)) {
            var_06 setorigin(var_08);
          } else {
            maps\mp\_movers::func_A047(var_06, 0);
          }
        }

        var_06 dodamage(var_06.var_BC + 666, self.spawned_model.var_116, undefined, undefined, "MOD_CRUSH");
        continue;
      }

      var_06 dodamage(var_06.var_BC + 666, self.spawned_model.var_116, undefined, undefined, "MOD_EXPLOSIVE");
    }
  }

  self.var_57F7 = 1;
  thread drop_pod_clip_exploit_listener();
}

drop_pod_set_drop_point_inactive() {
  self.clip_shell notsolid();
  self.clip_shell method_8060();
  self.clip_shell method_8511();
  self.clip_door notsolid();
  self.clip_door method_8060();
  self.clip_door method_8511();
  self.clip_floor notsolid();
  self.clip_floor method_8060();
  self.clip_floor method_8511();
  self.spawned_model delete();
  foreach(var_01 in self.spawned_debris) {
    var_01 delete();
  }

  self.spawned_debris = [];
  self.var_57F7 = 0;
  self notify("stop_exploit_listener");
}

drop_pod_clip_exploit_listener() {
  self endon("stop_exploit_listener");
  if(!isDefined(self.clip_shell)) {
    return;
  }

  for(;;) {
    foreach(var_01 in level.var_744A) {
      var_02 = var_01 method_8551();
      if(isDefined(var_02) && var_02 == self.clip_shell) {
        var_03 = self.spawned_model.var_116;
        if(canspawn(var_03)) {
          var_01 setorigin(var_03);
        } else {
          var_04 = getclosestpointonnavmesh(var_03);
          if(canspawn(var_04)) {
            var_01 setorigin(var_04);
          } else {
            maps\mp\_movers::func_A047(var_01, 0);
          }
        }

        var_01 dodamage(var_01.var_BC + 666, self.spawned_model.var_116, undefined, undefined, "MOD_CRUSH");
      }
    }

    wait(0.5);
  }
}

aud_blimp_attack_init() {
  lib_0378::func_8DC7("aud_blimp_turret_explode", ::aud_blimp_turret_explode);
  lib_0378::func_8DC7("aud_blimp_battery_land", ::aud_blimp_battery_land);
}

aud_blimp_turret_explode() {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_explo", self.var_116);
  wait(1.2);
  if(isDefined(self)) {
    maps\mp\_audio::func_8DA2("zmb_blimp_elec_turret_fall", self);
  }
}

aud_blimp_battery_land(param_00) {
  maps\mp\_audio::func_8DA0("zmb_blimp_elec_turret_land", param_00.var_116);
}