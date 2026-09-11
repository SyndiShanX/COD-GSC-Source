/**********************************************************
 * Decompiled by ATE47 and Edited by SyndiShanX
 * Script: scripts\sp\maps\hometown\hometown_lighting.gsc
**********************************************************/

function main() {
  scripts\engine\sp\utility::post_load_precache(&post_load);
  thread lighting_flags();
  level.sunangles = getmapsunangles();
  level.buriedsunangles = (-35.6, -94.97, 0);
  thread lighting_buried_start();
  thread lighting_carried_start();
  thread lighting_alley_gas_attack_start();
  thread lighting_house_enter_start();
  thread lighting_house_character();
  thread lighting_house_exit_character();
  thread lighting_gas_progression();
  thread lighting_gas_start();
  thread lighting_poppies_drive_start();
  thread lighting_pistol_start();
  thread lighting_bunker_start();
  thread hide_gas_shack_window_shadow_brush();
}

function lighting_flags() {
  scripts\engine\utility::flag_init("lighting_buried_start");
  scripts\engine\utility::flag_init("lt_buried");
  scripts\engine\utility::flag_init("lighting_buried_mom");
  scripts\engine\utility::flag_init("lighting_carried_start");
  scripts\engine\utility::flag_init("lighting_move_rubble");
  scripts\engine\utility::flag_init("lighting_pickup_tile");
  scripts\engine\utility::flag_init("lighting_unburied");
  scripts\engine\utility::flag_init("lighting_liftout");
  scripts\engine\utility::flag_init("lighting_alley_start");
  scripts\engine\utility::flag_init("lighting_alley_progression");
  scripts\engine\utility::flag_init("lighting_gas_attack_start");
  scripts\engine\utility::flag_init("lighting_house_enter_start");
  scripts\engine\utility::flag_init("lighting_house_enter_progression");
  scripts\engine\utility::flag_init("lighting_cellphone_moment");
  scripts\engine\utility::flag_init("lighting_house_boss_start");
  scripts\engine\utility::flag_init("objective_leave_the_house");
  scripts\engine\utility::flag_init("lighting_make_on");
  scripts\engine\utility::flag_init("lighting_house_exit_start");
  scripts\engine\utility::flag_init("lighting_gas_start");
  scripts\engine\utility::flag_init("lighting_gas_progression");
  scripts\engine\utility::flag_init("lighting_gas_mid_start");
  scripts\engine\utility::flag_init("lighting_gas_exit_start");
  scripts\engine\utility::flag_init("lighting_poppies_start");
  scripts\engine\utility::flag_init("lighting_poppies_progression");
  scripts\engine\utility::flag_init("lighting_pistol_start");
  scripts\engine\utility::flag_init("lighting_pistol_progression");
  scripts\engine\utility::flag_init("lighting_drive_start");
  scripts\engine\utility::flag_init("lighting_bunker_start");
  scripts\engine\utility::flag_init("lighting_bunker_exit");
}

function post_load() {
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
  lighting_setup_dvars();
}

function lighting_setup_dvars() {
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("LMPKPQPRMK", 72.4139);
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
  setsaveddvar("LTQMSPKRKO", 8);
  setsaveddvar("LKOLRONRNQ", 500);
  setsaveddvar("MROOOROPKL", 10);
}

function hide_gas_shack_window_shadow_brush() {
  var0 = getEntArray("bake_shadow_array_brush", "targetname");

  foreach(var2 in var0) {
    var2 delete();
  }
}

function lighting_buried_start() {
  scripts\engine\utility::flag_wait("lighting_buried_start");
  thread lighting_buried_carried_common();
  level.player setphysicaldepthoffield(1.4, 2);
  scripts\engine\utility::flag_set("lt_buried");
  wait 3;
  level.player setphysicaldepthoffield(3, 23, 0.6, 0.6);
  scripts\engine\utility::flag_wait("lighting_buried_mom");
  thread fade_up_light_buried_mom();
  scripts\engine\utility::flag_clear("lt_buried");
  level.player setphysicaldepthoffield(3, 32);
  thread rack_focus_between_tile_and_mom();
  scripts\engine\utility::flag_wait("lighting_pickup_tile");
  level notify("picked_up_tile");
  level.player setphysicaldepthoffield(2.8, 11);
  wait 7;
  level.player setphysicaldepthoffield(2.8, 20.3);
  scripts\engine\utility::flag_clear("lt_buried");
  level.light_buried_mom setlightintensity(0);
}

function rack_focus_between_tile_and_mom() {
  level endon("picked_up_tile");

  for(;;) {
    if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.farah_mother_model gettagorigin("j_head"), cos(20))) {
      level.player setphysicaldepthoffield(3, 32);
    } else if(scripts\engine\utility::within_fov(level.player getEye(), level.player getplayerangles(), level.buried_rebar_model gettagorigin("me_rubble_chunk_farah_buried"), cos(35))) {
      level.player setphysicaldepthoffield(2.8, 11);
    } else {
      level.player setphysicaldepthoffield(4, 15);
    }

    wait 1;
  }
}

function fade_up_light_buried_mom() {
  var0 = 0.3;
  var1 = 1;
  level.light_buried_mom = getEnt("lt_buried_mom", "targetname");
  level.light_buried_mom setlightintensity(0);
  thread lerp_value_light_buried_mom(level.light_buried_mom, 0, var0);
}

function lerp_value_light_buried_mom(var0, var1, var2) {
  var3 = var1 - var0;
  var4 = 0.3;
  var5 = int(var2 / var4);

  if(var5 > 0) {
    var6 = var3 / var5;

    while(var5) {
      var0 += var6;
      level.light_buried_mom setlightintensity(var0);
      wait var4;
      var5--;
    }

    return;
  }
}

function lighting_carried_start() {
  scripts\engine\utility::flag_wait_any("lighting_carried_start", "lighting_move_rubble");
  thread lighting_buried_carried_common();
  scripts\engine\utility::flag_clear("lt_buried");

  if(isDefined(level.light_buried_mom)) {
    level.light_buried_mom setlightintensity(0);
  }

  level.player setphysicaldepthoffield(1.4, 50, 0.1, 0.1);
  wait 0.5;
  visionsetnaked("hometown_buried_uncovered", 0.2);
  wait 1;
  var0 = getEnt("runtime_shadow_brush_metal", "targetname");
  var0 hide();
  visionsetnaked("hometown_buried", 3);
  wait 12;
  var1 = getEnt("lt_buried_hand", "targetname");
  var1 setlightintensity(12);
  var2 = getEnt("lt_whitehelmet", "targetname");
  var2 setlightintensity(2.8);
  scripts\engine\utility::flag_wait("lighting_unburied");
  level.player setphysicaldepthoffield(2.8, 25);
  scripts\engine\utility::flag_wait("lighting_liftout");
  scripts\engine\utility::delaythread(0, &lerp_sun_and_vision);
  level.player setphysicaldepthoffield(2.8, 15);
  wait 1;
  level.player setphysicaldepthoffield(2.8, 9, 1, 2);
  var1 setlightintensity(0);
  wait 1.5;
  var2 setlightintensity(0);
  wait 3;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(7, 9, undefined);
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
  scripts\engine\utility::delaythread(29, &carried_dof);
  wait 4;
  visionsetnaked("", 2);
  level waittill("buried_explosion1");
  wait 2;
  visionsetnaked("hometown_explosion", 4);
}

function lighting_buried_carried_common() {
  level.player enablephysicaldepthoffieldscripting();
  visionsetnaked("hometown_buried", 0);
  lerpsunangles(level.sunangles, level.buriedsunangles, 0.01);
  setsaveddvar("NPONLLLSPL", 0.05);
  wait 2;
  setsaveddvar("MPOKKOPMTN", "32 384 640 1024");
  setsaveddvar("LRLKLRNRTS", "8 -0.5 1 0");
}

function lerp_sun_and_vision() {
  var0 = 5;
  lerpsunangles(level.buriedsunangles, level.sunangles, var0, var0 * 0.25, var0 * 0.75);
  visionsetnaked("hometown_eye_dim", var0);
  setsaveddvar("NPONLLLSPL", 0.15);
  setsaveddvar("LSNRQTOKRR", 2);
}

function carried_dof() {
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
  waitframe();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(2.2, 500);
  wait 10;
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LSNRQTOKRR", 3);
  level thread scripts\engine\sp\utility::dof_enable_autofocus(5.6, 10, undefined);
  wait 0.5;
  level.dadchildangles = (-48, -28, 0);
  lerpsunangles(level.sunangles, level.dadchildangles, 1, 0.25, 0.25);
  wait 25.5;
  visionsetnaked("", 3);
  lerpsunangles(level.dadchildangles, level.sunangles, 2, 0.25, 0.25);
  wait 2.1;
  resetsundirection();
}

function lighting_alley_gas_attack_start() {
  scripts\engine\utility::flag_wait_any("lighting_alley_start", "lighting_alley_progression", "lighting_gas_attack_start");
  level thread scripts\engine\sp\utility::dof_enable_autofocus(8, 4, undefined);
  setsaveddvar("NPONLLLSPL", 0.25);
  setsaveddvar("LSNRQTOKRR", 3);
  setsaveddvar("LRLKLRNRTS", "8 0 1 0");
  var0 = getEntArray("shadow_array_brush_house", "targetname");

  foreach(var2 in var0) {
    var2 hide();
  }
}

function lighting_house_enter_start() {
  scripts\engine\utility::flag_wait_any("lighting_house_enter_start", "lighting_house_boss_start", "lighting_house_exit_start", "lighting_house_enter_progression");
  level.house_fstop = 12;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(level.house_fstop, 5, undefined);
  setsaveddvar("NPONLLLSPL", 0.22);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("NTLKNLNPLK", 2);
  setsaveddvar("MPOKKOPMTN", "64 128 256 512");
  setsaveddvar("TLMMOPMSK", 1);
  wait 2;
  var0 = getEntArray("shadow_array_brush_house", "targetname");

  foreach(var2 in var0) {
    var2 show();
  }

  scripts\engine\utility::flag_wait("lighting_cellphone_moment");
  setsaveddvar("SLSMSSTQP", "1");
  level.house_intro_phone_farah_model thread scripts\engine\sp\utility::dof_enable_autofocus(6, 40, undefined, undefined, "tag_phone_fx");
  wait 4.5;
  level thread scripts\engine\sp\utility::dof_enable_autofocus(level.house_fstop, 5, undefined);
  setsaveddvar("SLSMSSTQP", "9");
  scripts\engine\utility::flag_wait("player_went_to_foyer");

  while(!isDefined(level.hadir_body_model)) {
    waitframe();
  }

  level.hadir_body_model thread scripts\engine\sp\utility::dof_enable_autofocus(1.8, 5, undefined, undefined, "j_head");
  wait 17;
  scripts\engine\sp\utility::motion_blur_enable(2, 1);
  level thread scripts\engine\sp\utility::dof_enable_autofocus(level.house_fstop, 5, undefined);
  scripts\engine\utility::flag_wait("objective_find_a_weapon");
  scripts\engine\sp\utility::motion_blur_enable(1, 1);
}

function lighting_house_character() {
  scripts\engine\utility::flag_wait("lighting_house_enter_progression");
  var0 = getEnt("lt_house_1", "targetname");
  wait 4.3;
  var0 setlightintensity(0.09);
  wait 8;
  var0 setlightintensity(0);
  scripts\engine\utility::flag_wait("lighting_cellphone_moment");
  wait 10;
  var1 = getEnt("lt_house_2", "targetname");
  var1 setlightintensity(0.2);
  level waittill("dad_dies_start");
  wait 29;
  var1 setlightintensity(0);
  scripts\engine\utility::flag_wait("lantern_break");
  wait 9;
  var1 setlightintensity(0.2);
  scripts\engine\utility::flag_wait("objective_find_a_weapon");
  var1 setlightintensity(0);
  wait 2;
  var0 setlightintensity(0.08);
}

function lighting_house_exit_character() {
  scripts\engine\utility::flag_wait("objective_leave_the_house");
  var0 = getEnt("lt_father_died", "targetname");
  var0 setlightintensity(0.07);
  scripts\engine\utility::flag_wait("lighting_make_on");
  var1 = getEnt("lt_hadir_mask", "targetname");
  var1 setlightintensity(0.2);
  scripts\engine\utility::flag_wait("lighting_gas_progression");
  var0 setlightintensity(0);
  var1 setlightintensity(0);
}

function lighting_gas_progression() {
  scripts\engine\utility::flag_wait("lighting_gas_progression");
  var0 = getEntArray("shadow_array_brush_house", "targetname");

  foreach(var2 in var0) {
    var2 hide();
  }

  setsaveddvar("NPONLLLSPL", 0.5);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("LMPKPQPRMK", 36, 2);
  visionsetnaked("hometown_gas_close", 2);
  setsaveddvar("MPOKKOPMTN", "128 384 640 1024");
  wait 2.5;
  visionsetnaked("", 0);
  waitframe();
  visionsetalternate(1, 0);
}

function lighting_gas_start() {
  scripts\engine\utility::flag_wait_any("lighting_gas_start", "lighting_gas_mid_start", "lighting_gas_exit_start");
  setsaveddvar("NPONLLLSPL", 0.5);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("LMPKPQPRMK", 36, 0);
  scripts\engine\utility::flag_wait_any("lighting_gas_progression", "lighting_gas_start", "lighting_gas_mid_start", "lighting_gas_exit_start");
  var0 = getEntArray("shadow_array_brush_house", "targetname");

  foreach(var2 in var0) {
    var2 hide();
  }

  level thread scripts\engine\sp\utility::dof_enable_autofocus(3.2, 4, undefined, undefined, undefined, [level.player, level.alley_grab_guy_model]);
  waitframe();
  visionsetalternate(1, 0.5);
  scripts\engine\utility::flag_wait("town_exit_alley_mid_flag");
  setsaveddvar("LSNRQTOKRR", 2);
}

function lighting_poppies_drive_start() {
  scripts\engine\utility::flag_wait_any("lighting_poppies_start", "lighting_drive_start");
  visionsetnaked("hometown_poppy_reveal", 0);
  setsaveddvar("LSNRQTOKRR", 2);
  setsaveddvar("LRLKLRNRTS", "8 -0.5 1 0");
  scripts\engine\utility::flag_wait_any("lighting_poppies_start", "lighting_poppies_progression", "lighting_drive_start");
  setsaveddvar("LMPKPQPRMK", 72.4139, 1);
  level thread scripts\engine\sp\utility::dof_disable_autofocus();
  waitframe();
  level.player enablephysicaldepthoffieldscripting();
  level.player setphysicaldepthoffield(12, 4000);
}

function lighting_pistol_start() {
  scripts\engine\utility::flag_wait_any("lighting_pistol_start", "lighting_pistol_progression");
  visionsetnaked("hometown_poppy_reveal", 0);
  setsaveddvar("LRLKLRNRTS", "8 -0.5 1 0");
  level.hadir_ai thread scripts\engine\sp\utility::dof_enable_autofocus(6, 5, undefined, undefined, "j_neck");
  scripts\engine\utility::flag_wait("lighting_cellphone_moment");
  scripts\engine\sp\utility::dof_enable(5, 10.5, 10, 10, undefined, undefined);
  wait 2.5;
  level.player setphysicaldepthoffield(12, 4000);
}

function lighting_bunker_start() {
  scripts\engine\utility::flag_wait("lighting_bunker_start");
  setsaveddvar("OMKTSMSOS", 0);
  visionsetnaked("hometown_bunker", 0);
  scripts\engine\utility::flag_wait("lighting_bunker_exit");
  wait 18.5;
  visionsetnaked("hometown_bunker_ext", 2);
}