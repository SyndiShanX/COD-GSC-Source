/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_katyusha.gsc
**************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;
#include maps\_utility;
#using_animtree("vehicles");
main(model, type) {
  build_template("katyusha", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_opel_blitz_woodland", "vehicle_opel_blitz_woodland_d");
  build_deathfx("explosions/large_vehicle_explosion", undefined, "explo_metal_rand");
  build_exhaust("vehicle/exhaust/fx_exhaust_rus_rocket_truck");
  build_treadfx(type);
  build_life(999, 500, 1500);
  build_team("allies");

  build_aianims(::setanims, ::set_vehicle_anims);
  build_unload_groups(::Unload_Groups);
}

init_local() {}

set_vehicle_anims(positions) {
  return positions;
}

#using_animtree("generic_human");

setanims() {
  positions = [];
  for(i = 0; i < 4; i++)
    positions[i] = spawnStruct();

  positions[0].sittag = "tag_driver";
  positions[1].sittag = "tag_passenger";
  positions[2].sittag = "tag_guy1";
  positions[3].sittag = "tag_guy2";

  return positions;
}

unload_groups() {
  unload_groups = [];
  unload_groups["passengers"] = [];
  unload_groups["all"] = [];

  group = "passengers";
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;

  group = "all";
  unload_groups[group][unload_groups[group].size] = 0;
  unload_groups[group][unload_groups[group].size] = 1;
  unload_groups[group][unload_groups[group].size] = 2;
  unload_groups[group][unload_groups[group].size] = 3;

  unload_groups["default"] = unload_groups["all"];

  return unload_groups;
}
rocket_barrage(rocket_amount, targets, attack_range, dest_z_height) {
  self endon("stop_rocket_barrage");

  if(!isDefined(rocket_amount) || rocket_amount <= 0) {
    rocket_amount = 8;
  }

  if(!isDefined(attack_range)) {
    attack_range = 1500;
  }

  if(!isDefined(dest_z_height)) {
    dest_z_height = 500;
  }

  tags = [];
  tags[0] = "tag_rocket00";
  tags[1] = "tag_rocket01";
  tags[2] = "tag_rocket02";
  tags[3] = "tag_rocket03";
  tags[4] = "tag_rocket04";
  tags[5] = "tag_rocket05";
  tags[6] = "tag_rocket06";
  tags[7] = "tag_rocket07";
  tags[8] = "tag_rocket08";
  tags[9] = "tag_rocket09";
  tags[10] = "tag_rocket10";
  tags[11] = "tag_rocket11";
  tags[12] = "tag_rocket12";
  tags[13] = "tag_rocket13";
  tags[14] = "tag_rocket14";
  tags[15] = "tag_rocket15";

  for(i = 0; i < rocket_amount; i++) {
    if(isDefined(targets)) {
      n = i % targets.size;
      dest_point = targets[n].origin;
    } else {
      forward = anglesToForward(self.angles + (0, 20 - RandomInt(40), 0));

      range = attack_range + (150 - RandomInt(300));

      dest_point = self.origin + vector_multiply(forward, range);

      trace = bulletTrace(dest_point + (0, 0, dest_z_height), dest_point + (0, 0, -2000), false, self);
      dest_point = trace["position"];
    }

    n = i % tags.size;

    while(!OkTospawn()) {
      wait(0.1);
    }

    rocket = spawn("script_model", self GetTagOrigin(tags[n]));
    rocket setModel("katyusha_rocket");
    rocket.angles = self GetTagAngles(tags[n]);

    rocket playSound("katyusha_launch_rocket");
    playFXOnTag(level._effect["katyusha_rocket_launch"], rocket, "tag_fx");
    playFXOnTag(level._effect["katyusha_rocket_trail"], rocket, "tag_fx");

    rocket playLoopSound("katy_rocket_run");

    rocket thread fire_rocket(dest_point);

    wait(RandomFloatRange(0.2, 0.25));
  }
}
fire_rocket(target_pos) {
  start_pos = self.origin;

  gravity = GetDvarInt("g_gravity") * -1;

  dist = Distance(start_pos, target_pos);

  time = dist / 2000;

  delta = target_pos - start_pos;

  drop = 0.5 * gravity * (time * time);

  velocity = ((delta[0] / time), (delta[1] / time), (delta[2] - drop) / time);

  self MoveGravity(velocity, time);
  wait(time);

  self hide();
  self stoploopsound(.1);

  playFX(level._effect["katyusha_rocket_explosion"], self.origin);
  radiusdamage(self.origin, 128, 300, 35);
  earthquake(0.3, 2, self.origin, 1024);

  wait .2;

  self Delete();
}