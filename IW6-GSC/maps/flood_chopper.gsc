/*****************************************************
 * Decompiled and Edited by SyndiShanX
 * Script: maps\flood_chopper.gsc
*****************************************************/

section_

section_precache() {
  precacheshader("hint_mantle");
}

section_flag_inits() {
  common_scripts\utility::flag_init("player_jumped");
}

chopper_start() {
  maps\flood_util::player_move_to_checkpoint_start("chopper_start");
  maps\flood_util::spawn_allies();
}

chopper() {}

breach_heli_door() {
  var_0 = getent("kick_door_trigger", "targetname");
  var_0 sethintstring(&"SCRIPT_PLATFORM_BREACH_ACTIVATE");
  var_0 usetriggerrequirelookat();
  var_0 waittill("trigger");
  var_0 common_scripts\utility::trigger_off();
  level thread breach_door("anim_node_breach_door", ::open_church_doors, ::church_weapon_pullout);
  maps\flood_util::hide_scriptmodel_by_targetname("embassy_door_collision");
}

breach_door(var_0, var_1, var_2) {
  level.player disableweapons();
  level.player allowcrouch(0);
  level.player allowprone(0);
  level.player allowsprint(0);
  level.player allowjump(0);
  level.breach_player_rig = maps\_utility::spawn_anim_model("breach_player_rig");
  level.breach_player_legs = maps\_utility::spawn_anim_model("breach_player_legs");
  var_3 = [];
  var_3["breach_player_rig"] = level.breach_player_rig;
  var_3["breach_player_legs"] = level.breach_player_legs;
  var_4 = "lowtech_breach";
  level.player playerlinktoblend(level.breach_player_rig, "tag_player", 0.2, 0.1, 0.1);
  var_5 = common_scripts\utility::getstruct(var_0, "targetname");
  var_5 thread maps\_anim::anim_single(var_3, var_4);
  var_5 waittill(var_4);
  level.player unlink();
  level.player allowcrouch(1);
  level.player allowprone(1);
  level.player allowsprint(1);
  level.player allowjump(1);
  level.breach_player_rig delete();
  level.breach_player_legs delete();
}

open_church_doors(var_0) {
  var_1 = getent("embassy_door_main_left", "targetname");
  var_2 = getent("embassy_door_main_right", "targetname");
  var_1 rotateyaw(90, 0.2, 0.1, 0.1);
  var_2 rotateyaw(-90, 0.2, 0.1, 0.1);
  var_3 = getent("embassy_door_collision", "targetname");
  var_3 connectpaths();
  common_scripts\utility::flag_set("vignette_heli_crash");
}

church_weapon_pullout(var_0) {
  level.player enableweapons();
  var_1 = 180;
  level.player playerlinktodelta(level.breach_player_rig, "tag_player", 0.5, var_1, var_1, var_1, var_1, 1);
}

helicopter_jump() {
  level endon("heli_got_away");
  level endon("rorke_heli_end");
  end_jump();
  common_scripts\utility::flag_set("player_jumped");
  level notify("player_jumped_to_heli");
  level.player disableweapons();
}

end_jump() {
  level endon("heli_got_away");
  level endon("rorke_heli_end");
  var_0 = getent("trig_heli_jump", "targetname");
  notifyoncommand("jump", "+gostand");
  notifyoncommand("jump", "+moveup");
  var_0 thread end_jump_mantle();
  var_0 waittill("trigger");

  for(;;) {
    level.player waittill("jump");

    if(level.player istouching(var_0) && level.player getstance() == "stand" && end_mantle_angle()) {
      break;
    }
  }

  level.hud_mantle["text"].alpha = 0;
  level.hud_mantle["icon"].alpha = 0;
}

end_mantle_angle() {
  level endon("heli_got_away");
  level endon("rorke_heli_end");
  var_0 = level.player getplayerangles();
  var_1 = anglesToForward(var_0);
  var_2 = vectornormalize(level.rorke_heli.origin - level.player.origin);

  if(vectordot(var_1, var_2) > 0.75) {
    return 1;
  } else {
    return 0;
  }
}

end_jump_mantle() {
  level endon("end_start_player_anim");
  level endon("end_seaknight_leaving");
  level endon("heli_got_away");
  level endon("rorke_heli_end");

  for(;;) {
    self waittill("trigger");

    if(end_mantle_angle()) {
      level.hud_mantle["text"].alpha = 1;
    }

    level.hud_mantle["icon"].alpha = 1;

    while(level.player istouching(self) && end_mantle_angle()) {
      wait 0.05;
    }

    level.hud_mantle["text"].alpha = 0;
    level.hud_mantle["icon"].alpha = 0;
  }
}

end_nojump() {
  level endon("heli_got_away");
  level endon("rorke_heli_end");
  var_0 = getent("trig_heli_nojump", "targetname");

  for(;;) {
    var_0 waittill("trigger");
    common_scripts\utility::flag_set("end_no_jump");
    level.player allowjump(0);

    while(level.player istouching(var_0)) {
      wait 0.05;
    }

    level.player allowjump(1);
  }
}

helicopter_fail() {
  level endon("player_jumped");
  level waittill("heli_got_away");
  setdvar("ui_deadquote", &"FLOOD_HELICOPTER_ESCAPED");
  thread maps\_utility::missionfailedwrapper();
}