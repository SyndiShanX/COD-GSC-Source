/**************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\_see2_panzeriv.gsc
**************************************/

#include maps\_vehicle_aianim;
#include maps\_vehicle;

main(model, type) {
  build_template("see2_panzeriv", model, type);
  build_localinit(::init_local);
  build_deathmodel("vehicle_ger_tracked_panzer4", "vehicle_ger_tracked_panzer4_d");
  build_deathmodel("vehicle_ger_tracked_panzer4v1", "vehicle_ger_tracked_panzer4_d_base");
  build_deathmodel("vehicle_ger_tracked_panzer4_winter", "vehicle_ger_tracked_panzer4_d");
  build_shoot_shock("tankblast");
  build_exhaust("vehicle/exhaust/fx_exhaust_panzerIV");
  build_deathfx("vehicle/vexplosion/fx_vexplode_ger_panzer", "tag_origin", "explo_metal_rand");
  build_deathfx("vehicle/vfire/fx_vfire_ger_panzer", "tag_origin", undefined);
  build_deathfx("vehicle/vfire/fx_vsmoke_ger_panzer", "tag_origin", undefined);
  build_deathquake(0.7, 1.0, 600);
  build_treadfx();
  build_life(500, 499, 500);
  build_rumble("tank_rumble", 0.15, 4.5, 600, 1, 1);
  build_team("axis");
  build_mainturret();
  build_compassicon();
  build_aianims(::setanims, ::set_vehicle_anims);
}
init_local() {}

keep_track_of_guys_hitting_me() {
  self endon("death");
  self.hit_by_player_array = [];

  self.hit_by_player_array[0] = false;
  self.hit_by_player_array[1] = false;
  self.hit_by_player_array[2] = false;
  self.hit_by_player_array[3] = false;

  player_hit_me = undefined;

  while(1) {
    self waittill("damage", amount, attacker);

    self.last_thing_to_hit_me = attacker;

    if(isPlayer(attacker)) {
      player_hit_me = attacker;
    } else if(isDefined(attacker.classname) && attacker.classname == "script_vehicle") {
      veh_owner = attacker GetVehicleOwner();

      if(isDefined(veh_owner) && isPlayer(veh_owner)) {
        player_hit_me = attacker;
      }
    }

    if(isDefined(player_hit_me)) {
      players = maps\_utility::get_players();
      for(i = 0; i < players.size; i++) {
        if(players[i] == player_hit_me) {
          self.hit_by_player_array[i] = true;
        }
      }

      player_hit_me = undefined;
    }
  }
}

reward_assist_points() {
  self waittill("death");

  players = maps\_utility::get_players();

  for(i = 0; i < players.size; i++) {
    if(self.hit_by_player_array[i] && self.last_thing_to_hit_me != players[i]) {
      maps\_utility::arcademode_assignpoints("arcademode_score_bombplant", players[i]);
    }
  }
}
#using_animtree("tank");
set_vehicle_anims(positions) {
  return positions;
}
#using_animtree("generic_human");
setanims() {
  positions = [];
  for(i = 0; i < 10; i++) {
    positions[i] = spawnStruct();
  }

  positions[0].sittag = "tag_guy1";
  positions[1].sittag = "tag_guy2";
  positions[2].sittag = "tag_guy3";
  positions[3].sittag = "tag_guy4";
  positions[4].sittag = "tag_guy5";
  positions[5].sittag = "tag_guy6";
  positions[6].sittag = "tag_guy7";
  positions[7].sittag = "tag_guy8";
  positions[8].sittag = "tag_guy9";
  positions[9].sittag = "tag_guy10";
  return positions;
}